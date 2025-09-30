Return-Path: <linux-kernel+bounces-837123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E62CEBAB6F6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B82C3ABAD1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B0B2627F9;
	Tue, 30 Sep 2025 04:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Jn4RJxUo"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7E0288DB;
	Tue, 30 Sep 2025 04:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759208279; cv=fail; b=nV5BgtEfejN62qi/SM2vWZ9ynaN46BZEhaj1NrCl/d1ElPOYZv3By48D8lgqIdVot+smJA4Zy1Zaw0yB6vNZk3M9GfwJIm8y41uOUiA1nJngWsmvziBQfitBg7cXThYaFm7R4UXEureDu22fgFLXqNecsyrJjKXTYOxPNZDkx/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759208279; c=relaxed/simple;
	bh=wjJJ0pTbOMr3zPJlq0Uno+Kp7BdVZT5/Rb6TzaepgUk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=On2mjYwnoIszw2/B13BPetU0OrGWE6oc7WYH5xriOTppfInemoNCi4e2Rj/wGRY4LtaKX3ddS+qSnLZbmTUUGoXsBwH+Cw9Feiaxtl1AGwJFrY/yqS1ViV8pWAQ9ORhl6+yfII0DfKew121J3R9jtVMJ/ebCucptIIp9oEF3SrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Jn4RJxUo; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58U4i0a02639373;
	Tue, 30 Sep 2025 04:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=wIQGxKFJngZ6YrJ79pzy8QSUzfrWOQhbGL+WPzcIbDA=; b=
	Jn4RJxUoX5EHBYlT3UBnbj5GHY6bboWS5XFqpt8AonqEy+SZ1daYISL11+OyQQRA
	VH68skLImzAHgzVluBareNvSB553BeMS54Q+BxH7rsMHq3OfJk7LFIQKSFhXO5Pg
	DxR6ki3+QcXhCqDExC2nzq4JpA/+sgaQ6PaqTF2yiYGdekbvcP6DzRCKY1ZObfYM
	0ooxKiVJZA3CdmSwXDDidxVgoYduu2alpnKSqCpOxZsjrl1tPfbxhd94c/9uur03
	88icNspmIMkmm3Ii5iamcHsiMLavu1qJP+MtSoub/JFX8/1hIiGHoUMGQyrnFe2t
	x2U55t3m/D1BwGNK49xNhg==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012014.outbound.protection.outlook.com [52.101.48.14])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49e54wtxyh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 04:57:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baa5vCOs4119BZbtNq1MewsQoSxMMjj7nYWsctENd2HWvjKe9yAqMQqMzYd5/YFax1T/bHucEb1JzRQ7IBOAKV2gV/5837c+GPFO2+0DVToAec0wQy2aC56juC7B2pN2QDAQvbHoXbypE8j/+q3CgO5TOp0HPY90c9d6sr/VGSKtdkUes+1RWEyO7NuUA44NHGH2GMwP0x/hy9kWYX00TvPi5hS4MBtDofMH0wqkJNzJRAvmElQ2RFrNoVAw01/lJQpk1/SCN8LnjA2n6+I0sCPCt9fBDkeQOt8suYw9qCAO5by1o3ihXb9T7nIDbQQpzsc719qImFFTLpMwBCfkHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIQGxKFJngZ6YrJ79pzy8QSUzfrWOQhbGL+WPzcIbDA=;
 b=lVkwq6soW5FN0lwVECcjHbZFuBQrHT2W+sd5X/xX+OXqMjAJy8DZMdnRSoRiFcYlmQBeMbj/VrtZVp8KZMHAgSGdeDveAxnRWQKDrTevIaRY1OCuRI9fZAlngx0oK50TijRBfK3bUuh8v8jedZ/2/OKz4gXvyYbKlKFB/GvGK+KhvpBMOOBz7x00UETp3T4/3ep0LFMQbuxZEpWKEYdC9/HW99v0iXSprc4DkobM2HdTgAcld/Mf7VwCpVUCUiQNywr1STUdmiuH5AfjMTXcjKIhQ7q6B2SwZtCG+AQpxSNciAx6y+ZXd9ljw26x84QHhQaGmzlvDZpvv84xQxUeJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ5PPF2F7FC4EE6.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::81d) by LV8PR11MB8606.namprd11.prod.outlook.com
 (2603:10b6:408:1f7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 04:57:45 +0000
Received: from SJ5PPF2F7FC4EE6.namprd11.prod.outlook.com
 ([fe80::5cd3:aaa1:1564:3e48]) by SJ5PPF2F7FC4EE6.namprd11.prod.outlook.com
 ([fe80::5cd3:aaa1:1564:3e48%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 04:57:44 +0000
Message-ID: <a77dc81a-e8fa-4f9e-8915-3b8f352c114c@windriver.com>
Date: Tue, 30 Sep 2025 12:59:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: fix slab-use-after-free when
 clk_core_populate_parent_map failed
To: Brian Masney <bmasney@redhat.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, dianders@chromium.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250929083119.2066159-1-yun.zhou@windriver.com>
 <aNrj60UeYQfXmlJ2@redhat.com>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <aNrj60UeYQfXmlJ2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To SJ5PPF2F7FC4EE6.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::81d)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF2F7FC4EE6:EE_|LV8PR11MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: 90e59e45-6aa5-457b-5010-08ddffdde474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akRDNStiSExDOW5UY3NHTVl0YWd4eDJaeVpoY2dQMWxWR1VlSEZmVUVTeXQr?=
 =?utf-8?B?dGxzdFNrMG42ZlJwS0xMR0M5eWEvdW9xMk1Kc2x1VkhZYVM2NHhDcnNnM0E3?=
 =?utf-8?B?SFFuZWpXQkZKNCttRXhDWHU4STRRY1dGbkZpVVJNeUorM3FYVVc3c09aSFU2?=
 =?utf-8?B?U25VZlQ3V3dwYm9SWFAzNStPWXhhWGpuRTlHZG96MXM4dnBuNnZqTGxwTVIw?=
 =?utf-8?B?MG9NRWZVbWF5aEZaT1dzS1VyOXp3WHlJd2htaWwwemRPdHdqZHVqTmFobU53?=
 =?utf-8?B?ZEpNb1hPRGJuWWdReVJrRUR5TXhRYlpxK0UyRnBXSkJQS3JuWFMzcm9rcTBm?=
 =?utf-8?B?QU5yMjBiVTJDVUgyZzJSSHFhV2hBQzAyV2lDTldMUEt4WVJJblphQXZKbTRq?=
 =?utf-8?B?bzZSL0lJZjdseWNZRDIwRU9UZytjazlDZjkzZjM0a3NxRGliVzRTa2Yrb1VX?=
 =?utf-8?B?MHNndm5LaGJBc3c0SnQ0dHVFSk5vWE4wZFBEa0k1bDVtUTdIcFM4YTBUc3pt?=
 =?utf-8?B?RURvZ1orSStoQ0puUHFsRXFaaDFTaWJlekhWM0NITUYycDNLbEpYMkI2R3Vm?=
 =?utf-8?B?VG0wQWdRNmN2MzhRQk53dXJHeTc4MXFieklrM29MUTlPN0dzS2p6dllmMVVl?=
 =?utf-8?B?U2liMnFCalU4dFhYRWE3RmpEbHF0TW91WEsxN2M3ODhsNHgvMzQ4SkE4Z0Fs?=
 =?utf-8?B?c2o0dVpaMFpybXYzeUQyT0xUOWVZVFIyMCtYMUZ0UVJrd3Y3eGs2UFlEdzZ4?=
 =?utf-8?B?ZTB4eXNyMHRlMmhFZGYya1lYVEF3NjloMU52RHN2TUo5S1VuTDZmWUlteHlw?=
 =?utf-8?B?cERreWo5V3VDVzFtSTlncnVTTVN6NjBtTFZVRmljeGQ2RnpDdU1zdStxZ2RD?=
 =?utf-8?B?WkloTWU1LzN3cXpoZlJZdzZJUHZoeEYvamx1T0pvT0g2VEVnN0o4VFRDckJr?=
 =?utf-8?B?VEZEMm1KNEsvSHd4WDU1MW9vWTlZd3ZjMU9UMHp6cThER3E1SkZuSUhIc1gr?=
 =?utf-8?B?L01NbUJWeHdIYS9KeVY0RDF3dTVpWS83OXVXbzhnMm1hMVBGNjREOXZBRmVD?=
 =?utf-8?B?bExkSDNhdFNkNkNkbjBOaXVkcFNpbytCQmo2aW96S200TWV0WUhUTkYrRGNN?=
 =?utf-8?B?a0xWakdybjZ4TCswWExITGVwenloL3pPcE9CWU1Ua2VXcU51cThPYVZzM2Yz?=
 =?utf-8?B?K2FXTEM2Q0p1YnJxeUZENjdBTnFlL1doay95NXhxVmVzaWZJcGV1cUVDWGdu?=
 =?utf-8?B?dGhqRTRyUDF3dzdsa2w5RGNyN29EM2FUNEUyamlFdnRnWW1PUFgxZk8rVXZZ?=
 =?utf-8?B?cGgxOFdtUTZOeExvdFNWNXprdS85OEEwc0VhbXR5bUtkdEtIVWswa1ZIZHM4?=
 =?utf-8?B?LzB4MlR6QXNMRWc3cGZPSkxMdm4wMU9XUGhtWDlhbEkxNlFCRFBvYm5MeE83?=
 =?utf-8?B?a3craXMyT0dSRVMvMXpnOTJFZXV2TmtTVlRpcEpRNHQzeVdjWGdrRXhPcWRE?=
 =?utf-8?B?d3Y4NVJpMFBuT1BUM2dLWDNjMVBHdTdRSUxkZjZMOHJrK3FZeFJBSWN0S0Rx?=
 =?utf-8?B?TlpGSWFTRmcyajlLQ3BJOUg3Y2hKY01YeWJoUldoUC91dGdSV25vNlZtUUF2?=
 =?utf-8?B?ZEVOdkx5UWxZV3R0Um1BM3l5SVhMYXB4OTMxc3R0c2xSM205bHFlNzRCdDFN?=
 =?utf-8?B?YVVVUmVoS1YxTnpJd3g3YTVzYXJtNk5DV1BTdDZZdFBkSEZPNVpJajUyODhK?=
 =?utf-8?B?eENmbTkrME1uTFl2elI3TDRJQ3N6ZDI1aHRlUXdXNmYzZ1F2UmZhWGZKbnBG?=
 =?utf-8?B?aUlaaGlYd0sxWHcwUmZoaDFIV1YzK3Iyazlob3VoaHM3SzVLcTc5UkhtYU8w?=
 =?utf-8?B?M3RSdHpJRjFTNVpUc29DdWJkSHdNbFB1UzVhMXNsbEpGcm0zQ3hOS0JtSVlF?=
 =?utf-8?Q?glLswZAYTXlfEK+t28YP26RtWp/aviAV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF2F7FC4EE6.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXRNUkZrUkc4Y1liMXBBQTNkNi84TjlzNFk5azI3RUo4aStkSnNKU0dyRFds?=
 =?utf-8?B?cjJhcmlJVmlUTUQ4RmlsazFoWWpIbWxkaVU1Njk0UVh6bTJxblRXbWU3M2VR?=
 =?utf-8?B?emFoYXFrM3QvVW02eHd6ZHA1WkhnZEJ0SEcyZkZoSkhqejBHM3Qzd1R6TzR3?=
 =?utf-8?B?RXQzYUNwdTB0NlJyeUJuRUZsQjhpQlZUMm1QZHduUy9FWUg3RDhja1NrRzdI?=
 =?utf-8?B?MVkvRXBGYXFpMnJQYzFRdXNwRFllYTRpMmFnaGtBZElpOGN0VFcvNUdsb2dI?=
 =?utf-8?B?Zm94UDcrKzBkUyt2VVI1OTFmc2hTaWgwUXZtTTN4bWh4dHhoTjBuRnltZVF1?=
 =?utf-8?B?TkQ2ZVkxWk9OZEZsUTdnVTFtNkZWRXFzRTJLOWo1VjlCSzNLeUJNN1JoL2lj?=
 =?utf-8?B?VWJLM2pSK205OTloOWs5bm9WQk9iMmcva1BlZVl4dnZ2TWZ0VWlXQmlLZnM3?=
 =?utf-8?B?TzBRRnc2clVZalovYVNSaW9veG5CblNJWThtSThZd002S0wwSWJZVXZTbzFL?=
 =?utf-8?B?UWJRMFVJZm5KYStWdEtndE9vbnB5TFpyZHR3NFJFZEp1cUQreGZYc2ppYXZt?=
 =?utf-8?B?TkpFY01jMmZpTWJPOEw5SCtuTEk1L3orbE1oNThXL2h0UnhyRmlEaDdSMzJr?=
 =?utf-8?B?RjJCUnJiaGd2Q0JhRGVCVUI1ZzhrYUV5ZEsxMWZQNkVUSUlBNFRtbXJmUXNs?=
 =?utf-8?B?VjZXQkZSc293ZUlEcWh5ZDhnYlBFVkVjL2JwZy96dURUSkIyaHRTY0FEZVdQ?=
 =?utf-8?B?NjlFcU5zQWF5YmVTVjRBUkk5N1pWdTNaZDBEaytjckhMa1hlcjJuQ3ZYL3FY?=
 =?utf-8?B?SDJDdjJwY3hYT3BHTVBlamFGMEhmK2w3YnFXVk5ZTDhPWDRVZlhkOGIxM3Yz?=
 =?utf-8?B?YzZCbDlYVjZnQTZyR1JzMURCcWZmK1IvTExFZkJZSEZBeWdaUEgyOTVpT0xL?=
 =?utf-8?B?cnBTcE93Q1pjWkEwaUxlSk9ZSVdvem5SbGtqdzdnNER2T3FNanhPVjVxMHFN?=
 =?utf-8?B?SStlMUdLREJSSFoxYTB2a083U3lQRXM5bGVMVWRidmRLVmtySjg0TjZTcGJ3?=
 =?utf-8?B?WnJYQWxFUUNiakZ4WDZXOXV0eHovRkg0Z1NiVXFpR1N0bWxaTGxkZHh2TXQv?=
 =?utf-8?B?Zlg1VW1MTEZFQWZxYktCQ2NETlpXTXR5c0Y0OHZnS09vTDFSdzNzL2lsSVdR?=
 =?utf-8?B?M1BDcjFScXFwWWZqYUk0bktFamlrUGM0VFBpS0pQQ1NkbnhtbUxJcHNGZnor?=
 =?utf-8?B?Z3ZrSnpPYjlYZWp2UkFFeEkvUmo3RE5TNENjYWhXVURyVi9MU2lidlVNUFRU?=
 =?utf-8?B?TGpReWsveHQ1V1V0c0FmcEo5anlZVXJrRkpvYTFWOWNydzBFaWUxQS81NFJu?=
 =?utf-8?B?Qzg2cVNjNlBRMUdEVWRHdVgrcnVjYWpsenpoVjBVNG9iTFFhTGFwa0JjZ3Rw?=
 =?utf-8?B?WjR6RFNEMFp2RHRoU2R6Ny9sR1VYRk0wcnc2Y2g0cjU3d0FpcW9pZmV4VXlQ?=
 =?utf-8?B?d2dTK1RWZ0NRb0tkY0NpbmFVeHpyWWZEWWc5ZHRLSGRCK2QwNkh0REZuTUNo?=
 =?utf-8?B?UmxBdStQcWZiaFVtOTFkU3p0dy9DUGFoOGYrTXoxM0phcUVkcHJ3V0FRUmtt?=
 =?utf-8?B?VlEzYUR2OGpEZzJCT1BWbDR3TEh3dTVUTmFBMWRtdFhnRHA3R2sxV2RmalBk?=
 =?utf-8?B?dWFxNEprSUw4R3FmeGlOTW5wRHMvbWpld25OVEdrZmtLQVNjb1lBckZNNFIz?=
 =?utf-8?B?WVdFNVpVQnZDaGNVRzJXU1BiZVR2Z2JMUEFaMUJ3eDgvRmpNc3NsVmh5c0xy?=
 =?utf-8?B?ZVoyTHNSQkc3NUNUdTNobkNGT1I1a0lEb3gxTDJIaElOR2tmS1lWL3FhNklD?=
 =?utf-8?B?Q3M2Zzg0UmFvZURsOUwrS0N1UTRvQW93c242RjVOa2h6VzFUbitGZ3dMcnNI?=
 =?utf-8?B?VHhFNEpGYWNnTmZEOUNiTTAyQitSU1Bkb25hVzFxRkJid1ROQ2h3TnZwY0xR?=
 =?utf-8?B?YnZVRDNMYmhITmcxUUozRmdKMHpQdWh4MlZIUjR4ZU5IRzNINlJiZGpFdHY3?=
 =?utf-8?B?TmNNMFpEUWxONUxLZ0YrMWtBN3JON3FNOHMzV0lZZDBXa2RsdVI5K3NhdWxj?=
 =?utf-8?Q?RU8U26j2cg41QDJ8hQvppCPiD?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e59e45-6aa5-457b-5010-08ddffdde474
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF2F7FC4EE6.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 04:57:44.4873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rsm4S+yOdo9DXXUxvS4C+lt81yEt++HYbYsRhv9aDtMlGMhgp4UyhKZTlXpLb1y3wZ8JrKnKcMg4kQYcdBlQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8606
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDA0MyBTYWx0ZWRfX7cRe7Ljlu3Cd
 DowBVFvtRblWNS6b25YAa1GmxUFXpmVSwtIThIKCK10WsfFvQ2oyRJI0wMmjlgF4cL+2bqGSLq9
 RGp6emFxz1OrjihmrOd+MZqk+WMvmTk4mRS7phPGvDRzhC6sEY8Gf5BAY1PRZmEIphsacF5bnwt
 mEYXuKt1da+4GnsMStPNoRAV0qg/l71H7plwtr7Smr16ceg96o4239qx4qGnkvsdKO1vsmBGG/1
 yKEKecYHXGv/CaUliYiVXZ780DEg3el6UXRe2ROUJkisZ5flr83D3O2mDHy0uGzhm7JIS8FYCoU
 pFlUg1KZZcWjkW7IY/NONZAzBrGnbiu9Kj2EJ4NxzymMzKEkLD3KP1J6Yg2h1ilkdQIee1fKkQw
 vx5zo3KtAIh11q5xvhj5ifcpakfoPg==
X-Authority-Analysis: v=2.4 cv=ZNPaWH7b c=1 sm=1 tr=0 ts=68db634d cx=c_pps
 a=gI/9N9KNcdRJH0Veu/zMvA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=t7CeM3EgAAAA:8
 a=zbmeMhQIbF-rlxe_PzMA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: DX7MgVMtIURhjEqYXWMwuxOeojipWoUd
X-Proofpoint-GUID: DX7MgVMtIURhjEqYXWMwuxOeojipWoUd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2509150000
 definitions=main-2509300043

Hi Brian,

Thanks for your review.

This defect is caused by multiple reasons, but as you said, the fixes 
tag is not accurate enough.

I think it should be:

Fixes: fc0c209c1 ("clk: Allow parents to be specified without string names")

Do you think so?

Regards,

Yun


On 9/30/25 03:54, Brian Masney wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Mon, Sep 29, 2025 at 04:31:19PM +0800, Yun Zhou wrote:
>> If clk_core_populate_parent_map() fails, core->parents will be immediately
>> released within clk_core_populate_parent_map(). Therefore it is can't be
>> released in __clk_release() again.
>>
>> This fixes the following KASAN reported issue:
>>
>> ==================================================================
>> BUG: KASAN: slab-use-after-free in __clk_release+0x80/0x160
>> Read of size 8 at addr ffffff8043fd0980 by task kworker/u6:0/27
>>
>> CPU: 1 PID: 27 Comm: kworker/u6:0 Tainted: G        W          6.6.69-yocto-standard+ #7
>> Hardware name: Raspberry Pi 4 Model B (DT)
>> Workqueue: events_unbound deferred_probe_work_func
>> Call trace:
>>   dump_backtrace+0x98/0xf8
>>   show_stack+0x20/0x38
>>   dump_stack_lvl+0x48/0x60
>>   print_report+0xf8/0x5d8
>>   kasan_report+0xb4/0x100
>>   __asan_load8+0x9c/0xc0
>>   __clk_release+0x80/0x160
>>   __clk_register+0x6dc/0xfb8
>>   devm_clk_hw_register+0x70/0x108
>>   bcm2835_register_clock+0x284/0x358
>>   bcm2835_clk_probe+0x2c4/0x438
>>   platform_probe+0x98/0x110
>>   really_probe+0x1e4/0x3e8
>>   __driver_probe_device+0xc0/0x1a0
>>   driver_probe_device+0x110/0x1e8
>>   __device_attach_driver+0xf0/0x1a8
>>   bus_for_each_drv+0xf8/0x178
>>   __device_attach+0x120/0x240
>>   device_initial_probe+0x1c/0x30
>>   bus_probe_device+0xdc/0xe8
>>   deferred_probe_work_func+0xe8/0x130
>>   process_one_work+0x2a4/0x698
>>   worker_thread+0x53c/0x708
>>   kthread+0x1b4/0x1c8
>>   ret_from_fork+0x10/0x20
>>
>> Allocated by task 27:
>>   kasan_save_stack+0x3c/0x68
>>   kasan_set_track+0x2c/0x40
>>   kasan_save_alloc_info+0x24/0x38
>>   __kasan_kmalloc+0xd4/0xd8
>>   __kmalloc+0x74/0x238
>>   __clk_register+0x718/0xfb8
>>   devm_clk_hw_register+0x70/0x108
>>   bcm2835_register_clock+0x284/0x358
>>   bcm2835_clk_probe+0x2c4/0x438
>>   platform_probe+0x98/0x110
>>   really_probe+0x1e4/0x3e8
>>   __driver_probe_device+0xc0/0x1a0
>>   driver_probe_device+0x110/0x1e8
>>   __device_attach_driver+0xf0/0x1a8
>>   bus_for_each_drv+0xf8/0x178
>>   __device_attach+0x120/0x240
>>   device_initial_probe+0x1c/0x30
>>   bus_probe_device+0xdc/0xe8
>>   deferred_probe_work_func+0xe8/0x130
>>   process_one_work+0x2a4/0x698
>>   worker_thread+0x53c/0x708
>>   kthread+0x1b4/0x1c8
>>   ret_from_fork+0x10/0x20
>>
>> Freed by task 27:
>>   kasan_save_stack+0x3c/0x68
>>   kasan_set_track+0x2c/0x40
>>   kasan_save_free_info+0x38/0x60
>>   __kasan_slab_free+0x100/0x170
>>   slab_free_freelist_hook+0xcc/0x218
>>   __kmem_cache_free+0x158/0x210
>>   kfree+0x88/0x140
>>   __clk_register+0x9d0/0xfb8
>>   devm_clk_hw_register+0x70/0x108
>>   bcm2835_register_clock+0x284/0x358
>>   bcm2835_clk_probe+0x2c4/0x438
>>   platform_probe+0x98/0x110
>>   really_probe+0x1e4/0x3e8
>>   __driver_probe_device+0xc0/0x1a0
>>   driver_probe_device+0x110/0x1e8
>>   __device_attach_driver+0xf0/0x1a8
>>   bus_for_each_drv+0xf8/0x178
>>   __device_attach+0x120/0x240
>>   device_initial_probe+0x1c/0x30
>>   bus_probe_device+0xdc/0xe8
>>   deferred_probe_work_func+0xe8/0x130
>>   process_one_work+0x2a4/0x698
>>   worker_thread+0x53c/0x708
>>   kthread+0x1b4/0x1c8
>>   ret_from_fork+0x10/0x20
>>
>> The buggy address belongs to the object at ffffff8043fd0800
>>   which belongs to the cache kmalloc-512 of size 512
>> The buggy address is located 384 bytes inside of
>>   freed 512-byte region [ffffff8043fd0800, ffffff8043fd0a00)
>>
>> The buggy address belongs to the physical page:
>> page:fffffffe010ff400 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffffff8043fd0e00 pfn:0x43fd0
>> head:fffffffe010ff400 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>> flags: 0x4000000000000840(slab|head|zone=1)
>> page_type: 0xffffffff()
>> raw: 4000000000000840 ffffff8040002f40 ffffff8040000a50 ffffff8040000a50
>> raw: ffffff8043fd0e00 0000000000150002 00000001ffffffff 0000000000000000
>> page dumped because: kasan: bad access detected
>>
>> Memory state around the buggy address:
>>   ffffff8043fd0880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>   ffffff8043fd0900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>> ffffff8043fd0980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>                     ^
>>   ffffff8043fd0a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>   ffffff8043fd0a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> ==================================================================
>>
>> Fixes: 9d05ae531c2c ("clk: Initialize struct clk_core kref earlier")
>> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> Is that the correct Fixes tag? What do you think about this instead?
>
> Fixes: fc0c209c147f ("clk: Allow parents to be specified without string names")
>
> Otherwise, the patch itself looks good to me.
>
> Brian
>


