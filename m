Return-Path: <linux-kernel+bounces-898206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57952C54990
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79BA3AC8A5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724BA2D97BD;
	Wed, 12 Nov 2025 21:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FstuIoJk"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688762D879F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762981979; cv=none; b=hZ/wRbTs/DxaWEteheB+7weFJ5yV7O5eki37Eh887AXEnUg9hEbAvx/09FLTdAJIW8isADPDoI+UvoxLUbN5mP4eqdd2ySkTiflB1CO8eFlTZR8ZyN0DZFA0JBGHDLoDOtSgsmeHo9Rm8MO8G6fzeR/REot2nskyaf2+7kl5SL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762981979; c=relaxed/simple;
	bh=CbgLR+LR4tT+7lEikMxwinz+7xt2UO1RFMUh/9q4YVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cnEYCKaU2J/bsUc3ay2DV15A5yI3CqXmvSgSunCbE3hWnpT9SmP4ecGXL4KuJTFvuCAPLbvTmdA30JzaXWjCFAGHeiYMNxJYo1rPy743Tr9uDMrFu1B7cAOR6izyQYo6CAHJk9EiYZZAfeZjrSBThveCO195TxC2EYiE92bruro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FstuIoJk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29586626fbeso883435ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762981978; x=1763586778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjuDF77Nvin9wqVFgToN8rViAxLn6q03uh/wAmweEAk=;
        b=FstuIoJk3NFaVJTyNOmmb3FtzXdEMTS0JzvO98sNNyb2+sAuvkF0aJAVX1dSp36v2q
         FrtKtyufB6/5YhBCLuTdd+ScT8iwbCf/SNbnk2h1m+zL9K81ZANfo447rYZX7aMolRi4
         XmyCDflLTuTWSWfqkJCrnPJOznhfXa4lVYgKcM9IixoZ07MhBnUnyIJAbNHDAjP35ySI
         8cNvqbXVMZJWJpohd3zoq6R19ZTJCw+UUvDoFQJL/4nmMOh9vhTZsCj03xZxBCL5aqIL
         C78m6OjwVDFnr/QVXfE2P1qRPHQKdikE7Gyv3OuO3cT+xHH+vZ4NbIX/F/PtH8utjHUy
         sP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762981978; x=1763586778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IjuDF77Nvin9wqVFgToN8rViAxLn6q03uh/wAmweEAk=;
        b=s4GdGk0PYJJCkM+NnSEH9jv35r9wxbTmj/pg8pb8FBQwxbL/PZnTLQfK+yyXKl/mf+
         yb7HIwcIPeV29TgF0RA4aXtUyOOaEc3iI0l70u+i40Hs8LCFQMDBnASzPDrhXIGrKpGP
         WwLScGm637VUY+Znn1Jxql6narVeDCmGJBh0UcfEa5j9hwx5s6unQqfD4Q0agMMvDX2G
         +Ru8YKHrSYwQRRekFdTuz8j0oQNxsr9emKOSE9ffyFczYqO/3aNPy/AgMtvOzWvQwqBk
         q54xIQ9Z1R1WRxf12ff54popF2dnvP00We1eDBuGK2XKLDACpONffem8fK59MnqJInit
         E0Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVzbMlpqQpAmYsKwJMnL0Klzp1HOUHed1PjatC4967Qz+AUjS3yIfZ2+qvaIL0tbO612d8ewq8wq5EA97s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsw9AJN3pyWSJSo0EqYWLCLXB2FPCH4/r1OsZ+mQrEitZTvKQT
	eIRFKvxccT6E/59YMsaxc6LBhYY5B6ji9UuXxOeEZwFdqOyyhGIz4eN8
X-Gm-Gg: ASbGnct9RRloNtMW9P8z7h4M6lpKLqiJ8MZz6LPtRWAJtJKXxOiI7OO0g22onuoISIZ
	g6DDnMpHBWAMWPo3TLa9pQKg+hnrwdJX12QKfscAAh5nASjSdssg/MteXz0k6jJ6iINNP/JflUq
	vpnON3/qEi5ArzvObDejxdFh+TXn6lgJgvMrDzzyiwRGXF94wIlH1KuFpdlOugc861pZCsbu4HX
	zv3FgGCQvFDtRUv8RAkfFOy+y6qjpje9fTmTg5K0FomV9mYcR4+ng0AJFegq8+EKk1ojOVqXQN/
	eFcu0uinquYdCg6VMjPGwbRftc/lclswM59sYwuF7xelsTqV+MUyx6qjsEdvbPHqrJUCqxrtvnG
	7BOY+ncwrwmsC4mmSZnI97T+Zi32eD7J9M7Jk3Bkbvli9WfVSq7e0VCqVHeWE62Mi3Ho=
X-Google-Smtp-Source: AGHT+IG+mV9xg3XsxHHZk9IEjI2mp5r4vWAmColXzizBEHkP0uzY8AdSktbXnLxB4bTq6cCi6YDFug==
X-Received: by 2002:a17:902:d551:b0:295:6a9:cb62 with SMTP id d9443c01a7336-2984edaa8a2mr55489145ad.35.1762981977752;
        Wed, 12 Nov 2025 13:12:57 -0800 (PST)
Received: from gmail.com ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245ecdsm1011525ad.32.2025.11.12.13.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 13:12:57 -0800 (PST)
From: Peter Shen <sjg168@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	peter.shen@amd.com,
	Peter Shen <sjg168@gmail.com>
Subject: [PATCH v6 1/2] dt-bindings: arm: aspeed: Add compatible for Facebook Anacapa BMC
Date: Thu, 13 Nov 2025 05:12:47 +0800
Message-Id: <20251112211248.3711889-2-sjg168@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112211248.3711889-1-sjg168@gmail.com>
References: <20251112211248.3711889-1-sjg168@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the compatible string for the Facebook Anacapa BMC
which uses an Aspeed AST2600 SoC. This is required before adding
the board's device tree source file.

Signed-off-by: Peter Shen <sjg168@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index aedefca7cf4a..bcb874ebd9d2 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -80,6 +80,7 @@ properties:
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
               - asus,x4tf-bmc
+              - facebook,anacapa-bmc
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
               - facebook,clemente-bmc

base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
-- 
2.34.1


