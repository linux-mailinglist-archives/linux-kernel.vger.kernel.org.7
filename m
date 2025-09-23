Return-Path: <linux-kernel+bounces-828523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45371B94C98
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418C91901864
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C9230F940;
	Tue, 23 Sep 2025 07:31:28 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E81ABE49
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758612687; cv=none; b=Mzr3Bo/1IgQFniDrUa38Zph/Fj93GGrixbsUn3C+vaN+1+Puj+YOrgR7w1Ith4o35Jco6pZkd2uxI+/sQBcRY8KAIZ9ALD9F8hmOX6dOms3tDDpQ/SKhXsMzqn6rAr9EJQRf93i41B+o6dtSrUa53NScPYxYMNTg12KGUgu1Gso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758612687; c=relaxed/simple;
	bh=SMLODlHRN9kuvh5o/4TqHRLpAVlNc9mcp0TsXpj4clU=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oJj1pSywdfVeLz5i9e1AzwH6DzvROnzLGNlxMJ3Fvvi3LfsJRndCmby+HlgmYpzaKWWPVWIWEdr2fjuDXGh2pqqIkv4/TFaZXDQZGTVX+Hc/6VOf/r/kvk/aq46cxgaf+tvBjjEhzBjSNSMJc7ENGmtkM67WqcFfSwMLYji78Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cWBQS1Srcz2RW7K;
	Tue, 23 Sep 2025 15:27:44 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id B6AB01A0188;
	Tue, 23 Sep 2025 15:31:16 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Sep 2025 15:31:16 +0800
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Sep 2025 15:31:15 +0800
CC: <yangyicong@hisilicon.com>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<robin.murphy@arm.com>, <liuyonglong@huawei.com>, <wanghuiqiang@huawei.com>,
	<prime.zeng@hisilicon.com>, <hejunhao3@h-partners.com>,
	<linuxarm@huawei.com>, <fanghao11@huawei.com>
Subject: Re: [PATCH v3 5/9] drivers/perf: hisi: Extend the field of tt_core
To: Will Deacon <will@kernel.org>, Yushan Wang <wangyushan12@huawei.com>,
	<Jonathan.Cameron@huawei.com>
References: <20250829101427.2557899-1-wangyushan12@huawei.com>
 <20250829101427.2557899-6-wangyushan12@huawei.com>
 <aNFMUdPJeJo9XU1e@willie-the-truck>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <3cc3fcdf-436a-9e73-a377-ed896d07a825@huawei.com>
Date: Tue, 23 Sep 2025 15:31:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aNFMUdPJeJo9XU1e@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq200018.china.huawei.com (7.202.195.108)

On 2025/9/22 21:17, Will Deacon wrote:
> On Fri, Aug 29, 2025 at 06:14:23PM +0800, Yushan Wang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> Currently the tt_core's using config1's bit [7, 0] and can not be
>> extended. For some platforms there's more the 8 CPUs sharing the
>> L3 cache. So make tt_core use config2's bit [15, 0] and the remaining
>> bits in config2 is reserved for extension.
>>
>> Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
>> ---
>>  drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
>> index a372dd2c07b5..39444f11cbad 100644
>> --- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
>> +++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
>> @@ -55,10 +55,10 @@
>>  #define L3C_V1_NR_EVENTS	0x59
>>  #define L3C_V2_NR_EVENTS	0xFF
>>  
>> -HISI_PMU_EVENT_ATTR_EXTRACTOR(tt_core, config1, 7, 0);
>>  HISI_PMU_EVENT_ATTR_EXTRACTOR(tt_req, config1, 10, 8);
>>  HISI_PMU_EVENT_ATTR_EXTRACTOR(datasrc_cfg, config1, 15, 11);
>>  HISI_PMU_EVENT_ATTR_EXTRACTOR(datasrc_skt, config1, 16, 16);
>> +HISI_PMU_EVENT_ATTR_EXTRACTOR(tt_core, config2, 15, 0);
>>  
>>  static void hisi_l3c_pmu_config_req_tracetag(struct perf_event *event)
>>  {
>> @@ -397,7 +397,7 @@ static const struct attribute_group hisi_l3c_pmu_v1_format_group = {
>>  
>>  static struct attribute *hisi_l3c_pmu_v2_format_attr[] = {
>>  	HISI_PMU_FORMAT_ATTR(event, "config:0-7"),
>> -	HISI_PMU_FORMAT_ATTR(tt_core, "config1:0-7"),
>> +	HISI_PMU_FORMAT_ATTR(tt_core, "config2:0-15"),
>>  	HISI_PMU_FORMAT_ATTR(tt_req, "config1:8-10"),
>>  	HISI_PMU_FORMAT_ATTR(datasrc_cfg, "config1:11-15"),
>>  	HISI_PMU_FORMAT_ATTR(datasrc_skt, "config1:16"),
> 
> I'm a _tiny_ bit worried about this change in that it has the potential
> to break any users who've hardcoded the 'tt_core' encoding in 'config1'.
> Granted, they should be parsing this out of sysfs, but you never know.
> 

yes, it's true. I thought of this as a misusage, the sysfs format should
be checked first for option encoding, just like how perf use of it.
but yes the direct use of config1 is not forbidden.

> If we were going to avoid the possibility of a regression entirely, I
> think we'd either need to (a) split the field so that the upper 8 bits
> of 'tt_core' live in 'config2' but the bottom 8 bits stay where they
> are or (b) leave 'config1:0-7' as an alias of 'config2:0-7'.
> 
> The latter is still do-able, as you haven't re-allocated the config1
> bits yet.
> 

option (b) looks better for me, since not sure we'll expand it later and
currently I reserved the whole config2 for extension.

as for an alias is something like below? make the config1:0-7 as option
tt_core_deprecated and encourage user to use tt_core.

thanks.

From 446cceeff563774caccc087ec62db810a8154c2d Mon Sep 17 00:00:00 2001
From: Yicong Yang <yangyicong@hisilicon.com>
Date: Tue, 23 Sep 2025 12:02:01 +0800
Subject: [PATCH] drivers/perf: hisi: Add tt_core_deprecated for compatibility

Previously tt_core is defined as config1:0-7 which may not cover all
the CPUs sharing L3C on platforms with more than 8 CPUs in a L3C. In
order to support such platforms extend tt_core to 16 bits, since no
spare space in config1, tt_core was moved to config2:0-15.

Though linux expects the users to retrieve the control encoding from
sysfs first for each option, it's possible if user doesn't follow
this and hardcoded tt_core in config1. So add an option
tt_core_deprecated for config1:0-7 for backward compatibility.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 Documentation/admin-guide/perf/hisi-pmu.rst  |  4 +++
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c | 30 +++++++++++++++++---
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/perf/hisi-pmu.rst b/Documentation/admin-guide/perf/hisi-pmu.rst
index c4c2cbbf88cb..0017f8ddeb75 100644
--- a/Documentation/admin-guide/perf/hisi-pmu.rst
+++ b/Documentation/admin-guide/perf/hisi-pmu.rst
@@ -66,6 +66,10 @@ specified as a bitmap::

 This will only count the operations from core/thread 0 and 1 in this cluster.

+User should not use tt_core_deprecated to specify the core/thread filtering.
+This option is provided for backward compatiblility and only support 8bit
+which may not cover all the core/thread sharing L3C.
+
 2. Tracetag allow the user to chose to count only read, write or atomic
 operations via the tt_req parameeter in perf. The default value counts all
 operations. tt_req is 3bits, 3'b100 represents read operations, 3'b101
diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
index bbd81a43047d..a52d98f1ed34 100644
--- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
@@ -57,6 +57,11 @@
 #define L3C_V2_NR_EVENTS	0xFF

 HISI_PMU_EVENT_ATTR_EXTRACTOR(ext, config, 17, 16);
+/*
+ * Remain the config1:0-7 for backward compatibility if some existing users
+ * hardcode the config1:0-7 directly without parsing the sysfs attribute.
+ */
+HISI_PMU_EVENT_ATTR_EXTRACTOR(tt_core_deprecated, config1, 7, 0);
 HISI_PMU_EVENT_ATTR_EXTRACTOR(tt_req, config1, 10, 8);
 HISI_PMU_EVENT_ATTR_EXTRACTOR(datasrc_cfg, config1, 15, 11);
 HISI_PMU_EVENT_ATTR_EXTRACTOR(datasrc_skt, config1, 16, 16);
@@ -95,6 +100,21 @@ static bool support_ext(struct hisi_l3c_pmu *pmu)
 	return l3c_pmu_ext->support_ext;
 }

+/*
+ * tt_core was extended to cover all the CPUs sharing the L3 and was moved from
+ * config1:0-7 to config2:0-*. Try it first and fallback to tt_core_deprecated
+ * if user's still using the deprecated one.
+ */
+static u32 hisi_l3c_pmu_get_tt_core(struct perf_event *event)
+{
+	u32 core = hisi_get_tt_core(event);
+
+	if (core)
+		return core;
+
+	return hisi_get_tt_core_deprecated(event);
+}
+
 static int hisi_l3c_pmu_get_event_idx(struct perf_event *event)
 {
 	struct hisi_pmu *l3c_pmu = to_hisi_pmu(event->pmu);
@@ -259,7 +279,7 @@ static void hisi_l3c_pmu_clear_ds(struct perf_event *event)
 static void hisi_l3c_pmu_config_core_tracetag(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	u32 core = hisi_get_tt_core(event);
+	u32 core = hisi_l3c_pmu_get_tt_core(event);

 	if (core) {
 		u32 val;
@@ -280,7 +300,7 @@ static void hisi_l3c_pmu_config_core_tracetag(struct perf_event *event)
 static void hisi_l3c_pmu_clear_core_tracetag(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	u32 core = hisi_get_tt_core(event);
+	u32 core = hisi_l3c_pmu_get_tt_core(event);

 	if (core) {
 		u32 val;
@@ -300,7 +320,7 @@ static void hisi_l3c_pmu_clear_core_tracetag(struct perf_event *event)

 static bool hisi_l3c_pmu_have_filter(struct perf_event *event)
 {
-	return hisi_get_tt_req(event) || hisi_get_tt_core(event) ||
+	return hisi_get_tt_req(event) || hisi_l3c_pmu_get_tt_core(event) ||
 	       hisi_get_datasrc_cfg(event) || hisi_get_datasrc_skt(event);
 }

@@ -602,10 +622,11 @@ static const struct attribute_group hisi_l3c_pmu_v1_format_group = {

 static struct attribute *hisi_l3c_pmu_v2_format_attr[] = {
 	HISI_PMU_FORMAT_ATTR(event, "config:0-7"),
-	HISI_PMU_FORMAT_ATTR(tt_core, "config2:0-15"),
+	HISI_PMU_FORMAT_ATTR(tt_core_deprecated, "config1:0-7"),
 	HISI_PMU_FORMAT_ATTR(tt_req, "config1:8-10"),
 	HISI_PMU_FORMAT_ATTR(datasrc_cfg, "config1:11-15"),
 	HISI_PMU_FORMAT_ATTR(datasrc_skt, "config1:16"),
+	HISI_PMU_FORMAT_ATTR(tt_core, "config2:0-15"),
 	NULL
 };

@@ -617,6 +638,7 @@ static const struct attribute_group hisi_l3c_pmu_v2_format_group = {
 static struct attribute *hisi_l3c_pmu_v3_format_attr[] = {
 	HISI_PMU_FORMAT_ATTR(event, "config:0-7"),
 	HISI_PMU_FORMAT_ATTR(ext, "config:16-17"),
+	HISI_PMU_FORMAT_ATTR(tt_core_deprecated, "config1:0-7"),
 	HISI_PMU_FORMAT_ATTR(tt_req, "config1:8-10"),
 	HISI_PMU_FORMAT_ATTR(tt_core, "config2:0-15"),
 	NULL
-- 
2.24.0





