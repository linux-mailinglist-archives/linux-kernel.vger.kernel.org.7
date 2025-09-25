Return-Path: <linux-kernel+bounces-833265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52270BA1906
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81DAD1888D2D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B87B324B35;
	Thu, 25 Sep 2025 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="f3xwXjrm"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013074.outbound.protection.outlook.com [52.103.46.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A827F321F46
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835995; cv=fail; b=n0XEJVP+QLHjYgRhFF2LGTtqu67hBkHU+GYlqiEWVI+o4nI9tDWJr2coXxY4Wlcjhmrj0eGqd3eq9psaC9sGwF5vZXdc6TKHzUysucsA0chSpn9hUNYrbh9dDP63lwONI+nXrY4699YlP91P/rzKY8GZusIA4ydEElmEZIGAPjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835995; c=relaxed/simple;
	bh=94AmoLLqEtVLwBEnCAt1Gwpf5zhW8RMcY7bw6THpL20=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=U6sJk1cQ6vgijeCp2U6a051MZCKYGqw4eqlEfEGhWu4in03c4+cdjNdkt463FVhPttGyI7KUuc5XU5seD/qkYfaKfEAHQh9k8hsxV3qrUdiE34lgJ/VLpNWarR0CXtfqfCjhXYRiFxci9wKaqfnskr7kPmTwOqjf4Lr1LEU1PCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=f3xwXjrm; arc=fail smtp.client-ip=52.103.46.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtwrjCOA0xNA51t5uxcs4nrbVTLdLvxYkf4KsX5LU6Revs7Jn/10wf1w2nZCC9zSzR5oY0vkDL8AXB2GoV2DT466s5lBoiuckgbZtkt+ZN9/YlfJF0ewSFhuG3E7wWPKZvLNtxbi3fscqYq7oqVjmQR/DyBj1iWR/3D5nVVs9nMspwK+RdI3UUvwoGFDrpoFxFtX3GvEH0KV2Hro46VMlwQtUrUjbIXgMKB1MzxmU2JzRyEVVkTxCHpcbDpNaya+kpScKO+jP5DVxywFcy9uRI7zrGPmjhEkIasz0EBf2ZYGuWxAbQBss9erPejP7gU5J5ER60ZH67TJ8/IlLIOH3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3PAX1KznwjEtHvGjnBtQewpjJ9mK49k4oVn7igL0Oc=;
 b=AoqH8LtOH5DrTK4o+wJgx9QZ9PIGQD6lw0XY5S+mcOpDn633u89nwKx4vRA0lBeafJihT0ckEy9ABPcKxT1AMgQhG9FRd7csQ5tx5i0T4ko1xN5u3YzBSJbpytJ2wgR4V2AMgv13hR7is1MC9hkmnWH6eIYmqQUVTC/0JOVDoFrIBVq78s49g73g6n13cJz7xdXLybFkETtoC9eu1zcbaIO4+VkVohjZZoaXq9jfm1eW3sW1KBu+vWC/fKAqYl/vmfojjJ11rdZCi/nFotaCHWlLoYjeVtK+HzItsRjux3sIStraXsBvQ3yjyWORpZhsBbWgC3Um0nL8F2BeubenFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3PAX1KznwjEtHvGjnBtQewpjJ9mK49k4oVn7igL0Oc=;
 b=f3xwXjrmHJWb5fyWX9orxQHUXNnQh+GUJZF0FXq3G3WgBYfMEI6BOeUCMkhC2q3UWt92H9zg17om/5DSgv3iDXIeVbGFhsnU+M6q6Oug3MsdjUNPIvZjOqU4Ak8IV+ipZplZp1ZHPBYuA6UkBv9uvZeJqChn8fyWmfsDtyxvQtcfZVXGZVTp4vDr7A9/1Xf8boxz75tzeeoGFLEHgaMtDfg+OatxbENv+iPw53n4Uh6wQAqsVyjrzITIlucI+Hy0Y9nHKkM4THDs8OdXrHa+M06OpAYWRnDNZsSNHgn+dxfBqqOyflZKStW/RFVyhVFsj527HcokKZoX0M+YQYukuA==
Received: from VI0P195MB2739.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:2c4::5)
 by PR3P195MB1069.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Thu, 25 Sep
 2025 21:33:10 +0000
Received: from VI0P195MB2739.EURP195.PROD.OUTLOOK.COM
 ([fe80::350:3f3c:7e09:a9cc]) by VI0P195MB2739.EURP195.PROD.OUTLOOK.COM
 ([fe80::350:3f3c:7e09:a9cc%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 21:33:10 +0000
Message-ID:
 <VI0P195MB27398E5490BDD76B2107D1C5ED1FA@VI0P195MB2739.EURP195.PROD.OUTLOOK.COM>
Date: Fri, 26 Sep 2025 00:32:47 +0300
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux@armlinux.org.uk
Cc: fj.haider@outlook.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, trivial@kernel.org
From: Franz-Josef Haider <fj.haider@outlook.com>
Subject: [PATCH] ARM: Add missing mmu flags entry to arm940 proc info.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0032.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::33) To VI0P195MB2739.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:2c4::5)
X-Microsoft-Original-Message-ID:
 <ed1f95bc-2a33-4d68-a552-c012dbd9388a@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P195MB2739:EE_|PR3P195MB1069:EE_
X-MS-Office365-Filtering-Correlation-Id: c35ba585-5293-48b4-1379-08ddfc7b1f96
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|6090799003|5062599005|15080799012|23021999003|21061999006|461199028|5072599009|440099028|40105399003|39105399003|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkJjcktXYU9iQXlwUmU1dkUvMGxqOGEzYTI3KzZQdWxleWZOWWh3eFZ3bjVO?=
 =?utf-8?B?V213U0VmUWpCUDUydmVaQ1BtMVVDL1RVb3hSa0V1S3Z2a1E5ZFZ2NWhQbENv?=
 =?utf-8?B?UmRnOExITWoxU3RQWHRpbFJBekpIUlA3VHg2STNZZmRQRnpzVG1iNU81Zy9t?=
 =?utf-8?B?L09XcC9Rd2Q5TUtjTkFabWFHMEVwdDUzWGh4c0VNMkRBSDhCdkppZDhBaDZp?=
 =?utf-8?B?c0EyTWp1VzRqWjRwdDdQWnZSM2c5eldJem9CZmlKQldTYU5IdnJkd1lqdmF4?=
 =?utf-8?B?RGV5UkttQVBCZHNsdmhzdDNOSVBVNjBLek9OVjRqTHZTcjBOY3pTVzc4TC9K?=
 =?utf-8?B?NzVyQll1NHhCQUhyK0d3YUJKT2w2WWNyUmg4a2hJd21kRHg3TVpaUUcvajFJ?=
 =?utf-8?B?MS9JRFliZGZBRjdpRGlFOGtsdW00OUNyemkwY2tZR1NyN2Z5cVpWNXpnR0ln?=
 =?utf-8?B?WkV6Mk9MSW9KeDM0V1Y3SWRtSlBUd0l4RlBhaTNLcllEdmtVYkJTK0w2bjF6?=
 =?utf-8?B?STRXODFJNjU3b1VSY2FBd0lOajRXSFMwREtRRFUzL214N0xCSWVuODhiczVB?=
 =?utf-8?B?elByeGFMazEvalFQWU02blRZdDhYYldMVWxrSkhQSWthMmZGQlJtUml5UlBz?=
 =?utf-8?B?ZlBlMzRQMThobGgvZ3J0aVdwQUo5STFOUkVGdGJUUWVWc0dPclJuVS9CVVhQ?=
 =?utf-8?B?MFdBNXpwc0YxeUVtL1NKRXVMMTYvU1dTS3hJalhXS0JSbklpSkhsZWtQQWps?=
 =?utf-8?B?WVIrUy9UVENtdnJTeU1aQ1FlVnRwTjJ1S2VZQXlwQmFjbjFhU3laUTNSQ1hv?=
 =?utf-8?B?TEJNZVNSQlB0N2o0UENmQ0FsYlM5UnVvV2hUd3YxWnRiczZvbzhjN3V2b2ZI?=
 =?utf-8?B?c0UweDQ2SzJzcWRsUmNwNlBFbEJVTnA3eWg3cGYzQmV0am1rTzJWMVRJY1VZ?=
 =?utf-8?B?VldGbEJTK25oaDVGczI4bFN6MjZHTkhvalJPRk0wUkU5K0lydmNyYmJkRWV1?=
 =?utf-8?B?ai95QjJ1VEtaNUMycVMvM0daSVk2UnRaaERNT2V3bk5SbVRvczdyeWo4Ry9i?=
 =?utf-8?B?NGNySlZIbUtEcEtsMzFpMHVjSXh6WUpEMHUwaXZ3bTEzQ3Q4czVXS3JPQitu?=
 =?utf-8?B?anowaThzV0tMdStXdHVRSXhGVkYyNXhJY3N0ay81QlgvTkxyQ0EwenN5MmFV?=
 =?utf-8?B?TTNpemFzQzYyUGxkN1ZOMWZ3Y3hNN3dwM0drSE0rL1NUY0MvSFQ3Qm1POFBj?=
 =?utf-8?B?Q1NpbmZyMXZ6QzJxNW9zWEQwL2JJYXBnQWpkaW93NDB3WkpXVU9JYzhSMVQ3?=
 =?utf-8?B?ZUdhdjRvU3BBejdlUHVPajdrUWovTmNOU04zZ0R3Yjk3d3VsOTFWelROZFdN?=
 =?utf-8?B?clJsMDc4SUlmYWYyWmpGTHFEck5DMmV5VHhialJWNkVNQnhVQmNIS2VnQzQr?=
 =?utf-8?B?V1RJcHl4RFU4YjlrOWxOSXRiNDNDUW41NjhLSm0xTnYxcTJNWVB5ZHN1dHdl?=
 =?utf-8?B?YmJnc05PRXF2RWdxSHBlbDFxTWZHRno2TDRCV25DcGZpWHlmQWRIczJ4dXBF?=
 =?utf-8?B?MEI1bitBQmwzanZjQW5KN0FnNWNGZWpmTW1rUzk4RFd1RkJSVlF5Q0s4NEg1?=
 =?utf-8?B?YWlvMWRjcDFDU1ZQUUg5RjA0TnlqNDBIaytMZ1IxTEVjTE9qSWdmemphdDln?=
 =?utf-8?B?aEZzWFZCYVFQcjZMSjNpK2VCbXJZdlhwQ1lOeFJhUWhmM2V2Yk1VVzNjVGdz?=
 =?utf-8?Q?iA77rIb6FgpVFZpFhQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFhNTWFzbWdnREM4ckFWTXZoNHZ6WXhQdFhEaytXSzRTOWF3ZllsbFFXQmFn?=
 =?utf-8?B?eU1iR25Rb0NjSDNpYzJxZDFpZTlaRlpjU1duSU5mRHRlZGlzVFBPcXRFajJC?=
 =?utf-8?B?VXZqWHU5OTFlczNla3gvdFVvZ09QN3RkYU9uMjBHZVB6a2N3S0wvOGl6aUlO?=
 =?utf-8?B?aFdQZC8zREtzV2c3ejdlMVJSNSs1RnBwUEVYWEcybENxbmlzQmVwcmROSVhB?=
 =?utf-8?B?QlR4b3lyVEdIdkxpR3cyc3FXZHp0dTdDcmNiZGludjdjMXIyVDNKb1BHYzg2?=
 =?utf-8?B?UlNGMldJeXRYVTFBRnBvUUwzOWdQbXlZUk54N0ZmYXpISmh2czlrZVMza2dl?=
 =?utf-8?B?SVlsRkJHT2MxYjJibUllcjNNazRPekU1T3dldVgvS0dBZWJId3d1RmxDM2I4?=
 =?utf-8?B?WFgrd3hKbitlTDVqVDFyZlRIaGNNSm1WZFBlZ25yUXZlaEFmVDE4VUJMbE41?=
 =?utf-8?B?MEFtNVhsQ1V4TUVyNW56Zk5rZnZDdS9uQmZvZUlYUkUrcXVaaFllY1RweVNN?=
 =?utf-8?B?TVordUxoWVYzZUNyYUVMUGZicHVUSWRCeHQwdy9ZdzVEN3prM3JjeDJibHVX?=
 =?utf-8?B?ckpYZDhheXRMNWRwZUx2Ym50djhqSkZ0TEkzalIyVE1IY1RIOE1ZSWlxcXV6?=
 =?utf-8?B?b3NpQ3Q1Y1NEUzFId2w1MzM4WGkzTjlNT2tNdERvVk1GbUpVVW9KMzJMUFZj?=
 =?utf-8?B?ZXZPMTUreDk5NGlGUXRuZXR0NlNyR0gvVW1ONTZiVDBTektxTFppcmN6Tnhj?=
 =?utf-8?B?ak5hbWtWdGIzR1NNelQyREZySjlLQTNKSzc1MHovOFpYYTgvQTdNOURsVjlw?=
 =?utf-8?B?ODBseTZGdEhiZUZ3Z0tpSU0zSU15a2ZER0hjam9RcHdncGN0anZWSGx3eFZo?=
 =?utf-8?B?UE13ZG5vWGMyR0gyYmZUcWtMVEtUNWZ3bWhvb1VEK2l1Vmthald3K1pZckFS?=
 =?utf-8?B?NitnZXlaeVhPUFFsd1lTQ1duVkVybDVjNXdZRXRzWFNOYUhlZ2VIMEN4VW80?=
 =?utf-8?B?VTNWSHZkTkZMcCtuQk1SUHhkbmhOd010L09KWElGdy9wV0R1VGpyLzRUSU42?=
 =?utf-8?B?dVlVMUVzeDE1cFdtRVRPQzZlUXhBbnpSNXhKRkxXZEN4cG13MmxBUDFDY3lB?=
 =?utf-8?B?bHhZVEdkRXhqVCt4WDVqd1U1ZW02REJWWHBIWGZxMmdMVWpES0FjaGpLOTdF?=
 =?utf-8?B?ZzdMOThRU3dCTjV0bU5mdkxib2JVZ2ZaOUtYenAxcUhNNHFOYWpkSlFDUVJX?=
 =?utf-8?B?R2dUNnhsQzhxVEx4em40L1lpWlp0N3oxdU80Umg5ZEwrSk9hQ3VGaTI0QUla?=
 =?utf-8?B?aFlEQWJqUXlMUFM2eGdNUHFCRmQ4MzYyZlFzOGRJYWJCdDF6bkRrMEZaTE1h?=
 =?utf-8?B?WGhvMVd3ZUFGVG0vakhpOVdrR0tzN0xMNkNnb1doWGlTOXV3Q0Z3WE82VmdW?=
 =?utf-8?B?d1M0SzZGYzFKelpsd1Y0UWxtaW9qVTNXQlNYMlVIbDE4cTlJb3FUQ1JUaDJU?=
 =?utf-8?B?TE15c3h1eVp5L0lEQ0swb28zZUQ2N2lWNG1xQXJqTkhmYkd4ZWZySUs1Y0pE?=
 =?utf-8?B?SVBGb3l4WHozV2tMTFFoV0NmUzVhTTFOTnIvWmFyaFV6YjhPcHZmNTMxbEx6?=
 =?utf-8?Q?Z1a4uNb6URJfB/PmujfWk8+6v7HLxq/tKsfBL3pKc7Us=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c35ba585-5293-48b4-1379-08ddfc7b1f96
X-MS-Exchange-CrossTenant-AuthSource: VI0P195MB2739.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 21:33:10.0155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB1069

From 6543180935c8308b044c7166cc028caa23d4807b Mon Sep 17 00:00:00 2001
From: Franz-Josef Haider <fj.haider@outlook.com>
Date: Thu, 25 Sep 2025 22:12:06 +0300
Subject: [PATCH] ARM: Add missing mmu flags entry to arm940 proc info.

The proc infos for other cpus do have this entry.
Fixes a fatal crash early during boot.

Fixes: 8799ee9f49f6 ("[ARM] Set bit 4 on section mappings correctly depending on CPU")
Signed-off-by: Franz-Josef Haider <fj.haider@outlook.com>
---
 arch/arm/mm/proc-arm940.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/proc-arm940.S b/arch/arm/mm/proc-arm940.S
index 0d30bb25c42b..79f39707fbf3 100644
--- a/arch/arm/mm/proc-arm940.S
+++ b/arch/arm/mm/proc-arm940.S
@@ -356,6 +356,7 @@ __arm940_proc_info:
 	.long	0x41009400
 	.long	0xff00fff0
 	.long	0
+	.long	0
 	initfn	__arm940_setup, __arm940_proc_info
 	.long	cpu_arch_name
 	.long	cpu_elf_name
-- 
2.51.0

