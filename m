Return-Path: <linux-kernel+bounces-896582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7153BC50B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359821896F70
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBB12DEA9D;
	Wed, 12 Nov 2025 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aLZG3Lcs"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012025.outbound.protection.outlook.com [40.107.200.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9C55477E;
	Wed, 12 Nov 2025 06:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762929185; cv=fail; b=oFOGEnAI1Wv7lsCuP7nK0zF953+QHmc+omZbR9O8HvfH0l4EpwTJVV3xkPUVJ7248NUeDDHFCv7kDofTiBth9i+ukfJ5iA2l5fKLYWsjMJtO1pnhhfWd/WGrAwnD2NMNtkCxbkZsG9oBno4mxQn1R6+olDl7k3FPFvfM2vJIXsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762929185; c=relaxed/simple;
	bh=AYtBRC32Q8VrdAS6DGhVM2jJr+Z+SNUhmnT+jUgJb1s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ucb4VE9a/mvoebXqsLHXvww+3sZQBzh9Jrb+wUDnwCKViuR1A3by9ch5MfGetXQGP7aTpIV4ZOo0/4ZhH35s+COLaUJG/c1Usqk2nWLe6gfNAZC3Q5fvLreYc+mWALIqQerHXdDlPswhIq6IZ/R5ZfsB1DHY/uOGEASgo1ssNps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aLZG3Lcs; arc=fail smtp.client-ip=40.107.200.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yqwoou7yxrRWaf5K86NVotZFs9BS61GfTcIddHtuVlIrF6GYagmQBLVnSZ46zc/xEhmUTj1H+OBnoPKKTxb2jDh3o53W294V7xi7+1yUeYRvstGOOEVHPto65DMqbb9PiyEG1JlUtz88TRvd+x1tKuWbkJtCneaLY1tqa/JXHm4uVT2JCXR9L9/HaqiS6NFvAWUXE2K748HqBp+h8OsfUqOGxwH6uNiJkNwXaWyP8N7tVjXGeXsZZjUa5eqB51gsI1QkmAGCJZLrv3e3eky4hFn/78cBJT0yOsTCEuG2wCt3i2G0zV9DcP8lKc1LzP69euVPGItb3045jzIut3Si9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mXcNITZ3j0GhHXnUGOGoadop/LnfUn80poU+ITwUfo=;
 b=aoukt5hHBmC29aEySFpCMK+f6as3kl1p/J1bIi6Fnxtxe4qwoa19jpMgOymGSuu2voCAnvefhpULHNRncJYXW/9MoLccU5u6vBrZUiPK7ZwhWTHY8NHoMI7NxWbGtNNUE9iZ4LROj0tjEgrdny8j5VpDoc0IdyB4vnFGDyJb7zfWaYjy5V6dl+Q0L3pVD3zu27M0RzBsYdk4PnIWOr9f8bPY/Ieq/vj5JpszuKFfb28hb4GpLWYeG2HEfjDO61+14UwGx6R1Gjz8C687F7cwDNgXVvZ2OICOCXWUEBmwyHz3BrymVLm9bcM1hLyRMMP4VOQh00GQM4dgTtJF+ltUoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mXcNITZ3j0GhHXnUGOGoadop/LnfUn80poU+ITwUfo=;
 b=aLZG3LcscE4vzZfDYXB0brGy3s8/VKXEG1pzuIIms7i5Ngdu1mYRCkXYnpicjpXkQ//ysKEjEpyATUIhzL3iaFJl+tIc6Kur7aO1tVewKXNyFLWr0sR8kPpybQcs3NZL1aMRBBIe+AEP/Qvm3AiKJtVfgqOvW6tfcXDRndGs0D8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 06:33:00 +0000
Received: from LV9PR12MB9829.namprd12.prod.outlook.com
 ([fe80::c47f:251d:7b84:e6b4]) by LV9PR12MB9829.namprd12.prod.outlook.com
 ([fe80::c47f:251d:7b84:e6b4%6]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 06:33:00 +0000
Message-ID: <d9afc6db-fd8a-4069-a8a8-1e2d74c1db3a@amd.com>
Date: Wed, 12 Nov 2025 14:32:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] Add AMD ISP4 driver
To: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl,
 laurent.pinchart+renesas@ideasonboard.com, bryan.odonoghue@linaro.org,
 sakari.ailus@linux.intel.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 pratap.nirujogi@amd.com, benjamin.chan@amd.com, king.li@amd.com,
 gjorgji.rosikopulos@amd.com, Phil.Jawich@amd.com, Dominic.Antony@amd.com,
 mario.limonciello@amd.com, richard.gong@amd.com, anson.tsao@amd.com
References: <20251024090643.271883-1-Bin.Du@amd.com>
 <aQsYJhbGifdXhjCJ@sultan-box> <aRGjX1pv0y_lVext@sultan-box>
 <c41df0f5-b2b5-49f1-a49e-8750e55975e1@amd.com> <aRL8ZPwXSeKD4Qmn@sultan-box>
 <e09207fd-1879-44c8-a5c1-838a140dcd4b@amd.com> <aRPH1hV7bEfagPtE@sultan-box>
 <aRPhMCwJjpMqAROG@sultan-box>
Content-Language: en-US
From: "Du, Bin" <bin.du@amd.com>
In-Reply-To: <aRPhMCwJjpMqAROG@sultan-box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4PR01CA0018.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::7) To LV9PR12MB9829.namprd12.prod.outlook.com
 (2603:10b6:408:2eb::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV9PR12MB9829:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4d020f-6ceb-4e39-1f0c-08de21b5535a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2FUa3RldWJOR3N5WHEvNEJlZWEyendOMEpyZUVXay8rU0dWbFBMSklFb2lu?=
 =?utf-8?B?bDhxWDJnWjVlOEpFbFhFOUlCUG5wdG9aRmZmclJhZlIrSEQzZ3ZMN1FrV3E0?=
 =?utf-8?B?SmNxTyswTkk1bHBMT3AyZmdVMzNoTUZ2R2NGK1A0SnByem5jSTFxUk1QT0Rl?=
 =?utf-8?B?Y0VCVkJYS25ZTElDY2JwY0ZtdDRTN0RSbUVJQlhJdVU0cFhZTXpvUEdXWWJD?=
 =?utf-8?B?M1FUMUlXOS9HdGFjeW1RL2RPNlhyanc0dFF1N0hIbDhlN3BIWUNZRVN3TG1D?=
 =?utf-8?B?T2NuaTFzN0tlOEh2cURHTTkxRXY2dkFXLzhYQ1hCT0pjYUs3d1NYbjF0NEtx?=
 =?utf-8?B?SDQ0K05vM2NLc05oVDRBZGN3d0FWMVpMTGVzWUxpdEoxd0NqU3FwbEpaT1Jq?=
 =?utf-8?B?YWtsTDErWlQwVmJsclN0cmpEd1JFMWVQUUtuY3M5b2Q3L2JrU29vNkduTFF4?=
 =?utf-8?B?K0wyemluSzdIZDBwM3FLTERseVY2R01MYW5oSUVzL1kvYU1nREhKb0tYV0tP?=
 =?utf-8?B?cUgxdDZyS3BCT2NtOXhmaWNtNHBlQXVFSXhsb05GMXJTSjBJVTFDRXZqUFVJ?=
 =?utf-8?B?WEZiYVZ3Z2JtUkxvckpGbmdsdTVORkU5cDhKR2YwWXYvNytLdkdZdDN0S3dB?=
 =?utf-8?B?d3VJUGVuYTZhRk5vekxYRkRjSHN6a0htWjl0eFJ1aU5DR1JjRjVSVzlkczZ6?=
 =?utf-8?B?bmxoMTJEQStEbDRDME9yaVRLcEhPcS9xc2N3QUNLWFkwNGVRUkZ6Ny9OQ1U2?=
 =?utf-8?B?azVHZ203bW1RQlRMYVFJUC9TazF1dlpQSDlIRWdyMlVwNnhZbVZkZEN0aW1w?=
 =?utf-8?B?Tkl3ZWIrRFd6aFZCL1lUZXA1ZkkvSzlzcVpLUmh2VnlqMllmMVdTaVdORTVL?=
 =?utf-8?B?VlJGOXMremxzSWFDRURmME5yenpEd0g5SWlHMVhNelczL1QwVjJjQ21TMDUz?=
 =?utf-8?B?bThWMFhSL0xUb2wybStaRmNyUXJ2L0JVU2JkNVZhNGYzTW1hZHVFSDVma3Q5?=
 =?utf-8?B?VExhb0o3R3dxR085MFlRaFlnK2g4Tmw3ZzROcXE2QTF0S2hkTks0cUswd2Fv?=
 =?utf-8?B?Nm4vL3RrbjRMZ3BjV2liN0JNRHJvcENOaWovUGxIaEdaYVJDZGFNWmIvdXdY?=
 =?utf-8?B?UUxVQmp3Z0FaeUFFbEw5eXlxK3A2T01Oa0hBK1NGdldlaytmcFBMMjVHQ0lJ?=
 =?utf-8?B?dFRPYkpxbk55OEtiNHhhVFZnbDZrTU1tUjhnUDFXVDZ4M0doK2FxVXEzSjI2?=
 =?utf-8?B?QjhDSm92ZURmR2Y3eUNyYllXQ2NteUUwc2RwTGRSTVBxRTFzclBIZWN5ZlFj?=
 =?utf-8?B?MUVoZ2hiaFRHaEx2M3hvS3hZQ0J6OGx3ZVdxbFNOOHV1MGN0U2ZPRjFvbnJm?=
 =?utf-8?B?Rm9lcE14T0k3K1Iwbm4wL05oclkwdnp3dm0rd08vRTNZK3h3U0E1ZlBGeUhJ?=
 =?utf-8?B?eW1EYXVlRXBWSUt2cUEwYjZ6V2ZvbVNvSHRzZnJoV0hhUjJrOFZxdVgxUlpY?=
 =?utf-8?B?RlpUNzRkdXV1Q3RCZ0RETWN1b2ZFdVhPUTRRR2pSZng3dEp0ek92aGNBZ2lo?=
 =?utf-8?B?M29DRzRoWWNBOGRzdDdUajh0aVBKdWorRm9JTDAzU3VxOTYzUDZuM0pIb0xa?=
 =?utf-8?B?Q1B1N2psU3lIY1BEa1o5bWlDVG1TSEtSVlZ5bXI4UFl2WWZubTluam96OGVX?=
 =?utf-8?B?YUZvSHk0UG5pV1FDMzlNQVdnSlhReldCdTBYcmxtampDUmpVdkwxcXpudytV?=
 =?utf-8?B?bHlWSlpHdkxId0lhZW51b0ZrQUp3Q3FCaDBObHRCRkh0U3kyR1VmakpvVVpR?=
 =?utf-8?B?SVNZMDJBTzlSL2UwYTlhTS9zZHF4ME5jbExNMlNsTUNFL1NpUVVZOWh6TzBY?=
 =?utf-8?B?cjBKejBaK0FkYVVlZjdHRDlEWkxLUGJ6SWhzWEFjb0htdUg4T2V1VmRVb3NT?=
 =?utf-8?Q?7lqGCh9DEbA2LmHYmedjcuVQVTF3VxZx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR12MB9829.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0hsbDBRZERiT3ltU1pPR2gxWldHVUNzQTRBMS9ValdHS3EwTGtSWjA3V1lm?=
 =?utf-8?B?VWFQWm9XR2NtQWdFRXNxb1J0ekI1NlArZUxucUJkVHlOdWExMGphTXlGd2p4?=
 =?utf-8?B?aXE4U1JMZ1hycUM2RDZhdTNlZDFSbm1lZWVvK3RnSTJUdlQ0bkRCZEQ0R3U4?=
 =?utf-8?B?bGtZc1lTVUFsZG5XUzJhdG1yTzNVbk5IejljMmlLbWZPOTV4Z1E2L3pVQlZx?=
 =?utf-8?B?TGd3YjNIOEQ1S2w0cmx2TE1zSFpmNEQyT1lJNG8reXNldjRBSnQ5a2MwRlFD?=
 =?utf-8?B?MUNGRUM5Y2g5Y0F6T0hGV1dkdWYyZE5HL3d6YWpTclg2a21vdWFKSDEycEZ5?=
 =?utf-8?B?blFac29ib2tZMlhFaGEyQ3lWZlBKZGx1a1kxaTd2SWJINzF5UElHamlwd3Jt?=
 =?utf-8?B?cXRWNmMwdmxGbXNUaXF1RXFXdGFRRXQ3NXJnL0luSmY5dG5DL25nUlczMlZF?=
 =?utf-8?B?Vnp2N3BjNExDL3ZpZHd6WWQrVXplWGJuOUtidXNiOGhMeWJaZ1lmQmxRZHl2?=
 =?utf-8?B?MzZUeEJrd1BqWW1DR3d4M2xoK05lU3B6NXA5NVRxMDhMc2kveEVicXowbzl5?=
 =?utf-8?B?bWV1OVk0YnhhTFd1SkE5SDNXeXlaZ1g5MkQxWnFJUFZIcTVNbXFDd3Vqb3lz?=
 =?utf-8?B?aC9MOEkzb0NzQ25qeEJTSFBuTWdhTkxWdHNrdFJUZms1Vlo3bTUxSUhNaTA2?=
 =?utf-8?B?NzYzMnhvUnJKdGxwUFhNd2pPL1lvU3YvbGxoWTRYTUk2WEJOTmpTb0NXS0Zh?=
 =?utf-8?B?dzhWZjR4ZmlGQncxMUc5THF2bVB6cm43VncydnBzeVZ3NEhreXJNbHFIczBn?=
 =?utf-8?B?cmtFSkRHVno4cWlOc3VxS3A1Z21JSkh5RlNXWENKUHpFbGVrZFJVMmFUVVVu?=
 =?utf-8?B?Zjk2cUJKS2RWT1ZiYVFkTzh4S01DekR2dnA0UTFOYWd1bXJTU0tIUjFzMDJB?=
 =?utf-8?B?TTRmVUEzZGtCSVNRSHJ4WUNleGJuSTV4QW1HNS9YTy9kM3djTXhudlJPTUdR?=
 =?utf-8?B?UVM5MGdGZHQzdDBObGVLSVVzc0pQbVlSNkJKMHFNaGVWb3ZKTVVMekxvbmll?=
 =?utf-8?B?RVFmQUZET1dhUmVkdkZCSndhclJ1RUE0T1AwbWYzdWF1aEpWdHRrWVhqdXp1?=
 =?utf-8?B?ZzZMT1FadU5ja0VTY1h2czBDLzJmMGNaWmFKQ0N6WWhuZ04wYk9RS3R3RSsv?=
 =?utf-8?B?Zk5LM2lCMFU1ZVhVUHZsQlRTemN3d0J2OHkrNkdJYVlvNlFMZGFkSXdRWVQ3?=
 =?utf-8?B?bUFhYW8xeWpVYXBkcFpqMTB1U2U0bVBySzZIQXh4QjNyMGFNQnFmVkxocEk4?=
 =?utf-8?B?eThVbGxMZkQ4WXBOVERVbFhFZ2RIbVMybXpYcGxlenJOdERiTGlQSFlBcDB0?=
 =?utf-8?B?QzZUbi83R2ZlVkNNazJRaXNTYzRSakU4ZnBlcUlvNDRCR1luZ2RHTW4rVlcx?=
 =?utf-8?B?cG5iRmJ1SHljT0pDcVdKMFNEM1k0WkJtMVVnUk1ieEpTbk10OXQ2V01pbjhB?=
 =?utf-8?B?TzFHaDJSOHFBNUZudUJMTENONjFiL2svd1I1bDFYM3VaV2YwNHZ1eitEU3Nj?=
 =?utf-8?B?Zk1IZHZROFFweFVWQXRGL2N3K1pqYURTYUNpdFR0UVVTWEdwUzNPUkJ4QVRQ?=
 =?utf-8?B?U1Q3eXMrVHdDZGFOdzBkTk1NR2JYV09vNHFjL1lXeXZvbVR0cit2T1l5NzZN?=
 =?utf-8?B?N3EwZ0MxTlVLUzA5d0FubkpqbzBGS1crQ3I2OEx6YzJXc1Q2Rld6SUZIUlNQ?=
 =?utf-8?B?NVJyY1RsQWdzR1dRakpQOHRGYXRQR2RoWDdrR3Zwb09uY1RiYUNVSDJBaFNL?=
 =?utf-8?B?dlMyUWh4UjRQVzZTTEpxaWVnYmJXcTFnWTBjN1duQ0MrZjRFT1hUZjIrNXp2?=
 =?utf-8?B?TzJhUEFRclFVT1ViUnMwYzNZWTlDK1h4Ynp1Q0NCbWhZTTFZSGUzcHZqQmlw?=
 =?utf-8?B?aThMdUppaGVVVEhZRzc4TFhYNHQxdFlwb1RUMWEvV2k4c1AyK1UxOFo5QXNu?=
 =?utf-8?B?SVBpYWxJTFRjVElIbjRRcWx4b2dLcUE4SGdOck9HVVhvUUtGTWlTRGFOT1hm?=
 =?utf-8?B?SFY1RWF0QmtWajFSUFNDTk95dmMrWDdxK1J0bU9VV29PMThyajdjc05qMnc2?=
 =?utf-8?Q?Bmxg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4d020f-6ceb-4e39-1f0c-08de21b5535a
X-MS-Exchange-CrossTenant-AuthSource: LV9PR12MB9829.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 06:33:00.7249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: px6l7w3X9xjP2arwAGNW7y3vSIvhvyNekwqT+dy6jE/Og2nAt0SaQjX2sWcDz/WN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075

Thanks Sultan for your information.

On 11/12/2025 9:21 AM, Sultan Alsawaf wrote:
> On Tue, Nov 11, 2025 at 03:33:42PM -0800, Sultan Alsawaf wrote:
>> On Tue, Nov 11, 2025 at 05:58:10PM +0800, Du, Bin wrote:
>>>
>>> On 11/11/2025 5:05 PM, Sultan Alsawaf wrote:
>>>
>>>> On Mon, Nov 10, 2025 at 05:46:28PM +0800, Du, Bin wrote:
>>>>> Thank you, Sultan, for your time, big effort, and constant support.
>>>>> Apologies for my delayed reply for being occupied a little with other
>>>>> matters.
>>>>>
>>>>> On 11/10/2025 4:33 PM, Sultan Alsawaf wrote:
>>>>>> Hi Bin,
>>>>>>
>>>>>> On Wed, Nov 05, 2025 at 01:25:58AM -0800, Sultan Alsawaf wrote:
>>>>>>> Hi Bin,
>>>>>>>
>>>>>>> To expedite review, I've attached a patch containing a bunch of fixes I've made
>>>>>>> on top of v5. Most of my changes should be self-explanatory; feel free to ask
>>>>>>> further about specific changes if you have any questions.
>>>>>>>
>>>>>>> I haven't had a chance to review all of the v4 -> v5 changes yet, but I figured
>>>>>>> I should send what I've got so far.
>>>>>>>
>>>>>>> FYI, there is a regression in isp4if_dequeue_buffer() where the bufq lock isn't
>>>>>>> protecting the list_del() anymore. I also checked the compiler output when using
>>>>>>> guard() versus scoped_guard() in that function and there is no difference:
>>>>>>>
>>>>>>>      sha1sum:
>>>>>>>      5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // guard()
>>>>>>>      5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // scoped_guard()
>>>>>>>
>>>>>>> So guard() should be used there again, which I've done in my patch.
>>>>>>>
>>>>>>> I also have a few questions:
>>>>>>>
>>>>>>> 1. Does ISP FW provide a register interface to disable the IRQ? If so, it is
>>>>>>>       faster to use that than using disable_irq_nosync() to disable the IRQ from
>>>>>>>       the CPU's side.
>>>>>>>
>>>>>>> 2. When the IRQ is re-enabled in isp4sd_fw_resp_func(), is there anything
>>>>>>>       beforehand to mask all pending interrupts from the ISP so that there isn't a
>>>>>>>       bunch of stale interrupts firing as soon the IRQ is re-enabled?
>>>>>>>
>>>>>>> 3. Is there any risk of deadlock due to the stream kthread racing with the ISP
>>>>>>>       when the ISP posts a new response _after_ the kthread determines there are no
>>>>>>>       more new responses but _before_ the enable_irq() in isp4sd_fw_resp_func()?
>>>>>>>
>>>>>>> 4. Why are some lines much longer than before? It seems inconsistent that now
>>>>>>>       there is a mix of several lines wrapped to 80 cols and many lines going
>>>>>>>       beyond 80 cols. And there are multiple places where code is wrapped before
>>>>>>>       reaching 80 cols even with lots of room left, specifically for cases where it
>>>>>>>       wouldn't hurt readability to put more characters onto each line.
>>>>>>
>>>>>> I've attached a new, complete patch of changes to apply on top of v5. You may
>>>>>> ignore the incomplete patch from my previous email and use the new one instead.
>>>>>>
>>>>>> I made many changes and also answered questions 1-3 myself.
>>>>>>
>>>>>> Please apply this on top of v5 and let me know if you have any questions.
>>>>>>
>>>>>
>>>>> Sure, will review, apply and test your patch accordingly. Your contribution
>>>>> is greatly appreciated, will let you know if there is any question or
>>>>> problem.
>>>>>
>>>>>> BTW, I noticed a strange regression in v5 even without any of my changes: every
>>>>>> time you use cheese after using it one time, the video will freeze after 30-60
>>>>>> seconds with this message printed to dmesg:
>>>>>>      [ 2032.716559] amd_isp_capture amd_isp_capture: -><- fail respid unknown respid(0x30002)
>>>>>>
>>>>>> And the video never unfreezes. I haven't found the cause for the regression yet;
>>>>>> can you try to reproduce it?
>>>>>>
>>>>>
>>>>> Really weird, we don't see this issue either in dev or QA test. Is it 100%
>>>>> reproducible and any other fail or err in the log?
>>>>
>>>> Yes, it's 100% reproducible. There's no other message in dmesg, only that one.
>>>>
>>>> Sometimes there is a stop stream error when I close cheese after it froze:
>>>>
>>>>     [  656.540307] amd_isp_capture amd_isp_capture: fail to disable stream
>>>>     [  657.046633] amd_isp_capture amd_isp_capture: fail to stop steam
>>>>     [  657.047224] amd_isp_capture amd_isp_capture: disabling streaming failed (-110)
>>>>
>>>> When I revert to v4 I cannot reproduce it at all. It seems to be something in
>>>> v4 -> v5 that is not fixed by any of my changes.
>>>>
>>>
>>> Hi Sultan, could you please try following modifications on top of v5 to see
>>> if it helps?
>>>
>>> diff --git a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
>>> b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
>>> index 39c2265121f9..d571b3873edb 100644
>>> --- a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
>>> +++ b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
>>> @@ -97,7 +97,7 @@
>>>
>>> #define ADDR_SPACE_TYPE_GPU_VA          4
>>>
>>> -#define FW_MEMORY_POOL_SIZE             (200 * 1024 * 1024)
>>> +#define FW_MEMORY_POOL_SIZE             (100 * 1024 * 1024)
>>>
>>> /*
>>>    * standard ISP mipicsi=>isp
>>> diff --git a/drivers/media/platform/amd/isp4/isp4_subdev.c
>>> b/drivers/media/platform/amd/isp4/isp4_subdev.c
>>> index 248d10076ae8..acbc80aa709e 100644
>>> --- a/drivers/media/platform/amd/isp4/isp4_subdev.c
>>> +++ b/drivers/media/platform/amd/isp4/isp4_subdev.c
>>> @@ -697,7 +697,7 @@ static int isp4sd_stop_resp_proc_threads(struct
>>> isp4_subdev *isp_subdev)
>>>          return 0;
>>> }
>>>
>>> -static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
>>> +static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev, bool
>>> irq_enabled)
>>> {
>>>          struct isp4sd_sensor_info *sensor_info = &isp_subdev->sensor_info;
>>>          unsigned int perf_state = ISP4SD_PERFORMANCE_STATE_LOW;
>>> @@ -716,8 +716,9 @@ static int isp4sd_pwroff_and_deinit(struct isp4_subdev
>>> *isp_subdev)
>>>                  return 0;
>>>          }
>>>
>>> -       for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
>>> -               disable_irq(isp_subdev->irq[i]);
>>> +       if (irq_enabled)
>>> +               for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
>>> +                       disable_irq(isp_subdev->irq[i]);
>>>
>>>          isp4sd_stop_resp_proc_threads(isp_subdev);
>>>          dev_dbg(dev, "isp_subdev stop resp proc streads suc");
>>> @@ -813,7 +814,7 @@ static int isp4sd_pwron_and_init(struct isp4_subdev
>>> *isp_subdev)
>>>
>>>          return 0;
>>> err_unlock_and_close:
>>> -       isp4sd_pwroff_and_deinit(isp_subdev);
>>> +       isp4sd_pwroff_and_deinit(isp_subdev, false);
>>>          return -EINVAL;
>>> }
>>>
>>> @@ -985,7 +986,7 @@ static int isp4sd_set_power(struct v4l2_subdev *sd, int
>>> on)
>>>          if (on)
>>>                  return isp4sd_pwron_and_init(isp_subdev);
>>>          else
>>> -               return isp4sd_pwroff_and_deinit(isp_subdev);
>>> +               return isp4sd_pwroff_and_deinit(isp_subdev, true);
>>> }
>>>
>>> static const struct v4l2_subdev_core_ops isp4sd_core_ops = {
>>
>> No difference sadly; same symptoms as before. FYI, your email client broke the
>> patch formatting so I couldn't apply it; it hard wrapped some lines to 80 cols,
>> replaced tabs with spaces, and removed leading spaces on each context line, so I
>> had to apply it manually. To confirm I applied it correctly, here is my diff:
>>
>> diff --git a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
>> index 39c2265121f9..d571b3873edb 100644
>> --- a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
>> +++ b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
>> @@ -97,7 +97,7 @@
>>   
>>   #define ADDR_SPACE_TYPE_GPU_VA          4
>>   
>> -#define FW_MEMORY_POOL_SIZE             (200 * 1024 * 1024)
>> +#define FW_MEMORY_POOL_SIZE             (100 * 1024 * 1024)
>>   
>>   /*
>>    * standard ISP mipicsi=>isp
>> diff --git a/drivers/media/platform/amd/isp4/isp4_subdev.c b/drivers/media/platform/amd/isp4/isp4_subdev.c
>> index 4bd2ebf0f694..500ef0af8a41 100644
>> --- a/drivers/media/platform/amd/isp4/isp4_subdev.c
>> +++ b/drivers/media/platform/amd/isp4/isp4_subdev.c
>> @@ -669,7 +669,7 @@ static int isp4sd_stop_resp_proc_threads(struct isp4_subdev *isp_subdev)
>>   	return 0;
>>   }
>>   
>> -static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
>> +static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev, bool irq_enabled)
>>   {
>>   	struct isp4sd_sensor_info *sensor_info = &isp_subdev->sensor_info;
>>   	unsigned int perf_state = ISP4SD_PERFORMANCE_STATE_LOW;
>> @@ -688,8 +688,9 @@ static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
>>   		return 0;
>>   	}
>>   
>> -	for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
>> -		disable_irq(isp_subdev->irq[i]);
>> +	if (irq_enabled)
>> +		for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
>> +			disable_irq(isp_subdev->irq[i]);
>>   
>>   	isp4sd_stop_resp_proc_threads(isp_subdev);
>>   	dev_dbg(dev, "isp_subdev stop resp proc streads suc");
>> @@ -785,7 +786,7 @@ static int isp4sd_pwron_and_init(struct isp4_subdev *isp_subdev)
>>   
>>   	return 0;
>>   err_unlock_and_close:
>> -	isp4sd_pwroff_and_deinit(isp_subdev);
>> +	isp4sd_pwroff_and_deinit(isp_subdev, false);
>>   	return -EINVAL;
>>   }
>>   
>> @@ -957,7 +958,7 @@ static int isp4sd_set_power(struct v4l2_subdev *sd, int on)
>>   	if (on)
>>   		return isp4sd_pwron_and_init(isp_subdev);
>>   	else
>> -		return isp4sd_pwroff_and_deinit(isp_subdev);
>> +		return isp4sd_pwroff_and_deinit(isp_subdev, true);
>>   }
>>   
>>   static const struct v4l2_subdev_core_ops isp4sd_core_ops = {
>>
>>> On the other hand, please also add the patch in amdgpu which sets *bo to
>>> NULL in isp_kernel_buffer_alloc() which you mentioned in another thread.
>>
>> Yep, I have been doing all v5 testing with that patch applied.
>>
>> BTW, I have verified the IRQ changes are not the cause for the regression; I
>> tested with IRQs kept enabled all the time and the issue still occurs.
>>
>> I did observe that ISP stops sending interrupts when the video stream freezes.
>> And, if I replicate the bug enough times, it seems to permanently break FW until
>> a full machine reboot. Reloading amd_capture with the v4 driver doesn't recover
>> the ISP when this happens.
>>
>> As an improvement to the driver, can we do a hard reset of ISP on driver probe?
>> I am assuming hardware doesn't need too long to settle after hard reset, maybe
>> a few hundred milliseconds? This would ensure ISP FW is always in a working
>> state when the driver is loaded.
>>

Actually, each time the camera is activated, the ISP driver powers on 
the ISP and initiates its firmware from the beginning; when the camera 
is closed, the ISP is powered off..

>> Thanks,
>> Sultan
> 
> A small update: I reproduced the issue on v4, but it took several more cycles of
> closing/opening cheese and waiting 30s compared to v5.
> 
> Right now my best guess is that this is a timing issue with respect to FW that
> was exposed by the v5 changes. v5 introduced slight changes in code timing, like
> with the mutex locks getting replaced by spin locks.
> 
> I'll try to insert mdelays to see if I can expose the issue that way on v4.
> 

Could you kindly provide the FW used?

> Sultan

-- 
Regards,
Bin


