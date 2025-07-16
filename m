Return-Path: <linux-kernel+bounces-732913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026E8B06D9E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D263B19CD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BD027A444;
	Wed, 16 Jul 2025 06:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ELr6dfVw"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C56A272811
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752646005; cv=fail; b=s1ODh0exl685ub2Xlc4HPTteScApIrbHVjAQXH+Wp5UIW+LM7sREyqieKHfjedf1nX9QKn+bi9czbYWGD02zBCLr/Kx6n7Oi/MiYfx5rjWQ98+rA0GAIsUbxLKF1EENbx2XPsyfstvzMtOyB02bUCSEnBRaVMMtZqleug3pyS70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752646005; c=relaxed/simple;
	bh=JERniFdh7yFyE6eA/VC13bdZrAIsyKlqwLpSe0990JY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jf3F/eStUPOPGiOdnyucg7VK7mYeNnxMcnzQEHh4NNgZv0Z6yn0Y4prPJjYjjxtKCCeFEWeCeZ+sOUiJkJe+G8kSVsBR+Fd8hCh7uScGAMVMGIzDD0/aLR8N5JhLyLr71S59zcFE1zghpNOaHDdpXGpAc5OA1TsU44UhM56MALo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ELr6dfVw; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZZIF1fos30MNTtX6Bc4eKoE+l81DQnpz72lJHyjNDsJHRbeXW2+PDycMNan6VwG2uMfHuDi+XdWkjS0lUW4C3FyRd45SA6nJJRNpBfZWzJUPTRxKUq6cD3W7Cs4gWXcURBTcQwhOB9Gk8ZEjyPn85bRy7oJzi6kwQjm4JPBKUZreHdfuUoLSe2FpWYtVExzEG7EvJYaxqQJxVBYfK0cH+3K+CuKonbEP3yts6mdM5NWxiY7ZNworts1GSfHUB8x24iUUWmHVwcKXBjVBnWRRO14ZEeGOu6pf6Hvgapmr2F+PlzbdpARrbkTANq3QgGBMaGyBWBCCRqkDZ+NQQMI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9ZSq30DiOzkvGeV8UGz/ykHLTWtyrA0gD0ARlSd6lM=;
 b=WxvXT/8Vg+hemmUwAzNjhnefrRa/JIadEhY8iJgOI6luEaKFTYNSolSLP4R0WZ4Of2S1GNrd1d6RpCq6bWpIWPJ9Bk1xdgUo10Ax60WwjPZm4lTie4b6LWRfvvhUUlPtUeglrvNgL9R7q9pjBpJsuwwqAj+RrP2AGnz8JqB+Cry54MR1onWcNnDekFEl/+3wxaTUvfxeXURmJ4tE+aUTsl7HFQbEfJvJmxhbqeGngL3MjvjVu9BY/meUXprgy1h6Ay4ypjJR4AFCCYC5NzC/EGkC32iLfee0CcCZqNQtZuZ1tJPWReErv7MWbbfrbBIa+h6V8B66WvuFbYUJpfoS8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9ZSq30DiOzkvGeV8UGz/ykHLTWtyrA0gD0ARlSd6lM=;
 b=ELr6dfVwLRDA1jhF6m3WueHn6C6w16vj36d43eAf9kfkP69sb52tALOdFOralHD1SAzY71UjnrfmpG8PXd1O0xqwZ53Tq+Oc6w5yHD3xbUrWSnIW7/hnSI9rV9H0Fd1S5O2c3QaX1WXwGUKS1ZeB+wsYL9cM2CmJf8ce0Gz+wk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 06:06:39 +0000
Received: from CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42]) by CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42%4]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 06:06:38 +0000
Message-ID: <b49ef6cd-78b4-49ee-95e8-3105ac54e7d1@amd.com>
Date: Wed, 16 Jul 2025 11:36:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] sched/psi: Optimize psi_group_change()
 cpu_clock() usage
To: Chris Mason <clm@meta.com>, Peter Zijlstra <peterz@infradead.org>,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Ayush.jain3@amd.com, Srikanth.Aithal@amd.com
References: <20250702114924.091581796@infradead.org>
 <20250702121158.350561696@infradead.org>
 <0d86c527-27a7-44d5-9ddc-f9a153f67b4d@meta.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <0d86c527-27a7-44d5-9ddc-f9a153f67b4d@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::12) To CH3PR12MB8658.namprd12.prod.outlook.com
 (2603:10b6:610:175::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8658:EE_|DM4PR12MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: 639732d5-5d30-4912-9aa3-08ddc42eeccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUtqN1lIR2JueHN0cmVBUUhEd1BpaXNLWXByczBPSzhHOHNHNkFWQ0Yvemlk?=
 =?utf-8?B?aGRnOGh4VlNkVkJzYmNMMmFRNTdDaXluTzNOTVpUOGROaUtJUWhwWnZRYlJu?=
 =?utf-8?B?SDVLSFRwN3BIMkhaa3I3S3lzSlNNZXA4Y3IyZHhhN0Z4eWVQaVduZGJDNnU1?=
 =?utf-8?B?ZWRtcysxd2ZzcW9SVlFTd0ZSQXY2bVRFa2VXODV2K2ZWNlRtNFlJa0JtVVdx?=
 =?utf-8?B?YzBTV2ZYaW50UXFhYWlERndGVDkrejZ2OU0rMmlyeFhyL2FaTTFLalFiTEhE?=
 =?utf-8?B?V29IejJQbldsZUZscis4N2dNZGN1MlgrQlZZMEx3d2Z2bktuV3pWWWIxMmhO?=
 =?utf-8?B?MzB1RWcwWmRrS2hzNGF6MytNWk1Kd2xzQ2RCL0p1VVh2Tm1kazlMM091TGlS?=
 =?utf-8?B?RnJaRUJ5WENMRmZsN0h2SzNkcFJvd2VMaDFxU0JJYzFub3JUcnkvbTJEOElo?=
 =?utf-8?B?eXl4K0kvUk9lRkE4ZTd0ZGc3bXpMMkk3YkJOSGxmT0xaSWVWVHFRSU5jTU5k?=
 =?utf-8?B?blNnOTNmRnFzd096KzlFNzJhR3BER2VzMzFPeE1qTkFudExUK0hOVkxiU0NT?=
 =?utf-8?B?NzBYc25WODdzNjJnL1VidUV2NUd0bWZiWmNIVEpyVjRMR0RPTDFtTzZ5RTJh?=
 =?utf-8?B?VytONkhtbnorNi96a0Zsb28zbzROaUJxMG5YcVZCL0pPcUtGcGtJMzFEbklu?=
 =?utf-8?B?V0s3eTRQdjhMVmxDMEZYRnNJSFVCOTBWbTFGNUNwMTM0YzRGMHVyVHhCL2Jv?=
 =?utf-8?B?RjBpaWdJVXNqd0NhUWw1cUVqeUZ6MjhYU1B4QzIydHQ2SnFSd1BDV0o5dm8z?=
 =?utf-8?B?QXZzY3pJdDVMYnlHclJhWTAwTjhxckQ5YytpSGgzN1RUOC9HVVdaOW9lN2FM?=
 =?utf-8?B?TzZ6RnNXMnkyc3hFK3FIZ1g4aHJJSThLRWE5aUUzZWMvM05nYkExUWd4MWtM?=
 =?utf-8?B?R1RkUkFSWXZZamh2S1R2V0VGc0F1MUxvWnppWFdGaW92eVNUWktxa0dIZnp5?=
 =?utf-8?B?UTd3dkpXdC9VYUhJa01Zam5lOW5CQUNDc01YTm5JUlBxbmRGNlN1ek1laG9j?=
 =?utf-8?B?U21IOTh0YVh0eGllQVJUaERPZ3ZPczhoL3JqbWwzdjIzRDVQLzZ1Y0ZtYkk5?=
 =?utf-8?B?VVNEeWYxcWg2aDhTNHRyOUNFQ1BFcG9kaW5LWC9yQzNOUTQyM2U4S3Z1TldP?=
 =?utf-8?B?Ti82YkhPWWtTOVJQQkxrTTJqRXltVTVLam56ZDhYZTZzL2pJNzE1VGFrTXVs?=
 =?utf-8?B?emNKV0JpQ0hJTzc3N0YwOUMyMFQvdnVjRTlqY3Vzb3M2dUtPNjVzdmxwRkxp?=
 =?utf-8?B?SkN6RlpkYm1NWGxmS253d0V0VXU4OUtDcDY1WFk3NlRtZCtIWE5YcnM2OUhN?=
 =?utf-8?B?TmRiTjUzT3FwWisxR2xIOWhET2NCbk5nNU91VGd4VVFBWktxOTZXQTZJS0tM?=
 =?utf-8?B?dnB0VzBRem40a3YxU0ZGQ1AzMmFpQlR0aEpzVUl3aEJ5V2ZZV0x4eStiV3Za?=
 =?utf-8?B?bjRqd1JDYS9MUjVCbEwveDNXVDErTDZwK2h6R3RiK1l2MkZCd1FmMENRaEs5?=
 =?utf-8?B?RGFxNzBxUjVOTmtwSTFSdlgra0RaWVBsd016MFBVeVFua0hRbVJwUWMvci8v?=
 =?utf-8?B?OTFUOHp5Q0pjOXBZUU1sOCsxSmNIMit2R1Y5L3ZXYUlWc2twMHhxWWFkZE0v?=
 =?utf-8?B?MTZkcnpDL1NkNjZQUGFsaGU2Nk9OS0xlVHlxd1FCYjNRNHVYSXF1dzlPSWh2?=
 =?utf-8?B?REtZL2xqQjRLTCs3M3RJUWloZFRmMU9NRlArRDFETlV6N1dtbDIvUTBDUnVo?=
 =?utf-8?B?THZLZzBiK25IVCtRdnRrQ2F4U2RPOWZtV3BrVm5wQlhFanlYWFJGb1NMU0Jp?=
 =?utf-8?B?b3krQzdEZ2RYLzVLRjFtNjhsQ0VRenV3dzBlaEZSR0Z0aVVTTThuT0FNbk1W?=
 =?utf-8?B?a3hGZ1pWWFVtMHpMMjNqSm9yc1RoVjlvRys4bGplNFd0YlUyaGNUUThIdFZV?=
 =?utf-8?B?NDF6MTljSy9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8658.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2NVN2dWamR2b1BYanRWZ1ZQaEU4dXAwNit5Qy9QQS85bkZVY1lkMlFDYkxw?=
 =?utf-8?B?NnhHYWtmT2FRTXRxYkpaWUVpY0h4SEFtNTdQa3ExdkNhTVVMME42aGp5clJ0?=
 =?utf-8?B?RDdQOEMxbkRZb3VvZk9GRE5YSGlscDMzUlp3N2NHcUdQNFdBWUNHalR4dXk2?=
 =?utf-8?B?WkpZZ28wWG9yMW0vVk1zSUgrbzNZb2JWd2NWdHhORUJMU0xTYzRlU0NXajBp?=
 =?utf-8?B?aXVJVFRjQWVmZVdVQ1U1amJhSXBzSVlLcUF1TzJnOTlieWlPRnJnN2RiUDNZ?=
 =?utf-8?B?RURzM0kzZ1RKOHZxQmdPNnArM1hiMFIxL0YwVUJwcGxGM2R2ckN6ZDlMVTBq?=
 =?utf-8?B?cGhXWWVldFNkUDdqd2VWU29US3EzYjZubC94TFFBbjBWR2t1dVNoVGQ0b2tM?=
 =?utf-8?B?LzZ2V2ZZR2xzanI0eEc3WlFQQ0t6TlBoOFZnei81Vm5tTlVpQ1JEMTRTVVZ4?=
 =?utf-8?B?ZE41QkUwalNyVmtMT2VqbHZsWmtiQm5hL0dEc3dFVkNPM0xZaHlLZU12V3hk?=
 =?utf-8?B?T2JiTDhEa3ZFdGVBeHpBcGtSYUxmMHc3QW52UHdFem5hb2gzVVlBNjczclV1?=
 =?utf-8?B?TlZZWWlCRm5LZ3FtbmJhLzJVUlJEaGZ3T3B3d0xwR00zMnR6bWNYQVltcDFS?=
 =?utf-8?B?TlJsS2d2YUtkTzE4NkdiSnJaa3ZnWklIZWVDOG5qbGh6dFVwYlJZMkRnTkQ0?=
 =?utf-8?B?aGxpOERZVkFTOXZjNU1RaWZDb3lmTm9vSkg2Z2ZrNEJnUm9OUU04S2pmKy9v?=
 =?utf-8?B?UFJJb2xFaXpQV2E3UkFUWmpNU2FHTU9leHBWeDAzQ2ROcTI4dGY1S2x5NzVH?=
 =?utf-8?B?RzdPYnExUGs2S3VPWlova09zYk84QnJGQ0EzaTBBYmF1ajlidzNLZDdWckIy?=
 =?utf-8?B?L09WWUdpRlpnS3lQSThGMmU5QzdmRkprS2JYZHpqcno5NXpYY1VGUy9qc3hM?=
 =?utf-8?B?WmhubmRaQkpQcHdiSkY1V1Z5eWRuNXJQNkxyY0VSNHhqYXlCa3Bta3Z2RWo1?=
 =?utf-8?B?Q0ZvRGNtVUVkS0NJNU1ka0ZsUENJYllyeHZlbVBsMS8zS3pFUGpVYWNZZWs1?=
 =?utf-8?B?T2l5RHg5dU81d2NJR1B6eU5EbGRrbUhVUkx6YTZTUWltZEdXaEdKdENDMktL?=
 =?utf-8?B?ZEsxUDRBTEJBV3ZXVXR6Rlh4ZnVkT3FURDNVYlZJTXlhN2MyaHYyN2dtWXRL?=
 =?utf-8?B?d21lVGJ6RysvNURRdE13UmdvbjFmMi9SRHlhOGNTSGlnWGZUTkRzelM1aDdI?=
 =?utf-8?B?NFVza0dPYllrVktpYVRBMytDS1B5NEVRQXdRTE5aMDhCbFBXTGxLZ1hIaHdp?=
 =?utf-8?B?ZnZ2eHVvcDNvUjJQR0YvMVhFd2ZtbmQybElrcDJOZVhCaG4ycTBuN0FIVmh2?=
 =?utf-8?B?a2JQZ1JFanhaZjJzdVFQaTVrMWp4K01DeEVpbHdEdzZFTzZFZEhFd1pCWUw0?=
 =?utf-8?B?bE90WnI2YktBQ3lISTJRYWp4RVVDV05FM0xZUC9zN3lXNDlDL1lOS3NCdXhw?=
 =?utf-8?B?NU9YSktsdUgvZ0lKSmxtQkg4MWJ4YnZDNUhqRlN1WUdXbkRDK3FEb0RTdExR?=
 =?utf-8?B?YU0rUmxNWUJPTER4aFp2bW5Ia0YwSDU1Z3ZiMHM1MnFjY1BTRzFuSkYvRTBN?=
 =?utf-8?B?cld3UUJYTUZ1VWw4MVM4Z01pYlJiQnZldTc1TGpkNHdVaFlqOXNIdmZFYTk0?=
 =?utf-8?B?UENJaVhKakxROGI2b3VnU3gzTG9Pa1ZGOE9ZdXJIZDJXZVcxemN4UHN0RVEx?=
 =?utf-8?B?a3RMUUMyQlFKVFkycGYxaHZoczZBL0xXa3U2Z3B0bkJ2aWhxRkJGVDE3eDBW?=
 =?utf-8?B?RlJYcUQyOXk1alhnOGNGYkIwU1Bab0dkZy9leGtZVWx4OWluTkVyY2F0bWhB?=
 =?utf-8?B?alB5NVA5U2hkL20reGZSOUZRREJua0c0ZzJtQkk0bGRLNm9qeUc1eHg0cUda?=
 =?utf-8?B?MHJTYU9TN2JzSkJPRFBENUY4R1NvU21aNkVqelU5T29YeE1CcnRSNThudHVZ?=
 =?utf-8?B?T1ZpanVWRnY3blBBYkpjeTFXOG5YVG1HOWFlcXdpR1Y4RTZMa3lLMUowWk1Z?=
 =?utf-8?B?UlNaZ3Y3THBodDIxNk5wT08rUWc4NzJhQkdYRkJqd2ZEVERzbnlDZENjVnA4?=
 =?utf-8?Q?xz+75IXBZQSAWeEUExyEcqz2I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639732d5-5d30-4912-9aa3-08ddc42eeccf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8658.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 06:06:38.7478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T025SIQpiOK56wtZhZS6JOUnfDSip9CDNz3lRilGUTlSJd7gFQ0Ej5fDzAJyN7dIsaq6TCPIRCAcQdr3AUHlpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772

(+ Ayush, Srikanth)

Hello Chris,

On 7/16/2025 12:41 AM, Chris Mason wrote:
>> @@ -186,7 +208,7 @@ static void group_init(struct psi_group
>>  
>>  	group->enabled = true;
>>  	for_each_possible_cpu(cpu)
>> -		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
>> +		seqcount_init(per_cpu_ptr(&psi_seq, cpu));
>>  	group->avg_last_update = sched_clock();
>>  	group->avg_next_update = group->avg_last_update + psi_period;
>>  	mutex_init(&group->avgs_lock);
> 
> I'm not sure if someone mentioned this already, but testing the
> series I got a bunch of softlockups in get_recent_times()
> that randomly jumped from CPU to CPU.

Ayush, Srikanth, and I ran into this yesterday when testing different
trees (next, queue:sched/core) with similar signatures:

    watchdog: BUG: soft lockup - CPU#0 stuck for 21s! [kworker/0:3:2140]
    Modules linked in: ...
    CPU: 0 UID: 0 PID: 2140 Comm: kworker/0:3 Not tainted 6.16.0-rc1-test+ #20 PREEMPT(voluntary)
    Hardware name: Dell Inc. PowerEdge R6525/024PW1, BIOS 2.7.3 03/30/2022
    Workqueue: events psi_avgs_work
    RIP: 0010:collect_percpu_times+0x3a0/0x670
    Code: 65 48 2b 05 4a 79 d2 02 0f 85 dc 02 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 34 ba d2 ff f3 90 49 81 ff ff 1f 00 00 <0f> 86 73 fd ff ff 4c 89 fe 48 c7 c7 80 9d 29 bb e8 cb 92 73 00 e9
    RSP: 0018:ffffcda753383d10 EFLAGS: 00000297
    RAX: ffff8be86fadcd40 RBX: ffffeda7308d4580 RCX: 000000000000006b
    RDX: 000000000000002b RSI: 0000000000000100 RDI: ffffffffbab3f400
    RBP: ffffcda753383e30 R08: 000000000000006b R09: 0000000000000000
    R10: 0000008cca6be372 R11: 0000000000000006 R12: 000000000000006b
    R13: ffffeda7308d4594 R14: 00000000000037e5 R15: 000000000000006b
    FS:  0000000000000000(0000) GS:ffff8ba8c1118000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 000055b3cf990c3c CR3: 000000807dc40006 CR4: 0000000000f70ef0
    PKRU: 55555554
    Call Trace:
     <TASK>
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? psi_group_change+0x1ff/0x460
     ? add_timer_on+0x10a/0x160
     psi_avgs_work+0x4c/0xd0
     ? queue_delayed_work_on+0x6d/0x80
     process_one_work+0x193/0x3c0
     worker_thread+0x29d/0x3c0
     ? __pfx_worker_thread+0x10/0x10
     kthread+0xff/0x210
     ? __pfx_kthread+0x10/0x10
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x171/0x1a0
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1a/0x30
     </TASK>

I was able to reproduce this reliably running 100 copies of an infinite
loop doing - cgroup create, move a task, move task back to root, remove
cgroup - alongside hackbench running in a seperate cgroup and I hit this
in ~5-10min.

I have been running the same test with your fix and haven't run into
this for over 30min now. Feel free to add:

Reviewed-and-tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

> 
> This fixed it for me, but reading it now I'm wondering
> if we want to seqcount_init() unconditionally even when PSI
> is off.

Looking at "psi_enable", it can only be toggled via the kernel
parameter "psi=" and I don't see anything that does a
"static_branch_disable(&psi_disabled)" at runtime so I think
your fix should be good.

> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 2024c1d36402d..979a447bc281f 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -207,8 +207,6 @@ static void group_init(struct psi_group *group)
>         int cpu;

"cpu" variable can be removed too from group_init() now.

> 
>         group->enabled = true;
> -       for_each_possible_cpu(cpu)
> -               seqcount_init(per_cpu_ptr(&psi_seq, cpu));
>         group->avg_last_update = sched_clock();
>         group->avg_next_update = group->avg_last_update + psi_period;
>         mutex_init(&group->avgs_lock);
> @@ -231,6 +229,7 @@ static void group_init(struct psi_group *group)
> 
>  void __init psi_init(void)
>  {
> +       int cpu;

nit. newline after declaration.

>         if (!psi_enable) {
>                 static_branch_enable(&psi_disabled);
>                 static_branch_disable(&psi_cgroups_enabled);
> @@ -241,6 +240,8 @@ void __init psi_init(void)
>                 static_branch_disable(&psi_cgroups_enabled);
> 
>         psi_period = jiffies_to_nsecs(PSI_FREQ);
> +       for_each_possible_cpu(cpu)
> +               seqcount_init(per_cpu_ptr(&psi_seq, cpu));
>         group_init(&psi_system);
>  }
> 
> 

-- 
Thanks and Regards,
Prateek


