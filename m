Return-Path: <linux-kernel+bounces-878381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BB6C2070C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128383AB31E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F209423D7C4;
	Thu, 30 Oct 2025 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVhjEgXE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3E6218AAF
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832755; cv=none; b=M/EF3TdqA5ZuNW/CLS8lHIQ5mnyES7IjqwPHfcv0U1kGezBc+jzAQTCzUP0L+awl+cvs2fnrzar8mOvfmt3buEnlugU9XyQ6tGpSpPXAKoeRZxy6J5wblpg0vBYbb3zlqUdVnQ51uCsSnS9O5zp+WSjbVG9IrCuFNE/wnKcx6DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832755; c=relaxed/simple;
	bh=EI5k16HKK72OqEbVv2O+93NCmkl4aFydK/PL30ypjus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDa/V3INQ/BzprzBRm1Brjj3W/zotgz2koU/Odm6syznW2GHwW/4JVe2rdF8VagtdDweKoGRHmHJFZI68iWf8zCm16RQhJ3nVy3ZAuS2Gk9HdA735ToiQWcEWqq4mDz07i9FyqpS3HbdntMnLHDa29gDZlVXRz3eJZMHEQ6vjmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PVhjEgXE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761832751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/d/HRmDWcX+eRCc7ZcG6cq+zVaPfGqQhDVXjrBNobw=;
	b=PVhjEgXEIgZCHOin8oL6fkGFsvS77HaI6ULTzGeult5vA7s6gpZmt4IkLq6zpHhM5bx4Mp
	xZM/huHjEXAVnQ9tdjt9oFW7P+b3/pbKFAq7x+MWqyJ/obiKABVVSxf8/kY17FRSuTvBo7
	VTyznN8bGDOJpidU9ECOUKvHyQXD5U4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-qpABYTcGNOm8jOc1Acv_sg-1; Thu,
 30 Oct 2025 09:59:07 -0400
X-MC-Unique: qpABYTcGNOm8jOc1Acv_sg-1
X-Mimecast-MFC-AGG-ID: qpABYTcGNOm8jOc1Acv_sg_1761832743
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2102019540E1;
	Thu, 30 Oct 2025 13:59:03 +0000 (UTC)
Received: from localhost (unknown [10.72.112.46])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07FA6300019F;
	Thu, 30 Oct 2025 13:59:00 +0000 (UTC)
Date: Thu, 30 Oct 2025 21:58:53 +0800
From: Baoquan He <bhe@redhat.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: print out debugging message if required for
 kexec_load
Message-ID: <aQNvHdZcVzletjdi@MiWiFi-R3L-srv>
References: <20251030073316.529106-1-maqianga@uniontech.com>
 <aQMzFnqMC0MnLZFO@MiWiFi-R3L-srv>
 <C798DAB0066FD66B+590e2398-b667-40dd-abfb-99dcd728b573@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C798DAB0066FD66B+590e2398-b667-40dd-abfb-99dcd728b573@uniontech.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 10/30/25 at 07:41pm, Qiang Ma wrote:
> 
> 在 2025/10/30 17:42, Baoquan He 写道:
> > On 10/30/25 at 03:33pm, Qiang Ma wrote:
> > > The commit a85ee18c7900 ("kexec_file: print out debugging message
> > > if required") has added general code printing in kexec_file_load(),
> > > but not in kexec_load().
> > > 
> > > Especially in the RISC-V architecture, kexec_image_info() has been
> > > removed(commit eb7622d908a0 ("kexec_file, riscv: print out debugging
> > > message if required")). As a result, when using '-d' for the kexec_load
> > > interface, print nothing in the kernel space. This might be helpful for
> > > verifying the accuracy of the data passed to the kernel. Therefore, refer to
> > > this commit a85ee18c7900 ("kexec_file: print out debugging message
> > > if required"), debug print information has been added.
> > kexec_file_dbg_print setting when CONFIG_KEXEC_FILE is set. I doubt it
> > doesn't work when you unset CONFIG_KEXEC_FILE.
> 
> Yes, I just actually tested it and it really doesn't work when unset
> CONFIG_KEXEC_FILE.
> 
> In the next version, I can add a KEXEC_DEBUG for the kernel and kexec-tools.

Hold on please, it may not need that highweight change. I will reply to
you tomorrow if I have other idea.

> 
> > > Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> > > ---
> > >   kernel/kexec.c | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > > index 28008e3d462e..02845a7499e9 100644
> > > --- a/kernel/kexec.c
> > > +++ b/kernel/kexec.c
> > > @@ -151,7 +151,15 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > >   	if (ret)
> > >   		goto out;
> > > +	kexec_dprintk("nr_segments = %lu\n", image->nr_segments);
> > >   	for (i = 0; i < nr_segments; i++) {
> > > +		struct kexec_segment *ksegment;
> > > +
> > > +		ksegment = &image->segment[i];
> > > +		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
> > > +			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
> > > +			      ksegment->memsz);
> > > +
> > >   		ret = kimage_load_segment(image, i);
> > >   		if (ret)
> > >   			goto out;
> > > @@ -163,6 +171,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > >   	if (ret)
> > >   		goto out;
> > > +	kexec_dprintk("kexec_file_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
> > > +		      image->type, image->start, image->head, flags);
> > > +
> > >   	/* Install the new kernel and uninstall the old */
> > >   	image = xchg(dest_image, image);
> > > -- 
> > > 2.20.1
> > > 
> > > 
> > 
> 


