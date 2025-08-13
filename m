Return-Path: <linux-kernel+bounces-766514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF28BB24777
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059E0721956
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C2B2F656E;
	Wed, 13 Aug 2025 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XqLUgWhl"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1012D2F49F0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081397; cv=none; b=qfA8d4iyO+Iuuk9ncdWWJ9CXfimc9zyrq2SrEGqCA6B/6z6Pmug5z+/dAwFjyKDWu15qf2zxarC70jDN/Bu3L3Tsvw3Wl2+G2lE4rGAEJXP3u0WZ1dNKQM+8tGYbYDUIGWtwykGfAR2tbHfGbGA9/NA75vBLQ7HnPQhpMDxLR3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081397; c=relaxed/simple;
	bh=rM1VH7DXY3SQ5CU5JoXtOdVhg6Lj0cix+4FvL7D4Z3Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G7Dq72vSj4+ErrlW378mCiPGTQ7K1aDa1Kx09h5KsIu1fgadwMnkP+IzLKA2n2E584O8uGLjbyKqC8iOCA3dH0/HjIOq7K1WI06OiIyDxSDkNm4Yh1dE1911m4jCi/BNggHbN7CEtWIBRgX9iSAOqkyYIOPJYGPX2kxtfyTKY+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XqLUgWhl; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af99942ba4cso84514166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 03:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755081394; x=1755686194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZSse5z3Xz3M0O4BGbTx+nqu/znB14s8R4egSwB9b9M=;
        b=XqLUgWhl4cK8s3pED+YdqFOezhbepyC3P/7XsRA3c1rgqdPL2ghVGjcnxSi7Sad6Dt
         cnAjZIG1COXaQd8ku1vDXl+bSJRT/1F9MB/rMIuipBm+P/4tvhBXBd7jGFH6y8pP/D3v
         LkX6y+v7R4llOGaEIKOmj12dI6FwRKu/inR6qnquq2ISt41GsMzQZboJ4iWYuIKxCLbG
         GCcGL19JeuFYgQRE8PJh89n3Ky9enSIH+LNKEeEzdT1hvohncvU5rwNWAgHyWY1mSRu+
         5d5XoVF3RHm3K11p4xOavVxkdgBzNfDdhqUVzy+bQblLiznvoTAW9Jc+4D/OQKAb6ecX
         a45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755081394; x=1755686194;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZSse5z3Xz3M0O4BGbTx+nqu/znB14s8R4egSwB9b9M=;
        b=rDDIjD6TP+HMSp8GyeV7OAEpgBafwaNVSeUhjBpXHlRS2MZsNiyVP5yKcs1Uyk1X8D
         ZGI3bC4GSsV2IT8kwQ7b6cUmQ6iX5gZDMrjktUnMLthFXfE0lud72K2roLquBjgnbPtV
         oJ9+4a6Psmhh0TuxzlkOhKm1X3hj6ha2OyJYFNMGKfxTgV0Fcjgw6L1Y7wMUIi7HVgwx
         hdC2tqD2rJvb1ddt6GLJl44po+z33BcNSEcu7GCO9L7Bxuwamv389SLvXoLRxyOVDMNC
         d97o3wYxwCtTsQFOMkKG6eGksRlZfB3pmkgM6lJ3qtsjpTPwsQZP89af1Q2qjLEc9TpY
         Cv3g==
X-Forwarded-Encrypted: i=1; AJvYcCWdrcPRa4Gq5VCk2pMbVDYOlsWhGtTST8FeALvozsfIOUAmE9weN21tKlSlAHIffFc1r1OVwpSM20R69dw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb8DIHNrmuKeVBYZzMaP4U39lMjg4uVbzP4901zqaN90MgFGdp
	b9/UxEsdBcfytVHK8qvzQ6TNEBqMOIvXSlMNW2ok45uuYrSx2wjUQGkqsJfAY7il7Ms=
X-Gm-Gg: ASbGncuQLkYDSMQBO1ksrOUsUYopk4Jx221bwjk4N7OcqF6V1sfqjUcq22wqxOj36mU
	ZREqheUAkkksAG5gcuhRYcmhGnatA1w075QKhFZFIRld8ppj/jkMhH96INpgWrnEMkEdrRdzlcT
	MUwjIfzUx+XMIdB+5ssCmbBjru59cSPx0WL9w+5ZKJw+UIiAfetvLJG0doQi/4alullfm+eQNRQ
	tFhdO2JHAeuabZrN63X0keBChAgIT4wl7CVBZA7icWlN6O3GlFiLX/rh1nUv1y4bIHnhuHf3sGS
	hKafOevz/xkYbgrv8w1L3w4XSNLZUkacbTEIqm2IDJEHMRX0MBTyvDEEBgNMwdq9LGnX221o4xy
	48KOrM8slxoHPbKMUyyGUxIC5/ly6Sap51ba7VzCd0JBp+A80WA==
X-Google-Smtp-Source: AGHT+IFIGBvJE51ImLFwJEf+HWdvDhMI/ga9sn6qqV6XG49qX/4+cl2bNcAjFXq4HMH1UQxepumpXQ==
X-Received: by 2002:a17:906:4794:b0:af9:7e88:e174 with SMTP id a640c23a62f3a-afca4e6e6b9mr94000266b.12.1755081394358;
        Wed, 13 Aug 2025 03:36:34 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c08csm2392328866b.118.2025.08.13.03.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 03:36:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250731234532.12903-1-semen.protsenko@linaro.org>
References: <20250731234532.12903-1-semen.protsenko@linaro.org>
Subject: Re: [PATCH] arm64: dts: exynos: Add Ethernet node for E850-96
 board
Message-Id: <175508139304.40388.17997940621075080202.b4-ty@linaro.org>
Date: Wed, 13 Aug 2025 12:36:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 31 Jul 2025 18:45:32 -0500, Sam Protsenko wrote:
> The E850-96 board has a hard-wired LAN9514 chip which acts as a USB hub
> and Ethernet bridge. It's being discovered dynamically when the USB bus
> gets enumerated, but the corresponding Ethernet device tree node is
> still needed for the bootloader to pass the MAC address through. Add
> LAN9514 nodes as described in [1]. 'local-mac-address' property (in the
> 'ethernet' node) is used for MAC address handover from the bootloader to
> Linux.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: exynos: Add Ethernet node for E850-96 board
      (no commit info)

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


