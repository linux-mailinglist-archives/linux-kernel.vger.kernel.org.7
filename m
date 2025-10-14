Return-Path: <linux-kernel+bounces-852380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 305DBBD8D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA2DE4EB433
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D132FB986;
	Tue, 14 Oct 2025 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="eI00V3+l"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022102.outbound.protection.outlook.com [40.107.209.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635402E0939
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439142; cv=fail; b=Zfx0+M7nRSEWgy5urv8tmeUsxHMTl9lRZ4ukNCkiy1tJFCNSALMJSnquDiZi/M0URgdtfXw6z+m3/CmBi+Nq1XbjbewcWuq2JaCB6xIYiLBmLHabO2JpujRJqOrS7aqNi1aDjS4LSmz3SV6kqFOJ9f1kOvFgt4luOVce5znyfE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439142; c=relaxed/simple;
	bh=CV/I6VYysn4faCkfpaL6kfReI9rKRK7sTa0Z0FZG22A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=al0hWXBSNsryKi4ueuuoMW3BxU2CB4Suiun/VHsZNUE8VO8TalaGbx7eTnRawHUfVpugdmu5AC6xnclHoR9LqBfIeI7p6+Ja2hE4sZfixfFLCNU/uzoYgqI4It3iInovNmy68HtBYk0nIzd0XJ5HwQtG+d4kcPioXpI/IW4c6xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=eI00V3+l; arc=fail smtp.client-ip=40.107.209.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=We11lByyffq6P+2VxNbbaZ9lyvlriykehT0qRZYDi8Kl9MkLj41Z+G96ImRiOr2TzCVXOaZS6nyaqQWfYmEUPfvZSdNUNY36FfnRlPUHvnidUM5CzHbLz1Yh+wcgAGua9IaZ8nBV0ifKZGiB8OY73FI6z+sENCkJgmxnwetOEol2s3mstAFM4O7WnYs4SirOQ/Pn+pxGVE6kTZGOEuhYh+M5r4EmBfWp4SoNs8MHkxq2D1oGPuBdYdpzzkyI/tHdImMclAz5f0D5Uv3G/yNJdTb73hOpuJxaNT31X2Aet0gXCqDUPFY00gH/6JbvnOwMIZJOjE2o4Xco0WuJnSkjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQtetii4zDHG2WKzJBcpjaOGmfEv0c0hdT0KMQ3ezDQ=;
 b=I+WV/FBsNUdT6WNymPVDw3QxUuGeznfFyq1aYBCNpDVgsCdxBfcsFVnt5JS2AI2yWLaLpOaP2RwOJLt5rwbaO5k1pQwS2oA8Bbz6cCv5BPo+8c7E027zs836FldeN/XmZfVDbfHdnU3og6BrAFraoRCBaUI4uvIWJl+iMOSFTeX9PUcWJmO86YdAt5VV7MUa5ayN2Kx49ovRwaFm6zuKi63PLo8f/yF1DauClGqRY7DXP3O9if5TsJTVjZ9I8i1xCtgR9dAN3YKkG560Rup9z07n7Dr7pMeiBCYtJGw90HLzvaDTsGIRRpfNQBE6G4XTbPdT6Tx1Ld1O2zCaxKd7Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQtetii4zDHG2WKzJBcpjaOGmfEv0c0hdT0KMQ3ezDQ=;
 b=eI00V3+lEDsS1uao9D+lnrKwwqaZ4u+n0xrfT1lFf5e5EXdYXwvWP76KWSjTDZu3mQeWLTMPQIkwukJRtfbMDwlB1bznB00IoIsM8VN0mJed33LBK5uAdF307S1Gh4/mmur55VJHFk+X/ormLnQCzMIh7wfLeT39pQSjR4FsGKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 CY3PR01MB9272.prod.exchangelabs.com (2603:10b6:930:100::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.9; Tue, 14 Oct 2025 10:52:16 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%5]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 10:52:15 +0000
Message-ID: <d6b78d12-298d-4316-91f4-bf7d3d7d5776@os.amperecomputing.com>
Date: Tue, 14 Oct 2025 18:51:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] sched/fair: Only update stats for allowed CPUs
 when looking for dst group
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, cl@linux.com,
 linux-kernel@vger.kernel.org, patches@amperecomputing.com,
 shkaushik@amperecomputing.com, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org
References: <20251011064322.8500-1-adamli@os.amperecomputing.com>
 <90e7343e-7741-45d8-b076-d3852d1870fb@intel.com>
Content-Language: en-US
From: Adam Li <adamli@os.amperecomputing.com>
In-Reply-To: <90e7343e-7741-45d8-b076-d3852d1870fb@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18)
 To PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|CY3PR01MB9272:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b050b1-a479-4121-ee33-08de0b0fbccb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2R1UWNuZzNpdWxDQWZ5N0gxWXNIb1Jnd2hkaSsrUkZPL2RtQVVacjZDSnlX?=
 =?utf-8?B?T0lUV3lYMDAyT2pMeXJ3cVVFZWhzWEVJcUNUZFhZV1ZoTGtDbS9PSW5DcmZP?=
 =?utf-8?B?ei8zU1A3Sm53Wm9HT2kxc1J5K3BvVnRvdUhqeHlzQk1GcEwydlVpSFZXazJD?=
 =?utf-8?B?L0ppVHlWM3VIMlVOdURzUnN0MTNyRjEwOWFvUjBxR210MDJSUWM5bWRiWmJX?=
 =?utf-8?B?KzJDZlRYeDRGSkkrSFl1ZlFqbUwxQWI5dzZyMDZIRzAzR05pazJoYzdnSjFy?=
 =?utf-8?B?RmVlOXF2dk1idWxyRTZSbWxEV3ZsaXE1QzBha3YycFJNTkY0bjlLM1pRZXR1?=
 =?utf-8?B?WHQ2T1hoSTNXN0IyRWNvaGhSWmtoZ0FPekU4cGlSN3F0R0pVQi8xeUVxSCtn?=
 =?utf-8?B?NVh3bTdJUHR2ZGkwWXNlYlN2TG1Hb3lEL0FjNm1IbWQ4NktlY1NWMGlmUWFr?=
 =?utf-8?B?UlFpcUNYSVY2eTBpeXhUTHcrdFpVNFoyTWdlRjNtcUR1VE9KQ1pZbXQ4NGlk?=
 =?utf-8?B?dThpODdLQzB3STdtbGV3ZW9CRGxma1IreGQ1ekcvL3Q4RnlWRjlseGo4WW4x?=
 =?utf-8?B?RFh4aGtkZW13MXFhSnYzVXB1VUthYk00RWZiT0N5aG1aVyt3anN6RzBFNzlm?=
 =?utf-8?B?eVBaZHVHM3ZSbUlYUkVCa2UyUlBPN0dYNERyZGZkeDBCZEZtc3JBbVEyaFBB?=
 =?utf-8?B?cGd4alFPKzZqK3YyUitxTkF0a2M3WHB6VXoxaENKYktEaEoxYWdwMTY2dUxC?=
 =?utf-8?B?dFpJbzAyeE4rdnJiZm4yQllBcERrY1A5U0xsaHpZZS9VT1lHOUliOEwrRjNX?=
 =?utf-8?B?Z0FJZHRaSElTclgyclR2aXlzb1pwMUc4NVk2Nk5tMlp1Nm9pM015TEFiM1Yv?=
 =?utf-8?B?d0Y3S1phRjY5VjVMY0tCWkhWTThuTjdJWWdRelJYWkJrWHVFRFVjb1Yxa3VI?=
 =?utf-8?B?M2pyNzB3YllwR0FwN3FLRjE4N1JpVW9GWjRFb0RiVGVMemJGKzYzRmdxV3Qy?=
 =?utf-8?B?aThleS9JS2F2d1FEQ2c0Z2hzUHVzditydktvVTdET1FZWEZpM1dWMVBuY0Fu?=
 =?utf-8?B?QWhzWXd5QkNUZ283V1pOMnNJT09hQnNaQ3VQZW5hRWVCUTBmcnI5dlN4ZHNW?=
 =?utf-8?B?SSs5T3hWdVdOWGJmMFl3ZjBZa2xIY2NscVQybVBBTFVqcE9Ta0prRXJZWjFO?=
 =?utf-8?B?YVhFWlBnU0ZHMDJzZEExMFIva2ZpODVDTVg2YWZmQzczbktsN0IrNnd4cWpi?=
 =?utf-8?B?d3hMdnJSY09zK2pSQkJvMlhoSllKQmx1b1M0T3dIeXlVOGo1bXZwR2g2UTlH?=
 =?utf-8?B?Nmg3VWFFM1M3SGF4YzlSbWEzUmRKbHgrNnF5OWNqOHB6Q3hnTmMrejhjMnJD?=
 =?utf-8?B?VkV1Zy9uWVBlajZtWmVuSWp1b01nWU1HbmJNcjduZVB3VjhMVVppK1BtMkhD?=
 =?utf-8?B?SmU3K1FEdkZxOXB6Y0RuQTNYNUs0MkJKenM0ci9hYXJyYUFoZGY0MXpTZE5z?=
 =?utf-8?B?Umc3bHdROXhDeU1MUG4xY1B5cHhRZnZSeTFiMzhyOUVReHZUSkx2S2lQOGJi?=
 =?utf-8?B?NTZiaVp2S0cwOGY5QTkxK3RoRmNONjZRTXB6ejg1Y0VMK0NXdlVsSTRJakxq?=
 =?utf-8?B?UFFuMWxteUxXMy9nOGFSM3dBSkJkalI3OHZWNW50Rkd3cW5rM0NLWWkrTkIx?=
 =?utf-8?B?c3BKdTJXdHNraFNJUVZENytHRUdFK1VQWS9DdDd5VVVwK1B1UDR5TTIzdE4w?=
 =?utf-8?B?eDBwMmNQcGVrMDRGRVJJU25kdmRqcGoweGtFQk5mQzJYTzYzUzZvUEc0cFJv?=
 =?utf-8?B?RDF1dVc0bE1vWTVFdUR6eW5rQll2NTdsdEZ0Z2tnL3ZKSkhEdlovSXZndjFC?=
 =?utf-8?B?NUtlWXg1U1dwY2VpUDFXV0d2TUlQZ0RiY05UdVlYS2lxUDdPTmxxL0tobVQv?=
 =?utf-8?Q?7mwcfwFWtVP2m1QB8LOawoFnmfFuMnBb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blhXdCtQNkorN1BZNXJoZEdsaEtnYUVCdEFCV3Q2WitMUWRYcWNTNU1wdSt6?=
 =?utf-8?B?aEJBajlLYk1PM3ZKYzMvQjFBR2hPdUxHNDc0bVJxTGNMZjc0czBBQWNJc2E2?=
 =?utf-8?B?T3NyZjhtRms4V05qWlJWY3NNUG1MZXBVcHUrWUdENkxZZXpTaTdJcGxyQVFQ?=
 =?utf-8?B?ZGdGK0tzKzVKa05GOXNzQmU0RDBRbUVjd0UrMERySm1xOFUrUEt4a0IwQ3dP?=
 =?utf-8?B?ZmhqQmxJdmRUMmR2ald2N2lOSWI1V2xXSUpFUXBDN21LeG1GaUJ3T0pMK1RQ?=
 =?utf-8?B?NVVtQVlvOUlVYXpGTDhoeksralNjUDM0a3BQTi8ybHRsQjIrc2ZTR2M4Vks0?=
 =?utf-8?B?RGRrc3kybUoycytQUnkyYVArYmJRZk84U2J6VkJUQUlDbEFXUWEyUGpTS3dC?=
 =?utf-8?B?bmcxTXpTY2V2MG9CcWFLQjQ2V3JBQzkzR25GRzJjaTBlV1g5NytYM3RuLzFW?=
 =?utf-8?B?djd6YWl5R09vTUNyQVhhYStITFZDS3p1TjIyU01TMjlqcm1ZQ2ZwaTAxVzFv?=
 =?utf-8?B?eHBCMUVwS3ZxSVFRQ3BCT3RyTGRrV1JvYVdKQ1A1VTVEbjh0U2liVjRVekZV?=
 =?utf-8?B?UUVLTVBqcDAzTm4yZEVUcFBFRG5rVU5rWktqTmx3cktTYmhqakJIM3ZMOXls?=
 =?utf-8?B?WDQyZ0hDSTVlaURVNzNodFp3TFdIbmhSSTJqazFxZDBsQVFJRER3UkI0S3Fz?=
 =?utf-8?B?ZXZSR0Myd2dZZkNMbjN6SHlxUDBpSEYwbTIyWURVK1FUQXpwU29NSW92RFhm?=
 =?utf-8?B?aUp2TEViRjYrWFdYb0dKZ0FieGRQcmc3b2Z6clUrS016czN5VjRVTjBmY2ts?=
 =?utf-8?B?R3hvTGR1SFY4V1QwWFRKM3lzWWVYWHplem53R1QvemcwZmhKcXozZ3ZvbGMy?=
 =?utf-8?B?RGx4SnBoSVJ0SmU4bGVqV00ySTB6RGJwNGVsKy9HN1c5eVF4cGt2YWVsQWli?=
 =?utf-8?B?MUxQZlB1WHpMRkt3UGNNMkQ5ang3bXN1SERVUzExWUVZWjNCa0NJemcvV1dm?=
 =?utf-8?B?STdZK0R0eC92b216WVFSM0swN1VZSitxcXRSQWNMT2lrME9mQkM5bjFpSWsv?=
 =?utf-8?B?cUhVYi9Nd2VwY1JxWkUzbWVRSzY1OFJIcm1ydnpkZFYvYUZWLy9vUWxPdUZi?=
 =?utf-8?B?VG1zRGY5MFJLYjdPUzFaemwvUW1vdVJkdFU0M3hSRmNpU2I3QS9Qd1c5cmtq?=
 =?utf-8?B?U2pIZzBjWmh4cGZVbmNYYXo1bEtLaUFkcDZOQmphYzc5VmpLSVNSd2twV25V?=
 =?utf-8?B?NmRsNVlLNHVybGJRbVpibmZXM1psWHYxS0ZveEJuRVJoVWVOalEwZjVEUlFT?=
 =?utf-8?B?aGZhbTBQU3NMYW16cGZaQnEwNWN1WkVCUnRUTHF4YlBTaE44b00xK2xOaDM4?=
 =?utf-8?B?TG84Vi9lbzFDSE5uU2IvZ0R4anB2NjB6YmNaMzNaSTRHM1N1T2twNWlGV0VW?=
 =?utf-8?B?NW1CY1hodW5zTi9SeTM1Q1g2Y2o2VmpzZ01Pa3BXZlZnVllHbWtWU2RCS25K?=
 =?utf-8?B?amxyKzA3amNHU0tQZkgzR0sxYWVWVllCZVpBVWVjakI0SWtMMXU1Yjl0U0VQ?=
 =?utf-8?B?aWxqY0pXYVhxc2dmUnphZkNnN0dHakxiUXhQakxjWnI3YlNZTjcrZmEyd2hl?=
 =?utf-8?B?aFIrSCtscTlaOGQxMTlMR1d3OW96ckVkMjd0NWsvK0hBa1J6NExPS2xvQlVR?=
 =?utf-8?B?MUlhTlZ2Ky9iWTk2UVl6RS9GRnZNZ0g1ZUZCK3Y2emNlbXNPWUdOVUt5c1Ev?=
 =?utf-8?B?MEdobjQzdDNhdkMvbHc5eFNPTys2ZWZzeDVJOWtFUlRhWkE1TEQwT0NwZmJ3?=
 =?utf-8?B?ek9GM01DWTZwRWdDbTY2ZHZTWFUzMTQ1Mm1ITWtzZllsK0NTQTlHRmw0YTlj?=
 =?utf-8?B?MDlnQUhuS1BkT0VZYjJoTU5vMWN0eW1GanpiNlVIaTQvZEk4UUM2Z2JDY25B?=
 =?utf-8?B?ZVUvaUhVVlF3L3ZLM3lCZFAyYitkQUJyT0U3REErZC85a0RENHNnUmFucFZF?=
 =?utf-8?B?dkhVSlF5NWMvV3J4RXRnRmVnNUluZWhvemIyaVJuVjRhUHdIdjU4MjM3ZE1J?=
 =?utf-8?B?TjJqMEc3VkNKNklaQ0RydVJhN3RMUFZDSzdTWlVLdDAzTDMrZ0NyeHBRZ29a?=
 =?utf-8?B?dFhrRUR6dXQ0YXdmUVVLNHF5WXlBNzIxOWtyc0dXN2xFT3RjMmI3QytDTDdM?=
 =?utf-8?Q?VvivhJ7xXN/JAziAKMAsA7E=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b050b1-a479-4121-ee33-08de0b0fbccb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 10:52:15.8830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vw7WDnN7q6Jp6t7NiRbCzwCipD6wz3WsJVpIpVvyfbqRHMdlnbX6QB8AYYZ5yTYCAJX+dhAJQ0djnIvZg47S65sI+fAFWQQHPrBzsdWh5wtU60T5Kj1VCFwOmK59XPbU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR01MB9272

Hi Chenyu,

Thanks for your comments.
On 10/12/2025 1:42 AM, Chen, Yu C wrote:
> On 10/11/2025 2:43 PM, Adam Li wrote:
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index bc0b7ce8a65d..d5ec15050ebc 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -10671,7 +10671,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>>       if (sd->flags & SD_ASYM_CPUCAPACITY)
>>           sgs->group_misfit_task_load = 1;
>>   -    for_each_cpu(i, sched_group_span(group)) {
>> +    for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
> 
> Looks good to me. One minor question, would pre-calculating the mask be better?

I do agree pre-calculating the cpumask can save cpu cycles, without
doing mask AND at each loop.

> Copied from select_idle_cpu():
> 
> cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
> cpumask_and(cpus, sched_group_span(sd), p->cpus_ptr);
> for_each_cpu(i, cpus) {
> 
But I am not sure if it is safe to use the percpu 'select_rq_mask'
in update_sg_wakeup_stats(). Or we have to allocate a 'struct cpumask'.

I tested bellow patch. It can work and fix the bug.
If it is safe to use 'select_rq_mask' , I can submit V2 patch.

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10664,6 +10664,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
                                          struct task_struct *p)
 {
        int i, nr_running;
+       struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);

        memset(sgs, 0, sizeof(*sgs));

@@ -10671,7 +10672,8 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
        if (sd->flags & SD_ASYM_CPUCAPACITY)
                sgs->group_misfit_task_load = 1;

-       for_each_cpu(i, sched_group_span(group)) {
+       cpumask_and(cpus, sched_group_span(group), p->cpus_ptr);
+       for_each_cpu(i, cpus) {
                struct rq *rq = cpu_rq(i);
                unsigned int local;


Thanks,
-adam

