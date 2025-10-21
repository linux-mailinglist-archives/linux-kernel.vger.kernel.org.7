Return-Path: <linux-kernel+bounces-863029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC627BF6D3D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49CD019A6662
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDB8337BBF;
	Tue, 21 Oct 2025 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SjRwzlc8"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013030.outbound.protection.outlook.com [40.93.196.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44D31804A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053878; cv=fail; b=J+QaK0NlX5gxeE+J8Q8BNVbVttR2ki7p937yS1XwEr9ryeJa4Bk8HohBNshxMfZCHZu90gp7Jkbc07ULoFEkBdci62PXkKBSuoJY80TR/xnNblZm9v2FupVvzroShgOGtsHU8OaclHsjZC+anbrR/zb69AStO8bNGDl+K/zxO/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053878; c=relaxed/simple;
	bh=MoYwSNOOJluJ32scipZXkCKkE8uQITrelbmEhQRbJB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hcaTIYaPvtFSsuu2wbJpgm++Rr72O5/tTUqu8Af2YvFSZuzBKy3NbpUW/ny++KxRsOosUC7tMJOajAg48K8Br85UVTTBtGUAbzOF6MnrBe0yr6Ix2P8UiKEMFJvys6uVnJagAP4w4ZvYWCZsDWPqjMM7VtK8BC+umoUPGDiVmuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SjRwzlc8; arc=fail smtp.client-ip=40.93.196.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OP28aBkzki5zRNhKqUk1jNAuVfgyvHRR4CTotFimF6cni4qeV59WycMIcdgAagUc2hkEX04hAr+J+Nd4BhV1MjLMvS5Z1lYHRCyUxQ/h1ukanTieJu4vOZuAbIRj9RRcHyyx9M2fSsnrD9/uNaZaiRqzrILTa066FyShZFhv9oEpnYPevC7GqZAmpLj4jcC6krLMgZYqaR3tKqHfbAe/HfKZtdI7bs8ZLK9ihFn0/BUUiB7TgjSGRmd3qORzU5ArwIyKFsNsBxAbW5qVLN73OiCcXYKR6lY20bnaaMXW3SXacBzKSsneSSFX6ohSOxJSwI/4pi5q57wT/5ixrgw6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcSbEFFhKwHOM8j6iVRgR+O7IkDULIgb5VCKrNtgwuA=;
 b=rb1I1yhL52eiqMNujQB3mxz9SZBEKD8nVM+JmigOz9/6oJRKHh5wiEmFiZG1VXIb6QturkB4W3JjPq2XgpseHm3rED6kRpUpqppcFN1eA6iGDLg1wZa5tjDdZGUgHM706WLtUfE9JAryK5eAMq/K9IV0vGpNuz0kwLc7tGLK1QyI/squjY7O9BIA9gdP3Mt83TBNDoZmrpQD9lKo7xKl1M6Rb0y2b/4thlzSReUqi37zGKdo1lqJMM7w/mcB0X4ETG5ak85WtLqRQKcq9gzL1ZSE6UH58opeMUelr1CEsekL6L22Y8MrHwM0FJhnMP6ZcE9/ahdzulx9gxauBBC63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcSbEFFhKwHOM8j6iVRgR+O7IkDULIgb5VCKrNtgwuA=;
 b=SjRwzlc8ALGxW6zuGcRGNnKXRqWxHJkz9Cs6VrOTF9fcsGd6xIWMDYF5oJAHFbdDdaKND1EwQ7+U+d+fwWbE9AUkxkEk3M1zS0suUArAeSxbx2/8vT0U2pB+4X9tGCRTJmnfeyuhhNijdjTQnhpCQ//yaxPIPn52TClyj6MaNWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 13:37:54 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 13:37:54 +0000
Date: Tue, 21 Oct 2025 09:37:45 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Filip Barczyk <filip.barczyk@pico.net>
Subject: Re: [PATCH 1/2] x86/amd_node: Fix AMD root device caching
Message-ID: <20251021133745.GA3976@yaz-khff2.amd.com>
References: <20250930-fix-amd-root-v1-0-ce28731c349f@amd.com>
 <20250930-fix-amd-root-v1-1-ce28731c349f@amd.com>
 <20251021122909.GKaPd8ldoGqAf5JPfQ@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021122909.GKaPd8ldoGqAf5JPfQ@fat_crate.local>
X-ClientProxiedBy: MN2PR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:208:236::6) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|MW4PR12MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ff213a-c8b6-4558-d4a0-08de10a7096f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QCqDkSsvgLaScptvXMA9hDCnXqi44mkK25zDcAVdRJ5xsbUjk9INTPrLsbx8?=
 =?us-ascii?Q?ray5sr15seB9xqo3WuRNwAV2GBg/Ru/aUU/i+po21F0PtEYkzuodsif6zwGE?=
 =?us-ascii?Q?BL4nYIQbmxPnPwJx9IOLirbKON5MzEnMZtHzaoiKXDPuTt3tBWO9dQ7jSNwn?=
 =?us-ascii?Q?G9I5xHH5KYjpqP9vIwD64S/vLhEr6HOP0GuXF0FDb5RakClj34PNVLM4KONX?=
 =?us-ascii?Q?3Hqw17PRQkS2JSVFolLbcIzlARRfTXlZiaPbwTOiRHyHG/DRIKDZhLKqCR6M?=
 =?us-ascii?Q?w4nINDmB2NnwAV0+pfjHG0lfKmDywHLU7m94Dv+UXGkv1LhVoBGn2cHSP36L?=
 =?us-ascii?Q?jtqfqbvbLnh9hu/l7/p/al9IK4u3imoB6VRsG9dJM0phcuCFZMnKiXCC8v3w?=
 =?us-ascii?Q?EI6R4YyqwnGovl9uYnt9oT0xUoOLHYrY4HJiP4nUajaqjsBxOWI1wiHQQxNK?=
 =?us-ascii?Q?gC/R2KT7ZgM0WvDDVe8JpVIHIuQqxuHgAMAT+5DS1dqxKhCH9lC3yP/lt8Kp?=
 =?us-ascii?Q?IFM8YG1z9o/AjxWsiP5q84YgklrGEhiw1rVwMiTfVsdQfTbEIFSOdSAdLm9u?=
 =?us-ascii?Q?+qmoXY9KkwlnIT1nILL/Wc5gCY6r6tH8nCH2a+DOTFucG5n+JmsNTDBQ30+Y?=
 =?us-ascii?Q?yX5wN59RgLWoVijOct+BkemkOCJ4nxawEQ75oUDt3Ovn0cyWMH/ubUhwHv2a?=
 =?us-ascii?Q?Zvcv866/MKTY4jRPXU5gKtT+Yr6U8R2L3KE/zTdo9sQWko3aE9RztzfbIFNW?=
 =?us-ascii?Q?0drEzHRvtvIT6q3pI1eEcS5YtBtMQad9EVlzCmK3f5ky+e0NmEFVfDke3Ju0?=
 =?us-ascii?Q?qwUhWh6wYpud4UZTQ1O+GEM22D8m5Q3SX/QwTiEao6yt0v9Qq4wOqQWIm3k/?=
 =?us-ascii?Q?HbYDaz9dj9ugLP7ptCkz9OT5NJZe4UOp77j3FdfrbLkPtLLpXaBv4uDFGxK9?=
 =?us-ascii?Q?eWIdKoNmVlv2C1CmjHKc/oqvCODADnBW0j/Z84xJG1112UmKEcH1Mv3bz0ws?=
 =?us-ascii?Q?RJSIKwGmncd2pWchkL1wIop7hRVnebbECinSJ0VcEceQVoLcQm55LnwgS5gg?=
 =?us-ascii?Q?fsc6E2OuVqyIMx7KpYXGm8GWEzLl85nHkiSpioCDKVLoagk5+QPFr8+clOtJ?=
 =?us-ascii?Q?vNYDWNgPl1A0lSEnvN4Vd8flSweUcPQfJDaR2tcOaQlBCLfzweJEYh12iHa2?=
 =?us-ascii?Q?CXVq7LqiKZ0krQyRnLIZ1xIAitdu3Ez/lSmcac4QksjZA4iwzpzDzIEiAx1A?=
 =?us-ascii?Q?dpqolzk2D4qKfjOWpIDry1jcz3kS5AnkaWOcae6kmsrGML3uP3oXiTv5gFef?=
 =?us-ascii?Q?d0IAdU2MKRrhrV71+O0QON3q/J8KFRj11n8+YXIWsT79e1zSV7rXyOHVFkaI?=
 =?us-ascii?Q?FJdO7Vgv11Qv6nsvo6LmhC0HK/8SSOZ7GWXoMU1CcZDyx6ObAQjawvQs3uRy?=
 =?us-ascii?Q?Ii2idMJtQbzl2KcwD3GaLJGWJv7qT0aF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZBXfNGqSuTmfest4QJfhjD2OtUOkQsXVel4afZAD4e6wKlFR/hG2H5sJzs09?=
 =?us-ascii?Q?Y4aVjyLdHxqEtibg3noCwDYBtXCEvpo6V7B7n6R3uCzh2eK1rsNvCpI4Vqi6?=
 =?us-ascii?Q?1SKLAaZ2WzZcukIindl+sxcDRB/PEbzm/i10BI9r6WLKBK2jMtgU1KGarpZK?=
 =?us-ascii?Q?lYTi0x82nG52sSo2HCF5gHVg5hDKwOx05Ac1vtxxLgRkGDYmaWVCwZXUao/5?=
 =?us-ascii?Q?MV2mH74fT4exxBBiYDFa+2HqGt9w0+0I1V+pD49nvCiFNWLuJOYJgehQZVVF?=
 =?us-ascii?Q?lhOul1rgyWkcxN/tuNd2gOmEpzVfhDmRpabU5gl1F+vs3XgeSSwIF+gmgIhj?=
 =?us-ascii?Q?iteU+pn8B3Jo5mVog27uf7Mpd8kZ5KWZ1kpBeTCy24aTOEF4Osve9wlI9eKp?=
 =?us-ascii?Q?CZRXi2UbusbMnNjKoslC+UGtLvkgHNJzeeZ+iv/CtLEadi+5m1rrPerN0anz?=
 =?us-ascii?Q?NkuaYROkMVWIFdkLRadWHp38G+ZH+BFjbie8JTAgIapB00L1MkwxVF06mv/L?=
 =?us-ascii?Q?aS4pTEifwIwI6OcdMWVIjA8xTV3w/Z/aCWJlIl4qv8qukwqBjLTsbilkn+Xa?=
 =?us-ascii?Q?oyCtCwGWp+dv+U4Um3JWxtlUWY+dmn/20+zgnj8i8c860Gqtpc/3K12hX/m+?=
 =?us-ascii?Q?sXuWAbznnxLohoh6W5Xeep2/T7E0wycwT7/rLM28CzOS/fqZtzDZrcPFmGWO?=
 =?us-ascii?Q?B6/Zi3xEZau3Cvu77c+xCC68KR5WN7wddoc7SWRMNhZT1HCbqe9G1+3fp7Xy?=
 =?us-ascii?Q?FAW+uVIXMZJ4g6+zNQlJuARD13r9ruWXqmWs+tV5DhQA9aBod9CbcQ8kdW/5?=
 =?us-ascii?Q?/ooLZGldIA2eyoCTUQ1UtWmfYuA8ZXSeIvzNijo0+BMgZfdQ+wwkLH3FUwQQ?=
 =?us-ascii?Q?Oj2MezXKhLopqGvcSLQwIUh241NUmMPNu+N8yAuvuwM0gNmxIB8UzpUd8YlR?=
 =?us-ascii?Q?3gG3V+bmrJMpLtIg9yJK1E3VRMeJIikm16H3K8U8YC7EkDwDWNEagq8dH6W+?=
 =?us-ascii?Q?pJygAgoYYwv+58e1M203uJVjAX96wfmih7CBLoejLgT/76Zy9nfWFMjfbFwk?=
 =?us-ascii?Q?P2wJpG/tFz/svntb+gtpch4TJMEFwK9YAbbq0281G5swPuxlMn96EVR/4akK?=
 =?us-ascii?Q?o2CmAqJpIuNPJcIgClDHlUAFHb2VRRw0eaau9MHNnFOgV0Bz8PfQNWxJFH82?=
 =?us-ascii?Q?HU4ETO0mMn+37NSa+WI+fFAX+JkeNKGsL4RmakrwFDzRPBA57GGJ6sia1KvS?=
 =?us-ascii?Q?LrLH2CKAk7GgBh9HP8ijEfFGGT2fD3riZOtNDqaObaBmjx1TgZroQgpRNKKx?=
 =?us-ascii?Q?KXhQxwSMjSCZClZ3IfX2IkSHhQlzfwuVDxMbkqcfCexd8mKrC3o3SyCEPsN4?=
 =?us-ascii?Q?TWqKkIV9mtyAjA6UcA/NQ4KwvZ/oX2nuhcVpJUjvxfwHMd8/YgSBfzF+9RKs?=
 =?us-ascii?Q?Ixzy0Hdg/gM8Oc0bjOjGTFIl87qEw2zbWbbXzQ0SHjd3ccyEjAhIMvPfquPZ?=
 =?us-ascii?Q?/kfPs4mQv2hbzfHDqpzlG2egHgyitULH5aaUIEEcnHDGR5x0g7xAwLbu0dXs?=
 =?us-ascii?Q?O0fyFxdJo0/uTucPBN/3m0uP2c1kT52rMFKBXriz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ff213a-c8b6-4558-d4a0-08de10a7096f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 13:37:53.9392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKtsCEvABr0Df/oHzq0iali/oSQ8ZqJeHMsiR6KvG7FxtxUltsxMYvalfwL0pXO6UrCSRablkBGSaA29852EQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873

On Tue, Oct 21, 2025 at 02:29:09PM +0200, Borislav Petkov wrote:
> On Tue, Sep 30, 2025 at 04:45:45PM +0000, Yazen Ghannam wrote:
> > Recent AMD node rework removed the "search and count" method of caching
> > AMD root devices. This depended on the value from a Data Fabric register
> > that was expected to hold the PCI bus of one of the root devices
> > attached to that fabric.
> > 
> > However, this expectation is incorrect. The register, when read from PCI
> > config space, returns the bitwise-OR of the buses of all attached root
> > devices.
> > 
> > This behavior is benign on AMD reference design boards, since the bus
> > numbers are aligned. This results in a bitwise-OR value matching one of
> > the buses. For example, 0x00 | 0x40 | 0xA0 | 0xE0 = 0xE0.
> > 
> > This behavior breaks on boards where the bus numbers are not exactly
> > aligned. For example, 0x00 | 0x07 | 0xE0 | 0x15 = 0x1F.
> 
> Do I see it correctly that one of the root device's PCI bus is always 0x0 so
> you can simply read that one and you can keep the current code?
> 

It's correct that one of the root devices will be on bus 0x0. But that
device will be part of AMD node 0. So we still need to pick a root
device for the other, if any, AMD nodes in the system.

For example, a system with 2 AMD nodes could have this:
Node 0 : 0x00 0x07 0x0e 0x15
Node 1 : 0x1c 0x23 0x2a 0x31

Thanks,
Yazen

