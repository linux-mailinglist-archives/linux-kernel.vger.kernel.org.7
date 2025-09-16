Return-Path: <linux-kernel+bounces-819032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD982B59A65
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA51F3BC498
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28CD31E0FD;
	Tue, 16 Sep 2025 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kDtnJkv6"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A1F28B7DA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033056; cv=none; b=CoFAm5js9kyvRHargCezwvRLf19tugCauvZxhIzoBLqShtppLrSK0K/8KZQAwrEANMXfZJ2b+hFoh27oAReE5/ENtDJSVQ8WnFA6i0X25fhO7TNFBpEKSZRi8ItWRLGwwEomljQvphEx+gNz8k/eqr703oxdaVrwpZJIQUv9C8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033056; c=relaxed/simple;
	bh=7yYcx+PfwWgDTCyvf4xJyoeS4icmM+bVNdZS7wZmrS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyGZM/J4VYqJt2WKYe4tolE3i+HDwc9HRyEs6oy7pLs66m0UqaeCr9jqxRAjx84Mc4QjJmUcX9+fHMqkBCXq9CmJDlf8F7kO7eX79xlfUuqK2P93HCR+fTl5COL4aQP9Rj6XyQg7kpxiXJlNV7gLug/qyol4EsZ9lOu+Zj4AgFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kDtnJkv6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77b0a93e067so484467b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758033051; x=1758637851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiffAS7cC9zkCAeD5hrwe++ErwkU044VbYitXleZroU=;
        b=kDtnJkv6Cnv327iH9MKZVOVJsEpQz+tZlpLBgBb3rd/MDsypVboIx+dCDjPwnNiyZ9
         0plZj/8Uj1lgdWPeCKNiDbJ1v2FwjD6zaKI6IcKtiqQWbZsfsjP1s7XR0HR1RITPnD2M
         a2cfx1hfIZneyvDONznuSbEUBM/qtbMOwRUbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758033051; x=1758637851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiffAS7cC9zkCAeD5hrwe++ErwkU044VbYitXleZroU=;
        b=NLIMapTv8G0D1YnGExg39zZPyVsxEWZwssgipdJVnis0uXc1XacK36s0AbGq6+hH3d
         CRx2j50uvy7+fqgXNWZysSH/UX0qM/iNb8DR2u+SNYdzv9G1ztEf3XaHGtyDkRz6pf95
         YrcvOzQqhVmEjRA3ixTe9VXQ0dJuVo/bsDs6ffpYQPVmfyFIqWltv8Vm4HRSWiLSkV2E
         KvcohrjmNLGHUHFmKHPT58JalPYClshILoS01icpct/Zgr11KbgphQu4XnmSUb6dObH2
         B7aD0eEyInp0eS9Q0VLMXYcmS7gX+U1HAOOJQibsT+PPeQQXfRoWNyryR7H4nGfwMung
         KGyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUspenNJo+uybD5K8iD+pUDpU0BHA42eRqR+QRe1Y5B4X3WzIsEdyS70dB1fRkYNpj+9GOBk7ccmMrPMmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YycMLrEnbRFQ4Hm7xDQyoyvIfybF0Rwl8xNqhjA7TlqWhhy8o6j
	xJs/wW7MzZWx/pC1vifEf8M7p4TWVMIm0n8UqbwZxdWSoGViFhUjdlGvzqq3xPeNn1uHJ3JPryd
	83kc=
X-Gm-Gg: ASbGncuIvzdnHEqrldYfYIsQLMb9MumE29P6vDs9tKYOrbCSOuoiIl5QvI00XFY6ZMg
	aFKlylUAhYJblEr8COVtF+jELK/y7bHcgQFWQnxiHccPqVK8GYaUALy64vhWMuXKrnxyXnRozgJ
	ubtnFfABYiEWj8jm+v46ZLKyI+LPqjIiTcA/WLvZBygWdAWKV3ZTBT/gP0RM70CPW/VZHfU8y8C
	lGOMVn8TwjwJo2+pvif4Nq/ZaB0a/CLN2moQIYp0cE7DqM71o/eVm7x6wn1n7mVwWJZEJkikCD8
	tvMWq2CFmrHdCVqVFb7bJmg39TAhv2+XXMArcav2Ropye2g/RmGaIHemkVYaqDEHd2TnEwsbgfZ
	IwbYhcSfmPXc3EXzVrcets90AZzuShFe+hX7cvDFLfx9z+2xOkWxHYY6jF8XQQ3oE7A==
X-Google-Smtp-Source: AGHT+IFbqQdLB/x7JMmUC3gC4/SA8lilgaZvhwdPjxBVxSNVSNfnnSzgxsMYZgQai4H7N+5YAS0+dQ==
X-Received: by 2002:a05:6a20:1586:b0:24c:af7e:e55 with SMTP id adf61e73a8af0-2602a593825mr21234035637.10.1758033049355;
        Tue, 16 Sep 2025 07:30:49 -0700 (PDT)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com. [209.85.215.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760955263fsm15937859b3a.8.2025.09.16.07.30.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 07:30:48 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b52047b3f19so3869825a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:30:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEsgFKnY22t0E4j06bEejMEVFZG8k8ALWdGXyi5lz58ZeIAtiPhmGSnuqua1tM0liircK7q6S5kUNcR2I=@vger.kernel.org
X-Received: by 2002:a17:903:3885:b0:267:fac6:f099 with SMTP id
 d9443c01a7336-267fac6f0bdmr882655ad.38.1758033047184; Tue, 16 Sep 2025
 07:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910183353.2045339-1-john.ripple@keysight.com> <202509161344.FPfsjq01-lkp@intel.com>
In-Reply-To: <202509161344.FPfsjq01-lkp@intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 16 Sep 2025 07:30:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VZ8=o3D4iQ+hMFKup+8LuUh74BOyf7YLX-VHRkcU7TrA@mail.gmail.com>
X-Gm-Features: AS18NWDcO5yWc3JLU6eUzWEdoHiHgHWEJMNFpIAQ3YTFuxgHuOAPRPJlbYq6e8M
Message-ID: <CAD=FV=VZ8=o3D4iQ+hMFKup+8LuUh74BOyf7YLX-VHRkcU7TrA@mail.gmail.com>
Subject: Re: [PATCH V3] drm/bridge: ti-sn65dsi86: Add support for DisplayPort
 mode with HPD
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, John Ripple <john.ripple@keysight.com>, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev, Laurent.pinchart@ideasonboard.com, 
	airlied@gmail.com, andrzej.hajda@intel.com, blake.vermeer@keysight.com, 
	dri-devel@lists.freedesktop.org, jernej.skrabec@gmail.com, jonas@kwiboo.se, 
	linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
	matt_laubhan@keysight.com, mripard@kernel.org, neil.armstrong@linaro.org, 
	rfoss@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 15, 2025 at 10:46=E2=80=AFPM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> Hi John,
>
> kernel test robot noticed the following build warnings:
>
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/UPDATE-20250911-02=
3707/John-Ripple/drm-bridge-ti-sn65dsi86-break-probe-dependency-loop/202508=
20-235209
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20250910183353.2045339-1-john.ri=
pple%40keysight.com
> patch subject: [PATCH V3] drm/bridge: ti-sn65dsi86: Add support for Displ=
ayPort mode with HPD
> config: x86_64-randconfig-161-20250916 (https://download.01.org/0day-ci/a=
rchive/20250916/202509161344.FPfsjq01-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202509161344.FPfsjq01-lkp@intel.com/
>
> smatch warnings:
> drivers/gpu/drm/bridge/ti-sn65dsi86.c:1385 ti_sn_bridge_interrupt() error=
: uninitialized symbol 'status'.
>
> vim +/status +1385 drivers/gpu/drm/bridge/ti-sn65dsi86.c
>
> b8670cf7e6a41b John Ripple  2025-09-10  1365  static irqreturn_t ti_sn_br=
idge_interrupt(int irq, void *private)
> b8670cf7e6a41b John Ripple  2025-09-10  1366  {
> b8670cf7e6a41b John Ripple  2025-09-10  1367    struct ti_sn65dsi86 *pdat=
a =3D private;
> b8670cf7e6a41b John Ripple  2025-09-10  1368    struct drm_device *dev =
=3D pdata->bridge.dev;
> b8670cf7e6a41b John Ripple  2025-09-10  1369    u8 status;
> b8670cf7e6a41b John Ripple  2025-09-10  1370    int ret;
> b8670cf7e6a41b John Ripple  2025-09-10  1371    bool hpd_event =3D false;
> b8670cf7e6a41b John Ripple  2025-09-10  1372
> b8670cf7e6a41b John Ripple  2025-09-10  1373    mutex_lock(&pdata->hpd_mu=
tex);
> b8670cf7e6a41b John Ripple  2025-09-10  1374    if (!pdata->hpd_enabled) =
{
> b8670cf7e6a41b John Ripple  2025-09-10  1375            mutex_unlock(&pda=
ta->hpd_mutex);
> b8670cf7e6a41b John Ripple  2025-09-10  1376            return IRQ_HANDLE=
D;
> b8670cf7e6a41b John Ripple  2025-09-10  1377    }
> b8670cf7e6a41b John Ripple  2025-09-10  1378
> b8670cf7e6a41b John Ripple  2025-09-10  1379    ret =3D ti_sn65dsi86_read=
_u8(pdata, SN_IRQ_STATUS_REG, &status);
> b8670cf7e6a41b John Ripple  2025-09-10  1380    if (ret)
> b8670cf7e6a41b John Ripple  2025-09-10  1381            pr_err("Failed to=
 read IRQ status: %d\n", ret);
>
> status isn't initialized on error.
>
> b8670cf7e6a41b John Ripple  2025-09-10  1382    else
> b8670cf7e6a41b John Ripple  2025-09-10  1383            hpd_event =3D sta=
tus & (HPD_REMOVAL_STATUS | HPD_INSERTION_STATUS);
> b8670cf7e6a41b John Ripple  2025-09-10  1384
> b8670cf7e6a41b John Ripple  2025-09-10 @1385    if (status) {
>                                                     ^^^^^^
> warning

It looks like the bot reported this on an old version. The newest is
v7 [1] and things should be OK there. Yell if I missed something. :-)

[1] https:/lore.kernel.org/r/20250915174543.2564994-1-john.ripple@keysight.=
com

