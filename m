Return-Path: <linux-kernel+bounces-617824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CD8A9A68B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 10:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C298218805DC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 08:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F288F215062;
	Thu, 24 Apr 2025 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kx5IoAi8"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A131213B58A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745484120; cv=fail; b=bBg9chv7zott5ZQnydLO0vqe+ZuJtXzc0mprbZ7s14vCibNEzUG8roWNJ8wmyVM4tA4eSSr0LIjziUQvW1ssTUPXAv8b1NqWkPg/kWG4Q7UAbcYb3DW2xsS1zEXuX/V/yYINevqLs1LHUin50y+bmk3xEzVAbokqjutuoKVsMBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745484120; c=relaxed/simple;
	bh=sPU6I5qFZSIYB1HFIIkGmyq/fnr4Borz3jLMN7SOVBY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mV7DmSca8g88ADcx9zN1lCYTwRzIV6SKv56yhtDLtOoIBhFu60jJqteX85EvlwyC13Z/4Ek8RAgb1DCezPN9DenXR2r+ume6A+npfPt512//hEvLvMWqtsnEyfDSmhYKTd5bzsegfnx/RX3pWzzugVfTcBZyiN3kUfYMHyVq5ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kx5IoAi8; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZ5QAewq+3ODkQR8YcM6m2Dxv0WgOsyRtNcaqhKk4OWR9ptGkhUadcbDWhy5u4HLpXvIDGqMX4hKPom8CXNfMCZ75cQBf723yrRSR4vUvdeHqaka/1SLhSZRdHNZnhGHrFUhCi9hyqQt5essoLLn/6O5rNY6nQ9jcx9r20HbM+2IRr9rFqDwl7nBm+2MTdG/2Jc+yCia/Z9X1KG66zjZhipy9tRg3Yg31NHwkVfuxt5PfairXeXHx96ixzReK3i83Jbe0uWO1mgDmKZwqu74iIT0kKSakmFdlvgn/438h7x3eqCtngRhc3VdFgT+zfD6Hx6tB+3CkiYSfAiVfs1PQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFXFoCODN4SBN7bXLAC2jHegIZHMz/4Vz8lWODQmisY=;
 b=nBIwxo2+QiYFSpZqM6pTbXa4kItqlcx/b+ttMrB6sQ+2A2coCw/sO/q870sy4BUIZTmiJIADuKZD2qx+GtBAndqCSf9PCI1q6gHnLcFcLt94jHD4vtMIgdjhdqQaRPpXLtLm4IBybfZqZ4JDk8LaXT3rAcWT8Z1T6LN8Xpu3FNNg42M6HQd02xW093lzTP7lCYnULjrQz42ncKnKxxT+gIMnaRBsqSrGfSYnIxPzsNJ7+9+WRC+oaqZaQ7MPrcBGQ6YnZ2Gfm9foq6OWa9XX8RqwO4ooVJEOGM9q7KcSaGXFrWsL0vquW9XUv+UWfk5qXXptvo2xgH2eIo1ZWBAXSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFXFoCODN4SBN7bXLAC2jHegIZHMz/4Vz8lWODQmisY=;
 b=Kx5IoAi8UeBvJCbNDOHgI3lNdf9h/qgf15OOwFraFI5GMU0d8hFh++cEfCk4ivuT0JS7KKKPqLXuIWmq95A1pt1cVASwCPzdO+yf28rjDo16kOVHCQZJeyj7bimgkWNBl+ZG5OhvmLxJxGpVblGmbaxWLprx3/HiwluRmURy2iA=
Received: from DS7PR06CA0001.namprd06.prod.outlook.com (2603:10b6:8:2a::12) by
 MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.23; Thu, 24 Apr 2025 08:41:54 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:8:2a:cafe::22) by DS7PR06CA0001.outlook.office365.com
 (2603:10b6:8:2a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Thu,
 24 Apr 2025 08:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.1 via Frontend Transport; Thu, 24 Apr 2025 08:41:53 +0000
Received: from FRAPPELLOUX01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 03:41:49 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich
	<dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 06/10] drm/sched: add the drm_client_id to the drm_sched_run/exec_job events
Date: Thu, 24 Apr 2025 10:38:18 +0200
Message-ID: <20250424083834.15518-7-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424083834.15518-1-pierre-eric.pelloux-prayer@amd.com>
References: <20250424083834.15518-1-pierre-eric.pelloux-prayer@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|MW3PR12MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a8682e-3b3a-4595-d669-08dd830bdd36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2FWeEZaMHZFSlY0dENVYlFGQ2dickk0SDFJM21tUGJ3QnZoS2hNaUJnSHBH?=
 =?utf-8?B?bm1kNFNMR3hUaGFVWi90ZitTZktaRGk2OGFDVWlkSTFlbDl3aWVxK0pSc1hB?=
 =?utf-8?B?S2o0Vm9TY3BPL2c4cHpZUGMxN1VaemdzbHZQN0d0bkdsVmFPR3M3NWZ4aDVm?=
 =?utf-8?B?RjR4YmU5TDhPbEJoOGc5UFhFZ0RKVnoxRHp6cWxQY1AzcVVUS2Q5T3VnZzVO?=
 =?utf-8?B?S2FCWXJjRmFhcHZQSVVBU0pnb0hBY0xObUpjeURacnR0Ylo1SE5XUkozbXNq?=
 =?utf-8?B?R055Zjl4OXNZRGNsUWtWYVh6NEMwMTZIQUN1djhoNWRpYTVPRmNwdUhIN1ox?=
 =?utf-8?B?N000K1RvT0J5WVhHSHAzUE1RR2k5MjlEMWY3RHAwcGtwaGt1TjZJV21ublJZ?=
 =?utf-8?B?Nk44Y1JRbDk0UGR1NUl6VDNTeHoyVllyU25ZK1ZUWDNUNDlONmRBNGR5MzBp?=
 =?utf-8?B?TU1KdWNMVHZ1a0lWY3pydEJOWUlBRURzb0Q2RUVNdUVjbHNqRXNSWlg0ZE04?=
 =?utf-8?B?Z29iNExrZHp3NFh3MmMzWHYyd0VJUTBGVFozZUdBMVJXdE5hTVVHOGpuZ0sz?=
 =?utf-8?B?bCtPVlBzdmY1dEV5QlZyN1VwM2lhYnl5aDlvUlYwWUpFaFpVWUlvRjMxTGVT?=
 =?utf-8?B?blkyUW9lTnEwei9Nb09ZUW9UeEpWMEZrZHpEN3RUNGFpMnpEVThJYXZqb1Qw?=
 =?utf-8?B?aHFJUjhrMTJXYjNkamNtQ01ja2x2S2pvK2p6SzJIekQrRnRPQUU1MmZZNVN1?=
 =?utf-8?B?b0dSL2Y0Z2IvYlgzcXN0bjlvd2t3NDREd0cwRE8wR3RBcDJ4aDY3cEZQUTZE?=
 =?utf-8?B?aXJESHcxQjZnQ2ZCeDVIemdGSmNCclR3T3M0ZmdaKzFVUHpJaXB5RC9XZXZD?=
 =?utf-8?B?dTNOdlpxK3VHQWhoWVpoN21XdjhDdGpSTWRyaEM5dmVCWkNId1pkajNMZWZz?=
 =?utf-8?B?bHBxTmtXeUU3RUllTU9ZbHVPd0U3a2tGejNrdCtlMjM5WkFZREt6eVZReFph?=
 =?utf-8?B?eWIvck9jcElUY2JZMFBZd1NOVFIyWWU5TTVBcmUwUjNSQXYrNFdjUm52UlJh?=
 =?utf-8?B?VW9sR2FnK2ROUkRuVjJreVdnclJrVFZ2TC9FRWUyT05LN2JJeEJOamhVL3A5?=
 =?utf-8?B?WjRzUWdGQnQxL1BYVjJSRFVsT25JbURQYm1nckkxQWtnS2w0SFJXR3lhaDM4?=
 =?utf-8?B?NjhsWVZ5N2cxTUJ4c3hvMEFGNjFsaW1ZR2REZG0xYkpJaTVrSkh2RzVrcCs4?=
 =?utf-8?B?WFgxWGI5bnByeHR0MDVQNEh5L05Lcmc3dk5lSC9ENWpSU09RMGJoTmFEVGVi?=
 =?utf-8?B?ZExVLzcxRHJVSGVnU2lHUnhGeFR2dHFsUXJWQlUzQVlidFBhQTMvbGdMVU1Y?=
 =?utf-8?B?ZHJyTjFpZy9XTFNWdGkwT3NiK2F4MmFWNHMyMWs0RCtMMkxGd0kyR3hCM29Z?=
 =?utf-8?B?QnVqMHRjcGlYcEM3ekRwVkE5Z3pEY0RBVENKZjNXNFNvRGtJVElVT21NY0pN?=
 =?utf-8?B?QW1seDh1bnB2SzNwcUFxdEFzZjJDRU1ETllBckd2U1ZDZEpzVVd3cW9MY25C?=
 =?utf-8?B?RUp1aUxhSVQ0VDdnM0ZBM2l1dXB1eWNQYWdkcmozSEFmK3dLVVlud3plYUo1?=
 =?utf-8?B?clhqWlBkNDN0YWRTNTBZci8zRWZpcUNHZW1LZmx4c0plY1BTUWFmRm5UT09i?=
 =?utf-8?B?dnJsb1JoQU9YWmpHK2FsdWlqWlMwdXlWNXhiVjhycktJUzY3WmJqaWxYN2VH?=
 =?utf-8?B?S3VrTUVrTUtMY2tWdFEwdVZMM0xhOWJEc0hkNEZMcldjSGplVm9ZRTlwK0V1?=
 =?utf-8?B?NWxuWHlsUU9wUklwVTBJeTRkZEVkajZ1UjRtN2IwejhZaU5MbFhDNzFaVE1X?=
 =?utf-8?B?eXplV05zLytMclJHWmxoSGZrTW5HUHkvWGp3c3pqOFpSNGpCZnhuaHFZUFhW?=
 =?utf-8?B?UTJMeVhVcS82MWthNVZJOTdhK3JyVGowRTVhbkR5YVNTNmpXbk4vNlc5dzVx?=
 =?utf-8?B?eGFtT0praWpab25hczUrazhIblZGbW9GOWNkZTJQRTgxY3U0NG9LeStKUkpK?=
 =?utf-8?Q?kdufhF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 08:41:53.5070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a8682e-3b3a-4595-d669-08dd830bdd36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457

For processes with multiple drm_file instances, the drm_client_id is
the only way to map jobs back to their unique owner.

It's even more useful if drm client_name is set, because now a tool
can map jobs to the client name instead of only having access to
the process name.

Reviewed-by: Christian König <christian.koenig@amd.com>
Acked-by: Philipp Stanner <phasta@kernel.org>
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/scheduler/gpu_scheduler_trace.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
index 5d9992ad47d3..38cdd659a286 100644
--- a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
+++ b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
@@ -43,6 +43,7 @@ DECLARE_EVENT_CLASS(drm_sched_job,
 			     __string(dev, dev_name(sched_job->sched->dev))
 			     __field(u64, fence_context)
 			     __field(u64, fence_seqno)
+			     __field(u64, client_id)
 			     ),
 
 	    TP_fast_assign(
@@ -54,11 +55,12 @@ DECLARE_EVENT_CLASS(drm_sched_job,
 			   __assign_str(dev);
 			   __entry->fence_context = sched_job->s_fence->finished.context;
 			   __entry->fence_seqno = sched_job->s_fence->finished.seqno;
+			   __entry->client_id = sched_job->s_fence->drm_client_id;
 			   ),
-	    TP_printk("dev=%s, id=%llu, fence=%llu:%llu, ring=%s, job count:%u, hw job count:%d",
+	    TP_printk("dev=%s, id=%llu, fence=%llu:%llu, ring=%s, job count:%u, hw job count:%d, client_id:%llu",
 		      __get_str(dev), __entry->id,
 		      __entry->fence_context, __entry->fence_seqno, __get_str(name),
-		      __entry->job_count, __entry->hw_job_count)
+		      __entry->job_count, __entry->hw_job_count, __entry->client_id)
 );
 
 DEFINE_EVENT(drm_sched_job, drm_sched_job,
-- 
2.43.0


