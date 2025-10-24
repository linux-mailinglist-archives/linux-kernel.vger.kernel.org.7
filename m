Return-Path: <linux-kernel+bounces-868538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ABAC056B1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA939346B32
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFAF260586;
	Fri, 24 Oct 2025 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="YE/LxfN/"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012063.outbound.protection.outlook.com [40.93.195.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8898130BB8C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299243; cv=fail; b=d65r5mxFsWFm0kBCmkoYiLqeYZtZoXlGAzUcIzX7//izGnKvBY63cFbkrdg3RLE6j66jtuQi4Z6XDwp3XFNX4sxu3hUaYlhmbeoR3OsvVm+rpvYhul3P++aXLvJPkncnHeOJ5x2WQMkroYliwg39qspYNQ1Cqbv+cdBIhC+lqB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299243; c=relaxed/simple;
	bh=IAaIS0vgQgf5IsK8RXso5zSyEJYfTVilaojC82olldY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=plp4WZcZuX4LOxE9kO5ANzI1wacSglEnXS1dSRVNaqP5NbSKTpWWoL2a7dXwEf7Pi6IJgjy/MgUFo22C8SuOXSjuNWHXPN7Z+OkvwsuDfBC82Hg8FCz/sxDmo3UcUSGJ9fP4zoGQms9htoL5xNQlWm5NQxdIT+B476cXodNkXfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=YE/LxfN/; arc=fail smtp.client-ip=40.93.195.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQeLJ8q36CEkqIH2pGSBmZlQgBsanBnkuBtKOrmE7u3vmG3iqXRoB5S5JQVp7B1wBe3EPqDd+M6B64Wa9bxIm+mECiDhwQdMIgldqemSZi7P1lC2OKYrS2T46drrpdMx6Pl3CxIi80HliZ2hb6UjPjZOYQXY5KFmivjuqrG+p4LU0BW3Guv0S1Dklg3G+WwV555kLcGrBGluNXOvAIb4dPC3Zyu+zc4eZScFMI4EjS9pq+/ShBbCUfOJCwllZnotffYNpyTrcoeV3ZTL0NLzLd07rbFcniY/f9JJzG/k5jGBIge6GwqboD14kDzTvukOcFToJcwV8QUiAdrBr1lDrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RBSYfsut+4CHVOcJ9DnetNjBHO64Z+AhqhuIxnjx8s=;
 b=yOkv9bQrBqd5N4GIGrK56H7DmRvht1Axe1ox+GAtaeT6dCrNQLq7vOzc+aWzZtQ5SLmF0YKr0Gasy/1AMYrj72JCDue1LT2SBrz0lGQtQTJaLA2t+RtgHp52hokKzZFrwsbuK5tEE+9YEVITFG+aH/kvP7m3fDDANmNfZkok0vCiZMfZriXIVXY8/Ucag7m/XBc0LEl/rhryVURfmL2cgtnB4SIK7AbYtiubeJMkREwhSSGsFfDhsd2xtSC0RlTv4Ec7lZJXXNU4LaPlJTGBLZhXyV8Tw6UAzlz3wj94VHlK7Lf49VYN0RLNVU3nMDsM7T78A4Yk2EWs7HWd/4akBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RBSYfsut+4CHVOcJ9DnetNjBHO64Z+AhqhuIxnjx8s=;
 b=YE/LxfN/29iZGsJKRdcFhs3eGUSz8z0p+8pcvw4kHkAikrmD+u6e2pb1xkwU3+m+q/hGmb5FlqZHChlSvSkE1wO0q9ntcc5lB6aAFj3jLZsHw0k60IBpBYuFjnlvP8XtG+Usq1uhQ4MVIw8JnInvGUg7xuqaZnPyFi8yzROvpMCZgKMsigpJGWOXrGMJ28ahzNgZ0FKY3raK5jRpgnOf80NE7R24u2yzTqH/XVnTI8OLLIcCozvTT9MtvxDJAiSVmMqUJcU4CuUMg1CsssMjHFpakYGbuejGHm9HTbmI/BWvkuEyacIx/mKFMk4rbWZmjou5vgxTSDYo46RT1PNKUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by BY5PR03MB5078.namprd03.prod.outlook.com (2603:10b6:a03:1e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 09:47:18 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 09:47:18 +0000
Message-ID: <4a6577ff-7417-4d34-a683-2402736fd9d7@altera.com>
Date: Fri, 24 Oct 2025 17:47:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: rawnand: cadence: Add support for NV-DDR interface
 mode
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251024071306.242227-1-niravkumarlaxmidas.rabara@altera.com>
 <87bjlwrbqd.fsf@bootlin.com>
Content-Language: en-US
From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
In-Reply-To: <87bjlwrbqd.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0059.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:23::12) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|BY5PR03MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: d954fa3a-5ab2-4924-e55b-08de12e25202
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clNJdGlseHUyUnJJNXdWVm9wNmxhbGwzdXZRTnFrNTB2MXNEUFFJWE1LbzBa?=
 =?utf-8?B?VWxMSkVTZ3RxSVhLTlVtMlJ3YldvaU95SWlIS0E4dXFJQVZ5V1NVT1lkNUsx?=
 =?utf-8?B?WGVGSWlVRGwzNlVQSTd6TStRRlY3L0Q2VHFKbW9YQjBqTkkxcnQ3ZzNlUUp0?=
 =?utf-8?B?dGM5MUllYXN6TkJHWWF4elhJTFlJZ1JpdEd2YXF2VzNtdmJIaVgyODNTTDJY?=
 =?utf-8?B?RFViaWVpRjdHcitsSFBLeTJtU2ROQ1kxeVFMSEd0TmVnSFBTNGZxeGk1emJ0?=
 =?utf-8?B?QllTNS96T2FvREhDOXBCRE9vbDJ1cEMrNVlBem5EQldOS2t5ZEdFY1NTNXk3?=
 =?utf-8?B?RHdQVTN3a0JySTlmRTBWZ0JxRmVLazd5YXBJa3hockMzbWVmeXRlZnFlNEl5?=
 =?utf-8?B?UmZXWnl1cC9HOGtGYk9mY3p6QklsMjRESnl1NGJnY1BsZEdwektrWGNmci9z?=
 =?utf-8?B?ZmZMblRoV0NJbGJHcG94UTlUdDRqZE96bnBveGgrUG8vSUJ0V0pLdHVLckda?=
 =?utf-8?B?MW53VVRtVS92L2cvODZteTdLa3pFQlFEMWk5eEtRWVpTSG9sTkswZitpd3Bo?=
 =?utf-8?B?R29jNnd3eXphUjc4WXBvMzJqSU05SGJRQjZVR2NCcS85YkVBdnBWL3FkT3M2?=
 =?utf-8?B?Q05FSWM3cWxKMlc1eHJHWFpYbU1YNXN6aXhFWU1xV2FUVXdFL0tQUjQvdjlV?=
 =?utf-8?B?UHk5ZlZER2RnSVA3K3FidVkvR2Z6Z3pyYUsrWEpIOEkzZll2YzduMGRkU0NP?=
 =?utf-8?B?dHIyeXk2eWpzdm5wUGhINndoeGZYMVkrd0ZudmJ2QWF6VmNRYjdCZGhYeDhU?=
 =?utf-8?B?Vk9ma0kxQm00cVl6eE50T0E4Q1pqZ1A5Yzg4TzdBYXI3dUQ5YXdXU2hibFZ3?=
 =?utf-8?B?VDErQ0JHQjd5bWdncjBlMXBYelZnY3QwOVJ5L1dXRWZUZ1ZGamlSTGgvdzlo?=
 =?utf-8?B?UGJMNVFlYnJVQVdoUEdmQnlRZVA4SytETTNKK3NtVWUxN09ZVThwZG5zdzVh?=
 =?utf-8?B?emhCdmxKSHFUNHJ1T1VUZC9OVlZtTis4dE5SMkgyOVhXbk41RkxzNXNCbThv?=
 =?utf-8?B?VFNmclIrcTF3a1REanlLMWtkcDI0aSt0YXBwTVBPV0ZKVXhMQXNEUXgyeDhp?=
 =?utf-8?B?cFVpazd0N0NOWjRSU0M0N3RybzhYNS9qQndPaFVDMUJtbE94NjB6dHdzZS9j?=
 =?utf-8?B?cFUwMEQycDFvOFBlUy93R0UwbVRoNy9KSE1HY1Eva20rZGtaNlpvQTVXdmUx?=
 =?utf-8?B?SUNLS1A2VzlxbFhrWCs4TFBxbUlEYlZob2I2WUgwd1dJYWJ0dFQ3WTVCWmcx?=
 =?utf-8?B?aHZhWW0yWTJETUZhb1g0QVlKb3h3aFgvOUo3K2t1SndPbmFjUnZnV3dUcU9D?=
 =?utf-8?B?RmVONFlmeWY2NTh3b3gxRnlDbUtvYUlTM2xPZTVDSlVQSnRuZ3JjQWd2Rysv?=
 =?utf-8?B?WWlEbUljY2s4NVFTVWErYk5oQ1k4bTVVQ3B1VkpEK1cwajhaU2tRUkh0eXpk?=
 =?utf-8?B?OFZDNTJEZHI3V1pSdjZjblFsWlNyRXg2SXdvandoYTUvMkF0MXhIbS9ickd3?=
 =?utf-8?B?d0F0VGcvQWt3clRiZk8rb3dOWlZEaEk1OXNMU3VkS0dhcjVIWG4vVkM3a09D?=
 =?utf-8?B?Z1dReDZJTWxlUUtneVhqYmNLWXE2R0VFdEJrbXlENythUFU1Q0t0NCtqcUNR?=
 =?utf-8?B?aU5rdzh0OHd0WUh2K0lZSFp0RWZFNER1ckJwb2pISGNjYnA4Smd6SXlDaXNr?=
 =?utf-8?B?bFZQb1ZaOWNGTTBiSHY0b1BHSDZtSjVKYUhFaUdSbS8xQVV6TDdOWU45QVdT?=
 =?utf-8?B?RXlQRFhQTDZTKzdaeW9pZE12cXp2amFDaENsTjJOaSt6UWFFL3ZKc2NzSzAx?=
 =?utf-8?B?QUQ5KzVBSno3ZEUxRWd4N0JyQm1KaEZkMk50WDBWckk1YzFNejNJUmdNU2Yr?=
 =?utf-8?Q?nkSninzg8JkrYzcnDC8iH2MbM71u6OC/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmJOK3RnckZvUXRDQUNSL3BnVXU4cUFld3RmcU12M3U5SFUyc1dSTUdmNlJv?=
 =?utf-8?B?L0x1UDZyN2VTOVErV0tCc3hmWVpKVDROQzVGV2xWc2dWTmZkQkpLQ2p1aEN3?=
 =?utf-8?B?VFZ4aDlaejQ4Y1ZZcExGZUdTdDN0NHdLOGZxU0Jhb3BMMXFwUEgzZEtsdFZT?=
 =?utf-8?B?WHNIZ2hQdW9VbTNJb21FSnorZEZxKzV5UUVEZHlyWCt5UHpUbzlmWmdUcnV1?=
 =?utf-8?B?UHBZTWMzYUVORFJ0REFvMUEyTXNPeWRoT1BNQktzaGxtNVlJOXhucFNydGZD?=
 =?utf-8?B?K3NZdjNOOUltcXBSV045K3lpZjJSUVpjWmpkbVpFblVYL3ZRdlJjSElkNUF5?=
 =?utf-8?B?QWdOM2x4anpYenBMREZHT1RPK3c4ZE9hSjNGRFdlUHlsQUR1NXpKUERQa3hZ?=
 =?utf-8?B?RUsyNE8xd29SSzBaRzVtaGdPQU8raHQvL2Rwa3c4WUF5NU5OL2xTZnllc0ts?=
 =?utf-8?B?TzRDWEtzdzBQUThsc3FxaTEwRkpxSHBRWkF0Rm9zWnJMSWkrcEFTOE1jS1h0?=
 =?utf-8?B?OWRydE02bVNIVHhQb0k1VkVGM3NtS0tGMy92TllNaU9SQmFUN2d2R1VYOEg4?=
 =?utf-8?B?cHpNcC9SbGd4YW5MRzdFUW02dVRRMVQxY3NXM2VyRVNkUkFpa05VbkNHN243?=
 =?utf-8?B?TTQ5RktNNEI5OFlOQ3htMlgyQUt6QjFoazRkd0xyZm5FMGVMemZxaWxlUFFN?=
 =?utf-8?B?UXJiczVuS1VFc3krODladlNJQVZNWlNHSmc3Vm92SnZpTXdVdm10L0dyMUsv?=
 =?utf-8?B?K01ubTZMVW1RaEVJMi80Rzl5QVNzQ01ybHFZSTF1U2FkMzRqTjZ1WTdURURh?=
 =?utf-8?B?djBUMjREMm1nbGhmeWZmWk14K2N6VWQyamF3WkpBeFJhSSthbGV6RW5kRFNE?=
 =?utf-8?B?SVFQSHY5NjZsRGJOaktVd3cvS0xNeklDVU9TclVqRzJGODM0V3UyajZvSUs3?=
 =?utf-8?B?YlJob2dOaFluaXQ4bU1OMWhWb3R2K1RuQ0IwZFd1RVRFdklDUVFZMStGc1ht?=
 =?utf-8?B?S2wvR2s1U0c0MVJaaW00bElGanNJaGw0aXpvZFpxOHF4djl4RFdKd2hFSyt5?=
 =?utf-8?B?Zkl3MXh6QXhIS1VLUDFyRFJ3SzBGUncyNlEzM2JxYW5xMkdlNFBRd3RQYTUz?=
 =?utf-8?B?SXlhTXg1eURncEQyaU1ha1ZmLzNVMDVDZ3M5Y1MrajM0YWZkZDlvM3ZQRFZ0?=
 =?utf-8?B?ekpZcTMwSit1ODEvQmFXT1FYbkh3SzViVE9tQkorQnJOTWJkT1hKdXlhK0gr?=
 =?utf-8?B?WXdNYmFsTTJNekkvK2QwNEt6MjRaaFRER1NYV1lnUkV6WjV5VWptQitOcGhr?=
 =?utf-8?B?WnRoWmp4WlNYVDdmeC9zR296YjNWN1hLY2dEdHlyTHUrM2xwQm5KS2VTNTR6?=
 =?utf-8?B?dDdIVVdoN0JLWXlrcElZYk0zdGxBeXRJQTFJb3MxejBIL2tUTWYwRmRJa09Y?=
 =?utf-8?B?QWE0cjJsMGsvclNNcHhESU5TalZPTHAxUHN3a3dVNGJEeDJud2k5allTQXRD?=
 =?utf-8?B?eGQrYWx3SUVId2VVYzlENlBMZCtFeXJYaGdudW9ubnNadjlJZEN3NmZMMTJO?=
 =?utf-8?B?OE01QTJKcXhWWFlGSWpRdmpGdWt6UTd3THg1ZzRKYUJTVkswRnV3NFQyemxI?=
 =?utf-8?B?bVZvMnQxdG8zSkVQMW1VY3BUSkZYY2VQWnI2R0I4Mk9meWsxZzZXNTFHQVBo?=
 =?utf-8?B?RExLdllUM3k2R0t1V3BGcGJVZXMyajBuOVNxV3VmcTd1OThDS0NyUmM5U2xC?=
 =?utf-8?B?ZU5pNFpWa0RndWxUaWVndllORjZVeHR3dGZlbHJoSzFSNWIwR3JRaFdiVk92?=
 =?utf-8?B?eWttUUxEL2NwUkxTOUU1cFpocGtISEFxMVMrMnpZU0JCY0NrZ0l1UDhRZDBQ?=
 =?utf-8?B?bmcyZzdpM2t2M3dyVjlqeFB2U0paVjJuYXAxcmZuaVFZaGNGc2FpYUZpMTR3?=
 =?utf-8?B?aGl6b2srQVhieW1WT2FvbCtlc01neVRWd2k2VWdPMnZkSzAxUW5WS0dvamd2?=
 =?utf-8?B?STdDMmN3N2dsUEpjYThIUkF6andHaW16ZGNqemFxUVYvcDVWUGhHVWZ3dVhu?=
 =?utf-8?B?MVNWeVF3MnVGZHFyREpmOTd5d0pwTndYc1ZGRTQrWHFoaGt6MkdXZzhXOFM5?=
 =?utf-8?B?d0xSZ2JhWTNOaVhSNmRpTVZKanNUYk1aYmRpYkszc2ZtS2pMTWtvYyszQnB6?=
 =?utf-8?B?eXlIVU1zaVFldXNrQlpONU5CekxGUiswQUNocFZqUWUvTURZb3JtZTlCSFFP?=
 =?utf-8?Q?3LQb3CNiFGa26Ly59/2E6qctwCdns+Rno/170SB5Ik=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d954fa3a-5ab2-4924-e55b-08de12e25202
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 09:47:18.4533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5ClwCZEzb+TmNn8Xs9QJ4TRIxUq+wMaZFeFLsuextRVdsEccgcO6hQicZzhNdHrXhhAVClmnBBTHFJfX9gRfoOoEKwyuCAP/uNhQCJyfWCDkV2RDGOmTkBkGdMM0SqH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5078



On 24/10/2025 3:38 pm, Miquel Raynal wrote:
> Hi Niravkumar,
> 
> On 24/10/2025 at 15:13:06 +08, niravkumarlaxmidas.rabara@altera.com wrote:
> 
>> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
>>
>> Add support for NV-DDR mode in the Cadence NAND controller driver.
>>
>> Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
>> ---
> 
> Thanks for the patch, very happy to see people implementing this
> interface!

Thanks for the review comments.

> 
> [...]
> 
>> +	if (dll_phy_gate_open_delay > NVDDR_GATE_CFG_MIN)
>> +		ie_start = NVDDR_GATE_CFG_MIN;
> 
> Can you double check here? I would expect < instead of > given that you
> compare with something you named "minimum". Maybe it is legitimate, just
> warning.

I have double checked, the logic is correct. May be I shouldn't use _MIN 
to avoid confusion.
In v2 I will change NVDDR_GATE_CFG_MIN to NVDDR_GATE_CFG_STD.

> 
>> +	else
>> +		ie_start = dll_phy_gate_open_delay;
>> +
>> +	dll_phy_rd_delay = ((nvddr->tDQSCK_max + board_delay) +
>> +				(clk_period / 2)) / clk_period;
>> +	if (dll_phy_rd_delay <= NVDDR_PHY_RD_DELAY)
>> +		rd_del_sel = dll_phy_rd_delay + 2;
>> +	else
>> +		rd_del_sel = NVDDR_PHY_RD_DELAY_MAX;
>> +
> 
> [...]
> 
>> +static int
>> +cadence_nand_setup_interface(struct nand_chip *chip, int chipnr,
>> +			     const struct nand_interface_config *conf)
>> +{
>> +	int ret = 0;
>> +
>> +	if (nand_interface_is_sdr(conf)) {
>> +		const struct nand_sdr_timings *sdr = nand_get_sdr_timings(conf);
>> +
>> +		if (IS_ERR(sdr))
>> +			return PTR_ERR(sdr);
>> +
>> +		ret = cadence_nand_setup_sdr_interface(chip, sdr);
>> +	} else if (chipnr >= 0) {
> 
> This isn't very clear. Please make it a separate condition if you think
> you must handle this case. Otherwise you're mixing it with the SDR
> vs. NVDDR choice, and that's misleading.
Noted.
I will make a separate condition check as below in v2.

-       } else if (chipnr >= 0) {
-               const struct nand_nvddr_timings *nvddr = 
nand_get_nvddr_timings(conf);
+       } else {
+               if (chipnr < 0)
+                       return ret;

+               const struct nand_nvddr_timings *nvddr = 
nand_get_nvddr_timings(conf);
> 
>> +		const struct nand_nvddr_timings *nvddr = nand_get_nvddr_timings(conf);
>> +
>> +		if (IS_ERR(nvddr))
>> +			return PTR_ERR(nvddr);
>> +
>> +		ret = cadence_nand_setup_nvddr_interface(chip, nvddr);
>> +	}
>> +	return ret;
>> +}
>> +
>>   static int cadence_nand_attach_chip(struct nand_chip *chip)
>>   {
>>   	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
> 
> Otherwise looks good to me!
> Miquèl


