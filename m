Return-Path: <linux-kernel+bounces-892793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57616C45D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5A904EB5F0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42B1288C20;
	Mon, 10 Nov 2025 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+2ybnZ1"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F044267B15
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769384; cv=none; b=dPtL0nd1mffidGobDOkO5xCH+QlxsSyQGQLjnzWJmm0j56WR3Fbiq/L53XXSuDzzEWT7HKEIsojc39G1LJFNsdkuVfvkrQumm1AzGZJnzgNZwOSeMLxScTdj9ahbpRDLl5smWQBaolkabHizJotxYMDS58NosHbxbobsuXjH5AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769384; c=relaxed/simple;
	bh=tDhf8qixrDvFldi5/wrQHvvbq/Y7Dz2jnieCvqBR5hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ca9Kak6rykOkU8x7Jx/g4LK+prgbkjSm1tOdS8a0H2Q+imdsq+QfkLdCBRJVLO32L3Cr02pRHiSilzLFk26yvXCKtqmAN6DolBbN/8EKS1bD3c0/hhMKKo7qcT+nCTkahJ7FMFjHdxZWxUcRCe59E/ZRKH96CDtP2BwTfUhoavY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j+2ybnZ1; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-594476f218fso2017822e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762769381; x=1763374181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDhf8qixrDvFldi5/wrQHvvbq/Y7Dz2jnieCvqBR5hg=;
        b=j+2ybnZ1I86i8SvXdiHb9YpvHS0baO0DllnCHI2/YHXyM6N/OyODyLVtZY299lmAoK
         6TETXDVrhjrZ+TL6+k7GjVMiPF5gD3RptoH5dG7r8Zmxcvauv12mAG5Foowb5e+wRXRa
         IyaHgaAZkKiZ4KT2io0lDcwtanQN3mBL8VkuYQeEZvk/oTTY7CDpaaL0qlgEoRITYh5X
         trj6e4gE+KltwVxcyZyl2lgKcSpt+K1CzKcx8+R7k85aqtfhs8z7tQlDJK3k8fEjoQZP
         JvIr9m+2O3DD3pPDLQ+ZwcRDFKhzQllIeR2OXrR+/oiKROz4RvID4cvupqJxrw1JXTFm
         EGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762769381; x=1763374181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tDhf8qixrDvFldi5/wrQHvvbq/Y7Dz2jnieCvqBR5hg=;
        b=JTD36V/tbs4hzw5VX/2BOdHy1qssIhDql22wF/NXk75pHoPRTQU9KPdFZaxKVm59w0
         /XyP8OM3y4/v03dc8KJZPqG1CD/scNQd63VmeUB+kiO9Fl0z5JjDtMEHTB/ShpEukEXA
         U28Z3nVWWiauc1DIZcQ3zLqzYrt09AjaZvn/nn7gDjemj1JGN+HYfMfrMZTdsVnf3BS4
         LUL6ywiIyUv0xxJKhLJIjXFc8r5DG/eGhj/+ZN1cgI0lUtgxlnse7FKIZv4ISzz2JPoD
         dOaTp2Ch03qwXHz6w3OKfHC+GNppmDHITLxRDY5QqQlBqVxzH0fJQ6p+yyBdl/R6OnMy
         aidQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl+RUCyRG0L+VqI1m0Hk53l81Fjl6vQHM52y1iGLM9BrBT8p9mIzND2qLg2r4UhQ0NuP7iSLM+f3k3Nik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx74qwpQAf1IR3356evemENiuZreiRQqaHSwE2HVJuRTcScz7Fe
	zEf6KB9SbvZgZ20KHbQMlZEzhdEWatoV4GW/fJ9fKUXeZz+y3E8KaFBrcByguobxDprD8U6VQyU
	cQcHznyUC0p3fU9FRtlczlxelAWEczY19WPhOml4wJw==
X-Gm-Gg: ASbGncsh8hdrrHWdtsEZfVcdnai7lTYEZ3pLLJLJZDxMFHca2NI66YEqQVlc6OsWL8q
	OyodjshmwVJXSgXOp7qk0BIB1jQ5DYgt+z7Xeqxr4Zq+OhWZLtS2XDogDLsJ1EkoHK5i1BEfAS5
	lWZ7Ob9s5DOV3FuYrEyqyAhQleYJ04wPw0O70GxbIuuqsizkomDCBh3sTEAUvuvw0ZG1DJLNljL
	7bHFipXJ+/ZkbG9kFmFp+f/p48Lee+XcJKFecULqRLAokx6l9BtedIz3BYvgTqJG1cmhw4=
X-Google-Smtp-Source: AGHT+IFGPVnaDRtv2gClXSnX0sH/hU/2tQYDsgz3FSsDzfiozT/9TYr3cARpl9kJdemTQgStsHfELCywzdcTfbAOhKg=
X-Received: by 2002:a05:6512:1325:b0:594:4ef9:41f1 with SMTP id
 2adb3069b0e04-5945f1db816mr2146235e87.47.1762769380663; Mon, 10 Nov 2025
 02:09:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027212642.1710144-2-robh@kernel.org>
In-Reply-To: <20251027212642.1710144-2-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 10 Nov 2025 11:09:27 +0100
X-Gm-Features: AWmQ_blogvQPPAETGlrOkDS77tME5aB-9Sv0mNqgOJbiE_S-LtUsi9rfJh-GT20
Message-ID: <CACRpkdZTVaBeSPOFcVAwB1avUK21ftRrLGM=0bkBjvxOfo=XsA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: Convert sprd,sc9860-pinctrl to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 10:27=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org=
> wrote:

> Convert the sprd,sc9860-pinctrl binding to DT schema format. What's
> valid for the the sleep mode child nodes wasn't well defined. The schema
> is based on the example (as there's no .dts with pin states) and the
> driver's register definitions.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Patch applied!

> With this, all the pinctrl bindings used on arm64 are converted!

Time to celebrate!!

Yours,
Linus Walleij

