Return-Path: <linux-kernel+bounces-751411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FB5B1694B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 01:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8AEC18C4DBA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3F3229B15;
	Wed, 30 Jul 2025 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2a/6kiQh"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA8B17BD9;
	Wed, 30 Jul 2025 23:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753918312; cv=fail; b=ZhqEO3YOEilWe80SiM0k3TuKcDD0sXaV3faH6S8P1va+/HXugXH4zcY5l3zS52vTubUax6oHMHwuuV7DZ2AbszBRFgetpM/mpo2cYgQ3il08vxPZ3zTxBVehKFvMxZt9kYeGMafvvAcVsiVCx9al2srTiQJu5JPTpt7XEdFmuNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753918312; c=relaxed/simple;
	bh=R/pr+aKpyC+e99hNZCsAhBgvhUp5Ase8EpR9gIprHrY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fUAC7/4DidZvegr2+aQ2NK82qeaj+I/VB+KACrCsyLvV9frZojwqBKthctkqxTSMsqS6GjHMPx3XmuTHVAkv89Z4LGbz6kta4i0+GtXTw8PrKxDJ+wFFtCkBwKh/o3Ii9C3Q9cJ/2JE9o3D44ZHHGcuI5dbzXDKsC4Br4JjMbbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2a/6kiQh; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fycATVUpwzktmca5eusKCR6DeXejlCWFICy3YYum+W2Ixyw2Gnw/JU8QbD8l61FSYUlJ7DAKVDCAN+DUITly3bv4JU3nxN1Ezu5wzQeEnTuzOH68ACoGwuCtgV+jHSVVX0XlR+MEKstTCaflzYBt04pzG6hQQvJV0Dvm7ak8wIBZ1T6828tClwGZwG8nRT+YJ87sAUw3SEhGkbD130tWE/+gLM8cgfDhqX80Pkj5J/96yJTmLWU6oYYP9dgI5gRKHXbN8mJwpI7svilcbwXON1DUvhcKW1dZQcAgh4uINdJtcB4WrsSIava3qF47m/5tEAo/xJKksnm5or56zaV5qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WID+21ILgXcTTpfBEQOqrB205/l0dK+/A8n/WlspNfE=;
 b=eVam4kCigy1WoKGje7uNqtHc2FMuwr8SMpOph7H7eNv6fplLuO2mST5utSQk9n0T29Fx7QygONFO+0lgWypfBu3iYDYOkOrB810TZYztmmUaxhfVXztjXguXHO+ITC5MGc8V5wYXnBwKMhA/GPkxHumocgsU9XuewZe3buLH+eoLp7J/nE0BRW3fKaz5VLr2Kv1/UU17vLmUYDcYYfPt4k28yRg+SPD7E7VU5boFbar2IK5ZGap9liq0V0omJKOobj/LeabjqmJmLBzGqVw5vhaAR0VRFtWcmjRq+uZ/pFiDOSBD6V2oBAvZClp5mPG3DAgH+x1kNuZ+wA2AgWMW/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WID+21ILgXcTTpfBEQOqrB205/l0dK+/A8n/WlspNfE=;
 b=2a/6kiQhUuwa6SfoCarwK0jr2ynsQaM3vbSvf1fsvwKCK3QGY6zCFz4/J8k3SkZUY6DsqTC/wGl19X10cke3YMqfvbBMc/yVGZHAZG81Urghf4JMN8XdzZQ0HKVj+/qExHXHR+TJeIx9x+Oqa9DkjccKOGHaoEHpm4EtAeTgEKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by CH2PR12MB4264.namprd12.prod.outlook.com
 (2603:10b6:610:a4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Wed, 30 Jul
 2025 23:31:47 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Wed, 30 Jul 2025
 23:31:47 +0000
Message-ID: <1a916a0a-66da-455b-9b09-4eae42e6eb1c@amd.com>
Date: Wed, 30 Jul 2025 18:31:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 00/34] x86,fs/resctrl: Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, tony.luck@intel.com,
 james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
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
 <a259ff37-9e3e-4b4f-970f-04610c35f4cf@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <a259ff37-9e3e-4b4f-970f-04610c35f4cf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0034.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::47) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|CH2PR12MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: c8644926-0909-49c8-c7c8-08ddcfc13fe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHhtUHdwZEJSMlgxYjdNcXZORHV0L0srRmIyWmlOZFJnK25Ib3hOemFteVBu?=
 =?utf-8?B?dnFadHU2TFZmdnhTWXk4NGR4UmxlUDBqN04rRm8yLzhYRW9hR2ZaY2UweUYx?=
 =?utf-8?B?UEFjOGk3SnRXL0F0STZPdWNWWFpIWEJuNmJLS0NOWWl5cUE1enE4TVN5TVgw?=
 =?utf-8?B?SEszNTZsYmZoc0cxWmtPQ2JiZEk0c2dGUzh4WHBCM0JDMnhjd2VDKzc2Z0xU?=
 =?utf-8?B?S2pwdUFNYXpQRk9qejBSZnBuSnJqRTgvMEdkTVFMRFIxNnNmTytjR3JKWU1u?=
 =?utf-8?B?dzBTUW93Sm9FNmppNTdLaUJMSkw0SzArNndpRGdCbHE1K1lvZW5mOThRMmtC?=
 =?utf-8?B?Uit5clU3RzNmcWt6am0zMEhJOTVWWXBGajFyb1loNi9pU0MvVStFOTRKUGxU?=
 =?utf-8?B?eFhvdDgrK3hWOWpJWjdNU2pNdG1DR2pJenJqSXptaG1sK3pscXhRY213a2U1?=
 =?utf-8?B?TlVDZE9jOWhlS2JJd1JFSUpBelBRZWpxcEJrQU1uVmcwUEI2TGFua2pmeHZI?=
 =?utf-8?B?SGFzdHB5dDg1bGRpNVZ3WmVrWUJValA4OEhmc21HSkw1ZGRYbjNMSHN1YTI1?=
 =?utf-8?B?UXBTa1BMQkViRzFlN3hWeXlyS0NlS3pxRTk3QkNvYzlnbXRweGJxQVM2aEc2?=
 =?utf-8?B?dWRxVmkvU2lGV2wwRmhzTVZXbWU5UWd1WSswSmJEaWJlN1BjY0g1eG9DZytF?=
 =?utf-8?B?NHhnS1N2d0EwOUpNbUlJL0d2MGRKZ3AveFZ3ejRrUHY0UnJMUHN0bTk0Y09k?=
 =?utf-8?B?OXh1OFQxVEdqK25IK0tMeXlHMk5iNEwzcDhYUUI0dGpxd25Zd2FGZUlyQmEy?=
 =?utf-8?B?Q3ZnNUlrMEVQS2lhTnFuNTh3bEFiL292RlFNajZiZW1QWjA2TlQrVE80TzRM?=
 =?utf-8?B?TVF3cENybXlFbkhFTHdVNnRXVXFidDV4cnV6blh6UEdwSG1xVDZMR1MzNk9p?=
 =?utf-8?B?Z1R1U1lyaTVzNzk2REwwWWtIb1Y4KzdKT3ljTUZyQ2ROekRTR0Z3RTFnaXdW?=
 =?utf-8?B?NXIwVExkeElyUklqVzh2N0p1a2JMbGpMRERqN3pTYXlBK0NiY21UVXgxaGZi?=
 =?utf-8?B?eWsrVTVhZHN3V1RYbVBENVIxbGZCY3NEVCs5Vys1cU8zZUJkcjA1bTRVblJl?=
 =?utf-8?B?VjBTbmlFM25kVjZZUUdNN0pnaGRYZElkQnc1MytITHo3anhmd0VpRktZS2VT?=
 =?utf-8?B?VVNXekg3Qkt6QjdGQm9wY3lUejJER0dUaTYzejhLbG9RT01xK0k0TDUzTVNV?=
 =?utf-8?B?ZklUdFFCV00xTnFSZFJhTCsyV3VqVXJ1cGhWNUdNbjZMT0xQNlQ2dk5xZ0Zl?=
 =?utf-8?B?cnJzbUYxd2l5M05vOEZ6UUtieEtNTEFGYytEd09QQUNKb0kxNWpKMk9SQXRv?=
 =?utf-8?B?UGt3QS9KWllGUkR5ajdFaW9rY2pGMFFaOVk1RHdCeU1RRmhoNjRXOVc1SlRm?=
 =?utf-8?B?bXlsWmJpZEc3QzJNV20wS0hjSHhrY1Fydk43eE5DSWVuMmJxRmd4MUxrMlRZ?=
 =?utf-8?B?L0NKekl0OTVaMXN6UmRyMkthSmlUWmtHZnh6L3g5OUM2R0JwSE03b1AxekdO?=
 =?utf-8?B?dWZGdVAzTjd5dEcwaEErVnRzM1Z3cjRheHdFYjdIQWs5anNLTVNpSXhFQmtE?=
 =?utf-8?B?bUhiS0cyM1FKMDdZU3VvbkJ5SUpsUWtWOWJCblNVUjlkamxRZ2VnM3Zsd2dR?=
 =?utf-8?B?Y0Nid1VwdnpVZ1RvelpHSTV2RWFqb1BLSnlOL2V3ZkRvRVc3STN6Q0thb2NU?=
 =?utf-8?B?b3dla2NoUHNCajdKMG1KY3NXZ2RTaEdRdm9yQmYvdDVwTk9tZjNDVXZOYksw?=
 =?utf-8?B?ZGg3ZDh2R0VPNXdLS1o0Zk9pMFFvL1ZrVm1td3loVkRreTd0ZTVaTCtwMGNP?=
 =?utf-8?B?SCs2Z2NzZ3hnNWRmUE1xM0ZFUXIrVG8ya0k4bTdJT3ZzSkE3UjZEaFRMRDZq?=
 =?utf-8?Q?iZkS48TIuao=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1B4SGI3MEpNcUdFOHUyWXRnS05DZjh6MTI1WElYdEdtYit3SlhlZk5hNzJM?=
 =?utf-8?B?UVh2NFBFMDQ2S29iVkhodFZHeWRYOFI3RkgxVXAwbW5BUEZtUHZpQnEydGli?=
 =?utf-8?B?VDh3dFpFeVZqR2xCUXZrMDZRRi9ad0ZLVjJqek1nZTZVWVROZWJQRy9OTTI0?=
 =?utf-8?B?U3U0ajBSUGxYUXYwNlVVZmdlNzQzMmZzWk9uSXpiV0t0Um1lQTVnSjVsRW1N?=
 =?utf-8?B?UC83WndRdkcvMTRabnJsUVRweEdndytGZG9GRTkra2dLZUZCZEtHbWhreFh1?=
 =?utf-8?B?WjR0OUN4YkRMR2E4S0RYT2tkLzZDMFJ0SEdncTlXbmtFZDdCNitrc25MQXdD?=
 =?utf-8?B?TVlpdTQ0bk1LSWJtQjQzMmVUOC9GN0hjc2NUZldxZlZVTEc4WWtuZ2tobjE0?=
 =?utf-8?B?QVNTMExZTm9Lc3R4SHBCVWZEUzlmZ0RvRkljL28yRW9SV2ZPSW82ckM5NTdN?=
 =?utf-8?B?TkxBMVFpUDBVeW1tck5CWW16aEFvOFlSZDhSZ1I0UGRMSGlSOHBVUTBlZXJt?=
 =?utf-8?B?aXNFQkZRS0ZsWklVaytYN0Exdjg2dXhCRGoyQ3lIbkhrSDZZV2xRWDlaeThW?=
 =?utf-8?B?RUFGcUZ1OVRLQm9nRlNSWDRwbXRtWUJtazJNL0wySDNRRXVwZEtTd3V2Ukw1?=
 =?utf-8?B?cFVDYTRQek5XOWRJTUk3SU1JQ004V3Z1RWZFaUdqSW9QTDQ5R1lMcFV6eGsw?=
 =?utf-8?B?WVRBNzBxS04zck04MzJORE0yTXhJeUhjYUp4bVFEQjU1UE04MEZjRWRweFM4?=
 =?utf-8?B?SHRmaTlNTnNCVzRxZVJ2bkxBZlF0WngyQzRlNEZEazdyTFROVlREWjIwMENp?=
 =?utf-8?B?bGsyeFo4OUlVcHpMTnYrQ3hDQk1GSlFzK25nZ0VmTDBiSGRUbXhOUkRFbHlK?=
 =?utf-8?B?Q3hZWFdRczJoekVTRkZJa2tjdHpMWm5IbDA4SG10UnhPNDJ2ZnRDeW5EYXp6?=
 =?utf-8?B?Y2hpT0VlNndYVzluTkpWVVkrOFNBNE9NUnpxSlc5cG9YdDZtckt0MWRPWVo1?=
 =?utf-8?B?eE9XNVRzcU8zdFpNbDB5Z0lBL1ZhaDh6TFFRa1Jma2tnOFE2ZlVxclVEZzNX?=
 =?utf-8?B?UzRPbWZuQyt4dWI1VjFHeUxkUm9wcFBIVmQ0SFFwaHNHTng4aEZzN2lLVFhN?=
 =?utf-8?B?OUtHenJCRGI3VTUxVWtaNHk1aUlWTHJoU3d3dnFJSnR3RTBLVWlnQmZUTDU2?=
 =?utf-8?B?dndneC8xZlpOeUo5ZVlmUUE0S3pCOXhiOGdYaXdsNjVmY2kyS0RMcUsyaE1G?=
 =?utf-8?B?Tjh6ZnhUNmlVVyswUG5XT0o1c0tZQk51ZmdmYjg2MUxvQVcrLy9Vc3VhVUVJ?=
 =?utf-8?B?NGttOFVJU05oWjRVaXZtWFR4WXgxYk01Qkpvci9nV204YTRQaC9TMWVkd1A3?=
 =?utf-8?B?bHpLbThQckJLcFNET1JMS3ZKZmtKek1oNmVjYWYxTkdiSEpwdjk0TDBqNkhq?=
 =?utf-8?B?UkEva2hPc2Rma0pjQ3NxbDQ3YUw4bC9DL0tGVVNNS2xaeVRnb2RVYlRxNVAr?=
 =?utf-8?B?b2tZOFdhSFVoclRkYnZiWjRRcG5aZ284TjRDb2tUVnJ2c3d6SmdVZVBkS2Nl?=
 =?utf-8?B?QW0rdkxNbmhjZXo5cWNwWHU1aWNNZm82cjlNUXVvL3drRlZlV1h2K1RmZFA3?=
 =?utf-8?B?dmdyem1yVS95RXduakphSUNNNWtlUnB5Q1ZnK0R4eVRqNmVleU1QdFdYUnB5?=
 =?utf-8?B?bE9rTHlxNUlYcVgwODBhc1gxZENWS1V5MnM4SEl3M3JaSE9XdlVPeUVhUEtW?=
 =?utf-8?B?V1V0VWJqb0FCRUFZTURlajBPSVd3QVA1WlJoNmhnQXFCdVQ0dnJjNHlxWVNp?=
 =?utf-8?B?cG5TOTF4bm5CQlBycy9RUmRBQmFaSzM2MEtmcHd0K05oS2pVVHdFOGp5TW9K?=
 =?utf-8?B?MkxZUWxlZzRBQWJ5YlJoSUJ6U1Q3TkVsUm5CSDh0R0twM0UxNGlpR0lubXRv?=
 =?utf-8?B?QUE2enZzZi8yNFYxZ2hITlFVb1RGbUM4dzEwQmF2Rlk1L2xsam4ycnRMSlpw?=
 =?utf-8?B?d1czaE5LU1RQTndnVzNoeFp5NFF0Sk9MZ2Rva0JiQ0NQVTVTNzFyZDhnRlEr?=
 =?utf-8?B?YmFmQlIvZkE3UTlMeC9CWVl0SWlVR2x0TUJFVjRJLzN0RHVNUTJtcUlhU1Ra?=
 =?utf-8?Q?KNdNvlpBn4AyXavfH+nGc7FLu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8644926-0909-49c8-c7c8-08ddcfc13fe7
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 23:31:46.7510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwEUbnYgJxeE+b7k2NIDCfmxMJzd0fbHyW7qv8t1/61gQUQ+X5faAOHamM1ZCFtI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264

Hi Reinette,,

On 7/30/2025 2:47 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/25/25 11:29 AM, Babu Moger wrote:
>> i. Change the event configuration for mbm_local_bytes.
>>
>> 	# echo "local_reads, local_non_temporal_writes, local_reads_slow_memory, remote_reads" >
>> 	/sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>
>> 	# cat /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>> 	local_reads,local_non_temporal_writes,local_reads_slow_memory,remote_reads
> 
> Above are some more "counter_configs" stragglers.

Yea. Sure. Missed that.

> 
> Also, while considering our exchange in [1], I encountered quite a few functions doing
> counter management work for which I believe monitor.c would be more appropriate. Centralizing
> MBM counter management code to monitor.c was something that you planned for this version
> so I may be missing why you decided to keep some of these functions in rdtgroup.c? I
> highlighted these functions as I noticed them.
> 

I looked at them. Most of the functions you mentioned are directly 
referenced in res_common_files[] (show or write) and some of them are 
even named as rdtgroup_<>. So, was not sure about moving them.
Sure, I will move them one by one to monitor.c
Thanks
Babu

