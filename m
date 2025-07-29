Return-Path: <linux-kernel+bounces-749413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5566B14DF5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E851189E1FD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8A646447;
	Tue, 29 Jul 2025 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hNMChPUC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NuaLY3hg"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3151C1758B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753793674; cv=fail; b=rCB7Ccf8rN0+kEhn+p8b08lja2dUonv91oBhxeh5rVCQYHGdzzKjv9t51VGhj7yRhz8mH3SAjyljUVJNGceqj9vyPCeMVEkZVYOvK1DaSDUXm/tNv4sZGhADpNQaQ6QizN0wrS+Lbcx/Vqo+5WJ6JTJ2RSFybqbJeCeR3Jm5TnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753793674; c=relaxed/simple;
	bh=EqQsc6ieij9F+vvWXZokufGwV3EK9cRNAZHesdUtJYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kvDtLa/itVggrQnxDtaxqxonS0lbr2z+EUaYxSr0YDb5ZHtsDStIOuwwwpIA1ZtxxSArVxLlQ9BpzPzjuV+q6p+vmZT2/QEcmFsd2LQaPiJhY8CxgmZiPlJTzZDnmf6rgFJuHdCrOGw6FcM4L17KSyepLMO2UxJvct3MVgbDf8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hNMChPUC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NuaLY3hg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T7g67A030166;
	Tue, 29 Jul 2025 12:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=msD3n0q7EAC3J/eRfX
	OsKYS9iQk6u4KtWPHfMaEjvy4=; b=hNMChPUC21lyCw9t2biggnfJIyQPeFGSBE
	+cjQtm0AMJuruOaBHy8nQEl3IzlGGCGxYPLX0uvtFBHh0w8F2YUABAOn7wz5hSjE
	O1NlMS2CTX11O1tGuV/TczDylYBTJg9J8VQ2pkORhVAJ2c5sIP08zQ/Mkv9VgqdW
	9ptju9ZHITCBL6X3JHIW1OltFPP7zP6U/FhgxK3yYq6SGHNRekLwgiL5Uv2gUM/B
	XSsh8qWu7vBa65KP+MRg4Pa9dIgDQftNezztexlAXQJzeS63svAi1qhYv05D6C/E
	X2BJBUj6ymSpYiNW0MGp1mvV5bzfnMRbKmUv89OxMsZcr/Wo0D5w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q5wqf8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 12:54:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56TB61XM002467;
	Tue, 29 Jul 2025 12:54:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nf9vv96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 12:54:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOTIp017av3GFi7Ea5hklqeOALDKqhKTKUSEybTJy9+Srs2KgHAmDScwdUvpZ/5r1uarzMg9hF5X7MLiovIVVy6FiIEXIwNfK2ercKRY3BHvVIXuefn5+TZY3+GdllhoZHOTHdtRycVgi2XUl4WtVSfbF5TluAHmQNOLCAG6P8QRSib7pH0YLTm5g8Hi66MXYwqdQkZtOouaUaTuHCPOlY7JkSrg5IvJD/4vKzuZxPdtIvalDNwhd7a+TYoi8WCSj0eHqBEqD6x+5s43KYqi0N21z7iQnvgmvTQLC+4lOVUfKuhdXZjhdiOC2p1K68RevGxeWy7L9qGYqeQV+BymSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msD3n0q7EAC3J/eRfXOsKYS9iQk6u4KtWPHfMaEjvy4=;
 b=agYCwsRNGO+HOJC05WkOB/0S/kcsvVjSM76OGdPkmahlkOxv4R19fIza2M4STnicLiIEdrjXx/Oja+zMwWEWwsqmpwKRuCPrmPFjLB7dbwkSvOEF76Y0zZQVdfapGc1/c01xaKrzKkw1jktpMl/3ADMdtBS1YxmUIg7GfMw4TnwIGhjZs+3rqYuWSMdO531wiLFmmbnPQ/mwTmQuxbkzDGzMr4FnZ/li4QpI/hckXDkyzh4eOt1CUnIQnNuhGBTyzvysoRKytXXnsqGnaEc8BeDdYKaJ4uPqbzHSfnU99nraBLupWm8dYcayytSxljQZ+6KRBWFBgwVmlaNPaEfnQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msD3n0q7EAC3J/eRfXOsKYS9iQk6u4KtWPHfMaEjvy4=;
 b=NuaLY3hgJW6JpxG/bywG0RqSOz5/HoMfr7Sgl9v4/DG7XOQzBQVa1AtPllcYrCjANKhTq604ooWLhZrJNyTDW+A//f9CkVbC+CYXHBAOF4FuqlPLFCSAXssNxEfmA5QIRnIMHFQPberOLW/KhnrYghyHSj7zUEG0JTodU//qTd8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB5063.namprd10.prod.outlook.com (2603:10b6:408:126::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Tue, 29 Jul
 2025 12:54:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 12:54:09 +0000
Date: Tue, 29 Jul 2025 13:54:07 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] mm: correct type for vmalloc vm_flags fields
Message-ID: <e74dd8de-7e60-47ab-8a45-2c851f3c5d26@lucifer.local>
References: <20250729114906.55347-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729114906.55347-1-lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: MM0P280CA0073.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB5063:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d5a004-0492-4a22-72a3-08ddce9f02b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZTRK+B2RVHd8a3K00f2+1f1pQ4G3vc+vBc3dLSo5+DDVjKxcnzqBGVqy4HlL?=
 =?us-ascii?Q?xw9rpqrUkdkhaPja6Ntmjedf3L49pmOLIB1qcBQOtRVDAFCUmQlFLTKWRdU+?=
 =?us-ascii?Q?cOYUZ26kG4U9kOsmlW7APyMD9X9wCVqIpNQ8fHW1pSu0bq7cOX9GWemR8jMt?=
 =?us-ascii?Q?brImq5gUFmkkaV26O8Q2piuwA6VTVTluacVUljSMDPcinHVsPSofRPPbNLOj?=
 =?us-ascii?Q?ktMxE7w5WGrZGZWmmRhVlYo8YwXOTpsYhwYC0u6PHTbB1NCzXxyF8/pbFcgc?=
 =?us-ascii?Q?4/lUTnG3i3Rx7DxXE9u0vRBNJ8foUey722IPGFtB28xdfqOlcLpj0BxKqraE?=
 =?us-ascii?Q?NfbLWGmw5RHMFsbHKmXa6RPRFGkUW5FpGoS8qggWPod/VmQdr7P62YdnlwQ1?=
 =?us-ascii?Q?n64mGuyMShPH9Avu3BCTQCgQuR2aJ/FEUuPHdXqSxotaLHhEGBTODXkXeeme?=
 =?us-ascii?Q?3kYywkZiOz9GWEesYa/39vZOiAUiLPx32cEU6McZl5RJhUf9O8KC+1KMksaV?=
 =?us-ascii?Q?ppPxh2GtQC8aZ5608O6SBkV7t15FMOdqKk/HwVnKohFxkMLbGLZPYO+jb0Lk?=
 =?us-ascii?Q?+3ZCOZollhsHFBCadkB6S3CrVFWJ34RWcUPLq4PYOH+cJLcThtZIaaf/QiS9?=
 =?us-ascii?Q?lMKmh/VgQQP+BQ3vuHRxYXJvKL5gEjPb2S5GqZ2X4YO4wzbqxYEnGe0Z3B8c?=
 =?us-ascii?Q?3VMOadKkHhUDwhzr6Or6sdR96GW/95LbkOoxsFMH11YkqVUh029UKk8TxcKM?=
 =?us-ascii?Q?4Ui9JFbUpz4rHWbvnY6k7Wy88EypdPBZp1qdxd/kWoP8rqhExK0ZfScV1DIK?=
 =?us-ascii?Q?qN6xc9zDUvc2opauV3gHmaf1laXHr6vaXSCCftaPxzdjwNARBeylSWxMxf3h?=
 =?us-ascii?Q?GoDDXrdidIw2eNVn25AvCHkKaqaTXsZBwgqBK7cZUruRKJp7fc9rRSImgZL+?=
 =?us-ascii?Q?NUh0Xen8V24H0qIbUeIzuixSvoxm9B2zOWTAOEufxnV3MIdeW7a2MpGb6an0?=
 =?us-ascii?Q?3U0Ce4+CifwWI+VLPV3rEkaIG0I66fitlPT6MAyW5bDtFb4YfqTkgFfAo06+?=
 =?us-ascii?Q?wKWJg3O9bJ7XS1gDc1jDxS2cICtTHo9fDdq1aDNGkul7K2KKEn/fQilM8/Mi?=
 =?us-ascii?Q?SHMYaYpisP0y/Rw01sLHOvAmVMYlqh+g6FT0dj6UDULNWRT4qZm7wpT4EJKs?=
 =?us-ascii?Q?befSKndc2u3ysCEsLaX8PJX+s0y1KVfVg/ZsY2ECEAl0+Qk9UFtbqm7KDo8c?=
 =?us-ascii?Q?o61mTAB1597RT9mbXxLTWRnZo2N65Xzz5MGEeS7X9M1bc1J6XqwgE5f2BcBe?=
 =?us-ascii?Q?xDJeS10mjH9LtyzDUZ1WFRovJnIRU3W30mNhnrPH/dv/tq1/B777eP3yoo1z?=
 =?us-ascii?Q?nAz/Nve+97ZeJhShiCCcdhHWTU2RSa6Ljf90Cc7mpSlfwOvucA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NfZgyCfvIaM//PvUFyyKn0Xd6MU1pVVnJeji9eGscZIopCaAsyqIrKuRkFL5?=
 =?us-ascii?Q?dUqt5kQ2G6wmj6Z1CTmCDWADSsW/xrC5aQR4HpJ/5UuFAxdgPGRGD43tSNNC?=
 =?us-ascii?Q?dE9zDYgidtkk31IagTNO5LpUVpyCpCsotEKWrpNd/ISQYF/VO44U3TJHNIKG?=
 =?us-ascii?Q?Vy7glRWfGzRmjK+8uOKqG5v82Yh2MED1vLPQ7V21F8FgxovqZ5IiD4RLULSG?=
 =?us-ascii?Q?MwR4Un3reia9f6vnITJ4HMk7MRqFfrkYZqmb7/HEtUeqRd0KxMyDn2HT5hu/?=
 =?us-ascii?Q?HZiJTtw70vREWsaloBRbI6J0oJwfXevsV6y+LIzvX30si8qfSVTXi4B6wYSG?=
 =?us-ascii?Q?/J/DD2g0eJR5GXpJ7QoDmDOrOKr+IWiayoxrNOAs9Iia6V4BOq7dFf8mIe9S?=
 =?us-ascii?Q?mp3rtwRjhy5FP0VcTzE2r8Bpl7r1lW0ABdehAxPEpd5guHyNA1UGi42QTv8c?=
 =?us-ascii?Q?ouVtvXjL88oVXgli8HMTcOTlbDWdPKz89d7iH9u6xrScVKH89WhAkT2bu9ii?=
 =?us-ascii?Q?8PVPZHsD+4tNV/dCsKGa7VHU+3LLjFDlT6Ca2za060r/jvPS0fr7x9KAvEUd?=
 =?us-ascii?Q?X1lpV1ao9906pVLYkuGQJq9/nvQ47QuxIra+TIRC0u1L8CmdTwXwN6V8uSZT?=
 =?us-ascii?Q?hEc3kZj7SN8WzyaSN7n+pKh8wxholz4Jzw7r3awSs+836HwmD5d64UjwlStX?=
 =?us-ascii?Q?vLYo3GAJVe+aH34xesv2kiB64prJZ6Bxg1sSHVCT+8D/ZHiv2twTkgPfh6Q/?=
 =?us-ascii?Q?kw8dEvDbLRaBKlGKQvEdHKVFrFd7Vw+9NLWILYOAhl7zA8iJ0PjcggSNKCTW?=
 =?us-ascii?Q?CL9BCGPrbgxqVzeGVn2Fi0zRDC9MiLx7lSclg/DQd5TFWPFz7OD7hrDvFvBO?=
 =?us-ascii?Q?+XXZRfwBBb/rXIIUsPedJcw42n5O+LezT5ZfEtfuvDBpBnunuwO2JpRBYVf6?=
 =?us-ascii?Q?87msMUQqC2tD4KxO2ZPztEEr3HkCSbv8G2cu6/4KJb+hbUAsnjJVD3kYfANs?=
 =?us-ascii?Q?I1H6PxLqjxL1XUcB2wrT+CBfsBuRKJpFrMv8ibsI823wvUSKZ+y/4j+YJMOV?=
 =?us-ascii?Q?gN0JX2SA0Ybz/6B1g2dVsfKEaaEGclLJ4C/S8I6qahPbiTCP3/mHIxvnipl7?=
 =?us-ascii?Q?lg4CxLrdbPKB9F5v92Qbf7cceVww9dRJsKF5LgVsX3LeZD5yXN8tllTQOf69?=
 =?us-ascii?Q?Gh26IwR266jRXJKnW8S/O88E3vtmL8rquAIRZ9uERb9AMisDf1AxXCzyfAsF?=
 =?us-ascii?Q?OK4x3Md9NL7gaP+RfNPSTBQwkocfBL0WfevqQE67cVmJmz/6iIWgtIXEnwIS?=
 =?us-ascii?Q?6DhS+EPpp5dpiawHZMkkPReKuK3JY43NKAK45lCjZCLbouAhqruwnNn/IPAT?=
 =?us-ascii?Q?4yG4xwcIx2qPenhLWKJz+k2k3yGLMphw5FuKC+PdRx9nX1jL3ojDxldUndaY?=
 =?us-ascii?Q?08ifHBzj8yXwEnyS4+SbtSubV/foOHJSKNcYVarXpQGJxQe2uBzSvndAFUN4?=
 =?us-ascii?Q?nuds7RP2JDDKBK22ZtOekJnNM0GCpSIRu+fGlxsQrTrn8Q5rfvKGegeKpPSF?=
 =?us-ascii?Q?6j9kzq8G75JwSQX+FmnjX9nPgtcfwEwc2lM+F1+fjCgDOs3vm6yV4iwvLCXv?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/KXWOq6oYYtXwE7xnH6ffk1Eq7K2soZH+eH2VeCS4lyULEBvcH+95De37EYylmndO+ti0yqnz9l44gepcLKVzjgzIrVl2xtMAim9jCiQQnpnLp9Lro+5MTdw4RGQK8l1/gi0hZbY1f8I5/E9LsxSAlKhmLnyASPOxce6phNL03mUslDfX4+VMEvv+1h93Buuq4f+rWaPxMUhKl8KqMZO7mESffOfpTKIK8ydnvKJkXYKDqYORmvaaDbu1evsxJ1fyas7YjScRPwUKVOBNKg0XKv9xim40PPgRJ+19KJdbUZLqvffbz4aAzKaisbDB0tZZGA0xr1hYUb1pkolJTGAael45xN/ma1ZdTdXeiAMRSdXgI9bIbLgrOzJNe+smztFtQF124npw59BuiS/pyAx9xExnxQ1QLy+WEZRJiScxOFfr2eFbiZ7+DDp5e6uFCVOSSEuiIxWWQQazj2btxV+0JUHI9bQczH7pBNPf0QJlGVhbxKvKdbrCseV30QUR/z9j3VLADgCOFp+9+p+IiEJ7C4L3hLvOEVHrD82KFt8vCP/JA2T/KTTiVL8iYLP/3m990aX7Tzi+JVnGnjq1tjM7QdPL2Wa4XMCWxU6/LfLlzQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d5a004-0492-4a22-72a3-08ddce9f02b0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 12:54:09.7370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tExr6q+JMpX9lJLWgLfCUVKJFuyilaa9ghYkUcncyrBELn4U9D7krH5uF7KuX7h+bJAcfZejFuZp99wiFz77boQ4Q1RCT4SNdNN4V2uk09g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507290100
X-Proofpoint-ORIG-GUID: r005hb6rVPNvICS1RZZBB0ma5aiu3NDI
X-Authority-Analysis: v=2.4 cv=LdA86ifi c=1 sm=1 tr=0 ts=6888c478 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=iybBcRF1y069ExydBgAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA5OSBTYWx0ZWRfX7N14qPYDhelU
 k9no1qvl1Bonq8A6a9W4RqTCIRAsQPV1PVhW30ytuQp3wRDrSObU5m1XWNIQlOWljo7VSlGYylz
 885eOTeVSIPOfhM9Y81qFQjtKo1aDcxUYR45hx7nPhxwGb9ZkIOCy8NFAL8QLwFOizVpKKkpJld
 5vUs2r7LKNaBKJWXg/BxAZC6qo1i9oFjG5YapZ6ZBQh4RVb8WU5yf4ro1bjpXUi5guNwKYDuP+F
 uXsvyv4VqJP0EFa1otg70Q+9j/fD13SI+fWo2A8eZuJiEDNc0Uv8ofK+Z0NB8tbTbwSx+Ib6ASj
 HyKvXmfhT3waklVOF/Sfp20H57ve3acQf97dyihW5noa8qvH0puRfy7Putc1z3MDZ6w34hVHpUu
 pZqDvoLPrigYoYqXM6GPbtjDVeCM5heQVbX2nVnrpr3aHKUKOOCEXeae05JYKezJFpdBisJS
X-Proofpoint-GUID: r005hb6rVPNvICS1RZZBB0ma5aiu3NDI

Hi Andrew,

Please apply the below to this series.

Again to re-emphasise, there's no _actual_ issue here (using a typedef for
unsigned long vs unsigned long), it's just fixing up things in preparation
for later changes where this will matter.

Thanks,
Lorenzo

----8<----
From 94ccb0c9e49bf3f9a5a31e2f1da4a722b0a2de50 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Tue, 29 Jul 2025 13:48:50 +0100
Subject: [PATCH] mm: fixup very disguised vmalloc flags parameter

The declare_vma() function in arm64 arch code liberally mixes the concepts
of VMAs and near-identically named vmalloc data structures, so I
accidentally changed the 'vm_flags' field' that is assigned to a 'vma'
thinking it was... the vm_flags field of a vma, which it turns out, it
isn't.

Revert the type from vm_flags_t to unsigned long.

Given vm_flags_t == unsigned long, there is no change in any behaviour
before or after this patch, but in future this will matter.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 20a89ab97dc5..34e5d78af076 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -721,7 +721,7 @@ void mark_rodata_ro(void)

 static void __init declare_vma(struct vm_struct *vma,
 			       void *va_start, void *va_end,
-			       vm_flags_t vm_flags)
+			       unsigned long vm_flags)
 {
 	phys_addr_t pa_start = __pa_symbol(va_start);
 	unsigned long size = va_end - va_start;
--
2.50.1

