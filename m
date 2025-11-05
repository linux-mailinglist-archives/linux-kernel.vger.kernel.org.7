Return-Path: <linux-kernel+bounces-885952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF7EC345C3
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3AAF4E2CBE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A142D47E9;
	Wed,  5 Nov 2025 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxGCzZS0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20332C2365
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762329209; cv=none; b=gNcQscHUDV4SFIoM3WobjcWYQM1onVfTXtSYL8lo62FnU0xj+EF2YA1TjkoLruWOvjg1mvkCOJa6PmTyLeglSH//ewAE+MKzUDEZZcTHawL+bNDBqs7BdpSd1HOWCpOzeyufe6gP8vz1PwJQIgP8L5E6HSc1Cv6R7oGDONuUJf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762329209; c=relaxed/simple;
	bh=DqRdHLu8YZpMW0jF0RrigZyNDK0NVBhX/cdRxxvp6S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ki1ZhHN5o3RajWkJUK8wrDkIOTEU46NWxZ/1snWjVGR/bbpsnbNuQsoOmz9u08Q/lIYE5cEM3GawEsaq5/a0o6ueYwtcm8UTLw6KxxSAeWeYLOtYnsBDft0PyIzzPqG1AuykXhKVw0B3E480NHj/aHqauoyWrlNdANPTx0xAX7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IxGCzZS0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762329205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ROFoOenJg5dQLwe7jDFuQ2CPZm8re5K1Y0RzrsdP5PY=;
	b=IxGCzZS0RbAsyVO1c1XepL7CXQl13DjGye/VfDobiXmAu8gIRToBUC5ZMLxLsea9AQQ/+6
	wuOy6LIx1Aw5MrsMPdlRxr25uyxtmDkUtdvXvpsEzYfC/kW7j5RLq/oDy0XF+QoAeNppnY
	4yOGNP9RZXtQH8CpnDLJBN/fSqPAVMc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-eoNnlLuxNJ6s1FfhmwnFUA-1; Wed,
 05 Nov 2025 02:53:22 -0500
X-MC-Unique: eoNnlLuxNJ6s1FfhmwnFUA-1
X-Mimecast-MFC-AGG-ID: eoNnlLuxNJ6s1FfhmwnFUA_1762329201
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 455171956059;
	Wed,  5 Nov 2025 07:53:20 +0000 (UTC)
Received: from localhost (unknown [10.72.112.190])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED60D3000198;
	Wed,  5 Nov 2025 07:53:17 +0000 (UTC)
Date: Wed, 5 Nov 2025 15:53:13 +0800
From: Baoquan He <bhe@redhat.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 3/4] kexec: print out debugging message if required
 for kexec_load
Message-ID: <aQsCaeTx0WduSjSz@MiWiFi-R3L-srv>
References: <20251103063440.1681657-1-maqianga@uniontech.com>
 <20251103063440.1681657-4-maqianga@uniontech.com>
 <aQq97iGeYvZdr3SX@MiWiFi-R3L-srv>
 <5FC4A8D79744B238+97288be4-6c1a-4c0d-ae7d-be2029ec87f3@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5FC4A8D79744B238+97288be4-6c1a-4c0d-ae7d-be2029ec87f3@uniontech.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/05/25 at 11:41am, Qiang Ma wrote:
> 
> 在 2025/11/5 11:01, Baoquan He 写道:
> > On 11/03/25 at 02:34pm, Qiang Ma wrote:
> > > The commit a85ee18c7900 ("kexec_file: print out debugging message
> > > if required") has added general code printing in kexec_file_load(),
> > > but not in kexec_load().
> > > 
> > > Especially in the RISC-V architecture, kexec_image_info() has been
> > > removed(commit eb7622d908a0 ("kexec_file, riscv: print out debugging
> > > message if required")). As a result, when using '-d' for the kexec_load
> > > interface, print nothing in the kernel space. This might be helpful for
> > > verifying the accuracy of the data passed to the kernel. Therefore,
> > > refer to this commit a85ee18c7900 ("kexec_file: print out debugging
> > > message if required"), debug print information has been added.
> > > 
> > > Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202510310332.6XrLe70K-lkp@intel.com/
> > > ---
> > >   kernel/kexec.c | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > > index c7a869d32f87..9b433b972cc1 100644
> > > --- a/kernel/kexec.c
> > > +++ b/kernel/kexec.c
> > > @@ -154,7 +154,15 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > >   	if (ret)
> > >   		goto out;
> > > +	kexec_dprintk("nr_segments = %lu\n", nr_segments);
> > >   	for (i = 0; i < nr_segments; i++) {
> > > +		struct kexec_segment *ksegment;
> > > +
> > > +		ksegment = &image->segment[i];
> > > +		kexec_dprintk("segment[%lu]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
> > > +			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
> > > +			      ksegment->memsz);
> > There has already been a print_segments() in kexec-tools/kexec/kexec.c,
> > you will get duplicated printing. That sounds not good. Have you tested
> > this?
> I have tested it, kexec-tools is the debug message printed
> in user space, while kexec_dprintk is printed
> in kernel space.
> 
> This might be helpful for verifying the accuracy of
> the data passed to the kernel.

Hmm, that's not necessary with a debug printing to verify value passed
in kernel. We should only add debug pringing when we need but lack it. 
I didn't check it carefully, if you add the debug printing only for
verifying accuracy, that doesn't justify the code change.

> > > +
> > >   		ret = kimage_load_segment(image, i);
> > >   		if (ret)
> > >   			goto out;
> > > @@ -166,6 +174,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > >   	if (ret)
> > >   		goto out;
> > > +	kexec_dprintk("kexec_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
> > > +		      image->type, image->start, image->head, flags);
> > > +
> > >   	/* Install the new kernel and uninstall the old */
> > >   	image = xchg(dest_image, image);
> > > -- 
> > > 2.20.1
> > > 
> > 
> 


