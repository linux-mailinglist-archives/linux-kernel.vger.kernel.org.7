Return-Path: <linux-kernel+bounces-877287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DBEC1DAF8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0951897DC8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 23:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9E930C378;
	Wed, 29 Oct 2025 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PMbAGOsR"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A63309EF8
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 23:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761780320; cv=none; b=f77G5NvL86lkPxQz/tu/a6TbRo8UrV5UhSFKHqwYAuvcOtSdTyLlo2Uphy89liruVB4hV5hu5Gs1zvnm+bZ3xJMlw70NcbVt14U4LG+ME0shWE1Af1sjgxTCgrlEUZ0uM0tqn3o+PfyHdhfVcuxHtMHusMtUZ2VFmdkFYjwfgnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761780320; c=relaxed/simple;
	bh=n5GkqOKzhAD8zOeLMH8ojG/+XoJtlxzlllPxY8XCgCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBkILh+6a1VC0w4sNGkcmDZ4iiYJo28sCIrE3T1VqF/Biv7SDADcpFrTxjP/UjLcfZGL/QMxovYy9++eFQ07VakOFFqN3d+4n+RU+A0o9dj6S+KtdCw+fte71NhYqwdjYA3tJDGpkDwzo1iiEFcfZFygbuIM9aljpNn3VrWJ948=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PMbAGOsR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b4539dddd99so106923666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761780316; x=1762385116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3epzZnxmPN8tHOsM2+QpxO5JfuLDi/llITGwEkkd/U=;
        b=PMbAGOsR+O9DltqV2n+WyZgGfXVhSdo5ci5Oj1gvPikXX76q5p3f4ggeNATPSYjGKU
         AneWmmttgas6H9M4D1OPhIkbi/6CLBT5qotHNaFFr+5tGMxJQMkp9kY4ebkSAe159HJ/
         cUkAV5vhBdZZFW5bA/xBSWArHz3mUp2Lxgqzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761780316; x=1762385116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3epzZnxmPN8tHOsM2+QpxO5JfuLDi/llITGwEkkd/U=;
        b=Rved4dHotTcDJD5WU6WJd5l/n1fnv6nqnHpc4nDunfr7GJO3vALd4SAxdlkfQd6iu0
         I+cVHNDaAZSjQrtlUThyas/fRl4/S/ySgZeMxxnZW5tLuQq2wW/lYP/k+HSXFiwFYlmV
         jiO+gQQdBrer/mvcZMapSvQCkI5apyByRTK9LB9LDIjRwhlM9wJOxawzyu/9q19zf34V
         yCKasKvN+OnhDid+VLlmwcrqWWXeVs2UENBgrmtEaHbpy+82L2ei1XBjMjKjCHPi2SF2
         HU/ivPKLyKXLLdorW/8jNcO7OKo6o5hC8aSu9T3oPCyaRYd5lh/8JpwwQtAJt7C3Iuk8
         5+zQ==
X-Gm-Message-State: AOJu0Ywt6XCob7HBLqRhR1MuJdH0DrlE6JOV9RZEZg0Z735R+1h+RkTb
	i//+6qTbw5RxAiI0ADa5JJ1EjWcGD0iUybktovLHs/c3b06AClfb0cIDSw/dxPPrmI8yaNylaAP
	lMz9k2Q==
X-Gm-Gg: ASbGncvo35VXTTxjP1wuvx9NPt7QOZClhpv2Rb1rOyU6csElUM6NcHemPwt3nzm/6bX
	NMvygq2ejTg7Dk9QquBnJfdZgFojNE4LfHAp59DqG9dXay+kkGkkT2zutVw0sviNQ8mXQ4DBizS
	QrZySnphzhuPnqT3iso/3agUjf6ucPtPqYt5bvtDP1OJf/y8xkUoBz4lkfRzG8bvZnRxBIBoMl4
	6LmkR14YD8i0zNYMd/70/mtu1v0t5zMrEpaxRsQdJtVmEYIranaNv6Ap6dqE0bFkqI8Ns2OM47Y
	+jtGDxj/A/BZhgPeW2YSThlO7CCho7GtyGUv8IYgIBWpLpx1GQCSh5Tk/OFV3oMkiWo6DXQoMb0
	pP6L31Sfz6TBF7dbdsxHoZXaonroL5rC4udOKb15hG09zX0JujjTMqtfSxVBkDcDkVMd5n0qlPF
	2XiuhQsGru3PWEHbmBTax15ASnBMwu2+NR7bPZRwg=
X-Google-Smtp-Source: AGHT+IHXF8kKw7D3OCxwQE7/cbN28d1okbGr7wJriebWc9vtCu4B3NN84eLIY7LHAdtu4srjXdoNQw==
X-Received: by 2002:a17:907:7286:b0:b3a:7af8:c4a2 with SMTP id a640c23a62f3a-b703d2e2094mr528502566b.10.1761780315685;
        Wed, 29 Oct 2025 16:25:15 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7058770e28sm36287566b.13.2025.10.29.16.25.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 16:25:14 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b6d2f5c0e8eso89233566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:25:14 -0700 (PDT)
X-Received: by 2002:a17:906:71cd:b0:b6d:505e:3d99 with SMTP id
 a640c23a62f3a-b703d2e21eamr369434466b.12.1761780314255; Wed, 29 Oct 2025
 16:25:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029081048.162374-1-ajye_huang@compal.corp-partner.google.com>
 <20251029081048.162374-3-ajye_huang@compal.corp-partner.google.com>
In-Reply-To: <20251029081048.162374-3-ajye_huang@compal.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 29 Oct 2025 16:25:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WbR0u_a7S1pcL-6C+sj9Kt=GOLUwJmwt8ANJbyV4JYFQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmyGhK2APErFjpEf3hMjvCxrILRsCTTYr0jINqS6mb0sq-aCKx063lDV7Y
Message-ID: <CAD=FV=WbR0u_a7S1pcL-6C+sj9Kt=GOLUwJmwt8ANJbyV4JYFQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/panel-edp: Modify LQ116M1JW10 panel's bpc to 6
To: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc: linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <jesszhan0024@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, jazhan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 29, 2025 at 1:11=E2=80=AFAM Ajye Huang
<ajye_huang@compal.corp-partner.google.com> wrote:
>
> The link training is failed when bpc value is 8.
> It sure seems like the panel simply doesn't like 8bpp,
> Changing the bpc to 6 allows link training to succeed.
>
> The 8bpc log shows that link training failed.
> 6bpc
> ----
> rate_mhz: 1620
> valid rates: 30
> bit_rate_khz: 2399760, dp_rate_mhz: 1500, ti_sn_bridge_calc_min_dp_rate_i=
dx return: 1
>
> 8bpc
> ----
> rate_mhz: 2160
> valid rates: 30
> bit_rate_khz: 3199680, dp_rate_mhz: 2000, ti_sn_bridge_calc_min_dp_rate_i=
dx return: 2
> Link training failed, link is off.
> Disable the PLL if we failed.

Though I always appreciate details about the debugging that was done,
I suspect that most people reading this won't really understand unless
you give them the context that you are using the ti-sn65dsi86 bridge
chip and that you are printing out values related to bridge training.

I would also note that, to me, the more important test was confirming
that even when you pick the same "rate_mhz" for 6bpc and 8bpc that
6bpc works and 8bpc doesn't work.


> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Unless folks end up preferring EDID_QUIRK_FORCE_6BPC:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

