Return-Path: <linux-kernel+bounces-891443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B13B1C42ACD
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 10:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3560334B009
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 09:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C31238DE1;
	Sat,  8 Nov 2025 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNEdJQQl"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4584718C31
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762595207; cv=none; b=PczfQQvjRVo6r+nsNzYYDn0j1sotMCrAYzRZioQcyoSD+z2HWF0dKeXX6ItXaKgeX43dGI504NWs4vLso2/I6J/a8F5EEUr+6kj6HWoTpc2j39FFAd7cDI5Z0UCweb74T1EGXMoc2vNskZZcUX+I7rZOVCEB9Ia8TlsBT+RhsH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762595207; c=relaxed/simple;
	bh=aOwq143RKroQJvO/hjzbNHkwe922fvcvmxRe5cHZbKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBPO+vu9yl6/JlxeCGRda9K315J1yv7IlXWtoU1flv/JpeadR2CulNopUvGYNG4IE8qexfvhm35Baebxn6Iz5fABswqX+Q3j0ZsSMrg1uAssShCUsJl1SH2LfKV2x79uFse+sjU7M4XrRg6kRfXfhgrqP47kjSFQMHLx5Ds9z48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNEdJQQl; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b70bee93dc4so207076766b.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 01:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762595203; x=1763200003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSUW/WjMhCO0Veyp/5U9fPi2v4UQHFyEZLh62h16fCE=;
        b=lNEdJQQlYXO4Y3CJB92e2DG8RmRejewBi1Ohywpxq0G6I/c5zz2us8KlP1h1+I7CJS
         XiqVGoIjuVdys3is7s87rSeRTFwSGEKNDnhu/RtuM81KjKOFQBYD+CwutsgqINDJ4hGW
         S6qkywraRYGsTA+ngc/kCYSHJjMR4wLd6vClew4IVNyPd1rU7lWYxbxM7sdZMv1Ht0+7
         XbrBGH8ZH3cYsyT62diAFu/4DQQ67YpIt7utqBRFZxxXiXMY/gqsTh7fqBjDUMOO4YuC
         W1QGhxmznKV/hTw1wkejFqJedU0DXedEft+FIf+gKfK/piB70pl46YLi/IdWMPjKFda7
         Crbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762595203; x=1763200003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lSUW/WjMhCO0Veyp/5U9fPi2v4UQHFyEZLh62h16fCE=;
        b=TOcsH2Yj3kZVKXylxJVJy1L/J2YyAkQaz24Rs6aNHoEQCTtYFUMCqcZxQr5D+d7kqa
         z/ItFfzX3vSgXLMaZaHQXUS90kWn9s52Cbk/VYKIdWEyJ9kY3wr+YL/nMJIanU0ncLc6
         F8vD2HWQX6m5DsAxvEN1iHOPnHEn/f5JIWI/680cxx83Ynt7lezLaf2N8eiX0Om9pAhZ
         DSS+V+DfTCn4NF2Q7JD1Nr1JBzQ+C5OfANMqcGUIz9nCMvlLcG03HwNe5Zm0Y5cq8d6g
         4ZwHuIBhejd+TYO78S2SRIUlr6Kl0QgfDYuyRxvrl2HkGHEgfV0AYxatnzROTXC/nm4f
         eoVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVJx8+Vl78ktdF1/SNaXys9Hxuc1KhqGNG5AcRKfFWwdr04eJ5srGNk81IMkv+cv1VZug8S3UnCjiv84Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgqEuWeJLJ4Dm0P7iMQvJ6YFsJkmIIHvCDi+98f7sTptvdaDVC
	Y2y/h5Ru4xnOaCz6hkwykXjI6azx7osWlqr84Z7Wvthka5pa6o9WuMGG
X-Gm-Gg: ASbGncsNvYUtyhMuFCB0sztenpuBUT0r3RZ1j3RV2c2V8Y4zNRVM7+FNpVlv6UveuG2
	D5eN8y18kD03YtrW/SNamXGUgWNH/jBIL4wm5Q+IgzuXrM/jFoaIwi9T3CkkBOl9Y7ofx4c0kbU
	MsllaX7YvBlJcFbqTDpoYmZneBL7JVbRRM8MyStbwtpXEfZt6uvmz6IFS2aI5NLSEZsv7mksb/T
	O/6E7RtOYufgQBVtKZi1J1QqQ4jd9z24yZvs3VAzSPSOt6kTxkkuAFr7LjUaO/CdxQP5RAoqP3q
	/SPLmeZviQYJqPflH61nVHsSoSmZzUN0rxNMav9NCaMK2cvZ6Y0M4w0C0df65czMQZEiIJeWoWZ
	0nSG1JIdkIzUdEjvuZhO++yzIgaRzkoxbr143aC9zMJIeYt3nGJdlHfxSREn+eNvVLAS2HEYzvr
	Ecg0s64BL4W1PEhIN8WIZMDA==
X-Google-Smtp-Source: AGHT+IEF4CkxscNYi/C2XNylHCh280mub3VhXy2YsQtWnD+IOuCk3xiDthoT6Cd2QfMZg0xUKQ0czw==
X-Received: by 2002:a17:906:6a27:b0:b45:60ad:daf9 with SMTP id a640c23a62f3a-b72e028a602mr227544366b.3.1762595203327;
        Sat, 08 Nov 2025 01:46:43 -0800 (PST)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72d7996c4csm291514066b.5.2025.11.08.01.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 01:46:42 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Han Gao <gaohan@iscas.ac.cn>,
 Yixun Lan <dlan@gentoo.org>, Drew Fustini <fustini@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Guodong Xu <guodong@riscstar.com>, Haylen Chu <heylenay@4d2.org>,
 Joel Stanley <joel@jms.id.au>, gaohan@iscas.ac.cn
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Han Gao <rabenda.cn@gmail.com>
Subject: Re: [PATCH 0/3] riscv: soc: re-organized allwinner
Date: Sat, 08 Nov 2025 10:46:41 +0100
Message-ID: <4692596.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <cover.1762588494.git.gaohan@iscas.ac.cn>
References: <cover.1762588494.git.gaohan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Dne sobota, 8. november 2025 ob 09:20:22 Srednjeevropski standardni =C4=8Da=
s je gaohan@iscas.ac.cn napisal(a):
> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> Allwinner currently offers d1(s)/v821/v861/v881 on RISC-V,
> using different IPs.
>=20
> d1(s): Xuantie C906
> v821: Andes A27 + XuanTie E907
> v861/v881: XuanTie C907
>=20
> Han Gao (3):
>   riscv: soc: re-organized allwinner menu
>   riscv: soc: allwinner: d1: use the ARCH_SUNXI_XUANTIE
>   riscv: defconfig: enable SUNXI_XUANTIE and SUNXI_ANDES

This series is incomplete. It introduces ARCH_SUNXI_ANDES symbol but it is
never used.

Additionally, patches are not organized properly. First, you should introdu=
ce
reorganization and only then introduce new features. Also, not a single
patch should break existing functionality for bisectability reasons. First
patch breaks compilation of DT files while second restores that. This must
not happen.

Best regards,
Jernej

>=20
>  arch/riscv/Kconfig.socs                | 22 +++++++++++++++++-----
>  arch/riscv/boot/dts/allwinner/Makefile | 20 ++++++++++----------
>  arch/riscv/configs/defconfig           |  2 ++
>  3 files changed, 29 insertions(+), 15 deletions(-)
>=20
>=20





