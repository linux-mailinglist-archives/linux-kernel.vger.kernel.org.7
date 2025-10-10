Return-Path: <linux-kernel+bounces-847839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F0CBCBDAE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 246273517C9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4934523A9AC;
	Fri, 10 Oct 2025 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Pj8Zc96d"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35E7AD4B
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760079991; cv=fail; b=NOUtzcav30+hkRKsGPkMbvfAYYS9ZhuFunVu8Hgu/YLzweQdE+hhxmHgHHInpVSThoxH8JfjwsWaPsH9VZZpZH74+Fr9VhaJeHC+Hi0hTuQzVYjAZu2jK2dkYDQsf4ykLJECedO6dXIgKENf+5OzcLVRoCiI0JxxDBL7ofHypR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760079991; c=relaxed/simple;
	bh=a83p9dET9/VwfpCMh+pWs/MThOOYCA7jIsGFsfjTBnw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aMnOkr9O67lOespjUtnrCqXs8MykHAxhRBz8oHsJNDYEohjxgqFG5tbcBetre6eL/gfftvg+9jts+007JjCgVIl1PxWVsRe9xRhj8nFVg5CveHBdVD4+OD1zizUrUXFH3qiyDJ98t9/e60tyz4kBJxmnnJG30g3XdoktPH+OZoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Pj8Zc96d; arc=fail smtp.client-ip=40.107.209.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWr3WReOiBdtU76Lqw0hB0rp0HQBe2upBdHDR2o5/ZUoHaDWdhjL9VNGC38tJlW4z2XIouHMg0bBmgipQ1MKf0V2PvMuDwijPcsb6jO3WXfYUSydt4GLZcbin4Kuog/ZC2CWn173saIQQE5DIkwc6bxWcgeCEtSEit6gs/QvDlh0u7VveMMAxHdXTkJqY2cvBg4jIvKLoyxOrJB/oxUfFRr5x5J3Iaw6qm/bttnk20jvWkl+AVMJzX2s/7EakoEkVKxYjzVUnrPnKcA3yx+F90ApSJ7SVqAeYkvq1ACERmneLlFjr8NkllgICBhMa3Q7VQyzplKGVKI9AS7BM52S/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osVjU6/3HvPxoKbGOzab4V9/CWq3EJ0SikkkdAGPHyo=;
 b=ehbxboqfx/OIsMGigiKu2h+s0P79mDeeOv/joNF+OQymGqcAZK6zxlC3u+oGf/yuHqcOrGb/8ep0JrylWv4MuJ8T40dvJbbzy/kvkyy6qYUBDOI2oq+xCXXTdfeLYJ0owqWfHOyeJPd4eNh1fUkDV3ZiWc+eDoTrG3VOTcgT9CS2BUzoS+yf6wgZe3ahcchC8eeEnh3E5T01M42/4LGJppXDtbt8sfuhMqVlcnB/2R9ci9D8GV7vs6NI0uw0YbouheW3SSVjtG2rJje7a2pHS7Hofq5pUpfXrlFCZSEj9jMhafXtrOD0ziO22lccrJLQmxe22oEYBT+2EtWUIW44mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osVjU6/3HvPxoKbGOzab4V9/CWq3EJ0SikkkdAGPHyo=;
 b=Pj8Zc96dkTFUYdJEpSoyDyQp/+JEFObJF/9VFc8x7COD5dfozirTYMUrs5hNm9fJJSKg/W98HsWUNFDL3b6Lp9OxgVP7UdwPQ78nzqpWNLpRnwKZ7HnrHjHptO/7/Fz1HJdoMBi7P9THUv0m/7rHbWw4x8Yf9/1UqMcJ/it+ThkWDHS/p9VoEOftmYBQ7iL+0uKqgLz05FgOQBdchXuR8OljlCKjrM2SNfqJyNk66G5By2x3wHG3B5pUN4+5cZ0WSbhDoV0N14yCjxQQ5pLlbtGvxKDiac1zphwZ/JRfu6k1Zi8mEVmnvaolatrMN0v7Q9CJM/cE0jSVHXA+msuUfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by DM6PR03MB5130.namprd03.prod.outlook.com (2603:10b6:5:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 07:06:27 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 07:06:27 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	linux-kernel@vger.kernel.org (open list:INTEL STRATIX10 FIRMWARE DRIVERS),
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH 1/1] firmware: stratix10-svc: Add definition for voltage and temperature sensor
Date: Fri, 10 Oct 2025 15:06:22 +0800
Message-Id: <5797fa3875f39c30ab5c942310abc913344335a6.1759914326.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1759914326.git.khairul.anuar.romli@altera.com>
References: <cover.1759914326.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::7) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|DM6PR03MB5130:EE_
X-MS-Office365-Filtering-Correlation-Id: 1168e349-e040-4e3a-f010-08de07cb87b6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d9PYvGCaqGwRYPfAuW40zhV5DaU9WV6frL6YEHmt/neiq70WiNKZjJYrZ7pv?=
 =?us-ascii?Q?7Vlyannj2qI4uk/RAnAnkdh7l+SNtikkVzgHfLDYhzW8qypdnRZ89BAK+8PT?=
 =?us-ascii?Q?tPJFQnWXNza/yrm7JLHQ8MqGOabgoGTGU6KmlXEdkMblHCPWXc+wu93jrd54?=
 =?us-ascii?Q?HXcbwkyMSJwRJWAhzjoZTHBoB57XJs5UWk0PZY7poROmcWYJ8e28QksTwOU4?=
 =?us-ascii?Q?Iv2qOwVEoDIM8c8I9yG4OJ64cfDM9pAguxkKq8qSCkrUoSeRef9+usoNZuMD?=
 =?us-ascii?Q?NyytHcODSgmhPYq8LA571YP2mhAUkHzOooJzW5q5desOAyP/+UZEQRuR/Ezp?=
 =?us-ascii?Q?iS6c51TAm+3psiCTGx6swGPXyBmdJbHHYn1btjzFkjGidhyYbaXcJK+ft9/E?=
 =?us-ascii?Q?tNE4TsfqeE5c1pneyq1lMCbp/lcV+kr37B1WMUkcheiD39lVsWS/3a6douTx?=
 =?us-ascii?Q?D+ICPqrsM3O1jos+gJOwX7zeoikyxLqeA1xwgEe11foQChl+8uVj6H7jokR4?=
 =?us-ascii?Q?CYNerdxjg2WTm8PfhXhE+lZRBMUKfvteX72esPB99HYgsp3igAtZBgnOObbH?=
 =?us-ascii?Q?GUFyOOMoMnytqJcgCsm4QFEtTD/UDf8hXgDen4jIkiyOz/nggG0Z5arKiTTw?=
 =?us-ascii?Q?ASXRUnvyWFQsB5q1wmQ/J4+ZJ8Z8S+5FxQnRFnrMDuqmZq27WXnYwM8iJvfB?=
 =?us-ascii?Q?BwVq8TRlhNA+FZn5KN0o2QT6WjDzz5GUBAxs67VEHpVLFsFXoplhhSa3ZaOO?=
 =?us-ascii?Q?r70VJ7a61sLf/ZeKcNORMxBGM0j2ZuuQzWYxKwHyeUxVy0Tfy6Qk1Kxs3ZQ/?=
 =?us-ascii?Q?e5SyfFddc8r3YF3YV7+dB0euM69Bye6zeqNz5DrQaeVV3QrWt4iWkTUDRuZl?=
 =?us-ascii?Q?Ei2UTIctInnTQ1JZCDO/Prcw02Zpio5n5Enwc972+2YL/bgOO/Y94N9vqDN8?=
 =?us-ascii?Q?4ZrrVUKoBrvEkECQvV3+OzKSKEjfVwRQkBWbfTcFOitYH3+fD9C0XkD4VlVz?=
 =?us-ascii?Q?+io93TKLhekLJHri/a/W0WKXOI9AY46SQqmGcFv1yjvVcUw05D8/hjFiWptB?=
 =?us-ascii?Q?MbmYpMUKRC15PrAvlwiBOogEKRgblJUgO5sdr2lALspXFAiz7UviLxdSzK1A?=
 =?us-ascii?Q?S037mN45GD0aU9w3UbnG77p/KGFd4GteQEbm04Tv8IsqpLCESVyzPk5EO3J4?=
 =?us-ascii?Q?yQEtBZrvsY/w73iMNA9fpBSJzbAqReY8Z+QoW6Zu/on+sxZn+rfxqlB6wAE+?=
 =?us-ascii?Q?fNd3Mf5xQN3SvuxRjHwPUZWSKibRKPqS9kbk3ofQRGJbz4nOk6i88+3gnsgw?=
 =?us-ascii?Q?jVqvoRQv2oOdfBlMEUwAc+S1lMFxbMj/WkagBx5fS2y6AXtG74nOVy2w9uZh?=
 =?us-ascii?Q?+eBEkXoR2qkvF1QgwIhZ1bMF0ParGhzbGxMjR5L23Z54M8EsxeJUAsGDyxyR?=
 =?us-ascii?Q?Y0KkaG/fJWvSWvQcrBs3Z994WLFEvBl0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RPp5AW83ECvsEmbR09FtjPln7d04o8xRtUpXayqU/6OvvBf950cURLcXmcIb?=
 =?us-ascii?Q?L64aXnTbW8ZVI/2ZtJGTT0nlRl+ehxe1HrLpmuqiFnU5b4ex240s+IqztrkM?=
 =?us-ascii?Q?2hKv2w/DBkC7zk3lSEmtAfdKVozakAcK01Kbc1elFdl+0j9VLNHIMUiX6tq+?=
 =?us-ascii?Q?QXZ2Vc6Rx7tl/XOVpXgPuYXB0Wb7JbPZHXFxpnqGrGjvMWW01zW8Gnfulwpo?=
 =?us-ascii?Q?t6yOYypWB67XJTwbpIOPORBAABWUtzNEAudCwiinK93aQA8BGBDHeU5VoiJU?=
 =?us-ascii?Q?bwVkx8HXZ8aSbAgp3t+aihpCKSPS/5foO24SRcBBU8z7vrxMKFI2S31N2AJs?=
 =?us-ascii?Q?g/Pbw12gIjvXqY7kRPjwaq0ACjyLw5G7k2rZ/Ob1xFIT4y3V6mOnkpm97ebh?=
 =?us-ascii?Q?/Y1pETqCTtGjP1FpMIa7ut81gL9rbBHsGTGmZ588L7fKH4Py7QZgGqIvSps+?=
 =?us-ascii?Q?wSD3qVc2wEEtDaIE91USoCKYtPQco+8BZiefzKUmcrur3El07cUVkocidZny?=
 =?us-ascii?Q?J1MGN5N7teMjSApWRGfYwtZgphcrRlYjtXbZo6EJ11rmmYlI/yVl2FAlW8CA?=
 =?us-ascii?Q?N9+QwrykW0Wc2clFNfRKITfd6LxjWePLx37+3nAyUcjkJ3ZapU+Vvc4aJppC?=
 =?us-ascii?Q?2tC4i7N2gvqSBRui7FkIzYXlKjEGkJON+wj3bQ0xvcy9eBL41RuxL4SHIeqK?=
 =?us-ascii?Q?VRHyOVuEmlTEuAWW68MZE09fk20eswavp1GSmAdaJZihP6GyePwhQl66Lqee?=
 =?us-ascii?Q?TzE/a+gwGBID1k6J1DM87MHECOTQkVnTpLXAGEKVgUR3meT0AnaqGYdhhRzp?=
 =?us-ascii?Q?YBqqmEaRpQE7au/ImzOgOKBExDidykzx563YQgmvq33Nf2qbPCrkDJ7xYirw?=
 =?us-ascii?Q?RlEmso3RgAPt3yBKwHstPMratyOHWNO0J+s7AO9lyBF9lq9QWz+qRdnXDKgx?=
 =?us-ascii?Q?uYy8VCOWHEBTD3Fp+iFh2VAQxFYLPQVOmPTNxGI60AMm849/diSeUDfNT3Ef?=
 =?us-ascii?Q?tC0xutMI6A6Vd0LcOz91lBeB2r7OYRzJuW9vX/h6bv4vd5ZuvkKvchwAevgR?=
 =?us-ascii?Q?4JCskfHgQclO0ZPFY0yqzEgSZ561fQHVwzpCBpD+uKS11Pcbq6A8/NtYmY8i?=
 =?us-ascii?Q?lJX4Xc2l6PrpwFvkRbjddJBbyV/yPXsVoZIkcE5ARzVKSnoVsVX3I7dX6kBk?=
 =?us-ascii?Q?6B8adzuacDxEtbqw5JRnjvZs3UVzzX5KXh3WSEJTxOmH0P4Pnx+Ez+dxzsf6?=
 =?us-ascii?Q?QeCwQ09I8WGRrwGUNIPxriEnelrZ4I1Mx+GsqobL7gqAQMjpAVEB9jFRw/EV?=
 =?us-ascii?Q?DBc6xZfsyEHECSM8xqF/Zs3is8QToHXgfe/V+MbKZ1A7krQOVLMznmNhGQFS?=
 =?us-ascii?Q?bPDFVoFAZ4rUCXhD0/B1w0l0wE2Dqz0A6vALR/2lQs361DGgowj+aM8A7zlz?=
 =?us-ascii?Q?Q+1Ve4pTLOATJmewGD+hjYEPspjnanu1xNoE/i5GknlCh/nUDAwaKNbGGBWv?=
 =?us-ascii?Q?j9WWP+UiKOhQOuTb7vlnFcH7Lh47fONHNYQKF3L+RN/A/sWBE9bAwrCVRMRu?=
 =?us-ascii?Q?z+ICjdbJrBvdQA2eMl8NkPfMPwRiU9pkxtdnQ0S6vnQ68JpXDsRuYqxuWVFO?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1168e349-e040-4e3a-f010-08de07cb87b6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 07:06:27.2648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQhKJe9AS2EMruuzvhcDQB9SOgwtaa3l68GAKW+aozYhqNVIP8vopFJAwtzMnIQrgjUrTd7ZYHU9WrS0ZV9cOaJX6xXplFtWh/oxLObHlgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5130

Add entry in Stratix 10 Service Layer to support temperature and voltage
sensor.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
 drivers/firmware/stratix10-svc.c              | 21 ++++++++++--
 include/linux/firmware/intel/stratix10-smc.h  | 34 +++++++++++++++++++
 .../firmware/intel/stratix10-svc-client.h     |  8 ++++-
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index e3f990d888d7..5a32c1054bee 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -34,7 +34,7 @@
  * timeout is set to 30 seconds (30 * 1000) at Intel Stratix10 SoC.
  */
 #define SVC_NUM_DATA_IN_FIFO			32
-#define SVC_NUM_CHANNEL				3
+#define SVC_NUM_CHANNEL				4
 #define FPGA_CONFIG_DATA_CLAIM_TIMEOUT_MS	200
 #define FPGA_CONFIG_STATUS_TIMEOUT_SEC		30
 #define BYTE_TO_WORD_SIZE              4
@@ -341,6 +341,8 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_RSU_MAX_RETRY:
 	case COMMAND_RSU_DCMF_STATUS:
 	case COMMAND_FIRMWARE_VERSION:
+	case COMMAND_HWMON_READTEMP:
+	case COMMAND_HWMON_READVOLT:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		cb_data->kaddr1 = &res.a1;
 		break;
@@ -525,7 +527,17 @@ static int svc_normal_to_secure_thread(void *data)
 			a1 = (unsigned long)pdata->paddr;
 			a2 = 0;
 			break;
-
+		/* for HWMON */
+		case COMMAND_HWMON_READTEMP:
+			a0 = INTEL_SIP_SMC_HWMON_READTEMP;
+			a1 = pdata->arg[0];
+			a2 = 0;
+			break;
+		case COMMAND_HWMON_READVOLT:
+			a0 = INTEL_SIP_SMC_HWMON_READVOLT;
+			a1 = pdata->arg[0];
+			a2 = 0;
+			break;
 		/* for polling */
 		case COMMAND_POLL_SERVICE_STATUS:
 			a0 = INTEL_SIP_SMC_SERVICE_COMPLETED;
@@ -1197,6 +1209,11 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	chans[2].name = SVC_CLIENT_FCS;
 	spin_lock_init(&chans[2].lock);
 
+	chans[3].scl = NULL;
+	chans[3].ctrl = controller;
+	chans[3].name = SVC_CLIENT_HWMON;
+	spin_lock_init(&chans[3].lock);
+
 	list_add_tail(&controller->node, &svc_ctrl);
 	platform_set_drvdata(pdev, controller);
 
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index ee80ca4bb0d0..7306dd243b2a 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -620,4 +620,38 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FCS_GET_PROVISION_DATA \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_PROVISION_DATA)
 
+/**
+ * Request INTEL_SIP_SMC_HWMON_READTEMP
+ * Sync call to request temperature
+ *
+ * Call register usage:
+ * a0 Temperature Channel
+ * a1-a7 not used
+ *
+ * Return status
+ * a0 INTEL_SIP_SMC_STATUS_OK
+ * a1 Temperature Value
+ * a2-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_HWMON_READTEMP 32
+#define INTEL_SIP_SMC_HWMON_READTEMP \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_HWMON_READTEMP)
+
+/**
+ * Request INTEL_SIP_SMC_HWMON_READVOLT
+ * Sync call to request voltage
+ *
+ * Call register usage:
+ * a0 Voltage Channel
+ * a1-a7 not used
+ *
+ * Return status
+ * a0 INTEL_SIP_SMC_STATUS_OK
+ * a1 Voltage Value
+ * a2-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_HWMON_READVOLT 33
+#define INTEL_SIP_SMC_HWMON_READVOLT \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_HWMON_READVOLT)
+
 #endif
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 60ed82112680..520004a5f15d 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -11,12 +11,14 @@
  *
  * fpga: for FPGA configuration
  * rsu: for remote status update
+ * hwmon: for hardware monitoring (voltage and temperature)
  */
 #define SVC_CLIENT_FPGA			"fpga"
 #define SVC_CLIENT_RSU			"rsu"
 #define SVC_CLIENT_FCS			"fcs"
+#define SVC_CLIENT_HWMON		"hwmon"
 
-/*
+/**
  * Status of the sent command, in bit number
  *
  * SVC_STATUS_OK:
@@ -70,6 +72,7 @@
 #define SVC_RSU_REQUEST_TIMEOUT_MS              300
 #define SVC_FCS_REQUEST_TIMEOUT_MS		2000
 #define SVC_COMPLETED_TIMEOUT_MS		30000
+#define SVC_HWMON_REQUEST_TIMEOUT_MS		300
 
 struct stratix10_svc_chan;
 
@@ -171,6 +174,9 @@ enum stratix10_svc_command_code {
 	COMMAND_MBOX_SEND_CMD = 100,
 	/* Non-mailbox SMC Call */
 	COMMAND_SMC_SVC_VERSION = 200,
+	/* for HWMON */
+	COMMAND_HWMON_READTEMP,
+	COMMAND_HWMON_READVOLT
 };
 
 /**
-- 
2.35.3


