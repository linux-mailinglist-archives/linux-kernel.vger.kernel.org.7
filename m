Return-Path: <linux-kernel+bounces-760791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E64C2B1F02C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 23:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1801C202C3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 21:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BF825B663;
	Fri,  8 Aug 2025 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k3q+X2tm"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86271EBFF7;
	Fri,  8 Aug 2025 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754687456; cv=fail; b=WXNsUC3xNEkYntyfkq1ullx/e95R1URGNbQt7KzSoklVNU21JGQjKnJYU125AIzbc6FmEr8R6lCq15ZBe5ea+F2Bs8cqn45/m+YnjPVso65L06dGlPO1n8Si0E+sV9VGP7/w2eq2CVPaGtGUIyqpAx+sKvbaFrpKbMr8mSAhDYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754687456; c=relaxed/simple;
	bh=nzfXuBp17y6+ss1L0j3O+DoKqmhBZDhDVlnH7vzM6lk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hmMn+Sq00LQAvd3Ncb+j87JaQyPVgjTYzSiPXu5qrlozKW9oMIsIdOqy/xDyzsBSWK02OWZhEqtdh7jrsuv5if+E1FkyQ5f6bfKeIdIE/d91COGYXJATWXb4rd5lDZLOvUNsATjCx025f/0S2Uztj/jJxKB2SQAfDXZcGmiCq68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k3q+X2tm; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZVSg4/1fygKNfYU2pYs40g/oRr5OUEVXtgbSPuOv5kJRiUeL+mc8u0dVWP0eaScaSIXoDQor3nCl08bdmrObtXDSdxr2VMchHWfCJFSLw4ottSuBZgH4YgxHEB2B1diy1j2DKuWhRxhHVfeKEJgGCCyzITBHxZ0HtqX5aVIxpmbilnJI/YkH/OCWtqIvbruwfppd02f2g2nw5+Bb1GRE9E//arkkeM4GI73B+66mG6FWxzEZ/GUSLP3MS/V/blYQs/PAPvpRVoHFPMq22iBguKFU4eqWLqIJB+QwM8fGRKzAUu72m7APpM0WUQKoqgFRV8+6ifrzu/xdyMCATBiOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mjs+z833BZbaOtYcG3ugbDHm6Uf4E6fe0133gYVuqMs=;
 b=A2atLb4PlB/sHJg6sfj9pa3POjJfvA3Z3lm3GatLZUC3tzH9Sdo9HwQz/NgskjK3XOsLrrSU73RFYb53TAOMiIslWVEZx8CoOmQd/s5y48+zfwGhWOKpwGSrNN4ZuxG8Dog129cmr7Dx/6eEb02NngedLBFh/xDa//lDOGGxjbyPxMUiQ9sB8azaLgLIs4I+T8Y5me650+JYU2Znwgcd+idxCp5xWB1b6Nkpo53UScmF1OrNrVqxsEamVCixL/t+lF+3bIOsoWN0wVSpq6VU5dXrnYSNPB0DhXCOjt3s1IwlV7qwTtGgOdUSvkL9AsA/REGSBAeyLzSqB1T7RgC3cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mjs+z833BZbaOtYcG3ugbDHm6Uf4E6fe0133gYVuqMs=;
 b=k3q+X2tmP+EXftIZHYw7MsFwvU4wA0UOr6IVXVQnJ1dBsxYdEIPVOlW4yfA9Mrhckc59zRyQK8cEzo9UlgbvlfJINYhjMgq8CKd9kokeTxugIiZLw/ONcpTwPtxYO/ymJ+X0JlnwPfOI/gvd+ivP6Hg4Q3BgL2EcX3HmYy3jlvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by SA0PR12MB4383.namprd12.prod.outlook.com
 (2603:10b6:806:94::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Fri, 8 Aug
 2025 21:10:52 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Fri, 8 Aug 2025
 21:10:51 +0000
Message-ID: <35369f95-ef31-47fc-bb8d-c64e1b9f4748@amd.com>
Date: Fri, 8 Aug 2025 16:10:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 27/34] fs/resctrl: Introduce mbm_assign_on_mkdir to
 enable assignments on mkdir
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, james.morse@arm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc: Dave.Martin@arm.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, paulmck@kernel.org, rostedt@goodmis.org,
 Neeraj.Upadhyay@amd.com, david@redhat.com, arnd@arndb.de, fvdl@google.com,
 seanjc@google.com, jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
 xin@zytor.com, manali.shukla@amd.com, tao1.su@linux.intel.com,
 sohil.mehta@intel.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 peterz@infradead.org, xin3.li@intel.com, kan.liang@linux.intel.com,
 mario.limonciello@amd.com, thomas.lendacky@amd.com, perry.yuan@amd.com,
 gautham.shenoy@amd.com, chang.seok.bae@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1753467772.git.babu.moger@amd.com>
 <dd92bf598bf7c922b212100ea668f3241f6417c0.1753467772.git.babu.moger@amd.com>
 <f653a942-b2e7-45d2-b5fb-458b022a25bd@intel.com>
 <e4137f68-6b7c-4c4e-80a6-53fd029478e3@amd.com>
 <c363313b-78b4-4dce-9590-5cd0c418741a@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <c363313b-78b4-4dce-9590-5cd0c418741a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0182.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::7) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|SA0PR12MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: d65dd801-e9ba-413a-f3d7-08ddd6c00dbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alNsREJZYUhrVjVZLzhCdE1wOFBqYWNranVtakVNK0YzVm1VbE9ySlFWSWhL?=
 =?utf-8?B?MzVlOWgxb1c1NXhCSDdlaEROZzQ3bmdyejlDb0pOdGtnRHBYN0p3SkNhWXQy?=
 =?utf-8?B?NmpmMlhpdm5aRFV4bmMrb1pud0NjWnJtZmpXSkxKSVNhSUI1VDhZR3NBU005?=
 =?utf-8?B?ckF5Z0c5YVdLeVF2amFBeFVoSDhlNGxUeElrUnlob1pGdDNxSTNrczdRckZl?=
 =?utf-8?B?aFVvK1M1SkNadXNuYlVCYkR0MU1lSnhiRTRZVkxvY2RBS1lieG9HNHpFc3lG?=
 =?utf-8?B?MUtKZFlxaUoyWGFreDIwNlg0UzBiQUhyei9IMW9EV0sxNlNURGd0QU5DUDFo?=
 =?utf-8?B?L3hyS3RacnZhQTFJV21CeHB6RlB5cGV6QzZUeHJQNHRKLzZuMHZuZFhMa0pQ?=
 =?utf-8?B?SzBySktDR1M1elJtcFVMc1JWY1pXeVVVWE5iU1Q5dDRSSE9nRnVNN1JBVkp0?=
 =?utf-8?B?ZHpFRkZQSXJvSGJ6ZE4xOTBTREYyQ090ek03M1UvQWdlT2NkekFwWW9Qay8v?=
 =?utf-8?B?c1EyVFVaOFRiK1RIcEdFOHExc3lXRkIvM1gwbThsTVU2cDVDYjBCM0NTQUZU?=
 =?utf-8?B?WmVwcmtQWWkxTE9MRGt2cThURE9pTEFaTXZxdEYzWWp5WmNObUxNZCt3aUZY?=
 =?utf-8?B?RmxCOXBSZjVwcDY1QlROR0s5bFhORFNWeEJGSUxlVHFjV3lVSlVoN2kvSm0z?=
 =?utf-8?B?U0EzTXJkdHdLMG1MT0hVVEllZVVVUmRJRHJGc0RaV2VoNWhFdkpSaThPNkJ4?=
 =?utf-8?B?R3c3djFVVWtVeVNnMEJKMWtRak5PZDM4RHRkMXMraytkSkhSYzNuM0s1Rlgy?=
 =?utf-8?B?RHZqb1hOSkJ4Q294eU5sMUxsYjhzUDN0dThGVnVGais2SnhUVlNuUzFpQnow?=
 =?utf-8?B?UjlENjJnKzhzUmJOYk9YbWpIc0FIOXZsWGpnNVI2djc3M1lXNGJkaUVNOStt?=
 =?utf-8?B?SGxqbjJMTEZUMjRPOXlydkdmK2RLRW1yTERRaGhaWFdsMjZuazh1Ynl0Wnc2?=
 =?utf-8?B?aGkwZ2U1SzYrdXYyRFhwRzdydXRLSHZBSnhkZ2Rzd2F6UGc1N3pVSGJWRlJm?=
 =?utf-8?B?U2l1eUt0VDJXd3BGOGJmckVTdlRLMEZXeEx2SStacnhwbHRRaEFuZ0Ivam9r?=
 =?utf-8?B?MGFKZ1ZCSnhUREJlWmJWcDBabkdOeS9NMXhYOGUwVlNiS091OHJyRVpPR0F0?=
 =?utf-8?B?UGp1dUVYOGkxeDkzbGJMSzFqWGFIOFhRVVBlUCs3cGF5cEZIdytiZGtXRTFa?=
 =?utf-8?B?WjA1S0w5V1NRbXJvaGtmb0l3VkdwajBBaGVIdGlHcVZlQXhmNmFyYzd1UERl?=
 =?utf-8?B?dXRQZW5sc1pCMTJSREUxS0ZPR2xkOGRFU2RBNmI4dDRXOHhFQ0xMYU5FNndS?=
 =?utf-8?B?Si9KYitDMjNCUUNwQVZTQ3V1RHIzSW1tYlA2YWRBUUQ1QWJFK0laVC9ndjVC?=
 =?utf-8?B?Mk1Ramg1alJtYWVRdzRwek9tSGZwaFVhQ0lzQlFuTnRoaExYZjlGeVlBRjhQ?=
 =?utf-8?B?d2F2MTl6Qk94MzRiUlM2WTR5cEhPVmxBalpqajJRMzFqWEdtU3o3S1Z2emls?=
 =?utf-8?B?RnYxUzI1N2d1TlR6WmtTaHgzVWkwN0tZS3g4eEV3V0dJeE91eGI4ZjVYTW8v?=
 =?utf-8?B?Y2t3ZExHNHZwWEFhUFNGSExIMlQ5LzM1NTZBS2VsdEY0NGc2UHQ5anpTem5z?=
 =?utf-8?B?b1UyS0pFalZ6RHBPaS9JZnZXSVBnOG5GamxMS29QZUNpS0JpNmJLY25md2VL?=
 =?utf-8?B?d0p5dnZRUEx2TUFLQkpwV1daWCtHR2M1bmdLSWxHbmRGbzVXQ0pxU2lmQzgr?=
 =?utf-8?B?RzM0N3E4M2pXdXJEWGFrNUt0Y3hWQ2NJS2d4RGpCbzIrbnNvTzB3c0cyNDZF?=
 =?utf-8?B?R3hKZnRVVnhiRGZhOXRLSUx6UTVDU2w4TjdUNmo1QXpvSVcvLzlRazRUdEJ3?=
 =?utf-8?Q?canBfxs3Qro=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlkrY0RoSFZNRmthRU1LaHNUMUZmU1U3dlBiVlhJUm5Ca3JPaXdtWDlCUVpC?=
 =?utf-8?B?cjBBczRpSlNWalZNWmd6R2VkeXV0VUxJT2MxbC95aWE4aWdSVnJpaDF1MjdP?=
 =?utf-8?B?ZjJndE15a0EvMDk4ZnZQR0NYMlpMV3BQbFZEMWdad0hOenJLbXJzL2JDZEt2?=
 =?utf-8?B?TFMzbXVZcWRneXlxc2p0YjYyMDFGMW5EZy9IKzUwMis2cVNKd0lSWHBrVnR1?=
 =?utf-8?B?WU11OXJLYjc2cUlzZis3Z3UzRGM4TkJMQldHaWg3aUdBWWdIdVNwN21UVGhZ?=
 =?utf-8?B?UGxjM0JmeUtSZ0ljekpMK21ndmpDeTJmWExHMW5mMTRlL3VmQjM3amI1ZzY0?=
 =?utf-8?B?V0M3Mm9jMWNsc0xxaGluSUt6T3V2dGtCSDM3WmN5eUszOW5nQ1ZveFVUazAz?=
 =?utf-8?B?Y0h4cGRyWS93NVZNNVUxM1AvbE1Gbm03dEV3OTF4NUtIRHhOVnFka1ZNaVA1?=
 =?utf-8?B?emFJMWpTdGk5OGtrVmlab3ZtNmQ5N1NnVXdrUWIrcGVPYnpJWlNCL2lHV0ts?=
 =?utf-8?B?bjZHRFkrbG5DTTQ5akdaOCtPTms0MVAzTzc2MkhBR090TW9kNGI3L2RiY2F4?=
 =?utf-8?B?YVBUYVpqZjhKMEticXo1cE90c2FQL2U0M2ZhbjR6clA0KzZ3eTc4MTdsazZo?=
 =?utf-8?B?RzVyd0I0b1l0Qk9LdHZZZ1IxK1VqYU15eXVhdGUzQUVSNnozejVIOVFnaWRI?=
 =?utf-8?B?SnJKZjNnTWh6dGdsdVo2dVR5cmpkTU5aT1Q4Mk5BcG5YMUNycDh5SmJYMzd2?=
 =?utf-8?B?R1lNMUdRVDVEdmRGS3BMdVFoRDFhditSMnJLbzZ1RnJDZDg5aTJ6a25CK0l1?=
 =?utf-8?B?UGIzODU2SnQwcG1scFh3MEdTTXVQUFpvaThsV1N4eVNmNVd2eWFUL2k3VUxR?=
 =?utf-8?B?UVdpYlFDTzlrUVZYNnA3QUdvNlczTkZnZHRocEFCRTEyOVF1eWxMbktUbXpK?=
 =?utf-8?B?K3czaHg0MTdvYXFiK1Ywazh6VkpmSEJkMmNkSkFMRmRCd3dITjNIOEVIZFRH?=
 =?utf-8?B?RnhmN1NYa0xnRllTZWJ1TkM2cVpadzFRVzV5NE5wRFljWlVYMjNGRnFKcGlt?=
 =?utf-8?B?Z2JxUytvRzJLMFo2SGltcXk5S2x6ajZWeHUxNXpwTWNoeS9CWVNmV21jdkFz?=
 =?utf-8?B?TXMvd0R3OHdrVHB2L2VXMVMzc2JmeTNoczJpcEZqdXYvYTFFOHpNVzNMeFpF?=
 =?utf-8?B?RTJtS2N3cThYcC9oWTlQazRsZFRYMmpvR2EvZDlLM1R1SU9sTzR0VnczUHkw?=
 =?utf-8?B?bEwxcGo0dGF0WVBDaHo5OVRKQldneGFva1dyV0d6eU1lMStibUhVTENuREE3?=
 =?utf-8?B?eURYTnRpWWJubXo4RlBiUHZZcVBhaWY2L1RTQnBRUytZbXBxU3lpeTFzeldj?=
 =?utf-8?B?VmhEY1JGcHRlRjFzZllRNDMrK0tCU2U5eFdxMzFlOGVFZXF6bUJFOTZzMUNT?=
 =?utf-8?B?bmMrUmJNYTBsOHprRVl6RVQ5VWFBR1krVHN2ZVVOVWVUK1NVQ1NaTk9vRmZv?=
 =?utf-8?B?VlliVVV3amY5KzMvREVvOGlqb1l6bG8zNlZpbW9PZmxCQ0NoUnRhYWlvTkU0?=
 =?utf-8?B?aFRxYzExZkNVNkw0bzJuMmtpU29EU0hBY0FyL2VGT0tseFdHeEpxb3ovS0xX?=
 =?utf-8?B?QkErcmZQUU5QMG1FbE5QSzdVNG1CWjVZczNENkFtVVBNN2hVaFc3QmNlZTVV?=
 =?utf-8?B?VG9sRzZvSXkrNXc3YUFhRjduYXFiMWRpM1JxU08wY0pZcVgvNGlOcXV5M2Fm?=
 =?utf-8?B?STgweitJWG1ONGd2TkNER2pVYXNvRWVCaWdCVm15ZnhQN1l5Y0dGdHN3Zmxo?=
 =?utf-8?B?dmloRHJOZW1ZQ3EzSEMrZmxoMVdxbnpnODYvcXI1b2NQNmxScUVvSFoyR29z?=
 =?utf-8?B?QVlrVCs0R0Yvd2hqekZmS1g4b3dWNXVTRTB2UWs3dHpkbFVNc2VUQlJkUnpW?=
 =?utf-8?B?VHN3RDBUWmt3RlhwZG43Vk5oK2lld1RYZ0NJaTVVNmNqNDVKdHlISkF2REZq?=
 =?utf-8?B?TlMzUExhRjlJUVR5Ym1jUFJvaGhwa1F3YVdvK01FaW96UUFxTWtWQ0tSaFlp?=
 =?utf-8?B?VUtLMVhTbFd3WGRESmtTWnN2UFlKMUlhUlpFdzBQRVkvUVFkcG1uMkdSQU1q?=
 =?utf-8?Q?42erE0eODQc0wJuZWDm80WepE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65dd801-e9ba-413a-f3d7-08ddd6c00dbd
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 21:10:51.1255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRKLSkbT2DSXpKXcbm9JaK3WTw4yHyBJbRfSmZpHXLtbHW7BsseawhLd2ep/A/YA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383

Hi Reinette.

On 8/8/2025 4:00 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 8/8/25 1:29 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 7/30/2025 3:08 PM, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 7/25/25 11:29 AM, Babu Moger wrote:
>>>> The "mbm_event" counter assignment mode allows users to assign a hardware
>>>> counter to an RMID, event pair and monitor the bandwidth as long as it is
>>>> assigned.
>>> Above implies this addition is in support of "mbm_event" mode while the
>>> implementation applies to any and all assignable counter modes, including
>>> the "default" and for example the upcoming "soft-ABMC". It is clear to me
>>> how this is used and interpreted when "mbm_event" mode is enabled, but not
>>> for the others (more below).
>>>
>>>> Introduce a user-configurable option that determines if a counter will
>>>> automatically be assigned to an RMID, event pair when its associated
>>>> monitor group is created via mkdir.
>>>>
>>>> Suggested-by: Peter Newman <peternewman@google.com>
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> ---
>>> ...
>>>
>>>> ---
>>>>    Documentation/filesystems/resctrl.rst | 16 ++++++++++
>>>>    fs/resctrl/monitor.c                  |  2 ++
>>>>    fs/resctrl/rdtgroup.c                 | 43 +++++++++++++++++++++++++++
>>>>    include/linux/resctrl.h               |  3 ++
>>>>    4 files changed, 64 insertions(+)
>>>>
>>>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>>>> index 37dbad4d50f7..165e0d315af7 100644
>>>> --- a/Documentation/filesystems/resctrl.rst
>>>> +++ b/Documentation/filesystems/resctrl.rst
>>>> @@ -354,6 +354,22 @@ with the following files:
>>>>          # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
>>>>           local_reads,local_non_temporal_writes
>>>>    +"mbm_assign_on_mkdir":
>>> Needs a "Exists when "mbm_event" counter assignment mode is supported."?
>>> Also needs clarification on on behavior when "mbm_event" is enabled vs. disabled.
>> I think we should allow it to modify  only when "mbm_event" is enabled.
>>>> +    Determines if a counter will automatically be assigned to an RMID, event pair
>>> "will automatically be" -> "is automatically"
>>> "RMID, event" -> "RMID, MBM event"
>> Sure.
>>>> +    when its associated monitor group is created via mkdir. It is enabled by default
>>>> +    on boot and users can disable by writing to the interface.
>>> "users can disable" -> "users can disable this capability" or "can be disabled"?
>> Sure.
>>> This implementation enables user to read/write this file/property when "mbm_event" mode is
>>> disabled. Considering this explanation I do not think it is clear how this file reflects
>>> system behavior when in "default" mode. There is no difference between mbm_assign_on_mkdir
>>> enabled/disabled when in "default" mode, no?
>> Yes. So, we should only allow modifications only when mbm_event mode is enabled.
>>> Should interactions with "mbm_assign_on_mkdir" be restricted to when
>>> "mbm_event" mode is enabled? If so, the next question would likely be whether value
>> Yes.
>>> should change during "mbm_event" enable->disable or "disable->enable". Above states
>>> clearly that it is enabled on boot and it may be reasonable to have it keep (but not always
>>> expose) user's setting when switching between modes.
>>>
>>> Restricting it to "mbm_event" mode now gives us some flexibility when soft-ABMC follows
>>> on if/how it can/should support this. What do you think?
>> Yes. We should restrict it to modify only when mbm_event mode is enabled.
> I agree. I also think it should not be displayed with mbm_event mode is disabled. This is
> because it indicates to user space that counters are automatically assigned to RMID, event
> pairs and since "default" mode depends on hardware doing this it may not be accurate when, for
> example, ABMC is disabled. Alternative is to add a third value, for example "enabled", "disabled", and
> "undefined"(?). This sounds a bit awkward though so I think simplest may be to have this file
> also be consistent with the others and return error when mbm_event mode is disabled.


Yes. We can do that.


>
>> And always enable it when switching from
>>
>> "mbm_event" disable -> enable:  r->mon.mbm_assign_on_mkdir = true;
>>
>> "mbm_event" enable -> enable: "no need to modify as the value does not affect the behavior."
>>
> ok, please note this may need an update to the doc that currently only states "enabled by
> default on boot" to indicate it is also automatically enabled when enabling mbm_event mode.


Will add texts about it.

Thanks

Babu


