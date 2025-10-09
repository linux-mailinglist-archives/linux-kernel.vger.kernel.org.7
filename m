Return-Path: <linux-kernel+bounces-846504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BDBBC8319
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA8A13B45F0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D502DEA72;
	Thu,  9 Oct 2025 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="LwwPdw7N"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FABF2D8793
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000813; cv=none; b=TgesaaJKLmbzJT9r4+L1yLx0Cr6OtdZ1uPb6bfJlKjsLR1qVlOnpcR9sOGLvjNzQ7ikj4h5xPNbZ6cTGnJX9Oa+bxNgYdlhFKh0a3LtC/j061AC/uM297bSLsKfp6bx6M8J/7GTwczVgu7cDRVdiQi6Sw8ah+FGVbP89b4k51aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000813; c=relaxed/simple;
	bh=eoDXime1aNSf41VKrWKqA9W9Sa5Zt7IvwdfTnUqBwWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QcnLJioKT9Yq7EH3jaLVYCM6BejklGRFdHBl/kQ7I1WKKem1FSNnz1ji90bCHWNchype8NUpOvNnDcro2ZfcAQvtWMxo5Zjgvj9pR3+NQcrKe9I1DaY3dS2M6qvke/Uhj7a86YS4/hBtwQDM61NNPXdZg2GN/0grsasp6ZaQQ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=LwwPdw7N; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63a0375d7b6so473779a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1760000808; x=1760605608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qacc+aeH081mkpeq0qtJjcgsPMbMH7mykJcba3R5N6Q=;
        b=LwwPdw7N3egRw4MfD7pe1hicZ2wlOpqsYAxrXXd7LEtom4gfQ7y58awj/aPdEEJ/qK
         5Te9P+DBYmNgCobg/aKKCG32uRF0Bz8xRdyiZ1DZHJsjeFooYbuguIRIZljLkfxHaJfy
         eLv6Ug/GvVhcNIgjq3UZItzZrc5uzY7HvkLyWv9g3RpufN6KcW1NlxHm6oas0ekHzbFw
         63uSNKLHat9yK5TfutbI0SCxxp8+pMR3FMzQT5sjXoEPIOgOvjZ3hmVZs9ZgOozL0sWb
         mLMQYH6jjiljBAbkootuZYB4W8lP7NjrGzvEJTaeLB/d9RdOjK/19TfRS5Au49hhkzJK
         HePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760000808; x=1760605608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qacc+aeH081mkpeq0qtJjcgsPMbMH7mykJcba3R5N6Q=;
        b=lam7b8gYgos3/giob31S3/TUsxtwyrRZuvwq7Uf0V9fTWox+cJB5Hdx0k5DAqiwJMW
         BR1+SysDPc4HnmYHt3qECha/AQYvhz6x5VLzp1sQ+hVcZwLAacSJbP/6o817/0HJ3wbw
         Vb8DEI/l/C08X+wUkXqLLJTm0Rzex+ncKLmgOBMcNcgWBlGxgXpTBFhm52VpFmOhxgDX
         5vnJz+n+k6Prj4IAjgxDiB+Qfq4wgR5ejSlAEBQAzAQLkn0FBSaob562EBBo3YKwvR6s
         m25OMe3aPh4vf8QslNwqSpYfwMuRKEbgZtoeoPwBfZ67+nnmOezbATBms5Hq9hpkV4Y0
         kekg==
X-Forwarded-Encrypted: i=1; AJvYcCW6RdHWLjgaGKELkgel6kOczfza0FHxisHzOyAempsJaD4AUS+9TjNiB8xPuIYX+ueFEfn7SZSXlyDTD2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0TtLaNoEX+fELKIWqYZ8DkBniqElT+vPuNg2MVCygxe/T0+sT
	i516y+eOAjJOkkgR8VX85NV5jpx9AIngJRyzcCv57yM9FE6lZQ3BCCRVD6AehqP0NJ8=
X-Gm-Gg: ASbGncu8QrgPyXmjRwF0w19xLnDiprDy3FJWwLd++xhzZ4WG5+ki7AdccB6s7r4yLEk
	Z1mXJe/LIGgtsR0gOZJlKGgFejwot5NUCtQ1ifhpULldPCH0NbP8Jj+aMgFwi7YrxepEkvU/VH2
	I8q5ZqaA6c8A491Geu1k4LCWX9iBRXmBmqmNA9qwkRvRWKxkjPGT4br4l6F+r9t6RCij/P1wNd6
	+rWFIwasdtdjoiNaVBaszkAsgh/HOuaW1ZJ32QyHB2jc36C6afBhQ08JsnYHoRBN/sy2w7YPAv6
	6F3X3QTTH8P0jEvYMr63SEgbBjm9I2zifPDJJKki2u5zJEHVFzv63O1fyXw4z4Xpa4C+C/txqbE
	hE4oDuWnif3Avd+uMvxq066aiGGFbpT9rr/DRsgvabpZSB4O4nZ97LDQK7ETKTkcCLppbd1tHts
	iKit/6iMhy/RYE85Bxmg==
X-Google-Smtp-Source: AGHT+IFYR8i0mrRw+zCNEV/pJoxI4LYGMGp5GEhXLNZfBhL4V0B1OriyeP/tbhf2zus+NefeB9G68g==
X-Received: by 2002:a05:6402:1d4d:b0:639:fd55:37f5 with SMTP id 4fb4d7f45d1cf-639fd554056mr1180673a12.14.1760000808515;
        Thu, 09 Oct 2025 02:06:48 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-639f4109046sm1905755a12.44.2025.10.09.02.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 02:06:47 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 09 Oct 2025 11:06:34 +0200
Subject: [PATCH v2 4/6] arm64: dts: qcom: qcm6490-shift-otter: Enable flash
 LED
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-otter-further-bringup-v2-4-5bb2f4a02cea@fairphone.com>
References: <20251009-otter-further-bringup-v2-0-5bb2f4a02cea@fairphone.com>
In-Reply-To: <20251009-otter-further-bringup-v2-0-5bb2f4a02cea@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Alexander Martinz <amartinz@shiftphones.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760000803; l=1008;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=BxKFS95w1jXy35yaD2QFxAG8rJtE2kDnNaQVe3uTD4Q=;
 b=x8GqfoiMS7G+7JxFND0I9CxgJgnfeDYrwtV0yTVPxM+fe0P/ABKAFPdpoq5tfC+BrT4YAi2KN
 342Gx22/queCZoWhWVrxOWoKW+jIszc37AMo6FCvAgqDofedD+A5pSG
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

From: Casey Connolly <casey.connolly@linaro.org>

Describe the flash LED on this phone.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
index 31650c29b1ca..ac6ed79e57b1 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
@@ -605,6 +605,19 @@ volume_down_default: volume-down-default-state {
 	};
 };
 
+&pm8350c_flash {
+	status = "okay";
+
+	led-0 {
+		function = LED_FUNCTION_FLASH;
+		color = <LED_COLOR_ID_WHITE>;
+		led-sources = <1>, <2>;
+		led-max-microamp = <500000>;
+		flash-max-microamp = <1500000>;
+		flash-max-timeout-us = <1280000>;
+	};
+};
+
 &pmk8350_adc_tm {
 	status = "okay";
 

-- 
2.51.0


