Return-Path: <linux-kernel+bounces-773288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAA0B29DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45AB77B0514
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7D830E0C7;
	Mon, 18 Aug 2025 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UexCYvxD"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362EC30DEBB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509149; cv=none; b=q9ZsD8qojq1FLSwf3hbz7EdepU5KLcfBzgjPj0J50yldeikXxrnjq8oeZETjFrv9qkc4lEp2GWaCbf22ZgzbuBa/CsUFIqie4QAFBktC/v+xDW2NRCpio+7+vYTVkbKhAPGE0WCWoLY4juI5CY8KK36esB+DVDAIu/Wya73ol7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509149; c=relaxed/simple;
	bh=wo4TENj/CKIqy8SYXhJJLguOY5BaEq786MRtklI+vUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dk3ti7mEv4aZNi/Uc+bFqQKmLNUchM2YEW4yO+Zow+amUtB+MtX1bsS6dZEbS+94U5WHdZvc3z6VtbnrTAF50Jm2e4I/GkQntz914GteuSJMiCiYlZLUb2jm0HRQF9G4vaOYOZyOZzRkxyOK2ZoFrxT0bGsDbFy3T1FBGJETZP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UexCYvxD; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-333f8f5ca72so27519461fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755509144; x=1756113944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wo4TENj/CKIqy8SYXhJJLguOY5BaEq786MRtklI+vUA=;
        b=UexCYvxDLpHtwdYCfYv3diYuynvBUUHlYzsQcmlhNYv1f63AePv7SkqEvss4l2XBly
         cai1fIvltqILA2JhlRc+uL9s9IaNRjLM6FsNIGRMEFxM9WiMsr24ee0vt44NlJpC+bH/
         i8sTZTo6TwmHNO4QBJBIAwCYIkm6suv/GS9MAUWh/djRrRp+U/ejzIfsPx5C2Nb27Wop
         e46OUMMwih/PhHK6hwl0jbpF0VJowX4qbyzHPjFoXWpLKPTkXpYCa23w1PMcipxtHnNU
         rArVqAJb2J8LWNDWImWwA/a4bXwBKxyVh1CM8mtN4MoCL+EXNYzpGD5M/dfyth3RjGg2
         rXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755509144; x=1756113944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wo4TENj/CKIqy8SYXhJJLguOY5BaEq786MRtklI+vUA=;
        b=ToHMncfWojT4RqmsXzD6ZCoMVWD4iu9HsGM5yaJQX46NuH4jVU/efi4CsRqaPf8Glx
         zPbpQedw0A1vKNcLa2hHRAGsU8s3h58fxmb2IUD4thq22s4nRuY/bRZC/vHo/EIB5V+m
         hpJ0SmKZAkzNdp/69M4I289cno7SN1PZO6gMIYwzxZ9pSljUX5fLxCF799/SPBE+GvjR
         03MyhX4r2+PyBqjhpaQ9fQWwarvPU89pk3gWGgtuMaYOnaiU3alhDnblM4uKlfBOKfuR
         nft1Gz9nhVObqhXlSPHpGovRdoIEQDeHudW9kIdszrMqpkL+hjzin7J6k01IyhZMY6eC
         7h8g==
X-Forwarded-Encrypted: i=1; AJvYcCXdoS4veaGcaQB0VdftjBM4E7tONsfpzEL/JhTH5ReUOs0rnpR35X/DVDvuuTv9Saba2J8Q+6yKsFqUw60=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJDM509rFEcc0ob9LlP1iKSjDC6Iz8nWaet7lp4ZJBwoTWgRD/
	VaHdxoeMF9B60mWWQJlj+mDfTCpYRvhPHV30VZFwSYYuGsd0caJM+jrKoAtOS1HItGW/MRmG+jr
	TAStP7ts+0R9G06Xu68HYl9CoLVk62JQQp69C56ioqw==
X-Gm-Gg: ASbGncss7umM+bo4lz5UgVL8V6oDMadRlRKAcvoxM/lh2fgiyg81oNlBe7D2SiRdpA4
	FetNhirWm4trT7CE7FDXIM9hGIPvHsQav0f/kjdS/+3yxevj/eDtk8Lke5lbtebspaOGiR67pxA
	OVJvBUPCI1cJ2u7vix7mnTw5elg/ad6hkD4n5WG2mQRKV3Qnijc757TC9ve5kW11etAGT9GcDHZ
	773bc4=
X-Google-Smtp-Source: AGHT+IHNbZouPA+9w/Eg1wGgKXMzUtJ39CaSfzmACFke7a6lYkpcnvTkjJpS7aaVbzjtwG3r/4970mFH4ZdlzWsxTU4=
X-Received: by 2002:a05:651c:555:b0:332:3691:a50b with SMTP id
 38308e7fff4ca-33409963f8fmr35371671fa.33.1755509144347; Mon, 18 Aug 2025
 02:25:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730061748.1227643-1-me@brighamcampbell.com> <20250730061748.1227643-4-me@brighamcampbell.com>
In-Reply-To: <20250730061748.1227643-4-me@brighamcampbell.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 18 Aug 2025 11:25:33 +0200
X-Gm-Features: Ac12FXysXacOEMS_v8Dyu_3gMUa5CFOxftr3HHbH5tzkVfiT0eAfebU-wggGo3w
Message-ID: <CACRpkdYZrBze=MrixPpp8psUus+i2h_iz7CPfYtRCjspVGC9_A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/panel: novatek-nt35560: Clean up driver
To: Brigham Campbell <me@brighamcampbell.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, neil.armstrong@linaro.org, 
	jessica.zhang@oss.qualcomm.com, sam@ravnborg.org, dianders@chromium.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 8:18=E2=80=AFAM Brigham Campbell <me@brighamcampbel=
l.com> wrote:

> Update driver to use the "multi" variants of MIPI functions which
> facilitate improved error handling and cleaner driver code.
>
> Remove information from a comment which was made obsolete by commit
> 994ea402c767 ("drm/panel: Rename Sony ACX424 to Novatek NT35560"), which
> determined that this driver supports the Novatek NT35560 panel
> controller.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

(Maybe this is applied already...)

Yours,
Linus Walleij

