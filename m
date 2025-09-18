Return-Path: <linux-kernel+bounces-823395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 614C3B864EE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8EB1CC45A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78EB2737FD;
	Thu, 18 Sep 2025 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T6Totcpa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ljsY66j2"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1311522D7A1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217561; cv=fail; b=pOrAzkjJuLPqavwuTJ6/SOwwgX2ShsBnjLpuPDDsMP/TaURYUurFYTXYJshq67Ru3Jv/XX/lFWI7FEre9LEuY8tW62g0sgRttIZ6uizyKcQ1xkRgYa8J/rwuOCbbEMtM3IYjjNBAg6M6mMdNHKw4XRSdUMxz8Rag2OUSTWjuQuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217561; c=relaxed/simple;
	bh=nmLltfCzVmsgMb0jCANh0l5NLuK3pf4lKl+ppQr7S/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o2orjhLGw2lzecIyFA22aY4VH9Ltchw3hiwUxDpRswmxOPi0TdJD/mvDgJ7mWPW1ECxq1bhDP6pdnGl3WqsJh36hg82X4qsDuI20Aek4P482hTVqkOR5N/tPW2AnEg/hIJsqOzxSa+XOK5MHXHYNNOr1DqRIQ3VnNoAZpXRxie8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T6Totcpa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ljsY66j2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IG7Ea8009024;
	Thu, 18 Sep 2025 17:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=nmLltfCzVmsgMb0jCA
	Nh0l5NLuK3pf4lKl+ppQr7S/c=; b=T6Totcpa2LPvlkiQWL2MsXBFhWRer7T4Xa
	t9LjpmW8tj7jT15WsdJde2vwMi3WwVcDNRKqHFlioX7KfUXmw4KgyOYK1AzQVQnV
	7ZHfjZUsw57Wl69q09V5J750ChvlSm+RN4/ml1n4eoYycSEoUjJZVe1DTPkuSeSQ
	W7NF2rid8gYZ7yTnD6pExHRd3lcQxWM47bkPBQUNH+IPVdo82YAokBVqi8Kb3JW3
	6RKqp6jyzmbV8yse42Y4+hTaBUuxR7vwGAdPr75XRPZ2HEvtvTvIdg/887jrPU3F
	4FyifLt8uivxiUFNnAMG6i2jN+HQ5A7FJuUOt3X3OWa7J78RkPWQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxbv21p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 17:45:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58IHPcLT033679;
	Thu, 18 Sep 2025 17:45:34 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2fe4tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 17:45:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fvs59G/4DTIfUdoS3QtwHn6YJiR1aYpBLipXmjuA00bnsHrBYuLNHkdDCKPCjn6vTQGu4dTn2UCJbhM45pZtK4/MLY2mnxvS/VXRr5oPHCPWMi5w1eFjj7IvkJsDdLBoHV/N9C05vrf/ocPLPw6pPujZ+4fqKDG1A+P8xDhIXweeGb6s3xJTop6hwzgmpLH4T+DaZyB+QIFLkbrmtYB3GENytDhzWqHUc0mO4ishKI1yt3nQuT1Qi+Z8JxkdodG563v3kHwRg8g9pwhyenlaoVva6iDIVBg1tdFWpsANa6WBkambWhH/O1GUPiqNeezARXcklHN8XrN50IcvWBnnmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmLltfCzVmsgMb0jCANh0l5NLuK3pf4lKl+ppQr7S/c=;
 b=KWV0QrGCThOv0P6bzgqFb7svkqzCrDcbD+xldFd6bsw/KwhLBHFfMUqDdf3nJsuvhJpL+y6qZPK/mxlSNEFcmP/ZV8jtzhNpzqQ4KTP2zyblKJEoZnJwmTgMeI2P9Tgkt8jaJLH7Zcce5SSm1f5YRSlYKUCzma0tO9eP6uBWlb52mDUWL75o28m60f1be5jCfLAyhwILCn9r7sTfJ+qgzvI05BH4kQu/orcr6KFaovkjMNXRNQne/Az53hw5D87VzueZpYfMdkVRGtvxakmHmIhjtB+EdDJ1mFl4nvSqsrytR0S/M3FM1Zp5fBEWVwrYWp/29ssrJIMk2b7N1Yp2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmLltfCzVmsgMb0jCANh0l5NLuK3pf4lKl+ppQr7S/c=;
 b=ljsY66j2ldclyhZ7xVhBNxYc+nilhsLRVg+EqLjfb5KMdKVurTqgbBbjtXYe/wrCE6/nJyUZKiBXans1ENeX0W4qCBcCwQXTPVHqgtHXr2qsQBsRGsKVsvstOiCJLotcxWRwchjS0Nu7jhasEP1T+mQvuscddp2PLICqXRfGsao=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB7683.namprd10.prod.outlook.com (2603:10b6:806:386::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 17:45:31 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 17:45:31 +0000
Date: Thu, 18 Sep 2025 18:45:28 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
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
Message-ID: <7cccbceb-b833-4a21-bdc4-1ff9d1d6c14f@lucifer.local>
References: <289eede1-d47d-49a2-b9b6-ff8050d84893@redhat.com>
 <aGfsaIIzHWfjcNFd@x1.local>
 <e7vr62s73dftijeveyg6lfgivctijz4qcar3teswjbuv6gog3k@4sbpuj35nbbh>
 <930d8830-3d5d-496d-80d8-b716ea6446bb@amazon.com>
 <jxekhkhbn7uk23oe24svxrs3vfuhseae57sqagndqgh2e7h33o@kfkygmrvjb5n>
 <aMp-kW3OLqtZs8sh@kernel.org>
 <du5pzxmfk6lile3ykpaloylwz4eni6disj2oe25eq6ipzqemiw@ybcouflfnlev>
 <aMvEu9m7fJLnj862@kernel.org>
 <4czztpp7emy7gnigoa7aap2expmlnrpvhugko7q4ycfj2ikuck@v6aq7tzr6yeq>
 <a1a48a0e-62d3-48d0-b9c2-492eb190b99f@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1a48a0e-62d3-48d0-b9c2-492eb190b99f@amazon.com>
X-ClientProxiedBy: LO4P265CA0232.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 68407d07-6eec-4946-5503-08ddf6db2950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pm6R4F6WDuIhuooUZN+O4+yVTZ+2Qof/F2z9kD2efTAKkZQ70k06ZwkEdXhZ?=
 =?us-ascii?Q?4RzOhyMGdbUA6IzIyFbY4sOwHmJKmycwKFaWkYEtG0PalPNP/XsQAKWVxigk?=
 =?us-ascii?Q?PGxEIO3eL4aVV8/q8qcDL4s9+cSxmV79s6x9ac3AUWz47h6laACdx74aevWR?=
 =?us-ascii?Q?7x10GHk2zlwhrWqiaOgr0szf6yhXSo30KoXfqepX1Z10UKyt1on75IHkq3v3?=
 =?us-ascii?Q?E/x1dejuw2BpiHLrb2ellj/lyg1+VLdoFLH8/TcQZbbgyhAZJ9zDmLSC5h8w?=
 =?us-ascii?Q?6DIE+VNAme45YUrqJN6pg3NvIRklDolm+XYAVzKClSr6RP/2QbV3Bh+1ZHRs?=
 =?us-ascii?Q?UdTifybTcXnetNwdK54PssuU50A1a1CCEZ0TDbdzemwe2x/VC3lzeQJM668J?=
 =?us-ascii?Q?75zsZEth3v1XljIf0l2KsewRXKbM5jbtFTMD0IhdwDwZ2wu8TJ6B/CBfpmRR?=
 =?us-ascii?Q?U6C7yASytJCZihqfCFsWS3sgIfwkln23GFxyDuPaNJv8woUPDgrhDx+OsFyJ?=
 =?us-ascii?Q?7Q6T8tc8tskAmQeh/fwI6a0Ytq3MsUuE6cf3RnSOsktO2zeO75MoQsplIBtr?=
 =?us-ascii?Q?LrytVBWLruEjQWZCZSoPXJI4LKTwZIQ91BCJ4gMw7QB6I/+WQayVaW4EvH4H?=
 =?us-ascii?Q?9kizc6SI9lM32bgxdeaZu9scjebC1qqZ2IM7UiKJXpULY6cvWq3zJ6B7zGJr?=
 =?us-ascii?Q?qwAxT+d3PJWJy02bMgh75dSxvi3ihgmEsBKY9dO4zn0DRX7CdjUDKFheYMSJ?=
 =?us-ascii?Q?ZSQuibicnOWm9fAC84APG7BXj8/Kj/YTf2voIo8AfQijXsowTdVLEzqfWf5h?=
 =?us-ascii?Q?pDu66P3/b1j32QvgMd2Tfhb8nzvPHkRtxvE/5oLi4alM2x+JHJzuNbz8G9Wz?=
 =?us-ascii?Q?lSNgbmtUDCksdwTQfSry/DB/h/F+0vJICQhYkr+laU3GNchBkkeKuump+aGv?=
 =?us-ascii?Q?PG9K/PP8i6LAwLKabAWqdH/RwMuZf9DyMrnuj3yhUD7Ji3GXPynKrMD/s/1x?=
 =?us-ascii?Q?pWzdR6f2TTXwJjWu/Goo+UQqUNwOvh5ARhs4omBNMbxAfR1hdMb4WBsmm/kn?=
 =?us-ascii?Q?c+sHHTa/uS1DHUDjp92JyRE/3djvmP3BiWkqUMHdCnGCoPqQc9UqCbtXCF6L?=
 =?us-ascii?Q?kOyiulRxajEfM5Q7x9BBLPdoJ3l8WA9FbOAgn2xQJ8tXsrddPlh+41LmFhzy?=
 =?us-ascii?Q?risTp04BkcAHkfd9HQOYtpRWhwLd+5xo5n2m0Rtc/kAnX7xA4pH7Ev+ta7L5?=
 =?us-ascii?Q?mMW5/Zs+7kAhzzcAnbzJBsODVtmyICzcid22VNSRaAk0KsP0cCaCTfoA/SPU?=
 =?us-ascii?Q?B0gt+aouTfYFLuAKgGMKlPeAo13QJy+GfqdQKHRfh+e1KvmQJoJgf7dHNM5c?=
 =?us-ascii?Q?X6a/GWwseDC0PviIPsbxxYzBGEoc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vMOf4eGHxAEoejJjHS0wcU/z+W4jKU1B3HtI245H10+AKzV+le8G7lxq+cb+?=
 =?us-ascii?Q?F5Mx5PtzUdixPBmyFUToskk4NGlalh303kL2Gsk+Fh6EZt7eaf6mJoMpIxka?=
 =?us-ascii?Q?7AmPUBkfkN2uY4hJWkk2+OhJhIFt3oMSqQaTSOV7QBPg6onLqsDVDY6FCQF1?=
 =?us-ascii?Q?6gDIsP+9Fg2YSJQbcZ5H2c8GrHF06oCneDrQtSQtM/mgHnyMbTsizqUnM9jm?=
 =?us-ascii?Q?cqOriHYyGafpB4tbx0iv7zjPwcZrTzvX52FCNjU9MGYYxkias0Hm4dkPItUV?=
 =?us-ascii?Q?DmWLiXdV0uT4RZMldm2sb5oi0nu8hnSttqVL+Cxn2sTfN4+YvPVnriZKgQlp?=
 =?us-ascii?Q?gtpsjiCTlxf+jYRBj3xod4qlPx8GpH7n5FvygnC9o7A1XUI1Bw9gJa9lrayr?=
 =?us-ascii?Q?zsOnayH9unTWvbtb7IouAKo+UzbJb0QurZ6JmxhZT0XmxaXV0fpId5F/Rp/J?=
 =?us-ascii?Q?2tHTM3w0rktQ2qPxIDO3GojBp8HxTcWxGUmZ2ZVitZ3fSYYj3RtUZ47DjSH5?=
 =?us-ascii?Q?fABzkvXoUuU1eLvLB60FXPwGHyDkC/5uIsMucLSrZk3ep3eZsvI7x/K3n1VI?=
 =?us-ascii?Q?ulYvs7+fdeTm6LTO5KUDmIbmFQm380Bviygx8NlABiVyYA47UcD8hGTNXlZV?=
 =?us-ascii?Q?fzAV8eCHqSk+10YP5HzjaZubj3VstgOCrYgZQe4LytFIixTETf358+PXBYss?=
 =?us-ascii?Q?4XVTOR+w/eF9nItQvmv7QrSAe4mZvzpfi7NPw75HpxMJ/ds/tVEP7TDYkJKz?=
 =?us-ascii?Q?fe+1+PrBYInnpZIkryKADULsIp89ynTQ3IvfER3D6mu51Fm3mMjZbQxBCKi5?=
 =?us-ascii?Q?jeLmIMruF4U2jiosAXWqWfye/qNWhLyyCbaK5jd4aA5YOTsCWNL6x568XdOV?=
 =?us-ascii?Q?cr4HbRLm7qBj/jUqtyaawgH5zYXkUbj+iquQBVsywIwwPTbPntAOrxkkEN9s?=
 =?us-ascii?Q?RVar67pGw/jxvNZxu7k1Mm7Ky8u1Qtkq3uc788Jqc1/SDP0UnsKdUyyQYCs9?=
 =?us-ascii?Q?EHZM/x9VRXh7Q1C4xwgADt+DYwxlCksLABi3YYXQFkAgJqEbdBg4Ajrm4hbN?=
 =?us-ascii?Q?e6drFWC9bi1ERYAZZks5eeuOa12Lkm+65bqTFre1LL6e5K2elB/CRgirTfV1?=
 =?us-ascii?Q?o9f9qVYPLdVS47IVctBDH+DSA4UPtG5tCxub1QNAup71DcAjxy/Ji2/9YdIM?=
 =?us-ascii?Q?3Z0Pelh6L57lzEvkICx+3SzCSMcwmzBfUQruNedgXOq62qnNWyCcVbZYWjfG?=
 =?us-ascii?Q?cFsLynh4AFq046PZmcg/nLFc+Ptd7mW8iKFhG/DuiK71d4lz1iDC56gpI3SH?=
 =?us-ascii?Q?n+Ee5WusCaTN4z6kZoBdGv3n9WubLbbNO7d3/14jknJPtbvX6cBD5NT3QE2O?=
 =?us-ascii?Q?9eAScVm8vNr2sjHp3JWdLNzckxgQIlfUeVADfTMQsotSVm1OsugIvr9MIa9k?=
 =?us-ascii?Q?ukad3Z7Ha61wnTUduOe3P/rm6KCLs9l0Vq/dm2ACZJv6JfkCJiX5boqGoOtY?=
 =?us-ascii?Q?Dpp2gCKFxTWKZlyYmkzR2nozMCLi9x9MneMQavzVea+OpMh2CVcqXh452Ur+?=
 =?us-ascii?Q?tsafoIZXeOwHqpdsaaAnZXl15o55/kUtScLvsTeA+iGr03v8tC5W01hGaHyY?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xohmE4amp2+cNtt3p81pX9oCGUuOMCI6LsCkxGbam7KywEqLM6lU8Q+2SLbdVvhTUJZgcwEmFcVbMLlUJKVXHwb/f2c9FBgwGNRL0k2uomxVEKVFyYPflZp15N4jDTsZJ7byDqQBDlWpukS2zr7FZiIBxKvU9mtxXZ46epztErgWlqc0Pc7kPThWVNx3UUdK4JrmdjK+J4GCZLKvMb74R2KNxDpRFzqCASXUp3NIk4OS/Ce453ZsSWdKtwFlvjMCVDxMuPzBhBx83h1b9A1WEX40Rw3ggpvjrDdu77huCFQxBgXGIAMfqjCZGYdQHFRrCH46gNlA6c60DysXcHIGCpF4wVw0KGEvcuNb0K/wCdnOk6Qa0MWpqRAez+W729GrOuXHu2NusYMv6uUej2Z3tXMSHaNweqf4I8Zt2aIMmH4UdWKcoKhCXGvns00OramJkeDuUaAFVs6Xxp7QOKwJLqlSAzvRcZxM7u6fs9k0RDVvXXrV5lUmwZCzdK4i+w3IBP4EDM7FTCKMh5lTRwEbhFxF4VrIAHNu8jI+jCmiNcL2rfFj6FL5JJQ3023lvQ23Veb0QAFqO4oC75xy8hS+slXNvN+5iDlou97mYN5PpB8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68407d07-6eec-4946-5503-08ddf6db2950
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 17:45:31.1160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLmGfH35j8IW95pEYWxnkTHyAUUT8sPo7CWoI8pQ1MgEcTVuLmzUyeFAWNUgjQXNU04GvAwyv8FgTYA7vE9ma7HvBw6I9aY/3SJZ657HLCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=634 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180157
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX8gJ9IinCuMi/
 RPka+37gbIVxSwzjInMU2ggVNI79P0O6Kn/Wr+Sflzn8dP1RsJilgNHtCeeZlPZFuDtg7ezrLDG
 fn3xUnN9pi4nix7o6AO5DzJF3Yzf7eUMngKQwYtwlKnCM09tW4R69cK8V8KvlZy+fkh8bRgDr5+
 ad9AK1r/LaZ6n0Kr0p/wWOkilAkOa4ZMHYhDl/Lk0LQ0xTX7OGG7PjxpSD5OOpG42JoPDTpy5rS
 isoWHrACPAv4+K4tdufv4zysAt1IgiX9KOqie2VfU9Uz8zcxvviUubZcl0AGTc3EB/FBhXLorvM
 mA5WJkxWOywxW9rqq0Ks4ToyUzRn8U4w9x0SRhvuaT+j/5BwSXVq0T3yu8tRGhBC/10CqYT7+WG
 j/4CLJJP
X-Authority-Analysis: v=2.4 cv=X5RSKHTe c=1 sm=1 tr=0 ts=68cc453f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=6afs6eU38MASH10YQcYA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
X-Proofpoint-GUID: -UYcHUTio643O_2bbKzHVca-nAc4d3ST
X-Proofpoint-ORIG-GUID: -UYcHUTio643O_2bbKzHVca-nAc4d3ST

On Thu, Sep 18, 2025 at 06:15:41PM +0100, Nikita Kalyazin wrote:
> The other patches it I was building on top were mmap support in guest_memfd
> [4], which is currently merged in kvm/next, and also part of [3].
>
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/david/linux.git/tree/virt/kvm/guest_memfd.c?id=911634bac3107b237dcd8fdcb6ac91a22741cbe7#n347
> [4] https://lore.kernel.org/kvm/20250729225455.670324-1-seanjc@google.com

Note that the mmap implementation is changing to mmap_prepare. It's the
case in point example of where we exposed an internal mm object (VMA) and
experienced significant issues including embargoed critical zero-day
security reports as a result.

I took a quick look at [3] and it seems you're using it in a totally normal
way which is completely fine, however, and it'll be very easily convertible
to mmap_prepare.

Cheers, Lorenzo

