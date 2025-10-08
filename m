Return-Path: <linux-kernel+bounces-845504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86386BC52FF
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81E03BB416
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4113E283FFC;
	Wed,  8 Oct 2025 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tqyu4BZP"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4513334BA37
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929990; cv=none; b=IwmWD4qSGjZcOS0ulRHcE8MHVg2IdelYrrt09pJS7BUc5tHD6tCrx1X2UX4mfDrqe7voV6ache0QUjRKmMq7+dqzd0HrC2SknPWSMT24Zne6Cz25KF/rgChZMAwBIOXoybd3MeTHix1B38wywA/TXPRSpgNlVeKZWYE4JGsqdoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929990; c=relaxed/simple;
	bh=05Djfz/fc5yLW+hWwXjLSqtCX4jNJikbc/xDMtKa7K0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u51VZYZfzREPYCUpSr62NvWCkLkgAu4nsu2NliOQMjc+sAtO5LD/5ncSP4QXwacXYz9TexNaAwS7alVfQWztRFqMbqiIScv5sYCZjhoXTeppRQBOSS6MM8QgB9CxWg2feU+lRADdlxGPGXM2+MbBoHAKPEID6J9CTCGvA/Txe9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tqyu4BZP; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7a4a993dea6so2443589a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 06:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759929988; x=1760534788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05Djfz/fc5yLW+hWwXjLSqtCX4jNJikbc/xDMtKa7K0=;
        b=Tqyu4BZPcfx9jW7BYHnNwkYOpLcrSi14yfPhcd2/wDhCT3OsvUkiPTNyHfL2EP+Y3Q
         QgufzhdETph/iHEFSa44whMTT3bnNHuNPBasDsTSb4lvvKYpJPapJDHcsKK0BDkQtqfk
         X3tZfy1ZDQOc1gEsXRWD5pnSTh5uhCEV3GGlZGTxsNaG//CLuf2QvGewrVafIRA+zVo3
         wDrnW3Bs7Qhk33B7EGvdkVadRI22XM+j0hEdWjFnbZUmaJlC1rGfKpJKDu5NaM7Jbxyk
         7EqSXovUfRIebjKGUDhFWfZ5OM3aBOg9VVIgJui2iGVlHLptG/NC2oPbj7E8/mV+QMI3
         mt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759929988; x=1760534788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05Djfz/fc5yLW+hWwXjLSqtCX4jNJikbc/xDMtKa7K0=;
        b=ZJ0P1VjdfioK0z/Y7AzLp54/7+7B4kCCTR9eBzczSnkoeuUYt6txgSs1pHl7bDbptz
         G5hdXyLNrfpOt6BvL3lyqPqCc7iMVNyWSCyb7u1nz0sbbBtc8ITZo7A9WElTRpfTz32P
         4awbPNNUFvnS60qW+6FUoftpH80CACmAGo0gu8ptBrH4TTqYsM1GErLvecUPOrVZm8rZ
         PkNrgG2uqLcpGYSHy6OmajwCsaQjBybEKNNz9waNxCaXHCQ+gDxW2Pbx4xBSM9k7t16v
         VD1bjTr/B7DEmoBfmFSXKvr/aBP1BDHrtn687ykFrrVaEH/hJ3O3e2Xa3PRo0WYiY+Vb
         dFaw==
X-Forwarded-Encrypted: i=1; AJvYcCUYWIWoxHHzo8tHsV9nrcbMrX9oFo33YuBnMJai02UmMuQlzrCZwYZAJIft0Ql4j1hefSq2uSFVKVRv9Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrxaWeMqZfazP01D/7pKnCDJn6Tdid5s2UoLcj1h06/WIia5O7
	KwCp8jsv9xyFOXCmfjLYlC+wc/iyd1Rfgf3tX2wD2rH399Z27W1rMyqgsbrTBA02DbwPJXm/DyA
	zZ6F4o7uUaj7Df6VZCWWxoBwmU2PzqBdZeEkh+jDCQPhI
X-Gm-Gg: ASbGncs6eS8rh64HpGXl7Qi0lDmliG3BSO/iHGz7wnko9bULy4gw/8Jveq1sjs4jync
	kxfnc6p2r6GqoPR3aHocJ51HzyS6KcUzzXOzfMJTSc2TUFFgbHSvEahvGZA5wVzDCKMLZasPUkL
	zHvdJqR2qXnzl5dZSyhvb2ziOzmcaakmJkSpm9uEhJJscRPZE/ktVcDL0mx7NgYs2oS84HL5uSN
	Jj5wpA//PFgVhSLmY8jxyIaMgPc1QgTGXt8GXzMCA==
X-Google-Smtp-Source: AGHT+IGM/AtY5qLsYbBJ1vutlWYaPLrr0xadRxoxXcSHvhcZOCjpvlqjLspgJsuA10qAd80/JQ7NUhN/HiyOQcTpX7Y=
X-Received: by 2002:a05:6830:6481:b0:7ad:739e:446e with SMTP id
 46e09a7af769-7c0df7f5fe8mr2306555a34.29.1759929988314; Wed, 08 Oct 2025
 06:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007145028.1845-1-briansune@gmail.com> <aOUv69rMkyYFiHae@opensource.cirrus.com>
 <CAN7C2SDUiuMfPs_X5r0RDC56313aJsfhfx0-juhZRKGTb1OKuA@mail.gmail.com> <e78c9cc0-4a1f-4a22-9cba-a8213a7b9301@sirena.org.uk>
In-Reply-To: <e78c9cc0-4a1f-4a22-9cba-a8213a7b9301@sirena.org.uk>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 8 Oct 2025 21:26:16 +0800
X-Gm-Features: AS18NWCLuOtZcq-UX1FDdMc0FIiE1oQFFC-_uppp7SPL3NBQzzcP8YR7rHfCt9k
Message-ID: <CAN7C2SDMB8_b-m0ZMzuSmhHxWpA10mcxxxDMKWuNe6wfiEXo-g@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: wm8978: add missing BCLK divider setup
To: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mark Brown <broonie@kernel.org> =E6=96=BC 2025=E5=B9=B410=E6=9C=888=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:12=E5=AF=AB=E9=81=93=EF=BC=9A

> Consider the case where the BCLK needed is 100 and SYSCLK is 198.
> Dividing by 1 will result in an absolute difference of 98 and a BCLK of
> 198 while dividing by 2 will result in an absolute difference 1 and a
> BCLK of 99 which is lower than the required BCLK.

for (i =3D 0; i < ARRAY_SIZE(bclk_divs); i++) {
bclk =3D wm8978->f_256fs / bclk_divs[i];
if (abs(bclk - target_bclk) < min_diff) {
min_diff =3D abs(bclk - target_bclk);
bclkdiv =3D i;
}
}

Cycle 0: min_diff=3D0xffff_ffff
bclk =3D 198/bclk_divs[0] =3D 198/1=3D198
bclk-target_bclk =3D 198-100 =3D 98
98 < 0xffff_ffff
min_diff =3D 98
bclkdiv=3D0

Cycle 1: min_diff =3D 98
bclk =3D 198/bclk_divs[1] =3D 198/2=3D99
bclk-target_bclk =3D 99-100 =3D 1
1 < 98
min_diff =3D 1
bclk_div=3D1

Cycle 2: min_diff =3D 1
bclk =3D 198/bclk_divs[2] =3D 198/4=3D49
bclk-target_bclk =3D 49-1 =3D 48
48 < 1 skip

loop done

Final bclk_div=3D1 LUT=3D/2 198/2 ~=3D 100

what it the issue here or I messed up?

