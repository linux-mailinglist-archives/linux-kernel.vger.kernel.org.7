Return-Path: <linux-kernel+bounces-852010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 767DABD7F17
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214D3427349
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71492C236F;
	Tue, 14 Oct 2025 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PEDUWIiB"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2EB23CE
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427124; cv=none; b=P2VgByNLYDXMrhiXl2WawBUutut+pbMhyp6RkxujIySDVqEwvVMai3Z/iSPyrYVXQVlbes8jiUnjKs6QgVKznPiNh2SEt1YE60VlyxiJvxzDwm3DamVr4HZA1xua5+PiULbdR+GMyv8I5HI2ki5WH4gN/wERbNMm7fa0+05jDYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427124; c=relaxed/simple;
	bh=dVCZrCuq+ZctBuff8YlX99sbsYb/Y49Q+wQM+I7d7wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=miJbF/lDbCYw6HBUrx7QwupxjMeMXrBccW34q7/4607OJN/A40/ptE69eCv4Xqs5bPmp0fhU9vRHWKp2HO0paZBKd80ZOCe3m9jCr9upCNb1Y0JRJurvQttqC31E5CvSmjfhbH7chSJbPw23maev4rjYm+w2umqgreu+C9iFIQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PEDUWIiB; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-634b774f135so7942826a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760427117; x=1761031917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DXZZGW1uWPjZtrugE9+8JJyhpGziKLqQludy7yN6pDk=;
        b=PEDUWIiB0rpNXVzxThn6ZSjTGHuWxtsGzfq9nHct+xtJK1RAYcPRWoG9RZGwvk4xOW
         CZUmykrSphqB+NteNfSsv3iuHXyG4XIsLKi2kBKpIkCUI9JDGPrVCYn29VdsLOHB9SHt
         bPoGy+KXfdWwGJWgnbvspe1W4oogzv4od4Va/hKkpO4VxolRo7flYi3Kr9oGzlzElh3+
         31N1cr6km49qF/RSEE44EVQPMeTCRTTmBRP5jPFliMpixkmtbfMGnwyEu3d+WM1guKRg
         pM4NtRg+oyEMmBFPcN5S0emQFBRzq6Gt5/GW8K7SSNJeU3ewVBqbKxMNT1xyvMFcelcC
         MKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427117; x=1761031917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXZZGW1uWPjZtrugE9+8JJyhpGziKLqQludy7yN6pDk=;
        b=KwDvWt3XUg5mwJGP7OfzwIURCYoSoEgPbCXoALBilElolBTQWrWFna+mSDi5LcxUB6
         ru3B1MT1X4M9+FMGeOPcHCi+g/UnhatH1rYTZ2aIRgUCWLBEr+6vPNPonrMqyTi9Shbu
         aJgGEyohhT5MHIP1qIiHyR397Bk9Y5LIh6lXkU29/0QNdQUfsf/C/zw5Ll0jAM/A9nJ8
         eSed7omuEIN6L1oGGf6IA9ImeuZzFhGneOGX2R6hq5eN6GAwFXpuQqxw6FUx5MSkh2Ip
         YNmwv/XZNe4JbBwV3OIK9J9xBjlq1Ep+13M+mVXRvr9SsfXz/PIwgOBmer5A0J7MqhJJ
         hFMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS0CGRz8UaxtQf0+VKyhFjrnO2VHziFGrq3yVBLF8CCrFQgLNqAb5UOd1RGtG7ULsizpMCqZrdCCCA9EA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf6dHvXTPM8jCFOVYafG2/+I1Jk7qLqG0dHWExsLbx3R9qFBan
	FHu2YaFN6kp72SKMOtMK5Z2rD3+lg7/IHPXOGCZrEDVEmwfpTzUFhWpApoUyAOPRMjs=
X-Gm-Gg: ASbGnctc8X54RrRWLvq4Vqd9UqbkGo/U1kH1CVL3tuZaFrpH3CCMmBCbi1pr2qG5GHJ
	ZU+TRlJGvn0nCiEPyZ8Y60JXSb1DCKVnRQiF+bPJV+jffeNe1I0H4d/R4Tu+tplQq6x64elJfr1
	9cC4Zi7gK7S8OuSZTahfPrvRXxFClaNUSuuJo79RGvTSNn4dCZ8HrzgWmHOVNAeWG7vi8SM5xHN
	TTKHO75xhFoOY1hT4D58GfFW41ivbCWeq4YuW8PlBN2ELfhNgfk3e0ue3OgfxinUqE8ybSBFiNC
	NU6IlAYf4ecxVa9RqfPRxCoQ+kLkT0Z/LB6kRpgoIiQAFfyue0OUj4rCDonTsbzn9cFHyNOtrV7
	RKzachjzS8tqqhfg1M845cIIE7PgHgL2uEYaNlK1JEozWrImSurptKYjPvmKBG+kEK/9fqlhrui
	LBuXy4ENRbjWc=
X-Google-Smtp-Source: AGHT+IHKJefVpKUeKL/wI+HS+0ovCB1d0pVYRlAQVBL4u1wtot93EtcuA0IP5nStKOmwdm/Nsj0N5A==
X-Received: by 2002:a17:907:7213:b0:b41:a571:21b0 with SMTP id a640c23a62f3a-b50ac1cc421mr2370839166b.39.1760427116641;
        Tue, 14 Oct 2025 00:31:56 -0700 (PDT)
Received: from localhost (host-95-247-55-253.retail.telecomitalia.it. [95.247.55.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c12ccbsm1083131366b.46.2025.10.14.00.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:31:56 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iivanov@suse.de,
	svarbanov@suse.de,
	mbrugger@suse.com,
	Phil Elwell <phil@raspberrypi.com>
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH] of: reserved_mem: Add heuristic to validate reserved memory regions
Date: Tue, 14 Oct 2025 09:34:03 +0200
Message-ID: <20251014073403.32134-1-andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When parsing static reserved-memory DT nodes, any node with a reg property
length that is not perfectly conformant is discarded.
Specifically, any reg property whose length is not a multiple of the parent's
(#address-cells + #size-cells) is dropped.

Relax this condition (while still treating perfect multiples as having higher
precedence) by allowing regions that are subsets of the parent's addressable
space to be considered for inclusion.
For example, in the following scenario:

/ {
        #address-cells = <0x02>;
        #size-cells = <0x02>;
	...

        reserved-memory {
                #address-cells = <0x02>;
                #size-cells = <0x02>;
		...

                nvram {
                        reg = <0x00 0x3fd16d00 0x37>;
			...
		};
	};
};

Even though the reg property of the nvram node is not well-formed from a DT
syntax perspective, it still references a perfectly valid memory region of
0x37 bytes that should be reserved.

This has at least one real-world equivalent on the Raspberry Pi 5, for example,
on which the firmware incorrectly overwrites the nvram node's reg property
without taking into account the actual value of the parent's #size-cells.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---

The aforementioned heuristic has been tested with several combo of #address,
#size and reg length and the results are shown in the following table:

Testing #address-cells 1, #size-cells 1

len     |t_len  |addr   |size   |#ignore
0       |8      | INVALID
4       |8      | INVALID
8       |8      |1      |1      |0
12      |8      | INVALID
16      |8      |1      |1      |1
20      |8      | INVALID
24      |8      |1      |1      |2
28      |8      | INVALID
32      |8      |1      |1      |3
36      |8      | INVALID
40      |8      |1      |1      |4
44      |8      | INVALID
48      |8      |1      |1      |5
52      |8      | INVALID
56      |8      |1      |1      |6
60      |8      | INVALID
64      |8      |1      |1      |7
68      |8      | INVALID
72      |8      |1      |1      |8
76      |8      | INVALID
80      |8      |1      |1      |9
84      |8      | INVALID
88      |8      |1      |1      |10
92      |8      | INVALID
96      |8      |1      |1      |11


Testing #address-cells 2, #size-cells 1

len     |t_len  |addr   |size   |#ignore
0       |12     | INVALID
4       |12     | INVALID
8       |12     | INVALID
12      |12     |2      |1      |0
16      |12     | INVALID
20      |12     | INVALID
24      |12     |2      |1      |1
28      |12     | INVALID
32      |12     | INVALID
36      |12     |2      |1      |2
40      |12     | INVALID
44      |12     | INVALID
48      |12     |2      |1      |3
52      |12     | INVALID
56      |12     | INVALID
60      |12     |2      |1      |4
64      |12     | INVALID
68      |12     | INVALID
72      |12     |2      |1      |5
76      |12     | INVALID
80      |12     | INVALID
84      |12     |2      |1      |6
88      |12     | INVALID
92      |12     | INVALID
96      |12     |2      |1      |7


Testing #address-cells 2, #size-cells 2

len     |t_len  |addr   |size   |#ignore
0       |16     | INVALID
4       |16     | INVALID
8       |16     | INVALID
12      |16     |2      |1      |0
16      |16     |2      |2      |0
20      |16     | INVALID
24      |16     |2      |1      |1
28      |16     | INVALID
32      |16     |2      |2      |1
36      |16     |2      |1      |2
40      |16     | INVALID
44      |16     | INVALID
48      |16     |2      |2      |2
52      |16     | INVALID
56      |16     | INVALID
60      |16     |2      |1      |4
64      |16     |2      |2      |3
68      |16     | INVALID
72      |16     |2      |1      |5
76      |16     | INVALID
80      |16     |2      |2      |4
84      |16     |2      |1      |6
88      |16     | INVALID
92      |16     | INVALID
96      |16     |2      |2      |5

 drivers/of/of_reserved_mem.c | 88 ++++++++++++++++++++++++++++++++----
 1 file changed, 78 insertions(+), 10 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 2e9ea751ed2d..f94069ef988e 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -130,6 +130,68 @@ static void __init fdt_reserved_mem_save_node(unsigned long node, const char *un
 	return;
 }
 
+/**
+ * reg_len_valid() - scan for a suitable #size-cells value and validate
+ *		     the reg property length
+ * @len:	Length of the reg property to be validated (bytes). Can be composed
+ *		by more than one reg addr+size pairs
+ * @calc_addr:	the number of address cells expected by the parent of the node
+ *		containing the reg property. Currently it's just used as in param
+ * @calc_size:	the number of size cells expected by the parent of the node
+ *		containing the reg property (out param)
+ *
+ * This function tries to find the correct #size-cells number for the size portion
+ * of a reg property, assuming the #address-cells passed in (calc_addr param)
+ * is valid to avoid ambiguity.
+ * Parent_len is the length in bytes of a single reg property * as expected by the
+ * parent.
+ * Either len is a multiple of parent_len, in which case there's no adjustment to
+ * be made to calc_size and the region is automatically valid (this choice has the
+ * priority), or it is not a multiple.
+ * In the latter case, it finds the smallest calc_addr+calc_size for which len
+ * is still a multiple and adjust calc_size accordingly.
+ * The rationale is to avoid nonsensical combo e.g. #adress-cells 1 and #size-cells
+ * 2 since it's not fully addressable, and to promote any other combo that is a
+ * subset of the original space, e.g. with calc_addr=2 and calc_size=2, returning
+ * calc_size=1 still makes sense since the region is included in the parent space.
+ * The reason for that is to avoid dropping perfectly valid memory regions that
+ * could just have been passed with the wrong format in the reg property (some fw
+ * are reportedly doing that when updating the DT at boot).
+ *
+ * Returns:	true if the region is valid and can be further processed,
+ *		false otherwise. If valid, calc_size is filled with the actual
+ *		length (in cells) of the size part.
+ *
+ */
+static bool reg_len_valid(int len, const int *calc_addr, int *calc_size)
+{
+	int parent_len = (*calc_addr + *calc_size) * sizeof(__be32);
+	bool parent_multiple = (len % parent_len) / sizeof(__be32);
+	int row_n, calc_row_len = parent_len / sizeof(__be32);
+	int len_b = len / sizeof(__be32);
+
+	if (!len || !parent_len)
+		return false;
+
+	for (row_n = len_b / 2; row_n > 0; row_n--) {
+		int tmp_row_len = len_b / row_n;
+
+		if (calc_row_len > tmp_row_len &&
+		    tmp_row_len > *calc_addr &&
+		    (len_b % tmp_row_len == 0))
+			calc_row_len = tmp_row_len;
+	}
+
+	if (parent_multiple && calc_row_len != parent_len / sizeof(__be32)) {
+		*calc_size = calc_row_len - *calc_addr;
+		return true;
+	} else if (!parent_multiple) {
+		return true;
+	}
+
+	return false;
+}
+
 static int __init early_init_dt_reserve_memory(phys_addr_t base,
 					       phys_addr_t size, bool nomap)
 {
@@ -154,9 +216,9 @@ static int __init early_init_dt_reserve_memory(phys_addr_t base,
 static int __init __reserved_mem_reserve_reg(unsigned long node,
 					     const char *uname)
 {
-	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
+	int calc_addr, calc_size;
 	phys_addr_t base, size;
-	int len;
+	int len, t_len;
 	const __be32 *prop;
 	bool nomap;
 
@@ -164,17 +226,20 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 	if (!prop)
 		return -ENOENT;
 
-	if (len && len % t_len != 0) {
+	calc_addr = dt_root_addr_cells;
+	calc_size = dt_root_size_cells;
+	if (!reg_len_valid(len, &calc_addr, &calc_size)) {
 		pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
 		       uname);
 		return -EINVAL;
 	}
 
 	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
+	t_len = (calc_addr + calc_size) * (int)sizeof(__be32);
 
 	while (len >= t_len) {
-		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
-		size = dt_mem_next_cell(dt_root_size_cells, &prop);
+		base = dt_mem_next_cell(calc_addr, &prop);
+		size = dt_mem_next_cell(calc_size, &prop);
 
 		if (size && early_init_dt_reserve_memory(base, size, nomap) == 0) {
 			/* Architecture specific contiguous memory fixup. */
@@ -255,6 +320,7 @@ void __init fdt_scan_reserved_mem_reg_nodes(void)
 	}
 
 	fdt_for_each_subnode(child, fdt, node) {
+		int calc_addr, calc_size;
 		const char *uname;
 
 		prop = of_get_flat_dt_prop(child, "reg", &len);
@@ -263,19 +329,21 @@ void __init fdt_scan_reserved_mem_reg_nodes(void)
 		if (!of_fdt_device_is_available(fdt, child))
 			continue;
 
+		calc_addr = dt_root_addr_cells;
+		calc_size = dt_root_size_cells;
 		uname = fdt_get_name(fdt, child, NULL);
-		if (len && len % t_len != 0) {
+		if (!reg_len_valid(len, &calc_addr, &calc_size)) {
 			pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
 			       uname);
 			continue;
 		}
 
 		if (len > t_len)
-			pr_warn("%s() ignores %d regions in node '%s'\n",
-				__func__, len / t_len - 1, uname);
+			pr_warn("%s() ignores %d regions in node '%s'\n", __func__,
+				len / ((calc_addr + calc_size) * (int)sizeof(__be32)) - 1, uname);
 
-		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
-		size = dt_mem_next_cell(dt_root_size_cells, &prop);
+		base = dt_mem_next_cell(calc_addr, &prop);
+		size = dt_mem_next_cell(calc_size, &prop);
 
 		if (size)
 			fdt_reserved_mem_save_node(child, uname, base, size);
-- 
2.35.3


