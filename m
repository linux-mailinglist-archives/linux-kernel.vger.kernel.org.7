Return-Path: <linux-kernel+bounces-653973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E25ABC183
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 17:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776FD1B6328C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 15:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7247E283FEE;
	Mon, 19 May 2025 15:00:01 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF59284B3A
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747666801; cv=none; b=pUac7HfptCZJR8W7YRVcQjkWQckYk5LCUj0axYuLXeIi4En5/fdgMPHLxBI9Qp+B7pxDXOaQZy9eWlVTKIzjx5KQetE8trIfT876jgDMDhGAC/G3XwaLTw2bh7Xa1ETcLa8WaZjbeuCIjUJuqTWdf0MjTgBgW5mc5traYjXrVZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747666801; c=relaxed/simple;
	bh=W2vxPFvtMSGFDX01i+sEwTDfFarvJeP/3Ri9KeQvVsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4FaPyXvY8mJ6lOo0ea3rNqVNFfyk+c19eeVTjAHrESI3OcB8uis4tsPEZllmtAhv5zq6+4IufxO0b+Y0NylJSPgq+32yjXzJXVzmtfvIRorLK0jZPDqXiEcuoEsOb5in65NOP4TFxTcmP5fqjdGCMSF9ETC1KFdKLEX1O/kH1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54JExUl7002060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 10:59:31 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 74B8E2E00DD; Mon, 19 May 2025 10:59:30 -0400 (EDT)
Date: Mon, 19 May 2025 10:59:30 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kees Cook <kees@kernel.org>
Cc: Ethan Carter Edwards <ethan@ethancedwards.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] ext4: replace strcpy() with '.' assignment
Message-ID: <20250519145930.GB38098@mit.edu>
References: <20250518-ext4-strcpy-v2-1-80d316325046@ethancedwards.com>
 <202505190651.943F729@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505190651.943F729@keescook>

On Mon, May 19, 2025 at 06:52:13AM -0700, Kees Cook wrote:
> > --- a/fs/ext4/inline.c
> > +++ b/fs/ext4/inline.c
> > @@ -1314,7 +1314,7 @@ int ext4_inlinedir_to_tree(struct file *dir_file,
> >  		if (pos == 0) {
> >  			fake.inode = cpu_to_le32(inode->i_ino);
> >  			fake.name_len = 1;
> > -			strcpy(fake.name, ".");
> > +			fake.name[0] = ".";
> 
> This means the trailing NUL byte isn't being copied any more? That seems
> like a big change, even if name_len is being used for length tracking.

Yeah, and so that's something that needs to be tested (and not just
build tested to catch the obvious FTBFS bug).  However, note how we
handle normal filenames, as opposed to "." and "..".  From
ext4_insert_dentry():

	de->inode = cpu_to_le32(inode->i_ino);
	ext4_set_de_type(inode->i_sb, de, inode->i_mode);
	de->name_len = fname_len(fname);
	memcpy(de->name, fname_name(fname), fname_len(fname));

Or were you commenting on the "no functional changes intended" line in
the commit description?  I agree that this is probably no longer
accurate.  :-)

					- Ted

