Return-Path: <linux-kernel+bounces-755955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C3AB1AE08
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093B43BF8E9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C6F2192F2;
	Tue,  5 Aug 2025 06:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="FtbPi3Zh"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023107.outbound.protection.outlook.com [40.107.44.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2B91078F;
	Tue,  5 Aug 2025 06:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754374431; cv=fail; b=ghNkTe2+6EM/K1ecMhnAi9yMoK18TSJi+Oz+Zfp2SYYO6cjvLuHVGdtlaBLwlm9w5gfqQy/Ifs0zhUAzZoAWtP0Pjr69+7mozvokw9kIN3T73h+MVYW+1cMHd3ADf9/mbtcE5FAk0+mIynOqXTWgbCfgkNu8kD2iPYXdfr1bZCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754374431; c=relaxed/simple;
	bh=KVA6/rkm33Xw2BHfOUQ33dtIN/v1GOOnZ7yOF87lGSE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qxsbXl9JJ8vkIU0MRIVUY3xCZ0OH+FhYWjBf+LtHYz5+dxEEKDtd3EAET0ziWi95I41i8J6rkrTmNEz3XwpufOQXPmIRoBL6yJoDirJhg4wcpHBsE/pF+fqqhP3khjFneqsdFiumjLLbO6ofwdIIUmbib3kaeNGOq5JLpD1oF0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=FtbPi3Zh; arc=fail smtp.client-ip=40.107.44.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyFawkaktPn8SmlMKADRyLh7RDB0mk6zRgiBDygcdxYLYVA5uyv6t1P2x9I0cmmKDaOjR86tHQ1dexmPTpOl/MwQ68Pk0+ZDuiim+Tg1ghG2O7u3lQc5lKTo3LcZiWYQ/QBrJusL0k+fZwSvaKDpP8nkG82SsGAvZAwjJn1t0EsY/IGZ2Pss1GjGXPXJI7CC5EQ6DKQMUVGXDZsH9EKNpJXOY/7pgVMN5pKvTQn8blHdtHrtyS8+nYl6slrrWOJzFY13c1Nda+bofCwx4EL2ddkhIHcReDnxb+AQS8gl4GrPJqXUGOxsVv6GPXfIJaNav74W8pXCTfQZBMePrlAhiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLf+a1wV5W/ReLtaaJKwMqanvMqjHz1twaah3NMjfn0=;
 b=tzRmYgDMxZmNF3g49ibnlzJVifdrlEHHcH97YoZ7JQOTaobc+Og/E1rS5iD690mFRDrdf7+vJAcCvjjTfokKiIo05Bd0d9rFFN6D3ofuhxaw/Lgcz1XtCSvR+wEPbk/ApS0Q3R46T+vKuW0vPS77HTRdsmoo3IUxsfC0iP4rFAHP5dp5diFEPArM6qEgNenkWLnfFJTxzBtx8h4bagWoIMI7kg3pecSJa7dSC92VDEjIDA5q4ziL2BnSuyN31GoN0MXJ2Ptm8OX+r3099WnGPPS77x6N0KxpwiDhPgXuKNOcJo0vxrb1fTp0p6xjo1Rt99f5cMM8VrBQ+yjmq6leTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLf+a1wV5W/ReLtaaJKwMqanvMqjHz1twaah3NMjfn0=;
 b=FtbPi3ZhDaio7JCmRhFffDuUQF9nY/y4zIzZu8pH3KmlccouyHYDyzdgbRBz2Lr+schnvccxsSlsGjQK7R07amGqW2hXabg2WxRaif8R7W9BuUsioF+lIzRTasIxih2vEK8nZDAY7UWbV0dT85Dw37fVos83nZ9UpR/YN3E8z/I96QSpn5zB3uIAZJWJJpz1wijznGwj6c5ntH3zI2izLV7NKEDC+HY+8gL6QhFijoYwkXW3cpDaGaiawKLOu5i1fq1PHmUqt7iScn5rJQdb8hXz/5I6Ac9T+tlbfb3B51cqG/sSi6d2gkbV+7KhMi7/JD85ECN+FLvlfWvuUPqEtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by SEYPR03MB9374.apcprd03.prod.outlook.com (2603:1096:101:2d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 06:13:46 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%4]) with mapi id 15.20.8989.020; Tue, 5 Aug 2025
 06:13:45 +0000
Message-ID: <e2d67fbb-7b27-4340-b811-cadc01618a44@amlogic.com>
Date: Tue, 5 Aug 2025 14:13:09 +0800
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
X-ClientProxiedBy: TYCP286CA0290.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::7) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|SEYPR03MB9374:EE_
X-MS-Office365-Filtering-Correlation-Id: cef3d1a6-4e57-484d-4c57-08ddd3e73c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGs5eGUrbzBXRU54K3c2cFNSTU0zdWlYZXphQ3NZaUl3Ui9vYmZndi9HVGZS?=
 =?utf-8?B?Rmd3azdFRHlBMFJyUDg0YU5aSXVmL2I2REJxWFA2ckRWdnlaRFA0R1NkL1Ju?=
 =?utf-8?B?OVZVYU15ZDJhblo0YjMvU21OTVlsL1ZKNUFKOENsUlh1ZklJazkrZitzTVU4?=
 =?utf-8?B?OEdlNzFXMktIbW9wdEU3VnN2emphdkVmOTZJVTAwM1ZFU0gvc1ZWVDNzRDZG?=
 =?utf-8?B?WXhHYjZRS3k0QndXK3kydmFpRnFHU0NCTzhFc0U5K2FQTFpXbHRzVGJhZXRq?=
 =?utf-8?B?WWc4ZnVPNy9JQW5WQU9CZU9nZUltSUVTdTdVWm4yZFpOdkxTUkFrSm5FNDdD?=
 =?utf-8?B?MlE2Y01oSzBoRHpXUndNRkMvRC9iYmN3TDMxOVpwUDFzRFpwTUdnaUg4RVBS?=
 =?utf-8?B?bkIxZGMrbjNTWkFuTGlTcUhuL25wbTI5UzByTEUxS3NnQXRoREU4WlNaTkh2?=
 =?utf-8?B?bXJUcFMwby96ZW1UMmNVYU1DejBITS9lKzkwNWZwNHRaQTIvb21qeW9rb1No?=
 =?utf-8?B?aHFVZjVERlY0UnBFaG9Ic0pxTUhUdVJ5bWJKY1ZCeHFDRVllYjJ0eXZ2dGw3?=
 =?utf-8?B?ZkpQblprTDFmZERhaGViSXM4aWpKTWt2YTFvU2l1cndmZ1ZjcFQ1Y2JKbjBt?=
 =?utf-8?B?QWZROURmNkJYU0dJUDlsdG5VKzFXamRucEplc0IxVnlkb05uang5TytzVWVn?=
 =?utf-8?B?NW5rWkVIblFvbG1GazRXaUo1WWNISEpvUXYyWTQ0UGZvL01HV0FQekZNQXNh?=
 =?utf-8?B?UEZGY3c4NWNVQS9Hcjh6dzhFbHRCTkpXR2NmNURQYUZhblZXN29vYUR1dWkx?=
 =?utf-8?B?T3R2WnVBbTJyb2daZHU5Sksxa3R2VFRLUlY1UlpOQjRjZ0prbUhOd21aNGM4?=
 =?utf-8?B?Yy95Y0hpQzM0QllHNzd1Mjk0bzUyMGxJMVljZGM3VGlTVmtNMzdQb0NSenFr?=
 =?utf-8?B?R2JPald6bnJvNmovYk5oTWRHUWN0WWcyUGpNeVhJTGY1eEdnRXUzQjAzNCti?=
 =?utf-8?B?MFYyaDNVNGs1Vi9ONFdoUTRlbmJhL0tuVXhaai85ZFF1R3hnSDB6djZrVzlw?=
 =?utf-8?B?VEFTbWFrWTg5dS9JdXRVWXd1YWxsdG1WUy9PTmxJRlpyN1dpQmVKZTAveGRK?=
 =?utf-8?B?UENRRjJhaVJYSkJQOHJsM2ZuNDd3aUd6L0d4bmxRZmFYeE1RemRkNStUc203?=
 =?utf-8?B?WFJPOUM5OFEzbTN0ZjRreVpBbzFxbEZOckhzVWl3WXF0Q25vTld1RFJOenpL?=
 =?utf-8?B?TTB1T1FpS1pNOUZGaGJibW94K01OQ0dsR2N0YUg5SnVRSE03a1hhNHlIa2Vm?=
 =?utf-8?B?RmFQTkpSWFZGeUxFS3FxUk1LeU5IWWUrdkY4dXo4YU5YZzBQbUtiMUovd2J4?=
 =?utf-8?B?djArUGhuU2N6SG5SdGxkZlRCcXRXVk1ZS1pJeVh0OUVtODRXZStmTkgxbWFJ?=
 =?utf-8?B?NFpXcys3Z05nN2VHTUpaaDNYZW5LRDIvZUtJS1hTTnJUaXAwTHFPYjJDN0lt?=
 =?utf-8?B?UlhJbXpOaWE3WDAzalZYdVZQOUlpZmNGUFV0Mk9TekN1SlRMcGF6Z1FIelRS?=
 =?utf-8?B?bURsRDgvSkltV1d1TXpvYjJKLzZObktJc1NIWUx6MVFTbnhVNk5wSE9Hamx5?=
 =?utf-8?B?eUUzeHBXWC9aWkdQL3hDanVCMVRwRGY4M0Y2NmVGTTdXbXZFdk9tNFQrM2Jy?=
 =?utf-8?B?WjBlbUdvN3Y3cE9CMXZEZnozVFpaeXdhK0JOWnRPaEpCT0RVWUZLR3VmOFBo?=
 =?utf-8?B?MWRXcVkrRmFYK01rSnBrSkVyeUZYN0llRjdEYVcxeXVJZWtkVnRZbHY0N0pw?=
 =?utf-8?B?Z3NhRklHRmZmZ2REdk8ya1ZFQVJxbFdzL2FSSnRXNTZ1UnlCU3dVR1dwSk4v?=
 =?utf-8?B?NCtFQXNBb3drY0UrMEQ4RFRiYUQybktsUUhhSDBqM3J1aVhsUWt5bU1hUldy?=
 =?utf-8?Q?M0OgAo/mqVA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmNybSt2dXI1dTV5TUFXd3FZL3VZMHZPQW1HZzJWc3kvS1c5c0x0Nzc2MzNV?=
 =?utf-8?B?TURvbGlZMnBjOG1ENTVxTHNPQWk4YVFDWkpJR0kyU3JRaGJLcGVFQ25QakZO?=
 =?utf-8?B?dnBrUnl1YVFIVUtzZ2VmaGMwZGlCZDZ5aHF2ZmxRZVo1Mmg3dDgrVmM5RWF6?=
 =?utf-8?B?RlFSYXppZklXNDV3NjUxbytRYmxwVDlpa1E3ek1OOFJRNFZQV1VKUUlzcnF4?=
 =?utf-8?B?NnhDNVIxb2JUR2Z4UVNLaXdJL0JsU25hV3VFLzVSdktDT0NFOXVTMmdoUkli?=
 =?utf-8?B?NFRkL0hLQWZVWkFzZ1IxQ3BkOEgvYUZGNFRFYjU4T1lJcnpzV2ZwNEpkUGhk?=
 =?utf-8?B?cFlqYXpxRjNlY1NCZjdFelBsV1pzOEhKOTlXb1hheHUxTEI1NXFreXNqUW9v?=
 =?utf-8?B?U1J3U2xpVkx1N2NZV0JpM0dJemEwMlpPelMrVldjTXJOQTB2VXM5UEhKQmhS?=
 =?utf-8?B?L3AvekJoQnNuVkZxVmEwOW80YlhETDMvbmsvMzNVUS9VQUxUckpCeUFxT2NO?=
 =?utf-8?B?YzdjdUxNV3A0bGdVMmJOUTMwdWlVZmcxaXkvSDN3dDRXMkRhbVBnWTBySk9I?=
 =?utf-8?B?R3dESlhKTFJYeGJUc0N0VWw5eTA2RlJ2SURrN2JNdkwxK2F2eWN1dWdOUWlL?=
 =?utf-8?B?WWxiR09aTERjS3B0V3FIYmVWU2hLejkrdGlTZHhEMUdNRXNSRldHRjMyZGR0?=
 =?utf-8?B?WDhVSS9oaExvbm9uWXFybDJxRldQcHpDdkY4NlRQYXdaV0ZMWGttZ3hEN2RK?=
 =?utf-8?B?dmw0M3BBV0ZRR3NDT3VOQkRzeldJMzJ4VjBYZDkxT09FQXBrR1BmeFE0Nysy?=
 =?utf-8?B?bGJkL01Ob2JQRXM4TnUwNEgxc1IrR2NSVG9jdThDR1lRdVBaTVNTM2NSYXUw?=
 =?utf-8?B?UVhrV1NWNFM0TEdVcExNajNhZTI0TC8rWURNWXkvZ09OZlBucTd6aWVHTjRP?=
 =?utf-8?B?T2dCUUpmYTc0NEE4SEVud1JIS0RKbzZ1RkI0WldyZTJlT2J2SHBxYWdtZnFi?=
 =?utf-8?B?ZW03NVp1dTl0VzhyL0tQci9EYlc1TXVRclhUSW9Qd1dDK3BBYlBXMVZzckh5?=
 =?utf-8?B?TDlqdi8xQTJ2bjNLMjEzZU11QUlFT2c2U2R1S1ZEeXU4WUIyWktmVHp3WjVU?=
 =?utf-8?B?SHVkSUl5cFhPY0pBZlRWZFZFaHB2U3BzZ2UyUmF2cmxDZWtnMElwYysyTU5i?=
 =?utf-8?B?ZS8vbnplUDVmZGdGN01MMVF4OHgycHRiOE9kUy9CZFQ2d01OUkhNeFRmN2xk?=
 =?utf-8?B?c1kxK3JFMTVIQjREcFZnNkNPZkFuenJGOHYrVkFpRnNORUFIRUJMOUQveUlH?=
 =?utf-8?B?d1hGSlNVcVJQWG1ETWwvMlo0SER3RXZjUTZYd1BiQ01oTGJPOWdrUnA2MFUy?=
 =?utf-8?B?bEt0RkswTHoxdjV6R0hvQkcwb20xL0dsUy8wTXV2REhucDZ6RHVHYkxXZE8v?=
 =?utf-8?B?OE9IN3lyWkY5WmExVStLb1FTN3NrRDlqbXlsL044VCtGd1FOSEIyUFhrZXd1?=
 =?utf-8?B?VXdHaTE4QysrMk9ZRFU3MUFEcTlIM2UrWU9HUHVzN2xoSkFLTnQvNGlxUTFP?=
 =?utf-8?B?Rnk2NnJvOFlEcEJ5c2dtNkV1TzJyanlNN1ZUTWpob1dGaitIbTZRSXFIRjdP?=
 =?utf-8?B?MTNOMVJaM2Roc0hGWmltdXlUenBsb041dWlLMm4xVUQyci9EWTdvUHRuRVZi?=
 =?utf-8?B?MzBrUGszc2NOajJoMlZHVDhmMi9uSjByUUFVTGg3VElsN01vZmNxbEpyM3V1?=
 =?utf-8?B?SWFIb2dDV0I4cVAwUzRoNGsrSXhOT2lSQ0FBdC9sWjJwSWttWWJINlkxU04x?=
 =?utf-8?B?c0VhSEQ2dUM2QS81bURjeFBxVVNGUE4yLzRrejdERXJjVUZWSWdvMDJoOU9h?=
 =?utf-8?B?SnJET1FnUkJzSENEZUs2RkhmNTlHekJOUElxd2VNR3g0dElIREQ1VklIU3JN?=
 =?utf-8?B?QzhIRW9kTzErOU54SFA2RGoxTHFmekRERyt4dnpacVZ3M3R6bXREVmt1bzVu?=
 =?utf-8?B?SDFxRGZWTDhyeW85U01rcVJsaFlwTmJ5NFVFeHlkS3Y4Zy9JS1FpaFllMTlL?=
 =?utf-8?B?RjFFdFluQkViUEQ0Zk5uQ2dwUEtKZ1cvQ0xDM1lpb0ZPQ0VLTUtFRk9PTUxh?=
 =?utf-8?Q?HI2nxLb79T4p3mg+r4wbscjbo?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef3d1a6-4e57-484d-4c57-08ddd3e73c19
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 06:13:45.7838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLHPuyuFBmm6eIrUD9eVSJAPlj1u/QmOp2n2HL66vJnaLRQ04lZJ7y0aEkhWuba4o11XZtN8Be57h4Ot6+2qlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB9374

Hi Stephen:

     After reviewing all CCF drivers referencing of_clk_hw_onecell_get(),
I confirmed their corresponding binding *.yaml files define
'#clock-cells' as 'const: 1'.

Therefore, the case I previously described is currently disallowed.
Please ignore this patch. Thanks.


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

