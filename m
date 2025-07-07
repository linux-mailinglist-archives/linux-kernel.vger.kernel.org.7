Return-Path: <linux-kernel+bounces-719831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A726AFB339
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 14:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F933BA670
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 12:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E0629ACFA;
	Mon,  7 Jul 2025 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KlSRREA3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBF529AB1B
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751891228; cv=none; b=WUY/F5YzgUrZM3VtN8dh2I02rhckU0wYVHwME3Jntow9WZQD9gUi13CA2kmvuelvIvzOc0mLmLLHIHshvbLg1Ngw9FpzZfR3xlt4mnTTA/K8s9LoJ1S7OaTCplmI3p1WIR35gogREmVu1MXyQYqed83jFdRCAnweuytNNW1REcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751891228; c=relaxed/simple;
	bh=N6aIrao9mvKWLRzYYG6kmQNDgyAReKkf4PPJ58kKg+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipXL4DRAzrgc8aqcUyotTMOfNkCJXVB0zS2EC66CRv0MB62TxwZUo+XUsRPpE2ajEbLzO2x4cdnEL74O6bemApxe3uB/secpmuPytKPZjb07jn41l8op2VCeQfbDHe284NPx/VMfaWjdM2PbNvlfG82FeYZ9u7FO6ssoeFeXLMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KlSRREA3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751891226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KHTeRzC+GAtalyuC61VSTswPDreUYA10fT25p2FdvD8=;
	b=KlSRREA3mdcZQyDNV34Rxy4b4/oEp2sijAIX6w8RkIHbQ+2CvGZPChhXrtwjcfxDgr8gkE
	bcXomHnj/Itag6mNthOpVASk/+Qq8OFTo4uvenSK1tXmk3kJy+OxMJvF9r1HRhnmlHvGWY
	AsuCqZSPNoWJdisdhS0BafqOpYeal8g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-jUSYXDRlOUW4EfRnlb4HOA-1; Mon, 07 Jul 2025 08:27:05 -0400
X-MC-Unique: jUSYXDRlOUW4EfRnlb4HOA-1
X-Mimecast-MFC-AGG-ID: jUSYXDRlOUW4EfRnlb4HOA_1751891223
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ae0cd07eeb2so267205266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 05:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751891223; x=1752496023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHTeRzC+GAtalyuC61VSTswPDreUYA10fT25p2FdvD8=;
        b=kjFWO7MxgEjYngmSYupikMD4bOgtsmUl2fIaXts9ktEg8thYlsbwGpqVtvvPjRA3ze
         48wIuQjMzpC82/NY9gU4kgz5Y9+OqUTPwHPINBHZFfQPgaATIirNqMWgdt0UP2Q6bRw9
         UDNmSBittMVEPdmsE1ifBGx0+OJxjNWINYlSLCc7yxVOisawkVg5CxIWPus0pE9VZ0Lo
         YcG7IFk+Edp3+IsAH6Pw30hYxirBZPC8OZnpocS/nI+AFRYPCW8e4LEJRV/XrW3rHonQ
         UU+Bd/SrAL37aLEY6C6jK+PGY1xYqjlvBjewMUDxPAgL1dxtMqcwpG2IJOoL1qquNvXz
         oNQg==
X-Forwarded-Encrypted: i=1; AJvYcCU5FsEHzorjIQGSoTIKU9plImQxcjKOwInDd0bRFPQkAsIsmiFncLmdLVnX6IuEfS4IaBtbJEry92FeFVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3RdX6hb1Wb2qhX9BBBlVodWZBXSImUYo4ngMq5zO93yC2Eni5
	Sia/xJGW+FzVis4e0zGzX63TL4EuctTCNSwWTGAmuHCHwS/XhI5vKh976CfZdX6chq6Orji2EL/
	2SAWrvac/fvlQtFMVoGmmI1yKpXQldA7Y6WaPZfuedVhSjJ2RLBH68MwyT9kyun+z
X-Gm-Gg: ASbGncsO0jqbI1bfwRtrmbBmVZw/ZpXJ8r7XgclwKXQI/bv4mmt5bzuqYWcN1RDtN3d
	r4xC7A9Vf3ngrFVh93BXvz3KcyDtaKhA83SmdbMNYYoXdU8sXnyw5N43sS9umbHDcND5/1iS5yA
	z6Rw7s0mdJkMfqGv2Z2xSuZSOhN97VmG3XZAVCYM4P3duYHc581glo2e+Imf4ofzKsiNnPri/fE
	YWn20PR83CW34gZ+O1m6HABkhwBML5gVEHC6724FwgahL80rha4+KkTQvkID8DYefCMA6aLl9Nk
	Nn3NcNUVghfNeT/uBb1DijHj7oi4jKfEpn28IRVPPw==
X-Received: by 2002:a17:907:1b1c:b0:ae0:d903:2bc1 with SMTP id a640c23a62f3a-ae3fbe32085mr1269373166b.49.1751891222545;
        Mon, 07 Jul 2025 05:27:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+xNnEev9UxKSf7lcc6f2ZhivCo6t8UkYaBDX83sSiieaUIILsbAVwreWk30jTRbKc3uqazw==
X-Received: by 2002:a17:907:1b1c:b0:ae0:d903:2bc1 with SMTP id a640c23a62f3a-ae3fbe32085mr1269369466b.49.1751891222070;
        Mon, 07 Jul 2025 05:27:02 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d9263sm700724366b.32.2025.07.07.05.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 05:27:01 -0700 (PDT)
Date: Mon, 7 Jul 2025 14:27:00 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Jan Kara <jack@suse.cz>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 0/6] fs: introduce file_getattr and file_setattr
 syscalls
Message-ID: <rckjqvax4ciazuasmpiiflk6qgwnkfrcamw6xae4mvtofo3yxk@jj25of6o5ye2>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250701-quittung-garnieren-ceaf58dcb762@brauner>
 <uzx3pdg2hz44n7qej5rlxejdmb25jny6tbv43as7dos4dit5nv@fyyvminolae6>
 <20250707-alben-kaffee-da62c14bb5c3@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-alben-kaffee-da62c14bb5c3@brauner>

On 2025-07-07 14:19:25, Christian Brauner wrote:
> On Mon, Jul 07, 2025 at 02:05:10PM +0200, Andrey Albershteyn wrote:
> > On 2025-07-01 14:29:42, Christian Brauner wrote:
> > > On Mon, Jun 30, 2025 at 06:20:10PM +0200, Andrey Albershteyn wrote:
> > > > This patchset introduced two new syscalls file_getattr() and
> > > > file_setattr(). These syscalls are similar to FS_IOC_FSSETXATTR ioctl()
> > > > except they use *at() semantics. Therefore, there's no need to open the
> > > > file to get a fd.
> > > > 
> > > > These syscalls allow userspace to set filesystem inode attributes on
> > > > special files. One of the usage examples is XFS quota projects.
> > > > 
> > > > XFS has project quotas which could be attached to a directory. All
> > > > new inodes in these directories inherit project ID set on parent
> > > > directory.
> > > > 
> > > > The project is created from userspace by opening and calling
> > > > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > > > files such as FIFO, SOCK, BLK etc. Therefore, some inodes are left
> > > > with empty project ID. Those inodes then are not shown in the quota
> > > > accounting but still exist in the directory. This is not critical but in
> > > > the case when special files are created in the directory with already
> > > > existing project quota, these new inodes inherit extended attributes.
> > > > This creates a mix of special files with and without attributes.
> > > > Moreover, special files with attributes don't have a possibility to
> > > > become clear or change the attributes. This, in turn, prevents userspace
> > > > from re-creating quota project on these existing files.
> > > 
> > > Only small nits I'm going to comment on that I can fix myself.
> > > Otherwise looks great.
> > > 
> > 
> > Hi Christian,
> > 
> > Let me know if you would like a new revision with all the comments
> > included (and your patch on file_kattr rename) or you good with
> > applying them while commit
> 
> It's all been in -next for a few days already. :)
> 

Oh sorry, missed that, thanks!

-- 
- Andrey


