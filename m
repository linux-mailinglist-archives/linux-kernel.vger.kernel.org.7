Return-Path: <linux-kernel+bounces-765938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB3DB24045
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937CA1A20382
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22192BE05F;
	Wed, 13 Aug 2025 05:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fAU9+1YO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m8UgK/nC"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3865528C87C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063441; cv=fail; b=cLLoCxWi8ZzUuySnYWzJgeq4eHUMiI44EjptzOxPbm5x7eWaqqkEMC/GWPkZPlRcYfvwImPX65kKmpWr4/aF7VefqOaqpYI9AHZLi+OhPK1P88iyYPTA8nqHhIFhHUJrDEYU1nV5VpAhrLDUkwQMZYKNfwbyyZ75VtcQFxJHf1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063441; c=relaxed/simple;
	bh=ZTQ9nMHU88GSjOU8UrABXpjdFuRkaxJDt+0gJOYH2hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V0RfFbT0/ih77r8+/E1JHMt+7tF4bCBZwjJNCJ5edk3NmlrYqpEmQZFlnlZAQkQxtwB9BfY8J1svG4SvQnOaCkh/K8+fGwyfh5nsLtxB5YNE3AxGnas3VyhMseNtPfG4lHQwoIN+mIcAwZgUXR9zvcxgGDf4B9svDAMZWeT8kvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fAU9+1YO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m8UgK/nC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CLR2Uf017537;
	Wed, 13 Aug 2025 05:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=OGF4f8dcFSbV4i3eF/
	JEm2aWxtLWq02SNcuD/ebewEY=; b=fAU9+1YO+vfI0Orm6N2/gC67cr8W08ue5M
	7Fg7ky4oCp6/s11X2cid9w6mjgfaXDcMfvoJrP4vem/LhfJwmcnR7bTRAcjWvvCM
	tnjQARlPR+yiJnY8Q1jaxzcUdgIO3roTeMMJgX8XI5Ga+LLeDNkJLK+v5+ER4vU1
	GAiq3cHOliLTMemx6MmsuDeLzIPj/LuN4zwy83nObIReJJk4plXSu/jqDyKw/wio
	cflxdqNoVYDgvFmJLzPMZWSSlKEWMioeVxtkYKM0/VnxHvGSxOMhr+8ul74pjSxA
	vSGNMDADl4gaMj+adXv6RKeXXRoB6RUBtZfUxn0+kpsxuKXqb4Ew==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw44xfx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 05:37:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57D543l0006593;
	Wed, 13 Aug 2025 05:37:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsaq6h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 05:37:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDuEh+KcJqmf0fkD0jVECIIaIYcmhyRbfztF2pnhr1kMUfd9ANVQRr5ISnNL/uCmV620ObNFSF9lU5n2msFH6jA1EL5CQF46dW8oWelD1one4qpOpECbMJGSlX4ow8puKzBjTIytA/Ft14s2jjg9cTi6R0eHr+ZzBpAslVjSDlh7m6Timy3xQsH0GE32Vw1PJtvCP9YCZGue0nZIhpwilZAFB3JbWVsQxsvWD3GS4O7xfhLWxKiqRTDXwDM6Po+egQWRi0G38ioqSO3599HP6W7WZ8ZFzG+m2E4kxoQNiWHJrQKglUP+unNRdPqnJ8m5ftIc0IBGk072YrlrjcBgeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGF4f8dcFSbV4i3eF/JEm2aWxtLWq02SNcuD/ebewEY=;
 b=N6wM93pGZm7BfvDLbdcOKKMO6ocUkTsdnG37zvOx1qJyBSdu7gVy0pZ0Cd2QSA2u5q5/VL+Vy4qWoHDYVhWynRxKlpj9z+MnXXMJCs73uyzUpKdi4k7cow6tVu+KavrfqqVU6XO37hccMEOA87hQA9IV3gSggxbRYXq7u220e3UjZylOPt8DMw8l2AxbKb+twpckuiE7yTpK9EnmyVWlCZ9HpBx2/zRxuSuIOwY9AzcokYwN0aQxoIoj6SIFePrBa1yV4BnwNBa5e8QfcGiaAjIuiWeCgSMe7GqOWP5KOhKQ5ANpbaAGqsLaxJUbwNcAttADjIT+OAOpF3YP23l+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGF4f8dcFSbV4i3eF/JEm2aWxtLWq02SNcuD/ebewEY=;
 b=m8UgK/nCMkKd/jo4wgKDiuZbH/NbMB6NC+7y03FNIhTwWgbTdiHU0ARN6w+TdEJhP0CxlNHPh941aXipbsCoX8KI6RlqTJZSGOgFl7XeZlOhu93wmwGZbAltFZQ3gzJNxd5zT29fTPnjfVIcGBD8QK0uURShBx9o4vvE6L9WTV0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB7177.namprd10.prod.outlook.com (2603:10b6:8:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 05:37:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 05:37:06 +0000
Date: Wed, 13 Aug 2025 06:37:01 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linuxfoundation.org, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com, kees@kernel.org
Subject: Re: [PATCH v3 03/15] perf: Split out VM accounting
Message-ID: <e2abda4a-2f05-4e6b-b042-03523c32b8b0@lucifer.local>
References: <20250812103858.234850285@infradead.org>
 <20250812104018.660347811@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812104018.660347811@infradead.org>
X-ClientProxiedBy: AS4PR09CA0023.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b26debb-44ea-4206-54d5-08ddda2b70bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4nzULy5Y+odC8TikaJYwsj0L/qd5t5YlQGsVfR2demZjJ5TjiPg6dDl+H534?=
 =?us-ascii?Q?XBk4FmXjvTxNyUeU0jTUXTr+zpx0NbJesaNSeFugShHK6ceB76Ray674Z2cg?=
 =?us-ascii?Q?u6GDF1XczFBD2a0mEibExQ/5sCWeDg4upbWzVu+1h158pe3cMRclYn0hf/C/?=
 =?us-ascii?Q?466EAR1wmv1d5JLAuNYXRRkDlCUQuax/I/QPR6d0WGUk95AikqiiDBHgIj8W?=
 =?us-ascii?Q?ijHLLyoQa0PHEgvarxqCwqQO1LTABTfbvK/Z+t3DD7IS/o3nLVSxiBaQuIGQ?=
 =?us-ascii?Q?wc3KiILgNPs2w2kNttBZXoSEeZEJHUhDV829+qHYFogWYdECqdyviG8wLpXz?=
 =?us-ascii?Q?N1uW2bjiL1q2jqSmi/DHI+yYumvFZVmKgNspPwwFGzjUFIHdaUgQPS+YHgGa?=
 =?us-ascii?Q?rh5AfZKYxbNa4Xtx1+DPqWSQGPUqdTpI8tYAFF+a76BHZThipH84CAvb6q6k?=
 =?us-ascii?Q?LD63u4v/y07ytwDjq0T8VCXwpkszKOWUN0FafyD6eZDasGhfFaG7GgsB9tX4?=
 =?us-ascii?Q?bL2LS+U3MbHVdo48IxFkPq50q4qJSX/toDRDpRfEd5tt+fYHKA9s/WTSV3cW?=
 =?us-ascii?Q?DthMTXiYIogTwhUyKV91hRAq7AELKb2dn08KfgGIWeKN/FF0QJ2uJSJWhpZi?=
 =?us-ascii?Q?ZyO9n+0Z7KoKpY0J1m6UbYe2fg3nMb/7FowEFWqLyZ6g0crT5dgokcFF/R0S?=
 =?us-ascii?Q?zxyC7gj0HNQcRvqX0s8Bucx+MAhDkstRlHNu8xLbxzO+UfznGMA9gWtRS1Ne?=
 =?us-ascii?Q?nbLNBzzFQ0F6liXjwzyGPE5ifvoEb3cl2BZQ+l4OgW01a0JFMouiCOONV9cK?=
 =?us-ascii?Q?M55z4lp1D5SX9GY5oZAF5Mh6apbwqUG6kErrpvW6WjzwPxuYv3yjMNdRMpm1?=
 =?us-ascii?Q?CBdryoLCMqs/fctU6TFaFVX5/mUybNwlZVyzsmlkaBf7HmGSR/mnxzKjdX3v?=
 =?us-ascii?Q?Vz7k1RzXxxuzfdp6Ri4GlRvPX1ZBAyoUyEVo3YUrEzV6ceYWcdEs7P55qPP7?=
 =?us-ascii?Q?MPWXccAfDaHBvUxKoWlL/DFZMUYCnxbYBwNIpnIcTlkLOlVvfjMp+4MqCBEG?=
 =?us-ascii?Q?CgHrKNSN/yt4lLk1erkJNUBMDIlQLyqtXUVIqIUymcuVGpVod33H33QvN7cD?=
 =?us-ascii?Q?pJBLHTj5egzRMOXHYcOwAtIBFlsLr19duNDoT3uHgDvs2tW5zHwcCQr4xgC2?=
 =?us-ascii?Q?4yORTMAnF6JYpe7MQn8/tPt7aAdU8vnZ4Q3znZvKFhMqFFV3099rbvjzU/c3?=
 =?us-ascii?Q?IZLRBITEb/k/WsvwVuutoPKQToVYO3Ckm1bz3SqI9FZpgwO7ENmkHlsspdtJ?=
 =?us-ascii?Q?TvyCpgDYNrAuSlql2m7HfcFMyXRej9Le/fbsfLj4KoULIkGTUlJarAZJ/LgP?=
 =?us-ascii?Q?7gFWunA4usVurdVeHjtzHlhwPnDYahq3tSyuAwec8exhWntlsE7rCBi4wcM1?=
 =?us-ascii?Q?ZUWYPU1azaU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xQq/FuhkqCSCylx2+snopPDgPUCru3r9aENeOigOWalPHVHdfnvdycHyRV0n?=
 =?us-ascii?Q?J4LkiQmOUIwDZz7XYEUSZIcWWzixsbA6wzauHCeRWSoIu0kUG0uv6gHUhxW3?=
 =?us-ascii?Q?vshycz3sG4HeEPsPvG8HS6C0pbG8nP/IfjdiId62fiUFV1ssrTL17gmk3/F3?=
 =?us-ascii?Q?JfQzNUx9cSt0EVuUaV6p6ELNNf3T3Ctmje5RFnEFCxfZCcWsDNvBzBlZ3BtE?=
 =?us-ascii?Q?1ySCRACIDl1hQuMESsXTgbJzoLTDIJ3CmNonfVrR1S0ba8f/pkC+6yRdeVBF?=
 =?us-ascii?Q?eeDkqeZYgRarnh5ofHqjvX4phSTpfdHaKl1+pJM7rkd5pXLN8XkaXGf9ZbQB?=
 =?us-ascii?Q?c8V5qrYFK9BJFmWzlGR+xM4dkVvKxExGK6mVMhu80cswnhlSFY1AlcNZ3BDu?=
 =?us-ascii?Q?5SWiAMzIjb1mcPg4l3rwyww84WeqQ++GoJdp1qnI/mPvFZPPX6sK4JbM926f?=
 =?us-ascii?Q?nqn1LhbCeCsZA6854twtdmoFsT8dgUn+qvKLkKZzjT4p7SnkKobFHXaRWS7T?=
 =?us-ascii?Q?jCE29LjH6wL98JoMT+4rQkwqO1BQnO7piX2LPjHiuiErMfYwHWdTzotmJC7K?=
 =?us-ascii?Q?XUgxUbJzxvR/PrG6OSz8i/OccaMFkg22V2zsOsCMjA39oTai75XsktPMXG0Q?=
 =?us-ascii?Q?CBBJG0dgjaqXJICN68+0XfSPnsW6vNveCZFHEPGwPcqo9ptoyL+tSF8n1b+A?=
 =?us-ascii?Q?59Hv8aFVEButMnI0J56vSVXS5vmcLVsB36Ng9pR5RA98ZgyrWPrsgXyhceEs?=
 =?us-ascii?Q?KUdQP5++l73z0MnTy5zzX7fo5XuVj5xAOsIhgESP4U56NZaT6+4cZKb+YPM7?=
 =?us-ascii?Q?WE8gXh/NIMBdYPtcZ2YnrrI963Hn2h1M6Bb1LwEsQRmMR/QHdIDkOQZwoUaI?=
 =?us-ascii?Q?QkvFChEQZhwccA3Hf4qUejGY8MO0T1yXKkydwtAuJzT3gPT/5vBefFFXbLu1?=
 =?us-ascii?Q?ipZSNDDZdUn9/C3OdAv0CdifEaacN7RmPLg7mPxKZxKYgmSvuUOv/3z1XYC0?=
 =?us-ascii?Q?MvERrs5nlBlnk0CstpIUMjRlHjawSs/ovPzaS/6PosjV1CprVC68nRjoT+Uk?=
 =?us-ascii?Q?7qKZSVOeQ4IDMAihlMq55xi2bI+o3vZxNQmdv2f+Ey7zybHuL49wZzhTXiHp?=
 =?us-ascii?Q?uZLCbmvB1urr3K0cUuxT7zoyyKj5M2vzByWj2/oEiMSByrhWOtEd3XUlLz4E?=
 =?us-ascii?Q?QGxuC5OmMRDdIOQEwe811f/K6ON1Ri96QmyrUmJUWnIuO3NSz6N5zEJWIY23?=
 =?us-ascii?Q?nASRLx73BiyRV3+9FC1MV5RKIZH0F+KwG3D9zPIKVocr3bu43i/+dPAb8sEQ?=
 =?us-ascii?Q?7gF4NudPHVFPWRAbku93PL/ZiulKej2ecAO+/7pmJBFaRroISJSuFO1gcrwh?=
 =?us-ascii?Q?qGx51TII+xMzLJw6zdnu/p+MUMbVLSatBzxWwUaqh5bAfpr4herb7hr25hlJ?=
 =?us-ascii?Q?qYBSSW4Z1TGrjiJzsdW+qgb97EAydX78Cbf8aSjHI/kskh5LQ18PkeUYK/cL?=
 =?us-ascii?Q?DzoDBmL4hUljqvu1O3VR1FFS2+BhT/VSVLa+OZ6SG9gQxfNpCrjnYYOkNPI7?=
 =?us-ascii?Q?UnmgCG9ivUzl1cwXOk/PxiJ0sgLsUeYX0VL03dv/O8CDmF/ms8g6AgjIzU9Z?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NLIcV1eZ0sCGnppmtsUMEWermxCunObWpdDoVxNEaPn+AL4gBsUZl66g+f4R3BI9REk6DkiUa4+/9eIt0uQ3MVT59D/15ZDlacPQ0skMaOQKYZFQMt1DX+03iu2GTsZtFZlELv9kTPJOCK5hMYrTuRG+x7k7/YndQ4U4r7AGEOYXkDILG0jmL557g3VZXskU9cSttRVVr3JWE7azFjkXY9mmGyNijwNlAHxUDUiLa7MXO/U/AFYOuEQWn+w7hF2uPa99TQuDQwYk1ZOXZQZWzaK9PfxNf0XlngcL77Ix5OsmOUWFfEdZtn6/hYBXIe100miAdT+hSw9urdij8vc4jAeMIdBAc4yzPnnYWmiX3xi4anl/srKVpy+iSzSYRLUFODNFAAR4wTHUOIvpE8NHnSp/YIgq6v7lo2V1pW6MSVuNMJw6ksVk7UDDgOl2E7bQbwmvpk4oFxHk+4SqY1RYY5SOSrNc84nmj5C9/VOdkgmjcaqWcCfXnnkLw9YIPXlC8T3Q4lMj5luPqy3iWpYaZcd4993QR8/22zUKT1vWJSYWQObkHd82wTlUSKN1igXMxFtlfU6woT4gCbx1WBeL494J1LR7pKLSil8PD0qF3Ls=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b26debb-44ea-4206-54d5-08ddda2b70bb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 05:37:06.6859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EB1xr3LUz18TWpl93s2zKVHuL9gn4tWDVJcc9YA0r3GOLrHgg6r3Z6rEiTzqB9HinSPVuLFncgiMS8LUdEp0/Jp+jTy38oBKjS4nNYR+X5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508130052
X-Proofpoint-ORIG-GUID: SorRZ_StJVaK3yyqgQY-hhdeGL0Yxj4f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA1MiBTYWx0ZWRfXz8VNm85iQ0kZ
 GpbpsKW0WmU+TyqVGZ2BjzRsJH7WVXHHwGh7iVcuooX6uwc9fjsW9+hYKPwy2lAVlC4g1UKxffN
 8LafG112GSDvnB3VzEBpbWy3KssZw6nIdY0BO9fTiBoPIP+v5OII4aEEQz4uvOBmzsQ4vGbHIDs
 sloQa93itOdEx0d5Ii9rvhSnfmFJDmZxQYZ/x+2Ztx8v5FTwVrRXSncQV0ErE+3gBv7satr0+ar
 6g7aug9OUvMdSNkvIN9L4aHN1JFwAv2RUdJmnCRgMgwYmNvMzjNZC6Q9bMfFHFNlKun0djd68s5
 cLtOOcgI81r/28p7oray7QB2LeB/jXZmnmJykPkt6GbIr8V81PJ7mEHwbpS9ynow0XwchGr4cZF
 pSHs4KiZ0GYXJelGKeztx0SZtCIYeg7qgoPo0nYkss7p69BytDUw+t0EMPXM8LjvOaPb9+L0
X-Authority-Analysis: v=2.4 cv=X9FSKHTe c=1 sm=1 tr=0 ts=689c2485 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=E8UXNWPMkwP1c5fnmMkA:9 a=CjuIK1q_8ugA:10
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:13600
X-Proofpoint-GUID: SorRZ_StJVaK3yyqgQY-hhdeGL0Yxj4f

On Tue, Aug 12, 2025 at 12:39:01PM +0200, Peter Zijlstra wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Similary to the mlock limit calculation the VM accounting is required for

NIT: Similary -> Similarly

> both the ringbuffer and the AUX buffer allocations.
>
> To prepare for splitting them out into seperate functions, move the

NIT: Seperate -> Separate

And that's the end of the typo nits ;)

> accounting into a helper function.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Link: https://lkml.kernel.org/r/20250811070620.527392167@linutronix.de
> ---
>  kernel/events/core.c |   13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6962,10 +6962,17 @@ static bool perf_mmap_calc_limits(struct
>  	return locked <= lock_limit || !perf_is_paranoid() || capable(CAP_IPC_LOCK);
>  }
>
> +static void perf_mmap_account(struct vm_area_struct *vma, long user_extra, long extra)
> +{
> +	struct user_struct *user = current_user();
> +
> +	atomic_long_add(user_extra, &user->locked_vm);
> +	atomic64_add(extra, &vma->vm_mm->pinned_vm);
> +}
> +
>  static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	struct perf_event *event = file->private_data;
> -	struct user_struct *user = current_user();
>  	unsigned long vma_size, nr_pages;
>  	long user_extra = 0, extra = 0;
>  	struct mutex *aux_mutex = NULL;
> @@ -7136,9 +7143,7 @@ static int perf_mmap(struct file *file,
>
>  unlock:
>  	if (!ret) {
> -		atomic_long_add(user_extra, &user->locked_vm);
> -		atomic64_add(extra, &vma->vm_mm->pinned_vm);
> -
> +		perf_mmap_account(vma, user_extra, extra);
>  		atomic_inc(&event->mmap_count);
>  	} else if (rb) {
>  		/* AUX allocation failed */
>
>

