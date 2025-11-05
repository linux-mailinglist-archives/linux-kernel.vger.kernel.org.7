Return-Path: <linux-kernel+bounces-885880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E599C341C5
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 07:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E103189F5A2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 06:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AC72C235B;
	Wed,  5 Nov 2025 06:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMJctr5+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB4C23D2B4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 06:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762325819; cv=none; b=StwD50FTqYkZPHaoIpSvDTFa0zENrX5Pr6Gxg1sxJGeGD1Sq2wYi2/KT8gANVPW5mleayxWC3pEIkOBac0sR90kCpbkr555Z7uBOhSTer3U8F/CZbmXhoS3+qnDodwowmnvSMMFzkTgJvfvQrJ2fcfX3BmspGievdgMPGiHSMv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762325819; c=relaxed/simple;
	bh=YghYSH3ErnExOInZPWly77x5U97BVL4K83KN5zcNbBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kyda52v+VPA1vYqvPfN3F/k/r1gqf7oYKVBDVZptHhSe+d4xidcUYu3oIV9P04Lm2c+rCFI69P3VEAz5Yqxdh4eJsEPhWi7DVP/xQ3ljqNpo5fku+UIfGhzSQobR8Jv6IL/93mhr79F89nI3nqmijkyf0rPeospgSurOK6qlxcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YMJctr5+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762325815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vk7GWEnRtGI2DGX3f0cxz4dFwcTmVgEkQ83OcqulT0c=;
	b=YMJctr5+29gbpJVG3LuuU6S5YsEAKLp5fl20B/1lXNbQPJRJljBTtJMGOc7k7jP3AP+PA4
	lIZJIw61C1AbwBTtSS6f95EepZHhVgfofzCkZRg1lMwUH++AIMVibdFG7F1y9ZcgDMs5uL
	Tm/yjNfVB2wGZAciChQwyXooplrekRM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-GEAERZR7M_iBvWQLvt_nVA-1; Wed,
 05 Nov 2025 01:56:52 -0500
X-MC-Unique: GEAERZR7M_iBvWQLvt_nVA-1
X-Mimecast-MFC-AGG-ID: GEAERZR7M_iBvWQLvt_nVA_1762325810
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E5411956094;
	Wed,  5 Nov 2025 06:56:49 +0000 (UTC)
Received: from localhost (unknown [10.72.112.190])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D445B1800297;
	Wed,  5 Nov 2025 06:56:47 +0000 (UTC)
Date: Wed, 5 Nov 2025 14:56:43 +0800
From: Baoquan He <bhe@redhat.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] kexec_file: Fix the issue of mismatch between
 loop variable types
Message-ID: <aQr1K/+I91RhVGuo@MiWiFi-R3L-srv>
References: <20251103063440.1681657-1-maqianga@uniontech.com>
 <20251103063440.1681657-5-maqianga@uniontech.com>
 <aQq/CHi10ihT8/sn@MiWiFi-R3L-srv>
 <0C92443D3E2100AF+c669d240-1ee8-4897-a30d-3efefe161085@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0C92443D3E2100AF+c669d240-1ee8-4897-a30d-3efefe161085@uniontech.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 11/05/25 at 11:47am, Qiang Ma wrote:
> 
> 在 2025/11/5 11:05, Baoquan He 写道:
> > On 11/03/25 at 02:34pm, Qiang Ma wrote:
> > > The type of the struct kimage member variable nr_segments is unsigned long.
> > > Correct the loop variable i and the print format specifier type.
> > I can't see what's meaningful with this change. nr_segments is unsigned
> > long, but it's the range 'i' will loop. If so, we need change all for
> > loop of the int iterator.
> If image->nr_segments is large enough, 'i' overflow causes an infinite loop.

Please check kexec_add_buffer(), there's checking for the value which
upper limit is restricted to 16.

        if (kbuf->image->nr_segments >= KEXEC_SEGMENT_MAX)
                return -EINVAL;

> > > Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> > > ---
> > >   kernel/kexec_file.c | 5 +++--
> > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > index 4a24aadbad02..7afdaa0efc50 100644
> > > --- a/kernel/kexec_file.c
> > > +++ b/kernel/kexec_file.c
> > > @@ -366,7 +366,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > >   	int image_type = (flags & KEXEC_FILE_ON_CRASH) ?
> > >   			 KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
> > >   	struct kimage **dest_image, *image;
> > > -	int ret = 0, i;
> > > +	int ret = 0;
> > > +	unsigned long i;
> > >   	/* We only trust the superuser with rebooting the system. */
> > >   	if (!kexec_load_permitted(image_type))
> > > @@ -432,7 +433,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > >   		struct kexec_segment *ksegment;
> > >   		ksegment = &image->segment[i];
> > > -		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
> > > +		kexec_dprintk("segment[%lu]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
> > >   			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
> > >   			      ksegment->memsz);
> > > -- 
> > > 2.20.1
> > > 
> > 
> 


