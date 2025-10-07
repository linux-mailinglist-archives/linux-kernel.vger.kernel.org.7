Return-Path: <linux-kernel+bounces-844343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B56BC1A14
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 68AB234F648
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1302E229A;
	Tue,  7 Oct 2025 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KwvfG/PR"
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955AF2E228D
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759845895; cv=none; b=uIbnXllwqlSMMBxKD+g2HhO1GANv9LCia4KTT9f/TLTCpV0q9ZnDckxuvRfsQIB/37LRR9Mw3hq3xgrEDVUPgxJikfLMrlPgSF2c3urq6kHr0ekKtt9d5X6gJwD+iXnzfDWqWguuDof1B8no5Ahv49MZTONIO+CXgS3bOhAwbJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759845895; c=relaxed/simple;
	bh=IeHBJkm43o7DbIgNrwfftBjDn16UM0EotoQTOZb6iXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PZ83pDUaT4dserPfL5FqXmFWjHkB9vRMuPQrSlRDmzSlcaSFOFBEus47ozm5tAbN5xyydp8kgvLfug7rrs6WGGU5ukOqiGqKkS3S2+xEIF8sAAG/JK/X3OR5ccTqhUg3LXb5D5aQ8DweEhFW6rVs4onMzf86UgXGACdmPQad+nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KwvfG/PR; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so5703931a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 07:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759845893; x=1760450693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Px5PBDWoNSxvQicSvlQGDgd/7ifZnaEp1y0M1jncvfs=;
        b=dv5v7svvpUuDdtNvh4vrUySBvskPKHXp+DH1n4J8FVzDjY4pnyx77m8uA7NwjoI+O1
         j3/l5HfEdzCkxPJ9CzNIYjMPN4ixUEA5IunkLFBJnfhNc3yGktO98j5ZQ3NOOVXjaugv
         09oBPf0bM+3OmRnV3zHhZEGA5a8gstDXOdeWuBmC7oQQnJTdmaYZpRW4C/uQgmhpbtc5
         KIhYUyh2bcEY45y0fgAfXG5uZe2yl9QLPqTzWsRTaINDezJKWBHjgkGMFmYF6+AVlFSh
         UoL5GMuGkBSm62m1Xj+gfdYINanFcOHzMrAcQ5dEcMCxTNdmp5Z9kngifNRUa6eVDIOp
         Txeg==
X-Forwarded-Encrypted: i=1; AJvYcCXwhC6wdMRUfGqZgy3o5xRyauszZXvKGsEkPqdok3nCdmfYIjL5bTKjy+zfh4Dy6/gLnuAZkqiBshMBvhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNV3+NgG61sRiOD+HCkWBBi9szeQykcXHw44ADgfkt8deAakmP
	iSfgUQCDeFlnyBCT5Q8n8mTQrUiQqlmkvNHH2rPhtZn5xThsZZBGxRH4cwLx5bvsCP+btT3DrAX
	1Ksg5y29ZpDAfLQQIQgpcpqvpTf7gYARM8PCJgGpnfwxRIOXjE7A2vdxQAiHuWaalqMOXgiC0S5
	U7Fgn5JAdJKERUVkvvfQvfvo/wVGzOOAsczJB8C5c5eRMbB1ef0EV47WS/GFzShVAwYP6NOM/2F
	Lz0O8Qvrb/YZJWl
X-Gm-Gg: ASbGncs9zJNkrjZvQNWKY+iFTn25yMfECrGs6P7nncS2gEVJQhiYeIFzI+yStkn3mB9
	giKTa1o1DqFx1BjKQNWESMV/CRKkLpEsFi4t3Kzv0dj0i3NeXgjB7uA3LTS1CjTPpHF1K5NDdDV
	jVpKT83MXrsys3ID0aBzNYuhd9ykbff8jFpXLf+UBCdMOIddLs2z4gZ1Nkfu6BH6iTIzbDER2/P
	3ryJ1UExIMwstoGKHZC6FAkcVNsrlnw5kTlBdtppNa/xE0bcCr0Nrl9xWrj5UgcclitczFdfIIF
	S/p5S+q/IlqSIuaosxGQI6FfeTPIFImsVnbygj20AkA52eDbyYjzi9CDVTteAx2hI0nFI9EUTyv
	5WtT6BNjtTNnztuGVW4uWibByHXYsXtJbBkABai2f3GWoKUArNc+ND2FcP2k5OGKOTKViylyoFQ
	FhpQ==
X-Google-Smtp-Source: AGHT+IFwWK5D38CPii14kvwZtMYIOIuIE9Tz1w8rmnAkP5oSh++MScyw9eKEE+6iNy6UKRKDVdd4J7Wez6Io
X-Received: by 2002:a17:90b:3881:b0:327:c0c6:8829 with SMTP id 98e67ed59e1d1-339c27974b7mr21939628a91.24.1759845892546;
        Tue, 07 Oct 2025 07:04:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-339b4f2291esm1284059a91.5.2025.10.07.07.04.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Oct 2025 07:04:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7946137e7c2so185607276d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 07:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759845891; x=1760450691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Px5PBDWoNSxvQicSvlQGDgd/7ifZnaEp1y0M1jncvfs=;
        b=KwvfG/PR0ngd3PbHlS61WAjVgazkNsaKQHwp63pzFb30dB4aJMBCvcxcf15UYTrC8G
         NonoFNs8YUSPK4zDQrG2F3u4nlWOWTPF2vYwQNmAy/OWNT+w8ZMWWZHNTDv0wmY7WrIH
         yJDzxtN4eNH/kcDzw2U7edapQO9HTw2D1CG+U=
X-Forwarded-Encrypted: i=1; AJvYcCUGJU/12nq7Kp9BoXlMjtb9sEHCTZ6hwtUdCoVddZnvfBsPGhXyOVXGRPqBe9IGLxTwWxnpnDQkD8UzHrU=@vger.kernel.org
X-Received: by 2002:a05:6214:f6d:b0:792:61c0:beb0 with SMTP id 6a1803df08f44-879dc87f7c2mr226139086d6.67.1759845891176;
        Tue, 07 Oct 2025 07:04:51 -0700 (PDT)
X-Received: by 2002:a05:6214:f6d:b0:792:61c0:beb0 with SMTP id 6a1803df08f44-879dc87f7c2mr226137866d6.67.1759845890256;
        Tue, 07 Oct 2025 07:04:50 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bae60b67sm142718956d6.9.2025.10.07.07.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 07:04:49 -0700 (PDT)
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
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/5] dt-bindings: mmc: Add support for BCM72116 and BCM74371 SD host controller
Date: Tue,  7 Oct 2025 10:04:29 -0400
Message-Id: <20251007140434.606051-2-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251007140434.606051-1-kamal.dasu@broadcom.com>
References: <20251007140434.606051-1-kamal.dasu@broadcom.com>
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
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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


