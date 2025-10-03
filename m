Return-Path: <linux-kernel+bounces-841786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CB9BB83A4
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 23:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 517C9346C86
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 21:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C48C26C393;
	Fri,  3 Oct 2025 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCtGk1XC"
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8789624C068
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759527755; cv=none; b=GbEWQzageMgT9JDrsfdXHjgfSEiuLn9SlQx8B4sh5wa3140EAQ557gMm/JSDB9vc6QKlXU3OxwdfiPV0AvC7PFVXXOU3i/meX4+PzTGcBURqQrBu/deqlS8Gezn0SLElrhQOXeamAXlaSoPcHe5rUv+dRP4tBjvDwgmiOhRODA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759527755; c=relaxed/simple;
	bh=Qb4Wu82O8H4woRuNaXSp6qi7XmoH0H5VI5tHbH7Spug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcftctINVpWC+umO9c1d/Kn/8XadsaboKFqfO9RCjbB+ncLLogB38k7DYFb1Kz22wcQR5hHgNtKHbCz6hyE/C+F4yYPk/KCNvJe9GNlChYBAUGcLZPJDNKLz/Nra9Ea856ss+y2zOkdWJs/70zueyeH8eNhKi87BuNNohDcg6go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCtGk1XC; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6353e91a04aso3304356d50.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 14:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759527752; x=1760132552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qb4Wu82O8H4woRuNaXSp6qi7XmoH0H5VI5tHbH7Spug=;
        b=aCtGk1XC8rRSai9BmOGOVAJin6qeyYLkH35lv2ujQWg0huQq7vywCssunW/EbXOZO8
         1wVda4MHZbI0KNHHW0YQBQOubZnVfuT/JPAhIMmi8OUamRQCTFrxDnLbWtYoaPsylkGr
         kwdyu9TjvWi2cFUcR7uWv46N5lIaf0rgQ6Z1gbZqXYZwAJcShlua+BgqWkAvIq3bqbic
         2hntgmIKwgHfKdMBZIM6pk1HuFnnIlv2EvyHAzxCMJk3aEFhy7q7UJyiRtvZnlXlw1YD
         Zx/b86ghRw206/wy6+JEzzYipnSgA8OjHIA2zFfNkKICjPI8T5hiUmH8oBq7QtRBs8Wy
         KjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759527752; x=1760132552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qb4Wu82O8H4woRuNaXSp6qi7XmoH0H5VI5tHbH7Spug=;
        b=bbR8AU+8DAB9M/EM8U3aaHK15phFTfgjuZn7B6YqENq4l3jcVedmD6gYOonlOijaOE
         gNBmxSKdphjdzittGHUAE10rwN0r4UnnkHXixJpAT+bbJpPA2v1TaSdeDzbbsLaF/SFa
         QaxHrR78wiSIktUtMYOE6lqgu7206pQ6d1dCviU7Y292d3ho+xRdofao4KymBL/8N6SZ
         UG+Stl9+V/83qhFf1YzAxaQfq0A3RbkWDXAmszR6SmKaiK8z20TUL5Ranu5ta8qMxHcS
         8fr+l/w97rEpLfXx4SbuROOhE/DBEJhnMjrjUzNCkDgDuek1PhRxqiLcsbGtfL2s9sdo
         Ad/w==
X-Forwarded-Encrypted: i=1; AJvYcCU9MdxzGvYkRIafDHuTFSLgmpo/rIUVhv2oGOYvrihviQpje6PKDOvSuLHV0KzQTH8fiLmSYgssb5isBko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUU6tf0OXZ5mk4KQnG4Pv8BHFxwVLVwLYeKimxznY40dE90An3
	aflgjGQil0jg1z6A+q9KXKXbCjpHjuw0R/s8bIBc1ktlPHrBU5YlTem6wx8M5VmIxs5VcNrZ+7J
	6JdQsIWSsihT5yTKA1DxiLOIa0aXt/nK6M50+fiY=
X-Gm-Gg: ASbGnct0zxDKZaYArn73Rb/EIHVrZiAQq8R6ezK9KW3t50o2cBwpvborzz3L9NSwKhF
	8cH/PmW/miDVEqICkfpWMLfFWeITIiE403tfSz4fInpIN2cFG3kuHRkcwCxqfcm5vkIGFTwCP3h
	ntq32XDWuVtvr9slU4jKi6WMUOnBHjf0S4+CAYlS6IeIBp4k9ARPHVlbhNL3mNEp/zrsLhaCwPT
	HweIrSy2H2tbDcqkb6HEibwyKNTlfGg0nzSqUpqMajynJlWtWdwWO+kzK7+C/xHo5vsNNmbHOhq
	F/Tb7Qb6/DHYzVQhYa+TVQ==
X-Google-Smtp-Source: AGHT+IFpa62J3F001fD6gEmxASZM+7hprfmJdW+U2IPWM14bwbGqXpUXslnfVMopKEr/h/JVkCYbZZaxq7ZVg2GVzCI=
X-Received: by 2002:a05:690c:6085:b0:726:37ae:95a0 with SMTP id
 00721157ae682-77f947377dbmr63264647b3.47.1759527752486; Fri, 03 Oct 2025
 14:42:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003-mt8196-gpufreq-v6-0-76498ad61d9e@collabora.com>
 <20251003-mt8196-gpufreq-v6-7-76498ad61d9e@collabora.com> <CAPaKu7QWBShwr+YhFi+nUFo0kJ06k4PK3zggcCefWGjqUmTx5w@mail.gmail.com>
In-Reply-To: <CAPaKu7QWBShwr+YhFi+nUFo0kJ06k4PK3zggcCefWGjqUmTx5w@mail.gmail.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Fri, 3 Oct 2025 14:42:21 -0700
X-Gm-Features: AS18NWBXV7Dg7kjMsva2cG1ZX6ySiRudcCipxqw2a3pxKBvNUjFKzkOnT-TXcr4
Message-ID: <CAPaKu7SK=st9FkU+i25MOwBnBPQYpiBxS7-1nnerdBCiPnHy3A@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] pmdomain: mediatek: Add support for MFlexGraphics
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Chen-Yu Tsai <wenst@chromium.org>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 2:41=E2=80=AFPM Chia-I Wu <olvaffe@gmail.com> wrote:
>
> On Fri, Oct 3, 2025 at 1:16=E2=80=AFPM Nicolas Frattaroli
> <nicolas.frattaroli@collabora.com> wrote:
> >
> > Various MediaTek SoCs use GPU integration silicon named "MFlexGraphics"
> > by MediaTek. On the MT8196 and MT6991 SoCs, interacting with this
> > integration silicon is required to power on the GPU.
> >
> > This glue silicon is in the form of an embedded microcontroller running
> > special-purpose firmware, which autonomously adjusts clocks and
> > regulators.
> >
> > Implement a driver, modelled as a pmdomain driver with a
> > set_performance_state operation, to support these SoCs.
> I like this model a lot. Thanks!
>
> panthor might potentially need to interact with this driver beyond
> what pmdomain provides. I am thinking about querying
> GF_REG_SHADER_PRESENT. Not sure if we've heard back from the vendor.
> Have you considered moving this to drivers/soc/mediatek such that we
> can provide include/linux/mtk-mfg.h to panthor?
I meant to say include/linux/soc/mediatek/mtk-mfg.h.

