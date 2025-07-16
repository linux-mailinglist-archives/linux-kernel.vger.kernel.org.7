Return-Path: <linux-kernel+bounces-733485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10302B07548
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909F3583CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F7E291C09;
	Wed, 16 Jul 2025 12:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gE6kGOSb"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BDC28B401
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752667506; cv=none; b=DQtYjI3ynniBa5rYUipPdzAK4GGO1/6nTsGvhUnx7ogZ1PlRrgOxEfbv/zL93HwsTTKmXySp+MIe4+kl/iGMimQlx5C9Oh1ZJcGo3HSwJ6hEVHSeZWjUA9aAa00gmv41Yd2HCfofEW7+9yTxHHFNpx7Vs3+iNvp2AQsAzxW710U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752667506; c=relaxed/simple;
	bh=gwFnzLYaJfKcCfh+pyp+KlQNtwa+sdrlP9NP/uuwW/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdF+FrWAjubUXC0XhPORqv3f7wo7afxbwbPzkjwkRKzTAFiKJHL2ZMTjkFUl6aMpFfvS9ZeJhIFlm7RApcLa6AkIL2yWKqlhhMGiHKozXGrzfJK7VwTtpm1hgHv8qx3HDikCezvOePpuNK3VoasZZJF536HSVmiROkqIbs6fO1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gE6kGOSb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae3703c2a8bso1212108866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752667503; x=1753272303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r8TPF263FfctyCdIjb8gMnd6mJUseIXmAnCVMsuE8LU=;
        b=gE6kGOSbRVKK37QZ1IoM99GrlrsZTYRF5v/XctraxN7fL8J9MnQq7s455JLWYK4N4Z
         eXJKFMXW7Mn0cqoy+4EF4IlUUxki/jVob/VQFG2Ka5u5K++0wRKo3SN15E2+VibPizYr
         fWmr/mJSFM9TuobvxBvUV7s7X2gMCnHaKhrke9gTHeJ+esHDmD6Bner2N1OyFGTZPMY5
         mya8KAzNvgrwvFzoGBz7GszVz5YFd91ZCI2SQN6+En6sjRaWs8RYgJb5hQajVI4pfrM2
         3gqLevuXf/BtPmj1nlurmse3QN2UZ1tiwfJ1ZKbTZ0LFFgMqtGlUAh7mwDk4JIp0keIJ
         3Gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752667503; x=1753272303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8TPF263FfctyCdIjb8gMnd6mJUseIXmAnCVMsuE8LU=;
        b=jZWpTkTSPF+fxsv9U17zPY56xE+HtdWkGjs8yqouCxP3uHVdPopOKo1neylJbl9fF9
         2p5zayLGB927rxgWLSGK/ezuJlihVvZszqPJwWJzw70e+TAd0tpgDw9H4twUYvfbJ64P
         vO+2/kc+INyMz8Z8scKwK7RJo+FYhdosbrGiNxAcnICiFW5uUDRF58Mz/19r4yiTo8Tp
         cDkN/rx5GyjQA0zVDIlUk6YBSJvz8Et+YDIVjdNDH6+JfGb6y4GQqlMRZwc0IHE/xJQ6
         3vwFgKC0y4APJxitceAoLYesQjdNxTMI1ihW3u2RmQp0cYxzQYSVgkVrnh/q1FspQzVV
         vfZw==
X-Forwarded-Encrypted: i=1; AJvYcCX0v1om3eDpVCIaDM60klxyUDBmbZBZdfCzFX0nXYfPS9yfv2DVQ+6GXyvwvgJfrZefMu8u9JKnVSRq8y0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+P5XaywAbhSo/R2ES+fcfzNwYh7/Rc+auc1AONHb8nLPUsLFI
	p5twGjUjDA32dRXDtRbGyVnUOL2SAyH6EwW54oqe9RKuM6b+WGiPZqJ/OgnmWD5PpWc=
X-Gm-Gg: ASbGncvp+m0h3CVj5NATtoTVbKtIdkiIsX9jUEvaSf4/SX+H5d7KdvocNQQGHeDQs80
	HP7/5VkGPt5LcP+m4lkKgsyNhAl/qcNz2Ggz0mzjBytU4MCJPU2cu0tGSamwvfqU2FugZ2ssuQC
	2NvCXR87Hlqec+9d69If4gwrkSv8B0vsacidscsrOQwEnkAf+Nnb/w34o8+WJHCn/oDFfzqQd/S
	BnVo01tQ9MWMfh1eT5/rTuNXVoBrFSvxHsqlCnLpxIAHp/UHcV/FbDfNc93JYxdFeoNiTY3zqd7
	Nd/ZnVk0zJtoJYVzNp822KDxgvaAEAMaHKxZfU5dCMDT69JBsgAwk2ajAWOa0+YbzNSCsvtx02X
	lIHV9dtYl8NIRLPqsuOV/XFPBnd3ngw==
X-Google-Smtp-Source: AGHT+IEHWN0R93F6utf9eOM9iKnjv5S7ssfr5R2MO8UdDd3ai68a3PSrvOh737Pa7gqaj1wFZ0jbCw==
X-Received: by 2002:a17:907:7207:b0:ae7:cb7:9005 with SMTP id a640c23a62f3a-ae9c9af35afmr267572766b.35.1752667503179;
        Wed, 16 Jul 2025 05:05:03 -0700 (PDT)
Received: from linaro.org ([82.79.186.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294c15sm1185884366b.117.2025.07.16.05.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:05:02 -0700 (PDT)
Date: Wed, 16 Jul 2025 15:05:00 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: imx@lists.linux.dev, Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
	Frank Li <frank.li@nxp.com>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] clk: imx95-blk-ctl: Save/restore registers when
 RPM routines are called
Message-ID: <aHeVbInuGbZM7TUJ@linaro.org>
References: <20250716081519.3400158-1-laurentiu.palcu@oss.nxp.com>
 <20250716081519.3400158-3-laurentiu.palcu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716081519.3400158-3-laurentiu.palcu@oss.nxp.com>

On 25-07-16 11:15:06, Laurentiu Palcu wrote:
> If runtime PM is used for the clock providers and they're part of a
> power domain, then the power domain supply will be cut off when runtime
> suspended. That means all BLK CTL registers belonging to that power
> domain will be reset. Save the registers, then, before entering suspend
> and restore them in resume.
> 
> Also, fix the suspend/resume routines and make sure we disable/enable
> the clock correctly.
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

