Return-Path: <linux-kernel+bounces-789974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2950AB39D96
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D069E982EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0042E30FC1B;
	Thu, 28 Aug 2025 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sGZOXOx/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ePYEOIHv"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7422130F95B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756385036; cv=fail; b=M8fSJqul1DDyd5HDzTqklGj3ofIsA2Vr1Ky5ESztEQ+OstBV8fy0UukUsjS6qguLNQ30THRwKgQUscndrbg+KCFm3DiVcr5MtrKmT03VrDOmJVOPUUNS+yUjs2twdhXOpKS4+3bRDna4QilZJ0RLj6TX7MNs1LZua8U6/8zbPAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756385036; c=relaxed/simple;
	bh=k8dB048+gjXICA3vndxzhn4JLG0i9utdnyn78tWTaRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=keZhEmagpGVZnkyBIVuirQ9/U4sthWts2ZMMOLFZV6KgDZ37f4rbcCxpwbDz7n+pnySyo6BecqFOd8PVM6xiyJZYS4c0Mjq4o1CQlHUfSuMfTwhzi5NJJ/HNAUQGCt6a9dH/W/0lUGp2jeOxRv/yLqAehe7xndO7iWz+3L498RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sGZOXOx/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ePYEOIHv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SCgPGp005584;
	Thu, 28 Aug 2025 12:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=k8dB048+gjXICA3vnd
	xzhn4JLG0i9utdnyn78tWTaRw=; b=sGZOXOx/4OHS4F2ziq1gknnWUhxcmUVHEa
	gUGrjoy6RH59PnsA4AN6fJG7qZ56De9+sDnzzcqxRT5oQs+BgrQ1NC+u9O9tIPZO
	UCtDL2BULn2ffvUFF/dMxhTWs8+EARGKpxf005SC3pEaDY/Nn5UXCTk7/FMMC4wV
	x+5MYjMWlr3S3S1PxZBw7koJqXHZDtJ2dbVFtv83doLwEHmnoeNMUjxTycJdMRgF
	+XR/jk+dGSAfM4qPRMR9iqO2RPTgJ4zWDIpjgEj5L9v8ZKjSsHOdB9DAgH1G7vwt
	nxIXw3olFpX5xPA4Y5PXCvFwNbn9BH3c2tO71KzVMkV5g5uz2nDQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48r8twf4vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 12:43:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57SBPxxG018921;
	Thu, 28 Aug 2025 12:43:38 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43bxfvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 12:43:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATwf7BSC9imJtdnJ9d3g0kl2ElYIlnIwP6IU1ue257jwK+yFvVr8hbUXOWbpwGXZ/3hDQKxGx4jTHA6AsGnbETife04uClKhLlYEyYmlNdohTap1Av0URj3DjorCGVN4LXwWySth7LyzHFQpJu45ygIep3uomebtSIdgM7brIg4MItLcFXwEfTpIW7tEJMnZh0orV4ivVnhHuCG8S7QCeEWBAE+UVQnNacYjb+zLiSlITCstRy63oWyP11CuEQOB2CVqK10edCTBcweTtONzq+H7G20sdvtogu8glwqi39T5urIr0nqw9OAL3ZSNIQv+QzE9PG0/KrRBkHudxHkdgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8dB048+gjXICA3vndxzhn4JLG0i9utdnyn78tWTaRw=;
 b=aCxVGk9lTulirv0rWomgDXs53dJSAJHfkahUSVkwVUvLEdW/f8sEC73AQtxxiY4TDmJtF35quB3O9i/3vropcN2RV683uREVvHYIzIfuAJQT25EGizR/QMT646IhWAGseXQK0j/fpd0KSUXDVUV1x9dJpvwd8MHNA/eIoxH1s1GXJcwrdCis6QVhZCl37Vu6hNCOKfEmd8qZHReiKUGO7STeGjF1nQpmqmDeiCHoWhqU3pwXHZnmZ/jnyy6KfZRgRx0TGnKNbwp2eLdCCiIB0f2Yx0rWLqyXOhj8GWwzqRO+H8Z+7k0Gtb9bNINmgHlV8o2sevC5dqBkNfCqXZWJSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8dB048+gjXICA3vndxzhn4JLG0i9utdnyn78tWTaRw=;
 b=ePYEOIHvhQw4v3Keci3jeI5s5GMs4ef6WD2tD66dpqFRHF9ZDVRG1E4wakvcaeX1iMPqeRnDWXgidaDjnFNjI0XcfCa9ND1+98/4lme2Jt0ibGuV84OSfk/Qzd4RoyzU8OO/yHUcIVPsOxEEeJUxc5vPCam2gghDJFgEYm/4CyI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA2PR10MB4522.namprd10.prod.outlook.com (2603:10b6:806:11b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 12:43:32 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 12:43:32 +0000
Date: Thu, 28 Aug 2025 13:43:28 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: add `const` to lots of pointer parameters
Message-ID: <372a00c8-86e5-4a73-a1e0-ffb8502ccee0@lucifer.local>
References: <20250827192233.447920-1-max.kellermann@ionos.com>
 <c688a2f6-375e-4a00-8d44-6a833e3d30ef@lucifer.local>
 <27a21510-e9e8-4eb2-9e26-618c103d49c6@redhat.com>
 <CAKPOu+8DbXY6wT_8gcqLDpyZEg0=En6wOYtHX_VkUvZ_oOLHSg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKPOu+8DbXY6wT_8gcqLDpyZEg0=En6wOYtHX_VkUvZ_oOLHSg@mail.gmail.com>
X-ClientProxiedBy: GV2PEPF00004537.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::349) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA2PR10MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: 319e00dc-9fec-4b85-e2c0-08dde6307f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6DuMgl05I49dnBWSdIHvqDw/R7/YE+AGMCn4A2u+e93TFDzubfgt8OJxjzgb?=
 =?us-ascii?Q?XXCXxiHBAwQPtlyU8pNvIhcZX6yiLrRtnyuKlI0AF+Si22NZBero/c9hviRi?=
 =?us-ascii?Q?sMGhzAW01k3+fyheNhq0jqwGeqckDAzA3+mBFA5P3TXI/O1Vl0edwDMCALyP?=
 =?us-ascii?Q?itLSzRH7Q5/3I3cPlKutBc5bOrXdPbMpw6Kygt8Bv5Y6XNHPb6nkiDaI7Efo?=
 =?us-ascii?Q?w2kC3xcMfbkVVITeFIghdzhaDRcqVm5+bXeopGrv8W96B+SWDQTTh8tkzpap?=
 =?us-ascii?Q?1vzhQPzNQkD9+atCM0tF5qfWV7NSPSi/OL7gcJWuYLq56RhNyHU1RlLfTh2P?=
 =?us-ascii?Q?8wr1ZyP3DC1jko3pT9Md8rP5s/vPPRBKyWgiBZwKSyD+C14h9tDOeMadQBUC?=
 =?us-ascii?Q?4j9o8xioyQPqqLCOJ0BNX901a4rmvinM+s/IqS1cCs/0e3ofdrof1IeDDHiI?=
 =?us-ascii?Q?QeeouJc8qpkuDPgKSkz/qAruI4hMykqR7knrfr1gA25hJYgvytCda1SgpmmG?=
 =?us-ascii?Q?j/cw1Kh0xjKEx2t+jDf6NnziyO/EkcoOPuqjVp0MgsBS3gpa/xba51kHgs9H?=
 =?us-ascii?Q?Va56jaF5ZgvqbEZxiTn12iP0uGmelug8zz4KjM3WEqDHtQ1GOmdcqacuC4DH?=
 =?us-ascii?Q?dgsXfFQ6Zh3iU/BprfbezNK27Qyv0d2AwIj1fdxFNgXKtPGT5tIHrlKvC30o?=
 =?us-ascii?Q?AGa7bXfr8TsgTlW9w68xOvBXV9JVNAXp8FVLdkve2PmqmUKfBzFf4rM2LHWb?=
 =?us-ascii?Q?kSTNh9T6QgQE2Gyq5YTYiQmkIS30KDNILJbPlM3+dNL2D4mQaEAno/KHVN9v?=
 =?us-ascii?Q?CnWLLQ+3dBCUOhqZ4odF7xkO8eZJKDLCa3WEFq/OSB7SbCSEK3D4SySRneWm?=
 =?us-ascii?Q?ZOGjn1dEspQcqHdmwN/U43TSxQdQfBvWCpiRs4RAcuuuOSDfxKJrx5JflFLL?=
 =?us-ascii?Q?GMYG3/XaIDGKMEmiyC14707i3CdtKju56kR+ghOscqgryIKimij0/LAbhmwd?=
 =?us-ascii?Q?o/dXYJoW7Lo+2FqZdfjJPoeIlzqhdYHLeFUZijo9OsJWe+hbrYcqik0UvJwv?=
 =?us-ascii?Q?5wbh8fz0oKwCOJ27l0yqCgsVDniB9X3Q9RRY9MGqKTpTwRh6fLcMuEK6wjh8?=
 =?us-ascii?Q?mznxd3Bhys2elGU2qtxP1RctlYYKe/DoiQ2rkCWI6hcuhxOOdu47s33P1Tpn?=
 =?us-ascii?Q?IGwiYD9IRpmiTRY4fuRitDBGvyGJGvgY0QoA8c/D8U3XkWiMRroU7AATKcM4?=
 =?us-ascii?Q?8/8YplUrsr+CAa/1TzHZY0FLvzenSR17nNyR5W4/soHmwwInYo8sGdLamgnW?=
 =?us-ascii?Q?vFC/K/MeScyRQstgnRy9ZiLzPqCHIYEaV4gen2HIQ60S3+jxZCOb/1En7BZa?=
 =?us-ascii?Q?gOlxCV6Vt1rrPXMikw4HcqLOtffYLHe3XERLZa+hFS5y1Z35iLv073psID55?=
 =?us-ascii?Q?oA6083yrGtc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AzIQ5ZC6IMbaufxES9VsoA6JIsniL+wmXsy+jZ7z/B2amwH2GTYSx2AMvshs?=
 =?us-ascii?Q?nolZ5Ebgll80LVKqSbIZoHFOsw98Vl0/S/qikpi74lL8E02q29RVVQJRj8Ng?=
 =?us-ascii?Q?uhRo+9hVhAbnntX5RidvFUWHwtSPcHnjU3dkHOryMjhnEq1nHALnNEC42TlP?=
 =?us-ascii?Q?ae9Sa5fcNwAqg9nMndYjvpdbWXqoIp0SNBmeFTTgiVSIGgihwbw0EA3CNUs7?=
 =?us-ascii?Q?ebtBU7fD0iJa7Mo3avlX9z6aja8OWGk83ehjncaM5lnTX4RdRoO3fFV0ZJZt?=
 =?us-ascii?Q?LjtfO3f21Llt82JF5qr0w+q2crmNt1PkIigLEtfBj7T81wD540vm2pURnnun?=
 =?us-ascii?Q?qfSjJirWx9qNpJlPLYb1XOhz2NSE1nx+rzQUnhkHz0h4NZxl2FCb3Qmr9s2x?=
 =?us-ascii?Q?+SB/KqxN4XXy3j7tx+NLxLqGQUKlTIjULHBi8x84MhNciRLVqcGAPahLen/2?=
 =?us-ascii?Q?fb1A3v12BGeZOtxJwZNRrXCSe/6bq6kNSc/+i0d72Q3iVLA+mPef56cRNSGj?=
 =?us-ascii?Q?wGc3Zfuzj4tVjr05HHdPhQq5G1dzT76csZ1dRHZ46b696OUX8cywZngfHrGz?=
 =?us-ascii?Q?dfokErNibgAjfWJoo82EQVjkzC7gIA0QxxZDv16h8ox2y8jBJXhHkXQle9nK?=
 =?us-ascii?Q?1gVWNHSbfDmPmqVJWewf7uk3nEalJmnMAISadfGSMRX5D6W6kDJ8DkjUDRGn?=
 =?us-ascii?Q?lHCVlfs1MZi/GL00cQVlv6tVfplZ1Rwd8m8zoSG/GnZzFUJEaY/dgAzk5EDM?=
 =?us-ascii?Q?yQbM0zLLID6gKEL89caUHTboyqcxfPpx4cjh7PoQxsgo8r1h20YOVFI3yDKu?=
 =?us-ascii?Q?X71fFBFPDvMlmhSjS6hAzyPGPiD31gGAOCuhPf9f/tzgyT9B8VmT+UyaAujm?=
 =?us-ascii?Q?YhTelvkIUEapUpCUIvNBk6c6+W9vuVQ9ld5XHDxQuGkTCaXpN2PduxMcEdKl?=
 =?us-ascii?Q?iDdXCZcMrCh0jC83ts/qYyKuzF7SoHSk3J0vXElORc6R6eeCzQm7xRwBABSf?=
 =?us-ascii?Q?aF1+4zMp4okCSPJuOxUngIpakPm1mgzFxb4yFNu171CeqSo02pqanwDUpQFw?=
 =?us-ascii?Q?EbdRITHfoemfdVoeaRbHJZgllmtpXrV9DUuSvjP6VjYlgawwbEKy+oDNzCLi?=
 =?us-ascii?Q?wzElpp1atES8oGKcuI1mAamr7jQKLhRYcamYKSP9tass5WX2bYQj7vIYQx9g?=
 =?us-ascii?Q?dRh4YrBFWhbxTCXH/JsPmPgJCDGuTvHW0aebo+Cga0xqV+9DIw0JBnqLZtB9?=
 =?us-ascii?Q?lmw9EtbQXXRaDB2grvmm6+um4yEYc7EOuhlAuJ7FahBJWqM9oazISwFo8xYU?=
 =?us-ascii?Q?6SskMTpAiSTrZrEP7BIy1xznb5B6k+lysI1YzYiIHzHBUREYvqJXJw6TQxEO?=
 =?us-ascii?Q?JsFU+DIURV+/8WTzUMSY6Rl8T5MnzrFexFNjhMbI20L+Sn+OXuPCtA0kDhIs?=
 =?us-ascii?Q?xNJ3MFVruDzXTk3srrqrieIsDNdA8CDZPK3WlwFxyDEPfc+ZAmV5HcvxQPn5?=
 =?us-ascii?Q?Y9MHInZxPTeKjdL2oJDqJktjg3ncGNJfDTJZjKGHlaiexy2VqoL8eIL0wpwR?=
 =?us-ascii?Q?6ty9EgmgMWVxOwdGJLRDAcrRL90fOeEQ4xK04KE9Q48KobFJFc4ipc8pvEMc?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dz6MfPZHE05bS919sEQe73AirSl6C4Gvc4ww2sKZ8cVw2fRlUvApXA2zG7IQlfH4Tgle/B3XBLA764Wtc1DiC0R1dCmrgvUOs8uw1t0MdrUlPHxTPnU0o235HOwJkPykeZWUdGu9T6Wh+vhYp2OgEpifssjoaqpuEM2MSgQ5/Qlh2j2AxQbWaFyli3uN7Pn2AqghvyFfoNbmQERXE11mrrj2wuTX4Syx6ORnHxADMwpTT5EGYAVoVdiB79XK8m4ys2vgzIU3iEPyicpvRKU0+proJwb50wYxvLZMMGBwoKbMJ04p+fMvDWNDRC1ssJZLl9fwY8diA7OfxscbvIfQ4/b1gNsqQbOjF/igIJsx54VWroNcPgcx2pHxGzKw8zLA3C9r741EL7zDLgE+4NpGA5KB91AepK3uyXmPXtsgt7H4DlPlYygtn13+N/rNNXPDbrsMxfZOu/DWu76za6qKDggGGcMmrm5uc9+xCgUg/bXoH6xChTj7EKnVwBYukxzzRh20mzTX9efsQjq3BtWUMJdLCJhiiFOgFNWdsWtcOhWpkHFpBxVx2fGz9PPMecVJ+JCsY58iMIfbckOAtC/3NMVOhjcQ1xHWSd/wXqt3B8k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319e00dc-9fec-4b85-e2c0-08dde6307f38
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 12:43:32.4293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBgQOi9raTpXfuXa0ZbCiK7clx8OIvMzCenrkFYYnICcPIBmbQJ8OBljos51ZqKKYWYn8SJUUIwjpnbUtP8U165huAwaZNz1ytrXOhtCY2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4522
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=885 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508280106
X-Proofpoint-ORIG-GUID: EpOaRDiV8dYySlT1vCGWLRhJHb9yM-u1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI0MDE4NCBTYWx0ZWRfX9izMzjDFbws/
 bMaf6LF9fYfyOuZUiWF0YuQpIntZKdgpJeuUmF5oOTuBx4qE8sX3j3JKWXvCU/9IjrloxHLGGB4
 EChBe2vLnThgk080dZRp9okmZRmZBQkl+4wLFgpN+fycDeR2SYhI9GrxL8+db5EkM+GkzJ1f7A5
 uSTIOBgYgWhOKdEaZ4iY+f9Yj+K7+JqHqOdJZ2RjNxWbwzMI23CMPkVdxegmxbwhrPOLX7SGFM7
 R71Ln4IWCQNQ6C4xmPrSab6L5ZHCEWTuH1gCL/uWosgTp60KWBvPFqvH2YrztSQqvMFXhULUdBA
 Rt0syIqmMaWejTZShjeYuI+ZCTIsAChsqu7/Yi3gq4RW6NV+lQH/rAT+nfWvmtwpsYjaPTlX0cX
 Wd4i1pji
X-Proofpoint-GUID: EpOaRDiV8dYySlT1vCGWLRhJHb9yM-u1
X-Authority-Analysis: v=2.4 cv=IciHWXqa c=1 sm=1 tr=0 ts=68b04efb cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=zPvGTosvFGltHA_pTaYA:9
 a=CjuIK1q_8ugA:10

On Thu, Aug 28, 2025 at 02:40:29PM +0200, Max Kellermann wrote:
> > On 28.08.25 14:24, Lorenzo Stoakes wrote:
> > > On Wed, Aug 27, 2025 at 09:22:33PM +0200, Max Kellermann wrote:
> > >> For improved const-correctness.
> > >
> > > 'const-correctness' in C is extremely weak.
>
> "const correctness" is a commonly used term for this concept, and I
> find your arguments against const-correctness "extremely weak". I

Max, don't speak to me like this, it's disrespectful and unnecessary.

> So you suggest splitting the patch into many? I can do that, but will
> it be merged then, or will Lorenzo be able block it? Will further
> const-correctness changes from others (e.g. Willy) be rejected, too?

Also this is totally unacceptable. Speak to people with respect on the
mailing list. This is not how to interact here.

Thanks, Lorenzo

