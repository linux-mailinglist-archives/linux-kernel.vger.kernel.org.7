Return-Path: <linux-kernel+bounces-840792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C25F5BB5699
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 23:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832A0188331B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 21:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425853C465;
	Thu,  2 Oct 2025 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OFISdMeO"
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C75A16132F
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 21:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759439083; cv=none; b=oCaJmD/21Oztwb3DeEm/0QN72kuK29RYiiG7eUQaIjvDYB5vHhW62ExRNtLUT5kmOBG/3I/1gMLNtaY/FbTH2T3GGy8Kg5hatgFaUR1ltjZt4KjbuiDfOjFnT/5qqoWvB5XqErrMfok/5Ntem1zL9XcahTlYidV+mtFV1pARxX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759439083; c=relaxed/simple;
	bh=wQ1CYAjiFcO9931vPI1LjA3++HAVRuOZx4J5E9bcb2c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jdt3tUsfcOVq7QnktYwv5srSBjL8sfBEvXlvkrs4w9UpW8HiRFGSFUmAyiLe7c2F57I0nOXdivubFxRa9L4u5dg0LhKIWydXJeEyBq3YL5xcqwO6ZfkUA4YTv/Rpapwd6clzSvf6hwQBwWXuLCnArsjnuXfPe9gpv4SdyXS1pYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OFISdMeO; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-b6271ea39f4so348822a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759439081; x=1760043881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2UQeXeCdd38LZjkJTP74V8I/AwlCwJ5vjuI4bPLac8=;
        b=bPNhXVATVn6+lQ2izL8euADafbEwfpaHoxZF3SdC6/u8MFo1ZvBonvXeY0a3rPQuO+
         7F6hiTzVKT+CKQARcoJZ6LRW4KS0qFt4+DomFmp459/h0SedV/72kzzWPRgtRq3uetSo
         PwJM7U7u9eURnsby8Miv4LAIw5aRH0o296SgfkDfFrYyNCfeh4H08LLX/0smHy4DdNGq
         u45dHvLhHKTQEL5p3B3FIXTlJBMdZ/AL8GUlqyMWeZCHp0Lb959iELQs2fmtMNoUomVJ
         w29wsHwmeBOJcyWZawz8gFsSDf8D+Q4fSXrMT8MKLeEFlMwWPEOmof2a3eMzNDP7IJAQ
         K3Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWc46r0vv+jL2WU1B+uZYWlILVrCo0yyFkdOgjnic3bfxDmVk2ldhAJ52eywU4uenOrJtR/0D24ti86adw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFEAfuULA2tx8yMo46CsQ/X2fF1HMTxabiCrFCHLSZjgVGHDsi
	+20bhcrYRnS71Bf4UB02QCKizhCPaDFVLI0ZrPMn9riDoooDR/NkjCtSor5L3WjRdKdCeYwDn/e
	iIiMyBz/vZr+yQssP/IykwMihcGyEy/qFjGCU1Ywc41N//60E/okI0FzMoXyPtdXIp9qryeXINV
	pwBhNvqRUzPl9kw5KezZaJ2Tiy3sSVBi+gEaP8of/t5UBVUOEkRx8wA9cRRJo0CyigQlD3MhLqy
	9P86GeQe9ASlnRU
X-Gm-Gg: ASbGncuJWjwBa4jTeRFOnJQTyYKy8kuGS/2Lv8cztxuZxsi1jWyrSQh4IgpEgto8Y15
	jMeoTD2oZHHNo9VP2xqpAT8FX71mtLaud/LE8NkLJu2064v6XXARjenG1OIys8uLjeMWFYVCHGS
	BNMy8uS//fZ+ftwiQ8lfhmsKcZV2G07n/RD7XZUggjnt2j0ZHvQi797/5LPztSg/nGNshU3athQ
	oiv1mJvRqVE1gC50ljRyybfObU6WQZnlx6889R+wHL7xP9g0rfQjkv52c/MdvUx3s4royKsHSBX
	8uZ1Ys6z9y/MVHnlsOAz0YdKxDycrMSI5FbvXvz9r4aQiXMbBK8sPk3AmjgIfJLGPcIFSkBGgAu
	7vncpWpOSrnhQFI1dISO854K5KuDlT1C4J+S2lTsPrubhSEs+B3/JNpSuqiVJh2VdcqS2WNJNDk
	rKt2gI
X-Google-Smtp-Source: AGHT+IGoH/RuGMWJp5pFPSSnRxyPhQ502n9TO/GbURBonjtemqeoJ+7PvwLpn9GhyGwLqklT7IojXkgpe5SV
X-Received: by 2002:a17:902:d4c8:b0:248:a642:eec6 with SMTP id d9443c01a7336-28e9a67bf38mr5983355ad.50.1759439081457;
        Thu, 02 Oct 2025 14:04:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-28e8d19c809sm2189645ad.63.2025.10.02.14.04.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Oct 2025 14:04:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e36f9c651so9693855e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759439079; x=1760043879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C2UQeXeCdd38LZjkJTP74V8I/AwlCwJ5vjuI4bPLac8=;
        b=OFISdMeOfvEKfVtKZGfW3hrRgSBI40m3XgVOdaOCvidXH0/6AyvdqtPti0z0cWhOtk
         GKz3SmMG7NFPshYmzDJjoOOWU1kIg0kEa7o3JoUzPhyT8fRQ/rxEuhR8YxpdyPH696uC
         UUPqL8KsrbM1Sty+5iIvxPRoswBFsyw1wlYik=
X-Forwarded-Encrypted: i=1; AJvYcCULFwc0E7KCUTXk7fiKNV8EAd8TBbnICuJL18g72IQW2Y48PNZIJ4fnefuFM1Whodrhdonsv/ZT0viSR6Y=@vger.kernel.org
X-Received: by 2002:a05:600c:5304:b0:46e:5df3:190d with SMTP id 5b1f17b1804b1-46e7110ef5dmr4793875e9.11.1759439079339;
        Thu, 02 Oct 2025 14:04:39 -0700 (PDT)
X-Received: by 2002:a05:600c:5304:b0:46e:5df3:190d with SMTP id 5b1f17b1804b1-46e7110ef5dmr4793685e9.11.1759439078875;
        Thu, 02 Oct 2025 14:04:38 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5c4c0321sm61711295e9.8.2025.10.02.14.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:04:37 -0700 (PDT)
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
Subject: [PATCH 0/3] sdhci-brcmstb SD host controller SoC specific enhancements 
Date: Thu,  2 Oct 2025 17:04:23 -0400
Message-Id: <20251002210426.2490368-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

sdhci-brcmstb HS200 configuration for BCM72116 and PM register save restore
changes applicable to various SoCs. 

Kamal Dasu (3):
  dt-bindings: mmc: Add support for BCM72116 and BCM74371 SD host
    controller
  mmc: sdhci-brcmstb: clear CFG_OP_DLY when using HS200
  mmc: brcmstb: save and restore registers during PM

 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |   2 +
 drivers/mmc/host/sdhci-brcmstb.c              | 159 +++++++++++++++++-
 2 files changed, 153 insertions(+), 8 deletions(-)

-- 
2.34.1


