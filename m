Return-Path: <linux-kernel+bounces-751312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFEBB1678C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D583B7B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C21215191;
	Wed, 30 Jul 2025 20:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="odAvbhd9"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28A51E008B;
	Wed, 30 Jul 2025 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753907001; cv=fail; b=E6924EyuZ32VJ0o/S3OcgzQyKEEs2hhuzMGj/fzIvx0BMIsvWqcVrvAqMlkGSz8yLC+fpA7esvXlq8nJLKy2pASHr/2DBcgQtq3DQYfQ1iMdXgZ/oA6d4YY183fYzm6U5yHNGdvt9JnhMosp0DuSLSKSiAlRAtqn7c8RLgOOMfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753907001; c=relaxed/simple;
	bh=82+he19kfC8UyiJhyW1UznuaZh7aoMXke5lV/4Seuzs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qFqBI1aSBmH/51A3my/sxK/u3WLqpmYPJQxEMdyoR4vh34x2diy4m/5Kg9Af4czEWzCXsO1+7la4pXEnz8x69P2LCLDyYi8CAQcFCE1tSlkpemRys3YdJc9bnobTpM5QMn0KQFtwx6woVkuHu903sTPxJaomHjCpRwmWdkKzfVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=odAvbhd9; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qR3vrL/RhqECvyEr8z/wqPm84kDjzsCLwqtTkB7ZxIAxn15njNx8nG60P+8J6tz6G5qq0IRCPOZhPGtEMuDTR1zDznWfOkUQNUTE/k0wCvSDCEuU5zNBwJUhHW1Uq7N2PRqMnMexOnxzJLLxl+jo9JQoHuSfZ7zPOxoun7QJBRjADBtnXft4z+HtibYOS21v7M2eX44rSZoK8T+DBEv63Nio813Qzq3l0mJvWFz1uEFLCP9sYa7X7gVjBniXSJRT7xabxJawOHc948PfKwEdEFVjKXBwrat0GVFgBlCdipsIn44yefRq0DqrWE5ocrNu3Xio+p50VDhdH0Oa2QnZ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqjBJE130Yog5tND5P8KWsHS1CjER7iSVd3YyIiKIyc=;
 b=ISDXAn3CYYPoSLPQ8Q7TiNydtkXPsV0a23DG+oyeFX+BLFySKKBVu5QX711cSO8wqq/8fIxOCfpemw3Z2VYtdFINelV41PRtrRwHezGc95xz2iuKxTWle5bWsJHSA9nM/yV4xDp6tRHlJjm+kp5Z98bLvxRhPU8ZehPzvbpIY/IeNhnvHh9qy7ovVvOjvbgcc8/dd3i0pc1V/QQ9TEc+LSET2a9h9819AKiqMQF8k3a6TBRCrVIF7p4aDdE0JotEMFeDOgr1FTiqGNqzlZYEU3XSNbiP1vPVy/jAYpFDONf2917M06zV+MK6a8I1RKJW0SlASFe3I3XaOQYPcEkWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqjBJE130Yog5tND5P8KWsHS1CjER7iSVd3YyIiKIyc=;
 b=odAvbhd9vbbGx7dWpq5YipgN0IA1uBGjHwl71J4R7iPuufr/i2i7tXte3pdvH/bLNMPHeXyzJPOELidvSBcVUshJm0O46unCfUwNTZYyatShUj2Kul6lm+gVUqBdv09YDEP95eHNowfHCS1Bi1uaysdNWk9cjN1nVB8u35YZxHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by DM3PR12MB9436.namprd12.prod.outlook.com
 (2603:10b6:8:1af::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 20:23:17 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Wed, 30 Jul 2025
 20:23:06 +0000
Message-ID: <c9866186-a68a-4051-a031-2279ca401fef@amd.com>
Date: Wed, 30 Jul 2025 15:23:01 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v16 01/34] x86,fs/resctrl: Consolidate monitor event
 descriptions
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
 <404b149d4e717fa7e7f93cbe85cd5abd990202ca.1753467772.git.babu.moger@amd.com>
 <aa40fe11-b3a5-4b86-81ca-db8b997ef325@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <aa40fe11-b3a5-4b86-81ca-db8b997ef325@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0272.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::7) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|DM3PR12MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: ba638e4a-2dfc-4ca0-5e5a-08ddcfa6e43c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dklZbkRsQ215Q0RGemZnWENJNzVick1aMit5V0JiZ1VnVVc2WlZxVG1XQmNo?=
 =?utf-8?B?dFVnSmx3MmtZV3JpWktaVkRuUGVXbzBGcFJvT0pidThaei8weVdpWG9zWXlo?=
 =?utf-8?B?all2WktxYS85RWM0NGdNWEQ0ckU1bFFxcyt2WjZmSkd6aVNlNWRFOHVjbTIv?=
 =?utf-8?B?c0wyRHBnc21wb0tFUTg4R2U3TjBoUHNKYTB4UmVSNjdGY1A4a3Y4RXcxN3Rn?=
 =?utf-8?B?UGlESFFsNVRSdnlPMFY0aHM2VlI2RXBrdzRnY0dheWR1MTFWWlhTT0ZIY2tj?=
 =?utf-8?B?U2Q0bWc1bHc0Y2R6dFNpaTZSVzNidGU3SjRDcjZCQ1crSHpXRnlMOW1mN3ZJ?=
 =?utf-8?B?QTVaZWVtZitkSXExSGhQTjdrQjhwZ01xRG0ySkJmRkk3N0NLTHJwVm0zbG0r?=
 =?utf-8?B?TXNiYUtwcHJUSm5GWVB0SjVvRHB2ekh4V3ZqUGh4UUtMb00zV1JRb1dWeWhs?=
 =?utf-8?B?ZkxCbTVzMXBQMnNjeTZTY2l1SENCYlZSaWM1SWJuU3Z3d1g4Y1JBN0RpZG1E?=
 =?utf-8?B?enpmbm1TNDRLbHdtKzJqQnoxeVlEU0pTc29zajIrVU9PSEhvbk5DL1Bsc0lw?=
 =?utf-8?B?cDB4aW5SbnpOelNGN3NwWnZkMkhDOHZNNHlGK2ZPeVk4UlFEbTRUZzZHTjlk?=
 =?utf-8?B?S1I0SnRIaW9vZlBtNHJPWk45SS9PcldEaTdRQ3VHUHVKWnBKaXJxaHNsY1Fm?=
 =?utf-8?B?UkxhV1JNNGdwRTdvZnNjQlQyL2M3U2RTNWZQaWpNaGM2d0EzL05zczBHeGpK?=
 =?utf-8?B?UEc1Sm9kNU9vQmsxVStPUmF3K3JmTVpyeWhYZ1I4WTVvRDZubWhybkNuNkcx?=
 =?utf-8?B?b3NUOWdnRU9BMGkyeU9iT2V4WkxHTVkrZ3lqKytHeDBZcU83VWs0QkNPU3Ax?=
 =?utf-8?B?d1RpbXAyUWJJQlEyVWFIMUpjbHZnNFpFSWl1YVF1UFNnbnpTLzZTTGdqS2h3?=
 =?utf-8?B?dWhaSmJ5ZHBUZ0Yrazg3NktNS2FnUWsvMEp5K1pVVnFBcnI5Z1Bxdnh1czgw?=
 =?utf-8?B?Nll4UUl3dXl5YWhQQzJ3clNxZHZrZkhCVnJIaXZOL3lJVjZhbllJcmlmcEJs?=
 =?utf-8?B?L2VvcHBaaXg0RHlRSmZHSm9CdUdKZm1qYStDTlVkdVZ3aUVWWHYyay9iL0RN?=
 =?utf-8?B?bDkrTFM3T3ZneGNOeW1WdzRtcFQrT0Nmb2JFRncvUVNDa1JxTStaNmZVeUNC?=
 =?utf-8?B?ajU3aUo0Z2ZkcDZkWCs5VVJ4VSswYnJsOWhKK0VsUHZxRDRzY2VvTTM5d1E4?=
 =?utf-8?B?Sk9LdFJPa29QNGd0amVJSDEzUEp6SUgremdycTVNUGQ3elVFVy9ZRHZFQWhn?=
 =?utf-8?B?dzFxV29QcXRBU012R1MwaHV5OFA1bkU4Rk9mWVdwb3ZOSGFRTUdjNHVEcTRJ?=
 =?utf-8?B?TzRJR3IrOTVXbjR6R0xuZWxLV0FKNEpTdGt4Tzl4L0t3aGU4MExLbEtyTDhZ?=
 =?utf-8?B?bjc1L0ZlVzNFN3BYeStWclhRb0F5VkNqMDBYWC93SHpNUEh4d1BKVzg1YlZv?=
 =?utf-8?B?SDJtNlVhek5JV1FWN2VJb09Iam5pMWNrSWNWMkFhci9DVU1odXlHVkFFSzB2?=
 =?utf-8?B?bU56WHc4SkVoYTlPTHBDSUtkSXZxTW9WaGFiWEpwOVVxb3ZBRjhmMExzcFBp?=
 =?utf-8?B?eTlpMjFYRVJjQkFEb0VWUCtZdjJqaVZrekRRT3d5cXhJK3V4WkVTcnlXOVhO?=
 =?utf-8?B?dmk0QjRkakUvTmQ4VEpXWUU1N1kydC90M1UrRzJlbDdBbVc1YmgwdWJtc2pz?=
 =?utf-8?B?dVZSMUVnbm1GUWRUV0VOb0l1N004RFhlT3hXRlo1SVErM1FBMkdia0ZiM2FG?=
 =?utf-8?B?UFYvdVRhRGREd3J6VkRxMTR5ZFdsWUJUbkJTRDlSdmd1cnRmaUtTQ2FzZUNN?=
 =?utf-8?B?d3VSbVg3UGFRTWRoTUdGTjhOK2Zsd1FwdG1HMmhUclhCNVNmMGU3eTZtRXY5?=
 =?utf-8?Q?ymj8BojYQyk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0IzdkhBcHhralR2MlZkcEprMUt0OHl2ajVyc2s1VEtxOWNrb3FnMGsrV0p6?=
 =?utf-8?B?Mm1pUW8rYkhPK2ZzK3E0N3k5bHN3MWg4VlVjT2huMWg3ZElCbVBWRnR2WUp0?=
 =?utf-8?B?YVRSc2N4S0s4U3JMZ1kzc0R4TklTb2ViSWdmWmtRcG1sZ3QrOUE4aTFLc0RR?=
 =?utf-8?B?ZHhmMlQ0NkNPZDc3NkovK0JKTU5PTjVZQmtocW5yY0FiZGNZeFRsazd5bkFX?=
 =?utf-8?B?THVqSUpBNWUxWUlBczgwVjVBVFp4QSt6VHNRRXVYNkdWc25pdzF3Lys2cy9J?=
 =?utf-8?B?OWNMQnVjbmNzNmtBYlVOL1czc0VvNU14SnoxSUV3NnBVZDdneXVwbG50bzdV?=
 =?utf-8?B?QWtZbWE1UVFzcTNJUTZ3NU1aM1dOdUVUN3l4Nk1RM1hJYkU5KzFJa2JwODVT?=
 =?utf-8?B?WXVXT1ZvaTczaUZCZXdNdlNYOVZuT1lIMkxKTmg2Y3A4RitmZGc4MEFjaU5k?=
 =?utf-8?B?eUZuMDY2bGxuNXZnTzVyU1JhRUJlMW1aZFNvV2dReEtjN2xkRFVpa3N1UnhJ?=
 =?utf-8?B?TDlKNjU1NHZFaWRkSDl0Z08zclhtWjlGWnZYRnVZUEJhMGMrRERNWUM3OGdr?=
 =?utf-8?B?MmRnTjBCWGZ4N2djN2pFWVZYaXJSWmtTSjJVblNQdWxDY3QrQkxiR29YeURw?=
 =?utf-8?B?c2FPaWN2Yjg1QW5zV3lGdFdYcG5zeTZocXlGTGkwNCtSTG95WnJJQkdXM29q?=
 =?utf-8?B?YzViWlA3bkNDUEdZRkI5NFJVcVRUR1JkL3hhRUUzK0RSelpQeHNyYlJmNU1k?=
 =?utf-8?B?bUdPU3MyaUdUU1h6eGtGNS92aUl4WnhoaVlnRWR5QmZESTNhTGs3UU4xeHQ1?=
 =?utf-8?B?SjdaSng1Z2NvR1dhVE1XRyszZzFKazltajlDQmJoK0hXVzV3Zk9obmc1YTB4?=
 =?utf-8?B?QTg3SEh6ZEd4LzdrUE9RQnJpYjNvYVptbDJWTElVbXhiNThvbENHRWIxVWZU?=
 =?utf-8?B?dW9iS280aDVvRCtaNXNpRkVHendaWXVsaTJOS2FHSXNYMWhJS2RVZC9vbEdF?=
 =?utf-8?B?dm1MT1Vtb1FYcVpaa2RuNjVTQXZHYVBJRTlVNlM1SWxSY2tOc2Q2cFU4aTB1?=
 =?utf-8?B?ZDFMZytzUHJvWUlHUEo5bWVaUHo1RE9LVlY2R2xNY0c1SnFUWThGSUxkb09w?=
 =?utf-8?B?NFAybnUvclA2cnM2bUJCVmxKWGlwZHZOVkpFR1h3V0dhKzhIdjFCemUyRVhD?=
 =?utf-8?B?TGI2Z0pobmJBU2hhSGRObU1QK1I0bjl5d0I2MzVjVmJvcXltWjlicG80YjMz?=
 =?utf-8?B?b1FpUWdraTRPWXFxMEdzWUxFZ1ZoVk5tMDIvRDB4RHN3T3NnTWs2STF4ci9J?=
 =?utf-8?B?T2o3UFJ3clVWay9nREU3SmhPRGU0RUhhMElyUHRMUG4xRUhSb0RpODlmQm1N?=
 =?utf-8?B?Z0FUQzJILzZvTm8vbmdMTUF1RldTTkhpd1hzS1lUdkpQU3pMMlZEMHRSSFlQ?=
 =?utf-8?B?UllkZWp4QVVBWXVJbkN6RlJieWxtZm5URzFrOUh5YkNpVGpsSkVtYThaOUoy?=
 =?utf-8?B?U3E5VWN2c2RFdExYdGlRTzRRRXNTdTdHRG8zQllEQVBYTjNkU1BnZGVTalJW?=
 =?utf-8?B?ZkU5bjJNcm12RmpqK3lSVlBHT0VieGRZVUtFenBjaGRmOUxvL045eGowQjdU?=
 =?utf-8?B?UHZrSlhyekYrTmpIU2dCSnlILzBqZ0lCN2NwQktpUnlRcW1iYUx6MW9zeW1m?=
 =?utf-8?B?TVU2d3ArK3dpS3J3UUxuZlk0OHFoQWp5Ykh4TkczbUxYWEFuRlNqdGQvdW5v?=
 =?utf-8?B?Q2wxM0dGY3F6ZHZ3djJhSEpFU25sMG9PdUxmb0F0RXY4Ukc3KzlpOERLb282?=
 =?utf-8?B?ZzMzbFVxRzlwekRxUy9tckc0cjVvVUpuSlhCVmNzd01zK2krVjRBUmRyOXpi?=
 =?utf-8?B?QVl2UklTSHI4cVlFV0VxaTBSQnNUY0RXV3FzV284a2Jhbms1OE50ajVHQnVT?=
 =?utf-8?B?QlZ0c2s0Z2k5VkRwcmhBMWVmaFN4ZnFJWXVCQVBlVVA1OHVMYkdGQzY2QnN3?=
 =?utf-8?B?NGZoV3hHdTB2NUY4Vi80RHAvb1J6QXM4RHh5REpqM2ZFT2VVTzNFWUJtUjdl?=
 =?utf-8?B?YWVlQStkZXlNTDZaSDd0ekNPanBWQ2RoMVN6a0xUb2Q4NGJKdVFLY2h0Rmgx?=
 =?utf-8?Q?RxqE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba638e4a-2dfc-4ca0-5e5a-08ddcfa6e43c
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 20:23:06.0015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5ckhcaI6BIx4pAKFmkmAxZhAiPQfgdpxUkhH1jSjhPyOtbRsjuipvAuUdB7+dNA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9436

Hi Reinette,

On 7/30/25 14:47, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/25/25 11:29 AM, Babu Moger wrote:
>> From: Tony Luck <tony.luck@intel.com>
>>
>> There are currently only three monitor events, all associated with
>> the RDT_RESOURCE_L3 resource. Growing support for additional events
>> will be easier with some restructuring to have a single point in
>> file system code where all attributes of all events are defined.
>>
>> Place all event descriptions into an array mon_event_all[]. Doing
>> this has the beneficial side effect of removing the need for
>> rdt_resource::evt_list.
>>
>> Add resctrl_event_id::QOS_FIRST_EVENT for a lower bound on range
>> checks for event ids and as the starting index to scan mon_event_all[].
>>
>> Drop the code that builds evt_list and change the two places where
>> the list is scanned to scan mon_event_all[] instead using a new
>> helper macro for_each_mon_event().
>>
>> Architecture code now informs file system code which events are
>> available with resctrl_enable_mon_event().
>>
>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> Please add your "Signed-off-by" to the commit tags of the first four patches.
> When you do, ensure it follows the expected ordering
> per "Ordering of commit tags" in Documentation/process/maintainer-tip.rst.
> 

Sure. It appears I am patch handler in this case. Seems like this is a
correct order.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

-- 
Thanks
Babu Moger


