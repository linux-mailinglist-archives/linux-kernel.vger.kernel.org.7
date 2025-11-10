Return-Path: <linux-kernel+bounces-893728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E799C483CE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0FCD42198D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0144280A5A;
	Mon, 10 Nov 2025 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J35UdI5s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fNb5ghty"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB9A277C9E;
	Mon, 10 Nov 2025 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762793512; cv=fail; b=BiEtCKmhygGZL+zGsAtjEdbBy+FHetsKwU8v5n0hmc8+ZXOkh079lqEyX3XYOMw7U5Ld00ZX7qeLXlWpISC29FsGyzyoH4N032tJERfvOyPXV+vQVoMIVopOTtxJg2exJV99TuTL5QYZBHevJ1pQY5VxQfVlG3U8mzb2IyZnBvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762793512; c=relaxed/simple;
	bh=4hDIdU0Tg9rXG2OX3va7x/K81SnSyl/DABN35Fq2hnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d1uMai9BF615HwTbaGe6tyt8RxkOuMVJ1L1Vm6QNQ+9STjgUyxcXncwclDNqoE77/9S5nDt3TLWdDtX/fT8mpO2QH/XOhLRDnMuY4mbnNbLVaQSWCc0pqLTM9pHrpXyzwu/YEr4vD8e08wAaWY4JBGNtC2/AlwoZiPnpVVX2Jvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J35UdI5s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fNb5ghty; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAGBXDM012165;
	Mon, 10 Nov 2025 16:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=4Q/ENrpCOlGPgCTCsL
	ErPpoxMx8gbS6JJH2TeyQVNXE=; b=J35UdI5skCGqtFc2Im9QNaGcYtVOIgBVOp
	3BzQJ2o7cjOqiriQ3sKwH2Ksje4Y3Qt0YmN3t+Lxak4EBju0yKqtlb1Ehc13d1MN
	Es8dbVgt2x8svx3jzh6Ql9+rJ66cMjO+36KbvFBoLTnIEX84t30Pf2zyzScZPCjX
	6DnJmMxTIJ928agTrw5hNkmfOfyeXXDz/MYTBwTJYzpXjH1NcG+F31vIT/XW2a9f
	t7nUsnftk8kgWMXcG8obsqxmAA/qlIotSZSvyTAUHrFVZKYeSUT9mYCkbb/Sq4Ug
	eai/k8dn5/H56yW4hWVSgjscEFBX/ZPZBT9y/kcl+l+SneOQ3QEw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abjug062f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 16:51:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAGiMMs040864;
	Mon, 10 Nov 2025 16:51:28 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010039.outbound.protection.outlook.com [40.93.198.39])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va8d453-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 16:51:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRCmw6SVqY5idf492fJCOHB0dIx9Oc+3uCniPnLwrpfXmj0bYkeJGH4EPkCkqa+rgEyESgAZEKUABx24sLadvxe9P/69BA6w/WQdMz4KPHM3R6hB0qGarBY3gS3REg69Wh+DaFzJpwZXz4frRoBpjmaRAvhWojA/k9g0ZPZnILRsonyMeDZpQtcrVncjXSdZPa4jc66FotjjXmkeqH+kRGs8lfyLug4wekTb7vnxdjCGxRfXLMvuO1iLZmQsqz5v+pCqazDGqt09q80/CKzmLjAJW/o9hUYCA1RjveEBAINdsH1BQws9IPQ2gRhXMIBNo6mk9HHpdL0+X9JL1m9vkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Q/ENrpCOlGPgCTCsLErPpoxMx8gbS6JJH2TeyQVNXE=;
 b=vC5ocR2DFWjjWXEuzt6MOPMiDulvZRMvgfsNb/97nUdSunwYnOny2qd7OphO3WpqsyexzHQHKHmw2sQkzk6JCuKZ1zk6PshNSdhASosZqasYt9dy08EKNzWRHIPPBSG/bJhtOs4RUrPbBu8ymSdU5CHfBUSOGETFWw1AaHIuHD7ISebM2aL+2cpscTk71YQ0OmN0EOq4ONrpWz0LGNxepZlbzPtKoEC9kPJqOcG/uBBngetgDJ8nhmsZoyNkkMUF04am291pR8mZO3hZRPD5ewXfxQr/strYxCc5D7m0X2oXq6/tCje300OQ2j52jNUIuyUiY2vIqaaP0PHheVaznA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Q/ENrpCOlGPgCTCsLErPpoxMx8gbS6JJH2TeyQVNXE=;
 b=fNb5ghtyvvcnthd2Cmff9pEpILeoi1OdC6+mZd5y7ae5D7Dy0F8m6qbptvFcteFN+8OeQTUxBAqA9IqJPY3tDut315EoxDw13MDtWLHsTGgGb1TMHFVyHOr4I3yYRgzNxPH18uZzgsiMm6VY4IcKWnJp4a7pHQ1jscnP1fJC6tg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN2PR10MB4333.namprd10.prod.outlook.com (2603:10b6:208:199::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 16:51:23 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 16:51:22 +0000
Date: Mon, 10 Nov 2025 16:51:20 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Dan Williams <dan.j.williams@intel.com>, Theodore Ts'o <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Mark Brown <broonie@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jiri Kosina <kosina@gmail.com>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for
 tool-generated content
Message-ID: <c8d9f4fc-332f-4df8-9620-e0e2aa6dc0e9@lucifer.local>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
 <11eaf7fa-27d0-4a57-abf0-5f24c918966c@lucifer.local>
 <103ee61c-f958-440c-af73-1cf3600d10fd@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <103ee61c-f958-440c-af73-1cf3600d10fd@intel.com>
X-ClientProxiedBy: LO2P265CA0312.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::36) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN2PR10MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: 722b8faf-0296-4e41-2851-08de20796142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8v2NQsCcIKVxTLNNv8LAa3ckINhAhgwa/2kZQmOHLKBU58n23UEo+QBxdigS?=
 =?us-ascii?Q?nBBVPVWOod3FXr+RyIX5xMcaZ34On7qt0sl27IXNtzHfCRiCkuWTD09d006W?=
 =?us-ascii?Q?T1Bf1f5uCOTQeMgRpeIc4fbULVFqiGAo8dL7ZsRbsCP+DNlSpmIKZUqsXQej?=
 =?us-ascii?Q?I8DZraSjkSUDQYl2nOc0WbsBgjMEqNK21qqz/GdS25yZZ0WwPIU25Xx/6AhP?=
 =?us-ascii?Q?2UGdDaAI18v28Z+5xhMyCu/a1Zg+vPF6JiP6V0yxW+EY8k2KyOFVlzBm2sFM?=
 =?us-ascii?Q?SXMIDZLXlr761XUqbidhBXNG4b7Nh5M0tesSj6WKUfD3xtgoTlD5i8UFIG7O?=
 =?us-ascii?Q?uOc8QFgG44hk65Zl04nyOSeh7XXKz8Qu0bujCC6KdrVM2byv5HqkDnCc0xD0?=
 =?us-ascii?Q?Pd69uI1bPk3F8LEslLNKTONZ2ntVW+k3RJpm7f96yycGZ/oyi9A1CX3AAnqR?=
 =?us-ascii?Q?/HjdxNM2Y+MH7EZLUrVIIlo8x/v8g6/8qplEd8862yV3ezt+3cHGXEbhGFCu?=
 =?us-ascii?Q?srcF57PtanYxWSXV0piT0HCnBbZKnmwnJoWWqfQQSbDEqcVWERvf7PMg6/pD?=
 =?us-ascii?Q?+X78f1zyXeHmZqZ/V27bkAL6nr6AWsLSa5feCzfo9reKKXgojT1FRxzPnByw?=
 =?us-ascii?Q?UbkNQXYjK5p9lOZwthD/XbjJd1ky5+SboCxEbHKXRvXO+A89TKhMOKHXvaO0?=
 =?us-ascii?Q?TS34KeChG42ov8iXJLM/gBXSb9MyvMiXliTgaIwDXRPywSc9MwO5I6f1i8x+?=
 =?us-ascii?Q?JOcwgEDezeXRsXPDVG7HfbGwdB9DZmLG5zbzj4FhOjORpzp/BAJcHZFLrOUL?=
 =?us-ascii?Q?qAIgr8M4fbnSxL0MbFJhOZkOLe+o7IdfSEJwFM/cXqXQAahqIkllxOfNpqL4?=
 =?us-ascii?Q?dQ+R/EpmBUKOkmmo6pXe3xROsq4a+CwUQHj0O5J9SR3Kom7+ITVm+3qqxIPs?=
 =?us-ascii?Q?FoFMY8jzUy1sT/EHtgW6sbG1/MW579Wmankx5iUHIVFzE/+xgSW8+yy07RI8?=
 =?us-ascii?Q?RxCIQxEJYexSBHd4MXmn1JyhV6c1dIDeEHI9okbBnsM4F/BL2AntSHR+tVDB?=
 =?us-ascii?Q?uez7gfAxP0eMpipG9VJ7w/VS+FbLpTgzhLEmBF8/TP4Nx42lIKKOpEbI9RBO?=
 =?us-ascii?Q?qQ8s3Z4vJ/KwB61AuHkJnLg6YRQxnS4+vdCojaeYNk0CZhOZpdvbRIH29SA6?=
 =?us-ascii?Q?su87YFSvHOo6HWfMXWYZ6tqFzfsj61NM528OknY+eg2qK9mTuTknLG7e3CnT?=
 =?us-ascii?Q?VHim0pzzaGdSYlLZk1MuacjmZb72HHogEgpZtHPJ+IDq4E2EcnZHP5BvMTvx?=
 =?us-ascii?Q?2tND7XHXA9qXfD7tMA9VFjlLwpkEljVvK2yaEJOGNF1loa4NoBsgCW7Rj7hn?=
 =?us-ascii?Q?DPmu+VKniSqhAmKpkbAIb9TS11LHkZcF6PNC0DXV5Ys78wT6TRbOdprEh6Ix?=
 =?us-ascii?Q?nWANSbIjdvSLn2Uao8KYPVxbG4Mdx4zx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FweNi8xahZ5l5os88dHRFisTLm63E2LGaECKCLZAr+0X11ijeAZ063FHK8AR?=
 =?us-ascii?Q?cqNRI1jFvm7JMtANahQ16sgTt8JWShyYQuX/YF0MY/oGPhijdIzU6iogSekY?=
 =?us-ascii?Q?HsBOg2Y/IgrDEWCsSMTDMrgeY6c1fAQ9hrgo7XZImJ4ILnlS8Yv9GzMps882?=
 =?us-ascii?Q?YP/Jef8a6axhLTF6xxuL6cwyfWBtaX+FoPKiJNZzYcNroH6HWM46h1+968Gj?=
 =?us-ascii?Q?xHdvuZABduj8zHQE3KVWTm3CMGCybmeOwOD91gJtqfWhQAKW7HX2AXeUyuRF?=
 =?us-ascii?Q?FxTn6M+nAKu5xpBYNvGl1JQgP6HrFFQZD36UVh1rkMk8a3SsBzOamPMD00CU?=
 =?us-ascii?Q?2LYUeB49igomdlgvLtlv4/Pp/mAEpSAzeVw/oxkmRGz5YSDW5R+daXMw9YCm?=
 =?us-ascii?Q?iHLyCqdF1NxbwmmBkmP3QR1XDDAUN8TFeJQUgYVyKSH062oxy5lKEK6/3qLs?=
 =?us-ascii?Q?p+r88eIkXJNZk2icntJtbGyt9cYHz7NJ56vOIwt5HfJDJjvM9Ed9PoYr/Yhm?=
 =?us-ascii?Q?rDikVuJKIamXF3Kcr/7/1+X6sEQ8EB6M6h7jaM4SxIsuRkQvaUG1znSpSuzS?=
 =?us-ascii?Q?2VVJTbqMV8yjjr24ppL9gkw5J00zxMNMsMaGbOD5xs9Ue7meuJ6mIO4qrVbf?=
 =?us-ascii?Q?uifOPWH8cdrWF5OYMU8G4EGk0i7xpHiMU8xIIkHTFtOVnnNa2ozw2CbTVLNf?=
 =?us-ascii?Q?e8L2UV1YMA1LNSD11m0BrUdjSr4/0tPQjoraev9Qk6cCj89tZE5uK3NTFwby?=
 =?us-ascii?Q?v8d0jPmxlWy5oqfuEfjFxcudITlaubtka/M8+V/GGvi6bnwEQKhlvYgxXpQh?=
 =?us-ascii?Q?6VPo2jrJQAk8BjMMqbenbOhkGEPM6SN4WvW9/wBzAGANT+zAbMUBBKcCj8bX?=
 =?us-ascii?Q?c3Amu62l8VbhLeMx9Xrg5+ftcsGkCzkP8dDlGkQGSd6CaiIGLOHob6ogn6Ds?=
 =?us-ascii?Q?gbNtL8UoN4/dRNGTdAZraWFa7Lub9PNkW2TGKURT/0+MtQyu/BBJPYFNL2qz?=
 =?us-ascii?Q?aPDpbhpDs0+VPMUvoowhTOmk90AFBDDn8WJDQf6SeWHpaYw9DDUdTt0mrvJJ?=
 =?us-ascii?Q?0gnUGPvswSEclkrLUwSwTWfCiyQ6Rs2esKv7KuWZ7EhqcZpmhjGpWVYwvQbz?=
 =?us-ascii?Q?n009L1SIxLI5FT8Zl5EGs9YeleICUOGoWGs2B6+QGjGI1GDg33ryDxOyJ1Kk?=
 =?us-ascii?Q?9k7GthPXM6WChR7aPjnD4+mppL2sr68hpGURP8wG000bsXNj4Telw2WkPhjY?=
 =?us-ascii?Q?9TcBmB2J6/MECwuSQY0DcBhseJJH51kCBX3XNLY+swEePEi0S/Rk8znvG9cK?=
 =?us-ascii?Q?YsntkwcrvSJyvWddINJ1MInpJ1TlXIZyE81dWlLPnAF9ObtD+TFnNlJ/Q8xB?=
 =?us-ascii?Q?yh4Y3ydJqcjEZToGAYx6np4xz6RQ1Lu9px9PlmI3zlbW2QqZDl3MVX0l7D1r?=
 =?us-ascii?Q?rl2AkEaRdoRi6HeN+utg/xLMyGWHb0DA55NSk3IEKxnRusOzoiFRxoWBTFu4?=
 =?us-ascii?Q?T9KZzMiwk0RAwhV/7Gv4iiiPkqOz5A01rj6EB0y8oueCcL7Z3Qwo/sioyr5S?=
 =?us-ascii?Q?vmk+C0PxsivPuqIZ7DBIZokQbfZaarStooYL52dc2rIgpvC4kyH6Vk0dfFQ/?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Tlz1uTFVL679MrsCqc9MdVrXiv9LCwBhj6YWaUCtNlUaXHsYsFU4RiNC4e1pa3xetAtXY1Eoqc9/ZoPhr3jUxmWHX1G28qO6ivyaJg6hORn930JqkKGlszNJPu39eEfcCIFVYGgyEk+rPUmMCPxwkKIzs+YX6h+v6GAc2K3O+j6IPWTFet5M1wYpvrkl31VLgnXd+jaU3MdDxEs5VaKniVIbDBjA2Lk3YJZU3cxY4Dq/uWnRj0lbRVacffk1KOEi5BtmiK6y0ATiRxsa7qxnJXej1I/LmSzDHUIbLuXoRXVB6pp1TknC4enVmw3lSAx4uqLMJZnm+9f+9HeDFQZ7wwwY77EH4Bz9iUN6+M1fg4ogO4c7Q6B6HrObxkoXqdUV6mj1OJOTWrHwxkFxvI+yz+uTfbAVbVbnnAB+Nx4GkB53jrHnLzXNHz8qoi6Bwh9BvZObP4Pj6/aVLo1FVjI8LDgXFIIWLtKa0vuuL9IW5qoTHRfMHDCpZhXo2AnN0E+0HG3deCguOjX0AulW5MQepy5mQ8WSmIGQiuDSmqm8/M7tYb2dw8Lyoo7GE+UwJiZtxyjtgKt8LdAgwMnyFhLZj0o5SaqMDxYs4L6sae2Uco0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722b8faf-0296-4e41-2851-08de20796142
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 16:51:22.8646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5thBxhOSrKWFf86USTI0OjDjrvfKA5YFIXor6xyKllZz6tcw11ZyVjhKUDfp3ZEEz09S0Xo2tcNeZgDUqG1o6tCA6us98PpblbLaxxG9R8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100142
X-Proofpoint-ORIG-GUID: pc9Rp4dOhY6NR32AONk_JK4nCPGE6Lv4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEzMiBTYWx0ZWRfX8BsvOf0wgjBR
 eQTq86QW+TPWH1bG8hb0zKK7oX5mZMEMAOlJwUPhIPpqfrmE5AjpHh8U9XgrpDZB5s959zC2bDI
 32Y+9CV2/2nrr4LjVQMfoYvxSJcYpGTImgjwHbjAhbpi6GoZ+vPmtDHesNNLFJ5orXZRu8+gd+C
 n5YNS3wgDHchknj7t+K9/2N1DJkuFWTVYmQ3y72e0HGnTGgheBEqkhEOXPsj8s7NKJG4JIjpRp0
 r4mTeLQIxjXq0O0hXlZZqdeKacwkENzu4FIZTfvhPoXtAOsl6jQzUNCcqWL6CAXeZxBUorGmmi+
 r6aHhdMedZqNx5GZmrzU6CywaT06t/nYl7fHCixeDRCwgc8l+DlbIPZUzaGTAANeFDVe/QC2FNA
 0PJ/KtzvcblqLo0lA9ojloup+uZ9Pg==
X-Authority-Analysis: v=2.4 cv=YIeSCBGx c=1 sm=1 tr=0 ts=69121811 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uB7gw6k2XpxfU_6_OJMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: pc9Rp4dOhY6NR32AONk_JK4nCPGE6Lv4

+re-cc various - email is a pain!

On Mon, Nov 10, 2025 at 08:35:12AM -0800, Dave Hansen wrote:
> On 11/10/25 02:48, Lorenzo Stoakes wrote:
> ...
> > It also seems slightly odd to produce this in advance of the maintainer's
> > summit, as I felt there was some agreement that the topic should be discussed
> > there?
>
> The TAB discussions have been ongoing and this document was mostly put
> together before the ksummit thread even launched off. This patch just
> suffered from being put on the back burner.

Ah that's useful context!

I mean I (obviously) feel this document is very necessary/useful so it's
nice that this was already an ongoing thing and we're all aligned anyway.

>
> > I think stating that we will NOT accept series that are generated without
> > understanding would be very beneficial in all respects, rather than leaving
> > it somehow implied.
>
> I actually don't think that's a tooling-specific requirement.
>
> If you're posting a series, you should understand it. I've seen quite a
> few cases where folks will pick up someone else's work, forward port it,
> and post it again without a clear understanding of the series.
>
> "Understand and be able to defend what you contribute" is certainly a
> good rule. It's also concise enough to have this document touch in it.
>
> Would that suffice?

That's great thanks. And yes absolutely it applies to everything, but
obviously LLMs are a realm where a person's capacity to exceed their
understanding is amplified.

>
> >> +Guidelines
> >> +==========
> >> +
> >> +First, read the Developer's Certificate of Origin:
> >> +Documentation/process/submitting-patches.rst . Its rules are simple
> >> +and have been in place for a long time. They have covered many
> >> +tool-generated contributions.
> >> +
> >> +Second, when making a contribution, be transparent about the origin of
> >> +content in cover letters and changelogs. You can be more transparent
> >> +by adding information like this:
> >> +
> >> + - What tools were used?
> >> + - The input to the tools you used, like the coccinelle source script.
> >
> > Not sure repeatedly using coccinelle as an example is helpful, as
> > coccinelle is far less of an issue than LLM tooling, perhaps for the
> > avoidance of doubt, expand this to include references to that?
> >
> >> + - If code was largely generated from a single or short set of
> >> +   prompts, include those prompts in the commit log. For longer
> >> +   sessions, include a summary of the prompts and the nature of
> >> +   resulting assistance.
> >
> > Maybe worth saying send it in a cover letter if a series, but perhaps
> > pedantic.
>
> Do we have a good short term that means "commit logs or cover letter"?
> "Changelogs" maybe? But, yeah, we don't want people reading this and
> avoiding putting stuff in cover letters.

Yeah it's maybe not worth specifying to be honest, it might just add
confusion.

>
> >> + - Which portions of the content were affected by that tool?
> >> +
> >> +As with all contributions, individual maintainers have discretion to
> >> +choose how they handle the contribution. For example, they might:
> >> +
> >> + - Treat it just like any other contribution
> >> + - Reject it outright
> >> + - Review the contribution with extra scrutiny
> >> + - Suggest a better prompt instead of suggesting specific code changes
> >> + - Ask for some other special steps, like asking the contributor to
> >> +   elaborate on how the tool or model was trained
> >> + - Ask the submitter to explain in more detail about the contribution
> >> +   so that the maintainer can feel comfortable that the submitter fully
> >> +   understands how the code works.
> >
> > OK I wrote something suggesting you add this and you already have :) that's
> > great. Let me go delete that request :)
> >
> > However I'm not sure the 'as with all contributions' is right though - as a
> > maintainer in mm I don't actually feel that we can reject outright without
> > having to give significant explanation as to why.
> >
> > And I think that's often the case - people (rightly) dislike blanket NAKs
> > and it's a terrible practice, which often (also rightly) gets pushback from
> > co-maintainers or others in the community.
> >
> > So I think perhaps it'd also be useful to very explicitly say that
> > maintainers may say no summarily in instances where the review load would
> > simply be too much to handle large clearly-AI-generated and
> > clearly-unfiltered series.
> >
> > Another point to raise perhaps is that - even in the cases where the
> > submitter is carefully reviewing generated output - that submitters must be
> > reasonable in terms of the volume they submit. This is perhaps hand wavey
> > but mentioning it would be great not least for the ability for maintainers
> > to point at the doc and reference it.
>
> How about we expand this bullet a bit?
>
> - Review the contribution with extra scrutiny
>
> to
>
> - Treat the contribution specially like reviewing with extra scrutiny,
>   or at a lower priority than human-generated content.
>
> That's a good match for the "Treat it just like any other contribution"
> bullet. Maintainers can either treat it normally _or_ specially.

That sounds good.

I do still think an explicit point about volume is important though, at
least to underline it.

Something like:

	Please be wary of the volume of submitted patches - sending an
	unreasonable number of generated patches is more likely to result
	in maintainers rejecting them or deprioritising review.

Perhaps?

>
> >> diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
> >> index aa12f26601949..e1a8a31389f53 100644
> >> --- a/Documentation/process/index.rst
> >> +++ b/Documentation/process/index.rst
> >> @@ -68,6 +68,7 @@ beyond).
> >>     stable-kernel-rules
> >>     management-style
> >>     researcher-guidelines
> >> +   generated-content
> >>
> >>  Dealing with bugs
> >>  -----------------
> >
> > I guess this is a WIP?

Cheers, Lorenzo

