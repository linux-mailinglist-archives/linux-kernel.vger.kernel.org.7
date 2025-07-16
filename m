Return-Path: <linux-kernel+bounces-734034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA99AB07C33
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028ABA407AA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017A22F5C5C;
	Wed, 16 Jul 2025 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c5C+cBuB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lfWl1PgU"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B902F6F83
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687540; cv=fail; b=IDRqCNseEiFwcDykDziTSahS388C65P2Gw+CD7dxd+F7DaekrrEPC8v46jhaEYRfR/ozM3BmQipGM6P+6/CnIcp84ZcmEhTde1DM9UU/Meme8F6gq8l1MWROaM5nw7dMb9ruSMpxpbovjPq/zH2MNrJAni8UTOH27TbUV6z1K0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687540; c=relaxed/simple;
	bh=zIfEb65/LRj8RtZgAYaJm69rGjnJS4xHjZs1+XyZOBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fVenm3tZrOoblpsqr7JLyTHBWY1mpP2Mf5CLboH1qrSco1gt3SsRTTJJiSvTVgbT7KUKiyvECm47O5Bx7vk6GrTRg8kb6yfSkRD527OxLdLYA8HlnQUtgERhZUfkewh1Vd7aGvfY8pQWLc4aP2z627KTv/wpHUuXx2o3dKcyqjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c5C+cBuB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lfWl1PgU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GFrAbU011160;
	Wed, 16 Jul 2025 17:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/82vPa79czhaMrGtcMOuP7oWMZin6m2ckvlM2o8LNNQ=; b=
	c5C+cBuBQepXbjlJZXriLBW23AiIDNYb76ENzqGBtq56DiNKO9py/I+G3gQh5XVN
	xHo94Wh5Id61vX8z4g6g8yhHvTmXX95SXrkrwJhjAAbCpNkjS558Q3u5QRQk4fSF
	SHNg0S1/qbRFZn7aeB2qIeiD+g6iD40bgNfOjI/sM7js22DSggsWpkPZ+wVYNIkf
	oyCvdhAHA64lNTJTuk6++ij5rKLoFoElQDIqrYs5nlYxihllKILcLrEzrNYkbd/O
	KOYHRIGTySMButj3mKW14MKlmEuq70IPXWSRUWwd/Ra1CyiJ0LMNoigkcnsqReVZ
	/AmM5YrRWTh9xJRnqtwBFg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk67161w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 17:38:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GGnY0p030328;
	Wed, 16 Jul 2025 17:38:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5bmbhv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 17:38:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dx1cm8ZzSjoslSSPyVRa9t74w7TnvX8LzsPtK4sFWn+ftKFBQp+SJcyiDO7yUXyQW18WgLBoFG1lX45+UZDphSzLCseJ/RgxTcEd6Hb2ETvDSnfT2jf5MZiUGwb2CX2sopiJIynJHsOKDYmzG83R2hu568eNaz7a7NlpdFyfSwF+qbmNcdreg3J2obLz73sATgvx4e+DfdlYKVoyU+DPf7kh6jWuVJLtn4CTIxIlDnlWHjKJmKx4daAJEsCUIOevWUjjd6dIHQ9iqwudkzJo3U37NG6cEBb80ba/wLSF7vxdgM3xU1H++tkzvlARZD7JkepZpSum+4EIthbTQGF+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/82vPa79czhaMrGtcMOuP7oWMZin6m2ckvlM2o8LNNQ=;
 b=UDfOtpid9gn3jSwY4cwvRS46nNMcXqczQABVuVs8KocDslaCDEMAPr+w3EYqu1hGVmDd+qnwzD6T1xYx+mBL5w5S3kEq7rVSRdbBxV2uIkRpxvsAYj19W5sIA1dcTIjkr3iNYAevtjSIqCbIZMERh1EaOs5UGSHBiSJi7BktXqSSlHR/A9FGBTiIQajz6FUAdAQt49UXnGt+4jw8SY82sBpf82Rug3BQlHB+br7SDbzC8t63CAFerYp1njkBKjY87X0Gp2wGpUWyUTnL3GhgOTC2/37zeHobQycflU/n8UVghJY/BxnGIymSx2TtgylS/29ZQlTKuXFFD96vdLvF3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/82vPa79czhaMrGtcMOuP7oWMZin6m2ckvlM2o8LNNQ=;
 b=lfWl1PgUlen19L/vbN7kZzpZU8DIR3+bTBjSIfaVA0HuXuGBiu9lA3GVAEsVuAunafLAMp1gvHEkF+iSwlDCC/JkQHWP1UGX0sfPXHnnAi8ehNU77+PCnKl/3yl+RW2icYEE7TH6zQJ3rNvE6EaXuylmp4U9Gy/Zq8cjCck1pFM=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SA1PR10MB7683.namprd10.prod.outlook.com (2603:10b6:806:386::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 16 Jul
 2025 17:38:40 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.8901.036; Wed, 16 Jul 2025
 17:38:40 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v3 5/5] mm/mseal: rework mseal apply logic
Date: Wed, 16 Jul 2025 18:38:06 +0100
Message-ID: <9ae70e1c509d790cf174f16e491975efd9be50b6.1752687069.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0376.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SA1PR10MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dd7c2be-87ff-40c8-b6ea-08ddc48f9a22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4Q+4jbK/oyvqJW8Ug499UrC7dfria7htuUy8SFAazPcoQTzvzKYr72THTkOs?=
 =?us-ascii?Q?pnyvaXRcJP0lTG1U/fsejP1C7X3R7ewSuL0Cif37jQlGCJyoe4hvogsb4CIT?=
 =?us-ascii?Q?hPVUgEeLdrTUeEvtPgBD12HvlSW70rhjPDJMA+i0R9CpKOmHEp41zCEKjnAG?=
 =?us-ascii?Q?jBht6fymXoLc7LCRP5CR26TGJB0+6eSLK/0ercVyHui7bDHQS2Boyt+BzJkK?=
 =?us-ascii?Q?MJZ0zLCw42BQZmbY+/SYjgZfaT1PbYuKv5n6tmR6v3ZcXJt3BOCLBuBuqpFQ?=
 =?us-ascii?Q?Rsbu4deeiaaVRlgXNawf1WJJaGpk9RYtvZC3xH7PLzoQXXGAiDQu8gCf5u2a?=
 =?us-ascii?Q?UrMJOty9avP6K/zGJVlraMrmCSfUv7OHOwtdPtO2kf9Ci7HqNXLbsVBBsWL+?=
 =?us-ascii?Q?aeye0/IWKGR+HFu+4WV1+mPdbDWe/8cd9RWZqDDzBxCckfbGZTeNFIpcat/a?=
 =?us-ascii?Q?qnq6mfGD7/xdMq7upO7WPyH6f474NB6sXm+uMfMN4kDTO4fBeKDbv7h02suF?=
 =?us-ascii?Q?v1b9/c2RxM/SOcg6Oi6Oe1zDfgaMULQ/9nD/RSfV9UI6ERUYbhnovoMLPy+1?=
 =?us-ascii?Q?whdNOFIxpK4A+mtUnj2k2aN7j4hrXrXITVC6heqZssUIu/H268lS2wE/qFeK?=
 =?us-ascii?Q?zbUDKfOyu+QnbOTfsVV7Wbbv1dgr/rHRZQsbWskkQ8hgwwyFI3tXc1d1KkMC?=
 =?us-ascii?Q?TxIqEuxJl1WXZUOwr7e1rD9M/lj1kIUb+szYKgTbzC5t2OBuVBJJ0hP4oWDt?=
 =?us-ascii?Q?g4hFrRbY6RGWX+wMYg2HTXwIyL3BWe/DzJXQN3YlnyPB3Jivp5U5rGotoTNT?=
 =?us-ascii?Q?9hGT/aCHJVhGbHpmL/BMRZjmqpzs0eB6fCfIzr+9I8+Ah5BrmzarnXk69XGO?=
 =?us-ascii?Q?Fi8VA7YkFiIKvOn2/F9vSfpuweOm8OjCv4r7INHPbZG0OacG11UZ6pFN71QB?=
 =?us-ascii?Q?THiRVWBjQoLPZDC0JI36ZJwOGGkce5+H4/egcdMwoeM46auY8mdAhH36gG8q?=
 =?us-ascii?Q?mceSPYznisAjuCs7aeBQebmNUIInFw5LE0HDx9vhB38afoCUjYwbrJwGxSNW?=
 =?us-ascii?Q?7wVQygDIpL8aCvpgox7uHkkLsDogu1Mp1/p8QTSOmX/kDo3usSbSIo/GgUfW?=
 =?us-ascii?Q?kgCaqbg4yRxkemt7ErCgzGrwealdRMpVFlKP6FGCaaLE0biEw2K9cGbjI8Pq?=
 =?us-ascii?Q?v/WUxAbRo8O4X0vI2dy1Be0jJ7VbJM5YEruqUc7KEJyaAbV/o2CQ9uXE/Vcr?=
 =?us-ascii?Q?FKoj4eIsl+nBpcY6nHugEwc37IxVmJHWZSmmQB4TwUGs99Fl6RnXStrjjf/1?=
 =?us-ascii?Q?wB+key29e64LI6/6yMYaFXDBIlZW+lWBvbjJ1IiS50y0ZIo0Wq8pN1SQGBeT?=
 =?us-ascii?Q?sOW/O1jv+CYEdPI5RpeUHhE39jmRBzmRFPhwcLP2AmGH8woIgL7IqTxA9BZD?=
 =?us-ascii?Q?0kk6HAByKoE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PP5toL5itB0gr+46qBbMwNUcVe7wU0LXRfp4KB9fVBmKGOVJHLCFx/97zvI+?=
 =?us-ascii?Q?Mk6n7zNf3Undq4WxpyJSn52+AaL83GXP7nCzBtty1l0nCJKkZbAM9Qi0TOeE?=
 =?us-ascii?Q?RqexgFq9BgtYLgdYnLKFxhDO1NiPRbxBeQ3GBx2Rkl+DhIjUH2ZHPDo0MpK7?=
 =?us-ascii?Q?C5M7ZA71e6QgqJIKjoLi1faewJZX0X5uAmu2359UwK/V3HcIBthe4Kh3m05d?=
 =?us-ascii?Q?qeGmXJbglBRyuNyIkLaXIe/FGUYuOJ8HKVAYEJjD/7eDL0wpiVagNb2eJ5Ue?=
 =?us-ascii?Q?gnjZ0AWcA+QOjZEu0n5JQlRNZhCr0A2Qng80Smfwp5AtWkLdIsprm8+yz3RW?=
 =?us-ascii?Q?78rY+4phg7mYPCSDbky0j9jclGgLci7D1x19D6HNuHOEbEMP+1WB5Sza5eMz?=
 =?us-ascii?Q?LQqS5l2+t2KiW0RbcfBtCyLJWz6DNM9SFuow83Hm2fzWp9kodfo2QzbYzdLF?=
 =?us-ascii?Q?/hS82CDd5pU6E4waP6m9JEin6LGMyWp08l0y7qEtuMreHOjiJwou+NG9ZIXn?=
 =?us-ascii?Q?bURB/bw4AuAsXxmDfUZJ2jj0fZZK+B8gRAwti5g6uagsmDSkjfXTiSyQ5ydN?=
 =?us-ascii?Q?+VLZHf9Mnwfc4mabgxm+LAKSdKqKFW+IHW06nssABHk5jGHpPu38loPtwejs?=
 =?us-ascii?Q?9acw0FQ9v76FjU1eWs9V2hMwHoSCuo3i0BCH0pyvrGAUXHuP2Fn8B2AiKkYn?=
 =?us-ascii?Q?ZldWHv86A8UpeUpapukYA7WEeGW71hM4FqKdTVrw7MXMI0x7o/dan+0S83Jd?=
 =?us-ascii?Q?7HLG72C9i1Ao6crKtylaodMRzMU2EOG6c6S3VufByNghwyK0xzEkee2Gbk7n?=
 =?us-ascii?Q?pdMm9Zu2d0/otO6g0xJRE1meXuv3nzTiEP3a2pz4ca3SOjgqX1NVN8fn+z1T?=
 =?us-ascii?Q?/0ZkSCirgrYOiWpIQUGeQofOwDCLraDXCw15aAw93lZl31jR0gc5jp7x0w6V?=
 =?us-ascii?Q?JZ6uCiUtWhlm481lmqiJS2i9uBVWcLJdE1VoRY/T8oalHAGDAOgeSw2MAVQ5?=
 =?us-ascii?Q?pVlLKXDj4RJgLLAxEcVFB3B64iaWFA4KULF6Z/TRF6Gf6wjf+gecmN7oKU8I?=
 =?us-ascii?Q?1eIo9UEd0KSq/0dOCsReE7iCs8BoSEUa7kCaaAGKDLE+nkpW3Woo1Aw7LztH?=
 =?us-ascii?Q?eQmlfUYg9XDyEOe181fOVMqQtuoPmgra9kXMMD3a/dtJImlAmeS6lWw6oaCb?=
 =?us-ascii?Q?CCSpclIRqqUm9g3yspRNJWVQO5LZZJPcmn54YIy6stGCbzi3SXCV8pV3VNrs?=
 =?us-ascii?Q?PgifjV/Xb9CR90KvlTxcKKQmDbzMBz9fU3Nhxa+E7KzNJVOJBydD0UrOqRKG?=
 =?us-ascii?Q?EMC2DR45/KyFLhPXNrAFCjPR8wuA5o3lSoKgkhsAuUS57xx1orMgfQnX45W8?=
 =?us-ascii?Q?KTbae3KPiHJc+F2LL8La1Tti1sS2W2x0DELvvDojJWeKw5mSV0cZsL26MW0G?=
 =?us-ascii?Q?lUWtUEDwJn5M9FPitl4c6p+dITcp3MW2Izaj+rNPnrGRcRjfT0SfmZmp/nnx?=
 =?us-ascii?Q?pxP/RstjGO8ta/buJZ4RihdpH+sLc48gsBk8/XAc8MSYb9hQvjdRIQhA91pj?=
 =?us-ascii?Q?Tj2bQUCruYQP6fu+RS6FfrTqb1JPsXlkJFV48hgizIVAehIQjFjE0ia+5n8T?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bNOgdTtStMZrT3HhhTmt7Y7OtIB+56+UkhlLcSzie0XNJLRn1+Ao6IOHopHKu7Fzj1U96Zs7RkUc4yx2VP3GZ6JtbIpmkRmQAu+dsyVSmFC33aVN0KR9y7RVMmrQQ1ofjD1kV3T3pV2gUyEc/GtUUtsBUQzKjEfEOJpCyuAnl8HtHx3I5puCR/MHs/61iibx43+RO+eMI8aIK3rn43HHJh/XJ2cvH2lHFKMUuywZd3/L5hT9IqwOYTrqKgkbSUWkYXmclj7D0664Q9gpirXF4chh5CiDhsFDdtTc+TiTrgxkLcOHno04n1/86m3jO+dxzPh79MIqH3i3RYAdn4A59HlPc3UJEsaqz/JsLOaKqakIpWGjK9WVBQ6Aixp/evN3mP0I/2mxHR5k8Qw6hb2naZdSsEA88UahamF/vuUg8H2aOFo1amG1062NWvgYI2X2xY+QY113VU1OUUJR6D1GG2EHqUQW3EldLGwINGdxthzlAXHf3Asxpw7aYou+DdHo+f5LMrX6Q9TFzvLDzc6UXE8Ka6ed5BMgNwUxbo+86mnvVzI+8rfYxbtPJxelm4suazmvbz5fA2tQGwSHAq9M4K6n0C2umMUFOXQzNVn9PSo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd7c2be-87ff-40c8-b6ea-08ddc48f9a22
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 17:38:40.8353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQBulP6smTEeEn3dMYobor2mE2U9fWPCb2vkAdDdC9+Am8FlTennzdkUJ0yF6y7eTlwtb4J9NvjQ6ZTUHGhcMOhFzC/asGwi9M4Ieb2d0ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_03,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=975
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507160159
X-Proofpoint-ORIG-GUID: coAC6BBUwKjwyXJNtX3zE_GTFN_KlxBx
X-Authority-Analysis: v=2.4 cv=AZGxH2XG c=1 sm=1 tr=0 ts=6877e3a4 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=EyA4OG2UFDaUXDgDuR0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE1OCBTYWx0ZWRfXwQSR98bi50H4 wfetGAf5SqokpYwwxv+FMdRIz29p8Ngpv0/T5tUMj7KeZzgxrVvAoVC+S8ZlWUqunRMUth6V7Ka 1fCnWA75IyJyeYxLRX0gZnFcwK5/M/6CfQsZqiRr7nK1C9/jz/QrXzkVrXGL0iI5LlHOETXZJ7G
 rs8ZpKd/wdlUl3dN/PPqi/4Cy9T9fMJ98mHnstJD9kv/1au60jag8KpTVa5g0f4/iMqb1vdpszQ xK3Av3cXF08yHRnj4tmZ/ecjcxcF670cRnZFzRlZ7idyMpS3tjtsJ092fpWBlS9vAzaQuIgWK9G 0rJvqOiZXeHli8Foi9B5e0Clc4bxXCAt7KBlersRNH8fAyplCAYjnQd0sFjF0V+hu94OhKVof1N
 t16NQ9doRcYpJGTGGojTa/TJr5D41hkHhVd/PcAA5nx+FfljfHHjT8m1Q8mBCOnYIFgrY96L
X-Proofpoint-GUID: coAC6BBUwKjwyXJNtX3zE_GTFN_KlxBx

The logic can be simplified - firstly by renaming the inconsistently named
apply_mm_seal() to mseal_apply().

We then wrap mseal_fixup() into the main loop as the logic is simple enough
to not require it, equally it isn't a hugely pleasant pattern in mprotect()
etc.  so it's not something we want to perpetuate.

We eliminate the need for invoking vma_iter_end() on each loop by directly
determining if the VMA was merged - the only thing we need concern
ourselves with is whether the start/end of the (gapless) range are offset
into VMAs.

This refactoring also avoids the rather horrid 'pass pointer to prev
around' pattern used in mprotect() et al.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/mseal.c | 67 ++++++++++++++++--------------------------------------
 1 file changed, 20 insertions(+), 47 deletions(-)

diff --git a/mm/mseal.c b/mm/mseal.c
index 61c07b1369cb..0ab12e09792a 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -15,28 +15,6 @@
 #include <linux/sched.h>
 #include "internal.h"
 
-static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		struct vm_area_struct **prev, unsigned long start,
-		unsigned long end, vm_flags_t newflags)
-{
-	int ret = 0;
-	vm_flags_t oldflags = vma->vm_flags;
-
-	if (newflags == oldflags)
-		goto out;
-
-	vma = vma_modify_flags(vmi, *prev, vma, start, end, newflags);
-	if (IS_ERR(vma)) {
-		ret = PTR_ERR(vma);
-		goto out;
-	}
-
-	vm_flags_set(vma, VM_SEALED);
-out:
-	*prev = vma;
-	return ret;
-}
-
 /* Does the [start, end) range contain any unmapped memory? */
 static bool range_contains_unmapped(struct mm_struct *mm,
 		unsigned long start, unsigned long end)
@@ -55,38 +33,33 @@ static bool range_contains_unmapped(struct mm_struct *mm,
 	return prev_end < end;
 }
 
-/*
- * Apply sealing.
- */
-static int apply_mm_seal(unsigned long start, unsigned long end)
+static int mseal_apply(struct mm_struct *mm,
+		unsigned long start, unsigned long end)
 {
-	unsigned long nstart;
 	struct vm_area_struct *vma, *prev;
-	VMA_ITERATOR(vmi, current->mm, start);
+	unsigned long curr_start = start;
+	VMA_ITERATOR(vmi, mm, start);
 
+	/* We know there are no gaps so this will be non-NULL. */
 	vma = vma_iter_load(&vmi);
-	/*
-	 * Note: check_mm_seal should already checked ENOMEM case.
-	 * so vma should not be null, same for the other ENOMEM cases.
-	 */
 	prev = vma_prev(&vmi);
 	if (start > vma->vm_start)
 		prev = vma;
 
-	nstart = start;
 	for_each_vma_range(vmi, vma, end) {
-		int error;
-		unsigned long tmp;
-		vm_flags_t newflags;
-
-		newflags = vma->vm_flags | VM_SEALED;
-		tmp = vma->vm_end;
-		if (tmp > end)
-			tmp = end;
-		error = mseal_fixup(&vmi, vma, &prev, nstart, tmp, newflags);
-		if (error)
-			return error;
-		nstart = vma_iter_end(&vmi);
+		unsigned long curr_end = MIN(vma->vm_end, end);
+
+		if (!(vma->vm_flags & VM_SEALED)) {
+			vma = vma_modify_flags(&vmi, prev, vma,
+					curr_start, curr_end,
+					vma->vm_flags | VM_SEALED);
+			if (IS_ERR(vma))
+				return PTR_ERR(vma);
+			vm_flags_set(vma, VM_SEALED);
+		}
+
+		prev = vma;
+		curr_start = curr_end;
 	}
 
 	return 0;
@@ -185,10 +158,10 @@ int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
 	 * reaching the max supported VMAs, however, those cases shall
 	 * be rare.
 	 */
-	ret = apply_mm_seal(start, end);
+	ret = mseal_apply(mm, start, end);
 
 out:
-	mmap_write_unlock(current->mm);
+	mmap_write_unlock(mm);
 	return ret;
 }
 
-- 
2.50.1


