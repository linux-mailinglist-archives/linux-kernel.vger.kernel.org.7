Return-Path: <linux-kernel+bounces-739636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7358B0C8F0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923261AA53EF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B7D2E0937;
	Mon, 21 Jul 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJbmZ1AM"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80892C9D;
	Mon, 21 Jul 2025 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753115919; cv=none; b=kzN7/fEtdGHiS0pJ04QI5RTVD+8nJAchHRumCL/6FN0NBvfAfKgAyV8hfoMq3mOloWN82q/6JoyY61NxmFRvUaESISc3LamTGqphqanJllPIvrAnrlroj7cMPLNj4I/LQfNzmMdE5x1aP9F5es4HSQUmRlkcgrXEUovyAnwtjZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753115919; c=relaxed/simple;
	bh=GZcCzlBfT2NvXytdLmbA4cz+wP+XZdy/SRAxWTEL7jU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qb+dGd4HTS0Nn0a6N+EnkZswXz7e9v1ccaIfJQEcil03sr0zrLjb86F/PcRVIpp854/McjZ2D1431cQV05/+tOyiJKMTBLJIkt/wt220rwLL09Tkn00F8lOkJt5dZFkrUZTf/YNw0gz4J5wlyjFSKj2E/usRUCgvJ3zz83TfMKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJbmZ1AM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a4f379662cso3387393f8f.0;
        Mon, 21 Jul 2025 09:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753115916; x=1753720716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uUOTIvoTJxFo89UBip1+cBZSnUVuP5x6V/Hb7NNPpE=;
        b=ZJbmZ1AMYupdmJxEfPS8rQZSLa10DOGLKzEziEuPhwqiv0OJHee/YNv3rUMTegL2Y2
         BFK48gwpqOcuyCvIOkg6wmLaJyvYLPRHdDl5w56EFWh2gbnRVLEPfml9PwRdiAT8I1wL
         O3Q18GBUL4tNXRDHgCcDOQKzJfd5S7ERKrAkxdTvxRQuZzhWp7z+xgTToczrl+g3cWoA
         VRhWfBHJssjqjhcKTfeKxKm1iiNT3KB1eZQZvpp4aURpPQygnYlWyZU3f/YG/qV97xP2
         XBqgDcYAtcw+0NWbgmhgXEl6zf8VmOziOx50h2QVPFZG9mjY+clrVlimQDJnje8CiDKA
         QeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753115916; x=1753720716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uUOTIvoTJxFo89UBip1+cBZSnUVuP5x6V/Hb7NNPpE=;
        b=aP45UfLzUO2L+g3hml1Mj4gKapWbacT5GnDm6P06+igiTn2wMNLn9lHXL7pKzwgBKF
         IQu3zgNfMgBiFp5Ia6gVq5nilYPNE0av7AJjihUZK5mDkXIyLJ1LpnfMD3LJTQuQS7IY
         eI2iUTtpH/nHag0UbOEE1y7BFIvr0Dwy60yJvGP278dFaXVZxIpDpL80QqdYnQoSrKoC
         MfBgAZx9M+PJ5DKyzuvNlP8xNVif3ozzi1rB0oRM8WfDWVGr5FABbiDVFlZtJfL7Zh/F
         IiJ5U+oDNCtGUrX+b8vYyOoUNQiAHb6uG4KBwLjYxHpiTV/m8ftMhY/jstQ9VeEFTsxE
         uOZg==
X-Forwarded-Encrypted: i=1; AJvYcCWOn2lXr9zbYEJcKc57z5ONROh6qwhdDIR5qYlnbyu/hdb4uT9E/6mPOVGiTDcEXGI5CAY2rmuMMC/J@vger.kernel.org, AJvYcCXTsut6wniLFqGGnr+J2NIeHVPCpi+JG18EJDWdF2aZBwVUEp/6JiA+MWY9RdGZ9cjbtT9UcPUSpTd4U8tQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwEVtTox80fKeoYAdbP6PxyLxw8H0XXSlB6Aw4ymv9OwCMBYhTU
	cgwMN/a9+K5A3AlibVHZTmlusJeCPGQDR5ykt4oo2cTlZ+qLrYjL4BDuR4Ag8P/OnI++addwy36
	LVBdCHAIn0EcsNWbo0+rPRtySAs9rU28=
X-Gm-Gg: ASbGncvR+wN7MM595RzKI5bkvm8uzFLFqzAS4xXVJGsWRDNOpZKxl1JIZ9b9TtpDrnB
	id8yQzo8jWp1LgNMnVJ73W2mTP/VMAlpB2K2nzDc5M9pG+3uDtHVRol2iDUIQ0EDep/qXHl+ihv
	M9UsUvjUW9CSOywcNUM1QiIwu4KDV3lWT2Yt1T7TeuUZoZPoTEWvaBoH68vBSyYhB9X3Q52gGO5
	tlGbAMR
X-Google-Smtp-Source: AGHT+IGlzn+4WfqAWOh8uTdl+e8On+3Kash2k8WlA3OHsyAZo5snlc+j9GV9vcvotImaJPaQSwEoqWJS7yqyO5z8XDg=
X-Received: by 2002:a05:6000:460b:b0:3a5:21c8:af31 with SMTP id
 ffacd0b85a97d-3b60e4c237emr14967601f8f.16.1753115915693; Mon, 21 Jul 2025
 09:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623081504.58622-1-clamor95@gmail.com>
In-Reply-To: <20250623081504.58622-1-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 21 Jul 2025 19:38:24 +0300
X-Gm-Features: Ac12FXwbnrdf-VhDMDnvkeKl4abpgx2aYEoEhRZtmyyVrTx_bhPpP6J_3HsgyAI
Message-ID: <CAPVz0n38N32HobYshtS9cLBJqWGPA1MZjMr0HH3C4UqGcFaFVA@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] drm: bridge: add ssd2825 RGB/DSI bridge support
To: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 23 =D1=87=D0=B5=D1=80=D0=B2. 2025=E2=80=AF=D1=80. =D0=BE 11:1=
5 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Solomon SSD2825 is a RGB to MIPI DSI bridge used in LG Optimus 4D P880
> and LG Optimus Vu P895
>
> ---
> Changes on switching from v6 to v7:
> - removed enabled checks
> - configuration complete quirk moved from host_transfer to
>   atomic_enable
> - switched to devm_drm_bridge_alloc
> - removed redundant dev_set_drvdata use
>
> Changes on switching from v5 to v6:
> - set correct module name in Kconfig help
> - return error if spi sync failed for reading
>
> Changes on switching from v4 to v5:
> - rebased on top of drm-misc-next with adjustments to fit
>
> Changes on switching from v3 to v4:
> - no changes, resend
>
> Changes on switching from v2 to v3:
> - added mutex guard
> - configuration register flags parametrized using panel flags
> - removed unneded debug messages
> - removed unimplemented modes checks
> - added check for maximum pixel row length
> - use types header
> - remove ssd2825_to_ns
> - shift bridge setup into atomic pre-enable
> - cleaned default values of hzd and hpd
>
> Changes on switching from v1 to v2:
> - added description for clock
> - removed clock-names
> - added boundries for hs-zero-delay-ns and hs-prep-delay-ns
> - added mutex lock for host transfers
> - converted to atomic ops
> - get drm_display_mode mode with atomic helpers
> - parameterized INTERFACE_CTRL_REG_6 configuration
> - added video mode validation and fixup
> - removed clock name
> - switched to devm_regulator_bulk_get_const
> - added default timings
> ---
>
> Svyatoslav Ryhel (2):
>   dt-bindings: display: bridge: Document Solomon SSD2825
>   drm: bridge: Add support for Solomon SSD2825 RGB/DSI bridge
>
>  .../display/bridge/solomon,ssd2825.yaml       | 141 ++++
>  drivers/gpu/drm/bridge/Kconfig                |  13 +
>  drivers/gpu/drm/bridge/Makefile               |   1 +
>  drivers/gpu/drm/bridge/ssd2825.c              | 775 ++++++++++++++++++
>  4 files changed, 930 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/solo=
mon,ssd2825.yaml
>  create mode 100644 drivers/gpu/drm/bridge/ssd2825.c
>
> --
> 2.48.1
>

Greetings!

These patches had no activity/feedback from maintainers for almost a
month, so, in case they got lost in the depths of email box, this is a
friendly reminder that they are still relevant and I would like them
to move on.

Best regards,
Svyatoslav R.

