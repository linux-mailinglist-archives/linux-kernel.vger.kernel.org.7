Return-Path: <linux-kernel+bounces-830365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF6AB997BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E481B23885
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F102E1730;
	Wed, 24 Sep 2025 10:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="mio8iL/g"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021134.outbound.protection.outlook.com [52.101.65.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC2E2D97AC;
	Wed, 24 Sep 2025 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710929; cv=fail; b=BMAbUw/BEALvEy3kGALtYSqJwymiZRtzdWuoPkFT+JRQFRKaenOSHYwxaz0LY8cznOoCodiEt033Fglwsi9Q6SetR1be7X+ccIWB1Xi54K8rFnaYbNWqmg0G6cYo864HM2TH1XJufeZ+S5KO74mAHW696ePZWR7sSrqdS0TEliw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710929; c=relaxed/simple;
	bh=SuzvwcdObUcg9ZEnHWNnuzZmdnLzs3qPPMecapwz3qw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YLz7AryzToWRoRrVhWQ/3JKak+0YS4fPK6ZVMej08EgA3vY3vlka4Ju9GSJg/Om8Yn2rKXnN5Y7wZrhKcanfwxnyyO4cd1ip0Qtr1jM6ROcM7I69jRN5iKaRZqhESUE4I1QtH3uph5iizFqlIKdA8DePfAvdH8qBD219Q865ZwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=mio8iL/g; arc=fail smtp.client-ip=52.101.65.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpX2myCZFZTOQA3cmsNstAi0O3ZIi71bX34RRzj3nywsiIwtb6SUOOUquTDeCqTAVJb4BBPoSzJVpxaqH9LlnntlYJaAwjK+FNtyhDZlJ3oxT5Y5FOjQ6XKM1hXba3kh0kpM6h33e6m9m8WI1NSUIgU0rrwcP7RG84Lk3n3pGHmhL8S1i1xAK8CPxwuo4kp6P60oXO+WsvAAnZUQ4+4DiWy9g4oIllMFrrZ+UX3N6QO1gJvE6+sRoMSxEMtLB+wEzaBGB9c0Ak+CCxxuhYn/NIag0+24kGULImkYFbiCJC8P+gdgYs67PlOusRRGENnnlVwN3158kOL/nEqr9s2MUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuzvwcdObUcg9ZEnHWNnuzZmdnLzs3qPPMecapwz3qw=;
 b=axJellVgGvWtC8V0pr3LVwGgOZYbRfOI2G19EUbSQ5N+beeanboLBz85GLctRK5+JNVv8RhGOqvyFYB9EVnTOKOMHdW7c0AtZfdVFuLQHheNDe4d5LCXmTX3ypPUSf2Ex/4A97kSsdoC2WhVDXaOczvJAd52KGsYo1Yjj54IBPm1TqDDWFTUNBql5XTH02689o5B0fbUIszUVhwKH8rq1SDBjnhJ7OEinVL2sxfeFRCgSrOvK2csqE/VtHPtGT9bg80GCItQ6iwyAEAUr4T8uRM4UBxNp+NanCUQfRCaiH8TTttNiLWrZSHddVzDccCltAE4x62p41nEeygkC/vAqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuzvwcdObUcg9ZEnHWNnuzZmdnLzs3qPPMecapwz3qw=;
 b=mio8iL/gRJJODHNUN4j/5m6fSAjPPjV3mbNlGWLvutInLg3Ccjm5MAaur1XbUySRuZeSD98w6KvllSarFiG4Csp5pTka62urP5r0Z6YaOGTHPzfyo6MnKiY8+c1v7Ffnuh77KZXfq5abqW0x5Mj1/xR2J+3hURWfuEHrdsnIyf9St4oupnLA0AkQtO8w/6+oeYbqbXGMDgj8Pt0a8FrtO2EUcXyysx23LWOSrnonTXaXcBPghThfwbrwEWWZRPyLtwvFxt7I3m5tQtJGil+7v5/1ur6dUdgGwrq+fSkJVEdkqS+HZ3IHsVXRoNymn53HKRlZfyJTd+G6jdRPxhw6GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10010.eurprd08.prod.outlook.com (2603:10a6:20b:64a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 10:48:38 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 10:48:38 +0000
Message-ID: <e3d24f62-0f3d-4065-97c1-99bad92924ff@iopsys.eu>
Date: Wed, 24 Sep 2025 13:48:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] clk: en7523: Add reset-controller support for
 EN7523 SoC
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Felix Fietkau <nbd@nbd.name>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20250924060509.1889131-1-mikhail.kshevetskiy@iopsys.eu>
 <20250924094112.1918444-1-mikhail.kshevetskiy@iopsys.eu>
 <20250924094112.1918444-3-mikhail.kshevetskiy@iopsys.eu>
 <76a5e9ee-b8b3-4f7f-9410-9133263358bf@collabora.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <76a5e9ee-b8b3-4f7f-9410-9133263358bf@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0032.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::33) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10010:EE_
X-MS-Office365-Filtering-Correlation-Id: 62134a4a-f380-497b-f2ff-08ddfb57eb26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3cyeXVMQndpZTA5REY5SHBGTUlJUkNwNWdwZnc2RmRLL2VETUtNNU1jdGpM?=
 =?utf-8?B?b3MzSGgxMmd2MFd6UU5YUUViMTBxT1FWSjdRcVQwTzM3bHJiaC9JTmRONGFR?=
 =?utf-8?B?dlNqT1MrVWFaOTVxK0J4MEpnQmxnSkhkOGwvVG1jNm94Ulp6NkE4UWtSYVMr?=
 =?utf-8?B?VTcvckxCZUxPYmQyOGpnZTRDQTQ1ZnhpNXl1ZmoxOUlsTVJWdFVKWUVrZmNw?=
 =?utf-8?B?ODM2K2kzUE0wQTZJV1JrRHYrM2xaV0JIdnZMcEQxNDhxaGdrRUQ0OVJQRFJF?=
 =?utf-8?B?RDVYNFlkdEFjV3orN1RHejRlMThPb0lyQWdzUTRyV0ZCN0tmWkdsOGlwem54?=
 =?utf-8?B?TjQ5dWYzR3BmSWtacFNaVG5zWUU2Vm9rL2N5T0hNTFdvbWl0L3BsWXZIVGxz?=
 =?utf-8?B?QjZWcm1raXBUcXozcTcyaDJLa05pS2Z3M29WZFZrYmtRdzlTUkZoa2lvMWor?=
 =?utf-8?B?VzZIenJnaXRKRHdNd0ZWQjVjKzMzaUVNeWpHM0IrWElWNUlRSVJmNWI5ZmdC?=
 =?utf-8?B?Q3ZRZ3RLSDRja2o4RXRSS0lGb2Vxb1dKNkU0bERkTVpQQ0ZjbG5XbnZnYVNp?=
 =?utf-8?B?T252VUdhMXcreklZYytXdEdQd3YrNWsrWTVMR1M4SDlPSFNROUtuRjBHQUVK?=
 =?utf-8?B?QUxUWUFvejFORk11MGZ2d0JSSHhMTVV5OXFCVndndm5GRUcyVXdCRmNGZDdG?=
 =?utf-8?B?N0QvU2VGcGZYc0VUakc3SFNzYUtyb1VFY3RlNDlhdE9aZlg3djdyUnVzQkha?=
 =?utf-8?B?UjI1UU9aTm5JMkE3aUZLT2xhU2hYNmhxcU1EMytOQ3BVbVdjaDVvZDQ2Nko4?=
 =?utf-8?B?TVJGRFAwaTNtRHhRTzlxL01tTHkwZ2NoUXN6US9kM3pOQTFiYVZLVU54d09t?=
 =?utf-8?B?eTRVSTFheTAwUzVkUXhuSFNFdklIWXpLMGZnTUR2QmRkRW12aG5HMHdIaGRx?=
 =?utf-8?B?S0poMHVDZE9BS1h6TGU1SUhndW5IdXAzSDZTZ1JKSVJzQTRnYmNVblAySTgx?=
 =?utf-8?B?Y2lvcElvZkt5emNoUHZ6aUFaVDUvbjhkcU5nUndnQXU1ZXJraUpPUmVtenlY?=
 =?utf-8?B?aWEzNVNaOEpUNVk3d3JYTG9kZmtLTGFDWkMrM1A2WFNIQno5N1ZSekhsZmtJ?=
 =?utf-8?B?WWtXdllwTmJNeWpzdDZDZFhxU3gxRUNiZ09jVGFCdktlRDlKODloby9JNjFV?=
 =?utf-8?B?Y090OStsSVhGOWFOZjByYmZ2WXd3ckhycmI0OHkveEV3NE9hQUgwRHFGZWVm?=
 =?utf-8?B?UWVldHAyWWFtSlAzOGVqajZDV2dzSzFLaldBek1IRUVMZHJMRStERC90RnFI?=
 =?utf-8?B?Ym1PRWtUbk41MUtrL3VxUjAvTHdsYTMva0JvS253VHlET2xlUlB2a3JaazBC?=
 =?utf-8?B?aGhyZFBhejd5ZXZBR2JmRDg4OGF3b2Q2S1hYcWVnVldkcTNTK1B4NjNEdFBv?=
 =?utf-8?B?NEsxT0orSCtlZi9lbHF6S20xWGJjRWRYRVZKTkNkcjRFWXNoN2VRaXZNelRK?=
 =?utf-8?B?Z2oybEtNR3lQUHQ5UkQ2VTJVT2FHYWxhUUJEMmVZVk5OY2FveEgvOUh1QjBX?=
 =?utf-8?B?a0tSTlJhWEpwc0JUV1hwVi9kL1RpNFhJWWNaQ2xMb0I1aEV1NSsxbTQvMXl0?=
 =?utf-8?B?MWloN3FCT1hVNUZTNjdSR2hhcHdzMVZucDZQZkNsUk5hTm5vZUwxdTgxb1lz?=
 =?utf-8?B?akx4Tm45ZndDdkR4Qk16Zys2ODFVWWh5MjN5SnlXeE8rS3NWUkx1NXJ1angy?=
 =?utf-8?B?Znc1NHh4WW1VMFhNVTNSUGxaNXJQM2g5RVFHclpHemIzSmx6WndHZ0VwcEhh?=
 =?utf-8?B?cC9JL1Q3NTZqczFhVEhzTmY1eE1TazluZ0Q1UXdpcStrQTBySkJZbG9Ma2pH?=
 =?utf-8?B?S0t0WEZNSkZ2Z3ppNENSK1AxdTFtQng4Y3NMOXY2c2lpdW9kSXVpSDdwR1Va?=
 =?utf-8?B?UGk3NjJubEIrU29CNXdlY0dpM2pFK2E3WmxydCtmbEpYVTRiRVVqU3hwK3VZ?=
 =?utf-8?B?VTNvbjhubzlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3l2ZTQ3RnBha1RVWnp1NU9sazBIOW4yazE5bk04elBzbWhGREE5ZUdsSEl0?=
 =?utf-8?B?OCtKTTZkN0pBNktLNWtNWXQ2cXRlZnpsTzFSQUxMNFdxYXIrUGZyM2t1Vmdn?=
 =?utf-8?B?WVp0QjBBaG5RUVliSzFxM1hUVEhrYXNuYWZxWmhHZ2NIWGFGOUliRlAybWdh?=
 =?utf-8?B?M2wwS1VrOXBRaWtHU0lMSGVYVXcwaW05Vk5GWXFNNXBOS0NocEtNemRBaHZa?=
 =?utf-8?B?OGV2WTJ6azJ3MnFjbHFUWWdUZHY0L1Q0OUF1aFNlRGxaVXJuMFUxQWNQZmt3?=
 =?utf-8?B?dFhwNWM5czJLNDkwaU8rNmNyZndYV1J6b1ZxY1d1NWNRb2hqbnJMSG9wMkt4?=
 =?utf-8?B?Z0lqOUJ1b2cxM29vamRpK3E4MFhKMFUwSERjcXVtN0xNc1E2bTNPTDB5Sm5Y?=
 =?utf-8?B?aWlaVUhmbmpZa2d4OVZqV1Jzd2pmSzZSQ2pWeWlodmN3TGtUWlRScHpsR25r?=
 =?utf-8?B?SGpqUE5IQU1LOTJML0NnWFljVmZQMXBRTDJvNEQ5c0tpSHZtcFhiRjg1TjZD?=
 =?utf-8?B?dGhjc2UvS1YzejlUWTRnRlU3U2pYNmFEZ2dZNG9EUWNiWGV5Vk5UeElYL0Q5?=
 =?utf-8?B?RWFLRWNZdmgyM1ZWdDdGVUphUWIya0Y3WEoyRldjeHlPdjYvcGJpeGxyYVZB?=
 =?utf-8?B?UVNOUjJDZ1Z6M2YrakM0RWgyNE8rN3hGODAwVk1OQ1FVU3VLNWhLMFBwSnNC?=
 =?utf-8?B?T3hmM01BK2lyM1h3SnkyMTJ4WUVaVFpCWEVjbjJDWHg0SXozWUhvVFoydkp5?=
 =?utf-8?B?MzJDYmNwc0xBTGVGREFoQS9LVm9iNENEQXd6eWI1eW5lL0s0ZmNablB1UFFj?=
 =?utf-8?B?cWtDWVliWWxkQUprdWE0WXFEYXFMeUdRT0tORWF2Q2R4TXdmRlZvNnhvcEtD?=
 =?utf-8?B?eVcyc1dnTVVBaDF4QnVNMHB6VVVVaC9SSWN3OU9iU21iTi9URi9Qek1GR0o3?=
 =?utf-8?B?Z1dhWUNSdjkvSldkMjQ1OStoMjlwUlZxYjZVamxOdjQrZGVhckhaVmFWaitH?=
 =?utf-8?B?cVZaY2ZPUnhyelRra2RHOW1Pd3RmY0hMWlJFSGhkZUc5L3BIU1FEREZ2cjF5?=
 =?utf-8?B?VEN2U2RRamgwY0NjRldJU2czalVEVmg5akFTNmZXbFdpQXRBOWdGOEZQTUdH?=
 =?utf-8?B?a3pZNzhETkFwY2V6RUtDMUJrZkF6aHVVSUlrSjE1NDJRU0tMalY4UEZkL2Nw?=
 =?utf-8?B?VGp0Mk54UTg5NEk0VXFYR0RRRW9HTWwxSUowQisxMmNIVXZURG9xM25LWW5n?=
 =?utf-8?B?VTYvSFpFYzJIRlFFK2FWS0Vud3FjWkRKOXg2emZsQ2hrb25oTklSaXN3eVlu?=
 =?utf-8?B?V3k5WFN1dGR5YlJTMitSK0hJNE1mcnliYnEwS1JlREFLWWVxSVIyVjBZR294?=
 =?utf-8?B?OG9LL1hEZld0UHEyN2kyQmd5YlN0eU1zTG1QR1BuNTlKaWNMRGh0QTR5aEtw?=
 =?utf-8?B?cVpzdXFCWE95SFAzY1ROSlIzVTBOZzNMM3BRc0ZmdCtjcmJuTURBUE5sMFJP?=
 =?utf-8?B?V1Zzbyt4N1NTbGJ0Rm04SmxjanpjdFFUdVNBRjZERCtEVmdFeDBKdGt4VlR2?=
 =?utf-8?B?ek5BeTFabVd3T3ZiWU4rQTd2RS9MdHJ0SENac1d3RjdjRzNhcDlFTlNXRU42?=
 =?utf-8?B?Z1NuMHlNeXZHRG1kTjZETTF2Y1huSkJYRllMVENPdFd5VENFR0lNMGhEWjRx?=
 =?utf-8?B?dldrN1lDMGZLRVhqQ0V5ZTZSUWFnSXNreXFwaktNSGhqdlRsWFpPWHlwYXor?=
 =?utf-8?B?SGVzaGFGV3Fia1V6OHJVUTIyQ2RvZ0hSZG0xSjFNZEFMdXdrUU1DNW1KUnRv?=
 =?utf-8?B?dEZNcUQzYXNwOExVVlEvWTdaTlZISWE0YlZuQUNveGt5UlBRNGJPV3F2cmY3?=
 =?utf-8?B?UWpnemdHdzVod0hiQUJDMjYwdDF6NnZUNm80K2FhVGpuOWpqVWJFUnB2c3By?=
 =?utf-8?B?dmFEdUF1akhCTmtWVFpFOWFLM1RmTEoyTzB6V2doQjZwZmxKaUt0WW45MnA0?=
 =?utf-8?B?dmY2OGNRUkF4c0h5dUN1aHFJN1lKYktuRFlvWWhvWkd5cjFKVnRMQ2twY2tK?=
 =?utf-8?B?WnFlbWxXclZtYnp0OGE1WEdsUEUyejBKRXRadi9EdnVjUk1YdGVvdnV6UlVW?=
 =?utf-8?B?MS8wSlFpelhnL1VwVktzNFFnemludEpFdVJqOVBpaHBBNWxMQkN4V1JMMmhW?=
 =?utf-8?Q?VOSGCjstX1y03N89qkGyIyI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 62134a4a-f380-497b-f2ff-08ddfb57eb26
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 10:48:38.5307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vDRgvHtpvaqmvBu83+d2IlFo1O0xeUYeSaeoMOR+xOET8jZcXcmoupI1k2kTfolc2v5grBuDXMdl1iN2Rs4gHHKrzHMJfnYM3fDa5G8wBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10010


On 24.09.2025 13:20, AngeloGioacchino Del Regno wrote:
> Il 24/09/25 11:41, Mikhail Kshevetskiy ha scritto:
>> Introduce reset API support to EN7523 clock driver. EN7523 uses the
>> same reset logic as EN7581, so just reuse existing code. The patch
>> renames:
>>   * en7581_rst_ofs to en75xx_rst_ofs,
>>   * en7581_reset_register() to en75xx_reset_register()
>> because they are not en7581 specific.
>
> You ignored all of my comments (sent at v1) on this patch.

sorry, I just miss it.


>
> Regards,
> Angelo
>
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---

