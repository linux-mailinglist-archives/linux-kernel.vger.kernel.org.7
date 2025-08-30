Return-Path: <linux-kernel+bounces-793147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73192B3CF44
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 22:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B451B26B2D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 20:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FCF2D2391;
	Sat, 30 Aug 2025 20:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnAOURzg"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B635B42A8C;
	Sat, 30 Aug 2025 20:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756586323; cv=none; b=d8/XNZbGDZYcNgCs0bpledI8ySavNG5mt+WF9exoczpw/by6JsVeUwRTQ//yQFbZI79K2gUe2b/7cbubYCNFR80x814AgrVKVdsitQhC529XwO41jsccxOJPYyz3xbQF0YcrghUhfsvZ3bKKcDe6Obqa+gooEa55R6XJeftHx1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756586323; c=relaxed/simple;
	bh=LxDKyCBpaWM17lmisPDff38S0McR3uCZIfcas5RLU0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UOncXPaiqYtIodwslJlkokNapLCVpqFn7hUvpxOslYIrrI/GBAOdr1AahkVnJoW/FCeE07TwOF1uKORo1qao/OFIKd/VLYSYfsMBSSO80ChgM/diFm0/L3yyE0D0s7CcX9izKAqp8tweL9XrCBFWZZHeGkhuHhBjdF6JFtEw+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnAOURzg; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-70dd6c93071so25662646d6.3;
        Sat, 30 Aug 2025 13:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756586320; x=1757191120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XD/MAfd0FmRuxTxg6+ZVnGPk1e/NXFXUrP3nlfdWAi4=;
        b=nnAOURzgZA7Lsaso9auGyS7vNYe406fVLHblBTVVbqXsEPdPo282ZdPRux1k359u9G
         GmWbCMzIXc7vTtn0j4fmdkdw7uxh0tnv6LZFY0/yS2nzbwE5+NlkCIy3x4XD7NPiM3x0
         CTt3OCWRsxD6cuNcbfvY/jStjzujyElgUDpRH0DtBPd5XjEAqmBemgbsMQG0lvfKERRW
         DiJHzik6lvV8d7CPHTTtN/OAv6QZLx0r6+lKNBrVsN9UINCnJIdFKGCPPXJK8FM2u5YT
         JJQ8isI6N6vTLTkkQ8OhkDZt++dJh96/fIlmy2Kph7cHoG1d/IR8DXJ/XpDCHGptu/OU
         D/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756586320; x=1757191120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XD/MAfd0FmRuxTxg6+ZVnGPk1e/NXFXUrP3nlfdWAi4=;
        b=DK4oPKp+KwuQMjR3AqssZ38WRZbGvqO+F10CjflPU+XMZ3CzsUnLvQ8nzAYPVKG6e9
         0fedRIooYhSWr8Keb9HedjWiKf7UE8+xevh9wa+nLisgvv5S3tvDeMUy5PnLAGDDVeuc
         QUbyqodB82yD3DrMRTnpKlEYp7ZbRvNAa6M74Vrni1pL4bczVhRGYZmsi+YZPVyToV7D
         6di61HQZunNDK/x/nU+ARoivRoKAfu2TyGQSvzd8qXlgjDiNB1MUXYoiWnYAUTml9GSB
         hqdwpnutOd+bwvCXDs3EPTNXgcvKp9SlJIykXfla8YSX7WfJiKKFEgdp/6xsGtwdLss/
         AsMA==
X-Forwarded-Encrypted: i=1; AJvYcCVoL45tusGQFLq483NLm1MK0Gis7DgtoWtxVzh9Po4i6fxR95K72ZO7HRL6qOfwdgPDEmQesmcg2z9xhd2R@vger.kernel.org, AJvYcCWVKxmxyJUm+GEoJoxjpkcD+f7IQr6CT+5JuthuD8oDKAuWmZcQUPSyzKqIm6DSN1PNs8lU98HsARaZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5c04JMRfKbUdt4OtdtP//ZuDc/RsmDRCnGxOP3vlCtXccoYQs
	1ufKMmp+YaZyQuWBX7EtGpli4t2BVo1JolrkCuzkic1ipUFqQU7ToGs=
X-Gm-Gg: ASbGncukRj0qatM5LQYF7mZyuxtb2UJKf8GL2pJfb0fo7sCI+4zqX81L9hAVd5W6rkb
	ZEolmX6AhZP4L4MmaMNDO75w04w70TqsnUkSnoXq4yxedvzfrUfnjFq8F/nvr6HKNiAR8Glo06B
	JWMJEAuX9CtTudegbwSnoOqiTeUz6AgzENfeFmgMC1YUQ405unCjAEXheUZzq7y6IKNveerEODz
	FZMpOmnWFWwEMnaK1SbAlLob48R//73G5mVM4LMdv9gWNKFx7fMAMrVAaMjQCu8DnneHfpnHDP3
	e5scxtSXod2RraboDUkjSpu6DTvyhokF5/yR9KN1n8uuKShH3AH82TXRAptMBUT1O+oxBzOGBV0
	IKIgH7InuANEX9zy9xE/EEYc3OkIY/IHop/mh3art+7tImg==
X-Google-Smtp-Source: AGHT+IFS6to5vY2VYlyraxVUNpxIYUirboiZEUashAJKL55g85AvTiIPmQZmSMyY8xN1STzMmDupmw==
X-Received: by 2002:ac8:5e0b:0:b0:4b2:fe63:ade4 with SMTP id d75a77b69052e-4b31dcbfc82mr36311931cf.78.1756586320573;
        Sat, 30 Aug 2025 13:38:40 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:68e:c28d:1818:9595:da56:53b9])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b53840bsm37557771cf.11.2025.08.30.13.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 13:38:40 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH] ARM: dts: kirkwood: Fix sound DAI cells for OpenRD clients
Date: Sat, 30 Aug 2025 22:37:50 +0200
Message-Id: <20250830203750.239890-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A previous commit changed the '#sound-dai-cells' property for the
kirkwood audio controller from 1 to 0 in the kirkwood.dtsi file,
but did not update the corresponding 'sound-dai' property in the
kirkwood-openrd-client.dts file.

This created a mismatch, causing a dtbs_check validation error where
the dts provides one cell (<&audio0 0>) while the .dtsi expects zero.

Remove the extraneous cell from the 'sound-dai' property to fix the
schema validation warning and align with the updated binding.

Fixes: e662e70fa419 ("arm: dts: kirkwood: fix error in #sound-dai-cells size")
Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 arch/arm/boot/dts/marvell/kirkwood-openrd-client.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/marvell/kirkwood-openrd-client.dts b/arch/arm/boot/dts/marvell/kirkwood-openrd-client.dts
index d4e0b8150a8..cf26e2ceaaa 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-openrd-client.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-openrd-client.dts
@@ -38,7 +38,7 @@ sound {
 		simple-audio-card,mclk-fs = <256>;
 
 		simple-audio-card,cpu {
-			sound-dai = <&audio0 0>;
+			sound-dai = <&audio0>;
 		};
 
 		simple-audio-card,codec {
-- 
2.39.5


