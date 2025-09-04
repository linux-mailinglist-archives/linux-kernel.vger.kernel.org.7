Return-Path: <linux-kernel+bounces-800319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EAFB43637
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5E51B22354
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1402B2264B1;
	Thu,  4 Sep 2025 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mjgvfthe"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B091B2D374A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975529; cv=none; b=m51/2+l4pngi8AM7JD9j+FxDR6s4PtsgY1YwGm2nNtcrV1GztHMTIkd4Bb705QC9L4rURJBDP3V3X6eNpSVya1PXyLnFQ8iBnM9jTJ9IOxFvKiizR+r5gWbG7eL6GZTy0Jn/1vjeWgLfAXinGF6+gQ+0Y0VJo32pF8ShbduJ6Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975529; c=relaxed/simple;
	bh=ZGEqH7zGYkqnFSi4rlrpNOSAhung6PJfCUWI+PnX5d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQh7IJRgIcwChsXxa/KTjm+qzzE3/UyGFxfHQpS/9Lht/5a7saSwxvvkPu32cjzqRmX3cDddxIs6YJGhPAnTlpGD9+levzCX1WM0OZoABjnjE9vdIuJYEVWJKcYOmLBwxNfjxIAyr3deZ5ULxDK+6z7Lf6RVqyMOSoA2uqyEoV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mjgvfthe; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61a54560c1fso181386a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 01:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756975526; x=1757580326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpo1jT8QicmRmcggPU2o1bfHtAUWdd2RgALld2UHpDk=;
        b=Mjgvfthe4lrT4xnxMQSZi1ExQ7eiB4T6r1Yq9pvAsNh9EJ/tM4chppdv6zPHdrBUJO
         Zjcj4OGyzvAiID9OPmvcR0IXTl7hrm5OOPM9x4w/JyLoFC1eUBhbIuoxVrihpECnKbwm
         S6nOknd7K18kvsPJJVHcZRrdW4SKuSQNEhsyaXuCYP/Cu3qIyvAF5QSWiTcI3BRSV2yf
         Y95spOdRL+rClzBPs7f2ggIEOav6+OUvqjV+qlAVK1PpmnaD/QN22EqNpt7gg1iTaVtp
         V/GPXTAj5zxby8iDWv9ZQA31lCvm6hB/LprEYomx29++CDVgnK7+GUI+e3HpFLDaW+fB
         zCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756975526; x=1757580326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpo1jT8QicmRmcggPU2o1bfHtAUWdd2RgALld2UHpDk=;
        b=u4OWxVJT6So+9sKV+g/8TqoEK8WiMMWhJfBVYa4FqAKRNQmKmd55RRoIenxt/SET//
         1UHWaF7FeRSndMRPgvOJNA+sTCI+Hjrxo2oPfjCTJCVTTAq/idHAnqRTZO5aTqsPG9yX
         VJPmbWsQ0fAviyS29lIMwxJjyXYMVEn/NXV6ern9qQ9xlkHGm1VE0+IOO8kmYaZZIYjC
         1z+wGIIKI0umuO5RSvZzvWKfp5ahj+lDduGjdSiBR+/tJuHsTKrDVfPoV27AaPbepJfc
         4hGK5xgXVY96FoUVBrwqUG/AiZfFm1yhVgoKhN4/2+EsvCE3JPGXBrrMa2x9XCrcbAXa
         YNaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYWn5YcaWgkX5o3ZokMFvVf13NbXMQbC7bUcaEn8Calf1JP96PlgGaiwMRdOrOAMVxJ55bxJ7VNrhbHlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgEh43pyQoIcl1EybCd6grahwuPxjX5/Od1nsMpbQ8C8YcrP/q
	N5/D9NHTqHrlVQhKEHmD0YOGNoTRCgOPVqeySw0M7JSDQ/Bva2G0saPvYETJwDyu5sI=
X-Gm-Gg: ASbGncspZ/zD48BoJ/gGLlDeT6RaDvcGhWZgO0mhp0y/tWwGX4Wcmo9F+LLC4lDyw9n
	L8f/R/g1m41KLjK9WJWG30hZJ2EAjGZ96ajxFPgio5cd1xhKL4r/KJP4G2xY/k9SrD3GNuPLN4c
	WAhb1L3uSlfdHrVbMgfziFKAkVjRs2WpbnVoeovsh2bJBbphXJ+ufDi7UfMF7EbJ6a66I1+2Gwu
	jX5lNi7F/75qMqk7Tzm1LdnZaAOWiyvDCC99AEeKPd1F4VwGD49PlgxYj3k0U7WFnSciF6IXglh
	hdasn8dep17QklUtswX6cND+lQa0+xBf6tWS8sQl4TbiYXo1ZEc1xT0s3XMrDiEtmYpAUDPEqHm
	ZDm25XRB3tyr33sE8z99HAFX64Xkd+UOelebB9Vs65f+l
X-Google-Smtp-Source: AGHT+IE3VdjWLOu6xIo8rIEY/sOYhCgLWevktG3rPpuCMabmQujVAgKwDckQsqvJYhFcJkQvWetMyQ==
X-Received: by 2002:a05:6402:234e:b0:61d:107:d0b7 with SMTP id 4fb4d7f45d1cf-61d0d612dc1mr10930224a12.7.1756975526042;
        Thu, 04 Sep 2025 01:45:26 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7ed1sm14209228a12.1.2025.09.04.01.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 01:45:25 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: qcom: apq8016-sbc: Drop redundant HDMI bridge status
Date: Thu,  4 Sep 2025 10:44:23 +0200
Message-ID: <20250904084421.82985-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250904084421.82985-3-krzysztof.kozlowski@linaro.org>
References: <20250904084421.82985-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=684; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=ZGEqH7zGYkqnFSi4rlrpNOSAhung6PJfCUWI+PnX5d0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBouVFma+h6JZWLqFpNS91mMYe05574SI438BPYQ
 Iyapi97XC6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLlRZgAKCRDBN2bmhouD
 188hEACasGVcudwsVYdu6N6YGVAycTiEivBNGZhcL+6QnP8jxD95/+rceGEt9yM+gZFpU9zu0NZ
 wU7dHyj2R4R/rOt7Ly2/EQ0AadkVU6Ofsm+ttRZJK/Eqi2jCWbDObjZE17b1kFfwU7H8dCdweBN
 A6Z6Mi21DBNtNf6hGT65z30FeCF9icstLVtPvwppH0HN/VeaFQ+qdRFBlNAXDObxpOmrw3KIizF
 WvVPJ0v28P8su9mK6wmibQNMMfwv9ckkGRDCfFumnYLFGoQj7QpouC4HXsugNq8AmI57nucYLQd
 B6bhstxvmo9JZRMZAXH6IPOBgHngtDE9meiLsOANE8a7znf2Y/RoI3Jws8m/ceJyaBAHuTDibR9
 YhgNh87yF8GLyMeRvuN2IBxH1RMAjP05yXVKK4ug3xhi7pTnr/f85z9kMpZAgHHhXIHeO6vWmNh
 dIT7XQxWuv9T5+q2PHEcW25g7eiAnpU8H1vwxm4xBBi6NBXjGb36RJ9sZt8jRyn48wRlUVLwEji
 pUM+Sd93oCC5SxjzVr1VSXUPcJrVU7WS81Bw+k+qza6d37+A48GYHa4ALAXGjk5+6sMYulkHVwL
 cjbhxuPuUn1EMiIvBj0iEz0XLg3gUCu5DtvrzkTPNcb19lEcqndww6AnScAYA4EkV1ggJ8OdoqQ 9IpQF3vSgFJRIWg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

New device nodes are enabled by default, so status is redundant.  No
functional impact, verified with dtx_diff.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 9c71de589749..ba6ccf0db16a 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -157,8 +157,6 @@ &blsp_i2c4 {
 	status = "okay";
 
 	adv_bridge: bridge@39 {
-		status = "okay";
-
 		compatible = "adi,adv7533";
 		reg = <0x39>;
 
-- 
2.48.1


