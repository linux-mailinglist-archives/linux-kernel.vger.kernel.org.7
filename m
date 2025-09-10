Return-Path: <linux-kernel+bounces-809786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD63B51209
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A11161EBC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6702311C37;
	Wed, 10 Sep 2025 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yh3iYXbg"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A7424169F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494983; cv=none; b=NiXGu+cPxpcv0BKt9BTVF6MBhl8MzUGRDZrzzTQWKS9qR1v7aXmZkso5wzW5JMWD2ijEgmNmMOo0UckYF6Qf8jRgIEy5tAnHL1Wj50dwq6/DpACoOl0cW6E//BEfM9iRnubKWaGK1SpsF4Hph7kIScY1Qi53vPcURiYn7bXcUTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494983; c=relaxed/simple;
	bh=kxV6XtbiV7JTWu74TT6YzPaUMWNsUkAnJWAz+AQnq2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XV8dhNKr0P4L3FJcmD2xuXeuDua8jQdAPxQpjOXjG7NaOHsuwXw1sD2uvNPkGCS8uMDwG2YsXb4i8CIlpd5SS5GPdicU9mqRif1gDxbUrJ7a0hyZlf8QD8/KZkZRG4f9LixcIgHaCv2SrP3CA8dzrO0ZOemxQjPYVHy3WhnFhvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yh3iYXbg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3e3aafe06a7so3249469f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757494979; x=1758099779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dJDyeaSIYbWe+LX2MJH5q9Ay5IyPFDtaIV+Q05nJ9V0=;
        b=yh3iYXbgzctuUy3IwoI5pToRSJBOzqS+xGDU6NTDm7+hWH1NZBU+ftYh1gZoG1buhu
         OmJdlwIivrRYpWza6ZHaO9m2Kebwp1qpz9T9FqbD2dzB1cVSYCRui/dgx5wjHjf2Ro+D
         a/sj+eXKpMI3S6pEJHBAVecWJiI4IIWRj7LnulSGtg740paQGJaDUdLSXxKFmZU3nKDJ
         NiNK7Efs5eqimGb6qiq+IQiVVIpjVU2t905p8/xtcxiC9DR4ZoH3/3a5hKfzVRFInGO6
         YDtIkGDtNg/paFHQduu+tYDDX2nZu30HiqjmIvLO3ZygzwChXLYWjrBEH6Lr6YR2z6qN
         spRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757494979; x=1758099779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJDyeaSIYbWe+LX2MJH5q9Ay5IyPFDtaIV+Q05nJ9V0=;
        b=ndfc/jFzP4kLNVD62bA+Ih+o0aHyAcZrCXR4Q10LNzUJhiu5Ap5pjpDc1b7J2Q8F6g
         tUzd09EiMTWYRjkYXHyo+6apxrDhaYm7ngewyhq2JGZYmJzwvmh+xRnWqZUU1zZbumAI
         hgyl8H513dF0B+1Xrdfo089qXwJj4KjQe91RTblZ1cc92tGdPWnFDXNF1D4ntOggMA4d
         uidKIkUGKZ6aa8nvhGCpKM4JtnzH2SLl4i4fNxj4zkFaPuIumYbbFIVJJrzJtekMdanJ
         KcBMnNyZmHCm6JaPGJu6HFFQEnm3r0OaAsbUaRYo0H6R16e7nvZSqyNlM7xQRtijV1gC
         bNqA==
X-Forwarded-Encrypted: i=1; AJvYcCUyesRu9F70A+kMG9mJTU0eQ8qOtCuns+5MKynJ6XpzJyj7A0bQwLaH5VFwpiz5mFbhPs92NYHD6c1m5DE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI0r5H54eUkhSrdnCo5ws8ZIOzQTEcDMWipUtVHIjpRLqnVwt1
	R5F58qrZgTU4OJf3LfbFXpXxNceM/3RJbE5n6q9xVHs42jlKBnn3H5G1WA9v6eDRCH0aFK0/Jhr
	Ljq4J
X-Gm-Gg: ASbGnctG1njYaba+uOiEqrn6BmScQv4yDXtHIBKGJo3vpLAPgZIm/yINms1qPcqkWHe
	QuirWRo9pBPUw1HdlIC7gTpzkGt/kFCogWwsc5Zp6Fdwl5hznKLZz9iXezza6xBRbzjUy168A5D
	X7xZt5QqZSuCU0DR53TTxT/YpbDSHOyxKZoAovJwZowAz998SwhXrJnzGEglOMJvKbgtYEeisrQ
	MgYZT60BpiaXRf4wtpP7Lt+IY/+EKleamVZMDPilj06mxkPXZka+kTyLMpO00r6p7qyMZoKfJO9
	GrpYmx/HIcrwWFIUNRm0NLIBK4IA9bNkKo9zRt5ymOCL2uNXBJSWUKJmzZYDkyv1G2NVf+3k/8A
	XMsJ4W1il5QV6z7OCQS1gLtsvtbzKY0NP0LPm895hfRfVyEjlle2BX6DHZqNroQsSpoxmkvWmju
	5A4ZVTFycEA2cs
X-Google-Smtp-Source: AGHT+IHl14Q5qqdTfUO4W4z2QDsiDWkUjE4wOLa0XIFkQEkkvKf4UBTBdWfnoOWQPrHUthI7WagxOg==
X-Received: by 2002:a05:6000:200f:b0:3e7:4c93:18d9 with SMTP id ffacd0b85a97d-3e74c931c04mr7944670f8f.60.1757494979530;
        Wed, 10 Sep 2025 02:02:59 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:9717:723a:79cf:4f4a? ([2a05:6e02:1041:c10:9717:723a:79cf:4f4a])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e7521ca123sm6229990f8f.22.2025.09.10.02.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 02:02:59 -0700 (PDT)
Message-ID: <af4a09e2-5b3e-4223-a926-4ab33b327416@linaro.org>
Date: Wed, 10 Sep 2025 11:02:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] clocksource/drivers/timer-rtl-otto: work around dying
 timers
To: Markus Stockhausen <markus.stockhausen@gmx.de>, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, howels@allthatwemight.be, bjorn@mork.no
References: <20250804080328.2609287-1-markus.stockhausen@gmx.de>
 <20250804080328.2609287-2-markus.stockhausen@gmx.de>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250804080328.2609287-2-markus.stockhausen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/08/2025 10:03, Markus Stockhausen wrote:
> The OpenWrt distribution has switched from kernel longterm 6.6 to
> 6.12. Reports show that devices with the Realtek Otto switch platform
> die during operation and are rebooted by the watchdog. Sorting out
> other possible reasons the Otto timer is to blame. The platform
> currently consists of 4 targets with different hardware revisions.
> It is not 100% clear which devices and revisions are affected.
> 
> Analysis shows:
> 
> A more aggressive sched/deadline handling leads to more timer starts
> with small intervals. This increases the bug chances. See
> https://marc.info/?l=linux-kernel&m=175276556023276&w=2
> 
> Focusing on the real issue a hardware limitation on some devices was
> found. There is a minimal chance that a timer ends without firing an
> interrupt if it is reprogrammed within the 5us before its expiration
> time.

Is it possible the timer IRQ flag is reset when setting the new counter 
value ?

While in the code path with the interrupt disabled, the timer expires in 
these 5us, the IRQ flag is raised, then the driver sets a new value and 
this flag is reset automatically, thus losing the current timer expiration ?





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

