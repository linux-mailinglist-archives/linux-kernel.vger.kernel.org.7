Return-Path: <linux-kernel+bounces-777529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD23DB2DA8E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245DE163E52
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069C52E62A2;
	Wed, 20 Aug 2025 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="juyxlmRR"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2120.outbound.protection.outlook.com [40.107.100.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66012E3AE3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755687940; cv=fail; b=V1zm893x5jvlLqUAPUKQExXexst2TkjTpDY2gu8moSN+9G6xXov7bqIVl3kCX6uZxcKv+KETpxnh2gu0R8L4B4/GTxLvZYEe26DByVYFPfWV1Iyv6M2bH7cGmPs1mAQmrk7lGkrHCVyz0FZuoB6VcgaD/LtaELzka0P9c1aiFy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755687940; c=relaxed/simple;
	bh=O6uML7XBefmeKoHJqEXpdMQufDAqCFCdgrlRlG0KP/E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ubeRc7X3GnIN3+OMCOmoAttjGNAg/nYZ1L3n97093a6OCe+fITsUZkFOGeCJhDYFGJgRqln1mmembjVoH01FxlXPZZvRLbu7QOvbzU3uD9tK8ABwfA3+Md0HgqGiKq2DBUyq+GfHHo/hnDauK05Z3p0OlDoeuQLMR88Fs3DhprQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=juyxlmRR; arc=fail smtp.client-ip=40.107.100.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/SrKWUhZ16m9XS/ZWEwzHGAexaEsRdthkcCPxUx+CPafYwVLRIdsPFT+IVgALmGZ1eGoB+w/ktSxZVpnyZRqqLXa28pRSTnFWFtdmn5fiC3EPolJNJigRkRTUA5R0AQMbad6J4eTkVQBrNqxqxw6BNFboCoKrL3L+m9JIobCBMCzIn6WL4KB/dKjCeeVSLSoBtPzdiEtkLz6uj6VzsGa9rG3Ej5F1VrwPNqixjA7krY5JEoXMXDFT89Tg9dFnI2UIDcEbRFJCN+EYw/Qz0aWuvHy64alzShCV2Ez/0y2xLTgO2eo4QZ5ndhWfQJPEcTPJiLdKUSqLK6R6QVSLdYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGBdT6L2pZ2tosRn4to7mlYdTHwOU7SD3hpBSzf3FRc=;
 b=qVQOrvQput4DSDwZL6P/Auyv+YUUm1I7yBg+m+ru+wvsNlv2+Yd74I4IAgdSJoTFmfEEtHt2qnl/sPdC2abyTfo/N78TFLZzphLpzfpxELP7CWX808CioTw/yfyVXT+Il06nAq8V/PAAxUuuS5whgHB+8gUuIP74K0aeoP6GqjaAm2egAHDycS8gD0zgfKjVKwWHDD047/rSrW/2qKGmqjrFddbsCpc7Ao6jU2ndc66Uo5ZgwsnVkIVQMUMg+0A5EFnB8OFwuk/zmwQSjcHUgRzEOOLb8t7/m3F7MN8aoS90aLsHBrx7elG1AYpoUNJo5/7XTBPafeq/CdXdNbtT7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGBdT6L2pZ2tosRn4to7mlYdTHwOU7SD3hpBSzf3FRc=;
 b=juyxlmRRi3m3Sj9tGe5lisCBrphYSeoK14rVZj7g4/WWbdu8wfiLyNZDyCU6c2PInA+J8OF5wZbQ0gOTuPlVNrGW5PI2seVyDoXNUFMrH8IeXG+10WzrbKoMgoZSIxbFhkv15xSwIGQQ22ibnl+oC3ZCb5Z56aYwV3leD2LfRLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 CO1PR01MB8772.prod.exchangelabs.com (2603:10b6:303:276::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Wed, 20 Aug 2025 11:05:33 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%7]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 11:05:33 +0000
Message-ID: <d421a5ba-95cb-42fb-a376-1e04c9d6a1ac@os.amperecomputing.com>
Date: Wed, 20 Aug 2025 19:05:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/nohz: Fix NOHZ imbalance by adding options for ILB
 CPU
To: Valentin Schneider <vschneid@redhat.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, cl@linux.com, frederic@kernel.org,
 linux-kernel@vger.kernel.org, patches@amperecomputing.com
References: <20250819025720.14794-1-adamli@os.amperecomputing.com>
 <xhsmhtt23h0nw.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <7438bb3a-96d6-485a-9ecc-63829db74b39@os.amperecomputing.com>
 <xhsmho6sagz7p.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Language: en-US
From: Adam Li <adamli@os.amperecomputing.com>
In-Reply-To: <xhsmho6sagz7p.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR01CA0164.apcprd01.prod.exchangelabs.com
 (2603:1096:990:7::20) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|CO1PR01MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: d302918d-c5a7-46c5-15ad-08dddfd97b66
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEREZFdDa085d0Q3d3hXd1lwUFNENHFpd0pyMmxQaHhJck1lY1VuVjlvUnVm?=
 =?utf-8?B?TTZPYTdHempWU2FsODJsMFVMYkxNektDa0x4Sm9xbFVOVTVFYWs1b09raEtK?=
 =?utf-8?B?VkN4V1VRMkFSdFZ2MzZCT0wzQkxiREwwUG5sZnpSVlp3bnN4VXVWREp4WEx1?=
 =?utf-8?B?Tmp0cHBFVTg1UTJYMTN2Mk8xYy81YmRmakNpRUlQVjNLUHYzNjYyeTZhcFpa?=
 =?utf-8?B?aGJmdU96V0tYM3p0L0RNZDJNMjFDT3RxNUI0Y3hEVG5NTTc0Sng1WnRpWVd1?=
 =?utf-8?B?Qmk2dlRpMkNQUlRidENYRWZNWlMyNU95aXRNaWI4YmpMLzFhazlJQkQ4ODlC?=
 =?utf-8?B?eWpFQStYTk56WDhsNTB1TUxpSWFqMEQ1dUV6bUpGVU44andiTDVKVU84d1c4?=
 =?utf-8?B?bVJDajlnVncyNjdxMzFPVHZ1MWNVUFJHNUlpakE0VnNYZ1RQNTNCdFlSRjlE?=
 =?utf-8?B?ZHBLSnIvTmFXaTdBQ2t5Y1d6RUdCL0pzd1RGM3ZPamhHbldZcVFITlFyTjdl?=
 =?utf-8?B?TUFqeUdqUndESy9BZU91c1Q5d01kQ2NNUEJTd0hQbW9HYlFEVkdENjd2bC9O?=
 =?utf-8?B?RmdlU0JZUk9samllTlFiMktScHdub3QwSkc5elNSVWRoanA4bW9xU2IxWUlp?=
 =?utf-8?B?MldaeE5BYWhSOUk4MFcwNVRpUVBOUklSTVgvQXFwTzZPUmFWT2lRNHBTdDRz?=
 =?utf-8?B?bkMzTENnMTJnUEJOM1RsTC96RUlxa1FSMVU5L29xZHBnL0I5L1dKRmUxUDdi?=
 =?utf-8?B?VHVLWnBPcWh2eDNFMmpRbzRLdTQxM2VrMmNUQlhjUEp5ZVNtc3lJc0E5bVVu?=
 =?utf-8?B?OHNiYldtczFmVGhzMmhXUWJ4L1Q0ZVVFenRJdFRLQTQvbk5uVU5nZjBpQytn?=
 =?utf-8?B?N0JiY0wxT1ZjVUJ5ZS9pUHhqWSt3QVdVemhjM1l4azRocytmMlV5NDVLZW1K?=
 =?utf-8?B?TUtOK1pvdnRKeFJwK2tyTjRqcFQyUWVPeXNNc3ArcWJjN3pIR2FwTVh0b2t0?=
 =?utf-8?B?YlRybkFBQm5yVDFXdElBRW1RMFAzZDRhNzA2UlJGTXY2bVNpZCtKWUhFVmZh?=
 =?utf-8?B?dzhLRVdHM0ZHTTFQMFlMd0lIam40SkIzQllVZm5DZU4rQ2FLMjZOOVljQVBq?=
 =?utf-8?B?eWZEajdmS3BsS1pDaDFoV05UWmxzTmZuUm1EVnVLT2FGRzRWMXlHNXFiUzlT?=
 =?utf-8?B?cVJnR3E0dElEeTFDVmFXZHBIZVFKcWJ3aVRFWE1SczlkZEQrNzE1NEFYSVlF?=
 =?utf-8?B?NFlyYVl3TmE5TGR3aFpQT09mSG5LNTJxa0E4V3pDVXdJRngvMW1rQUFkcTFS?=
 =?utf-8?B?cDNrUk5qYWIwSEZXWTRBVGZ4QlJuRzBhaVhsbEl3dFhYSnlOL0crdmlzMnhO?=
 =?utf-8?B?NW0yNmNWUGRkMzhoNVFSN3hvSTJQN1Y5Q0VkSms5eklrVkh6RVppdU9CRnJv?=
 =?utf-8?B?V0pYMUZjenI1WmVFWE9waUQvbUFNNGI2NkplNkZ4bW00bEQrMjhJRDBvS3NJ?=
 =?utf-8?B?aTF5WVhKa0EwdHl3cUg2dmsvczdEaEhuNlV2bXNGTm03N0szT2wyY3Y2cnJp?=
 =?utf-8?B?OG1mU3R2d0xKK2c0cEl1RnM2NGx2Y3BrR1RvL2VLK1U2SlJsMk9EUmJtVS9Y?=
 =?utf-8?B?em1HZDNkQXJmRDArQVQyMy90NHRjS2RnK0RpamZwK1VaL0V4WDYvQnBhOWho?=
 =?utf-8?B?TytBd0Y5aEhLTnNWWjUxU21zRHhCNXgxc1ExQzYwUlNKNjMrN3ljV2tERkxF?=
 =?utf-8?B?TU1EZlJpUnZqRy9OWm42UENqaEd5S2FzOUFWMk1oYWl2WlpyalJOOEtUT0N2?=
 =?utf-8?B?R3E3RGlaaWFWZ2o2U0pud1lHWkMxMVNOVzRHSjlOSkp6U0xvS3liQ1Zsamd1?=
 =?utf-8?B?Qkl5R09LUUFkRWhpOXpLR1FhdytIdndrem41MGN4SWd1Ym12eE5IV05FK1Vu?=
 =?utf-8?Q?X0KIHfibDeI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHcrVUN1RFJIQVF1WDdSK2I5TzhOQVVnbkhqYm03THBEWHplZ0lmcUxoMk1D?=
 =?utf-8?B?Si92SUZ6OVo4dmpMTS9rcDBrYnZuNm5jZ0dxQm9KZnNKSTByMXVYdFNUTTBz?=
 =?utf-8?B?STU5dTFlZE56WnVHdGlPZGJlSHVta1FESXh1YTVDRk5kVVMxNmpLVG9zZ2FI?=
 =?utf-8?B?Wml3U1BoUEdlb0VBQWZEc1ZkTmFHZ25QeDM3Y1lpY1BpSTJsV2RHN2pNOHZD?=
 =?utf-8?B?cHY3MG83Z01HUk1JVGlzZFdSNTlCMUlBbW82enkwSERtcDF0cVdoNFhSMmZ2?=
 =?utf-8?B?d2ttVWdpRU01T3ZwUXlZMVdHWTlsSGh3U0FhQzlUeDExTmx0UGlUTEV0UFR3?=
 =?utf-8?B?c0V6S2x0T2hWN1VPWjdNcHVWTXdQRU9QNEE2YzZBN1dWaDcxZjUvNWpURG9F?=
 =?utf-8?B?Z2V0eFpNVi8rUlVtNnVWN1hCTHV4OU9iUE5Pa1l2MUpmbU5xTU16SktxRUVB?=
 =?utf-8?B?ZzRRYXBHY1lEWFhiUzJJTlZGYVBqZmdhRXlEWFp0UG1wM1hWRnlHZzkwd25I?=
 =?utf-8?B?VlJySjR5MWhxNVJOTGVOWnpvQzA3d3BDeVJwbzd2S2NBQUQ1d3orNlBsVzZG?=
 =?utf-8?B?ZFRDRVlxdSszMWVMZmpQRlA0NENjZ0N4cmhRZmd4QmE4ZWJQREt3MjZxS2tD?=
 =?utf-8?B?RTF4VVo0b0RSZitsaWRFcXlWTjJ6dGhoQmNRUEt0MWlnbzlvd1RRNll0b3No?=
 =?utf-8?B?ZlFLNEFTT2tOTVE5RVJNeWV2ekcxYjY4NStPNmpiM2VSQlJYMEJxaytpNVFm?=
 =?utf-8?B?YXhQUkEwbWRTbzJ0NDI2cXlnU0xqT1JIVTNtaU1QQ0FteUxSQkNHbmdrMzlY?=
 =?utf-8?B?ZDRsQXAzeE9pVG41NUlPUmlQQm54MEpKYVFMeFpIYmJIa21PbDF6S1h6QU9O?=
 =?utf-8?B?bWxuQUpzblVuS2dJQ0FWSzh5dmhNQ2RLOWNqendYS25ndWVBcGRBdklCemVD?=
 =?utf-8?B?V0NHaFEvTjUxUHl5MGV4MEVzc1dTYW1xVXFOVDdZd0FCS1hna3lybDFLNjUr?=
 =?utf-8?B?MXdqOXVIOU9nZjlQUGhFc2J0YnFsVXhaNXZtc2N1RVlBSHltZFRxeEhrMzJh?=
 =?utf-8?B?aUcxQUtMY2s5OEx2R3V3YUxDZGFSS0RpSlgrMnp6c3NqdGZlUVBwYnBVQkp1?=
 =?utf-8?B?b1ZWT0grS0w0eUR3SWpWMlJaQzRpVzNVVklJRlNUSG9lUStlNExreUZKdjN6?=
 =?utf-8?B?VE83Q3g4SENxZVNWVW9JRHQrTHpKVU9jR2NnZ1FMUS84V2xwSi94VWNDTmQ0?=
 =?utf-8?B?N1lvSUpScUlzUm1zbGdxZVpkNW96RzBGRXRSRWMyK3o4VlZtdmFqcEtNK01h?=
 =?utf-8?B?SVR1SzR1cCtIZVJqK2FwbDA3Um5Ta21aZnF5SkN2Z3lBRmsyOWR2T1l2U1RL?=
 =?utf-8?B?eHdBTmtmdnhzMk9NUWdQajU4VTVjK0NuZ01sNGpYbFhMcEg2NW5WT3gvWHVF?=
 =?utf-8?B?VmUyRkQwQUNmbmJyb09WNHNzNzNSc21HT3pqdEJNMTlNSDdsSmtxMHpqc3Ru?=
 =?utf-8?B?MWNvOTRsaUJhN0dqMEpKbXlySGVLTmJ0OGJqN3NMTlZPRGV2bUZDN09IRFBX?=
 =?utf-8?B?bDd6bG5Rdm8wVVA1SThLQnlpT0d5ay95KzlEd3FSNzVQS1lsSHVQYkFqRFZt?=
 =?utf-8?B?eHdHcXZYZlY4WlBOZFlSVncybkxJbExsVFpxM0hpUEhxTzFmNU4wSjByUko2?=
 =?utf-8?B?QXlOLy82MlpIOTN2YTd0cThRWHdhdjRxV25udEZjVGtMSnFsU1IvRytXM1pB?=
 =?utf-8?B?SExWK1ZhUk1GeDdhbnFxdEpqdCtua1FpMHZ1WUZhdXRoaGY2VXdLK3RYY0Fp?=
 =?utf-8?B?Q0hxb1I5SEtpNms2aGxkNk1aQlJtazd1OXVWWjNzTkVkbVBZcFMwK092WHRm?=
 =?utf-8?B?NHFBN2FuSjVOTFZzUkFaVnFvL0owelJTQnJZNWdXM3BiYWgvOVFBNWZNS3Yx?=
 =?utf-8?B?d1pVTk1wekdRTkhDamlGbWY3aml1QmtRanhoeS9lMHVGNFJUaFlhNWhIbUNt?=
 =?utf-8?B?eFhDcTVtYWhUZTJiUGh0NUNuU0N3OFFjQUlObVJnTStmS0taaDA5Y3paSG5B?=
 =?utf-8?B?UHFCZFRxOGx5UlViUE8rd0UzRlVnQWs5SmVDUXpEOEVRTEZWM0F6K2toTkxx?=
 =?utf-8?B?bklYcXZhL2pqWWREbkhsaGsxYTNaWnd0ajkwMDNmRU9PQkxjWVlHYTN0SFor?=
 =?utf-8?Q?nlEAzpnWi5RjJkR5ZDRVrPk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d302918d-c5a7-46c5-15ad-08dddfd97b66
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:05:33.1777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEdBbLD0uTqBoCFFat2LFcjd90LaOwVI4CDafcw+e4xmPCxblvtMiZ7Gr5kUaoQibWN2q+3aNKID1n9O+LVHLD+Q+VqY2bwFj30TIV3+onT7iiYU7pvihTuFhClqmvwc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB8772

On 8/20/2025 4:43 PM, Valentin Schneider wrote:
> On 20/08/25 11:35, Adam Li wrote:
>> On 8/19/2025 10:00 PM, Valentin Schneider wrote:
>>>
>>> I'm not understanding why, in the scenarios outlined above, more NOHZ idle
>>> balancing is a good thing.
>>>
>>> Considering only housekeeping CPUs, they're all covered by wakeup, periodic
>>> and idle balancing (on top of NOHZ idle balancing when relevant). So if
>>> find_new_ilb() never finds a NOHZ-idle CPU, then that means your HK CPUs
>>> are either always busy or never stopping the tick when going idle, IOW they
>>> always have some work to do within a jiffy boundary.
>>>> Am I missing something?
>>>
>>
>> I agree with your description about the housekeeping CPUs. In the worst case,
>> the system only has one housekeeping CPU and this housekeeping CPU is so busy
>> that:
>> 1) This housekeeping CPU is unlikely idle;
>> 2) and this housekeeping CPU is unlikely in 'nohz.idle_cpus_mask' because tick
>> is not stopped.
>> Therefore find_new_ilb() may very likely return -1. *No* CPU can be selected
>> to do NOHZ idle load balancing.
>>
>> This patch tries to fix the imbalance of NOHZ idle CPUs (CPUs in nohz.idle_cpus_mask).
>> Here is more background:
>>
>> When running llama on arm64 server, some CPUs *keep* idle while others
>> are 100% busy. All CPUs are in 'nohz_full=' cpu list, and CONFIG_NO_HZ_FULL
>> is set.
>>
> 
> I assume you mean all but one CPU is in 'nohz_full=' since you need at
> least one housekeeping CPU. But in that case this becomes a slightly
> different problem, since no CPU in 'nohz_full' will be in
> 
>   housekeeping_cpumask(HK_TYPE_KERNEL_NOISE)
> 

I ran llama workload on a system with 192 CPUs. I set "nohz_full=0-191" so all CPUs
are in 'nohz_full' list. In this case, kernel uses the boot CPU for housekeeping:

Kernel message: "Housekeeping: must include one present CPU, using boot CPU:0"

find_new_ilb() looks for qualified CPU from housekeeping CPUs. The searching
is likely to fail if there is only one housekeeping CPU.

>> The problem is caused by two issues:
>> 1) Some idle CPUs cannot be added to 'nohz.idle_cpus_mask',
>> this bug is fixed by another patch:
>> https://lore.kernel.org/all/20250815065115.289337-2-adamli@os.amperecomputing.com/
>>
>> 2) Even if the idle CPUs are in 'nohz.idle_cpus_mask', *no* CPU can be selected to
>> do NOHZ idle load balancing because conditions in find_new_ilb() is too strict.
>> This patch tries to solve this issue.
>>
>> Hope this information helps.
>>
> 
> I hadn't seen that patch; that cclist is quite small, you'll want to add
> the scheduler people to our next submission.
> 

Sure. The first patch involves both 'tick' and 'scheduler' subsystem. I can resend
the first patch to broader reviewers if you don't mind.

> So IIUC:
> - Pretty much all your CPUs are NOHZ_FULL
> - When they go idle they remain so for a while despite work being available
> 

Exactly.

> My first question would be: is NOHZ_FULL really right for your workload?
> It's mainly designed to be used with always-running userspace tasks,
> generally affined to a CPU by the system administrator.
> Here AIUI you're relying on the scheduler load balancing to distribute work
> to the NOHZ_FULL CPUs, so you're going to be penalized a lot by the
> NOHZ_FULL context switch overheads. What's the point? Wouldn't you have
> less overhead with just NOHZ_IDLE?
> 

I ran the llama workload to do 'Large Language Model' reference.
The workload creates 'always-running userspace' threads doing math computing.
There is *few* sleep, wakeup and context switch. IIUC NOHZ_IDLE cannot help
always-running task? 

'nohz_full' option is supposed to benefit performance by reducing kernel
noise I think. Could you please give more detail on
'NOHZ_FULL context switch overhead'?
  
> As for the actual balancing, yeah if you have idle NOHZ_FULL CPUs they
> won't do the periodic balance; the residual 1Hz remote tick doesn't do that
> either. But they should still do the newidle balance to pull work before
> going tickless idle, and wakeup balance should help as well, albeit that
> also depends on your topology.
>

I think the newidle balance and wakeup balance do not help in this case
because the workload has few sleep and wakeup.
 
> Could you share your system topology and your actual nohz_full cmdline?
>

The system has 192 CPUs. I set "nohz_full=0-191".

Thanks,
-adam

