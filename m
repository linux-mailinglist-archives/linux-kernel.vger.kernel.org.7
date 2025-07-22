Return-Path: <linux-kernel+bounces-740771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 569CCB0D8F6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1EFF188FB3B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01152E499A;
	Tue, 22 Jul 2025 12:07:02 +0000 (UTC)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022106.outbound.protection.outlook.com [40.107.75.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5744D2E336B;
	Tue, 22 Jul 2025 12:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186022; cv=fail; b=QwEZ7lb7h5Ohj39PMFEQHGjSxglabkZuOVPDPSBXi8trkijFUdTaiDWbKKTEeLdTU5fAHF4A4UwArRSZIrcKXfKpdk5IRKl4z7DaMtFtKysLM1wURM7bM61GQ100b8yn8UQoBeCfa1JxuIQrg4VLZoEL98G1P0QYpLM4XmjbsbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186022; c=relaxed/simple;
	bh=ddde09awFFaOZ5kMXQOBG6G/U9JOR5UoojhdVBhMm1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhjvJ0zmL2dCGyCPh6wryxEw0ih/GXJHphWUoylgJH04sI1ZrSgY7xL1i8JVCacP561/+L2J0jXI0YOP+PEnJXKx9mdl43k02l2CVr2/RwU3ReFyC05S+1iJtBmWOZGxEpjQo67fp5SDGOF/Ah91tNVpTV1C7JX0duOhG+NFRmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmkLqXEOLKqsH/j1H0pm4gFowAjhFW4A4GVnDTa+dtTZvgCbylyM3pW8m8+34kq3Dxre7yen5kBNnzvXN9b9BcaN/sMiIAsGEWG23DzBqyo/GhcYmmxFN72wAB8kYeZOzwZ4Ol6YtsuspHZi4q7BEbizZ8HKeRz+/9m+0vOTb/wufji2QXpMXE8gMVdtdsShKVap631zJmjLWToKxgirhnF8tW3OT/Sw+z/MKBkaWXY7TljOr4G0gUZ1JmFUJZ+A1jah07kfATJTrMul9cl/PjLUAynObno2r3xBvPjJ+uXkQbKoG1/pHB9nItiEeLz3M9fU5fMSEGnADq2LSqepFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LADhb2PuqbDwuUerz0inEybQtfmOp4apa5x8P6KI71k=;
 b=zDQwKcY9O4Wa+S2CCFCYaGhyWBKVat/ZLRtT/mGNaOQ9Pzz5VhhhtiVtVGGcph7lQVsw9ztrnFlA3viBEAAdabVMoI5TZ1SPcxHFk0xkx9COYADezmTiQcBvOgffWga9q+cPLwS4R65uW/94B3/1HO/8VjOS7Cn/kbue4h9pQ9ah5OLwYcHyRB+O2SrTxy/qfsGVpqozW4z3IT1zSiqjfOVGJ/jDSksl3mqFkXL45XcJYOoJVpaUe3e48etlgrYzDI6tNzsa32aG93pFG1pM6vG5KUUJEMJPTQEhGbUxjriDwuEvp6lIw5mJyrS9hFWo9reX/jPQLWg/8qV6e/VL6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP301CA0079.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:7b::15)
 by KL1PR06MB6964.apcprd06.prod.outlook.com (2603:1096:820:121::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 12:06:52 +0000
Received: from TY2PEPF0000AB87.apcprd03.prod.outlook.com
 (2603:1096:405:7b:cafe::1c) by TYCP301CA0079.outlook.office365.com
 (2603:1096:405:7b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 12:06:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB87.mail.protection.outlook.com (10.167.253.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 12:06:51 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id B0E124115DE5;
	Tue, 22 Jul 2025 20:06:49 +0800 (CST)
Message-ID: <ed2b9167-2eb3-412e-9c1c-eba124560e3f@cixtech.com>
Date: Tue, 22 Jul 2025 20:06:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] mailbox: cix: Fix spelling mistake "overlow" ->
 "overflow"
To: Colin Ian King <colin.i.king@gmail.com>,
 Peter Chen <peter.chen@cixtech.com>, Fugang Duan <fugang.duan@cixtech.com>,
 CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250722100214.3792075-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <20250722100214.3792075-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB87:EE_|KL1PR06MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: e7844489-bd18-4af5-1037-08ddc9183e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXh3N2ppK1VtNTJudnZUeG9sVWNnTXFhSGJDRXNHWFdrZmFKanR2MkduS0Nq?=
 =?utf-8?B?bnpxT1E1OVl1QkhlcDFITTdZKzRPTUtiSlgyb1dJMjRBa0xndFpZSG1WakpU?=
 =?utf-8?B?enJ5aDE0d0FOV3I0aVJRYVJacWs1ZU0va2ZCbWFPY3lvU1ZvakdTMER4Tm9h?=
 =?utf-8?B?VklUMmNIaG0xL1plb20yWWU5SHBsRWVFdG1vMkh0WHlteVJpZUNrV28vM28w?=
 =?utf-8?B?a1RkRytTeW0wZ3YwbktiNG1UNC9tb2hUQ0tpVU9XSmJoZjV6bEhRNENXcWRk?=
 =?utf-8?B?RmZtQ3IyUHA2eTlUTnNFN1JDRC81R2QrbVdra21YUTExVGpBK3p4d3hTN2Rs?=
 =?utf-8?B?b21lNmZyVjA5U2tTb1ppSmwyNmpQVTV5VlRSQUpzY2RJL1RzY2NkUVhWUjhI?=
 =?utf-8?B?b3U0SXZtU1FkOEFZSHZWWS9rTEVGUHpGTURJb2s1WTRzQnYyWTJEUTVvQWNL?=
 =?utf-8?B?dXZNakx3TTQ2Y3JUQlhVMzgzNGQ4Ly9ncSs1VWcycWFRMVdIbVFuUXNHWU5G?=
 =?utf-8?B?TjVRYUpOMTEzejFVMnZLZlhXNFV5STExMVFaQmJEQlB1N1VTZEVEL0hPVGZT?=
 =?utf-8?B?V3VHSk05LzM4Z0ZTTWVCS1ZURC9zMDNwMHBUZTJuRkxDNGl0V28vbFUvRnpR?=
 =?utf-8?B?eGJiSU10NUdjbGRYVkI0R1JIamNqZVFHMmxBTFNZd0NUOVVlUVhXY2taQVVH?=
 =?utf-8?B?OTVnRnBHODMveWtiejRYSm1NcktmcS9hb2s3NVRtb1VXU3ovQTFLME1RWGVJ?=
 =?utf-8?B?ejFjclRJc1RCWk1nOHJYenJDSE9nRmtQQnltQlFYdElVKzQ0VTM1NEVZQkRh?=
 =?utf-8?B?SXB4b3RVMll6bkZxTUZsaXN3U0RldlBrWU1IMjFWU203UktuNHdGc0cyc0hv?=
 =?utf-8?B?NmRlbmpDUHVlS3Q3eWd2TUFOOGErclZxZmQ2bjRUdlhBZzZ3OHhOYzYwN0xi?=
 =?utf-8?B?d3NKeVRRRE93Ymc2VlJ4UkY1dENXaUw3d0U4QVk3VCs2bE8rcnFHMVdnaHRK?=
 =?utf-8?B?aE05TGdTV3JkNlY3UkxnSkI4d1d4RnV2WWVTOVVscVVGRDBPOWxVNzBMU1o4?=
 =?utf-8?B?bFRBdDFsZEZSVndwZXJKVVhhM1JZMnlaTGdpK2FoNDBYWlU1MnlEbEJXRXB6?=
 =?utf-8?B?T2tDM3ZTK3hiVUhVaUx3Tjh3RjFVYjZXc0J3Unhpb1F0UFp6dHRFSUNta2hm?=
 =?utf-8?B?WVVaWkFMNXc4Z3JTM3I0WDdSK2REQlBtY0h6Mk53MWdWSUFBRmRFK0t2WWUw?=
 =?utf-8?B?VVZxWVhKcU55N0EyeHY5UktMeG9iRE96N1JCTWJLNWRLWnpqOUxZTlZRK1R4?=
 =?utf-8?B?WTJSOEtaTVI2eDNJRjFUV2xsVU5kUGhFMEQ1RkkxS0NlcFFBUHVkNzhjTmZ4?=
 =?utf-8?B?RGd5TSs0dENyRFI4Z21KaFRadmxzaHFuTHRWNDFERjZyRUxwOVQySTlubytw?=
 =?utf-8?B?WUJYcG9nS1hlVjZmZDN4QXFoYlBTR1VNRlM4cXhzQkkrb1hna25KT1FyTGtp?=
 =?utf-8?B?Yy81MDB3dzhMcHlFcFd6WWJIZ2ZNN2NTa1YvTm5Ud0dncU51NlVvcWVMdTlm?=
 =?utf-8?B?L2NLaFMzczl0Z2hqay9TbFpqekhYcHhFSnVaUTJOVEpTQnoyL3J6YUF2dTg4?=
 =?utf-8?B?SklEcnduYjA3UnlJTUREQy83N09TMnFmeGJORmJiRU0vT2NGUnlHcUN4SDZK?=
 =?utf-8?B?V0JWOFpuMHRHcVRYMjB6VEdlQjVKUmM1Yk5WUFZLT0VCRWI3OXF4QTVVeHE3?=
 =?utf-8?B?QkxCZmtGTElNV1liYThUSStod2E0M3ZDY1pBdVZ6YXBpbWZaT2ZoaVF1R3hZ?=
 =?utf-8?B?b1lGZW93TnMzODNQRzYvSzQ1emo0dHJQT01jWXkraDVSYkNmaTQyMTdaQWlu?=
 =?utf-8?B?MVRsb2hTMDVwUUpLdzk3YW5qYUJTZUtWYXg0NGRycFFza2QrSkNvSXh3Zytm?=
 =?utf-8?B?RFFNVFdmUkxsOG9UTmZMYkxUQmt0NTJESnBpREJxYlJVbW5kZnZaSExlSkJC?=
 =?utf-8?B?eWpCa0xTODhlQVo2Q3piQnJIeUl3Ry9wdjYrM1phZEE4d2xVTmhMM04xaUpl?=
 =?utf-8?Q?kS96TY?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 12:06:51.0558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7844489-bd18-4af5-1037-08ddc9183e5b
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB87.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6964



On 2025/7/22 18:02, Colin Ian King wrote:
> [Some people who received this message don't often get email from colin.i.king@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL
> 
> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/mailbox/cix-mailbox.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/cix-mailbox.c b/drivers/mailbox/cix-mailbox.c
> index 5bb1416c26a5..443620e8ae37 100644
> --- a/drivers/mailbox/cix-mailbox.c
> +++ b/drivers/mailbox/cix-mailbox.c
> @@ -346,7 +346,7 @@ static void cix_mbox_isr_fifo(struct mbox_chan *chan)
>                  /* FIFO overflow is generated */
>                  if (int_status & CIX_FIFO_OFLOW_INT) {
>                          status = cix_mbox_read(priv, CIX_FIFO_STAS);
> -                       dev_err(priv->dev, "fifo overlow: int_stats %d\n", status);
> +                       dev_err(priv->dev, "fifo overflow: int_stats %d\n", status);
>                          cix_mbox_write(priv, CIX_FIFO_OFLOW_INT, CIX_INT_CLEAR);
>                  }
>          }
> --
> 2.50.0
> 

Reviewed-by: Hans Zhang <hans.zhang@cixtech.com>

Best regards,
Hans

