Return-Path: <linux-kernel+bounces-837793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68299BAD320
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299FB3C22A2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDD2307AEE;
	Tue, 30 Sep 2025 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="QDzZKkIb"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54687306489
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759242762; cv=none; b=BN/91UsbaAlfeHM5uc88c8QWzzGoePeVWmxKvZ6W0EQWM0pQrwIzibntnWgqHQ5XuCaCKN8suFqeIgM46nTQ8z1j2vts1Wag4UWtXCQnMPpANmN3SmgZ/Q0+bIsupg+q3uHuXR5nEuAgkCW0FM7U08C3Hok4Nde9yTh09ocSlqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759242762; c=relaxed/simple;
	bh=lvctC9UZ9/7NZkyWnJLbdkf1JYHTsQZ/REX9jctNvl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XNrBtBDA85fhh7ifJifA1hE4vpTOvOTYmyIiHElAIQdQxLfrvaAcACliIY7oCfhH4UuL/hiEgjHsQ+T4xKYixR0ebiTSuNd7CQERAsJhF1WCg0laqxvu6uB5UASW0hRkaircSZeqCUBrPTa/KXEk+1CZ8X85C1vXqhZHnJeMv54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=QDzZKkIb; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b41870fef44so306215466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1759242759; x=1759847559; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPU0fkE7kS9d2V6qsy9O55PBYIoaiLsw1EoR/Hm7yn0=;
        b=QDzZKkIbXRNwEDkrjK9sOfU1fb57i1eVzYmJFEdm+z2elqzxdZG08b/sRo0LOKim4H
         MTlBiw+NGn8R8QjtxX04vCRnNN96iCZQrdtAekMsmSe7NRemCG3QNVfiwjSxpTiYDGrH
         Gg6hgQ5hJ3zVOZusozjXv/26mlnDqXR0igHV4ZfENu5gLld4i5027cbclMdTitf4gIqY
         /jjY5U5BsHj7N6Zh22GlT7YAtaqzs3Nhuw35ddqfHOUxBGzVETrr+fH+IJxO/eNF/77P
         RbfieerpwmlZ4d00Y6TbRvCYqKZ4EWRbpj8zFJW7qsmgQQu/rlG4VvQSNUPc7JRGLQE7
         ADpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759242759; x=1759847559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPU0fkE7kS9d2V6qsy9O55PBYIoaiLsw1EoR/Hm7yn0=;
        b=bMAphjySOUuD0oJ29VQdHdxF498Sdi72X5b5nhcSCOXnLAgWmmlZNCQmpRFPSLOCAr
         q7CLG+AgHlZAYi4nE2EQhp3VidC0bl/fJy+krU7l61NUPeUnItdYrlzE2GwMkjROmOy4
         N68oeq/prOE+cZHyK16n9EfWBfwPiW3SisfiIw35pX8d0fF2nfbVtccnFGp7G/QZydVb
         JUdLQo2hHbwrIy7v05PIXNRubnKs4JiQ3ARGLPJkOlaLDCRu4EppOw19tHsQ+aSWJQoJ
         fzrgCUxRlHj6b8qXjWt6bUgqVkHGZk9WK3RhunKE1alSoQDPvhIxRGoz0V/ui2+QWqwK
         ciuA==
X-Forwarded-Encrypted: i=1; AJvYcCXOWGZNu+ZQj3y+ZQionMmBtLuJLe1STU7qwMSrt79/VE7DqXh2lV3eYPxzqMgin+xKA8JkYPA6gzqfLDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/tP19tv4M+EoN31upD5ftVkcNyICuQjyK3qTorgNIcSTIRNKv
	SHTP9gqQLixVag0rsp2CGJY2uVO9UxUkDzpvGWf9RbXaV13VJj8C2TMFtkIK4vIG8uiW6qGAEpD
	W9AFHVs4=
X-Gm-Gg: ASbGnctpW91fccmJ1zSAtAF8BaSWVbp+cmbA3o7sHqsT4wj+8P2a7TjOfw+0so6eS8V
	hdnUpFZF1aRrRCmYKv3c7T7/NfRRQSJ8rUlmNNpfu7W+g/QYrvc9eQlBi4XYDgqGmjneek9xM40
	9cFyiDNCVZKOQ5L2L5wUfIcRt2OK0ikrZHQgXEpG9iZpB1LXde5S1KIvcSeyCfQL2QO5BlznqLh
	2B0knAxZueQYWLq0B3RY7csb+iTdobkXrPulmJ+4eCb6bk/YRh3FNV755Xc748kvZyJQVmmZVCo
	LOiIN2FUzy7jT1p4+yKJ9nvI2M4fjlfcbEUXbcat9//3MsMbaVGKtO2Jp456kj2UVqONn5L2Chb
	+I6QhK+vgmGIv+qhNH80gtDKMgSjmSLaWOxTugDkemz+kQdBH0o9M0DrG7phu3aZobX8FXMwM4R
	Q7ybCzCGsv2ReVjtaEhHYXZ0OlIZjo
X-Google-Smtp-Source: AGHT+IGT+tcwdtG8+Nk5QcSQLl/1P9H18xoE0BkX5+EFdQ/TDVamP3BKtsWgTbMh3TfkbM0QHAZksg==
X-Received: by 2002:a17:907:1c15:b0:b0a:aa7e:a191 with SMTP id a640c23a62f3a-b34beba9405mr2469612266b.57.1759242758446;
        Tue, 30 Sep 2025 07:32:38 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3dc2cf61dbsm499858466b.29.2025.09.30.07.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 07:32:37 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 30 Sep 2025 16:32:23 +0200
Subject: [PATCH 5/6] arm64: dts: qcom: qcm6490-shift-otter: Enable RGB LED
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-otter-further-bringup-v1-5-7fe66f653900@fairphone.com>
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
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Luca Weiss <luca@lucaweiss.eu>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759242752; l=1112;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=msVLhRVtyqqzcb6CEAQvjXz9Vl2Le/8AL8FbBJzu/UI=;
 b=juPccTJVCdUljWzxuw8dM2AJoUPx5guCgbIJ2bhQkA33KFFP+NMXg+y9PPjFVdfpdX1bCr8Rn
 GjBR8tNb2ggCcjRRV5pNmAntGlg/BQjlIoMqleUHNlEaMY61XHIiFjJ
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

From: Luca Weiss <luca@lucaweiss.eu>

Enable the RGB LED connected to the PM7350C (PM8350C).

Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 27 ++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
index 36cc67469615974c193ea3a9db1b2362869d56bb..b4c69dc50ed0f0b3cb45341a01c89210bd261993 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
@@ -632,6 +632,33 @@ led-0 {
 	};
 };
 
+&pm8350c_pwm {
+	status = "okay";
+
+	multi-led {
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_STATUS;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_RED>;
+		};
+
+		led@2 {
+			reg = <2>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led@3 {
+			reg = <3>;
+			color = <LED_COLOR_ID_BLUE>;
+		};
+	};
+};
+
 &pmk8350_adc_tm {
 	status = "okay";
 

-- 
2.51.0


