Return-Path: <linux-kernel+bounces-766375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 278CDB245DF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D63D72533F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419E43074AC;
	Wed, 13 Aug 2025 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fP5ZQeP6"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012041.outbound.protection.outlook.com [52.101.126.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FD5307481;
	Wed, 13 Aug 2025 09:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077970; cv=fail; b=eaepCtX38JzrVjTsTXjFDzVuO6awgJB+Ug23R66g/0kPJiYa5U0MHcNp0T7rZzMz2CQTa/cVKVtUVHh8nKvqm/aGKb6mog5a+EwooAfvVNy50q0LhwGvU8X0iH74ICdQWkkUMYTozX0f1wMUalXwE5X/yxDA5Ii67PJ7o+j4I2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077970; c=relaxed/simple;
	bh=cdcLlbaZYs6fE68tG9GV1nycBQ4Qxj4rQVdUJe0ZvTg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZKesQj1VrIznH/My34f85vPYCrHLgU3sgnzb+pKS4pFyc8aviXW0ZAkLW2pbO3a+UsAOqOd9kAquFBgV6WU/AqsFTLa3NRQbx/Clrt4G8NclOyyFkk++sRTERm4tDTmXzZfBdSU5MB0KJpC+eXvRhvhDAVBa4QuGa7Ft32TXVL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=fP5ZQeP6; arc=fail smtp.client-ip=52.101.126.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dc+M4UCdSvQu5TU8r7lWBmWMwRfBu3VmyU1VV+eniXk4osjQ+JHx4WPsDWYOdpFH8fh30lbbw3E/3V0F9aVHwPvS0N2/jV4m/GXO4ccRuhYK8Cxf0Ig7nx4Lywmh9KvLRYFuwR5YS4F/BvS+c3bPphFUwgZXfqCNuydeTupqg57fLsPnvUe+tCaEhARgd8ZvCkKcL5C109IYP2DFTKbp86YEw+L8Jh6tdVvPLq/dyLIU8W8LRAzTACNCgV8/uJpPty0dRrIOVB9psPsbEAAKh2C7LfU9H2iVRV29EhnF6uJO/Man+ufs2xDIrM4nsuQdLkvc4ewMHvYXDS89QEwKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpQSe6VotA180cbnZbT8sQmg67F/CIso/zFBd+6tvcg=;
 b=fb9Pu3KlO0exL2TauDGnc1VvoTz/+OEbqxFkns+0CiAu4zghRC4YDY8xfA481oybppI3N54zsuQqQ3HmQDiKiSK57Xit37rpOsOAoT/ZlbfRXoAlLMbBvDlsORvUBTNJamOrgiOPpYITCHbWU/XqnsdSxMXMwds4Ou6AU5jVHXLI4rCkaItWQ0ja7iUhJOCkHgP8SLF7fD/qdm5bI9Ki5CfKJUoHqGUsm6O8kZ9VvapHY6+OCq8iWeNxQFk4oZG9u+O/n8HxagyRybiMrzbTt2weiPHm9Afi4JyY4fc09CBvNfsVp+eEjhbL3Pl9lL5HtLipAm3I2LXxd9sf0yUKWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpQSe6VotA180cbnZbT8sQmg67F/CIso/zFBd+6tvcg=;
 b=fP5ZQeP6CNBdQe6/AFb5kZeCmYxr0Sb6sogKktrTohYR/QM9BJ3XKXgHEbKxmSYy6zaC9KHhcCdmsVpZZfeOnixcGxac0t6DKjr3ZzpouXBrKrd1opEqpNSh3vtEqhbAtTNy4U5K75byfBNuZMAHZCT2Bi+N+KtkEBzxaCBJVYd97gfzjxYDUn4KMngFWRtMH8froQ8BcAddBmXipFfszGGoTEVHe90yQw9kjAirRux+DWrmqIGvV4I+fsp0lNOe4ehOJ9VdO6i3yN6+tvsIhJlXtZOi9wn5i2Utls9r2RAPl/QsqSAIdxAVF6YIeUp8Qvglb7Vhx3zU19gbp+srCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYZPR06MB4978.apcprd06.prod.outlook.com (2603:1096:400:1ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 09:39:25 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 09:39:24 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org (open list:INTEL ASoC DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] ASoC: Intel: sst: Remove redundant semicolons
Date: Wed, 13 Aug 2025 17:39:01 +0800
Message-Id: <20250813093903.551388-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYZPR06MB4978:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b35400b-63e4-47f3-616e-08ddda4d49e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VPpklnw2PpB/PiwZQf4ewoOzU2PQTOV6b08/5B0hliWm3cIceGlb4rYW23Ur?=
 =?us-ascii?Q?HCEK0DqrctYeed2avoKKK79C4jv9BHGIu2TB2UHwtvl5kHK7lvAZfMWyLuce?=
 =?us-ascii?Q?HOp7AwjfPwGnUpsh13hyd2/8aB1f/ei68RkFMnnUtYHV20zsamL0m/wQhbPM?=
 =?us-ascii?Q?f4ZmTXiuIQGe3WSve5DiGquyLRBq/BzsiyyOmsFrRCX6NHbDtJQtUo5viHEH?=
 =?us-ascii?Q?0H3ZVbwMt7xgKnfAz6/h7izuLaRcQXXpKWzHDAyPR8ZRodV0YmfWcS81zqt8?=
 =?us-ascii?Q?UJE0lIUosMCy3ijEXoN5aM4wwJIySRMVzWuJrfZ22WOh5bZ5VCp1Bv/MTWtQ?=
 =?us-ascii?Q?ep86VxIVEwooljwC9iqP3y4IHAygQPgyhVUedN+y5ELJkbYHTe2kWGtYeF19?=
 =?us-ascii?Q?ND0ygYFVVghDAOUylPmHWqTO9DCMApB6hEkpRMHm526tMymiVSpZjFi+nWTn?=
 =?us-ascii?Q?eOm4QEE3KyLWlP0ORdRn1T0L3xeAc1h2W2Riv0szV79LcH2lhI+T+PdaGODr?=
 =?us-ascii?Q?nAHvab6AztOiYHlQhl7jN+0+O/fl0lG5hg4P3Kb6RLmg5F8jPjKRmb0ODFa8?=
 =?us-ascii?Q?TmX2lPmbFPmC+cK2CekAAvmdxpRTMLRxkAM7cP1pR4m8ZrXCoC1Bb10Sdz3t?=
 =?us-ascii?Q?oDZ6nsdyJQHJfmLSOtsu06H9aryaVcoSf0bUW5r7kxl/JtT+OygeayfbeK4t?=
 =?us-ascii?Q?oDc1WYwrmkRjZkxfqXl5Y2q30USIQ4bxbXiKDNTD0sCTE2EIQpVpD6hR5pbs?=
 =?us-ascii?Q?xOLhMINvdfb08OWZbuXxh/A+4ErShzsGu5kfBfm364o7MvS9KzkNrVQNw5zm?=
 =?us-ascii?Q?zdnBrZ0Qh+6mWN4UOyh/X6IOryPCG3ppUHQND9r5HtD7aFlVT3caDuUsfItp?=
 =?us-ascii?Q?25UTHNnKvRvz6uNiya0agaBVVAB//2Bk3mNbejWNKaNVWiojtKNjHeV8dbA2?=
 =?us-ascii?Q?bybpaiJVhi9v8xsBpRV2bZnFy51r2A6Nv6Xr8uoOPiuuhPRQ9w46tG65CwPC?=
 =?us-ascii?Q?jtdn+kVER79RufaD0OoOoLGQaZzqGaObXXv544bxcNqlxfnHjGvSyA3f9mpW?=
 =?us-ascii?Q?XGjfKlQtRHrIkSAELUHiBwlTqEPVQ4SdWFFwap7OT42buoFMRvOV6e5mSfCI?=
 =?us-ascii?Q?73kB54lwNN++2bh+0BjAhzdmlZdy3oP/VNSNu/vnBPBaSLVVD5FPkO4jSK4a?=
 =?us-ascii?Q?SlmR6LcUmEnh/0dWBob1xp+TpJurvIHE91TJ1UDggAPa1UosczE7SSXgdT+w?=
 =?us-ascii?Q?KG9OuPKw0mG+zgsSbSyF9iavXFEK0Cfwx9gyn6pyB/QLNv8wP+QXZq72ZDK5?=
 =?us-ascii?Q?Y5Blb7t2M/eSAzXpF0Dn9mWHQiMHo05RfGTu+S3628myXraIX1/Hrrijr4Br?=
 =?us-ascii?Q?p5T+jlmQ7kKeovq9ZtaMcDiJnASJfYBcu0/Dfe0WAUwIPT/mwBnjZIsHnnvz?=
 =?us-ascii?Q?vZm1LyZbbhM397tkPdmfiJMFtRPojV5iUyNvgNtwuD805YfQYRN3RmAzOFlG?=
 =?us-ascii?Q?PBQ1mM5IWrTSxf0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xOKBA4WXn7jaUZvraAF0LOFsEEYR/VnpeqKvatRgMoHGM8kSyI7rtZ2ymFWU?=
 =?us-ascii?Q?Ect5ZvBRVpSat8AwUPIMtm2+bqeB2QuAKuPpoUTUoUlEYGHMDMBq9kqAsD9a?=
 =?us-ascii?Q?xwYGfFFL23+7IVfh73JhF+m/n0TXUb8oTZPliTTHjaR8znsnnB/DuzIzXRDF?=
 =?us-ascii?Q?vsAXOLv68id8ExpeSKGM4mt2ulI7B5YEGIcMrcpcKW5wvetvcURQw76UsGqn?=
 =?us-ascii?Q?8vklG7pgc5ZKBZDEBLIJP7LGP86qpoiDURyRYhfwiVebQE7QRqYliycOqkkz?=
 =?us-ascii?Q?lRO8y8Ogzjgnojxz8g0+LTTNdIqVBsNQ51PrcyNXZNyBV2e5U/g0PFrl0F1L?=
 =?us-ascii?Q?JM3jPR1ve3fUMtRS5bbvbz+bXt3ayfQVKOla1hgkUE5B8KMWLpwIUTfMIve6?=
 =?us-ascii?Q?5WUL6SD/AnQfE8U4/+X49suXAavzLy8lTT2YZRhpWc7/iVhoVKsw0SpGSp0k?=
 =?us-ascii?Q?nEFINF2sotyWkH+BhZ37X/3QjHusWa8Zr5wyczwawQJPrX7SxPHCV6df2MGg?=
 =?us-ascii?Q?/k1B4A6gYhbKqcHWqaTGAiJwvJUlawJCTUHGhgzlS8Ph2/Zbi8wpUmC3ok5r?=
 =?us-ascii?Q?EHhHpAI5qhJxO483NXgEs131T015R/XLswEBK5HBlVJ/NfrCw+30EkMUmVu4?=
 =?us-ascii?Q?cdE1ucjdshqCO2MFuE+fr/bodT4aQcw++YNH3kvDydCEGqZ0cqmTJSGkYqE3?=
 =?us-ascii?Q?im/6lPWACdmaQOJdp8RUYGITc17jriZmb/ttkz5SJHtk1PKz9SYvRaUpfYwQ?=
 =?us-ascii?Q?iXSa4Vg3SOEIgcCZK10Zwh1uQeKNcZhAJargXS0zLWv5tCXs7bU6Pu83mXDY?=
 =?us-ascii?Q?xKPFr7n9BGZiws9KJM3DBgpA+DEERFzgHALWtZNhHOTqfwQgGTz6T1xjypiB?=
 =?us-ascii?Q?wqnmEXj0+I1r63ZWl+2Voadl8y4++kTzx0MZ0XZqvGw3bPH8JskHpii9CaRX?=
 =?us-ascii?Q?Xd2wjtyS3rtvFUoJCmpnNktgctn7pha10Hcn4JXxqJ2nmgFgGzdQNB0Cg5Fm?=
 =?us-ascii?Q?S9R4YKu3lPhsv3Wgvhc6keWSvD67aYmjGUHFH7MOtqDWS4FaTLb709OIYl6s?=
 =?us-ascii?Q?4qUKd05GNhLStQN9jeolZT3+pnxlaSZZgJ1hfHON9GhuAeSRhG/bdwwQ2P0D?=
 =?us-ascii?Q?G2RB9t40Pe3KbiIdHQn/Ya3jL4KZ6tTMqQy8BYtFtuG3ESFcOqarbrxCJGx7?=
 =?us-ascii?Q?+eIFP+nrFDmVp47AqMphXt2kwqrChu8pzEC7Dn/JQStgEFEkiVgAiwLxbuB1?=
 =?us-ascii?Q?74Z1Ix/GE2o8RNJeNIuU9BeSFAi5KuTKqG6sB9Bb3qpEis1fWXGNOnfcEn7Y?=
 =?us-ascii?Q?2IzeYi72SPanoPdKwk2f9MnOlmFwQeLSF/K39hdD7Nu4t0JNRs/FrlBjOGMR?=
 =?us-ascii?Q?Ti1EbGHy1QmJEyFdY4ijUUVst2VLhWwBBNVBlbt8Nirk/SIqjvF0+dWjzVeL?=
 =?us-ascii?Q?tBPoorZfry8RLSUdkvs1GEoyUNX+4VDWZF220jcYMXkKquomdhgXw6c2p1Rp?=
 =?us-ascii?Q?H7ItrUatW1GvxEBnNmn53hP0NO30OUoGCqTWpPTKGsAiAolgkGklEJR7MMZY?=
 =?us-ascii?Q?n/V6l6CH5s6SmnuxsFnz3l1XBWA4aa2GTzXEJeTf?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b35400b-63e4-47f3-616e-08ddda4d49e2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 09:39:24.7004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3wzqAKygRVLSPU5j3Tz4J+eIwfj3GslFSQUpduvn+1j1jxR04xeg/W2eZd3cmbD3sV5MNApHs7i29ICMYSJlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4978

Remove unnecessary semicolons.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 sound/soc/intel/atom/sst/sst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index e0357d257c6c..3c47c8de04b7 100644
--- a/sound/soc/intel/atom/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -64,7 +64,7 @@ static irqreturn_t intel_sst_interrupt_mrfld(int irq, void *context)
 		header.p.header_high.part.done = 0;
 		sst_shim_write64(drv->shim, drv->ipc_reg.ipcx, header.full);
 
-		/* write 1 to clear status register */;
+		/* write 1 to clear status register */
 		isr.part.done_interrupt = 1;
 		sst_shim_write64(drv->shim, SST_ISRX, isr.full);
 		spin_unlock(&drv->ipc_spin_lock);
-- 
2.34.1


