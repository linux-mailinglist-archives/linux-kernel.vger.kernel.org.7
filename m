Return-Path: <linux-kernel+bounces-801095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1616B43FC8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DC237BCC99
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78523054CF;
	Thu,  4 Sep 2025 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="TCcrbOAU"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2101.outbound.protection.outlook.com [40.107.102.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F463043DC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756997918; cv=fail; b=fQqs0SQJTl5KSZAnvp+L7F77Dh5lvnAYVFI9ZxQObmPZwHlcmPHByvrcX9ARkocjD+8C6ws/s5Id90pAbbQVN+L9LCaWrEUMiw9+XMy2dty8GgcjFayYnursB0qllQ+2BOcTWA0cpRke3gzDUOILBJKSrWYDVUm/V/k+2leFblg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756997918; c=relaxed/simple;
	bh=tqgjZ22jTrfsfqaQO8IYgp+yGRrpe87fhedPLi57Yx0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z6mZ+jE3FhFpTJw5sqs24TdtuK/MzgTCAXtY4y/M5vl7VKCPyxspWyPrqIWXQO6n4ggPp8LfbE/lCqm5tL6Sc9ohs4m9vIP2jXD3m66gWhYZU8tNWzTAS8+QOXp5ngw/dckJGp8Gkat/bou373NoEKMwcIqcBoUmkp+Pf6h6+js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=TCcrbOAU; arc=fail smtp.client-ip=40.107.102.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d727UEhpfLt8rT+BmOzC5fR8CZxQqcbvtGtirphdHHdHB3E9T2aHSIxxrvEKyXOeCytjXbToXEXcpOJRBfbqs3cUxLU1KKPIwbIyY8xf5Ec+botgSDpMCLFADVXyK7dfJiqpunshSo/yhhApj+cWW7N4wNyAwTMo5AGW8nqsIg0XQkbBXzVALHHcp6dMnto8XLCND1Ma4oetxTzFyFfIalgzs9jFISAsEAQC5FD5dF8wpvEsmR4KMBCKAv3RFNBgGBPFo/WcRCKaGpi/wq99cjTrI2W4BSR0GyB2FQi0YF5jv/pBtLTS1iIMQWVgYJOG/SeT27c3+dj5RIXAruPfaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roADL/FSK0rVKIN+JulISkHgUM6GMDNOOK5VTdUubBk=;
 b=QI5ZqgbRYYFOsOHt5eJMtBXVKzeuL2yoa/UX6Pb2w2DUmorDgWyJWtcns6jvhmTXXILrdHY6JN4i9428YvFgZTEg3/PZpaeC3f1mux7odHi2XlaX6ma6w3z4C3h16ZwOFoNxV994SvzhScW5Z8cjJxaDDYzEWmbz26PBTjFn5XE9lrAl0pVx3aWzaAXECyJRtvHp+/7LDfvH0Dtaj08dE9tvrPMwGKqTEVbdSwDMFH3URiuLPx/xMUROfhmoAQ7tkeKcsTaNXUzr0a1gdt3fKmqVUL65N/8FS4wK4oYc1U/zo1+1X3dkFBO/1+B27/utOwTXebdSf8j7vnmMfOyuUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roADL/FSK0rVKIN+JulISkHgUM6GMDNOOK5VTdUubBk=;
 b=TCcrbOAUfAHZKowvQf8n5yIzZr9SjLXwaEvI7GfIpO3tY3S3vSthm97xd6CzU2oeU96hE23v7OvzxcS5QxvKNOvZRcRmUc+RowyEFWqUQJgWfnSeMCyrMV97sna+NuP6nCRsk7EDT0XuS8e3OBIaY+pLmxJJkWrXhLMy585qC/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB6683.prod.exchangelabs.com (2603:10b6:510:90::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Thu, 4 Sep 2025 14:58:28 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 14:58:28 +0000
Message-ID: <d2877287-d456-44d2-b8ee-be1f27b35a9b@os.amperecomputing.com>
Date: Thu, 4 Sep 2025 07:58:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/6] arm64: mm: Optimize linear_map_split_to_ptes()
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ard Biesheuvel <ardb@kernel.org>, Dev Jain <dev.jain@arm.com>,
 scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250829115250.2395585-1-ryan.roberts@arm.com>
 <20250829115250.2395585-7-ryan.roberts@arm.com>
 <9d666caf-a799-4229-86b5-3a22a60fa79f@os.amperecomputing.com>
 <2cf02021-10d2-46f6-b3e6-f5c55546ca9e@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <2cf02021-10d2-46f6-b3e6-f5c55546ca9e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR15CA0019.namprd15.prod.outlook.com
 (2603:10b6:930:14::31) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: 750555f7-1f83-4e12-8158-08ddebc38178
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVhUZ3hQZldSMm5vYUhxblR0dm5RQkJBOFR6d09OREs5OEswYytTWW9NUWcv?=
 =?utf-8?B?SG5yRDVoSTZ2UUZObUV4dzc1Nm9kenhpOHF0bEpMbGFPYmFtTEdWcE1wUEwy?=
 =?utf-8?B?YmJHMjdxeXNBOFgzY0xobWwweFQvRmxjQlBjZ29GMXRxUWlXMWF0WjBheGo3?=
 =?utf-8?B?YW9jeTlwUVozU0pzNFBHbWdZb0pIUVNGajloVWI2eWJxazNudmdsUlBTT0ll?=
 =?utf-8?B?TWpPSndtZ1RIUmRGZEpaWFI2U2hSeGg5Wm92T0lDemFQYnZ6K2Z2MW5UdU9E?=
 =?utf-8?B?akZxcXdFcFV1OUc2L2E5OXBlQnBNZEpoSnBOcU1UOGFhQ0kxVmVLVVBoTzAz?=
 =?utf-8?B?U2lMQzRqSjd4Snh3NTB3alpwWFA0NnFXL241d1N1eXB5VGxNYk40RDRZMVdW?=
 =?utf-8?B?aWJzaFd2cDZ2UnR2RVhlMVN0SEc4VUk2TDBtaUhvajdmTVJnNzc0RDlPeFlt?=
 =?utf-8?B?L0V1RGtLcnVUc0EzeHlNaEh6bUIvWE4xRDFIUFlIUURlb1ZvZ2tLWm9WZnJF?=
 =?utf-8?B?VWVrT1p2VmlGQklPMDI4MTB2WFZkKzRoRWU0aFBWSy83SEtkTFI3NTFPQWlX?=
 =?utf-8?B?eFNqUGg2Y3lhaHpybkptdlhmTkF4MVliN1hxUnM2RFdKQlJCbFU5QnRQbW91?=
 =?utf-8?B?OGZZM0xvK0RRRTRpYSt0SkZlRnhGSnMxQ1JvYXo1YjNjZ1RwMmRoYWJiYWpp?=
 =?utf-8?B?M1J4R1FaV2VZSlFtQ0hhbEtvVTJmZ0dVVklBOC9SQU1abEM0ak41U1FvUnl5?=
 =?utf-8?B?K3ZLdktkZVc4eWNRblVMbjFVUjNzUlNJNjJtaXV6R0xtRnhwSFNaZFpxTVhO?=
 =?utf-8?B?TFM5UzVVWmdISFphMDBRVXJSd2d4UU5zMGxXdEJ3cERoQ21MR3RPTlBxeGxt?=
 =?utf-8?B?V2gzNzdFMERnWWV4VGx0TGhQWStwOUhqVHdqNG8wSDFBR2dBSmJBRUNDanZC?=
 =?utf-8?B?ZmY0Qm1TSXF1bGQ4ekRKTU9LTzBmWUZ0VU1UUndyT3JkTi9FR0RaeDZ1NURW?=
 =?utf-8?B?ZzRiblNUMENlZU5adFlMM3JrMGZEVEdHSFZSQ2htbzRUUTJLMldzeHhDQmJy?=
 =?utf-8?B?dUhCMzhDZFQzWGxYS1lkVHgwUG9OUWx0TElUejlKSzVFS1lOdkJhSDV0NFdr?=
 =?utf-8?B?SjJVeG5Oa2xOYVVsRUJYbkxaRGNwRTV2Z2RRRzRGNzg5YXhzVGExeXUwL3da?=
 =?utf-8?B?cXBCbG1idUZKRDJweXlOVXU3SDhDRk8rZ1pNYmlVTCtmdU5hYTZ3TGR1NExP?=
 =?utf-8?B?MXVheGtqUnpvRHZjbEZKLzlrYmE2WmhVMzFLSndJTzIxcE5obzNnY09mY3gy?=
 =?utf-8?B?Z3FJbitSZ2V5NUNhTk5odlAxZG1MZ0oxTUM0aHhIM2JNTk41c3lOei9MWFBQ?=
 =?utf-8?B?NlFEbnl0ekJMQkRxajdkY1F0b1lZdTJYQlF0TGxtY1h4RnEydHNxQlJaWU5w?=
 =?utf-8?B?SVVuajNYQU10MkYyNTB3ZFpSTlJaS3krbW01WWRSOXBrV2t0TTY1SXdxTUF5?=
 =?utf-8?B?S0pwaHM2dHZ3bExRalFTT3JiZ1BFbUNQR3NNTEdrRCsyU25RQldoREhta1N0?=
 =?utf-8?B?SXQ4MEsxVWdRQnNpUlI4UUVIR2srK1ROTlFOTUZiakgraXlZYnF6WCsxT25r?=
 =?utf-8?B?LzNsS1JEbFhRMU9kUFN5RGRIT2N0S3VWWkxYUE5uMmRabldmazBhaC9mY2F2?=
 =?utf-8?B?d2FIVFpBaWJqK2dySE0zdlRwWGMyMVl5KzVLendZbytjdWhvZU1NTTJIcW0z?=
 =?utf-8?B?d3VURDdmN3NITUI1WDdRNEI3ZkFjemFDWHdzazlqOGEvYWI0aFFXVVFpS3VC?=
 =?utf-8?B?QW9QRVR5ZGYzYWhqNEV4S0svSGtnK25LNWUzc2YzZlM1SDAxSWtObXBlWG11?=
 =?utf-8?B?WVRHYVNHRnRHNU5JQWVvQTV0bEFaWktiOGVUNlZRMlpvUFZqQVJhR2xrRWdR?=
 =?utf-8?B?dVh5R21KeVZ5aVpLdWNsVCtBejB2eC8zUWNqb3dBQXBHQThEVllkMnB1V0pR?=
 =?utf-8?B?VSttRzJCZ1JnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWxjY25ZMGQ1VzlJMmpQTkQ2TGtuSGozY21kelJEeTRuM21QTnRqdDNYSG9I?=
 =?utf-8?B?bWhweG5HNzZqSnMyRHpGd1hBU1BoM3BzeEVZcUtRci9GRUdIT1lXMlMrR1lE?=
 =?utf-8?B?UlExY250dDhJb1hZcG5jclBCMFdTQ3p3dU5hQmFWWjF2OHRzSXMwajN3QXUv?=
 =?utf-8?B?Q2dnTkNwaUduVzBPeFRMSVpFZTJsamtyU1lWanJhM05XWE1Yb3I2Tld4U20v?=
 =?utf-8?B?RnpoWWUydk03QUI3WjIrNGpYY2Z3dS9MblQ5NlgzREVZVFlZT1M5c3dZMnVt?=
 =?utf-8?B?RkhCdlByQnRKL1FYUWZVYjZvbFVWTFdybTJROERGUng5OGN3bzJvaklpaFgx?=
 =?utf-8?B?Y2I2Tng3bjVwZ1pYQnVxWVYyRU5zUXllQnZESmhJN3VON3dvTHpwUVNGbTJu?=
 =?utf-8?B?Vy9GUDVMM09WUUNSS3F2MWx6bnBlQ08xNmlXdm9NK2tCN0Z1RGljdDd2QUp1?=
 =?utf-8?B?MllXbWliZUUxWFcraThYdkJnSlVsZ0N5RXV3RGJwTHg5c01lVEpuMEw5MTc2?=
 =?utf-8?B?aWpwamZoeTh2U1VxZmovZjAra2xRa2VyOHRIWUR2RFIwb1BJZUgxWTNNbUNG?=
 =?utf-8?B?ekJXK0thTzFBbnZ4U3FWWnZKL1U0NWV4bUdKMkxOSU55Tm1aYnV2dHhUYmYz?=
 =?utf-8?B?emREOCtnVFR6czE4YUVSS0crVHIyUnFwNjVZa0tmVEY0Z3dHL0pjdW9SMHE2?=
 =?utf-8?B?NTFxYm5HUi81NzJiaWFBSmRxZWNMM1FzSTkxTWZDcStjWWtRTWVFRWdZdG90?=
 =?utf-8?B?SEhlei8yQzk2T2pVdVpNenNlTENneERzVnhGQXpYTlR0K0UvTDhHYU9Za0t1?=
 =?utf-8?B?T3JndGhXZlFvdmx3WUdMRHhWQ3gyakFkNGVjOTBZUmdPQ0czNGxqbGlVblhU?=
 =?utf-8?B?c0g0Nm1tYm82Wm84cDVvc0lkQ1VadVRIaC9QMjdIWDBRMnZKeHpUc2RFb052?=
 =?utf-8?B?SXhTcjFESWMzSkRJaEJDN0tQS3VLcU1nZy9JUlJ4QlFNRklEUER2RkFyakJ1?=
 =?utf-8?B?eVdaMlkwdWpJUlE3eEtjbEkyclRRS05nWnNRK2tJbWFXaTN4MjlLU08ybXJh?=
 =?utf-8?B?a2JIVElGeEQrVUdaOHFVcFV5MFlRTmtrKzBzUHdIeXdCSFE5ejJIWHZHa0p4?=
 =?utf-8?B?TWZDeHdVdG5LSGxFaDl6aXo1N2VrUmtKQnRuUVpSeUtWOUtSS203Z2pDc29C?=
 =?utf-8?B?SG9yemxFWnpCaDZpQmlPOFMzNFFEVW5YcXdQR0dqaTJDK1pRbE1mQmtmSkIx?=
 =?utf-8?B?Q2NrUk9SeUVacGY2SGJXWE9YZitZSGdGRER2dk5hTEcyangwaEE1VXMrSUdB?=
 =?utf-8?B?aTI5cFBsSEIrZjVTRzl6WVNhZDNLV1NYOFAyanloMnlHbVdlSzI2elJydWhT?=
 =?utf-8?B?c3lzSC9ETnFyTElzSXVBNWhjU1RQQS8xRU9GYXMvRU9pQ1dBckFPbFpscVJJ?=
 =?utf-8?B?cXRGM25VNDNGTkNZWFJQSjQrWkJyMXUrK2hCUVJTRjJyYmR5QXE4M1pObkNp?=
 =?utf-8?B?V09oV1VTR2s0bVl5aytWZjNHV0RUdjV2bkk1WlR4a3FEenI0YW13dmF2MUVP?=
 =?utf-8?B?bGdvZ1BrYXRMNE5jalhRVVVpSEN2aDRqczJESkljMkR5WVZoT2w5eXEwRkhp?=
 =?utf-8?B?R0JncGo4OGRtcDF3M1gzUUMya0FSSEtJbXJ3eEFBak04cHZ5NXR3TEw3bGpi?=
 =?utf-8?B?S3ROL3paWHovQWhnMkwxOWRLWUtCMnFzY3pTWWMvK2JraE93ZjdWNy9hMnJN?=
 =?utf-8?B?WUpwQ0dEODkwS0RlODluRVg1NDNJRUY4SEcyU0VPK1pPckdxZ0FhRkU3SlNC?=
 =?utf-8?B?K1grZ0lDV1JvMXpCM3k2RjN3N0d4YXdEbGEwZkpCMjdmeHlxVXoxcitIRGxw?=
 =?utf-8?B?TStkTEJxNHZqVGJ3aTYyVlBBenNWWlVHUGQ3R0ppb0RZY1dtWk95bGRPZ256?=
 =?utf-8?B?WDVTMG1uUEVUOFdzM3dxMndCa3d3TTZ2R3ZRUDFlbTZsdFlrMnFmTnBybC9W?=
 =?utf-8?B?TGR6RmljYkdPTTZ1bm9XYkdjSHVPblFsZ1NrL28ySjAvVERUMy9NWkM3Y28r?=
 =?utf-8?B?L3VxRUl3MHlJRy9QbEJxSXFTSEJ4OUJqSG10bUZyWExRL2lFbE5iTWE0WG0x?=
 =?utf-8?B?UWhTYjFrenorRm1XeS8zNCs4S1ZrQXBLWnltR1RydHVWL2tzNEJjZU1aS1Fr?=
 =?utf-8?Q?RIpAXMZiJwmDqvcXXSmqKLQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750555f7-1f83-4e12-8158-08ddebc38178
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:58:28.2417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syF6ZgQ0UOGUqI7HZgu5K++5UPz4FIDOYC/bPC0Py7CvvwX5y/ZbyVPemYslkZa4k9kcf+4/T8Cm2xbQc5emqkamHHOeuHFg/ATvc7UVvHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6683



On 9/4/25 4:10 AM, Ryan Roberts wrote:
> On 29/08/2025 23:27, Yang Shi wrote:
>>
>> On 8/29/25 4:52 AM, Ryan Roberts wrote:
>>> When splitting kernel leaf mappings, either via
>>> split_kernel_leaf_mapping_locked() or linear_map_split_to_ptes(),
>>> previously a leaf mapping was always split to the next size down. e.g.
>>> pud -> contpmd -> pmd -> contpte -> pte. But for
>>> linear_map_split_to_ptes() we can avoid the contpmd and contpte states
>>> because we know we want to split all the way down to ptes.
>>>
>>> This avoids visiting all the ptes in a table if it was created by
>>> splitting a pmd, which is noticible on systems with a lot of memory.
>> Similar to patch #4, this patch should be squashed into patch #5 IMHO.
> That's fine by me. I was just trying to make the review easier by splitting
> non-essential stuff out. Let's squash for next version.

Understood.

Thanks,
Yang

>
>> Thanks,
>> Yang
>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>    arch/arm64/mm/mmu.c | 26 ++++++++++++++++++--------
>>>    1 file changed, 18 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index 6bd0b065bd97..8e45cd08bf3a 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -550,7 +550,7 @@ static void split_contpte(pte_t *ptep)
>>>            __set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
>>>    }
>>>    -static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp)
>>> +static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
>>>    {
>>>        pmdval_t tableprot = PMD_TYPE_TABLE | PMD_TABLE_UXN | PMD_TABLE_AF;
>>>        unsigned long pfn = pmd_pfn(pmd);
>>> @@ -568,7 +568,9 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp)
>>>            tableprot |= PMD_TABLE_PXN;
>>>          prot = __pgprot((pgprot_val(prot) & ~PTE_TYPE_MASK) | PTE_TYPE_PAGE);
>>> -    prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>>> +    prot = __pgprot(pgprot_val(prot) & ~PTE_CONT);
>>> +    if (to_cont)
>>> +        prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>>>          for (i = 0; i < PTRS_PER_PTE; i++, ptep++, pfn++)
>>>            __set_pte(ptep, pfn_pte(pfn, prot));
>>> @@ -592,7 +594,7 @@ static void split_contpmd(pmd_t *pmdp)
>>>            set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
>>>    }
>>>    -static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp)
>>> +static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
>>>    {
>>>        pudval_t tableprot = PUD_TYPE_TABLE | PUD_TABLE_UXN | PUD_TABLE_AF;
>>>        unsigned int step = PMD_SIZE >> PAGE_SHIFT;
>>> @@ -611,7 +613,9 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp)
>>>            tableprot |= PUD_TABLE_PXN;
>>>          prot = __pgprot((pgprot_val(prot) & ~PMD_TYPE_MASK) | PMD_TYPE_SECT);
>>> -    prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>>> +    prot = __pgprot(pgprot_val(prot) & ~PTE_CONT);
>>> +    if (to_cont)
>>> +        prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>>>          for (i = 0; i < PTRS_PER_PMD; i++, pmdp++, pfn += step)
>>>            set_pmd(pmdp, pfn_pmd(pfn, prot));
>>> @@ -669,7 +673,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long
>>> addr)
>>>        if (!pud_present(pud))
>>>            goto out;
>>>        if (pud_leaf(pud)) {
>>> -        ret = split_pud(pudp, pud, GFP_PGTABLE_KERNEL);
>>> +        ret = split_pud(pudp, pud, GFP_PGTABLE_KERNEL, true);
>>>            if (ret)
>>>                goto out;
>>>        }
>>> @@ -694,7 +698,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long
>>> addr)
>>>             */
>>>            if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
>>>                goto out;
>>> -        ret = split_pmd(pmdp, pmd, GFP_PGTABLE_KERNEL);
>>> +        ret = split_pmd(pmdp, pmd, GFP_PGTABLE_KERNEL, true);
>>>            if (ret)
>>>                goto out;
>>>        }
>>> @@ -771,7 +775,7 @@ static int __init split_to_ptes_pud_entry(pud_t *pudp,
>>> unsigned long addr,
>>>        int ret = 0;
>>>          if (pud_leaf(pud))
>>> -        ret = split_pud(pudp, pud, GFP_ATOMIC);
>>> +        ret = split_pud(pudp, pud, GFP_ATOMIC, false);
>>>          return ret;
>>>    }
>>> @@ -786,7 +790,13 @@ static int __init split_to_ptes_pmd_entry(pmd_t *pmdp,
>>> unsigned long addr,
>>>        if (pmd_leaf(pmd)) {
>>>            if (pmd_cont(pmd))
>>>                split_contpmd(pmdp);
>>> -        ret = split_pmd(pmdp, pmd, GFP_ATOMIC);
>>> +        ret = split_pmd(pmdp, pmd, GFP_ATOMIC, false);
>>> +
>>> +        /*
>>> +         * We have split the pmd directly to ptes so there is no need to
>>> +         * visit each pte to check if they are contpte.
>>> +         */
>>> +        walk->action = ACTION_CONTINUE;
>>>        }
>>>          return ret;


