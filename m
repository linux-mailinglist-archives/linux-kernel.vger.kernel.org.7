Return-Path: <linux-kernel+bounces-815995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A61B56E01
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F451895193
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ECC21ADA7;
	Mon, 15 Sep 2025 01:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hG6ylNpV"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57192165EA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757901131; cv=none; b=FdoGunLdLHMgSqthj0Yr61DSsFpBEljTJguSd0uaNXGhaWugGyBTBTukUstwXnby0pZz9mDOX+77bAUJvO+SXeCPIUajSkYlNVkELEzT1GuAu17ztBnoA2UrtnpyKur5KNho0rFrKhbtlWj94tDbfEIZSjjv3uq8CX2/Bxkym3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757901131; c=relaxed/simple;
	bh=nEV1xIt3tWltM6HcFTPL9++suMELB5ydP0fIn7qC2Sw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k7A0xctvmFM7WpgFxJmf1UpYgbKEMs6NnyYM5NqGECnU6RICi0kgAe6WoYD64Hk8DJ8ZalFIhmKVSovUKBZ65eQU8VuXuvMdKsSr5mGBPaGJ2OdWWeJxTWGdqNHrgBJTf1di++aeU9CQ3h6pjG/AepmmMwejTsEZxiXgwCqmc0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hG6ylNpV; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32e6f3ed54dso141709a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757901129; x=1758505929; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mi+Q3MX+Nh87QtdSLZzXC7Ij30Ba/l8ZeRTlSODhCu8=;
        b=hG6ylNpV5TXL0I7QQFDa0nD4zNabsiaQEM0cOjGS2WdBjWo5kBXd5StcqvZsP3jskE
         QY1pIHEPZUBxd3TEUU+mR+/xnviJcABarCrNAcKDuZac1MRCvJ1dEH+yRxzBaoCVvetl
         sibvK5aii58yYj8kCE4xP5vhkh6zGMOWxG2fF1Egx9G2ixFukSjJqcwHWpKL91nmIarh
         m+pA1G/QllANeEt4kYKB3Ff+SCucWEhhCpYwWXMn6sV3wldInEVHjqYE1TMxEnwR/9v2
         S3dQeyn6D9gaSW+5hyff3ilsobB1iXtYYY4AigpflUzXN8nIFgAK97l475tVE+7OKIb5
         Gl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757901129; x=1758505929;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mi+Q3MX+Nh87QtdSLZzXC7Ij30Ba/l8ZeRTlSODhCu8=;
        b=cbD3yItVxoxhDAp+VCb/EBT9wSW3rMl45RWI2HzA6+QpG3yr8BjkN7JdtF6j2BbrjK
         Wg1bDLsas8rAlUkJw/7YCeGGH/7l0q/CyaIy+h8J4inx+vgxcW+g3XF2e/9p8pXwFs27
         O5k+kVh9C9ERH/iMmBUCV/BAeuG2cXEwI0raT9cRtba2b09vwNFcWLSOHO0+vEBH44pT
         wMgDTBdS5BvoGpvcXasCfk6kNX5hNP05doew/ghntBT5qK/s+9Ab8gjuXCtwlshiqVsf
         S+jYdwWk5hWHD/bJaYX/J9MxBfZSlzHKsBYjnDWxWH1vBtHu8ia78LDcMWDln/y5qyiF
         ESRA==
X-Forwarded-Encrypted: i=1; AJvYcCUfKv5gwumS1xy7qvnJ39yls/QJFiSVAvo+TqTbS+fk4JBGYc5izg2FocETZlrO3S/atQ0A+I14LjY8TE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHUxQ9Hcab+gQUzJuT5+RlHcnxCwWjLtNRjm7DoMdKgBU9BJfQ
	HzvdEs57PiHI8hVpqw6YvXuJIBo9AI/B3CD0PyLfSnU7t4DgXKI5OOv8
X-Gm-Gg: ASbGncuWu1E0/e/lSeC1/2e35TQd+LHPd2vszwgSDiWAe3MqQfDhum5cv4uJTt8/eyJ
	oGHuwn0hfzYgQJV0qOWaNHrwfV5SHg3/teRgO+fBMOgu2oeDR1vhFOe3M/GeqPwbrVTg90SEVh8
	0p1wy/2jNRPcd+aK/S5BRzne0HOY4ag5I7cm5YKLrsEsoCxlXTKlje1Q8n8LY/mbiQ6W76jvaVd
	7vb1NyhZfuT3B5Eld3whgj/arNfXmOAMkRvys5QzeFHi17NoUV4le5x/VOSefdHGRpTyaQ2QJZd
	MOIaCc1oRUvqfkErMRMV4poLR6tnmgueZoVe6FUvdY7BqdQcenHJ5Jp2DWHTY952r0XiUXzZPDg
	T5MLRhVfvN5umTZzUx6bEp1Of
X-Google-Smtp-Source: AGHT+IHWF+AzJX+M1VdVgQWjvhWFRrfFx2K9ZCZ7H1PPT0SBPU/undvXo0rlDVawqZIzAu9ueFerMQ==
X-Received: by 2002:a17:90b:3b92:b0:32e:ae:8748 with SMTP id 98e67ed59e1d1-32e00ae8779mr8787581a91.5.1757901128968;
        Sun, 14 Sep 2025 18:52:08 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b54a387d0aesm10354491a12.31.2025.09.14.18.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 18:52:08 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH RESEND v3 0/5] SPMI dt-bindings and nodes for Apple A11 and
 T2 SoCs
Date: Mon, 15 Sep 2025 09:51:56 +0800
Message-Id: <20250915-t8015-spmi-v3-0-f1d51031a708@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Stephen Boyd <sboyd@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Sven Peter <sven@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1659; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=nEV1xIt3tWltM6HcFTPL9++suMELB5ydP0fIn7qC2Sw=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBox3FFf0q6xEhYxdTKU4qhOvp7PkOYLr0XN5DMF
 VdVILtp4++JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaMdxRQAKCRABygi3psUI
 JPHUD/9UxVZqOz2cw72C5eSRIZTzEUA0p0te6QP9znCqu82I2RjHH+BwYf23Eko69k79/DGuSbs
 FGUBwP32VuCgenwa7IWruwwLWB8pm66q7jR01mXpnr9lwhUDo70LWRoEVnDYLNmp6n6MZu4knDZ
 WxYX+iZmOVrmeKQjB61WMdhrd9iDFLooUSmnZID6v6on9rJjUFNy56qnzjOyy6LaDK4R7G0dCPr
 l0VCegDEartwKOdK4VComtg62wUPBI38/T0yUysheJECDXvR8UROAHn/nLnhiz6PdexdahzsjGC
 fB8/eTuhdRp1nMoxIffl1Y9k8w/FOFS2CcF/8VsWIK9rpSvcLfbDZBPD1llb43BA5Ik7LkGsw85
 E0LJYrSaxdLrEhITZi4Ujqm206j9C7B1tc9YU9mBoeYaH2ulcmYcONcOz2bhK0ulLoGLvhjobBI
 oQDdnASJPWbPnVkCnIVWnaJV95iit9pqXzQ3dej5cSnmx28rYtch22kRUR57ThpquBY8j60AW+m
 PK4lV1doEGExtWpocejgmPM+wariey7WeA9CY+pmaGQM7naIKdkfE0ckvj8MflOFYud2QUrggCX
 Uit4pCRosgsiymjHL3S4aeaORsMMyRlfpSibdJSOVGAsRRnEqAx6u3yHQ+1P/XptGoz68zZ+r12
 aiptbgtn0ThVX+w==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Hi,

This series adds dt-bindings and nodes for Apple A11 and T2 SoCs,
and the existing driver appears to be compatible. Drivers for the attached
Dialog DA2422 and DA2449 PMICs will be in a future patch series.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Changes in v3:
- After discussion with the DT maintainers we agreed not to extend the
  generic compatible[1]. Change the series to the agreed-upon style.
- Now depends on a patch[2] adding the t602x spmi compatible.
- Link to v2: https://lore.kernel.org/r/20250811-t8015-spmi-v2-0-a291acf0d469@gmail.com

[1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/
[2]: https://lore.kernel.org/asahi/20250828-dt-apple-t6020-v1-22-507ba4c4b98e@jannau.net/

Changes in v2:
- Rebased on top of v6.17-rc1
- Collect Rob and Sven's tags
- Link to v1: https://lore.kernel.org/r/20250609-t8015-spmi-v1-0-b3c55ad01491@gmail.com

---
Nick Chan (3):
      dt-bindings: spmi: Add Apple A11 and T2 compatible
      arm64: dts: apple: t8012: Add SPMI node
      arm64: dts: apple: t8015: Add SPMI node

 Documentation/devicetree/bindings/spmi/apple,spmi.yaml | 6 ++++--
 arch/arm64/boot/dts/apple/t8012.dtsi                   | 8 ++++++++
 arch/arm64/boot/dts/apple/t8015.dtsi                   | 8 ++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)
---
base-commit: 062b3e4a1f880f104a8d4b90b767788786aa7b78
change-id: 20250527-t8015-spmi-838bb49d34ae
prerequisite-patch-id: 801a5b0bb76e74553fd30469734e9589acc09b7f
prerequisite-patch-id: 371cd14886cc2c5d6f6e8f8eac41f710b26c403a

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>


