Return-Path: <linux-kernel+bounces-734131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D3BB07D6B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3E73B72AC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508D128F933;
	Wed, 16 Jul 2025 19:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FmemoE3V"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AB924A07A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 19:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752693165; cv=fail; b=bAk0mv9T+ZDk9eouw+8nzaYqrJypvMifE3DagJ5pdHdqYugD/TAAK9/E9fWb9+aIoGf8o8W9sZEmc3zjIPzXuCSgl2B8bNAS9RV+3UPi6wgKdCHb0idbO3BL9nZ9AFZppncnFVx1MPKed4BCeRCKUNYVYaPJPJ2VnvZAHIRqDiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752693165; c=relaxed/simple;
	bh=XyhflZl4ee7g6f4Fj43oYfFJP3TMRO+E2zdD4o0tgjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NNBrQ5neQOVQtoiSOJiH0bsWr1aKbc5mmqv8hUeW+nT48vpmRaJ9OQhXIMCDTXAMPwDhqUPeVcA2vlHz6LA1FI6cyecESPaLNMSfiR6hhOdt54WehoFsJ4kR2p7CiWRz6vujOP5dFDsW5v92tq3UiOy75rySf2+cKxCl3VdW010=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FmemoE3V; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEu1r11rgbcYWwvTusZGtB2KhJNToiVqVVmH33GqoS30bi7l+SNjig/bUhS44VKghOZWNMvMZoZ9cKJxzOM3o3/rPrenciPhtMPVkiIdmEwbNrs3/Yw5lbVOoyMSpCOBd6VlUCO1kaTDJgLsD/I8NUAT6bbEG7UEJqXsqB3Z7fUPBQKHQojt3p9snUy1ri75yVfCSVTgxDTJN0DXHGvhGlhhyeF+YBT+wd3756KjTGnyWScFDoLsvTnRgTR5qswhJlMGlYpv5cPqq6Ck+EUA/iT163LiBgGWm1cKdxZLx+/a+CF/Q7o8U5BDwDSH9m9CNC9feg3NBaAY3PAdY3sb2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5f+iMnKaOXqMocYRIsrfB0SyI8tmS00rb52lqJ2QxGs=;
 b=XdHR67vdd2AQzsIH8f72sF3uzjIiAk/yFKLOAq9p92de6evWIXixLLRLgR1uv0qJAcbcIlnJ4SULMAXQc1RrRJs2zvRzT5BGA4YUsXPcILPe8B3UJG1/HZ4FYwG7BDaUZZdX0BBEviOmJv5zyxzB/ZWkMx0m2GR3PeuK1RkO68cGl8gFNDdvhaBqFGyrUaFyPJ1xv+3Uk2tdnQC494zGPbkXIpFiRCQw8TO7eLp5mAxsBWFkbF6OhL9z7eJqhApEghT3sgNHbi5c0xwdOr35m3agktUMKgOy7Y3/lpEnZIoMLGyM6sbvuLurvC+hFtiuaWJYKOtXxOZ2pIScIyhoMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5f+iMnKaOXqMocYRIsrfB0SyI8tmS00rb52lqJ2QxGs=;
 b=FmemoE3V6JosL1o/eUxcFvyaF+a6kJLJsm0MYK6PwDCVJ2UvFSpMxWL8BZZsYKGS4yk23jr03kzKeQWHRalvLu0dHB3EWC05ulze2KQ6U4wB7DyEQGuIOShHF5+0nWE/uP1IGolb3rG2r2MCFxIYBTgMm6X0YfUYstSVlaTO4W1ub0+J7LvIFOxlRJkL3ifRi+fGjsYePBNho94scXDsr2BmndUNkrYXwvvaShYr+1vNXSCBGTZykMcjr7gZJGSWE3hcgaVJ8pXGFmQ+jJ9G3G9A/RUBAK9f18K93HQDUowlQY/BvEYFkbffmQtc8wJMASST7BDPQNsMFpcpYnI53Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB8444.namprd12.prod.outlook.com (2603:10b6:8:128::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Wed, 16 Jul 2025 19:12:39 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.023; Wed, 16 Jul 2025
 19:12:37 +0000
From: Zi Yan <ziy@nvidia.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Antonio Quartulli <antonio@mandelbit.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Kirill Shutemov <k.shutemov@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: refactor after-split (page) cache code.
Date: Wed, 16 Jul 2025 15:12:34 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <B0B7369E-2D65-4FD3-A1C9-2701FB455019@nvidia.com>
In-Reply-To: <38ef66fa-f10d-43ac-a650-233d53cfe65b@suswa.mountain>
References: <20250716171112.3666150-1-ziy@nvidia.com>
 <38ef66fa-f10d-43ac-a650-233d53cfe65b@suswa.mountain>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR1501CA0021.namprd15.prod.outlook.com
 (2603:10b6:207:17::34) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: fab6c363-53dc-470b-4c32-08ddc49cba4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pPxDphWCI1cAk8UxLqC//SenqerEtXAF2K3JyljpzU+z/0T5sHojsSodehuf?=
 =?us-ascii?Q?e0A/xJzHnYEBZHZu3TEhf3t+Rnrv6ZcgCBSgPOJl+h3kOSqmMXuR93HWNSy9?=
 =?us-ascii?Q?1n9Q+VPs8AtGbzR4sj9m2b/tQkfBCQh4hdqKNB5hzHfcHUsMAxb6LQAgTizy?=
 =?us-ascii?Q?GBGKeWU2ZcTvPKESm55qygAtld56B0MqtEuakeR9ZIJQ375YO8GJEh0xBRnl?=
 =?us-ascii?Q?YAQTvbt82IYjsvyfeOKFvH2V6SPQdCtzm3B121uVDc3DqwUgMtR0J/zrPOtG?=
 =?us-ascii?Q?kr5V9BwPZz3yFlJ8X1g5T5ziUf68/foLWMKfuyMstzVr7CJdgm7CARtLhRx4?=
 =?us-ascii?Q?wgj59/59eXFFye9VyyU3jhc9mSSAttnRhc76v6ctt7/gCHehDIiPmAwzm9wd?=
 =?us-ascii?Q?ooOK4VK18DHq6OA1tc4uGvERvIhTWJFCSdwlgsDRKihH6iAvxArDZ3kJAUeJ?=
 =?us-ascii?Q?Rue/6ezXkzp/vuSYLYpI+9YUJVcxLucrmpLRagXbgu2aT1hNUZqi1tvfLEc+?=
 =?us-ascii?Q?FDVw9oQRS14HzD74a94qjsoyfWP17fVTcxyosru/i4GdxTkBPsubF8SG7pOW?=
 =?us-ascii?Q?Au/VO0yGj67Mz2Ty+T9anjTHaj6Gcm+OxlGE62pgJubs/ngSLQEEnN/1URVJ?=
 =?us-ascii?Q?0vWdsXCQO0MWUJs+gR6WLS1rFtnprrGJ8lNJaADDvzg2WRkgDInh18R6tCtV?=
 =?us-ascii?Q?xTByqOsMnOs10OUrgkdzjq1oNoZUX8SuX03yeRB0PXAprFvhKBoU29KGBLxP?=
 =?us-ascii?Q?u4RLS2lQSAX6+Ix9OQxi42DYEHfdgLa7cPApnFJkcYNTHvsTIkaQcMiJ/pxc?=
 =?us-ascii?Q?Yg+FxQ0pE1L5OjR86N9Z07pQzoJPPavzE1mt5+w1KUmEc/zwZiI2eVAdc49p?=
 =?us-ascii?Q?DmP1bSpFbRtMxlYUXFUvKqJb4Ec7gEw30C0O2kVmDRzE1WYdpwh9lWpmSBn2?=
 =?us-ascii?Q?R1VuLwNB01IIxLTV3RDp+YB4I3+bcIduTFxcU3sq6H5LM41P+2wxl8y2cyKV?=
 =?us-ascii?Q?WWJeJ8H8ezrZpo6pJepitHMQLmdpwT3MmFAWdyNQtn+eStzTBG8snjraOls/?=
 =?us-ascii?Q?6RXPccYPcr/s4+7NzefOctUUDligWiBs6NrTz+KKxfEnEtmbOdxCCxjQTQO2?=
 =?us-ascii?Q?phPBcsgU9MkN/imJsDOG3FZ3g9Tw5u5I/zQaXVBUiplbxPxUtJ6JAwScfytu?=
 =?us-ascii?Q?oiSY6ILFJGFPkMLNNY9GpKcMK5eHjTJShuwhd3Yxvc2gar5L1+hIeFVFYmBd?=
 =?us-ascii?Q?NnfHGiHLUvWaLHguptroV2jcyBIJsPdJgAUIndgYREjfs52AbUK3O0hVInGq?=
 =?us-ascii?Q?nIbEXUGMLXrPfqjn/0q2Web1AkKuuEb99jcOGo4eInHyxrhNyQPQ+PIjAwm9?=
 =?us-ascii?Q?uTjGb1LYrbIbtzs4DNCgvgMrOaHgQtZe2+oIisup9q1IeOtL7Ern0M6O45bI?=
 =?us-ascii?Q?GXB7eWuVnEQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aAIfx1T3Cbfh3WTqDYpRgiWdfGIqEk+thTfHP/9dizy7MBV2rsE/zxisMVfN?=
 =?us-ascii?Q?np4BV3fwoS+z78n8ozBsrROGdCii5xX1lMEGnLivsgtvB691cin3CzOOav+o?=
 =?us-ascii?Q?nAH8mqv7BCzSQIemXVe4Omo5ul2LHnlEE+tMWYZKb/YWCfkplvk3cMa7XgLz?=
 =?us-ascii?Q?F4jw8yoLTE3qvqs/A9fFzB4D71fAPfp5TJsTEJo3qsWDVproDKzEcl+1c0eZ?=
 =?us-ascii?Q?5Btl6dzoGyRLDWGQMyLK7Y+UzU0DSOjGmlTr98KjZqMAk25pP9wVgYk2LfCb?=
 =?us-ascii?Q?WJUJXyak+bEOc9ewGCqrbe7w1JydahVHd9iWgwpQ7sgrzIg3KFuSEB6zMYM3?=
 =?us-ascii?Q?upCFYc7/NDyP2+Ej4sc+H8AQHiVnlMZRjycLbDmfcoHWzNIEotoaDzJpbEqR?=
 =?us-ascii?Q?Af97qzzbcgDws3hswKFROxWfhYEnGcgb9Pi3di/+18CNqKXG2HZjRupY78Wd?=
 =?us-ascii?Q?7jOIk8B0gYpZn6TmYJIqJ3CBZtQQGi9Djmm3FQuHu1EMV0xyQt8qeVTg32ii?=
 =?us-ascii?Q?DSj6etfDB6j9g2D+9lWYnQfwLukk24iUQbQ33ppDTfne4TIiBsaEJxGojKH1?=
 =?us-ascii?Q?p7nlPUv9mlgZTNX065LDZ/s7RMY7Ac8NuVkeaQa5W92YJL6GBAHrrm/rRsnM?=
 =?us-ascii?Q?KuAUl4EHENzr2Odbcl+Jz1Nl1Z2P2w+w+F0JUZQHBp8a561oGdYQEOPJ4Y+k?=
 =?us-ascii?Q?fZrvywJcop5H/z+L8KnBao+QD2y3mP018wquXo4lxuWDoeaEQqQqs6pdrab2?=
 =?us-ascii?Q?t1cDGzfcxuQLSiKVe7a8Y6OV4pOBUhgj+0EylS7XlZEVsJvIvf8ShA/EpvSh?=
 =?us-ascii?Q?C1SyE5UbWlE4mNfccKDjL36Q/kv/Zs02HRudyIMX8w1sDogu3A226ZlCCsFa?=
 =?us-ascii?Q?Mn7jtnp8EnHgFMwtfAi93pd8UktUaAxJI4/7baR4J3N2dp5Rkl9rOLyGOFtJ?=
 =?us-ascii?Q?VIA2DEOyjkkDfBObGbPqEmy6YzBuanZJHxR22m/3n1qS9hhxnmpOqIUtOPJb?=
 =?us-ascii?Q?/uQkr5v4GpBWtFrUT7V0RaTE5bYCUv0kNbbny/GVmtdrUit9eJG43q2eP+Ob?=
 =?us-ascii?Q?USVUB0yRXPFVlwY8UzBPmubg6hojBbAp9TnO1BWdpft06v3TAp7wnx/pMCFi?=
 =?us-ascii?Q?2eHhye2g3FwgOdGOQiO2+TFAt2G4idN6Ii7f2+mUEZww0QpKV9YEhadgOcnI?=
 =?us-ascii?Q?vvt9B0Jo1COTm0PNf1jSGDMuDcwZXkB8QqKaoLGBF8sqHgVCHHIKFM0JX8sW?=
 =?us-ascii?Q?VqIvFiFX4/hPQqMPOq9aIDRfnk4ItEmuKuicemouEQ7r55oQchwJEgTsh4s8?=
 =?us-ascii?Q?VTxRCmuNEC2IIqBTcxJrY5+qEEaHsffV4VqzijeJeAiXKPf48w3FL0zGoCui?=
 =?us-ascii?Q?++Mno0qKoZU/he4SOZt8lKn4zZDWoQS+tLQUZXQ7NBAXzfVAGv5Yhu/WAjtj?=
 =?us-ascii?Q?WLevpUZLcLW/AbovMeHK/THue4mtGj+EGN73HrFrQ3NLP50HVDcvxbVdVLAP?=
 =?us-ascii?Q?kiLlfh4f48KcyfK/NhWYw24eFZ6gcc1pj7e7qdlNgDos6hz2is3lCMIRopBq?=
 =?us-ascii?Q?r2fEpvL0dI2o8pgM7xeBeTpPos3YLfn6MLHbbsM3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab6c363-53dc-470b-4c32-08ddc49cba4f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 19:12:37.7396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SzRzh5EeR5aHdx1MH8rh7Cd0dzg0IodpYwHje6GaCngNWjSAcwFMlMRue+KHfjRS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8444

On 16 Jul 2025, at 13:59, Dan Carpenter wrote:

> On Wed, Jul 16, 2025 at 01:11:12PM -0400, Zi Yan wrote:
>> Smatch/coverity checkers report NULL mapping referencing issues[1][2][=
3]
>> every time the code is modified, because they do not understand that
>> mapping cannot be NULL when a folio is in page cache in the code.
>> Refactor the code to make it explicit.
>>
>> No functional change is intended.
>>
>> [1]https://lore.kernel.org/linux-mm/2afe3d59-aca5-40f7-82a3-a6d976fb0f=
4f@stanley.mountain/
>> [2]https://lore.kernel.org/oe-kbuild/64b54034-f311-4e7d-b935-c16775dbb=
642@suswa.mountain/
>> [3]https://lore.kernel.org/linux-mm/20250716145804.4836-1-antonio@mand=
elbit.com/
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>
> This silences the Smatch warning.  :)

Thank you for the confirmation.

Best Regards,
Yan, Zi

