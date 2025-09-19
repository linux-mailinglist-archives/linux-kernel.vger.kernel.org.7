Return-Path: <linux-kernel+bounces-824743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 235D0B8A0F7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9413E5862BC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1572A258ED6;
	Fri, 19 Sep 2025 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="am6klZks"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AB824DCEB
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293166; cv=none; b=nHx/LdJTCPggpS2D+zDDswJRfr4tdxUjubpFLAyaXSjFZcmE4024cYXarbUqU0BGycR8dlGJAB0NEWjOKbyLtQZoSpQ/GNXMwIkGCgFE35NjT4fa0ECsxqfU4mrSX6Wd4bge13r/t4rKkFJjCTUrwasQAwgwna6zYMoygWH4VfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293166; c=relaxed/simple;
	bh=2MTK23vuo2CKjb7oozhaqOgEaFFuCN+amqxDrseDFbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIhqq6BqR96/8UN9X97LZftXueNZL5d1L4AfP/qSM3XSvoz2bCXh1fW1I9t/tG01qWn94M6W7W5oBJ0MQYbEPTHOC9oUH1cEBTPl3b57p/v5M47aqhrr2TFuMc03sfXnDVzjcAZdA9iG+QqR1YE2o6rzBIVHCLZgakxgvRlVs7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=am6klZks; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-47.bstnma.fios.verizon.net [173.48.111.47])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58JEjmDl025285
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 10:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758293151; bh=/uU8JB3lnEDct4CiuBwq0NtIG+7u6ORH4LbnEydmI40=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=am6klZksCSxOzCs/veCZ/BQm0/jo0WROhYwaT6NRgzX5LZU7Cef3Du4mTB0rNjRH2
	 R47QqL2GjGtFtTRPH6CpxTW0UxgrA5KLOeulsRC8cU8KV+vwZLofZJEmJ2gB3yAjM7
	 YtiPbxM4Vyp/3e0hrtNpb03mAkQ0gTzA4s1NzAzO1LMIqsxzc/Cw0XCEMhtoCsS3BE
	 F/oTIm8kt9Hkrvj3wjinjojGkLu3960904WypXyImOwv0hwCIx0UJXkAguQqjLvzKn
	 xCMv1zPKbgCyx4ajH+VDPR56iaLBNC9zuWniZlpkuYcyTFsbnM3JHgDQltHwWKhf55
	 UlxtEZVL5c0WA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 7F06E2E00D9; Fri, 19 Sep 2025 10:45:48 -0400 (EDT)
Date: Fri, 19 Sep 2025 10:45:48 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Ahmet Eray Karadag <eraykrdg1@gmail.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: Re: [PATCH] Fix: ext4: guard against EA inode refcount underflow in
 xattr update
Message-ID: <20250919144548.GE416742@mit.edu>
References: <20250918175545.48297-1-eraykrdg1@gmail.com>
 <20250918181801.GI8084@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918181801.GI8084@frogsfrogsfrogs>

On Thu, Sep 18, 2025 at 11:18:01AM -0700, Darrick J. Wong wrote:
> > diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> > index 5a6fe1513fd2..a056f98579c3 100644
> > --- a/fs/ext4/xattr.c
> > +++ b/fs/ext4/xattr.c
> > @@ -1030,6 +1030,13 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
> >  
> >  	ref_count = ext4_xattr_inode_get_ref(ea_inode);
> >  	ref_count += ref_change;
> > +	if (ref_count < 0) {
> 
> Shouldn't this check ref_count >= ref_change *before* updating it?

As Ahmet pointed out, so long as we don't actually update the on-disk
data structure, it's fine.  The issue I'm more concerned about is that
if ref_change is +1, we could also have an overflow where we go from
an ridiculously large positive number (~0) to 0.

Your change might fix one potential syzbot-discovered issue caused by
a maliciously fuzzed file system, but we should harden it against
similar problems going in the opposite problem.

Cheers,

						- Ted

