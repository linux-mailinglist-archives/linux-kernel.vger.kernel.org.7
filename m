Return-Path: <linux-kernel+bounces-754935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0351B19ED4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86BA93B395B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D508523E34C;
	Mon,  4 Aug 2025 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="V4xxCeBu"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013034.outbound.protection.outlook.com [40.107.159.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD49C54F81;
	Mon,  4 Aug 2025 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300140; cv=fail; b=TFeA5XiGCXDGC4mzUSp5VaZBDmHM7+x+BJBpF97Stpdb6e1qLhKvWw0vPz8IuPi3fEJYjcECxooMdSX+cL8N76zJJEzLsIwMkjRnYFE37fzifKAhurYnBXTkIDNaKRHYd233gXMxl/QgJhJRL6nH93EvOwjQvBYTfkid2KM5Ou8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300140; c=relaxed/simple;
	bh=qHib/V4ZaomGenPF7QD619TF85qczWNpYHcdFzyXVv0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DrcZj1LvA0HaQMi8ZnB3ivrpM7s5VESSMmzN5dnCokhCY9tuRRe8bi92W8O0Qa2xzMl8UC0KJI4W4Pkj2uomquQFHZ0vPtKcINYyRdKEyfDVqCVlC9XuVFGJtad8Di7ki8RzQ/RwOWAfo2Fe6tnpjkpQlazb7312XY8K7bOECdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=V4xxCeBu; arc=fail smtp.client-ip=40.107.159.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gui4LAuMGQ2rXVShpSC4uwW19EQ0N0AeqQtoxOJsamF8Zl8u/odX5TXRD/4GkcWdU6g+05ksCOwopvw4WZPw7q2xSyBHxlNSn2E0fAunltWDRDii0FBxdbpVVZRx8ZPSVndX8hGwAHLYgAz9TYzkDRUuuYGHvPiwFo2DdVPNA57dOa/Foa/AQHtW3L12Q2Jby243eWRdOJGegSMwbywIhSZG2R7zZV2u+Uhf3ExsTfX6IUMldWD7dUhymjzwHz9FxKNcGt57/AKeg1GvEGgwXqTD4lwzYyY1t1AxKY6qHgq0zo0O8Io+f3BMcwB4awSYq/siN6Mo9jx2/kDEOYjJuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0JGvleOM312BgQGXo2FvG9UMNxzT7Cjy+NS1D2uYjI=;
 b=duZ5f5WL+SjqIJqUqTMSx5pvYCgNguuuud3fx/ZyhaURG35lEDO9SjceqAphygrwYJtxSMgvhAAjnnhAC9lGK12gokt1pxV6OZGVFmKMNXhe2xUL+vFlI9xawYbe4QCKSTWdUGtIWw1GsXmRampM6TBODeM/f4xv0mrQ1bm9lsw28sEcX9h6yuYSME74VU+4bg+wXeeZpEqg4QOPNCq1wjn8Ois5pNysxwgQHxVrGDcYErWlAhPAdL/zuT6J0YaJJDrWAGpkYapdLPMyvsKUo2fJw7Yfo+k6wENy6XooeBlCkDA+9sTpHBQIxcHY0QQilqGTWoGRL7l6IFr4FEhcGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0JGvleOM312BgQGXo2FvG9UMNxzT7Cjy+NS1D2uYjI=;
 b=V4xxCeBuQb5IgLkriugxX0/8nfdgNvKjcNuTtno6LZ/SFZcp96Ta4K3gI7v2Su9hOhyhxzLXkVvOsmO5xdH/hBGlCMpKeMEmmhvJODc2utumlOg7So8CNppf1eUNeCyPM9GOdiwGObOTHVI5FuACrAJoYTLLK4LzoYRlX3rUN1BotMv1pxiXjZNFUP2QrWp7xWEkm1JZ8h1QfkfmOTqoDzxgzhIjCZ78E+EovepUGeJnQPATVZ3/xFK1P6roiaQrV68JeYsD6xnz68smXMEQMHh5vTn5DVUpjF1v1Jydti8NcFycxbJpPlBKVUOIw5FCn33otrxv57RgCfF8zK3UjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAXPR07MB8771.eurprd07.prod.outlook.com (2603:10a6:102:246::20)
 by AMBPR07MB10617.eurprd07.prod.outlook.com (2603:10a6:20b:6a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.15; Mon, 4 Aug
 2025 09:35:36 +0000
Received: from PAXPR07MB8771.eurprd07.prod.outlook.com
 ([fe80::e125:c4ef:b872:5c60]) by PAXPR07MB8771.eurprd07.prod.outlook.com
 ([fe80::e125:c4ef:b872:5c60%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 09:35:36 +0000
From: Wladislav Wiebe <wladislav.wiebe@nokia.com>
To: tglx@linutronix.de,
	corbet@lwn.net,
	jirislaby@kernel.org
Cc: akpm@linux-foundation.org,
	paulmck@kernel.org,
	rostedt@goodmis.org,
	Neeraj.Upadhyay@amd.com,
	david@redhat.com,
	bp@alien8.de,
	arnd@arndb.de,
	fvdl@google.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wladislav.wiebe@nokia.com,
	peterz@infradead.org
Subject: [PATCH v5] genirq: add support for warning on long-running IRQ handlers
Date: Mon,  4 Aug 2025 11:35:25 +0200
Message-ID: <20250804093525.851-1-wladislav.wiebe@nokia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::19) To PAXPR07MB8771.eurprd07.prod.outlook.com
 (2603:10a6:102:246::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR07MB8771:EE_|AMBPR07MB10617:EE_
X-MS-Office365-Filtering-Correlation-Id: 49143ba3-58f9-47bf-1728-08ddd33a4401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?81OcTXM62PU2nTdEtDr4xKORht+UCqypmLK+4s6IvPjJ1ZFzQP5yJdduJOEs?=
 =?us-ascii?Q?gjkJ+FQxXj0yMjdy1Y/I+OM+232iKqfqzsy8alggg+Iror3UwiP3NcRI64Or?=
 =?us-ascii?Q?+EydNElp2dURhR9yPPVxK0XBay1RUN/EZbZEWf5px0XJ3OP3x4vC42zRfUXv?=
 =?us-ascii?Q?vx5jdqDPZzf/Db3imbYUEi74O5tmvkmv6Do4lwYCkGDeV/ykrBEwtfSqddIv?=
 =?us-ascii?Q?7QY7fMddmKUWiwP/Ir7J3S7bWEofbdxcvlgZUCn2h3XuL86aPkkMl503/ukp?=
 =?us-ascii?Q?3b+7GbNiDWqRCXOEjDtJhrpc1Eau3+9V6lWc2nxeoCzeKGWtF8wAXvwoLeuU?=
 =?us-ascii?Q?zg85K/wYVyQTsqPC2cjl0D/an8KPECjoZLJtYh/oic06dgqESHe73qfYb5g6?=
 =?us-ascii?Q?0PTFh3+g5H7eKwqpBxkj+q5BlWZo0s5lvc5T5PCuAErt7HpUoxKmQaiwM7E/?=
 =?us-ascii?Q?dCbDYH/1WdnBqCwDKd/0LEHOto++mCAi/JJwUF4M5r59mjWHhob2RI73gL2I?=
 =?us-ascii?Q?tVsx2qWAVZP3CrU1dnOrwFqS9YDgUQtv5U04JTdfgFCMd9bgDiZ0dW/50vS7?=
 =?us-ascii?Q?f2rOhfkPS2FnUvvTzU+TmG4uiSRMafNKFi1uifRVRWDSfDZMs1QTYhq/j47s?=
 =?us-ascii?Q?WxE63HsLuaRj+s7JgdYJRIi9DQYYVFIEyMj1DP9YCmjPRsYWNjA0Q0ljAQNR?=
 =?us-ascii?Q?lsIU6VffUkIUMnDa5LFpop9vvqawbfituuXoNqAMKyNXqKX7Mr4AM3t84z4H?=
 =?us-ascii?Q?NZAr49F4nVQ99UmtUK2o0mEkkG+mqVji1R+1jk8/oOqr2450cPYrNMPZaQKE?=
 =?us-ascii?Q?uRffiF3w5kkWMJS8Czczqums86qD2LRz9rhjpMP+Mw6jr2xS83yj9VwKaFtg?=
 =?us-ascii?Q?13zavafgs6TLOaw5ObsPy9++Oq44c4PNtcxn7a0rLm1BfQqX4Ypit6kjmT40?=
 =?us-ascii?Q?b33DSOdrXU8ItIER5Tp/wNvMut1bs/1ESn35H7zYzCDPpfaoV5D4HPKHXY2t?=
 =?us-ascii?Q?ZxApkFiSM3421NIup0rfXNa6cIJEpxnZxUwhfMu1HzBzT92L03LivUezRFiM?=
 =?us-ascii?Q?kQJdtdlcU9YaOA8n6UVWAxzhBV8dvZE3PKnHAIUWXvBav8oXdIj0mxhhrX3l?=
 =?us-ascii?Q?B7QVU6AiF+E0O1uRCXcJyU0SMtYkwy477KThtUvw21J6+s1zXuMfWrwE54so?=
 =?us-ascii?Q?rtdZzMEvfkRs4zz38dG7yB4Jc48oSah0KVb9K6IyCNNWZ9wWFc7X+GuleIaL?=
 =?us-ascii?Q?Uu5s5dy4Et+hDliBPyQzE09Ug8E1f1R08k695YuTrJ4cYQi+7ECGa8K1srT5?=
 =?us-ascii?Q?uzA3myAJWQagijD2sUxE7XFPJbpPVV8z00as7BWl4OwvUAZO3FdRTxoDpqtQ?=
 =?us-ascii?Q?SwSxnj89O9uddBBNS+0/okKOd8Lm6HP2KgfGDF0cpTWufjYFOI9yzk6Kv0h0?=
 =?us-ascii?Q?WsUa3LF9i/vauVgm28plPMjkXtIMgKnt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB8771.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RLFZ1sm54tFUbgIf1Bn8CleLzrZ8SlSJli6z23B1gpVzgUU/nVmLdWL1MY9a?=
 =?us-ascii?Q?WAZ0PVOtIySInTHjOuQgPaVNJBI5CXF0zy6WgjOK3tfAZBLez812rRtLe5ny?=
 =?us-ascii?Q?ItbSdsRthqtJGuiyoc2oWAQZzIdgsXhOEw18IbPzVluRN+zlvTRJVxjI3ATL?=
 =?us-ascii?Q?31Frol4wLSVEzfU2jrBRseZ787LSmOvmnmeDHKQBiZiMMCjh57H/QHQ/9mL5?=
 =?us-ascii?Q?SpgbVRTtBSXuhb/ZYDFS1PPqtts+gMKPV95JK6AQUE7ns6LwmLJYrkuSzwrt?=
 =?us-ascii?Q?D0z0jSlAxLx6tyz4X67urUaorytTeQToZy/AyvOn41FsJHvPn9phcUpa+Aoy?=
 =?us-ascii?Q?Z7KxPxs3MuuofwyXOPW9OGSAj1/xbV0SczjT0qcQaan1LWj4SjgJoiiNDXsi?=
 =?us-ascii?Q?ARiHawyhdkW20XXuEkTvXdrDUOQCUj9J/UmWKmdH1ymx2xhVuvaRFad6ImdL?=
 =?us-ascii?Q?6Ryr01wbnUuHIAR04ACR+H44HRc+hEoLofoYEORmyeJHd42xFbz77HBHwInZ?=
 =?us-ascii?Q?IIjeuOiausuLyjTW4ue0bmzaiXBMfn80fv/ZCaOK6LUwWwppwjzKHcuZZM1r?=
 =?us-ascii?Q?osp21Trv7oGMHNjv71zN3hvtU6Ta2OTYTkFpQWHg2/fEY6jkt3Bz8/iDUboQ?=
 =?us-ascii?Q?qh7OTp8H/2mxuOzZuk7EsjjoQukI5BeRT9LGhKK1/I4qrBrLe0oQ9C8U+o2i?=
 =?us-ascii?Q?tTQ+2OutPJQiz2GnS/xVhhHUcrRI+YW+JfrzXTQGXq+lNFGFva7OYyCNz3H/?=
 =?us-ascii?Q?1UyJNp+nJJon6r5m773ZCZajwsxBei5GZwNzXxu2wjAGJWma20LCgvhA/O1L?=
 =?us-ascii?Q?pQBK7kpmo2GdAqNpTwI82+j/Q+xMFVOzgYDxTYBD+PhXWj22eVqELjPmn+g7?=
 =?us-ascii?Q?DcZmyD/AH+fSqkLJEDufksmhwGpOZUdV0535d4oKGPJLBKJ/9IS+J/JkR8Zj?=
 =?us-ascii?Q?F8xCFqNtXkMXrGtuRBDKoUKK8wAWJ7oMG3cmGyXnRKiVXLq9UsJkYDEpGh44?=
 =?us-ascii?Q?AXhk0tal35DOs0xML2zdNExOR4Lrb7iLMDSIPc/8TmTp6BS5klLxyq7u0rSO?=
 =?us-ascii?Q?nPgkrrXc/JQSfpuhYCtxNlNJiHX5k4mHRLyh8RV28YbMmLJ1a1dYHxpDij7/?=
 =?us-ascii?Q?LkRpT7EZHYRTSL0OgUxDQSgZcaZP2kBwv8naV3sAMo9vKwuGa5wocU9T6gCQ?=
 =?us-ascii?Q?p8hJ3IB9ANvBeFV6ms/nvE2vHQq6t0AJlFGBFH3qvEW9qIIAAFuWzxO7a3U2?=
 =?us-ascii?Q?aLSCDk7UqlxhcNkjnTEvSyQMQPqpFoE3FEMoQbziGP/4kdEEnMR/uK+1LsI/?=
 =?us-ascii?Q?smI1T/SYc6eHSw281XoGoRMUmUUNVJXAt9wLVGXv6jGhi2CXiCVsjoFlxPYS?=
 =?us-ascii?Q?ZpPwJK2B3DaSzZv+dDWED1zNoEqbx4Bgml5T2P8B5AXfwe5AjoTM4Sz8hyYZ?=
 =?us-ascii?Q?96MaVJDvPXbR4LHjX7gXEv8G7JKQFshaPFy4vqNG/K0YxKFWw2qdUJsuAngD?=
 =?us-ascii?Q?LwKCELEBN536Ct5sn6R1RKtAnW5MKX/sJonTlQ1NOnIzVpEqwGN8fS39pZmx?=
 =?us-ascii?Q?TenTaBUlPkUy+9vIPE7cD2sSNSaoLdZBFdC7fciAvIHFiB8gprN77JNLUYYC?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49143ba3-58f9-47bf-1728-08ddd33a4401
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB8771.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 09:35:36.0678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eipT04+Bzal2+tJRI9pqD/65+qgJOiMERNW3/T124w2mt2Lsu1MufwMZPOH+DaKfA8NxR8oqkt7Tb7qhDDEpOnSmYZefEuZAQ0JTIE1f+c0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB10617

Introduce a mechanism to detect and warn about prolonged IRQ handlers.
With a new command-line parameter (irqhandler.duration_warn_us=),
users can configure the duration threshold in microseconds when a warning
in such format should be emitted:

"[CPU14] long duration of IRQ[159:bad_irq_handler [long_irq]], took: 1330 us"

The implementation uses local_clock() to measure the execution duration of the
generic IRQ per-CPU event handler.

Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
---
V4 -> V5: be more precise in duration print resolution, use div_u64 instead of bit shift
	  for printing the IRQ duration:
	  https://lore.kernel.org/lkml/20250724155059.2992-1-wladislav.wiebe@nokia.com/
V3 -> V4: convert us to ns in setup path to avoid shift operation in compare path
	  based on V3 review:
	  https://lore.kernel.org/lkml/20250723182836.1177-1-wladislav.wiebe@nokia.com/
V2 -> V3: Addressed review comments based on v2:
	  https://lore.kernel.org/lkml/20250714084209.918-1-wladislav.wiebe@nokia.com/
	  - refactor commit message
	  - switch from early_param() to __setup()
	  - comment on approximation of nano to microseconds conversion
	  - move ts_start to if() branch
	  - align pr_warn arguments
	  - surround else block with brackets as well
	  - invert the condition and drop the "else {}" in cmdline arg. check
	  - make struct irqaction *action function param. const
	    in irqhandler_duration_check()
	  - print smp_processor_id() return as unsigned int
	  - fix warning text "on IRQ[...]" -> "of IRQ[...]"
V1 -> V2: refactor to use local_clock() instead of jiffies and replace
	  Kconfig knobs by a new command-line parameter.
V1 link:  https://lore.kernel.org/lkml/20250630124721.18232-1-wladislav.wiebe@nokia.com/

 .../admin-guide/kernel-parameters.txt         |  5 ++
 kernel/irq/handle.c                           | 49 ++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e4b7015718bb..441943dfd0f3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2259,6 +2259,11 @@
 			for it. Intended to get systems with badly broken
 			firmware running.
 
+	irqhandler.duration_warn_us= [KNL]
+			Warn if an IRQ handler exceeds the specified duration
+			threshold in microseconds. Useful for identifying
+			long-running IRQs in the system.
+
 	irqpoll		[HW]
 			When an interrupt is not handled search all handlers
 			for it. Also check all handlers each timer
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 088e5c01075c..b2b0600aa5ba 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -141,6 +141,44 @@ void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action)
 	wake_up_process(action->thread);
 }
 
+static DEFINE_STATIC_KEY_FALSE(irqhandler_duration_check_enabled);
+static u64 irqhandler_duration_threshold_ns __ro_after_init;
+
+static int __init irqhandler_duration_check_setup(char *arg)
+{
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(arg, 0, &val);
+	if (ret) {
+		pr_err("Unable to parse irqhandler.duration_warn_us setting: ret=%d\n", ret);
+		return 0;
+	}
+
+	if (!val) {
+		pr_err("Invalid irqhandler.duration_warn_us setting, must be > 0\n");
+		return 0;
+	}
+
+	irqhandler_duration_threshold_ns = val * 1000;
+	static_branch_enable(&irqhandler_duration_check_enabled);
+
+	return 1;
+}
+__setup("irqhandler.duration_warn_us=", irqhandler_duration_check_setup);
+
+static inline void irqhandler_duration_check(u64 ts_start, unsigned int irq,
+					     const struct irqaction *action)
+{
+	u64 delta_ns = local_clock() - ts_start;
+
+	if (unlikely(delta_ns > irqhandler_duration_threshold_ns)) {
+		pr_warn_ratelimited("[CPU%u] long duration of IRQ[%u:%ps], took: %llu us\n",
+				    smp_processor_id(), irq, action->handler,
+				    div_u64(delta_ns, NSEC_PER_USEC));
+	}
+}
+
 irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc)
 {
 	irqreturn_t retval = IRQ_NONE;
@@ -160,7 +198,16 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc)
 			lockdep_hardirq_threaded();
 
 		trace_irq_handler_entry(irq, action);
-		res = action->handler(irq, action->dev_id);
+
+		if (static_branch_unlikely(&irqhandler_duration_check_enabled)) {
+			u64 ts_start = local_clock();
+
+			res = action->handler(irq, action->dev_id);
+			irqhandler_duration_check(ts_start, irq, action);
+		} else {
+			res = action->handler(irq, action->dev_id);
+		}
+
 		trace_irq_handler_exit(irq, action, res);
 
 		if (WARN_ONCE(!irqs_disabled(),"irq %u handler %pS enabled interrupts\n",
-- 
2.39.3.dirty


