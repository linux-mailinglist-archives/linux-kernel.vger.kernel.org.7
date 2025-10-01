Return-Path: <linux-kernel+bounces-838910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 065A1BB067D
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8762319420FB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1D91E834E;
	Wed,  1 Oct 2025 13:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="cOhzuY9W"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013011.outbound.protection.outlook.com [40.107.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836E24501A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759323826; cv=fail; b=WSkk1g+PI0u3ECrewAnxz5LIkBUfxyFeJDs4jFDJn8uXPTid3vFBNNKLyhtmD+6MqCbvzT5fJQWm+Nylel/706v5yxssVLD1mEav9qkSy3Rn0NWuj+he/N1nuu9HXCe8AgU3Ph9k8AZEg7angnyK8UbqtFWph0VIRIppAEsYZfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759323826; c=relaxed/simple;
	bh=zkKZL4GhFJvDICJxAavg4OwqG/FNyToxprS1sA/IzJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MV+HHFVS/sNgpMKOiv1IKwwzL5xrnoHcLOhhttIFbEM5/Y01c0r1+McBHQIyeYuERL6QyUqTauUNyQDjesYxru3RmhtwtnF/k+UJoqfH/aIwu3kIas40WpZLO+10ugB3Aa+UVrSkkL01zkXDW1ND5Z0x5Cvr46M0i5eldIgFq14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=cOhzuY9W; arc=fail smtp.client-ip=40.107.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcBhjXjJPoFTesYmwKj5CYsCQIdFbi/6HnoIA/nMwNTieNoq6+qNQl4isrvKG5MGqxrOD3xhpboLNMclSZJ76kDweBZML31FvqIWL/sAMya0VCYQWIRNumGb3h5VP9/edufgcI4UIHiKIMpUVIY3Qv4g9ZPqIYEDoTWZakNyZO2K3eh8q4B8+2Pqhbgw+Q0WbEAHjBDVMwHlmbDJybmQyQGPJrZCP93rwtFtYMujl9tDfrTLa5/R1ZqRaHV0zpyakhoKOGLrqANm8Fw2k7+jdE2DmMfqRsYdqBX9H0VBlozHXWW5rETmH2HAsVK/lF5U1FZIVXZf5ckfl3TDCG5vyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4WJNFyWNnSYj8m/WtY241r5BtjUJTY0dNMn6gWIMmU=;
 b=cid06Yrl7jNUtNKdrgEj2vm/wABCp4xy3UnUOiPkf7nGIn5/0KfKPY4uEkTvZxSx1NSy9pDZjlg3Xaq6tabrT6aayD4FhzSRrhlWF42xCVL8jcy38q8KQDXnV+O+/gpu4w/vHo5T9tP5ls1Bp7ALtGFu5BNmiJ8JE+o70Jt4TftcP7fcjNrtZm+VlHBABS9TZLlAvaQRdENcfegdnhX8zZlipydqnWJI6A9s97aSag9XxcaMnYkNFfk0SSdx0SNvKHRgyHoLUgOYWzr7SM4C5m8Xe6IvYey6ZgTcOiau4M5CR6OZ1ZrHxJ90ToczzXY+nSOBPA8+tAuqE4fI39KspA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4WJNFyWNnSYj8m/WtY241r5BtjUJTY0dNMn6gWIMmU=;
 b=cOhzuY9Wpd0LoGFsKqvmqoy7Fj6+ON3XWvhTPRPI+LzpidUGnG0hnoN8AhG9sICwvOfRzheEbaUPVBDARvUGwR58gKcYZKfAM6tZPV0uCeh+wCyhOFhysT+N0Q5DPYwQCKLKvEQ9nfHEzuVUgf9Mx+Pf1VJDUW3OcApugb2fIzyGDroTVkofpc+sBpxfuGiiJetstTAyIPLkauHCsI0F2UIEuXF4nrLGK/Ho654pPJJWxOt03pl7UQG1pcHpe+xUZTCJSI3vfjyvAwGto/VXSOInoSDcB0SYQ6oYcvFpyX20SSpfRy/o3q8NwgwSSTDykudMCsMb2n2zHhSM2fgelQ==
Received: from SJ0PR05CA0179.namprd05.prod.outlook.com (2603:10b6:a03:339::34)
 by SJ2PR22MB5071.namprd22.prod.outlook.com (2603:10b6:a03:58a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 13:03:41 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::b9) by SJ0PR05CA0179.outlook.office365.com
 (2603:10b6:a03:339::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.13 via Frontend Transport; Wed,
 1 Oct 2025 13:03:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay2.compute.ge-healthcare.net;
Received: from atlrelay2.compute.ge-healthcare.net (165.85.157.49) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 1 Oct 2025 13:03:40 +0000
Received: from zeus (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with SMTP id 1CA44D9C00;
	Wed,  1 Oct 2025 16:03:38 +0300 (EEST)
Date: Wed, 1 Oct 2025 16:03:37 +0300
From: Ian Ray <ian.ray@gehealthcare.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Support Opensource <support.opensource@diasemi.com>,
	Lee Jones <lee@kernel.org>, Axel Lin <axel.lin@ingics.com>,
	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
	linux-kernel@vger.kernel.org, ian.ray@gehealthcare.com
Subject: Re: [PATCH v2] mfd: da9052-spi: change read-mask to write-mask
Message-ID: <aN0mqU75onKEYSDg@zeus>
References: <20240925-da9052-v2-1-f243e4505b07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925-da9052-v2-1-f243e4505b07@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|SJ2PR22MB5071:EE_
X-MS-Office365-Filtering-Correlation-Id: 721fc90d-fcfa-401a-28c0-08de00eaf18a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?empN+Z93rTbAIni28m6VR0xNEjYkQGZP5kOh2ttxPUJCb7gGEtKuxTWqKL2K?=
 =?us-ascii?Q?ZXyNCa4YfiUi15/w72MOYzPP3pQ/tloY4jT0RJ0ig9fob1IyAvPsu0neTnL+?=
 =?us-ascii?Q?p6Fe2sdgIDoVn5RMRKyC8iBEF3bVwRfaXzx1G+usjD9lbOibuKWC8TDe8YsD?=
 =?us-ascii?Q?sbEF5vQQju+hxHC2zkBdyS7lAZ/WwFUjK511NAjgV9EgTazpUqFjj76RKVTN?=
 =?us-ascii?Q?uONsnRR1M29dlVYPFcmKk4KhOmZBnLXXk7eEhWFRGiNVjA8x8jVceQ7WSrCY?=
 =?us-ascii?Q?C/a8XXSa+sQtG6sU0c1ADyFoDOXW7U/utpAyAbqgZKZ4fmS8r3W5HxdwP53Z?=
 =?us-ascii?Q?rIwKxZGkpHxaMgpgssS/PzrJn855a+gwzruOcGIBjP8+qW0TON8CtUQMwu9G?=
 =?us-ascii?Q?v/d2Yun0Fr7Rx115+JnZv4jxOAjPQ0RaPXVBjfvTAu+l1KAP6kl2ylOq6SwH?=
 =?us-ascii?Q?ZgTYVI5xZwW9R8ffY6tX+4xDOTrP/0qBzIyf7vMVXyWIMEF9vqKUi24kVZ2C?=
 =?us-ascii?Q?vkmajjvamboCtoXpYm1bltQf0igNx61Y8wA+3ynaLt54MgMuM4pBCtt6Yjhi?=
 =?us-ascii?Q?N3HRxVVxZN6PO30g18Z/yL1W3c9lsujIWOq7xtcE81Fsx68yT5+FzbbPv7+Y?=
 =?us-ascii?Q?sYULTOpo/o+iGm+/l9//nr4EpOFXagaiH5SG+Ey8mbSJeHSUw3d+FkLnYjuT?=
 =?us-ascii?Q?lQ5sojb6jDSAa7U5XBMetvESQyTg4dXhH514xJgPaKo8llJTzDDwAKAkJF1V?=
 =?us-ascii?Q?Uh1yhWgbwmX9rptkiL1CpzKAbjo1KGtHc2PLI5hfLHQp6fljOMFnVibnKq0Y?=
 =?us-ascii?Q?/hYyd9zxuTrlA6YRxIZXdi/XflMsMwKVRmmR5xHI6gOqSG+NggP8xk5AAjI7?=
 =?us-ascii?Q?mrIPTi5x+bKU3sN7GqAJe0V/Epcq3G7QHdlDyZeZt2k7Cs/wg0C4HQ41k1U4?=
 =?us-ascii?Q?1MTtgviUdZedmNjY4Sk4RT4vmwuQ7E6WO1710nRtAis1wGOQP10pdL30k1ny?=
 =?us-ascii?Q?vbo+bXthD7gQ0yJDJz8p8sEuzeGUDaVWzrqmaynRvjkSipTfx9k/2S2gCjLh?=
 =?us-ascii?Q?Dg2GfZYEMLn/5x7BEdEf8f8T3EsPoPTe58wY7LVi7VF2/evLHRuZM38CS+Pj?=
 =?us-ascii?Q?5DtpNEF5DQ1A99TvGFu3Zg9412w0QCwPE6bAFLTSPJihtybY85yGLZgJkF/0?=
 =?us-ascii?Q?SokBiUycFwOlVaBytvrQoGJ9fIwfw3j7YGBkDIvP9g05A2FdJ4u2hA6bzaLf?=
 =?us-ascii?Q?dO5zYgzXU6AhqjN61ezjUXYb0QTkLaNyshku8ZGh8pU+2ddTrmxhpJgJk2Qq?=
 =?us-ascii?Q?gkpNAEIy4W0L8TjtVoL4Ao2acAmCuOiX+9cuPmG9J9LkzZli+CQDggc9d0zZ?=
 =?us-ascii?Q?TnErbujBQCVveDecCjXIvfFwIjy9a69lzNvep8dDf7FS5x0UkLATHrlZnQsx?=
 =?us-ascii?Q?6uReZYr05GHqRrdvSR3YJf7dPHaqtBw4AApMxLvINtBwJyO7Clem+Z707sCD?=
 =?us-ascii?Q?bE3r7lbQV3BZcTiCIk8JaWwo6AE4QW0uEbwf4074KQjI2HyG51bxzMv/OBV4?=
 =?us-ascii?Q?EbMe2Po+PfwmqfS1Sm4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:atlrelay2.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 13:03:40.5235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 721fc90d-fcfa-401a-28c0-08de00eaf18a
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[atlrelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR22MB5071

Hello Marcus,

On Wed, Sep 25, 2024 at 12:19:53PM +0200, Marcus Folkesson wrote:
> Driver has mixed up the R/W bit.
> The LSB bit is set on write rather than read.
> Change it to avoid nasty things to happen.
> 
> Fixes: e9e9d3973594 ("mfd: da9052: Avoid setting read_flag_mask for da9052-i2c driver")
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Your patch breaks DA9053 SPI communication (for me, at least) on the
6.1.y branch (I have not tested on master).

The datasheets [1] and [2] both refer to R/Wn in the SPI signalling.

What led to the assertion that "The LSB bit is set on write rather
than read."?

In the original code "config.read_flag_mask = 1;", is OR'd into the
buffer in regmap_set_work_buf_flag_mask.  This sets the "R" bit as
expected.

[1] DA9052 CFR0011-120-00 Rev 5, Revision 2.5, 13-Feb-2017, page 67.
[2] DA9053 DA9053-00-IDS2n_131017, page 54.

Blue skies,
Ian

