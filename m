Return-Path: <linux-kernel+bounces-789870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBBDB39BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5572C7B2C63
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9EB30E854;
	Thu, 28 Aug 2025 11:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="B6AGdvxz"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2125.outbound.protection.outlook.com [40.107.22.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3DF191F6A;
	Thu, 28 Aug 2025 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756381622; cv=fail; b=Y3/KVHmN39LCspW+TOMepwZd4AdIpr7IkTilCi0pQ5c2jmEGEgQLzL9aF3i7hv3JezjOmIdrl445Vs2y/3qJ6AJjgJ3EHFSQSjR4MO5Fu2jhhdIm5iFaQQQbT8T6Ht+xsmJWkDsJh9CgfFhO8rDfDeQgpftW8Xp1X+kSs4hxdN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756381622; c=relaxed/simple;
	bh=xTGe3tBfrqChsu+cLhL/a8cqSRBNul1aQyrbv4vk4vc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WH5KQUx8y35JN1MBkVPYLx9NCBHw6VWCa2W6YwiO75W6E3UnE03OVDV56p2kvJnREjIEvwpWbHqaXdK1d8HeeGy1fu0ClR9AkyeECQxTkXQrs+jEK0zDD80dBQi771/2y1RUtH1GNSkAwKgNR/Ht7yiWn8j/zEujJ6VDnKtO5yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=B6AGdvxz; arc=fail smtp.client-ip=40.107.22.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnpD7i23vVbLeQq75ReouO5bJbIQNbBv31a23sftx5rLBQKwdw0qUVtzuX6z8VBe7p+QqEUAb5y3u5syq31s/Yq5TI+dQT7hJwglM+Y/brLLYq1ixfxNsed5D+FTCzqjIFHnjK6OU3r8SjLxUn8eBd8FrC8Zw3pGvyX5y/nIbAsPCEanVM/It5qWZq2xlsIzhXMS365/gqJic3Y+X7P+fRIc7jkcYQUk37LH4niwu5keiqulDcQQIblUh6sro6w1eqh7ccAt6PIGpSS4Iklz/W4nX4bWBllPMbdpihwV0nuoAOCaSOpXE6KB1eXzi53GD1VMI0Ji93N9nfa6YvQhkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsrYIICTyJjI9Q/4RiACZd97zb7o/Rgdu1KQUkFTHQA=;
 b=PswDAzHEIvgi74hnpVa28ulTMDs7iEkNdgkQslTikN8/1dW9iG1OCi3MDXyym8icVJuWLQdVEjTbLgye+GcQGzSqxbeUexAZVQgsD8aZHlDrHsDxyfQjcAuqaEHs7UcOPJoYAZb/UAQo3xto2Z7UDGsGjOcCnKrsM0LQdIJk1ncy47e/3SsrVzRyCle9EEwVIOvnIkVYOraqmgS4lcMP7BleOdLHyzX1CRISAUyniZKvBpo4hlnuZKO1BhGfUUcUzkk0tpBL2buvF9AFpcQ5ND5FqWW3Q34MW/f0TS61foRMTP/30NHfARSIRZgkPoHbs9UOq5/i0sUxvvN9NDsMYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsrYIICTyJjI9Q/4RiACZd97zb7o/Rgdu1KQUkFTHQA=;
 b=B6AGdvxzWJ9T0+d3WkOIDWjOTo/hkCEBjsQYuyAVjdHpTLeoXEbfo/HjpEWou9LDGXtM0Tlm99ndnN+hsPbSKIwZSId23kibA43pCk9QD34UFhgl8XSEsVgzY/j38opXiqkDMRFdGMbNKNRToViQtb3Q/G8Lc34AxcPqif33LVvPy1xpeHLPytf0GaxReYoDv4L0KqUWnM/NUFm1V/LXOD5BAmDcRnzue3FHrxnRIWg3907hUCBQqZLiju4pkJdhDlL9quzhHxZklcaDqreUvslZwSl/jKt09qkjM7QDF06ZRTVu60iCC4+AhcYCUSgAuorsub84TVZ9M8niwq1vUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by GVXP195MB2483.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:1b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.14; Thu, 28 Aug
 2025 11:46:54 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%7]) with mapi id 15.20.9073.016; Thu, 28 Aug 2025
 11:46:54 +0000
Message-ID: <4326a387-4d2d-44ef-87df-17aca68aacd7@phytec.de>
Date: Thu, 28 Aug 2025 14:46:50 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/33] arm64: dts: ti: k3-am64: Enable remote
 processors at board level
To: Beleswar Padhi <b-padhi@ti.com>, nm@ti.com, vigneshr@ti.com,
 kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: afd@ti.com, u-kumar1@ti.com, hnagalla@ti.com, jm@ti.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250823160901.2177841-1-b-padhi@ti.com>
 <20250823160901.2177841-9-b-padhi@ti.com>
From: Wadim Egorov <w.egorov@phytec.de>
Content-Language: en-US
In-Reply-To: <20250823160901.2177841-9-b-padhi@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0104.eurprd04.prod.outlook.com
 (2603:10a6:803:64::39) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|GVXP195MB2483:EE_
X-MS-Office365-Filtering-Correlation-Id: f580ceed-6670-4ac1-c618-08dde6289592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tm5wd3NTMTNLNncxaU9SR25OQVRXckpodmxJdXBNZStMZ01HZUp1TXVneHVZ?=
 =?utf-8?B?R3gvZk1ad2ZlYUJJZlV3SXhaMjBIdU9BM0hVSWdUNkhZd3VKL0lMQW1Ueis0?=
 =?utf-8?B?TEEwa29GbkxqZE10anBpRlZvQmhqUFFDQ29DMGk2R0FOUG82dzgrTjhVNHBI?=
 =?utf-8?B?K0tScTJrcGh2ZHBuc25haFo0NEpHVFhiRTRtSkFnVVM3SU0ra29JQTFzUzh2?=
 =?utf-8?B?cDhMcU5lQTNLSWkvRERybkFnbmc5aE1xM09WeXZFWm5zTys3Rk9lTjExTVg0?=
 =?utf-8?B?WkRTQVkvMHhTQXBTcGlSR0ZMdk1ZMkVJWXVhc3N5L1pyQkhDckZQMVhUdDRk?=
 =?utf-8?B?YVc0K21OOU04Yk12QkxkU2hicVhWRldUaWhJQjhUMlpjeUwzSHhQeFEvelh0?=
 =?utf-8?B?d3hPZTZtVUNraHJ1MG1BbVNzRU54RGJhSmRzYjBOQk1yQW9GZm9ndS9oNVUw?=
 =?utf-8?B?ajZEWlJ6ZklvbXZZdWJsMzJpazRMUit5bnF1aFNEZlBzb1M1MkJjV1VFM3hF?=
 =?utf-8?B?ZEFBNUFOdXU2RmpPVm9sczBkOVNweTc5bFlIanBkbzlCSUk0a3hwYk55ZU1m?=
 =?utf-8?B?NG5BS1h1b0ZiZXFtaWdiazhrRFAxQ1VZV1pGajlEQlpDOVdxQmhNSFJyemJ1?=
 =?utf-8?B?MGdEaTJKemtmTktuUVQvazRVMlJQMXVsNFBYSXdWeWRCYnZZc2lVdjNodk9j?=
 =?utf-8?B?TmdFNXE4R1ZnaGR4dWtnbkJEOWgrNHBGQlJKRkNQYU9kNkFLcVNxV3ZYTStZ?=
 =?utf-8?B?WGZrdVFkRnJlbUpyUGtHTXE2czExNEFhN09IS2dWV1RnYlJoVnNOcFFISG5C?=
 =?utf-8?B?S2EwVlNMZlZBR1VyMVhwYVFTZE95akFTTVBHVGJmWi9sZHNpOTYyUkQ2Mkxh?=
 =?utf-8?B?dXVyU0Y0TXphcHNQQkpUYmVnaENJWUEveWdFTlRYK2IvVklldStud1gzTzdD?=
 =?utf-8?B?MFNOYlpCL1dNSkx2QkFIUFd6Y2V4d0tpb1pWQjNKekY5MUxESU83MURsdkk2?=
 =?utf-8?B?MVg2UHlrSzFzVnhNL3RmSGgvdk16dUJET01JNU5NNDJZakVjdHJIQzM0NXBL?=
 =?utf-8?B?ZWtDYmg1V0pQdkduQXNZK2dXaUszQU5NaTl5a1dFVHg1dnkvTG1TT3hmTHVw?=
 =?utf-8?B?N2VidnRXdi8rUTE0azFSRjM1bUFLQTRobDdPRU8veG9CZWo5NFIzVjkrcmlF?=
 =?utf-8?B?a3BneDJSTUZzTC9rOU43dFYxdDZvbE01SjVGUnUyUUQ0ejd4MVZpT0NjY090?=
 =?utf-8?B?UkMrSkt5anZjYzZXMFBJTDllVUJKWmZscXVrUGhtenMzRzJPQ3JUL3BjT0Zv?=
 =?utf-8?B?eGphUEF4SHVUVm9MVzg3engwaElmSUNzY2IvL045SklvYXdvNi9DczI3Rnp3?=
 =?utf-8?B?cXE5S1RXVmM4aWpmYmd2cUFtUWsvSDI5WWlCMXZnVDJLQ3V2TCtRSURBTUR1?=
 =?utf-8?B?VUZNMURlTXdUbmtQdVV3Z21OVG9zVFBuM1ZJSnB6NzAvQ2s1UHhHNjNkdC9w?=
 =?utf-8?B?WW1LWU9HanJMNEloUzRvbk1od2VPdGFSaFFQUlp4NGNreEJaWm1rc0ZRUnls?=
 =?utf-8?B?UHQ5WnJUNEpCenRiOEtHMktFMzFCYko2TFRGQmMxOVhXNVMwVlhZOWt3WWh1?=
 =?utf-8?B?UDlLbjlPdjFRQ1ZNanZHUWFFUWVqR2NDWEg3ZmhqWjFkbkZWM3BxUjdvREwv?=
 =?utf-8?B?c2VWOXRoUGRtN0dqZVpCRkRic2lRVTRGVjU0Z0pSMWtVcHViaTN3OWR3R2FI?=
 =?utf-8?B?TDN0bWh0SDBsajZ2eHV3Y1I0Y3h4SFA0bFRKTjR0U0xmNWx1dWlWdDNpTWpG?=
 =?utf-8?B?OEpZdjhoam9KUmdJQW1FT0pWLzA5bHhHWlh1SytZZEhTaTZRVGpCQTc0SDdW?=
 =?utf-8?B?M2Qvb01wUHV3SHpmemJ5dXZwVmhTYm1FbEhXSzRQQkhKT0prOE0rYkVPQUhw?=
 =?utf-8?Q?8xN+ggJvkv8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjYrdi9tcnF1b1pDVzA1aC9idnYxdE43aWN1QnF6OE01aTZhTHNTcjdkK24x?=
 =?utf-8?B?SEVwRXhLdEN2enR0NXh0R3VGblFQUXlyYkdNWTExMjVVY2hlbU1PSFFpR2s5?=
 =?utf-8?B?RFhEQ3BsTHRCMHYxWGlYWGxFc2c4UVBxdnJ2SXo2Y1RyaDhaR1dsQTNBK3ZC?=
 =?utf-8?B?VEJBVzNxMExkdHhqOG11eXBPa2sxaHVTZDF5VkZJcEplK2l1TGg5WlVzVTVx?=
 =?utf-8?B?U3Z6cUFYYUJ2eDlGMjVGN1ljSXUzWnF1VldkbjdnK3VMN0RZZW02MlluUVJN?=
 =?utf-8?B?bkdVeU5jNzB0d25ScWdkNXBaVzhac0h6V2dWSU0zaEQ2Y0k5MVJRV0FQd3Bo?=
 =?utf-8?B?QW1iSnRSQi9yMzNJOVF2RkdZTXN1QzBZbE5PcTRTa1k3MldsZEs4akF6N0dy?=
 =?utf-8?B?OFpSaGE1YzE3T04wR2tLdUlqN3BEbnBVTlp4Vmp3K2hnMCtONWxhU1k1YWNR?=
 =?utf-8?B?WE9BQ0ZIdmg3Y2NDMVdpZHd0bHRDTWRWZXdmYkh5dTRBelplSndmSzhvMU42?=
 =?utf-8?B?VmpvNmJiTjdVRm5pUzdoQzg4VEViM1BGWk0rSTFQci9mMElqUFBpU3FFN3E3?=
 =?utf-8?B?b2sxSGZLRmFuY2QwWTNWeThBVEx4RnRieGhJOXhNTmhHeTZQVkRnRkJkWkJT?=
 =?utf-8?B?Um5SbkUyeDVsUjJ4TzVSR2l0RWQ5M0JrSDdTQUhGRnlOTWJaMXR3MmkwMUlE?=
 =?utf-8?B?OWVIS0t3QmNvSExXRDk2ZGxORzBOTWpQZjBPRTAzUzgzYnZnQUFtTnJ2eWVW?=
 =?utf-8?B?U3BleXBRbnNRbGdNODlhSHB0Yml2bUdTS0Q3dHVRV2I5ZjFxMmd4d0YvN3hN?=
 =?utf-8?B?S21XalpVb1YyWmM2b0tyOHpqN0dGQjlyZ0U5NGFiS3pLaVpZU2VuNFpWN1Jv?=
 =?utf-8?B?UEQ0aFFlbEFoNVh2RmN5cEp4OUxUTHZQU3piaW5pcVlKbFlNcFdsMUNMMGhG?=
 =?utf-8?B?a09VNWo4WVBRbTFiamM1ZWFxaW5TVUdzb2ZxVE4zVVdzc0p6dG5sUlU0SjJn?=
 =?utf-8?B?RHppbG9hZER1WSs3T3NpWHY4OVpDQnBnVmJUR3N0cjNDMXpLVTdNU1dCVHJj?=
 =?utf-8?B?UjBwcGJnRkF1VExqYzczYThsOFBHMEErbjlhL29MVzVnbFo2UG1BQm91dXFi?=
 =?utf-8?B?M3ZoWlpPVW1zcWhNNXJZOW5mTHRGZHdRY2ZMQ21LbVA5Y2hZVERVMlZRa2lq?=
 =?utf-8?B?TVNlenhhK3JETnJHdDgxWm1VMkttRmNnQmdNYXVhcEFpYjFvdjU5YW1CaFlr?=
 =?utf-8?B?WTVON3NKU0ZZaFdCRFNmd3IrOEhRTWRrWFBEU051YTJFOTJRQkhES0E1U1lY?=
 =?utf-8?B?WkZIU2VaZGJvQkVaWnBwMGFiSXRaZWh2YWk2VXJsS1dNN0h4VUpQNWFleDBr?=
 =?utf-8?B?d0dKbVFYMWNvd0N4VHl0TWxwUVhnUzB4VVRxeGY4TXJMWkJNbS9pV2cwbkxO?=
 =?utf-8?B?NklQR1ZBUisxQm1ZODE4eXlSSlJORStPbEtWajNoei85aTlpOGtWdDBzeEYw?=
 =?utf-8?B?Qkp1QWdGUUUyemVHeFM2RGZiL2FJTlJwLzlsaW11WUNmSjNaejFTNksvVDdv?=
 =?utf-8?B?TmxYeFpLWUQ5RDJpQy9XeXRKVUJKVVJRczdvS1hodzV5bSszZXcreE1mZ3l1?=
 =?utf-8?B?L01hQUU4bWpDdzdST0oxL3hlMzI4MWt0VSt0bDl2ZmIxT2pGc2lxRHk0Tlhn?=
 =?utf-8?B?Vi9CUWRZazEzT29iM0Z1Tkx3SDBnSGw5eit3ajJXZEczanB5SWMyM01pR0V1?=
 =?utf-8?B?aGJRM1pXZFhFdjhweW4zWE1odTZ6V3ZXdzRvNk5FditZTERDc0JPT2VJc2NX?=
 =?utf-8?B?TWNTUGVzdnhpdFpiNXp3eXg5STZraDdEUERZUG5Gd2xma29QK1Rod3RwR0RJ?=
 =?utf-8?B?UDBiL2FaTjAxMW9Wc29GdEVsbmprL01NUXBGVHJoYk10TWxVemM0MHgyR0Vj?=
 =?utf-8?B?ZFU4ZGlzbTNUVGZNTWtKQTdJNDYxQ21iRjJld1hkUFJ4RjZWZXRLTXh5bDkw?=
 =?utf-8?B?T1I5eWhUNThocEk2bzhhSFgzUzB6UXYyMEM4L0pJZWJUNGRLYmF1ZjBXaElr?=
 =?utf-8?B?WnprWjhzZEltZ2RHTzR2QTdOQVJGV2Y1cVVyNDg2OXZCWmFlcjQzZExRdnlr?=
 =?utf-8?Q?rt8k4U0GfeA6K4M4lV6It6sM8?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f580ceed-6670-4ac1-c618-08dde6289592
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:46:54.0991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHZiuTeFmgy5JqNEwOhEvY2tP1dtuD8sxd/IqY0PkObTrYp8iEQL2etHiOEfqAS8CUBMa9w/kf62fYbtTB5mOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB2483



On 8/23/25 7:08 PM, Beleswar Padhi wrote:
> Remote Processors defined in top-level AM64x SoC dtsi files are
> incomplete without the memory carveouts and mailbox assignments which
> are only known at board integration level.
> 
> Therefore, disable the remote processors at SoC level and enable them at
> board level where above information is available.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
Tested-by: Wadim Egorov <w.egorov@phytec.de> # phycore-am64x


> ---
> v2: Changelog:
> 1. Re-ordered patch from [PATCH 26/33] to [PATCH v2 08/33].
> 
> Link to v1:
> https://lore.kernel.org/all/20250814223839.3256046-27-b-padhi@ti.com/
> 
>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi        |  6 ++++++
>   arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi | 12 ++++++++++++
>   arch/arm64/boot/dts/ti/k3-am642-evm.dts         | 12 ++++++++++++
>   arch/arm64/boot/dts/ti/k3-am642-sk.dts          | 12 ++++++++++++
>   arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi     | 12 ++++++++++++
>   arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi  | 12 ++++++++++++
>   6 files changed, 66 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index c7e5da37486a..d872cc671094 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -921,6 +921,7 @@ main_r5fss0: r5fss@78000000 {
>   			 <0x78200000 0x00 0x78200000 0x08000>,
>   			 <0x78300000 0x00 0x78300000 0x08000>;
>   		power-domains = <&k3_pds 119 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
>   
>   		main_r5fss0_core0: r5f@78000000 {
>   			compatible = "ti,am64-r5f";
> @@ -935,6 +936,7 @@ main_r5fss0_core0: r5f@78000000 {
>   			ti,atcm-enable = <1>;
>   			ti,btcm-enable = <1>;
>   			ti,loczrama = <1>;
> +			status = "disabled";
>   		};
>   
>   		main_r5fss0_core1: r5f@78200000 {
> @@ -950,6 +952,7 @@ main_r5fss0_core1: r5f@78200000 {
>   			ti,atcm-enable = <1>;
>   			ti,btcm-enable = <1>;
>   			ti,loczrama = <1>;
> +			status = "disabled";
>   		};
>   	};
>   
> @@ -963,6 +966,7 @@ main_r5fss1: r5fss@78400000 {
>   			 <0x78600000 0x00 0x78600000 0x08000>,
>   			 <0x78700000 0x00 0x78700000 0x08000>;
>   		power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
>   
>   		main_r5fss1_core0: r5f@78400000 {
>   			compatible = "ti,am64-r5f";
> @@ -977,6 +981,7 @@ main_r5fss1_core0: r5f@78400000 {
>   			ti,atcm-enable = <1>;
>   			ti,btcm-enable = <1>;
>   			ti,loczrama = <1>;
> +			status = "disabled";
>   		};
>   
>   		main_r5fss1_core1: r5f@78600000 {
> @@ -992,6 +997,7 @@ main_r5fss1_core1: r5f@78600000 {
>   			ti,atcm-enable = <1>;
>   			ti,btcm-enable = <1>;
>   			ti,loczrama = <1>;
> +			status = "disabled";
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> index d9d491b12c33..03c46d74ebb5 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> @@ -349,28 +349,40 @@ &main_pktdma {
>   	bootph-all;
>   };
>   
> +&main_r5fss0 {
> +	status = "okay";
> +};
> +
>   &main_r5fss0_core0 {
>   	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
>   	memory-region = <&main_r5fss0_core0_dma_memory_region>,
>   			<&main_r5fss0_core0_memory_region>;
> +	status = "okay";
>   };
>   
>   &main_r5fss0_core1 {
>   	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
>   	memory-region = <&main_r5fss0_core1_dma_memory_region>,
>   			<&main_r5fss0_core1_memory_region>;
> +	status = "okay";
> +};
> +
> +&main_r5fss1 {
> +	status = "okay";
>   };
>   
>   &main_r5fss1_core0 {
>   	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
>   	memory-region = <&main_r5fss1_core0_dma_memory_region>,
>   			<&main_r5fss1_core0_memory_region>;
> +	status = "okay";
>   };
>   
>   &main_r5fss1_core1 {
>   	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
>   	memory-region = <&main_r5fss1_core1_dma_memory_region>,
>   			<&main_r5fss1_core1_memory_region>;
> +	status = "okay";
>   };
>   
>   &mcu_m4fss {
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> index e01866372293..a07503b192c9 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> @@ -764,28 +764,40 @@ mbox_m4_0: mbox-m4-0 {
>   	};
>   };
>   
> +&main_r5fss0 {
> +	status = "okay";
> +};
> +
>   &main_r5fss0_core0 {
>   	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
>   	memory-region = <&main_r5fss0_core0_dma_memory_region>,
>   			<&main_r5fss0_core0_memory_region>;
> +	status = "okay";
>   };
>   
>   &main_r5fss0_core1 {
>   	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
>   	memory-region = <&main_r5fss0_core1_dma_memory_region>,
>   			<&main_r5fss0_core1_memory_region>;
> +	status = "okay";
> +};
> +
> +&main_r5fss1 {
> +	status = "okay";
>   };
>   
>   &main_r5fss1_core0 {
>   	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
>   	memory-region = <&main_r5fss1_core0_dma_memory_region>,
>   			<&main_r5fss1_core0_memory_region>;
> +	status = "okay";
>   };
>   
>   &main_r5fss1_core1 {
>   	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
>   	memory-region = <&main_r5fss1_core1_dma_memory_region>,
>   			<&main_r5fss1_core1_memory_region>;
> +	status = "okay";
>   };
>   
>   &mcu_m4fss {
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> index 1deaa0be0085..ae4a6552644c 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> @@ -679,28 +679,40 @@ mbox_m4_0: mbox-m4-0 {
>   	};
>   };
>   
> +&main_r5fss0 {
> +	status = "okay";
> +};
> +
>   &main_r5fss0_core0 {
>   	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
>   	memory-region = <&main_r5fss0_core0_dma_memory_region>,
>   			<&main_r5fss0_core0_memory_region>;
> +	status = "okay";
>   };
>   
>   &main_r5fss0_core1 {
>   	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
>   	memory-region = <&main_r5fss0_core1_dma_memory_region>,
>   			<&main_r5fss0_core1_memory_region>;
> +	status = "okay";
> +};
> +
> +&main_r5fss1 {
> +	status = "okay";
>   };
>   
>   &main_r5fss1_core0 {
>   	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
>   	memory-region = <&main_r5fss1_core0_dma_memory_region>,
>   			<&main_r5fss1_core0_memory_region>;
> +	status = "okay";
>   };
>   
>   &main_r5fss1_core1 {
>   	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
>   	memory-region = <&main_r5fss1_core1_dma_memory_region>,
>   			<&main_r5fss1_core1_memory_region>;
> +	status = "okay";
>   };
>   
>   &mcu_m4fss {
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
> index a5cec9a07510..d0c1e4dc1da7 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
> @@ -488,28 +488,40 @@ AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* USB0_DRVVBUS.USB0_DRVVBUS */
>   	};
>   };
>   
> +&main_r5fss0 {
> +	status = "okay";
> +};
> +
>   &main_r5fss0_core0 {
>   	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
>   	memory-region = <&main_r5fss0_core0_dma_memory_region>,
>   			<&main_r5fss0_core0_memory_region>;
> +	status = "okay";
>   };
>   
>   &main_r5fss0_core1 {
>   	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
>   	memory-region = <&main_r5fss0_core1_dma_memory_region>,
>   			<&main_r5fss0_core1_memory_region>;
> +	status = "okay";
> +};
> +
> +&main_r5fss1 {
> +	status = "okay";
>   };
>   
>   &main_r5fss1_core0 {
>   	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
>   	memory-region = <&main_r5fss1_core0_dma_memory_region>,
>   			<&main_r5fss1_core0_memory_region>;
> +	status = "okay";
>   };
>   
>   &main_r5fss1_core1 {
>   	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
>   	memory-region = <&main_r5fss1_core1_dma_memory_region>,
>   			<&main_r5fss1_core1_memory_region>;
> +	status = "okay";
>   };
>   
>   /* SoC default UART console */
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
> index 828d815d6bdf..876cbb21961d 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
> @@ -167,28 +167,40 @@ mbox_m4_0: mbox-m4-0 {
>   	};
>   };
>   
> +&main_r5fss0 {
> +	status = "okay";
> +};
> +
>   &main_r5fss0_core0 {
>   	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
>   	memory-region = <&main_r5fss0_core0_dma_memory_region>,
>   			<&main_r5fss0_core0_memory_region>;
> +	status = "okay";
>   };
>   
>   &main_r5fss0_core1 {
>   	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
>   	memory-region = <&main_r5fss0_core1_dma_memory_region>,
>   			<&main_r5fss0_core1_memory_region>;
> +	status = "okay";
> +};
> +
> +&main_r5fss1 {
> +	status = "okay";
>   };
>   
>   &main_r5fss1_core0 {
>   	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
>   	memory-region = <&main_r5fss1_core0_dma_memory_region>,
>   			<&main_r5fss1_core0_memory_region>;
> +	status = "okay";
>   };
>   
>   &main_r5fss1_core1 {
>   	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
>   	memory-region = <&main_r5fss1_core1_dma_memory_region>,
>   			<&main_r5fss1_core1_memory_region>;
> +	status = "okay";
>   };
>   
>   &ospi0 {


