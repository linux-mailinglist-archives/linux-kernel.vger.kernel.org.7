Return-Path: <linux-kernel+bounces-836795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5748EBAA946
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36F219245A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 20:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6D5264F99;
	Mon, 29 Sep 2025 20:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WzX+oXpA"
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1D0262FC5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759176438; cv=none; b=TT3cvm4JoXRTxNWYe5Hvs+wPcszrJ5YbyhkCoyx9Mb4lSsAa5YKl2KY2XdYB9gEWZ7aLO6H7afBRRZFcjSognvvP+2Pf4NNjRRs+JL/1IzXlgQtV3Iw/cluinY+Z36bdR7V3r6CYYUGHzc77aX3NtzC8iZO16XfVv967TJZbuYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759176438; c=relaxed/simple;
	bh=pbh0BAzdCZ5GeAnkz26ytoOKgkgpRsRjE/yqGfWQuio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OBWWt5XWpIc/qByKWSSM5HyFUaCb2fj9BJeTjpWN1YAcSIF4S41j+Oe1du1Zkv4x+BExWgq+VzDooFOuJllTmsZ4/1bGlg+j45G3paaId9ZZx7TMItdQBuGpFSEUYeHWshuokQoZ+uEq4abDe9lmcVxsqNscdJ2frdaXzNOhPxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WzX+oXpA; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-42571b8abbaso50593475ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759176435; x=1759781235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KKcTz2+WfcXi6NCeJhs4Aeeo3+yILKRVizIKcyvohdY=;
        b=MJ2lqgNhWPHdhOuEdYg3eoYLyNqxQpaQyj4Cm4MjX4wM4vyoPlrJKTx/c6iZEGUDVW
         DwBNPQWl/h7tsmVj1zHL0jpbFEfMaycRNAwuy5v5mqlRRy3xXDw5DDH/NPHcT6tPwRGi
         w5Ol/nq+suE7CJSQjfVC14eJZpMGZFGScyM+frQ2+LyszClMBsXfOVg3NtEo2lD+8MqW
         4frLHbHZ298gBTVWriVnXIotfj7OhI6qzzg9x1KQyiHm1DVdECfAVwONfVdQG8X7upmA
         hfEBn696jdDglnnaJLcmGWFrI8IHpZUQYJyXX49UCre41GVmfO3c/dQ2kheBiHkVB5x2
         mIkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu1+qN5Nj5vuZgjxeUW3mgLjaoOFHu3z7hOs21H29AOKdS45TD756LaKVurC1P2us/ygitmbIDoGY6/bk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr1/UQ6AQTtjA8BxZrII6X0U7GGVOTww6P/BZF+00gUaMKVBkS
	OQXX43Qsekt1R2dYwT6UI/ptZyj59EnKctLoDMijJyzCkqf896qDMTAZOvykxdOrtrJRU77aovy
	jz+zLNe6agTHxw4YrIEANTQdJnbbXU4NwjOUvGDXNIWb7OOe1zLXSZ9Ba5IdkpzIilFoc8zG5Aj
	vc0ukQ+6pNeHcyBErOmE++IQBlupqNNr7S37JeKcyuDnW0xFwepZ298sv4o9nEB9eZTr+F7KjRw
	GcDjsGobj+T5TOw
X-Gm-Gg: ASbGncuzf5rN3/xLOFFKh59LlMBngR8alOu2Fs9+unB8w6kAxPnGyhu4MP/TrqI3wki
	0Z3vPCi2etuWAJwiFCQkqSjyrHKQySYDPTsYo4334DsdJIjzKYv29JT5+zip/sQxuC0gT6L7dXn
	f6989mXYC4tph6+ql0ZzYlCVbKlJjTMvhj4vm6myPep9Dx72+lUbJRGsN4hMv/iQC7+SB5gjzKF
	IzLXrKsJYVXr1a3/hvlQokL0L+ScFuve0GMvCsfLh11iS1ELeeaakPjlZYyzsEEGDMK4ymfCZGq
	SA6PQKGS27OKE0cPFPBYvrsDLrf15fEvN4Vyk2jEwGxv0rzj2D1i18WCPmf/CoLmlteckmzB2MO
	Vn7bZq7mH+YZrCK9By2VQ
X-Google-Smtp-Source: AGHT+IEUnwAG31S+hIgPnhsNaDsmZH9/D0c+xnZumWQ0zXbTEkEZDtY/zsCXGnOcpINhr1+ckxyJvvhCH9qu
X-Received: by 2002:a05:6e02:378d:b0:427:27d5:bccf with SMTP id e9e14a558f8ab-42bf94699b9mr61934455ab.19.1759176434593;
        Mon, 29 Sep 2025 13:07:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-425bf6d5023sm9308985ab.24.2025.09.29.13.07.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Sep 2025 13:07:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-336b646768eso3236645a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759176433; x=1759781233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKcTz2+WfcXi6NCeJhs4Aeeo3+yILKRVizIKcyvohdY=;
        b=WzX+oXpApqNUnlyvEPrkNx8BZBB/ASewmHzBLaP/P4C0xR3216v0eHbI2BFu/VJWrm
         myXjYxsj2P5eMPyapi5B2teLblFnWxlc4Yvdwm0RcJOioqjfXFviIYIxqjg642nf2ixo
         L2ZdAcGGw+mZOpednzxDsAynlMgyQFOgpYafw=
X-Forwarded-Encrypted: i=1; AJvYcCV9nOlRIchXyohgp2L21eseNZKwYrfQwDYyfpWkS7IZaUEscptEXaFUQma6Ww0rYVUmjPZDwvAy95u7C7Q=@vger.kernel.org
X-Received: by 2002:a17:90b:4b84:b0:32e:528c:60ee with SMTP id 98e67ed59e1d1-3342a2c9fdemr19234062a91.24.1759176433127;
        Mon, 29 Sep 2025 13:07:13 -0700 (PDT)
X-Received: by 2002:a17:90b:4b84:b0:32e:528c:60ee with SMTP id 98e67ed59e1d1-3342a2c9fdemr19234028a91.24.1759176432436;
        Mon, 29 Sep 2025 13:07:12 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33838735194sm2121479a91.22.2025.09.29.13.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 13:07:11 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	andersson@kernel.org,
	baolin.wang@linux.alibaba.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com
Cc: linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH 3/3] MAINTAINERS: adding entry for BRCMSTB HWSPINLOCK driver
Date: Mon, 29 Sep 2025 16:06:27 -0400
Message-Id: <20250929200628.3699525-5-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250929200628.3699525-1-kamal.dasu@broadcom.com>
References: <20250929200628.3699525-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

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


