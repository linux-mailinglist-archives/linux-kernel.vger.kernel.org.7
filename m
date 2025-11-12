Return-Path: <linux-kernel+bounces-897526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67080C530B5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A012353E08
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F9133F8A4;
	Wed, 12 Nov 2025 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a3z4y3Gt"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0DA33F382;
	Wed, 12 Nov 2025 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960204; cv=fail; b=F+YRyshEMlCRiZd2xoI5x3OvV13fF5ICfh2efWKoVrXVDPQBzd12T/A64CvPGe0HIi50oW30C58P99I3B9gDhT7BS1UwDWCHx42OPA70qzRQhRkmDgu4b5m3WFoARcDF5/cZPf5TbQkHkXSh5pJG9dirki2MeA75MDXusZIjQLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960204; c=relaxed/simple;
	bh=e12uivKGRpekv8Ao5IpbavjxINnDBmqHkpxKyMTKhEs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHayI1BPir6VNNLAVwXethU+KYjzJQy4SZlVkNIYUiEelJVTGaTj6cryUR10nLAVGoPF9jEcWxlXwAikVhz85VY899YvKwH/CSwGmRe4A9irvzFZmRpGldkqSQNWiBu2WcFAFYkoBIuN/2n1LNH0nqCCCxNs2mxtXzXyDk/XAI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=a3z4y3Gt; arc=fail smtp.client-ip=52.101.62.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNct5qNt5lGICe+fQLWJ4I6+c/tULq8HFDmS5zBxknlAk8uIwjxZOUmocSjKy5yDAzNrQxpiypmk6+t5YY47PjJq1+YovX2vtDaxxhPN7IrHQwnZuInJZfe14K/7fro72PABdC7vf7D5oLtALUBdH++c6+dscLsd9q1g/3Eqar/aUAg+o+yL2oaMMllOXH5nrG6xSw8ZSB2fb92U95idcLmUeWqNtpp4Rnqk+W2zKPU1dnUfbt6Z7krYiH9G8fHHzAxui0UKtarhCWCJvDC1Poagmq/LBNomdj/oEAR6BWebT6n6JDjwSCiew9e8WR9p4MxjbdRyrvw/AExxfN3JVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCB58Vy8ZtmmN+K2Jz2+forEBp/DSlYXrIiRl/Y2Ehs=;
 b=ueS4iPMBhCE8hGrrFboc8h+iNQ7dwVKqnXrnX8KCTB3lInuH94tuYG3fZ0nHSo6uET4T2jnwx1G7o9rGFokt5MkfoZixZbQrk+/CG46BTmcUw+kyHJlXvsc6TOCAl1DkN7U9Y+vHBcEdSF8KN5UzLAzNB1dDy0inGtF3caaF87gIs2Eipo+VqCIuDquym3qqxHltytvGpcN4v/qFv3s9q9jnqK1zsjGGXq9Qhq3tqec8I9QBcjqhe9ALBde19VE/IlWmWpR7o4zaIbGeADA9k7XHhAR4uYhVLh2APB6mjhVaqszEw96FwAvpardYxBppW1JvDARmvE5D7/vuj6UCBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCB58Vy8ZtmmN+K2Jz2+forEBp/DSlYXrIiRl/Y2Ehs=;
 b=a3z4y3GtX8nSuI6aRREQZxGI9ipYA61PW5UGNOVZiPH7hjQKornE4iEGzBTXbzM15R1gmvFZcitq1PUiBLsBStFUKSGTUU9ksM8ZIE/En7jWmasNFCu4LQ0TI+qeI32DVaGyvFVH0weuIwqd61PNTP9phftePtdhTtTe4gtm6Us=
Received: from CY5PR17CA0013.namprd17.prod.outlook.com (2603:10b6:930:17::34)
 by CH0PR10MB5178.namprd10.prod.outlook.com (2603:10b6:610:dd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 12 Nov
 2025 15:09:57 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:17:cafe::94) by CY5PR17CA0013.outlook.office365.com
 (2603:10b6:930:17::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Wed,
 12 Nov 2025 15:09:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 15:09:55 +0000
Received: from DFLE109.ent.ti.com (10.64.6.30) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20; Wed, 12 Nov
 2025 09:09:47 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 12
 Nov 2025 09:09:47 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 09:09:47 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACF9l2O2845097;
	Wed, 12 Nov 2025 09:09:47 -0600
Date: Wed, 12 Nov 2025 09:09:47 -0600
From: Nishanth Menon <nm@ti.com>
To: Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>
CC: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-clk@vger.kernel.org>
Subject: Re: [PATCH] clk: keystone: Fix discarded const qualifiers
Message-ID: <20251112150947.i6iionea3cqrpkxe@pacemaker>
References: <20251028161643.1727046-1-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028161643.1727046-1-abarnas@google.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|CH0PR10MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e1406c2-c47b-4265-d807-08de21fd89e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWVEanFpZEhzOVkvcm9RYkFYenJwQzczSGVXNTNreEdtWHJQb3lNY21WOE4z?=
 =?utf-8?B?dVRCNWl3dEN0elVVNmU3cXZjKzc2dE1NaVpNZEJOaG1OVHVFQUxob011Tktu?=
 =?utf-8?B?UWdRR3pPSmlXUWhlTEc5TkI3SnN5T0dkMUFscUNKZEI3YXZPOVZxVlpzWUxO?=
 =?utf-8?B?d1RuRVM1VUdydUVPWkdFdmNxVTFWT2wxbmlNZ0VST081NVNVenFhS2NuMlVG?=
 =?utf-8?B?NFNDRlRFWkFoS29vMW5wTkIya3hhajc0aFY4d2Nya3NmM1RHck51MEM0dUZT?=
 =?utf-8?B?SW5zLzVEL2VVYTVudXVIbUVXWGxUcWZwSjJ1UkczV1BiaVg0a2lFeklqMC9X?=
 =?utf-8?B?VDFFK1FySko0SWYrNnBPT1dTbGo1TlFaZ2lLUnlUelNKNXNIKzh1SDNDUGZi?=
 =?utf-8?B?aEo3TlprbGU2eFJhUGVuVkRjaFJGSzJmbFpqYXN5MDBPUHZ4Y0hjanJPSmRq?=
 =?utf-8?B?YStaRW1zdWNRekNOelM4MDZEeEVEaFRZWm1jeG02aFBacEtTdHE2V1FSbkJK?=
 =?utf-8?B?ekpGWHVwY2VrV2lUSDE5SzlFTFZKRnd0YndPdjJhZUtJVWNWR1VhTTNHcFRT?=
 =?utf-8?B?UndDbTZZUXVzZ1VlWkd5Qk5VMkFBZFNNR1lxWUpqV2p2L0s2ZjFyZlJMNStC?=
 =?utf-8?B?VndFMEpabkZCNGZrUlF3MTZSRFRZbzh4ckdwak9KZzliU3lQL09tKzNVVERJ?=
 =?utf-8?B?T29RV01JY0g0MUttZTJSZlY1MFlsOW5yVENMRFVPWEhjZHRtaWpZdnRnaEgz?=
 =?utf-8?B?dm95QjZsOGYwVzlqMW1iVEJzZ3diMVpORVVkNkowbHU1U1E3b3M1azNXenVE?=
 =?utf-8?B?OW1EZXhIOEVFSkFxMEQyaGhvMUxMNzhqYTB4UjY1eEczZDNybWpzKy9OYzFZ?=
 =?utf-8?B?blRwQmFKeWZnQytVTHlhbHpxaTlkeXc2TzJlVFllcGhPQWt0Mzhtczg3b3hh?=
 =?utf-8?B?OUJZeUZDZVV0NS9aaW1BK3kySTk4eC8wRVdwRHZQUWxQNVVFbi94VTQ5UUxn?=
 =?utf-8?B?eW1SZVo5aEd2anh4NFpzeEZtcDRjZnhMSnN2Q2ttVjRGTjduM3IvTXVRT3BG?=
 =?utf-8?B?YkhUSklPU1RtcDlFZjEwSWhNMmwxazQ4OEhNdGYzVC8wWjhCR0JwL0o3b211?=
 =?utf-8?B?UHpQc1YwdmNxYXdKeFpIQ3RGMVlkdExHNS9oVjJJVWNka0o4Y0lJN3A0MzBv?=
 =?utf-8?B?Yy9lQ2dlNG5tYjl1Nis2MjJVcElCYUlIOUxUNytubUZmUEd0Nll4T2VZeW5p?=
 =?utf-8?B?cUpSWE01OGkwOHdZUXlRM1U4VFl5T0k1SUduUnRvL3R4MmpzSTNTdWh0dWtT?=
 =?utf-8?B?U21iZU56TjlDd25oSmdYTHJBbWJHcThmN25oREZzcm5OZGgvS3lEZUM0ZEMw?=
 =?utf-8?B?QWRKVXozdXU0emhRZThJeDA2UTVTdVpjU0Z6OW45Sks0OGFCdVh6VWV0a1hk?=
 =?utf-8?B?NzAya1RNNW9OclRuRTJQQVB6ZWJkMUpMN29mNVBPN0xtWktSa3p2a3JHSEZw?=
 =?utf-8?B?eTlCd1RKR0szZ0NxdHFtNHZJc3FjWjZzeHI0SE1YLyt0bmNuUm9LVTlycTBT?=
 =?utf-8?B?bjNLM3RyQWdhRWpnKyt3aCtZVVNOanF3Tk9jV3BsR2pOcDBmZWtqS0I0eW5O?=
 =?utf-8?B?aGlva0pHZ1RxTlM2ZVZzWEVkaGpKZnpXM2hQL2NnNDNON0h5SHV4UzgxWWx5?=
 =?utf-8?B?U20zRC8wLzVMZ0pCMVg4SVF6UDFGVE9FUy9EV0lvSkozOUtKNkRWeHZlY0Z3?=
 =?utf-8?B?dkE3blZFZ0swdEgwUkpMcVdud1hoNmJTQnpMRzhJdHdDYm0xM0xOMGFwQlZW?=
 =?utf-8?B?N3hPQmV0eTZpeW0xQmg4OXlwU0ZoRXQ2WjMxWWJLaGRqclFpK2t0STJieFNV?=
 =?utf-8?B?SXBGOG1GSkdwQlg4T2xYeHhDZSszSm50Q0c3NnZZeCtSR3ArbTdTaEFjSUk5?=
 =?utf-8?B?aVZ3L1VQclUwckM2d0NvNVEyd0lQWHpRSnU2WFAvakw5VUY2OUNOMVlkZGZG?=
 =?utf-8?B?MjlvbzE1aEtEcGg0a01NV3ZyOFhxTm1HTVAxU2g2NDNGMENoRVhmUjZQSVY5?=
 =?utf-8?B?eldHSlBzakZNaW9iZWN4V3JiQnh0bFZZNjVFVWpockZLYzBRK3Q3R3o2aXdo?=
 =?utf-8?Q?ncIY=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:09:55.6200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1406c2-c47b-4265-d807-08de21fd89e4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5178

On 16:16-20251028, Adrian Barnaś wrote:
> Add const qualifiers to the pointers returned from 'container_of' macro
> to prevent breaking the const promise on const struct pointers from
> parameters.
> 
> Once you have a mutable container structure pointer, you can change
> structure fields through it, which violates the const guarantee.
> 
> Signed-off-by: Adrian Barnaś <abarnas@google.com>
> ---
>  drivers/clk/keystone/sci-clk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
> index a4b42811de55..9d5071223f4c 100644
> --- a/drivers/clk/keystone/sci-clk.c
> +++ b/drivers/clk/keystone/sci-clk.c
> @@ -496,8 +496,8 @@ static int ti_sci_scan_clocks_from_fw(struct sci_clk_provider *provider)
>  static int _cmp_sci_clk_list(void *priv, const struct list_head *a,
>  			     const struct list_head *b)
>  {
> -	struct sci_clk *ca = container_of(a, struct sci_clk, node);
> -	struct sci_clk *cb = container_of(b, struct sci_clk, node);
> +	const struct sci_clk *ca = container_of(a, struct sci_clk, node);
> +	const struct sci_clk *cb = container_of(b, struct sci_clk, node);
>  
>  	return _cmp_sci_clk(ca, &cb);
>  }
> -- 
> 2.51.1.851.g4ebd6896fd-goog
> 
> 
Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

