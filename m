Return-Path: <linux-kernel+bounces-740268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A433B0D20D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A623A8823
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD0A289802;
	Tue, 22 Jul 2025 06:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EAS2aTIF";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EAS2aTIF"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010066.outbound.protection.outlook.com [52.101.84.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6015228C5C3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.66
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753166936; cv=fail; b=WYjRk1JKryq8UWxCI0bJBcbFjZEWP/NcBbWyR49vTpDPy3XYs2RpejYzO8o/oA/mrhRNND8mEbNfZU7uo3ggieX7J3Uzlc/K2WBawIPP3bVYIIH5uaNMIIRJhlPAezaOCdoB/L5z1EitLcGwzh/A/zDqz5qQUoahwnl3ppFKsoA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753166936; c=relaxed/simple;
	bh=MyYf6dugXhB79DwUSWqH5oyHQBqYbAPWlqyIcG3S5JE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BFt4Gl1/sFRqZtXD1mH19Xy+S7guOccFjq6Q7eQf8vQnOh89Htq8eDNsBx7LIWsFT0CeW8RP0evgpukskBT/NVt6NeaVTB1nZS6qBiv1+BokQu5sxwj+J6YyXj6eKHxeeijYwCndcVpZo/NWuB5te5jgeAPWAj91/T/zTr2tcc0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EAS2aTIF; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EAS2aTIF; arc=fail smtp.client-ip=52.101.84.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XIRnsok90/uiv6EuKEdr/57a5pEHTutLCXD2zTljvP8OQDEZViiSRha55NwL3JEPDIH86MdCd/MaJex8WsQ1vFnIG1cgmPxlc7IZKK0+DxJylVWhyXOPaQ+KMMcRIyEcqJL63J4mSPf2pJXLwW9salU808s2VFxNsq16iLUGOcBx9eUHaCE5p/uLahlGQKNyt1CtK8isnWx1bsv3CqgM2l6xtCGGvx6eSjUWgQESMobrEAoTs+LQuvkNStWHvEYvXIAXWk/qxXjEAzVjztvII96EzOL6fG7KhcB8Cv5v7nEteRygZtcFTPyYaafsjgKY7o33m0ZmrXTLWZYo0iNHMQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgdiXv2tjvE0tWiOTZfr04XHNLmacF4/+78bPru3UFI=;
 b=eg4ASOXHm9NP9SZscMuYm+aayGR0rqoVPHsJUJm+Qm6zbAZuFJCTaTI1DrWEHSYQ6GSSi3+7blFJKRK5JcJMbU2pkcSmJUE0P8CwWNBIrbu3tt2Dgly7pnySU7e+hbMRX8P0HozghR170qvNOqieINj9fQPR0HhCQ+fK0DFx/gzdK2FTXCgCUTc+Fji7snEPfHOeZv2w9JhR4OlKlotREooXjKNg7Fkjo7Aiohe12x/m78R2VHcxumPtcJK3/9j63pLqs1AzNAR6n4dUd56AHTe4QUAEN0zi0sjCaL68UWR6tJ8VrgXbYp7P35/JH+MtH7aT9gRMQnlEwkHhpFh6sQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgdiXv2tjvE0tWiOTZfr04XHNLmacF4/+78bPru3UFI=;
 b=EAS2aTIFnZQ2eKq9r6b/vj92z1XDxY3DB/4Zx01k1LBo2p+6es1n/Qp0vvOiX2hBSgDI1xPc/c8QHxxt39ugmwsCZlErQF12uTga7r3L/9/BT5A2Fi2SJwY6HhbbkxHTKG4UKhmSkF3+mtbjDqgt5h3126P2pEvkwyd6xM1AmYI=
Received: from DU2PR04CA0076.eurprd04.prod.outlook.com (2603:10a6:10:232::21)
 by AM8PR08MB5828.eurprd08.prod.outlook.com (2603:10a6:20b:1df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 06:48:50 +0000
Received: from DB1PEPF000509F2.eurprd02.prod.outlook.com
 (2603:10a6:10:232:cafe::e1) by DU2PR04CA0076.outlook.office365.com
 (2603:10a6:10:232::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 06:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F2.mail.protection.outlook.com (10.167.242.148) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Tue, 22 Jul 2025 06:48:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYG4bwa1eTg7OHAsljHufYcDDpJJ0+14itXzGbHGKhSsG72iVjA2TCIJitcgJebKrN6ZaLzNyfZJe/De1rmUHCulMK3b9pOV8D+PDsAtJIomrVn167Jkd14ZX8HUPLJKd5zbAVBMnd0s22pl4MFf8FbT4K6vCIfJPolUPvamA4bqiwY5dRSIVbs7u+nJ+qQM8V54wc/SJuGP0jcdRnoMnBJbk+GiF3C1k4edMBZdsg+4Vaj6UnqDGxrh4beo9FWVVJD5eR9SBNjJh1p+QLBuK1HWc81b43RWpZ/kTuBToxSUaATeKUNqBDO48MjkkLNFzbzn6w19yZ/9H7Vk6VmgTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgdiXv2tjvE0tWiOTZfr04XHNLmacF4/+78bPru3UFI=;
 b=kHDDqU57eZDUfhSzT4wHCsjBnF9NMWy15ov3lEDn1ZindggC8LENcjxVLCj18f/QMp1HqcfbQVr1EodsVGhfXIysv07kUuZiJCAYrR9LMfSx0svIjtqztlhC4MhQnUDTJnfXgTZub3UcscwZ+YN3C+8zr60pDDcqu0DYQGkDOtzpkobfgnpI9LSRBtXh1PPhC8tOWK1dU1oZ6ZKZ++8ehmrR29rvwsEPT2D3s8c+ZjAIBjSC9XsMZftDvOceGiee9B8G25Q3VUj0a1kOPsX2Efrq0nGwmGu9j0wZ0cLqtQGvvZlD3Dy3h6boT9AdTQB2kmdOsmlRHmsgTgl+DwTvqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgdiXv2tjvE0tWiOTZfr04XHNLmacF4/+78bPru3UFI=;
 b=EAS2aTIFnZQ2eKq9r6b/vj92z1XDxY3DB/4Zx01k1LBo2p+6es1n/Qp0vvOiX2hBSgDI1xPc/c8QHxxt39ugmwsCZlErQF12uTga7r3L/9/BT5A2Fi2SJwY6HhbbkxHTKG4UKhmSkF3+mtbjDqgt5h3126P2pEvkwyd6xM1AmYI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by GV1PR08MB8692.eurprd08.prod.outlook.com (2603:10a6:150:86::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 06:48:17 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8964.019; Tue, 22 Jul 2025
 06:48:17 +0000
Message-ID: <c185e160-1b82-41f6-832d-cef3938a1a9f@arm.com>
Date: Tue, 22 Jul 2025 12:18:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: vmalloc: use VMALLOC_EARLY_START boundary for early
 vmap area
To: Jia He <justin.he@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Peter Xu <peterx@redhat.com>,
 Joey Gouly <joey.gouly@arm.com>, Yicong Yang <yangyicong@hisilicon.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250722040850.2017769-1-justin.he@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250722040850.2017769-1-justin.he@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::16) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|GV1PR08MB8692:EE_|DB1PEPF000509F2:EE_|AM8PR08MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: 5639fa36-602d-4529-c7ed-08ddc8ebd0a1
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bC9SaWxabXE0YlNxZitqRS9LSWhObVU5TWFUZVJwbVlERW5YQjNNYlV1cjg3?=
 =?utf-8?B?YXZTUFJWZDNkNkpWb2VMcE9KMzNTNDZLdTZQamIwRnRrT2s0RFZEZzBrVEcx?=
 =?utf-8?B?UDNreVhhL3BoUjBVcHNJT0M1ZFA2ZGtRVHZBQ3JrQ3JHSlBZNVlZaWdJeVds?=
 =?utf-8?B?NHdnQjhYbjhMNE01d052dFc2OUc3M3Q2QU1QYk5rQklLUHBTZEdnbUwvb08v?=
 =?utf-8?B?TjRtWkplbzY0QlA0a0gwU1l6cWxJTFFYN01jSy9Cc0VyTk40c1A0NERJWm5t?=
 =?utf-8?B?VFA3bk5HTXo0WFoyWnlaeTRIZGJyOG9BZ2RNZERueWdDc2hMT0FwdVpNOUVi?=
 =?utf-8?B?NDNhQ0FHZUNDR1JEdTNaV3d1eEJKMDdseEpEUzczaTdnS1liMm81emszdnVW?=
 =?utf-8?B?d0ZrdWZRL1NRUFcwaG11NVRsVmRhdEVOUVdxZHh4QlZPY3Bsb0I0SHcyekU4?=
 =?utf-8?B?dFROeU9yUnUvSXNqZWtiU2dqZ0ZmYTI3cmZ4eTlYZm9UOWZQblF3V1RMeFBy?=
 =?utf-8?B?ek9RM3ZGRm5xSU4ya2ZXRFl5MytYckNhOXVwdGhsc0Q5ZVp3citlVXcyM0Uz?=
 =?utf-8?B?Y200M2xUNzQzUlU2akxqZ0NoUSt2TllKeElCaXAzaHM2NjJrKys2VHRHMDMw?=
 =?utf-8?B?dlpUYXNaVWlxVEUrRlNXa3FXTHQvczE0U0d0U09IMG1IV1pMZEk3YlVZYzFT?=
 =?utf-8?B?ZlI0V3JnMnJxeXBxaHZPcVBVcCsrd0F1UFY5MHNheDkxYlVVODRDMkRKMkJn?=
 =?utf-8?B?b0k5U2cxRjJoeXd0d203c3piNlFnNlR2OWc0TEl4eXR1eWQ1OThZWUtqdVJS?=
 =?utf-8?B?ZGUzQVFTZzJKZFBhc1E3a3FFZ1JjWWZoWTVETmdvMkdVb3hEcDBmU3ZiWldi?=
 =?utf-8?B?b0lUblNEZ3pJTEh1Z3MybFV1end2bmZEc3hoaWVUZnZ4VjRxZnRCQWVtS1pC?=
 =?utf-8?B?aVorbXhKUndjZ3RybjNLTUQzY2FZbmg3OUpMdjNXU25GdkZsUHZkaURmUDAv?=
 =?utf-8?B?LytsbXBrTnBEeHpVR0lTbVRKSVhqbW02TmpiSElFWGpid0w1aithTExyNlhH?=
 =?utf-8?B?bE5sVnFjZGh1QkxLM05NU3NoTCt6bUtTSU42Y1ZlbFBxSXVETEdYcDRvUEwv?=
 =?utf-8?B?M0N4cnZpQnpxcGFERkkwMlZQam5Ja1BwQXl4YTZuUXFvTnM2Nmd6bnlScVJp?=
 =?utf-8?B?YWdMRnpEWkxSa2cvNDhBVG5NM2JMUkQzK1ZITnMrTEFQQTFHMkRXbXhkaHVF?=
 =?utf-8?B?NmFBb0Q3RWtKTzNoMTNmcjdhZzRpQjNRbUxNSDcrTXlZZ01idjBtRlRDS2gr?=
 =?utf-8?B?anBIamVnd1k0MXd4TEFNU1NZb0IwRnJISmYvVUlzaVA1K0daYnlSUmFNVFF5?=
 =?utf-8?B?MkVnTHR0emlRVEJCblNzc0xxN1B2Nit3ZXVaaU11ODNZNXBMMk9QVGRHc3VK?=
 =?utf-8?B?UDhrOHUzSWJrM1F1MzRmV2YrRUZtU29uYnFjbndSYmQ1dUxFTzU0Si9tVUEr?=
 =?utf-8?B?SlRUcUVQSlVDS1JEK1pvR1Zadi9GQk9Ub3U3NmZQV1ZKZkhiVERqZ1pvYjgx?=
 =?utf-8?B?OXpLREttS2JzR3VtdWdubjdVUnE5V3A3UUNrSDI0MWZ1VkNuTXNZNlo3Y3d5?=
 =?utf-8?B?a2phM3hzNG5HZGFHUmRKSHl3MnlVMXJ4OWc4QnBGaGU3VGhHZjl1bS9uUm50?=
 =?utf-8?B?MlE1Nm42aUFXZUZNYTRiWEY3NnlpU2wxWTI2TWxkOFF1YzNFWURkMllEbS85?=
 =?utf-8?B?SmNGK0pPNU0rU0htelJQeVhIbXRINVEyMWhuaEFHU0pIb2FCYkZMNEI2OEVP?=
 =?utf-8?B?SXhBU05QTUtISEpySE9jdG05aURFTDkvZ1VtM1hCYnlTQzVhb0FwVDhHRVdR?=
 =?utf-8?B?cjJoNEZlVUp4YjFqSHQwMVcrdkg5OXR4MTlEZ3FiRjhqSHNjK214MFJqY2hw?=
 =?utf-8?Q?mcnylB4PhzY=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8692
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	49c6dc9b-2d98-4135-7db1-08ddc8ebbcfc
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|1800799024|36860700013|376014|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3E3ZjlyMXFJV251YTI2Smh2VkZhbVorS3I3dHMzbHcza2pmYXk1WTRBaE5x?=
 =?utf-8?B?YWVNbTIrekJHS29ZUWE1L3Q5ZnpXNWFwVWpuZHZuVERYbG9qVFpmYzZRNGVy?=
 =?utf-8?B?Y3J4OVZ6WkR3WGNGME52Ukl6czhuKzBCeHlOOE94VGxIWEx6VDZhZG5VcndN?=
 =?utf-8?B?aFlWUlMrOS9mVU1iYU9nZFpldm8xM0hvNEp6eDNkYnBTZjBlcE9NdlM2bzVN?=
 =?utf-8?B?NmVxM0V6SXo4VmlRcWoyVHVIRGlPM29TRnVmeEdmRFRnTUl2WjM5VzBjdTZ0?=
 =?utf-8?B?c0JXdndjQkZnbCtDWWxRdkZwT3I5eWQzWEZnSkxNSjg4dWhkcEdJc3pLcDB4?=
 =?utf-8?B?aGt0TEx0ejhnQm1nTHZRMnc5YnF3RTlUaEFSN1h1cGQ5UmtaY3MyQVdmS1Y3?=
 =?utf-8?B?OXRWNDNuWHE4djhCc3h5bDkxSEpmcGJ1UFgwb2lnZy9yMFRMeGd0Sjd3OTJW?=
 =?utf-8?B?Q2wrR1pUb0w3eXB1Z0ZPWWJqU1pyK3I5aHVhc3V5WUtLZ3p4dHFXQ3ozQXNt?=
 =?utf-8?B?QStzaG9PWmw3N0VqOGo0d3NWWnFxWDUwdkpmQlMxMUM4NjhiUHlGVFJVL0RV?=
 =?utf-8?B?Y0J6NDRYMnZFQlcwcjI4VWZLV3hPdjNRV2lwQ2FONk96di9xUStnWWxwajlY?=
 =?utf-8?B?c2VqS2ZuZ2V3Y1pwNkYxZXdKbVZ4SUlaMEVMYUhTekh1ZXRmdExibnpCYmo2?=
 =?utf-8?B?ak9sc1JIL0xHQzBtWGtaRkJiTzAyQU9HeCtSNng4R01uT1N0UUd1VXNaallp?=
 =?utf-8?B?OW85ZkZEL2FMZW8zcFlGZjg2Q0I2MUkvTnJSSndnYzMydUpZSzFkblVRUE9p?=
 =?utf-8?B?NGR2RUQ2eWgyWE9LRDRiMjBlVk9zb005OFVkeWNPU1k3RXBzanc4VGpOc1hK?=
 =?utf-8?B?ZHFqVFo0MVl6WTRleDRuY3d5WmczY1NzSldRZHVmQkNIWGdyS1dnRGZFRUlS?=
 =?utf-8?B?RCsrS3ZkZlpqS1NCMmVuVStRbmFNaDRCcVN1VlNseFZKWmJBM3hwU0t3RGtD?=
 =?utf-8?B?U2J5bUlCd1UwdlZTMVJEOGs2V04rWnBkVVhNZGhuNEIxMGNhK3RyR3I4VzFU?=
 =?utf-8?B?MVNQbFhvNG03WnlncVNyV0h1QjJVRDhtZkRVd2FtVXZDdFhyZzJHUDBXZHlj?=
 =?utf-8?B?U1pxRGN4a2k0UGVtUzU5dGNaT1ZYL002aVQ0VEZwbnV6cEhKMFJXTEFkSXp3?=
 =?utf-8?B?UlN2QXIvQVdYYStJcXhaci9jY004TjlqNW5NdWI2NVdyQ2lKVXRTKzFJTFNZ?=
 =?utf-8?B?QUtrV0FsWlVaNlhVNDFJOVUxcE54UUlmdGNZZ0NWUXJZdisvSi9uN21vb2t0?=
 =?utf-8?B?VVQ0WkNyN1Vib1F4S05MLzNURXBxYW0zQk9CbERqU1lubFRETWdZMjluUVZJ?=
 =?utf-8?B?Sjl1bEVvMWYyUVljWGxjT1ZqcWdvelh1TE1KS2g0WmNBTmpyOE9mVHdZYkZz?=
 =?utf-8?B?VUNrNWhnTDhQRWtxYUtOamU0UHQ2dzlWMU4zL2dnVEcwTC9qVEFaSzU2Y2tL?=
 =?utf-8?B?L21CdTFFeDFPbi9xdVZCT2RCbDVQcXNiNkNpa3FrajZYc0s3TEZhaWlwNyth?=
 =?utf-8?B?SkQ3K29nY2JTenBHbW1ENkQ5aENnQXI1RG93eWp1dXh6Vk9LMytOQXVPRDVu?=
 =?utf-8?B?WjVJUTlYSVlzbHJZRGxaUnh1d2x2bzZpQURnSWRuckJZc2oxV2t2VEs5d0I0?=
 =?utf-8?B?TmJMMExWcWZUd3NiUm5uU1dWZStOWnJ0b0cwR3F5RXZuYm9uaGNHeVBNeUF5?=
 =?utf-8?B?U1VtZzBtOU9OZ2l4ZXFTanpSTHRmQUJjRFpWK084K1M2d0dsWC9QTm43WHpi?=
 =?utf-8?B?QjNEUkQ1QUNST3J6ekI4c0lpOXdHaFhJYzluWHA5amdmUi80VUtmbmpFZ3RJ?=
 =?utf-8?B?d1RYMENFcHZKSzNxT0ptMzZtb3RXcC8rMCtLUXlIUFgwTHhid1YzQ255b0ZF?=
 =?utf-8?B?SEtRR3RLWnRnVzh3Y1dIcXVsOFczZjhpOE9mc0tVOW9FQ3RvbjRQY251SFMr?=
 =?utf-8?B?L0VpNXFJTjhIbFY2RVNoZnFJRE1nZUJFRXJlbHE2T250cmFMdGJ6TWlQMFho?=
 =?utf-8?Q?ZKeBmo?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(1800799024)(36860700013)(376014)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 06:48:49.8629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5639fa36-602d-4529-c7ed-08ddc8ebd0a1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5828


On 22/07/25 9:38 am, Jia He wrote:
> When VMALLOC_START is redefined to a new boundary, most subsystems
> continue to function correctly. However, vm_area_register_early()
> assumes the use of the global _vmlist_ structure before vmalloc_init()
> is invoked. This assumption can lead to issues during early boot.
>
> See the calltrace as follows:
> 	start_kernel()
> 		setup_per_cpu_areas()
> 			pcpu_page_first_chunk()
> 				vm_area_register_early()
> 		mm_core_init()
> 			vmalloc_init()
>
> The early vm areas will be added to vmlist at declare_kernel_vmas()
> ->declare_vma():
> ffff800080010000 T _stext
> ffff800080da0000 D __start_rodata
> ffff800081890000 T __inittext_begin
> ffff800081980000 D __initdata_begin
> ffff800081ee0000 D _data
> The starting address of the early areas is tied to the *old* VMALLOC_START
> (i.e. 0xffff800080000000 on an arm64 N2 server).
>
> If VMALLOC_START is redefined, it can disrupt early VM area allocation,
> particularly in like pcpu_page_first_chunk()->vm_area_register_early().
>
> To address this potential risk on arm64, introduce a new boundary,
> VMALLOC_EARLY_START, to avoid boot issues when VMALLOC_START is
> occasionaly redefined.

Sorry but I am unable to understand the point of the patch. If a particular
value of VMALLOC_START causes a problem because the vma declarations of the
kernel are tied to that value, surely we should be reasoning about what was
wrong about the new value, and not circumventing the actual problem
by introducing VMALLOC_EARLY_START?

Also by your patch description I don't think you have run into a reproducible
boot issue, so this patch is basically adding dead code because both macros
are defined to MODULES_END?


>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>   arch/arm64/include/asm/pgtable.h | 2 ++
>   mm/vmalloc.c                     | 6 +++++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 192d86e1cc76..91031912a906 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -18,9 +18,11 @@
>    * VMALLOC range.
>    *
>    * VMALLOC_START: beginning of the kernel vmalloc space
> + * VMALLOC_EARLY_START: early vm area before vmalloc_init()
>    * VMALLOC_END: extends to the available space below vmemmap
>    */
>   #define VMALLOC_START		(MODULES_END)
> +#define VMALLOC_EARLY_START	(MODULES_END)
>   #if VA_BITS == VA_BITS_MIN
>   #define VMALLOC_END		(VMEMMAP_START - SZ_8M)
>   #else
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6dbcdceecae1..86ab1e99641a 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -50,6 +50,10 @@
>   #include "internal.h"
>   #include "pgalloc-track.h"
>   
> +#ifndef VMALLOC_EARLY_START
> +#define VMALLOC_EARLY_START		VMALLOC_START
> +#endif
> +
>   #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
>   static unsigned int __ro_after_init ioremap_max_page_shift = BITS_PER_LONG - 1;
>   
> @@ -3126,7 +3130,7 @@ void __init vm_area_add_early(struct vm_struct *vm)
>    */
>   void __init vm_area_register_early(struct vm_struct *vm, size_t align)
>   {
> -	unsigned long addr = ALIGN(VMALLOC_START, align);
> +	unsigned long addr = ALIGN(VMALLOC_EARLY_START, align);
>   	struct vm_struct *cur, **p;
>   
>   	BUG_ON(vmap_initialized);

