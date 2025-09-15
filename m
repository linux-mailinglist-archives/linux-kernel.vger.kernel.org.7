Return-Path: <linux-kernel+bounces-816574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F76B5759A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D35C178CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22EF2FB0BA;
	Mon, 15 Sep 2025 10:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Owojt/Em"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032F92FB991
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930799; cv=none; b=pxhtKqSoEA0ZfhNhzjiVOqL+OKEDnz7xP3LeyzoxdIIqNm061fIMyli88V13ol9+G8RttYf68FZ9pWRDEyCnNQ5rzWCXk6vvMkaRkVTlRDTx/ZJDmg8x5N36p2vMJzFQ0mtq2H0E93Ly7+quePVm6Pf0kdYzMkQRBwKj4La9cOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930799; c=relaxed/simple;
	bh=ydOKT1/PJG94gTRDvCWS3LKFYBuI9gTVeaXJDFPVqx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MLDbjf4Xwle8GccH9oOQ702dgzO9K8etpTr9vqOSY2TLZxz2INiMb/IG+KGGynSJ6NJ48/l9YSBKFWDv8UNMawvkxpmo//DbOXRciWyA5RjCoy23IKFne7fpYddRChP2YvelM2NGXffvqzj0rdI1bnGfuuzoJADjGPvX5KdwHTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Owojt/Em; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so37769595e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757930793; x=1758535593; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOQbP+sOwhZlxt+ueHzX2J9z+zGJpRh33jkk4ePQOak=;
        b=Owojt/EmvXTER6bu/Ei9ZDB++JkWzlR0T8f8wYV8/T7+wB3Na3aFf40/YTUvvMqiYz
         MuExCgnm9FcBD6vILVf6erC13Pm7Qo4K7m2NEQHFTRxnAzxqvP2QKQkz1PWy2YaIK9Qz
         L+DSq88FoCg4RHlQLhD7QhsEfpTXJRnqEtWsQKgFrQZPj8EdhDNvuLpcl7v9K34EK6hV
         eNxSBnxsA6eU1ry3TGhSaFb3uZckX/ltmlTd7TncJRI2vxI8TyiLbHP3cZ04qBy3u6+w
         xv6IjB+0sWTp4c2Ev3bPMNxNvd+zvMuIgKXkK83g678psNZ1BB9w90KCKXbysGZ1dhOT
         PKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757930793; x=1758535593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOQbP+sOwhZlxt+ueHzX2J9z+zGJpRh33jkk4ePQOak=;
        b=kkxgvUeFzPTvOT8VLNwXTUxCGoDA17pFMRGv3RD5yOj/fScfDu88EAKfW/2h2pKgMB
         eS+TyCdLXA2QTi7iyJstMuIejjOb3NkhvHaYKjsMgGO0f4qwxosZpSamffFdt7z5Pzbc
         d+OETz603EHfgf4r/fZfMdIaxrp0nzODmHh1BxiZPTQnMiCtDGySs+FAa34UeNC5XsZO
         Zk/321OBr7zhPOWhC3Ikh7kEcHbp1oqNAYr04EXSYRR/W8hmQp2HfdO6Y4FkE2IgJp1F
         SelyBPVXO5+MzOElcRfxfUaIpY4k+ImoadF/UtXxMoLq9ZINyPWDp6s/cmxXo/hQabAZ
         xVBg==
X-Forwarded-Encrypted: i=1; AJvYcCXjn4B2zuclJhfYDpsNCGFlEpJtBlGdQPabxrkyQX4+eu4JhpLC6g7jKzxSnxSd9PtMr42k6SMXZHrv5S0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuP0XcLjEbC/jFWnewha5Z8miwhLz1zAc6aTWJ89S4/aKGI+9e
	5qf3OM2iDyseUrzMwngXQXj5vWBLaNf0wJmzn1WNyD9x0dwU/YXYCpr1uFztvGuTOlU=
X-Gm-Gg: ASbGncupMLYfbcsU8+mgyvi9MaJ4SFnnED5NMaqhAD4NMBauhoEJ4OGQiZ+Lcycbbkk
	YA+MAhi8uOcJRaVRw8XSAKpGeNDp4BMaTAWn4bnWgs+4kYxF1U3WdNiznKdh21KQQ+ODaHAE8mg
	AvlnfK8D3maPGMykCyFHwz8DCGULEjve0OziGYMMU39V6TrkyNzLbz1Hlilw3FIaa1eu0DcdiTR
	Gx5FMByvRLVsDjX8ZaTXjoDmKOeKpophn20rz/WNYCnz4PiD0F4YvWgq9bxH/rroRH6vgyCwFFa
	zDRL+wHY6fE0o2USIBUreiFUfB25NAu7UhU9gd0DqUjgQ7T7aalT6Lla37qNDlx79Zdh+ab3OIg
	Lv8kVjJ6z2spFVFr9NuwiPR+gfcV7O/H1nxk=
X-Google-Smtp-Source: AGHT+IEzxwtBmYCgbr0PgRIMPx7tGP8Ho6F6LYO4VA23DeY9gbeUHKdAFtYC67Zh77DHAR5Lzon3tw==
X-Received: by 2002:a5d:5f90:0:b0:3e9:d9bd:5043 with SMTP id ffacd0b85a97d-3e9d9bd5644mr3381016f8f.0.1757930792874;
        Mon, 15 Sep 2025 03:06:32 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:41:eee1:5042:e713:2e9a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd4cdsm17209127f8f.37.2025.09.15.03.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:06:32 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 15 Sep 2025 12:06:17 +0200
Subject: [PATCH v2 6/9] arm64: dts: qcom: x1e80100-lenovo-yoga-slim7x:
 Enable IRIS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-x1e-iris-dt-v2-6-1f928de08fd4@linaro.org>
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

IRIS firmware for the Lenovo Yoga Slim 7x is already upstream in
linux-firmware at qcom/x1e80100/LENOVO/83ED/qcvss8380.mbn, so enable IRIS
for the Slim 7x with the corresponding firmware-name property.

Tested-by: Anthony Ruhier <aruhier@mailbox.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
index dae616cd93bdf54bf2d3a3d4d0848e7289a78845..e0642fe8343f6818e1e10656a1d8fec8fb09e7e2 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
@@ -1026,6 +1026,11 @@ touchscreen@14 {
 	};
 };
 
+&iris {
+	firmware-name = "qcom/x1e80100/LENOVO/83ED/qcvss8380.mbn";
+	status = "okay";
+};
+
 &lpass_tlmm {
 	spkr_01_sd_n_active: spkr-01-sd-n-active-state {
 		pins = "gpio12";

-- 
2.50.1


