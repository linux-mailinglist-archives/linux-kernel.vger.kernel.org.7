Return-Path: <linux-kernel+bounces-795044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 902FDB3EC3B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47D63B9744
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E86C3064BF;
	Mon,  1 Sep 2025 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0Ql04zS"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E0D2EC080;
	Mon,  1 Sep 2025 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756744391; cv=none; b=FxDzqlgXH20PXUhKHTxOS73cOx1DJuIRKrslJNnA4QC+3BiGbF5cvhM/HwhE2YSWAHRftfIOQdMmQC403rR+3FEBHZMzsQ452/i3hqTY5aH/9iSfRZI8rlAMNPnGJ6osyI5I8YDh9gdlU3FKsKZqJSo45psBQetmrh+qHm/Q6GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756744391; c=relaxed/simple;
	bh=wBVV8lCyWpzak5Ahq0TyAHZqwjZBUNzGkG5CgU5NEkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLQHKnKcx0E1n7o/QKgi2ZAy7j1n4WAui2RLQD//Kqe/nYKcN8QPzo5/WxQtE9QT2QZKEYQazqbp3ZRFcsAvIUsNRw4J+zFVs4UktHVljqNL39Cw60ah+4bl6Kq/GLkvNJDG9iEjam+X8lj/XvyGCgiLMeX0M9fxicrGnupKvQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0Ql04zS; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55f72452a8eso2219264e87.3;
        Mon, 01 Sep 2025 09:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756744388; x=1757349188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvGFPcLRQG7NDdcutxPYCIPA441LFKGMfIhq/xAeHWw=;
        b=h0Ql04zSGSubiWQspNo1Vv6iJbISjyVXHC5Ezic2B2CiXcpen+1hNCAQQWjC3JgYFC
         GaOPhU/GfUv8lRmkGMPEWcwywngegfCpNm5GjKz0r14eeA+wXo4wx7qst3eMSAsFDRbt
         zU8pQUikBF466bBnwSJiUStGgZ3jI9EwZWPISn5+cFWljsUqEQlgD5uoRQvtp6Ktbeuo
         Cv0ZPm9SZToJ2NjX8JMml0CKCKEl95CQg8BPPMoiFKrKT0pyFHL9557wZ5Y+sx8wpNp6
         stsACoFFMth7pOTUXg9M/5yLQE5lQ/B8Y1U9GLCaw4+lRjrPbCPDHMDkrED2lkFuUAl8
         Lh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756744388; x=1757349188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvGFPcLRQG7NDdcutxPYCIPA441LFKGMfIhq/xAeHWw=;
        b=LD3BGSXxVSR9I9Vlux4Gp7rdML6FOTeQxhhB8gHXsYtcs4eiMokL/sbgc5oESkmrls
         D619d7J3y5dCjcpZT4fvgFIbt/ME2rEz4XzTgNtn2rhQ28PRo96CNdmIx/4I0weFCCb6
         n2XGCvxwo/qxlMYYhLV6PzirY52LhIRgugCWGeW1hQsk0BIWKYbH8qyvcBiFTa91Z3/1
         9e/1Oe6d9hb8iPLzGJ5ZNcHyfKox2JKJqxuDkozUauQoTUMIgbQOGXgb0h3pH4ZPUzUr
         JSY/ikxv0BasP4kt6hDHJ3PQwUrGJ7A/jtYW5oYzOfo70inOXo9ddKeKpKzJtNCgzkk+
         Sb3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2R3t1xP4AGP/avXf/lWoaCyKJxN+ROn1eYwluhpBuQlvZ5i7pEuxHCXlKD9nvcuz+g6sdTcU4kA==@vger.kernel.org, AJvYcCV0oqgxI70uCV4hBmKfGP9KCZET8ltW9wBsAqgQ5tyQYSkKAsyVMUMzW1FBzUgnR75pEMyjGT4gAo5lLiNF@vger.kernel.org
X-Gm-Message-State: AOJu0Yymnlo/2wv5GOCllc0F9FZGaakFOFVaghoCsBDK/eKfht/dQ3HP
	/3n2NEZrpyxqylOx6w///frm2tZBNMMrzVXoBqddcsw17Ds8ZAQexVUX
X-Gm-Gg: ASbGncu2qxbC04sizlzDk/yLdWmKOFQ3urH4EJqR+GRSjfqa6q/PXAvgYiOiB9e3Dw6
	U6cCTpnMWVbVXljCtOeh0GZbIfgTXfrEFCqiffyzx6rNneOY7uGPZQ83LYKu71bHJK6XA4pqWvx
	2T5xcYsrDr8+6hD60fKitXh05qWzwTNP0vroOi7wLIXa/V9AZKbWiLF/I7Hb8M+obW/GhjbyH2A
	Lceqt+32LJgGWuJjIvJQyCDtPJk66AjRdu9MYpr5GhzL6g5BxpgM/XoxqQcppyBFJU/72G73nEk
	fOS9fDHSHfXommibAGsJAbWgrkWDdnyDwBGYs7i/Pj33Gn0aQScIychl7PNLmAIgNd/EA8tNAil
	t/ChCSR/EOvDDwP6KAaWFtezbpaC2ZFcx9evhteAvew==
X-Google-Smtp-Source: AGHT+IG3UXE73EbhUolTZUA009n6afCvf/c7qZpC2nZYu33/7lnWpLXjusYs+O+48Y7iJdz2RPqajQ==
X-Received: by 2002:a05:651c:4183:b0:335:2d39:efe8 with SMTP id 38308e7fff4ca-336cb148b70mr21019411fa.44.1756744388011;
        Mon, 01 Sep 2025 09:33:08 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([88.201.206.176])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-336d0e78e82sm15291861fa.53.2025.09.01.09.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 09:33:07 -0700 (PDT)
From: Artem Shimko <artyom.shimko@gmail.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Artem Shimko <artyom.shimko@gmail.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] firmware: arm_scmi: add missing spinlock documentation
Date: Mon,  1 Sep 2025 19:33:01 +0300
Message-ID: <20250901163304.2504493-3-artyom.shimko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901163304.2504493-1-artyom.shimko@gmail.com>
References: <y>
 <20250901163304.2504493-1-artyom.shimko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a missing comment for xfer_lock spinlock in struct scmi_xfers_info.
The spinlock protects access to the xfer buffers and transfer allocation
mechanism, preventing race conditions in concurrent access scenarios.

Signed-off-by: Artem Shimko <artyom.shimko@gmail.com>
---
 drivers/firmware/arm_scmi/driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index bd56a877fdfc..6828392152f4 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -76,6 +76,7 @@ static struct dentry *scmi_top_dentry;
  */
 struct scmi_xfers_info {
 	unsigned long *xfer_alloc_table;
+	/* Protects access to the xfer buffers */
 	spinlock_t xfer_lock;
 	int max_msg;
 	struct hlist_head free_xfers;
-- 
2.43.0


