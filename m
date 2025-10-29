Return-Path: <linux-kernel+bounces-876635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7E0C1BE9B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBD419C0C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E989833F39E;
	Wed, 29 Oct 2025 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkjEseJZ"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A393F34BA40
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753632; cv=none; b=kSbnoKLaZZNNIez3zQbbTZ3SUivQ4/+se1DdhNrfpwV1HDRPuKI84iWKWkUl5D26nvUWxvocB/CGq3s71ABbjAve3GQQgYuoCbaN4VT7kxr130RyL3qtsfswl9gngNZsRoZjVItu7TkFRWS2XRON8mQLj2PBRCGGpkSDzchenz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753632; c=relaxed/simple;
	bh=QjbKfgzHn5tyeA0m3V5JJ3BLODA9JPFCp9Sk+QT8tK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hk1cMftz1DeRbguzONK6fZkjjUof/fEmEUxfBR6gsRMKjVUVKzhlSBEqJbYdeW03hnWpxqpAOdszBGxTyV7m5v8qKrTsOx3g8XlEyN487wiNSHuteQxp37dsd5rUGbnBZet0ppITTE3ZWwhZcqNYPka+GQ+198owmqsw2R1oz+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkjEseJZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-475dbc3c9efso35221085e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753629; x=1762358429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjbKfgzHn5tyeA0m3V5JJ3BLODA9JPFCp9Sk+QT8tK8=;
        b=JkjEseJZKoHhnNYyso0khj5Qx3qxvZe9I2U0THqGOb5T3Nj6EEGXln5MhmFuO93w2H
         VvLp1BC+Da7Oad+gyfH8kudsV3nizxestNRGjdvtuZHprDUlw2msgKiUg1MspMKwJ7SV
         KAQ9HbJkDgUIKbysEEWFF0YkBDfip4zbOeXnsZsG6EbJXCp+YRcC2IMtBWHMlS9O9ss5
         DmtGWznn8LkffHhvVvoaCRWfG28FBES3AL2XuUjqYDmJI3BtN9QfdSZ3EEETLq0d4pz1
         Hn2qnCp4s88IzwlayCDMav5FTvsaUTN+BohEYzOfuyvCPLF8d/KjvIB7koupNJvGp+Pb
         aCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753629; x=1762358429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjbKfgzHn5tyeA0m3V5JJ3BLODA9JPFCp9Sk+QT8tK8=;
        b=DXTSYu7FqLarKZSQPSAwqc6hoZyAAUxi69vd3cUTrY0q3L1mSCjrWbAJKmMX+itu2E
         zV6rgOhOWjue+JkB0FA3lhST226cMIAz6+9PisQQVO+9H84WtF7tNSv0hiy3Q10ihV5m
         iXahEPf+UquoVvgSNBis7xZ6h4mVTpOnTYfRFsN96NsCcqEh9Kux73SttTgW+e+/hy6N
         jeVak/FTzZqDUs1fYsUElqQAqv7RquMmqaz4kp7dRgSsiLNljyMckdTkt/mVlbW/TDgg
         0TkUlQYBvVpVqm3WXC8ffuLvOFWV1XH0kQ7ksLqr439x8+iMkrvj8HAq+ieIy3Nuxft6
         Y4ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUhtExH5TwUI84Ds4U4sd9FYyL5yfmFzzCSsFC+ixr0XyDQo/9Zyw7b/LeHqINt1DgQQcw3dGr+EkgTk/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfF36QYEF6IW6Tsb+EMUNzxaqu3ZB/pix6ubSB39P2ewFq1Wqr
	7Lfdfr9YJNHBMm1QomUcKSn3d/nmOC0y6W5S8eFgAT4sDy5GlkaIvcBE
X-Gm-Gg: ASbGnctAdKMSnoD5j0jrMHIkA+yhtBs+RZ+cX278T5qBqxfJ6oicQTUg4+BNEm4rGEO
	XqGF8WnzY1XXLD+yOVCtM4Ut94EGOxmD0aNT1p299Q+FQfdVUdFu70FWamlhKF6D+YPW4X/1uyp
	2BS6gf7VZBZ0d6lOUlJHhwFBQmm/WQc1lIGNCQFMdpTr19g3vIs+9XuZo5eT32JlPog16KMnMgb
	mlyczJ3QeIgyOCs1ir3XY2QHJoyukmNWqtxd0N6mXzBABjAZBmXNNTe/Go+DURGq2WVSAbAR8Vf
	4D8JOSXKm5KROUhnS6ft4TlGRFKtgl/jojQYCaOnK95GMaJdm9gtapAHzAbllOqhiSeyOx1yX+e
	lYIXFJWwI0upnW/1MBXd3dD+fexdw8IFzJ+Jk/69u/87QJTwwJWCp3CIRnRgPTcV0WCoGhfuGqM
	pQP/M0Q3COyjDwU2J/vEByerVmmXvbTnbEi/sN9XWGaXaWHje8mqzjia4wbIz3Mpj9N21/
X-Google-Smtp-Source: AGHT+IELwKkyoHZcEXoDh+ODYAhJc1PkQChXNnF/56yRmyxyp0iQGf8PAy40wU0hq97LrnXaNPX15Q==
X-Received: by 2002:a05:600c:848a:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-4771e21c484mr25812165e9.21.1761753628706;
        Wed, 29 Oct 2025 09:00:28 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3a8209sm54097015e9.11.2025.10.29.09.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:00:28 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Samuel Holland <samuel@sholland.org>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
Cc: linmq006@gmail.com, stable@vger.kernel.org
Subject:
 Re: [PATCH] drm/sun4i: Fix device node reference leak in
 sun4i_tcon_of_get_id_from_port
Date: Wed, 29 Oct 2025 17:00:26 +0100
Message-ID: <3848160.MHq7AAxBmi@jernej-laptop>
In-Reply-To: <20251029074911.19265-1-linmq006@gmail.com>
References: <20251029074911.19265-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sreda, 29. oktober 2025 ob 08:49:10 Srednjeevropski standardni =C4=8Das=
 je Miaoqian Lin napisal(a):
> Fix a device node reference leak where the remote endpoint node obtained
> by of_graph_get_remote_endpoint() was not being properly released.
>=20
> Add of_node_put() calls after of_property_read_u32() to fix this.
>=20
> Fixes: e8d5bbf7f4c4 ("drm/sun4i: tcon: get TCON ID and matching engine wi=
th remote endpoint ID")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



