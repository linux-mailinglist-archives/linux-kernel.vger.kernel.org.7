Return-Path: <linux-kernel+bounces-845987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8E8BC6A65
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 23:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56AC84EF164
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 21:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D872C0262;
	Wed,  8 Oct 2025 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sch.bme.hu header.i=@sch.bme.hu header.b="r7ISiIHN"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021092.outbound.protection.outlook.com [40.107.130.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80882BEFF1;
	Wed,  8 Oct 2025 21:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759957920; cv=fail; b=Jl1fGcZ78lZhlUF5+O1NiOArY/vdmKpT+KDfAU4wqgd9+x9n4fcVONkEQte/h41w58xOgIkzLTA/OEyW06rgpQnGjOX9OD1gQikZRmY5x6/1E3p/zp4x7CrLyMOJUD3wOt2BYQcpUDIkjdJa23aChvZh1M28G5mxbl3P0ms91ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759957920; c=relaxed/simple;
	bh=cTyUKZ/fCt9b8+IPcHN6xKhNXqFXQ/uO6qFYC9uI8sY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=suW/AM379DLqNTSvs8qSGgHT1pDDSfXQJOhGLdb2CObpKWk9PsMvhuqM/4D2oSPrntFFPeP+psjUdaKPHcZzUUDZI2+taHzOb6zIEpsNjer+M7K2vHm5bv+dAcwYrmuH0ihI0XJln9e6FMCJSI/I850Zl+kmcAqZQ6/Y4ydI0JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sch.bme.hu; spf=pass smtp.mailfrom=sch.bme.hu; dkim=pass (1024-bit key) header.d=sch.bme.hu header.i=@sch.bme.hu header.b=r7ISiIHN; arc=fail smtp.client-ip=40.107.130.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sch.bme.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sch.bme.hu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODWMuq5XYvjoCyukZ9chP9kxXlTG9NPQ6mJ8j41CHH/N0wLqFOyOHhAMHZAgCYOvUDhqd2xmWC7DrSwA8twUdMD18q5V+odH0z5yJNfDKpai/Eur1jnDwFWdBYy85UhMK7CNk03QmbG6rNzbepdMhIfsT/HuDns6ThT/j09/kJdTbGPc8K6qd3kUbRRB6YYf4hqMOJCJJjSocSIvSd21SVISIpRemrM8buYrOPABivSBd6mWUL24GSflOQv5PrEmMFViClSKYjpQ7gU35gyfjX9kyFG681PkWIeHEBlhgrY7ElbB1RzeydQrwGft8q+vhu7V+9IohHOKz3hOv8vHFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSTXXfi7TlWtegbezr0PVCeKuAuiNd0DF5NFBU96VTE=;
 b=KSi1ySwKYidrwCiwOwTjz6I+44TsWF7JQeImKovWTSI+n9s2k5FGrOcUYi+4Qw6sbzrb2v2jzMbU19xIhqtYFap26EzPx7T/K539DpoYv74RV3cWyAozQRZei6gujiLzuAQA1wwYkIglhDzdxpPBX4zrTppomn9+TThsIwwGSu3bDEjnCCodqIphvDA2eqsJaueeWHtEinYRjWhj63FNB5pwgGbfWtatQRzSTfJUQOZvYwLKbazvdQgQ9kr4eAlOnPVIW5ATYtTwStw8nONyK3st8SSVSJqCzPgkY8gzdWtRnEqaIqXdy+4R7jKUWyIIuwS+Ex4xGf/wvlkQAh6AOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sch.bme.hu; dmarc=pass action=none header.from=sch.bme.hu;
 dkim=pass header.d=sch.bme.hu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sch.bme.hu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSTXXfi7TlWtegbezr0PVCeKuAuiNd0DF5NFBU96VTE=;
 b=r7ISiIHNp1IdcDLWS3DYrk19g204/3C5W4410ewt9OEYnz+JLLiL2+5jZfmquuo9CYypESHWlepQiPZsuhUtAr5vsIvjcuQ5Gh5nQSEc5KcgrrpAUoAr2fFeWPTIlt98vaSruUPC8X371KLX8OE9WKri6ojvBSbemHhoiqTV89A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sch.bme.hu;
Received: from PAWPR04MB9806.eurprd04.prod.outlook.com (2603:10a6:102:389::22)
 by PAXPR04MB9326.eurprd04.prod.outlook.com (2603:10a6:102:2b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 21:11:49 +0000
Received: from PAWPR04MB9806.eurprd04.prod.outlook.com
 ([fe80::7619:14c3:6aaa:fae5]) by PAWPR04MB9806.eurprd04.prod.outlook.com
 ([fe80::7619:14c3:6aaa:fae5%6]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 21:11:49 +0000
Message-ID: <7f771c56-808d-4142-90ac-f0c949d7a3b6@sch.bme.hu>
Date: Wed, 8 Oct 2025 23:11:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: sysfs-pps: Fix `Description:`s
To: Jonathan Corbet <corbet@lwn.net>, Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org
References: <20250815-b4-sysfs-pps-doc-v1-1-61d315eafbca@prolan.hu>
 <c226c97b-e42b-4ef8-9cc9-56299f0b37c3@enneenne.com>
Content-Language: en-US
From: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <bence98@sch.bme.hu>
In-Reply-To: <c226c97b-e42b-4ef8-9cc9-56299f0b37c3@enneenne.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0222.eurprd07.prod.outlook.com
 (2603:10a6:802:58::25) To PAWPR04MB9806.eurprd04.prod.outlook.com
 (2603:10a6:102:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR04MB9806:EE_|PAXPR04MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f725b7d-c0eb-4b6f-ae5a-08de06af4b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|366016|19092799006|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHV3MTBMRTlHUWRnN2dJbHhSOWFkVEZaSzB2UWY1QllVWlFmTHVnNENqZFNV?=
 =?utf-8?B?T0VxVTJaTXdob050SUQzeFpubSs1VTRTcHJnRjFmQmlyK0JreUdtN09NMW5V?=
 =?utf-8?B?UDlnUzVsZ29iemw0RGtObE5iODVQZTVEaGRwZldqTDFwMDRZOWlqNlp6S0tp?=
 =?utf-8?B?bjFTNVcwbitmYUVZSjgzQ0VFMTBRRDN6dWVhQkc4ekdyK051Q2VJeTRGY0tQ?=
 =?utf-8?B?SUE2aHgrN1I2SHFXdFlGak5rWVU5RTBJMHZ5Z0pwTW1Ja1RuOWtBMkZIZTdi?=
 =?utf-8?B?ZzlnQmZkRW9WSW1iaWV0ZERFMitYYVg2MWE2NVo5ZVBDd3dBYlBrMCtxdlFP?=
 =?utf-8?B?YU9LUEMzN3JqM1VsdkRoWG51RUJVdnU3V2JyZEYvZUpBNWZSNG5raHJwblE3?=
 =?utf-8?B?UkN3OS83UXJRakQ0YitZd3QrT1h4NnBTRlFZMGFkQ1JWVXhENFpoRlRPWjBD?=
 =?utf-8?B?SmU5NVRhY3lSSmJIa3hteXBJdXFUamw5cDFrVU5SSUwxSUpTM2djQnRpQWNK?=
 =?utf-8?B?bmZCMTlralVVVDdBUllwMmFsVE9qV0prM29DaVdUZEFNeTZOWWVBeHdIRVM2?=
 =?utf-8?B?R25zSlAxSFdjOG5IWld6d3hJK0VXTVVjY0JoNmdva0gxU1hTU24vRVZucDV5?=
 =?utf-8?B?eXJwNFpYWDVkSVZac0pwSlUvd0REMllpV3ZyMUxYT3IwWXA5R3FvTWJMeitt?=
 =?utf-8?B?VFovVXh1RkV2Q0lGdlVKTFhRU25uSEdoUjhNRmRCQWxka1dacmNLWko4VVEz?=
 =?utf-8?B?RHF6RzE4SmpOcXQwK3ZuSVMvMFlHbW5nY2M4aGU2Q01VRnQrRmNPN2x6RnYz?=
 =?utf-8?B?YzJkdEhmS0FJdUVleVY2V0Q1Y3R0WmYzeVZraG9JNUtrUjNIUjlGZEI1TVEw?=
 =?utf-8?B?T0pDdHZXMG44UWVBelV1V2p3bWE0dzNhd1pHQTFmWU1sOHBEaHE3bm5FUW1r?=
 =?utf-8?B?SWFwSUlhbEpaVkhVKzFVU2VFUTFubmNVeUNXL29jOVMxTXZpK0toUnB4SWRz?=
 =?utf-8?B?bVArdFdPWkVmbE95VmpSWHpxU0ZZNGNsSXlHZXRYaHFxMGtFT24wMGxHOW9l?=
 =?utf-8?B?N0NoRnJnSkYrWnBjOC9qRTFCemlyVGlxK0JORmFkdzhQSm5kVndaZVNsN2pn?=
 =?utf-8?B?ZU1aelFHS0dpOStzVTNRSHJPY0lQQkt6enAxRjhJbEQzZlpyMHJqZUN1dGZG?=
 =?utf-8?B?cGpGZDdheUJ1WFdOSWhIQ2FxWTVsOFUzakNIR2FZcnFjVGhsUjNPYnU5bmV2?=
 =?utf-8?B?ZDhweXJsdCtTRjVIeWJRZFQxR242TWg0aDFRSVZHZ2dBR1FndXo4TG9HMmVT?=
 =?utf-8?B?SGpyN2gzbXV6MTF6cXJWUGRkSURiUWJ6bDBNOHBYUHM2Nm1NUFlLZDVQMGF5?=
 =?utf-8?B?RnZqeFZTcFlEMmowNXMrNkZURm1nVnc4OGhjTElpd1ZwK2Noa2swNXdydUtm?=
 =?utf-8?B?NzR6c28xNWM5bUcveVVaOEhKRWhqYXowdWZHYTc2M3N1S0g0YzUrbHhPSDhR?=
 =?utf-8?B?ZXZ0c0c4YnN3Z1hLN29uOGRWVy93allQVjQreGlNcVBEUW9XYTJDbmt3VFN0?=
 =?utf-8?B?NTM2aHF2SWxuWm5xVEhrbDRuZVp3M0VibHQreVk5TlljQnBGYkc1WldnM0Y4?=
 =?utf-8?B?NzZIdWliQlpXaTVyWlo1WkdQenllMStFTXplcmducUQrbEpiQnhlYkJkcjJp?=
 =?utf-8?B?SWZja0doUTZMNGg5MzBZeEJCSjhTRVRaT0Y2c2FodzBVRE0vZ25DOVNocFZH?=
 =?utf-8?B?dXZkTG5FUDhpangrTmRHYzY0eVRTUFRPUXpuREZwQVJxTndRQytxYzc2bkxu?=
 =?utf-8?B?S2YvbURIcmNGeTBNb0JBaGRZSVYwbldqWTB5TmdCM2ZlZmE2Y2pOVzR6U1h4?=
 =?utf-8?B?Y3lDWU9pNk9oOWhBWVFuSE5wa1VEMm1mTHJpZDRoZTVqamd6OENuRlM1dmNW?=
 =?utf-8?Q?FPrwkU1NtAhC/pq4KYf3ksBmiLgj5IQ9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9806.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(19092799006)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L09US1F5OEg3Y0Q3NHUvL01HUENZWHdUV09jNlV4Tkd4N21hVitPZS90QkFp?=
 =?utf-8?B?aW02NytjRTdJYjVaa1A5WHh1Y0NpTGl3T0R4ZVRzaDFKMGU4dkRzL1dESHNU?=
 =?utf-8?B?VXg3Z1YxWDVNL0tnamZSZDBleUNzNnIwWVVBRDNNa0twZmV1cm40ZWc0UDRk?=
 =?utf-8?B?ZEg4MEVNNHhMbXFwZmRFQUVvWTE1cEpJcDB3ZmNBajRHZEhTTVVzUEkzS3dO?=
 =?utf-8?B?NkxOSnRrV2Q1UDVtVldtZ25lRzMxRDBMajNFWThyTkNReEkxYlQvaWFuWlRZ?=
 =?utf-8?B?Y2lEUkw4MFRFbkJGQnFqMHBNeUgvbUsvTVN6VmFCTEE0enBKRTdia0wvZnk1?=
 =?utf-8?B?Ti9JQUJoc3Z6dHAzVk5tRGNlVTJLOUM3TnZqWTZQRDZuRDZETVdyaEM3MEZj?=
 =?utf-8?B?TGxFRGFOejBwU1F4WDBUbmpSalFGbnNiVkZGa1BZZE1tZlRWWXBrc0VJbHBq?=
 =?utf-8?B?K041WTVkYTc4RVd6STJPZ0J6RmNFbXJDUWdybWRVc1Iza0g2Z3VKUVowbVFn?=
 =?utf-8?B?UGt6anJRZ0ZMSElSa0ZMdUp0RE12b3dmL0Y0WE1wN0hOZXVQMERMcHdrcTcx?=
 =?utf-8?B?ZnhQOVJmVHFERmlBZnp4Rm9LNFU1TXFDOTNIM2xRMHVqbFROMmlYeVBldDd2?=
 =?utf-8?B?eERac1E0ZTBob0pDMXErcTlJU0pHT0JxYStKditubDNkcDVFdkRPSXJXNXkw?=
 =?utf-8?B?V2FvRDNWTUJ4WDd2VU03NG1vZG8zV3BHRmlPbHl1QWN6TzkrMnBoM3N1NCsv?=
 =?utf-8?B?YUkraGJ6NUEwdWtBNSsxL2Qzd3J0L08yc0t5dEFOVFhmOU1UbTgwdExENThI?=
 =?utf-8?B?dTVPN0QzTkxEbUs4SGQrNkg5K05oL1Q3a0dCR2F5elpucmFsRGI3TzFid0NN?=
 =?utf-8?B?UkVZTDg4ZWs3enJ0RDFlZ0FFY0dyTGZlVGxKSDhYOXJ0WnVGSmxacHNBcE1I?=
 =?utf-8?B?OXgySWxmaHpZbVhzb3hFeHduRFZTU0I4RHVYK3U0eE1sbWJqTlRMUk9JOHRL?=
 =?utf-8?B?SGJzV3Rac2I1MzU4YkdlcGpQVG5Rc2RpTnRUT1hxb21QaEtHRVpPeFFGN2Vq?=
 =?utf-8?B?SlhsRSs3VHFHa1ViRmJVZEkyWnVIUkNiMnJlVGMrMmhBZittT0xSTlVhTk9C?=
 =?utf-8?B?bERySWpmbXpsU1F0dVRJb3JQM0JWR2RnWU02cGFaUjd1SW5MRTdQRnJyYTB6?=
 =?utf-8?B?WjMva243b3BVNnlIRTlxeEU3OStDdVBkNDcrSU9MVUdEZWxSMTdITWM2bURN?=
 =?utf-8?B?V3NFN1YzZHBIV0wrT2tUNXQ4ZFExT2xjMlJjaWt2UmJaOUlmTCtxZDdxbm44?=
 =?utf-8?B?OFFEK1AyK2N4LzZ6aldTOFFsQS9Ldmp6K2ZSNUoyL2xPOGVJOHFZT25SdEdK?=
 =?utf-8?B?a053aHd5VmpBU3d1ZzlaWWtraVhIUno5eW9LNERQK3dBY3pZS3FnOWl6ZEg3?=
 =?utf-8?B?NnEvRlMreUVKT2trNUo3d1NBeW5FamJCc2tBSU1kRHJLTFA3SHhpeDM4QlNv?=
 =?utf-8?B?azViZVhvckQ4K2NVMmd0YmNQQ1Z0OUFCcHNVOEFKS0psS2RDYkFHa1UvaDln?=
 =?utf-8?B?eThXek5MdWwvdEpkdlZpZjMxWkhFU0cwTTdBYTB1RVc2Q0lqUUdIRFcxV1Mv?=
 =?utf-8?B?bEhTMjBRSERTYjVSN21DTzJMQ1I2aElFcjNlbDVvSmRXWGIxcGJCc2l5SnhG?=
 =?utf-8?B?K2IxUHJncCtSQktDOVRycW1Bdk1Dc0NVT2RldmlHVUg3THl2QVUwWE9tNjVT?=
 =?utf-8?B?Y0xabURlM2RnNHh6ZWUyZER1NjBrcUoybnNaVlRzN2FlUm1zNVU2RFdKR2tr?=
 =?utf-8?B?ZDJmL2pzczg1bEx2OUJyWWNEU0hoNkpaNTlGdUwyWVI2eDBWdVdRZXppdHRz?=
 =?utf-8?B?eHJwWmNXcUpDZmxEN2N1V1IvQ01UQmVMd010c3UxVCtnVFBsUFF4blAxdllL?=
 =?utf-8?B?aHgzVVZNenFKOHRqR2hFRWRGcC9ZUTdsQ2JjOUYxbStzYlpzeDFhcnQ2ZXl3?=
 =?utf-8?B?T3BaNTZIdUxnWmxyaDhXN21kU0pSVW0yUU9zMmlkWURnR1pBam9zT2hVNTZR?=
 =?utf-8?B?cHZJQUxhR0ZFb0lxUlNiaEd2eWpmNzVncnNqN3k1WGFpNXY5Zk5hWGh0eUJi?=
 =?utf-8?B?TnZlNFVicmJ6cEtkRUkyd2lNOExsOUxFSkdqSEZoYm5KMmxwOU5XT3hCYW5s?=
 =?utf-8?Q?bYcZ4Cg/No9XzazBJNW2uAoZe+jTltTL8Kxdsx8dbNLq?=
X-OriginatorOrg: sch.bme.hu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f725b7d-c0eb-4b6f-ae5a-08de06af4b99
X-MS-Exchange-CrossTenant-AuthSource: PAWPR04MB9806.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 21:11:49.2375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 79f0ae63-ef51-49f5-9f51-78a3346e1507
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kC4r8nx95uQ0U1TEUbUVnncBuwollJmAnSo05IZ/Nn8XUvxTFzD3cvSNa/eXRSYArwGi69K0NyP0pn7xAVmA/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9326

Hi,

On 2025. 08. 15. 16:09, Rodolfo Giometti wrote:
> On 15/08/25 15:58, Bence Csókás wrote:
>> It is unnecessary to duplicate `What:` content in the description. It
>> makes it harder to both read and maintain.
>>
>> Also, the uapi header no longer lives at `linux/include/linux/pps.h`.
>>
>> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
> 
> Acked-by: Rodolfo Giometti <giometti@enneenne.com>

Cc'ing the linux-doc team.

Even though, according to MAINTAINERS, 
Documentation/ABI/testing/sysfs-pps* belongs to the LinuxPPS tree, after 
2 months, I'm starting to wonder if I should have submitted it through 
linux-doc instead.

>> ---
>>   Documentation/ABI/testing/sysfs-pps     | 29 
>> ++++++++++++-----------------
>>   Documentation/ABI/testing/sysfs-pps-gen |  2 +-
>>   2 files changed, 13 insertions(+), 18 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-pps 
>> b/Documentation/ABI/testing/sysfs-pps
>> index 
>> 25028c7bc37d8e50a2d4b53d954a2a0628c4a582..b8034ead5ae530c99fcfd280f295057823a3d613 100644
>> --- a/Documentation/ABI/testing/sysfs-pps
>> +++ b/Documentation/ABI/testing/sysfs-pps
>> @@ -10,16 +10,16 @@ What:        /sys/class/pps/ppsX/
>>   Date:        February 2008
>>   Contact:    Rodolfo Giometti <giometti@linux.it>
>>   Description:
>> -        The /sys/class/pps/ppsX/ directory is related to X-th
>> -        PPS source into the system. Each directory will
>> -        contain files to manage and control its PPS source.
>> +        This directory represents the X-th PPS source in the system.
>> +        Each directory will contain files to manage and control its
>> +        PPS source.
>>   What:        /sys/class/pps/ppsX/assert
>>   Date:        February 2008
>>   Contact:    Rodolfo Giometti <giometti@linux.it>
>>   Description:
>> -        The /sys/class/pps/ppsX/assert file reports the assert events
>> -        and the assert sequence number of the X-th source in the form:
>> +        This file reports the assert events and the assert sequence
>> +        number in the form:
>>               <secs>.<nsec>#<sequence>
>> @@ -30,8 +30,8 @@ What:        /sys/class/pps/ppsX/clear
>>   Date:        February 2008
>>   Contact:    Rodolfo Giometti <giometti@linux.it>
>>   Description:
>> -        The /sys/class/pps/ppsX/clear file reports the clear events
>> -        and the clear sequence number of the X-th source in the form:
>> +        This file reports the clear events and the clear sequence
>> +        number in the form:
>>               <secs>.<nsec>#<sequence>
>> @@ -42,32 +42,27 @@ What:        /sys/class/pps/ppsX/mode
>>   Date:        February 2008
>>   Contact:    Rodolfo Giometti <giometti@linux.it>
>>   Description:
>> -        The /sys/class/pps/ppsX/mode file reports the functioning
>> -        mode of the X-th source in hexadecimal encoding.
>> +        This file reports the mode bits in hexadecimal encoding.
>> -        Please, refer to linux/include/linux/pps.h for further
>> -        info.
>> +        Please refer to <linux/pps.h> for further info.
>>   What:        /sys/class/pps/ppsX/echo
>>   Date:        February 2008
>>   Contact:    Rodolfo Giometti <giometti@linux.it>
>>   Description:
>> -        The /sys/class/pps/ppsX/echo file reports if the X-th does
>> -        or does not support an "echo" function.
>> +        Whether this source supports an "echo" function.
>>   What:        /sys/class/pps/ppsX/name
>>   Date:        February 2008
>>   Contact:    Rodolfo Giometti <giometti@linux.it>
>>   Description:
>> -        The /sys/class/pps/ppsX/name file reports the name of the
>> -        X-th source.
>> +        The name of the PPS source.
>>   What:        /sys/class/pps/ppsX/path
>>   Date:        February 2008
>>   Contact:    Rodolfo Giometti <giometti@linux.it>
>>   Description:
>> -        The /sys/class/pps/ppsX/path file reports the path name of
>> -        the device connected with the X-th source.
>> +        The path name of the device connected to this source.
>>           If the source is not connected with any device the content
>>           of this file is empty.
>> diff --git a/Documentation/ABI/testing/sysfs-pps-gen 
>> b/Documentation/ABI/testing/sysfs-pps-gen
>> index 
>> 2519207b88fdffdc404238409cb03d0112ce1958..c36bac37a883f1d702ff97e63603d4df7e24de83 100644
>> --- a/Documentation/ABI/testing/sysfs-pps-gen
>> +++ b/Documentation/ABI/testing/sysfs-pps-gen
>> @@ -12,7 +12,7 @@ Date:        February 2025
>>   KernelVersion:  6.13
>>   Contact:    Rodolfo Giometti <giometti@enneenne.com>
>>   Description:
>> -        The /sys/class/pps-gen/pps-genX/ directory is related to X-th
>> +        This directory represents the X-th
>>           PPS generator in the system. Each directory contain files to
>>           manage and control its PPS generator.
>>
>> ---
>> base-commit: 88250d40ed59d2b3c2dff788e9065caa7eb4dba0
>> change-id: 20250815-b4-sysfs-pps-doc-270e54da51b4
>>
>> Best regards,
> 
> 

