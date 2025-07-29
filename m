Return-Path: <linux-kernel+bounces-749613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D03AB15088
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644BC3B560B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8420E2980A3;
	Tue, 29 Jul 2025 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AKCuPBJS"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921A3296153
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804541; cv=none; b=PZAEz8AN+ok4BRtNeLrRJW2ydUjOeSjtGcQak4gbNI3HF2YUHu4wrbhgSa5Jn8XBBklMnBzPPsP8sb8UxrY0+7B8gHy0tUHwdSOM5iBNqdK4DSu0b0sNQQ4VIz3U0Pi1jkHHgqqjX0MjkaYstDaRZzhYq5KAYjgJ3KGQalH1cIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804541; c=relaxed/simple;
	bh=zCssDT2BlR2ddGZ/s6nI3zWZcFEmq3mkKYK5ppXgMLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhYjRSC6wWsde8eb+spjrAPpXTP++feDa/3ju0AanH1MH4SDT/S4CXUOQiowIuhIQBxokz2QUL8kQAPGwGz7K7/rFoF+dnIsNg6pprsNs4RoSap8ee7oG2hJg64VdCdyiUUwpSpoAUPES89ez3RfhG5BRA1YoumWG9trlBvT+yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AKCuPBJS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23fe2be6061so249965ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753804535; x=1754409335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELxIfhrJzM9gjDNT6LfSal3ycdHCOt4AXjIO7oTLtoU=;
        b=AKCuPBJSp81ezn/K3Hq8yLTTCeaQmoqbrl9mYynPfsV9EyzwB3Tya7l9sVTU2mlqzI
         B7I9PKbx6X/0sWpjVf+fU2i1Ie4PLcLWaf8+N+u8SSGs4bJeZFzsOV7Kbk92uSRFckdO
         U13fY/0ttBDcElAkewkK9uzDhk/kGP+BXXLyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753804535; x=1754409335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELxIfhrJzM9gjDNT6LfSal3ycdHCOt4AXjIO7oTLtoU=;
        b=rCDI6YUOkTGPjuri+Iau4K+t/MuJQg5lOXytNZevNsDQLGu8voqyXXZl5bDEPI4P2D
         cp9M896QccRVWFumm77tn2SXldXb2UisREFywVPmYvMvoMmvQvWqJ9n55sldZo71RAhP
         GJHGeAcnIfFtzD1hCIbU4WbUHBe8thNp2pqNCfjkFcqpNtcApphAoWy4l2mnJkWH3iXI
         ud7ZQPOy3/dr/UvcBmVzV1aINoQ3Kkz9PpbVa+k8b/KwHMzM2GGI70IGaTvX6VYWl/Dm
         3fsh1h2020J3PNysBF0Y/GOStbLpwnhtD2s0X7iIeKgCgANJcvN9UGafaA01xd4otp0d
         536g==
X-Forwarded-Encrypted: i=1; AJvYcCV5sTx2zj66+s9JTjR6Rdk0/yHKInqjsy9ml7ky6/V/+TgvJIf18kLOT8jqB2HVySHqXdMeJOA8a7wHCF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcmw3A/QGOUc8e1IqjaJPRiEbANanVDT2rUR3rX6j/KfPJWB4Q
	sSa6nYLEStI8TaDiSpcJH18zrt8x/8xSff5jEu1Ma6LVfPYjb+h69IVv9k3hbCmqTG3zlI33nVO
	xsWY=
X-Gm-Gg: ASbGncsevrgHrY2zZBA+GtnfkziVERqJvBeczxbJYcPUYZ7YqD0LIfXLWgXUm0Foz/S
	51PSAAVZoKF3nf1HUu/lTjTd+7PNkMb2Xww5vOnbj46CkpyQ7+QY9HxytjScXEEAvv+1VsySXzy
	N8WDTgmLcv9Ao1jtIIt9cJsmOo3mDuflvhmn19E12dqUFEr1tIfe7knRjmIzW0EkzS/gK9MzAe6
	mdPRVFN4Ja4/mWMv6X4pY13ox/ixDJdDcqtPZW7Ga3noM32YkxiyVVuywFDV7AsS5Td8dWbZkID
	Mv2SiuKjG0mSdyZX7G47D31BlOJMylgS8DVAyLwNy8RjPFHKysGQCncKvF0chxFmpA1pXqXEKk9
	mRBWiyLRgxr7s6NebCYr9WDwbrNqmvIddWQvg/PI6ajiM908TOan14lJwsDqhGQ==
X-Google-Smtp-Source: AGHT+IGI1bWrXALi8mCc6uvsttWoDF+7WgYCAUkKZHDT7/KfBCp+qKkBb1w26jY2fbMorDyT/vPFLw==
X-Received: by 2002:a17:903:298b:b0:23f:fa47:f933 with SMTP id d9443c01a7336-24063cd35b2mr57900195ad.8.1753804534429;
        Tue, 29 Jul 2025 08:55:34 -0700 (PDT)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com. [209.85.216.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31ee4b231c8sm5521867a91.31.2025.07.29.08.55.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 08:55:32 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31efefd2655so22795a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:55:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5j1SZBE6mOE+Yy6Sufil2Tihz4ap0MLEkkLdSaTrlMxmjCO3pb1qERSxRXdYeOG0+8973PO65CmXvorY=@vger.kernel.org
X-Received: by 2002:a17:90b:3a8a:b0:31e:b772:dfcb with SMTP id
 98e67ed59e1d1-31f28cdb992mr5501419a91.10.1753804531722; Tue, 29 Jul 2025
 08:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728-topic-chrome_dt_fixup-v1-1-1fc38a95d5ea@oss.qualcomm.com>
In-Reply-To: <20250728-topic-chrome_dt_fixup-v1-1-1fc38a95d5ea@oss.qualcomm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 29 Jul 2025 08:55:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W-OkZMJCr2Dm1_z1qXaX8sJnX=LhRjXVZqMZNnYHna-g@mail.gmail.com>
X-Gm-Features: Ac12FXwhvU-MKljZvKjMKht93COeT38n82UujnqslPAoyz1yCqEzHnCwfYmzaX0
Message-ID: <CAD=FV=W-OkZMJCr2Dm1_z1qXaX8sJnX=LhRjXVZqMZNnYHna-g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280-chrome-common: Remove duplicate node
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 28, 2025 at 2:34=E2=80=AFAM 'Konrad Dybcio' via
cros-qcom-dts-watchers <cros-qcom-dts-watchers@chromium.org> wrote:
>
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> sc7280.dtsi already includes the very same definition (bar 'memory@'
> vs 'video@', which doesn't matter). Remove the duplicate to fix a lot
> of dtbs W=3D1 warning instances (unique_unit_address_if_enabled).
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 5 -----
>  1 file changed, 5 deletions(-)

Seems reasonable to me:

Acked-by: Douglas Anderson <dianders@chromium.org>

