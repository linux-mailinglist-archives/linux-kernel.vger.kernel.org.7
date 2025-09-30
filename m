Return-Path: <linux-kernel+bounces-837794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E19FBAD326
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4021940842
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9576A3081D2;
	Tue, 30 Sep 2025 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="phDXBWH7"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78E5306B01
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759242762; cv=none; b=nmc/ApyXOJRAcCV1AfMr65W2yBRhzBaSDM8cltfISGyDRBa2xH6YBEnfZXihpe34sz4ALd41jQUq1pMW/ddb+QOWLkOEeLCDMVVbp80A51Kzzlx21hBfIkvF4ONGKTPUiH1cb26s3t2Rtx4AM3m43lfd3su5ZDWloEUTBxaf9DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759242762; c=relaxed/simple;
	bh=feC/R68VglV9TZu4Nvs7G0duXY4qW44dqlbaCoFX760=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PU62oD5ohu7LmKuCOCQAvA6lzWbUBO03m7JshggRKIcXS0HoYj4idelh4znncVYTkYreBzD7s3XpB4QZUdW+dDIo941PV1LIUi5zqI9ofzNPuknVnysQ8KjtgoNfsdM2Rrz/0mdblBHeS0l8oFgQYCPpdU5363MM6iw69YVJ1mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=phDXBWH7; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b457d93c155so124737266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1759242759; x=1759847559; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1loSnqQxcluwc+xgRCVoTNWJKsc4VIrA6pvLqnr/gM=;
        b=phDXBWH7bR1dE9u7Mn9oozefEu2SZKtu0Oh2kNgnS0llSf8qNgB+Vsj/GREkP8iRZR
         QPgLnfYKNmMHc3aaLfCTObMtuDZfRkJqO22A/pmJ5A4vcIKZy78rwwa8NmKdvrZyB+h8
         ejpQB7CCT2tOxx/Hpj5Hgk8JBzfgM1lQaQtkQyn2pvOaqaFo7wiP/dAjs0AKudx7R/TE
         M+tlTWSr377Sfy+SacFXbuTYh8HfdsBPZVNGTqMw3PTW+AJ1lTFcZwBbjN/TqP5EXKIA
         zQHKkEs8rDGz75C4lAJp/M9D0G1u2Xkxyoz57QZJKGY2AXKbLyohP6hmCatCH3EY5zVA
         r/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759242759; x=1759847559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1loSnqQxcluwc+xgRCVoTNWJKsc4VIrA6pvLqnr/gM=;
        b=UGTdM++/4oit453dgv1UV080uWfEUq+t8ilal/ChESBQ4sRi5PoNfrVSa7GOOEOX8v
         D0geONz4KY1qm1t9yrwa6NWluunYHoNKWgUAg4oOuERY7qwpoI1JntkTsLTpX8D1hvzi
         lr2dfZU06ZuaitO/BXbvWt8mElTHU0y3twgs5XiFse7XdmYEh1jvHaaQfLLTRbdObrtT
         BcxtvKOissbfZGEYEyr7hdVXwayXG6YS9tW1390hOequa+Y4F2zDQ3rnzUrWUYuv+1ZB
         S94KlPo/G11zOhAnhX02GSHuP9uiH7S6eSrw6ww8E23oWjPeV55uei8Hdbyvu3sf9j6H
         j0UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCxeuRI7qnkba0M+EgdtgJ/nBBWzE0Fmo/M4TYl0nf/NU7wr/js7BgaCXeWTWB7rnMz966dM2MGDNxn1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu368YOyiDbe9oVB6VKADi8epadD/Lbp19E+3qufnn0Krye1NK
	S2luCK4pDAKSTXFXyWImvQYrkBJgMmtE9yTKM9trD5PYVBc7or8avH2GyTvkAixj6Ww=
X-Gm-Gg: ASbGnctPancsShGlEDgLApAFCvLEiqqK7k+Y8LK0hE5Pa6p9iRmIsl8UvH6/cjMxd9u
	80iJTAT+EvBo490kntIJRpgHpqP1F0FGcp/ECz/wUrgh1vFl23rY8o250ss89SfJmZK1fPAE7Dx
	2pHSA9VstxuwvZ0jG7eVNW6JJecunv6XbA5MCwxwYCZJkOKPJ5t3U1byPBposFUkHB4/0Vey2UY
	5icY3YuN4DL8PW/tJ6bAnf7DX4ilnlXeKALI/rxDhQAg+5QzJ7rGNiYvixIRxE2DGmSgZzHvgjM
	pGGMXEDPTM7BKWXYQKqxmj9aNdlvZuYD4z+ZxfobV85VtU5gJwoOFYd9URVcNYGp77Xijruqm6y
	ydjLaQrFL/VW565uUdlScKh4CqAZeeem3vaABWYVJ7GRXxHix5DnlEQ/GfoNDZz6Ri6MHqCUz1P
	2eidQdHeR0FQuI4WCtSA==
X-Google-Smtp-Source: AGHT+IEOuIPYt67EBrcFp1mbmXrPmXz8HmqA/6GOaYFUuT7MdE59lwUX8pXH8JAbJY4iOrx/f02phQ==
X-Received: by 2002:a17:907:d8f:b0:b3d:30d8:b885 with SMTP id a640c23a62f3a-b3d30e807e5mr988200366b.9.1759242759200;
        Tue, 30 Sep 2025 07:32:39 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3dc2cf61dbsm499858466b.29.2025.09.30.07.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 07:32:38 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 30 Sep 2025 16:32:24 +0200
Subject: [PATCH 6/6] arm64: dts: qcom: qcm6490-shift-otter: Enable venus
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-otter-further-bringup-v1-6-7fe66f653900@fairphone.com>
References: <20250930-otter-further-bringup-v1-0-7fe66f653900@fairphone.com>
In-Reply-To: <20250930-otter-further-bringup-v1-0-7fe66f653900@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Alexander Martinz <amartinz@shiftphones.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759242752; l=887;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=LSZDqnF8eZZ0YN5ymjZn52HAvKq4JeCAtEqFnPO+yIU=;
 b=T9HjfdM/hf8lvFA8aaNIljFgr/OXK6z7IUWukKa106HmG0hVjrhebnd+Ohi8ezrUz1r/FYTuI
 02o6AxFWchfCQrsUuOLtCvOelyJsPm8O8t8rIfMmzJmEsjLUaEss3t0
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

From: Alexander Martinz <amartinz@shiftphones.com>

Enable the venus node so that the video encoder/decoder will start
working.

Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
index b4c69dc50ed0f0b3cb45341a01c89210bd261993..98c1ad4c21118831f079c83f4fe66ea30c141fac 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
@@ -995,6 +995,12 @@ &usb_dp_qmpphy_out {
 	remote-endpoint = <&pmic_glink_ss_in>;
 };
 
+&venus {
+	firmware-name = "qcom/qcm6490/SHIFT/otter/venus.mbn";
+
+	status = "okay";
+};
+
 &wifi {
 	qcom,calibration-variant = "SHIFTphone_8";
 

-- 
2.51.0


