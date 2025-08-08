Return-Path: <linux-kernel+bounces-760741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ED2B1EF85
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 22:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C0F15A507F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEC423F412;
	Fri,  8 Aug 2025 20:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lyG8divV"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4226E23D2B2;
	Fri,  8 Aug 2025 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754685008; cv=fail; b=R1Qd1LozEKIVqedV/VSA9CS6u8lxBl0fmfKUlGu2wb8xghh9tq7O9bR+jpX1MfhApt/sNvibP9SqM7oF7LpM9/uFAIDU8k2s5Ui4yOm/NmJbjKKR92N7t2o6xU7DaZXs90//nFmqVCklkQHzlMxqPEfHqbYASRJsRxScBUNyNBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754685008; c=relaxed/simple;
	bh=BA1aaZABzyvUYcPXh9UEyTomav5xgh3bGtH9G59TR8o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oFYsb7vsiNWvdEPrVhBmqLX6ZlRu9FqK+SV1TF+F0uiq4v8Pdu+DQ2jVTdGZHipFoZnuJi5AgjTmB7Ai4MnDAH+f+8ltPHXfhNZJsoTK1PeZH9wxyfwqgbA6i+/AGe92sRGzBTIY32O+KU1fInXpcKTG9n/x3IYu9yR9tUoA8xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lyG8divV; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOD/AM95p4RC3IEH4uJOTs2YYEaNDYk9G3Do9QgqOl8dkN6iuqcNc7WA5MqXiW4YPwn6DxNMkiiDtnXf+LDgRWNqe0fXnLFvorcX2j0Y4wS/Rb3v+VTH09JxErg4LrVIUUXo/37i9Icll0jV6WqnKuPESwczvJka+TP803SOgcOILSY8nNjO4qlMqvhkzdGW5yTiqyZCuRnm8TnnYwp5h5J+wGxAH7p75HAsYnZ67fllyTGYpzfruy2BnCTj5sCOOX3+907iDz7VDQth99bTR+Ger4it0hJ5lOJ9DMt8MWsD7pZsppap1s8DbuqhkC+A2ESE8Qc373HYXhxcK146dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAepi7a1uZs0SquI85NY/n+6j5cE9Nl/fiPFKoNFp/s=;
 b=vbX3NOXElm1FcDp0+HoeuLZW0IfXziaB+m7LiRYkvoAEpoLQBmOkDjS8S2hmwGzH2MDKgXMqTZzjYiUhKo9cYMVvKMtg2s8/ikhJpLh4BA+Z60W7Go7udLZvYoVp+AzCi+VBLLrxLexu6GRieKwB1ZqGjAVi4U0EPCajCczji/HwEHiY1qW7iPUjONWjFIQbjryziRsIHsoLz+suBGPq9lTmut34g4zlw261v/C6EMBBcvS3IaTKdE7DySoIPthksiA9f8sHhXFkAm7t/xrYZZDMuzZC0y6SGb6oqUHrKNy+6RyyQwPIwIAuUyNNYMytW9vr3pDXaMz/96gB3wYK+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAepi7a1uZs0SquI85NY/n+6j5cE9Nl/fiPFKoNFp/s=;
 b=lyG8divVahHWv4vg7FfgLXsiOUy7dubLShOjAvBldSJax0/0lJHkByAIKRcXKiBHWtYZ8d8ynI/rqGboUH8TuwLVlvc3fZRLrO8dYaFiIvYYOz1EiGPHB8qKRmvuSZi4w4k2+mmV83t1bLqQIfcXGAqIpCQbPKExptzNRkov260=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by DM4PR12MB8497.namprd12.prod.outlook.com
 (2603:10b6:8:180::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 20:30:02 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Fri, 8 Aug 2025
 20:30:01 +0000
Message-ID: <e4137f68-6b7c-4c4e-80a6-53fd029478e3@amd.com>
Date: Fri, 8 Aug 2025 15:29:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 27/34] fs/resctrl: Introduce mbm_assign_on_mkdir to
 enable assignments on mkdir
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
References: <cover.1753467772.git.babu.moger@amd.com>
 <dd92bf598bf7c922b212100ea668f3241f6417c0.1753467772.git.babu.moger@amd.com>
 <f653a942-b2e7-45d2-b5fb-458b022a25bd@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <f653a942-b2e7-45d2-b5fb-458b022a25bd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0189.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::14) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|DM4PR12MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b65316-0627-4344-23ab-08ddd6ba5978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emVjR2RXOVo2aGxaS3FlR0c3djFpdkN3ZWc4YjVBcVYra2VkTW1HcHdlT2Fm?=
 =?utf-8?B?Rkc3TU1Ddy9jL0dTV1hZb0FQSlhUcHRXa1RUQXVMU3QrUlY2aDZLUUlyZTdI?=
 =?utf-8?B?Wk5wTjFFZ1Q4S050eDk5aGxGcEd1Sk8rSTVVZUdzWEprL1VmYTlsOXE0UEZ5?=
 =?utf-8?B?anNkcW1WNTU0bXdJbzB2bzNWbjJyTUQzTC8vY2FOay94QXpkOGtRdHJ5NkR6?=
 =?utf-8?B?dmxUeTMxWDViLzh0U2VrcHBCWjdOMzBNMjVyTENsNVZta2x5YTBKV0lWTG8y?=
 =?utf-8?B?QnJwY2JjK0JMTGRjZWZOUkpwSGxBeDlQTUZvQ3dpSlhRQnhWVlJUZW8rekJC?=
 =?utf-8?B?S1UrZ3o5VUV1SG0xNUhYcCtYaFVTcE8wT3FKUnV1RGxIUGsrNWpwMmV2NzVB?=
 =?utf-8?B?REhSYWp6OXppNC90THNqK1gyOEFVVkJ3cWpvUktyN3VCR1lHSHcvNEU5dkpi?=
 =?utf-8?B?akE3MGdvVHF0dTVaTElHdDRKSVIwTVlMb0RaZ3dOOEZLeXVIRUpQdmNHL0FS?=
 =?utf-8?B?TDNnSldZVjFLTHRBK2RRSHY4eldMdDlIRDB2OXNyR3ZpN29rMGNmd05DRVZV?=
 =?utf-8?B?Vmp3MFV0ZFNxekc0Y1IyeUlkOFBYZ0ZqVTMva2U3TWhlTER3dldnR0Z2RXFz?=
 =?utf-8?B?alJqZkVscnZ3R2lpclJwMlNSRzFHTEFGbTdxOFZqSDBCWk55NUVLOGVTb0Na?=
 =?utf-8?B?bWpySUg2RHZxNVpIT2t5K1MyQVJKOXRtQ0s3SmV1RHNmOVg1T3RkUmV1WUor?=
 =?utf-8?B?bmFSTUd1U1l0bW9wQzFKaVBBYnhLdHNsQkhxSS9DOXRoYlFCMGlyWkpJbms3?=
 =?utf-8?B?R005ZWQ4a3phQi9JZi9hTUo0cHFCblVTMVJwOU9UMHphS0RYZldaQWJyMEN5?=
 =?utf-8?B?ZzcwOENzZHBxZmJBREtVbXdQVG9jOWkzYnMza2tHR09tUFYxTnRNTDBFQk5X?=
 =?utf-8?B?eFNYVlpoVXJhRXZVMDQ5VXhzeGJQSGtyODRFYlhrWG9RL0JUUTU5QlRNa2dT?=
 =?utf-8?B?cThpUVFmRjJLaVc0UXI2TU1jdWc1am9adVZPc3dhN1pzczVMUW42c3Jnenl4?=
 =?utf-8?B?T3V5NXlOaTRaV0gvQjRCQTV6OUVuVHd1dVptdmJCak9HeTlLT0hGUGFoQldi?=
 =?utf-8?B?YnRSRUp6QTRYTHQ4Z3FEaTdLeVVVeXNZd1crTVlnRlZ1STAzS0FEeEhnNWlN?=
 =?utf-8?B?czVQNy9PV1NuNnY2cGpNd0UyVlk3bDl3U2w1eUpVZmMySHBKMUZob1Facm1j?=
 =?utf-8?B?blRWOHBITUJtaXJEaThPV3FpaDRmNEtkZkRUVHU2SmdvMUlGS3dlQ2lmckNL?=
 =?utf-8?B?cmp2R3NhVW5kQUh0WGJGWjFuVVduUDgyZlpsZ3hrdGY2TmFyZVAxcmVhNHVT?=
 =?utf-8?B?aXVzMXA4TVhYR2dYdGRidUtacUNDRGRwN01IcjRocE9YQ0Z0WXFlZVk1WGwx?=
 =?utf-8?B?TVlYSW5uOS9leENjNkZuaFRuVFRrSHROTnpxell0UENmdm5OOFE3RnVCckV3?=
 =?utf-8?B?VlBEMWpqcVNpWk5tMElwYWM5ZDVadkhycEhmMmREZEhMR3RWUUZ2Ui9GRlc4?=
 =?utf-8?B?M1lMNlZxZnMvd25ka0lzZ0RhekNyOE5nMnVOQW1TTk5ZeTZQYjVqaE9wNWhn?=
 =?utf-8?B?bU1rNi9oU1AzZ2Z6aW1YVWlkdnNidlRHcUxEK0V3d2ZhMGlpRTlKWXlRY3NL?=
 =?utf-8?B?SjhxM1lOVHlyNGE2SDJyem5BZlV2d2JhSGxnczdUTk1SalMxR1EvTk1OUkVV?=
 =?utf-8?B?YWRtaG1GQlF2Sy9sM0l1UUdNTklTUGczbXFVUTR6UndFbnBBYSs0S2FhVTVw?=
 =?utf-8?B?bmN6UjJpWjIzN005TzluY3FsUVlwZ2xtRHFBMTh6eENyVkxMa3pSWlY3SnNn?=
 =?utf-8?B?OGsyTG5tcjFoN2xxS2VOaXhhei81LzVlVzBoNmVWK3BCa05xZG01cElaN24z?=
 =?utf-8?Q?/2n80YgURys=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MCtJM3lrK240Z0Y4VzhsQXR2RmZVV1ptRXNQNnFCZ21Pc1cwTFp6YkUrQmpG?=
 =?utf-8?B?QytnZXpRc0w3eGRQY2IzQTZ0a29TOUxFUGxXUXZUSnVhYUZuSVdmY2dHVnUr?=
 =?utf-8?B?TmZsRVMyU0NrSCtHdVIxREU0cDdqR1NFWUlXVW1ZR2VtQmN1bnlPaGJzMUZq?=
 =?utf-8?B?eDh1REZvQVJxMi9tYXNQRmM2ZnhmcitsUWdzZDZJNHdMSXJUS0dRRkNjVjhm?=
 =?utf-8?B?Mys0U0RRU0VyNHl4bGRoZjZzVFgzcWtqR2N2dHBlbXNHcG90NkR4Zy9mNlZB?=
 =?utf-8?B?Y2oyYlRjZ2l0Qm0zcXEzVXNTRlN5QjR2VlRjZFl0UXhJRDV4Wk84cnZrVG45?=
 =?utf-8?B?RHVZdHFjazYyNStTZENlTmVpdG8zWVVUVXVXYXljVXd4RHNFNkthek55MVky?=
 =?utf-8?B?ZUtnNXdOZTlra09PbmsrV0ZsQzhjK2dqdlZCZW9SMjdrWmtIK0xQNWZ2NWJp?=
 =?utf-8?B?VGhRNDgvRG1Va3Q3MEczSFVwVVhNbUhZUkY4S1NMVGZFT3hlQXlHRzZjYUNi?=
 =?utf-8?B?SmJkSzdWSy93WnNCbFhwTGVrMkFLZ0ZaSmlNTWw3S2haK3JRSDNObUNIOEQ0?=
 =?utf-8?B?NlYxNmxIUTN1UytNL0hLN0Y5dlV0N3ozTHN0Mm5qQWxxRmEzNUlqQUhnQUEv?=
 =?utf-8?B?amlHWnJxR1c3MVFrR1pITndtYWR2WUZGQTNZbHg2QzdkbFU5NkpqNjgvbjRJ?=
 =?utf-8?B?OVV0dXY2SWR4SFQ4Z0puZjV6OGNzL2ZtM1JzSmpKY3ZPd08wUU1leVpZZW5F?=
 =?utf-8?B?T3Rqb3lUT0Y4ZE5xbTB1K2pLWFlmLzNpbXNlQkJMWXhyN1UzclJBS1VIaHFp?=
 =?utf-8?B?d0xvSFpFUU92VDNZOFNCL0Q5aS9ET2pPRk5ialFrTURiTGhIdkxubGFXd3Vo?=
 =?utf-8?B?aUU1RFB5a2RCVXBPdnVrU2ZqWG5nZm1jT21GNnZyelQxMWo0MnlzNEJRanh4?=
 =?utf-8?B?Tk8xZ3lOSUY0N0NoOUZiZldYWHhwU3JqaEtlMzZwNjNBQndkL012ZmxHekV4?=
 =?utf-8?B?cmRXZ0JNWFBTSEwwQ2RIK2JuN1hqL2RrRmJVamZZZXkxYytBKytIVFhyRHNw?=
 =?utf-8?B?VEtVVFhvaWhndDFheFNsc0s0dlBDc1J2dlY5Y21WSXRNclZDRVUvakFVdkxH?=
 =?utf-8?B?NWV3enNacFNXWlBzcTRKVCtVSGFoejZ4aDVWMktMTVVid0w5WGhrNXZhU2Y0?=
 =?utf-8?B?ZzB5RXBCRC9kd1orSzQyQlpIOWltRnRqRXJieU1BM2dxK3htRmp1WTFkSWRI?=
 =?utf-8?B?Zzh0MkdjUkw5amw4N3JIS2JQTEE2QWEzK1NZWjhSN0VnL0haS2hXR1ZYTGlQ?=
 =?utf-8?B?YUZubW4wSjNwb1lEWEFhakVVRXpEVnVrTXFCS3ZqTUlhVU83WkppQXhNcmd5?=
 =?utf-8?B?WWJlNVBSTzE0N3BGbkV5SVV1S3ZBYUh0eGdLbFJUVW9zRXEzVHhLTWlQQW1F?=
 =?utf-8?B?OWhtM2hJeUZkY1BhTnh0Yms5OFVKV1ZRNlFjL0kwT2d6M2Y2RWl3b1c1bk1P?=
 =?utf-8?B?U2V5S0owRW41YVBzSDdNcFZsLzkvWGtVdXlYSHJwaXdwUWpHeDZVSWdTK0NS?=
 =?utf-8?B?c1Y4cWcvU2hkekRTQlRSZDFYa2JVaE5USUdjUGt5WHE3MHg1SXpvQnhhQ1RF?=
 =?utf-8?B?VXFLa05VTXdoT2VZNTZKWldPSkxpUGtqNnZUMmFDT0FCNnA4U0E4enZiOUNi?=
 =?utf-8?B?MTNib1h5ZDY2Wk9QdG5qeE9tMUorcjduZVhhcFYveVVHV0hxdEpldU4rQlY4?=
 =?utf-8?B?ODh5ZWpXcUoyWDdCanBGcURTRDhLWFVPejI5NHRGRHc4OEVKc2hmNk5Mc245?=
 =?utf-8?B?K2FSUlFXeEFBZEtkYjZNQXJhTFo0eHU5MmlTUUlHVVZrVFk3Vm5ZWXY5UTB0?=
 =?utf-8?B?MDFoVXpSQk5jSkRMVWwrRHdFbFh5MFNFVWcweGdYUHpDUyswOUFFSEZyNXdi?=
 =?utf-8?B?dXJKSCsyMlR4U0RNeE9LM3MyMndGZHFzMVl1Uno0M2hGMitCS04zVHBOeENZ?=
 =?utf-8?B?OXdsR3AzWkFGanc0VSt3UU52ZVpNemM0alRZSzRXUnpibXQrQWJ1QUxtQU5u?=
 =?utf-8?B?MVp2RjlmMUUyamwzUWo5UzV3aEdlNTBZTHd1SCt0WGg3aWg5Q01rN3YweGpK?=
 =?utf-8?Q?FMUpI1gfhdwctuhLc8g14oj8r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b65316-0627-4344-23ab-08ddd6ba5978
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 20:30:01.1516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ts+IWb1EyYgwDIfjZuGdh4mGJByOH6F6kXazXWWuHsXjX8O4hiLFOZDS1DPGsAgJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8497

Hi Reinette,

On 7/30/2025 3:08 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 7/25/25 11:29 AM, Babu Moger wrote:
>> The "mbm_event" counter assignment mode allows users to assign a hardware
>> counter to an RMID, event pair and monitor the bandwidth as long as it is
>> assigned.
> Above implies this addition is in support of "mbm_event" mode while the
> implementation applies to any and all assignable counter modes, including
> the "default" and for example the upcoming "soft-ABMC". It is clear to me
> how this is used and interpreted when "mbm_event" mode is enabled, but not
> for the others (more below).
>
>> Introduce a user-configurable option that determines if a counter will
>> automatically be assigned to an RMID, event pair when its associated
>> monitor group is created via mkdir.
>>
>> Suggested-by: Peter Newman <peternewman@google.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> ...
>
>> ---
>>   Documentation/filesystems/resctrl.rst | 16 ++++++++++
>>   fs/resctrl/monitor.c                  |  2 ++
>>   fs/resctrl/rdtgroup.c                 | 43 +++++++++++++++++++++++++++
>>   include/linux/resctrl.h               |  3 ++
>>   4 files changed, 64 insertions(+)
>>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index 37dbad4d50f7..165e0d315af7 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -354,6 +354,22 @@ with the following files:
>>   	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
>>   	   local_reads,local_non_temporal_writes
>>   
>> +"mbm_assign_on_mkdir":
> Needs a "Exists when "mbm_event" counter assignment mode is supported."?
> Also needs clarification on on behavior when "mbm_event" is enabled vs. disabled.
I think we should allow it to modify  only when "mbm_event" is enabled.
>
>> +	Determines if a counter will automatically be assigned to an RMID, event pair
> "will automatically be" -> "is automatically"
> "RMID, event" -> "RMID, MBM event"
Sure.
>> +	when its associated monitor group is created via mkdir. It is enabled by default
>> +	on boot and users can disable by writing to the interface.
> "users can disable" -> "users can disable this capability" or "can be disabled"?
Sure.
>
> This implementation enables user to read/write this file/property when "mbm_event" mode is
> disabled. Considering this explanation I do not think it is clear how this file reflects
> system behavior when in "default" mode. There is no difference between mbm_assign_on_mkdir
> enabled/disabled when in "default" mode, no?
Yes. So, we should only allow modifications only when mbm_event mode is 
enabled.
> Should interactions with "mbm_assign_on_mkdir" be restricted to when
> "mbm_event" mode is enabled? If so, the next question would likely be whether value
Yes.
> should change during "mbm_event" enable->disable or "disable->enable". Above states
> clearly that it is enabled on boot and it may be reasonable to have it keep (but not always
> expose) user's setting when switching between modes.
>
> Restricting it to "mbm_event" mode now gives us some flexibility when soft-ABMC follows
> on if/how it can/should support this. What do you think?

Yes. We should restrict it to modify only when mbm_event mode is enabled.

And always enable it when switching from

"mbm_event" disable -> enable:  r->mon.mbm_assign_on_mkdir = true;

"mbm_event" enable -> enable: "no need to modify as the value does not affect the behavior."

>
>> +
>> +	"0":
>> +		Auto assignment is disabled.
>> +	"1":
>> +		Auto assignment is enabled.
>> +
>> +	Example::
>> +
>> +	  # echo 0 > /sys/fs/resctrl/info/L3_MON/mbm_assign_on_mkdir
>> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_on_mkdir
>> +	  0
>> +
>>   "max_threshold_occupancy":
>>   		Read/write file provides the largest value (in
>>   		bytes) at which a previously used LLC_occupancy
>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>> index 8efbeb910f77..6205bbfe08fb 100644
>> --- a/fs/resctrl/monitor.c
>> +++ b/fs/resctrl/monitor.c
>> @@ -1077,6 +1077,8 @@ int resctrl_mon_resource_init(void)
>>   		resctrl_file_fflags_init("available_mbm_cntrs",
>>   					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
>>   		resctrl_file_fflags_init("event_filter", RFTYPE_ASSIGN_CONFIG);
>> +		resctrl_file_fflags_init("mbm_assign_on_mkdir", RFTYPE_MON_INFO |
>> +					 RFTYPE_RES_CACHE);
>>   	}
>>   
>>   	return 0;
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index c3d6540c3280..bf04235d2603 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
> Please move resctrl_mbm_assign_on_mkdir_show() and resctrl_mbm_assign_on_mkdir_write() to monitor.c

Sure.

Thanks

Babu


