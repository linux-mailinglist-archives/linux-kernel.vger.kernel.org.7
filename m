Return-Path: <linux-kernel+bounces-823296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23659B86117
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8345451D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B993F23C507;
	Thu, 18 Sep 2025 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKzEHZ9f"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A8330EF86
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758213623; cv=none; b=IIe1fic3l4YZ5F0YIRNSUdvLidoxeWrLdcdI1UEJuxUX0+3v43niAwsq1HOlT8hAyotl4yFnaWBKya3m9U3kKkFQlrSEgbCptDxOHS3lErkls6spvwCk7apPqWpw7ckiocTQfvux6dPeoRT7CFOPqULTkuRltYnPnHoyajqk5zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758213623; c=relaxed/simple;
	bh=8qXux/Vc1dzPkgcLfFCrymBfcnJ2c1a7n4ElLdzyceA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d3oaOjj/n3mEYCXraL6d3VraNdBApa9RDylPUuHMtq2Iz/YoHlmGIIx0tf3qOfnSGifeijm9SuWv/F2UjqPmfw4NhiO6a5F99kbt9RAiVzchrTh/hzEj+VaOuTMOWrEe5wLWCggq0dYCOdeekDvaLYo4xjMVu6PM13CERgR6hBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKzEHZ9f; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-826fe3b3e2cso112052985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758213620; x=1758818420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iOLygcP+xzbpP7kZE0AKFOWZV0EFCw3JTpU16h/cZRg=;
        b=lKzEHZ9fiYGdgIIgOEqQp23Kp2N26u/U6j1Ra2jCvR8d3UngNgMHq0gUgj31geHzSR
         /nBHaaeOf3EowjsWFlEyCShjtc+Yski/Egb09UVbn/xhYICjdVaIJIp+yuVzt+riX8V6
         Y+/5CHn0snVbqQ6UBbGTzKAGrxZBq/1s+V0g3iBW2YXE3TUJgyvZQLE6kLB3kfVhrMdB
         d+1K4u6ySi2DyCeO7mL7bCa8xjYubvaT0sEt6E1vu7C5ZoE8u1ouhSAVJUen+lxx7Adg
         gQkv7qSExrAlFoM8OeTPUM/FGkWoVewqLF8cjfTbyxdL8AZh8gqOVRUdoTdp/D4DTiXz
         vncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758213620; x=1758818420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOLygcP+xzbpP7kZE0AKFOWZV0EFCw3JTpU16h/cZRg=;
        b=iIvZz54NMMZtbnDlDtHfX2JCAgHbv29HA/ol/BY9d7fzK6gLbdZs0ZFfHI+umegQXH
         SYQRR5QlipSyaXL+0pWnrGie6KeP5MRn6u/+IoZpvejnFdq1BzRFhbWFndoNTtN8Xw44
         kl5rEOfR1aS+bUq3APrBRmYL44y5u8ISRDKeOKCeFF9OQSXHTheUb7jsKogh1RqQcUOf
         Jf+og/9zIWCtsPcN/UsugWXt2KtgTpHpSnW9JTjbKpDhCpESyk02OU3tdy9mPjZ41NOG
         eGqCV9m4DaQne38I+MrdpckyMbnjUnVMGjXNHNcNrrYlXBJEucmziXKbBJ3YSST6Jyyg
         8EdA==
X-Forwarded-Encrypted: i=1; AJvYcCV2j6vsQVg02V+bg2jEsuZ7M3ozgwAMUXcEIrHRm1LFnlPUcG1rmRgkI4gl88PhIAfZczKFJUJuUW1CDHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG5FW56JdQgITeSI87TulfZ9Al3Bno3NQkZEDsHW6XclqDPOAJ
	EdLQ99j9wQkV8TvmqB2T2Rj+hazO03pik3O8h9kkBA1TyaSr8xTTa83KP0z2poTQ
X-Gm-Gg: ASbGnctqndEw9cxhZ110nGljWBNNBRSsYlsckFXJtrlhwrXtNfbCJqAQornj1QMPKcr
	R7gDW/603D1MaEHr7cDDxlSHiPPHrhtRTi/t9V6zNO5rHfPBmH+eQGj9jHPLq0UaQ7hJQ540ZyI
	/4MaqImtTulMrhOMvB+kS5bKP6Gfnkx4tf3y3bnoCOCa+GG78q1fcRjPEDG3pPZEy9AIDQTjHGg
	Z7A5UFA0u6WCaFRszsO9hTYSaSiMDf1cLmvoWUdS7UOytVZU2bEkEvntilDDeA57DUL5+rUDUA3
	oeiEkEqoyAlqYZOp1YjUOpmmSs/7OPaMc3VfinGQ8mZovtLhtzt4toYqUH2Ad7r9vwdUq8JrM2O
	a6u66WS9rxsYVbZH74blvB+mBjrYI76aX2fLh+RngjDL2y0KJEhQ9AHJlo8gXvS1yXw==
X-Google-Smtp-Source: AGHT+IGhjrWbjFjKXricb0N1Q63somwo2IYSb4i+ebrBpab9emSuZ+a4s3k78yG1lZ0DEe7YjEtAag==
X-Received: by 2002:a05:620a:11a7:b0:813:8842:93c3 with SMTP id af79cd13be357-83bad40024fmr21056185a.81.1758213620307;
        Thu, 18 Sep 2025 09:40:20 -0700 (PDT)
Received: from lufimio-laptop.mynetworksettings.com ([2a09:bac5:89e4:1678::23d:12])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83634a4f965sm180540385a.71.2025.09.18.09.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:40:19 -0700 (PDT)
From: praful.adiga@gmail.com
To: perex@perex.cz,
	tiwai@suse.com
Cc: kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	chris.chiu@canonical.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Praful Adiga <praful.adiga@gmail.com>
Subject: [PATCH 1/1] ALSA: hda/realtek: Fix mute led for HP Laptop 15-dw4xx
Date: Thu, 18 Sep 2025 12:40:18 -0400
Message-ID: <20250918164018.69040-1-praful.adiga@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Praful Adiga <praful.adiga@gmail.com>

This laptop uses the ALC236 codec with COEF 0x7 and idx 1 to
control the mute LED. Enable the existing quirk for this device.

Signed-off-by: Praful Adiga <praful.adiga@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 85bb8c4d3b17..7d8c60f1a751 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6469,6 +6469,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8992, "HP EliteBook 845 G9", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8994, "HP EliteBook 855 G9", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8995, "HP EliteBook 855 G9", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x89a0, "HP Laptop 15-dw4xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x89a4, "HP ProBook 440 G9", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x89a6, "HP ProBook 450 G9", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x89aa, "HP EliteBook 630 G9", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.51.0


