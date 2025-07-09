Return-Path: <linux-kernel+bounces-723562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 200A7AFE87F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE9D18907DE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8FB285050;
	Wed,  9 Jul 2025 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="I/l9ss5C"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3181DDA15
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062383; cv=none; b=rxG8zmKAG77he4gkP5sR/pGlT2gLBskyVoiDByUu3rpPxlfARHMJvSWhsiguY4TIO5nG5a9/jxPWy4Tp1J+Imd6V8jIhNeK9bnjJYlL8Mn3K5V7MsIq9CzRbTVYXkGNLRp8gLmOGXMbmpsEh+EWm/CqJA5++Y5/45ZKaEVZsLEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062383; c=relaxed/simple;
	bh=9pVv9RHixO9d2u5FdY4HrMvtjdLG3sLqMZQKJyVQ/RE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=R9y5NT1JOY3UJGIaoH4RM/fcK7YoW1c9nMQFQdSljG4cNokBanUZKx4NNcDqZqlVxNI6UNhx3+panathBvD9u4zj9AACso2HI+lAiryV75H+H6zSYwVHccMByqrqmN0Ecb1fU20d3vNrpXlh9EBrYsvsBBsE75Hu0CiJp6pVbTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=I/l9ss5C; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae3a604b43bso864349966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752062380; x=1752667180; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwaoJLiJYF12OSK8rGI95sJddGwuByNYIOGTk/ksVzQ=;
        b=I/l9ss5C9PAfhDlfShQ35YWk+BRm0E17GRDikPaSam0JgAbLc7P2ns4sZtt/a4OVjg
         rYbDpPQ0KVyUKUQSAikua41foV/Ua12/X2/pUCQyLppBr867YhrGPO1mnpzhnTsIzStj
         ekxRxJJK3kCbTDa6KevbEF+bKhYv4R8x29hQuT/YtrSOHMAqlaqMGNs5alz1aVaA0hNZ
         KCBMRZ60vAFAWebteaqt67asWPfIUBxKYEuYt9IbqYsqxxkifb2d8rF++zBaPUray8Kd
         3QMI63XvglFpMilnPnKQaVVZkWl8xSMjvxmQbxieOILT2Hoo2iVGfrksdWPkBxTJDsp0
         RXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752062380; x=1752667180;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VwaoJLiJYF12OSK8rGI95sJddGwuByNYIOGTk/ksVzQ=;
        b=qF8wUyGcs63OAcPnoGCZRhzu11A3Qop+W4YdKHsoi+ms2Y/Ey3D9cEhz7vd1GUcHuW
         YQet4BcJZ3mO8+IzX6cOHmlOWrHll1YwyqTODytvqHD8h9uvJOWK5Smt67eegFSCWWbJ
         BIUD5tUPOJjrnWN9GpoCjDsV3MPj4tgHia1Wgg+5ZbG3dgfiOY39HNamTaETnHnWXRHF
         yR+V/hTchlFqUV6GWMTaduu/IIXeF6i7eRgYOQAvJKcgIsTFDlkX9Dj1livG8YZsZTgc
         OiTIgM8Uzsq5sP0WiycahPLxISjn3GBYXk4UfQnmi+IjAu4isokvxQY1fPUG+xn1AW5z
         hQNA==
X-Forwarded-Encrypted: i=1; AJvYcCUIcxkHjX410p2d7pjIrzRoX5KcTSm5xI/MbiFhTLXGXuMiNbYUO+4lhQeeTjWy80b4BsqF3/FIEgGP/gE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDciyWK8kVbwsxt6Y6vvJ/9qtDRdbHPkguffaLTAbEL+e284kT
	BNpH1qHAHTEGAy/gOjbP8vQr5/pwTajYekHJ8ipN1MVgKzjIgMlZX4rGO77v2/waO5U=
X-Gm-Gg: ASbGncuh/+5D0LxqYrFbV3knTs5gESJMy+ZvZTHvRfWk40HngUdYMhVCmcPPRH2FEsm
	sDLg/JXrglgu0J1B+dCcV2KNYBnn0N0WtLGbVa9TSO7ktJurhnXuZLbKJGLfARW7avBpajKB/qm
	Tsj53qCDqfe81btWewyBvEcgb9qkhlomnnZWY46H7WI9mbMTi3CcJzf2gzeaQ0x8doDtaoPGYtK
	X8n9QA78dQZ3+ReH8Iuw7rGgr7drQz/TbMW85oSiS4dLwruHPKIclnjR1nV3XkkKmT+k0pvrj1Z
	8oAFyftPkukFEMwchH/mg7HpzngxOtwg3teiIyhJ3zEzOJd5mDWEOOWJ4EKq3i1Y3K3HdMLL0nm
	gvy6IDgvY6UgqBQVLHk2ujr4fB2JkDdGwZEzAACv01Q==
X-Google-Smtp-Source: AGHT+IF5M43gbb1VPZRgUmXUN6Xh1tAveUbZcs0w5aMrTx9Nx/yzR4T2sKl+aY7FPc+zZ1BgthqpOg==
X-Received: by 2002:a17:907:9708:b0:ae3:5f74:11fd with SMTP id a640c23a62f3a-ae6cf5e8e9bmr206052066b.23.1752062379715;
        Wed, 09 Jul 2025 04:59:39 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6d7fc3584sm76721666b.62.2025.07.09.04.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 04:59:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Jul 2025 13:59:38 +0200
Message-Id: <DB7IA132RX61.200FUO5T7L3I8@fairphone.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Javier Martinez Canillas"
 <javierm@redhat.com>, "Helge Deller" <deller@gmx.de>,
 <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] drm/sysfb: simpledrm: Add support for
 interconnect paths
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
 <20250623-simple-drm-fb-icc-v2-3-f69b86cd3d7d@fairphone.com>
 <ypjcqiyfzjobg4zsm5sowjtu6ctvzgd4bvt3wpbqbb7o7f3rcm@q454aob3wwth>
In-Reply-To: <ypjcqiyfzjobg4zsm5sowjtu6ctvzgd4bvt3wpbqbb7o7f3rcm@q454aob3wwth>

Hi Dmitry,

On Sun Jul 6, 2025 at 1:14 PM CEST, Dmitry Baryshkov wrote:
> On Mon, Jun 23, 2025 at 08:44:47AM +0200, Luca Weiss wrote:
>> Some devices might require keeping an interconnect path alive so that
>> the framebuffer continues working. Add support for that by setting the
>> bandwidth requirements appropriately for all provided interconnect
>> paths.
>>=20
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>  drivers/gpu/drm/sysfb/simpledrm.c | 83 ++++++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 83 insertions(+)
>
> If simpledrm is being replaced by a proper DRM driver (thus removing
> those extra votes), will it prevent ICC device from reaching the sync
> state?

How can I try this out? On Milos I don't have MDSS yet but I can add an
interconnect path on another device to try it.

Are there some prints I can enable, or check sysfs/debugfs to see if it
reached sync state?

I only recall seeing sync_state pending warnings in some instances, but
never that it's synced.

Regards
Luca

