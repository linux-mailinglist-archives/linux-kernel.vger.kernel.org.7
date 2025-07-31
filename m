Return-Path: <linux-kernel+bounces-752665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 296CBB17917
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E30B1C27249
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882A7277C9F;
	Thu, 31 Jul 2025 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n0BPU9ct"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867287260D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754000745; cv=none; b=fy8CzM7NGe68YlfabE5f8OXWAIe7Q1FFp2lnJb5zWj2XhFzPTTNUgACZWyWe3FdnlZnQGX/rskbqe/CSvvdee0PoJthsI5Yu9kaLEICjJ4UfvjBvS8Jdi3QEQ/qWT/7eYaDZ/Kexg2S/bn+SY6kuzX4R0zDerN1lm/3aVEfi894=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754000745; c=relaxed/simple;
	bh=SpDUXTIpkublM0DdrEY3Y1E5epN5S4LuOsQnARsLSuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3NdN79In+y27xQKua/PgLZYS2GngCefwem0lkS6c1MfOq+QJfDf3dWo4g6K/n8IRbxUi/eDwZZDcUewv1qdgCGVPx+yheB7V2u0tcG7CI445+nj4Hu3mzCyxvEwaO7eLztShJq6hgdGB6P6gcesKgrHJFBOB9RyDHpdGtEQwf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n0BPU9ct; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76bd7676e60so240179b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754000740; x=1754605540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDly6jsUjLYLpTk911qABJ1dSyDnXYYIjODUvF3M+Yc=;
        b=n0BPU9ctvTkOOOqpCopFRlsb/1HQBR8XmzfsRbHfvq7BsLAYPS4/8tlVvsTbnixEQT
         W1kuVnC+hukO/5zS9TXUkRvkB5mNbCHY7cQN2tsWYR79E0VbjdjdGF8Nf3GnmMVu269c
         ApXBss4ffTOdO23diYyJicVWP5e/gxLE4KM2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754000740; x=1754605540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDly6jsUjLYLpTk911qABJ1dSyDnXYYIjODUvF3M+Yc=;
        b=JR7CKeTKKsxy8RhO3wNfXr9Niia8mFY57YCkIn5O7MSjLjYAQpJx/UEEGP0jgQP2gY
         Q+jAMNYyeyEi4CU72QpER60e+OHyy+Dcny6LB5bZe6368zbVRjrVsdTKEHVg5acpwZTy
         vg5hBm71nP9Fe9q00nMj92BTr9nNdYxzKmQ1DFH+cOViMNAs6fNHjx7eX0FbsqFqATAj
         9a/dOs90k2DBXNaRtL9TGSdOp+dCu9vHxwVMjYom8FQA/6ryoZDrdMVgLKceBMOuAYCg
         snZr7B9m+Cm2Q5nTjDNeZ+LvFDZJzyzf2WV38MToeoLZ22VF4mHiC5tdvAfj9QsMSvUT
         +IoA==
X-Forwarded-Encrypted: i=1; AJvYcCVOobgbnC+gGCQulITaZuhoxW0sk3CN8RZFcVJWaiSWFEgZcpYSPvqYAxZzs9nqHSLQvevP36YcNkoK7Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuu+1wPPuHHtxi7FdXaALlK5txlMsr8ezL5mQwSftQbjOknq9a
	xhS0EzHiXl30lIEqfFZWhaxWkUG9io2njD393t18wZwxRUvxgXmtxDAFQJMP3bdHX8F3C6jljMY
	XckE=
X-Gm-Gg: ASbGnctfJDJ4mQFHaM5/hYqCR+mUBazT7arSBVV+JMdDagWWt0m5qnUSIejWphjXNqr
	WRYjPAD10whdYXGoduS07ZCIGLanJpuuMTvQojELY3rMOWBKmyq5WnHPkVex/AsewWrnTDuSKKl
	drq7s9LQutvCh8T2CA2j5ivFuBkRcYIBVtRiyK1JKJxsETcfno6B+MRnOM0sVOgw6xpjdodshUh
	kOYGlZnJ3P8RcK+A2W312pjLAt6GzrIXnNHGA8PyzkcNV83moNc79zDzyPWt2zKvkJXGSmABbAD
	X4Io1ti4ws89ZKSYR6kS1c5Y7MJA4oNItJvSjJq+F35pWSKC0uzym/jX30jjGzCSCa8PVc6yP3v
	6EALoXciZr9eM7RbtcQNfMQykpRhbxj1iYle3OtlJ7irRFO+rIiznf5ivUZU44Q==
X-Google-Smtp-Source: AGHT+IEdfxZvj1miiKsC55XUacfsGUVmwkgOSbsxR+ATB0sOD4JyTfiw6Oa2WBekeGH9MBp7mCvdYQ==
X-Received: by 2002:a05:6a00:39a3:b0:748:f854:b765 with SMTP id d2e1a72fcca58-76ab0f17842mr11842738b3a.4.1754000740199;
        Thu, 31 Jul 2025 15:25:40 -0700 (PDT)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com. [209.85.216.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce88d31sm2531214b3a.28.2025.07.31.15.25.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 15:25:39 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-31effad130bso164910a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:25:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsTw8j8KhDHoa00fM8UBGyk+cY6DsoKLBdIgGBGQKjY6Pxec9cpuPrydpOlJbiZe5lN6nPf9G1pEJLQhM=@vger.kernel.org
X-Received: by 2002:a17:90b:288b:b0:31e:fac5:5d3f with SMTP id
 98e67ed59e1d1-31f5de54b78mr12214752a91.16.1754000737144; Thu, 31 Jul 2025
 15:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731215635.206702-1-alex.vinarskis@gmail.com> <20250731215635.206702-2-alex.vinarskis@gmail.com>
In-Reply-To: <20250731215635.206702-2-alex.vinarskis@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 31 Jul 2025 15:25:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VbLW36hJZwQ2uS86wmvsqiAzp2RMjds=-+qXOafg-YDg@mail.gmail.com>
X-Gm-Features: Ac12FXxFZufQJD5lK1zYZRbpN7hzBp2lfR58ugoDPco-BA4iqzwE9ZcJ34mjneA
Message-ID: <CAD=FV=VbLW36hJZwQ2uS86wmvsqiAzp2RMjds=-+qXOafg-YDg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: display: panel: samsung,atna40cu11:
 document ATNA40CU11
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 31, 2025 at 2:56=E2=80=AFPM Aleksandrs Vinarskis
<alex.vinarskis@gmail.com> wrote:
>
> The Samsung ATNA40CU11 panel is a 14" AMOLED eDP panel. It is
> similar to the ATNA33XC20 except that it is larger and has a
> different resolution. It is found in some arm64 laptops, eg.
> Asus Zenbook A14 UX3407RA.
>
> Raw panel edid:
>
> 00 ff ff ff ff ff ff 00 4c 83 9d 41 00 00 00 00
> 00 20 01 04 b5 1e 13 78 03 cf d1 ae 51 3e b6 23
> 0b 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 cb fe 40 64 b0 08 38 77 20 08
> 88 00 2e bd 10 00 00 1b 00 00 00 fd 00 30 78 da
> da 42 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fe
> 00 41 54 4e 41 34 30 43 55 31 31 2d 30 20 01 2a
>
> 70 20 79 02 00 20 00 0c 4c 83 00 9d 41 00 00 00
> 00 00 20 00 21 00 1d b8 0b 6c 07 40 0b 08 07 00
> ee ea 50 ec d3 b6 3d 42 0b 01 45 54 40 5e d0 60
> 18 10 23 78 26 00 09 07 06 03 00 00 00 50 00 00
> 22 00 14 e7 f3 09 85 3f 0b 63 00 1f 00 07 00 07
> 07 17 00 07 00 07 00 81 00 1f 73 1a 00 00 03 03
> 30 78 00 a0 74 02 60 02 78 00 00 00 00 8d e3 05
> 80 00 e6 06 05 01 74 60 02 00 00 00 00 00 91 90
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> ---
>  .../devicetree/bindings/display/panel/samsung,atna33xc20.yaml   | 2 ++
>  1 file changed, 2 insertions(+)

Pushed this to drm-misc-next:

[1/3] dt-bindings: display: panel: samsung,atna40cu11: document ATNA40CU11
      commit: d680a7959b9d7cce9526b1b391cc7b13e313a096

