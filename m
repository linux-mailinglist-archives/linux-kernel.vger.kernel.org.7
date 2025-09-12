Return-Path: <linux-kernel+bounces-813385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F4FB54464
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DABCF7B916D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6B32D481F;
	Fri, 12 Sep 2025 08:04:10 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C04B2D63EE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757664249; cv=none; b=C3J5jKGqPtEVNQsqSGGC5PqdHh3AKRUuBDESY3mWxQkMCSa5M9koa+kKGYDfqU6V4UJDie6BKm+ZX6xPSPqbU7s4OhptUhXZnvYfQTVZxRMIhAy+PbYxdWDpktTcT+LawNu7jlZTKCn6Yb9MZXEhlOSnjwOnvo56yQxyZMT/PCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757664249; c=relaxed/simple;
	bh=qio0UgqqCiVlwo/iotJR5Jswa+50RwT6XpwD/Gsmz3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BHuqhp1tbH6JueFbim5Vcx48cmexkG5e1QUbr2kyOtwp9FSCE+IsKG2roM7Von40aUZv0vMmy4NO+xtxR0CAdBq8HQ7IIPEkM3WwLwkJSkm4ygRLTbP4XDiyFe5xDT9kIkD3EUI+yZ0JjxGRRlTZP/U6yF7YP2cjN0Ip+Tn+xoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1757664236t834c71fe
X-QQ-Originating-IP: jhVYbhvFGzYgONTpQJQh5yssDPWy/gomue/4E6PK6CM=
Received: from [192.168.30.36] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 12 Sep 2025 16:03:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15272649383679166477
EX-QQ-RecipientCnt: 12
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 12 Sep 2025 16:03:29 +0800
Subject: [PATCH RFC 1/2] dt-bindings: arm: qcom: Add Radxa Dragon Q6A
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-radxa-dragon-q6a-v1-1-8ccdbf9cd19b@radxa.com>
References: <20250912-radxa-dragon-q6a-v1-0-8ccdbf9cd19b@radxa.com>
In-Reply-To: <20250912-radxa-dragon-q6a-v1-0-8ccdbf9cd19b@radxa.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, 
 Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>, Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757664226; l=857;
 i=sophon@radxa.com; s=20240424; h=from:subject:message-id;
 bh=qio0UgqqCiVlwo/iotJR5Jswa+50RwT6XpwD/Gsmz3A=;
 b=deD0zGERvHRRT5r7tFEe841uDvgXGxjdpGVeG5CVxCydoNx98lqgON9oefV4ETLSNdjxK8jsd
 WfauGTV6JywA7ue0NbjHsIX/RTm5CK3u8B+69h5HWh7jZEFdgp8aXCj
X-Developer-Key: i=sophon@radxa.com; a=ed25519;
 pk=vPnxeJnlD/PfEbyQPZzaay5ezxI/lMrke7qXy31lSM8=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N0fHFfxtkpsjXy94aYe8CiLRobnW0Ov/2Mro1J6DWcOAgfopvVl7SHfh
	Sr/f1Shc1kOy5AxLXEGx/bM+xpUdnoMiT938wg6Ka7B+Uq8dFcIAgikr8dg2jeLZPk2Y1o7
	0qqKngi3BD9CgI5cLv6UNfjp0ad56f2S9R9kHuNUOsdesgYt230BwH/sJ36tVr5UNIJLsWQ
	UX6jG0zkyujoxvg5I1qx3LJ86TnNUZERumJZJ4lSwwdg4GjrgLKHl8r4veX5QL/xNM0tCDO
	Q5+7YCGEZsn3IDb9clixI/kqwmKIaRwP1IlawdsFeZ5GYiYYnYwxITU/We3N61Ync6aBy2N
	ucMqVknur2tm7BMK02P6VajI6FtSJ+M3liNwjqzs0NMCOuCHu9BW+8N/5ob/1eh/pfViZOB
	380tqCfs13oMsddJfzxIofv6JZ+1is8yEsNy2tXcLTuHXjSHahJJ8JHYyY6qoIeB4qdD+Xg
	f6dmuQFT+NPrfgaYEvwnerstQKO42zIsJaMoBsx8REgZKg4W9wOck+AtSaSIjBmTePE6Xvn
	Rnw/GFqv+cKcaw/ORiD1ORYXgjfRlFp0X0PjxPLoJ/SkKdrkKlwtTQlHmAAvDucxDaywIFO
	gBRCHGm9ZXrJiyItzeZg4gevEvWhOXW90NryH/1GUOFYcgY+EIGtpSB0uD+p+TigOOBhp8S
	k0OUDExxNEohXRbRyCW75rnI7P8mqwOfP49GQY6lJTP/31GP8YonzyCf4eavUCSZJZD6K+S
	r4KSzq3BFtGdTveL1V36i7ey6gcxTj5mgis1ANT5cx3Q9KfPcFHVqhl0DzQFacF41owf5Dz
	zrdRS4FOS4QXVmv6yuKCyeHj2nS9GEzI1GTc6io0TZsJHh3sHmFqpelUvk1IOvx/D7HhYyq
	U5ABr+9xCUleV2PYGPcWdoxY1tNJ0rUp1AWR0sWNGwkb2i5JR5Ku5dALnJT7hYK39catB8Q
	CB6YAiIA7AfQ1WFBxhGvijJE8x6qvxbfn+qOfOxGuTZhuNeO8pkZSSxrb9AGPprcotwc=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Radxa Dragon Q6A is a single board computer, based on the Qualcomm
QCS6490 platform.

Document the top-level compatible for this board.

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 0a3222d6f3686f1647b9e2ea192c175b0b96d48a..a7469a51adf0d6ebc1bf25acce8f125a844dcdbf 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -339,6 +339,7 @@ properties:
               - fairphone,fp5
               - qcom,qcm6490-idp
               - qcom,qcs6490-rb3gen2
+              - radxa,dragon-q6a
               - shift,otter
           - const: qcom,qcm6490
 

-- 
2.51.0


