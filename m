Return-Path: <linux-kernel+bounces-832885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6521BA0A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677FD18845B9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A022307AE3;
	Thu, 25 Sep 2025 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VerTbg64"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2156D306D37
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818450; cv=none; b=IPeUfDJZGcn8Q/sUSg43J2ASj/pUUNjqOcx6EQi0J5dHnu/PE1N7nc9PDseG9sWgl7vjSQeBR/mVW2p4FGXfcfgVffp+9ima0wicDQ0yxuwd6HkH8WnSwojdndYbrKYCAGTrpq7tMrIDB0qUJwk0SVRdo3HzTIXr7fQ243g7GEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818450; c=relaxed/simple;
	bh=MAVG6XeMaP+9pF3hULqJiFuqVbiW3W69qtIjS2eHzx4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=R5Ev561fYxo1TQOIRBcLoAidHUN50ai5hvZuKqFDGwqCVCwUw0NfaSCzxaYNhx6MKUsfBL9tmPfTKzlcSzKkQJysCXyhaeb+Cj2jArWR85BS44lS+58s3QEuqjq72Z5BnA8yByXnPLY4841vkCVC/F2Pa55cS4DlbFoBAohPyiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VerTbg64; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3eebc513678so1317175f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758818445; x=1759423245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ms//Cx2KpQPodFvmBjr5qtYhxMu5fF/NuoJ5civygTU=;
        b=VerTbg64pRKBH8pEy48WmhMQFgelsTYCj43OUSAUK8auqBrFt5ZbInOHXu72cPeMSo
         KPi/kXif2CQjNd5AEXhVXyCBnskfq41aI+iJhs42QwToRsXaAWGL89mHDLSCKzLgSaQW
         qCaMwXBN2dhTGtutISZkfGMgWtIUuxfzeihv0Z6fMcR0UyKrVd+J36EJjs/iRXC9gF9U
         TYVGH+AmbsI21VQzVM2yNkiPrOIyH3mHp1oAqjTq5Rvln/fYPy+cEa8QKsDWDeY+Zxzn
         0cPK32BgcKYbeeIbMjt4rcg7eNKvO2/eIbT7HmLzaJZhCRlgcl35dPU5VEP+cFwIYr7F
         k/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758818445; x=1759423245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ms//Cx2KpQPodFvmBjr5qtYhxMu5fF/NuoJ5civygTU=;
        b=VxdDMLdog9WV17uhQRwmGtPVL7uhPaYp2yY8G2Tmg7x5tHh5LqC9OKOatx73CsvQyh
         FwKb1OblibVrV+NXGLCXGVrApn3PEOoKr5nzJoqqIZnlc+0St1c4DDE+C0qxWya7XKSr
         3lATdGpBQyY9ooHZolp4M1ECpUkADRsEiw0EH/YCmtgV/XK+16wptxXWQ9muKfnF5q1c
         RJuZVhY7r5fmg6f7lz+z6F608CzhSD8jXX0zRO60ZJE57zO4BW1TH9g7RpONcwzp2WAv
         XufayXIu/zMkOnuFwYTxd0us6dX17K/JxW8E/VfdEEPhT/ixveeU1hxy+znPBzDLzzwz
         NaRw==
X-Forwarded-Encrypted: i=1; AJvYcCWZGboPlpPUDyHCfPURwt1zzOvAvQhyFWdtDTm3rZXD76kxZmXwP1txB+bu1CFXckFFZXsCDgHtnywzHsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwloVDiV70xjzRUzTepA8CVR7CIuVHTUMihHyYHxGQbbownKD1t
	7Y2AidHyQ3kIoGIPsqipslz0tkw7JKh/EhFKs//KyBxjjVYedBfGbsvp
X-Gm-Gg: ASbGncsxhXGg01xhmgmkZxyazVm35DEBrsETH1x+nFYXvvr6no63t7Ucz4le/qn5bfp
	Xq08cMiZ0bQW/oleDKwOrb/LTY0TtEnhxAy34dXkWnnlKO51T5lyzdVBL71B7dS6RMMJLSH8m/z
	MN5GALznanHKGn0eZxcZLAWiCVWHSAe9RnSsOWH/kUdRD8tH2kXjPRJeVu8FWhwOGpG3IEPnCwL
	+QFNApLsn4kZyG420Nce7nj617aQm37LbV8CjZC7UJUIZhrva9JcHLjEtX9hzMRstRTGCFhfbid
	8O06mZmJp6E69nVv0ton1Ek2ED//cDCm2I33qXMdXAIZ8FEHu0l/GcfnSxmmW1dLGPig+mUURH9
	P+uk4+QGeZ3etHT/TRk7g5YK39/XD8a/zU+fbgbliOCSPDCNULOnL19HFyAlGVFMpe4kMGWs=
X-Google-Smtp-Source: AGHT+IFhsb6qW5/GahKJeP2Wl3RdIGj6vmskf1jEdNXYYA/Gj3jq1OBG69r49jeZED4H7pHpv3jTpA==
X-Received: by 2002:a5d:588c:0:b0:3e7:6268:71fd with SMTP id ffacd0b85a97d-40e4cb6e2fbmr4192124f8f.52.1758818445399;
        Thu, 25 Sep 2025 09:40:45 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-40fc6921f4esm3591904f8f.44.2025.09.25.09.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 09:40:45 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Felix Fietkau <nbd@nbd.name>,
	John Crispin <john@phrozen.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 0/4] arm64: Add AN7583 DTSI
Date: Thu, 25 Sep 2025 18:40:33 +0200
Message-ID: <20250925164038.13987-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simple series to add initial AN7583 DTSI. More node will be
included as they will be supported.

Changes v3:
- Fix typo EN7583 -> AN7583
- Add specific compatible for watchdog and crypto engine
Changes v2:
- Fix DTB BOT warning (fix crypto compatible and OPP node name)

Christian Marangi (4):
  dt-bindings: crypto: Add support for Airoha AN7583 SoC
  dt-bindings: watchdog: airoha: Add support for Airoha AN7583 SoC
  dt-bindings: arm64: dts: airoha: Add AN7583 compatible
  arm64: dts: Add Airoha AN7583 SoC and AN7583 Evaluation Board

 .../devicetree/bindings/arm/airoha.yaml       |   4 +
 .../crypto/inside-secure,safexcel-eip93.yaml  |   4 +
 .../bindings/watchdog/airoha,en7581-wdt.yaml  |   6 +-
 arch/arm64/boot/dts/airoha/Makefile           |   1 +
 arch/arm64/boot/dts/airoha/an7583-evb.dts     |  22 ++
 arch/arm64/boot/dts/airoha/an7583.dtsi        | 283 ++++++++++++++++++
 6 files changed, 319 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/airoha/an7583-evb.dts
 create mode 100644 arch/arm64/boot/dts/airoha/an7583.dtsi

-- 
2.51.0


