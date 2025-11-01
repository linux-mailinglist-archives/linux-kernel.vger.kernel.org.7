Return-Path: <linux-kernel+bounces-881601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76788C2888F
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 00:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C6F1895F8D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 23:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3706220F3E;
	Sat,  1 Nov 2025 23:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0PZvVRA"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D1C1D54E2
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 23:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762039315; cv=none; b=lvUTymabXjxCrfR9SSz2uK0wH5uT8vY+gGoR441ABWXMLTn+IkzKwzKqvRYindHAhvsE2aDSpa/gZtVlcPC3Ut6XbXsqnheO29PCy3InJisLDpBKHE9JK+HPN9uS81FvzjxTf0lb2JwuyF6ih16E51jH7X72a1dbXj9syA9YvFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762039315; c=relaxed/simple;
	bh=Ih48fCgGxmcDC+rq9KAGCQ12b/6J7vEnVTVpSk2fSik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMmt00pEeB/t2lqq12hQPtsS9soOQRNPyF/b6yGeuUDdKnK3tn51kkv2yvRFHnI2kDNJQO/SirsnwfrHt3p4sRe3nfk6tnZX5weJ80ewN4g0/RtbmafWVmxj5v0XKLCyWH4h/40NZyQ5Jp6Vt4mA4ieEAawf6o4zutm3qQ94lJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0PZvVRA; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-592fb80c2faso4251106e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 16:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762039312; x=1762644112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tE6bLmNTkidBdeLhF+rPCfURMSNj/Z7BnksFHtpAFII=;
        b=U0PZvVRAaJghF9lBb+PWMgbKUg7C2NPU8N48ATqvPgt1KO3LekxPewU5fRWylIN631
         gQJ44UW3qe33Fyr74FW6h3owIj4pBa9uo59teMSPHfE8av/nyKL0m2kFHNrO5vaeD2PV
         e+jTaLeF+rNeWD18/OWkU0SKk/kAGBBI10Z8x1E35jnCuieoL8rhlfypbGZkTxGUR302
         HQ0dchYajVVl4AVYqjU+E5PU4PRNXrUZTzI15ZyVK1viX+OkZcpOL/czbHrQaKnJamiv
         DAmqH2TezMU9p3MG01nWbVKXpmdZ0XbVfwZwdrIYnih/kiIyX1norjXPsURzmTCEpdIM
         sobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762039312; x=1762644112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tE6bLmNTkidBdeLhF+rPCfURMSNj/Z7BnksFHtpAFII=;
        b=MXVg7NU4uXcEc1gPLR/X5l+ZFXVRCvwSPrr/nD6T2V18Nyk/M6nsQaPJjo59as8QR/
         NiMEWhtTOdhXdUbkdSyAAPP+e6PiGXrqSS+HIA6bbk7KyPar+fBxH4eAndmSrvtc/otg
         FJFlRkBeybgiCd8Vf52WWjUuUBvNoiMchNNwAtvBMgiiDbeK9cLLY+o1imbfjTlDr+ei
         3HeBY/KGK2MJluq6gSR84VdVVNyv6BKmC6aAU+hypOg7iPK3lim5K9jNA00N2ARHQ5Zt
         14mwJy09fBzYflIJqqyNr3UOm5IVfhIICsJo9l5QR7Y6rXyR8FQua5PdqF0ue4/2KQt9
         xMmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhkKiwjEh2DKTGoSo+Dn3RkEs+N5a/y8ySnsFrXogLqO6dtC6OsQT4sdpEmytdAfoKYia7c48eFvsvY1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbBSxO8ochCRbq8XXFdQqlR51yxpcgpDJoFcioCVq2m40NmEZL
	DhKOVh55uOhIw3BOhIE6NAwVshC05LpSgLYTjBAcJC8WvL3tVwptDqT2i6P6+iVgPNxVZw6NuKO
	UjB1e68jAROHDSVOixKqWZLvPHQfjlWw=
X-Gm-Gg: ASbGnctW4srjV9ZrWyakRb47sYU7TTfWcQM/LFdAwruDWc4TQyjU4JOEh42HaBLQaYs
	SjDl2k/sNC4mTdEJtFKgMZbkN8P0EtUHWvS4zbYvjUjukBCT1TCUt+e7O4LH+HumPusJLWJ7R7Q
	ygZQ4u69+qyqC8hwkiW7YQ4ThBr5/Gi01d/mryHshJizn5YHgsOhi50X6J/IqwiLK+4c/3m6TMG
	KRwwGvb7ptDuD55+VdG+8VnyPaNDghfzV2WZzSlIwlJf2ChlgVMLIx7f7K1Oo0h+8DX3Vc=
X-Google-Smtp-Source: AGHT+IEvPRmi56xA8VSlKhoU4qy0ZWuJI01gXXRCxfZUpYfce2ybmegTH3BGaEdGz4/nTwnns4xZ4vmoZY61Tko8f6Q=
X-Received: by 2002:a05:6512:6ca:b0:571:8fad:ecee with SMTP id
 2adb3069b0e04-5941d50d172mr2275685e87.21.1762039311783; Sat, 01 Nov 2025
 16:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-tegra186-icc-p3-v3-0-68184ee8a89c@gmail.com>
In-Reply-To: <20251021-tegra186-icc-p3-v3-0-68184ee8a89c@gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Sat, 1 Nov 2025 18:21:40 -0500
X-Gm-Features: AWmQ_bmZzHSXWhAY2pY6BRtjObw17AvJtuzUsKcg8jYHF9w1YWeOmRl20FG9z7g
Message-ID: <CALHNRZ-uFJhMjyyV1vUS6ye3q-nNVPT7Ab4vuO41ziHqg8MOvA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] arm64: tegra: Add CPU OPP tables for Tegra186/Tegra194
To: webgeek1234@gmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 8:13=E2=80=AFPM Aaron Kling via B4 Relay
<devnull+webgeek1234.gmail.com@kernel.org> wrote:
>
> Bindings Dependencies:
> - https://lore.kernel.org/r/20251021-tegra186-icc-p2-v3-0-1a50b526dd40@gm=
ail.com
>
> Logical Dependencies:
> - https://lore.kernel.org/r/20251021-tegra186-icc-p1-v3-1-7e6db3b070c4@gm=
ail.com
>
> Merge Strategy:
> - Merge all patches only after all dependencies are picked up
>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
> Changes in v3:
> - Split series
> - Link to v2: https://lore.kernel.org/r/20250909-tegra186-icc-v2-0-094137=
24e781@gmail.com
>
> Changes in v2:
> - Use opp scoped free in patch 3
> - Cleanup as requested in patch 3
> - Move patch 3 to the start of the series to keep subsystems grouped
> - Link to v1: https://lore.kernel.org/r/20250831-tegra186-icc-v1-0-607ddc=
53b507@gmail.com
>
> ---
> Aaron Kling (2):
>       arm64: tegra: Add CPU OPP tables for Tegra186
>       arm64: tegra: Add CPU OPP tables for Tegra194
>
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 317 +++++++++++++++
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 636 +++++++++++++++++++++++++=
++++++
>  2 files changed, 953 insertions(+)
> ---
> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
> change-id: 20251021-tegra186-icc-p3-3f6454da5ec4
>
> Best regards,
> --
> Aaron Kling <webgeek1234@gmail.com>
>
>
All dependencies have been picked up, unblocking this.

Aaron

