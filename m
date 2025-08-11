Return-Path: <linux-kernel+bounces-762660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8915B20970
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E83F17B60B1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095132D3ED2;
	Mon, 11 Aug 2025 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i8goyjQY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pfQ7njCR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530A2171D2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916983; cv=fail; b=LullOiRNG4Wl99EkOfXlkDUdmRpOR4Bw2CWeZ9cdDwyeBmj3hO4U2K5+MOEFa20PEs9Y6KRny8h3+l8QHhSzNz+cOFoMShMcBMDTRmGPUAyofo096Zj5+IV44eDGkCmJy33weAFVZE9yi8wDngetE3Sg8KaIEK4TaxKclM9Y2I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916983; c=relaxed/simple;
	bh=3syIs9+C1ewekFaz9WbACfVz6T/n7MK57pxxEuLawfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H4NSFKWF3gy4GyW6XMi3JHZgcSQ9zLTPQE/U4BXwr+EeTS9NBCWTDgmOzebM3LQP8cdhZ1z2+cAApVlLYrOzeIPeR0dNxaPvoMeiTjPBjiOrViOZDwCGHrHcd0/PHriueqXTLFBZALU05UVaW3a7a8NhcZqVOAwsqsnQwp6WAVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i8goyjQY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pfQ7njCR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B5uENv004947;
	Mon, 11 Aug 2025 12:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Cox8LcO0PlU784qQim
	d4EJTRyIYg8hQ94mAYxnp3YCg=; b=i8goyjQY9EJg+LAI5RbDb0qEp/u/L8qMTx
	b5z6K0swWJiyPw43hqiCPTazRWz+ZmUH3rF2grIPFBnZcNAO0jIh9aVMYKMHzf8I
	mJv35IOXqMfUUD2lVutop6Pw6zXMHn0olr0u5myAG820JVC+qX+BV0mxF/d7gzwo
	HXAM5ytOIkz7HKq7hgzqw/vhCBggLrpUL2IOKfqLixlAI0dRSoUEyhRESjfMZLrl
	OC8hjQqR2dILnPXoeIHX53cneujwvWJh/lp8Tb6XCY97f3J7rcRMdo3CyrE+fRhO
	MqhPMAupd6nMJAqFOXpikY8u1pQw1oyZnhzNC3HLyZj+iFgKfVWg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx4afp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 12:56:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57BApDAh030076;
	Mon, 11 Aug 2025 12:55:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs8kkf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 12:55:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIVyFMguP1nDp7/jOL4R3OToVn7jGKWu+HGiM3cBoKA95AHLHfE2yj9WQIkCXllyT/ybqjhjZOfYjIaseGsSH514v2n54effuw8ntKqpgCicDLoQ42aVfBZw4rCv+foo/hG1BAcdvp+3uHYUjW0Uigt5zTGcsaT7BWzVocHRbNIKbuwbcSdpRlYfP1bdFj5kD93ivJJPVR0m8IN3llIt/3+WpRZctJAaAZDQ1M0+YnzwJiwVTKEaw0L8K8Um208VYS8sE9LaeQBk9f475TdGLBq9coVj5GPz2SaLpnI2rvTdKbVvF6HXmhK8skTX0sMgREgKQKoagCUdXVRpBrNmMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cox8LcO0PlU784qQimd4EJTRyIYg8hQ94mAYxnp3YCg=;
 b=XYThkA6+71GrKQYYLnmsZGw2y2ZlsV0shbKgD8mEQp7Qn/sWGJvxwbj0CS83D0UBFCFmUgb8UgKJ1q+D0RjpJunDCuQEuTrEfOa13NrVwElL/lph23AN2cJmUa5EY5HBPAVhEymh/03jIQYopgrXkKU3Qzxl79eliYQNQkSDv9xfeFL9TxQKtIEn01cSQmM2hkT5xJzOCGbPWZSVxjIj3QKdHNHteA4H5FTOslOg5i8mr4BNis/syzCLTwDVz+8PDejm30ybV9Tk/lY7XYOrDiCSsj27F396t29CTt/uZQZHC5eWzMNoDo+Bv5f0MLVNA4+IdH2vpbahG4tBUGkHKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cox8LcO0PlU784qQimd4EJTRyIYg8hQ94mAYxnp3YCg=;
 b=pfQ7njCRWWeIv70OVu1lLdM6lZBLXwMPGWbXWuonjuQ0eBgCbRUhpy+8ZReX0f1f7sLiGkolRmeqg70wiYgMKAwEdUbVMN+9paZaQXg3N1FNYi2EmoQC8fm5PW9gGwlddTrjfPzO2sngVeAoXiuvcv2CVQuG8wSk4TstpHX41zU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPF20A8CDC0B.namprd10.prod.outlook.com (2603:10b6:f:fc00::d10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 12:55:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 12:55:48 +0000
Date: Mon, 11 Aug 2025 13:55:46 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kees Cook <kees@kernel.org>
Subject: Re: [patch V2 RESEND 1/6] perf/core: Remove redundant condition for
 AUX buffer size
Message-ID: <3e54b0fd-1720-4dfa-9456-fc4ade7261d1@lucifer.local>
References: <20250811123458.050061356@linutronix.de>
 <20250811123609.476196370@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811123609.476196370@linutronix.de>
X-ClientProxiedBy: MM0P280CA0056.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::29) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPF20A8CDC0B:EE_
X-MS-Office365-Filtering-Correlation-Id: be98d5bd-6a55-49b4-78b1-08ddd8d6650a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v9OVkF/UFRZN8gbXByp4m6M2e7xf2A8dOjIt7gnX1aWhmKo+DIhHXFgRqmg6?=
 =?us-ascii?Q?DlYrAp32Ly5v3B9j5fEU8bECLt8lJQGYXbBX/XiUtlG1ItNwv+whxJR1CRTJ?=
 =?us-ascii?Q?V1wdfEtfH4A26Unok3AqD6zI3a/0V5F5X1D3kApWbnK0TGas8NyqDEnlr+xg?=
 =?us-ascii?Q?DHRn2HEboT16XgWvIGw2btgZd3B+pZ91nqLZ3f85CCXj/r336dXRoKDw+hxr?=
 =?us-ascii?Q?dJLK7UucF3a69Zfzm/BwRBsRtj0TZDdqQj1e8O5JqtzoTGo3YruYmSPEZPtY?=
 =?us-ascii?Q?IaSsKXIAsDIAU3x16jBwRBsyijSjfSsPGiNatRuBmekMs0C3JlexlwAXWWjf?=
 =?us-ascii?Q?ap1HUwNyQ3nZg/QzcQtgGnfEqh2CZMoVmSaoF7MBHMmxpTSc3UP3swyiSI/H?=
 =?us-ascii?Q?UcIP7s1HhxbPYdkXA2m8jTcUk8z8c49/ZzPCIHPLHngT0OjXt9GIYWk/rlSi?=
 =?us-ascii?Q?7xma0+9kFKmzQS9lMt6Q0/u6BiHJL98m5xHz0qv+357CsPoN15lJCb8E1Q10?=
 =?us-ascii?Q?/Inwv1WCLj0cbHk9qa4/eH0znbKF4NIFRB0gdaZa1PXzHVDbWffj766Vuj+G?=
 =?us-ascii?Q?N7g7Tf2grDwXPPFZ9HvB6x5le8k+0oZW9wkNP6T30IhlXy9wySNxat0uWtsc?=
 =?us-ascii?Q?okGCAv9NMa44KBaltUUnawj5rTguM2ct7Y3GajJ11JwWqRYdlaWOUf6OcIGC?=
 =?us-ascii?Q?QEnjoMABRhneLJOWWBvfG4Zj+6mDV3+IGUfMdEAwaVye4mIkCO3gLnE+klvN?=
 =?us-ascii?Q?fiRuDjcK13izPO402VnVGJ+7WHOoqY0R9WRIes56o+PNYOeqL+dvNxVzdcrT?=
 =?us-ascii?Q?v4AiMr3QXaKbkVv4yeT2xYlwlMIb8sd0jiDZcNpR9ggAk3aMlCXDTg3w25KM?=
 =?us-ascii?Q?AtgX+dIIofC2BP16AmrNIQkZKktlbnrMZFLkSdkNTwbZLSRvFX90yUGGa2X9?=
 =?us-ascii?Q?3lCAHm6xyvJF0P41Azx8yB8p5RDolqLC1UJ7sFqibEAxHAvrXNH0clqK2RUU?=
 =?us-ascii?Q?nLgafX8U63bLQqz1BPus6Iit0sONsqsOVJnL1JisB88RnFAYgt1vWozN6y89?=
 =?us-ascii?Q?dr+La58CG1b1+gpo3wI30B93mxKAZTagTOll/bsJaXaLnVwIruYGOt40yWxF?=
 =?us-ascii?Q?3ZuC8FCFnfP1juqcnFA/aC6CoZQMQCIpv0b3EiHPiCm3K0MwYHplRz4pDhxX?=
 =?us-ascii?Q?X01s3Rk+Thipeg22FXXCgnGENTiSH3TKd+fCfPRzjWKDl3FX3eDbw+uQ0pBV?=
 =?us-ascii?Q?DQodP8aua+WYXj7F2Qnq5f2rGD62sozhudA96UjQT5olhAtkiH0neneSh1Mx?=
 =?us-ascii?Q?eGMx3C0XRS7dUmD3UQHlhqZ3nn9XG2cIxveTluw4hPhjhqmyIWYcx69AU4c8?=
 =?us-ascii?Q?HNlwvjT18FPTucbnU8h6VsqIN8ePnR4OrxwMY7OnPZcNkkAwGzWmpjS4f19v?=
 =?us-ascii?Q?Vknt+eIR8Ro=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7XfnJHl0BuOeGFmavQ1bWNSyfVBHoCakSuDHrBZm6zmZN3zc5pRD9bgZsgcD?=
 =?us-ascii?Q?fVfRXaT5wPF7G+8FBx7nKRgA1hCjUj0NoTurinueYaZpGHLfaZYMh2asF94t?=
 =?us-ascii?Q?1NAeG37JnYadyvPxn99sHosQDNAYiNNzcvqhoaL/IisXaJ9454DpVfQsYFUE?=
 =?us-ascii?Q?WuSu/3dbU9HLJISGRuHHC7kLwtPUYoFA+khjLy2HDwvd8xKa24EyNAfkzBe1?=
 =?us-ascii?Q?I5qMt2bDY772T1Dn0rkudAtTp9j+jhxp7F7+vNjK+ks3QRP73Tg8p15evzPE?=
 =?us-ascii?Q?HexT5uHjC/OscWODF02qLt0dY6w1dYZ/ueBIjdt/w8cyj4JVmw/pOfVylwNy?=
 =?us-ascii?Q?V0YI1oTo7W8rXMwQPuVmqpekF6S2Ii58nod7xqdnDDUAUPTutGSLTxZ4dl2C?=
 =?us-ascii?Q?j38GKGfpM41R9Tsb46RN3QjESaCS80OcE2p8sflP6ScwNPYEcDBCe929u91D?=
 =?us-ascii?Q?BE0xIUBHFCiQsAFBQ+Wk0vzDzInUQswveVJG1Yq96v26J6jvEL/Zh57XFCSi?=
 =?us-ascii?Q?SpaqmaiALoMladnrsSMGNAEn2BYSp4DPdcVaISnMLG0NLOACDeoYqsWfTHHK?=
 =?us-ascii?Q?XZbx+eAxQjikR2/IFbGcLplJESRPf5v1YtDBBp2+TkdVVOLpbvGRTPfDvbuO?=
 =?us-ascii?Q?2edngPwnzIcJtiZf5kLze9TaMiwrJ2w5uEZ43ShaQGuOSK/uVqxvb4RbJ+aP?=
 =?us-ascii?Q?6beOyhD7RC8EC8P83lcoqiH1PRtrJwUhcIvRPYvOilhEPgWLOcXYXT6XbpPF?=
 =?us-ascii?Q?9t4XRi3Lcbi0RnPEN7s6l++J9vuUbxDIZl45IFrluwNwOuvYHtl05AWSDTxg?=
 =?us-ascii?Q?oVy/d1ph/Tle32sm+hKBZs0tzXXbqpT7fiBjq6p5EIqTTczV9rHtVuVjlgA9?=
 =?us-ascii?Q?KrkCq4sqRXdhDfN7fDeZtJFcTB/Jm38ty3a2Gt3epJQk0qOa93qxu2YGt3mI?=
 =?us-ascii?Q?dKB/lU7Ph3s4M4UjNu21ka5XfeBVLH7A3vjg5NnhIuFxefOYYIbQ6tfl9EeF?=
 =?us-ascii?Q?u3pESbk5BzI1cW/k3EIMU5vEfjNzFLBbPHu/ILNbRVWS6Lm5mhX2eihyE/XZ?=
 =?us-ascii?Q?BYhVcTb7jbsm63Nms5r1rJ8H0ofTjtUjwdTabATIasTUCBOvzuYpK16rhh35?=
 =?us-ascii?Q?nzASh+go+Qf7Vlm7XflpM1uPvhgpZdCGkFq69Nfm9npQim8WcDYdmF54ruXt?=
 =?us-ascii?Q?J7cm3u2PqyhNRhG1bcaRlnEzuVmAx6bIoJ0hD4GiXO/AUliYvSiOxNwyw4Po?=
 =?us-ascii?Q?LYfJ6dEt4N42U2LY5q8XXbyttozbv5WNj8DE60aF9VdKHTVHB4S4gKCBtajV?=
 =?us-ascii?Q?iQ4pFjLU1bObjFGW82OSpy2bTaJXXin0x/kKplR1NxcFG32KcCjpp734et4M?=
 =?us-ascii?Q?xqpKpP/SzDHEouoTpEaNsQuNfn84XUv7nQZi593WeCA4hRvKJnr7YyEIh8k6?=
 =?us-ascii?Q?2/wK6xNFmxHtwOq61ytn3N9iPu052JziZ1bvzpMw+U90bkO8EhlURsI2wvis?=
 =?us-ascii?Q?7cVGlhjgeAyvjlvIjgCnJLhP09ptVfMLleRw2YEDkhEUsM4DGgt+JbejIFwI?=
 =?us-ascii?Q?H/tmeK0Ofe5DbnQ68n7lQABGRDx3g9pIqloeU0o2Y4iBl7IT+5DD64mH8JH/?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xKxLAvxKLDeIt13/Gh03glqSa7FcUNsBFV+dhav2SNVcwSeN46UhogF6NfVLTaFHkbuhYupkNktHIaPfUDfv6mneXPZhJuGI195avgQSDbFf3c+tT/YKmucz2AuZ4NTraVOMpMcReE++dTxqeglZciNvR9HPRYEq8qHDG9R03e8Kp/U3/DQ3ES566/xedF/JAAYAvICPCmi+usrTAAc5L0Nys9MWO82dZNiwv9Fyxx9a1z3GWFQrOgj3U+HUnV39vRRJC4y3gCAHJNev7Cc2WQ8LsdWiYRPgZmUrreSRudbRTUmNu43SsEC0X+VlrkbGfKvnhCRzqWEcG4lDjSAxC4MN/HaDEN5/NozPS67owQWkZPa1rxycP4tYkH17CpC9exRNHmH+ea/HycYIktK9DRB+e3HwEKQtUHRyi/Y89ONnpA6q7WzO6LjehuAayp4Kats4pvp8/HdTnFWSic8B0ojVRz1W7QdYOtmLlrE+nZgnmSlk6Rqkm/WZPz/PuFvds/YA5/JiBWbmxrsZVaLhSeFFXAk4KjnMaj5SoC48lbKHLoYBFMd7ce0ZQRZidql3bcnnGsO+N9E+Rki3wF+bfnjn8tkJ0KeNUpX0taV58g0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be98d5bd-6a55-49b4-78b1-08ddd8d6650a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:55:48.7074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3sjjmXwIYNJlWS1ZhlKQiPvwSjuQ7Su//1xZOUWmp17vWBo5Cf4FkD61IZ00STyw3lyvGrubAhQydNek/OXHn9mlFAD2gn6cUePwJWzkNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF20A8CDC0B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508110083
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA4NCBTYWx0ZWRfX2B8NHyOMP7lc
 LqGGuxJeqdXabFO5nwJfo8arivuN/GjZQ5e/NSoYJHdMl7TzNe3fN37tR+PgER97C1Rw6mvoXhH
 uIkVue4BK5Vj0g/37zalXi75yYqvYhrGQZkOG8tpFS8Jt6XCpDL5+i4WWlpN0wZzi422rPYg813
 QPDxj65KKUqHoBdKagUF7UE33eb2tICCYBjoRIKfXV7yCA3UJhWhUxhFXzpbwgvasTASZPIsISS
 Jat+y8yeveevObraAb7hjO752suZhlGkZAsxDO7Zi9e5F0dRPUlbEFCsKHjsYIipS0JhSoT4gDK
 9xMQ5cbeOGBIKML0dm+9Z5xgKBmqejCII7k1Utewk2WHq5jRQJZSeggpEjECntD7Vh3PUOBdX+0
 gwFD+NCVFphiSDEfZfuvelJDBWbeJbw5dyb6FM140iG5fns1yJa87WBgIFrmhDJrJEqhrZZ0
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=6899e868 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Nbx5DxAGqteFDgi-yIIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: ekBK53ISPOoM2SLatIAW0nUgdD0l41s-
X-Proofpoint-ORIG-GUID: ekBK53ISPOoM2SLatIAW0nUgdD0l41s-

On Mon, Aug 11, 2025 at 02:36:28PM +0200, Thomas Gleixner wrote:
> It is already checked whether the VMA size is the same as
> nr_pages * PAGE_SIZE, so later checking both:
>
>       aux_size == vma_size && aux_size == nr_pages * PAGE_SIZE
>
> is redundant. Remove the vma_size check as nr_pages is what is actually
> used in the allocation function. That prepares for splitting out the buffer
> allocation into seperate functions, so that only nr_pages needs to be

NIT: seperate -> separate.

> handed in.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> ---
>  kernel/events/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7043,7 +7043,7 @@ static int perf_mmap(struct file *file,
>  		if (rb_has_aux(rb) && rb->aux_pgoff != vma->vm_pgoff)
>  			goto aux_unlock;
>
> -		if (aux_size != vma_size || aux_size != nr_pages * PAGE_SIZE)
> +		if (aux_size != nr_pages * PAGE_SIZE)
>  			goto aux_unlock;
>
>  		/* already mapped with a different size */
>
>
>

