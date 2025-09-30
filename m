Return-Path: <linux-kernel+bounces-837278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AB7BABD95
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1437189E7E9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B97E288C12;
	Tue, 30 Sep 2025 07:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="SbtzrdM6"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC30220F34
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759217856; cv=none; b=eAE5QawI2sBwwPC/vX1XgAF5Cn/QOy3X+3DoTs25d5JApFi15vpVA8UBusA/RZVt2n37Z2EfqEMV422GMxWVfccdIQv5wppuh5joNhgQVvefV7Vizg4+N+MNjYbTdRF2gcJmdhouTiZyiNngAMra8mrMIHWa6x7p/QY9CYApogA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759217856; c=relaxed/simple;
	bh=ENGheAYnNW3g5COpjG03gMGNXlOZ2EcAFRzlHVSA5ng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UORBTHRVRtaZB0lLCxx3Eg1+DIxFP5VxZKNl5l6R++VW6e07A0CobEPW1eJIcrOjTVg+5qllJowRt+LertMS1Jaa89Ba7L8mVVyOgpWAjtGOgN2OsK5DlCS9iPCPO+RXlZ97pj3gKZwY7wO+U2KGqAJLovVz4suhzXE8jv0kGE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=SbtzrdM6; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b0418f6fc27so797985866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1759217852; x=1759822652; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1iApKO+F77Gmy+nvt9OQEdz8JuAQZPIJ8wB7y7Z7dgA=;
        b=SbtzrdM6fadj02L8XwAIEAp0QjVDZw8ef9lOJrgovoXOie9eIB8/j7TRtnhsDPkqZs
         pGrqUeY5dX8X2rf3edVDV5tR0k9hO0u+3wNmzF/Cm8xXvHECc5kCInRmuN6iy1NUswfy
         CpUrXNS4cYGsq8D/JBBbDKy8xZv3ujAdYoXSbvZxPeQTIOINyIQgvlrAqyTq0QE/3N3G
         qiI0RVmKrJgz0kafr1YVBF5CDYyyjTwWcZLCW12xELbbUDGTGskGa3Wy9poLCgmSj/FB
         h+kJtv3POt2SusRmn9qSZTDkcb2Ij8/Zw+DsRl3djiFaZ5W2wiaCEiimFkNVhZsdGOeu
         owYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759217852; x=1759822652;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1iApKO+F77Gmy+nvt9OQEdz8JuAQZPIJ8wB7y7Z7dgA=;
        b=hkGDGQCdHHY6s5ecPls4At0tcQTSz+p7i/OjoJK6YMy1rYFmsB5iBusHc6rngEp+gq
         XKwKLCQVlS9BOeSXpyup2ZPALiFa9ygQ1MvDu2zpzfyHa4dh7JZWU4AGJtbDwkIS7JJ2
         yp3CTnpuiyuC2dEazZHRXsE9xGTY2dIVyUp598Rqo38BZnt2hljdnXShkQlcNegqLCjO
         94iU7yKMbvLIDjOSWQp+e29HUgDQwjAfSNEsvquYXDC2clzKLQUaJjjT+97E5aC+FEK4
         nFiGVFzhx2HK9+RhqSq4jEtZ6QfeObWgUZGzC8BmmOdJPb46Q8h/t1IgYD4o/pL7BnvA
         PIew==
X-Forwarded-Encrypted: i=1; AJvYcCUwLVw9vfwA6cPTR0fLV/nk7g82TBbwny/tnlO0KlVYQpGnV/4hHM6lK1aIbZNiBC+v4f+0Uao2UJY5QKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk89090iCb+Vdd2H5JjOsWyerxReqAgWEJHlKYNFh/Rmy5P9W7
	PKKXGc7aSuwQOdETtWCL8nXAQPcuqae9sGP1AFwGNshmFEcJjOQkN+gmMACRBBJaP5a21OTa+49
	jJuX1jow=
X-Gm-Gg: ASbGncsn26kvOtIS0cxrUgVwhOOFgTN4Obi/oFkNuhW6WNZ0jR6RPfdZyRSIpKLLKDb
	2V7kgOkIMibux84xyD6KqB40hRXq6HkCZS0O1SDwIYhkIJTIq3YeR4xFopRCTqbRZCHbxUpO40R
	2E6BurJFYxVjrFH2YoUmNwELyJ89U/Zjw8kvaqNJURFNFUN3tkOxZSEiSTpcsYR/Ju7QJXHdPx/
	3WS2Hb1L5pisaTQObsYYlr2nWB5tWhNyHtVAlLtP1U1PI+WKQdVp1oIwAtlS6ZM3oZCPnMiUgy0
	EXT+o0w30OCIcAb5X+8d6WqYb5zpA9V+VA+7xSX93M4kjzDSyhqSVFyRdDcmkmC3I42d8ZW6idM
	Io7YWGH5RS8FttY5mfb0Rxph9RDdy31nWH+DSQoQgpKamGUG7housi442GoCyqrKMXaEpx7RxH9
	8VT5x/N7jnH3omdIKIgQ==
X-Google-Smtp-Source: AGHT+IG9j4qCfb+pWcKxOWPLNAWJqVlW5gBDMAQjRf28CzIk+BsQWovz6lYnrw00odazuAg1RoDJ+A==
X-Received: by 2002:a17:907:3c8c:b0:b09:c230:12dc with SMTP id a640c23a62f3a-b34b7209e46mr2054121866b.8.1759217851585;
        Tue, 30 Sep 2025 00:37:31 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353efa46b2sm1084376866b.24.2025.09.30.00.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:37:31 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 30 Sep 2025 09:37:22 +0200
Subject: [PATCH RFT] arm64: dts: qcom: sm8250: Add MDSS_CORE reset to mdss
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-sm8250-mdss-reset-v1-1-a64522d91f12@fairphone.com>
X-B4-Tracking: v=1; b=H4sIALGI22gC/x2MSQqAMAwAvyI5G4gt4vIAHyDexIPYqDm40IgIx
 b9bvM0cZgIoe2GFOgng+RaVY4+SpQlM67gvjOKigyGTU2UJdSsj4eZU0bPyhZaKyXJlMkcWYnd
 6nuX5nz20TQfD+36Jp6K+aAAAAA==
X-Change-ID: 20250930-sm8250-mdss-reset-307c3e921d03
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759217851; l=1086;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=ENGheAYnNW3g5COpjG03gMGNXlOZ2EcAFRzlHVSA5ng=;
 b=J1uq8r0DaAiTXMXmOmZSb+gbE0/AQqQXkde/No4Im5tvKyezccWDZwJHxiAQnh5r8fiI9uUYS
 R9BxHaVroVOCzWJst1RVXSv5OAglNbGU9CNARiExyL0gF6lWU3pNxXB
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Like on other platforms, if the OS does not support recovering the state
left by the bootloader it needs access to MDSS_CORE, so that it can
clear the MDSS configuration. Add a reference to the relevant reset.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Not tested on a device, but should be necessary on v6.17 kernel.
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index b30aea8b05409094837ad494389d7c22fa1ba7dd..9bcb2c4c34388f343fb93083977b8d2e9a724bb3 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4687,6 +4687,8 @@ mdss: display-subsystem@ae00000 {
 
 			iommus = <&apps_smmu 0x820 0x402>;
 
+			resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
+
 			status = "disabled";
 
 			#address-cells = <2>;

---
base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
change-id: 20250930-sm8250-mdss-reset-307c3e921d03

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


