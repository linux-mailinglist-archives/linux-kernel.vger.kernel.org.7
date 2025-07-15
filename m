Return-Path: <linux-kernel+bounces-731895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCD9B05B90
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC07743DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ABE2E2EE9;
	Tue, 15 Jul 2025 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="R/Q5FImn"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94332472AE;
	Tue, 15 Jul 2025 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585613; cv=fail; b=IaXw94oPT51qlZxDG4MZNr+YUZSYZPuZ3RFQjLfJIhnMU4yMMovVu7UxASVlSGbvHqDetCdSPtLZ4xCj55nIA5clO/Je4HEip+fLohQexAkaa6txGjMr8UtsNCcRgw2vwnSuns5iaUWfXtMOa/k10ijGwkKHqHhX+tt8h3p9B0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585613; c=relaxed/simple;
	bh=XFL7uVTEN9eNhsV5c+0d4gtjojGUFuoCWAKrEH02KqI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WPriuNI4ucCkV97FfXWYNiPtnG159v7XxrIRUxE5nmFLUW/HaJInvn37aRM9aLHzAjyThdReQJH9D8cPUAAvS9oXQ3BK/0cqdJBmH96mf1BHeq3ioUPmvIp0HSYf0sHVLHrMIX/O4TGBL/aA4d+91g9ZoGCzKs+Cauv/+HbENT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=R/Q5FImn; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjLNpNsdqfQZdTCnmQh6jDe8hYU1RCq3Yvzw130hr146+YHc21l0rJuZ4B2DMcwS88TaMC/nUZeLw2FxD7ghvUKeM+CmPZbXdj2zkUrr0QUQLanYDXQYp8JVJH9mBWc3wVFoVVditLC8T9IjHWiRkEFWj/Gi2ISrrjaiMxa183ibMgxrOZ78keScjJI+6rmlNNmaN+j+0q9+vS+jEnRcqxRGcI8chJ5uwTPmMY3rX0T3ceC7sZYVWBjIxov+Sn1pSsd4v5dtkaBWX5x1Qqof8alBoajrYmHhdvFxO4JCrEo3A4vzo29jqxykr9EDaeeD6UaY3ycHv+fKuFcyYDu6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IS+Lj0iXgPRlhF9dBqEI89RYbEHMr5f5UM3DfvpGAw=;
 b=uf0B537HJ+EaUUSu0+lWQS3bwMda6gG89mAFELwRSEpXYQSSSpuz7zeNVyUwGyRjtVz63shBcTfODJdusdJBBg5QrA4t6ygnXiB0yenhoQrR4B9/AjMqpTEK68Z1RRZ3MHTNMpuqObVMhpZuFsM//Pdyvu8YoCWToTvY41ux+myv+tF+vM89TSde4f93HoYxlBMUQ2dqBMgKUFmNGOtIalMMHle7D9UmP8Pdr7HlWs5pzWP0FRxOrehzzTnTCVULt24KM1Nr0No2LWgsCevcWD15gE1heL6aKp64su0tB5X6oGx7/QeI3f02p1GyPAxZT6WinM8VCQu1lCsbte+rzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IS+Lj0iXgPRlhF9dBqEI89RYbEHMr5f5UM3DfvpGAw=;
 b=R/Q5FImnTUQZDy4AwfmWco4/VyrYKNm/AjiUkLbhp5McL1S/ipP3Gp5zHikk/mtJTc5Q7Y6PynZaTZF3foNY/l9WeKLY2mZMUDAaKqTrAsFchF5Vl8s9XX+9QCPe803jvT2XKNVhiL+VnQT8ngGeaZ88+do8cUSqeUCVNLXGR18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VE1PR04MB7487.eurprd04.prod.outlook.com (2603:10a6:800:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 13:20:06 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 13:20:06 +0000
Message-ID: <3c1d1e45-aaf9-4274-ae7a-f2082ebe383c@cherry.de>
Date: Tue, 15 Jul 2025 15:20:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] arm64: dts: rockchip: Move mipi_out node on
 rk3399 haikou demo dtso
To: Diederik de Haas <didi.debian@cknow.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250709132323.128757-1-didi.debian@cknow.org>
 <20250709132323.128757-8-didi.debian@cknow.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250709132323.128757-8-didi.debian@cknow.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0087.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::28) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VE1PR04MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: c181874a-3f95-4240-cf58-08ddc3a24f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWlkZ0ppV2piSTA1YWZaNEtwMlJ4MDdzYjZ4bkREcm0zcC9SeFlSVUp0Qi9s?=
 =?utf-8?B?VmpYTGc3TGRhNm9TSzNSQmJVendoZ1AwN2xZQXQyWmlJV3JtQTBqTkRDTHFS?=
 =?utf-8?B?eXU4NlFtOE9KaVd4cVNSeXlIOTBrcVAvcStZWTFWR2Y1UGw3SmdGUFNTOXFM?=
 =?utf-8?B?VHNLSXFOT2QvbFNDMmcrc05uZStBQkVCeVV2VVVoakZ5a01Gd2xia2U1Q1hm?=
 =?utf-8?B?L245dG1ORkZmaWZwS0RmdHJTS3BxQ3ZQazhxT1RwRmlqZnNBeEZlMnE2dkt0?=
 =?utf-8?B?M3ZPV3RNVS9KTExrb2wvRXhrdFlJMUhtL0UwdlVOaVAvNXJkSmc0TnhncHVX?=
 =?utf-8?B?UEFURTNmYUhzYW1BQXdweFp3cGZrSE9MeXVxdnE1RjFxaGtaU0h4RzJqZXp5?=
 =?utf-8?B?WlViSWpWVSt5cHE0bzZnVkxxMHZqVnk5WEFjZ1g2c1g4VFZYa2NxajAxZWFS?=
 =?utf-8?B?QUM1S1JEaW93QTJkQStFMzE0THV0YWVWZVh4MllERU9UK1NSTElWaWE5Q1RS?=
 =?utf-8?B?VkJXR1AvL2ZibzlkeHA2cWxKV25wRzVCRzZFZ09PLzFLZDBMWW1hVE5CV1Zo?=
 =?utf-8?B?ZW5kZ3RZVWltMzg0YVlRd0k3Z0VQQzlRTmRPWndnTzc2V0g1ZEdETFk0WlVS?=
 =?utf-8?B?amN6SWh1ZEc1NWE3Y2pNNDBlai9EcXdkZHRsTnF5YW0xYXg3S0h2SEpNeFJS?=
 =?utf-8?B?N2tBTU9BS3ZYNlpyVmVqV2NxUzFUcjlLYmtORGJveHVrd09VOW50TWN6Vi9Z?=
 =?utf-8?B?RTRMdGNQVmFTWkxBOTNycnFoZnFKS3V3N2lwYTBtMmkzN25MUVh3MUtGSGU1?=
 =?utf-8?B?WWhhcDhBU0phS09OUGtVczlyc20wVEszUmVvOE1uRTZ5VGVjeU5TL0dmbWpT?=
 =?utf-8?B?U3ZXMzF5WWlPVldtdTNTNm9NcHV5M1h2bkpOUVdQNGRvSDViYzBxdS8rbE1S?=
 =?utf-8?B?RUtYcmd4SnA3QkVwNEpHR1VRb0NpeVlPYncxWVo3ZW5UWW5jWGdvVmIyeTRE?=
 =?utf-8?B?UmptM0MvazdRWHJMZlN2VzA1Z3VVMVFWaGtFQ2hNcldkVEpUcmtVNTF3aHF1?=
 =?utf-8?B?RmZUVkxBZEtnU1UvVnM1dmNaNWlvUkhzdjg1dEpnMm1KcytVck9WZXY4RXUv?=
 =?utf-8?B?S09oMmRnR3Y3YkZ3YjBmS1hCYzZwSzBDd0REVjFZRVI3NFFKSFdOMTFvc0My?=
 =?utf-8?B?VUdxVXAzeHF4bHVxTGliRXRWdG9aYXRsb3FNdnZ6MTl6SVNQVSt3YVR3NlFJ?=
 =?utf-8?B?L0xJOHlpY2I3RVhJTW4vdlhwZjJEYi9WMEl2WnR4ZzRVbVpFLzBpUW9yK0po?=
 =?utf-8?B?aHA1c2ZUNXpEU0p3alI4QWlYYTFEbG9iRlY0U2g4TEhsNTdOSnFFU1dhaFJ5?=
 =?utf-8?B?cm5OWE5lTVJYOEdPZ2lQeVFkYmFTM1JoeThSd1pQLzZ6TGRhcHc3UlF4eWE2?=
 =?utf-8?B?MHh4dVVSMCtQaE42WEZYYUpjVVFtOER3RnVONS9HTUlDYUhMcVRDMlR5ZWxj?=
 =?utf-8?B?TE00M2xjNHR4MUlIazY0eTJWTGwyWlJZcEN1alRyWlVpeWh0Wm9VbjM3Q3hn?=
 =?utf-8?B?eE5ZZkxLNTVrSUt2Tkxkd3VPeW5CS2RSWWdtRDRVWWdDM3pkMy8zOEZxZGN1?=
 =?utf-8?B?MUxYVEl6VjZFUUg1NStIY2JvWGpIRDZqdS9kNERNM05ITWNIeG9zOHgzalRa?=
 =?utf-8?B?eUFvOWtNZ0ljanRxNnhGMTRBNDV3bHdKRG1wU1FkMllqZmxnZmNxWDdiWDFE?=
 =?utf-8?B?bjlnQ3JZOHpQc2ZPbFJUM1JNd1drZ25jakZ6RDgrTEtRWkdrQmc4QmhuZENh?=
 =?utf-8?B?eVc0T2cyblpSYkkzMnJqNUhScnNERE0ySGNMT1dUbjhFTkM0bFkxTml1ejNt?=
 =?utf-8?B?blBSNVQyRFJiQVdQZzZzNHBIb3V6ZlM0NG9nUUlpb3N2Q1hqN3loWU54eGFS?=
 =?utf-8?Q?V1Q+EsyUcJU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2ZZKzVzZXNNaXV4TXRoWFU2eDg4S3B0NW1HSEd3RTIzd2VKRkZHTDJoUkVI?=
 =?utf-8?B?Vlg2Sk51OXUrYkxwUVZ4ekpURmJYakYrOU1WTDk2c1E1eTlteEtnaFBwSkNK?=
 =?utf-8?B?UHRVdXFab2hWUGx4OHRuK3lxY2JsMEVubnNweEhtdjJrWHBEZ01SMW1yNzR0?=
 =?utf-8?B?ZnVuNTdwb294MlVHcDBEY0NHbUVqWFg5d1BQY013eGtLTTVvajE0Q2tlYk9Y?=
 =?utf-8?B?YUFNZzhDM21qRG9idlNoTllSY1VFTm5EV0c4aFhMUys4OXNacU9sYVJsTEp0?=
 =?utf-8?B?TDlzL2F1WUt4emZVOHVmSXdOdXptMUZxY2pMcThmYmM4SEdMcVVYZ1VMdlZH?=
 =?utf-8?B?djIwTG54cWFMVmt5SkQrNGV1NE54ZHd3L1NSRFhEUEZ0VW5GVXA2R1NUT3E1?=
 =?utf-8?B?bGlDalFnRjFjeERoM2M2Ymg0NXRDQ1NRZXlmNkc1N1NVZUJ5dHFidDMyYXpZ?=
 =?utf-8?B?SUVDbk4vMWpERkVoUERTZmJ4TFdvQTR1SldhTGNUMUR1RXRmYzhGeEZabHB4?=
 =?utf-8?B?NENnVmlBb2VjcVhqMzJNb0N4bTNEek03VGhGR2FzRVZuZUJZZ2VEb2NGM0cz?=
 =?utf-8?B?YndTaFMzOFZVZFlWOFEvTGhweWFrRjA4RVo1NmFHUkFxbU1PZXhwcVhTVFdD?=
 =?utf-8?B?OW94ZzJqN2NpNlhlbTE2Mzl6VXRHU3Yvc0tpY3VxcU1kbzUrbHY1RHdPbWRS?=
 =?utf-8?B?d1BhTVJPUVh2UXQxMGlqajh2MmsxOTBVOU5WajAzQzgreUxUQXBJT1BvTmdt?=
 =?utf-8?B?OEdsd0sreHRMb1B6ckhMR3o0RlZXaTEzM3JweFNOcmd6TGtjZmhPc29UV2Vo?=
 =?utf-8?B?K0sxR3hYSE9KNTNPdE5QeWFGaGZ0eXdYNnB0WFNuL2FzOHN5amFYMDgyakVw?=
 =?utf-8?B?SjJBVUdzakMyNUFjNjRuZjFwL3VFUFI5bHlPTmkxTlljakk4QVlaR1ltMDhU?=
 =?utf-8?B?WElnS0hadjc1K3VjdUdNK2xwSlBsRzBGc1hGNCswSzJZR0JDWk1UQ0RqZWRl?=
 =?utf-8?B?V3FYODYyNmRKaTN5VlV6dktmWFJ4dmlCOC9tQmJkTlF3WXZPRFhjRXBmOVdu?=
 =?utf-8?B?QUxNS1lKb09Wc3h6VkxEOWlzWkxQclJlVWlaZHpDaW5za2JMMEkvRFUzVitC?=
 =?utf-8?B?ekF5L25BSnBmWTlXbXlGWmJGYWQ2d3ZhUWlBM0pxMjZtNVB3L1lSSVVRTEdx?=
 =?utf-8?B?aTc1UWMrdWpnbFc5ZnB3SzNmaFM0c1ZSOWdibytHdlIwb0VWVkZXNmJHL3ZY?=
 =?utf-8?B?RWZLekVyb0F5UGVuWGdibWZmRVdxZ0NRMlhLcFovNDM5eHRiZ0krVmh5Si95?=
 =?utf-8?B?b3FLMThBaE5MQlBpNVhmZ28yem9lamZlSVp4am9nUjkxU0tKRU9uMTBuQSt4?=
 =?utf-8?B?d2w4bHA2RjdIaDFkU0YrSElOT2hQUnRPMlpnNERTejdscU1lcytmVno1emU1?=
 =?utf-8?B?V0NaaWE4WkpRMW9SUGRLVXBRaENqUWVsWDY1dkk3QlZQd1VYalhiSHNJd1BG?=
 =?utf-8?B?aWFSeDBrbnkxTlNoWm9BODRCb2djbWgrNHRyYTNhL1ovNXRTWDhTK0dJNitr?=
 =?utf-8?B?VWVwTDBZSkhBL3MzTkFTMDBhbXlPWGVzZ0tZZThGeVdwb0pvQ00zM2RpeUV6?=
 =?utf-8?B?bVFrVm1OMzdwM3ltZllTa1ZzN1plZ0VkdWlBenJQZDQ0cko1YndOUzBYcjFv?=
 =?utf-8?B?cHNaZGN0NzZadVNjS1l5cHFPRWhueTNqWFRLT3FiOXJ1QTg1MVhxbXJzUGRT?=
 =?utf-8?B?U0FsaHhrQkt4dTJDbDFQOCttaG5XRmR3aFI2YjdBQ3RPMWc3VUF0cmdRVmV3?=
 =?utf-8?B?L1NwdGlUOGFzM0FCZU5sMWl2dXhRVG5ITUpSWE9NbGVycjRzcERwRWpDbUpI?=
 =?utf-8?B?a3N0cDBlS28xQjY2YVZJSTFVbTd6bnhXRGx4MXp5QVF1SlVFVklibmQwOXY0?=
 =?utf-8?B?RXRyMGNoa2RQeVViUWduVTJOUVZiRlFrZzhNTzhwUHRObFB6U29ZeHlSaGRE?=
 =?utf-8?B?VTNqL0tmR1dUdnl4bmkyejFtaTFva1kyN21saTE2dlBqMEEwUGhmdHk1eWxl?=
 =?utf-8?B?Nk0wdDk4RTdIZjZ3Sis3NGJNamVocmtqVmR3TEpONDlQUVZYaTBVNjNickNy?=
 =?utf-8?B?K2RaemIzYUM5dWR3Nndwb29ZSDY1VmtVOWxWdnAvQ3loOGdXN0dBR0xRYmdj?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c181874a-3f95-4240-cf58-08ddc3a24f12
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:20:06.1212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCAE8Hh9qqykIVlD2Rj/44hi4qC+0Qq3Lm8RP4FRt71+VHo44mEoozWdMU1k3nAqKWaac/tAijpk0CQ2vtcNrTvLQVWXuNm4EtZCs3l8TMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7487

Hi Diederik,

On 7/9/25 3:15 PM, Diederik de Haas wrote:
> According to the DTS coding style [1] referenced nodes should be sorted
> alpha-numerically so move mipi_out to be after mipi_in_panel.
> 
> [1] https://www.kernel.org/doc/html/latest/devicetree/bindings/dts-coding-style.html#order-of-nodes
> 
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

