Return-Path: <linux-kernel+bounces-768178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 992B5B25DD8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268771B68C20
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FFD2868A1;
	Thu, 14 Aug 2025 07:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pKnuWGga";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OSi8wO4T"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911A8285CA9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157449; cv=fail; b=Y9N2YNMDQEVChq4wf5OdMiu8PvMoyNaPFOAp137F6g07iTljkIEbam1v+U8tt+J3TyS8/6Zo15GKsyVtfbhB4dTKKPy+t0y61aaMmH7vnjLiT9YImIfIyr3Sj9QC+JICJWDgwzvgIzqtMwXque+ZDuueqNi1YYT4DT5R5lrERI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157449; c=relaxed/simple;
	bh=rG1eVV7OxsH+56iRswptENsTWbQsBIM1G4GhDpeOJ2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fkf23r38CjQ62chITFp+GaqgmbcEIRsVZYztOTj+P9QiLmo4pmktNIHNt30I0c4d/ylWt05EZEpdSXJb9zTVFi//QQPftqJkDD79PxNBr+G6T66OdoQvEKyapz2QvrTF54uUhen5xoaf/2oU3jBnCr3f9tC9VGbfVTkU8GvXkr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pKnuWGga; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OSi8wO4T; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E3HCnN008668;
	Thu, 14 Aug 2025 07:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=8JZjYOXZudGV6uEppe
	zzRPSLT2dORdIYozNhowVB/M0=; b=pKnuWGgaSUs4dbLp5qmeaYcGmq3W/W1c/P
	i4EK00GuAxpz2iHdJOUs+Udphh8Rnmw69RhuZ2u2Rw6UscP/532YXwmJGIjl+FT+
	4BfNdVd/iCGa+rzUcxM1ecNM71kSbLosSZTEtEGB6086nPBXJFjbXvZ7M9594sMX
	xdS6Mc89aYeszzS+G33m9jZZWlhaLIzdx1TlMPmAJIv8WY/g+43QsBAntQq6S0Yy
	nw4d6XpYplI40IN3fu37+Y16w67nuI+sIGv6soFNjlkqJ9/icH19Fsz41chPW81L
	krIrzDMiO80v0PFdUMfnO6qmfmkQkD9/NwIqFJJ6/MXwbh6BRnWA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48h7rmreym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 07:43:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57E6VAMX017597;
	Thu, 14 Aug 2025 07:43:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvscdbdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 07:43:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPv757TZoZZsRCxQnIq/9BHxwq6sBmABs2oQ7Eq9CtxxQ/uxG0iZAG91bcbECxuOUv9TcrgTCjWaIYO2WHe3H3MJ0k72uE+CWi63stlu8Cdt7riRnBnJLVxScJVjqXdwgMiOT+hwxPkh6reLt4p3AbaTRjuCub3MlJmWj/TEa02ZR7Si9OnLuLicTJV684HU+Fm6uYF1/ub2vUb15hEadtrlMJaj6el6jKtMGkM4C9LU4v3kTFPeldRrhzp6mB8z5VRxnVZIbQbIXf9C7KCBCvVJ19k3r0FqTmSov5HD6NFyQyftf6y5W6h1fLdTwZVQBV0kY8YMq2yMwjJYDAxjXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JZjYOXZudGV6uEppezzRPSLT2dORdIYozNhowVB/M0=;
 b=pUy0fXPJtXXtI9moxnRy19HZmSE9N79+DAZ2VE0qeLJplfdiZT7/IO8/ct5gRWTHgOUfORt7zYNhyyXS5bN04JTwXPgIMnwYE9BRYg8sJk99XdIEjg7vjt0m8u9MEe++VHuIzRNnGXC/zgnwc9/YlVROrC8o83Ttch5r8bKlcKJmOaQQ2VQkQD4dW8A5ZpuHAnvFIuJQwLeXIeQ2ZifFlQqVWLnL2D2IFi/3wHTpH2XCoZnQWatXXCuGMDriJoh3TKBnB6WfL1YA8HXA1Thz4+oIxCdZZCCYv+lANkOJv2cHSmd0gUIFJFKXmuWOXPQbQgidC1L35wdQvqelIwgV0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JZjYOXZudGV6uEppezzRPSLT2dORdIYozNhowVB/M0=;
 b=OSi8wO4TggOyVnSXVg7tQ+bXkTqNGMqJKD5jADnzN/+7O3bx5194xEsbDAEU7Pq+V/mBebAEWONhp6hEourYxErkh77g3MotuiIuPTESNFY14l/Qn3xFPIjs3/3XVz8hwaM4EJixgQ3jnOf1TOoTqlSyzVLcCMrMqpSsZj1L4xU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB7411.namprd10.prod.outlook.com (2603:10b6:610:187::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 07:43:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 07:43:07 +0000
Date: Thu, 14 Aug 2025 08:43:03 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, Ye Liu <liuye@kylinos.cn>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Fix typos in VMA comments
Message-ID: <5108b2fd-c6a5-44c5-93f6-6ff9fc2ae783@lucifer.local>
References: <20250814073800.13617-1-ye.liu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814073800.13617-1-ye.liu@linux.dev>
X-ClientProxiedBy: GVX0EPF00011B66.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:1b) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df0214c-0cc5-4414-1c2c-08dddb063548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?srbfashZ2ZWN15TMYtsO3FBK6ybwrE7TFPLf/9gvMr2erwKYUtIeJpxWYEnO?=
 =?us-ascii?Q?s8M33JgKnA6kzCqfg/u0fgrlZJNa65JQbe2H7xyDVFG7UoIxD5xE0DZWHVIf?=
 =?us-ascii?Q?+h6mTFXnKUC/GKMwPJgo5/sM9BNDwPOxpnyeHHnXn3pLJp7P1W0D1jhD1u6m?=
 =?us-ascii?Q?nyZGG7qfRwFlHH0DHgJ/UvvVEe9UdeRooZtQ28KAJMXnTSXAnzh6YTPsU4wB?=
 =?us-ascii?Q?Y94NTxsBd0wXo41K0f9LAwEICSpQjAx2/rjdNZIyqCnBQdHp7np/Ht4oNVoh?=
 =?us-ascii?Q?jZq5rmV7w5UROg6veVxzwkpCXuehksr6yUX1aWLGG0cVnf8lkecK1pICySP1?=
 =?us-ascii?Q?/UTW38rBzLd1PGV/+Sf7QR+LkYXRuV9uBnXyb0xpaSxoeLS0f3eaS9DSnSsV?=
 =?us-ascii?Q?9RS0xXXsj3v3xeyp/x/g8wCrCKVAh2ouZl+jcztCpkgrls4PxpclWWkBcirk?=
 =?us-ascii?Q?woC9wsoCzuGGbObgPTX0MclkzooibU/ZHhiW2AImq9N7seNigaGTFy8dLPS2?=
 =?us-ascii?Q?YdPfdzlR48TQYiCuhVpbCTWsM6+eSUaCOkh1PGQf2VZr45ORCRgmYj1ujeAQ?=
 =?us-ascii?Q?Jm5h9QB0FCr/QpG6P+zAImh18srQHcJd53bktR44E6MDB6RFDdS7x+EnOn9d?=
 =?us-ascii?Q?RQbND9w5vgsei5ZRqX82HCRf6NJEMEeegz8rLNy7TftXdlx16DuWb3gdBSKO?=
 =?us-ascii?Q?IcFjmj7YG8l84UT+wGKQBR2sKxR5kX7/pXxV659AkPdUT4Le/u2WPtxDg/F8?=
 =?us-ascii?Q?hV0YmaKQ12bTIi42WV2FBCn3ubB7kTYXJLVlPFSyoF20AlEbXjxFP0+pIRrn?=
 =?us-ascii?Q?/39tuTFvaFu79ScjBs96+50YvYA3AphjNWhy4Ngzqlaa4ISDulLdrwM/178E?=
 =?us-ascii?Q?7B9xLxHM/CqWKdNOg72/8NcJnOM/KRQZalqPcOEtHJmr7MxP5nDQ/h0oRpVW?=
 =?us-ascii?Q?DdS+5b786FIxW1MM32rsidyi4b/mIwdljmihDRzkklFqWdGuW4HyRawZTKS3?=
 =?us-ascii?Q?QqaPgT0OpaJjBrPCmdGvIIIsETBrmcJmXX0vERlCWd82fWxbV8DeqzkjPiNS?=
 =?us-ascii?Q?4xRqcQl/o3SWXXXt8DQq+hT39GLcERkztVAgQWm3gNUY4XHwPvusPiCTFWIJ?=
 =?us-ascii?Q?Q8UB+Nq85l91FtU6WdyjHnbiREDy1vOM+VU8MvrU4bpfUtiV2OSPpCnD747P?=
 =?us-ascii?Q?V6qkMdhLcU3iqDNogZfPqgNYDTfUk7VwGuEO7IffSu5zBmGXNAZZGS0V+DGB?=
 =?us-ascii?Q?j+Z8U/COscfu8hUAagYmlg3ohFBwzDUYRFKZLl1LuRQ5V8ULKmL26ZeoXVgC?=
 =?us-ascii?Q?1/MUfZCuuuSvEYJgJhojsL0zrWkH+rvPPQ5E74Ljc1F3sXyXxUkFao4WS+EI?=
 =?us-ascii?Q?85pKEMwDbEvzkHf/uebB1K0l40tB8e1xP1diO0GlxpWLZ/I1Gw3BWRtny9Gu?=
 =?us-ascii?Q?WEIwLiFoUmk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sK4eCZ/Yr1e0t+eMezzqRSnQ9x7n0CsoYB5TsDH/Q2HmFcQjWnrFwfTVkbzv?=
 =?us-ascii?Q?FaHpYlZG+n3fnvQAejDEtie4h3CpMd5eYrctkPTtI+yFpsla5uTueaHSoWsE?=
 =?us-ascii?Q?lFOrdj4Z8qllh90ycok01K75efYXX5enMIxMxpBsKzYavIkgauZjtVdGR49y?=
 =?us-ascii?Q?N2t8ApYcxYdOF4KdJIkbOJuttEaD5dFT2Mzq+wzdgd3BKXxalcWbfMTqT3kg?=
 =?us-ascii?Q?smgJ7jM5+2LcuXy0+wVVNWz61QnSvZPh51iS8ypHzUNOXxmu6ewMqetbOEw1?=
 =?us-ascii?Q?Sd3lrw2yh61j1HzbU6E98LaCkDCHlhaYQ3WVg/TJ6QG1DT+EqjKvNCzEOBtx?=
 =?us-ascii?Q?4xDCFcfgq38KIMOL6JE+xO3u9Gzq28wuo+lNMnStlnHCfNEYhsP3ZG6DyMzg?=
 =?us-ascii?Q?1kgqN8AbCS2dIIAM+vfo9uhtUkuBfrGRXWImZc3GlTiMWhHzQMS1eChJufL1?=
 =?us-ascii?Q?a5EojY8N2Yu3P7z0w5K3GpnlvCvzxgBf1Wpf4od/slQ/LhbRfG0wAVSoQ2/x?=
 =?us-ascii?Q?r1fXfjzhPz/2wNNR2qGTpCi46SnKesghnnjO2rE+kezfzgSaWTVTXeeoaTG1?=
 =?us-ascii?Q?2p7H2zpNPJysGr04bEElTR+UPa4GhtdIAKf9QApTxniZqh4KECAACnHYnVly?=
 =?us-ascii?Q?vLcEWYsoc3JK5j4Vx6yS8ZBXcpo9E2hG+QDEWXZHBqTv4SijA3qHNDmfBLXl?=
 =?us-ascii?Q?bXfX0/vsUNZP0Pko3GdYoT1ZKF8gd4+ND3WRvQ6FroQUMXiaZTxJF2nLkCFc?=
 =?us-ascii?Q?J2dj83axja+i+/ZOiw55o9YgFTctDnqAoOFh7WVjWNQoKH/Am24pyA4PBuAE?=
 =?us-ascii?Q?JIEp7W1GEcow58TkILiIJl+3XdJgK9v0jQGAIhsZ8/fOngmudJy4eyVQn+bb?=
 =?us-ascii?Q?7SHeN9nGe71st3119pas5GUUXU9Vb/Bt6VRX2ROFo36N6nZ1wvA2zESB10kG?=
 =?us-ascii?Q?/QJie/0Ps6vwA04HAaPux+ZkdwrMSw8MIp04avTP3dhfZOtYWVC/zAykhRG1?=
 =?us-ascii?Q?xMeyvs2QupIacdpRbtD9WfQs3CQDWoNjd0ZkrdDoISOxie3YCOB1oP/N6F/2?=
 =?us-ascii?Q?L2KTOMBufOKB0hiTV8wc0/JyCV5cIGu6BpedujIzsP3k5FkC69rU3wMFe6cP?=
 =?us-ascii?Q?ILbiccaRsBMlIcNpuER19rEU3DRhUCZ38/bUyzWVwe/RRMEAe63G7Q+UUUD2?=
 =?us-ascii?Q?+KHqRxIZo5y41Vcr0Yy25k4k7chGJHuEX/PqY722JndnRxeIjyNF1yt1fdv/?=
 =?us-ascii?Q?Drl5PjN+/SzG3Bz3FgG52iPxqv2Sr4S7PSUXjLQbxQc1Idj85CBzkHIC665f?=
 =?us-ascii?Q?Zz/168IDB2FXFlg8uq74DGpAMhvnU3DRhBsRe9Qtc40sxaWGtr7h5QbDG3YV?=
 =?us-ascii?Q?YjTOZ4tCd7kPwvO/niaQq4VcDZz8TKHKcK85aBpw7Rbp3NKKpVdkq7TH+Rc2?=
 =?us-ascii?Q?vJhcIA3gYHKj74ySnkW5sBLETT1tO+VZhjNg5ihyn/tmw6bMz/tqFNES6Xr4?=
 =?us-ascii?Q?z0uN7kySEchKPLvFb1ObkXFVQb+2zGZWrOmYCQz3a/BFa7qfENPIl7/MiUOl?=
 =?us-ascii?Q?GOp89LMMmTURdSCc9Rfpj14f6OLMGfESNpTSHCaNH4KMB2V6ScscOFXdOFPK?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	deS6mSl/T9j4wmh9UnXK6eIrXAb+40m4IiWsryq6fhJhvFKgnLV4ZW26bTTVTck+4AaCwr0fMnfOvRkhlXs13cd5sx26wvvuJdgc/BUZXMBjAHt0e+NSDWsFmrfN0B1PHYIkxYQT5LD7oC7uGn+AgseH2Z/W3cxp0IWN1KFsebankpsj+EtRhIZBX9W7zB52hJVGnD1msweO4xX7AcmjnAvf0m4ikmZ1LNCXKQKQBU8KKc/TUvJyrdjN7KPub4agA5ezU9B6Go71MQ4+YC0dRtkWFfQFe1wBMOV/Bo1xejP+PrYKS53ruag85dvm23DYYem25drMNBI78I7CbHsadSVbKADAjBjuZl0J2Bopph9mcQlYaIt6qrhyrh8nYKU99BJ6Jb/K0rMzuNeD9g8uTu9LLmlqn94hm2090QiZWdN+tvQImpM+bdNd4UK2DWeWfffWS9+nvTSLd+1QcaWiuH8VTPMJ8i5Aw/bj/nHkvKR1AEmOPJ2s6aB2MN0MHd/1AJTuIxdxwKhayErywipDoAkSRLW19WN1LgFrugiwoxMCQIHCbG1rBcfuZOpOyhHgaAeewWdAN7dCOPsq8Abhfx49PVjpBhI32Y/rWhfJGeI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df0214c-0cc5-4414-1c2c-08dddb063548
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 07:43:07.2485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qf1Asik+9Yt3qEKVK2ljqm/wYAxHtleMfziERQNStkIUM5x5cmHMIiPg2bJ267n1YWOaApWpK/jr+r4+so6S3wZsjgHyDxku9RuR3utk6+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7411
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508140062
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDA2MiBTYWx0ZWRfX5xbrk/iZEERI
 9ILO9cWSZTk9g/IxjI1cuxCCUntHEm6DUc4U1lLT5AfIWhK+TDVvbcgP6PuktEegSAtQ1aMfZKJ
 1wE8GzxaHDd1CbiavSrRaq0KGsT1HsCR0oxdkBPt+R7/NRnd/EkgMW8CZwKHecz3NeqJBHqlNJo
 zTxgtHS9b4XZpnXEKgp/DiKIHU6WEiF/v288Nc4sIGO769macfMA7vwSv3Veu2P6fQTQwWa6tAH
 lAt8ZCfE+Urm+5k6EC9z9R2O1DyEzYoUYNdv1/Yp0ZWaqF0o/Un3cvucbKIsgS1nHP9yl2h+yKh
 kkJMT4hFgNkYM6/LHzTyBS8Xnk3acM21pT7DiiHBF5eQv1jXBXej6zFrqM8Z38ZQo+Rvut/2DAT
 nN3TWxbINNMEo5sho8wKt0EuIs3dc7CPQj2eDIeIEJamxA7Ifqc9RtyAYhexW/m7L0UsKsuW
X-Proofpoint-ORIG-GUID: a69vS9nZe83-FFMDf7EOyB0MpPmmR-aF
X-Authority-Analysis: v=2.4 cv=UN3dHDfy c=1 sm=1 tr=0 ts=689d93a5 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=MEGe2A-j529lPJzwVz8A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: a69vS9nZe83-FFMDf7EOyB0MpPmmR-aF

On Thu, Aug 14, 2025 at 03:37:59PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
>
> Fixed the following typos in VMA-related files:
> 1. "operationr" -> "operation" in mm/vma.h
> 2. "initialisaing" -> "initializing" in mm/vma_init.c
>
> Signed-off-by: Ye Liu <liuye@kylinos.cn>

Seems I am the typo king :)

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/vma.h      | 2 +-
>  mm/vma_init.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vma.h b/mm/vma.h
> index b123a9cdedb0..bcdc261c5b15 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -145,7 +145,7 @@ struct vma_merge_struct {
>  	 */
>  	bool __remove_middle :1;
>  	/*
> -	 * Internal flag used during the merge operationr to indicate we will
> +	 * Internal flag used during the merge operation to indicate we will
>  	 * remove vmg->next.
>  	 */
>  	bool __remove_next :1;
> diff --git a/mm/vma_init.c b/mm/vma_init.c
> index 8e53c7943561..d847c6557261 100644
> --- a/mm/vma_init.c
> +++ b/mm/vma_init.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>
>  /*
> - * Functions for initialisaing, allocating, freeing and duplicating VMAs. Shared
> + * Functions for initializing, allocating, freeing and duplicating VMAs. Shared

I typically use the British 'initialising' spelling of the word (when not
typo'ing it :P) but I don't mind using the American English form either as
that's almost a standard in the kernel in practice.

>   * between CONFIG_MMU and non-CONFIG_MMU kernel configurations.
>   */
>
> --
> 2.43.0
>

