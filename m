Return-Path: <linux-kernel+bounces-837790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7412BBAD306
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2401132232F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEFC30507F;
	Tue, 30 Sep 2025 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="ggRZ0me5"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD7925FA2C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759242759; cv=none; b=ICSoOZ5sEh+JmVW1XJLLfwp1nVzI8bxAYGcE5A8uGrxcbBRuMqvToNIvE57ONrSIZKO8Tw1zU3gdv8rBGiJz9MZ+xgrszPIPVGm360OtTZXewjNBHav0+fm/VDMphjOi2rM1znocZuw2I89tzREW0ZuQsvr8o7VfZL1DcsA7Z1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759242759; c=relaxed/simple;
	bh=+LFiRy3Z1LxfRQYxjXUFDS9xzpk3P5GtXoUbQtbfGYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kqlAaG4TdjT2EHFYcQN8NBja7MzaT80P67gszkSpi73xcC9mNBs2vaAbREThs1OudlBgC/Uo6k+hW4W6XXXAmJUf2F3B754u1QJa5U/ISOYAIfFrYjm6iuoDcnmLVwNWfccEssy7FGzfnyP/tEetOE4yNbnTmrvfLtJvXp60gHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=ggRZ0me5; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so571327866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1759242755; x=1759847555; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5x8EyhLaWWj+c8MV0HkR8SIUiKQa6BIuaXkJKptBZg=;
        b=ggRZ0me5vvAsk5Mo4yS+qlqFfvMsIMTAwjLnUT1fuDJMHwCzC+X2H4y1/HDPACkE2I
         4RMSkMv7UsSaPWHEDawg3u/h6z3w+0E289S54MZVSMAUkc7crjI0XtNOSPXMfTGeTmc2
         PYEMn16fGUC34k+H9I+JjdPZdYB4mKJCjK15tYJrm4SrA2LGVzwBqu1alnCoC60m59v6
         QjYSUrSczfY+AX01RZeOs8s7YZ0DCMd0ymmONtRtiPs/UFnSBpgmVifuYTJLNcJgG8WH
         yfduAXUD+SciNRlrd06RGokTh0h07Sva0fl9rTuIPZdRbQArOqHMxN3YFGtn2lbMOGyT
         55PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759242755; x=1759847555;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5x8EyhLaWWj+c8MV0HkR8SIUiKQa6BIuaXkJKptBZg=;
        b=dHQ5KAzWP6bFQSUGz/bV+ilI+DxxQI0H2TgSE79I3OaS8A3+mSKyybv7CnsTLfzg7X
         Gd3ceSj4+1k2GuAGfEpOJFMiH7FU56NSXpOE3zDGfXtUu/2/KssReKwHpKUlNq57n2eB
         d79hmy74cjG3r9Pxc2X0oWR7JTL1D340RDYrbe2p5AJCzTr6jytN1ADCeqV5+lDLTQg8
         tXuZtzW16c6rWRJ2U7OWL206WslZpyzG5WjrqYHTI81Hy7Y0gAdLTLv4q6wA4/KNlwou
         qsQPI6g+bUJ70TWnVbv+h+TJBI7dLlPwD1+Yl+vEmA93PcAq1D2OSf60J63jGgTaw92N
         +HvA==
X-Forwarded-Encrypted: i=1; AJvYcCVbC+ApKTO95i8ZE3Gt7pApbRLPKad3Cm05GjEyQNYz09th+yPMHw55WUrFR8gZ0DKC2pcZr37g5ozNRbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+p1qJC0L/n9g5ZidASkQs62XMaa3ifkg5GjUWqQes7JdAqEG+
	QkNi7nuIx74l0YRpxSzznnO5tn1j1B6eBa7ZehA/7LPslkTi+Vw0YX/6HtVF1Xr6QbA=
X-Gm-Gg: ASbGncv5N0e2btmxA5A6vXqU1/s0YQt8XddMnXquqG5LLY14/eotfD0nIOS7BZwKbi0
	8iHvSefUIZq+FA7f5IPKLOZrK8rh2uAvmWADrea3Lb2JRpoqShHJbDFBdS6kWkqZi9wavYG5u2U
	8SIJb0txI80/O+Dtv73VjnFvrDmsCAmZ3Z0k2EEoVWAOJLaP2wYqXoR+bVotIWNQlJIgypgXNN7
	eD6p2vVPnL5D5Tx/oE5NTgq3wn/PZ/0YYIHWhoMkFqpuU0wdtJQ7iA9b7ZyMhe17AQaeOPeG7bO
	ad5G4pfSkMYfJuhI6MVc2+Jr2u/m1J/Vf6rDORWmB/qek3E2H8icXT4yKhv+1BBXFZf++IedqsR
	Fr/LvmJtM0DwD6wDOOiNL1Ci/zcS/w+2atHIE8fnwYQsJJcWXmbi4zzYLaweYM6n18ym+/cIDfs
	Iv4SGQRYGe+WgiHFwumaQCEu+a/8gA
X-Google-Smtp-Source: AGHT+IEDUJRM0GN5W5q15/tGP2wBwyGlX0yymXPHCIRCaXyEjbXUNd83PMCVK5ptl+ENOKcbxttmzw==
X-Received: by 2002:a17:906:478f:b0:b46:3a39:3ad5 with SMTP id a640c23a62f3a-b463a3951aamr135599766b.9.1759242755483;
        Tue, 30 Sep 2025 07:32:35 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3dc2cf61dbsm499858466b.29.2025.09.30.07.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 07:32:34 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 30 Sep 2025 16:32:20 +0200
Subject: [PATCH 2/6] arm64: dts: qcom: qcm6490-shift-otter: Remove thermal
 zone polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-otter-further-bringup-v1-2-7fe66f653900@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759242752; l=2062;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=2qIN8MfH9qi0zQH2HVOb0uwrinuQsozaHPS9vO6qYb8=;
 b=AbjQrk2iX1Feii3SrCw0VNGiNG0q2XCedBBBM+eKVS5/5P6KL+5yniSzPjM0G+Wt9pkyeHbzs
 oSgU2cuX5g+BVbHsQWu/zHaXqVN5+pkRgw2XrtjN6TIdZlIedtGIckX
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

From: Alexander Martinz <amartinz@shiftphones.com>

As with all other devices in commit 7747a49db7e5 ("arm64: dts: qcom:
sc7280-*: Remove thermal zone polling delays"), apply the same change to
this device.

Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
index 8d45e6ac0e445b9e20bb9c1520f804623c505653..2efcfb631c3683456794b0a0cc5686f00efd329c 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
@@ -131,7 +131,7 @@ rmtfs_mem: rmtfs@f8500000 {
 	thermal-zones {
 		camera-thermal {
 			polling-delay-passive = <0>;
-			polling-delay = <0>;
+
 			thermal-sensors = <&pmk8350_adc_tm 2>;
 
 			trips {
@@ -145,7 +145,7 @@ active-config0 {
 
 		chg-skin-thermal {
 			polling-delay-passive = <0>;
-			polling-delay = <0>;
+
 			thermal-sensors = <&pm7250b_adc_tm 0>;
 
 			trips {
@@ -159,7 +159,7 @@ active-config0 {
 
 		conn-thermal {
 			polling-delay-passive = <0>;
-			polling-delay = <0>;
+
 			thermal-sensors = <&pm7250b_adc_tm 1>;
 
 			trips {
@@ -173,7 +173,7 @@ active-config0 {
 
 		quiet-thermal {
 			polling-delay-passive = <0>;
-			polling-delay = <0>;
+
 			thermal-sensors = <&pmk8350_adc_tm 1>;
 
 			trips {
@@ -187,7 +187,7 @@ active-config0 {
 
 		rear-cam-thermal {
 			polling-delay-passive = <0>;
-			polling-delay = <0>;
+
 			thermal-sensors = <&pmk8350_adc_tm 4>;
 
 			trips {
@@ -201,7 +201,7 @@ active-config0 {
 
 		sdm-skin-thermal {
 			polling-delay-passive = <0>;
-			polling-delay = <0>;
+
 			thermal-sensors = <&pmk8350_adc_tm 3>;
 
 			trips {
@@ -215,7 +215,7 @@ active-config0 {
 
 		xo-thermal {
 			polling-delay-passive = <0>;
-			polling-delay = <0>;
+
 			thermal-sensors = <&pmk8350_adc_tm 0>;
 
 			trips {

-- 
2.51.0


