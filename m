Return-Path: <linux-kernel+bounces-752961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E08B17D14
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F644E3FB0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F901FF610;
	Fri,  1 Aug 2025 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="M/MwOjud"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062C51F4C87
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 07:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754031717; cv=none; b=dUviiIp7x2lUkfqkazpYl87J6yIkvw+WAMz5zsKxV/TqtwsqbQVYkbnbw9XfLwcbdR+bvRMDl9Um3m6OGnnAOzH5tGvCJP0S1qlGMGvScdNyQ10ctfvYKaVeKeDbZNww4bM52H3Q4yHDYYEj1UZdDgqaSgmCHA3YIhBzPYdj1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754031717; c=relaxed/simple;
	bh=1gtkaxU8lzB24bYfFWeTLEwtt6GQeplprUCDPu66xiw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=XAtohtIdzYBu5OIx+7MwLbCcmcYZ6WI+jWQOTGSeQDjGvLmo4JIEEdlLdgdft7aUlZS5FD51Vtthd7XKGk+xJwBD+JPOnsBtD75SlECYPcYrrkqPzW3TiVGR/IomxbXeY1W+0Cv5CmmGCmCvHqCn33Ol+nqVFTres+aUwYUbw/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=M/MwOjud; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74b56b1d301so315900b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 00:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1754031714; x=1754636514; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1QL6HLqz3BETHlGyW0GKYu0gTqBWZzWd0eO80if9fo=;
        b=M/MwOjudFzeC8iBaR93ZlxU6voL9LI10OCXKnWwddZuotrC3mYl9Q9X9PlfPfv4m6k
         MaiI+V7ETSjzaO9PcTSjCmn2D4GGf9dgk8Vzp5qALhSJEKgldoBlxeTLQi/5FkWN+VzJ
         4IxUCZxGdZWhQr1srKDXZ+TJae6GVvmrvLTVp2ZBox2Mz3qVESLJO+OoJ8Qn5Kv2IySD
         +Gj9MpW8IDUgiSqn6E47lest/lep6EVDjin5hbZ1ptEc3d4/Z3rLiI6N/ZZr+KBO3gVr
         1fBFge/3zhPIrfnxi7CldYAAyL0IAVdN4lClHz3C2Af0Yl9A0NQgIVLyWPBwWD9ROhc/
         AI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754031714; x=1754636514;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1QL6HLqz3BETHlGyW0GKYu0gTqBWZzWd0eO80if9fo=;
        b=ix5PH8uuK6kCb0MKgwNyOu1DvPl2HwLD07nL02w70n6gzQYVWTmaj+kY3JrYA/HG26
         1QASXjcvuw2zHoyXBVsxSHDscYBh00XfY5MUl1/soyj2BswUtXdt/NtPcqujr2QnP07v
         3bRKouzTt00HACvemdqAeGwv2uXTPO6Pi5hLBEaFOLctVgKwvAvoxbPprj9w0vJ40y5P
         ODI6HbPq9s3P3g3nUX9eWSipVgP4RBXXTJfbpky6kRzkzsPAN0gAJMoh/BYC8/7rB9EL
         XEwncvLbPURgyYwjdWk9nHrFussWnIEz7lfWur0dVOLQVt2Qq54SXV+u5fOet8Sz2paM
         Dc4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTwCUxZ6Rw6APEP+bUPDj3wGgircbtOLzOuUaBe9wyNNrZLtrx0NEeV9llkgybohKtkIG1NmdJjnNKlro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSNH5TgSA860hjQWCuebn7Yt6Xq9HYXWAgYBfv/iHXaIUuUM9X
	xcnirG9v/KGmIsz4JU9TmH/VtBFy4wHtbG2meM/699lBx3Ao6lORRI9u76lnEJ/oTpg=
X-Gm-Gg: ASbGncvUY0Vd1ymNOS+wk2Aqs3SvKMRYpRl3PlQBYAMtZt+aDbetSjgdzm66kTiOaaR
	1E7LzrdvQAp6/20mPRE2/P1fDsKLWOF03u38tKDfXWKKaeKpl5VXkKMXWKyZapnW/QzrRg5Nq1/
	LXblbZexvYd/Seciy+DeWN8LrVMJHIK0Encd7yLtUFHUzrFQoJ08imTu4V71t/N0o3buV+XY3mb
	KwECoIY5RIyNseQR/tBpW+eqkBg0XZodfeERfhavsBwcBRABxqkuG05oEPP8wmPBL/m6DGkMDlA
	Ue7ezu03eYtQfDiAZOPjaJ43ePkRnIvewLYShxkYWWRXuGq9HPH34BcRgVNHtLSxR7+qRqHIJSI
	oIhHZg93Q+lPNAW2D61jIL18KtluBMI7MLqSBDnrSuuNh
X-Google-Smtp-Source: AGHT+IGU9ZLun3YXbKoCUx9QZlnwzO5u9ujah9aC8iWcLVseEem42XMHKR5EamUm8BPPO2QR3/wwVQ==
X-Received: by 2002:a05:6a20:a104:b0:220:82c7:309c with SMTP id adf61e73a8af0-23dc0d2c094mr18053041637.7.1754031714232;
        Fri, 01 Aug 2025 00:01:54 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd1a7sm3319043b3a.73.2025.08.01.00.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 00:01:53 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: conor@kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nick Hu <nick.hu@sifive.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2] dt-bindings: riscv: Add SiFive vendor extensions description
Date: Fri,  1 Aug 2025 15:01:12 +0800
Message-Id: <20250801070112.12071-1-nick.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add description for SiFive vendor extensions "xsfcflushdlone",
"xsfpgflushdlone" and "xsfcease". This is used in the SBI
implementation [1].

[1] https://lore.kernel.org/opensbi/20250708074940.10904-1-nick.hu@sifive.com/

Changes in v2:
- Update the message to indicate the user of the extensions.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
---
 .../devicetree/bindings/riscv/extensions.yaml  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index ede6a58ccf53..5638297759df 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -663,6 +663,24 @@ properties:
             https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
 
         # SiFive
+        - const: xsfcease
+          description:
+            SiFive CEASE Instruction Extensions Specification.
+            See more details in
+            https://www.sifive.com/document-file/freedom-u740-c000-manual
+
+        - const: xsfcflushdlone
+          description:
+            SiFive L1D Cache Flush Instruction Extensions Specification.
+            See more details in
+            https://www.sifive.com/document-file/freedom-u740-c000-manual
+
+        - const: xsfpgflushdlone
+          description:
+            SiFive PGFLUSH Instruction Extensions for the power management. The
+            CPU will flush the L1D and enter the cease state after executing
+            the instruction.
+
         - const: xsfvqmaccdod
           description:
             SiFive Int8 Matrix Multiplication Extensions Specification.
-- 
2.17.1


