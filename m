Return-Path: <linux-kernel+bounces-825141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAEDB8B1A1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3D5565B61
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BA129ACC2;
	Fri, 19 Sep 2025 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AxU2xNC2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e3H+3ONR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95032874FF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758310791; cv=fail; b=TIBynaHH+eaoYSALAmA8MqPEnNMlD1i2kEWjrbMlztNoUWtIOwJkaREN2dw+SBDsujzCA64JoTKc0fxd8hdSrpGlcKsb2L24ckP6dF8nWtTBq7HE+7zrEin5KO+Ml1LASNVYl/arTyq1M7qdngHOgaaSxiJL7GrTt+MlKmuXNIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758310791; c=relaxed/simple;
	bh=6kni4UAS9YXgEwSZaaPVljUIcTI7S/p4xxkgNb/v3fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aiC2FKGwzOVDSQX8LM36JrbWeCF18Pj5B2nOMc7u3iKTxONWa+1rOBsuAAmJZhTQ7G2wMV/Z5aw23LxJ484a0tYbQYj7PlxHCGRS2ESRaidm5zEdqPocZMHI8g5DZjsbiuoXy1zR3+Ubn1u6LIP2lHe7hZMiHvGoHDuabtcypZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AxU2xNC2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e3H+3ONR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDuM1D017630;
	Fri, 19 Sep 2025 19:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=wHqrAQeWNahcY0IuoI
	lbLsUcNls9rVsEHj0ezCl5sSs=; b=AxU2xNC2PbtoQKR13f4w5caml6nSNHlxgM
	Ir23+tCmVmZ9hsktqV5BjIjB+EiTyK/1pQkTTKvARewaVL1hiL6a4Zphy4RvG5vQ
	H4kudzHNPpaCZjn0zvneH5T/kwbefxfS0qfnFM4vn02biXFH4FnadamKv2fbEuY6
	unBJteAVYBb9GsOmfEn6+Xj6z3z/MlB25trYb8seC7DzRGnzJqSngrczHLswIjO4
	DKtGqgBhBOf7kxxLHXW1gVKQZuLZHeaAgNn8xkKWk2hmjDZPkofDhlDRhDk5o3Tu
	1I6DcmOV+7imBYOP+LWA86uPVzxdB6r25wtdOb2KCzyBjqrxj7Xw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497g0keawt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 19:39:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58JHeDRS035170;
	Fri, 19 Sep 2025 19:39:07 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010070.outbound.protection.outlook.com [40.93.198.70])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2q6gdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 19:39:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7f2dkIzYRbpo1sONV7qJtejNHIK9MqXng+5HZWYq7N1BeOsuDB6oUoDQxzHwPRyq/OAcV1wdLucddQrt6eWTenqWh0UauVC2OGwpKFtcssrh1RaFiqc5HpY+xfD5/5EJVFgVyYPWw4aSl9o8ip3G9DC7upcE/zernJV8cOG0SXVK0uEm74mWTot0bfxXDL/yt6ShSp1j/kY+/xDg7Xg3c892UbsYADqHDg4NOqI2+9Uqdkduq8mWz3Hqwi0bI/NlfOLixjeZFh0qUFR51Kp8v9IvTfQWhaNvaiKsqkzqrLCMsJfCPRjhKze+zKDGNbiK0oNd+DdroIglmyUu/wbyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHqrAQeWNahcY0IuoIlbLsUcNls9rVsEHj0ezCl5sSs=;
 b=YgwLSOA8gctBuYWUEiTZxWKSs7q64hJDShPDbuekub7BEl2DuqYQolwRIySJOQC7MJ3HdsTbeVRys2qnV3nCz6ACpLLAfCk1aGBt73PmJ3jSXEDVjGHb6zJYhQRTcLkTQn5g2JaUVH3L+nWg1oRR7sxXiWxU4D39KmVSlB36DSDp93r7ACthxmcIIYn8jyjcFjFq7pp+zc18iCrdzkBx7hBnYk0BanqlxHlODqnpNZFZjXOJ6I5PYhe16A/U5+wmMBCLV8dCorCqdVmpB0DtDvj/Z5hpOUxqeU3DCp3l54ZKS9VBnD3heg+jV5lxeoIY93R/2RaWKyWmnVNU44W5ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHqrAQeWNahcY0IuoIlbLsUcNls9rVsEHj0ezCl5sSs=;
 b=e3H+3ONRJSbTHBZaVJK7+AvhyVAdUAoU67YRG+yPmWQmmqm568j4/k6Uwi8WPU0BGh8iddB7ndv1ucdyebw1l1bP2/P14GzZZpAkEkflZ9f53fgRDo59p8xL0X73fUhx9H9O5JEtdRUarfEGD6HXpiqVhyDPAgq+VtchgZBZnf8=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS0PR10MB7477.namprd10.prod.outlook.com (2603:10b6:8:162::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 19:39:03 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9115.022; Fri, 19 Sep 2025
 19:39:03 +0000
Date: Fri, 19 Sep 2025 15:38:51 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Nikita Kalyazin <kalyazin@amazon.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>, Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Introduce vm_uffd_ops API
Message-ID: <unvooxce622bchlsivyr63lsvywnx4u6omyndotdo32ynv2eki@ju5srmktf3hg>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Nikita Kalyazin <kalyazin@amazon.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, 
	Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, James Houghton <jthoughton@google.com>, 
	Michal Hocko <mhocko@suse.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Oscar Salvador <osalvador@suse.de>, Axel Rasmussen <axelrasmussen@google.com>, 
	Ujwal Kundur <ujwal.kundur@gmail.com>
References: <aMvEu9m7fJLnj862@kernel.org>
 <4czztpp7emy7gnigoa7aap2expmlnrpvhugko7q4ycfj2ikuck@v6aq7tzr6yeq>
 <a1a48a0e-62d3-48d0-b9c2-492eb190b99f@amazon.com>
 <7cccbceb-b833-4a21-bdc4-1ff9d1d6c14f@lucifer.local>
 <74b92ce3-9e0e-4361-8117-7abda27f2dd4@redhat.com>
 <aMxNgyVRuiFq2Sms@x1.local>
 <cigo2r2x22bk7wzr6qvazcdkmt5kfqhbgb7nslpuff7djufucg@f6xucfuntz3q>
 <aMx0oGwRpSTcfdnf@x1.local>
 <swfs7qpgrezamnijhheiggwdfklfqdc6ahp5g7nvprr64m7wz5@msf2mqajzbuz>
 <aM1l2YMmvBgiXJ8a@x1.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aM1l2YMmvBgiXJ8a@x1.local>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: MW3PR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:303:2a::32) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS0PR10MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec8183a-2a7e-453a-7876-08ddf7b4303c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bMftbs7aQ6TkCT7v/dJGtrvTTTdAvKt1shDZXeaEInXs5XzaBDnRhqStGPPv?=
 =?us-ascii?Q?JkWmrsOyKuZAMsYoiSgE8seIX2kqMBxkO9dih3oQD8kOWnKVgdYy60pK6/qH?=
 =?us-ascii?Q?rccm+rK2FJgozbpXNdjArPP6Q9gQc20sNQ6q/g8SHYMqcPiam3buLN7j6CTK?=
 =?us-ascii?Q?UwhPQQTS//juoDuXuCOqH8tB6uF9sM0PZbcdQNQ4qGMHLFKRAuZYfKsdCxL0?=
 =?us-ascii?Q?f/1Ph0pvAFeCgx8fWimQ0J8k9IRzUtJUr4918nOAL9XAD3q+I+IBWDPJZ8HP?=
 =?us-ascii?Q?XtUCOGTCABlL9xEZrfCsyYIKS4iCaYE12En2cN7bRTYje90mH8XXi9UeZZXw?=
 =?us-ascii?Q?SNCCJ/SrVK6dCg+59CL/eQNiCjPqR+uuBvBRTUsopTrU/adR+hEa4mRtzjrq?=
 =?us-ascii?Q?/4DsfP42gFJkd8UG0XDxy1NNVTdqalkMneT3BAFZUkMvE314yMHPqPmEbVYr?=
 =?us-ascii?Q?He5Ppc95Bc1XNveTjpbi4s25lsA63BYCZSgmP5aD4qbr9/ubvsrJRWTUjJ3N?=
 =?us-ascii?Q?hzz/UaWZ+tDPicn+kdqpu3gEHTxLyG5y2tOw1WppZglTX5fiyXOFs3fyYESg?=
 =?us-ascii?Q?AwFX34qGClCifkPRsQhTAJsdkeQDdXJGYrx/xGfPKv4WRp1oCq3CgfdTkFM+?=
 =?us-ascii?Q?hRpJYmuNBbuAlNZ4lzs14/qYmvxtgkQlYUwDhaNLhU7otcJhb2ENhEjm3VqE?=
 =?us-ascii?Q?gCvaOROW8DHMlGhSNtcOtEIKoJfLWtaASXYtrjKda9Gjt4A4rdeEgSthU0Kj?=
 =?us-ascii?Q?HJJi9mYqyP0W3ZnllEDo8DKpYbQuKDOKPHh0c/8o5kDnL4S7d08mKUlncv/P?=
 =?us-ascii?Q?ziV1GWRmE+zktRn5glFeRq4f4jndNf+uA1AwTpMYWdB1A9B0TXMKolRijtvv?=
 =?us-ascii?Q?Xtty5gHK1EBhn5Fk3T7HS6fhN/wax8iWUCTb4xHFDOJZmfi5z+0D0TGbzPqN?=
 =?us-ascii?Q?2BAu21UkcrfEDh+qPjSptFGpDVJLg2gT7eMzzeTGo9E0+NmXjwpOoykXljpv?=
 =?us-ascii?Q?5/ePkdBrozvMpu8XJo1WwchIThYqtVsK8hu6um89qf85vBo3COq98ZKaYFQo?=
 =?us-ascii?Q?x9g5195fNXihHRen0u/6U0eUee6lng0ZFj+Vrgdqvxa/BjMPET1nE8ppFX0b?=
 =?us-ascii?Q?W9Bbqjm9m+8Fkh4N0fhiFATWitCxdCX2W6PPgNUXjuIY/N5O8dJfLNQD+uU8?=
 =?us-ascii?Q?J2bo1fHIyLcUeDSxJsE8IktN/Z5HqkoTgZr7T9vfq3m23pcRmFKG09zMOhHC?=
 =?us-ascii?Q?ggepds9/VY4aRabqJCJB6ucYj85EA5nUiHM0k0mKDKirx80spYJJir28NKGt?=
 =?us-ascii?Q?eIRYIVMn2f4aarVktByX9AwsdC0W5Q2w7f12fQ740wdQG+4MkauBiNfAC/2T?=
 =?us-ascii?Q?PMa9kDM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G94LWCm3Pa790iWkAgfCX1BVaUqqRHP+7HH8+R4y4Mwq3st20XCjTT+vu8pv?=
 =?us-ascii?Q?e6VmLwKj85Je5TOxNg+uITfGIN1kX9JHV+dWB8ShGGsueF0eB4mbeStx3Kn4?=
 =?us-ascii?Q?w66L2uCuKXd+Dg2Rp7ZuEogbQ1l4bOXPWZ4aIvv/L6QhWotRazAP2lvcz3+f?=
 =?us-ascii?Q?TqeIUmdkSln1pkPj0ygakMUb5V2b4F7udyAoQr6cSrxWYJeeFzY9wk2zHcAI?=
 =?us-ascii?Q?/fFv0Hh5A2LUEV373n8nR1+ZroiSNvNSyV7JdMtcCCj1TxIFBaQlKLxrVxZY?=
 =?us-ascii?Q?+UxoKhD3L7J11aT/7g8JKX0lpnO42KohQSOii+S5tN9AmnCeQnPw7m7oIE2Q?=
 =?us-ascii?Q?/mbG4p3/olwH6kXtNNqWyNk+IReGv2Cajj8Qo1lnY7tKVgu89yuk5LFMr8It?=
 =?us-ascii?Q?1xhoQnEX5QNEnRuuGmH99FGaoreZD/4m92oRc0bDLydTv/R9uPtnw5SQ9X57?=
 =?us-ascii?Q?ezQ6sFKjYVzY7ZE/59mUORf3j7PiKSm9+z+At+K4M3Md1SLO7LpQk2k80KZU?=
 =?us-ascii?Q?GS+D7uw8KF9RzmgjM8B5jiBzYmFYwUH91iXXMfXo1AZxEsyRqWhCHAaD0YJw?=
 =?us-ascii?Q?jqCBnCc6wqUp+EHr8ajIFfLnqA4fXbdHk4mnlqsaG84OkCM2GtSZfgGlrDUM?=
 =?us-ascii?Q?f7OoCxjtq0H3f/rxUxVRfGBYCIr8pPx/MQUPCagTGY29JCFNlYr/Op41UMDs?=
 =?us-ascii?Q?NGUPBrH89v8vY6c0T8OU8yORt/dnJM6syPhlwYGb8IYeC8g+EDXGw/IB+HO2?=
 =?us-ascii?Q?Iif+QelsI1BWCrK/tASGKWe3ls3rLKeM7OSN/LHxuCXtiXDsK1DAdW6PlSUw?=
 =?us-ascii?Q?82pvyjHVNOEDyNiu+zxvbPDHuImvzyX4hDXBxtNc7LAX9hz7LxXjCAMDs4Bj?=
 =?us-ascii?Q?apxAE3WIpyORpkniGTB6IPvFmEKYMo3Nh0hh3AMeqpn53aSRyQvRV6LYZG9e?=
 =?us-ascii?Q?BTYotRphXhCu8fUtqO0OkelHH4NMmrb+Et2jPE1DIfIMef/F4ZverD/8V16+?=
 =?us-ascii?Q?oqLq9zO+n+HhBWsBCzwLaxle14kGobeq8L7nMm9QuikFyT/3nxqFDEzpUv1l?=
 =?us-ascii?Q?wof/xQ+D0Mb4sai95bFhoELULh1C4Q6DjclgYiZTHsHRt9OjA3/grAJX2hjJ?=
 =?us-ascii?Q?muetKjakCqR4WxXshr2iSZJrQJpwba0a8U/5624nvfCGA04GsGCL9Hp11+W2?=
 =?us-ascii?Q?gPaymKSsOa978rsvcTOTgDPMrsU9Eos/03gxmgLG2OqseR7FVZNx6FAn0TcP?=
 =?us-ascii?Q?/r1tO1sI5p+3cz0xcWReo5fGKS/cnOc8GP0lJnl/2Fhi/lDWB+rVOh38GBBL?=
 =?us-ascii?Q?jfMrDehqyhMeWEvxYFZ0NsHT7GwN3PlBfSycIG/uAZ8nxT+fcW18IChV5ii/?=
 =?us-ascii?Q?VrJ3Ax83HhrIGXCtpSr5L8xFT/cprGr27TU7B5dg6EGWf47AUGoJ+Zs+J+RA?=
 =?us-ascii?Q?8qM1mkGQ0AKytKddQOgl8RhogpcT+bByPJvnxGVmuqYhIXjiy1e3O/Ip16oq?=
 =?us-ascii?Q?g7iOnJIKb9zF8qECIWqiMIiBsmVWiHv8a4dlUJDAuqLOXROIXriUObKUtbh0?=
 =?us-ascii?Q?WWGqZPziplRJGDYm4SHd71UZtHWO/+vnaaau8Qpb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Cslcby6T+o5nKVH7OnUcFeGhjBedu5XUAdKqwlK3Sa7cNrOI+dk1PntmiCEKOMgatFq6ZlWmtGKSJMXYzlsz24V7bZlV9M4Y/7i7jjHSOgE/lmOyN4QqqP3SD5FUxvooV0fWSs0MB9ahGhp/lBWOgRvqfenpzJuTJqaHatw3w4UdVLO3euAU0ghNeOObKbaUWnU/ZeueTkfalCQdDk571POAcUFJqetaD+h5nKOsLyEr1kwrTwfYJR4uouvNgYE9f8uCjA/horsCrjjkwmlZAsyJ3I+7xFeTKM1RcjJcaHO7CNbvlNa81OQhUdcSjMQ+FdlTdRC1SAJJdFjxt+BnWQZ7sOv4wNmNDczoBJkYKTroTnVzH1CoeXU7NAW3eT2ckwK9YpHTj/L+/mv6NkKl2moTh1Hees886HlxJ1ahwSkqSSbgjxgXV9UujmlpzFFTkEyBtsDtM7VqQ/JjvpKm5eR43IfuQ5DA0Ucg+DUzw8kxQPmUoU2NtmXTqr2Kh+id96qvHnB4d+0zEfQmJYZ1iyh8xhc6qpLBU1KYNK5ikFhoDj5F+PyyAFIRLYO5yRgxnLZt9Jq9nldcNlewPdNMQUut7znElxdtIFwqlHPHhEE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec8183a-2a7e-453a-7876-08ddf7b4303c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 19:39:03.4289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JgOlYj+zSAEpu1pV6/+4hzkonYgmYoSfheft/nV8lmOpvNWX6e835yt/rieg/DJ43bwRx11gshJl8aHg47lfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7477
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=921 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190183
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68cdb15c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=47uNgOy5BzRS4EBlXpAA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13614
X-Proofpoint-GUID: UC5A-2VuQBh1QyBOOf9EO_Irj9_QOGHT
X-Proofpoint-ORIG-GUID: UC5A-2VuQBh1QyBOOf9EO_Irj9_QOGHT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMyBTYWx0ZWRfX69Tp+J9aE26x
 TsCDFI8jBR5wietvdhanxMSSd26gyP1NBknxbJUZOackt7AQvnkHMRfxmBAoABXfxo9+2qP5seT
 FKjRfnB2o63lOC7cdkiIESYePHmppEAtt1eAf3Ajgj6r6FFBOk4xGxiP8a6x/jqryP/l1LgPD2I
 lDpffGbcjJRyboX+0PjI2ujac+BTnsHQjClqpwh86guc6uSUz8tdmsWsCNBh6rS8bYY5HYOdACf
 ioGHGBl2c0PgiLby6zaQ5lJM4FsBoO8unH35e0UbNKQhNsfpMNyhVevxchSPaU7cUjjgyyoB0Br
 YoiUs59x0OTaEa66xC052WOszkuHqe3jux0QOLH9xdAw82JAO2v4d9mlivTU1OYzGeGyQWw9m5R
 yoHq5uJyMob8Z7kFhM8DTBRqLnsvGA==

* Peter Xu <peterx@redhat.com> [250919 10:17]:

...

> > > > Can you please point me to which patch has clean up?
> > > 
> > > Patch 4.  If you want me to explain every change I touched that is a
> > > cleanup, I can go into details.  Maybe it's faster if you read them, it's
> > > not a huge patch.
> > 
> > I responded here [1].  I actually put a lot of effort into that response
> > and took a lot of time to dig into some of this to figure out if it was
> > possible, and suggested some ideas.
> > 
> > That was back in July, so the details aren't that fresh anymore.  Maybe
> > you missed my reply?
> 
> AFAICT, we made it the other way round.  My reply is here:
> 
> https://lore.kernel.org/all/aMnAscxj_h42wOAC@x1.local/

Thanks, yes.  I missed your reply.

> > > 
> > > If we accepted ->fault() for all these years, I don't see a reason we
> > > should reject ->uffd_get_folio(), especially one of the goals is to keep
> > > the core mm path clean, per my comment to proposal (a).
> > 
> > I see this argument as saying "there's a hole in our boat so why can't I
> > make another?"  It's not the direction we have to go to get what we need
> > right now, so why are we doing it?  Like you said, it can be evaluated
> > later if things change..
> 
> You described ->fault() as "a hole in our boat"?  I'm astonished and do not
> know what to say on this.
> 
> There was a great comment saying one may want to make Linux an unikernel.
> I thought it was a good one, but only when it was a joke. Is it not?

Well it's leaking the internals, which is what we don't want to do.
Certainly it is useful and does what is needed.

> 
> > 
> > My thoughts were around an idea that we only really need to do a limited
> > number of operations on that pointer you are returning.  Those
> > operations may share code, and could be internal to mm.  I don't see
> > this as (a), (b), or (c), but maybe an addition to (b)?  Maybe we need
> > more ops to cover the uses?
> 
> That's exactly what this proposal is about, isn't it?  Userfaultfd minor
> fault shares almost all the code except the one hook fetching a folio from
> a page cache from the memory type.
> 
> "could be internal to mm" is (c) at least.  No one can do what you
> mentioned without moving guest-memfd into mm/ first.
> 
> Nikita and I drafted these changes, so likely we may likely have better
> idea what is happening.
> 
> Would you perhaps implement your idea, if that's better?  Either you're
> right, we're happy to use it.  Or you found what you're missing.
> 

I spoke to Mike on this and I understand what I was missing.  I'm fine
with the folio part as you have it.

Apologies for holding this up and the added stress on your side.

Thanks,
Liam


