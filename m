Return-Path: <linux-kernel+bounces-866118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524FABFEEE9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 04:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F7D1A04312
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 02:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7CC2147FB;
	Thu, 23 Oct 2025 02:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="eBG5n+nH"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01113205AA1
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761186253; cv=none; b=AAxiPFeOe07kVEbqQEWL8MgVCIk54YPdO020+Nnvn5nukP4LhF3OFy2orr36eXIYwLduuCF4iGJMBf4/Z9y4HFXK5p/7cEUNw8uo9RH7Jml3HgvKwZsnlwH1sCMyYv7Z7lxUVh8Sm4pevEuRUvH7GZh3WWCISG0TrtaD/UYBa+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761186253; c=relaxed/simple;
	bh=SVr30Gy0yl93FUQ9VNPO4a87bKc+DSCWdirStpeVB+M=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=r8es6UdM6Fg0wMkekRAs9C3yVO6kBCXzE5fJXdcxOPbLwU6XtTkXpWwQOTL2kW0tpXfAaO/91PF0FSv3vZ8qyncqG8NucbAFvtXvWLTrauj0jD5F1kHEDZ4K1HWGNIk2+A7lo6+EE1NSTyJWVjzt96WLkvHlR/mXi8NAYlSDWxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=eBG5n+nH; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-79af647cef2so275070b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 19:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1761186250; x=1761791050; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hPrl+g8MWZLVjr5+X7xKR8IPIJl3i65GUuqXDZ4/RcU=;
        b=eBG5n+nH9zJ95Fzn+R7fnOhg9otrS9AMVa1A/fHAUzn23pY1VozDCsXiKOZkx9EGnq
         ZoiiijFynTJX5wEoaP/2pIFr8WN+VYve8GE709kK8X+REdW69dbyX32Qi2jo2nz9Q1Ns
         +4drH3zC74JcgAuemPQTILk0cxNxuWbjGUK7cuahIeh28G/edeiW5mb8DPr1MQ2VOHOL
         0HHfuckhu3MOoF8teCW1nKnfWroEOnxfCrpeA2l84qJL4P5cDK/3OyYXMSwaePh9Vq9F
         8iPLzttBU8HowRjQQcd8GiuV6LddHTqIobrs1dqqyn36itVfEBxBvb6IHDfj8Fy1Zgso
         qSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761186250; x=1761791050;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPrl+g8MWZLVjr5+X7xKR8IPIJl3i65GUuqXDZ4/RcU=;
        b=BqczniFpb60mUxwVJ/GPdimsifNSmLp1fbCc0Kk1VueQDNu+in9V9yImTAhHrJYoS9
         x73icCsq26dfvGuLhQDyz4txQDjvLxtVNccLPsT6fD3HbW7C6gO7k/UMTLCN0eAvAwtQ
         zSHGYGbCFkLhG7Ip1JPxTw5igvQ32SmOAXVcXEcV79xBtlLJUcdaBvyUvABUbhwdy4wD
         fWTYz9dYiAk6yh6e5iO2pA0W3r3/HRMOPoS3oMvqnuj2qnnUtK9yNsyCSnKWSW3JDT2L
         5zT/ZIN8FaGsF7cIutIeGCRNdCOIUsKND2NLSEovRKGmZMc3L6yprA4SMHCybmfRw5iU
         1eWA==
X-Forwarded-Encrypted: i=1; AJvYcCVaDmqsLlsXlCYOwRgfhpXgnHmPbgUn0WWmLs+OBVBlGv9v2FfLkycgLdJuZvRV6liG7TrEbAgY0M2ReHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxTKodXlrOQgq2M2JZcy0HVZAOMdF0yWsGBJ8jrlvSnsiGXGXI
	TD6PevbWeCkAmWLm+3AQzFRC99zSVIJk2xqjPNYesK+qXkfVvKXtSKr3aleEOUXZU80=
X-Gm-Gg: ASbGnctJDOjWg7MY8krQmkWM1WS5QJqGTYAWGL/SVPx81nnH1G5T6m0P59TsgfSRgIP
	7n/EThi09ue+TSEHDTiFIXihS0LR+PyuAKHKIpKF+8LvqGY3R8LJLPkAZcL4gQYT4Bvz0bwbFht
	mEfHB+5DeoZYvk/knhMIHyHASc9NjK/+HL8+zn7uASY5S7DMBTEelL/KHXgtyrv9ZLudDT/Mxgk
	lh3DBD610m3MZ4lkD+ktUU9f+vCJHwoSAtvvAl0N5wMQ8Ky/rqlPDubVoSgTkFjkS7LGjaYBRQN
	LRc+MWgAO1cRAIW2DW+VKfSPCuBbQGe56kSRZLaLCvnk0ku9qpGjk0HzDuHCrZOEnF2dJynZyDS
	c4jVFZgsM1tp1PAzohsHHq1j/bfuIdGwaX6m3KIPQh1UJY2OcE6t/E9oIZBA9ApLFKX+HwbsdTG
	ONxaYHQ+hy2H3T01Zt0OgucXfyz+Xd1XgWPd62EqemtmJ160TycTZdEbc=
X-Google-Smtp-Source: AGHT+IFwycBqDK/MPavB8G4BR9E3C2atxDC6Fo7M4NKNuTfl2rx4e6P8+xg4h4rSnxEx94PbV5suKA==
X-Received: by 2002:a05:6a20:a123:b0:324:6e84:d170 with SMTP id adf61e73a8af0-334a856d518mr32518220637.15.1761186250263;
        Wed, 22 Oct 2025 19:24:10 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4e12d6asm488383a12.21.2025.10.22.19.24.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Oct 2025 19:24:09 -0700 (PDT)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Sergey Senozhatsky'" <senozhatsky@chromium.org>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Christian Loehle'" <christian.loehle@arm.com>,
	"'Linux PM'" <linux-pm@vger.kernel.org>,
	"'LKML'" <linux-kernel@vger.kernel.org>,
	"'Artem Bityutskiy'" <artem.bityutskiy@linux.intel.com>,
	"'Tomasz Figa'" <tfiga@chromium.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <4687373.LvFx2qVVIh@rafael.j.wysocki> <5f0aa630-b30a-44c4-a52c-e08179cd3bf9@arm.com> <CAJZ5v0gBtv0bpK2swkc6D0AmanpKAvqO53dgRp2e7p9cWAM3TA@mail.gmail.com> <28ecb23b-ecee-409a-9771-24f801081d07@arm.com> <CAJZ5v0jMoEVUaYYPx6EtHFxsg6TF-QtDWJGrasGK7C2C+JxOFw@mail.gmail.com> <001801dc4041$607c19f0$21744dd0$@telus.net> <x4qvjfwxzatm6wnrtqgue7y673oqzo74i6ysmxalvnts5olkot@ekaee62fjg5l> <001201dc4297$3903af70$ab0b0e50$@telus.net> <zq6mqdrq2kxmyga2skrizuj63ocbab2o2k3ogeufq3sydmwyuo@epxcrwomkvvp>
In-Reply-To: <zq6mqdrq2kxmyga2skrizuj63ocbab2o2k3ogeufq3sydmwyuo@epxcrwomkvvp>
Subject: RE: [PATCH v1] cpuidle: governors: menu: Predict longer idle time when in doubt
Date: Wed, 22 Oct 2025 19:24:11 -0700
Message-ID: <001d01dc43c4$1f131eb0$5d395c10$@telus.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQEHjVQKCrlPynWgLAaVpIarC+pGJQGZtDQKAi3SGCUCWYi7hgLZuqUGAZPsdfIBj3Y3eQKrbtlkAf5ekF218ivVcA==

On 2025.10.22 01:01 Sergey Senozhatsky wrote:
> On (25/10/21 07:30), Doug Smythies wrote:
>> For your system booted with "base" and "revert" do:
>> 
>> echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
>> echo 2300000 | sudo tee /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq
>
> Alright, here are the results:
> 
> ~ # echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> performance
> ~ # echo 2300000 | sudo tee /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq
> 2300000
>
> Base:		52.5
> Revert:	45.5

So, still 15.4 %.

Thank you very much.
I wish I could create a test that would show such results on my test computer and believe me I have tried.
I haven't been able to.

... Doug



