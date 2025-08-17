Return-Path: <linux-kernel+bounces-772329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF01B2916F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 05:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E79C7AC444
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 03:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D211F1534;
	Sun, 17 Aug 2025 03:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6ein0VI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D367367
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 03:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755402063; cv=none; b=HH7YcPEm9uQekpnhqBV0MsxD0cKhTo3v2VCodBlK0Ojr0NuzxPmnG3HFAbkF2B03u1LA/6/C+1SOvEoWiv4+Cx45G5unocJ+bq9v7+9FMN6qklMQsilnaFiOlZuOQH7CSgcMEomL4xyR2z9D7VJoYv5YMbZHjWwmo8PwuiG5Nrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755402063; c=relaxed/simple;
	bh=Wi2TRfYpR6wvvg8UpKW2O2TcIJ1xXIhqvyEYdfTO+Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzmLSHJlLL0GQ55BmIs4Vl4CJv0AzVJbN1+p+gkO3D5ar0Y8xWF1Y8JEvQB1/tZarcjBqPjlgwMmUcRzIjE4ZlB2eJDhHELGquDRE/NdnbfYfPcCQS6KCeSgJJpGHn89VWDDLTUVICX8BcSFRpQoYEW1OfConvj7qyAkSdaC+YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W6ein0VI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755402061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Y0oXgvbJlVAXUapKet03fj1MIE/RRaWOW5OiNzH2oU=;
	b=W6ein0VIYzXSSg7u4dmwhBQASf+T28g9MK2uZw8m76651NtZ2JQWEUFf8aawnNLnyJPnRq
	+jzlmzI0HE/SsYDk5XQfpDAQI3/Jpo70nLqDH9Nlgqb/Mq7uuBuyxD9Q+T9/eA77U0RKN+
	Xhmztsn5R3AS//RUeKHFH6vOEk/keDs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-PkT_4EHSPaqREfWT33cFVQ-1; Sat,
 16 Aug 2025 23:40:55 -0400
X-MC-Unique: PkT_4EHSPaqREfWT33cFVQ-1
X-Mimecast-MFC-AGG-ID: PkT_4EHSPaqREfWT33cFVQ_1755402053
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 544231800340;
	Sun, 17 Aug 2025 03:40:53 +0000 (UTC)
Received: from localhost (unknown [10.72.112.34])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5A23180044F;
	Sun, 17 Aug 2025 03:40:50 +0000 (UTC)
Date: Sun, 17 Aug 2025 11:40:46 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com,
	dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	sj@kernel.org, lorenzo.stoakes@oracle.com, elver@google.com,
	snovitoll@gmail.com
Subject: Re: [PATCH v2 00/12] mm/kasan: make kasan=on|off work for all three
 modes
Message-ID: <aKFPPi2sti7+3JZ9@MiWiFi-R3L-srv>
References: <20250812124941.69508-1-bhe@redhat.com>
 <CA+fCnZcAa62uXqnUwxFmDYh1xPqKBOQqOT55kU8iY_pgQg2+NA@mail.gmail.com>
 <CA+fCnZdKy-AQr+L3w=gfaw9EnFvKd0Gz4LtAZciYDP_SiWrL2A@mail.gmail.com>
 <aJxzehJYKez5Q1v2@MiWiFi-R3L-srv>
 <CA+fCnZfv9sbHuRVy8G9QdbKaaeO-Vguf7b2Atc5WXEs+uJx0YQ@mail.gmail.com>
 <aJ2kpEVB4Anyyo/K@MiWiFi-R3L-srv>
 <CA+fCnZcdSDEZvRSxEnogBMCFg1f-PK7PKx0KB_1SA0saY6-21g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZcdSDEZvRSxEnogBMCFg1f-PK7PKx0KB_1SA0saY6-21g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 08/16/25 at 06:50am, Andrey Konovalov wrote:
> On Thu, Aug 14, 2025 at 10:56 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > Ah, I got what you mean. We probably are saying different things.
> >
> > In order to record memory content of a corrupted kernel, we need reserve
> > a memory region during bootup of a normal kernel (usually called 1st
> > kernel) via kernel parameter crashkernel=nMB in advance. Then load
> > kernel into the crashkernel memory region, that means the region is not
> > usable for 1st kernel. When 1st kernel collapsed, we stop the 1st kernel
> > cpu/irq and warmly switch to the loaded kernel in the crashkernel memory
> > region (usually called kdump kernel). In kdump kernel, it boots up and
> > enable necessary features to read out the 1st kernel's memory content,
> > we usually use user space tool like makeudmpfile to filter out unwanted
> > memory content.
> >
> > So this patchset intends to disable KASAN to decrease the crashkernel
> > meomry value because crashkernel is not usable for 1st kernel. As for
> > shadow memory of 1st kernel, we need recognize it and filter it away
> > in makedumpfile.
> 
> Ah, I see, thank you for the explanation!
> 
> So kdump kernel runs with the amount of RAM specified by crashkernel=.
> And KASAN's shadow memory increases RAM usage, which means
> crashkernel= needs to be set to a higher value for KASAN kernels. Is
> my understanding of the problem correct?

Yeah, you are quite right.

When I tested it, on x86_64 and arm64, usually I set crashkernel=256M
and it's sufficient. However, when KASAN is enabled and generic mode is
taken, I need set crashkernel=768M to make vmcore dumping succeed. In
kdump kernel, read_vmcore() uses ioremap to map the old memory of
collapsed kernel for reading out, those vmalloc-ed areas are lazily
freed and cause more shadow memory than what we usually think shadow
memory only costs 1/8 of physical RAM.


