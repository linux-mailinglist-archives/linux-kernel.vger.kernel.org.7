Return-Path: <linux-kernel+bounces-739528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9716B0C768
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9F91700AE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF072DECC9;
	Mon, 21 Jul 2025 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O77MbH4K"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA21128C2D3;
	Mon, 21 Jul 2025 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111243; cv=fail; b=OluZF0vO10Npl633H/56mNi/bb9uHh1quYNpbhizOJP3DjERy9Eh5XsnrLHxOfT68Kj2IILZNmZmJU/6afhYfbOC52PK76RpQ7B5uQveocwe34Xi0YbI7r29dnO0PRFeYEkBz+teOo5LRV+PD8E0qQlyX4edpBdAzORmrmRbMUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111243; c=relaxed/simple;
	bh=K9LIz5ve+A7lGx741FPtmpFclQCQR4c/zVkRyV4y3vw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c1qhpSk+TIpLZd73MZftTyk1V6EKeHs+CeMSYYLcSevy6BRPKlCy+OdVgcni7mCuIdLsSqwcOEhFonqZ11SoM7Rg9r+O6eMV9trsLF8uO8FDtoBro/aiK1k/JIeqdxCsG8mNzdhBMk40/7IeAUvmzBqjaXzZKwiALZkAE87VDJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O77MbH4K; arc=fail smtp.client-ip=40.107.96.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZuqERPSEc6uIcGDRXCY+h2Hn707GKVCGFD43ZbCGr5BNOP08he+sgQSah1AorXSMdiBHJ/tNkl8hLDeOirLsYX6rzi5wklK3xWvEH/bLx8lxR1xigW3NIxT68KluyH3i22qOM0fQhCyrvmy0N5JZUcf9UfUK5kJ+mVLj5LD0cqlqTcdOUrbndHM5H1rlFPJZ9tWVYZoUw1d59JofFfDyIk/2KfZyFNk+H4z/atZQ5eHViz7ICK3ypxmiDL/RGCF9MCDuyZBceCm4atysQjDgppifXQbzM+jQDXfxeMVG5Mrm3aaKzkUTaDqMOI4Gxl+o0yH4YiOAWj3OV8ApGV5oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtIwq4VfrFtRiCF8lnY6U5LCN16S35f3gSkzqd1ZCHk=;
 b=VUUl/nRePA62wK084ZVosRb4ZvHFJZOE7NlQkAnwJMIm64LfrhfwoXhqsN6qzfE92s6d8wNXPGh5wZy97aYcXhbAg8vTGlDGhd3YQAK1qyNPcRMOIcB+OyoWwNF5u7tNi7hTtiVtwWzIELWYZwqOBE/OKxwQQeafQG23vx4tlF6cAToyY8bPpbU9hCIecmX6YNISg7tunSxP8s0Lk/r1kEKAwHeu5qVLeS18U3kE/b1SPqRondzA0frfnG6+p1wvs20HTK10LoOTdAi8vw3t2Z7vP92kL7IOlsdjDpL1OJIIdlHtSKMZ8qCtYLIQBL14IYcrlw0YiKaL3/VAox7upA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtIwq4VfrFtRiCF8lnY6U5LCN16S35f3gSkzqd1ZCHk=;
 b=O77MbH4KqhAzpE7aG2tw3R+D0orvtUTrJFTeI4KL26/8QqQeAeYup1JfcK1ljOGUIiRDKkkzwoOmSPmYc7onAp0GKWDPAPAEy7gAO9rpojRrsVj3JEGR0OR9IdrHx6OBRH2trHuQuMcYTsJWV9xLeXrCQfeMDBnilGJWEcB0kUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 15:20:37 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 15:20:37 +0000
Message-ID: <f0b62df8-3582-4f94-bd06-cae2fe1451b1@amd.com>
Date: Mon, 21 Jul 2025 10:20:32 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15 08/34] x86,fs/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, james.morse@arm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc: Dave.Martin@arm.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, paulmck@kernel.org, rostedt@goodmis.org,
 Neeraj.Upadhyay@amd.com, david@redhat.com, arnd@arndb.de, fvdl@google.com,
 seanjc@google.com, jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
 xin@zytor.com, manali.shukla@amd.com, tao1.su@linux.intel.com,
 sohil.mehta@intel.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 peterz@infradead.org, xin3.li@intel.com, kan.liang@linux.intel.com,
 mario.limonciello@amd.com, thomas.lendacky@amd.com, perry.yuan@amd.com,
 gautham.shenoy@amd.com, chang.seok.bae@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1752013061.git.babu.moger@amd.com>
 <e48edcbf4fe2c258ab8d38d9ff78fdb8849c353b.1752013061.git.babu.moger@amd.com>
 <ca71d550-86d1-40ac-a416-c02fbc1ed77e@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ca71d550-86d1-40ac-a416-c02fbc1ed77e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:806:a7::31) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA0PR12MB9047:EE_
X-MS-Office365-Filtering-Correlation-Id: ffed0d5b-509c-4442-0688-08ddc86a253e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmttOEQrN3dtU0t4LzBWcXJoRTh3eE1RM2cwbDJYME5RR1ZOcGh6RnBvSE5O?=
 =?utf-8?B?WTVqcDArb0wwUm0reThlTUNxbGtqeGI0bVdxcWNPK01ONE5BVU9vNTVyMlRP?=
 =?utf-8?B?cEFGK1B3N1FDSDRmTUpvL25SRS9TcFJtdm1QRmJIVndidFVNTmw0M010NkZ5?=
 =?utf-8?B?SVhFUThkRnVDZzRYUFVtZVBxV0xVS1dZanlHWnV2OXhKejNZb01kRXlUdUtn?=
 =?utf-8?B?YXJUcmgxMythUlY4cjFTYS9WY1d5MXhSRE9SMXhlR2ZYNFE0Nmg4NERyaW5N?=
 =?utf-8?B?dW1hakJjWjdBbDA1RDVETWFwS1NEaFJBenZsdmdNdkJJWWxyMFZFVjU2S1Zw?=
 =?utf-8?B?bTNhNHMrWmpVamhIRWd3Tm5wUUJ2ZVpuZFNZaWp2YlErYjFYS1VEV2h3Q3lw?=
 =?utf-8?B?Vy9DOWFPbGpNRjdtUlNCZ2pJL2Zhb1JmY0dBWHhUWkowMjhCcVUyMlhTdU1K?=
 =?utf-8?B?MGZEdEo2WEpKbHlnSC8zajNYSkFwcFdodnUwSmFZRFRscTBwdVV2V2phcklJ?=
 =?utf-8?B?U1BHUWxaVWtrdkk1MU9zS0thbFVLUDJydGZvTSsvSkJOQlh0TTF3VzhFS09Z?=
 =?utf-8?B?dVgzYUdRN3ZkZG9RYjY0WGFCRVRwNnJpdkloako3cmZxekthaVNrenhUdU4w?=
 =?utf-8?B?VkgvQ2xheEd1Z3k5V0hITG4xdittVWw1SDRWWXE3UkpHQlllM0x6MDlCK3hQ?=
 =?utf-8?B?blVndEtTV05DSk5ueDdZOXFYNlU0RUZZZjFhTlk5QXVEVENrdkZuYVZSRUZ2?=
 =?utf-8?B?TllBZjMrWFdnR0tLSTJSaDFqOTZRZE1uUWZncnFRaHQ3ZDNnb2lGOG9ZWkVE?=
 =?utf-8?B?RC9LaDdkK1d2dlNHUzdOczc2TjJQUmlYRVZJOGtWK0FJd29kT2RZSzRmd29B?=
 =?utf-8?B?VlNxUXhndW1pakN2dktZMklsRlU3R1c5b1JjaU5mcU5hTzlHM2NWMkJBWSt2?=
 =?utf-8?B?SU9nNnJ3elVaWEE5c2Nhdyt0aGU2MWIyNHlTUGF1N0J4WWpPaXg0YnMyWUVj?=
 =?utf-8?B?YkNHMmd6Wk4zMG5WMGxVeWZoQlB1MnQzd09YWU9Fc1BxUGxsS2lhSjZoT0Ey?=
 =?utf-8?B?UTlLYVQrV3lDWG5zbzg0Tko3V1hVbzEybXdORWZXaEVjdXpIOEZFSWl5WVVt?=
 =?utf-8?B?elBGYk4zdTRzQUJvcE5aQXJuUmdDYm1EVDJmdis4MlNkOTMrT1gyeHBhVVpE?=
 =?utf-8?B?TVFLK1Zsdjg4NTNEZkxLdUw3V3dEL1Jxa0ZhL0hNK3cyTzhQZmtTQjlsNTJS?=
 =?utf-8?B?c3JWaFV6QXB4aHhBMVprZ0JlaUo0WThnWmpkOEhtMjI2L0I2L0p5NURUY29P?=
 =?utf-8?B?czdFYjRSdVhOUFJPOTJCeldRaVNSRG94ci9wdCtYZDJkMzZ0WmdIeW41NTl3?=
 =?utf-8?B?enRWRkliendGSzlYV1F4MHVyYTJTODBrNFpDdGlESFN5NTNXRURtYmJCSThp?=
 =?utf-8?B?V21YckF3aXdtSS81WkZwNVRFaTlyQ0hNWmNod1BPQjZ3clNvRHQ5STZ2NmQx?=
 =?utf-8?B?MXpxMHdGL0xHbktMUW5yajRWZjRpb2EwMVBNcXFFbGdqeERlVVpMMlR0NCtG?=
 =?utf-8?B?alJoeDcwbXM4SkJtYzlJdTU2YmhyanhaR2MyNWhyNzZwcVhHMGo4OWtaYVFH?=
 =?utf-8?B?TWEybm1UbG5IQmlnblltZldmTnRIVWdreHJlT1FIK3ZYcE9GZG5lb2hwRnV6?=
 =?utf-8?B?OFU2UnppTXpGTzBreEJsck1JQWkrV0lYaUgxRldSUjEvcFZ3QU92QW9Pd1M2?=
 =?utf-8?B?Z3NhWU9odDFjbWIyYVdwQk84dlJsbzRDZ21uT05qL0hOY29vaGlkREtPbGNO?=
 =?utf-8?B?djR6S2d3V3Y5dXNGU0pSRGpKSHdEU0NyNWJuUjZXNlJ1YnY2WHpDd05YME43?=
 =?utf-8?B?ZUZmY0tUckhBM2U4SzYrdUVVNmUrMnZoZ1N4U001STZReWFTRng0UHF0eEcz?=
 =?utf-8?Q?VVp4Ay93y9w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2srNWx6cHVsYUhaNE5Pd1NYN0tuYXdBc3FFdE9ZbzRwMFhFT2hJVFZqSXQw?=
 =?utf-8?B?RS9ic3BVL1JWRFZEcmtNMVZQOHAybEh1T01vMVVFZEFBZlNJd1JrUk5RNTQw?=
 =?utf-8?B?S2RJU3kwNWF4U3NMT0laTmZ0L01VQVcvQTZPeTRBaCtzOU1qWmdzV1A2VWMv?=
 =?utf-8?B?K1FFbnVzWXNxajNEM0Q3MFI5WjQ0eGNlU0M3MEhDdEV1bHVWQmZsM0VybXhp?=
 =?utf-8?B?K1JNYmxBR3RQV3hINEo3Wm4zTVNiQ3kwemNQdjRNNlpMRENDWmV4TjhKTzIv?=
 =?utf-8?B?eW5uMTN2WU94enk5UFdjaUdGYzIvbS94ZkFTSVkxZzBhM2VrTGlBcU9CN2I3?=
 =?utf-8?B?N2Y1L3BIcDkvTWVyWkR6dWd3OTdnQUZiSGFOeHJWdHZmWHlGZjRuWEpxMzhU?=
 =?utf-8?B?dXNTZDc2TFltbmJYdmRJZlRLM3J0eTBXa0ppMEJXam05U05sOVFXRllLSGZK?=
 =?utf-8?B?VUp2ZmQwZUJjeW1WbWd1bDhkZDhiWnE0OTZHeHBqeUNSWTNjMFR5ZVNjQzlw?=
 =?utf-8?B?dXBDeHpjb1lUVng0dE5GMkFuNGRFNGwrcTBNT3Y2MkJJbk9TS1ZJWXE2ekRV?=
 =?utf-8?B?amRFUTZ5QlBnaVlIb0J6bHNIZjhPbURXcytGdUJhTmJ6YXp4OWRGRWcxLzVV?=
 =?utf-8?B?SVF6WDllSEpudnJMdkxlekZkSlNNVlBUVWJDbzdlWVhrMnlNaEY2ZXNmSmV4?=
 =?utf-8?B?RDJuZFcyOHJUam0vaUplbm9wQTVhZkVnNld1WEVxOWxWM2ErVHNGc1hMdUZB?=
 =?utf-8?B?SitqQUNqVWZnQzBVRkRTdGtjb0tQSUFvMTVmVjI4R0FyVjVvYkxiczEwZjlx?=
 =?utf-8?B?MThqQ2NkdW50SFdMWENHQ3g2aTVsK005OCtjSjI1TFk1RVk2VnNRNzBFOXMr?=
 =?utf-8?B?cGFkYytST2ZqSE5DSWw2TVdqMU0yUDhXUUR1NVFWMzVzWjAvUUZ2bnRWNDQr?=
 =?utf-8?B?d2IzQzVPK3lJTW45ZkNkVE41bzNyZUZrRUpuZ29zN2lNblV2NkdFa2puTUxz?=
 =?utf-8?B?a3FrRUZvV0kwdG5MZXA4SjBROXRIOEtYUGNXRUdoYUxMMTBTVEkxc3QwVUFJ?=
 =?utf-8?B?aWNaRjdUZGplRk1CUGwxazllZTRwOTZQT25lOXlzV0ZBekJWUGMwM1JjMDF5?=
 =?utf-8?B?emJHQ1lMaGhCcUkrd3ZtM1Y2ckpXUnhkT3NQRC9QdnlKV0NueUI2dXRFaWxq?=
 =?utf-8?B?SDhLNGpoRWorbmF2UXd5clBOcmpvZFhmblYvajZwREhyWjhab2ZKd1lMWDM1?=
 =?utf-8?B?MU5kTXNhZ0d3ZU1YWUp1WitaNmN3QlJ6MDhLLzAwQ3FDbkZoODlsWmh4eERx?=
 =?utf-8?B?SDNhdWk0cjBHZmJiV3o1REZ4emxFeS92VXpEaVNaRUlUQ1ROeFY4UUtPT3V0?=
 =?utf-8?B?ZG9SSWorc0daYVV4NWhPQ29MV3BQZVdYTE5lYnM0MWo2RFFRT1FPQ2J1RGd0?=
 =?utf-8?B?RHgxdkVUY3lyaU1OeEt6T0VtM0Z2QytpbGpzeWtyNHV4ckQ3K0orT0lQQkcv?=
 =?utf-8?B?S0pMSUFLSEI4Y2lNNkw4NVZQeUFsUmFZdjN1dXorTXFGR3pVd1V5Q1dOOTB3?=
 =?utf-8?B?cVJxQm1obHZzQmE4WEJlRWp5em9ZcnZPRnVWZElMMk5zT0FUcmRNQ1A5TFFp?=
 =?utf-8?B?M015SnJ2bXRrbFdodDJyTW9vNTlUL2l0ZjU0UGlySXFqbFIyTUR3UFpWbldQ?=
 =?utf-8?B?UjhVUFdza1BUVU0vOHVod0cwOEpXNWhHQWtiQlorbWY2WENSVkdqdm56Znpv?=
 =?utf-8?B?QjdibVdBNXNtWjFvN1hYRjVTWTNlZXVneXhONWZmaTlKT2p0MTNWRU9HeUVC?=
 =?utf-8?B?T0ZWVlRBNFByMzAxVUdYZ2lzNmw3Um9Pam4wMS9NVEtObWxXaEFwd0V1U2hR?=
 =?utf-8?B?V2t1UCtTN3JiNGdVZ29JZkszQmFVQ1VnbkFoMVdTT2h0RlpIV1ZpdEd1amZs?=
 =?utf-8?B?UFBpOXBUMVh0Z21TS3VyU0Myc1ZoVFhITEp2RTZzZWF6eDdjVjZLRXJEMEg1?=
 =?utf-8?B?bS9RU2l4YWZ1M3JyVkloOXFNTkxxSEpuNWRISlZlTXc0c3JJd3A5Q1hPUmFT?=
 =?utf-8?B?eXRYRlNmUXg2cXZ4NmFjRndsWFdLeWNGRk5hYitLdGxLSXhUQ1M5ckpaM0Fl?=
 =?utf-8?Q?qFRA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffed0d5b-509c-4442-0688-08ddc86a253e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 15:20:37.5858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLU0NlrQREMQqM4UaNMMkzBsBmVf1rF6ZPRW+9McNxn9JP5iDE4OqzdF3GGf55dr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047

Hi Reinette,

On 7/17/25 13:45, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/8/25 3:17 PM, Babu Moger wrote:
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 267e9206a999..b48cc67cbbe3 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -990,7 +990,8 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
>>  
>>  	if (cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC) ||
>>  	    cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL) ||
>> -	    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)) {
>> +	    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL) ||
>> +	    cpu_has(c, X86_FEATURE_ABMC)) {
> 
> I interpret this to mean that ABMC does not depend on any of the
> "legacy" monitoring features.
> 
>>  		u32 eax, ebx, ecx, edx;
>>  
>>  		/* QoS sub-leaf, EAX=0Fh, ECX=1 */
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 2558b1bdef8b..0a695ce68f46 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -339,6 +339,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>  	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
>>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>  	unsigned int threshold;
>> +	u32 eax, ebx, ecx, edx;
>>  
>>  	snc_nodes_per_l3_cache = snc_get_config();
>>  
>> @@ -368,14 +369,18 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
> 
> rdt_get_mon_l3_config() is only called when one or more of the "legacy" monitoring
> features are supported ...
> 
>>  	 */
>>  	resctrl_rmid_realloc_threshold = resctrl_arch_round_mon_val(threshold);
>>  
>> -	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
>> -		u32 eax, ebx, ecx, edx;
>> -
>> +	if (rdt_cpu_has(X86_FEATURE_BMEC) || rdt_cpu_has(X86_FEATURE_ABMC)) {
>>  		/* Detect list of bandwidth sources that can be tracked */
>>  		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
>>  		r->mon.mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
>>  	}
>>  
>> +	if (rdt_cpu_has(X86_FEATURE_ABMC)) {
> 
> ... so having this check within rdt_get_mon_l3_config() implies that ABMC depends
> on the "legacy" monitoring features. This contradicts the change to resctrl_cpu_detect()
> though so it seems that get_rdt_mon_resources() is missing a check for ABMC to ensure
> rdt_get_mon_l3_config() is called when ABMC is supported (but "legacy" monitoring features
> are not)?

Yes. That is correct. Added a new check in get_rdt_mon_resources().

diff --git a/arch/x86/kernel/cpu/resctrl/core.c
b/arch/x86/kernel/cpu/resctrl/core.c
index b48cc67cbbe3..09cb5a70b1cb 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -883,6 +883,8 @@ static __init bool get_rdt_mon_resources(void)
                resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
                ret = true;
        }
+       if (rdt_cpu_has(X86_FEATURE_ABMC))
+               ret = true;

        if (!ret)
                return false;

-- 
Thanks
Babu Moger

