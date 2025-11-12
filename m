Return-Path: <linux-kernel+bounces-898049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE05C5439C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E99093BC7EA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA293538A3;
	Wed, 12 Nov 2025 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="iK/WZAx6"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9465D352FB3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975819; cv=none; b=a5ZHxWeQel2y+sXKHdctByDp5EtlJ2amf0V3B0VB13qJ/hP7HSjq0U67BSbVPoyz9uygJ8OBUAcxMV2LgQhfq8MiiC+VVtJtuAyKcjMjyI50352r/y0DaVYYrm2RJSQyMBxJ8a8ZWmXe3ZOnHxcSS1vlJO8jM1UyjaXx6DEMK6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975819; c=relaxed/simple;
	bh=KDT4LvBi3S/XOOUfgA+q7nj0PsLuynWQ2oewm937Vbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQ7/LUAPrNCjXY+K+3DjPybobYT5+IZWxsMx+ehjkzTBty6DLS2pvmdydB23qwb/81ASivVw/lpkeB/lGGX0fFQT149fjyFohEK/c4rib7dmR6wcyndIRc3fK3eKv8Bx2dJrdjQ1Wo6N169bF0Xpl664L6U1eoKE5hlkGt+GcA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=iK/WZAx6; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b28f983333so4588085a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762975816; x=1763580616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8LOzdRF3F1ID8i/f4610zpV6s32IDb3v5xseVevQWo=;
        b=iK/WZAx6WSo597sQv8dIVqkTiZevnl7RNJ6CjNCRNNsysgMjw9wd8LAxosHniaUOIQ
         1ZeQKAR7HVbZBtr2aHSNZujRlWlLerK6xSmtGIb5v/1f1jFULjCLQj3IJGukejb072yG
         kyPlEwN3TL3wmoh95kLwZTsprX4hSCgP9W7300+Pk0YhzI3tzMWTTn5QJPR7VE8MDyg0
         L1M6CtPORE57vIczAIkMIyIHNQJuObn6FaNHoEGYJHHzVgY7u3dtKIocl1CdlccwNLB1
         EECRWVa4KKu2DOX9Q1E3aqUohIhmijL+SVGo0jNVJDtazmB2KiWDETbvcUL6sMr6eK6m
         ERYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975816; x=1763580616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x8LOzdRF3F1ID8i/f4610zpV6s32IDb3v5xseVevQWo=;
        b=uKo9Ut7JJy1dKjkn+WZ4a8X3/ygS/muGYId5iY6n2EeG28TVRrGflPnrdEPClrah6q
         gLd2+4aBQFYVEtUMHHPIZiwSCaEMp3zlYPMrbRgPn5xwlzAHUsND0Rw20lZQMk6p5t6K
         tLS9s8IqzJLoJHCmSA9gcWPol8KkNbtPAT+cG7JPAhFOaYS9g8IJz1EW6hBe7Hw96/Mc
         O6eLa9i58m4DYGX18tY2yIVKHicxaV8lvVFHJtjxotknQe5PzocE9Y9xLCufiBE5NJ5M
         ssn7SHnRr4K4rXYfqORuhtV9MH/p7AaPP+0Le2mSl0cQOe/4cte3i1IxdCf+fmMFBj5l
         Xo/A==
X-Forwarded-Encrypted: i=1; AJvYcCV4f4XQoF8JL8u/yBXSEbsjmAuu13QKmUX3oayU5uugiKM0dzfRqPeWggRAIlHPcKz9Xm6Ixjp3VnfOgK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvG3qLg61685bJ+CiT59iN/VSwx2kNv/cp4c9TOpEpikedX928
	8yei9vSJoYfuecPOs0r8JSrIj7gDmb3uiSR3z4lN/syFvrX0+tVVUDwz0RELvTp8aUU=
X-Gm-Gg: ASbGncs1UytqoMf/gNTussmU6tR3yUM0UJBECbtcrWsU2uhguMSv5ZcSC+QxAWfOO/x
	Uh9xCDvZqrdN/JdOxEHXzhCCID/kbcCWh9J5snMmbftEFXjuaJ1IdHaWafYnHtRk2HNdCPr1Jdq
	k3R0AipM76KbBv6/Lm4jYJAJeQNJUbkhWzYVEu1UrGe4QwTcBbmAFt+vuPzJrI0O9B0/6RlV2Q/
	mQTn7cVWMkA1XWNnWLdFBSa3Bo59f+b87DNiMHq3RPeTkJcQkyET8LTPV5oi4oYoYD3nzMftTYs
	HowSSSfFjvCJ7/w9j7qoZ2DhZKUhbE/a7Yd6D4xPfIqIZq2K9BZph+IXSsR3JV0oHLQYyd/BBR7
	l3fjrOA4bE1Zv/RyFVrO8ytGRMSo1S9SiL67NXJXAuyHyTauTU4qxcNtSaCDUBp8F3sVZS+CaeJ
	BZakhizZ3aV+V/4Vphdo7eaJkOatonkxjndo6wALYrCd2vn8u+hOWJm0ShxVgFNnLC
X-Google-Smtp-Source: AGHT+IHll+IKPvcEc2EdGPBw2QQZcQZ6T6jlawQUNb6L1NrYv5cDZU0Tf0FeuJID2gzeZN1UxCbY+g==
X-Received: by 2002:a05:620a:2a0f:b0:84e:2544:6be7 with SMTP id af79cd13be357-8b29b815e49mr640273285a.65.1762975816129;
        Wed, 12 Nov 2025 11:30:16 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa0082esm243922885a.50.2025.11.12.11.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 11:30:15 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: kernel-team@meta.com,
	linux-cxl@vger.kernel.org,
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
Subject: [RFC PATCH v2 09/11] drivers/dax: add spm_node bit to dev_dax
Date: Wed, 12 Nov 2025 14:29:25 -0500
Message-ID: <20251112192936.2574429-10-gourry@gourry.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112192936.2574429-1-gourry@gourry.net>
References: <20251112192936.2574429-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This bit is used by dax/kmem to determine whether to set the
MHP_SPM_NODE flags, which determines whether the hotplug memory
is SysRAM or Specific Purpose Memory.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/bus.c         | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/dax/bus.h         |  1 +
 drivers/dax/dax-private.h |  1 +
 drivers/dax/kmem.c        |  2 ++
 4 files changed, 43 insertions(+)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index fde29e0ad68b..b0de43854112 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1361,6 +1361,43 @@ static ssize_t memmap_on_memory_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(memmap_on_memory);
 
+static ssize_t spm_node_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+
+	return sysfs_emit(buf, "%d\n", dev_dax->spm_node);
+}
+
+static ssize_t spm_node_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t len)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+	bool val;
+	int rc;
+
+	rc = kstrtobool(buf, &val);
+	if (rc)
+		return rc;
+
+	rc = down_write_killable(&dax_dev_rwsem);
+	if (rc)
+		return rc;
+
+	if (dev_dax->spm_node != val && dev->driver &&
+	    to_dax_drv(dev->driver)->type == DAXDRV_KMEM_TYPE) {
+		up_write(&dax_dev_rwsem);
+		return -EBUSY;
+	}
+
+	dev_dax->spm_node = val;
+	up_write(&dax_dev_rwsem);
+
+	return len;
+}
+static DEVICE_ATTR_RW(spm_node);
+
 static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
@@ -1388,6 +1425,7 @@ static struct attribute *dev_dax_attributes[] = {
 	&dev_attr_resource.attr,
 	&dev_attr_numa_node.attr,
 	&dev_attr_memmap_on_memory.attr,
+	&dev_attr_spm_node.attr,
 	NULL,
 };
 
@@ -1494,6 +1532,7 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 	ida_init(&dev_dax->ida);
 
 	dev_dax->memmap_on_memory = data->memmap_on_memory;
+	dev_dax->spm_node = data->spm_node;
 
 	inode = dax_inode(dax_dev);
 	dev->devt = inode->i_rdev;
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index cbbf64443098..51ed961b6a3c 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -24,6 +24,7 @@ struct dev_dax_data {
 	resource_size_t size;
 	int id;
 	bool memmap_on_memory;
+	bool spm_node;
 };
 
 struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data);
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 0867115aeef2..3d1b1f996383 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -89,6 +89,7 @@ struct dev_dax {
 	struct device dev;
 	struct dev_pagemap *pgmap;
 	bool memmap_on_memory;
+	bool spm_node;
 	int nr_range;
 	struct dev_dax_range *ranges;
 };
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index c036e4d0b610..3c3dd1cd052c 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -169,6 +169,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		mhp_flags = MHP_NID_IS_MGID;
 		if (dev_dax->memmap_on_memory)
 			mhp_flags |= MHP_MEMMAP_ON_MEMORY;
+		if (dev_dax->spm_node)
+			mhp_flags |= MHP_SPM_NODE;
 
 		/*
 		 * Ensure that future kexec'd kernels will not treat
-- 
2.51.1


