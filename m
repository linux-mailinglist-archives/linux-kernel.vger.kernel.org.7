Return-Path: <linux-kernel+bounces-837791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71E2BAD311
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66BE83C46AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52D01D63D8;
	Tue, 30 Sep 2025 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="ofl5p9HW"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2338B303C8A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759242759; cv=none; b=Pz56j79rmcMcHn/SLHMPfrTS7CTkwF4ZaZle0ZNc2STowemrj1jezSMf6RA3JvvfmaVcDP21SRjjnjHfaKNeV2ob+3/vkBEcDbCNaXUnmB9neqhttv/dv///Rk/82ghzgdOYzPRK4PI3wfSABjqFBbkHiug1R4B6YiZW0MnJXgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759242759; c=relaxed/simple;
	bh=6XDKwZQKKm/HcS7Zce2mlrECQKgBdlxp14xSsBBMKeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SpW8q/0HIFUbLDOKQ1aJ/CITfTfmYrfMEF5UdKswwmbu3pWWCAar1iwuypP2Im6DDcZ1zWeRpw4wGPnhrPCt6+1hN0rizYklCggal2mD0V8l+W5HquPTOWw4a1Dscd39RGSyvFAg73Qa3J89bZ+XwhrQ+l7UFuPH9yf7RXC4Z+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=ofl5p9HW; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3e25a4bfd5so481349666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1759242756; x=1759847556; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KpqDsPljIbI1ydAAYbBHpL4t7hGd6BLoLJu9kFhmW2I=;
        b=ofl5p9HWVxP6mVHwljTBWJBRTcn6XoAS+z4rAO+OceyTP+aRnPEoqGdjtqo5Qn2S+q
         IYBtkgFY1xwtQpg8nWEAZoXVYCzkjEzFHNR39U+LjqTHdFQv5ww1VAldJpMnlnCtczdF
         CZEvDL/qcQVblV7ySz4fVUv/RodROa1Hw3fyl29ZoowKPm2Zhgny0ODymrs/WWlvmY9G
         +37nc5r++8OIjqmlO1TsGvvIs33hoAbqySVG0XdzsShkPjTIc/no3iFGdZYBXvEb5s5K
         eL7oQEsPAvUNqw070L+YefsfsKr4Byx1l+XI77TR3Ew3WVcVSuKP/wiDaupnu5Y09/n8
         w/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759242756; x=1759847556;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpqDsPljIbI1ydAAYbBHpL4t7hGd6BLoLJu9kFhmW2I=;
        b=vJ4l5SGJVZauga1YW8B+3AJd80wa9XfNlTx1AxOW+c7OHAf0Zwq00PqCFFvncFsQes
         VNuLdZyna1p07R3EaEukHdsDX026u60SDYmK57sRSXxeKXsxRKsz/O2xXyDRCdEtOeyy
         qOyi+WmzKpRbq7wh3ug+FSgcpXS29Ab7kbFtyrNm2iNRUpUmOI9pHD94/D+KN+QCqi7B
         Kew2ep018iMcILSeDrPKYVPEY+kCtKLjyMP1lmzPcFSeJEy3wheOGHUSzbixxbhGfQCQ
         O/aswzOB7Go3qOn8RSmqM9JdQHI+Dvbmy4ygaqnMAO/2DpsJQSXD5ZnZIxBO9ISIDF20
         qS8w==
X-Forwarded-Encrypted: i=1; AJvYcCUskx19U6KheGA50q0WS77vyI/1PegmpoLW+wdr2ISSWXbXhSeoK5IL1xrR3/AMej3sVwnE6UBRyXpQIvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ChHvJA56YQ+O11fT1CS/vhJ8ih1Iz4BxB39nDrXIe7Ad/Z2X
	b478O+y9hfgo0hXLiz/cqXKKz2DS8WMPAFBliSCXIPCOLEZHRxoq+0ZQT2EJpMndg8k=
X-Gm-Gg: ASbGncsYYkOdxjUvQqZJ77tV5uM2XFdJE5LGjcisRLnG0etHVpHpxEuwcr5huzaOfpn
	lPizHtXK2MFKk8TXF+r/I9E+/2HuW3P+wGDQ5+dyjSCwPwVRLWbfyCokOeqOkNvJrWLM4sm2ah2
	sSlrBARzSwg4YbBFR37CZsVeg0RbrUxrKmtWpXHEOuDVDzstNp2Mb/jYXaNvQidKUeJLKa1mmEd
	Dc1eobftbX1Az5aVZv1lLus8IXmfmOehXGBIN+SV2Ao1chDmvDhu+rIFfY9TKp/j1P/jVdw7RCf
	Ws1qf+bb3cI6Wuidkq2YXABBMZhu/lVSsPgXzKrP07hyvsZIWsS1/m8DUI9if/PBuiaWtlLq32C
	fPSgKeBC2lIXvxGE0X+QU9s5P5HBE1RQvMnbBybFe8iTDLXoBtswxH5/P2DjAl6O5dxSw1UhxBW
	PzZB+/flCiJzKsAo7Jnw==
X-Google-Smtp-Source: AGHT+IFyvbxwgP3khFMfvK8Z3FvV7VS3kFyp8CZVMqy6iYYE4fRT64Yn3WmDZTXMdlLdYOJtArGTow==
X-Received: by 2002:a17:906:c349:b0:b41:822c:ce76 with SMTP id a640c23a62f3a-b41822d0d02mr385052766b.14.1759242756474;
        Tue, 30 Sep 2025 07:32:36 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3dc2cf61dbsm499858466b.29.2025.09.30.07.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 07:32:35 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 30 Sep 2025 16:32:21 +0200
Subject: [PATCH 3/6] arm64: dts: qcom: qcm6490-shift-otter: Add missing
 reserved-memory
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-otter-further-bringup-v1-3-7fe66f653900@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759242752; l=1048;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=4H+1X8ibBwQxx6F2/tlczJd/Zh53oYpIpneYTVnsrY4=;
 b=MkEj4fc1gplW3XRkFyG+YTnbELDyh++lWP1rydH0MJ5KRTho9D8HyWL4lHZBs9ii40y7yz1h/
 I0/PtM4t3HBAl9nJXXzVR7cZtfEEkrukBKYGAJP4Of2svukfI89BmB2
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

From: Alexander Martinz <amartinz@shiftphones.com>

It seems we also need to reserve a region of 81 MiB called "removed_mem"
otherwise we can easily hit memory errors with higher RAM usage.

Fixes: 249666e34c24 ("arm64: dts: qcom: add QCM6490 SHIFTphone 8")
Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
index 2efcfb631c3683456794b0a0cc5686f00efd329c..ce794ca724db6deb39f7fae47912c3fefe974573 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
@@ -118,6 +118,11 @@ cdsp_mem: cdsp@88f00000 {
 			no-map;
 		};
 
+		removed_mem: removed@c0000000 {
+			reg = <0x0 0xc0000000 0x0 0x5100000>;
+			no-map;
+		};
+
 		rmtfs_mem: rmtfs@f8500000 {
 			compatible = "qcom,rmtfs-mem";
 			reg = <0x0 0xf8500000 0x0 0x600000>;

-- 
2.51.0


