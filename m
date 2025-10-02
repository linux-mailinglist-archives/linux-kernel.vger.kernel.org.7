Return-Path: <linux-kernel+bounces-840794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4633ABB5744
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 23:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A39B425113
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 21:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87308298994;
	Thu,  2 Oct 2025 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B+mHKi7F"
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761AC221555
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759439090; cv=none; b=VHzjNE5+8OCF2Nd4f7S0zxXhIlfQhK605KPywLRRqWpggIjeIHvPoqQZl9yzye8+Afli2FStYtCxo9gR8C2aseO70shgUmiUm7SVpTeehc874feZzBySxwf866LffiVu0y6wr+quT+YMuOzY0/npvvyLr0tHq8nE8jf4+GS7FYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759439090; c=relaxed/simple;
	bh=jK7kxcxxZSZOzxffNSAiY6865wMbhPwApNWPua55We8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=no6h8CAzECHXyDVQw7RWUZPybHtNLLbDmo/VDAwiaDtJ1svQv3tbVin3mFXLc5BHTvHKVYGMD8JY56PsqBMA8YxGzWY7vFCfnXJjTu/r8YFCBe6d3u3fe+7j+y6H8xus+r874rkNeH3GmZVuOipHil1LjOal1n8VlZbW1UYWSkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=B+mHKi7F; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-78f30dac856so13488736d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759439088; x=1760043888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0VBquDv6g415iy1L7kGakH7H853FAzWxsvjxiCHfN8=;
        b=HwdePVR7vJw6Ep0JFMh8A163QprN/wF4lEi884HqIplby45LuRz39G6UNofnveEXlh
         pQvoV/0Sl9m9t0gqIOANTL5mEJ/WGyg/ClssyafwwVUAOuU6MVCz7lvpLPvjTWLzdwMJ
         PPpnWpm9J01AQ/5KTFeEF7cuaufYZlgY8kDEmRceKOP+puicsi5A78BnvOmY3nBilfSd
         iBxVB+CV6rhKt0M1qmklrsFE6C64mM5hdqVWsPa5SM67wmbhA5027CwnV+EErjbwL89W
         wU52vuW7C4JQG65xc2jJFm8bQnkG9wG83HCU/x1mGh8eCabo/LSGUNU7gMwTK2axXGHU
         RobQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAeSClB4BHDY+QmGicv+x1P00Jo3s5aYrA1nGRmKNcVZwLrlIcEDxDrLJ6DHPgwfDbR22/cvF4lPZrRjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqu0JPk4DeaxPxhHhV+e04sw4jyEtQrrajHWseu639GebSFV1p
	LaoFUnX9xlLKOVKpSIGIbo9N+2czo/dmC5N1tiWsLTEpemOvoAMXKrzugKuplXkS0J0tz92QDY+
	7+xb1BtxaZxumidrFQYg8VlrGPaD7TFLoP3jWuZfePBcJXyIIctsgOH7jrIbmyLu1EN4bvbwxXh
	3CTwPCFC+KtKe+oKK8YXMLwvWKvBAPPCBPaIBA94iXkM/aQcEphURvgjR2vqWJB7+Bp63MaFHgg
	NaIYagaG9IzoNIa
X-Gm-Gg: ASbGncsw7xZuc3euOiRB6gGxNkKsOExe3p5WfTvGM9s1Ntz2ZqXdTdpLN/dGdTN+6fw
	Fjazrnw/Lu/C5jpcK1xOg0ASUPqnJKpUSqbiHkaqGKqC3wiAzA63Ky9yTjBwbTz7JZMBjA3XIaO
	kvaSax2Vl/zjbMGHs/Yn6cYOrQ4SHWBSzw0BdaFMuISIJx3Ezmhm7S/GX3L84iDq1Zg1upZtUZN
	lczMmUnDrEj32n33QXhSKjslZw+YHMosD9NToGJ9H6JmytRlUflYE9h3ZVUUYxBJpYNEGSNTBrI
	+HVvBMpH87iN415PJtAZGFlNtle6r/El73hLUANpdxVArE3YYuL8+eUwYDhLX9AZIGHWkQ4kAOd
	iDRTvsSrR9hK0HTLyz8J+BLPYAiQ0f9cTF2lNiOGSp5gbehQ0O0bXUT7NBYYLrwjr44l5U39H64
	15Xw==
X-Google-Smtp-Source: AGHT+IEwr4/jF/K2st12UfYEYZRICc3Nbc8F4ojthVgpgzIs5SkXsE1uU2AlM7XErauxq5Guv1GQtyuEosYE
X-Received: by 2002:a05:6214:250d:b0:7f9:5850:70fa with SMTP id 6a1803df08f44-879dc776112mr9841766d6.6.1759439088191;
        Thu, 02 Oct 2025 14:04:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-878bac6c1c6sm2255126d6.8.2025.10.02.14.04.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Oct 2025 14:04:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e4c8fa2b1so8147575e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759439086; x=1760043886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0VBquDv6g415iy1L7kGakH7H853FAzWxsvjxiCHfN8=;
        b=B+mHKi7FrxKqXf4T4MBS5guhb/3IiPhc4kpJMT8Jx/STD3M/UTs5QwsYI3aQXdqBe6
         gCg7OSputMXRtqZg/Sf3Zq6g0mwI7VaJ/P1tM5hyPlI6IDsV0YS/ZBaNgX1GlVYCbBaj
         p6s/CpiPQ8Caear653sKwVVQ5eCE54X4YmGVY=
X-Forwarded-Encrypted: i=1; AJvYcCXBvoaNyu51Lz2BVwAjb+aWRtEeSW7y3cmGUvbxBvTZPvm0fnZbw21Tqd+wixDR99GZO1nXJK8vF5jfhVI=@vger.kernel.org
X-Received: by 2002:a05:600d:420d:b0:45b:47e1:ef6d with SMTP id 5b1f17b1804b1-46e71172104mr4721595e9.36.1759439086297;
        Thu, 02 Oct 2025 14:04:46 -0700 (PDT)
X-Received: by 2002:a05:600d:420d:b0:45b:47e1:ef6d with SMTP id 5b1f17b1804b1-46e71172104mr4721505e9.36.1759439085831;
        Thu, 02 Oct 2025 14:04:45 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5c4c0321sm61711295e9.8.2025.10.02.14.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:04:45 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: andersson@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH 1/3] dt-bindings: mmc: Add support for BCM72116 and BCM74371 SD host controller
Date: Thu,  2 Oct 2025 17:04:24 -0400
Message-Id: <20251002210426.2490368-2-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251002210426.2490368-1-kamal.dasu@broadcom.com>
References: <20251002210426.2490368-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Updating compatibility to support BCM72116 and BCM74371 SD host controller
similar to other settop SoCs.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
index eee6be7a7867..720d0762078f 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
@@ -21,9 +21,11 @@ properties:
       - items:
           - enum:
               - brcm,bcm2712-sdhci
+              - brcm,bcm72116-sdhci
               - brcm,bcm74165b0-sdhci
               - brcm,bcm7445-sdhci
               - brcm,bcm7425-sdhci
+              - brcm,bcm74371-sdhci
           - const: brcm,sdhci-brcmstb
 
   reg:
-- 
2.34.1


