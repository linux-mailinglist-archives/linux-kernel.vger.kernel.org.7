Return-Path: <linux-kernel+bounces-779429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C20B2F40D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4273F3B1D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDCB2D9ED8;
	Thu, 21 Aug 2025 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Qjk46bmO"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013048.outbound.protection.outlook.com [52.101.127.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F8C72625
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768789; cv=fail; b=K5aO4j5TmNvDTmPzgD66S90ckhCQa9J6cO0Ihayq0Tjg0ZrOREBhisBvauesrSsBZ+3YIR7aErQ0NjeVmVSUDQSnmpjJe4gszlt9tPtaBcLNezKydy7MbAtDMUFUOf4zJo9/PI74gc6NpCQZ4pE7GqOjedhnoPt4tf0lx4Weyog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768789; c=relaxed/simple;
	bh=ZENZNWHiNIvEdsn6WGxvqaNK/XhIyihoWtDyk5jQgVA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aDid3kzys4AV+i9Z1jBt73LN5eRtV+usAwjUqt3uCg+JH79lhdYNOVW5ZBH6OWRaKvGBP6e35UfkjPtKRlE7+AJie//IbN9oFDVtA36Wwa1JEtTFu7OjzGbhZW1hlgvzLLY4JuNukJb6SK2CAAgK3NNTompkxRfP8zkzvJ1L1Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Qjk46bmO; arc=fail smtp.client-ip=52.101.127.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4HwbR+NxOtnutTYt2/cVpZaOzKn7P9bHxQJK/JtAeFeVhOKSax7aRpwSLW4zAGXk2ZzjJkA3zFZEQ71m2D8aE8/scWZakMFaA7+XA0QcgPDatdibaPgSu6lMlWvpCFNDn6k75dU3X2R9TqOAIBH/YISxApUuKhMeN/LKpVM3X1k1G4ApxJyBzbYfn/O7doxaZpsF3R9+Ws81Rel8u/R9uQTzfhXW6wK5pD4mgjNQt7JaVuSToCvOIExDRMZntzjVco85RSC0ZDLpaNPtU5hSRbpLlRz+PAjdw/QkSnT2hdxCqB3avMON3+0/21+AyUtmoQN9kwFANHGe0KJSmcKVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyM0nV16EDBXuA7hV0tE/nHsrNwso1+hYUO4zftz5EE=;
 b=ZJ4TTyp609DuN2w9AlsQ+z1Mizp0IeoLnuqf94VLvT61VVCfYqgoxiHUAkIw4jEsmKPeKLEkTvvs/GbZlK7OnJBuMyhcODAPRd6CqKskvxIc3kOUM+/m5wvq9yG11+sdNEjaVLgcQLX51jBNIfQxFt7+iCAclZ9nW5W150Mvwj3C2ABUPveZUx/AQb6QaKjzLlgGUyFVCkfnTa64q7R8iXu7HoWNVIVhp6/80+F+EyyJQrp7smUwgno7Z5oE7tU6I3Spnpvdo5UAdQxQImgQDHk3Ax+NZ+FmEJ+33NjJjATJBUrVvJLTXC6eiL5Fb6tfKLBDOpHqJlKVBbrQ9nEIvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyM0nV16EDBXuA7hV0tE/nHsrNwso1+hYUO4zftz5EE=;
 b=Qjk46bmOEUlQzcytonj1F83fP+NOvr0rW0HZhIHeEhXl0paCkUeOKfamV7R3ugkMFVLPTwfo0f24TPtCCoxlzI7dke9K1guwJMXT+cDTL0nvtKeLMWLWoasnmS9le1XC2RysJTTo1SYRlEOIobi0z+NT17WW1zWKBpepi0pPhvbGM+N5Bfj9J7uYyI66Yx1sdzBXW/v1wZkw/3LbCpF0nE7hfMFPBEFD1XVEbb1uWhsHTg8RRsUzw9dG7evU6ISexHZAF2ya4/c+59qmA0PU0W1JIJnnhMy/HefFdbN5Fndjt4zamPp1qpEP7ZkE/obn7cbZUeCFXfqHh9MM8K8Qcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by KL1PR0601MB5448.apcprd06.prod.outlook.com (2603:1096:820:c5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 09:33:04 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 09:33:04 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	jassisinghbrar@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] mailbox: arm_mhuv3: Remove dev_err_probe() if error is -ENOMEM
Date: Thu, 21 Aug 2025 17:32:53 +0800
Message-Id: <20250821093253.559809-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0045.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::12) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|KL1PR0601MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bca1322-b8e4-421d-b950-08dde095baa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sQdOElQW976EWn7RdmDtXtLhfQa02CbO+uuTZzebY8iqh9d5mgw7f5wLNjei?=
 =?us-ascii?Q?mQy5QlGUTQiw5z9Sqi6Vwa8DEhghYR41y9a1BjZ6D+hkPqYiqPXXGNfy3QcM?=
 =?us-ascii?Q?F+5KbvzToeVVtZfCPP8xHwPh3NYG9CZGt+E/94T8ZG8ztra/3bodVTg11gig?=
 =?us-ascii?Q?Lmmyj2+bNDb65nDL4u+SHRVoXve3VBj10ydYStYmQGAelGa5zaswwgwrZc52?=
 =?us-ascii?Q?Kz1wq2hXvSEqsiBdx9bAXoPHQdzNUeJoGPcD8ZN7YaXIDHsOH4j5v03T5Pgy?=
 =?us-ascii?Q?3nlK/uu37Oa1H1SqSIcDHfZpcif+VIrbOh3LGTEeFGfBtsg/stRNe0ZccUzz?=
 =?us-ascii?Q?M39DxHn9RAmTr+qGDU+XldNcxf/tPe92gCOEpNz74skxQ2TkuyE1KjfPVPed?=
 =?us-ascii?Q?acnwo/W7zbBO+3oAJdHaQXK9KneZom/24SRR/HhH7YNqr3ze6Z5OWmht9kP1?=
 =?us-ascii?Q?/ZoOQjWalFxM5HtTmHI1DFJ9D7GufFvGEGfyWSm9ENiDGPUPwc4dXbUFXDOV?=
 =?us-ascii?Q?MdDmxXTwY3JKp1gVae2I4gHFSttoT5K/XrbyhJPMBEYSdLPZiFlKl9yLGdGm?=
 =?us-ascii?Q?l7H24akORXRjKNUbZ0T40PufezYTsGjCLiGTUDFh39aD+4waqY+ZUnBKpqPH?=
 =?us-ascii?Q?CE03KoCI1l7masGxgdVU3Kloir9DFfVZFkoyN9e9eAhhB1nojfL/GqwhW97p?=
 =?us-ascii?Q?PwlEalNvRPwasyRG/cVONZWnDxeKH7ZvIw275oDljvSLiHfATx685eVoSNdc?=
 =?us-ascii?Q?EFCquSLkFgmylvHOua2ISbi7Gfx+FT4X+XZOH9mtzMpVbed/hhSnS7lE1ky2?=
 =?us-ascii?Q?GHKf5olsd9Aw65UERlAVZBsSwOSKtKYO2BA/cgfncvjhIK6IfZYr0a5WIgAf?=
 =?us-ascii?Q?kbzkgauAutxl9lhVZEGCeJzxrF7JKcLXGQ9LPuDXZ9RLVpaK/4EGwFhOUFe3?=
 =?us-ascii?Q?+hGqRr9+Q0DqVqV5vLSfoNPmSubpf5VZll2Ie+vArZXXkCzeJob7IY442feq?=
 =?us-ascii?Q?RJDObrvrv6KZRsrzDt9enz54wPvj6Vfsfk7hISr80mAYRtCxoJ7exemterAR?=
 =?us-ascii?Q?1QKtu7kwSCaJChagj1gzqROpUH6jyDdw4+zabwuPgPx7DbFfNbWRsOioBHCD?=
 =?us-ascii?Q?a8xLDYpLzook6sSUxIihP8BDWoTVtY4FGP9DtDfrtyu1bnTgWSdZM9tNPsn2?=
 =?us-ascii?Q?E0VCJwfbbJ4ecvqjVinmC9pNlvfp9nYlnB/eJRi94oBxjwX0mizKQ50TWDlF?=
 =?us-ascii?Q?q4a/P6z2tmfQ3mgOAI63G8Vg1IHKYy/oXZhk61trddpbfdBD5xTTjTSQsOQU?=
 =?us-ascii?Q?4Z0YKEHmB1FPSug5J9NiHw7hcUksebolCvWfFOA3mr8uBXLJ9zz4vSNSaCtG?=
 =?us-ascii?Q?op7P5oyQkmCSABa/05utRNYsUdiYwG9WAVI32LHsJvGDp+zy7eBNOuNuNkqd?=
 =?us-ascii?Q?HHs7GlpYVG/NPdwfHU2yYgOJuDUrNKElQHlROEsuEdUs8WjlRhTbkdXM0Sp9?=
 =?us-ascii?Q?kgHi64Q5KF744/8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dcIVjk1O9D4HNjKsmrYnUffhFUvHUHgTNe29KhuFA4D8upqUghdJGyT1RoDo?=
 =?us-ascii?Q?ZIMncOjp9GF3aw1/TGpm0ehTVZ86mdyg79WvvGjmOVrlPJ6iEpQkoYN2PKG1?=
 =?us-ascii?Q?6wHVXw8GEVShXHJxrfAbGCQOV0Zf/IwJU2YJyHkz/RYay80B/XsScnDYq/d0?=
 =?us-ascii?Q?48GxQH1MOntSHT2zUYvm1yJDdmdCMY/KukMKFE08/0680FCZj5s7zNXvOY7i?=
 =?us-ascii?Q?3WcHVMrSNlo2QEGbU1YflzU1Rxggh62apwxlQ8rhI1D6oK4fQ09HysqQlT3L?=
 =?us-ascii?Q?RntJgTG9rkEQ99odEKw9TQOsdCZQIH9pU1uqUHJNNgzDI/zaDcmMEfXtxhxF?=
 =?us-ascii?Q?B8Vrd/jeXQLwTO3pQuYMsJpWjwyamkm5MOR6qifac+/Q351z3hTYBDEwEWci?=
 =?us-ascii?Q?Fb3x3g2qZtO9ADS1JRESqKm5+lHcgA/vWX2JjIzfqq/5DA37RhfbkpTihc+H?=
 =?us-ascii?Q?i9dUOUt1+TQA8+8zluwD6oU1WdTAfA6aSX8J5TOgxg250fkngIfu0+Pm91qx?=
 =?us-ascii?Q?XdJx2BgP7opDeHLVZHGY/pOiz6/W+L8vMp0iBm0NkzMj83QiALj9kOVQkEO3?=
 =?us-ascii?Q?Wpw9FUNUww0mPrQvR3+iCXeKW/8cGIurktXGzpUP5IdaAsQ8RTG4z26yixWQ?=
 =?us-ascii?Q?QhoEIfhQH2uTudnOrX1u7eLh2ZkXNV1ruhgWTR+25SO0Zmpy/XGn+6uprD0l?=
 =?us-ascii?Q?j4LGXiv+KRcfuoLhhEE5UNev2qjgB47HzrXFp5FRnu9d4OosTt9A7bII/G3r?=
 =?us-ascii?Q?j/BWQDx4YF1nOWSFHZXrw9RzbhPWcVj4UkIfLWSz+OLOKVSJm99eD+2vwqeb?=
 =?us-ascii?Q?jau0JyCc2Nm0tWDF7HYBg3pF0A1PVFwIXppnHz8a1D9eaEis6S2djUzfO35b?=
 =?us-ascii?Q?1YF5bpGGnslS8rQI1vHsTQxpv2trYba/n4hveIr0GWDT6LIZhOZrasRZPbDJ?=
 =?us-ascii?Q?w74VANA1E+dnXsszf1qx/C1iW2tZLSriddbgsxKdZMIgOyYPXmbis60m94VX?=
 =?us-ascii?Q?idjTmcIB0bXN9ibuodOX9YIOHXGttRRgiJ//WhbVXE2EgoPLPHHNywjp0tqF?=
 =?us-ascii?Q?QtYIJxPF6hcAJxSQaeIIKM6M0hoWVY3SHKrYDDSq9HjZmDaWLxP5gq0SS0hI?=
 =?us-ascii?Q?A9Rm0KG74dDgO37AoXBF3+ovNfI/IHiyQFbJNPJPnfGn2Hr21mzdzju0ZPHx?=
 =?us-ascii?Q?KaZGczPvlbakLoY63+a5y7jVssZqttDdamD4hPhts4Nbs6VW2XCU1AFCBqGj?=
 =?us-ascii?Q?tZz38PQ955n0DO63fn4KK5KFdu6m2mgEKmQqDYHwNH0yP8TE3DszuCd9FacA?=
 =?us-ascii?Q?UarlZVmmYBWmAOr15rpEi3HcUrZrs6RItgvT1QfhabernOejHq7rHVm0++UV?=
 =?us-ascii?Q?k4edxsUDthlx26xUZOfUH4LtfjNjfhKZL3Wrl6xIEeG6TKBZEiYmgrGOiLZt?=
 =?us-ascii?Q?Cp924fEVY0pjpT88TmhaBDMzP/hCJE9w3ruJj9B/p6htFm1tU7uY4P9hjW18?=
 =?us-ascii?Q?CV9LhwIOWaes9IaSFYGJS849Keg9Z9tSyj1a66XiqlXPeSsvN1P5XbgOyEJv?=
 =?us-ascii?Q?1kCVFYLqTnxwOgR4LFWVCcbZncMXXPaZeGRj96VT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bca1322-b8e4-421d-b950-08dde095baa5
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 09:33:04.5093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXdlzV34G6BN99DDlZv38CBfU+k70tiXyVZS5ZruEr6DS86UF/EFR1X+Ld3qS0TlgPFZ4LjaO9rmpLXNKLlsQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5448

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
Therefore, remove the useless call to dev_err_probe(), and just
return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/mailbox/arm_mhuv3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mailbox/arm_mhuv3.c b/drivers/mailbox/arm_mhuv3.c
index b97e79a5870f..cae1f9bea050 100644
--- a/drivers/mailbox/arm_mhuv3.c
+++ b/drivers/mailbox/arm_mhuv3.c
@@ -775,8 +775,7 @@ static int mhuv3_initialize_channels(struct device *dev, struct mhuv3 *mhu)
 	mbox->chans = devm_kcalloc(dev, mhu->num_chans,
 				   sizeof(*mbox->chans), GFP_KERNEL);
 	if (!mbox->chans)
-		return dev_err_probe(dev, -ENOMEM,
-				     "Failed to initialize channels\n");
+		return -ENOMEM;
 
 	for (i = 0; i < NUM_EXT && !ret; i++)
 		if (mhu->ext[i])
-- 
2.34.1


