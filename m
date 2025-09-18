Return-Path: <linux-kernel+bounces-823075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CDDB85719
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE52162B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B607D18FDDB;
	Thu, 18 Sep 2025 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="npHkftkZ"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020127.outbound.protection.outlook.com [52.101.85.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A16B1C862F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207966; cv=fail; b=YPRoyvWe9jp/M0fWx3b9ZQXGOU46SdRif6If9NVFIWx/cKwgZGDHpaw8JI+W6N3j4UVTfUE319b3iAF5D7RqFqeZv+oZZHklmwCnohudVR27xe4v/73gxGji0rMW9ESXPTSpYxcXENPpVxaSP3cZCiTIUxvkC9FavUqs7mxkHag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207966; c=relaxed/simple;
	bh=Rf/NXfyNxXIvIEKWhX+tomiHq48Nbb0cAqqTQ46+aqg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cOqn49/KHBBYKAD292GHk/0IFobIxpE5RtmLP2WH10WMvJYE41jUvySqR9q5nnZn7H3aurr0qF2OHSxwiMDww4mm+OosRjegwvV5VVvTXK5RghRDzMux5EMKBAf8AX4U65idasIEjKjMMMoeZVaPBOvu/0bUeUNh9GAijMOQvDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=npHkftkZ; arc=fail smtp.client-ip=52.101.85.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJLDYFIZZx2InxHBfSOxztXj+6oHdcHHNYIymsBB23KkeJfkZDlssB317TB3xvRDCB/YnRASHyDr7NkIwyrUzVlSgx1TO659FyaFw4vbvYVLP5kxamAwXrSUw0MET0O7/AnSo/jPq4udxVPN0Q3i978y+cQzejL3DTf4nfOzmsxttfTe/V0ZyUvqF5lwkLrc61ICLkm3EQy6Lc8Qedm0IX+oeahFfgt2CqM9J5eP6BDzEomViOOOrLoIr1qffw6IJevmA6gSrDrWphaSUD1o3od9SteS02IUtIkVUYzyP4z1BSiI8MF19MeCoRKqRPAyHXnMcN4hN51YE/MrXyI4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmjL/ihV8nH83nq+IwRnCZ0BbhKT8EB6qqrT440A+Qc=;
 b=qvSwoC1xxPLYstrhPnZwA8EfTPayFsKMoE4wZ0pKYmkQZNvjyuF6YqZluAbQ0ks81v/o2qQA7avA23RPv41J9SLVXK9sPRgTUdLh6DjtKMfXdaJHnc2tyoDzDBODCFhRmYSoqDeIteTwNU0o+dbL7VH6pwuLUVBKhUU00XNF6V2+Ym6FymKEc2HpVk5kW8XP00GSkRsoJr67HUqfb5awKdWhxKOlp/7iEPBNwwn3l6rkXnvpRGHVH/Ksiv+f+X5FEXLO11wlnGyTuF2mLeTWxHUr78lAJPAqZrG2Rm8DIJZ4mYAPAUgtt064XAXF8jECo21LjaabF/Z7VWvZLNXVsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmjL/ihV8nH83nq+IwRnCZ0BbhKT8EB6qqrT440A+Qc=;
 b=npHkftkZN/Mk2BWS8L2ZqL/b1bv66umlTFyy17nDsJ7UC0ZLNz0iSg0mkN35VTGuoQdo0m8zqWIj7SHLBMGAkS6hOQnktLFDQ1AfElhwElE0IDVkksWGsoBu2bljL8RNDEcLhS50IXCMkgHuhoCgw3AeCBzkP186WoqmP6QWKik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB6326.prod.exchangelabs.com (2603:10b6:510:a::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.13; Thu, 18 Sep 2025 15:06:01 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 15:06:01 +0000
Message-ID: <22732cbe-20f8-4d1e-b086-e34d0f9bbb35@os.amperecomputing.com>
Date: Thu, 18 Sep 2025 08:05:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] arm64: kprobes: call set_memory_rox() for kprobe
 page
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, ryan.roberts@arm.com, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com, ardb@kernel.org,
 dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250917190323.3828347-1-yang@os.amperecomputing.com>
 <20250917190323.3828347-6-yang@os.amperecomputing.com>
 <aMv_nhEuCSHKp5J6@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <aMv_nhEuCSHKp5J6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:334::15) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 804b2b98-8cb6-45c2-ea0d-08ddf6c4e120
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amdBKzd0Vnl6Vlphd0FaTjB0eVNEdUNISXY1R1I0MDV3WFJpOFpPdHh1NXhH?=
 =?utf-8?B?ZUV1ei9uODMyMWpXN3BlcEJMQy9ocklRYnR0VW02am9SVUZ3YWNNMWlOTWpV?=
 =?utf-8?B?VXNZdUVPc3JNYjl3MWxLQ1NjSURIYlBmUWs4OEhsVUgvN1JXRS85RkRNWnZ0?=
 =?utf-8?B?aGhTN2s2cThROFdmdnRobzArcUplTTA5eG9wT1kyR2RsbktERWJtUUIrS0dY?=
 =?utf-8?B?SWVNQ1pPSTRiSVJQQnVtRGszS1ozcEZ3b1Bqb1hnVUo4Z1ZZZFAvVldKWnVG?=
 =?utf-8?B?cUVyQjQrbHRweXdsakRraFlxS0tHcmY4cDd0ejVJZ3B6YnludFdlcW83UjZn?=
 =?utf-8?B?U0g5OE1KZ2dYLzV3SE5tdjR4eS9FVmdnVlFTQ2J3SFBvYSt3L0ZCMFVkbGpW?=
 =?utf-8?B?VnZsL0hncnBnMVF4Q2xINURUbVBDVFJuR3N1UU80Q3RVRTMwMEZqTXRIUUZj?=
 =?utf-8?B?RmZsNDV6SUl4cjg3cDVCY2sxM0RmMkxERS9LbWN2VTZlekR6djNJOGxWZjlI?=
 =?utf-8?B?cW02TVo1V2lSVjZ1dm9jODFDeHZwczlnNnVQeTJ1Y2IzY3Rma1BXbGl1SlJW?=
 =?utf-8?B?cE1kcHgwQVZYN2FZQTJIbExCRlVxdG56YU1XYXhGRU1NaDF4TE43N1JCaThJ?=
 =?utf-8?B?ekxUR2ZZMk1KbzhPY1pLMXRDK3VWODBnV2dVakJYeTVPZGpxSlFkSFF3bTht?=
 =?utf-8?B?bTVRUjJzVHBJa21ta0VBOUtCbHlKTmlwdzJ6ZmtQZGI0emF6YXpZRTlmdnc3?=
 =?utf-8?B?WDV2SHJHV0gxK2xYcTdWV3lvamF3U1NDUGJtaFJpV0tEZzg2ZE95M0RpbzFU?=
 =?utf-8?B?U3dHZEczeU9JV2FLaGlXNHFBZGJFWm5DYmdGY0FjNDZVTlQya0JlekNvZEo4?=
 =?utf-8?B?LzB5TzlyaEY0dDZqbmNVMU4vZzhJekVZRmc0R2Vtck01cnR1M3EyZzNEMkhp?=
 =?utf-8?B?SlE2Wi9YQjFXdzkyQUtPTU5mUmttVVVKM2FWTktYZzI5WjhMYjVKMWxWL2xS?=
 =?utf-8?B?V1JoRDVZMzdRQTRaMnVwbVZlRi8waDRWRGUzNmZmckNwTHF1enIxaW5QMjJ3?=
 =?utf-8?B?SlFDbFdsU2NIazV4Sk5ZZU1GM1hQUTI0TWdNYVR6Y0lTbDRURFdObGt4K0U0?=
 =?utf-8?B?NVpCNXEzZ0VXSFRiS2RLa0tYMnRUbEJzaCsvb1E1bWFTMnorYUozeThrSmpC?=
 =?utf-8?B?T2syZ2xMQVR4MVNYZEhRN201WHRqTitjaDNEaCthdDNycXNrdkxJQlpMVC9K?=
 =?utf-8?B?cGR4cnJEZ0tFUnh5bS9kT1N3cU42U2lMd3ZHcDFQTHR3blRLaW4yYWRrZm9z?=
 =?utf-8?B?clZuN3ZXQmlCM3o1TmhDYkhMWndIZWRueVZ5SHlHRy9SL3QxZ1h6UUhNb216?=
 =?utf-8?B?K0YzaXVDdWtmYWxxMWdvUlIzcTB4WWJLYytEZEMwYUFwUzhtQ0kxV3pYVi9t?=
 =?utf-8?B?MVhmK25HSFphR1hhVHlLbG5sZVFJZ3AzSnZPaExxVnJxR2J6SE5DMWw1TzVM?=
 =?utf-8?B?cHFRaFI3Y0IzU1NjYU1KMG11MmxWVW95N1F4WE9rTDhIemJqN2U2ZHlyQy93?=
 =?utf-8?B?Q0ZuWm5xVWVuSHZWWk1RcmZHeE9JaEhuNFdqSkVnMVg5MDVjNzZiQktEY3pn?=
 =?utf-8?B?MXZ6azVSMS8rTGZuMW1Nd3ZRa1BGcFZkblRFRUpodDdBTmVlcXNUVTlkVjh3?=
 =?utf-8?B?OGtSK04vcUxNc3NadHEvQ0xzNXV5cXZTMzJsclVxaENRLzI2NlFvUS9pTUNt?=
 =?utf-8?B?b2dhWmVTNENWM1krZW0rV0dyVkZtVThZM0dPL05ZdEx6R1RJMXlScTAyYXBR?=
 =?utf-8?B?TWlycG5GZlV3UjdSMDRVVDd5d2FNa2luY0dOcmpHWUM5cmpMaWV0Y3dQb1Nt?=
 =?utf-8?B?OXdQWGdvbHdTRHpPTG95cWcybnBGUnR4dEZFUnlFMXFTbWlMZnMwWmNETU52?=
 =?utf-8?Q?3YCwVeeyKk0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1E1TE9sRUZwVDV0ZzErMGY2b1Uxd2g1U3dEdzFlK2dmQ2lHTGQ2TjVDQWdJ?=
 =?utf-8?B?QUdIa2VDYWttb2Jhd05XVkMxQzFSbUk3TXRnV0lBalRGd0RtekRhYmpSVHVj?=
 =?utf-8?B?YXB2UmVpYUtrY0RFWG1jZmlTeUhZMWpKbytRYTBkSUprQzhDMGJYU3BsT3Fn?=
 =?utf-8?B?MktuWmNjQUd1T0h0WVN3UzNwdCtuOTBkVzl1QmtZYTNJNWZtVWdQN3FYLzZ4?=
 =?utf-8?B?UTU2SG5xb0RRL1NpSVErWGtuamN1d3lDd1ZsRkJvSEpSSG5odUg4Z014S1dk?=
 =?utf-8?B?M3ZYaGx5UVhwd3l5eHh3RzQrN2RQMG15bzNwa01iZ0c4OU5hTjVVbndueWtF?=
 =?utf-8?B?TkkxdFpCTGxlamlOQjVWT0FWaVRreTRnYkxDWEh2TG8xQ1hqYy9udytyeU5P?=
 =?utf-8?B?TjNzd1E1QmJpSkozMEhreFNwcm5xeFgwMFR3Zi9sVnRKVks2UXM1NHNSbktr?=
 =?utf-8?B?SGRzdzBOY0NWMzBySkdtdzJMYldGLzZuaTErOWZTVHI3dlZNVkZWZ3dYTjRP?=
 =?utf-8?B?NHRCWWNFaU5zYmhlTlhZNXdSS1NRUkxXUVh0NGM3NkZ5S0tjR2s4R0tGSXZ4?=
 =?utf-8?B?aGRLbThiVjRpT09ob2xNaTU0T2FsL1ZqZnd3Y01PYTdnRTdSbjN4UmF1S05X?=
 =?utf-8?B?dHVDeXFTUmFvOU1ZeGxXYW5vbVVRaVdIVk02ZGs0SCs3YU56UFRmWjVHZHRk?=
 =?utf-8?B?cXMzc3VpeU5VR2hCQzl2VWQrR1dMVFlMRk1DSDgwdXJTUlhDS3NOdGhNVzhI?=
 =?utf-8?B?cmxVeUY0cXNHV3p6OUJFWDNpVStLdGJ5UnJ1ckdqQ3NldmQ4OFZrZzVRMEtG?=
 =?utf-8?B?WTBabnBiaHVFSDlGcEdZM3FMRkJWN3ozV0JvSkY4dklhVXEwYWlsUzlkZENW?=
 =?utf-8?B?SkhKTDRJc2lYby9WYksxcHVlK2NodTJtRDdYcGFJOXF4d1hGcjFzeDEzbjRk?=
 =?utf-8?B?K2JaZGkxWHh3c0trcVh5KzA3dlgrWDl0L0RrTkdsUGs5blgxalJQdWRlRTZh?=
 =?utf-8?B?K0NOeVpVVXVuWGNXcWM2VEpISEVmOENKQjEzRFFYQWpMUlNlclVJUXVOTzJj?=
 =?utf-8?B?bmEyQXRtcXZ4SW4rRkloSkVaYWlyeCtZMjU1bWxIWThDeWx3N1Z6WGtzQ2JZ?=
 =?utf-8?B?UnFzSytobm0weWtvYXNGeDZaZU9LZGszdy93MjJGL29MOGZjSjBxcUJYRGRn?=
 =?utf-8?B?MW0rZ0xIVE9PV0JjSEpQazZuV09pUkZFNzRKaitGWVFBZGMwWndqd29aMGQw?=
 =?utf-8?B?N09YUjZLY3prWWxPMmNJWFhTbmF1VWpqL01RTnFBNFordlRBSjU1TEg4NTZz?=
 =?utf-8?B?TU1mOHBSWkxuTStwUDVHckN0NVE5dUtzWk5sK21IR29ncXhMbDA2MzNBc2pR?=
 =?utf-8?B?SWpERnBwalQ0dDQ2S2NUOWxFTVR2M1cycnM0b0o0RXhENS80UUxaSDgyeU9O?=
 =?utf-8?B?QnhqSkZodGdlVTVyNkdlcHFuWGFUSHNPbUhGNVhEN3NOVFl3U2tUdThHSGxQ?=
 =?utf-8?B?c09rb1haV0gxN2t5bXh1UUh1eEptcGJieVRTdjZybzZhdzk5aWFSdE90WC9H?=
 =?utf-8?B?c0IyQUlNTldSSHorOWpxMUZYdjUzZ3VhZ2lwcTRrUGtnZ1VaVDR4NmJyeGhn?=
 =?utf-8?B?Q1pJOVptQURXWHg1cllLcXI0WnkxWkZGUXVteWlOc0RvWmJ2SmtDbE1GaHRE?=
 =?utf-8?B?UG9CNXUvTEVRSE8xMDRBa3hGOHRPZFZObkJGRTM1UXpReWJWM3pBdXVqYU1q?=
 =?utf-8?B?K0dKbDd0U1FuRDJSYUF0UjVZVEZ6WmlZbmEzWHhlWGlvR3Y1ek5sVTlsMWJq?=
 =?utf-8?B?OXhaMHI4WjJtdTNRcERmNDh5V1NLalpyZW5vdDFTdVpSZ2tzU0xrL0NVendP?=
 =?utf-8?B?NDRSOWVnTFlrVksrSlhvWS9Tc2FSL2dyWDZReTNQcFV4cGg3Rk04cloyTUtD?=
 =?utf-8?B?TVBQL2lhQnJvRk81eTlTR1dobmMvU2hId0hCL21wekhiY3JxQ09pK0dMa05T?=
 =?utf-8?B?dEpxVzZ4YTMzNkJDT01aNkllUUNVbmxrWkdkWUNuaWw3ZCt0SnJBRFAzYnFD?=
 =?utf-8?B?ZFkzci9HbDZFQ3dpYjJ5TWNlTEQ4aGM0ZndJL1h5M3FQalY2eFVpVThMTlRG?=
 =?utf-8?B?Ty9FRHFZMmRRTnRJVmJZQ2FvbHVQRFFVcFdnanhUa2dmS3FDdHF4alBDMFIr?=
 =?utf-8?Q?wmwUaw+S/QheTLLkLknJyv0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804b2b98-8cb6-45c2-ea0d-08ddf6c4e120
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 15:06:00.9295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xWO2FXZg4eBUiE6KtZqa1e3aQev/J2iOcdEl+KoEQQuJHX2pG8+b8IGuUBV1jxpU2bR/v+lWlAg7VNdKQKy9t/68AwencgCkj3VSh7Ulxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6326



On 9/18/25 5:48 AM, Catalin Marinas wrote:
> On Wed, Sep 17, 2025 at 12:02:11PM -0700, Yang Shi wrote:
>> The kprobe page is allocated by execmem allocator with ROX permission.
>> It needs to call set_memory_rox() to set proper permission for the
>> direct map too. It was missed.
>>
>> And the set_memory_rox() guarantees the direct map will be split if it
>> needs so that set_direct_map calls in vfree() won't fail.
>>
>> Fixes: 10d5e97c1bf8 ("arm64: use PAGE_KERNEL_ROX directly in alloc_insn_page")
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> ---
>>   arch/arm64/kernel/probes/kprobes.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
>> index 0c5d408afd95..c4f8c4750f1e 100644
>> --- a/arch/arm64/kernel/probes/kprobes.c
>> +++ b/arch/arm64/kernel/probes/kprobes.c
>> @@ -10,6 +10,7 @@
>>   
>>   #define pr_fmt(fmt) "kprobes: " fmt
>>   
>> +#include <linux/execmem.h>
>>   #include <linux/extable.h>
>>   #include <linux/kasan.h>
>>   #include <linux/kernel.h>
>> @@ -41,6 +42,17 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>>   static void __kprobes
>>   post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
>>   
>> +void *alloc_insn_page(void)
>> +{
>> +	void *page;
> Nit: I'd call this 'addr'. 'page' makes me think of a struct page.

Sure.

>
>> +
>> +	page = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
>> +	if (!page)
>> +		return NULL;
>> +	set_memory_rox((unsigned long)page, 1);
> It's unfortunate that we change the attributes of the ROX vmap first to
> RO, then to back to ROX so that we get the linear map changed. Maybe
> factor out some of the code in change_memory_common() to only change the
> linear map.

I want to make sure I understand you correctly, you meant 
set_memory_rox() should do:

change linear map to RO (call a new helper, for example, 
set_direct_map_ro())
change vmap to ROX (call change_memory_common())

Is it correct?

If so set_memory_ro() should do the similar thing.

And I think we should have the cleanup patch separate from this bug fix 
patch because the bug fix patch should be applied to -stable release 
too. Keeping it simpler makes the backport easier.

Shall I squash the cleanup patch into patch #1?

Thanks,
Yang

>
> Otherwise it looks fine.
>


