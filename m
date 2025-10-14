Return-Path: <linux-kernel+bounces-853032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20909BDA7F4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23843A9C58
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70004301003;
	Tue, 14 Oct 2025 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k2uJNeN1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qniXOuAm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FAA2773F7
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760457204; cv=fail; b=qd4WOpL/Pwcti3v1sVPGVjALKbdbLohstuCc9+kcrkVUb6MF3AXMZxsokLN/6KJj3vdabJH6bIB18K+NQIpQtRq9vdcLyRa2zmbrHWJbK3mkHJpWJRaxtU4/ja/2gkAynOdESC3tE+JnzqgkDUL8hZKyQBCp7QcVrihylI/ZYVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760457204; c=relaxed/simple;
	bh=iaIJO2KIA41yQpXxvvLreyB3iLC78E9JgtcMPQcbjYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PDcjUw1GY0zglQ6KTnEqFVF5JMP/G5djQhVoBQ2QClyC8eNvLqcDcb9YRMxo6sLh4Jjz/l6g6cNQGMC1ZAPNjVOcg3ai76fNdtc2LpBbrSn3V8Oe1xaN6GSolGckia1gwKgsHyssmutZtUA1E4MjB3k2ibkt3iExp5oRYin7mVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k2uJNeN1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qniXOuAm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EEfJT3028323;
	Tue, 14 Oct 2025 15:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jW0602cEF68q0ML+Ft
	6A4TkQovT0NmAylRbnKFpRtQ0=; b=k2uJNeN1uRbR06FELypeqvv/WbJ9hWv8Xx
	ZwQtCYJ6vBfQpgOGao98vorNE627x8gv4ygV72DDzBY+uyj5oUqJkXZ9t9yu++fM
	nybJ3aJx0mGzrigj7gxn29fSCxoRgCJ593HAMX7eViIDTPt9Oxg3jb5CfrLFAac1
	6FTS+dYcIdvY7OiikuEk/nckVLyyO2YEBIC5rlNkp+nVNP3AJnqZ2enchBEwYhxP
	n9wOEByiA3sFiECV01Ckmczs+8CrWec4OeUBe05zYrhL6JgXu5IFC6++EIz5mzeN
	gsdCk7PvgsshYAqIFxLQ4TjIOaZ/SJEbXvvsxIOqROW1+atjhuSQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf47mmfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 15:52:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59EEqAnk026402;
	Tue, 14 Oct 2025 15:52:45 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp8v62s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 15:52:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3xADeP4eZ3qLRIXhX87AcsvVA1zck05nHyS0ca6JPAjX6OOqi1k+ZGp5pM6R19uX53H0K+hAjrTuPSu27LCm7TJgOqU0d1WZtDjjdFJjwScFTwnEDJgVh2rqddW7x3Eu+Ra0xfa4IEmkDBKyF+Se4zC8eU17gpmJFUa2OIUw1WOB+r5CcwdKSwkhOLe2js85ZYCn+h6wpsrwvGhFe6yKB2xyN3JFjrXnXYm20DwN+P5/92ieZ8iB3cbYItzhQfvtjitl1RaQEG6AeHGoA97bG+QHKFj9BWdbVntUDeyGffvR04bwgKXpRlTNFJsgV8xEjP8jGhQv0Eq0RyPI4FNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jW0602cEF68q0ML+Ft6A4TkQovT0NmAylRbnKFpRtQ0=;
 b=N3n9G74DiGFaDsYC0EpFODR0TB8Nn+dhDPv52e8y/HqaiXJ2p7hpInjX2/1vPNq/H4niJ8dEnD1Z9HLshWPFPXv+udu/TK8DhqTqjJsMnM5ua2OPn31iK48Wd/JNjUCH20MoxXz+veQ7aM7IY6f5mh3gPqOTq7fHHKwjl7bOCcLgFuFLmV21+oD3ffAoeIhFilJfEbrnP/EHl15VOV6T6ra0P91KampRQeDAbK1zPDvtn2iDHUI0ECxbkJ2vnD2lY5KLgXSc7jvt0AoVJM94sUYPPMa8mYGO0hkWtK6p4gqGPglVll0jMueDjIYj5/ra2Po+9G9QmBqE7mUUTn6scA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jW0602cEF68q0ML+Ft6A4TkQovT0NmAylRbnKFpRtQ0=;
 b=qniXOuAm/77km1ovKJPOQnGpEshvMnbkeXpd3BMMocrI0K7cJmse3KDCEoCdxblqDkeg/V8riA3uV0pNMF7j1eE5mGcvh2qmn2N3KkE6ySkO9oqDHdn3xddf7QgzrkDXIMUNPikkhHIbIVUVLFHp0xis1bEWISCtJcJV096rGfs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN2PR10MB4190.namprd10.prod.outlook.com (2603:10b6:208:19a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 15:52:41 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 15:52:41 +0000
Date: Tue, 14 Oct 2025 16:52:38 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, baohua@kernel.org,
        baolin.wang@linux.alibaba.com, dev.jain@arm.com, hughd@google.com,
        ioworker0@gmail.com, kirill@shutemov.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mpenttil@redhat.com,
        npache@redhat.com, ryan.roberts@arm.com, ziy@nvidia.com,
        richard.weiyang@gmail.com
Subject: Re: [PATCH mm-new v3 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
Message-ID: <57cffedc-65c0-44f1-8364-3a3ff9bdc760@lucifer.local>
References: <20251008032657.72406-1-lance.yang@linux.dev>
 <f33735d3-b38d-4b6a-aeba-b415e6b24ea2@lucifer.local>
 <0bfdbccd-9d4a-409f-ae43-b44bb7347d70@linux.dev>
 <f7392f43-b8f1-4e6a-b9c8-25ad8a47f82c@lucifer.local>
 <95a223b1-8d57-40c3-8226-678b1db233aa@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95a223b1-8d57-40c3-8226-678b1db233aa@redhat.com>
X-ClientProxiedBy: LO4P123CA0032.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN2PR10MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d76e392-aeca-4a4a-76af-08de0b39b53a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?znjZdu2um1Ja4PfZ2Rl53JA46H+3bWEtNkVdHL0sqBMBxk2VyQFW9NP3PU8z?=
 =?us-ascii?Q?gFvSyS+WJWGeh4d0WTR+jzDcZ+qYi1wsQ6nqchCcvDYubX4cjZUp6jA1Pi6d?=
 =?us-ascii?Q?zpslZmA/yx2VZ2cIHn0x+dGkEbgGSy4FNUZ/Jpa91VPYWqwXHi/hYMCbFlst?=
 =?us-ascii?Q?yY3pE06KQ3N2JkQKrY6JGk6rpaZgN0tRot6NpXEPEtW6VGoAEhrcATmVrxS2?=
 =?us-ascii?Q?vd/XCIToXowXBCSnQpfG1He7Obi/QqcuK0jBYDtdERj/srl6SL2Azr5aLinj?=
 =?us-ascii?Q?RlJp5laImMuO9pDn4pmeCvHqy/SxbZ0mCuWFPimAYhAA+rF7Fuwi4IowHQgs?=
 =?us-ascii?Q?gMR9z5P2sVyaiWX1aJhscTym+sGCIYkfVabKjYbZhm2fZ3KjlxgCvptTwp/j?=
 =?us-ascii?Q?4GtF+0Ue/db45ER4ilxQi3Flso0/98fHcnn7SJLACekvSy7rxdzs/7gVYFa4?=
 =?us-ascii?Q?qTAkbLJW2cM3npcW7c7icV2Q9RPu2v+CvS7gTj18GyjecgCzCnDUqaVBMRUy?=
 =?us-ascii?Q?5aGLgl1Y/3UOuG4Nu4iPhB2u6VoUc7yoJMmrH10mavPR1LI30VjKysr5kj9/?=
 =?us-ascii?Q?3dkGxKV9Vw/VcUxBNs4ey33NFq/u5nivCKXlsYAWJGknFQKqUA+3LauF9pIS?=
 =?us-ascii?Q?vF3P/LzvnHIVuAPd/MYZ70sZkr5Sx/wTn0KJNcipJtUVYCj3su10iTiKf+uw?=
 =?us-ascii?Q?WHs+EstTxq85rEekvTCZnsRatBEuT9tjjWtkEY2diXid7ZJ+hgOQhBMuN21X?=
 =?us-ascii?Q?kL4f3pncT5pptUlfVf1Hu0RxBrQ4q0iPLH2e+1g4o6W5gOTQgJesHHrb6Yk2?=
 =?us-ascii?Q?9XvPAI11WIEf4s5KnL1Q675NVAvgnIkznEmeYBLXJCzGvMdOxtXtVoYgnMDE?=
 =?us-ascii?Q?mpr1qcndQ5mPCQ0wpm9PICA0k7G9H3gpUQzewSJ2934BPY0fP8ucCkyHCq+2?=
 =?us-ascii?Q?KYYpp9rAJmeYzrnETlgX+iEzxeGVMqfci8JcNWcI/DDrV1HFmjVM8JOoeTvb?=
 =?us-ascii?Q?udc+VcqzQqXyviMC6AsTL5QQ017RuEtLKUm2P0k7SaSr5sNyODcsgo6fh6HI?=
 =?us-ascii?Q?XiloBuLRB1BPbJK7nWIWhmkHbJNKH6KhDdjJk5YXEDIGtlC8jTqu1S5BTCrS?=
 =?us-ascii?Q?N082IUrXI1JuMz6EfTw/2IzCi9Zf9VUH+j8KaGn4PsclkbhpP6VGEVdOmO4y?=
 =?us-ascii?Q?u3PfSKb+SgPSB/IcYJNHr7xa32Q+OB5FmOPNurZnXlf9Ms4zlfvgOAJQTJhP?=
 =?us-ascii?Q?UHSw2dODEA99XUOByx2+AWCCVS4qMvy68qoKMJPyl3JxD1uBT6tsGjzxzXNB?=
 =?us-ascii?Q?MM6UrJ+nt+sHBDSDolkPawbhdCGdo9XbSMVJZbiNQzrxq4aBodCmmQIYKNwF?=
 =?us-ascii?Q?QRt8q6UeoPpYZyjpQThkiRqbEaBEpqyqAbuyAWG/PcU1as+JV96pTKgcss7d?=
 =?us-ascii?Q?BV+FeviS0i8/Kqf9/Iwl6q+RK+SFtjN4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X/wH69OhnYT40fgbxJFbyHj7DOwqYtO3y3W0NozVJuLxp1wA55MkbnPovZ/6?=
 =?us-ascii?Q?1IwSzMHH2iITog+6l73fMFfFFY+igoZrgK5DLn4MykKnc3YdkqG215iiVATA?=
 =?us-ascii?Q?TYozu1UW6EB/VK/Vvxt1WXxZrlPEsTapz6mIOrbamJ1t9BAcIeaVIPKhvqDl?=
 =?us-ascii?Q?53lqUxnAgbjXRjVvH44lpCbE7ke//3FokPbsTLbnZoRYmjubtRJaVovQcwRV?=
 =?us-ascii?Q?D7z/ghITeOppKnOhUPOaActosHiHAxpx+fFx72AxlRkE838EGr0DtCxalath?=
 =?us-ascii?Q?D44z0gPf6UklyJo/lcteFj5tuB9/2kfHAquumMb/6CyQUpRJXWx4I1EfLiM2?=
 =?us-ascii?Q?p6koEruXEg1r9TPSMy5wFhACTSii/JXL+8SV6HMAbmWS+LVlrm6ArBnmJFib?=
 =?us-ascii?Q?jfBeWLbG/+2TZyfKhJQETUDBBIENkeKU0ffVDkdZuXpdicU7o1LETnA7qqKW?=
 =?us-ascii?Q?nt6/rU4ApV8kn4ux3egxYE01queef+WFVgAavngMkW93bxfHJrk8cYob9lB2?=
 =?us-ascii?Q?1aMuHnnYAohw04HZ2FpUpqqPb39vwvOfXH+YbZUbPnYgFgpxjMyii2AqTjgJ?=
 =?us-ascii?Q?OYVdEKPYt9TNbj4svq55gUSYUpjR1Z6+0VzxAA0nEwK5ApX2g+4O4IcIEYdO?=
 =?us-ascii?Q?g9pDjYPgh/PZvPkv/HJ8filwrv4Bd2i5wplEVccb2NPm/xUNDyb8uEkO++lt?=
 =?us-ascii?Q?NvTfcrLvlMriZlWVMSXk5UZelr0Kk430UD6hBtzhIwawk3TP2YQLp6hF8y0e?=
 =?us-ascii?Q?njmsdaOTLDED8B85BzOvMwW4Arxq1VqSjEJtcBk3rNeWpQ2BK7Z9UotOaqFF?=
 =?us-ascii?Q?d7ZfspTmrU+7w49t6rdNEmSz0wENVHEYJMwruMdyfG0MYeHVd4EDsxrP2nS7?=
 =?us-ascii?Q?yV9DP9fs7S8qWXE7X1ocNHay5SIx8vjk6KWGL5SiZZiqW1wo3XTwSxE/aHzZ?=
 =?us-ascii?Q?C1oNalBvOqzqjLZHkc+dFnSeokuamkKqjD6rGmwllTLhvCJ4l4KU5l34hfQR?=
 =?us-ascii?Q?bhChmQv2W43j90a1JU9CkHnNjFZQM28L3mdYn1dQDyQHnku/Gdn3iXjf7jXk?=
 =?us-ascii?Q?IPyK/ah8/SZRd9bWvgXRj1rdeVw2AT7Uo5WfWHmdVImSOR0mkAIFwmLwzh0L?=
 =?us-ascii?Q?vlQmeFNQzvDKwh86J7Vsq0jWGW5YQS2n/h7Vp9Z1amzRCzzUft7qQWylR6m8?=
 =?us-ascii?Q?CDI0FJfmzhsJ6+1hIYgNlJfHAEz44Qu67Bs/TgNUco2WkNcFvLxJacbB/L/U?=
 =?us-ascii?Q?MpbcWyNvUlDPhrmAKeKzLGwd/JxUX/faNHtxj5W7NQWaNJGssZeHUn30vMIe?=
 =?us-ascii?Q?impkjXVUOevd1yYcHhqE8cn5jZCCsZOo3j27NYcyDAa2hdB9r7l+QY1ROUm8?=
 =?us-ascii?Q?IhV0XwiDinL4zQjnNglW2458ye0fCiu5qmRpCOFyc7DKQ1hXs2to4NdDxRyz?=
 =?us-ascii?Q?3na8Bxi0lyeZI3bStyKMXsq8mcGQ9fzx3tfPdnhgOOK6119ufuO/PjuJQG29?=
 =?us-ascii?Q?wkeZPLc4j0RbExt2OcHlTDlm2Luf7fgS15WjHwZfuORgyBk3WLIMYcp0sLG3?=
 =?us-ascii?Q?vFWwEw35j8FPh/bUFLYOcXTPHAyGC2/K8SqcieAHcRMiZZbk8RCbvTs23IHp?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C+O38M5AVes9Tizge0JXLG2DzqAoB7UxR4G6V3bcrGornRF1FOqxhzQ720gajN08xn52z4iTgkLh4eELwb9banZ5lA3gX8OLx43FIstvzEXwP9d/VsZGCp8szSD2p+cQqtYXPtwq8+J3uvRHvWMPx7d1RkhMnZ/mUjJycWx9ZdCcbjXHKCxkhCk5Enl8qlEHXytaxoXicoJB/+3bQv8sQ3UQm43Mu7NDMwSLHr16RzKTG5SRnZu2JY/3d9kdk4/OjBdx28oU6bIrqNxsBwAHns8295PBI/KqLIQRsv+DcEQSP/BmMNmETkH57+zy9ZOrWe5eCaCXk/zQX8q46Mtf+cL85e7Vn1dSCTwJfn6VIKQeel3UgqIADdotTXaarI1Xl7YJvjHeGCl3y45O9zClwELKJdF7yK4F8q8duxL5gRBJqCOQmbl10rTPdPKXv3vK/Ish1X7jAxxNK5n8pGOWJMrax16f78O+PSUd8w6L6N3C1sxX8eXE1vOa1WlELq4fWYIUvtfQrkymwlJ8+g+ZrZc4xyld13eRi+is6YAnYuVGrQoz31g9VfiklTtMhstNgSlKCyswk/L8YSGTfNmTSq9Puw1rXa7oY3YkCFz6fN0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d76e392-aeca-4a4a-76af-08de0b39b53a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 15:52:41.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5KP6q1TxwYfLTMzKtp3yVDm/kRYx/DKlmaQq6JLwUYYjijnrpb2GoCEIxvHM0jm3ZyJ5Kx168sWFG8VukwOKSYopZ1NM509WDEJIHXP1IQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4190
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510140120
X-Authority-Analysis: v=2.4 cv=SK9PlevH c=1 sm=1 tr=0 ts=68ee71ce b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kU6-wLiX-o5OkV44zJwA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13624
X-Proofpoint-GUID: AWmFFYnMEKydZ4Lneca63ipZbH_JJCyT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNiBTYWx0ZWRfX7YpKgrM0Me6Q
 8xfDSSu7qN26ufLHQJjEGPaCs2dSjSQ5XzKh9y9CnJUEuq5gKRXdlCAXjjukEC7z38zFG6Iy4B7
 GShEso8Xyrn7VSKqedflxpbbG1jXq3WOX8ByJp49zpagwmXjKJDebrHfTNWa2BRQuiGwmjGBWj0
 hRmYPB5DQBDjUcfu/eE5W2T8aAMySP1jC8txFggGbRtPAHhPJumasMMmqpZlB6YZdE8MGTJIOKF
 Yq5mznMjBX7YBtz7pPxJoBDTsv6XQDBylGvv2Zsn41S4H19rpTfFT2qLIIFXqP3wSP6OS8RJkqt
 4xAd7vJcIxy6Q+0YC+AUpqb5MwZ9nvMOQwSV2F8HGMDjMx/A/I3I1ITPkQGruKhE8MiE59y5qM4
 c5gCXW64YTVqT84SLjDWalohhRyTXqC8+rh79iiMIm/mCS9PovQ=
X-Proofpoint-ORIG-GUID: AWmFFYnMEKydZ4Lneca63ipZbH_JJCyT

On Tue, Oct 14, 2025 at 05:11:12PM +0200, David Hildenbrand wrote:
> On 14.10.25 16:39, Lorenzo Stoakes wrote:
> > On Tue, Oct 14, 2025 at 10:26:20PM +0800, Lance Yang wrote:
> > >
> > >
> > > On 2025/10/14 19:08, Lorenzo Stoakes wrote:
> > > > On Wed, Oct 08, 2025 at 11:26:57AM +0800, Lance Yang wrote:
> > > > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > > > index abe54f0043c7..bec3e268dc76 100644
> > > > > --- a/mm/khugepaged.c
> > > > > +++ b/mm/khugepaged.c
> > > > > @@ -1020,6 +1020,11 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
> > > > >    		if (!is_swap_pte(vmf.orig_pte))
> > > > >    			continue;
> > > > >
> > > > > +		if (non_swap_entry(pte_to_swp_entry(vmf.orig_pte))) {
> > > > > +			result = SCAN_PTE_NON_PRESENT;
> > > > > +			goto out;
> > > > > +		}
> > > >
> > > > OK seems in line with what we were discussing before...
> > >
> > > Yep. That's the idea :)
> > >
> > > >
> > > > > +
> > > > >    		vmf.pte = pte;
> > > > >    		vmf.ptl = ptl;
> > > > >    		ret = do_swap_page(&vmf);
> > > > > @@ -1281,7 +1286,23 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
> > > > >    	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
> > > > >    	     _pte++, addr += PAGE_SIZE) {
> > > > >    		pte_t pteval = ptep_get(_pte);
> > > > > -		if (is_swap_pte(pteval)) {
> > > > > +		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> > > > > +			++none_or_zero;
> > > > > +			if (!userfaultfd_armed(vma) &&
> > > > > +			    (!cc->is_khugepaged ||
> > > > > +			     none_or_zero <= khugepaged_max_ptes_none)) {
> > > > > +				continue;
> > > > > +			} else {
> > > > > +				result = SCAN_EXCEED_NONE_PTE;
> > > > > +				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> > > > > +				goto out_unmap;
> > > > > +			}
> > > > > +		} else if (!pte_present(pteval)) {
> > > > > +			if (non_swap_entry(pte_to_swp_entry(pteval))) {
> > > >
> > >
> > > Thanks for pointing that out!
> >
> > You've deleted what I've said here and also not indicated whether you'll do what
> > I asked :)
> >
> > Please be clearer...
> >
> > >
> > > > Hm but can't this be pte_protnone() at this stage (or something else)? And then
> > >
> > > Yeah. The funny thing is, a protnone pte cannot actually get here, IIUC.
> > >
> > > ```
> > > static inline int pte_protnone(pte_t pte)
> > > {
> > > 	return (pte_flags(pte) & (_PAGE_PROTNONE | _PAGE_PRESENT))
> > > 		== _PAGE_PROTNONE;
> > > }
> > >
> > > static inline int pte_present(pte_t a)
> > > {
> > > 	return pte_flags(a) & (_PAGE_PRESENT | _PAGE_PROTNONE);
> > > }
> > > ```
> > >
> > > On x86, pte_present() returns true for a protnone pte. And I'd assume
> > > other archs behave similarly ...
> >
> > This was one example, we may make changes in the future that result in entries
> > that are non-present but also non-swap.
> >
> > I don't see the point in eliminating this check based on an implicit, open-coded
> > assumption that this can never be the case, this is just asking for trouble.
> >
> > >
> > > > we're just assuming pte_to_swp_entry() is operating on a swap entry when it in
> > > > fact might not be?
> > > >
> > > > Couldn't we end up with false positives here?
> > >
> > > Emm, I think we're good here and the code is doing the right thing.
> >
> > I mean sorry but just - NO - to doing swap operations based on open-coded checks
> > that you implicitly feel must imply a swap entry.
> >
> > This makes the code a lot more confusing, it opens us up to accidentally
> > breaking things in future and has little to no benefit, I don't see why we're
> > doing it.
> >
> > I don't think every little 'aha X must imply Y so just eliminate Z' idea need be
> > implemented, this feels like a sort of 'mathematical reduction of code ignoring
> > all other factors'.
>
> Not sure I follow. If something is !none && !present it's what we call a
> swap PTE (that includes actual swap and non-swap PTEs).

You see this is the issue. You know that. I knew that, then forgot that :)

Obviously you can go read the function:

/* check whether a pte points to a swap entry */
static inline int is_swap_pte(pte_t pte)
{
	return !pte_none(pte) && !pte_present(pte);
}

And see that this is the definition.

You also have to know that we hack pte_present() so it doesn't actually tell you
the whether the PTE is present but whether it's present and _not protnone_ and
again, I just forgot :>)

But that's the point! You shouldn't _need_ to 'just know' these things.

We have some operations that _require_ the entry to be a swap entry (including
the very poorly named 'non swap entry'), or they'll read back/write garbage.

My key arugment is:

	if (is_thing_we_want())
		do_stuff_with_thing();

Abstracts all this, and is far better than:

	if (condition_a) {
		...
	} else if (!condition_b) {
		do_stuff_with_thing(); // you should just know that !a, !b means we can.
	}

I do agree that the naming is very bad here.

>
> We have the exact same code flow for example in
> copy_pte_range()->copy_nonpresent_pte() and I don't see a problem with it.

Obviously I'd make the same argument above.

>
> If we were to ever change what we call a "swap PTE" (I don't think so?) we'd
> have to fix stuff all over the place.

Sorry it's my mistake for raising this point about some imagined new non-present
PTE that is also not-none, I'm fresh off vacation and forgetting things clearly
:)

So withdraw that point.

>
> Maybe I get the concern here wrong?
>
> --
> Cheers
>
> David / dhildenb
>

Perhaps the naming is really the issue...

Cheers, Lorenzo

