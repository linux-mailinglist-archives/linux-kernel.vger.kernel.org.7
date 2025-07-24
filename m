Return-Path: <linux-kernel+bounces-744407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6631B10C63
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4561188B9CE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1FB2E92AB;
	Thu, 24 Jul 2025 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NhHBBf8J"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13212E6108
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365399; cv=none; b=dYxBNGiNvNuBgcRb/v36ob9uAtQuRZIit+5z6YLw+yGR7Ny7T89147YFZhmYGQyhYaJDYjNdmDcWgs+++JwtHhxNbO76y3MKWiejZOopv3JKVeGhjvH/PtOCsB0wt8Ng1Nh5iHbtzUq3oVLCol4DjJEK109BIiBkcOMKJIAUmgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365399; c=relaxed/simple;
	bh=QpOyX3O1zVluz5hSldO4dnPU9Pz5bkE/gs9RkenFruo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UibORWmlQfeDUfu2LI2oZK5zHxVQop1VSDnnk6otDEf/Z3Cvel8T1HCL45kre3o1AmaymHrHh5jtBPnlv2DtMnob0yfX5t1bI6rkizMuip/rPa451xYuLFLwYv/Dbnvq4cmrXUYvWIYDN+dnK3m5eU1TxHBOt4ks8sh4LMBOkSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NhHBBf8J; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-455b00283a5so6422395e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365394; x=1753970194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6EjHBZibILbBUp2qJIWYHcXS7kn/hLDSQS+TJg877Y=;
        b=NhHBBf8Jzh2UWPCgsbFcY8aPFwvtxFOq737cLLsrQCZmRgkKkfwMJqNysXsBL8QsXC
         qmzgwjtJVYsVGW89ouotrXqKPHH++Kh+n8fzAJGfeTQQgN3xUx8umehWdVe6hxnncmui
         vMMx7OFls9lkmSMYrkbutgmBveGsrwvyQbxtNkw54UmbUH8TGVbf+pntg0yVwqDgKKpp
         sW91XbQn7lQRduhAgmkL+m0wfWr/G35EOLGF3ls9tPJArHfaRx2kec+lQcZd5sYG22Ty
         VQjkDwvKt34FiJcreuIkEXHvXuP69LMFBp1pM/55KiGjJ4nmzQMUSN1xoQGuC6LmZbcE
         fGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365394; x=1753970194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6EjHBZibILbBUp2qJIWYHcXS7kn/hLDSQS+TJg877Y=;
        b=CZrp6fprjPTz1zLhxhdThXJq7p3T01NXwxc/XBt6UF6vXvFVhODKzZ3diHjdXhTDah
         jZ3vatPBLgitK6TB3jwwPSP1NecThLXnE65r1xbPFuH7yBexKJB8wejnyEURG5dOs9kP
         q6VTAa2S61YbltL/ec3iWE8KMk6sbufQT+g1TjjOxSa2qEg0Oz0FOc9YUvhiGFUppmcg
         mYGrobc/9xvDc+D0i7CkaXStvSj0ByEiuAVuo9YAkC+1l60sX3FtymGIAgVVrdg9t/3C
         urR2eObhCA0rMTA7cBq35qrAfmZ27FPXbuMmJtBBsV0UMBD5gWKZG35icb9f+lbLHaWG
         X0Zg==
X-Gm-Message-State: AOJu0YxrxOuzJWQN1T5h0fu/k5FguapJTxV1D5qEENbQdl7A94+2FZno
	UWbZA4zEqgHsVHOvd/zBbbtdJsrRs+/tx9UmBYf/XDCOJynV0UJSTCZLUfyqazywINQGmxxXm43
	hD5xAL/k=
X-Gm-Gg: ASbGnct4QW0TJZomvgueA9R5jDRq8+AT9EE8Cf1Ov824E1MowcJZvt6xiduB/dOeOJB
	8yCnEMyVyeDqQi2SXu9vp5X8PPX2uy3ju48pkx32KbWKWmVm0dzoby78iaEbcwTqY4+RMcexz6U
	gczHx76l1v1lYq15GcrZshPPcSOD/BoGL0Yr9SMDtuHzMOa9Y7YMQ/AkvJPcaiOIWpllCPwIU3C
	UwrXpSStrIs/MumlQUbPxGQYB9s4FRyYQbCrEO3eE+Y0DoxlF7m3yFdENaszuapCB28jLtj9+/7
	n4/0LK341CXQPwRwt7s3YbZEZGyNsVemGfJVz07LSPfTuP0ZqNHL47C2EEtUHxfYa13K5fvH70a
	sKj48sk5ZRY2AVMqxL1oUFWAWP71BIjX8Iz0xYUJwHl5CE9DTilqHdVJbLL19GNGzCnV4UJeBrF
	BmwY8l7M6QTgBx
X-Google-Smtp-Source: AGHT+IGRlGdpZ28v11nrKuEy26SoaDmKeIQI1w12F1VyMMK6OUtkgi6ZkZkyO989nTl8PB59Q+K5gg==
X-Received: by 2002:a05:6000:290e:b0:3a6:d7ec:c701 with SMTP id ffacd0b85a97d-3b768f1ab39mr5321094f8f.30.1753365393821;
        Thu, 24 Jul 2025 06:56:33 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:33 -0700 (PDT)
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
Subject: [RFC][PATCH v2 13/29] kernel/fork: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:56 +0300
Message-ID: <20250724135512.518487-14-eugen.hristev@linaro.org>
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
 - nr_threads

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/fork.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index edc6579f736b..ae8ae9b9180b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -105,6 +105,7 @@
 #include <uapi/linux/pidfd.h>
 #include <linux/pidfs.h>
 #include <linux/tick.h>
+#include <linux/kmemdump.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -137,6 +138,7 @@
  */
 unsigned long total_forks;	/* Handle normal Linux uptimes. */
 int nr_threads;			/* The idle threads do not count.. */
+KMEMDUMP_VAR_CORE(nr_threads, sizeof(nr_threads));
 
 static int max_threads;		/* tunable limit on nr_threads */
 
-- 
2.43.0


