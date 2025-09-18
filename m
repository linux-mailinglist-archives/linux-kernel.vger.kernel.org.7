Return-Path: <linux-kernel+bounces-750724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A16FB16048
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A9B56392D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D70327AC34;
	Wed, 30 Jul 2025 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="My6zNoUt"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232F24C62
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753878371; cv=fail; b=VtdN0O6yJ90xX3s0Tuci9gdJpdcI5WrmaL2h9tFmMQCIZiJAD+VBMff4/TcjP+g1g7I/IVujZTMb9Q6CU2ydzWgn18OmU99X5QoStIvXziEl12d/QLP73Urngr3sPCHabUSStVCnx21FRHT8NpmImhObvacZSI517jDv3QobO3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753878371; c=relaxed/simple;
	bh=kRr9WiPFwIT6fQ4wN7Ae7pB7FYpY3JSgP5Wzsy1qUN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YInN79WXUKpsdqhEf8rldVHEYiuIRvWfm/cosPEeleWZiWiutCYXBnFlMRynhbrH6sr5gAeRYtxpoE8RuVTRPZ/QIs/v4u3jNn7siShbg0ciG9crU9kO3njlvTCvG/8DP0w1br64FnU5KX+4qTIKpDUoqWVg94UYGau6h+fpXKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=My6zNoUt; arc=fail smtp.client-ip=40.107.96.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9f/mXIrw1YJtLG2WssKRx8p9eciLFmxgoPwa39PonrOEpEIjPIAzvke0k9FPBf6OyshlHRB3LFTIyxDrEKPNDPvxN/8MYIgfz370o3/GMF6aKvYcyJXWJQ0QVmxh9R3oq6RqxkEKUi2QnYMioMRrKQvtxMzthb5sE8+P0Z3Ui3neCejo7sUxqWNcXPFGZadLWx/cakNLMkRWvadlmiTuQRiQ89iFIaPXqBVZ09ivEYYB5MHdJJtgz/oL51h6CQ6nwAv6It6YM/eghWU7zImG6EiY2IPQiyx2dWTptwCcV08e3E9L/eLlR+harmKhm/xpM7VzsrLF4bBiKuW7n99Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DqQaBFpbF3j9d2BytkuM6ztuElxrZlcO9HYGoCE8ck=;
 b=qCbO047bvF1H8BfrNBPE0BfA+pv0lcx3ALRDTCf2mlxSBbxWk0wdeWWn2BYqKpQWdGs3/mLNOFnqSecEii2libA+1teBt43A9m6yYUZQu9SGJ9agUO24FyIVp4/lh8s3h2J+Q+bRcH1ud/gZQn+ZdyBxNtq1BUrnuYS1skqKFonfY0AGvq8WQDJ0H3mYpiNn2aZJfsw9HfiMGlo1ZQXaDvn0MiHPSEhq2luxB7ZAqOYcdM/kikvFMSOduRcRXoZlcDeBg6yHoXzkqHzn5zmBjd8UjbLP+v6iNrv2+dfXw0oD/Uvp+5vwasBTS2HoqyoRcVMzsD5mzNV+l+B60w1o9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DqQaBFpbF3j9d2BytkuM6ztuElxrZlcO9HYGoCE8ck=;
 b=My6zNoUtodI+x86LThBRIlEz43WL9l4DcvsCg9ctJcI9h0clCmaAm42SjZnz78VKYCb4ZRevstZ1bejqPR/hiX3a1gC5cOifEO70XaqvDFsgJV7oqLguyDZMHQ2IKR6lApuxh7Jq5W6XD/pH8wU/e1jw190Yai/Qwlbm7odOYJn1xBwYsig8Hl4xzSKHFrhTzdVCrUoNH0fNKrTLqAYe6nVVDNt4oak7iZUfeIYJl1crOizIy1yEG+ArlNFDEUy7XhNIno7FFIReavzAq0DkTBx0/Jv+YNvs6pVFBZnTkmlwEhxYVIQlRU34/6THMeZv8CLKqENgpOXztUDfEGSQNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Wed, 30 Jul
 2025 12:26:03 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 12:26:01 +0000
From: Zi Yan <ziy@nvidia.com>
To: =?utf-8?q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
Cc: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?utf-8?b?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
 Donet Tom <donettom@linux.ibm.com>, Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>,
 Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [v2 02/11] mm/thp: zone_device awareness in THP handling code
Date: Wed, 30 Jul 2025 08:25:55 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <6291D401-1A45-4203-B552-79FE26E151E4@nvidia.com>
In-Reply-To: <884b9246-de7c-4536-821f-1bf35efe31c8@redhat.com>
References: <20250730092139.3890844-1-balbirs@nvidia.com>
 <20250730092139.3890844-3-balbirs@nvidia.com>
 <c2f2fe52-a358-489e-a1f2-5c0a6f5b4db5@redhat.com>
 <22D1AD52-F7DA-4184-85A7-0F14D2413591@nvidia.com>
 <F60614E1-28D1-466B-A434-7FF1061B0778@nvidia.com>
 <9f836828-4f53-41a0-b5f7-bbcd2084086e@redhat.com>
 <884b9246-de7c-4536-821f-1bf35efe31c8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR01CA0039.prod.exchangelabs.com (2603:10b6:a03:94::16)
 To DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 869cc000-e61f-4e4d-fedd-08ddcf643eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzBQVnpBcWI5YkE5elZVbnQrSFFsQTRtU3ZNYzdkRThYaFI1RDdOdk1IRjFi?=
 =?utf-8?B?YllkanE1a0RXd0dUSHVFdUwrL1FJY05TSmVYK3JOdDZqUVhkaHRFRXREY2hP?=
 =?utf-8?B?bjFMcnBUWG0zaUUyZUZyZzl5ZkNHT0dpWVkwNjRiZ1hKUmRtQ3psWGZGSGtD?=
 =?utf-8?B?Wnp6MkRNUUhlM3VDUUhVVUdDc2pFemNMZzVXaUdEbE4yQjlIaThUVnlPTnMw?=
 =?utf-8?B?c3NQOVk2L1pKT2IvTE9GYVRXNm9FdG1IRHo2NzZFdllxb3Rha2ZMTEd2ejhq?=
 =?utf-8?B?aHdxeFpDNS9jUVJCUVF2cWpvbUtLT1NkdHJaTkI3NVZaTWd5cTRpM1h3MmRr?=
 =?utf-8?B?aDFZQ0dwZ1FGczRrZHlxL2oySk1oKzgwZXFqOWhQMVV6N3QxUUlFcEwwdzBh?=
 =?utf-8?B?dkMwU0d3UlpSNmxQUDVXek53RENGM1JtNDRTUFluajNQSFFYWk1sYVRIc0hM?=
 =?utf-8?B?K3FlOG5FMU9rcjJsYzNmdmgrVmFZQkhRWW9FWnByRXpYNlFvMjV2TlducU9r?=
 =?utf-8?B?ZGRUUDg0NnVMOXUrcjNKN2ZRZGRXOEI2MTB1eFFCK1g3NzZDalNFRkFSV3Q1?=
 =?utf-8?B?NUw0cW9qTkFIVmxEa25UTENXOU1lWU9VQWlCdDVvVDNFdmdrRHZyendxSWVT?=
 =?utf-8?B?dHZlK3l3ajdOZ1N3U1RuVTRrb0xIRHk2WXl2VnJsMXozQys4R3FJbVhOWldK?=
 =?utf-8?B?SEZmeTNEYzNVcDNyRmlvcy9qb08xS1ZyM3JUdlNscTRjSjdEeEp0bElNckxX?=
 =?utf-8?B?eHlXdWp4K1dybGhuZm0vUVVKeWovVTRsSW1hbGowZjhGb2FzK1d0OXQwRG0x?=
 =?utf-8?B?T3ZCRUtOYjIwN3hER2lkaHdsTTFNSENWWmkxTS9pN3JVbmkrUkl0VjZzN0hB?=
 =?utf-8?B?U01OSnRiSHVaZHVFYXVVQ1hiL3M1WXlaaWFzZDMra2RZUlNXY1hPRjYzRGYx?=
 =?utf-8?B?L0toM0dzU25KR3Z5U2NmRFR6ZTRMK3hwMnRVS2crenVhS1NtMlB2R0M4MExm?=
 =?utf-8?B?SVlxSWJvQ0MvSDhCb0x1cXlmNG84elQ0eUpNRWxXbTZtQ3pyWE4zSS83ZjRX?=
 =?utf-8?B?UGtqY1VYUW5GalpvQmw3MnFUSUFFQWNDbEdSV2cybjdIWHFTTEcwOXJzL1Fo?=
 =?utf-8?B?Z013azJ6NGY0ZFpNOWZTdCt6SnltZkRZQ0lGZE1EZkZxTVFBL2ZjRTdCMVcy?=
 =?utf-8?B?Q0FmNXY3SGxoODBwQTJKMTJVZDEyM2V3SFRqSDVIMUMwMnhBVnM1UFEzUnls?=
 =?utf-8?B?K0ZvR1NpMVpLaVF2aW5BcHlINFRkaCtVVFI5eGp5VCtGYjBYQTViZzdXd0hY?=
 =?utf-8?B?SHdyU3d3VjUrbkFpamFlVk1hb2RZVnJsd2hramh4N0hQY001RzdvZit1K2k0?=
 =?utf-8?B?Mk1JTkVpY1BxRlNQZVdHZUQ2VFdKNXV1V1E2SEdFTm9JWmpUQThsNmFEc1Jv?=
 =?utf-8?B?TDhrQ2JCcW1OZmwwZzdkMWVuZEQ4bUN4NU90MHdIeitQTHIvb2RvZHZMenNN?=
 =?utf-8?B?WnZNVmVPckxrN3lCekZXR1hpSldES1o1Y2JIdjFqMHFlQ0hNM0llZkZ1NWNX?=
 =?utf-8?B?R2FFTlV0YkFiaWZZT0d4aEt4TXV4NlFPR1FINXNpMzhWbkJqSVVhODdBQklQ?=
 =?utf-8?B?UnVUZTlsUnRGdmtqWkd6UXRyUjRuY3FLRG85ZElmY0xhNDgxQkNJYnVOM2tY?=
 =?utf-8?B?TVlPYUZyWFZVN3NjaDJlSWppTnVNMjFvQUxrbHNtTHV1K00rZ1hCbjZ4elFF?=
 =?utf-8?B?LzRpZWh2bE9ZZExvbW5rMm5KQW9LVmtKZ0pHa2d3RU80eVJocnFJUlZJQU5D?=
 =?utf-8?B?NGJDUEtDVmRXdmlBS2RIQmJJenZ0QXR1MkVyRjdKYUV4dDJwQjNEdDdqTWVR?=
 =?utf-8?B?WFhWUVZDQ1IrRU0ydWZJY2RCWGNNZmVENDNWUDh1NWVoSUx5Y2UyZFBlUnNH?=
 =?utf-8?Q?NMSMwUwEDYA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGR5WVFBSEtDUDlERHB4ZmdtVjE4dmdMR2lrR2ExdUYzUEplN1Yzd21LalFW?=
 =?utf-8?B?aWJsYTZyNzlxWmdSOTVVZENKNFJTdHFDUldIOHdVLzZ4VmFBMjFZVWZxTGE0?=
 =?utf-8?B?NFduWnJYSnEwQmIxTnV2QUFjR25CUXlLdnJGd3JyNUtaWFR6ZkQ0cmpZalV4?=
 =?utf-8?B?Qi84ZTl2YjRaWFZQbUplSTRCck1VUjJ3OG9XRDBWRldxa0J6ZEdlVnhnU2Iv?=
 =?utf-8?B?RHZQRC9oTG11VEFMVlA0LzBheUFkYURSTE1rR3J0UnVwc0lBRkRTYVorKzI5?=
 =?utf-8?B?Snlham5VSGx4cGJ0cVNTbkpMODN6dzZ4aG5IMVVnakwySnpFSTdSV3JYbDAx?=
 =?utf-8?B?QTlBNDhEekhKZzNIV2ZxZWhnZWprYWJQcGFZOTE2TGpPM1hEelZJTWZqL0cr?=
 =?utf-8?B?YndYeDZFbHpudms0RzM4ZWcyRFNML2dpcXZyYXBKQU1Rb3RrZ00xSUtBRWw1?=
 =?utf-8?B?ajNndTd6cHhIYzRHNTFDTk41R2xINFI4eStZckZKdFVNaWcya0RxOUtWQTNh?=
 =?utf-8?B?VkQ5UG16VUZDTDJqUXZDcmF4cWNwb0c0M1NreXM5VFhFdHh3Mk1mYkNqQXEx?=
 =?utf-8?B?Zk5MQW5ubmFXMDhEckw5RnBaYStLa1BnZ01aNkpOK21Ka3BBSno5STlHcTVu?=
 =?utf-8?B?aXo3MXI4a1ZYQXg5bWtIZ0FOTWhiTllFdjUzSEEwZWtqUWQ5T3k3b1Q4cDFM?=
 =?utf-8?B?UDdDbmtvaDZjTVpHSmZiN3JPcmt3bmpHTGRncDJrQ2dON1dTaXVhaHV3R2c4?=
 =?utf-8?B?dzhNemx2TGxNNUw3V3NuV0VjRXpiNEQvU2p0Mk9sbHQrSGFqSUJnYjVaMjRj?=
 =?utf-8?B?UzgxZWk3SGd5bFJCSmgzYVpHMFRETkhtL2Q2SlNxRFV2QlBNSzFRdmJDdlZG?=
 =?utf-8?B?UTFjZWxSWWFqalAzOU9oc2s0S0pZeDNCTkJQUHU3S05OVGg2Zkh4WjQzQ3Vr?=
 =?utf-8?B?MlNSbHlwdVdlQUM3L1NublpyQXhIMHlGN2s3RVd2WjdBNk45NGVFSmgxVXdM?=
 =?utf-8?B?NDNlMHcrSkhLSkhrMWttQkpvU05ZNzNnV1ViUmNJQlh1SENST0NlWUdpdStP?=
 =?utf-8?B?NCtXaVRiaWNtUlpDcGdYa2pnN0ZlL21nVlRjSmxOMGx6bG1EU2poRjZOYUxy?=
 =?utf-8?B?L0VqUFl0SmpiUnRRU3Z0emtFaTJVeW5rN2NFMnFjU1d0SENMMU9XMWYyOWpz?=
 =?utf-8?B?bC9UWmM1dG1HSTdIR25IckJqdmxkdmxHbzBsOFJSL3dkR1FqNStwMk5BS2Rn?=
 =?utf-8?B?K2VRSVV0azVwY2wrOVl3TlBPb2JnQXRSbFFKUEt6akx1SmRFYXZXUmY2K1FE?=
 =?utf-8?B?Y041eXVLWEhrY0dkV1l4NmJ3Y3h1MkJJYlZHQ2dBNmcwYWJBRk5zRVB1Y1h6?=
 =?utf-8?B?VEVvN09yNGJib0d2bkE0NDk5cS9udGw5TVdtTHg0NmY3bnFwTFo3ZndTTVZ0?=
 =?utf-8?B?SjhGampRcVdKeDVxRWR5Zk1hcnVQVTB4SXlCa2cvTDkwdlRScnYvS3JIYnpW?=
 =?utf-8?B?dnVWWktOMm5Gc1E2WUFtVCt5UXJPWmVnQ1RGVDRLaStXZklWd09HTHgrUzhs?=
 =?utf-8?B?c3d2dmtWdVlaVExLWUxkMWZIVE1PbWh5emRPdWh6c3RiQkl4djhwTmd5Uno1?=
 =?utf-8?B?ZWxzRUdXemx2WStUSmpYNXNvQ1A0TWpTRFZIdUVRaGx3RXZnOEYvc0RxQU1t?=
 =?utf-8?B?eE9VcURtSHhiaFNCZVdRaSt6bGhMWjBMT01zNGxTSk83ZDlDZ1JpeDVzVlBl?=
 =?utf-8?B?TTNhVk5WbWRHYjd1bDZNazIvWnBDUzk3SkNLa3l1Q3M3SEJqcU1CSVR1dmo2?=
 =?utf-8?B?enlGdWFtaDJlTXJhd3RUdEV2R0xBbkFBQUVZTnJVdlZWakhZeFFuMGkvQ1pl?=
 =?utf-8?B?S1dCejdwdDZTK2lBMnVZck1kL2hPeFppRTFvaHVIWFVuVWpXYzhMS1NiZHZq?=
 =?utf-8?B?bndBdERhaERtNTdxNXdlUlBjek05M1FYSmhwNzM2aUpUa01pTlVma0VQSUNC?=
 =?utf-8?B?enBHMXZrbU1panJ6M2xYMFk5NHN2Q0lZMFlzRk1JR0pNYWN0cjBSZFIyYm9T?=
 =?utf-8?B?Wjh1dWkzZVQ2Y2wzcWpWdWpEQVJOR3U2UmtLQU8rU296QVBMM1hSYm85M1NL?=
 =?utf-8?Q?bI4s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869cc000-e61f-4e4d-fedd-08ddcf643eef
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 12:26:01.7400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fv93axOxB4AN69NSKBCS9R30MMF/oSgpjfhY4B2PnusMrggaVECRUcLzAcmvK5LJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865

On 30 Jul 2025, at 8:08, Mika Penttil=C3=A4 wrote:

> On 7/30/25 14:42, Mika Penttil=C3=A4 wrote:
>> On 7/30/25 14:30, Zi Yan wrote:
>>> On 30 Jul 2025, at 7:27, Zi Yan wrote:
>>>
>>>> On 30 Jul 2025, at 7:16, Mika Penttil=C3=A4 wrote:
>>>>
>>>>> Hi,
>>>>>
>>>>> On 7/30/25 12:21, Balbir Singh wrote:
>>>>>> Make THP handling code in the mm subsystem for THP pages aware of zo=
ne
>>>>>> device pages. Although the code is designed to be generic when it co=
mes
>>>>>> to handling splitting of pages, the code is designed to work for THP
>>>>>> page sizes corresponding to HPAGE_PMD_NR.
>>>>>>
>>>>>> Modify page_vma_mapped_walk() to return true when a zone device huge
>>>>>> entry is present, enabling try_to_migrate() and other code migration
>>>>>> paths to appropriately process the entry. page_vma_mapped_walk() wil=
l
>>>>>> return true for zone device private large folios only when
>>>>>> PVMW_THP_DEVICE_PRIVATE is passed. This is to prevent locations that=
 are
>>>>>> not zone device private pages from having to add awareness. The key
>>>>>> callback that needs this flag is try_to_migrate_one(). The other
>>>>>> callbacks page idle, damon use it for setting young/dirty bits, whic=
h is
>>>>>> not significant when it comes to pmd level bit harvesting.
>>>>>>
>>>>>> pmd_pfn() does not work well with zone device entries, use
>>>>>> pfn_pmd_entry_to_swap() for checking and comparison as for zone devi=
ce
>>>>>> entries.
>>>>>>
>>>>>> Zone device private entries when split via munmap go through pmd spl=
it,
>>>>>> but need to go through a folio split, deferred split does not work i=
f a
>>>>>> fault is encountered because fault handling involves migration entri=
es
>>>>>> (via folio_migrate_mapping) and the folio sizes are expected to be t=
he
>>>>>> same there. This introduces the need to split the folio while handli=
ng
>>>>>> the pmd split. Because the folio is still mapped, but calling
>>>>>> folio_split() will cause lock recursion, the __split_unmapped_folio(=
)
>>>>>> code is used with a new helper to wrap the code
>>>>>> split_device_private_folio(), which skips the checks around
>>>>>> folio->mapping, swapcache and the need to go through unmap and remap
>>>>>> folio.
>>>>>>
>>>>>> Cc: Karol Herbst <kherbst@redhat.com>
>>>>>> Cc: Lyude Paul <lyude@redhat.com>
>>>>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>>>>> Cc: David Airlie <airlied@gmail.com>
>>>>>> Cc: Simona Vetter <simona@ffwll.ch>
>>>>>> Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
>>>>>> Cc: Shuah Khan <shuah@kernel.org>
>>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>>> Cc: Barry Song <baohua@kernel.org>
>>>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>>>> Cc: Matthew Wilcox <willy@infradead.org>
>>>>>> Cc: Peter Xu <peterx@redhat.com>
>>>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>>>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>>> Cc: Jane Chu <jane.chu@oracle.com>
>>>>>> Cc: Alistair Popple <apopple@nvidia.com>
>>>>>> Cc: Donet Tom <donettom@linux.ibm.com>
>>>>>> Cc: Mika Penttil=C3=A4 <mpenttil@redhat.com>
>>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>>> Cc: Francois Dugast <francois.dugast@intel.com>
>>>>>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>>>>>>
>>>>>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>>>>>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>>>>>> ---
>>>>>>  include/linux/huge_mm.h |   1 +
>>>>>>  include/linux/rmap.h    |   2 +
>>>>>>  include/linux/swapops.h |  17 +++
>>>>>>  mm/huge_memory.c        | 268 +++++++++++++++++++++++++++++++++----=
---
>>>>>>  mm/page_vma_mapped.c    |  13 +-
>>>>>>  mm/pgtable-generic.c    |   6 +
>>>>>>  mm/rmap.c               |  22 +++-
>>>>>>  7 files changed, 278 insertions(+), 51 deletions(-)
>>>>>>
>>>> <snip>
>>>>
>>>>>> +/**
>>>>>> + * split_huge_device_private_folio - split a huge device private fo=
lio into
>>>>>> + * smaller pages (of order 0), currently used by migrate_device log=
ic to
>>>>>> + * split folios for pages that are partially mapped
>>>>>> + *
>>>>>> + * @folio: the folio to split
>>>>>> + *
>>>>>> + * The caller has to hold the folio_lock and a reference via folio_=
get
>>>>>> + */
>>>>>> +int split_device_private_folio(struct folio *folio)
>>>>>> +{
>>>>>> +	struct folio *end_folio =3D folio_next(folio);
>>>>>> +	struct folio *new_folio;
>>>>>> +	int ret =3D 0;
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * Split the folio now. In the case of device
>>>>>> +	 * private pages, this path is executed when
>>>>>> +	 * the pmd is split and since freeze is not true
>>>>>> +	 * it is likely the folio will be deferred_split.
>>>>>> +	 *
>>>>>> +	 * With device private pages, deferred splits of
>>>>>> +	 * folios should be handled here to prevent partial
>>>>>> +	 * unmaps from causing issues later on in migration
>>>>>> +	 * and fault handling flows.
>>>>>> +	 */
>>>>>> +	folio_ref_freeze(folio, 1 + folio_expected_ref_count(folio));
>>>>> Why can't this freeze fail? The folio is still mapped afaics, why can=
't there be other references in addition to the caller?
>>>> Based on my off-list conversation with Balbir, the folio is unmapped i=
n
>>>> CPU side but mapped in the device. folio_ref_freeeze() is not aware of
>>>> device side mapping.
>>> Maybe we should make it aware of device private mapping? So that the
>>> process mirrors CPU side folio split: 1) unmap device private mapping,
>>> 2) freeze device private folio, 3) split unmapped folio, 4) unfreeze,
>>> 5) remap device private mapping.
>> Ah ok this was about device private page obviously here, nevermind..
>
> Still, isn't this reachable from split_huge_pmd() paths and folio is mapp=
ed to CPU page tables as a huge device page by one or more task?

The folio only has migration entries pointing to it. From CPU perspective,
it is not mapped. The unmap_folio() used by __folio_split() unmaps a to-be-=
split
folio by replacing existing page table entries with migration entries
and after that the folio is regarded as =E2=80=9Cunmapped=E2=80=9D.

The migration entry is an invalid CPU page table entry, so it is not a CPU
mapping, IIUC.

>
>>
>>>>>> +	ret =3D __split_unmapped_folio(folio, 0, &folio->page, NULL, NULL,=
 true);
>>>>> Confusing to=C2=A0 __split_unmapped_folio() if folio is mapped...
>>>> From driver point of view, __split_unmapped_folio() probably should be=
 renamed
>>>> to __split_cpu_unmapped_folio(), since it is only dealing with CPU sid=
e
>>>> folio meta data for split.
>>>>
>>>>
>>>> Best Regards,
>>>> Yan, Zi
>>> Best Regards,
>>> Yan, Zi
>>>
>
> --Mika


Best Regards,
Yan, Zi

