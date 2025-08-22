Return-Path: <linux-kernel+bounces-781562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D198B3142C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B27CB049D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAC82FDC47;
	Fri, 22 Aug 2025 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="foxDDdEE"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C582EC57E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855575; cv=none; b=Z+RiNk4Mo9g2NCvErwMJ4mLTrPUZ+iLvy9pFq7rx6+0lu2NP6AzyE7bpDe0reNY1pXQTstiwNeOEFAvBlT/e9XioxpmMllkp8Vw7Y3Xe3dZCa+WuYePx3bniNeR3EC+v3yPstA0vQUQkpe2NEEMJ/jMPHpZxkpQ7UMp/UfkJaZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855575; c=relaxed/simple;
	bh=33V6vO8dY2xO/0hImlUa4h4K6tSixB5izhQ3YWGUhF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TQRl7TJbbg6sI7ZHx6T2wUxguCzbqzH+LhXKUAwE/4OhJCZvwPVYQsNSiCu+QtkU6AJLB7WPKmm63093FC1FRgM/uzxZXG49Iv/1x2Xn3n+q1SJpLY9ckG2VEmbg/nKXWn81UI/I4Z524ddCZLRWfta23iRVxSuHpkkNdEpTnAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=foxDDdEE; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3c68ac7e1c4so75679f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755855564; x=1756460364; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FN3M1ELHzNZvl0HLZKgIMT8AvEW6zwa4QCuopr7VTZI=;
        b=foxDDdEEYRRT2jDrf7PAZ5+ed0ryMWWsmnLkKxIBJ4Vtklwp8ptjo1zquDrOv3zaGF
         7xy4HJPKcX5SVgSBgla6pzTpz2pKqIynufTRW4nPZDx//My3xl2ShEvBNNwQ4/sJHtaO
         FC2FBf1ZzM3R/PLN46UvJYP1Qu99tfLZbTyjGeYcEdLAfXeP5u0udtACDytReGxa9HBb
         /GaG0M/Ood2vYHzT1T8b44EoU+04rmLrZHatRm6rkqPZdNmWFiyUYRPpTheYBbutt96Y
         d/t4GkdnVgI0UplT9ezx63R4fnkuxdlEFCxIAaH56prZdzVmbVdPvfQ0v9igAto1Gt8Z
         O+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855564; x=1756460364;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FN3M1ELHzNZvl0HLZKgIMT8AvEW6zwa4QCuopr7VTZI=;
        b=gDlR7XkWAa8wLY+kHV7DUshIXQvzpNhzDW0BdOUsri/5m0cgCMi7c0oTsjBo0Pc00H
         WUk23yjuNtzaB7L8QKcI47m9vFVnqAsTgQfeGsQeajDj25l02xeYO16LqWN1rA3eiQoC
         sZp6IwVtwfs0UOkj/e7Q+oB20RFSoRG6YW/GIOEteWPGZrVKQDFlKV/HKII1QEns+tgO
         k+0FE1BO863sEIht3SkWxfKQKQyED77qHiBn9jNUtoHtv837WnBRUXiWMUdGx0tJm48/
         ShG3RapAvwA5X8rx0Koc6ApjuXsT0DMKv4a434wHAHTWMnRkgNWfYoLfuEDyJH+cAQgu
         0dTw==
X-Forwarded-Encrypted: i=1; AJvYcCVbu5xpIJRJByaflfBT6F3f9JWrXtbVdsextOpWDMaun/U9yvOag9/HA0kUaFeW8J6axQVkEsb3++VS87I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJPHgdV4oTgEH5RmCKbUKNZK+RtH7OIZFtTTPohuKl+3fSntnR
	Vsi1vgyY6D9Oi4IUQD2Im5/zD9rPnOeYM3X+YIwGD+lfTkQIacBSHRJDOblb1dHxPZw=
X-Gm-Gg: ASbGncvTRKNEHH0DYeQfwvppK1RSVRjW1rU7stRZ/wqzP6o5+nZQuQyrweEfXX/Zj0u
	3+UO/JLbObMgvMg/cz8OZq6Bkjn29MtrEhSEyLGKvOTr9IahVL1ZTeWoGlO4Z+53VWJGdDV1GKe
	JKJx7nV3hO1VsIl2tEfMdAI11wdfsWgQZYnaiKaarzdwxxqZ8efQgMK8SQzhPEtR0SttN3IYypW
	gP8ZDQXn9r1osTLyqIoyx70dwO+9ePhbKKVYcKdUQO4asaTT7qRoazEPutKldhJNCE39piurWud
	Zy13LKa2rJNJwPnjGL1GVZTdSFbGSu66K0w3V7MdDb9pspT0qgBMTQLS9iwZrEZQsxRfwdDCK3l
	qVwWxKca/Em8vgePlwTil/PmTDyjHZmI3k2yuhLwelzU=
X-Google-Smtp-Source: AGHT+IGJ68yT3uMWwjghe50nYfb6T/a/MnWwRI7s6dwWoQV0Xc0niE7+5hqohLZT08H6TqIsnjN1bQ==
X-Received: by 2002:a05:6000:1883:b0:3c0:4f30:acde with SMTP id ffacd0b85a97d-3c5dcff535cmr1600624f8f.55.1755855564318;
        Fri, 22 Aug 2025 02:39:24 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c684524163sm609890f8f.61.2025.08.22.02.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:39:23 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Aug 2025 11:39:16 +0200
Subject: [PATCH v2 04/16] arm64: dts: qcom: sm8550-hdk: Set up 4-lane DP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-topic-x1e80100-4lanes-v2-4-4b21372b1901@linaro.org>
References: <20250822-topic-x1e80100-4lanes-v2-0-4b21372b1901@linaro.org>
In-Reply-To: <20250822-topic-x1e80100-4lanes-v2-0-4b21372b1901@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=734;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=33V6vO8dY2xO/0hImlUa4h4K6tSixB5izhQ3YWGUhF4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqDrDwRAUGJaa81iL/NB2pGU41mbKbaUmf8aCkXET
 3wFcyPqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKg6wwAKCRB33NvayMhJ0VigD/
 0SyMp9yz1Jm/Js73SUZISi20pNqIqKhOzCEhDnVqOtep8ags2Ph147Clksqv+0u/4Z1OEnQ5zchHvb
 Sm4WXLBfldwSZMP1h7Xz/PrNSCujobPBmj3YFojt+bw4bHlVJJVLBlOEzwwGUnYTeoHF17BRTYr5Km
 j/VbQCT7Jj0v5lOamNjQAhDfQb6V7s5tHvULcZRebbe9e6VUjO3WPJRHYaG2whn7MgnqccakvmUkTh
 AhBkpz21nW2podAgXZQZ2CJ3OeSGNGZybfCVV3JqfO4QZUu/KN1WhR4kbqzw4lFQVjQPf/7WUxW1og
 YZle8rduQmpKQkB7MaU/kt4fB87IEMVmHy56+hsCgqCf4xEvRel8Ikfpz8+EUOEjIBiNp+iZZ82Ldj
 IhntBIcYSFZ4diCda/2yr2JlSdQz6JhiEIKg4zf5HNBzLzJeQtXB+2le9BHkJL48C044zDL7vobZgO
 l5oqzUc7r18FDgIztyCX3WXVzSCr2SItCrdbtG2wb+R5iau15IQWY32WBXJg4VvpcoW23oA06w/f65
 8HVwnPeS2zQ2WZx7UsmWhqBQTygzteV3MUjswW5v0/p7/muq644RCt9yv3Vyjw/R+7l4c0KWpANp1r
 Az2Vq411naGJ7h/z8q1IV/vkqF0n/aUCyI4GMDaG5LbI3oaxbaOYYQESnBjQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow up to 4 lanes for the DisplayPort link from the PHYs to the
controllers now the mode-switch events can reach the QMP Combo PHYs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
index 9dfb248f9ab52b354453cf42c09d93bbee99214f..6c2c9514a7396a8b75ebe24585b47571c74ff568 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
@@ -1003,7 +1003,7 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 };
 
 &pcie0 {

-- 
2.34.1


