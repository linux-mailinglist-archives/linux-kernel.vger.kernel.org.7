Return-Path: <linux-kernel+bounces-784123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A098B336FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D30189AE91
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EFA28727D;
	Mon, 25 Aug 2025 06:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCMToo7f"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793C6287257;
	Mon, 25 Aug 2025 06:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104993; cv=none; b=Oe3bupmWd2pccM7S1XXOPlRPDp1c5j6u/rDzn6pq/iOWZW2uO9gRb2FiAwnXY59htAeBBSQP9qj8l5Y91hxKyJmrrWBVHRxWqH0XY+IPtu3XpzxM3UB5X4ZOkCG8+WePl1/Gmqay23fDa1JzuoxC7J5AQxsJ7aF90FU73TXLDCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104993; c=relaxed/simple;
	bh=cnETHiuRSssaBEiTgdPtwlHAn/fBOMXmkTLrBzYJ84A=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z81Ww/SDRQFRiXJ0zFFi6Nc0nbT93dX1YhOK9z6gY6pzg53mbk/1yeSpKP6/YDlyLyIaM6eR2T4fbIvhqbyy2uPW+xf6hnT/Jjs2nOqhjxQbR30TK++7gzqUWsg8L8fP04vYu4GE6bCINZv4dkmmnePeD8UAW34oZVkwjU4aTBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCMToo7f; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-31524efcfc6so305465fac.0;
        Sun, 24 Aug 2025 23:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756104990; x=1756709790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fr502dmQ4odPuahV9+jfQPzgPn5kXy7yEDTTv9ShcH0=;
        b=SCMToo7fFiGoQOuKTCkgwx3/DzlWGK2KD6lU5WwowHPxkuZ/mUJ3So7BXaDi1kPGyK
         98DBh7CvSqKwU9lk8CbpR6PgFjHzMRsu0ZK5P5UNZpHgNxNOdRWmwegqKxoDiJkcaKY7
         r+4OdnwTirJL8sp7yUgVsTPO3NAFIxRMBwzAeBGh/UMZzlm+AVG6a2C5LgiEclgjYmXo
         DKdijwfTUxnpOmoCQSq4rXWPFacFHl5C9/23irI/zcukII7qBHuSgFrCjp9MnQ3yb+on
         vDkqDBUsZVlZMyB6eWzSdk+0cJBlYxI9uuW9lNuxeJUtn1MMdbM8YSf6rcB+dLgJZyAu
         kOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756104990; x=1756709790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fr502dmQ4odPuahV9+jfQPzgPn5kXy7yEDTTv9ShcH0=;
        b=nEi9LdUCc8GY0/TKC49TY0N4xNltRsi0qTUiQPY9FOsOB98S9LkeHNGaOwc8EcEDjS
         fPwleL1m00G1moGh4XOXmuJXzqe9OpLqrhGjm86ab2aCobZ1DAdwyVDoOIxAm8V/hqLW
         TiEyw+81qdB0arkMsNZ5SW+/iaTqxn1BQnPHIzEzS6SwFcbF3GZiWteU46wbhIlubTpY
         jEtvJofR3ZSxF4WayVy3K71HMip+rbNeFZJTTbn9+Kn6pL+ZDTrF+TXw5/N+Orx/Nsui
         0GFgKUnMYL04PUYRKQ0DmfYG0qQkAB7W4GE3TKnNIwhkLusCzPpnrYEmDpMsq7itP+be
         shvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFdYN94YlcZDuAtOA+BDnoL2Szf9DuA9a3UNqnsBv4SP9ARk/kQB5C+GlBIztGW5OJbGOpoDtmGTLfnWTB@vger.kernel.org, AJvYcCXiYi5QO1cz1gxIiu5y//vZcfPtt46lMVkSdeCDtv7Af6+KwDHD1/37zQCUdOD/r1I60/N9inrfqfTN@vger.kernel.org
X-Gm-Message-State: AOJu0YyARwlJeqneBoKdmrmPYN+wguIisRlJD10JvQHy7p/hDWqEbmoM
	oGfdGO7+1Rg5OoBTp1cz3K2WUjZhFqY0mJIRzcnrSQJ6ZB57/0DI8ims
X-Gm-Gg: ASbGncsAQxtKxlX0KGznUmKxHyzgbyzq2Gf95xMtqBH6Kt5fSlsRa7v6xAauzzffupf
	3dDE4iE3I8BI2KAG6KYLDejw+eBkvKI+x7tpt3/OR8mZPz/RFPYrxtYRpQLPxBSS+UefzfN37L1
	hfecpzYkm+NsvKHgM5g0Z6xsGWpsNwPyeIgWuzGWxTk4f0cnCsKX54V1M8LkDi4S5wXFgsqphNE
	yxSdOY7nWhYCBf1mOuNOoXqO8vODF0rpqL6xSKEIU1X392jNvuVLAqS/SQ+c6tbbLLYOQyAhkBb
	OjNtA4k9VVzhzgIe1yuwBHgEXopms1xbF5gFPwd0iAWGL5LrPo4G3vuqR6xFcezkT8K/w5BAWY4
	zms2I+X5QGxUoHyV0g7udLZPpwimRZKFf
X-Google-Smtp-Source: AGHT+IFR7r2iERKhQBivRTMEUEiZRAfQkh3FKggj/0CGOOtJuAdCOPNqJjADbkLjgPMG1RSVyRhGKQ==
X-Received: by 2002:a05:6871:3a1e:b0:30b:6e6e:3477 with SMTP id 586e51a60fabf-314dcd2dc5cmr4797064fac.32.1756104990380;
        Sun, 24 Aug 2025 23:56:30 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-314f7a21bdfsm1630277fac.8.2025.08.24.23.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:56:29 -0700 (PDT)
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
Subject: [PATCH 3/4] riscv: sophgo: dts: sg2042: change msi irq type to IRQ_TYPE_EDGE_RISING
Date: Mon, 25 Aug 2025 14:56:22 +0800
Message-Id: <6cfe6dd32d875fc6811d74d15afe8719d2368308.1756103516.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756103516.git.unicorn_wang@outlook.com>
References: <cover.1756103516.git.unicorn_wang@outlook.com>
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
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index b3e4d3c18fdc..6430c6e25c00 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -190,7 +190,7 @@ msi: msi-controller@7030010304 {
 			reg-names = "clr", "doorbell";
 			msi-controller;
 			#msi-cells = <0>;
-			msi-ranges = <&intc 64 IRQ_TYPE_LEVEL_HIGH 32>;
+			msi-ranges = <&intc 64 IRQ_TYPE_EDGE_RISING 32>;
 		};
 
 		rpgate: clock-controller@7030010368 {
-- 
2.34.1


