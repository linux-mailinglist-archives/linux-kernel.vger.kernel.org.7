Return-Path: <linux-kernel+bounces-731216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F35B05117
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE6B1AA645F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CA025F99B;
	Tue, 15 Jul 2025 05:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cH7p1kiH";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cH7p1kiH"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734FC2CCC5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.18
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557977; cv=fail; b=mOp5ByKjA1M9trmWtcRkupZhGq+GkHSJia2wQoft5+64zLY5axrwn9r/J/i6ziPZlTS7LTT6JoUcdNoXNQUWuDWXFaLCri9vCeX5QS7h7eerUsSTWzX9Gs7pHZaaFoDNSMiR6YHNJXtLmU0GOmeCpex3BKRoWFEWxXfpL9sykz0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557977; c=relaxed/simple;
	bh=C5XUWRztYi7tjmYHYyKN/Td1APdI9orTMzZjxfua4E0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vCafy10j/OwHYVYnjBxfGP/wpMMlll2nOwvCe18QETCcCB0kbO3ijDZL1zGPNwgPLkh2MLnmeWZwz/r6CLDow7ds+zZ4D0iC+j2LHoezGd1Tj0hWQ/TPVsjgVyPAK9sIIQ2eBDPdyvP4Kes9H6yuzrQ/Y/0qMfqCQqsT2L3wDzg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cH7p1kiH; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cH7p1kiH; arc=fail smtp.client-ip=52.101.70.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xTnLCx7m1fy8Th1O4wPoQkiKPAmNoAwKRSIwUfDommAdOOP0gO2ftv55j2101RxB12xbNa9SAwafcD4kllz+KFp/t/W072PLNbUgeJiVbpG6ux0XbATZFXC61Y7aHAvEePpqxGWYCgIsTeFKnkaAShIy9I4CRCS+sxWvFZQn9bLBrE5wzmocn3brh8nf2XGylha4ZZyDYxOdrPVCX6G1D8Z7kOCI2j84z7dlqRRzRcdqq1nvR69IervMZP6WZurRSqkUxRneq4RmK78PfNq1jKcIpaQlRaPr7fr+kojK2IZU95bbxUOanI27FQa0SUDnUrV+zOVRDy6tig9/oWmPng==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqYcUjvjsRETe+TiOrWftFwq6upJEGvCuLSyYALXwWo=;
 b=GXdbh6HtLkSynnyr6ya6wCpGiR3G0rpSqJ43tt2rWgqjmdtFGLrTLxQrd9Q5k40iFQgBLuZhrwbMEkl5G/NkvD/dMPD93ccxHHsYuLIMmcJ9qTs9z8vXMcyJyev9ZByremb+PWclleuA2DdXngX1ATVMHZepxVp70QupRf52JAStajZSm2WIPIt2Wd0r8d8ZthUr7ePoNDbRALB/Q+LItiWH1FOsRzN+NfCGIcq7rXksL+s5x6uMlHHs3sAO7DJitKTcOsi5FZiTUT03dMof4I6XO4gM+BsiwcgI34Od2FWKbTkRh/j4MTnemvxuH0QRLNRH/V7wamXNGdDtgi+GOw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqYcUjvjsRETe+TiOrWftFwq6upJEGvCuLSyYALXwWo=;
 b=cH7p1kiHc3Pl8B7Wajle+xYNRIqKpo8T36Vu9VT01qohfiq7qFTyKJdp0IF/EQGLvXoQzjN1FJF6rgrVkA3BHDyFuvL0QBiO5V2BQm3hUg2Pz5KHPYl5VIVuDzNreOk2rRdzbM8h2ozGyxEM9TBrjF2B5lDoSVfnoNhUq6bKMtE=
Received: from AM5PR1001CA0045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::22) by DB9PR08MB7625.eurprd08.prod.outlook.com
 (2603:10a6:10:309::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 15 Jul
 2025 05:39:29 +0000
Received: from AM2PEPF0001C70F.eurprd05.prod.outlook.com
 (2603:10a6:206:15:cafe::b5) by AM5PR1001CA0045.outlook.office365.com
 (2603:10a6:206:15::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 05:39:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C70F.mail.protection.outlook.com (10.167.16.203) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Tue, 15 Jul 2025 05:39:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIdOOJXi81EqJDCA8OaI8X49wx8CM6/jOgV5IwMN9dtgL6CSp+5z3t9TNeDrNDaGlspZEr96eopftx8GYkzywSO5cNPl+Nfkwl6g4NPBb36ay8mMGisVVug3kFM4aCbDHkwYugRucwXcePMRYieTqh63CqsIO/UlIdARD66zmIkw+LTkfvCavN5XrR7C3Ez6JW9T/Qm2pzWILmDKrU5ggOdIiOacI1BXoEGAu8iNjFbGK7MxL++ZVeaLiueIjkwoAgkPTM+mhTvaMMndkwv2a7yDQlPQ9Y+CsXjD7YeOdFpgcfLvB5iPggctOKQE6FStSPcNrI2LLSpuA6bNdh41Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqYcUjvjsRETe+TiOrWftFwq6upJEGvCuLSyYALXwWo=;
 b=Quckhz4ORahhgjSZYg8xIXlm6MkCPDhoQfAToLqmr87E7Baf8ztpge7nquNddizO2F4CehZ01+m2SZ4Cu/n8dBcZ1Q6oz1w40hx7XqlE/Am6ZqOEnKZ3Hkb37p5vU5Ej5qPRs1ntqi+CrBE+pmCnIBmE77Rm+SclbKoEcRrJmDTOHe16nMrAGW5gb1vgwOvZ+STiTs/I7eKWRmg1cgzw/0f1VwD0sfROjWfgW1T/wHM1dSVXpdspQiWbeSCukGovOaTvhHmXJ+dnYskN+mbJ5Xcv6N1URtxHSMPS7FE8LUCGku6GGWJcjickPov0B72+QtaHaDjPP+E0pyzpzdGibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqYcUjvjsRETe+TiOrWftFwq6upJEGvCuLSyYALXwWo=;
 b=cH7p1kiHc3Pl8B7Wajle+xYNRIqKpo8T36Vu9VT01qohfiq7qFTyKJdp0IF/EQGLvXoQzjN1FJF6rgrVkA3BHDyFuvL0QBiO5V2BQm3hUg2Pz5KHPYl5VIVuDzNreOk2rRdzbM8h2ozGyxEM9TBrjF2B5lDoSVfnoNhUq6bKMtE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by GV1PR08MB8620.eurprd08.prod.outlook.com (2603:10a6:150:84::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Tue, 15 Jul
 2025 05:38:53 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 05:38:52 +0000
Message-ID: <1b15b4f0-5490-4dac-8344-e716dd189751@arm.com>
Date: Tue, 15 Jul 2025 11:08:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] arm64: mm: Simplify
 __flush_tlb_range_limit_excess()
To: Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
References: <20250711161732.384-1-will@kernel.org>
 <20250711161732.384-10-will@kernel.org>
 <b10fd873-6de9-445a-a43a-cd588b433f42@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <b10fd873-6de9-445a-a43a-cd588b433f42@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::25) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|GV1PR08MB8620:EE_|AM2PEPF0001C70F:EE_|DB9PR08MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 85fb3f52-d1d7-4fbf-3997-08ddc361f792
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?b3krRStMNktzTDZGanJCVEJoQ0EyczVJWFYwMlVIbkJQZVZnMS9BMUtwSFR4?=
 =?utf-8?B?c2xnMXkxQnhlMXNoNkV0WXBKMHRudVNpK0Y2bVZaa1MwTWdiVXVTS3E5ZXVP?=
 =?utf-8?B?Y2k2R0JDVHV4dUlXZXAyWldBL0JMTlAwRDd0ZFZLL290dnl1Wms0Q0JPKzZh?=
 =?utf-8?B?OGxhR2twRHdvUE1Lek1kaDdqT0RsRHZKVGplT2M3TldId3U5U1hmUE1DWUZX?=
 =?utf-8?B?aytiSEJocENnOEtwcHRiSDNIYmcweXJVQXZVUTJXTnhnMFZwSjJJK1pOaEl0?=
 =?utf-8?B?dG9MYTNwNng1VjJYR2JMUXlBNDNQUE54Mko3ZmtKWXRJMWkrOHpFVFpDanRG?=
 =?utf-8?B?Y3hCcUJ5TkVkZjJXVm9jQ2dVSUxPanp6a3l6NXBnUnQ5K2xUUGxvaVNXcHNJ?=
 =?utf-8?B?VU03RmxMcUhudjhCSElzSm4rTVNqelFkWldVcFJ6cVZhSGVRL3pZNG4wb21Y?=
 =?utf-8?B?RnJ4NitDMkxxc3l0OUo3UEREYmJUTFhyM2J4dmRod2txNmpZdXhGUGFkVnVo?=
 =?utf-8?B?b21IMWo4TG5vbnFoQ2J6a09qY2NmQzMxbU1MVzhaOVVobnlSUEJpZmZ5VS9a?=
 =?utf-8?B?S0tMMTErcnFEMk5jRFdJSWpNdGI3TWU0dkZ3TTYzZmJiS1UwOHBwamhXUWZs?=
 =?utf-8?B?eFEyMG9EV095bjUxaEJjVjVldzNZYVlhUHdhRC9xNEtnaDRodkYvMHRhUk9m?=
 =?utf-8?B?KzdOWkNWSVN2UEQ4SGV6RnFHZEdtM1YwZkRRaTdLaXd2TW9BMU9OL1VDTHdn?=
 =?utf-8?B?bXdWdU5HY2dXRnFiZ3VMaVpxU2I0QW1yRnlENDZ5WllKOHo3QlNJMkFkLzVC?=
 =?utf-8?B?cUpNTHFPY1NXbUtMeXdRTDh6ckk3ZmkyK0drUVB3VmFFMytHVGZiNG5MbkpZ?=
 =?utf-8?B?a3VoY2JQTWduZndSV2k5NVord2NtaHpmSURNRk02b0g0SEd5Rko4WDQyalRv?=
 =?utf-8?B?MnZTQ2ViODVuVk1LNnRERlBuVGtkdHpvV2EzdXJuL2d3VGxBVFBWT1RXOFNw?=
 =?utf-8?B?cEEvRVRld2EwcG1RSDZwM3hPdERsTVRzU0JtUjNKN281NS9VV1RmQmFnSTNm?=
 =?utf-8?B?NWk1d0FpK0wvdVNnSzh2SUx4UUo0L3ZvdlBEYVdYM0hka3psQ1pnNGhvcElt?=
 =?utf-8?B?RTEwWXdTalUwY2FCWHJ5U2szRHBUaXAwclFyMS80RnBKc1B5N0gvTFRQRGZx?=
 =?utf-8?B?Y2JCaVR6WEgyTVRlWDN3QXprWVpaQ1ZzbmRQMC9tUmQxZmttbTFHRUxhcGFv?=
 =?utf-8?B?SzE2aTdTQTJsUUwzZFN4Z05XQjBONUJVM2VVTHZJNkxCM1FubHhudFp1ODZK?=
 =?utf-8?B?REcrNFVhRzFoQUdMelMySyt0YjFnNjYyYmpSUDlXREE4MWt0TFNjU3hPam9q?=
 =?utf-8?B?YlBjSExMdnJTL2VURkJKYTdVdGpxUmxBeVdKWitBS2QzbWJuTzl3b3pMRldx?=
 =?utf-8?B?YVkwaERBSlBNbFluL3hpL21TS0hLeTJhUkxjWTl1ZCthakl2VTc2UE5zMkt6?=
 =?utf-8?B?MHIvRk05UUxoajk2b0hFUFoydnZuYU5QbW5DZGVyNGMvdVBla1hKdUNkbVdF?=
 =?utf-8?B?S2xzQmszM1VYSkh1TDdYNXhjTm8rMVBqRlQ3NWtCRGRndkRINGhDMFVYbjZx?=
 =?utf-8?B?KzhzZkovY1pVMlJEMjhKUWt2cE5SaDZYa0lJaXA0WW9hVS9wZ3NuODJlZmtC?=
 =?utf-8?B?UXVsOHh5bDlzbG5zWW9odnB1Zm9wVkt2QlNHeitSVEhKT0c5VzE5azQxTHFY?=
 =?utf-8?B?WGRmQzNYMUpPSVhMdWJwckNKVUJuRDIzNVZqcXVNS1F2Q203blhnUzFNRWl2?=
 =?utf-8?B?aGt3a05FZ203bDJreVlsbXFzMTFBWDEvazIzT3B1WmVnaGxBSDBJSUZvNko1?=
 =?utf-8?B?dzhvRnQxN0Nkamx1NURNSi9paVA2eEpsMTBHK2tEbFdQKzlqNU5CVlMrSUl4?=
 =?utf-8?Q?CfhbePQMWmc=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8620
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b26835b9-fe43-4db9-a591-08ddc361e1f4
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|14060799003|376014|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzUyM1JmR3hUTHBIemlFbk1xN3VOME53M1Q5RXFQQXQwMCt6ekV6UWpVcVBV?=
 =?utf-8?B?OHdLS2daWFFRQUxlOUtnQ2JscGIydGt0YWU5KzVJN3JCMFd3enFUT2lJd3RZ?=
 =?utf-8?B?emlTY3VGRURabGk4UHJid0NnMTVFVnMzUURhRUtjeG9VQThDekNRR0hFNHNq?=
 =?utf-8?B?ZWJrakhVMWV0eTBBZzgzdEFDVStmaGdhNVk5T3NOZ0pFNThsWkx1d0JGVVFO?=
 =?utf-8?B?a3QxbVpYYkxtdDNMenhwclhnYmpjUmdGdGluakE2MUxvc3RpZWJZR0dSd2ZB?=
 =?utf-8?B?S3RjbFg4UnUvcFlONkVBV1hJaDBZaGRyQ2dDSFQwd0p5RENIbkVOZThTRUU5?=
 =?utf-8?B?RkpWc1d1U1BWYW83eTE0VnppN1JWbkNDWGJNOUZwNSthMVpPaDFaaUd6a0lk?=
 =?utf-8?B?YWYyQytaVXFtZnJOTFlNT1RhME5PQUtBWC9yNnZFVnJLVTFzKzZnT0hoVkZv?=
 =?utf-8?B?bzZ2MnlpL3pYSlVrcE9BR1lrMEY2SkVOS2czV292T3RJeGpVV210VmhKTVlZ?=
 =?utf-8?B?bkNCa1BxdG5URmxrZDVqWEFuVjBZMEQ4YkhocXo0SWtMKzJWQmdJSU12QW01?=
 =?utf-8?B?a2JkMmJ4b1NUZEFKcWxXNURLajBKNmtRcVpjNU4zdzBIeXFhdjNmRk1vclVC?=
 =?utf-8?B?YjFOS2NWRFB2ZVZtQXQ3emFnWVUrenVHS3VDQnhnTFJwM2VOaGgvOWEyZVJy?=
 =?utf-8?B?UDZvWUluUFdpdXdBUE9GWW9UQWZCazVyVUE1akhwdUxNcHN5WDBCcGhDVTV1?=
 =?utf-8?B?d3FoOUpnaWVEUFh2UE5QeXZNOTQzeXF3eEJCSThPSVlzUFJPeFpHN3lLN2hS?=
 =?utf-8?B?S256eXZ3ak15ZUc3d09MUUdWWDllLzhSSFFhUWpGSVNUTW9mSlpFeGRuWWJG?=
 =?utf-8?B?MW5RK3N1ajdtb3FPc0xtaGJYblk3QURHaVgvamhlbkNuSHVKK20rb1BJVlNz?=
 =?utf-8?B?ditZL29DMWFwVGJEMXpRajZsdTdPNm5PRFd3NmRnbGhjT3R5NDdBTUZTZWs1?=
 =?utf-8?B?aUVDQjBRd1ZtcUFFaEk5ZUZsaCtVcm42cC9lK2wwQ1M0dmNFTmJhUS9VbHQ1?=
 =?utf-8?B?WU1Vc3RMNEw1a3dkL1lPc1NjQml1OGVoMWo5c0ZwNENsc01xMHowS0hIZWsr?=
 =?utf-8?B?KzduMlZzS1hRYmxnR0wrc0xOei9VQWxVQUFwOHlCRDd1ZmpNMVZWcUprdm55?=
 =?utf-8?B?ZCtzd1lxdWVhZTNVTzhtWkk0NXU1NzJCRE9nQi9JT0ZGOEdYWFNDd3lDRXdr?=
 =?utf-8?B?NHR5U0c3bVl6WlE0bG1HVzdXSXVPWGpydS9UTkc3blZqQnFQa05HNmc5MDl0?=
 =?utf-8?B?c2pjUUYwS3RWT1lqdHhsY1VQdEk5d2xpOGd6bm1VS3lLWFBDaHdhMnYraVRm?=
 =?utf-8?B?RGw1dTNBbGFpWkdpWnJDay91NGJVZlYxUXBJY0tYRXN2SzZLUGdTRVVPb1lL?=
 =?utf-8?B?c0FudS9IWTB5SGNCZlZ5bUIzbHUwQjZhSDYwTFVHUjJyT1lkc1Z1cTJmUFM5?=
 =?utf-8?B?QkZkekZDcndjV3hMMjNLWmsyUzZGalJQMEJybmVvNlJyaFhDR1RoamREVmZo?=
 =?utf-8?B?dWs1akZ2a0VyZmlMTFVFT3YyeVFjeGppUlJQKzFIYSttK2dCQ3FCbUN3S0RN?=
 =?utf-8?B?WDIwNVdkR2V5cHhIWEJrN3M1TmVZaGlLZXJVanVRRWZzc2x1anZ5OGQvbGE1?=
 =?utf-8?B?THVSOHpsSE9nNC9tMWNWN1ZqbzdyUy9FbGphUXJCSWhYVGdEWFVscEhpeDhs?=
 =?utf-8?B?Y0JNRTdhcEtKZjdBN2RQbmQvRThPSU5EVzBKMkpWcHZ5dVY2em41NmhOcmxn?=
 =?utf-8?B?cVlTNjhUUzFzTTVBU1JsbVJPcU9Lb0VXbmdKM1hmSHY3ZUtkM2JlYkFpdkNP?=
 =?utf-8?B?dWRlK2RlUTgyaE5DdmdPS1ViYnpPcDJ4Tm5mL21aVkFxd1JZUWhaZWtITVR4?=
 =?utf-8?B?YTJYRjFNcGFpYnZvQ3FZYzZ6aXRoOTExRlVOSENDLzNubVdId3dpODkvUC9D?=
 =?utf-8?B?QkI3b3NITHBFb2RBNzFuZFN1dUszOW5YSFp1bm9LS1BpRjBVYnlGT3Btc0Vr?=
 =?utf-8?Q?/CWhfd?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(14060799003)(376014)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 05:39:28.8317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fb3f52-d1d7-4fbf-3997-08ddc361f792
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7625


On 14/07/25 3:00 pm, Ryan Roberts wrote:
> On 11/07/2025 17:17, Will Deacon wrote:
>> __flush_tlb_range_limit_excess() is unnecessarily complicated:
>>
>>    - It takes a 'start', 'end' and 'pages' argument, whereas it only
>>      needs 'pages' (which the caller has computed from the other two
>>      arguments!).
>>
>>    - It erroneously compares 'pages' with MAX_TLBI_RANGE_PAGES when
>>      the system doesn't support range-based invalidation but the range to
>>      be invalidated would result in fewer than MAX_DVM_OPS invalidations.
>>
>> Simplify the function so that it no longer takes the 'start' and 'end'
>> arguments and only considers the MAX_TLBI_RANGE_PAGES threshold on
>> systems that implement range-based invalidation.
>>
>> Signed-off-by: Will Deacon <will@kernel.org>
> Does this warrant a Fixes: tag?
>
>> ---
>>   arch/arm64/include/asm/tlbflush.h | 20 ++++++--------------
>>   1 file changed, 6 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>> index 8618a85d5cd3..2541863721af 100644
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -470,21 +470,13 @@ do {									\
>>   #define __flush_s2_tlb_range_op(op, start, pages, stride, tlb_level) \
>>   	__flush_tlb_range_op(op, start, pages, stride, 0, tlb_level, kvm_lpa2_is_enabled());
>>   
>> -static inline bool __flush_tlb_range_limit_excess(unsigned long start,
>> -		unsigned long end, unsigned long pages, unsigned long stride)
>> +static inline bool __flush_tlb_range_limit_excess(unsigned long pages,
>> +						  unsigned long stride)
>>   {
>> -	/*
>> -	 * When the system does not support TLB range based flush
>> -	 * operation, (MAX_DVM_OPS - 1) pages can be handled. But
>> -	 * with TLB range based operation, MAX_TLBI_RANGE_PAGES
>> -	 * pages can be handled.
>> -	 */
>> -	if ((!system_supports_tlb_range() &&
>> -	     (end - start) >= (MAX_DVM_OPS * stride)) ||
>> -	    pages > MAX_TLBI_RANGE_PAGES)
>> +	if (system_supports_tlb_range() && pages > MAX_TLBI_RANGE_PAGES)
>>   		return true;
>>   
>> -	return false;
>> +	return pages >= (MAX_DVM_OPS * stride) >> PAGE_SHIFT;
>>   }
> I'm still not sure I totally get this... Aren't these really 2 separate
> concepts? MAX_TLBI_RANGE_PAGES is the max amount of VA that can be handled by a
> single tlbi-by-range (and due to implementation, the largest range that can be
> handled by the loop in __flush_tlb_range_op()). Whereas MAX_DVM_OPS is the max
> number of tlbi instrcutions you want to issue with the PTL held? Perhaps it is
> better to split these out; For the range case, calculate the number of ops you
> actually need and compare with MAX_DVM_OPS?

If system_supports_tlb_range() returns true and pages <= MAX_TLBI_RANGE_PAGES,
then it is guaranteed that the number of tlbi range operations issued is bounded
by 4 -> we start from scale = 3, and by patch 6 of this series (and the loop
itself btw) it is guaranteed that the scale will be decremented, so the worst
case is that all scales are used, so at most 4 operations will be issued, so
we are safe.

So if my reasoning is correct, I think what we need is something like:

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index aa9efee17277..53591caf3793 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -427,21 +427,19 @@ do {									\
  #define __flush_s2_tlb_range_op(op, start, pages, stride, tlb_level) \
  	__flush_tlb_range_op(op, start, pages, stride, 0, tlb_level, false, kvm_lpa2_is_enabled());
  
-static inline bool __flush_tlb_range_limit_excess(unsigned long start,
-		unsigned long end, unsigned long pages, unsigned long stride)
+static inline bool __flush_tlb_range_limit_excess(unsigned long pages,
+						  unsigned long stride)
  {
  	/*
-	 * When the system does not support TLB range based flush
-	 * operation, (MAX_DVM_OPS - 1) pages can be handled. But
-	 * with TLB range based operation, MAX_TLBI_RANGE_PAGES
-	 * pages can be handled.
+	 * If a TLBI range op has pages under MAX_TLBI_RANGE_PAGES, it
+	 * is guaranteed that the loop in __flush_tlb_range_op shall
+	 * terminate in at most 4 iterations, so we do not need to
+	 * check with MAX_DVM_OPS in this case.
  	 */
-	if ((!system_supports_tlb_range() &&
-	     (end - start) >= (MAX_DVM_OPS * stride)) ||
-	    pages > MAX_TLBI_RANGE_PAGES)
-		return true;
+	if (system_supports_tlb_range())
+		return pages > MAX_TLBI_RANGE_PAGES;
  
-	return false;
+	return pages >= (MAX_DVM_OPS * stride) >> PAGE_SHIFT;
  }
  
  static inline void __flush_tlb_range_nosync(struct mm_struct *mm,


where the comment can be worded better.


>
>
>>   
>>   static inline void __flush_tlb_range_nosync(struct mm_struct *mm,
>> @@ -498,7 +490,7 @@ static inline void __flush_tlb_range_nosync(struct mm_struct *mm,
>>   	end = round_up(end, stride);
>>   	pages = (end - start) >> PAGE_SHIFT;
>>   
>> -	if (__flush_tlb_range_limit_excess(start, end, pages, stride)) {
>> +	if (__flush_tlb_range_limit_excess(pages, stride)) {
>>   		flush_tlb_mm(mm);
>>   		return;
>>   	}
>> @@ -547,7 +539,7 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
>>   	end = round_up(end, stride);
>>   	pages = (end - start) >> PAGE_SHIFT;
>>   
>> -	if (__flush_tlb_range_limit_excess(start, end, pages, stride)) {
>> +	if (__flush_tlb_range_limit_excess(pages, stride)) {
>>   		flush_tlb_all();
>>   		return;
>>   	}
>

