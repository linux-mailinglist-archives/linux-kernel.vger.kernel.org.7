Return-Path: <linux-kernel+bounces-755565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B576BB1A878
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 19:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD43D18A01DA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A711EB5FD;
	Mon,  4 Aug 2025 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qXRSuLNV"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80133AC1C;
	Mon,  4 Aug 2025 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754327693; cv=fail; b=jnuUlQUX+jwCkaf+7OHylyTp/4ZzQzk3nN+r0a2NpAIW7qWw9PGJByrPL85YwDw6pJQcfY+Q03II6rZLouk2YG+kIvtS5R7ejxXnlOCJ9u5+K1/PtSMtrW/OxV+38RCaWVVeUswEg63SkJfNXN0UMwnqqcdQhB6PhIdVKRH6wAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754327693; c=relaxed/simple;
	bh=n7mq1iK0se0w17ogSzd125edsBgtTAFccJGRsS0eOyY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AL95EWl2ZF43K66cNz1FbVAL9lO+0LsoaBYrkji5yIiAIMkdGjupWHyT5LWjPMmqHLxKfwnSHP5tt1WqdCofjuYt+vH1J/aprBBKYZ789BclvR4TxuGjHy4kd1w48tjsmtF/yVf9iWeeWgLOmGf3FmToNnqJqaOrRPS/kNGC4nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qXRSuLNV; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndUmgEXwPthxAVXHAWpBscrtAxnCDMA5isTs2AOFildPZGubbs6WpWNxDgRbiPHppxFAb08w3DxlcPvbUmkXjC0668js5eV/y+vzeLgxKag9Ho2E0yPQwzaoz4eZ+rVH1cLtXgYf4KDCGiwB2VHwWkzRyeHSplFe7PHGYEBtwxT52onbW3eEIKqgo+8sYR05l2fMJPkyYdhKGoWxkAImUBu3Bc3SwRQRod7lXbg8E9UfCDPJPqtANky9kjA3ulwFAAnn6CmO13pwXjSJbCc3vItesd5nztin506Fvrsbx+kuKLPPJW/IB7X5cY8V3mG3Atw5UPl33hGwxISHFyfuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQ0Wk6ftzv8FrBAGnpMNQrVFiZEtEEWthbkiv9UZ6cI=;
 b=IUBVDnsJbzoKxo/iZgddrdwEWSrHjU9ZTgEj4B1R6v5++ULnD6CowI1iw4ariJbnPNm4DcpQP5AD+EVFxyXspL+laKLivZHXkoi6ywMNCSNYrI2engHSuJw/a3AlQwrEA7o4ItPDtZrvVNfmSfZeQGTuCy9yFfFrMjv6tJ6K/Kqh4NGayGQmf3VDRSlsVw6dKSInc6g381SeCrMQSaVT+VGx/5/1oV8ivH8ijHMlzdoVSYPpLRptljH2DUs9Ro8vb7R/45A2DjGO4qBVrfltRhklefk9BJgud55fA2nV/XbW6dnyrkHX2hvR2zpjCErU+SKrtboLt6SMEQ8freGvTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQ0Wk6ftzv8FrBAGnpMNQrVFiZEtEEWthbkiv9UZ6cI=;
 b=qXRSuLNVMQ91llhJBfa65ikIjkXr1wv+xNbLJhIuDcZPL8e9NCmkmi746JQU4ozj0CTLKbEAVCmd8ut+eky7uDiP/K5eC1ar1KqfDN3QnH+d4oAmTYthveduKxFCiNZ7fDYgCja5zl+z4I0dkmWk9lhYogJ1zsZmTChIBgNOBmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by PH7PR12MB6561.namprd12.prod.outlook.com
 (2603:10b6:510:213::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 17:14:47 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Mon, 4 Aug 2025
 17:14:46 +0000
Message-ID: <fe6eb3bc-03c9-40a1-9bab-35d755548246@amd.com>
Date: Mon, 4 Aug 2025 12:14:43 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 07/10] fs/resctrl: Add user interface to enable/disable
 io_alloc feature
To: Reinette Chatre <reinette.chatre@intel.com>, "Moger, Babu"
 <bmoger@amd.com>, corbet@lwn.net, tony.luck@intel.com, Dave.Martin@arm.com,
 james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
 paulmck@kernel.org, rostedt@goodmis.org, Neeraj.Upadhyay@amd.com,
 david@redhat.com, arnd@arndb.de, fvdl@google.com, seanjc@google.com,
 thomas.lendacky@amd.com, pawan.kumar.gupta@linux.intel.com,
 yosry.ahmed@linux.dev, sohil.mehta@intel.com, xin@zytor.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, peterz@infradead.org,
 me@mixaill.net, mario.limonciello@amd.com, xin3.li@intel.com,
 ebiggers@google.com, ak@linux.intel.com, chang.seok.bae@intel.com,
 andrew.cooper3@citrix.com, perry.yuan@amd.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1752167718.git.babu.moger@amd.com>
 <e311fd8f4ddfd33c29febdc71d5d41f8a06680cc.1752167718.git.babu.moger@amd.com>
 <ebd0a6bf-cb55-47ba-b9dc-65f56b065ab0@intel.com>
 <5c784fb8-fafc-4529-afd4-d1acb71aded0@amd.com>
 <d1c3b736-8dc4-43fa-9ace-acb26ac0f3e8@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <d1c3b736-8dc4-43fa-9ace-acb26ac0f3e8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:806:21::13) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|PH7PR12MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: d18452cc-dabe-4445-0e1f-08ddd37a6994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEFjbHFCMStkL2hUeUdRQ01vQS8vQkVxVWFtSWpqMTlvMTYzeFBPd1IzcTZt?=
 =?utf-8?B?d1Y3WDBvUXZDUUsxVjM0ZGw4bml0VGhzRXQvM3VLcjZPTDNDY1NFRGs2TVZB?=
 =?utf-8?B?dDhLR0ZYbFpYRGczanBSd3RnTTY3KytNNlJqc2tIQWxKVXQ2U3pFeGpGSnZT?=
 =?utf-8?B?eXBFWVEwQnR0MDF5eFk5cUZtSWN5Y2tiQ1BVZjJOL1NRdG56d3pPY2hiODZZ?=
 =?utf-8?B?Y29nSS9nbytJSmx5aDM1bDdxQlMvVWo3cFA1ZVBXb1Fsc2g5Wkl6WVovWHlE?=
 =?utf-8?B?S1FOTlhQMDA0NjBoMjY4ZE82Qkw5c2xXMm5QNWNOai9pcnQ2cm9LeUR4NU5v?=
 =?utf-8?B?VWt1akYxblVocDJnVE44RzRMK3l4dUVuYW1teXh0OHlIaHl4TmtTaEZSSCtl?=
 =?utf-8?B?S052SCt2UnZqTlB6WG9iWE9QTnFoeWJKamJEeVpxU3N6M0dmZTRSQyt3TzNM?=
 =?utf-8?B?ekd2Sll4cEkzM2YvUGZhZnM2UHpha3RFM2VEUWtuUmhzNHE3Mlo3UWo0MmhF?=
 =?utf-8?B?SWFJOXpuRURjUXorYTVjazNSOURBbGpFdndjNmxJUk44L2JzSHBFWHE1TERZ?=
 =?utf-8?B?RTE0ZHhEQVJEWHhZTlJwaHRMQTF4ZGVzMU1sdmdkZUxuWXBWbXpsQzBUeXU3?=
 =?utf-8?B?MzBWRnBKVlF1QkhvQWtWT0NhY2xxTU45c2JOY0dvOHM5VWNJUEpnUEhKY1h6?=
 =?utf-8?B?b2IzaFh5UDg3dk9zcUdIWENyNUhmRTFSSXI0OFRzMmtXTithaGcxSE5xa0Jv?=
 =?utf-8?B?YUd3MDVsMzBBd05PYUdUTmVmVk1WQjh3bG00UU0vS1MzNGNwRjdJNFVvMTk5?=
 =?utf-8?B?bUkyVExBeFFmSExqMzZpYlpQbktzT2IwNUZMSnhqeHFMOW56K1dZTXhYM0Zn?=
 =?utf-8?B?dDNKd1picTJ0K09obGxwaDk2Y3U3VGJFQjVUeGdvYUIwcXI1Q2JpcjJudWwr?=
 =?utf-8?B?cStGeCsyeWlKUEJjYWl4bHB0VHd4b20yMmR4Rjlrd3M4TEFXRTc3Q0RmM2VF?=
 =?utf-8?B?dWUybjVrWW5NSk03RElLdkdiRktyM0VCcW1vTVNId1lmQ0ZERjdzVHNtTFgw?=
 =?utf-8?B?M2Q1YS9qYlpjZTR5eXVNN0xNcTNRNHJBRlNRNS9TMHVmR3F3RHF3UlhVUFdn?=
 =?utf-8?B?RzR2ZEhvR1doR00wQU8wdVExTjZVZWJ4Vks4WW1MYTF2Y1gxSHQ1d1Z2WWhp?=
 =?utf-8?B?OGxLMEUyU21qTE5LaUdIbEhJSVVVdERWUTdvd3UyaVFDY2x5YlVPT1ZNdGhl?=
 =?utf-8?B?YUFSYlRYTE9veU5weDdwYmFDSFNteEpzb0VJMmJXVzFKUnhQRW9PNjQ2M3VE?=
 =?utf-8?B?NTN6V0dvZzR5YlltczJodzZhbHJmbWhlRXZXSXczS1V2MjNGSUJQckhqcm8x?=
 =?utf-8?B?Y3B5dzBwU1FTdTBMbXNHR1d6UTV0SExOOFNsUGdWc1FqeFA3THNrejUwRDB6?=
 =?utf-8?B?eG40SUE0RGhyQzNIQ0Nld3JyK081QmFxa1F5NDhhSWg2SEJ6Ui9IZWlpNE0v?=
 =?utf-8?B?ak8zazZIQTlhSTFQWHArVGZodll4alpnc1MrdS80dTlMRDBBL2NpdUNRRVVR?=
 =?utf-8?B?dmtqZkROYWFGY2ZqeTRDZmNXRm5JdFltaWNkUEUxNG14REFUMVFic0pzMitH?=
 =?utf-8?B?QVBwOXpwSTNRNmZkZEk3VVZJUnZKNTd1anMxM1NRaFdjdEtibHlhQVllR0d6?=
 =?utf-8?B?SFdmVTg0MDNSYjRrS2YzUU85RjhlY3pkQ1F5a0QxUEtPRXdHRFU3ZmtJTi9B?=
 =?utf-8?B?QnJrdFBYM1NVTUdCUWkxZGdzbEhUTTVndHpSRjdvVG05NlFueTlnSkNNOEZ3?=
 =?utf-8?B?WmlLQm9POVJBMGY2VGJldnNYaTA0eE9ZcTVJZUlHRGlaQk1yQUpIRG5mdGti?=
 =?utf-8?B?V3VBRExxR3hXQmM0cjBIK0xFWUlOYmNLbWtxUHlXVk5jTWhybXAxdFYvSUxC?=
 =?utf-8?B?RW4vcS8rWTFCd1RMcDJnNDRSNlRVV05VN0RSemxpSnFiT2tMbTNLNHlSYmZl?=
 =?utf-8?B?SXJZSjN5cGJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wk1RZ1FVcmdLSllScGZiVXp2Tmw0TXRJaFQ2MlJnUDFib0NVNy9MdGE4czgr?=
 =?utf-8?B?NzZON1RvenR5cE1ZZFZnYndOdWlsaVZ5S1ZYNVpQNzRLWEZiK0poTXhYRHl5?=
 =?utf-8?B?eE54U1BOS1ExK0JZb1cwbnF3amZsdGVSYzloNzhYL0tXNGJxbmluMDlLZ3dq?=
 =?utf-8?B?RkdYb2VqWG8rVEpIRGhMUlY2S1cwZ05ZVGxVSFIydlJaVjRDeTd6ck44Yk9H?=
 =?utf-8?B?TUI2VTl6RVVnUGp2MkFaeEJObml2cjZqalBSZXVFRGpMYXZqNmVPQ0doK1J2?=
 =?utf-8?B?MHhRMnNld0p4c09sQlV2T2txVGJLdjZCMWZQa3UzSzBCMlNZMmJjZmdhUGll?=
 =?utf-8?B?aXh2RmdNNjhOczdUcEZoc09HcGdWN0MzajhDNGpvNytQNng0SzRCWXpsdkta?=
 =?utf-8?B?UzQxSEtZQXQvTG9rbkd3aTUvY0p0QVVpWFpIaFY5aHRxSUtWS3AyNWxUbGpP?=
 =?utf-8?B?emJKL2FBaE1QMkxoYkRVZFg0aHloR3Rpc1lGTHlrS1VkemxZUlNMOEFtTzla?=
 =?utf-8?B?Z0lMbVA5WlhTclpDdkpZSXZGeUNQSzJBWGFTeit5dmd0YWUwZDdLMmUvRjNT?=
 =?utf-8?B?R3JONlJYRE1pMEZiYXk0cXoyVDJGR1Rhd2xtRXAxVEtOelAxYm5scXA4Y1hw?=
 =?utf-8?B?THZQT1hzb1ZwbXVwSHFMMExJdm1md1BQSDR4ZnB5M3c5QWI4TlRQM2trYW9I?=
 =?utf-8?B?NWgzczVBRTcwbUVWVkZ6Z0hibmFKeG5xRjU3NjRYZUNkWmJqL1N5aHR0NHJT?=
 =?utf-8?B?ZHgxNkxHTkkvcnVqTVp2WDFDZm1IejkxNHlSWlZQc1VLbDNSV2JXVWRweGxI?=
 =?utf-8?B?NjhwV3p1NXUwL2thU2xVbDkvVndaemczZXpjaTJEVzl3SWdCdUd0TVIxTjNr?=
 =?utf-8?B?aU5wb2h5cis2RTRzQUx1SlY3YTJmbDMvMnYyWGg2bExkQ3hINWdzM1BscS9p?=
 =?utf-8?B?cTNKLzN3SVNpNDFmZGRwR2NqVG83S2xTOC9TTEpyckNEdGlYci9adzY4ZXAx?=
 =?utf-8?B?ckdkcW02OGZ4TDRaNE40cmttRDllcExlU2JkbG9rYlNObmxXQlJwSTIwd0ZZ?=
 =?utf-8?B?VjlEL29sL1d0V1pNR1dCa0pzZENtb2NXVyt3YVpNUW4xT0hKQWJDMVFtNitl?=
 =?utf-8?B?emI4K09KRlhBZFFGNHNrZWQ5ajVaT1pIQXBDNFVBTE9TT3hpV0tQTTZMWnhF?=
 =?utf-8?B?VmR4UmJHdnFkOUd1MFZDSVYzallXWk94K1JjeUJtTGwzdHp2ZThoRlV5V2th?=
 =?utf-8?B?MWp4VXAva0doTnNBdGxEeGxqRWhHSWUwRDJIcnp3ZzV6bitWSEE5aFhYTG5t?=
 =?utf-8?B?L3hDVkFOMUdDaHJ1YjNYek9uZHA0Yk8wYkpLVHpqa2NhbldINnAxSFlkNTBR?=
 =?utf-8?B?TytBbUY4cEdMaEg3dk1STzAwNEcyeW1ZQlRFOGRSMk9MQ2Vsb0FlTXA1dVBm?=
 =?utf-8?B?Yk92Z2JWekpYd2NySjlGQ1BhZFpCQmlmbWVQOEwrWlZZMVZsVDRQcytaYity?=
 =?utf-8?B?ZGpEV0p1bmh5cUVOcVY2eWFGTU1yMFVWODBpMHphVWtGVE5Qc1cwdWhYdHhn?=
 =?utf-8?B?WC9vSXQ3L3AzcUY4T2hUZXpzVHlKbFJPZWNiNlJkTS9WMzUvdDJpV0xWL3or?=
 =?utf-8?B?a3ErczdmNDlTQW85R3M1WG5remVycUk3cENKN2lEL3BqeDlBRDBKbklaQlAw?=
 =?utf-8?B?QnJCWEE1YU1hMzQvbjRXMEgzMXlUS2tDZXd0c2ltbXFRR3RGZ2VoUk5BUUsx?=
 =?utf-8?B?czY4Nk9xbUFxcGdHSER3TFRQNmhuVFJDcWZnV0lDYXFWeWhVME1WbUxScGhx?=
 =?utf-8?B?WDRkakFqUHFCNHIvWnZwYWQwVU9XOWM1L0U0cm5ZV2hkUzZuWjBPRU44NDh1?=
 =?utf-8?B?dEtlVzRHbkNsNkRsUTJKMTl5bUxSTGRaclJaWFgyZzZaRGxGMmhCUThuWkEv?=
 =?utf-8?B?ZmtqWVFCdkt3RThPYlVoTm9LUTc5SzBqUWhSbG5vaHliUGhLbTU3YVJ0ZUo3?=
 =?utf-8?B?a05XNWl3MVJQWGVhMHZmMHIyNjQ1bWZKQ1puTkdBaFZKTjBsQXpaYmdQZTNr?=
 =?utf-8?B?MHlrb0hOdnJNL0xRQjBhR3QrbzBrTFZPTG02OWVCdXlsNHM0bXg0Z2s0eFBF?=
 =?utf-8?Q?0Zt8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d18452cc-dabe-4445-0e1f-08ddd37a6994
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 17:14:46.8899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ndy+UjJH9TpM+yMJyaywGgfEGy9xSGlGvIsIl2rN1tm+55woVAKjgkD3KLjNUSe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6561

Hi Reinette,

On 8/4/25 11:07, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/31/25 3:52 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 7/21/2025 6:40 PM, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 7/10/25 10:16 AM, Babu Moger wrote:
>>>> "io_alloc" feature in resctrl enables direct insertion of data from I/O
>>>> devices into the cache.
>>>>
>>>> Introduce user interface to enable/disable io_alloc feature.
>>>
>>> I think it is worth a mention *why* a user may want to disable this feature and
>>> why is not just always enabled. Here it can be highlighted that this feature
>>> may take resources (CLOSID) away from general (CPU) cache allocation and since
>>> this may be scarce enabling user to disable this feature supports different use cases.
>>>
>>
>> Sure.
>>
>>>>
>>>> On AMD systems, io_alloc feature is backed by SDCIAE (L3 Smart Data Cache
>>>> Injection Allocation Enforcement). When enabled, SDCIAE directs all SDCI
>>>> lines to be placed into the L3 cache partitions specified by the register
>>>> corresponding to the highest CLOSID supported by the resource. With CDP
>>>> enabled, io_alloc routes I/O traffic using the highest CLOSID assigned to
>>>> the instruction cache (L3CODE).
>>>
>>> This is a lot of architecture specific text for a resctrl fs patch  ... I think
>>> you are trying to motivate the resctrl fs implementation. Similar motivation
>>> as proposed for cover letter can be used here to help explain the implementation
>>> choices.
>>
>> Updated the whole changelog.
>>
>> fs/resctrl: Add user interface to enable/disable io_alloc feature
>>
>> "io_alloc" feature in resctrl enables direct insertion of data from I/O
>> devices into the cache.
>>
>> Introduce user interface to enable/disable io_alloc feature.
> 
> The solution should be at end of changelog after description of problem it
> solves.

Sure. Moved this text below.

> 
>> On AMD systems, when io_alloc is enabled, the highest CLOSID is reserved
>> exclusively for I/O allocation traffic and is no longer available for
>> general CPU cache allocation. This feature is disabled by default. Users
> 
> Changelog should always be in imperative tone and problem and solution should
> be in separate paragraphs (above paragraph mixes problem and solution).  
> 
> For example, "Disable "io_alloc" feature by default to ensure all resources are
> available for general CPU cache allocation. ..." Although I do not think this is
> accurate since this patch does not do this?

Yes. Removed the text "This feature is disabled by default."
> 
>> are encouraged to enable it only when running workloads that can benefit
>> from this functionality.
>>
>> Since CLOSIDs are managed by resctrl fs, it is least invasive to make the
>> "io_alloc is supported by maximum supported CLOSID" part of the initial
>> resctrl fs support for io_alloc. Take care not to expose this use of
>> CLOSID for io_alloc to user space so that this is not required from other
>> architectures that may support io_alloc differently in the future.
>>
> 
> The changelog requirements I refer to are documented in "Changelog" section
> of Documentation/process/maintainer-tip.rst. I feel like this should be
> familiar to you by now.

Sure,  Thank you.

-- 
Thanks
Babu Moger


