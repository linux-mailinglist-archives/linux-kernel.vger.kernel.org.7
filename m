Return-Path: <linux-kernel+bounces-742705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5624B0F592
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DAC3AA1F1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871FE2F4A05;
	Wed, 23 Jul 2025 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WtE4WfoM";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WtE4WfoM"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010008.outbound.protection.outlook.com [52.101.84.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0C12F49EB
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.8
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281609; cv=fail; b=Eu6+aP1/dsi33+8r4vy18SJ3NBmJR5YBOuS7JsH5xHUgSp2dIe3l9Dxh0naSQO7QJ10f/7VkNDsjg3hPqWddA5QmijnF9PINpMYFwE9PnmxIsg/DUOzfaKSAH9Sw243X7M66IDW1AR2yVS1qUjlo4fGLNLgCiZKkBcSQrOLvYXc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281609; c=relaxed/simple;
	bh=hayhTX8byjkNSrp1R4KKaqJb/fu90eXbs9NIyQDKZiw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C7PXdhKrTumkc4p4JPOeZ2IC9jkYLjSTR8kl/w97myeHpJXcdM2nH4GXXDyBhkfQYkD8xcSHOUQ0jqgQCZerbNLbu8zf0XtUIWv9h2kOYqeh6CquL47QFXhhchiHzxN5YG5EdRjJjTxUQh1w3l4cIO6JOywxELWAYyXLIVSeg58=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WtE4WfoM; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WtE4WfoM; arc=fail smtp.client-ip=52.101.84.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ElFWmYzWFuyfboKwBcyvz5EHFx73XOlWqglJW0Uuj9ij2IKUdkFFKhh0KwfeZiuBQ63dGuO2g+a5Mu4jX4/Qfc4WbMi1W3fiO9N096ln9xwkcLRtdjl2lUCEMrV5ZoUZHkQrPDm3PNKRySRuTi/ywdcf9XLaMexSMtI5qBYqi3ByQjGAF/3pD3mgB3VC4UHKx5vtOcpLJsGQLPZgcs6efirBhNgZqKksOox1ACU0dYEVK/olSyu6rSl+WYSJW5lr1JRavhOtf7sGGvkxHU2IVZSZ5dpdM/Sb2HQAAbQJkf7LeX+tLnJhlevuKYp+338SisxSKbbrDXdx2ODk74KFlQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIbAO55wzjPHIFYrMI09rcE9v+bE/NEExaDwAQvevsM=;
 b=Eos7dqGni1bXzoTP8SLZkdW9itk9NaF9rEWSKOIjtRTZhAaZEA4AJTjKi9TdneOyBc5xHcuJIEQFzHN7enimkrTp7lnWFAA9rVPnJRevxz7WlCR4K3BelBE/DVSgYVr5bV6BpGZicfTdk7XCd2t99a2FYXx4obxJ8ExkHsJLG6sfc1+M9CAWT91+S8KjHuhxY8ONHZhnLKW9VVZ1R8Jrr9bteebYQwaMR2vZ3emjDcY1jrz//NcTy53Ffj9f+za8z/HeIYRQyZht0/4htlNiH67cQ4uVoOtY5zZqNcUsEhIDMXSPLmO8F98mGFvDI7bH04PpOmGJZZuYffOu7sNy0A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIbAO55wzjPHIFYrMI09rcE9v+bE/NEExaDwAQvevsM=;
 b=WtE4WfoMoQICzRUKLv9t50oH9i4EK3WHBHx8k6lf0ngtfmUgaPXN11sMKrJnFexWj/5x3QeBvDYZFW3YD2xvefJlnRVZsinJa85YU/h2twiqGzFOWGpsapPxB7kOMC7ZayofAp5P4pD2SB9SrJ5q0EuFxG6THj6WywvBiZH/p58=
Received: from DU7P190CA0014.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::12)
 by DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 14:40:00 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:550:cafe::bd) by DU7P190CA0014.outlook.office365.com
 (2603:10a6:10:550::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Wed,
 23 Jul 2025 14:40:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Wed, 23 Jul 2025 14:39:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ororQ4JHhIsVrIEGGy2RHu3zuh/sIXiuyLl8+ln1Np57VbA+dnHukGhnmLKKtl/AGNKqUnLbSmTqaWyWpf6ll+0yDnhpnLcCFud+HrwjdP1+xOFa0VgJE8UF+wSOQBYWf+ybQ7FFYa9TIuMgW1Ptr0gONv0OD1a/lwcwDNm6BFFN3//+L5oOkbR55xrZtxzLopL/HdCXg/XjqeSe9TLB7XE0fUOU9Y6xKCsDpC19hEJyGJ3AMjFfDOHbcajwXFjPWoMni3sdnmxQQuxf+8MZaPZ3XOVHioZ4HRXskbo1kepn3McTGhbrHWHvLfwUAHYbY+FkWiviHV2RYvaeHTN2Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIbAO55wzjPHIFYrMI09rcE9v+bE/NEExaDwAQvevsM=;
 b=GHRTXnBygqu2ju5DrjsIDLxSZQXZqxVbU79d1UQJdYoQ+tl2SfyChP648pt2pZBDdypsvMyvvISVxIyvVTi21cqYqMHo0jE3VR/5xJSRQikRC1z8MgGx1tZtB4ffHwRBc0bIpIc9Pd59Gg7WVC+XVjQ1vYIMN98YlXFI72Wbg0sHl00/mBrfMUfWVLQuUgR0W7UwANN8NgUutiIXjqXjn4vcnqzFsD5QuOQ1dvpoixgjUIe+hmdCctGhdWPcco6/kkDmcdljUPlsQsYeDvdYCTcOHbXN/o4vnpUCNQefrAC299pzifXw5IUERs4nfntC5nwkr4R02LG6K6RT/AuWlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIbAO55wzjPHIFYrMI09rcE9v+bE/NEExaDwAQvevsM=;
 b=WtE4WfoMoQICzRUKLv9t50oH9i4EK3WHBHx8k6lf0ngtfmUgaPXN11sMKrJnFexWj/5x3QeBvDYZFW3YD2xvefJlnRVZsinJa85YU/h2twiqGzFOWGpsapPxB7kOMC7ZayofAp5P4pD2SB9SrJ5q0EuFxG6THj6WywvBiZH/p58=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DU0PR08MB9728.eurprd08.prod.outlook.com (2603:10a6:10:444::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 14:39:28 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 14:39:28 +0000
Message-ID: <55f8c7a4-4535-42ff-abb7-a7cf7cd08684@arm.com>
Date: Wed, 23 Jul 2025 20:09:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] arm64: Enable vmalloc-huge with ptdump
To: catalin.marinas@arm.com, will@kernel.org
Cc: anshuman.khandual@arm.com, quic_zhenhuah@quicinc.com,
 ryan.roberts@arm.com, kevin.brodsky@arm.com, yangyicong@hisilicon.com,
 joey.gouly@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, david@redhat.com, mark.rutland@arm.com
References: <20250723102905.7894-1-dev.jain@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250723102905.7894-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::32) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DU0PR08MB9728:EE_|DU2PEPF00028D02:EE_|DU2PR08MB10037:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f8a6a1-6e0f-493c-8302-08ddc9f6cd50
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ZVpwWlkwbnAzWjdIQ1lqYzJXZUNiMWN1a3lMblVjQnk3UWQyb2w5dEcwSHUr?=
 =?utf-8?B?R2FNR3JaZEhnK1dIbVJkeWxQeWNldzhxUm9YZkFCZ0tvVFAvem5kQmZjSnBx?=
 =?utf-8?B?SUViQkZvc1orQzBaTEVzSXBOT3BaMkVCY0VrcEdTVDZTaktENUVhWDhKbmI0?=
 =?utf-8?B?WmhDZFdCVGY0TUdUaE5PWjRYcW5OSHBwT21mRlBBMmFXTVo1RUF0VGlocnhp?=
 =?utf-8?B?STc4aU9FaGNSRjVoMHBnZHhOOWRXSmtBdzcxODhxbUpYMEdLM1VGc3FmZDdv?=
 =?utf-8?B?QmhtaUJhYWtpVXZoZExqZXVMTXBZZ2RKVEFsZkhQd1plZzF6c2lMK29TRjBC?=
 =?utf-8?B?UjdoallRSnBRbGpVMVhYV3dDeStTb0t5WVdPT1ZoL3dhK1lOZVgxQUxHdDh4?=
 =?utf-8?B?cW5uOFoxQW9tVlJlck5VS3Y0eWo0d05TVno0K1JDb3V6VDZua1lHaFgreFBP?=
 =?utf-8?B?djBRcUhmMzBWcWF6WDNkSXpBNkNZdkRIcmE4Z2pQQWFpV2lKcnM3Sk1Tay83?=
 =?utf-8?B?aHMyR0pMVXY4WWdITUZIOEtBVzI2Q01GcjRFVFNHZGxYWVBBV1ZXY3FLTkdw?=
 =?utf-8?B?YmE1Y1dwRzdjSUxCbmNSanFFMGpoWW95Y2NaV2F1QWlkTzZNdDBSYmVtSFZm?=
 =?utf-8?B?TGNxMGhOZVpobXc3YVd3NGl2ekFyTjhQU1VvZWZrc1FnZHRDQW1jS1RMR0dE?=
 =?utf-8?B?NFpENmhsbXg4SHMyalJOSXhhWUdmQmFYalhxMTQ3YU43NUdTWXl6S2NSc2Ur?=
 =?utf-8?B?T2JEaVErVThCNUlhWXdqZWlja0cxWTRrYU1lRGF0MmJCUm5lVUhmUkdFNFk3?=
 =?utf-8?B?T2Y5OHNUNmJBODUrUHh5bHdSR2pES0hNNHYxdGFjTGlYRWQrenBCR2ptRENs?=
 =?utf-8?B?RDFnY0ZheFNjVnJFbmFQRjM2eWNsY28rMnVMZ3h0bFJjRVJtS25BeUVOaFAy?=
 =?utf-8?B?STB0YkdOamI1OWZvTWxXZVhUMUF6SHJTeWtodDhqeS9RWGlHVkRtekdzaUxq?=
 =?utf-8?B?TE5OZmFhSU1uTGJqVktJWmpveXhTVVIxMEFyYlc5c3Q0ZnB2MUE2Rm5iTlBa?=
 =?utf-8?B?d05QYkt2d1J6SitIRnpwelpwWGxpRHY5eXRwYTVkSllXMU4rSGV5Nm9iWTlV?=
 =?utf-8?B?Qis0dFRXMEdOb0EvU0d6Z2ZPUUlQaDRVTUt6Y1JvekJ6TDU2aS9lNXhPQ2xD?=
 =?utf-8?B?U1hMb0lGWUdmdXB5NTZndU5vN3hIazRKTXl5MkZzd3MvS215ZG9JZjRkZTcx?=
 =?utf-8?B?cjlxdW1la2tIOGZyak1vRDB6dVNhY1dXRnBuWk5EbzFVZFllWXNaajdtZFI5?=
 =?utf-8?B?S0czOXAxdGQ0ZHJ5VndPSjVQSjJlYlJlY05MN2p5Qi9QUGlveC9sSWtxdnlm?=
 =?utf-8?B?S0lpaDdIdG5UZy9sbWtnWVpWV3ZVTFhnOE1JSFhNckZTUS9EVW03M3V5eDds?=
 =?utf-8?B?dDhCMnYyMUZYbE5HNXlVQjRzYzBvS2Zib3ZBYXMzNVcyOSsvS0UxVDM5Z2w5?=
 =?utf-8?B?cmNFbmVjWDlQZ09FckZHLytUZGFucVF4MURVSk9WWkk1SVVPR2t5UU5SWURM?=
 =?utf-8?B?cnA2Rk1OWmFJckdyVzlCUFk3VHJnSld1Vkl1ZHllT2xENkpBNTRRNEQ5ZEdF?=
 =?utf-8?B?VEhhdTBta0JjQ3RFRmxEMVFjSmkvNjVTelNaMkpXRDE3NUtBd2dhT3lZNEJQ?=
 =?utf-8?B?MzNhakx3ZnlKbGNTR2srbjFIZ3VLWFlTWHhZUDJCMjFhVEdDcUhEWDBMYVJ0?=
 =?utf-8?B?clB6TTZYZHBNd2MyL3MrWGp3RXQ2amg0MW5wR28rVlhmQnM0MjRGZEZKZDh6?=
 =?utf-8?B?K0pZRXJuZ2lNNDJxOXpkWDJoQXZLSzZicVFINzZwbTBzK0F0L2VDQXBmbW43?=
 =?utf-8?B?bXhOeHlyZUxWWkRUR3RrcGhieVNMNlp0YzVSN1hqejVvd3NYbWVJS2JpSENF?=
 =?utf-8?Q?ovRGugIqUKw=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9728
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ff96479b-cd4f-43da-a190-08ddc9f6ba17
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|14060799003|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUcyQS9qS01Bdk9iSGxkaEdEY1paT0I5bXZKZXhoUHVZaDhTZHlIM05vRUxL?=
 =?utf-8?B?alNmTW0zWFZKSlBWL0Y0OERROE9UZW9pcjhiQzk2L2J6SXdicHJuL0VkV0FI?=
 =?utf-8?B?V1N3Q3RoMjdRRDRWUitNeXJuRGZIcnVzUmZZOUw3cUMrNytzaGlTVFZMN2Jl?=
 =?utf-8?B?WXA1bFA2VHBxbHVYSlVjZVpaWHNVdEE4Rktkb2JkVWpKbWlNdXFLbnExaEFa?=
 =?utf-8?B?OW80eXNDRysweDFveGxSN3A5QnJWbmpCL0p4REl3Z2ttNHZXRDlQNkQ0YThB?=
 =?utf-8?B?VTZLdWd2VmZLVC9tL3dlbnVjdFF0dk9ndzBPdWhaY2Y3Kyt0emFHaEs3K0M1?=
 =?utf-8?B?YS9CNjlxeDQvamtmM2wvVHN5MTJCYVdpbE9RRm5XL3JtV3VSeTcwcnl5M0xQ?=
 =?utf-8?B?N2p1b2dJZHVqT1R5eU8yRHlkTy9CYTBucUd4QllNdEpHK2taRjlUZGFLeHpi?=
 =?utf-8?B?TWNvNE9FaldaeDJqc0xWa0k2MHRhL0NDS0FQYTZKWkt1OTRVVnl5dFVsYUIr?=
 =?utf-8?B?dC82NmxxOHhFb0dHKzJyYnJac1gvc3pnUGNYNEc0S250Q083UVBOZGJ4OFha?=
 =?utf-8?B?RVM1bTI4UjJsR3pQdGRnTGN3N1BKYmJIMjNxQmpxb2pTZTZCR1hPQnlpbVh6?=
 =?utf-8?B?a3daVERlbnlxbTFpMUUraVdkZUowYzVlSUl4TVVsTUNSb0NLRTAySTI1WVd3?=
 =?utf-8?B?QmRnOXUwU2s5eGNUdGlWb3lzVTZXYlp0M0RKQW5ZSGFueG9LNGc0WG1wSXha?=
 =?utf-8?B?ckJFUGtGTnFvV25oUTF4T3o3N2J6R09hU01pT0FCcGdEZW03L2ZZUnZQWXFH?=
 =?utf-8?B?VUZFangyUzBrR0tSTUNZQjhOK2xVS09DbWttOWJ0Y0hWSE9GN1ZoRU5ySHpq?=
 =?utf-8?B?YVpyeThBVTM1TTJvM3A1b3JwOGxQYSs1MHFNMzhUQ3ZYUWw5dGVNRTkwRzVO?=
 =?utf-8?B?K1h2ZUl6SEFQQWVaTWNHRW92ZWZxbDJ1R2RMNE04Q0hVYzVZSmM2ZzJjZG0z?=
 =?utf-8?B?OGN5Y1paZG9NMCtKeUZVV0V6OXE1VUxyMzdMRmtIcFE2QmVDalY4b1RKMFY5?=
 =?utf-8?B?RHNSZEZtcXh6WXNLSTdEQjZrUVh3MkhkOHBocVd5amFxNGNGVzBFTFdKcjhD?=
 =?utf-8?B?ZHZUQVFmbTAvWm5KNlR1cVF4a21ObDZvenRqVGtDLzNGTEtrS2NZWFRjRnQ2?=
 =?utf-8?B?SWRBOHp5TWZkczBPVm1mdVovemlRNzRhSlMzUG8rTWdGanNnVUorNWFXTElT?=
 =?utf-8?B?Nk9SM0JjTzJrNU4rQVBHTTFiWHBRTFJXanJ0V2cvQjRyWG1oOHAwL3pmOWs0?=
 =?utf-8?B?eHpxQUlJUjlZMThSWkVhYjAvVmdHd0xpei9RSnZyVmt2TGFGOVdDVUEzckFn?=
 =?utf-8?B?QXMxaDZtR2ZRVTM0dk9GeVdrOFFuczNJdnhnNGRZNzZoYjF1cDhYZEk4aU9w?=
 =?utf-8?B?aUc0SW9NTnhjNlcyM2FlK3NhOW5RbU50S1NGS2JmS2YvazFMSzBnMFFBT2NI?=
 =?utf-8?B?TWpvVGtkMFo2ODgzOUxDMnJuVVUzMWxQMVMzQi9yL2VPemRoUlhxNlptT1RD?=
 =?utf-8?B?eUhLanRFU3N6VWJsTEFIZVdYSnp3YXNMTWFBMVpOVG1qWjl1Wkt6Qk1manRQ?=
 =?utf-8?B?dDcvYkgwaVk3Rm9CNE9mVkkrZ0U2WUhxUnJUYzVZT2RMUUtzN1huZ0hRbGtl?=
 =?utf-8?B?U0Z2bUtuM01wU3hmTXdRRXFMM3VUeVh4RGFzTHo4UWc1RmhIbEdsRVlJaGVK?=
 =?utf-8?B?S1FRbUd5ZTh1UHVGcFRDYnpvdHptVWI1ekJidy96a1d1VUtPM2dveDErZm9R?=
 =?utf-8?B?NUpRVXpSNlF2SHd3azJIUitxaGR1Ni9PdHhIbDF3V3BSQml1WHV1R293RmVt?=
 =?utf-8?B?aG1MODg2Q3VIU3hUYWltSitSeGp2Q3l1c0NpWkRBaGQ1ZTZLTE9iK0lCblBH?=
 =?utf-8?B?b0NTamtWME4yNVBtK3BRVWxQOHdFSlVXSHV3UTlWdHY5VUZCUmR1UWEvb0hZ?=
 =?utf-8?B?SmprRmxCdmxaaURkMmFrU21BbFJ5T1NnRVNPSlZkQzRldFdNb0F2a21uTkQz?=
 =?utf-8?Q?2Qjl8K?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(14060799003)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 14:39:59.9252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f8a6a1-6e0f-493c-8302-08ddc9f6cd50
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10037


On 23/07/25 3:59 pm, Dev Jain wrote:
> [--- snip ---]

>   void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
>   {
>   	unsigned long end = ~0UL;
> @@ -311,7 +319,7 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
>   		}
>   	};
>   
> -	ptdump_walk_pgd(&st.ptdump, info->mm, NULL);
> +	arm64_ptdump_walk_pgd(&st.ptdump, info->mm, NULL);
>   }
>   
>   static void __init ptdump_initialize(void)
> @@ -353,7 +361,7 @@ bool ptdump_check_wx(void)
>   		}
>   	};
>   
> -	ptdump_walk_pgd(&st.ptdump, &init_mm, NULL);
> +	arm64_ptdump_walk_pgd(&st.ptdump, info->mm, NULL);

Brilliant, due to copy-paste I passed in info->mm here instead of init_mm.
Let me resend.

>   
>   	if (st.wx_pages || st.uxn_pages) {
>   		pr_warn("Checked W+X mappings: FAILED, %lu W+X pages found, %lu non-UXN pages found\n",

