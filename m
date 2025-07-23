Return-Path: <linux-kernel+bounces-743205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B04B0FBE8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6967B5682A8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B38230D1E;
	Wed, 23 Jul 2025 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JcxlypCG"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2096.outbound.protection.outlook.com [40.107.94.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA96B1DE2DE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753303925; cv=fail; b=GrQZktIHUPW8gCjjEM4HibdmM6lIrvMLHz9nuIQKDrvnz4ldwlaC1rtUWFe0JKxRXfmg2x9K9A6PeJnnq635ooqH6AdwpdJtNqgnYiRk8D9RgKf7Z9qtakM9FeXTDv/E6loUJsvOnKXXhyMZsFw7RscNvbyAOCntFftjbBgC7aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753303925; c=relaxed/simple;
	bh=j3Ju5pWNSl8LtKRIF1nViNKcOQI3dA41eP4KQZJSXB4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DMzEBWzu2geM5Pj2Oj2x2v4Wv8hIbnQgvOE7oYIPk6yxjnSeVweM+tL4hWU0cIrnXmhNiv4O2CwasFzOumiibiH6aeBXWDnMm4ZL94F5YvDRKn8E4cbOq51V9dhkgOEA8sgGgmZ2mdbwxd6T3j8+JCrkm1KHwpa/h+OBqybC5wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=JcxlypCG; arc=fail smtp.client-ip=40.107.94.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwBLqgY4FK0j6Uorv7X0/E0AuexgzeZY92iynKTsw6pVChfBnpwPFpDnJ4Ilge1CV9ECBjx6wlzA4TIeBIyeIbyqbfZCPB5P9saxVNP113eeqnYDa7sBlueuKaeaw++obiOQGPmZqmBr3W/ev2Lelqmo6JdnqyPH7Y/dYXMepWTy7aEetq2hBWHkRmJ0zicGhRt+ENDe30kPikVEA7vaKS8E0lo9ueYKahH9vFrDM2m/OuwYaUaonO5io2wNPVA/TmCdxXqubd1PgO45CWARhTEnqfXPnAyVwoXYayhBwhrjOfO041cG7YEVCqDwW6mu48Bv3IwHDZ4klMG3QFY3fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHAtqFgYhUgk27idZGvvB/hKoMGOTvf9F6eXqZ0yPxE=;
 b=jnvr3TPisJWu4I+Ks87+7/RjuFLcu6YdoZv+YjrqpGg+xx6ud6HRzD+3FIKGHdDQ4/4btY1VgKQ99bC/FGaRSdfqchNa/A/Nep3PJeWlhj475VnmgxwElW/cdjD3/szsOL6ASH29DDlbjZmSiKcieoorLSLsg4Uasd0u0vB+AKf9UPxT7jRFCFAdBeFq5Lp5oWFISeLxiyT3Uy5cH79JVl5KWDP2LpmWv1m/CipLr3kABLlUNxJ3U9+LP6EaGGDl3bEPRqGONAhyMCl5bAT/LVmc/iBBkOk6TGVOZvlTJlZ/OtEXo+YhLh9j8XcGtXZvRCal/4EKajsqgSp2TgK/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHAtqFgYhUgk27idZGvvB/hKoMGOTvf9F6eXqZ0yPxE=;
 b=JcxlypCGrp3J6TfFVZGty4AltUYSi0U4gswmvFnCljO35HjbedjkqeVi4ktHRcNik/+S45xeP9uqfUiAXosRqyj8j8nd3wMier9+DkDo/mig0A8P2ALcDjSAtBRQmLx1++K+6rSwddPMpZUTb0tyuzEEWTK25LlGl+hkKhrSfHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB8118.prod.exchangelabs.com (2603:10b6:510:29c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Wed, 23 Jul 2025 20:51:59 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 20:51:58 +0000
Message-ID: <3b3be4db-4f8e-4d81-8e52-dadad23dcd24@os.amperecomputing.com>
Date: Wed, 23 Jul 2025 13:51:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: mm: support large block mapping when
 rodata=full
To: Dev Jain <dev.jain@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
 will@kernel.org, catalin.marinas@arm.com, Miko.Lenczewski@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250531024545.1101304-1-yang@os.amperecomputing.com>
 <20250531024545.1101304-4-yang@os.amperecomputing.com>
 <f036acea-1bd1-48a7-8600-75ddd504b8db@arm.com>
 <50a4f767-0007-4f6a-8c62-398962d54029@os.amperecomputing.com>
 <ed942c01-58e8-4d91-8f86-3b3645af6940@arm.com>
 <452be681-f28b-4b5b-848d-c967672b4f5e@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <452be681-f28b-4b5b-848d-c967672b4f5e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR04CA0086.namprd04.prod.outlook.com
 (2603:10b6:805:f2::27) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af23bca-6fe4-43df-8756-08ddca2ac41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NERCb3p4Vm9BYkJDRGlURE9Wc2lJem9PMkp0WVdINE9jQnlCbXE0WmxxbC96?=
 =?utf-8?B?bFlUdlVFcE9YTkpNeDNYQVJDUklxNEE4T3JQOGhrSkFkbHlkUUlQWVliNXZw?=
 =?utf-8?B?VVZLNEwrL0E2WWtuTzdXNkhCSHcyNEN2OUhvSmlkTHNrNDB3NXRFb0RSSnRO?=
 =?utf-8?B?MHVPZlkwYU15K2ZsdDlXUTdSVFR6cW9PT3Fqb1Q3QklrYXFHbnRwQ05sbmtq?=
 =?utf-8?B?L1FYQ1VIR3JTdnpiZkFUV1NPUzBTaVk2dkg4NkQ5MnVDVHIvYkg0R2NGZEFL?=
 =?utf-8?B?WVFRcGZzWHNNQVRGWGFhRmxZQ0RpZXNWTnVsUmRWWkU2V25qeC9Nam05U2o3?=
 =?utf-8?B?b2hPbXc0VmlxeUtubHVGbUpXU0p0NzI1N1lRemZYYXBYd3p1R3Y4VW1JUzRk?=
 =?utf-8?B?R25uNDhKN051TVF2Z2x5aU04RXl5VEY3RHd3M1JzOVJxVUhvRGoxcUhmS0s3?=
 =?utf-8?B?ZENmZlcwTWV0Wi82ajArcGdNY2l1WFZqbEJNTVhxNGIyUGkzQzFwQWdYUElS?=
 =?utf-8?B?c2UvanpTdlNhNGVibzY4SWVmYWdMS0daQTR4L1lWSmdtUzZTbkJFMUNnUWcz?=
 =?utf-8?B?RnpSRHE0M1lqeW9zcVVERnFiT1NQOGZhQmhNUnhzTGFlakZGenc0aFVGeFBK?=
 =?utf-8?B?OGplSS9NbEhTS3QzQjJ3NThSVm5KWDRLd3M3QmRJSDFCUUZucTJZR1dYUS9p?=
 =?utf-8?B?aDhJTzg0YTdzNXRQMC9VcVBSc3BkZzc5NExENVovcXhGdnlxNWdWQk81K3Iy?=
 =?utf-8?B?THA0V2w3NE4vaHNzWktpNjQrU3MzRzJTa0QvRWhDV200Sy9rVWNPNExJN1oy?=
 =?utf-8?B?L2Z6WDJZVEZ4bnBVdnFYR0oyL0dQT292VTBUTUlycHRtRmIzRUpTOHBNanQw?=
 =?utf-8?B?SjhITkFBcnMvenJ6MlJYY1FSelNNSS9zV1BtakxvbnlPUkhJVXo2MTlUZ0to?=
 =?utf-8?B?bU1EdjhlTno0VHc4eXlNU2luNm0xd3BxUDU1bjE5czJQWjJlbjZuN1hyNzdH?=
 =?utf-8?B?ZDJLd0huWUpzSWhwUTdvbE10dHZ6WlcrTFk4ZzBXZDhLb3FkMTJ1ck9Xdm1N?=
 =?utf-8?B?d0NZaHAzYUQwNzFRbG5nS1ZkQXc2QUxBRHRGR1ZCRDhNdjdaejlqUFNMaERV?=
 =?utf-8?B?bTREVFZJSUp4d21BY251UzNYTWlBdW1jcE52dVRBYXhQM1VmRm1ZU2FSRENZ?=
 =?utf-8?B?bDlqYlFuODVRRWpiZ1ovNDVDZi9rc3pkZEZVcndrdXpXUHV0S0lTMjdBWTBi?=
 =?utf-8?B?N2plWWI3RTVUeWdkWGUvRWo2ZzgrSVZrTkwxcmw3TzVvK24waGNweU5mbmZN?=
 =?utf-8?B?enZPL3I1Qm5HRUR2aHpOYTlXRUcvUkVRTjZoTHc5Y2d2Slgvdmw1bjJueUsw?=
 =?utf-8?B?cUFXOEpvUmFiS3Nad0VzU29EN3dtT0pCTnJ5VWJJcjB3TGVIaWM0RXdkWVFW?=
 =?utf-8?B?c2lYVWFZamdwV3NKNjU4ZXlnZGpYUG94SnpsT01xc21POFM1OTZvWjN6bmU4?=
 =?utf-8?B?OUkwNkYvdXU2ZGFSdXR5U1JPY0lVc2Y0TGd1d3ViOVkxQWhkMHlSUXRqY3Jh?=
 =?utf-8?B?T0tyZjQxS05ZMVZoR1JhVVRNUnVnTndvWS9kdGtCVlJ1UW9LOEJmMmxZdjVO?=
 =?utf-8?B?WWxMY3E2TGp5TTk1V3RJNmtKKzIzK2dNZnN0MndlVmdvMW8yejVXamppc1Bz?=
 =?utf-8?B?OHF1RElPMHhsS2hrZ3JJN1Y0UFArL2V5Wmk5YWo1ODkvWVZqa1dPOXdxN2Z0?=
 =?utf-8?B?ZFpSV3VnUmhzYkFJQjBBa29ndnFvbU1oaGl6WnN4OSt5dHpWZmVzZnptekhQ?=
 =?utf-8?B?ZlQvNk1KWklzdW1VSHIxb09DdmV6SnVwbVJ5RWZOSktjMFdOYmRPWkJpVUN3?=
 =?utf-8?B?TFI5elRnSjdJakU0K1lrOWgrQWxIRUQzczAvbnpjUjh4VmU1ZGxUbG9scVBh?=
 =?utf-8?Q?fLO8u/8VkPM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Um93Nm9tTFFwU0lUV2lvUlF4SU10U1pQZm5MK3B2K1lxRkFTVUQyV3UrTGNh?=
 =?utf-8?B?Vm9CNUo0M1RDVmZHdEVGd2JENHhLR2JFK1pRWll3U0JHSjFCdk9oak5wcGhk?=
 =?utf-8?B?Rm1yTFJmZWp3MTRDUisxRTFLYjlwSnBoUjE2TmU1L1BIMktiOC92dXVkNUpF?=
 =?utf-8?B?MlFYOEUzTGY3ZXRPeWdtcEplbGhud2dKMmthZjYrS2RoNWhvcWJhNjNlc3dL?=
 =?utf-8?B?NGhYUVBOZ01MYUUvdmQ4aWNJaXJCNmJJS0ExbldvU1BEQXBXVVBTYlFXcDNG?=
 =?utf-8?B?blE2T3NjZjQ4ZTVMT1k3K2Q4Mk5FWG45MGxEZmo5K1BtKzZuNFA4eUVMb3hF?=
 =?utf-8?B?TVVTSmcvQ2EwT2ZjZlQ5NFZqWEtpT2pzbERFYXRuVmJiMU5lV2dTOUNtc29V?=
 =?utf-8?B?YmphVThCRzdMZGZ5VTB2WWRKTHIyS2ttb21vK25iYlltcDRKY09VV3ZvbGFw?=
 =?utf-8?B?TlNKa3JGRWVaZXFlYmpjTEtVSVpJTlVkMVhHUjVtMmtsZm1wZnJZZVI1VFpI?=
 =?utf-8?B?ekFWdFBidENBazJCd3hZY0FGbnBlcmR1NHlQNFpwZUxIUjdJVERKT0VlRTIw?=
 =?utf-8?B?ZEZFOU1NWThuS0M1N2tXZmxDZTg1M3dWblhqSzlJdFRmdWpxZXZWTWlIMUpZ?=
 =?utf-8?B?TER2dUwvWkx2VldxRGNiNnRwMHkycG9aalpoVEdlUVo5bGRBU0Z5RHBORnVp?=
 =?utf-8?B?MGw4Z01weGxWTnByRU51WFEvVHlGL2IxTE5Cdk9WQXlxTTBwZzZNMzFwSEU4?=
 =?utf-8?B?c2FEMjlkSGRrdkZXS3BXWkZWTDZ4UkxnWVJvSkRWYzBPNTBzeTNkN3FBRUJv?=
 =?utf-8?B?MkJXTnN2L0RzSlhUZGxjdi9Va3lqbTFKOURuL1ErQ0ZWaGpmNXcvbFMzTzBU?=
 =?utf-8?B?YTNwSjVmSCtLaUpTcThvMlBsLzZIK1dWOC9ncGdOcTZGQk02S3hSWHlLVmlu?=
 =?utf-8?B?VjBnaHBGK2xneUhnRXF4b2wwazQxMnh6OUdOTDI1aThRQ3BIUEdNaXFoVXB4?=
 =?utf-8?B?NFVtQ2pFeUdyRDBHNFUwRVoweXV2MkMyMU9vWTR3cGRoZWExK3ZSWlZFc0lp?=
 =?utf-8?B?UGpROGdrVFhTbFRVN1dhQ0xnQUtSRG9WSzZqcHo2QXlhMTBFVmdKL0tBNTBJ?=
 =?utf-8?B?dDArL0d2VVBacjROMjhjMkJtcTdqa2NlWVh0VWdybW1nRnFxRnptRWQ4dW9D?=
 =?utf-8?B?eHZRTHIyQndsSTE3TXpDU2pKbjRBZVg5Vk81K1V5Z3gzSGFjczFiWTN4Y0ph?=
 =?utf-8?B?bldzaXRKcVBYbjBkcjY5eXdNbnR4RTNwTzYzWFVzZithTkwzWXYza2hOYUdk?=
 =?utf-8?B?eFBHcUJJd29wa2RKS0Y1OElLN2pwOVpBWmFRcWVTcVpBVVcyOW4wa0ZscDBZ?=
 =?utf-8?B?Uk0xa1RyOVRQd3VlN3dBVlYvUzRsZHBNV3I1aEx5dWxpZ0Nta0JsTzlZdnZU?=
 =?utf-8?B?WUp0NVdBcWdwdk9PRWNSd3hrYWhvays1U1FabS9RN0UxQnlpMmI4TWMweFQ4?=
 =?utf-8?B?eTU2eVVkRTFIcWpWS2xCTS85OXk4WHFLMURaZU5DNUZLdnpDK0N3WW52Q1d1?=
 =?utf-8?B?Z0pwTlErQ04xNEc2ZTRIZk5GR0t5VHd0N1FwQlNML0VzaUxnNVQ4NTFaajJk?=
 =?utf-8?B?b2Q2T1RtY2R4eVMwRnh1S0RUdEU0cGlhVFpacjVOLzlCNEQ0MTZHU2xqUHJU?=
 =?utf-8?B?K3ZqemdsUDJnTjFDQjZISWxUN090L3F1WHNHT2RzclZuekcwek9XaG5PVXV6?=
 =?utf-8?B?N25RRU1zTUNFSG9TVURZcDd5V25EaFI5ajBmR3ZmQWdPSE0xbXhVbk5NNlIv?=
 =?utf-8?B?MW42ZjdzSEZVT0NzQ1o0cEgxeDRLSzYzNWdlVGwzYmFsYWRxV0ZLSWpZSmhJ?=
 =?utf-8?B?MlE3QnhKRDRsL2c2THA1MmhIZThrN1dUY014TUxVL0J3a2o2WlBDYko4ZDNI?=
 =?utf-8?B?YlBCUmNXRnhRUlJzQzNvZVFyU0RCNDR2aHViTHdmOTJTTXc5dzlvZUtZaXox?=
 =?utf-8?B?ZFE5aU45Rk1wS1liWUlxNVZ2YWl0RnlrazcvNFRJcFlGODVONjJQMk95bVd5?=
 =?utf-8?B?WTBUSGw3MmxuMGNMWnFKUXU5S2tGaDFnemJYeEszRzcrR0hTMVNxTW0wYnYw?=
 =?utf-8?B?K2dWWGIyMWRSNFFuRDhXVHNIa1pTMzdMVHFTeTJ2ZXN6VFpwTGIxcFVPNWNI?=
 =?utf-8?Q?1myT4hZoSzhpKGgff1LjOj8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af23bca-6fe4-43df-8756-08ddca2ac41f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 20:51:58.6907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83hwrjgCONcmI4DnvQJ7kotk1U1vd6UbCQ1N6+1gDelOeUXpJvmA2broSgpRTZZctc15pDwHfRLjfW1zY5EwHBeUkr3e6R0LssZmJz5eUqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB8118



On 7/23/25 10:38 AM, Dev Jain wrote:
>
> On 23/06/25 6:56 pm, Ryan Roberts wrote:
>> [...]
>>
>>>> +
>>>> +int split_leaf_mapping(unsigned long addr)
>>> Thanks for coming up with the code. It does help to understand your 
>>> idea. Now I
>>> see why you suggested "split_mapping(start); split_mapping(end);" 
>>> model. It does
>>> make the implementation easier because we don't need a loop anymore. 
>>> But this
>>> may have a couple of problems:
>>>    1. We need walk the page table twice instead of once. It sounds 
>>> expensive.
>> Yes we need to walk twice. That may be more expensive or less expensive,
>> depending on the size of the range that you are splitting. If the 
>> range is large
>> then your approach loops through every leaf mapping between the start 
>> and end
>> which will be more expensive than just doing 2 walks. If the range is 
>> small then
>> your approach can avoid the second walk, but at the expense of all 
>> the extra
>> loop overhead.
>>
>> My suggestion requires 5 loads (assuming the maximum of 5 levels of 
>> lookup).
>> Personally I think this is probably acceptable? Perhaps we need some 
>> other
>> voices here.
>
> Hello all,
>
> I am starting to implement vmalloc-huge by default with BBML2 no-abort 
> on arm64.
> I see that there is some disagreement related to the way the splitting 
> needs to
> be implemented - I skimmed through the discussions and it will require 
> some work
> to understand what is going on :) hopefully I'll be back soon to give 
> some of
> my opinions.

Hi Dev,

Thanks for the heads up.

In the last email I suggested skip the leaf mappings in the split range 
in order to reduce page table walk overhead for split_mapping(start, 
end). In this way we can achieve:
     - reuse the most split code for repainting (just need 
NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS flag for repainting to split page 
table to PTEs)
     - just walk page table once
     - have similar page table walk overhead with 
split_mapping(start)/split_mapping(end) if the split range is large

I'm basically done on a new spin to implement it and solve all the 
review comments from v4. I should be able to post the new spin by the 
end of this week.

Regards,
Yang

>
>>
>>


