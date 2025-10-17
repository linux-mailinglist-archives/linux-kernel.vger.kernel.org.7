Return-Path: <linux-kernel+bounces-857119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEC7BE5FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 02:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2653A6226DF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEB721C167;
	Fri, 17 Oct 2025 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="e9h7HaYl";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="WJkFP/IG"
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90857433BC;
	Fri, 17 Oct 2025 00:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760661293; cv=fail; b=U2BrmD++gp/eALRyGERtqAAw1k8EukLXTDmSDuEvZok4xRN7dJ7d1P9kaIS/Kj1mLX3rqzoLh0hDzXbp1p5AmL2IBINAEusqQvn5v+QXsiawLU+8sqJHZNcuuv01bunQvK+lLVBcjSm5Hi5IJrkjNDb/t4TLFDx8gB3YcJi0nFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760661293; c=relaxed/simple;
	bh=rbNbXdWm3EPlvd4bvv5yt9qSBCTe9hHJMw0O1keyHlE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Vu5qi2XXOy687RwcfN113pGdY5WGv2q6jz+SgIcARF2KJ1XspxHNUQCV1GFRS5QEZ+dXojlNjODFAMKGwvlSv0bKXD42+f7ZmAukKbfp4+3v0X8nOEE8CqTX+ZwDSe6rJDd9gD1HpjrlsP1hapD2nbYEYgOPoT1TRu1DZGM1jj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=e9h7HaYl; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=WJkFP/IG; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GG0KoW3705263;
	Thu, 16 Oct 2025 17:33:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=lAnWTPUPzmONM
	tbRIapMi/bGv6w1kjV7s2kC8A1gGoM=; b=e9h7HaYlSfUmhRmsddUIS5p9gc/Pa
	DePRRd1vlE8J0KlSM3NPqlG+d54Mpp9ATrV+9Te8+XYveatufBNjibFZEaLb0rVO
	BjNgm1mWsCtZXtdbvIQLToPitKR91VBeJG2JWkUUVBgflZA/12OMENCh3pLhH5IY
	oGGlNiGLS8wN3sqNlh9Om9ZhA5Ahp0TZdt9GYCjZOrtvaFVXbHkklMiXX396IUX1
	qWuBercpYbWNfmCiba5sbZza0qHtsRocGY1mdzc88OUUKaNhM3YqwCDSqF5f9I1P
	o3VAS859PRl/EQ8IWcsRrN2gSmeLMMuYNojtHTi1EONn+5Y3UNAoCSC2w==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023140.outbound.protection.outlook.com [40.93.196.140])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49u3umh33n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 17:32:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/1Tw1532hy72J17Uh722bYB/8jNyQXniNyFCbfgxISCviZDIufkJ28KOWD4dLF1b5uAU0l1pDCy5T5P4hqZR0+mqtU/O776ZJnre7n8nk4dAqaf0QAPJ89bj++Xi3JdimuNVBq/XgJ2z25wO+Ia9VTNGwY2SC3RaIaSVcLTSH2TvbzREmkpEsx+yiq09HhB1jLoWdz/DoiJ7tN4sh6p4ArJcC7KI8IVdhCQruz5OpinPW43Un6ErAfuZcZfMjzhqwfKZH6e2HmtxQ+iW+KPeCPbEobRWopfyeoP9aB+DIHkqiSrNtnf256IBxkGTI7eZ/On8awveJo1UkG+Sr11Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAnWTPUPzmONMtbRIapMi/bGv6w1kjV7s2kC8A1gGoM=;
 b=puBOzGmiRAieIrjdC8QzezmmMLoYC6c12AI2MEsy8Wu1s7Kjjk1SHaoB7tRkDoD/AUwSocANnfaYvYm4AwuTAU2Y1b/Vgee7OoQx5zFQYEzBwGUeO309FPYneucZesxRXRGOhTODfZDbo/Y0aAMjb9WZYKMXhvm+E/RJZ/4in8tVp/XKBNn9YrSFqdRzHabUJdRZ1ZNWlkNd41IziR+LQC09/sD8VnRYraLCxnboxLsF19F6EqDpQD9ZuGl2B6ydJvJZ0rMszHcFDDP6XF+mpYEkc4af5sLxxk5bOsCnXHHTEduFDtoWx6CtycbsUjH+hX0vqv/jEW5Ok02s7zhyoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAnWTPUPzmONMtbRIapMi/bGv6w1kjV7s2kC8A1gGoM=;
 b=WJkFP/IGjQitPxnQpBnX2dRM01OLOA18F1J8sQYK+6cr2d7Oa2TFLbvxTh4cCS1to58LGHaj4Kz1Q0QF6I0qKT8K/a5ldcFTRk9DpnjUc5WePd7m12640XW9uv1eyHjacuzxqDu1VsK4/rahIbru1ztsRJVEuCCMHkHDLHQ7hJsGggk0APbnADD7iyGVzjBzoMCc7c0x6k8OwLKHtTUfR+XwTJaBmpBTuDFHHKXNlba9OHFKDEMaFiPEYNJf5J3HC/qL5LVJs/FfDkrzsh51OC2S7YGtgN+kXm1Tn/I8fo17rk63E8YK1tRV0wfchKbW8jOxIDTW81srylG1PR/qDQ==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by CO1PR02MB8602.namprd02.prod.outlook.com
 (2603:10b6:303:15d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 00:32:56 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%5]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 00:32:56 +0000
From: Jon Kohler <jon@nutanix.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
        Brendan Jackman <jackmanb@google.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH] x86/its: use Sapphire Rapids+ feature to opt out
Date: Thu, 16 Oct 2025 18:12:49 -0700
Message-ID: <20251017011253.2937710-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0069.namprd17.prod.outlook.com
 (2603:10b6:510:325::29) To LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR02MB10287:EE_|CO1PR02MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: 2362ec97-db35-4bf1-0c0b-08de0d14b774
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DG11LNFiDDhMbkK0Fvz1fI1LcxLPdncPGoT+jXKSC0Xnk2zdXo5B2w210ujc?=
 =?us-ascii?Q?UiMzGIfX1syIHBWHQFTobIlAJkVrI188WqaoIIfneq65gqgdGRMhPuy0i0V3?=
 =?us-ascii?Q?L5SA3S6ffDreXiPvRMt2NIZAngqUgM9X/ezfFMHl6PEh+Yt8LCEZ3Mo9o9Cw?=
 =?us-ascii?Q?b73sgUR5jN2iXSz2BdvrH5fuOf5GWP6pOJNA6f3wwU8xQonsn5EwW++evquT?=
 =?us-ascii?Q?f1MNpQNi9jDLkcapJcwFQyEKLHzrtsmfkZy3lkhtGhdvmtr1iBUsNMjcpwU3?=
 =?us-ascii?Q?yMRNNRWT9NMUSRpYVqL9TGxCQqIDVLR/andII/AzTGuv4N4xiI48ubKYujRG?=
 =?us-ascii?Q?8bls7doiVc1J5YuDRhGlZ3YLjnJNRqmKqvNfXzMHVAMIadFsv8GtDdNJHhie?=
 =?us-ascii?Q?oBwbKa5JB9C2IUiEVwVSOniwZjHY78AtcojLmi5Y7Yt7tdfO/eRZIy/Srum2?=
 =?us-ascii?Q?hxa1xrjhxenyN2BTzrWMCo1Fz0LtyfZbBqQCtULK8iGlVZLJ8Ru4kJaPzvQu?=
 =?us-ascii?Q?7fBEhJpanK92wBPVGLEF9o1VVy77OIKbUuI+0N1AXlCjhNy0njofC7z1nbHc?=
 =?us-ascii?Q?qQ6ZDjI1SamuWh0EETS/SlIHD1seR584azJDTFLfsfNIVrVv3NRE2pUS1Hgt?=
 =?us-ascii?Q?vykbPgmezEZV6XoAU49w595V+3I6My/hOl6L2C71ln1FYP7d8cHE1fCtqIuP?=
 =?us-ascii?Q?Wxky5JE50Ele7D7FF72T8Ry09o2oAtiagrWTEmw6pzQ91Cj9HnuDQlAt5IvW?=
 =?us-ascii?Q?iHy9PFj3m9S2OHVpomu5X33FTufkWaM8IMzcmq6vNIwPtnrzk4xqfa/7fzU7?=
 =?us-ascii?Q?BOYUdxlcE7NHWnnLNvPrkbrl1RaeVcOX+OeJLAT1JsSRUzjNR6kjEfM5Kdg8?=
 =?us-ascii?Q?+816BWu6SeE6rL23IGdjqCJKFEBCOBLMexTH0Ol5kL5stZc8DYp4Gp5Lper8?=
 =?us-ascii?Q?mImqnfmfJfO9Pngv24y2T5N9yRzEkPt2IFsrqfMSjG6S9c+SV9gW6acZ3T2D?=
 =?us-ascii?Q?f+QVCNHj8t3EwiVyCkiN5O8T5sJemi3IYzqfHmeszj04Rj17VWUUT7eDISuB?=
 =?us-ascii?Q?h2JjnQWjd77LQndQQxc5gKnT5KyY+8+2m1F9mGjqwNlmX/UTcSYAIUNHpHCZ?=
 =?us-ascii?Q?ftIo1v1AuuMllXkJ65GDTAFWB5DLupsitcYad3aZYBSUTyHBwsDm4k+h+msA?=
 =?us-ascii?Q?/SQjpS7IWjwA4cNSotvgSS0XUWATrMcmVdbaQRvz4Df6vEp/loGefZS4if1d?=
 =?us-ascii?Q?Qwo36ssmHU534AuxBhNI0XZ6kcS8vvPfZrClZum69TKDZDvQoIoREvbKOJZW?=
 =?us-ascii?Q?rE/iMR5o/qkOX1kvMfjuMHYchfaMdo4MGK7ufUVyd99wG3jphpU4n+tWxD3M?=
 =?us-ascii?Q?n0BJUOF0yT4K9ei3fI3BgvT/ch7hTQflyz1PcWBqr4CeqYK2WAbzr8He4CS0?=
 =?us-ascii?Q?rK9jT93LdVZiQHPg/IH6RBMiWDpeJjKzsW3PDPjuIul1CxvB4CQrig7WyDvS?=
 =?us-ascii?Q?AXihjjAJEO4A5X7Oi7UrYtE4lgu38162lnHiIPfPSkIFhp0nN9hiu0FBBQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xBWU6AaM5jbuh6fSmgAOlZqCn6OzrZ2Fba8n8r2IyBaFJ9QwnAuYDfpB9HHY?=
 =?us-ascii?Q?b9HkbhMCuaPvJmzB3lAB9z/BK0ufYdg3CrkzAtFDhXQOnQ/1PDznVmwr5ysw?=
 =?us-ascii?Q?N8ajr9RixdUxGzDtKpamXpEo8teXgLpUVl8aZicksK8x3ko5qk6RVGzQ6FgI?=
 =?us-ascii?Q?MT2Bpmw+6Sg8YT7WcBOhoKC6gdeK6dVmsXsS06MFcrCIVI+C6dZzpGJ8TrTk?=
 =?us-ascii?Q?LmkVe8e3B6xVKKQ/bQUA669DTcZxGOyE8sVZgeLFmXATu6LPbXExdnbj6dvk?=
 =?us-ascii?Q?67iEg/dZwLE24W46yGqJSPdh2jia4sJfoySuOXK8lFwMeRB91FYafLbszk0X?=
 =?us-ascii?Q?grSDfIWfN/RtWsr+QWKHsOKLaAAx3p5I305pTZcFVcNFQkJkfCpJWmP+KpPm?=
 =?us-ascii?Q?2czTCwgUoJvwTXBrmQAxF1ad/vrpBdGGY0iMvIEzztQYnthKcfuViQLQcSTe?=
 =?us-ascii?Q?rzA0hWSMCnQ6yUQGZEnUSi3ii9HFrLYWl7ZeYme8hF9FwMtPrzNE+VaKUcdR?=
 =?us-ascii?Q?GvVBF914EU/bN0ADej/KmbiViT6aJCvM2IzWoQhERuHJr0kPXGBbjKkGuNdk?=
 =?us-ascii?Q?mJAkrs4VsbweQ/yWN5e6zCporXuBFElb+5oXu5SX0Mea1Xk/RF8R5hAy9WZ7?=
 =?us-ascii?Q?rLX9IMHcbFbBGuLJZphTUvLmqUUmQNl795oH1+ars2ZfnieSbDyyLGsDHhXj?=
 =?us-ascii?Q?0j+J01aCMKrEFmApn7bifkrGq8fT9XnzPpD5rRVepKov2BrAjgZIq9CuHwu+?=
 =?us-ascii?Q?nGgEQc8nrfvyWizYYKGc+BGk25C/qMYlgrKiYIGfSm34GrxMrF23tl74c1p8?=
 =?us-ascii?Q?Wf9m/AGu0RAk1l2V5j+oLpbAPYNDA/9QpatS91kgS6sZWRrCF/LpSQYKGiL+?=
 =?us-ascii?Q?BIKHDAspjYnl4B2VhAsHnXH7wJTZ63KO1q4kl4FF8Im9HR//shNpvWygZ4cf?=
 =?us-ascii?Q?d7pXeroTUIhQ+4WAJQ1BquDhFcDIZvO9Co1uH7aMxPR8f9P8LkrWuNWViE2H?=
 =?us-ascii?Q?dzja/L2Xfk4yYOemtd3nJko/G7HMKd0ZYqB2ovhf0FYGUNGTqER5dYA7Wk/7?=
 =?us-ascii?Q?rVmDN1xYeVU/Q1XEOWzu5r7LaEat2CXp36PyJpEKIHC8XFu7PNZ5pk+PHanT?=
 =?us-ascii?Q?uGT9KHRXXufucDoTDjwWInKqqrV71AqyFV325XMgHIHazwUzw6ewbJ8WI1KQ?=
 =?us-ascii?Q?imJrjJ+++ftBgVqMWXhmFVIeFeGhSqR7L8/tAqZPQjKughhYNGKfaUNr3JNw?=
 =?us-ascii?Q?JuirpZe0I0lOOhL2hT7Ozf4sS6/XFPDjzNKp3blCVQLX3CEEyildjM3b1BY3?=
 =?us-ascii?Q?g4f3NUq06JNVjGumFfZkBCPki43/GgjWMniWhZzBTfB9jxziIsWvoy96N8+m?=
 =?us-ascii?Q?kzEFJ+7wXDwBF/Bw2g1PFVqw3yqdvFWVrbEeWIUiJ8L8LHwJT/lgrHw/+MOs?=
 =?us-ascii?Q?RxTPLCYDSKyVi346wd/Gk7YYWM8lzVRu/FRiKze6JD8fwIHgLZ2aMx2+iawX?=
 =?us-ascii?Q?6UeYPF2EaT1YKZC/JKPsj/ysvykyZHillNNbls8ioF6bbrBVIXaJNvH40XKg?=
 =?us-ascii?Q?OS9P5d2HqP5GGwNp7UBKRlcjefeg97GaEo0uqSou9j90w5V8vbXexfRYIl1E?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2362ec97-db35-4bf1-0c0b-08de0d14b774
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 00:32:56.4205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/KAFq7LaghgbXyLYFbjloRsz7i7ULqWmBGz6UPLzzQuCdpeFuw1ymg+qQKFmOf+XUyw8XiuF18ujhmcASsO53ybLGrvBZvXltmHft+QndQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8602
X-Authority-Analysis: v=2.4 cv=foDRpV4f c=1 sm=1 tr=0 ts=68f18ebb cx=c_pps
 a=qcfn1AlnsIIAWGxC+ugzFg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=64Cc0HZtAAAA:8
 a=sHQuVjOH8-NXzyl9kj0A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: To425BxAebEB3my_9nPWoJUiBZLguMQK
X-Proofpoint-ORIG-GUID: To425BxAebEB3my_9nPWoJUiBZLguMQK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDAwMiBTYWx0ZWRfX1n+ngu8ZLwdk
 HL8K1c9zjF4UtyxefiI72IWCfeWLQnMsgHOP1y5zkmkpdjfeCgOeYh6CZx92I9XZFw6Lgg5F8nF
 bxSaU1fx2MEnrj94VAC8yv1MV66jlgCREvIdgM9fJWIOfLx+f1N7oXvOXKQNMtvmyu+9P6whhtx
 a45PTW1qbErGe2lvy+THJWX+0v7029f4CPjtaL7pKkjqHM3lrbkyHTn1HreWCpK0vaOvBs0xMzE
 3Dtz8mEOPsxDlaRu1d9byD/zSn0CVxw93mmwrmV3tm0qq9O/G1qlc/XbUocvbeHzuSpE1CoDuDN
 PG0LXO5uuvRRVZOQkrcx4rT/WZIlZi6H9SKSDiLs2O9rLaX/r59b+3c5qmcTWB4kN2Uf8srsQRb
 /P+L3rhO2yyGx5JZo+swLzGjvHEkUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

A VMM may not expose ITS_NO or BHI_CTL, so guests cannot rely on those
bits to determine whether they might be migrated to ITS-affected
hardware. Rather than depending on a control that may be absent, detect
ITS-unaffected hosts via a CPU feature that is exclusive to Sapphire
Rapids and newer processors.

Use X86_FEATURE_BUS_LOCK_DETECT as the canary: it is present on
Sapphire Rapids+ parts and provides a reliable indicator that the guest
won't be moved to ITS-affected hardware. This avoids false negatives
caused by VMMs that omit ITS_NO or BHI_CTL. For example, QEMU added
bhi-ctrl only in v9.2.0 [1], well after adding the Sapphire Rapids
model in v8.0.0 [2].

[1] 10eaf9c0fb7 ("target/i386: Add more features enumerated by CPUID.7.2.EDX")
[2] 7eb061b06e9 ("i386: Add new CPU model SapphireRapids")

Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Fixes: 159013a7ca1 ("x86/its: Enumerate Indirect Target Selection (ITS) bug")
Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 .../admin-guide/hw-vuln/indirect-target-selection.rst       | 5 +++--
 arch/x86/kernel/cpu/common.c                                | 6 ++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/indirect-target-selection.rst b/Documentation/admin-guide/hw-vuln/indirect-target-selection.rst
index d9ca64108d23..3cfe4b9f9bd0 100644
--- a/Documentation/admin-guide/hw-vuln/indirect-target-selection.rst
+++ b/Documentation/admin-guide/hw-vuln/indirect-target-selection.rst
@@ -98,8 +98,9 @@ Mitigation in guests
 ^^^^^^^^^^^^^^^^^^^^
 All guests deploy ITS mitigation by default, irrespective of eIBRS enumeration
 and Family/Model of the guest. This is because eIBRS feature could be hidden
-from a guest. One exception to this is when a guest enumerates BHI_DIS_S, which
-indicates that the guest is running on an unaffected host.
+from a guest. One exception to this is when a guest enumerates BHI_DIS_S or
+BUS_LOCK_DETECT, either of which indicates that the guest is running on an
+unaffected host and would not be migratable to an affected host.
 
 To prevent guests from unnecessarily deploying the mitigation on unaffected
 platforms, Intel has defined ITS_NO bit(62) in MSR IA32_ARCH_CAPABILITIES. When
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c7d3512914ca..3de4b51d8681 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1361,9 +1361,11 @@ static bool __init vulnerable_to_its(u64 x86_arch_cap_msr)
 	/*
 	 * If a VMM did not expose ITS_NO, assume that a guest could
 	 * be running on a vulnerable hardware or may migrate to such
-	 * hardware.
+	 * hardware, except in the situation where the guest is presented
+	 * with a feature that only exists in non-vulnerable hardware.
 	 */
-	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR) ||
+	    boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
 		return true;
 
 	if (cpu_matches(cpu_vuln_blacklist, ITS))
-- 
2.43.0


