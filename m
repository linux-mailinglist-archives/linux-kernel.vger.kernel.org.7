Return-Path: <linux-kernel+bounces-830873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D504CB9AC12
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED423A4D8A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5F030FC3B;
	Wed, 24 Sep 2025 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.CA header.i=@LIVE.CA header.b="U6nSpyk4"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010033.outbound.protection.outlook.com [52.103.10.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF1217B418;
	Wed, 24 Sep 2025 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728669; cv=fail; b=OMORzZ3S6rXxGYan00CRFBorY3iiBZJXqKS3dWRTVQr06rP5C4eFVVC4D8sL6sHWUfWq2DkhSnQ5a+R3K2lLV2OyTjn59UYL5sLJRBLIDT7zxHoUJWzLXegiYMMVclXUfpqoj6E8J3rus+TdUyH1VWgXH9qRJSOVT3EY2mTc2/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728669; c=relaxed/simple;
	bh=ZyCZsU4jBU53CtWTukkI4T1oX7Wm/iQK9wPAkERO4FE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pBUuuza9Y271AitROWnXCuI0n2vE7GhWXhcRd5plKFxWOW2TBVdfJ8LDpgaHOgYNT0UYtji3SC9Sqtfc6OLGR0qin/4wv6aTs+cMJ9LiOvo8rMADqneco338PxnLULzKxJ6McJebogf6SYAoyx6JH2Qz5JOw6qB6VVRYAiDj8W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.ca; spf=pass smtp.mailfrom=live.ca; dkim=pass (2048-bit key) header.d=LIVE.CA header.i=@LIVE.CA header.b=U6nSpyk4; arc=fail smtp.client-ip=52.103.10.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.ca
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpAuNV4yuaNxfNki+81nglAdY3HAvW1dGYWZsXyHrQsaExGDuScSHapVKbcfdnd5YNE1PnNp6m1pGn+wVzVXf8vHCHpwKwMmmS4Ah7NqVgIoB93tqeR6IgFZYlZSW7ncUpeTy1XRaGQHf1gwcfjx5i3CR978Pm1B0GWCQkih/nsI1V/5lhjnOlR3WkRACnwz+PDTnpFXJU9fHe3uW0aMBlzFYmgCQdymySLaeCccy3MT2uroq6EtNjwhUGgJ8+0KVNGjnwFmT5KdIdksx7eLA/Y1KqttesnjJI4HEX0+ufjrZKhy9jgtDKOziTPtJmniZWYxzTQ/Q+Cgu7F7l7B00w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cl7Q+QFn43hztCh2pk4r2hdzi99nfJD78o/eo8ddA0U=;
 b=PaMJ16VxWsL1SqPr5UJsg9/3dmOqC0FAE8pXfgTSoOgwFZskEEqDq1z+MuCbbmIQaoUf7fqwlxvoHFhIe/a4onvvVMndu8pzqHZg8QbOCYkaVECMw3bBULzxhjvkfiR43fUUccDuUscGHnHDMw4n+XL3AITma7AbOaihFu01lZvnlhzRX/CUTGpHoKXsB06TuGSiQiMsQV+SKE9QNv5hpJiaAhHRUMWPouI87v4YQDlU6F+6uSWZon1GErZajHOfWc0cWbzqVrumNxbsYIkjsdIUttDbVbPC3ToKqXY+Cx1ZjkFQEmOwL9CdJG2mt5wOWXlIwkP4SJ7dZM/Zmw7mIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CA; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cl7Q+QFn43hztCh2pk4r2hdzi99nfJD78o/eo8ddA0U=;
 b=U6nSpyk4j1Jc6QQH0AeTeMU4zoyXH5RvvNy4NtP8kbdjZefyHg7WpBbGFwWQsE7f1KpnasOij+nLoKoBJQfMsAKdx6pZQ8O/5hBLuuA45z+MMd7sWZBWv7c+0A5Un7uq6m63AMm4TkpiMtD4pM83qAnvaJxr+LthUeVIUCzOCwMJvxHJu5s7EpEgcv5w+e+ANAeNqVEmFf1UsViChDCtvwMC6RTmdgBgRwNKR57XcaFQ35Qpl+kkEmzTT1+U3fDYsoCpgs5+/47tgKdj0GUwncWMw42NYRJOjmnuaSzUxCxj8luvAk9t1RJuV7BUdNugdYLvPOB3Pozr1PZg4DfU2A==
Received: from MN2PR06MB5598.namprd06.prod.outlook.com (2603:10b6:208:c3::13)
 by PH0PR06MB7934.namprd06.prod.outlook.com (2603:10b6:510:a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 15:44:24 +0000
Received: from MN2PR06MB5598.namprd06.prod.outlook.com
 ([fe80::96f9:fd1e:4b7c:17f4]) by MN2PR06MB5598.namprd06.prod.outlook.com
 ([fe80::96f9:fd1e:4b7c:17f4%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 15:44:24 +0000
Message-ID:
 <MN2PR06MB5598AC9C807A8D3929E6C30BDC1CA@MN2PR06MB5598.namprd06.prod.outlook.com>
Date: Wed, 24 Sep 2025 11:44:15 -0400
User-Agent: Mozilla Thunderbird
From: Daniel <dany97@live.ca>
Subject: Re: [PATCH v5] platform/x86: lg-laptop: Fix WMAB call in
 fan_mode_store()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Markus.Elfring@web.de, hansg@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, matan@svgalib.org,
 platform-driver-x86@vger.kernel.org
References: <78e9dde3-9f21-9b06-663b-e7a23451b9e7@linux.intel.com>
 <MN2PR06MB55984287A9BAB69F1711640DDC11A@MN2PR06MB5598.namprd06.prod.outlook.com>
 <ea57d978-3fd3-fd86-aec7-e814359e3e02@linux.intel.com>
 <MN2PR06MB559873DBA3BA4491E08949ACDC1DA@MN2PR06MB5598.namprd06.prod.outlook.com>
 <175871961048.19584.6234729612579222383.b4-ty@linux.intel.com>
Content-Language: en-US
In-Reply-To: <175871961048.19584.6234729612579222383.b4-ty@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0319.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::17) To MN2PR06MB5598.namprd06.prod.outlook.com
 (2603:10b6:208:c3::13)
X-Microsoft-Original-Message-ID:
 <ec67ae3e-2664-4935-bbf3-e050cdf1f7ae@live.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR06MB5598:EE_|PH0PR06MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: b976598d-342a-45d7-c51c-08ddfb813c28
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|41001999006|19110799012|5072599009|6090799003|15080799012|461199028|23021999003|440099028|4302099013|40105399003|3412199025|12091999003|26104999006|10035399007|3430499032|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWEwOXVyLzM4ZTBYOXRNYjkwemNtaWxGbmFGekRqdzFTbTNDVzlBalI5dytZ?=
 =?utf-8?B?R1hKRU1kWXVES05oSzFWOEw1cllNM1krbUpJNENMam81NExxTlZETjZ3UENK?=
 =?utf-8?B?em5scm1Ba0xkSTNudmpYSmJyamJjS3dTYnJFS3M2TW1panludms4Wkl1QlJ2?=
 =?utf-8?B?eTRCZGZTTE5mb1pFemFoeEJ6S3Y4bjdsZ0ZIcjZaOWNNd1ZXOWVSVTVtSnZ5?=
 =?utf-8?B?V2Jjc2o1aDhSUTI2U09NaCtCOWJndHVjZGNabUF2bEJ0U0Vja0hRQUViMUI1?=
 =?utf-8?B?RGd1WjAxbnRJUmp2VGlzN0h2NmxFUCtCMWlHZ2FXRWVIcGRleWRZb3dZOWNZ?=
 =?utf-8?B?WmhRYXJZU3J5M0FGalEvVXBuR1VMZnB1cmdrdkNxT2dxc0FHSVpFV3o4LytQ?=
 =?utf-8?B?eUNYM3h6MDI0cnpObWpTN1ZjY2ZlOWlJdy9Fc1JHc20rdWhYQzZiT3B4Rm82?=
 =?utf-8?B?cElrL2hyUnNJcFhXbkRwSGt6eU1QWXlTOFNJS1ducUxIbEFMN0pEbVFFc3dn?=
 =?utf-8?B?WEhhcUkwNzFka25tenhuZ1dveDJ5cWNvT29WSnFXTWdrZnNuckVLY3pzbk8w?=
 =?utf-8?B?NnZtUnZNVGltK2xVcFJIeUpzeUMxb2JuT3c2MFlXaEtSU3FVV3g3NVFZdFNS?=
 =?utf-8?B?YWd2VjBxTTlPUGg5Snl6dFcvMU5qSWpoWThkaFlRM0FuZjBBaXgyY09ZUmI5?=
 =?utf-8?B?elhVQjR1YjF0NWR3RlE0Zkd0elBCZ29MLzJVeXhwMktobTI5MUx2WERBSUlu?=
 =?utf-8?B?SXpFL21SRWVrQzhPNHZaTExndkxvVW03YmQxMGdzVGg2R0ZGMjhZN09HcWtQ?=
 =?utf-8?B?TWorZ2VEejBGellsY3V0VDcwNlhDYXVyeXpKVDNtUm9sM0d6WFJFdVg3Zjlt?=
 =?utf-8?B?ekNmWXBERU1HY1lDakFKdU9iQ2hEQWJtTDRSU1dqSWpUbGR2U3NPWWo4c0ty?=
 =?utf-8?B?M0R5ejdkaE9WVjJJL1lvY1RJRkVKT3h0UytMaWNzK0t1TlZtUTI5dE8rZDQ3?=
 =?utf-8?B?QU9Ib1pmU2R1Z01kTlVEUkZyZml0M1dVSmhqZHo4eVlBcGx6dkpqSzJiVzdB?=
 =?utf-8?B?UnM4ZXRCczcwbTFTekJCNTl2cmM3UnpoWWZDUEx0Y0Uzd2J0dzMyc2w2QTMv?=
 =?utf-8?B?NUpnYW16bU5zSm5VcEYrV3hMWTZ1WE1sOGhLQXlPNkJKbVNVeDVZRUV6NVdl?=
 =?utf-8?B?b2ROa0FhZHBMYzQxelU4ODg3SVpXQk9yVndGL2pEdlNyd2RXY3RpdExMSGc5?=
 =?utf-8?B?UDY5akNPWDdqR0piY3l1TURrbkoxTTVlOE05emx5cjJZbU90aGthUERTdG1Q?=
 =?utf-8?B?QnFoYVBQUHlWRFROTE5ianh5MVhLSDNlNG1MSmEwZG8xMWVzRHdaVjBsejFS?=
 =?utf-8?B?MGg5WTNVd21uVUV4VldONjk4UnNSMmdrWnB4LzdEdVhFSmpGZ3JoRlZPT2tj?=
 =?utf-8?B?TThXQmZUQzFGbDBxcUJQZnZnQ3NQT0hzWjhSaFoyQklWTEVtK1pNbGI5RXFp?=
 =?utf-8?B?d09EeC9LSzlDNUdkd3ZYYUJpcXhsOGJCU1VuTGpTdmJlamg1K0VFUGVnZXAz?=
 =?utf-8?B?eTJzaEhjWGwvSG1MTTNCTFFrcUluNGtkRHZ4MzFpNlRMUXR2YitIT2lYekdX?=
 =?utf-8?B?Q1VBRUMzVEZrT0tnbi9uclVvaXEzYVBtNGNZU0VhVFM0T2tZZ0JFZDBxbTNE?=
 =?utf-8?B?azJtL1FvN3JOWUcyL25uejYrM0FaNmZDUWFCUmhYY20zQlNEY0wxaEl1V2JW?=
 =?utf-8?B?czIxUTRWVTUweEZKUUJONjJRWG5KTUxVNjRGSndsM3NnRWJvVGMzMlhHelBw?=
 =?utf-8?B?TlAyakhxcXU4YW15dUdoUXZyN1B0MEIrUUlpMmtWK3R5MmpBQnlPOHQ0dXBr?=
 =?utf-8?B?ckFOeVAwMGlERW9wVXhUSkpMbW8xZnM1L2M5b3FMUHVjTkE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFN6QUQ3K0JLT3VJeVVWNWtMbXdUa2VtVzlWanJ3R1FnaDY5bkZlckVLeTVE?=
 =?utf-8?B?U2V2SlZVNmxTdDhoS3ZRbzVJQ05ncWpYODVGL2F0VGV5czh6cWJxNDB5QlpB?=
 =?utf-8?B?QjREWVYvVWhHUG9USGg0MHhyUlYzcVppQVVuK0xSSjUyeDdIaFl1VU5QUjVT?=
 =?utf-8?B?K29MTCtDZlhDSWJPRTE0WXZ4ZkZRdjIxM01MLzRUNWhHQ0dVd1BzMW1maWFI?=
 =?utf-8?B?enhobHVjNWRsSksrTGNSYTZoWFNzY0l2NllTclpUcldSS3FjNDlxZnpUZSt6?=
 =?utf-8?B?WEF2UFE0cHpiLzZDNC80b3VpT3NacmJqWjZ4aUI1eldkUnR2amViTVIxUmJQ?=
 =?utf-8?B?bWp5eSswTnFZR3ZZOENLdFpwdzRZaGJvaG5qQU95dU1SQVA5Ly9qYXFmalRQ?=
 =?utf-8?B?MStNelJGYU9md0gyKzBadGhPdkRqNlpLWmpwQ1NCdFExb2xsT3QyOHZDQlcr?=
 =?utf-8?B?MjVQOGhQZWdxUkJiTnFpUC9jUzFkaWRVRmZQeEgzY3VROGVzbFArUzRGSW8x?=
 =?utf-8?B?ZWQ2SFZOb1I2N1BNdTNnZTBHU2d3eUR0LzFmdzFhUjl3anFvRm1nQm1MTnN2?=
 =?utf-8?B?eDlZcUpyMUJTNnNoMDFJYytsSFpOV0ozMm5tWjlycVZnZmFOcUJKYTFISTNu?=
 =?utf-8?B?Nk1nb1R5a3g2OW5VMnUycSs2bEQwUndKQ3VmUmJVUmJyVUVMNjRMT0hNRmZQ?=
 =?utf-8?B?dlZxcnZ5QVdqakZ2SXB4VFplVnA5aUFsZHNKb20xNThJWmgvQ3RWc1ExVmpz?=
 =?utf-8?B?RlZoTEhIT1pGQlVoVlc0NGF4WjVmYVR1blZOckRQaWhFQVRJRGtRem1KU3Bx?=
 =?utf-8?B?SVl2OTIxZno4WnBOb2JJVTBkYlJTMEw0UklkMnZnL1o4UWVwc0x3STJ0bk5M?=
 =?utf-8?B?bEdCWUd3b2d4VEZIL3lBbzNxOVpkc1pVTVdqY05TNXlWUGFyMWVSOVBlbGx4?=
 =?utf-8?B?MEkzaDJmZkg3VnhoeFp2V2YrSDI4LzExSURaSXkzdVdsWkxTS2NYTlVFYmdo?=
 =?utf-8?B?TDBJZmthazZORW9PelVwcmxxNTZocnJFTXBkUTdGVmRBRDE1M1V6cXlIM2xQ?=
 =?utf-8?B?VGt6ZGRlNXFSRG1PdFhlUDF5UkVPTCtaRnlyK0QxdzMxUFpTbW5TNE0vdWcv?=
 =?utf-8?B?bHJWa3g0YWZuaWpSYXhETllmTE5OSTR3MGY3ekoxalVOWWpHbWVrN2pyaUVP?=
 =?utf-8?B?L08vMk5RcVY1b05oMTJxS041TFA2SnlKOXpWK3RWcE81MXdRL2Q2K254M29i?=
 =?utf-8?B?SEtiYmZEeXRsZ3oyNXI5RHRwRUh2SllHdzh3c3NQdGhBbEZUZU1TY1RwR3U1?=
 =?utf-8?B?RTB1VWhuVFVjNUtTM3Z0c1I0YzVxQVlYa2ZMOWphN0V6K1huZlg2V0RvRjFL?=
 =?utf-8?B?VmtBSE9Sc09menhhWWowVlhzb1I2STViazhPc3NEN2d5ekZrVjl4OG1YbVk1?=
 =?utf-8?B?VDR6dU9BYTgzSk80VTlYZGxDTXJZNEZPNU13KzlBV0xyaWNva3BPTkw1aVZk?=
 =?utf-8?B?Z2Z5cWQyMGdRdlRseCthK2MwakdoL2l5TkRrbWo3S1lPY1JIdXp0K2Nub1FT?=
 =?utf-8?B?YVprR3V2d0tCbnVHOW40cUxscWp1Sml1R2k2VEdMNkx5R1BrYWJOVTkvWC9l?=
 =?utf-8?B?dHVMbVRNdXhiY0tWOW5SVDB1YnlDRlE9PQ==?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-a1430.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b976598d-342a-45d7-c51c-08ddfb813c28
X-MS-Exchange-CrossTenant-AuthSource: MN2PR06MB5598.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 15:44:23.9312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR06MB7934

On 2025-09-24 09:13, Ilpo Järvinen wrote:

> Thank you for your contribution, it has been applied to my local
> review-ilpo-fixes branch. Note it will show up in the public
> platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
> local branch there, which might take a while.

Thanks a lot, but I was actually thinking about rewording the body of the
commit message.  Could I ask that this version be the one to eventually be
pushed to the public repo?

Also, this patch fixes an issue raised in this comment on the kernel bugzilla:
(https://bugzilla.kernel.org/show_bug.cgi?id=204913#c4), but crucially not
the issue itself.  Do I mention this anywhere in the commit message?

-- >8 --
Subject: [PATCH v6] platform/x86: lg-laptop: Fix WMAB call in fan_mode_store()

When WMAB is called to set the fan mode, the new mode is read from either
bits 0-1 or bits 4-5 (depending on the value of some other EC register).
Thus when WMAB is called with bits 4-5 zeroed and called again with
bits 0-1 zeroed, the second call undoes the effect of the first call.
This causes writes to /sys/devices/platform/lg-laptop/fan_mode to have
no effect (and causes reads to always report a status of zero).

Fix this by calling WMAB once, with the mode set in bits 0,1 and 4,5.
When the fan mode is returned from WMAB it always has this form, so
there is no need to preserve the other bits.  As a bonus, the driver
now supports the "Performance" fan mode seen in the LG-provided Windows
control app, which provides less aggressive CPU throttling but louder
fan noise and shorter battery life.

Also correct the documentation to reflect that 0 corresponds to the
default mode (what the Windows app calls "Optimal") and 1 corresponds
to the silent mode.

Signed-off-by: Daniel Lee <dany97@live.ca>
Tested-by: Daniel Lee <dany97@live.ca>
Fixes: dbf0c5a6b1f8 ("platform/x86: Add LG Gram laptop special features driver")
---
V1 -> V2: Replace bitops with GENMASK() and FIELD_PREP()
V2 -> V3: Add parentheses next to function name in summary line
          Use full name in signoff
V3 -> V4: Add include for linux/bitfield.h
          Remove "FIELD" from bitmask macro names
V4 -> V5: Rename `status` to `mode` in fan_mode_show()
V5 -> V6: Reword commit message body

 .../admin-guide/laptops/lg-laptop.rst         |  4 +--
 drivers/platform/x86/lg-laptop.c              | 34 ++++++++-----------
 2 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/laptops/lg-laptop.rst b/Documentation/admin-guide/laptops/lg-laptop.rst
index 67fd6932c..c4dd534f9 100644
--- a/Documentation/admin-guide/laptops/lg-laptop.rst
+++ b/Documentation/admin-guide/laptops/lg-laptop.rst
@@ -48,8 +48,8 @@ This value is reset to 100 when the kernel boots.
 Fan mode
 --------
 
-Writing 1/0 to /sys/devices/platform/lg-laptop/fan_mode disables/enables
-the fan silent mode.
+Writing 0/1/2 to /sys/devices/platform/lg-laptop/fan_mode sets fan mode to
+Optimal/Silent/Performance respectively.
 
 
 USB charge
diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index 4b57102c7..6af6cf477 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/acpi.h>
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/dev_printk.h>
@@ -75,6 +76,9 @@ MODULE_PARM_DESC(fw_debug, "Enable printing of firmware debug messages");
 #define WMBB_USB_CHARGE 0x10B
 #define WMBB_BATT_LIMIT 0x10C
 
+#define FAN_MODE_LOWER GENMASK(1, 0)
+#define FAN_MODE_UPPER GENMASK(5, 4)
+
 #define PLATFORM_NAME   "lg-laptop"
 
 MODULE_ALIAS("wmi:" WMI_EVENT_GUID0);
@@ -274,29 +278,19 @@ static ssize_t fan_mode_store(struct device *dev,
 			      struct device_attribute *attr,
 			      const char *buffer, size_t count)
 {
-	bool value;
+	unsigned long value;
 	union acpi_object *r;
-	u32 m;
 	int ret;
 
-	ret = kstrtobool(buffer, &value);
+	ret = kstrtoul(buffer, 10, &value);
 	if (ret)
 		return ret;
+	if (value >= 3)
+		return -EINVAL;
 
-	r = lg_wmab(dev, WM_FAN_MODE, WM_GET, 0);
-	if (!r)
-		return -EIO;
-
-	if (r->type != ACPI_TYPE_INTEGER) {
-		kfree(r);
-		return -EIO;
-	}
-
-	m = r->integer.value;
-	kfree(r);
-	r = lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xffffff0f) | (value << 4));
-	kfree(r);
-	r = lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xfffffff0) | value);
+	r = lg_wmab(dev, WM_FAN_MODE, WM_SET,
+		FIELD_PREP(FAN_MODE_LOWER, value) |
+		FIELD_PREP(FAN_MODE_UPPER, value));
 	kfree(r);
 
 	return count;
@@ -305,7 +299,7 @@ static ssize_t fan_mode_store(struct device *dev,
 static ssize_t fan_mode_show(struct device *dev,
 			     struct device_attribute *attr, char *buffer)
 {
-	unsigned int status;
+	unsigned int mode;
 	union acpi_object *r;
 
 	r = lg_wmab(dev, WM_FAN_MODE, WM_GET, 0);
@@ -317,10 +311,10 @@ static ssize_t fan_mode_show(struct device *dev,
 		return -EIO;
 	}
 
-	status = r->integer.value & 0x01;
+	mode = FIELD_GET(FAN_MODE_LOWER, r->integer.value);
 	kfree(r);
 
-	return sysfs_emit(buffer, "%d\n", status);
+	return sysfs_emit(buffer, "%d\n", mode);
 }
 
 static ssize_t usb_charge_store(struct device *dev,
-- 
2.51.0

