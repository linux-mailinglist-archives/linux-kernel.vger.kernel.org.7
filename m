Return-Path: <linux-kernel+bounces-802788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C3BB45704
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDBF51C859F4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE2134A329;
	Fri,  5 Sep 2025 11:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="myiKuklS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Vp7G3ZDa"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928EE34A323
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073476; cv=fail; b=hREoaEYzLUcvcKRn2ThnUqT6lUzXFlrfwxrlBKatvR0kE12dbCDRSLnVAjEYwQPENnYYr95bDCAaAFQDyX2rRbhVuRANIR+FNv08fF8so1+fWnB4Y51OhFaFsySNRpqjmA6K8OlyO2IlnbrWSjQ5ZmBBQmHXCUi4fPRh8E2QsNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073476; c=relaxed/simple;
	bh=TR5OBFuT3m8ZJUU/smXWlzhDVjs8C74HBa/JCFiZsWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nydJfZDAEcvuYWtb+t/3Bo/EbTalw6O8NJWOrnv5CIj3ClQHJrGsPFc2DnfxPpg1zv/MD5HXcbV1POEDvFm3QFxSn2aQJ6phxwV+8dG0KWTxEAPk7DD7+mDYGLQp+MlZW6zT4hgYkRwybk9uxZIJER+0VAJmA8JWytqWoyRXU8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=myiKuklS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Vp7G3ZDa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585Br1Kv025191;
	Fri, 5 Sep 2025 11:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=OwxSxe5WszjlUWqrgU
	FBNRqehv2KBGgZcWUzcWZ/Ffg=; b=myiKuklSBp83e+/CrmvAC+ir39p2vJgqoz
	nbi5L+ikNXWY/dJveyTT9gUyF/+ilBzzG1KYaR452YHBk745Q8JzWKT1cqUxQojq
	ebV6Ku3qkCSMVsZahW514cuGQujGELx2E5oPo24qlByRViRlHh/37MVyQ1OpHVKN
	jq663zfkFWMWdsYvQQ8+JfGZEo60aLRw5QboGbRZhMOzQ5w5TFQnEeV+2WB7nWqP
	gzMOVZysSSoKBlkx2nqYT2FSWZuJGEsIWrYNnuDDcor6oN1I854TuCE3Nwz69kon
	3GWpJYxETkLa6jh34+Im6BbzLy62dwsAZZuWhRTrGE0+mbXvy+qQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yxa583f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:57:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 585BcQWP026313;
	Fri, 5 Sep 2025 11:57:09 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrcws7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:57:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doAs5OhaNN8r+w92VE6eqbc6m15f/c+d6CX8HPG9DZrRw2gCmDpgNRuzbImNdbM1F7D3mZILOCPLSfNwmDxIyIa280q84jCZTYQ7CJK0+bzbATbVkkPc/xVbGVZ9JSGF0SWXPqNcENIjMx3VdufNtal6eOuAb+RV62kJIxgYo4cJTTb+7ybA9wMOptKHci8guj9be6V98zFrTdilOBYTfBP8fxM9FuntYcJ48Jg8Ay9yoVTBS3IgTFxL8udrPC4lFM/3V+FlCaioeQ4cHZOLxrTFjH/IXeqZbNq0nBmLDnBAbMz3cSL1P6PPj9r/51r2GXH5UjWqy5KPYGgnIyz/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwxSxe5WszjlUWqrgUFBNRqehv2KBGgZcWUzcWZ/Ffg=;
 b=cTInNZqs3eqqkHcaO6RDqz/G2ugaUn/bvw4xKikMTKPzDjjwa+Lx5JCyyh/GU1QQ/zegJg8Vih3K6f/YRx2X8O8X/gWL7E6lUzn1twaSH3axW50hYegUfebGNJpXqCoAmywzHIyGrr1y1EV20ZW81xNZAtgycjUL+W7ib3aSFkNhjEjEiVv+djiJMUdg+ElzBba+8QsFKNrSjm89ZvOk3PGs0R+bpgmChgGXWf/qCGO2GiUiqNJOWtv3thIt5sVzVlXo1n2hKBJn1LkRzmlWghL36HfI74CyNO9MyVScpHsdLqOmH83/Busw4Mqc2ea8/xMtUjVClYJ2IuSfmmNyQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwxSxe5WszjlUWqrgUFBNRqehv2KBGgZcWUzcWZ/Ffg=;
 b=Vp7G3ZDaWGmyFq7h8mczagvlzgehkLZwMVO93FLsig0CGbiniiRjdiMOaHWkDCDRMES73s6GDGjTiQamRjtHFgXYwy58QSPiZnRDMdtmcWTj8VEc2MCcaR5kQr11flHO/Xo4X2eJb9MmdoZzdb6EKvtEnYbXefnvcIxsSWzTmxs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB7250.namprd10.prod.outlook.com (2603:10b6:8:e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 11:57:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 11:57:04 +0000
Date: Fri, 5 Sep 2025 12:57:02 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Zi Yan <ziy@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Barry Song <baohua@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
        mcgrof@kernel.org, gost.dev@samsung.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2] huge_memory: return -EINVAL in folio split functions
 when THP is disabled
Message-ID: <8b646492-7615-4b46-81ec-1a1601fa7e2f@lucifer.local>
References: <20250904095129.222316-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904095129.222316-1-kernel@pankajraghav.com>
X-ClientProxiedBy: LO2P265CA0291.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 78fcc9b2-9181-4a20-599a-08ddec7354c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PDabape9tsqN6/YJH20ZhB0YbewRgV8szzuDKXD7miuk8wx+bOlhzQx45tAB?=
 =?us-ascii?Q?GZNCrZ38HQaM9q1wq9BntsbwQccyv8DMQDNFDZGrhIx4dPRADyZBdjFx88LA?=
 =?us-ascii?Q?gGWkyZBEd2iUzKhaleJ4ypkAwasvZ6ULUhIWyLpmfZkmSCV+RSmOMgrB/Cl2?=
 =?us-ascii?Q?y9VDYno6Igz7aPwjyJxwEfwrdI7obPRGSWsDR6Enbqck1nlPsKTupiCo4XPK?=
 =?us-ascii?Q?vctXM0P7AhNLKMNBEdRNphVToQ8Cp+lLvYG1qKk+cIJUUgmL3eQLETLM9Cpa?=
 =?us-ascii?Q?A7+jqp7zxoHZMMqMuBEZkdtK+tlAXyunsWEWkoaS3UQ3pwhsGsryBKc2LO3M?=
 =?us-ascii?Q?Xr721F5Izogb2wFR7PlX3CGutt90UCMczc0GIe6d7l56zhQp6yEsIscRfZJO?=
 =?us-ascii?Q?ksnqJqo0k7EDMRO4NhTy06Nc0aVZuj+MxIh0o1dl+JdffWxnp2GF8dKjPB5W?=
 =?us-ascii?Q?41WZpdmG+o0+hRzitmb1N9XDixBou3qJS+3geNO2j/x2jngNB3YcH9l7dKAr?=
 =?us-ascii?Q?Q8qztAQIhpuSy0lLToeue7iGaY1YPs7f8wIyD+SnFI12umHgy1mf0SyuV10m?=
 =?us-ascii?Q?5BgbxLTqE4AGl/1b3LNzVFgXPQCYbHopEBdG5Tp8O2NEXzsxnkuHN2wGk39N?=
 =?us-ascii?Q?yqi/SRTb+c3aQye06dkLZX+Iy0f1vx0+G+EqME8K1hgv040YX4Em7fifa1DS?=
 =?us-ascii?Q?hNO36SHU4jdenwWKSW2+rdrKuucSQoP1v6ThuUua8Nv9qmum7ZgyXSMO37e1?=
 =?us-ascii?Q?pW42XyYOCzv3vx0MiKj/vbVhftOjDNVmeQDnyyQwMqIqTPSQ0xlOR5Rq6L1P?=
 =?us-ascii?Q?2WFdnwXEUt/HscKBdAc4e9zuj0aVK4n4fBw/L328m2juCnLekC6A/MSAdKF4?=
 =?us-ascii?Q?8YC8A537dnJ8a8YVPSJa23JindE4kB0JK07q9ajJc3DwhCdzPZl2RvuOv/YB?=
 =?us-ascii?Q?RfnGFEPbO7CyAWrtqBMusFYaW1MjgoMD7J9DLiK2Th0fGs8/JO7lQLqbqW9K?=
 =?us-ascii?Q?K9LNC1oQY35gCRy5LvWhXKBCmuso4yEdFrFzlwIMq1hTccGdfu/QcOWkumQr?=
 =?us-ascii?Q?QE8eCVIo+TumoQiglrdmHThNwikVxoeSMQyEL4evPI85K5Ejgp7pTGbkhz8/?=
 =?us-ascii?Q?KT7JjJWN2D++2ZbHO3CvdJgYDR13QFaS4gILeJNMnd0ySShsvQbnZ/+rhKRi?=
 =?us-ascii?Q?3Z1/PYBdCMylj2EGJngQRFPBJuJvbY1mDM6vqu9ICNKmfq/nxxWRCQKSrrTe?=
 =?us-ascii?Q?RiCfaZbw3WaS09Frbxw09oRwglvtMRQI+74DHGuSbD84zW9PBHLVTj5l2y/M?=
 =?us-ascii?Q?odm9r/VsEy5HVCw0XEV+DFvjtJA7VW7O0wQlstL2tUiT9jtImLlwM9mhSDxK?=
 =?us-ascii?Q?VRZSZD1xhsmpHGEjFDJZZ1xW47KOPkfwJdLmGnej8/vEy/UB5GWi+kXmpSdS?=
 =?us-ascii?Q?WQFKNPuufJo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?13tGzM8I2xBIHbQP+SvHbGqxmeHyVCvVVYw9/UI3MOOruXoKeBJwQHFodaFz?=
 =?us-ascii?Q?ZlO48ImCuOKfrUjMu8Bf9zyrSRPmJ8QtOsRfIXU9mJ5mRRnKDYzx47x1VzWf?=
 =?us-ascii?Q?TWfltJzsfeN55V6pBwh6eWCgk1gQ0jqpyWQ4xTMO9XrP1Rq01DRMkRVVF6zS?=
 =?us-ascii?Q?b09u1cN+BJKU4nSy8B3DVshwsr4HUzaHPdV0o7+cf+5tXi/0h2n0V46RKcnB?=
 =?us-ascii?Q?L9GaanDwlHIANyfHzBBvbTx6AjK18myelGn6FrZw0KDipHt40eRfEaWK1fJX?=
 =?us-ascii?Q?1TQWP4oRigqowF5Rci/DHGdvPGvaKfLpPO82CM8BzmffYmWC1Bo8v8o7OKcZ?=
 =?us-ascii?Q?FkvlKGsQ59Y/y2DH/3pilZ70TX0ofpJhsbPWhz5Y8aGq0KZWAX7bIU+U6IOe?=
 =?us-ascii?Q?fNTHVNQwA+UywZODfIYRWNHt7Qsftz34IQgrRF+Lj/uo7MmUEz8pjTMR20pi?=
 =?us-ascii?Q?TQaq5bHGJUQ+KsrccrpJ47EcCIVyNLmqFl2Sqb9wmLM+SqN8pJAz49MwiD60?=
 =?us-ascii?Q?stZxGH3Wqojv85FoxbvA05r8Xs5OQrkjcD4S3RUbM1wR4A5cmSDrxOhK1ktH?=
 =?us-ascii?Q?IjptTdrnGOabghvdh0GX1oFLZ6wLq1CWG4YdxbrJWXLJnUOgEhZJ+oe5ZBZe?=
 =?us-ascii?Q?HfHKF3t0HtsOF+2a6iThBAYqAxOckUn0ORqn6lAgp6HrQJknhZrF+JKVE/CI?=
 =?us-ascii?Q?Vx7mCry/DEPvJJWf0ywh35hCHdlCi+VVXhiZbeaNwLd/WrYcTAxyWwGGEpcb?=
 =?us-ascii?Q?KS8iNLYZ92UkNS7vUaHtbuUhmb0bEUnZHXY0F4lPkJWe5FJDfZeaIONIl7G9?=
 =?us-ascii?Q?63FFztV5ybAfluHjPOdenD5y4YXJ22VAbV4Gi4z1y7yqY7tUx1u0Hm7q/395?=
 =?us-ascii?Q?rmj3PBLCnX1bXe3t4nukdTQ7MqxAZW4xuKphj1+BeSZC+z9doftubxDEOUfr?=
 =?us-ascii?Q?rYPF8l/TrIM9nPz8rhEhrHd9p5+VXSTjLPe9EEh8ukwaBVLmPt28BdtaFx2J?=
 =?us-ascii?Q?Af9pbAfdBMYVIkTLGopNzoQiLgebqW5ARYP5ZPeMT2c//uaFMN9NW/SYfD8U?=
 =?us-ascii?Q?U9t3KAho5DUhurNfZMflWUsko9UvGlc+K0TQ59sM8jZEWs0K1bz6BVkpvQqc?=
 =?us-ascii?Q?P0LEqCRrCb2e1oa/xeWl1dDJA62ONX7T9kYz4z9MbtNhVvmNUwzW2aOt8QNd?=
 =?us-ascii?Q?WcKqLIWogUKx+DmMdrXMVIXeOitFQmMOI8bV6h4s4rZ9Z+5DOCoB+nDHHrcO?=
 =?us-ascii?Q?fAu3RyDtBFQJ/w0pRo8LgzbMmBNwH1yJIrfInBpGw5FhUH4lU4bxGxA4Qvmp?=
 =?us-ascii?Q?48SKaIAzDQB2sUnzyXfvz6Eq2K3TTs+06XR26t6XaKFQG4M7vVf3J8tTdF3Z?=
 =?us-ascii?Q?+s34wIDkMb10xLF62fOipjfoQctEhYcrzmcyMCwHWbhNLMx015EIwtr4Yc6V?=
 =?us-ascii?Q?Fdxwlz6MY8g/CJlGZqdTiBRmQ3UZm7j6eh8BzbtvdRLbDI/VL97JxK4qXMhK?=
 =?us-ascii?Q?vF6SBpWqIpaBoRyV9uait6RNrpe/esjZ/hRVOjBbyrQkCrzPgYd9dNk7ptVI?=
 =?us-ascii?Q?7B0Fub/oty7/LcbaVozOzPa9bFdqujm/SbvovVxC8jCaKuKz3v3ldSNCKxNS?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7zgdfIbKX84cCZK0sZGVRkQttZc/uqmqevFkg7MUH9qUmV0hUL4eD3q7gTZr3hbdkCXFi1irSC9rovFgIXQ4dhbUgDsyjgmaObwfMxKCmBohc7MUlzc0aoBjKmB4ERD21vJy60ygV/PsgkcG97aUXGrg8GoNO/BKE1/GIVDDFy3NotzUoaVggZaoI9k0iIRxsKxMSlxRkaGUt96+7JTYFW0MHwPQq/jRvQrQ5gS+pEpfx/nPy8HicKoGenP9H1KeGRDAP0YvZ86tS1qBT4ATlZ6i0fps+DpSpw5sXgTN9hLD+b4ysL3uxTP0e1m7fWAGk6WzVXIn5BwVsssdjuPU4V1Om3fhcFQ3UgDqpPmSp+bBpiUBJUmVdBqbi1fzw4zEQYK53ftG0A/fY109xopeEcjvTvP1uzcDE6IRDoBCc68eIrCwX+kixHE6g03XujFo3ZJUOOtcdDjKMvwo6TdPIwM1NorxV9bx2TRVePEtKgHen48ZV7DotDgxPTkgOaIjllyP8mzYbbecZqprcu7jrRydOpfYnFBcdvw6X4WDElSCQr/HstHh7PrCyeem/DkCgGIf+fY+RFOTjN2X/PSgWX9P4aoHtcMevfy9U22B6zA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fcc9b2-9181-4a20-599a-08ddec7354c4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 11:57:04.4602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlNVDCxm2pmOODRvauRYkNNpaE8lHctivoMA58qUbWum0itLMVbpg/jx3aQePIwqR3XPFijcU+jKrSHLO7Y1xXBMJInMgU+IEP+F5ojEfWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509050116
X-Authority-Analysis: v=2.4 cv=eJgTjGp1 c=1 sm=1 tr=0 ts=68bad016 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=hD80L64hAAAA:8 a=yPCof4ZbAAAA:8
 a=aInhr_P0kWKn36OxR0MA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13602
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDEwNCBTYWx0ZWRfX8LwbvsjrNsJL
 viz4ELE0kdQYS3qtidFLDD9QB65PFwt93TkYGIVOTMG00hvCe0I6WxaR7Lv+5c6WFstqf+Yegwn
 hE0qkxUeFhyOtV1wd3wCN71a8dhzS7I6SmqCqtT9z8kOlnInPJaxBSYcL5FWGZZb7jwOesXRCbN
 RUCJ9RySxqBiQzmGFr/W4RZqbByJ/VXo0D6bKnkAa0yu0IHcj2HPegCYcrExgtvIia4FskayPru
 X0ocJSevGXHwNiLx5KyJFxMNcEvyO1qd73KXSjUhJupd7ipPTuUogyqU+lZxUw6FWkvyKsoPZd9
 MgGYpYA6wajjT75m/cJcRwr5LHbXAvNEXvCDmiJyKkqHtvAizOc90ZqUqjNJ9wR9eoTwcfhL+Dh
 cudssfh+tSvt7s5rq1cJdfgE6mMzdg==
X-Proofpoint-ORIG-GUID: 1S6D3JsbuArIl-yEsQW-LRHRK1pRSm-5
X-Proofpoint-GUID: 1S6D3JsbuArIl-yEsQW-LRHRK1pRSm-5

On Thu, Sep 04, 2025 at 11:51:29AM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
>
> split_huge_page_to_list_[to_order](), split_huge_page() and
> try_folio_split() return 0 on success and error codes on failure.
>
> When THP is disabled, these functions return 0 indicating success even
> though an error code should be returned as it is not possible to split a
> folio when THP is disabled.
>
> Make all these functions return -EINVAL to indicate failure instead of
> 0. As large folios depend on CONFIG_THP, issue warning as this function
> should not be called without a large folio.
>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Other than the trivially-fixable issue mentioned below this LGTM so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

On basis of those being fixed.

> ---
> This issue was discovered while experimenting enabling large folios
> without THP and found that returning 0 in these functions is resulting in
> undefined behavior in truncate operations. This change fixes the issue.
>
>  include/linux/huge_mm.h | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 29ef70022da1..23f124493c47 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -588,22 +588,30 @@ static inline int
>  split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  		unsigned int new_order)
>  {
> -	return 0;
> +	struct folio *folio = page_folio(page);
> +
> +	VM_WARN_ON_ONCE_FOLIO(1, folio);

As per the bot report, you should just do page_folio(page) here or otherwise
when compiled out you'll get an unused var warning.

> +	return -EINVAL;
>  }
>  static inline int split_huge_page(struct page *page)
>  {
> -	return 0;
> +	struct folio *folio = page_folio(page);

Same as above!

> +
> +	VM_WARN_ON_ONCE_FOLIO(1, folio);
> +	return -EINVAL;
>  }
>
>  static inline int split_folio_to_list(struct folio *folio, struct list_head *list)
>  {
> -	return 0;
> +	VM_WARN_ON_ONCE_FOLIO(1, folio);
> +	return -EINVAL;
>  }
>
>  static inline int try_folio_split(struct folio *folio, struct page *page,
>  		struct list_head *list)
>  {
> -	return 0;
> +	VM_WARN_ON_ONCE_FOLIO(1, folio);
> +	return -EINVAL;
>  }
>
>  static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
>
> base-commit: 291634ccfd2820c09f6e8c4982c2dee8155d09ae
> --
> 2.50.1
>

