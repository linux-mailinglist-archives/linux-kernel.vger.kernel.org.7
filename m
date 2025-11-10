Return-Path: <linux-kernel+bounces-893836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27514C48774
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 284034F025B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D746C30BF67;
	Mon, 10 Nov 2025 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="npM/vE2E"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC7D248893
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797789; cv=none; b=DZPQdxz9dQUfb4io/QJF2fjBbD+igTbzg8XVk86Wo+W3SM2iZEb0flkcranOZJAnAVK1cqBpZCqblcGv15VWkYqG2SEK0H767wRaXQXWUmjhQpmc/i/ycWNDtFoWJ/PSwfAByEqSMHdqtq0Si80rVmx6fIkaCZbylMSYv4Dl7Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797789; c=relaxed/simple;
	bh=j//I72pxjWcMF3asq98y3R+83xTar6DU+rEGXdBJHDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMVZTuWTQjlNWGSiyMgN7CLloksqyvPs3sbx8mqtWqT86Ve35ILzwOhUjVfOjZas/63cgoaPmQ8DVZU/eWAuHGPLh+z6moBMF+IJ4S7B75FagtAzb+aAYM0j+uxOGZkULO74fTo5d8e15nbbrr1qS9C1tV12nQpTG1B16miQl9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=npM/vE2E; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-343514c7854so15820a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762797787; x=1763402587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EXgY6uiuq0FwYuYwuPfUmG8ZQgy+HUaTGGXE58Lpr3U=;
        b=npM/vE2EoAxID6JMW6FWaF7PNcYjewj5XX3RGoeC3BTWDRNPt6hyQ4WqA1+olnR0dw
         kvc8B5VaztA1c+c+gCpScU2j392vT39QAtJJpWsSTX/kO8BUoBTW/Mp5tg/ePUVxN3Uz
         i9jT9upRLHUWTlE56Q89xSMHhFPd8TCntZa8VlQF9W263UYwjIXE+gJUmhPDIujOM6LG
         ToUfayUQn8XlWQCutMF9az3aU8uxLR/4AoCe7ee3b7EVPEdJ38faSeQsYj7ug3y8k21U
         7moYXSJ2liPsOlckubQKHG7FLPWQLCwy+LqJ94OqDTLZ0tH67L+i8nxnjorh1nzB8oZb
         WuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762797787; x=1763402587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXgY6uiuq0FwYuYwuPfUmG8ZQgy+HUaTGGXE58Lpr3U=;
        b=C3jbCcjyegdtFBHOw89+V7VHdyGO8xEIr1H4FtOPBxix9ceWFjAuJewaZxmx0ytYvX
         qXQSnEqnANq2nKDIVEOHIzL3q2LV8zUyZ8SvuxgStgiZefLFFdH55CtlUm2rf9qQxzzF
         qfOyrrG3dGzCIZ5Cg39X56mGTm0RmdO5RG8p0oviXG3vGDcOZ6oDihWsm3C5eCknLcrd
         fOsP+C6bCFt/2tZa0+RmmirhDje5f8qpa8KECPrLa7nYGyt3rLwBkvxzUtjKkp60OhBD
         Q70rby6Eef4eWYzQ5oJre9UtM0czRkD+CRwK+VVrL6zBS/HUcm6MP27e8fT0lMmxUNEf
         gkJw==
X-Forwarded-Encrypted: i=1; AJvYcCUtwibagDWuI2XJim1uV5C4ZQbGRXhYhcw9al6ADm/CovW6Vof6elVGVnHk7Iv7HEn8yjn2xbIsV1Ms90U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5cT5pPGWEtvS8iCMByho0bRpm5vq9VhYEQ+WNrwnJXxKk9ylx
	u58YPklNiv5aNHRxCf1NZMyjVyyc/GedLh/MAawr7W7/OhHazEU0uxWSdj/Meml51A0=
X-Gm-Gg: ASbGncthMJFOOrMjLhW7OH3wfkTCGQyEBCb7ZycTLeCufXxcJRPPYuCUineSm6kyzUE
	DXAKMiTb/LjhWb2yxVqSLXrp2UZ/YfRwvMF+iU7qTLuUIcds4WMH7q8WYXMDb27Zi4PkV0EaN+W
	eaqrvLidUIKLbCXa4OAT5wRJJH0OeWqMxXxyhhYynaRZBYVZHl8/a8cxI6SMaN6ANV9n8u/gGrG
	O5onzhPNIcqXG/QO5F9KHCgIBxBm4cGITF8X+tb3p8ZrlN5z0hhDBJRA2iilKWbypw2clm23K3a
	5bdZADuAWcq0JcH4LtPAda8TzmYzx2KozQeqvYfbcBHGNDJ9TriOEddeebaRh2kxcjBWPkd+Wf4
	gEcV+kvxa5AiR4U1ZOMHO/772JvKyEgLV1aK9FT9BK0PIyn2J9rNfEbVUxa047V2b6l4ncux4lO
	a8kYs0ociceB2r
X-Google-Smtp-Source: AGHT+IHC7Imfj7cGkhR74bYmKh2j9kSgYdYuG4G34KbAjsmXPPbwIE4U9hQteTj2lzNkj3tD+sm36g==
X-Received: by 2002:a17:90b:1e51:b0:343:89cc:6f23 with SMTP id 98e67ed59e1d1-343bf2540d4mr278216a91.14.1762797786874;
        Mon, 10 Nov 2025 10:03:06 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:e689:789c:c35:41e7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34362f1f231sm9522807a91.10.2025.11.10.10.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 10:03:06 -0800 (PST)
Date: Mon, 10 Nov 2025 11:03:04 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Tanmay Shah <tanmay.shah@amd.com>, andersson@kernel.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] remoteproc: xlnx: remote crash recovery
Message-ID: <aRIo2MUol09Onu9B@p14s>
References: <20251028045730.1622685-1-tanmay.shah@amd.com>
 <20251029032422.GA7297@nxa18884-linux.ap.freescale.net>
 <b9ce8b9c-6391-47fd-b7b5-be5cddf9cd4e@amd.com>
 <1bb3a121-614d-4040-9cbe-505ccb7a7fcc@amd.com>
 <20251030042124.GA18595@nxa18884-linux.ap.freescale.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030042124.GA18595@nxa18884-linux.ap.freescale.net>

On Thu, Oct 30, 2025 at 12:21:24PM +0800, Peng Fan wrote:
> Hi Tanmay,
> 
> On Wed, Oct 29, 2025 at 06:51:51PM -0500, Tanmay Shah wrote:
> ...
> >> > 
> >> 
> >> Hi Peng,
> >> 
> >> I don't understand why it should fail. The patch simply implements
> >> rproc_detach() -> rproc_attach() sequence.
> >> 
> >
> >Hi Peng,
> >
> >Thanks for testing the patch. I appreciate your quick response. I think
> >rproc_boot() should be used instead of rproc_attach(). That should probably
> >solve the issue you are facing. I will send v2 with this change for you to
> >try.
> >
> >Thanks,
> >Tanmay
> >
> >> In your case, when you do detach -> attach via sysfs that sequence works?
> >> If that works, then crash recovery should work as well.
> 
> sysfs does not have attach option, only start/stop/detach are there.
> 
> >> 
> >> Could you give steps how do you generate the crash?
> 
> I have not look into the details on why it fails at my side for the 2nd time.
> 
> On my board, the M4 core use watchdog to reset itself and notify Linux, then
> linux side imx_rproc driver will do
> "rproc_report_crash(priv->rproc, RPROC_WATCHDOG);"
> 
> I will give a debug on the failures in a few days.
>

So what is happening here - Peng, do you plan on providing more debugging
information? Tanmay - are you planning on sending a second revision?
 
> Thanks,
> Peng
> 
> >> 
> >> Thanks,
> >> Tanmay
> >> 
> >> > Thanks,
> >> > Peng
> >> 
> >

