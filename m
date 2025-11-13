Return-Path: <linux-kernel+bounces-898895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA31C5646F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FB0D4E6C9A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9C9330B18;
	Thu, 13 Nov 2025 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="jNf7xKsd"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012044.outbound.protection.outlook.com [40.107.200.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22D7DDD2;
	Thu, 13 Nov 2025 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022274; cv=fail; b=AQr2JeoG+osVbp5cCojXvNKaRFI50yxCCXlKHGeLhipkFKDtLOMHUL6wx0VikJsjy0yUQ7muq7Yd+VeEIzftrTK49SHE44km/11ZWCuznaWfsC7tVfxXnRsEA/uBNi8XgLzsLPrUGFf00iz3vrtWoscVmZfiKKPqq97L0DxaSnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022274; c=relaxed/simple;
	bh=oPYoKTSH3YdHsA78K9cW1C6pwNKOTHFXLRF2bnhv038=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UqsaKPIrC8LTK8CJoHNnPFk7vTTNmLbbganvRqbVe4w6XrUfZvC4eQJoONq4Mr8L2x/Gm2w/oasceCMB8/b/Lf7R+5gFf2jQJ0Y6aM8HzbIIoZVfxZTq/noGzv531a6hDKFZD0/ACwg50gvz4nrVxh9CVtgBb25rVYDlncFBQxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=jNf7xKsd; arc=fail smtp.client-ip=40.107.200.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbafBSOygvCHZ8yT6p1vVOPorT9TrLO8IcI5U3q/21itRexoqcPrh5zXDq53gW0S4D1xOpUyz+pMWtweP8m/xiLzj5ftWC4aM8jMa7YCS7k/2FxOWd+aYUMe2lwkizaVlytZejpXLKdCYqjjn8lPVgeNNsgPBQoWKLfnDnWPDtHfE1qNPs9LM1CDqu9isrRTSvhFQ9R8P5YEIigsLEpeP4EssqY+ofRqs+gPOrG1f37D9lqb5a/xLxYFCpVsl0v01sbhEW653vFF6P8ACHdd0MDiVVkL2y/YkHLikMCnI0iWNazbXph1oevMT8k+i/dNTzZ/XzVmkwJMoocf7Gosbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEQapfwx53KS2lDoDHEhDsoAQuO/VQcjFtO/oNpDq9w=;
 b=HTEtOYdvhIbpxQIIi/UaynxuCq46X/Ye1Ie7k5uD8YAbERFd2F1T0fjW9pg3cOY7LmTXoiFLNi9H0tDQ0CbKIEoYrgVNzfL2yWX0AckaxqfkArZOW5qp1uT9llqXJAizq/35SPj5Mbi3WgdqsTro8Iv9Oo6Ibb9GobsW3SEFd2e9Yu8VAwV8WH//qpdGf15RUrh6HOdrM5Tt08jClcEOznfEN+SdqeKPMDt6chaheUfzvs511YS2NFaN7jEnyTlFqtqv2+uWL2+kgG/PKuSeP3slJ8YCfjDQqoifD6gpsgB6OP6YMv22Artn6337RmUKyyDBr8tHa7cN2v77GG2lLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEQapfwx53KS2lDoDHEhDsoAQuO/VQcjFtO/oNpDq9w=;
 b=jNf7xKsddlX6pNzsZm+2o6knR/M7/IgjmMeiw7zYKnDQvwlxNxet8dauTgoPmYnfLnOZ++42EdHftJxdBf4WIQmSKUKSk/aEu5wzRXWd6qxDt05N79Ned6OmdE7OlGCP7Z1O6xL5i+ai+wS/qL5v6As9BiMnzrrVw9+0PzU441SylGUHSRmz3VOB1PiNQ6oNRBMS42UklmuJzLZsjbQbeja/GmQk+j2KIyhu9Tc0t1PIAw63FXPLIb4JRKiILhP+0zv0mr+9R23kskIuGkEeFf6jX9e0LmSI6TYHlxDuqUkPTzwc6X2C01MfavM9mxbksLzgxjeMStdkNgE7slN7Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by DS0PR03MB8272.namprd03.prod.outlook.com (2603:10b6:8:28f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 08:24:31 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 08:24:30 +0000
Message-ID: <afcdee8d-5ea9-4ece-bf4e-c347881d2b97@altera.com>
Date: Thu, 13 Nov 2025 16:24:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: socfpga: add Agilex3 board
To: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251112105657.1291563-1-niravkumarlaxmidas.rabara@altera.com>
 <20251112105657.1291563-3-niravkumarlaxmidas.rabara@altera.com>
 <95aaafe2-a362-4f55-9d38-c0d2dcb21cf0@kernel.org>
Content-Language: en-US
From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
In-Reply-To: <95aaafe2-a362-4f55-9d38-c0d2dcb21cf0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0139.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::31) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|DS0PR03MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd05172-8c06-4277-e623-08de228e10ea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmhMOGhnbTh0T0FiTWt5M3FtbjMyeUo5eGtaQng3elNUa0hxMnFzSmFyMG1V?=
 =?utf-8?B?RHU0OTl1Sm9vbHBwRUhPRWFjZ1pCTzVERmhoZXhGRnF0NFNVS0huRWlUckNK?=
 =?utf-8?B?K2QxbXFzaFUxOGo2a1R6Wmt2WGNTbm9rMlFQR1A5dUw4azlZVllUYmdJTEV6?=
 =?utf-8?B?ejZmaFJtT05BSXk4Mkl2Q2YyU3FZbnlaK0JyWGU1Zy9Sd0U2Mktld2JJMHN4?=
 =?utf-8?B?NzlwU05VVTk3Z2k1MCtIWm16MnZSOXJMemdxdW5QR2pQTVNTT2lUYjJTeWI1?=
 =?utf-8?B?bnd4ZWpiQVNBemlQd0UrZHN5L01UL3pWT01RbGtiWXkxMnNvRzNsaWk0QlJi?=
 =?utf-8?B?UnFQTjlPZSt4dVEzZENrN0pFRkNoWWJBSTI3MDNWZEhQY2tKQXNMWjZTZkxr?=
 =?utf-8?B?OEFSbVliMEl0ZTJ1OHEyRWQ1clJLVDluS214UW9DWTN6TEU2YXE2Tkd4N2ts?=
 =?utf-8?B?S1JGV1M2YkU3eXJPWi9PQjJPNTlvblZFVmgwTEI4WmRHendWY3dEZDAxSXlU?=
 =?utf-8?B?M0ZWbG1BUm5OWms0Qi9wRG5kU0w4eVRCbG9DNXhSNGtNYnNoUFVoNTFGa1JQ?=
 =?utf-8?B?Q0hxWGIxMjNuS3pJUytVcEtJck8xSWh2N24wNWhnOVlCeDRhL0VkUVR5alVD?=
 =?utf-8?B?Q1p1NndlWVVyT2VxYXFVOWtET2h3YWxMRU1GZmtxMjhBeUYyRHFIbkxoTTlU?=
 =?utf-8?B?VGZXNXNRdXYzNlFXbXZMR05pdlFwb3NlY2xidUdtVVdWWmJocHkvWUdMVE5T?=
 =?utf-8?B?Wk9MSDNDWTBWTnd6M1FqNkprZUlIcXhPWVdyalF1R0V6V3VxTStxZ1VBQmUz?=
 =?utf-8?B?bGY5MExHL2dEejRKRUJVM3ZvVFA2SUw0RUhQTmRkMUVhcWxEWVA3Z1gyMU9o?=
 =?utf-8?B?dHFJbXBPdDErcERGblZ0MDJITHhNejExR1lJdUpNS2pyWUxSWklBMTJ2NFI3?=
 =?utf-8?B?OU1odW5KWHJvYlMvN1B4VGZUZm14K084MnRldXdObk8xUmhtOXB0WW8rSWZv?=
 =?utf-8?B?VmhkZ0tWQjVQbDhxL2J5NFZMQzA3WUl2bVZUNnlGT3ZBWE1DRGdnYXRCdDhQ?=
 =?utf-8?B?Z0toZWs4dVhya3doTmlSc2Z5aTZla1VHejFmYzJsNHlheXF3MmVGOTdaNTBq?=
 =?utf-8?B?VGZLRVZaM040UFZraGR3dHFuR3pFTm50N0licVliM0ZCMnhLS25XUnpmRkZu?=
 =?utf-8?B?VldYOUFuTmNwY1FtbGd1bWZQYmw3dVFERFVpOWI4NFFCaWJnc0ljMWIrbU90?=
 =?utf-8?B?Mk12b3F5eHgxdEJYSGF0SEE1Rm1ucThXR2xIMW1aZkwxaVVrVW5XOW9zVEtn?=
 =?utf-8?B?OUR1b0ZaRUNPNGNrVEdqL0lac05PUUhoTFQ3T2dRQ2l6VUJ5NDdzMHBJUCtD?=
 =?utf-8?B?L0h3cjRFeTJYSkxpVDNpb3NZMW1SdFhyVjU5dkRNaTdDSE9SOHREcHYrTmN6?=
 =?utf-8?B?dFhKcFp2a3lUUVk4OHV5UUN1cnNxRVdITTZVVHJpMXdjQi90OCs5SjNDZTBT?=
 =?utf-8?B?Y2ZaWDRhM291RWJqemVwYkl3MWZlSzFOWDNnU00wMlRxajdIbzhLUjdyZ0t1?=
 =?utf-8?B?dkY3WjUyY0hOODk0UHJlay9tZmxINGZ5V2tWRDRMbjZrbUR3MDd0cmM5QUgx?=
 =?utf-8?B?RndyVkRNTjJadk5lVkRSZDBDYWpac1d0R2lPcUF1b1N1YVNPUGRMVERTMzJH?=
 =?utf-8?B?YktQVDFhb0VzU01vWUVHc09pMjVISFdmSUZsQ2tBbG5QZVg0THhzeVJxTm1O?=
 =?utf-8?B?KzBmNWVMRFFHeDJIMVFqbmh3bmtRYTRCTVZQYVhDSWJKY3Q2enBSTG1zVlVm?=
 =?utf-8?B?RXRFZkpqSW50cDhKVkhTSldsY3lrS0pNaXFLSGtFOEV0NStJWTliNFdlSkMx?=
 =?utf-8?B?ZnBLNXVKZ2dDclBvZ0NMN21rM1R3QWxGMGxnQ044T0lzZThhczRaZ2VtQ1NK?=
 =?utf-8?Q?h5GnNIaNtNKX7SRYUCM6u9vtB2KiW/Jf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXRxSXg4Y3FjelZGWCt4bFVpVXgyc0EwbmlaNWhucDhoekFrb09pYTFGdmtr?=
 =?utf-8?B?RGZOSHFMZi9vZkRLWGozN2w0Z2V6UWNPWWxnSEhjTk5VSjF5cnc5a0Mzd0M1?=
 =?utf-8?B?QVV6bWxFeUlIaHRJRHk4anFWaFU2NGdjanRZYnAxYlRkaXFucUg1VlBxVHVY?=
 =?utf-8?B?RU5MRll4WC9pdGtwanp4ZEdjZ3pleDlzU25QazJiL0pkSWRGQ2dmRzRqbGJY?=
 =?utf-8?B?SE0vRGhwQzg1T3FUd0hBQUhqbEJRWk9hS01VeCtGc3RtVGpxQm52SExNT2M2?=
 =?utf-8?B?elRjWXNtUnMxLzVVcWF0dEVXai9ZTWZLTEROTHlPckZjUkRFTXdRSEVVVElu?=
 =?utf-8?B?cFFqcW51d252NC9yNzRlN1FOdjFtcTQ1bkVtZURyd1Z3Y0orT1dOR0Q5RGxx?=
 =?utf-8?B?RjVWUFBFdnlZTG10NlRFVE5MbmZiTUJnZ1U3VGZLRXJ4MDhhcVpud1ZVbDM4?=
 =?utf-8?B?aHgvMGhFNlZ1ZWppOVRXZ3BhOHdjQkhKTFRpY09JeVdQYWxqdk81NW5ZMWUr?=
 =?utf-8?B?TCt5T2dkc1NSbFZ5NFV4ZDRhNzJuQlVWci91bnJ0TStsTnZkMkVVWnZMaFlB?=
 =?utf-8?B?YkQ1aEduUXpzYjNNS25JNWRHVGdhditlbVlZdlhRNTAwZktvNTVpdnQ3d1Zw?=
 =?utf-8?B?dXhxK21VMWJ6SkFCVG9ZNXhhMjdQbDdzK3Z6bXdzcDIyandoTWtzWEpMbnVV?=
 =?utf-8?B?WGkvYWtUOWhMdDdtNjhEVzEvR0xxaEVXbDF1eVhINlFsK2d1b0Rrd1pxWWox?=
 =?utf-8?B?b2FNeWRMamthcjRXWU5Pd3diR0dHNXh0cHhtc1V6QTN4aVJpYVJOMmpxMnEz?=
 =?utf-8?B?TU40UzBJdlFCb2dUb0RZUmtZN2V3ZTZJMGgwdGpkNnVXakY5eHR3MUFhYTl0?=
 =?utf-8?B?MGhUcUI1Kzk3R3ZLU252Rk1NVzJPVjk1dkxJQlZnWjMrU3QxdHk5dzF3bFVt?=
 =?utf-8?B?SEgxZm9KN1lGWm9VSkhXZmwwbERFQUVwRjVabTFVU21OU0FXUWhGL2FEdEtq?=
 =?utf-8?B?U2hGL2RBV0dxdGZ5L2FsWUQrN1Y5a2YwSmJ4V25qQnVKSHBEcms4R3craDd3?=
 =?utf-8?B?bm1lNUY5bG5jWlRoL1Y3d0ZYK3pQRkZSUjVkQXU2TXdqMDRTZE50eVRORjRW?=
 =?utf-8?B?cVZQWmJxeWp3TUpLeE9mZEovWDF3aTY1WUIwY1BnakN1UE1Zd1hXdXFBYzB3?=
 =?utf-8?B?aVpRRmZwNU50aVRrQ3dYZ0Q2RzlYNnA0QXp1SDNTSlZtKzc3dTg0UFRUSDll?=
 =?utf-8?B?QUdCVlo0MWV0ZU52c1ZXTWNsL3F3WkMxbnVLd0JySjgzeVk5Tm9GM0RIS1BZ?=
 =?utf-8?B?VnhSazJrT1M3L0xZelVrVW4vN1JlMFprQjZTU1Y0V2p3VGpVdG9vWmhFcGM0?=
 =?utf-8?B?eWxmbFB4ZGV4aDBtWjNUUUxQSldISkVFcjczY3VXSk5lZ3lVQlM5bkk0d1Js?=
 =?utf-8?B?Ynh4NkMrZERycFZHWEV5UTlnQnE1V0Q0eTVndk43aWhoTFUrbXI5ZTNDMlY0?=
 =?utf-8?B?THoxMVRXTlUwamtjblA0ZTE1MUdQYzlLUzdRWlNjRDIwc2lOQkFkUVB5dVNC?=
 =?utf-8?B?NGlhWXNmSnhQMURFMzFmNEVMbjlEeDk2V0lpa2hHRG53TEdmL2IyTWZ0Zjcr?=
 =?utf-8?B?b1o5ay9yaUNTdDl6ZDNiMWowQ0Y2bDI3SFhTTkI0bSthYTNhcnpZT3I2SkV3?=
 =?utf-8?B?M3h3WXM0ZnlvRnAzWkFRRXFUQWZ6elNwWlVnWjVDekRTNzFrTkdwaFo2c3dw?=
 =?utf-8?B?Rlp3aVI1WEZrdGRNeGZVR1JCZVF2bjdtM1BVUDZpR2tGdTRYUmVqcDhhcTBR?=
 =?utf-8?B?UGFKMmFYeEw0YzdoWlJxa21aQm1FWGRmN3hhV1o4TmZzcE93V1pzREQwZk1Z?=
 =?utf-8?B?b1V4QmhobUphampXTll3SGI4R3o2VlBzdlFZbThSZ2g1dkFSZVZCQnNFTU5o?=
 =?utf-8?B?aGVIMjBER3k5K0duNzFPeGRQMlluai9vK1hGWTV3VGo5ZExzZ2Ewdm82VUVy?=
 =?utf-8?B?YTBSaHZ2c2ozT3g2U3Y2YUUyaFJldXh4cVFFZGprVUFGcnQvMTlGQjloUi8v?=
 =?utf-8?B?SkFPMlEyM1ExSlN4UDcvVVlWdG5IbFhnZTBZRG9LVXUrWldWMWtBZEtwYlBL?=
 =?utf-8?B?QURBbUVIQmJXOUFER2dRMi9XWG9sclNEdzVSN25wcFBuUUZ1QnFPWHNubm03?=
 =?utf-8?B?djhUU3k0c3VQVnI4L3pJU0lkUDZoRUN1bGRYbUwyMzlqNnN1QVRBbFpzczZz?=
 =?utf-8?Q?HjF+4kRXmj30urPtq/TMRFOiLFuelbjbdzIVEPdc9o=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd05172-8c06-4277-e623-08de228e10ea
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 08:24:30.8731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CU+i8O39nFFyYDQkkEvtZBDFtt6dogOtjRZgud1UvvuCikIo0HdiI2GUiz2F01vh45+O4Ccv0Ool9Q7WVC/jUws6fY43/KXt27WPqTomPd1g9Szb1cPmdwF//JT58jBT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8272



On 13/11/2025 2:41 am, Dinh Nguyen wrote:
> 
> 
> On 11/12/25 04:56, niravkumarlaxmidas.rabara@altera.com wrote:
>> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
>>
>> Agilex3 SoCFPGA development kit is a small form factor board similar to
>> Agilex5 013b board.
>> Agilex3 SoCFPGA is derived from Agilex5 SoCFPGA, with the main difference
>> of CPU cores — Agilex3 has 2 cores compared to 4 in Agilex5.
> 
> Please fix up the message's formatting a bit. I don't think you need the 
> additional newline.

I will fix this in next version.
>> +/dts-v1/;
>> +#include "socfpga_agilex5.dtsi"
>> +
>> +/ {
>> +    compatible = "intel,socfpga-agilex3", "intel,socfpga-agilex5";
>> +
>> +/* Agilex3 has only 2 CPUs */
>> +&{/cpus} {
>> +    /delete-node/ cpu@2;
>> +    /delete-node/ cpu@3;
>>
> There's no need for another dtsi if you're referencing the Agilex5 dtsi.
Noted.

>> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts
>> @@ -0,0 +1,127 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2025, Altera Corporation
>> + */
>> +#include "socfpga_agilex3.dtsi"
> 
> Include socfpga_agilex5.dtsi here.
Noted.

>> +
>> +/ {
>> +    model = "SoCFPGA Agilex3 SoCDK";
>> +    compatible = "intel,socfpga-agilex3-socdk", "intel,socfpga-agilex3",
>> +             "intel,socfpga-agilex5";
>> +
>> +    aliases {
>> +        serial0 = &uart0;
>> +        ethernet2 = &gmac2;
>> +    };
>> +
>> +    chosen {
>> +        stdout-path = "serial0:115200n8";
>> +    };
> 
> Just add this here:
> 
> +       cpus {
> +               /delete-node/ cpu@2;
> +               /delete-node/ cpu@3;
> +       };

CHECK_DTBS gives error if I use above mentioned way.

/delete-node/ cpu@2;
/delete-node/ cpu@3;
Works well without any error or warnings.

>> +&qspi {
>> +    status = "okay";
>> +    flash@0 {
>> +        compatible = "jedec,spi-nor";
> 
> You need a specific type of the qpsi memory here.
>
The QSPI flash here is a standard JEDEC-compliant SPI-NOR device, and 
the kernel’s SPI-NOR/MTD framework supports SFDP (Serial Flash 
Discoverable Parameters).

Since the driver now reads device capabilities (size, erase opcodes, 
read modes, etc.) directly via JEDEC ID and SFDP, it’s no longer 
necessary to specify a vendor-specific compatible string unless the 
flash requires special handling.

Therefore, the generic "jedec,spi-nor" compatible is sufficient.

On board, it can detect the QSPI flash and works correctly.

>> +        reg = <0>;
>> +        spi-max-frequency = <100000000>;
>> +        m25p,fast-read;
>> +        cdns,read-delay = <2>;
>> +        cdns,tshsl-ns = <50>;
>> +        cdns,tsd2d-ns = <50>;
>> +        cdns,tchsh-ns = <4>;
>> +        cdns,tslch-ns = <4>;
>> +        spi-tx-bus-width = <4>;
>> +        spi-rx-bus-width = <4>;
>> +
>> +        partitions {
>> +            compatible = "fixed-partitions";
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +
>> +            qspi_boot: partition@0 {
>> +                label = "u-boot";
>> +                reg = <0x0 0x00600000>;
>> +            };
>> +
>> +            root: partition@4200000 {
>> +                label = "root";
>> +                reg = <0x00600000 0x03a00000>;
>> +            };

btw, I just realized that partition size needs to be updated.
I will fix this in next version.

>> +&uart0 {
>> +    status = "okay";
>> +};
> 
> No USB?
Support of USB3 will be added in a separate patch by Ng, Adrian Ho Yin.
Agilex5/Agilex3 socdk by default supports only USB3 interface.
(USB2 node should be removed from socfpga_agilex5_socdk.dts when USB3 
support is added).

Thanks,
Nirav

