Return-Path: <linux-kernel+bounces-856587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A13BE48B4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA555E4E21
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC1E36CDFB;
	Thu, 16 Oct 2025 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0BZpY+d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882C6350D46;
	Thu, 16 Oct 2025 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631420; cv=none; b=lSCh/Q+FGL3s3py3yACi0y/M5p/LJid0FMu6FLkRadgQVzp8jBxPcE+6wDrb/3T6IiHkr6KjDafc+uw9aOj1u2aZavg5HuSnhom/vOZcFtvkuMME55EJA7glm9tqh+h3HR/oQyhrqaa3JDlGZJamk3Pwc13x96/39ut1vrs7tHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631420; c=relaxed/simple;
	bh=v+q+jUnQBuk3tLdWUct2g8Ando3+sIKtmiW+8PGGVHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BEJiNU1xBTfxhyR6wi2bL98uDT4+0c1wjvKI2b+gdV4ySXBeKT53VFfezJp6KZxbsngMYIbLZzqHqkBj85fT/yTbjb4cctMsuZWlw1axZw/kXoVe3Swhdw74scJZvdxcDQuuxOQlNnAuKAQHhAPR7hMR9iVMvzXIzMWNI9g4qXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0BZpY+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35AE7C4CEF1;
	Thu, 16 Oct 2025 16:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760631420;
	bh=v+q+jUnQBuk3tLdWUct2g8Ando3+sIKtmiW+8PGGVHA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=b0BZpY+dFpEKtkRKJPo+9UqtMKGlnawQ8kQpXBvWRCQJDioLlGbXKoCPD91z8DzWZ
	 kxDWa3MUjInytgJIUfr1k1rBEKueULwggGLQyJHmTyUkCwrjm1evHvm2yAGP19OnLj
	 ZDCXkmLUvULJ2ns41HDwbaT+lS8gbOvnEsrAM8GFprTnckBUwWtR9/OCi7lJJPRWWz
	 X6bFtaZ4MH2F7FmGUHo8MoDq5W3geSmGMKz9B/ob9D1aCbm5aGcyIqOCeY1+PVDzZB
	 TKYVxMUTwafwT1ikOrawHH0/zpvU/BFv6iLxNNirxGPVxe6Y/ejojb306nGEqiHeXD
	 6/2BtsVSwUFcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286ABCCD199;
	Thu, 16 Oct 2025 16:17:00 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Thu, 16 Oct 2025 18:17:02 +0200
Subject: [PATCH v3 7/8] arm64: dts: qcom: sdm845-oneplus: Describe TE gpio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-s6e3fc2x01-v3-7-ce0f3566b903@ixit.cz>
References: <20251016-s6e3fc2x01-v3-0-ce0f3566b903@ixit.cz>
In-Reply-To: <20251016-s6e3fc2x01-v3-0-ce0f3566b903@ixit.cz>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=805; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=+89dIAb307+D766iUEdy+zPCpNwpfjUMxJzd8fVjBoI=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBo8Rp5q2dOvtsknUbjUNwSHcaNLRNWN+FecCpIt
 o82OFlYPC6JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaPEaeQAKCRBgAj/E00kg
 cn/QEACGgswW/P0zslsiphemBB0c6BW1Vy6E1tvxtQnoJBav+EVs0JadpTeE5PetRiOUEvqsGQb
 HghwyTCcVqgp2O0jwICNjHvQQ8gySMY1VCsC1YAwPZceB6HZ82KTb5dOayiANi1gFXUyxVNR7SZ
 phzAPO+o6jOhbcdIKIGWF5Erblk7sMQ3BjFRRpAW7PxbybKql4YIlX9nJ5F/bI7w5E0Kz/Dcg47
 Y0A/fdj4ZwuV7zHK+NvxhFTa0EbgL0SlqGnhl5iWtXXG6GXImmaka7lnzoSanZsKHcFy7L09UzM
 mBSwyjLAsPv2p4ablgaiub2nUEZOk8rjMCPp8Or6WDEcs7Q6kvVqTcbmZ2Iuser7jASNfMvvEc5
 PZG0M3x6TFVaUTnNX+nUnOCpn7n6DTCR1HWdrmBoEgY7hUvk0kpMio4W5PRqHK15n1cIdejWWwE
 iYBcrjthD8LE2M6e440JXw8gI3b8q8dDxfqcoCNm1dh/oAj7qVbdXtbmOQCmgKp4ccGf/HsJz8M
 vpBuH618ZRW1R3Ve72J2Y7dM4V8fXT8EMXUdrIe7YZLw4NVRNBDOw0aLLhsG5w4sDbKZlDf7uF8
 3C9PNCo9itZYeZQrys8fb0gfoTGVqN1n4qppakNwO9496U7KpoJH0n5VzslMPVKUqHWTdolyvxP
 UekX+jkJNo//+Sw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Describe panel Tearing Effect (TE) GPIO line.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index a8e87507d667b..b663345de0214 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -460,6 +460,7 @@ display_panel: panel@0 {
 		vci-supply = <&panel_vci_3v3>;
 		poc-supply = <&panel_vddi_poc_1p8>;
 
+		te-gpios = <&tlmm 30 GPIO_ACTIVE_HIGH>;
 		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
 
 		pinctrl-0 = <&panel_default>;

-- 
2.51.0



