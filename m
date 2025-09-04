Return-Path: <linux-kernel+bounces-799780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 521CCB4302B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40A21C20A84
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2711EA7DB;
	Thu,  4 Sep 2025 03:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7kWQKhA"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BD217BA9;
	Thu,  4 Sep 2025 03:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756954849; cv=none; b=VRCu9IkhjkHRYvoHp2ZOvH2BAWrOKLb9yQj3K1IDC8TypmDRpx8C/eEB0pvubUeD+OLb8KL5jP/kyMZwvxdu/nD1ozQmSR+iaj9OUoXxBpGCWSXpC8c4B+VOx0bpJQ8HcM7OYh6UuWcXZDPbaidSTagpdGtafKMbbIATvUEGcds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756954849; c=relaxed/simple;
	bh=fJXcIelCzSQ4ncGEXNsg2zBinjQG6alr/a+lwsBakRA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XYCP9LNgAAao066/NRX3bJYwes35GGUuFydpLxWwtFm60jk0nJnFjWSVZzmAs4awq6VOtAOVw+WItCYRgGbqtSHEpDauAPSQsNkiKSPGhqMV2A4YrqMpL9kUFfQqYc39sqEIL49/dW99zP9oCt60rTV3+54GfvGlOIK1EiVW5a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7kWQKhA; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-31982facaf8so219074fac.2;
        Wed, 03 Sep 2025 20:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756954847; x=1757559647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5jXeT55BnpUVCszwTrOGZ3L+gWKoVejeqfq+IifiGA=;
        b=Z7kWQKhAlltfcAEhxDCd/dgJvfYm5whf0L4ZbrMKDcuJz8+P66kShU8Ao3kc/RcR+f
         618OhGEDqdrdGYrKgMNVaxjivkSsG9Gq637jvbFG1h1+N12TWgEJ65SVNsfrBTV+9WWF
         MkwF0kz3RBplrcEIdi/NJ/R4J3FmG1reJBUPDSH8YaeW25wgcyD79qWt1SIXq3V+yV1+
         +pmDvfM1xy+sI5uOUu5M5PzzQyPUgncTANRVPbnEBltthQwfU9sDQx9Znjx22I6qUw/9
         I4ybJJ/puFxbo0yk5UNT6EnfftSWhajLp81ynYYxqf6PPhPrfp892MLQIxiwXcCzC7qH
         VBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756954847; x=1757559647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5jXeT55BnpUVCszwTrOGZ3L+gWKoVejeqfq+IifiGA=;
        b=fztrFHAwFj+VzSDXmQIHS7RVyltv1UKU0pB03c7bpZCLUJZotAEiX8jbdb+xME0FQK
         uxG0mtw42prnE1HMxDhAiWirpqDDOl44QZJothVyTGG2EZPXzPj6ZQtlVKTBUTCZ3w6t
         kipG9D2GVfqfAp7tHEftvogZaP6sr9LeqLTazB4U8ZjMQn/S2/vSOPUTxJIOBT40QoBs
         DggPQB22IWQmRc2GNlCB6T9Rz3nxfYgk7i/eaayeG4ltjAN0BZbZvIzjbOj15iGM345o
         r/jA9Wjz+GIB3Tjiexls88+vnZz4BEva9vsH9PCqjnH+otuKcBdEy2xmsLgGOS7FqWp8
         IqmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0qPKOeLEMEvpklrSV0JmXWHIUVvYKlT4EWgua75sx3fYkDocfkGxlcTOvlbikWnZjOUQa2MbJ3kZ6@vger.kernel.org, AJvYcCWEHWZUzFwzp2elh0+La7yhKKVcDxcNYq/yvi55kzv1zjh/RJrX/7+vUzsdZ4Q8yR8UWmpa6gzrQDqWx+j7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1KfZCQj1D5QBksWvxgmTMlt+2ajawCKqHAaYJ/YcNmL/NFk8V
	CMgaYzEbQV9KcVu2yCI64BYmR/7abibT8HsXMvw5E1U0HuXdnLm8O5aj
X-Gm-Gg: ASbGncvNNPjWDUUT8K9Aoxz9M+rGu7j9RkOJo6w69IL8Vipf5vp7PGuzn6H5EWwb0IU
	LHp/AVP1oHme5g91tITdYINMsmzIM1vwyuvS4q+8snQrLzt5otLaVy6BoYagv5uiPMcp8hoXPce
	ToRAqVOtENcHgqBTsZSe04WkrKA0GW12WDjDcCr0l35eYbeSb14t6cBNiH2zGkG8DE38uCgUuOs
	sedIePTcC5KMiGY2Ji/ft83yuSIqGQd1UMek+DURgPrDPJNsbNKMT+fxQ1AU7pToajTat4qCatx
	+/3CL6uxp8ZmmJYbSnHRnjFmHw+BVZWwRHv3LkpCJtzibO7/e6+gJAAAQ8PKeHzCar3X5xY4y0u
	EjleY1rlwpcs0NhQqFiyHoOqKP83Y/L+US98TLOvMJJQ=
X-Google-Smtp-Source: AGHT+IHlvmexbbW2CBYnIgaBbF+B/QOgH7eG7bUDWUjPCiy5DLQ8QKw4zT3k8FX/kgF+W7r/JPofcg==
X-Received: by 2002:a05:6870:63aa:b0:30b:7ffc:ee85 with SMTP id 586e51a60fabf-319631d13f0mr8794231fac.21.1756954846566;
        Wed, 03 Sep 2025 20:00:46 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7457428c153sm2570265a34.8.2025.09.03.20.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 20:00:45 -0700 (PDT)
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
Subject: [PATCH v3 1/3] riscv: sophgo: dts: sg2042: change msi irq type to IRQ_TYPE_EDGE_RISING
Date: Thu,  4 Sep 2025 11:00:37 +0800
Message-Id: <831c1b650c575380d56ef3e2faed9bee278c9006.1756953919.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756953919.git.unicorn_wang@outlook.com>
References: <cover.1756953919.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Fixed msi irq type to be the correct type, although this
field is not used.

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


