Return-Path: <linux-kernel+bounces-806663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB2BB49A14
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3571BC371B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403992BDC2C;
	Mon,  8 Sep 2025 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="boSipc6i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ub9EqViN"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A0945945
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757360174; cv=fail; b=GMGSKpsGAxs5r8aSE4KR4a9oRB7jpSdpo9+CiAjFd/Nkcv96VtMnkmzC9izx0+O7LyrwZF+UeYQGfDovWftwcPRm61snYKXCJ0T1WGBdCDv/qeVw4j/iyNGVqbTRwOU3wZCoyy/NMoIFMEzxdP+IxLVc4pZIPeW1QXMFwxjNl4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757360174; c=relaxed/simple;
	bh=5WZkIVbEzZWjvnMz6xELao1BDxv/CXT4sKP+uYku5Eg=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=JLZyDGVpHng8vY2cm0Iz8NAxPpjJs+L+HqI/YBBb8Mx0Vy8VKQTv1bEmY3I9Jm+8pRewaB6NyF1L+nl40o1D0J16yfOMCyll3W7lxJ3y+Q0VDqrleu/UcXoaqJ6OmoMIKxGCkEwg6ExsrCaCQbqPdwIib0aSOoSp2Q1X+EbxHh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=boSipc6i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ub9EqViN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588HfwhO007466;
	Mon, 8 Sep 2025 19:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=de6uD5ExhRkbDSg5
	SyqrQHxamSRcLulfghXiiAK/oKk=; b=boSipc6iVgo06X7/5HK6ZLtYRGD2/AQU
	ZKw9/vzLh+nLVpvOkHDPrvgoGgcu5UpeWF9no1orz7/MjTIxSZy1zBP50vpM4zje
	8uhhY0PNvzl/bp9rdO07+M095YCka65tCoN3CQ1QfWX2BGvWFFojsDABcOS2h0Eq
	W7MDI6BbvdMI3rE3k1SDunKJ0WoRa26sFKwqXMOtIaRgRHIktHuVA3tHNhNqS9rH
	vxwraM6GSJgOGXhVOBNjkTX1G4IOw07ytUyE3OymNsshvjGqa6WhhsRyZUkmV9+K
	hvr0G17DOMx2fiRc6SKRjsoSSH0hxb/fhBskzkSqZIeV1hCuy+DPQg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922x90ajs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 19:36:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588JMjgN038704;
	Mon, 8 Sep 2025 19:36:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd8n6wq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 19:36:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOZAPsQoT6+8ICqpBjF4nPsjK8F0s4rOwvm3BmDTKeklNvxN579WAs/uoJBL1ucCKwNIdiUqzjvz8krMGJqibT0gMjsrDsEYCIPmLlEQiWCNvd5mNACT9oK2SL8hCs6CzM+7/ZK46Mn1vXg4VEYwaFjkTUPFp/8Hx/hXd4E2oj8dI4EeLipg1UXJehiK/f1fTwAPAoJelk1Gh4juXu+xiFPYtgWFVWpujfjst0qyFIDGdQM/QZXj1tfUZVTbqlCmOlsky17s1atVZr1DdJ/Dy3ZDsvW+NT/iP+WuCs5wqQSgGI9/fPYg0t5RKgT3K1ONKwxD69OMTiB6N5NoxjINgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=de6uD5ExhRkbDSg5SyqrQHxamSRcLulfghXiiAK/oKk=;
 b=MejwL8G++MpwzhCd+IXxBSapT0sOcNoxHmS9ZDD8aQtSv06sYsGUA9hvjEuB1kOM1uYx+EM052y/+GZLrlArW9gApqT2ifUQtRi5LaItMCFvsnG2bOYL/BXKgMjX1ESk4CCuNUwOetHLxpoJ0lAERHza0tbMjtSD1HWR9l+bEIQ/AupshtB5FLcKnSkefokO2QuqUKoaqcr8JYOy2s5G0oS3vpkW/IT/jbfRUNRDF4QjWhL5mSGIEdaqepCczfF+0lK55sTtLmveF5XqDNMAYMCrJjWCfB9l4y84Zy9bJ5jXvfpe6MbYovjndnagnScYXEZjzS6HD8hUIJXeLt2VxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=de6uD5ExhRkbDSg5SyqrQHxamSRcLulfghXiiAK/oKk=;
 b=ub9EqViNasLYpjRsEhFYHNudHBPJn2xQDN3QkdTXfDfjUjmidgH0TBS3NGhQaGOz5BESBnzI2LeRKWCQSITAhBLiyhfZ094z462QyFYDpODjzeb0IlQoKnclNHChpxq0QCpdI0FcZM9zd8DmsTMNwhqujm5dM/gz8jp5tJxMmew=
Received: from IA4PR10MB8421.namprd10.prod.outlook.com (2603:10b6:208:563::15)
 by CY5PR10MB6215.namprd10.prod.outlook.com (2603:10b6:930:30::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 19:36:02 +0000
Received: from IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77]) by IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77%6]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 19:36:02 +0000
Message-ID: <e3e57e5e-70dc-420c-9f98-2278c2505979@oracle.com>
Date: Tue, 9 Sep 2025 01:05:56 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [Query] Generating profile for propeller fails
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0343.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::19) To IA4PR10MB8421.namprd10.prod.outlook.com
 (2603:10b6:208:563::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8421:EE_|CY5PR10MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 251dc06d-5f15-46e8-8af1-08ddef0ef1d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnlSaEw5R09acXgvSEpEekw5ZG5DOW9zNUdFMEQvMmNVanUxaGVCakJqWjJq?=
 =?utf-8?B?UGdIbmtpMHM2NnRWSXZ1S1Z1bWxXa0ZNS044cDh3c0R3aHc5a25pUDhnTjZE?=
 =?utf-8?B?Q1Q2cCt4YkdTUVUxbG5kcWdCMVZpTUV0YUU3WlJMWUtTNHgrMHpocGtEdUlY?=
 =?utf-8?B?MUV6ODZHUmxUYld2VlNnbERFL253ZEN3VUtIajZKN09LVlVER0hJY2dIVUFQ?=
 =?utf-8?B?anpjNGJLaU1LUzZ5VHZZZUJmaitMaTI5ZTZmcVBGd3ZQZlROdWMxN3FROUlS?=
 =?utf-8?B?QytXLzhSeG95M2VDTWlESitwcmRBWnlWb0lmMkNIYTdES2xyc1JkQVA1L2pk?=
 =?utf-8?B?bVpKa2w5MEd3RWV1RDhhMmR4a2hUbTl0ajIxR3I2d0J0OXVpK3dtRmhnN3Y4?=
 =?utf-8?B?Vk9lNXdNaWpkcEl1NjNHb2J5dDI5QkJIbXRCTUROOGFhN1RIcGdvSlhnV0U3?=
 =?utf-8?B?ZWNmL3BHZTZidmp1SGVoRGQ4RFd1N3o1ZFpyT2ZTcEdKZ3FWOHhORmVyMDhu?=
 =?utf-8?B?UnhKRFBjQnhuc1RhQU1DdytaZ2ZRWHN3bU1nVWZJd3p1ZEpXODI5eWhJbExK?=
 =?utf-8?B?NXRoN3VMZEJaSENGZ05ucnFQUXlkM1RYWXYvR2xSQXlTc2FONXRXWU1Fa292?=
 =?utf-8?B?RmY4WnNPMVFVd3RMSFMwSk9qUGNZRnkvOXBFQkRPS1Rza25JRDhYTWNTSnB3?=
 =?utf-8?B?MzZKRFFINHJRNmJEN3VKRENnSkVUWjlhVjdEVEQ2SlFzczRLU0ppQUdvTVdl?=
 =?utf-8?B?WnM2dktWL1F2QzBhdDNzdEhJKzNtaFhnemlhWnZEdlhGQ3p2UE5iMXNIQ1F6?=
 =?utf-8?B?NFZ6bXFORFQyZWFPWktEMEJiQ1JXWWszbVFxb055UXNHVDdsQ1hOSDlwMlYw?=
 =?utf-8?B?NzVRNVR3cEpmZG1zanpHTUlEdnAvZnZBeld1WkVUNFA2elBjVHFXUGxnNnFE?=
 =?utf-8?B?NFZDMlkyNlZDUW9sNktuRElaSUV2bFd5TTc0b0liSW1TbGFVS1RIMFZuZFBK?=
 =?utf-8?B?emNudmFMTFdkT2pWNlV4U0x6K3J1YVFiYkpMSGxnRDYraFd5c3lScktPeVU2?=
 =?utf-8?B?ajJTSmFob29BUU5LTlpDSC94TWJQYzczME90Q2pFT09FQ2Y2OCtaY1luL2F2?=
 =?utf-8?B?WExkamcvYVBJZEl3dmk5ak1DaFFScnZyOXp0bSt0UmpPeDNMZEdndWVndUVJ?=
 =?utf-8?B?bi90d29sZ0pLL1NKbUlRSTlkSExSQ2laTmRZaGxyZzBpeW0vR2dkL2UwSDRV?=
 =?utf-8?B?clptNlNpL3hpSmRaNEIrZVZLSUxMS0lSTXl0UDJTdSttQnIzbDlBclZmOHVX?=
 =?utf-8?B?YjlmaXpLVXN1ZmpNKzh6bEJmdU1iR2hmRGJxMnJnN3JMWlRSZC9MR1NXMjJl?=
 =?utf-8?B?bjJCcm9mSXZGUklsV1lTZHcrdDlJMHQ3SFRLTUY0Q2VyY29LeWZ4b01TV2pR?=
 =?utf-8?B?eE5id0JvNnZCaWJUcFZXa2QrcVRjYnRYQ0gyMWRmNnpxcWl4NVpwU1JIV1hN?=
 =?utf-8?B?NEJCZWlzbUZUd2lJUGxOUjZ0OWtQQ21iVU05S0ZYOUkwdTYzQVlqd1V6bHpj?=
 =?utf-8?B?L3kyRHk0SW1DV00rUDRHbjBjTmplbm1jTjUwazZMeVNsL1ZGOFBuRHAvbXkz?=
 =?utf-8?B?Q0tRWDA1ckRDbmdtSXBIdHR0aU1oQmREUnlhMmY1UXJQOEFiOE5XdEVWVllz?=
 =?utf-8?B?YlJWc0czTDlJSE92RzlPOCtHTXVmZVdVMlBLS2gzZTYrYUEyNTFtZFRKa1NW?=
 =?utf-8?B?bnpTOVF4Z0ZDbnduOVNML1owT0tTZ0c2c0pyb3N2Y2RNczMvMjFEREFaSGFl?=
 =?utf-8?B?L3k0dk56ZGZKQmdUNUxyWG1aUkV4a00xL2JNKzhhMVFwblNhYXp5bFBmeTl3?=
 =?utf-8?B?bVN3dENSa3RBdHBpRkRjbXZtYndtb0xMSVVHalpGSGQ0dUsrUTJtWUVIRXAx?=
 =?utf-8?Q?Fb5jSEFVnJ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8421.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTN3SityV2ZVaFo1Z3hzVHpYZndhOGszUmtqYnNGcDJseFQyU2NuVnd0WU8y?=
 =?utf-8?B?RTVkTlBtK2FCcURMK09nTDJuOWhBYWlJUkpIYXBINnVhMUt0MzdzOGtPdGVp?=
 =?utf-8?B?MVlESGxKSGRGTjJETXVvdFJRZEltT0orekxESy8xbThlSmJnYmhQeGwzRnkr?=
 =?utf-8?B?VmJ3YjU1ZUtqYllzU0Fib2Vsb2xsU3dnU3BiOWVpUmU4OUF1SGlVdmdqam90?=
 =?utf-8?B?Z0VkcVBnMkltZTI5c255ZkJUa29Oei8yRi83ZG5XbXdseFNFWUtDajZLaU92?=
 =?utf-8?B?a2VWdzAzSDE5V090cjFpYXRUb2Qxc0JKTWZTN1RRenV2TEtPaHNQUE0ybDdr?=
 =?utf-8?B?QzdDbDI3eHdlSlRxSGNVYVhBVVNJaHdPbzBLWnNhelpnM1RqSmtJa0oxR1FN?=
 =?utf-8?B?K1JYeXQ3dVdXdHJTU3RJOFJuanhiei9iZ1dHWmRhQlFJbkJDRXYwbmFTbXZI?=
 =?utf-8?B?OTYrRmtZL0k5SDJyaUR1UjF3bEhZVitMSnIrTkhDWXlNeVdXQWlMZS94WWdW?=
 =?utf-8?B?OWhUNG1YaWI4YzNmaEVySUpxSWpzbWhITytqTmVMdFN6YjhOaHZMelN4RVZv?=
 =?utf-8?B?a05PcHg2anlzeEpWZ1pSRmxUei80WHQwTGxNNFk4N1dHRnZ6M2ZTSXdhUk55?=
 =?utf-8?B?OXhqMFF6L3FTbnFueWs2YjIwbTB6QVhiRDZuL2x2TDdBNk1BVDlSNDQrZnhM?=
 =?utf-8?B?K1pCb3NpK0kxeWd4NXVSb21wQmQwbXZqY3NkL2FPTFkwQTdlR3dkd1Y0bmc2?=
 =?utf-8?B?MlRuTldyUUhEYmR2NkxQeVRwNE9TUFJEYXN4SGQ5aXhkbVZ6MFVMcXRuMmlH?=
 =?utf-8?B?RXRoNUtLR2w0dldDTC84U1J2cnJPNFgvQ2dQNVpmcHZ0aEoyb1VwVGk1cXlB?=
 =?utf-8?B?ZFpTNWJzbjNwdUZUbG9VbHYvSnIxT3NsdFcvUTFzOVh5NGNBWjRpWUdCZ1Vh?=
 =?utf-8?B?aTJSNUdnNDNnWUY3UlloT1MxbHhyZDAxQ3YxMlBaK2J1MFRXRzBjSTF4ZWVl?=
 =?utf-8?B?MnNHSWR2MXg0eE93ZlorRTdZaTl5OXovV3U2ZkdaRzFEaEMyZjBVOXg4cnNm?=
 =?utf-8?B?ZldkM1ZZQ2djRzdQcDRvbGw3T1MzSmFXSW50eFFpcmFrLzhyNEhUTC95cXBD?=
 =?utf-8?B?Yko3S0huNUx5cjdRd3FsSEZOSG9hS0dKS3lVZTRqQlVNdDh6eVRhS1dXaTQ0?=
 =?utf-8?B?dHNtUmQ3NE1VdTV2d29nMzV6RDRBMlhVVHlzYlhHYVdqQVQrMVZsVEJsdk1s?=
 =?utf-8?B?TjZZWVlDTGdGcTM4cDJIbU5ZME9Zb2tUYkNVdkI3azJkUVc5RUtXSXFsT3A3?=
 =?utf-8?B?VVB6TUJpOEd2eUdJZEw5M2ZlZHFicnloN2pPc1pCNTFXVzNOenBrVDFCTHVk?=
 =?utf-8?B?SkVsdmEzaURrakRFL3NmVVJpY1NKdGFHSmlnV3JhbW43cEl4dkhrcTZoTlgr?=
 =?utf-8?B?R3BaSDdUSExBbHZ2S0NLSVZnUnRMbS84Y2piaXI5MDZtS0NVV3pnTG5ReFo2?=
 =?utf-8?B?OHhhOHk4aDZna3BjQUpyN2FBb3dlZWtFR09vRURUaFpmaHd5T3B1MmRYZVJr?=
 =?utf-8?B?WUZnaXBGcWlOQkNBNGlKV2pURk13ZkEvekRteG02a2hGaVhDWVU2ZzVOb2J0?=
 =?utf-8?B?anY2Nys4TE5pdDNrSi94dG9GMk50V0N2bkxGV3NnMEZrL2pBTWFtVE1RemJB?=
 =?utf-8?B?ejNHQ013b1dJbmJMZTJDK0M3SGhleVFtN2NnNXZuRTFZSVI0aTNobnRxbExP?=
 =?utf-8?B?UEJJSTdzTGVtazd3N0VxRGFqMFNxVXlNeFRPVW13L1ZZcW5rOUpQbTRZbmU1?=
 =?utf-8?B?T1lvajZyR0Zia1lmWFFneHZpaTlGb01qeUhzbkFUaUV0a2RBN2M4b2U0VEEv?=
 =?utf-8?B?TEcydUhEZ3NIUFJ1eUx6MjYwRWgyNnB3dk96eVo2S1FPbHhUMisxaXpXN1lj?=
 =?utf-8?B?Zkl1Tm9VS214T0RwWjFHck9uZ01aSTVGZk9YUklBbkRLak9FalBlNjFHV0xy?=
 =?utf-8?B?SytjK1Z3b244QXR2YUhuejNjMDNDWk5WNmtjK0loQThtblMvUUdIMi9LSGRP?=
 =?utf-8?B?VXNQZlllS0VROGk0V0h4K2t4Rm94WHdOUmhoUVJxanQxS0hEZk14M0VPYS9D?=
 =?utf-8?B?bTNhSVlPemF0N3RINDFvYndXakQ4ZklZV2RUMVlweXJNbXU5M3ZVRDZPSVZ2?=
 =?utf-8?Q?usiDl26zSDspWgYjWa1jDeo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n6LoOz4idCHo0c8TcsZ81S2/A12z0MUVB4QsYh73jSpTinNu7sINU5idG40x+uCuHZmBXrGB0UCLD56/leequtw4CtaVcD4QAnJQ4zYdcThRewfPtX2P0F8U/u91kJVodJdRM67/FdVcHBddVwnoMras5R0nzmn0W2HkrpHLflyBm6SYEqqrFN8mHXPkvbDaVi9flk0zj0/VCwmOHfsXxatzcZw2LroQB6+95oeHc89b2EixGn3yFHNfpleoHNgU6ICZLImq4wgyyOneBT+l+AwIrv7KkZDOdlrpziesl4Z4+d5UQ0CnVkfAfmSuxW159H5f7T5GNyvecJhziWYSgWQYEoeTqKf0QeBlL9r/j3f5UR6PRbUVabnYaPS9Vy1RXxdJwGTtNAOg+ZOh66TXbPkLuR338Cs2OwPOl4qiQJuRMqpIfaK7tNXw07y1dX1WEXjfWiAicA64GXEt9nbA5Di/rgJTOl/aj/xzS9PxL8BO7TGCHou/nAwhLHiwdVcCsv3hIxIAw0DVEevZVd1RDaICif0k000hQLcUXAH/TA4T2CgTOaWa3UewLrGsXUPvXVEAJjuuyb1VVJvye1y3qVy85yAea91ZrsDMFA4sReo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251dc06d-5f15-46e8-8af1-08ddef0ef1d3
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8421.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 19:36:02.4091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FYBMtDMvEZ8eVSuLY+M5kihOxwODNGR71IRPU238LsOwEjoXIGB35ffl2asTNKD8BY/Df1yf1AjKC2Wdg5wjPW5r7Eynfhvf+3oOySeTCUY7/DbZHPOlF4xZr+tz+3qI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6215
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=957 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080193
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NiBTYWx0ZWRfX/giaBSqrIPY5
 kxUYzuT8TAzACc6s6MXg71UeeqTfIjMoxwnE/RcWZ0rVJ0YWtSBuayzEgYp8OezvzJzAiYWtLH+
 ZXdckfMUdRGvTKQW3ThfEu4Wz3NXfwC6Oanf0T9MZNhZzbGbPMkFniXZETVn1fuqzR3vqQDDvcp
 oC7AywRdiV0Xt3MYKamC0XdI1S2wMxxZKTqt5kAK9mzbbMW0gab74wtrpc7GV49x1lyFZwBEa2W
 pujZjiKcgsdjYUdldomVHbMsJp0oI/eDeqDtW1eafDbEXfae1LYcMfYSiH+SU+jA501GQ2z51jy
 eFrnhbPcfnWKDabWH/WGUAEFWaJaKr/SFQhPz5GdaOLjcd1gVt2ZvT4gWwpyCIlQ2++6m7JOnbn
 lP7tBy38MCR2zYu3colrPvk1fxP0Kg==
X-Proofpoint-GUID: XSUXJ0NIPp77KLlVfyROM5fztNgTvXYL
X-Proofpoint-ORIG-GUID: XSUXJ0NIPp77KLlVfyROM5fztNgTvXYL
X-Authority-Analysis: v=2.4 cv=LYY86ifi c=1 sm=1 tr=0 ts=68bf3027 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=xi-v-lbWv0uh1YKWhzgA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12083

Hi Rong and Han,


Thanks for your work on auofdo and propeller.

I was trying autofdo and propeller with the latest 6.17-rc4 linux kernel.

I have built the kernel rpm with LLVM=1 and I have installed LLVM from 
latest source from the git. (https://github.com/llvm/llvm-project.git 
93c2eecda521049ca6334830a69fdff54967b440)

# grep -e "AUTOFDO" /boot/config-6.17.0-rc4
CONFIG_ARCH_SUPPORTS_AUTOFDO_CLANG=y
CONFIG_AUTOFDO_CLANG=y

# grep -e "PROPELLER" /boot/config-6.17.0-rc4
CONFIG_ARCH_SUPPORTS_PROPELLER_CLANG=y
CONFIG_PROPELLER_CLANG=y

# uname -a
Linux hamogala-vm-1 6.17.0-rc4 #17 SMP PREEMPT_DYNAMIC Mon Sep  8 
07:49:54 GMT 2025 x86_64 x86_64 x86_64 GNU/Linux


Collected the profile using:

# perf  record --pfm-events BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c 
500009 -o rc4-propeller-intel.data -- load.sh

# dmesg | grep -i lbr
[    0.289671] Performance Events: PEBS fmt4+-baseline,  AnyThread 
deprecated, Icelake events, 32-deep LBR, full-width counters, Intel PMU 
driver.

Now when I copy this perf data to the other machine where I compiled my 
kernel and tried to create a profile with create_llvm_prof tool from the 
latest autofdo project like this:

# time ./create_llvm_prof --binary=vmlinux 
--profile=rc4-propeller-intel.data --format=propeller 
--propeller_output_module_name --out=prop_cc_profile.txt 
--propeller_symorder=prop_ld_profile.txt

I run into this error: ( Note the kernel is autofdo trained kernel yet, 
but I am trying propeller directly:)


W20250908 19:18:38.009934 2251492 
llvm_propeller_perf_lbr_aggregator.cc:103] not a 
potentially-control-flow-affecting instruction at address: 
0xffffffff8184d60a with counter sum 2090, instruction name: NOOP
I20250908 19:18:38.013391 2251492 
llvm_propeller_binary_address_mapper.cc:463] Started reading the binary 
content from: vmlinux
E20250908 19:18:38.115377 2251492 create_llvm_prof.cc:238] INTERNAL: 
Failed to read the LLVM_BB_ADDR_MAP section from vmlinux: unable to read 
SHT_LLVM_BB_ADDR_MAP section with index 59: unsupported 
SHT_LLVM_BB_ADDR_MAP version: 3.


Any suggestions/thoughts on why this could happen ?

Thanks,
Harshit



