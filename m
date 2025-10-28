Return-Path: <linux-kernel+bounces-874116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E02C1592B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238F03BD30F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB09B3043D5;
	Tue, 28 Oct 2025 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="js4mrF7n"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C31F35B130
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665907; cv=fail; b=NRdjQc3erL+vJW9g/MAtBcCvi5u/f7+dDw2bUfPmSHGrk2uGkDwRtscxKwt+UPcLUMUCbPVC88x9NNTp7dI7YGvq0k5SPhteCsuF2+TrT8ZxaRbuinRla3nzDuDqopAGIb54ML5mEAluON83r6Q/ISk8waaq83Qx4Dy2uMg7hpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665907; c=relaxed/simple;
	bh=EJvC4LQ/w2WIxXBstgdgmsVck81noVIdsp7VryvRUZw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KA69bqTyFrqBKimhY7YrMAmS4yOfn3YJIm2mvs/Ct43XCFYSj8WMSZFWfCTJ4HpK6FXgHiRwGKdIc5WIB+WwIFkuuZMSSsirNfc1VnuRsEkHWmIU/iut9o4Fnaa9MmMFZQ9Lm3n/cFH7HXhlezB3hisC+CwPFjjFkMVQ+MFiSfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=js4mrF7n; arc=fail smtp.client-ip=52.101.62.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDKUzYdWg2NrM1mxNsG0f6JP4rgufx9sAidgCzQFI0CUQovrviChCp9uSGID9pv/Oon7cTdT3CDmGqIrInG1tZAz6XUy922b+OwS2G/1eKdG3EsrDc1AjKapHpU5xpOSPmkzNVCtHSh4FxnpryV20cvGvsJBnL2O1H8ioCfDI2hRjW19X0yToPq1sAFKevpOg9+RE72YzDiLJ8UWG77Kzb+6iR6jxxJNDwpu/ZISMmSBCqDrN7Hxoz8kWbZCqNB5NvI4yRep4gjrXavvZ14VWf/MzCsXhTpPpxGtTJ6S57i54YodwZee0DOAqelLdkJnUF6Eu6lwKgtnN5TapSFdag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLvPEqosDKrsTCmoDCDo32cYuLCjtbKuP1rKcTAn1Uo=;
 b=IomFBsPtuRqNNfEURQCHp89gituDgHmyzELpfWtIW3lgE2aE96GgW0YACY4S2G0rPNr6xBBXqjvG78ALpHwqZoZYyApbtTcNEww6so3guz/TVVpQqzX0jCyLuCPewFM5JxqBO1FfZ8tQw8Ki9daTCag7IS7dyR2FfOVgrmHNQacLXk9TnyjwMMo45vhEBdf62oAZZ02rWBPD+qofm9TwwKqgiRkaJGWB9Kn8u88LVkQDSAtR1IXvT1dGBml7sNVqjWivx1BNfMxbDl0vn1PQ2qWFPO6H/Y6UOhhh9jcKNXFusZ1HUuSMCrvNkKVeHsUGiPjzOb/U7cIaC6DibaLEOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLvPEqosDKrsTCmoDCDo32cYuLCjtbKuP1rKcTAn1Uo=;
 b=js4mrF7n2ruLz3mnJhb2uFVEKfd9hi/qmHay0cP8cQsNpGDfPBsPFX0MyQ4lCS+4U13invn/swp33LrykCX33TVcUw+ifsOkGTkBznXpYNHGgCfvywRDEh3CAyLjXgF8+jzwcRFWnZfEwbDPTiPMA/Kg2WQBGk8fZS5/RuTmgTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CH8PR12MB9814.namprd12.prod.outlook.com (2603:10b6:610:26b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 15:38:24 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 15:38:23 +0000
Message-ID: <ddd3e19b-2cfe-4528-b3e8-05034a34d858@amd.com>
Date: Tue, 28 Oct 2025 11:37:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: x86: Disable SSE4A
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Arisu Tachibana <arisu.tachibana@miraclelinux.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 Leyvi Rose <leyvirose@gmail.com>, Samuel Holland
 <samuel.holland@sifive.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 lkml <linux-kernel@vger.kernel.org>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>
References: <20251027114059.GJ3245006@noisy.programming.kicks-ass.net>
 <20251027124049.GAaP9oUaUtzzHUK4j4@fat_crate.local>
 <CANgtXuN-grBSdVfhtZ0xBk8pWyh6tUiMtAWOaPHBApQ3wrUy6w@mail.gmail.com>
 <5deb806b-4bd0-47c9-a8ba-868cd4c9dfd4@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <5deb806b-4bd0-47c9-a8ba-868cd4c9dfd4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:408:fb::28) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CH8PR12MB9814:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ad50c7-15eb-40b7-3ceb-08de16380789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmZCMXdRdWFKWUJ4QitQVEdWbVBxelE2RVl6MEJxRXlnVTVlZ3RMSDlSLzlE?=
 =?utf-8?B?Sk9GY1hFV0hXazR4ZHMwTzVpZ3h2bnVWRUVVVE5neEwyZHBDcGlpaktySUJn?=
 =?utf-8?B?Qks5MGVZS0dicmRNSUVpSWVXcUpTSk9DOC80bjAwRWQwTC9nMXF2RnJEbkpM?=
 =?utf-8?B?MkRJaVVRMHQ3U1JtUGhybEwzbzZlOHBOa0VoeWhoenllZmhvN0IrSjkrb2hq?=
 =?utf-8?B?S1dzSTVPb1RZUEwwNHZTTks5RTJ2dk14OVJYRWI3emtYcE9ua0J5Rk5BeGh1?=
 =?utf-8?B?elJPY1J2czBud3dJQnNJai9aVlM4UHVpTjRnSmlyTHdoUnc1ZXhveU42VFJ3?=
 =?utf-8?B?NWJLSU14dTNnaXNOUmtPalYwQ21HdDZRcWZvMER1WjVOdllDVXZleXpqWWVD?=
 =?utf-8?B?VVUzYmQvV0ZHMGhrUlY3TFpobEZ3dko3MnY2emFlaFp5anRiNzZ4SlhVK3Zn?=
 =?utf-8?B?Q3QyUitXc1lBbGl0cmt2YmVIY1NzdXZ5Ly9PWGllT09TbHBKdE5LQjZsS3J1?=
 =?utf-8?B?Z0wwd1Q2Wk9rUFlyOXVQWkYrYU5WSStpN2dYa29mOXZ6YnhqQ3lxTWU4MXRv?=
 =?utf-8?B?OG9CS29odkVtaHpVVjRWR3FZWk5acHRJWWptUzBQSloyR1BZRWt0N3BlRkgx?=
 =?utf-8?B?amkrYjViQmEvVTdDWjJKQWpoUEF0dU96OUllSnptT0NPcTZPOGJ2UEVadGR4?=
 =?utf-8?B?OTRlR05QVzlwL3ZhUm4wOFgzT1VxNnpDa2hhVXd6eFNiUk5qTEFVVW9UVzNl?=
 =?utf-8?B?V1lRV2xCblg4WFQzMEl3RldVcXpkQlNMcXRXNXZRaGdOcTJMVUp1clh1eG5L?=
 =?utf-8?B?ZmYwUWhTUi9NaWl1VFpGSE9ZandPT1RZTk9ITlZQQkpnYUtmZzJOejBFd2VT?=
 =?utf-8?B?UVNZdXA1T09oQ3VDcTlFVEJldzkxci8ya2JScUFINUhHN2NmTUMzNmlwTWM3?=
 =?utf-8?B?eUVDTFBLd21zOUZKREpVVlVCSythU1FPTUlxaVovNXZocDZpUkpjcWxkTlUw?=
 =?utf-8?B?MStsV3VsdlNiZUlWUlNhTWpLSWpQL3JUM0NkZmVqc3dVNzBjeFlrc3RBRElV?=
 =?utf-8?B?MkM2SzhuRnV2cmNEV1VtNnhmQjZvajF1d1ZuaE5MRlp5OWNjZE9UYVRSTFFi?=
 =?utf-8?B?Y1BpYkUwU2FNNjNKSFA0d2VyU0V4ZnNsRENMcjFOTHh5WXBjY0FNWXJBd2Fp?=
 =?utf-8?B?NkE0WUpoUldhcFM1dHdTZk5pKzZ4d3lvWnlmRGdJWngydlRRU0NJWFZMUDhz?=
 =?utf-8?B?Mm9tVlRnR2dGQTBJOThtbVVLSW9IaGF4U0VaTG9CbW1KemkzcDNmTlZ0Mk5u?=
 =?utf-8?B?RkZGdTNQUU5Ldk5WTFV0bmc5MUYra0VqVVJOdTErMnVSWEMyanB3NU1pOTB5?=
 =?utf-8?B?ZlRUbnhzMG00N0sxYkVDSXc5aytMeGpvMHlrYURlRmMzYkdqS2tzTWFVVjZR?=
 =?utf-8?B?ejdzSTRTdmhxVXh6MUhhblp0bml1d2tSYnpOLzJiY0ZoVUxybjlFd2pwekZ1?=
 =?utf-8?B?VlNOcmxNUlRDVHBzQ0FTeXRvcEdWZGZmV3pvcjU5N3ppOEllV2Yza1pSUmFn?=
 =?utf-8?B?VUEvcjYwREVYNEhtcTRRa2RZbmlCOHJXdVFHcDcvNW5HbHJKdTJ1Sk01OHJS?=
 =?utf-8?B?Zk9yWUd0a2FwM1lnZVJ6K3QxYVdkRmdoYnVQMVRNK3oyWGc5a2lEWlk3aDJE?=
 =?utf-8?B?SkZDVEYvY1pTcGFEQmFaNHZiTXRkV3p1YXZLdEIxdHdMNXQ3NFhNUEhVNFA1?=
 =?utf-8?B?c2FvVXN2cDNjUlkrSkhkaWhRUWs5SWFwNEk1Qm5xR2pkYWI3aWdLQTZWdWRs?=
 =?utf-8?B?MmRFUmVuRnZBT28xMFo1eEZhZ3p0SW9RTjk2SHBSQXhNdDFQZUZ4cGZ4R2li?=
 =?utf-8?B?a091Z0hnRE9IUytULzdGeW55U0psT1JNMnJYV1NLcklzeGd6M3JWTDRDRXgz?=
 =?utf-8?B?d3VHK3hTT2F4YTIrV1hPNmk5aVNoKy9QTmZqRnpYbjVMSlhKYkt0VFQ3U0FE?=
 =?utf-8?B?OXJBL0cxZVl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5427.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW5aTktEZWVYNFJGeVphM0VrRjlVM3d1TTM4cVlUL2l0NXNxMDlBZ21SMk56?=
 =?utf-8?B?TlBKSUN5OEpaeEVnMFlMaElVTHdXcGZjOStWeWJBOEFnaWRkY1UzQzBLVGJU?=
 =?utf-8?B?RDlyMVVqWXVub3hhWDRHTzZEUTlPQUE3R2dRL0lwR1ZZaWEwV3gwdlI1a1dH?=
 =?utf-8?B?YWhRa1lJbzl6QlliNkw2SW8vQXlmdExPOS9yZ3N2bjJneFo1T25IOUhJSzJr?=
 =?utf-8?B?MGd3Syt0T2Z0dFh4U3RoampVY0VBcDBDdWZodDdJM3RxampIS3FaWGw3RGJU?=
 =?utf-8?B?S0dmUWhQSEI4bTlmWmhUTThzVGlhY1BWZ0VuWFJ3ZklNcjdRcFJuT1ZsS3dQ?=
 =?utf-8?B?NW5uMkJ0Q0lLZHdOaEpWcUZGVHZVbmlxL0RKVTE3VTVvMHdIcUtlbjYzRWRx?=
 =?utf-8?B?bXBpODR4Y1ljSzc0TThtTE1YOW1mMzJsczNSUy9yWVNXS2JYcXFqejZBTlll?=
 =?utf-8?B?bGtMU3N4by95dGlWdzNDbVVGSkNPWUthU2FHeXpxc2twWm1uNDhtd1pzSG5O?=
 =?utf-8?B?V2Z1RTFiNXJOVEZWaGNhQmFURjh1UllyM3d4V0x1NVZtemZLNjdoaWNVWWhP?=
 =?utf-8?B?eDRVK1BGV0RZb0JzbnVJc2NKUTl2azFqSjR3djhnV09NeTIxMFptbTNKa1p1?=
 =?utf-8?B?Z2FseFpDa0Jpc1pWVTB4ckVLdisyMHNWSXhGT1VrcTF6NWcrbEZRMDVEK0dE?=
 =?utf-8?B?Qzh2bnRlN203eDhGSktoRlllOHY1R2FpMkxXRzhPWnRzRnJ6YzlJTVI2V2FZ?=
 =?utf-8?B?VjRvanM3c2c2SnJ6UEhqTlRvTGN2Y29GVm1aSklMemFEcEJ4ajZNd0prWUxP?=
 =?utf-8?B?L0FGMlEveHFrOU1JZW8rUDh3VWJrTERiNzFNSTJKWFJUazFheUdtcWxFSnNU?=
 =?utf-8?B?elgvMldWWG9HNzZrWDFkazdrMVlNaFNPSEl4ZFVtU3ptc3JlSmZWdGx0Mk1q?=
 =?utf-8?B?cXZCcVBzOFBrMEl2ZUxWU3kzVGorYlA4R1R1eVpST3pxa0tGbW9waDRRWkVB?=
 =?utf-8?B?Tm5FemVDc3hZRk5MSE9aZEFWbjdNOXlFZWtkQ2V5ZHZncmFURG1OamtnbmV3?=
 =?utf-8?B?MTVvY3lQT01MKzNjSWJ0cUlYU0plY2FUYXJ5SmRCWmJ0WWx3K2hSSzBkenEr?=
 =?utf-8?B?azQ1SVNMSDV6Kzd0TENJY2RXdll1elFCVlZqZnZYWG9QREJLaGxEb09OYmlT?=
 =?utf-8?B?cVltSm9kVjB0WXJ0emtGQnFYREo4U1p5SXBHRW9ITXA1VTRLWHRCNkpTTWs1?=
 =?utf-8?B?N20zeUVmbkgyWTh2c3pFTGpxNGplOGhsOXpLVGtKOGI1TEx1djRQUk9pNUFJ?=
 =?utf-8?B?Yk9rWFBZNGh1dnpRdk1YSWVEWHBSZHQ4S25PeGJ2MXVoVFB4N0NDdUxvajFV?=
 =?utf-8?B?OThiMjdKb2duQStESTRHdW54eWY5NjlnN1hTRWZLMVF6dTI5NzExL09nZ0Nt?=
 =?utf-8?B?WXNaMFVPcmF6bWlyNjQwWk1Tay96eFpVbmhwQzFBeENEdTVBUk1CRC8rUzBG?=
 =?utf-8?B?MEtWRzZ1RHcyb2RHemkrMWxIY1BnSHRhRmZwR3lLRkNGajBFOGpuMmtnL0xI?=
 =?utf-8?B?VXhvRTFrRDJraEhzbWlKc0JFcEdlM3RDVENaOUZJeEE5MFMzUEsrK3poeVZv?=
 =?utf-8?B?TGg2RXpLbnVuK1lQMXpYYTVDbzVPNGhwaWhIemxZTW8yUnpOL2M1azJSaXdi?=
 =?utf-8?B?VnlCdC9xdG5VU0tWYVJTdjU2Rm9rdFFiRDVnN21xRWVKRlVkZU1OKzNEUVdM?=
 =?utf-8?B?c29OaVF6UXJndkJtczNQeGgzNmJkdUE5UmUwK05IbUVzc2ZZVkFTNXNWUTB4?=
 =?utf-8?B?NVFMWDlIcEdmYVNBWUJHVDkwR0pKeTRHallMVWs1a1VVOGdiNXZCUVlJN1Rw?=
 =?utf-8?B?b0dhdE50L2VFN3NiNGJLZXlyMnVKbVUyZjBjY0wzNGRXWnNMeEtoVGhDUDMr?=
 =?utf-8?B?a2t4eGlKb0xjM2lBeHAvVXRDZFpXTFJsYlJFcUxvMVcydUpJQ1ExaFJlNE5p?=
 =?utf-8?B?ZjljSkFhRzBZVjV5L0hBZkNXSS9Ua2RQNzcreXlONkZ5SFJlYzF4T0hybFR1?=
 =?utf-8?B?WWxXU0c2cms2cWV4NWp1NmpBRTNFY1BiMTFkTjR6elllR2Rkc3IrTmkvdVFo?=
 =?utf-8?Q?9u31g/U7uTH9XvzLIWVd3Cepc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ad50c7-15eb-40b7-3ceb-08de16380789
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:38:23.6977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0bxTEv/ZRjn0Q1IOJK4vuQq0SZr6ch6HmEXmtHuHf2gg4g/r8hP3njtoakg2wNeykNYfuxLJ02DITdMZw/NNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9814



On 2025-10-28 04:32, Christian König wrote:
> Adding AMDs DC people (the component which enables FPU in amdgpu) on CC.
> 
> On 10/28/25 05:19, Arisu Tachibana wrote:
>> On Mon, Oct 27, 2025 at 9:41 PM Borislav Petkov <bp@alien8.de> wrote:
>>>
>>> On Mon, Oct 27, 2025 at 12:40:59PM +0100, Peter Zijlstra wrote:
>>>> Leyvi Rose reported that his X86_NATIVE_CPU=y build is failing because
>>>> our instruction decoder doesn't support SSE4A and the AMDGPU code seems
>>>> to be generating those with his compiler of choice (CLANG+LTO).
>>>>
>>>> Now, our normal build flags disable SSE MMX SSE2 3DNOW AVX, but then
>>>> CC_FLAGS_FPU re-enable SSE SSE2.
>>>>
>>>> Since nothing mentions SSE3 or SSE4, I'm assuming that -msse (or its
>>>> negative) control all SSE variants -- but why then explicitly enumerate
>>>> SSE2 ?
>>>>
>>>> Anyway, until the instruction decoder gets fixed, explicitly disallow
>>>> SSE4A (an AMD specific SSE4 extension).
>>>>
>>>> Fixes: ea1dcca1de12 ("x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU option to locally optimize the kernel with '-march=native'")
>>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>> ---
>>>>
>>>> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
>>>> index 4db7e4bf69f5..8fbff3106c56 100644
>>>> --- a/arch/x86/Makefile
>>>> +++ b/arch/x86/Makefile
>>>> @@ -75,7 +75,7 @@ export BITS
>>>>  #
>>>>  #    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53383
>>>>  #
>>>> -KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
>>>> +KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -mno-sse4a
>>>>  KBUILD_RUSTFLAGS += --target=$(objtree)/scripts/target.json
>>>>  KBUILD_RUSTFLAGS += -Ctarget-feature=-sse,-sse2,-sse3,-ssse3,-sse4.1,-sse4.2,-avx,-avx2
>>>
>>> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
>>>
>>
>>  Acked-by: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
> 
> Acked-by: Christian König <christian.koenig@amd.com>
> 

Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

>>
>>
>> --
>> thanks,
>> arisut
> 


