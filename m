Return-Path: <linux-kernel+bounces-753323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BC8B18189
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3CDF562FD0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC36423E334;
	Fri,  1 Aug 2025 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCQmgqdn"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D662F5E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754050686; cv=none; b=SG/cAYXgVHNZrLui91sRciuUFzJxzBfxwYYeFYz0Id9M8aMEvilDYoEiE3CXFazQeqXKae6eMDvtu8ncxICoJdf5BqzGr8jMOwfJrFLGvACySGPcm7EoQEntKoBdrDdSYVk+xGhzWXkbJQfdRVZLoK12+IIOksqPNJKySeoOksA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754050686; c=relaxed/simple;
	bh=YsZ1llpJlYq+AjYwqeb+mqRwUxkLzdHogXR1ktSXBGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZxjX7OZ7kPITznkdlGqVrMCak0gs/XgVvE5mR+tbB3wmUdFKbP69gHwo3KgcYdfTwZGDLGYUpOkt5Gs7wzKQDgBtq7PLBRVHtk5Abhw+dSTeSEWeOBWXxu8d8TtzIsKcGwZotM5RIiWKUUVwq6ZJfTWxQICIPrPxKNWh1C/6Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCQmgqdn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4589b3e3820so20682405e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 05:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754050683; x=1754655483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YsZ1llpJlYq+AjYwqeb+mqRwUxkLzdHogXR1ktSXBGA=;
        b=bCQmgqdn1fC5Pn/wup8TDZTCI1QpDU9oy/naZ/DKp2h2Iju86Iut4D5hpogXnbCkWs
         fwAkI5g2RHwcNwukmjH2JsrYo7JNdvHMRFniH3HpBQxo6BRIqlBuprWr1szNA3kZFEc7
         6oUU6GMwg0zfYUcRryUCSUBKhumNl4fAZx1GpQxBEF9tucmlE1MwHjJFw29o+Bm7PXxt
         1ZtzIBrNDuLzorNUQWrNGIB8WNnLZkeKMo3Q6hdxCfpr5dVYHNGMsL6C/fpXvHofuqGM
         wqEM10zWgm31uCDSMk16fzqA34bQiWcXkqVTw7bLbBtQaINjgFjyM+Qob2Yhku8B/B/X
         oyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754050683; x=1754655483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YsZ1llpJlYq+AjYwqeb+mqRwUxkLzdHogXR1ktSXBGA=;
        b=Kcy9dTH/pWzI+dtFc2TlS8oD0aX0j5gauiXzqAKfxDeKYHef2G9h05y2uicoRrjwxZ
         xFPFSQC8qneq1wSK8H+2DjhOIgSQouWZtwbJuYK0P9u5lF2hOP37ncYRxUxgIXG+wfJH
         VqO9eBVnQlawWvCLOcBJ1z5VgrbRdQIjI7dMbwT36CXHab5mJWX/unJkiTeswhVP6A64
         JU/smXQNaqZ/sSFmYbyPByxqgq7fdbCrpw2I5Y3AcNAw7JcBK4whX3pFx49C8JkrYD8O
         pzyC4ULrpa/unnWdIX/lNiYaM0C1kLtJB72LN+87v6ipMs0Z9B7dDbRVJZ5uwHfeRjBJ
         6jqw==
X-Forwarded-Encrypted: i=1; AJvYcCUjwwjR8Yt4N5z8JMA8r3224HHB27cVGFvs8CROLw5v3qky9p3ixmw/P1oRHkMX16aqB+GAY0Jv0JTOwHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkCKS1THwad+HNMJw5/N1rQbr11u+JEPJItn7e8Ubf9Ta0PiF5
	IHUi3SqhA8hQ4iFb4m2HDXrDuKfdgSLe7WxCJgyeq8QgCYjKC8YvIYU+
X-Gm-Gg: ASbGncvSavLO4dRLjA3Ha/tsnDTXebHXNtHD+fXEx6qEIDaA7rzzOZ2Wcp7d/a2Zxvc
	jEaN2YPX54GhvBMaoKBYVQqiTuQXQzUd/52+F25Oymio50rRRjMs46tdbLqjyPZqCTVq/if7XOE
	Yn+4HyBFun5UEOIZfb9DMatYXY3dlB0SUbrjzsuGXJZu89hgkBSsCn3HuRAFjg6P7T+BoNDo3Z9
	itVW/SjZtXP+6A/gnNO2fyiIsa8N29vr7++FnESdH7bE5+n3aSM9Vd5BOdaiKVRzhjzjKsBSCLF
	wgcxSW1VEhkq1D4d2vHB11c8ykF29Vu/bdTu91YULqBWYIn8+enJoVghKp9eGWITAawR+xqqTPW
	glM+XT4ZHxOuv4jMJMQyZVykDX1HiPlSR4nRsRyPsZM8xA75PSw==
X-Google-Smtp-Source: AGHT+IHrJFPu6CRAATEvAklTPqretPHJtlzsftD5zl+L+B6Yf1bmLAz9RezcD7RpfLo+BJQVo8zS1g==
X-Received: by 2002:a05:6000:652:b0:3b7:90df:c53e with SMTP id ffacd0b85a97d-3b79501f11bmr8833925f8f.28.1754050682841;
        Fri, 01 Aug 2025 05:18:02 -0700 (PDT)
Received: from [192.168.1.129] ([82.79.237.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458af78fed0sm11896105e9.0.2025.08.01.05.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 05:18:02 -0700 (PDT)
Message-ID: <c39de58f-7fd9-40e3-b48e-b26b9b3ec5ad@gmail.com>
Date: Fri, 1 Aug 2025 15:18:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: defconfig: enable i.MX AIPSTZ driver
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Mark Brown <broonie@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
References: <20250707234628.164151-1-laurentiumihalcea111@gmail.com>
 <20250707234628.164151-3-laurentiumihalcea111@gmail.com>
 <CAOMZO5DfuRKYHkC8e4mNzetY204UdPDBHzUVy4M9pyjKpx401w@mail.gmail.com>
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <CAOMZO5DfuRKYHkC8e4mNzetY204UdPDBHzUVy4M9pyjKpx401w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/8/2025 4:39 AM, Fabio Estevam wrote:
> On Mon, Jul 7, 2025 at 8:46 PM Laurentiu Mihalcea
> <laurentiumihalcea111@gmail.com> wrote:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> Enable the config (CONFIG_IMX_AIPSTZ) for the i.MX AIPSTZ driver, which
>> is required for platforms using the AIPSTZ bridge (e.g. i.MX8MP).
> Shouldn't this be enabled via a select in Kconfig instead?

would've been nice but I'm not sure we have an i.MX8MP SoC-specific config option for that?
or do you have anything particular in your mind?

