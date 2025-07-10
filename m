Return-Path: <linux-kernel+bounces-724865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADE2AFF7AA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25723A2594
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A3B280017;
	Thu, 10 Jul 2025 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P9+vWEPy"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0132AF9D6
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752118902; cv=fail; b=qhQU5CKnXo/oAuoh+qxQNs4StLVfKAl8r2yjl7sif9mfTkx3jKYrEiomWpoAq6YRJAnAGft+80u/GnnoONWLh1rmx7gm0V2v7HBZKlL3prFgRHD4TwoB5Ek2E51ukKZf3KD8gWRliy5QcFtzgVhV0BJ7vH5R+v6TmJlrb4amHjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752118902; c=relaxed/simple;
	bh=I0Sb7/gfMvonkTOHOnG7THEk86z4UX/rY+ZDNaqWdNY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vAPlvAcjHR/YmwpakDXahLDLL5Zers+NAJhqMZFSdxwaH16ZA+RVRloVqtFWvtQHhiwb3D+wTzb5WQ0Ou79bQwnFt1zbepmH5XmrtN+HSROngzJbah+wqYUPqHu7I/oxWvfurG3xa+SIZmpG5DWd4ZTP7Nilvh61l+Htdu2yRhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P9+vWEPy; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpHjo10+Wt9M2NIGKj/k3AtWBlHOqGGZqMWZHZEfrzoyDJB0SsL8vPYS9O7wddH91yvqqZlQ9LjoFZQ3muKijnhjLppZWtnJzZZwaVpH3FgxSSX5vQNH4NcOETFdqG0+AKKFe2/7GD1g2cHn/mqTUjjYkoRHIZzpDFVukn9/+hok0PBmBi+8ijpOn0/hDc3LSUd6FiejllNTQfJwvW0e1zmFDCjYT9UgcLXO3dhpZfKlQpj0SaasFnT7IwSx3eRCdpsXQlKcN104HvkYWH5TMmrIP9ZFopzG3NJUvmI9mJ5DVcJyFFlo2PTPI5jMhAoZD59ArR39d6bmZ7NKJK+yYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wro/n7xSWKseYmp/iJFLRYbKjfaehDrauql0Rkqu7Bw=;
 b=bq8k0Lb5JD84ZJVCOVtvo17BiMiyoWHemetdSKAWlKUsahKm0Zabe1bRj3xT7y23cgHiMCqN5/8XTH6A5vAvNiqN6KGzTBEy7IvqapzprZXj7yi7io3UneUugBmKBgVeSjhb/rLdwlij/tse0UQy89mXdSeqY+5eAPOe1zUUYffakqFsUpItgLTjoe5A243aCQCI8ArK/zu6jRSctAB9l2lDltQGxZ2ZCpFxSxY1RB0EbbspPCZ7x3g0bQAcq7nIBvg3IaJiEabDTiptTllS3d3+gBYZwNrNDdL5+REZcelYrRHR4AQfw1Z8pAwcxKe++Y7ARPpkRZBzCdhfysxiQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wro/n7xSWKseYmp/iJFLRYbKjfaehDrauql0Rkqu7Bw=;
 b=P9+vWEPye0ZVq2meFTYxQKT0MhXAuigDkR3f85fsq1Th01BUpU9+c2DwCHbplL76yOvvvx6yY2aZY22icLAkV8MTQT9q+NfyAvBBooswu3ZuTEoexNud8IQzkzgEw0Ghv0eGC/3U7KyyzjSShi+0ggrV95h79XMFIMKc/AhuGDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 03:41:37 +0000
Received: from CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42]) by CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42%4]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 03:41:36 +0000
Message-ID: <fb97657e-cb61-4e8d-a156-eb1141dce19e@amd.com>
Date: Thu, 10 Jul 2025 09:11:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] sched/uclamp: Exclude kernel threads from uclamp logic
To: Zihuan Zhang <zhangzihuan@kylinos.cn>,
 Christian Loehle <christian.loehle@arm.com>, xuewen.yan@unisoc.com,
 vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com
Cc: rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, hongyan.xia2@arm.com, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com, di.shen@unisoc.com, xuewen.yan94@gmail.com,
 kuyo.chang@mediatek.com, juju.sung@mediatek.com, qyousef@layalina.io
References: <20250703091437.79861-1-zhangzihuan@kylinos.cn>
 <675563a5-8f1d-4249-9828-9fb353dd7dd1@arm.com>
 <6414cb05-11d3-4b2a-ae97-7bb0ca0ea898@kylinos.cn>
 <8a64cb22-24f7-4ca7-8e4e-22e1612124d9@arm.com>
 <386d99d3-aa97-4069-8d63-d197262832bf@kylinos.cn>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <386d99d3-aa97-4069-8d63-d197262832bf@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::34) To CH3PR12MB8658.namprd12.prod.outlook.com
 (2603:10b6:610:175::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8658:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 0397a78c-1c9b-4cfe-b37f-08ddbf63aba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STJoZ2hZR0thOFQrQkVyMGwwdDlDdWx5NXU0Q21NV2FYM3ZNNGs4UmlCM0hn?=
 =?utf-8?B?UXdzQlY4UzFyOVY2MVp2RDhESzh3bEkrQWJJbzBDR1A3eEF3K2g5WFByWjhh?=
 =?utf-8?B?dXNsblBaM2hoQmNZRllyN3AwbHdSWDMwWml5ellRNGZlS3JwRWh1d2RZRnBG?=
 =?utf-8?B?cHo2enV4emNlRUsxdmg4Y0JBMUVDTVBzK3pzMTFCeWR2WW1jY0R1L2QvUTEz?=
 =?utf-8?B?a2xPMjdBdFM2WHRCaFJ0cDJDRWNiZFRiMlozYS9BbllRK0lKR0RnV1ZTa2E0?=
 =?utf-8?B?Q0xNZllWNnZRQXFBd0pPdFJrY0JnYkxjOFpSMEVFakNYMkFQZ1FFMTNMdWYx?=
 =?utf-8?B?Zy81cmkvUkt3L0x2aFIzWHdWS0RBQmZEV216RTBZdDZnRVp6N3grWWRocWZE?=
 =?utf-8?B?MlpENWxybktFT0Z5Z1Fjdm5GSXp0TkJ3R3JDQTdvZ2F5d2RGU0tSYmdEcHZs?=
 =?utf-8?B?aGxxZTdsN1k0ZlhWS3hTNTgxSVZTOTByRVI2MUZ4RGN2cnM5SDVTNGZ3R0FP?=
 =?utf-8?B?ZEQ5clJpUjYrMGdHVE0vb2l2a2o4ZG93V2JKWmk4WFBybEtnN2tzRWtrYm5W?=
 =?utf-8?B?ZlFnV2E1bmYzRnRCM3NkeGsvTFp5bHFBM0hWZUFzaXhJc0k3SzRVc0s2eFpU?=
 =?utf-8?B?V2lYdlVQVm9PS2ltbDhLeGJGTHJPWjlRMy96b290L3B5MEQ1cG9uRk1LcG9p?=
 =?utf-8?B?eFpEeVpqMlNzK1FlVWxrL3JSTWt3VWpqaCthZDM5amZlUmJGQXFIYXRUVzV2?=
 =?utf-8?B?Mm11a0ZrQ2NpcXNXSHVTdTNESy90M2lVcGFDNEowV2FOcHhnakRBdHVkUGVV?=
 =?utf-8?B?WHl0WVJEaWhqMStLd2hxR0llWjVTQ1hhcnFhNiswaDlIak11ZWd1WkVuQWJi?=
 =?utf-8?B?R09DTVVuMFE2ZWxBS0Z0Vkg0OERyVXNSZVNGc1puaHp3UGNNM1d4TDhXRk9i?=
 =?utf-8?B?ZnFmSFdEN0tqTVVIYmdRVXlrWG1aeWpVS3JsSXF5ZWJiUVRsaG1kMGtQdkM3?=
 =?utf-8?B?Wi85OFl0RGFyMDZCbytsb29ST0lVb2Q1b3hwOFIvL0dxUHZDMFhvYWRjSlVV?=
 =?utf-8?B?RXp2a2gvbTFGTytWdmF5WXVyaituTFdzbkU5empVTll4YzE1dXZxZkdHbjVN?=
 =?utf-8?B?ei9pMWF3TEJCaC9PSWllaGhFdGVmMjBUaUpIdlBXM2pWY0Q1eUVBRDdvWVJS?=
 =?utf-8?B?eEo4dlhuZEVJVC8xVjNDd2pzZnZJbWlYR0tUdGhBUUY4T1ZHckt1MVljaVJu?=
 =?utf-8?B?QjRuZnNSaVBKdWFPWERPZU1rNDRDdVNYZUFhYk1LWnNxNGp3N1ZKYUM0ZkZB?=
 =?utf-8?B?OUFsU2xqMTNPUVgyd0JLKy91MjN1bmt5NEhLRnpSY3o0VDh5eW5pbzZLWjRH?=
 =?utf-8?B?bVg4UjQ5am5pRlZKRDNNSGsxcVBWLzN4U0RtZW16SUViaHhoRFJXMDlOdUkx?=
 =?utf-8?B?L2FVSWh5YmRSRmhYMjRpWmhVbzhqakcxdFlkdFVuSFA1UFZzcjFxNFA5dEs0?=
 =?utf-8?B?Smh1dDBDQlc3UzhwZDRGblREaDNvMHV2aktsUGJTbHFjaTZyM0JzcEZFRmRu?=
 =?utf-8?B?MHE3RkFQTlBaL2pQUDRYVDV1eU4wcjE0TS9nTHZLbHRiajYzeVZCcGhZZkZz?=
 =?utf-8?B?aS9FejJRZEV0UEJ0VzdHSmVVRndDYi9aUkFFWU9oV01NbkVxd21FNktIczNu?=
 =?utf-8?B?amVJaFQ1L3NJdWpKeUVaeHVRbng0aFR1anlBKy9CeFhLdTJtR0hjK0pSVzhq?=
 =?utf-8?B?Z2Z2RnN1R0dDOGhGMHlLbWxoM0xuRURnMXpqY1RXYWtXZklEQjBsV05XQnVM?=
 =?utf-8?B?S2ZaaHkwZUlVcXBlNXlLK0hTVDVXeStxb0pHSFdJdGRHSnFTVkNMUU5ZZDF1?=
 =?utf-8?B?S0RJL1dlU25oSEpCSVVEN0FWWVBZbE43OC8rU3NkTWZ0cTJ6ZUdlYTVudTZz?=
 =?utf-8?Q?TQIbRLV/ucs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8658.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkZRZFNYNE5NYStwTjViUHEvQ01EL2VsSE9hZFVsUlE5RDgyaTFQaTUxWXJy?=
 =?utf-8?B?Z2RabUpaS0crMTlsT0hyaXljZEY5MVdZWXM5OTY4OWw2TGQxdEZZV2pNN2RH?=
 =?utf-8?B?MzQ1d1NidDhDY3VCUWd3ZmpGNXRRZW1uY0kza3pGWSt0TE5jd1NpYmFvdnYw?=
 =?utf-8?B?S1h2ME1jdFByUDJQa2taZ05lMnVxdVEwQ1dEbFQ2UnU3SGIrUU94bjhUa05m?=
 =?utf-8?B?QlU2ZUtqbm44RUFTUXVuWEZwNURnendQbkU0YWMyMmFBcDNKQ2pteGYxK3Jq?=
 =?utf-8?B?MjJZa2ljUkdlbVF6RTdMbm12RkVBTTNqa1VIdk8wMTd1L2UzQjVxV1l0NHVm?=
 =?utf-8?B?Y3lEMjlPUDRnb0NJN0lVQ01OVy9HNUZrU0F1a3ZhV2RkRVVjQUtpSjQwa0pL?=
 =?utf-8?B?cks1Y1REZTJUcjhoOFR6K0pjS0RTZnRybThtY3dnTUFRaXA4Vy85dEpKcjBs?=
 =?utf-8?B?SlVPdFZyTEVzSld0Ym1xdndiY0x4NDRLRFFHbGtUNUxWbTV3blJHVmhySjU2?=
 =?utf-8?B?VG5SWlVUSjJyWW0zekg0d1BDcDVJQzlPUnBwQjMyZ3gzS2F6YndDV3lGSEtn?=
 =?utf-8?B?QkYyQVFIVktzRlpyZW5kL2F1ZUVEUzQ4OEpNanQ4d3lzMGRlaW1SYlZLTjlp?=
 =?utf-8?B?RGl3WmIvdlV0WUxhcFRkNXppV1RvVW5pRnplaktKZTNJd2QzL0tyeVZ6eGt0?=
 =?utf-8?B?Zm9Qam1xanZXQk5JUnBDNEpkVHVIUTVLem9YYjlFaHNpRDFwOGNzNkxqSm9P?=
 =?utf-8?B?UXU2WHJtK2NFa0RuaHhZa1BRZlZHd00xZlQ1K3lmL0h4cXV1N09tUytpTmh4?=
 =?utf-8?B?WHFJUCthaE9qVWNiMGdkWndmcXY4bjBUYWdkemRXWmZ5VWhDV3pVVWpjcGQx?=
 =?utf-8?B?SS9VSnZVWlEycUd6alZSQ1pSMWZQMDhvVVdkZE9hMHlmRExaSHVWQ0I5TTJY?=
 =?utf-8?B?c1ZhTnJGcXU5SE9Cc0ZTL0hXM1ZqSTJFQ2YrbXZXVHNXdjU3UnFxQTZtc2lG?=
 =?utf-8?B?U0JBQWFCdGRWbGNUS3VyNytpbVdJd1NCNTQxbjVqK2kvdWlhZHlCNi9BbVlO?=
 =?utf-8?B?K2g4TnRnTyt4dndjOGhiSHZQYmNIek45dExQMFNydWFhT3gxZjdJOVd2bFda?=
 =?utf-8?B?QjFlY2E4MEdWTHhHajc1M01JUDhqbk44L1RFOWhPTGxxbENUc3h3WEZqMlpS?=
 =?utf-8?B?Qkl2UXF6WHljR3hiL1pVdFpBaE9lOUZZK1lXL3JqS2JRaXlDQitSWGZWVkl3?=
 =?utf-8?B?dXRDNVoyK0xoSmhzd3FMSjNOMXFjY1k3RXcrZDRDS28rWXh6RUs1aERpcVhF?=
 =?utf-8?B?aHNKYlZrRFVueVRzdGNXV3hVa0VoaUUxUU50TDFFa3J4QUhRU2Q5M1ZLYVhD?=
 =?utf-8?B?WkVleTNURjFmeHR0MThHUGZGNS9MeUxLbGpQZUJEemo3c3plWUZ0T1lqNlBp?=
 =?utf-8?B?K1Q3VUxaakd5YmQwaWVvTm9qbjUxcko5VkZoK1ZPZzJPbzFzYzFWcXpPNVJI?=
 =?utf-8?B?K0Jnc0JsREcxaWxlM0V1YTJVZFUxTnRKdGRRNmF0OWpEUTlqZjZRcnUyVCt1?=
 =?utf-8?B?ZEI4aFpMVzBJQ3QrNWh2RWZyeUhDK2ZLYzArVUFzekhQZXQzMDBqRTFMTXVH?=
 =?utf-8?B?UTQ3SDd1cTlIb2YwZ0FKQUIyNkV3Q3lTY2RWMTFyNFhJaXlsRmxHQ1pOV050?=
 =?utf-8?B?Y3NEYVVqb01ZUUlGTkdNUnkxNThqMFdhWCs3V3hmZ1VBcHJycUZ5Z2NuNTQ0?=
 =?utf-8?B?WlJRSmFyTHV5emMyMm5rT3NscjFiWkMwckNtWXB6ZHpEbnRQVlY5VzB6VEZO?=
 =?utf-8?B?SVIxODdTUm12aWJ4YU9oSjZwM09jb0REaEw2M0NyRkIvSGlPL0xQdDRMRVFC?=
 =?utf-8?B?OGxjSmc3VGdBYTR2b2trRkZ5VHFlS2FMOXpWYUNwak1JZlIwRTBtZEw3NXls?=
 =?utf-8?B?cTZjdFlnc25EdldiaG5yQ3dhU2g5YnBHT2RwZnoxS3d5eG9aUk02SGFuYkFo?=
 =?utf-8?B?WDlpSG1uczRGLzdVamVNS2pOUkY3M1dzb28yaFNyUlZVTTR2a0JabGRGcGlK?=
 =?utf-8?B?cUR5QXRzcUliTVV4eTBUZHJHaWlqMVUwcU9LS1hGRnFRMVNva1VNMitNRUlK?=
 =?utf-8?Q?6rvBKDs2y2cTp1p2zoR0MRhEj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0397a78c-1c9b-4cfe-b37f-08ddbf63aba4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8658.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 03:41:36.2966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXfz7xFFIH+D7quawGwIjTN1yNEOO1sDFRq8LixhbkROmyBAN4iuHDp+hx3VunCFO9OFdQqzQktEAH8LGG4VZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718

Hello Zihuan,

On 7/10/2025 6:17 AM, Zihuan Zhang wrote:
> - For kernel threads that do not set any clamp values, skip the clamp
> aggregation step
> 
> - If a kernel thread explicitly sets clamp attributes, it should of
> course remain fully visible to uclamp logic.

There are also sched_util_clamp_{min,max} global controls via sysctl
which can be influencing the kthread scheduling / freq behavior
indirectly and glancing at the implementation, I think these are
still handled by clamping in uclamp_eff_get() and effective_cpu_util()
only looks at uclamp_rq_get() to make freq decisions.

Wouldn't excluding the kthreads from the uclamp aggregation also change
this behavior? I'm assuming these global knobs can be used to limit
frequencies when thermal throttle is detected and be reset again once
the SoC falls below the throttle limits?

-- 
Thanks and Regards,
Prateek


