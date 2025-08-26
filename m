Return-Path: <linux-kernel+bounces-786865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFA3B36D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C211C415E0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE4D241696;
	Tue, 26 Aug 2025 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gy2ML9na"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B2624DCE5
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220280; cv=none; b=Vbval5P/wEjRJaXzpahGD0oBW4QcPfETqSOn2X0vucB97lXjxh6fBy7+udQAvUXsD8v48jomO070lLOcc9Xwp+GGaPl588NR20qsBoUPPYvHJvMhNtVhmBKV9fjS4vLcpR+TN9FAzFhZ0MxfXUor8POU9xF6M1iKEO+E3OhsZRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220280; c=relaxed/simple;
	bh=yf12NUbJlr5zt2ZgNH1/MSY3Qsy4n7BrLp67JFo7aRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uOP0XEttIQJiBohM95CgN2gFW8U2Pye8r1ypKWrRNpCiaBLOyh0YPTlaQcVu3dIy9Br7rg/VeY9pAPcx4aMQYtkosrPCQtP6BY+tjp4Jdw26V/ot3Vg2MDHFGq68ILK+PlGOolXpb9sNi7JRUJSBIjj20rHjVUfWlQ9tUHyXS+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gy2ML9na; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7704799d798so2348127b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756220278; x=1756825078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PM7ZOBxbXaYL3polB/sK+4dHFDAVqr3gYjlAgyAuBEQ=;
        b=gy2ML9naCcywBUoAjkYEcAXZHY/8FAEYV6GxwH9/S+MrumJ77IZU0P0ifjIHq+aabU
         Mx8jKaFqYHtg1cTBEgK+saP/spNZ4wE0O12nyvfNE9LfYEFgpYzMRknQ74rSM4SDWNz8
         WNrAyQDVpdMZugh27gqto7N9YGOeC8862+IYEM7UvjVe3ROBKMuS6YeKjqjAOXalvmHR
         7brTkWKWuDvypwa5OYOvZgjGtIYhol3635o00YAANnA8PQoB7BjJvxwVX9sDxsv2VNn9
         n/95mZquNSA3vqOiwZtany1ALjmSKOY1pPIMrghgrghD1GDQKgX63OWHSmPctqKsxAmf
         /d2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756220278; x=1756825078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PM7ZOBxbXaYL3polB/sK+4dHFDAVqr3gYjlAgyAuBEQ=;
        b=nasdR/eDb9Qbg+HryPsCbMR8sPd/NQOu8TlNKOzfO5/cx6eRio1BIRToLyytMe+Wiv
         v9932h04Bz4lc+xmZyLihGwU9HYbD2h+9XX2otH3b7vJxDfRaBseria8yCf24Cb6jMqE
         srNZSQqvTLu5Bq4/dPYU7RNJGXvZUQzyMtsdARNFS/MBsvAGCqdyRPUBurQJ9QfxVs6s
         VI4Li6qcUobaTmR3vZ/Zmny5ETVN2mQxtVSrpju1KNoJyz5L5zfwqj5MAao7C/U7j8Fu
         S28u5t6MYGHgwnXWjfmv/L397YZ4kMVYKnANWlPxnXAFM1Y/i3hVD2GoMC74FFHWszIg
         a1ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgBXYPOaeiOn1qFSwXZu6jpAUJy+dpNGmKXK0cyhNcbge4KVvWkjTSRFs8KNb+x5GSSQ6mYAGJIZbSDEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9kPpYN/9/qxWq6729iYEfcG0S/RbueCx5KPXhVbo/V/oUkHwv
	kDmXB0Sczqg0hSyiZ1kllCjUR9MkQ/QUN2e9obWgLClaHv/aAJBP0/ZL3jvXFwkQXoM=
X-Gm-Gg: ASbGncv/5RODqB31TLfnER8GT0nE5sfyATKTE/I+LvY2Wat+keylTkIi9O0qfBZgMXy
	9bJEvMmV1Uj4Pdw5FWUmtdTzscM5XqI9Lqdg/m4NUQ5V3l3MP4/KNWZ9Gs87X3uU5Gwgw/+E07N
	XXHAbaCivjGNCD/SISzODV+aAieVzIiOBC3l6LmuTCZh78tsXxSgnKdRaxLfy7sdLfc25CxXRip
	/TkBhZ6p94ESu9xBYBVE5mO8pO2vnd2FWdmJd/JsbcnKsdaW18X2RoOkqba7ocKIFBT219o+i8Q
	PWAppffH5Tj9tSSZ/cqozV+erEtfWgYj0AInKWpbqVGW2OjlEoUUxoIXnqx7nMjdlMecw+mZmDq
	NTWEH6QWpYB4Z/znm/VQmUTg4g/LG2tzvA+fkKNo4ftlqQQ9xppseoUdF3axc0KvFCWRuEZB9Ow
	+pvVObNMS3fIFFNiVjCEVuWip7mmMMhBiE1UiAbN0RUQI=
X-Google-Smtp-Source: AGHT+IGRZfzmqas8P2qIkEBx55WpUsJls+/G4WI+d+9aViOVixxjip0aXSAjUYjI6b7UbZ8AtePGhA==
X-Received: by 2002:a05:6a00:1399:b0:770:5544:dc0c with SMTP id d2e1a72fcca58-77055544aabmr13666696b3a.32.1756220278054;
        Tue, 26 Aug 2025 07:57:58 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77059928c5asm7209799b3a.1.2025.08.26.07.57.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Aug 2025 07:57:57 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	ajones@ventanamicro.com,
	brs@rivosinc.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH 2/4] dt-bindings: riscv: Add Zalasr ISA extension description
Date: Tue, 26 Aug 2025 22:57:38 +0800
Message-Id: <20250826145740.92276-3-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250826145740.92276-1-luxu.kernel@bytedance.com>
References: <20250826145740.92276-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description for the Zalasr ISA extension

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index ede6a58ccf534..6b8c21807a2da 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -248,6 +248,11 @@ properties:
             ratified at commit e87412e621f1 ("integrate Zaamo and Zalrsc text
             (#1304)") of the unprivileged ISA specification.
 
+        - const: zalasr
+          description: |
+            The standard Zalasr extension for load-acquire/store-release as frozen
+            at commit 194f0094 ("Version 0.9 for freeze") of riscv-zalasr.
+
         - const: zawrs
           description: |
             The Zawrs extension for entering a low-power state or for trapping
-- 
2.20.1


