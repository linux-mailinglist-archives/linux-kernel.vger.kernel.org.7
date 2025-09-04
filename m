Return-Path: <linux-kernel+bounces-801548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBD0B44678
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44079169F4C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04BC26F445;
	Thu,  4 Sep 2025 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lpQzrJpv"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B78024A06D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014458; cv=none; b=I8vDeYX7ZZBgGGNdiCBbf3VhKRweTuiU+mkLSGR5NZqW5TJTzzIiWLDhtApL+b8q1rpk2S6RN5ZXemm6v88uvR2WtUpkphWalQBSqWfi6pCgISf/93isb6QpVYtcPgPzreYyFWHLUTTOYCsjGiC7Q72PVF4opd0bWIXWPss9JAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014458; c=relaxed/simple;
	bh=clPjNzrRlrR9W8iK7IsCzqluvKE3yxrC0Jr2QIzTItE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsyRShK9nxTVKq9+6rukGg0b/NLvac5K//QWVxihB7G6zJa95MxDw0WswFgYAK9EU4lNCKFh5Be9724n0lwa7e6tpc2SuBl9lSy6xILfW5sS1rBVv6kyYCBBpLlbdqa7L3m0fubHO3p3YP5JLMkCKJ1T2gbG2yiA46kON5QoyRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lpQzrJpv; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3380787b30eso12947581fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 12:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757014454; x=1757619254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clPjNzrRlrR9W8iK7IsCzqluvKE3yxrC0Jr2QIzTItE=;
        b=lpQzrJpv5R031VqsaxozYtelK2+fHPlPiWcr/M/NY9bFP9+cIsIQHAEgK/97S8yS/F
         8pHAUUSAzNNelLpjKTYwELxGCiJ29kN3acRlAePIGwKh2yVC3t7LSQ2Qf4cxG70J7yzP
         lFGnuS0ji6C6mTd1QqrKoevzxgsdfhC98Q9DG9gt1uOFZ7ugk9EpxjvB89kOq7DJx2sz
         CQk71nq/uoajVuakD0UUM9ccBBNxNNO8OLJUE3Dqr64aOZIpuQ5H+ZLh6or1rMZCYugY
         5dgvNcLbOgdqsaB1BMT2Zxk744RJLWN6aepQGffHXT3S8isKQtJv7xIXOpbZtMsTzI2V
         fRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757014454; x=1757619254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clPjNzrRlrR9W8iK7IsCzqluvKE3yxrC0Jr2QIzTItE=;
        b=YVsg7NxAfH8DCspkJWsEP8RwogoL6swAKS0u9xhCMjtSegtRDw2Q9EcE3x3LuG6Eem
         C3w4yek2mrTx2ytSpVChW/tqnuGF2FlnWZsCToNOUNKoPcNK8I6YnLgV6NVeLtsqzbku
         K+t+DNlWV1777eJyX2oNVjs/xg2A+0zBtYKwYDtXKLAmKTF+OjbIdo5pBkn2Eww9DfHc
         j0sRNKJXiCYiUdYgZxwV/KZSdm+di7dyTuOU44cHDhhzVhnGUZiB8KcXgzQ60Qk+gBW+
         a1ZToPooRiV0cIjXwf8jn56vmM6KBZ0/wS5fF7ggX3fV1KQuFDOiHGCozVXzvjzVSGaW
         vIuA==
X-Forwarded-Encrypted: i=1; AJvYcCV5+u088z2PIWpnSEaMxj5nSXcEhpNuyCOhz7ykx7Dm5BCnwmt3G+JNyT5UIWsYnR5ZwjDm0FNB7mBNiZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk39FM5tRxyk6TX4MMZUEdEI2mMdjPbPPO9a2IOkUrWHNVXhCv
	THkeXU/8pcEFLXD94JCt63eBf7mT+tAuMQayTVp0fllsKl8P7LuV3bKMnq0gCyrmyXAUr3a3I6Z
	e/8jQ0ZFw2GpEo/VRlM0fSd119cwlj+Xns9xy2cuGCw==
X-Gm-Gg: ASbGncvpO/Jt12LLF/wGdpAZSaoRMiSia1RCX+hEy/zQ/zn+M2reamG2Bocn30hFjcw
	8bpc4FWO35fHbb0mRKwM9AyKANZR0T7kM0uupOYya+dNUzRNCU1SfgePaSbSKVq4Jj0AYL17f0k
	fxzrYHnlHUNUOSQk5oIQYawf9SfuJs8+vcT735K5es3QI/2EeBPLVqkgXjbBf0Glt0mlDI0VR3x
	ALHwcdIGGq3qOwlvA==
X-Google-Smtp-Source: AGHT+IEM7jhXKP31Q5ndk+KiHK48PfI3HF/sr3X8hFMQjwNo5zeLcG5ihiQY4yJX8VctkDHZ0/XvKBh/j6C82Ua3sDc=
X-Received: by 2002:a05:651c:19a3:b0:336:72e1:7f45 with SMTP id
 38308e7fff4ca-336caae1d45mr49522041fa.24.1757014453579; Thu, 04 Sep 2025
 12:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813065533.3959018-1-pankaj.patil@oss.qualcomm.com>
 <20250813065533.3959018-3-pankaj.patil@oss.qualcomm.com> <vxd4gr6hcbv3wmgbo3phhwserinub6y5o2dhkoaheofbwphaz7@3mkfwswaukeh>
 <9be4695b-54eb-461a-9e59-81670089ff38@oss.qualcomm.com>
In-Reply-To: <9be4695b-54eb-461a-9e59-81670089ff38@oss.qualcomm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Sep 2025 21:34:02 +0200
X-Gm-Features: Ac12FXxoMfMgKe3bppQxjm3t8wtzMbd4lxjj0GXJNQiFFIQLEQle8aSsfY7NR58
Message-ID: <CACRpkdawjL1CKy776Ya_tZJaurmxRVqx98DGSUZjUWZe=Gdrcw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] pinctrl: qcom: Add glymur pinctrl driver
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	rajendra.nayak@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:53=E2=80=AFAM Pankaj Patil
<pankaj.patil@oss.qualcomm.com> wrote:

> This patch was not pulled in linux-next,
> commit- 9a1d01fbf43f56a02026eee44181f70108a0dec8

No you said you would do changes to 1/2 so I have not applied it,
waiting for v6.

> Does this need a rebase?

Maybe, then use my "devel" branch.

Pick up any ACKs and Review tags please!

Yours,
Linus Walleij

