Return-Path: <linux-kernel+bounces-761218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD28DB1F5DE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 20:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E1C16E482
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 18:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75B72BEFEB;
	Sat,  9 Aug 2025 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fb6Azumn"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75321EC006
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754765304; cv=fail; b=dkBeFHGB1rnp0EG7q06+WvQ3aW05Y1O3CJAaB/rcnYGU2r9O17z9FPv3+BDdW6S5r3Lel2o9CFA4v70r5Bjc8eL8FoKVoLW5TECMJW4Kw/uaVI44c7Ut2RZPhIOdlv3GjRmV8KQPv95SwOHf+9108cgDpYou2hUlu975gGNhdME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754765304; c=relaxed/simple;
	bh=GI6RTEquJw+235yiGn5+tKg6z/+eCpmIh8bzkVClpuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ES23LQYfbr7Kr/bW6Perb3+HV0RRWjeZA5CTv4mkSVuFDsnxxi7lpY0ly3WthHwIhdHXikS/TwnPlb1HLNTJrMXu1qd0SqTdNbA10qIkKnHf29XCJXPdBSEWfRVnrutwoktI3fk3Rh4+bz3/HprYOVywo928Lfg4MXWl5QkW99c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fb6Azumn; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qav0/HTnE5luagP9tj17WMAPdLiU7iT5+6nmQ+6g/jMD24CLcnY46aIVUG8gVq/gDSF+HAYkpKvGM/eQKnxEmRnz8tiff5C9+FoWYwz2JbGrn/0MVwIkzBqO9YlJJS5r9dHcHEAwhwb52pe/XCDWh/3dtW2hHPCGqtFJ6hHqxdSwosuVfooxDCLZ16v77Sg3FhWWfZ5Zm1xxw4u0LPlR8qvJMlRaQyvaOdIjIqB8/RuRN65lepSg84UZBX02+h76uJ+T/UQpq1/ed+juwqLO8rXVmRgu4LrOyRMLh7hbK5XOQdam9RoVn7wX2u0XvwZuvAepRmjyMiM9al2K4pj9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ged8g6lTaitVT9SyKr+vR3XERwmTNlO1bjOTKYxmKMc=;
 b=ms8jdUDr/7A+XNo4xORDWpGFPapAG2j2XgYgXB30Be3gQQfskZSot9UFRKQ38FC1XRXkTPhT0rMmaFGTJ44sP3VzsymPkYVdnBqIFA2Apu//NPiVwFC9FDRtgv/oMvDXzECrLRts9vXTj7+XBxseBJgV1zkX54hrfJ15FWUIg/DId5IgnRCaShWESWGfmoxrZQ6fHt+B5UCYf2ytLPA5g4fF3aWbXTMZbZdXS6cF9wlwupp8SM/UfJUUNJZ41ElAJX+nR/O1V6SBF8DdxRoGO6RlhZEmoW4NCPHEy1wrUQlyulSthC00yUqt+0FbRqU4aMxWLwMYPKSzW9h2am478Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ged8g6lTaitVT9SyKr+vR3XERwmTNlO1bjOTKYxmKMc=;
 b=Fb6AzumnwrA6SwHz5osFukrh8ODRV8+9MPwUiSUy4jFS0lLq7CNthYiJP6xsZLv0tRf0+N6Zinew1sMgs+z1NyoH7T3JzQ1MPcinj3fkFpqbA7e2X8zH21bG2OtNfTFC4rLyM++qYNHOzKtqezmyd6hV4+Vz9f+pE6oJOvfh4fIgldxbbjk6I+y44AYGI1RuCvZShf0FKjt/2y6b6hUl+xoZ2NjXy4yKDyTmMUHt4eN+vxK6oMGQyzaXH3d+5SEHGOyzmU/l/8+1v7QDkQKKxfdaKxWIX5ennU8QnwKXNgMYka3MvvZ3CDFeVuIAYeYMsRkXRdUwQIzk0d+LeIeH1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sat, 9 Aug
 2025 18:48:18 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 18:48:18 +0000
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
Subject: [PATCH -rebased 01/15] sched/debug: Fix updating of ppos on server write ops
Date: Sat,  9 Aug 2025 14:47:46 -0400
Message-Id: <20250809184800.129831-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250809184800.129831-1-joelagnelf@nvidia.com>
References: <20250809184800.129831-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR14CA0028.namprd14.prod.outlook.com
 (2603:10b6:408:e3::33) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 4039c6ee-d6f1-4928-f4b7-08ddd7754e9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UVc4rbnhOOWPc9zwWmys1pKEe2x0ziAHxP06MU1gWpuWkUynCB5vMnd5av8y?=
 =?us-ascii?Q?WIHtGTcCD5NoIwNvEpBdZQGXpxMJGWkBe5LSI0oN+drCIRSMs6jgWkP/4j6p?=
 =?us-ascii?Q?x7o9GsKo0yw8wiZRIoR6JBL4qSrfB0tAvfQqaYqlk9Iv3w1pXxv3cX679GzR?=
 =?us-ascii?Q?eVUp+M3uFxavCos96QD5gTb6N9csvkZ2c1PWvAEkGTIPvQ9kx+qdkOHRydAp?=
 =?us-ascii?Q?oE2OgTqNayA4mPTY7vc2SWFFA+4uzWll3uLXaVyqRgemvKby1g1PHHJgE+H+?=
 =?us-ascii?Q?fwJ+Aq+Cw6+huEeSRkJC6jq7Tcvqd0bFCkM3bQW8ZtBnWrZ/Wd6TQWuCg+aL?=
 =?us-ascii?Q?p8zcJAdn3dVZo/4AmZbsb13p8PfzhcrO6WugaHQGT82bk2HHMTYTXde7lslT?=
 =?us-ascii?Q?479KQh75aUjCWBpwxh8Kj91w+EbxcXieKzESsWILCHdjJQ6qGa1I65vvMWe6?=
 =?us-ascii?Q?a6WM5HqwzMDM2lFK5E5+1xUI3j8Kpby3IlwuCWPC1qAGdRX5VuBtIGzJbNUT?=
 =?us-ascii?Q?bsh5aW9kW5W+A3ArfntRsLyJiUa3iFvYnP0QLsqn1P1zyM7DKkix1034xUEK?=
 =?us-ascii?Q?jHODTeluDiKm9A0s7YeRKsD0uOvL2UxSDrbA4OJ7xP1c0XAeoMZS0niE70Bd?=
 =?us-ascii?Q?CJIKVyLvM2jTNCOz75CrTX9FyTIgpyDNWj1BZ9DpfGYaKcV6ZjX+kjFv2ASM?=
 =?us-ascii?Q?zSfX9QC2vEAA92zf5eKdf6dk0KvarvDHmBiGBzvUAq/pWXAvXUCUys8i9oQk?=
 =?us-ascii?Q?5OZgF6XEyQMhELVn/LiOnJD3dtMSxWZVxbbXE707ZP9WjLYv8qpUFRyrUpAG?=
 =?us-ascii?Q?NsnXIrCxP49UmD0b2gz8jSGVBqKCqdgtqLhJz8DguVaLOM+PQ0QZRCqa46cQ?=
 =?us-ascii?Q?5YEn0PICeR/9rB6winUiCHFh3i6KLejoWHRf4Uu6Zb8o7jdU1Gi9BP02wH1R?=
 =?us-ascii?Q?1dGs+nsii8vpWqZHYSUFSQXC/G8DE6xZsU4C8NvxlS7AR8cv7XzZOLHAtJ+q?=
 =?us-ascii?Q?7uARHDXckjCin2n70UkD9ut/GKy9GU2YBel39xCeXEIaWzmSnAtKarLLjBbJ?=
 =?us-ascii?Q?YOiApxYTE/wqZTQrb2UPwL5h8OkOF3rREs4uezno6MMzikn9e+8FMGiYSFVx?=
 =?us-ascii?Q?NyCO/cNZOhfFzW1jf373ydrjT16UUwVCY6949jWLvvvQr2ctqt4uv3c9Lvzj?=
 =?us-ascii?Q?IzfisKWxBu8kBJ3F+l+1qil2+26igx959ESmrtGOqFpYUhTmp+rPGouUZUM/?=
 =?us-ascii?Q?ciu9Y/G3fIdCxifXjVMR+Em901655lu3/pDepFdkgIaC9ie8UgfPsQ0ntjU/?=
 =?us-ascii?Q?XifsFwXtIzHtwXM9KmLHMHVjWD/SfQ47vj3km/tVCcw41mc3Nd9bOsIFOfwn?=
 =?us-ascii?Q?mPmkTzvcFXsIAFkGr6Bjvh6a8d58YvEenRvZtNnHmlB5aaxoAujByUtPHOem?=
 =?us-ascii?Q?pU6h8A09mwNVRcZdXC1aG0JihsEkd5j/38EVk480Pu0BHYyb9BrXDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iziUhhzd1D/A8OliKpLaVf0qDW+Ni76FkOb+m5NQB6GJXdnW22G3qJV1MEmS?=
 =?us-ascii?Q?rfHc27e04LIZwHokmn3Mcj0BcuDBO+/G7K/16IcO0lckAAQ7+yVfv6SuMHVB?=
 =?us-ascii?Q?qDeMOtfy+JR8cdA3AM+MoGBlWajOON3un3g1fpjZJn6jH6nbwV3UhPY6zW27?=
 =?us-ascii?Q?AmuUQsP7OpauE8fRIID6+hw+WTIQ/7gTjaG2Y3jMoJ86owrWLfuA3UrVDpO9?=
 =?us-ascii?Q?c987BQl8pTwROtSHWX7G+PWow3RIry5nyCyPRugw8i5gP5xtzaPxEIAyTCNP?=
 =?us-ascii?Q?8UA/AK67qcCl9QSTCyzP1ODVcSVkI7Wr/JrLHIJtiJ7SN3dWEF5Orph6Mi07?=
 =?us-ascii?Q?smKasGE5V5F1yqk0/wEiNaF4x7S69OGAUwInctYB52XSQa5xESqlWp0chDSu?=
 =?us-ascii?Q?3ihy6Hg35U8LpALVCSSpMTWv94LzJdtnBwbwQkUvZVYgZJozb4xjdwtG/O4f?=
 =?us-ascii?Q?QMduvzIHqmnTfeORXnl6wv0capHcNkiaifaRP9N6Tx4d0W+lGiBAZzvrReoH?=
 =?us-ascii?Q?eTodoIhaCrOYWeZeNoql357z79kVO7NRlbLPfgjvwo0xq7PiYevH8lKaQq/q?=
 =?us-ascii?Q?EERCJS4i5TYIKafesmybfBjyVPFH3jgR8rZiR7PfKPxXqYpD1iVMGlCqxS9e?=
 =?us-ascii?Q?ThXiJAILDWtHWEgT9fdd/OKlNy7tyk0XrDQdSSIYJwBWsImJEcFfoSUBjURM?=
 =?us-ascii?Q?r1zcB16iMBw8JmqyhHeGNeWc50rPzSkeR+kfiMIWJMkdCR002vLDn9gPUFGu?=
 =?us-ascii?Q?xvIBLJHmr8S6GQnYlFIEiyxN689RqxLGMLPqbsnF6waqBQwMsH/LWNz5dsKX?=
 =?us-ascii?Q?24D2P49349YGroPwbIe7yhZhZ3I+OPoOD3goGT3V3yWNwyLibiZEc+8BKbrG?=
 =?us-ascii?Q?W/fPO4UJEzUSHuyS+eU4E15PV7cwU9qUPLGOBg7uDSXci+hi0DEtKpKXfTX1?=
 =?us-ascii?Q?In432h2C5kdAzSiu1LhKMmP+MnjlKEwPQs9O6eSTMG1N9jEQDiONvPRXs40P?=
 =?us-ascii?Q?6vPGj0PKp9PW5F8B6+NG+bS6sh9bm4DMdBmX8QsSoMX1aZxWyA4lLHfLGj1V?=
 =?us-ascii?Q?A3CGMavHNwTZHPdk15KlEoufEkoZndHrwl6glIN1dfgXEToAUcKGGwIppeUW?=
 =?us-ascii?Q?Fads9myJ5JMnO0XyAioHt0MRpyx3eWMuq55cuIRiZDgYpG9c6PdiWTo6FiJA?=
 =?us-ascii?Q?ArsMEw8/TaqF3XQHck7RW/g0XyVB8NUltSonCHMDRCiF0rUszyBm4ewx3PIY?=
 =?us-ascii?Q?rCp0kf00cHnSSxJVrsp/WhMRePeAM5390g4Cl7xDW6xthhyHg+6HjKhfF6Nt?=
 =?us-ascii?Q?qeCguUb4YlnbOLpMkXULqaPG5z1RoAt3g73gX05xyjkwFpToWnjxgkDSMKFW?=
 =?us-ascii?Q?iRls53k6K56M7cYxwU/p3QmKQdBh+oFV787VfzNTLu8+n96uk1v5BAlskk2A?=
 =?us-ascii?Q?jgYIFL6BhTAu9cSbpKtc5wW0u9Mu79QSY2vunQJqWH1tiny0FMIorc6juKTA?=
 =?us-ascii?Q?UZeviKRe+PVeQaSESVW9ZyGFg6FHmzPgulDdmlTmZoXnKtnu2C+waNzCkzgu?=
 =?us-ascii?Q?VLMgsRl9OpdebqNSA8S1G2+oOdNBrogoyOohiZaz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4039c6ee-d6f1-4928-f4b7-08ddd7754e9f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 18:48:18.7456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tboH/DSaZgoDBilOniyBxc/7FfOhdnXMhk4VuhkDQ72knpbqWlQhhNhDX3IVF9WBLqjwMfUiwdUO3PxHAcU9PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310

Updating "ppos" on error conditions does not make much sense. The pattern
is to return the error code directly without modifying the position, or
modify the position on success and return the number of bytes written.

Since on success, the return value of apply is 0, there is no point in
modifying ppos either. Fix it by removing all this and just returning
error code or number of bytes written on success.

Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/debug.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 3f06ab84d53f..dbe2aee8628c 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -345,8 +345,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
 	struct rq *rq = cpu_rq(cpu);
 	u64 runtime, period;
+	int retval = 0;
 	size_t err;
-	int retval;
 	u64 value;
 
 	err = kstrtoull_from_user(ubuf, cnt, 10, &value);
@@ -382,8 +382,6 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 		}
 
 		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
-		if (retval)
-			cnt = retval;
 
 		if (!runtime)
 			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
@@ -391,6 +389,9 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 
 		if (rq->cfs.h_nr_queued)
 			dl_server_start(&rq->fair_server);
+
+		if (retval < 0)
+			return retval;
 	}
 
 	*ppos += cnt;
-- 
2.34.1


