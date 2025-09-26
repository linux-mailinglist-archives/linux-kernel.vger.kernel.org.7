Return-Path: <linux-kernel+bounces-833635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0D1BA282B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C53517A52FA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC3327A909;
	Fri, 26 Sep 2025 06:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="QZKDaBG2"
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021073.outbound.protection.outlook.com [52.101.57.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B0C25FA05
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758867289; cv=fail; b=G33JXJqc21V7vSnlfxQ+dO34namnlwDUa4HhHBNpqAWCDe7LdXxKirgqt5Zvdk+ZIC4u4LqCufoM29ueQCG8B7FXK0ShOeiHleL5JltcRbIFcT4yVQGE0cyFRMcG8rLvgWHfYlkDNKsMQETWArquutDDQvobmV3GEOEKKYwAXgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758867289; c=relaxed/simple;
	bh=XjrIzRsms+6o9wZE1AzkPtF5SkDH8fA6r0k6Nbq3ybE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZGmbNJzWW8Ee5f1OMpLQrJZH+glRdVhSCjY/srpryjoxBrxGkIskVW1k8DZFFdP/w5pcAWdKyqYlTtfp1poru5OEoEabMe3TVshql9tkR0tgCcgLLgWzSJGop3SsI79v4Es0DwQro8SHV+RNFwIzPoCsKb9H3/Ul8jZToHoAjAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=QZKDaBG2; arc=fail smtp.client-ip=52.101.57.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ut4n+hugvwNyRDc6N7wLRRzGXwOsqxZ8dn+kQtjKwUV+9RIWBG8doyHz1BR24aBIiqsoLptK4Ps5NHVPJ9Al7ry1dRRPuOACLz8asdZ3Wjcj5PAD8NxDdXx1rrFJGAeMdOF2jkVTH5QOnalKW50FWudpvr9FRUQZ9E86J3XMCdNEaQD6crZMPXRDSUZWULM5LBG8InXjDogJHAFkVPk0D0aNDsKLjZgqTurT78CEnsbXRHHwwHMcUgDMLATMp3cqi08D2LYtV2to87v9ukRbuyBNRhuxkHurBP8bJC7Tl9rHnDgw/LT3YSxyW1zXkMY+TEZc4ueE14PmY/q+w1tpvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjtvG5Laowbm0Z6cFFWisZzjmXYqDAynk89ZT0jEK/A=;
 b=VH3FAjx0M8N93d0QS1yl+IQV4DiMFAx0q80WJNlmETqbgEFpGh22cSfZY730QhOAlsH8Heg4G9GZeJJ6710W0azo0ivb3p71enJKusOK+ReBCHdXRJZnmhvPYNAv+1tnUFCNNMxOoGDH9/4Hdgzakd6LZESkCgD5b+i/J+zZswM05irjETRdp+4gipPbA/Gc6A5i1Q+k0P3U39jQ3/vekB5q8e0xI+9sYRjl300c5Uyj5luTZu9ns2fV3p9GKYUvlUITpCaHhQVVlaokKE5ZQLva1ucpHJozqJRHgGh/da2mXShM86e+nl2Rr18maZVKx5BRgAp96aVvsFxm0t23nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjtvG5Laowbm0Z6cFFWisZzjmXYqDAynk89ZT0jEK/A=;
 b=QZKDaBG2eZEeinS8fPgEyz0NEVgyasFeV8kUZWKFXxqywE5JjfkZkqelPwKoWIJH1k4Kuro0au6C6kVFKRIdg4PfhAgD/ixYTJLPU6/FNixvaMk9tWj2QEQ6/al/C9bcqjWcy6Yzpts1Gzy6S0bq4Mtcb1wBo91yBiSC6RMUBys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 CH7PR01MB8785.prod.exchangelabs.com (2603:10b6:610:251::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.10; Fri, 26 Sep 2025 06:14:41 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%5]) with mapi id 15.20.9137.012; Fri, 26 Sep 2025
 06:14:41 +0000
Message-ID: <baa45b9a-d8ef-4652-a3c2-83596216fcb6@os.amperecomputing.com>
Date: Fri, 26 Sep 2025 14:14:19 +0800
User-Agent: Mozilla Thunderbird
From: Adam Li <adamli@os.amperecomputing.com>
Subject: Re: [RFC PATCH v4 08/28] sched: Set up LLC indexing
To: Chen Yu <yu.c.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Libo Chen <libo.chen@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 Hillf Danton <hdanton@sina.com>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 Jianyong Wu <jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>,
 Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>,
 Len Brown <len.brown@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
 Aubrey Li <aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org
References: <cover.1754712565.git.tim.c.chen@linux.intel.com>
 <959d897daadc28b8115c97df04eec2af0fd79c5d.1754712565.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
In-Reply-To: <959d897daadc28b8115c97df04eec2af0fd79c5d.1754712565.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5a::15) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|CH7PR01MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 8533b52e-d464-40ce-e3af-08ddfcc3fac2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cER6M3J4RkpDYlBpZDZyT2xRVUtyY25XVXVpVnNxVVRRM1lYRnA1TmZFcHR2?=
 =?utf-8?B?T002OWRCWkFvbmJrL1gxYUlrWXNoVXpDbnJtTUQ5cUJVa3ZwbzZxRkQ4T0Zn?=
 =?utf-8?B?cFd1Q29ncDJ5T2lqMGJFUWNlYk9FbXllT1I2a2FtVkxlbzUvU2dYUE5ob2ZM?=
 =?utf-8?B?bEdMa2hINEVHbEVmS3pERnhhL3RFaFhuakR4NVFrV05qbXpBNzRHQ0NWUkpW?=
 =?utf-8?B?V3lvNHhJSTFRNkNqRTJZUElaOWJHbGIwWXlGZFlFaUkrcFRmQStyWVdKbFYv?=
 =?utf-8?B?c3FrVkdQRk5jdTEra2xZS0hEUEd0dWFSYW9JcXJYcEwyZEM5WEhqVzJoMUx2?=
 =?utf-8?B?Z29OWEJHeHpOYmpsbnliOUhOSk1hNHhLV05oTmdpQy8wa2hFejJ5UCtDRm05?=
 =?utf-8?B?eHB6V2tTNmZXVVA2UUhCZWxvU1JWSXlLQmlzV0Z4KzdhZXRmVkp4QzEzRU83?=
 =?utf-8?B?NWpaQ0ttQ0xHWVc3U1ZHRks5K290RStFV0dnQWkwSUlnR0NXZFBqZnQwcFp6?=
 =?utf-8?B?QWtYNDNEWUl3ZXc1azJnVHdpVWg3UkZyWUVDM1ZPNGJKbG9TaGl0RCtzUkhm?=
 =?utf-8?B?eW8zTFBDbFJtY1NxSDVzN0R4THBadkNlTnBxY3ByRW50NHJIanVGOHZUTFBU?=
 =?utf-8?B?eGNob0ZHa3VqMVpkdkZjWkkzWEtqeUhPZDVnSzNrY2pURDMzSHdRVDhETUxs?=
 =?utf-8?B?WWZKQ1NoMEJLMlBNVEZURHFlZzhaeWlJVG54Rm8zeEprQkNiUnpkcTgyemJK?=
 =?utf-8?B?NUVlY1FXcWJ5ZHBwRzhKMEJCT3NKVmtyTDlSYy9nZitMY3dYc0VxM0ZhZy90?=
 =?utf-8?B?WXJ3bHZOenBpM3EzRFNjQk0rcWcxY3o2NUw2SGdvK1REYlYzMC9nYkY3dWJp?=
 =?utf-8?B?ZVZhNHZab29tMndSY1VRaG54TlFVK1ZIUHMrSlJGSmNtZ3hZUkpoc2ppdnRq?=
 =?utf-8?B?U0ZFMmJFemtuWjhkM2dDdTVqdytmbWd4dVduYW4vTVpma0dVUkZwVVV3UWgz?=
 =?utf-8?B?TVV4SE5oWjlFVFUrQmpyRStNdkNhVVR6TlZUdElqU2xvcTFhQjBrZzVYMnFI?=
 =?utf-8?B?TWViVGxTNGs4RmVMdFc1cWxYOU9vMWlNczA0V2FxOHVTRWRjRk8zTjE1N0FO?=
 =?utf-8?B?MUlONGxhZzNDeGhDbWRucUxFNVYwNnlhbGhIVzlUTUR1WENzSEM0UkdXWDlr?=
 =?utf-8?B?ZmFQM2pSNVdYYkZCd0h0bXZnVzNLanhZekYwblVlaW12Y1lGbUZIQUVQblMr?=
 =?utf-8?B?YTN0VHltcnJTbkh1RmE1NkQ5SDk5MXlBa3d3Q2hhN0R6c1BBZWNFczhUSEhy?=
 =?utf-8?B?UUxUbkNJRktnVG5nOGJoZmNKSExXVXZuUk93UWpiQjFZcWN1L2VsdDBRM3l6?=
 =?utf-8?B?VkI5cEhtQzg3UnhXcUZYMkVrNE1BOGQwMzRJK2Q1TTFoNTlXMW11Y3RudjZQ?=
 =?utf-8?B?WW9VdFpkY0VhamdFS2g2bmd2UHpiNUhFMGxmK0dmREpHa280K0ViODIrOEJ4?=
 =?utf-8?B?emp0SnNUSUVya2lhaG01TVl3SzVSbXlwVXMyL1BGVVZ5SjEyYmkyUXUyUVgz?=
 =?utf-8?B?OE54N1JUTWkwV3cxclVYVmFyYWpCOHJIWTV0Wm83NUI5clQyR0N3bDBYaHpq?=
 =?utf-8?B?Q2svWnRyY0VIVkJmNHM4WmRWbkFiZUFQNnRCdzBBZStmOVJLTTBDYXpyZjBo?=
 =?utf-8?B?RUtheUgxcS9CNFY5NmRUWFdoRVlQc2crVVJLZjcySlF0QXJiek5JSm9UZGF6?=
 =?utf-8?B?TVVobTFmSnhJUC9OemlmMHNZSlAycGNzcjdTci9ZVTd4UG14WTNJV0ZocUUv?=
 =?utf-8?B?SVY2MHNaR1BSR2VIRHhja2xNWitRUzJBUUtMcmNkOGpVZ0s1N0VkQ3VHcnkx?=
 =?utf-8?B?R3MxbGZEcnVwTmZiRGhEZUVWMjBIRlhGUFNDRkMxNEMwR3lSUW9rZTVBRHdw?=
 =?utf-8?Q?DGUXVTFSXx+IMvoBCyPXoenM/4RKwmna?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGxQRWZUU0ZtZ2VTWDl3VDRQZ3gwcDNmN3lxQ3g2ZUg2WEthZ1VXMFU0NE9y?=
 =?utf-8?B?bXdrUGRuSHZsd1o1cmZTZzF0amRXUC9pY2R3YmhLaEtFdHZ4NCtwaUk3d0cy?=
 =?utf-8?B?VUsxREpqZy9Kek5yK2NjbEphUkZXdWF1UjZTV0hrdklxbDJ1VklCMTBGNjN0?=
 =?utf-8?B?Y2Jxanh4NWxkVTd6Y1ZoNHp5UWdhc2dDRldVTVpyYjg4YU14UkdTQnNLY0w4?=
 =?utf-8?B?RXFEcXpNRzBTWk56R2QxK0ZOUDQrMGVNNERnRk9SYXBIcjgyZGkyeG95Zlcw?=
 =?utf-8?B?bmxySTlyUHU3cjVPSU5tSWc3S04wWk5GZUtBVEVPUUQ4eFBQZzdJcGx5bWlq?=
 =?utf-8?B?Rys4YUd2OWg2SDBBZ3VVT3RTb1VKeDFEM0VnUWRRRWNXb0Q5VllXM0tBekY3?=
 =?utf-8?B?UVE0WVFXYkt0YnBmWEpsRUgzVG1WcHZpeksyZGovY09GbmJqYllkTVBYWmdu?=
 =?utf-8?B?RGY4RGsxemRNV1FSVGt4YWl1L2xIaWh2Tm56Q0ZDYUxGWGZZR0kraGlheWZY?=
 =?utf-8?B?a00wQVppMDBTbEN3YnVIRWxINHFhcUFmdzZ4d1ZHQkZHQk5yRFRkWUFlOUV3?=
 =?utf-8?B?ZFVJNmNQcTZjSGxkcXlJS2FUQlFnKzRIcUx6WUVuaXBHNXhlNWZmOU9lZU56?=
 =?utf-8?B?aDZuVmpYUmxkTVU2bEtSNzJNUjRSUjRQeFkySUZCUlpSOTh3VHkvUWNFTno0?=
 =?utf-8?B?N3lkdlpqM0xxY1VQaGVqcVJQQldXdnBiQ3dtaGVlL3V1eUcwNUs5MkZUZURp?=
 =?utf-8?B?WWlybWQwckl0N0pQclFWbjhCVHQ0NHZpbDJ6a3IxN1JHbkZvVGRKb1VOelJY?=
 =?utf-8?B?c1h2TVFqaEV3QnoyMDIyQjJiSUhvbm04SlBmVTV6RzJ4dWN4cjRDejFLQlJj?=
 =?utf-8?B?K3UzZXJseCtZWUVOSVpLWmVLVDE0bmxIOTZwZjBqaG9zaTZsMWF6SG82MlBR?=
 =?utf-8?B?MUkzdW81cjhVOHpIUW14cDRRZVRMZTFFUzg0dGhuUkdrVTI2TUh4amR4ZFRx?=
 =?utf-8?B?Vlpjd0pUTTJDWDloYzFia3ViZUxNSi9jbnY2ampQUlNWdjA5K2Y1L0RMRDhC?=
 =?utf-8?B?N0J1Ujc1MzNhYU1FODE4YmtLL0NXZFpSTlMwV000WHRkZXRnQVR5U1ltMjhT?=
 =?utf-8?B?RGVud3N1L0NoM0VIcUlVc1AraVR3anpPV3NDTS9xQyt3Q2tYcDJxeEdTM1lq?=
 =?utf-8?B?ejNuYUN2M1RQL25nVlNRTTRpdDF1cnpDdTZ5VGtDcWNmejVJSGJpYmJhM016?=
 =?utf-8?B?bUovczFRd2xXZTNBS21sa2o5MDRlV1hBT0R2MHBXZzlrVWc3bXVMcnUxZDdS?=
 =?utf-8?B?Wm42N3lDejk4cHVCV0xGdHdDWXgzcGNRTTJaMEppU2JBdy9OYzJTZWhFTjF6?=
 =?utf-8?B?bW1mOU9UdjlSU1JZQnJqMTBYMkRTM1EwVS81M2FESDFKZWhTUGd6K01qdU1R?=
 =?utf-8?B?eXErWU84TkhmY2l5MEpZK2dXREVXdnV1TGpzN1R6VjFiUUFIcHI4VFlZc0Zi?=
 =?utf-8?B?cE5uY2g3SUJNOWVEL3V2WlZCNG1XNVhiQXRQUFJ3SkwzZERjZTN5ZmY2UHF5?=
 =?utf-8?B?OXNqN0ZiUThnYnhvbFVOVUFvTGtvYzJ1eVZmOStNWkpOYjl1RGpHV0hXSjV5?=
 =?utf-8?B?ajRyQkw0MlZWbTRvRnora1RmWWFWM0dqc2JVWi80U090MHhpOVBmakw4QWFV?=
 =?utf-8?B?dzBOSHpnNjNYKzJUSmlsNmkwYitFaVRqeWV6ZUF0em1pQUd3emdDeEpGMm1n?=
 =?utf-8?B?bzVKZ3RLa2l0bE9VRXp3WDVEWmtndWhTaVpEMjd5eExseTZQeUhCa3lKU0h3?=
 =?utf-8?B?eHJ2c3VGQXJPRVVJaVY5ODE2bG9IUnJxYjFGenc3aS9qU1FIUlRFY3pIQWpa?=
 =?utf-8?B?eE56eE9pNDl6b2J0S0ZmRHBlcFJJRTYreWxSNXhidy9hK2E5SU1iZi8vUndL?=
 =?utf-8?B?VDNsa0hoUHhDWVBHdlM0cE9WcXBDMDR0b04yMjFDRmxHM1VHTzd4RjNYV2ZD?=
 =?utf-8?B?WWN6OVZvTVYwMlVkeklRZWZxOE9lRFFBWDlvQSswUkRTTUI2amRocDdCWGtu?=
 =?utf-8?B?MEpCcndiblV3N0h2WGFHOWgzeW1sQm5PbDhIYXd3VytjeC9xU0lYVUNKQ3pG?=
 =?utf-8?B?ekdVSU1Nei9OOGhsek9LdjhHN0grRTczankzRlFHVEo3alhqOTFWcU90aUVE?=
 =?utf-8?Q?lpdLmb2sieT+Ebq61bShtmo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8533b52e-d464-40ce-e3af-08ddfcc3fac2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 06:14:41.3665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOqOJHsBClEsetZJhgBv2VwbEQg94sfql4G6s7xA2jJkfUIEF68CVnsQJ3DAUFVSYW/hz99++K6lFciLCP78yIy12wJQp+j4OGkfRwnCqWf9CPaYtjblGyy5/unwsDCT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR01MB8785

Hi Chen Yu,

I tested the patch set on AmpereOne CPU with 192 cores.
With certain firmware setting, each core has its own L1/L2 cache.
But *no* cores share LLC (L3). So *no* schedule domain
has flag 'SD_SHARE_LLC'.

With this topology:
per_cpu(sd_llc_id, cpu) is actually the cpu id (0-191).

And kernel bug will be triggered at:
'BUG_ON(idx > MAX_LLC)'

Please see details bellow.

The bug will disappear if setting 'MAX_LLC' to 192.
But I think we might disable CAS(cache aware scheduling)
if no domain has 'SD_SHARE_LLC'.

On 8/9/2025 1:03 PM, Chen Yu wrote:
> From: Tim Chen <tim.c.chen@linux.intel.com>
> 
> Prepare for indexing arrays that track in each run queue: the number
> of tasks preferring current LLC and each of the other LLC.
> 
> The reason to introduce LLC index is because the per LLC-scope data
> is needed to do cache aware load balancing. However, the native lld_id
> is usually the first CPU of that LLC domain, which is not continuous,
> which might waste the space if the per LLC-scope data is stored
> in an array (in current implementation).
> 
> In the future, this LLC index could be removed after
> the native llc_id is used as the key to search into xarray based
> array.
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  include/linux/sched.h   |  3 +++
>  kernel/sched/fair.c     | 12 ++++++++++++
>  kernel/sched/sched.h    |  2 ++
>  kernel/sched/topology.c | 29 +++++++++++++++++++++++++++++
>  4 files changed, 46 insertions(+)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 02ff8b8be25b..81d92e8097f5 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -809,6 +809,9 @@ struct kmap_ctrl {
>  #endif
>  };
>  
> +/* XXX need fix to not use magic number */
> +#define MAX_LLC 64

The bug will disappear if setting 'MAX_LLC' to 192.

> +
>  struct task_struct {
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
>  	/*
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3128dbcf0a36..f5075d287c51 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1183,6 +1183,18 @@ static int llc_id(int cpu)
>  	return per_cpu(sd_llc_id, cpu);
>  }
>  
> +/*
> + * continuous index.
> + * TBD: replace by xarray with key llc_id()
> + */
> +static inline int llc_idx(int cpu)
> +{
> +	if (cpu < 0)
> +		return -1;
> +
> +	return per_cpu(sd_llc_idx, cpu);
> +}
> +
>  void mm_init_sched(struct mm_struct *mm, struct mm_sched __percpu *_pcpu_sched)
>  {
>  	unsigned long epoch;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 83552aab74fb..c37c74dfce25 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2056,6 +2056,7 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>  DECLARE_PER_CPU(int, sd_llc_size);
>  DECLARE_PER_CPU(int, sd_llc_id);
> +DECLARE_PER_CPU(int, sd_llc_idx);
>  DECLARE_PER_CPU(int, sd_share_id);
>  DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> @@ -2064,6 +2065,7 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
>  
>  extern struct static_key_false sched_asym_cpucapacity;
>  extern struct static_key_false sched_cluster_active;
> +extern int max_llcs;
>  
>  static __always_inline bool sched_asym_cpucap_active(void)
>  {
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index b958fe48e020..91a2b7f65fee 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -657,6 +657,7 @@ static void destroy_sched_domains(struct sched_domain *sd)
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>  DEFINE_PER_CPU(int, sd_llc_size);
>  DEFINE_PER_CPU(int, sd_llc_id);
> +DEFINE_PER_CPU(int, sd_llc_idx);
>  DEFINE_PER_CPU(int, sd_share_id);
>  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> @@ -666,6 +667,25 @@ DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
>  DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
>  DEFINE_STATIC_KEY_FALSE(sched_cluster_active);
>  
> +int max_llcs = -1;
> +
> +static void update_llc_idx(int cpu)
> +{
> +#ifdef CONFIG_SCHED_CACHE
> +	int idx = -1, llc_id = -1;
> +
> +	llc_id = per_cpu(sd_llc_id, cpu);
> +	idx = per_cpu(sd_llc_idx, llc_id);
> +
> +	if (idx < 0) {
> +		idx = max_llcs++;
> +		BUG_ON(idx > MAX_LLC);

[    2.793048] ------------[ cut here ]------------
[    2.797737] kernel BUG at kernel/sched/topology.c:682!
[    2.802957] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
[snip]
[    2.917450]  update_top_cache_domain+0x248/0x260 (P)
[    2.922493]  cpu_attach_domain+0x170/0x250
[    2.926653]  build_sched_domains+0x640/0x7b0
[    2.930989]  sched_init_domains+0xbc/0xd8
[    2.935062]  sched_init_smp+0x48/0xd0
[    2.938778]  kernel_init_freeable+0xf4/0x148
[    2.943115]  kernel_init+0x2c/0x150
[    2.946658]  ret_from_fork+0x10/0x20
[    2.950288] Code: d2800001 17ffffc7 d2800000 17ffffdf (d4210000)
[    2.956481] ---[ end trace 0000000000000000 ]---
[    2.961170] Kernel panic - not syncing: Oops - BUG: Fatal exception
[    2.967540] SMP: stopping secondary CPUs
[    2.971529] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]---


> +		per_cpu(sd_llc_idx, llc_id) = idx;
> +	}
> +	per_cpu(sd_llc_idx, cpu) = idx;
> +#endif
> +}
> +
>  static void update_top_cache_domain(int cpu)
>  {
>  	struct sched_domain_shared *sds = NULL;
> @@ -684,6 +704,7 @@ static void update_top_cache_domain(int cpu)
>  	per_cpu(sd_llc_size, cpu) = size;
>  	per_cpu(sd_llc_id, cpu) = id;
>  	rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
> +	update_llc_idx(cpu);
>  
>  	sd = lowest_flag_domain(cpu, SD_CLUSTER);
>  	if (sd)
> @@ -2456,6 +2477,14 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>  	bool has_asym = false;
>  	bool has_cluster = false;
>  
> +#ifdef CONFIG_SCHED_CACHE
> +	if (max_llcs < 0) {
> +		for_each_possible_cpu(i)
> +			per_cpu(sd_llc_idx, i) = -1;
> +		max_llcs = 0;
> +	}
> +#endif
> +
>  	if (WARN_ON(cpumask_empty(cpu_map)))
>  		goto error;
>  

A draft patch like bellow can fix the kernel BUG:
1) Do not call update_llc_idx() if domain has no SD_SHARE_LLC
2) Disable CAS if domain has no SD_SHARE_LLC

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8483c02b4d28..cde9b6cdb1de 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -704,7 +704,8 @@ static void update_top_cache_domain(int cpu)
        per_cpu(sd_llc_size, cpu) = size;
        per_cpu(sd_llc_id, cpu) = id;
        rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
-       update_llc_idx(cpu);
+       if (sd)
+               update_llc_idx(cpu);

        sd = lowest_flag_domain(cpu, SD_CLUSTER);
        if (sd)
@@ -2476,6 +2477,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
        int i, ret = -ENOMEM;
        bool has_asym = false;
        bool has_cluster = false;
+       bool has_llc = false;
        bool llc_has_parent_sd = false;
        unsigned int multi_llcs_node = 1;

@@ -2621,6 +2623,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att

                if (lowest_flag_domain(i, SD_CLUSTER))
                        has_cluster = true;
+
+               if (highest_flag_domain(i, SD_SHARE_LLC))
+                       has_llc = true;
        }
        rcu_read_unlock();

@@ -2631,7 +2636,8 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
                static_branch_inc_cpuslocked(&sched_cluster_active);

 #ifdef CONFIG_SCHED_CACHE
-       if (llc_has_parent_sd && multi_llcs_node && !sched_asym_cpucap_active())
+       if (has_llc && llc_has_parent_sd && multi_llcs_node &&
+           !sched_asym_cpucap_active())
                static_branch_inc_cpuslocked(&sched_cache_present);
 #endif


Thanks,
-adam

