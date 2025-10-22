Return-Path: <linux-kernel+bounces-864477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73899BFADED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425D256174D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20DF309DC5;
	Wed, 22 Oct 2025 08:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b="B3DM2sCs"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023123.outbound.protection.outlook.com [40.107.162.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CE227990B;
	Wed, 22 Oct 2025 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121440; cv=fail; b=As7wqBMn4n/GLxE88Ma8lMvLWWCdY4ecHPJU9/AvBhbcHIVQPP165hJkCx/ipgtEBGWngp1wrdBaIc/5TSreic59AQiJ7lrRd2qMrR2J2wU9gR3kET7PHszKVV9Bi5oI7R/03EPba4GComL8lSG6jwecRvcE2NkoEKeYM+ca0Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121440; c=relaxed/simple;
	bh=dM1L5QynGKv5fIwLOgrcbQIabq0gsdPnLea8NRrbFqk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C7b3A7W/N3QoJyJxdpea2Q/TuwG6zoNH3DlWXvKtYYOqqqMpyLz5mcK4PZN07AYxDneI7sM8lZjTzhlJkqZ7/C8LLEZ167U7oqBFMjwq0wpgIYhSvJ0z5rTAN0hoD4uUoPd2Gf9jS7YLt/C3zdt+mxDQBc8SOXhaCHg319a86d0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com; spf=pass smtp.mailfrom=gocontroll.com; dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b=B3DM2sCs; arc=fail smtp.client-ip=40.107.162.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gocontroll.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7JPdP2JKN1mB4A/MLl99JZ5jJGcTcIsZNjJ6h8wV/Xog1/6B0PIFI8XJuWFFMdOxLuUT8wo+M3LDp65HgNSLrcXfUqmuLc3YiZlJf29iiarHYbTELa48W6oDEtM54yAqaHPWlzlCvkD8kQMG1pWrFVREzIaFyLeIIjVg7kzCBqO9o2gCm6yqbg4vlBfZeei6b+OKbnUceePYNn49A7wb95KnRiLEIynRxjhEtY6krRricXJkdAYNVASHi6gH/3ylgbWHd83jk+cUqFpolEw9LlWip6fo61OAluLk+WEIfpaU1hcOFlYQVTfj7RPlpCYIxxeDAIP8dUYQ7dKTvz+Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdbey67hm/PDcSx/B9O0V6NL3zLcDLKlGyeyDreZ4k8=;
 b=mqlJnGpjt86etaDJK9drUHAgv9C8wtKOF69RlPH7b6qdm2YR0z50FcJIe3mj7ZNoPq4C5syrpKhdB74A9CjW18FL3s9D3fHQncQB+PZjJEm789X7RqOvQ2FG3OFsF7eImzqNuCsiH1t5xpG/vJ2GoWwcL8yV6DR90V9olSfY9QcFiyokaNAefcy/gzzyy9sXCuZfVSKGL9Prq0Aw5uYQdBfKjp3ePJBa3E8GTAz9ugWuP/LHjdSvQpNjUuoyK9EXn7SG6l7YUSOoJHY9xUVoh0whcSuuEvSgYp90Z62rLY8W0jun/EHoWx+rfKwGhiGLHc95W3GRaeUnFJlAF3roQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gocontroll.com; dmarc=pass action=none
 header.from=gocontroll.com; dkim=pass header.d=gocontroll.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gocontrollcom.onmicrosoft.com; s=selector1-gocontrollcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdbey67hm/PDcSx/B9O0V6NL3zLcDLKlGyeyDreZ4k8=;
 b=B3DM2sCs1ks/yJRzXeNFEFai/HP8B7UHiRJB4HA9Z1jeRRODRAp/uC3cz9qW6P+3ImChpAXfNdEUX9aJptJUNzmFp5XQtQ/KqQKdqntKfAC0ts7W0pAKPfDEnY2BscANFM+v2xLUREd7/0fxgl2Ut6vZUp/3CYBRflZttUIHiCxF2qD8SRSwiHHTrHFMzbE85BQK+iZ7RjIU9WC/MoKbZXUR1fHaV8y3uUOFstXc1kHP1qhhwRXYeWq85Ml6tsQwSm1J9otXmhIt8cGTgDDnT2RLVtAdqn4yDxwD6a2XxaAg31/T6ncKc6GI75B+ARluePBr6xTCReewAeT/1QBSxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gocontroll.com;
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com (2603:10a6:102:ec::16)
 by DU0PR04MB9299.eurprd04.prod.outlook.com (2603:10a6:10:356::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 08:23:53 +0000
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f]) by PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 08:23:53 +0000
Message-ID: <05fbf53d-63d7-4087-af56-361fe655ec76@gocontroll.com>
Date: Wed, 22 Oct 2025 10:23:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] arm64: dts: freescale: Add the GOcontroll Moduline
 IV
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev
References: <20251022-mini_iv-v2-0-20af8f9aac14@gocontroll.com>
 <20251022-mini_iv-v2-4-20af8f9aac14@gocontroll.com>
 <20251022-innocent-micro-reindeer-5baf06-mkl@pengutronix.de>
Content-Language: en-US
From: Maud Spierings <maudspierings@gocontroll.com>
In-Reply-To: <20251022-innocent-micro-reindeer-5baf06-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0005.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::11) To PA4PR04MB7630.eurprd04.prod.outlook.com
 (2603:10a6:102:ec::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7630:EE_|DU0PR04MB9299:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e9dfd30-1ee9-4b14-b389-08de1144561f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nzd0OXErN2pxMUZ5MXlpU2llT0ozN2JJNnR4djBVRyttUUkvVWhqajhDakJ5?=
 =?utf-8?B?NVREdkNRMW5OcExCRlpCY002ZkY0Ni9NU3hFUFRqcHpCRjg5RlBEZ2hQZEc4?=
 =?utf-8?B?Uk5xUk5JS28wMzVDZHRRUzQ3RHJKRC9iZktXWkV3R3Z3UWxENGVFdGxzeFlz?=
 =?utf-8?B?NHVJZk42NmZuK21iQXRZcWMwSlJVZHlvVDQ4c2Q5anRWb0FIUWxZeUVDM1Iw?=
 =?utf-8?B?S1M2MWJ1Qll3NXpUWndSK0o4UGg2SFE3M3FmRExNaVBHWWEzbkdlcWU0cmpD?=
 =?utf-8?B?R1FvM0dESEhhQVNzV0l5ZmpWZWNtdkJ4eXZGbVFkUEduQXN2eTdDQlpFK3B6?=
 =?utf-8?B?VDZNMW5WaktQMktlb08vQzBXZHJEbC84OVdVb0l3b29FU3pVWm9wUkovMmZO?=
 =?utf-8?B?d3hUa1NpcmQyTkJiZElva1pjQjRsSjdkcWNMY25SY1RrNnpBMVZhaU8rQWlH?=
 =?utf-8?B?U0V6U0RTamE3cVlTZEgwbjZSMFJtTzBZdE9DN2ZRVWRlYUI5WGpZUnRQSGtr?=
 =?utf-8?B?aFhwLzN0ZzlPakNmS2paS0VnRGJWaThiODVXczV0MitZdGtWMDh0QVVrU3du?=
 =?utf-8?B?eTBpOGJqZWp5d2liS3Y2UURuU21QMVlwNlJVakk0enBYWFJmNmpvbEsxUUxo?=
 =?utf-8?B?QjlyRkJabU9yaGcyWUlzTWxDRlhUN1VUQ2NFQTRnR2tLNXBHZisxdHVXSm1o?=
 =?utf-8?B?SXJYL2Q4SVB3N0VHQm9EV2tMMmZLVDMrRGFsTW5kM3YwdXpXZHBYN1Zud0dW?=
 =?utf-8?B?QVZkRlQ4c1k4OHZuSHNuaW1EMEFYTVV6Lyt5QkJEU0FreTNmMGFkTTkvajdC?=
 =?utf-8?B?b1VwU2x1MExSM1M0Wi90V0hGbXpmU3ZGWkNVemtBM0xzZ1BMYVpIWDJEY3hR?=
 =?utf-8?B?SXhqaGI5OFBqTDdNcCtjMU9ZK3NEL202b3YxWEN2ek9xbmFVbXdWbW9HUWRp?=
 =?utf-8?B?eHAvb25PVi9YMlRycDdrRWZyYytDNFRKeGxCYlpwamJWZFhEVG5lT2ZwaHp5?=
 =?utf-8?B?Q1RoNVgrRE9UckplRXg2Mm9sQzNrd0ZJNDJiQS80ZzJobkc5TW8raXVvT3o2?=
 =?utf-8?B?b3I5cWN1Sm5jSm1aajBLdk90bytRTVBoeEhyWk1sQzJTOEVFMVIyQnNrZjly?=
 =?utf-8?B?ZWNtVkEyUld2bS8vSEZLSDAxblFHeGlwcVJBSmpQNVZsKzhWY3FqelZPZlZh?=
 =?utf-8?B?UnhGVzBpSTJVREd2QTRlenNtN29DVW00SUQ4a1pucWdERG9KaTRXOWlzT1do?=
 =?utf-8?B?YTFmcVZKMUFQNFhaa3lCd1VTWTFieVJFejVXRDl4YW85eFRqdkUycDk4ZWNk?=
 =?utf-8?B?Znlkd1U2OWVxbFVieE9nWjM2c21QNmYwTzZDb2VoS1N3emZkTGVDdFZBdzBj?=
 =?utf-8?B?TWZ1clRYbURqbkljbjdPbkEzOXZOSElKbmV2QlQvVk1jZlhSQXUzQmxNZVlZ?=
 =?utf-8?B?YitvMHgvekhHVm0zek9QMWhWc2V3VElzK3BPL2ZTYWdqVWJiMTFOMmdnRzBS?=
 =?utf-8?B?aE1TNVVnRWQzUkZVc0lVaXpZalFwVnpsenZ4UkxwV09ydzRuTzlDOForQm1j?=
 =?utf-8?B?bXppRDVsc3RpeHNzQ0FMMmhTUHdpWEU3cXFncnI2NkY3dm00RTBXYlZtUElQ?=
 =?utf-8?B?MmIrRVJvRDRlTzJWK2xObm45UkpBL2x6bFc0bXZYWWlqaklVaGNoaFRIMWJR?=
 =?utf-8?B?V3NYWUJtYnAyalVJY29xaURzV28wQk1kT0ZsNjFRUFppUkx2eDlCNkpObGN0?=
 =?utf-8?B?bnh4UURZUUpwUWxIWlREZGl4WkhnOE5NOWE5QjNDWnMxeDgyZUZ1M09NR1B5?=
 =?utf-8?B?S29DWTlhTGlIQ0tGVk1EUUpzOGtmNkVsVnFiNlRMeFNMRkJydnVoSHVDV0hw?=
 =?utf-8?B?dUNDSVI3QkFZQWlzSXQ2V0t0Y2xhR2FuT3Zna3ZmRDZXY1p3cHZiMzhtc05O?=
 =?utf-8?Q?/ZzmPxKEM/wudaGQGx1rcTrwOlms/KPO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?di9CL1loQlJQNkFDRWQ3NitLRHBwMmcvb0dDSzJGK20wbGpvclFBVzZaQ1B3?=
 =?utf-8?B?d0o5QVpPNUNiZ2luT2JRMHErOVJkanp3NVpJbDhvSmh3RXNQN0dpZkxiWGhY?=
 =?utf-8?B?RUluVUhFc2loY1MxRHNPak9GSjJNb3dwZVliRmFRTTg4d0NoMmhqSkVDckRB?=
 =?utf-8?B?N09JZ2FuQjVNOTJhalY2UlNsWEFmZXFVWVhVRGp0a2ZTcnExQXF2MGdiZTdS?=
 =?utf-8?B?cUVOeFpFRDhlTW1wbStnaldIM05jT3lCY1E1Q2NIUm9tWkMwWi9DZWtlRE5E?=
 =?utf-8?B?Q24wRG1ub1RYQXB2THppa2VFTDI3NHBGQW03NzV5OXZuZW9ya2Vpd2tzQzZZ?=
 =?utf-8?B?L09UZVJxbFRJVFZXNTdjZnBxcitjNzJBc2xDQWJidlpGTFVJcVpUOUx5SzUr?=
 =?utf-8?B?bTFSa2lGTzBEZGllM3EzV1NUOWZUZ1Rkc20vRElIMXZES3NmbXFvYnY5VEd2?=
 =?utf-8?B?S1huVVR3YjV0ekVZbDVyZ3NubXRnL0dKNzFaMC9KbkhOdmFBMnBEd0dXRmlr?=
 =?utf-8?B?TmF1YTJQRTFNMHNSMFZ4d2o3VUFiMStkVmpFVDBsTS83SEZVMzBKS2FRdlpU?=
 =?utf-8?B?K3RqZ3V6UW5kNmN0WnNjQ3FHZGRUa0RsNm9FbStUTWY5Y1JHQU5KNEpiTUlo?=
 =?utf-8?B?UWNWdXNxeGpWemFkVXNla0VrUVlxb0FZSFd3bDRWajdNeUg2K3pYbC9YOWNX?=
 =?utf-8?B?ZUFHdmY5VWYvelpwTE1Uekxwa3VGck5WV2p1WUQxRFlySlRhMlZmc1duVkE1?=
 =?utf-8?B?RUxINElLMHBTZlBkWFZDVkpPMnJHOUhVNmtzbllLK01HUHJPUEJmeW80KzdL?=
 =?utf-8?B?c0lQejVSL3FOOE5taDNJZHd1UlA3U29tNWc4c1Jtc05DMngrck1rUVpDQlc3?=
 =?utf-8?B?TzMwMFVUMUhWRTBHRENVeXFMV3RUNkl3a3o5OHlqOHcwOXRZWkF4Z0dsbEYv?=
 =?utf-8?B?bkovR1VaOWJwaElBSmVjZkRDYTZ0aTZISFZDeE92MFU4TnJKU0ZJeWxVKzZ6?=
 =?utf-8?B?VjlvWDJ6eHRsaitVMG03bDg5M1hseDZFNlhBemZXdXdBT3d5eEZHdmo1c1lQ?=
 =?utf-8?B?RmRxRjcvb01Kd2R1RXRQUUVxckhYaGdpTGhhOGhoZDhTbS85MmRwNDhWa1I1?=
 =?utf-8?B?eWV6MjNuRzVTdnJoWjF2WVhaRlFzNHlCbWVaNXBtMEdId0pGWEF2UmE5emxV?=
 =?utf-8?B?SXg5SjN4enFHLzRnUUFTeDhUWlNxRFRKUzRZeFZURWNrdWU4UHlMa0NVZFJT?=
 =?utf-8?B?LzdkMFUzWXRwMFdRd0ZDRHAxdzREWHpHRXVKRHR1bVNtNnIyMDhsZ3NGRGMr?=
 =?utf-8?B?ckNVVEtiTHpJZkI2VTRsdFF1TFVHbVk1eDBDMkFldVllejNicHRPR3hHNlJF?=
 =?utf-8?B?Ym1xYjV0TnhiOUJ3ZGVHa1QrRm1SK3pqNk80T1FIVzNWQzlQc1RIVG1zUi80?=
 =?utf-8?B?TEZ1YTh5Z082WllLb1g2VWtTSWptMXIrWFhybTlKcXdNY1E0SkNqSXNINnFw?=
 =?utf-8?B?UWZGS0t4Y2ZVaFkxQTVNdy9QK1ZLOFpKZEU1YjJBQk9MOE5leklZOGlWZ3R5?=
 =?utf-8?B?VHEvZ1FXZHJBMHR0Z2hYK0JPdkpGZTNDSnZIT0J1VUZzbVJ0NmJiQnNpU0Vq?=
 =?utf-8?B?WUxsRFBWOEprNjZLMnNOOHhNWDg3STBINEYrbFlJSkcxa2p5NDQyZE9TOE9E?=
 =?utf-8?B?T09uY2ViSk9pODJaZ0tEQmlwaHFFeUo3M0xWVHRjdU43Y2c4Y1p0M2N3K1NM?=
 =?utf-8?B?eW4rMmFOVHoxWTZDcjl6MHpTL1czQ1VmOHFCb0RGZUpqK1BZUTdhaExscWdV?=
 =?utf-8?B?SlNlMVZTM2Q3NGNUNjNVbjlQWU9SV3ZRTUpQYjN3VElwVmdlRmxwK25EWXpa?=
 =?utf-8?B?SkFEVW5QYTFiOHBXdTBMNGt6ZFo1NEI4NmY1SVhPeTZPbURsTkhSaHE0c1Bm?=
 =?utf-8?B?U2owNmJPejd6M2tEckJ6VkFUSlk2ZmZhNHlzL2ZLdElFRS80Sk9MZ0RNclpv?=
 =?utf-8?B?RGFidmZuLytxMDlKbkxUUjgyYUpma3pGek9NYmx6ZFpwMENYRWR0SFNuZEVH?=
 =?utf-8?B?clRFbXVWVzJHdVZnaW14ODBSL0JhM3BleGd0RnVBWWdBYkwra1V3NjMwSlFj?=
 =?utf-8?B?TUNXMWdsV0piUlJiYVNwMldXbXNCNHBHS1FxalZvZ1FPdVd1amtCa3hsQnYx?=
 =?utf-8?B?cjhBNWdveGVzU2pHQWdnWWdEekRIYUJhUUw4VEpWQ3Z0VmNnSlV6dEhjeE9N?=
 =?utf-8?B?UEhuK2VlWGJSY3IzSkV5RStDcG9RPT0=?=
X-OriginatorOrg: gocontroll.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9dfd30-1ee9-4b14-b389-08de1144561f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 08:23:53.6026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4c8512ff-bac0-4d26-919a-ee6a4cecfc9d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLmevsECXgx/AekWtrnjhBWpGtXnpM5oQAqVqpghFVDt/ADevPp+9+x9glMm7uA2uQVNapgKw+HI7KhJBeotPFje6sEa4F401tyiq7OnZcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9299

Hi Marc,

Thanks for the review

On 10/22/25 09:57, Marc Kleine-Budde wrote:
> On 22.10.2025 09:22:40, Maud Spierings via B4 Relay wrote:
>> +	can@2 { // reg vdd?
> 
> What about this comment?

Thought I resolved that oops, will be fixed in the next version
>> +		compatible = "microchip,mcp25625";
>> +		reg = <2>;
>> +		clocks = <&mcp_clock>;
>> +		interrupt-parent = <&gpio3>;
>> +		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
>> +		pinctrl-0 = <&pinctrl_can1>;
>> +		pinctrl-names = "default";
>> +		spi-max-frequency = <10000000>;
>> +		xceiver-supply = <&reg_can1_stby>;
>> +	};

Kind regards,
Maud

