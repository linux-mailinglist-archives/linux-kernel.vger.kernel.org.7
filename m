Return-Path: <linux-kernel+bounces-752668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 157BDB17925
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610311C27010
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E590327E05B;
	Thu, 31 Jul 2025 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cDJDBcHz"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D895221CFF6
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 22:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754001201; cv=none; b=XB6Ko8KXzRPyhEb+/35TNlIDtdnzO4RGDnakSxJqurkK84MCpY/2p6B3ZoKWFttmdmZCmf3WX/fUH7X0VK0XRmWG55FVIYJg5C5pGjYZFzYv/97H7TWk3Cmg1z8DYFXbFTClZ52yroCOYeJHeGxHNDAlSS2tpMO9SR/08J24pes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754001201; c=relaxed/simple;
	bh=Iyl+iRcxcCK3DiNxtralldE1bYNP2gRzf/t0Mc9dEhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/5g9VzMfGLAa1xJ/OtbRFLIzO4DW/geYhOdp8Uu5yULLnfPYuS3XYDC6oER9+F1kldIgoFvv5mWtehIW+StlimRBobY8d5wBUW2An+zVt7BE3neCyTkRxtPsegGlm/N1KXvTjKT1addJqNqgKlMCorYLgeAmjcJifTtHKsb/Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cDJDBcHz; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2ea34731c5dso932706fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754001198; x=1754605998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuzCKl0JWVA/Tt1eJjsJNxFRtsPec8WgVBQlmDXx0UY=;
        b=cDJDBcHzaNYaEgeOloJFTEu4/pOQxsq4hBvYj14+5+sJqkjs66y8jM4yiPxM/hDVq+
         +KgM3NTN+bkE6MBmlTyCEuq6pi96cyyBI70gM3zF+0EkdR5gicwGBidqeuaeM1CasX7o
         uIaGhAjR7p9XYZKYB/qf+QZ5Y4trr7YHRgw5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754001198; x=1754605998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuzCKl0JWVA/Tt1eJjsJNxFRtsPec8WgVBQlmDXx0UY=;
        b=MYxZQ/4R45J1y8OZLmrfc+FwcVUX+xTj+c5/e1EBAz9wWrCoq6ZKYWDTtSvOZ0VTbq
         V5kG0fLELQbZkhe9eZApj/nPrAIHvc+jzSGQ4wV+ndmN8PTOcvHgGemr2Qm6NZL8yUSf
         JGSba2U6CIItlVsTieq901BO/MKoeA8zy6y4jQLV+yJzWgjAk8LKm8lWQyqLA80bnC9g
         XELlURN5kvHCmtSraThMHytkoaUZ5yxcYSQ/kcKcbsH+MGZz3zlfmMH3zmxEe0qYAlcy
         W3BOZTP3rd0cyB9IZUNjzCXZxvXfNXw8rvlPHQB3jHUF/gBmG55lwvMTfpejbljFr3JK
         zlKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX279ZTkxNQsljUGcBfbqoHC8DJbpuD3UL9qTrUFa74Y1Uy4XuHHRrmDRXSy+5a2+BRNBAKp1K8Kf3uBDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOPTCQfgy25tEWN8U0HFGWcJqFek6jQ7gpdEZExH63Ak0/Aeso
	6koIm6EyupRVpB+v4zXo+ZBI10D7o9fUHm4An9mUS4X4ucbq+XEFv1sC0mLN9PA1sKanN2fwzTz
	uQLY=
X-Gm-Gg: ASbGncsBD+hQYUUX7j1kmCL7l00cd5xV4ep3cRsAR+rfiX1ztY+r4jKKrRiY2VHog74
	uIB52xjy05wjCd/J88OQvBDI5oHfbrzrYRIwOR5y5UBYqMbc50BAVZe8ijUg+hHgz/B50pR8xLJ
	Ttc8Xf7fw+XyAZc/kCaFhQNxKFMnhasEoj2uRrhdMHLodFxrQzF71ZTtynVdDwFWHdOlEBluYEv
	fwKZnq4pNsixfQWMI8mWN9DBwuSr3kheKUF421eZVI8YuP/dUn8MjRW76avD5NeLIPKWBQzSHTJ
	8qINiqrnSY5ka+c52R6INmwFZwzPa1LjoJ8ZLvg6fVN7QqyFhX2ZkPnENcUQyX/KEIxJca1BMFa
	/g2US6b29UEJ3xNlO7WnmixFmwWlwTpr2K7tkowvltE/YXCWBJST3a502BChQKvc2jDRcfURK
X-Google-Smtp-Source: AGHT+IHqgev+drqrJsFC/6bkrUv72LOwQttPsgFRfVl0JkQsk3GgPH/NTRN58fFXJSN9/hfqjYpG7A==
X-Received: by 2002:a05:6820:3082:b0:615:b344:927 with SMTP id 006d021491bc7-61982a04e77mr287648eaf.3.1754001197813;
        Thu, 31 Jul 2025 15:33:17 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-619704df316sm374096eaf.6.2025.07.31.15.33.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 15:33:17 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-73e82d2ec9eso741298a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:33:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXpG8vgsFs2WFWwS0P4jjHjkkNZW4U0es9/HNlS+ZoWE5oOIBMUSY2s1BIM1MY8CznjHL1d81CIg+mE8ps=@vger.kernel.org
X-Received: by 2002:a17:90b:1b06:b0:312:26d9:d5b2 with SMTP id
 98e67ed59e1d1-320fb58f639mr739004a91.0.1754000750319; Thu, 31 Jul 2025
 15:25:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731215635.206702-1-alex.vinarskis@gmail.com> <20250731215635.206702-4-alex.vinarskis@gmail.com>
In-Reply-To: <20250731215635.206702-4-alex.vinarskis@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 31 Jul 2025 15:25:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XkZk61ad-Sjywp7xUCzL=gfrOetAjdAgdBZS2euOx-Gw@mail.gmail.com>
X-Gm-Features: Ac12FXwjfUgMu3_9Fbku_FeVuAQoqm5uw9Nv7Nj3Y-NXJ8CPv5IPxq-hUPITQbg
Message-ID: <CAD=FV=XkZk61ad-Sjywp7xUCzL=gfrOetAjdAgdBZS2euOx-Gw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/panel-edp: Add BOE NV140WUM-N64
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 31, 2025 at 2:56=E2=80=AFPM Aleksandrs Vinarskis
<alex.vinarskis@gmail.com> wrote:
>
> Timings taken from NV140WUM-N41. It is found in some arm64 laptops,
> eg. Asus Zenbook A14 UX3407QA.
>
> The raw edid of the panel is:
> 00 ff ff ff ff ff ff 00 09 e5 f6 0c 00 00 00 00
> 10 22 01 04 a5 1e 13 78 07 8e 95 a6 52 4c 9d 26
> 0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 5d 30 80 a0 70 b0 28 40 30 20
> 36 00 2e bc 10 00 00 1a 00 00 00 fd 00 28 3c 4a
> 4a 0f 01 0a 20 20 20 20 20 20 00 00 00 fe 00 3d
> 4c 33 30 20 20 20 20 20 20 20 20 ff 00 00 00 fc
> 00 4e 56 31 34 30 57 55 4d 2d 4e 36 34 0a 01 f8
>
> 70 20 79 02 00 21 00 1d c8 0b 5d 07 80 07 b0 04
> 88 66 ea 51 cc 74 9d 66 52 0f 02 35 54 40 5e 40
> 5e 00 44 12 78 22 00 14 7f 5c 02 85 7f 07 9f 00
> 2f 00 1f 00 af 04 27 00 02 00 05 00 2b 00 0c 27
> 00 28 3b 00 00 27 00 28 2f 00 00 2e 00 06 00 44
> 40 5e 40 5e 81 00 1e 72 1a 00 00 03 71 28 3c 00
> 00 60 ff 60 ff 3c 00 00 00 00 e3 05 04 00 e6 06
> 01 01 60 60 ff 00 00 00 00 00 00 00 00 00 de 90
>
> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed this to drm-misc-next:

[3/3] drm/panel-edp: Add BOE NV140WUM-N64
      commit: 82928cc1c2b2be16ea6ee9e23799ca182e1cd37c

