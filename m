Return-Path: <linux-kernel+bounces-741150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB27CB0E0AF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E051C825EE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDBD27933F;
	Tue, 22 Jul 2025 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MRgWgYI1"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A5B24DCE1;
	Tue, 22 Jul 2025 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198654; cv=fail; b=Bhu4XXp8Ox4KbTbwNH71Lg+W/iZy3q9hRo98wIdsNOlvjm1oIYK3Q7NWzHoMxLrBJ4vv7Toybbls6wHOK2FFD5gc8Kmk/WjzoHrlGz8znF9WE7yoxehQEj/AIJuIaYqkhzcK0CkEtJWzzp4I9BttFAVO1OlfLGaRNw6Y2sv6OPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198654; c=relaxed/simple;
	bh=cWAYo8WqbdZDRN2UT/THrQML6f1R5akM7rV8IENvRVg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s61ml5+xwCKeFYnIpEWJn3S9Vp8U0En0JZbM4q90gnz41PHDSGOiWBmzR2kvk/ok8b9jlw75XN5DWd458LN/dZM6CMRHmY5XGk6pHy7qSLtdDpywNPGoHXs62odqL/gwtGxYwjsH8KAi7A00YzEyibnPu3opr2h5A0K+SuTCmAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MRgWgYI1; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVnJWsqzL4HO566ebrfObiy5Sj4ADf6ovGF6yxnK9ALYm4ljkdd3cJtkDvZgX7HJosCV7XW/fPweQKQSw3rU0d+e0Q7WjcCqa70SQ+6pk8nMr8K6JAmQLp3o2Qw0JLZf4VQCbRsXcJw3fhSAlyFbXh+D3a75v4komM6nDQ0x+FR55pCFxWiEcyXUlavjbh4M4Pru42ncHunjURsB8KEnBjU3k2OwiPt+FPnsw74rs5GiewMaVgqSDTvDgt2vovIj6tvvvFjwJKR60IBgJflwI5PMaczJ+XLL14VAmOv88W6iMmt4eCouuARbPSN8YjBKnCsCJX44xYndKT8jK/L6lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiUwoSXVlzi1JOTogZgYIO1RcN5kPZBsqMmmoTID0Cw=;
 b=dSrvlJuhzMCgsXj6GEGnT3IVDQjiR0tTFsAoFWVAcD6rXgiiZnL7OQW7CkksThK70KXjq3ySLkZOMmCq9veI3COflJGX2JngAAy0SEfksTs9X/c2w52luD2PyvF2FgU21Iz7foxya0RdV6uGJG6coefq818fdbVnSayfJoBeXwxMZrCGYpn5ayrBEJdeNNqQ+UabDfjOUM7IrB/KSs/zCFpEOC0JY/IWs14xZjpaWA9h9ZWTLI0Zbx5XyVjGbPnzogBN74JEoKy9iNVIs9z4q+kMFnF8wuYh3Prev4YOIEE3f/V37CIo/lEVAF4r5hK5JYzwBTnVBlkj2145jzSGAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiUwoSXVlzi1JOTogZgYIO1RcN5kPZBsqMmmoTID0Cw=;
 b=MRgWgYI1MHgXbE3keMh+10ogd+2arDlEmFZHHEp7kEGMZY+Kxg7DlR0rhkuZbC2KAMVMV5adP5f+2hPeRGffUILuChB0Ggu0jPx5lo9/e7aWPzw/KJxu+XhQL6JqnD/PJ8s1CKvwS+kyToDwja7kS0ZR4ZDGD50M6jYUyTWlslE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 15:37:29 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 15:37:29 +0000
Message-ID: <d48e42ca-a9ac-4bd0-840a-86a975900322@amd.com>
Date: Tue, 22 Jul 2025 17:37:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: riscv: cpus: Add AMD MicroBlaze V 64bit
 compatible
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Rob Herring <robh@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>
References: <adf316c097ae416eb8565f2f1d67a98c413a71d2.1753169138.git.michal.simek@amd.com>
 <20250722-glitzy-worshiper-7574af025084@spud>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250722-glitzy-worshiper-7574af025084@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0138.eurprd07.prod.outlook.com
 (2603:10a6:802:16::25) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA0PR12MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: 9501ee4b-dc8d-4133-8a52-08ddc935aaaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qkt0eStHYTIwaldGSG90MU4vMWFOOHZIdVNvMTQyWmFNNlBCR05nTnc5ai9i?=
 =?utf-8?B?Wkk3RThpc1pGM1RHUmxGeit6Y0hnbnFZMEJrS2J5emhwSEpBRHRHZkI1UVRj?=
 =?utf-8?B?Z3M0ODBVT1NQVmUvdGJqZ1lPbktNTFM3YUR2M2gwN0dCS0lNems5aTMrK3FB?=
 =?utf-8?B?MHIwaXZSa052SjlkSE9XMy8wYWU5ZWlXK3Jxa050eXlrMUYwM2NyTDBzZGRR?=
 =?utf-8?B?YXllSyt3TW1EdXJqL25RZFgzcU1Bem1hbFVsZFJ3Z05nMTl3ZFpYdzhZUWZZ?=
 =?utf-8?B?RjRTeG13eVo3Nm1PRENpS3BPejllc1F4M2RqdGlWWC9hZ3lFQmhlSkFVSnhG?=
 =?utf-8?B?RnVTL0x3ZUJmTXdnT0VBcXpvUWw2QzAvSzFoOHgvN2VLNnYzeFdmVW5ZQzhn?=
 =?utf-8?B?NEh5YytCYTZscjJFakFTNUxrOG5MdXd5bllkZ3VnZ09OMXl2OGV4MGRhU0lo?=
 =?utf-8?B?WGVSRzNqV25KL1NXZFV0cXRLWGZ3NXFteERpYSs3UVRIeFFVeE40dFZRaURN?=
 =?utf-8?B?QlJTdm5oNGpjZXlNMW9sNXQzNDN0VnV6ZWZmN3FmaHRLMDBza1NSdEFuaHN3?=
 =?utf-8?B?WW14ZXFvempHTXpjWi9BZWo1Z3JreE9FaXUvTWhtYTU4YTdyL2JaMUJBd1Ez?=
 =?utf-8?B?azVqTHNzb1NKWmpCdi9wVWo4eUgvaDVZVlZXUlMzTzhkMnY2NEZNV3U4SFl5?=
 =?utf-8?B?RnMvVHJaQ3lWRzNpc1lhTC9EZXp1NGFSL3pqYlByVDBWZEhzRUF6S2ZhS3Nw?=
 =?utf-8?B?K2o1M3E4ekJHNzdDcUtGYlk1bzdSbG00OUJSYzVYVTNmM1cxVDNiUkdkNkk0?=
 =?utf-8?B?b0c4bWhLTzlqa0ZhVmt6cXhMQW1zb3BnQTNUUVlpaHhZRStHQSt3UlhRQmx1?=
 =?utf-8?B?ZUs1Z3Z2V0ZlRWhpdkRtc0VySlNkQThMT2ZDWDBFaXFBc3FmdHdYc1BlOFdl?=
 =?utf-8?B?TDgraXkxWCtFcTVZTkd3T09hYll3eEFmTkJ2WmkyZERlTzNTL2pFQS9YM3ph?=
 =?utf-8?B?blVqeWNvRDBmMDJwbG1LbU1FZ3RMamdkZnZ4TnBoaU03OHdYYm5ZY2Z1Tzg3?=
 =?utf-8?B?bEdIaGNnUXNoMGlOMEdRalllekovTTBBbnROL3lUMEpENm5ObDZ3VVFDWG1O?=
 =?utf-8?B?eW1ncGcvR003ZVJRd0VCNUhialc3d1FTN05PbnFvOGhJY2RBaUMxOEtZTmE2?=
 =?utf-8?B?R2Y3U1Z5Q1FBSktzbTI0MUwyS3A4bnRBUnNLZlRNRThtVlVGYzNxVTNCczV0?=
 =?utf-8?B?U0RLMk5KZGxsQ2x6Q04xc0JZbm14RldzdFl6LzBYcjJZYU9nRGFmTmZaQ3Rv?=
 =?utf-8?B?WWdScG5VNFlXRXFyMHRETEdXTThVeEh3ZHNacW90RjFiNHZQMVlHbTZMWi8x?=
 =?utf-8?B?bENpR0Z4cWg1MzVCazUrQjJXa3RrTkhRSE1MdWt0WGJGRm5KUnlYN0c4MnNj?=
 =?utf-8?B?Q0dNS2dTMUJ3cWZQWGdrQ3ducnJCdjN6Q0o4eDlIUW5SYnB3UTNvRld6SjFT?=
 =?utf-8?B?d3JIeDFIWUppOGRzeTRhZGwzSTNhbHp2NTM5VVFTQno0VDFnNmJ0Ymd1OENl?=
 =?utf-8?B?czVOcWhJNHQ1VlFQTFMzN01Mdlk3YzhzY3F4cXQyQlgwQ011MmFVb0xpWWN0?=
 =?utf-8?B?NzZQRkdUMjFCR3plYm9yYThJc0pwOTlzNlROcW5OQ2ozeUtybGkrWXlWZjFs?=
 =?utf-8?B?NkpWdlp0NGEvK3oraW9UK3BtRVY3cHlIWENucTkrY2RTNCtXMzdQQmlsdGJJ?=
 =?utf-8?B?WjdYaEhUNm9LWStQbGNjMzk3MzNPczhTMHJsOThIL3BaSy9kQ2dLYy96L3pj?=
 =?utf-8?B?dnlmWUxJN2ZnQ3NWSHdQTEczekYrcFB6YlFrcDcxd0RZa0JIVTV6aHl3YjN1?=
 =?utf-8?B?Skl5REJwVFNvSHVERytYeU50YXNYS1ZoQktta0l1bnZueXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFJrWEF3MHJtVnV5ZmhNVmpERXJBK3doWUNEOEU3YTduUTBxVEVicnFIc3dM?=
 =?utf-8?B?cWJZRW9EUE9Nb280ODJabUlFc3BzVk1mNGpSUFlkQnRvZysvTk5qMW1GYTMw?=
 =?utf-8?B?dnFkc2k3OWJhYmxKTlAzV2t4K091MFM3azYreFJJL095L3B2Vnh4Q1pCZXRZ?=
 =?utf-8?B?N3JTaTVsWlF0cFFYTFRQSlJnVkdzamlmbVczdkx5RE5yUGp2SElzOW1uN05k?=
 =?utf-8?B?bGt3R0JPL3ZXcDNVcmIvV0s3MXphM1dHWE9UTFA3VGFPMWZ6NEM2RUtzRUE0?=
 =?utf-8?B?dG1mRTh3NlZoVjFMSzZJdm1DZ3hWbEtzNHJ0UG5ZNGRjaEhtb0JQY0V1K3dz?=
 =?utf-8?B?cWVJT2p3L05FRGJNR1JsRHhuNlQyNWIrRDhtQkpUNmp4UG5URVpUbkFoYnlI?=
 =?utf-8?B?VjNnN2trcDZNc1I3SGYwZ1drTituelo2WnBYM0xYRUVTNjZEUy9MTGpibUZz?=
 =?utf-8?B?SzdzdkVWOHJsS3FYUVNJWE9peVloVVNldGpHeWhPcTBjTk1kMjVacGhrMzZq?=
 =?utf-8?B?U1pFSE52OTZOS3hMUDZ0bnVSeERXN0dCa1hRdHNXbkJ2N0c1V0NNeG9ublNM?=
 =?utf-8?B?TFJEVXVNY1dZWThtbE55NXhiRUdNYmcwRFB6bERFeDQ2a0FaQ2VRdU8vWlhr?=
 =?utf-8?B?M1NwUmV4a1RFcWxId0RRWnBxMFAwcHhSUDdjVit1ais0aDRpOXhicnhyd3Fu?=
 =?utf-8?B?eloxTXRyVUFPQ2lzOGM3ZTFMYnpqNEF2T25MSUlnWm9Kc1JCVTN0TDh0cjUy?=
 =?utf-8?B?U0FGUkNtKzV6dDJLdTl5VkErZk5jVDkwV1RESGdZSlIza3ZPRERHcnB5VkZM?=
 =?utf-8?B?MFVyWmdxeHF3dnIwQWwyWm1EbGhEU0VrdTVySkUxbmt2ME1CN202aHZJOHFj?=
 =?utf-8?B?RjRESzNWSWxWREN6aWVVTHFnaVFQbEk2aTFMalYwelNUNnEwYjZWYXYxZUxr?=
 =?utf-8?B?ZloyOE1nb0FaS29HSDVVaUZXWnJQQjhCOFlhZDU4MHlLSXkrVE02UGM0Yko0?=
 =?utf-8?B?dytUQnNXTWU2MWkyUEE5UGR0L2Qwemt6RDg3R0xJSWVjWWhlQWNUaGp6dys3?=
 =?utf-8?B?N2JjdzFwOHpNL3JiZWxEYVFMY09HM3duUEUvaTIwNFF2dlA1YVdjZk14STVy?=
 =?utf-8?B?RW05ZTlvbFR5OWx5SFlLVkdZWDhOdWM5eThWRXNpWFc0dWtxOXN6aUJ1amFZ?=
 =?utf-8?B?U3dhSWpPdlFhWDdHYU5ZNVk3T3BPQ1QwK2haZ0hCUEY1VS9MR1ZEMGF5RVdx?=
 =?utf-8?B?V003dDdyS0xzTXZ1SFp0THBVV0QxelJjZklsSFlQeEp2SnRPbDJBVGVNbW9L?=
 =?utf-8?B?RmtLSzlUUmE4cXNoRDdOaWtobEo2bUFxbk9QWXFLM1Z1VmpzVG1ocFVWKzFt?=
 =?utf-8?B?MHlXdyt5OS81S0xuWncwa0crNlRqTmpFL3pJUTJjU3M5TU1TMlFGbEh1dkVp?=
 =?utf-8?B?TUdmN2VXV1VseTNNSEREOTRKaGQ0Q2xxWWpXMDBvWC9KVElicnBibGhhVzFq?=
 =?utf-8?B?ZTVpOXRacG9ERnJZUEplV1NBbEZHWmo2NnZhclpSREJacXdjSlB2NlhicHZ2?=
 =?utf-8?B?L0FpVzVEeFdhb3dkNFo2SDF4eDlWT0pCZVF1eHd1V2dSMmpvODU5NVJ6QWlY?=
 =?utf-8?B?QjRsMFBtK2ZmWUdEQXB4SFNwZ0h5SkJPaDJvU2ZIUFJuYUtaNHIxWkNDRjY3?=
 =?utf-8?B?ODk0YzVIa3YrR25MVFVVMFJoc3hqQkFlSjJqMUxhNXkza0hHbVhWVVZROXZ6?=
 =?utf-8?B?WmErckJ1V3lranlMSU1hd205SEZ4TjRCRC9MRnFmbGNiQ3Z5VEE1eHZseW5r?=
 =?utf-8?B?M1A5MWYyd1dJOFFiUVpkNTJtRndPczEwZ2tZV1lESjNLQXN5YkxENHhGNVd3?=
 =?utf-8?B?SXBFYUdEbU1JZFU0bVVrbFEwRmlmWEdvaFA2K0JkZnoyRWNrU2x6eklIK0VL?=
 =?utf-8?B?cHcyWTVEZGJuZHJQek1xQ1huYVBIMU1GMmYwMVRJblM5N3dZV0dMSGlxV1lB?=
 =?utf-8?B?bWxsUTQyOXBPSTE0ZkMyVE0xcUhMSkNZRWtvY0FtejMzM05Jd1kwM0JJc001?=
 =?utf-8?B?NXB2eEhFNlVDV09xeGwvMTBtU1pSc1hSU21ZRzR4R2lHbnRKNE9NdXN2dDhw?=
 =?utf-8?Q?d7H9BoYlJWsJDhkAN9gX/CSi9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9501ee4b-dc8d-4133-8a52-08ddc935aaaf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 15:37:29.3880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ky6kVwT1Gl2yQrOrqFt1F4btZeDlFHJYKTCWein6oY6Jx0HD3uMmZeXCFagnczEw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365



On 7/22/25 17:18, Conor Dooley wrote:
> On Tue, Jul 22, 2025 at 09:25:40AM +0200, Michal Simek wrote:
>> 32bit version has been added by commit 4a6b93f56296 ("dt-bindings: riscv:
>> cpus: Add AMD MicroBlaze V compatible") but 64bit version also exists and
>> should be covered by binding too.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Although maybe I should pick this up myself? LMK if you want me to,
> rather than it going via the xilinx tree.

Please pick it up.

Thanks,
Michal

