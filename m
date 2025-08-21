Return-Path: <linux-kernel+bounces-779708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D83B2F794
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A411683851
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276DD3101B5;
	Thu, 21 Aug 2025 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+MBEtPO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857DB2147E6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778178; cv=none; b=WkWPpjHVug656vuKnzL7374NXMaUmlSA5jSuvbJAqYjq2Q852A76movpJot2lR65akVBzEndz6SEkWkxGL578LjrfzIzPperf3ASEaQ+YAKejHedGInzTKHlxmjnib0ZY2IKRcExaf5h56vcy0YNAgrqA5Rc0IzsA3A+Gxf2/yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778178; c=relaxed/simple;
	bh=YVudOL9kLvUa7t5Z40vgTlIpdlCqhWXk8VlyZ7WFiNQ=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=ADfuIBJcuzbBmX5/7+p1pXvlyI45djAX7A/Ll9bRjSKV2dCtxneYSYxm9Df7C7s3RDquvPsUsAg6hizPUgRSKaSmfASWNYT078oaFaUZit9EsaucSY2CJvrfI8VPQvTz1nJhXEdEbnEqOSnNNd5zDfeKl4PEylOZKaoZnRC3pDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+MBEtPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A22C4CEEB;
	Thu, 21 Aug 2025 12:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755778178;
	bh=YVudOL9kLvUa7t5Z40vgTlIpdlCqhWXk8VlyZ7WFiNQ=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=Y+MBEtPOx9jut06XprjYa5k9qJRVLaN8rFTQrX6N3+YUimMlQw7rKcQQnzT8LHuDq
	 qyjfPinXN7Sb6Zc20pEsKH73TA0q+LGlpNgbF6zhZlexfuzjT48ceGBsnILcrOVQUV
	 /Z15DUI3a/e3OO8cqpMh3WFDcnQnQGkT0Nfe5oF53Kfa1c01CRuMBxYPRp3o8Vc41A
	 Veq4phsAsmKxqBt5UopCNzBLPTEVTJfv0yDO63xUzSEdIdPyLkIsVXxHZVsIB7JPAL
	 PrKwYke/zaA8eJy+iu6wB0WAfg7kbqZncty9vJfwAf6YRU0jGkdvm6rnHgdwVD6XnX
	 YmV5ZHD7bAcdg==
Content-Type: multipart/signed;
 boundary=3a383ff1ea192992f3804c3bff8ea9d8903d7571fd6cf5190aac3da7f3cc;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 21 Aug 2025 14:09:34 +0200
Message-Id: <DC83F2197OLI.2KRLEH7GUBKSA@kernel.org>
Subject: Re: [PATCH v5 0/3] Decouple max_pclk check from constant display
 feats
Cc: <h-shenoy@ti.com>, <devarsht@ti.com>, <vigneshr@ti.com>,
 <praneeth@ti.com>, <u-kumar1@ti.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Swamil Jain" <s-jain1@ti.com>, <jyri.sarha@iki.fi>,
 <tomi.valkeinen@ideasonboard.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <aradhya.bhatia@linux.dev>
X-Mailer: aerc 0.16.0
References: <20250819192113.2420396-1-s-jain1@ti.com>
In-Reply-To: <20250819192113.2420396-1-s-jain1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--3a383ff1ea192992f3804c3bff8ea9d8903d7571fd6cf5190aac3da7f3cc
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Aug 19, 2025 at 9:21 PM CEST, Swamil Jain wrote:
> In an effort to make the existing compatibles more usable, we are
> removing the max_pclk_khz form dispc_features structure and doing the
> supported pixel clock checks using "max_successful_rate[]" and
> "max_attempted_rate[]".
>
> Changes are fully backwards compatible.
>
> After integration of OLDI support[0], we need additional patches in
> OLDI to identify the VP that has OLDI. We have to do this since
> OLDI driver owns the VP clock (its serial clock) and we cannot perform
> clock operations on those VP clock from tidss driver. This issue was
> also reported upstream when DSI fixes[1] had some clock related calls
> in tidss driver. When "clk_round_rate()" is called, ideally it should
> have gone to "sci_clk_determine_rate()" to query DM but it doesn't since
> clock is owned by OLDI not tidss.
>
> So add a member is_ext_vp_clk[] in tidss_device structure to identify
> this and avoid performing clock operations for VP if it has OLDI panel.
> For the same checks in OLDI driver, atomic_check() hook is added to its
> bridge_funcs.
> In the atomic_check() chain, first the bridge_atomic_check() is called
> and then crtc_atomic_check() is called. So mode clock is first checked
> in oldi driver and then skipped in tidss driver.
>
> Had the tidss_oldi structure been exposed to tidss_dispc.c, we could
> have directly checked VP type in dispc but since the structure is defined
> in tidss_oldi.c , we have to add additional member to tidss_device
> structure.
>
> [0]: https://lore.kernel.org/all/20250528122544.817829-1-aradhya.bhatia@l=
inux.dev/
> [1]: https://lore.kernel.org/all/DA6TT575Z82D.3MPK8HG5GRL8U@kernel.org/

Since that wasn't picked up from v4:

Tested-by: Michael Walle <mwalle@kernel.org> # on am67a

--3a383ff1ea192992f3804c3bff8ea9d8903d7571fd6cf5190aac3da7f3cc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaKcMfhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hU4AF+IvgcxkPRSESU4r7IR/aM34rxVsUbczii
5ClhTBDU79TzVapcJx4a8PGB+f5WEwkjAYCPvJC/QF/bADblThy3D3ln7plKn30A
i1GnefaebiLizZ8l5IAVZTDxawBYVY2CIDU=
=QPzU
-----END PGP SIGNATURE-----

--3a383ff1ea192992f3804c3bff8ea9d8903d7571fd6cf5190aac3da7f3cc--

