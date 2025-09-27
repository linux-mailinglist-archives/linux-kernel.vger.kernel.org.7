Return-Path: <linux-kernel+bounces-834959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211FCBA5E98
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 13:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3DA2A68A4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AE72DF715;
	Sat, 27 Sep 2025 11:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIjw4lh/"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDA92D662F
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758974350; cv=none; b=JuB0tRsR74I3REar668B92BD8FYjCZogq21CsxLg4a2LcW69Y2LSYQujnm5GVadOtz2oAluyl2bfSeU0gpkL7DxXiYRNH8TcxTfjSNbv46FVaQpAnOCHAAGmlhNtAZSGlOY8I/O6kjX1UwC+Y3TrWPWlrHINo0q1bJWHRzzp1js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758974350; c=relaxed/simple;
	bh=Q1G3ufsLPzjHcfqxuhYUtyzb6mkBeQ58SzLq4Ks7+fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U122Jb1alTDYhL6mivlT5zLOJAYH5Rb8eJc+VWPN4k816Yr2RAUwMfb3FA9BbcaUMdpdvl0lehUDnuqw0SYHRzuV88OwR8HhyvomZ/rZe+e/6xJ6WcaKHTPC26/1rcXRFd/MSiblCL0kNNHK0NlewCden8CyaNvMnAx9Lsn16Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIjw4lh/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27eed7bdfeeso23581115ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 04:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758974348; x=1759579148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PijOBnBE5pXeLnRzXQWQH7HqbwlFYRqNkz2VA+MNSBM=;
        b=GIjw4lh/98Wd709/MhxQib8sLy9zbxI/gORwTU4Ox+QJmTYqhmzmVCpHrjOJbVGeBE
         nlIvxfz4BeajpkRPXw5x4uNl3o9PT3iAyhzNf6urK3/E8xFuFDEmUzbMsFu0PRttF1uN
         c/FFK+zyUPKx9jhuynJEgJfNa5c42RY972qh61BsIk3sPGgXk4USEOPM3YsCiHngYcYP
         lLs4H6Sl6qxTl3FO+91nFmyTWPMMx/VtTCSUWFRS29p5xPQVqb7fJ9dbGcAzyBNoDcRO
         fOi/3WP6pciQOKtX44BjZKYPVTJ55ddxQVoEn7CNgNWn9V73NRu+jKQpK54r6g4iAEXN
         925A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758974348; x=1759579148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PijOBnBE5pXeLnRzXQWQH7HqbwlFYRqNkz2VA+MNSBM=;
        b=wtg/SWjWxzuc1hO2SrjoY1iEVBw84dhXt6qt6tsfNw/CH/2mcop9Q26amoA/0JCu+N
         /h8+LGe/+epaiADoEL1h/+nRuvmJY3u7XMhVdhr3YGRJun/xC6+cERhuSRzffA/ZXgtt
         O9BT4Fc8lA/C315zhwGoC/IjpmUT09Iz+jcdV1lwKamlUjyQe/HK7mny7tiCRdq+lAuz
         VS5qLk/o8d6+N/B05BtedR9pvPRsCfSBtuZClku1bwP7vDjpsTnx2Q78Fg6jX49AqNiF
         jXWuzPO4GOiuI6MpDUZQPrWopriZBJCpVv49+wCX2SqPvLghAbT4eVvNaDu9cNMjBcOE
         xRvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOBqx07Q1Wabuyo1UCfvu5jDq8ACUG1b5cDZ1ITz5Bmioqa4gTsYYtIJlkE7iIwda9gCClJ3q3k+18Wno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfAMAVes7fDBPNpABwlVxB3fVf8nVbSqzkoQATPUpcSDfKCHqr
	hHrMY/1le9aSC+kLbf6yv0zd+5jabzLQBZH8IBOKUx5B6OldiLYkve5R
X-Gm-Gg: ASbGncvvQp/9M8hmQIqhpQItKFkzqFQo08vFOOF/r84D7z0U02gMON6vtjJsPJJtOlV
	WZXz5az3wl48lMd5iB4vt/DGJ5RSNR2g2EdKRutIQidt0gSaqJdAkBM3qqYFUCfVLX+tSexMh9d
	KschFnEHFVsye2T00N4ZtezGWiG6Jc9NzmUT5nID1es/Vy+15eKTcSNmMpxXzEKi+pjVo75FzF8
	jMm5IvCogjyLvyp8Ytk0IKNyMFUdknNDgJbBSX0fetgaa4topaJO/5bIAEtdX91G6kKDJ1Wol4j
	nIUJIP7Xt2ap6TODsDTWhebEr1ZGv4r5yTA7GoH9HC9in/G3qt810bbKzcFm29165w8AKYI29xt
	3YIxTyhjRrZLtf5lc+eKktSpChQ==
X-Google-Smtp-Source: AGHT+IGdjsvu2VFOWhWF2FmWJyi+6tpoozd27mdQinEsI9lm3h9uunjFU+cpQiasI10JUUE7yFidOQ==
X-Received: by 2002:a17:903:2351:b0:24b:1585:6350 with SMTP id d9443c01a7336-27ed6bf072emr112191455ad.11.1758974348284;
        Sat, 27 Sep 2025 04:59:08 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d3fcesm79872805ad.29.2025.09.27.04.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 04:59:07 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 3BBE94244349; Sat, 27 Sep 2025 18:59:04 +0700 (WIB)
Date: Sat, 27 Sep 2025 18:59:03 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Takashi Iwai <tiwai@suse.de>,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Klimov <alexey.klimov@linaro.org>
Subject: Re: [PATCH] docs: sound: describe 'chan_map' member in snd_dec_opus
Message-ID: <aNfRhzjqs6Z2fi-n@archie.me>
References: <20250926162658.989479-1-kriish.sharma2006@gmail.com>
 <878qi0b97l.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B+9DhcFL+/ubECCd"
Content-Disposition: inline
In-Reply-To: <878qi0b97l.wl-tiwai@suse.de>


--B+9DhcFL+/ubECCd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 10:17:34AM +0200, Takashi Iwai wrote:
> On Fri, 26 Sep 2025 18:26:58 +0200,
> Kriish Sharma wrote:
> >=20
> > When building kernel docs, the following warning appeared:
> >=20
> >   WARNING: ./include/uapi/sound/compress_params.h:364 struct member 'ch=
an_map' not described in 'snd_dec_opus'
> >=20
> > The inline struct 'snd_dec_opus_ch_map' inside 'snd_dec_opus' was not p=
roperly documented.
> > This patch documents the 'chan_map' member and its fields (stream_count=
, coupled_count, channel_map), resolving the warning.
> >=20
> > Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
>=20
> Adding Alexey to Cc, as it was added by his patch.
>=20
> If any, please resubmit with a proper subject line (e.g. "ALSA:
> compress: ....") as well as the Fixes tag pointing to the affecting
> commit.

In this case, the Fixes: tag should be:

Fixes: 5d36370f3431 ("ALSA: compress: add raw opus codec define and opus de=
coder structs")

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--B+9DhcFL+/ubECCd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaNfRfQAKCRD2uYlJVVFO
oz6WAP441DdFLVyi6XyfBHaTk0yfgsrCJqzp1izuhVPCZPS9hgEA+9pue04CjA55
TecMhupmUGb0LVIe0TYAGh9RDASzZgw=
=uLks
-----END PGP SIGNATURE-----

--B+9DhcFL+/ubECCd--

