Return-Path: <linux-kernel+bounces-874131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EE9C1597F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3FEE5063C8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49963446BE;
	Tue, 28 Oct 2025 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+/32qUY"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5C7343D61
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666215; cv=none; b=LAwz2dk/83rfNnc5onml9SBCV7YAIhqs0MM3t/26q9E/fO3c2Ui8NaAO6h7BLCUH4Usjt6hm0TXde/kbUNi9D4j1LHHe4a5C/hFibiXXVxQlHPX8BIC/kFuzQwXnsCwhXzWONiv9gqJfdtcK7w4eZE+9R9eSJ0Imms6YmUYOK14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666215; c=relaxed/simple;
	bh=0OdKjf6E11PLhTN47izQgrYewu6DAaBIZBsxLqLrIEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PYGbLr6gpyuQVfk1yhk3ggsQ5UNqJV5yh8QCspPxqdJDbq0AKS9iGJSNcWZxS1zvhJArosAAP8FOFTzhMpfMgnAeD6gIM4HPIW9WJEsJZOufJCY0eEl2S4WneJQbCd8oayk9vCGvhrJIJv5spb2N5Th8TNj19g1wUq52wgivZ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+/32qUY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so39613485e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761666211; x=1762271011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OdKjf6E11PLhTN47izQgrYewu6DAaBIZBsxLqLrIEE=;
        b=Y+/32qUYnUB+gqfNDafPgKTIQtmGDLg8GdilWpQT2hijTOq0kmzOGyZJCpBrV5qDdi
         xPPKx4Q8wCx+fdZFoPBZjK+i7QrCBu1Ec9KPf+tJerMP4ng5Guh6ToDmJuA3rhTbVd84
         r23Eqqn2FnJUVZMfsHLq+peJaOq+/615yY5gCAX8zA7koYOzJ1+hu/Oqc6l21G2Fo8dc
         vNFR1ilSNiV4DNH6DMBk8fgjI8lR86K/Zcf8MabWqk7bDeT1Q6l5Fa66D5ItqEgoSRce
         lYkyHBsaOySdBDz+T5OaPoCI1ZQnvcTFZAo+oLylrCaVlTJZqHAQ5KeLe+c2x7OAGWX9
         5HBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761666211; x=1762271011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OdKjf6E11PLhTN47izQgrYewu6DAaBIZBsxLqLrIEE=;
        b=fHArKltRR++UBYvHVzDAmt9pAWAojKlvpfE0acYkqKRCgUqYl99d7cvrbdzpo1yC2e
         m4WXEGCNmYzC1ItdcMy9jy2D2p92sP7d8jxy43vTiW/E3XsKmkd7Mb5FMyn0G+VvB3Du
         k87LZEtsQIMH3g6b5qsKQTC+QQTNawadBNlwyKrfq6W66zgFePurhwaPrLkWuvezRG/e
         0HUZBLUFInbypsFFWxmAJkd9OE08QssbA2mAzv/s+i2Dfu08dznRs5U9x21h5W813mdM
         YWRq/d+Xqn1kBTsPLSh4vLuyKEYS5Vkgw2R1YvQ4/Lz+ckypy2uwGF2C2ie0+GEMXjSy
         kfMQ==
X-Forwarded-Encrypted: i=1; AJvYcCViDb04HZU9iDRIiNwgW1kV+/VyWXzy+2D0kS1vEyDFqTAckar1fjvVinRXtMf/bjUnLOe5Nt7GvW/mFr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YypVdEBb4bVDRieKfX54xLQ39IYzDP3JM7zM7f5hz1P9dNbN9ok
	Xn/f9+MmjJOhGR2Iyo7XacGBA/Dx8cXiQlMhBii5k60t86jmsZyGLvTb
X-Gm-Gg: ASbGncvPlOiPyNuIN4pYrwwDtvjj1yMmwildRIcPOmSTPSCXChQ8zpPiIyAbjgwflUI
	6fUVR/KdcA2hkj1+9CH63BqYbhBfVCSaYfu5z2NjTnUAVPR8gzv4cL0wrHGhma0VY8+Er1lXLrg
	i6SYCR/0NP+c5+YidCwunou/CCO/0KXTrjgM7RqRCHxt/tG6/bUGTcCEbeXamsDeP9qzf2+UVsB
	QIXPGoCIX+f4uvF5MTK6KTRHGQAn2FuSSc+QUzeh1Q6SEJG94kEs4MvkC3UBQMe4BHWrpQDbPr/
	KKWVs/ZUGrLpLbxSTz586gQny0fKYx1fWkq/IOEH3ME+CvKej5U0IRxmsmC1KU8+i3A/qkboWKX
	Y/m0tHuOXKxafbyDA21SHBFaMcYXVQJ1W1Oc4Zpwufjxgon3qt3Z2n2irwe877CMZk9zLFZ3A5A
	OBFqG/QTJvFgr/EaLjy27/wwx/UI7oSolPnonU5Dgt9iIPx2fGziCA0AozWQ==
X-Google-Smtp-Source: AGHT+IGQT1sWn537O9lUQH0SeyIcZJ4uWohxTzjPx9kV6HFu78PmQQbglpth1JWOPqlEUpT9jeFZgg==
X-Received: by 2002:a05:600c:4e02:b0:475:dd04:128a with SMTP id 5b1f17b1804b1-47717e6b4c8mr33281395e9.31.1761666210763;
        Tue, 28 Oct 2025 08:43:30 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd02cd6dsm210045835e9.2.2025.10.28.08.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:43:30 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Richard Genoud <richard.genoud@bootlin.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Wentao Liang <vulab@iscas.ac.cn>, Johan Hovold <johan@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Richard Genoud <richard.genoud@bootlin.com>
Subject:
 Re: [PATCH v4 08/16] mtd: rawnand: sunxi: add has_ecc_block_512 capability
Date: Tue, 28 Oct 2025 16:43:29 +0100
Message-ID: <8637155.NyiUUSuA9g@jernej-laptop>
In-Reply-To: <20251028073534.526992-9-richard.genoud@bootlin.com>
References:
 <20251028073534.526992-1-richard.genoud@bootlin.com>
 <20251028073534.526992-9-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne torek, 28. oktober 2025 ob 08:35:01 Srednjeevropski standardni =C4=8Das=
 je Richard Genoud napisal(a):
> The H616 controller can't handle 512 bytes ECC block size. The
> NFC_ECC_BLOCK_512 bit disappeared in H6, and NDFC_RANDOM_EN took its
> place.
>=20
> So, add has_ecc_block_512 capability to only set this bit on SoC having
> it.
>=20
> No functional change.
>=20
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



