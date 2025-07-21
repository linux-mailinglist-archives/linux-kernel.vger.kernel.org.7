Return-Path: <linux-kernel+bounces-739517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA686B0C73B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B4718850E9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E168328C85A;
	Mon, 21 Jul 2025 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZcF02Cp5"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5838F2DA763
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753110342; cv=none; b=LV9QZcYKfDqigi0dlHWtm7txu3VKWarN4mlyxCV6FQK6SsTkv/sGOPSIa+fnC4JdXHNI5jJ+LYql85IufG2k1HrpZ0oWWxs9bF5qA3nGEqmaFF9DdGLu19gj63MMMIlIWf7u4SYJkxfWkH4+8LdvYRaaH2ke9tLUTPAEqgrt5/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753110342; c=relaxed/simple;
	bh=WYOX+aQvGuyRdaZClk3PbP48B++PEB6IQx4YMuZQvwk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pEaZn4maaYy6ToDamBaGSHRMSNHfcyhsy7tiX/YarKSfjvkuRX2bummUfoz3u8jgR6vbtt9J0sOLW02ykSCYNZJ8L20ORTVT9c90HnRqKP/uQTCmIBTls4a39mVyDJV/X83Gp5vtHw2GA/xSRRjo/y9C0zi+igyEVfSE0mCv11U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZcF02Cp5; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-75001b1bd76so2746614b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1753110340; x=1753715140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wfG08sQTzHZuDbwX1YtmSn4kKtcxsDK1qy1oCX+Hc90=;
        b=ZcF02Cp5g10nrqDh1xgv4J7txRlVvzVL+hiiPFmo6lsEN/eHjAntPz+mrQ5cJ6ye3h
         OmEY2ADcOHbPEcv5INRewVgnTbhnYd3ivftnVLRwiMAPbk6U/TiouuxGDcN1ULJnzRYN
         qPwZkaWpOHgMKPc/65aJ8PcJJsnhgrW2HvqfYx6T0ulW3AoXUZ/LNX7veLOPMR+anP00
         zh/mb72mtZOK2uSKw04HGDXu6KafnLCd0S+CAT8UT7o87pSH/qYCYseHhi5XXj1eVbT5
         fyeQFrVrRZ/lZf7oLEOnNwtgwD6kOYtNX2DhxkC3stVa0Io/0jzsGNipj/hlqpEqeVQP
         WXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753110340; x=1753715140;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfG08sQTzHZuDbwX1YtmSn4kKtcxsDK1qy1oCX+Hc90=;
        b=iK5xCDMUR4VCIO5pL162skKzMsXmX0w9bKshiftUUC3q570ovUmGNW95VazjWD4jSX
         GE+HV5tzo3ukfASAH/Tqbm4VK9np8Um6DtsjhyeUCE0wouua/LUGPgM73YvidhlzgQXe
         g3qfIWz8/W+2qTg9GniiRrx1oiEa2+PsW5Bkh8uHgVR/QdCo4JPgLUykC8B2SMqp5an/
         8Z9XeHt6zr+Y4F/tYUy4b994L9qXoa0NmI5+fbQa7dkBn5jMAt3nXsZRtEtq3NV8Kl9q
         9l6UkELl6xOHGm0z01sh8ubhL2b05p/6S5dPXX8FkRA0GTPctJz8grCqfl3OUOzgXYPT
         UtFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuBFaPj5Nql5McPPThbA0hkf0/XSxn0mChLEtgs5qGzLAQJSpvh1Em4uIkCiQYEoq3Uh/y63XgnIDWQH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiWfXxV8x4USW1b7R62W1aQwsP2lnoD2PLJ4E72Z1YX2eXwsNx
	zcgsqdkF44Zw5J2SJWNExR+VxdDl0iLUnpYuW5b/MngK9G2FlL+rcnIe6QpcXuzpkM0=
X-Gm-Gg: ASbGncu3r/aNBe3VKzVZU8r8fTb6HeGZ45WJzPC9Xv2plQ36PLLnair5I/arG2mIIiy
	cJwxyUpB1rbwnrk8f39J1X2yK8sMNPYBBlX/LwLaC8gPvo4h6NQfqynQjsXwQEWxJGv9wN7flau
	I2AzchHD+xtIhi8HPBgt7C0UHM/M+lFZcqGhmUdFwF8KII87mmZy04tAt2bsZfkzfOA+fzrchMB
	wYZBOe1zOWDm9Md6WCX6I/mIHJQJ4wYrDJXNbd5PoUykNTAxwD9ZHqnIgfeHTrcl5rc0IkjzUtk
	fGFmMoeb6+0uP1nVD1y1mMI5/cKLxzsdmx5ZYjDfkZbQVRunwsm+3FvoFr7CaLZwXSPLXy20wOH
	vYufdagNBCJGnHdkxQmQkqWv45X66/iSCZSHmr8h1vw==
X-Google-Smtp-Source: AGHT+IEuZqAgbCqPJN/Z/JqXSrSZReTr9cVipbUfr9O+JL5UqFtmUZlL2hb4+/z33WcUxAR3xeqIRg==
X-Received: by 2002:a05:6a21:b90:b0:216:5f67:98f7 with SMTP id adf61e73a8af0-23813249c87mr30073287637.33.1753110339519;
        Mon, 21 Jul 2025 08:05:39 -0700 (PDT)
Received: from [10.5.70.53] ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb154755sm5967994b3a.69.2025.07.21.08.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 08:05:39 -0700 (PDT)
From: Liangyan <liangyan.peng@bytedance.com>
X-Google-Original-From: Liangyan <liangyan.peng@google.com>
Message-ID: <de657285-cfbf-452a-a217-8069f074f9d6@google.com>
Date: Mon, 21 Jul 2025 23:05:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [patch 0/4] genirq: Prevent migration live lock in
 handle_edge_irq()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Liangyan <liangyan.peng@bytedance.com>,
 Yicong Shen <shenyicong.1023@bytedance.com>,
 Jiri Slaby <jirislaby@kernel.org>
References: <20250718184935.232983339@linutronix.de>
Content-Language: en-US
In-Reply-To: <20250718184935.232983339@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/7/19 02:54, Thomas Gleixner wrote:
> Yicon reported and Liangyan debugged a live lock in handle_edge_irq()
> related to interrupt migration.
> 
> If the interrupt affinity is moved to a new target CPU and the interrupt is
> currently handled on the previous target CPU for edge type interrupts the
> handler might get stuck on the previous target:
> 
> CPU 0 (previous target)		CPU 1 (new target)
> 
>   handle_edge_irq()
>    repeat:
> 	handle_event()		handle_edge_irq()
> 			        if (INPROGESS) {
> 				  set(PENDING);
> 				  mask();
> 				  return;
> 				}
> 	if (PENDING) {
> 	  clear(PENDING);
> 	  unmask();
> 	  goto repeat;
> 	}
> 
> The migration in software never completes and CPU0 continues to handle the
> pending events forever. This happens when the device raises interrupts with
> a high rate and always before handle_event() completes and before the CPU0
> handler can clear INPROGRESS so that CPU1 sets the PENDING flag over and
> over. This has been observed in virtual machines.
> 
> The following series is addressing this by making the new target CPU wait
> for the handler to complete on CPU1 and thereby completing the software
> migration.
> 
> A draft combo patch of this has been tested by Liangyan:
> 
>   https://lore.kernel.org/all/87o6u0rpaa.ffs@tglx
> 
> The series splits up the draft patch and has proper changelogs.
> 
> Thanks,
> 
> 	tglx
> ---
>  chip.c      |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++--------
>  internals.h |    6 ++---
>  pm.c        |   16 +++++---------
>  spurious.c  |   37 --------------------------------
>  4 files changed, 69 insertions(+), 58 deletions(-)
> 
> 

Tested-by: Liangyan <liangyan.peng@bytedance.com>

Regards,
Liangyan



