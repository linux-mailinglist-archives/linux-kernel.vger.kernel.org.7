Return-Path: <linux-kernel+bounces-761226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14DAB1F5E5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 20:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF6B5612BD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 18:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42772C2AA2;
	Sat,  9 Aug 2025 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ITMq6Su0"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486292BF013
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 18:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754765323; cv=fail; b=mwQy6IlKG2z6glD2l3wxn16wkeyYi1NDmUP4M34P4VqhZfIgoPDvc9M2bD23G1ZDEP6zKn/MSnUFUeX2OBE8gWMVTcNxHiQUGa8KDweAvR11lixhJKl+jeUu/ief1IpFk6zlgj6DIWm2WRSRyJrJ3kkY70CN4RyJ4TGMP4HqqKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754765323; c=relaxed/simple;
	bh=dbuebLBUootjrGp0gr9xGLYKZnwF/aMIgr/kH5+LOTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kdaoG39CGMuEJxD4UmRk+Muj9LtF46DcwDzwSRYdXWqFvGpdUBxuzVLkBCEs+CFCb/rVgwN1/dofHsUgriE/YE7rneL4fKCnamzpIKweofBq0Iud9D2eTClLSQHhCV/os716aes7z66A5rVPBRvhfC62CGcBhaYoXi+Pq0HbBQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ITMq6Su0; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbOzC1vJE2xcHV2iKaQTkPy4t15WSUcaDEtKPnB1uRnnOnYSQSWZ3HfOR+Rdn8zc3JlHV9ijyq8DvYLaAMSVx1RqVUu6oX5ZvJUv5zR9MHj4cd0sThA8Zq65aFUUw8zxPJKfHp4qmKBbbDPAfMf3dhpzxeNiz57jk9qYwme3S3YMkZMSKIOExAOUgzle5bysSY9rT/yGmPI2/I9YxQ7bYbTcyGDCACHIkFRgAmrpn4UeO3mBVB2nTBJy2RgSta5KRtlLranPQeLp9Sut2yw/y0rFWjelOSkAUCvQlQ6bRjObBwbaZElsTGAK+0pLlZvdySel5p0mw8ZkhIGctlPUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccykrcY4XyAOBLhFI7Hu/x5eJdDtYHsFZip+WaE/ySY=;
 b=ouFuEiw1iCuPVFmbBTyzxsZ4TqfWL2rSEhwGhNq+PHbNM6+dYvPXyMXU5B9uZmqt/BWz4f+Rcgbi9sGpu7XyPguTAuEL2I9J+a3MesvoJwlcYTq1oms267ZOpVBuxf/1WAbEX8BmqU81slGWRpx6b4AZB6oWuZNMysrBFeUfhFoKmDaqzZwi5i/tcvYrXE80LG9QomFpZBeG3VRk4g40pi88ORidp1fA+qcqQw9EiPrIsHw6uXljI3BwKKKS8obV5ho4Nt5AkzEV6QtgEjhlFQ0vl8IQrZOOyR85SWzfGiyqkl/SCpKoHaP7uG1yvqpjXoMNkn7zXyqDy9tv3STVUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccykrcY4XyAOBLhFI7Hu/x5eJdDtYHsFZip+WaE/ySY=;
 b=ITMq6Su0tybVXkhIuvywVjk1tTq5xR3NN2zmGgQaaraXaMPUGohbmz+ssPBR+LsR+oNdAlibEh/8FKUXhH8Ek8LMEQIvnran7YARP1KdjB11nDLncml8szc00xW1LswEGgWa8KCa8ZhIXEKTIOhXN3tFImCgcOrlzgCH1PW++2Ku6/2gPO9frEUYuz6u6u8WTQG+S6TFXJ+X77Eqz0lYjWYKqiht7QLKmg6jP1QgVlw6bK7gybzpoubLiazkJX3fXsdiWp/Jhx9GJJVT+aNTaUHVo/RV53TZhgY9FNNy6KbSwddAFbiZC52hxFn2z5JEIc+L+P+u2EdnsDRTVLBCIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sat, 9 Aug
 2025 18:48:39 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 18:48:39 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH -rebased 09/15] sched/deadline: Add support to remove DL server's bandwidth contribution
Date: Sat,  9 Aug 2025 14:47:54 -0400
Message-Id: <20250809184800.129831-10-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250809184800.129831-1-joelagnelf@nvidia.com>
References: <20250809184800.129831-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0282.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::17) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e4a663-e261-4f2f-f811-08ddd7755aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FILefFJvl9Fd8ua+1XTa91iERiTOQeHBuvElMLuNY81K6VVB96UegyNDUMaJ?=
 =?us-ascii?Q?wl4UQKwRShGzCAQEJbmFjtVlFutX+4R4BG8Hcke49KFjlF6TFCwz9RbnlDUL?=
 =?us-ascii?Q?T9KlQbcDnd+3urSkk5OCw3Xpgb6YHseBAekZqEnyoiddPzXISo+sECg453S6?=
 =?us-ascii?Q?Oma6hFS0IV8o7GGfZZY5FA0vMYpcrsduqShqanFbjvxjU36aIGzSmuOC+x9X?=
 =?us-ascii?Q?TvaZGkD3P08yxtTs2k0RUKU3XUAz1ICowR0/q7wW0HEBDHhm6b0UEVucm4K5?=
 =?us-ascii?Q?uAywqFbC7Y4wjrvFF3oHA7s5Mtg8oLJmJpWQ+6co8TsfPvTxBQgIEXYXAofl?=
 =?us-ascii?Q?vxPkGJQIdVAjoB+12AgzO3o9Yc0xTdaO2Ly9ZNXrH5kQLO6nN2leeGm/mnNH?=
 =?us-ascii?Q?HYevRjGv87CFluKYc+HS9cJwE+y7StBp62rgpt0F4/HnKDU2Ws+r3YstwODv?=
 =?us-ascii?Q?ecZN5gs8eRZDZbaej1uoEDXSY8samj0fo8wS5ZQvWULPTCGk8+FjGgrA1Xl0?=
 =?us-ascii?Q?77JTxFhfIdQYncpc23w58jfQlP/wGDq/4px1tsl7GJOWAWnVW85GUsV2ZDyZ?=
 =?us-ascii?Q?XFyDwrFISEABM1BLEjhfu9FsW6D6lXtOMmJL9VDpBsbgXcqz6d9pAO8eAAIe?=
 =?us-ascii?Q?Jtna2rFBFgKQh9Gn5576aTazx/9u/DIM3Nh90xyTCxmkBBq1LwcrG2R/PJzO?=
 =?us-ascii?Q?kqTrDF0R+b2Pr1Pg1OxQh2nxt0YSr9euMNJbkr8AMb4pI7bwQq6nTVsdm8EF?=
 =?us-ascii?Q?q9Z0I8brdP6L6y/7x8BBQZgcZ0+xOG6M9/1VAB7WjON8mMZE7WClAbEV4b1e?=
 =?us-ascii?Q?l2iARCi0ftqqQkJmyuuMtHBBEzI2BpqCs/rIO8b+RYG+CBvGB6e3S5F1vFRJ?=
 =?us-ascii?Q?bMTPFaqzaIbybqkjjnDffE1JTFXeOPpBbyCPV+oL1EtiNpsr5dpCEyxmEADj?=
 =?us-ascii?Q?I/F1qWVDOOA3uwm2natqoYc3/3WTGzcyL7pgChIgrTFWDOLrFNLq7s6yGtPV?=
 =?us-ascii?Q?kUyZcMS1wlt5FBlrhM/vmjDdC/0oxSaJRwF+Q8C17DENnlbf8Sy42vCGeZ0V?=
 =?us-ascii?Q?YKCfrIYuLrDGpZpltxzJxuaruyCYui8aKW5k67Ti+hSjCepYrBYjQQZ+bo/F?=
 =?us-ascii?Q?17he/xolCZMD1/I+HXK2wTM3pdoFZeMVNdRb6uRATNXHUg0VY+ZQ6veIgNIT?=
 =?us-ascii?Q?OCp/rVkobxdLm191bphnyq6IgwUOM+LSAX/sn5O3we5hNWljbI2XxOweBovW?=
 =?us-ascii?Q?VzNtBSVQWY7vm0hr1Q8EjzR499BGeV53OcbluzSFw/hSCzxHP6puGlI2iVIt?=
 =?us-ascii?Q?Lpe22dTaHaCAjl/icvfPrE/tti4qoO0Z0FLUE0AB4DnTsnJV55Qw8N0vQjej?=
 =?us-ascii?Q?RjCcqrqMN1gmGrC7XoRhTvWLLCOvRGWMSdkedyxRGTkJ9WRj7jTsn0bRiyHH?=
 =?us-ascii?Q?oCcs6vmEZRJi43RAKp+W8H5mqivmwU+Y/9ryfkN5gaMimivLiZFPNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FD3c7UrcKPR/2CtrtCUzhgoPwemBhHRDo1hn6EqSjqkZtH116VPKPHd4Y7NZ?=
 =?us-ascii?Q?3ewztTFKrZPjCogxnXhS0lrUzTTtxXEHOTPhad8ZO8R0XJX9kGJODA+LPbHs?=
 =?us-ascii?Q?eb16Cgad3X+wnJsglscso5eYFaj7FN2mkV8U/SUgkxyEx4fNBcOklvBB0lbQ?=
 =?us-ascii?Q?ew3cQfP9llQYqhs24cwl2SzY4eYTFkXNYcGvKCueCD10/5XCQlp6wRnRJCku?=
 =?us-ascii?Q?FbhARHzalm2PZyJ1NtZ8CtF8p1aiqkNyk/Y5OHnxaD/M9Ukgb731jna9I62k?=
 =?us-ascii?Q?n2/u9/2dhGXW5fxvw0ayeP41BJW84X2OpvGgugwfFmxUhyk8KLfjO/hh6Sj+?=
 =?us-ascii?Q?KHJG63L1A3Elq0XSlt47V009X2o16ew5XzSgOi+XFmLFebaDVMjRNEpcYGEV?=
 =?us-ascii?Q?VEWm77FTQnnYzMsxQYc053vsgyiy6x/x4WzBEu0FLYhNsi4bg9B3eLt+ybg6?=
 =?us-ascii?Q?POHqbVklhEzBP/tFk/mIboufuyfmSNDBekMoTlUE0TipihTssQHKXeX4Ecnp?=
 =?us-ascii?Q?2IBlv4yO9bBuArzGy8GH07/UAchildR4fYv6IYaDrdJroUtLTS7t1zXdqtI4?=
 =?us-ascii?Q?PzenkuKOQZc15/L+fiyWlG/I+Ux6bQdX5pcr+qiLUPA4ZxjlI0w2eM8y9xXw?=
 =?us-ascii?Q?khACFuzCa/VV+cTlsz1gYii+aoeYeMiLyramknRHfuY35AqHD3mjeY+QomTX?=
 =?us-ascii?Q?X3iqvIYNGedrtUPxpn4+q7DDSAmKDycjhvZcRs7wtZci03YSzgmmlu9DXQPH?=
 =?us-ascii?Q?3/a03V5sNVj/7hw4654XTCnLub04QCS/2rv2jnC/YzK+T005fAoSCdQO+Gjr?=
 =?us-ascii?Q?AXY/HoL0obZxUGPxusxKnfi/lG1xa6I7p5Gk44l5GVHXLj4JfWO37RFO9lN8?=
 =?us-ascii?Q?KjELDCNHfTwkFK3hj8xpkQbK4QeaDw1ALIFlLa5fc8GkjbLWR7S5HU6Ax2J8?=
 =?us-ascii?Q?Ws3/NF3JcYhI43js0OKL9XkG6tvm0uriDtwl60jAsRHAI5slYWHRq+0OMXUM?=
 =?us-ascii?Q?ahxb2XRSolh0NK7/yS4lVBx6L1Dh8iUvOQ6Pi+YtbylMOUL0mJBAeA83toEM?=
 =?us-ascii?Q?3xCQee74gOKJ3j1IhAA2kB1Um2NYOmED9fMCjUOSgRiI7G2SpTjNUGVxQUMn?=
 =?us-ascii?Q?4OJPjGDJsaW1PqijEo9wIXGHpZmmmIf4RjchfY1aGOL7q62hvqOopaHlVo/r?=
 =?us-ascii?Q?NOg1b0YXsPF5VSLLvy075/4zQWtd2Kl2TkqP675xK00UPd791jS5eIyxGWoO?=
 =?us-ascii?Q?cmxssn18K1Akry/BhGkgEwTd0RPEndBtjvkaCNiFhVdy6XLCGMRpH73HgD1N?=
 =?us-ascii?Q?RkWLePSPjB4+0o9vwElkIxSS4gfP9/CyRMikVDIICToHKc3nve6nVrokh5pi?=
 =?us-ascii?Q?Jwmj+fz5LUT80TLknAInd5nkViVVlH/qZ61JMWG+zcqO5mTehYzCbtpCXKWo?=
 =?us-ascii?Q?DxmLlUfWMVchL3YTLWb5C67QkKKqzGdjmIHedgp7nKnKZdWzl2w/eNrkJEbW?=
 =?us-ascii?Q?LA/vj4p3+45mlpd2W2KesGv7d5rVeu9h19KG3zHLUpimenU4PLE1OFCLoh9R?=
 =?us-ascii?Q?CJ5GlgGdQY7AX14yUYwdB0rwEfk2kleyRjz2EaV1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e4a663-e261-4f2f-f811-08ddd7755aed
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 18:48:39.4012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nZLy95G0Fn5v24qZjE1GMoXSxVUmJW4uWyYQh7ItEZv8ruYR4Nc0W9njIOsTodCbSF1lFC4OmFcz2RIPp1sMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310

From: Andrea Righi <arighi@nvidia.com>

During switching from sched_ext to FAIR tasks and vice-versa, we need
support for removing the bandwidth contribution of either DL server. Add
support for the same.

Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/deadline.c | 31 +++++++++++++++++++++++++++++++
 kernel/sched/sched.h    |  1 +
 2 files changed, 32 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 00bafa434fb8..17f8cd5df1aa 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1707,6 +1707,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 		dl_rq_change_utilization(rq, dl_se, new_bw);
 	}
 
+	/* Clear these so that the dl_server is reinitialized */
+	if (new_bw == 0) {
+		dl_se->dl_defer = 0;
+		dl_se->dl_server = 0;
+	}
+
 	dl_se->dl_runtime = runtime;
 	dl_se->dl_deadline = period;
 	dl_se->dl_period = period;
@@ -1720,6 +1726,31 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 	return retval;
 }
 
+/**
+ * dl_server_remove_params - Remove bandwidth reservation for a DL server
+ * @dl_se: The DL server entity to remove bandwidth for
+ *
+ * This function removes the bandwidth reservation for a DL server entity,
+ * cleaning up all bandwidth accounting and server state.
+ *
+ * Returns: 0 on success, negative error code on failure
+ */
+int dl_server_remove_params(struct sched_dl_entity *dl_se)
+{
+	if (!dl_se->dl_server)
+		return 0; /* Already disabled */
+
+	/*
+	 * First dequeue if still queued. It should not be queued since
+	 * we call this only after the last dl_server_stop().
+	 */
+	if (WARN_ON_ONCE(on_dl_rq(dl_se)))
+		dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
+
+	/* Remove bandwidth reservation */
+	return dl_server_apply_params(dl_se, 0, dl_se->dl_period, false);
+}
+
 /*
  * Update the current task's runtime statistics (provided it is still
  * a -deadline task and has not been removed from the dl_rq).
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 51ac373554de..719f9424b417 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -395,6 +395,7 @@ extern void ext_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
+extern int dl_server_remove_params(struct sched_dl_entity *dl_se);
 
 static inline bool dl_server_active(struct sched_dl_entity *dl_se)
 {
-- 
2.34.1


