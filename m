Return-Path: <linux-kernel+bounces-722620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CED83AFDCF3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D723B7498
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFE71624E9;
	Wed,  9 Jul 2025 01:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="pcA7g9FP"
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11011031.outbound.protection.outlook.com [40.93.199.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2038D1EA91
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 01:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752024647; cv=fail; b=ky4s4iFsgfFflXSnnHKpfApUBwyfXGBCbvPTRKIcF7r0xQhuRQz8KDR0sPAmThOd0+L45iN/tglYk6TaC9de70mD4xLxYHE8uhL05aFZWnH2P1Xev0K3sArPmzBh3qKjfAznoARByGwBlB0b6MzDT7q40bG0TSsfu/Wv0e+IaXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752024647; c=relaxed/simple;
	bh=FsqXxJCZ2RGVJiSvRXKS3N2DpeiaC/sZLR2zDDPtx/k=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EwWJkKRdU/WAGYnw69v7eFwkXOABx24q5Ceu2m7uu05VQUqOmm/FZyh/dba70J9sUqkTlRFIllGLJ1Ajl/iamHDivRH0F0jqDHVLU5ppNrArdYTU4wCRZKo7iU/bF+laHD+nYAwnIdTyYXZMcvV9QDEwpMe629ZDFac7RrH7UtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=pcA7g9FP; arc=fail smtp.client-ip=40.93.199.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6Rnf/kSJ/DVvIuFj08J9y2ZSsrD8iUepuVdBjr4D6NZX4ZlG1GIlrYJnSipjua+PplAjQgWMwX9FSv+laAoHJ4aAfUQSCKWlMJGSV9cCdZhBXoU5DI6bZRMQTuX63CNlrL1MvxRHgtDueA69ET/ayriZcD5ZbBVsj22bET4E8Ac4i7osFih999DwYG+GZRdpIyEh0s+iRh55eidImQrFg8WULhn8xXdb6rvLEAnEPEZf1lFnWWvFV+DWEayuc2E1GL/V4itjDLxhX9HbjSKbSpUfbcIfl+DG7gxGC+8UCpGa3rTtgDLi+M4blWQJtWoWfQ+O4y58RsCIadnrKL5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwQCd5w7ng5GNlVH4PvzQ3K/MBDgqxtE2zetaqYB5+Q=;
 b=iPEgIxmQyftFY22fDN+nsv9kBoZzZfbO0mZmCd3Tuq3dbiga8BscMJzijTgNLoorzEWVMJZLaP75S2jO+CwHMWIPdp2OX6D9Y0nwIi7kU55ckg8CPTUd14BO5tmX0HmoLuDVK2/SIe6AA3av85hvauZ2ZbCCFuH5pShVJcn9q77AFJj1UDKOEzjoov1rvO2/+dqSs90UWKF1Pcaxl/sTsJPb4ughU71+krSlOHm6//qnRXdR6egGQJ3AgpaobzmthxJDAVrD0a+98VBa/uQ6QrU1kUcY6dK2pI8htPPoqH//5XENPVRfbPiKWTFPRnR6WbOJmw02vKecpRQ3vkEcEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwQCd5w7ng5GNlVH4PvzQ3K/MBDgqxtE2zetaqYB5+Q=;
 b=pcA7g9FP4pKQ5ZZ4/SKglyLs2MYGOf1mHfCMVpsyMYaG7HagA4eXh0XQXQmkVY9ZbiRaCmYCFhsPxhMObtW2h4nGUOeRjNOjWYjVAtF2chtE6PtKLGhlKtkU83oj+o6yCqdnnTxQZsaTjyxQRxYq6XGGwjLjU9dHU0/7UtO7oKC/d1FTSHXezrTYDN674lR8NVI2MdsvfqIxjh7BkMuB1RZguGitINGXwOidTbTIALzm+YOdKPu12CPdeqQIvgS68wtxrJuTDrVpL5eLzL/Cz3PKs626PgDZtfCgVjKJnb7hO9JlH7Ck13PPwJg1K5AkV4w5AqUkgLORTePwtdNwIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BY5PR03MB5299.namprd03.prod.outlook.com (2603:10b6:a03:229::12)
 by DS7PR03MB5576.namprd03.prod.outlook.com (2603:10b6:5:2cb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 01:30:43 +0000
Received: from BY5PR03MB5299.namprd03.prod.outlook.com
 ([fe80::b106:261f:6a67:9615]) by BY5PR03MB5299.namprd03.prod.outlook.com
 ([fe80::b106:261f:6a67:9615%5]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 01:30:43 +0000
From: khairul.anuar.romli@altera.com
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
Subject: [PATCH 1/1] mtd: spi-nor: core: Prevent oops during driver removal with active read or write operations
Date: Wed,  9 Jul 2025 09:30:38 +0800
Message-Id: <e439e6b85e650a91607a1d02d5d432d096363315.1752024352.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1752024352.git.khairul.anuar.romli@altera.com>
References: <cover.1752024352.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0234.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::29) To BY5PR03MB5299.namprd03.prod.outlook.com
 (2603:10b6:a03:229::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR03MB5299:EE_|DS7PR03MB5576:EE_
X-MS-Office365-Filtering-Correlation-Id: b1031199-91da-480c-8bb4-08ddbe88389c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D8aYEsJUioahTjWjjs7f7gEllmRixLvRwMAY479nvuU5Wx9I9hUbEwQamDJ8?=
 =?us-ascii?Q?EfLIQtUzjERy9IskDoST7ZI2X0SIopxLcD+TLha9W74J3yhk1Z2bUpUGDhPf?=
 =?us-ascii?Q?wfuk4ugf4PKLYUKP6dW2+MhjtaBte9hi7AWA+8VIJYTMjpEQYVROz3iqsCH7?=
 =?us-ascii?Q?kryP91+h4P28HQwukST1cjpDHrR2HK6fIMmPT0sXPGBuKgvZqqg1QummXRbw?=
 =?us-ascii?Q?P56I4nMwx8aEO0wcRCUkejf6gjrqykT0fwgO/yslcm8bJJyjr19JDb2TRW9B?=
 =?us-ascii?Q?DekJ+dgEwDbwfUSzo8Faw0vl1yz690ib86RF10ePuBcIIBwDiNUmoJQdOD6C?=
 =?us-ascii?Q?5uJRe3qd5CyeCCA1tO1s3O2gDrUCblmDLZEXjo65+D1D/7Rwz5CY3jZqsbSQ?=
 =?us-ascii?Q?uU5TnL7p8dIll2eApjh2YeH9QdZyCIT+Hg/bXTc0zr/p7oh2fKeEXOtJLHsu?=
 =?us-ascii?Q?mEUK6dj4zs/tZgnyrYzKryOtf8aVjnTSiWv21d9VsEQWqYzcpJZwCNuYRP+B?=
 =?us-ascii?Q?TImxCmOhRTGCBPTtapYqm6Jdaa8dT0auDrntpOH0/HFC9jmhDDD+DcScwd24?=
 =?us-ascii?Q?2Lh3yo0al5kQ7J2HcqtUJ9nD0h5BD/oO91fwHdNhO3OJSdkQeqNQiIsWt3Vj?=
 =?us-ascii?Q?e7HxBD0faCHmqTspFWNWQVzD6IQXwaS85E0oZoZ9BON+/85s6wh0y9yfCwDg?=
 =?us-ascii?Q?q2rOR8t2oJEe33CA4yy/0iNsJoj0FYJ8AfrgzxYRrSmFMkF4krmAX4jhcAhD?=
 =?us-ascii?Q?FM+ahB85zXT2+QYffvC2KjzQqF5Myqc9nNNJ0Daw7OFGey8zB7oksejui22Q?=
 =?us-ascii?Q?5KF3cqXVAc7TcIW0Gyi6fhHemCb/E8dkxu3puAvQrRoOPZKRagXSZ4LkLsJy?=
 =?us-ascii?Q?kYAZyFvFiaibPRvrPhkGdRKOO9I7bDhr2wjrhCpmhOyUPMWlMZs32eP+Jif0?=
 =?us-ascii?Q?r1yPBqPgVeezF966WiCA8AAXTyP8vdsaGkt9hFbzK9P9ONCaZ1mrRurZSJWd?=
 =?us-ascii?Q?yptaD1/NSPRC0JULOhsNtKLMxgiDQEbjmydGA02bLS9acTEJRB03tsekFNGp?=
 =?us-ascii?Q?vPRJkz1n7y544dYZxKQ48PcbjoIXcQv2DCUB10HyxZQHSwLadU/WX359qmuO?=
 =?us-ascii?Q?/ahCqya0CmVVlStFDEfkH/m4oHmU5pSnVlJXQwbQFLaIjM9pdfbt1OqthuZp?=
 =?us-ascii?Q?rBmCUPnGfpk8vxbTbSchSv+avVmdhcieQtMTFQlx8AvCu5mECj45+GpH+z2L?=
 =?us-ascii?Q?MXNRSpkoiOEUZvqg0//ds5mHselNzDr3lNxYEn3A4/IlhQnIeR1vaN+YiqsP?=
 =?us-ascii?Q?HD5vNQNJR1PFtQFSuu6PAyqeDbFfmCHflCqw6cqLzruwI4P478/pfdHFEMji?=
 =?us-ascii?Q?RHItolZdRSpLyCEQTns+szDXlF0EAVi5rKA7m6oKp+zJVfrTvs0HwK+s/OcR?=
 =?us-ascii?Q?LUZpOs7yvk7fKjmFkTH6KKJ0AFDLWnJnPpRmbTSk0e7RsOPKSHKGAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5299.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SEF3aZ7rbpL7clxS8qdBVgY7yUqooDzIhYv0dQ95W4394rrFXr6idfVwtoHF?=
 =?us-ascii?Q?VWLwx/AHttgJS9gR7LZYWMkCUXdQ5NSvRXJBlXn65G46TeCFIrWCOgicILkR?=
 =?us-ascii?Q?C7a4R7ctD0YYgcctdT+zv9duGXc4gKpixiveK11Q3FQDYBCv9AsbTejCAdVr?=
 =?us-ascii?Q?X/cACvvrY4XyOtprRAeNyIXdjQ28/XzZMYnitRtfCh+NpDavSx7zcqmx7FBP?=
 =?us-ascii?Q?Ko92Ety3ueW3yAoKJyBUIwvoa6q7DSKyEwj4N0SRHWgMcuK0jyd67VICsFnX?=
 =?us-ascii?Q?qiM/t3ZAdGxTeMuJKN6DbiW+YcQiidGW6EkNHyDwBMpvTHmLrikD8jQfm0Kd?=
 =?us-ascii?Q?SICf+eTNeZlD1T8SHYWhYbyU6Ngz5sOfAYnF8hXdEdL3IwU7+J21ZsXTu0Tj?=
 =?us-ascii?Q?+UjEaAkpSodOGDJG3EvlQHm+yfoSfrLocWv9xem4k62TApLc/3E/eUGflAal?=
 =?us-ascii?Q?nLlGJ6jpnl+MdRCqqT4VXyYlv/lUrIRIPxVvXWIpg8uldSyZ/ql7uBinKnXb?=
 =?us-ascii?Q?lH5NEk+nCl/p0Sbv5RPKTxHWKvErobW1naYKW1C3Kp/slxcNmwyaACTJQHIS?=
 =?us-ascii?Q?GOK7Dg5CAQesmAPr11kE/0rCX08bVXEoUv39YFkqRSHSGJRmwFc7Y/JjF1f/?=
 =?us-ascii?Q?iofYgAxInIcV8aPv7mHjaQK2hFZkak6D1tI9HTDej3QhK2NYsJHjlAQ3JLSr?=
 =?us-ascii?Q?3moMm6fh/vy6moVFiVlXFgKyjUbpOx3Logsc0S5YYh4A1JwqpzxW0iXXozmp?=
 =?us-ascii?Q?gLj+7dobAxmBlr/k5MSg1njjPjg6UskI/iQoQlUDzltynnQPU+7x5u6wWbu7?=
 =?us-ascii?Q?UhfNs9ViLl81+o13jUp3RC+AThWPHlCqGC5jkVvVwfet9yJArAGu/DEb+ZYr?=
 =?us-ascii?Q?lENc61CU4ZKvJbnZGMPhtPo3sh4QGjEE+GXYSk0wa4+92N9oDnN6RBKVST+Z?=
 =?us-ascii?Q?M313lQ081hVwmGciCzhShQgZ0grSjYVUOhBXnA3DI0oIe6y/7Oo/mvU6VND/?=
 =?us-ascii?Q?KmI7PUhIyFrJyroaLFWFON2QrcA4goFt/mEhsFYJjlUinWNJPhSaf1xRAKD4?=
 =?us-ascii?Q?uadoYd5e93SVIZTbrlvq4mAL/zm+qZAnkebblXbocFk18tMVyR8K6U80jWlX?=
 =?us-ascii?Q?WsSL3ZeL8PwRpr8kxz1o86S9BXilXRYCu+XpEHHVlWmG/0v1CNBGbRPCoGUM?=
 =?us-ascii?Q?XibtFO/wCn17X9UsrWODLi0Vck+f5BP2ZvsdVjVwi8gee0L3OZae3tvw0bge?=
 =?us-ascii?Q?YzBT+hZZw6wyOwm7HmA/VmTAduLvd+8xS3sna6z/xBvzzUhIt9U92vH3oESN?=
 =?us-ascii?Q?vFGwpY6eqAleKGk+9EEEzs++01retrblfLxc8ktA4yKBcRbudW2bfGnlOnAf?=
 =?us-ascii?Q?wQOWiducBWCLJdjrIuxRwIYy4ZKq6uYsABWJ97SGiOu9k8S0wd+Eaci86zQq?=
 =?us-ascii?Q?ex9DdCb1l7xcbk6ci3y/U7Fpswad0AgNWXRr0gaolqED1KO/aQJMhQFRiFr4?=
 =?us-ascii?Q?TnTC9XEZ6wq5qHlwvJZGXwc6YdfokTWwBW6ZwjQnFBn00qq9yRhXGyU8UfKL?=
 =?us-ascii?Q?X+thNxxmhKHA/dUpP6KZ9JYWoMybPdmGa0WaPOOfof0oYQiu6on8hzA/PzCk?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1031199-91da-480c-8bb4-08ddbe88389c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5299.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 01:30:43.5127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ih2q/Wix/IZrhkclUuI1i0p+Zj575VfFyRS6Su4HkAD1hczfVrh508x2h7WZbFdGb7OlVAU4mV4qLdiLtPakvk0PLJkV4B2xYw2RyocPjN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5576

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
 drivers/mtd/spi-nor/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ac4b960101cc..501e48a342ad 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3213,6 +3213,9 @@ static int spi_nor_get_device(struct mtd_info *mtd)
 	if (!try_module_get(dev->driver->owner))
 		return -ENODEV;
 
+	if (!dev && !dev->driver && !dev->driver->owner)
+		return -EINVAL;
+
 	return 0;
 }
 
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


