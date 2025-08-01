Return-Path: <linux-kernel+bounces-753417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0C3B182A2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8601C82314
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F9B25B687;
	Fri,  1 Aug 2025 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="c1QhIUfE"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D489A20F098
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754055671; cv=none; b=RFfeOwYYD7XH8wLwx4K08YmXvGua/QWcXx/cyD+d2nAFuZtAXlX6Ut5mUn8mcUW7DQfwpVD4MqrpYR9QilG/GNVyV/Ujf6Atk0arbxkgHFtSBwpMU1U9TSm2wv12svOXjjgGcGWG3t5qvqSoyALdoK5Pwks49nwdh5HUk3BwDTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754055671; c=relaxed/simple;
	bh=r1c9l1OijXU/QDDLBcy3ZcjwcgLrgltP3dZGJovejCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V94M9MSRVBgSuEpFpkxFRnxXdRkoOH0Tsk3fBrPGzXvXuneMu1wYDEfQmIbaIFXrtOutjdUso4cIRNDCyasCV9s9isurwCkRCIJ7AGicO1HoYb0Y5bboRsiK3bnw00HsrUxKwZ/9+wZYGR2igntKu2mwmIl2L0vO+J4X36Byba8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=c1QhIUfE; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so306092466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 06:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1754055668; x=1754660468; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fco+a29BOB9mtDgoYWIpNOSq5S/ZGt3leEcvdoqeQzk=;
        b=c1QhIUfEhKHVK78f5nQ65L9bdCehwMZ8HpANGaiIOHFhfH+FnzYXydJOQ582aW4808
         fwk37JMyBD0J5wHdT0QrVNjnHwVTbfXyn0SGDMp5tCQSo96SkmsebKC36DfYVIn4KQPO
         FIo2k3ebwEu9RFU23L1qePLbbCemm0FiLS2an5eCqZgQn8A0Z9nb9t3lVOSv2BQcwH0j
         JmKULiwRKDbjPHYb0XtFtW7st4mRzPAt+QCf/2oeONytaWYv3xwd/E9BXvMxKARVPdR5
         U87ftPBiuUTVajJrbys9sb7iwohFsPGbmqwXHOSjFBMEnGU9guR8nXMi1K64mHMViJc/
         yNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754055668; x=1754660468;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fco+a29BOB9mtDgoYWIpNOSq5S/ZGt3leEcvdoqeQzk=;
        b=LeSBqY4p0j20bWtjk/ZdkHmzyL+sERk51Fm1DHULcwJfBFKvIzdWYlhuOmUmyWuhtf
         gqnYFguS1xjxiyIRlncAXfF13LI38Igyclbee8pv9kGySLq1/oeDc+UrkCJgZVAan2TV
         H71nnCaKj2Pv8fdVk2B9T+/6xzDGuNRcfyennn1rB9LRAAs6NYGTrtflx3I4cVMJZfRF
         G3byNLtxLRS6JqUzF9f8b4Nmp1SSe32O8WkIRFgw2cJ+w3e3GwoHxcY8nUa0h+pRzVSB
         ePd+yVxKre+aEXU0bG4bLhBpDAV7hplC5+1WAcZI8IQw7Q0JLwq9Y0+Ag0e2m+LFCXLp
         HCSA==
X-Forwarded-Encrypted: i=1; AJvYcCUoM7Lr4sqapsV7M+wNHwETT1HRjr8cWH2vRbWkVLfaSlKj/6JvXgLyuPjq29DVFO594p19Z4+FgURpXVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBTLe+mzZCWSvaJ0AgNXFG5kyNqtrgupG4gpDFu/hIGhZ9lFVh
	TLQosK6Y+wwA6k/moKaC/BTrKsEzHUNPDI8suvvzCgKn4cdGceUmI59wui9cAoHQw4c=
X-Gm-Gg: ASbGnctPCSwC9h8kKh/9W8KZZ5Ve9fTtabNekK1YSsId5eWxy9DtWrta2qTKza0yphc
	hcPYQfvdZLwQWFkg9QckT7+Co5yfnTF8hZk4bvKlVdzd61csux0bbI6xs5cwIHe+i8mIUbmLQpP
	8808QTeqdu5I3yjYlb61UnfB0E61jZxOwAfJLTWmweO/s9cUhi07GHHGtP1hkXN0gYz2Ft65VwA
	sZrnmhpO31p6oiwxwToTwmD3R97IIQOutAdUaSJxu9xkOe1OSAc/IUOgSa5PTIo144Rx8oP22WE
	aHrtu6qtWarDznmHfEIWdBMW17DNAy5h9I8xhdLHguKqY3/te9K4GjI6rocL5FEe4bcQ+lr2m1b
	W8Ay6rThQS2pjtjDUCk5Us+PViseiojDPv95a0eQOondd3piysMJpHzGGPjSIqmD58iYjHLTIQE
	LnwhU=
X-Google-Smtp-Source: AGHT+IFj00+KEhfyTUdUoeMsQOAVFICxssAUXXiQsbArF6rrRmD2nbeXGkEAgVBJGf4w+/U9QBdSNw==
X-Received: by 2002:a17:907:3e1a:b0:af9:3d0a:f393 with SMTP id a640c23a62f3a-af93d0b0315mr71429966b.25.1754055668022;
        Fri, 01 Aug 2025 06:41:08 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0df10asm288082566b.59.2025.08.01.06.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 06:41:07 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 01 Aug 2025 15:40:59 +0200
Subject: [PATCH] arm64: dts: qcom: sm6350: Add rpmh-stats node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-sm6350-rpmh-stats-v1-1-f1fb649d1095@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAOrDjGgC/x3MTQqAIBBA4avErBtQy9CuEi0kp5pFPzgSQXT3p
 OW3eO8BocQk0FcPJLpY+NgLdF3BtIZ9IeRYDEYZq5zSKFvXWIXp3FaUHLKgddF7FyYXYwulOxP
 NfP/PYXzfD+cRroFjAAAA
X-Change-ID: 20250801-sm6350-rpmh-stats-58d998ac8dd4
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754055667; l=1009;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=r1c9l1OijXU/QDDLBcy3ZcjwcgLrgltP3dZGJovejCY=;
 b=tAHAiNynxK3Ng3bMtjfpSPW5u2gDSl91hy5GdfnCwmCR4BXuMzsfpHCbjiNS09KU/gl/wt4/n
 d28cvt0FPR4C+Fyc/3S93nOYzig+JU97Q7B7lehVkdaDfAvXkp1NaoZ
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

The qcom_stats driver allows querying sleep stats from various
remoteprocs. Add a node to enable it.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 2d891a5640dead6b60386006bcbbb9aad40a660b..2493b9611dcb675f4c33794ecc0ee9e8823e24d4 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -2487,6 +2487,11 @@ aoss_qmp: power-management@c300000 {
 			#clock-cells = <0>;
 		};
 
+		sram@c3f0000 {
+			compatible = "qcom,rpmh-stats";
+			reg = <0x0 0x0c3f0000 0x0 0x400>;
+		};
+
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0x0 0x0c440000 0x0 0x1100>,

---
base-commit: 0b90c3b6d76ea512dc3dac8fb30215e175b0019a
change-id: 20250801-sm6350-rpmh-stats-58d998ac8dd4

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


