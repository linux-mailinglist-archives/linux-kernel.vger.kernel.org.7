Return-Path: <linux-kernel+bounces-796021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D13B3FB01
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A49CB7A8F1C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9142727B34B;
	Tue,  2 Sep 2025 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f/9q9kV4"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF0C27AC2E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806472; cv=none; b=bv8tNzSbdtKiK8SFi3qEtDu+MV4Gk9c4oKSo7+VrrSxfWj/g14HZBI7cdAHdxwfKgd5e3hzU95g4EtuDC8CQI3wEUEf9tWdpxQSEYBq5vBHWVGc6QLjpxpa+qQJ948UL8woYgTBPDPYo9H4WG671mHuFsZgnKjpiIK9yDepNIys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806472; c=relaxed/simple;
	bh=yzipH7+YLSVA5XwvVOPX7KSuVlBdg734ixf29Kxdakw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAHZbcZfyUPO/hh7JKAojtgJsP6s3kZAr1PQ45vHddD2xN3+QmRDPdwkzqjdydz7oZXAovdK72HTCRIR/K/QSOSMxT+AwZfWcHpMXDR0K7QdygzxUrMMdzQYit3jCd11FSeAL6pJD5nEKWgpCRSRK1K4BBhr2g/tZhClBXRVp5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f/9q9kV4; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3cef6debedcso2279794f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756806470; x=1757411270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zDNEVdF1aav7akHGWHi6iBedrI525SqQlKbGzww85uM=;
        b=f/9q9kV4wDr2uusl+FJ51jDnJSwz0NuZoeNEI23hGRnu4YhcFyZLF2EWeEjvmS9cHT
         xLO7nCt0XMwSZzhsG5SeGbXF7HEF4TtbMGBu+9+QW+JZ3BSamzg+xz3lzmzCmMCrTCQ+
         2i9gNLU/YjoFyJ0XWtH5JaatkAmYA/CQ51VVvsGTq0rkcnkG3RKhwEVvQDPsOH4FQJHv
         bV3kgN2DI8bmgFRfPq44HaJLWIw4k85UBz6Qi28kqOfxBq2tm7Hh+7UBZMjsKOTPxKtQ
         oy/8NeZiMqHXX3nGgJjMerZO4OLVqp+NLSnFrtct15Myz/XZikNGZzDwGZMU2PjXAxwt
         FJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756806470; x=1757411270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDNEVdF1aav7akHGWHi6iBedrI525SqQlKbGzww85uM=;
        b=cy6k10jFHgelKaJ3lXBzIMg3JRiROPmaaE/jwCfzQ0g5v44Wd5gVi+kfYUyVTVpaMa
         +LUH3/S9PTIH5xL8XHHaShN4BkI2n0ox3ysgAoJk/Ai129wgxs4xKOkZ2pZARPQbjaRj
         8MleNUs3cw0ZVKYjO5K3qqudgkTGuKDZhD+a77Z407fta6lt+7ZZ5ZDt2gyzxQ+eML+v
         y0kH5e98PncbkrOFAzNBZPLdui8IMT3obJvfn/4JrzpXTfWN7ZtNjBX4CfOVIRfF7Lah
         bXEJKz+DkcWxk3FH5mJ7EnVTU6ARUS9XXdupc0BpMBl0iiMBUQCazTR+MIkcVx+h8tYz
         5ZrA==
X-Forwarded-Encrypted: i=1; AJvYcCWYdc44IF8FO6PKukyTS0sUOQMgIJ0Aaz3xYZLGzVkCeJVgbJXSCnPRLvw1Tsy47UE5zVN2p3h7+TjZAsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxA/P1A91/lbFBAB7jYzicIBMDxktqrIpQNB06uKdn+C0+d9F3
	6BSdl1BEefQoJ32OLWtSc8XaZPiTi3ELgMVURS51U9gsfyxenHQ6QNPfCjxcd3iki8w=
X-Gm-Gg: ASbGncsoiWvZX4QcLS+v9hHFLA99EogEC+Jzudb/cXVvxitfnyLun75BWu65TD7Fd6v
	gOO3jaJR+LkVncCMw74Plkv9nuZPl5ldZ3w+/3IlOYCKyrjFg0WSjj0JT8/55nWh3ASQQ9qBDgw
	mZepA5v0XpnuaL1L3t0e7tD2x+fpyjrjd6Z93cT5KWK6cbqEXfURS084U7+wZwvXcGGYZdzVUH/
	BbjeZsQtts+qrQsWSbJlTIk3T94E00K4/CANHrd9UO/6LwB0mW7MHQGjVQ8w6kwKLP3On3sMdXh
	ADbogarBCr8tWLrQCOWLdlWzMoN98gN6gOWC9iX5GFfsfnGD8BPMG+wqzZDItzKhyiZcgHlGW3/
	0zOcOyYNpJJxAryttlu6K0bJhSHlj9jh91FN/6Q==
X-Google-Smtp-Source: AGHT+IGhzDRfSoIBdZIYTbvS+YKQHcUloucdIOzwbNIUuQlEjgK00y3sqTBhlk96hnKLHY9Y8H1RGQ==
X-Received: by 2002:a5d:64c6:0:b0:3ce:f0a5:d586 with SMTP id ffacd0b85a97d-3d1dc5a2fe0mr6784224f8f.1.1756806469665;
        Tue, 02 Sep 2025 02:47:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf274dde69sm18902229f8f.14.2025.09.02.02.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:47:49 -0700 (PDT)
Date: Tue, 2 Sep 2025 12:47:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ciprian Costea <ciprianmarian.costea@nxp.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, linaro-s32@linaro.org
Subject: [PATCH v3 1/3] dt-bindings: nvmem: Add the nxp,s32g-ocotp yaml file
Message-ID: <6a9562fc4b5a70a34eac66359bcab64be96ab873.1756800543.git.dan.carpenter@linaro.org>
References: <cover.1756800543.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756800543.git.dan.carpenter@linaro.org>

From: Ciprian Costea <ciprianmarian.costea@nxp.com>

Add bindings to expose the On Chip One-Time Programmable Controller
(OCOTP) for the NXP s32g chipset.  There are three versions of this
chip but they're compatible so we can fall back to the nxp,s32g2-ocotp
compatible.

Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v3: Remove unnecessary |
    Move $ref to end
    Alphabetize the compatibles
    Delete the unused ocotp: label

v2: dt_binding_check DT_SCHEMA_FILES=nxp,s32g-ocotp-nvmem.yaml is clean
    make CHECK_DTBS=y freescale/*.dtb is clean.  Particularly the
      freescale/s32g274a-evb.dtb file which Rob mentioned.
    remove bogus include file
    remove redundant "reg" description
    remove #address-cells and #size-cells since they are already in
    nvmem.yaml
    Fix email From header
---
 .../bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml  | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml
new file mode 100644
index 000000000000..8d46e7d28da6
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml
@@ -0,0 +1,45 @@
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
+description:
+  The drivers provides an interface to access One Time
+  Programmable memory pages, such as TMU fuse values.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - nxp,s32g2-ocotp
+      - items:
+          - enum:
+              - nxp,s32g3-ocotp
+              - nxp,s32r45-ocotp
+          - const: nxp,s32g2-ocotp
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+allOf:
+  - $ref: nvmem.yaml#
+
+examples:
+  - |
+    nvmem@400a4000 {
+      compatible = "nxp,s32g2-ocotp";
+      reg = <0x400a4000 0x400>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+    };
-- 
2.47.2


