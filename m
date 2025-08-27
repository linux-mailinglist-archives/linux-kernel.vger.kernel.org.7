Return-Path: <linux-kernel+bounces-787564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CF1B377EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78EAA1B68C40
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DEE2749F0;
	Wed, 27 Aug 2025 02:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="f3n6lwTT"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2099.outbound.protection.outlook.com [40.107.244.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788E627815D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756262023; cv=fail; b=GfEMO1dJ6BE3JMIj6COIunevCgnzhMlpcbHOxFS3L5/XM2b9fJwQ0wlzETEdRPqiOhAQsas7A1wKtoVg5IpIYnNc7HfDJvfT8Ath4xsD9tzgyMztmNoDOObfR8s0LNplyp72Riw1mN0Xmzx9d043nPeTsQEd6lnZJAkZH2AjmYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756262023; c=relaxed/simple;
	bh=46QbwAgoHb7PHA2TBpTgRRLmjmawfObILOdyJt7fNQw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=igVGFBR/qBs1x0eU4EeQnk8osP0KHCaaHtgYfpdpV+qhNbx4g9UnVDAmgm/C7/OgPWb1V2LkjK8Gd1VVhaA5dI6xTvSwoz2ExlwlCzOLyy1IUULRT6QP88JaW4KTdKyk27WsGSPQX3g/z8WgWEs2qBQiFgEGmEsQroVHF6Hybi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=f3n6lwTT reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.244.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M24BIken1YUKCQPjpynsJ0ciGE6LpIPP0oYyMsuCL1sOLUs2rayWDgtWflM+8tLM4flDdLpO13MpzndhsMozxzUcs8CJoxqhdjRVuypGKRBy+wRrnZBAGwlJzrFdbg8TfqIvg4NdxG3dJ3Hxx292tD9jojQCp6nJSTPqP10SFDthCrMEg3wt//q2LOcGfMKGC3wimHvnXNNtXU1qiJD3Hta5lDg+eeNQwvWnTj35rRCmn/qyjW8X/wnu7j9bRQkNIWWxJGeKVgxfQnNxE53+els1rsy9AvPmxU+RQ+ciEWmfQioMkWkLAUTE+ysUd8QNpghNHEY4/3/sp5wAdydI2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLUwut5H8H8DiuRbIgspuynN299/oUqNzpjASEEVhdM=;
 b=afTuFEAVHdeDMp/Fv0/vDzgkX6tr4jW3PALhx+DWUXYy3zNejprL7fFgkl1n06lz9519TER1O+DCdY+xBJVNwejEBwH40KErgH0ct9++1zonO1xyDqQ9sc1MZiNtY7TAcKRkujmgyX9RskaWWvt7O7YhAvp/36rbibjP60+o/6f/1GyvtHzKkPYiB+hZeqi0bxd9Vr8c78IMx4QX4W39bx8Dj2uWlAr7sBN8IeqqA6B4x0xZZd+61XvO/xP8QB0hRQOEJY3e0TEIqWSCuIQKyDDEEVnouscCVp6mIHOXM+eg9UF1lLert/QQLSoHXhShYKUuVsyiyQWcyVa1SphayA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLUwut5H8H8DiuRbIgspuynN299/oUqNzpjASEEVhdM=;
 b=f3n6lwTT9eYudIJ/UMYx8nuBC9Rm226V6gYYlUtC+vTUT8luOPqhiFG2dEuTyp0z3jbO15pH/5WIo3TlPK4YTkjw81iuyaydq44xYogGsUIe8fpIGo+xay8xsk1h3TAz9QY1mxlHyMKmd0eAvX2DdM3jYA22mba59cGh0iB/sJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 DS7PR01MB9185.prod.exchangelabs.com (2603:10b6:8:24e::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.13; Wed, 27 Aug 2025 02:33:37 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 02:33:37 +0000
Message-ID: <bdfdc220-63d8-45ff-a475-41a6a63e61ff@amperemail.onmicrosoft.com>
Date: Wed, 27 Aug 2025 10:33:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: enable CONFIG_SCHED_CLUSTER
To: Sudeep Holla <sudeep.holla@arm.com>, Jeremy Linton <jeremy.linton@arm.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
 Huang Shijie <shijie@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org, patches@amperecomputing.com,
 Shubhang@os.amperecomputing.com, krzysztof.kozlowski@linaro.org,
 bjorn.andersson@oss.qualcomm.com, geert+renesas@glider.be, arnd@arndb.de,
 nm@ti.com, ebiggers@kernel.org, nfraprado@collabora.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <e47757c3-6091-43b5-ba28-52e11de7d86a@arm.com>
 <cb383a76-8848-44cd-6f32-fd30478d9ebd@gentwo.org>
 <2d9259e4-1b58-435d-bf02-9c4badd52fd9@arm.com>
 <20250813-gifted-nimble-wildcat-6cdf65@sudeepholla>
 <d172f30d-28ad-dd46-1385-f010107bc789@gentwo.org>
 <c45b13b9-52ae-a52b-ce39-77f7ebe09507@gentwo.org> <aJ20imoeRL_tifky@bogus>
 <97278200-b877-47a6-84d4-34ea9dda4e6b@gentwo.org>
 <20250815-pheasant-of-eternal-tact-6f9bbc@sudeepholla>
 <1097a1d1-483d-44b3-b473-4350b5a4b04d@arm.com>
 <20250818-mysterious-aromatic-wasp-cdbaae@sudeepholla>
Content-Language: en-GB
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <20250818-mysterious-aromatic-wasp-cdbaae@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0142.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::11) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|DS7PR01MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a53515-c426-4684-5bd3-08dde5122063
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEhyc3Z4RWpWVnkreXgwUG9HN3hqd1M2R3IzZ0JuZ2xkVFZyNWV6QnFsZ2JB?=
 =?utf-8?B?WG82RDBhRGNBRXhGczFWNjRqbEE3K09zZzB0ODV0anRQOHMzWG9kTW5HOVFU?=
 =?utf-8?B?bUhmNTdqTldFVHJSWjV2bjB2aXR6ajJaY3lBOE90U1hBRE40eVRDMUVsMVpp?=
 =?utf-8?B?cHVTeEp5SU9IWnJKaE4veHRiRUxQeU5sQy9xTzZ1VSt3K3I0S2dEanFzSjBm?=
 =?utf-8?B?L1N0aU5OTWxmak5pdGVWY2hvQlRka1Frc2RBeDg1MXlocUVMUFI1Zllpb3hk?=
 =?utf-8?B?eHJXQ1cwanF3eWw5Umw3Uzh5YjN6ZE8za3JybHhjcmR3Wkgvd1N1Q0QxZGUv?=
 =?utf-8?B?RkFQeUVjc01IamRISFBZa3lSZzFabktrYWE2dUI4SlJTNGNYQXErS1RMV25B?=
 =?utf-8?B?SW5QVVgvc0d5R2JwMllWRlZvZDhJeWFoTmpCRzlwMjd4VjJhUmhYT0dERmlp?=
 =?utf-8?B?MGxvcDZUNUUxN245K3B6cWpiRy9jVFArVWpPT1h5VldvdDd6cVNGMGFJSTFu?=
 =?utf-8?B?WFc1Z082MUR2SjZ4bTZkcEx0SFlKdGNOcitVM2l4MjFlVEFWTWlSdE5KRjVY?=
 =?utf-8?B?NU9KdGJaWk5FbFlyTlNEQW40WVc3L00xSit5RCtJWEdQdmFxL05QTFdvTUpU?=
 =?utf-8?B?YUVJbVJDcHdIRTVVR2tqUElSOWxRZ1AyeEY2L1lJeEppd3BJNTg0T3h6aVdM?=
 =?utf-8?B?d213TkF5bXlmeE5kbDhvcGFpVDREQ01DdHErNXd3bnRGTG0xaU8yZ0JXVjdi?=
 =?utf-8?B?RGZSZmhWMVJISjhuYTlMaGlTaU1LT0JoVjFMSVFwOFFibk5EVGkvVTk2bDQ5?=
 =?utf-8?B?RzdkczJrckFKaDBPL3gvUlZodjJ1K1Z5OTdZQWtsVXhaQjZZci9IQ0tTMkwx?=
 =?utf-8?B?VFFMM1o2bEpEMitBSC90WEs3ZUI0Nm14d2pDZGgrSE9JcjVGUXBvSUU2OFp4?=
 =?utf-8?B?NWhWaGdKSmFvUjZZVTc4NSswaG91bGR0aHo2L3piRkJrWjc3a0pxeHRsT2JG?=
 =?utf-8?B?MTBodU1ZTDJ5eE51ZW1zSTZCc2dKM25KdUdnWEJwYXE2Z2RVQnRRNXVJbUZV?=
 =?utf-8?B?VStFbUQzR25BN0JBK1dxd2s1VGd3VEswWWxObzJWV2RTWW84T1loSUhLUFZM?=
 =?utf-8?B?UlN5QnFGQ1dwcmJTUCtURkhFRm42c0JMNkcrUHVUaFpQQk04QUxjR1ZWNjF4?=
 =?utf-8?B?UjVBQWhubHJyVlRpVW1PZENSb3hPZ1FTSi9qNnNzM1p5d2ZGQ0VhYThJcXIy?=
 =?utf-8?B?ckQzN1lZL3EyNHM1TGZEb2tzemxZTGlIWTF0OXl3eHcrNnlua1VHUTJoV1A4?=
 =?utf-8?B?dUFKV1BIa0RIU2IyZk84bFAreTJHRHFEY0kyNUxxN0lwdkgxei9zdDEyemFR?=
 =?utf-8?B?MG80ay9YSTZFMmhRa0VLcm9WWnZkU2t2YXloM1U3YUYySUN2djYwTEtYdjY5?=
 =?utf-8?B?UjhWbzRhak5QRFovSWhnU0I1ZUdTQlhNWDJJVkw5MUszNEVoS0FkWTRJWXhu?=
 =?utf-8?B?TFAyOWdsd1FQZm1zTjZlb2pMMFd2VlNQZXRPQ3FrcGlFTGFwWEVZUDJpZ28z?=
 =?utf-8?B?dGZ5ZmN5TVczWWNWcW1SRjVFYjZPaFp1a0psQ2JYWWVLL0ErL3F4czVvM29C?=
 =?utf-8?B?d1NzcEpVUW80WmpvZ2NGVjJYc1hHY2hNdWZtcVhBRk1qRjQ4L05Ud2pRRnpH?=
 =?utf-8?B?eDloM2k0aXRvOVdoNXBNZjFXQ3U1VjhFcTNKeXRpUTBMMFc2SkhYdDUxUS9Z?=
 =?utf-8?B?VWNaNGFPc2tvb2dFSnpYWGJ3UVFuNlB4cWo3YlhSaGZjWFFKWGdxWCtDdXha?=
 =?utf-8?Q?f22F5ulqfDBGekWtGk/Bqn9VedkC3D3lZTKaA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFM4Kzh1OWQ2NDBwd2RVV3FaN2MvQm5UL2wxYVhFOEtOVjVYLzI3NVVLTlZC?=
 =?utf-8?B?TFA4dW44UmVvaTRBc244bWRrYm1PeWpjN2JBa2tLeXI3bk1vQjdpVisxR1g4?=
 =?utf-8?B?RE1Oa2MyYXVYYktNeXN5VnVUZFpuWlJRQ2ZySW1GWFlsL2tNWjZ3MVRxdkJt?=
 =?utf-8?B?ZmJpYjRsRTRieFdSOHB0d0xFd0pmcmFMYUMrTENkU2JBRlYzenk0ampIT3ds?=
 =?utf-8?B?dCt1VkxuZmdKdEtseVp3OUtvVWtNRTdOcnpxbWtkR3piSjFxNjBpZE1hdGxa?=
 =?utf-8?B?OTVVTndBeEpBc0Exdmd1amZYNVVpSnovdEhUemluaG0xbkJybUI0MFdjT010?=
 =?utf-8?B?UUZXb3JrWkk4SWFWVEo2d0E5em5BT3QvMXpHRTNnQTUrVG1KRkJvTFdWTzlq?=
 =?utf-8?B?RUpTWjl6Q1Q2d2xUL2Nrb3VxYkh4bjJIVXlCbFdEZVhUanBJZEtUOW5pd0lq?=
 =?utf-8?B?RTFTb1g4TTF6SXRvTjNFcFF3ZllGVnpzUGRvb3R4RVFKMjZIaVY4ZFBMTjBl?=
 =?utf-8?B?bExRMjZzaS9UWSt6angvV0kvdTE2N1ZaMStvMVZOTDc4Q0lGbkhLQkNsaXdZ?=
 =?utf-8?B?MzZHUFVGNEM4bHFGOVc2dGFIUWpZK0Q1S1V1Z0FKb21XZmkyZllwNzVsWm83?=
 =?utf-8?B?Y0dmZVVLL2p3eG5xaU1wYUVPdnJBY1Q3V1FKMkJra2RnMXBENHR0bkl6ZmxB?=
 =?utf-8?B?SUE0MEFWcDI3M1pHSU43bG5sNDh5TDVBdmkyU0RoM0NBMHZqYUNFM29MQVh6?=
 =?utf-8?B?dmVLRVcvTW94TE9TREtwUlBOWHplVlpIck0rRWxWOUJxcDI1NmtscFBUSWlo?=
 =?utf-8?B?dHYycU05NFRQUTFCK0NhMTJCSEhiMElaenJKZytGOXVXMmgwTXRDYTFReVg4?=
 =?utf-8?B?aTBQcjJFSEVza08rYnFSZHlBRThZRU96Zm92cm5oRVVaRUx6ZjNwZ3FBbG5B?=
 =?utf-8?B?N0ljUTk1dW03cXZXK3dBTVByemRNaUpsSkRkeXNrK1FMbGNRSWhieTFGSDVy?=
 =?utf-8?B?VVRkSDZuckNwT2F2R0w4dzFkcjBVcjd6V3BnRDQxQVE1VEhDYmNYdnUrTm9u?=
 =?utf-8?B?dnJiZll4VkhES0RQMndGUWpjMXpFQzE2UzlGcDQ2aDJicTgzcXlWcERsbENj?=
 =?utf-8?B?VmUxbFZ1Uk85SFFpa1I5SFIzYzkxSXJHV2QvYm1ncEl5NlVsYUZrZmk5NHVG?=
 =?utf-8?B?cldlWFRyTEVQcnlSV3Qrd1VKR0hwM1NVcldvUkRWVUFodDBUbnYyYlhQWU1Q?=
 =?utf-8?B?Y05vWXNTNTFuVW1wL0ROYmZTakFzeEhOUXIxamhRSHNHRGMvK2paMmNZMWZx?=
 =?utf-8?B?MG5xbFE4bXdUeWRhYlgxZmR2NE5uRHNTZjZIUFBnaVNWb3dDVmlUMEQ4OW9I?=
 =?utf-8?B?c1hNMm1VeGhtSkYzajJCOXlNMndUUGxDSkN6S0EyTW11MzN4endhKzdLdWZt?=
 =?utf-8?B?Tk4rN2t4N0NJKzNsZ3ZyNGRVSWE5aTZnSm1SS1hVejRiTDNsK1R3RG5oZm84?=
 =?utf-8?B?cjhNLys0NjRuejRZQ2E5NFJYSnNyK2F2WEYvQkIrMTZvaXc2OTRZT28vOUZv?=
 =?utf-8?B?c1lFb3QrS1pndmt3MXFsMzlBNHMwUVVjbTNUWmgybERaRlRIKzZXU1M2Q0dr?=
 =?utf-8?B?cjFQcm5wdWFuOUI3YzUrcEh3Vms3QnMxTXVhd3VFZ3BWQ2hzczdhMm1DOXVL?=
 =?utf-8?B?K1RLa2Z3dHR3UXA4OEYySGpUMTFxeU1CYjNFejF4WmlxTmFFRDlCUFp3Ymtj?=
 =?utf-8?B?V3cwUlZ4LzRycWc3QlhMOUpGNG5TS2VjNmFoQndKaUNlMG1oQk1BZFhzVUVt?=
 =?utf-8?B?aktEaTUwczdyN0JWRzdKVExDeGNUd2V6Y1E2a3ZheEl0WU1Vd2huWGhFT3Vq?=
 =?utf-8?B?V3o1d1dCUDRpa2Q1UTl1WW1sNWg3UlBxeitBQ0NaMnNhMm1SMzhQRWZnY09T?=
 =?utf-8?B?aVJkR2lNcHNqaU11aE1EVEZHcE5FNHJ3S090V1hXOGhObTZTT0g4SnRDZHdB?=
 =?utf-8?B?OEwvRG5peHh3aDVQS3ZNUTZ2dG1VRm0xVTJ0MjVEaldVeVdvOE95dFcweHg3?=
 =?utf-8?B?RlNlQUZQNW13TTVhM0QzajZjRFF2VEZKU2tHV3lQajV5WkpOYlRKRkJqNHps?=
 =?utf-8?B?elR4c3ZET2hocWIyWVBJZHNrWE90d01pQ1kvWmY1SnVxbVhNSDJuTkc4Qkdh?=
 =?utf-8?Q?fTQoUcz2RX68nMMlwjtvTfA=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a53515-c426-4684-5bd3-08dde5122063
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 02:33:37.6658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/qFNfpxiW72qwjp7KkNwBSg6391fwo0psXQCCTPIO0Xb4qU7uiRYDTz5MPBP2ZOB0EE8PDX7PGmmDbK/i9Qwv2k2XOKDh2OFosnYnqqSmDpCtMPYx52L/ryOfXyTAuh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB9185


On 18/08/2025 17:33, Sudeep Holla wrote:
>>  From a distro perspective it makes more sense to me to change it from a
>> compile time option to a runtime kernel command line option with the default
>> on/off set by this SCHED_CLUSTER flag rather than try to maintain a
>> blocklist.
>>
> Right, that makes complete sense to me.

Anyway, Peter is also try to make the SCHED_CLUSTER as default for arm64 
platform, please see the email link:

https://patchew.org/linux/20250826041319.1284-1-kprateek.nayak@amd.com/20250826041319.1284-5-kprateek.nayak@amd.com/


