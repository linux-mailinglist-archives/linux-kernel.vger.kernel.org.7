Return-Path: <linux-kernel+bounces-743084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4126BB0FA51
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5945DAC292F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EF222257E;
	Wed, 23 Jul 2025 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="ir+UtnrG"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012069.outbound.protection.outlook.com [52.101.71.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B840F1FBEB9;
	Wed, 23 Jul 2025 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753295684; cv=fail; b=c/6E1pWrVWAHf+Uvx+qXrswm3JmcT2X+VgWbBtYS+PpMdTClfnO+kSquL51ALt1ZU9BTD8vZDT1BbYW1bjwQU56RapbJnD62cSEt2IeI44ESi+ufj6SZe9HoiBkPTNFJjJr4XVRJjxuOVTLXmUjnEaYOMXIE+/IvPm+huf4yAq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753295684; c=relaxed/simple;
	bh=BvWGi25UCiguLez2LjSrP31KrU0JSzYRbU6iYn6UMBw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ec9LCYkHw3sAjdvXXozvOuAO1tjKHm+xBVn7Lhkxt4i6qANikx6LjclrwIrl1JCkZyPyX3jBXlN8zesEVk8ztO9KDhrVX5coWDNlU6kDZuG4RRsDSVgWUbvQfDWBJItBhcjImqyeJhq+6zfYUhZAXnJfBLSMUDqIiPr+6i56sOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=ir+UtnrG; arc=fail smtp.client-ip=52.101.71.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmpwsgVJcZHPBKbq4ONWKitxnaujWDLWhrmTTaJVVZsYEVH5c8DBfy6cKEHxCGb6BbdOljhiJOsmy/IvpohJMQ7naBxzhRKoK8lBiLD175GZIO9Y1DVVm1Jf34bm6yk5vlgjiv03LAHesH32l+1QZ8tGSjdh6rmJWhkMfqKXfmcB3r+klN5LWYkYapReCZrRg8ytzfvo16Z20VlLZkHyqZeJvatrtpVrhNMOHq+Ac8Ht1fCGi9v4L/sbA8JJRiWmb6kdIs+WyB5MLd377mtKpN/O6myzOAhUFUiJasFwTp9LwG8GV0+VIzdxBB9vQq7GqQ2Bbfxf0m9FbT3yAMActw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvWGi25UCiguLez2LjSrP31KrU0JSzYRbU6iYn6UMBw=;
 b=otLp6crzic1/1DElrzeOElg2PJ0WAY8nWAi3x89G+3mvdi047U46KJuQlTtDEe0GpNlIdOXcxgF2m0sqlhdZbOKhdVZ+uDz84lqvEgnjotkDhilgsCjQWyaAGrupa6ckh9vIKlqWjY+4ZX7KY3ysSmbmwi9IJ9HgdchfvT6dBmd8D6gsEbhK5SXjhGjaqHdIGuNIZ/NVuXbgFie1pRC9spt2I8+GOMfjDJFKXrBb8fQTULljptRGlAKyTwmThLPv3XSjoYHQ1VJh9NUFAnE5jsEyU0KK2B9I42oOXv94663b9eERTuEjszSz2ydrgENi5lZ3BMyO37w0wAVqNr3yTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvWGi25UCiguLez2LjSrP31KrU0JSzYRbU6iYn6UMBw=;
 b=ir+UtnrGUsVcE6PBXBfLqQRgiG9nZ+4k/l040fDWhFBno4AMgxfmNF4aLJ2tla+JoPUjyJzrZOPKDtDhYJ2nMeWrgYY1CdAdX/yQfBLbir754/6rHJb7mbSZJzSkXiukMx/EG1ERgrWaTOIq4onnuwbPwQkPzoZi82SLs8t1XHPdPeraUe8f/pPIlj+5qr2GlmBvvBlFWDnD6lebwEubSVu7DVRHm6v3j0BmuIGIWRY0pSzTb20xYQZn8qosrhXFabtlIVHpZAXELAdMpUiYIpGPVKcR9p5tLednNkk/5X+FX23csNJmkailJbGCRpwMw9C8qP2i/JXkZ++1GhJhWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAXPR07MB8771.eurprd07.prod.outlook.com (2603:10a6:102:246::20)
 by PR3PR07MB6794.eurprd07.prod.outlook.com (2603:10a6:102:5d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 18:34:39 +0000
Received: from PAXPR07MB8771.eurprd07.prod.outlook.com
 ([fe80::e125:c4ef:b872:5c60]) by PAXPR07MB8771.eurprd07.prod.outlook.com
 ([fe80::e125:c4ef:b872:5c60%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 18:34:39 +0000
Message-ID: <b0c3d2e1-9dc5-4baa-ab90-bb8e130c3578@nokia.com>
Date: Wed, 23 Jul 2025 20:34:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] genirq: add support for warning on long-running IRQ
 handlers
To: Jiri Slaby <jirislaby@kernel.org>, tglx@linutronix.de, corbet@lwn.net
Cc: akpm@linux-foundation.org, paulmck@kernel.org, rostedt@goodmis.org,
 Neeraj.Upadhyay@amd.com, david@redhat.com, bp@alien8.de, arnd@arndb.de,
 fvdl@google.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 peterz@infradead.org
References: <20250714084209.918-1-wladislav.wiebe@nokia.com>
 <adbc919f-772b-46f1-99fb-d05cf0989763@kernel.org>
From: Wladislav Wiebe <wladislav.wiebe@nokia.com>
In-Reply-To: <adbc919f-772b-46f1-99fb-d05cf0989763@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::16) To PAXPR07MB8771.eurprd07.prod.outlook.com
 (2603:10a6:102:246::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR07MB8771:EE_|PR3PR07MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c60031d-a946-49cf-5863-08ddca1794e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjBFODcxSWhCM3BZVW01VDNCcFJ3M3A2UzFqaWxWcnBhQ3J6TnNvU2ZEQ3dl?=
 =?utf-8?B?RTd0ZW1lQXZwVEw4bzlnTE1WYXJ2Qm9aQkUyS0NzdjIrT1JhZ0RqVGFKLzFL?=
 =?utf-8?B?SFpldzlHVXRzWDRRMW9RWWZsMlgyeTd1WGtGOHdFeWdsOTZYVTdmRGZoRVFR?=
 =?utf-8?B?VW1RaVFYbjVMUzA4b05CY2FReEx4eG5zd0VTdzc5MlB6OTBONTd0dkduUXJF?=
 =?utf-8?B?OEtMcjZBVk1VUjIraU9QemlOSmxwOCtiSlNGOWs4WDE4aFVDYXhYcVdjN3FI?=
 =?utf-8?B?WmZmNVZpbCtMTTVic1J0bDUzZEk0UzdsUU0vYVJVbEoxVFJseGJhRmdFL05u?=
 =?utf-8?B?aHhpQXlGa0FLaEJ1YnRWOS9nUHRvZ1lBYTJCTjliQUxkcUhvR3lsMlBxc2FD?=
 =?utf-8?B?aUhQcC9FVUtCVDFvQXRlZ2psR2xzZTlFM010ZHFGcTVDRnpaWVNsc0pEUS80?=
 =?utf-8?B?amRPNDFzcjNVWURYNCttUUJUMXpOSmZVUTdUbHhZRTVrS2FzVng1WklrelNo?=
 =?utf-8?B?WTBmU3BCSVNLdUJJYnJqWHlwVFV5cU1BZ0x3aVh6aldFUVFMUmFwMTlLc1dU?=
 =?utf-8?B?eXNEVUJlZU5VVG1RdmNyODdFY0pnckdPc08vd1FsakgxakU2cmFqVHdCRWhI?=
 =?utf-8?B?TnNyWEFtU1ZsUTFFeDcrWFpjVlpRYW5aSmdDRTQyU1ZEMWxmMEl2Y1NUczM4?=
 =?utf-8?B?dUhwaUdPM3JZY2Z1bWhjSk1ob0Y1TG9oU09paHllZVJ5emhXVzZWSGhLMXpG?=
 =?utf-8?B?bThpUE9HSXBaT0NYZ0xVMDZaaGZsSCtXelFhcFZlRnR1VmExMkhCRU16Z3pl?=
 =?utf-8?B?bld1cTBOempyVkU5QmgrY1p2cVVySVFLd0VtM3ZkVXBrV3BSZ3VyZllQMm8r?=
 =?utf-8?B?dnJCUm9QdVYyRElVTkNET0JRZlFyM2E3THlUcm5oUzJIb09rcDQ0MFRiY1F0?=
 =?utf-8?B?bWg4VXpMZmtGU3piZ1BtdDRJOWJhMXgrSEk1RWlWZ1Exa2ZRNTc5aEUzZFJ3?=
 =?utf-8?B?NlJXdjZ0cHVTa0pHT0d0RmpXL3BWT2lzMSt1bGV2TWNXYmk3TFQyK3g5SEh5?=
 =?utf-8?B?RlBYNFFDQzJUVGV3Uy9EaklWd2tqOHZvd0djbThPM1JkUkNjbE9hOXg1N25r?=
 =?utf-8?B?OGhNNFV6R1c5Yzk2cGJwTFRIWWI3dWVOS3BhOXV5WWkrUi9CaS9XV0hLK09B?=
 =?utf-8?B?V09SN0RMUmZYS09TeG02ZlgyUk9IakFMdWNxM3I1ajdaWkg1bDBnclZIZm9r?=
 =?utf-8?B?Y1RxcCs4L3BHSzhhcFJ5amo3eWtQUVJlZkttMm9ybjNwTlp4UHUxeThtdTlK?=
 =?utf-8?B?VGdjYWphSVpRaS9wUHRlbVdaaTZteFRVU1VwTkRRaXBFUkVxVm9FU1RFL3Jj?=
 =?utf-8?B?L2gyWjNBeDRmSjRJTnlURFcwV0tiUVJFdDZybHlRR0poY2I5VlBhcHphM2ZX?=
 =?utf-8?B?akM0eUIydVJqZnBsSXpQVCsrZWt5WXV4cXcyODEvaEZpQnprZ3VTQmppTDBs?=
 =?utf-8?B?bm53N0pRbE1rdElNMHRseENRNU9rdzF0RExpOUNxN1N1V3ZMcWtKR1F5ZnVy?=
 =?utf-8?B?QUQzamJrdGZVSDU3WDVoSXFwbWtJZm9YcWIwbGtZc0o3MUlDaitCOTAvUmVJ?=
 =?utf-8?B?SW1wWlpNdFN5M0tib3ZkblFhQ1B3TXI4N2w4a01OcXYrZXRYb3pPd0xIdURX?=
 =?utf-8?B?ZlZIWW9Zc09VMG1qVlRpUW9OVFYwdEJIQXZnbG9PR0ZpckdVSDFLM3NGV096?=
 =?utf-8?B?dG9pTUNvaWpLckFoUjlOdVB0NmgvQUVTRmhaZmFUN2wxTlF3R3NnMzVHZkdI?=
 =?utf-8?B?SVZKZStkZmdXWURRL3FZT21WclVHeC93N2wrRkw3TkVJa3BZaWFoeGxLVUYx?=
 =?utf-8?B?VHU3V09BU253S3llemV0aG9adkkyR3NQYmZEanVtTTh5RHB1VnV0d3kxZ1Fn?=
 =?utf-8?Q?E8LJ0FxA0/Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB8771.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXpzNzJGTEEzU0x4cGZ4dVo2RElGL0hFQlVPN2MvTFBEaEJOZFZRcElmdzlB?=
 =?utf-8?B?Yk00c3ZONjQxU1lSVXJ0ei80NXRJWHVJMk5sZ3JDRXhKRlByanowYy9yR0wv?=
 =?utf-8?B?VklCV2Zmbis0L3l4ajZOVUp0bjNITEZQcnBoQ0VvMnIzaFJOR0VIc2tRc2Ju?=
 =?utf-8?B?djR0Y0lTbWFhd3AyL29rOEdwTTFEU3Z6L21jUE44L0ZPRUM2UHVDeXZaVDgr?=
 =?utf-8?B?RkhpWEIxbnpjOHArRUlaRXVBVUdOSVhZWkU4ZHkxSndsaEROV2dSbjNuOVho?=
 =?utf-8?B?TndOeDg4VG0rMU4rQ0ZsRHBkbmpnYnppMjErOWYvampVUmEwSThOYWZ3TjA2?=
 =?utf-8?B?b3BMbjB3ZlViYXp1TVJwQi8vMmMzVFFIVjBlQjR0eDBEZTJ2Y2lNekFGRXVm?=
 =?utf-8?B?VWNSZVRkZGFJTUREMmVOWTN1aG9aSGF1WGpTUEUwSk5XWVVIT29oSFBDdm1U?=
 =?utf-8?B?L3duQks0UGh3cExiYVdDaUNPMlpoakZIcEpCMEdvaGJrNC9aaGlEQjBpUEUv?=
 =?utf-8?B?cU5Jek5FUmRnRFJDRnFCL2YyTzY1a1g0cXFKTjk3UDBTd3JQQlRPVkx5WUs2?=
 =?utf-8?B?OWhVNGRIV2g3SFJMRU5vWHpucGFFUWlRN3h4YjRMWk8xQVZ4L08yUVd6R3dv?=
 =?utf-8?B?QXRQaytjKytYUW13OE1pd0xKenJ3TFdsOVJha1hkVXBFVUdjTU9Nclphazhp?=
 =?utf-8?B?TUJqaGtaWVk2RWJPbUgzMjR5TTdhR0l2alpUMjViOU91V2R2d1BxMVR0YWN0?=
 =?utf-8?B?L1dmL1RaN0wzN3ZCcWlLZGlMek1PbmJXbFRxMVY3SDJHcGhoSlY0YVBjbWhv?=
 =?utf-8?B?ejY5ZVZQNEZMS2tQSUk0WXl5L1VSam43a1h5RGxzM3hyLzR1c1EyU1pET0ZG?=
 =?utf-8?B?dWkwSHZUeFdTSjlzZ0NRMmJpMThSYktFcE1xbmpwZlRQVm10RTEyYlZlNWRk?=
 =?utf-8?B?VURxem04T0FwVVc1bEN5bjFjVlJmWG1IR05TY3ZxWjVDeWM2RXVuUGF5ZTVJ?=
 =?utf-8?B?VmtQRWJWVTdESjBzSlVlUWFKZC85SzN5N0Nxb0EwbGdHc0pRZFM4YWdteTY4?=
 =?utf-8?B?UzFBd1RLUjFyaERobDBTaE5USWNidnpWcWZ5anlrRENUWFo1WHZZWUd1NG54?=
 =?utf-8?B?S25EQlVjVzMxbWdxVFc0bVphVm03cktIT1JUVTBnUmEveE9WZmtEZHFvSCtZ?=
 =?utf-8?B?dDNJQi9JUWdvVjUrYUVtU09xK1AzeW52RytBRTc5ZE15aGZUVWN6VVI0YmNM?=
 =?utf-8?B?aTUwdHpRb0xHaUxDbWYvd0JNT1VmNUZXRnJsd1BYY3ZMMElIajNKMUNEdGZE?=
 =?utf-8?B?aFgwT0V3RVVicTJRaE1PZGNzaXUyMC9BT2FYcVVqait4UGpwVnFpK0oxbWJp?=
 =?utf-8?B?RXBHdmlISUdUZ3hZN2ZzYnNSd2cyMTVQWG5FdmtPcVJiQWZ3T01LZmJEYlhj?=
 =?utf-8?B?SXR0K2RiUHY0bVlKb0RJQkRxVlRWbzRkNXhxTi9XYWVtMnlONndwSW5Fd01X?=
 =?utf-8?B?MlZRdE14blhtZEJtbEVOUEpVU3pXWCtsRG0wYk5teEVzcnBkb3l2clFpMmhT?=
 =?utf-8?B?Z0J6TFlJdFkwRUhQQmFaOW51Wm9mMURvbEhGSk9FS0hHRlRMblJoZVVZTFhv?=
 =?utf-8?B?NXRJT3VtNDVRUVRDRk84QVgrNFcyS2xsZHl0Umo3TWFwSlJETGpBY1l6NjR1?=
 =?utf-8?B?MzR5RjdiV04wbWdCZWxxSi94cmJINDdWUWFsWXI0VGNXMFdYQWFMVUpKYnNl?=
 =?utf-8?B?djJvdVFBL2FmZi8wakVqdXRjUWZJTnpCNEF4UXh6M1pvbjJEeXppWTJ0Y2lE?=
 =?utf-8?B?VDhtTmFzVXpDN2pyL1ZQOFlLMWFhc0pvN3ByZHFsNFpkQm1OUmdQWWRaSVRx?=
 =?utf-8?B?M2hNZjh4OUpXYndseEdDbDlBenRhTjJabEtqOHAvVm9nL3RZSFJ4ejFWMWFP?=
 =?utf-8?B?UWdxdUNtZDdXRkpXd085MXdsRklKUE9CYnVTS0JVVzBaR1FrQThWRlVnZkhp?=
 =?utf-8?B?N0VOaXAyN0Q3allxT0ZEMjVyOVpaUGVlcFl6RDI5anBlL014ZjlyWE5SMFNS?=
 =?utf-8?B?eUxBUVAwejNFR21SZjdtYmlxZWovRFFpUTlIRllja2NCTnBQVGNwVDFKd2VQ?=
 =?utf-8?B?eGFaTzBKeVdka1lieG14NVRJYUhmNTVETW1lTnJQTExqRlYyTjhSZk5MUTBt?=
 =?utf-8?B?TWc9PQ==?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c60031d-a946-49cf-5863-08ddca1794e4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB8771.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 18:34:39.0609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJfsKQL6UolicZOmqxNIwKBDxntP6uy83btNoNoSbkRwIXYqcs29M6slasFe9/BC95SyiSpOfQgirFCxZ/cWSeflJ5U81P8COmgymzm4pkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6794

On 22/07/2025 10:21, Jiri Slaby wrote:

>
> On 14. 07. 25, 10:41, Wladislav Wiebe wrote:
>> This patch adds a mechanism to detect and warn about long-running IRQ
>> handlers exceeding a user-defined duration threshold in microseconds.
>>
>> The feature is enabled via the kernel boot parameter:
>> "irqhandler.duration_warn_us=<threshold_in_us>"
>>
>> For example, passing irqhandler.duration_warn_us=1000 will warn if an
>> IRQ handler takes more than 1000 microseconds.
>>
>> Implementation uses local_clock() to measure the execution duration of
>> IRQ handlers. When the threshold is exceeded, a ratelimited warning is
>> printed:
>>
>> "[CPU14] long duration on IRQ[159:bad_irq_handler [long_irq]], took: 1330 us"
>>
>> Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
>> ---
>> V1 -> V2: refactor to use local_clock() instead of jiffies and replace
>>         Kconfig knobs by a new command-line parameter.
>> V1 link:  https://lore.kernel.org/lkml/20250630124721.18232-1-wladislav.wiebe@nokia.com/
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  5 ++
>>   kernel/irq/handle.c                           | 48 ++++++++++++++++++-
>>   2 files changed, 52 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index f1f2c0874da9..fa89f21ea1e6 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -2543,6 +2543,11 @@
>>                       for it. Intended to get systems with badly broken
>>                       firmware running.
>>
>> +     irqhandler.duration_warn_us= [KNL,EARLY]
>> +                     Warn if an IRQ handler exceeds the specified duration
>> +                     threshold in microseconds. Useful for identifying
>> +                     long-running IRQs in the system.
>> +
>>       irqpoll         [HW]
>>                       When an interrupt is not handled search all handlers
>>                       for it. Also check all handlers each timer
>> diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
>> index 9489f93b3db3..eab8fdfab8d8 100644
>> --- a/kernel/irq/handle.c
>> +++ b/kernel/irq/handle.c
>> @@ -136,6 +136,44 @@ void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action)
>>       wake_up_process(action->thread);
>>   }
>>
>> +static DEFINE_STATIC_KEY_FALSE(irqhandler_duration_check_enabled);
>> +static u64 irqhandler_duration_threshold_us __ro_after_init;
>> +
>> +static int __init irqhandler_duration_check_setup(char *arg)
>> +{
>> +     unsigned long val;
>> +     int ret;
>> +
>> +     if (!arg)
>> +             return 0;
>> +
>> +     ret = kstrtoul(arg, 0, &val);
>> +     if (ret)
>> +             return ret;
>> +
>> +     if (val > 0) {
>> +             irqhandler_duration_threshold_us = val;
>> +             static_branch_enable(&irqhandler_duration_check_enabled);
>> +     } else {
>> +             pr_err("Invalid irqhandler.duration_warn_us setting (%lu)\n", val);
>> +             return -EINVAL;
>
> Perhaps invert the condition and drop the "else {}"?
>
>> +     }
>> +
>> +     return 0;
>> +}
>> +early_param("irqhandler.duration_warn_us", irqhandler_duration_check_setup);
>> +
>> +static inline void irqhandler_duration_check(u64 ts_start, unsigned int irq,
>> +                                           struct irqaction *action)
>
> Can be const.
>
>> +{
>> +     u64 delta_us = (local_clock() - ts_start) >> 10;
>> +
>> +     if (unlikely(delta_us > irqhandler_duration_threshold_us)) {
>> +             pr_warn_ratelimited("[CPU%d] long duration on IRQ[%u:%ps], took: %llu us\n",
>
> s/%d/%u/.
> Do you mean "of IRQ[...]"?
>
>> +                     smp_processor_id(), irq, action->handler, delta_us);
>> +     }
>> +}
>> +
>>   irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc)
>>   {
>>       irqreturn_t retval = IRQ_NONE;

Thanks for the comments, I've addressed them in v3:
https://lore.kernel.org/lkml/20250723182836.1177-1-wladislav.wiebe@nokia.com/

- W.W.




