Return-Path: <linux-kernel+bounces-847465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4CCBCAEA1
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 23:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97FE7483F16
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 21:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13B4283FD3;
	Thu,  9 Oct 2025 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PcppOuP2"
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E29D283FD4
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 21:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760044851; cv=none; b=rFby+N4V2FklfAWmnfq5GKe1SjbfET+U0gNOIrXqBgjHXCBtE5KLm23Irbm8HEvCTTPXIvxwsF4w7EY8mgAZnE+wwVUk+wSZMG4k1wSp2sVbXaPBRprlMthBGEVLExUnP1j0cNPDErpqfdp2XoFMrHolm8cBpgM7y4xNv+6FNdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760044851; c=relaxed/simple;
	bh=5Z7F2UPREvGp5FEtsnFrVwld1p6TT/Qq5YikRzeYqHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t1Oolkxr5ypClhPd5txpGh4a26TFc1fJ5zCha8ThMMi3a9G7EuSWp1C0ge9wvzccmNnkG9HPOlRKlVv4qDuJAORBI2WjceP9VS5GC7KH4sJljkYRZeyW34JrBH0Tmb8MpeB5gSiyu6hyOJU1YRVfMM7742PatRic7K9K2aqX3lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PcppOuP2; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-7f7835f4478so11813266d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760044848; x=1760649648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8pC7vKNtvxXJSB4veOOQwTeA6v2wJSbqIf9D6+uJhGQ=;
        b=MX0viWve6pm47lxr3hRnRDps8aP5fYZnsqBVnOL2pJ7hmS3UPlN+BjkExPPgLgi0ro
         ezxdBFxpwvQEPWTaJr/ui1nkHvBfmUjyUsL7l5SlXNONSTFPx7x4Jrjgol+QIh6y6wmf
         IkTRa7EKoUdi4sYp7d52Ds02w/tXc4g3iGo17Pm+9d0ODXt9+HCc+iXNHSgIrnZUYs8L
         DMwDT0awQDCt90waJX8laWr2VJPi79ewbdfPK0L5wIDZhwqsQX29FitcIOtm+LVqKufJ
         V3kfatBxDoazkSHKtMMCVZCJU0uiVQcmT0T5YYOZWvU1sKvblaieVArevlr6NFeQBXML
         6n6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNIBcu7VkHlPzw3L92QhjmWBju4Cbj/OdritUTZR2782sUqQ4uxMPUFLptte4tQX3DA0/JyGrEQTeEbtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHf33VD0cc3obt5dsCxdp+A6E6QcNLWQuAdCKD1i+HpmKIL4I5
	hvz3i2+0uQEKBFCfIARF8iOi5G4xmde/gkdKKMyO1nmgH/WX67MuV9KDHsdeC5clutsAP2bh7ln
	4ANs5pTJW3lNriHwIwxQpir1BZH3iGLPom2xrJZ9RaIVHn3NY4vyd9umJdUPJqke7sFSdhKEm/J
	W1d9Q1+LH2VVovE7Hi88aCWjTIB3x4HEQY7sisSt+PcWCVICABu29xymBnakIBFFGEtDwaTKqP0
	zpyprjsIbO2lP8A
X-Gm-Gg: ASbGnct4RdVzjtmpxDRyxFAftdI3WVuX8/VnkRrtNssOHaO8o+eRw03g3FaCUN10MmP
	L82jOrkOSWsASzWYxF+EUhPMY1WtjRtsXlzfHBnNq+5TnAt+3wr31Q9dktaDZTL52a36qjqNdP1
	PGSaKc+7vMbXt5UqDm6F0bwqomthMgPWCAT27eXLOR1sqlm+g6zc5DmOQYUSvMCssLOnfbmrM5L
	UsBxAQN4rMLjutoF1jA8NLdoF91KNXAXAJNlBud1XWe2rS2qi43Ip6tbw/YVzXX72gq+wrWpw+I
	7l5zwMCQrUyqKU8rux9jEQnqGVKZsJQvUEHKRfHi+ooWJB0XZdRU1V/YWY5WNv4dwvz9L8z2oh0
	v4iI1pGXgnLnzYn2SSkzinVp3dcRywdQyS2vyi64n/dtVCYAORPPKsEagnF/VDwBTX/UsiXlTOI
	vHCaHD
X-Google-Smtp-Source: AGHT+IETtN56rdxRP+VqJygN84qUh8IuRnJHCcZR3wxCD66oMX8sj3mgcFcrZp3Omh//X6gXwkgWHcvu29p/
X-Received: by 2002:a05:6214:e6c:b0:7f5:eda2:a561 with SMTP id 6a1803df08f44-87b2ef44475mr115461206d6.52.1760044848090;
        Thu, 09 Oct 2025 14:20:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-87bc3461604sm336746d6.15.2025.10.09.14.20.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Oct 2025 14:20:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8574e8993cbso259325285a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760044847; x=1760649647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pC7vKNtvxXJSB4veOOQwTeA6v2wJSbqIf9D6+uJhGQ=;
        b=PcppOuP2fE5nCC5mBvxBEuDFegxsNXPzfwQeg+jatq2Ojhu359hFo0AdJgh/Q4Oadu
         AnQ4bbhzDWK9YNdoQcj+pEP+w8JZvRzButrRzBZ/X3EuTPOnZheWmF6W7AT9RAeYgqdc
         w1mh1A/AbeNNg0vq6WepG4MQNC3+hXbwXhG4Y=
X-Forwarded-Encrypted: i=1; AJvYcCX5D+76zkSRRsbIGFTKDFticMoFopcoEe0jcXIUh+EFw2jwAipHXewlRNlisDnwNwdK46B8V8FkymJP4HE=@vger.kernel.org
X-Received: by 2002:a05:620a:711a:b0:7e9:f81f:cead with SMTP id af79cd13be357-88356de6853mr1368993885a.71.1760044847454;
        Thu, 09 Oct 2025 14:20:47 -0700 (PDT)
X-Received: by 2002:a05:620a:711a:b0:7e9:f81f:cead with SMTP id af79cd13be357-88356de6853mr1368989785a.71.1760044846973;
        Thu, 09 Oct 2025 14:20:46 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849f9ae428sm274832685a.16.2025.10.09.14.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:20:46 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: peng.fan@oss.nxp.com,
	andersson@kernel.org,
	baolin.wang@linux.alibaba.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH v3 3/3] MAINTAINERS: adding entry for BRCMSTB HWSPINLOCK driver
Date: Thu,  9 Oct 2025 17:20:03 -0400
Message-Id: <20251009212003.2714447-4-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009212003.2714447-1-kamal.dasu@broadcom.com>
References: <20251009212003.2714447-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Adding myself to the maintainers list for the hwspinlock
driver on broadcom settop platforms.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97d958c945e4..21b78f468169 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4972,6 +4972,14 @@ S:	Supported
 F:	Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
 F:	drivers/gpio/gpio-brcmstb.c
 
+BROADCOM BRCMSTB HWSPINLOCK DRIVER
+M:	Kamal Dasu <kamal.dasu@broadcom.com>
+R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
+L:	linux-remoteproc@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml
+F:	drivers/hwspinlock/brcmstb_hwspinlock.c
+
 BROADCOM BRCMSTB I2C DRIVER
 M:	Kamal Dasu <kamal.dasu@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
-- 
2.34.1


