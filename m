Return-Path: <linux-kernel+bounces-737294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6118BB0AA5B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 681B47BA294
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838042E7F1F;
	Fri, 18 Jul 2025 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RrCUCyf8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SN5wy/lS"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285EA2E762A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864649; cv=fail; b=NqATr80TmKKPt+nD3qw4Py2eOHARH1ZCNx7VOplCWv8foAOorrSW2itBHytm2dgC+eYtRe9i66zUVrRMbz8KpcmBJBM3EHE2XInfVcFNyTqW+oEH7Fgf1+7QpZ/gg7gJPbGSzzbBYsDrhYL/no2QQS7WuUUKUHaWIILiTITPs2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864649; c=relaxed/simple;
	bh=0igEX/Vd3roqC6ht1NchmePX8PE0iByrXvDQ82fPcgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mLZJJB7aq/s0KomILs/v56qcDohuu0zNwwoQ1DVcibG5bM3EVLj+tq7JL06zQv282Ty/WWzW80aJKcMXiSqSB2qNfxRh2iswb1KdF1sVlrumV00veg+q8gTh66y8LwSRu9IjbKkCwZjZYCKk21v90UO+lSvTatz+abrI27nkaYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RrCUCyf8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SN5wy/lS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IHIIZM020101;
	Fri, 18 Jul 2025 18:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=0igEX/Vd3roqC6ht1N
	chmePX8PE0iByrXvDQ82fPcgQ=; b=RrCUCyf8T/zQOSmiLIazOWcJzuz/BVfr3a
	GIvqms4ouVIOiDaqprhOjyjB0DL9HosDCF4b7jKcwUHnF79tUT9DzuT6AahSnEhX
	34LOCtac/MME9U3rQfkUAiw4TVrKFbdkrhw3YdNRRcTqbJAWk+CYqknctNthjvTj
	KbUMjXXfqJQK4TyzjiyLXCE6FWWyq98UfWZ8ZmUIFz4iU4OQU10KukZfM+HajiMk
	IZPuodfqC0fBJsb92k4UaVOKXZRXn6DzRAMwwE1XThfvcDKtCeWf9d7eGsw4st+L
	CXVaYfQz02cqMYxx6y0S1sqYV57h/S73sML3C91XtUx9yms4xD/g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ufnqxfxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 18:50:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56IHDK2Q011729;
	Fri, 18 Jul 2025 18:50:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5eewxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 18:50:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZq/grUFereN/4z7znVl6ajcWL9A5/IUZrpDGQypszKorNwf/QyeLi2mHtCKRwsyLCYzbCMW7dcUamFIog5EqG9HQ/K+kEaY0p5xMQIHfL2vohPTfVM3ActRuye0e1RhzB12de62UK+wHegvrlZsPN2r0WjZC+XBXrYE70SMRU6a03ybGwvp9Pz0FZW3SJKCUvEo3goe58Wo5j6/XpSMpBkNs9fdEc7PB9LginkceUx1FSKRrYlUwsuteiNEbcGrtnpzK3DWX2JyDkIaoU1q60M1J4F6eje/RmpokYsaOmecXg9wELJ3DYSXDyo3UTo2SJihAEpQSRGrEe17Fz672w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0igEX/Vd3roqC6ht1NchmePX8PE0iByrXvDQ82fPcgQ=;
 b=FJG3psi8Tyj3YMx3ixIqAXKjtc9Z0mV7Y29lqCx6fObp6SCkuGfrA4ChxzAB7rX5wVo2WY43hUrNNnZFWndTTfaNPtXhZbuNWnzkFkXXEGVpSkQbJ/cPuKdw5oaODl8LzpzNpodrBCM3PAuE5yu8QgbAzrZpS1MNlUm5C+iw5w0l6w6KXI5jjtsKE3LXJcknR7iVhNsM7OpyR5w5+Z/gjz1rxIY7g+Ou5jcb9cd3LEGLjKe8SvRni8hlHfkaWI24z+qHsgBeVtftdZXvtiiTUFkJC1qGr+jXhFIyG2WUSvWdNK3fhjmoYknDCXFd0gFe2zrW/vmgyPNc7FuortbQ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0igEX/Vd3roqC6ht1NchmePX8PE0iByrXvDQ82fPcgQ=;
 b=SN5wy/lSmiVau14r8L7rBZ6OEe4edUOhoqLjUqxRJ03SapYPPOcFxUALR/xd84tcmw/MPI8Pmy/O38W8GoTjK50bVYe6b/7HfVuwdHf460kzy57hGYc39ZfEBjH09D2gh2AoS5BSDZNTTJ3siMPMqM7VC6KePzl8GawG4m+m5fk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB7981.namprd10.prod.outlook.com (2603:10b6:408:21e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 18:50:09 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 18:50:09 +0000
Date: Fri, 18 Jul 2025 19:50:06 +0100
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
Subject: Re: [PATCH v5 7/7] arm64: Add batched versions of
 ptep_modify_prot_start/commit
Message-ID: <2784cfb4-0838-4492-920e-cf3a9691bd4d@lucifer.local>
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-8-dev.jain@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718090244.21092-8-dev.jain@arm.com>
X-ClientProxiedBy: LO2P265CA0108.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::24) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e2a7920-3c91-4cf4-b651-08ddc62beb4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pp8OqVM2XwDUaCLDgvFLumwQpf+2Ld7ixiBhhyy3TvDgVW1yanEfP1K89Erd?=
 =?us-ascii?Q?w9ekCoslxSoVAQUFkrxBKr5uqXcX4JInvaPd6otGpbDBdA1o9tCZrt/Zahy+?=
 =?us-ascii?Q?InNPQVZzQmWh2sZbb6wJg1yiBohGJr+YnEP7rgr1lBkyVFTVeYezuGDytquA?=
 =?us-ascii?Q?/U4ZB7WxYeevLT405mMhFe4r1Em/K4dczklOqyZL4/qL5HPVSpCaaM2BBaR5?=
 =?us-ascii?Q?I6Q8p8SYpycs8MCFwCYfHrl0/OgUYQ9YflFCc/IsfGrPOtNZpg2aOfwBV/d7?=
 =?us-ascii?Q?qjuuhmaIjhjBpt1jZ9Hxw2+ck7ygg+sQ0zstIH7fcKuNEm846f5ilbyuu3c3?=
 =?us-ascii?Q?tNBmM5QBm5QXsQXEFWaixRbng9oUObnHSLyCj9ssQGPKR0qdQWURWSe72eqT?=
 =?us-ascii?Q?CUDzMxAVCLvxTXbAGip/dFRgSGvsZ6jyIq3j7QSpziKLHPzmmgBD7NnaMIwJ?=
 =?us-ascii?Q?UF+QPS0s3B3CK6h53emgiUbpuHS3rAH4RM8r8ih+w7rHjm/hbkbRYeqN4HvD?=
 =?us-ascii?Q?kQntOFq49DzSsJ4nbMG/IHhmQmnF2veS24b3HZIyRUzOJQihQyB3v6g/RU7T?=
 =?us-ascii?Q?PCyqsY93jK5r6FnRByzznbmxf0OM7izoIlS2oP/aKBO31jUCvdU3Xo1bILA7?=
 =?us-ascii?Q?d8Ee/wTOg/ItMg6rMp8Ux0mWgglMm/LQbkli5Jt3R0CiZk8nqQHcLrmTb3uA?=
 =?us-ascii?Q?a98SMeN1vx2sdUUqtphmbcJXRRFCgiAnqyEMG68OYwmNT1FP6/Yk0Ev4iLVt?=
 =?us-ascii?Q?cllvB+fK9Ib4/lLq4ExKeyaz2Cbe8qYjOBMTLOxPo0z/VLiZAmrkmyVRe2yI?=
 =?us-ascii?Q?2tmgGfoT2nsFTBxrx3hdaUBuWmn42Ms930M7i2ar8AUeafdujs3FpAZ8eGTS?=
 =?us-ascii?Q?lj4R8WXqUwDddfmBpNxcZ03cd0pZZX+OAUm3DtWbhHaeFgjMftHFyA6viE7l?=
 =?us-ascii?Q?t/6SxQjDzbJzfvzv64tEA0yO/RKG61apyqSmyBBADFq64gzLUGiM1ksVwkhS?=
 =?us-ascii?Q?5Wl7RscR6EpZ/tm30fdR3CFN5mxwvBLaRjxbr2mFvlxpFhSmgXkwL87HiiVq?=
 =?us-ascii?Q?cpWRZ9pMjNAlxj/lS/xBgJfgJW7kI+/JafhI8buuERSpFwpfdK5SnxzENKZC?=
 =?us-ascii?Q?LQ9NCYaAz9KHEr7hWeHKcDFHjaUvrlHfCIOBAsdHgWoWAdtvB3a9MP5DlKYf?=
 =?us-ascii?Q?4mmLCMQ0MzhfMBEIC+2hhFAzCc8J7SeKr2XYBnu0AVRiLjUNnDWTGzaaYA3q?=
 =?us-ascii?Q?FP44n6GSkWKl05gLJsrf1zgkVxtJvcy6dC4fGViIDLQupzDtBdyJTnVnSMC6?=
 =?us-ascii?Q?FgdngY5mRJbriPMbgM4PsTYqMqz2JZ3hNzSNtS147dsbc6koQKk2OgMYz7dJ?=
 =?us-ascii?Q?w+M9kGeVD26tVdgpNxNW8uDIqy4p292Qtuu4r+04FV+764mKLeKVjsOJtl4a?=
 =?us-ascii?Q?wbR6yyr/Wcw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xYWMAq9iI2w0xUt/M8kkheKa1IZUkjWO31SxoFtKnRO69npsJNy9X6LQmo7u?=
 =?us-ascii?Q?RvH+mRR2Xsx/Gh1+zF7NWJ5CIZES/CM63nUqLZBG2fqCXT1JstucCOQI6Xus?=
 =?us-ascii?Q?A0Nc8e71jCayljk9lURfSRrqSHm3m7wKSgCfsM2O54s/d+1hIO7TAlmPBh+C?=
 =?us-ascii?Q?Ds1DGBP19BvWO2jnYCcvXLuxVz1Ek6IfJRfPwpWzwILHz+l/b0j6ECopW4xS?=
 =?us-ascii?Q?yoGpa4Ip4Q0SsNaWJr/wr5hakg1LUoA15R3QhjhlBvENeu2+X2efKxGyMG6x?=
 =?us-ascii?Q?QpxeywDa1vzQH461TtqtEJ7J9+3JmW3rGYdig3VrmO/hbTP8atyWiw9Qeclo?=
 =?us-ascii?Q?1PB+3MAYKYiilYZFeuM4VRw1QjFN71y67IS141rnV4+EUpFIY8eyI9fqDD+z?=
 =?us-ascii?Q?SUbMoDSOHrmcfdHcyshTwMDvYgSThAk1hy1XKZfxOcFDBACEhyAuq4GyA71R?=
 =?us-ascii?Q?kno+udTQ/X+tcJxyUKF95FaJVEKF4lYHmBdlT8RgFzTv5Wuy+uzOiYfKS+2M?=
 =?us-ascii?Q?0AcNMU078xH83VPbPsP1e7poM53Osarx4nmlAxLMabBmJUDlmIh3VRNb7y7M?=
 =?us-ascii?Q?p+7d+UI1lNtdaczqbOcSm3+GvpmJLLrOU3YCEZEZyCCk61UImDH62W3tgFO+?=
 =?us-ascii?Q?JMzAUa/6+CW/6V5hi2OAnX1nstfZtAvJxmf+4biFODvcCdqSOsZzGVmuIEhN?=
 =?us-ascii?Q?CVPLomBaDWwy7Pe6WiB2WVxjvipIeVlmFW27Z3BmbOpEqM1UchYPWihYcAnm?=
 =?us-ascii?Q?5mNh03Rx33CVGx3igppWEop4R4E01KysRW2wZR7gqwUeMkqLw1/g8l0BYO17?=
 =?us-ascii?Q?G68ZXo1oVakPGrkjz/ZFfbgTwi9Zj4zBr5qT9FgXMIBGMYM7fVFT127A+bgR?=
 =?us-ascii?Q?12EtVYoINuk2pT/DZlyV5D9wH5lVa2RXYWFxC4HuUG0hoQYG+ZfrchDNHnpS?=
 =?us-ascii?Q?NVKwgfZoBN6vMm1lUZs4dbFjAuVzzxJp9XB5Nn42VNKaonMW2BLi/xyx10vI?=
 =?us-ascii?Q?qO80DxjOQunFgHF72Fft6Uv4DkbuJ0d2Fzhm1P1pHki1MNunggEz2xDon89b?=
 =?us-ascii?Q?6+OaTQmLZofM7fCjwkYbJPjlmMwa9Yqhczxdn2IAnOaUnmmu1yy0rrUhBDYz?=
 =?us-ascii?Q?4AT/8doC/txdMcRhtHkWyRbNfId3oMrtnEZXPQhlwvOozhXmh79KPdaSaW43?=
 =?us-ascii?Q?6wTKa/V8Cb0ktu+oMbZvG1TrkIYIq0fQKgJ/6qZyK9Mx3J7+DeLrddhSXdws?=
 =?us-ascii?Q?ArKSE/zm9PbH5YhMRkndRLpp7BpqI0Ul88ECAcKmXe0zfkpMU5TcDmVfFyeP?=
 =?us-ascii?Q?W5CGaBAujTl6zVaFxuuZ0tCSCwmtFq36+cL7RdOwwZAIgJ/izH47fGcW/MmF?=
 =?us-ascii?Q?Xem907useXrixc+986MgHrTOgj3adtzmdDJhGF1W0Lvvqu9wA5sDXiM6vUxN?=
 =?us-ascii?Q?shfsppc2tLh7HV672Itrhp/2P3KZbAH1tdL65Yq56tSC/eRrSaS6hICT0v0F?=
 =?us-ascii?Q?ZJrqie3nEGfnJ0Xaft8kXLR7+xrhflpzln4qXLH6VaVW+1C78ZI2XqfxSJqt?=
 =?us-ascii?Q?Te9AOIQ2Et61877KySywvruJBkYfkZmE0kI2ahyoPD2qKPtwqufZ3xed5Zom?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Hicw15sPGhfuH/NBqlLFrlgGHEQ//6MnG+mLdfwKcrPsN5avrvCsHMMFCObHqAho500DmyFgWHVlq/b2eIAq5DZEk228T6xfpJl8Yvv4SXWTScqcat7gkvpmVVFQMtKvUR/Rw7vqnFyomIlSo505DCv9QWCRSXqWj9/nVCUxcm3dVsAXO9xnKNCnVb28j6tWqWWhP3tj91S8fWpjSzWbi1ROzgH9D6RvH1+1ayXEKf7cU8asnXO+OmFF9XRxc42TNSvmKO+pAVRmSnPZXbnnWTKzppWdH8Fdkr8bZsnVw9wGYUeIL55Zdr3+GF9ZAWo4hAI+BOqZw0yrgaYqQVhmQfHuFEgawp+YdJFUlOIEYbnXkg4jr6GcA/oA7d0qT8w4PuFujyIJ6q7n3RM7it97PhRvE9VQqzx9aELibRL1hxZ5KlRAeAoFFb9Q34hE6zVx4YsOZXBfvM735h2LMGs0VMvv3ukxkmWCTSRpATnfK32UNd1J4OkPl3ZThnnQPb12V33Y0bg3YDSJxK2jLdyOF+v8hbLaOlh8A1U1fbynkZHST5Gfb6M9SOF7lX2tzbOtN3dhXJd6njipK+Z5f1emIgshkeW5fPZoadnYhq5cy4g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2a7920-3c91-4cf4-b651-08ddc62beb4c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 18:50:09.0629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L26NG3Jk5n8Q8QBlkIcn+XjzkzCZwmuDBqZRnli2XFTHW3+/2b3ZXLDIMJVLys0sjKguUdVl0OicJdQB5q6kZU2HLr3u1KHtMJ9eeKYU1x0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=909 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180149
X-Proofpoint-GUID: HBZ4xydMUjW-pV903izCQcoPNLy3DGPQ
X-Proofpoint-ORIG-GUID: HBZ4xydMUjW-pV903izCQcoPNLy3DGPQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE0OSBTYWx0ZWRfX3m9U/rppFZeK QCUbhxJB5ooRkcsgUS9lKDhJykfCdfOMByE6T9whgAl2ensksJI7qelxNAmgoyaiyuCQeOyoOAp LIGRKGyl9Fd0rZWLq/wKhD59wkGllOjhKU0pYe+pLb6d/N9S/OBv4T88lkmQmI5XI/KDx2caisl
 EOyN+obGGHVmQVRWw5vZTd+/cK7iOtMe289lmgDmRwa2CW6G/MquQqWZR5mBiNTYZWhhWoIDHq/ KFCDQZhG2kbzp7CTSX/RwDCXFKhXLLfIMe+WCrGmKt1uiVYTu51EOMCwMtMM7IuztmTLMiehh5j wBfc1fEGsnfavAo+w1+C07dkK2zIJ/kJznCNBAweT/2AslvxqFQe1SeEV1LGoKYZBqGhErQB4zY
 OJvTgXOaZOmsMtKlbEkvtTWH3lIFhBwcWdX7Lbrqn8S4z1nTTwM9zx0gllE7/ymWwrtY3YgP
X-Authority-Analysis: v=2.4 cv=U9ySDfru c=1 sm=1 tr=0 ts=687a9765 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=9ajRQuhW0FMHHFYymKwA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12062

Note I'm not forgetting this patch, it's just that I see Ryan has reviewed
it, and on the arm64 side I defer to his expertise.

Cheers, Lorenzo

