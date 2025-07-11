Return-Path: <linux-kernel+bounces-728091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECFAB02398
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBE35A0530
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE892F271F;
	Fri, 11 Jul 2025 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J9ZQpNgQ"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6470615687D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258409; cv=none; b=T9n9VOyhRRGSyCXUspaaY/lnfbylwYsfQwhq9p/CBNviR0QMcPWJBn+DIQ8aLdYwCT9Wn3C3vXhyi3V5JiIjmzPlXDOQNCBtaetG0fhjSZ+87/GZUw5RV8uMEX25Rd1Uzy6BWNP8WfgT9UR4qI1ZiSNe+7Pz2maXOn+LXbE/1Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258409; c=relaxed/simple;
	bh=su517mkk+oxzFqk3UP0BekUx1TUAeS3VlwMBUTxhr1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=badT7oflj4BTHbvnwMPUzvQIqWsnh881aLEkqjJeQK0DhG151Ry3GM9UIJYE3p0DCFGJVJPpeGgxKZfTbS50VIqCRcwfcMsT4n9aVvz50mcqQplXcCciDnUaVu8KKyLiKOk/S6C+O5Ciol7RcUNdp+8aJiNTStbbUU04ZUO0dR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J9ZQpNgQ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-558facbc19cso1973661e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752258406; x=1752863206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=su517mkk+oxzFqk3UP0BekUx1TUAeS3VlwMBUTxhr1Q=;
        b=J9ZQpNgQAtAbEjB0+/XpvKMHMa5y2yOfDmprEzkl0/qsPH3CfQrTAXr6Np7Xb870j9
         zREf516urqki4bA8vb9SJzJv1fRnnOG6pNnzCSL/Ff84DmLRdBY5f20VBz5/2xptMo9J
         jLPhH4OjJkuqhfVSK+AJylqH4zptq0mzbEzD1MuWtpel4evb6mn9X8Rv2rEXZzwwmY6k
         7gesmyTAqPaSCnP+KL/9s7vTUnQhuWXe/GiVa9u5dZg7C2KCrxnNi3U4KhIDXknnhOZv
         FCMT1V3WuBdMIt24NvEcNtr+tOW7qUQiVBpz7QMRFYYlb538QozqmKm3Jf0QKUHWEGMv
         gVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752258406; x=1752863206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=su517mkk+oxzFqk3UP0BekUx1TUAeS3VlwMBUTxhr1Q=;
        b=Ho2FtEfPfZY0pxTXDrSBSIEDNtY7yYrq2Aat2kffR8wlvP06jJb4C4kJhM7ZX1QOeM
         cZEKo4fnJb+0uV9dLUI3vO+521DwlG+PJDVBmDFmmevyVj6ArfFLLxaZjP7Tt8ALRJMH
         tCbIE4nZkHdQf18TKyFkvq0llSehnDNhJvoBEUDnIBkkTdJZI6ZkkFV7uYrdW8CVi7um
         mgg7Deh7Km2V+qCa7pgUEDmxRfZ7Nlc7S4qSmlOVNmrDL82gwEw4XCsmhYXFnvtQEvJb
         J5ARSdcCFsBFjKEwXogy52kMdKNs5ihpfd0ECBGQgsYg/LEf5nej8hJjAWwepIvzHK7y
         Aicw==
X-Forwarded-Encrypted: i=1; AJvYcCWp0s38WaSAaym12Wp5/LKoE3L69/+NgDIQPU0BTaSP0B2Ah6vps15jGUgJSCkv+M/9fFSc9Chf6jeBNDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoPLKkr4Z7kai0NgbTyv/X9nCaqD2+03an9J666hLKVK8Ve8R6
	QsDjhTNlsxLng7Cei7/hp1gXlAEvAS5ZmrJzKLgVsqEYeS+3rf6WIFMYPq+MwSCC4i2i/kB2bSB
	N0+N9hU6itZXJhqkXJ6siuM6t8YLmJdzF0CmNXVOfUw==
X-Gm-Gg: ASbGncvvG7fx0S1qBnFrSrew1aWu3vRgNQqvQUwZAcCXVjvrt5DZHWYiyw/8ZhqhlFl
	KiIMRLxmeQqF7z8ggDsYD1DTw47YcxqtKqVFjeTyVSf3aWYlNlQwCpuK2acDUJMiFdSQoMMmEUE
	Mky4S0BKcV05r3eMlOHr+4u2rfndZNo00EHcMNvJ1QBvHQUhX3mEFP1jbZzHxKDldE6WuGDrE12
	Tza+X0=
X-Google-Smtp-Source: AGHT+IG/MoMOERMcdwRe0u2MCnKNH5c6G0Ju9EQCtJSlh1jp+ka6aa2/4j15Ntd51i+P9QmOojm9ELTDBk2mPF4JmWM=
X-Received: by 2002:a05:6512:3a89:b0:553:2ee0:7728 with SMTP id
 2adb3069b0e04-55a043e9350mr1420176e87.0.1752258405544; Fri, 11 Jul 2025
 11:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702-sm7635-pinctrl-v2-0-c138624b9924@fairphone.com>
In-Reply-To: <20250702-sm7635-pinctrl-v2-0-c138624b9924@fairphone.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jul 2025 20:26:34 +0200
X-Gm-Features: Ac12FXzxbq3zhEMygG1ywvm57ienmlxEOsz-4IQUAfbc1IiUJliLFPebYAlPvr8
Message-ID: <CACRpkda8+veE-qQdQf=LMFO_URiUAiFvkc2QCbJBQizqyg37Eg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add pinctrl driver for Milos (SM7635)
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 5:56=E2=80=AFPM Luca Weiss <luca.weiss@fairphone.com=
> wrote:

> Document and add the pinctrl driver for the Milos SoC.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Patches applied! Good work on this Luca.

Yours,
Linus Walleij

