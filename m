Return-Path: <linux-kernel+bounces-777786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0166B2DDC2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01AD0172482
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581AA320CA3;
	Wed, 20 Aug 2025 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZlA9qyQX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kT3CGxV3"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4753332039B;
	Wed, 20 Aug 2025 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696549; cv=fail; b=qmhCKYbsJ1dRF9BoaukoEg5Wr7CNczARYUmVkmk7oo2k69XTAEETLIxfGZCbgp+2sfI1/7Q9AA+9iYnogRayoLqq8seuzDZJX4WJjKyY8BvEo6XXsajfL3d8+CDwFZmEFnEi8UreaoBVTYKE0GwFD0P1E61BF1DJb3bPImTiCsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696549; c=relaxed/simple;
	bh=iv35mYmXtbQ42MFgnOXCrexyd9GItIflOEPiQRl9VJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GsXTLHkSVlLSJPM3itWBiP40fQjod+UpPB8vvwFFlq6cZCs10yAgujPC5ts0sJqO+fuyC7PHPAEhyiaUsvw3V4raeeqsDD6MeG/dILcNU489UKHb32Yvc8mlxaq+MtnasIxqPqaZG6LCYvzsbBJq2i8gwjVPcer0lzzHTplXSzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZlA9qyQX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kT3CGxV3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KD23bK021575;
	Wed, 20 Aug 2025 13:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=i7/ZVX/itJwGr5n08I
	25BfjRNKN4ysEgX55TktvFbMQ=; b=ZlA9qyQXFz8oXazYX5US87qteSkIhjHAiX
	2KftjFeoCGWrxntIT2f8VZGDpI0PREEXCzlbjiD6Pno+UYPko92MI6pr0LR+OHmJ
	8JzaZLVqsUrcfjnZXsSUw9zC18BJxNV6HvvLB3gXH/aKQhsXnQuNcOD/XDGJt6i1
	4oLGlAGOdag3yKmx/qx0rTAAfuF1r54CPrKEFeOwX8+eTdALSatQ1AcqKwd10fKL
	8FLXWUGqlpyrnICvdXl4j1RbMStiiK1So76eV1S85VhuJ+0tqPFf8Yl5iD+A0lWd
	GcVlkPS5Chl8L0KXujdWh8fDLUmxGCEd7GINZvP/tY8Twd6wl0eQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tqs9yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 13:28:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57KCmVUI030313;
	Wed, 20 Aug 2025 13:28:23 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011057.outbound.protection.outlook.com [40.93.194.57])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48my3u1euh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 13:28:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCoW6GUqCs7884zFA6OciDTmvtubN9TRdntF3fqJX3mLhBPq7ZjD0jRJOYXESeLaJpq93fwlyhNSsaHS2BiZ43hNTTlO6CKCtpmzkwyZZcHJjLRG+LyEhaEbw3ADWzkP/+0rJnFhA42Yo3n6qUeTqK3H/5paMz0sB86NXnyrSK6ANQTfT59dYXs6Ne126rxgUKtBA3yboJ+4V6r4tYaw/epY9kKgwvL0ZmniyR2VpxehRBuJe4ngTWKLP2AwMf/NJ2W7neiTO5/TtdrCjFOUsIzTE5/Debcxgip4ps9o7EzUapKZkBPZwlcz9+joUhJvkMsQ5H8THGQT2ukMAYmwLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7/ZVX/itJwGr5n08I25BfjRNKN4ysEgX55TktvFbMQ=;
 b=rKuy1/zv6lmJwqg/03KTb3LvNxkxckQbMs6uP3KyFg9WW11pwczX2RJGC85EUOS82CWfWBiCDazwJDlqwZwf+uUr7hATqkOoEVpl5SJOPrwuogxf4sLwhDJP+Hv0EVbKzZJtexzoynVTyoK7YON5VIsZgzQz2PRZnGEYV/80jyRODnE0dJzHiy2xf3LufC6kW+ALRQUkf/2/TIB+9yB2RXQ5ERXxSBpiKwUphhWMLg2t351vz8f9uAafnvY+F0BfKaQzceNQx2FWigucEwh02XZL2YahDROzPGwgDNyRZN5/W0KKWXPcxEmO9zDepkAiAAz9IRm4rzbs+eQpZcwoXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7/ZVX/itJwGr5n08I25BfjRNKN4ysEgX55TktvFbMQ=;
 b=kT3CGxV33a7XUMDngyZerjI/t4OGtDhQie/vbjJGbhua56Cq1L6k9KmFdjljffZAiun2h8/5v370nAvb/ENz3TiIngKrCIcsiwn7p6x9aggrBTs8h8WYZTaQzGYuKq+6IUtiS8p6TH4v4A7x2aIy9A0C7N4VmRTyn3XI/kVW9ZA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB5844.namprd10.prod.outlook.com (2603:10b6:806:22b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 13:28:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.024; Wed, 20 Aug 2025
 13:28:11 +0000
Date: Wed, 20 Aug 2025 14:28:08 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
        corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
        baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
        wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
        sunnanyong@huawei.com, vishal.moola@gmail.com,
        thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
        tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com,
        jack@suse.cz, cl@gentwo.org, jglisse@google.com, surenb@google.com,
        zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com,
        mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
Subject: Re: [PATCH v10 04/13] khugepaged: generalize alloc_charge_folio()
Message-ID: <08cca28e-24b0-4dc9-870e-f328a788a454@lucifer.local>
References: <20250819134205.622806-1-npache@redhat.com>
 <20250819134205.622806-5-npache@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819134205.622806-5-npache@redhat.com>
X-ClientProxiedBy: LO4P123CA0436.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac22bec-4831-4efa-a684-08dddfed68b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6r493J2qhTHJAVpRtqesCDXWduaGx9Le7LrqG3G4vl9L67DO0jCBfx8TBKzG?=
 =?us-ascii?Q?zyrtlUeKqQsu9t0fpg0ASFvwuCRD44pDKc4RbwMEQX3n72axWTz0qNSqEgk7?=
 =?us-ascii?Q?Cx9kbshzMqdyWUoNip/fpAgyj2/D3DsOkuNo/O3ku09Qzzpxn09OzGCCHb+t?=
 =?us-ascii?Q?0s1j0dQyRInjVY26AA8XLRt1VR3IES1FgIJUopntUHvfNItKIDqMTepppFjB?=
 =?us-ascii?Q?n2UuJqM4mZl4us5qcJuZdJe0WiKNecZCbNaUDKMWQAh2ZTmhA4dbym44VcG2?=
 =?us-ascii?Q?TCjKr1cSNgrAvX82W+Q1YVT/WQtQCPvJoDNXjPB+xbz8/nBqDSXl8JiccFo3?=
 =?us-ascii?Q?+lfa5pv3oo0YTIJ2Ezi/SLQePeBqOkzr5I4UELud8cjUN/xZbi/E+8KxqjAs?=
 =?us-ascii?Q?TYm7gsGo1kHIHhCmZiNGdYX7pCHpsX7ABOBgZgr3pKHFV/Y0MIHI5RZk7g/r?=
 =?us-ascii?Q?aKW24UYn/ACfT4adlqJ5VYopiuDxJQ3bjSnaOPD7/F7O+fbZKUshU5cXjHcd?=
 =?us-ascii?Q?Op4QtEYlCnoyNr63EpTZM/hKSgdJGgGalEZyzmGmGsEOTcZEe+AoFANjNVs0?=
 =?us-ascii?Q?jQ9M5CcE+lqz8dku87Xrd2VgSHqOdX/tXbYPaaxKftAeirF7+sSRyVxh7Nte?=
 =?us-ascii?Q?29qZCAsmwRhEAnIxZmLxrjp9c7Lm28YTYVrxs6QLHV+mYdIOto+Mr3MAXYhE?=
 =?us-ascii?Q?QSQUyO/l8dMFDrPsu11zy2CVsV1Py7jXh4PpGL7t9J7dQRnEKEZjjBbZbCyZ?=
 =?us-ascii?Q?xmQv6Tux5Pci9OnDu/WRI50g5o5FncYEfSjPd3ZQSn/awlZ7GW3PQ42d7+cf?=
 =?us-ascii?Q?X7HSgDI/oQBI6K0ZJffpCUxhbks6YuzpMnLNra2zpXbuplhuJlgtosaN359J?=
 =?us-ascii?Q?K2WXg/JSzhsf358+qx+1B3kxgvZCBDNY5uae4Ym/27sVJF7CbKnpiNDliBdk?=
 =?us-ascii?Q?AtHk9YDwZZ/ODPULL7teQHpkSBMqyKOjZXlRaQbI/kPGcBUgkgtrKTKoFY00?=
 =?us-ascii?Q?mpFqh1YaeJka8SMZMX80+lu2PNzwu1ETHZfNHHdr17WXFKygdCofZ/hOjJZu?=
 =?us-ascii?Q?8kkaEMxL/xyhSt4BOJi0dsdn0pNq3DUBvZRXVLYOtQK4UxGLvxZcTZnwW2nR?=
 =?us-ascii?Q?d/2jMfQWjEb6LFlAwVEjXDyLiP3t1Hk+lb0Z6mrFQSvq0YzUlwnb30+tCwqn?=
 =?us-ascii?Q?+0Kn8OrwxmCk+mYYGuYjRy2MH1x9w5x4IWI+VXvuNKZKnmxdRJTXF761Q9b9?=
 =?us-ascii?Q?DiKW2DGp2cRP2tbBTVnakfspavBD7avg2EqPz3m462ye5uQS7iqyA33VbQxQ?=
 =?us-ascii?Q?/e6gxACKnX0G6KwyIKBhkPrJfTE0hZ7wRnHUQlRwUHnJ6479jcDsk0xA9riN?=
 =?us-ascii?Q?6mysqawUUn64vd01tsIlO6bU6zrNxAvGL+piKT7IHKhrJ+EA44mMhlyARARY?=
 =?us-ascii?Q?BdvMs8YPSZs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d4XlEcVT//kf/21RgdSl5N04DvRxyrkqHpsrji3IyefSrEDXh/p8n+KTK7Bo?=
 =?us-ascii?Q?TK0d71p24majM2pMUSACDP+s2N92TkUUwNjy+aNsu9c8UZF38dmLdKFlDeAD?=
 =?us-ascii?Q?dfVWar6xZ91DInlAreSpl50o6QfU9ehBfaRsWh/Ls47tcfYRpBTke5z8ftXu?=
 =?us-ascii?Q?4UN+YPz4s1pR0FhsWd2eDMBuqZS/PgZo8n4r13uzJyhdEXyfEFJGec1X73B0?=
 =?us-ascii?Q?QgLY5FxadDyaQjHrp/WtwLSKFv4S01YN8RHKncFJF5jk95OeJGtlIT2WISlE?=
 =?us-ascii?Q?jSlvef2My8xPlWoRXE0xlnE67LJw4fNC0hf5D1jydSVJmMFCb2H79yKuRcAs?=
 =?us-ascii?Q?0hRPmSOGjaDf9wBc3bnt5ttZntT31qBcaKUpZo84rDfztRZTRe5UN8Foknzb?=
 =?us-ascii?Q?3kSrnI6vUcDHT1+EQSYE18gNYfb1qLVtBdvtWByi7vpAoI/9nhQ6SUsojlbg?=
 =?us-ascii?Q?cWDNMPGweuhfRbzW7RF/VGDuecE8Lpz3nFJ0h7skBiofyVlo/4fRTcBbVwXn?=
 =?us-ascii?Q?7MdmJaSbJQKWdntbNzoOc3SsXjn/VKVBMPK1MgJgb/tWPIgGwWTwk1o0giNQ?=
 =?us-ascii?Q?cRWgdFWtgREr0XHXKiZ4b7wYI5Wt/XuKVT08CN65eeMWIpPnR1te8Bv7MZmH?=
 =?us-ascii?Q?bIOVX23UDbIeuu0692NqDWr0GvsZc+Gg9e7u6eJ7KU6g+I8GD1PEryWjPE4D?=
 =?us-ascii?Q?APnpOsHh00q04QFaiQYdjNL+MVu8IkwsuhjEn9hiWDXUphzc66sdjhpQchSK?=
 =?us-ascii?Q?+OtjFQjYtpoTN8KlmwHDU2d8cyhf4aZvbR+4/Q+yOG7qB+lQEMCi58gVQ7U5?=
 =?us-ascii?Q?FridrCPVK7J2JEXkDENTD9ovLU5JhYTPhSQoLV9oWzpv/mXkvPgotjyExzfW?=
 =?us-ascii?Q?uDGcyVJCGkkMeNXaGXJI+4eo5Rg9k0ikNOJmkKEnHP1PkpbdufQndbDeTau1?=
 =?us-ascii?Q?RtK0sld4J1DYaZvKmUHQg1hXFAWQzKpdWiwUx0cKADOwYhsdRzglpwfYBLOy?=
 =?us-ascii?Q?1U434OUBSe+o6obqGC55ASYv7h9XtlZQplpcGS5ZTu/tniQ7cewm1+q8Ud3n?=
 =?us-ascii?Q?jreAS4+QVEA0o4S2jwE8FVhbDY+IT3Uf35VE2kKg0fva04n7FnhtxBAZTY5S?=
 =?us-ascii?Q?5uLrdViDkevmb9QJZXhqjxQPwnTsAZbp65004gZ7Q1AQZ6msbwqtyAPLpxY4?=
 =?us-ascii?Q?SXowu2ZiBmZfvgbAiCrrn3mhgaCsCwayvgBJEoBsLuF1JOYYf196g/a8u/06?=
 =?us-ascii?Q?9UtpW80wuFwCIcnbI7ZHa1AnmwTiHIIwPLzsB0Ktu2LGU7HVsTc+FY50SD4c?=
 =?us-ascii?Q?uvkj9h2boezQ7/4uZ6XKD8InA2ONgUsJzo9+iusenGbqi6DTweUGHoR42u56?=
 =?us-ascii?Q?rI6W8EsuBn55+NGMjs+9Sb+G99gFw3IG/yy/OGxMysa25IWYgniXs4rD/4Ti?=
 =?us-ascii?Q?lLpT8tfpy8jlJP8vo+MTmeBbAmSK9Lx2gY+V6hM1BOL+G7jCdiKDGz0pD+kJ?=
 =?us-ascii?Q?p+/QxFk87gwcbVSsdIhvIuwvb2xhZrE0wGJo7AavhuHLJ5Aq9FAVGgpCzPdY?=
 =?us-ascii?Q?cYuxPptLz/qckxoYeNfcHPxzNcaTt0uFzY4OUtFgPY8AftC20VsL0rWq+u//?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h/c5PtuGAFXvZ5fpwu9HMRva2kiOdL56fZE7d8lJrEJXCjTnE+rnxVa8VVN5JljncWtjyBbkHQvfnkZUGJcnCj1zuaTr1CL+DIFABtuUVwBPpRxGQrvY6pKui67jtVNNl8S/e+71PpboUzlXljcZB9qp8ZjOUbBqfqddAmRb2EAUpnTYirLup9b7c3aVpzMdgCXwLdrVRpLVywu+Qxeizdp8njzTVXuSyz75yY9W65tmYXf3aOfuo4WK0n+G80UFM1g+anETSGo9nZRhQHb6ORDClvHNzIZyDLOrMCEx8gqF4FXKtvjzZb4x3ezsP4ENVPWRbnHt7pyCbYVHI1BoaStSz5Z+1tb9jKkxSkNGCWEIyXis3uThVkY288LfxIheoKut9wh/7y0T+xVB8oaBkiQ7GI5XGp73MSjqO4izB36JCkUPMFhwwdH9R5i9Cv5N8L1GqhfOPf9mS8wwC4BwUNnbg3Yf8Gx4fjCLL6dMy4mXksuyJw4oxUb16TKdNC9bmP6M9RhKB3D3Ve7dYlxafoVXJZ9hsarMrBZRQVDSM8I+VP1O+hidU/NErcC9I8ly05AoObQ8aeKD/KoX94/mKwHeOjTVLAr9lYqrhT+xlEs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac22bec-4831-4efa-a684-08dddfed68b2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 13:28:11.3954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NLIviNmWY0GoBch4IUs70ELrVm0NPfk62BXt+I09gs1Vugx18IFbS/oLmL2A2gMUpQnMTKI6sYnerzLwBqmhLelVNuQdGPhZ15uBKCH+G4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5844
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508200119
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfXxISPH/ome4/f
 zwMV1vmh5Bt0hp8Pz2smycO0QZr7QYGhUhE4rNwqYofEYpIVzn5eH64xfRPS+OLt9Gph8lS3AS6
 9hNayQvELjm2MNgAA9TMNVb8TnNkIOe5T53PvmAUnYRu95YnmfDbfccZO4usIrBILKt44gEkUCv
 4pouh/EX0v5A4HG73wR/0pKVafHBm3Gx54nguJE8KO+fmOc9peYAc6oCwze7icc3UgC+HsQBD2H
 8ym8+IVZVH7SYPkvTXcyYLxCK517blM0Wsb9ls/AgZ6xMeYMyufnfmUbjPf5Yr+0GFEjWiUc0eL
 ixOl8jJREoWyGmLcUrmC3IxFUJsc2Dt1V5V++24ByGWUwTI32qAz1ylptplc6VN+2/fetw5U8vE
 IzlDTTlk2WZbQ7OiUmGYU/qhy02v+H1yw7CtJX+XtR7mi/+0Hws=
X-Proofpoint-ORIG-GUID: 6q2xKIPypQuWaDGYmzYy2hK9Hy76JlTh
X-Proofpoint-GUID: 6q2xKIPypQuWaDGYmzYy2hK9Hy76JlTh
X-Authority-Analysis: v=2.4 cv=K/p73yWI c=1 sm=1 tr=0 ts=68a5cd77 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=7CQSdrXTAAAA:8 a=SRrdq9N9AAAA:8
 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=J81bwLSWdHHFWAzV91cA:9 a=CjuIK1q_8ugA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:13600

On Tue, Aug 19, 2025 at 07:41:56AM -0600, Nico Pache wrote:
> From: Dev Jain <dev.jain@arm.com>
>
> Pass order to alloc_charge_folio() and update mTHP statistics.
>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Co-developed-by: Nico Pache <npache@redhat.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

LGTM so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  Documentation/admin-guide/mm/transhuge.rst |  8 ++++++++
>  include/linux/huge_mm.h                    |  2 ++
>  mm/huge_memory.c                           |  4 ++++
>  mm/khugepaged.c                            | 17 +++++++++++------
>  4 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index a16a04841b96..7ccb93e22852 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -630,6 +630,14 @@ anon_fault_fallback_charge
>  	instead falls back to using huge pages with lower orders or
>  	small pages even though the allocation was successful.
>
> +collapse_alloc
> +	is incremented every time a huge page is successfully allocated for a
> +	khugepaged collapse.
> +
> +collapse_alloc_failed
> +	is incremented every time a huge page allocation fails during a
> +	khugepaged collapse.
> +
>  zswpout
>  	is incremented every time a huge page is swapped out to zswap in one
>  	piece without splitting.
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 1ac0d06fb3c1..4ada5d1f7297 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -128,6 +128,8 @@ enum mthp_stat_item {
>  	MTHP_STAT_ANON_FAULT_ALLOC,
>  	MTHP_STAT_ANON_FAULT_FALLBACK,
>  	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> +	MTHP_STAT_COLLAPSE_ALLOC,
> +	MTHP_STAT_COLLAPSE_ALLOC_FAILED,
>  	MTHP_STAT_ZSWPOUT,
>  	MTHP_STAT_SWPIN,
>  	MTHP_STAT_SWPIN_FALLBACK,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index aac5f0a2cb54..20d005c2c61f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -621,6 +621,8 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
>  DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> +DEFINE_MTHP_STAT_ATTR(collapse_alloc, MTHP_STAT_COLLAPSE_ALLOC);
> +DEFINE_MTHP_STAT_ATTR(collapse_alloc_failed, MTHP_STAT_COLLAPSE_ALLOC_FAILED);
>  DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
>  DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
>  DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK);
> @@ -686,6 +688,8 @@ static struct attribute *any_stats_attrs[] = {
>  #endif
>  	&split_attr.attr,
>  	&split_failed_attr.attr,
> +	&collapse_alloc_attr.attr,
> +	&collapse_alloc_failed_attr.attr,
>  	NULL,
>  };
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 2d192ec961d2..77e0d8ee59a0 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1079,21 +1079,26 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>  }
>
>  static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
> -			      struct collapse_control *cc)
> +			      struct collapse_control *cc, unsigned int order)
>  {
>  	gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
>  		     GFP_TRANSHUGE);
>  	int node = collapse_find_target_node(cc);
>  	struct folio *folio;
>
> -	folio = __folio_alloc(gfp, HPAGE_PMD_ORDER, node, &cc->alloc_nmask);
> +	folio = __folio_alloc(gfp, order, node, &cc->alloc_nmask);
>  	if (!folio) {
>  		*foliop = NULL;
> -		count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
> +		if (order == HPAGE_PMD_ORDER)
> +			count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
> +		count_mthp_stat(order, MTHP_STAT_COLLAPSE_ALLOC_FAILED);
>  		return SCAN_ALLOC_HUGE_PAGE_FAIL;
>  	}
>
> -	count_vm_event(THP_COLLAPSE_ALLOC);
> +	if (order == HPAGE_PMD_ORDER)
> +		count_vm_event(THP_COLLAPSE_ALLOC);
> +	count_mthp_stat(order, MTHP_STAT_COLLAPSE_ALLOC);
> +
>  	if (unlikely(mem_cgroup_charge(folio, mm, gfp))) {
>  		folio_put(folio);
>  		*foliop = NULL;
> @@ -1130,7 +1135,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  	 */
>  	mmap_read_unlock(mm);
>
> -	result = alloc_charge_folio(&folio, mm, cc);
> +	result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
>  	if (result != SCAN_SUCCEED)
>  		goto out_nolock;
>
> @@ -1863,7 +1868,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
>  	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
>
> -	result = alloc_charge_folio(&new_folio, mm, cc);
> +	result = alloc_charge_folio(&new_folio, mm, cc, HPAGE_PMD_ORDER);
>  	if (result != SCAN_SUCCEED)
>  		goto out;
>
> --
> 2.50.1
>

