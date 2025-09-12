Return-Path: <linux-kernel+bounces-813612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A76AB5483F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB2E1BC4D5F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DD6276028;
	Fri, 12 Sep 2025 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FeKOwD9x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IVc5frCE"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CFD28E3F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670488; cv=fail; b=K4/q16SRW+Nl9Z1XrkZ5BjqJO/44vKUqLiRhQvKoMLBEFzLuqg7PkfUkAqCNtqGBTxTk+FDrSXuTcku4dsT6krmtcLs5ejuqq2Xa31h9d2vO++QrD6nZjDAq2fuOrUCJFCSXNUq4RYNBHbrEwSDra2KMUT3SzSodEVQO0/FtWho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670488; c=relaxed/simple;
	bh=IL/6dQ9HhcaG/3VbGSKAd6RQE62QmxhaljbOKcZt1gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yrv1UeyJhQEK8Fm6FzYRZXqsOdpvVK58Ht86qDsmVX6FcU/wLZ23bXqjmjtFM/2fpHffgkxDxEIHOgvLO8wBKH09iU13uY8AqS/RQR6ZdQH5sxm0xdtl3e24IRclmhBCClg92yMz7A3qdqTwDTnwmifBBa90Gm+1HP4LRtbV9ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FeKOwD9x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IVc5frCE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1uPfI022740;
	Fri, 12 Sep 2025 09:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=wmA5zG3gCEpdPQzhta
	62GkJ7J9z8MkJTi3y/KawEdGk=; b=FeKOwD9xo7aD85F2aGu3jA5xjNN1tlfPdG
	Wqi1vUUIWsoqYSka3/nhGXeYEXZM97DisoX36IcuZn+b3owQ98K8FBPTpGKAqu9B
	e/EsFEvzjwauqfMkZoKemF8YBI1R/iINN54XFivj3b7BjR4uQna1HaO6t3x7CW/k
	Eur0ZvLOtcW5vsSXq4WjzCiLBqhpaO3xkFkS+sZ1paOYilD3qlrQgBpJsR+GST40
	mN1EQYNOlMPqVdM1SoIVDpFIGCc4VjlcQ6/c8RzniY2wt2+vBY9Ia0y3xNIXmDLj
	llHTKEN66CYzNhUzYagq5vIbt8Wi7mJe6wr3wjxu5f7EWBADqGsg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921pefxft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 09:47:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58C8hMAV012835;
	Fri, 12 Sep 2025 09:47:40 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012061.outbound.protection.outlook.com [40.107.200.61])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bddu43w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 09:47:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gv8qThu/I4CaWMYadivfvGs8aYBsjHpTVaTn5IqBtSm/5XB7bgnWm3TDBpbW1Mr7wsEafKT/BhXUsbzltEDW+6KtDiy6iZ9UTt0+Ja+mgD6zkERmP8mHYstjjuctYSwYdDIBQB5wQp8o65ndh4kQYKR2q9RVwzo0CqanoCN1pAHtfWBWsZe7agxZiMdtyg51a8i8nzJOCG+qQiOZgOCCZHz1k5/7OozACov1NfYrsEE7DSks5Zp9V0nm1OguabUqXMFiUtiUUvWVhKErqiVRXaezCrHdIguudLQuI135ZGodeMSMCGoH8fHRfo+RiKr/rGDhtsq2vu2FIUXXawdkFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmA5zG3gCEpdPQzhta62GkJ7J9z8MkJTi3y/KawEdGk=;
 b=neLerIOJ9x/FVYH+Okx4PWNjN4VbvdG8K6EuxmHLyPsGu67Mt6eVKEouSd068cRnKA0WAJUPywubanJZKnrHHya1O6DdtS2wZnSntLQqQBajUYWas8uels4aNec6usc32y+L7+T/XJAnRE/mb9Q6jyoFYZvwrlx1k/0AEJyzj78n4giiTaUt4o+oa00ViohBDjEj9b/KgXHQ6oYsNkDSZykx3HJARZxrimpCfZcU5djC4oakDoJUa/Lmp47OqrJEt5nLMJSZR/T22A9Pg1OHFfQ+dP4gMPfLupiZRquvXXVTgLvzddWHHavHQ9XtVMu1duNunmyvONTVNmiRLpekQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmA5zG3gCEpdPQzhta62GkJ7J9z8MkJTi3y/KawEdGk=;
 b=IVc5frCEkBe8m59DCHrHisiaE4+U7zj3HVImElnuLDKrWOBTESLy0JNF3DNv+kaIraCNzC2nhm/XrGAqaAmWtryGnLnR0VqmBHaCg7+vit3pIUC7VCj5b05MUn0SjVmQZyht/lwUUAYzj8ZckSDRD/rWaC9EeqhEUyKC7WEhtXY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO1PR10MB4530.namprd10.prod.outlook.com (2603:10b6:303:90::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 09:47:37 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 09:47:37 +0000
Date: Fri, 12 Sep 2025 10:47:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
        Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>,
        Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Hildenbrand <david@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/15] mm, swap: use the swap table for the swap cache
 and switch API
Message-ID: <32503f17-ab9e-480f-9921-72f20e3e4c4f@lucifer.local>
References: <20250910160833.3464-1-ryncsn@gmail.com>
 <20250910160833.3464-12-ryncsn@gmail.com>
 <CABzRoyZc1zHHy5eFaO5hRY=bM36xsk3COd=r18KahmrP11tpSw@mail.gmail.com>
 <CABzRoyaAA3D0nfkQcBMjZ7crUckJXXpGmYfmq6ojQC+BQUigFw@mail.gmail.com>
 <CAMgjq7CtYpe4sEYaw2carqGskvchV9Z+1yn2Wa3nMP2VguV_eQ@mail.gmail.com>
 <223c560b-0234-4203-a11d-661656317808@linux.dev>
 <d5f84730-c7c0-4059-a5b7-061a9eaebc5c@lucifer.local>
 <CAMgjq7BbYmTCmA+NPS_jQ3iWM4DJR1mkDe925qTcYOMzbGwnGg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMgjq7BbYmTCmA+NPS_jQ3iWM4DJR1mkDe925qTcYOMzbGwnGg@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0470.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO1PR10MB4530:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d9ebe7-2357-40dd-d2fe-08ddf1e1684c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gtAjL5QmPKZhlY+eXuUsslYO6aDKLozvP3vN2SiysU5oyMraGZfwOzdaZeGy?=
 =?us-ascii?Q?yxYMT8S8stWtpQh+yOUvdobNVoTyz0UxQO1DWaIqCrxYq2eKFsjH+RzJG6vo?=
 =?us-ascii?Q?EPX2Z5c63UN/wi4/nt14H//1mpDOHPwBmV0p7q8rj4fHnqVadxn+WA2dK1pe?=
 =?us-ascii?Q?qqSm3wWE3nKmff6OzwFsVJN6MfRK7JPJR/yM/4zcke9/QUoHN2PqmxpU8EtZ?=
 =?us-ascii?Q?fe2pL/5rVC87QD/CvlmJBNTifDgTvIMZJt3BGe7TqJXTfzjW1FXWbJ0Pn0em?=
 =?us-ascii?Q?pQ3xq8UlS8WIQzeGQHUjm2xH93Khid7A/XRWi8kW/vz5QoHS0J6tNdpfMyks?=
 =?us-ascii?Q?JGrxfnkWgKtAI23j+5derWozIxTNl4QWrMPvCMtJ5QOvnCnmvUXNNcqvqK2q?=
 =?us-ascii?Q?+bVRmUoKb9hYyDkTjJVLbwktvENac3uT/y/Vkx3k24olY2J0GzwvGWnzZC6L?=
 =?us-ascii?Q?nQxI29YddgrO+vRguMPZXBLUKz79Nwz9QUg8pkUm8nbNc//iCD2gEdfmkZIK?=
 =?us-ascii?Q?f1zI1WHc9+ZHDqaEhZ4Pbzy4j6P4zxOosaOJHK6WIFDPxlY+2+ygbU/abA1l?=
 =?us-ascii?Q?T+RMwxmecJjIMCU0pXgwhL/U0Evo72qfdyoDpPDnsEXlqr/hDY62Aqg6T7kb?=
 =?us-ascii?Q?myt2B1tqzMU5A4uSag1Lyrja72gBlLLg4X44c5JbwnGAkJZmNrJTo2/dq9JX?=
 =?us-ascii?Q?kmGdbutctEVrb+3RjR2W+ddcERareVe5xyp59GKpK3FJEJjgAkBBjXVI3H2y?=
 =?us-ascii?Q?eOpCCSXL9vg/sIj7T9NeC4A4D5sQ9qr60gT4R2Nrm+xh/dAe5+mhj3QcRu//?=
 =?us-ascii?Q?zx7PQZdSYB5svwck9X+8jlAlqArvyzKvgzmpabzn2eF5YV+6By6wfFHkVNdw?=
 =?us-ascii?Q?FpAcJlady2iTJ/vr3rUh9QiUBLOMKBT2QMVjnXt19GDXHUn/YdxHyNx1iD+8?=
 =?us-ascii?Q?IIVQIjw0wPIGtsnnBAeajOyqsuNwYqKSpcJAAOUwbY6qt/phYc55AYCGZfLq?=
 =?us-ascii?Q?NStF4js+/nV+CnrmlAAH2jEQO7We4reTAPtEgLlSYT7oRZiqTeTL8dmf5dte?=
 =?us-ascii?Q?hkvWd9ipvHdkFM5ODyWCNVEV+QmEsRS6bQ8fbU9OS7pekU6NIVeOqADCzCT/?=
 =?us-ascii?Q?6J0MQ3OHP+n6ANnPexDTp1EY2FosmxoHJ78SNl7raiLZ+q5e5Y2zsh0mBTPi?=
 =?us-ascii?Q?IYnVpX1VceR38gNdaqX56jwGDSg65c1A8ie466ie3K004zxKKNO1n/08asf+?=
 =?us-ascii?Q?5Fsu21Rm34DjSDMDuDci9Sr0DiIA9y200lkfaZ1keMrAZv3zaTeT+i3tX8FJ?=
 =?us-ascii?Q?F7btBCGnJIwuH/gS+aVSmYiDxt3Pu1R3k2n3yPTbfHDsE3uQ5dVAMtLDyHRV?=
 =?us-ascii?Q?YeVaM2+Hy4JoCbBsGWYucajM//wdCovXmI+7TMlTl9fKPFBkLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/XR0TwrgBnPUiv4VnttrMIGVG8BFk7BCGlaVdr1SIrQsjzR/9TwZAEK4Iwa5?=
 =?us-ascii?Q?x7H1m0PcGN21QqUvkr7ORwfHh4FI4zZJcxsSyEuRYn3LpKTpt4hq1S8LyQQa?=
 =?us-ascii?Q?wX7grY5LONB07dbKgZee+esp3Bu3jNW7RPjQCrvm0ht+LcUKPR7ublA0DL3u?=
 =?us-ascii?Q?iYO45eTLu1QDxy5lcU94QVgJtYMAfQNJDPWHDgkXGH1d87JqKPXnxTQ5zhjc?=
 =?us-ascii?Q?sM5g+v79DcYlNKkbM4Mh1P/Vb/KyAJMqhejj7QX2gWlLqmoTiIcEXH/mXKMo?=
 =?us-ascii?Q?Hz1UCf6+iWK0x36zqKDf7L2nHjtDeL66RIjZUY7q6jISH0PfWueCuU3+NO8W?=
 =?us-ascii?Q?DN+EqxNWLpoXoJiwHncbaeaPPhau7ux/vFWxw9g44IWYWpWBaIlRJJ/mNLk1?=
 =?us-ascii?Q?RfYyxbg1fF2W7CpkksA9ed0H1YdNQzqUVyXgyyRXxPcnlmhQ+fp/dB6soCFx?=
 =?us-ascii?Q?zL5RwHISa+X+1co9Tb5uWYfwfmYqYcZWx1zNEXtR9p4KE1FQdhq5K2xptXtL?=
 =?us-ascii?Q?ku7h9fyDpp15oa74cJkJOmHJk8NrWs/7TnofyuxF2BYNmHSFVaO7uj2sIVMs?=
 =?us-ascii?Q?wHAlivfvmNOtl8Vx8W4C2voCd3KJnSzJ3KyPeJ6+7haLByQDsRNBIWNR66NZ?=
 =?us-ascii?Q?6fyR7S9vyOQvv87Lbn7rHcEqCGucsijeHlgmilSYSVLRp9mvgf29emBaEqlB?=
 =?us-ascii?Q?camLR1i+CztejamC740wpTpd11+KEz3GPrq/nLJlZzq8xGTuZ2kSIxoE4ZJM?=
 =?us-ascii?Q?35UQrUieaDOkY3/STcZSrIeZ/a1PmtogEUo8oGnUj6x+lDhWucNsdPUUbnXk?=
 =?us-ascii?Q?m4Wf3Ns7qcb1oW/eJQ/piwihGLq9Rg44A8ALTdVeVdzltVpbt6hMNpF9dVU8?=
 =?us-ascii?Q?ZtWIC+K5PvShr/B1I5bydp/OWIvYgiMq8WX622raJMPzPRmlyt/bDGOO1Di6?=
 =?us-ascii?Q?FNhlWvfKOFUMHwOOZSAGuNPXo111YGgHmrq19p+508ozkGya/ECwXAh5I1Zi?=
 =?us-ascii?Q?xY7y/sSljJX8Gtn+HSq8Owl/zq8ggGexpKJcxXav6zHNEYiRszbbRMV78gNG?=
 =?us-ascii?Q?TfM+fDUOlU0u+89EkwTpxVM16iBvIDLAkLJlhCjTA43X9mPaBp7uYzDVbfS+?=
 =?us-ascii?Q?ipvDqGvoiLF1d7+gpyTu7tH6pc2nLKX2xVEfe9WaeN9KvpdEkW1/psXO8AN2?=
 =?us-ascii?Q?iCFtys5Qz6PUOval2KCcqeO6NNo12i/JWFssy/1gLPiW+MxBh1TzQopi1Jly?=
 =?us-ascii?Q?BJlOrYUH3yTtp4x4rllbbxW47x8+E9AdmN524zwLQK6qhSEeKQ9wy2XVQwp3?=
 =?us-ascii?Q?qACoqGQa337jHxYDvAB+SCenUmVvR1WPK2uYeOV6AZeGaOhT7icf4kKISk6i?=
 =?us-ascii?Q?oZJg8HomimRsoD2ArMW+Z1wvghnVM/Ak1jgt/PAcf8ExQeUBAmYBJV410l6G?=
 =?us-ascii?Q?mF3y4kqjhSwIAbxVfYNZ5jxwjnIPV8f9V+6BnjJV41ljxVKaZsvGVSZ17Rmi?=
 =?us-ascii?Q?X4S5LGtIkfky9FbqK3GuBLuDGBydtqq3c8qDf8yJJTo2eC0WXlhKtBBlPKa7?=
 =?us-ascii?Q?3dGngkEWTSCifENuF2CfJHAFfVBEv0HO/jzUUCd/h/cp8H+MkNKc15ZP09AH?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WeZxD6SHeWhzcMxPepQ8ysLHKyZbiBLAPFIOQP2d8an7RxY79+biGGo7wVWJAJtNI3HxeChPBiYLSn8/Ykn1XFjJdKJ/I4tw7jS7DY5p+KInw7NxFAF4TowLwanA0lXWp6JwjKXGTz6RFMOOJLRoJ1u3nyLQUO7aVRrDsCp4cjvfRp+Ph0o/uvW2cAaSnczwCOdDmZdrUWUIibYqXVIWVI+IBeSwKyvBtqIRXEO+JuNV0ad7RskpBPw6LsGuo1XtiYv+ZDOjyRTVW6kQ68WGSGMt9G997DFWguH0Lh254lVfW5Xl41LYP5geFMNRq6cLqqT+sFXwlMyal4Tdo/nDn3YFxycWkLukaCoKN2SnI7iTgHVZ0sSnJDViJfs/QNHaWPnDdLGB5wIIzEX/3jzZ9GmvG4mulP6GC6rTTrSVjBKfU3kTARflbwUY2gEiPE76LuGVSV/i3KNljYg4fw8/SFOTZENh/UtQI2vx6YXJJFc+HLvub2RH9EehM+sgYMiZS9Boy6q2W1l6dl9/rb/H1kt9YVcNiuJM5LoTwqxAriNe2vb021UWdb4Lu+Ra2CXqFxqEXpd5QC+5UxwTN9vspSMMLQW4ctin3mxIZqtfQrA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d9ebe7-2357-40dd-d2fe-08ddf1e1684c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 09:47:37.6883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IW6QMr0wkyqrCIbRyxqd2k++KneAy9kePLmYGC+hDk6RpyE5g6h82pQya5jGJQRUR/w/ox28T0Ymk+25LQr89ObDgFXXOd0lM2NaKWW25FQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4530
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120091
X-Proofpoint-GUID: yhN7qLsQl-wS2yfy3GNyPX4fhep4sWh-
X-Proofpoint-ORIG-GUID: yhN7qLsQl-wS2yfy3GNyPX4fhep4sWh-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MiBTYWx0ZWRfX3fvFdpVAWrtN
 ywNb0aWQSAAftv2NQPz4U+VOetGEhojcqjWQeCSb2NaUYIlhEHqKCXmc3VgrRRRPP0bRsY1Uwmn
 3+8sK7jXQvbPCq9CODy21Sk7frLVEZ1JIMdCjUGVGUsq0yCNofBSR02oay6v09qDDRaoTLxjq3U
 2pGbFoXXBX+ewjz7nN6PtWX7n9U/tL+mpqPyR7e4xY79L4JPuS2v3EZL9Zc5JyohtwK7dyEOjmL
 tPkbqnw2Pc5QUhfX+oMnLlAVOA0QFrzZ2qt+DuS/hcqc0sOGv3upPVPChThdItq3HclT8hQ4bpS
 vGld1UMRGRBYPNeHq5raCPSns9Huv1JsgkdpT6PgCa1eaBfbKkjZd+HlQtISLPqWgQ6ssLRWE9s
 dCpCyq98
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68c3ec3d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=fYbhGPvKPZ0hst4Z:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=czuE3VdJKv-Bpdhw6NYA:9 a=CjuIK1q_8ugA:10

On Fri, Sep 12, 2025 at 05:42:53PM +0800, Kairui Song wrote:
> Thanks for the info. But I think V3 should be good?
>
> CONFIG_SWAP depends on CONFIG_MMU so if you have !CONFIG_MMU, you must
> have !CONFIG_SWAP.
>
> I didn't adjust the header in V3 and fixed it differently from what
> Lance is suggesting, V3 wraps swp_offset with CONFIG_SWAP. It should
> covers !CONFIG_MMU case too.
>
> The folio_index in V3 (this patch) looks like this:
>
> static inline pgoff_t folio_index(struct folio *folio)
> {
> #ifdef CONFIG_SWAP
>         if (unlikely(folio_test_swapcache(folio)))
>                return swp_offset(folio->swap);
> #endif
>         return folio->index;
> }
>
> I just tested !MMU and it seems fine.

Yup my bad, it's because mm-new is not actually up-to-date properly. So
mm-new build is broken until v3 is taken.

