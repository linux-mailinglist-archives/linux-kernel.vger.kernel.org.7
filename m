Return-Path: <linux-kernel+bounces-772673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8B8B295E6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 02:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB0E17063E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 00:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211AE218E8B;
	Mon, 18 Aug 2025 00:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjQotmF9"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E2120E6;
	Mon, 18 Aug 2025 00:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755477884; cv=none; b=N9bvWCap+8CXGGcPqSCgGokqVzeCNgN92um9xilq4otnaHQfHms4pLL4c6EDe5h3OoXDUzVFuq0LZqquLA0ZvVlwh8J4679Dz03fSP6w1arP7lfpAzcTrvHLPeAeZHURYk7hpiq0Xwp+Qz2YmcRpPETj1FUhdi2zmzUExedEGRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755477884; c=relaxed/simple;
	bh=4+Seknn2MoyfoYkQDYJUDCGyj+ihO9qsbYBk77VDubI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sStC6vQqZLhr8/jUN6VdKlblEUYkI7qwmvi3nhX1MWeeE98M61dHvnpZjIEFL1cyhi4Aw+TbD19CXybr+qO2R1cJ451uyQbiU0n7kkouyL6Ve+axNerLI1MDfuM5xNXsAG+nJ2owctTsFzZ6N/PY666OG0CuHQc5oVnCvC4cM4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjQotmF9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2ea94c7cso3040931b3a.2;
        Sun, 17 Aug 2025 17:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755477882; x=1756082682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A3+jGZnoPc1t7HINGfHTDjqwOoO9Iov2mq5P8s9FVss=;
        b=HjQotmF96fat+sO+i1CnFUKpWAfn04OmRTKoWoslleriTjkE30lscTB/ZgogWsvb8E
         cFobdRRmxFAiBxspUVIO3gIHOOpS4NJBsMbFVuwzZaMldWOPGmFGeKsnaeJ+GpEPxhqb
         itLv1hlhdZecgd7vTxquGFyvvn029JeJDGow1nlLpdOSNyua5eqhZU/Dtgi1cG+uVZ9n
         7s4+xAV6sbe8bayXRIF9PoFg7t7TZwcyqs24XsuRZ9e95Iz8du8GOQVJqTWugQXHWqR6
         asHuw6XhT5mKv2HEyPPpFLD0nCf0OoICVmvTifbTRfj4AXMukbMlj/9gtZHmQkGMIDFx
         8JHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755477882; x=1756082682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3+jGZnoPc1t7HINGfHTDjqwOoO9Iov2mq5P8s9FVss=;
        b=v+aHF1B//2RMfy0PsZXkkfWQ2j2dH2w3gZuoA/l6CgXk6uwbpb2vIw6YtfTwq6NLcI
         +hiIOx86mLGpJ5UN01ITORc91mxs/G1A7u+I9FglSMIW8LIUfzcM2KtwKnXZDhvQbxl4
         +7qCaEtRpADiFEf9Bd72rxDiTgtiDSL61zbv7hazxJisbL986opzrgzI/O0rcahoVIfF
         0sz/JYuc80M+9e6OvG1AfCcYrVRAQk7LZKhHZ3Q4nX/vLPp8AV6bNf6135rZhrbORY5a
         +5yvA5Mo9Yvy5UWBm79aanp+VRNjWebLlU+wjBtRRYZW/z4rAGmJqQI6JezaBJt0pxy7
         UPjg==
X-Forwarded-Encrypted: i=1; AJvYcCUSqSEpB/VjMJCF4Pvyge2Qdgjq8VQwEQFg8tlTyi1yK9Jdemqz/MnXMhRIUsKNYeBpsgsYfydajdE=@vger.kernel.org, AJvYcCVkc6lcbs2BdvPMMtPsy3CMIff8EFV+zTgjhjXi5tcVLYOCyjC7wPdBqfknf9Xs1KOxDAQzEwTYsyRvsDcs@vger.kernel.org
X-Gm-Message-State: AOJu0YxpsmlTss8b+Y9O0PRFuuF/98YXRoJM2LigBN2hOF2Zdbb/BBjX
	d4Wocof8iwBe9XSo5C5lyq1m6HnATbhFYQmiqfJMq7Fi62R//FTxipMX
X-Gm-Gg: ASbGncsUCiXrVPiFmXUVc+tTiM0yYcz14fkD9rRXy9hN8PiUrz9jsGudpOpugB6ZFn+
	mbWkR2i7d3LSWFQxKfrJBZiuWxHLGpLDNiVh4KBBYDcRAzpkom9CN6ZYINrVcFEVtLphqd7Y2yC
	oH0TCYiMbaKxuAZhQO0ANGUQ8a+pWT3paWp81mkcsbXgRvwHiR4Vv9LkgkBqKEo4m+LyJ3S47mG
	1GLC3eOzI11SJO6dNfJK84nqeWJTvyct6vnHzM5Na70Zi0QjiIC0oTaC2fxlqb2JFJWaLdiNL4v
	UpIgVq9pULQacj+wPHZKaerV2yILr6YmGmOqVv5FxxLKSYy3dc8svBqjWN+c/AEsLfwsY8ImZol
	2u2B8J7XOQry7HEieNCZydPEXuqUavYkwTcdrDJK4vYSPP3UBmPNRmHd4etm88QhQNHSW
X-Google-Smtp-Source: AGHT+IEWMg6KLtj2JlLiJ+60+Ns6YHDdMe4AdVEPI4k65idxKLNthaFApl4P/JUZnW3nmxgeZ3PNmg==
X-Received: by 2002:a05:6a00:4fca:b0:76b:e1c6:35d6 with SMTP id d2e1a72fcca58-76e5151e0b0mr9010746b3a.0.1755477882380;
        Sun, 17 Aug 2025 17:44:42 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e6fdfa95asm320212b3a.93.2025.08.17.17.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 17:44:42 -0700 (PDT)
Message-ID: <816ec5d2-33ea-4399-86e6-51ddc20ead28@gmail.com>
Date: Mon, 18 Aug 2025 09:44:39 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
 <773f4968-8ba5-4b1a-8a28-ff513736fa64@gmail.com>
 <20250816135538.733b80d3@foz.lan>
 <acc71988-4ed7-4df1-aa1f-a9d7a125ca53@gmail.com>
 <20250817133606.79d968ed@sal.lan>
 <b3d97e98-121d-4d12-9624-3efd119b12a4@gmail.com>
 <20250817154544.78d61029@foz.lan>
 <b6d18aa7-de85-4fd2-8456-c2f6342f1b06@gmail.com>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <b6d18aa7-de85-4fd2-8456-c2f6342f1b06@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 01:07:24 +0900, Akira Yokosawa wrote:
[...]

> 
> Ah, I have finally understood what 5/11 is trying to do.
> 
> Its changelog mainly talks about an issue you saw after adding options
> to xindy in that same commit, and you added
> 
>    \newfontfamily\headingfont{DejaVu Serif}
> 
> to resolve it.

Sidenote:

It looks like texlive-xindy is not available for RHEL based distros.

That means, you will need to ask EPEL to provide it.
Otherwise, you are obsoleting those distros for pdfdocs build
(under the confinement of "distro packages only").

I think I can live with it.

Akira


