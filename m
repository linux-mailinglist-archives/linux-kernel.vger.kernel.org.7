Return-Path: <linux-kernel+bounces-891764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAB4C436C2
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 01:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A4F188C9EC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 00:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E79126C03;
	Sun,  9 Nov 2025 00:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTxeXNwX"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E2F9443
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762647477; cv=none; b=IchoqX2L8PabiFBSnKMBUP7flwUStUnXzj5hi1MLO4IdGNajBlHut+0SMLCXSign7irFVOgXUyXIbmvsOru6KpdhXqKOMTPRZ2J7+TnEa/fC++Eq/MoDijZq3KgDUGZjE8G01cPG8zfcRNiB+Qk7Pu6sBaDzkD946f/2VJHRg/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762647477; c=relaxed/simple;
	bh=X4o0u61EUL2HL9e6hUwjhKpFF2BdKLBjbpfp6Ho3jmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6vxhCKmp0AAGXkB2vNpKKCw7wm3oARwH1O3feunG0A1qht6PL2p6k4WXPFTvcVkXwv+SiQtMW1tli7lWMMNBfn1qkT6bymSKTCELJhCs39kntOYDUHv/rKhfL4i86M2f0LlIm28oeC7Rr0iCOtTJwoNl044jlnU66uy7jEUYzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTxeXNwX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-297dc3e299bso10206975ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 16:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762647475; x=1763252275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X4o0u61EUL2HL9e6hUwjhKpFF2BdKLBjbpfp6Ho3jmU=;
        b=NTxeXNwX2pXjExTDqCWCgX/YSf5pesI3441bqIBMeRUvTL/pT0xkWHhuUndt/jEC+D
         dJZuTFzLm8afw42G0XhtmJirdu3vF4kjJVlmlUaNVxwgPOpVCIY9w6IqBLSsFK5dPri8
         4dpnq5ip87u7mgZDtwge8VfvQkxYXtyX3K7nr2GX0wgEBvsILNck2LBD0J+ci6tumMxV
         J05bWl9K02BzPhjNB9y6ImRm6l8KEcD/KvBgGoNaXeeFnhjV9QnSbtWVXIkA1qsx3zca
         b+73uswo43tQK+M640Cw8KEm2zoHfok6L/o8bnnznNliAABKTLAjaPNnSKIZI8tDtrw8
         f6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762647475; x=1763252275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4o0u61EUL2HL9e6hUwjhKpFF2BdKLBjbpfp6Ho3jmU=;
        b=qlbnz0zTreAS+Nqtu2tCmgEDFiFg3wsuTF7P0IUjhOCgVDMf22fk/YVCKnHQoiFsC+
         NyD15XboM6qU472aa/f4StYU9ZjKcUglzKS96t1la3c9ShPD6iTrQ/sDemUiem+eOK28
         01cFuMaSJN0UjimW9iNlegUzm0r3yV2S84cw93r0zqsF0TjVX3borz/IGUOMdpQwEAOq
         oQRXv76Z8DTnIrBPVpcSMRDhwHeI0TeU3pEzM3OXR5x72iBlg21zCY4DNklWRKRzlMFk
         z4UkPc/k7xrcsGNGCDGV75pEtAVTCR8bIE/hy7zOMXpyRmnXpwHyWFcmkJPCr1ePT5JI
         UjXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVllbddGvDQmoSRqMrRjU8Yxu2gLBsfa1sa6QPNWFa6qRyijbq5/2dvBWHnwLKgw+brRRlJXFBiDcLpyak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws/WFSIkznzI/YE2uymKd4nSeoaT5y0wf1h6ccU+jOchvHShdP
	qjrqToItt1uQkpB0H4EwfY20QYOYrld+aDzcW8gtIgGMFtoFqgrjQnLo
X-Gm-Gg: ASbGncs5dbeL2hgPQM115wMADf+QfBc6BxBDaS3DcnbCJiwamy/83THqiLwb7RL5d7X
	iHOqqa61FSC+dwg+DD9wRQYbbuHE1AGIb3Jv575L9AXf+TfkMZmkD1PLj0ve4cVPTFGtuMbChvN
	wffyBCBkRWqiI+pVODaU3T2/RgJw7EeD0geU/9kST8qHuVHqfw8dy2j7s/eoxIqwe3soeOFTg9C
	EmOmbawdGuLwBVlKb66yp56Bxr5UgCP2BDQy+4ybX3R7ERPRYGOmYpqVP1HV4lwC6z0Z20Xtk3F
	ZSZVZ93bRli7ErIcA7nixDxW2PghsB68xfmZzZ4A6kepEPh56SnGziJwSlMXtfTYwgE7uDVVLgH
	UwiRCFEeuurZf2PBPibWVommq5O8Q1jkJbe6lWG3BKyc6PBPhuse9BwiS5FzPRmw6nVFTqOZuYs
	UAfgUbatSHZJM=
X-Google-Smtp-Source: AGHT+IEfpVtgarftoP1khEWPmgwWxs779ja9LAfhLZz+cixPanXCR7edT9dDIbRToxxMxKm1XIXjag==
X-Received: by 2002:a17:903:ac6:b0:295:3e80:9aa4 with SMTP id d9443c01a7336-297e565ed75mr47522485ad.22.1762647475301;
        Sat, 08 Nov 2025 16:17:55 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7c5ccsm98771565ad.57.2025.11.08.16.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 16:17:54 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 0DC0C420A6A0; Sun, 09 Nov 2025 07:17:51 +0700 (WIB)
Date: Sun, 9 Nov 2025 07:17:51 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: pierwill <pierwill@gmail.com>, tglx@linutronix.de
Cc: bp@alien8.de, peterz@infradead.org, jpoimboe@kernel.org,
	pawan.kumar.gupta@linux.intel.com, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	pierwill <pierwill@users.noreply.github.com>
Subject: Re: [PATCH] docs: Fix missing word in spectre.rst
Message-ID: <aQ_dr2_Dd0peHFi5@archie.me>
References: <20251108192216.28534-1-pierwill@users.noreply.github.com>
 <aQ_c822L9lSTtwl5@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9vluvyLBrSPG1L0p"
Content-Disposition: inline
In-Reply-To: <aQ_c822L9lSTtwl5@archie.me>


--9vluvyLBrSPG1L0p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 09, 2025 at 07:14:43AM +0700, Bagas Sanjaya wrote:
> On Sat, Nov 08, 2025 at 01:22:16PM -0600, pierwill wrote:
> > Corrects a missing word in the hardware vulnerability docs.
> >=20
> > Signed-off-by: pierwill <pierwill@users.noreply.github.com>
>=20
> Please use your real name in the SoB line.

Oh and you use noreply domain instead of real email? No wonder why my reply
bounces...

--=20
An old man doll... just what I always wanted! - Clara

--9vluvyLBrSPG1L0p
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQ/drwAKCRD2uYlJVVFO
ozNoAQC/cv9wmVg5pzceAkHar2sbEKcupnJkqBVZM04fNz+p1AEAlnie/f98i76k
dzvJC21RaIzAnCxgRtQbAgJpE3BoqwA=
=LIp8
-----END PGP SIGNATURE-----

--9vluvyLBrSPG1L0p--

