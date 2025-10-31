Return-Path: <linux-kernel+bounces-879599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC2CC238B1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6C118965CE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173AE329C48;
	Fri, 31 Oct 2025 07:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b="SopqEsyH"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023073.outbound.protection.outlook.com [40.107.162.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871172C027C;
	Fri, 31 Oct 2025 07:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761895700; cv=fail; b=SU/AdC20WHJk4gk6rvH3cZNjypbI9ThukaTBXd53nEmftC3HgJhMznBZbzOS+mTaPgMQ/7wlFtZy6wK5qOcIKNTLkimMn2WpAFOQZAYHXLanV0KR+LZ6Jus/JANm98yJFm+7GN4zz+oZA+RNhC9GCnzUN8w40KMfFL8kKNB93BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761895700; c=relaxed/simple;
	bh=AOdRWXuNp3K7RWCWroHIfzcdvV3WZ5Ms4IvMP6907ts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pKbiWUApiWCT8LNMZWcHaiLHJEfZQ0c5zGbVUFHfXh0QvxYWGHxb8gWc4m5ITRXL0835RkW9npV7p88gvfqoZ6IX3oasXQNicIJDqO8xizfnFukfnvMVonoit6isMWDVOLjTNCvAYjPEcuDfA5+Lzj3/jEJgMC5iEn3ljeN0YOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com; spf=pass smtp.mailfrom=gocontroll.com; dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b=SopqEsyH; arc=fail smtp.client-ip=40.107.162.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gocontroll.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6+vBw4wlRcNdLTEY3mN2cHgOawqyqY6Zg8s/VY9jiBXBle7AWD+cDyAkX4hFoWB5B0t08FfNJx30eGUCqPYfTMzp5LjWwLUadADs5fOLngazJrdaEElSlIUU6yw843CfKsYMaUGOCKjRZ/g905Ipgm32w3Qhj51q9Yd8gqDomhe7BCeluZ/w5MSgAuMH2OOuOFp2P1CBrpn0RieY77t1n8CAJwyNJf0n51s9JaXFFr1NPtM6d+hPhyZfquG2RtnJkr6XpLGRH0WSiTrHIfBcOiq6WQzDWMftpu8UUF9LQiIec9h1YJ9ewr2O2J4HjD2lKKlooAGw87yMU2GXhFtqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVFO2c2vmxbHJqjmuNj/fj/XYb0HTiBpuM/wqge1ZMk=;
 b=werkHMcPZtUzojPPfQCOReack5C/48wU2ws3rfnX6APRuas8Mlq6t+7U8F9YR+sF2HaQx1HRslcawlB4MeH07/kaNinwaUjnEYspSxidG8BEt+GGGistRu62KplaDk2XlSB7VH1sqS1PgwgF1ORlgj4p4aup3RPFh9MSQCOpNF/6nWgeWMWdsqpSprPvJHWBXbIlEwbfmx77nHDjTtYn/uoUVL9kMsd0TZ8WqDOsnMGih8XBi9I21CP5Z39JN/lzKytGG2fdFHKH5zTBzjKG/x1W6OBwa72QEFPpm8zLgZ2KtcrvFORvZE99JFr+oMja8SYBzOOTKf1W/mmmWL7uWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gocontroll.com; dmarc=pass action=none
 header.from=gocontroll.com; dkim=pass header.d=gocontroll.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gocontrollcom.onmicrosoft.com; s=selector1-gocontrollcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVFO2c2vmxbHJqjmuNj/fj/XYb0HTiBpuM/wqge1ZMk=;
 b=SopqEsyHQsO1TjyfpQsjFqk/p4wLFAGO+iGjXafDtR5dH9GkxqRJ501AG0SIHsHANGYD7/VMV+l0MSaRzGjl5rB4BOAFefB6UJjzTBUatQnGF1AIl00zplQMe9Ut3thbwJRONbX1uh2Oqp3K4W2+PAQwCWaWP31seHqRrA0nmCjc/iWM7Gl3L7C0FvSDwD9c7/YudstIzbA6ZC1TKfRdyoUv8LQaXe3Icz3nbwHqQt1RbRED26cxj6cB8dvSiVXfUk5dIohbV3qiWIlahe9cUCmfIP2WDs/D5NC4eslM5gjOmNbn9aY94e9ZZIOwkWgy7SWRDVlIrimSrxTLURDEXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gocontroll.com;
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com (2603:10a6:102:ec::16)
 by AS8PR04MB8755.eurprd04.prod.outlook.com (2603:10a6:20b:42e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 07:28:14 +0000
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f]) by PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f%6]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 07:28:12 +0000
Message-ID: <d7ca0212-f83e-4da9-bea4-2a987602395e@gocontroll.com>
Date: Fri, 31 Oct 2025 08:26:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: dts: freescale: add Ka-Ro Electronics
 tx8m-1610 COM
To: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20251022-mini_iv-v2-0-20af8f9aac14@gocontroll.com>
 <20251022-mini_iv-v2-3-20af8f9aac14@gocontroll.com>
 <a7012995-c2a8-48a3-abe1-5c227272f21c@gmail.com>
 <65202d1f-6c4f-4d4e-9fef-85cfb74ec768@gocontroll.com>
 <938f85b0-4c9b-463a-960a-f5f4e4092480@gocontroll.com>
 <20251029081138.2161a92a@karo-electronics.de>
 <4a47b9b5-f482-41b6-a441-7728572c5a0c@gmail.com>
 <20251029104838.44c5adcf@karo-electronics.de>
 <d05c62c9-7ed7-46e4-aa4d-27172741b5ee@gmail.com>
 <0667e026-99f3-4233-b3f6-e38273961d49@gocontroll.com>
 <20251030095434.1dc06df2@karo-electronics.de>
 <036a04e1-3cb7-44c3-8836-3640f640b4a4@gocontroll.com>
 <20251031063631.0ea1ec32@karo-electronics.de>
Content-Language: en-US
From: Maud Spierings <maudspierings@gocontroll.com>
In-Reply-To: <20251031063631.0ea1ec32@karo-electronics.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0058.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::20) To PA4PR04MB7630.eurprd04.prod.outlook.com
 (2603:10a6:102:ec::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7630:EE_|AS8PR04MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: bd591516-fb25-4914-06cc-08de184f0c90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWtCdk5ZanpvRllLdTJLcE9rc2NwLzNlQUV4ZFVUTXY5OHhIVjljUnVLTXEz?=
 =?utf-8?B?OCszZUgwbmc1bDZwdklQZW5laldqT01rTGg5V1JJTEhmd2hsUkU2Yk9BTlor?=
 =?utf-8?B?R21PUFlzK3Z2WXZOQ1hzaUIvbFhDaGI5cXArd2lWcnNYaWs3L3dmNUl0eUEv?=
 =?utf-8?B?VzFiT1Y2Vzh1NENkYXF5WHdUMzVoNVl1U1pzRWd0bW4rNnBYY05EQzlNK0Yw?=
 =?utf-8?B?SUxFODRNbmN6L2xRMlFoV3NlM2NEREg0Nk42WC9BMy9hbTRobFFyTGpRWjFZ?=
 =?utf-8?B?bFcyVmM5RHRrdEN6M3F1d01OZFlKazZvRjVVblN4ZDBuTWdVZ0srV0g4UlQx?=
 =?utf-8?B?VWMvd0RleVFJNHhSaXY5Z2tKeUdRcTAwQTNsMUVZZk42b25VSFp4a1JCc2dx?=
 =?utf-8?B?MC85aUtlai8zMW9JbndGWEprN2NxV1hZWG05c1pYeGFvVjB3STVweXR5ejRN?=
 =?utf-8?B?d2lld0huR1pOU285QW1sbWowUUFjL1BkRzhKdHdXLzNJODdsYVFXNDVydTE1?=
 =?utf-8?B?QUVHM3VHaW4wZlcwM2hwYno2cC9jV1RhZ0ZYRVlVejBNWEl1UExCVkVYSm5z?=
 =?utf-8?B?Tm45ZkZYcUNlcmRFQVZHM213WTVhQ1dWditvOEM1VFZabWJ4U1JGd3FvN1ZF?=
 =?utf-8?B?OHJCRmZ6OHRUN1o1S2d3bjR0ZlV4RGh6Sy9LSkg5eE9WTnhGR2Jhdm9rcDhR?=
 =?utf-8?B?V1hEckhNa09uN29JZTJkVGRlbFN5ajY1K1RSME5ZYys3TEkzdFo1TTdwRlhZ?=
 =?utf-8?B?MzM5cHBHQjZOL0RyVEZkOHpUMjFJdU83UUlQVWR2dzhISW5heHc2VzRqNjFp?=
 =?utf-8?B?Uk5ObUNjVkF1dHQxclBrdjBuSWE2a3VSUHZUZUZIeVRuSDN5ajd4UGc3ZndT?=
 =?utf-8?B?S3pWRithTXc4Z1ZsK0NNODFrYTFjV0ZMbzNNSGM4Y1lFWkp3dE1kbVY3L1A5?=
 =?utf-8?B?ejA2dXZYbjg5SjAxd0NIVGt1dzVZd200eU4rUVhtWmlMVGdLSjVNeDhKUCt0?=
 =?utf-8?B?UWRka29PbENuMUdETmtJeWYrUkZia1VSWjlJanlTUWF2b1g4Si9Lc3R5MUcx?=
 =?utf-8?B?YW13Z0pxdTBOdUoxZitKVVNlajRDVmFieTh2MzVLcmp0MnAvYzdudlFib2M5?=
 =?utf-8?B?R0RWWXBkQi9TNEhFN2hnK1pVYlA5Q2xsOGtxY1dYcmtjRHFkMitRUlNIZDNa?=
 =?utf-8?B?Nm9HakRZYkFrdFFobUJKVEk5b053ZktrYzJiamZxalEyWTlSbDBtakhaRXlC?=
 =?utf-8?B?cVlDRWlZeFFQMVZnNDhvY2xmdDYxR3BlQ0ExVThRL3lFSW5CVkl3ODhSdXJm?=
 =?utf-8?B?a2xoZW9rYmpicnZkTHhRNUdwQzNFbEJXbSs2VzdlZmg3dlZIQk5wSTdkYVRR?=
 =?utf-8?B?OFgxbTIxT1hYOGpZN0Qzbyt2d3FBdmc0Nkk1RlR0dnJNRzY1SkVTd1FRb29s?=
 =?utf-8?B?c3BIL2RGL2FwcVVUSC85cU5FRmE4cDZZRzZpUFBKNUJCYzhhaXJVUm53Vm83?=
 =?utf-8?B?QXAwWWJwVDgzMWhheDRDb3c4NXFwVGU5RWVQYStxaUY2dUI4cXlIWDg4aFVk?=
 =?utf-8?B?TTBQcWJaZVpzd2h6bEpjcE4yVm96YXZMT1IyM1JFbE1UQ3hkZTViRUlWeEEz?=
 =?utf-8?B?cjBSdlNGc1ZwWE41OVVwWW1LTUUvMWJOcE51ckJxRHpYbWt6ZnZDcm1pZXdD?=
 =?utf-8?B?Mi91N0RZSEd0T2ZuL2ppS2M0RXpmRjJaOWs5M0UzV3NCZ3ZaSHpjZFUySGtO?=
 =?utf-8?B?Mkxlc2NUS3k0dTdrY2FNNlJlZG1MbndJYzNtODFlWTBBa3kxbUpxOUNLQ0sz?=
 =?utf-8?B?RU1ieEZrQkJjbjhpdkdTMEQralpvWU8wMFM2cEIwVFRTdGxJQ0UrNmh1QVIv?=
 =?utf-8?B?SGp1SWx2NVMvYk9aTk4veFhBQXdmTklIQTdBMDFOdlZzckl1a0FIeW42NER1?=
 =?utf-8?Q?o6k74n9koaz+fLr6gRvvhJQ5U9akStnW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VG1JUjJqRkV6TDk2YmJTVEhSZTM5T2ZTRzdzZ1NoVUJlZWlzZENZMzBjbXBi?=
 =?utf-8?B?NTlTU3k0MTc0TUU1SjJyVVRsamxyNXBmRU9QSW1VdDVPNkFKMzNPS0NmdkJE?=
 =?utf-8?B?d0VLVThLem5TL0hxVjlQODQwU3ozU0o1NllpYnVkTkFoRnFsbHNDZlhUMyto?=
 =?utf-8?B?bWV1eHFWam9MSVgwckFRYWlDMUlMRUF1VzJHSTRvRWJjbVJ5QXBxYjdGNnlF?=
 =?utf-8?B?dWRRUHlSSnRIUGVHbEZjalpjVnZ4SFpPbjJKZkdoMytlRkp2MSt0eXNzMVEz?=
 =?utf-8?B?VTd5cVBhV0JyTkZlSjhLdFZNOUh1K2RrSjdBa1VIRSt6KzdIeTNIZXlKYVFQ?=
 =?utf-8?B?aEFKaW1uNmQ5K2w3TVM3ak1ZcXVOc0YwNmtTbjNYZFErbXltV2FnSkYrRFhE?=
 =?utf-8?B?c1RLWi9vdHU4c09GdmgvTkxZTDFDUlRvYmYyMWFjU1Y1VWE2Y3VnQ2FUU3ZE?=
 =?utf-8?B?d0g3UzN1enI5SkZRRG92V0ZNZUJSZkZ2VHlmV1BLMndNRjNUK2oweldXTnFL?=
 =?utf-8?B?QW04SG8yU0RaOFZ0UFpFTE9BZUlYNUU0em83K3JaNU9rSmNpQkVFeU55SnBS?=
 =?utf-8?B?QnE3eFJmV0xBWk1hcXI4Y3JFTTlYNU5GQWlUOHErdlFQWlZpZTRoMTVUWlB5?=
 =?utf-8?B?R2swUWtUVmMvSTRpdkxVN0dkQWxDdERZWjl1YUxkR2x5a1RjbW1EMTY2emZk?=
 =?utf-8?B?dVE1WUI1NXltZHRqOGo2NFRDdHNzMjRNYkllUXFnNUFOZFJRQVVRTnRoQThr?=
 =?utf-8?B?Q2hTVVMzbklwZTJ6dFg2N0JnZDRTQWJkRVlvMGlXaXhpUXh3TjVtY0dlQnBo?=
 =?utf-8?B?NEZlenB5MWlma2FlcDBtM25vOXRSSC9wWmZDMlpKalY2cEVlSnplWUVSYmVJ?=
 =?utf-8?B?akZRUVdPbURLZzdDcVZibFJLZWpIOWFrZzlkbW1ZeG9kYjMzNHc2U3FzcGdi?=
 =?utf-8?B?MTdmMUFlUEJlMnBST2hZVlZ5UlRNMVRRWlhVenNMbEtvN2V2dFlwOFZ6WTZr?=
 =?utf-8?B?K3I3dzZoWXBpMDBnSERqVHNsVVFQNXhjQkZyemVzUmVmejVwSlAxc0kzODZV?=
 =?utf-8?B?aDdhK3o5T1gvZ3VFZTJGNEE1cG1meDZ0ekJ0Nm9FYkJyQWpGM3BvcE9vZ3E1?=
 =?utf-8?B?UmEwcjZVT2VGME8yRnd4YVdsM0lZOFhzNnVYWDdoeVRoWFJlUFhLRTdmRERP?=
 =?utf-8?B?Q09pR3J2OS9JR0c3eDVlRTFQNitRTkRjMGh2NW1CYjc3UU9QSDFSM3ZMSnQx?=
 =?utf-8?B?WjZONWdZbVB5Unc1ZXFsTG0zOTNoSDZ5Z0dURXUrSVlxSnp6YTRsZHhNMzA4?=
 =?utf-8?B?cUkvWGRiNGZCWXBqY2pLLzcydlBselkxdnhKYVByT2tyanFZZFVRT0ptdkg0?=
 =?utf-8?B?cHgxS0tmaStwU2Q4Wkd4QnlRNmJtNU1LNy9MdEJzdmZpZCtCTENRVjZMSEtu?=
 =?utf-8?B?ZWNWTUQ2emFTdkdEWVZPaEFsSHZjTHEva3llL2RseVpPbm1VNEFPaEc2TEpF?=
 =?utf-8?B?Z1JLZUdINE9LOFlENzRmV3l2VTJPeDFrVDRtUHk2TUoxeHpYaS9KNTRRNTN3?=
 =?utf-8?B?akFEcC84M2hvZHIycXpONjFTSzlZNmFINXZFSlVyMTBjUEpWUkpabHVTeW1q?=
 =?utf-8?B?bU5YMitEU0FXS01HWGlKa0VEanFWYUpVZU1OT2JuSi9BeFJOaTE2cVhLSGRl?=
 =?utf-8?B?YmJZM242bm55ckVmZXV4eEFuZE9PT3BoYm8yY3Z2bVBYY01IQVJHYUFhdm43?=
 =?utf-8?B?Nk1ya294MVpDbkF3c1FTWUlUdEJmWWcrUGF0S0t2bkRoM0FPazkvK0VPYmNT?=
 =?utf-8?B?blg1ZlV4TFViN05NOUZxQjU4dnFTQUU4NE13QnRybUZzRU42a0xuOUZxYWhW?=
 =?utf-8?B?Wm5oeHRmVzVuYm9kSm5jc0dGYTczQ2xzaWs5d3pKb2svcUlIVXd0bWZZazMw?=
 =?utf-8?B?aVdHLzB6eVhLelp4UjdwdkpHRUVMSmJYOFFacDFqdVEzR205ZktSVzV0bEsv?=
 =?utf-8?B?QlgyNWxNcE4vTzcvNlBXR05jREN2ZEpOSlV3ZmpXNUZOMHpWTDhPN0RhOUlq?=
 =?utf-8?B?Zi80ZGRka1BkWW1xMklXVm9FRzNVMW1BQ0NGQzJHZjNpTXNSNVJDMnBYcHk2?=
 =?utf-8?B?emJ4bnFSQmNkTTVzZEhLaWpXRWdKcFFBNGxWQVdZZkFTa1RmNWxDWEU1aWQw?=
 =?utf-8?B?TjI4K1E2d3c2QTJCb0dKUDlxZkNSektSakZFNVJHZU1KcHNJSGNQazlqVDRY?=
 =?utf-8?B?aXhUc0V6bGxpYmpkVFNXZ0h5YkF3PT0=?=
X-OriginatorOrg: gocontroll.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd591516-fb25-4914-06cc-08de184f0c90
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 07:28:12.6869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4c8512ff-bac0-4d26-919a-ee6a4cecfc9d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQNbP6nl7nx9UPdRUFQBhavOsEwRU3E6Lu20M/TvNa8XqJhuAsxK+EpbA+zyZw3htr7p7aRl6/Pyq+jaaFp3VxexoGA9Wd0iYV9QGbfAOp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8755

Hi Lothar,

On 10/31/25 06:36, Lothar Waßmann wrote:
> Hi,
> 
> On Thu, 30 Oct 2025 15:45:14 +0100 Maud Spierings wrote:
>> Hi Lothar,
>>
>> On 10/30/25 09:54, Lothar Waßmann wrote:
>>> Hi,
>>>
>>> On Wed, 29 Oct 2025 16:35:25 +0100 Maud Spierings wrote:
>>>> Hi Matti,
>>>>
>>>> On 10/29/25 11:05, Matti Vaittinen wrote:
>>>>> On 29/10/2025 11:48, Lothar Waßmann wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Wed, 29 Oct 2025 10:42:17 +0200 Matti Vaittinen wrote:
>>>>>>> On 29/10/2025 09:11, Lothar Waßmann wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On Tue, 28 Oct 2025 14:10:04 +0100 Maud Spierings wrote:
>>>>>>>>> On 10/28/25 13:42, Maud Spierings wrote:
>>>>>>>>>> On 10/28/25 13:15, Matti Vaittinen wrote:
>>>>>>>> [...]
>>>>>>>>>>> Could/Should this be described using the:
>>>>>>>>>>> 'rohm,feedback-pull-up-r1-ohms' and
>>>>>>>>>>> 'rohm,feedback-pull-up-r2-ohms'? If I understand the comment
>>>>>>>>>>> correctly, that might allow the driver to be able to use correctly
>>>>>>>>>>> scaled voltages.
>>>>>>>>>>>
>>>>>>>>>>> https://elixir.bootlin.com/linux/v6.18-rc1/source/Documentation/
>>>>>>>>>>> devicetree/bindings/regulator/rohm,bd71837-regulator.yaml#L108
>>>>>>>>>>
>>>>>>>>>> Ah I didn't know those existed, should've checked the bindings in
>>>>>>>>>> more
>>>>>>>>>> detail, thanks for the hint!
>>>>>>>>>>
>>>>>>>>>> I will have to investigate this carefully, since I don't have
>>>>>>>>>> access to
>>>>>>>>>> the actual design of the COM, so I don't know exactly what is there.
>>>>>>>>>
>>>>>>>>> So I am not yet entirely sure if this works out, I used the
>>>>>>>>> calculation
>>>>>>>>> in the driver:
>>>>>>>>>
>>>>>>>>> /*
>>>>>>>>>       * Setups where regulator (especially the buck8) output voltage
>>>>>>>>> is scaled
>>>>>>>>>       * by adding external connection where some other regulator
>>>>>>>>> output is
>>>>>>>>> connected
>>>>>>>>>       * to feedback-pin (over suitable resistors) is getting popular
>>>>>>>>> amongst
>>>>>>>>> users
>>>>>>>>>       * of BD71837. (This allows for example scaling down the buck8
>>>>>>>>> voltages
>>>>>>>>> to suit
>>>>>>>>>       * lover GPU voltages for projects where buck8 is (ab)used to
>>>>>>>>> supply power
>>>>>>>>>       * for GPU. Additionally some setups do allow DVS for buck8 but
>>>>>>>>> as this do
>>>>>>>>>       * produce voltage spikes the HW must be evaluated to be able to
>>>>>>>>> survive this
>>>>>>>>>       * - hence I keep the DVS disabled for non DVS bucks by default. I
>>>>>>>>> don't want
>>>>>>>>>       * to help you burn your proto board)
>>>>>>>>>       *
>>>>>>>>>       * So we allow describing this external connection from DT and
>>>>>>>>> scale the
>>>>>>>>>       * voltages accordingly. This is what the connection should look
>>>>>>>>> like:
>>>>>>>>>       *
>>>>>>>>>       * |------------|
>>>>>>>>>       * |    buck 8  |-------+----->Vout
>>>>>>>>>       * |        |    |
>>>>>>>>>       * |------------|    |
>>>>>>>>>       *    | FB pin    |
>>>>>>>>>       *    |        |
>>>>>>>>>       *    +-------+--R2---+
>>>>>>>>>       *        |
>>>>>>>>>       *        R1
>>>>>>>>>       *        |
>>>>>>>>>       *    V FB-pull-up
>>>>>>>>>       *
>>>>>>>>>       *    Here the buck output is sifted according to formula:
>>>>>>>>>       *
>>>>>>>>>       * Vout_o = Vo - (Vpu - Vo)*R2/R1
>>>>>>>>>       * Linear_step = step_orig*(R1+R2)/R1
>>>>>>>>>       *
>>>>>>>>>       * where:
>>>>>>>>>       * Vout_o is adjusted voltage output at vsel reg value 0
>>>>>>>>>       * Vo is original voltage output at vsel reg value 0
>>>>>>>>>       * Vpu is the pull-up voltage V FB-pull-up in the picture
>>>>>>>>>       * R1 and R2 are resistor values.
>>>>>>>>>       *
>>>>>>>>>       * As a real world example for buck8 and a specific GPU:
>>>>>>>>>       * VLDO = 1.6V (used as FB-pull-up)
>>>>>>>>>       * R1 = 1000ohms
>>>>>>>>>       * R2 = 150ohms
>>>>>>>>>       * VSEL 0x0 => 0.8V – (VLDO – 0.8) * R2 / R1 = 0.68V
>>>>>>>>>       * Linear Step = 10mV * (R1 + R2) / R1 = 11.5mV
>>>>>>>>>       */
>>>>>>>>>
>>>>>>>>> Because I do not know the pull up voltage, and I am not sure if it
>>>>>>>>> is a
>>>>>>>>> pull up.
>>>>>>>>>
>>>>>>>>> So:
>>>>>>>>> Vout_o = 1.35V
>>>>>>>>> Vo = 1.1V
>>>>>>>>> Vpu = unknown
>>>>>>>>> R2 = 499 Ohm
>>>>>>>>> R1 = 2200 Ohm
>>>>>>>>> Gives:
>>>>>>>>> Vpu = ~0V
>>>>>>>>>
>>>>>>>>> And:
>>>>>>>>> Vout_o = 1.35V
>>>>>>>>> Vo = 1.1V
>>>>>>>>> Vpu = unknown
>>>>>>>>> R2 = 2200 Ohm
>>>>>>>>> R1 = 499 Ohm
>>>>>>>>> Gives:
>>>>>>>>> Vpu = ~1.04V
>>>>>>>>>
>>>>>>>>> I am not quite sure which resistor is R1 and which is R2 but having
>>>>>>>>> there be a pull down to 0V seems the most logical answer?
>>>>>>>>>
>>>>>>>>> I am adding Lothar from Ka-Ro to the CC maybe he can shed some
>>>>>>>>> light on
>>>>>>>>> this setup.
>>>>>>>> R2 is connected to GND, so Vpu = 0.
>>>>>>>> With:
>>>>>>>>       regulator-min-microvolt = <1350000>;
>>>>>>>>       regulator-max-microvolt = <1350000>;
>>>>>>>>       rohm,fb-pull-up-microvolt = <0>;
>>>>>>>>       rohm,feedback-pull-up-r1-ohms = <2200>;
>>>>>>>>       rohm,feedback-pull-up-r2-ohms = <499>;
>>>>>>>> the correct voltage should be produced on the BUCK8 output, but a quick
>>>>>>>> test with these parameters led to:
>>>>>>>> |failed to get the current voltage: -EINVAL
>>>>>>>> |bd718xx-pmic bd71847-pmic.3.auto: error -EINVAL: failed to register
>>>>>>>> buck6 regulator
>>>>>>>> |bd718xx-pmic: probe of bd71847-pmic.3.auto failed with error -22
>>>>>>>>
>>>>>>>> Apparently noone has ever tested this feature in real life.
>>>>>>>
>>>>>>> Thanks for trying it out Lothar. I am positive this was tested - but
>>>>>>> probably the use-case has been using a pull-up. I assume having the zero
>>>>>>> pull-up voltage causes the driver to calculate some bogus values. I
>>>>>>> think fixing the computation in the driver might not be that big of a
>>>>>>> task(?) The benefit of doing it would be that the correct voltages would
>>>>>>> be calculated by the driver.
>>>>>>>
>>>>>>> If real voltages aren't matching what is calculated by the driver, then
>>>>>>> the voltages requested by regulator consumers will cause wrong voltages
>>>>>>> to be applied. Debug interfaces will also show wrong voltages, and the
>>>>>>> safety limits set in the device-tree will not be really respected.
>>>>>>>
>>>>>>> I think this would be well worth fixing.
>>>>>>>      
>>>>>> Before doing the real-life test I did the same calculation that's done
>>>>>> in the driver to be sure that it will generate the correct values:
>>>>>> bc 1.07.1
>>>>>> Copyright 1991-1994, 1997, 1998, 2000, 2004, 2006, 2008, 2012-2017
>>>>>> Free Software Foundation, Inc.
>>>>>> This is free software with ABSOLUTELY NO WARRANTY.
>>>>>> For details type `warranty'.
>>>>>> fb_uv=0
>>>>>> r1=2200
>>>>>> r2=499
>>>>>> min=800000
>>>>>> step=10000
>>>>>> # default voltage without divider
>>>>>> min+30*step
>>>>>> 1100000
>>>>>> min=min-(fb_uv-min)*r2/r1
>>>>>> step=step*(r1+r2)/r1
>>>>>> min
>>>>>> 981454
>>>>>> step
>>>>>> 12268
>>>>>> # default voltage with divider
>>>>>> min+30*step
>>>>>> 1349494
>>>>>>
>>>>>> Probably we need to use this value rather than the nominal 135000 as
>>>>>> the target voltage in the DTB.
>>>>>
>>>>> Yes. When the driver calculates the voltages which match the actual
>>>>> voltages, then you should also use the actual voltages in the device-tree.
>>>>>       
>>>>
>>>> Think I've got it:
>>>>
>>>> diff --git a/drivers/regulator/bd718x7-regulator.c
>>>> b/drivers/regulator/bd718x7-regulator.c
>>>> index 022d98f3c32a2..ea9c4058ee6a5 100644
>>>> --- a/drivers/regulator/bd718x7-regulator.c
>>>> +++ b/drivers/regulator/bd718x7-regulator.c
>>>> @@ -1613,6 +1613,8 @@ static int setup_feedback_loop(struct device *dev,
>>>> struct device_node *np,
>>>>                                    step /= r1;
>>>>
>>>>                                    new[j].min = min;
>>>> +                               new[j].min_sel =
>>>> desc->linear_ranges[j].min_sel;
>>>> +                               new[j].max_sel =
>>>> desc->linear_ranges[j].max_sel;
>>>>                                    new[j].step = step;
>>>>
>>>>                                    dev_dbg(dev, "%s: old range min %d,
>>>> step %d\n",
>>>>
>>>>
>>>> the min_sel and max_sel fields were uninitialized in the new
>>>> linear_range, copying them over from the old one (they refer to the
>>>> register range if I understand correctly so they should not change)
>>>> initializes them.
>>>>
>>>> Then setting 1349494 as the actual voltage makes it fully work.
>>>> Otherwise it complains:
>>>> buck6: failed to apply 1350000-1350000uV constraint: -EINVAL
>>>>
>>>> Final debug output now:
>>>> [    0.327807] rohm-bd718x7 0-004b: buck6: old range min 800000, step 10000
>>>> [    0.327813] rohm-bd718x7 0-004b: new range min 981454, step 12268
>>>> [    0.327819] rohm-bd718x7 0-004b: regulator 'buck6' has FB pull-up
>>>> configured
>>>>
>>>> I will add this fix to the next version of this patchset and include
>>>> your requested change in the dts.
>>>>   
>>> Does it also work with min/max settings in the DTS that are taken from
>>> the designated value +/- 5% tolerance margin, so that the DTS contains
>>> reasonable values determined by the HW requirements, rather than some
>>> artificial number that is enforced by the SW behaviour?
>>> E.g.:
>>> 	regulator-min-microvolts = <(135000 - 6750)>;
>>> 	regulator-min-microvolts = <(135000 + 6750)>;
>>> Thus, the nominal value of the voltage is explicitly shown in the DTS
>>> file.
>>
>> Setting that range seems to work:
>>
> I just checked the datasheet of the DRAM powered by the regulator. The voltage
> tolerance of the 1.35V supply is -.067 V + .1 V.
> I.e. the voltage settings should be:
> 	regulator-min-microvolts = <(135000 - 6700)>;
> 	regulator-max-microvolts = <(135000 + 10000)>;
> to match the actual requirements of the consumer for this regulator.

Thank you very much for providing these numbers and verifying the 
calculations. I've incorperated them into my V4 of the patchset.

Kind regards,
Maud


