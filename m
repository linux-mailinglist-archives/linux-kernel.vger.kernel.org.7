Return-Path: <linux-kernel+bounces-823231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9D3B85DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F3B1C269D5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC7B314D32;
	Thu, 18 Sep 2025 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMJuI1Xf"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62154314D02
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210936; cv=none; b=KNy6zM5byZwBV+TYooOS+XBnQBxvhgIuWXtaT62RP6ZQx6Cz27mCkZZ1NAUBELyyOwYKBXVJ5rCKRxAyrbbU1mWYPGkFrEEtQaIuV168zG8YUy8Owm5aduq9sEoyLtR4VfvknDT9oOqFgqX5hAfr4OeCQmU3RRYXSbz5E5N/Da4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210936; c=relaxed/simple;
	bh=9NHi/2Cce6YtYupIQCjuGL2CK/BqjDprlX3JyUrBZ4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OxHijSq45kJ5GadTGlxu6/+AMR09DmfZ2HVUxPs2PtIJvC9ckftDLu1Rg0fQ/2ocw6ODysNWDRvE6YP9xrJDO5gTFwTZMBmjKFZDIyk2AMFmU+YNeiiAhTdiKYa6FhtbOTa+Uhr09zhMjFwgOewnOCj5DLm7vNgZ3m8rhNjdACo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMJuI1Xf; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-8e30a19da78so652925241.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758210934; x=1758815734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Sc26hxDTkdtCvz76lZc7JwNfgd5ybo+08CIFSOrjwg=;
        b=AMJuI1XfjfixM5/oKis4rHEkiwRTugX+meGbo1+YQeHOl8cQqX9WMrCB063+twy++G
         BVDU++GgVpqeY/UpkNvDSb8lWUzWuLn4z3lzCfREOXqVSAkDRT9VxIo/pmjMkye5mEQm
         DgK0GWGss4y2LbhH7KWZlYTkVZ5Ubt1poufoNpWz/qNEBxioje4I+/WKAlaBvJ1S1jRl
         Ac6+fP1x9qpJSED9OgtLt1VuEH7GaoK3dakgKtdD27TtUECZQsmpOmbzfHDM2KKnGACy
         I6hPUYdJD08ySOzg8x9PZnnwpbZaBCqFryYKSRpSfeAxis+4PxuXoKg0g30rtNyVvSel
         YZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210934; x=1758815734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Sc26hxDTkdtCvz76lZc7JwNfgd5ybo+08CIFSOrjwg=;
        b=Gm0BNplJcV7omQ7ukRAaR2n++l5cjQ/eneHFV5faGZdGH1pEX9l4bmVfmUakmLkGeI
         z1hoYeRRFZQOjSXl+2+KsyYRnXV53DFiaah0K79Silq7gQyanvCIn81qhW9LjUy22Ia2
         +wu1lsMBMD55ihKVXSN5dwK+DoMIAv6mrkfVCOaVDRzrUDuDTH3QZlyIcpD3zxociURZ
         slY6r7PQGxsbsBQsmHn1da11Z/GCmv71wkqkLuUsEVWmlMKpwVMa6srQzyD38292Y5VA
         M/8T6c0XZbXBoAepbPfoKasFkGXnHkz1YSBM2HBnoBQJzSuLFpIvCdX3mE/HQ+uJI827
         m9/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXS2xr8FgRNdLmWC5ewMw1q0gnYPiBjdrtm2Ahm99HRSeu9ofik5dyXjsv73UdZrMr0XCJ24uwbwMAis+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA4YwKtYoydsGBCnhA9onJKItXI4Vg9dtNI9zEC03CUeji5VUO
	8dq9fX2FENu9/DAYdk7dEs/a06ezw/GvomBNV8Yv6sOys21GBuSuGybSlFx1ikC5m8E=
X-Gm-Gg: ASbGncufiyTBBJJPUxpYuA0AgtIVxogkcJv0tWQw7gYl1emhT/7lSwNpKa5wP/cDC3A
	A1GxfYTZ1ZsQimDUspz6HxBjmdwXZF1Skxm7As1ufI/FvUjqoBEIP+Jd4/9t34j4hUXHU6lCvFe
	cNfiDmYnuwR8TS9kwCvtHby4cFxhO1NxizjFXEbuF2AkvMp4Z1djZ5Tz1gA3vO+Xdrgj1ZM0CcH
	HX0fonRh42XF8wuaTUIz/YUsWCC+9vpuPKgU4c2Lo/CaiNRBkaruB9+i8aeyZXk1nQU9ed++X7+
	ng7Dpp/7KraG56Tzp5TqFGzklJciE99UK7zmiaGiNWsTw3uPHwyUy6FDtZ2aiutpMXkQ4dGhNG6
	3oq0dEcEY3w7+YWuRw16J/KIMDd770/AiR2TlBwhMtg==
X-Google-Smtp-Source: AGHT+IF9suJfr/TckXhc3x4V/Ham0gaboRPTGKUywBt8FfSoHGxa1LjxFJVx6FIwVN06VaKFltF9Bg==
X-Received: by 2002:aa7:888e:0:b0:772:499e:99c4 with SMTP id d2e1a72fcca58-77bf926881fmr9331092b3a.18.1758204996072;
        Thu, 18 Sep 2025 07:16:36 -0700 (PDT)
Received: from lgs.. ([2408:8417:e00:1e5d:70da:6ea2:4e14:821e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cff321237sm2490376b3a.102.2025.09.18.07.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:16:35 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Santosh Sivaraj <santosh@fossix.org>,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] nvdimm: ndtest: Add check for devm_kcalloc() allocations in ndtest_probe()
Date: Thu, 18 Sep 2025 22:16:06 +0800
Message-ID: <20250918141606.3589435-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kcalloc() may fail. ndtest_probe() allocates three DMA address
arrays (dcr_dma, label_dma, dimm_dma) and later unconditionally uses
them in ndtest_nvdimm_init(), which can lead to a NULL pointer
dereference on allocation failure.

Add NULL checks for all three allocations and return -ENOMEM if any
allocation fails.

Fixes: 9399ab61ad82 ("ndtest: Add dimms to the two buses")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 tools/testing/nvdimm/test/ndtest.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index 68a064ce598c..516f304bb0b9 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -855,6 +855,11 @@ static int ndtest_probe(struct platform_device *pdev)
 	p->dimm_dma = devm_kcalloc(&p->pdev.dev, NUM_DCR,
 				  sizeof(dma_addr_t), GFP_KERNEL);
 
+	if (!p->dcr_dma || !p->label_dma || !p->dimm_dma) {
+		pr_err("%s: failed to allocate DMA address arrays\n", __func__);
+		return -ENOMEM;
+	}
+
 	rc = ndtest_nvdimm_init(p);
 	if (rc)
 		goto err;
-- 
2.43.0


