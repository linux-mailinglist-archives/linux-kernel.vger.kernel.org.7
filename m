Return-Path: <linux-kernel+bounces-752492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26145B1763E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D2EE7B5C43
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5A9248F48;
	Thu, 31 Jul 2025 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3royqnNX"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D668195B1A;
	Thu, 31 Jul 2025 18:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753987932; cv=fail; b=XjAMUUMV8PSb4Qj6yfsnoF/Hth4QdyqCyIF6j2o2+AmNP0YllI5+YDyeuW6Rj3F+MT6tJU3IucjiYZwhFdBvLZU4Ys4sY7ioHyFbRdGflavDXGODSLR5i0GURnaZ3PEcHoTcvGEHBm4fissNIaY0YCYQfWhTDpeFude3EsmtBZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753987932; c=relaxed/simple;
	bh=XUzuEyouMYsObLa+C92e3RVrm3tFsOQH/X1yB3e5DHc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YNk5etQxrjSLxQWJ6GH7Ryh5E5ZKkfAFAtzmcnaOI00iHNNBWx5l1Hnv79dI3R4dBwJeTGi/aRb9H7qntzmvMcnFUG/zvI1XJxDYxUa9HvWSAO7mFLOqNVeASrePERGCpgmVZdypGtkRGzjW9y/t1FxmwB+uzQMKlzvQ4d9GESo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3royqnNX; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yy2cTNhquzfBvs2ZRTTHmxknmqyYRKXqPoWMEFeCqMwbJ9pRzY/3srKG1YqBTlDpFVW0GS3vvpvnQtVhs8BvEsn3PXk1Zt04iKkYMyCQwMHcQLy/38+oNfwwlJE6p86bUYSZi3CIk3vj2M1Uc6GTUJ3HMrXeK8N+ee0A9+UwBJSpRqk2CUVkRCjBuXlrqJl4kTJJGO+SiF+xErRAVtS2Opc5fh7yRkHw0YYJBL7GJEBKW+8lLJ+fcwfRIVcVDiN6zK0VCJ+UdviRVlOVbRYTzWIgTtW5KTc+CZ2q8V57H1TwPIyhdDOi22GCe58x9WBcKYYyD9vPsOAnUR5z2/SVJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72tMYUeebeb7o3dEaEsZSfOLviLOzBPtHCGDHakArBA=;
 b=Oh0nJIbzse6qqsALmr9U6ZP784SO07Ysvz8Ii9ZsCYfXwp1vtECzxA54XzycQdHnTfd3nJYjjON5LOagFPr07gcWHN4DtTeoelG9tTiEdQoypiX055afwNoYW67DbujGPLdNCZC+jJL7mUeepC9tvdFOGkSEIJMwFlq/qu0qCMS+THYexdsmbW/jtELE5law7p/ie53FLXVTT7kfaF9skEgfL4XNAtv/K8cxZMZA962FrMsDR8bzIxI8l3Qs903uHKuJ5sT80mrQnFooOpInOaU40hJPyHoc8fwj7fdru4VjyatKfnegPSXX9K7Emwy0abA6cReFURW3YCy3Ss4/3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72tMYUeebeb7o3dEaEsZSfOLviLOzBPtHCGDHakArBA=;
 b=3royqnNX7zuUPPGORDp+KMPwiTRWbUn0d7QRE0Lli2OgQ9OUq6eKbGHkK4XgHkc9BvLzc4ehvyGswp08XRrch1cm7H+VTUfAEj4zRz7uUogu1IfvkcMw7vJvweQRIOtUAm5CEZk8iBd0HWpQW5dnnbHADukTei3ibDAKosjjjcQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by SJ5PPF5D591B24D.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::994) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Thu, 31 Jul
 2025 18:52:04 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 18:51:57 +0000
Message-ID: <e2cf2e42-8a0f-47a4-8c05-8876272275fd@amd.com>
Date: Thu, 31 Jul 2025 13:51:52 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 06/10] fs/resctrl: Introduce interface to display
 "io_alloc" support
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, Dave.Martin@arm.com, james.morse@arm.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
 paulmck@kernel.org, rostedt@goodmis.org, Neeraj.Upadhyay@amd.com,
 david@redhat.com, arnd@arndb.de, fvdl@google.com, seanjc@google.com,
 thomas.lendacky@amd.com, pawan.kumar.gupta@linux.intel.com,
 yosry.ahmed@linux.dev, sohil.mehta@intel.com, xin@zytor.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, peterz@infradead.org,
 me@mixaill.net, mario.limonciello@amd.com, xin3.li@intel.com,
 ebiggers@google.com, ak@linux.intel.com, chang.seok.bae@intel.com,
 andrew.cooper3@citrix.com, perry.yuan@amd.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1752167718.git.babu.moger@amd.com>
 <4e275fadf59e36e38ac60406a19cdf67d640f7d2.1752167718.git.babu.moger@amd.com>
 <ccff50fc-c802-4352-9859-107138f103c8@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ccff50fc-c802-4352-9859-107138f103c8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:806:130::23) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|SJ5PPF5D591B24D:EE_
X-MS-Office365-Filtering-Correlation-Id: e2464c10-881a-41e2-0074-08ddd0635309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnVza3dYMThtRnVTS3kvVXZCUDdobkxnMTdMdHNJdFNMY1BLNDhiYWE1ZHJQ?=
 =?utf-8?B?cXZNQVkvNWVKb3JtcGRLRTNlRlJBQ0ZoTVVUa2tNUytPNWN2c3ErWjU2RGVn?=
 =?utf-8?B?ZkVIWUVmTGU1UzZMajZGdFc4SGQ3T1ZvTy81K2dKYVNlTzdQdFB3ZVVXMkZG?=
 =?utf-8?B?cnRPOWxMK2E4bTgxVURndXFJbzZ5WlYreDBISFRJeEg2dGpDekF2d0V6Wk5a?=
 =?utf-8?B?WGRDUVRuVUEweUkraWRQSU0zcWNIMFdvdjEvb0tINmxkcTA3SVBWMXdtNjJq?=
 =?utf-8?B?aTF2ZmFDakdjQ1c1UVRRTHZYSUZ4bFhQQTV5c01Kc2Fmd3BDOGg3cDJkYXNY?=
 =?utf-8?B?dzI5azhQVnBrL1NWZDNDc3JCYlNwVHJGMGlyc01wZ2Q4ekFLalRRbGQwejdh?=
 =?utf-8?B?d2F6QUpJRmlxOXh6ZDBHUm1CNy93OXBucTdaWDBWdWN2M1B1QnBzWlBaZnI3?=
 =?utf-8?B?dDY0M1d5Y0NPMXhhNnBFalk2NW9mdUo1TjVZYVYzV3RMVEx3dElMbitEVzVV?=
 =?utf-8?B?eWtpclp2UlpjM01maUFRSjNETHdFUzdZZ3pkWVUxQ3hHTVpWeUxKYjVxSzhs?=
 =?utf-8?B?eHdpME9QMStjUzVMWlp6RTNoR3lOVnNyTnNYK2ZsSWhjbEUxRVdCVS9HZG1W?=
 =?utf-8?B?Vy9FTE9kSndQdVh2Q2w0Uis0S1FUY0s4OHB4VGNZbjF0bzF5UlBTaGtMa2pU?=
 =?utf-8?B?ZkFKM2ZzSGwvS1M3ekhuR2N0YnJaSmJtWEdLVXliU2liWEcwK2ttK05pS3dS?=
 =?utf-8?B?UVNIblNBVURGRmdiTHo5SE9Sb1NZZExJMTFwYXpGQTk2eFcvZmpnWVdIbDBz?=
 =?utf-8?B?cFhOMHNyQTlDTjNCaTB3YitLeWtMcGFDeXc5ajF4NUtOdkc4TVAzVkRka28w?=
 =?utf-8?B?Zm0vMkdWMWpFRmRrcytQL3dnY3JLWEcvYWNjRnh5VlJnMEtFZmZ6KzczcVFu?=
 =?utf-8?B?NDducUdDcGR5UlVjaTBwM2FDa3BJQ3NaOXEwb1VIT01SNWJQcy9CT1VnRE9h?=
 =?utf-8?B?Wk9UT3hiaVFnOUdiTUJvckZLQStGaklDM0FNeUtaTUl2TFFhWDc4QzNpa0tT?=
 =?utf-8?B?d2k5cnI5dW15ZGxEd0tDbTZlU3Y5SHNDRWhMWGpCTHZBb25uYU9tVzBlSDBz?=
 =?utf-8?B?emtocFJGTFR6dzNiNi9YckZOK2lXMktHZ29TaWVmeU1wWWpjc3dURjc3STBR?=
 =?utf-8?B?Wm1HOEsvNjhVQmNoMG12dHVIaWcwRUlENzRMYmlTWCtRYzJxM1VMK0gzLzJt?=
 =?utf-8?B?VS81Qkx1VVNGNThpeEtPUkZmS09LVVJjcjcvQUoyLzlXa0VkQUlnREFuVzFz?=
 =?utf-8?B?eEdCdmhzU2F5U1ExcGszMXJ1Tm4rOWZ2cTZPaUtmMjl3TU51Z280YnBoR0VD?=
 =?utf-8?B?ZG55ZjRlQnc1dkkwNTR4dk1BWitVV2hrN2k0cEl5dzVCRmF3Ti9La1IyQVJL?=
 =?utf-8?B?SlBBczN2M0NSMitDTjZXVUgyNG5IUGk4Ykw3bm1LN2U3NmZUSjdoc1JsbC9I?=
 =?utf-8?B?Q1FiZWhqVHIvMDc0MHljc1BTL3ZBRkNPOUtHSHBSeWR4WGNtd0s2ZzVtcXdq?=
 =?utf-8?B?NGZvTFJOSlloTEExZE9RZHhqSTNKRFMzbGRobmhMb2E1WmxQc09CWXg5dzFk?=
 =?utf-8?B?T1FicWZheUsvR2RmOUFTK0hmREgrdmZIZTRRdndyQTdNWDUyWHZEN1VUTTg2?=
 =?utf-8?B?eFkrdGM0Mmw1K0FQN0xMbkZTakZrdU1NbHlGeG10ZGlRUmlaVzBRengzN0NL?=
 =?utf-8?B?SzcrcHF6MWd4TTZTeUEwS0p2eXEwWmRTWWp0Yk96MEo5c0hKU1UyQktqaE5v?=
 =?utf-8?B?bHF2ak1vK3R3Tmg5dlRuYzl2QUNQY2x2TTdWUW1QN1FUR0lvM2NlL0p5MVpU?=
 =?utf-8?B?bTBPb1FVdDc0ZVlvU3U2VEMyU2wzcXFtUllKenRyTUFXbTZhODJlTnEyYzhu?=
 =?utf-8?Q?ko+lC7z/fnM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGNwd25LcC9ERnpsUjlaenZzUzRNUGZjOUljOFJRNXhBa0VmcUxTa3NQN3gr?=
 =?utf-8?B?dVFNU01QRDB2VHhPS3d0SXdNdUoyN3J4bzVnRzFJNU00TFlZRXEybzBrUUdV?=
 =?utf-8?B?Rkt3SjVrNzArQUFvUFZ0Zm1NUlhPR0FNL3VrZjJVWVJPWkhCcFdVVjNaZHRW?=
 =?utf-8?B?M3h6MDMvMUc3WFR2bUpiWHFTOHhhTEJ3ckhSTTV2eXZGeXl1TUIxcW1tdEZq?=
 =?utf-8?B?QWI2SWJtMHUwQk1rVVo0YU80bUxDK2lCN3VGaUtuakhtY0xsV01CUWRwakFp?=
 =?utf-8?B?N3JpL1FLd0g3Mjh0UkR4M3ExbjNqeXFwODd5M2pDSlkrMy81S25mUUtVTEhO?=
 =?utf-8?B?eHN0LzljaGhYcHJUYnh5SFBOZVhjYUNaWFR6cTZFOWJmTDdOUjBXZFVjaE9Z?=
 =?utf-8?B?VXcxbXBxdFo4RzNaTnVMcDZ3WSt2T0dIVmJKbUZiYW41R1BxalBERkNyM2U1?=
 =?utf-8?B?UVQzNnpLajBSQlZ5aDg3RWNyd21FRWhld2J5VzYxK1o2OVRZT3ArTGlIY1Rv?=
 =?utf-8?B?ays3TW5OSk9xWERCaGxwRWJuaXVxSXl5MFR4VThBVUFraFIxZzRYeHdBZWlw?=
 =?utf-8?B?YTNoZUx3NWZ3VHljaE9oRHFLMDRVdkVoZ2EvU2JRQ1QzV0FwSHY0T25zd2pU?=
 =?utf-8?B?dzhqbmtLenFaTmVSMHpmTFFHdnBnUzdMQW4yNkErMldDOE1WeUQ4Tlo2eDJL?=
 =?utf-8?B?Kzg2SWEvbjJpVzVjV2lVRGNicjd2SHN3bzBEK3hWZGxXbjRnZkpTcWwzQ1pL?=
 =?utf-8?B?SUhxWUg2ZDArTEJrY2NzamdOMExNcjZzbkFvVE90ZkpJZkV3WVc4OGJTTkZt?=
 =?utf-8?B?NXF2bWhnbUVPS2RKYW5WWUhQK3VrMTErYTdZdGJhY21GSHBlU3R0L2pMUkwy?=
 =?utf-8?B?SFRqZmRWSnBHYW9ESGV2TFZvSkF3TjQzWDRaN2g5RGZuZGNLOTR6VjNjZWJ6?=
 =?utf-8?B?M0pucisxWStrUUZLK3ZJVjlMUW52MzhGSUlTdE9aTzUwRDZXNDJHQllyQXJ0?=
 =?utf-8?B?UUtPcVhwNWg1djV6eTNqanNZU2tvQ2NlekxpNk9BaWZLTDU2aXN4d3FVS3Vz?=
 =?utf-8?B?b295enF4Z05NQzlXVWpPMGVBSDhZRDE1S0RnOWxZMnUxcFg3aGlLUGtPd2Ni?=
 =?utf-8?B?ZEFMcjVPUmNtTUhDWUhBdHk2a3JLT3NDNHNMT1p2M2NsN0FkUGV3REFyblpG?=
 =?utf-8?B?R0ZFaGRVdVJMdkx0YXZIeFpNbUJrWXRlRFpEYk8xUEIwcFRpMEJza25OZVh0?=
 =?utf-8?B?T0ZSTkNSS1dsRXk3aFJST1FhWVJTTjFGQzY0NGYvK2hFREdMMkV2aS9LMGF2?=
 =?utf-8?B?TzR5Rm9pcDhHc1d2Vzh6WTFYQXhHYkJnbk1NVVNFUTFiMVRVVXh2NXgzK1R5?=
 =?utf-8?B?TUhZNVRYTVh1QktBN0hCcDlURmsxczd0cCtaM2FCVU92Y2F1L1ZYZmVaS3B0?=
 =?utf-8?B?bTlWMzhjZ0FlT0V2aUVNYVlmbTEzL3VSNWZBTmVZcDcxdDdZMzArU2NFdzVk?=
 =?utf-8?B?SnBIZUZZcEhVRkRVb0FDRWNCbjMxbTZtbVQ5Qm1pQ0IvTTN6b1FVUzJrSnRE?=
 =?utf-8?B?dXYxTmhWMUViZEpma3Bxa3QzZWFZQ280b0JIL0tKNVVSek56TmRWdWQ1SDJp?=
 =?utf-8?B?NTAxVW93SlFsUUZUMFdMQytPT1RnaHphRzZFVEJlcFVtZG0vYzQ4Q2ZENFlZ?=
 =?utf-8?B?QlNVaExQY251ajVGaTJZVlpvTGMrV2FXdmJSUHZHVFZnaVVnUUhWKytiTHpu?=
 =?utf-8?B?OURVb2FTbVVTa1RvcTdSQUR3dGZnMXcrNFRFbmM2RnVaNzdJZ3NoWkYzaFdt?=
 =?utf-8?B?VnN5cFFmZGpnRXJLUDBVeGg0WWxtVW1YbHFjN3AxdkdCK2J5SXFYdThDWm1r?=
 =?utf-8?B?Q1A1NUxJYVdpOVFJTjBjZTVxMVdpS2xOWXYvcUpsbVVjZHVEVW9IaHhqY282?=
 =?utf-8?B?bWpaMklTTDg2ZlhIOTl1Mzc0dXB2RGZnR2pxVjRyM21raStyYXcvYnl5dnpu?=
 =?utf-8?B?Q2habU1EeVBCcEpvMVdzek5LdVFSdmZ0MlJaMzhpT0EyeFA5T0NVTDcwcEtz?=
 =?utf-8?B?aDJZZTE1RVQyZ1h5bHVMZ3UxTUVGMklQTDhYeHVFWG9PWVkzMkl1dStUOUZW?=
 =?utf-8?Q?CfeDH2ExggzdkpNgniAvUt0Wo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2464c10-881a-41e2-0074-08ddd0635309
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 18:51:57.2067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhhXXE0rNbsN7sTmQZ/Qp/t+NTQIPgHe/TYMBmADGmlV2yUcIe46vs2+VUh8tSrP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF5D591B24D

Hi Reinette,

On 7/21/25 18:36, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/10/25 10:16 AM, Babu Moger wrote:
>> "io_alloc" feature in resctrl allows direct insertion of data from I/O
>> devices into the cache.
>>
>> Introduce the 'io_alloc' resctrl file to indicate the support for the
>> feature.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> ---
>>  Documentation/filesystems/resctrl.rst | 25 +++++++++++++++++
>>  fs/resctrl/rdtgroup.c                 | 39 +++++++++++++++++++++++++++
>>  2 files changed, 64 insertions(+)
>>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index c3c412733632..354e6a00fa45 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -143,6 +143,31 @@ related to allocation:
>>  			"1":
>>  			      Non-contiguous 1s value in CBM is supported.
>>  
>> +"io_alloc":
>> +		"io_alloc" enables system software to configure the portion of
>> +		the cache allocated for I/O traffic. File may only exist if the
>> +		system supports this feature on some of its cache resources.
>> +
>> +			"disabled":
>> +			      Portions of cache used for allocation of I/O traffic
>> +			      cannot be configured.
>> +			"enabled":
>> +			      Portions of cache used for allocation of I/O traffic
>> +			      can be configured using "io_alloc_cbm".
>> +			"not supported":
>> +			      Support not available on the system.
> 
> "Support not available on the system." -> "Support not available for this resource."?

Sure.

> 
>> +
>> +		The underlying implementation may reduce resources available to
>> +		general (CPU) cache allocation. See architecture specific notes
>> +		below. Depending on usage requirements the feature can be enabled
>> +		or disabled:
> 
> "disabled:" -> "disabled."?

Sure.

> 
>> +
>> +		On AMD systems, the io_alloc feature is supported by the L3 Smart
>> +		Data Cache Injection Allocation Enforcement (SDCIAE). The CLOSID for
>> +		io_alloc is determined by the highest CLOSID supported by the resource.
> 
> "is determined by the" -> "is the"?
> 

Sure.

> To make clear connection with previous paragraph you can append something like:
> 	When io_alloc is enabled on an AMD system the highest CLOSID is dedicated to
> 	io_alloc and no longer available for general (CPU) cache allocation.

Sure.

> 
>> +		When CDP is enabled, io_alloc routes I/O traffic using the highest
>> +		CLOSID allocated for the instruction cache (L3CODE).
> 
> To clear up what happens with L3DATA, what do you think of appending something like:
> 		, making this CLOSID no longer available for general (CPU) cache
> 		allocation for both the L3CODE and L3DATA resources.
> 

Sure.

>> +
>>  Memory bandwidth(MB) subdirectory contains the following files
>>  with respect to allocation:
>>  
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index a2eea85aecc8..d7c4417b4516 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -1836,6 +1836,28 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
>>  	return ret ?: nbytes;
>>  }
>>  
>> +static int resctrl_io_alloc_show(struct kernfs_open_file *of,
> 
> Please move to ctrlmondata.c

Yes.

> 
> 
>> +				 struct seq_file *seq, void *v)
>> +{
>> +	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
>> +	struct rdt_resource *r = s->res;
>> +
>> +	mutex_lock(&rdtgroup_mutex);
>> +
>> +	if (r->cache.io_alloc_capable) {
>> +		if (resctrl_arch_get_io_alloc_enabled(r))
>> +			seq_puts(seq, "enabled\n");
>> +		else
>> +			seq_puts(seq, "disabled\n");
>> +	} else {
>> +		seq_puts(seq, "not supported\n");
>> +	}
>> +
>> +	mutex_unlock(&rdtgroup_mutex);
>> +
>> +	return 0;
>> +}
>> +
>>  /* rdtgroup information files for one cache resource. */
>>  static struct rftype res_common_files[] = {
>>  	{
>> @@ -1926,6 +1948,12 @@ static struct rftype res_common_files[] = {
>>  		.kf_ops		= &rdtgroup_kf_single_ops,
>>  		.seq_show	= rdt_thread_throttle_mode_show,
>>  	},
>> +	{
>> +		.name		= "io_alloc",
>> +		.mode		= 0444,
>> +		.kf_ops		= &rdtgroup_kf_single_ops,
>> +		.seq_show	= resctrl_io_alloc_show,
>> +	},
>>  	{
>>  		.name		= "max_threshold_occupancy",
>>  		.mode		= 0644,
>> @@ -2095,6 +2123,15 @@ static void thread_throttle_mode_init(void)
>>  				 RFTYPE_CTRL_INFO | RFTYPE_RES_MB);
>>  }
>>  
>> +static void io_alloc_init(void)
> 
> This function's comment can benefit from a snippet that highlights that
> even though this operates on hardcoded L3 resource it results in this file
> being visible for *all* cache resources (eg. L2 cache also), whether they
> support io_alloc or not.

Added the comment.

> 
>> +{
>> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
>> +
>> +	if (r->cache.io_alloc_capable)
>> +		resctrl_file_fflags_init("io_alloc", RFTYPE_CTRL_INFO |
>> +					 RFTYPE_RES_CACHE);
>> +}
>> +
>>  void resctrl_file_fflags_init(const char *config, unsigned long fflags)
>>  {
>>  	struct rftype *rft;
>> @@ -4282,6 +4319,8 @@ int resctrl_init(void)
>>  
>>  	thread_throttle_mode_init();
>>  
>> +	io_alloc_init();
>> +
>>  	ret = resctrl_mon_resource_init();
>>  	if (ret)
>>  		return ret;
> 
> Reinette
> 

-- 
Thanks
Babu Moger


