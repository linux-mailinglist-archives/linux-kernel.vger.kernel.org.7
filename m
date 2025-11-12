Return-Path: <linux-kernel+bounces-897760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C00C53B28
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3DA4A4244
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDFA328270;
	Wed, 12 Nov 2025 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xRxdbULp"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E240633F8D2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965322; cv=fail; b=seOZxTTT9xLjpnfBb6LnVV/c53koJSxHTqFeSogVC+ZtvgXhhTvUJH+S/6rAsQG4+69BbANhF1H+HzPsB6K9GyE0SQ3mFvbgH4Rnfn8Vhfw+u61Atypifl9eR9GvNtY0WW0Plgk0VVIlyuee27Pxd2727ZfvcDec2GXO6ZjqbIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965322; c=relaxed/simple;
	bh=BtAXXmFOfILVF5VZS8J+8J3qBG7SblcLPmfBjp4B9BQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AGniJiFdIUm/vmsxtHabnLeFoLCXQS+rFyUEdAtI3/QmDKHcWsGw5WwuW0nqNn1gFAKUJWZO9ivC/zbAwbxmTwkjMBBF+DZ0ySYPoZApWKQE0j+lSRWZ9WNK9K38ydbkA4VYyrQEQ2NMgFQaFyetUKwZY8cemhyap1IEMjXojwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xRxdbULp; arc=fail smtp.client-ip=52.101.85.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAEWDF77/SAZSpaRd5itfbm4BaI66/CLjP06soh4PT2E4QHlLNKRGFEXqMDvfu73ho5vDOEo8Z62IYjkGMI1a90YqxenNyB4NkIwYxndp5La+NCbWr168OicnvJsv/gye4tg2OMcT6IbbA6GbYXFAtsRjGWl4ll60BzkO6grNEH2leHzt82F7IilkrysigDxh+QScGvDZ7wFfhc96D6fcIdMdyMc2EZhT7VtM3uDhUZUDn2LW1RE8sfjXQ7l3w3v7v4qFMsRP62yCDUxVllRFDf3F80wSzcKd5qlkFbKtuSMHaYfRFE873woWeK0S+YuiUXZxpMKyhjsc8KaUhzsqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofGmSPMchcf4pjczokQ6HkV2b0gvm1FDoPmGbIVt06o=;
 b=G2lvObF55F2rspplxHKpveD91Tj8ir8q2jaRCfrfaB4J7blQ7CEtxDdvDsKUi8ESVjxZdLMj3KAaRLR0M/pVGZLiwxrIrcyLRLZkMepihfR9ncfy1eofyTW0l8t5fOkJmyIa2jJl8qM3+c2T9HPg/QSQLqo8jNv3iNpDCrT2Vt88DL5t7dZ31ip0iXxx5HfmVk9TSs0B4Bd2LQbGXOYAyqV6cpjGDeFFN8KaD6bF9M3w6+UYEpF6qNCy+4Q2LcdJD7+igs39psS4DzrhZxLsMhib0voOfFSffykoSMhnn8qTVZzfeXFzaJhWkVHvhwco95D37keyljPjUw9Gv+QAFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofGmSPMchcf4pjczokQ6HkV2b0gvm1FDoPmGbIVt06o=;
 b=xRxdbULpQMMBjqiUdl85eOpz2hFkKhofSrJPPQKyjdD4UZzzvONUC3AA0WImwyEvwh6MkM4sdZPWqXsPKqAZEY4STVxvVCWBFop9wPUBpUVtdwMEVIQ05ICs/LlFghKV1hD8v7KHkJkLb8NzN8LmP2kE3gFqOWh+JOtZrD0WSOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB9219.namprd12.prod.outlook.com (2603:10b6:610:197::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 16:35:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9298.010; Wed, 12 Nov 2025
 16:35:18 +0000
Message-ID: <c430ae05-74ca-4620-bb11-ff40d2eb62f6@amd.com>
Date: Wed, 12 Nov 2025 10:35:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/acpi/boot: Correct acpi_is_processor_usable() check
 again
To: Borislav Petkov <bp@alien8.de>, Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Michal Pecio <michal.pecio@gmail.com>,
 Eric DeVolder <eric.devolder@oracle.com>
References: <20251111145357.4031846-1-yazen.ghannam@amd.com>
 <20251112135618.GCaRSSAkqagSF_gr9j@fat_crate.local>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251112135618.GCaRSSAkqagSF_gr9j@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB9219:EE_
X-MS-Office365-Filtering-Correlation-Id: 600f33ad-91ed-4718-0f56-08de220976de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0x2c1N2bGduZ1JIVytncEtMUlpsbTlZTDdhYk9ta3FDaHNtQUdOOElpWU0w?=
 =?utf-8?B?aU5LenE5VC9PMnVLdTNsbEx6WkNQeHZ4OXRDNVh2UU04bHNCZUJYekFCOHZt?=
 =?utf-8?B?Q01zWVZQeG1TaGV2NHhTVitIbE1hQ0FJeEFDYjdHVUtDVkJtTEhXclJyMjcy?=
 =?utf-8?B?QlR4YVB0bWg0RnlnQVNSUlg4RkRyZERyT01TWW1pOXRBY0lXN2p2YWY1TFhs?=
 =?utf-8?B?QUtmazJLSjZHRjJha29JTjRlVlRlMTZja2p0UWRCL1ZvVzhSVmZJYVJMTkZv?=
 =?utf-8?B?Q0xPNHB5M1BmZGRCQWM5YjZyWU01U1p2UDV4M01rMFV1WlhFZ1FmMlE0N0lT?=
 =?utf-8?B?NTdYQXlLRnFxazJIYTQ0QkcweU8rcTJLQXM1THdyVmxhbmxVa0laQjIzQzdY?=
 =?utf-8?B?Vlg3ZnNsRG1McjdSZ0RtRHE4QXoxaElTdG02U0dmQWM0R2lYNjlYRnhnTFZ6?=
 =?utf-8?B?dGRDS0RDSHVFQm1rdy9lS3lTRXZJRlcxajA2SkdUenlSRElvS0FEZHRlYVlX?=
 =?utf-8?B?Rkxod0VaR1JPOUo0bFFRaE1rS2ltVWM5QURDR2d4ZGZVOGdxNldtYi9BejNC?=
 =?utf-8?B?MWxOenFvQ2p4anU2NVBVSXB3bmJ1QnhweDVrZC94aE9aS1pVeFZvampqSVVM?=
 =?utf-8?B?ajhOQWFQVVRjaHdYcEJuWWo1cjkySmtjbmRycWs4VVV2cGFkeTVWM2NDY1Zj?=
 =?utf-8?B?R1dFUTBvQ1hCNXdidmJ4aWpLSWZESzVyK3VTK3FSZ3JSOTJTWUtpQlc0dVA2?=
 =?utf-8?B?eFhkQjFRd3R3dnN0dUlyUUNNNnNyTm9FQ2F3UVZ5Wmw5RlRxdlVHVlJaMWtT?=
 =?utf-8?B?OEc1NURoZlp4eXl6OTRKNElsUTRYbi9MVnV3ekRLeXVlUGlUdFF1L1pJN2J3?=
 =?utf-8?B?L0c2aytuL1JyQjBzQVN4Ly94Wk5VdjNod0hveDJudkR6elMzU1l5OWp1QjFH?=
 =?utf-8?B?aEdXOWdqaENYdkhUUGN6SnZzZkJoZzkyYWYxUHdkZlJpclNKZDhZcnp3T3dj?=
 =?utf-8?B?b3J2MEZFdWltWWlyV245aGlmR0ZQTWZjMmphVUxOc0JkdVRDeGt6cGM2RGZT?=
 =?utf-8?B?a1F1VGpkNStLVCt2QkltYzlJbDlHS0czZWVFL25YYmVMazdBMVBUdzlvVjB4?=
 =?utf-8?B?UGk4NlR1RkppZ3FlTUpqSUk0V080RDJlMzR3TEN3b1A2MlY0SVhwRjNLeG5Z?=
 =?utf-8?B?ZmNrcmdHUXEzZnN2TXhYUGE1d0MyZmdZQlE3S0UzWkptUTdURXczTG5xRXp4?=
 =?utf-8?B?SjltZ01scVhIcEkzcm9UODNVSHo4VSs3L2syQXpGMzhuVHFvck5HaTNYdDdJ?=
 =?utf-8?B?anEwY3AwbERPVWhNOUl1SURRTWFKQnpham5Qa2M3UjBpY3A0R2l0WGdoZWVF?=
 =?utf-8?B?aU9rRExMM0tLUFo2UVBwNGVBczFYZ1Y3b2FyQ0o2cUpXam4xK0JMUTZwc2RK?=
 =?utf-8?B?MXVUelN3L3d5UHVSNDQ1VzVwL2tTREJENGVSNzZIM25IcnBPTUtJT3NZL2Nk?=
 =?utf-8?B?am9DdFRQRUxpWVd6dFhQNFRhUDRieE42SWcvTmhPc1IyVEpTWkFTdVRLMTJU?=
 =?utf-8?B?YjFyd2FCd3kwQ2I0bUVWejIwRldTM21HV2hhakxzUjFrOU1KclRjeWEvc0FN?=
 =?utf-8?B?LzdaNUFIdVdEUkNSRmI3VFlkbTd5WmpZWWNBMm5PQ2VjeHVGZmhTSFNVbGtr?=
 =?utf-8?B?WkRnMnU4ZjhPRkUxRUFKQ0M0TmtlbGZENWV0dlUrK1JFblYwNVNNTmppbDFB?=
 =?utf-8?B?NkQrbk1lckxFWm1UZjNwc1lOMkNJNitXWUdTZjBudDhEamo4aE1qQ0RLTGlu?=
 =?utf-8?B?ZFM2MisvSjlCZnFJR0xTUTVYZUFlU0UwTE1xd3dxMkV4QzMwemtsdlkvVldP?=
 =?utf-8?B?VGdDWWhYalUwOW5GMTFnL1AyZGgxcFZ0Uy9UUGVjcytISnRReVdzUGtacWZs?=
 =?utf-8?B?TFZ4K1NpYnJEVFptSWxZTlUyZnNmNi90UEtyRUJHaUd4eXovNTgydzNCUU5B?=
 =?utf-8?B?cVJ3UnhYTjNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU5qOU4yZmNUYjFUUGJBR2E2SVpUNkNNclVObkJWSlpaL293UVlXYWk1Y1Bo?=
 =?utf-8?B?ZmtoVkxIZnBIOFVWSGdpZXdBT2NpZFhlalN5WjlQV0hOZUhnMlpLSlI4Q3lv?=
 =?utf-8?B?a2hqL2phUlNTMXVwRWhuVlk5Q3VGSXcrOW9melkweW9HdVdVbHVQRVNNQSs1?=
 =?utf-8?B?Q3IvRVU3cTFFQmRCdVF6ODNEN3B1Q1FrR3B4OTRHYUVRbW4yVEFHVzIzQ1Yy?=
 =?utf-8?B?M1drdlIwTUdTVE1xblpFMlJ3SnBNQUFPYStFUTJLcnhwWFNJTFlET0gxaHVE?=
 =?utf-8?B?MXZ0TEZud0dMSnRkY1MrRk5RZis4WmpFM01hb2JpTjl1L1VHRVdJTFB0OThw?=
 =?utf-8?B?NUtvVUU1Nkh6NzZzcXVoRHREalB1MW5kUGpwUmpad3ZpbGZNTFAzcmJvTWp5?=
 =?utf-8?B?b3QzY3VxQm5zUzNCeTZQWlg4WHo2OE93NFBFVlM0TTZiUmdZMitoVTI2Sy94?=
 =?utf-8?B?M09zWDZjaFZWaVNpKzBleXIyQlQ1Z2diSkZUdnJwMUJEZ3JDb2ZWS1J5S2w2?=
 =?utf-8?B?M1R1MFVaNEZlR3g2QkRhcHdTWGhuNVZ2VHVzVU52ckVCd3NVSENhcHNJTElv?=
 =?utf-8?B?aXJqaGJUdUdXSDBBZkVmbWU2Uyt0RXhWU0ZmNTExS0R4UzlCODhIQTlITzV0?=
 =?utf-8?B?VjVCZFhXZ3JLQ3pLRXZPTTFBRHdhVlFjZ0lVV2did0FRUm9URXRTRG9RSyti?=
 =?utf-8?B?NG9ncko2Z0tDakdyMmtaRi9pZVhBaDMyOFZpMExXcnR6a0Z3SDJyYmd6R3Zw?=
 =?utf-8?B?NEdmN2NNOEhxcitMUmhlU1FnbVlsTGlSWjZITGRSVmZnd2QrVEtxemtvVGQx?=
 =?utf-8?B?eUdJUng1SEFNNEJQYW1xWGdyUnRLeXpjVnFPMHB1VzBmTmtsNW4zdjdud25O?=
 =?utf-8?B?ZXdVR1gvb0k0V1NlVkxlbE51dTQ0OFBadVVyMVhoT00za3U0VFRnK09wTGJq?=
 =?utf-8?B?TXJDN1kraXFtYXJkdHdmamlrdldBc01BdXFPS2s2V242WG8vQ2N0VnUxUm4v?=
 =?utf-8?B?WWM3MGI3WkZqUDhIUE14aUlnc2NYSFF3bGI0V2E5NjdGS3FnWUZ0N2kzWS85?=
 =?utf-8?B?cm1ydHVVUEVKQkhlc1JBSmtLUzBLWDdqZG9TTGVYK0NhMTN3RTVMeUNGQ0Va?=
 =?utf-8?B?U1psbjNXY2NqYXBwR24zM1E1ZWE2dXhlQzE5QnZyd0t6eno0ZVh6UHZjZWhD?=
 =?utf-8?B?N0VKeHViZTRmVFdUT3ZRV0VXN3QrbzM4NGNNd2ljTnAraEc1YVRjYVo0eWlN?=
 =?utf-8?B?RFo3RkFHUWZ3S2lGM2xpOHlCZjdXcEpuaWprcysrRW5kMUxsblloSkUwNjd5?=
 =?utf-8?B?RlNyMWVNT1BCWEJqYW8zaWRxNHppNFYra2ZXUnplNGhhQm1tNDVidzZBZml3?=
 =?utf-8?B?QWUyZjI2Yml2bDVLV1BaYmM3QlIvbDVTMDlldXNoMWR3RDVkZm0zbVJUaWM2?=
 =?utf-8?B?bWlBSDhobzlTb0IrZzd6OGFwa3BnS3o5by8zVGtzM0ZqNUI5K0RXQ2d1dHl6?=
 =?utf-8?B?eFBWc01jOXlMQVR0VDZSN2xRZGFvd1JBUW54WWpXdnlmbmtMNGFuK3hMRjh0?=
 =?utf-8?B?VmdyRyt6QmZCNXM5UUQwVjRIRHZFM0FkTXhiUGpJeUhjTEY5YzlieWxkTmhs?=
 =?utf-8?B?Z2RzR2FYdGQxSEkvNzQrZENjYWhGS1gzUDFqbmlkcVFsM0hTVVRLdmRpL0tt?=
 =?utf-8?B?dkpPTHh0Y0pSbld5TUc3cjY3YkZlQkNnNDFURlNpNXlHVXFISDZyS1dQMEpE?=
 =?utf-8?B?TFFZRDZjNWVDVHZjbFU5ZVBDejdxczhQWTBtczJjYzBkYjRvK004eElVNkFs?=
 =?utf-8?B?dHJqYm1ZYnJGMGxEU2dNMjBGd2tYR2VyUUlFcEFYMjk3SGdidVJZK3ozajFM?=
 =?utf-8?B?WjJMUjM3NUI1dDFnKy9tQjIvR0crQ2VQVnVkWmlnaVltUkZQRWFlOVFQd2ZO?=
 =?utf-8?B?eHZzOXlhaTNFY1AvS0NuZWJFVE1aaHFyMFVzWlB5OW1BZXRhOEJiWTRWczZK?=
 =?utf-8?B?bTZUQ2xNSG54RXN5VGVqRCs2NnRQYmhJQU5XS2psQmFHSlBZMG1yeFlJMExJ?=
 =?utf-8?B?bjNURTVORzA3OXMzbmE4Y09sUk1yMUlDbG13dVIwcU1qMVRreEplSDhHakdn?=
 =?utf-8?Q?eKhOGlCKTu4WfJrt8N6ZvfVCL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600f33ad-91ed-4718-0f56-08de220976de
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 16:35:17.9723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NM+cwoUdDXOMDg0F9/s1XVh8cSdLNaUV2cArfaoeYwMVrRfQr27CSEcBKqWyUfXT+FL9/yPjWSYPPaD8SVB+Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9219

On 11/12/25 7:56 AM, Borislav Petkov wrote:
> On Tue, Nov 11, 2025 at 02:53:57PM +0000, Yazen Ghannam wrote:
>> ACPI v6.3 defined a new "Online Capable" MADT LAPIC flag. This bit is
>> used in conjunction with the "Enabled" MADT LAPIC flag to determine if a
>> CPU can be enabled/hotplugged by the OS after boot.
>>
>> Before the new bit was defined, the "Enabled" bit was explicitly
>> described like this (ACPI v6.0 wording provided):
>> "If zero, this processor is unusable, and the operating system
>> support will not attempt to use it"
>>
>> This means that CPU hotplug (based on MADT) is not possible. Many BIOS
>> implementations follow this guidance. They may include LAPIC entries in
>> MADT for unavailable CPUs, but since these entries are marked with
>> "Enabled=0" it is expected that the OS will completely ignore these
>> entries.
>>
>> However, QEMU will do the same (include entries with "Enabled=0") for
>> the purpose of allowing CPU hotplug within the guest.
>>
>> Comment from QEMU function pc_madt_cpu_entry():
>>      /* ACPI spec says that LAPIC entry for non present
>>       * CPU may be omitted from MADT or it must be marked
>>       * as disabled. However omitting non present CPU from
>>       * MADT breaks hotplug on linux. So possible CPUs
>>       * should be put in MADT but kept disabled.
>>       */
>>
>> Recent Linux topology changes broke the QEMU use case. A following fix
>> for the QEMU use case broke bare metal topology enumeration.
>>
>> Rework the Linux MADT LAPIC flags check to allow the QEMU use case only
>> for guests and to maintain the ACPI spec behavior for bare metal.
>>
>> Remove an unnecessary check added to fix a bare metal case introduced by
>> the QEMU "fix".
>>
>> Fixes: fed8d8773b8e ("x86/acpi/boot: Correct acpi_is_processor_usable() check")
>> Fixes: f0551af02130 ("x86/topology: Ignore non-present APIC IDs in a present package")
>> Reported-by: Michal Pecio <michal.pecio@gmail.com>
>> Closes: https://lore.kernel.org/r/20251024204658.3da9bf3f.michal.pecio@gmail.com
>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> Cc: stable@vger.kernel.org
>> Cc: Eric DeVolder <eric.devolder@oracle.com>
>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>
>> Notes:
>>      Link:
>>      https://lore.kernel.org/r/20251024204658.3da9bf3f.michal.pecio@gmail.com
>>      
>>      Hi all,
>>      
>>      This patch came out of the discussion above.
>>      
>>      A number of folks (myself included) understood the ACPI MADT LAPIC
>>      "Enabled" flag to be potentially used for CPU hotplug. This is
>>      explicitly false based on the wording in older revisions of the ACPI
>>      spec.
>>      
>>      However, this understanding is used for QEMU. Hence we need a check to
>>      differentiate the virtualization and bare metal use cases.
> 
> ...
> 
>> +       return (lapic_flags & ACPI_MADT_ONLINE_CAPABLE);
> 
> Superfluous brackets.
> 
> In any case, yah, I'm going to queue this soon but I'll give Eric some time to
> complain before I do.
> 
> I did play with:
> 
> https://www.qemu.org/docs/master/system/cpu-hotplug.html
> 
> and that works with that patch:
> 
> $ ./qmp-shell -p -v localhost:4444
> Welcome to the QMP low-level shell!
> Connected to QEMU 10.1.0
>   
> (QEMU) query-hotpluggable-cpus
> {
>      "arguments": {},
>      "execute": "query-hotpluggable-cpus"
> }
> {
>      "return": [
>          {
>              "props": {
>                  "core-id": 1,
>                  "socket-id": 0,
>                  "thread-id": 0
>              },
>              "type": "host-x86_64-cpu",
>              "vcpus-count": 1
>          },
>          {
>              "props": {
>                  "core-id": 0,
>                  "socket-id": 0,
>                  "thread-id": 0
>              },
>              "qom-path": "/machine/unattached/device[0]",
>              "type": "host-x86_64-cpu",
>              "vcpus-count": 1
>          }
>      ]
> }
> (QEMU) device_add id=cpu-2 driver=host-x86_64-cpu socket-id=0 core-id=1 thread-id=0
> {
>      "arguments": {
>          "core-id": 1,
>          "driver": "host-x86_64-cpu",
>          "id": "cpu-2",
>          "socket-id": 0,
>          "thread-id": 0
>      },
>      "execute": "device_add"
> }
> {
>      "return": {}
> }
> (QEMU)
> 
> and dmesg has:
> 
> [   33.281150] ACPI: acpi_map_cpu: cpu: 1, physid: 0x1, acpi_id: 0x1
> [   33.289650] ACPI: CPU1 has been hot-added
> 
> But man oh man, if this ain't wagging the dog I don't know what is - we're
> fixing the kernel so that qemu can hotplug because, oh well, "but then there
> is this thing called reality^Wvirtualization which ruins everything."...
> 

What version does the MADT in QEMU report today?  Presumably not all 
virtualization solutions make this assumption about this bit.

IE rather than clump all virtualization should we just detect QEMU and < 
ACPI 6.3?


