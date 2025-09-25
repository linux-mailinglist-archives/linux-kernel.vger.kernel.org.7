Return-Path: <linux-kernel+bounces-832467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8BAB9F64B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00CE2A7FB2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413DD2192F9;
	Thu, 25 Sep 2025 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mQqslnxw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S5a7hkNK"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A2721771B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805341; cv=fail; b=RZgowFcSTHLlwGR4tTQ6tSZQmn4ObxQcoFgIANbhZXCcQBNkZxlDL+HK23jZCTkvlHsTeVFtUhLAwJec05zT++vq5vM8pKHAILREmCk4FvIETNyZW8d/Jo9ufuXw9+P9SpQ9NoPbHzPMWlgz5jfx79Zxyt4xaO+/ZP2+W8mkKP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805341; c=relaxed/simple;
	bh=BWjelumxJMKze6IsYqpU6E74HLwXJFvm/AdzYQ5D57U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P1ADiWKlyF1+A7KAhQ0dzMuzeqTEy634Yq2utWKXDGPXD6fjxWY73nyn7JQ6Jl4gWvTqmQ/0j7CqaqMbNGDXFpD1VVDyKU4SfqqI2E3Qj+xUWxCpgHOv7SvFcTbN9clsX8jfFLtO2zaKbrSUo2uCEoCDKT0t94oolFsxQenl2bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mQqslnxw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S5a7hkNK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PAu3LM021542;
	Thu, 25 Sep 2025 13:02:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=T2/77xv7SNYRmATioV8PknHWeC2QWP/b9Ga3EPQgGVU=; b=
	mQqslnxwGW+D3px8JHc+fCYW6E4Hz+uP4Yz0LH54MucHgs/B11Brmkbu3nTHRzil
	2+t7R/HUvDDA0WZu/enzDnFnvlJvx7pCwBJp5hUIyF7s8gtWql9t/viebRg9rEPi
	e60I3Yjy7ZTJEnrB56zUzIIORs2zfetSso8z3pEsCm7V/YBNRS8GY6HPyx3HCbTT
	MW1WgyyZ+ozP4cc4Q1Ych2cNYQEP5RSjtYMgzlghd6STSKFkV+IDMHcVUlLADn4Q
	5iL8VzEbKYX+1h0WP/eH66UXT3M96imtTTkpfiVLhAR3v519A7e5grY4CHM/9nsO
	MxPJOgf33LiJ00eT8h3/Mg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499mtt9y04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 13:02:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58PCnoPU014991;
	Thu, 25 Sep 2025 13:02:09 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012046.outbound.protection.outlook.com [52.101.53.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49a95248pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 13:02:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VeLCZlbc5rIAm6EDowcUqluXl9T/PPr0QDksuJgpb6mN546MSstaFsT+zjerso/WHp4wGCD/dUm1dyBClFhPwau75m1O0fKylr3cdAamTfiDLXy9PgFwitj08rdIJIVf17p1JWRo0wHMUMYfABAXoNJTddG7zzNM2QvJL+tp/RCisjAHOLqUh1iJl7bd/QAZ5zTrbZo/wDpvWrX31E1RszhLWcLSiC98hz1Vo1+b/xiLKdGR4vtSgE6MGtWcIBuUipBOyr9V/ueo4oYxbaDvkaBfJyddFDTVlzBQzZq174jztU96O+aeHXsN9ZoQUBpNg2QO3hrkNjWT59nUMbvbWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2/77xv7SNYRmATioV8PknHWeC2QWP/b9Ga3EPQgGVU=;
 b=vptwphUA7Vb2vMnf3jjGA3F3ejV3H0jz2sWV859m+8efM0yzVER752iF6E4AgWkYVc8d7Q5S3TyMq/j3cYesK8e9yA4Ansgw+qgKZgzXMqoINz6gwPcqT+PPIyMzi+Jv01AR04463O6RgXvucEEXZ2mGRwsxRon777UO6TvI5AfTAyEERD5JeAiRKt4pJHbbabA3oT3iLXkLPW7nu/Ku1m99nW+ul/EkB4uBQ3hXBXiN/TNNU8VN05gCjgBGj+0KIPmydgf1tc8LoP3QysPVfSCBnUB0YwRSD+tfyOSyo4F2i+2FgU/J9bD3bFtTNypzyPp5A/PSJDzbjiOjbpphrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2/77xv7SNYRmATioV8PknHWeC2QWP/b9Ga3EPQgGVU=;
 b=S5a7hkNKnCO33m9aBQ8Hoe2B4vKfvS1KPwe5TTF+UHI8CTnsUeFHr4foP5+M5yfllFxkYCqajcRL0PstI+CQYUZSlnIJFdIY0zitANzkk/aoxSR5tefb4g0ZK7wKvwQf4HzsHW5LbXegrRf/gOCw/P9fNUYHQie++E3wsMKNKo0=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 CH0PR10MB5193.namprd10.prod.outlook.com (2603:10b6:610:c4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.10; Thu, 25 Sep 2025 13:02:08 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 13:02:07 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.15 3/3] NFSv4: Clear the NFS_CAP_XATTR flag if not supported by the server
Date: Thu, 25 Sep 2025 18:31:46 +0530
Message-ID: <f7667748451f49ea3af42534c824b66c2f6e3ab0.1758805195.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <1d4bbe4e9b6e6909067d8d5ab704e5392ec42bff.1758805195.git.siddh.raman.pant@oracle.com>
References: <1d4bbe4e9b6e6909067d8d5ab704e5392ec42bff.1758805195.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::12) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|CH0PR10MB5193:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb5bf69-b0af-433c-6f96-08ddfc33bb74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/tT6mcuotM6X0QD/TFlNvcRhkb6QOydxxoWFvIC50osh67Z/c74oxcmzVVx6?=
 =?us-ascii?Q?hPxxqF55TalFRI8KCJpADF7l9DCgxEl3NndZ32bAJdMnmxtVEto+4XHmyCJk?=
 =?us-ascii?Q?eQNLHZmZ5kavl2xQEeSY7Haq8MHiwEqJBO5jzw13U4wAuk7e1HfXEte8bxY7?=
 =?us-ascii?Q?9KtwvanE4LLntemSJ/Q51c+GuF5f75dzjwlRKgCiCNWF2go8D5sO4g7kvY4y?=
 =?us-ascii?Q?+glVr9yZbIbMxvRkyZFPv4CvhZ24QFJqsvWQ4NDSxEbE+rTzIxN9xCsOLHUE?=
 =?us-ascii?Q?SiVDT4C1DpriazbGW6s/p9NiXkn9lrQ1oxF8k0YetZO1dl8X9gb0Ook4pbG4?=
 =?us-ascii?Q?WVngtyyJCtpLm4L5Dmw60fNF3FKcLjvx9DmhLXmVa9Cbb0RRi7oiI1iSEggU?=
 =?us-ascii?Q?qsadaPStt2kdD7fGYbGTX8n8TYiHjoJE96H+3xm+zmWSun7f776RIpt4CLEb?=
 =?us-ascii?Q?DYNMfjedWCj/oy5Lt1LC6u+mH8XdT7kEroDZ38V4I9RH+eR5bbVhhdNr3UJM?=
 =?us-ascii?Q?bTJTDxGJiOqsJnXv3b+BxCCFcjfZGN5DvAc/3cxzHCO9niVKdMuw2HpccDqT?=
 =?us-ascii?Q?Oi70pn7yHKtmKbGZ95r3ElFAkn5/tk42+K3fCCQ3yhbQeRnNNMbMSw9Q+G6F?=
 =?us-ascii?Q?Qa/BtRBXRhYjRbyR3UX8qg1pqbed5gqtz0KfzAkq6PvcU2AKRqW1FbUmdW5W?=
 =?us-ascii?Q?/Yhy8TE67yLSO2vIkUmM2f3wvPaLFaE9CUOlCKOqlUp6hDPrjgQ7QOswYGtu?=
 =?us-ascii?Q?vN0iFpRAyeg70QiXfHWoDltIS3meDvNdqAa0IjfLS3FDNga1ggEXT2Erxiyt?=
 =?us-ascii?Q?agl9jbysAhIqdjcsRbl9VRmjT7bb+zyv6ey+pAE/Ld4OUUjyXfLe5v9fYIC+?=
 =?us-ascii?Q?LWovZbconV82yKgv2JHyMCQB+en/hf+hqmOOWWwQqJk5x39nNBYDdZBPOOWB?=
 =?us-ascii?Q?hPLAOPHWoH7+qTCMe/dNSWwOBsUT1s+hW1ndbZ7heaPWz6GR7g1HjIx4r3Gq?=
 =?us-ascii?Q?oYfr5Ybo1UAkUI6F6nlap40H+Mm8WS9nKfoDJVRkb8d7NX0ulVyzHbxS9Rke?=
 =?us-ascii?Q?j1BWu69tX20fUtnUYyMG+P+BTFQtKlpnCI9GswyAHP/ZGloCt35Sy/xPsL8h?=
 =?us-ascii?Q?GOW/zU4y79edILpraUvTj35sx17kKkM8K+Bes5dSumAErOypkeWUgUMhRTKt?=
 =?us-ascii?Q?JDzgJzZxADlvb9SUfmh1BKPUoWze6z+i90LiMrq4eAV5cvCaS37+qtvcyWcK?=
 =?us-ascii?Q?pjr1pwm1Q7TuG6a4Ex3r+U2CZCVIwoJ8OkAo5lLqVglv5d7cuzgBQaDgSSbM?=
 =?us-ascii?Q?k8x0DTpIFQ2L4dn7vs2xOcgrbW3XwAymBvjEOOrBXvjiFaFvei8ui1u1iPaB?=
 =?us-ascii?Q?KZF+b2f2DiOyIOxz+9RUKbM+WwmwlG4g+3Pv1EA+m8/IKedCLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5d1iPIZmGFGhrVF9u+bGbUlvOAXIc5owt5XVKeoX5i4TmsEaNl0vgQLhID1V?=
 =?us-ascii?Q?iVM9iDGPaQrB3WJjDoKr/lgGC65C/CsNox6VzGe6hkEghB9BKYpwz5M9kppU?=
 =?us-ascii?Q?LxL8Bz7jv9sbJvrY7bIrl+z3IQHuYlqk5WlSWvE+KNOiOKL4U46AQ5/RTtAE?=
 =?us-ascii?Q?/tBSEuUHPMP2US+eovbPdEHG4+NhfE05s5kz8aAFDKGqOOlrZ3DdFKyp/Tix?=
 =?us-ascii?Q?OZjbzL0uBkSqUxTkjTduF61WQ5toOJ1mhH++DGrwLbpf4Jl8WBlrb6+5HDJA?=
 =?us-ascii?Q?Lf6G0HXimZVIypu1eEaXTo18vyVzzm08Zjj4zadpUyVFhR7om4uzfzKsDMBi?=
 =?us-ascii?Q?QhC0d1+HiuOf0x2SuTwfqqyUj5RiIfTiQPfX7FBa/gfLBVGd3rCy2OyXoZ8+?=
 =?us-ascii?Q?C4EM/5t4YVxYK8ejsUpd4fKWmNmJNCp41eq4v0CHqqdidzfYAY/13IZpZrDq?=
 =?us-ascii?Q?G+jM8FgNwSsC1PPRnCszqXBPZ2WEq6nqo+JMt0ytVycJjA3N+4+CQLPUFDm6?=
 =?us-ascii?Q?dmhV97eDW2AVJjv4yW6Jvf51O+na/4RYEJJs4niUy/M0g0H4xJFRL8yMEm7H?=
 =?us-ascii?Q?8wdRL5bQBwp/hZBpNwjFwAXnm/dyH5pHOEBCQ8GtPqXpCze5jM5DPzQMbNka?=
 =?us-ascii?Q?19cs3gnrVoUXhHbTzZXdOqlvWY965yPNumi90g9VR2M8PVlDqpdAODYHCqNU?=
 =?us-ascii?Q?8MHCqxq07iYUCW58ttlKyhgSCpYb9S+VjOkjy+NHhQm5XHIQBXoXEyHxAmJt?=
 =?us-ascii?Q?i51WjY5gl6qPrSvEwtQwwv09aZbJMceLoF26k5V1BZZpn/JJAZSSXS4IvuBA?=
 =?us-ascii?Q?KFVr9322XLw8DQJhHFrVwd7LGmFiurbbhsPOgTPrQ5NLYifKvsoPkLA32vbA?=
 =?us-ascii?Q?YPvWebrGhVfSxdOYuPjDcgi8rREZS3lvO2r7qBP587UmW5wf8jPbgSxzzo7h?=
 =?us-ascii?Q?Mi05Ppg+hnINNrV73nJqx+NiSQmuy2BOwk3nIjUDr4s2MiI33FD69nFugbNv?=
 =?us-ascii?Q?BI+c0PnVmSBIVoqgkfJa66QtK7lijIkdGi2pkN7tRVL7syZFq2MViVrCKF5P?=
 =?us-ascii?Q?cSGLPpCZVg7xcSsAOZq2VWytdGLd9JELsR+4rNPxLaXzTDws/692Z0FqI3bj?=
 =?us-ascii?Q?GGIog2BFJrwQS9bLXSoX11t8AAI4WDwznTFwaUqh7QHm0+Ht9SZOsB73Le4w?=
 =?us-ascii?Q?TK7BqU34IYkyay/XoV3iu3/KJCdhBOePtcFZGq1u2geAIYDYgNNBa46sFpoq?=
 =?us-ascii?Q?0cz1NSZbT1mbrl0wkxVecsDZLIiSOqb0MMoAD59ql8rVdX0bPaSpaC60DVzX?=
 =?us-ascii?Q?HOB3wfSfRgCHmwIwGaLh8SbsKmcnPepKchUvCz0f6EpybJc1MtX2pTFUC9Kp?=
 =?us-ascii?Q?IfgMhvUO04iq1ZjkQAUokMm780hV/KL598rfrDab6Uz6eioOmP5o1G3MtFI3?=
 =?us-ascii?Q?foRatKMd1VPs+NRf4MZpHMlLV3YJ/wLD9sid/ChCC5B/aMbmWMdq8RT/WbwO?=
 =?us-ascii?Q?4bgF7EZQsu9KKFzj3LYgF7M1hqK3jtgULz9AD31roIn5rSmV01JMKm+0tQvM?=
 =?us-ascii?Q?229jQLWWZLSDk0S+6mw8kIZbGHRn9lTgcG1eK1X4+P/l0ZjrA4iVm4EkVvCe?=
 =?us-ascii?Q?hIuvC2t9zOCA29oojmEDyGg8TD6LpwmmlB0PzQhs8ApkrbdQ3mJnnAKBC0VB?=
 =?us-ascii?Q?lctaCQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PfHQC8XF4lkD5ZasD/wfwYyU46yLIlMQshrwOfeDySUJMZPoOcb7vEbTGAHRF1sESytB5DGIuyWWwK5mq6QinqOrl7KaCwFNX2ZTcV8Ux4na316CMlz83rD5CX7IXfhu4UiFxEEJv+itZ/dSGuyhLNR8/3BpSrMJANNx9Yxs/oZIPaxzK92cGDF/zDNWH5VZYhFx7BUGE6EXS4PPAmR0aDE7C30a6hGvoLnEh+j57HI5z62iu/tO+cJok5Y6sSwcycu0rAvXMRD0C5H5PF3sLndnXv0Kb/zW8j1HvXvUC+PARC75vxWYJSvzO7meMNW5b63WmoOCDSPe0rEjRz5Bg/J+1xhGDz+ttnVWVYXlrHhmYHE4jqPXkqnWe7Eg+7IrFGiPH9raWDiUMjcRZL8Xm4gRf0cG0TA65DeI1TkOpmcRhk1z3HKMTc1IRMEJ3i0Mf+BjN/+yyBj74VQzWTHfvZLR8FTfOy+rmzFfm5zk4mIrWymgDMfMcka6T13s/pHwquOpeo1kX+II14BeOQxnlkxq1JgFn+Cbc9/EcXHyL81RpqnnE5m6FAw2ST6R7KLUGXIPJVsFBtQpRfjgxzBYSR98F3AWR8tH6y8rOX3ooQw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb5bf69-b0af-433c-6f96-08ddfc33bb74
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 13:02:07.7428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H06Ji/+T15XKzEKsKr1nZEL3ptAQN5oEIXmnazKHzO7xHVdWePURJ4qqOtp0teM4PtB/zdx91ylIax2+on2NV4v7pB90m+R5J01IRv+kmVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509250122
X-Authority-Analysis: v=2.4 cv=fd2ty1QF c=1 sm=1 tr=0 ts=68d53d53 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=K7RatkPSvDhmpgaM:21 a=xqWC_Br6kY4A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=SEtKQCMJAAAA:8 a=yPCof4ZbAAAA:8
 a=3gqAQrb8DLZVcbKcUoUA:9 a=kyTSok1ft720jgMXX5-3:22 cc=ntf awl=host:12090
X-Proofpoint-ORIG-GUID: mboP1ltxeMs_yTIssPdTz9Fzt8gWy02I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNCBTYWx0ZWRfXyy4pTpkk4QWq
 07I8KzKqT1vLNWPFDb/MNcRLdZXW18PCXYaFHLgJrafoUQ9oCWaWhFdEcWP9sGOFixzPg3TFx5K
 Bw3x7lsXtSfrc0+auh7RIyQecghRbyiUY0bhjj3Dsis6WAQOO6dRGTd4HR2mbkkxui05vved7pS
 1JnXUKwi0/4SEzJVvOkaujhxgZHZuCS7KXwD1uN4hmPfLtcBT8KTEdUACpshv/hjt27TdzmkbnZ
 BPIOxxjWdLcoA847Fn7SdYnqWmhbrdH3wkBQH0U3O8g6rMn2hXw5pSDzOgFbE2AE5tAST1+SP4w
 pwdkcOX1UnQhGX/XE0IiQDPxM3v7LCRLcRlbljYzDmm79XZ82D/eeKewsyfLp5mBjTdgDxAW4D/
 TKKmx32ge7QohR0dntmAPMkpH3QqYg==
X-Proofpoint-GUID: mboP1ltxeMs_yTIssPdTz9Fzt8gWy02I

From: Trond Myklebust <trond.myklebust@hammerspace.com>

nfs_server_set_fsinfo() shouldn't assume that NFS_CAP_XATTR is unset
on entry to the function.

Fixes: b78ef845c35d ("NFSv4.2: query the server for extended attribute support")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
(cherry picked from commit 4fb2b677fc1f70ee642c0beecc3cabf226ef5707)
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/nfs/client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 443b67beec37..c29bc0a30dd7 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -862,6 +862,8 @@ static void nfs_server_set_fsinfo(struct nfs_server *server,
 
 	if (fsinfo->xattr_support)
 		server->caps |= NFS_CAP_XATTR;
+	else
+		server->caps &= ~NFS_CAP_XATTR;
 #endif
 }
 
-- 
2.51.0


