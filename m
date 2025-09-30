Return-Path: <linux-kernel+bounces-837782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C79BAD2C9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB273AAF13
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435362FFDE6;
	Tue, 30 Sep 2025 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MXykD2a4"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011031.outbound.protection.outlook.com [40.93.194.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5DD18BBAE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759242518; cv=fail; b=Eis418dP1EZimZqRQGDHT1mGByxAUlUU+3X0cUGB8EkzfqWHnnd0Wzc8mXXoIYVIGYqH+8SuidjOHRstERQq+hlaiOKvDAwr5K+sMVI73HuuY10G7grohXOipjuQPpVt31z0FBJo7+LhILiBfTzYc/jsQ6Wx0N86JA/75LY6yKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759242518; c=relaxed/simple;
	bh=bNHH7fqiQoDTNjZTQNTt3ik9xD6Zdr/PtIg7yLPGHRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n7umQ+g28NtH7T8uCNYkPGQynp6NMjAzG0Y05BiZN1gsTo5D6PCIfZTkk+oHnl7KA91Ly+lpasYs5zleJrlfWvnVjwnDp/NgAItax0k/AbO5A8DlonwYrFuD0HBeEDmVfDQBDgoPVfon487NEpTdlqcyWLdJhTyRrY46qqQTt7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MXykD2a4; arc=fail smtp.client-ip=40.93.194.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LN+0yW6gZJpPWNYWAJk9Bg+CmLOTop6DbnbjVbz8YRDyxsLOqTaAuhfqO2SZxV8dTv0wNN1CkT7Clgmkm1PvK65qSxcs2NoCabhG2u0eVlycxzdnQkP2TOL43oVp6Pio9SiPfK0/yNsp6rlTLUcU1xD9yOfbidjF1VTl9Fh4HFCp5zYHdp72ZuWvqKwMuwrdPp1LEzhylqi13E903j8PI/FvpJm86rPL2rDF542/y3ye2SVlKfySzCVjxrrwvT0LH0avyRxgxRx9rJ181/edilm5JaN5oAOMtip9DIOdJipt+7l7RMkzvdrkgV5QeFr1PDL+csrvocVUQ9fIYgYItQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcxnqPwkOV/Ukne/2LS9fWen1M89DKiQXJSfhbUJsiA=;
 b=PtKVSG/dgyfqZ0paLHwv8UMzwvR039MYdKA+uwiCmOf6z2dK47f8Rk20kFhdA2dLqGkRnYJi7zkHvh+gvxQgztG6vEfuja2hTaSht3uL7e8OyRl77IuNIY/uynfrP+jEBJirRv9QvmIGoFHnb9t5mooRHlRsgO7KPLgJ6b9RAIPcXlYVk1IiB3nmiMlDn4tr85UEPGI09y6sU7mPH7MivZB4vmrNzJH1tXqkA77xe5a86/PplWrvz+OdCAk4Rlbl8SWOS2rnSHyKZG995oTiGLYm8Bk+7pIeEri5JZT8h09GN6YyFYEvy8Pl5EeMS+oEm6ptlTC3I76GtcscwjsKNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcxnqPwkOV/Ukne/2LS9fWen1M89DKiQXJSfhbUJsiA=;
 b=MXykD2a4CfZgvvmOO07v/a5G+UujFwkGjxuFEmex8hPfkTmZN2NRGH6lApcqlKV585wg9UwpcGHk66Kh89BHihVzsJq77wrOYnq8WNA+yCyUiheunlYUi9BftvWfpINMKEy0iI2XkP+Un8Kh+8Ohv4oBtBL+q5j2l2zarTOL2KGn2SbhUFY3lKyfy//Yjztst3NdPoWI2v9Vq+kZc5AAaWThnAXskEPS8TUy8d6odiiHhhYq5fEPFkNJc8vu5giTdlm9PBvAy/t+uyxwYiEnsNul5iQjFATvtBZ95vIbLMls8MUtPSrg5A+MfYG2PAO8KPAObOh7oGsRePaXeec/7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.17; Tue, 30 Sep 2025 14:28:32 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 14:28:32 +0000
From: Zi Yan <ziy@nvidia.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: zhongjinji <zhongjinji@honor.com>, akpm@linux-foundation.org,
 surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, liulu.liu@honor.com,
 feng.han@honor.com
Subject: Re: [PATCH v0] mm/page_alloc: Cleanup for __del_page_from_free_list()
Date: Tue, 30 Sep 2025 10:28:29 -0400
X-Mailer: MailMate (2.0r6283)
Message-ID: <F1AB428D-73B3-4E40-939C-2A7BAEA1E73A@nvidia.com>
In-Reply-To: <6fa0e2e3-045e-446f-8ef3-955711b6aa82@suse.cz>
References: <20250925085006.23684-1-zhongjinji@honor.com>
 <6fa0e2e3-045e-446f-8ef3-955711b6aa82@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAP220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::25) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8d4420-5d07-4294-d0a1-08de002da1a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHBQVmNFZ3BnNitIYVZCV3N6UktFc0dQS25nR21XYUE5b1gyWXVURnVNNFhT?=
 =?utf-8?B?NHpnRlVKVDg1cWt1SVBYTzZZUzBqVFpJZ0FkWnh4eE5udmVPaEhGOURHOWJw?=
 =?utf-8?B?OEhjeEE5M1VnTFozZUNUVk9PQVFoVXpPWkRaUlZ3VnVwKzUxK0hwSVFRRUxa?=
 =?utf-8?B?SGM2Uk1NaXhVL0tBU3RkSU9uVzRVUVJrMXlkaGZ5N2g1SmdGNCsyaE1UdE5j?=
 =?utf-8?B?OVMrWkRGaTBHV0E0Qis5ckYyODlYN1JvdjRCeFZBNVVRanBKRHJ2SCt1T2t4?=
 =?utf-8?B?RVhqaTd2ZTVMQ3dpUFlqVVlJZEJBWkZuYXIzMjBJMEwzclVwa3lTbHZvTjVQ?=
 =?utf-8?B?YnhVZXVDVXBqbzlTb2QyV2xnNlVselpWa1VFbk85RGtNTWRxWG01MFFwY3do?=
 =?utf-8?B?Undoazl1bGtocHA4M0dPeGdxM3EwTDUwcjJpN0Yxazh1bDhmamRhRUxCY3Nj?=
 =?utf-8?B?Mk9BdjY3ZHg3UW1hZnlQb1BQMFJNMXpwQjVSOGhFRzZGSVlCNmxUa2w4aWdn?=
 =?utf-8?B?K2hhZXVoOFVKRTJpaVhoZEI4YU50ejN6SzA5bmlZUTZBL1h4eEFUY3E2dlZJ?=
 =?utf-8?B?TnhxelFUWFA5WSsydGE1aUtLZVFhYU5HdERMVHR3MDU2ZndNRW10ZThlNFVL?=
 =?utf-8?B?T2xzRGtZb0FDNnpiV1kvYlUzZmcrWHpxM1lCcW40NVNkS0xKOTVrb29CeTNQ?=
 =?utf-8?B?QXZ2YXhQWnVnclZ0M2pYeXpvdmhOcDI5OEdsSGFja0cvaEU4QUxjZURUaDR1?=
 =?utf-8?B?cC9YcnUwNUs1NXBld0F4ZkdCYVAya1gyS3RyZFlTbmFSMEhXckNsay9TT2Zh?=
 =?utf-8?B?OWJ2d1FjNk91dVp6OEMwR25PblY4UG96VUdRUnlXRG04ako4UjUyUWxBamJh?=
 =?utf-8?B?a0QvaHlPREl6ZnJqck5yQ3V4cXJXa1MwYmlTRjlROTJlWGtkczdxcmNPMXhO?=
 =?utf-8?B?WTZIS2dYMmpneU44V2JHMEdlUkdTQ2VGNEFkdGVuRTJHQlFwUmJrd3U2aGYv?=
 =?utf-8?B?dzlIZFBmdmszNWRFVndiblFEbmd3YVNCRm1JRXlaNG11THRRdUFucERWN1l1?=
 =?utf-8?B?SkJTOVhXYjhLbHU3UUJMMnhkQjVaZkJaOGxpekE3cGQ1UUJKS2VpOFlFR0dm?=
 =?utf-8?B?MHovMzAzbFlIbm5GVHUwalJJYWh5c0k3ZS9FT0RPUUUxS0NwSVFWalFSMTRP?=
 =?utf-8?B?bFJnbFlOcHdFdDhWZHFKelByUTlkZDBGVmFuQUVmdlcrNWcrcm11TFlZL1Nt?=
 =?utf-8?B?b1BxRUxhTEZaNWxsTGMzOEhOQk9reGMyMk1CMy9USm9FR29NSFRpeEdFMGc5?=
 =?utf-8?B?WWxyRjd2QkY1VC9BckVzUlBzTER6QWk5TU1wL0Q5SEtBQ2k3MlZCejdiZ3RV?=
 =?utf-8?B?V3liZlB3M2xIYXlHN0tmNGZuUzI2d1RoZTFUVUx3Yy82SmhkWjhTUFREa3Bq?=
 =?utf-8?B?NmVRV3ZWbHdvb3N1Y3huRGhlNUpHT1JaZWRBcGZtLytrUndKbjZyZlZCYmFR?=
 =?utf-8?B?VUtOdkFSVjZwTUI3OTJrNDVPRmlFcnA2RW5FcWp2dHFwdC9Ldm5UV2RGanRm?=
 =?utf-8?B?NkNJM1dpV0ZsQXF5UUQ2Z3FrWHo2MytZcHB0R1RhdEExWnNGT2E0TzFsM1J1?=
 =?utf-8?B?aWhCOHZYczFzWlBkUzBqRXhvdk5weFFiWmdRQTJkUzZGM2FvbnlqcmdmenFX?=
 =?utf-8?B?ZCtINDBhK0tBUXRCa0orZnMxSDhsSG50anRtVG5QM2ljUUlxcHM4NFlqQU0r?=
 =?utf-8?B?TU1nelVVekh5blpTU0tCOFIvQlp0Y3UvSXZnUjQ4QVNacTJSUmtub0c2Wml1?=
 =?utf-8?B?bC9PSm5aWjkxcHF2RmZzOGJreHBSeXFBV3dLRTdnYkdiM3hOazAxa2kwUFR4?=
 =?utf-8?B?NVAxZWtDWHpOY0dZcGFJUU4xeDBuUWxRbHRNanA3ck0zUUozeTNGN20wZC8v?=
 =?utf-8?Q?Pf5ODU2Wh/0dh/2fVvgI/34IjwTHkmEp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3lyU2pmZTRFVzFwQ2lRRlpNM0FzQmpyUVI0UjJDb2dzVWpGUHF3Z1pzSUVt?=
 =?utf-8?B?aEpWTmtGUlFlem0xeFBFajJ2V3pJcVNYcldrSU9IVkRjcjBWWGF0d0dLdCsv?=
 =?utf-8?B?anVZbUtoRG9hcVJYRDJZaTBVNHRoK1loanNaN0lhT1BPd2d6V2JjZzl1eExL?=
 =?utf-8?B?NzBWOTllY3BEeXEwTFF5R216L3pnNWR2SEJnYzB1L1dmN2QvcEhWRER3eGlS?=
 =?utf-8?B?S1hMekZnV280Yi9hTHh6OWwySjB2eHZGajFKcVJOQ3lTU2hHbWo4eTR1aWJz?=
 =?utf-8?B?RjhGU2RnaTd4dHRlRUx5RDkwZWtWdTRtSmFTQWJUc2dJZVRFc3lIM2J2ajFr?=
 =?utf-8?B?bzV3STdmSTdVdTJEbzBBQVR2ZmZuT2crOS9pMXlTdHBjZk1Helpsa0JCVHVP?=
 =?utf-8?B?OGlXRzloUnkyNXdpR284QnpMeHpHUS9GdE9rVHNSRE0wZzFtNjhNeVhsRDl1?=
 =?utf-8?B?ZkdoeTBVNEd1N0FHdC82bXFrVTI5MTBBRjltbTM3TDFQcC9XcVkzcVJXckQ2?=
 =?utf-8?B?MzZKMG5obTF5R2gyWXlIYWw1TDFFNklQd0MxT3ZZTHRBbXZmODBzaWc4K1FT?=
 =?utf-8?B?ZE1RWlNHYmF4RXBURmlIaitZbkdOdkVsSWpEVGR1Q1Y1Vit2WUN6aHZyVDMw?=
 =?utf-8?B?dDQwZmozM3RGclNMeEZGTnFmUjJiOHBTNlE3aXhjSUg2RE1jWTlsWkFjY0ZQ?=
 =?utf-8?B?OWYxM1NXWkt0VHJyK2pBQkZ6TVFPWjF1djZVUGxUU3pnZWJac0dxSlVhSGJy?=
 =?utf-8?B?TmtSMS9tZGl0OXRkZWZUMzJtK1c4cGRSc2pUQXJTTmR6SjRGUFdFTElQajVx?=
 =?utf-8?B?WGFWbVlWMHdra1hxZkF5emJpVHVGS0NOcFk2WnlxUUZlRmtsSmdxbldONnFT?=
 =?utf-8?B?U2JyTWUrNG9NRXRMZHZYRWJ4a1RxbFNSUll1ZFdNTmZyS1NNdU1maEdTWUtR?=
 =?utf-8?B?Z0ttSGVUOVhVVzVSWEU3QzYzb0tNR1ovR0doeUdjbHNXUHNPb0RRdGlkVlZX?=
 =?utf-8?B?RDNXeFlBVm1GNkU4MXNMNCtEN1RrWlh1cHZmRGVCMlZUREgxSy9zS2NGQXhW?=
 =?utf-8?B?ajNzZktUSTBLNTdEdllZUWRWamxBZXVTS0htaWdXSWpTSVkzbXI4S1NFaTVV?=
 =?utf-8?B?MkRmcmZUQklrbEIySithaFgyaFc2UU9GYmhoY2lhSmQ4SGtNRnhDNUtEK3p3?=
 =?utf-8?B?K2JnUVdEZ3d2YmEvTjVtck9OcnJZdkpCU2lkUTF3bnl2Ty9zV2tBWkI2KzBR?=
 =?utf-8?B?SjIzbzhMOVZIdFF3ZjN5ZlphR05DampBUTJmRkM3MEdwZXRmZlA4V1hadUow?=
 =?utf-8?B?K2MxTVhSMFhuUWU2Rm5BU0hTb2VRS2VwK1lDV2E4NHpKVzZDRHBRQ1VLTTRC?=
 =?utf-8?B?UzZ6Q256OHoybUFGdDQ2Y0VMMGpzdXNOYzQ3UDJHclIzSWhObGt4VTl4SHRh?=
 =?utf-8?B?QzA2b1hRUDR2dXNMY3NBM0xNVXFvUUgxdUZaOW1mOGlsRk8rMGFVWFBiUFNW?=
 =?utf-8?B?QllvY1N5Rzl3ZXdSYlJnTjR2R1hyS3Z4M2U4SDN3Slo3R2ZXdk43Q0hkREZH?=
 =?utf-8?B?Smk2aEF4NXc1Vy9ib01GZzFtV1IzUEhTcWVPSXNjMVA3RlE0OWpkeUN6c3Zx?=
 =?utf-8?B?OFlzalRZN3RFYklQQkY3dzJFQmFiNWc5ZFgyOEpJZlA0SERrMWZkZjlOSTFk?=
 =?utf-8?B?dU1QcFEydjRoWjNtNU5HSmJ2SkYzQTd3RFN2MFJvaFlaNGU5N3cwZlVKNkkw?=
 =?utf-8?B?dWIwNmhxaDJqOVcxQlJ0em1JcGVsUE1DVVhiUEg0clIxcngwSHVCckI1SS82?=
 =?utf-8?B?bk1kN0VVczIzekVuN0VRU09MSll3ZmNRbm8vSkRvVEVvdUxTam53dmthdUZ6?=
 =?utf-8?B?L0wxWnk3M01ITlhNVjJBd1F4NTNKSVRQSDBQNEx1ZllHRnlaNEErNzJJRnlR?=
 =?utf-8?B?d240eEs4ejhEa2V5dTN4czJxN25LNGxYaE1Eb2RJSUxSL01qZTFXZjdsTDNn?=
 =?utf-8?B?UXF5NlRyVFRLd1QwblFyTitleTZwSGxpS2RmdVp2dEJDa2d6c0tsc2gybVRS?=
 =?utf-8?B?WjFGSmJGdFpBZll2OFc3MTZCd1VLcjl0LzN6aDNCNDBHbTlXTGlyQm1mVTRX?=
 =?utf-8?Q?sQIemqbu4/lETww88gJiQRxUS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8d4420-5d07-4294-d0a1-08de002da1a5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 14:28:32.0146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXpvJtNv5oEzzIIMXhnn/lR6KkXoPsp9eui0MZL9qNHEs/kddqap1okZ68+oCj+Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526

On 30 Sep 2025, at 9:55, Vlastimil Babka wrote:

> On 9/25/25 10:50, zhongjinji wrote:
>> It is unnecessary to set page->private in __del_page_from_free_list().
>>
>> If the page is about to be allocated, page->private will be cleared by
>> post_alloc_hook() before the page is handed out. If the page is expanded
>> or merged, page->private will be reset by set_buddy_order, and no one
>> will retrieve the page's buddy_order without the PageBuddy flag being se=
t.
>> If the page is isolated, it will also reset page->private when it
>> succeeds.
>
> Seems correct.

This means high order free pages will have head[2N].private set to a non-ze=
ro
value, where head[N*2].private is 1, head[N*(2^2)].private is 2, ...
head[N*(2^M)].private is M and head[0].private is the actual free page orde=
r.
If such a high order free page is used as high order folio, it should be fi=
ne.
But if user allocates a non-compound high order page and uses split_page()
to get a list of order-0 pages from this high order page, some pages will
have non zero private. I wonder if these users are prepared for that.

For example, kernel/events/ring_buffer.c does it. In its comment, it says
=E2=80=9Cset its first page's private to this order; !PagePrivate(page) mea=
ns it's
just a normal page.=E2=80=9D
(see https://elixir.bootlin.com/linux/v6.17/source/kernel/events/ring_buffe=
r.c#L634)

I wonder if non zero page->private would cause any issue there.

Maybe split_page() should set all page->private to 0.

Let me know if I get anything wrong.

>
>> Since __del_page_from_free_list() is a hot path in the kernel, it would =
be
>> better to remove the unnecessary set_page_private().
>>
>> Signed-off-by: zhongjinji <zhongjinji@honor.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>
>> ---
>>  mm/page_alloc.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index d1d037f97c5f..1999eb7e7c14 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -868,7 +868,6 @@ static inline void __del_page_from_free_list(struct =
page *page, struct zone *zon
>>
>>  	list_del(&page->buddy_list);
>>  	__ClearPageBuddy(page);
>> -	set_page_private(page, 0);
>>  	zone->free_area[order].nr_free--;
>>
>>  	if (order >=3D pageblock_order && !is_migrate_isolate(migratetype))


Best Regards,
Yan, Zi

