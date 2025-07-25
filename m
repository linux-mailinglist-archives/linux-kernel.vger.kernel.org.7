Return-Path: <linux-kernel+bounces-746390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22671B12618
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 23:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F094E0C62
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 21:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722F020487E;
	Fri, 25 Jul 2025 21:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BJMrhj+U"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829071F4CB6
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753478240; cv=none; b=OSLQcWeYfUhQxVBI7hrwv51PHJijqqv0lJqqwHlR2TNJxAFftqteDGt8Uv+zQ2hK2iOzaQshIXmy+cVoGT3SSt1eeJLD3qp818ScX2iOd/HcmI/4531dOL60m+nNyP/8CwiBuFU2KQpihfLHOwOGt2/CUBFlPp30FEvpRuheP64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753478240; c=relaxed/simple;
	bh=5W1xWN/MH3bhYHOn5uEZ50/hNwMW6Ugv61qVaiOuZ68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/UNGY+HZPZ4KiSl92Y+DZjl4+EnaShN4rudRkJMR9+TnP7UN0Uz+8+oMhA3YmJt2J3Bdf0Bg6AMJbC/fJbZGhDihtwf/xHvV7LRTQjleDrHJT+A9X1EiJYq3koaTGnids1lbsfxP62d4v0++u86Qf3dcBtOr0M8VsIghczHHjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BJMrhj+U; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74b54cead6cso1808350b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753478237; x=1754083037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETkxLDxYY1VgsCRsmN7I3Wj916ZLSMePTLbGFUiSWPc=;
        b=BJMrhj+U4+nTW9f3oEfwmjbTVekcy3RX6Y9V/mIcWWH0Fqq0niT7hLpjRWBfiUDb19
         PVbF8YB2RlLKbiV70cjpx48a5u9LElfi09xBJNxQhq4hIayuQ3XISC55eKSqZgxSYzTp
         1hhQ1FSnMJu+puGFs1ChzBZCfXyvIRr8HkQHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753478237; x=1754083037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETkxLDxYY1VgsCRsmN7I3Wj916ZLSMePTLbGFUiSWPc=;
        b=DEEXieOnV/59FUkP3k6Mh5WfaNB5KFzNIHkZRZgcG3WoNuCYe28N8CBTuYRgEW8BIW
         btjT053+oYhcWQ1qN8Nl8QOz4OwJ3Q/3oFt4VE+d9FqvnF9RLWq70Zp+Dou9dvgh/nTR
         Q84YK0allu6TLViTZLVUTXStR5MM6z5ggnhdCftQW0kl6i0xs5pNMmmrTLFuJb7S6090
         oRIQGKg7KUt16CrvNiluX1Vh/CSq2iE+tYLuKuXRoUGq/6Jku+Zaxsg6lPzymUAPv0Ve
         VeRYrrqQEZvxAn4e3QzlXajRMC2YuGdZ5gUwMlq+Rnf677goKApE5GTbeUYdSoQpap12
         XV2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZFaVrp5r/CoQK79QHTInmCo9+hrYdUwQJ/XC77pyN2TdderqxbG7tXlN/vbC1vLPQOa4imrtQlCu9MM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywge38tfoxz7t9D6QAcSpJ8h0VMRByrl8vbjTKBrkYNEVbeWpZH
	UvHp0Pe6H114ShoRbgBHy0j12Xb9nsXLggMbj/VJf4ajE0pddrgT9xVD433oapUwc3BAxIb4CqP
	Jv0s=
X-Gm-Gg: ASbGncvF/4Q5OWjtu0yfnVuBPW32gNXZ+MN2ntzWy3RosWuvlGf89gfLs9i+xPYPrhr
	Z0dFI4pxGlqbc8vMtPNAtIYW3iOxIqrVA160TaxaTbMXGBINdPdvOV3u4rtlUWFbIThVVB3DR/P
	ZZDrfMSWxxsT9IaQkgf9dICql/mUTVBu7qbepFePCBDKqtORqR1s0fxBLuctxCr5QPkeebxPNNM
	6OmOGjJfjsVtEQu17OXViS6u5ClZxojfBSjBjHc4IhF+VYajKSRa/FGrLrnSt+FXorXY/YovLvq
	NUthbBE+PtWeJvmmL18zH7uE6rvmUmJiXK3gdKc1lAWOKMohm8rm/6Ux07PXxaJ1zJf3BAvQ6Ev
	Rp64Swub0fps9WpqGeFHxhg1kBjoUlqAZMP/jn0wXVh0S11n1vkV0tUwQq6HWZUKFzw==
X-Google-Smtp-Source: AGHT+IHVKQ/HNLE+pfFfZguTmpFlf3HBBFjdlEmi0iDDRNnK2HQszPQt1zAXvDgfHep4GxebQ5PVlg==
X-Received: by 2002:a05:6a00:cc2:b0:736:51ab:7aed with SMTP id d2e1a72fcca58-763379e8429mr5069347b3a.16.1753478236749;
        Fri, 25 Jul 2025 14:17:16 -0700 (PDT)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com. [209.85.210.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76408c02005sm442954b3a.36.2025.07.25.14.17.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 14:17:13 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74ce477af25so1850034b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:17:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU25geiq/4c0kXvqr1suuNmkbTHA2hwnctbfwm6DMriJlBqnlGe5eFLUJJB+WrTyIuuj8/SSBYnrHLSCko=@vger.kernel.org
X-Received: by 2002:a05:6a21:99aa:b0:232:ac34:70ec with SMTP id
 adf61e73a8af0-23d6ffe455amr5790082637.7.1753478227853; Fri, 25 Jul 2025
 14:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724202338.648499-1-me@brighamcampbell.com>
In-Reply-To: <20250724202338.648499-1-me@brighamcampbell.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 25 Jul 2025 14:16:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V65Pa0p-ckGAHTCgkqd00M9gE2Py99QcYmaq13jOdX9g@mail.gmail.com>
X-Gm-Features: Ac12FXxmzjj5lJEikgMEtUTC8c1N1dj-92vpoAep7aMMBdfPQfUJq6k3EPzR0JU
Message-ID: <CAD=FV=V65Pa0p-ckGAHTCgkqd00M9gE2Py99QcYmaq13jOdX9g@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/panel: novatek-nt35560: Fix bug and clean up
To: Brigham Campbell <me@brighamcampbell.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, linus.walleij@linaro.org, 
	neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, sam@ravnborg.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 24, 2025 at 1:23=E2=80=AFPM Brigham Campbell <me@brighamcampbel=
l.com> wrote:
>
> This series does the following:
>  - Add mipi_dsi_dcs_read_multi() to drm_mipi_dsi.c for improved error
>    handling in drivers which use mipi_dsi_dcs_read() such as the
>    novatek-nt35560 driver.
>  - Fix a bug in nt35560_set_brightness() which causes the driver to
>    incorrectly report that it "failed to disable display backlight".
>  - Clean up novatek-nt35560 driver to use "multi" variants of MIPI
>    functions which promote cleaner code.
>
> If there's a reason that mipi_dsi_dcs_read_multi doesn't exist, I'm
> happy to drop it.

It's a _little_ weird since one would normally assume that the caller
would want to immediately act on whatever was read and to do that
they'd need to look at the error code right away.

...but then again, there are places where a driver might want to read
multiple things and then check for errors once in the end (like the
driver you're changing here does). So I'm not against it. I'm not sure
I'd expect it to be universally used, though...

