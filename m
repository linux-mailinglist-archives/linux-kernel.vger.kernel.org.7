Return-Path: <linux-kernel+bounces-777474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C2CB2D9DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEBC1175C59
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C3D2E0401;
	Wed, 20 Aug 2025 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ErORNK9N";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ErORNK9N"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011054.outbound.protection.outlook.com [40.107.130.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80141FF7D7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.54
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755684847; cv=fail; b=f3H7jxYhXMFxqfRTPFsbR8XHH45bJN8ZskVJYXEG0/+NIpKgDhsMzuZRf2CCtteP0CEt0rKx44lpobaBzT7ZU8A/sE0ydNUa78PJW4tPBDPsch0WcDwv9/ONDNWWPc9iZtPJAzMDqvmcz/p4K7FYgA+IBhudimtvlEZTDDS9Mok=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755684847; c=relaxed/simple;
	bh=PBbLyPNc4r6VrLUBG+Nlb2wlUDguZyEnL33o0qvCOlc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a8cZpa8HvquAsB/Iw9SuKOK+cqZUusBEn17K0URq0Ae/g4cOnPQpn4uzFQxJtR+C7mctaVUgMaE0aFEZADfsR+5d67+AHwxzGdSoKOlyy4w8mgGviFbqlyFV57f8ebONi3UHEfixyDP5KZdTDjVC4vylzD7LHjAB9SbxsFBRm7A=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ErORNK9N; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ErORNK9N; arc=fail smtp.client-ip=40.107.130.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Wm2Z1WVubQkKUL8f0ONDVAQ+9XEuVphw5jCjwaR20JHJapJFjtMwzUh+uNdB1by2O5PXkA5umRY7nUfmgUmPTEE5XtesPWR7EBSvOjmo6ahsqlpIo9AIWSe/AS0h13vE4/E19nyDA4XqwbIVXIdmXoQKcTqd4h8ZUBB+D27ULYDmk0okzAXft4Rg5738t4Q5dWkZp57SgrjsWAHY/urnch8u9Y3HF6z5vZHCpZTjRi18IL6a6PBKp07snBfSIEKuQBbeu9d/Sfl33nUS44G70zBcZ5CejrfzxjJYY+uDlXQZxZgXb3Pys7WdyOWBAxpoAxqWqD4Hbxs3x6QFlazyxQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wx7RCumOnJl429mMKmZy4E6vsTe3kfEIZkgMFcw9Em8=;
 b=d9O/QjBrBzlx85q/ARHMpnjusYC/Wk7sOb7mTuO+SpUr3GZFXKQ84vNZPZXoI1W2xP/s+T+ngrqnutWtVNj82JUXFmQKYlidmQXi1MwmqvRIVpEU4U6D2zcsZbP/Q6xy01QziA8zT6IBomn7jGn4d1saIt6e3VUIuDQAddf6YFm69f/DeIVr0o94v2heJMKMxtI670IoHvYn0j0x38xQDjKv7QcFsqRkEw6dhZ0ZI1gs4pi8xE5vQYqr2edXvch/P+9u74VhvOKuP4nURs3GB7X48RB07cnPS5e6EilPwcQil6QFFTBS4OQ8htpMZgBSTXR9MVDM1geEWmDUErh9Ug==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.alibaba.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wx7RCumOnJl429mMKmZy4E6vsTe3kfEIZkgMFcw9Em8=;
 b=ErORNK9NVWwuVTiLuPclYHgkNOxRQv7NghXJV0HoG4/YTw/IVr6yl4WcGCaM4woOmdsS4ovxPxOvcW34u3RhRRccEFqeEaWSWZ0GIkf0fz+FM3s8dEQ8MrUNHSbutRy0iolZCrOcSidQ0YN20UT8uR4QVtGjeStj2eHvkyGI/Jk=
Received: from DUZPR01CA0348.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::7) by VI0PR08MB10758.eurprd08.prod.outlook.com
 (2603:10a6:800:1b9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 10:14:00 +0000
Received: from DU6PEPF0000B61E.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::18) by DUZPR01CA0348.outlook.office365.com
 (2603:10a6:10:4b8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 10:14:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000B61E.mail.protection.outlook.com (10.167.8.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Wed, 20 Aug 2025 10:13:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLBPZaF/LXv+IVtu65II0rbLChpwpSuBsv7q4gjXVIpU+sgDaUjJnRkCcmJS4uoWFOX9vroBbIQtYr0GIRJ19uzUOWXfvgP99RLXIuhMoKOU57DQNUFRONBgvy4OuSG0GzZPqHmIMNrBXxhDE3WazeB+M3k/k8P3if4G4pBp3R8T+Q32FGzk+MatY7zaUKJq+e9MFVV75e3/8Iy2MJ1ICLwGBdItnZ0LSyw9WV8g5ntOUVN91bqauCkGKSh/uUoJdlUl6MXiyWwfHbtKkn8BpB12A8mTPX482BjqY/dDEt5fE9mLilpm/rkhow99RJDvuJ/EWoiFA4lCaDvrE1Ecxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wx7RCumOnJl429mMKmZy4E6vsTe3kfEIZkgMFcw9Em8=;
 b=Vpz5yudFS6hI+NVngCaq34f4j78aMq9HqZgncFAm6yGro1EdPI1sM1tSHKXBm425zfdJPJuwx9uJFAHBwVBkODG7BpY+t3Ymxd17CK+vpNyIqwVX/4O/WfEY3XcMsHyFNxwrws+b/esBCWg5AndHo4ZHazYyuTBN6/jwyWWFD68aCVTolLIoVBVkzfmOZpBO+lTMQu+6BbeTyFzh1zqI2oZwUp36YG2r58uy2duowyGgpx6PUmd5ex16HX0oLFxo4ZNqWljuwsqj9BoBp9OlgHOwsMM/VpRmyhRoAkxMmclfzC2hLiE6KP5ZPd3Fn+nOx9oxUTQl1ZZ3Z/ospUaX5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wx7RCumOnJl429mMKmZy4E6vsTe3kfEIZkgMFcw9Em8=;
 b=ErORNK9NVWwuVTiLuPclYHgkNOxRQv7NghXJV0HoG4/YTw/IVr6yl4WcGCaM4woOmdsS4ovxPxOvcW34u3RhRRccEFqeEaWSWZ0GIkf0fz+FM3s8dEQ8MrUNHSbutRy0iolZCrOcSidQ0YN20UT8uR4QVtGjeStj2eHvkyGI/Jk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS8PR08MB6085.eurprd08.prod.outlook.com (2603:10a6:20b:294::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Wed, 20 Aug
 2025 10:13:25 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 10:13:25 +0000
Message-ID: <9e816c30-8ce9-46dd-99c0-e747df445be9@arm.com>
Date: Wed, 20 Aug 2025 15:43:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/11] mm: khugepaged: add khugepaged_max_ptes_none
 check in collapse_file()
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com, david@redhat.com, lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1755677674.git.baolin.wang@linux.alibaba.com>
 <aa2db6af6bb2124ef59ad5665951e47806c00a6e.1755677674.git.baolin.wang@linux.alibaba.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aa2db6af6bb2124ef59ad5665951e47806c00a6e.1755677674.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::20) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS8PR08MB6085:EE_|DU6PEPF0000B61E:EE_|VI0PR08MB10758:EE_
X-MS-Office365-Filtering-Correlation-Id: dfbd8093-ba18-4578-7bb8-08dddfd24787
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?U3hDVWtPN0FHUUpSSFBkeVl5VHpqcVYzaUFhMkRkeVArVGIxbzVBRGljQUF6?=
 =?utf-8?B?L3lxaEc3WHl3M01QSEFZM2lsdlA5aTlORU9Nd0xUN1pWWkxFMW5jSmNVSEln?=
 =?utf-8?B?K3Z4NUFKSDM5dHdDMzk3VW1obXNqRUZyRHFCbnYrbWl1STZaTzRudGFQNTNN?=
 =?utf-8?B?UTdCS1E5ajZQWnVKQ3NNUGh3SWZpL0I4WGM4K0ZsSmJGMVZvTWV6NUNPclJq?=
 =?utf-8?B?MjJXM1BWeWU3cnFsSEdVbHZlRXIwRlJ1ZSthQlFadFNJRGsvUnFnS0dsTUpE?=
 =?utf-8?B?Vkc2QzM0akxjQzRQQktoRElNcUQ5QllhRWFuZjNmbHN0NkZqWlQrNUI4THV5?=
 =?utf-8?B?SEgvZEhFdjN2bTRRQ3pWRDhUYlQvWmRrUTBxSmcvbnh0MnJFblpOZHpmMUV3?=
 =?utf-8?B?V2wyUFZrNVM5aEV5eGVSM3NYUUNyUjBTTWtKb0ZNVnZ4czMrbXVFYnJjOTVZ?=
 =?utf-8?B?QVVhNTFxRHEzNkNaek5UQUhOQ3Y0UE5QVzF5SWF2MkQxeUVIYXN5WlkrZEtX?=
 =?utf-8?B?RnRuU3Q0MWNNY3VGOURwNGhqakg0Z1NFcW1IdjYyUzVGd0R0STgvMUxTUlQ5?=
 =?utf-8?B?UDlybTVsZXl3dzFIbnBpZTFDM3VESEl3SDFZbjltKzZWSzNkWTI4RFFFakxl?=
 =?utf-8?B?dWZDSk9EaEw0TWVabjVMYmRRRDVxR2xqZGgxajNpa1B3NXRkNGsrTUNiTFVO?=
 =?utf-8?B?ZFZoUFFOY1lqUXNDVkg3R2VabUhtdHRESjlIemYyQTNtRi8wQnk2ZFAzYTNn?=
 =?utf-8?B?VlNoZVI5S2dvVmptOHlLdXhZRFAxdUVubjhWVzFjbDZhVTNhT2NudHQvL2dq?=
 =?utf-8?B?WXBzK2pCOHlsMXkyNmwrSXJjSGw5MjVXd1JkSEs0ZCtuemUwREJ1OXovRzJu?=
 =?utf-8?B?RTdFaTR2amhSR08xV1B1OC9iR1NtOGhEd1BRNkZjYlJyT21JMnFKNUtmNVo2?=
 =?utf-8?B?dmRpdnFYT0VodDJBcXZBcVFPME1mNGRQek5oOTJoRjJmUnFNRklyQ0tXR1oy?=
 =?utf-8?B?RGJoZCtFM2JrRW5Gc0ozS2NFRkpsZ3Y1QjFwNElaeWxvY05mWnVrNi9EVXdj?=
 =?utf-8?B?cDJSVEJaQmQ1NHRVSnhvK2JJVlpiR3lrVFplVXpaVVM0T2J2MnM1RHI0OGdR?=
 =?utf-8?B?TGVzZGx6aytqVHBUK0ppUUhJZmRjcTArTGplc05EOFFMNFJxRVRBV3RwZW9x?=
 =?utf-8?B?TUw5MFB2YU5mcFlzczVub3NGTHNJdGVseE1DTTFGKzB1cVdZb2dLUTAra01v?=
 =?utf-8?B?bWJlZmJ4T0xyTExkSkw3YnRpR0JvR1F1T2duZ0hpbGJiMG1pUnE5MzNPTm9m?=
 =?utf-8?B?cis4OEFDY1JnclZlSUNCV29ORXBvMUlJYTl4TUNrWmpJbmlvM0hsUGZDYlVq?=
 =?utf-8?B?ZjhUV1EwSWhSSHFrd2NnNVhFaXA3amtWQW1KMUUyZjN1TWVCRUFaS0dBTW5I?=
 =?utf-8?B?dFVGL0QwQ3Y3NHYzSDREalc1U0Rqa0owTndoWXhpMVRiMzQ4cmQwcmVPeFRl?=
 =?utf-8?B?SmtnQkJpVEtYNFQ2UlMyMlpvMVJITmxNQ3gwY0tqM0RaclFodEt1d3VVMExR?=
 =?utf-8?B?bXF2UC9BUTNCQVdkRWwyRVVITXpwSGNZcVlyWlAxUFEyRnJjZlczbnArYldX?=
 =?utf-8?B?cElrRGtsUS9RZ1Rzbk9CWXFwMDZraFRCdEl6U2lEaW1yV2hULzVQcjcxQzNZ?=
 =?utf-8?B?YmtXa2Z1b0RqZUpta3pRdkNtbGxqTis2Q2tEZ2JKRGhiY3hoTndESTllZTZS?=
 =?utf-8?B?UDBwWlM5THN2UGZlSlB2M2VyYUhVdU5EN3owSjJtd0x0L3NtYzJIZS9rc2x0?=
 =?utf-8?B?aFczVmVxeWZBMDgveXdqTCtWY3hYRHVObHpNM0VjRllLN0VIUEVUdmdJcUps?=
 =?utf-8?B?eFNwZGVabGtMSm5admxiaXk2eXhkaG1MUmk0QzlyTEozVWc9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6085
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7f8e9a7b-8a96-40c4-0dd8-08dddfd2337e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|14060799003|82310400026|36860700013|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUVXSUN1K0ZlM2pxL2pITm1kQWpwTDdGZ3VMajd1cncxdmdLb3E0RGFWejFD?=
 =?utf-8?B?MmZlblIxZisyMFNlZXo1Ty91Y2pUcjFyOTJYVTI5b0M2blQzM0lsbDJuMVBQ?=
 =?utf-8?B?Z0JNQ1NiaHo1YjIvMytBYldoMUhxaTNOUWg1aFMwVDlsWWdFRnZLeWw2cWM5?=
 =?utf-8?B?L3kyY1ozdU1mOE55NU1melB3bWJNVXI0U051OGVjR3BVdmJseXhqUkJLaG81?=
 =?utf-8?B?eWR3MWNXZXFhRTlPaktINWNKRllseU5paExhSStxUUkxVGlqdXhDWVFzWjg1?=
 =?utf-8?B?emcvTEtrY0FEYjRWK095VjE3cnN5OVl2Ti9naVkrOHRjUlc5ZmZtTE1IOGJj?=
 =?utf-8?B?NWtON2tXMjNYdnBONC9Eb05UVnBqMlBOSGp4Q0Jsa0JLZnRZVTcwa2JOMG5M?=
 =?utf-8?B?ZU5Ed21GcE5NZnRlUVRIUTBGTXlPenBMR0VYZ2lqL2Q0MDZKMCtoVEpwS1hT?=
 =?utf-8?B?L1IvUkRycGdWa25XNmFWdW5INVpGamNYNWdoejBna25yYWc2WkZkd2tBL2Jn?=
 =?utf-8?B?UEdMMjJ3S01yR21MaVNjUzd6WHA5clhkeGtnSkJRTkI5TXdrVFJNS3dVSWFQ?=
 =?utf-8?B?M1dubzh1ZmhaT3lwTFdneWV4eDlCdk1uY3d0eWRUeWlGT1J1VkFobUtSTC9B?=
 =?utf-8?B?VHdYSXl0ZFhranFLSTZuM3UydndEbHZkSXFqamZjam5Wb1lodmRzRTFXcXRq?=
 =?utf-8?B?YlU0NzZ0OUs2Zjltdm10SGp3NHgweUd3ZE9SRnkyQ3FLNDNxME1iQXAyTEZ0?=
 =?utf-8?B?UHVTZW5pL3ZnZ0lFUnh0MjJsSy9DYnUvQkxTRmRYR25EWlUra00zV0ZpTWI4?=
 =?utf-8?B?YTRPRURnUmlRVGRtSHJ3UERBdWdUMlVlVkxINE9WWlB4WXRwdEd6MXIrOS9q?=
 =?utf-8?B?akU0Q0xUTjlOOVVzZW93cEx6dER5b240eDB6VHFxVkxyQi9yOEIydHcvMjFG?=
 =?utf-8?B?dDZYUVJNaU5QZ3lNYlRVOStySkViTU0zREFXZU5zR1Z6UWRQQi93dTFJeXIv?=
 =?utf-8?B?VEhJSEdnVWlTTUpUd3hnTzFtLzNOQjVzSlFHVnI1WFRaSWZiNkJ4SlFiOEh6?=
 =?utf-8?B?WGp6SXZpTTJIVFlTV3RiU0dhaVdCOVl2VGc5TGtNVmJTV3BBb2I4RFBrTkpZ?=
 =?utf-8?B?cDUxZ0o1SHVQRHZ0K3c1eUhJam5RZndUaXkyWWhQSUJBUzh1cWhrVWtiWHRH?=
 =?utf-8?B?K29rRU5BZ295TzJRVmgweXVScGhycDVQVjB6ZTZDQ2NmQmlyTmVtTzJpbVli?=
 =?utf-8?B?czgwL1p6SzJlbmRGRE8vUHd0U0Vkb0ZEQ0dRZjZzRTFhLzhNQTkzeE1mVHF2?=
 =?utf-8?B?aWhmQ0hIWHRuZEJWdXdRbVQrdFU0M2w2bjV4N0ZLamRCTldIZVpMUkQza1VI?=
 =?utf-8?B?SVFPeXpqWndOQzZrdUVpb3RzODI5czlmREtOYmtLa29tS1UreHo2cWNPZ2Q2?=
 =?utf-8?B?QXRmb1huRjRCMlk2aWtrZnJsWXhGdWR2SXZLb2Z0eXBweHB3czRTN1htSDQv?=
 =?utf-8?B?dEEvdEE2YmJoUFpIejV6VzVBWkNScEp1OE55VnNNbGNQeDBRQkJQZEdOeWNl?=
 =?utf-8?B?YnRNRXN0b2tTZXpHb3hUYWRSbXRkVFdDUDBZejFVNzJMNFozL1Iya0t3bi9H?=
 =?utf-8?B?N0JBbHhxM09ybEFNNW52N2hhK3lhV2tQbXkycUdOUHp6amRxdjZ0cHZBMHI5?=
 =?utf-8?B?ZWRCVkpieFRjYXJPMUs4SkQ4VStZNW5HRDRzZEp3bUlwSFd3cHI0bTFFZ3Fx?=
 =?utf-8?B?R1RJcDVqV1hiTTA1aFRQd0FlRzIydmZOREFTTXJlcG1nc0JwbVpxbVZnTkMw?=
 =?utf-8?B?MlZSVUpuU2xsZWc1V3ZOZjJiYjY1VW9kMkdzVVhNRkE2TjNRbFhWNzRBbkJZ?=
 =?utf-8?B?TDlLaVZOOWViUm1nVXVmZ1E3c01ZMzEwK3NNYXVmSjNOZDRqZDhuaHJtdFUr?=
 =?utf-8?B?dzJxcmFOWTVSNTFWOWtZYTZXeXhvL2RZemNlS1RGUUF5RUs3R0tTdjRXemdw?=
 =?utf-8?B?ZW5tdjRaOWxNckFzUlBkN0ZUdDAwVVRhQlpnbDN6Qi9GRTdvZ2s0Vk45cFFI?=
 =?utf-8?Q?8qN3a3?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(14060799003)(82310400026)(36860700013)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 10:13:59.1642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbd8093-ba18-4578-7bb8-08dddfd24787
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10758


On 20/08/25 2:37 pm, Baolin Wang wrote:
> Similar to the anonymous folios collapse, we should also check the 'khugepaged_max_ptes_none'
> when trying to collapse shmem/file folios.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/khugepaged.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 5a3386043f39..5d4493b77f3c 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2125,6 +2125,13 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>   					}
>   				}
>   				nr_none++;
> +
> +				if (cc->is_khugepaged && nr_none > khugepaged_max_ptes_none) {
> +					result = SCAN_EXCEED_NONE_PTE;
> +					count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> +					goto xa_locked;
> +				}
> +
>   				index++;
>   				continue;
>   			}

Isn't this already being checked in collapse_scan_file(), in the block
if (cc->is_khugepaged && present < HPAGE_PMD_NR - khugepaged_max_ptes_none)?


