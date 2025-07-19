Return-Path: <linux-kernel+bounces-737765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 856E2B0B051
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 15:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9F1567629
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 13:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A626B156678;
	Sat, 19 Jul 2025 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l4y7kuPY";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l4y7kuPY"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2621101FF
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752932863; cv=fail; b=KPc7+eU9Q4dNy156joG9eeSEtL/8Gw7yGgpR9nrtzxr5MEI/J08uvVu99dNwvRwCfIRJjK9u+bSKEqwwdepZYYF6wmyVoQOZJWA8Vy5CTmW15PVClcNmtVceB757qKsokZKWQKqHk4BypXdcBvWaZnJD4Y+ZCwFXqX/KbOHFO8U=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752932863; c=relaxed/simple;
	bh=DWEA6KP489/bXI744Nf8zD5mnvSLDs4ZSdZrMVhxuQ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mK+rnTLn6XfGCzrOP6BuXh5bAPBEZjFIJOlmS7gP9CidKiNTPoXExznGDWYveeE0k62jhi5GEwXjDSy0qWTS2N9Q2HRSAIVzKep3H2WFEyaeW25SY5dKaj6qBtABJ71JYn/CRCDUIDqGK9wRmA32+zXH5RQ/Mm1OGSUPkG0KsC0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=l4y7kuPY; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=l4y7kuPY; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=N9awUmn64ZnKyLHTIJF7kbkwWAsB+V9HnxXJT3PV1dkqJy246UbLSM4DT6HqAfyu2SYTGIJ1CHIuInJtETrQS/zU5hGhy1fZ412NVwodRMkra5Gyu9aAZDU+v1+pTlFZOelwNxX2pRhYxQgL/NFl6jGXRq88M98woefsvDhWt84ijNTgon/+lE3pqQrpP/BBC0X2sHKOvFb15BZEgjX8P/L8X6Bs5Spu4+dA+7CvmX0WaTsyKs9qqMB/Ah1MHgxq7kRld9SZ3Rlvyhc9vxuCCbg/r+6ISFlFgzT+zKsplAA4fHNNM35Oh/HvqbSZqffWZPq5fN1cwoJWzL4nOy6fDw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDOIuucyd3s11XTN2gA3RxTmFuuLbisKcUxTqaL1kMk=;
 b=LdV+ZmnNr+Rl15wzgwmvDvG/ZV4eHjyNfjexRSXNGZyk+IezJYjeYHCd4nNG7CVIqSzCroUIvDX0d3E7CBI0sH/dT1v6JMKa+oQPpJIc7al8baY7HbfJD+xIbEZREcZorijdzzctDD/t1oR3PjTbKHR20oumEbKKTYj7Jsw5K1tUQN7/7cqlNjFxJ4vWDv0qhHewMcyA50pq82QIkYUMY32VSMiAb/UWb5GmeMD8WANkMjhrz6TR1JJdam8BhMWpbxCVX4Tf4JBu23iNqzJEef0v7hTmUYQFuR80UH7hE4rXbuCyQ+eZRm+QBvWOddfDxT/0KGyEv4yIaYJwMtfaVQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oracle.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDOIuucyd3s11XTN2gA3RxTmFuuLbisKcUxTqaL1kMk=;
 b=l4y7kuPYV3MwV1xiUwf5cnfHzRcVCeCA40t3KtyDOc6KDzEgBlXMaelnqH3l2sJ3zHhzcNdMcE6qVsartt/aogV31D+4oqJongGSgKMN2Rjss9lZgliFmjHS1PzkkofaufFjp1jsw7YH+rhpFNQZaAHvrzNnX88k8FD/K+kuHnk=
Received: from PR3P191CA0044.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::19)
 by DB9PR08MB9443.eurprd08.prod.outlook.com (2603:10a6:10:45b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.26; Sat, 19 Jul
 2025 13:47:33 +0000
Received: from AM2PEPF0001C713.eurprd05.prod.outlook.com
 (2603:10a6:102:55:cafe::65) by PR3P191CA0044.outlook.office365.com
 (2603:10a6:102:55::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via Frontend Transport; Sat,
 19 Jul 2025 13:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C713.mail.protection.outlook.com (10.167.16.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Sat, 19 Jul 2025 13:47:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eeEkMiRpXFWckxzFez0veon44Pi/DDb8aRMaI+DlmdorN5WxYyZgWB4WVowaoYVopzK3oqg3J8UV2//ztl6nzZF1rHDNNmy/jCEAM9fE51iU04DSXAzGhp0rKNFJzowhuDwB9gxqU6j3TgRS/vKHel35WFMCs0CD6IF7kFpkzWBcApuds52WcBwGRznzpAVmW3YxsRrQSdFM1DcAOIYNmVD6NRiAVIXfKnE+VwfHGMRhxrH+TyO3oOM7Xjh3w6WTr0aHM7E50awppFiwDYagXqmCjj18wlBgNZB3UbiCY0CwNc5lpXpx3sBjJYqgVsM/L0i96H0JQ9MyWQSdb+iGPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDOIuucyd3s11XTN2gA3RxTmFuuLbisKcUxTqaL1kMk=;
 b=ckex19T4kvlOrTd0aVtLp1/T5iwK15fIHvSKa4n0ouaDPEHXOR2xUPO2RhulD3geftaW0KaxuJyW0kd3UksIOzeDXvtFs3tcSgfhsq/23xZWTv6VPBpu4XFP6LzHuFKoa476HndjXSel805xKv4oMHjJOMrCgCyEtIqGN33L4CFTyASOHZQoo2z/HF6hKYyImpDX9apWa+8SoZ/esr3tB7E/HI3AZRMk+OvjkyDlXt2Lvg+t7cMfuY/WBoyyF9rVzzXuB5YSgd42Sx6ouBC1OIUVmh5B78YQLZZuqM9IWg0L/cmViViRJk/aSBbGB3HkAbY58HJ6bTwRx1LbhdlR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDOIuucyd3s11XTN2gA3RxTmFuuLbisKcUxTqaL1kMk=;
 b=l4y7kuPYV3MwV1xiUwf5cnfHzRcVCeCA40t3KtyDOc6KDzEgBlXMaelnqH3l2sJ3zHhzcNdMcE6qVsartt/aogV31D+4oqJongGSgKMN2Rjss9lZgliFmjHS1PzkkofaufFjp1jsw7YH+rhpFNQZaAHvrzNnX88k8FD/K+kuHnk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DB9PR08MB6666.eurprd08.prod.outlook.com (2603:10a6:10:2a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Sat, 19 Jul
 2025 13:46:57 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8943.028; Sat, 19 Jul 2025
 13:46:57 +0000
Message-ID: <9377543e-3b92-443c-adb0-bc3227ea994c@arm.com>
Date: Sat, 19 Jul 2025 19:16:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] mm: Optimize mprotect() by PTE batching
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, david@redhat.com,
 willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 catalin.marinas@arm.com, will@kernel.org, Liam.Howlett@oracle.com,
 vbabka@suse.cz, jannh@google.com, anshuman.khandual@arm.com,
 peterx@redhat.com, joey.gouly@arm.com, ioworker0@gmail.com,
 baohua@kernel.org, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
 christophe.leroy@csgroup.eu, yangyicong@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, hughd@google.com,
 yang@os.amperecomputing.com, ziy@nvidia.com
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-7-dev.jain@arm.com>
 <5c993cf6-13c8-4420-bd78-706ea287fb28@lucifer.local>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <5c993cf6-13c8-4420-bd78-706ea287fb28@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0167.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::15) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DB9PR08MB6666:EE_|AM2PEPF0001C713:EE_|DB9PR08MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d643a9-f7f9-4c69-339f-08ddc6caceb7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?VitBbi9uSDBIc3duR0Rwd2tETWIwUUJaZmFRUXZqWDcxQlFDWXFUeVJIUHBx?=
 =?utf-8?B?cGhla09oaHVSWWd5MVhvSzJZbXBSZ0RmOEsxbUN0aHg5MUR6ZzhKbEFwUUYr?=
 =?utf-8?B?aHo2cjh5TzRVWFQxWEhhQTBNWjYzVWRzYUIzajFnVEN3RVVYWkw0U3AzM0hT?=
 =?utf-8?B?ZytrS3NId1UxOEpDbzFJSHBJdDlFVXFRSWJ0UWxMVnM4R0pjMEVXenU0UzRn?=
 =?utf-8?B?TGJrVXNKVFFveGhiSDJHQi9zN1F6QlJzK0M5UGJiM1FnZlczYWNCbXUyRFc2?=
 =?utf-8?B?UXE4VGFZN2pPdmdVMnYyRVVybXV4L2FOY1htK0FYckQxa0p1VTV6L1FlRlk0?=
 =?utf-8?B?OWc2ZjI2KzFjcjREN3I5NFVVV0oyb2pOOGE4MDZyVUlhMGlmUHZIaTl5cDkz?=
 =?utf-8?B?dm9mSDNzWUxaWVgvQ3VtVzYzQ2ZlR3lBRXc4VVkxUnYwM1FERnIrSm4xM0xu?=
 =?utf-8?B?SjVnVUFJZ3A2RUt2TmRLTkx2WHNJdFNsZjFYNmZxUm1ROVFHMFJ3dTdrRDNC?=
 =?utf-8?B?YzZBSFdxR2ttT2RxU3FiV04vbE42SlJjUkdHRENNeHhHMzdISFVUeGNBVGo0?=
 =?utf-8?B?SWpOU0ZZYzg4aWZnNXhvQml3d0ZrenRFVm5nTHpEQzJaejZhV2o0NmtQdXZG?=
 =?utf-8?B?QUxjdEsrRUMzNDdCZzlQM0NxeHQ0RUpBSGJoYjZSTnFlTkkyei8wejVoaHdJ?=
 =?utf-8?B?K3k3d0J4anlXaTF3OGs2YjdZNWJkM1F4TnJwSStjNEN4ZjJyamNKQ2d6UGVX?=
 =?utf-8?B?NGpiNGxTRjJvZU5hWHU1QWhzNjNDdXV6K1pPKzJYUWF1bnZMem82dXFmZkRq?=
 =?utf-8?B?K2luWUVFVUc1MWt5WDV2RVZkcElCZktQRER6OVd5T1RrQ3NUUXRrV1dSYS9q?=
 =?utf-8?B?WDA0a3ZpWGFueDZOdVArVUhKZzBmUk9zRDBlZzQ5cXhpd1hHcWNhMkZqYjQ2?=
 =?utf-8?B?WGp6WHA5d0t1NFZxaWFUQTkyZWFDM0YwU1ZJTWh4RnF4STAzMW1waEFOempL?=
 =?utf-8?B?Z1NjR3RUMDArM3BNRzEyMlFYV3JSOE9Xd2xXTEhtbFp2R3F4ZzlCbkUxRm92?=
 =?utf-8?B?WS9DcnJ4dkFVR3l1R3MvZWhScmFiWEVGQk1YZXdwUzJ5RHFMUGV6dlVGWFJE?=
 =?utf-8?B?ZnBmcTVCaVFhL2VuNWZUbnpDNmgyNEEvcW1GOThyczFpRC85ZXMzdjl3bGNm?=
 =?utf-8?B?bkpxcjFRcUJzVDRqbm05NEt0Q25sYTBhTVZUTVZvVHI2UlhWMlJWcFlWTUZz?=
 =?utf-8?B?YkxsS1NIbCt5TUdjM0NKb1BJY05Dc2FDT25NTVN0LzE3dEtVY1pJN2phdVR4?=
 =?utf-8?B?MGU4RXJKRm9nbHFUSzlac0x4czBDQTJOQ1hwaFYvRzdrS0IyZzA4Y3Z6RXk5?=
 =?utf-8?B?QkN5RzZSSGlPdE1TVTZGSk9xTm1oQ1g1UGlzU25VK0xzdzFRdXdoa0J2aDJI?=
 =?utf-8?B?QmlzcnFaVitlUUd5bi9GVzB0THFTQlRXSW56Zkk4VURuYTIxN0tQSFV0WWda?=
 =?utf-8?B?c0RIbnRNdTRuY0FwVWcrVzI2b2VORm91aVpLOGh4STdyeGtNOFRBZXQ1dEto?=
 =?utf-8?B?ajRxcjRQWXJIRXFjd1dMQWZJVkZ6cEFhc2RuRjlOOWQ4T1lqUkVOQjZobDVD?=
 =?utf-8?B?ODczOUxzS3E3NWdlT0ZSNEZFMXZBRkRSQmhQOHJoVTBsbnhFSm8yQ1dmUW9w?=
 =?utf-8?B?MlZieWxoajd6MTVFb01HKzZtN3dmTisrUy95QUpvWHROOVpKeFlBS3l6L0ha?=
 =?utf-8?B?VjhnSytlUzFHWVNna0hSZzRhS0pLTWtrall0T0Q3R0dLckhrSURvNTB0eHgx?=
 =?utf-8?B?TjN6aWQvYnhjeE1NRkZzcHNaSGRTNXZZTXBjUkpCaFBMTDZITXFZYS9ZRTNm?=
 =?utf-8?B?NlRKOE5pTzNvT3ZNcG9WRERmbkxkRkVnODZMRDZra0NCanZRTm8zeHpPNGh0?=
 =?utf-8?Q?7U6cTpScPFM=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6666
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e3019d1f-a2c5-417a-3ede-08ddc6caba48
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|36860700013|82310400026|35042699022|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTVMby8xN1BYVWF6dnI1R2c0ZDNDUHd6SGx6SXJscmozYXJPVTZ5N3g2dFRQ?=
 =?utf-8?B?NW12WU1admZ0Y3QyOVVlVVFPNU9WQW1VTDh2ckFBaG1NcHhiSkJOSWV5cGhC?=
 =?utf-8?B?YWdTQXA1MU8vNzR5M3ZCZFJSNDdhZ3JJNzZCL05URHNlSndwWXNTaWd3T0Vp?=
 =?utf-8?B?UytRZEhFVHFia1k3NkM3b1ZRbE53a3ZhcVlRZDBmSnNDb0tVenVZdU5Lc29I?=
 =?utf-8?B?L2JYRFhNWFRCaDg3RHNtYmtSNEdRZExSZGhQUDNETnJIdzhtRE5ZeXdkcmlZ?=
 =?utf-8?B?VS95N0YwL3NZVnQwTFlpeGRUQ01ScGVHZDlBbnhpZFJSMzdXanh6bmxyYVA3?=
 =?utf-8?B?OVBpbmxsTHlSVWMwMHRiZG8rejdpZG0zdkhQVGpWV0FXNy9HamV3dGp6VTFN?=
 =?utf-8?B?YmdXVTByY0lReHVwNnpLNUpMQ1NEeW01eGR3eFBuRkVDb2toczltR1Y0Wlhr?=
 =?utf-8?B?RkxHMVV0MmZDUFYveko5MnkrcjNBNHY0L2UrQ3llNVBkdjBMSGRKRVlrS3hP?=
 =?utf-8?B?R2pvczhFNGpzeS9IS2VZNktxSVRNZk02NEJzSjdsZzZEanB2dDhFcVY2Vml2?=
 =?utf-8?B?dlkvNjI5aS9US1BoeUxZc3AyYXlVZlorS3RFWkRRVTVFYkxoUzN5TzhreDFu?=
 =?utf-8?B?T29JNU5KT2x3dnlqZHAyZUcvNGdwL21yRFVtMnl6Z2VvY0VtUE96WFVhQ0tn?=
 =?utf-8?B?ME1ISUtRRnQzZ0xROUQ5MVhhTkhHN2hPN2Z2WkRjN3FwQTVENHI2SFJUSk9U?=
 =?utf-8?B?ODFFK3YzbkxSQ1JQUFZ1QkROd1laS3BZaVFrU3k4Ylo4bmVhaXZLYnBqMGg1?=
 =?utf-8?B?UDhaMzJORjdsOUFoS0NrbzEvVGsrWGNEU3BWY2Vyck5IaU1XYmJTWEVrV0tW?=
 =?utf-8?B?M0E3cm9pUFBJUHNEOW9rUkIwS29vRmRIaFk3SmtHWVhmbitmenlnRVh5eUlS?=
 =?utf-8?B?em95Ly9Lc3RnbVZXSU0wblRwU3EzZ3ZPZXg2dE1ZMlZjNmk4VmFlRGlYMHhh?=
 =?utf-8?B?VXo3QlFGdjUyaWs2WG9WU2FRNzlCRFcvbjhwUzZOZTN6bVBrNEFjZDRURlpH?=
 =?utf-8?B?SkdONW5hQzJyaDN6TmpjVnNvMmZveXpXYzR2VWVGcXZxcFVEMEEwMHlqNmRa?=
 =?utf-8?B?TGhoRWZTMU4rNnA3NUt4THU3N0NCS21mUExXZ09aNzhsTDJ1VW9rZzNsTzJw?=
 =?utf-8?B?LzhMcmwrMVRTL3dtSDZBcy95UjdqTmthUUtxN2dWQTRCR0lhTVJiN0ZMWmVV?=
 =?utf-8?B?NjZJWENyb1JxalJaZVBFdnpPZk1UT01WZDJxQ0lXRlNDTGFQN2RCYXBnaHFE?=
 =?utf-8?B?ZDJ3SnNQR2JhektvYUNnbTdOamZKMXlLcDY1Qll5SlVxZndOYWdvODV2cEMv?=
 =?utf-8?B?SVpwaVRubTZLdjF0T3k3UkQxOUFNcENSVFplbXYwQm9xaEVHamVNMk8yeWdq?=
 =?utf-8?B?T0FyT2x1L3V4Y0lGeE5DVkh5cUhxS0RYTEw5V1NFNTBUdEorMmk2aWEwZnVr?=
 =?utf-8?B?THZzMjgzUWw5OTFnRlVQWmYvRkZGZloyU1dFdy9icU1pK3k0QmlaclpsaEdP?=
 =?utf-8?B?Uzc5UTJWTFJMdm5KalBieitHQzl4UjNGRnBZalRIUTAxNHlySVV2V1JFaVBQ?=
 =?utf-8?B?OFEzZThORjBxak5vQ2IwaTBqQUtIT0R1YUNTd2J6RFZtT2ZEUWNJU1FmYUFs?=
 =?utf-8?B?RW8xaDhsejJIZFRMMU5NNERMTWE4dkx6MHdUdHJhK1FhZmVlbSs4MUVDZ1Jt?=
 =?utf-8?B?ZU8wcUhScUJQSy9jRzF4eFNCckNVREJNUTZjbDlYaDZ5Slg5Y0JTWTNOYWRy?=
 =?utf-8?B?RkJ0cFZDaDUzdFhGTUV5TUcxdmoyK0Fwcmt0N0VUNTA4UjgzbTJUek4yK0FW?=
 =?utf-8?B?S3J5QjJQV29tWHRmR0hPRFJxRmdBOHBRWis5SkpIWlZyUm5tWFI0ODUwYmJG?=
 =?utf-8?B?eVM2Rktka0t5ZUh5VjFDaTJEVEd6VUdTYzhPS2RJdXlCdVA4ZXhhODQxc1RU?=
 =?utf-8?B?NzhDRHVaNnRFSFVvRi9QdTBvMlZVeHZmd0liV0FPaEdZZnErSTRXclAzMWlY?=
 =?utf-8?Q?YqAWiM?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(36860700013)(82310400026)(35042699022)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 13:47:30.9336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d643a9-f7f9-4c69-339f-08ddc6caceb7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9443


On 19/07/25 12:19 am, Lorenzo Stoakes wrote:
> On Fri, Jul 18, 2025 at 02:32:43PM +0530, Dev Jain wrote:
>> Use folio_pte_batch to batch process a large folio. Note that, PTE
>> batching here will save a few function calls, and this strategy in certain
>> cases (not this one) batches atomic operations in general, so we have
>> a performance win for all arches. This patch paves the way for patch 7
>> which will help us elide the TLBI per contig block on arm64.
>>
>> The correctness of this patch lies on the correctness of setting the
>> new ptes based upon information only from the first pte of the batch
>> (which may also have accumulated a/d bits via modify_prot_start_ptes()).
>>
>> Observe that the flag combination we pass to mprotect_folio_pte_batch()
>> guarantees that the batch is uniform w.r.t the soft-dirty bit and the
>> writable bit. Therefore, the only bits which may differ are the a/d bits.
>> So we only need to worry about code which is concerned about the a/d bits
>> of the PTEs.
>>
>> Setting extra a/d bits on the new ptes where previously they were not set,
>> is fine - setting access bit when it was not set is not an incorrectness
>> problem but will only possibly delay the reclaim of the page mapped by
>> the pte (which is in fact intended because the kernel just operated on this
>> region via mprotect()!). Setting dirty bit when it was not set is again
>> not an incorrectness problem but will only possibly force an unnecessary
>> writeback.
>>
>> So now we need to reason whether something can go wrong via
>> can_change_pte_writable(). The pte_protnone, pte_needs_soft_dirty_wp,
>> and userfaultfd_pte_wp cases are solved due to uniformity in the
>> corresponding bits guaranteed by the flag combination. The ptes all
>> belong to the same VMA (since callers guarantee that [start, end) will
>> lie within the VMA) therefore the conditional based on the VMA is also
>> safe to batch around.
>>
>> Since the dirty bit on the PTE really is just an indication that the folio
>> got written to - even if the PTE is not actually dirty but one of the PTEs
>> in the batch is, the wp-fault optimization can be made. Therefore, it is
>> safe to batch around pte_dirty() in can_change_shared_pte_writable()
>> (in fact this is better since without batching, it may happen that
>> some ptes aren't changed to writable just because they are not dirty,
>> even though the other ptes mapping the same large folio are dirty).
>>
>> To batch around the PageAnonExclusive case, we must check the corresponding
>> condition for every single page. Therefore, from the large folio batch,
>> we process sub batches of ptes mapping pages with the same
>> PageAnonExclusive condition, and process that sub batch, then determine
>> and process the next sub batch, and so on. Note that this does not cause
>> any extra overhead; if suppose the size of the folio batch is 512, then
>> the sub batch processing in total will take 512 iterations, which is the
>> same as what we would have done before.
>>
>> For pte_needs_flush():
>>
>> ppc does not care about the a/d bits.
>>
>> For x86, PAGE_SAVED_DIRTY is ignored. We will flush only when a/d bits
>> get cleared; since we can only have extra a/d bits due to batching,
>> we will only have an extra flush, not a case where we elide a flush due
>> to batching when we shouldn't have.
>>
> Thanks for great commit message!
>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
> This is looking MUCH better :) Thanks!
>
> Some nits below, but I've gone through this carefully and can't find
> anything that seems obviously wrong here, so:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks!

>
>> ---
>>   mm/mprotect.c | 125 +++++++++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 113 insertions(+), 12 deletions(-)
>>
>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>> index a1c7d8a4648d..2ddd37b2f462 100644
>> --- a/mm/mprotect.c
>> +++ b/mm/mprotect.c
>> @@ -106,7 +106,7 @@ bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
>>   }
>>
>>   static int mprotect_folio_pte_batch(struct folio *folio, pte_t *ptep,
>> -				    pte_t pte, int max_nr_ptes)
>> +				    pte_t pte, int max_nr_ptes, fpb_t flags)
>>   {
>>   	/* No underlying folio, so cannot batch */
>>   	if (!folio)
>> @@ -115,7 +115,7 @@ static int mprotect_folio_pte_batch(struct folio *folio, pte_t *ptep,
>>   	if (!folio_test_large(folio))
>>   		return 1;
>>
>> -	return folio_pte_batch(folio, ptep, pte, max_nr_ptes);
>> +	return folio_pte_batch_flags(folio, NULL, ptep, &pte, max_nr_ptes, flags);
>>   }
>>
>>   static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
>> @@ -177,6 +177,102 @@ static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
>>   	return ret;
>>   }
>>
>> +/* Set nr_ptes number of ptes, starting from idx */
>> +static void prot_commit_flush_ptes(struct vm_area_struct *vma, unsigned long addr,
>> +		pte_t *ptep, pte_t oldpte, pte_t ptent, int nr_ptes,
>> +		int idx, bool set_write, struct mmu_gather *tlb)
>> +{
>> +	/*
>> +	 * Advance the position in the batch by idx; note that if idx > 0,
>> +	 * then the nr_ptes passed here is <= batch size - idx.
>> +	 */
>> +	addr += idx * PAGE_SIZE;
>> +	ptep += idx;
>> +	oldpte = pte_advance_pfn(oldpte, idx);
>> +	ptent = pte_advance_pfn(ptent, idx);
>> +
>> +	if (set_write)
>> +		ptent = pte_mkwrite(ptent, vma);
>> +
>> +	modify_prot_commit_ptes(vma, addr, ptep, oldpte, ptent, nr_ptes);
>> +	if (pte_needs_flush(oldpte, ptent))
>> +		tlb_flush_pte_range(tlb, addr, nr_ptes * PAGE_SIZE);
>> +}
>> +
>> +/*
>> + * Get max length of consecutive ptes pointing to PageAnonExclusive() pages or
>> + * !PageAnonExclusive() pages, starting from start_idx. Caller must enforce
>> + * that the ptes point to consecutive pages of the same anon large folio.
>> + */
>> +static int page_anon_exclusive_sub_batch(int start_idx, int max_len,
>> +		struct page *first_page, bool expected_anon_exclusive)
>> +{
>> +	int idx;
> Nit but:
>
> 	int end = start_idx + max_len;
>
> 	for (idx = start_idx + 1; idx < end; idx++) {
>
> Would be a little neater here.

I politely disagree :) start_idx + max_len is *obviously* the
end index, no need to add one more line of code asserting that.


>
>> +
>> +	for (idx = start_idx + 1; idx < start_idx + max_len; ++idx) {
> Nitty again but the below might be a little clearer?
>
> 	struct page *page = &firstpage[idx];
>
> 	if (expected_anon_exclusive != PageAnonExclusive(page))

I don't think so. first_page[idx] may confuse us into thinking that
we have an array of pages. Also, the way you define it assigns a
stack address to struct page *page; this is not a problem in theory
and the code will still be correct, but I will prefer struct page *page
containing the actual address of the linear map struct page, which is
vmemmap + PFN. The way I write it is, I initialize first_page from folio_page()
which will derive the address from folio->page, and folio was derived from
vm_normal_folio() (which was derived from the PFN in the PTE), therefore
first_page will contain the actual vmemmap address of corresponding struct page,
hence it is guaranteed that first_page + x will give me the x'th page in
the folio.


>
>
>> +		if (expected_anon_exclusive != PageAnonExclusive(first_page + idx))
>> +			break;
>> +	}
>> +	return idx - start_idx;
>> +}
>> +
>> +/*
>> + * This function is a result of trying our very best to retain the
>> + * "avoid the write-fault handler" optimization. In can_change_pte_writable(),
>> + * if the vma is a private vma, and we cannot determine whether to change
>> + * the pte to writable just from the vma and the pte, we then need to look
>> + * at the actual page pointed to by the pte. Unfortunately, if we have a
>> + * batch of ptes pointing to consecutive pages of the same anon large folio,
>> + * the anon-exclusivity (or the negation) of the first page does not guarantee
>> + * the anon-exclusivity (or the negation) of the other pages corresponding to
>> + * the pte batch; hence in this case it is incorrect to decide to change or
>> + * not change the ptes to writable just by using information from the first
>> + * pte of the batch. Therefore, we must individually check all pages and
>> + * retrieve sub-batches.
>> + */
> Nice comment thanks.
>
>> +static void commit_anon_folio_batch(struct vm_area_struct *vma,
>> +		struct folio *folio, unsigned long addr, pte_t *ptep,
>> +		pte_t oldpte, pte_t ptent, int nr_ptes, struct mmu_gather *tlb)
>> +{
>> +	struct page *first_page = folio_page(folio, 0);
>> +	bool expected_anon_exclusive;
>> +	int sub_batch_idx = 0;
>> +	int len;
>> +
>> +	while (nr_ptes) {
> I'd prefer this to be:
>
> 	int i;
>
> 	...
>
> 	for (i = 0; i < nr_ptes; i += len, sub_batch_idx += len) {
>
>> +		expected_anon_exclusive = PageAnonExclusive(first_page + sub_batch_idx);

We won't be able to do nr_ptes -= len with this. And personally a while loop
is clearer to me here.


> Nit but would prefer:
>
> 		struct page *page = &first_page[sub_batch_idx];
>
> 		expected_anon_exclusive = PageAnonExclusive(page);
>
>> +		len = page_anon_exclusive_sub_batch(sub_batch_idx, nr_ptes,
>> +					first_page, expected_anon_exclusive);
>> +		prot_commit_flush_ptes(vma, addr, ptep, oldpte, ptent, len,
>> +				       sub_batch_idx, expected_anon_exclusive, tlb);
>> +		sub_batch_idx += len;
>> +		nr_ptes -= len;
>> +	}
>> +}
>> +
>> +static void set_write_prot_commit_flush_ptes(struct vm_area_struct *vma,
>> +		struct folio *folio, unsigned long addr, pte_t *ptep,
>> +		pte_t oldpte, pte_t ptent, int nr_ptes, struct mmu_gather *tlb)
>> +{
>> +	bool set_write;
>> +
>> +	if (vma->vm_flags & VM_SHARED) {
>> +		set_write = can_change_shared_pte_writable(vma, ptent);
>> +		prot_commit_flush_ptes(vma, addr, ptep, oldpte, ptent, nr_ptes,
>> +				       /* idx = */ 0, set_write, tlb);
>> +		return;
>> +	}
>> +
>> +	set_write = maybe_change_pte_writable(vma, ptent) &&
>> +		    (folio && folio_test_anon(folio));
>> +	if (!set_write) {
>> +		prot_commit_flush_ptes(vma, addr, ptep, oldpte, ptent, nr_ptes,
>> +				       /* idx = */ 0, set_write, tlb);
>> +		return;
>> +	}
>> +	commit_anon_folio_batch(vma, folio, addr, ptep, oldpte, ptent, nr_ptes, tlb);
>> +}
>> +
>>   static long change_pte_range(struct mmu_gather *tlb,
>>   		struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr,
>>   		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
>> @@ -206,8 +302,9 @@ static long change_pte_range(struct mmu_gather *tlb,
>>   		nr_ptes = 1;
>>   		oldpte = ptep_get(pte);
>>   		if (pte_present(oldpte)) {
>> +			const fpb_t flags = FPB_RESPECT_SOFT_DIRTY | FPB_RESPECT_WRITE;
>>   			int max_nr_ptes = (end - addr) >> PAGE_SHIFT;
>> -			struct folio *folio;
>> +			struct folio *folio = NULL;
>>   			pte_t ptent;
>>
>>   			/*
>> @@ -221,11 +318,16 @@ static long change_pte_range(struct mmu_gather *tlb,
>>
>>   					/* determine batch to skip */
>>   					nr_ptes = mprotect_folio_pte_batch(folio,
>> -						  pte, oldpte, max_nr_ptes);
>> +						  pte, oldpte, max_nr_ptes, /* flags = */ 0);
>>   					continue;
>>   				}
>>   			}
>>
>> +			if (!folio)
>> +				folio = vm_normal_folio(vma, addr, oldpte);
>> +
>> +			nr_ptes = mprotect_folio_pte_batch(folio, pte, oldpte, max_nr_ptes, flags);
>> +
>>   			oldpte = modify_prot_start_ptes(vma, addr, pte, nr_ptes);
>>   			ptent = pte_modify(oldpte, newprot);
>>
>> @@ -248,14 +350,13 @@ static long change_pte_range(struct mmu_gather *tlb,
>>   			 * COW or special handling is required.
>>   			 */
>>   			if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
>> -			    !pte_write(ptent) &&
>> -			    can_change_pte_writable(vma, addr, ptent))
>> -				ptent = pte_mkwrite(ptent, vma);
>> -
>> -			modify_prot_commit_ptes(vma, addr, pte, oldpte, ptent, nr_ptes);
>> -			if (pte_needs_flush(oldpte, ptent))
>> -				tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
>> -			pages++;
>> +			     !pte_write(ptent))
>> +				set_write_prot_commit_flush_ptes(vma, folio,
>> +				addr, pte, oldpte, ptent, nr_ptes, tlb);
>> +			else
>> +				prot_commit_flush_ptes(vma, addr, pte, oldpte, ptent,
>> +					nr_ptes, /* idx = */ 0, /* set_write = */ false, tlb);
>> +			pages += nr_ptes;
>>   		} else if (is_swap_pte(oldpte)) {
>>   			swp_entry_t entry = pte_to_swp_entry(oldpte);
>>   			pte_t newpte;
>> --
>> 2.30.2
>>

