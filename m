Return-Path: <linux-kernel+bounces-739987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFAFB0CE3E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE51164E22
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B5D2367CB;
	Mon, 21 Jul 2025 23:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="odPAQllk"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C09F2E3716
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140865; cv=fail; b=X5KEzrOtPjlh7yutCbPa4FUMvSVB2TX+Uo9UOY94IsFZM+VaG1cL7mpWrlRvW4Fd1hGPQ/WjMDj9JbkidLTfKYKacoDexs4TeEpXRELZaGzEYXE83Ftnb8ccq/c1bHoKCxFV7aMxYv2zsh8CDghXinu1slujmLqFWQ1VIBsVpIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140865; c=relaxed/simple;
	bh=k/tPWULy9sDVB0WJCwBTBlBcE35llCGIjcDtXsh5G50=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LZdMwWQY2b6vuiYjLKlpvbKJSHvXcUWdkOxFocJ1o2LqTLWrWNYnuFtKKMQItNMMtO+GwKHGQ72JIdlo8LtPJp7XiZB3hC7sLmkcmmDIJCXbALEibxrzn2YZLze8qmLZnlfXMSuCz3wgRtNvlmpPyV3vR2JI/Dooqa8/ADOEV6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=odPAQllk; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmPZqz81/SbS9fx83ONFi3R+av9bRGSdo3B0QdMHsuZKinRx8gjU2h1zxfMQLlrMOWBsr8OwQS6CzXnrBA0tdmfUc7Iwp9eEvUNuBbOIlLHyKM96UXDcX/hBvtbmfSw3crrP/DTba7lFBaiO4O5oXmjbTqTZEYVrz0yqRxYSznD45D2tqVy/nvZEqujMqg7FHBem9rz61klEu87smSWLLiO0OUZZnQOAZx2PSLFoi/PHlLMKI+eL6kfZj4OH0/JBXqTlZBFmk5yQ8fOKn5s0f8h1lTHB7zEN53MKAOnQN/OImJkRtu8dzjoji4biCVuRybx9x6gLvXaPQwvgOl2INw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuaZJz0DmpswwJe8ZsUzr+HUOIdIqypVE+67RMHhgOg=;
 b=jeFsn7R473lApd6v0BkWRvZuQfakgIRbs7vR7YP5B75ew+8Ava37ILS1LMzSqlv1iaXMWJLPgc/o3mNeQogw8giojnQtQYyZhxBg8NstIGZwMeXROd1r1Pl3XKCvkT73nC67GCmUOcdlh1Hk+7+77fnqJlYZUUdUWfQrBDKiU3GSSjcN5DoRLaEMyVKDKSqufH9QGLbHcawE5F6SlSq2XdDbkggAPmGZ5AAqm7FvykOeEeJqT69Hee3OPx+qk5r2JnACBZpalCf8E1MazZ0aLQAGVX3dJa6bkpB0vs/EKWFArQHXhtvCWB7ZogtBMNA9Dqem34vGVUYsxgnPqt2dYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuaZJz0DmpswwJe8ZsUzr+HUOIdIqypVE+67RMHhgOg=;
 b=odPAQllkqlCcBQ6TrKQjxmQsm3bJpdMvTCi0oakULN4LNU3vXFAp0cOViF/qnEer9NlDULr/0+cytHF0Am5amLTrqgYPwEzWF1em5hHC+b010R0UREjMWDIpA7uSbGmwq4qSoIGTd1w+B3JLM54QzzUJ7ez4mh4JHbQ5lGG76rxJ7M1VGAoOPtmrpgkL99NReKcudhRjGbnkQJVhXd6sLyWdbW0v++RL0jwrPDvqWCAHNG6AYltQIKNJYwi7uA0li5yvi+1E2RjKoVbYEPs1yG7HlmIpvl9OLDGy6L4Npzz+Zg3Uxi3lVMnf3pc87Z02gC/tH45rSW3z6nHnkpy6SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 23:34:20 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 23:34:20 +0000
Message-ID: <9ae3e014-c7d0-4d58-af0e-925bcd9e4cfd@nvidia.com>
Date: Tue, 22 Jul 2025 09:34:13 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 resend 00/12] THP support for zone device page migration
To: Francois Dugast <francois.dugast@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Shuah Khan <shuah@kernel.org>,
 David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>,
 Alistair Popple <apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <aHmJ+L3fCc0tju7A@lstrano-desk.jf.intel.com>
 <09c5ce76-f7c1-41c7-97e1-74448e6143f7@nvidia.com>
 <aH4nibzGVLiPE5-4@fdugast-desk>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <aH4nibzGVLiPE5-4@fdugast-desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0177.namprd05.prod.outlook.com
 (2603:10b6:a03:339::32) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|CY8PR12MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 187e930a-5663-48a2-9598-08ddc8af1da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTYxWDFmY1NQakdSQjRmYjdJRzFoVFFId0RFdXdiZmhtL0NOZ2g1L1JBUE9q?=
 =?utf-8?B?Mi94S3dTaERsZTk1OERiZEpIYU8xalJXVXhPZW81OWZPNXYyQk9welJFZ01K?=
 =?utf-8?B?aVdOYVdwUENHMitOUVZSYUo4ZDlNTmg0K2x1MzM1YXR0UzlwZlIvV1NjM2NM?=
 =?utf-8?B?cVcwMjl5VXpjY2hWWVpwK1cwNTNSVndIVzVSMWFFaGw2KzFtcnRpTXBrUnJJ?=
 =?utf-8?B?ZW9Fdk1Kak94U2ZVYldFMGVIWWFPZStIOCt6UHpBcFpIY3B2UksxTVFMWGJS?=
 =?utf-8?B?R204MDBIaTFma1l4L1hjaEdrbEh1cHlWeGFPalBYaEhweks2NG9VVlpxd0xv?=
 =?utf-8?B?WUZWcHBTZ1JoQlhnT3FHMVVMUTBpdmtEajdiaGpQOVlrQXM2M0N2bUVQQVY4?=
 =?utf-8?B?VnptaHEwL3FkNjRYREVmQXkrSEJhS3kwL2xhUW1JUWdJb0lBaWF3RnlBcEd3?=
 =?utf-8?B?MG13RUNwVjJ0b1A3SUZOb1dhR2g1dzhZTXFQR0w5S0g4QjJOV2pTaTBGQS95?=
 =?utf-8?B?YUgwQXpLNUNZZGxsWVJxTEVubmowZGRVUWdKQzRubDhzc3lxelFrMzV6REdU?=
 =?utf-8?B?K0Nqd2tQaURsN2d4cmNaUmFXaDU0cEM2OEg1VDlReU5YcHg1cWc2RlZRVFpy?=
 =?utf-8?B?cjZOOG5pVXhFR2s5QzhrOEg0V2pnSHZzTmtDQ1pQYlVGbzNrakJyVXhuNnk4?=
 =?utf-8?B?cUZ4bVdjS3RvWUpxYXpIK2hkZEtEYmpKeitPR3d1cEs3cHpDVmljd1lQc3BF?=
 =?utf-8?B?RGNva2xGZEVxTFZuMmJ1RkMrY2VMVUNVdkhVbC95TkFGdzZienBORlBaQlV1?=
 =?utf-8?B?QTlycjhzN2Q5OENmVGx0STdNNVVyMUlKMjAxU0ZUUngwVmRpdVg4b0NWUFQ2?=
 =?utf-8?B?VWJDeXlldE1ibHVIRmFBQWRHQkhMN2s3U2ZrUXlqWFFZT2RqOU80QVBTQ3Ex?=
 =?utf-8?B?dU1UejdHbDdzK0NjV3E1aUo1UXVtaGNDOTIrRlBmeDUvUEUyZjg4cUt3cXpB?=
 =?utf-8?B?ajJzTHovNzlkSjRMcnNxczVjYTJBWWJRNm8wdmlhanN3QUNRUUtUb0xoczBo?=
 =?utf-8?B?TU91bWpudkF1WkJDeDFERGw4TFp6ajZsbEUyOUFqaEV0anFmYTFyQjJWTlpP?=
 =?utf-8?B?aGRtcEtIRkVUSmR0Wi9TNEMrQTU4eGwvbC8wcFVaQ2tka2dZRTdTc2dkbSt2?=
 =?utf-8?B?NFhHUzdlTHVaQlFFTE5FTkx1dVhkbmIvdTZJMVMzTXMrNnZxcmUvSmJoN25Y?=
 =?utf-8?B?dmN2ZEdrOWR3Mi9qSGpPQ1NxeFdTY3k1ZDFTNVZGRG1VUWpCTFUvWTVXODhs?=
 =?utf-8?B?U0UyTEdZOVY3b2JoMTczbDBTTHZscmthNzdoc0FwRjNVUy9pKzZJay80NzVR?=
 =?utf-8?B?ZEg0K2MvNjIyMUgxOE1NeXIxV3BKN0xQLzhXQXFqTGJWZVdRd3V3amxaT3Ir?=
 =?utf-8?B?eDJoWmJmMy9vMGFMN2FvWWlFY0V6RkhORGxndkJYZ0JjbFo1L2lVbGhsSloy?=
 =?utf-8?B?Rmk3VStEaDJ3VW5LaVRUb2MyWXJ6YVZNcncxT0Z5YTFOUXJ4U0hGV0lXUUFV?=
 =?utf-8?B?SkhwMEZrNVdRTVJkVmlmTFBObGZ4ZlhvaG45TGV6QXlVZG9hNWNEdy9lc0t2?=
 =?utf-8?B?aERZNTNhTFJGTXVIR0k1YVNJZTMrVHQyYnJUdDFsUmV1b0V0YXBFbUpUenE2?=
 =?utf-8?B?bmd2UWZGOUU5c0VNSU5QVXh6ZlJwL3B5QnV6dEdmVCs3eDJWUldidit2MVhy?=
 =?utf-8?B?WWx1R2pEOXE2cmIvMFZmbzJrQWJzTDNZc3YxZnBzMG9yKzZHemlDUml5MWoy?=
 =?utf-8?B?VE5POVpSblQvWkFOSEY1Wk5iL2UrQzNkQi9yR0RwbzZMUU5jV3RWQXpzNFE4?=
 =?utf-8?B?L0JZN1ZrZ1ZBaVhvOHFQdlVDT2FHY1B5QjZOVzFTaXgrcVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzhPTzh0SUdRUUlMMVNkY3VNcExxbzNJNUxwRW0zQ3JYOThxVzNxd1JZeE9k?=
 =?utf-8?B?QmlFWjB0Q2h3b0tyQU9xbUptVklqdHJRZTNob212aytLUGUzVlBBVXI5aE9Q?=
 =?utf-8?B?Z1pncjVtSSt4anUybmswMUpKeDB1N3VCVjB1NERkQ2c2anp1dUtINXFVVHFn?=
 =?utf-8?B?bW5VcXhqeVl0cGNyYUFtMFFEeWJha1BxYW5WV21MV1VTaC9lblcrUlRDNlkr?=
 =?utf-8?B?eUlMUW5Pa0JNSkpMUE5hT3RjK3I0V24yL0hJWkVlNE1KMVZDMVlTRjdRVXVE?=
 =?utf-8?B?bVpkZnZPdlArcTZhY3RYUzIydUtwS3grcGNQVUVyRFVWcEM3WjMvemdtSFIx?=
 =?utf-8?B?ekN6NW9SaGlIWGtLMzdXb1ZsRWZRcTY2eVlIQnhwRDg3MlFJbUhSdytVK0c4?=
 =?utf-8?B?VGdFSEo1Qis2MWhteENYNTlUMHdsc0hoWkFYYzQ0WEtvdnpFMWdJVFZJUVBr?=
 =?utf-8?B?d0kzdnd2WFNORDJhK09UTXJjcDMva3Rzc3lTSHRpekFYQy9JbWFCNkgra2pv?=
 =?utf-8?B?OFJRWTlLN1lZelB2dC9MQTczOG56c3VhSFdsZ01PTWs0VktucStpQVNXUWli?=
 =?utf-8?B?U0diSkxjdVh2YXQ5M1d1MVBRWm9uTG8yTXVkVjExSVpwOXR6RlJuZW5ZRThU?=
 =?utf-8?B?eGtTQWw5VkRtc1p2anJzZTUvSThld29WQUpqRmpNNDJDaFUwVEQ1NitXWVJD?=
 =?utf-8?B?RDIybEMyMW94WGZlZFJoSGx5dlNBRUhTWmc4Z2dkNmRzVXl4ZEt2TjBnQWFX?=
 =?utf-8?B?Qy9UQUMxT0U3ZUo1TEt6UFNFZ1YxbjFSZlRPcUY1WGZMcWQ1ZUFiMVhJNEhF?=
 =?utf-8?B?KzlYV0Nad1Zob2NveUptYXRXWHozK0FBQmxIUmp4TjhCaVRKR3hVZjJWZ3hN?=
 =?utf-8?B?dGE1N2xFejRpUDhsTHpVOW5iOS9YRTdFY3hxbU1LM1RUdVliUHAwclRnRjR6?=
 =?utf-8?B?Y1ZkNWdZWDVBT2tpTElHOE5EK2M4VzRTbGM4a2E3dEhYa3JWSTkyQzdnQWFX?=
 =?utf-8?B?TTliR1lhbmNCMStBam9kNXFOaEZsUmNNL3REbEFHVkZkZ2I2QTUwSldlaUNI?=
 =?utf-8?B?N0piUGZpaG90SUNWakdXL1B6VnFEM1pZekpDVzh5SlVLYUNneXhkNSsvT2lY?=
 =?utf-8?B?VlNHYytvUG9uNWJMMmdLdkIvYktnK1F1S2hLbG4rcEhGbWZTeUNmQWc3cmVO?=
 =?utf-8?B?di9Vb2hiM0R5dEZ2UnpsUk5NL1lnM2ZlQXpwYzRRbzJDd3JSalJyVW4yL1FT?=
 =?utf-8?B?WWs2ek9nR3EwYlRhUjBSRDRxTE5zQzN3cWUvTWJIVEkrWjVvL0hrbG83SHho?=
 =?utf-8?B?aERIR0dFdTN3dDIwYUYrL0pWLzV2NVQ0SDVFR0l1YXBZQUNkS2FoVTB5amFu?=
 =?utf-8?B?SmRHaVNLa3JuSFZ3QWs1aDJudDQ1MWNZV1pLb25XdGVUN2dBVExSTkNsVitZ?=
 =?utf-8?B?SFQ0VGdZYVV6S3N4aVdxMGVobC96WUNFcHA4T3VDdWQwNS9ucXpqTktwNXVx?=
 =?utf-8?B?YmN0Yy9MM3Y1TWlhenFSQUQ4UG5Fa3FwMWxmc2ZnL2VNaFpPS3VOL3gwNE1m?=
 =?utf-8?B?Y2hoWFE1eXY0MlVXUmJOb1QxdmVHYUNIc3FSQncwSHFIMHIyTUc0VFY2ajU0?=
 =?utf-8?B?Rnh2elRIdUROc0dJZGRtZXRZckNFV1M0REJCWDE0UWRMcldDbzVSUXhKbFcx?=
 =?utf-8?B?U1pHb3hqYmE0bmtEbFFISWRMRFlZQVFBMnBGMzhvRjg3TGI3enVqN2NmNm81?=
 =?utf-8?B?WjBkSGx2c3YyZ0ovV0c2Z0syWk1oaWl0VVYvWUhwVGNWRVdBWWFhMnRwdzRT?=
 =?utf-8?B?TjN2Y3FTTW84T1UwUDdHc2h2NDQ5WURKMk14Y2ZJSjJMQnNkOHk5NHJrdU9l?=
 =?utf-8?B?ejBhYWNNL2ExM1Y0T3NvZE9FUGxGaXNHR2o2b0VMZGlSREZPOGRObUJoNm9y?=
 =?utf-8?B?eUJ1dFNaWDdrdzNRM2N3NHE5WHZISzk1cXZ4MFVjbkV5UFpGVnJxd2dtMXB5?=
 =?utf-8?B?UXpEN3U1MWUxTVZyckRsK0hPZmtOWlVCREM5cnFPTkhnUkFiYWZ4YVZwNkx0?=
 =?utf-8?B?bGEvS3d2TjdhV1Q1MzB3SU9QVGdiN3FsaEQwSVVvZ1RINWZHWGhTd3JnNjZR?=
 =?utf-8?B?cE9BcEpaZkxlUDROb2hCRTYyVXpnMVpXcXJIM3ZOVUlpbHNibXdSNUhSTGVq?=
 =?utf-8?Q?3d1inEE3Ikvuifdww/LBVPjZMQ4u1AMLo1ZmjW1FX9RI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 187e930a-5663-48a2-9598-08ddc8af1da6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 23:34:20.1402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/AXMwN8i4IjYc4XdBFiZkOERaehNeiKEYZOxbWzHkL7/v+RDYGM7t/7Jcf5X5Utw7ENj4moxNOajRr3qBmdfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436

On 7/21/25 21:42, Francois Dugast wrote:
> On Fri, Jul 18, 2025 at 01:57:13PM +1000, Balbir Singh wrote:
>> On 7/18/25 09:40, Matthew Brost wrote:
>>> On Fri, Jul 04, 2025 at 09:34:59AM +1000, Balbir Singh wrote:
>> ...
>>>>
>>>> The nouveau dmem code has been enhanced to use the new THP migration
>>>> capability.
>>>>
>>>> Feedback from the RFC [2]:
>>>>
>>>
>>> Thanks for the patches, results look very promising. I wanted to give
>>> some quick feedback:
>>>
>>
>> Are you seeing improvements with the patchset?
>>
>>> - You appear to have missed updating hmm_range_fault, specifically
>>> hmm_vma_handle_pmd, to check for device-private entries and populate the
>>> HMM PFNs accordingly. My colleague François has a fix for this if you're
>>> interested.
>>>
>>
>> Sure, please feel free to post them. 
> 
> Hi Balbir,
> 
> It seems we are missing this special handling in in hmm_vma_walk_pmd():
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index f2415b4b2cdd..449025f72b2f 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -355,6 +355,27 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>         }
>  
>         if (!pmd_present(pmd)) {
> +               swp_entry_t entry = pmd_to_swp_entry(pmd);
> +
> +               /*
> +                * Don't fault in device private pages owned by the caller,
> +                * just report the PFNs.
> +                */
> +               if (is_device_private_entry(entry) &&
> +                   pfn_swap_entry_folio(entry)->pgmap->owner ==
> +                   range->dev_private_owner) {
> +                       unsigned long cpu_flags = pmd_to_hmm_pfn_flags(range, pmd);
> +                       unsigned long pfn = swp_offset_pfn(entry);
> +                       unsigned long i;
> +
> +                       for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
> +                               hmm_pfns[i] &= HMM_PFN_INOUT_FLAGS;
> +                               hmm_pfns[i] |= pfn | cpu_flags;

Won't we use hmm_pfn_to_map_order(), do we still need to populate each entry in the hmm_pfns[i]?

> +                       }
> +
> +                       return 0;
> +               }
> +

Thanks for the patch! If you could send it with a full sign-off, I can add it to my series while
posting

Balbir Singh



