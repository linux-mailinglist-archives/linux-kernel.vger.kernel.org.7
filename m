Return-Path: <linux-kernel+bounces-758848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 753BEB1D495
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CB91AA09C4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12A425CC63;
	Thu,  7 Aug 2025 09:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Zqwfdr9m"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012011.outbound.protection.outlook.com [52.101.126.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A783B2A1CF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 09:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754557946; cv=fail; b=gA8lR3LmotFsV5j3dtEVADP/JGt3MTI7kk3mMzvc/eG8SpMGdCq5qnE7jFxqh3dq76l5dpWkHxIp35swC3YExooPNbE4i1DGWzYuAcb2l9BncfuqRIHYO/IRPnY5Kfe34yJiMxoxu+gk91hFIWzvW4+raFr0WY3bTjmqirYkEyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754557946; c=relaxed/simple;
	bh=ASmEH+RfX1IyrtnY5VqE5RQgO1u0orHF+NNTGneFpwU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dNNUHDwntTBp3Co51//4ZJzrB83t3+Z7Fv7UEP6BtLkaCqzoBi/CpfV9U3rFswSdXQF5bmyuY78oX5Wp4xr2Zj20A5UYwn6np2bocFP2wZ92ozkfBv4nL+K6k3bU8nroIZvXyhp/69OBdKb5vmn9DNRMpu7xEcncnX+M32RSwv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Zqwfdr9m; arc=fail smtp.client-ip=52.101.126.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/b/U6TJSrqy1pXp2fgIDBhwwe04HcOEZDookHUT9nHoHdAKnbgEu8DgWVilNZbyiMfs6mfRLPeBg+BtDLzqjsSrw9y23CaKD/B8a66fapqj2GGrUOwuhYLfzPR8ZdjX0pRiwEWw/GTZd0VAJK4Xj+u2jOuYtA1JhsiUq+T/zr+2t5ZHjkWKfycoEMBbksur82SV4ZIdW+YffUF/MNMcSJX+Y/W+qQAV38BQEFaYtw2GFFUDjR9IpeGTtuh8gdZ5J4CEws2NjRRold8e/VgLTEmrhuUi4PS7YLKl7SugVriSPwKUC5U4aQq96Sgnf7cEUr38+xo+57Zw4uf5GPsbpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9ZO8w2wX7EGnjNFokC9GKBLyIq+n1/X1AXUZzDO5Qg=;
 b=bYa/gYnqTPKlc3z37EcZOnk+PG3IIV6bp/OvYHkqZYxgJtzkLeIIo+UOQSKmCD75es6W4tNjLDls+yrQ17jpqORKn2s7Byl+mUpPvUBPRx6EtsFZTqilGoubghxBbWQ7bpXx2382+/Ec3RcNAxlaVgReKshtteJ42L2tVdLKpF+6XdR5vakRDpdfUkIT1wtakQh+yvXf+WY1EdSxlta/jTZm1lZ6LsMeEhZ88wruT37jC27RSrx5hx3vfWbXgTFzqer/uBq1zBgTee0PYDu5j7tq/bTp6XKabTQimI55TAA1zE8mfIOHXEebnASC5vO9XX7fG7afd05r9hGq/wyqMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9ZO8w2wX7EGnjNFokC9GKBLyIq+n1/X1AXUZzDO5Qg=;
 b=Zqwfdr9mqR2T66MMJjtfQfQU0GcO6hOahGNQ9bjLKNhNb2QWWTfVu3C5np9IQpgBM49mRExN6WtiUiC+H60uDAoRqpzGIIioFqsfPV28ZX9kXp/pfI6hi6WlCFQLF75tSk18AxUjBvtciYkeSbemjRT219Aa82QLx4GAz41oafDI2WnF1KIg0x24r88VMf7OMiLpjQ1VGvXU168BO/NJq7ZiiH3EL2Ptx0guQ4Qq/YFFu7O6GBQems9jnZLcpw2H/chYmP1p5H2BWRRuD6XYPo8E0WQjetvkS/RVZ5AzMc+bUAOIrhwlzRhr/XtJ3AmCWdMmbZb4621l69wnD0//Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TY2PPF70F768FD5.apcprd06.prod.outlook.com (2603:1096:408::795) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 09:12:19 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 09:12:19 +0000
Message-ID: <2518652e-4a81-4b71-a0bd-a078d511f7b2@vivo.com>
Date: Thu, 7 Aug 2025 17:12:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] f2fs: Add bggc_block_io to adjust the priority of
 BG_GC when issuing IO
To: Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20250805132208.486601-1-liaoyuanhong@vivo.com>
 <20250806070905.71012-1-liaoyuanhong@vivo.com>
 <ee0b8b83-a368-4529-b25d-d3b1c6291648@kernel.org>
Content-Language: en-US
From: Liao Yuanhong <liaoyuanhong@vivo.com>
In-Reply-To: <ee0b8b83-a368-4529-b25d-d3b1c6291648@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR02CA0063.apcprd02.prod.outlook.com
 (2603:1096:404:e2::27) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TY2PPF70F768FD5:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ba4398-ce53-4c8f-8c43-08ddd5928299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1RnbjE1MklSRGlwUVVXL3pXcUR3ekNOeFJ0YkNuSDR0SUltOG1rbURCZ0pp?=
 =?utf-8?B?Q2JKeWZxZEF1b0V3Vng5T25qWUJaU2RqS0h4c2JiV1g5ZkFZY3JBVnlZc210?=
 =?utf-8?B?VHAzV1ArVWpXYnZiR3ZiRmN5d1lWTjNNNTdSelpuK0lQVit4eFVpZ3dPWDk5?=
 =?utf-8?B?ZVZxbzdHa1REKzNEeW15eSt2MnFVNDA2c2xvbFFHUVZZajN1NkdoWURUVkg2?=
 =?utf-8?B?MTlFazE4Z3FGUHIrY0ZVUTZuc0FmY0J4elZQRUVseTRjc1lETENxSmFiUWk0?=
 =?utf-8?B?M1Q2UWE3bzVzSmNwREx3U0JLNFNxSUtDenFJemhwcU0zYzdNNGVoQzB1MTZ0?=
 =?utf-8?B?cFIwbkxzZEhCVG03VWxIcU10dUFlR01xR3ZDV1NCUmpCZFRCbHpXOHZzeXZw?=
 =?utf-8?B?ZXAyRC9QaFdhajJPQ05pYWVOZ21DMWVWN0hIRDQ1RVpJMXRINDhJMDg5UXRB?=
 =?utf-8?B?eDkvQW9IOUo3VlZWR3pZQjdvSGR5bVhxaFJRMHg5TjV0RTN4SWlhb04rNUF0?=
 =?utf-8?B?elhrUDBPWmh6STd1elhleUQ4M0FzQ0FNRkl0L1dTWDV5YWp5dWU4UG5rZVpR?=
 =?utf-8?B?akI3VWdzMUZaeTljQnJEbzliWHR3NHorTFY4V29YKzU5cVdHT3JHT3YydDNY?=
 =?utf-8?B?VzNyTWRMendNazdZMHY0aE9mWDJ6cUhWWENaNE5mMjg0S2o4Yy9uYlRUZmJT?=
 =?utf-8?B?TXBkRTF6UTBvRmVlK3QzS3ExdWlqQVNlaFNFNDgxblNrMzVZZVNKOUt4ZURS?=
 =?utf-8?B?Vms4YUtXV1BiY2pSQUNCdGRRL1RxY2Q2dW52UERJQ0hKdktzTjlLWTZKQ01N?=
 =?utf-8?B?T2Q4R1lXL2cwS3k2UEtWSlV1OW9pUWRPZXMvWnlOUjdkWE5RdCtPNFNSWVM5?=
 =?utf-8?B?bW41MWViSUdKWDhtZVF6dXRrYXZaTlVJdFRnNG9IOHcwUTZ5eUhSVWwxdWlO?=
 =?utf-8?B?WE9NM1FzeEJsQnN5azBEbEdRaUMwSkZhY2daWkVnRW9WZDdxRVFidTM5TjR5?=
 =?utf-8?B?ZXo3YUQ4M3NyWEtDT0ZPNXFMU2tzN3hsNU1iWHU4UVFNRDRuQUJYT2NscHhI?=
 =?utf-8?B?NzhJRkVVK0cxbmVtZTBUaVVGTEtMVDhGVGJad3JaSkM1YmdvMUcySCtyL1Vp?=
 =?utf-8?B?OVhqZEhtOU4zdWQ4UmpBWk1NR09XaDlZSlV2NkJkRWl0RXgwYVpEOVFvY1hi?=
 =?utf-8?B?UUwvdnFIZkMwN2tFRVNoalVuaUpPRzVlZ3BoQzVpRlF3azB5cGNFZkg1UDlR?=
 =?utf-8?B?WllNOS9wR2llMm9ld0g5ZURvdmc4ZGNDWGhvbU90cG95WS82eHM0VEkxV1JD?=
 =?utf-8?B?RU1lN3JxV2kxV050S3ovWnUvZzJjaEtJYTFHd1ZnY29ieUluZGR5dFZBMU8x?=
 =?utf-8?B?MFBMYTltUFhyMmk0bWF0SUx2dWwwL1hQTDFpNWZONUZBak1ielpyTjdTUWs4?=
 =?utf-8?B?bmRxWHQrU28yVDhoTE5EZmtWaDJxTGlYSjNrZ1ZrczdLaDVtNmFaNXljNGRH?=
 =?utf-8?B?cWRYME9kVkRoUkM3bDcxK3NtQjFHSHVtbmFNM2VQUkpQZXY3SDVLbHdqVC93?=
 =?utf-8?B?QjhaTnNsTHg2QnBXNHY5K0FWODVMU2huS0U2K2s1SVkwOGI0VkdvV0dLTHdk?=
 =?utf-8?B?R1VlMUVLWDFqSGR0UmptQVp1enU0Q3pNVERrQ3o1L1owTnJUbHRsV2pNK1ZV?=
 =?utf-8?B?NVJGcGZiUm5oTXN4UzMwQXVqNUorcEh6bVY5M3ZFWW5DUWl6NSs5UnJwQjF2?=
 =?utf-8?B?T2pYMWRGSXRta1NmVWV3Z2dXTVdWK1dnNjZzajRBcFFSVHJJb3BiaVJodW1z?=
 =?utf-8?B?dWl4NDNmZG5XcktCazkxZWE0OVI1a2tBMUI1Wms0L2dTV3YxbTNaUFl3OWky?=
 =?utf-8?B?R0toVGpyQWpJU3MvdVR3Z3RLL3gyV2VhWmpTQXJLTFQ2bnNyeTI4eTdWZjhB?=
 =?utf-8?Q?paLbdkSqyu8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVlIRTJ1SGJSRGgxSEVZNkliK085S1Z4bzJBbmM5MWdKWVB2bDN4RXRDaW5z?=
 =?utf-8?B?Y0dnTUl2dHM3bjJtNU40Qjh0SmsrY3ZXVUpPdVRNU2hWMzFSalBac1k1R1hz?=
 =?utf-8?B?UnluUTBteEtac0FpRHNHbU12c3hqYThINStESnVNVzJiNlUwMHVXUWhtdjNT?=
 =?utf-8?B?Q1dkeXpYNURjbVpnMm1pVmpkaEdIRGUwaWZYN1BaMXVjYzhxVnBRQXk4dE9l?=
 =?utf-8?B?QjBmcFhScG9HeUpPVkVjSElRQi9ZZ2diUWJDOGRJWXlBNkJCRE8yZm1abS9z?=
 =?utf-8?B?Z1d0UWNCVmVFSDcvR211N0dzVlM3alI2YUlsQ2FaQzROYzI3Q0dxSzJ1MjRv?=
 =?utf-8?B?KzBFUy9Wb2I4cjRIbWtOeW9aNkNjS1RJQmV4eCtueDZNcWp2eVRJMFE0WWky?=
 =?utf-8?B?azBlWTE5RS9ETWV0M1h1ZUJ1NWgzNlRJWDNrbmZ5cEM1amxkU2tMRHE3bVpx?=
 =?utf-8?B?WDR6TjdxQnIzRmdkSFNPMEpYVHZrcW5TMkFEV1Zwb3dKTzdKUlpjNnNndGI5?=
 =?utf-8?B?UlJzYm1SYWlFVGtaenRGZ1lOc2RnTmR5SjRGdXFPbEo3UGpBTFh4eS9MZGtJ?=
 =?utf-8?B?S3Zxc2ZMT092T2NOR2krV1Q1SEwxMG5iWjlPeUpXblBBOWlNVEZzTUUvdWpX?=
 =?utf-8?B?NzZzOHlqZ2FHL0lUZDhWNnRCWGFodUF1bVJubVF5SkFlNzI0TTNoUy95N05F?=
 =?utf-8?B?a1BvYko3SWFIaENHc1A5Tkx4STZDajZMcHdXampVNTErUHVTOWIzZjE4c1dr?=
 =?utf-8?B?Z1F4RFB3NXplTFFhUVp4NUJpVEZWT0pTK2lxRDJBaS9iVHU5UTA5VUdGRnJn?=
 =?utf-8?B?anF6OHg3dXdRaWFGWFUwTjBaMTJBUWJwa0Q4VWlyUUhPVXZxdkRDUkRpcGt6?=
 =?utf-8?B?c2l2ZlhmVldXdnJ5NDNaQ1psVTVTVlMxcEpUNnQ0U24zZnU2bUk4ZC9WRkdB?=
 =?utf-8?B?YWtORDh4ci9qMmF2eXhqUkJGYnVsQ3ZuV1VhVHQveTN4c3AxT2lRVldGRTJn?=
 =?utf-8?B?WGVpSDZHckp0YThwMkZ3MHpEVjRRYkZSUU5QSkhaUGJjSTBVaWNKeDhhbTB0?=
 =?utf-8?B?SE1ZYkFVTWczVlE4MHloM3RreFp5OVBHeWpNYUdZUUZzOXhvWFNTMlpuVGpH?=
 =?utf-8?B?aUc4bFBBUHp6WURrZTh3VWZpZlBvN3NPQTFBNjVTZzkwZmNBQ2tRaUtySkJU?=
 =?utf-8?B?KzBhQk9WVWNsZlowWmVReTBGT1FlNXViN3phQ2ZWQ0V3UkZIRlVrRmhtand4?=
 =?utf-8?B?QXJJYURzalVrakJacG1aQ0hWZXh5SXU4Z2tUcWZkaENNOWNROEVCOS9xbmtx?=
 =?utf-8?B?UFpmVS9wRXNNUG5EMkJmZkN4NmhHVEo1MEllUXBVcWpheENtYUZiTTFnVUZE?=
 =?utf-8?B?eTkwQjE1QzBNZXdTNlIvOTJqSzIvVExRUGRhbTJZRmhBVE51djk3VFB6bHI0?=
 =?utf-8?B?cXA1aG1kdjNiTk9ubFFiVXBFOE1mcGpxeWRnT0YzVlVOYU1iczFQMlNhL1E5?=
 =?utf-8?B?STFCUFI2a0ZIbFQ1bnpteTVXMkRzRW8zTEJpaktjcnNZTkNaTnkvQXhkSTNV?=
 =?utf-8?B?MzRuYlhKZjczOFM0M0tFTVpqOHk2d2tXM3Z1QTdUZ2Mrakk0Q0pGNWw1cmw0?=
 =?utf-8?B?RVl3dU5oYXJpRWMrdkJVUlBBSTVIdTBocTZVKythRFdnZ0J2VXZQZUFRMXhM?=
 =?utf-8?B?Y0VUVE5nbVRFaFRNOXJGZWF2cThOOGZET1FHZnNQWXpuNXNGYit4d3BQekxP?=
 =?utf-8?B?Y2VyUENCcmplYVR2SkV0RHJEMlJCOXc3MU1mWlZqV0pTdmIwOEtiOC95OE5B?=
 =?utf-8?B?RlpMUkN5RDJQTU1LZ3ZyTnZ4bXZvb2F2dloyanN3ZUpLNy82ZmpzdlZiSUNy?=
 =?utf-8?B?MDQ1L29YUm43Z1hybWdrZXVjUGswUklCL21sQTY5MTlBTFpaSHBSNVJrODh0?=
 =?utf-8?B?a3FnZVBFTTlmekc0M1hha1k3MjRPcndLSGVkQXZtbUpzakRrV1B1K1VQYWdl?=
 =?utf-8?B?WVlKZUt3N2NCbFZlcEIvSm9oUzhlbGNzNHZwWmJNRERqdm1Bb2hLd1Jwa0xi?=
 =?utf-8?B?L3k4SDdCTDVDdmQ5aTZUR00zTXhyOTJYN3ZETjhpU2RxTzFFVTRoZEd4M0hO?=
 =?utf-8?Q?bDih84cMlX4QHxdsgJEz0ECJi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ba4398-ce53-4c8f-8c43-08ddd5928299
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 09:12:19.1230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYNbfk66r+M6YelhjybGomzPsD36a9z5z/IrMwwotMoY3jSOmNsuOmYU4cqHAmu8w5RJtqjPHEMMWHKq2iar2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF70F768FD5


On 8/7/2025 4:38 PM, Chao Yu wrote:
> On 8/6/25 15:09, Liao Yuanhong wrote:
>> Currently, we have encountered some issues while testing ZUFS. In
>> situations near the storage limit (e.g., 50GB remaining), and after
>> simulating fragmentation by repeatedly writing and deleting data, we found
>> that application installation and startup tests conducted after idling for
>> a few minutes take significantly longer several times that of traditional
>> UFS. Tracing the operations revealed that the majority of I/Os were issued
>> by background GC, which blocks normal I/O operations.
>>
>> Under normal circumstances, ZUFS indeed requires more background GC and
>> employs a more aggressive GC strategy. However, I aim to find a way to
>> minimize the impact on regular I/O operations under these near-limit
>> conditions. To address this, I have introduced a bggc_block_io feature,
>> which controls the prioritization of background GC in the presence of I/Os.
>> This switch can be adjusted at the framework level to implement different
>> strategies. If set to ALL_IO_PRIOR, all background GC operations will be
>> skipped during active I/O issuance. The default option remains consistent
>> with the current strategy, ensuring no change in behavior.
>>
>> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
>> ---
>> Changes in v2:
>> 	Non ZUFS can also be adjusted through this option.
>> ---
>>   Documentation/ABI/testing/sysfs-fs-f2fs | 13 +++++++++++++
>>   fs/f2fs/f2fs.h                          | 18 +++++++++++-------
>>   fs/f2fs/super.c                         |  2 ++
>>   fs/f2fs/sysfs.c                         |  9 +++++++++
>>   4 files changed, 35 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
>> index bc0e7fefc39d..12fda11d4da5 100644
>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
>> @@ -883,3 +883,16 @@ Date:		June 2025
>>   Contact:	"Daeho Jeong" <daehojeong@google.com>
>>   Description:	Control GC algorithm for boost GC. 0: cost benefit, 1: greedy
>>   		Default: 1
>> +
>> +What:		/sys/fs/f2fs/<disk>/bggc_block_io
>> +Date:		August 2025
>> +Contact:	"Liao Yuanhong" <liaoyuanhong@vivo.com>
>> +Description:	Used to adjust the BG_GC priority when issuing IO, with a default value
>> +		of 1.
> Default value is 2 if CONFIG_BLK_DEV_ZONED is off?
>
> Thanks,

Sorry, I missed updating the description. Is it more reasonable to set 
the default value to 0 for versions that disable CONFIG_BLK_DEV_ZONED? 
If so, I will submit a new version to correct the description and 
initial value settings here. Thanks, Liao

>> +
>> +		==================  =============================================
>> +		value				description
>> +		bggc_block_io = 0   Prioritize background GC
>> +		bggc_block_io = 1   Stop background GC only when issuing read I/O
>> +		bggc_block_io = 2   Stop background GC when issuing I/O
>> +		==================  =============================================
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 46be7560548c..fe41b733fbc2 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -155,6 +155,12 @@ enum blkzone_allocation_policy {
>>   	BLKZONE_ALLOC_PRIOR_CONV,	/* Prioritize writing to conventional zones */
>>   };
>>   
>> +enum bggc_block_io_policy {
>> +	BGGC_PRIOR,
>> +	READ_IO_PRIOR,
>> +	ALL_IO_PRIOR,
>> +};
>> +
>>   /*
>>    * An implementation of an rwsem that is explicitly unfair to readers. This
>>    * prevents priority inversion when a low-priority reader acquires the read lock
>> @@ -1804,6 +1810,7 @@ struct f2fs_sb_info {
>>   	spinlock_t dev_lock;			/* protect dirty_device */
>>   	bool aligned_blksize;			/* all devices has the same logical blksize */
>>   	unsigned int first_seq_zone_segno;	/* first segno in sequential zone */
>> +	unsigned int bggc_block_io;		/* For adjust the BG_GC priority when issuing IO */
>>   
>>   	/* For write statistics */
>>   	u64 sectors_written_start;
>> @@ -2998,13 +3005,10 @@ static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
>>   	if (sbi->gc_mode == GC_URGENT_HIGH)
>>   		return true;
>>   
>> -	if (zoned_gc) {
>> -		if (is_inflight_read_io(sbi))
>> -			return false;
>> -	} else {
>> -		if (is_inflight_io(sbi, type))
>> -			return false;
>> -	}
>> +	if (sbi->bggc_block_io == READ_IO_PRIOR && is_inflight_read_io(sbi))
>> +		return false;
>> +	if (sbi->bggc_block_io == ALL_IO_PRIOR && is_inflight_io(sbi, type))
>> +		return false;
>>   
>>   	if (sbi->gc_mode == GC_URGENT_MID)
>>   		return true;
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index e16c4e2830c2..a21cecc5424e 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -4629,9 +4629,11 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>>   
>>   	logical_blksize = bdev_logical_block_size(sbi->sb->s_bdev);
>>   	sbi->aligned_blksize = true;
>> +	sbi->bggc_block_io = ALL_IO_PRIOR;
>>   #ifdef CONFIG_BLK_DEV_ZONED
>>   	sbi->max_open_zones = UINT_MAX;
>>   	sbi->blkzone_alloc_policy = BLKZONE_ALLOC_PRIOR_SEQ;
>> +	sbi->bggc_block_io = READ_IO_PRIOR;
>>   #endif
>>   
>>   	for (i = 0; i < max_devices; i++) {
>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>> index f736052dea50..efea15209788 100644
>> --- a/fs/f2fs/sysfs.c
>> +++ b/fs/f2fs/sysfs.c
>> @@ -674,6 +674,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>>   		sbi->blkzone_alloc_policy = t;
>>   		return count;
>>   	}
>> +
>> +	if (!strcmp(a->attr.name, "bggc_block_io")) {
>> +		if (t < BGGC_PRIOR || t > ALL_IO_PRIOR)
>> +			return -EINVAL;
>> +		sbi->bggc_block_io = t;
>> +		return count;
>> +	}
>>   #endif
>>   
>>   #ifdef CONFIG_F2FS_FS_COMPRESSION
>> @@ -1172,6 +1179,7 @@ F2FS_SBI_GENERAL_RW_ATTR(max_read_extent_count);
>>   #ifdef CONFIG_BLK_DEV_ZONED
>>   F2FS_SBI_GENERAL_RO_ATTR(unusable_blocks_per_sec);
>>   F2FS_SBI_GENERAL_RW_ATTR(blkzone_alloc_policy);
>> +F2FS_SBI_GENERAL_RW_ATTR(bggc_block_io);
>>   #endif
>>   F2FS_SBI_GENERAL_RW_ATTR(carve_out);
>>   F2FS_SBI_GENERAL_RW_ATTR(reserved_pin_section);
>> @@ -1342,6 +1350,7 @@ static struct attribute *f2fs_attrs[] = {
>>   #ifdef CONFIG_BLK_DEV_ZONED
>>   	ATTR_LIST(unusable_blocks_per_sec),
>>   	ATTR_LIST(blkzone_alloc_policy),
>> +	ATTR_LIST(bggc_block_io),
>>   #endif
>>   #ifdef CONFIG_F2FS_FS_COMPRESSION
>>   	ATTR_LIST(compr_written_block),

