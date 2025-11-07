Return-Path: <linux-kernel+bounces-891125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81175C41E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 23:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF6D188D05E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 22:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7B333DEC6;
	Fri,  7 Nov 2025 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="q08QAoxW"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD96A33A014
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555831; cv=none; b=Mrmww+ysoClfDO2U2fMm5p82rqR+u8P+193FOhhg56qaYNipVIMgEK/7mD8U6E1lv9NxSY5wng1YAFBjg1bvqYQFIOqSkWU1d0ChZsuETEk0Bh1UU1cL4ktiOJUJ6L2H0oMRPETjYCOTV3bdSWL3b9OZqxNboORgbBkv6LoiN6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555831; c=relaxed/simple;
	bh=CNVKe4UoF4HjKWlrvxf/qnyhxQc08gfgs8nx9Dft3Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKWzGP1PssWaug7cOhjDzA3hEnWrV89XGdYDXgjSiG9UNm2k+/d9CckNvsCBaAfHt4D2k7tBvdx7SRmMsc5dQ2wdYkzyxUArHpHuju4MpIBLdKXXjMpW1r6G5Uf/0NbAVERpn0P034mchUA6dcXqgR1DCBPNrEpwdGl5rWinE7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=q08QAoxW; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ed96544434so12261611cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 14:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762555827; x=1763160627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raBRVFIoxXfgYF0FkwrcuU6SyEb+VTf3BUeepNhNHyc=;
        b=q08QAoxWVJj69JFbkhxxapbBs4S8dpPKapCmH9sXwTVst1MP8fcWCHDuZgzdljL88L
         H5vIVF/Ov67nCjUb+ldFEdIqq8PXzqV83sB3DKsUKdtmo6ocPd2nVi2cHA9lFp6BT373
         +02gnhC1M6NSAKbGOuh9RcEVEWpyN4nrzaRGvdBl2ZKJwXPONSLHO6wk0fRrBj6ARh0F
         odZqvQAs9wAgYFxUCZYqGhjFCRnLQKeg9k06osxeFnKA9a7GH8BRSdrpVJLK922lC7Ca
         Fj2gO0yCKwQ1tYGZq0b0uH8PPrTQ1AJnch2Vv9ZWRZgItpiXtaSKa/GQk8mlrSNr8gsW
         TJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555827; x=1763160627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=raBRVFIoxXfgYF0FkwrcuU6SyEb+VTf3BUeepNhNHyc=;
        b=Nuh48bTnsDcLyGtM/JjCSxKLDDaCMpgzxU5NYQ0QMiNnIFPZqGMJEPl9EmrzU42/Ym
         X6DdsHybgY2CRV6JF20B/QHstSQkwiWn9yWwDHb6BVXt28051C4ZhRXHJApAKzur1h89
         dgT3TfH1Rh4ee/hFv/vXhzPUP1hyv2dmOSfOhCKDrgjkOzhaK2DSy6apUA0OtrYx0TMe
         ugu+QHR+VuIpIdktTdxMzsreuwPz4GMQaApSd/HbbrzftFfrKcJ9dUyF7WlwrHeT31Kb
         IRHCAbv1rI50SZrPraNvWJ/Isir5TATT65sylMWG1LbuUFsQ1/L9C2yAS5+hKxFVzQjN
         k3pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo8ozX4TpraXx3kOSww5AndGpHI1F27vC2nHgAP+g/TW7lH32YdFK/cQPZUaeGpKh0jl9GmgspbTUg8+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqwTMZbYvHjJreLwmCC1ZRgYhliVKI0QGVo7B1SeqP2izzsOTg
	JF27+N03PQ1pFhzUw6cYE1xwtrzjfR9/03KOfcfIIB5kfe3wEVpSiK5ucfogVaemErE=
X-Gm-Gg: ASbGnct2es2RfqJUN7uPSU82x/MhI3A1VBszPdVYzwyakxIW9jsWD562Fj/Xl751idf
	PBGlezyjSn3WzyqXNaZq4pwKHXtl9YpDLJQx0Hw8ID3aYgkIwGPYE5AIHmr/gCYesALBDNH7G0v
	h7x4aWPAlkEzTZMGiKU2Oodak2tY9vhdIQ4YeCNPDNAzG2gk0QPD/f4STYQ5hEUHpNi6Bt1HxLv
	pau7iEdEdaIj62BUe9JgxP+ZPiM49/dGDhzhuuH35ogUxerOYNYkpSWAwmb7wjVuItaPbO9Hz4O
	Ko4hpiEnMDwImbYxkZDLf6+/foMnIfEgSF+9sdMhauOnziSWLQxwIoHNurNdFGC+0KmjVlPfbAt
	AMpRlAJOAq+0xj6J6xpJUp19YpFkMx5PmQzp91RfIN8WfldPfuqFPIXIY2OzGRY8eauMDRrqIfq
	Fh+VXsbZxEGsFwxZVwAI7y7+9lwfsgxxTkUu3A4QpGKwj87/EnvFrvk0EckAN1RG8M
X-Google-Smtp-Source: AGHT+IFm7+5mwYzM+NrPR3r2lO2/HN8TDlNByi59dSrMG4CDuhQ9TLgCeHpdJXuwA3iY2H9OGim97w==
X-Received: by 2002:ac8:5751:0:b0:4e8:a0bf:f5b5 with SMTP id d75a77b69052e-4eda4fd4dd3mr9303801cf.73.1762555827556;
        Fri, 07 Nov 2025 14:50:27 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda57ad8e6sm3293421cf.27.2025.11.07.14.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:50:27 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	kees@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	rientjes@google.com,
	jackmanb@google.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	fabio.m.de.francesco@linux.intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com,
	usamaarif642@gmail.com,
	brauner@kernel.org,
	oleg@redhat.com,
	namcao@linutronix.de,
	escape@linux.alibaba.com,
	dongjoo.seo1@samsung.com
Subject: [RFC PATCH 8/9] drivers/cxl: add protected_memory bit to cxl region
Date: Fri,  7 Nov 2025 17:49:53 -0500
Message-ID: <20251107224956.477056-9-gourry@gourry.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107224956.477056-1-gourry@gourry.net>
References: <20251107224956.477056-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add protected_memory bit to cxl region.  The setting is subsequently
forwarded to the dax device it creates. This allows the auto-hotplug
process to occur without an intermediate step requiring udev to poke
the DAX device protected memory bit explicitly before onlining.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 30 ++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  2 ++
 drivers/dax/cxl.c         |  1 +
 3 files changed, 33 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b06fee1978ba..a0e28821961c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -754,6 +754,35 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(size);
 
+static ssize_t protected_memory_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+
+	return sysfs_emit(buf, "%d\n", cxlr->protected_memory);
+}
+
+static ssize_t protected_memory_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	bool val;
+	int rc;
+
+	rc = kstrtobool(buf, &val);
+	if (rc)
+		return rc;
+
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
+		return rc;
+
+	cxlr->protected_memory = val;
+	return len;
+}
+static DEVICE_ATTR_RW(protected_memory);
+
 static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_uuid.attr,
 	&dev_attr_commit.attr,
@@ -762,6 +791,7 @@ static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_resource.attr,
 	&dev_attr_size.attr,
 	&dev_attr_mode.attr,
+	&dev_attr_protected_memory.attr,
 	NULL,
 };
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 231ddccf8977..0ff4898224ba 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -530,6 +530,7 @@ enum cxl_partition_mode {
  * @coord: QoS access coordinates for the region
  * @node_notifier: notifier for setting the access coordinates to node
  * @adist_notifier: notifier for calculating the abstract distance of node
+ * @protected_memory: mark region memory as protected from kernel allocation
  */
 struct cxl_region {
 	struct device dev;
@@ -543,6 +544,7 @@ struct cxl_region {
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	struct notifier_block node_notifier;
 	struct notifier_block adist_notifier;
+	bool protected_memory;
 };
 
 struct cxl_nvdimm_bridge {
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 13cd94d32ff7..a4232a5507b5 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -27,6 +27,7 @@ static int cxl_dax_region_probe(struct device *dev)
 		.id = -1,
 		.size = range_len(&cxlr_dax->hpa_range),
 		.memmap_on_memory = true,
+		.protected_memory = cxlr->protected_memory,
 	};
 
 	return PTR_ERR_OR_ZERO(devm_create_dev_dax(&data));
-- 
2.51.1


