Return-Path: <linux-kernel+bounces-837038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32959BAB23F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C970B3AB436
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DEA220687;
	Tue, 30 Sep 2025 03:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cNC7kJSJ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C972940D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759202143; cv=none; b=WV9b/LSHxTeISIzBrjohCKsuBeptyEPc8WIeaiEh/PUdWgLbm2gnMSxJkgc//Q7zIZg0y4gSYBlSWBRqcpTIA5R1q/ggdfPUKQBF7XrluKIeZnC1eCYgvxmsrvcE8sAWA+50+nuLnrmGgdDPIHmpdelVo0V0jCbzbDZezmOpqVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759202143; c=relaxed/simple;
	bh=f1mcXd8+Wda58Pe4UjO10xfHJyJf2Mdi7u1iGWV2Tdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pU+QZyBp2i16v36QmNzw5jZHYrAP0pX9+w3+GEUdqkp50NC447KyPd7Kd1TBgjTF9MJsQEFmrU5uEbiHFOayMeUkiXdpbdqPjMCBd1JrZ7Z1080tSE1Iasitrdb6+9X4I0unaGtIxMKQ7v/BhJkws55Sm0pUte1KETBURmTa+mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cNC7kJSJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-28a5b8b12a1so16566715ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759202141; x=1759806941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9VNt+2mjTk7M/315hb/0C625yS1/uUIWUcK/eJkk2E=;
        b=cNC7kJSJnvCv1QE5J/p4MBoT+/J7HvgO7fXGrhUelPMSLqwdHUOjUuqzgPeStzscy9
         ZvvQamEPg0POs++dr+Sq8CnXcavqTPv7Sr//xT/KZc6Ijx5VxfcpRk252pOxfHgDNQfK
         jPwZUo2ImgJBz3oA66HlfnVr2fIQ+gmqciW/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759202141; x=1759806941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9VNt+2mjTk7M/315hb/0C625yS1/uUIWUcK/eJkk2E=;
        b=TA01BOTf1kTRcFAeGVQVtwI15Ir4IjY3NesWRvQrvVjRxMgUR2/FZuTmZR6ESSgIT/
         TcQ71vvxpaogbQSv608pUgHtZT33L3gxejrsV3Xz5/q9mUb74CvQhvIPVUDkiBWCRkPk
         +TTmpxZ5TisyW0+6gXEx+DEIzxgKiE5Oi2I6MNr0Mo+7dt6kJHW67MlLRxKYhX/jZf/L
         pnRkOnc8soJEcSl8RapOnntNkGhTb94mqV1ERN9Vy8gpZfNxYA39DB+hid/4MJpp3ChL
         hiKTAU+q+1iE82vqZS5pjakXXDhmRi7WHLpazHGDOGWbwWZLap4cYyVW+uYYLlhEPUcl
         9S/w==
X-Forwarded-Encrypted: i=1; AJvYcCXN8oaGIzGf7ueDktZFZP0k0S2mYTXgEIIPirSmdZUq0wf/z/bHccu1QQvOpG4s1gObfSa2kOLdmBaHGqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiIhvy55Zg7QABUXg9FxMk4lkfYEKWs2UWeSgXbhqocz9OsDaR
	lSAo3gDIeqW/Z6Q6ygoWZ9yZWcdmPnruOgBHAOPs34NjHfT7S+dZfbqO31izeyUUJKEgm0Ri2RX
	0NGg=
X-Gm-Gg: ASbGncvF/zloNpSO3bOFNVdE0sVaT6DIIj89WPlPMGIzE6VBaxDSrIWubTbL9sgju5+
	ah01gKZ2R9M3LOodJIkF14uV9V9zYjmpUKajdi+BlDtQOJNWCzJol9/dwAJDhmpvsVeDj1KeYD8
	Iw10b0UgBqluyW+YAlf3K5f2su5yb5Ak/CP/ya/iKEaeIbo/GBDEnZ89XXCnRX0pOuQydoY5ueq
	mJgMER+Op8J9xgRWjFMXO66MNpq7Tle7dJfQLuMwBME7XjorA2ygYlyfz4rQrwdvRuRwGhz5B0V
	5RkNH0hbgAosU9p2XInoK2ugwzeU4T7vWFDPo3ALl3eWpf3nl+Kmq6YBBWvpGnmNjEm/0HFR8qW
	EvYppKn3DHyAnWpubkzR2w2Je2Fi3KgX42IFDtSP2ar4HzmdBwAZj5PevZNI0bCSeohoAOOZd4j
	gi1zhlrt2zJh/3/xY4ubR+qO7YJPP9tLS4c64=
X-Google-Smtp-Source: AGHT+IFgzFgU1DAxlte5671jtc0bFooc4a4ukkRyJdEDOBI/Mc0X+8MvSnutxxhl/ivawM7nFW/P9Q==
X-Received: by 2002:a17:902:cec8:b0:264:5c06:4d7b with SMTP id d9443c01a7336-27ed4aab67dmr216228075ad.32.1759202141384;
        Mon, 29 Sep 2025 20:15:41 -0700 (PDT)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com. [209.85.215.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69bb502sm142962135ad.118.2025.09.29.20.15.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 20:15:41 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b555b0fb839so3953712a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:15:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXeHAHRNSmBoucFmbe9eZEQUzfjmpI2H59jkHrkizxbmjRD/VesyxfqYH7zSLeJi2xkMU8jRlAYCo92G8c=@vger.kernel.org
X-Received: by 2002:a17:903:278e:b0:269:b2a5:8827 with SMTP id
 d9443c01a7336-27ed4a3ebf5mr154705285ad.16.1759202140267; Mon, 29 Sep 2025
 20:15:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929142455.24883-1-clamor95@gmail.com> <20250929142455.24883-9-clamor95@gmail.com>
In-Reply-To: <20250929142455.24883-9-clamor95@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 29 Sep 2025 20:15:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VO2sXssuhZyz+aKvN22xH5eButHOQgKK+qEkPT3Ug2XQ@mail.gmail.com>
X-Gm-Features: AS18NWC8gI3JaOT7-DFuGJwv3EdaIz2pXOb_FdBFJQHicmbnwrHDBbTXVpKcO4I
Message-ID: <CAD=FV=VO2sXssuhZyz+aKvN22xH5eButHOQgKK+qEkPT3Ug2XQ@mail.gmail.com>
Subject: Re: [PATCH v1 8/8] gpu/drm: panel-edp: add AUO B116XAN02.0 panel entry
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 29, 2025 at 7:25=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail.co=
m> wrote:
>
> Add an eDP panel entry for AUO B116XAN02.0 used in Lenovo IdeaPad Yoga 11
> with Tegra 3 SoC.
>
> The raw edid of the panel is:
>
> 00 ff ff ff ff ff ff 00 06 af 5c 20 00 00 00 00
> 00 16 01 04 90 1a 0e 78 02 99 85 95 55 56 92 28
> 22 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 12 1b 56 5a 50 00 19 30 30 20
> 46 00 00 90 10 00 00 18 00 00 00 0f 00 00 00 00
> 00 00 00 00 00 00 00 00 00 20 00 00 00 fe 00 41
> 55 4f 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
> 00 42 31 31 36 58 41 4e 30 32 2e 30 20 0a 00 f1
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

