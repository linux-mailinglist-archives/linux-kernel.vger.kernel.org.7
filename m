Return-Path: <linux-kernel+bounces-889366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD531C3D643
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 21:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 62499343BFE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 20:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63BE2DE6F1;
	Thu,  6 Nov 2025 20:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="aDJQ6idn"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023084.outbound.protection.outlook.com [40.107.201.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C591E1E12
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 20:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762462056; cv=fail; b=u6wxf7FsEp+N7zvzRPYAxI0kay+Q235mMkXB0BtG9YczmwQFgSIW4z4iveS5uPsyYckEN4aDC2HNUVG8BxCMwiFn2NqRTBrQ3ZF7NDK9xSTqXaTWYGXPupFDvstPV1X4vaMEM2cQZUXbuxHipJog9UnQmPFfqw+Sokhcuj82xtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762462056; c=relaxed/simple;
	bh=Cr5JQ3ct28FeJpL7H8zsbVgFHBRUez1E/6rvV0dEDTs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AO7QxURDuCyfG+E0XtR5oC3aSc7Q0N+2L1Xx+IV6l4eD4ZTH4GD6k+SyFKTEISPzAm+JHt/T62tMo4VmMevW5jm824bB89519pIMz9o8lBpbet6z2+Jb399fDzfimCIki2VOEHiKfDzKAl4Ne4fjQre4Qe9X+nJrmDupzTD+AcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=aDJQ6idn; arc=fail smtp.client-ip=40.107.201.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xr7UX8cS6L8ZfUZwzFPzDC6VFKrbmU0ADq9EMgTBGK5ZiIjZDX2V0dzIyId0yZY2xk8oVyf13jqpXZN68YZGxvzKijdoaJDy7AdV/WLYpPx2bUdkmhPjfTOU9Rjxom2lJWOAxwcq6/WtlxOI2OkXdoutzfmkjx2ZT0eiVEg8Xk0Z9S7CTdx3uSk99NCL0kD87PqutNVW9ojVSSAdqNOrm3HBzdBJor8O2uwQiudLkStZukOxRtNm0OI0hAA2AgzCvndbE9uBVJ9vAFmm89q8kfgSjkzF/DvRnxfjACGmws+fuBrtw4C/S/H1AbJISrRg+/oZpHtU49gIoV3CCwybJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZCXwx80lFrE/h/9zJlOY2pPagClIn9GXq7nvef7WdM=;
 b=ByjEZ4KvS0MyMJnAogBti/cHNe9bPwpH1ZSxxKI5GggZXzPmgFBFXHa2MwAWJR0UWd4FG1a9e5oZwFMIVlKmxwXheX2ynTdtRX9LeeLrbAyIT35uFRD+M+nQ67kEBhMJx+KO+/CIb/GwWGao9kxY+1KMW9HzC0pExp7+lPOYhCVS1BNpAD4Iphfxu3DyPvkdtpBksPkAgpnxa3ENEJBH/Y8d1pS0EgeQW0kMFCZLms+k04N3adLVg8q8H3tuaq0WtcdYXj0UDD4B0m3L361ysIMh+9P9BmTJ0wAj71NOw6gDO/Yr3agiRlGwULM4E/bdic96tSUR2ftrgWUItjURhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZCXwx80lFrE/h/9zJlOY2pPagClIn9GXq7nvef7WdM=;
 b=aDJQ6idnTWvlLS36xqtvcj1+Fs1JlmDFWG/n1JQIqCc7O0aZ1tww5NRuYlC23Yf0j1sx8htZyV1jqwmvKz/cprXz4fpv75qjThTFlXJZVdY1qWEt/MGYP/1kEMMQE5KpyniGyZYIUOm1xD8c1CJhYyt7y93mVtHx9NLQTjpZ6Qc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 DS1PR01MB9015.prod.exchangelabs.com (2603:10b6:8:221::18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.12; Thu, 6 Nov 2025 20:47:31 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 20:47:31 +0000
Message-ID: <abc692b2-9c1c-47f6-a8f7-5a1f26a98b83@os.amperecomputing.com>
Date: Thu, 6 Nov 2025 12:47:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: mm: Optimize range_split_to_ptes()
To: Ryan Roberts <ryan.roberts@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, david@redhat.com, ardb@kernel.org, dev.jain@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251106160945.3182799-1-ryan.roberts@arm.com>
 <20251106160945.3182799-3-ryan.roberts@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20251106160945.3182799-3-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0203.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::28) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|DS1PR01MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d2348b4-b465-48a4-d7ae-08de1d75b482
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDhnSTc1TytQWUN6azVPNC93Q1dPdUMvdDhZc1UxWDJvSkJjQUt2NElRblpu?=
 =?utf-8?B?V0ZMWndFOGJqbzFocmkrVmZ0ZDdQbW1QZVl3MlZMYnlkUGlnNkluM2ZnRzdD?=
 =?utf-8?B?NWRMZGF1UmVyd2tlVldMNUFqV2NxaVlCTGhOSEd4WVYraDMxNVFrU0kvTjVq?=
 =?utf-8?B?YnQxeEVmSG90WE9sMUlWRGJIVjcwRmt2WjROR3JpVWV0cFV5Um9yK1NnZGVV?=
 =?utf-8?B?SXUyU3N5VGVPd1E1M2l4d0xTbXNraEdObFVXbFMrdjlualF3UW5pelhWSVQ2?=
 =?utf-8?B?b3F6WDNzeUJxOGUvL1c0ZndzMTR4NlJTTDJOMWVkblE3MjFhSExHb3hoMG9H?=
 =?utf-8?B?YTdZV2V3UE5QNDNaNHJtZFd4MGk1ZXJDdWg2NHg2UTFJcTMvc2NuYk83cUxi?=
 =?utf-8?B?Wm53NWFkVjNMNmUxTkxNUE5JWnNvM2ExelNWanNnV3NpOFdHV2dlTE4yZlh4?=
 =?utf-8?B?dU5UeE15UmN6M3hRd2VIWXBBL3JERzROR1F5L2xWMjFHcEkrdW41bjJZWSs4?=
 =?utf-8?B?LzF6dzlTU3BqN1I3NXJxNVZWNTkrU3dFNDNkWHcrZ2w0MC9HNWRKbkNzWXRy?=
 =?utf-8?B?WXVLOE1ZU3NUTGhhWXpld2w5d2w3U3NJaXR5SW41dTJhbGR3YndmazRrLzhw?=
 =?utf-8?B?T3E3MlY0aDhraUJoYTU3QlhEb21TYVNnKzcyekxaV3pUOC9wTngvUzFjT05D?=
 =?utf-8?B?ZU1rK2w0dHBGOUE3bk5UcUxSOHBhdUF3akYzOXV0QTZrYmd5MkZBVnNLZ3FT?=
 =?utf-8?B?bVg4SEh0RUVTK2ljcmdNNlJ0cGdnSFYwZHIyc2dLQXNPaFNHeHZ6eHU4QmQ3?=
 =?utf-8?B?a3Q1bDAwZzhLSnBOQUsrUjBsNklZaGsycm13MGI0L3B5UGZiMmkvdXVYd3JD?=
 =?utf-8?B?TkdtamVjMEEyMC9BcFYvUnlkN1JmeFZJMnNuWWZFb2EzeFg4aEhXQ1JCd202?=
 =?utf-8?B?cTlVYmtEcGs0NUtBczhQL0U4RS83QjJ4VkJ1NkFHMURoemdVNzkzMUdCb25C?=
 =?utf-8?B?QXh0STBiRzc0YmY2Q3M0b0dmditRTGtDcy9uUmhXQ0JzendzN0NFMVJiRUlZ?=
 =?utf-8?B?L3h1ajFDM21FSERBVFpGU0ZYQ2JBdGpuV0MvVkV0Q2wyWDNoVGVXRjRwc2VF?=
 =?utf-8?B?TFJaV0R1VWN0V1VZNUloYkwyV1pUUG1paEJDbE5Ic2xmc1RIcWY3WTh2Q0tK?=
 =?utf-8?B?K25lS1lrQXpoeEVqV2ZHb0xsQkhtUUYvOStNTTBaaHpycWg3b1NNTFdlNkht?=
 =?utf-8?B?QWdNRWUwYlVTWmMrWUhWL2p1Nm9SS1IrcTROVmJ3bnRTUENMYk41SUlzbHJP?=
 =?utf-8?B?UENpMTRLdVN0T0xJMEJGV2JPWmh1REFzMUFTVFdBOCtnd2Z0RnpXZ25LTXR0?=
 =?utf-8?B?NWk4WnVWUWlnUlhXMTVOVjdJOFkwODdTTmxkUFdUQURwTXFxUUtqTGppNTdj?=
 =?utf-8?B?Z3NseXVYWEVrNmhzbENNVzB1dlhTM21ZcDVEbGhiMWc0ZFM3T0Fyek1JUHRK?=
 =?utf-8?B?Vm1IYytnd1pCNWtIdkl1cElLNXovSjNVRGUrNC9tYWdTOHNPVlZ0SGkySEky?=
 =?utf-8?B?cXVlVnBwTlFhcC9IZ29Cb3F4cklsUnNsNGxKbnVLNEM3Yzl1c1pqczc0cGZj?=
 =?utf-8?B?VVZPOENPeDZnTWlmOWtYV1BIUy9RZGU0bnBNTW4rQjk4djJWTi9CZmhucG9X?=
 =?utf-8?B?ZVY2NzZLWVBTK0t2TG9ETWwranZNdTN4NnNqRHlKQ2RJaGNRc1Zma04yR1hK?=
 =?utf-8?B?dUk2dllndGw0TXAraWlDT0ZmU1NIY1hubDhQWSszZVdCZkJJeGRKTjFkWGZ5?=
 =?utf-8?B?Ni9TMUlMQWRvRWFUOUNxbDJJbVV4ZWxGQjcxc3gwTHlOZE1qbFd0UDFDYitU?=
 =?utf-8?B?aVJDT0tHekw0L0hxQ2RqR2M0TkNRdlM0dUZJTmVsbzVZbGxMeWl6ZTFkTkxt?=
 =?utf-8?Q?OoZjMjy4eR3nJwFte/buYqXz5CtUSIXi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blJ6NFhyUDBDNTlQSGVLU1I1aXk5aVRyL29tcFQ3YlR5TXJpSWF5SzExVlYy?=
 =?utf-8?B?SUl1WFNTbEhkMFIxMlh3UEdVclVUTVltcFFWaWdpQkwrcXR3eXJyTEV5N0NY?=
 =?utf-8?B?aTZpZ3N3bHcyR1M2SS9wRis3WUVXbDIwWXJyNkY5OEpHUUJFSTZFbThUMHlo?=
 =?utf-8?B?YjBYeWY4M3JQcE8xb29oVVMwb1kvbDliTWxMdlJrb2VWUFdtRXgrWkNiYXEr?=
 =?utf-8?B?WG1paWRvY2VzV1NJMmd3N0hRWi9jZ2ZCZlhPZFZzR2lDQmNSV1dSZldlUUJv?=
 =?utf-8?B?L1lSTUhJTXBmbzVOb1p0dXVFSWRoNWwrYmw5ekZSckZlRG43ejZZVFhqZUk1?=
 =?utf-8?B?TjNxcnJJQi9DbkpnRHdIaWtJQ255b1JZWXFna0F0djdLMjE4OUZranIvclFP?=
 =?utf-8?B?Yk9vOE43UEF3SWRXaVU0T2NoQmcreTY3cVdWMUtucnF3cHdOd1hkR295M1Zh?=
 =?utf-8?B?QkpnTExlbUdjNWNaM09UTjhmVGRveUQ2eEpocE5BcFU0cWFSZ1lhNWduejgw?=
 =?utf-8?B?elA5ZEZZaDJjN1dRUnZCUlpyUDMrYnlXN0tBbTV6WkhWQmg3VmVTeE8wMVln?=
 =?utf-8?B?ZVRqR09XUXRJRWVmKzBCRGhsSU4wRmZtaHM0cktJVVdnVVhUV1NlSkJtS0dn?=
 =?utf-8?B?allVcmV4UlpKU2ZZNkJyRk9JUm5mb0J4eTBubkR2bzFhTHNTeXhISnNUR1dT?=
 =?utf-8?B?dmprc3dNdXNWS1Q5eTRoZnFtZjJObW5mZFpUa09ONmlpK3RVTXR4TldxZTBP?=
 =?utf-8?B?Q21zK3RwZ1VFSmRqS1FXeTZkc2tDZnUvWjdCTVl5YTlrUWdJdHpKOHovT1c2?=
 =?utf-8?B?ak5ZNDROd3pyY1hoWkxGQWVsWXpNU0tWMG1VdHN2MFpLRXYvbmUzaHl5ZHow?=
 =?utf-8?B?RTZ1ZjJhbm1zZ25kcEJXVzVTSEgxL2EvUEZZN2FZTk91aGlIeTFIK1RoaUVv?=
 =?utf-8?B?Z3IvQ211b3A1Sjdaekk0amUxRS95MTNUNHZITTkvUUFFY3RHRWYrMG5YVWFJ?=
 =?utf-8?B?UDlrdE9YcUljYVFtb0crUFpKazhrZmdncjlvWmJUZHBvdElJR0kvcVV2SkE2?=
 =?utf-8?B?ZjNlamFIVXk1UFVDeFo2cE1zampGUDlYbjFGaVEwZVJadm5EVDgveTRTd1Zm?=
 =?utf-8?B?bjA2anRNd2dZSWVubGVNRXdLSUVoSzZLaStRN040dDN0cW9NN1cwQ0ZhdWxh?=
 =?utf-8?B?YmhCeWxhT3VoU1FQVGJjVm5CZ2NPaEdvQ1FFK0hQLzE4VnEwYUhvUUpIcm5Z?=
 =?utf-8?B?b2V2Q3FHem04aFJEeGxSdWxYYXFOdjBycTJUNVVCa3dGSkQybEM5OXRMb1dS?=
 =?utf-8?B?OTdRUUlLQXFPdTFicXNhOXlqZ0lyUXdnZm41VVFMYUN4Q2s5TWIvaXdLcGpY?=
 =?utf-8?B?dldDUDdTb2VDaGUxSVNtYktMcFVtakFFQjdjTmZ1Sm5ZOVd3SkhwVEEwVCtP?=
 =?utf-8?B?SXNvUHlRMHBVV3BwR3NQTTlHUjNWbm5UYjN6ZFJqYmpLYVZOQkFuUTM2SW9k?=
 =?utf-8?B?K2ZnUkJ2Q0VWa3kzczE0RHArM0VISkdGVW4zRzFaQVI0dFJvNUlGOStYMzJM?=
 =?utf-8?B?dW5Qc1pPdHo0T2dKYzc4UGZrTFhTbkdGcndtckF1ODMrdmVNQ01qSGtrbjRE?=
 =?utf-8?B?WWJ6T3I3TC9yUEJkT09pZWUrTHg0bTJlZGE0Nit1MVBVbmxYdndPWVJ1OHJP?=
 =?utf-8?B?MXpsQXZnZzhhYW9UMjdsVW5iNXVSU3NQaTVNNkV0UUtxYytsTmpHY0lSUXlT?=
 =?utf-8?B?UG45TFltcWx6dDZ4U2VSYmREOXRNZExuemRXV09aL1VCcXdraUZ6NWsrQ1Z1?=
 =?utf-8?B?dnQ1b1hUVGtvLzBzb09OS3h4UWYzd01vRHM4dFl5YTU5cVptUmFYY0Q3YTJN?=
 =?utf-8?B?WjlMMERUbFN0bzZTQ0lWR3JJUGFidFMvbUN0Y1ovdE5ObkpwTXhmV2JCQ2lM?=
 =?utf-8?B?WXJQbUl3aVR5OGxYTy9IZDhQUXpibWc2TXBZV2JtU2hHNk9VMllEbmh4NERC?=
 =?utf-8?B?UG4vSXYyZlpXQU1MYkRwWmQyeUwwZFVyQkR0cHZWTUdUNCtITkQ0ZXBINzhl?=
 =?utf-8?B?SHlDSHlucEJCdHJyUzA5KzVaVVFDNmg3ampmYUd0YWNWcjUwc3FOOGdpUXAr?=
 =?utf-8?B?L2xJSGVZaHZYVDVFclNFeVl3bWw3b09QK1FiMXFnZUNtdXZpRmlBbmtFUGNJ?=
 =?utf-8?Q?eqPUdbbblJiDL5xr7p5Rr9E=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2348b4-b465-48a4-d7ae-08de1d75b482
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 20:47:31.1339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2Rj1j9ft9s74eMUePlynMLY4mwg3g+YBD2sAStoshn1+KRiCjnuQSRpTPYkG+dW7+9F2fC/e1oohXlPffVgSCXbmUiHtAa5cb0MWXoVryg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB9015



On 11/6/25 8:09 AM, Ryan Roberts wrote:
> Enter lazy_mmu mode while splitting a range of memory to pte mappings.
> This causes barriers, which would otherwise be emitted after every pte
> (and pmd/pud) write, to be deferred until exiting lazy_mmu mode.
>
> For large systems, this is expected to significantly speed up fallback
> to pte-mapping the linear map for the case where the boot CPU has
> BBML2_NOABORT, but secondary CPUs do not. I haven't directly measured
> it, but this is equivalent to commit 1fcb7cea8a5f ("arm64: mm: Batch dsb
> and isb when populating pgtables").
>
> Note that for the path from arch_kfence_init_pool(), we may sleep while
> allocating memory inside the lazy_mmu mode. Sleeping is not allowed by
> generic code inside lazy_mmu, but we know that the arm64 implementation
> is sleep-safe. So this is ok and follows the same pattern already used
> by split_kernel_leaf_mapping().
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Yang Shi <yang@os.amperecomputing.com>

Thanks,
Yang

> ---
>   arch/arm64/mm/mmu.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index a364ac2c9c61..652bb8c14035 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -832,8 +832,14 @@ static const struct mm_walk_ops split_to_ptes_ops = {
>   
>   static int range_split_to_ptes(unsigned long start, unsigned long end, gfp_t gfp)
>   {
> -	return walk_kernel_page_table_range_lockless(start, end,
> +	int ret;
> +
> +	arch_enter_lazy_mmu_mode();
> +	ret = walk_kernel_page_table_range_lockless(start, end,
>   					&split_to_ptes_ops, NULL, &gfp);
> +	arch_leave_lazy_mmu_mode();
> +
> +	return ret;
>   }
>   
>   static bool linear_map_requires_bbml2 __initdata;


