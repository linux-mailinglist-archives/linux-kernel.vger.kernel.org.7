Return-Path: <linux-kernel+bounces-779916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 619EBB2FB34
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE13AE51B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AB63451AA;
	Thu, 21 Aug 2025 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HTuTfv4a"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFE83451BB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783460; cv=none; b=lvPZn5J5AevrBy/yKhdlSyo2Zf9bievt6TaJ2ldRZtQJXah2xdyYqKAua3KLbMU59rh9WG7bzB6txCm7f9mKWUJDACYCLH3yTwXNIu8KYKBShbq0HYSdansoSV93n2yv6xa/urt+y3EzMpFekITJjID2e0JdXSduW8mNh7KEOSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783460; c=relaxed/simple;
	bh=CBHmMHHtxlm10+qeAMc8aYam3qMzlCk22/bbwKvrU/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qN/QZ7mImtBYidyllTAB6xyHIVGm/VucGKrqrNG1XJZQOcx/IRunaLzJtlq/aLDW7ulq1fQC+y36RZq7a/QZtgNBPgtSVnX4zAjFU5TEW/w0khX2hBQ310i4JyBob6rmAgK2jt58SCaYfCkUh2r55JbFF1QMBQ6bKd7Y+SxbSKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HTuTfv4a; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso769933f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755783457; x=1756388257; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wtFtCOZAL2gp20b+62S3Bdf9VL3D2oi1QDgtuJyRDc=;
        b=HTuTfv4aYuoiKCF7QFp6APO4jjWv8C0iGerOsBbMUKfNPsftYpoy5Rv5CsA7L6kHBZ
         I67a8OoxBcrkF2NTiZq0y3sXHw+EHiQHNl2/RbOWzjuMYyoqISf7OTeKeFrvn3KbuC4k
         reHh3oycEblp1rJuUlEZ0Zek2mNcS8NZT7+znnllHNS9FFUYSbzhtaHSjTdHywL78kjB
         DyuksBuKYmeafhDb0oPD6iOq16BVHFg2sjRYFZa7wD4iQmRwL0BxPmNCTsPtPqdJjhYU
         qeBloqm1iC8VBm2IwbB4FQWGFxB/gbIem/6yDvB6xLC//jYBGslJxc8iMZo6ix7Z9Te5
         +pyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755783457; x=1756388257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wtFtCOZAL2gp20b+62S3Bdf9VL3D2oi1QDgtuJyRDc=;
        b=p50+oqXe2MqAotTTcWzXGHFQVA5M3duGE2xed9+9JYltePHQ6BxKMTig8WDKnmAkyC
         VtGi0W3yxFvSXVjei6p/Ij/EYP3sxb2oD714tW3rpsOpoXT8tIVcV/VNTlyfBthjmpr6
         qG8/rIa+gb6Ym04ALam7XFaSogvxWfkLmKbhPvnvcefiSz5wWjPX5ty1Ubtjd3Q/YRxt
         ixmv+LNtNCf0i5szxnhgdrsunYi+u2TgbuiHawTE07pY44MVeD7+oBoiYxajwSlREo6s
         B1Gjm/LlLAEbAct8xQg6fP9C56/O/qIID/B5JQfqO79E+/ly4VQEKcFd/qjnvCU6oE8y
         fOiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt7OdceGQ8ovjLgyAFtmtmLhQP2k+v97c3IYdgdS8QxdngCYvgIzqXYPyd2R59sK06uOzCsTc9ytvZpXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAQcqho0cdAMpWMORscgJMwNczkVndOAYyKH19d0cjtq05ehjJ
	5zQ9MkFILVMYrfWkhif6cScicUF8z8qCvn3jqAJeZy890nkXNma/RqZgfg0YUGIlbI4=
X-Gm-Gg: ASbGnctn5hpy7wZmRyJL0FXSZ/6FbXe04iUSRXybginWSlnTKNqdwblaG4cSufREtIe
	2aCbKaDN9wtdL53Qh/BmGZys3bP6cFujIivkduIen3MFmBiEx3RNigOORBKnBJO4uOWDTBL+akq
	B6Plki9lC3yVmA4LlE4oy1NBuaSrxmwI3gd9Q+u1s6JLVRemkQBi3CkfLHS11uSCi+gBvtTc6I6
	0RRYv/QdLEhWti0V8q5qdDPbl/44XObvCgL8MHSXD+5ZQArkGqmr1TTurODl2+ICTiGje5HiFKV
	Aclszx7Q7wG68yUGnXHx3wDAeZEN4QLUNs62+59wnMKI+a0K8huGkewDk6edfOjPWrQRRUavX2k
	c8StT54jsI0VJvKLVeUTz60q7qFNGbINBeEPWVSLIYqY=
X-Google-Smtp-Source: AGHT+IEy3el9dJ6T0DOmLFIF1DS7krS8sHRU2HPR3XquNbvcEO8/WCjXHebCzaRTbLThFau/+7Qbfw==
X-Received: by 2002:a05:6000:2c0e:b0:3c3:ae31:7189 with SMTP id ffacd0b85a97d-3c496f92d65mr1680240f8f.30.1755783456842;
        Thu, 21 Aug 2025 06:37:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db2ab4asm28937605e9.8.2025.08.21.06.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:37:36 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 21 Aug 2025 15:37:25 +0200
Subject: [PATCH 06/14] arm64: dts: qcom: sm8650-hdk: Set up 4-lane DP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-topic-x1e80100-4lanes-v1-6-0b1a0d093cd5@linaro.org>
References: <20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org>
In-Reply-To: <20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=732;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=CBHmMHHtxlm10+qeAMc8aYam3qMzlCk22/bbwKvrU/Y=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBopyEY7+kEh2F/gI63IFBpyGRw0jK386+oe1ZgDyRp
 n2S4b/uJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKchGAAKCRB33NvayMhJ0el6EA
 CSG3PPSjObo/BDCu7kBBD1blql+NMchwlsxrrPQ6IausuRpPfPht+qcQ232xPmejhpdBIckZmIjqcZ
 Uuk/RLkBB2vZaPElNgMqOaW4ETvpsmyGMRHwV0zf5xLuWW/8X0LEcbz61KRwLO2YNoPUZttTO4LBe/
 LdOXKslWGG/kvWVXwRUfy9s2W2elESOiQbYicuhV1MfMhRBglDeNrzOTGp/F2uiW0wxT/MjzA/mN04
 /iT9K1pUhRINB22SHBFtZoCifhHlgnTj31eSesWTDgqwle+ggoiheSa1aINuVL1GmPiiboGrFM39sR
 NppwgBq1kMQd3NlYbJ/TwDmP53g2EsjBZ+kqKPqArGaTywujl7cMifDG0iOSspMkSf596eOb5Slskw
 V/pd/vdXfT1esvre5smfjU8n9X0zxk8MtmLyBNiJmCtBwLjy05a7+gth+onA6WGhUFiaNGRtSwmTjU
 iRTKiiPko8HGWqaERtDkCVw28+e+goDUzJiGcgqZ8OW2VYYK3zBBsGp9wAVHTG2lT0eoMnZZvNstFO
 sGUdGUmP3mNs14DRxU5SOVvVFta+8HlThH7KcFAY0ytv1Lk0y0iXD/rHTwptL0pLXXjAKeO/NY9X30
 OszhzEQ8wXvgjKwKLwVGTtZHgerVyzSp0m/dwhc8SIUOoP6E9QzE6+r26Xww==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow up to 4 lanes for the DisplayPort link from the PHYs to the
controllers now the mode-switch events can reach the QMP Combo PHYs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
index a00da76a60620b998973cab189f12eeaa0a448fa..5029c8bfec5921074ae6e1171bc3685ed9407278 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
@@ -942,7 +942,7 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 };
 
 &pcie0 {

-- 
2.34.1


