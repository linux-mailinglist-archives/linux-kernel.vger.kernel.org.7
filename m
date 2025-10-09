Return-Path: <linux-kernel+bounces-847006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AF0BC9A43
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B85D84FC1B2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812DA2EB84A;
	Thu,  9 Oct 2025 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b="yVkTrNiD"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022116.outbound.protection.outlook.com [52.101.66.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6BDB663;
	Thu,  9 Oct 2025 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021483; cv=fail; b=G4wW/YrcQfNlqv5+ZXKzlzzLholcrv4PrQe4OqU72hYApjQ2FTV1s8Z2VM5p0mMaopxdIQprwFQUURipUR78inRfY9QgnnQDwwcum+PJx9oOEil9D1gZnuJUWeduaS42/x1f78zKwRVqZmHwCWIZQ34iM37qBsvXnWIcEjYbyDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021483; c=relaxed/simple;
	bh=3NUH4HiRk1TrTEFHmnmybqWHQgFsX5Pkr0MTsI7sEp0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f+Tizyjt15Ry6NLHEtsq2KLyY90bDtBzCkQR7YkCIma99yg02lmH+Ajj5lxRaWO6+7lZ+vbOX2bSjJlH3FXR7GWlfJMi2QRhxjBUh2ViGd/2IzEmaVPN4Qysqli4JdKdIl6xdJ6f2AFk7UBoN/Go9/a9FCXeMA2k9dinYe/WGzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com; spf=pass smtp.mailfrom=gocontroll.com; dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b=yVkTrNiD; arc=fail smtp.client-ip=52.101.66.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gocontroll.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQIavBW8959YnNyExOe13hg8S1C61zxPU5izjAL3VnLECO+iEtfthb3zyX7OVw8hWqjHcuXA3j2yFDJEN1AHNGcfzR9MKFJtRgIu046UxVDEHIRbp4/xs9Qo86ONwJhJOh82/TmWDb/V9IMyXUIraOjLOQPfE4kzoAxvxn8FrUaTrEWKkm1NpHdm/CyKdkiTKgEcWlBSK82y1y2TOFjN5BSxPdvBR6IaxCS8lgXe8w0CtyOu9Al5sEfCExoRWgyJozgC/xApUD42F3RJ2V70Gl3aRqsfrBZ4+byiQLx1CY5r0qAe+3VfluLjLfJ3aFNWm5I6ypujyENPe3aHg6CGrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JY40ky6Ewxot1CtSQz6iFD9HJ0HMncuXAgfv6q8aMp8=;
 b=xOIYSoXW8zbbDKJ3kvGrdJXh3oixITX6odcSo4XN2h1P55KfPJWfLAMso7U8bJyCCm62gVagQhkU5SNUUfJxF1r1TTvjWFgu8ifmE1tS5a0n4QKOFItotUAx4P6eqynoX+GS9GPcyPP0XbZdkuCPUvMFTmdOfDaXcoID5D2UXKNXKT2iH6F7WukkRloPrOJBm2Ts24/3per93p/Nv+vYBCMYn6/oVDA1SQ+3zZhl8o09xVeuYH5kczUkgeJDpW0rgMREbrDPjeTmKHQkYH0HSDmwTe9CMCwvAWwQZukKwTQ4ol2w0gFa84j+V+Nrgr9sQFopNCY+1wkr5w+80w4GZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gocontroll.com; dmarc=pass action=none
 header.from=gocontroll.com; dkim=pass header.d=gocontroll.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gocontrollcom.onmicrosoft.com; s=selector1-gocontrollcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JY40ky6Ewxot1CtSQz6iFD9HJ0HMncuXAgfv6q8aMp8=;
 b=yVkTrNiDY9OmRvMeLz85OeS4oHyI2U62mZ+YqklhpLl40JC5gcx/SoOHpxMoNqVIpwk3mgN6GE5c91Yqc9TLXFr+gXuLxENc6f/hL14ZbVh3kkOcmFHm7arEBkNqFl2KxxuU+h8OzFHndVm0Kz9KS8Me6n/GvLS4LwkRIQrSITmqBNny7psbqUsK4szuTlrmml7YYI0CHw3R44cGRUcrGE5v5kmIE+TmlITYUNFmL40vVtlfTxrhjF6vbDXTvZBvOy3zuloRAEYpxAxkuFhM2e6HrpXjS0CqqvcyoyBeDsBOjZ4q0JvR0ljkMKI26+oVgasSpZWYyPsN4x/7dOGgFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gocontroll.com;
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com (2603:10a6:102:ec::16)
 by GV1PR04MB10631.eurprd04.prod.outlook.com (2603:10a6:150:202::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 14:51:15 +0000
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f]) by PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f%6]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 14:51:15 +0000
Message-ID: <f4354e94-a1ea-4506-aabc-f251f82f5a0a@gocontroll.com>
Date: Thu, 9 Oct 2025 16:50:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: freescale: add Ka-Ro Electronics
 tx8m-1610 COM
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20251009-mini_iv-v1-0-f3889c492457@gocontroll.com>
 <20251009-mini_iv-v1-3-f3889c492457@gocontroll.com>
 <aOfLM9/+S8q0cbsf@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Maud Spierings <maudspierings@gocontroll.com>
In-Reply-To: <aOfLM9/+S8q0cbsf@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0046.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::29) To PA4PR04MB7630.eurprd04.prod.outlook.com
 (2603:10a6:102:ec::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7630:EE_|GV1PR04MB10631:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e227c92-c092-4faa-f459-08de07434bc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wmg1YUNlYXpaT3dXRVF2Z3pKYmFNRUZNZkVTaTU1NG5nbDhVL3E3WkhESWli?=
 =?utf-8?B?aDVNUUlZaVB6R2hxaUN6NUdBUVRpQXc2UXZGaGVKZmhYaHNHWTBjcVNaZCtv?=
 =?utf-8?B?cU4rUGtacDFOZDkvMW9oOFVjZmtUWUsyVTAwaFpjYnFwTDkxakZIc1huOEsr?=
 =?utf-8?B?Q3lIYmV2NUVCekNRV1hEcXhOQmZRT2RvZUlMaE1QcXFBVkYrbHU3ZXQ3UmJR?=
 =?utf-8?B?Q29iQktMV0piYnpIZ2g1cDl6eFFPZkxqdkpkbXZZTzJPV3BMeVB4REVsMnJ0?=
 =?utf-8?B?UE1QTFlNRFBpZlc4YkEzMHdyYjR0NnY2OFFyVE1OTkRtSTRnMmtJOCtDQVVr?=
 =?utf-8?B?dVFuLyttMXY0UTVWaXFLQWpCOEFrS0tnUXVMUFRCazZoYUZjV3RWSmNoa3Jq?=
 =?utf-8?B?V3ZKZWt6bmczQXBMV2lCNk9WbVNuUTNkd3hGa3AwN3VIb0Myc3Vub2NOR2dw?=
 =?utf-8?B?RURmbGY5V3lzZ05CT21LZ01xYXB0bmUzd21DaXRRMTBLTTY1SWtFbVNLN0Ry?=
 =?utf-8?B?bWJHeGF4VmlOWklKVnpyR0RTWFEzZFdGZnpNanBNbFZjeVBDUHlOMDNXVkk4?=
 =?utf-8?B?TGNISkFSYnJkbGxoRzBLd1g3eWpNNWtCREIrWXJFQ0hMUGppam1VNU1NR1ds?=
 =?utf-8?B?cXJ2WG8wOTVVeCsvZUtZcmFiTDcvVnFubTc2cDNuOGo2SGIzS2RzeXdwV2dR?=
 =?utf-8?B?NkFwZTZEQzN3bExURDlRM3k5cG1hRDBjTWRaL3o3aEcrTzZKODRhcnNZejY3?=
 =?utf-8?B?WnlaMGxLUncwVGNSb2VDZFhqSjNJZW9odEtQNDg0UnR5OThZR3RYU3haR3dC?=
 =?utf-8?B?VFgvRER6K2E4VnFuUG42WFczWEpDNzBnVmxoeFU1WVZmaFhEV1RVMm13ZHhh?=
 =?utf-8?B?c3FvL3J2WEtRMFIwclZFZWhRak44VTlML2V3Z3BSMXp5Ulh5a2NvZ3hUbXIr?=
 =?utf-8?B?ZE9XQXo0YjJPcUQ5WE9uTFFtQ2J6Ykpwb2V5aVdPRGh3dkZjcGZmSWZRQVJy?=
 =?utf-8?B?NW44N0ZPalloSXh0Q0VkdHdLNzlZajRpci9WZDhWT0xGcmkzM1ZOZElSSUx0?=
 =?utf-8?B?YVhyRHhHN3NIK2wrb2NlL1lEM0Q0R1pqR1YxSjNQVWcwY0dybTJZTVE0UTk5?=
 =?utf-8?B?NDVKdkxlRDkrUHR3ci9paHlpRjQ5SjcxcG5ZNkNIZjlaclNIVFBGU3V5M2pX?=
 =?utf-8?B?Wkx4bVFvd3dhUlZZNjRQTCtjRHBwajdXcDNZb2E2TGQzSDdXaisrdmZxUFZK?=
 =?utf-8?B?WUxTWHo4Tms4TTNHTURkN3VONWd0V1QyWERDNkhZZ2ltYVVIMUVIcEZWd3RL?=
 =?utf-8?B?UUJiNjJpSVhsQ2tJRWcyQzJlUGw0Z2hlRmttZ1Jyb21vT3kvM1ZiZFQydk92?=
 =?utf-8?B?UUlKMVFjUnhqVExSQUl3KzcweVY5QkphbWVUTytOekhOZmJHS0ppUEtYVEcr?=
 =?utf-8?B?YXUvNGR2ZGkvczUvY2lsWnZ3OG9rT2FQWldGSTNQMnNsMXFOUHBXbXpabWJ6?=
 =?utf-8?B?ZWpweEtqb0pwK2RzZG5ZVmJLdGVJUXZ3U29TdG1oOTU1T2pIYk90SWdmVGNB?=
 =?utf-8?B?WWN3eTkzOXRDYUd4VlczbDV2RlkxYUZ6UkdWTjYyTjJpTjFqRmJEc1Y2T05J?=
 =?utf-8?B?YjdWblV3Y0paQXVIK3ZYWk40aGFsOWhQSHZsUk1GVHBxbU5lTzJ5SFJISnJL?=
 =?utf-8?B?Ti9ReUNJWWN4RDVMSkN1SkxFY2JsWWdrYTY4VkJIZUJBUFgrZzgyb0cwb0dM?=
 =?utf-8?B?VlpJZCtkWU1IK2EwZnlQUmdiQUtrU1RVeDdXbGNZblpEWFZZVWJtRG1SMDZM?=
 =?utf-8?B?UFhVenFERDZqTXQ0L0wyV3IzdGZTYzhGeFV4NmVhaklBeDBFa2IxTS9vV1Z0?=
 =?utf-8?B?bGRHcjNUanFicUJUQU52cGlNL0FTRVNQaCt6RjVKOXlNdEo0czN2SU10d0lx?=
 =?utf-8?Q?OEZ9WKF7j9kBl6LqLUwqdmkW+Q6d6yzA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFNmb0JYWU9sOTNvRlhKRVg1aHBBUjJ1WE5YcHRucjd1RzVNQjV2STZkSG4y?=
 =?utf-8?B?RTJjQ1pWOTRTK3RZQ1hzZSs1K2cvOVVWOXYvR0twNFN6Rms4SEFuV1Zkd2x3?=
 =?utf-8?B?SDBRM25GVVV5Sm1nZ0V2T1A3cldmd0loYmt2enBUMjR3MVZSYXZPTkhyWmpW?=
 =?utf-8?B?bVlUa2RFL2V3N29URllHK3Z0L3JDUW1yTnNTcTR4anFiRldsSWJ0TzMrREs5?=
 =?utf-8?B?b3hvZTRkQU9YOEYwdXpSaER2MmxSa1hLMmJFMTVjZ0xxL0l5aUFvRktVSmdG?=
 =?utf-8?B?ZGVKbjRGMnBpNWhOZC9DMVYwRFNiSmJzUG9tbjR0d1l5RkVVVFVveGlya1BM?=
 =?utf-8?B?RllieHF5L3ZlTHVXdVFFdUM1Y2E5ZzFXeEpqcnNXVkRQa3BxVVQzanlaSWxv?=
 =?utf-8?B?WUhURHorTTdWRGgwSzYzdm1HeS91Zks3STQzVVFuMGkrOGtJVnBLTm56RU1P?=
 =?utf-8?B?MzcvWlZnS1ZFbWFyMG9HYkladElSNHZKa0NLZHFuNWJxTUdGV280bUpRSHZ3?=
 =?utf-8?B?ZDJTVVF4QVRMRzVvUENTTmFjbnZ6M2tzK2JCZHdqMjV5NmM4UEFISWVUWHJD?=
 =?utf-8?B?ait6ZTJheitnOW9lNjc4dE1EL0grSnhtUkhkYkJUK2FIQU03ZWJXdDJodlJO?=
 =?utf-8?B?ejhRTUtCZ3puZjRka0VWaWhmK2RHaFpQU3hoaW9NZGFoWG1hZ1dDekk3d3ky?=
 =?utf-8?B?YkszWFNNUWRUTUFvVkpIeGN5d0FkR1lmWko3akpXNUZ0Qi9LR1FtaUh2K2RI?=
 =?utf-8?B?NjRyeUNpNmI1Y1YzcnVpUGhNekdoZE9pME9GVUR6blQ2a3FyYWFxcjVMb2o0?=
 =?utf-8?B?bHFRWFpRNlh2eDVGZGR6bTBqU0hBbUE5MGdHTjF4WngrNzJBM2NrS3ZlOU52?=
 =?utf-8?B?OThRZThELzFRcEFMWFJHQlluYThzaWptL1hnZC9kQk05bTVpQTdLU1BKelk0?=
 =?utf-8?B?M1VOUE8veTdxTG5YR3hPYVB6OVJ5NzE2VEVIeU9xMW5ieE1yazM4TUcvQSta?=
 =?utf-8?B?dm1LalpqRU1qc3BRZms4M3FrNS9rMVIwVCsvN09OdnJRQkRXbXhoWjRxeWVa?=
 =?utf-8?B?WUNERnpucHZCMjJ6d2l1QU1NRUlZbXI1SUx1OEJsN1JFUVBnM1VCUDBFUWlh?=
 =?utf-8?B?Wk44cmttVUk0UDlyRFRaRVYxaC9ES2xZL3RXS0tqYjdmNzl2SXZzdUMrek83?=
 =?utf-8?B?dTlKOXZINm9mZHBweURodnU0NzNubG9ITTh3QzNUa2dUZjF1dGx1bWI1TlJT?=
 =?utf-8?B?OHVIWTN4QXYrNlFXbXNJVkl5UFM2RUEySmFJQTZVQzBxanhidEZnU3lJenI1?=
 =?utf-8?B?dFg3TlZSaGVSSTJZR1R5bCtVaFJSSlp4UXZ2Yk9ldzh4VFhTdCtVUm9EblJq?=
 =?utf-8?B?UGtXdkFIR2NWMUxyOXJsSEhCSXlpdGdldkxtdWEyS0lkbG1VckpKT3FqMzRI?=
 =?utf-8?B?TlhUMzRBTlEzRCtLSFljT2F3alhrSjM3eFZqdVVaQlgreTFxN3lLSEh5TzA2?=
 =?utf-8?B?bkZmMUN3QjlxK2tOODV0OXNNQjRUY29qY0t5Tk54bzdueEVLWnUxb2lRNFFJ?=
 =?utf-8?B?d3pLSzJaU3NEVUhlR3NPUDNjV3F2Y25FQUtHRmt4ZmZUV1VpdTc0bTk4L2Ix?=
 =?utf-8?B?aTFLMHQ4WEFuQ3FnVkt2aXZmbmhRS3lZdFNmRG80SW5NNW1BUnp6RHcyMm1B?=
 =?utf-8?B?Qk4rVkpFd3VDdmNQMC9rcSs0WjBmeG5FVmpHNmR5dHZjNWU1M1BoTElWeElK?=
 =?utf-8?B?VmlhNUtCbm9mb1VEai9KRTF6bnlvWTJVbEQ2TFEra0I1anVGb3BYMWhjTVpM?=
 =?utf-8?B?bUgrUll1U2ZveHl5M2NhTDFCSlZhdFE3ajNBZmhZWldiVllWNEpDK0YyMWJp?=
 =?utf-8?B?UTg4L2hYL2QwSnprYTB2SE1QbE1RRXZPZGc3RFNKOVBZQ3FhU3I5cnJpZzli?=
 =?utf-8?B?SEtFRG1DZGYxK3VsUlNlWEJZZkZmWnBJMXpDb1hlMW4wQW8rY2dZak5vejd3?=
 =?utf-8?B?RmhnK3BleG1NUzBrTXFsTWM1SXlVK0ZGQzhhMk5vV016bmNjNm0rcFVVTlB4?=
 =?utf-8?B?YldQZmpWdWhlQ1kvNjBNaGJsREltSzJBYzdLZG5iQnBtOUM1cmxmUjdnWkh0?=
 =?utf-8?B?cHJ6WDcyclRidk9ybU5UYkV1QWpNakE3K1J3dldESzNmSjd3MHpsZjJrTGxB?=
 =?utf-8?B?cnNvM0txQzAyUjZOQnNxTGtHZjNlR0YvbW1hSmF4SWRubUhlTzRVUmlQNjNL?=
 =?utf-8?B?Nmx1bXM4NlJPdXl4T2Q4ZjAxdkd3PT0=?=
X-OriginatorOrg: gocontroll.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e227c92-c092-4faa-f459-08de07434bc9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 14:51:15.0287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4c8512ff-bac0-4d26-919a-ee6a4cecfc9d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4ryS7jD2Iwgj57S48hOoG/DJwFFcwD07l3OgkV7Brgvv/Wd4rn589wYbrqicfWX1XwWejMRw6OTMp/kGg9r1rQTGMyo9CphnwJIPHXTZZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10631

Thanks for the review!

On 10/9/25 16:48, Frank Li wrote:
> On Thu, Oct 09, 2025 at 12:54:19PM +0200, Maud Spierings via B4 Relay wrote:
>> From: Maud Spierings <maudspierings@gocontroll.com>
>>
>> The Ka-Ro Electronics tx8m-1610 is a COM based on the imx8mm SOC. It has
>> 1 GB of ram and 4 GB of eMMC storage on board.
>>
>> Add it to enable boards based on this module
>>
>> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
>> ---
>>   .../arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi | 562 +++++++++++++++++++++
>>   1 file changed, 562 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi
>> new file mode 100644
>> index 0000000000000..6ed86b10c4310
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi
>> @@ -0,0 +1,562 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> +/*
>> + * Copyright (C) 2021 Lothar Waßmann <LW@KARO-electronics.de>
>> + * 2025 Maud Spierings <maudspierings@gocontroll.com>
>> + */
>> +
>> +#include "imx8mm.dtsi"
>> +
>> +/ {
>> +	reg_3v3_etn: regulator-3v3-etn {
>> +		compatible = "regulator-fixed";
>> +		enable-active-high;
>> +		gpio = <&gpio1 23 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-0 = <&pinctrl_reg_3v3_etn>;
>> +		pinctrl-names = "default";
>> +		regulator-boot-on;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-name = "3v3-etn";
>> +		vin-supply = <&reg_vdd_3v3>;
>> +	};
>> +};
>> +
>> +&A53_0 {
>> +	cpu-supply = <&reg_vdd_arm>;
>> +};
>> +
>> +&A53_1 {
>> +	cpu-supply = <&reg_vdd_arm>;
>> +};
>> +
>> +&A53_2 {
>> +	cpu-supply = <&reg_vdd_arm>;
>> +};
>> +
>> +&A53_3 {
>> +	cpu-supply = <&reg_vdd_arm>;
>> +};
>> +
>> +&ddrc {
>> +	operating-points-v2 = <&ddrc_opp_table>;
>> +
>> +	ddrc_opp_table: opp-table {
>> +		compatible = "operating-points-v2";
>> +
>> +		opp-400000000 {
>> +			opp-hz = /bits/ 64 <400000000>;
>> +		};
>> +	};
>> +};
>> +
>> +&fec1 {
>> +	assigned-clocks = <&clk IMX8MM_CLK_ENET_AXI>,
>> +	<&clk IMX8MM_CLK_ENET_TIMER>,
>> +	<&clk IMX8MM_CLK_ENET_REF>,
>> +	<&clk IMX8MM_CLK_ENET_REF>;
> 
> Need align to previous line <

oop yeah thats my bad.

>> +	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_266M>,
>> +	<&clk IMX8MM_SYS_PLL2_100M>,
>> +	<&clk IMX8MM_SYS_PLL2_50M>,
>> +	<&clk IMX8MM_SYS_PLL2_50M>;
>> +	assigned-clock-rates = <0>, <100000000>, <50000000>, <50000000>;
>> +	clocks = <&clk IMX8MM_CLK_ENET1_ROOT>,
>> +		 <&clk IMX8MM_CLK_ENET1_ROOT>,
>> +		 <&clk IMX8MM_CLK_ENET_TIMER>,
>> +		 <&clk IMX8MM_CLK_ENET_REF>;
>> +	phy-handle = <&ethphy0>;
>> +	phy-mode = "rmii";
>> +	phy-supply = <&reg_3v3_etn>;
>> +	pinctrl-0 = <&pinctrl_fec1>;
>> +	pinctrl-names = "default";
>> +	status = "okay";
>> +
>> +	mdio {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		pinctrl-0 = <&pinctrl_ethphy_rst>;
>> +		pinctrl-names = "default";
>> +		reset-delay-us = <25000>;
>> +		reset-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
>> +		reset-post-delay-us = <100>;
>> +
>> +		ethphy0: ethernet-phy@0 {
>> +			reg = <0>;
>> +			clocks = <&clk IMX8MM_CLK_ENET_REF>;
>> +			smsc,disable-energy-detect;
>> +		};
>> +	};
>> +};
>> +
>> +&gpio1 {
>> +	gpio-line-names = "SODIMM_152",
>> +			  "SODIMM_42",
>> +			  "SODIMM_153",
>> +			  "PMIC_IRQ_B",
>> +			  "SODIMM_154",
>> +			  "SODIMM_155",
>> +			  "SODIMM_156",
>> +			  "SODIMM_157",
>> +			  "SODIMM_158",
>> +			  "SODIMM_159",
>> +			  "SODIMM_161",
>> +			  "SODIMM_162",
>> +			  "SODIMM_34",
>> +			  "SODIMM_36",
>> +			  "SODIMM_27",
>> +			  "SODIMM_28",
>> +			  "",
>> +			  "",
>> +			  "",
>> +			  "",
>> +			  "",
>> +			  "",
>> +			  "",
>> +			  "ENET_POWER",
>> +			  "",
>> +			  "",
>> +			  "",
>> +			  "",
>> +			  "ENET_nINT",
>> +			  "ENET_nRST",
>> +			  "",
>> +			  "";
> 
> I think
> 	 gpio-line-names = "SODIMM_152", "SODIMM_42", "SODIMM_153", "PMIC_IRQ_B",
> 			   "SODIMM_154", "SODIMM_155", "SODIMM_156", "SODIMM_157",
> 			   ...
> 
> pack 4 lines to one line to help readablity.

I followed the same pattern I used in imx8mp-tx8p-ml81.dtsi, but if you 
want me to change it I will.

Kind regards,
maud

