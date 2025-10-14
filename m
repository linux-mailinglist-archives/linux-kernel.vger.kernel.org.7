Return-Path: <linux-kernel+bounces-852928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FA5BDA429
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D52D250543D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5346303A0E;
	Tue, 14 Oct 2025 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQxqfGaS"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28032302CC8
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454327; cv=none; b=iOyimVsYeEUn78xlbtcgU4p6sAHL3mwYLoJxIpEcduaYzmpsyA7w1w+piaG78Te3fxzJRRuovhJyFovr0J1DxoVOAo+1fgJWVBL93GRSgifDq7gvvSnKeNG0OYYWgYUuZZG2xXjYym/5uFKt7USoNmM92PBbL0D9TUFNeUTFZrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454327; c=relaxed/simple;
	bh=I5bmZCvx8lSOgqzXisEWeIL6b++oNn2j9gQ7uou5JZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QunJ2a2jMQRYPtopAMp7s8Ab2EykTP1IM6N4fp289fz+wwA2Q1dNGf1wS8Am10NwujKwIIJtLNRnUEiflWFUWrff4BUMo+NPcQqfFanHIIq/ESUsbofub1KTQ+zvQIFDCqOwEjLmWFEmqNPD/AM5wQvoZrZ5emIgSjUXHcC6TrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQxqfGaS; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b632a6b9effso3354311a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454323; x=1761059123; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7UzRpURIuRgTvljraCf/vxpCIMLGtFavfo4dJ3/GB8=;
        b=JQxqfGaScJYm3mojr6oCmF8adxLQP70AM+ea5d5h6td4HjftWHiS9PXUa2K51BAWJo
         PuQ4gTBHBeTYwp46BtafoWk5miNkp/BkStHyqyF+qTuJBDF0KkLQY5PbuqplPUK/Bn5k
         lYFLRxNa6Fwqscab2Yv6E1MBWPWUg6bd0k9xU6m4qyC5fzZctQ4HtfpIjUobWmrRpo0C
         6O7ZZI7SrTP27UeHqR9aGKHcRNv75V9/jQ6bCc7IB4id7z6aPcKfIDVGP1N7ly7l9iaT
         P/Ph5w5M1JKMj6MFIH5YSpZK23BpIJa82J33Q91sBAn+1a1oQwO1/NG/fMyXpnCMpFJD
         wYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454323; x=1761059123;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7UzRpURIuRgTvljraCf/vxpCIMLGtFavfo4dJ3/GB8=;
        b=KBKMQLm/wNAVG+3dJClTGB9oFXpXImV0kBjk8iBpUyGpHzKu0LEMV3dEHiqo2QbTiR
         OK458NqD74uWMb5aLdQPW3WrHgn4gd7yi+zNKtHCQ8DF9fTaYZROW2XJaSzKyU9cL3eB
         cHTZzRc2xmqUHEtsGuRWjWzh53mEXxYOju3bVUycOc1f7bfNhbVBsrWjNKIJ+soCkOtt
         M3hgfzkDNL8tT9yk5KfFdfnnnb1d52Nxm5fhgq5b0mVinDs7kFLH9xTDoV4vnOG2QphS
         hG7STs+CwAHQkK8yNIdqbBLVmvitrYKC/SlgEtV/xvgFgK460a31dXZJUF1OJg4wbsqT
         xOig==
X-Forwarded-Encrypted: i=1; AJvYcCWvQlAjNZH+dVu0UfDqcSHOlkNtH86TC7VjAxjnZ71jf5aHcbCj9UwuEMcug6zM1NEn4jnEFbaQCLurj/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuS8vky08fsDYorjfJUZTY0rfMgR7r1dh8b1w68qHyJz20K297
	2QgLHG1gvxMya9cntn2acgzfExNpCt/68cCc3dqWF/t2mafx10+uLa8F
X-Gm-Gg: ASbGncuIEW2XMbc9mmJzFXs3/sQa7VgD8jggd2t1A/iATh1iJ0XZVIfvKF+FpBJBlGA
	/SqGBFVqurQb6/ganSpTbnkfo5nkx2fYQk38j5QA66jNv/pfMHS7OqtDMw7+nxJQlWpyghwSMT4
	rGGqqd5besPW/X+rz2ncP3Qawtvu5oQcHIQjc2MfGqcn4HSME0XuoEic3Y6V+DqiDPmxhxN+nED
	CgxdrwnEvidtp6DHjhwITWP2wWqTH2EeIMkBL99Qz5i5aFFLPrBxseQrYBh+YlYS/DiYYlMKpIC
	g/dFkaR/RWTq93OggM77Hq0eLcaVoVBCKAnQ2+HfIG2LaX3gnFlRl3abehNt0v+KfOmxhHBIpem
	UGtuzx7wpXAepUd2ePsC8V323plNyRUwcl5kN5mSkkDQ=
X-Google-Smtp-Source: AGHT+IHWoti0arhwAJ8/ehOp+A7jTPL4DfjepOYMl0fCMINaTjupjut/t4zvp2r+UEnm0n+I2R1stQ==
X-Received: by 2002:a17:903:2b0e:b0:254:70cb:5b36 with SMTP id d9443c01a7336-290273568d8mr282473335ad.8.1760454322930;
        Tue, 14 Oct 2025 08:05:22 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d3cfsm16258161a91.2.2025.10.14.08.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:05:22 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 14 Oct 2025 23:02:51 +0800
Subject: [PATCH RESEND v8 18/21] arm64: dts: apple: t8010: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-apple-cpmu-v8-18-3f94d4a2a285@gmail.com>
References: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
In-Reply-To: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=I5bmZCvx8lSOgqzXisEWeIL6b++oNn2j9gQ7uou5JZQ=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBo7mZuYkjRFb4PXdnwb4fw8h24z1bFwhtr/DQZY
 FpwFq8WkAyJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaO5mbgAKCRABygi3psUI
 JPvuD/9ymjV0qW8N2VaqTxRqTnf7Wso+LimS4Evbq267jx0oIEEuxIAxTGDbeQWAWyet9DAebNA
 tHZjixPKFbR2gP2QQkaVW2uG0jZ7xSumkITy8nVtog1K6USKN06PNnE2L3D9oAfhg/kFPhym874
 eY3cdNGD4yoZhDeH441f44UswbG6ioxOJFOJQvBtWvwMRr3M4pX+6jFutcsAy9hyd1bAG99Xfqq
 A94kTQmdAJ7IWGM2LsC8gKNAaQMTdlQ5pGI8mdVDLMpT10fqOTt7sUk9SvMF6cffSuf6t5yV2fw
 HAnndoskEI03SeHfRmAqLzonuDsa1I4NQxmRZMUq/DsGjoBMr6nHp9ChSC3ve0awXWQo+0oeobB
 6J0CpZ5KYPeluNH1qA3WdyRWLIp8nWZwFe3SvuSUWUpJhSrB2j+MoBxjPg8gbRnGgloqHbbe8RO
 8jjLSG3KQ9QBRt/dAkIxfkGB3VMtHSz1Tmx3ElsmxIKdLPIwmQTa2DlqERHfztZW8lEQPyZwz7I
 12zfqcYDWhn87u0lyqFVfUZ6kZcRUx/tTBSLp1fjXm5JRJ2KmTb7EhtwHmwQOP2lcnSMpq2opY7
 d2UZgRW4510C4wxfSWVNPuZfSVJxaWJM1UiqpE88/hPoMl+WY0g3i/R6/wBuCiOrq1vmlW4fqrj
 4j5IZLtJeyaobJA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A10 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8010.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8010.dtsi b/arch/arm64/boot/dts/apple/t8010.dtsi
index b961d4f65bc379da3b215ca76d5f68691df06f4d..d187fbf7e7a214cbbc1027034efd0724ef7f8b83 100644
--- a/arch/arm64/boot/dts/apple/t8010.dtsi
+++ b/arch/arm64/boot/dts/apple/t8010.dtsi
@@ -256,6 +256,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,fusion-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 83 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 86 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "t8010-pmgr.dtsi"

-- 
2.51.0


