Return-Path: <linux-kernel+bounces-722622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E59AFDCFA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E953AEA23
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40F818C011;
	Wed,  9 Jul 2025 01:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="SWDQMwoX"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB0817C220
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 01:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752024851; cv=fail; b=TunfYYm0gN5Oy3UoRYyAZeIdpH+CTXE0aNKmLNa5nav31OXjB5TbSVnQJwY3bGDsbOzos4jpI/Nmo/J+ZkMPvNScm55IbsnTdJIW4ijYT3L7Ghwz3/MQ9HyAnp+pXD7wNlVo+UtQ2q+1tB240A3pjTL+9r/ifey1PQQUXYI4vdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752024851; c=relaxed/simple;
	bh=dr/QQDoNj8OnP7ZtHG2h63VW//Um2Pt5mC8TNAPezyk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WcZiN+vm3Q+v+QTjmz6vUY23cJeYC10i1J+0zsU/re3QirAJdFwQdDX/C6cCq6/bMTpgvM/pGi75URcuEuFmdwPSK68ICdndD2Iuq4uUgoJzBwk6kePy0uY9SNsaCDmxZZTNdfh5MRi5MkFs28/3kzTtL2HIlshAfOQXDRDcueQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=SWDQMwoX; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzMyU4Y4FduCESy6iQL8pQ99AzRilcYtmxZN2Iv2g9VwqLXCX5eDI9fBfk+0E6Mh+3sjnGiusaj/5xT0A1/HmvdVhUli8plUs+nv+6mgKnosiL863zv2ZORrgzJ+fK8PamHBEQZbwnLQHViM50BBSPcJ6FaRwLvFdKG1HTI+jTOd1nvGsznKAXHbi4HXd+ZZVA2tinaXPSRWvct+fiK491+f5XSByD7eD/WeUJjLKCBOrAKCrSw7nftdACej70kqy/LDaAxvxiD8riflxm8195+l+nxNl6Q/hTonZA3Dp/kVCpNdleml+pk65oChe6NIdJVsRKkNXx1xTUu/cZVshg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QN5iwhKsYt/aFkph4X5eMGm/52PLCL2050nmEfHLjZU=;
 b=bOylClzUzxdzziFQGrIcd3ayH/jIndZflQ1J8USR3wHII1j5fmU+TowuCEX6Qjk2pOD1xMX0G9DBZQoBJE5hwxSdF6CglUdwYwdpXmPKgLTi8iShPLivoXjTMe/TY4Uvqtgdp98qzACZ7VWW17y4r+phmyOhEc/uAfwUNhMzkpt9PA0hWaYMndo8lbzdeUQZj0fGBeR1PytXNImDKE55XBbjPyGyL644MRPJC/8esX+ElynAGoD3Fb2N4CpN07Pj1JhvAJ3DaNn1astD+/OHX8gGgoV+sIOdfCGmAt6gcSV727wtiGPevtCARDc/JxRZ91AeYqX7bnkxFskvozVEqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QN5iwhKsYt/aFkph4X5eMGm/52PLCL2050nmEfHLjZU=;
 b=SWDQMwoXGQKgMWCJBxRUkKhb3qZd52hDQl7d9Isw2FT6LI3Jy5jWOuf0CaQZcHpCX8IAiS4lDrXp3xLbkFyUo7y3/dZSEoMVWWzofKyTZlKKWnLBlk8YemjDTnhZS6GpH7IZ/+L47JTfIdHxLwHpKKd7x3H8Kg3sGmi9pBk9w93NvBbEU6OEEI2jFz02X5Rnj9ohetyji3jl1jT1DTexOzoDHiBFRjGbkLm1CNO78sUqEWAJWLSBg+HxMgazy+Ih5mDbwqHSPbyGomeONbyWMDmQnrKLB+IwpRPQfo9Frp1pTRCOpnsXtO0e9M4GT5RojT5eIm0+EXWnZnkq9l6wGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by DM4PR03MB6030.namprd03.prod.outlook.com (2603:10b6:5:391::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Wed, 9 Jul
 2025 01:34:06 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%6]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 01:34:06 +0000
Message-ID: <2287f4f8-f4e2-4f93-b050-afeb41955719@altera.com>
Date: Tue, 8 Jul 2025 18:34:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mtd: spi-nor: core: Prevent oops during driver
 removal with active read or write operations
To: khairul.anuar.romli@altera.com, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 "open list:SPI NOR SUBSYSTEM" <linux-mtd@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <cover.1752024352.git.khairul.anuar.romli@altera.com>
 <e439e6b85e650a91607a1d02d5d432d096363315.1752024352.git.khairul.anuar.romli@altera.com>
Content-Language: en-US
From: Matthew Gerlach <matthew.gerlach@altera.com>
In-Reply-To: <e439e6b85e650a91607a1d02d5d432d096363315.1752024352.git.khairul.anuar.romli@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0026.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::39) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|DM4PR03MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b38c281-e433-4b9a-98c6-08ddbe88b200
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnN6UjJPMnBMZXMyQUJaL0FDTjZXcWlOZ1RjRGNZT3JobnVSVHEzNldoUnJh?=
 =?utf-8?B?THBxdG5tdGREU1dYU0tXNTFxWGZyVjU1NkgrVFhpVTB4ZzJEak9PSlJVZXFM?=
 =?utf-8?B?T0xZU0FaZWsySWJ5VjBXT3RzNmxUUytTUEo5MVp6YWhVOFlaN3VpRFJQT1lw?=
 =?utf-8?B?d21NYUJtRlMxN2N1T29xSGVLMUVlYTZXMHE1UWNadkdKb3NheElxeUpFTFVx?=
 =?utf-8?B?TjdUSXhCRDI4dFhXSWgrQTdiNys3cWdFbEs4ckxHdnJvQXhxaEJlanZyMEVO?=
 =?utf-8?B?M1BHZUVYdE1XM2t6TzlZMjJXdWcvQkNMUG5NMzdPY0tGdCtDbXp5ZFFlU2kv?=
 =?utf-8?B?WDkySkxmOUpGKytZZTJKaU1rc2lHWlNWL3FNK0x3WnNhODBwNzh4eXhRRWlM?=
 =?utf-8?B?YVhvUzQwTDF4QkdVU2d6a1Q2T1lhV0dDNE0ybUJGYWlSRHVHSFRQUVFjU3Q0?=
 =?utf-8?B?WkZibm41cWFsbllYaDJMZ0s0bUJ0VTVUYUs2QU1ZdjNMd2lERVZ2R3lSblNK?=
 =?utf-8?B?ekNjLytzeDJTVWZjSmxySzhqd1BJaHhmUjlTSGRZbFdaUHpTak5EaURKZXZG?=
 =?utf-8?B?dUVzbVJIR1pMWWhtYW9YZWFlbWNIaUl2U2NxRDJlYU1RS3ZnRWRxMklCLy9C?=
 =?utf-8?B?SUZST3Q0UHJNaVRBL3U4aGlNZGVCYTFLUzB3U09XR0RGYjBITVlQMkJ0OEY2?=
 =?utf-8?B?QVdlRnRUOTM0Mzd5QmVVbjI5Z2wzQngxYUY1bGVUanVXOGhEVVNxQlBrWFNR?=
 =?utf-8?B?cGV5Uzd2N0QxZWNGWmovcUViZzEvTjJmYlVLYlZKRUhySE1HNEk3VG5KQVNH?=
 =?utf-8?B?KzAweE16Y1c1Wk9ZSUwzTUJzU1hnelBwNWNTVHp1c3htT2xMckRNcEUxdXZE?=
 =?utf-8?B?NTREbnZFWWllQ1ZtbWZnMmFqU1ZkWEkvMTFXVGhkT3doYTcxc0haNnNHai8x?=
 =?utf-8?B?RngySkcvRmNHTEYyY1pnbHcwZEZpWUM5YStKWW9MSkd2VTRnWkxBbCtBRnNw?=
 =?utf-8?B?MnUyekpLV1BydHk4dWR0c0FOQmNRblovbzhxVDlrbVRZWDJDeVl0SjhuM1dP?=
 =?utf-8?B?Q011SHNVOGlBcFdyWURHd3V2L3M4RWJjNjQ0bDJQSDIvWTJ5YjR0L1J1eFd0?=
 =?utf-8?B?MFlUNk1MdW9PNnRLL3VvMHN3cEk4dnFlNHlRYVZUVjh4NUhNSGc0MzE4ZWln?=
 =?utf-8?B?OVNqdkd1M0FGYnc0UGpzdGFHUytWWFFHUkR5RnpsaHZ6TFFqQW1XNmxzRkdT?=
 =?utf-8?B?UHcwQnVnNVVZeHJMem5YdE5QN3RGcjBrNmxuMXR5blRzL0pUZDNBMEpSaGdD?=
 =?utf-8?B?Zi8wVnh5L1dkU0dZZlFXcENqWHlZQ0JVMDloM2luVnYvcnI2NXY4VnRhZTgv?=
 =?utf-8?B?elNHWWdJQ0VPdDlwdUVQcmV4dGUxQ29DY25xclA3ZVlZRG5ZYXdxS0dNc0JU?=
 =?utf-8?B?M3A3QWlRM2pscndvYWNRU3ZNS3lPTEk4OXBzSlpEMzlVQzVxclEzU3Y5dlJt?=
 =?utf-8?B?OUdYQ2dOdWNFSGJhcEJ1aDU0ZkIxR2hHR1lEbXdmQmJSRk9wOXlkeVNtdUxU?=
 =?utf-8?B?SlBKdHkzdThTeXByTis2WnFuSXRDR3poSWFzU3hhc29tLzZEWXhJdkdNMWdR?=
 =?utf-8?B?eURrVEJyV0RjaTl3SmxSRDNQM2hkSTJGNyswZy8vdWNDK1BJLzFJVExCWDho?=
 =?utf-8?B?bnZOZERkbHo5d0NTazdrL3hMK1BvUE1MWmJzNU5KVGUxWUNBaW1ONHh5Y1VO?=
 =?utf-8?B?MXBqck5EY0JxNW1kWEJDMkJ5L1FzOXB1NDAyRk9mZ3pyZm5vQ1lZcVlqS3RY?=
 =?utf-8?B?ZFpObzRNQ2NJN0pIMXNjeitxTFM2OHJ2emZIM3BzSXBieTdBZ3NBU0kvSWhF?=
 =?utf-8?B?aTRNWnp6eXNuQ1lSYjJ5a1UvTytJRGZlTTg5ZEFLNnZVYk1nRXZUb1NEaUU5?=
 =?utf-8?Q?mP7/77xKbw8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnNmV21xZWhNYWJ3ODZFUFAwaUVIOFU1Zi9oVWs2c3JHTmRzMXZjODBmN0Ix?=
 =?utf-8?B?ZzdiTklQenV3MlFCdmpLREpzT3M3cE1oN1U0QWQ2Z3JRRzZPS054YUpVSjFl?=
 =?utf-8?B?YXVVcVA3NldvWlJFTTI3NmZ3Z0dtRWRzVjRqM0U5Q1hwUGxlamluS2xzS1Bx?=
 =?utf-8?B?S0pjOEZGczhUejdGMldURm5aVjFHWFZITkQ2d0ZhQ3lrSENXbXRXdG53K3Fo?=
 =?utf-8?B?ZzcxclVheGdlUTUwWHZCTURhU0N1dEQzcis4dzRQaHpNOWVndG96N2ExbWZF?=
 =?utf-8?B?MndGRVhoRFh6RE8rNkd6ZGVER3Nyemh1Q2QrVndXcGFvZEhSbUxEMk1uNzN5?=
 =?utf-8?B?REx0OEJhSTROanowYlJCcXo0MnBJVklrOHZiQlNqR2xUWWhqZ1ZmUHlLTWQ5?=
 =?utf-8?B?SUxsU1VFblREcWZwSmRnVWttUktoemxkZDRnVmhtSFVGN0ludWNTYnVZNCsr?=
 =?utf-8?B?Um5UVjJ6MmhsQ2R3a3JiZjN3VVQxQm1INVlCK3YzWDBSY01leUg1V0J0WDJZ?=
 =?utf-8?B?N0hHZUVzL0RtajZMNVJvM3A3azJ4S2ZpYnp0Wm9ud0g0cFFSSXhUb2R5VThP?=
 =?utf-8?B?RUhGK2l5YXRYVElURnZybzdYaVFjc2N0a1dVTmpXaFRSd21EOGpwc0ZadTcw?=
 =?utf-8?B?Z1NXMyt3SWl3MG95Z3BKcDJRY0F0ME9DUXBCNStxbGdZY1dscGZFUWZLRS9x?=
 =?utf-8?B?eFNELzRCSkUxTHIyUHdVUVJJRGdTdXFHTnlRajQwSnZCbzVrRGpvZ0JlRi9E?=
 =?utf-8?B?a3hQWS9wZ0NCY3d6bjNqdFFhSVJxYXBEWjRjTVFzZ2dMRlBRWk9GWHBaL1p2?=
 =?utf-8?B?MitYV2dSRmNuMEs4dmlVYjJUTFl1RGNhRTd5Wk1lMXYzUW9hbVhhUTVwaXlR?=
 =?utf-8?B?Ukhvc3U0bVp4U1ZOY01OaG9KVTNEemx5SDd5bVZtZlJHaC94a2pPOXYzTWdQ?=
 =?utf-8?B?VDRtaWZzVm9hUVNIT2tzUGw2cWVaYW9MQVVMRSszUXRrZFpQNENjOUNkZGtq?=
 =?utf-8?B?R0dxRGpEYnNVWE51VkNpeVNwZEVrVm5ZbFM3VElyTWVRaFFjRURiY0tFRkdp?=
 =?utf-8?B?a25jVVlsamdZTWpMaS9uSUxjVy9DaFRiZkp1RXVYUmJoQ3FhbzFkNzZEaFFp?=
 =?utf-8?B?bmZkREpUeW9nazRkd1pjZEdRWGkrKzhiaXBxNElyRTFjUWZHcTVMN1ZLd1py?=
 =?utf-8?B?SVNaeDJJb1pZblVwSGlEbVdtQ0s1ZU44VjBPRHMrV3lLemVjVjhFWDd5SjBS?=
 =?utf-8?B?WE9QZWxqYkh5TlBBVWJjQlU2MndHM29abExpVVU4QWc3YmdtQk5kaXpYY2F1?=
 =?utf-8?B?cUVBRlNjMmVmNVl1SUNpLzBkalY0QUZCZE41V0xLMW5oUlY2OFFadTQ3ZWZU?=
 =?utf-8?B?dHczTHhrY2FiMWh1cE95MklmdDZHTnRmeS9ScVdwWjk3VFFVT3I2K25XaVBG?=
 =?utf-8?B?T294SFJ3a1hiWU56YnB2NDlPNjl5WTAyS0ZpdHBsMVNob0lHYWREQk1zV3FQ?=
 =?utf-8?B?VXJvNGY1V0lDbUh6RXlKYm9OV05NaG1GemRFT0RJN3d4V3p0aTRZUzBXMFZE?=
 =?utf-8?B?dnRWZk83YXlNbGVmQzZTcEVyeCt6VWRYOTM4WTJsQythUUIyOXVOekRVTkNU?=
 =?utf-8?B?ZkRqbGxJZUh3SXRuNndrbXhQZ2hGbHpOMTJnUDRnQ0ZWNi9jOHBmQzl0Wlow?=
 =?utf-8?B?S3ROM0xBTU5zY0hQeElQSGNuYmc5OWRYWXhnOEhyaS9UZFNHVzkxNnBrRnRR?=
 =?utf-8?B?TTMrUm1Ud3JzUlo4OUJsaVprZHNiV0VBQ0RPRHhTelVoRmo5ZEdlTDNFOEIv?=
 =?utf-8?B?c0JPMzNRTkZDTGpEN0N5T2pQdHo2a2NQZExHRnBEVEFzdDlEMThMdm5keml5?=
 =?utf-8?B?M0owM2VTc2p1ckovNnJNSk96V2lvZWd5dm0xazhRL3RQY1Q1ZkNHeDNjV2hn?=
 =?utf-8?B?RFg3YmVRYXRzVmxPaENhYXBYbnFtQWk1T1NwUUhSZ1U0aGI3SGxvVWdSUGd1?=
 =?utf-8?B?cFhMQVNJcW0waklTMkJoTVhBTXJ4ZExkN2JBN3FxN292U2JleHB3aXNCeWFD?=
 =?utf-8?B?TlpxUVdFYVFnV1NBeVJuN2U3M0ZqRXlRVFR3cFJlcHZiTXd4WUVkWHl2YWZW?=
 =?utf-8?B?dk1wZTF6L0RoRFJwWFNtOVhzdkdPaW1oUHEyakpGZ3pTb0JCUTV1czlVL1M4?=
 =?utf-8?B?WWc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b38c281-e433-4b9a-98c6-08ddbe88b200
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 01:34:06.8587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmhscd4qEFqOVj5f7vUExyY4y5tg8zP7SG/Ue80gHBVxLStZLw6hbo9Cvr2rNsM5rbrX22o5aRWEJSAKveqGdtKhx+OkI7oUCdIiS1Bo0R0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6030



On 7/8/25 6:30 PM, khairul.anuar.romli@altera.com wrote:
> From: kromli <khairul.anuar.romli@altera.com>
>
> Ensure that the pointer passed to module_put() in spi_nor_put_device() is
> not NULL before use. This change adds a guard clause to return early,
> preventing the kernel crash below when the cadence-qspi driver is removed
> during a dd operation:
Let's get this submitted!
>
> [  200.448732] Unable to handle kernel NULL pointer deref
> erence at virtual address 0000000000000010
> [  200.457576] Mem abort info:
> [  200.460370]   ESR = 0x0000000096000004
> [  200.464136]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  200.469527]   SET = 0, FnV = 0
> [  200.472609]   EA = 0, S1PTW = 0
> [  200.475904]   FSC = 0x04: level 0 translation fault
> [  200.480786] Data abort info:
> [  200.483659]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [  200.489141]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [  200.494189]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [  200.499500] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000185df8000
> [  200.505932] [0000000000000010] pgd=0000000000000000, p4d=0000000000000000
> [  200.512720] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [  200.518968] Modules linked in: 8021q garp mrp stp llc bluetooth ecdh_generic
> ecc rfkill crct10dif_ce rtc_ds1307 at24 stratix10_soc soc64_hwmon gpio_altera of
> _fpga_region fpga_region fpga_bridge uio_pdrv_genirq uio fuse drm backlight ipv6
> [  200.540016] CPU: 0 UID: 0 PID: 372 Comm: dd Not tainted 6.12.19-altera-gb6b26
> c4179a6 #1
> [  200.547996] Hardware name: SoCFPGA Stratix 10 SoCDK (DT)
> [  200.553292] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  200.560234] pc : spi_nor_put_device+0x30/0x60
> [  200.564594] lr : __put_mtd_device+0x8c/0x120
> [  200.568856] sp : ffff80008411bc20
> [  200.572161] x29: ffff80008411bc20 x28: ffff000185e2c500 x27: 0000000000000000
> [  200.579282] x26: 0000000000000000 x25: ffff000185e2cb00 x24: ffff000185e2cc88
> [  200.586404] x23: ffff00018034c620 x22: 0000000000000001 x21: ffff00018873e080
> [  200.593524] x20: 0000000000000000 x19: ffff00018873e080 x18: ffffffffffffffff
> [  200.600645] x17: 0030393d524f4a41 x16: 4d0064746d3d4d45 x15: ffff000185757700
> [  200.607767] x14: 0000000000000000 x13: ffff000180045010 x12: ffff0001857576c0
> [  200.614888] x11: 000000000000003a x10: ffff000180045018 x9 : ffff000180045010
> [  200.622009] x8 : ffff80008411bb70 x7 : 0000000000000000 x6 : ffff000181325048
> [  200.629129] x5 : 00000000820001cf x4 : fffffdffc60095e0 x3 : 0000000000000000
> [  200.636250] x2 : 0000000000000000 x1 : ffff00018873e080 x0 : 0000000000000000
> [  200.643371] Call trace:
> [  200.645811]  spi_nor_put_device+0x30/0x60
> [  200.649816]  __put_mtd_device+0x8c/0x120
> [  200.653731]  put_mtd_device+0x30/0x48
> [  200.657387]  mtdchar_close+0x30/0x78
> [  200.660958]  __fput+0xc8/0x2d0
> [  200.664011]  ____fput+0x14/0x20
> [  200.667146]  task_work_run+0x70/0xdc
> [  200.670718]  do_exit+0x2b4/0x8e4
> [  200.673944]  do_group_exit+0x34/0x90
> [  200.677512]  pid_child_should_wake+0x0/0x60
> [  200.681686]  invoke_syscall+0x48/0x104
> [  200.685432]  el0_svc_common.constprop.0+0xc0/0xe0
> [  200.690128]  do_el0_svc+0x1c/0x28
> [  200.693439]  el0_svc+0x30/0xcc
> [  200.696454] dw_mmc ff808000.mmc: Unexpected interrupt latency
> [  200.696485]  el0t_64_sync_handler+0x120/0x12c
> [  200.706552]  el0t_64_sync+0x190/0x194
> [  200.710213] Code: f9400000 f9417c00 f9402000 f9403400 (f9400800)
> [  200.716290] ---[ end trace 0000000000000000 ]---
> [  200.720948] Fixing recursive fault but reboot is needed!
>
> Fixes: be94215be1ab ("mtd: spi-nor: core: Fix an issue of releasing resources during read/write")
> CC: stable@vger.kernel.org # 6.12+
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
>   drivers/mtd/spi-nor/core.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index ac4b960101cc..501e48a342ad 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3213,6 +3213,9 @@ static int spi_nor_get_device(struct mtd_info *mtd)
>   	if (!try_module_get(dev->driver->owner))
>   		return -ENODEV;
>   
> +	if (!dev && !dev->driver && !dev->driver->owner)
> +		return -EINVAL;
> +
>   	return 0;
>   }
>   
> @@ -3227,7 +3230,8 @@ static void spi_nor_put_device(struct mtd_info *mtd)
>   	else
>   		dev = nor->dev;
>   
> -	module_put(dev->driver->owner);
> +	if (dev && dev->driver && dev->driver->owner)
> +		module_put(dev->driver->owner);
>   }
>   
>   static void spi_nor_restore(struct spi_nor *nor)


