Return-Path: <linux-kernel+bounces-788234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4711FB381A4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58BF1BA6A87
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76DC35FC31;
	Wed, 27 Aug 2025 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Nmt6xtBK"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012049.outbound.protection.outlook.com [52.101.126.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B3F35FC36
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294836; cv=fail; b=NaEdM3SToJ/cHSAv+i18NSXNYWjB9prx3MLNQGikZvt/gKi9TGr4hGFhFMT4+29ABtJhQNCb+nUL39yx2sCrzidY3kmP9l1bgTQxK90NS5YuqMtF6sDTlbEMejmtM4z1izeI8GCZnQdzXFhe8kkI+In1LuP30d5Cdp0y8rsuNzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294836; c=relaxed/simple;
	bh=liFRpgwE5iwlIx6n+INmZ5HyK5xdIMe6WLyt/h0vFj8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=toxyC1L4/9xpbd2Xs2U/uiTD7Gshsp0lssMOPbpyEo8ZN5uvw00d6I+aPENpCwqwpm+Pgp3nRMNvprvlROvbL6EW93iD1+rleHh3yFb3VMIneHg6mugrxRUemiyuiRcpt2f+LYDdCN2vZKh36/t4QmHtXve2uvP5djLbZKPaYuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Nmt6xtBK; arc=fail smtp.client-ip=52.101.126.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2H0LeR5e2d6vgp7z4qkL1WfhHEXfaqia3Npadg1Z5AVC8rAERSrRqmR75RlvIFGU6wMAmFBltxPYzKURKmSu84nbUa04LThJS1KvEh4UuEvai4B+jQOjb5FtELrTpaH/BZdTav9JcmOA7huJc+VZyn32+PUiBacY5q7jizZgRHisTZ06meDcHibYp/Hd6SiydodLuiryxqwDoF7TGoUSJnPUzqnEVFOmRCs/9rqgUtEvlUjssda8wCzzpV18K5qxBQGrQ2WSJmjt0K2PQF2ABjH8mBWGD3OOOEuZKg8tTjUngxUa6erHY5hnwvON0yyn4oajMwUM5e8GxVugDuK+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=re4LfGZjA+XThz0ESWanE5sZD7/A/2tTCLWufA4Xp2M=;
 b=wD1quWBpEE7rTpSvMmurIldfcevF4Smoe2plNgaYvOV6JmQsc2jg7EFxoZFKSofyuckYo71fWZSLtafehSO/331hFUezGvf7r09+rl+mdiLeyGg5WyaGNCuoTDwqCvrSvtvKxmgL/ZOYJTwOIqRvBPvI2EiyLJsgThbicUsk6ABrbdUSgHJ0rhH6hLNcLgwh2aewl2OmQkD8xybb5cDryxN6qW5GqfTH40MCCzoTMr0zPJuvThuCpyeOMY9Jg9NLM0eHaVuWO3UBrhqXhhYoqS/w3d3jkZKDvlud/zEujyJAvW9/l4yYGKPR7IEB/VhmjSL1REMILoHW9eThICQTrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=re4LfGZjA+XThz0ESWanE5sZD7/A/2tTCLWufA4Xp2M=;
 b=Nmt6xtBKWJb3db9fx0jq2pICOV/kXKhRJ+qXlfRE13ytDQWnPCNIHSHsPXIcYfEvthuU/LfoPmujw1yqHNP4JHae0tuSWu0G7tPIoABIbi/KXSfgArpDIB4jvpdYa0reWFdS+LCxOKX72QBrKx0VCeynIhB5AneGajdtXxhXtUK4TO1toSfUh6RxhydaVoTbsQL3LORmqUhJ5f09SlrZ/6m43GLPcg+l8pWnpdvTMJmeDfRCCnbEExFe+p3KLOATBQRpGViRglFmt9Zm5pRiGw99co7P6CuJQ25I3l3gbtrQjKIN2XaadIXudY0tUwxWxIjotdU5HOuuPnQHsWhraw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SEZPR06MB5590.apcprd06.prod.outlook.com (2603:1096:101:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Wed, 27 Aug
 2025 11:40:31 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 11:40:31 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] drivers: base: fix "publically"->"publicly"
Date: Wed, 27 Aug 2025 19:40:21 +0800
Message-Id: <20250827114021.476668-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0050.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::8) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SEZPR06MB5590:EE_
X-MS-Office365-Filtering-Correlation-Id: 6047487e-784e-40fe-19b9-08dde55e873a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ey4AskCDns3VsYW3tbxO7hP42V4DsoomO5TUqF14rPpiC4NB7hMmDERBKi8R?=
 =?us-ascii?Q?7uTOsHpIBEoNvK0TWZjX/QnoZPdzR2N8C+mqNK3PhkEE7NZ1G6No4A6dj+x8?=
 =?us-ascii?Q?/GRL2gT8Krm6DBxSiKBk0r7118CQTTeZR46Ra7HWsm0HVoX9FvAEtVd3b96T?=
 =?us-ascii?Q?6rwAjvQAAML9f/xaJ/n3zbK/76ByECh8EBj+BE3TvdixlJf15g1TAnqHB4Es?=
 =?us-ascii?Q?O1A5p5alI19wQdu8CW9xX/iKCAEiwhSYozbD+Obj05U1fNDAkWwMS2sGhqAm?=
 =?us-ascii?Q?teboDgyvebQ3c6fjMKhLaKlz05Vx4lNyoFzTqiqqdo+MGU38A9B/3G5h5zQp?=
 =?us-ascii?Q?uCn2ZmzgTZ0AGzAStjP5mug6gFTGnVQ1dvtpZL5QmYWAN1W+tqSn4Qdxs96C?=
 =?us-ascii?Q?1QvxY9GI58UgJ3OJP89wdOtXCNIiS+3WUXlYQtxQFZsJL78jfOlyBZxlCFQ7?=
 =?us-ascii?Q?dDfgKf68HnH9MGke+10P6lYAzEdzbdOq2AqYT8b8h3lwjn2of570yaPA459E?=
 =?us-ascii?Q?wXA3K6gLxNgeJ34NmEdANqOZWcbPfQKb0dkXicM50H7QjK4msgybeFVgqebb?=
 =?us-ascii?Q?e8TgbbefIHlbASHlN9Ah7HzocxrSogsLaEWGH+uPy3m9A7RjutkzI7xQQ4tc?=
 =?us-ascii?Q?tFwf+SbEMRvH4UWHnMaZwJKQ41pbTakwx2lBYbIYVvw/Q0kA22VWh5G00OZp?=
 =?us-ascii?Q?43TL5Xm8bK1o6/whDTClHDkRfX6dXjkHYwG6JhTS0VgfT8V/6EPyU/NBfGB5?=
 =?us-ascii?Q?jTQaFD5744U23Cd1YL/YxghSVmnYNozMmYU3Pz/S0YfLQT2yqiB2+VcsKAK6?=
 =?us-ascii?Q?wODCxVrEKNfPBjqujBeQaJ1hI/ILQO3gscg4qlkWEXQkEM0nym7Ng0ibnChy?=
 =?us-ascii?Q?aBZDRusQWuGehhrO2bMmRlXfqVzN1HgD4YEiagyIqIp0L88BKopHUH7u8+b6?=
 =?us-ascii?Q?Q26E2DysyCmFzauWArmmNYrS0wjjOz4RNRQa76AuaBW6oYloZNgc4jx9NnEm?=
 =?us-ascii?Q?jNNrfNbxlGrVcrNIdSDtGarajJSOhFTsMDLKL98BO8bk4JF4a9D+g7winhDE?=
 =?us-ascii?Q?Pw3TbdYfpaj8bPifJWgym3Ocb1VXjkKRbuo+nxxx4TGUL1KBRPcIef8LTYU7?=
 =?us-ascii?Q?IZX8FqxrKxPMPHu+JEmVB7gi09U6mIvkFWn2XmG9KJciURPd6rA2YhK3hta5?=
 =?us-ascii?Q?TDAjGrX5IpDZAvUY7a/64IAwgips4rC+zE3Hku1pnLGLB46WaMswNRHK6088?=
 =?us-ascii?Q?stZRW7JweK5m+7HyrBM6vB6L5HT3/gMskJV8gTKEWawbZCDAq2GN7HMweLP1?=
 =?us-ascii?Q?ziIJW8/ut18I+RaanLu0IFYMDsjuC3DegAG9an6iiEXOcV5xTzS7KvrE+Zit?=
 =?us-ascii?Q?TfG36OthgQbA5XwLznie28bgSLHnBGrrzVFiavbjTkcuSa2ifBeQ8uCoyI+4?=
 =?us-ascii?Q?CdTbfNtzl74FQDxiwW2mTHu1y7eDSUdD0dCk/NFtrcwyx6GjFE5HSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NyOJLn10o8rNVR0RknsBGW0M337PuCcKlaRJUSQ/AvOaiQzNtFP6GJPY7YV2?=
 =?us-ascii?Q?d4vDWzDW2OwPUobGDBDMn6NZMGKI+kArmMtHfLqeM8lUm1f4QhOnqd1edDzm?=
 =?us-ascii?Q?nmNORuRzUMzv2VAxGgp1vcWf27MgBhJ79dhuIthspcl5fCr1QI0uR3CM4kRV?=
 =?us-ascii?Q?7tvZ7EU4zkeR+dyMB0sCPczVEduir4YvTWmIZ3U2PY2+zQMWx/3aTKB9a0s+?=
 =?us-ascii?Q?ckxguBoEYKW65bskOORxOYpAganjZg9PrRozUD3OAr09YqqWZ+OXf8Obx/Og?=
 =?us-ascii?Q?Sl0fw0skyVKtiKA7yAflGOpPZ+neVJ4LbyaFZFsd2FzctX/NOCwndq/vrsdD?=
 =?us-ascii?Q?fyC3kb7hvfJzuK1Fal0Dq/I+DHW29vU1jvJtfNU9GcxEgaiHV9xvoWm0bnqo?=
 =?us-ascii?Q?GUD+JJMXVGx2t04l0EKxYAU01CFEPIp+iqNAaN0sdwi/kEDoB8ilouruET2V?=
 =?us-ascii?Q?BGNNSq5b4pL7DPLgAjZBHYQxuC3SypMrfpaYOMRk0hG4RYoiOoZ2vpqysnIc?=
 =?us-ascii?Q?Z4PkcBVyup5vtHGEuMEXCMBWqSi6/MBZTefwpUD2Hv2WU+XKMTLBMy8JIUDz?=
 =?us-ascii?Q?MBy/UiPHihqh33gR5iPjPVAB2b8LaLMus373RMO+P7DiobGKT0vHji2XuUa5?=
 =?us-ascii?Q?4YjXG1GyoHpoTSB8zXHzUtxHJFXzs335yeB0d6au9bp7T3wXfXLOBO3W/RtR?=
 =?us-ascii?Q?75Bfg5pJjmDIcFdP+tnwmY41jdNfrw65HbuJ40M225tNo9sc9XSsu62vJ39q?=
 =?us-ascii?Q?AHDfA0eDXAvtyE7wHaACryObsk2cvMeLUP69rBoaWglh7EsAUAAIA+V0a4sp?=
 =?us-ascii?Q?WXVeP0meunPI1LZmtfZ21e0I4gL9hQP5WjLCpjVv2XIbKp2v7pE8Nbt3N5z3?=
 =?us-ascii?Q?SKG4l/qdDzqkm9bB65SXuZ9Fn+lFAZn5yD6eTkFE0uGfPDmREMQirnukvjTt?=
 =?us-ascii?Q?LBCFpNMvjzxVBC/3UR9ZdqXpkowwxlztdOe4pbETaB9CwrMcKZY5xFejBQVM?=
 =?us-ascii?Q?kskCSFuq2solGOMDOoNqT+LqSR/ZDsZxu/NX3eBpoQnTUxrRmEtw5eHkrcKa?=
 =?us-ascii?Q?HjAg1xTOdZfHVKn2HNQwWmnCrSTomRlM7rhuz3SHPvXIVnr9QtXpDDD0Jaha?=
 =?us-ascii?Q?I4Wt/PjNvZe1lIbKP9C7jEhYWTtMCIDO3nO7ppX3dBwrFUr8t10m67eHsGBE?=
 =?us-ascii?Q?o8KFSu9V/IQFdXeb8wGY8UexUfrIS304ochlFDpvgQNkLppUi/Hwwg0snDoq?=
 =?us-ascii?Q?ZpNbGXG2a5oX19eG1mCmAIajCWzKzrYPoLZ+BeAid2i7ZJT3RtmtBI37fn9R?=
 =?us-ascii?Q?Lfmmfg5wvROiOV14FyNo7MLf87sVGI2Ky6SVfEcsNqlXzTTy3inMoUxfE4v6?=
 =?us-ascii?Q?2o3KLGgMV2MxKOIraHb8YeQ2YiFxb0IQe9HAdMXhxFwwocyX5YS5SQ+Bk0qE?=
 =?us-ascii?Q?AFJWTwuYePTnk/EySo9lIQ3hr6E7P0RoRHlGUpSrjfyI7IfXKu9bzG+cP4ze?=
 =?us-ascii?Q?FiH166S5nrtpNTyvoo3fS7bwzjMKWyauf8Q78PMXVTOEZiugKnjrK7xjJ0c+?=
 =?us-ascii?Q?1Cte4uDivjcZIAHcW4ZMjDIq9GFHoYnOprTOCuw9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6047487e-784e-40fe-19b9-08dde55e873a
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 11:40:31.6843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fUsgYPRL0blVElJbT+gdRVFKXqcTU8McnIKb+LpxOeTusVQTbfoSQGJxXe6ZXbOx7FAmVWgcIE3FdPN9KRWa+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5590

Trivial fix to spelling mistake in comment text.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/base/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index efc575a00edd..ccaebb8ac656 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -325,7 +325,7 @@ static void cpu_device_release(struct device *dev)
 	 * This is an empty function to prevent the driver core from spitting a
 	 * warning at us.  Yes, I know this is directly opposite of what the
 	 * documentation for the driver core and kobjects say, and the author
-	 * of this code has already been publically ridiculed for doing
+	 * of this code has already been publicly ridiculed for doing
 	 * something as foolish as this.  However, at this point in time, it is
 	 * the only way to handle the issue of statically allocated cpu
 	 * devices.  The different architectures will have their cpu device
-- 
2.34.1


