Return-Path: <linux-kernel+bounces-782399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D95F8B31FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AEB3AA42F6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5C42594BE;
	Fri, 22 Aug 2025 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f6zFiOSw"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02AE23D7C1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878223; cv=none; b=JMRognhVDU1uAZtg374BS7HlHiEStbOe8mdKcxRSvp6tj+nuSDiIB+LmVe4NeMHTMUeU+5g0DHb8ZN87oRMpynxLttypeKfsCsrC/TaXWQAwuHQh23nUg/HXO1IzLUcUZW+z4/AAiv5kZYVIVcyOUDAHd2rZyjfZTPhWzjOIpXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878223; c=relaxed/simple;
	bh=rr71+BBtnhxoI0vp1gh26EB5RHubOusDekfjzEuTCME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MBNE3GqRCpi46p9/IFFv+Jg/cfWXy2NmcuSOb7UGS9mpYl/aW0jsiq/fC8MymSwIvRqkcQOsDFtwCP/GwPLYYhoeqA6fhSB59QfqwxTBwrXePDnp3sWNGfwft3aPjpdEXCuCuFtNzC+EzW4HykuTrg0k+AifzUVJscJEjf1Y2yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f6zFiOSw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a15fd04d9so22378105e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755878219; x=1756483019; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8BLkvgVSbp7ucpmwzFe6L0udmC1CeuwZxTZJh2EA+8=;
        b=f6zFiOSwsZ46ZqvO4yZhBMZU5pBJSsH6auQJgrZM7HK5vp7NIcYY+ir+k0KMhEFBTS
         xHAnD+PtcKjtRUER8TLznyT4NnRcLjr5iLJsz39BGs1c5vHTpU+J6NL3m6qFQ9DtGQ1+
         D9hU7dNe/qmyWT+VY0NGNI2cYnavvXe8CMcDmYnC32tdWD46fiduJp64uStOVnewaOCM
         W4jrcNy2bIJCPV+S6monKdbFsTWy5ge9pSEXYoYUy0h+9Zup5MvGQ1y3me8VhEy5ToOB
         GD1zYf8w07Wut3yN8mVKd40tOo+P0R7knsrftnpc2StEcT1FXzN8OeA5aaxB4PkSDrE3
         GRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755878219; x=1756483019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8BLkvgVSbp7ucpmwzFe6L0udmC1CeuwZxTZJh2EA+8=;
        b=GBv1wnNmubTSZBjLkrQ5Z05pCW0M8cotMBr2n/dAzl1WMXUkywkSbF/pDoSyoFn9yJ
         TDOWx2w6NxntmUhJWlb2NiQkTGXofi6fP5r9IKXhopnlXM8wVypra1T1r9T8+NfkImDj
         +7x5cKBu5Ezl1sNkubq12NtbHU235WRWcWIEkNcSS3Y7b6iEBXCdn543A+niE/104FvM
         JiF8gdCSAfVMvQyD+ZjvTnPjocZXkscW9KEWp6CuwhMBx2MfShkk6QIRgvdf3qc1Jiiw
         4DeX3gR4OO/70yGQ2J7z7suIuoag3YXs775/I3S6VdXR9wHO42SXfIzrJW3+9BAW2AX5
         IHaA==
X-Forwarded-Encrypted: i=1; AJvYcCVXL5pYwrOWxTgva7ropLbXPUs32miClUA3dczfBlmQjroxzbG2moM8U+4FtQ0iE1JX8wFOUDRQ/g7KBeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCrvnF8lYaHn+yqWOvCOXSDbVW2IIVwvk6bqqMUTeVWUWFmPFd
	+uNBRop6HMuEC2wtFLEbA4EdAnO+pDhF1wEEUkSVKktreRPTc3yKRdwRSnYM91V3pVR7bp4+KP7
	Hzcn0BUg=
X-Gm-Gg: ASbGnctH96K66pYwqDkb66EllrzlBUIRYx/7wUmJq4prm+go9du9zES/edtwjIRpS5N
	qAKRa8sDmi7nFhBpqOZgaxhZnJMs5xKY5g/mrpt9OPQx1vOaBLxAtRuxqAsvhfkev6YCkP6k+KW
	c2v3fCl/L9gAv1PiwbIXZPp/FW3lKD/14X8L4WT25hQP0db7FTb8qeY0NkAEq4XJTnzAUS23dTo
	zRyoJFfGI0xP4FGujokKj3M+gJbm1I4EwJ/Elen4nMecIHey/RkjXwuKDfM8UevNOYmUK7wWxRf
	TAL8TKBPDfuYFtOEroRW6Kjs5Ruzr0VHhjZvhnEJRJvz3MNZRi2WgCLXMx9EbdlF3y00XYaG8hr
	Qj3A3zoYQhYZ/Jeh2J+8CjsAXSkE6PHUs+D+k9KfYGgxJIu8SbVcleQ==
X-Google-Smtp-Source: AGHT+IHAILKrrhMvJu48FiWHPRG8716NLCNwe3tEtNvBbBHTI+z2zVqFWz27jthYBBeiNsEZWQPBWA==
X-Received: by 2002:a05:6000:22c1:b0:3b5:e6bf:f86b with SMTP id ffacd0b85a97d-3c4af1eac36mr6361861f8f.11.1755878218965;
        Fri, 22 Aug 2025 08:56:58 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c3c89cd4d4sm10095765f8f.42.2025.08.22.08.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 08:56:58 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Aug 2025 17:56:51 +0200
Subject: [PATCH v3 3/9] arm64: dts: qcom: x1e80100: allow mode-switch
 events to reach the QMP Combo PHYs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-topic-x1e80100-4lanes-v3-3-5363acad9e32@linaro.org>
References: <20250822-topic-x1e80100-4lanes-v3-0-5363acad9e32@linaro.org>
In-Reply-To: <20250822-topic-x1e80100-4lanes-v3-0-5363acad9e32@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=rr71+BBtnhxoI0vp1gh26EB5RHubOusDekfjzEuTCME=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqJNFbUhzX06708ww/e/e6JH9cTNeaP3B2cc3BJ/E
 XhddW3CJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKiTRQAKCRB33NvayMhJ0QmGD/
 9pLmigNnG9TysBzzxMStx2SNu+d5YJGoNHS18cGAveMXZlfKm2pQoIaqdHcKupxBIxaADkeCBcm7sf
 r2bnFdKAZgIm1TiFAP0/KQGjGpgxibBD6DrE0las0M0ic58hxM1WchpupU2Qucp9IQYytijbyC/INa
 nb37R2ufDMcL/AbrjN8NNSh2NaSEvsFufzS4bHah8GSOFlw4vdbXn3vXwYbdx4CTnEfQC0/1ysveH+
 F/LQuzCy+sJI97yWdgzUDRJOMpk5cfr19ipZgAPGa2cLzfAFEhPXlLbxalLUrcbH1dq9tWIjsUBcit
 JtBbZ/1v3y5u/MWUPmdOKC9WzBqstqRhugcQaYufAkvssyvgVDfHcTve7OEkRwGHm2Adv/femssUBx
 f4vyszXIFIQcX9a+FFNizuIWZS8tIDLogbw1idn4l5TiKuYF3ofTRiv630GcZrdJxxC8hR4Ehs6rns
 lI6EiCUi4m4yK5UZ7pAHZNFSZCn6VE+fbIab1aV6MfkcP2vsvAeXDC/ss9jV/Mzt40VXZ6L6xkoWYT
 JLwRVTYQniXZMyLFbMkw1hg3dFbhoMwcndCXU/AhElw8X2evyB4m/Hymt3kzzEvsYiDSALnfmMBDoP
 Y5jgslHU/v0CJ+B9e319bKZdD0H2/UAVDf+4Ec8n8PzLryyq/e27MOczo/EA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow mode-switch events to reach the QMP Combo PHYs to support
setting the QMP Combo PHY in DP 4Lanes Altmode.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index f293b13ecc0ce426661187ac793f147d12434fcb..48c715e9ada33d4909049bca28c68a6b24ca0b0a 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -2857,6 +2857,7 @@ usb_1_ss0_qmpphy: phy@fd5000 {
 			#clock-cells = <1>;
 			#phy-cells = <1>;
 
+			mode-switch;
 			orientation-switch;
 
 			status = "disabled";
@@ -2927,6 +2928,7 @@ usb_1_ss1_qmpphy: phy@fda000 {
 			#clock-cells = <1>;
 			#phy-cells = <1>;
 
+			mode-switch;
 			orientation-switch;
 
 			status = "disabled";
@@ -2997,6 +2999,7 @@ usb_1_ss2_qmpphy: phy@fdf000 {
 			#clock-cells = <1>;
 			#phy-cells = <1>;
 
+			mode-switch;
 			orientation-switch;
 
 			status = "disabled";

-- 
2.34.1


