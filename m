Return-Path: <linux-kernel+bounces-732961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D884FB06E32
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228654A4CAF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BBE288C89;
	Wed, 16 Jul 2025 06:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAl3t/XO"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F01828507C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752648441; cv=none; b=i5QrrA/FzeCvTNMbUOjnJ4CaYRbnR/DnI8WX+/Csa8PENJzwnsYP118QGHzDomlo74BQHxt7W/sfysaC6Diq3qTvaRp6JewyC6vrdHZt5wf919bVJD0MJOf1cmDf9XhFGhEuaNt61RjUzS2ISA92LYg4boCajUrcQ1wuZrQwUVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752648441; c=relaxed/simple;
	bh=kvPpp9MFKdrAeRON6ELJLTeQ9H2PXdIO/ZWgGBU8IUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FiyLr8s9IamulD6fhr9RZKSB8YqZDDUN13JV6D3zjSYirg0NsoVL1ee75MF+d2txPoqP3NtEkD3lvGdyiu8VHS+sp3k4xKJ/bgM+d2aQxlixpsnA19XHR6AAIeLt/8Qf/AsVa5IswiCvudonhnjcapS+5M6R5ThPS6/I90vy3fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAl3t/XO; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-748feca4a61so3574525b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 23:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752648440; x=1753253240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BXPUv4hT5+sf8WKiS8i6UVurS1TbDz8izWFqwtyzG4=;
        b=CAl3t/XOtsYvzJqMrqoxnpcNCHDq62t4hhTc0uCKtCZF+YbvyQFIjokxO+w2RcuGCA
         LgWV2ZIIohiKFvbhnDqrf4HKL2nPoh0wgqhQ/PY1amfqIraZgZAf6bJSNJgl5RpF4Zr3
         72Ys00ZVaBEgo3AUyXk1O2eF90SXcJfN3/Nd8g41ygDC0bZACncDjD9kjZCRBpShU9YD
         /XmphsKDbt7TeG9N9dWwJSM/RUPN+bqLyrQBBQXeLYF12ziuCRKZYUzS0ZdSayO8HmpW
         cK0R3URMEQfx+6oThYDWViOspbkxOSaN3LBiH2gBg68jAiOxw9g3L3BhisP0ZHMcbHl0
         at1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752648440; x=1753253240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BXPUv4hT5+sf8WKiS8i6UVurS1TbDz8izWFqwtyzG4=;
        b=Z63QmZyGl1sQAv89nZKvgA1TjV/Pl8OYiW9vxY2OnsIAmWBX0zjIJ71Nq+1DbQvEBm
         EUalzSqqg5u5a5d6cv47hzuZDu+7GahwX3fo2abb2VFmAajTWLIAaWcX45rVjTo3fGfB
         Zvh3z6EwfsVmOPh+pqegzNe3QUSIm+yduBDcJzRuRGyH7JAbB59j2+PXfwHvCOB3WUwg
         8troAo1Ube9niPNTWkRY3ko53hUSnHnF2Dl+au3BfISzwmh6CYU2pNB+K7O6noH+g+m+
         mFG1vvuyPh+CKJtmg1hiaMdTBwlK5u7w7ldf1nUPDCnII3CyxclqTL2MKOtiJkzZ6dXH
         mL7g==
X-Gm-Message-State: AOJu0Yxd/WXiCz6IHMPEgmJ3ZijpKA5vJmeXsG3io0hWsOPCKLR3y238
	3GZS2hZSaqcT1EUSQAw5OBAiG+6l1qAvtCaPSAhAov9C1eVh5wkJvUgXlw3BmKfLrw==
X-Gm-Gg: ASbGncvLCvXANhQpfhx1dCH2DM67hGv9gJ7qIn2K3kczuxO8BY8r4s7W/okISOa0Wdj
	drOL8zFVhXPwxyQQKLFhwQMPHM+ya4HTdF1zby0+kflUaHWKT8RJ+6heM4k5YaBLYpR9WRAAP2I
	vyhu+ZPyuFfuZ1BY2O0kt3nH2pCjsaYAKRLwsFV+OqN9pW3OCjw+UYrIDvooVWDu1Br6JHp8Fqa
	Y0n/HD6tZxhpMwTakyJNfUg0AZ+MMDNyok3NgBxgYcPJAtWzGuJVOv5eaXpPD1wsy5Z7rsDtzou
	TjTE4o0rxdOu5waD1HGpXN4W1+r+1flBF+aBlMGKShAedTqsRxEH8L9m7QdyevuBj+PhRNgZYcs
	/vuO8pofnTNs+BTzF35HEk1ZFQLkoExNqT1c+HJBSMopb9wdG6ZngHTnBBmDClA==
X-Google-Smtp-Source: AGHT+IE9mwOZZnfGhVvSf1vEFskUprRoKDGdNARAL9a9dV/1r16DYiMjYxwueqPpHCH148deT/QN3A==
X-Received: by 2002:a05:6a00:a15:b0:742:3cc1:9485 with SMTP id d2e1a72fcca58-75723e744b5mr2006297b3a.12.1752648439639;
        Tue, 15 Jul 2025 23:47:19 -0700 (PDT)
Received: from max-MacBookPro.. (36-237-135-199.dynamic-ip.hinet.net. [36.237.135.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4cb57sm13825041b3a.136.2025.07.15.23.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 23:47:19 -0700 (PDT)
From: Meng Shao Liu <sau525@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	visitorckw@gmail.com,
	Meng Shao Liu <sau525@gmail.com>
Subject: [PATCH v3 2/2] samples/kobject: make attribute_group const
Date: Wed, 16 Jul 2025 14:46:29 +0800
Message-ID: <dc94227eaf337a2b92ab77dffa0da9f7f1f84c4e.1752646650.git.sau525@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5be61d284a1850f573658f1c105f0b6062e41332.1752646650.git.sau525@gmail.com>
References: <5be61d284a1850f573658f1c105f0b6062e41332.1752646650.git.sau525@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The attr_group structures are allocated once and never modified at
runtime.  Also to match the const‑qualified parameter of
sysfs_create_group().

Signed-off-by: Meng Shao Liu <sau525@gmail.com>
---
V2 -> V3: Add missing version tag to subject line.
V1 -> V2: corrected my name, thread the patch series, and remove
incorrect commit message "No functional change".

 samples/kobject/kobject-example.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/kobject/kobject-example.c b/samples/kobject/kobject-example.c
index e6d7fc18e..36d87ca0b 100644
--- a/samples/kobject/kobject-example.c
+++ b/samples/kobject/kobject-example.c
@@ -102,7 +102,7 @@ static struct attribute *attrs[] = {
  * created for the attributes with the directory being the name of the
  * attribute group.
  */
-static struct attribute_group attr_group = {
+static const struct attribute_group attr_group = {
 	.attrs = attrs,
 };
 
-- 
2.43.0


