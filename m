Return-Path: <linux-kernel+bounces-769052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC69B26970
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B478A06D43
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA310321448;
	Thu, 14 Aug 2025 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Rr20xIeK"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013005.outbound.protection.outlook.com [52.101.127.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F05321444
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181402; cv=fail; b=PrAeiDI6coQHwP7uGt5NFVDJST6GtaO/P3GIsyhGu/FoXMi4/HdAn3Y11CVL3LJoYv9w6LRytFVkeCSgthUGR0GoCxbtp1oCa/P07/5KqSseNyZ+i8R2A/hwFFfRGeoqIxdhrOY5qytnFIfD7LnZfRQIMqSqMkesyhT+OdOBwIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181402; c=relaxed/simple;
	bh=3l8Sj2y0bs6WmGsz1zhh6FiOSyRRBZj6NpvrGs01heI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=V+efuyCk5dovgPLn0312WSeERVpbFSRmwfhhMbcMqXC5EaiG0oARd7UeA4fxt330VrCB6hgS8OawcP2YyxQBSHvr2RgZuYGvN77Gqj9UGUyG03ZAIiAjYTSVWABoUASI5kmXzQrlIMobuOMRv//dBbw+dhqGIDU/rUWXJb9Mx98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Rr20xIeK; arc=fail smtp.client-ip=52.101.127.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMAvQmzPbd8nmMQVb72WfOmqAXLole2lX0ViAVa7t+/2RE1Nz9u1hNjlrrkV9OV3fSg2RVgcyflxRkKPdFA2Fb9jWxsK2nBVwQPzSKMeeQbZMBY1OG4njAKK1RjaS+WRqgWSlKXghjoGJCCQ92SMOYkDH5Bn1YkDi4HEvYzGfWbYaTs/oDDLApuGIszypHkFDbqkzVvVmLm80RfJIvSu3rLCte1iw6e33OazI0r8WxGzLPdtGDoO50DhDX5UDTIuveHtidZeHUjfgvLPQSOWUADV9iNjdVck/p5HUCuty2xu1VGZP9LfstBqYbrAiBrkxI6gL0Q4CxCW6IU61R1b3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvchi29qQ41vDz3iax9R4Qu16keGEIHbQ7PV668WFcg=;
 b=iRjkEs1QV4AXiT4voxgiLA2A3Bv+v92Yn2ZxTmoNNTV5m4Jwgo3NboFm6w/LLxz7B1BI2puF5Brh0cZ/XvEqZ1GIv/yZF48qEQ3tR6Mg5sVXnkNvNzMs8/pYiWFndABNx2eBoAkMEXY2yEBtMUk6GC77duRE8itjVPRH29ffqbQH1ee3hoyhr6M+9eww2ZoVEg/mTSGz76aRKjniGnmulCHWPbGHr8zROPvi2ngEdRCUoZEQ6FRXHujwuqIiwciNvp2VEoFsqNn1XebDzEOuG/LfpcBaMQ03l+3ol9cfiS/EdTdUJ3e/6SkgrfHlhMMXzo6XTZ+UYudUwG+/8NBjyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvchi29qQ41vDz3iax9R4Qu16keGEIHbQ7PV668WFcg=;
 b=Rr20xIeK5NdNdNmsBrYB+LgaCu/SSXYNkCXNa+ZzIzmAAFEKHd5P6tfn6iwj55A5SY7Scr7Wq71Bo7hvnLzC5jJ4TXDvEr3Vp2ksf3E6wzgS8NYuUuruOTvTGlk6xBlbb+bibE1jqzNnwoDIaFYYEibo8Rjf8SpcbAw8Tx5j/zkVDillNiUMH0fQUjAmdnh4JVNc1lvtVkQ6s4uvqWeyv59vXRZoMsFZQdKIFgr3qwE7xMI25HMMWZ43EKkmc/pDSCMgoVEqpzbTXB7RHxZCjjwU0mvnFXVRFOQ8lYWskvUj7mFSDtBoSM4gbvtkkhHXoyQ4p9d3N78LS/Zwhgv8Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB5907.apcprd06.prod.outlook.com (2603:1096:400:339::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 14:23:15 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 14:23:15 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] gfs2: Use min_t() to improve code
Date: Thu, 14 Aug 2025 22:23:05 +0800
Message-Id: <20250814142306.282211-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::23)
 To SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6e3aed-f3a6-4487-79f1-08dddb3e1b69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6XEwdtosvasj2hpHd5SYN36aIAzsGIrExR9TQI/tXFKetAnkqKDuyUHBDzWb?=
 =?us-ascii?Q?WKOJdQcri/njk2KuM6kN7V0NEuaXPqLEl5N4MHnmeLxLBA611TI+Dp1flTWz?=
 =?us-ascii?Q?w6JuZfGhifKHwnK8YmUNsEq3Vq0qG6Zf10MqFPWS9IMOtN1lAxfgedw04Yiv?=
 =?us-ascii?Q?d1sSoobZOtjuLSMjGjzA30r8wgSxwpsGiekBcbrazHocPzMRJhXi0O4d86Q8?=
 =?us-ascii?Q?5lBK4GsQzRcbKeFl5Vo6LrWA5CgaUtarYU5iBmkcAYdNPV15aqDi1TqZ7bZX?=
 =?us-ascii?Q?vv7M+YJyxGjS3qRTne+B/j4L51/cZXIc1zdvFMJYNzCT/tFpxSVXElpkkjyI?=
 =?us-ascii?Q?qwg48HZ2TIexZ2EL3/QNk3HLTYvzzfTjTHDVSTz2yCJWWxjupFRG7ISB3ezb?=
 =?us-ascii?Q?8i03B7gtsIXXqGLVJe3NtaDeLu3bbb16bMpy2noYi/jwDwqkVXG5MKeJfbz3?=
 =?us-ascii?Q?NLWislecyBrF+dPuCBZWXzSNeKHGXvIxCPlpS/2ybnRVcyMzKM+/Jqt1yNko?=
 =?us-ascii?Q?07udoZKYLzY3s44aRhU31fczKCLPNeK+ITJ6ZaNBhnY5WAzjmuiaSj3pLJrk?=
 =?us-ascii?Q?ZXNpNLLPqEWVXA6B+MV2tU/y/6lWcXQDEk7YOjHo/DX+wD52V736S1HWgG3T?=
 =?us-ascii?Q?lIBmpe9UDOzslZp4+3aLl/+NRs9Rx/oQoa8OE47vSu/t8gWeGObemQxXjCkK?=
 =?us-ascii?Q?YUMcqYTL9QViFo/ksLFPit650NJjxuMR9UCuUbvD494pKeYv4rD/7DvP6trT?=
 =?us-ascii?Q?LgfdJ1k4rhJZn8TMr9dJtemodzP/UrqPfpOU4tiBmia/008X0Pf0L3/fVeCv?=
 =?us-ascii?Q?3dx1rlsuTb3S9O3uJb8jG+Ig+ILjgJUDe7vLKWMVi/VUURvCI7zAR3qIcdxf?=
 =?us-ascii?Q?J91ts261SW2XQFzdnT0wlNbv3wxWNjP/pjupKAMAWQIy0JHW26TH7tCS+Y59?=
 =?us-ascii?Q?ZRC3GqfkQsJPoNEPHghYFGeGXUpCl3OygfC8eaZmUxZ1O52iVTPRyaTe92PL?=
 =?us-ascii?Q?90NLcRSkWpJwvIW7WFH1nLCCWTj+J6DZ8F+K/FYnmsF+lkVVW+b3A7M+jtqk?=
 =?us-ascii?Q?1ULRi3DZeTOah3FBgMZ/FLeAxd0snF7mznCOtAjy0sGSy7AXgKe+MoTF5JX1?=
 =?us-ascii?Q?LlkyI+rAQsIZ3cg0U+U33bQx3xkZmicDmG1hnd9dare3FEAqLDbERmu7f1Xi?=
 =?us-ascii?Q?LtyO1OqNOjB325piep/tEYPb9uHy+BtbTvUlCOomxpGsQOgNOsK28lbW1tfx?=
 =?us-ascii?Q?APvVEkEWrIXry3NchLMAS2lAg7pC//8aMjymCQ0/IK4BAanEkSZHNU9FzepU?=
 =?us-ascii?Q?xHdISPt6/u56ty7vEX68+noa5io9uyx0HBg6DeDDLkp4KppIUkVdN1VQWsMY?=
 =?us-ascii?Q?8q5bD4WFJtRCmxV91f/aUYD8l67cGP2zqeikF8vTM5KeKjabwEpZEtB7zQRj?=
 =?us-ascii?Q?r1vorsO6eb/mjIzHg2nP4amhSPRksOhzhv+TrOsE8+BNTCmQVScoIyeyIzMI?=
 =?us-ascii?Q?n/HftAVrugAZj7Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7hVDicu3HIg1PKtWKp5r6leYqwmmrP1BGNenE7M5wMAE/G4pN/1v4pBOl+oo?=
 =?us-ascii?Q?Y6B4OrC8URuLH+HYMwIHdJAWcXAo4j2vkqq37nFu6+NiN4BT1a7QWgHPAvsG?=
 =?us-ascii?Q?j6Xd7LsZBy7j69jHL72rHq8+MAxEk3AZo+Pfjth8q6o7XkBUNIzCEiRNAB8K?=
 =?us-ascii?Q?4YZmfmI+EE25Rsp43kuChH/xP5i0lsETosZQ73zTwLBbGkfSbWTILbovffKw?=
 =?us-ascii?Q?Esq5g4zsiHWY0dOTsw6e0ZUyZ8IMBTTFq33ilBPCjg3YO0e/hx0zhYt/52B6?=
 =?us-ascii?Q?qza81EsD5j1/VIbyNfy69sQgg4S6JoDvD0tDy/QINz8btgXrIJhZ05usJrV7?=
 =?us-ascii?Q?OgfEp1EEp/m1n2oCfO9Eah+q8XnIl/6CMH5qblEuynwNm+hXrhnGoeNifFlQ?=
 =?us-ascii?Q?ZwLgNSJ0mlBAehgfXS3KkPsmglssbVghhKY9NqsfOLXOA4rPj58j8JD/5PcC?=
 =?us-ascii?Q?Ym9XmKLDbmzaU+cJB9UhLuLbkGsfNN0XFwKioFbKNw4uglU6ztxWy2rlcv4i?=
 =?us-ascii?Q?S/0/vcHc3Hw9tPF2eq2KcIZKwlJCVV3w0foSSomxKqqZROxKK/KncdmKHqKd?=
 =?us-ascii?Q?rCaSX7ZvpynkWpN90e9KF+UEJU4iVC04hiQphonQ2buY/gBuYP4pRxmaGUfK?=
 =?us-ascii?Q?YHut6nlDBF/gwPzsukkSzo9z0Hv1/wQlLR4WTTK6vMU8js7uXeyeblFXGDJV?=
 =?us-ascii?Q?+h1hf1wg9eXnuKqRudSsSXAh6nnf6MDssQsVEez8VPbthRwaoyKNjHCOMUSg?=
 =?us-ascii?Q?o73j0XXa5ZpIDc1/hrt9IKs1aUXukGO5J2P7z98wlONjNveeAGkeg2lOZOql?=
 =?us-ascii?Q?HuY8vjk+BO/GbXgSCcsyASia8rZGJeUlvHusN+SedvxSegH/CT692XrH5oUe?=
 =?us-ascii?Q?codyEBK7x8MAv1E7omw8/kx5uBU/XUl1hs5ve3JolQqy2sZCxJ1lI3c8zmdh?=
 =?us-ascii?Q?NHvZpkSnNVCDNSGdlDy5T7lAEjg8M+LEOzkMbxCh2HZ0YZVo+2MGm5V31w7V?=
 =?us-ascii?Q?IUKTi07FXzOlVkAvJAVjcsGVDoBT8sW3nURvjUY3I4eqZR6VEelysrB5DMG0?=
 =?us-ascii?Q?3bXd7FSzaTLbC+roG3TCXo05xnx5NjGbDxnB5puZrIbht4xjeOgypS5FjIqU?=
 =?us-ascii?Q?TJIff2jCutKJqeBlboHhUuOIQH0x1+494UsWTtAIn/bpQf03Wej1FWcOIpwj?=
 =?us-ascii?Q?02QgmgKX1Kk63ly/BJCkxBo5u6eYlcuh1F/UxMJRrM7CVAu5VnJRgxiwpcpc?=
 =?us-ascii?Q?zIavJfultzFHVpvl113ctfHp17GzNdLH+7l0nlhaL9sJ/FyIjgAVqIOZlb9Q?=
 =?us-ascii?Q?wRHyEV/exuZs/i52rvvPoUkEAxHByHaXZ2/ACsdk9HJW1kFN0kWVEeG3eEh3?=
 =?us-ascii?Q?Ex56JB50Fjt0iqcUF/ACjvwwi9amTfCtQX0RIGnT7asI5uq8pCxGs4lAlYI3?=
 =?us-ascii?Q?78pujnbWaKPoAw6cEeU7sc0+NDVivBOqQjb9bg36D9lgvK28r0UeirSHhGIU?=
 =?us-ascii?Q?IMxBS+1wZspqZi4jUryilkVjO/Mgx7nxSG6XO74FQA1SIxmlBMifwK7jVFGQ?=
 =?us-ascii?Q?VcZUAMYnjTPO+ZOhWEiECYwci7aIZpkMswl2X42+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6e3aed-f3a6-4487-79f1-08dddb3e1b69
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 14:23:15.3166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/5ChqpXxC6ndf5uPp6x+xzZTlfno5AuSMbdDqpoQnQFepQQJU3l8JusDyr/ubKSYraJydl4QPTtNBtlvkIClg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5907

Use min_t() to reduce the code in gfs2_page_mkwrite() and improve its
readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 fs/gfs2/file.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index bc67fa058c84..b54746299c5a 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -448,10 +448,7 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 	file_update_time(vmf->vma->vm_file);
 
 	/* folio is wholly or partially inside EOF */
-	if (size - pos < folio_size(folio))
-		length = size - pos;
-	else
-		length = folio_size(folio);
+	length = min_t(size_t, size - pos, folio_size(folio));
 
 	gfs2_size_hint(vmf->vma->vm_file, pos, length);
 
-- 
2.34.1


