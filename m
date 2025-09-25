Return-Path: <linux-kernel+bounces-832161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CE7B9E85A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D95C160BF2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9EE2E8DFD;
	Thu, 25 Sep 2025 09:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VvoQnmKO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y+9fUDlm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70662877F6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758794187; cv=fail; b=V6TSh6ENl3ipUL5wz93sKmorZEioVI7ZW+YFUkYqbHIpJoF/bT/fmrOhyWAmAxDocVBBQUxTg+2eGgKPwdEq1pv0o1TKLanvnimc3A3Udof5HdnAKjeZRPQ13Qz5msjyiHzBWa5ds2wZpDItTnw8X0ErxHPToy4YfpVKz2nxyeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758794187; c=relaxed/simple;
	bh=Wzb77ZJpDGSjWCGOnyx9avSnd6KHrwixIuiYeABk8zo=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EA4Dq0xzdztFv2/TacEUXGfbX9dplAJZ/oS3exRgcnKhYQVyOf4Gz0IWlCsqKFJ1eFQSmmh2B0xYPLf0RtwWuHoGMyJjtVXo5QEl92RTamX1jCsG1HC9gnTf379vA6jhC6b45K83FGtj7fmfPj1ODct+3BB3oBGwjWITXhY1mVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VvoQnmKO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y+9fUDlm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P7tx3c017265;
	Thu, 25 Sep 2025 09:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=u1V8PVGJhK95M8+uDjrwIKrGT8eF6YkEznmyPXbF1Eg=; b=
	VvoQnmKOzEq3v32Zyiap4KTr+wJRflnIkmSqcBLV04gBd5BJUdkStH7Q0TY2X9Th
	fs2snCS01L8iwntqDt8yG+x2TeCGcrmQYnNtiV+xahFhr7eoKM01fygIrNTaHvh+
	g5M9FoU+rLPksWzRSEEaqJbF6ftmYJesNX94L/QzGNoReH8cm/pF/vp4R8AJcYUQ
	hbgfloeAFOzV9BF6JeC6QnBj3ww3dvaaFxZeIwR8H7h9Z1nV8u39dijLAjDlGKb6
	jMS2BD9cf0UrNx0b6/Mmw0LPzKV6snLrgbefSYuvZh1EVUlnaKOxbPrgzEIJZjKD
	F4ctz53DqsWudTq9p00hsA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jv19s7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 09:56:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9p4mQ021641;
	Thu, 25 Sep 2025 09:56:20 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 499jqaut5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 09:56:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pK0k7Vctl3okVdeQjLHI5y8Zrfn7Pc7VWQWEEoyTF0Gn8FqbhnEmVcFpcfPHu3D5T3gTzYeN0r+LJtF0CCAVh+saFjt9Ls38QLMFsG8V+A8JHSzOqHaCBg5QA1sqYqw7P/0sWB7RheZwHxgD9R4CP/dIGfKrGmM7sGT+zf6MW2VnRAZq15g7OElZCJyKOpVDLDYorv24NBcq25V5Yae4HDM0VBo6OoLQZu5DJxJiziVFxYJHKDuj7nnD9BakIBysCtfOna4j0w5pkG1L2eAGgpWtYbWhVEj1xKNqGO+g6jq+M7HWV2oELeRyk5uZc9ZO+OaePf/eE6vaoRtrCZ4jTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1V8PVGJhK95M8+uDjrwIKrGT8eF6YkEznmyPXbF1Eg=;
 b=A4zk83yKNTMaXsaVuzYlG53WZWz9c4xPczQBcKTp1o566Ifnzjp78hy4lGI+xE0b/gnzsFWfK5GVtYv2AUNqijTGqdV4Yrso31NVhzL0RdMbhNOqiPpbA7dNAnCJ7aq/sJiA+wKGc8K5YsgudVFL0Ip5S/om5xBvO+0sTsYcXzpotNrJuKsCn0+I2vbgZPkNyRAmFH4/6mBXtULhNjSvrDkQjOqUOX0piQEURTdhQuAr3Ot/z7SPBBk86urP9zi0/VSHljuTB/70U224Nvvr/FiKxEbfx7OS+jiftSTHgP4y1pi7XgFKQCIRsSaLUcgdZc/EiXNZQSmzxZZ0QEmLXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1V8PVGJhK95M8+uDjrwIKrGT8eF6YkEznmyPXbF1Eg=;
 b=y+9fUDlmJdEQrf0gOzEL3M7yex6fpxBFtM0799C+6XZCBtWF4S+S+yog5RUSoHvBAcKUwjy8YL/vooA6QChcGtpoobDryGXHD4WYfYOX5iJ1IZJbrpB/hEQRoNP4P1LALuD5C2HMbmyCKh31lkIHA/5ioi6aCQnXbsjLna7cHgs=
Received: from SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18)
 by IA1PR10MB7287.namprd10.prod.outlook.com (2603:10b6:208:3fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 09:56:18 +0000
Received: from SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084]) by SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 09:56:18 +0000
Message-ID: <96fa4e52-6d38-49e0-b298-0d824ec9aacf@oracle.com>
Date: Thu, 25 Sep 2025 11:56:15 +0200
User-Agent: Mozilla Thunderbird
Cc: alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] objtool/x86: Add UDB support
To: Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org, x86@kernel.org
References: <20250924134507.288529132@infradead.org>
 <20250924134644.027686159@infradead.org>
Content-Language: en-US
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Autocrypt: addr=alexandre.chartre@oracle.com; keydata=
 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
 swLliy6PdpST
In-Reply-To: <20250924134644.027686159@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0003.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::8) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR10MB5622:EE_|IA1PR10MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a5a6d0-3846-40be-f2f8-08ddfc19c5dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0V6Mnk1MSsxQXVMRVhjYUpVN0xxcGVjOERDVytGWDFyNkZybmVzQXg2UG5x?=
 =?utf-8?B?RDFSV2dBQ0kzYVREOTBnZGVYRUIvRmY3TmU2V3R3djJoRkNhbmd4RzkrNEFJ?=
 =?utf-8?B?SnNoQmJtR3NCNmNwdlhvRzRQSEcvR3NnVTcrOVREZk1CV1RPZDhnakVDVG5Q?=
 =?utf-8?B?T3V1d3FGeVZ6SDdPN3ZwVjg2TWJOakxZQ2NLTmJZVHFCYmt2NStBb0ZJTHpF?=
 =?utf-8?B?VXRUbUMzMzFDNXBPVy92WkVNeFdEL1Z5SmRhQmptRVI3ZnllRVp2eSszaFlD?=
 =?utf-8?B?aDZqUHJabzV5MG9PZFAxN0VPMWdIaEZaZ2JMWXU5c2xHR0FadGpzVHY4R1ps?=
 =?utf-8?B?OW5sem5DbUl1SXdBZ3FHc3pQTlVWMVJKczRjaE9YZ2NONkRaTjBEWEl0T1dj?=
 =?utf-8?B?SS9HSVE0ejNZbjdXMFNQRGZZbWNzSVFjYlhqK0pwdXZkSDg5aU1ZOHdiN1Rh?=
 =?utf-8?B?dmpxVWtvSDJQVHd2bWlGejI0NHoxL05ZSUZWTHkrd1VEQUIvYm5rMTlSQnFQ?=
 =?utf-8?B?aTgwZzhaWjcrTnlSUGg2em1aNmgwakE0TWtoT0E5eVlLQmhNdkZDLytoZG84?=
 =?utf-8?B?bDFXWEZqeTZGVnJydVRyZktNTURhY01VV3VkWGhwNnhSTTlMU0x0NWZPTmJn?=
 =?utf-8?B?dk5KV2dXb1B0NzVqUkJsNGR2S1Bzak56K0NjSE1tUW1jcXNmR1Q5c0JWOFVq?=
 =?utf-8?B?M3IyOUxNWllob3NSWDZVb29SdDNQMnVyK3FPZzlxbjZVQzhBYm5NbVZoaGJR?=
 =?utf-8?B?NDJ2Wm9zaExBaUpIZERzWXNhRVE1MzhhV2RQQTQ1QzhwdkJYd2tIWTJVZzZa?=
 =?utf-8?B?eHJxWFdXWWRHdVQzcy9hV0N0cElrMWR1d2l1N0lGMEFtQ21wbm5Ec2hFMDZB?=
 =?utf-8?B?Nk02dDRCZXNFMWhNKzF2WC9xbmJIUzVUV2NoTVBxMktMTlV0N1haNzlYSElJ?=
 =?utf-8?B?a3JlV1NKS3lCc1UxS2IxelFad3ozbmJSRjZ3dUQzK0V1dzJYZVNhYTBVaUhF?=
 =?utf-8?B?NU42dFZQQjFhUlJIOW9BS2x5MXRlVDBWVFNwNUxQOFFNaHd5eWJIamJsQ2F4?=
 =?utf-8?B?dStGM1lmOFh1UURsWFlqMWJkUERsT3pEYlZpTVA0ZTRLQThST2pDcFRSQUZr?=
 =?utf-8?B?SGlEdGNFRm9SdnB3c01CVlFFbW5va0VValovdlBXYjM5VncvUFVuV0dCQy9S?=
 =?utf-8?B?NW5UV1NsWkdpb2JPSUM3c2IwZytucE4vZVFGM09pSTJRT2RqMU9nQlYrNFUw?=
 =?utf-8?B?cnRBYVJCQ0VxQ3pjWnlSWVdoTE04U2pEWk5XK1AySG5qN3I2M1VvUU1ONG9n?=
 =?utf-8?B?Smtyai9CY1JFandoYkozZFg3YjlMRUVpbE1RQ2VyNEpHYjk4RThsYnJSVzVL?=
 =?utf-8?B?ci91RzVKMmoyaERVOHg4VEZXQ3hnWVoyQnZ2OWk2VmJnNHRoT3JvSEVUNFcv?=
 =?utf-8?B?YzRzRWV6azNBNnQ1VUo0YkZvMWNyUnM0SWVQdGFZRU8yaHhaTzZJWHNxaWtJ?=
 =?utf-8?B?SzFpTExZRFJzVlhEZWhZVUlZckpZWkd3NmRoOVBNbFR1UlFtNCtSSVBDTS96?=
 =?utf-8?B?ci9tTElGUjhZZFRiejZSS3BUMGZLeFFydDN5Q05YN0FNNHliQXdvOUZ6ekp2?=
 =?utf-8?B?SUY4RVBRK2pYMGZEREhpSFBoRFdsOEZncldvRmRTaGozbjdpYmV2a2x0akhy?=
 =?utf-8?B?eW9YczZXd0VTR2xwQjhXMU4vSVlvVjA0TmwyQ3ZSS0RnUTczS2h2dG1Fa3hH?=
 =?utf-8?B?blVwOHVuZ3RSOWZlamRZZm5UL0ZlSTNJUklieTBZN040N2FKU2tLRnFnb2Zp?=
 =?utf-8?B?RnN0YXRjVUhqUERZbXBRT0JOeWFWWWpQQWxhM05lSnYzSjFselpsWWdNdEgz?=
 =?utf-8?B?bWRrbVVvWGd5NFhBRGxYRDBJcjhzZ01yZ3lkL3A3RllpS0lVczBpTmNRbS92?=
 =?utf-8?Q?CVwy0ggjj7V+GNnwopxKyzzyLnZgHd1h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckZwQWFnSkEzczJoc0hIOWtLZ3laaHY0bWdZeVkrNEdldGRSbW13UzlFTEhB?=
 =?utf-8?B?K05qVXNsSEV1NHQxMVBFUlpmWmlONVRUYkUzS3ZPN3JDYUhtR0VuWWdIRjZN?=
 =?utf-8?B?WkxyOEdtOVZ3Snp1dGhpUEs1QUJCMSt3Z1pxaDhYbW4yTnJFS1ZqWkFKYkVX?=
 =?utf-8?B?TlhqbnBSWXZIUmRmQ0xEVDVRb05YaDFMWGFndkZEam1QMVZtT2prS2hEUG5o?=
 =?utf-8?B?Q1RmUmFWNjN0NWlKN3BmcnVtelBFM2JpeThxQWt6S0ExdlBXWGJPQTFjM203?=
 =?utf-8?B?Y251S2g1RGhHakRDYUNpSnpvdjZKOWpHTklEZ0ExUUlKS0MrVlJSRk9zSGsy?=
 =?utf-8?B?bVVDUEd4N3diMldOcjhCMWZHY1ArbmN5SHlrRE5neTE2QlJXWVRoR1p5Q2d0?=
 =?utf-8?B?ZGhMZlk5M2VTc0VQcy95UGRlMEZGYXAwUW9lTHFZQ09OYUl2amNJYVRnVUVM?=
 =?utf-8?B?eXBIQVhBOVdjQjFLWFRkOFZvTStrR3BsOXdOUHZkOTVLMm96c2ZITjZQR1JC?=
 =?utf-8?B?MHRXcEc4ZHNiRE9sbDRJcUdlc0loUkJJaFFBcDh2WUcyTkpHLzJud3dLTkYz?=
 =?utf-8?B?NzFlNXM5MWtscTc2V09leDB4d09QYTcyUVZ5TGt4QlhlZ0ptRWZtNTJRempm?=
 =?utf-8?B?MDZqWkRDaWFLQ2tra05qZ1dFWjRUZmlRRWR2ZUplRXo1L0hpRS9aU2g4WThZ?=
 =?utf-8?B?cklKcUE4M3hINFpjU3MwdE1JUTFjSkNPeVJ4akgrVk5mKzlwYjQ5ei9jRys4?=
 =?utf-8?B?VGNqMGkrUkRIWVV4aFNhZCtvYXkzTlljWEpGWWxhVmNoRmtiU2pSZ2crdVdH?=
 =?utf-8?B?Q09PTWNnZEJxaGZRUUpPMjgwc1krK0J6eTlhVkpCNmphcEhLMnZ0dHhqdXRu?=
 =?utf-8?B?WTE0MzEwSmFsYkV3L3BVQWtEa3pNSmQvZWM2YW9qeWhEODdhTkdEUksxU0xr?=
 =?utf-8?B?UThEUGs1Q29DY3c3VnBrNUFoTmJwL0JGdElsY0NUSU94Y1p0cDZXa2VLb1h6?=
 =?utf-8?B?SlViK1NTNHdkdXowTXY0ajU2bXJtdW5sWEhGbmk1c0w2UUF0OWV3NWRkTUhC?=
 =?utf-8?B?V1FHNVA0S1ZEalluNG9Peit1NWp5TEZiQ0NkRXBaMjNYeCtZT3VqU0txeGlF?=
 =?utf-8?B?TVo0NWw3U09hQjUwS2dUenAya3dOQlZDVEREWjhkb1V5RFFqa2dRak96VHdX?=
 =?utf-8?B?NFo3V0lubUFxQVp0QmpVUFNRZTZhaU1vOEpLQ1J3U1FRVmkzUWJQcDI1ZHFl?=
 =?utf-8?B?TTQxNjdFbUc3Z2duNjhXanpiOSs1Mzg5T3NzV2tVcE0xR3YrRkpveDJKVW1Q?=
 =?utf-8?B?dFA5Z0dnTTIxSDU5UGl6eUkvK1BjdFhTM1JidDBwVTFuZzdxTEI2Q1Nmb004?=
 =?utf-8?B?REJrek1ETklBcEhINlBVQlc2Y3B2SUFMbTd5RTNydGYxZkhLc2R1aXVGdmc4?=
 =?utf-8?B?aC9NRm1sMURrb2ZaWU9lWmhxTGtpRVAzTisrRXY3RDlKZ1hYNVhsK3l5UGY4?=
 =?utf-8?B?SGZMRTBSZkxGejViQ1pGUXc1N0YzY0ZOd0ZUaVRCZHU5eTJQbmEwNmxyZmh2?=
 =?utf-8?B?clZKUkF2WGFCRjN2b0NVR2hiUC9scVArQkJ2di92d24wajdOeitHS3VhOU96?=
 =?utf-8?B?cC9zWGN0YWt4YnhFVWdyUG5tVCs1UVM1Y2JRUWdwUmQzVnNkRkMyWFo5Y1BH?=
 =?utf-8?B?R1JHTk9pT2RnOFdOM1JQOTZybjVGbkJiRXY4cnJQeFhHNXBaZG9SZVdaYndC?=
 =?utf-8?B?MFJ0SGtPMFBTN3djR013R25kVFpFUnhFMStXNkp5NHMrTFU2bmdLRXFqYXgz?=
 =?utf-8?B?bTVDYThhVCt1UzVkQmNaVzExYnNxMUkvdXkwSVBrOEx3aVRsblV2K1FOWEFH?=
 =?utf-8?B?bVFGY25SallGUXVYdk44TnhBRGhKUjI5QVo5QitoSUJWOXpnNlJQdkF4T2FN?=
 =?utf-8?B?eWtRc1FLWFNKd0VIZkw4bStULzB5dVV1WG50MVFQVU1CNnFnNGxKWkVpdlly?=
 =?utf-8?B?cHY3YjJLUFNCbzVKZXN1Vzh0OERkQ1MyRDEyUUVVbTFHbHh4MVcrNGQvcVVv?=
 =?utf-8?B?NmE1OUtIakhsK0xka1dnK2dYb3RhTEJhbGgwMU1aSjNWYkF5a1hjdGFTTXBm?=
 =?utf-8?B?WG50enFWQWFHbGxtdUMyNlZGTStoWTB6S3g5SHUvbEt5R2tCZDRzQ3VFYWkx?=
 =?utf-8?B?ZzJVY1pZeEdFZzB4WVJKSkJnZVU2c0lEK2lPTGJjT0JBM3pxOC9Wcms5WU43?=
 =?utf-8?B?NDBYNE9HdHRVME1mV29CNUVabXNBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T6EgyP3Yj1CMGm/R8/rXP6uWw4DPpR9Gahhn1i+wFD9vO0NMOZwz/75gTDXoutUFZMOP5Na95SUpbhzDmMF5/aoT7P5KVFvRJeU/0F9B6LD4iRGXIRPrUq0nZCo6SAhATfo/u8ZAtlu3qzakisgff3lfYhO2OkCSBGl8jwZ3f/60lThxhvND6jg7j7vQBlcHK1UT5DfPUAf9VIvhJuiO5CyeiLhHrTkkabUybwReraZs3DFHprDw1tvjU7XF0Sdy06Sm6FRoEJP9OwomPRVtycGXT7oj6na6miatu0rWNMU+u2qzNYE/4xn//+8WinQZmZcuWzhhjfQdTL2Lp5LL0CJxfP1hA5QnVtIf/OgDYZVjTOPWwqyM0Q+EALoh1Ct+XrqUzBIaO1wArqoAT1yj0pp7DmhpiMilSSXoK6VNxACHsmPcy0t6O652YAHKP3o6t2DP0SZDjnDqi9huKzsxT8HEZ6YCm63t2cDnXqnDaj0aSxKAG2mA9Vh/XZaSw/OyXhe/f86P63IIH8asP1j/nGRIVQBDR8Y/Gfh15Yli3nGkKZO88+0EkXonwkYKfMpGNXSHTJzS6m2A1hURtlPJevOJfwRfVFO+gHaZY/hhMVQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a5a6d0-3846-40be-f2f8-08ddfc19c5dd
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 09:56:18.1835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bZFI2iyqiAm8KDp7pTp5w9ASSOOoUgxTXWuAiKD/lWVtDKH9o8IcvaWTBiYH15/lI4GZPEP4TTR2c9PTnOea/oR3O7XxGbq4dH7y+6H3VM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7287
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509250093
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMyBTYWx0ZWRfX8DUSE8HYMHb2
 cAEvS/16lOZERRcZdELri/XFPB3pX0bpebJKagKx0rUMqRXWRn7zMPw7Rh9a5E1IG5JtTJvKFGH
 5BY5cZSftcMz+GS9LUDROSmRYPopRLNwtgtzEbO2D7WOzgBawtfS4U3H2bKjNXoBQOj1hbeDJSJ
 SvO7n9Pw345ls6qWgEgYZ1rYQF/SrqKttZv5IrQIx32WsjJopbEFd2llgX+vtTNg1+MhYxlimsq
 npvotoTUUSMlsNwkaZen8LmDwNxSjrW6K1dnVWl6gGInT333KjbASz7XMcx+iL1RJYgIKYNN2gR
 Gho65WCLNtZrZb3q9hBe6KXvQ7bFlPPXHWnUEoIRKlbQUYLoBayiB+MRho97drsCEr2fZG/wTAl
 h/Vz2DYlowGilAakN6QPMnpZRDmbNg==
X-Proofpoint-GUID: p5R9mLI_AAmua7SpMfpWYxSyao0dVcJU
X-Authority-Analysis: v=2.4 cv=YrMPR5YX c=1 sm=1 tr=0 ts=68d511c5 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8
 a=OIndoutni1OYuYBYa44A:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf
 awl=host:12089
X-Proofpoint-ORIG-GUID: p5R9mLI_AAmua7SpMfpWYxSyao0dVcJU


On 9/24/25 15:45, Peter Zijlstra wrote:
> Per commit 85a2d4a890dc ("x86,ibt: Use UDB instead of 0xEA"), make
> sure objtool also recognises UDB as a #UD instruction.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   tools/objtool/arch/x86/decode.c |    4 ++++
>   1 file changed, 4 insertions(+)
> 
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -683,6 +683,10 @@ int arch_decode_instruction(struct objto
>   		insn->type = INSN_SYSRET;
>   		break;
>   
> +	case 0xd6: /* udb */
> +		insn->type = INSN_BUG;
> +		break;
> +
>   	case 0xe0: /* loopne */
>   	case 0xe1: /* loope */
>   	case 0xe2: /* loop */
> 
> 

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.


