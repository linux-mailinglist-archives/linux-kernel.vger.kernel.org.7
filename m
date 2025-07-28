Return-Path: <linux-kernel+bounces-748021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C37AB13B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5389A189D366
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1723A26773C;
	Mon, 28 Jul 2025 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qD4bnXt6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CfMzBf8l"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F26524DD01;
	Mon, 28 Jul 2025 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753709336; cv=fail; b=DsYQx7clxVsFv4I5N1BL5WJ8+poUsSNpNm5yQevRo3J/DsqRGiONxw1uMA5FEqO3oxngtFpaqlbMic/k/MvsrBLt1mOuQUS1xZTIu5u75JUAmXS4QrdKnynG0OtBU499j9g9EhrkZNUpFfg5aJ+Hc6tDOG2AYnlf/RjzUpgUlEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753709336; c=relaxed/simple;
	bh=ygQ6gyRBzjDQkxUCU638gnqTyQ9/29e0Y/SKpc6SBzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oaFz58Z5nOeeLFsSEH2aJFUFvgYIl3wFRVeP8QSkbPBHlOnUuMhFHxyFNL83i0Ys/zozh2RwWwtRePkghZT4NrRgifw1OdZODs7ZTZ73mBuRNdlf/O0q9H17sIIyWAOXq0ma51jChIi90rnY6mwmgA3OVeiwr8fiHhQ6TNBHR1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qD4bnXt6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CfMzBf8l; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SDCUGj014199;
	Mon, 28 Jul 2025 13:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ygQ6gyRBzjDQkxUCU6
	38gnqTyQ9/29e0Y/SKpc6SBzw=; b=qD4bnXt6QXJoqmNAh5WyUPN0zimyOib2QP
	rgMUF5Hqs4d7+7qEt65p5R7wlVQUeWBtbjh9+pfAvu4DiRwkrdF0P6kfUy8VDoNt
	pbM4MnjjNUtooBBARX8Pch6epS1fMMARchoMez47y6WdUH3RwvjqtSgehSeBrNh+
	MMRF7Lk2LFIVsupSHE3C3osI640OLGyG4egZhw5nduxloTT+hebMA0YgyVgZiWx6
	ElYeO43wFXiWEukL+9cEDpJppVARdWK4/2BjbWmL1wKMSrrK3g3l+nTCYZcBIMXG
	foN3yvHu8asA/8zTaMY//76fTsXTpid8o8oZh2YKz0exkmmEn6JA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4e3tda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 13:28:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56SDObO0011238;
	Mon, 28 Jul 2025 13:28:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nf8b2yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 13:28:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdnVvUUDxKpQL2w3+ywZDF5t98g6FAldA83fcMQmxSmDtOwdWJP1YutL8M7NT0s+rqk8tuXsWBMZhnvMWpCzbJCxR8pQMbj0VgwLZBH9q+9zLVPCJFDXwNK1Zt9Xan/7va1BNmOz5CRBRn1r/NMtwAQV/9s59eeZafbQ4noPbDMrkg7RbbTvTNwu0uWrNAbZnEeGS6nmPQ+G5VOqhWDP+zXJovzOPkpndzSNyFzjCwmnVwOr8cFrYyKgSeM1W6Y/htINBZDsNOByggXpUR26C/mpkBonqBdJaTH1eFCzSceheLAhmvxlXEmHqUEzwYfHfvwmI9rzNMq4W0hjPbXocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygQ6gyRBzjDQkxUCU638gnqTyQ9/29e0Y/SKpc6SBzw=;
 b=ZlAeTzEHqyUqtRNI6/SBVou+gDPSfCCPZQnRr8H2pdntNZ0WBp+/mUKtB2PvLPruQFu4ULb/sdoJdFoIZWSMPtyfUwApmuuZ4DB4J3G+Zz/k/lwP25PrmTnxgxGWJfbYdjfsNsyyx6hJR8pjnOBsqDJxDbAZ/4NV04s7PyZ/sf2qJjShx8FidBk5ICApilLsavrosjbHs2GcR/QfkSv9NzfPrW9EBtctDWwb1Y7ERB7jmodvqEe+HYtn2noR54dQswn59+Jbo0mplIZjLD0TF2Ceg/bL7BtlIZp63VDj8cwguQOf7ILizUvFnf64nbz6vkxIf6i3ASWHX8fxWL3Tyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygQ6gyRBzjDQkxUCU638gnqTyQ9/29e0Y/SKpc6SBzw=;
 b=CfMzBf8lwv1VISH62knzo3p3yLh4zuIt2mpuAvc9TSm7xqE0ma80EujDnOxBuj1fyHmu7WHE6W4TSSufprd5gLUnxZssfJJDA66GhZuJwD/d0xRrjOKY+IXxB+4DWOgJU4VljK/TUpakgZZLt8/awKUMMxFsG+FBXW81ZN1SXRE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB4848.namprd10.prod.outlook.com (2603:10b6:5:3a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 13:28:23 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 13:28:23 +0000
Date: Mon, 28 Jul 2025 14:28:20 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Greg KH <greg@kroah.com>, corbet@lwn.net, linux-doc@vger.kernel.org,
        workflows@vger.kernel.org, josh@joshtriplett.org, kees@kernel.org,
        konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <90b0ba66-8d09-433c-a6a8-f46893db1ef7@lucifer.local>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
 <2025072854-earthen-velcro-8b32@gregkh>
 <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <aIdw3-G04QQPvJtU@lappy>
 <c4974be6-6076-4833-bada-3012d3660a8c@lucifer.local>
 <aId5x_ocOiWICyZa@lappy>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aId5x_ocOiWICyZa@lappy>
X-ClientProxiedBy: MM0P280CA0098.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::30) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB4848:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed9b4d3-cf0d-4f06-383c-08ddcddaa06c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g04TQtm9Tm/nqOHJNi0MXGafk2uFs/soMAQjjN6iUkmAJ/TF2yTQNTDdYsLc?=
 =?us-ascii?Q?7MnCa4oZOLwYhzn+owBVsXyi/vR1K4YXVwfvq14grNCFO2jWQaO7JeR0t/w/?=
 =?us-ascii?Q?8OYKnpotRCXIWa4wpnjxAqEzsdqGmoQheNwoCpQIl9opzdfTvCBdIuCyj7ER?=
 =?us-ascii?Q?+8GM++7elbpYvZIXDx7wfeY6qfXPTzsQdseEf4glWBFxEt9NHDB8pdikRBWN?=
 =?us-ascii?Q?NVOr/yulKELmR8Ci8b4CHYrhzd2ljtm9DloFCxX1Tc+U35E8QfCb9u9zpoMf?=
 =?us-ascii?Q?CO6ZdNFKQTLTGx9Fi43l0VYHiFPOi/wZbJ9IMpjmGtGso8qbixIE1BqUiied?=
 =?us-ascii?Q?anazIjQrABYEnh9eeHKyj6rvT51RJnwMrUWiddLG4MYxcEIvYvzqtwV3huvP?=
 =?us-ascii?Q?19LcyMIorUaNYCYKXHvLx+KuE2ZxqM1arSWo+23u5vcegJXJtLftJTmAuEIk?=
 =?us-ascii?Q?WAg2D3GLys0G6EzingWbbg0TxaXxrqYYVEtxdzgLsqzWcWkz8H9QXklaA09y?=
 =?us-ascii?Q?3Q0kzYF3HReiyJCDa7NMH00OxWXGdXg3CWPkeQshzFz55Zes2KMLtvHFph/C?=
 =?us-ascii?Q?ca+Wm/D3J/bsxYkrmeL9ijYlKndbtL+VZsf9f3DA5iK6hsfRwKQEPxzQV8Z1?=
 =?us-ascii?Q?boJQIzdb963N727M59vqJ83hnxKVxoBqrc812QJiDrVDY5ppDcGccDR11S7C?=
 =?us-ascii?Q?dgAwBQNaOvlJ5qSvXxMcPYKyJ2VG7pZW7yxumBE7NMKGOz8zJD/7S0YCloo8?=
 =?us-ascii?Q?UwkCOfuRszalOQJWk46vtShsekXjOLdAa6cG2o2/WNIrfwoGOLJFNwge4g07?=
 =?us-ascii?Q?0/gjjl+eXRC9BHyL8/4OepjwCJLWLvCFUMMHOo/dVMFkMk7JmzM17KMtbfXe?=
 =?us-ascii?Q?pT6+4A54gyJ58Gx111wvaLOUIZW0kLHDr6KhGG2AKMaE3mCyNtlGoJGF6+Fc?=
 =?us-ascii?Q?tTCnrfMiSOoUYAAndiXKAw/7R829mvo9zVcyWpAuG2Xn4XF+XiRjDYjtaF36?=
 =?us-ascii?Q?0OCmJh8jANw0sYTNUCFrdhuKfeLSpEH0KE9SFn/nK4tOsyddhTq7kdEbn5qg?=
 =?us-ascii?Q?BqP2wJDo15RpEyfJj6Msz/PVSvJG/jo1Ld1CoXvprrwiTClHcIn+BDJBb6My?=
 =?us-ascii?Q?f52n8AvElLVDCPZDqtWT0ijg8Uq6mAPn3y/ru3UPyySpRKP+SZRZlES0AYgC?=
 =?us-ascii?Q?87OGZAOipIV/X9mMfXI41sYY7HTVJtBpBuiHas+00lMwa74PQAJQ37X7Qm9+?=
 =?us-ascii?Q?1C+18mrUiHmgQZmZ8Cxnu69bCc/4mTLw04BRqy4aVWBMr4Q+uN/YKC1Wk8cx?=
 =?us-ascii?Q?kcUr4FMoBx8jwQpcRdhDtLwE+jcWPwN945UDy+WMx49BGHY+BFi63521Mn4A?=
 =?us-ascii?Q?tahSAqiswczOT3M4XrKak2/qpKVtmXiYk3rwdhf2KD8NinsbnkMiKfKBRH2H?=
 =?us-ascii?Q?XApgveH6xpE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fT7KnfqxSPKQVdMpxAEi/7My9QrZzB75g6wZwAL0wrMKW3YQh2PjPtxO9p3S?=
 =?us-ascii?Q?44kLq7UDGFJIiDZZoqhhiTAu+aSjhe6KTc1vbghc+HBbbGgLP9RcDA82fKKT?=
 =?us-ascii?Q?jp/6eDJWJEt33wUptoCqwN+zZtuj+86ASS4V7ZMjNT8PbQez8aiNfGXzyrPj?=
 =?us-ascii?Q?bCL8QzEuwbtG6kY4c1ay9hE0klttj47IFyFKRF8ZdJmZnqIDuilRMTvlF2wU?=
 =?us-ascii?Q?H5kwK/f6m1hp5feQ9Q83b558mZ8Vtp4Es/O3BrM/ThrChWSGG2xr8hikmIaI?=
 =?us-ascii?Q?QLBXLVZwFusfekQufs7kXkdtXHAJYXptt7blUUJLtZF2NLl5xx/cy+f53fzh?=
 =?us-ascii?Q?Lt5MNWfia8pua+STDR/VX4/AzQP1W8BX6OVlTI6x61eC+KC3gSL7+imGIm3N?=
 =?us-ascii?Q?nvsTT3Bh99YuNn9qe79yqeWgQ6Cx8sf+ZjCP7hm+Xs4jWaNF54xpVmbFbkBD?=
 =?us-ascii?Q?cJ61/vWhSkUC1HX/J5sR/LwMqeS/ozS9G1uhuOpszAQjhuOQ3DO7PBrJOUrv?=
 =?us-ascii?Q?P/d/mWduukG+tTuDWCSFPFjMscjTceKM2+AlK2LV++YG2YlpGhZNUsHI8uqG?=
 =?us-ascii?Q?y8/2ewobgvUM5Z54qXRZT7uv76ybJDPXCG3BipcrV7/PCNFbdLLLg/g3pzCn?=
 =?us-ascii?Q?H3Rn5JgxlYB6sfedHP358Y6z9fHAFxy9tSOtsdIs7VtqETxwUdOwWIOZV2bF?=
 =?us-ascii?Q?1+A4h01QyN/pddWEWCQINP8rTPgxm7cBCwXACiZUOY/ty4eokx9vHJSGevaY?=
 =?us-ascii?Q?v6gCEMHTKKVfBefAP91F+/Mt8v3Sn6msynSP5jMbBEvxMlCK0qfwzRjomfMm?=
 =?us-ascii?Q?ymIaoBijqgVPgShrufap548wUfpGfY2ZBPZwSmYjL3cMhv/dQX5sTtaDJAUt?=
 =?us-ascii?Q?yv1Kzge2qJm28z/zEMzheDo97myl0H6RE5u+REHwtbYxEjdDzy0mg2NXAOvj?=
 =?us-ascii?Q?D7o65WtgyiiExiDIYD41eyF5ETLRJ6p2Sth/0F5vKDgbOW6WzKLHnLbJtUhG?=
 =?us-ascii?Q?b4cNcrqNYTK35WuaFyMdeozPgK33djxmz5tY/5Ccu+nhcWws45oU48zKhAj3?=
 =?us-ascii?Q?LOKXVoWUrBCdbrE7+eOCF5qmYaZjtSSQxXuhfLEmlPik8caDw2wirhExgVc2?=
 =?us-ascii?Q?plmwRwFpH3h3WrS8n6IaK6wEu8kAXSqE2+g4M65C4Ap1qF8z3kTPICNB8/X4?=
 =?us-ascii?Q?ovdCx/eLM1iE9gbIGTrnMHY9R6kfNH+LeMI760QOUxHExEpeqQC56uZdcpte?=
 =?us-ascii?Q?wi8IhoWcAzKknSeGXh4dZlmLDMvW13Kc90yx0sV/+u8ajfFj1cA65WD+sEzQ?=
 =?us-ascii?Q?LJ1eUu5o7kMore3jqsvuJ+lOpNyJQbqTT8n6HIE0mZdwQ66TnFLBjEJKebzV?=
 =?us-ascii?Q?LUW8lEwZb+NJXnlFp9ZOV5XNUwJTXwrqVWM8XLwJWhSlZyzckw3h/GmxJg8H?=
 =?us-ascii?Q?hS8zc8IaBidl3j1cE1bJ3JuavRr4/438V2ORWI6HAxVgCKOrsKc7oQHMYJ+k?=
 =?us-ascii?Q?YbfBKZ0DBZuIEgA/nJChfiBsoWoLXzvleMM5g2AxI9E3W9EAtmOj3bx/pmeK?=
 =?us-ascii?Q?qHHdCsRya6P0OEGaN9qvT28COp42E0sciYboDDApeVSXHunUhg4w/Ts4b+3V?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9uNOT1DbCAXWtHDbEd5uST84RRiqJK2+A9bZmc+YnaVIhuurOdZaAFYH/X7lr/VXIDxD4TxeQ0FKkBrjxkFSivqSTer2hm8zK9Qg6OC05xWq1SSxapK1IAPGSWDaiylSTj076mkF8NwZ6cPPGJgm9+QJBeVBecBuNTE7wL/JQjRvC3t5hknLqPjC87jFDUQrIswKUseaCXvF5wnETrokpSIZECvE/gT1uuQQELWzOIF71d4TlV0rWpq1t1axtCX2vxkPUaEUkZ9f4gLnOtZb0wsp1TsvrSYcV0h5kU3pqWogbJcVFALl1UKs82g3eYwQiA81S9RZpNiVXrDazgaW5sp3vuWYXDHs3T9T0aN7se49BtatnHeX79+5iemYg89I+F9v3if1G7nl0n9pkUuWvqSzTUFBQqHhwGgm2MuNVJ36ypVpJC+w7eankn07gTlHCnD6ABIN31XNMUi3JLiQorujgxnVClC4IgvlPDTezGvlhyvH+NcI0q5DqT3OCJMFLQlzjRxBXgSPFaKAKZ4NtSeIBXOxmqsxw8MXxAqSe/jM6TqA74+egdS5PAsQMhgfpbraD04QSQRtkAkiZOoMvJu9G8M8KJFyZgF9SDMeYas=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed9b4d3-cf0d-4f06-383c-08ddcddaa06c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 13:28:23.5330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbF4Hf44MUnYdYF1UJBsLJf6kLka85KZJ8m+WPUwAwL7lmcLJUGBI6Idizm5BGmOU78PzAFUtZmHo8g2oatLH3YuE5UgItizjvLxaWdjFEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=890
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507280099
X-Proofpoint-ORIG-GUID: x5sOg58xWYHhTcLoIfl0nrCkutYZRzSq
X-Proofpoint-GUID: x5sOg58xWYHhTcLoIfl0nrCkutYZRzSq
X-Authority-Analysis: v=2.4 cv=QZtmvtbv c=1 sm=1 tr=0 ts=68877b08 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=7xYEiJbnenL_VmwJDk8A:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA5OSBTYWx0ZWRfX9BbQwccgtSn6
 1VSqIgjMS7TzAa62erpEcnjVhNWFyrRNWIzp4ltaP0LFx8N9tunk2ZMDs2DWCyrBrrxvDybQ4KL
 qE+ePEb8CHQvJR43iuTq1yh+1ksbcu3b0fXZybPYPsZ3Lz6+VNsr3ZdLz86Op8DGs5+KNNT/vlA
 HQmIADr9hkHflKzZtb55kCsLnqCsOfpIJTpPRn75VCS/Xb1KBnAGSLjenJdmyerBjVtx091IiDv
 3OZUuLjPv7ME7zNqRX4l/ONtCMO3leOrPUDDLQ3lmvWLjob+s0OGwOkbHyPnutuq+6Zbu7qQbEq
 Tc/VDFnMTsB+iQZ8Ui23lY8VynYmZ49mGDYt8zmr5yLwfHvLNYWwbGsK40xmq6E/knuZGOCgUun
 eizTJHoh2ED+vIEGdkO92Z6G+IJ03izqCYtO9MYGX9ne8Lp8uOyy5B4nijwFWFpwrUPzWVld

On Mon, Jul 28, 2025 at 09:23:19AM -0400, Sasha Levin wrote:
> On Mon, Jul 28, 2025 at 02:13:01PM +0100, Lorenzo Stoakes wrote:
> > On Mon, Jul 28, 2025 at 08:45:19AM -0400, Sasha Levin wrote:
> > > > So at all times I think ensuring the human element is aware that they need
> > > > to do some kind of checking/filtering is key.
> > > >
> > > > But that can be handled by a carefully worded policy document.
> > >
> > > Right. The prupose of this series is not to create a new LLM policy but
> > > rather try and enforce our existing set of policies on LLMs.
> >
> > I get that, but as you can see from my original reply, my concern is more
> > as to the non-technical consequences of this series.
> >
> > I retain my view that we need an explicit AI policy doc first, and ideally
> > this would be tempered by input at the maintainer's summit before any of
> > this proceeds.
> >
> > I think adding anything like this before that would have unfortunate
> > unintended consequences.
> >
> > And as a maintainer who does a fair bit of review, I'm likely to be on the
> > front lines to that :)
>
> Oh, appologies, I'm not trying to push for this to be included urgently:
> if there's interest in waiting with this until after maintainer's
> summit/LPC I don't have any objection with that.

Awesome, thanks; yeah I think this is the best approach to ensure we have
our ducks in a row.

>
> My point was more that I want to get this series in a "happy" state so
> we have it available whenever we come up with a policy.

Ack!

>
> I'm thinking that no matter what we land on at the end, we'll need
> something like this patch series to try and enforce that on the LLM side
> of things.

Sure, practically speaking it's unlikely that the decision will be
'absolutely not', in which case we ought to be prepared as to how to
implement what's required.

>
> --
> Thanks,
> Sasha

Cheers, Lorenzo

