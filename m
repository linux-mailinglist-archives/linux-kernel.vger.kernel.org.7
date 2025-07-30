Return-Path: <linux-kernel+bounces-750076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F57B15703
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D62918A4C9D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E05818DB2A;
	Wed, 30 Jul 2025 01:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="p9sU+UOs"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A11717BA5
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753839576; cv=fail; b=uVzNNKKxxJuP0J6+7l1mX6xILg8RwJd0fYmPFF9ws4CeSXx2vGavDE+yUlHAg1AeMQeYQOlJcTG/fXG5nxWDwkUyMj2wqBB1/GdUgzrCKw/+v4A3/P2l7SoHtMN8yhz6g4I+7zJnPvePab/nce/vJA7+haQGr9T1BrO/l2jhQz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753839576; c=relaxed/simple;
	bh=tCE/XBjTbE4Tw9J30g6UqZ9z4FbGGSMcYwGTurTzMFQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gMcB/qQBN/HDLt9N13m0zyUoZa7XutHhU1wDygu/XXb+omrZ2dNTRPs6WGetdqjE+bF39vqsSGQxWgYDnM+7f6LRojVFbvHV6olZyoH0yJEnEKKjlwHUveTOqwITmmtq7JQ/xz47l/5ovavI/QoU+ILNzS31aTVo36/TheNmR6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=p9sU+UOs; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dn9WX/ct4kh04ZVkLuR7l3jB4tL0lJLjoyT0cusiPh9H9ibQXD8M23Uerxhv1Q0ymHKrHX72VIyiTF5kEniq6qcJ0nSAA5M4z26A2vhIzkkyxL7WnqNXbJ255Y+0CIjlAdxdU/ngsN5scD4Z8hwdoWn1ICOvF71H1T32F+312iIWbBUTGQcBbGSCe26voCPfMnkp5e8FtrB2wRxWXikjaEcYpuuIwtDjJ18XLP5q5uLqRWT03SQY1q3+f2b0GqfuhZsuasX2P3WS5gi5+cxuIQBC9jhKlXlwKpWW799mAMmFeaFpYhg3SrB+JRK46ZumgAaOgl1jyDtsniZRpoO0Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1G4Obh/d3GJ46WHJ5jkZ/lYRA5OJAJ0QRbC7ftnOGVw=;
 b=RATLnxcDurOtCyaQIvUpW3E22d+sFuaxdUV4xXyruTwVrG/Z5zg99f88+p4OtJC3tp+SEVPJswbrHtFPrinUij6lzjfAXyvRFQyD+t63FxwCjRdK/O4yDssX4VzUtYRuQUU++oWTyR+QjAFWjrM/z/D7d48G9t6nWZi62HlCVa4EBiNIeQbdSN9pI1d/j2LMFetg+RCnu8eheikJ0cQVbC7D7LAjo7RI47KEmA5xbh0urGZb46f/Er2DPAJPcqpzoix9C6Fz8ogP3U79w8HkfPCQWd8svQTY8gTgkEGQvGEwg7YQJm/5vrFPN/kbRO7HmNdU6AcBhTII8S8Ej6NCBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1G4Obh/d3GJ46WHJ5jkZ/lYRA5OJAJ0QRbC7ftnOGVw=;
 b=p9sU+UOsc6ez3dzxGhpjebFzOEp+WeaA+67yEIODkSYYrO0GazT2tDiPFthrtFKgzCyGdrRDgFKD8lZudB/OdqVbmK2EPC6wAqnEy/h8JScp4yf1OIjDLsP19cR8ISgV793M+eBFlFwBvDEOfHTYI3R48fHtnAfm6QeCLRneuEsX8D0DqiXJuFc8otdVCIIPVXW34DqJli+0EDTpnI8cORyM+jtw/K0llcD7Hm6LbVIp5DWCApCh0ztHvqpiC+YIrgd+yd4ki5pA/p0ux6augfzD3zXw/5eSP/13Uk2OnRsp+40nOp7/4pV1vTkvgII13iEmVoAJXzKZqCJKrr400A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by MN2PR03MB4925.namprd03.prod.outlook.com (2603:10b6:208:1a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 01:39:31 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%4]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 01:39:31 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org (open list:SPI NOR SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v3 1/1] mtd: spi-nor: core: Prevent oops during driver removal with active read or write operations
Date: Wed, 30 Jul 2025 09:39:18 +0800
Message-Id: <566fc1168db723672ab0bc6482ec7b72b4b8fe2b.1753839339.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1753839339.git.khairul.anuar.romli@altera.com>
References: <cover.1753839339.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:a03:505::26) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|MN2PR03MB4925:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a99b76f-f6c4-4ea6-39f5-08ddcf09edca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4p5T1WBv4QEUBJdjlVV3Nj3XscWXRKFx+dkh7LLVOlDl1C4MdXKzcGP2vkq5?=
 =?us-ascii?Q?Pz3S1godEt+gwe/xMgCFZrPee9r5Mib+o3A5QhOd82qfik5BEC17kQ89qbaj?=
 =?us-ascii?Q?4qxdoyh/amrvIQFM/7O1KQyvBkX6ASSnxL0zyBjA+zYDlTQD+7hnOoqpzlpM?=
 =?us-ascii?Q?pEjzyvcCOyFSZKiaJ1yDng3wSq1rm1vWsqtVQ/AQJbajnp58P2bfzyxAKbhm?=
 =?us-ascii?Q?/K9DyY2sLQuEWKaBJ3pQgKJEbT2EjcfHYMPPNWHJ+QauF6xE7VsK61INgddx?=
 =?us-ascii?Q?Kz+SiKwtLj3zncXxfRcLZGI66MJ9rMWIkn2qMkxNng7RncD8BZU7+J6QzqyG?=
 =?us-ascii?Q?DmzWVHfajpwkXNoe7w4ntoQkL3NQxR7Q/VNQWhi8gyaw0oXkVXZLCJimb102?=
 =?us-ascii?Q?qHkxUA56NR7vkTbBi+0DZ2ipTKKpG6y7eHHxLjQIS4ffsxlfiROCbwHQT4ir?=
 =?us-ascii?Q?NMJTXjwGwFWM6vSuvVn8S3nvm+iZuBy+UgunhF/7zHxDUxJ6KETa8YSjGgem?=
 =?us-ascii?Q?iOQ7RPec2qhlaVrcvG13GBSI1wEN3iae/im7uBc/AThfhlKVULf031ndbThv?=
 =?us-ascii?Q?FOgp69gdRKrRy+o74gTV4jVuaFNPLgum8vbHIynlemj8TuBTaB64vHWP6ySO?=
 =?us-ascii?Q?+gBJuPrndMGK0sjPM0t3v/WJJcGol7x06q3rdqxnemBEEx0cSoM7gl3qMMBl?=
 =?us-ascii?Q?QFirK0k9AJ36HYEUZTpwNCzzFtHH8HF3lt8xnSmJMthvmUDk25U9agY6IfZb?=
 =?us-ascii?Q?/rIg+Lk1SohR180hHkCbbkfWafG37zQ0GoNlGSUraaX6MGV3c+tN78FU8OuO?=
 =?us-ascii?Q?MsnJ7bckMxBQwuLVkklR+LubJN4wYb9hQTtMIke+9JUh+Un5REQTrrBqUmZZ?=
 =?us-ascii?Q?t0eq8HwUIUIh+0NKRyU41zC4RA5LABu2kapNMguBu0JjhwzDX0ajzKk7vkUT?=
 =?us-ascii?Q?fR7keeL37Qk9TpFVKJhKNyY1hGAlJd4Jh8CE5aK+N3KUdpgaYX+KJjpFaCkU?=
 =?us-ascii?Q?iihPNDU3yFU/wL9NDdApE7KXmisWhK+VWyb2bqrmE0M0kIcIhrWdav9WXfIu?=
 =?us-ascii?Q?xvyFdHP4sIwk/H7NHSg6sye0FjTaU90uA4LdjopBpyd0hKV5CVIdfA4KEzS3?=
 =?us-ascii?Q?SmZ1JCIXO9ISE26xXn7NUbiAX2U/SbnzNZdYCdnavFV1MrvW5BUwdfR3TiQ6?=
 =?us-ascii?Q?GYU+TOr0HHzWPX/cpHTPHgozYuAZumADypW1eMQXgtqt4bjKlg4nWQZdyI4+?=
 =?us-ascii?Q?gfd36QF7+41AfQ65Z+g0duvM7wmGAf5tHAa7XcOQoZ3a+8VQNe4EzWmjrPsV?=
 =?us-ascii?Q?mKlaG1c97jprNCstm/gcdFdgLbLEzfa9W+PoeAtXQZdFo+jKv92E48GF1xmM?=
 =?us-ascii?Q?0LMLp1WM6Q9FL6gvlXrTKsDy55tKE5YDkj4HAHnlg2F3AZ6ixKociX+HkSIZ?=
 =?us-ascii?Q?2vtlHGNm+tqBlkV2m+UhL9TfZg4qPJg4D6cvsm9WjkHK/Dvt9gCRhg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cW33vuo/PVWXjPO8+7hw5uzxSE1kqxRNxN79XhkzdikqaX2rc5QDAzQwJCUd?=
 =?us-ascii?Q?rta56kiJ+IAREPtVI1hbPM0A9had+5hNJMWYT6rXsCe5fyuxUeYNav4bmr+M?=
 =?us-ascii?Q?xC9iChcg0gSi98Tc+81S+UWOcNVzNOtjxXjtN2L8fbihkjFIhhdEy9no9lr7?=
 =?us-ascii?Q?yirSNtJQeZzVfMpOnG3vQy3OwVsQ/VnEU97IdmGt1/4fSJjfB+K9A2/mkFjo?=
 =?us-ascii?Q?8fB/9SAqpZFRMeCQ4GwMCFBMThwLgwyJDA0TeNPfMSaEvj4JUkBCY2JBB5PV?=
 =?us-ascii?Q?h33mMER8ldW5Etezdhr5hlrW1n/PHTCe54wC9h9B73fBwvpEL3glId+T/5Sr?=
 =?us-ascii?Q?SgztUVch64LqSqM9wICPuOjKf2ISbsiB3+TCqKtD1nILUCcgFc1RRlxJZNBN?=
 =?us-ascii?Q?F0BUYHTDhDPNCtn6k6WCspKzV7s7N7XjF0oUIsk+yxn8TgsIVQwSiNynLbr0?=
 =?us-ascii?Q?aWTUjUa2fOtyxxYzjnF96VnQWtMMBevS6YbC4KlNOrqRBIJXa88mpvyDRtvH?=
 =?us-ascii?Q?8JjVnfPpRW5pG/W8sT7R3d0UW45TL8Lu2Kw4NNrBiAsrj0yl79dEUb99XVSG?=
 =?us-ascii?Q?T4pz9D7KVhH96RaDWRVgxD5Pbh94btQTW2ZHZkzGLoH1WuB4FipONotVnUwK?=
 =?us-ascii?Q?pKneXJw07S64uqMmnxgkXiu7DKxYn7xoLELccfhJ720/qXo0dhUJUzP3OdBY?=
 =?us-ascii?Q?rAIc6qfhqukA17Py9jnZ/GgQWNTPmWGkQiuQnBIleZE5rcS545I45C0HJVHh?=
 =?us-ascii?Q?BuqCOin2vin2Esx/jNmxw2/ALvtxA32aetKe5harBAgGPLWtf5xJR0G3wNcs?=
 =?us-ascii?Q?ze0Twe6BrrLaCAqn9cT4hSGAyrnTlZ/JATsq7muVV5Mv1A9KxDW25r+BPwtP?=
 =?us-ascii?Q?LJM+/k2YaWNaR93VVw7DS736UBvnRDKtOUiwa9QK0zq6l6TwwgilkTJujkkn?=
 =?us-ascii?Q?LhAtjDvTJyFtaA++IQwRSmirqrcNe4qnD+yPG7KSmy45RW5FdnGMmXmPhkpT?=
 =?us-ascii?Q?Kx4rX8mIe0yESthIAH7ISYfT+vTuByrwKgU2WTa9Stxm3SksMZ83iQE240MA?=
 =?us-ascii?Q?cf68Bpkvdi02gqdhgcw3Fndt5bybf9ROxQLN+q7PIMAWKv+unZZSTpfnbLf0?=
 =?us-ascii?Q?LGFofDxGOH9D3nvqTmQblhM0fBSL+l+pFfyYc777A38JeBtnlPnCLwYs9asU?=
 =?us-ascii?Q?TKlsJf0/+Bbub7qMqDW0QR3iPByafMJ5WMfwJ3K8fofEjj1nJo1QWaXTSKmy?=
 =?us-ascii?Q?fywnSkTL5ScIYIKor9U0ib2qRuPDSjIVsxWr1tQ/5jKqaw56lTYzo7/YkJLk?=
 =?us-ascii?Q?U4/e/uXnseuXiQqICdy6e4BRPqqIwM16YKeUaPlXHXZAisxEtvyTa8Jd0FpA?=
 =?us-ascii?Q?eJfwljPKG+7/Su5sqq4ZRgUfmt+LE4ZA08Fgw6bGjFHlSPhqP6cPdYUTyiMz?=
 =?us-ascii?Q?6ji9QpkNKHRER8lud9UvKkNyK9G29cO/kuwLjKwTbTi2jl8M+HhbqL+KI4M+?=
 =?us-ascii?Q?2e3zdKDJ5YOhiwMLWzZq1E1KYeFeBu5In3/cZaNZjPMBz+n/EGlkyTyVmDJB?=
 =?us-ascii?Q?R0bFSRh+GMVKLUf8WWHuRvUcmIapRvj3dZg7Uiq/SpBgVk/YBfOtzwGvpB7d?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a99b76f-f6c4-4ea6-39f5-08ddcf09edca
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 01:39:31.3835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqA/Nn/eZSsFJ2jgZTSkft6KEiizn1I4PKQq3BidYqvHecvFD92h5hJWsi7mNyU4v7vxEFfYT0cqsnxw1s4kK+fRzUzMAM95Jmj0JW/WD4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4925

From: kromli <khairul.anuar.romli@altera.com>

Ensure that the pointer passed to module_put() in spi_nor_put_device() is
not NULL before use. This change adds a guard clause to return early,
preventing the kernel crash below when the cadence-qspi driver is removed
during a dd operation:

[  200.448732] Unable to handle kernel NULL pointer deref
erence at virtual address 0000000000000010
[  200.457576] Mem abort info:
[  200.460370]   ESR = 0x0000000096000004
[  200.464136]   EC = 0x25: DABT (current EL), IL = 32 bits
[  200.469527]   SET = 0, FnV = 0
[  200.472609]   EA = 0, S1PTW = 0
[  200.475904]   FSC = 0x04: level 0 translation fault
[  200.480786] Data abort info:
[  200.483659]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[  200.489141]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  200.494189]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  200.499500] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000185df8000
[  200.505932] [0000000000000010] pgd=0000000000000000, p4d=0000000000000000
[  200.512720] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[  200.518968] Modules linked in: 8021q garp mrp stp llc bluetooth ecdh_generic
ecc rfkill crct10dif_ce rtc_ds1307 at24 stratix10_soc soc64_hwmon gpio_altera of
_fpga_region fpga_region fpga_bridge uio_pdrv_genirq uio fuse drm backlight ipv6
[  200.540016] CPU: 0 UID: 0 PID: 372 Comm: dd Not tainted 6.12.19-altera-gb6b26
c4179a6 #1
[  200.547996] Hardware name: SoCFPGA Stratix 10 SoCDK (DT)
[  200.553292] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  200.560234] pc : spi_nor_put_device+0x30/0x60
[  200.564594] lr : __put_mtd_device+0x8c/0x120
[  200.568856] sp : ffff80008411bc20
[  200.572161] x29: ffff80008411bc20 x28: ffff000185e2c500 x27: 0000000000000000
[  200.579282] x26: 0000000000000000 x25: ffff000185e2cb00 x24: ffff000185e2cc88
[  200.586404] x23: ffff00018034c620 x22: 0000000000000001 x21: ffff00018873e080
[  200.593524] x20: 0000000000000000 x19: ffff00018873e080 x18: ffffffffffffffff
[  200.600645] x17: 0030393d524f4a41 x16: 4d0064746d3d4d45 x15: ffff000185757700
[  200.607767] x14: 0000000000000000 x13: ffff000180045010 x12: ffff0001857576c0
[  200.614888] x11: 000000000000003a x10: ffff000180045018 x9 : ffff000180045010
[  200.622009] x8 : ffff80008411bb70 x7 : 0000000000000000 x6 : ffff000181325048
[  200.629129] x5 : 00000000820001cf x4 : fffffdffc60095e0 x3 : 0000000000000000
[  200.636250] x2 : 0000000000000000 x1 : ffff00018873e080 x0 : 0000000000000000
[  200.643371] Call trace:
[  200.645811]  spi_nor_put_device+0x30/0x60
[  200.649816]  __put_mtd_device+0x8c/0x120
[  200.653731]  put_mtd_device+0x30/0x48
[  200.657387]  mtdchar_close+0x30/0x78
[  200.660958]  __fput+0xc8/0x2d0
[  200.664011]  ____fput+0x14/0x20
[  200.667146]  task_work_run+0x70/0xdc
[  200.670718]  do_exit+0x2b4/0x8e4
[  200.673944]  do_group_exit+0x34/0x90
[  200.677512]  pid_child_should_wake+0x0/0x60
[  200.681686]  invoke_syscall+0x48/0x104
[  200.685432]  el0_svc_common.constprop.0+0xc0/0xe0
[  200.690128]  do_el0_svc+0x1c/0x28
[  200.693439]  el0_svc+0x30/0xcc
[  200.696454] dw_mmc ff808000.mmc: Unexpected interrupt latency
[  200.696485]  el0t_64_sync_handler+0x120/0x12c
[  200.706552]  el0t_64_sync+0x190/0x194
[  200.710213] Code: f9400000 f9417c00 f9402000 f9403400 (f9400800)
[  200.716290] ---[ end trace 0000000000000000 ]---
[  200.720948] Fixing recursive fault but reboot is needed!

Fixes: be94215be1ab ("mtd: spi-nor: core: Fix an issue of releasing resources during read/write")
CC: stable@vger.kernel.org # 6.12+
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
Changes in v3:
    - exclude !dev && !dev->driver check in spi_nor_get_device to
      resolve kernel test robot smatchwarnings.
Changes in v2:
    - Move the null check prior to try_module_get().
---
 drivers/mtd/spi-nor/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ac4b960101cc..eb21d660036b 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3210,6 +3210,9 @@ static int spi_nor_get_device(struct mtd_info *mtd)
 	else
 		dev = nor->dev;
 
+	if (!dev->driver->owner)
+		return -EINVAL;
+
 	if (!try_module_get(dev->driver->owner))
 		return -ENODEV;
 
@@ -3227,7 +3230,8 @@ static void spi_nor_put_device(struct mtd_info *mtd)
 	else
 		dev = nor->dev;
 
-	module_put(dev->driver->owner);
+	if (dev && dev->driver && dev->driver->owner)
+		module_put(dev->driver->owner);
 }
 
 static void spi_nor_restore(struct spi_nor *nor)
-- 
2.35.3


