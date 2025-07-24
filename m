Return-Path: <linux-kernel+bounces-744588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C8EB10EDD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11A31D00CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2942E92BA;
	Thu, 24 Jul 2025 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JAI7tw94";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xp6pdf9I"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF32021D584
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371584; cv=fail; b=gXRl86izcokYfbRbep6by83P1dB5Uyudf9IdiIUhpn1Q1UlcA8Knzw7SJicmTiW21lLoOOoH6Lckfkbk623NP3nJs/GdmJTUNr7YclUKT1w2aJw11La4zZoDjbvn1HQcijN4qBF9IP7HjrofQsSZ3vmApUG+b7pMwxIV+WyN6nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371584; c=relaxed/simple;
	bh=t3jJZWSZP2MvWDb6A0+iWZ1dFx5oxdZLpSbFNgV19Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PC5CiGV7ZsInzVzF+YSeWOOUHnm7yHvK5wqVetBNejYWbLn7D14lsIFwWYV/DdyjXGLEZf3k5EBJTSlXcYrD8XSur90qE8Lwzy1oyTKEtHaw1NBHfg8jUiClStQl6Qb45KfsIILMt1r6kDeNAXuMudZuWmwOEv09t7nF8SdwJII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JAI7tw94; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xp6pdf9I reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ODRFM2025311;
	Thu, 24 Jul 2025 15:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Y8EMWgl9CZhEG8vgj2bcgT+W7mXwYfOLCdiq/TV1hXw=; b=
	JAI7tw94GE4h/eRHnax900n89eXx+LuXjxSA12+UhSBwQqkYF+cj/AUdc5E6VIyt
	3++xEkaMqArSzfD2KNJQw2IUVbnM/a0CnO4S5apelFYcoTk8PV5t1LSrNGqBWAFR
	8CNaOrTTsnsWpbc21qjoydkJ+S7yOe6Y4oP5vi3Yt+JIxHA8Kk7bM9rn67g6b874
	JkKR1YNMC0ra28OguW2ShEhMuYoIFlNfRTT9FFfl+xkQb77FiChEV8uMPX+t5ftj
	XBcn9ckTw482sigF6bS8pFnvxp6iirtNTz3xSAJPXDUke6IbsTXR7nsxHt9snurV
	bW7V2y9+96rfBZ+ewPz9dA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805gpswur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 15:39:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56OEjB9T014403;
	Thu, 24 Jul 2025 15:39:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjb35g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 15:39:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edUv1tO2vAqj/YG4134t40Et3atUyJIhYigCTVx7nKAYhzFXNPJk7sKKYjqkXowTStvVujKl1bV5B0gEWu34Ux9MJWOqQnDeRI3cSVBiFwGWov56P3thcu/r5FdaHVR/YnIX573Q6qqycTGY3j6ZJV5YP+XmyvComTfKljmaFl3XxrztPExzZueK7UuXfC49n18aeAQNPClB3opFrHF0yVQ9aNvyBdg9ZvzyP9a+Plue+K/p2egXOFevLjUJ9pvmkBqP2xveqI3cccVrNjdg5cFcUZ1UOyR6mRc2vje3PEAFdMoTscTEgFgpxVsAjAEE89foHU8Vnyp0UWPbBoHOvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9MNwiFr8qLM4WCKhgvGz9DU+1wfwcejLDYFNVO23qE=;
 b=BFQgG6VYoqFceD7ppKS3tZdY+yZjfSbEd19kd2sTo9FBgJWFnWlze1OEhU+6TZN0OVR3H1bsjgjjFXO/jmttMp94sbBGv8Grr71Q3Vlo8Z45Y91GSRX/bmEDLSR44NS2AH/qSWKvhZHeER7dP0OAhkcAxLHqmyi/ti/CLdhqB362hfTpkcs8GGG/xK+qW9f9xySkbu9PmPkL+3unWhaU36oUzVlU+I/p9/ZIGgAn+c7GKq3puhRuMP21fluRZRKQDVZ/lUTn5Hk+vcn2sP+nBvyIQbh4gxdW1MLOhi57MMqHHFHhxiwl8WXyG5TUoQm7xW/XCkLiv5UB3cnlSZEQww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9MNwiFr8qLM4WCKhgvGz9DU+1wfwcejLDYFNVO23qE=;
 b=xp6pdf9IbXZzuBqo8+GRhAT64UkNp0cfxW/kJ4znkMNZONEKz8ov8Q88szRq1aBLUu6wsMIi3Op9wl+n1kH+zQZ2+OaFXhGrUMFBvbsR9zR4wH5uYCoZzIpk2pNXaj0frb2geFxFRZx7wk4gIMcHqO6mpNr2aK2QgIXRu2wS+qw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB4865.namprd10.prod.outlook.com (2603:10b6:208:334::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 15:39:19 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 15:39:19 +0000
Date: Thu, 24 Jul 2025 16:39:16 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: remove io-mapping
Message-ID: <199a9d2c-9e50-4740-b29a-6ffe906e7d9d@lucifer.local>
References: <20250724145313.65920-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250724145313.65920-1-lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB4865:EE_
X-MS-Office365-Filtering-Correlation-Id: e973f6a5-819d-4754-dfc3-08ddcac84109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?tVEBqIdS8XqLoFqmex+ylhTtfTNeTtrPIvjfvHjYIRtOvOu/gfTOkt5+PG?=
 =?iso-8859-1?Q?KKF9inrd2FHHNkzZf7VnLoxTyF1Ogveszza2S1DVU2DHHsoR5Vf9WB9z7p?=
 =?iso-8859-1?Q?UgsTFIsZuGGG4HDkixa0QuuB61s2darWJzsrtrNls7k1YA+awolvMosBIO?=
 =?iso-8859-1?Q?Bdg9jEqqEof8iG9j7aJZPXLkOei+krnCptrhXdW/mMJGMvVDtcej1PB7P9?=
 =?iso-8859-1?Q?22LXArnrqscxPtuO7O6LAiiNiXQdF0wzDwfIE0rmqq67HWopOqvw1VcoWb?=
 =?iso-8859-1?Q?sf01ch4SpB8EgephAFRJMVfgLcgS3W3ubxonA63Ic+iJcwBJkjQlD0ergk?=
 =?iso-8859-1?Q?mqW1cWVQjWKOEIRRMhNmni/hUTTz4naPdRSIolj0w7XHUjtn0Du0+Vx+Dd?=
 =?iso-8859-1?Q?vn2B+KMmRoVud5F/D6jMDMnfiCg45ByxAWDfD/MY4WIsmp7hJQ5+VTfRTs?=
 =?iso-8859-1?Q?sdUR48kbpOBSw0JKXt0RehwNk7XWzvSIjyyRiHJTuTtSOKd1XtVwMu8ahb?=
 =?iso-8859-1?Q?yd9Dnkc/+r/4m/MsUBW+jyGQ7+2AFlud/GG2c+vmnzjfPC7W0fHcNlwoW1?=
 =?iso-8859-1?Q?XAxDFrIoHOrQlFKL0DwVFPFo8QrKvwsBBWfJwA/EwuBAXwcKhGWy1m3DFv?=
 =?iso-8859-1?Q?QUTGoqxAlBrlzdeyncDRKeCQPlJ89mKQRuVchJeQSXlczEhZkZJfzM/7bq?=
 =?iso-8859-1?Q?9yKrvLJuHf1k15eMus8iu6z2S4rN6jukdvUaC3K1Za8LqaehseTRpy+Aia?=
 =?iso-8859-1?Q?6Uoz4QyW1M39bFc3Q4ecKdRnWN79KicVFcFreAnN6Fm+q8pIhMrS/Jn9Z7?=
 =?iso-8859-1?Q?yHR4eAIUHDrdY0Hreu1NsA4T4MCCWDtpMaY+Ihf8LRzDZYZasB7VUb4nPm?=
 =?iso-8859-1?Q?MfPIAn+FfTBSKFs3CaS/ly4/0WvOFuPA7u5B8iuNIfGkqVM1n5ORBT5vZG?=
 =?iso-8859-1?Q?l0zUyQUjJMtBZP7cQ8opWvwTwewwikR11+ZS1LbfsQttvledC50rYBqXoA?=
 =?iso-8859-1?Q?YJjLW0XLo1hW4N9vt/pIyowf99dcAV0N3/Yi4V2Sp0+dB1FJ8+Z4yqW7uC?=
 =?iso-8859-1?Q?bOoWQnzQu188jpPsn2mNJLAuBKdSkiQka8t8yHX5D+k2I4+s9jC8Mdy8OV?=
 =?iso-8859-1?Q?NkmoAOckRoMl9ssns4iO8Op2SJ4FildfN0/Oc3r3GqQVW5Y2FbUY2eyCwB?=
 =?iso-8859-1?Q?9wbfv7AGYdpFIXpFWgml0vc6FcZho/HclmQSkj0Ez8s2fDVrlQr3gm0eby?=
 =?iso-8859-1?Q?fyG0eilWIknEbPiYH1J/VPY6/BUhp3sLZmg4ZlUE9oXqJEQKKPyshWQO8i?=
 =?iso-8859-1?Q?StuAJwiIx3IPWbgtLprSkXioD0sSGhzuOz21tW2A0WYmhMGOX80bbGy59a?=
 =?iso-8859-1?Q?1rsyZg+bO7iafdvjg3OT8W4q3Ar/2Vbrb6fX1zqmDYlraNuep5WNbGt/OK?=
 =?iso-8859-1?Q?rfVFPIAVNSlFUb0Z9xj5TloVbohbK2V7gC2XeI+UpNXGrpIa0m5qQuD2KR?=
 =?iso-8859-1?Q?E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?HRCEvWE22A3ZuBEDhZRAL65L09KD3dXD6JdMMJomf/kTN0aSGdy+PKMnql?=
 =?iso-8859-1?Q?cCjmkaPXVS4phC22cDWjYHoQdSh7LDOvEOQvgTa87NNmy0kaxADShyPJq5?=
 =?iso-8859-1?Q?JV4NJKC031+XcvBwVAuOaQO6reHJM5KdqVXWKGB86YBR/zcpdy3IDWT3Os?=
 =?iso-8859-1?Q?1o0vvbfaP148zi47Hgq76LWb7wN8Yan/hM0YOYjchY4bFBDisjcg7N5nnu?=
 =?iso-8859-1?Q?MmjgwgDorXfdmQdmSMXN21dPn14ndMdMpuXXj31ZpkHnB3ckA6AzX0kDkd?=
 =?iso-8859-1?Q?tcjrbj7KAYGM29wXqYWG5+MJZztKbbdBpkEmGApG7155gP9j7EIdzaF9lp?=
 =?iso-8859-1?Q?PjanWJkaJVnvU1lnPnxQ3xGbLbDC3tfZ6BMxzYSpj4MVQQyJUR5lXDHMwz?=
 =?iso-8859-1?Q?XQL0Nvjn+cqrzzPT+mXXIiAjmrZaavnIWP+k7J7Ev9XnxKg+y4Cn7R3lto?=
 =?iso-8859-1?Q?ClRNbieQBl3l4gUuGMkVeNOMxgZWAj+KEYi4ml1V2VpEFDPNjSltBIKNCz?=
 =?iso-8859-1?Q?PsepUu5PpVehpKkzpHVbIg5ffLl1P/rGcM6rN8CcCmms3XQ4OcaxiBDq02?=
 =?iso-8859-1?Q?nu6I1JPclChMKsaqS4CTb4On7TOLhD0+QVvDSj9X9NSowCw8rLpPmaz6Yq?=
 =?iso-8859-1?Q?KfWOAEW5ALD+Vj1KVTUaKaP0BnMoWknlrGAE3P92G2e0sV0sguGCkVjXhX?=
 =?iso-8859-1?Q?Rk+8SU09OOXcb0nDtsiqHjqdhLPvUhV25nSn8cjjQW7NvMobFnEiJjV+pW?=
 =?iso-8859-1?Q?Mma5eL9ewGfKbSPzsoCoA0pyXll869wuEO3eFdgN0tng7uMAwmOKKEFZfT?=
 =?iso-8859-1?Q?lXbbwTVVINFtyhi9VcJ9Iij/fbVePHQFn0brdcyk3UQomqEchZqg7bN52Y?=
 =?iso-8859-1?Q?cXhtkM84BYWD63r6mgTrYQJ3mBhWDM+Nfqe3vKNBHgNKnOqYv9eQ9MuNdR?=
 =?iso-8859-1?Q?MJbvtfNuRSioVgnleZE5NBx6huwt1PLI6vAIx5HHMjxHIgXB1/lqRAidYy?=
 =?iso-8859-1?Q?C5SofWz+hNNjX0lRxXU4z+ZqndFCNROCKkRYMIbSEDSCH7M1tcYWUHK+9N?=
 =?iso-8859-1?Q?gDAi14/ZmcyCFA8/cR9fx5k5BWMPCm1sBbo4iS6CQ6RZer+BIwkqZYAAzd?=
 =?iso-8859-1?Q?clgHZIadTh4NAJWvMyGfWW/PLgynfYLGOvSwYOOk3lEx0Fojj/3dY0lOZq?=
 =?iso-8859-1?Q?DpOxNnVzFGhurBqtSMojazkv1XqLRY6va5qXHGg9Ti4PilZIxf9AncnRwQ?=
 =?iso-8859-1?Q?w6+PdvOtdpDO8q+qwZbpxJrGtrw++I2/tbdg20N1tGlHBWvCrU2c37U2ds?=
 =?iso-8859-1?Q?gecDlSIMCALRpaOXZVSFXyEm4XBuqMnVSHfa+P9/hSo57gKCwnh64lVNi7?=
 =?iso-8859-1?Q?FraHLPT/Ik39OVKlBJOy6jukiC2KKKGzq3sgcfPKAUsidTp3hAnvUD0Y6b?=
 =?iso-8859-1?Q?lHBZ7vARti6SINr/7QKYp4LF0+8nE5trWCUO+D3FDB/G0Tugup7SLi9K56?=
 =?iso-8859-1?Q?/UKkpTRJkg1bTt+/Mf/z+yA1bOfec8Rqj06lfmssI95oSQY0WCfVTM/xrI?=
 =?iso-8859-1?Q?JxFoqQFCfkkDQYzA0M4oYyRV/CwgICqFOKknfuhZ9Hmgu3g3Tr6qOhwlEB?=
 =?iso-8859-1?Q?JrvPNYmGqgr5YBeAABn7eZNN6BYVSResBTIfPrRYwoj9s3XVdMl8tAaw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wLhifGOwoNDK5AUTc+bJ4Gy/HUmmLry5dNHZAKh7LCsM+TXhx3ZpzxeryDiHMZoklVlvNnQ4a0S8KlvmcCH3mQOlThTreBxijJ5WZ8xjA71DWqtGuYd5u4X2Gklv48/ZhYhT6bfc6C4X0DucJgdSuPZR5AGnf8LDNF4qC9WMlWVIVD01/nbo4u19yuASWXa97cQ6WocyO9wH92Q17wRkSBG6aj+EE9X5dMIU3d9cC7eOZ/zgyirILFCGfXCbdkEmAvKMKrAKVTY3GGqQfQZ+9nnsUtMPOK9ssGXTZVDksGFf2kEmyaP8OOVIr+eI/5bGFqNm3OHGOI+jXEGLLHIFbdVcg7OooqWyvVuCRDIONuD1WI16e0lFKdEstz9a4t1nhEwZw4rqU2yfKkbn+uhZDYC16YMz2URnZ1mzgSj63iqJMwm03AF2Bae9fYrBfDpZCo3rpnW/6Zio4qdeMaBliI0gfMqvyqsBG3hG/q+rbrEB4Tp2rfyCQwRKjyMyJw5dDWR7W9njwPzzAaDkLmO8FvjzbdcLxQsft3gwTBPyP94FO7RqRIUcuP/7Qi8FP5bEQtjzniW/B6+KBYRaTo/taxxMBkF8+KKSNwnfkDjZI9I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e973f6a5-819d-4754-dfc3-08ddcac84109
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 15:39:19.1717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7EAWwhzqCeHMa/TpSRZiOi0n61piS8Ui4v8qyKK2DaCQfaNNLqoZJOYaxbGdEmcY/rIQ2p5yWrHtrjmVWdv32aOYp/Fs3Ph+QcoC9mjZF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4865
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507240119
X-Authority-Analysis: v=2.4 cv=TfGWtQQh c=1 sm=1 tr=0 ts=688253ab b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=MhnL__LWAAAA:8 a=qEr9z0IRn_NSqV-NX0kA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=DArMNfZabhNmbrQIurc0:22 cc=ntf awl=host:12061
X-Proofpoint-GUID: iWhdeoMIoO1EoppHHawIr1lBcIeOGVlZ
X-Proofpoint-ORIG-GUID: iWhdeoMIoO1EoppHHawIr1lBcIeOGVlZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDExOCBTYWx0ZWRfX1YT53tXEMFpS
 E+hi3DyCxTMBwq3YL1tf6ez36GFBntHS5iiX0FXYHVKHJqTP8woM+pgfg7Hi9CyU4FmeKPREOIu
 4Hkoo0S4v/7uwx3bvGvr1UbrNgmQKCSBxtISJ/r7X8F+hE5nU75fMO5S65N/Qakk/mv/1DVTZwo
 4Cuy/kglYtC2DgMpx363qXMvX55vdZHvH6Fef+YWO4BnA5XcVzOhwiofPR0eWJFHjMjF5chzlL7
 HflW/OkbGsJfl46s+K2Wj42dyOUBaoP8GsZ0v0gk3FMjBpG7B+Bo3ZDHCaLPvcE8VcALz/vi4p2
 tIuF9tVoc2A7/cCwoJmjX5yFBP30d7SWsI9Icwf9PZJQhJerHhEBbIS/MsWlA7o/6tnm99hX9Om
 OuP9zQoVmuYB9JF9nk8SCyCANKVJhxEAfcPZcBXfNY/8JTgCUIC6gBJWEHHtk3zODk5lbBij

Sorry Andrew please ignore this for now, I'll send a v2 later.

I'm not having a great day here...

I wrongly assumed that, since this is wholly unused in practice, that nobody
would refer to it or include the header, but it turns out that's incorrect.

Thanks.

On Thu, Jul 24, 2025 at 03:53:12PM +0100, Lorenzo Stoakes wrote:
> This is dead code, which was used from commit b739f125e4eb ("i915: use
> io_mapping_map_user") but reverted a month later by commit
> 0e4fe0c9f2f9 ("Revert "i915: use io_mapping_map_user"") back in 2021.
>
> Since then nobody has used it, so remove it.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/io-mapping.h | 231 -------------------------------------
>  mm/Kconfig                 |   4 -
>  mm/Makefile                |   1 -
>  mm/io-mapping.c            |  30 -----
>  4 files changed, 266 deletions(-)
>  delete mode 100644 include/linux/io-mapping.h
>  delete mode 100644 mm/io-mapping.c
>
> diff --git a/include/linux/io-mapping.h b/include/linux/io-mapping.h
> deleted file mode 100644
> index 7376c1df9c90..000000000000
> --- a/include/linux/io-mapping.h
> +++ /dev/null
> @@ -1,231 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Copyright © 2008 Keith Packard <keithp@keithp.com>
> - */
> -
> -#ifndef _LINUX_IO_MAPPING_H
> -#define _LINUX_IO_MAPPING_H
> -
> -#include <linux/types.h>
> -#include <linux/slab.h>
> -#include <linux/bug.h>
> -#include <linux/io.h>
> -#include <linux/pgtable.h>
> -#include <asm/page.h>
> -
> -/*
> - * The io_mapping mechanism provides an abstraction for mapping
> - * individual pages from an io device to the CPU in an efficient fashion.
> - *
> - * See Documentation/driver-api/io-mapping.rst
> - */
> -
> -struct io_mapping {
> -	resource_size_t base;
> -	unsigned long size;
> -	pgprot_t prot;
> -	void __iomem *iomem;
> -};
> -
> -#ifdef CONFIG_HAVE_ATOMIC_IOMAP
> -
> -#include <linux/pfn.h>
> -#include <asm/iomap.h>
> -/*
> - * For small address space machines, mapping large objects
> - * into the kernel virtual space isn't practical. Where
> - * available, use fixmap support to dynamically map pages
> - * of the object at run time.
> - */
> -
> -static inline struct io_mapping *
> -io_mapping_init_wc(struct io_mapping *iomap,
> -		   resource_size_t base,
> -		   unsigned long size)
> -{
> -	pgprot_t prot;
> -
> -	if (iomap_create_wc(base, size, &prot))
> -		return NULL;
> -
> -	iomap->base = base;
> -	iomap->size = size;
> -	iomap->prot = prot;
> -	return iomap;
> -}
> -
> -static inline void
> -io_mapping_fini(struct io_mapping *mapping)
> -{
> -	iomap_free(mapping->base, mapping->size);
> -}
> -
> -/* Atomic map/unmap */
> -static inline void __iomem *
> -io_mapping_map_atomic_wc(struct io_mapping *mapping,
> -			 unsigned long offset)
> -{
> -	resource_size_t phys_addr;
> -
> -	BUG_ON(offset >= mapping->size);
> -	phys_addr = mapping->base + offset;
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> -		preempt_disable();
> -	else
> -		migrate_disable();
> -	pagefault_disable();
> -	return __iomap_local_pfn_prot(PHYS_PFN(phys_addr), mapping->prot);
> -}
> -
> -static inline void
> -io_mapping_unmap_atomic(void __iomem *vaddr)
> -{
> -	kunmap_local_indexed((void __force *)vaddr);
> -	pagefault_enable();
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> -		preempt_enable();
> -	else
> -		migrate_enable();
> -}
> -
> -static inline void __iomem *
> -io_mapping_map_local_wc(struct io_mapping *mapping, unsigned long offset)
> -{
> -	resource_size_t phys_addr;
> -
> -	BUG_ON(offset >= mapping->size);
> -	phys_addr = mapping->base + offset;
> -	return __iomap_local_pfn_prot(PHYS_PFN(phys_addr), mapping->prot);
> -}
> -
> -static inline void io_mapping_unmap_local(void __iomem *vaddr)
> -{
> -	kunmap_local_indexed((void __force *)vaddr);
> -}
> -
> -static inline void __iomem *
> -io_mapping_map_wc(struct io_mapping *mapping,
> -		  unsigned long offset,
> -		  unsigned long size)
> -{
> -	resource_size_t phys_addr;
> -
> -	BUG_ON(offset >= mapping->size);
> -	phys_addr = mapping->base + offset;
> -
> -	return ioremap_wc(phys_addr, size);
> -}
> -
> -static inline void
> -io_mapping_unmap(void __iomem *vaddr)
> -{
> -	iounmap(vaddr);
> -}
> -
> -#else  /* HAVE_ATOMIC_IOMAP */
> -
> -#include <linux/uaccess.h>
> -
> -/* Create the io_mapping object*/
> -static inline struct io_mapping *
> -io_mapping_init_wc(struct io_mapping *iomap,
> -		   resource_size_t base,
> -		   unsigned long size)
> -{
> -	iomap->iomem = ioremap_wc(base, size);
> -	if (!iomap->iomem)
> -		return NULL;
> -
> -	iomap->base = base;
> -	iomap->size = size;
> -	iomap->prot = pgprot_writecombine(PAGE_KERNEL);
> -
> -	return iomap;
> -}
> -
> -static inline void
> -io_mapping_fini(struct io_mapping *mapping)
> -{
> -	iounmap(mapping->iomem);
> -}
> -
> -/* Non-atomic map/unmap */
> -static inline void __iomem *
> -io_mapping_map_wc(struct io_mapping *mapping,
> -		  unsigned long offset,
> -		  unsigned long size)
> -{
> -	return mapping->iomem + offset;
> -}
> -
> -static inline void
> -io_mapping_unmap(void __iomem *vaddr)
> -{
> -}
> -
> -/* Atomic map/unmap */
> -static inline void __iomem *
> -io_mapping_map_atomic_wc(struct io_mapping *mapping,
> -			 unsigned long offset)
> -{
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> -		preempt_disable();
> -	else
> -		migrate_disable();
> -	pagefault_disable();
> -	return io_mapping_map_wc(mapping, offset, PAGE_SIZE);
> -}
> -
> -static inline void
> -io_mapping_unmap_atomic(void __iomem *vaddr)
> -{
> -	io_mapping_unmap(vaddr);
> -	pagefault_enable();
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> -		preempt_enable();
> -	else
> -		migrate_enable();
> -}
> -
> -static inline void __iomem *
> -io_mapping_map_local_wc(struct io_mapping *mapping, unsigned long offset)
> -{
> -	return io_mapping_map_wc(mapping, offset, PAGE_SIZE);
> -}
> -
> -static inline void io_mapping_unmap_local(void __iomem *vaddr)
> -{
> -	io_mapping_unmap(vaddr);
> -}
> -
> -#endif /* !HAVE_ATOMIC_IOMAP */
> -
> -static inline struct io_mapping *
> -io_mapping_create_wc(resource_size_t base,
> -		     unsigned long size)
> -{
> -	struct io_mapping *iomap;
> -
> -	iomap = kmalloc(sizeof(*iomap), GFP_KERNEL);
> -	if (!iomap)
> -		return NULL;
> -
> -	if (!io_mapping_init_wc(iomap, base, size)) {
> -		kfree(iomap);
> -		return NULL;
> -	}
> -
> -	return iomap;
> -}
> -
> -static inline void
> -io_mapping_free(struct io_mapping *iomap)
> -{
> -	io_mapping_fini(iomap);
> -	kfree(iomap);
> -}
> -
> -int io_mapping_map_user(struct io_mapping *iomap, struct vm_area_struct *vma,
> -		unsigned long addr, unsigned long pfn, unsigned long size);
> -
> -#endif /* _LINUX_IO_MAPPING_H */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 0287e8d94aea..b7a47bb593d6 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1254,10 +1254,6 @@ config KMAP_LOCAL
>  config KMAP_LOCAL_NON_LINEAR_PTE_ARRAY
>  	bool
>
> -# struct io_mapping based helper.  Selected by drivers that need them
> -config IO_MAPPING
> -	bool
> -
>  config MEMFD_CREATE
>  	bool "Enable memfd_create() system call" if EXPERT
>
> diff --git a/mm/Makefile b/mm/Makefile
> index 690ddcf7d9a1..e4ab5ca755d1 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -142,7 +142,6 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
>  obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
>  obj-$(CONFIG_PTDUMP) += ptdump.o
>  obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
> -obj-$(CONFIG_IO_MAPPING) += io-mapping.o
>  obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
>  obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
>  obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
> diff --git a/mm/io-mapping.c b/mm/io-mapping.c
> deleted file mode 100644
> index d3586e95c12c..000000000000
> --- a/mm/io-mapping.c
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -
> -#include <linux/mm.h>
> -#include <linux/io-mapping.h>
> -
> -/**
> - * io_mapping_map_user - remap an I/O mapping to userspace
> - * @iomap: the source io_mapping
> - * @vma: user vma to map to
> - * @addr: target user address to start at
> - * @pfn: physical address of kernel memory
> - * @size: size of map area
> - *
> - *  Note: this is only safe if the mm semaphore is held when called.
> - */
> -int io_mapping_map_user(struct io_mapping *iomap, struct vm_area_struct *vma,
> -		unsigned long addr, unsigned long pfn, unsigned long size)
> -{
> -	vm_flags_t expected_flags = VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
> -
> -	if (WARN_ON_ONCE((vma->vm_flags & expected_flags) != expected_flags))
> -		return -EINVAL;
> -
> -	pgprot_t remap_prot = __pgprot((pgprot_val(iomap->prot) & _PAGE_CACHE_MASK) |
> -				       (pgprot_val(vma->vm_page_prot) & ~_PAGE_CACHE_MASK));
> -
> -	/* We rely on prevalidation of the io-mapping to skip pfnmap tracking. */
> -	return remap_pfn_range_notrack(vma, addr, pfn, size, remap_prot);
> -}
> -EXPORT_SYMBOL_GPL(io_mapping_map_user);
> --
> 2.50.1
>

