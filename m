Return-Path: <linux-kernel+bounces-849062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A94DBCF221
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 10:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B0C42662C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1616A238C3B;
	Sat, 11 Oct 2025 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="VeEFfFqS"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013035.outbound.protection.outlook.com [52.101.127.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC4C22A4D5
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760171003; cv=fail; b=Ywgsl2I334TvIr7PJZ/DFHjdAGVqFh3LKqO5PX7fTKYra1C109dV9D+oRXqIwEqUWkSh/JEbafpYHKUwJV5V3FTo6nFWBFn6vfCDLUqN0x/na+vCaY9OQOUd4Ew3p9/bsfIWIvIz8wBsnWb+diLj3UYE2I5xCLH6Ojodc2BSVpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760171003; c=relaxed/simple;
	bh=jVjzEumb9JKsrdq6yPqk/jp9VHMdhNEtc16ohRIrgTY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RdaLH3S2RY5QIH2OJDMFm56HOEIidsD1Q6tY3dlUK+plp5OOaNQ6Gpp5vKJHJ48gsqqrB5uh5J9HI3Ix47INupsZox5b2rLNKuM5qeo5nqib15U85gRZN+CDcLyApEiL3sIF60BgI+vpOPI5Ca+58nELZmFPYGy2Gzx410yu7WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=VeEFfFqS; arc=fail smtp.client-ip=52.101.127.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGPSHsKnce426enGwIIX4UKQEJ9MZByKWBikS+B3MUyAQ421xX9wxFcP/38vTgPNfb2w6qvXM1GAtT1rtfWk1N9F88oxaInEZAOfgk7h0clStXEm9k2Fd+xd0AEn7n/ILi3Dcrol+TKV4zNbQE+9Hk8Sc99uP8PSRuDCHJS+0TnY/NTv6ERnKjcNra+OvJ7Cy6KxxfymNUQoQksZGtyjoIeTUjgo2Qi+MtmHEN9sl5pcfpxSJh/oPIUZxTIXW2duzjLopzfpXLgvh0F4TQ67uiugcQj1YeK0zq0aPz8R8ILxikbl6iEASgOtppmTj8FFnzzpkqO0WTtf9KMMGp7qtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIdHyUkoD+eBZCtpnn6mPUBSHw8qSetJGe0NcgbXd0Q=;
 b=RdJ8Ry+5cRVmYcLiAQh1nYehE/RAoDlvxVzoedPhweQMCsbKtAsz7stux4P0Raakkzha1MIP5vcMiOjXozLwHhzdL3TZWsKff6E3yR5yFioM6grTYKRFg4gt9smdniiT2y/yw8BWHS4s6kqqa1WBYnrFfqeeH7Pduby10Txorr1cTMins05JOHtK9F1gvVJg4EfGuHSM+oSgIAnrMw8lKf1HmmifKFlO4zcXUJMJn2AES2HV1fqH655QATfzPsokX0p8Ju9G6ucjlsqX9Dbu8Xcw8XWlS2mvVc0NTwrsGEypDEIvo52+DvwVNXnnSjSCJTR888AcBvJBhfnb9/iUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIdHyUkoD+eBZCtpnn6mPUBSHw8qSetJGe0NcgbXd0Q=;
 b=VeEFfFqSuLSpziyEFU2fSeAiOV6g6juxwjn8b5Wb8bnvtBwEWbjhXag/0b4qLP2iMeBnma3mnqWbvD6NbdFeOB5t/0tbhpNLB0Dm9JELnH7VtESakP93S42NJADsL4DTQXTxY0NnigCBDOM5EzJkhh7AkwrjmLTaVe80dENpEivZLsHLF6DejhdemkWlZ8BUf/ic9vmtyc21qBBdud0x7N3H/oouNDOI1rYdI2679gIg46BVFDWTjOLD9NouzUsFBsOR+U98QsVEuidKF9IZUhrOyHQuK7uanTBC1LqELNpxqp+TiY054+dc9kriQKFt31LLGdZKd4Gi8za+q7wBvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5538.apcprd06.prod.outlook.com (2603:1096:301:ec::8)
 by TYQPR06MB8262.apcprd06.prod.outlook.com (2603:1096:405:375::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 08:23:13 +0000
Received: from PUZPR06MB5538.apcprd06.prod.outlook.com
 ([fe80::ad8c:f38:8633:708a]) by PUZPR06MB5538.apcprd06.prod.outlook.com
 ([fe80::ad8c:f38:8633:708a%6]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 08:23:13 +0000
From: Zhichi Lin <zhichi.lin@vivo.com>
To: elver@google.com,
	akpm@linux-foundation.org,
	will@kernel.org,
	andreyknvl@gmail.com,
	samitolvanen@google.com,
	yee.lee@mediatek.com,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org
Cc: xiejiyuan@vivo.com,
	zhichi.lin@vivo.com
Subject: [PATCH] scs: Fix a wrong parameter in __scs_magic
Date: Sat, 11 Oct 2025 16:22:22 +0800
Message-Id: <20251011082222.12965-1-zhichi.lin@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To PUZPR06MB5538.apcprd06.prod.outlook.com (2603:1096:301:ec::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5538:EE_|TYQPR06MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b134f70-8716-4575-193d-08de089f6b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gWgKwoN9eWSe5Lx8zEPIFYRlb0pQJinMmfxmjb9SKkJMCTM7GisvbiQrY2Qz?=
 =?us-ascii?Q?cwJoy0uVzKNOOlTKLfjp1fV/lblJCZzJFWjUH8ITyhGd7LjsOyRRb/ngYGQe?=
 =?us-ascii?Q?m+08a0ZflsQ/C5PfUNrf51JPZaKM14tN0Is1wciGVIQm67vKMlNihNn8g+tO?=
 =?us-ascii?Q?5MGeJuG06mu6XpPzaSxItl2kyYk6tYBhSefzwS61k5w+T8cRP15moSRy1NRD?=
 =?us-ascii?Q?BzclX46o2JIZf/pZhYEv0WiH2NH36P6iAAGh0MXcqj2SNmMKbkM1XXq1nqhu?=
 =?us-ascii?Q?VmMZRBxjqkopWG5Y0XLuaaFMXhUMHk5qShemC4lzSy9rcTTetfrmZLdh/6xn?=
 =?us-ascii?Q?tFKrwW0+WM2YbtmDljD1UIge57ysY4V2S74CaHQzuC0iVcoSR3TVTLk7H6OH?=
 =?us-ascii?Q?rTks0IMzRwojjohFFx/ptSbeOcQCASF8LIAhkFNGjFZ20JrtSJ3FakgKHS7k?=
 =?us-ascii?Q?K1ufdw7NSle+4ri+yczN1dXw/c/Hmhw+T0eOfLalVwJoMRu5JEULQ9xgutsp?=
 =?us-ascii?Q?/f0eL0RielavZS518EiBr6UceFhlroArO+7mkorbAqg59zwT5LVFzEqadCbW?=
 =?us-ascii?Q?mv9bPxRfxd8tcPhfWZPxTuXdUEth567yHXQg+Ga/CI4KFjLiLiAfa29EB5/s?=
 =?us-ascii?Q?7NTIybHnYggq3o0VqfDxPpnkrf53gQt+W6eE3OFKnWuTLZAtbIcEy/e5V4wr?=
 =?us-ascii?Q?LMfTcl5YZVCtCdJjNX7AQ2Png9xkDgzs+tHGkwWMsiv/kkgDIZ3dr28yTRwx?=
 =?us-ascii?Q?jxEls/0j9am5pxyzbNrvh8ReaiekNzxB57NodUCiWQJAzy7VK4qGP4u9uXNN?=
 =?us-ascii?Q?0EFq55sfVezG/fANFCgyfToX4cmH9Inki1vHROM2GWvoe5O3XJT0A6sKQ3Fs?=
 =?us-ascii?Q?ToYeQYy79WtttOZeT9tcXRNj/psgtlZoyfKDBJORLlk4ONtwXqMr/0+DO3EZ?=
 =?us-ascii?Q?WUXzDt6NrUStvQoGjrPXD3f8TohkAMAb8Sof+uToJ7wTYZBSgFnEr2b0y4zM?=
 =?us-ascii?Q?1zKdv6vKhKoVXHtaPUM8TYuUbxvimpF6Ht60Qn7DjeQ9G5lKlEkQyN/qOA4Z?=
 =?us-ascii?Q?qpcP/xlpv9BdwgB07HXTIJpCd+izIhZySo7AD/MrlgcAItcKlKRdxas2GUn7?=
 =?us-ascii?Q?zAbAr5Jxl0iViTYWlUrCG2A7SYk1WnnR3+TZeHGsAdVAU4FAvgCHLAgwgvk8?=
 =?us-ascii?Q?vT4/+AYIkgr7WeU8E1wy4Mduwp/kJPYyZH5rUJYFfHab9EDKL/3jZE58rqwB?=
 =?us-ascii?Q?MYTDRNwkL5qCX55DEoNwLyMvwBhvbxWQIEwDYfAYFUBmP6kTSferYK3fIH53?=
 =?us-ascii?Q?TaiZy+kRMZ8QCuCR0xr1gGrVhKUGXuSpDWZCXgwAHhrXWVdYfhPKnKLfaSln?=
 =?us-ascii?Q?ahPwrVeB1RM20gpQ8dOJWEsXUzQI10aG2E5NAAeBBtRm+3jyEEwP5xVguof3?=
 =?us-ascii?Q?Mid969JoAgEW6rXNAqA+5lFs4NWZBOzLsfgQSgw0ggJF2rQByKFYwmwgkwcp?=
 =?us-ascii?Q?LWQ0y4WHDoBJ9wjqcThxO643hkrOPByTO8+V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5538.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1c7DMo4i4SY+R3wVbRiCArsUWpgNfS0T23l4xyQWCrrDKGehiePAoZLlvlLA?=
 =?us-ascii?Q?Ur761SSjojtUTF8NwDv4bJo2fenZoMl3+IMhiiOK9ZDq1RzywUWbNu93wpm8?=
 =?us-ascii?Q?wQ/B6DUZo4TK1a551JipaiP57A0PXFh+8sSykHhhpqZSjj6MyDXMd6hev1aY?=
 =?us-ascii?Q?BPFh1UAOt2wToCQYq5NSThzW6jHsCv357eryLisbsnPnuZ4zWYJNCnrm1N6J?=
 =?us-ascii?Q?GCeLSroA42uqt5a4q/7sx0wP+b00i8n2wTtQqCrCKnEZHHjcJ/Rm1EF1aoG7?=
 =?us-ascii?Q?ft2UREwFfeB+oqG74sDN/VJKWWzKRUjX6Y+ZVx/RJb3YEszP9CRNQGlc++N4?=
 =?us-ascii?Q?IyV1sFv0d1cYpm6hV5EjYKtp7MtlTdfoL7HuDJR1GVCC3qC7mytEGtmt+tII?=
 =?us-ascii?Q?dw2JIDq7ntoGJWJ4wNX9wtr5bncP9mP5ROJYlWPrnws/SVhzyABuVczZJClU?=
 =?us-ascii?Q?kGH+hUjI34IkmTPP/tBYpXaj0VNIu03zv+2HXULTisGPrUOuWfwxPzbL7HH1?=
 =?us-ascii?Q?b8R+iGsPBk5ZLwIgbsJtEsB5aDCNXVdEwmjuKiKcSlq4f+mCP5ytyIT3NoeZ?=
 =?us-ascii?Q?yBucuulAAJXQibEwHSis3hlkrsmJCYjTkFREDnkSJOO1O3XiORKkqcO+U07D?=
 =?us-ascii?Q?rhcx7ilJ+xOXbK+XTtlYN7vI/wCAq2yuuHnND3Ufo/xEJ3pvIkCEI2kjoOu0?=
 =?us-ascii?Q?Ys1N+T51IWHOsmVWSHksgcIYDL2zdarYv5VnZEHsXdx3sPGsRvQ+ZTgwDjio?=
 =?us-ascii?Q?e52AinSoC2HWCzEoLuVi4HF++snOWjPH5rYfv2jl6vyFNfgnTP57bFqRBcRj?=
 =?us-ascii?Q?g/aM5sAzgPXwXC/C/K1hjmFOBhuZYToJjOegQuRmom8IO8d1qrh5AIYE4Zom?=
 =?us-ascii?Q?WB+PjbJ8idGiihFjZbtN/VwzlTGK8LOXQhiZqRyKEDqME3iMo5byXNkg4Sem?=
 =?us-ascii?Q?yly6huPzIy9ztwUt2SHx4xbxcmAz3WsmRrFrr10R+L3Y7dkx3oFr1W0KIPBe?=
 =?us-ascii?Q?zwTPe2Y7HlKdta3X0kOA23hpFLGQvVTGkuARBfammmOATuFZmPGdpPoTSamf?=
 =?us-ascii?Q?RfMZ9X8o3KluqZnvoJ6NqgxI2KC73OLgNqniADNUUwkXPZdBzzBEe6WQQO14?=
 =?us-ascii?Q?vkkgs7DLu+wcPNlilDwf5PcTe3nGzEy+A/sqZvUc2NR+sfiJhSLubgyHpcyo?=
 =?us-ascii?Q?PaY5iSnBEwTqnxWLzhvV4MW2h3IZua5EzvStbA4wEfmtCvG94PS9bVEiNX75?=
 =?us-ascii?Q?Xpu/OgiTgOU6v9KWLMSsuh8waxqHObQTdGOsS+uJAq5RjE2cQe62+RmO5bdi?=
 =?us-ascii?Q?rrfmYHPvzjecCRbl0bdKBOlP/XrGUyaQCfc2iBmq9yB0DfX57gOlS6H9JsTt?=
 =?us-ascii?Q?jWB3OY+0IGEekzpcUeywPFK6aIxlhOTHsn+rAPcMPU4Y2se2al0pzp1ptjrC?=
 =?us-ascii?Q?8CDZZJ1o7SLdyn/OvYqVAQySl3lj7sbTogCC7OWDkR0T5f77tswzJov0JlD7?=
 =?us-ascii?Q?40GFLGwNXKo7aaH5tix8NR7iiEHvv1kg7OM10y9fnFhcy2KZq+joWB03bJGd?=
 =?us-ascii?Q?e8xHyVd/Egawun5YKbXHjsOr3HEcKfVHn4w8rVfU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b134f70-8716-4575-193d-08de089f6b48
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5538.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 08:23:12.8771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sV7nLoBKVSENUf6elCNJ9eWSA1bRVgkN4WcPw5/h9/yZ4+DPnBZkTo5RNQgcLQYvdU0Xm1aq2FFH2LYtQ3SJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8262

__scs_magic() needs a 'void *' variable, but a 'struct task_struct *'
is given. 'task_scs(tsk)' is the starting address of the task's shadow
call stack, and '__scs_magic(task_scs(tsk))' is the end address of the
task's shadow call stack.
Here should be '__scs_magic(task_scs(tsk))'.

Fixes: 5bbaf9d1fcb9 ("scs: Add support for stack usage debugging")
Signed-off-by: Jiyuan Xie <xiejiyuan@vivo.com>
Signed-off-by: Zhichi Lin <zhichi.lin@vivo.com>
---
 kernel/scs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/scs.c b/kernel/scs.c
index d7809affe..772488afd 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -135,7 +135,7 @@ static void scs_check_usage(struct task_struct *tsk)
 	if (!IS_ENABLED(CONFIG_DEBUG_STACK_USAGE))
 		return;
 
-	for (p = task_scs(tsk); p < __scs_magic(tsk); ++p) {
+	for (p = task_scs(tsk); p < __scs_magic(task_scs(tsk)); ++p) {
 		if (!READ_ONCE_NOCHECK(*p))
 			break;
 		used += sizeof(*p);
-- 
2.25.1


