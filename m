Return-Path: <linux-kernel+bounces-741414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B5DB0E3C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F6D541A9C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1447283155;
	Tue, 22 Jul 2025 18:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pZRGQCME"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3136921516E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753210682; cv=fail; b=GlsZlYjpHNYBwCpxhXMA3JxnCkl6UJTeDFWZz8aHFu7T2x4sIjoC6UCIIlbxk4Svs94DmQRjMUpWzmwGQN2TXZ3VQuWd6xGDPrk/tvfSxeTICXGivxQXHvQVy7hqCIjhD0HUVt9y4z4D02Idvu2TkLf/HIqKdda8G6AmMBV0Bo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753210682; c=relaxed/simple;
	bh=tMkCxpX+24DDS3zrpRzznarYv9um+U34eSbXnPCGsgg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JNoGAJ5zAXrFZ5iqxgEsUHp4S9aLhNEy2CUzyUwH0teVhYJVn+G3LmHe+oZ0Z6f7hbORxrJbiiIWCH/lDku1f+/OOKG0pvQSqYldgi2t/QwSZGhmCvTy0WxINpx2J6kD7mtQlr2o8ExodrySPuDMqhetSnRpGG0L2tJT9k7bRM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pZRGQCME; arc=fail smtp.client-ip=40.107.101.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFK0M1L0u0xJE90WYJC4GlpzA/EDNUpjV15ivsbUGqKLkJvEDJ4OGjwsOUkTQS1bKVX6HpW2UvhJ9GM1+gkpMNqRB9JVXT1/CUJGyGIMXKr2/CTKpny99yQCMLSaJpn+FNR+vxOkBSzEey4Q7dRLm8z/Pq8k34ZDeCd4IKovxh0aYT4wnBpVRFLD0GwM1JixDdB9sje6qhDWSJmTaiBmi4tiT/lflwE5uyXyHP0ejThQRjonoKrNE3lC/stBRVKcdA+2678SFTdvihEdgsLPhmMZYcmCBnRyi0Ttei6+B5QDylFQK+MVIUwtdxqCKKJxK3BTDrbVOG/3N1DEZGXkjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMB9IY3mwmGZC9soiR7WkzmBpz193wmFApe9Qp44leY=;
 b=U/wNGzd5nsfzrM+m5I9feAOL+dHi4+ZlYIJVzXdi7bepvvfN1aWbR9hTldfdOH5JtLKcViqj8QfjWNs7zhH+7jynKuLhkHLnleqNzcFjsUhoNsutr68Fy2wRti5D2p0ORFmW37g6pv0Ztl3Cs3czAtLxsts3GAWM/Ao/YM/gIDDDjy2ujmIkiY6J2V4XsCYmDrMS4kSYjLFohieAngi9yCkYfC+WUibW8Pivhs+EfHEimmx+ls1kCpk//iGpvrf2nV/1QDEZTCSHSQFu/yqgLEpXoDrnyPr6T5v9LWx7eIkdATBsiBsYeaIPzUl0UAg3P4S19GCWsZRguBYVF/7myA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMB9IY3mwmGZC9soiR7WkzmBpz193wmFApe9Qp44leY=;
 b=pZRGQCMEw5IWgFKXUjQYpnVqjfey7DsUoqXpd03779XlkvfM/IL0Q7PgCqZu/orpMtZCYr2L4bne+27PZ//S40bUvh7Nn/UajZRfarq/Olpli78R4eFGKMNDkmiK7ZvcR/+lxJ/7MLJOb10KeLHZeeMyV6BDehq/L/aaJsbScDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 18:57:57 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%6]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 18:57:57 +0000
Message-ID: <f48edacc-7159-e5fb-03a4-1b1d6c68a971@amd.com>
Date: Tue, 22 Jul 2025 13:57:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] x86/sev: Improve handling of writes to intercepted TSC
 MSRs
Content-Language: en-US
To: Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
 bp@alien8.de, x86@kernel.org
Cc: seanjc@google.com, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, santosh.shukla@amd.com
References: <20250722074853.22253-1-nikunj@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250722074853.22253-1-nikunj@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0100.namprd05.prod.outlook.com
 (2603:10b6:803:42::17) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|MN2PR12MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: bbb5d594-232e-4608-6bb0-08ddc951abae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVNRdlgvMEJqM1JRRlVHdDNGSEI0LzFPWmoyTkQySkVsRVQrM3plQmo0dFJy?=
 =?utf-8?B?U3Fub1o5UWtGQU9BME5heWU2ajFtaTg1SUpNT1lkK0E1NXE4eW9YU2hmM0NY?=
 =?utf-8?B?QkxlbysycmRVY3Flc0k2Z2hSWWs5VzRQVUtiMWVMSkREL0F6NnFTOFBTRTNQ?=
 =?utf-8?B?WTdtTUx1dWYvMENCbTRQUUM1d3JUUmJCMnMwT1ZoKzBMSjRwOWFVSjhQY09V?=
 =?utf-8?B?ajJiMU5SZzJTbCtJaFJjQ1IrUDB4b0lsRzRMNTJ4QjJlMHd1QXdSOGYzdWJx?=
 =?utf-8?B?UHRhZXdPcVZqQTJqUHpNMFF6NVVTNWRoaE1DOWZNYzJpa3o1MmdjdFlCeEx1?=
 =?utf-8?B?REZjSU93ZDdlNWx0OUtDWURzWVdEL3d3N1Jpek9VKys3UTZ6LysyNTlGUks0?=
 =?utf-8?B?TTFMVzVla0FEODRGZTdoblpDM1VOd09nT0Y4STlpYnRiTDUrZW9SVzh5TFRo?=
 =?utf-8?B?Sy9RREZ4NC9CbjZhMUhwMnhzaXVKQ2lqeHdnZlpTME85ZkJJUzVMOFA4dU1P?=
 =?utf-8?B?U3BpVm1VbGRkYlVOMUNzazJBemhpbCtpblhZVE0zc1NSaFpoYWtGaEgyazhs?=
 =?utf-8?B?blM5dm5hczhmdFQ5b1lkR3hNWnJjOWtJa2cwcUlsUW92alRJWjNhdERVQWpn?=
 =?utf-8?B?NnpTNUVtOE05L0ZZZ2R6SkE1cnlUdkVWWTdwQWlnejRqZ210Y2prR3pobzdJ?=
 =?utf-8?B?OUl5VEw2Z0F6OUFXVDQ4RmNxSkFLdHhTWjgwcWs1RXlkUTVpcS9vdVpmVEVE?=
 =?utf-8?B?dkJtNjRadC9UVHBiZUJGTmNpOG5pU0dsSkFRUjF2bGNVdE1ucGNQY1NLSkFh?=
 =?utf-8?B?aXFhNjRHZ2xYbjF2aXlOYVU0elUzc0kxbm5KNHNSUkFGSS9ITk80TXhNcTlE?=
 =?utf-8?B?QUQvZ2h2NXZYUzcvamlGaXl0ZlJ3dk5ISDhZTTR1a3A4bnJpTkFpclVyWHBn?=
 =?utf-8?B?WGViZWN0N0xBako5WXEreXlBeVlGTkN2S29pOHFBMlVoZmJ6VGc3eFR1MWpm?=
 =?utf-8?B?S0xjZzFBUWIzY21vdFBKKzdkMnd0Z0tSNkdUaUpUYkNnOG9Pbmh0MU05RXdZ?=
 =?utf-8?B?Y0lWcUg0M1hIVzduSGNNYTRVd1BZWkhERlhwRDF6ajgrYVdsbDh5YytaaWpn?=
 =?utf-8?B?RWk3RVB1cklpdWtRRHdtaUg3MXVadTNhbnpMRlRmZ3NzYUkzS1YzVGEzZEZp?=
 =?utf-8?B?bFhneUhpYUxrL1NSZDVwejBxNUFWYlRsVUxLZWJpTGJTVEo0SlJ4Q3ZjTDVT?=
 =?utf-8?B?ZGo4dEh0cU9pTDJtWnBqRlVOYWhaQ0h0SE11V1pDQTRvaUo0cFYwQ0JUeWZY?=
 =?utf-8?B?eE5jL0pFdjF6Rm9iZVk2bWVCdW5yZkdabTZ4bjd6ckgzaVVielFQVVg1UlpN?=
 =?utf-8?B?YUhiUitOM1p1cGNvVkpJNkhCWkFUZThPYTQyUC83dmQwUjJLeHFGTHZ3OExv?=
 =?utf-8?B?OTMzZHBFQ1RZZ1dHUmRKRWVUMm5hNERlU3ZWR0NzSUZwSXVqMFdFY0R3OElC?=
 =?utf-8?B?cnZyWnZ2ckJhRVplQ01NZS84VDZwZkhrejJjVmcvWTFLVkl5c0c5Ty8zaXU3?=
 =?utf-8?B?ZURDMk94b3RMWGRmVTVXRm1wN2lncWJuYkpadjZhNjRwNVRsVUY1VS9MT2tU?=
 =?utf-8?B?OURSUlFGc1ZScnJmelRkWWhwY2pBMy80VzRhMzBjSTRPeUErWHFZMEl6ZUph?=
 =?utf-8?B?YnRNOFYxWmJ6MmtkMVIzWXFuTGtiTG1xcTRGVjg5VXBZdFZvUGJMUk1aTXZo?=
 =?utf-8?B?cTFMVHdJZXBvUWRNcVFsQTlDcXdlVjBRNGViL2NHR0pnNm1aTkpiWFhxek9Q?=
 =?utf-8?B?Y2lCdEw3YjhZenRmNzhqcmxycUhTRW5sWHYrZFlGL2NIakZRMUlqNFVOV0py?=
 =?utf-8?B?S0pRVW1ETDdCbm1YQkxPUWJZOTQraHR1dCs0LzVTajFLcHVDc0Y2a1RiSHNG?=
 =?utf-8?Q?PjiX/6NOMGM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTF6OENwQi91VzVPbDQycFl3dTg2eUFOSVNPWFg0UGlwVnMwRkVPZFU0WWtl?=
 =?utf-8?B?UU5MZmFBbVZYYnFsWS9NNzRFd1VCWkFBV2VxeGliSi94SnVpcjBRTk9MUG5K?=
 =?utf-8?B?dmlRQ1lvSU8yZnl2Y3NyMENTVEQ3ay9maFZIODFjRDgwWFdkczZKbHk5dnIz?=
 =?utf-8?B?Z2RlRkVzU0F4Zm5mTVFuUXd4cEhBNk9vZkhNZWxTbDlxRHFwU2FXWnRIcllT?=
 =?utf-8?B?ZjlsaVdtaXBIU24rcGd5VEZFaUZpbHBGMndBZEI4ejh4UStUUnN5dGE0Y1Ro?=
 =?utf-8?B?azM1V3hkTkQ2ejZJNkRjSnY2OUlNb2VzVkFLK2xtWlZWbzRKU2h2bzhmQllB?=
 =?utf-8?B?L3M4c2EyRUpiVHFlaUlrZ3YvOEo4QTRuU2tvZTM1RVpydmo4V0gwZU9ZZ3pY?=
 =?utf-8?B?V0N1cXpOSlp3aHlQcjZsTHRUVzlPMHpNSTczdnVuSmN4eDFjbHRvZWIrT0VZ?=
 =?utf-8?B?dHRLbXR1MkMyOFdwd3JXUEJZTnpIcEdvSWhteE9HZ2V4ZGI1bDZmdXI1Q0hF?=
 =?utf-8?B?QlBzaWNmMXBCYVFBTjFrWVlheG1aYVpJZVVNV2tDWDVVc0xob25ZZ0l1WmpV?=
 =?utf-8?B?UEhobHpzYVNONW53aEdLRE1aVjdsdURJY092YkFkR1RZSFBjT25UMlk3alM4?=
 =?utf-8?B?dDFUZjBKWFRSTWFyakxNdUx5S0ZpeExxejJoVGM4UXRCamFjejhvNDRERUw5?=
 =?utf-8?B?MlJJeHN1aGR3Zll0eUVtSkdJQ1ZwY1ZMYldEcE1JT0RnYmFEZUhGcUYxem9l?=
 =?utf-8?B?QXY0UkdtcWV1Q2xxcDk3b0pLUzZGTlhHcCt3TS9TeGZyMjB4S0o2ajl1SmJy?=
 =?utf-8?B?Yjd3czdNSFhxbUprZEFhSnNXbmRkeDNUdzhReU1zRU9mNlFMSnIzZmtQU3NR?=
 =?utf-8?B?T0FNMXp6NHNlUGxWT1haOWlNd1REVjJGcFZLRTduQmRYQzJZWElMWWllcUVk?=
 =?utf-8?B?NktHSWZlVEd3bk1xWnlDT0pLSnZrbVR1UDY2aVFzSHJ5aE11VHMyZ0ZjbVNj?=
 =?utf-8?B?dmMya1ZSRUQ2UFpNaGxwSFVMQzllakxxNnRQdldjcWR4ZE53cU56VDJiTW1O?=
 =?utf-8?B?N1Y5UVljcG0rTklUV2R4dzdZaVFHb0pxY041dW5oamNGbWFZSEtnME5Fbmp5?=
 =?utf-8?B?WFd1SmJ0OVY0RXkxdHlYZldESjNCdlpRQXQ3K0RwZkVwYmp4UnBWWWpmWXB0?=
 =?utf-8?B?Rmx6T0x0N09mSnhZYnQzVXM0K0pGWTIvYyttTDV5bVk5U0laeWN6ZlpzVnow?=
 =?utf-8?B?V1NBNGpZRmdEZm1JRC84ZXphR080OVdicUk2dEkyR2UzTlAzNCtCM0lqUExv?=
 =?utf-8?B?VDEwcHQ3N3NpTjNqUnJYMHlodG0xMGlKQnFVZmFaOVFUUTZ3V3BUR09ybFBC?=
 =?utf-8?B?ZWUzNmUzNXRTTElDM25yUTBtaG5pM0VvTUZEMldIYzcxa2ZTZmNRZzlyMmFa?=
 =?utf-8?B?SDM4K24ybVA5N0doTkw4ZnZjc3IwYVorVzA3bUlOVzcwQ0RON0QwdHpFR2Jn?=
 =?utf-8?B?RURjY09EV0dOUHkyUzFacnhweWJWbmljdEVvTDlRcTNCZDBrTlpPemdBcFRG?=
 =?utf-8?B?ZnZ5WDAxVTRmRzhCUGVNclFxVjhjYkpnamNadllnaEtHR2xScXIrOS9UcHlo?=
 =?utf-8?B?R0JZNGI1UFN0NjRyUmt6czdxTTVDcE4vTmlmUTFtK28yZkZCdkRSdjNGNVV3?=
 =?utf-8?B?MUFZb1VDM3VxcEFvTUVVdUJXR0JEVzAwYTBzRVZ6djRFcDByZ0wyejBrMmJN?=
 =?utf-8?B?cWc5aExhMlNVazc2endHbzBSQ3JzZWpCNVkvbE1WKzk4dHpobVkwc0puU3Uy?=
 =?utf-8?B?YUhMTGhyRXNhdERJaEwxTG9SdmVDZVlncnNQZUVkeENvL1lPSzFjT0NReEhI?=
 =?utf-8?B?dTg0UHdpa0pCZ25mSmJiVXpCbndZTDJuM0JOak5zWC96eGZxYVNZNjRRQnYy?=
 =?utf-8?B?RDYvLzhyNGliaVVJcVZiaDNUQ1k2OW9GMWh3czgrOTRYcElvS2w4Vi9MUGNF?=
 =?utf-8?B?Z3ZJQ3BsdUNBOFVlQ0NhNVJmNElMWTF5c05IR3krendEL0tyMEVwTkx2NjJx?=
 =?utf-8?B?a0t3WFF0b0lvSkd6bnBzLzNkMkxuWWphanZ3dk8vMC9QUVEzZ0RJV3pwSEl6?=
 =?utf-8?Q?QwkxDxitobrI5n9zIRPiusoWo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb5d594-232e-4608-6bb0-08ddc951abae
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 18:57:56.8956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLet3gvRUlgJwcpP4ygJEPq/YGcb4kzy9BVhKHJg7uZRMa+VoLzIJy0Bfvt03rUsN7i5t+aaDYj16iOKRQ1p0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454

On 7/22/25 02:48, Nikunj A Dadhania wrote:
> Currently, when a Secure TSC enabled SNP guest attempts to write to the
> intercepted GUEST_TSC_FREQ MSR (a read-only MSR), the guest kernel response
> incorrectly implies a VMM configuration error, when in fact it is the usual
> VMM configuration to intercept writes to read-only MSRs, unless explicitly
> documented.
> 
> Modify the intercepted TSC MSR #VC handling:
> * Write to GUEST_TSC_FREQ will generate a #GP instead of terminating the
>   guest
> * Write to MSR_IA32_TSC will generate a #GP instead of silently ignoring it
> 
> However, continue to terminate the guest when reading from intercepted
> GUEST_TSC_FREQ MSR with Secure TSC enabled, as intercepted reads indicate
> an improper VMM configuration for Secure TSC enabled SNP guests.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
> 
> v3:
> * Drop pt_regs pointer as it is already part of the es_em_ctxt struct (Tom)
> * Added Sean's suggested-by instead of authored-by (Sean)
> * Removed WARN_ON_ONCE as kernel already warns via ex_handler_msr()
>   for bare wrmsrq() calls (Sean)
> 
>  arch/x86/coco/sev/vc-handle.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
> index faf1fce89ed4..6333eb6b23c2 100644
> --- a/arch/x86/coco/sev/vc-handle.c
> +++ b/arch/x86/coco/sev/vc-handle.c
> @@ -371,29 +371,30 @@ static enum es_result __vc_handle_msr_caa(struct pt_regs *regs, bool write)
>   * executing with Secure TSC enabled, so special handling is required for
>   * accesses of MSR_IA32_TSC and MSR_AMD64_GUEST_TSC_FREQ.
>   */
> -static enum es_result __vc_handle_secure_tsc_msrs(struct pt_regs *regs, bool write)
> +static enum es_result __vc_handle_secure_tsc_msrs(struct es_em_ctxt *ctxt, bool write)
>  {
> +	struct pt_regs *regs = ctxt->regs;
>  	u64 tsc;
>  
>  	/*
> -	 * GUEST_TSC_FREQ should not be intercepted when Secure TSC is enabled.
> -	 * Terminate the SNP guest when the interception is enabled.
> +	 * Writing to MSR_IA32_TSC can cause subsequent reads of the TSC to
> +	 * return undefined values, and GUEST_TSC_FREQ is read-only. Generate
> +	 * a #GP on all writes.
>  	 */
> -	if (regs->cx == MSR_AMD64_GUEST_TSC_FREQ)
> -		return ES_VMM_ERROR;
> +	if (write) {
> +		ctxt->fi.vector = X86_TRAP_GP;
> +		ctxt->fi.error_code = 0;
> +		return ES_EXCEPTION;
> +	}
>  
>  	/*
> -	 * Writes: Writing to MSR_IA32_TSC can cause subsequent reads of the TSC
> -	 *         to return undefined values, so ignore all writes.
> -	 *
> -	 * Reads: Reads of MSR_IA32_TSC should return the current TSC value, use
> -	 *        the value returned by rdtsc_ordered().
> +	 * GUEST_TSC_FREQ read should not be intercepted when Secure TSC is
> +	 * enabled. Terminate the SNP guest when the interception is enabled.
>  	 */
> -	if (write) {
> -		WARN_ONCE(1, "TSC MSR writes are verboten!\n");
> -		return ES_OK;
> -	}
> +	if (regs->cx == MSR_AMD64_GUEST_TSC_FREQ)
> +		return ES_VMM_ERROR;
>  
> +	/* Reads of MSR_IA32_TSC should return the current TSC value. */
>  	tsc = rdtsc_ordered();
>  	regs->ax = lower_32_bits(tsc);
>  	regs->dx = upper_32_bits(tsc);
> @@ -416,7 +417,7 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
>  	case MSR_IA32_TSC:
>  	case MSR_AMD64_GUEST_TSC_FREQ:
>  		if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
> -			return __vc_handle_secure_tsc_msrs(regs, write);
> +			return __vc_handle_secure_tsc_msrs(ctxt, write);
>  		break;
>  	default:
>  		break;
> 
> base-commit: 34481698fd9c3c21425ab744e9e15dc2ce3b1b85

