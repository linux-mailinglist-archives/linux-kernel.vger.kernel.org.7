Return-Path: <linux-kernel+bounces-844735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3BCBC2A06
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 22:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C683C69E4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 20:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922FE238D49;
	Tue,  7 Oct 2025 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RcGQHjzb"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680F91DE4C2
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759868460; cv=none; b=DRhKmJh+pxOLuODdgpPJo8Rs2J3fe3rJILDgSm/JBKvDWpJGF9cn4q4Q8qTWkJCkC/XwpEeM3Oewe1I10n47p6cO+H7IBkW+/+3FGaBdClE4dE4CIKyaVWQAKh1jXk+DUWouxOfcEMMgfBaKnwndZ1pIM6OvAlYLDmnxKrb/Ibw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759868460; c=relaxed/simple;
	bh=y/TWEe/aEhKr6s5KMRouLoYYcgI2epSiBagA6I5SO6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1Iyv5xRQ5QoW8xLLEaOKP2sBDGoxNaUNlkzoWu/8Uv5MEYCCccYHHLEe6rA8HT+c7PC730aH5UHwsm9h5Z36eJEkqSlDMb8DVWej+YclpLDpWX4nKzeWxTtAJB7VJc1W2VvIPGweDIhgarUsdIXsPdBDonyDNRXn2BqcodXEj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RcGQHjzb; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-63f03676bdcso1718237eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 13:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759868457; x=1760473257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/TWEe/aEhKr6s5KMRouLoYYcgI2epSiBagA6I5SO6E=;
        b=RcGQHjzbAGRrHPJEr+DWLdnoU2rfxNB/1+f3jUIU18Wqm2hO8HXSWKM+968sr974mI
         3AqSI36AL+0qpZJk4af5xGb6D5Ualc7Z/184RZO1wKK2PBy4q/AZA+dYeSlVzVRUi4bE
         8K+Wjz32+OoqjvYLmNlbFWlZ8l1pfb2J9B9/l564MgZNB+onHkDww4gyk5uIG4yYL6Nz
         15llv5nLVFN5J6pebfOFyq6jFrLKHiJATlW5NzHcc2JNmHx7fd4FEdJiJn0lLXiD9yLM
         QkT+bRjKQjSXpa+eJUNFj0eD7jZknplgpJT1boL9SV2twmRFJ9Fo1SRs2bdUC6rBlpNC
         wkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759868457; x=1760473257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/TWEe/aEhKr6s5KMRouLoYYcgI2epSiBagA6I5SO6E=;
        b=r+kWHAhn9EAQZNahmh+tvXXhwW4cjwNaNhZG6TK9I9KVQwMC4VKSNOo5eewNFTwdDG
         E0A4DDp+91gjGbDnGVWFPTKSilr0ac++TrB/nUGOpL6Zyd6d7SQSf+gK+FDNaMA/JRF5
         qXz2JLHSlZwFZi6+413coqqqf0IPMlXJr0hDMMI3HMXOeJRUv53C/SO3E5uIsXNBjbvu
         yHf90yAcYaBbsePcJ3VJTZrjml7ws86WkFF/ZxTGFt4fFH2daUv+yyzCGg7bTkPoNHwf
         fPWOSjmqKLng/CmbKsAOL11zvpapFJInllk59xYgm7Nfs5ZVFTzlfcx7hcWYPOcqBkaQ
         aI/g==
X-Forwarded-Encrypted: i=1; AJvYcCUMY4+VwSHJLAEhsU7kcAsCrNzMSU/+zEy6yLjnGliHeh4OgeciIUBxST+m56eGnE5VMuGBxOcoqcbVCjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMGaMtZ0Kz5oIU6jXn3NPCP1hLL4YWsNI1Xgjggr+DfHSB2fly
	08sTHEVEIWXdXx81BvFBUs2dIDoAU1UIy/hWlh/+7Ti6l9iAOo/GVk4AH/jDz5ECOHfXMk1iQ2s
	WQT3azkWWOTUKQWIS7G5MiQYMEDV1PvT6PvCb0LzU1Q==
X-Gm-Gg: ASbGncv2CSaUr9Yq8TGPWQdUBSl0N9k/L++q0B6XVlXsNBRjSKA3nQ8oEbDWNdKKgHd
	9fejvBrkbXDk25MHZnP3Tkcwz/gnEclFSzLsRU8bFtQoKdG66ugYIATVdF6a1MIH17Qwue4WTnC
	1mK9khi908W/Z2EPDXqlwUk+qk+pqvAaLtdCW56ofBQhCgLM86P5GrxywEpVhHsukHRaEnNHbXJ
	9JwEZ1N0wMCwB5BMIJ7hU/aerGB2pVkOv/6Gg==
X-Google-Smtp-Source: AGHT+IEyLeFs/tZrPpe8u5cykgOumU9CrjJh4fjO1Ik2uE9eU8H/ZkZq/fUMlKIiW99d1ig/gW3IYGMToD+2pUB6yiA=
X-Received: by 2002:a05:6820:4a14:b0:622:1a4c:ca84 with SMTP id
 006d021491bc7-64fffe46c1amr372637eaf.3.1759868457494; Tue, 07 Oct 2025
 13:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-power-domains-scsi-ufs-dt-bindings-exynos-v1-1-1acfa81a887a@linaro.org>
In-Reply-To: <20251007-power-domains-scsi-ufs-dt-bindings-exynos-v1-1-1acfa81a887a@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 7 Oct 2025 21:20:46 +0100
X-Gm-Features: AS18NWBXzhclL12SN8KyOZlv89Zez5Qwco0h5Y-fiwtfj-_OtAAbqpmFxHR3Ve4
Message-ID: <CADrjBPo5F9H3BbxBBQmwmDUFnzibnH4hNkYMPTknOn8ZHH_Mwg@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: dt-bindings: exynos: add power-domains
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-scsi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Oct 2025 at 16:56, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> The UFS controller can be part of a power domain, so we need to allow
> the relevant property 'power-domains'.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

