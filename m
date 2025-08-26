Return-Path: <linux-kernel+bounces-786596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34798B35ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7B3188EA03
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D89338F36;
	Tue, 26 Aug 2025 12:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF3Lh76j"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17169322530;
	Tue, 26 Aug 2025 12:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756210201; cv=none; b=JV1y+r+9kVHRNEJqamO1aiHnkfHiUlk0BsdGxGD++8Zmb1DsFloCSsGNV1PPlKZ1bZQPAqSjvr5W/FHyj3oBsjPAAnDNpjeWW/h5ulpd5VRmonVWEj6FenZioUXS00RbVM/Zyze2IdtX0hcbckDdiScoxx1lQ+DlAEDw2MlMDts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756210201; c=relaxed/simple;
	bh=CYNjF9OQgn4g6Ftiuun6/MohBcP92VmI1C5IHAHtgWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mjT8+o04xWvgBK7WE1xu4bpX+sV17ET+giuh+TosutXIFlW687FoMs8A7TrVHDUqZhfcVGZ6k8Mc97J1wA+7db/emL6r8YNKdONhN4rha3Xk9VTj6jSHvKsbcHPOlakQTBeL596MyG3NVITCFDRntgfcwm+vIbJYvZJbByytmMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fF3Lh76j; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b49cf21320aso3357767a12.1;
        Tue, 26 Aug 2025 05:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756210199; x=1756814999; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Te1xVrQgzDBuz4rdm+oAY4F74VBZ8yuKiz2U07Pbv64=;
        b=fF3Lh76jo7PON7hja9CkcywKaOEkklpb5AuzWZxFNERB5iNkayZ7Hugp7orkTRjuoo
         j8/m4GdqrkY0J0KwUykqI7Ho0qwxOdVryu1TWEA+yU8WYKTybOISj0PsKmQiC0CyrQys
         uZzYaYjF92ODdCfMSOhc+yJ9Y3Ogplijw0WFL0qmmYkchHuXBRundIeVlLSZBV58znSO
         7J2uN6EVRw+lQQK1haAmE02Xuv4UNnT3hKQUDI35QgNwWuftM+PtAY0cBsNi1roSggBa
         SwmgPKt44Z9NSgP2E26/PzWSqtWwHXAxaItX4aRxnT1P4yWaftE/LgGMgLxJdyYiUNkW
         2jLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756210199; x=1756814999;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Te1xVrQgzDBuz4rdm+oAY4F74VBZ8yuKiz2U07Pbv64=;
        b=C6RlnpYSp95tyENK7Gk5+m+aH9WpIVFE+8GDSZTna30zo+Uqws6oQIoadEOJ2tEJjk
         G8u0nNX/9M2umSKnh6+DhGHj9B8KetQ9O71SvnaS51XaA0kFm3j1TIDvZzwtXyWs9ZIX
         ghhyZjLf6XLvE7l218GJQCm9GmcGE2+YQGOmw/p3KHFjPFcJNATFRes13dJsIwqf4YT8
         HUo9tpXynt/+OlJ8VlJmPdvNAZeSwGjdz1Fc8zmJA6fnFFvoDBdNYIyH6m/Yaj1Zb92W
         LVC6IAKvfuTCOAPF8k6WwID8cdTgaTOh0NroAbT4/rNKB7/wKHRBwK1U0WBKKTvAMl7Z
         RLhw==
X-Forwarded-Encrypted: i=1; AJvYcCW9rB1VPVyIa4Dhtl+UspMYEc2RnqBPlSCqP6+K3sQulswybXspo5S5OkSKUS8DP7HJy9z74tv9Q8Evl62x@vger.kernel.org, AJvYcCWs3YBPKoNgIRDm9uSiE+SYuBOjr6knE+D6s6YOoXmOYL1Fo6ZIrDBF/W/AsUXcjZgq1vT78M7MP1iG@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwd+ZVbQ2GZNh7ghXZ6AytoVCZ41VTrX9ZJ8jh09+XYvFeS5pK
	2bVVJMwwSAjvEETB5Piujz6BGjZsswiOI/PgJnLMwiWmf7QYXRERMdGpSGFYeyIi
X-Gm-Gg: ASbGncsZgj+b5Mg2xkOs3/u9ctE+ZKWJYXwGF1Zt4CnkKBzUXyolOAmmnOjC9d/sMTX
	3GQ0qGgcmuEp9Y/zU1rW61nWL5G/OXKGJkLxWZI8zKklDrhcI9UUezYHAOIfI5sSm5hJuCbFHqV
	vOBDx6ETUJ3EpAdNNTyHRGzjzMRzkfOGjQFzJwoMYW9pcWhdkj88NtrzNAet4xqt2+hm7bXoPCv
	WqLPM46On10o+zUR8tfGtTack5CuAjKDHJ/tMnsGjWWoRlsRnW2iobgI2vwCIGz9GI/6aOLttCO
	kAYxX8CmsdFFZkjW6pXJ6U+hz4VuT97rEc/sRyAzLQLDgppb8g/yb3T6mixWwzrnChxXobnJmth
	vXDLqfq9CO9aH0fG/GaGFIlZvhbhX3Setfd8vmA==
X-Google-Smtp-Source: AGHT+IHtj4KgXbSqTdwrJl0C85JLO/ylMqNOyyNdi7uTUtfGcZME4gs+kyz2KM5t0aJF8T2+RPr03g==
X-Received: by 2002:a17:902:f543:b0:246:7a11:3775 with SMTP id d9443c01a7336-2467a113b1amr133955215ad.48.1756210198844;
        Tue, 26 Aug 2025 05:09:58 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-327565d3924sm619966a91.13.2025.08.26.05.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:09:58 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 26 Aug 2025 20:09:14 +0800
Subject: [PATCH v5 3/4] arm64: dts: apple: t8015: Fix PCIE power domains
 dependencies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-t8015-nvme-v5-3-caee6ab00144@gmail.com>
References: <20250826-t8015-nvme-v5-0-caee6ab00144@gmail.com>
In-Reply-To: <20250826-t8015-nvme-v5-0-caee6ab00144@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=798; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=CYNjF9OQgn4g6Ftiuun6/MohBcP92VmI1C5IHAHtgWs=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoraQDxO7Qv1fzxL96zHeJ8UWQtZ+jverp0LMZr
 KDDOuHgJf6JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaK2kAwAKCRABygi3psUI
 JEkwD/0QJJHfCREZw30/LgHOOZhIwxNN9/ncVeXksoFKhfe1XdfT0CTUV/5MqsZPYXRLEi5D90X
 c4b5Tg14SjloONpUPd4fFzx2pi6atWQ2KVETMATFdRbeA9D3hdnkAk5wo7K1NP8cKUHkreo+aH6
 OH/UZFBjr8Fi4ZQ55UHa8Y8nX/PHoXPpZd/0+g98pkIVrMdzcWRYnci9x5aKBF4dfryLJLytW9Z
 pLn2C/VEsZJAxWe4QZZ4KTcGAZAsVkf4ytvpi5S8NG3PNT5GiTemz5rc0oPz/otK6DS2NY6s3C0
 G3rGendudRTzg0AJRAoJmPNXqt5cN6Kt/7S+lGpRJV3avH2gDq2UPyxkHwK1cnrliUmec4WxOyx
 stFLRy1di10g8esevDN97RpmiC3NNSn5yJ1Xc7wsBl73EafjB3fytXW2HgkcypoZ090NlcgNRY/
 8N5bZaPuoLkWJkkfiqViehHAI6Si6k3w21NldiUzoaqegH+3OJS/LlMMPAEd5OUQNxpc06nRGR9
 nvWM2W+V8zZjQ8lyDpsj7V+wU0snKxVysRfkmkEUfhLCP5yEl2NQVKu5OMj+5tsA/cenjWLGst+
 rF59G0fy6vX+I/1vNQDwenNZMiHDFp6vX/1q6G65UQxxovLzQ6zqFmlwSQbPsofCaShSfAZXOsN
 7HK+Nk3zVoCnoPQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Fix the dependency topology of PCIE power domain nodes, as required by ANS2
NVME controller.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi b/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
index e238c2d2732f7944dc1f984a4eb647ba212b9ea5..1d8da9c7863e5b7a732888342de9d481f309edd8 100644
--- a/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
@@ -658,6 +658,7 @@ ps_pcie: power-controller@80318 {
 		#power-domain-cells = <0>;
 		#reset-cells = <0>;
 		label = "pcie";
+		power-domains = <&ps_pcie_aux>, <&ps_pcie_direct>, <&ps_pcie_ref>;
 	};
 
 	ps_pcie_aux: power-controller@80320 {

-- 
2.51.0


