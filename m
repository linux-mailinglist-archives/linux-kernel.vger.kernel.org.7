Return-Path: <linux-kernel+bounces-849036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2C6BCF0E9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB97119A2784
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 07:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4552264A0;
	Sat, 11 Oct 2025 07:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="eZDDFLjI"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12BF2AEE4
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760167140; cv=none; b=WOtuubFD2TaAKd8eLWUy0RO1uBJ0xhT82FS0GqBkt/Wt+emGU66aCRACpi1qFHjpiyD3qQqgSWXogu0lKWlWoNUDU1T9is5tOvpJff7zXyGNtxCPrTFStYaV6LqAEjr7aHTNpFezy7D9yWKZAd6kHJlumIVLRigQYsh4T2s1hto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760167140; c=relaxed/simple;
	bh=tpE//6gH2ceJz4TAKFITtyl+56y4S0Zq1mUYtOEolhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Un5VGlfSDxQeWYR2zYb1d1chSGWdzA4Dsq1cVPGbL89Lky/j8rLR2zXRfjnJycReBv8DI1ioilhKBWpAMC8vYV4U/SFLWQM3wZrgM+xnFu5H61rsx4Aa8+5N/Wfsh4CUOavXAn39i4nmk4IGC4R6yf2qJ0ZXzfjbyaecUoNUTcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=eZDDFLjI; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-339c9bf3492so3517606a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 00:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1760167138; x=1760771938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SUmuf8N7efdy7uUe7LCCQ0JKiGdcMKfcndEXaOZcuSE=;
        b=eZDDFLjI31g/90mGqsbuxp7Di/NN4Vp9KFjDgAG6gSI0LCxmzng7TNSImNJG6Z+iVi
         riNQ3NtwFpklbjp3MLIZdBEZemNCW90OXqpEC8E8Dt1TxvHzTPHV0nh7GCBoyxlK1nDk
         K46nQvvE68tg15bNjUhvBgNpr1Of0LR3WXIFhUyAyHC9kRMtxKchP6YLuATBPdHK1HDt
         4BpR190cfaZoLtBefFurqAogIt47RuCJ3RThFpqs7l0Evnd/7W/yAf3VmRbZ7Czv0PaC
         iQyN+PhL8GJ6VMNtnzEcH+NI6pbMVwFlk0ssvTXY450uxwZdnTxwJzlR0vDIRcR3jvqF
         9jCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760167138; x=1760771938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUmuf8N7efdy7uUe7LCCQ0JKiGdcMKfcndEXaOZcuSE=;
        b=B2BYlD3yoc7GleNWd5OXhQK8rLumw8qyw39BAajGG1TeswphrYTcDMq/0z7iUuDdBD
         nCT+HAXXSK/mt8Bqsdg9ldA8eDpOVZ02Ld4nzlOVr8AxQyiti/F0Vl17UsdFq6d5xH3O
         JqFd1KjVOPXLw3Z6XSiZXxjJDfZBpYA1aRbjjE0x4QsTxpTJvEm379vc1r+uZx76Auz7
         ALZO8+H3vcUu00+yp2OgxSLYsz2TjcJUrXkSpsQ0lOR0MvlouynjAH2fF3HJI5Nu58hY
         EXkhTuxUNJS7eFLA98XLng4rCFe69XakDoyal3Y2l3QNkm5LXonwfGzeypbkEUdWPYFs
         pwIA==
X-Forwarded-Encrypted: i=1; AJvYcCXej83pP3yPxhzU8TqD+1l7wmpnrP7olypfv6TCuBacbdpWaeRb882RIjyHsfN25hGhy4tW5qqQKMxeHts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlulxHj7vrOqwWyySrSHnduCk9qZfpteAOkwwMXneUDRTW+JTI
	7ZtlV2gNCGZGYda+uPHhbmfWR+CvimWIcpovAOIKcPZo+wPdjTGmtbwijQt5SdjCeEif
X-Gm-Gg: ASbGncuCXLAve3YGyj6lKmTv0GI1owosdLyCSCcGNpRo+IXmus/YqRDU2qwX6EqER4u
	yDMSHFF5TcyG1KERI4lHXQ4SLTR9+W0H1H4q8eBPyCymAAz6MjP3Q6oOyS7yu4YNWj1aTwdlEba
	uLfrCtoe5cLquenTwIlk9QKgPfB7j8/Wr9sSDvR1HIsHVHdnUHDmwN5SlKoMJoire/vQA37o51K
	OmaZk23N8Ei4V8Llr6mRPdPsmjzWaiYPNw3YNekY+ffuCLgQvaeWWKH0wBnDGIPtjplT2Jag1C8
	LzTMOAkIoFmEMBgmWtCdI8CWczJofps/GDCMuVUIvZgK0sAQBUtgKYrEDqY2jto9D6paOgcIgIv
	dsWzAvB5IMkEDzAgde5XNLiK1bFTjBDZ+8NLk0fg+UV0TJjiWrC8IxWM=
X-Google-Smtp-Source: AGHT+IGMAhwZUtxLSCfxb1nn1Xv9WZqD3H9xsVVqoNrOrRTbrsC/gPSVhqWUKhsa4XihRV2z61wt3w==
X-Received: by 2002:a17:90b:2249:b0:32e:7bbc:bf13 with SMTP id 98e67ed59e1d1-33b5139a2cfmr19504988a91.34.1760167138183;
        Sat, 11 Oct 2025 00:18:58 -0700 (PDT)
Received: from sultan-box ([142.147.89.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626d15b3sm5171252a91.20.2025.10.11.00.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 00:18:57 -0700 (PDT)
Date: Sat, 11 Oct 2025 00:18:54 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: "Du, Bin" <bin.du@amd.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl,
	laurent.pinchart+renesas@ideasonboard.com,
	bryan.odonoghue@linaro.org, sakari.ailus@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	pratap.nirujogi@amd.com, benjamin.chan@amd.com, king.li@amd.com,
	gjorgji.rosikopulos@amd.com, Phil.Jawich@amd.com,
	Dominic.Antony@amd.com, mario.limonciello@amd.com,
	richard.gong@amd.com, anson.tsao@amd.com,
	Alexey Zagorodnikov <xglooom@gmail.com>
Subject: Re: [PATCH v4 4/7] media: platform: amd: isp4 subdev and firmware
 loading handling added
Message-ID: <aOoE3oPVeUuaElRl@sultan-box>
References: <20250911100847.277408-1-Bin.Du@amd.com>
 <20250911100847.277408-5-Bin.Du@amd.com>
 <aNJK_tZe99_jWNdR@sultan-box>
 <c63a56cb-23d0-4c5a-8e1a-0dfe17ff1786@amd.com>
 <aNzXJaH_yGu1UrV2@sultan-box>
 <dbc92a53-a332-4e57-a37a-7a146b067fcd@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbc92a53-a332-4e57-a37a-7a146b067fcd@amd.com>

On Fri, Oct 10, 2025 at 06:25:48PM +0800, Du, Bin wrote:
> Thanks, Sultan. sorry for the delayed response due to the long public
> holiday here.

No worries, hope you had a good holiday. :)

> On 10/1/2025 3:24 PM, Sultan Alsawaf wrote:
> > On Tue, Sep 30, 2025 at 03:30:49PM +0800, Du, Bin wrote:
> > > On 9/23/2025 3:23 PM, Sultan Alsawaf wrote:
> > > > On Thu, Sep 11, 2025 at 06:08:44PM +0800, Bin Du wrote:
> > > > > +	u32 r1;
> > > > > +
> > > > > +	if (!isp_dev)
> > > > > +		goto error_drv_data;
> > > > > +
> > > > > +	isp = &isp_dev->isp_sdev;
> > > > > +	/* check ISP_SYS interrupts status */
> > > > > +	r1 = isp4hw_rreg(ISP4_GET_ISP_REG_BASE(isp), ISP_SYS_INT0_STATUS);
> > > > > +
> > > > > +	isp_sys_irq_status = r1 & ISP4_FW_RESP_RB_IRQ_STATUS_MASK;
> > > > 
> > > > There are four IRQs (one for each stream) but any one of the IRQs can result in
> > > > a notification for _all_ streams. Each IRQ should only do the work of its own
> > > > stream.
> > > > 
> > > > You can do this by passing devm_request_irq() a private pointer to indicate the
> > > > mapping between a stream and its IRQ, so that isp4_irq_handler() can know which
> > > > stream it should look at.
> > > > 
> > > 
> > > Will do optimization to remove unused IRQs and keep only necessary ones
> > > (reduce from 4 to 2), actually an IRQ won't result in notification to all
> > > streams, please check the implementation of isp4_resp_interrupt_notify, it
> > > will only wake up IRQ corresponding stream processing thread.
> > 
> > What I mean is that the IRQ for one stream can wake a different stream if it is
> > also ready at the same time according to the interrupt status register.
> > 
> 
> Yes, you are correct, besides its own stream, the IRQ may wake a different
> stream if it is ready too in the IRQ status register. But i believe the
> shared irq handler can improve the performance without negative effects. The
> peseudo code of isp4_irq_handler works like this (take your below example)
> irqreturn_t isp4_irq_handler(...)
> {
> 	status = read_irq_status();
> 	if(status & WPT9)
> 		isp4_wake_up_resp_thread(isp, 1);
> 	if(status & WPT10)
> 		isp4_wake_up_resp_thread(isp, 2)
>         ack_irq_status(status);
> 	return IRQ_HANDLED;
> }
> Which means the first isp4_irq_handler can process all IRQs at that time.
> For the second isp4_irq_handler, because the irq status is cleared by the
> first isp4_irq_handler, it just does nothing and quit. So even if
> isp4_irq_handler doen't know exactly which IRQ triggers it, there's no harm
> as far as I can tell, not sure if I missed something.

My thinking was that it's possible for duplicate wakeups to occur when the
stream IRQs are affined to different CPUs and they fire around the same time in
parallel.

But now that I see how the ISP interrupts are actually GPU interrupts, it means
that the stream IRQs will always be affined to the same CPU as each other.

So my concern does not apply here, and you should disregard it. :)

Sultan

