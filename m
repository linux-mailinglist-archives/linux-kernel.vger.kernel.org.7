Return-Path: <linux-kernel+bounces-738169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 573E1B0B567
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 13:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E09176C97
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 11:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6A51F09A5;
	Sun, 20 Jul 2025 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DdcyBmSD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xTuscfva"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C39171CD
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753010454; cv=fail; b=aZtewtJjpgIliVWY2cUiIuJa7d0u9USCGoJ4Nr1BfcaIa6dx0RTxp2QPxgP/KoskrETWZUOaW+5yqyoYBhbzewcevluBbAkfCullcZ5zV8B7Wrrrqdwji4b5zTcTO+/FLz8WIKtPQ49TKGzR/1gc+fwTUAkZzmRQQJ/jaPqqQ58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753010454; c=relaxed/simple;
	bh=XBN/LFe374iIq+fCnKJ4MG/TR7ueOCqZh1CU22MoZjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V6iqrsM2maXEWlRdUtUYM5rSu704jrN7ZSUxKemne321Eegxj2IZdm1vs6PfRBxbU4KAHj73eTdXl5+FdcoKRSigpsG6ebk6cHHUMQx+LJp2uIkvOJgubwlU3i3oqmGsA9dTMa2BztzzSpvTXssXF3HU6CcgHBqFpSjMj7vsWyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DdcyBmSD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xTuscfva; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KBA2KD001922;
	Sun, 20 Jul 2025 11:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=VCfHmIUdbL65nRRxhI
	TdHxOe05qEIlamWid512BXo1s=; b=DdcyBmSDp9vzxgD1PAOcPO0aPnXUBvpPuq
	1zthijeMCM6Nz6jqfBc+Sjrx/QzrVWWZo32feNlvkjnNKeH4bkYD0EHud/DqfYDf
	HMYoseLr/z0VfjotoMQw2fI/vn1SwntJFKE/BuTvtimrNnnLkHCu+6taJ1YjsT2a
	E2KY4CmVnKS6jUMTfsebbiKa47QYiI9Iy8DkfLF5+E8Vh4dKuy212gO7Ce2WndhC
	i4s72HSo2uJp2tORCywi5LwRtKHwsTtZaD+KB4Bu4bCG+vLdBRVsAsGvFqknk4GR
	8uz6jjcr8JkPn91VCLkJdt3XmISEcGvV7EUMWg0Jbd9Nas/2Mq+Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e296gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 11:20:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56KAuQ46010291;
	Sun, 20 Jul 2025 11:20:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t75k23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 11:20:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7uSbRsbyiOV28cCjFX0aMjkguw4SxNU/AEoCEW12lA1jgqlAKk+IQD+Dk+bQn8BMXEWZscvSnD6TG7A3QgScLg+T+yTJSdMkrL4VbfMUk2jgzvfkfcNtRRInxSHBIkVQVE02d1qKcpMgnDBrqaKifcy2LwzxXxbc7S2ofIkgulY+MTH3UOdScjGhiY4ovBDSDFp23dkaR0IWz5Z3RnqZ/AfzQ8WzhCQG7B8qemA+o2eAdjrhkW1tPG+e1r/3f0cL64ZUSoHNv1kdSH720GjxZDCBeUx2/HsDRgcVJvVutDhzTNAnZMkyuVMvjYFPMfIUEQur4xVn/NdZsLlIz6IiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCfHmIUdbL65nRRxhITdHxOe05qEIlamWid512BXo1s=;
 b=FHgvrvndTfqrj9eriGk90UJiinsxFGbQkb0otxE5oM0oHwz6biqHg/qFt7Rq/cBptJiYD2K3KpzeiH3rIwXxX5YqdUA0Zea3LY9g4sKtQbfYhvGpjDu+nT8mIh1QxuGLf9e8LLYoY6HzdZ38EhHSAZd82Y56dtc2tTbUK+X+5KQIV0jxMkRnaciMsXf23z6amlvYLTMDqUsUqc2y2HZQEgQxuQUcd2cucA8hStDtEks+bWpjlmysxm6l6Cm8eY8yNozrrDtKmJ2Grd8ATsO+CQCrhPqkpp1saKmkAGxUf3U5VrIcs48O5GIp7cewca7WZv9SQ+2hG/eCnlnqGQU8iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCfHmIUdbL65nRRxhITdHxOe05qEIlamWid512BXo1s=;
 b=xTuscfvaKkLyc7ZkHG8wBsdUmXlRqtm7SnUgPsSp/ENVbBiOJInkXmtfjiqTAb8ZXiJUkiTerkxzVl11Kt949CMFpBhTc17Hkzc2frVMXu1ttbjTetHrqYn1rccaq1x1e96mKowfA9h3A1xMllBtZgazKVXKpmJhmiHB8gFrR9Q=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB4997.namprd10.prod.outlook.com (2603:10b6:408:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Sun, 20 Jul
 2025 11:20:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.028; Sun, 20 Jul 2025
 11:20:04 +0000
Date: Sun, 20 Jul 2025 12:20:02 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, david@redhat.com,
        willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, Liam.Howlett@oracle.com,
        vbabka@suse.cz, jannh@google.com, anshuman.khandual@arm.com,
        peterx@redhat.com, joey.gouly@arm.com, ioworker0@gmail.com,
        baohua@kernel.org, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
        christophe.leroy@csgroup.eu, yangyicong@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, hughd@google.com,
        yang@os.amperecomputing.com, ziy@nvidia.com
Subject: Re: [PATCH v5 6/7] mm: Optimize mprotect() by PTE batching
Message-ID: <43ac6e1d-e8b4-49c1-8216-af523e120630@lucifer.local>
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-7-dev.jain@arm.com>
 <5c993cf6-13c8-4420-bd78-706ea287fb28@lucifer.local>
 <9377543e-3b92-443c-adb0-bc3227ea994c@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9377543e-3b92-443c-adb0-bc3227ea994c@arm.com>
X-ClientProxiedBy: LO4P123CA0522.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB4997:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dafd6e7-55c0-43da-8b0e-08ddc77f6041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BU9miBGrTOVe1+UvIQV5BBCmBhp0FLn0H+E/FZxoDKDTVafLLdsZqAPd1atR?=
 =?us-ascii?Q?m00v/uYj26LgzRHahK0bJTzFXBRHjzk3GCA+xIhYIkgp65z86j5Q+bu6JKmJ?=
 =?us-ascii?Q?SStLr4buR0iVqV6NhHPKu105/G+jIUFmxAGp3UINwk6Bz0Mlc7T4jssj29PX?=
 =?us-ascii?Q?AiHbZSbtHvRbwwGwELW94Ymep69KZjWi/9hNobfxY39bAEjObNgqMMpV03+n?=
 =?us-ascii?Q?xo7C2TnKnlvAwOXr6ph/MWBk7L8XpgLJ/x2abooXLpfzGipnw1db5CT/1JP+?=
 =?us-ascii?Q?/z8NJdfnPQpDabZEuJha6b+XP78iUqnqRZFl8FJMFSYsTbAjzh6tzuYkYbkZ?=
 =?us-ascii?Q?dQSWzwiyowfPT2vmyVTLJfCwz59C5rlTwGdv+fuTlZMb0Kd9sUl/zCeHrN0V?=
 =?us-ascii?Q?JLE6dTFpA7LFe923/SoPi4zo7EAcydAiMSsMDqXR4VOBHtLh5HC9uJtZBUTm?=
 =?us-ascii?Q?G7Aw7P9R3saw6H027wk6tol5U4r7Bxg3DW+8KJvY6GSxyQ4VTvdT1y8H0eI6?=
 =?us-ascii?Q?slTmw60itSsS1g8nXIKvdmH5ZBO/0GpSKeXZbFjd/QfAZExiG/Y00wuPNGhx?=
 =?us-ascii?Q?k59b0C2P+56kWM73j/OPSK+i9QVz7WdmisdebsUEEEqkzeHAvuqQ/YmN9k7v?=
 =?us-ascii?Q?EWxhpZ5YpytoyCtlE0Nc8xARcUfWMYapDvQgqGBkhOkiNlkuv+hJx+anTn6j?=
 =?us-ascii?Q?Qs4igapOnnZjSxtnUKTYySGLdLEIpUAXM0GphDaiIPL/VOPF1zJSq8rT8WAF?=
 =?us-ascii?Q?widSk83MQLr+n0fKUB2X3Ws2u2IR7YaqbYJyr4cXskg4FKQ0H9rR/VlpVnBu?=
 =?us-ascii?Q?5S5kazMhIC9dPfqPRw892T8k8y47MXPk2QePomrG+scfm3GH1hACS9veUWMr?=
 =?us-ascii?Q?LvMLakFfFs+4sDP4TVULoevtDAfnOSP8cD1Z5YEH4uk2lzEVctmEODGUC/ru?=
 =?us-ascii?Q?oNUscfhFWTADJqdrR+Jr1VzUNmgGv6JW+Hv7tY/ynK3vZX5u5MjbWHFeuyna?=
 =?us-ascii?Q?uAALKnbc1i8MKhc686VkpxuHd27b3933wtbmD2GjRmxIBQne1YKmm5+Ndyri?=
 =?us-ascii?Q?okm3JuxmlwqO0MoD7mvoiwe8qEEiSJ2LNbMJoFrBzjSAeSLb5K0yxOJeBuAV?=
 =?us-ascii?Q?tpJgw4UjL1oj3uYj8+K1C2aT76Id0/7LzATnqbLkZppddW+TdJRDEvoGVbzF?=
 =?us-ascii?Q?5pWj2LvFwF/VGTGgpiQkXolyLN3ezlVHtN8MqYBXKCSxKcwy1aW0PCK2FD7w?=
 =?us-ascii?Q?g71G1/euhizPZQnY4Ldk+92KLbqh4qkmA7ozUD9dBbBPwNx/afglCpIET36D?=
 =?us-ascii?Q?B2+ScsyJZquas1dJ9oljY9Sjs+JhyMlFAAr2ze80WrYI5b8nQlUtJKBNLJYx?=
 =?us-ascii?Q?ERO/yOIouPfRspVFO5N+bWNlrP/fHnfLKdbot2Fu4E7jxLeVmYKx2ATsE9bE?=
 =?us-ascii?Q?tMHQ+OuyEvE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uUiatzmdPbAUTVXJWvHWfwNWZw9yoGKS+/LIwJoLDbmGS3dx9ENEnFgKMK6f?=
 =?us-ascii?Q?xiQ9uOEu+KyTofoEmyApueSAFiQ55gaXNY2Of2l/cvweyV4xAHRRUL3ukkzP?=
 =?us-ascii?Q?NGwwnhcPDZ8OsUN/kgkCI5XqJxW+b8hoezfcJ5Zh+VcbydmEx8mGN1O/u8ie?=
 =?us-ascii?Q?MhoDrAprOV+qooI2aIJs8SiPSJ1ymXMTf1zgoHTwdaA+AkmsRFWnwPxeLWAw?=
 =?us-ascii?Q?pg+08uEd1BpxRTSR/s4tS7kcUJfGIke5PRPaKTNIgIvICzXUdUPsLYgd5+PD?=
 =?us-ascii?Q?UbqBVGrNs8bt3lCNNtCKoPvdsPb8beRrJXKkwdASCWhbX2zz9VBUY7z0phxk?=
 =?us-ascii?Q?RuPSflawP/to28Py+prkP+sDS1cei9wnFxEa7xgyjjxbfmLiQSGezWfuLR8C?=
 =?us-ascii?Q?OPReo2BS2ix65yjCmrcCErgxRXSQnrD0vcQ3Tnog59KzT4QYLx4nVd1BqLPZ?=
 =?us-ascii?Q?by/Dzq4d8Cj0Mcq6rEK6a2AlE7bfvw4MHCJxmJdR8rhbdSXcb6QrBEw8HyOr?=
 =?us-ascii?Q?huzjjtsydy4b0JzEr6ECe264F10ULvRzZEGPA9kX4Wbkb9ALgihj0MS8QZUO?=
 =?us-ascii?Q?RdWtywuusgB2drq6a9j5TaDipSFs1u9ji7ev02zZK2u72/1Kbte6ZjkwVyXj?=
 =?us-ascii?Q?VGTu4H9EzgOi+nTtnT6v8KbxfuXQ4Atv07O4lZJ8ZRVJuMCmGMK7g5c1ueMH?=
 =?us-ascii?Q?RVgMUoDbLYadAe0yMcykrmU9syQHVxCm9oNlaxIVfsEIGIF9EbAyRuX5l7VN?=
 =?us-ascii?Q?VUlAoyNA/7dMYTsxMhSzla1fqxzpTjWC4FC0MCU9CVDLMjsF7PvfthUYP7Ip?=
 =?us-ascii?Q?cNCzSaS3I5jIuj92JoYzfvltqy9sFTyPa/AC2EKB/RKbKcguI+gDXyPU80Sa?=
 =?us-ascii?Q?dFV6uK5DS/vXZC9Mj0ybnLDOo+xXRHYDcryb976FKVV1YdkltPR3bnObjzjC?=
 =?us-ascii?Q?R066x3hqdfzYTWiB0oJ7wCKYXss5dI4oD0EmLsvZp0cCsg5ZLzgaPKc6+LQ7?=
 =?us-ascii?Q?C55bMhWVXQeqMHJusE6iHxwW8kxYtKdEXwLUl/QvBmUQlBOv/jLMo3denC9H?=
 =?us-ascii?Q?3QclN4rcwhPyQWFRkXNjZOgLbTKgLi/jW305ybWPdCl6fTquSWUY8iuRTHnH?=
 =?us-ascii?Q?w/JZcyQ/8vfYkdaPa1oMObW1dhfe7Ngmbvg3MAcUH07f6mS5FGOw+n6BrPz2?=
 =?us-ascii?Q?h7EYGTWeDHokKO/jMQIbfkGakA9CqkGGpJ+7oxeVHsDbuYU04WWFEDLD2EC1?=
 =?us-ascii?Q?ACYXlajQpd3cghgrpIOt/Z2yV9b95Y9G/+gAbKqp9P4EAB76/i1RWfAA3obR?=
 =?us-ascii?Q?/0iCm89OseJk41E1IFazeM/YqHFD5Q0RqkZlYK/Hhd36zuEE+MFj7jvaYhj1?=
 =?us-ascii?Q?LGive//0H9Le6mi8dvDHptBN99JQWfscKGiyDvmxhDnZC6RyQMt22mjuuPp8?=
 =?us-ascii?Q?80pyV/zUFPbXLce0cdn5Bqlw7SS6I4gvxbyPa8Aqns9NEdt2mzYeiQkiFWWJ?=
 =?us-ascii?Q?9lMdIOOrsbcKDBithXK+trnr9H6cb0kVWlJ3sevE1NJQVstK6O2FwN/FRO+X?=
 =?us-ascii?Q?U+Fb7NdlLyC6Qc/mnGbazz0FDEtUzS5+hP9mNtVui8CnsXMQlrCaXYPTQDyZ?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3ENbHoYW1BvueUu6XoM431pfcB45LLTACoTok8Y9mmC5OfXvTWig/D3xKpxej726DYiUPtWChNamtxNO7wFFRjvKHgXzvcXKYQlMjNoSsZkbugff3rl364kX5ekqEz4gr6x1cfUI5bUqgzndWNUgjkODQNbQCvHhbdj6DdWIaVLqKTsHQ1+JAPs7lrU9JpMci8mA9gHB4IwPreQ1a+psMpcEMB/0c7LiHjyeEIWF1vvBg+pzfgOc9WBVKcyTVgkZTvFZ9Jf0y+a7D3vrgWwr20oezcjKAA8teOHU0FlVqib3iruaAgRiJAwi+z0kr89TdhQjzjxIaOEcK0vIYCni5epDu4F1ItyD1U4K7vcVpvOVZgtjsk1d6h2TUygTWFLNTfNkL4OMZqpZ5/Z4RI8tSVZU5PxWjtUpT4KjXTlpq9lDFG+avK83Ie3qlcJXCe58fF6+R0MKNDJA+TIAh9ioUDLBH1+GtOnUxgZH+cgVGphJHij/P5YNvRuuXN6qxc2m31bPq+MCP/op4EdkHILa8kVez3W7jVH4LwNgtTm1nNHw4WJxf7nqpeaPJSnfMeH33bcP1PxAyHLzdPhCimBW0hlGEB1RQ4e/K5eEybt0GKc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dafd6e7-55c0-43da-8b0e-08ddc77f6041
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 11:20:04.6914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLTNVJCiFSCjHFAgs5I6xqrNPryd2f16kA6nStb8jQyJCd7N+0eC8/Na1gxzOFC3N0PNT7b84frnarIzBrq540IeRF3wR8aiaUWSlxuMVeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4997
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507200108
X-Authority-Analysis: v=2.4 cv=WaYMa1hX c=1 sm=1 tr=0 ts=687cd0e8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=Gp2qUnQIc9k_xH2Q1zUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: dOBsWZiPQeUCdirDisFOGN6qr7wgx3t4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDEwOSBTYWx0ZWRfX2xtWPyzkVSoF
 0uSs/fLIfhZdFUKjL6R/c7dCdcTr0hrIyXs9s2ejxUdPIkgbn3t3JZr2sCtlCWlaoASMbFVi9kC
 wj3Zmv108E6KvaKcAKNvkiuMP6br92CF6XV2aukmq0AO8ihTsZVh8Rrc161yt/nw78GgMPnSQ72
 RS9KVyjIDrk+42/4jjEXlJLH/0VmXjAExLTetnk7l3xArY1GchYS9Z69qjmiqA0qqyC5uf3pirh
 zuF9DAvkrQAyd/cfMGP5gTyaAU12jLSkJRnemQ6v4a2sfYnz9/MU87r39p7Bm2ZZkeiS1aEjqwo
 bACFD9VmGFLogTLMGP/Yq/xd0oHbAmYFzxFbNPEl0zUpDePOGGoGfJ/8TOzqUAlQ3Ftg6Gn8B4s
 ob2S/XsVCjDRJyboCE2zmDtR4ZiZwSEdNXzLByd7o1K1q+JLpu/BwJjB7Gf2JoyAAl5kUHNz
X-Proofpoint-ORIG-GUID: dOBsWZiPQeUCdirDisFOGN6qr7wgx3t4

On Sat, Jul 19, 2025 at 07:16:48PM +0530, Dev Jain wrote:
>
> On 19/07/25 12:19 am, Lorenzo Stoakes wrote:
> > On Fri, Jul 18, 2025 at 02:32:43PM +0530, Dev Jain wrote:
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Thanks!

You're welcome :)

>
> >
> > > ---
> > >   mm/mprotect.c | 125 +++++++++++++++++++++++++++++++++++++++++++++-----
> > >   1 file changed, 113 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > > index a1c7d8a4648d..2ddd37b2f462 100644
> > > --- a/mm/mprotect.c
> > > +++ b/mm/mprotect.c
> > > @@ -106,7 +106,7 @@ bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
> > >   }
> > >
> > >   static int mprotect_folio_pte_batch(struct folio *folio, pte_t *ptep,
> > > -				    pte_t pte, int max_nr_ptes)
> > > +				    pte_t pte, int max_nr_ptes, fpb_t flags)
> > >   {
> > >   	/* No underlying folio, so cannot batch */
> > >   	if (!folio)
> > > @@ -115,7 +115,7 @@ static int mprotect_folio_pte_batch(struct folio *folio, pte_t *ptep,
> > >   	if (!folio_test_large(folio))
> > >   		return 1;
> > >
> > > -	return folio_pte_batch(folio, ptep, pte, max_nr_ptes);
> > > +	return folio_pte_batch_flags(folio, NULL, ptep, &pte, max_nr_ptes, flags);
> > >   }
> > >
> > >   static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
> > > @@ -177,6 +177,102 @@ static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
> > >   	return ret;
> > >   }
> > >
> > > +/* Set nr_ptes number of ptes, starting from idx */
> > > +static void prot_commit_flush_ptes(struct vm_area_struct *vma, unsigned long addr,
> > > +		pte_t *ptep, pte_t oldpte, pte_t ptent, int nr_ptes,
> > > +		int idx, bool set_write, struct mmu_gather *tlb)
> > > +{
> > > +	/*
> > > +	 * Advance the position in the batch by idx; note that if idx > 0,
> > > +	 * then the nr_ptes passed here is <= batch size - idx.
> > > +	 */
> > > +	addr += idx * PAGE_SIZE;
> > > +	ptep += idx;
> > > +	oldpte = pte_advance_pfn(oldpte, idx);
> > > +	ptent = pte_advance_pfn(ptent, idx);
> > > +
> > > +	if (set_write)
> > > +		ptent = pte_mkwrite(ptent, vma);
> > > +
> > > +	modify_prot_commit_ptes(vma, addr, ptep, oldpte, ptent, nr_ptes);
> > > +	if (pte_needs_flush(oldpte, ptent))
> > > +		tlb_flush_pte_range(tlb, addr, nr_ptes * PAGE_SIZE);
> > > +}
> > > +
> > > +/*
> > > + * Get max length of consecutive ptes pointing to PageAnonExclusive() pages or
> > > + * !PageAnonExclusive() pages, starting from start_idx. Caller must enforce
> > > + * that the ptes point to consecutive pages of the same anon large folio.
> > > + */
> > > +static int page_anon_exclusive_sub_batch(int start_idx, int max_len,
> > > +		struct page *first_page, bool expected_anon_exclusive)
> > > +{
> > > +	int idx;
> > Nit but:
> >
> > 	int end = start_idx + max_len;
> >
> > 	for (idx = start_idx + 1; idx < end; idx++) {
> >
> > Would be a little neater here.
>
> I politely disagree :) start_idx + max_len is *obviously* the
> end index, no need to add one more line of code asserting that.

Haha, well disagreement is permitted you know ;) as long as it's polite of
course...

That's fine, this isn't a big deal.

>
>
> >
> > > +
> > > +	for (idx = start_idx + 1; idx < start_idx + max_len; ++idx) {
> > Nitty again but the below might be a little clearer?
> >
> > 	struct page *page = &firstpage[idx];
> >
> > 	if (expected_anon_exclusive != PageAnonExclusive(page))
>

> I don't think so. first_page[idx] may confuse us into thinking that
> we have an array of pages. Also, the way you define it assigns a
> stack address to struct page *page; this is not a problem in theory
> and the code will still be correct, but I will prefer struct page *page
> containing the actual address of the linear map struct page, which is
> vmemmap + PFN. The way I write it is, I initialize first_page from folio_page()
> which will derive the address from folio->page, and folio was derived from
> vm_normal_folio() (which was derived from the PFN in the PTE), therefore
> first_page will contain the actual vmemmap address of corresponding struct page,
> hence it is guaranteed that first_page + x will give me the x'th page in
> the folio.

OK, I don't think this is an issue, but I"m not going to press this, as it's a
trivial thing, it's fine as-is :)

>
>
> >
> >
> > > +		if (expected_anon_exclusive != PageAnonExclusive(first_page + idx))
> > > +			break;
> > > +	}
> > > +	return idx - start_idx;
> > > +}
> > > +
> > > +/*
> > > + * This function is a result of trying our very best to retain the
> > > + * "avoid the write-fault handler" optimization. In can_change_pte_writable(),
> > > + * if the vma is a private vma, and we cannot determine whether to change
> > > + * the pte to writable just from the vma and the pte, we then need to look
> > > + * at the actual page pointed to by the pte. Unfortunately, if we have a
> > > + * batch of ptes pointing to consecutive pages of the same anon large folio,
> > > + * the anon-exclusivity (or the negation) of the first page does not guarantee
> > > + * the anon-exclusivity (or the negation) of the other pages corresponding to
> > > + * the pte batch; hence in this case it is incorrect to decide to change or
> > > + * not change the ptes to writable just by using information from the first
> > > + * pte of the batch. Therefore, we must individually check all pages and
> > > + * retrieve sub-batches.
> > > + */
> > Nice comment thanks.
> >
> > > +static void commit_anon_folio_batch(struct vm_area_struct *vma,
> > > +		struct folio *folio, unsigned long addr, pte_t *ptep,
> > > +		pte_t oldpte, pte_t ptent, int nr_ptes, struct mmu_gather *tlb)
> > > +{
> > > +	struct page *first_page = folio_page(folio, 0);
> > > +	bool expected_anon_exclusive;
> > > +	int sub_batch_idx = 0;
> > > +	int len;
> > > +
> > > +	while (nr_ptes) {
> > I'd prefer this to be:
> >
> > 	int i;
> >
> > 	...
> >
> > 	for (i = 0; i < nr_ptes; i += len, sub_batch_idx += len) {
> >
> > > +		expected_anon_exclusive = PageAnonExclusive(first_page + sub_batch_idx);
>
> We won't be able to do nr_ptes -= len with this. And personally a while loop
> is clearer to me here.

Well, you don't need to :) maybe rename i to pte_idx + pass nr_ptes - pte_idx.

Buuuut I'm not going to press this, it's not a big deal, and I see your point!

Overall the R-b tag still stands with the above unchanged.

Thanks for doing this series and being open to feedback, I feel we're iterated
to something nice here!

Cheers, Lorenzo

