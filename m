Return-Path: <linux-kernel+bounces-892273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 111D8C44BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771433A79CA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 01:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCB221CFFD;
	Mon, 10 Nov 2025 01:37:06 +0000 (UTC)
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022102.outbound.protection.outlook.com [52.101.96.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC9219E97F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762738625; cv=fail; b=eZyJxNVmvxN5CzAeMBtWOSM8sIizCdSiAcqMN9OH9zItJY/OeDDLhZW+nDmtbEGvToUUeKj2v6XjFZyYYF1argDEkCQovcoI1iY7gf9DEwTtMOTZ1heg/ZkfHsSG0wf7r/ebMXXcFV3urC8X47tZme2UVxOlbZe8lTCw73M1KPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762738625; c=relaxed/simple;
	bh=U5iSbN3cvSJeddTRCbylWbdswRntVXAR7wcfokaeIAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QMZAGVItW5vIs5SSb0Wpzg6MKuYYB1InO9ORK0+5WeHiDT2xEOm5v3q25Lt8SDLN1+q9yGSqhzY7quXbSxQICXmc8hi0J0gVXbv9JdMAYpH8S+9Ir+kjlpHsyVCNXR8iYoFAnNbnIjPot7M10py2o+6/HqC0Vp6Q0Ko/qOQ891k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5zZu7PjBkc8ECcVYdGIxJWGWJB0pt38wJbMR31URDYcq0GbuGh5bLeyZ6wtUemggJbzWA9wKI5HK2pmgWMo8iyTU9N1ZRSXylDYlAJcbKgn5qMQk91vVDTyELJe2VS8vTsyPeJrt2HAr6cNEa0nRq92dyKL43BA1TdOf1jk6n4T1EcjqdcTFFXggedsnI6XawYY83oibh7f6259zjOEt2G40H3NUkMplqijMPNUWinzA4kmmtPHXED+f50nqbZ+QliwU3Ga/GITZ3L4EA7PPLWiIrPjVgguZ2LoAXHojL2FTI6VxAEqNN4zgjNdQpqwmg77lROrLGbAXK0pyEroQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wymjlkcFAt375/dWia74lnyDd056maxg1/kZ7t1xiTE=;
 b=Z6EPslqat5c6+EVDmCDsn5bIAnuE6UmDNizVOQQywdcG4czZZYDf/XMW1HuC2IS/gdRnJ5qWPSYqcRbpdleao1o+LXCqzEmD52FnfhGWOgvDl6VxxtjkeDOjB63WR6aL93PZjfrY/p4Igs72uPESLJwHYjyrtk1JPAg79ZyGSkyh+MwD5LLcLRCS10pZ9wrrveMVov3bZUVQ5LPeBoUK5vyicOHsqzse2/usRfCG31gid+xyNHKSKYqmpCbXOIw3NeGKLgrEwrbJDCl7+ULBO6FZskCCPM0f/Y7ko5vpr0xxJ2aP7ljUvlI0ZmM5fQNXOHf6QE6B7ril0/9iznHPOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOYP123MB2877.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.14; Mon, 10 Nov
 2025 01:37:00 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 01:36:59 +0000
Date: Sun, 9 Nov 2025 20:36:54 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Cc: pauld@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/isolation: Enforce at least one housekeeping CPU
 per node unless maxcpus limits
Message-ID: <ze4cjlj36ads7d6gpbpxryqxcnrguh5etokbmlrrzh3uxw4hb4@mcfszlpsozuv>
References: <20251025161113.14313-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251025161113.14313-1-atomlin@atomlin.com>
X-ClientProxiedBy: BN8PR04CA0056.namprd04.prod.outlook.com
 (2603:10b6:408:d4::30) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOYP123MB2877:EE_
X-MS-Office365-Filtering-Correlation-Id: 88423c44-2e9d-4640-f55c-08de1ff9a3cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|27256017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2lKUEdRWGpEN1BpajBwMWt4czM4RWlXR2l5QXpES0MyU3VUdVZCUUhtZVJL?=
 =?utf-8?B?VmFHdldlS2ZzV29uTXk2YlFIU2pIQmI5eDRTOW15SmJNMEU0VlJtNWRxWXRk?=
 =?utf-8?B?djN6Y3pGdjZzWWpUS3RWdENLaFJhU1l0Z09kNjFwMXFGNGFBS0x0RFo5dWVK?=
 =?utf-8?B?VWh0NHlIYWNrc1E5eVhZaFRwYnA2elJTRHpaU2lxSUZLV0RFdktxZ1dMWjE4?=
 =?utf-8?B?c2VyQzY0UnZpbi9lM1F6VmlEU2pEcXdxS1djaVBtVUtDckV5cndTbTFYVk1q?=
 =?utf-8?B?NDFUY2tndUt5a1czSUdpamF1bVlwRSt5aGdHSUFhblBXbzJmVFdnTlhxdVU2?=
 =?utf-8?B?R2ZNYlRmN2RyWTNnQ2M2dy8wOXlMT2VWMU9mdzlFM2tIUkR3M0RqY2xNSjJT?=
 =?utf-8?B?QTFCS2NOVkFIOGZvUnFWWU92cEhLM0RwMld3c2pnUi94dGNOTENEdjdzeWti?=
 =?utf-8?B?ZGFwdjR3NXVvY3dZMmVaV0pCWGNsa29rZDArb2J0NG5nemFoQzFOUFJQNFl0?=
 =?utf-8?B?MThsQVlXa1JjZE1jTFliVTd0b1pGWmpzaXpuNXFiQUM3RWxaVStNazFPSWk4?=
 =?utf-8?B?SVZ0S1FHUy9PMWtFVlprblpWTUZ5ZGdUd1g0bWtzcTBnZzBMcE41c1dod1dE?=
 =?utf-8?B?WXlXOGtNYmtqK2tJcTZBbTRtYXN3R25DZk8ySm1jK2VOSEdSRHdJYnZ3UHBj?=
 =?utf-8?B?OTduaFhIOHZYQ1R6Y1UxR2M0RjY5d3F5cnR0eElnU3U2R1hiSlg2UGJsMVdn?=
 =?utf-8?B?alZxalpiR1AwbGdDTTNrcGJuU0wyT3kxYzZ1RHVMRFNwR2N0Vzc2eHRzek9q?=
 =?utf-8?B?L21MeGVEZTVibElrU0JIQXRzM2ttMjdGNzQyRWVRTUtXVTNwa2J6NXpyVVMr?=
 =?utf-8?B?SnpWOXU4SjNCRFV4Umh2ZFVnSjVrZENwSDNYc09USExMb2dicGdCMEZpUTMw?=
 =?utf-8?B?Y3NWYXV5SmthNE45OCt5UnFZcnFrem84b2E5S2FlZ29sVmZycnFKWDh5VThr?=
 =?utf-8?B?aGd2dWlvSzRXQTlXZUhTTURoTlY4clNzVFptc3lpV2s4eWtzQ0pLZksrVTkz?=
 =?utf-8?B?dHU1MEVCNWZ1WmY5akpMc0g3RmpYUllnd2NESE9qVXNBaGFpWEJWZmJ6NWVi?=
 =?utf-8?B?emRndVBNZHJVdU9yNUFQNERCN2g0WnBmd0FsclNidHBLYkluUE9UamxNVWpV?=
 =?utf-8?B?QmtjUUErR0FSUmF0b3pYMHFXMGhBZlJWVFB0enBNbDkvdHgxdENOUm5BU2xS?=
 =?utf-8?B?NWNBMjYrZTJhNTRpY1l3UDhvT09CbUIvZHFHOGZxR0V6cEZEL0ZaUUxBeHZ1?=
 =?utf-8?B?NVpxaXh3b3EycEhIWXVzT3RROUg3cW5lQzFkOU1NbWF3TWpRcGlDZlo5a3ZI?=
 =?utf-8?B?S1pOSGpmSWRHazJ0TVNPYStDTWh4b3c4Wjk1RWZGNkpqNzN3eHFTekJSOGd3?=
 =?utf-8?B?dy9nTHQ0N3RMNDZzS2JIQ3lyUExrMFFqMWtUSTl0Zkt6T1IxZDBtamt5L3Zs?=
 =?utf-8?B?OThOcGVkbUdBbzBHL2RVRzJJb1JJWStHK3JUOTc2a3hkR01tZmxMMUVJaW9K?=
 =?utf-8?B?ZkcyS1M2dWNOSGNaWUdEM1Y4MkxjeC90cHJlbDZ0czRNYVFaTTVaOWdlejc2?=
 =?utf-8?B?ZEYzWk1RVmFZOW9WMmgwdnhnN3hDd0FFcTMxcU10YldIWmI3WG9pOSsxSUtM?=
 =?utf-8?B?SjRqYkgxZ21nWWFIa3l1VXFKbUNMZjU5eS96NzQ2MXhTOW8rWjF5Z0NUM0o5?=
 =?utf-8?B?SldGNEk3WnhJOEpIbmlmSWUwd2hzaE5EcWpnR1ZKWGIxejZTVmxnd2FSRmxC?=
 =?utf-8?B?ZzlYSzhFOGU2YVdMUVhKcGNFU29oZDFrSWg5UmNESk5LQ3dITzNiQmFwWktS?=
 =?utf-8?B?cGxSbzd5cm51b3duMUl0TmVPNy9vcmdlcXpTd3ZEMTc3cjdYdTM3Rm5pRjFI?=
 =?utf-8?B?allZYUI3OVhvTURpVkNtYkJMRmlmci9Cc2xDSGw1Rit5RlFxWkZzVHhmbHo0?=
 =?utf-8?B?ejB0MnAzMGdRL0NZVE53TVREelNFTnNMNUtvajd6Zm9SNVh1L2lYNmJZUGpn?=
 =?utf-8?Q?vZUMQR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVhkZHNlT2Evcjd4TmNwa2ZWcVZBdk9sMVNEMVp4NEVhc1NoYXRzTzhURHNE?=
 =?utf-8?B?WmZhL0hLa0hONFVjdTRNWEpkRWpZZ2FhZnN0UmVBWkxzaCtocTkrMEpoU3l1?=
 =?utf-8?B?cHdudjdVcUxMWGVDREp2WkVoRlI0WURSb3lnNzdLM3UyUlRSYVM3cENlR2ZH?=
 =?utf-8?B?ZFVvVXlkc2M0Z2k2NlBOMmNlRFd6S0I4RkNaQXRxVDBaTi9MQkRKeVQ2ZU5u?=
 =?utf-8?B?RXlUYUwwYTlzQWJMbFBBOVkvZUc0OFJJeVpDRUlBUHRpUFJqTjBQZjhtS2JS?=
 =?utf-8?B?ckJBdDZ3M291elVzQ2J4Z3p3ekN4S2RrNFYrTTJEUlhBVjZDV2pnYWVvTUE0?=
 =?utf-8?B?K1NDOWVFS2JwSlFUVzZHRCtlaXFZb01OSjdYbjJXVzVmaUNPZ0Z5RGRyYW1U?=
 =?utf-8?B?MTNSbGUwTTVoSjJuMzlvdjF4ODRiK25rSUZyTVJqbFdYaFY0OTk0c09TWEZY?=
 =?utf-8?B?TDJYR0xEK1BhSFprZnBaNG9HOXBPRGxYNjVHbXArNTdFcHdaZWk4QTk2TVFk?=
 =?utf-8?B?d010N0xzL2hkS0UyYWU2RkRZRnh0SXlNWTByVFFBVWNOckptVG5oMFY2M3kw?=
 =?utf-8?B?WVdiTDZjRC9Hcnk0V3p3QUcvRkphKzZHcCtzK2kremtsUDRFbSszYTdhZHli?=
 =?utf-8?B?ZkowQkxCV21hOHV6NHJZbHovVllTakplckhFVXdSM2tCeW1XQTNmUSsvalRm?=
 =?utf-8?B?djhUQXo4S3ZGVWppcmluWUhoYjFlZmxQWVNpaWYyeXpLMExWcGltckJtK0Mv?=
 =?utf-8?B?bzhhWXdxZ3F2bDhySzg4aFU0bDlZMDZnaStlbnRjVCtmR3JpRnd2S2ZCd2Jz?=
 =?utf-8?B?VEUydmZnbzZVSnZWZG1maXpoUk4zck11K2ZIUjJsazk3L2VjSnpVdnhCby9p?=
 =?utf-8?B?bE04Y1dmd1VDNHRQL0RUK2l0cXRoMGY2LzB6VzEreThMRFEzLysyUFMvWHBX?=
 =?utf-8?B?eW80VU9RWnhJRVdpUmJUbllYRWh3cHFxZlVrMmZNQkQ0cVJUeUJERDR4MndZ?=
 =?utf-8?B?ZFpPdmZXMGgzV3FaNWY3N0orY1VjSytsRFZmSHRpeVNjVW9Ya3M5aDhZcTZY?=
 =?utf-8?B?MUtBaGV4TDhuTDR4d0hJdUR0aEdRcngrUk5QcXMzTWZDbE1hamo0YklJL0RY?=
 =?utf-8?B?UFkwcEFoSVlQNEhzdzY1YUQxVHE1L1EzMWI2blhNWW94NE40a0pHS3dpVXFW?=
 =?utf-8?B?S3p3azlHMVhadzNjUTFVdjRySzJRamQzelp0M29iZkwrdHVFSFZqeEF2ZnZF?=
 =?utf-8?B?bDg5NFBtNXBVN1I0anplTDRZN1JTa3JPb0Rxc3l2SjIxU1I1SW9DN2UyYkww?=
 =?utf-8?B?djhyd21FVmlUZjJnRm9YOWR0eTFSdmNyL0xRS3ZVQ0xTL1hjOUNGTWNXZzNp?=
 =?utf-8?B?YmtsaXhLejBIYUFtUk96MEhpRDVZKzZzc05ZMWVWUUlabmdJc21Ja21HSW1h?=
 =?utf-8?B?M3R6RFpUUDEyRHN2SVRBUnNzOGZEN1NQc0x3Yit5QkVjYnB5ckNBYmdIY01p?=
 =?utf-8?B?U1laK0Rock1DblFXbStpL2ExYUlndW9SeXM3S1BzbnVwWW5PaXN5ZnpLdFNX?=
 =?utf-8?B?c0p5TGNwZTk0SC9sekhuU01SVlcxSWFZQjRUcEgrN2VqcVNaZ1A5ZmxKMmlB?=
 =?utf-8?B?WXh2cHRyTmJKM1BwOXVqdUZOUy85SGdHMExjRENRMnAzcldpcmduK2dwREtN?=
 =?utf-8?B?ajFxWURDWXh0SW5McGpFVEFlTXBvOTkvbnB3cTFEdlp3QzJyTk8wYm9VQU8x?=
 =?utf-8?B?cUhoL2pvVFRwdGhqaFdWSWpmSzRTeWpTbjA1Y2lzc3VDZWNhNXp4dEtxSDJS?=
 =?utf-8?B?MFZJeTNDTWhWTGlnbnZkSzIzTXM4WitGTWNRK1BLazZMQjlqRUdoZG9oazNR?=
 =?utf-8?B?UzFRMlVxSTRMUE00RGt3bmlXTjd4bDN5bzIrMGIyb21vSHZIa2pucVZxLzRj?=
 =?utf-8?B?alNMK25Wam9PRTkydzk2REFSNGl3QldabjhsQnVTRmo0eVpHTGFjSGJUUklx?=
 =?utf-8?B?RW93UTFTSU5sRlErUUVaYXA3ZUd6emFyT2NTN0xtTEVIYVZOdVhiZGhUaTl4?=
 =?utf-8?B?OVpFV0lCaEpmTWdRdk1IQitTZnMwbWl3Sk94dG8yUXowdUJTeEoxY2lwUlE0?=
 =?utf-8?Q?0GkW8cOlVErd+QT2QMQdIgI0D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88423c44-2e9d-4640-f55c-08de1ff9a3cc
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 01:36:59.8254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2e0nEtvgudbcl7nbsItTc5nr4dZCUc0FWHTTeIVF9oAifPUkeRt4oqvyjAJkVfpwf5fr5KvkIg98lnaMTcCNhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB2877

On Sat, Oct 25, 2025 at 12:11:13PM -0400, Aaron Tomlin wrote:
> This patch improves housekeeping CPU selection logic by enforcing that
> each online NUMA node has at least one dedicated housekeeping CPU,
> ensuring better NUMA locality for kernel threads and timed work.
> 
> Before assigning additional housekeeping CPUs, the patch checks if any
> online NUMA node contains CPUs with logical IDs greater than or equal to
> max_cpus=. If so, per-node NUMA enforcement is skipped and a
> warning is issued, since some nodes would be unserviceable given the CPU
> limit.
> 
> If NUMA enforcement is possible, each online node lacking a housekeeping
> CPU will have one present CPU (the lowest logical ID) assigned and
> included in the housekeeping staging mask, with a warning logged for
> visibility. The final guarantee that at least one present housekeeping
> CPU is assigned across the system remains intact.

Hi,

Just following up on this patch submission.

Please let me know if it requires any further revision or if there is any
feedback I should address.


Kind regards,
-- 
Aaron Tomlin

