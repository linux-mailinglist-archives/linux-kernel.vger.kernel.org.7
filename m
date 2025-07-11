Return-Path: <linux-kernel+bounces-728196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF3FB02488
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11381C433A9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D161E0DE8;
	Fri, 11 Jul 2025 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RyoyjohO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t/99zXRT"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B621DDA14
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 19:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261923; cv=fail; b=pvsneLMaoNhVK+p7JfLbjqb5IwsgEpfnbRGsj9C4ERD3WVYyziBYUYu6l9v9nKnpBooc2+/8vnnJymVEUozVEZG+a+Ohditz7wvuoU1zHSvJb91KBRZaqylKQVSpSGLglywaxDjI4ac3i2Q6LwvxfjQpowuSW07u/H4cbU/dezU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261923; c=relaxed/simple;
	bh=8WL7+akWNrC0NGgvFt+sIc+gFOV4ei6eIGxCzGSG64g=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=I2ziqdLJeEyzTyYq1MoF08VDYMXIpMtfpSgU6sUE5wqa8lgaF/ilTPFjSvmF6TWvQU1V234tS91f8aExURbYRUC97whXWz1YRtWX5JPxYfSX6mrg+DOMSxf20ahdB+URKcmaIKMcmscYBNuEYibVs6liXuDJd2T06UIGoA3qu60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RyoyjohO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t/99zXRT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BJGo8E008704;
	Fri, 11 Jul 2025 19:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=DCsG4RUVpMmCH1ebX7
	UJqBSfGydop6ZkV03Pa4a2zgc=; b=RyoyjohOpEA7s7JaBsYYObWgtw+9RLzRHi
	Omp/OqVXzrH2jkOBg49VCROgvnP8jPvOKmcYxjn4UH3RW/zL6/KDyE+S15GWsruq
	2CTA/GwVv8fdC43H9KiJSncMWTfcGj4OkecM93YiAXneWUOI3A9yWhgGiJsUt6Xn
	zP8NMBxJmMuIiTDRUjiPUS4x0454otY2vZQeJJwExb17iwht0r3QcWFHqcMIz86a
	XTXBPn/1ouMUcytnI/nw4u6v/7D+9E0v2TLSWwu25AeRz0knu++mTaKsxruhSbUf
	YBuvjj9MlbnvqhWXI6ZEpk8/U4R4YJut6bN4fWK3PS95mZ395ejg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u8mh00eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 19:24:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56BI93Fg024219;
	Fri, 11 Jul 2025 19:24:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptge6fky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 19:24:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oi9BqnVDvIyr0tBG83BbvijFb2WA2jCiGQTKZxNIILylagt3fvgRbutKk4WiSv1xgxQzhqLUSlLWT4Dp0hiOU6oQ5c8EIAhI4jQpOp/K3RZBCTFsy/gv/LnFSbpkfaNjWc2HaVKRsPNpxFf+e3WRUV6fiCOW9srVS0vl0lXQ4vVXetMYOUy4YlFh+KJbOfR8vQcit9X40AcGhlzHchZrswCaj1z3ktK3840qGNC6V9VliROp5JWA9QZbo559fFTaYu87jwwq+8ObIMcSYQPHrmaB0XD/G8Ce0ZPj1H1faHPhmCyfhOqa8lsoRsrKsZEoahSQAyiA2KpI0MG9OM3C2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCsG4RUVpMmCH1ebX7UJqBSfGydop6ZkV03Pa4a2zgc=;
 b=ZBlGE+C9eLHA5EWk8RRAXldhTXTbxwo70k7UN6w997S/fFRbeee8jX7/kinSg36r3+20RmIk2+CNZ8gFRnONNBUhfUKUoJufmQdt+H1U3+pzcz8WaqwJWc5u4lde3kWATrSGCqnKJYzOp6cq6L48OoAthRysesX+ieYcEGhyaWcAk0TjiP9xHcwaf0MkKtJhJRDcIsGyzn9a27OzX/BzM7/DMjv54yvrPb9OMUYeXEOLPBg5ZvdXJ6Jsh5JEaAphJiTLaClc7QaF+9JZbjh2Mz/oBfgDgVrPWSvC83WSSYUrRvYgferHZsjH5pjRogUVbIONhf+/F8OCFGiQCu0JqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCsG4RUVpMmCH1ebX7UJqBSfGydop6ZkV03Pa4a2zgc=;
 b=t/99zXRTJjdDkI9DxPR+RfxvlWn0aRFqs/jeLDHpKDxaWOULGRYmKjQDfSR4/rFWx8qzxxXC8rIfOVXGKAuN8yDQF9LLbLu5YZo8ImX0GjX8NQPEAVRSl+pj+eUkX/bYAhAG2L0pNtVWghmNdjaQJnxv8CUFdZeBEVq57Tio6JM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by LV3PR10MB7747.namprd10.prod.outlook.com (2603:10b6:408:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 19:24:54 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 19:24:54 +0000
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-11-ankur.a.arora@oracle.com>
 <377d74d6-a7f9-4e94-9276-168a26d49210@redhat.com>
 <874iviprkf.fsf@oracle.com>
 <d258c487-29c5-4e1b-b5ec-911def6c850c@redhat.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
        peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v5 10/14] x86/mm: Simplify clear_page_*
In-reply-to: <d258c487-29c5-4e1b-b5ec-911def6c850c@redhat.com>
Date: Fri, 11 Jul 2025 12:24:52 -0700
Message-ID: <87tt3imsxn.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:303:8e::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|LV3PR10MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: f88c21f2-2be2-42fc-fb6b-08ddc0b09d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?epxiDo0lOWGLJ3pFcKik6RzPkLViSFEPsQ7bufs/pnIDq1yzXhvZwhaaOnhr?=
 =?us-ascii?Q?wQjuAvyRpC4PWxY0nnm8kW9E+8WEl6bQegVb5fDUETjU5zGn9h2uz8j/Ljw9?=
 =?us-ascii?Q?fVaVoKrklRcXqmjqz/7UcQHIxxx7oLncbxvglKlk32ZOSpBoopGT6UWVv4fh?=
 =?us-ascii?Q?hzTbAoz4r877BIEeNw0SrGr0aZLxnokA1KYBof4ds2pL9Z4Cr5pwDKHiBR1S?=
 =?us-ascii?Q?eHoYS33FRwfvkZ63rBkAJw1UO378LrbTe8lwpJwK1hg+fDitJFoCkQh2boB4?=
 =?us-ascii?Q?8vX8jLORrbZ+sdGwvWRnRY/yQyptpsR9mxltO3VPW1VGzu/ofab6U35c7x1f?=
 =?us-ascii?Q?gNc2DY7f7jmQQzj3S0h3Z8v7c/vTyUp+rgWWjxjrio3IfRdtlr+EEtiL3zm7?=
 =?us-ascii?Q?yWrluefBI4kVbv0gISY2vodiABg79qfHxVpb5Sv3ui42bqqtQdH+2fFsqKYb?=
 =?us-ascii?Q?RKUFz56eqcon3CpqLQkrolC1KgUR7TR0J6q1omzja3EU42UiWQtpi3gLHooU?=
 =?us-ascii?Q?5ToRjEiOsyi86BBpTglpFHu8z5fJnf4ViGDMw5KkLSD0ral9T87NkDZb/Caz?=
 =?us-ascii?Q?atIDQxhm6/o3c5q3Sq7ydUT5bmh880O5f3P9Q8XtESrcRUYjGl+/oOPR9FUm?=
 =?us-ascii?Q?Qxtz393zrqR9mlUVqCencI/SjNsJFj0iztgNttggSrdHDuH/VMXetvObNYXe?=
 =?us-ascii?Q?c/Iu9F3s5csHIWSoiXPVUC8OVTc38KEPMDRsN5dWlzs9X6dQjMqIl28b06SL?=
 =?us-ascii?Q?wFKwJKNLrOOrizfXcxGGNQkhrKfQwqE781TPiJ+1dR1LYt44TWpAVIVGXF0B?=
 =?us-ascii?Q?kjG1lxiZAVaoqXOXntAGnxnhy5Yxf/vf2FlpKfhTKmsS9WqBXi3TFtPJQYCG?=
 =?us-ascii?Q?pnbWtry7obZQz7xihC83eJ3rtJ6Rfq9fPwLMaISh/W3PzlDcd6421PJ0tBO9?=
 =?us-ascii?Q?KEG8Ha+GAamhHV02b7GWNrGg8IBC8+Bd055MR69negLgW9suaQaP0bHKk3t6?=
 =?us-ascii?Q?RxzCDgTZ4cJmVNP0wVznQSkYyVie63WwSAyhBzqNJpisiKoLzpkreRhuebfI?=
 =?us-ascii?Q?9oUzWANj6U1GFDEoerYPGNON9fd1jVqiVZyWsPZ7yuYgpWUgBg54MfSrvF5u?=
 =?us-ascii?Q?VRBFob5/1r9KyEcSAzxhVfsezujO6FHkIUoRtPcCQSPtvtOYjJkpC2AKF6Ke?=
 =?us-ascii?Q?+nmjRwbt3XWJuF3hKN2dcbIqlIh21tOm45yAZ6MqNPp1RCqz8msis/AAyEHo?=
 =?us-ascii?Q?mjtyroubV82rdA8vhcCYS00cLczaV6xLEAzzR8CyGqFM41QboQqm6vKMwKpu?=
 =?us-ascii?Q?JxoUWtNVfIUPJIDYue8ZT/waAqSa3dXR3iIjT8XqXcRR7PBvAVjyPhMF8/C8?=
 =?us-ascii?Q?qzfF+AF/I1zmt/ehXVz+4T0kPpapVD11Lrt0cmt036Bt0SflMSJEAwi76wAX?=
 =?us-ascii?Q?rmiSMgu5Y7Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l/sAuGaZmeX6JZYCFDCy57nZhIKEAqR07CGecZsmi4NjgEd/Dul8SFHRbjuS?=
 =?us-ascii?Q?hsRY+oKA5WUEK96m66++iW8bCoMN7rJCEuHLuDg4U11IIGIu/uqY1bwaF55+?=
 =?us-ascii?Q?gFBjf8xOBSe6b1mcaDGTII6C/wvaOiy2PvLuYE0aU2yyMlzQseftfCu2t5cY?=
 =?us-ascii?Q?Vg0f9g6sxyKnybyQLU76KkjU5JRbSwa5R6rmE8rtWIVSo7x79pAxFAVutMv3?=
 =?us-ascii?Q?pIVDUXq23B76PRm4YTFxhtkSn259PdPMzX8AFUb9adODJKKRve0H4L6+5VQp?=
 =?us-ascii?Q?Uro36UGuPJiPF8Hc73ElxkrnIOuIYUdG5OKe3Dz0mhNE4RISFSuIMxbSv8wr?=
 =?us-ascii?Q?64RhT/C5JHEvAdT3wFlyQ331jAm0k7HMbwkgJbq+fJBwOoVbPotc/pcaM7Tr?=
 =?us-ascii?Q?Hps5ZHGF0WsIOC0535K9zMQGVX35OjNeJh067fDRTyNOjpWZY1NVGgod5SQx?=
 =?us-ascii?Q?crHSjqTTceaZGNckltmm5KhQUQ4RiPlwobjLg0T8MmhAW6cF+51tIPFYw11Y?=
 =?us-ascii?Q?axNmom37Bu5B9wy4jU/jp8yzhyQc3eWN0YixS0HwG52KqNgpetac/zjLr6CU?=
 =?us-ascii?Q?XRjz8H3tL0FzmIPAqWjvgt4K87+6ySI3SfwaD/cJwEGVillNn8ZMEHpkyuGl?=
 =?us-ascii?Q?0jbkhRVkgZip9Emi5GOuY/3lQq+Z2fHnFWkfIqD3WRcKiGY/b7MLyITdeIpQ?=
 =?us-ascii?Q?dYfLOIx4zuU2vlpOUHs6+PzWhIkhwbh1KK1SDhpz9Sd24Z9PHnlJ2EIGtGSL?=
 =?us-ascii?Q?g2pBwNs8sRdLKOMvCAZ0HUGQeekZU4YrqShqMrqIfPCqGrWHX7rRPEESj7X1?=
 =?us-ascii?Q?JgCl5QMJJa2FEo/cwrQAWxVtyY31FCn0ViSEUJ0p6xNh+xQQZ0pLHnhD7ShP?=
 =?us-ascii?Q?Y6BN5Gz+gDUA8irpkenm2h0oX1FH1R40iYvQZLmW/1MOTYS6TMRlBweNFwe6?=
 =?us-ascii?Q?mtm1j1kzz044UXFjqq8mRskB/rx0dF2HgKMkqrHY8NcCfrkuITJPwSiCYrcy?=
 =?us-ascii?Q?ioatcV6dxcv+00bG4hHGEc48MJuJ25B2CWXcSEjA7PD6y/PsJZqP0/aZlQQF?=
 =?us-ascii?Q?SM1ykXaX7/+jfsAL8Nfelbn8/8Wnt11R8CpXDq7zbeseP55Xre/XL2VIPMyT?=
 =?us-ascii?Q?mwuQvoIMzizBeJsOje+HbBLRKxAEW1+f6/bwRds2Mq/mElrMWpHqojM2aLZn?=
 =?us-ascii?Q?4+OnSWuVFElVQe5n3TpzCZRLvbc2Wr+JJ6cv4doajPn9T6Nf5cBgihuZ5dru?=
 =?us-ascii?Q?fDRNtYRmQN63eL1KYmt8AHJUieOGSvwj0tUPYXcpDSBpurv6ITN4NXscBpu7?=
 =?us-ascii?Q?vI0d+T1h5KlcbsCUTAT0YP0C+zXQwcL3mLYNr4lohezQzdE00Ake37hqjZvi?=
 =?us-ascii?Q?6o5ctfpa9dAET8lHIsT4yQAxelVuZ8nUGDzvllVyX1xKBfixGA3X+CTWrWZ9?=
 =?us-ascii?Q?G2EOwj356J4ASS6eE7j+SipFAmeT3jeIvr+l0JsO1Gn0JZH+GpBIG/zmcpWb?=
 =?us-ascii?Q?SvMRK5oKq79fcu3BmiH+4X27ndbdR1Lspz9/4oh1jzk4u8eOwP1L2kjs3AJJ?=
 =?us-ascii?Q?oOr9KtF0uKtgCB+qn5im05dFwsLmzEDrVBMH7NsrAnkPr13E9VjojzRL1EG9?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HqDCnptHpMSqmq4inPtsIDZbe0UvKR9ZRxa5vF+wnOV9KLCUSxk6LxIsErqTiXKZoKsqQOMyC1stOzzC4EmO8jusufOcwFfLxVtbaYGH6F6tBD+r8nW/oKkSz9NyCMsd/JbwC+9PY2/CJcvbnCNj6QXC+P4FoaO5R8q4gic9ehn9f+7DNaFLgXD36RDQcE9tbPsQyHS9wGP1WfIS0ssiDwcWpN//QUjJz608RPW6T5IkhxuHmijOq3gVxD+1xBQqt1dJF6BpPIbSheoo3rf4u5HKEUEnfz+9eoH+i1uO/utzmc90kw4kXNr30tCvvJOSDOaiz625QKpAofJrSDHiGh6lROuUT4RuIWjx1VNTqoZPe/zpHW0BFfoM/CbEuljhV8IVayEgTANKUsLXiGScit8+tTbJYufClnaI2ualFdKo6NFkKp4827IP/OEjjnvhsq0yCytrnNiD1X2d4gt9rq33uGyVYmCQrHjja5PW0FigZCm1g6mdG03Jg8/w6Uqcjh7j7QREZPitwfHR050qvmzoc40crEk+zvWbvrJqjUJRXE8SPFiNjDYOiFt649+H+TYucIKey401gQTrdnQskPW2PkR+XwB53XLquyBZq/A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88c21f2-2be2-42fc-fb6b-08ddc0b09d25
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 19:24:54.1064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yV8JS31ZrVcm6puJ+JDRTlSM0r4/Ctns18zAWeEbDh0TRYLJSpiURkYpoJsSdjgiy2ltD4bmtkAsI67DwqbgnQiDuyBPR0bYwGL3BMQWaIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110144
X-Authority-Analysis: v=2.4 cv=b72y4sGx c=1 sm=1 tr=0 ts=6871650a b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=P6ckELlYBy-DpU23vbMA:9
X-Proofpoint-GUID: Lm37789Om82cHo0yeGif7d2P3_V0zV-z
X-Proofpoint-ORIG-GUID: Lm37789Om82cHo0yeGif7d2P3_V0zV-z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE0MyBTYWx0ZWRfXzxADtXnVaobL 1zUo1qMMHFdwompKZ5bdwMu0MN+sJPD557taJJHuFS19IthAqUzlraxiZosry2uI5YnR6nuiTay mdnwY9wKulQXXrHjrMm/KOCr2LNVyOi9CuGU84OZnC9fzkQaqO/O7TFrqyUPlS91gu0Z6qVT/5r
 WjMSKNP1VOabIILtzCVx+w6wxMzgPItgBOYkKQbBxiiY5vRQ7hFZtsLUjNK7szpFUe6WsWmuTCc d6HlnAiqENdiHSkpOtEdhS4hwFAwhlQ4W1aDBnoYm1PbsLXrJjdp/p+KoBj1cD8IUKDvCh5cMyf RiUNA4nv+bvWOqubFEhLkZAKkSNkHN3kbqHdkdf8E/c/tUvp6YRKaXkEFXUQMWDV6a3saJQDh24
 MZqB38zUGMrmeZwkNX1D5KJqK0U6SDpb2KW8CyuyH9jbcK/ROqe2DJnuUVrRMMBwlK46PCVJ


David Hildenbrand <david@redhat.com> writes:

> On 11.07.25 19:26, Ankur Arora wrote:
>> David Hildenbrand <david@redhat.com> writes:
>>
>>> On 10.07.25 02:59, Ankur Arora wrote:
>>>> clear_page_rep() and clear_page_erms() are wrappers around "REP; STOS"
>>>> variations. Inlining gets rid of an unnecessary CALL/RET (which isn't
>>>> free when using RETHUNK speculative execution mitigations.)
>>>> Fixup and rename clear_page_orig() to adapt to the changed calling
>>>> convention.
>>>> And, add a comment from Dave Hansen detailing various clearing mechanisms
>>>> used in clear_page().
>>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>>> ---
>>>>    arch/x86/include/asm/page_32.h |  6 +++++
>>>>    arch/x86/include/asm/page_64.h | 42 ++++++++++++++++++++++++++--------
>>>>    arch/x86/lib/clear_page_64.S   | 39 +++++++------------------------
>>>>    3 files changed, 46 insertions(+), 41 deletions(-)
>>>> diff --git a/arch/x86/include/asm/page_32.h b/arch/x86/include/asm/page_32.h
>>>> index 0c623706cb7e..a8ff43bb9652 100644
>>>> --- a/arch/x86/include/asm/page_32.h
>>>> +++ b/arch/x86/include/asm/page_32.h
>>>> @@ -17,6 +17,12 @@ extern unsigned long __phys_addr(unsigned long);
>>>>      #include <linux/string.h>
>>>>    +/*
>>>
>>> /** if this was supposed to be kernel doc (which it looks like it is)
>>>
>>>> + * clear_page() - clear kernel page.
>>>
>>> "clear a kernel page"
>>>
>>> Although I am not sure what a "kernel page" is.
>>>
>>> Did you mean "clear a page using a kernel virtual address" ?
>> Thanks. Yes, this makes way more sense.
>
> FWIW, most clear_user_page() will just call clear_page(). The ones that don't,
> have to deal with the dcache flushing, as the page might have cache alias from
> another (mm) address space.
>
> So clear_page() is just about clearing page content using a kernel virtual
> address, and clear_user_page() is additionally taking care of any dcache
> aliases.

Yeah that's a good point.

Right now I'm assuming that clear_user_page() and clear_page() are
effectively identical. Which as you say, isn't true for all the
architectures that can't disambiguate dcache aliases.

So maybe I should be adjusting the naming of the helpers a bit?

Specifically, by calling clear_user_pages() from clear_pages_resched().
Which on x86 etc can just call clear_pages().

--
ankur

