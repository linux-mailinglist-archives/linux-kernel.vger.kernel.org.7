Return-Path: <linux-kernel+bounces-817869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 325D9B587C4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26D1483B8F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954232C0F87;
	Mon, 15 Sep 2025 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxy9qqDC"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EA31DE4F6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976388; cv=none; b=djSC8IhJ8zoUuGcDq6PacesFseLXl2M1/7YJfn2VbrNDTMAOecQyMlPzaMivHYUv+aFfNaCQo/wex0k4xDuC45j/wTP2zMQ8vRPb4omaxw/qSHey+YUB17GCwi7jW9OeIcUnodKdTjb8xMewGzFOH/3GOnm1CuZ/CLA7BWkgUJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976388; c=relaxed/simple;
	bh=dB1OztffTtPLQ8svUIE87jrVQ1xV6M40n11vNPdAgNg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e4MHLYwoO12TNXJho0neNx0hPAswHQgvy+8VI9KvQn6RVaeMCUo/94NEbI4Fpvf8HaLMAqU4MCV5FtQEcn7YuTCD7ntYlCvnhz4XxP/lBXoHI4pe1slPiTkYB74N4W6ExjNpojJPCIRH0T2sapcd8K2NZ0JMFDS/xnuLlcgX57A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxy9qqDC; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b0418f6fc27so811431266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757976385; x=1758581185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=13DnP3wRqU+zsSJbDDW+krsmHK5NNVJV3DHwW0NPTaE=;
        b=lxy9qqDC3Wn1IY6PQvredi9lqe2f1ycqtbmq7+G8JRpP7X1w4oV74c4iKALqEZubZH
         HvC4LTaSO/zia89FHOCR2XIrYzWqQgWIq67MiFa4LIb8RHK65V54160vxGXRvL1jF37c
         GsgvKjZWxhdUYKzMwG49Thjjysr/IoElTjCiF3zn5KUHbp/zglbmT+PnUuPDyDiAzlWT
         1z8Nm5qyjx8L4/JQv9EmOJaac+RkdzUSRDOS+mCMUtrdYfXE/vH/XfGVS4w6f4nUDq9h
         r20oo9ha+vu26NTI83ZD1VqFgMa9j5xwROHAZi5MTSjOoWvpw+fzNrO2ztjMyus1ZI6f
         dSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757976385; x=1758581185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=13DnP3wRqU+zsSJbDDW+krsmHK5NNVJV3DHwW0NPTaE=;
        b=mcSQWMSN+3+Qb4iq9j/I2K6Qz+VLjyFu2GRnX4+Csi3Qlnt0GUJIwLyMH0kZHaUIQ5
         lvGKBoII7SuWUPvjVaUL+LiF5D6GwSIH7uv46mXn8KjFrH4gaW2HsMsFM9ro0aVad8bJ
         yAHjTwmUx2w/LS0VqtnnKs7k5pMhZ5b+ylWN7ZQnEGuW2e9uh5Ve2SMUqVGhx8tM8ScW
         XV1nE58jj75w0r1ob3Ktst6ExC8+dbSu5y296BJGblFuxvb2TVYe7H4xB4LrbjMrYPk6
         7cIXLij3YD6MErj4ksJxwlzqacKC0ry3NFxs0tg9Mu/cyqQTPpU5BV2rmMSvnhnpxaJN
         Uoxg==
X-Forwarded-Encrypted: i=1; AJvYcCXNf1n0BTprfYMBmKLklxLPJmkxW8DgGt4nKQQP7W7f/d8TZrr9N3PM5JcU4mC34FoQufBs1R5JnRQyNRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVela5uV9ZE9duXF3VkTVtnpcRmkY7NZLcoLywc6b5TCb2iE0y
	Y1lTrchE0QEuz2gPITzl+04P56S1w+OGLKjOhW7+0Ya4w7qa2nD2kcw=
X-Gm-Gg: ASbGncvcalwnISqYt9R7Tai/XaYqGkNVmT6GAW1FfqlR/T4b0LHbByIDWH5+1791TdU
	DgOZc/9BZC3YKndzEaMYejlhaDP+dRaw1L2nM4AJ4wngD8v7i0F3Bd+u+ROo+JZCA+TxJtm27/7
	qvXG0+yCGkm8dH058rRABsE99jLAoASNglH2p16QcrRA5XLJ5hASe5dy/bZY/2Qmnr1ph+C88ED
	5WjOHPbzle4Mn+3peccvgi6sTAhNfynXmZGrZleVgWGlhpydv8QulXX/F6ZKHkbqi3ot3ZnSHUF
	3LkIJwIXyEim+IcEmuPr/5jI073RECuq7PnoIx5Q5dKcJdBowHDcCuqB5w0mIxVIGbtl6mv6DFs
	gB2SdIQUAxgFWemQuhVweliVomO0Fzz2lH4amOxBxdjl4rZ8=
X-Google-Smtp-Source: AGHT+IFC1RDAQdftftflM3IR9GIxbYxiAqxOMxHqEUoMHehF7YawNWtyqMfqbQIPOxJCVyY9vyzwnw==
X-Received: by 2002:a17:907:1c9e:b0:b04:5385:e26 with SMTP id a640c23a62f3a-b07c37a7fcemr1575363166b.58.1757976384468;
        Mon, 15 Sep 2025 15:46:24 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:214e:a6f2:7d6e:32b1:d615:2ff1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd5bfsm1011153366b.63.2025.09.15.15.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:46:22 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: robh@kernel.org,
	s.trumtrar@pengutronix.de,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH] ARM: dts: stm32: stm32mp157c-phycore: Fix STMPE811 touchscreen node properties
Date: Tue, 16 Sep 2025 00:46:11 +0200
Message-Id: <20250915224611.169980-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move st,adc-freq, st,mod-12b, st,ref-sel, and st,sample-time properties
from the touchscreen subnode to the parent touch@44 node. These properties
are defined in the st,stmpe.yaml schema for the parent node, not the
touchscreen subnode, resolving the validation error about unevaluated
properties.

Fixes: 27538a18a4fcc ("ARM: dts: stm32: add STM32MP1-based Phytec SoM")
Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 .../boot/dts/st/stm32mp157c-phycore-stm32mp15-som.dtsi    | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp157c-phycore-stm32mp15-som.dtsi b/arch/arm/boot/dts/st/stm32mp157c-phycore-stm32mp15-som.dtsi
index bf0c32027ba..370b2afbf15 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-phycore-stm32mp15-som.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp157c-phycore-stm32mp15-som.dtsi
@@ -185,13 +185,13 @@ touch@44 {
 		interrupt-parent = <&gpioi>;
 		vio-supply = <&v3v3>;
 		vcc-supply = <&v3v3>;
+		st,sample-time = <4>;
+		st,mod-12b = <1>;
+		st,ref-sel = <0>;
+		st,adc-freq = <1>;
 
 		touchscreen {
 			compatible = "st,stmpe-ts";
-			st,sample-time = <4>;
-			st,mod-12b = <1>;
-			st,ref-sel = <0>;
-			st,adc-freq = <1>;
 			st,ave-ctrl = <1>;
 			st,touch-det-delay = <2>;
 			st,settling = <2>;
-- 
2.39.5


