Return-Path: <linux-kernel+bounces-881000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B35EEC27291
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 00:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54DE14E24AB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 23:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C7B3254AD;
	Fri, 31 Oct 2025 23:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qx53GJMK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817D230B50D
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 23:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761951859; cv=none; b=iOMU4R1RYt9BLlO4ECMUbt/VhXiVBaOilbje92UQDX5tJ65vDa4+JZ7btTm3S8vzVS+VgEmylpP/MdRT+gxVY089WMZ+9DsZZ4SOpU7nUsBVOLb16gxxVhUrDp3dj3peiiyjuDHXlQiV0Zc/PaIzsgfqU1BvcJGeF/x7s12ktpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761951859; c=relaxed/simple;
	bh=2qpx8hbT/SE/3lTaD4/w/mtyg8N5YsHDSoHAVF8d6zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWbZbTMxrz9psltp7sD7fgffukWiN9HSshxgPmUMmGe/fWjSRvC/RqOGF8yGz1rwUWontQNUUQg08lmCmH9w0UCULrQy7CWSgXflp4rJA+Ut+CTOAq9Z9KR1bzx59GESQiIMXp+kB4k1LLOt2abT3RnFgSQurTpYXhN3gfqjIvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qx53GJMK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761951856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ThkqP4KaoWB0HS0HVt8nqsOJjwG9UYgjJCNYGNLL94=;
	b=Qx53GJMKeHhGSr8KLy7+epenQf2FQB2+8OD1pDCSFINprBZIlLn+05+muW17Alo3SSMMjV
	4KdsvYrLCRl+xWlTULeuPz8N6IVWAT4CqVJ9Gs1OCu436JhOir4bsm+dHGeQIVCMuKaZai
	/yYmzdGKburDvhSMoBZH8d2xEGczMCg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-7XS1Ex_LP7-aYUlParY28w-1; Fri,
 31 Oct 2025 19:04:00 -0400
X-MC-Unique: 7XS1Ex_LP7-aYUlParY28w-1
X-Mimecast-MFC-AGG-ID: 7XS1Ex_LP7-aYUlParY28w_1761951839
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E42A319560B2;
	Fri, 31 Oct 2025 23:03:58 +0000 (UTC)
Received: from fedora (unknown [10.72.120.13])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A23A30001A1;
	Fri, 31 Oct 2025 23:03:54 +0000 (UTC)
Date: Sat, 1 Nov 2025 07:03:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: use copy_{to,from}_iter() for user copy
Message-ID: <aQVAVBGM7inQUa7z@fedora>
References: <20251031010522.3509499-1-csander@purestorage.com>
 <aQQwy7l_OCzG430i@fedora>
 <CADUfDZoPDbKO60nNVFk35X2JvT=8EV7vgROP+y2jgx6P39Woew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZoPDbKO60nNVFk35X2JvT=8EV7vgROP+y2jgx6P39Woew@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Oct 31, 2025 at 09:02:48AM -0700, Caleb Sander Mateos wrote:
> On Thu, Oct 30, 2025 at 8:45 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Thu, Oct 30, 2025 at 07:05:21PM -0600, Caleb Sander Mateos wrote:
> > > ublk_copy_user_pages()/ublk_copy_io_pages() currently uses
> > > iov_iter_get_pages2() to extract the pages from the iov_iter and
> > > memcpy()s between the bvec_iter and the iov_iter's pages one at a time.
> > > Switch to using copy_to_iter()/copy_from_iter() instead. This avoids the
> > > user page reference count increments and decrements and needing to split
> > > the memcpy() at user page boundaries. It also simplifies the code
> > > considerably.
> > >
> > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > ---
> > >  drivers/block/ublk_drv.c | 62 +++++++++-------------------------------
> > >  1 file changed, 14 insertions(+), 48 deletions(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 0c74a41a6753..852350e639d6 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -912,58 +912,47 @@ static const struct block_device_operations ub_fops = {
> > >       .open =         ublk_open,
> > >       .free_disk =    ublk_free_disk,
> > >       .report_zones = ublk_report_zones,
> > >  };
> > >
> > > -#define UBLK_MAX_PIN_PAGES   32
> > > -
> > >  struct ublk_io_iter {
> > > -     struct page *pages[UBLK_MAX_PIN_PAGES];
> > >       struct bio *bio;
> > >       struct bvec_iter iter;
> > >  };
> >
> > ->pages[] is actually for pinning user io pages in batch, so killing it may cause
> > perf drop.
> 
> As far as I can tell, copy_to_iter()/copy_from_iter() avoids the page
> pinning entirely. It calls copy_to_user_iter() for each contiguous
> user address range:
> 
> size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
> {
>         if (WARN_ON_ONCE(i->data_source))
>                 return 0;
>         if (user_backed_iter(i))
>                 might_fault();
>         return iterate_and_advance(i, bytes, (void *)addr,
>                                    copy_to_user_iter, memcpy_to_iter);
> }
> 
> Which just checks that the address range doesn't include any kernel
> addresses and then memcpy()s directly via the userspace virtual
> addresses:
> 
> static __always_inline
> size_t copy_to_user_iter(void __user *iter_to, size_t progress,
>                          size_t len, void *from, void *priv2)
> {
>         if (should_fail_usercopy())
>                 return len;
>         if (access_ok(iter_to, len)) {
>                 from += progress;
>                 instrument_copy_to_user(iter_to, from, len);
>                 len = raw_copy_to_user(iter_to, from, len);
>         }
>         return len;
> }
> 
> static __always_inline __must_check unsigned long
> raw_copy_to_user(void __user *dst, const void *src, unsigned long size)
> {
>         return copy_user_generic((__force void *)dst, src, size);
> }
> 
> static __always_inline __must_check unsigned long
> copy_user_generic(void *to, const void *from, unsigned long len)
> {
>         stac();
>         /*
>          * If CPU has FSRM feature, use 'rep movs'.
>          * Otherwise, use rep_movs_alternative.
>          */
>         asm volatile(
>                 "1:\n\t"
>                 ALTERNATIVE("rep movsb",
>                             "call rep_movs_alternative",
> ALT_NOT(X86_FEATURE_FSRM))
>                 "2:\n"
>                 _ASM_EXTABLE_UA(1b, 2b)
>                 :"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
>                 : : "memory", "rax");
>         clac();
>         return len;
> }
> 
> Am I missing something?

page is allocated & mapped in page fault handler.

However, in typical cases, pages in io buffer shouldn't be swapped out
frequently, so this cleanup may be good, I will run some perf test.

Also copy_page_from_iter()/copy_page_to_iter() can be used for avoiding
bvec_kmap_local(), and the two helper can handle one whole bvec instead
of single page.

Then rq_for_each_bvec() can be used directly, and `ublk_io_iter` may be
killed.



Thanks,
Ming


