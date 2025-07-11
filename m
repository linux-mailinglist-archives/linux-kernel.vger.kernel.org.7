Return-Path: <linux-kernel+bounces-728020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C2CB02297
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F4F1C24CEA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68922F0C75;
	Fri, 11 Jul 2025 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MPrH8otY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tMnhwYSA"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BBF195811
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752254801; cv=fail; b=QhlIvmkILIVl8qNQo5FrRymVNKBBnkKOXUydqk8C9N23C/CpN/SGQ+vJSfmXtxFD/SBWRiv9a12gNoScYxMHIRUGaKt9Db5Vsd0u2c1FlL46dLQC47QV7weKjvjX3y3Gs6w0g52cB4DqrnpbV+KmVI3JrXO5xCc6VivvK33/edI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752254801; c=relaxed/simple;
	bh=BB+1+Gem+/8XgntNpASjGG0aI0E53wvFZuJnfcKPdTQ=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=U12tg0F9RWwfvQvkGHZoyoTdH9TKRg3+Cw2gHGOKshbYYomGl+B+5btQwFeKFpAsUh+uSATFRggWzuuqtqXDQ//BB0mx5N5iBbXesmge/HpigkQDNFlG5MbpPnCeDKkqezavRJzmpJycdQ4PWNg78P4D5GmSkA8hhcRZtsdou/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MPrH8otY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tMnhwYSA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BGRaxG026682;
	Fri, 11 Jul 2025 17:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=eIdYphVbt5SgBCuQKV
	3E1rdH8z90lNbG9MgjG26r8Ks=; b=MPrH8otYWoVzNgnu8gvwLcWX1Hu+R4dw+5
	sOhgGm4u3TbkQxj3einlQRjjeimeJehuYV+jPCNqK/iA1GZEqIfvrcnvEGZv+jjy
	E11/JE2TKvcsYXWa6uCPlF6qRCpKbODucgqw1ehiOwK4AncqqkTKmDaTGDY1VhEJ
	24a4DhfFDM/3PtBeb+RchT6PNNyksElRmkRHmuZor4LmsecxGmQXAoVE28L5XI1j
	QOtQCohkOXd3VhV6ASvoLn9F3vvZgXXrlKbJ0o9lOZphhw2yRMa3C8HUrXWscQlf
	tK61x1J2hY7AHeVsQQ2SEt2udH8nN/3szENHRVCw3tWJoG8JP5Rg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u64yr4ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 17:26:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56BFoJoG021402;
	Fri, 11 Jul 2025 17:26:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgdt8q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 17:26:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8lhyLTXj9NEohYw62G0VXbxsgeQKD2OAQiurngjenBDqFAPVsnxOFJN1SOX+XuvZO/VD82+iP/8nxNL2z+0rr4B7bGgHXuzaGAgBIc/NiujcQcw4/6Fmsr8un1TVpiQzPkXdMGFDYnya+JKOTuZqj6s7Y4rEfSZ3lriNZak21WgnmhY9IQmfcfFjzGD0EU453owbFkPNQg/yKYETF+0ezeZ8AX2lEFnZODaE1Pw6LMvYERFM/4+f1uhEmQnCtnhWK5bVyUgcNq5jASXCb2ca7WzpqqhqH+B+qOia07jGdLooMW8VqNw99uzSh8fuBsK8VH2RAkJ9AAYIdPkw4W8tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIdYphVbt5SgBCuQKV3E1rdH8z90lNbG9MgjG26r8Ks=;
 b=gQ2FzSfIWgfwJgKfYjcqro8TmCZX7ayeU9BjG0PBvV/xQajDYFF1pvdrtY5D9EgBXX35nMMbCXWf05Duw4CZ/xqgaFfHJ0qm8QjYpmIrAdoDJoMpmTm93FevT2nbFaCpn+LXtLWaAEyp0xie1B02qWkhpJNH2CVmsgiwvxV+T2Q0U5F/umWklg2aZg3wza1tD6qDuP7fdQbRDnlERdLT/0fYFxHoMArR0cq4EJ2Oqbb8KDDwhD/wYhsvkiUlcsdfA7BH8xr/Hs7yKqrA9EgapeGqg5dF0pXBU56Rajb3pEPk+wfy99XFc8WUI43tgGlkpkb9KGaLL4IKrOitJUy9cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIdYphVbt5SgBCuQKV3E1rdH8z90lNbG9MgjG26r8Ks=;
 b=tMnhwYSAhub7ZBJM+C5jhUM5BfQGhtzh10HtB7LoxQDfmUwVy28HeL2fNQsX725J6TTd62Nd4SsmBC9YGjEoyiwwFDKmc+CowIZ2IV79I2Gjytp3U9o1moDUWMHS5vsJ0bwJklowXJ7x+lnQO5x5dyJ0hTlaeWD3zEXkVWo9QRg=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH8PR10MB6501.namprd10.prod.outlook.com (2603:10b6:510:22b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 11 Jul
 2025 17:26:10 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 17:26:10 +0000
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-11-ankur.a.arora@oracle.com>
 <377d74d6-a7f9-4e94-9276-168a26d49210@redhat.com>
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
In-reply-to: <377d74d6-a7f9-4e94-9276-168a26d49210@redhat.com>
Date: Fri, 11 Jul 2025 10:26:08 -0700
Message-ID: <874iviprkf.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:303:b8::8) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH8PR10MB6501:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d0f69b-eb4f-40d4-398e-08ddc0a006d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DltYmExlD8PwrKmYTty/iLEMJTKiZnb4+BmMZ2w7JuSzcVwgtOM4fc1JtF6D?=
 =?us-ascii?Q?XkUAAxiuPsl9d+KnHmDMHh8b+WXdadusFD2ZwZ0dsgnUWOGQGDYPbp7pv1nr?=
 =?us-ascii?Q?XT2a3HzEeorqG5lKQdNA/gjpo+xjNtv0IZkPSa6xQMeBsK6u80vp1NB2M8Dn?=
 =?us-ascii?Q?DJlw53d3DykFnCEhwP7M/DI1Znx07GBlcddQ2KHlJSJAIkwc5AFJShk+e+XU?=
 =?us-ascii?Q?mZ78MxJFXjEb3y+cCWbkosu8ZjD8CJgczIXM5aQfTq26jQlUx20OtVQZv/Ck?=
 =?us-ascii?Q?uu80VW17vlu+dSxEvTisJNhURrOnWG0KnvJjID4bAJMQLDEFFaiYrYDlwh1t?=
 =?us-ascii?Q?s56y9IWR9DAj9e+nZYJcUsZTPZOZgDm0w81Pzb6/VVq5BuNFV/zjcR2ISDGl?=
 =?us-ascii?Q?ZpkHAL+JZamM96dqoJIqrC6hDS2vIjduQRVzbGbei0cfulsZqXPbA0Sig0O5?=
 =?us-ascii?Q?0tfsLih3MIfjitAIikpa3oPfvZ9VKFSshOM0v9Kg2bdd8DO64D0iknCvQfJl?=
 =?us-ascii?Q?wD96PxCd7DH5pITPW7RkJGLMY2VlK/KhaFOxNhlyUvM2+HkLgDjrceCtKq57?=
 =?us-ascii?Q?cHfP32j8SEKFSDctPNkdj+2XPq6QIcpnBQ7wir+wA/kt+zF0DykGg8owzxDx?=
 =?us-ascii?Q?VbOADRpzP5b4MiLTPT2rSqyf8kdIQTRbmnJ4IsQs5i100vUf0RDVgYt2jQ5v?=
 =?us-ascii?Q?AZS0E/lJJ0yQoW90Srs2dNMy9HPninjRGQkgZxqmhJeC0ROqpeIv7Plxcqiv?=
 =?us-ascii?Q?Xf27gmgYmP6Os612M6iNUShbv0fKX4hQhgww/EXG+eqHONteY4TjIwC7XcS3?=
 =?us-ascii?Q?Lzu4ArtBdVu+78jYAVw5N085ebKKRQYg6lSy6QvTaoma76r5DSGlQRFvXj8Y?=
 =?us-ascii?Q?TQHGQTpTUtQ7LcJDAr+4NshuHvx0MgpCjLk7FKIv6a77KrWQmapsMtC0m66c?=
 =?us-ascii?Q?+hrZSXl9tzlBvdoBdWM/m8eDFYx0qC0xME0ipxFPhKP98nYS9nFfWt8t/X6U?=
 =?us-ascii?Q?6/UDeicSx7Ii6OjKKcYYfV0G5Tac5pqXPIEmzmLixu/t5tdzyEKjnLwTPzqr?=
 =?us-ascii?Q?FdaRrQ2+MbvI1H2R3B8z5J7CTNTgyD7GFIE1k+xakYyCWlzKHu/n/bE5D5WC?=
 =?us-ascii?Q?515DFO/FozuO+6TORYE3ZdmPy4pZ4fVurTlO8RCpfVsifVWV9Gqdl1o5kvX0?=
 =?us-ascii?Q?KwUMHeiKrdLBUpN9GROG5GuCv3MTQpoHoNSHThFLAxhIOunEgTz6anKnRv+9?=
 =?us-ascii?Q?XhnkhzMW1nEIz+zOy2m+N8moUQ8MqxMx+eSzynFKj4UxGnBuH9y7gba8S0SE?=
 =?us-ascii?Q?tU52tczqqLU3Z1Yv4+WIzgJqBKcpHvXNRbV//LqrOoSPw6AeoruQ2jcFT+0z?=
 =?us-ascii?Q?LfSfEhAxuwfmdB9CA8q0yg7/g3unOkEBBDWEyd3FFsxtf0fBjD2Uaho1mA/D?=
 =?us-ascii?Q?nCjQ37EJyTU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?voVWn3HafsCX7MxCYCcZg5yfFOhwWysBDi4YxunLWa/NuQOfOmUiTlGd+lMN?=
 =?us-ascii?Q?LbAdx8u93DMnSFvOduw/A5WoHRLfR3Khfa/yoepIgzW6lekpIs92GWSHWh6+?=
 =?us-ascii?Q?cOl0LY7NbfZay+8j+bjXb3bgrkM4sgaV26osIKbZs6Q/AS8z+L+GW5NB97np?=
 =?us-ascii?Q?/9af/3hb4CrA9cqCOTu/9HQ0Jf9M2Oac/QJlP98j8c0Y/9s9MhveMm8bzDxu?=
 =?us-ascii?Q?D0DV4daP4SvizaF2KSQvDUZtZEF7nx3CPjcmh+EIXp/HqrGuJM3y9QhUfN07?=
 =?us-ascii?Q?K4gCCaQBEWO0uPh8Y8fRymLRgdyBRQUyFWCsY4khjLve9rZJcVzH6C/tmDCq?=
 =?us-ascii?Q?te+LufyNwL1ahXpmHfBDJ/faaUWGrTdwY317IL7rE/ivEkPhmJoWzn2sdSCo?=
 =?us-ascii?Q?MI4OXI7on9KXB1EnncRVtxPRJECqjEPC4bGkcPzjKuxj5rU25XSy53CN5psW?=
 =?us-ascii?Q?FV/XoK0dkaatEdLSq/tib8HhC+jZPzFqiDuprhn28nM7LxhaFCkhQCEbPgqJ?=
 =?us-ascii?Q?/AwY2SCWO32rHJwKhhnQ3H+5tdXO8eTyamTv0eIk5NKFd8lmZHGdfx2vE2Ey?=
 =?us-ascii?Q?5yv4MqRRVnFYYDAV+tHVNQDytVmY+QBCixny2eHcCLilB7xnP8sOBNaCbvzC?=
 =?us-ascii?Q?dqCeKJZXB+Nys1qN+8idTbEo7YhrekDC/XZeyrN7V5YQW6CWM1PdUKJtapb9?=
 =?us-ascii?Q?wqJoKa9Q8B8mU/6/USQlAGv8OzBqchM2v4iu3eIWa5D93tKR2o87qqN71dsJ?=
 =?us-ascii?Q?AeDWqVC6ycdjFKx3M5OFMW0+xXj0IjpfN25gbZXrqCAbjNQwD12z0PiKPJ2Q?=
 =?us-ascii?Q?tOwfx5esmkcFLnUWZ7CwgyrfuKC78iOEjtWxikbKeGnznKbdgwzxf+gB1QGq?=
 =?us-ascii?Q?hmRI5Pa3MNnnbbJDyAacFO32EOP9w0z76W/jUlrIBYTXQ3HDX95SlJvnqGcL?=
 =?us-ascii?Q?JN5eNQ6EGX2rE6sSmGgAs0sSzW4TR5JJcLSBBqTUTqhHCNu3tYJ0zLRxyRRB?=
 =?us-ascii?Q?bgphEx3L8pUhSJ5Qab3si0+x/w+Ri4lIu0Sb6oeln+V0HRJB5m0CpUjgRdxu?=
 =?us-ascii?Q?eNHIShpFlI6OVgEZthuVZQ9YipGIF71Q0Lk2EIwRmdK3drRmez1EfgNsNd9K?=
 =?us-ascii?Q?vzIrrk3IiJBWzkmBGiw4vZMiFz6fSzyjQr/KgzYdcO+ZkxpLcbM1qiZ007ks?=
 =?us-ascii?Q?yf3TyJoJUS6s5qb0qH6nv42gna3OzRVrNlf6pB2dgyrgZfpWUwghFBvewJyc?=
 =?us-ascii?Q?jvZqQHVA8bjjyGbZtNLQnYnGWLL5ln1BvysMnqwzFkL0abTuPMAweb3IpjhO?=
 =?us-ascii?Q?4Zip9yE5Y99OvguA64i8oWdhyXs6+WxDonY5iNZhBhZIbjkslS/touL0VZxp?=
 =?us-ascii?Q?CnsSizF9s8GtBFLkY2KObdQEjE8xiiLkvGQvRvii0RtH5SB00zpp5qn6HbPV?=
 =?us-ascii?Q?2Slr01zqabHIIjY7YKJTk+ESuADd11i4riw55UAMbVM6Gwg/UkOXO40nzTq+?=
 =?us-ascii?Q?QACA5GQ60qPaT6dJ4Ix6hk+eiBqFTNVOl+60B8ALeXgCo+Uci17q2kwAnpHe?=
 =?us-ascii?Q?JG4jbWR9zXk+pB8GQabfMXbLzsX7c0IHom8UXDHAzvGuLAT+R1J1vjT/66aG?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IPyYyGUbUzc02Y5eP+NKdtp1+LDTgvN4lsHGt77Kb+Ff64ttwQXoAoGNXXkq91gh3o2o16GbWDRIOvT4sSYprOIYgMf3+i+voCm0OJ5ydgvi4lYq5FUy2bCYzN7RCTejGpSORN+qapwTP+W/6vuI/3gGuIESH3/kP3LMHA3tIFAzqZ2CIxWn8okYaZLW3Qno0pcIpOHDs2NvThEOhIRkUgEQL4HMUDqKlLrO35GAAqyeBQriIXbt4wIv6Jg+IAJ/dIRt538eIxwF37cPY3ygF2xHEucDPJ8+FUqQ5/0VUK32lx0or9xOpFMvLemMycN5EfT1iE39BD8DbcuiBmr8UkHJg4rMAvEHYck80UvgCUgsSQdD+FZxyNe89QytVtUb8oXuL5Zq+TJTLj4CBPpsx3e/vOpXM71r7PfekZXBJ7ANClV+qBh/nIKwC98wzHQnvVclyDJM6NMujPnqctQSM/7XhHv8u4Gy0CKle2N77MAg3Jst70JeMFEi6SbRe9jyLjpzDXBcNzLjAcJVxKSnkbDI1ZKi5Ly2hDCu8msNyW8mQerTqDP9brepRnXF+Y72IE7Rf5dWHqhP6SBgvwsenlJmHzBX7noXbDmmsSmFcnY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d0f69b-eb4f-40d4-398e-08ddc0a006d5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 17:26:09.9700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwT5FvDXo4CEZHMypsK8+vG2KAif8GI4w2MJTwUYFbYU9Gpv+hVJoHMkNc/dpu3lELpnPgfXh59yiPFr3N+DtCDLoQyj/Y/M9Nx3H3sD7bE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6501
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110128
X-Proofpoint-GUID: 3gr4p8eUbfLBx-Rj63U9rk3p30yvQNX3
X-Proofpoint-ORIG-GUID: 3gr4p8eUbfLBx-Rj63U9rk3p30yvQNX3
X-Authority-Analysis: v=2.4 cv=BtOdwZX5 c=1 sm=1 tr=0 ts=6871493b cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=bsw58EEUFU9EOkeIzxAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEyOCBTYWx0ZWRfX1qByv2YVnQQ4 qzC/ExAG5MPgOYUWUtDXdYvLCz7Ti3oLIamlXG10CWG/l5vJmWBl/e4MR1OtckWU9B78GmBv7zL lwwIORhi4HKU9tCJbyIarB30NjwJ+VcKVXeDeCV9csPID4CwNmN8VTKaDOM+6hkSY87u19esDen
 DF0LMaF2y2L9DcvQ5ukISckz/V7mlxIW/DHix/nKk4E7LcXOSn1HBpPGmru2oQIsbgdWWzonSS3 HSF/NBjMbASQbyCNuv/IOwTabUAYI5pQGd2LrcVv3r8qXFD8RbEGsxrwobggcLpchTWpIJGhfW/ A6gGA6y3LnMFAZW1+6zO7KrSRWw0BLCSVK+iGwf2VwPtj3roTYwh70wpQbaCBbNEOYbO/eFi4gT
 sMnj9b0xn4hGFssW7eoq9785ovPuJvFuMLnArIEb6cdHWiN/jyV6YYvhHael0jB8O5Rl3y6L


David Hildenbrand <david@redhat.com> writes:

> On 10.07.25 02:59, Ankur Arora wrote:
>> clear_page_rep() and clear_page_erms() are wrappers around "REP; STOS"
>> variations. Inlining gets rid of an unnecessary CALL/RET (which isn't
>> free when using RETHUNK speculative execution mitigations.)
>> Fixup and rename clear_page_orig() to adapt to the changed calling
>> convention.
>> And, add a comment from Dave Hansen detailing various clearing mechanisms
>> used in clear_page().
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>   arch/x86/include/asm/page_32.h |  6 +++++
>>   arch/x86/include/asm/page_64.h | 42 ++++++++++++++++++++++++++--------
>>   arch/x86/lib/clear_page_64.S   | 39 +++++++------------------------
>>   3 files changed, 46 insertions(+), 41 deletions(-)
>> diff --git a/arch/x86/include/asm/page_32.h b/arch/x86/include/asm/page_32.h
>> index 0c623706cb7e..a8ff43bb9652 100644
>> --- a/arch/x86/include/asm/page_32.h
>> +++ b/arch/x86/include/asm/page_32.h
>> @@ -17,6 +17,12 @@ extern unsigned long __phys_addr(unsigned long);
>>     #include <linux/string.h>
>>   +/*
>
> /** if this was supposed to be kernel doc (which it looks like it is)
>
>> + * clear_page() - clear kernel page.
>
> "clear a kernel page"
>
> Although I am not sure what a "kernel page" is.
>
> Did you mean "clear a page using a kernel virtual address" ?

Thanks. Yes, this makes way more sense.

> (we have a handful of "kernel page" usages, where we talk about non-user space
> allocations)
>
>> + * @page: address of kernel page
>> + *
>> + * Does absolutely no exception handling.
>> + */
>>   static inline void clear_page(void *page)
>>   {
>>   	memset(page, 0, PAGE_SIZE);
>> diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
>> index 015d23f3e01f..28b9adbc5f00 100644
>> --- a/arch/x86/include/asm/page_64.h
>> +++ b/arch/x86/include/asm/page_64.h
>> @@ -40,23 +40,45 @@ extern unsigned long __phys_addr_symbol(unsigned long);
>>     #define __phys_reloc_hide(x)	(x)
>>   -void clear_page_orig(void *page);
>> -void clear_page_rep(void *page);
>> -void clear_page_erms(void *page);
>> +void memzero_page_aligned_unrolled(void *addr, u64 len);
>>   +/*
>> + * clear_page() - clear kernel page.> + * @page: address of kernel page
>
> Same comment as above.


--
ankur

