Return-Path: <linux-kernel+bounces-761425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 123A9B1F9F1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 14:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131AD17A206
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 12:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84FF25392D;
	Sun, 10 Aug 2025 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="M20Az2Rn"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7576A241C8C
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754829217; cv=none; b=ohtr3DbU1FCsPT6b9v3Y1Yz+8eoOMJXc6TR1vhKn7MXm1Fe+VL4rIiYgQ1KlNQDFboUofBwwZ8WsDaCCBAhrAgvQ7AJ+ReA0CvkZb9w937s2tNHp1aBnYUzK8cezZL1NBf+Z+NVV5ATV/2ncGvmIr9SUSosECZtoKreUKxbbp3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754829217; c=relaxed/simple;
	bh=3nf59Q9AGWpmOg4VMUuCwsRS1MPEIrcUFh0ePKk2Wb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bOtG463Bc+mXVbgjzvfMYMum8pEMC26FsRKm1PcpYc3WEOcGap5RGePiSFP+5m55ozbGg0PLZ9lwwz3ytSFGPJ+LKp9VcfWPh3dLL4WRt9wLMPCiuEN8pTL7iwX0xkDBGqIReWacLfiaiwjIS/PHp65gZImvcud21lhsK2zkYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=M20Az2Rn; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-af93c3bac8fso503054566b.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 05:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754829213; x=1755434013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e/vk1HAe6XwhvBH/Z6ZCTNjAcCh+NxJHs2NAijcEcZs=;
        b=M20Az2RnVwhQS+Anv8XdgRkgg/mPpUkrezFO6MotAUluwduq1InIqUiBq59IKSdFk9
         DoQHEexmg03qSGnHA21XpYIJ9bCizx7bXIZphMaqZtDyRrZ42YxXUYQZqYZBvywpT9c2
         3gy+efh871G3HLy/WNZlwXqCtbbgwzDuqVrXANBiq3EX0+rGVoN1tSDwzH7RkR7iI49G
         qyX276O+1ot2JPMy1n3RF21k0hWz1b9oAKquYInWFc0ahLFzS9EuE8WvYf2TtRZqNnyM
         5LYd61r60BgJ2vH0Cb+VUYSA6c+pER/zXyoTQMGecnVDJNEscjGwHTzC8eKVN7ia/vgQ
         hrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754829213; x=1755434013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/vk1HAe6XwhvBH/Z6ZCTNjAcCh+NxJHs2NAijcEcZs=;
        b=Y3X6bt122d+9V/NPl90k/Um+eltbzzULV1dwUTpMwy4EVh269Mbuil32MKifI1Fdub
         Abd0lSLAdrbHBLTKBuqMjQSxkMMNGBpqHObrHHd8bpbT8qxhRb9NkoWJhg6GizzIRNf7
         yg+4sm5tvWFARI6bGStoOHH9eplFFQy2bSuUBZlVb2YMMxD1AYCcWK3/QokEe6YtfTRH
         h+mvYwRzrrTEOlOBuJOaqk5NsOmCTZgFd58/PljH9Pn4ByLbPFdHS2PEysrP9sV2mkNz
         dVzWHoB/AswwGP+WKJrNyPokAC3TV1BOp5i7IwgbmDM15sVm2zrv1Yv1xVV0z1K04LCo
         d/7A==
X-Forwarded-Encrypted: i=1; AJvYcCU/oioQxtm5l/XLNtXm+cxSBlO4RnkGsaYyw+UpdKYSbHcqV+7W7i54BEGj5TyNU1suGlGAnxiW5u6pSPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi3BKpX1mMnT1dzQmllppJeWhlNNNCik5afupH9h4haINT3hbW
	VxLT5buXsy5QO33YO2Pu7ie/geXlzjTNg/g9fOkzd43F2DFqrONdDE8QLAad41+0ECI=
X-Gm-Gg: ASbGncv1vtEahsudE1R6lI5F2yFWw0oYoPNUNEFyPyTM2ZLFSH6tj1eQj2yITeTzyXR
	XWjtm/iR9SOrMThhWv/IwKXuJz3Qh3jAixe198asZdGOJnIx4AaSiVTTGuTgUJr0f4XnqNp/Qou
	/pkCsWBp2MdOj3jRBrD6Ea4yU8i8vlsvlMGdxmg2sUDakNEbPwQCUtI5OjIxCZlYgnkA3edE9lU
	OFlK4jlVE8boHGC+02IHoeyoCn4invCqSlvUCRbp1ffv+vHPAV3D2yRzOCdM5lC7tsiIsX6jr3B
	0Sfbwtu5w/eioCXW44RSMv2CKUPAqb2KRA0n2MKadvFlWqfADAXvFV/Cjx37bhFGMzqxvU1hAFL
	YTIpVi0uwiDnX3Qo58F9x6HjaVjhcg4pzv8ocNSoJ3h6NII/gJH3o
X-Google-Smtp-Source: AGHT+IFu5S+xpfZ42LBfBM2LxULYyH7yrjzISc4HpHnHIpHtS77Eg10O7wraMX8ZzVEZ8pKVCi0TWg==
X-Received: by 2002:a17:907:971b:b0:af9:3116:e0ff with SMTP id a640c23a62f3a-af9c653f538mr968527366b.52.1754829212827;
        Sun, 10 Aug 2025 05:33:32 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a2437desm1852203366b.127.2025.08.10.05.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 05:33:32 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v5 0/2] iio: rzg2l_adc: Cleanups for rzg2l_adc driver
Date: Sun, 10 Aug 2025 15:33:26 +0300
Message-ID: <20250810123328.800104-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds some cleanups for the RZ/G2L ADC driver after the support
for the RZ/G3S SoC.

Thank you,
Claudiu Beznea

Changes in v4:
- dropped patch "iio: adc: rzg2l_adc: Open a devres group" as it is
  now fixed by [1]
- added patch "iio: adc: rzg2l_adc: Set driver data before enabling runtime PM"

[1] https://lore.kernel.org/all/20250703112708.1621607-1-claudiu.beznea.uj@bp.renesas.com/

Changes in v4:
- open the devres group in its own function and rename the
  rzg2l_adc_probe() to rzg2l_adc_probe_helper() to have simpler code
- collected tags

Changes in v3:
- in patch 2/2 use a devres group for all the devm resources
  acquired in the driver's probe

Changes in v2:
- updated cover letter
- collected tags
- updated patch 1/2 to drop devres APIs from the point the
  runtime PM is enabled

Claudiu Beznea (2):
  iio: adc: rzg2l: Cleanup suspend/resume path
  iio: adc: rzg2l_adc: Set driver data before enabling runtime PM

 drivers/iio/adc/rzg2l_adc.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

-- 
2.43.0


