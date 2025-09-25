Return-Path: <linux-kernel+bounces-832466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AABB9F648
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF332A6E44
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EF21FAC34;
	Thu, 25 Sep 2025 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qNm5li8C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W+R9x9Wj"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B1914A0B5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805335; cv=fail; b=Wb6A6GGTsfbdpfblX3SNXGcG7gmeSHuzBW9HIwpYgIfsd9llCe6NjkbrQG+h9TLNvQJbRMv8IJtMdyurhICYu6vvlcHM0+3OrkPPxHW07Z2wTmHSpUS7AauAe2xRn+OFxZ0snFNClW3HrHVpnHRdPtOq9uLg449vva2PQNAXzxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805335; c=relaxed/simple;
	bh=CwZfP9CEMYIyn3BZ/CNEc3dD8AE6+bxMH9mCVNN+nYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sg4kFLi85WVEzEx70s2FwKJjcD0VeN959dvruEY3jSusNPjvjnSNCskN1bw5mjavDAGc2Wbx9cd1JaLJI7F+bwsV15vEe4YF1jNY8sQRGpyLqPKGB4ro/EG7DeH1pMFxRSp06WYOrq4Ndi+WQ9DwEDvE+E1zlw35FZQ8BWE1of8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qNm5li8C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W+R9x9Wj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PAtrJX028409;
	Thu, 25 Sep 2025 13:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SuPyV66By6KM6NyvXfkn7PStuNba+qGfVS0yl4AzFZY=; b=
	qNm5li8CbEaFObF4Lb2beWnMBZ+ryh+UwTzHri587u4htteSGev/sTX6U+xjuS4q
	2aEa/3uCnqBJ7tK6O4WLDEskG2ISw51SYqd/hqZMMA6zvhezTsyqKAWP8j++0UhK
	t9per1/EIdgwaa3k/nWS6IY3UuCutS/l8aXVCBn4ZS8OP2dI8kOWq4388Sd3/msv
	XOtwWN/9DngclqfIX3tNnK0SDK2sdQbQSBAE6MpzHCMenLhGI2+4Nkjwfw2TRhfi
	pTBzo3yTp6lRpWc2uqr8ZMwjQkQooDF8jTxDOwdeEwbIg+kW27rLPI8WTsAxXorA
	tS58bVxCykJVHMHyPmIfEA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jv1a2tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 13:02:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58PCIu8U021698;
	Thu, 25 Sep 2025 13:01:58 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 499jqb1k9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 13:01:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXhDMWAFM//eopPk4nTU8Y5hEJKErF8UXyqbFWJ/m2P8mOdqdJ3hJ+1JOZAqY2ZyCDGFv9Xzo89I7gG/KSb+w1lnbRGTIVT+qFAcBFolzTg4qpHI3JVglg9WFdYsNpbgUpMIvHfUujwNdiWUm6eME8qI/zRQ4sVqOzp+bw+4dSvB+v3vAzxgijRaoODxGtiUMOI6NicCdzDWMrjo8xMe7nJZqaCd0NfQEy/Jlcpa+v875jL6eWwNdR2X8d5RypXVqlCGjlZgy7XiiqUNAkSNEYffoy6L1O4CBrTpc4Wwi863IGUGBfpqFxowzgeCxahFcdt+NZI8gqvmnacIX3P46A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuPyV66By6KM6NyvXfkn7PStuNba+qGfVS0yl4AzFZY=;
 b=NLY44BOv8WQ48HZdr72hJw5zQ+YrqZ68kmC4jrazOhJgr8CLvLBiXowCwQFcJIbduhoGJtzOd/xuSoGVjpB7c/aeQ68caoH9BrrSp3rCAYS2qnlCYC4k5Szx3iA+pyCt9/L2Jn3B2bW//b4sAj1p5h0RXH7QeBTJ0dJfBc0MlJ1SyqSq6/pf8wYQIzNXg2SF7sn0Cu3DO3svD18uqKF7FzrNmZ0qUWjfhq2Ndvvg+wyvud0c8k7CrGSQzmUGg07TvV6GEVGLeAcnqW0+Fo7VIHiS1Y0iYRDs2YMj2U17tkoIH8T1eIXioQvTdcVerZxzRWpjGnZE7k4uyM+gjy/UXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuPyV66By6KM6NyvXfkn7PStuNba+qGfVS0yl4AzFZY=;
 b=W+R9x9WjeUkVVMarPv0aFLkRS9L2Y/Pxe2aLnMZ/dkaTzpkqy7gyXglbog+JgOpjpSalibxCqVk9mBo/iWaC7en1vs8yeEblQW8/ThGDErduw5hluLg1n5WZHracc0vZuIno2D3JoTx+P4DnBrgrQkwNoLaBdgU23dOpPOK6jn4=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 CH0PR10MB5193.namprd10.prod.outlook.com (2603:10b6:610:c4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.10; Thu, 25 Sep 2025 13:01:56 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 13:01:56 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.15 1/3] NFSv4: Clear the NFS_CAP_FS_LOCATIONS flag if it is not set
Date: Thu, 25 Sep 2025 18:31:44 +0530
Message-ID: <1d4bbe4e9b6e6909067d8d5ab704e5392ec42bff.1758805195.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925125800.74222-1-siddh.raman.pant@oracle.com>
References: <20250925125800.74222-1-siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::6) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|CH0PR10MB5193:EE_
X-MS-Office365-Filtering-Correlation-Id: 71571f8a-c9d4-4e14-cca6-08ddfc33b4bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SDWqWVGrdU7s3HAuW9w0oa1DMX7vscUoh9hj0oDH3/5o/+JTV5Umij+KStUJ?=
 =?us-ascii?Q?y/S7fCEYGoVs+omyQvtMqszink7+ha6XoSM1n5GRuLrQoiq/bWz0opJMpX1F?=
 =?us-ascii?Q?4tOfwmPr4zfWVpqa/kqOll2gbwtbCBUC5QgXVyKOjBSpLz7wIRHAU81N9MDu?=
 =?us-ascii?Q?HaI1ghmCwquuODJdrL6Wlsv4A9SbqxoozqQLCRZeRNi6YQQYtPkeeOKjll5e?=
 =?us-ascii?Q?mPbBXPRVV0k4r7dyMo/el/MQbXjpXGFRfmPo4x8/9VwkmHA97kkBTNWf/lO3?=
 =?us-ascii?Q?2krCPNeLnxji8kKZkrUG9IFCD2rlEufyT2WfXmlB8RK7E4SfZxF6563aCu7Y?=
 =?us-ascii?Q?oeCJrxXWfrZmnCj2pkLfWTIEtqLKee+NDbCAoFt6dl+2pUPwe1tBBgU1RpBL?=
 =?us-ascii?Q?waYt6vmSIiKFduLMot0/KdgnkPzGxkpZWvFDKpfcqQuVhZrgI6PyK5oIbNRC?=
 =?us-ascii?Q?aY8w+10jxDEp3I6LsplBIyGFQ4XLVnXsjGXcOl8zXpfe1Wzu8IPhYyf9ErXm?=
 =?us-ascii?Q?Xu9SCwHdEWccB4qEKv3WfCrHyR/eTAn0yUxtI1RuPjAWf5tujyfDCkpF4iet?=
 =?us-ascii?Q?Oo8lqALXmAkdE0MIec3XQwRmnJxFgqmUsF+QI7L2/UyYLG3okhDgpRy3GENd?=
 =?us-ascii?Q?MLPdHX1b9kyivcaJVzGYI1WQV23BxsbZy1Hwi7orAiWp//tiVdNUdTR+EDwC?=
 =?us-ascii?Q?+XQ7xsolxiKaSvBeFAB2ggVdfzXRa/qjo1bCnCsuQMmtpdMFPyncvFmhGzTY?=
 =?us-ascii?Q?oX1k3PxiUruN3K7DdVZ8GhAcQYBygi5bTFC7qF00pLt706g2EPNBOwG2D3Yf?=
 =?us-ascii?Q?Rvq1CrGoiN8ptzmUSv9s4Q1L41Fx2Sj3RNpR3IffOBTzsZq7MTjRIsH65hvm?=
 =?us-ascii?Q?fjUExxdxnXqZRfPRt4Njcs66ejdhm3EY/74S60cU37zGLbDM6kKuYW2xZAan?=
 =?us-ascii?Q?ReEjyte4ajD4xn0+gXrD7kx4qft4ibHceDT23W1tT2KvLqdTrFnY0rcO4JMG?=
 =?us-ascii?Q?xBs8GB/Ns493pNWiSr8aeeo4e5ceeUms5tSDpwH7CatGFODsyJnilni5sUXF?=
 =?us-ascii?Q?RuVAnPMF0hVhxVth512BziGJcCbkiwBlTDWfD6sZsBMwRl2IwDI7FGVvO51/?=
 =?us-ascii?Q?OFBPv4ATkYV9jFjysoSaZfFzn66AFfyYvUV1Gs4yAI6fV83ZRVgl9ZwUMS2V?=
 =?us-ascii?Q?0ZiK5/xCmgThDBhRq1Ikwv9M6wA4qZOZjRbvPir7xRH+TZOrmT93u0JzBo5+?=
 =?us-ascii?Q?Dc1V5ULOrFKLBPlZB1C4qpaqj3ELY0Rxh7gJTrNVRUf7t4WUPBUT1BYHyEcS?=
 =?us-ascii?Q?FPMAKH2w5ZjrOo2ICPhC1eamuOD/+knJpMpdxOzgJb6WB/WBq6PFgBagiR5Q?=
 =?us-ascii?Q?dCsxvm6hGzShZ2gcLNIIO1DGoaqBV0IqNOE9IlooUqZHWObQ3qxF5uDKXRKW?=
 =?us-ascii?Q?p+k5RUyC1bQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eYO9jmTbzsbVwK3Im1BX636NyZEqc5W0TlTJ6YEBn3Y89C6093SeQYP99tBG?=
 =?us-ascii?Q?492OGvaiivaNFdrtpqmZUSEIM9zW20Lz2UDa1jWkwL7WGMLWwfGLtkLIw7kI?=
 =?us-ascii?Q?QSi5M6d3KFktF2mBkjIjJGrhFmNrFV3iJdQcSv1w9MWf9MCNElcviovIJEXs?=
 =?us-ascii?Q?vY399mhaDToAFS69JUiY+GOvnuOJGIBTtyHkH8wvZbzMgICPWTeEpd2yTz2t?=
 =?us-ascii?Q?Yn2D//5Xj6FkQjklFT9dzRtpOMroaeZ/KIV4h/fsXugSr4ps3hnTnQh/Fr7J?=
 =?us-ascii?Q?oNknn9VaQ8wYia6a8+e7SiJ7bfEWFtiaCe/zNr3kb2ooWYjZKgd/1yyFgsme?=
 =?us-ascii?Q?VRVpoRSDen376UNbNNZdBbhqCmtKDa+1YFniucIm8MqxiK2n4rB/0DwLHKn6?=
 =?us-ascii?Q?F2PJRthK/jZ82nklBDmpPHNZ9tnmirZ+btOzcJBwnnjCoMhvXx5XIm/Xpirx?=
 =?us-ascii?Q?VlHwvLwRoVBFzrutdbYaFIxkhGIOMpBxA149HZJBCT2ClMi5HIOqUek/u4Tm?=
 =?us-ascii?Q?FpG9EKmm7OAsfZtBO6Ulwag4OlN5tmQ4L9Gdgu1Hp2FY743AGH8gkORxXcs2?=
 =?us-ascii?Q?8l/Fj4diZb2Eo5Nq1pUpYKz5s34k5QO/KtItUNvfpB1epV1hHP1o1S/YSgdU?=
 =?us-ascii?Q?4HeDDM1MSAy38OpcXjNAZ4Dclley965B0Z6AlOL19T2vyoIl5g+LZseGZGJI?=
 =?us-ascii?Q?niscX0EhIVazI/SYW94Z74Aex5M0XTRYQHaLW00N3jKzFyi+cBjDqIncg8L9?=
 =?us-ascii?Q?buBIjCxxzvIG+EBOd8dCVfpj5QvPFzuUg7MOX5TRVXyqin+uy6Ser8U1YDpG?=
 =?us-ascii?Q?lA+SPeC1zhZThcVrtfQRlJPmNd5vJzMZWWilh629Ih/+tkvgDDisbJx82S8U?=
 =?us-ascii?Q?Zuejtq0YSBGxSWU19pKsGLkOObAql440x3nq3+wdHeylc4KON9it4K99AHVf?=
 =?us-ascii?Q?+/fA+GNE9jQ3h7LowH1NtVOQ9BnAajGjSTWM9kRkgtKyjYNYBKE+uaM54ToX?=
 =?us-ascii?Q?rqhJrp1vsZhMXLYuGjOGwbKupJnHNXLpFjFSvD1TxgNY5cRUKMXCHitt04dS?=
 =?us-ascii?Q?83YMRbgQyCsdV3apmKHHau/udSjYrbM1wNoz41huZ32XbiJKNj+QAQ//9n6X?=
 =?us-ascii?Q?MXZudkEJKiqJ80DuVyGp5pKMGRDTA06b0I47A0bYQlc7OdmpjP9xoOAZJtyw?=
 =?us-ascii?Q?L0OXlNcHBdcW4OPgqneeneWDwN99iSraT1ZXY0Rlu0Pr/Gvs4zZrIVIYMpM+?=
 =?us-ascii?Q?2mj1iUTdZyg3+bupBDZzsGfOVvr2FyJlBLPuvLrseYbaqHT1fLew3nnLh97q?=
 =?us-ascii?Q?3GEPFNHvaLrRZyvjaiouUyi0XSOYgt+Ah2xrJLSIGONUHHXBxVUpF1c/mEpu?=
 =?us-ascii?Q?UBqfmtBDYnL7pk0AGwow+IXO48cTHfYH1uE4dY3ekRh8kvU53FqY0y2y/pxP?=
 =?us-ascii?Q?2JSWWwi7Dq9wxMOGXWwu1AwwMSdVq/Rj4D9Weoc5ozA4oBvFWgzhs7WLwNwS?=
 =?us-ascii?Q?art7rgeg3OAlI7CrdJ99FLmVDDsM17p/ndqNpwk+U1uIP0nmmQYSOIyo5ABp?=
 =?us-ascii?Q?kBgiQY5DcDE4CSP5nzlcr+2ixkknNNJvrBwqqAZiKvgakVTKku/q/WcenQME?=
 =?us-ascii?Q?eyvo7mdE5Xj5AGsAOgwvjXSnYOsmfvbErwckdZN0/3T5s+IG3eNddiLSrwRt?=
 =?us-ascii?Q?o6EUWw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vy+dYWH9+IrKg63q7q6I84se9rlT2Coofv3DcW/EnrPPVhbQ0/hAoSP0ROWvH8XvXBNoqBDtyZ6K2343GpFwjX7tYQjvrMIn3rPAMIvu18Wfr12PMRgiJI8Nv/5Pbj/WYJv3xylgJMprZlWJb/9GomE7x9hQGuAp5xKeCAJ2pGpL3aS0zrShsPd4arQYqFLEiuscGG2elAjDbETnhVAxpL9B5QM1MmVR9Lmyxso6LK1y/Q3kl/81nOeQKdoES4NGoDXc8t/MuKmUFYj4D+xrgEZBeA+7myPlleYYCxqbKq2XNqKlX3e1M3XSjoDjZQzaiiWYr99iJAKXAmKhYF2M26aAt4IzGmeSto6pqYilQLcjkMj68qKk+2edXJ3Y1Co2RWmQqR8r/IZnndEmR+segJ8lyt66utszhm2b814puXHbUOYHdklJ8oA35K7/aYfTzNLKVzvVcppbHy+9vXV+n2RxZXqxw6YKPpUm4NTymvyNrHvGoFz+MjDJ5pAHVXrB80kFgwUIxUNIE1H8Ybr8dEctLX5Z20sTBOeRu234KOgAsx6l7H7teYkM2D1gAH4EKKsmtaHHtOughbsM0PWfP6DdcaK0vSGIK15zWc3K3wI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71571f8a-c9d4-4e14-cca6-08ddfc33b4bb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 13:01:56.6097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwITvhtzwUEahFkYNCzvFF/5BGe4coxzw8Ch2TCDFzlo1YEzeBDSrrkbpaw8nkPjvuGhzB4tZar5o1lXI4PpXL00aOnKDCCC8hLCylsOIM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509250122
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMyBTYWx0ZWRfXxrqCqLv2EPZk
 ZABdigfzNzchjC6CIjag8wPPPMunYnrn+PsrjlEaDOl6baCY0nc/gcZ3Rn9xChHjtyecoHEFZOP
 MNC3+L/Bt9LGz9nHBSd++WL1oA5YmAnovLMOpr8VrBafhNQmU9o3zEcmAOOrcCaYnw/FD/TOEPw
 /AWRie2ZjjaHTtguGIkZZ4r5oa0Ys3f1nPyLszhIie6u0wComu7ytnFfnj2leI4kGzVwnuP0TJz
 KQawjFtXDCEGHKC3pJVoRqGKb8sseIBHPE0YrTJ6PAbOtf15Qagb9mW8oFDyd8BhxnXTiLH6vA7
 mVgiuajS0qdl3R0+TPQJ97RxlE5O7NnuglqDOUo5zm1cGV7QSL/1Z0JuxTaLkj788gY/aDfmoCV
 qPe8MPiKacGEGINq6E92qpf9DTQjcA==
X-Proofpoint-GUID: 4wUNoR2Bir7LDc9vc8-H3Da5NpXmVJe6
X-Authority-Analysis: v=2.4 cv=YrMPR5YX c=1 sm=1 tr=0 ts=68d53d48 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=-yBNYp4ZcZhI2Ymk:21 a=xqWC_Br6kY4A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=SEtKQCMJAAAA:8 a=yPCof4ZbAAAA:8
 a=0edzPUMpuhp8A0VEMogA:9 a=kyTSok1ft720jgMXX5-3:22 cc=ntf awl=host:12089
X-Proofpoint-ORIG-GUID: 4wUNoR2Bir7LDc9vc8-H3Da5NpXmVJe6

From: Trond Myklebust <trond.myklebust@hammerspace.com>

_nfs4_server_capabilities() is expected to clear any flags that are not
supported by the server.

Fixes: 8a59bb93b7e3 ("NFSv4 store server support for fs_location attribute")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
(cherry picked from commit dd5a8621b886b02f8341c5d4ea68eb2c552ebd3e)
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/nfs/nfs4proc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 65dae25d6856..3d854e2537bc 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3904,8 +3904,9 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 			res.attr_bitmask[2] &= FATTR4_WORD2_NFS42_MASK;
 		}
 		memcpy(server->attr_bitmask, res.attr_bitmask, sizeof(server->attr_bitmask));
-		server->caps &= ~(NFS_CAP_ACLS | NFS_CAP_HARDLINKS |
-				  NFS_CAP_SYMLINKS| NFS_CAP_SECURITY_LABEL);
+		server->caps &=
+			~(NFS_CAP_ACLS | NFS_CAP_HARDLINKS | NFS_CAP_SYMLINKS |
+			  NFS_CAP_SECURITY_LABEL | NFS_CAP_FS_LOCATIONS);
 		server->fattr_valid = NFS_ATTR_FATTR_V4;
 		if (res.attr_bitmask[0] & FATTR4_WORD0_ACL &&
 				res.acl_bitmask & ACL4_SUPPORT_ALLOW_ACL)
-- 
2.51.0


