Return-Path: <linux-kernel+bounces-779619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC38B2F66E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B743ABEAB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30112DC334;
	Thu, 21 Aug 2025 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="R9Y7rcUN"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2094.outbound.protection.outlook.com [40.107.96.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439332EAD13
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775144; cv=fail; b=UMm7FYDEiRCMyMmBtlmJSrdXm58fFGKJfrpJYAY2yv5q13Q8y0tbdJeNOZtZIzR4t0JEAS2QmdfUsknEgUltQlwjmShnX71r+hwHl5Yusvck+2QVH/RrmSMkCoeWn5RbPWNP/CNJKMHm7r4zZ3YEv9P8T0c7jtZzP9HZcKfKMUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775144; c=relaxed/simple;
	bh=a0YOeHU547Yf8dsYB0S9Yf5Gz/86WrxLBM4BNm3Giss=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qpr68PpjIgZXUpW0Ax/Qr+4LCMhuS+W25CXvwFSC3GFeDCLL3c+DG2zOE5YJ+orPD+mhpJWea+TW/I3zJRCLWOEY5fm0/3rJ1T9rJF44/O1kla0yaHaF0qmgRS/nhiy1yKnXSEFOcgSU++OSCfP0P4SUvoWdZ+fJcPWRYXJwHGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=R9Y7rcUN; arc=fail smtp.client-ip=40.107.96.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLdm2npmTl8qJXf3B+OahVmC+GDQHkoS4bTz/L1ftvpQnPw8z9twbMOw8et33aW1zhmR9KhlAAVybC/RUFk+zZ1DVYeqe2vznOlecbSttYP+8p6g9FCEUS60AMD1vyZ50EgQcJf59bL8JvfSbDh5Q8d0Ng+qBUcBIYRd3xhaaoxkOllL2cyDltNyOuf/9BJQq83zgfcSYw/Mo2GpwYJFX7X+v7H9K4koydSGjtjXtvy+Kt98qkjtmTr/2MJJuTBUqwAOejziHLWj0rS2W0vD7W7JlidIiHMseQizc7gH8v+DCIGuVQ/DNbvYZtDUL8xe8D2apqzDkZeVcHTi/nxAQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zX8+minUKk5gRxvCDVFJOf6rZFRhpEENtki4aD7EDHg=;
 b=m5GBCncBFeYI3XqoZ+YDxHLKa5IY24OP+QV1IlMGkTrCNf1Zi8I0jq1hnjf93T0HTu2QSmeeZPxHlgspgrAwSIn0TsinyHIDSS0Pqgjnp56ysM7It7cBHwi0yzthfWDxRRSv+gJ7iufalg0aSc5kr19cdbrP/l1sETLiPkztHINihjVgAqzB28zQjtv0Ro20wHXSTT91rKH1I5rppimUd1V8y1ofPlYEUV2fzHKDDtdKwGRJANbykZKzsm/YCX7T3pDHOfbKnVd37zcDI+5VSWisIsi/s2kWS6bAH2v1ddbpF8CW6ceX9RkkA3rdkdLZ96MQGSs5RckMDg94DGCqsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zX8+minUKk5gRxvCDVFJOf6rZFRhpEENtki4aD7EDHg=;
 b=R9Y7rcUNtRynLeIStDOpmDxM5MzRJnlcK4Wb4bKXLIpgI+nBncsyMw0uWyMhO4NeKri36e11xWe6tXgfC2VPy6esYEy6Kjb3qTWYFV3uyqvYSuTiZCwW2jC2XzmcweRD/tEZOmkVVePjSFQnLy/3ONRmEkZKZFhmFVeZY9AX9hA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 SA0PR01MB6379.prod.exchangelabs.com (2603:10b6:806:e1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.16; Thu, 21 Aug 2025 11:18:59 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 11:18:58 +0000
Message-ID: <1db2d6df-16ff-4521-ada5-da585b87b06f@os.amperecomputing.com>
Date: Thu, 21 Aug 2025 19:18:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/nohz: Fix NOHZ imbalance by adding options for ILB
 CPU
To: Valentin Schneider <vschneid@redhat.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, cl@linux.com, frederic@kernel.org,
 linux-kernel@vger.kernel.org, patches@amperecomputing.com
References: <20250819025720.14794-1-adamli@os.amperecomputing.com>
 <xhsmhtt23h0nw.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <7438bb3a-96d6-485a-9ecc-63829db74b39@os.amperecomputing.com>
 <xhsmho6sagz7p.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <d421a5ba-95cb-42fb-a376-1e04c9d6a1ac@os.amperecomputing.com>
 <xhsmhldnegqq4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Language: en-US
From: Adam Li <adamli@os.amperecomputing.com>
In-Reply-To: <xhsmhldnegqq4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|SA0PR01MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f62d7a-366a-4b39-8600-08dde0a485c1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDk2cEVIRWdhVnYzaFZjaDZxS0VpUmcyb3lKS0dyK1BQMUZTRlcxQ2NyaFMw?=
 =?utf-8?B?aGZHUjMzaFNFVEk2YmNkbHAydlZBeWgwckFjUlNqUWo1dzVUaGlNKzlXK3Rz?=
 =?utf-8?B?YjVEV2sweTVrbUxhNXNkVHJPNGhBSjFXcktSMEt4MGtRQk8zcy92emI1aVFC?=
 =?utf-8?B?MldRSmFJR040OE5tV3ZxUm9HWWIvQlRVcUtuRGxWbytiYkgyeUtmTG1PRzJk?=
 =?utf-8?B?OGVkeGphS3VDTXFvdnJkNFA0RzZQWWY3RWYybHZvRVlQSmsyUVJnZGFhVVQ5?=
 =?utf-8?B?eS9YUVpqSitBbnc0b3VmUVhIbCtkOFZQeEN4L1hlVkl2RnRvL1A3Z0JPY3NR?=
 =?utf-8?B?VnlQZ3YwSmlrbi96R2hPaTlnYnNXbTNCUnhBa213ZWhDSU40S1hVMUZBVEtB?=
 =?utf-8?B?NXFZdzBoalArYVZaVWJOZU5SeWhOZ1B3Q1hmQm1DV2lOaENHbEo1MjlxWFZx?=
 =?utf-8?B?dGtlWFBzSVQ1VXI5WC85dTI4ZXczMHhiZXk5czJjQjRlZWJjd0hqYk5TaHVI?=
 =?utf-8?B?bFI2YVJoWnYvaWszZ1BsdzZ5Rm8yUUhhWW01djBmWkpUb1B5cTB0RzZRNEVl?=
 =?utf-8?B?YmRQOGpmWEdNSGQ4cUloUENFcFZXQkdiMkN1b1ZvOCtvKzg1SEl4T1lyR3Rp?=
 =?utf-8?B?VWZrejdHWDJldVNvczMvU0dwYmd6QXlBUzY2Z1pOdjgyN291cXNaK3NIWkVz?=
 =?utf-8?B?Zk5wbmZwUEh3NmpxdWFNc0hMZ0t1Y29WWnM1K3JKMVh3ZUptc3pVNmRzeVYr?=
 =?utf-8?B?MDRMU0RwSkthcVlRUEIrSnJzMzdrd1d2eFQya3E3MnZSNEZhQTBrd3VYT0ht?=
 =?utf-8?B?Rlk3ODVlbGNXeTlOUU9vTzhDOTZSUVIxYzIrSGNJTml4SXM3QkEyekd2cklP?=
 =?utf-8?B?L1pQQUxSdmY4anRSN0hFT1c4V2ZiRjJmYlk0K3pyUlFRUzR5blpqVzBzK1U5?=
 =?utf-8?B?bG8vc0dLYkhNWStPZmoxWW5Pck5HcTZVcVNyUk5hVWw1RS83ZDhMWXFtQUxh?=
 =?utf-8?B?RUpCQjBYL21WTTE1bG94UXpvVVFiRWR1cTFwbklaMlNYUVNxOWp2TWlreWpz?=
 =?utf-8?B?bWNYVmhCdEYzbzRrYWZoMW9paUFvTmdvbnhSdkhiOG9FcVZSd29TUmd6RUpT?=
 =?utf-8?B?SDhEWlVLWWlwYmFrYTBEbVFLbFRLRElGSFErNE5ZVSs5MWVGOStLbm9DWDN2?=
 =?utf-8?B?dU5XTlZCZnNrV0RsOWhMSXBCaHNWWllabE4xZ3Jyd3k0L0RDTVFWNWtLZUpX?=
 =?utf-8?B?Ym92MWJEajcwMWc5NGMrMzUxM2MzM2c2R0VwY1Z1VENpdlVEWDc0TTJNWmov?=
 =?utf-8?B?YjBhK1ZvbGJwMjZ0Z3JxQ3VaVHFlQXNtSXBlK3JxVDF1MDNKRG43Tmk0ZkFF?=
 =?utf-8?B?VmZpb0ovaEpwNWtXRUtwN1VmZ0tDb1FSSnlwUVJNT2JRbHVBYk1hcWYzK3dJ?=
 =?utf-8?B?cm1VU0FiQlpUTWZJUm1FZk1VOE1mblp5YVluTUxVb25TdmxCWkRwMm1kbGtJ?=
 =?utf-8?B?dGgzbkx0dERoR3UxejRKeDNKK1FNMmVkOTNHNVNMTmZlbmtRNDdjR2xjK1RZ?=
 =?utf-8?B?RytwckZvZDlkV2hYTkJFMWI4aE91TUdYSnlmZkpKcHdmejN4Z2c5SmpiUVNV?=
 =?utf-8?B?dTQ1aDNxZnZPc2ZtYVZWQU1VTFN4VmEvR2I2NVpLcjBHT1lZSW0xWmFGT1ky?=
 =?utf-8?B?dExHRmVQb2Y2OWxwdndJYkEyb2c2ZDEzcU56L0hRREgzZ1orTXl1T2tzZ1Ni?=
 =?utf-8?B?WmhxbzlNUHc5WVpmUTY0UTFEcXYwZEU3dVQrQlA4cGZUUkVUR2xqYXhsbEJO?=
 =?utf-8?B?Q1l0MUV4TXZKdExmRGt4NGMrdk40U0ExN3F1bEJ6Y0VqMHB4U0JtaCsxdUpU?=
 =?utf-8?B?REFUMDlyZ0tqdlNFUE1QWFQwSTJnd1o3QUVEMEY5VWhhNzE5azNLdTVkSGV0?=
 =?utf-8?Q?7E5gNMzdxA8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXpCLzh2VkloL1laR1ZxNUhaYTgyaGJDYk5oWGI0N0FkQmlKcUtIdy94QkFU?=
 =?utf-8?B?WFFrQi8weDlrMFE1cTVyUFJyVXphMXgzR3ZCU0tuMml0UElXZjJIOTF4SWts?=
 =?utf-8?B?NTBZNWFXbDVRODZCcUVhRVpVVlh2STlsSmUvMGR5RGI4VzF5WWVab21MdzY1?=
 =?utf-8?B?TjQrenNuaGZwZWlJMksrR1kxbmxnRGtkVHU1UFljbUVGZlgrbU9uVU9GM0R6?=
 =?utf-8?B?cFZIY0cyM0R5WHZ5enJlNE85c2RMZElpRVQvZ05GOTJmZWNQcmNKQ0ZzRVpt?=
 =?utf-8?B?ejgyWHRRbVJBaU9UcGlEK1JjeGk5QkhvZjFMQWV0NFovelZndmI0TUtsMmFj?=
 =?utf-8?B?aldkeHVJSnIvMGtnVVJySzNiR3djOENTK256NjN1NE9uQ0tkNnFzcFA0d29X?=
 =?utf-8?B?RkZObHdCVTQzV1dSSGVmVXkvWXNSUWhDWWJCYkxEOXJNNEZ3SEk2bXJzNm01?=
 =?utf-8?B?RkExeG5CZUlTb0RhWGRNdVozK0wyRUVRZDk1RS9tUlo1a0lpOGVPOExvanNu?=
 =?utf-8?B?MVpmTUpMcDVjWmY4bEJ6V3lERTkvQmZzZ0V6eGxXd3p1ZDc4bzhIb1crSjhH?=
 =?utf-8?B?aStJM09VV0RYbE1oNW4xcTVjZ01yMVNjN3lWeHdrbHljR052c2diSXNNWmVR?=
 =?utf-8?B?OEVjY0l2cDUwOU10UVBjWVk3UzcwSElUNzRwejFXaE4vcjJxY0o4d1g5alZ2?=
 =?utf-8?B?NVNnaFV1UTVTSHJ1Z0NnSFZaTndXR3plc2hMbXVJZDBId0FnVkhveWFOTi9J?=
 =?utf-8?B?amRzWTdocGN4dk9WdGpFNk1Zc2lRcU9EUFM3NzBncXc2NTZsVGVwT1F2VDRt?=
 =?utf-8?B?YTQwaE9kdmZnQTdPV3M0MUxiTTMxMnJUWkcydGRicjBOM0F6RlFVN3dYU2Z3?=
 =?utf-8?B?YTgxUDJnV2p2K1B1TFVGdGZUR1hLa0d5VTJLZXZKZ2V4OERBWXpVeUxCa3lX?=
 =?utf-8?B?WmVicFJidGcvQ3RYZkZCM1lWMFVvTGk1SW5RaXF0b3FFVXRad01pMEdwWXlU?=
 =?utf-8?B?aXc5cGdEdHpSRHJJL212NFJEcnA1VVFubGVjbmgydEtoam53cFNwYnFJSjFM?=
 =?utf-8?B?MUV2VHlWKzh4T0ZrcWEzMEdKalFNLzFLaU5mRitiMkNHSXJtMUEzVjZ3SEhO?=
 =?utf-8?B?ZGN2TmdOMVBWSEVrenRMT1l4ZVVYdFVDRUJINENlL0N6azFlTzczamgyNW82?=
 =?utf-8?B?MGx1R21ZN3M5Ry8wQjNWTytsRUIwUFJOblJkaXNnQ2NoVDhZSGdDWWhpeDlm?=
 =?utf-8?B?NW85bFBKUFBrSWs5SGx1MUZhR1U3Wk1Xb3g0aHNoQ0cyS2RCUnVTMS9WWWxG?=
 =?utf-8?B?V2s2V3p1N2lKR09LVEpaQUNVeFpWVytRNlFIMWxWNGFPL21oMHdPdlgyYUtK?=
 =?utf-8?B?OVg5cThpZDdRTWhBTmcrVE45LzdYWTlkaFlLMHBLcDZNOTN5SWoxSnVDYzl1?=
 =?utf-8?B?bWJzTHF5V1JwR0pQbWN5UDBDQW4yTFhXTng1dXNxVzUvMFRTcFdaWUZRalMx?=
 =?utf-8?B?WEtTOGNEanpvdHNWL3d3V05Pa0dxeTJnODJQSnlmQ0tZYXZMSFhJdmNycWIv?=
 =?utf-8?B?NkdSUWZyYzhZQWZkcnQyU3pUL2NzWU5pVGxNOWp4UVAwRXg1cGpOWnJSVEU4?=
 =?utf-8?B?ZEFYSllLWVZ4WDhnNjVlRnBZSVFhL2NYTVNYdTNBbjBUbkx1RVpiaGhLQmpy?=
 =?utf-8?B?eTBnMHBaM2NRWlFlMnFqYXdLRG41dkNodVoxb0Q5WWJjRldpejJtS0tEOVV3?=
 =?utf-8?B?WnBZTFpIcitBbW5yeVplTWlnMmpFWkNPWS8wa3JNU3drbmhMWTAvNW4wcFph?=
 =?utf-8?B?VUh3Wmx5Y2dzcEF2Nkd2VTBkREVBSm4xS0FTdUdONlVjK0kvMlFzZlpXU29J?=
 =?utf-8?B?U3l3NUt5dmlnKzBtSVBiL3ZhZ0NIS2RVRmptdnJWUTB6Um4zUFdveWx1WDJY?=
 =?utf-8?B?TkViOXRkOVdtZVh0QUtnYlhaYlN2VzhlazZ5c3dXMHA3aGFrSHhYaWNQTlN2?=
 =?utf-8?B?dzFKNGpVRU5VR0ZCdFR3Y1hLclhiQ3hDMkczOWkxbkhMa2w0Q3NzYThyaHZU?=
 =?utf-8?B?aVR1Q3pGY09ja0h0YVBxZFk1SkYwTE5BdURrbTljNDlwa0NtTWJLUk1GZDIz?=
 =?utf-8?B?b2k4TmxhZU14RW1oQzI0MzlrdE1KV3dNVHVURXhRclRwT29FeEZDMTZ0ZlZM?=
 =?utf-8?Q?GTOYK9Fdtw4uclshXwZVpOc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f62d7a-366a-4b39-8600-08dde0a485c1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 11:18:58.4696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxdszrTvk9zeuNMWrEjN0WknXaF3ymzQtzyTwvWrW/4GUqW+geBm8StXk1SdjQw1mmGRfH5jNs0S8P2ucqrg1HpXcB0Cp7tkslfYtWXTy6MgS0aq336PvqmyDi98SC6U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6379

On 8/20/2025 7:46 PM, Valentin Schneider wrote:
> 
> I'd say resend the whole series with the right folks cc'd.
>
OK. I resent the patch series.
Please refer to: https://lore.kernel.org/all/20250821042707.62993-1-adamli@os.amperecomputing.com/

>> 'nohz_full' option is supposed to benefit performance by reducing kernel
>> noise I think. Could you please give more detail on
>> 'NOHZ_FULL context switch overhead'?
>>
> 
> The doc briefly touches on that:
> 
>   https://docs.kernel.org/timers/no_hz.html#omit-scheduling-clock-ticks-for-cpus-with-only-one-runnable-task
> 
> The longer story is have a look at kernel/context_tracking.c; every
> transition into and out of the kernel to and from user or idle requires
> additional atomic operations and synchronization.
> 
> It would be worth for you to quantify how much these processes
> sleep/context switch, it could be that keep the tick enabled incurs a lower
> throughput penalty than the NO_HZ_FULL overheads.
> 

Thanks for the information.

>>> As for the actual balancing, yeah if you have idle NOHZ_FULL CPUs they
>>> won't do the periodic balance; the residual 1Hz remote tick doesn't do that
>>> either. But they should still do the newidle balance to pull work before
>>> going tickless idle, and wakeup balance should help as well, albeit that
>>> also depends on your topology.
>>>
>>
>> I think the newidle balance and wakeup balance do not help in this case
>> because the workload has few sleep and wakeup.
>>
> 
> Right. So other than the NO_HZ_FULL vs NO_HZ_IDLE considerations above, you
> could manually affine the threads of the workload. Depending on how much
> control you have over how many threads it spawn, you could either pin on
> thread per CPU, or just spawn the workload into a cpuset covering the
> NO_HZ_FULL CPUs.
> 

Yes, binding the threads to CPU can work around the performance
issue caused by load imbalance. Should we document that 'nohz_full' may cause
the scheduler load balancing not working well and CPU affinity is preferred?

> Having the scheduler do the balancing is bit of a precarious
> situation. Your single housekeeping CPU is pretty much going to be always
> running things, does it make sense to have it run the NOHZ idle balance
> when there are available idle NOHZ_FULL CPUs? And in the same sense, does
> it make sense to disturb an idle NOHZ_FULL CPU to get it to spread load on
> other NOHZ_FULL CPUs? Admins that manually affine their threads will
> probably say no.
> 

I think when the NOHZ_FULL CPU is added to nohz.idle_cpus_mask and
its tick is stopped, the CPU is 'very' idle. We can safely assign some work to it.

> 9b019acb72e4 ("sched/nohz: Run NOHZ idle load balancer on HK_FLAG_MISC CPUs")
> also mentions SMT being an issue.
> 

From the commit message of 9b019acb72e4:
"The problem was observed with increased jitter on an application
running on CPU0, caused by NOHZ idle load balancing being run on
CPU1 (an SMT sibling)."

Can we say if *no* SMT, it is safe to run NOHZ idle load balancing
on CPU in nohz.idle_cpus_mask? My patch checks '!sched_smt_active()' when
searching from nohz.idle_cpus_mask.

Thanks,
-adam


