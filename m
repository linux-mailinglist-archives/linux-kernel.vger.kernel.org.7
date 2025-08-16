Return-Path: <linux-kernel+bounces-771931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8812B28CFF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39971CC7F0B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651A326D4C7;
	Sat, 16 Aug 2025 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xaKjal/M"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0748F156C79
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755341230; cv=none; b=PQRcfCqG8P2RBc5dsRYt8J9yDRm6OVyqr9mx6OHx8V/t8VDipnBz2jQ21OvvVZVcQyVi13P5Qe1p5O8QMSNI9g44SPgVygZLEwVF/20T57MEq8c6U8IDXxZp38OSBP2yQCY/WdgBeNIytl9pjBbdNaraD4sSJhXBJhRv+k0O5RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755341230; c=relaxed/simple;
	bh=OeKXcWK76d0yWclbpyunEcAV1pszEggwnOfT37LA7fQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNlzgIvbAmF2TfOcshQNQOxvmrNrLeLWwSqQZxQOIq5WtfGx3tmHgxDKIIiTv7DNGJ6HISDYbTVCU6NnWI3IMXr/Wd2Q/o6vdSbsgjZabz94J0u2gl5CcieefDqHREbtBFZv1U7TWgRtiMxDjgZqb8CJFfL/nm1ZTqkzipE6Oig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xaKjal/M; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b05a49cso17652965e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 03:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755341227; x=1755946027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EaoEKTWawmv6w2uMw9L7nlPWvxX14sx+nVz1q6Hglg4=;
        b=xaKjal/MVKu8eFuQA3R3PpiUsVMPjumaRFtVEvgWF5lFa2DFsVEBzO05KK9KLaq8R9
         H3ouzDvy0B6Cw8os0QWM7s60QdCMNCbyF5/xFM5p9esSflXFn4mMIR/VpvTXd/Oihki5
         dcQxMnWk5Y8NbiC91mTlEY7+f9rnnJImiunL3xkY5R5WH27AyFFS1k+08T8uSRytF4sJ
         krMQrX5Fr6PkNvXhZQa83nPg+ZjLtB1tbOOTUQtN0CRopQ6qU2HXDL+uVQfdtMtnCYUK
         orBdnY0NmcgNsO/fkPgiZiFzvxs7CLOGz6LHGZi2MgUOKLW/Ww1rYTufSrf/jKkcPoMZ
         Hegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755341227; x=1755946027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaoEKTWawmv6w2uMw9L7nlPWvxX14sx+nVz1q6Hglg4=;
        b=Ug6yp+d84CrC8u8NR6A7hdW9+VIfw7/wtVOsIhvSZ9+6ZV0AcnwGxc05BYA2FPyRi/
         1ZMJqvIkDlCLbGbEHgPrTE9eadfxeVYu/42h8ZZtRwo8k0ASFDoGDx2zl+bCJCs/OXbr
         mhnO9Nwgig0nCxPn40AFCoqNxr9yEp1VF8sgD20/umkmZ+2D/HGy71dZd27eTql2MMHZ
         27hLSv9vttOCS5gSPNRwvcMlx8IGmc9900Jx4FTavCPMqEUqPPDwYrJiseXqZQUH6lBH
         vWTIYyrXg74DvfwupqHpt56PoWmykzP44FT+EyQW037ER90OPYvrhMflwyrq7pvLpsED
         te4A==
X-Forwarded-Encrypted: i=1; AJvYcCXGgcf6eIwVwTutGHfrkUzRpYqcgzC/SGHddNhByZV+xx1CX/TQssrEZiUeHLot26c40j8UR5AOtKHslRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz1mGFfqSSsXWteW7XWGhpA8q1PHe6n9PL1UHXO4diz1anlmvE
	p9JJlf6PmxoQD5/MAub7m9zbG23iqN0ct6zT83uQU3ZeE5rsaI0aY0GcOeL9B3m2lVs=
X-Gm-Gg: ASbGncuvov3vfU7hFUHxtXmBLEFWyxuyfjWHiuTkP8b5FO0cQdf4JzOiHCK5rr6oLE9
	MeIaZkKFZWkJ780Zg/FwdgS83jMRoJpN6nVLXH3ybZa1BC/CyDuu1LoZdXQdUe4kTVx01NxyzwE
	9+AREZweY/gimtvx/dxoWnJTBFl1ihh8Y4LBc8O7xJIGoQ4K8G+w93U7hcqKuz37IY7hgEbdp9y
	2qfuKBdR1zpt23ty2mO84Nxcdgy+RkzXXi3XpPJ7/aPq2EzPj2aEnaQrIKbzh43CRUVQ6Gk19iB
	CQnFGNng9OUdI7g7YDKwdpdumF3610ke4107cTZzACNWTBbDoZn0+uVHtmtZMq0u9ucdJOSGvdX
	GHW0aHaFr8Mt+bcwUi8ASuuo0o06lIxs8je2YWHbC7k4891RZb8g0baO5SNk=
X-Google-Smtp-Source: AGHT+IGkWKzC/ZUC892QL7yJQoZJoHNrOosh02okhIhcrBnZmgy1YSlQeu1lm9PX58OU21V8+jK1HQ==
X-Received: by 2002:a05:600c:5287:b0:456:f9f:657 with SMTP id 5b1f17b1804b1-45a2185e6cbmr36481925e9.27.1755341227201;
        Sat, 16 Aug 2025 03:47:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a1c78b410sm96162985e9.24.2025.08.16.03.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 03:47:06 -0700 (PDT)
From: Ciprian Costea <dan.carpenter@linaro.org>
X-Google-Original-From: Ciprian Costea <ciprianmarian.costea@nxp.com>
Date: Sat, 16 Aug 2025 13:47:03 +0300
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ciprian Costea <ciprianmarian.costea@nxp.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-s32@linaro.org, NXP S32 Linux Team <s32@nxp.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 1/3] dt-bindings: nvmem: Add the nxp,s32g-ocotp yaml file
Message-ID: <7d0e025ed3fdc9e545f1d0b84f6a1cbb9dfb4e91.1755341000.git.dan.carpenter@linaro.org>
References: <cover.1755341000.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755341000.git.dan.carpenter@linaro.org>

Add bindings to expose the On Chip One-Time Programmable Controller
(OCOTP) for the NXP s32g chipset.  There are three versions of this
chip but they're compatible so we can fall back to the nxp,s32g2-ocotp
compatible.

Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 .../bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml  | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml
new file mode 100644
index 000000000000..19f3bb6b7eb0
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/nxp,s32g-ocotp-nvmem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP S32G OCOTP NVMEM driver
+
+maintainers:
+  - Ciprian Costea <ciprianmarian.costea@nxp.com>
+
+description: |
+  The drivers provides an interface to access One Time
+  Programmable memory pages, such as TMU fuse values.
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - nxp,s32g3-ocotp
+              - nxp,s32r45-ocotp
+          - const: nxp,s32g2-ocotp
+
+  reg:
+    description:
+      Address and Size of the fuse bank to be read.
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/nvmem/s32g-ocotp-nvmem.h>
+
+    ocotp: ocotp@400a4000 {
+      compatible = "nxp,s32g2-ocotp";
+      reg = <0x400a4000 0x400>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      status = "okay";
+    };
-- 
2.47.2


