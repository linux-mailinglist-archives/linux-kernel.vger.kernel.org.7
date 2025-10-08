Return-Path: <linux-kernel+bounces-845991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C1DBC6A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 23:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F60405EF6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 21:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CD7274B5C;
	Wed,  8 Oct 2025 21:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dw6HdBno"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9F823D297
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759958323; cv=none; b=sKhjoqoOWdHeGkKtmtaA6meKsrpfHx32ZzOiol5gdBeue51CXMsqwgEb/1/Slkvix0Ar3J6EZcX3tr77WCUIhHVTg9Wz4UEQJIurR2TbVVcbRMmP4Y9BAp8PgHZf+CUX3Te684OJQibNX8+19swJqFKT24GaJWCNUozQYSecX9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759958323; c=relaxed/simple;
	bh=hZ8KM21uCwat8g+u/QrX7yrwt7duhcZgFx8yHhxTBh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvV7Fl7M3QKUJVgbxc4T63AegUgCJ/K+8nIroTF67x7n32BKz8YJq4pvnvRKGScufmwYXhul098PGK4Tj6B4koFcv0Y1U1M02mG/2yCLhNoRGKWcOSjfvbdioUTj6IVi6KYEJF6lmSUNzXxB4Op/ruqN3yfDxOthd0fJQoweDQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Dw6HdBno; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b40f11a1027so47175066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 14:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759958319; x=1760563119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cAv3aIfZwqmRDaIqSQ8Kf1PKLE+RCGlZcqma3KwimQ=;
        b=Dw6HdBnoORGPUb/91N87OLTjZh8WdsmBIrfUsiG6PDhiJIlQLRzx6WkO/B36r47s4D
         eTRZ6T+eG4s09T4aZTr+c/Ioy+wP8k3ye1bhVdc22NbBDU6hhz21Pa1VcAq6JD1LriY8
         /zq88aieGqSyGn5F7QOTso7vIiiQzQlRQaZ1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759958319; x=1760563119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cAv3aIfZwqmRDaIqSQ8Kf1PKLE+RCGlZcqma3KwimQ=;
        b=rn7zEUSU64jstSIk2EB9KnI0qWmsct/mWKn34d7pZs59w8TAMa3U/N2uVIqLM5m+ua
         9TM3sqbGlprkImo1T8uZv5qkQJEHJ1qxCs6WwtQY2Mc6rQdQAh8HR/39i9fAIbRSi3RI
         erWP0JFrkNR6lUCRAnCJU42YSaA8L8KgWLb5OZ0esOD0j3xTV9BaPXKOFOl89dS69wLF
         +o+zgsj+wty8/RNFzzx8KNJALQwXw9AqCVWzWYI/g87DxAU4Kl6+ie3RRwCYpxLNZj9R
         t1b8vtVybyIU0PD2Mtjpey5pkP2RbzZtO61hzGfKSTRL5BB9/FLtVGIW+/pF0xItYLbP
         3KVw==
X-Forwarded-Encrypted: i=1; AJvYcCWS/pyjvmQ/8A99HbAe9LYygKA70T5y9kl8mDWjBmVS84R79ekGxAl3Kf6Ah59heOtqqQ3NG/xStU7tpdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdVxYVk2KyOT6sbuXifmpSfLzV56bwBYgUQBYFBl9VrYRbhO9l
	wfmANTzT0OvYewQRwMTUt1c9lO+peplRkVIj4nS/I6TawIIC/Im1/PW/KYd9RgMjJ/o7tUZAd/U
	JtDiOLw==
X-Gm-Gg: ASbGncv/CmqHN0DjoHPLggxOTd5XRdkYho8nFbDPsz5vOvfVKNfqKwRNaZFf4CaYMFP
	i72dhiheiotr70UMf0X/xdJ6o9pU9kjo6v+nRPZikAX9hHxioZ01gmasRLzhvaRBHlY5kSTJv4X
	DiU/ZAw4I7LhwQluqKwIW3UFc5j2H245xytqu3brXCgyoQPLdRh8FYjQz1tqprrltQU5sW3+BBN
	PcMM+l2/caB+PCJUB2uqAAfg1LB64ENBm+JBjRIdS6CgG0eG1f59NOFYXexNXapQCT5/eHe4Yg/
	zg05x7fIeqHq9mIMdFLnG8ptbzmgxHk9HoR/2AtEPYcFDUE1WA4Rj0Gy4fom48d2AiNahurgkOG
	UWDglbiB2R2HwGLy44jRGiMyARvL5sCQP0pQ4v+tJcHyLO+hb2xLoyoXqNsmQzYJFKMkpsOsnkY
	cfIINRMD2f8g==
X-Google-Smtp-Source: AGHT+IH0jZS0N4ld9uFmNXyStFgNhdVUHRHmdgS5jMHZ4rZU9LbENOsV6dbZ3nZQ+yAUGxztcH1jOw==
X-Received: by 2002:a17:906:d8c3:b0:b51:24e9:7ddc with SMTP id a640c23a62f3a-b5124e982d4mr305055566b.50.1759958319326;
        Wed, 08 Oct 2025 14:18:39 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b408sm1723493566b.58.2025.10.08.14.18.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 14:18:39 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7ae31caso42145766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 14:18:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX21FPjp5Gga9V0R9+H8M/mN+3wo3v0SUpKUwx1jrs/PIk2Bva136twUTGdI67r87lksUUfQGuBnWP1Cus=@vger.kernel.org
X-Received: by 2002:a17:907:3d91:b0:b42:f7df:a2ec with SMTP id
 a640c23a62f3a-b50aa391ec3mr529354866b.9.1759957905420; Wed, 08 Oct 2025
 14:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008082800.67718-1-clamor95@gmail.com> <20251008082800.67718-3-clamor95@gmail.com>
In-Reply-To: <20251008082800.67718-3-clamor95@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 8 Oct 2025 14:11:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W=b2ivRzJsJiWMCQLOzEbLQRcFdJvVOGkCPB1n9WFygQ@mail.gmail.com>
X-Gm-Features: AS18NWA_nIjegIylG_UcLKKJDvhd5Cn1SpayqPs3VwGjbaJ5oTj9e8qwAVTiy9c
Message-ID: <CAD=FV=W=b2ivRzJsJiWMCQLOzEbLQRcFdJvVOGkCPB1n9WFygQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] gpu/drm: panel: add support for LG LD070WX3-SL01
 MIPI DSI panel
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

On Wed, Oct 8, 2025 at 1:28=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail.com=
> wrote:
>
> The LD070WX3 is a Color Active Matrix Liquid Crystal Display with an
> integral Light Emitting Diode (LED) backlight system. The matrix employs
> a-Si Thin Film Transistor as the active element. It is a transmissive typ=
e
> display operating in the normally Black mode. This TFT-LCD has 7.0 inches
> diagonally measured active display area with WXGA resolution (800 by 1280
> pixel array).
>
> LG LD070WX3-SL01 MIPI DSI panel was treated as simple DSI panel when it i=
s
> actually not and requires proper setup for correct work. Simple panel wor=
k
> relied on preliminary configuration done by bootloader.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpu/drm/panel/Kconfig             |  13 ++
>  drivers/gpu/drm/panel/Makefile            |   1 +
>  drivers/gpu/drm/panel/panel-lg-ld070wx3.c | 184 ++++++++++++++++++++++
>  drivers/gpu/drm/panel/panel-simple.c      |  31 ----
>  4 files changed, 198 insertions(+), 31 deletions(-)
>  create mode 100644 drivers/gpu/drm/panel/panel-lg-ld070wx3.c

Reviewed-by: Douglas Anderson <dianders@chromium.org>

