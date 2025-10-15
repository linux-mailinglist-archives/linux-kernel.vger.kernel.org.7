Return-Path: <linux-kernel+bounces-855200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B57BE080A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16841A235DD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E6F288522;
	Wed, 15 Oct 2025 19:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzpSiete"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC932D3ECA
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557450; cv=none; b=ZVNInX7p8+rJotOxU798yHgphVMov1B5nOll0gb2stVkZGbo9hOXXU/pEOx0nZfJfr5fFyY2lvQwVPJDSvrvvmjSjGzUW6Ij+tsZus4zoOD/vX1Z70JD0t/9hFWzeRzH03+P2rfcYGXnuzHQyOmlspxEt4DLXUZczfP/hZwux/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557450; c=relaxed/simple;
	bh=WLrGTKrOMYbljn6r1CK+cob2OJfzE02/ayEDB3wMOE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scbvrBQaNYTOGHw4c+hAE2Lwi4wryv51MxyiySkQHsswV6I0NUVzT/dOc8eJRDnTPuVmGyiYETZI1FsrOY9SnggYElz6BJ2WwRz+ji32r8UACeZ4dC9CDEmjpx1Tuikohbs81k2g/4I9JPlEBZtsRgZt3EVHc9dWqT1Defeh6PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HzpSiete; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760557447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8NSnMT6RiKobpn0PKbV4gidHn+ZR3JPL7ln0XZh9CQ=;
	b=HzpSieteNG1A2FYhSBTOJ2d7NIFwuYYrQljQqtrCEFXU7/hCT1LujX4zGGaNk+eGaCqCFq
	m9jcvlDzr0cI6Y7gBwqic9u2ksqYZGeVERBs/9aJnOIF6qkjTZ7EwVF/my9asgoO7h86uV
	6k9jzRiEnzUDtsUvRwwVfDH7I9oD1AQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-2zcVHpPXOxqQNLfBEiVbFw-1; Wed,
 15 Oct 2025 15:44:03 -0400
X-MC-Unique: 2zcVHpPXOxqQNLfBEiVbFw-1
X-Mimecast-MFC-AGG-ID: 2zcVHpPXOxqQNLfBEiVbFw_1760557442
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B91BA19560AD;
	Wed, 15 Oct 2025 19:44:01 +0000 (UTC)
Received: from bfoster (unknown [10.22.65.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 884E430001A1;
	Wed, 15 Oct 2025 19:44:00 +0000 (UTC)
Date: Wed, 15 Oct 2025 15:48:19 -0400
From: Brian Foster <bfoster@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, lu gu <giveme.gulu@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bernd Schubert <bernd@bsbernd.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
Message-ID: <aO_6g9cG1IVvp--D@bfoster>
References: <aO06hoYuvDGiCBc7@bfoster>
 <CAJfpegs0eeBNstSc-bj3HYjzvH6T-G+sVra7Ln+U1sXCGYC5-Q@mail.gmail.com>
 <aO1Klyk0OWx_UFpz@bfoster>
 <CAJfpeguoN5m4QVnwHPfyoq7=_BMRkWTBWZmY8iy7jMgF_h3uhA@mail.gmail.com>
 <CAJfpegt-OEGLwiBa=dJJowKM5vMFa+xCMZQZ0dKAWZebQ9iRdA@mail.gmail.com>
 <CAJnrk1Z26+c_xqTavib=t4h=Jb3CFwb7NXP=4DdLhWzUwS-QtQ@mail.gmail.com>
 <aO6N-g-y6VbSItzZ@bfoster>
 <CAFS-8+Ug-B=vCRYnz5YdEySfJM6fTDS3hRH04Td5+1GyJJGtgA@mail.gmail.com>
 <CAJfpegsiREizDTio4gO=cBjJnaLQQNsmeKOC=tCR0p5fkjQfSg@mail.gmail.com>
 <CAJnrk1b=UMb9GrU0oiah986of_dgwLiRsZKvodwBoO1PSUaP7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1b=UMb9GrU0oiah986of_dgwLiRsZKvodwBoO1PSUaP7w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Oct 15, 2025 at 10:19:15AM -0700, Joanne Koong wrote:
> On Wed, Oct 15, 2025 at 7:09 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Wed, 15 Oct 2025 at 06:00, lu gu <giveme.gulu@gmail.com> wrote:
> > >
> > > >  Attaching a test patch, minimally tested.
> > > Since I only have a test environment for kernel 5.15, I ported this
> > > patch to the FUSE module in 5.15. I ran the previous LTP test cases
> > > more than ten times, and the data inconsistency issue did not reoccur.
> > > However, a deadlock occur. Below is the specific stack trace.
> >
> > This is does not reproduce for me on 6.17 even after running the test
> > for hours.  Without seeing your backport it is difficult to say
> > anything about the reason for the deadlock.
> >
> > Attaching an updated patch that takes care of i_wb initialization on
> > CONFIG_CGROUP_WRITEBACK=y.
> 
> I think now we'll also need to always set
> mapping_set_writeback_may_deadlock_on_reclaim(), eg
> 
> @@ -3125,8 +3128,7 @@ void fuse_init_file_inode(struct inode *inode,
> unsigned int flags)
> 
>         inode->i_fop = &fuse_file_operations;
>         inode->i_data.a_ops = &fuse_file_aops;
> -       if (fc->writeback_cache)
> -               mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_data);
> +       mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_data);
> 
> 
> Does this completely get rid of the race? There's a fair chance I'm
> wrong here but doesn't the race still happen if the read invalidation
> happens before the write grabs the folio lock? This is the scenario
> I'm thinking of:
> 
> Thread A (read):
> read, w/ auto inval and a outdated mtime triggers invalidate_inode_pages2()
> generic_file_read_iter() is called, which calls filemap_read() ->
> filemap_get_pages() -> triggers read_folio/readahead
> read_folio/readahead fetches data (stale) from the server, unlocks folios
> 
> Thread B (writethrough write):
> fuse_perform_write() -> fuse_fill_write_pages():
> grabs the folio lock and copies new write data to page cache, sets
> writeback flag and unlocks folio, sends request to server
> 
> Thread A (read):
> the read data that was fetched from the server gets copied to the page
> cache in filemap_read()
> overwrites the write data in the page cache with the stale data
> 
> Am i misanalyzing something in this sequence?
> 

Maybe I misread the description, but I think folios are locked across
read I/O, so I don't follow how we could race with readahead in this
way. Hm?

Brian

> Thanks,
> Joanne
> >
> > Thanks,
> > Miklos
> 


