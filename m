Return-Path: <linux-kernel+bounces-801436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B41B444F9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E95507B9E21
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2304337686;
	Thu,  4 Sep 2025 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QDa4J6VV"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356DE305E2C;
	Thu,  4 Sep 2025 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008963; cv=fail; b=nA6dtKRlHra+mu1GV5wIU208sT819ZL8lg8SWjl0SxGWvRbRiquMNOk6+5BOI8zP40XlwikvUpwxC/9d5rnZ4p+zjuD8oQnj0msLTTuc09V444hCl2W3R3a3xoAiPek4sm956jIydH8286Nyu0YR52kX30I5abJ+Q0SM3rQRJlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008963; c=relaxed/simple;
	bh=+2CZ960O9JcpFDRzlS1gLylp41ZCd+oSf2v09QN+v8w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=udX6q6OgpyyxzZnajIx9+iVpxzSBvpqM9P1hWLTuIiBc9QEcnAiE9F5vZDCNbAAO5xOHt83jdOQdN5jaoW4Z+ku2Wf15asDCmBBZRWZCTdzN8f8UPQYKNr96gbiK/7o+9H+Xuz65C0MItdVzcwnHRO/ROP2BDGqIRLRXhVcZ9NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QDa4J6VV; arc=fail smtp.client-ip=40.107.95.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5KTi8PkNvmfvs1zhJbadns0bavLmX9+zT8sfe56Uh+AM2feQ13OTYdbFPtfQkSt+3e0wVRRiRjsKoap9tFoRcjJLG9hvwenrTNSSGShf5zTL/Un0Q+A/q+3Gpf329gnAtcDtNP+0VrKbuhE/6I2KBBlzUL/hwcJp/E3FMisHRHNUQTr7EvCfBx8Mk0pjbQDqUwCmbyRs6UwVXSeims7BDA8h51zl8aRe5Hu8DKYSpMmiOq7t1hxf3tEntj9mLknQifGpsntRrW2L/DCAkelQ5Ak7jn5db7OxlPzngLegCxickghIv4yJJtUlksdIAi71Q6Ci+p4L4VALcJ0SEIwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAIZLlkt5sbhD1Jyqnn0sVsijCjKqcq6c8wzgcxVMXM=;
 b=DR+I8lYRQ9P2QD7rp1e8xqrAfOcvbfriwnmiMur+VFf6w4iw4UKmoDoriFFD/zsJdF2CgaHfRRXYnsTT6OkaQlavByz+0oyGer0XyUiw9Hwkvg5xHgFRQWaasj5MaER9G65sF/ck5Y4qTQbfO/zvWf7wNhEGpjvhJ0aGpcXR0HVhDnbd2ypS8/B7db1LK9qoDiVNvwnYNAIl/E5H3zsgkC6XTJtkPA/pgrXlwK+BWzF4oAtK8VS67IdqB3PnnRn7hKB9QHVSo0MnjMTmWjbTU1FHIio8DYAhZ5Xj3RHJDreoWD/xDgdvShjiccrUAItKFfCUHRaaDkxnBvMlkuyJ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAIZLlkt5sbhD1Jyqnn0sVsijCjKqcq6c8wzgcxVMXM=;
 b=QDa4J6VVSCKyhkY0OIyrp3TsK0BIpfLkzIszOWvIxhIulm7yjEwQzEMNnlPGDid/wH61OaNOoUu/hFW0vnGxfTb/JZb1qBm1A7mUmAUMJVgTWEXGLI1yYO7ODEmJaYbYgS/EHNVdt3NvPLbbbQvAd/serZSBlQlmW/kjIOoG1RU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by CH3PR12MB8584.namprd12.prod.outlook.com
 (2603:10b6:610:164::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 18:02:38 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 18:02:38 +0000
Message-ID: <4a3b49c5-1103-47a9-a987-eb867ed6acd0@amd.com>
Date: Thu, 4 Sep 2025 13:02:34 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v17 05/33] x86/cpufeatures: Add support for Assignable
 Bandwidth Monitoring Counters (ABMC)
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: Dave.Martin@arm.com, james.morse@arm.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, rostedt@goodmis.org, paulmck@kernel.org,
 pawan.kumar.gupta@linux.intel.com, kees@kernel.org, arnd@arndb.de,
 fvdl@google.com, seanjc@google.com, thomas.lendacky@amd.com,
 yosry.ahmed@linux.dev, xin@zytor.com, sohil.mehta@intel.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, peterz@infradead.org,
 mario.limonciello@amd.com, xin3.li@intel.com, perry.yuan@amd.com,
 chang.seok.bae@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com,
 gautham.shenoy@amd.com
References: <cover.1755224735.git.babu.moger@amd.com>
 <8f2c506c2e0bdc4ab3e4736435d683ceb5322839.1755224735.git.babu.moger@amd.com>
 <55dbe7ee-8e4a-4f09-b00e-8e879d8f6ad6@amd.com>
 <11949172-e319-4d2e-b977-67aedeac5c1b@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <11949172-e319-4d2e-b977-67aedeac5c1b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::12) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|CH3PR12MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a34c51-ac8f-4d85-f770-08ddebdd3bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djhZVG5ObEVPalRZWE5TSHh4VmhlM2R6WkU5bm1XcElNNWVXb2M3SHd3OUFP?=
 =?utf-8?B?NkR1eVZucFhCY0lCdk55Q0ZHS2xhZDkwTEJQT2JzcGxETVpkcVlGSGV6cksz?=
 =?utf-8?B?eGdFOUdyZ0xMaTZCM3I5M3NPZU96bHhRM29lMHlORkMxZk9IYkVpeVRKbFVk?=
 =?utf-8?B?bm00bUd4dEtwNnRvV1VRVVFRK2lvekxaZXpFeTdrRkdJVENIUnk0ZTNIQTcv?=
 =?utf-8?B?b2dsWFpYOTRudVMyQnhick9ESGtWMWo1SHgrZFB3d2pXeUdvclg5UWduQnBm?=
 =?utf-8?B?K3hVR0IrN3JYMmZXNklzY25ET2taS2xka29wbnM5MGl4cUlsQkFxWkxNYlN1?=
 =?utf-8?B?ZjdGZENmSGxFSFQwTmZIQ2djMTQzcXF5OFJUMDVReUM2dy95dU12OVJDOUZP?=
 =?utf-8?B?YVJuYlpSczBhM0RNLzBZRjRhVmJHTHhJZTRTMzFmMUxkbXRsQmROcms1VG9w?=
 =?utf-8?B?T0NSY0t0ZXkrVWFxa25iNEQ3dEh3akt4YnUxSnY2dTJxOVdmcU4zMmVZdWtJ?=
 =?utf-8?B?MGRwQVluajQzM1NxT0JjTEliZngwamlmOWVGRXMrMmZPZTRlT0FKZjVHaWZo?=
 =?utf-8?B?Sjdhem5ncGF4OERyU2RwamFSNGFMRW1tUXRoa3did1ZxcGtKa2k4bkllYW1w?=
 =?utf-8?B?R1Uydy9nNkg2NU1uUUJPSysxTzkwYmFZd3Z5dmxOMDg2aEtCaldBRDJjaXJa?=
 =?utf-8?B?bGdrV29GNTBLZlB3d0U3ZVdKQVppMkd1ek01aUdUNUpFbWVIUlJJRVVkWHFJ?=
 =?utf-8?B?NkxlUWlXUlZrOWEydHVJQ1AzTW1TQ3JlUGNPMU41ZEZWODN3WWtDVXVDWGVv?=
 =?utf-8?B?aFBlM1pyTmFFSlprY2VqbTlJbWpRM1hzNm91QnhJUXpLU0p4Wno1dEozSkdp?=
 =?utf-8?B?SU1YSFV5R0N3dWtUaEhDdyttenhlNFdncUU5ZE51R2MvSUptZU5jRTNEK2dP?=
 =?utf-8?B?dldMcnJCRDBQV0dzamJjbmZiT1lObnNnaHE4dnBXSzBqazdNMSt4QjZ5UW5k?=
 =?utf-8?B?Y2NOdDRFclM1TkRoVWlOLzdNd1lzUnhqcTJqMHE1WDRaZGZWbWVYMDBIWDUz?=
 =?utf-8?B?dnJKbzVFd2kveVREQ1dxWjBCeFNtTDlIY0k1MUh0QWFYOFJzMzZWN1dtenha?=
 =?utf-8?B?cFlUMURTVEhBVE5XOUx1Y2lQNWxxc3dESHFkb3F0WkpzWG1mV2dqNW1FYUhH?=
 =?utf-8?B?YkpXQmRLY2gyRHRrMzFzY2dqaDNHSm9ldlVxZC9GSnl6RXR0RFV1Ly9uaFhZ?=
 =?utf-8?B?SWorRnoxemRrYW41QnloL1MrOG5tZVBTZTZJSUNFd3lEVVdwZ1dMQTcwNG54?=
 =?utf-8?B?NUNKYk9zdkFHRGExR0xueHFsK0dydlpOc2wxOVp6MjFFUVFIeFJtTU9yejdm?=
 =?utf-8?B?V3N1OGpDNHlxRkNWRWpQR29wSmd2WVF3cFFpbG15bHdmTHNZaEJiK2J0dmkx?=
 =?utf-8?B?U3M5UUF6M0RxenZrVHVOdzdJb3MwNS9YMVdqL2d2UWd0ZnduY3ZKTWhwdjlS?=
 =?utf-8?B?WUJtbHpYR0xPeUJFTzJPd3ppR2dsYzEwWDBrUTc3U2pHVWJacWdoYlhFVDNG?=
 =?utf-8?B?TDRGRUZRczJrQzQ5VGMrMjFFVU40QitYR3p5T3FjZnVYeHdQYk51ZXBrcG1U?=
 =?utf-8?B?aEZiN0x4WkdiY2k1Z05jQkxYOXFmUDNVSXdzQm5tY2V6S0JiN1puTk12QXhN?=
 =?utf-8?B?SHlrNllHMFZwcHRPa3hkK2x2S3NxQWxwRzFqSHJKMFA5QVVHMHdPWGl2dS9Z?=
 =?utf-8?B?V1lmRlh1ZDFzejUrRXZtUGFTN0p2NDlxMGRobTQxbGdBK05TbXI0ZFdQc3Ri?=
 =?utf-8?B?bDhtZlFBbTJwVkFrUWFYUFI4QVhPY3M2V09KUTUwZ1F3amhtdE5ZZzBWWmts?=
 =?utf-8?Q?mV2A+KpYkKoBk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUg4WFlLYWVjYmpmTHpjdE85amkxUTRFU0JnNjFZSnA4bFRZNWxuN3I1RDhF?=
 =?utf-8?B?TFRaM2o1MXFzbHFxeUFVYmVwZHdmajYrUlJLbEZ3cTlxUHZLSTBlQ1pDZW9a?=
 =?utf-8?B?SlZiVkVJS3hrYWR3eEZ6akxzcTMrRlViNndlMkJ2Wmk1b0ZFRENCcGxrQ0J2?=
 =?utf-8?B?OGl0WjlyV2duU0xmbkdQWlllc29CVDB5eDFKc2tpR2d5YlR0UllnYlhTeU44?=
 =?utf-8?B?ZXZpWTQ3MG81dFlNdExtNzM0b01DNTVXWllmeUhBbGhBdmhXOG1kQ09sMng5?=
 =?utf-8?B?Z3RCVFYxUE54S2RUN2lLd3h6RXU3NHk3bFM2QnJoaTlqZVk5UWxjNkdWZmNF?=
 =?utf-8?B?QTZOeWV6MDJzQXdUK1BYVFIwR0JTTjlWMThEYXJUQkh4c0ROdjMyOFcxeUIy?=
 =?utf-8?B?OEp6UDJwRkdvdlFUb0R1eU5GWFQzelpJQ3Z3MTM4TnZHQzdJTzZwODVCQVc0?=
 =?utf-8?B?R01qblFqWWxBdjAvUnpOU3ljOXFIdVFPeUszZE85SURob0dyVVpxMEYyUFZF?=
 =?utf-8?B?N2ZWT0RMdEw1bGtZZXF6VUhXck1ENjdTTlRiOWk0VkZnY1U5VEgyNUowRUdF?=
 =?utf-8?B?R3BhNTFXWGpOa0FjSm1sNUQ3bmpNeEFqaWJkRVYwWXZSZHJ0WjlJT3k3OWkx?=
 =?utf-8?B?cHQvYW42ZDcxaGJZMk52SCtQOTFaRUJ2NU1DS3ZxSkYvZnZDdCs4WHI5RHlv?=
 =?utf-8?B?elp3YkpGb2VGcFAwelBQODFxbWZrOHVwTUU4SURqRmhTRTRKZ0gyTi9DSlZD?=
 =?utf-8?B?WGoyUjc5Lzl3OTBwKzdkQ3VmZ2hiVHRpTXRDSmVYYW5MbXAzMEorcE8rQ0FP?=
 =?utf-8?B?RjZSQ1ljUG04WjBTTUtWdnpSK3FyZms3bW9zRG1vc1JaWDRLNERxUkZkOCtT?=
 =?utf-8?B?eWRwRGlDU1hHaVZMMENaeVF1QkhveWx5cUJDK3lUYWRuR0pVdkVObnlXbnFM?=
 =?utf-8?B?M1luQ0RRVVdSaEZyN2l3Qkk5YWNVem5SUFk3emFrSUVDcjh5NFpxNmVHbDUr?=
 =?utf-8?B?ZVJZVVZINWNJeWI1bElmeEpvWFpJblNxRjMrVXJxNUJzS3ZnblBvT0xNclNJ?=
 =?utf-8?B?RkM0V2ZFcW9rUDhYTDBOMzdQU09jL1FMcDJXVWNnY3VtSEZQWit1b0FmSThE?=
 =?utf-8?B?emRmN1BSQ01qYUhGYUNzeHp4L0c1Z0dHSm1vbjd0NGlYcldpR3VETDYrakQx?=
 =?utf-8?B?KzRXdm1tRldTdXNMSDNVbkJiU1JqelllZnpjNmdzRXJQc0tic2xYWE5WQ2ti?=
 =?utf-8?B?QUJGR0EzRmFLRGRRRVpBTEFhSlR2cHQ1K0xiUVRXdFRHTU00YmxkcmJjM28x?=
 =?utf-8?B?eGptNGhkYWVoQ3pVUWVYZC8rTGcrcU1sYnRsL2U3akc3YzVpcWRwWkY2T0dy?=
 =?utf-8?B?bEdxS2FrZTNGZy9COUdLbnRRbFFVeGxjcnBFWTFMbkNRVDZYd2V1d1NnQity?=
 =?utf-8?B?Tng2d0dHeUtBbWtZNHNZZ2MwNktlbFlCVUJVL2NiQUVOcmJURGNSREhEVVlM?=
 =?utf-8?B?QUxxZkpFZUl5SEpPb0hlRVVJM3Z3N0dQU2t4Y3h5NmFxZ3RaSzVVRXRrMVFS?=
 =?utf-8?B?R2RsQzlQelpOeUVXSW1OaXRGdnRNV0JPYUJQVWpaVE9uSHR3RlQrR2tDTUJS?=
 =?utf-8?B?WDZJeVNlUHdlaDdVUHNiamE2RVZaL2lRajV3NFFUL2E2WWJ0eW01Si9yK2xP?=
 =?utf-8?B?WXFFQ2YzUDB0ZHdpa3d1bDRYNmVkMVhIU2FQL21kNTVCZDMxaThGME53TnNO?=
 =?utf-8?B?OVQrZkI3Rml2c09JMGhZNkkwYXJTakN0M2hXWG14eVJZd3UzS1JOZE1Vd0Rz?=
 =?utf-8?B?VklIRDRhZE96US9zMkp0c1lscFIvSS9HdXFuNHVnZHlyc0dFRmFLZWdaSjF4?=
 =?utf-8?B?am9tbHlTaStrOFovcVIwSDdZZlhjNzZLZGh0NXFaMi9Lajl2enR2eXhHRzZ3?=
 =?utf-8?B?cGxjOVFhaEI0T0piRzZycTZlYXVjODV6UnBWbDdFMmp0UEFHVmttTWMxdS9I?=
 =?utf-8?B?d2kyWnZKTEZOMUhCbGdrUXVVQm9xUmxZbjU5V3VUMTZQYnJkMGVkc3l6WEpu?=
 =?utf-8?B?SUxjTHc1eTlnSkJNRGdpZG1MS1hFWVljQWlyS3AzaUsvMzdlVVBtV2MzMVkz?=
 =?utf-8?Q?Cias=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a34c51-ac8f-4d85-f770-08ddebdd3bb9
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 18:02:38.2103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Lflfus/z2Tk7fKwOwCA3Zmm5bsqUgEayCI2t2lnDNw076Ow/flY1l3hE4kZpsFI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584

Hi Reinette,

On 9/4/25 12:35, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/4/25 10:21 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 8/14/25 21:25, Babu Moger wrote:
>>> Users can create as many monitor groups as RMIDs supported by the hardware.
>>> However, bandwidth monitoring feature on AMD system only guarantees that
>>> RMIDs currently assigned to a processor will be tracked by hardware. The
>>> counters of any other RMIDs which are no longer being tracked will be reset
>>> to zero. The MBM event counters return "Unavailable" for the RMIDs that are
>>> not tracked by hardware. So, there can be only limited number of groups
>>> that can give guaranteed monitoring numbers. With ever changing
>>> configurations there is no way to definitely know which of these groups are
>>> being tracked during a particular time. Users do not have the option to
>>> monitor a group or set of groups for a certain period of time without
>>> worrying about RMID being reset in between.
>>>
>>> The ABMC feature allows users to assign a hardware counter to an RMID,
>>> event pair and monitor bandwidth usage as long as it is assigned. The
>>> hardware continues to track the assigned counter until it is explicitly
>>> unassigned by the user. There is no need to worry about counters being
>>> reset during this period. Additionally, the user can specify the type of
>>> memory transactions (e.g., reads, writes) for the counter to track.
>>>
>>> Without ABMC enabled, monitoring will work in current mode without
>>> assignment option.
>>>
>>> The Linux resctrl subsystem provides an interface that allows monitoring of
>>> up to two memory bandwidth events per group, selected from a combination of
>>> available total and local events. When ABMC is enabled, two events will be
>>> assigned to each group by default, in line with the current interface
>>> design. Users will also have the option to configure which types of memory
>>> transactions are counted by these events.
>>>
>>> Due to the limited number of available counters (32), users may quickly
>>> exhaust the available counters. If the system runs out of assignable ABMC
>>> counters, the kernel will report an error. In such cases, users will need
>>> to unassign one or more active counters to free up counters for new
>>> assignments. resctrl will provide options to assign or unassign events
>>> through the group-specific interface file.
>>>
>>> The feature is detected via CPUID_Fn80000020_EBX_x00 bit 5.
>>> Bits Description
>>> 5    ABMC (Assignable Bandwidth Monitoring Counters)
>>>
>>> The feature details are documented in APM listed below [1].
>>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>>> Monitoring (ABMC).
>>>
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>>
>> This is an FYI. I am updating the text about the documentation to address
>> your comment.
>> https://lore.kernel.org/lkml/53387aa7-0e72-4bf9-a188-43c0f78c2d6f@intel.com/
>>
>>
>> The ABMC feature details are documented in APM [1] available from [2].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>    Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>>    Monitoring (ABMC).
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
>>
>>
>>
>> Hope it is fine.
> 
> Yes, thank you. I think this is a helpful addition. I assume this change
> will be applied to all patches in this series that contain this pattern?

Yes. Sure.
-- 

Thanks
Babu Moger


