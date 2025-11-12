Return-Path: <linux-kernel+bounces-898267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C0BC54B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9C734E02F9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F672DD5E2;
	Wed, 12 Nov 2025 22:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="lfVjLNo/"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020116.outbound.protection.outlook.com [52.101.46.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C067E247281
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762986876; cv=fail; b=HuUW6eKHt57Q+WZh+tWBCuBevp33QK4ViDVMcpSkDzxCbpOmjG/NLryDkHrqYp+HGhCv977XQDyHemBMOmr5JiIm9BZ1b/XJth44ACG7fhr5zZuHVnZF6syCRzF3nBTm8zslvuIZkmPKTBBwqb7p45yJ7eyhakec2JI2dytEAEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762986876; c=relaxed/simple;
	bh=p5fSfGRqW9tAUmMQc4quLDtS+gre1dwGLgfcUnp7/JQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EkoAU6FWKETRsebHKwHAJygSqxNA1TSIV/U3epQvy9eaR+cWGTamXDtLVpIIsMl4ko84SvApDF5eDvUgi8b7QFO4sUCusDMtcuPgTni9qr7vhlQfk9n0kiF/idM3x8fyHAlIVIzexE0kB07JZ7eE5jP0RPsnvHOTxhRIq6/VmKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=lfVjLNo/; arc=fail smtp.client-ip=52.101.46.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Khh5KSzEE374RdSZl6Sgd8gSFhVC5eQaoiYNyCuO/d4zGi2WWP622br/fJPUMZhis8qgULyncQAg9DfM0sgeCElTnqLOncsQFhdw6wMt1yZgMH5vAzjH4fn7ZyGrVTEu+Ag/YphU+2/xumj1xnoVuUIC35PGwo+oegCugGAlbLo9NNeKXmwZMfWGxumThxQmimcTge652aH82JF8esQWy2FwLHwOMdTpBSIHahiK8wOLgFmlreTZ4dwMMZENqe+POzNS/GuH5qCsTzeWfwUtSOibpKDavWmisBmNibsxrbwFA2kW6F5WGMi9aJe8P5M0svF/1KU3XqNneQI1XxewBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+H37iBdsKfzA8qH8zBG9kjfR4zdvSDrKwMGXltipC4Q=;
 b=johawcgzZtF3dqy+m5N6ijz9HjcIHl4U8nJf/hlnZmNvLPrV/a3bBVCe1wyCI8IbOThekwjB3eOK8BBwshk+lf5jNxBYY7O+xCBXsqhdq61fRjZABF6711KMOdb+4ZNhTTKzWe6C7LeqbGFmDV+btAdheC2uJJo7E16Feupf1vNlQ5AKg3tx98/euZre5iCysjchuDPA5+Z8RZw0QSjNk5xGNozDB0eJjEQ0IU58C+o6uUjD9OCtPVISnEUGYHhih1KMXY1sfpyGIHj5AJSRQP1vl2j5cyMFi9Df85gJgbmDZ+Jbkem/xto0vPXPkLaRQTopVrQkRqKWQYrZ6VSgzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+H37iBdsKfzA8qH8zBG9kjfR4zdvSDrKwMGXltipC4Q=;
 b=lfVjLNo/Fac4xhjF/903a5ZFPo+LQgHj5iov2GtjKCvVO1a/3/5y9H20OS2CPPIq6wgU1oX9xovlpypZPcmV3tlZpnYN7Q8mP92/fxLbfPoHMhgADRGIP+sLnM720TBfingWnu+0FvcxnLmeIpIV6Mv5RNmoPV/ogeFNrbgsNHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA1PR01MB8249.prod.exchangelabs.com (2603:10b6:806:385::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Wed, 12 Nov 2025 22:34:28 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 22:34:28 +0000
Message-ID: <ddfd7c74-d115-4f23-9a42-817e40321911@os.amperecomputing.com>
Date: Wed, 12 Nov 2025 14:34:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64/mm: Document why linear map split failure upon
 vm_reset_perms is not problematic
To: Dev Jain <dev.jain@arm.com>, catalin.marinas@arm.com, will@kernel.org
Cc: ryan.roberts@arm.com, rppt@kernel.org, shijie@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251112062716.64801-1-dev.jain@arm.com>
 <20251112062716.64801-3-dev.jain@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20251112062716.64801-3-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::16) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA1PR01MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be1c150-09ee-4f17-c45a-08de223ba421
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTE3U2RvQVk0U2h2YnB2SExrWGtrOVBaWmFjMGlxTEtNT1Y1RzczbEQ2bkhq?=
 =?utf-8?B?cmRLbVI0VGlmdkNGNGtPclliTjZJdUpsNm1XUHQxbXBXUXByTlVEcTNJeHlw?=
 =?utf-8?B?UnJCMWFSZjU5Q0VWSFFyOUJDWm5wL3R4bUFPSzRzbjBKbExaa3o5em5iUy9S?=
 =?utf-8?B?Z01VQzhEZFduQ0lEYStBd2dJdFNjczNZV3BqUFEwZytvNlhOSWF1akkwUFpJ?=
 =?utf-8?B?TG9Ba3RsbWhQTHpvcVA3Vjk2Yk8wVFVZbjNoRm1EY28zamlndGd4dTMxekxN?=
 =?utf-8?B?MmMyWi81aFBWZ1RRcjM5ZDBZUDAwS0N6cVFTWmtOdStYeEZWK1hCbEJjTUhC?=
 =?utf-8?B?THBxUTFSOGFxS2pzbE9oT09Od05TejVjZi81Z25OakFLT05SMFlYUERlSDJh?=
 =?utf-8?B?UGJ0MnVsZlZpemVvdWdGcDhFTGlZS0Z3c3JSNUNSb1pKY2NoK0hMZThrRVZu?=
 =?utf-8?B?eU1aL2M3LzV6V0NNakI5S1JnMWdMZ1R5VDZNcGhHQzBaa0lKYVlhK0N3TERJ?=
 =?utf-8?B?d1JhSkxvTVJhcW9nNFM2WjkzWFd4VzQ1TmlWUTN0MlQ1WFRDR0FTVzZjZW9S?=
 =?utf-8?B?OWtvYlM3Nk5yQVQzZk5GR0ZCT1NkSVkwd0FMMWVNb3p2dVM3NzErLy9ZZXNK?=
 =?utf-8?B?bGEzMS8vMFBhODVXRVM4MEVuei8xRXJ0WEExNXlkQXdxM0JlZDNoNWVmc1V6?=
 =?utf-8?B?ck5sUHJPOHdveWEzNE53SnkwdG1UMlZZNDZZa0l6SEN6UWFJdVVyeTV4NFhN?=
 =?utf-8?B?WUNtaGJDVm5obDVWdldQS2Y4RGZGNk1jUmFwTzc1NjIzMmcybzB3bFBsc2Zy?=
 =?utf-8?B?eUsxcHNLaXhQYlpHVUpSME4vNDNGRE9LZXVMMGJPQS9na0JlMkNiVEpuK0xG?=
 =?utf-8?B?YWU5L01aU2pZOHBLd2dSVThVSFBTOExWeXNQYWs1THNRV2llTHhKc2JNM091?=
 =?utf-8?B?cSt1bUorM2o1STFVbERVdU11enRjR2I0YlBIdXpqcjMwVGgzNzBoUzBRNENN?=
 =?utf-8?B?SEZVWVgxOTB2WU5GZnBFSzRFOFdONHBZV0pCLy9oMzB3M3BLUG5iZzAzeDR0?=
 =?utf-8?B?L2cvaDlZYXcwUWMxMFhoMVpOUlRZblQvNnFHNXhHaFRoZDQ2M3l2bUNZd2dN?=
 =?utf-8?B?WlNpUlRpWkFrYWpxOCtDNjJrVE8zSmJ0bVYwSEgrYVV6WXNHR3MxZVhFS0k1?=
 =?utf-8?B?VjhrV21YTjFuVWVJMlZPSFZyQkUrRWw0a1lwaVFKSURnbUgvNjU5ai93cU05?=
 =?utf-8?B?YUNjQXRTMkU5LzhsaThuWFM2R3NaNktkZWJLYitqdjRCOHJ5dTVNNTdMQWg0?=
 =?utf-8?B?c0tjaWhOQ0o4allxcXQ4cGhQRG5BSndaMHlqY0tlNWxwVjcxb0Rvcyt3dmZr?=
 =?utf-8?B?V1VGeUtuT2tYTjc5OXB4WWM3RDliVWxYK0FDRnFObUFiQzRzNWRIRmRjZlhW?=
 =?utf-8?B?U2VVNWxSdnhnTXRUYWhUL3YzWEZoRGhwQ0R5RGhmRlBrWWZPWW44eDJPekRH?=
 =?utf-8?B?YlVRSm9QdkU1RFJrM2M2MVFZYVdwTDhkYndFMFFqM0FkdGtDbkdXclZTdXNs?=
 =?utf-8?B?LzJ0UnNNb0J2L0pGZkdmUVVnV2MvWThlR3ppUmE5VzhkbktQV1pPVkZ1YXBx?=
 =?utf-8?B?NE42ZTB4U2p3YlVFd3N3UDZ2MmdEdW83UmxGNFpaSk1tYy9VY0g3eURWOFFr?=
 =?utf-8?B?bUNqdmQwcG9xWGdSbGxEcXg1a3g0OGtVN0ppTEMxU0dZWU5nK1FrbmRJSGZF?=
 =?utf-8?B?aG0ycGl5U0MyM00zcUdtZkxzNi9hdHhvUitYbTRvWkFOM1NtdWcybEx1UTZq?=
 =?utf-8?B?TnlDWXRWUmdSUE1SQTA2OVU2cUN3TVNLL1pZcW42MVhTb3dyeUp5SjBIc2M1?=
 =?utf-8?B?UllvTGNwdjNNNVA0Q0hVTzYybEZxQTNVS2xsV1pZOGo3UnlCQzFHY0FFS3Vr?=
 =?utf-8?Q?FCRcgZPt4ywx4250RLGSDtSpfqrv/so+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTJJbHVUa3BWK09mLzFyWDJrdmdmakpMZVE5UVpXc244Ulk4djNDczVWaGM5?=
 =?utf-8?B?TUhwR2lWV0xzOHd5c0hJN1Vud3g5UXN2cWpwbXUvMmF0ZzNWcmljR0xYc2tK?=
 =?utf-8?B?azRmYjNqN0ZEOG4vbjZkcFN2VVhGa09yZW93eXR6SHNxMlk4a0NxclYyMnpE?=
 =?utf-8?B?b01TRkdNRXk3T0dKVU5XdldobG9NTEVhNUJQWjQ2cnJOdWR4UE9tYVczcHVI?=
 =?utf-8?B?QzRMemFvejF2QUlvMDJoQzZUOWlnaThLMHZQbGpucmlXaVY2cmtEa290U1Qx?=
 =?utf-8?B?RkFKajU5RzNRRGNUcmZ3cStkbFRoeTdhblBDTUc3YU9VRTBES3JaSUxEL2pZ?=
 =?utf-8?B?bnQrUnV1ZVBHSVFoYktMc0k0UzlOMzhJOHMzb09VTlRhNzRJaFA0NW9GZVln?=
 =?utf-8?B?NnQrSUhnb1BBN3UwZitVWEpBOWM4Nm5jelk2SmZqbmRhRzNFL0NNdHdQNWpE?=
 =?utf-8?B?LzFLbzBCbnRBd3g5WUVnYThsM2p0ZWlVK25VaVE5Sk5yVW9PZFM2YkxvMXJr?=
 =?utf-8?B?eFNSY1pXTmhwbm54Mk1uTGYxZVM5aG1HRHRGWkhlWnFuWUlCeStjajFGZ1NR?=
 =?utf-8?B?eGsxUDlnRlNOanJuSUZINUI4aDRhU2ZwTlRKdXdjUjVIMnBxQzEvdmtGVUQ2?=
 =?utf-8?B?aE44SjdkSDljeWVUZjZ3UG1QMkIyV2MweDZEbnI2bTJaRFdoVzcyQ0dmVFYz?=
 =?utf-8?B?MTh3TzRXMm5QdFBVU2xnOHZVQ2xNanZSRXRpK1p5VXZ4NVA5ckRXUmtuQ2xs?=
 =?utf-8?B?MGR1U3F6Tm9TOVdpbStVcTVnRlVneHB6NGJIOUxYd2hSdGdRSTFOcmtRN3pQ?=
 =?utf-8?B?Qjd0bDJvVU1aejUxcnFKSzEvM2YvWXc0dXFBeDhIMnZFbkM0TTFBWWYzSDZ5?=
 =?utf-8?B?bGlzbkdURUtGSzBOd0hoWlRhMnZJVHRTZ2I3U0JTR2tQOXlZNzVaN1BpQStE?=
 =?utf-8?B?TVplc3Njc2FhdUJOT0ZTblJrRysyNVdvbCt2aWhNdk1hL0w5UGVWYmMrbVpa?=
 =?utf-8?B?bFkwVlIzRklzRyt6OFF6K0lDMTBlazR5YlFjNUxFMStMWkNXMm5PcnJ1ZXdT?=
 =?utf-8?B?Z3VXeTQ4VGhsaDM5ZlhvVlJ0aUJZSTIyVnBFSFBTamFhU1pYaUxtZXpUMkNX?=
 =?utf-8?B?ZThtTlNGWUt6NG80ZjZ0UEFTN2d6bzQ3MEZHbDRiNXBUbk94SGI2MVNweGVr?=
 =?utf-8?B?cnAyQWdlS3ZSaEpQU3UyaU1lRW0zSHk5eGdLK0tSZ25ZWklIUGJpLy9Xcktq?=
 =?utf-8?B?SHBxT2tNRGJsMGQwZ3EwYnNYbkZDU1lKeWZVRHhpUHpBTGlxTlpZa2dkdEsw?=
 =?utf-8?B?TUd5UTQxZEhrWVVTdTBsbmIzUDBnV1grWklTSnMyMER0VU1lVmlxa2RFczVL?=
 =?utf-8?B?c0cxZExDL3VRSm8rN2ZGcE5uOE1TdkRTdTRQZ0NPemFCVnJDbmdCekhWNFlC?=
 =?utf-8?B?bE56cUplVmthWG8vNjhZSjBra2VzZi9EbGhKUVY1elE2Z2t4NnlSdkVLcVRO?=
 =?utf-8?B?SysvamZwKzhxYWM2TnJML2lTS2NaNXZObnJObjI1Z3NiUWFpeTlpWWMyL0dh?=
 =?utf-8?B?R2NKU0NnKzR2bmJsUXRvMTJOaGZTNGRMWnJRMEJuSGhDdFhEbE5uRXBoazZr?=
 =?utf-8?B?N2p6WkRkWkN6L00xb2Nvei9pWWxDZ3lQL0Y3bVJiWExjZzFrWjZxRXM1VHBZ?=
 =?utf-8?B?SEt0S1RhQ081U1p1cFE4czE0ajhxaytySmd3MDNkd2V0c2xscG9ncWNTeU12?=
 =?utf-8?B?QUt2WUk5YytmRGIxc25YamRyU1U2cndub2plTCtXYTlXNmdtVEt3NXJ5ZzR6?=
 =?utf-8?B?VXdUQmE4dHJWN21lZThILzVKbXhyRitTUHF6dFlST3pSU2FveUM1OFM1RTEx?=
 =?utf-8?B?VHNoRmN3a2wxeUFaMzZvbDhiZEpGbDREaXVlMzRiTi9tdFA2NmM1eVRhblVQ?=
 =?utf-8?B?MzJZSUc5ZkdVaGVUazhMUTk5b2dOYlJDa1AxTU5YcTZnd1ZIeS9yODZDcHpq?=
 =?utf-8?B?Nk9zQS9WdE1qSHdEMkxoYW5KN1JBS1AzWGpXSHNZV200MDUyVFByLzVzRmI2?=
 =?utf-8?B?UlBnMzVpKzYwQWh0VWN5WnBYK3pYQWRza0hndyswSzYrSGFSM1dKcGpUVlI4?=
 =?utf-8?B?cm9NTHF0UXkrTzA2bnBvS0d5ektmbFNuWTA1eVZ5WUtSdytpd3ZUZWNxOW94?=
 =?utf-8?Q?RoyRlOUnrFUp7WJimmMWfaA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be1c150-09ee-4f17-c45a-08de223ba421
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 22:34:28.6990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXufV91CaMADKBC4g3ZOkzMSzl4z3WIAXr/9iaNhJpECWDRPXIgl/yAyfxtnyQp0HQh/OyrmGZe6cWucxPY8Wq7cpW8mVAqaFloSW3Kxe3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8249



On 11/11/25 10:27 PM, Dev Jain wrote:
> Consider the following code path:
>
> (1) vmalloc -> (2) set_vm_flush_reset_perms -> (3) set_memory_ro/set_memory_rox
> -> .... (4) use the mapping .... -> (5) vfree -> (6) vm_reset_perms
> -> (7) set_area_direct_map.
> Or, it may happen that we encounter failure at (3) and directly jump to (5).
>
> In both cases, (7) may fail due to linear map split failure. But, we care
> about its success *only* for the region which got successfully changed by
> (3). Such a region is guaranteed to be pte-mapped.
>
> The TLDR is that (7) will surely succeed for the regions we care about.
>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Thanks for documenting this. Looks good to me. Reviewed-by: Yang Shi 
<yang@os.amperecomputing.com>

Yang

> ---
>   arch/arm64/mm/pageattr.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index b4ea86cd3a71..dc05f06a47f2 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -185,6 +185,15 @@ static int change_memory_common(unsigned long addr, int numpages,
>   	 */
>   	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>   			    pgprot_val(clear_mask) == PTE_RDONLY)) {
> +		/*
> +		 * Note: One may wonder what happens if the calls to
> +		 * set_area_direct_map() in vm_reset_perms() fail due ENOMEM on
> +		 * linear map split failure. Observe that we care about those
> +		 * calls to succeed *only* for the region whose permissions
> +		 * are not default. Such a region is guaranteed to be
> +		 * pte-mapped, because the below call can change those
> +		 * permissions to non-default only after splitting that region.
> +		 */
>   		for (i = 0; i < area->nr_pages; i++) {
>   			ret = __change_memory_common((u64)page_address(area->pages[i]),
>   					       PAGE_SIZE, set_mask, clear_mask);


