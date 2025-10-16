Return-Path: <linux-kernel+bounces-856929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E158BE5795
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BFB3189B845
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FD12E1C56;
	Thu, 16 Oct 2025 20:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bk2foqa1"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C1821CA00
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648183; cv=none; b=oclcV9FW2o8WM+H6/rlTZiMMPNPdWuj8zeXv5L3ulazP/GcSXNV2so86AQr5F4OdHL/t0F0jyMQcRJgkQavP+zpcdzWM6f2RsDqG4sEffz0Wp4xBhxIJEp+ntJvCfcsxIjNfmFlA8vFbqFU+Yg2NujiMyH0ScHDUGoO+XwQUO6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648183; c=relaxed/simple;
	bh=QNbtDJRoZLPpXy+idpr7aFTGQIMBg2BzDWB4Jsj5egE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pLSdV84aKu+2f9UOYQ5uYqBHoroctj+XIw+wLj4bINARSLtxBHFmvHHLBRZHn5kmNhbdnT3ehTxtn+oZxxij4rHTFGx3Wltp0lhi9KtJdpi7DMXKyLQIevvdIbmqEFEw4SM2z5SXhveCAArF0NjH1Gvsv8atoY7QUgzMhlwHvyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bk2foqa1; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33badfbd87aso204565a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760648181; x=1761252981; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GkYz85RHkk9FUvuJAia9QMn7na2I9WeVkFiitjkUcbc=;
        b=Bk2foqa1ypZvjmRZ9gczXYcp3/3SegTJGwSuEoFGUzu90RNFZVcUEp4S6w8IFX7iCp
         wSUBJkEPYcic/Rg0NJp3sEtuukiFgTKfvcoSsWEUmusy6jAlhNEWtu6S0HduIEgNAU3N
         R5ygEmna4IGGvuP2AcCHcPckuqCKnRrvooUh84lsfv4hZSXuSKZTxjEndE67XacLXSxq
         gegPpDznIzqLfHqcVCrNfSramLDL7ytVRlAK9BxCng0bALpZr0FGiBkOlUd/OVx6Y2CP
         2/cE7zdO6cUrYXCd9xRtTJy9s9VxngW/5GbWXdSqsELBs4p+xzLJeryzPB0c088NhPxX
         YV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760648181; x=1761252981;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GkYz85RHkk9FUvuJAia9QMn7na2I9WeVkFiitjkUcbc=;
        b=NQwuKjgv/OGzwqNj+ECeLhMDUYQF5AymXekcfSnmenb7yvRHjWKrL6m7wDeL4TDZv4
         D+a7/cEMqiHFtPrEbjHkuYRWvWfH1MS3dOihhgTbGP5SWAeh1E2OKYNijgf38JzZld8f
         p3FR90NIvZL77FI8CBI7aRAhbL1c09ZlKxdgR6MGLM0/fiaxJ56bJOMyYO6GOIsMnHOJ
         eo+KZxvrGjK53QVvFyFocyxQkzwdBPtEBggHR4ojX3AaauZJPIm3Mu0+Fq3pgYtJmfCU
         SyEKjbHSF0SCugl0PtDZeiBEEXZNb2MKzH4uVaZbTAV8+pwafTdi2DSJ/D13iPsySlyZ
         +o3w==
X-Gm-Message-State: AOJu0Yz4Er2SNNYnX522/ThE9piyJolfhV+Nrq/x80LiYnGwg7QOhx6a
	XmarRTpfva1a5HIlK2+S52ZaHcb94PYECovhksr3+7daS67UrBgAcqF6G5/OFuQ0
X-Gm-Gg: ASbGncvPBQ74axhRDn/JSQCC5i3+7yvpMxLqQJPKlcY/HcYSiEWKY/vPZFGq4TtUgO+
	hbAVB2qvW7BIzc58vk192hx3PvRgMdMtmoMg/JBbqKV1r9mZjptlweMZrhmXvpSNcuLK6+CJiWT
	TDIh7wpaxGAWatyJnCfbWhHa2+geSFQsf6yL7fca4t/jCLQ3yeF2Cuws/TyhZyXofdbIVlKy9GJ
	kNA0Q08Me1e57xZN9V6DOD0dr3PzqOIhjhw2F0ThOU5pobcyCsgVjbm2cy/mx2JiS7NvBLL5wVJ
	J+IoMbEZx6AdJNU/W4v+kNKhVBLJATR0+kg/NZwC4xV3610nWkmoB0EYLL8EG7KxbNOIJC6s+iD
	Nb9RdK2jmmmm0m5iegG5cFpydItvneSShV4aYWW5CORldfVYybLRac2v1Nz6Tsbg0Lt8OTuY=
X-Google-Smtp-Source: AGHT+IGIefvEDm6vu2zJfmlf3U/r52Y7h8MqeGPnDg4XL7t2Jz0M9qxJZVyywZlIkfbPAPTt22SvRg==
X-Received: by 2002:a05:6a00:1a87:b0:781:18ae:2b8 with SMTP id d2e1a72fcca58-7a2206e648cmr954594b3a.2.1760648180846;
        Thu, 16 Oct 2025 13:56:20 -0700 (PDT)
Received: from hobbes ([2600:70ff:f833:0:85d:f376:d78:d2b3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b921711sm23324709b3a.27.2025.10.16.13.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:56:19 -0700 (PDT)
Date: Thu, 16 Oct 2025 10:56:01 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, 
	Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH RESEND] perf/x86/amd/uncore: use kcalloc() instead of
 multiplication
Message-ID: <hlb3gqgsqpimmv5xjniy27x3l7rmmzc6rektf7hqkr5ysysxsu@n7b7dcnuymwj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4qwazsycsrcemc6n"
Content-Disposition: inline


--4qwazsycsrcemc6n
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PATCH RESEND] perf/x86/amd/uncore: use kcalloc() instead of
 multiplication
MIME-Version: 1.0

Dynamic size calculations should not be performed in allocator
function arguments due to overflow risk.

Use kcalloc() instead of multiplication in the first argument
of kzalloc().

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>=20
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


--4qwazsycsrcemc6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEx6b1SGGPTKxTmPDYqoHu9CTxowIFAmjxW+EbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEKqB7vQk8aMCSTIP/jyBdY/bM6BYOPmLlxcY
7d679rsc10SVO9ia3Afd8buRveo0D9MnZyODRWgO1xcKO2d1MEc89G31P/e/LgL4
Cxze5uz8l4a2pWP5VCmRLFVnRoLP+50k5D8BkPwe62c5+XiAwmLCcpVVNTruuoFD
7TiWQh3QsqwlFAOYg1Fau4nAJw151IUByQjDim7yLUA3fixjvETspAh6ePRKsEMr
m7/VBrJn7jnjgI0q4aNA5uvuYLSy+NTSkBjHShbo9y7a43nHgmP9CxxgPScYV7fV
MOoXUxvdKbPyxq2zOoQ0mHI0wQ607byo+J68U2/ddPwPb+iX1acHi8gZ91xzntPp
BArExh38u4NXO6ofTOLPSLAspI5NbmVFvb98AgnhvJuYvD/k/TDZ6/E3l6iMlXZa
A9bMMx6B/MY/YlgrS/Aryo0KMsqbtfckfuDKbEEFvg6kG0ocZB1F51zRcI6HD61f
iYcmypXjK9GU27F1OeGV/0h8PT41izq7p5V91LTWK1KRiFLP76YewOaXaVQbAyF9
kqHW6IzJGKtk8jpe+0MFTt7pq82HOFdkehXVBCGaloDXAfZ9UpjQ/czkP7qOlHOF
cx2KrgbeM+ZiV+e3TIryaSvyVKVFvQFC1xEtruLKKgvavPq9dXxRdPUFPzFjfMJb
YrFcIN9F1qYrCrfgqfNEmuYT
=Xdus
-----END PGP SIGNATURE-----

--4qwazsycsrcemc6n--

