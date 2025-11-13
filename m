Return-Path: <linux-kernel+bounces-899977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B665C593FB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD6C0358BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5A433FE23;
	Thu, 13 Nov 2025 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="XL6IWX+r"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023072.outbound.protection.outlook.com [40.93.196.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A1130DD05
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763055504; cv=fail; b=ibv+xaZi3ile093EsK99fz4VXx/L2xNC9Eq8ovKJU1KXU4ffCBs1cYxFTKY9eTZkf8zUaJDvj4mgDCH2GfgIvecNByUhKwwZVO4DsUrRsmo6tu1iz+foqJgkgyv3gpBqFA4614NihKq8I09TNQzuEc4roIJeEl9BFrOsY4GxIgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763055504; c=relaxed/simple;
	bh=m56XBZ9+hXKCG/rlIpIRASWvEzZ8KBc3QZWbaSnQsJc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eKT2duXFWkt9HvAy/lqbKj5+uMFqeAZVtmMRKsImAqIpkimt55BhZGuUBOolapm+rER1eX7t/03vwxDIgxNMVzd9Mo16NCk1jiOs3CHKBDxEx9EI3RWE5dey4+1ounfVb+FBtq2oFQl0VcocrJCqXF8uaDC9y68GSRk99j4vOjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=XL6IWX+r; arc=fail smtp.client-ip=40.93.196.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etXEwlV8XnXJb+crMMz+tIYmiovox4I6yLP90SKbnDlASTQ14Gt4Y4CBZmtXnA55PbUM/bU2xXIuoMd0wdFZzQ24xnsw9r9QoHrBEhUa1IPlAxpDpQoZBr7Uplvu12puzPfA6l7AzBU78CdJzCTHckON/FtUg1TJrQeolZI4FGkqmRUWCois1esNmjpBoTIfAIwrRazQMdxj27kQXDDtR52lX3TxIwu5pVeL26+jHNdvP6ts6350OPOvT+su7ybgmnA7g44T38nPK8p3N5s/bc6zMLiTKyuzjG+s+w24dPOfGPu6RbFHqwA81gpu7EGSX7EWzmJBl/JN1KldErfQtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJGMVItCMdERCvJOv+FUrYJFSgRpxAnNaXzgejNuxRU=;
 b=yzt5Mo/vJ1i+JqwHDMLvDTiyHCL2EZCCBgGEAOhLiKJaIcGKSq5kjmlqJqzKoCZiQvWo1ae1IGD9DYYLve5XzCBIHPdu+azEvNAcTHEwE0VJnlX/n7DMDE/1ZABA32nXLD+SHHOB6pAyoD35BsX8a3M8zGv05Zaa9AjI+xKQObKPd+XwG93Aro9K/XMkvivWfpCuNlshiZY+7I3GDMLkEW+c2k/LxEZKo1DGEULlZ5/cEz0gE6RFy8bLW/YFugnFxUEeJ1yF9MrDFe+ct37HiiOAchSqo1Np17T64MKXAEA9ITR4qRpWEiPkrO1hUzARoDqKgrKDMuO9WubeCDHCwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJGMVItCMdERCvJOv+FUrYJFSgRpxAnNaXzgejNuxRU=;
 b=XL6IWX+rqNauDVInMJvQ3+D+JgcxN4FXHIZ7t5yzamJt1f60SOSsppok+KfCczJzLmKvtliw16KW3fj9HQ8IWaL9GuLUi0BPWOKZtHLuh9At5kexIGFq0DnkUjGdSYj7Fx7iJRpvCsJ1iVafcq98uIt7oHj6ieYxNmf4jb7Wt8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 BL4PR01MB9097.prod.exchangelabs.com (2603:10b6:208:590::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.17; Thu, 13 Nov 2025 17:38:19 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 17:38:19 +0000
Message-ID: <ed879c7d-456d-4981-9949-1edfc8b9af71@os.amperecomputing.com>
Date: Thu, 13 Nov 2025 09:38:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64/pageattr: Propagate return value from
 __change_memory_common
To: Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 catalin.marinas@arm.com, will@kernel.org
Cc: rppt@kernel.org, shijie@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251112062716.64801-1-dev.jain@arm.com>
 <20251112062716.64801-2-dev.jain@arm.com>
 <6bc0fac0-3c00-4ecf-948e-5648584ec939@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <6bc0fac0-3c00-4ecf-948e-5648584ec939@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:b::29) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|BL4PR01MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: 014478a9-5b7a-42b6-6507-08de22db6f3e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGRrbFNmWmNVYzBiaXo2TmdySEJWbUEyT1loYnp4RE5hZk9BNStNd0dqTU5T?=
 =?utf-8?B?amZnek1HNmRoUFVJRTFPekpLWllaSVNyOXlOaHpza05uUFNZK1luVHN4aVFN?=
 =?utf-8?B?Zm92N0E4Wllmb09sdE1HS2M4VUs0RHQreHBtVUJUb053SytIUWFReDdseTRM?=
 =?utf-8?B?MlhLaWp0L2VLZFJUWkF6N3ZXVjlWTmVuYzFnZzl5cUphQllTaHdUd3RvMEZp?=
 =?utf-8?B?dndGa1pRdDNPWk9GaHJwc1dDVzg5dThESHhEbGdFMnl5UzNBTXpqdzJXZ0RI?=
 =?utf-8?B?NnU1OWZBZ1RXRThrVGR4akRaMEZpdXY4em5WWjdicmRGaDlHRlg3M3o3cXpS?=
 =?utf-8?B?MTZ0endOU1p5Z29rdEVPSkZFTkZESC8ydnppQmI0d0JDRVJEMStJUEFrRXlW?=
 =?utf-8?B?aXFZVk5xTHMvZEJIbGIzbHdlcGtEbW5xTlNDMGRQTW8xT3UzU01pYlB2T09P?=
 =?utf-8?B?ZFFhbzM3MVNodmtSaWYrM3pDVWowK2IrTktoVEZFc2ppTHE5VWhPdTVpYWNm?=
 =?utf-8?B?aXVhdGVvOW5mM1RaeDV5RDd3cE1rTUY3MkJwcGhCZ1QzdUFSNG5XaGFQMjNL?=
 =?utf-8?B?eTZaeG96NUV0cUdGMlU5Vk5TcnRFU1VYU1dZcGg3VFRLV09JdmMyTVFUV2Fy?=
 =?utf-8?B?QldOUnl4VExHc1Mxd001eWdDd3J0YnJtemxRaGRuMzdsYmQycFJNQmtNdmJw?=
 =?utf-8?B?ODhpRWtQM0Z1MzRwVUxSRW1EYlJCVVhBYVhNUFZMVk9BaU1rZGNET01obVpS?=
 =?utf-8?B?bDBHYzBkUE9ISnVsRnJOVEZqWERLOG9CZFpnVTh4ci94K3AzYi9QYldQRlR3?=
 =?utf-8?B?ejNnRmZMY0srclY5N0lMeERBRmZaYUZPRnRiMndDbzBYSStwUzBJK0FSU2xP?=
 =?utf-8?B?dFdRUXlaNFFGamhwUXZ4WGwzbEdGVUluYWswcEFtR05uTWo3TmlLNDhFb0xI?=
 =?utf-8?B?SFFLUmZjVHo0MTdjS3F5TmVXeHdSTUhvWi9uektrb2M5eWpOdGRTRm02Nkpn?=
 =?utf-8?B?K0JuNkV5R1lBNVAxNTJ5dlNjeTFpRDZyRnpkZDJ4THp0c3YzMGFWZjFGZVc3?=
 =?utf-8?B?cVZCOVBqWEFLQVpSbXZ5UGNCS0Q5RlFGb2p1Y010ZEJjOWtFUmRITllmYjV3?=
 =?utf-8?B?WVpxVlk1dDNnQ3RVeEsvek5IMW9ncE01WlNQR3F1MnVVVFIxV24xSFFhR3JG?=
 =?utf-8?B?c0Z2SUtETjJ5MXY2elFHRnViL2dsQlZHeVhqYm5TeFlwWkpRdnhCRUV3SENi?=
 =?utf-8?B?TzJzYlRzRTNMNEpqdEJFeXJsOWxQM3VHZldiYkttL3cxZW5OSkx6MmlBWlpW?=
 =?utf-8?B?aUZFaEpZZkduSnlhMHIwZkt4L0NGZVFwdkd6Ry9jbk9NcHJLa2NHQ2pIMkY3?=
 =?utf-8?B?OS8wYWZkRlFrOEV0cVErdExTTENpVzBucXlKbG9uQTVoTUIzL2ZtWXIxQlln?=
 =?utf-8?B?ZldGSlFSUkhFR01MRStSNW5nT0VUUXBDYUhYeHMzZStDUGx0bTVkYWtGeUxX?=
 =?utf-8?B?UW45dVk3WU9OQm5QamduU0dBRVJYL1JxdXp4NWpZMjVTWGVXZVM0YnN4ZDNz?=
 =?utf-8?B?OThPRlVuY3N2WC9jOEY0TVlSTk1HWTJ4eWpyaG9ZOWg4d0U4RFhkZjUydmVJ?=
 =?utf-8?B?MEFTaW1OZTVsU2RCNGtHcElqUGt6TitoOE51ZmQ0NEtwSGlOTEFock9QYTJP?=
 =?utf-8?B?T00yYWxjdVBVWUJKVkExd0sxRms5K2p1bStHSU9RU0JIU3ZXSEJxc0tFUERP?=
 =?utf-8?B?ck5FM0lvUDdhN0xtUjNRWXBTb3JxY0drZU8vUlFoam9vQjZEMlBRLzlZRFBp?=
 =?utf-8?B?RjNWUFEvSG9yNGlRb2dyOXVVUC9yc2R0MkxaS29wMWpCZHVMWXNoOUFPRy9Y?=
 =?utf-8?B?K3ZXUkRnM0dZZnFuREV0dW5VSGNKUzR6V3RUV3JYOFl2bTg0ZS80cFRLOUox?=
 =?utf-8?B?ZkdCeTBSWVY5TE14UTVnSUdGNmhyWlRYS2lTSmg5aGkwcGxlWDR5Z2FBekww?=
 =?utf-8?B?Y0hZcFRieFV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2hJZDVkQ3hiWUpYempXZlUvakhOY0Q0a0wwSWdKTE1keEJCT0lLenM2UkNK?=
 =?utf-8?B?QXg0YVVZQld1VWJ4WnAvd2hDRGpvTG4yUUs4K3c2UXhTRDh2eWdnR3BVMU8v?=
 =?utf-8?B?cEVSN1hxT09BdCtWRzRZZDVEOFNJZU1aMWRzS1FjT2Vod0xJOS9zR3FGdUxj?=
 =?utf-8?B?ZVNQNUROVXpYaWpML01la1l4aE5xeURTL3NyQ1g4Y1Q2V1FRUXVmM2dyYTI3?=
 =?utf-8?B?QWpXSENJdVJGUnE0SmVkRStNNktKc2VJRkFYWTd0dk5lelp4MnpOSUYyWnlL?=
 =?utf-8?B?RlJTUGZDUnBhOXFYMXVKRDlFdWVvcVZ6YVo0SWwzakZWamZzRjhhd3FwZ1hX?=
 =?utf-8?B?M0RsSnhzZElVdDJGZ0M0VUtsVW5FRHV1M29QZEVPRkxRYW4xMnBSRWl0Vnhk?=
 =?utf-8?B?V1BPS1VhdzVZSkJtc2VMczNZR0MyOFpKVlFRcEVUV2RNc0lKSG96TVJOb3d2?=
 =?utf-8?B?UnI3REQ2dktZdURPWGY3ZzEyTitvdmUzcWFHdXFWWWt1NlVzM3hGZzR4dUl1?=
 =?utf-8?B?cGxKSVU0d2kxeGg3NTFaRWE1ZWN1cDF3MHJpcG0zTHk0NjBGeGlOdGtKRE9N?=
 =?utf-8?B?V2hDRzNIZ0FkY3phRWdXVFlxVGZOVm03NXE0ZTY2ZzJJTE5HMW9kUEpWd2FN?=
 =?utf-8?B?VlhBelpjZnJCZnlSSkJ4WWZsbTN6TVBDdUg5ZDdOTlo4KzdoMHBqWjBEaXlM?=
 =?utf-8?B?N1RMNnVzQktSR1pkN082Y2Zwalc5Y2JOQUxqNk4xelpPRVY0aUxLR3I2ZVlj?=
 =?utf-8?B?bG44MUJ0Q0h0Ulc4cDd0VWpXQVRjNTlSQWN4ZnNMdkZUM1VqclRtc0FtQVRL?=
 =?utf-8?B?em44WW9sN2hZNlByOEdvbnFVNG01L0wvUEMxdEVyYXVqNTNISlAwRUhxV05J?=
 =?utf-8?B?V3Jwa2p2bWV1ZStpYnBoMktnaU80cXRUcS9aUzJHSU90bGxoTi8yZndHOE9z?=
 =?utf-8?B?bVIwaU5FUnpXL3FVS2xGNmRQOTdQQktVakhwT3V1cUQ4UStDYk5NV3MrblYv?=
 =?utf-8?B?UHc1QkZVYWdJNTZSS096L1ZyR3hZVUljQ3hHanE2ZlJsYmN2R3d3by8ybGl1?=
 =?utf-8?B?V0xWMU5VT0owc0FZTWxYMnM4R1Jna1dTUTQrQThJbzgxOHJsZVhLekRlL1RC?=
 =?utf-8?B?aEpQMHN1ZGUvb0loWnVFN3BJbVdsc3FNMnMrazQxN3JKelpPTEZjZVppemlu?=
 =?utf-8?B?UUFyc0tUSXZlbTkwbStUeEJJWXZSZ016V1k5WkhZYVNPRlRMaDJOZDlheHBi?=
 =?utf-8?B?SFFGYnJFczZWMnJRUVc5SEJtWDJEVXBTM0RuSkQyaVJEc2wyamFtNXZPVmhH?=
 =?utf-8?B?TkJSN2dMNW0rS2ZlNFRENzdQTHZDNkdWdEl0a3cxZE05a0VGTFIzUmtPZEtK?=
 =?utf-8?B?WFNjV1h6bjZwWWtIMUJOSFdBcVhpeEhvVkRkTlBaZnBhOVhrWGszVnRUb0Rq?=
 =?utf-8?B?ZElBVVY1cHZod3p5V3Q5TW1zR1MyZjlYVzBDdWVJQWxLMGs3UE16NVdGVDh4?=
 =?utf-8?B?cEExQlJYeW52L01KbDhML1ZkR1RmamcrWUs4QnpLRTFJdUo3UUVCQm5KTWYw?=
 =?utf-8?B?am9BZWZULzRZUWdCNDY1aUlZNTBpaHhmVG9iSU9leWxnL1d4TzMzOFFRYWhh?=
 =?utf-8?B?Y3RmVUI3QllKSDRxWkdPQlVrQVFYMzZQbEE2USttcURGMXpEeUtHR01WTEx3?=
 =?utf-8?B?QnBGdVVNMllXc3RPeXFVMklaYS9lT2lmNzlRWUt3U0JJNk80TXp2aUwzYlQ3?=
 =?utf-8?B?L0t1Ym9Ja09jdUU1NVFGYlloYXBieGh6KzhsdUR0elMyVTd4aXdHWEpEUVZE?=
 =?utf-8?B?NXkzcXE5VDR1SDlRRTJaUE9MMllxeUdGSlJGZXlOS0xzMUlpYTNTcjNUTit2?=
 =?utf-8?B?V010b0hDaVVLVWsvMWtrM3hwMkZvaHV2S2tqRldIdWs3elo1N2lwcUtrcUZr?=
 =?utf-8?B?czBMT0pjN2N1Um5oUEVMeFErTHBWbWwwY1h2d3NDMFRER1VjdVQxM0ZCVHdl?=
 =?utf-8?B?enVzdXNNWkd4RERYUHR0MjRHNUIrWnU1L0pQR2N6eURtZ002Vk11M1NzZ09I?=
 =?utf-8?B?VTMvcXpzd0p3TTI0NlBVTVhiUHhYbVNQdFZJNjVmZkM0VTlrSVg0T204Rm11?=
 =?utf-8?B?cVdESzE4WU9zSmRuMGtRWDFlblV0S2x2cVNSRFlFdmlwdzNJWVdjaXkvTDBI?=
 =?utf-8?Q?7U5crbACbKY5YnZKnCFJFKg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014478a9-5b7a-42b6-6507-08de22db6f3e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 17:38:19.4020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQcoNBjEQfes4FAnRKJsWbt6vF6nVVak02LG862JsIKE0MsGS1n3AXfPQ472RP2AbFZ+tBlFmCA7uBZOVHIJB2thd7lzl1RUwMNGlYauXek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR01MB9097



On 11/13/25 3:55 AM, Ryan Roberts wrote:
> On 12/11/2025 06:27, Dev Jain wrote:
>> The rodata=on security measure requires that any code path which does
>> vmalloc -> set_memory_ro/set_memory_rox must protect the linear map alias
>> too. Therefore, if such a call fails, we must abort set_memory_* and caller
>> must take appropriate action; currently we are suppressing the error, and
>> there is a real chance of such an error arising post commit a166563e7ec3
>> ("arm64: mm: support large block mapping when rodata=full"). Therefore,
>> propagate any error to the caller.
>>
>> Fixes: a166563e7ec3 ("arm64: mm: support large block mapping when rodata=full")
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>
> It would be good to get this into v6.18 I guess?

Yeah, agreed.

>
> Although I think this will conflict with a patch from Yang that makes this work
> with a partial vm area range - But I think that one will only go to v6.19.

Yes, it will conflict. But it is quite easy to solve. I will rebase my 
patch on top of it once it is picked.

Thanks,
Yang

>
> Thanks,
> Ryan
>
>> ---
>> v1 of this patch: https://lore.kernel.org/all/20251103061306.82034-1-dev.jain@arm.com/
>> I have dropped stable since no real chance of failure was there.
>>
>>   arch/arm64/mm/pageattr.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>> index 5135f2d66958..b4ea86cd3a71 100644
>> --- a/arch/arm64/mm/pageattr.c
>> +++ b/arch/arm64/mm/pageattr.c
>> @@ -148,6 +148,7 @@ static int change_memory_common(unsigned long addr, int numpages,
>>   	unsigned long size = PAGE_SIZE * numpages;
>>   	unsigned long end = start + size;
>>   	struct vm_struct *area;
>> +	int ret;
>>   	int i;
>>   
>>   	if (!PAGE_ALIGNED(addr)) {
>> @@ -185,8 +186,10 @@ static int change_memory_common(unsigned long addr, int numpages,
>>   	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>>   			    pgprot_val(clear_mask) == PTE_RDONLY)) {
>>   		for (i = 0; i < area->nr_pages; i++) {
>> -			__change_memory_common((u64)page_address(area->pages[i]),
>> +			ret = __change_memory_common((u64)page_address(area->pages[i]),
>>   					       PAGE_SIZE, set_mask, clear_mask);
>> +			if (ret)
>> +				return ret;
>>   		}
>>   	}
>>   


