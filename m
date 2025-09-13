Return-Path: <linux-kernel+bounces-815068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69865B55EF7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 08:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B7B47B1F30
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 06:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1162E7BA0;
	Sat, 13 Sep 2025 06:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5nDp3+G"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330D72E6CB1
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 06:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757745324; cv=none; b=KQ0RvNbCRuPJjmKp5XkDvPl29URFrb8OFRJ4/qWP3M7EMtXfwWK47+QW2R3T7WVWASdRfdTUOg6J9A/tmCWMVYwoRk1xQRTiGcM5JJDw0AqL/5/3+c1zUGhEncD8L8QHG3wIQ9ohfyuDw03T89AUC/XjtQR4m2bz5fvnqXaZ4Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757745324; c=relaxed/simple;
	bh=+MrZdmNVCG2OdQ4Nn0NGHXqto2cWIelVt/Phs7xDyRI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ldf1tUceSd3hExIBfS+EuMPDjr/EaAM4o5ly9Gw3L5ND4Iwh6c8brEHjFJJVW4OKWP71w6bylzE/YtQ3snyE81bxdq409wUktK/mydkro1O/je9QVRl5WhOmIgFQPPsDBu32NovLL4pmhbmXMnKpDISx6ORY3Y7i/7VjJ3Q8SG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5nDp3+G; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-329b641fda0so376153a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757745321; x=1758350121; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMj3cfgRXbo5TbTq5fxmrLscUg24nKM3Od2dH2JQ1YI=;
        b=l5nDp3+Gx58LH6nYilj7/sSnHRarvFYfgpAkBu6QNVhta6Q2QX1zxICxnseZIOOj1L
         fM1UBt9Iu56N6TqSL+ZBj6s/1mTpmb51TCZi0rmH143IzVSR+A5/CLgBPW20lKuuDyFl
         gVd4O+b7mI/XsgbAIwsP84rMvfIgTfA4hVKuJWDhgWkYix2MqvxuGXkVgj+SPu0Qk+fe
         40r7M1MKWOtyKzr52TYA49ZhnGF+kPK0TL7CjruaSzyICdeQYQKLCIEWNrFerHc5H3tM
         v5KKkEDp3sI9ObSBty51kRiWJeAtI3Dvzq/vr8Zkb0G7scyTN5EsLRoVnHhjUoGTZ2dQ
         PYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757745321; x=1758350121;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMj3cfgRXbo5TbTq5fxmrLscUg24nKM3Od2dH2JQ1YI=;
        b=Vk/KahNDwdP/JT6jfQ5KNb52kr9OGulsVt260Cubagr7LkpqN+tAkmUXcJ907RgFYm
         6BFhdTpoK+4or6R2v+sdC/hm56pvhEhjrIzHVgoXDoI6g/ul4Fdq5pegSAfXFUual+fd
         SIJ+npUPBSf7w5z1WWGOlNN9BXSqut2zFpsJ4POgNP5UHiQ9y56ONFIUmJ12VgksWYXw
         Eugv//TvjjG+eH1I7+Mro86crojXI1rSu34NC+GB9T/T93/KZ+71+f+F4RVZ5m3Sgmyy
         k8KZfYOeqKXbbgSPBrtu0mXPWLe1Hrykxx5u0nAtM9Um/4DeCafc0hVIfOzki102qfYG
         0CdA==
X-Gm-Message-State: AOJu0Yw7RwNrC0dInZS/4g0M1NKnyZM1dulKwe0U0ebPd+MNX7fEeJEq
	eA63b1+WGBUUyPXzJmQRmyVXDG823ULdbVOT6PhOp1EBfaT9dPgXubTDw5X+c0gW
X-Gm-Gg: ASbGncuxyzMWoq4fKYM7Nu28bacDaocFIwmyylPaSwatK7B4tZ/Muc58m2F8s/c7cU7
	Xb++XA2npHAkl0nLC5Zc7TLicoSVTwTpVz5bl3OqiGK4uKnhvODOcjLi0E1Sh5AwKP8qMQZQYMv
	yNn/yMVGQ8Cj+m1vC1sf/zhWiInNMYcuGKhHQsIM43ADXE9DwPFkl1citva2r05costXKb5eUmP
	GMtO6X/yK84+dANoVqvoiCz86iLSBtx3KO8PV/SXeNptH/Cn1SFS87KetbHD8dN79z3QDnBV0AO
	tHfh5JSfe6le2SaFmdnH+RpZjpN7HhGhG/GBKy2O/IScuQ/zSENx2ZtRCzXEOB6Mqwg5FPmu3dW
	rW1hvqP5VdSOcMAkQXAq3V2HFmwya
X-Google-Smtp-Source: AGHT+IHKkkC3QM8coQ6NO9qeJrC1prXGkBNL6WrXbhaljz4l9tRVx5lZNhS337M4qjUvBRHY2zyeNg==
X-Received: by 2002:a17:90b:3890:b0:32b:92d7:5cb2 with SMTP id 98e67ed59e1d1-32de4e70fabmr3469839a91.1.1757745320701;
        Fri, 12 Sep 2025 23:35:20 -0700 (PDT)
Received: from hobbes ([2600:70ff:f833:0:85d:f376:d78:d2b3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a35b7b53sm6453910a12.7.2025.09.12.23.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 23:35:19 -0700 (PDT)
Date: Fri, 12 Sep 2025 20:35:12 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH] perf/x86/amd/uncore: use kcalloc() instead of multiplication
Message-ID: <455fb1db8ab0811d2336e0ec198c728a0c703be9.1757744812.git.joeypabalinas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qtx2otpa3et5sln5"
Content-Disposition: inline


--qtx2otpa3et5sln5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PATCH] perf/x86/amd/uncore: use kcalloc() instead of multiplication
MIME-Version: 1.0

Dynamic size calculations should not be performed in allocator
function arguments due to overflow risk.

Use kcalloc() instead of multiplication in the first argument
of kzalloc().

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
---
 arch/x86/events/amd/uncore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index e8b6af199c738eb00b..d08e3054461f2ca07a 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -1036,11 +1036,11 @@ int amd_uncore_umc_ctx_init(struct amd_uncore *unco=
re, unsigned int cpu)
 		group_num_pmus[gid] =3D hweight32(info.split.aux_data);
 		group_num_pmcs[gid] =3D info.split.num_pmcs;
 		uncore->num_pmus +=3D group_num_pmus[gid];
 	}
=20
-	uncore->pmus =3D kzalloc(sizeof(*uncore->pmus) * uncore->num_pmus,
+	uncore->pmus =3D kcalloc(uncore->num_pmus, sizeof(*uncore->pmus),
 			       GFP_KERNEL);
 	if (!uncore->pmus) {
 		uncore->num_pmus =3D 0;
 		goto done;
 	}
--=20
Cheers,
Joey Pabalinas


--qtx2otpa3et5sln5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEx6b1SGGPTKxTmPDYqoHu9CTxowIFAmjFEKAACgkQqoHu9CTx
owIXpxAAjaO0yrfiWXht/rwuJg+nIcjL6lDzl5QbIruCyZ57rrETsm1VsVvrx+fm
KFwjQhmJmPSF0m7Zh7yRtbgMvR5ADZ+C9no0CNvTtihrrIO5tJRPZqKJDcbWt/5P
vFpYvE0HO3nFhB5jSKSM32Cavn3GvVjbkgJHTAIVts880qylg/tNgnpFFrWo5wYw
KPPhksYPLkxsuBA5dQKF54qB6RyMGt3TCKQYwwU4oxoIBrtXux/Db2q5cCRYb23Q
f469XWF0UxuEZlimxjs1h6XWEnmXuBLMFhdLRdutU5VKZxnYNOLzbcvIqg425yJh
BxzIUm2Z8WYIQdxmtx5B6Z04qnLuXyJ9fuz+VO34X9MI7fRIFsPmRcu8OhVYLFvx
JELIQLKzQ4Rpi6//2jEgKgozwUrDNrF9Od3za66qqpJCPpOZsyFcFAuzIhYyTZtE
P1LrrG08RmEZwlZ/9+1sAaKVNFko3n+ttO12+xkQD/7fNw2T+UEeQ1URwocLvvuw
V/0ZSckdIm8kbuUckBFmjTbY0UnJdp6sJbSg/pXpMrhFyB4XBqgJdAMDwd5bbxkv
xySiGG7Os9R+v3GziyiFJ9RoyjJrl2wrQ4RzOhpoMBJ1wIcj5Lfhs1woq3Lm3K+d
RdZOwTalO25NWvX3nbVzSnLfiyZmevYV6CCQXUoKCpJEyAeR8OE=
=cHp3
-----END PGP SIGNATURE-----

--qtx2otpa3et5sln5--

