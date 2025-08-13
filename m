Return-Path: <linux-kernel+bounces-766103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF02BB24258
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7297A1BC3AE3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521142D29D8;
	Wed, 13 Aug 2025 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a2pVhcfQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OsBP6PEO"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BD22D0C83
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069082; cv=fail; b=SELIQZNlhNLrSLLucZODKoW1aOigx1aabvgrWTR7uMYm4da9O1PgWnLovyQr9hvTTZntuhA2L2idXvHMLFh9suxWjLdME7zL+wmCrzndo8Una3GzC6r9RmI/yzO7GMkmnszNcFgCgjt5Uz9EYO2s2bdVdqj4peVMoGoA60KHRbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069082; c=relaxed/simple;
	bh=nuk3X7ruSx3oT8/NyXgg/LtUGEHZKDBc9aWY83xYdzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YAZCaXlY3NzGAPW+CbgRMEjTa3shPqyRfrtOEa5l3pdD1i53Zg1EX6NWQbT5JgtKzen+g46clUE685QY/qJhQNdmUV7KPhoxvU6DNiCfb8WgQyfAmAwGCxG0by0Ly5MaltGDyr0WO3xA4Bi/ZjpeNirfRbjg1qp7DKZr12Kdhdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a2pVhcfQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OsBP6PEO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6u58w001265;
	Wed, 13 Aug 2025 07:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=tEFKMapCZYnBdLU7pi
	c9RAfiOLJ9xAIjl+8hLKSQPSg=; b=a2pVhcfQgpjEjdpJWkB4ssXx0WiE/UTUhx
	iJdqXKGbT9Q/eOHCMbAE6V29/X7UOntpoltFXOzhNicLeN7t7ZcKnYNA0H4ZqwOU
	3FQrMKG/Le9mICFELoVVf8OARaGgXNDKh8stfCs4Jv4nlfydtbmRmPh1+8sIn0CL
	ObzEV2IAos4O9Ucp03j6KuxsQgj0f46Gh5/UEf5mTbSUWXegv3TtPM1qnokEWYLr
	QUjSH6Vo5r4BMUUKNX/UWq2D3/2ffOCD7DZ5Pz2NMfLHml2cYQ0PneUgDYgAuhs0
	zdHxrGoMeoCxLG9Ac1C+ttktaGtG22m2NGJUQyID6HZGyPvlFGDQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxvwxj2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 07:11:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57D5duxX030191;
	Wed, 13 Aug 2025 07:11:09 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsb16ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 07:11:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTnIrOWfxCRMk5/VwMdQdHV/HRakYvX/YYjBo6mu/URPbmaYtZkpMz3mt++Dp9su23z5GSFreOiOBYmvm949oVaky7Su7rgNvT7Li3Q3vjGLYSyH2W+bBZ197kV+2TwYJdfUPfgzX4mUqA0/DsHjkBkxmZd7FKKLralg2deMYgzoVIZU7Hgjcz+peSjbiQIbH2+meYRiEMgPv30w790SM/MspxO1DTJ1bKhGjqsoHIh84NKIc4irSFhSpmgWFNeIqcB7Yn4FcITIntBqiTYzQl5FUPGJpkSuozl2oMbyBuwqzvvk7zqSUE5GxeHw1LS2VTYKlW/okDd0mWg4ftUywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEFKMapCZYnBdLU7pic9RAfiOLJ9xAIjl+8hLKSQPSg=;
 b=HqqteMtCYlbD536NNHQVhVDjk6RSLMyrg7PZ69ccCGUcm3MbIq3AluH6iOQuyDvLP0W5ikSFqG5wAPsj+bsFsE68RJinbqd9XVio5TSrM8ETDhXQqFpeK0zy0Ag6z7KYOIVBbM3Xrd0jrQplZPWamQOIOEN6AZYqMutYx+oh3gTwTY/3ZSTrgvhvb1SWPn9IDQNUK6ABGBogjdoaiKOSwBwaL5jMhGWWZQtMukgiS/wV1ZWhdkBvHmcYT9K4dvQcpBtefJ+xwKf/zbQuVGFjZBHw4/jcrlKnJLmPhvyVRX9BBZDd8qapLu9ynR7uWBdjp1umTWECFHmqxRtC6Pn5Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEFKMapCZYnBdLU7pic9RAfiOLJ9xAIjl+8hLKSQPSg=;
 b=OsBP6PEOJQr0kJ0SI3jKtj9fVe+fCcsNkA07/tryb2BS6cEZAewTT/v2LrwSTvPD2gNSfYxmBpETEDH926QSOr+hIn/oGV/R4g4lzm+9F4rsOrtWKP3q63Gbm06GD2vzvX8Ryg9oYPM+xkeTFxEdvRYOybbSegSYtOKZrN4UvUQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4437.namprd10.prod.outlook.com (2603:10b6:510:3a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 07:11:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 07:11:06 +0000
Date: Wed, 13 Aug 2025 08:11:01 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linuxfoundation.org, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com, kees@kernel.org
Subject: Re: [PATCH v3 00/15] perf: Convert mmap() related reference counts
 to refcount_t
Message-ID: <185fdbcd-7c34-4f9e-bd63-52b0f7a29617@lucifer.local>
References: <20250812103858.234850285@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812103858.234850285@infradead.org>
X-ClientProxiedBy: FR4P281CA0304.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: 773749fc-0a2c-4dcd-a5d2-08ddda38928d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mXnHDRSNF2zLYV1qR7OtUyqcsvYXbNoqBEieldGak0KZEbNqC8l6B7gejEkq?=
 =?us-ascii?Q?uDLibqaR5p0676NGUsa7Ub503l3NTFrWqKSpLD/WbAqN1EO50Tzz17zsKh14?=
 =?us-ascii?Q?kl2nWH4VLS5FIXJISwIaelgiWQT7dEH+1OfvUkrCgTZUH6g0MhskpKmSfwBa?=
 =?us-ascii?Q?Onu9Zg0C7LZ3cAoK9DblsB9EoKFyh6abX59xwQZEPc/NRVQwO3/+gzBcnkEd?=
 =?us-ascii?Q?yUkvpN3LCoD+Hi1X7gw2yqjM2ddtljxDanTcTgsQgvO/NIPsWVEvxcnqJJy3?=
 =?us-ascii?Q?Y4bm8zBlhGJ4pqCFcZXpGLkPTS9mRUyPfhjnU7ereysKBEeb0gOz+p1VEABm?=
 =?us-ascii?Q?xzcs7hiOnHcevra4AUeXzcHERsZ1DnQXNKZly/PL7y8KCjl2VpJTA8Nn5jA4?=
 =?us-ascii?Q?AIV0/+f1is+suimoW/pTgrSywGQ2hEKgYja8RnCi2YGh3+VvSLVK0kq7zrqt?=
 =?us-ascii?Q?+8CJqLcx1MrGX6P95KS+go18TgL+YutLwwQC7yc5tx7vPyv6zQpmFzbGx6c+?=
 =?us-ascii?Q?RDLqHlveYKV3e52b2yafDlBrDCkt4rTqPmzuSmA3GmG6/uqDSSMJOzIBp7Wi?=
 =?us-ascii?Q?ahyh7sjDoFh26AqxDY67+NcgEJuvydGtP4XEd8IH2MaF7wWtjK9NtwkFTr9r?=
 =?us-ascii?Q?IJJZnu5MnkEE26VCnUO3V3m5p9bnEx2hcpUCUODT++zmrJQa9n0hAUK/Lm4A?=
 =?us-ascii?Q?INGc6A0vZZ64GrsS6W2jQK6w1+MU8azajN+gTpGrN+JGbGfvkYMLvj5ECNS8?=
 =?us-ascii?Q?WxJz2PiIRhIisaiUpPtaqIMnChsyqaYS6EXUSIwFEmVeVKous4Y7RIImvDmo?=
 =?us-ascii?Q?ywMFWXUk5j+b9gXafJtBCpAOHbhFjugUEtk1OPAL8NumlY9xVhDRpUv6y3Yh?=
 =?us-ascii?Q?JVYz5WLT22snB6ULmLPCk7wZivtO39eUpjEf4F8QGxwf2QIqqPN1d3BPkOok?=
 =?us-ascii?Q?y4usSv9kmFlB7Nlar66QYwaLSRocX62lzWLP0b4HZygh4KxZETwmVhnTB9UL?=
 =?us-ascii?Q?uE2pFLcBONg0eG2eUlf24Fh0tiiMnb+qajA9Q+nsiG83RxEnq4PTs/4Vk1g4?=
 =?us-ascii?Q?11qVxtSiUdGdR6zYlMNN/LXSuW0vV9kVtGfYVoawl7oMo7X41hbplBZ+xZOl?=
 =?us-ascii?Q?JhpN+TOfixvZQASaSGC/tO7U/vs39jOoyFn1hqMfDjdwNYOJCHPx2d+24JWa?=
 =?us-ascii?Q?xDyTHZthEM/h11bDILoNu4zGclCjYuF3XVpkKh1GTfvRRb626pWo1KRrJf10?=
 =?us-ascii?Q?Dw53bPHYlTfqOO1Tj+r5wTUvmIKXTvpnoUab3dIw6k67YPrHiHQNz/U3YzLN?=
 =?us-ascii?Q?6f+ay5THAjWlz+ZEP4oAaifiVkw7rhIHiSLS96F798BEVQ4zirf7EZQ9n/WT?=
 =?us-ascii?Q?rddnI/s/BLbjyoypIfu72BNecmZtTQGKDo/uMqpy89CtDNpmrSJHGElKBcui?=
 =?us-ascii?Q?UTvAaGT/X5Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Ekve5/6odBGgS3f4ZXqZiTyg/8bKwt0Fn8SNTUjtmb9IN0YOwACIadnI386?=
 =?us-ascii?Q?/o1GnWNOKYCrGwGgJavk0R5M+Mkbj729RKBtkJwVHZp0av91ien7rz+U7JhU?=
 =?us-ascii?Q?+tIGZe84nKNF80rbRYkEJIjtP+aELxupd/fG+7DxGSH/YVNmFxfbOd4ZkTpr?=
 =?us-ascii?Q?I6DBu8g4rJQva3iiuHkhQVoaFH0VeGsAIPLW7xnAWrmEbu19YIbdwyD72vMa?=
 =?us-ascii?Q?ePppl0pRMT06XLotbKe9WvBIqOoAz37xQF8z1G8Rv69nda3Jn5C9CufDeyD/?=
 =?us-ascii?Q?QNvPhN6Zp4iTTPWqbNshkecLLIbQO3KjnNEPDGU0CYBSZmAUA4EKI9lmg4Tz?=
 =?us-ascii?Q?R3fBdPJUDG5NzC+bJje/yyDKTxJbwhzzP2A0osjrLtd+5mU7vFHxeBP9tx+/?=
 =?us-ascii?Q?jwCM1rknNckdJWEaqe3JJLgTFBM0tOyZjiRH3utjn9Vi+kW+kQbmf++3n+xj?=
 =?us-ascii?Q?4R2q7OB97OISCPsM4HI3BjfP8Z2r7xuyBc6r/TqfwxRCEYCX263468HoGT3y?=
 =?us-ascii?Q?PEY4w10NcgMpuqDtdFOpUDmdUsq9KEPXtKhSKg3vQCLCdxN9vytpQdgGbAxj?=
 =?us-ascii?Q?me1NnzVpuQ+gtUikJEJeomvKS/fyTLZI0fsqeezq+bB7mE4AQ60hqJMy63Nk?=
 =?us-ascii?Q?//i3IcY+tqZ+IKV9XB89APOTy1ERCD+hdFu1tDTbszCyg+H9Xu2X+HdZZAqw?=
 =?us-ascii?Q?AwNONCQK3NyvdSTw6/COuP8oL2T1s13K1BKqcZ1HqikcUG3w897curga6Pmk?=
 =?us-ascii?Q?sDJiPnU4rG4sj7TlZxkjBgjWgTKktP0n2cXnAI24Zbj+ZddQnlASwqk6GcJf?=
 =?us-ascii?Q?39aprTZRcNfZFAvFbAk4pzgW5LzHWc4UvMHM4pAumKdgqgB9wDMlsUr7KpX4?=
 =?us-ascii?Q?NOfS2XBVQF9zyZfoMKHPbetuySqBAvsTdsQyHg2VYKyPRFxZ04ainUe9jAXs?=
 =?us-ascii?Q?LQdiem1WY7Tqfz8ZA8nCFMk3uruupSB3VlHZLt04/SAatsRuuRAXlPCHx8Ad?=
 =?us-ascii?Q?9EJsmsJw8nCqRSF3n/KOe09HVEHooAG8uvF5Vv/GYac6UaE8rPnJCm1O7GZp?=
 =?us-ascii?Q?KMQjwouLmUB3goZYvZS6L2Z9W5itfe9L2P4iQM8MN8lGm939nxb5UW9MgCyn?=
 =?us-ascii?Q?j/Wca08x1vV/DBspBBNTNg/QaYlBtHHy6f5H/XRMaPK6626oW1/ekfw1ER8L?=
 =?us-ascii?Q?87I1tjzCDB3NMoQy1xAuFW50jkwqZFrVn5nFQ+0lCqdS/LV8o5gxjXclT4X/?=
 =?us-ascii?Q?rPF4LxkZlm9h2zr0ZKkXT2fnKT4mwaP0qKboWdSuABz6kuFe0DP/3jx3gpNx?=
 =?us-ascii?Q?vG9p2jmIYe9ZKkGQEsUVK1fHsmODq4N+ZJOnYB1Sr8lP5aDOD3AeRt4OWa20?=
 =?us-ascii?Q?DT6BWvWjakkFZDlrCgj2/2OFW7qFMU9DjZWV+8M9uU99IP7+Lc1wiMNrNTnI?=
 =?us-ascii?Q?7nVV3NhrkY4SU+GXseCh+iLN5AUoL9cxq0TyFcDzIpVIasJVpcwrg/ZMGrl4?=
 =?us-ascii?Q?0nzFdIRFKB+IZljkPF7iO9RKEYPGWGHqzmhFbfJTsbEozWgOQ01uKiLV7wTO?=
 =?us-ascii?Q?x+OlLB75oGj0nDeqyfWI1pXQ3AM9rY/jK6Ovr9CpbPSaTg5IoMdqIVm5UNoL?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nk/C+1qldF7IkJ7+s6Uh7qnTjhIMMVapKetdnCa9yr0Rad5GfQhWdMNLxpqPXk4r97q3E3WDboJKx0vXsXRZAoUzkYdc+goImVHWJoM710snowzU1w15X+LFFJSPNrcfHP8MbnkOt0xDcdI4Z23cQ3x6wAc/tO6uAtQpuTOa4dRsK1jrsKtv3B2qOB0X0qk8NtG7jUBWvpItM+dpZMNntSkfTH1TaBdngeTPUvSr5OrgPOifxfPFLWs5N0+ga83JRUoMwAB9WYeadTIlUo3YDcN/QZUO7ju2vlcOiDiTYyrCz24RgnCo86RqAxdt1uMpoOhodgZVAe4znro1TUs2meAoDVYCvUhnYSsldqnDHBUjQlTpjR4EBHI3awepTMCJgDNJLSRjIijgZD+TPwWv6DaBbKmw3DHJaOexZdOQK0lhtZ8hfrRZMurBroEM9wSeOF2KkKnam6d16mEStst5nSmxChTgJlQZZ6zaSVkHcmEhNbdbAL7u+x5iLahMSOcFYY9G+Jt1YM0issH/3PoK/v55iQ+xZoDU+ofa4zUU/5q5GLydcb8fnfN3KNq0eAIbTl962Zv3+47l0AgvhH4dIIg6P5THeDgZ8upx40x1IFw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 773749fc-0a2c-4dcd-a5d2-08ddda38928d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 07:11:06.8825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skRgvfPTWChC5FwI7Vh1YLWgB9dlT4fcxb076L2v96Mweky57VYi26NhOOvLdhknAGIOl2kqMGuO6NxxJ1u8Vrx/svqAZQGYW+080u+HZRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4437
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508130068
X-Proofpoint-GUID: 4wcBUMZna8QxP33-hAWJz2TbCOWEmts5
X-Proofpoint-ORIG-GUID: 4wcBUMZna8QxP33-hAWJz2TbCOWEmts5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA2OCBTYWx0ZWRfX/KVUdjf1Zmis
 YDfGqK88LCFxicCAW0wkVDn2VhUbQnbblw75DjafuYYc3qWDRMTT8CCPTHYC4f72F5rYw2amor4
 WEH0vwDAWIeXZea1mlJ98aZoNhurrxgHI1iUq08WgH60RLNhfDZpTcj0EejibanyR1nYTW4/3j0
 /FYqGlqeeyNa9bBWqMSerOwGUtpA2Hy1gwOZdrLxIR3D4O9e2Zhg4+Pxsop6vr84lWPtbqDYXHv
 3cxvU+hewTuYmN5Q/XvWGc+zF/ovbp7t0mRPyh9WC6N+sqNGzNCaSlOnDg9SxsgrFt//8mfiIv7
 HFQfLqGm4BFKiZjgJYeh/raWb8UOX0Eiqx6FRGGG2AmhCuE3tJTyIcuzqglO5BFuovAO+1Sxxr2
 gvjXl6GDosIqiyiMA4rIDEwrMVgv4f+9EVQ7e/kxsDQj4onC0u6fJWgb667Azxt2lkU4tJmy
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=689c3a8e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=nSLcMuwPj4R4G31i1eMA:9
 a=CjuIK1q_8ugA:10

On Tue, Aug 12, 2025 at 12:38:58PM +0200, Peter Zijlstra wrote:
> Took over the series from Thomas; much thanks to him for cleaning this up.
>
> The recently fixed reference count leaks could have been detected by using
> refcount_t and refcount_t would have mitigated the potential overflow at
> least.
>
> It turned out that converting the code as is does not work as the
> allocation code ends up doing a refcount_inc() for the first allocation,
> which causes refcount_t sanity checks to emit a UAF warning.
>
> The reason is that the code is sharing functionality at the wrong level and
> ends up being overly complicated for no reason. That's what inevitable led
> to the refcount leak problems.
>
> Address this by splitting the ringbuffer and the AUX buffer mapping and
> allocation parts out into seperate functions, which handle the reference
> counts in a sane way.
>
> That not only simplifies the code and makes it halfways comprehensible, but
> also allows to convert the mmap() related reference counts to refcount_t.
>
> It survives lightweight testing with perf and passes the perf/mmap
> selftest.
>
> Also available at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core
>
> ---
> v2: https://lkml.kernel.org/r/20250811123458.050061356@linutronix.de
>
> Changes vs v2:
>  - replaced patches 4,5 with fine grained steps
>

Whole series LGTM, various nits/comments but nothing of importance.

I also build-checked every commit and checked the new mmap self test all
looks good.

Thanks for this guys, huge improvement! :)

