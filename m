Return-Path: <linux-kernel+bounces-785768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB85CB350D6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FA6E7A9FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 01:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777972882D0;
	Tue, 26 Aug 2025 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfvwAeti"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F741D416C;
	Tue, 26 Aug 2025 01:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756170621; cv=none; b=t9ziuvKsFJRk8kOQRBdwY3J89DH3UzZ0O5q9x4WPagE7PhBUjTN7MUmZt8lRq6E1rFS75N83mzcT7Ih086QBeI75RAj6FRlpfo3mPe+FXcc8j3W+KSBsGx3Y3SVq3lgbU7RMcB62H2znUJ2g5+CKDN0hALBhVTAGo/mjXRX6sQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756170621; c=relaxed/simple;
	bh=BhPG4H+I7zDs8dwab76+BoAR+ozvEKZSdpitJSyJUkw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WRlFLobthaiCEBOAOtGvjuJ5jqLnUHKz3iaGL27w7Oedj4WCPVT8h6seMqrv6QmYlS+kNIHQd11Z0hjRaGobCF3sPtz6cxC7h7F2As3Asuq0R0tBMkGZwITHqkcb24L80KiXb24HCbL/976M7XNtDh5n5Ps9XjeiRQAq+bn9yEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfvwAeti; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-435de5b2f29so1537050b6e.0;
        Mon, 25 Aug 2025 18:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756170618; x=1756775418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/Iq+sl3J+lnpf+wc6OQRiTYktTo8qUO7r+bK6zwUBU=;
        b=TfvwAetiN+TikIiBko5Y1DvrFnFukd4ZGXSuFhw4iOCquFBgay1NmG47AXzBYadcOE
         4kVqKp+hH+p0XXYuU11BInKOb6+UuE8K8hSn7fbLsBEaRTuuRwx8OyCOlGpSMU/3GFyi
         OW0DkF7UfnF+KN0NGjMu8AvVfeJVQLJaS4h3QwE2LeP0x94o4eQA35sjQ87v5xR3Sg0c
         pwDDkBcc1mHszcqihZbvlujqAbYpkbhSSnLxi2I36ylyMoXwQisuDGPDq0MLO7AkwPua
         BpzeUaOVhOl0TD2dUaHLerjakeHq4CTt9UhhxYtBUBF7JrW+M7OfbPAIRy2JjmcUSgdz
         Qb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756170618; x=1756775418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/Iq+sl3J+lnpf+wc6OQRiTYktTo8qUO7r+bK6zwUBU=;
        b=WyX9Hg87Orce8VcPQTnZnKtJBbEdxbdXmbSCTJNlun2nmyaRVVqEulzumdxskkoKx0
         brW4FND95Y01klQclfq57APN8J+pH1RjDXAFwpy93Cw0ofxI5RPwPpozqrGzPykVtAIt
         V9C3ESHyQUmSmDhIY+xgU8gXvoiUBWYqlcvdxQK5L+SvTI3n6uoRtK7VoXrBqXMStPG2
         RYQsywdviEJVpyhYf1zGvglOvxhkO523JSYkXsHIuU+yqaZTmnb+d2MDsllfeWTmuDHX
         wskwDJl31aYxjwVlXGdBnOTyQnCifvuqfNa+/S1+ky4LjjUnWfbf38hiSmUKmUtMNMJL
         zFPw==
X-Forwarded-Encrypted: i=1; AJvYcCUOY25RfB8AyyGuSsagoZvxbVhG8ncJ6szQvT1RExeHTuUlL1DFfB/YxL5IuaOjA3+/867+YerFsLJC0WPM@vger.kernel.org, AJvYcCWukYx4veSpzuX1xGTZCtfWeTWUZ3WvEPuBHtpAS2GmJTg6YfUkxW6Kw0di9AvvsDRhMCg0OB6hGZgj@vger.kernel.org
X-Gm-Message-State: AOJu0YwV/BfwoztDoM2sPB7KTcRkmjRVpV9y5+yFZrub81QRZBOqKhj/
	BEXWGq3jlXdfriqHMxn1yeR1oJlzl5zrACHTzP5bYSkKzV0clMnn9str
X-Gm-Gg: ASbGncsA5VNbch9pVAaxojmVDb46Y4rbLTl21u+GO6VZmSfRZLZBs/aS978s3xFTm49
	EVdLxx9hi23zoHLbNrI+QI2un9+kvDz8UAfAGjVS5DKo1KiYWmIBpnnNKpaywFNdle7z7Wi7uLb
	PDJzTbWRmQ9J96DKeuZAHwtyXG72fyB0ZtCOncd2Jk/NfPHsZzj7NNrxOnpvx394CIcjU/5Meuq
	cOX27BnqE3ywY6lUbk1Lhh7KZJGgEnTkEAPSuiux7iLZxNsl4ueVAnw+Is/zgH0V1/HGIiht1o/
	4NcTh01LHLIXyB0ogE2BdT7TwVMd9Gp5cLe3WYlHJ4GYm45OpxEgzNS2IZsl3BxLd3HRCZjr7Ka
	ntui9ryiKkzLvVQp8ByM+icJxs3O7sA2x
X-Google-Smtp-Source: AGHT+IElnibKn0kJO+4EjW9DXM+SobqgRQIgDWBiXTLfJjdn8m2ppBqLQoVrT6kVdtQvj76aRcVJlg==
X-Received: by 2002:a05:6808:179a:b0:437:761b:dcd with SMTP id 5614622812f47-437852ad33fmr7337517b6e.44.1756170617942;
        Mon, 25 Aug 2025 18:10:17 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-437963db10bsm1352616b6e.0.2025.08.25.18.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 18:10:17 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	inochiama@gmail.com,
	krzk+dt@kernel.org,
	looong.bin@gmail.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	tglx@linutronix.de,
	sycamoremoon376@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev
Subject: [PATCH v2 3/3] riscv: sophgo: dts: sg2044: change msi irq type to IRQ_TYPE_EDGE_RISING
Date: Tue, 26 Aug 2025 09:10:10 +0800
Message-Id: <579f5bc7d060701cbab1046c3b55ca0bec15eff5.1756169460.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756169460.git.unicorn_wang@outlook.com>
References: <cover.1756169460.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

The latest MSI driver will read the DTS configuration to set the IRQ type,
so correct the IRQ type in the DTS to the correct value.

This field in the DTS was not used before.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2044.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sophgo/sg2044.dtsi b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
index 6ec955744b0c..320c4d1d08e6 100644
--- a/arch/riscv/boot/dts/sophgo/sg2044.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
@@ -214,7 +214,7 @@ msi: msi-controller@6d50000000 {
 			reg-names = "clr", "doorbell";
 			#msi-cells = <0>;
 			msi-controller;
-			msi-ranges = <&intc 352 IRQ_TYPE_LEVEL_HIGH 512>;
+			msi-ranges = <&intc 352 IRQ_TYPE_EDGE_RISING 512>;
 			status = "disabled";
 		};
 
-- 
2.34.1


