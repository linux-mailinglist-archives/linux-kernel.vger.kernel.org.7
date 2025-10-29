Return-Path: <linux-kernel+bounces-875826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C071C19E50
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C4DC4F9133
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F15F23D7D4;
	Wed, 29 Oct 2025 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BaNEBoxL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u9N/5jKF"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60C432A3F9
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761735216; cv=fail; b=DWU7um7cAhQrXa2Gd/VbDKk8kqQ2JrQNuyRStP2kCfXWQ9+GGRBKGBiEjCKcqGqQDYyvfllL5KZtPPPhJVvVU3u+4Jb/u97oT9McEaxXJaTx6JhaJbDKpqC+vvS21Tye6YWyudB/b8Fq+nNaVbFAybtq6qHIX42UltwAleSmFIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761735216; c=relaxed/simple;
	bh=QAnsLjXYdu8q0oIJhV0a3fabcmAxYkyTOvjQwvC5K9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BRE32Rcp7HxqG4xbmn7CDXm0uYFFMqxNTm9b82psY8T8keJTX1aauV1xbaeyTtGYsTWrZvD0rnu1qs2Mny2TMhMetdsAfVtLdOJz7LHwubGVx69zwwNWKHlT2ao/fe3YtohUbPGBbLRlZG/EjmusXKti8srDjF7UQ1jakhv2UG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BaNEBoxL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u9N/5jKF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59T7gCvN002315;
	Wed, 29 Oct 2025 10:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=4l3cu3xkOp5oE/qKzp
	i7Lq7+oaPcro6wFGm9+6t0SXk=; b=BaNEBoxLJnCSgAI/Id8M4L6Rxv/z2oCfSG
	l5ljfBBUDcbu+UXll7PtI9Z3oB9HFEU0Hybs1sOwNK9E9WWBVEVzd2FfbRHK+z8V
	k10O++VKN1XOr9HQq3Oq+cRBw89c1ja2r8Heh0h6qW9KTITEb+i93NCUcd/nm0So
	9D8vLuhWRqsRSExkw5uFhwMRV45eoMFkBKl3uTAhP3+5CsYVWhlEzADhDpdjt8cn
	J8XJpMnl42ijJ5jUsilc/wwK4o84JLaMCI1J4EYS5sbjVJYRdN1tdQUh8HEV3yCQ
	L3ilVLbRy1vjtJOlg55Mfkc2VSW7UKee+xUERMdMw1ByBlO2REiQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a3cv98jja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 10:53:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59T90kag011199;
	Wed, 29 Oct 2025 10:53:23 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33vx2e6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 10:53:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXTx2EOhFrhTRC1GKdGVKMx2R1+8rXaFHi59oix36u0MGMreF+Jl64TKq0iVTujoXpbfcPFcX3mNBXDsWz+k4kZH0DnJc+67r1qKzXUbus6bBVqc+XepzQYfzW/REL9Y3CUkUl6T6CEQJcnwHdv6yX3BEK1kPhyEHXg/lEH1u2zXpj3O36cU5wq6vjBi4Lf8lb6SSKqZVLjL+xuEPAMlZjZaasSKVoFbD2FMRO3gEQaT1MN3NGVPqWe25XBmCSnazxRYTpckekiil6o9nhXRY7J/kqDjJPWcO9nS8tF5vTyPbGRHJpZKi5OljGlvdQ2/dPrtV3C3T6nX85/u5iIigA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4l3cu3xkOp5oE/qKzpi7Lq7+oaPcro6wFGm9+6t0SXk=;
 b=lQsMwaQ70wxxhPoTXbTb7K9ABVHvs5sDRUTrRPRmvVIR2G55SLKW5cA26ZDvacIceA0nAyye5YTOGWZ6AAzrkgEIdiS51igGiZ9mgEV8F8S5LG8u12tIcmpgJ/Pax3NhSRtk1uq/NvKtPr4pQAM/RNT8EQlMX0QzoDRQc0iA/0IbJqWdIZRBUz+ITsCcnQH6zwsYrJzybNLElYfZl3A1ViCeZRH2jQNdFbSTNB3Wew3RcdeLKwaT8eTZjdQmHG+Wn7JLG7UdIGwswGg0tMkT4gz6ri3aA8+kYaxktxKUWFKlJsVki6iZBsaoT5iprSLVjyaj6G6WJ9YywZkN1JeRqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4l3cu3xkOp5oE/qKzpi7Lq7+oaPcro6wFGm9+6t0SXk=;
 b=u9N/5jKFqMPF5h1XgC3xs0NQAF7N8bDNPvMJ1TDpWazh18jTJoCyidzZclyZpAF+HeRczXpMTlYs4QnTsQ2JA3zjuU8yyMbcuONVwC4/L691yrk46qQ1MLSdrjm3yKohefUCg0valKPgEPLXwu5+mURNfrilAX3dUuv2yCg2pzM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS0PR10MB6845.namprd10.prod.outlook.com (2603:10b6:8:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 10:52:54 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 10:52:54 +0000
Date: Wed, 29 Oct 2025 19:52:46 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Petr Tesarik <ptesarik@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] slab: use new API for remaining command line
 parameters
Message-ID: <aQHx_vx1ElIBh7tq@hyeyoo>
References: <cover.1761324765.git.ptesarik@suse.com>
 <6ae7e0ddc72b7619203c07dd5103a598e12f713b.1761324765.git.ptesarik@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ae7e0ddc72b7619203c07dd5103a598e12f713b.1761324765.git.ptesarik@suse.com>
X-ClientProxiedBy: SL2P216CA0174.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS0PR10MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: d044b53b-d25c-4948-a094-08de16d95035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tK42DQ2nop5XhXtn9QxD6QL/oQZBKfuEnzpd+L3x3OKGCGjymJpXKk/0iv4Z?=
 =?us-ascii?Q?0RkW0hL1z3Q+7alhoDCWKWegr4Q/ibZnkl8An+2G8oIl1hfO9u0IOPOBc2XM?=
 =?us-ascii?Q?FnEjPn6epVH2cku+zsKLFch/H/Mddf1Zoly0O/caMBH1/Du5SJaasCJMYy7o?=
 =?us-ascii?Q?0yJUxKqaitPK781qbD/dla4CjRKodsDcNlQnWqLKonU7oEOPRGFmhYVAnxfp?=
 =?us-ascii?Q?UlLIJ6j1Rb0DCPajTpXxd/RZl3GwzyWgvyuVUBSrThDQ80jof27zzOKpWquk?=
 =?us-ascii?Q?V9w8jnmEuOFOF1eI3waMa4KTnmnvvof4euXfqzOygIbsDvQPpUvmu795zSs5?=
 =?us-ascii?Q?3kSL2BVpgswge1N9bdjhB0Rx2s3HgElbD7imTH0v3Rd4fRSkSvQXTwf5Ln1r?=
 =?us-ascii?Q?Yq1L/5KR8iTyzwfIKE/324cmC2xyUc20cGuVM1C0BkhPcILiB68vsjjDtbaG?=
 =?us-ascii?Q?OCajtyAksuc2FaUGA7SdrNfj63bEQf3qlF8ejzSSZj1nbKcp+KvTaYRFXr/S?=
 =?us-ascii?Q?yynCSmEx2fgRlI66ifTsoWso1MyPsCICE8IGGD68yHjLp0tRiS0btkZg2Pw8?=
 =?us-ascii?Q?kjOwm1wXU86v5neeCI2iKlmkl9pXVD6AVic7UKwLsk2GV30w1Qna1+pYv2tJ?=
 =?us-ascii?Q?p1tNbS02zT5nkgX/pf4zzEKAQL/wM+6bEOIaa7q9ptgnfOJ4Dyo7mk1HPzdV?=
 =?us-ascii?Q?9b6778Go4pIrtLQuhXpMRuHKyk15jUJZ1QtiQDrogCpW7V2iFq3npQwiwt8p?=
 =?us-ascii?Q?SLJPwhPxPuoacZpmxHGc8eu2TTHDHFRiPtFSA3ndyDvRX1J+jPJrbPsGt3r/?=
 =?us-ascii?Q?GqXr2HeCiwCdAtByLZfgFV3Gfh2pqRBrFXIrY9l6fhTS3IAVF054IHDaoNeS?=
 =?us-ascii?Q?weMq/iS4XoNkONyj+PIP+RJEcFzzVKsw86PujoN5fyapgrJFO+OqFUfqh/sQ?=
 =?us-ascii?Q?ImdwShlWd6W9ha1K1dK9O2BXo2CHfBs101seP4agbZhcjSC2lO4o/KMm/RH9?=
 =?us-ascii?Q?ryxXkesGKH8D8JDwkxjo+DFe3b52u7zcPzKdvdGVnX8YzOh06qY8VW8CIJrk?=
 =?us-ascii?Q?oklQRH2VSxyrWhLSfIGZ8kSNEXXF+v9ki5hqz+Kyw512r57T0+AjWS6dX8NL?=
 =?us-ascii?Q?q0rU+A3q0U0qi70iWGlsPF3c5F26QXD6JRISaxGUzLPedgJPLaGp4mdilffK?=
 =?us-ascii?Q?3gBp5YbMT5ilufaADhgLTzYNbNiICAA+dNhBjPeEwv74UPogujWV1vh9+IR4?=
 =?us-ascii?Q?Jhj42oNcQCYQPKEypSBILZ/+Kn8aTt7QHIOSNhqJQ97H8J5fbsjiNkcwiL3y?=
 =?us-ascii?Q?qHU7DBqfMm+MtvrCVTEohPHMxaoye4YFfKhHwjgW1W/ZMijWC2uLY9xArK6t?=
 =?us-ascii?Q?2Apr0iDCH6+o9MKaau7LxZxYmzvu6OeivXLgrj3Wv1iZVrDAMRnxEXehgw+i?=
 =?us-ascii?Q?kJXdVwOvZNI6McZ+BmKNzPmBQXa8JHfx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pXWbo3TZC36o+rSLSFqO9b7r9jjJ74YJDh4de3BuXa97yvbWCQgyjU1Hl91a?=
 =?us-ascii?Q?38VWfe9/6ZQQf93joCk9QOIZt+iizKxYiobbZ+Bopnot4kIZSHAJS5aI9lcc?=
 =?us-ascii?Q?bU9oHpLnm+HyIzz6iRoX/iWM6yv254mKglCLSRS2AFxwrrANnF3WsvZbvKNV?=
 =?us-ascii?Q?DTuPGK4IGyprUAS+jqXBocbwnNTgaxfvOtV53a4IGdPu5gWMxd32OTjyC/ey?=
 =?us-ascii?Q?0Pgj03/YReD1vg85UETMf2JDhfp3Oi4256FKgtZNQTPOrhhpYi2FOaHvSEHx?=
 =?us-ascii?Q?E/ETNAmZiic+ANTuJIsUAvbEQl2VMA6JzdtooB0GYImPkdjaRRxPGwRszeH8?=
 =?us-ascii?Q?/ixvnMVkJXilhgHbUGEBMmnSPSUd4bhOIVCEeG+3E1IMXwLk0e8tbuKvGHrd?=
 =?us-ascii?Q?Bs/r3i98rOLWXSDuoqOa6bSa2xPgGgN/EfTMBb+QhGq5qY3hxoJf0bR4/+lP?=
 =?us-ascii?Q?qloqxFIvBS9SxyogjYG4uF9gYJsuwQQlx9wVdKPV7MwQ4XZjqQNXvkJQ3cPk?=
 =?us-ascii?Q?sVDCiopfCF8xVAF3HKqxs7joaWwxWHxLSjNpy9bhg6Wc5yqxoB/XV5Sr9GhS?=
 =?us-ascii?Q?NjRhIP0rhzqCfc7lB+hDI0jUmVZOBWlIz4yHd7hIIRBUL/YsIrOpKBQp/zXR?=
 =?us-ascii?Q?31yc6K2wjz1AWFOw7UCOyxi0R8hf8/HAi8MCM1rX1IbDSwDWsxP67yba/rTs?=
 =?us-ascii?Q?4br0m0Mut9E1hBBZJibsz8KpLTmgbBiCcG84Jtz2VjR1SnNqRHKBZlrT3NiS?=
 =?us-ascii?Q?SLrrMnf8IONR9+vxwAACNhZnclSCrbRB+lOh3oCxGMGwtzdHREUGF3zb1Gtk?=
 =?us-ascii?Q?TV+EoknGiN7P4pQumyb7umcnNHKfTJaTPa9bWQFfJW7sQE08TA1MMRfO/ROQ?=
 =?us-ascii?Q?/Nw4GwVxDGIGTTBSeM/he73XeO+A2rFh+vXk03KR1P6Tv3hxMJ/A6k4DqnAN?=
 =?us-ascii?Q?5UPLhzjuQfrNdJTOvYpIxApPuYhGrnPBkOXEdxQ/AlMVjRAjo8fJgEbjJrlY?=
 =?us-ascii?Q?JmcKiCXeXFhSWukqqWLS6imfAXc7Cv3X/Q6H5GhbPu1Klsh1rwpwmv8N7EUA?=
 =?us-ascii?Q?ftCPCaB1/5mICIZbFNT3bfSSXluL9+uKyrpih5SFoLPw8ag6fSQyszZ/4jMc?=
 =?us-ascii?Q?abebedx8iVGLwfgKh1DWhqn+qx5f/syIEuP8k0C0xTW2fP00UxeI3Zl9Jyt4?=
 =?us-ascii?Q?F46keVDSgruXY6s8Nm6VHrsZBFkY08OTgYM8xruXqAzzcHnSD/ek4gA+7ZSP?=
 =?us-ascii?Q?qOvL2QaKzv/qx6SEotBYlva1Cgyv+8/J8EhN2RFbc6UTT1fh6+bEzc1q5WiH?=
 =?us-ascii?Q?mMBTAwPc2qMHCl3SDJdoQ99wHnHrkvizfHZoFSKU8TL+DF10L7Qbpak6fIm+?=
 =?us-ascii?Q?vrX7Vx8XW6gcEDjJcDZ0aAFOufhzbOVQ8dfvA/6qJHZeXdgezAl0HFGHoD5Y?=
 =?us-ascii?Q?nFi+MLuc0QAXLP6uV8ZghMvGBS7A1wvB8bOa18HN9IZYUy2xPHhde+EUCvq8?=
 =?us-ascii?Q?q1q4X7RxRrwi7f5bRtNt2khgWnFknopr5iEtnmY7SiuVLTzlnYM0p0PoH1lw?=
 =?us-ascii?Q?RJGrlClft4ic5KyNhylSz5ddCICZvp26QdJhOxGK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P7WdTDk8NtpPcJBJMM+Ap73w405UINRLEmwio2zrZ9qkuFKyB/KyJTYIlEvi8z584zyTvMxz+ymfHx+3sgs0R70p/Qq8P3pztngA3id0dWZ5SVc0+IIe7F1uFoB54nw7dc+qShLWm97Bx6b92wNoczyho8+f5SIm9SeOrzaAwAOjNpVM1xb/SaO2xaQoeG5P9QI32JRGPswEiE2zR37dKkLM4RlLd2XRZE02rrmw2SZhdTQS+0LtrtcUfE111AjeE9Vvbthxxgqu7rNc/kaps/jZe7Un4ef1q8h+u+ykC+MeD0ulMfnl4e9n33XyEIUvBHJnDMfeiQ4csXxN5deGZV+AkkVEKdRsbNMoS7sBLov1xSvod5n9vN+1N7H6v9FRsQYmluZ3MVKYDK4C8Pkge4H2+sW3ZuNzuy/0C1wmr/mtxg7RqIa9QA3AMD0Fy8OZp+TE8tYneWzltqMe+qY380eykbi7RlhDAUQQ3QPaxGccLkuEFMvhMISy34AKTjLDo2NUypTESi0gw1WOjLLXmLSuovSYh5fEyenmWNyfANijq8H4RqIGPLL7CfAowHz5F9/1NtIiwufX90O0vvwfZZqPcHeqBOVWmk2uPF+MRpw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d044b53b-d25c-4948-a094-08de16d95035
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:52:54.4050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOj1zyHaBbbFsxc/qU7ZUfEmZFLwPB8bpEBIGwAFLyzV8LYd+uYbxBsiiBiXbej6JIZyxhxHoKyxudYxAT2gbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6845
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290081
X-Authority-Analysis: v=2.4 cv=NfrrFmD4 c=1 sm=1 tr=0 ts=6901f224 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8 a=kH64WY-QslCimUNakVoA:9 a=CjuIK1q_8ugA:10
 a=zgiPjhLxNE0A:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: f2gpbhEqrTkDg0pdx-DbsOIt9Eor-O4h
X-Proofpoint-ORIG-GUID: f2gpbhEqrTkDg0pdx-DbsOIt9Eor-O4h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAzOSBTYWx0ZWRfXzkbXgO+4yy8Y
 s6vdWnqsMx+U/rL01hbTfiB63zlmCMQKBDj868KNvR8f3BWW1/XxBKgGOcYg2vBht7rqKW5OHCP
 fPw2u4aUkGkVFEIHxl4eYFI1R1Ux9+77V6EAvdDpqLQebp5/SkqRuFM5cQKnKXZuxf6CzIUyQV7
 7Bo6vISLTdgBwx/3mRKhivywm13VywLVVOiOzYcq4yNms4BvR0/Z04AaRo60IiKQtaZ9krTKMmF
 fo4KOemeua1wUIbTqkAjirj6bYsLxvIcjP9PwZPgOT5p+veBve/N95LOk54Qw4IRG0XAdFPxpQz
 nSOY8tncix0mQe7GzW8bSfydRTprTv39H0eBswZMQhGr7DTCx8Q9vXP7oL2VekGFn5fZeJZ4V69
 1ihgJwTjRhHF/xK2IQi6Nbhl9bLkBA==

On Fri, Oct 24, 2025 at 07:06:54PM +0200, Petr Tesarik wrote:
> Use core_param() and __core_param_cb() instead of __setup() or
> __setup_param() to improve syntax checking and error messages.
> 
> Replace get_option() with kstrtouint(), because:
> * the latter accepts a pointer to const char,
> * these parameters should not accept ranges,
> * error value can be passed directly to parser.
> 
> There is one more change apart from the parsing of numeric parameters:
> slub_strict_numa parameter name must match exactly. Before this patch the

nit: ^ slab_strict_numa

> kernel would silently accept any option that starts with the name as an
> undocumented alias.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

