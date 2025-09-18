Return-Path: <linux-kernel+bounces-822037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06045B82EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1367188A0F5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165F02749E6;
	Thu, 18 Sep 2025 04:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="altiid7f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XqyXqulU"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427D9259CAB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758171291; cv=fail; b=IXgAQWoSO/hLpUdMxTbcA1QJfhCNfJhidwNkssx7NnRjmE5Vs6hzDJbc7vhKOsaduyQ4Xc0N14DpQB25yQRXxwsVp5rwtISwUnszNZBz9i8EJO4Y8wkLUAuofskkz+FpqSsFcZ8GCDHkW6BwXqVAj+zslbkHwVeUHTQ8q+SK9yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758171291; c=relaxed/simple;
	bh=8TUKUqW0C8wzNQGWCfpAcixsHWtIGmItfu4kSx8qa4U=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=e9/BT/4HGQUTaTynGazs5KHC+k9IztgY/G/VYCS1HQnvgYqNyotNVs/17YjxBJxCM1bsaI5d7bKD7L7zmiwGpgXyIh61YWeUUmdADfRDWOE022EmKdIfrzmLIDvwxH5/RQ+bzhzAO/rReXIYHvS1OBCvj3eFya99bTBnq/Sq8Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=altiid7f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XqyXqulU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HM7TfL014322;
	Thu, 18 Sep 2025 04:54:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=1YYkY2OGeHk1nhQea8
	DgKlogA1oEVRZztNSNH0DRZ74=; b=altiid7fQiTgDgV2PFEMMVMoUJw2go6MzQ
	sC788JIASmhTWl+ks8NCa4ge1ZHbHGAD6jaimrGCcLA+wcnybcJbKcHsbSwYSifq
	Ve/iS2fjdZhy1azMxg4YOnGZvPxGFJBspLbHdKYAuD+96/MHwD6nXm8G6R9Gn0N8
	uNFamZ7LrHWKkyn3D/VM91ZOXXCP+X9qC39zmctOikukXqKBq5jM4o76Qw8KA3NA
	RMU7Xo3NoNCgi6oC0VrRsvNzyOapaMYDQ4+hm7QFvegnKNZa5i9v0DOHXbHXRF1H
	TmhouqKEp9szrEXMi534HROdKDg9MnC+o9kDrUoOIsLmXhKkRLfA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497g0kapp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 04:54:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58I3FcmO035088;
	Thu, 18 Sep 2025 04:54:04 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011037.outbound.protection.outlook.com [40.107.208.37])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2mwrc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 04:54:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frl0HGkIR6BFG0Mx/r4mvNhqwY/DZnUiys9HHlQl8urjv9hU6YvbPnwCa5GZwInpzcw00/MwzJ1BiN6rrle/AaUnN100fUBncfs/NmFCeBseTYOg0vHfpLFn0au+QRj6ssJLfPbfUnteg56usqBujKCZk0qpUdFnPFGXvL9b7X8ViaWt/A5hFwTfDmO8jAC1F/gU2JfXFB9Ro2HD1pk13tRWMViKrCNRaNyXfnkfUEPAaSfSrT9eELv17ZaN9pCataD4kCD6B6siupJNBYcPaBOVtPbg02mZRuthk8sY3jymog2Ni4r0U0igAyKY6J9gwWgJs71Hr2lLnGFI1QXFNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YYkY2OGeHk1nhQea8DgKlogA1oEVRZztNSNH0DRZ74=;
 b=ufa+Wko0+yRx4pXYSidrE7yfbPd0H1n4wF86cKWYv+0LQgyN7AevjKsrAMwnWrm1A46Egiac9B0knfMqtSGaqerI6E1lajSyCFcWnDFthdW2N1hYhMSDJNEYmDxhBY+AAUUWt6ozJobo4Kfq+0yvgj8h0Rh4uDFHxe646fO0vIR+orq47jyreTqaEx9SDP90ZngfyNusuoo72q2xMiSvli2d/U7dyDhg2yAxK4UiwsODhPxUDzphn3eRI/MVxBrU41qVYcBK9kpkbOBN/s5VIkm54FdlQl+fb0LVynqwJ3Fw+yluoJVLcw+MY08XjtF5c1jJTONZIYaMYEYPmiy/vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YYkY2OGeHk1nhQea8DgKlogA1oEVRZztNSNH0DRZ74=;
 b=XqyXqulUwlc6sAZCP8TX0apsW/cjIbgGOsn05gpRC/TWRKJ87434aUrlIc6UlyDHkoADuKByRZcrarUkZzvBO0bFiZnE+D+IE3L+uNAY9r+k08zKUTy0YUfFc1j+0fpWJuwfTBbQ+MMrzyQW00IEQ3dWeLHv0INXhADt5qnJ9L0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA2PR10MB4668.namprd10.prod.outlook.com (2603:10b6:806:117::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 04:54:02 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9115.020; Thu, 18 Sep 2025
 04:54:01 +0000
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
 <20250917152418.4077386-14-ankur.a.arora@oracle.com>
 <20250917144418.25cb9117d64b32cb0c7908d9@linux-foundation.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, paulmck@kernel.org
Subject: Re: [PATCH v7 13/16] mm: memory: support clearing page ranges
In-reply-to: <20250917144418.25cb9117d64b32cb0c7908d9@linux-foundation.org>
Date: Wed, 17 Sep 2025 21:54:00 -0700
Message-ID: <87frckgy3b.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:303:b5::6) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA2PR10MB4668:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4b3449-ccc6-4b69-f846-08ddf66f62e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U66EthOxLDlSjVEWE6DPsj3kyGfJUId+aJ4JCRdNvaHLdEdxTd+nj42H3LNp?=
 =?us-ascii?Q?wvstPG217/q8qO4fX/xKksRQVFM+rXfmGThp6JenAzIIQ5p1YgdS3UnIgYIu?=
 =?us-ascii?Q?mzsuWMkjTyYKclT3zLakPvMFw832/Yp/QioIObahRgRyl/6fntiHqmJLOPOi?=
 =?us-ascii?Q?j2JIob2dXvwQa5wkHRq0KL5ejxN1/KKFW+TfvDKOWA7gsOxnZ57O6VDX18b2?=
 =?us-ascii?Q?T7Fo/hdLhq3wjR2/5wy3E7+vsBP7Yd58xgJuCM4hwFW34l8O3JKwoRTjac9a?=
 =?us-ascii?Q?EEYPO3tQxE1xqCzOLhVtXNlcPk1JZB/rCi0mPqiNnL2Xe9rm3ukcZTtrvbnE?=
 =?us-ascii?Q?bKK9zwYnaHFt0XxNlTVazqb/VdqtIik8sKbY6Mb+elKhD0UtugPH8f3oNfPK?=
 =?us-ascii?Q?dhstSJiIvtQz4wIp5A73sdYjpbMtExdgL/Qu1v/GkovztS3NM/l/YQotD4mU?=
 =?us-ascii?Q?O9GF9t/noiJZreJgzTGNdyiosoNbj3r6gnPx0746yqAgBY0v9X4dOBEi7cSO?=
 =?us-ascii?Q?llxEbUz6B9tFG3QbM4WbFLwZWeDgwj6QnNq4r8fN+2GiUQ9u8FcYc1yYzukf?=
 =?us-ascii?Q?rUSsNVj2t1M3hk7y5HW99FXa2HwHH9IgIe5aIUhWy3Z0ozgQGdz4zzaS6/tD?=
 =?us-ascii?Q?jLqXlc7WTYd0uWpmYl1mTSRd3lQERd/oeyu0hqebrSIePMBFGqq7lms/flI2?=
 =?us-ascii?Q?x+QOjEzjVNUk/DDjZYR6p27VPVXpvaOS3E9irzh/HHJsO0RhUWAjZEW2Rav8?=
 =?us-ascii?Q?H/tsH4AtExk9/MbtQNCP+23c5DaKySKtE0og4m6KSSkULTgP1FhNppRSfSWK?=
 =?us-ascii?Q?IrsH9ZajHCOqxvnA9W83Ifsemxz293fjm5Gqko0kwN2NocABpqkiwkqRp0oW?=
 =?us-ascii?Q?3ViWrhFwSZw3Gdf3ziVv2POceN9XvzMwnbPL3n5EB0cK2HW0Q12CX0Stdz6+?=
 =?us-ascii?Q?nNHnz1GYgWtA9aiX4MRUPpfongQy4SN8GGbNhENsqGK182yZoddIPwkpCQT+?=
 =?us-ascii?Q?i/KReojcpFSAjrLiCjg72M0E9cWdE4F+STChbEV5T8jlbhfuG9kxMwBre2Fg?=
 =?us-ascii?Q?G5fVfydonRuSeaRWHsVeJ7N0HO6cJaO0QAxE3a00NohtSuSnJWvfNjsJ0MXX?=
 =?us-ascii?Q?qhAcVI37gXINJADS2OVlmJbzGmQy3pmueAlR+zs8ecy8gvW7pYht6wBkmErx?=
 =?us-ascii?Q?7ZnWCkJE1Lp4wnWhfOfTyg23nhuyHJTEKbkHMFWCvoioETgGkd9UpiykR4+4?=
 =?us-ascii?Q?jkyT2DSOCaEIKrum5eSRyU2XJiW9JCVjeD5P+O5m/ikkZMUbDyXv4pd7YZll?=
 =?us-ascii?Q?Flzx+vH4tfOog48X4Fe0gLGmtMbiqbTokVfcA2p3ioRopy0Xkr1vqlNnOv01?=
 =?us-ascii?Q?pPMqLF5+tGJ7NC5VcYMOrIEcnnnMSQHVAo4Jk/0xfK4qR633CXjLXNeeZLqW?=
 =?us-ascii?Q?WrP3k1oagzQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1TVHY78FDyoGQDkO/nYvy1wgbD2pefzWYsjQbLKKroRTZFgwM04UCfvtjsht?=
 =?us-ascii?Q?qHjxyMCBGIFqjy9HQGlw6dF6Zhc3s7J5zqLnSmN/77JFIf6uE3mwNPfLYes5?=
 =?us-ascii?Q?JrWF8m1oRqRbpo3zggY5WAypVjrm60VPMfL3hQUTbMvPkxLz6s8EHdaCoMNJ?=
 =?us-ascii?Q?L29LxCBRHVbCxolmll9oa6JYoXLMOOrev506MbLVpC4I+AzcHtdpG+q5/eZc?=
 =?us-ascii?Q?YS9oQFCmqfMlLJtO/o7k0OO2tq2wZeNekXAc2/7Wx0jqo/jAmZVv0nmGOosB?=
 =?us-ascii?Q?rykfdTci1sext5tT2ctldWtPi1c+mUIvewlSNGKy6mQx6qbCiQ3v7geraRD9?=
 =?us-ascii?Q?BcUc4dfwDk4WxkKr+VbMwCktcLtUMFjRiyhtpsq/iKMyEDMqY7Po2NCnoxXK?=
 =?us-ascii?Q?1av0OQFW/KMXARGiw7FlQXD1q2gz8tmOUlYd5sWiDd//mgmzsdfskaTUAcoe?=
 =?us-ascii?Q?oA046ScEh7CaZZfMVEj9+vNTHHTtZCEJ25ny6AMemvPjWccLgHrlrAB5AaQ5?=
 =?us-ascii?Q?/PS5JW1IraTnKXSw5+lcArPsefw0hat3jvt89dfMjGbFLgiOvXHfFQbrTCGo?=
 =?us-ascii?Q?e/upYYkhf7yaa0uAyocmcQrlSKGKiMnW+y0eL/Z3JU0PUHyab4B6Q8u1wM8M?=
 =?us-ascii?Q?4Vi2QNujw2QicFifEVtUFs4pQFSsalxkhrXAav1vLaOuyY00VP3zVjFtgAFX?=
 =?us-ascii?Q?vkwUgi2b3DoQ2A5vhvMRhYIqcTe+2KEMDhZx5HSS5/Pw20+4shPMomCy/qoa?=
 =?us-ascii?Q?wzdcKqMzw6HMX2kFlGH8j9ZpuMpahgksxJHy2mKtoSuhZ2HeVWSDMkpuAE/h?=
 =?us-ascii?Q?MXmMPK/Rl6FZ8+EFrQM47X96QTwaHcKVTm+uFx5q6g5sugbh5IyUqGCDs/54?=
 =?us-ascii?Q?1Ab1RUm2ybpoQku4ect3x8qfhTxPqDwH2QM8+rqxJXhYI+3FID17ke8jKSEP?=
 =?us-ascii?Q?5kGalndaXtS87uqdPIinYHoINBPbI8fLW/Qbq7BJcjTPblWa6NOVAlk4T9UM?=
 =?us-ascii?Q?CvVMoE8K8yXRhQIaBQCrE4oQ1dj5yuyhj7Qh8bgB709owOJxQUtbNSpjKM48?=
 =?us-ascii?Q?PFAbxYpq6ljFpMu8sC3fALV69hyfn5wk5QRppFFv/f0VgkPTikGScf+NcaHR?=
 =?us-ascii?Q?FLv2BrBvCKIxW7XmtrEKzHTkz/KG1xizEUKsyS2FzmShTo6FmqfDF7aUoHga?=
 =?us-ascii?Q?9Robvznr4MUBA2k3kyXSSDoUqH6dTnYi1QeO4RfPQBO6Z+fwiiGwgPiKPdxn?=
 =?us-ascii?Q?ztdPyWsPcPv0n7JvM18KxPyFX84epWTDntmEa6Y0/T3L2Dt0cSA1Edzreci7?=
 =?us-ascii?Q?qmrpLA3xtD+FKh3Hxf2tjcvqWupy3hM4JC6ZID0bBCX8LBENPbvCFqnSOFaa?=
 =?us-ascii?Q?rjUOUBcgYCEm3WM65LjKMahYoTA9uY//J7pbc50kSoXiRl+cIlw2xPqqo72Y?=
 =?us-ascii?Q?KtEa13EsyaEnC7ZrRqthXTfocpRwdFqMAKLOv6aDmH1F23h29UL4fJ1SN+LO?=
 =?us-ascii?Q?sYADxVPMaykv2PN5LrTphphy2R0t13PQBDuKy6k1tzxG8SCk3YGKSuD4CalE?=
 =?us-ascii?Q?fijY9850P0Dd0338R/zC8YJY8S8tk0V5/Ai+lbQ6pMwyF+/IZGfeHUhhcQuX?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FlHVdZT9kpg/zasS3fYOvZDjgowBrPV6J1LGM6KEytx0TDEK/XQ9ctYkCuRPSE1LRTivBVh9JsUCW3QYE4/2rGUiV3WobZSIZfkI5Z+bNeFzAoU8p1tlIk9PyxXQLyFD78tKIlvkGQJqUdtUbtTwxNcxa7MBS42hDMpwbnjssGB+K8wBjcVT2LQV7wv1SMdYWohk1mPs4AEn8RagpXzWK84s3jxCrY2xL1IuvQcCfoSukSKtB0nbHOhSUteSLIgEUG/OxCPf/qQVP8d2M88kxQzrD+QPzszCn2dagV36uoZ7fqVNCUFJD/ecasLFcx+nSu0lWAu91sPBOsj1MRotHsHACKnS/J5R3t6yB2Vl573CNCgJpznaNtIYNJMkgPP52a0etuEEArXDUiQmRiypV4mxZ+vDyhjEkPlDFtDbXJ7dj7o77E3AhIYPVzOrkhXzkGncBxaFXrV77Z7p9EALgef9FbRb+qBMofcA2cELoi0myaWCsSeICRtTKB8DE6dI33BxKgOCTffYoJr1c87niNp4ONP6c1Dgfb+Fui8WDZGmsdV8i8fL4osQPjPh+eNyjiPC8lp9ay7lXpOZfpS4O73QK6UNzAp1o58e4aAx8gI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4b3449-ccc6-4b69-f846-08ddf66f62e6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 04:54:01.8938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKTPKm9Ukze4ih4bLJM/Pr7GvbUDnwJNlf9dGIMPPNR2yw/y3lfe2g+snDNK6LcpbTq7RGzerEWJUp9smrVd5RPGy9bKJqAXDorZ4wkap9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180041
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68cb906e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=Z4Rwk6OoAAAA:8 a=yPCof4ZbAAAA:8 a=x7bPxUSWbP2r8J47y-YA:9
 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf awl=host:13614
X-Proofpoint-GUID: j4dTs6n7AXrdPi_qeFgsS2vG6vow7ixV
X-Proofpoint-ORIG-GUID: j4dTs6n7AXrdPi_qeFgsS2vG6vow7ixV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMyBTYWx0ZWRfX4hbjYUAbsi6l
 3N8tBkfPw3A9FWMXATMoVLhEJQXd7ps38smh3SlprM7+CUbEGoc7ZHylkHtieMAHff8DE+Rjfx8
 5IYHTkU4qno3yt5dm393Gtas4eAXBp0A60wXevvIVboqGwck8IjYgDacjT7w8BJj8Z+Yb0HGLlg
 MwiLGwzYy2VSg/KqsTZQiaHp9XUOMC9pvJjCC+3hqlMEyshk7r6PE/zE5e7m+eRFbv6kW8HZ+Qi
 82+CQIgg9hu5/j23c2Df2EEASgmqGvknIfY/pzwrYji/ZzYfN6tEW5ST9r2kpj6d37ajkPVp4HX
 YsPsZXr3XK/0yVT2iZrNtclBqLRd4ZQGGTysJcwKKAD/O/uCpRbGVorcmDiwC6DT50jqB0jTl7J
 ML+2TAqdoLVnhpYTfnpQHBqj4zuy0g==


[ Added Paul McKenney. ]

Andrew Morton <akpm@linux-foundation.org> writes:

> On Wed, 17 Sep 2025 08:24:15 -0700 Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
>> Change folio_zero_user() to clear contiguous page ranges instead of
>> clearing using the current page-at-a-time approach. Exposing the largest
>> feasible length can be useful in enabling processors to optimize based
>> on extent.
>
> This patch is something which MM developers might care to take a closer
> look at.
>
>> However, clearing in large chunks can have two problems:
>>
>>  - cache locality when clearing small folios (< MAX_ORDER_NR_PAGES)
>>    (larger folios don't have any expectation of cache locality).
>>
>>  - preemption latency when clearing large folios.
>>
>> Handle the first by splitting the clearing in three parts: the
>> faulting page and its immediate locality, its left and right
>> regions; with the local neighbourhood cleared last.
>
> Has this optimization been shown to be beneficial?

So, this was mostly meant to be defensive. The current code does a
rather extensive left-right dance around the faulting page via
c6ddfb6c58 ("mm, clear_huge_page: move order algorithm into a separate
function") and I wanted to keep the cache hot property for the region
closest to the address touched by the user.

But, no I haven't run any tests showing that it helps.

> If so, are you able to share some measurements?

From some quick kernel builds (with THP) I do see a consistent
difference of a few seconds (1% worse) if I remove this optimization.
(I'm not sure right now why it is worse -- my expectation was that we
would have higher cache misses, but I see pretty similar cache numbers.)

But let me do a more careful test and report back.

> If not, maybe it should be removed?
>
>> ...
>>
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -7021,40 +7021,80 @@ static inline int process_huge_page(
>>  	return 0;
>>  }
>>
>> -static void clear_gigantic_page(struct folio *folio, unsigned long addr_hint,
>> -				unsigned int nr_pages)
>> +/*
>> + * Clear contiguous pages chunking them up when running under
>> + * non-preemptible models.
>> + */
>> +static void clear_contig_highpages(struct page *page, unsigned long addr,
>> +				   unsigned int npages)
>
> Called "_highpages" because it wraps clear_user_highpages().  It really
> should be called clear_contig_user_highpages() ;)  (Not serious)

Or maybe clear_user_contig_highpages(), so when we get rid of HUGEMEM,
the _highpages could just be chopped off :D.

>>  {
>> -	unsigned long addr = ALIGN_DOWN(addr_hint, folio_size(folio));
>> -	int i;
>> +	unsigned int i, count, unit;
>>
>> -	might_sleep();
>> -	for (i = 0; i < nr_pages; i++) {
>> +	unit = preempt_model_preemptible() ? npages : PAGE_CONTIG_NR;
>
> Almost nothing uses preempt_model_preemptible() and I'm not usefully
> familiar with it.  Will this check avoid all softlockup/rcu/etc
> detections in all situations (ie, configs)?

IMO, yes. The code invoked under preempt_model_preemptible() will boil
down to a single interruptible REP STOSB which might execute over
an extent of 1GB (with the last patch). From prior experiments, I know
that irqs are able to interrupt this. And, I /think/ that is a sufficient
condition for avoiding RCU stalls/softlockups etc.

Also, when we were discussing lazy preemption (which Thomas had
suggested as a way to handle scenarios like this or long running Xen
hypercalls etc) this seemed like a scenario that didn't need any extra
handling for CONFIG_PREEMPT.
We did need 83b28cfe79 ("rcu: handle quiescent states for PREEMPT_RCU=n,
PREEMPT_COUNT=y") for CONFIG_PREEMPT_LAZY but AFAICS this should be safe.

Anyway let me think about your all configs point (though only ones which
can have some flavour for hugetlb.)

Also, I would like x86 folks opinion on this. And, maybe Paul McKenney
just to make sure I'm not missing something on RCU side.


Thanks for the comments.

--
ankur

