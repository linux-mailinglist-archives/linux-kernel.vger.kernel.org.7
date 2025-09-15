Return-Path: <linux-kernel+bounces-816569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADDBB5758E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE58317B083
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372DF2FB637;
	Mon, 15 Sep 2025 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QPu3WDvA"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECDF2FB0A8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930794; cv=none; b=H1DLZ8BgBuq5OIZStZKekBf6e8j8OHLRTVMq1YLpmt3zl40AWxVr2aPj9FQdqO8YZYtLyQSK4EK5zWHWk0tWl5b5S6fqJLDMgArLdysYG9x1bOF/ZTjpc/PHVIH/0afj7i9Abn/fys8UjW+yr6dmUYfstn50nTXlq6846XYXWJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930794; c=relaxed/simple;
	bh=CivzybVT6femLa3DyANzOoNr5Zw6tJRLE5//4WZ20nw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JiX+MJYAr9r8wbL+/96cfvKH7eHGpHpwnWjT18JX//uKliR5O2ojfzpnFDtSk+R3et6QUSiOWiCTxBSBQl2EH2HQl753X5zPNxRoGIoHBWbBtw0D+2aHPSY9UhFvnzwhrxlGI+1OdJbRuaQvyYI3pt3UK581eFemMxmr1o2FTTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QPu3WDvA; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3eb0a50a4c3so437690f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757930791; x=1758535591; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFBNEsy8Ttzp7cjciSXICukNb+BZxKqaUl/2TE24rqU=;
        b=QPu3WDvAyaonIJ1Dai7C5GhUEcB7qSipkp8bfRyPt5hFdXmcnfxacnuLafW9w8apev
         USZ8JPGgBV+Gf+9QDBMipYKws92Poe8CNoMXDJ3k8cxXa45fzysJ+Sivo8rP+nYO4kq0
         Eiyh1VkBkJiaRcx/W6Alfd+0Yi73kMFuO+92AVE522lqeiRiN6dRGX2DpX0FELvpcSh5
         0H4VGWz9ZF5r5BwPz9MTljt+KFh0tbAyTSekhGbr1IPhBHyvPD4xLrkCqxYCo5OGclg7
         JBzOutpLewApmB7wbvBsmDm+7XcF0nN7XH18jxNIhFa3Te7LWZTE0LONqCqLqP6YG6M0
         ypxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757930791; x=1758535591;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFBNEsy8Ttzp7cjciSXICukNb+BZxKqaUl/2TE24rqU=;
        b=TevAVeHk0lk2sy+UGEpxhAMpEeEhSkQLVdIx9hR/d7Kd2KPP+Pu0SM66LZXCkqih7q
         RMEk7MFSXM+hpbsk9jwpHrxD7PmFMB1EuAP3CUuLlfaqMAic8yfACFlV4N+LkRqIu8OF
         4u/EiOSCvMgtyfWPrno7ZJBLriHT45Is8WbQkGzrIDZPYPwImBVAiywHnJzYAjgJ1gr0
         9iarMHujlHEP+MdtKZfGGDV2dn70pLZXm51a6UaK3O8Ut9V9MZl12taM4AqDW7CBtM/g
         sDaKlTJPEd1/zmJGQ9AEV4Ciax/1so134kAkej+a16GA8Q7ou/fS1sHCy3VazVwllzoZ
         R8Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXMbSs+/9IRwmhhQYnVKhrQ24O1MlL2ezKTGgQgRobdWyjMdalj+wzYagyYZ+SfpQk3pb7+oPOKbwPt4QM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl4+LiUEFqN79JuwvVsUmf6eNz/ZMtw5nPpb3myQ5Ib3InUg2L
	+IVCxhMq6tgzLxD+FTuW96+z1kXcRbjpgPWw/n8USB7mDXq/llsaTVCsVxXLJz+XPh0=
X-Gm-Gg: ASbGncv5Grt7XheC1j1gxegcCloVPs9Xbw4HdIadmPsJf2L9zHu2c+6mG7T9Vn01F6i
	IJSWOkOu706OC6HbRqbxNb4MLzOKI9giZ0k8uhN4BniwPqnQQZvAYv3tVBcSLyGAIT5b+D2NnD6
	pkGBo/P/zFAE2JZmQUI/Cyk0mMC87cIY9w/FJdeyeBbNM7YjoJenEljea+1ckh63giXTruNXG1X
	L3bCxbYdITdIOTH2nwkcOEFHvqb4lUM8gpsrMwqgd9XXBAqW/AOr1DlJAQxJHajSnjTMdvOMrPS
	yHH2FJ4fY6SyXYtXvbbv62nQjGRrelvxe7pWqeAQBJRZLIE+tOElP4uSytXti9d6YnBDUEq6vip
	cGoTcgO7/GH42khCDjcPgFJ3xliAt+ZnOadXjOFc0XpEF+w==
X-Google-Smtp-Source: AGHT+IHN9nN/WsNaVjDToDQ9YspQkvCA8d89vfCeKt3nRTtRQEdxmZtJnxV46PeT+eqbRJvfHa+ngw==
X-Received: by 2002:a05:6000:4024:b0:3eb:5ff:cb38 with SMTP id ffacd0b85a97d-3eb05ffd028mr1770106f8f.20.1757930790847;
        Mon, 15 Sep 2025 03:06:30 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:41:eee1:5042:e713:2e9a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd4cdsm17209127f8f.37.2025.09.15.03.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:06:30 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 15 Sep 2025 12:06:15 +0200
Subject: [PATCH v2 4/9] arm64: dts: qcom: x1e80100-crd: Enable IRIS video
 codec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-x1e-iris-dt-v2-4-1f928de08fd4@linaro.org>
References: <20250915-x1e-iris-dt-v2-0-1f928de08fd4@linaro.org>
In-Reply-To: <20250915-x1e-iris-dt-v2-0-1f928de08fd4@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Klimov <alexey.klimov@linaro.org>, 
 Anthony Ruhier <aruhier@mailbox.org>, 
 Stefan Schmidt <stefan.schmidt@linaro.org>
X-Mailer: b4 0.14.2

IRIS firmware for x1e80100-crd is already upstream in linux-firmware in the
default path, so enable IRIS for the CRD to accelerate video decoding.

It looks like the X1P CRD might need a different IRIS firmware (possibly
even changes in the Linux kernel driver), so keep it local to the X1E CRD
for now.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index 976b8e44b5763b2d6c0f4786bf5809fee29dcecc..dfc378e1a056a8af27ef4b646f7589e7198dbaf8 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -16,3 +16,7 @@ / {
 &gpu_zap_shader {
 	firmware-name = "qcom/x1e80100/gen70500_zap.mbn";
 };
+
+&iris {
+	status = "okay";
+};

-- 
2.50.1


