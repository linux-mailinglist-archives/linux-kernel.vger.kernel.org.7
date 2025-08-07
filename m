Return-Path: <linux-kernel+bounces-759182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2ECB1D9C2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCFD72329F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AD3263F34;
	Thu,  7 Aug 2025 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CLtq1aI+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OBM2pK7u"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A634263C7F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754576108; cv=fail; b=GLmrrxm0uB0WXm08q3I/sJct32LY/0StDEMQkvnF6gPJWWK8IccTvwj1xy0A8Ag0IRibOQIduMhyvQJhzIgjwp2nop19Jn3D2B/YFeWSQlP9BMvKWkSA9fMw29vliImxtgx6ebRoNDLSeds7JQTvEpuhxRSiAaoiK/t2g+AH/gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754576108; c=relaxed/simple;
	bh=79swz4kgc/gFIlRg+4LPH/KGHfQFmADg01mEhb6+mps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PhbYp8tn/Mnz+NdJgvh9vLtbxhDVr7jXiIBSA/J06PdhXrSDRSv5AH437dh+BH9k94fmRxDYXJ5Or9xWnoSbmwe0zfcBESBBKALnhy8byXrmmh0II/eR3nOdVDw8PW8+McfkcmMz+RZY1dvh4esQf4YtJhPjamB4s4VyuvCjlrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CLtq1aI+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OBM2pK7u; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5777NVEK009715;
	Thu, 7 Aug 2025 14:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=y9tsU9s68G+CzdhHtd
	tdA6dRfVeVVGosg8Z9yLDf3zk=; b=CLtq1aI+BIc9YuQLvBxNn6zvZL/dz40+W3
	fWUmHbIw7FkZvVDNEp2NQveM7io9bPHGOYbgEN0WaNWbqD4P9yqjFKLlhC6XL0eR
	uQ//rhrrT5cOg0E6N2g7Ryp9qwtyoIZVPkJWdKRbqxCiWeSPFrj227Y1q6yepQjT
	LERtCTSHe3HF1a6z1vb9ExLGB/EcX2vI0EF79lM4Vzb+kTKLwx45nKSNQMmdA/CC
	oIXUAUVf/R62A/z0k+uRoqOMHtEc60ckZM6MsGBKk2lzMBE6+VPjup5Q04zZRBlL
	YSsZA3zAmXeKXpxNCwU3EPpyKzKRa5uMp8vBKjq2xy7sJdg39U7g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvf46hu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 14:14:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 577E0Y7q005682;
	Thu, 7 Aug 2025 14:14:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwygpap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 14:14:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhEyzccaxNUaGvMEQ/tTdVZXxMgBsbTSlb25rZDUSYe9WuFp+lbkuNkoSH7/e7WfGdZtGrI2JP296Ts0mkpwbMLhZL8Hs2slCrZGg7X3GFV/CqecNa0csnlds8HRH4Tk14P+YoWxz3DR2eMdX/U4I55+/fzqIzdBv5cSWFQ7wIgkdnUO5/s2C9sU2CFoIAv3sIp4rAvDH7Z9TBPDfmj49S7pncsciWJKmSBFkDviDGiY7keWy9hq2LK55jhazfkpz6C4GjY2FVw4PZJdzjnpvRChFBmnSt6xBwbcWEJfLMsHvI6+tsNDmnQiikapset93zgUM16S1Jh8fMfXPW9V0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9tsU9s68G+CzdhHtdtdA6dRfVeVVGosg8Z9yLDf3zk=;
 b=Vs6rvZslgpumA8GqrD7hVnNuZb91LV4mjs2WhSJ6sE/gkdMQWj21V+C1/FcjrqpbuvRKqJ4W99czse4kUFXo8FudjOhzi9wmTgsqtGU0SbAaXB7GZOjnOGZAlInrXUnuGIRLLQIMinmKA1mfslEcHsaOtmJt5cJodejWfKEufayQKV2Q4k403AdmUXqQm/RWH164FgITEEMMPeM+gfBruSx2kw8WuOtt1I6d9SR+yjd2rXjZBVu/oy80N+arzATcQULmpn3IvAvuEXkwVHW4A4bAGbpeEantcem9vEeMuPJjCIshXIxnE60wpc3g6grlmVRB/x2mcXNtGG4aikGnzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9tsU9s68G+CzdhHtdtdA6dRfVeVVGosg8Z9yLDf3zk=;
 b=OBM2pK7ugToOOZoVEUMHbUJwXLFsL7iWqDoSSI80mgHrJhuqL3eqf6smolHx0pt2jstWFzwTVsm73WgKuNq2AOaurNLqlQruQjDJwgt0H4tHdwzBUfjeH9iDcO7CgqCfXOGVt/CVzjuOnHJXkDcC+kX/9Qulma1xRJs7p5sPJfo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6230.namprd10.prod.outlook.com (2603:10b6:8:8d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.14; Thu, 7 Aug 2025 14:14:43 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 14:14:43 +0000
Date: Thu, 7 Aug 2025 15:14:41 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kees Cook <kees@kernel.org>
Subject: Re: [patch 2/6] perf/core: Split out mlock limit handling
Message-ID: <25957ac5-e52f-493d-bc32-395a759a41e2@lucifer.local>
References: <20250806195624.880096284@linutronix.de>
 <20250806200617.323157553@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806200617.323157553@linutronix.de>
X-ClientProxiedBy: LO4P265CA0326.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: a895fbf3-7f46-4899-086f-08ddd5bcc19f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wXcaupbJyStc6MIcLr+FjCcSBCWow+fnQaWu7FL4mgXnKaorOTbtEOl41Dx+?=
 =?us-ascii?Q?AmOgugu0NFFwNTWgRZ4zOCQ5Sj/7qeo+zuIZqwL+SUN0jrWy42pWTfd2lTTW?=
 =?us-ascii?Q?ngA5bdTy2kzbOAMQFoFmtvaGvaEXoeRgJZlFAKhRpS1zspU6ke0yrK8tiCdR?=
 =?us-ascii?Q?mCUZHv4vt+fhhPLGvgwcKx9+hOCgHFnc7yoihCXUb4ydh/Vwy6R+nvr7RvMR?=
 =?us-ascii?Q?4hwS1qp+/pBZumJpXsqOzDgeKI3KQUYORIJ+gppDIEXxke4ekj9qUSuAuxJz?=
 =?us-ascii?Q?XjkOnkLaCbgdyFWOOisUxw48sJ4QcXjZQ3sUW25bUDNs9muDKvihdJ+/3Oss?=
 =?us-ascii?Q?vJkaOFYVQs7UNQPKw0jnUqnLm0iwu/xd+XpE7wyMox5+8JcprXf+mhFHkVi3?=
 =?us-ascii?Q?uLEbRmIZ5f3wynEJDUpW4T5gW/64F5HTWcRTifoN0pwSmDThfvWFVKXeaBaZ?=
 =?us-ascii?Q?nuvysWaSSlJsBcZbeu0CTZzw6YJ2ji1bUjEjaTV6YvCGqlAwc97LsPVf4Qjx?=
 =?us-ascii?Q?FqOnYHTU7ODuIcvBS295pjzlML681o+IU8PrXJUUZBIIpfwFIfCDh1MOPHLN?=
 =?us-ascii?Q?kHJK6+8iwXb5Iwi/W6PdoaR8V1XwHmRbQx6zLhPInTlx8JLmWE5yGNqPrmqw?=
 =?us-ascii?Q?/as9bVaJzyfNkV25OAqDxhTXfmfVC57AQ7HwQaSG7A1sy8ObJP6gsu9IVHTj?=
 =?us-ascii?Q?iwLtSM0GegUH0uaQciNxuVtEe9o1gyVd4BNk4O1LJTXoAAMxJLtaz/sraTFv?=
 =?us-ascii?Q?I/JW16RHJRtvgh5lV7EoYun2SyWVGcjvVfMPGBTvUBAYWp848PzTiTUDD3dG?=
 =?us-ascii?Q?UUwsPXDDR5MoJLbZIhchEM006PtLKFBnsq23HaDzHRA3OZv3KY8IeIZVoJoP?=
 =?us-ascii?Q?DTezqj3pw9Y2wBIh6psbkxq99htExExxyrvXaxEsjledEvjkPqrOrdtwW+6e?=
 =?us-ascii?Q?F8R2yadlfA17tikWgbl7ADOnAKZKCAFu4hsvcEg7MLfja7/k9q0WavBUEV9C?=
 =?us-ascii?Q?Hjf2lVtV5XDd7qHHT2HiOTk3DQgf/Q/b5T1urxu8MYhiAx+1OEyTwFlqvg/D?=
 =?us-ascii?Q?Vvei3YeCB8Vu/TuTm7eDgkOoTM2jX1n8ZRBG+VmGJn6weYxtBDKpKnmMhBDW?=
 =?us-ascii?Q?StmF7L7puHIqsANug15DHCNWHJ/iph3D1CxEHyul7yzo2iwY5CQj2o9pL9eM?=
 =?us-ascii?Q?7ZnP1UFXM0t9+GoOj7ev3SdL8+Rf3C89NCtV5DNNTR2g53vXXnJ3IDgRZcMQ?=
 =?us-ascii?Q?sX/9vArRl9+WafvTQkd2P/k53mLGEwWHdaB6qqk6aiEv7bDp+me/EgViLRlA?=
 =?us-ascii?Q?m+oNAQSBebTmtdq5yYKgGQPVB3PJZyzwN6jYXhaxODK/njuX+RsfWSHusCv/?=
 =?us-ascii?Q?UYGMtRwKnP7NEMOTIGeQa7wqHsmrbQt18n6qsseBqmOANqpoHJ/MfBJUoHd6?=
 =?us-ascii?Q?q93KBs2HYxQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i8aoamW61uDQrem+GhSMOrWS+GXQ5DBScf1gTaOg7wz93njdRtBGPwWcnibb?=
 =?us-ascii?Q?Y6IzfgjjgdkReIZmYharCuYUq2y44V+4e90kZEZqJh/P3DD7pAZ3GqUzN/p3?=
 =?us-ascii?Q?ogcj5gykM8jz0BmYiobSDEXcoCg1QqKw+PrpXGW/0LgMzbzyxfMdEzC31KIf?=
 =?us-ascii?Q?1SC88suhYzm3PFx2QR5n6Nk0kV5/NHg4ir+B/SKRw92A0DJjEjb2DE+a5lNm?=
 =?us-ascii?Q?uUrtBEe87RU7BqYEqobirYcO1+18VaeacW3UOSduY9QWgTegwp9bc1MGJWVU?=
 =?us-ascii?Q?T52Pjdtwre1KNS9UHbNI23m3hD3hhRIl+RITVqnLYKjZoF1P0i63J9WDWMNu?=
 =?us-ascii?Q?81xeheK8SvsWxlVxnBC6Z0K6v0hiEQleq1xCQLG7/75PmyGYAKOGMJwxCgvv?=
 =?us-ascii?Q?7Ku8YocICOy84BTwUu74vAXx2bM8N/DofarX0jIRohsQQJhsV2tEfyrxab/3?=
 =?us-ascii?Q?2XhV04fyfeokt3P1+2I1Rq+9UNSkntpUtG48KHrwM7YNIMSlp8PyC1Jf68YU?=
 =?us-ascii?Q?2Ax6jGbWkF/Pgajp01TO45cClK7UYX4VMrNCWaiiqaNJQnPZZK63pNyay4rJ?=
 =?us-ascii?Q?6yk27P3ngN0So0oGjJGniySxGQwqMkeo7pqY3InVvbQKlVSusN8joklBWGWi?=
 =?us-ascii?Q?d0sMlUw7mboS6SDfB26cF/0eCsMQ7/j3No85Y5VX9fpkEQZCoBr4ODyghFa/?=
 =?us-ascii?Q?fUxyLAoyR2V1c3vm/F5Lq06grsUJOJIxzdW1qRW107liKXq1dVd9q2aJoEj9?=
 =?us-ascii?Q?AbFIiK7wF0iA/P1ocrbFzEH0I5ay870m55xpY4EgQwKSgJTJu6zs8b8mqUyV?=
 =?us-ascii?Q?33wJHcKGLQx5z5LKmNID6ecptX9byFkLDjUYZKI0HU19YOfCsixw/EGmtGJE?=
 =?us-ascii?Q?NNUYTYNdK52s8QPIp3GnlVB0RG9McnWI5a73AOqSFxzYtSCCYuZUe7Cj+Zex?=
 =?us-ascii?Q?lEID1Qw80BNRH2PoSS2seOzMdcLtfKMhDg7kOsyowxUvkRtxC0KRNvdEW6zM?=
 =?us-ascii?Q?rO9GXZCHXAq1xEY2i3u9lE6/YebV28Qqns5X+GqZfnOWwE/G915Pzv9ie5bw?=
 =?us-ascii?Q?QFuWl3ORaMcpBN1C9m+no6dqwVaDyFNbZk5ifDfU9ms8hcnP7hxhd7Ctc3BW?=
 =?us-ascii?Q?l2RoDzuahaogiRFOKZnAkKq2komKwho1Z1oVmkgzgfYwh2In6Ct5mY7PRNIl?=
 =?us-ascii?Q?JAaIIxJdMitnCA99CfPfpRJEFBCu1kYTTvS+pjDuzXJs/Rlrc2epPKn7dRxL?=
 =?us-ascii?Q?/Jll2z1DuoPsA0+YrhIVeDXx5QHH0j3bYjjxg2/tUXcwnmf1nXFt4dUvcQfP?=
 =?us-ascii?Q?evwBLVne25/jsyfNhWoJHcvmLTrJNf/MUWyfFDh2/olHrFvxwEYrDf9pkPNC?=
 =?us-ascii?Q?koRoWlGUPhHC7KDLDb/Sczj5YD4uzfe2UzKRSjfevwg4D7EDhSu3LaGKlXZm?=
 =?us-ascii?Q?A9mhhch+F8w/MLjOY9pOiTN0Nr2dHG3XBEU1ogBip2bBwid/E0DOxh9wBshj?=
 =?us-ascii?Q?Znaex+LDoYcoumWkh+gFaPsc9aVGSNDZYq3l7CwcPmDgIjcXAD92vzeZ5IqE?=
 =?us-ascii?Q?6w77DVn8HBmQUdoPIp1nj5QiV9ZHR2B/P7cYNjJYj2i4PMiRSSufcRwZfrMb?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y9nCPKIMfsfWHvDwMFZifgLlfvJzVvexFKqd9hKDjGAvDIEFxe2Dq/4rssSe92ooVfTlJWEDXzrYjHDhZ82gwV/dXQ8JygVMSjlVVIY9dB6EqA3jX3xo912XBB2TkLeWyD4MIixH8jmRLPurdSLy2JxBc34tNIYYB5GslgBC3DG+WvjX3UrOjJBt0oOEcxGSo3bqX6pueVaJ18mF2OQShLCpzrcea9c8fQmvxrRUIUSZ6Kkz8UJWm1eMelBcm0Apab3anRAikh7bwwshD0GnHiWgaJ1rF8FO2nQ5EcKTojaxPtlIojvIrZiP1/muYo5KhsZ9jkq0z3rmIXiu0QC1y8dX8ynbyxtlmq6HdaWa3pk17Vl1+tk+rdyQu5O1LGXA/8+L+IGIHtyoB4HOBrvblqlkEtscAMLBgW7wa7JQakyaSGJIsJ2fkW77QIHmVovOHdhiyF7+vs/iniNky8xTq19xzKQXgiX5Qgc8xYfgmYb3qGe5Zvq6R/z/8pIfW+GuxreZ3kMPmNwCDjqCn+IePDaxt7J4hU8jS/Yi+Su1GrYyKJ6U3lrEd3J2BAbjJD2AzOtqpTqqzN78duBwuwtEA12qWVDuxTfBCQR7d3xrV7Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a895fbf3-7f46-4899-086f-08ddd5bcc19f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 14:14:43.6138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+qMMHu5ptBGKyRDM80JUOrflgboFnAfmE92ssQsTFiL7o1Jn5MnMvTcsmkM3X55G2UfUL9uE3acrv/Gw9C88gpTqsH29y+zR3YRqirEb0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508070115
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDExNSBTYWx0ZWRfX9KfV9Mu/eD4k
 NxdUIzW9oDOOyC988f0SUYEOpcMOhMMx8r8l5kUyah8KpSgCqkLIo04EXFKBKwN9XFHlUuFiMRb
 VFHP6yT5/ecz/1LQbXgzcHyCiFaGXUZLs0EVrg1eQjTZvu38GeZmYJjbzsA0v3FKD6706o7NZmY
 ft0xrjsR0Q92boCVa7nZHCTsl7BS1WqtqQATJcl2/hDuSqEWjmnWJGiUV2RHovYCGit9IUQtE2N
 rEtnxYA1vfDtaAhD9p279g0iCvGOR//5vdbGkv01ICsqmDSChH/l0ox8ppWcKLxHFCAcFVKuvjS
 vR2W2Nuw9koVtwpbveE1Ccxv99KtrOO43OD8hseR1PNinrBqyMTzR9IARstQRCIBvopQMAt3Jbe
 oackRSXCmHLMCReA7SmwSJ3jAr6Aldxke/KcqzsWZ7OxAoaIjQ1n8JDmVivYOLRYSvGR1B/a
X-Authority-Analysis: v=2.4 cv=RtTFLDmK c=1 sm=1 tr=0 ts=6894b4d8 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=NaCgsDVjFS3P7sG25WAA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12069
X-Proofpoint-ORIG-GUID: oeP-eZD2AOtHLDNBVwf_FTQq55ppP0SD
X-Proofpoint-GUID: oeP-eZD2AOtHLDNBVwf_FTQq55ppP0SD

On Wed, Aug 06, 2025 at 10:12:55PM +0200, Thomas Gleixner wrote:
> To prepare for splitting the buffer allocation out into seperate functions
> for the ring buffer and the AUX buffer, split out mlock limit handling into
> a helper function, which can be called from both.
>
> No functional change intended.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  kernel/events/core.c |   75 +++++++++++++++++++++++++--------------------------
>  1 file changed, 38 insertions(+), 37 deletions(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6927,17 +6927,49 @@ static int map_range(struct perf_buffer
>  	return err;
>  }
>
> +static bool perf_mmap_calc_limits(struct vm_area_struct *vma, long *user_extra, long *extra)
> +{
> +	unsigned long user_locked, user_lock_limit, locked, lock_limit;
> +	struct user_struct *user = current_user();
> +
> +	user_lock_limit = sysctl_perf_event_mlock >> (PAGE_SHIFT - 10);
> +	/* Increase the limit linearly with more CPUs */
> +	user_lock_limit *= num_online_cpus();
> +
> +	user_locked = atomic_long_read(&user->locked_vm);
> +
> +	/*
> +	 * sysctl_perf_event_mlock may have changed, so that
> +	 *     user->locked_vm > user_lock_limit
> +	 */
> +	if (user_locked > user_lock_limit)
> +		user_locked = user_lock_limit;
> +	user_locked += *user_extra;
> +
> +	if (user_locked > user_lock_limit) {
> +		/*
> +		 * charge locked_vm until it hits user_lock_limit;
> +		 * charge the rest from pinned_vm
> +		 */
> +		*extra = user_locked - user_lock_limit;
> +		*user_extra -= *extra;
> +	}
> +
> +	lock_limit = rlimit(RLIMIT_MEMLOCK);
> +	lock_limit >>= PAGE_SHIFT;
> +	locked = atomic64_read(&vma->vm_mm->pinned_vm) + *extra;
> +
> +	return locked <= lock_limit || !perf_is_paranoid() || capable(CAP_IPC_LOCK);
> +}
> +
>  static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	struct perf_event *event = file->private_data;
> -	unsigned long user_locked, user_lock_limit;
>  	struct user_struct *user = current_user();
> +	unsigned long vma_size, nr_pages;
> +	long user_extra = 0, extra = 0;
>  	struct mutex *aux_mutex = NULL;
>  	struct perf_buffer *rb = NULL;
> -	unsigned long locked, lock_limit;
> -	unsigned long vma_size;
> -	unsigned long nr_pages;
> -	long user_extra = 0, extra = 0;
>  	int ret, flags = 0;
>  	mapped_f mapped;
>
> @@ -7063,38 +7095,7 @@ static int perf_mmap(struct file *file,
>  		}
>  	}
>
> -	user_lock_limit = sysctl_perf_event_mlock >> (PAGE_SHIFT - 10);
> -
> -	/*
> -	 * Increase the limit linearly with more CPUs:
> -	 */
> -	user_lock_limit *= num_online_cpus();
> -
> -	user_locked = atomic_long_read(&user->locked_vm);
> -
> -	/*
> -	 * sysctl_perf_event_mlock may have changed, so that
> -	 *     user->locked_vm > user_lock_limit
> -	 */
> -	if (user_locked > user_lock_limit)
> -		user_locked = user_lock_limit;
> -	user_locked += user_extra;
> -
> -	if (user_locked > user_lock_limit) {
> -		/*
> -		 * charge locked_vm until it hits user_lock_limit;
> -		 * charge the rest from pinned_vm
> -		 */
> -		extra = user_locked - user_lock_limit;
> -		user_extra -= extra;
> -	}
> -
> -	lock_limit = rlimit(RLIMIT_MEMLOCK);
> -	lock_limit >>= PAGE_SHIFT;
> -	locked = atomic64_read(&vma->vm_mm->pinned_vm) + extra;
> -
> -	if ((locked > lock_limit) && perf_is_paranoid() &&
> -		!capable(CAP_IPC_LOCK)) {
> +	if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
>  		ret = -EPERM;
>  		goto unlock;
>  	}
>

