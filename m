Return-Path: <linux-kernel+bounces-827917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4445CB936AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D3114E1FAD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CE73112A0;
	Mon, 22 Sep 2025 21:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sch.bme.hu header.i=@sch.bme.hu header.b="NE22iliH"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023075.outbound.protection.outlook.com [40.107.159.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BB726A0BD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758578389; cv=fail; b=n4hEPZV6wM1bra02tp9xlL8v2rsAihqOjzALB87Pqd03Y/odzYHuy2HdZmvD7wFAwU9CdbPrtSosCDo6UqCd6NiPMLF0p01rsSW7AwF4sSQvDptOiiSXPdjWbUmW0Y3boPN9uvA7VUDwqj0EgDn2EJwbzX9sgsbtp4vSF3FMYkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758578389; c=relaxed/simple;
	bh=Pzv7dXPYvPtVM2JbwcB5tWlrifJV3I6GTP/l+tbhJrc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nc3CfEr9VRNeTA9HjAU0Q2hcxfmdTone+Xw3YNVD0r6IlUSAaENR2VxaeOJmcQIyOgm3J46z6XqSlePcZX9/hzrQV0xks0B6ZNq/pCJBFjvSuCHLnZztJAmnYFeEt0OUZ1iIvNIAT1zfJZQaLLiZKsWrjTwbFf4SbtwZkTQxJmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sch.bme.hu; spf=pass smtp.mailfrom=sch.bme.hu; dkim=pass (1024-bit key) header.d=sch.bme.hu header.i=@sch.bme.hu header.b=NE22iliH; arc=fail smtp.client-ip=40.107.159.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sch.bme.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sch.bme.hu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGrawhaIn8cD1OkMy9Q+yRKDDLICPnc1S/F3mc9mZ4YjNhkEIfmEGyw2AT0ShieGOWjsNgmnaZ6dynb9SLXYE/VfJ15VdKEFloB5a1BxEou5U8oE6X6dCavQ+u+X7JrBW0R8aAfGE1VL/YRdiZ9YVbWKOLw1dlWMVu0jdHKQM20c7xWAciNMSwcl7mdFajNRTp30vRmhXsTEIMBTMawkBC2doEEUOBykoOO0LIKspY0xab9I2VQmJxSu4/EFg5vQ7AjsDQP5V/0GB9bFhfEkttHvHiZXtlLK/fklsvEIrtKxllm7RwLVmmdcc1AElSmWTSEuC0AwMVGf9hxYHXV+5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSEjQqPGcG9yFWkkAl/0gkjbH5CTdJbwTYnCgOqHQTA=;
 b=BYj6+5Q4a1f2J0RAYTr4RzileISslSYu7ce7IG3ay4mqNAcMlaLAx1B+MMTg5Ak9GTpV0YxOJUXlsIN2xQ9SLMmNhD3wDIPrY6g2OQqzUxZhGYbRKkNQKvm4TwGtZdZsh1EEAeyfzFBNtAEpUwr6/V28wSOYXuf4aROiZ9yVGQADD+l7cQCWTG/tOjWGoS0bqLs/2RDgcgiBojp8ulPPDUSPn+QphMTh+dyq8qVZNg5rc24nPdCT9grdfajzeXpM0+VHS3a3qKEU/XlTU4bCaCALHfOSs98OUdBRa5UstyOQ1LUlaGaymyyX9as6VMP0k5XdJdnCrEftll9Whyvw/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sch.bme.hu; dmarc=pass action=none header.from=sch.bme.hu;
 dkim=pass header.d=sch.bme.hu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sch.bme.hu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSEjQqPGcG9yFWkkAl/0gkjbH5CTdJbwTYnCgOqHQTA=;
 b=NE22iliHsstpyU5BEj1NxSgHBGlWj5daahVyld6M8fJLPvIY/Ya+e+nus8LmHGtEyrglf39YoOQ+8XMLxFJJ+1FKyQ5u6Un8sTBlhL1GrgjYbUbcLftDfXOafOY6HDl5YQhJdsUk6leFnDEeoh94B44kbnnSoYQohNemFVBYSww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sch.bme.hu;
Received: from AM0PR04MB3971.eurprd04.prod.outlook.com (2603:10a6:208:56::16)
 by GV4PR04MB11330.eurprd04.prod.outlook.com (2603:10a6:150:29d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 21:59:40 +0000
Received: from AM0PR04MB3971.eurprd04.prod.outlook.com
 ([fe80::c81f:9eb5:fbbf:e9c4]) by AM0PR04MB3971.eurprd04.prod.outlook.com
 ([fe80::c81f:9eb5:fbbf:e9c4%3]) with mapi id 15.20.9137.017; Mon, 22 Sep 2025
 21:59:40 +0000
Message-ID: <9e23fd1b-3d97-45f4-b707-74dba785af70@sch.bme.hu>
Date: Mon, 22 Sep 2025 23:59:38 +0200
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_mailmap=3A_Add_entry_for_Bence_Cs=C3=B3?=
 =?UTF-8?Q?k=C3=A1s?=
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>
References: <20250915-mailmap-v1-1-9ebdea93c6a7@prolan.hu>
 <2a8277a3-1ab7-4a78-a35a-0af983e1c112@sch.bme.hu>
Content-Language: en-US
From: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <bence98@sch.bme.hu>
In-Reply-To: <2a8277a3-1ab7-4a78-a35a-0af983e1c112@sch.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0273.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::46) To AM0PR04MB3971.eurprd04.prod.outlook.com
 (2603:10a6:208:56::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB3971:EE_|GV4PR04MB11330:EE_
X-MS-Office365-Filtering-Correlation-Id: 6345787c-b843-4e8a-1281-08ddfa23543b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|41320700013|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWNiRVhoK2duUlBUSW0vQm4zdW1VRzY1bVh4RmJoVU02NkJFVVR6eFFCYVFY?=
 =?utf-8?B?aHdBR1RJMEluM0JBTVNSdnJKVEoyL1hReUF4OUJJYkQ4M1Q3SFNLMEg5bGpN?=
 =?utf-8?B?dDNrL3Z6eXR6c09DbVJLbG1JOUJxLzdxSnJaYk9UWFlMc0ZiVmtnSi9jdTVW?=
 =?utf-8?B?NkVpbWxjZjIzeVZJcFJNdlRBbXcyNmg5ZUJCN0FlaDdhaHVPSG1wbC8rU1RB?=
 =?utf-8?B?ZnRtcGIwMXZlbEtRWWtVQXN1QmpzWVBVUWVaOVhaL2ZwS1lScUZpY0FLSGRN?=
 =?utf-8?B?SThOdmdXLzZTSFdNUW52YXRYaU91NXNPMXJESXVDVXp3K3lWbmhKQTdxK2dT?=
 =?utf-8?B?eFpzSlZ6U0VtTUZvYWdPb0x4NW4yT3YvNUZBa2E0ME5Ta1JVUkhEckFOL1VI?=
 =?utf-8?B?OXJQb1ErNUhBeTZPUmg2bTNGL3hFR0xZM1lzTGtZcW5yL2VLNlprZTc1Q1hl?=
 =?utf-8?B?RjRKNGlCcFpnNkR5RUlqOXhHY3hxRituTTN4RVIvTTcxMWJVU25FZThCYnhZ?=
 =?utf-8?B?dFNTdFl4NXRTRUZPZmttckVRbDJoRU5SVXZVMTlQRzBqU1ZYZUNSZUFUZ2J2?=
 =?utf-8?B?dDExV1ZMUG9aTEYvNGxLeFc5RUM3c2g3WnJGWlpHVjhscjVNWFIwQ2VMTGJ2?=
 =?utf-8?B?TURZL2E4NndEVCtRbG0wdGZwVU9rdTBDM201dkg5NStUK1ZKeklEcnJpV2o1?=
 =?utf-8?B?QlVhcGtvODR3WFJtMzFFcmU4cWlyb2JoSHIzbmkxbHd2K2lNTENOOWZqVlFv?=
 =?utf-8?B?TGxsWGF1NDA0UHFKcXpHKzE5Z0dWOUtsQXArNHlaUGRnbG5obERSa0JPeXBj?=
 =?utf-8?B?dzdXRmR3cm1ZZFNxaEVLdnNSd2t1QlpjeURGZmdvUU4vaHdxZjV6RGRVNjdZ?=
 =?utf-8?B?dkNtT0dyZlRTM2NSRVBiWkd4RVMwaWRmckVtQkh6VVdRV01UZVpJZForSEZ2?=
 =?utf-8?B?MGp5UWJlUWVJc1lKbWRCYjZENVlnblpxQ3JvRlBkZWJUcVNEL2xJeE5LMDZC?=
 =?utf-8?B?SkFzZG52S1lXbnpmaDlia1BQeEtCRmIvc3hYZDJvdFA1dGJVMzJqQTNjU1Ra?=
 =?utf-8?B?N2RBRXRnWW9xcm9NVzZWWSs3OEhGNm8wb004cjMrT1E4ODRWRGZrNmIydEFi?=
 =?utf-8?B?VUZRa20zWEtPSnlWY0hyUHgwRHAwUG4zckltMk14YkEyQmhSSVk1NDViS2sy?=
 =?utf-8?B?OEZwalVwOVQzSU9MSnUxczVOR3FIeDdnZDlFeUlRREVoZUV1WmFZbi92bkZE?=
 =?utf-8?B?b28wMnNjWHVKcWJkUGt2OUNuKzZ0SGpzUDdMeDVHQWpXYllwSU9TTDVqUWJw?=
 =?utf-8?B?RDd0WmZMMWY3Wk10WmllUitpSGtqdnhZQmdyd0JEUDJVbTFpZkVjeFNBeWlI?=
 =?utf-8?B?ZXRzNTdndjIyVXRXMUN6eS93V3doN1pnSGVobVRxMG0ySnpqd1lMQTNFeVlp?=
 =?utf-8?B?MmZLSmxLZi9CU25UUWg2RmkxMmFmQUl3MXA3WWtyb3pkaEpQZE02bkxRejNt?=
 =?utf-8?B?MkxzNjk2bXMrc05zOUhDWWRZWnFLMzcvMXoyWjJxSk9GcnY5MGU1ZG8rQ1M3?=
 =?utf-8?B?OW9XWmt0bDZyUXJKZGI0ck82WmU1Z2ZzSm13dmx3MUtjWlFreCtFRktDcnFP?=
 =?utf-8?B?UU5xWDk3cWluQURzUkRJa0RSWGlCNUdpcUx4RGJjSE9wZHljRkk1OVJEbHlY?=
 =?utf-8?B?anZ6UHcxMFpRSXc0WHAvUCs1NkJUQ0pneUZ0Nk12QUhSTE54SFpIVUtzOWxw?=
 =?utf-8?B?VmkxcE5kV0NXekV3MVZjT0pSM1ZESkhqZUF3SmpSUlM2NXlrOWUraVI1TDN6?=
 =?utf-8?B?YnBVZGJJQ2c5MWU5ME04OXdlVUEvT01URHdrRlhFZE1LYUlmcGlFQ2xlY1dP?=
 =?utf-8?B?Q20wUUtvSE5xSm4vdWdoekxoZkFuRkVkeno5UEYzc29IVHN5eHo3ajNvV3Nv?=
 =?utf-8?Q?NphnDzPOLOQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB3971.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(41320700013)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2NJQlpuQUUyZ1ZVVVphTzl0SmRuelFyWTdMV2NXbThzWFVDdEVXdEYzUHd3?=
 =?utf-8?B?VC8rbGNleXpCVW5VUlhQUmFhR0k4N1pPQVZXVXVWU0gzL3V0THRGbWlPT2J1?=
 =?utf-8?B?TGVNMDhzQldER3pSR1BnYjhjNTYvdll2WlJ2UWsvL1d1WDJJNFVodXQwOGFI?=
 =?utf-8?B?OWs4dmwzOFViMnV1bDhwMkxLTVdYYVZSaGZubnpzbDJKKzZQL3paZWJ0cXVG?=
 =?utf-8?B?RCtTcWFBZ2hVbUpZWjFYdUJVdEU2TjVTSDMwVE9odVJicmFzZmtIZzQrSDRs?=
 =?utf-8?B?aERKMFNHRUZ5ejcvWEZvcFlWcW9RZUV1R3JndjhBcDJBZDFDV1dEQXNma2tB?=
 =?utf-8?B?ZHIvTXVoU3NMT1ZEV3lUUXUyMTMxSEhLOFNWNkpGT3JpVm5EZXFkYUxLL1hx?=
 =?utf-8?B?MzBYY2ZtQ2lCOTlxem9jbDQwOHJnSGVoSkFvYzRmb3lBQnN3WUNYWDh6THY0?=
 =?utf-8?B?UGFnMTZPTkMxa01NdXk0cEIzdlpRSU1hNU5tK2VhY2FQMDVDZVc1ckJkUnlo?=
 =?utf-8?B?ZnRUdUxoRVozUDlUOTZjSU03YlRCenVkd0ljMXJiS29PWGZZUU1XQjkvTE5K?=
 =?utf-8?B?dFZXZVNYQ2pwN0NIdUc2S3RZeFZhc1p6T2c4eDlJb24vRFRZUmN4TGRqYzEz?=
 =?utf-8?B?TkFwdjhpaW9CRFAyalpJYklPVUVucUM5M25hSms3RGdUamh2cW83ODVRN0FR?=
 =?utf-8?B?M2FTUzBuZjhhaEh3bDhtckVqUmZXRDY1Q2g0RkRWNUV6MzBxVGxtRTd0c0tC?=
 =?utf-8?B?ZytxM2xCaHNhenlHOVV0WmNCdlR1ZE1reTBIOElDN2djd29BbGdmczQxdVpR?=
 =?utf-8?B?LzB1bTJodkJyYTNZdlEwajJ0MlBiZ1pEdkF6bkxzS2Q1b2QwRWh3Y3lLME1k?=
 =?utf-8?B?NU15ZXpscllQSXhRUEs5UVM4UHdtd1MzdHFYRlBBUWxCUzRwNHZOVThHOUww?=
 =?utf-8?B?aHZseEFHMDhqbktQZG5IUkdTZHVwNmpsTkVSMHNrQkdBc2FVK1NhVkhOTWRN?=
 =?utf-8?B?WjRmZnNMTE9waTk0d0FPdHlMeHg5OXRMblFnVnhzZTFsVjkyUHBCWEw5V003?=
 =?utf-8?B?dGpEZ1hZNHFXd1F1bU1PZlJXektncjYzT1YzOUhHUjM5cUlyRVNHZXpqQnJa?=
 =?utf-8?B?VkV2aFFIT3VZQkI2MHArbXRWMC9tMWNyN3RpUTZPQTV3ZU1uTVpBYW85M2dH?=
 =?utf-8?B?b3lkOExPRTBJVWt6ekpIY01OQ0tteHh3TGhCaXdUTkpUemxNekRYSkVEV2Ir?=
 =?utf-8?B?bC9lalg2ZWZvTGdFckd2aXNZbmoweVhYLy9Id0liQ2pIUGRGU1B4UTNDcUJE?=
 =?utf-8?B?Ym9UYitiY1NPQ0tEOWFxcjRHaE82MDRCWVJWbEFUMGZmVUNlZUY2WUE5Ulo1?=
 =?utf-8?B?Vk5kSHJHQnM4MlV4MWh2ZHJYVGNrMEJVN0J1WEUvbTJnVkF6TGp0bUlwZVVJ?=
 =?utf-8?B?UHVwTDRYYTdmb3VNK2JWeDdFVVpCclMvWWVwSTVwbVN5cEFOUHE0SmVtdXlL?=
 =?utf-8?B?NThuZzBlSnlKaUZ3Skthd1BpamRxTkFZdXA5bHprZmdHenJweFU3ME5ESHcw?=
 =?utf-8?B?VWtDR0ZZL2VHSmc4NHlHN3g5YVNuU2dzYSs5dENuWmZWZUNLOXk5cXNZMm44?=
 =?utf-8?B?OVlXZGducXc3QmFMTFdYNU5jMDMyc2ZIbVBvaWJxSGFCYzVqZmhPcDhmNFBa?=
 =?utf-8?B?OGR6dk0zQXRaV2xHeGt4aHNybGVJZWxRa001b1pjVWJxVlhLdjVHVkxEa0xn?=
 =?utf-8?B?cU54VDZVL1lKdlBHdGdVYzljdHRTTkZJTmRKSDhxZlRtbXJmZmJBM0NXVFFr?=
 =?utf-8?B?Z1IvZk9IVjRKdTV4SVM3cGFMQmtOUTlEeHFpODQwQzh5dXpLMGtCUyt4dFNI?=
 =?utf-8?B?VEY5U2RiVzM5NjVIblp1b0prdFFURWcyOWNpT2hIMVR2QmxmWHRyVXFFbjdR?=
 =?utf-8?B?MHg3cGNad1NoMlkvK3RjTFoyYjdSd1U5RFl0c0p5VHY0Q0I3R0p5cHFJZzFt?=
 =?utf-8?B?RmliVXJQQStwVlFjL2ZlSmxMSTVIVkRlcHdzTHltVnE5c3hQMENRMXpDaUtU?=
 =?utf-8?B?M3dOUjFUTmlZZ1ZVTk54ME5PWmNjaVArNDdLTnVCODF4VDAwdUc0WVNMTjJs?=
 =?utf-8?Q?qSU0RPPQg4Wu24xPN3yCfxh8T?=
X-OriginatorOrg: sch.bme.hu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6345787c-b843-4e8a-1281-08ddfa23543b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB3971.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 21:59:40.2662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 79f0ae63-ef51-49f5-9f51-78a3346e1507
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TrxfvE0C3dt+BksdwPgUyTNhVNpT1lShr0iW2n7U8aLbR0r+5n91eUqiW/jeXJjSP+s6ODXHDJPDd002qXZiOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11330

Hi all,

On 2025. 09. 15. 11:13, Csókás Bence wrote:
> Hereby I confirm that this account belongs to me as well.
> 
> On 2025. 09. 15. 11:05, Bence Csókás wrote:
>> I will be leaving Prolan this week. You can reach me by my personal email
>> for now.
>>
>> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
> 
> Signed-off-by: Bence Csókás <bence98@sch.bme.hu>

As of today, my Prolan address has been disabled. You can no longer 
reach me there, I don't have access to it anymore. Please update the 
mailmap at the soonest possible time.

Thanks,
Bence

