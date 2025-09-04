Return-Path: <linux-kernel+bounces-801806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58387B44A29
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 01:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B86540D62
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B041D2ECD21;
	Thu,  4 Sep 2025 23:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I67m+Bs0"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CEA2EDD69;
	Thu,  4 Sep 2025 23:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757027201; cv=none; b=cPJND4xvXxfXqtoTOsx3geIhNBKlSDPsjFknFBBi8J6Bi72s07FdhfxokqVLJwuy48D1HKxptkmUvUK/1cnC7JG6awU9FPdvw610Ozle4JN+4rJvEGBxhLoxixALXU8WixUGcgYUCG3jIfFggqvoXiUQpDmxw+J9pteM/1D5JvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757027201; c=relaxed/simple;
	bh=ZuEO4PslU/pm55gCZ905+7/xl3aHK66V3E8iOO5lwR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5vObGB3kkzp8UiFpumF0Auln2JY3bKacG4Otp/4xtNKYV/v/BDoQjmFF9uH+RSDb9N1EyA9CnOO4phqbZHmuOKAmRQ2Oe2/Ts9n7xeDFR6ukFgLqKnMMfgrybLAMc0KssQ/67pebe6OQsBBMEFVSrm4TORR8PLg1dQt+b5r0UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I67m+Bs0; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d601859f5so15831197b3.0;
        Thu, 04 Sep 2025 16:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757027198; x=1757631998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zz0GiMYb44SvgwnTpnJ1WiT4G0dl9xf04AReEOrfC2g=;
        b=I67m+Bs0OpKmD+ppEqYmE04x2sd81nJpqZUo+vt0CD2ZNgonul201Chi4wVinty0Yv
         wIsV1mRokFlURA85KXj+HXZTN/2tcwuZlpTQqYjXBUDd5HdjxqJ6F2WqvosNUVu3IT1N
         jtkZemZBRvy19syNQiiGcNjkA/Ph2Z5dgrBG90VQhhtsBX3kdgEXfp3JtAXs+YMsDf5j
         Rydf05O9SaUXfpZC19nAZT+KUP1/FGEcfbocsDT+AyfVnYrDr2C0yzHDQ2o+GclUJyZw
         rjShV6uOgMvPdim2NnU/xOpQT4j8XjiyMiZwLgkEJzdudUtx4hoqiB5+y+8isNMaO5vo
         s4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757027198; x=1757631998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zz0GiMYb44SvgwnTpnJ1WiT4G0dl9xf04AReEOrfC2g=;
        b=NyXri6fWfPvifKEWy4Ulry6fWk1BcRC8xdfHusED96TEDlgEXH1hYuiHT2pkJDaJnn
         5YXX1oJTelvRuEIDmr4+8pAVbi+NIFodHLaQeJro1LDb0MM1ukIP98wlaZPZMyofPr2w
         M7GadvR0nFK6N+fcH0r1UHAYydbRdWkJikpx43nFlGolsJwxWnz2vFgVU8jhrk4MrUht
         rSQgWc4XKTPfx+FSYw7zWj5HnNx/nyEGjGGuIbuiTH0GPuZ1Hn/65V5sA7w939Lz8T9b
         fZZJtKvzP7rImadJfXKN1AEbGespwmbt2eFIr/BZFdPcMlB+HssZJrz9zfsAbbVQBqs9
         gP4A==
X-Forwarded-Encrypted: i=1; AJvYcCVKWgCwWVELK/0efPzO+tyzSGIJK/vjgij2HGbpeBis2kuIibNLrE2sHhG89bkyWBtObNhJ3RyCtetyjV0H@vger.kernel.org, AJvYcCWdkmbhvJts4VzynES0lGHDEVM9BoonAqdgOqMbsNjtQoRkQsBHZGH13KPTV8xc9vLE6N2HdZmhHV5S@vger.kernel.org
X-Gm-Message-State: AOJu0YzdQDPd/YUX3XMqPRADPJyOBZQW3OKRjgcJLu9bPhyWSFz0jCDj
	HzwEXSVeUejzu19R7HSCZ+hYvOoRLXq2y8Z7kewH3/QFSpsgAC//ztq9Zc6Wzqrc+WWx9TQG8el
	x8Xw+3Aihgx1lFyRIamNO2gX8vfqYBoI=
X-Gm-Gg: ASbGncuX6e7zxwruoy2qLm1UD8t1crJNkbLcSIthpnyZAHoMGFJBzSwc14BhBeLM1OV
	IUzWhkW5yXnVn31f53sE8uUj65vzkROR1t9Afo9OSVzXMaxzmN5RYf1bu2lzh1FCrkVX3LmZKG/
	T22yaiYyH/am4w3tbPC7RhgpcoFvKtIrxrJqSwcJl15Qa8De3YIcS+YMxe2sW2l2W+qxSnJllg1
	9uOx+wq7F0ixmqSLYS+vB4ItOF4FUC/j6zNVucYtuvyfrPtOp+BWDARgOy4vnB3r9r+BVke3eey
	MUQOfOOOsw82x/YtEQ==
X-Google-Smtp-Source: AGHT+IH/UOPapUe67ml8mQg2G5ZORmPRUqKua+tHRBkgLjhGsyEaV9W6C1STKBiXSzNdaKZDJ9D9LdHr4bJeBLGW/a0=
X-Received: by 2002:a05:690c:dcd:b0:721:5b31:54ce with SMTP id
 00721157ae682-722764fe1e2mr215403527b3.31.1757027198220; Thu, 04 Sep 2025
 16:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903225504.542268-1-olvaffe@gmail.com> <20250903225504.542268-3-olvaffe@gmail.com>
 <20250904080239.779b5e24@fedora>
In-Reply-To: <20250904080239.779b5e24@fedora>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Thu, 4 Sep 2025 16:06:26 -0700
X-Gm-Features: Ac12FXzcL3-czZFvhjU2Mujq6i9ZrXWDYBfA8bIrDPlQ3iKdmOHkCSCvjxw7aN8
Message-ID: <CAPaKu7RdpEtwqDHrjt4HJOJVYeRjUa38Sk70=6dD9WmXYtf_jw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] drm/panthor: add initial mt8196 support
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:02=E2=80=AFPM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Wed,  3 Sep 2025 15:55:04 -0700
> Chia-I Wu <olvaffe@gmail.com> wrote:
>
> > diff --git a/drivers/gpu/drm/panthor/Makefile b/drivers/gpu/drm/panthor=
/Makefile
> > index 02db21748c125..75e92c461304b 100644
> > --- a/drivers/gpu/drm/panthor/Makefile
> > +++ b/drivers/gpu/drm/panthor/Makefile
> > @@ -12,4 +12,6 @@ panthor-y :=3D \
> >       panthor_mmu.o \
> >       panthor_sched.o
> >
> > +panthor-$(CONFIG_DRM_PANTHOR_SOC_MT8196) +=3D panthor_soc_mt8196.o
>
> Based on the stuff you describe (ASN hash, core mask read from an nvmem
> cell, extra clks/regulators?), I don't think we need per-soc source
> files and per-soc config options. If it becomes too HW specific (no
> abstraction to make it SoC-agnostic), we can reconsider the per-SoC
> file approach, but I believe it can all live in panthor_drv.c for now.
That's about right except no extra clk/regulator is needed.

gpueb on mt8196 is yet another mcu running on its own fw.  It can
provide clk/regulator to panthor and no change is needed from panthor.
But it can also do dvfs autonomously, in which case panthor needs to
be modified to make clk/regulator/devfreq optional.  I think the
latter is where Nicolas Frattaroli is going and requires more invasive
integration.

