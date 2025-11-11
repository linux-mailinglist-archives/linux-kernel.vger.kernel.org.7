Return-Path: <linux-kernel+bounces-894380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7367CC49E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B5ED4E35D7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F23248869;
	Tue, 11 Nov 2025 00:41:37 +0000 (UTC)
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020130.outbound.protection.outlook.com [52.101.195.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD49244693
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762821697; cv=fail; b=lAWeEn8KtMANxOBFXjhX6j30a9TNmNK5t6TaEt3BVdB2whiO8+4ciE4UbGC8b36umAyMIhV8odXk5J9n6lOecgCiRbFpXabtuUyQednf22LJ8fjhi9QgSyR4R3M3fObPEaRZWLmVQpnW3CdxGBqKE8jX2qJKG6234oTBpSqH6+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762821697; c=relaxed/simple;
	bh=gOlKi9McpP4zkWJYHUbqGgzD59YUY3cREdkpzmXObsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tQecofHfCBbpWB+qC5uXotvXuvkxJZYouIK1sC9i+5jUEXaAfhWSyGXjxxuGKdrVBz+flx1XMXCEgnwJDMbkw64WpCSQv2CNuQ3XHS79BcFbg2sG8ttmfHx/L1D7nPlkKKz1+Uelx86ujYT4LwHdBcgPOJ504/1qLT6kFiS0niI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbfpywnRglYuBisrtTizodEoIiVA3pPKEMudeQXCPZ8UmgL0rFpfXNFXYHuLE/w+BSf6NJq52+f/DhqBT6JkvrrSJjiQWWEX0TBfqjWyvi7/cI8H92cdbCf4aL7UT2KxZMOntYXWJw/1W+jkN9T3ta7yz+tcYl04Zvqpy3QpxzjXbGziyJTV0aC0WYQb1hM7LwcUzIPeuC/21rDor6Is7s+LWLxHlCjl6eVmj3OGeQRznvgKMIRdJPnAUhHiNNniDYlMZ3O2fQKSKnR2RNvKQ6mW+yf4LgmVQyEnf0YMxfmwZQBAuzBF9g/8sMgKkZvOv1SYFpZiWia7hJArEW6PuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YC2Wa1R3yO0I3R+GEBOokOUMDwOmmLAKuiEd1aO6FuM=;
 b=yQTYS8n0imVZ9M7JT8w3DGtXHETkHGOM4zDQaqGEtFJ63Uijbm/RAWrlDydowqvYYco0Y2juXKVgC3/ezi7xuUqzrkPVb+8hrtTMldAYPb3FlTnJmkACdGG1B1BegIKqNt7ybq76aszXzOflO+mOX/NKADiKjgUvsRNFSn2JmTbgLSt4l2MdhlXXKHZWQzJ5OCahkUOxxZdSlLNy1x8wgMKQenMR/jccgKYPGshYsWP/xMFAHbvR9sYRduOissdrOKJm4W/g03xaXOLUdWDZm/jkyZJ3xMFecu4jRr9pLaKWKruGTc56L6zuMBOHOPDA7u5Q1iRS54TwNLm+cHVeZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO3P123MB3307.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:104::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 00:41:32 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 00:41:32 +0000
Date: Mon, 10 Nov 2025 19:41:28 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Babu Moger <bmoger@amd.com>
Cc: tony.luck@intel.com, reinette.chatre@intel.com, Dave.Martin@arm.com, 
	james.morse@arm.com, babu.moger@amd.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface for
 CBM reset
Message-ID: <knqdzael7yihvznsdzijztawviex2n3i5pqbzslmk3rolnacrh@h3cwjthvyeuz>
References: <20251107012401.224515-1-atomlin@atomlin.com>
 <20251107012401.224515-2-atomlin@atomlin.com>
 <2a0b270a-e398-4d88-aa10-421f2769a759@amd.com>
 <53iuqiul6uo7zj6sfckm2h465cjusaxvpxrtdmnbmhvbzuqiq6@7ogm3zqddzjd>
 <fa2c3cbc-2af6-4d98-bd70-8ab49cb0d83e@amd.com>
 <4whfbgq336xfuov4i4nwwrn35ywwlwizuvpdlstmdqzkhvwrq6@eits26xbwyz6>
 <bcc8e6d2-8e91-4e91-9dab-f1c00f99c408@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bcc8e6d2-8e91-4e91-9dab-f1c00f99c408@amd.com>
X-ClientProxiedBy: BN9PR03CA0504.namprd03.prod.outlook.com
 (2603:10b6:408:130::29) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO3P123MB3307:EE_
X-MS-Office365-Filtering-Correlation-Id: cf86b6b6-9e2e-4c13-746e-08de20bb0f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0NQYStMWE4vcWU2dVNMT3Q1NWtuamEzREErV3dUSGJQcWgrU1dOak1mN21K?=
 =?utf-8?B?eUFjUEk1QVowZms1Mmt6KzBnRkpuazdmdmtCZDJZRE9iTURHNlFnY3hwS0h3?=
 =?utf-8?B?cVhQd1k3bHhGNjJsNlFHdE9teXo3Z2pUcDJvMGpTSkxhRzNOMnloM1ZnUjlD?=
 =?utf-8?B?SzhpdmozVnR5Ry9PUUpPRnV1R0wzcVNHZWU1d3ExM2ZrR0d2TExmTnRQNWsy?=
 =?utf-8?B?YTZKRWtJbmtQVEpWSFZXekEwZWl2MXNHZHNVVFQvOWlORUJieHdVY1FiQjNH?=
 =?utf-8?B?SUt6TWlWTnMxdDF3UTZEYzhCRmVUc2dQK081N1RXbFBoOFowTVpRM05VYU1x?=
 =?utf-8?B?QitWT0dBQkhtTllieUtXSUZYR2liUFdZM1FKb1ZCYlhmSWdlZloyaXVkUGJv?=
 =?utf-8?B?UXdkZEMrdnBFWHJHUFZ1azVQT0R1L0tBaWlkSnlrWHpxclFXZ05DR1liT1Y1?=
 =?utf-8?B?NTVQRnM2bVg2YnVZNGpRRUw0NFQyRFdYNDB4RWl3eEdXaUtqNUpEclhZOWN2?=
 =?utf-8?B?dmtid1R1aDNBejNOTmtqaDhWbG4zLzhKME5vaHBKVFpHeGR2ajI2azVXaGJB?=
 =?utf-8?B?Y3VSVkJmRkl0T1VkN1JnQlltZlAybGlCMjJqczhBdWNUTXJJMEFLYWtNZTlj?=
 =?utf-8?B?dStNekZaSGZxS1VZTHJGOEVKWHo2a2FzdW13QXVBYTdZSjM5S1VrM1liZkVv?=
 =?utf-8?B?dFNGV1BtOUxYeUoxVGxHZU1rdXo4Q25FUVlYS1dvTy9kZmV6MGhEbFVNMjRi?=
 =?utf-8?B?Ylk1Z0ZQU1ZXbk0xT3k3MEJWTDgyd1FuY3IxV1BnSVZmOERGeUIvNWI5dXBx?=
 =?utf-8?B?UmVpUE90WmZrdkM4Nk11THY3RVlGY1FvSm93YWkxL1kvV3BIMEtqLzlCUFp2?=
 =?utf-8?B?YXZ0VWhtdnhIYmVaZ2JWRnN2aDFydHUvVXpxVUw4cVdvZXNaTG5telg0UDhj?=
 =?utf-8?B?QWc2eVVXZ2ZjNWtHU2VtM3lRYnZVWm55YjdtRys4Ky9zM0dqbmlrcGM2TUxn?=
 =?utf-8?B?TndpeGVEZ1poYVVxK0xoYU9pVGVpRmo1ZTcxdVlhcTVTZ0dKeUVoc0h6L3FH?=
 =?utf-8?B?QnlGNzN2QllNNDFCc0ZDQkhwMDB1eHFldDF0bHA4WmxURnVPSk1IMGVlRk11?=
 =?utf-8?B?WnpXSzZrdktVdThLa1krbEs5ZGs4UE5DbXgrRFo2UjNJUGRIYnd5RGh2cS9q?=
 =?utf-8?B?YXlYNTN2ZWNESDZRcnJKTmduMjUzdUFuY3ZoWDJyaUlXYnl4Y3JxZjRGMDBj?=
 =?utf-8?B?c3pFQlBIQmtWWjA1Ni9Yck5UdVAyZ2VCYk1yUTQyalBuNWRSNnp4dGRIMmpk?=
 =?utf-8?B?WlAvS1VFVEZoTkV1OGlsT0tNeUg5M3k2TnhNNkxxUkY4U0Q2YUhlMjgxeHRz?=
 =?utf-8?B?Z2hvL3kzNnJrQlBaRytFbnJCL28xMjJMdXdETFJaVnlNSk81ZDFPcXpuWmE3?=
 =?utf-8?B?aTZwcWdMK3cwTjR0T2hwSkJNYjhWNnZNcE5FMEJUemRvN2FwMXdMSEZoTXlH?=
 =?utf-8?B?RVF1SWZzcHNaQ0hCWmdHcVN4aFAwKzhkK3JIRUpDTzU5YlJ4WVZhb3d5V3RD?=
 =?utf-8?B?eitxdUl0Rkg0RVc1OHpZeUs4eFhCWlZ5T0oxVjM4TWVnTXhDMU1Iazlpcjh3?=
 =?utf-8?B?bzBQbHc5MGdmT1NVUW9DR2Iwa2JNdkFrTkdtQnNMcytkNjhucE5WRjgvMjhQ?=
 =?utf-8?B?NDZtY1RtNkR2SXhxOVRNOW13V2x2VWhQVVVMVWUzL1NWOTBuL3RpUC81TUVz?=
 =?utf-8?B?WW1XUUNTYXM3NXhiZGlBOGdKbnRuOGdUQUFIRTVieGw3cVE4MStaR0E1aE1y?=
 =?utf-8?B?TWlOZjR0Y3NSUGE4eUtXTDBKVlFZcXV3MC9XMmRVWEw2UXUwUThydFF1TGFL?=
 =?utf-8?B?dVgwQ2hucEwvaGJZcWZQdG5PY0RNNVpyUHRNQ3VzN3BJR2ZBZ3lBWVJnVll2?=
 =?utf-8?Q?fSybYhV6+2D88+U6JJhY6hBP8lNlT/gE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTluM0trd2dOdm9adzVxdUxBUEV6ZzVTY0R0U0hsR0drY3cvOFJCbFN0SW0z?=
 =?utf-8?B?ZDNiQW0xb20zSlYvOFRkc0RabFEzMWg5VlBTWkR6VTBXYU5GZDBHSDd5Sm1i?=
 =?utf-8?B?VGpDZFNPZzNnZGlldVRoK3prUDJTLzNGWEFmbVRWS1dWVjNZK2xuOE5KWU52?=
 =?utf-8?B?UVZpMkhmbGVEcjNVYnVEVVJUdEVpRHFBSzgveDhHaFNuS0Z5STNLa2pvREFD?=
 =?utf-8?B?Wnd1a3M3VFp0c1RZaFROSlAxalhaSEcvcWlJTzF1UXJ2RXJTeVgxWVF2bWky?=
 =?utf-8?B?VWx0dGpBbjhiZWJKRFU0MVRWaTNkZ3MyYVZsZk5VR1grd1NwL3prNm1kMitZ?=
 =?utf-8?B?NGZhOXo3OU5EOXdKWG9ETDZNMll3c0h2OWgrdnZNa2ttWWU2ZGFXWm93c2JP?=
 =?utf-8?B?cHV1V1o3bnYxcmg0eXRVcTQrdFNmTzIzZ285VDZwYmU0UDNoZVhQbjVmZ1VN?=
 =?utf-8?B?VkpnSUZZL0gvaXJwYUF2cFhxMGRDV2VjYlQzaGVZTnVqRE9CY3BUd3BCVGZT?=
 =?utf-8?B?aW1XMGh1bTJFakRTY3hiejVpejIwYWNCdXhDdVM4L1BKVFRoVFltWS9EUXYy?=
 =?utf-8?B?QXpFdDJCRUhodlQ1bnNLL3V3MzVTQkFyYUNJRmNxRm5jU0ZJZGZOcmo0N1Vh?=
 =?utf-8?B?MmVueEROTDNBY3o5RDd0OFJ6dUw0ek01Q1BEVkI4YzVwcTZLaXFmR00wZmtH?=
 =?utf-8?B?UFBmbkYyVUVCZG5hV2hmd0QzUFVFNnNoV0xVTXNiTFIxUkNENE9OM3ZDRk5S?=
 =?utf-8?B?Z0xkc0NiV3VLckh4OEU0czNPZmo0TS8vcTM3bEtTMHhSY2RzdE9HSHlTblZy?=
 =?utf-8?B?U2ZJcUZKZUZBYUhYV2EwNXRJSldzaG9hRjkycGxad2I2d2s5WkMwVmpwc2lU?=
 =?utf-8?B?ZDNHaXMvMnV5ZkQreXJyT043Mk93TElESVI3M0EyZ09NUERLS3YrQ2JwK1o1?=
 =?utf-8?B?TWpSR1h2VHhnQ0R6ZU93RVhQUUp2bTNTakwweUtyZHpsQlVEc25LOGJZa2w2?=
 =?utf-8?B?Zkd1NE5GVjVVVWVDaUhiNE5yVTFEUVJmeHBlM2lvaThhNE1pWkxOUmVyQ3JQ?=
 =?utf-8?B?bjFUOS9jdGJlR21IUHhGcXE2QllqWHNYSmdTR3Q0a1lPNmdQdHBURnJJWTdr?=
 =?utf-8?B?RW81RHdGbkkwUFVsSWtKUDZ2elpDaG5kT0pJYms3amVpOVh1RnZNNW1CZFFP?=
 =?utf-8?B?YjEwTlphVEN5aGo1VGtHeFBOSlArcWZ2alFuZVRsbTlDZDMvV1NacDFvbm9q?=
 =?utf-8?B?cHJzY1duRHNRRys2NGlpdldrcFlBSXBjWGljSDN6UTZWQUNuYUc0YmtYak8x?=
 =?utf-8?B?anErQitHYVFkQjZiS3hWUVNHK3lNVi9uTkVUM1JwY3FOWDVkM1VUdFFQc0oy?=
 =?utf-8?B?R3laSmxEalZWQTMwbjBNVmJlaXdCMC9SUEk4NnlHUXY1a0duaG90NkIwN2l3?=
 =?utf-8?B?bkorSndiWkZsSlpQZ2NhYkNSNllzWDlZd3hhTWxDdEVLWmp0OC9vcUZuZVJQ?=
 =?utf-8?B?SzQ3WVRoM0QrWG4vK2FiRzAyNjk4dzFjRGtkNG1NK044SS9xTVpkOTNka3F0?=
 =?utf-8?B?WWM2ZTk1OXdFdjIwM1AyNzVDeDlUcEdOK08xY2F6QmZlQjArY2tDQU05cHpT?=
 =?utf-8?B?c0RxT29YWGJ5V1R1ZVVucUlRc1NWYnYxVFZ3TVJVTmFkYThQZWpNSFQ4bm0y?=
 =?utf-8?B?Sk5Ec3pWdkZjL0psaVg1WmZrK2M1UDgzS0JqcDFaMXkwM0dVZ3RXY0VGOFcy?=
 =?utf-8?B?VTIzMWxNMWpac0RNQzZyM29hMjN0TE4rWllROHFWek9MNHpPK29PSVF6b2h6?=
 =?utf-8?B?bExlWVhpVDRuZWcxVVlDZEg0Nk9wbWU0VnEySlliODBaRllyVmk5NlE0cTFl?=
 =?utf-8?B?WUFaN042dXFwNHBxeU9xYWp1NFYyTkFRWUZqaTRZSHRuSEtoRldhaDl3NXFK?=
 =?utf-8?B?eDdsaWpqTi9uV1Rvbm1adVpoZzR2aU5vbTBkQ090RGtUMUEvU2krbTF4RHBP?=
 =?utf-8?B?V3piWURYekNlaWQ2ZnJ2Uk01NDBGdG5Hd1drNTlDT3UzUlVGeW1CWDE2MVBk?=
 =?utf-8?B?SlMyMjQ5TklkWC9jZGNXV0hRcDFPY0FGcGszRHBjd1VzYTl1TmxtTHBZNXBF?=
 =?utf-8?Q?t3sfW0R6Ur590aOCJHZkG2Yq8?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf86b6b6-9e2e-4c13-746e-08de20bb0f09
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 00:41:31.8545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGwPjm1H7CiINMxbGWxFRmRL5JdmpAY+Bl/K8MKseTnJlWJvlK4jotbPfUQPsmrovTplFFFKA/+kmWuII72PrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB3307

On Mon, Nov 10, 2025 at 10:34:48AM -0600, Babu Moger wrote:
> Does the following option work for you?
> 
> # echo "*=0" > /sys/fs/resctrl/info/L3/io_alloc_cbm
> 
> 
> Here,|*| represents all domains.

Hi Babu,

Thank you for your response.

Unfortunately, this approach will not work.

If I understand correctly, the assumption that echo 0 (which translates to
a CBM of all zeros) would always be accepted as a "minimum" value is
incorrect since r->cache.min_cbm_bits could be greater than zero
(e.g., under Intel hardware). See rdt_init_res_defs_intel().

The goal is not just to "clear" the CBM, but to reset it to the smallest
valid mask.



Kind regards,
-- 
Aaron Tomlin

