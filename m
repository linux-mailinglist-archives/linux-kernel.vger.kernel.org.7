Return-Path: <linux-kernel+bounces-789519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63632B396B2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210F8984301
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAAD2D6E5A;
	Thu, 28 Aug 2025 08:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WC6Inp+I"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD235283C90
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369063; cv=none; b=HAdrHkIDTDUYWYJNSUTjPGxvK1lFA3ZDg/k9dxVOCZEzwUdcMmIeBODT2WDQrSLMOWhupRL4S+PeRxgnZ2q32EwpZX6wlSEMzpTcpWOhZldgKy+rmFCuGlOG/i4GWiqFb5vVsoQBoxOajfSBQhd06LykttRnixaVKHbp3yVer6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369063; c=relaxed/simple;
	bh=FKTWsdA6IZ93bSaQhX1pWr9LY3oqj3IddAD/RuxzfsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nqYUa/Gg2hinzjFF4aaqHor4wq5UGtUzmiBkfGVKbj08oukaBFQG58vO4PeFmDXZCRcrs5yN+GZ1XcbJ365xbncUoZdQzo6EvqiUZzNhRi3QgdqCmTbk6/PeE83pQNlqopD7NLaekdM8hWRt1ba73c24gutsP0xntKSHuHB+7Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WC6Inp+I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S6XZV9014807
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rzoIR8Y5Bui+pM/FURb8FN
	MSIseTPwwe7QtZJ+qN7HU=; b=WC6Inp+I5iyjXHCXhJaZbIM/pL9qCBVKhlxORP
	QrG/g0ECMmukHZkkLf8wEEkcH50+P+f2nYm2Yr40ahueXGhrJ1q57TKrZh8eMeqJ
	aIwufa7OIH43wvVB+ZoVPDTqwvc5Tve2wXvPzf7uv7YqVEBoi53xR3ufcS+nOXEz
	T3lOrFC62eY0HxS2Ur0cul8YYbmwEpaXrJSvRQH1IbpJiIxdByVaLTxfoiBPj6/+
	y828RvHi1H/ffhMr0zpefU7LrKGoXQlfchS7firq9kdVBr28os9exubtM2+e683K
	NBS+6YXlm8PLnQz/S4kuMskdLwrbes21oKVEYPFPNSkgAzxA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5we76xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:17:40 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4c229e2a42so575146a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 01:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756369059; x=1756973859;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzoIR8Y5Bui+pM/FURb8FNMSIseTPwwe7QtZJ+qN7HU=;
        b=FRgzA/JLHats2wia2r871jewr+DaU4kxlfQ8cvbAwporRZgHddpLpc2a+3z7sS1FTb
         ZtWJlDumyTAnQBm8EdzUIEmh419FlnXBRT1Z9gRvjcKbonLZD51xsibsEUwM2VTo6ehu
         KtlHeIeIF3pPXZPXHTjFK5s6H4NAjOvcbaXX1TLWArnPDXVHlpcvVjSAbEWhs6ROcvLt
         oo5HhkLN60kiSO4+ueAFNQiKtAKdXK4IF0TMIyrGtBXF9696dFhKUqISihrlmU2kKIRD
         bG0z4EE5X+HOlob/vnmRWdyhhKp78soMwMhbZebMpnIQv8ma7YTlqlBbhCC1RxOrOCbS
         vGHg==
X-Forwarded-Encrypted: i=1; AJvYcCVepYTFsLslRSx0/wlbo3M0lEOj9tlYDCDABqpMuXxzjGWvqoX7BFKY55pkmATof33cJ5AR9zrEDZnxVPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm4yGcPzYkgp14nsOtnbE2s4aNFkticMei4K6GAJvBdoxTq8fQ
	i9XVw6OrOFN6koXMOdM0cemC/MuNbrb4iPbtyi/09GbViK8pUyZjhky6bnn5OGcsHHMuIvQAeZ7
	wCukt1Zz5C9E0WYG7aDu0sZOOznzOfTOEEI83Lsx5oTZGznSi1lsJDpDKPfyZh9OEpLA=
X-Gm-Gg: ASbGncsAg25AEB1O3yCHnEYPt9D7aOzFLFoliNcKUSiLhPVwCw93hgWeD0urOg2NDTW
	uZ1w2aV/2/dFtFXCzmO0UiLxI9vbT/UUww+uUCeu9C5Jw358/oizcBCyDhRRLAekR90bw85wFrC
	YYgg5JyWPCtDZUXR5BveCkncAYuV9awCi8ajlhuPNCqvxf92dc7b2iW0E0rsw/I1ebsTs3uETLP
	deseVOKXGNIER+L0FhLzHbtv6vpzaLteJ/ghxFxlaA2+VFu6OMVgx3bhuNXEO8RVvNB8l+zHEej
	f1vuqzCKp6rN9BUXgpsuSXU5VCKWp4bamN42k0Yl9i4OxE0TsFE5cCfNpkUD7rU+Bth42Ws4ECV
	OP17d6KKHrBn8iYg2Nw==
X-Received: by 2002:a05:6a20:748e:b0:240:2371:cffd with SMTP id adf61e73a8af0-24340ad0a5dmr32409019637.7.1756369059253;
        Thu, 28 Aug 2025 01:17:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqlqgsl1b6t+N/20ARa3vSPPvbvMXiHdm2s9sVXuPscBZ3EF0CG4+/NyoOtw2wh5z3z36jow==
X-Received: by 2002:a05:6a20:748e:b0:240:2371:cffd with SMTP id adf61e73a8af0-24340ad0a5dmr32408984637.7.1756369058748;
        Thu, 28 Aug 2025 01:17:38 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb7c0e0sm13474213a12.37.2025.08.28.01.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 01:17:38 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 16:17:33 +0800
Subject: [PATCH] dma-debug: don't enforce dma mapping check on noncoherent
 allocations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-dma-debug-fix-noncoherent-dma-check-v1-1-76e9be0dd7fc@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJwQsGgC/x2N0QqDMBAEf0XuuQcaTIn9FemDTbbmKL1IolIQ/
 73Bx2GHnYMKsqDQozkoY5ciSSt0t4Z8nHQGS6hMpjW2dcZx+E4c8NpmfsuPNalPERm6XouP8B9
 2uA+dDdb1Q0/1acmo8lUZn+f5B3xgwQJ1AAAA
X-Change-ID: 20250828-dma-debug-fix-noncoherent-dma-check-8e6915d58494
To: Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 56pySQPbZ7wLT7dAX9KkfGR6l124gBGR
X-Proofpoint-ORIG-GUID: 56pySQPbZ7wLT7dAX9KkfGR6l124gBGR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX4OsXvMEoMoYF
 4BdCK+aQk1CQ7tktBSmD97kF6CsdP3N65JcNs2SYZQlao1ROOFPHhlyY3l68DfPFp91WjOBMTey
 yUySuVi6BSzIGmqHcnr+yJa2Ws/Le3LBtuCGQ2iCcvhch3JVDzFaYYPJgobBrb5msUSfbwxw81h
 PCFmALooLp99Q6jDKmAwWs+fCPdc4BVmAlppN2EtpX4cMCl6W7PfekG/neqOAQ82SY36I79D2rp
 xxrEQ/SkEISs6xEV3RH+5qnhxqk04TcNIbwF2jhjzeGZVF3HMysyF+Gid/DiHpqEyfuI32WlfpU
 rQdXbsSNfSUKDqd863eT322RHSYScTdPHInO164tQ/wtRz7H3k8QFir5z+/WXIAm6sPtsQlWR8I
 S4WcIndR
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68b010a4 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=lGNrSFP5dTkWF7ljvXsA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033

As discussed in [1], there is no need to enforce dma mapping check on
noncoherent allocations, a simple test on the returned CPU address is
good enough.

Add a new pair of debug helpers and use them for noncoherent alloc/free
to fix this issue.

Fixes: efa70f2fdc84 ("dma-mapping: add a new dma_alloc_pages API")
Link: https://lore.kernel.org/all/ff6c1fe6-820f-4e58-8395-df06aa91706c@oss.qualcomm.com # 1
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 kernel/dma/debug.c   | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/dma/debug.h   | 20 ++++++++++++++++++++
 kernel/dma/mapping.c |  4 ++--
 3 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index e43c6de2bce4e7d3e58f8d9601a7637d8f6da767..b82399437db03116a396c7d1cebd16b2e1af98c3 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -39,6 +39,7 @@ enum {
 	dma_debug_sg,
 	dma_debug_coherent,
 	dma_debug_resource,
+	dma_debug_noncoherent,
 };
 
 enum map_err_types {
@@ -141,6 +142,7 @@ static const char *type2name[] = {
 	[dma_debug_sg] = "scatter-gather",
 	[dma_debug_coherent] = "coherent",
 	[dma_debug_resource] = "resource",
+	[dma_debug_noncoherent] = "noncoherent",
 };
 
 static const char *dir2name[] = {
@@ -993,7 +995,8 @@ static void check_unmap(struct dma_debug_entry *ref)
 			   "[mapped as %s] [unmapped as %s]\n",
 			   ref->dev_addr, ref->size,
 			   type2name[entry->type], type2name[ref->type]);
-	} else if (entry->type == dma_debug_coherent &&
+	} else if ((entry->type == dma_debug_coherent ||
+		    entry->type == dma_debug_noncoherent) &&
 		   ref->paddr != entry->paddr) {
 		err_printk(ref->dev, entry, "device driver frees "
 			   "DMA memory with different CPU address "
@@ -1581,6 +1584,49 @@ void debug_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 	}
 }
 
+void debug_dma_alloc_pages(struct device *dev, struct page *page,
+			   size_t size, int direction,
+			   dma_addr_t dma_addr,
+			   unsigned long attrs)
+{
+	struct dma_debug_entry *entry;
+
+	if (unlikely(dma_debug_disabled()))
+		return;
+
+	entry = dma_entry_alloc();
+	if (!entry)
+		return;
+
+	entry->type      = dma_debug_noncoherent;
+	entry->dev       = dev;
+	entry->paddr	 = page_to_phys(page);
+	entry->size      = size;
+	entry->dev_addr  = dma_addr;
+	entry->direction = direction;
+
+	add_dma_entry(entry, attrs);
+}
+
+void debug_dma_free_pages(struct device *dev, struct page *page,
+			  size_t size, int direction,
+			  dma_addr_t dma_addr)
+{
+	struct dma_debug_entry ref = {
+		.type           = dma_debug_noncoherent,
+		.dev            = dev,
+		.paddr		= page_to_phys(page),
+		.dev_addr       = dma_addr,
+		.size           = size,
+		.direction      = direction,
+	};
+
+	if (unlikely(dma_debug_disabled()))
+		return;
+
+	check_unmap(&ref);
+}
+
 static int __init dma_debug_driver_setup(char *str)
 {
 	int i;
diff --git a/kernel/dma/debug.h b/kernel/dma/debug.h
index f525197d3cae605aa7e0499eb2ca6f1ae134ec93..48757ca13f31403f58090e1015de828893b8f94f 100644
--- a/kernel/dma/debug.h
+++ b/kernel/dma/debug.h
@@ -54,6 +54,13 @@ extern void debug_dma_sync_sg_for_cpu(struct device *dev,
 extern void debug_dma_sync_sg_for_device(struct device *dev,
 					 struct scatterlist *sg,
 					 int nelems, int direction);
+extern void debug_dma_alloc_pages(struct device *dev, struct page *page,
+				  size_t size, int direction,
+				  dma_addr_t dma_addr,
+				  unsigned long attrs);
+extern void debug_dma_free_pages(struct device *dev, struct page *page,
+				 size_t size, int direction,
+				 dma_addr_t dma_addr);
 #else /* CONFIG_DMA_API_DEBUG */
 static inline void debug_dma_map_page(struct device *dev, struct page *page,
 				      size_t offset, size_t size,
@@ -126,5 +133,18 @@ static inline void debug_dma_sync_sg_for_device(struct device *dev,
 						int nelems, int direction)
 {
 }
+
+static inline void debug_dma_alloc_pages(struct device *dev, struct page *page,
+					 size_t size, int direction,
+					 dma_addr_t dma_addr,
+					 unsigned long attrs)
+{
+}
+
+static inline void debug_dma_free_pages(struct device *dev, struct page *page,
+					size_t size, int direction,
+					dma_addr_t dma_addr)
+{
+}
 #endif /* CONFIG_DMA_API_DEBUG */
 #endif /* _KERNEL_DMA_DEBUG_H */
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 107e4a4d251df65fb86a1d7302261c31138061b7..56de28a3b1799f7c18f7e3f8e5ecd438c5748677 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -712,7 +712,7 @@ struct page *dma_alloc_pages(struct device *dev, size_t size,
 	if (page) {
 		trace_dma_alloc_pages(dev, page_to_virt(page), *dma_handle,
 				      size, dir, gfp, 0);
-		debug_dma_map_page(dev, page, 0, size, dir, *dma_handle, 0);
+		debug_dma_alloc_pages(dev, page, size, dir, *dma_handle, 0);
 	} else {
 		trace_dma_alloc_pages(dev, NULL, 0, size, dir, gfp, 0);
 	}
@@ -738,7 +738,7 @@ void dma_free_pages(struct device *dev, size_t size, struct page *page,
 		dma_addr_t dma_handle, enum dma_data_direction dir)
 {
 	trace_dma_free_pages(dev, page_to_virt(page), dma_handle, size, dir, 0);
-	debug_dma_unmap_page(dev, dma_handle, size, dir);
+	debug_dma_free_pages(dev, page, size, dir, dma_handle);
 	__dma_free_pages(dev, size, page, dma_handle, dir);
 }
 EXPORT_SYMBOL_GPL(dma_free_pages);

---
base-commit: 95bf875b89b48a95a82aca922eeaf19d52543028
change-id: 20250828-dma-debug-fix-noncoherent-dma-check-8e6915d58494

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


