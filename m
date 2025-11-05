Return-Path: <linux-kernel+bounces-886495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D606AC35BF1
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241A03BDBCD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D993081A6;
	Wed,  5 Nov 2025 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SaoJ3aPQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DACB22F389
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347688; cv=none; b=LcTWgYaGfHFOcoP7/pkQR43W7vgei+P/tO+hWtTYyoOsr84sT3emiE0ok232/rXkaHY0pz7evRUdkFJHbaAiTLRKD2iuhpyqQhhmhgphvPIDI9ag0CRhB4svcZvC3p6tCmnKbAt6magh0yZ5Xyg1cGfe6HNRuaVZDjC5BjmD/po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347688; c=relaxed/simple;
	bh=PsUzBn0ZHldN98fRDmqLigL0RQWnAVAW9c4G3SLhOfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ed0hzFbkKy1gXkSJ851vlkaY9fHxKiMGZSb8WfK9HPhBDVrhBIFa2Aktacv0U367uUSyL5AM0PkKezSsTjuhLRHwsxu11kK3Oh+EGfCI1XxHervRF1Fj+Cv0wQpbhVfS8rqTrWm5SECM2rxhywy993GB2vRyF2jF2EChkzEty/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SaoJ3aPQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762347685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXIwHhdPf2vZL070s3tpHwbG9LrUwjSbIBxTv4Nl50c=;
	b=SaoJ3aPQ2tb7pGhEgt7xFALCn8f/20iOQi8oGmmGM24or9CoLyLSEkGfU7nmOvZGhXx3R4
	R9Z9Se4xKX8ySPGRLraXzSiQMczvinyYN/yZ40ndlyMzqFHcI0x6WtjmRZRiowJmwuPd9/
	1hFiGv7ag2MoKggSLmsuhkXkE7GUj4g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-Akg3YLegNSCoPQQgB6Exrg-1; Wed,
 05 Nov 2025 08:01:22 -0500
X-MC-Unique: Akg3YLegNSCoPQQgB6Exrg-1
X-Mimecast-MFC-AGG-ID: Akg3YLegNSCoPQQgB6Exrg_1762347681
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1670E195607F;
	Wed,  5 Nov 2025 13:01:20 +0000 (UTC)
Received: from localhost (unknown [10.72.112.190])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 936AD19560A2;
	Wed,  5 Nov 2025 13:01:16 +0000 (UTC)
Date: Wed, 5 Nov 2025 21:01:12 +0800
From: Baoquan He <bhe@redhat.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 3/4] kexec: print out debugging message if required
 for kexec_load
Message-ID: <aQtKmP1W+k2+Gjdq@MiWiFi-R3L-srv>
References: <20251103063440.1681657-1-maqianga@uniontech.com>
 <20251103063440.1681657-4-maqianga@uniontech.com>
 <aQq97iGeYvZdr3SX@MiWiFi-R3L-srv>
 <5FC4A8D79744B238+97288be4-6c1a-4c0d-ae7d-be2029ec87f3@uniontech.com>
 <aQsCaeTx0WduSjSz@MiWiFi-R3L-srv>
 <2331A9F3E09581FC+4ab7e9ba-8776-47d2-868f-cb01ca9cd909@uniontech.com>
 <aQsRADZ+pPho9pYa@MiWiFi-R3L-srv>
 <44308A6B6D8BEB61+c143d52e-03dd-48bf-aadd-8a0d9196b280@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44308A6B6D8BEB61+c143d52e-03dd-48bf-aadd-8a0d9196b280@uniontech.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 11/05/25 at 07:28pm, Qiang Ma wrote:
> 
> 在 2025/11/5 16:55, Baoquan He 写道:
> > On 11/05/25 at 04:35pm, Qiang Ma wrote:
> > > 在 2025/11/5 15:53, Baoquan He 写道:
> > > > On 11/05/25 at 11:41am, Qiang Ma wrote:
> > > > > 在 2025/11/5 11:01, Baoquan He 写道:
> > > > > > On 11/03/25 at 02:34pm, Qiang Ma wrote:
> > > > > > > The commit a85ee18c7900 ("kexec_file: print out debugging message
> > > > > > > if required") has added general code printing in kexec_file_load(),
> > > > > > > but not in kexec_load().
> > > > > > > 
> > > > > > > Especially in the RISC-V architecture, kexec_image_info() has been
> > > > > > > removed(commit eb7622d908a0 ("kexec_file, riscv: print out debugging
> > > > > > > message if required")). As a result, when using '-d' for the kexec_load
> > > > > > > interface, print nothing in the kernel space. This might be helpful for
> > > > > > > verifying the accuracy of the data passed to the kernel. Therefore,
> > > > > > > refer to this commit a85ee18c7900 ("kexec_file: print out debugging
> > > > > > > message if required"), debug print information has been added.
> > > > > > > 
> > > > > > > Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> > > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > > > Closes: https://lore.kernel.org/oe-kbuild-all/202510310332.6XrLe70K-lkp@intel.com/
> > > > > > > ---
> > > > > > >     kernel/kexec.c | 11 +++++++++++
> > > > > > >     1 file changed, 11 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > > > > > > index c7a869d32f87..9b433b972cc1 100644
> > > > > > > --- a/kernel/kexec.c
> > > > > > > +++ b/kernel/kexec.c
> > > > > > > @@ -154,7 +154,15 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > > > > > >     	if (ret)
> > > > > > >     		goto out;
> > > > > > > +	kexec_dprintk("nr_segments = %lu\n", nr_segments);
> > > > > > >     	for (i = 0; i < nr_segments; i++) {
> > > > > > > +		struct kexec_segment *ksegment;
> > > > > > > +
> > > > > > > +		ksegment = &image->segment[i];
> > > > > > > +		kexec_dprintk("segment[%lu]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
> > > > > > > +			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
> > > > > > > +			      ksegment->memsz);
> > > > > > There has already been a print_segments() in kexec-tools/kexec/kexec.c,
> > > > > > you will get duplicated printing. That sounds not good. Have you tested
> > > > > > this?
> > > > > I have tested it, kexec-tools is the debug message printed
> > > > > in user space, while kexec_dprintk is printed
> > > > > in kernel space.
> > > > > 
> > > > > This might be helpful for verifying the accuracy of
> > > > > the data passed to the kernel.
> > > > Hmm, that's not necessary with a debug printing to verify value passed
> > > > in kernel. We should only add debug pringing when we need but lack it.
> > > > I didn't check it carefully, if you add the debug printing only for
> > > > verifying accuracy, that doesn't justify the code change.
> > > It's not entirely because of it.
> > > 
> > > Another reason is that for RISC-V, for kexec_file_load interface,
> > > kexec_image_info() was deleted at that time because the content
> > > has been printed out in generic code.
> > > 
> > > However, these contents were not printed in kexec_load because
> > > kexec_image_info was deleted. So now it has been added.
> > print_segments() in kexec-tools/kexec/kexec.c is a generic function,
> > shouldn't you make it called in kexec-tools for risc-v? I am confused by
> > the purpose of this patchset.
> There is a problem with what I expressed.
> I don't want to add print_segments to riscv.
> I want to add some debugging message(ksegment,kimage,flag) for kexec_load.
> 
> Although ksegment debugging message has been printed in kexec-tools,
> it is still helpful for debugging the kernel space function.

Sorry, I can't support that. We all prepare the loading segments for the
future jumping in kexec_tools if it's kexec_load interface. And calling
print_segments() to print those loading information is natural. Why do we
need print them two times for verifying if the printing is accuracy?
Could you explain why risc-v is special?

> > 
> > > > > > > +
> > > > > > >     		ret = kimage_load_segment(image, i);
> > > > > > >     		if (ret)
> > > > > > >     			goto out;
> > > > > > > @@ -166,6 +174,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > > > > > >     	if (ret)
> > > > > > >     		goto out;
> > > > > > > +	kexec_dprintk("kexec_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
> > > > > > > +		      image->type, image->start, image->head, flags);
> > > > > > > +
> > > > > > >     	/* Install the new kernel and uninstall the old */
> > > > > > >     	image = xchg(dest_image, image);
> > > > > > > -- 
> > > > > > > 2.20.1
> > > > > > > 
> > 
> 


