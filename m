Return-Path: <linux-kernel+bounces-896333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE761C5020B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0158B3B1F97
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5491ACED5;
	Wed, 12 Nov 2025 00:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="b1ShWNPQ"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E3135CBB1;
	Wed, 12 Nov 2025 00:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762907665; cv=fail; b=G7vp0pBjIqCL9q8Ye/+FMAuN+dK6/96gNt4JZ5KhI6jqjovbDKnCkeoTG4glexClV3gNxEoiiXSK09Wim+Q6lBHGtWCbT5TQkLXdI5a5nqwk0eFzAHm4jm4DqU1UACa6+mRPEYAeSEos4aWx23OsEhttqKajGKzcQAcW3gfjtwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762907665; c=relaxed/simple;
	bh=QA/eRlZ1a9119Vk/mxp5gEnxgT0Nk+RPV/LMfR3LBXY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jBswl57x4Ubpg5upywPLpAyRnj6r9b0udzFP3plwBDU3QMPyrqSBYv35Sck5eBiz5UB53ApFzC1buMty+FDgZtOxeQKupHJVPzo9mESXncKW2Pxs3IqFhe+u1ssfJ+uAImdzxzQ95YqCNu3G9TOAJ87Nt1pCWcz1DR14ZguCWPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=b1ShWNPQ; arc=fail smtp.client-ip=40.107.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmnhlYrZFtHAjf+37iOc/RWv+HzqNBkUINTOX4hnB+hWqsjKwCs1TExRAcmeFdMl4sBsT3jY1PHCEmfwIObXaHUd4mE80SXXy8SBsBCvF1H7JBJ9Z7fRN1tCQeAE8Kq5vLB+QEnwvdjU54yCDSlaCXKeKEXaywgK2XlGmLtjjw1sTglM0sH2/OxOaxRXH7Z9XF/doPeSqcGaIq56HXqocMt7ffxk63KGBfIWKKFs/r+5lWvlQR+tRZ0+kRTUWeBtVhvzTeOuh85yXp6M46oTOa95hot4daF22xzdpJN2zp+V0uuWIgzjVNjH2/M9kSc83GfRC+ut23Lx++Vwrt0U+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGUDhw7LnW2e0Q+TSvTC8+e6io66wmqH6eb94xKVoWI=;
 b=xzn38qijC37jCieE+D4TIuw5IVQSosaRlj0bCPSASVCTUzfL+L7RqDUdn4MPA+cCabkE6DmYQAA94NriuGG29+Up1wS+o0WgQDuYwuxcM7bLZu3SVfxG4mnGL3EB0PJlYHvcszzulbUAO3rhRWNvkJhi+Q2RzYyQLFcY62GQYfJGbh4QZB/9J4biRmmGSZmrXvT3L9bSOvMtX3thYwlgIQZiOD2doWJIJhdGdyU7cXXJSjnOA7wsICtrXQcXOlalCz5TgyawRpSb7Sv89mrYaGWdUAMBcg8XoRPHWuaBS7IWrIMcCApxDGsJZeUAsiuHpKbnkdIkrm63TlN0McwdPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGUDhw7LnW2e0Q+TSvTC8+e6io66wmqH6eb94xKVoWI=;
 b=b1ShWNPQwZzguXjTaJYJAsiAS3ft50uEKhPJ3uo2of9bjo93FbO3wGcsxcdvXD76O9/x+nh4mI/nlvwhdJXY6Vqid/5yHZMbfGSicj3azBLLo7Pf3ylxgy7kEVsOy/svAQV82K5N5A3EMizb4mPq22p2GhmZ18zwPKjVOHS1Oxw1KqCXaVkwBt1v1YInWAVtKd1L0UV40qCcVkZDaT+34yeyuzbj1hjCWnqp+uMQ9ySbpM4OxD/+IF13sYR2P6vHlgatWgqHl8PWjckbEn8aNfOrJWhnul7d4jsf1cSJncyliUIcJEGqoExT+658pD6c5jeYI/gDRMg9AicUHpxi5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by CO6PR03MB6211.namprd03.prod.outlook.com (2603:10b6:303:13b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 00:34:20 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 00:34:20 +0000
Message-ID: <76d281f3-4349-47c0-aa76-2e9716ba53f6@altera.com>
Date: Wed, 12 Nov 2025 08:34:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: intel: Add Agilex3 SoCFPGA board
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1762840092.git.niravkumarlaxmidas.rabara@altera.com>
 <e9d398bacb299c996f14c9993bf041a9a6740cbf.1762840092.git.niravkumarlaxmidas.rabara@altera.com>
 <20251111-nuthatch-of-amusing-attraction-06ea70@kuoka>
Content-Language: en-US
From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
In-Reply-To: <20251111-nuthatch-of-amusing-attraction-06ea70@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU1PR03CA0031.apcprd03.prod.outlook.com
 (2603:1096:802:19::19) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|CO6PR03MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a5cd47-02ab-4006-d8bc-08de2183387d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWJjRmVlSDhKcnVmWFUyTllLMDB3cTNEK3JBeEU0K3UvckozSkIzWkhaR2hu?=
 =?utf-8?B?akhFNVU2VFJnSSsvYnpZT0FiMExNbVhUbnFVUmxwTmgwV2VOUDYvd1JJRkly?=
 =?utf-8?B?M3ZGQ0d1S3RSQUdTSmtEL3RXcE1JTWVGY3RDRk5sVXJHVGZrNFZZclpFN0Rl?=
 =?utf-8?B?MlB1UGRxR2g5TmdyeHNXQml5N2lSVGFOdlBIWHAzODRwZER0Y1hzNHZYalFj?=
 =?utf-8?B?MGtCVFExT0REUFJMeG5POGdvVDZyWm1Rd1YxL1g1WWVUa0U1bnIxTW53Y1Ry?=
 =?utf-8?B?MVhUeVJqVkVUWVZGK29FNUh1b29JWmdBU1RpcU9DSmtIQ0xKSXRxOFNKY3Qx?=
 =?utf-8?B?L1BhQlNuQi9maDVOdXh2YzNsbUpOVy9TTFVVUFF0SWY0ZEh0NGJUSUs1VzFT?=
 =?utf-8?B?LzVPcXZkRXc3UmRrbGQ1cnM3dkhiZW1nNStISVdrV09kbnNkNFBzMEdUZ0Q2?=
 =?utf-8?B?a0k1SDdWcXVQWi9nM2Nhck0yVU81Z1VKbHBJWlpydGxsZDhXTlZDSWVib2Y1?=
 =?utf-8?B?aUp1bnFPbURkcS8vdytBSlYwMmQwN05DOHBwSGFtc3k1OHJJYmduUTlRcVow?=
 =?utf-8?B?Uk5QQlUvU3NoaUhqeUc2VmJ1Nms1L2V5UU9RSktPUmJoYlNuTE55RWkyWndP?=
 =?utf-8?B?U3lIK21kRWdmcWtZWXVaTjEwVFo1Mzhlc200UHFGZTdiSTZTNFZsNi9PMENK?=
 =?utf-8?B?NThNemNzWnlkQktvR0wxSFRTYkc0SSszdTI1MWR5UWNpWVBJYTdicTdGMjdP?=
 =?utf-8?B?WkZ1MWJCdkQwalZZM0xKVm9NaHBMUUdQeC95SVZld1d2ZTBuV1J1YVBNWUZL?=
 =?utf-8?B?Vkh2N1dQL21ITFFwT2tLcDZtdE9OTnZDeDdkc0ZYc0laMDY4ZjJ2MjlyVEVw?=
 =?utf-8?B?aHpqL0FvcjI0YldaMWFWQU9YaHdKLzJzd210ZTVZZkJ3ZEE3WW1hcjRpczNT?=
 =?utf-8?B?a1N5Wno5TDRXSXVTWTZvMTl2dXhEWC9NVWpXWkJGNXM5dCtieExneUFpUWJi?=
 =?utf-8?B?UDFyaFZPMWpML0pwNkxEdjlhQlJtQjh1QXBZNzRZK3ptQnp1ek93d2hGV1lm?=
 =?utf-8?B?WWtxRjYycmFjYkhLREswbGFhSXBUQU5iZmszRTA4V2g1TmlUQlVXemRlUW9u?=
 =?utf-8?B?UlRMQkp0VWZ3SGFzQnpIWVFkb2VkL3RiaXA0VTN6cVl4VHh0T1NYbE5IWC9l?=
 =?utf-8?B?dFJ2SHNDNnppbG81OWNtQXkxSVNzblhPZXhnVzlwQUEzeVg3UXpjNUNsQnh2?=
 =?utf-8?B?dUJ5ZFhCem5VNldWb0RuSEVXeDM0cFVpazJkcWhqNnJtV0FMQWh1MjllN3lS?=
 =?utf-8?B?ejNId2Y5am1LZ3lPSGNzRnVza2FBeUNtYys3djhyNFZJd2M0LzFLdlREeUVr?=
 =?utf-8?B?MDc5TVFQSFVNSVhZQmNIWEVaeVhXL05McG1RQXozTHVGaXpqMCt0QWtrQ3Fu?=
 =?utf-8?B?WlZPRVA5RkM4M1o3TFJ6Q3BJaVBxVG02ZWx2SlZsZ3dGZkVISUVTcDQzbFB0?=
 =?utf-8?B?WnlPcDdsc2pYZTY4TWpaUFZJWkZGcHJMZmlqeGp0dFZPZHRFKzNKcUNpYkZG?=
 =?utf-8?B?N0ZZalo2cW1rdzBQY09zTEhlSzRoZmM3ait5cFRsUFNXM3o0M015WHc3VnFo?=
 =?utf-8?B?b0N6MEpqSHA3a05sbFY2S1NEMitSRDJ6T3hSRGdkQUU1ZzVyN0tzUmVTR3c2?=
 =?utf-8?B?T21DY05abE1KUURrZWtEemhPaWVWSFRkTXVPUTk4SnJ3SDRGelpLRjg3Z1Bo?=
 =?utf-8?B?RWhPUW9rdE1kVm5nUzRxQVJ2OU8xOTE2anRyZzd0QWh4ZWhQazZjWEdhbE5Q?=
 =?utf-8?B?bGNFWTlJQzVZUHByWVhUNmNPQS9hTkptYjk4dGl1Vkw4SElCUkdBdEtLLzFH?=
 =?utf-8?B?YmdsdWlKS3Y0T3BZQStjL01jVGwvbHBrZFR0enp3RXRPTlN3Qy9aMG5mZTFX?=
 =?utf-8?B?dGkxL0dtYnFua2p6c2o4aXBSNkdhYjlrMVVjOVE3RGRaTHp2VUl4clNNNHhX?=
 =?utf-8?B?Q0IwcmJGMVRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVJBazRNOGxmWjc3TXprRHpvUFo0YWYrVTZJUWVNc3JhakdmSDNGcWpYQ1BB?=
 =?utf-8?B?RTJ2dldIYk1RVUVUeCtSR3BCYUJSVmlGMTJoQzE4WnBMWmJLMlNGTm1BazE5?=
 =?utf-8?B?ZUw4Z1ZGOHhNVWpHSnYyeVA0aDZBdzR0RWttcFV4VWtkWVRsR2s5dFArSGJh?=
 =?utf-8?B?TTE0b3pHaHhhYllJT3FIb1JKaHFyKzRNRVNPdGtSWUhHYTdRWW42WDgzNlJY?=
 =?utf-8?B?QzJvUFIyZzRzeGlWSys0Vm4zOEx2eC9wc3R5a05leThLNElOcWdibTJMUTRP?=
 =?utf-8?B?MGR4NG9GOEN3WmhiNmdxVHZLTTNEQ1RnUjVtZG9TaVF3U0NZS1pGMXg2NWly?=
 =?utf-8?B?cFFlZjJPSmRtcHRNdW0wcGl0YnVGekd1V1VlN1hJdll6RTJ6NjlZUG1IbTU3?=
 =?utf-8?B?Q05pTnJoeGVJL2UvNU0wTXp6QkZlUGJIYzB3eU05WmE1Tnl0OVFGRVVxNVZR?=
 =?utf-8?B?aDlvMTRzck5xWW9tVCtuRWl0dkFYV1dJVko4eGwxZU9GM05jM0M2cHJtcnpB?=
 =?utf-8?B?cWxmV0s4KzlWQXVMbDAwNEdWd2RBZk4zc0pJeWg5ZldUZ3cxTzVFNTNXZ1Yz?=
 =?utf-8?B?TU4vQXdBWjdGZnNacnhBRXdqOUVPVk9nejJEcDZZczJ6VjRhWTlrMVN6Ly9D?=
 =?utf-8?B?bjlhUE1VQXB0M2tVaEl4aEZxMFAzSjEzM21kUE5BeGxEMWJJY3NZM3pNYkwx?=
 =?utf-8?B?ZzdEdHhUQ3BOM0tzVnBVKzM0YW51bHhOazQ0ZExkNlVGQWFnME1tcTRISGEx?=
 =?utf-8?B?WjV3K0NYamRXVkNuRlB1U3dnNHRGVnpoM1NMcXdUdFpPRVNMZGZ1NmwxT2hJ?=
 =?utf-8?B?OWZBaUUwMUhnb1ROcWxGY3FseFpDT2FNSjZ1VWxzSzVINGhqOWtKQXNOam1O?=
 =?utf-8?B?VXYwQXRUeGROditjWDYycGlnd2tULzJUMUdyd0hFdFppaFpGcFd0RzcvQldt?=
 =?utf-8?B?RDN0SUtrLzNyZTNaRVVYOHBLKzZybFoyZS8xS3h3Nm84aEpMUmgxSTBaNFY5?=
 =?utf-8?B?ZGdRb3lLZExCc3liWHJSTll2MG94MnhjemRwdC9vdUE2TUFLL0QzdUZYUlUw?=
 =?utf-8?B?VDc2OFZveExLZU9BN1ZsRU5xYUJ1YnVQYVhmdnNJQ1UvQmtqNEtOa3JMSmNE?=
 =?utf-8?B?ek85dXlzSU94bzRVMGpkdjdrdU80ajJYVlZ4RXlpbGFVdkhvS2hTOVZtQWVr?=
 =?utf-8?B?OUNZNE0yM09vN2Jtd2VsOHZ0UkZOWDB5MnY2aDJwenltQlEvSkF1OERXK3lH?=
 =?utf-8?B?dENUVUJJbDd0MkxNUXQzQUpzTnoxdjI1OGE5OFRyS2xSYjNoRFllWGRCa1Qy?=
 =?utf-8?B?OTdBTEpWS0xuM0doUGxYb0xIRUNRUldPTXd4TFRKRFBhZzZEYkVSZ3E0Z2Rp?=
 =?utf-8?B?bE1qdVNzZndzelhSNE1UNVA2cXF5clM4Y1I0Vmdpcng5cHF2c1FTSi9GUEc4?=
 =?utf-8?B?L3k3VGcxbWg5dlM3VlJSYkhtalY4c05EdUR0WGx5VDlINUJkbUJqdDVoL2pN?=
 =?utf-8?B?L0EvbFJLWFRoTndRSHVCNW1nUGphM01HV1RGT01GRzdpY0NKclJuMVM1alpn?=
 =?utf-8?B?WnB0d1NCRkxGMW9zZDJpeDFCVURuTXowbnRMUUlkMWZQWFFwM1FKcWgraGVa?=
 =?utf-8?B?KzQ4NlVxVUtDZEJ4S0txZjlyWlF0MDJST0o0K3NqKzFvYXdVdjFyak9vdy94?=
 =?utf-8?B?cCtYb3IzTXlTTzVHaCtXcGdCd29UOFYzeDRJbk1rZWhQZFBubTUrUGtxWk5x?=
 =?utf-8?B?K2J0amcxd2IydVpOdUQ1aW8rSUNWcVltZHZFZmtwb285MEZZVHpVT3hYVm0x?=
 =?utf-8?B?M1ZHczdYZjBEd2tUUXlRM2NVbE56WEZiTHFGNDVGWlhwZDM5M3VFL1p3STU1?=
 =?utf-8?B?bEI1OFR3TjVPZk9mTHArYVRDZDdGcjlIa0ZTdWNtRVB4SkJ6Qktxc1JOdk1D?=
 =?utf-8?B?N2JqQzBBZVBRRk5qc0dZbU5hTXBrYzRTMnlwekVoK2RWRTRDYnh5M09nYzJL?=
 =?utf-8?B?dlFlVk41RDhRN0VsNHBxbjN6TEh0am1GWnF2QWpXRVZZNCtIZVd1QWZlOG5J?=
 =?utf-8?B?QlNPbTZ3RExueGlaU2RtcGFSUXZrRys4am9QdFhFVXZ3OHc5Vi9KcEIyOHNL?=
 =?utf-8?B?c2s0MDBrd2QxcVlxU3Q5RitGUllwR0dwSEpJOXMySDA0U1B3S1pUS1RvVVZW?=
 =?utf-8?B?SkF0bWRuR0RJUExIdzF0ZzB1R3RnNXNid3ZJSWdyNkNsTHlrMjRxY2tvMkFH?=
 =?utf-8?Q?vXjy+09HYEsqxW4hiVzhxx65+W81r9h6TyW4WnY780=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a5cd47-02ab-4006-d8bc-08de2183387d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 00:34:20.6877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbtqJm4PWIzjDWGGtsLt/hys9VqqDoGt3DvSvv1CrvDOSf8Qb7oW1REupPnNSFQ1KvOUuKGRKmJk/mBo4YnwzPLlu8TAzWcQRUNqjP9yVgJ9HXPX9Pctbl2pNUfASBhM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR03MB6211



On 11/11/2025 3:51 pm, Krzysztof Kozlowski wrote:
> On Tue, Nov 11, 2025 at 02:17:38PM +0800, niravkumarlaxmidas.rabara@altera.com wrote:
>> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
>>
>> Add compatible string for Agilex3 SoCFPGA board, which shares the same
>> architecture as Agilex5 but with two fewer CPU cores.
>>
>> Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
>> ---
>>
>> v2 changes:
>>   - Add separate agilex3 compatible instead of using agilex5 context.
>>
>> v1 link:
>> https://lore.kernel.org/all/51ecc7f4eb7e419c00ee51fc26156e25686dfece.1762756191.git.niravkumarlaxmidas.rabara@altera.com/
>>
>>   Documentation/devicetree/bindings/arm/intel,socfpga.yaml | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
>> index cf7a91dfec8a..e5a8141dc6cb 100644
>> --- a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
>> +++ b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
>> @@ -21,6 +21,11 @@ properties:
>>                 - intel,socfpga-agilex-n6000
>>                 - intel,socfpga-agilex-socdk
>>             - const: intel,socfpga-agilex
>> +      - description: Agilex3 boards
>> +        items:
>> +          - enum:
>> +              - intel,socfpga-agilex3-socdk
>> +          - const: intel,socfpga-agilex3
> 
> This is confusing, where is the fallback? You said this is fully
> compatible with Agilex5, no?
> 
> Best regards,
> Krzysztof
> 

Yes, I should have "const: intel,socfpga-agilex5" as well for the fallback.

+      - description: Agilex3 boards
+        items:
+          - enum:
+              - intel,socfpga-agilex3-socdk
+          - const: intel,socfpga-agilex3
+          - const: intel,socfpga-agilex5

I will add this in v3.

Thanks,
Nirav

