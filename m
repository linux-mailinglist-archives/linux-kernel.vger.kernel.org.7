Return-Path: <linux-kernel+bounces-741374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C198B0E359
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9311E3A6E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC9127F4D4;
	Tue, 22 Jul 2025 18:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="noP7DL9a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z/+aqtjg"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A7D26056D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208329; cv=fail; b=nkCNT0bHYFEis8TXUd2pDpEK0XCK/YKiyVfIuY17JuLsEpuFDpkTkAAZdtcSBx3hagjE8h7871CJXdpdbfeV4Tk8SuDjRV2TAsth8IZPtYKBzFRk4BP4yn2O+6L4sZHnn1sf72UJXpwpeccSdi7cVnzu6Q6rad7zA4e0L2DmytQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208329; c=relaxed/simple;
	bh=GBgFxdsceBqmoru6JJC+Sf3ovhPmGBYnIRZeP/FRQek=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DcXQu65anb8NvrBFjI9a1BDVI8PoNHK7c1KxyTOwLdiFrnXUvokA2UoZ7Z0LTcaXSnN/KjuUFKVOMMoKtoDh7S9m9Rn2zt3WwJ0udIgL7KEgp6akktxH/VXhHtqbt0eycdDhXyR8JTfc/npIkvOzbEYbjOORbJ525lj2+6+OFM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=noP7DL9a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z/+aqtjg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MFXlMf005736;
	Tue, 22 Jul 2025 18:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=EJ3zXY6tz34sSCUk
	hXGXX5Qt+HP1VJ0pc/zwAWv/1V0=; b=noP7DL9aGXGkwH5766CLyxBYE+VIUtNs
	4A7oWPLt/l/sVvwysnKlXTv5eKluLCnjk5I5GhIFLZbbDkNSxBH8sK+OpNU4N67P
	9zbjrUwqkGitNNvElspTTFDds5+N65CAz4KDD4BwQ49hZ3eMO4sivUNzKjGv3QIr
	VS8RLM1F2zdAE3Tj3GIuG/OuQHcWqojlYYJ34jSkobmswrcBHLUsS/S1dfUYJciJ
	3AOEfiSj8uely7BG8l8ygMzC1mOxwHbpQQc3TcFYmKGHv4vliLzkV7hdk+7UOhxD
	qSbtK6dsjS9gRO8ltj6FbZTW4yKysehP8L8SiN3bCFcebyxWL6LSlQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e2dwnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 18:18:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56MHENvf011001;
	Tue, 22 Jul 2025 18:18:37 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t9mydu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 18:18:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFFMWQuVmUso+wey41G6vN9X9bDkP9QYaawUKyY1AICzvheEqJ6Zzcxp/E3WdD9t1kfhjx7XinXIIDjfjPq3vdEg3vILP/NYKkaoaLGk4vVgbI0Rii24xOyooWyAWVR4LqY5HFgPqsZemxehg6kTS1khAbQwbC6FRwH0keC/tWaaWPPzDoqc42ryFXvXCZqhTTIbfdqXrxMv2PvDqONM1bVdIivIVrS2NYvkw2IQCeSFR1KxB8fVbBPOc1v4BTuTrctx/S0KbJyVsyntoWNRbgv8NaouJto9r8qQkTjn2tWsh/ZI1E1EC8Zbql4iEtsE80Dc9lZgZ2CbGjee//vdQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJ3zXY6tz34sSCUkhXGXX5Qt+HP1VJ0pc/zwAWv/1V0=;
 b=qmWZexcsHQMI0UZ+TSxcbR9TbwVAMQ4k/8qdryRL/q4moPh2W3/xazXbUV+Ah503QSqPccuEIyxGnwBkRP8jEu7ADZmpwA0AqvTqOWeZdCY/g5orZ2SN3z1C3LfrSJYP+sK7zLyYR1uK/5BN4RF8cahrCQEgOyPkQ8UwY1kl45Y787HE4jgSO/omMXV0YPNvSsB+FWyj1lXMt2uzT7kWjlM0Fg4dIxkNKtEvPhMkfQ90RaO2ZyQ6ByqlQTBJ9LLjRrjuItk/zzulIs//IodgLDjPCRHmJeNgsd2VJ18NtezuONfL9NuAJjpbu7Pg7j9uH65fxXtgiJ6q7M73Yqy89w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJ3zXY6tz34sSCUkhXGXX5Qt+HP1VJ0pc/zwAWv/1V0=;
 b=z/+aqtjgTKepXJBuT8cicHIQ2NAXqou+3zQaqM5qQ+eOoccMwi3n8i1Bv6KurZ/zwa5Qou3Rq/SfposqUV1dBs7FAa07lyREpdTIifpmyaf1kxZea0vu1X70kwlKkzqYbJ8P2hfwtrlE2Np+fJyC4cZJPkQgfJ88hAfvoR2rOwI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6382.namprd10.prod.outlook.com (2603:10b6:806:26e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 18:18:34 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 18:18:34 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] MAINTAINERS: add missing zsmalloc file
Date: Tue, 22 Jul 2025 19:18:27 +0100
Message-ID: <20250722181827.156035-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0048.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::36) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a14a140-0fe2-4f9c-1660-08ddc94c2b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q0xeI1+CN//la7Ck4kwx7IGvWTyJT5ePSAmFWf8SCVeA0KZ/wD6baha75iZN?=
 =?us-ascii?Q?1B904Ylp7W5mlAat5OqE0wmjIewhWO+SbmqlHg7rTwivVDnXBpWEOFUbJeE3?=
 =?us-ascii?Q?kSL5HCqqMWIWmLS4vm25j8r2bKssxqN3KISyMh/kDDvUHAU9uV03ZvBlVMS8?=
 =?us-ascii?Q?YDSlX6rGlE7MZhzV072pl47VqeY0zqfr0a4iYlZCKPUJju7l45sH+8ZR1EQR?=
 =?us-ascii?Q?KhbQ56cR3zBSh3TnTao9UWuSe1d5EwDLsoivh2Wy0rXZKfGAxjIfGEMX6nPP?=
 =?us-ascii?Q?6DhLMsayRznwx8EjRxnc4XrS4sSNDPt85d1YayNSi+AnR/C9t9u497I75f1y?=
 =?us-ascii?Q?c7+U13JltjAD3fShWftS64St7NhaHXNrK3thHlAQ+ld+/rHE675CoFKVETod?=
 =?us-ascii?Q?M3QK8dEOIdkAix5tOToM4W/0JlDbNCiF1vsMfKir6AsAxALTdBora9RBQBNF?=
 =?us-ascii?Q?hZGRt52a/C5JCKNMrW2gR8HrbzGFreGq7YUVU+Kn7k13qS4II/5IKK11jX+9?=
 =?us-ascii?Q?8Fkprjnf86WGHvO54hwyARLE2/6tjHR0o0p26hTzQldODD1EsA7LbQj6eS+N?=
 =?us-ascii?Q?qJRhJT4LPIMXt5UMnIDEcNwCuj7Fepq80CPBPduSk2ixYqN7QiHHS4B87PSO?=
 =?us-ascii?Q?5A89lTDls7IZsqXUS/ukq4+2w8BZk3mxcqIoCEusqvNGig5Pmfd/phRD5auK?=
 =?us-ascii?Q?T1LLe+mf+lY5T7WMwxUvGFnVOfBEQEb/IQkOYmVi6fRTCoXt0xiXerTGG79O?=
 =?us-ascii?Q?RKbulceehZaagTH32Nqt5LjCYhWVitkRmDcyJMUqZvqZhlLwfmI5WcRcUgiC?=
 =?us-ascii?Q?mJFfEScyPIclF70BHF8WdV4Weiw6uoM2IMqvUGPrUUwhjpwHyx3K4mONHf8g?=
 =?us-ascii?Q?H2XmRrOspvuPGrvOTC3j6w3LvxxrHXZP10jj19vHAhW+smin8qi0dM4l9wNf?=
 =?us-ascii?Q?Q042uIipoHgIwUMjP5J82r8zh9jjD6a6PP8tmDwcGCAWDlbTEgq1/KvddTme?=
 =?us-ascii?Q?ED5jwD6NA62HWcSTcc0ab5vrkBKvlqCX797OBSiDitmuFE+WdpKSZrF5hyA/?=
 =?us-ascii?Q?hZPtFvDl+Ujrpc6Q4Vuv2pRToED1e28TY896S0F/l/PC89G8HgQ7K8x8bXoC?=
 =?us-ascii?Q?fYI2sBXp8zc4IEyLuc5sUrND/V8N164C6Zk4gdI2kvT2PQrLKZ2/eMhf152w?=
 =?us-ascii?Q?WkLiw0VzAUGq6KCC/nnQFC6YTmrLN0IJP9NjIFsGph8aYj8313s37npqBnXT?=
 =?us-ascii?Q?DHJfX8ugprxLh4dCA3GGwC2LoQvGoX0JYfO1K+SMyhqvAFLj88KRUHF9qebD?=
 =?us-ascii?Q?nwAuluTcgOzPuBJ0/b2TJxoXZ9TC1eByR7NA9T06l10WwiG8zCfNM37kNGSQ?=
 =?us-ascii?Q?sUqnSumfe3l33RZYAynXWg8uCkMdeEfEvoquv8ljzNQpXmqczC7l/+rDY78h?=
 =?us-ascii?Q?WQmZmPo8gk8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tk0Hmmv+/SbT9A0azsfa6MEDIMlwjAFr6YMlTwMpwBt4gH9odDYYmdfx/xaN?=
 =?us-ascii?Q?p0LHCUkvfLdUmt1/DpZ0BivtcTDY99vaYxtrJbTBg0b0zIiU9WRverS4auSx?=
 =?us-ascii?Q?ZO4TAH74fXAXUo+UXV9rX6He6JG0dlUjZrD++KXvFwkUlmZetwj5ixeeE2KK?=
 =?us-ascii?Q?GnSAtRNfFqg0og5RPXZqQ9/sdCHN8COLj6TMOG8ejCBidvkvrnHcItEklElw?=
 =?us-ascii?Q?dFcvkGNIlj82POl+20M/yt+4M04Z9pky65qYkSxqUNGetxAoT2bwrvj7Xnv2?=
 =?us-ascii?Q?V1Zu+PrGdfRec0YEAnqk8rzAI8nwbT/qDrylRZLGSw5+4F0CSogVa7duf9//?=
 =?us-ascii?Q?7R7bRaOZCUZyy59nuXtSsRsB4Y0/ERHBTp8cUo2mmTrnAjumo192td1ZEaT3?=
 =?us-ascii?Q?4ydPHK/pklaR6kRF150sZ8i7cD2XsK3KRXx7snhrmTzDuV+sLL3PBnobmO7M?=
 =?us-ascii?Q?jLlGffjHgKc1rCuIne4G8L8R2yBX3D8tQWt83fnbmwyOQNTv1iAqWmJ3FfsB?=
 =?us-ascii?Q?WCZH+Rpx/eDitsMVkZxPYqizZnagmPNbjXsmA+kZpvz2N5AtH6IK+FyZkJim?=
 =?us-ascii?Q?GUlOaDbj1/7oqX3TEuau7SgC47ecdp2IUBHTmvWiIWII6e9caNZd1y5dmC8T?=
 =?us-ascii?Q?05F0hqpwKLoZS19XeE9ns7I2sCVyXgNi4BnvnJdFmTsajj6YIgJ6tg/ivYYY?=
 =?us-ascii?Q?Ue0kNz4GB4n1nvZJCZh/blG/48FguRZKreYIm5A0qVj5GJhucM046LjAQ4h5?=
 =?us-ascii?Q?L+C6gey7e3mZQHFJJ72M6jJdY0JKjl8R+7RbcG/3Q5iP2IswgPVI7C7WZS7Y?=
 =?us-ascii?Q?TRSLpm/Q6rVGp2UctbxoBKehzu4lOF0rjDczxVAfRt6okomjFPFk7F/y7SPi?=
 =?us-ascii?Q?N7z5cqN4nn2KPolBcLXi0yVaTMNcuozP8NZmTeVNhGIWAjCSJGbPrqMtWaTn?=
 =?us-ascii?Q?yTksCS/LjQubFMA4WoatOCflBiZX9GIhDlOdd+Yjwroe0GgQkClyh7aqEsRt?=
 =?us-ascii?Q?M/GzLJq4LlMTYAixis0fD9ATp0LY99/Y1y2dYHnhEwOB9MkMWWKqW2saVTMt?=
 =?us-ascii?Q?IpQWdnZc2XRILLGxhpVfHU6ELJSUQqSsBIvTsV7RkkzvpPTlLDdX84GF9Lm4?=
 =?us-ascii?Q?2R+89ojvqyV1u7aLDGRf8SJ25PH7erXJnAMMOI9CiiKkhOG1yhYFpB2WiAPw?=
 =?us-ascii?Q?KYtq5g29IPnj2Rav2+tDtI1xTK8z6gTLf7RLY/unk8dyP85fZopTBoBhaYG/?=
 =?us-ascii?Q?y7THQrg3dGQ+pvKRorRbFlruoa110FImTkjhyKsvu+2TSTS5voA92bN03FUZ?=
 =?us-ascii?Q?LtO6oDPPZmZzL8eihKvuc81cplumX3JodS47aRKhbAII1dlge4/cG+Jl7aVE?=
 =?us-ascii?Q?RmybbhdYwMp46e9pUV0GE/dlJ79TPf8drDhJMdWzDjRI8TEhvkoeFtsES8d7?=
 =?us-ascii?Q?5sHYPH2LX9TK8Q/Ze+eqIvYB3UHNvFtBT8SnaadffFJB5VVrx9s/z/dVGkyc?=
 =?us-ascii?Q?5cHWmNbkafftQsjcfZLMKYZXGcpc6/QAJ0G4hfI+gBCgkMhSlcFw+9mGoK/6?=
 =?us-ascii?Q?u+de1C066v06rrEvW0HqUNtNkzqVzEpTAs15XnCFkNttDuyvRFukIGypHNYK?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jB3l5OFIdm5uvDoOcBTjd0owLF4BUkMcLQISEAdKguE0LmtuFmEplPCcDEKcQoCD3eZyaQTW3Iq55lsl/jCk3Rl5F7ZZwjmntYeozCGMHIYu+CKnQOTPrfZAA7f+eStAxFHLhdKbzDAG45bJPWv8+rVJCmV00yvWoNuFl/PqZzS33ZxkhgcVg/B0KRGBiKfLbZ/nPde1OLDxMFSgxTZKvdcy/QLdr079TExO5FzQ1FP+Y8YsQkv299N1d8+35JOCci55HQ5m34GFM0W6Ijx1KEMhsjOuz1197DC3cnZ6CRsgE9frvik6DgDiCVfE/DXy2xvFhe/WlQcxtSZKGKtZuB9ybYCmBil/onuXGCWTmm4ZkxdfazQJ7LXbtBUjBPmPIkvMGBGP7IWmY5DtsCabnZMHY+NFo2Cw0qXIHQhtugmWprhuDBXD9mOWQd1dDuAAoJ0fp/c0dSRpTznD8o+xxmeT40wSz/IcFSvYn+CDOoEgsLWLpmg5lbZowDpGDxYyZCpAJq1sunIyVt7dwj1evLQ6BYhFcCLsP4oWU0QqCXsTl5rGPolHkkJWLs/+av59GsCAOcvtARqaeM2O65KOSBwOLR1bK4BigoY+UDJhIgw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a14a140-0fe2-4f9c-1660-08ddc94c2b7b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 18:18:34.1233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkSr2rTuuWTdsQkijl5nzaGT6Hd6jqTT5SEvFJ0l1i4SXdKBgGnLJSNv5EBDtS28ivgfo84AVPWMK/Q622eeup20gBSXxTmWMFHpnbrG6C8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6382
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507220155
X-Authority-Analysis: v=2.4 cv=WaYMa1hX c=1 sm=1 tr=0 ts=687fd5fe b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=37rDS-QxAAAA:8 a=AALVElXCgEnTsNbEWNsA:9 a=k1Nq6YrhK2t884LQW06G:22
X-Proofpoint-GUID: hZctkWuSs5hGBBwpBXUH5z2tl_jdJ7o2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE1NSBTYWx0ZWRfX3QZeH38QdFN3
 LSZt1QMjeWRwp0UR30nu904zAZcl4W3pIKv1MDEXA7WHtOlfSZu9lwgwzW/rskJZvMilKULRk+F
 TC7R5e7wFX9ZwThHjWpXl8AsFJ8CWr2kEv+i0ss05SJmOOezMd/2kMlG0Rh/VB1aVUrFIz4LAyF
 OOGXXhMKKpV98mty1cGFOOHdIVxxpFajG+pGD2Kmiu1hMd2q1KEzYW1/v933Ou7Yg7vjwZxdfTw
 IoYoq9WsPWxmsHGUlRG1jU9BebQFQ3ILJ0VwGTIkwAitJDDf1R6Ii0lF1XkZj7ne/QcidbVsd7a
 JJJRSRDGaBLBrEGFfjbFv10CzyvJ3SqxRjC3YsgqfypjWQKcVIL9TTdTuiXUgqwzd954W0vvCQT
 3JsHJdwEWZG4ZGm7REHe8TuzjCGzrojVK5PAJxD8VBJt0Y4NoBmmsWxpq9fxyiOj+aeC8m6M
X-Proofpoint-ORIG-GUID: hZctkWuSs5hGBBwpBXUH5z2tl_jdJ7o2

The mm/zpdesc.h file is only included by mm/zsmalloc.c so the zsmalloc
section seems the most appropriate place for this file.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 837bc5cd6166..fda539aff058 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27463,6 +27463,7 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/mm/zsmalloc.rst
 F:	include/linux/zsmalloc.h
+F:	mm/zpdesc.h
 F:	mm/zsmalloc.c
 
 ZSTD
-- 
2.50.1


