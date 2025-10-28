Return-Path: <linux-kernel+bounces-873019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D54FC12D7B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C643A3B0172
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64AB298CCF;
	Tue, 28 Oct 2025 04:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlCDlk2p"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5112882B7
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761624659; cv=none; b=H5QX5jOP6cCCGKifF1C5PnDdfprEwTyvtzCdJx8AItGfNF1GxtARwNMTahX0ANWeCvYi1weBWdHgoAmkA2lUe/vBcQr8NnXSjhlmYRkXBiBr7gAhrwoN+dsrld/UNNtGwTFOLdpDoreoNzpg/Vq347PRGxB4WDlF7kPcM0r97nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761624659; c=relaxed/simple;
	bh=AtKOGqCoRvLS9nhFLSgO+uSH2h9BAA8HUM3chLNgf9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rUjh29LjQKwf9miCpEdpcSebX0hfwgvxu4hv5esS4w9GHb9es0pd/xmD77QTIuePEhDGGh4MjIs+u652caMYBdqiG/o3S2KV5FMS7tdI4fzcpvQ2dOftLtjYUHO+m02bc3BfDNe79h3NRzF+r9Ry5CTGf5NdKvIDCe0ZAUhySwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlCDlk2p; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6ceba7c97eso5112794a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761624657; x=1762229457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ct3fZhejSt6azXQEGIIev5bJeimWjXEXm2EsgfaLruk=;
        b=PlCDlk2puN48pBARNFZijAmEK99yoUastQNJPt9+FwwoZ0+WjsNsxQDMTHmnb3sMt+
         RUIgI2gnJIElsZzA5h6eDOqJx0HfjSg+IJA1wpzzPuxbVh3zyCcTAKpHCWtvqGahcuZT
         saj1hLk7TLzbI9WgDxNP2FlEfebJVKrI+4PXIgxPGG4Hft4t8V6A6V4e2jaY/pL6z+bk
         frYOzh+XmMj8M9i70xsG+RFGibtHMYBdvx6cihl+N/jrpyjYU1rnEI+eRlyeoDeAuoGr
         PHgsBy8F+vRaLzXyUdsmzwIulhyHsbIo6XuX0nLnS4G7iEBkrIHBfwk/xCaC9+1w0AMK
         +/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761624657; x=1762229457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ct3fZhejSt6azXQEGIIev5bJeimWjXEXm2EsgfaLruk=;
        b=MdkJrLYoqmhWetStYPqwwe6Ah57XsIf0W4YJoX4ZXEQNVS+4evCYozmGD7lBrtZJZ+
         0LB8ruOxJU3eBclrQt0vYIasUBef+S7b0CyLEOQB30gxk580MTMR7MTpkc/zDosI25zK
         xT9GEMJFQgM4hBuPNuZYxxPlojBvbMJNQaldWhhD+LRli32A2VwbpPMeHfYXYlGFwwyP
         X3VcXFxdOMSm99u9oTQjydA6VmS/JnGiecADjwqgt0WdNcMUDex/ZVPrIN5rE7JJEzJt
         ZjE+tpyM9EGbWAEQx1bOjPbz4MOW8mQen7ezS33ssZjGueGfERy9jowy5L9OrAOEA3TT
         YFaw==
X-Forwarded-Encrypted: i=1; AJvYcCWfqY1sdVyIBPZyOJCPQdi5I5cpXRhVWFItdu0eP0XmC5hMzriKqfuDG9ViyiWMu0pIiQCCtf+F9VzQxBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLEeomjjskEpRfPMKvuqZHds8BNkH8hZo9AZeMjZu3pxDG2Qke
	YfsySboEmonxNAONDF5LowIM6Nx5eH9au6yFGJt96CY2LTInMARksGN3
X-Gm-Gg: ASbGncuDenCBBJYLuAQ9E1LmzSauGxPmYIE5MxZwPtnOWzGzjIF+ZxjBXMTs0qRHt1H
	iacJBCKJsFzZGWWO+4Sss5n/I4bYLp/IhBOeokJhX64v0VHifRPUNJl1Rv4UtwYR2kzDNxW9ils
	bM68ZfP5YUbt0elWqKpYbM+7proegPf/XQCTXvU9e6LFN++YK+UPvKE7jVkzr4y1vAwsGzsekXS
	4KFRiQl6wsPd+bTzPyvNsm7Zt4ZiECrSV2CFFgfu9FthbfPf77bzEAXk2AuOk//O73oktm3chL0
	AFt6IRdwNsSjJveJ0lWAKNtXmkoJcogbsh1vtI/gq0SqlD121E0gQvb8NOd6XGm9N/9qzV+WayG
	JhgHeUXkrVQEGn+lX0HSpr4DWy09toeLhXaqQ7vNmkbzX2qWUguqE/Ec46Qugf1DlpwZfgEBjdt
	/gMjrGxfJB5a/VLzP6wdTGaA==
X-Google-Smtp-Source: AGHT+IHwfz1ouJdbUs7lW8MAtJV14JfgzopRaooMgIeeKG6B+P4jnBmcWNKe4LmDGl9zH7XRHwYM6A==
X-Received: by 2002:a05:6a20:3ca7:b0:2ff:3752:8375 with SMTP id adf61e73a8af0-344d3a4fdbamr2689081637.45.1761624656788;
        Mon, 27 Oct 2025 21:10:56 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b8087fac6d5sm3535839a12.15.2025.10.27.21.10.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 21:10:56 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Thor Thayer <thor.thayer@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] mfd: altera-sysmgr: Fix device reference leak in altr_sysmgr_regmap_lookup_by_phandle
Date: Tue, 28 Oct 2025 12:10:42 +0800
Message-Id: <20251028041042.48874-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

driver_find_device_by_of_node() calls driver_find_device(), which calls
get_device(). get_device() increments the device's reference count,
so driver_find_device_by_of_node() returns a device
with its reference count incremented.
We need to release this reference after usage to avoid a reference leak.

Add put_device(dev) after dev_get_drvdata() to fix the reference leak.

Found via static analysis.

Fixes: f36e789a1f8d ("mfd: altera-sysmgr: Add SOCFPGA System Manager")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/mfd/altera-sysmgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
index fb5f988e61f3..cb66b2fff536 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -116,6 +116,7 @@ struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
 		return ERR_PTR(-EPROBE_DEFER);
 
 	sysmgr = dev_get_drvdata(dev);
+	put_device(dev);
 
 	return sysmgr->regmap;
 }
-- 
2.39.5 (Apple Git-154)


