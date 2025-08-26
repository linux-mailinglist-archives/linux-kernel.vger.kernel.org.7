Return-Path: <linux-kernel+bounces-786906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE84B36DA6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F9BE7A8C85
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DA5262FDC;
	Tue, 26 Aug 2025 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ElQZhw3l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CWkABaRQ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024B426E14C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756221861; cv=fail; b=Lz57hmxqrbFT2Dbd0GQnTLGFUMS+VwpXP5eg/XcpEaXYQrJS4FGC2YTa9TiMM6DQ/e2Aif8VwIm/pCn1x1aC7JroQRTnRwiba2Poyy73SZOmvEX6Lll8IcJiU3cn5UV4MA5gzf6cV+DCSQgMSmYuFxDu0yDd+CcWuTQVO7q3iWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756221861; c=relaxed/simple;
	bh=ymQ3mJKpU/aUAb03uSgduiwUrGNgGRPbP5l1WkjUGjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rmm3iPSmvop7m7bzpvg4PPwiKR6pcrtclgOFBU/y5o+RvGnYrJqGYCKhgFAFB5Ckz2Eyg0yUflFr0kPGGUz6pu5fw2QLQC2uNY7bjzb+zDA7ZgcgEM/uWfQrqDNwt0uo34qeubxxxXjtE56Ptuj6l1vTiZQoNMnlg//Yzd90pao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ElQZhw3l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CWkABaRQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QFC5gv012214;
	Tue, 26 Aug 2025 15:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=qVv3zzYrAi8xX2MyVz
	eNG4s6TtPUsIVoT0gqjQH/UYE=; b=ElQZhw3lVyB8xq7kxid9rbjn1Jsp+PWPaq
	9AFcPqmKvJDgff1pIqNWlWW6BeNSFe9P7oaiBMF7xMKRTQeeKEIKcmBeMyeHXmlu
	FBQUwr1qFzyCiJ6NuMKDmpuL4EnUP8dWHfh32BTzvUWM23AL9jTt75thfOmKF0Oy
	hchN3znUIieCakVYHdLBpE7stgbn6xDea5JOd2BNbzwoYSEn3EnjGnE0OiEXRwQM
	TWx00pcaz+b5h7mSaMV/Bmu7G28nLjkAdXnwevYk+tatNd5bJ61lNx0di3tfpeJ/
	7zoCH0iMKpz3ibCyeQJsNLM1Pybrp6gX3C49ZXrgkT8yavUgTdAg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q48emrqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 15:24:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57QDsgdD005142;
	Tue, 26 Aug 2025 15:24:11 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q439ur43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 15:24:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6zWlT1jWB885HZd3wQ6yujKA4xoXWus5PX7jXc2I35W1yDy1xImUH9zV5cq82GWd6M3EgkQ5v5cDnbKPqUwYN/U74HGDN2auroI1vkMZnYibxewrycaItFqfCuy10bX3D00d/qmwELvs064E7+BqqPaZElMqtCrGSrKOXvB6hVgEV2qLBmd81yB2SaT2/5zYyglcEM5+8FT06zein8w3T4Dh2XIF9q0oKJtH5nEVx5rkxut1XVl4LPUaB7rggNM9pKN2V1UWBX1GTlQoIQvSlx0xlJz+TEkkb3nMI9WPGleUTnXWlbd1Hh9ZtDD4NdlOU8sm6Hk+5jAk25D2Xdj2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVv3zzYrAi8xX2MyVzeNG4s6TtPUsIVoT0gqjQH/UYE=;
 b=fZepZKKRzxxv6PsbTmBl3gI3xFKH5wAH5mOLgPbwsZ3h35bldYER3AgMlms7+7dHgyi+8F2WqNGB2Sun6NzKBvGlYTw9hlYkjAW6OgphRRtExh9GpLg0cKLfY6RUDFZ/X/5wTGPDpiYHBsluOLk/cR5voeXdBg4u2DAF+pgO4I/i5P+siuWbwbCEr2bN5WJJ21UwEoyY3aPYnxAK+u5nSGHz3rNMShq5QYRifPm63IVNtCcrMEq89KD4541E/Lu7VWt4TfYcoM09ap89U/RhryAuRtvP5rS5LIbaxAKoXirw2DFQdVXljOO5P3fR+mqJO7woefoq5KWF/mxoOedZnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVv3zzYrAi8xX2MyVzeNG4s6TtPUsIVoT0gqjQH/UYE=;
 b=CWkABaRQdVF0310kYw1RzUszJ0b7tiPPNBrrm3bJBu2f1axTnORI74ydhAt+ew2Co2O2EMvUBgg4A1abwiFxzL2KkUuLsqgTdHtPEj1lNUtlQw4tg8A8NMCILZ7uG5M0EN8N67WeG26itpgY1LYEpWD2TlTxLhTz0GmkqJiAzB4=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH0PR10MB5548.namprd10.prod.outlook.com (2603:10b6:510:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Tue, 26 Aug
 2025 15:24:09 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 15:24:09 +0000
Date: Tue, 26 Aug 2025 11:24:06 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        akpm@linux-foundation.org, willy@infradead.org
Subject: Re: [PATCH] maple_tree: fix MAPLE_PARENT_RANGE32 and parent pointer
 docs
Message-ID: <a3nqea7xewezigtvnan6okktz5l27p74fquqcyuxdgtbwvogew@kbrjh2yqsdzs>
References: <20250826151344.403286-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826151344.403286-1-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: MW4PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:303:6a::21) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH0PR10MB5548:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fdaa186-2c74-4e09-ff2c-08dde4b49a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x+Eixw7N/oN1qPhETajuAS6s3Txlde6+QOum7OadWUbcQNLDvg3hai7jU4sc?=
 =?us-ascii?Q?I3/HGDHbd5VvM/Fs3/GVoAFsidQ9dIA50If6y4OJJH9kjp1kadEP37DievhP?=
 =?us-ascii?Q?e+KpZJctzSaPgKG/VrWW4/oBBnFUZnoSsa3vhJ0E46eOUqhv7cvVAGxKX9sz?=
 =?us-ascii?Q?b6Txs0dIcsFcGhXfqSrBrqti+nv/iPSh3o66notudcEl+u/Qfawon2uR2y8G?=
 =?us-ascii?Q?MnZPMeyi4hzBJJWQ1qJZdzf9eUPZbG+R+pLb133CQcybbYV1WudAw6WPIbFr?=
 =?us-ascii?Q?vJAhFBTZer5qLQszXq3PVl9Y0MGXDTB/XrhkdURuD8pwjZk7cy86lDBNmjP5?=
 =?us-ascii?Q?jmMzgEpGQKIRwbEED0sB8A0AFRurQL9P3fcVrmrkN/bI0Ok1l+AcIJd076mJ?=
 =?us-ascii?Q?RD0Q7K17hXsPqe3XqaG0FHcDhxCtKaZkSodea1P4CKPZHs6KZ+x1TiS+5PI/?=
 =?us-ascii?Q?DXzTV/CxTTsUaoJnFYzgSnPVmRuLrCIf01LKaWnmp67JEmGLjS2JLaVbheOi?=
 =?us-ascii?Q?LglBoXTfmEE7ipROGbiypSWk2wKbURMtSdRgWi438Ly2ugsxX8faL/55yUe4?=
 =?us-ascii?Q?0Q6I8gDC/SNyVAojx81zCB/9JMuf1a147QvDPOJ+UN67AopbyQD2zUJmTORi?=
 =?us-ascii?Q?VszLSW1ZozFkZI0Ig0g0oaIWatmzwoizbYpRoAPa376Em3yzfe32n2LY4G1l?=
 =?us-ascii?Q?tWoUC7/z04qu9nhmk+TmZA1lkJlA++/EREhOISgb1dSWKbU7kOhPVA4YAJ0z?=
 =?us-ascii?Q?b9lzXtKsh1H+DS0VW2RJChbjQCUlAQrxcs5DQovmSh6DpQiVdhBbvD6+XIie?=
 =?us-ascii?Q?hm6/bN4jwfIr0043zYk+8lzVHMNsMndX2/TzQICN4f4uM/3F/vSv5FhdIqcC?=
 =?us-ascii?Q?vpDTZOzgBjKN3omvGHjWejbpf2Wx6Bm2ho7waKHwtxbeBhrCdVoNEOgDQOrp?=
 =?us-ascii?Q?dENg2gkSG0fnqqwH+VPpGapPivkCDcFGSP2c9y+cwxr8U2+1pMxviVNGbO/P?=
 =?us-ascii?Q?i/eqtiPM+1pyzLqsq6TVlCu6GRTYg/TC4YHLI2g8UdE8UjEkwgFdTDOEg6kO?=
 =?us-ascii?Q?ezmiM8wR5RMm7tAZ94jPGrE9Uw7At/ISMkmFNWozdPz0T+yShoneumR9XRTt?=
 =?us-ascii?Q?oRkyNvwHl8SP2/fMGzmRbtZrENR+AXTVNaYmpjAEkm81LoLskG02lQ4SLbSl?=
 =?us-ascii?Q?GGkhnJGbboQYugizQay0U+6xe8IMUKJbe2V7Dz588cAnFIda1EYT7ddM2XTk?=
 =?us-ascii?Q?fAsxs4RCHsnnRu5OskTScLywfctLvGz06O6iV5zXP1xD6Pp0/AfvIlLClPBs?=
 =?us-ascii?Q?omFJ26napYwR0WvjqeoPwBxGSd6BDEspSuAv8o/co8z1yY0/YAvryJMSVjpA?=
 =?us-ascii?Q?Nbaoo9mcRuLQKBzbrUSHHsyusoGPJhZOlDPoZ4O/xOEJ1ch5lGEuG/unjFcp?=
 =?us-ascii?Q?R4+PO0qQ7VE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lYue6y3dVU72Pen+xDj0lnWs6HmZCNJ5+N7v0PDs5mWXzKuI7j8q4rOxeXjK?=
 =?us-ascii?Q?OzROpHh4adyAkD9cKx/OlkMpp2nk4mKXuYoDW3iS1erHCgQpfeusRsq/NFFc?=
 =?us-ascii?Q?mdjEC8+P8A1aBKWZqbCiDDSVdXaxq1E2bATDv4BbKZ063PNtsk3zH/2FWM5Q?=
 =?us-ascii?Q?ZHVViPOEV4EHHXyRi0ecHAiryuFs0sf5AgqXb7kr8jm1Tst0NIVP5NpM18YG?=
 =?us-ascii?Q?Q4ZxEzoVeyCBB8aLGEhiIe6ul7sKuoaaf3dXDj0GXYJZn1JnbRLW0nH2OS55?=
 =?us-ascii?Q?z1DHlLll9J1OJz/9P/GzAca6vK0z4LM0roejYB3u0nHw6nFdJuR9xoa3euPQ?=
 =?us-ascii?Q?Dcsl37EhiqDRtEpKOUWWiImz8rA9dvnpc0NujesxdY40ml1ukKuTxzKp21gN?=
 =?us-ascii?Q?W9XCv/+yHj0k9TZEHrvtLlEp8c6s0TQc72tYXpt87yWp8oJtH/aXYYid5iHG?=
 =?us-ascii?Q?3y9g/UH6RYHPMDULnYAGaH5LDQNs3/iE0GBLCXInxjmQT5TCiZN/00KQCDJs?=
 =?us-ascii?Q?2bRXsqymUhZmz1Rf+QiB/NpChOd4/dLoCb2ywlXuhdtj69kzxWu+akrxzIiN?=
 =?us-ascii?Q?mKqfre/xt1L6c/j2qxMVizWhNjGRtHZVK9SmNAOJflmyG9GziPU0JDXlUAF9?=
 =?us-ascii?Q?4TWlPC1TWWuv9IZqM8/Nbjfu5PTl7QquQ0cCYrnci3EBEj7/eJGJOb/f8Pi/?=
 =?us-ascii?Q?vR6WRn0/PuwldNcTOatZV5n3noCR2x/r2dyI1+Ycosi2nautOW0rTYWbKpd9?=
 =?us-ascii?Q?UO/h9GoWPCuyGJshmuaThSWbPhNI3OIg4ZLj/Rff3LL7Q7MQOI5oLXVU6LHA?=
 =?us-ascii?Q?5CKKmp7GpTmgHPvFrLHith6FBTT2qTvgft8fUuAKcgY8J1PIzVoFBwteMaow?=
 =?us-ascii?Q?8smL0x4DLR6avOXwSQ3709yQN1NeYTb3hpgUITtwMg4JeVYIoyMlp/2/9+fV?=
 =?us-ascii?Q?oFXjasy9lJio1G/bjkgJvb6CKxW5Al2zG0hRImrz8uUCqeHKP6BpqLJcQ210?=
 =?us-ascii?Q?3ZWbSuYlXWwrkClgkPa78WEuMFc6W2JPUHN3aSbIgeHdSCOGooWkmDn8Vb09?=
 =?us-ascii?Q?Bt9h6rttrX7TBj7Bg8OjVDU1nw8dOuszVayR1ykh7/bcNcQHm44i8gYf0+30?=
 =?us-ascii?Q?jcj1qJW4NPUDCALy5tlhZ0QYIlm9s4WnqYF2tE+RK2K0+beT9TNfrU3+XSnl?=
 =?us-ascii?Q?yfK4C1T70kIOM9MBuiPcPEhRHAs9dhlYafk9fP++HFrYDxD7O5iObF4seteG?=
 =?us-ascii?Q?PeHzZyLeVcs40bKBoVAD6k3qxHzNctUK7kL8fGvndh8XB6Y1g1raSATNeQWr?=
 =?us-ascii?Q?edC1YXb3Z852Z6aHmYFANXbHDDuXzKtLTQpxS8sr2nXQ/SoOVYpwAvWWBo8k?=
 =?us-ascii?Q?l8tLC/9zmhP3m6LCUabgtA4o7Gca7r4GDUDiIzPFapOI6J6Se31UgMQ851ZE?=
 =?us-ascii?Q?432FBGrh/nvuFXJ3ZtFeUH4eNhN9AOxtNp4phhUv5flAxeGOMSIaWC1O+nPF?=
 =?us-ascii?Q?aPfLdaU/V6tDOPZLFJGGAeXUYxRC+0wTPdB+i4Ppi8ZcdDgEI9U9nf39/VEX?=
 =?us-ascii?Q?d5oPR8pkDEg+o3yiEkwM43xB7phzKydWJXlLl2Q0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d41MCRjFYRy+gUS5kk4fenJj0kPUzf7nf9MU+x0OrryNNpdtkVx3APT0W/++w3nKBKNUuOccJfk13L3srj4wMseyI7bIsug5KX5yfyAFl+jfFf3f9I6X59GRcTr7f7l7lTPHfYs/uCVS8Ruqrjvc3BPuN9ayOtCXVteoo5uw+tJ3aALJaSW1o7H5/3My1kVcGB8j027PIY7nlCDqkH9Ka0Vo6123GlFHXGPvgpb/UgYTKeIYIPqtZi+QWxTm7MXFZkbuVXnFwv8v983rePQ4Spgnyq5Mx4orEVdcIMpxjNtoVdEbZ8QF6/qiKA419Jew7H4GaQqWG/CgQekr7vQRheNICX8u1cNH8fySKiPIKZRvLFRdUi7bNT+1M9dNZlt8WmbvAKxxaVYQRQLDJqye89428W1Jh+gkM8KJi1kNXWNcat9FchV3FGR4LVKDqzoe35Rp6ctniuqJrxtti9R5FOF6uwkz2iGAYQ0zmrGqEqqUlS7AwgUeVdswBg+dP7M4GGLDl8+v36yRM5bGAahGTxHB8y2TRmBFQt8ho9sDMVgIyiUjw3kEL9gbzgQTg87eFvIyIbfimOZWu38ctwGlfZsnpPyE8inZ5ZuYQG9KbrU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdaa186-2c74-4e09-ff2c-08dde4b49a5e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 15:24:09.3271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCQZ4k1Davygk5ezEI8ieldRIyTYXOYmXQtSLYtbJRy/bZAjN85gbSWF0RElTx/t/ssCLGo8BWA1Gj/CkLMUpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5548
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508260135
X-Proofpoint-GUID: 1awVEf6AG0iAHQPAXzWrFBc3E9UDBTet
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNCBTYWx0ZWRfX/XMSDaENeAjQ
 bFlLMu075Tct9IN68Z3ooeWcsn7xPbS/8hpTksqRB8+XZ00V3++EkkBIwX8aE7ao9ZvC56YmrCt
 +YtIppUJJvZtIFRELty46x1VWG4UsjExrL/gQ+vDUFKZg8dTvRY/l4LwE8l1ItyekwW7b6GiERo
 lrKXg0JgF1nKljME2hP4FCK71+z7A5CKCdzssgsCtEF9kc08nlTJeNEAhp7AwDVaYUcfGLCis2r
 IRM74guagCSnzoH2mxSBdqrvckVLWP8FG0t5nz6xJUdrakCoUULYOxccYFGBa21gdWVHJzl6BDK
 Cv2vWMTko5Jh3WwerhyvHojFdIOVp5kXoHQSaDZ0UbTGrZi9ZBiWELItF2O1axGPXYn6qclvCfx
 aHhkBx71
X-Authority-Analysis: v=2.4 cv=FtgF/3rq c=1 sm=1 tr=0 ts=68add19c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=3aWWk13lahmSCGHIah4A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 1awVEf6AG0iAHQPAXzWrFBc3E9UDBTet

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [250826 11:13]:
> MAPLE_PARENT_RANGE32 should be 0x02 as a 32 bit node is
> indicated by the bit pattern 0b010 which is the hex value 0x02.
> There are no users currently, so there is no associated bug with this
> wrong value.
> 
> Fix typo Note -> Node and replace x with b to indicate binary
> values.
> 
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Thanks!

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/maple_tree.h | 16 ++++++++--------
>  lib/maple_tree.c           | 12 ++++++------
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index bafe143b1f78..41e633264e51 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -57,17 +57,17 @@
>   * MT_FLAGS_ALLOC_RANGE flag.
>   *
>   *  Node types:
> - *   0x??1 = Root
> - *   0x?00 = 16 bit nodes
> - *   0x010 = 32 bit nodes
> - *   0x110 = 64 bit nodes
> + *   0b??1 = Root
> + *   0b?00 = 16 bit nodes
> + *   0b010 = 32 bit nodes
> + *   0b110 = 64 bit nodes
>   *
>   *  Slot size and location in the parent pointer:
>   *   type  : slot location
> - *   0x??1 : Root
> - *   0x?00 : 16 bit values, type in 0-1, slot in 2-6
> - *   0x010 : 32 bit values, type in 0-2, slot in 3-6
> - *   0x110 : 64 bit values, type in 0-2, slot in 3-6
> + *   0b??1 : Root
> + *   0b?00 : 16 bit values, type in 0-1, slot in 2-6
> + *   0b010 : 32 bit values, type in 0-2, slot in 3-6
> + *   0b110 : 64 bit values, type in 0-2, slot in 3-6
>   */
>  
>  /*
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 38fb68c08291..d1d513bb6e95 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -405,11 +405,11 @@ static __always_inline bool mt_is_alloc(struct maple_tree *mt)
>   * a reuse of the last bit in the node type.  This is possible by using bit 1 to
>   * indicate if bit 2 is part of the type or the slot.
>   *
> - * Note types:
> - *  0x??1 = Root
> - *  0x?00 = 16 bit nodes
> - *  0x010 = 32 bit nodes
> - *  0x110 = 64 bit nodes
> + * Node types:
> + *  0b??1 = Root
> + *  0b?00 = 16 bit nodes
> + *  0b010 = 32 bit nodes
> + *  0b110 = 64 bit nodes
>   *
>   * Slot size and alignment
>   *  0b??1 : Root
> @@ -427,7 +427,7 @@ static __always_inline bool mt_is_alloc(struct maple_tree *mt)
>  #define MAPLE_PARENT_16B_SLOT_MASK	0xFC
>  
>  #define MAPLE_PARENT_RANGE64		0x06
> -#define MAPLE_PARENT_RANGE32		0x04
> +#define MAPLE_PARENT_RANGE32		0x02
>  #define MAPLE_PARENT_NOT_RANGE16	0x02
>  
>  /*
> -- 
> 2.43.0
> 

