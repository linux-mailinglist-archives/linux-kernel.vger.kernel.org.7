Return-Path: <linux-kernel+bounces-752818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC389B17B43
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 04:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102501AA6BD3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A0514B96E;
	Fri,  1 Aug 2025 02:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="tF5BrzNZ"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023107.outbound.protection.outlook.com [52.101.127.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F365173451;
	Fri,  1 Aug 2025 02:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754016052; cv=fail; b=u6w57tNK2CJyBwnWv7NIgfH8PZKppSHk7/1EoJ4ayGV52qJdHx0L7Pix0C4soeYRhweVaFDfJ9JQscO2NTMYSv/YUIUBbZCpPkkjp4bbUbMjvQyPfdmcZyK+du5wthU+S1MUxOrKfuRXr/HbJ4WLaagC3NubsN/LBkfttFUt0Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754016052; c=relaxed/simple;
	bh=SnJvMEtORjmCBTGOFNZbTZem5zEMqaXe+vLFeSuWHnE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iAFfaff7B5N/ZSoCXWw/rl5PC+C2fiGhJE1suR1l0hUGBckNsV0dvxSAev2K9zzh5ayg4E7Gs5OtZObE5cQWL0yps2NUTxIoi2zBmsKaT1hnrISEkSdUNVWjNBTiMpiW4pUixYiHQb2s8m12LA5bM2M0d50YV5EihmfbBMNoWXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=tF5BrzNZ; arc=fail smtp.client-ip=52.101.127.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h188k7TKD6dEFgiTn5v0MWLrFRFzRqI6QrbBWFtU07zco/9Yyw5fbyzsPJaOZc+PQkZ/G9XuexRTbffD48oYtB4FP3hb0q8jZE+i8eNRzClrHnuYWDH5usKQl6MpfUL9SLJrIQOtUPtbZmvN48rupysOfnRM62HsDYJolIutxOzdD5YT3ZqrxeUJ+X2EhWqA9ivWyCLjDbPvI+ewgTG98IRJiunwWr6sX4r3q5baS20RFR4ZEpVso8EIyWENabgpcGx/bjYhfrLJorgZRovs+dyGDbsHUP/JPTpTgU3yMMgAgcxgLEAjZjOrVC1c8BrDAa0k2N+pX+jP/w5IYqHQjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZLq1vvwsDP14HmITFIDa/VLEkifkZ0pLED/ow/FeQU=;
 b=LYK9u++xgR9D3/F6W3RlTfvKNOfS+QAdvpwGKVumD+oAWNcKP7HRlbO/N299TkfnpbBNeOG450kJfyCvjFCSNEAqKmDNNvEIGu63adwddz78Yp7bIE3gfV5OuvA/WzH6ntWW+Y7hJjet2EZVkzuIZKXIQRmbVQ1ffQeO3uN2F784z4Fu9iUKk10BBflby9GUSnw7X1Cfnxc25cusr2Mx+8aCUAdMLdB5Gcj7YTreJtqy7/MM4OM+zzvpl7jdcC7pDcSH00NZVdTg5xCEUY47Ks1h32m/lWb/OwgRLVtd5C8v1z4+aodwNF2MRaAQ7fGP9X5IUK1KysIq/4uLCIDFZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZLq1vvwsDP14HmITFIDa/VLEkifkZ0pLED/ow/FeQU=;
 b=tF5BrzNZzyIyNNrdPmFDtfyHxQlK5Fk0qdPjXbO17rkprAsTY/wdDT4lNk9tYmc66qeuRPdsVYMNBwjFWRvWJrpobNqV5OqSLp0nqkihhVDXly6RDdLJqIPhguvf/eXcQ5C72G/GrEB1UpK5YfxLHvT3pYAMpQT2GJM4XXT9QzSrpcRVQaETILbHbAb+6qPLKkZqyaOwfmqjq3jC8Htb5AUjRvZ1z0dGkYJLLoF1kmVVxcHzQuJFaF++HgbkG9ZGh2GRGNEz1W+mJ8/wKFCQrhLXZubn88ZVl5HeOyPpuKgr/efMSYBNwDazg5uA5xsZQkiA/wvetBthWDTx6VMIfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by PUZPR03MB6887.apcprd03.prod.outlook.com (2603:1096:301:101::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 1 Aug
 2025 02:40:46 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%4]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 02:40:46 +0000
Message-ID: <f815a5ff-920e-4842-9d6b-f4a11944b9b7@amlogic.com>
Date: Fri, 1 Aug 2025 10:40:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: Add fault tolerance to of_clk_hw_onecell_get()
To: Stephen Boyd <sboyd@kernel.org>,
 Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250731-add_fault_tolerance_to_of_clk_hw_onecell_get-v1-1-886214fab4a7@amlogic.com>
 <175398035351.3513.14541914855277799230@lazor>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <175398035351.3513.14541914855277799230@lazor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|PUZPR03MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: a63338b6-0d4b-4ece-418e-08ddd0a4d18d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3Faa0JZSlA5RmFaTTF4UG8vdFgyNThnM0pqb3VYUUN5c1QwbEpkckJUSUdB?=
 =?utf-8?B?UzlaTC9IMnNOeUFzcEhhSlBFbk9EMU5FSFlNQ2pNTXhsdFFYV2UwdTFsd2JE?=
 =?utf-8?B?SU5KRXZKWFZIUEtweWFoM0JWVW16MzJqaGQ5Zm1USGlPR2UvK1RDRm9FNGxW?=
 =?utf-8?B?WVRZRzdRRmIwekJHOUlFajJNWG95RFU2Zmp2ZE5wTkdIQUxjVjY4RXlTQXVU?=
 =?utf-8?B?dXFGek5PY012RDhYMEJMbjkwMWMwZWxOZklqbmJxV0Z4NWNLaXQwUkd2L1dL?=
 =?utf-8?B?ZWszdHU3bjM4MXExN0E2eEtxS1V6QW55UVBnVTd0NE5kbFh2TEQ2OURONU9j?=
 =?utf-8?B?MkNtRjg5TWoraG0zT1VNUVBkOXdWSldaM2gxN0x1NFZpbGcrcXg0UkJINzdl?=
 =?utf-8?B?eHdSb0VWQWdkNmpPSzNMc21UNE15MGFWWVJIOVN1amd4dFltTEdTMEZ5d2lG?=
 =?utf-8?B?ZytmU0ZaL29DMUNXVjg3YjBVeDludmIzSGNkZmpWd1FsRHByVkZQaTRXclFL?=
 =?utf-8?B?dzZJQ3RCVWQ4V2c4NDNIVzh5aTJiVzFvSVZPZEhrb1QyNmVlN3ovUnArdVZM?=
 =?utf-8?B?Qit1MmlRa0xoZWY1QzlVTjFYV2JsUEVqSll6cTNFRFQ0eEJ1RkozaTk2cmtW?=
 =?utf-8?B?NXZld2NIN3V3UUdkeE9zY2ttanFpK3Bxb3RJOUtRNlJsVmxPMERGaUZaeksw?=
 =?utf-8?B?aTVtd04xbzcvb2Q4VDhFSmQ5cTF6RHJzaHhKSG5WRXZWUm9XZzBPUEcxOTRq?=
 =?utf-8?B?S0d1c05UOXpnTjd6ZlJzc3ZHWXVSOWFlUjFBd0JPNHNJZ1Z1UW5ZQndtK0pU?=
 =?utf-8?B?TU9vTXV4emVwWTJZc2pEVXpobCtudEJRWkFNYjl6czVpYW90RisxY2t5NENE?=
 =?utf-8?B?ZUpxVER0Z1NKdVBpc0tiN2pUdWd3U1hpWDgxU09rWmp1TjJsMXhjT2V6TVVa?=
 =?utf-8?B?MWM3YWpieEdWTy9jVWwyTmY4TUpyUlltcVJUMXRZSjRmTG13VFE2TmRMYVBx?=
 =?utf-8?B?dW9zdmZFRXluWTFxOGFjNzc1T1drNjZpVko3cFlycmRjN0g3NS9ldVRRN1Rz?=
 =?utf-8?B?T2Z6cW45S3FOM3FIbzBrMGp6NXRwTWtZREtDU2RoWXExa3lOZ1I0dVF6bFcx?=
 =?utf-8?B?S2lZOWNrbis2QTYxVDNtRTlhTDJuRUdUVzRnZ1ZFVkxyTDB6Nk9GRC9LdVYx?=
 =?utf-8?B?OElRb3VSODZPRUhLeVp1dlh1V290UW1ON3MwbTBOUXRrSjViVXhJMXZXWFJI?=
 =?utf-8?B?dEN1VVNOb0lJdVQ2ODRJN0NKWmkzb1JhZWhYM0VlaTBDR041WUNmSlBMZUI3?=
 =?utf-8?B?MU1yai9hbGN0Y3J6bFJ3UHNaWEdSajROSVkyOE9WMEl4WXhjNWxuYVFXOHpB?=
 =?utf-8?B?QmYwU3NoVjVtMFZET3VhRHVOMVFRZnZiOER2eTVVQnk1V3BQcVk4emx5Qnkw?=
 =?utf-8?B?eFUvcS9ra0k1OGZTckpFcisvOFVuckV6aGdNeDlnbTV2OWkySURVcVJrZC9p?=
 =?utf-8?B?dTM1Tmhqd1IwQlJMUU5Lcm9sejJoRGhkQlRFMVFFbld4a3kxSHBib3JRZWJO?=
 =?utf-8?B?ZDQzSE41ZTcwUTFHNmJqd1dkTFpMNU1mNHdOTnZ1NWdVZEJXMG5qK0E0cE91?=
 =?utf-8?B?V2ZqcDl0UjZQR0YydGUrMDlTQlpnb3IrZnU0WkhIbW1CT1VSR2IrT25CaG80?=
 =?utf-8?B?UXc0dVo4MXd4Y3RXTDlocVVXOVNzaDVxeVdHbVVIWkFIeHc4QnZWS2YydHgx?=
 =?utf-8?B?U1RCbzFaNXArZEVmamJBTEdhL3NYb0MzeDYzNW5MUVJ0R2pRZnVJTXZtYXJL?=
 =?utf-8?B?Z0JjT3VXSXUvY0g1SzVqRWNITGd5c3RlRFJHSmVWZ2pSRnN3c1hsL1B0M0Yx?=
 =?utf-8?B?TndzNFVhUDEzL1VYNzVXem1CVENldm9pallVaGx4UWdiRlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzhwWmdwQjNkeTM3OVFSd2IweXc1UzgvTzJCUkloSkwrTFphK0tRc3ZDcTZQ?=
 =?utf-8?B?KzYyaCtpUnhDWjlQUnFmRXNnOXlBSEhWaWpSMlBEWEp5YlNMVHRKdU5scDk2?=
 =?utf-8?B?UXhkOUtEVFpRUzV6RGRya041cVdBSjhZR3lvWEdBcnQvaEY1TnN1VlRyNlhU?=
 =?utf-8?B?S1RWN29KL281MkN0UDFEQ2xBQ1B4bm9XanJUcm9MMUszaHVWS0VQZDZlZ3B5?=
 =?utf-8?B?bVpmbzM2ZTE0bmhTZmJ4RTcwNit5WTZIcDRpaFVkemNRTnd6WDRXd1JaWUpF?=
 =?utf-8?B?dFV1RlJLbzZ5R1N3Ym8vSFJ5ZkZpNVBicWR3MVJ0S3R5UXF4bE9Hc0tsYnlu?=
 =?utf-8?B?a1hkNkl0Ti9zd0VzZllUbXFUQVNpSnI2NzZHblM0Z1JrVUR2VHYwUmZXcjFh?=
 =?utf-8?B?RjlzbU9HSGZuT3lyaUE4V2NHOTBiWCtwR2Q4ai9YaERDWVcrR1RCZ05lK0pi?=
 =?utf-8?B?cFkwRTRicEFyOWo4MWlmWDRTRDU0ckoybVN4Z1F2YVJFVlQ4V2FZSWg4L1JJ?=
 =?utf-8?B?Z21Xak5OaGFjc1JmL25TTUxkQllqdWN1S3BQNnFRWFpHbnZxYms1eU52NzdW?=
 =?utf-8?B?Vy9sUGVsUHZTemxNL1ZjMnMrbis1YW5qZ3ZxUWMvNGw3NnBCRVRBL2IrM1kr?=
 =?utf-8?B?SXAxUFdaOTQzNWwrTHNYcUxOR1poU0JBWVozNkNyT1FFM0dSZTVvVGlPSFRN?=
 =?utf-8?B?UEV3QXN0eU52bEsyVFVjZE1vWUQ3NmsvdWFFQXB3ZjJMalNmOU10Q2VBTVU2?=
 =?utf-8?B?Z3RTenlLWnFac1J2RlJtbVJpaU9BaVhxKzVPWWFHNXhTVkxDSmROWmk0c1FT?=
 =?utf-8?B?bGp0cXFIYUFwS2VoeFFDMk0xZm9mb1haZE90WmNPbldmNGZZYXdYZklLZzNp?=
 =?utf-8?B?cG9QeTBSZks0bEVGUkNKR05XUkpQcDFNbEdLK2lZaXlyS1laV21EWG9uTVhG?=
 =?utf-8?B?ZVVkWE1heE1XaERuem5ib1E2Tm52amhFVDhFK0d0dG1TY2pmbU9neG9aMm5q?=
 =?utf-8?B?ZWlyRG5IMWRUaW1CbHh0OG5QeUlmWUJ0Rjd4eTN0MHFOOWVrVVRqS2t2bFZL?=
 =?utf-8?B?TzJJMHJicS93L2dIWjVvUGJSbVFidTFrMk02RDVFall1c2xpSThSR0pobHVr?=
 =?utf-8?B?UE15TDNWTXZiMlcwM1JHR2E3U2ttUmw0K2VqTnBqK0Y1bkJkRndQbDMvVWxa?=
 =?utf-8?B?NDNvbVNERW9zQjkwSEhxNDBWTC9mTm5zWno2RHpGN1hoeWR6TUtSSkE1MVlQ?=
 =?utf-8?B?cklFc3E2V0k2RjkwZ2ZUN1o2cEtqcVJIbldpOE54K0lwN1EwN1JFeVZ5MG9u?=
 =?utf-8?B?ek1kNHY2VWRtYXE5ck5YTzdRNlFpZ2RVVlJHbXk1Y0RoRXEybVlHM1paKzZ2?=
 =?utf-8?B?MnBzMHRlQVQ2MHJrVldPOVdtRGxuLzdjbmlzZHJpS3N6NEphcHAxQTB3bnVp?=
 =?utf-8?B?d2dyRXByRkp5ZGhqQ3JTSFVsWWdLdzdQMHBZbElVT0VoVHNyREF1SGZLcXFs?=
 =?utf-8?B?bm9WeWZad05WejV1bHlXY2k1emFlcHRUQVhqTk1RNGxjR3JpYU5rRkVERlJP?=
 =?utf-8?B?bUNoU2ZvWWFveEthSTZYdG5kSDlSY0FSdEVEWTVHQzl5R2JyNjNidWNSZTY0?=
 =?utf-8?B?b0U5SWxhRFZmMVplTXF2NkFsUXl3QUc3Z3ZMR0tIQmxjTEtQYzFHTkxRWnVh?=
 =?utf-8?B?MDZTdnNwTWFmUGZMcGFKR29pdW1uak4zYjJGdWR1bndoS3djUmprMkRBd1RG?=
 =?utf-8?B?ZHhZYjI1UUZxLytnY3dObWdWb1pHSUVkajBiZTNJOEd0S2JOMS9SQ1AvZitC?=
 =?utf-8?B?K1ZPTUpNWkZHUld2ODBoSEdoOElwV3ljc2J0OG92d2tzRjBrSUZ1cnI3OExt?=
 =?utf-8?B?NjlRbHppV1gwOEtqcDhOZUZyelRaSytrcWJabHVJYnBXWHQ3SG9mNm9OWjNZ?=
 =?utf-8?B?VVhrdEd2V010ajBKQzZ3c1ZnQ1pTcGpqTEVhVUNzejhGcGc4N1N3dXoxVndG?=
 =?utf-8?B?SEsrbnQvYVMwTTMwdFY3aU1VbVVxZU5tQmJPeUVXdXV3M1lNYmFFaUVMTm9h?=
 =?utf-8?B?eXJSVXlEVkdpZ000ZHZMUUk2K1hjT2VQMktKSCtjNjhPZU42dnU5b0FCM1lw?=
 =?utf-8?Q?VJFZ1/1SIRtCwgKs6XaCD5kYj?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63338b6-0d4b-4ece-418e-08ddd0a4d18d
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 02:40:46.7189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbBGqIGptOr2lh8tE49XDFNA1Gq8CIRQHMrN2s37JZ8rnMJ9GBOGPzWXyT8Ad033wrS/P7T/4JKTxZB6KBdOZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6887

Hi Stephen:

   Thanks for the quick feedback. I'll improve the KUnit tests and send v2.


On 8/1/2025 12:45 AM, Stephen Boyd wrote:
> [ EXTERNAL EMAIL ]
>
> Quoting Chuan Liu via B4 Relay (2025-07-31 05:39:58)
>> From: Chuan Liu <chuan.liu@amlogic.com>
>>
>> In specific cases, even a clk_provider managing only a single clock may
>> reference of_clk_hw_onecell_get() to access its member clocks, as seen
>> in implementations like clk-scmi.
>>
>> For a clk_provider with only one clock, when calling
>> of_parse_phandle_with_args(), the phandle_args->args[] members are not
>> assigned. In this case, the reference to phandle_args->args[0] in
>> of_clk_hw_onecell_get() becomes invalid. If phandle_args->args[0]
>> initially contains a non-zero value, this will trigger an error.
>>
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> ---
>> Error conditions observed:
>>
>> scmi_clk: protocol@14 {
>>          reg = <0x14>;
>>          #clock-cells = <0>;
>> };
>>
>> phandle1: clock-controller@1 {
>>          #clock-cells = <1>;
>> }
>>
>> clock-consumer@2 {
>>          assigned-clocks = <&phandle1 1>,
>>                            <&scmi_clk>;
>>          assigned-clock-rates = <xxx>,
>>                                 <xxx>;
>> }
>>
>> Under these conditions, executing of_clk_set_defaults() triggers the
>> error: 'of_clk_hw_onecell_get: invalid index 1'.
> Please write a KUnit test.

