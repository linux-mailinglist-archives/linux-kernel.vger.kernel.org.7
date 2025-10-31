Return-Path: <linux-kernel+bounces-879476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F73C23356
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CBA940112C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA56283FD6;
	Fri, 31 Oct 2025 03:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Pyk+P4/L"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022129.outbound.protection.outlook.com [40.107.209.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D2F27FD5B
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761882601; cv=fail; b=EU8jeA54Lxq5awLxsd2pjl5ByWhPb+/+pnT8GsO13pLhnjh9QabRZc/Y/JgZZDV6TWMg61Cl6d3gxNFXQdxhBfGkN/NL1/4I/k7l7P+nFgo3leJeR0ZsGyd4byDa2qvRTWnWp5WZ9XUVUSri6TtsJR1zCbRbtt8LzKW/Ayu0iD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761882601; c=relaxed/simple;
	bh=TKdbCoISnW7yzZDk1SMzGXesYPL17Y/3GP3BbXcCZF0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ACWiF1+52Lkw1OTkGkjDLqgU8kI5RyZ1OX7Rkc01H8Z2fGOZ0/e5lKjpp268rydlMdqk7A2OZukIU2SKNldo+cN61XX2T5SMUdIklVrQc4z5dbfnPXao1FqkmoLWlGXpgXhWPcd6G1w3WOd+YFjzHhi0FFQW/Fg7yKxGkh1EmpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Pyk+P4/L; arc=fail smtp.client-ip=40.107.209.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oc7x0pQvs73WdfJA9eJ2Vk+kgU3tYxNsfj3B0+Evv4KNYUCImvyg9Muy62c7fLGFrOutx7nd8OQxKGpl9XLEQSKLG6T11bLAaJDyK2+/76KdAmIMkfc8BY+qFW9wSAFQGgXIuwdcddAUZXe3aDSusv0EsHrgysZWdsjuAzqyWEINtfaYt2NSs89KXcva6uFTE2hs84hPNle6xgkwsSqJNSBr/esc22stkJFbncFDveBFV7Qm1VBDteHgw8VrG4llfao2DsvOvRzIkdPHrtFkMqgUS/MyYQzB7hSsAT7wstDN/JVYSkpfrhLyhTDQ6YNwjhML4uahHrS2DqELwQxRHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTK2pdJjPmkHjwboRAr4omp8/rLQuHKcFq8FblOQxpk=;
 b=d2D2JeEqtA5PgfJiEkfrMvG6Gal83I31hKUOYeEe6wknLbASncgEPSzRvnUUMuzD7SZsYz8pGGd6biQBrzi9GhWUbR4hquC23b0s2yCqWmVzhBXniG6uneSUrsPyfenZUU19rw3GPmWfbvok5gPXUQy4KN7Pz2prT03MVo4fyCEnGH9sHT1LwdVOzudueDdaHv7yFwHgUCKeuvxQLkEtIobDMQuaK5cXy3IUaixbi7jTdjmAarbjZdCBMRRb8wmxmmmgT01g8oLsXKCkP+skM4BKXOzZuFWp4b3grXuhrvzBsmAAsl4rhdUV4ASugIjR5gneRdF7+rexqsZToOu1Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTK2pdJjPmkHjwboRAr4omp8/rLQuHKcFq8FblOQxpk=;
 b=Pyk+P4/LsQCE3Dg4coNHXDuopSEKhjc65Kp0uTYNGnyi20WJO8FvP0WE/Tax69LYr5KByf6qIlcbnGGq1koCDv0WwuD14eLCR4RPhZsorEEaHLCfw2mfjA4vaTzcS8sstmXdMA4E1rD/0RnUUkH3kxjJVGN5Fmj7z/RHgvA0Utg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN0PR01MB6862.prod.exchangelabs.com (2603:10b6:408:161::11) by
 LV9PR01MB994129.prod.exchangelabs.com (2603:10b6:408:366::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.13; Fri, 31 Oct 2025 03:49:58 +0000
Received: from BN0PR01MB6862.prod.exchangelabs.com
 ([fe80::8a1e:34a8:2ad9:7f83]) by BN0PR01MB6862.prod.exchangelabs.com
 ([fe80::8a1e:34a8:2ad9:7f83%2]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 03:49:58 +0000
From: Carl Worth <carl@os.amperecomputing.com>
Date: Thu, 30 Oct 2025 20:49:31 -0700
Subject: [PATCH 1/2] arm64: mte: Unify kernel MTE policy and manipulation
 of TCO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-mte-tighten-tco-v1-1-88c92e7529d9@os.amperecomputing.com>
References: <20251030-mte-tighten-tco-v1-0-88c92e7529d9@os.amperecomputing.com>
In-Reply-To: <20251030-mte-tighten-tco-v1-0-88c92e7529d9@os.amperecomputing.com>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Taehyun Noh <taehyun@utexas.edu>, Carl Worth <carl@os.amperecomputing.com>
X-Mailer: b4 0.12.0
X-ClientProxiedBy: MW4PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:303:8f::34) To BN0PR01MB6862.prod.exchangelabs.com
 (2603:10b6:408:161::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR01MB6862:EE_|LV9PR01MB994129:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c96ce9b-6722-42c6-5046-08de18308fb7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjdVQUoxVHVyZDI4SUQ0TFB4YXU2LzhUK0psVFlZMnhSQTRVRzJFYk1SWjll?=
 =?utf-8?B?ZUU4dlh3QmRmTDhyUFVLTWh6eFJFdHNWeWZlVHY3NVUrRHRSanBYTWNjMEFk?=
 =?utf-8?B?em1jdmVoZU43dUFVVkJmS1ptdjVCUWdtQzlQWVFhRDdRR3ExRzBMTXdRb1RR?=
 =?utf-8?B?VzNQb2JzeFRzeW11bHVQMEozNVFsUDdBQmUrTXRZNlh0NnBHcXRFbStZNzgy?=
 =?utf-8?B?bVhkNktxdXNYc21NcmFqRUh0OElDQ3VYZURYRTgvSnM0V0pzcStxUGFiMEx6?=
 =?utf-8?B?dzVJVk4xRGptNjVJN2J1VFBYSnE3K3Zkc2dOM0FlSHU5akVDVGdTbm5tQ1pW?=
 =?utf-8?B?Nm5tQkU5QlJMbGNzSzZCaEJtL0NPK3FUbFFCZWtXS2IxV09UVXF5ckJyOWNY?=
 =?utf-8?B?eGVGR3BrMU1iZmR2RHh0RnRpVERqVFBrUUpLSnFPTGx1NnZDZmV6R1dxMHN1?=
 =?utf-8?B?VGhwYm5FeXZBblg2UGdCWkZVakwvbDAwUXRmaUI2T0R5aGF2c1QvR0JNOE5R?=
 =?utf-8?B?QmxHNTI0R1g5b0QrTlg5ZVh5cGtocUR3OEphQ09oMVZyUGpIYWJmQ0p5bndE?=
 =?utf-8?B?Z05ZOCttbUI5NDlKcjNLRERYUVhYdXlJRzEwQ29BbGVKVEVFd3JnNVRONGFH?=
 =?utf-8?B?WjBPbkhLK0JOa3plQjZPMnQ3czkwTXNsT2E2NmI1Zkwrc3hBS3d1Wnh6VVZM?=
 =?utf-8?B?Z3BrdHQwcEtZRDYvdEdEREpMOFhSYTlWK3pSUFEyK1ZnREE4eWJFL2Q0NWlL?=
 =?utf-8?B?dmpNOWo1RlViYkZsQkJUczV5OUJkanZmclIwQVJVczl2WGVxMUFwbXBHcm11?=
 =?utf-8?B?cTR4RHM5QTRvd0pyMEExSVk3cUVOcTF4OXlHeWhNckpiYVVIQ2RYS0pvakJp?=
 =?utf-8?B?QllpcjBEN2MxOHhNSXNnZ0NKYUVjaDcxaFhqN1ZYV09hL29RTnFBZ1lxbnZu?=
 =?utf-8?B?bUpuRGhtNjBqeDNVUmZKY2pTUi9Kbk1WMGhZbmlROVB3citlQTFRbUlhOGN3?=
 =?utf-8?B?K1hXdnVrMEszVVp1c1U4eEQwWFVqUFhIaUU4SUtIY2FEVGVxdzc3R1lVN2Vq?=
 =?utf-8?B?MEdyWW5KTlExaVk0UTV1dWdIWFd0OUpLV0paanJ0cHp4Q1pWZ2pjTWdOamp0?=
 =?utf-8?B?eFZGRERXb1J3TTN3bkd3KzhZLzFJbS9vdFZUQU5NTkR4S0hLTWhsdU54ZzdO?=
 =?utf-8?B?Y1JjNFBJUjVLL3c3em1vWEhkb0tRZGJ2MDFJUXJuNFFaYmJVbmM2ek51SFpv?=
 =?utf-8?B?U25FdkNhUUV4Y3pVVE5hdjBxanc4TTgvbU9HNWNvbTA2bVJWSkZwYnRoTS94?=
 =?utf-8?B?ZjZzOVJXR1dNMk0rT3JDVThtS0Fzc2wvWUZuNVdNM1lkV2YwLzJVRTNGSG1S?=
 =?utf-8?B?anVaN2hBSTJ6aDRBUzNvRzV5SnlDbVM0Tmd0RkZJRUNzbmhEeFpkTVNBN3hZ?=
 =?utf-8?B?ZkhlZlo1Zk1jcVE4TnQ0QUQzZG5UV2dhQmxuc3d0a1dhUWh6QU5mcFpiY1Rl?=
 =?utf-8?B?TExZTC93ZUxrbVVQTHBiMDhwZndka25wQmRrZ0Mvd25aQTMwclVEL2wwUm9J?=
 =?utf-8?B?UG44N3NiMXV5eVV2a05EMVdSM1dSM2Y4SFRCR0ZJajNrS3YzZGpsZXVmVjlw?=
 =?utf-8?B?RCtQTW0yRVowNUxsb0tqWkczMFlIamlmd01WcUwwZU9YU2RZdHdkV2xxemRJ?=
 =?utf-8?B?anhlMkVIY0NWR2VGYld6TzgrUmZjWkdzMjFJSTVwM0I1dG1uS3dDUUxWRjYr?=
 =?utf-8?B?c3U3S3lZSDdwb2QyODFrbTN5UWo5OFY0Zko1ckozckYwM24wb0V0czhxUzF1?=
 =?utf-8?B?WFV5Y2VjRmhzNWF1b0o3cGVEempjcDJ0K0ovOHQrTk9CSkoweVZGaUNXQnFB?=
 =?utf-8?B?UkE5SW9FbzdwSndlc3dJSHhDZjhHbUg0Ujdua3QyNm92b2lmZHFNZlUxWnky?=
 =?utf-8?B?S0hQY2R3eTdlR3l3WjcvbG0wTXlOSGhkM2tGVmk3QXpHTzN6RWlXK29xS2FN?=
 =?utf-8?B?ZUttbG1ubWk1Y1ZoRkxrdGg5UGxXRWl1ckdNSjlkR0t4bEdHeDFhWGpiTkIx?=
 =?utf-8?Q?w05LqB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR01MB6862.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTc4b0FJNVUyNllZNHplN3Q2aU0zbCtHNmdtVUhPMEZ5QmpvQ2xMdENMZ0xI?=
 =?utf-8?B?V1JzTEkvdTVMRnRydUI1RUk3SWRUUENiVXdyV1JubFpwTXZnMHdlaENVcFNu?=
 =?utf-8?B?N2VuaC9IRGdnRmczRDZiSGQ1UE1weXc2SEgzZ3hTemxkZEFJZ2pqeHB0SHMz?=
 =?utf-8?B?YVBKeDliMW1ubGs1akR6akNoSG9EZzR4ODIrR2RZUXVnZWZwYnVrWEhBeFY0?=
 =?utf-8?B?WVlOcGdwbGloYVFDdTVNSlFSSThvS2NId2NrNmhob2ZRZ3VpYUpYVmJyY2Uy?=
 =?utf-8?B?RmpoQUpWbnc2N0VtVTlLMndMN2NGc1RuMHpDMHRZakdpZ0tuK3AvUW1hN2Ji?=
 =?utf-8?B?VTYveWJVc3FNYWg5L094QVlWZGlWdHVvU2Vvdmd3K1N0SFArNHliM3AwU2FD?=
 =?utf-8?B?T0pLYWc1MGp4QVY3bXI1bktkNkJ1a2tqeFZVOHBSc0NFQ1FtdUxLOXJYazJQ?=
 =?utf-8?B?QlJ3Tzg5WFBPQzRSYU51by9oRTNxd1JBaTdiRzArb29EWVFWZ2Zpa2twZlZO?=
 =?utf-8?B?VEFVUFhVWUZiTmdhanB6SnpsZ01HdVByN1cwZ25CUlI3cFVzUDB0ZXBQaU5G?=
 =?utf-8?B?amVBcTV2SXBpVktacmMzcGZGQlZML1c1aFpkazd5dDJESVJ1OUFuM3FBbmw1?=
 =?utf-8?B?TVhKTEdFaTdjMVZxajlFUzFCTlhxSldmc1JDVUErTWlOSFFzWFRzQm0zL0tq?=
 =?utf-8?B?bjBIdmRCK215WktQRDZ6NDBkQUtVQk5iMjRvU2RETFlVRGNVU2hMSEZmSkNC?=
 =?utf-8?B?RTV5VHpVclRCZm9XWUJWQXh2anluM0VNU0tFekM3RG5kN0pTajhxenA2ekF0?=
 =?utf-8?B?NFNIeUJla1hwMTIrSSsveExjSVVFQ0FQSUlPY3FrMnA2Z3JmLy9WV1lxMk1w?=
 =?utf-8?B?ZU1ZR0hQSTBMb3FqVHNmTmU3UzhGbG8zYmV5OTViZ1NBaVRlemRrQURhMnF2?=
 =?utf-8?B?NjN3Rmc5c1ozTVdTN3MvOENodjNVVHZ6NEJ0dFYrdUd5eDF3MmxvZUo5N0hY?=
 =?utf-8?B?M0Q1eU9lWXFvV0duem5ZRXEvalpoS0t0RTRKT3o5NUNXUVExN3Y2V09ybHNz?=
 =?utf-8?B?dC9HNUNhT1ZYbzNuajBWQzQybEsvTTVaQ1ZWZHpRWWdzakh2YXA4VStBOWZs?=
 =?utf-8?B?MDRBTHN3ZmdXNDFXSFdmM0hheXROTUlVOS9WaExyd3hBM1Vicy9DYnVFbmpT?=
 =?utf-8?B?TGR1cjg1VUpsaEIzdUVZUnFlY0p4dklkdFZEcFlLRjZNMUNtQ2tzOW1Yc0RJ?=
 =?utf-8?B?V3IzSkc0ZE5TRi8wRS96SGJqU0cxaWJibjZlQzJMaWtxdk5UTzFRUmh1NHlr?=
 =?utf-8?B?WGxDNzdHMTZoVCtpNEdHcUFWbWNQR2JXZU8xVVF1QmI5VnBaTFhDUGpwY2lS?=
 =?utf-8?B?TGgwM0hsWnVmckM0S1duYzFqdVRHV2lEUlFxZjZLMnYwbWcvV0tLYVZtcFJF?=
 =?utf-8?B?Q1JuU2F6MXQvRm1Sbkx4L0hKUi9QTE8yRmFNMzYrZDY3aVh2Z2hZbUZwUzJh?=
 =?utf-8?B?YklFbS9GaHRnRGVjUzNxdjlBM29JSllQWGUyanlCamgra3RFcFdsS1c0QUZF?=
 =?utf-8?B?L3BiZXY2ZFVrZXlnamdKT3I1YkRuYUdjVkVwUUdZcGZ5Sit5U0ZHa3FCM0w2?=
 =?utf-8?B?LzVOZWFVNjdVcDZyZDFZNjVMdDNKYWtoTWY0SFhYSGVXeUE5ZmxKMkt3b2lO?=
 =?utf-8?B?Yk5WNDlkTnpJRkEwVjFGQ1dPUXFaU0lXSGg5RElJWmhpaUV4bm00TC95QUtz?=
 =?utf-8?B?RkpCV016ZVkrOFlYN284ckJBVXA4aWNxUFJvM09Fb2N6V0FMQ2tKU21sYWlU?=
 =?utf-8?B?RjdTWVdYeHZnak9LTEZuOG5Rb0V4bmNQVHliTkVVdHhOV3ozZkh2cmREaXVF?=
 =?utf-8?B?aG5iemFpdTcwcFNVS0F6UU94WHh0aVRWZUxzTTR5WXZpRDk1VnFBWmh2K2M0?=
 =?utf-8?B?QjZRN05acHU3SWRMaUlQMWxXa2I2UlZkVTJqTG5VUmlJdG9LR0RKMW5GOExS?=
 =?utf-8?B?VlFLMG5CR1ZaOVo1WVhCRDRjTlRTRjBWeHUzMy9ZU3FHQ0VYZ2lVczZaWnJ1?=
 =?utf-8?B?RFR3SXB5QzN3SVpmaHREcWo2ZHdRSkptbmRtYlQ3bnp0N1F5bHkwVlZFMnJl?=
 =?utf-8?B?UUUwNGcvd3RVU1d0Nk5ON1c1L0RVMytZblZ6MEtLOUorTXBSNkEvL0pKaGxl?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c96ce9b-6722-42c6-5046-08de18308fb7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR01MB6862.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 03:49:58.2508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46uzFnvCg8NInmXfm2j1wBxY5xr1ht8Bcd1M2Yukvnw3FjQlTcKFGHk/ToMd6qo51AGrckAw7RrFKtCpsW1rixIuxB/t4Eqh6eVII01KsZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR01MB994129

From: Taehyun Noh <taehyun@utexas.edu>

The kernel's primary knob for controlling MTE tag checking is the
PSTATE.TCO bit (tag check override). TCO is enabled (which,
confusingly _disables_ tag checking) by the hardware at the time of an
exception. Then, at various times, when the kernel needs to enable
tag-checking it clears TCO, (which in turn allows TCF0 or TCF to
control whether tag-checking occurs).

Some of the TCO manipulation code has redundancy and confusing naming.

Fix the redundancy by introducing a new function user_uses_tagcheck
which captures the existing repeated condition. The new function
includes significant new comments to help explain the logic.

Fix the naming by renaming mte_disable_tco_entry() to
set_kernel_mte_policy(). This function does not necessarily disable
TCO, but does so only conditionally in the case of KASAN HW TAGS. The
new name accurately describes the purpose of the function.

This commit should have no behavioral change.

Signed-off-by: Taehyun Noh <taehyun@utexas.edu>
Co-developed-by: Carl Worth <carl@os.amperecomputing.com>
Signed-off-by: Carl Worth <carl@os.amperecomputing.com>
---
 arch/arm64/include/asm/mte.h     | 40 +++++++++++++++++++++++++++++++++-------
 arch/arm64/kernel/entry-common.c |  4 ++--
 arch/arm64/kernel/mte.c          |  2 +-
 3 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 3b5069f4683d..70dabc884616 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -224,7 +224,35 @@ static inline bool folio_try_hugetlb_mte_tagging(struct folio *folio)
 }
 #endif
 
-static inline void mte_disable_tco_entry(struct task_struct *task)
+static inline bool user_uses_tagcheck(void)
+{
+	/*
+	 * To decide whether userspace wants tag checking we only look
+	 * at TCF0 (SCTLR_EL1.TCF0 bit 0 is set for both synchronous
+	 * or asymmetric mode).
+	 *
+	 * There's an argument that could be made that the kernel
+	 * should also consider the state of TCO (tag check override)
+	 * since userspace does have the ability to set that as well,
+	 * and that could suggest a desire to disable tag checking in
+	 * spite of the state of TCF0. However, the Linux kernel has
+	 * never historically considered the userspace state of TCO,
+	 * (so changing this would be an ABI break), and the hardware
+	 * unconditionally sets TCO when an exception occurs
+	 * anyway.
+	 *
+	 * So, again, here we look only at TCF0 and do not consider
+	 * TCO.
+	 */
+	return (current->thread.sctlr_user & (1UL << SCTLR_EL1_TCF0_SHIFT));
+}
+
+/*
+ * Set the kernel's desired policy for MTE tag checking.
+ *
+ * This function should be used right after the kernel entry.
+ */
+static inline void set_kernel_mte_policy(struct task_struct *task)
 {
 	if (!system_supports_mte())
 		return;
@@ -232,15 +260,13 @@ static inline void mte_disable_tco_entry(struct task_struct *task)
 	/*
 	 * Re-enable tag checking (TCO set on exception entry). This is only
 	 * necessary if MTE is enabled in either the kernel or the userspace
-	 * task in synchronous or asymmetric mode (SCTLR_EL1.TCF0 bit 0 is set
-	 * for both). With MTE disabled in the kernel and disabled or
-	 * asynchronous in userspace, tag check faults (including in uaccesses)
-	 * are not reported, therefore there is no need to re-enable checking.
+	 * task. With MTE disabled in the kernel and disabled or asynchronous
+	 * in userspace, tag check faults (including in uaccesses) are not
+	 * reported, therefore there is no need to re-enable checking.
 	 * This is beneficial on microarchitectures where re-enabling TCO is
 	 * expensive.
 	 */
-	if (kasan_hw_tags_enabled() ||
-	    (task->thread.sctlr_user & (1UL << SCTLR_EL1_TCF0_SHIFT)))
+	if (kasan_hw_tags_enabled() || user_uses_tagcheck())
 		asm volatile(SET_PSTATE_TCO(0));
 }
 
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index f546a914f041..466562d1d966 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -49,7 +49,7 @@ static noinstr irqentry_state_t enter_from_kernel_mode(struct pt_regs *regs)
 
 	state = __enter_from_kernel_mode(regs);
 	mte_check_tfsr_entry();
-	mte_disable_tco_entry(current);
+	set_kernel_mte_policy(current);
 
 	return state;
 }
@@ -83,7 +83,7 @@ static void noinstr exit_to_kernel_mode(struct pt_regs *regs,
 static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
 {
 	enter_from_user_mode(regs);
-	mte_disable_tco_entry(current);
+	set_kernel_mte_policy(current);
 }
 
 static __always_inline void arm64_enter_from_user_mode(struct pt_regs *regs)
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 43f7a2f39403..0cc698714328 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -289,7 +289,7 @@ void mte_thread_switch(struct task_struct *next)
 	mte_update_gcr_excl(next);
 
 	/* TCO may not have been disabled on exception entry for the current task. */
-	mte_disable_tco_entry(next);
+	set_kernel_mte_policy(next);
 
 	/*
 	 * Check if an async tag exception occurred at EL1.

-- 
2.39.5


