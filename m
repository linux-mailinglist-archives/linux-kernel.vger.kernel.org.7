Return-Path: <linux-kernel+bounces-739992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6947BB0CE4F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1883A1AA1C83
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AF824676C;
	Mon, 21 Jul 2025 23:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ehv3toC3"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C276E1A5BA4;
	Mon, 21 Jul 2025 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753141209; cv=fail; b=KDG7y+/22ab0+j3ERElLNib0aZG4G/jGfAs0CmH6a3vq8ftSUB71zlQfR/UUFZXvs/DLxe3sBeurRO/xdDQP+jd38xwwCNeQlH7C/pRNkwDc0S1fYUpt7z0jWHhhi1uDYrGdZfs3gL3WUvjBi4c6tRjCk+wW6MRolKRDh5dzmwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753141209; c=relaxed/simple;
	bh=ZxkIMa/0c1Cm5hcppfqnc0VWVprrjjjrQpU7bx97EdA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rn9TeJ/M1WrC9E8e/28zOa9OW2YYeX74ld6Lx03zYHfI4jDzZjAvOzTZ5dw6GsgoyggfI15M4Mlo0uvqMkzHFnaesQN4PIgp4yyrrKX6k1Mdjg7S+kTM59m1VQfBhZUx8xR/H8u8juWl2n5D4j10PNGxJrWZDgcaryjQl5QYryQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ehv3toC3; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSeS26+peOpcZcHW0m22I+C1VWvB1qUUOHWVUl6o9Kciyfbj6VUsByXr9ASnLXGd20IjD9OT4aP9XNUXmFy+t1nCNOGcQINdjAUUb5TiXbCKlyxZU+Pln7gm5s/tfNtwJfx7IbLkSy4Ss8hvtqD2kKKtJH+muHkilJbo6gRNbJq3HJ6ZfD6OnHbK/a3x96Xf2Lg9VWC8Fg6pW70GiOUSftPCViizlE20jnBb6pbtaSatqYNM+tb6X7lFZgvkebl0di7rObyuzDf0rYs1ai9e3jSVZeOvhTUH3u3+g08hBEc/tVwGTRmbTn4UWhesNe+NpDsSlpHWhgVtnKzV5aft3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8CkM/p4it6d5XxO4nTaqByCDgYvcR21Oy15Ex5/fa4=;
 b=dFnnILtelRWkw6CJpi19+/D2Gi1bZL/suKsZlaDScTPH2On7wzmOGValEPrWdfBEGDuy071E2yeZco7qmy3COptcsdwn4JCAz9BvOclWrP5IK29YlEwnFoKigyWoDLxPI3lkhEWevYLwyr8eJpr/sNvbVYVNj9nsUkwIcJM1Uo7PyIZoWxgtaPJyVkMNhU7219b+O4peY33DDUMP/B6TYH8r0IvmGFGfazvkWtJ0rIWQ9wJnjHHoAEDW26JCwsoKR9pUJK2EtM/2RXwtrqhqViUYivQhXrp8S0U39nkuEV9/wgQpV128tFMJnlYJW2eTKwCkMefsbWe/prpob4/nRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8CkM/p4it6d5XxO4nTaqByCDgYvcR21Oy15Ex5/fa4=;
 b=ehv3toC3EDItWfVMsZIK6N9sIEDFIgtdfLcBLIspmxm2EWAFCqhI1tjbTjlwRosIoastJH32lY158MgbqmzX9s6Wq5PLgCIbMc3rkhqwKfhw0d/C0h1wdF7EvDlxQdc+rnneLwVBUVi/w7+JvHNyLly0B+FChHz2qqqt+TPIPbw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB7796.namprd12.prod.outlook.com (2603:10b6:510:275::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 23:40:01 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 23:40:01 +0000
Message-ID: <25c1a212-9d36-44fa-9305-21ac9f866f8d@amd.com>
Date: Mon, 21 Jul 2025 18:39:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 20/34] fs/resctrl: Introduce counter read, reset calls
 in mbm_event mode
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, tony.luck@intel.com,
 james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
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
 <abb2f418a54f46dc3e2a78716f5ab643e112ca67.1752013061.git.babu.moger@amd.com>
 <bb3fd177-2d48-442d-94dd-636d06895973@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <bb3fd177-2d48-442d-94dd-636d06895973@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::26) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: afb0c394-d3b4-4f13-b6a3-08ddc8afe90e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTVhdnBmeUVHckhQRDFZdWdrRENzeEdYMGYyTEJHcGNqalArNWliWjB0S1Ir?=
 =?utf-8?B?UUxhY3hkNloxQnY5V0J5Q3UxdVdaWlFBRGFMRzhoUFNrSTJNVE5vRW16c3d6?=
 =?utf-8?B?Y1lwV0toM1A5blVrRVozSm5PUWZrUTRRN1ZXRWJ0VUx4bGl0VkhTQ1JYQWpN?=
 =?utf-8?B?eUlEamIrN1c2OUdWQkdpSGVibWM0ZjJEbXVKVGJyTWFHQkQzdGoxL2lYaGkv?=
 =?utf-8?B?NVBrLytFMysxVWxndXNOcG44SXhlWkFxYW5ZWEN4Z3pFRXdtMXdFSGlmL2NQ?=
 =?utf-8?B?bWtrVHFhSXQ4WERFN0NZMXR4TFZQaER6VHd3N1BWbXZ6UWNOMmpsUTdyS09K?=
 =?utf-8?B?VWFEUTVPdUlsaEU5MksweG01WnVFRXZvQmRXcEE1azF3eFM1eTY0ZUd6MjB3?=
 =?utf-8?B?ZUpoeU9ROGtJeUd1dHN0MTdtc3FNUXl0MFlsa0hIK0RIWXVURnRBTGtQaGRS?=
 =?utf-8?B?MHdGT2dXbnVQY1RRbUp1Rnk4WThpMTkzVkcvWVR1VjRJeitpbGozWGRnam04?=
 =?utf-8?B?RkNMeWVuU2VVclZSaFlVMmhxTm5SOU9XdXE3cjhXaVdGM3d2VVEyQVp2NXNs?=
 =?utf-8?B?em1JYUVYb3FzNUVnUzZnTy95M2JxSUdSMmV6Ukk3V1gvNHhvK082c054UmZH?=
 =?utf-8?B?aTc0SDRacTFLUDNoekhtTXN4ekdjYkdid09Edy81NWwxV3lKYWFxaWdoMWVG?=
 =?utf-8?B?cnU3WUwzRXpXTlNXbGwzYXNQQzlEc0ZxZExiZWJ3blNUVS9KZlhERUk5aGlo?=
 =?utf-8?B?VXNzeSt6bVUrdXYxd3VXV1VNTU9WRHduTWsvRW5LRWtKWGZwR3lpRm5XS0xC?=
 =?utf-8?B?VG1rU0NjYWw3cjBEdVJTM3pxaHg4Vm80R212M0kxLzRmZFhEZUdlaVVucVl0?=
 =?utf-8?B?Y0FTb0ZyVHNFNk1VQnUxMnZiN05WaUhXbUI5TUI2OUFMRmdmUno2dWEzUkFJ?=
 =?utf-8?B?OVVOdTJmUVpYRnJBSWVROHRJNlBQaUkvdkFvclRyNElxZEpEZGkxdG9MeFVq?=
 =?utf-8?B?NHZQVEpLdVBWVEZ1eEtiSkZxOGZScHpVaTlOUHdmc3l1NFlyK24xamUzQ25h?=
 =?utf-8?B?U3ZIelQrcHNmZHlvMm04RFh3Y1hpZnIySjRYRllqZUpMMUxZcDJnMUwyczV2?=
 =?utf-8?B?d3Bla2JBeDZVTGkzT3BHRFZ2NlNOY1kya0tUVmUzT0xpRjJXWU4rak9ldmJV?=
 =?utf-8?B?ZGI0VzgrSWxNUW54d2g2Rlp2dEVaU0U0SnFjbndBdmhZSTF2REdEYndDUk9Y?=
 =?utf-8?B?OE0vdlNkV2FjcmQ5VHNiZVFSVG04Q0RyS002d3p0SFRhd0NMY1NkVTk3Mm45?=
 =?utf-8?B?RzRtS1JsTzkwWjU1QlJPZUZ3N1c3M2J4dTEvTk03NFJTaDFMWE1DYzQ3SlhM?=
 =?utf-8?B?KzhFWEU5WmMxOG5ZSWZpZHNlRmtzZW90aWQvdi8vWm1SMDI1M2hWNWJ1Mmw2?=
 =?utf-8?B?a1l5ekk4S1RqRW9QTzJSZWIvbzNtczROdHgyR2VDSE5McXNqaVBlaHo3OFV5?=
 =?utf-8?B?RFNXVUxxVHJoeEk2QXl0WEZlUWlzU0pnRDhxWXBYZnlQOWV1dkNJUFk4MU1m?=
 =?utf-8?B?dm5kVEJlZzFlWE5vdm1acG5IazFqMXpvWjVPai9Vb3lhNkUyMXlvNUVFa1JU?=
 =?utf-8?B?K3FIMEVMV08waUVFWlhGaERGRTJxQVlnNWY0bW1QZlpHY3ZUL2oxdk1MME11?=
 =?utf-8?B?ZGYxMEVrUTE4bG9ORUdqQkFhcWtpMHRBdUgrUWNzWXVURTZ2OGtqNnVrSWZP?=
 =?utf-8?B?WGNJeEoyQnpVbGtOekY4a1hyV3YrMzhjN1FSUVAvYWlPV0tiQjZSVGpRNGpS?=
 =?utf-8?B?eEQ0NmQ3cXhuei82YXJvSS81ajc2Q0pENEN6ZkZSdml2ZlRQWkMvTHVTZUs4?=
 =?utf-8?B?Z3FlYU1rRmVuZEVGcFZxVy96TlJ5UVk4Zmd5WXgzU0oyZGc4VlJSeUg1Y2tV?=
 =?utf-8?Q?YT7yqadazS4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UE9sbmViRFVNb3hZT1RqcHJOWVNwVjE0ZVA0NW8zWjJQS0ZHM0RqMUh2blpB?=
 =?utf-8?B?eUMyeStmN2FHSTU0c2pjUVpSRGxaVTBNQ2k2TTcxc3dNNi8wNnlia2x2NXFP?=
 =?utf-8?B?RnJnQlN6REE2ZTBBNVdVRG55YkxVSzlEbjFFYjJpM3oxemF6WUhhMlMxdjND?=
 =?utf-8?B?anZwRGNka2QwcUsyWUFXSmhHVlIrbFRGc3VndDJKLy82QThkcWk2eXlnbnNG?=
 =?utf-8?B?eW42ZWdRei9weVRmNWoxTHlUcHhXNXpncUM4TDlNTjdrbHF1WGt3UXhaQmxm?=
 =?utf-8?B?cXdlTEwvNXVXemRNRGVhNXhnV3NIcmJxdmR4R3d2L2JITjREVXBRYk51WHVs?=
 =?utf-8?B?TStiSldZWFROcmhJWjRrbkpsUmpJRWZlbFVOWm9Iei94THp5WlloOGdidUZV?=
 =?utf-8?B?bmZPV25WeGpCYjhhS1FiRUlFRnNSQWV2aldOUmpaMXNWUm0vQld1c0dMSHpH?=
 =?utf-8?B?a3l3b3JzcFJmT0xVaXF3dGFtUXFnUHREQ1hIYldmQkQvWHJJdTN5QkxQZy8w?=
 =?utf-8?B?NzVQVm1OYnB6N1BJb281MHVHL3pHY21GWkxNNXJlQ1RtOG9LWEt1bzVxeFQy?=
 =?utf-8?B?eUJQTUNJeU1TN2hGVC9ob1o4N1JodlIrRGkydndKcW84eWh4SkxpWjBvVU5m?=
 =?utf-8?B?L3FFN0RMaHY2bjRPTloxUTZibXpoVURoVHFEY0p0MjJWbTIrZkhudlpYMlY1?=
 =?utf-8?B?bjFKcG1LUzk0dndVMmI5VWJDa3VDZ1ZhZE9oOXB6Y1NpdHJVamF5MnNYMDU2?=
 =?utf-8?B?S0FoZnA0dVphWStBOWpEUHdIVHpGa2lXZW9KZTBQd2VXdzJaOUJRNG1SVXpt?=
 =?utf-8?B?YVFSRVpwLzJxWVpVNUpqeE9HUkY0S1RPUHd5TUJtcCtLY0lKRTFIbmtJUnMz?=
 =?utf-8?B?TmE4Nmw5UmxkckJtTWhkVlNPZURuL1owbGdSVHFCcXBKRW54K3oxVU1vd2xK?=
 =?utf-8?B?VXZGMnFwbDhtT3ZyakVYWjZCSWI3cU1KTXJNYXBmb1VJbnp0M2NsTURHRkti?=
 =?utf-8?B?Z2FGS1l5RSsybmFPYXNKZTVWWG9tUTJ3TlBoZ0RicXFYRTN6TnlQd1JuTnlp?=
 =?utf-8?B?RVJOVEhQME81aE1BV0NFbm5vUEM2dlZXb2J6YjRrSVpWMUlpeG43L09VMSt1?=
 =?utf-8?B?S3RIUlFUWDloSVRCSklFd29TTm1tWWYzV0lQMnFmakloY2poVitPQk9XZk5D?=
 =?utf-8?B?RzRXV0UwVFhQZ0UrTmF2RjRtMUw3ME5Hci96UUhPOG93ZUJucW94bjBQcjNi?=
 =?utf-8?B?Q1dhbG9ob0l6aVZaMXVXUjZqUnovLy9qSkJreS9lMlFZZ2k0Rm45MzVVbzBJ?=
 =?utf-8?B?ZWJJZzExL2ltWk9OWmZzZS9VZzVKREVTQkNpcW50VXdaWFhRemJRRE01aEd3?=
 =?utf-8?B?MC9yc2ZmSFRTbGE1T25iTFQzOTNQZFhZZlJBaVlQK3NDUmRVMU1qOXVCKytn?=
 =?utf-8?B?TWFIYm5uOERTc3dFMWpMWjdKT2NPV1cvbllhaVFpalplYjFNMFVRYjZobnh5?=
 =?utf-8?B?Q05lWnZ0M2dUaDFBK0dvU1BBOFdDNTlocTAwWkt2Lytkb2NndXVNQ0NvdE81?=
 =?utf-8?B?YVhVR3dqU1pqZ29LUGJXbU1VNDh3SGorNWpLbUxQTW5OTExSb1ZXNnZuWUF5?=
 =?utf-8?B?blM3ZHpOSHJqalVUdmdyZmt3OG51QUV2TEdMR0FHclpkL3p3OFU5Nk4zckVO?=
 =?utf-8?B?eDA5MUhTNjdnTzVkMHB1aXRLSVl3bkZFTVdhRHIrNVNBalZpeXFsSkt2S0FP?=
 =?utf-8?B?dHJSc3RkREY2LzZNT1BXa0RkbXpDSjNqTUsxdmNlOU5jUWlacFVzQVlPY0d4?=
 =?utf-8?B?QkVzYllVL0dOaGhtcEhWUXNpZGdraDBGZnYyVkV0eGQ1Tm5YU3I5L0ZSYTNL?=
 =?utf-8?B?Y3RpbnNqSTNPMnF6Y05VZFZKYmEyTmxQdlE2a3hKdDM1eDhkMW5BRzNWTy91?=
 =?utf-8?B?dms1T2Y1WmVEZ3RhOXV5Y0QybTdFNVhuSWhTMzJuMWhWZ09uZHpMa3k1T2dk?=
 =?utf-8?B?Q0ExZ3dxRXJERE1HdG1GSnJ5dnJCL3ZlR3UwQ3ZhY1pRSkdZUlA4cko5cHBO?=
 =?utf-8?B?VkphQjVTbjc4c3BTOEYvSVJFZnNGNWM5VVZ5WkpEWjA2OWVROVhPbVY1cFJJ?=
 =?utf-8?Q?z02A871ddkYN+Gk34XHDHR3Eq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb0c394-d3b4-4f13-b6a3-08ddc8afe90e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 23:40:01.5991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Gvp6K1S+14/so+CnCWTHK7m9B8Wp4Ayw7Cw4s+tv0rKF90yRHDzhZQ+1XW4VvfV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7796

Hi Reinette,

On 7/17/2025 10:50 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/8/25 3:17 PM, Babu Moger wrote:
>> When supported, "mbm_event" counter assignment mode allows users to assign
>> a hardware counter to an RMID, event pair and monitor the bandwidth usage
>> as long as it is assigned. The hardware continues to track the assigned
>> counter until it is explicitly unassigned by the user.
>>
>> Introduce the architecture calls resctrl_arch_cntr_read() and
>> resctrl_arch_reset_cntr() to read and reset event counters when "mbm_event"
>> mode is supported.
> 
> A reader may wonder about the inconsistent verb placement so I would
> suggest adding something like: "Function names are chosen to match
> existing resctrl_arch_rmid_read() and resctrl_arch_reset_rmid()."
> 

Sure.

>>
>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v15: New patch to add arch calls resctrl_arch_cntr_read() and resctrl_arch_reset_cntr()
>>       with mbm_event mode.
>>       https://lore.kernel.org/lkml/b4b14670-9cb0-4f65-abd5-39db996e8da9@intel.com/
>> ---
>>   include/linux/resctrl.h | 50 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>
>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index 50e38445183a..96679ad49d66 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -613,6 +613,56 @@ void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>   			      enum resctrl_event_id evtid, u32 rmid, u32 closid,
>>   			      u32 cntr_id, bool assign);
>>   
>> +/**
>> + * resctrl_arch_cntr_read() - Read the eventid counter corresponding to rmid
> 
> rmid -> RMID (throughout)
> 

Sure.

>> + *			      for this resource and domain.
>> + * @r:			resource that the counter should be read from.
>> + * @d:			domain that the counter should be read from.
>> + * @closid:		closid that matches the rmid. Depending on the architecture, the
> 
> closid -> CLOSID (throughout)
> 

Sure.

>> + *			counter may match traffic of both @closid and @rmid, or @rmid
>> + *			only.
>> + * @rmid:		rmid of the counter to read.
>> + * @cntr_id:		The counter ID whose event data should be reset. Valid when
> 
> "should be reset" -> "should be read"?
> 
>> + *			"mbm_event" mode is enabled and @eventid is MBM event.
>> + * @eventid:		eventid to read, e.g. L3 occupancy.
> 
> This is resctrl_arch_cntr_read() that explicitly reads a *counter* and
> just the previous line mentions that @cntr_id is only valid when "mbm_event" mode is
> enabled. How could it thus be possible for "L3 occupancy" to be an example of
> an @eventid?

Fixed it now.

> 
>> + * @val:		result of the counter read in bytes.
>> + * @arch_mon_ctx:	An architecture specific value from
>> + *			resctrl_arch_mon_ctx_alloc(), for MPAM this identifies
>> + *			the hardware monitor allocated for this read request.
> 
> This is confusing. @cntr_id is intended to identify a hardware counter that
> is allocated to this event yet @arch_mon_ctx points to an allocated "hardware monitor"?
> What is difference between a "hardware counter" and a "hardware monitor"?
> The @arch_mon_ctx does not seem relevant to reading of the hardware counters managed
> by this series?

It is not relevant. Removed it now.

> 
>> + *
>> + * Some architectures need to sleep when first programming some of the counters.
>> + * (specifically: arm64's MPAM cache occupancy counters can return 'not ready'
> 
> Again the example of cache occupancy counters for an API that is unique to MBM
> events. Very confusing.
> Would any needed hardware programming not occur when the counter is allocated
> and assigned? What does this "first programming some of the counters" refer to?

Removed this text.

> 
>> + *  for a short period of time). Call from a non-migrateable process context on
>> + * a CPU that belongs to domain @d. e.g. use smp_call_on_cpu() or
>> + * schedule_work_on(). This function can be called with interrupts masked,
>> + * e.g. using smp_call_function_any(), but may consistently return an error.
>> + *
>> + * Return:
>> + * 0 on success, or -EIO, -EINVAL etc on error.
>> + */
>> +int resctrl_arch_cntr_read(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +			   u32 closid, u32 rmid, int cntr_id,
>> +			   enum resctrl_event_id eventid, u64 *val,
>> +			   void *arch_mon_ctx);
>> +
>> +/**
>> + * resctrl_arch_reset_cntr() - Reset any private state associated with counter id
>> + *			       and eventid.
>> + * @r:		The domain's resource.
>> + * @d:		The rmid's domain.
>> + * @closid:	closid that matches the rmid. Depending on the architecture, the
>> + *		counter may match traffic of both @closid and @rmid, or @rmid only.
>> + * @rmid:	The rmid whose counter values should be reset.
>> + * @cntr_id:	The counter ID whose event data should be reset. Valid when
>> + *		"mbm_event" mode is enabled and @eventid is MBM event.
>> + * @eventid:	The eventid whose counter values should be reset.
>> + *
>> + * This can be called from any CPU.
>> + */
>> +void resctrl_arch_reset_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +			     u32 closid, u32 rmid, int cntr_id,
>> +			     enum resctrl_event_id eventid);
>> +
>>   extern unsigned int resctrl_rmid_realloc_threshold;
>>   extern unsigned int resctrl_rmid_realloc_limit;
>>   
> 
> This is new API to create MBM counters. Please use API that is appropriate for
> this purpose. I do not see why it is necessary to copy the RMID read API.
> What am I missing?

No. You are not missing anything.
This is my cut paste issue. Cleaned up the patch now. Only kept the 
relevant information.

Thanks
Babu



