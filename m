Return-Path: <linux-kernel+bounces-824309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A247B88A17
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC996188ED80
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37C2306B3B;
	Fri, 19 Sep 2025 09:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF3RaxlN"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5115306B34
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275089; cv=none; b=XhwqtO4uyzeK66Md5Y0pK3GE5qpfSsdbvOi9Qd3hY0CaJNQxH64YN1k3qa+OggDy6zHjMUwUs50OQY7URg8sJMxJAyyXlnmO5FqdHK8QZvurOZD3vHLM8ePjIBZcuOHjSCUELPsnD6QET3aBju0XeQCVtVvo1SO4lMwPlBvRkwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275089; c=relaxed/simple;
	bh=SAyUnJhCwMKSbhb7U5p01vudm4sy13VmR4oxIBmj0nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrM0BDE4bIo1Mjjux8FOEpWDz8AvfT34AxxJHoSyUcgxsbJcV44hYYrL9e1kqOC7tkQkMfYQRJdKFHFdBC2qcJvHzqfCR04e4/BcVJ+EDr7gPpG8ftMtck+E4EbK9V/PGCA+RpqbbSVUojjEAtZJ7Vi1PRLIm7rbUgmwYsYS2uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OF3RaxlN; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so1228620a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758275087; x=1758879887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2cvRp1weqffRPvbmfOkQaVMZbMjAj/UHkPXTSQ25jI=;
        b=OF3RaxlNYhdEdilZvebjfRJ740SjX9RIh5eOhTwgLeEvUXmtI6ny+PZRnhfisxdPE0
         cn6/6+KpG7rE77nPsNF2MEeasA4YBliZ4yuK4a6tAKW5y48bu6680HMpu7GLpnkHnfDm
         OtueOhIDVhbZLGQ/sZ8RFy29TW1P/zmnQJpAz3scyd+f/hbEVA1LITcMijC+1PHynNhT
         anre/f9AaVx1iA0e6LBUic9l8jc9s1Eb1uQdrxe9yvud08ubknvHOPE+6AIiFeylOVf/
         t9uVIQQyw6NvGKa6LeIyNzHRRKbOdNsOdnn4nmC96AJ4B6ckNtrKkT1MyhpnIsQuJpCh
         fOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758275087; x=1758879887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2cvRp1weqffRPvbmfOkQaVMZbMjAj/UHkPXTSQ25jI=;
        b=P96SUOODaGdwvH4rep/SL4Qv+NZKluM9V6YETYFmAezdcnzHkHbEw86hgeeXeoGq+x
         LMHdKjlLuy0cmF57l7TApH/EjYHkuhgSNox+v7f7f1OcxDZk7I1t39xwAYWwEYPTpp6q
         Lpfnwa/fYri8PcDEoBkqD9xBLgSs8400hszx3tTOWdPvRlI5XDMjElkpxOA0gN/HrapO
         M9s8eEOcxoxDz7zMoSZwev2MfwO+BnGQrpWI42de8SLUOJzsDCOqtccSXt7CbLU0vNbH
         r3yU/5ot1JHk6ur0EJZg+gkEuLUuKC9XZZTkplcQTKoZzdVsqHceirgBhdHdXvN3PtB9
         pFWg==
X-Forwarded-Encrypted: i=1; AJvYcCVc6URd96J/Yj5EEZoc4TlCZTjikTO1Z0laKQE8b9ThDQBNDKWe+kwNZl2kvc1cjBJKCvY5NYJ74hs/eaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUvdksR58OBXFQzKKgjKWRkdn/LCy4WS1q8ziAKq0LZgtqwKqu
	NbkkN0VIA2xfY+0x/dDcLOUXyxGpQF6kqoBkGNb2aWn6z84x0m61JrMS
X-Gm-Gg: ASbGncvNM2Dz6wCPW03QJxCuGzlS8+zQKlU2xze8V4Z8KwJnTBjkeN3HVDb8PpEJZ+L
	nNTFqsCYpy0MBZ869P+QNzGk7ZnWfFoblAzwKG1Sz2CUNedtGpJ/srxfz54R2sCpld7isD80m1a
	8Z3gaTr8o+1/ZyGJ7OtH+wBXGVmzCIez7mUr8p3x43rDTXmoj+O42vg+oQltVLMjGfN4V+0SwIJ
	/cZwEwooP7am36GUzhxwQjcFOdkb2brwJlja8dTgwOUu+nifqhm9sC6Sxf4hf4VtKfRFxIaYjsv
	Fjg1Ade3Gee9WzdlPXt88sViCCdDoHov0XmloTCW7JFpl859KvyHbq4SdAhDj/Bhh10JkAUVk6m
	FfDCd01aQB5rbtGLPoaH+Xk1fj3MxHw==
X-Google-Smtp-Source: AGHT+IF81ZCACHBm2iK8/kjiA+RR2MY+a6mu/h4nqyIa9OcgzApIqnCmwflrvu2zcpOjmU3UceR01A==
X-Received: by 2002:a17:90b:5107:b0:32e:9f1e:4ee4 with SMTP id 98e67ed59e1d1-3309834bf38mr3988965a91.17.1758275087266;
        Fri, 19 Sep 2025 02:44:47 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3304a1d22cfsm6221873a91.7.2025.09.19.02.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:44:46 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v10 1/5] dt-bindings: ethernet-phy: add reverse SGMII phy interface type
Date: Fri, 19 Sep 2025 17:42:26 +0800
Message-ID: <20250919094234.1491638-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919094234.1491638-1-mmyangfl@gmail.com>
References: <20250919094234.1491638-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "reverse SGMII" protocol name is a personal invention, derived from
"reverse MII" and "reverse RMII", this means: "behave like an SGMII
PHY".

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 2c924d296a8f..8f190fe2208a 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -42,6 +42,7 @@ properties:
       - mii-lite
       - gmii
       - sgmii
+      - rev-sgmii
       - psgmii
       - qsgmii
       - qusgmii
-- 
2.51.0


