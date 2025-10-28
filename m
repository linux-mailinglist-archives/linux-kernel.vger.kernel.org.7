Return-Path: <linux-kernel+bounces-874139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E081C159BB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E538C543C88
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B30A33F8BE;
	Tue, 28 Oct 2025 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAmMYy75"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7722348883
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666329; cv=none; b=CyGOhQU4HRZrxbCwGY4V5wNA6/JOJXTQVpnCtiD3bm4QbOT1URVO+MWTRt1pKXlee4ifIXOt+ZWOowHPZYl0E6NqlMwOW73F2pGFohYRmqTkD2uqXIQ59OPVq/SyTnM+7kYw2tgO2yIab8tmk28FBi1T+BvlTRhIptE9YXPbGUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666329; c=relaxed/simple;
	bh=mnXURezN7n9VOpNAkHt+wC6tLgWa0+LJGSJ0uA+xyu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FannUEN41bbpfsXzuTBznj1H2hmpng9Ae10A+5IQXt3eVQFKmlCwfTwPCNBzilPRahRsLbazZsPy8Fy5FqzotgBsfihuJ2J8bkBPZy2TFk/aPGZfPqZOHgKTiHoQKPGhbeSJvRqzqa/NfNjmArN4N7T2Uary+A7ucSLVpCRyUBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAmMYy75; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4710022571cso63858135e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761666326; x=1762271126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnXURezN7n9VOpNAkHt+wC6tLgWa0+LJGSJ0uA+xyu0=;
        b=DAmMYy75myEeMJrSRNr3/wd+r0EbmenHmIR4NtugQRM38pEf6IZn/m+iP08FHV7yvj
         bY2xfF4+heYVrCh+gp2T23ABmkvp3PTrXEAcQML+yQB0bUQowNFdsaFlbWqTu5q2fDki
         CDNXJnfcRktwlh5dTNSVPLsF0sAarecxeRv9Nb3lmrrpQBP3wMHjekHMXUKnK/GntIr0
         uuhyHhu4hDyf6HXbCPy+CT83mjJhE9MSuiqZ7bZtLM3z6GnWcCSf/ccEjD8W2G2wNtCV
         V3E5gg96VBKF/0VMOjE/a3HdbzQb+tQmPJLG/DmtE7/V09pZAPpl3TMkdp/Ik6r7vJ5u
         eb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761666326; x=1762271126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnXURezN7n9VOpNAkHt+wC6tLgWa0+LJGSJ0uA+xyu0=;
        b=f2joBNNEM5s5XELa3XJHxwv9V2LOvKFp5eEF0LLuM9hk7WqJZgCQ0GWMhS+gI5w220
         7xuB/0/gWYzLPMCiMzTxuwC18qgjIbBi+ojvanjGSTSX4yhkkOV1whYLhdaZ1gVw3hs0
         GVMllXgWwTr9oCJsP98P8qyRMnGPFhbxkUi2o/iVbUNxVG9UBVfc014c/lcgoes/p17a
         QKVC6nyM2ahuST0j03d1ADgbozAqm6FseLRHu7uPd9bk2FQaod+3tZ9496fZcmXGMCZm
         k5QCUCcHmqks8FLrsSwMM8DMYiylv0/vOYjxmgulvHCZCAtNWSeixJXX4URk9szrhd/Z
         h7Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVqTmx9iW5p6yHv9ZGt3PFc/qS08qeoMoM57eTDlhldTuXs8mSqOuaz7Wfa/P60vetayjWxhlZlDnsAN2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywscq003Y6hOrOP1yLlPypirX2wRUyfrhhDIxHzJhq7ZM3CkD0r
	hpzXSRX5a+XLcjIndAzH+cEEhQ03IgATQmRvdJNFkeE3/5NGMe7sKg5O
X-Gm-Gg: ASbGnct/aqIAF5KM4labfT4zjJNp9YQuea1kXviiN42E29iwOS9ZgTGX0iEu9Uz/Enx
	fYH3hIWLyU9nNa58dT+mBOhqNd1DZCw8oIvVnMMKXexvYY/jjKUPF4TcwJfwSgrq/MUNJpgud3m
	kWi0Rj6QYplUej2C9oiqyc7C+AvJxWqUl4pTduYYSKAVS2kg0Sr588YSHz/o2t4hAaoPBHLggiB
	8UvTFt4XRiDTmsOFh+D181pAoSvSqng1aoEpDvoLGAat7ZsKcPvdAKWGe56W+W59U4xbpD0j1GU
	7zx8v01gtXJbDs11oVh0S4vsrpJuJDmTGMPTTtRj0mdpXszMbNNRJSAO66ZwIfr97CfrX2Hxa8s
	H7DimwQQ77gbmmMwcPEv2iuXLK9BM+UA3D4C67Rz4glRB2kBY4nS0DnZxXbOpZbouT2FPoJu3zr
	NX2OppntrmUxSBShaA4aXM4tU0FBnnpi9NXdbmpHLiHkZBMoByOegWmEmxrw==
X-Google-Smtp-Source: AGHT+IET/efRhuIuFB2PFKn8DXpNlkISko3LPS6KKpyQ63Wdmub6V/UZ/rCEDYkQXXUtyr4tnbPxTA==
X-Received: by 2002:a05:600d:8386:b0:46d:cfc9:1d0f with SMTP id 5b1f17b1804b1-477182e1357mr23793205e9.19.1761666326096;
        Tue, 28 Oct 2025 08:45:26 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df62dsm22927131f8f.45.2025.10.28.08.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:45:25 -0700 (PDT)
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
 Re: [PATCH v4 12/16] mtd: rawnand: sunxi: introduce reg_spare_area in
 sunxi_nfc_caps
Date: Tue, 28 Oct 2025 16:45:24 +0100
Message-ID: <24133952.6Emhk5qWAg@jernej-laptop>
In-Reply-To: <20251028073534.526992-13-richard.genoud@bootlin.com>
References:
 <20251028073534.526992-1-richard.genoud@bootlin.com>
 <20251028073534.526992-13-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne torek, 28. oktober 2025 ob 08:35:05 Srednjeevropski standardni =C4=8Das=
 je Richard Genoud napisal(a):
> The H6/H616 spare area register is not at the same offset as the
> A10/A23 one, so move its offset into sunxi_nfc_caps.
>=20
> No functional change.
>=20
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



