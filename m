Return-Path: <linux-kernel+bounces-806633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6111CB499AC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 263234E11F8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB5B2472A6;
	Mon,  8 Sep 2025 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Tnu7FzlN"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85C4246BD5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 19:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359120; cv=none; b=BZE6Q/mSvgCMjgIowylcnHpeW28/Qy0YejEFkinwAxPFRl2O6zHwv8jTHNkDy2KLFnjRhAIz0di1GeJC1tddgQoBQAQcb9JowQ5pB8+XN9QStAEv5L19Xx9f6HDcESIvhJWQHgtacdU3UDNqGHwfpJi9wJwR+wBn+L/1hxydgOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359120; c=relaxed/simple;
	bh=9F2TNgdH1pNDHLwB0pIr1YxFZjkobiXp5n7/OLvFJn0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VIJ7a2N6HWUeJS5gT9HBnK5xJ1/Ld/LH06kNS9De8af6gzUIXgyLJIcTq781PFqwN+1HqTqc07OWfoRwS4Vfs5HQQ8VicUz5YsHAzyuHHqmq/YPMoueGiAgDnbEPF2UYYOD+28u76uGgrKvjQU9zHkit8HOwy3vsADtQOGFWp+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Tnu7FzlN; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=Tnu7FzlNRrvAkepIltGvjpu9EdsiMA10UkZXaZVXkcnFa1peLRj3E8wl6ynPkTwOwMxQEQSt7xTF+kh0S40yBzp5lJ/He13/W07ehhlM7oD5YrpbYqsSp4/gaVGa/4bBsnk5ODMI+3c2/OyI+Yq2MC9FiwbNfpAoYLOPr98MAj0ijI3Z9x25zkgg7YVn7F55kZHVOlUfQL86k9K0qWS5Vr02VvFjle7t0EHmSTjsvh4O0Dk9mwqK1xVE9lkEd5JgFllDbV9+uf/stStJkuebRcPYoXUZiyhVgyp/jHiOGwYawBbn68O53kZFbbtmH219JW8BczfN/dwfeaFnsul7sQ==; s=purelymail2; d=purelymail.com; v=1; bh=9F2TNgdH1pNDHLwB0pIr1YxFZjkobiXp5n7/OLvFJn0=; h=Feedback-ID:Received:From:Subject:Date:To;
Feedback-ID: 68247:10037:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 292196779;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 08 Sep 2025 19:18:08 +0000 (UTC)
From: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Subject: [PATCH 0/4] Add support for mt6878 pinctrl
Date: Mon, 08 Sep 2025 21:17:54 +0200
Message-Id: <20250908-mt6878-pinctrl-support-v1-0-3fb78c8ab4e8@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOIrv2gC/x3MywqEMAxA0V+RrA004qP6KzILH1EDM7WkHRHEf
 7e4PIt7LwiswgG67ALlQ4LsLoHyDKZtcCujzMlQmKIyrbH4i7VtLHpxU9Qvhr/3u0YcaCZqqDS
 8jJBir7zI+Y77z30/5GtqiWgAAAA=
X-Change-ID: 20250908-mt6878-pinctrl-support-a1d117140efb
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@kernel.org>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757359086; l=1603;
 i=igor.belwon@mentallysanemainliners.org; s=20250908;
 h=from:subject:message-id; bh=9F2TNgdH1pNDHLwB0pIr1YxFZjkobiXp5n7/OLvFJn0=;
 b=wI4YdYlwNvX69+y3MzJHzF6UO6pNEeWKFAjvc+aSn8WWJDIMJQsllOvMaB2EBg5KV3E3rULTy
 L1mHuP3micEDVGsrwXEWOIfrNFSLazxHtZeK84LMp02aFUXnREqFYo8
X-Developer-Key: i=igor.belwon@mentallysanemainliners.org; a=ed25519;
 pk=t9Kz6B3jEwJD7YAKcp8XftfEz7SUSlGbrsfFlbrrFwA=

Hi all,

This patchset adds support for the pin controller found in the MediaTek
MT6878 SoC. This SoC has 9 pinctrl groups, and 4 EINT controller
instances.

This SoC also uses the new "eh" bit for controlling i2c driving, support
for which is also added here.

Kind regards,
Igor

Signed-off-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>
---
Igor Belwon (4):
      dt-bindings: pinctrl: mediatek: Document MT6878 pin controller bindings
      pinctrl: mediatek: Add support for eh bit
      pinctrl: mediatek: Add debounce times for MT6878
      pinctrl: mediatek: Add support for MT6878 pinctrl

 .../bindings/pinctrl/mediatek,mt6878-pinctrl.yaml  |  209 ++
 drivers/pinctrl/mediatek/Kconfig                   |   10 +
 drivers/pinctrl/mediatek/Makefile                  |    1 +
 drivers/pinctrl/mediatek/mtk-eint.c                |    5 +
 drivers/pinctrl/mediatek/mtk-eint.h                |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt6878.c          | 1559 ++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c   |   60 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h   |   24 +
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6878.h      | 2248 ++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-paris.c           |   30 +-
 include/dt-bindings/pinctrl/mt6878-pinfunc.h       | 1201 +++++++++++
 11 files changed, 5342 insertions(+), 6 deletions(-)
---
base-commit: 64074b8d93abdc35ae90e38ab5135f0b13ccdf68
change-id: 20250908-mt6878-pinctrl-support-a1d117140efb

Best regards,
-- 
Igor Belwon <igor.belwon@mentallysanemainliners.org>


