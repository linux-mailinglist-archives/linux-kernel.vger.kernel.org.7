Return-Path: <linux-kernel+bounces-849105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8C7BCF37D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 12:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9343A4C10
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 10:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1811C257846;
	Sat, 11 Oct 2025 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VebE0nXN"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C01A23D7E8
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760178024; cv=none; b=iMKmrf2E4kgB+NJzTW5nsSva430bGJFjwKjbdcUuSy0p4Kmmf5IIo/KfIYf6tIWUViWgdbjyzogcz533aVOoVMpMFTBSBiQEBnMthYuPFiKEEWq3FTKQ3ca+gGgLrwUPJaIB3KBgXrd9uauMdNoDSKa2l3oPL4hmmJw27L37S+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760178024; c=relaxed/simple;
	bh=kH6m3q9Go+WlNJw/7g8dG1h/aaEJpSAxzZprEUvs9Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqNFE6fUdGhjaB1wKbYCseaN9sjlr8tP0ZZBxBGkMHtHau/7TlrglRXWjY2Pz71y8Ph5qQH0ZGzh5uETtBrlrIPvZLGscCSMKcLnjelIXar6SWabDYC/a8JcQAGGIovm9jZPbsfbllw03AyUivKlelNdO+KsPS0Ij/9bjlnQuns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VebE0nXN; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so520279766b.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 03:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760178017; x=1760782817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kH6m3q9Go+WlNJw/7g8dG1h/aaEJpSAxzZprEUvs9Nc=;
        b=VebE0nXNeIr2YNLJhPwkR7q+thpqkMZoXp6Cjwa451Zw5JlqfiLSuEQ/ltSVXPMp+O
         Ac10saPyWFjLjiBF9Cq9f0Q1cutGOEhnND+PLDeYRIKRhtH3X/PiaADd9pIxLwIw5Vnt
         6v+o5KwjmyDw9bzfSHzYnUsyP4n3OrMCqDicYj/wTpp7loC4MEiPlr1W5V72mOrYbBHz
         lZ9QzfDcLqvRCbz+IGgKYsSt6RwiEntKR1DtQ5z8StmF/ogXIYJvS/UrL5F1BeY8wr1T
         uv79TCQW5rbAswOmdnyho5Cm55FIrS1xoBl3WCaPW5SEq2xIP5RDaW/HtkxKPOe0CIl0
         IaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760178017; x=1760782817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kH6m3q9Go+WlNJw/7g8dG1h/aaEJpSAxzZprEUvs9Nc=;
        b=fT1E95m7V9BWzNOsF8aa+sdmc6/A4uASmrxKrD9hTsaXpAUIMTSN/07sSu79fsHQRa
         FBPIzmqcSxzxD5hyLbzmxBueT+OjagXSikuoHF1slOqlQgNNkQkPR+/fuozSsv6pp1PT
         hlxHBUFgvKRDuTQt6Q3n0aMJuAfaYBZynEO07hUosG4zFI2hy5I+ot/vAto8upwLziWo
         s/uCS7iFuHu+hMikbaXyTuK2FSr9icTJOXoYwbJbAgDtYMQhO29N5VlDgX8U9h8T5wxM
         jc+20aK1pRo85iFthKQSiFaCVVYjdsj/7y3ydH1Z6xsesXIKmYiZG0uVRy+z941dUoKn
         cdYA==
X-Forwarded-Encrypted: i=1; AJvYcCWhftDLhg3s/pzzKyud1WsSf3JdkwmbvyGXICWrClZ00YD6NgS1Rz/d6UCdcZSnNwfu292crd3iVFstiqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQor1ct7F06Mn7IBvxup/Lh4Q4BERgxU+P8GIS1XwJrublOW3o
	v5WyedsdsbbQFfdZEMMUXFbDABJfnqdNLBde3xD7z3uCOwQzceHqrIC1
X-Gm-Gg: ASbGncuhoBZCjPRUNzey2Y6hGcw+XbheHoIOkG5zjLcK4pt+ok1GrLIlp9VZHdd18qk
	ZPN/gvo9QVteQroLCMNxzAwKsKrnaxyPjfSnlMLHW1wRnNpecTopXOSrDgtsff2IEhSodkNJf88
	Yhu77nV6WeZ6wPOL18893LcatTKX5xM8TgAusAbPwElWiAigUHt7HvtjK1g/s9tQPvEibBCGL2y
	HBpNWRHiUFGytZasRY/8rRg7NrDtiZfffROUkC/jKCwvgkj1UkiGL8y2/APaQbPb83ccT5VWncp
	c6zEQqt/DLOa0dP8HbXDRJ0EViwmYV/2ISao/z3N0S6QL2efXiJe1J4XH1wQT0SuLsLpJh/pq96
	JEYsymgBiOSQ27NLvxja0OCnNBbPk8L7I2eqB8xMVyGWX85/3P1Vqt4/U5qFmQeI=
X-Google-Smtp-Source: AGHT+IHolFmrbsPL01Gij9mDgcL6wtIFQuNZ62CxZG1hurbWV+WEoYmcgYDEtNQjTwVOdmXwqzHL9A==
X-Received: by 2002:a17:907:6d25:b0:b40:52:19c2 with SMTP id a640c23a62f3a-b50aaa9c937mr1500673066b.20.1760178016637;
        Sat, 11 Oct 2025 03:20:16 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c12a8esm454077866b.42.2025.10.11.03.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 03:20:16 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Richard Genoud <richard.genoud@bootlin.com>
Cc: Wentao Liang <vulab@iscas.ac.cn>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Richard Genoud <richard.genoud@bootlin.com>
Subject:
 Re: [PATCH 01/15] mtd: rawnand: sunxi: Remove superfluous register readings
Date: Sat, 11 Oct 2025 12:15:03 +0200
Message-ID: <12756386.O9o76ZdvQC@jernej-laptop>
In-Reply-To: <20251010084042.341224-2-richard.genoud@bootlin.com>
References:
 <20251010084042.341224-1-richard.genoud@bootlin.com>
 <20251010084042.341224-2-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 10. oktober 2025 ob 10:40:28 Srednjeevropski poletni =C4=8Das je=
 Richard Genoud napisal(a):
> The register NFC_REG_ECC_CTL was read twice and the result was not used,
> then a third time with a mask applied.
> Removing those calls didn't change the behavior.
>=20
> Tested on H616 SoC, scrambling enabled.
>=20
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



