Return-Path: <linux-kernel+bounces-820887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C27B7F9AF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC838188EA4A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236FC32E758;
	Wed, 17 Sep 2025 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Trwi+qDD";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Trwi+qDD"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011009.outbound.protection.outlook.com [40.107.130.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0792C32E748
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.9
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116569; cv=fail; b=atGBj+MfD/aym2tJfGQHrsQbkA+zgJoFBzurVoJRBHEVIRkk3XJkVU4r1Ob1ssxaxrDZUFjV7whjX0cI6kyF2wFt8DNOYG+ZK5Sfx/ZYNVqhh/YLj9atoRSbT5QVRynOQJIMi3842HQ/pBj8BYo7QLZtbtWCfQZEMdxpoFOOb1Y=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116569; c=relaxed/simple;
	bh=hInceJnYgo2Aqu8SYpNYkTTwZW1yJQhchoixLyaND/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=laQny3Szig4MwzckN4cwH7Sr3hyfXNYke25Bc6K2XohXe5th+HRAVhGRjgeHfdmGG0l6PHN1OYOJKuHlHQjy+MASHLPhin2j+YRsQSKHaNXnPbTCjjdnhz2EONB8fhtMz0gsXOqAow4BoKM0ab4y1KzhyOPOFQVDGB7Vh78xfBE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Trwi+qDD; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Trwi+qDD; arc=fail smtp.client-ip=40.107.130.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=h+MWcSNIxDtO97ib+s7MLpJIt/F/TzgroKViUuncZC5OScC7soKRU0JHpu3paqXrc0TTBPEvvx/QXCwKe9LJ/IvMgmiKWnFAMqo6fe4XJLXfAWxcuqVAo+fgV/8IknllsR0jwTuoL2XuZu36fFU4aD0yJp7eWgDrWMG3jhE6PN8bibZsVAxxPfT/gggLihphPGfPk1DUrpiG+QyaYnFiD5p3n924ORzumoHtuXYNq68+2W+BfucYjhwAJMbsN4OkT+z0g6EsV2VdPAWDOxMIwowkiIuxBfZMmRoJ5ToZY/s2ykVUjJ18orHwGLB70yLJpYQPrFQ6CcCl7UIgyKfDgw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIvuV8dMLNWCY6ifkYQ+OjzOC/H9KK/DCqA8sUX3YK4=;
 b=gc6eeOJGBPvePk0Jxfo56e3tjoU/qljpMhMb2XQzkVVrCkD26MVRDVhcOFa1aT3P23OvSRlPwihsrc452mnqfKQT0UDkc/4cHyc0A6yueHNmj9UO0atbiAZFQa6xfc5v1hSHaFZ1+q3UimFR+hvzVU/1LGRT28B/kYarrGkyggBxC6S2xTzbJhZGeWrDd5125FqQgptbC9xWeRYx9SaNnrdvOn2AN5Z9eRdv0Qm07lvk1qHWYJyb7HWw2Cpd4btAO2FtdSpGDqT0Sy5TqMvPfOf5VKe3+JNfI884cIl6UDxU6WyOP4w2zodtU97C+z6raT/LjPssRh9NYyM6TZfO0A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIvuV8dMLNWCY6ifkYQ+OjzOC/H9KK/DCqA8sUX3YK4=;
 b=Trwi+qDD3oe6d6AK/CvKerjv8tOWVROa8yrkQOVLVCVwtpRTgYdCkjwQqnKq4axLm7bWWQvFQle5V+akVnOr6I75s8zjgczpR7Ao70xVBGZO6QtGHZSk82NYNupAFRjWXMkWhZEgThFnbBnpXzMnJMp0kUx0hDtTdlxwTcaRNdc=
Received: from AM9P192CA0015.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::20)
 by AS8PR08MB8873.eurprd08.prod.outlook.com (2603:10a6:20b:5b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 13:42:40 +0000
Received: from AMS1EPF00000045.eurprd04.prod.outlook.com
 (2603:10a6:20b:21d:cafe::cb) by AM9P192CA0015.outlook.office365.com
 (2603:10a6:20b:21d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 13:42:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000045.mail.protection.outlook.com (10.167.16.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Wed, 17 Sep 2025 13:42:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsr7AHOl6m83Xe/U0xiKdSS9lKkA64h5AHfS3xugqNXDxTo8LLw3DBua22VkW853lxx+egiPf8ZxA72pOch3FYJ+fxJ6Re6ZUJDr+8ou3waHqi9rL677d5CxCizdRdQL+OZtNYMIR9SJKLbHThOMH9U3TMligcKznKUMm4f+LbYKWFTINncyORZV7z9FXo8HV5GGEHixtnZhfr3TuERyhhlJOhh/i314NFQ9yh9FbbTe9rUOnbZoLuiJ0QwPlo8/+6s4tsuh3l8OVmUtVEr5rklPecovbztMCs1FicFzNWJQmSNgVnXz66vcBIlFBrYrTKiQkA84fLpjbMvCMOAgHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIvuV8dMLNWCY6ifkYQ+OjzOC/H9KK/DCqA8sUX3YK4=;
 b=l9keQbP1iamksdGx/lQU05V6gKpWmh6Gzmiahkmf/wzMQbiP4yJYehy8LUdAzBwRf0ZWbp0nUN7F4hS55jDCnc8wAvbljytV/+qls5IrFkUXniCXDIZLcfrZ3Hy3blnuLFKNcsGdMam4vos5GePpIfGtXo/JObgSJ0BcI/yUK00PtY1zi8KpbmswHtg5ayDPMVO1lqxPkcKaGwRwmajU5TJ0b9xDIiIZuIQRbBDLeuMHVz+XEpzl34//QS/NNbDd64Cs+F1IfbJchpqcoEATgrW9xjjdIkRyiemYFI5IzUuskPrgVaxR4kgCrR5n/+6POTYi3+2P2eMue8HE0qtfUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIvuV8dMLNWCY6ifkYQ+OjzOC/H9KK/DCqA8sUX3YK4=;
 b=Trwi+qDD3oe6d6AK/CvKerjv8tOWVROa8yrkQOVLVCVwtpRTgYdCkjwQqnKq4axLm7bWWQvFQle5V+akVnOr6I75s8zjgczpR7Ao70xVBGZO6QtGHZSk82NYNupAFRjWXMkWhZEgThFnbBnpXzMnJMp0kUx0hDtTdlxwTcaRNdc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DU5PR08MB10733.eurprd08.prod.outlook.com
 (2603:10a6:10:526::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Wed, 17 Sep
 2025 13:42:07 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 13:42:06 +0000
Date: Wed, 17 Sep 2025 14:42:03 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	james.morse@arm.com, ardb@kernel.org, scott@os.amperecomputing.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/5] arm64: futex: support futex with FEAT_LSUI
Message-ID: <aMq6q1OGc3InfoNA@e129823.arm.com>
References: <20250917110838.917281-1-yeoreum.yun@arm.com>
 <20250917110838.917281-6-yeoreum.yun@arm.com>
 <aMqx67lZZEgYW-x5@J2N7QTR9R3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMqx67lZZEgYW-x5@J2N7QTR9R3>
X-ClientProxiedBy: LO4P265CA0155.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::7) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DU5PR08MB10733:EE_|AMS1EPF00000045:EE_|AS8PR08MB8873:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e7aea07-e519-4a6a-471f-08ddf5f0122a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?jby1vZ9uINR+2Nottoatzx5Pg9sNl7P6yyO4rp3i6IOpdUuFEZA99e/r8PS+?=
 =?us-ascii?Q?oX+dGEFXNxf9bZGwkn32qAP6vmAZmkXfkm6r8relj1sq2pAtrZyXfAkrzAwj?=
 =?us-ascii?Q?kiEh9cubNl8JQ1q1NrbZLFZaTMRVsyJLh2EusuAdN0FvzfkJaeO6/IFwj5W0?=
 =?us-ascii?Q?CYBCNFEN2J3KLtrMiiqrJQYui4ISqc7uScGp7WP5nSB8S9aJC7mG924LInoQ?=
 =?us-ascii?Q?XdYu4pMo4hJ6H6z6ALeB6cuP6kaTvpKESTxTsNVoKu3VHiSvB5K6cZtD3EIl?=
 =?us-ascii?Q?+N7DCqVF71gxj2sJKM/is/TDYJEcrQS4WQvIyCjDCCUHvCrd0hYXCYsm/ZnX?=
 =?us-ascii?Q?m+cwnp9AXzXYGEPMrc8eiLYpJzAWb7mM0+MKkJTCPPyQG7AkMGs5kpscGU5w?=
 =?us-ascii?Q?ORyA+h26vJ3SIcuclfjCYP3p4x+PokAIt2cJ+NmL5FBqLYQktIFtSNtZvEwC?=
 =?us-ascii?Q?/fbvHQ2fA1kuPuN8dpc6OEmY7fe7Tvikr17iSCCYvffHcDpMkVfg9S9gzj1k?=
 =?us-ascii?Q?taCbk6Hapy603Fr5/M7bPQkebmmosTjqhL2JEGgh0h/mnd1jWG07lC9G+hbn?=
 =?us-ascii?Q?9ikP/1aTNB0KDrz8FIQWt+vfhH5QDYVNMSG/zXkdKU72rEpKI5HmXJ9CoU2k?=
 =?us-ascii?Q?EHnEjBCIABa/+M1sQYz/R+KdnGaaUVWJaG76pIlXwT/R+z/ESO+Zx5n0d+qI?=
 =?us-ascii?Q?UBxfoai5Q9CwNDqZAlYOO4yRei4WQjrh9t+1YG2QbyDjUokSQ4BYsOUs5XGA?=
 =?us-ascii?Q?hPwCoVPf4hlHzR8JJP9lfMTiFOj7ic0PzXz/gC5YGTIaEYmDLGbsUA0Kj71j?=
 =?us-ascii?Q?WkmshE3AQ+VHyMxMU8DcfedGlQ4XuSFU7yYtb95xa6zTn8RVBDQPhy5BUO2H?=
 =?us-ascii?Q?IUKNf6kPQn96VCbClvqt/GWdSCd8+saXLL5yRW+Elyax28ffMovACVHddtJ3?=
 =?us-ascii?Q?mNE1IUVxXT5mMf8Y6NLvEu2CEk/lTi/TTop1QRvqhABWUZWfG40JpPPRZMt8?=
 =?us-ascii?Q?ybgnyXeLEO5gHUJFHF+Dx9No3nAiM87dBJ3rLKheUKKPOROGsdFXK13C/J6R?=
 =?us-ascii?Q?1YIyvoGJx4wvrEcvxUQceUOysV3Jm9nukRiyYiMsJt+Rf/GZvc0QEDEShSU0?=
 =?us-ascii?Q?XVW2qRdG1TCQAlfFc2a4eM9dwYWXGHQ6tk69aB1zxO6lcsYQvFhy6rILYys3?=
 =?us-ascii?Q?lma4INDKWwbjrkGbLKYt+RdhovkUWxyJbXY6hBgognyMIhodavjwinlmFhQW?=
 =?us-ascii?Q?vqv8MPkWmmEXwiMwDhatVcSIJz19pmmWXLlM2J4/dW8CDBdJE9dAV7FIzEOA?=
 =?us-ascii?Q?LkMM0urScpRe6b1m5DPFimihSLBOaKdyJr+TIWgrsIrSaHas20x1G68kslV4?=
 =?us-ascii?Q?hmJyyNAPq0aZ5nUJt4ZO2wFMHH05PiMh+Oi6hQifUHZFXikGv36qRgukynt1?=
 =?us-ascii?Q?Yqhe/erdQjM=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10733
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ab2e59c9-39e3-4ba3-c99b-08ddf5effde6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|14060799003|35042699022|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?86bwAziS9rYuZ/bVp6+k40gxRPc0DHLZQ4sxS/bwyZwnsjIogaFFhvZeh6Jx?=
 =?us-ascii?Q?7QTASqyBt+dTH+yJKfbG4JjC/XwETsm0lUS7Y3PHyOT7foBuK796urOu8mwb?=
 =?us-ascii?Q?pR1b3BBHa+EL+3Zx3MiVTjcuN9A5cO56/lYxd4rTrU17YgIo8FfuGjfZp3OS?=
 =?us-ascii?Q?E6jc42pd7pwZ4QDwZtVLkUXRhI6SIGMOo+D58XyFkb4iw4QVUbmvpVpiHX4z?=
 =?us-ascii?Q?TsJDKsfbjv/pDVi/lero2NwFTa1FHMKzG3hoj+Fh1+PhkxuIfcsCHD67utyM?=
 =?us-ascii?Q?fndk/vxvU9jjdhcymcv5Ng5EbUl6qeJdlflV6CWtCkEq6WCUX991fKdtYM85?=
 =?us-ascii?Q?jIlTj48YCZZB14xtvcSFjwwH0y3KSLkCxKMV2UFMr+/LF1N8hYSprcdjvRwg?=
 =?us-ascii?Q?6iEPPbrRXaH4qisCrHG+TE8P3QL2JTydEe3DoezVskILScvx8Yfli2mt/wzz?=
 =?us-ascii?Q?3y5CoLLcO5tNrqJedmhZ1aTyuNZp13I37hxFGByv6eeKgZMHiWM/klvT+MxJ?=
 =?us-ascii?Q?ofBHiW/1nxq3L57s9uCWbQr4WIVZt7U8NNNFm+eMnAY3oO2XmFovyWwy833f?=
 =?us-ascii?Q?oOOyA9oyjS4XVS7pgZbrJvXqmCRe8VH3X6HG6s9X74P5gUs7V9Yjpk28D+8q?=
 =?us-ascii?Q?UCadwufzn05xp+l95qoJnbBs2SBI3ExnUlNrbyJUoNtXAwRwhk2jLJ5sHlaX?=
 =?us-ascii?Q?yaZ1VtnZygYUMeCCMyhj5V/Foqm69IrqEqd3xE8G5KvzYM/q9G3KuAJ6PVAo?=
 =?us-ascii?Q?5/BspyElV/C42OhWWTXnFJqUUWVYEKA7QexsgyyZ9C8bNZdsTx+eruCydCiT?=
 =?us-ascii?Q?bEpjRzIqx76lSSvVJOSn5+NZg384XfaAhgeLnZTGZBzOr1wOqNyA8YTACC96?=
 =?us-ascii?Q?TAS4beFS62y9qIkkCeNnH2M2HWlQfU8LoxXSkIBHN8jeJ+IzktN5QpUdiR9P?=
 =?us-ascii?Q?zvPKHTZDtGjffKdEnc2YOOe/GlagLhsE7IRUKI/Ls9K3JnnjSQcfEaspEYX1?=
 =?us-ascii?Q?DqrSs4mGn9122oiIYhAtYxn5B/5A3rX8bJEfRfhbfecJqHiSr2p5iam0qsD+?=
 =?us-ascii?Q?K7VbuWqTlp196rCBh0QLxRlDGC6axXsd7/64/TzT/UfINSc3Yt/f0x+3iqSb?=
 =?us-ascii?Q?ZU2Uj2GQhRaGGv0YFfEr9s+SZ8Ks5FiTloJq4xa2nuCP5QohKpC6Lv9akpxB?=
 =?us-ascii?Q?Pn3Kz1Hixnmx2ZOmLkeXbFcUY3EZyo0VbmZtx5FpGgwynaUBOPQCbYjgkZ6l?=
 =?us-ascii?Q?6Dm2zCGRCSm9OU9AJ7EHy69HMM3Fnsd/C5f7JfAr0C4IpqGnbCmpX2WonLwi?=
 =?us-ascii?Q?mZ8uiDU3vl1pzJWXET74fe7TEMPXMVJrK8KcPaWNccvB+7z5MlfHEfgdk6jL?=
 =?us-ascii?Q?1s1sp2rIJDutIfr2LR/LlYmKiCodPVEBuEkNpj0zaOxB4z25NHQzn3cfPOEK?=
 =?us-ascii?Q?xL0t3VTzmgcZieaeu0FugFrheO/b7Y1DnPLnx5rs167tZ6QOlS4va3KPCmci?=
 =?us-ascii?Q?rbHmzcRRprF3Q1Yr4TyksFr8RGIZPeQY7inx?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(14060799003)(35042699022)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 13:42:40.1346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7aea07-e519-4a6a-471f-08ddf5f0122a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8873

[...]
> static __always_inline int
> __lsui_cmpxchg32(u32 __user *uaddr, u32 oldval, u32 newval, u32 *oval)
> {
> 	uaddr64 = (u64 __user *)PTR_ALIGN_DOWN(uaddr, sizeof(u64));
> 	u64 oval64, nval64, orig64;
>
> 	if (get_user(oval64, uaddr64)
> 		return -EFAULT;
>
> 	if (IS_ALIGNED(addr, sizeof(u64)) == IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN))  {
> 		FIELD_MODIFY(GENMASK_U64(31, 0), &oval64, oldval);
> 		FIELD_MODIFY(GENMASK_U64(31, 0), &nval64, newval);
> 	} else {
> 		FIELD_MODIFY(GENMASK_U64(63, 32), &oval64, oldval);
> 		FIELD_MODIFY(GENMASK_U64(63, 32), &nval64, newval);
> 	}
> 	orig64 = oval64;
>
> 	if (__lsui_cmpxchg64(uaddr_al, &oval64, nval64))
> 		return -EFAULT;
>
> 	if (oval64 != orig64)
> 		return -EAGAIN;
>
> 	*oval = oldval;
> 	return 0;
> }

Oh, I misread the condition. Thanks for your suggetion.
Please ignore my previous email.

--
Sincerely,
Yeoreum Yun

