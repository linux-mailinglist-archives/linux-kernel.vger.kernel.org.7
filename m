Return-Path: <linux-kernel+bounces-774433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 902CDB2B226
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BEA3B1D95
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD4F272E60;
	Mon, 18 Aug 2025 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E36sZ15N"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78819475
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755548078; cv=none; b=AfOgr1g8L/63sR+PxYxF3MzshLbKOVzi9pL4dkOfE42GWVbl5gwF1tZYnqNlO4RGY2Xv9D76pkys5uVcxJHV3aYxOYNnbxmqilBapPhbzRU8PbnkkUt1DLvhhWUNSyMqOhSPEnXS97m8SreKivlo9g02O03eorjWixWLw2bihP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755548078; c=relaxed/simple;
	bh=bwvyfdQ/fHA0Znhw7LDO141t4jAYvsxdGSxHA9sEnC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dv857XUOJ5JCdFCdzoTS36/Z3RhOTNWHceGG5w7eUR/W+bCrYi+RmjGJGT4M13hGp8GsCBD/imRfrcTmwURBnrSkscyywuNSTSMBsMZK2/IZKWoU8tih78AeqOuH4mJIdNp23IfdnrrotUjt23AElfmaOOlm7M9wEbxCpd/IKmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E36sZ15N; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb73394b4so692849366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755548071; x=1756152871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AbLN0mEOCL5wJFjFbEqIHTYiHqCns+0OdQO7zoWlxk=;
        b=E36sZ15N0uKjTaIBxGN7F8lAQNWsHabKFvsD1ueB3jVZ8CxtdXplB/JAKSeJBgxK19
         Wy/1HtHPjzksvAU8WlNKfJRqYxHAp4ANyFizgIvAqjhLXsNrC41h1Sj1Ffe3bo2Id6/E
         GyLZm9BPc1KKMYlNLOJNfx8pPtcR4gUHdHlKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755548071; x=1756152871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AbLN0mEOCL5wJFjFbEqIHTYiHqCns+0OdQO7zoWlxk=;
        b=ww8hNdffK8Gnyh4T+WsW0WZwBK3Rkh4ndyn4WoQFj09ARQbpwEwW4lQEZcCHX0ki/1
         5ipVIKjLqCBFeKZSU+HYjpJ47TvNNubGNBU4pBAD3baPVVsztnZy/P/0IKkkc7N8w2sw
         Vwn4W2wce5HZGZLQ9pHKbx0BNKqYtC4CnjrJwDFPoEIXoNog13OLeK+THLZFOtfLmbVh
         YWRjvv/RvmcsRNlHLAxBhUD8A4VVn3AknklZCNj9Ko7hzULgkNHh2nNdbfXdFP8FWjNh
         eu1aJYkMsEodwZ2Z2jkr9iwKuTgcoTxjV1CiY653Pkj8vj1mVgFhip0jMAe7BK72Colv
         evBA==
X-Forwarded-Encrypted: i=1; AJvYcCUpNJgsvJWToTnyhWbf7yj5MVhYnnSnIYcjc2cu3UgjWn8jOD+i7FwJ3Np6EHZNwV/mhUcvFhz61+62VPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpUxZm5zUKhTqSmFcJeo5uAWEDsajdVFZDqldaBz6bSbxTr7tW
	j+dHjzgPzE9patoN0EDrH1HWuhbdSYUloSztDFIQan56HMRXpu2KZhRTBAa7PR8HOtwh2WQo/Io
	u/p8t2A==
X-Gm-Gg: ASbGnctRHuCzmzO7BdCLLabMRHVwVH7arzZgJvY8y5Ud9ncY2YKgJ+MU1ZeerJZONM7
	fUOcakkgDDkf/KdRUdtZ2Y9khN4nztIBROMECWkFXzacZobTMhJqO8bkt3jygmnAfJNU9jkvoqJ
	M+HE/id0rPEgPGzyNZ6TqoYvU72L5zDsxXpk+MVJ48a9JL3bnqmozX5LiuMOtF/qLH3dW1W8lfy
	I5H5wKGGxgqTECENY1tQ6h5FvlWzJDrAPSRbtwYmTp3ksgm8BzBG/GjacuGU0rZtLTlZBTDpnwZ
	19h6q147hsobTl4vXvf2P0Av0QBjGlM9oQpgRxDWcPHAYRuDBw+Euke2t0e5fuaosEeinZLFEvU
	OuFhYH07o6b+7326f9HF76U30bHg1VGopyrVacjKJlyBKi+n93z5cqwEuSaUDLA==
X-Google-Smtp-Source: AGHT+IFRmaEH1E1GTVpi8kygM0i9HUhqC0ViWNUGqhGdQjhiiBLMQH3GO2JCFHvGzYB7Sf60rqJ8pw==
X-Received: by 2002:a17:906:6a0b:b0:ade:6e3:7c4 with SMTP id a640c23a62f3a-afddcb8324amr9568966b.23.1755548070896;
        Mon, 18 Aug 2025 13:14:30 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdcfcacc3sm872747266b.72.2025.08.18.13.14.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 13:14:26 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7a3b3a9so678772566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:14:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHEYTg5iBco2Tk+JOMojRMFPYRLtU/vh1cQ7OJ0/aSbW0WbvtJuJsxysVfmWa/cXiBuwa3ixMFS7CFcAQ=@vger.kernel.org
X-Received: by 2002:a17:907:2d10:b0:afd:d994:cb3 with SMTP id
 a640c23a62f3a-afddd24993emr6364066b.65.1755548065667; Mon, 18 Aug 2025
 13:14:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818115015.2909525-1-treapking@chromium.org> <20250818115015.2909525-2-treapking@chromium.org>
In-Reply-To: <20250818115015.2909525-2-treapking@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 18 Aug 2025 13:14:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WCfFWHAh=XxA_jZpMsS_L0U_k=_g_oj36Nd=4winZ24g@mail.gmail.com>
X-Gm-Features: Ac12FXxhwq2Tdk0MQ-VqGrmgMkR2gFXqi4A8weX1E66vNCEQGqMpqL4njS8RunA
Message-ID: <CAD=FV=WCfFWHAh=XxA_jZpMsS_L0U_k=_g_oj36Nd=4winZ24g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] HID: Make elan touch controllers power on after
 panel is enabled
To: Pin-yen Lin <treapking@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 18, 2025 at 4:50=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> Introduce a new HID quirk to indicate that this device has to be enabled
> after the panel's backlight is enabled, and update the driver data for
> the elan devices to enable this quirk. This cannot be a I2C HID quirk
> because the kernel needs to acknowledge this before powering up the
> device and read the VID/PID. When this quirk is enabled, register
> .panel_enabled()/.panel_disabling() instead for the panel follower.
>
> Also rename the *panel_prepare* functions into *panel_follower* because
> they could be called in other situations now.
>
> Fixes: bd3cba00dcc63 ("HID: i2c-hid: elan: Add support for Elan eKTH6915 =
i2c-hid touchscreens")
> Fixes: d06651bebf99e ("HID: i2c-hid: elan: Add elan-ekth6a12nay timing")
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
>
> ---
>
> Changes in v3:
> - Collect review tag
> - Add fixes tags
>
> Changes in v2:
> - Rename *panel_prepare* functions to *panel_follower*
> - Replace after_panel_enabled flag with enabled/disabling callbacks
>
>  drivers/hid/i2c-hid/i2c-hid-core.c    | 46 ++++++++++++++++-----------
>  drivers/hid/i2c-hid/i2c-hid-of-elan.c | 11 ++++++-
>  include/linux/hid.h                   |  2 ++
>  3 files changed, 40 insertions(+), 19 deletions(-)

Re-iterating my response from v2 [1] so it's still seen even if people
only look at the latest version. :-) If HID folks don't mind us
landing this through drm-misc, feel free to Ack this patch. If HID
folks would rather not land through drm-misc, the default plan would
be to just wait until patch #1 makes its way to mainline before
landing patch #2.

Thanks!

[1] https://lore.kernel.org/r/CAD=3DFV=3DUV8_XGmxC=3D7Z18PEnj6wKz+yZQuV_4h+=
LJh_MNCqszvg@mail.gmail.com/

