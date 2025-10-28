Return-Path: <linux-kernel+bounces-874113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B395C158EF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 921884F3255
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E557343D66;
	Tue, 28 Oct 2025 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPvSISls"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D367342CB0
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665857; cv=none; b=Q+hT1RtJrc62J+E9muXMS/q8GlueQucnbzQl5/TZ5QsRYvC4Sj2Nnfj3IlRVD907Ein+sVxRYiLqpS3Ihu4o4c4yx1QK/U4k7eLIUhIu1yFGR78OKKoY9ueaSfIwLP372hF0+BVzGQCsn7AgveM/yhMU8dBueTY2UwriqkUkT3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665857; c=relaxed/simple;
	bh=Tq1rindzPoSv1LaOddPS8k5NKUTrYDUpuyisQ7twQKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=An2gTNpfA8XB5hXHWwOJjlRbZcpmkm2ufgobxMF06Xq0BmQhRoSL31Zr4U1woXKOCHh2avLpg6c9/5rSQ1YAeqEhQPdg0Shhe5W5kbG5Dz/oAxaQTgn5CBWQ7kPWr9/vP+jv/3LaDUVIIdMxIdm59J+R3YwCJX51CXmi4E57E1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPvSISls; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47118259fd8so47661385e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761665854; x=1762270654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tq1rindzPoSv1LaOddPS8k5NKUTrYDUpuyisQ7twQKY=;
        b=gPvSISlsA1aHBrRGmqewdjqlNum5+MKCl/FahsjJUwQ/q01Zn9fcvht4RW6Hl4wD8U
         YcXVy9Mss8S1sz1XT3shm6EO806lJ9QNaLHOCaoGOWyiabEeeZNb39TW2J503e7mGm4k
         7ODOw927nJyTllBu+/098Ww5rKUIQSsa1LUZbkXBqRbIaLGHfjll0OIEICQfz1bru1lU
         HgJPqRDgko77/Gl8u52ekJuxs4310YAc+eeVXx6XjetO+h2oG4gcaFi9x3wDy6daPEfk
         36vWh6idubY2szg4MEMbZ2gRicqRCLXtMq6n56L8B2hpDA7YE8AhVOzxGK+KegACCCA/
         LjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665854; x=1762270654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tq1rindzPoSv1LaOddPS8k5NKUTrYDUpuyisQ7twQKY=;
        b=lpxthqgNQmXgdyuzy9dWN7m3oxC96yhcWek7IoDayGnntnAV6UW7jMbfTt+UTXDtTA
         BjVdDd4Zj80P3c0lE1zDVSw7AFLFFeDw05c2kSbsSkI4GhKZt9iEP4ZZYZ7n2WQcfFIU
         S9uozOrZatH6dnDve1o4/3ZT4QyjlClsooiXlzAPkIeExCgbZGaXzLjU0rUSrHkipue4
         BWwD9sgsMVxOzhv94lscffmLXx0v0yM4hWKQhnn42N4twz9hztM76H8jRXBOhoGSkIrL
         SjCTbM5wNH0vk0yPDyfQD1qt5lpr46M4BDYzHC0sNjLBZ/O99J8YP4a+wBrc+OO0qEpB
         xHCg==
X-Forwarded-Encrypted: i=1; AJvYcCX9fDflui7C7r8B2FEE5g2+BtrWqAZxqJNRNnfdWR8vczDJsykrujNcz+rmGUwM0IRprVOmZfv9fi5lYOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YycyxgAj4Q2q06OAwLIB2zvTSZd9LChciiriWX1ozJ98SoOdGXh
	3iiRGwfTzhOMB2L4UFFwt8HDEvuMyPwJsagDWkI/Hvb4DjrgFsKU7an4
X-Gm-Gg: ASbGncv47X3IYX5Xr82uO6RqyIK3T97UxcfqJ0vjDElxykN/i+PcvF66QXZJWolAmG5
	eItaSpAik4PsXMR2t48KWE8Sku0EGWYrXyVYABXZDM4e/GzVFSkp18V6+k+RY5YrD7J89xLyRNs
	48FP6orVjbp8alNkgIVvJUIg3UfgsX2ujFPgrGM7fVUrsqKLAMySTtToxKkIkbdeikwjjGkt1ob
	AnFGKWPpQi/jYnlJGNghlMLZ7SQPssOeYQXA4ZfvC2oaTJ0ahl61fy39MI2vruf9lLdwoRGQtMF
	LT3adDT4vKiXNtusweacCOhRxb0ZoqGi4ZYJzD1tmEvkzdpGuUP0wC18PdjNo0Dc9tpqALvgH/Q
	rqu0St0r/j/iw6SUKgoKl6eIm5ksQGC9SuKFFiBmQ/GV60W6SlxtYXfn3nThMrf+mAgeB3NZNOx
	I++hYD7KEJDpaNYxxRIQ1rxu5is7YXeO0d+NrIUojdwLVy/icgWMFQksUqkA==
X-Google-Smtp-Source: AGHT+IHXOTFO2WAIn1ZujBJa9U0PAXYA4glOCwdtcmQllsrumq7MYqoGH/iY7FhfpKKBj/R4vTdKSg==
X-Received: by 2002:a05:600c:848e:b0:476:84e9:b55d with SMTP id 5b1f17b1804b1-47717deef5dmr32584225e9.3.1761665853339;
        Tue, 28 Oct 2025 08:37:33 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952db9d1sm20581519f8f.35.2025.10.28.08.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:37:33 -0700 (PDT)
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
 Re: [PATCH v4 06/16] mtd: rawnand: sunxi: introduce reg_user_data in
 sunxi_nfc_caps
Date: Tue, 28 Oct 2025 16:37:31 +0100
Message-ID: <3656445.iIbC2pHGDl@jernej-laptop>
In-Reply-To: <20251028073534.526992-7-richard.genoud@bootlin.com>
References:
 <20251028073534.526992-1-richard.genoud@bootlin.com>
 <20251028073534.526992-7-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne torek, 28. oktober 2025 ob 08:34:59 Srednjeevropski standardni =C4=8Das=
 je Richard Genoud napisal(a):
> The H6/H616 USER_DATA register is not at the same offset as the
> A10/A23 one, so move its offset into sunxi_nfc_caps
>=20
> No functional change.
>=20
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



