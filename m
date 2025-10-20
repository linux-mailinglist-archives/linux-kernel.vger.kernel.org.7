Return-Path: <linux-kernel+bounces-860444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A85E9BF0248
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3BB934A95B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C61D2BEFED;
	Mon, 20 Oct 2025 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="MFLtLtL6"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013012.outbound.protection.outlook.com [40.107.162.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F392E9754
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952147; cv=fail; b=QBbTqfGRJP3TyjkAZriSY85CY/akqTuVbtkunz+/SfSN/4c3WT+YrLIkP45jZ9eU//+Hz1EOMc+y1Igc3arh2H2KHrxx37KHy4By+9qmVJGKjUx/u+8vxexHfa/s1EVV7EPYPNY20SFELgTitcFiMQ9lgcCIp6f4GIQ0a0BByk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952147; c=relaxed/simple;
	bh=LPW6qkj250XxXlxrP45bClE8SddNYONiGXk6CWrmiq8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U1k+8A4JLpeuimS0mL8f3n0ll7+OEsCbXfmB4ZW9IT5hz69+OLO5U/wj400XL7jupJ9ZaHaJ+4VLi7ynzdkSK8+VC4aa0PZ273A1Sx02yVWqJFtZrb1378/OJ/8XwifLc6etd+7wH0iTqmpD3PgcvewgyfYbNPgbd1g8eqTC5x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=MFLtLtL6; arc=fail smtp.client-ip=40.107.162.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNX3WAGa7ihTnzvmzV9MlVWuXjeqIhUluACyrtVEqp7YBsuMkBI+K1z38JyNiSwn8P+6168G8WFYiPn56SBoPEo3LlgYhXadfx5/TBG377atDErTE3I4FmgXgduRpzTbMkjGMbhoOkPuLk018LnhTU6XagUo9FYjvGT5uL5VvN7JDI73PgGzfXBULqXDfiiPQmIgGVuTDppMImqmROpFg+GYHo/ij2aIrer4DtDx2sAdFf0slA1GWdW7qq6OOAARw2mdpBaEoQ/Ljnq6eS4LpvrLKev6sNOL7YK6lvMbwLlqNrfbsC2jaxUnPgW6pc4zS/6MqGcBUouf69H1pAO/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlTGd2OEm56mOieRZbSG7HwjRIxn1xZjgIE0qiIkoHA=;
 b=mpms0bgZLfcR7ln7GsHdvW1ctEcKeC2G565HR5A3XUzpxt0CRmKkZnbHs2VcWVVHZ2Yk8q0Ff26Z0bkZaSUDlXdUsz3U60W46JGs0mTNFm+Sx1/TICnjaRIIxEdLdQo+UFFokUwl2AYGBYj4eLr5g6yIWlWRcPJwJt38jAonr+5Uld2V823QNHFlfIXgYrOzFM36wYBxw+bSaRoEErL2XoPy60ytMfl9qpzVR0Qxzg5m57fLV4eDpFt8gPOZF2/FamoRIVWP1j+IUh/LyivRkjNOn9Qd0ulgTN6F/mm0TnDNp5OeOF1KSWfMZd2WI+PinSp2jByuDGejmF9ECzNmow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlTGd2OEm56mOieRZbSG7HwjRIxn1xZjgIE0qiIkoHA=;
 b=MFLtLtL6HdeYNnMbiGJyu2Wh0Yz44Mwk6cJEh1yRmlDtZ0VVGlXdwcX0x0SWXCJ8ay8LbOSD7Pcw9yG84NYAzaodeiPcAQ10GqqU3bhWy5+B+NYhYrAsRkcLslPr5KYYIH9PXhnFPm2xG0R4fHnWFmL+6xySae/8yOIsm3NIhRI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA6PR04MB11803.eurprd04.prod.outlook.com (2603:10a6:102:523::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 09:22:19 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 09:22:19 +0000
Message-ID: <64b79330-5168-4aa5-9485-0e9b34578d24@cherry.de>
Date: Mon, 20 Oct 2025 11:22:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: Fix indentation on rk3399 haikou
 demo dtso
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20251020091139.3652738-1-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251020091139.3652738-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::21) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA6PR04MB11803:EE_
X-MS-Office365-Filtering-Correlation-Id: d7c56b3e-560b-4e66-adf7-08de0fba2aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVFhU093Q0VHTGVHLzZaaW9Oc1l5L2ltc2QydExhem9BdHE5ZmJiUHd3S3J4?=
 =?utf-8?B?L09wdVdzTm4wQWl4WERvdmZ4TlBpUVVhbjJaQ1QxcXB1RGYzdWI2azhpck1y?=
 =?utf-8?B?U2J5cDRjSExhb2ZOVmloTVZoZ2Y5NnJRSEI0ajkxWjZySVlESnZmOUNIV2ln?=
 =?utf-8?B?ZzFwNllyL0tmWlRiQ0F3OXJWbmFlVWdTSTR0Sk9wcDNPSEdlcjBvM2pPaUtp?=
 =?utf-8?B?ZWtRQzk0aERCVi9qTnkreFlBTHF3M2pDWkp6K2NEYy9ZZi9vYzcrWTVmNGlR?=
 =?utf-8?B?QktqeEpHRVdLd3BXeS9vL2hlVWY4dEJLdkxBT1dMSnpTTzg4SkFaa0pwU2Zl?=
 =?utf-8?B?dnpSSnlqelJtZ01CNkdVN041T1lpNVZxOC93dndQaFlWZ3JWSzZoUGhWeG1Q?=
 =?utf-8?B?V2R6VVcvaU5SL0tVMmd6aG5xQkRuUWtVSmM4S1l0YWZhSFkweit0cnA4T1Z2?=
 =?utf-8?B?Q0NtQzVLNFRUZndzM3NBZDg3aHNXRVVhMFNud0doaW15d29xTE5DUzFVWW5V?=
 =?utf-8?B?ekN4TU5mWTZmTWlRUWdxZ1BqUE1sUVhUQmN0eXdLUFVkRm82NlhvTlhTczFG?=
 =?utf-8?B?RmR2Z2tlSHp2Umc2MHBybHh4ZUpZTTZHd01CTlNKeUFaVmdyOEUrNFdNS0dp?=
 =?utf-8?B?RE5YNGlTaStBblZDMWlvUjgvZlhSOGt3cXZnWnhpQmFsUDJxd3dVRlU1d293?=
 =?utf-8?B?dlZuL1pxbXk1d3JpZHVyekV1VEhxOGtmci9CeG5IU1dBWG5FejJlQlBKa2lH?=
 =?utf-8?B?TDdiRG40NFJEUE5WZjMwdCt3SzJjK0VPV3hWaDhyeUVQYm9YcUFDZjdJRDY4?=
 =?utf-8?B?RW00ODF4YmtHbWVLOFJaOG5CdmVRQVhtckhwbWRuSytjb0NPemtwTGJoQTZH?=
 =?utf-8?B?NWI1T1dJbVo4MUNQdHFFemtieXIwSnVvbW92RHZuQzdNYkNSL3cwNk9IcnM5?=
 =?utf-8?B?ZFVFMG1QVDNKREJlL21nbUxmd2xMem91eTlQZHdhK1lvN04reVV4ZkZKRWpF?=
 =?utf-8?B?UFZvVVhkSXNTVC9XOVh5dVlraTVlUStYaWRpcGppKzBkTzFwVEZmSFhUNmRW?=
 =?utf-8?B?cmx6TFhtaDhJUEZrRnNIcmxma0FURU4yKzVMbUJZZWRuRUFlNWlZak4zaDlW?=
 =?utf-8?B?S0lxcm5rSzExR1ZHa01YKzUzR1NPZ0w0aktBR2VUYnEyTXd2d0pMRFdrSVlv?=
 =?utf-8?B?bXBHUmZ1VUlScDNUOXJ5SStIRWpKaUNXZG9zQUpjMDZ5SEZYQ0p4by9EL01T?=
 =?utf-8?B?NkN0WkNiajlFTEcwek1qdXY1dmFDVzFXVUorcS94emVxdkFBQ3JCUXIvMXhw?=
 =?utf-8?B?Rys0amxkQVJ5anhJdFpCN0hLYkYwSzRya3R1dEZUOGJTb25nM1NCbFlHNU5Z?=
 =?utf-8?B?VHI1VlAxUkVzVUt6OEJLZGpvTytEeHRaeHZyVTN4OGdrMnZLNXVZWW5Cblc3?=
 =?utf-8?B?RmdPZUIwL2VHVkVzRitBZ0FBcWtXcDdJdFF1Nmw4Z0RnTTV4TUR5R09qWUVW?=
 =?utf-8?B?WkQyejN0MnpJMGlQRFBxZTBTTldpQUVBZzJjcVA4NjMzaFVkUWUrbzZXVm9o?=
 =?utf-8?B?NXBnVk15UDdzSmxvV0wyY01oQm9UTk5NaGF2ZjZ4ZEhwUWQveGlOcWQvZEMv?=
 =?utf-8?B?RVYxS2pXYTBPNklvSkFmaGI5ejVIckE3T3R4dzF1UklXamJzODRCNGk1RG5Q?=
 =?utf-8?B?Q0pMK1VjdzNjSE9jRTduYmloZUgwckdqZWsvRTQ0aWpITUNVNUtxamVuMngz?=
 =?utf-8?B?elMxRGRDM0RHS0JjbC9ETnFGQVQ5UCt3NHU0SWpvYTdDWE4zU05GcHhpb0tD?=
 =?utf-8?B?MmkwdWpvVVp5K2FVQm4xM2laODl2YWtYV0NoL3k1N09KSWV0OWFadEs2Q2cx?=
 =?utf-8?B?ZDROeUViS0hVL1hycENJaHJUa1IrWkRqL1d2QTBxZ0luWlNPeWVxNmhvZXYx?=
 =?utf-8?Q?M/4UO51CqBE9PoKmaEE1P+y1LQXJBDyL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU1Bam1oM1NRb3hZZ2ZHMnZ5eElIUzcvNWdrOWdORlNvUE1SQzFnY1B1OWZZ?=
 =?utf-8?B?aDBXNnVQT20rT1JKQmxRS2RWdkduaFlOK05LTTdOWFBNNkg1SmZML2lWMyt3?=
 =?utf-8?B?eHUzRmNKNlJtSmE4MWp4cFBpSXpGZW1PMExHT1VKN2NJWGdXaDhmYzlTQUxw?=
 =?utf-8?B?TkZuNEFPaHFCQktjWWtWTnFkSTJENEVRaUJjNE14d0J1SFhRTExDKzMvNzZ0?=
 =?utf-8?B?MjF0aWk4TzhQeTN5TUJQMkw4Myt1Wm5MRTBaZ09xc3hIWXJ1TzJINjlsTTM4?=
 =?utf-8?B?aUZ0TkNBQlF5K1hDY0VZUk04UXlGaFRlNmllWnVwYWJyaUpqWTRwck52VGxr?=
 =?utf-8?B?RDV2eFhkWXJSQlRkK2VFVjRTQ3E1Z0hDR3UzekpNL3JRcUt0aHpOSlZTWFox?=
 =?utf-8?B?d2JyNXFwMFVqSXg1ZlhINjZZQ3ZpQWlVVXREc1NhVENtMGx1RTVTT1k1WlN0?=
 =?utf-8?B?bEs3cXhXRVBmK0M5OExxK3ZVWHM5eWFNK3RWWDNhTDQ1MUxmbkFtMTl6RWpI?=
 =?utf-8?B?dkh1L3BsS1JtNGVHZWhPakFFNFVyZXg0RFcxSCtrTGVQV3dvRVJRK0VNTnhl?=
 =?utf-8?B?MEVqL1NnMUNNaXNjcnVoZzRBdTROVW04NXRyMTQra3hmdHF3dlUxcE1YQXhQ?=
 =?utf-8?B?ZHp1NW1yTTZUK0ZIMzBQaHdaSGRsc3IxU1FuODgwUW9SV2grbXNEM09vS05P?=
 =?utf-8?B?VVhsRFRNU3JFVktBbExNczB3SkoyNE5RbnA3QW9paCtEZVRaSlRwanF2dndh?=
 =?utf-8?B?ZU9wU0VmNllodEJNQjUzendEU3BJMGtzYUtOaWozSGQ3OU81c004N3ROYWJB?=
 =?utf-8?B?NWtXekdDSnQ3YVV0bWlmaTZoV2VmaWVMWlRkVDhGSEFrMVFGRzc4d21EUDgy?=
 =?utf-8?B?VGhxUU01T2xKZ0g5bjJ6Rm43T3BJcWxTV3NucEJOUVpYSE9IZVMyNCtVSldn?=
 =?utf-8?B?b2dWUEhVTFhoRVY3RkpzS2dqWWl4VVJzT1NFMkUzTGhCVC9kVFFVdURrSWtR?=
 =?utf-8?B?Slh3MW1PUFVReWt5VmdSdFJWcE5jUFFuUlhZS3Y4UjJ1c1VWK0xRYlBpSUcw?=
 =?utf-8?B?OC8xNXlTYmhDWkRVdXJobzJXczRsMWhHZG1mODBBOUVTMk1QeHNOQS91UmRF?=
 =?utf-8?B?aklPL3duYllYVUo1UVVUZUcveWs0MUpKZ2p3emVsOWE4bW1QWmJ3ZXR2Wnl5?=
 =?utf-8?B?djR6VkcrZlltNzl1UFB6bFJ1WE1DOEdIUjNqdjJIVVRlUGlWaDFkY1pneWtF?=
 =?utf-8?B?S1IyNjZENVBZaVRjaW9HUXN1TGt5VjFvd2MvMmZjOTUrdCtWRDlHTmwreXRC?=
 =?utf-8?B?RWkycmpJOEdXY2FvbllkZUVuTmxSYVhPVHBrb3NtVEZLM0I5dmdrc0o2dzV6?=
 =?utf-8?B?czRmNjZCcm5kNFAveU1KNzU1Y2JqTTQ0ZmlrUnJPOWZwbkQwZ1J6eGJWUHBx?=
 =?utf-8?B?b2MvYnVQWmg5akZUcldXbGU4TWtJblQ5eUNwOGNLUmJCRjcvL3A1WEVoWEF3?=
 =?utf-8?B?UzlIL2phZjNTRzkxMXQ4b1hTTEFjNldkSlJ0ak1TU3lULzUrajg4R1NIaEdw?=
 =?utf-8?B?YTVScHVmUHFoVnVDTUUyaW9tNHpUM3lQdkxNUC9GeCtWaHF0bXRrdGt4WXM5?=
 =?utf-8?B?UFZpc2xoZGFLLytXVUZSbUdhZ04rR3FoY1AxZ3ZKWk1ZbGVySkVQL0JLdUZD?=
 =?utf-8?B?Zm9RYm92RWliRlQxMzJsZ3owVFd0eWVhTWxETWZTT0xSSE9DclAybFMwdTMv?=
 =?utf-8?B?eXlpbnRlenBRaHdzUHZ1WWFvdEduTHMrYVUvRWljakk2WHZnY1B3VVNwcG5Y?=
 =?utf-8?B?MTlocEZ2N1FWSUlsRDRsU1J2aE15SjV0TUNjN1B0ZzdWbnc1dDZvODRVUGhV?=
 =?utf-8?B?NnZNei92SnNPMXRIZG5sUWxYV1VxQlNBMXVCdlh5Ri9KWXNoZHpXSU1pT01o?=
 =?utf-8?B?UHpOZDFIRElralY0dUdOWHJCaTBLNjJ6OVkyMDZtMG5CMXdJZ2RweW1OTnI1?=
 =?utf-8?B?YUVCUmxUUTFYNGcrL0Jlc3o3OUQyVndveXJZUFc5dm1nYlNZSkIwSWNvbFRI?=
 =?utf-8?B?eUphclRCRVFNNkcwd1hweHd4SGZBT3RHbG4zY09lQmV6dCtKeXhCYXJHQUZC?=
 =?utf-8?B?OUN4eVcyQVF0dnV6U3Zzd1UwQ29EUythWmJaV2RTNG5lNWNwL1luSUdRN1k0?=
 =?utf-8?B?dmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c56b3e-560b-4e66-adf7-08de0fba2aaa
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 09:22:18.9148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82VHfkZ7nTfeyyNPY6fW5h1MBzA1ZhJlezef3bbwe2p1f+22bfIwhfkrMdIE8+EuqrQb67Pt+qdAfp3yPYZzXCt2SM+lRTcMNlxzOT/UI8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11803

Hi Heiko,

On 10/20/25 11:11 AM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The regulator-cam-dovdd-1v8 uses spaces for indentation, where it should
> use tabs. Fix this.
> 
> Fixes: 066a69db9db3 ("arm64: dts: rockchip: add overlay for RK3399 Puma Haikou Video Demo adapter")
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

