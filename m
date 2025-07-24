Return-Path: <linux-kernel+bounces-744412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D8BB10C8D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76EB217B4FE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5102EA74B;
	Thu, 24 Jul 2025 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q+n07aCt"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141CE2E7F05
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365404; cv=none; b=OcffIHrj9Y8pDmX1MWHy+JjtaZWWeUqXZw7hW0lLkEJbV1Q9awFIURHMAltK+QBriTKJPolv2xmxfAHlRUtwMGg+XlEu599NdPEX5HtHW3Gnz8Wh2vG2DSVdr22zlMULsaDUwy8urpvYRUfmq3JLvHOxt+vC8DP8UQEP3y3AFas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365404; c=relaxed/simple;
	bh=j52yzR7Gpkc2C7QzVnAL6OhmqWFXWx3JwzJVokNsTms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umAvOhIe9lAPtD9HMDLTCDjmFZNjyXurAe/igNSy7u1F8lFrV/i0gUNG90DZjq6YcF5qInMYXslLuPonul9HQniXok9v+kbpbo04bf+I6qakxR2NS3DEA6AGkMI6LQJjiI2R/pRXZwTuS5cjaea+5yV1O896pc57qXL57I1zDss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q+n07aCt; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45611a6a706so4974115e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365398; x=1753970198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phPxbutaSa2cHj8lQiAqRNXIpOiUr1sfgJg1sLmhr6Q=;
        b=q+n07aCtzLI5b5OprZDAIq8uAz3mWb20L+1xonnsPcouJj98jigrLf3qnMfoFVGfjI
         OeM+S05Brccvs8IcQCcBzyyTuTZArzaZr8h9ZMfyRrLigg0kpO725gQN5XC2ZzbVUM7L
         y0SjDNgVhz1kD/1GqaIOIxzY9rvg50jLnvwQKhgCp4qLn+r9PwtjQG5brJ+1iI2y9KoD
         kezpmDXrZh+N2x4Ohl6XzyCKFMsfeS0oratUTsc7VHeirpSYKt0fwdUtrXfb5e2FHUE3
         cs7nx92cEbIVH0knZ4w6CwYkO9geZwstvRoJzP/BrqrH7YGor0OWRBqmLrF6Bzl6P2Wc
         fJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365398; x=1753970198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phPxbutaSa2cHj8lQiAqRNXIpOiUr1sfgJg1sLmhr6Q=;
        b=mpy/ssjPd/kURJprkK0zfulJRo+SnJRCYzgxFeCzB+30IyPixCaUYoVI1XDst9sQoJ
         68E6h4i+SpnK0b+a1Pzqeg7UbE/7S5TuX9Ge1rjKnBO7sOCvaQJOWGALD94qU3lVgY3c
         9+Ldx8D09FM+2UpdhIr6LDZA0hnJkJ3ZeGMUZngF6H5HTsKzTC339PvteNvHvPyuyvQ5
         GTrSESj4MdPhA+SzYPVUH5utZRCi66+QDlhR0Uk7JhF2YVgieuotsoxkHGnfaSkHku3s
         AFnraFtChM4ZLq9shmh2T5+9sQERtUy/pZz+mNUECTYQrNFpTJVCYMM8onPXocYfkm5n
         tTuA==
X-Gm-Message-State: AOJu0YwirhC+faQwrvai+bvBtmwguEDptIi3+odEX5ivN1HbQiIUvmq4
	HTatbrYA/rwkuCh8/Avo9Q11J12w2RFV0aIi5bxldvD11dqUxziCEisnjdc2jvtlX2pZZz6sw76
	n/FCFDeg=
X-Gm-Gg: ASbGncvXZKec92sKRcoova2dmasElcamFFs0re140ZBxJzQeRoD6aLPhazxQ0UJQMkK
	TDQgL0N/GJICB1Chx4tlcvlFbGIeT5AC+vvk0KBOJ3SlHg8d2KRpsBaSZrfbfG6zwfDLMdt0gJY
	O01BQ8UVEbxGcqUn9D84juEmR6nGPxhuwaeSuvGxJHyZD76td3Z5rEGC0BP/BwJcDUcjt/8AoC6
	yznjW2gUBeWPxvQ+MeGStCSY2IdQuY2MiL3Fb0fcDfcwBCuFxdLcdSxh7WjCd18FXh0ZDmS6+pD
	r8d1FkyjNeyXDfkVUzgF5fgbBLNZy6E1tBujaVenrz/KaaJrXx3gelAPDHKR76osQV9+9OSzbyu
	VhX5oa0tDnVZKqGyif3zCUi8BAK8DcaDkCE00LDN8Jdeuy5c01bqEijFERYdDFlERONLywTagR7
	1gz9JJgXxKwTQx
X-Google-Smtp-Source: AGHT+IEzG7rA7SjcU5/IexjXqSf6MXBAUKpIcrbkFM4DkAzOo8wQtcA8euIhs0yEfuaDr3L1GJYTKw==
X-Received: by 2002:a05:600d:d:b0:456:207e:fd83 with SMTP id 5b1f17b1804b1-45869ea827amr55222245e9.4.1753365397698;
        Thu, 24 Jul 2025 06:56:37 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:37 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 17/29] mm/swapfile: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:00 +0300
Message-ID: <20250724135512.518487-18-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into kmemdump:
 - nr_swapfiles

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/swapfile.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index b4f3cc712580..ac5a2307a278 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -42,6 +42,7 @@
 #include <linux/suspend.h>
 #include <linux/zswap.h>
 #include <linux/plist.h>
+#include <linux/kmemdump.h>
 
 #include <asm/tlbflush.h>
 #include <linux/swapops.h>
@@ -64,6 +65,7 @@ static inline void unlock_cluster(struct swap_cluster_info *ci);
 
 static DEFINE_SPINLOCK(swap_lock);
 static unsigned int nr_swapfiles;
+KMEMDUMP_VAR_CORE(nr_swapfiles, sizeof(nr_swapfiles));
 atomic_long_t nr_swap_pages;
 /*
  * Some modules use swappable objects and may try to swap them out under
-- 
2.43.0


