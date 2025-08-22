Return-Path: <linux-kernel+bounces-781558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB4EB3141E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB34B03683
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BAB2FD1C0;
	Fri, 22 Aug 2025 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I+eLrQV1"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB0427CB35
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855574; cv=none; b=P6ALYKWMS70mhXlOjQd9ZpL59RQpGkMAAtjslUGDplsK2R3pjcvez6ODo/A6QEQqvE7RmsA2HwsbTk36N6Va2cMNZKueRAKfpbbfrlQlk2BXGGLurGj7uaBaQAV/GOSFG/pozDEid7f6FcpqumYb9z+Vhj+GeWfCKTsUSRGdrl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855574; c=relaxed/simple;
	bh=/ijYBip4Gef+08P0Kp9cDhiylfO8cgPDqcobGaJy3Uo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s8+5fmrPqc7AgpM7og81+3aix56s1MY1WSvIOS5xk0KzK/Dua7E4zOCKOiSTlnRVO5iRa1C4AQWxpmZrtM6RjlgX1sp0J2HZDqQDt3XsOLgmu3BajnE3RG+e8KxjXoAaTNU3YIJSNieCvy2cHjY5s8wY/mtqoFSid+j7oLUzPdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I+eLrQV1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b9d41d2a5cso1581871f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755855567; x=1756460367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qJ51d/LzxXtFMmJ/9ohPT/eBh8hSvxUNsu8PvJJDNs=;
        b=I+eLrQV1NcGu6bAqE3fJzZmJAq05p/6JepqSCDsEBNB4rJ2TjUdtWeqaBIgEJ32CMa
         mvCK+xseo4l9CnB89Y84lV+L9wij2WcHb1/ZlGlxw9huIIpTiXgji3GfTAiGhuP2ogmL
         XbNwMlp9BWlv7ypZpSxhr7/6C4wmrowz91/P9geaH6hP8Bkw9aZNsNglS6hHQ5PHqWlX
         0g8EwdSk/32LOhY21NK3r321jNk+/hik8WXBpp639mTbh1dKfi0TicuZUP4dfK+M3OU1
         5CiTCXYgThzQVe/OPkVktHOXAdP0oMa7Y/YbVBytNKJqIT4c3/7Gm+WIHxNokuamq78I
         KtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855567; x=1756460367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qJ51d/LzxXtFMmJ/9ohPT/eBh8hSvxUNsu8PvJJDNs=;
        b=kuqbrzzypJ9rbburZRDtQ/Py8rnDgTe2QJ7ocpAXDghjetLa87Gf8JYcS0v5tJ9WOr
         PNptTxek15CK3u8LNZiLO/fqiL9vr0P2tibLmGElhDY6T7+REDiSzcfAieMExdMteu/6
         ekIcTudt6MS5S8YpjWBFkk15LJSZfEakPXqReG7/1xp3/cgDDjrxsIZe5fPusENygwQU
         8KsJ3ZmrjrmOUUFKfWVeWVGVeZ6Ty4bBbi1qqJ+s7kfcn1/yZwD14pyyCLUicKlgo+71
         5Mxx7JUZ/Lxvm2+9EfjEjZPNLUkLxE2/Rhjr2O9+Sg9xfzBS18Ky80KJT3P9VovS4RDK
         4znA==
X-Forwarded-Encrypted: i=1; AJvYcCWCUoBa3ZN9hjDddpPncXHTQzXAOC4QzPE3TafyUsG8r3Vz2RNVyyeKoV8PwXJRbMF9p2nG6UkR+I+o5Co=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa6NEGw3iAWaV/7E7SwvBP9O2n1ztuUCWFzUgIzmiIVJMzn/y2
	WYQ4VZY03tYOh9srCVYHbKoOz1rtc2JKlbXxlxcnUdfsIGamTJijxXIrB9gH+spiB7c=
X-Gm-Gg: ASbGnct+esE/OTgUYIabjmNzuvBtGmbQGeJQcKdNe85h4yzfzLzwtqEwQN1O71aFtHC
	xn6LZEPDCq0HGF9SSDuO/XzINLEv57gU/AwdkYcw2vQWPynBEEhFpYFp4PhUVqqqmIdpC9EqgJz
	5rMCTeXuTIjFZakfVCmRLheGIAiFkazyMvS9Z2gU3JNBKpyM6mQqT8CytCD4+ZcPaNVjO+29nMz
	c3rmYtByx843F+6EEz9DTK6jlPRP+MSbxbqaMqmLHcCaeiXgv4NviepUWMIuCseqYevcD3NDjSN
	WMWJl+fn4jHKMHaRqo67lSnb6ErgexdaqPdpZSE0eAEqC8I0yEoENpy60XyFHZtgFeGlQ7RBWlb
	s6atFjOT93NBybbbtkFw+nvBPZH6cXSnHe/r2LZX8IoA=
X-Google-Smtp-Source: AGHT+IGLbeNgCPY3QzD01aDKsP++v1teSlpVKBAg69DzLUXtEAXS8+pA2PvrG1/xF48FV08k8DIZWA==
X-Received: by 2002:a05:6000:400c:b0:3c6:a970:1501 with SMTP id ffacd0b85a97d-3c6a9701cebmr110928f8f.5.1755855566927;
        Fri, 22 Aug 2025 02:39:26 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c684524163sm609890f8f.61.2025.08.22.02.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:39:26 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Aug 2025 11:39:20 +0200
Subject: [PATCH v2 08/16] arm64: dts: qcom: x1e001de-devkit: Set up 4-lane
 DP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-topic-x1e80100-4lanes-v2-8-4b21372b1901@linaro.org>
References: <20250822-topic-x1e80100-4lanes-v2-0-4b21372b1901@linaro.org>
In-Reply-To: <20250822-topic-x1e80100-4lanes-v2-0-4b21372b1901@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=/ijYBip4Gef+08P0Kp9cDhiylfO8cgPDqcobGaJy3Uo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqDrE4Tmp8qOSpiuxCPDdZyYqOEkzZjfZkV2QUK2P
 vl8CfTCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKg6xAAKCRB33NvayMhJ0Y7dD/
 9HH65FmwV0TTwin7fXUg0Aa9FMKMuafXSeFqKDcbGa+AyNAmPKhcBvrdMJA5Ri2zHw9BuAgewAyWOx
 SsAT3tdmwOvMfZUYc26UZpAan8e2snbK7DryR+3xQ4+owPb9en/dOILZTsB9fp2ZOvklVmf/JCYZNa
 PQk+KaRxkCrpXJ0QNQTnAsiI9up3r0eyXwcplxSUjBwfjRTKSLxtaHoXhGW+i4yOVfCV6PgO5mkkLd
 aY/Nj206vW1mKQWFbc6bC0XlH9b1+jkdIvl1YoupTcAy613daGm6NgAsyqhZm2DRYuHpNuzNIXsE8f
 VbO+u33JwkeEWyW+G9sCfqy9DPeQnGEXtvmNDLppfGfxJ6VlUOWMq4fIERcHPfsfi66KYs0W76zaEg
 KwDtlSYG29BdoNKz4TZjjfc+oNZ4sUVRrdtz6fTxg1tQXy+cxSy+OKsZ9hQXpXBXK3YCXZVvfK8Z7N
 oxA/tTgwJ3Pn+IXBXZHM9NVWGCfW55J/wv8aiMPmNAnfgqasg7nYWCHUFn42P5xDbeiiBLsLXSVzqw
 QceHSp0LBftb89m5gYbW/k4GWB1wXpIJEnmcqbzckm6mkVaEUhTUvG0Rwc7FaHVUfkCv5htx3GSN9X
 iQ2lvsJCZJhpHUTexb53jN+aznF4DazTfWjlTBwZATgKeBC+fCuozLoPcDmg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow up to 4 lanes for the DisplayPort link from the PHYs to the
controllers now the mode-switch events can reach the QMP Combo PHYs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
index 2d9627e6c7983daedba87619ba01074ee22b43c9..b055925da389146c4a141152bf0025624be53dda 100644
--- a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
+++ b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
@@ -983,7 +983,7 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -992,7 +992,7 @@ &mdss_dp1 {
 };
 
 &mdss_dp1_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -1001,7 +1001,7 @@ &mdss_dp2 {
 };
 
 &mdss_dp2_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 

-- 
2.34.1


