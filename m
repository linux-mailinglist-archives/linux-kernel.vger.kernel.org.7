Return-Path: <linux-kernel+bounces-769785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B10CB273AB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107A91898CED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2792D7BF;
	Fri, 15 Aug 2025 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eecylmi/"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098A43398B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 00:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217191; cv=none; b=uhBvsocOT0bePW7IebCnv6oSDJyzz7C1zyUV31FK5noFkylkUjNlrEieMkvedHJX+SQRZCbVItMKQBEP7dgUYXm04VY03Y/LWQQPWrDxzOLHcZvGepkHWm7oLiI6yprFyehQzuVIdZ/CIVxxHFQoNoaYTwB0BCqkN5IivZyI+b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217191; c=relaxed/simple;
	bh=pSmdu9muq4NXLatn/DCnS97tZQ+5zeuxvhwelJy44jY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUYZ7udHoP4z1NhfPxq3orQUkFLh9gLoBVqLElME6yax0UMD/QnmCNxVU05zZ4MfhuSlG/PSlKLL8kLOadooip1935VGPwc+TsHUbYR1GsXk1gPdq5ccSMU8bfJXBxG5SKJQZpbH9tg7CcqhGxgjFTFTUc2DG92I3vwiLUagidY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eecylmi/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2445824dc27so14540105ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755217185; x=1755821985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VleEWglR379JUi2VRPyVygfWGFpaMa+WQLnA/qDO5J4=;
        b=eecylmi/JkVg23ENQ9AuZxPt0YA13GN2Ss0LdHqalStUV7QgNPEeQD0LkJioXtE7qK
         6vX0eX0CGiUoajBaAPSgME2avtJgpeF5E2Zp3bkKQHZKaXerVDWfmGUpTdyruG1Coor0
         YNnie7iffQMtP4iiYY3hlPfdkElmfs2/ASTl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217185; x=1755821985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VleEWglR379JUi2VRPyVygfWGFpaMa+WQLnA/qDO5J4=;
        b=ubTwD+JWBXuzke8RF2CxpbS0R5rmqunvFfOlHhAtG4YQ0UR3ko1GIFlHlV03vPIGlX
         5rUrEg6UNOTdH6wcKvTXLopFYnRTb2FO2UTQJfzDYAsE8UN540nd/PW1zHD9m/pgqrc5
         /8Bz3IeH6+0wyHRVyBx+V7cyDDMuBxmjlfji5PH+XGxA+BxFBgLeOe5n7mDrM1F3t5e4
         0IbD1/7RPuXsdgr9CMN/9gpodr5nMnyarE2HtK0X7Mxu0ot/czDS9HZ5Jw4Yz+0dTx/K
         5bnkKpzBs2oCpcVLljtzZQ1Cdl5OmeNHUnTHVuVNp/fRUkQMx1fNj5Noe6rpMo84VX7j
         /rDg==
X-Forwarded-Encrypted: i=1; AJvYcCVA2lVZ07e8tJks8uoLV+ME64GAwzRzZ8MMtOOIe0sxzjZ53hz92jqEwa+TikSpdXQ2CnkNCZEWSU2s7s8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHLS5ScQJi+2z0npYkmBK2GggKvyXNgIVWp0ZxHG+3K4+k1Lou
	t6O8B2y9I3MBbWRJr4pDZku8hZjr8zc9aQpJdKf0Q2S7RT3SSQ0bPslsymthQvelYXROqxF31je
	IRKM=
X-Gm-Gg: ASbGncsOhg/lhdD0sAqolx3gGpUWPotX5e3Zeg0RkFqdh0cjonlevOPXXMzZIHue2dF
	TnduZnPF6kb5tsCXay1pSZImT03KaH0SO1rffEr+thxQO86CVBDdVtL5jfCbbai2HxxnXY8YT7m
	zRTMqry1Sk+3sbx6WzX8XXXWmcjN6a25I+F89x6t4NMx5+XoXqNwVV2ADSLiINk6FKpB4dHHgMp
	dhpOgOERhkZtPO7TRd2Mr8mxqnkAhYdVKC4nokCZwTdc21Vw/mECQCZ0QQ6oWRC9Kn78vwASedW
	BK84n4OVQQPmRrwOYaQymIgAkCsMQPs3gV/mB2x1I8MFWKVRe5yuHBBcnv4UQrN9BVvQ/OMYT7U
	onzI8VZRGjK0cBfB6YihS1G12zME5TesHbpn07gEqWfKQ6z5l5mRSiza5m4lz55A+MA==
X-Google-Smtp-Source: AGHT+IHZfXKKNZOtbcohBKSOFqzpcZEKDUtqiK7L9i3FNCMB4l4m5boWs3tls2xrJty8mgWGVMlvsg==
X-Received: by 2002:a17:903:3b87:b0:23f:d861:bd4b with SMTP id d9443c01a7336-2446d5bcffcmr2009985ad.5.1755217185079;
        Thu, 14 Aug 2025 17:19:45 -0700 (PDT)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com. [209.85.215.180])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfe9003sm35395753b3a.125.2025.08.14.17.19.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 17:19:43 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b471754c159so916898a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:19:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcz3xFcaCgxW1/e79YenH3JnK0bJWjoMFSClrlu5zCnQ9fGqp/OdUOJ+j/OK+3qhQcqQFMiVio7Cz2bIE=@vger.kernel.org
X-Received: by 2002:a17:903:1a90:b0:23d:fa9a:80ac with SMTP id
 d9443c01a7336-2446d6f0ed3mr1600235ad.16.1755217177677; Thu, 14 Aug 2025
 17:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813125132.1319482-1-treapking@chromium.org> <20250813125132.1319482-2-treapking@chromium.org>
In-Reply-To: <20250813125132.1319482-2-treapking@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 14 Aug 2025 17:19:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XmMwocA_oZVi2OS2Z4+5LBT4BXZE2C1mx1U-Tcs+5SOg@mail.gmail.com>
X-Gm-Features: Ac12FXzAXTp-VomUKh_3L3spBMWh_fGYcK1SRCaMDzVm6bQCCPWcJLsctftV8BI
Message-ID: <CAD=FV=XmMwocA_oZVi2OS2Z4+5LBT4BXZE2C1mx1U-Tcs+5SOg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] HID: Make elan touch controllers power on after
 panel is enabled
To: Pin-yen Lin <treapking@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 13, 2025 at 5:51=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
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
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
>
> ---
>
> Changes in v2:
> - Rename *panel_prepare* functions to *panel_follower*
> - Replace after_panel_enabled flag with enabled/disabling callbacks
>
>  drivers/hid/i2c-hid/i2c-hid-core.c    | 46 ++++++++++++++++-----------
>  drivers/hid/i2c-hid/i2c-hid-of-elan.c | 11 ++++++-
>  include/linux/hid.h                   |  2 ++
>  3 files changed, 40 insertions(+), 19 deletions(-)

This seems reasonable to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Given that this affects devices that we already had support for
(you're changing the behavior of two touchscreens), should it have a
Fixes tag?

We'll also need to figure out a process for landing the two patches. I
can easily land the first one in drm-misc-next, but then it'll be a
while before the i2c-hid one can land. Is it OK to wait?


-Doug

