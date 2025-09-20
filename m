Return-Path: <linux-kernel+bounces-825749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB33B8CB91
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 17:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C827E0A30
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 15:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FF426FDA8;
	Sat, 20 Sep 2025 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="iWqtrSbk"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBE51F428C
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758382303; cv=none; b=WoOd3dCysme/CZs22eSgFFz8zEtpUroh1zjsxDtm8mpBi2XOuyx5QYN+m8JYfBao2QdGNs6rUMlikAfEBjd22OEkXDIIeB7XMJL98fLTOSeKM5+GdudJUdFhDyfhdrFktVjAZvEzeI0YwBSfUPokDHxyrSmZ2K98wSB72uDxhnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758382303; c=relaxed/simple;
	bh=hSg3c2ZghTZizAbYqX13nbRSTVnHbltJh3jiavgkq80=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YY0Hj3rFbGrkhAPTwOvqGlJczZB/2dnHpYO18Rfi9I8vGaHPlyF+h5UzUF9IOOtFI8H582H2PC/0wDArYzYF1fL4XCvRXEx2FAG3ZSTpoJyQ5b8at65ZOCWxExrmzgy6hh5xTtd9vTrB8qcLHbd6li8WtULohW2chbYKHNwOqyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=iWqtrSbk; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=iWqtrSbkxBi/JLRtP+iV4RQ3k1a/tesuTQDMgAOYaJrV4z4Alue0kRIlCXG9+d0c7mYoZjRyokZC22Hggfu2+b6LpUspt8EsOPd0y42DuKze8KnMR2qsqUXog8/vBIDorYRSGpMhhkzrylMEnZFo8XMajFm4DXKrdI8Gvhw40NCJpOAClQuewkde8tKwYx+5CPhtWn7VLhRtgiGa2pcmcfDUwpPA/HPCQNkI0yX4WgetJ6Kekc3bFTlHJePlollL72koMZLnIU3bi1RNKs6xTQm77+g+4MTi19Y8AgflsVqnDRUe5byyQ7OWccIXe0Aa+TVbQyjfEvY3fDB14PL3eQ==; s=purelymail1; d=purelymail.com; v=1; bh=hSg3c2ZghTZizAbYqX13nbRSTVnHbltJh3jiavgkq80=; h=Feedback-ID:Received:From:Subject:Date:To;
Feedback-ID: 68247:10037:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1935225507;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 20 Sep 2025 15:31:09 +0000 (UTC)
From: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Subject: [PATCH 0/2] i2c: Add support for MT6878 I2C controllers
Date: Sat, 20 Sep 2025 17:31:02 +0200
Message-Id: <20250920-mt6878-i2c-bringup-v1-0-d1527ffd3cd7@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALfIzmgC/x3MQQ5AMBBA0avIrE1SDVWuIhZa05qFkhaRiLtrL
 N/i/wcSRaYEffFApIsTbyGjKguwyxQ8Ic/ZIIVsRCcFrofSrUaWFk3k4M8dVS3mWlvjlDKQwz2
 S4/ufDuP7fnRUnrZkAAAA
X-Change-ID: 20250920-mt6878-i2c-bringup-640d48cbf66b
To: Qii Wang <qii.wang@mediatek.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, linux-i2c@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758382267; l=759;
 i=igor.belwon@mentallysanemainliners.org; s=20250908;
 h=from:subject:message-id; bh=hSg3c2ZghTZizAbYqX13nbRSTVnHbltJh3jiavgkq80=;
 b=ZmmuUVQP60SFRzeKx5oSct4QOEoDeLeYJIF9FKk4TQgtZPtWpkWxvMFN31WjyU6lbr31VyM1G
 uWVbihpePQ5BA6j/daH/+17Zn4BAr2LzmQymhbXdmJlbCFgEvwgwFTG
X-Developer-Key: i=igor.belwon@mentallysanemainliners.org; a=ed25519;
 pk=t9Kz6B3jEwJD7YAKcp8XftfEz7SUSlGbrsfFlbrrFwA=

Hi all,

This patchest adds support for the i2c units found in the MediaTek 
MT6878 SoC. These units use the new v3 register offset scheme 
(differing only in OFFSET_SLAVE_ADDR).

Signed-off-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>
---
Igor Belwon (2):
      dt-bindings: i2c: i2c-mt65xx: Document MediaTek MT6878 I2C
      i2c: mediatek: add support for MT6878 SoC

 Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml |  1 +
 drivers/i2c/busses/i2c-mt65xx.c                       | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
---
base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
change-id: 20250920-mt6878-i2c-bringup-640d48cbf66b

Best regards,
-- 
Igor Belwon <igor.belwon@mentallysanemainliners.org>


