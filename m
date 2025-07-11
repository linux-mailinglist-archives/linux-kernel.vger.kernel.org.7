Return-Path: <linux-kernel+bounces-728024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FBDB022A9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A544F7AF128
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331642ED855;
	Fri, 11 Jul 2025 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KRogLPGR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dPpV9npy"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01DB2AE66
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255396; cv=fail; b=M1I9UOiedU3IyLLov/WpEn+7A0Ydal3vifoX0jWOZg3OMVCijM0BqCYYm+dMhpa6WLZeHvFA27kbHrW5LJkfmNhogdQzEcfHgkgvWD9YYKi8qvtz/+KBIoUbnmIMLRSBI+URpRXapBuo/FVs3ebvH0LsnjHMgVkcpmiARWs6NGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255396; c=relaxed/simple;
	bh=VFv7xos7JahdX2xI53cn2BdwS1kfSAS1NMsKPwE4C2Q=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=tED3fY6BRrBpKMRky0qTVOV3TZQL0+LD5eJzbWQAx8cEFdtEeh8AOIHsdAi8i0pKyGFruaXOpLlhZt6zrFp5JAxYVF+wkkHigFB1btzDqp63xuM/f4z/bQq3RUpY7xdYO+t7YQsOtRzZc1QlhXE5mFIoiXqkXiudUBCFLG9JIY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KRogLPGR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dPpV9npy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BHYrJJ012240;
	Fri, 11 Jul 2025 17:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=VFv7xos7JahdX2xI53
	cn2BdwS1kfSAS1NMsKPwE4C2Q=; b=KRogLPGR7nlKysOo8G8wvVkz6SWtyPjWo7
	q/AAm1ONQ8YZDr6iT45S0O4zKvYLoRFX/pVC310GXhtmceXDBCM7ShaH3lBD4Z4X
	OqthzUVnoeudmPX1XPPNXbFeqeYfmOkeE+O9GVGFDYweMuX2xH2i0EmEBO52i3rS
	j3bJcjsZEyC7FScWPM3W6ql+aW/R+wAMa8ON8DqteHr2UgNnbsrxglUA5xKLggl5
	ZKkxdrlZq3Di37Vc6azUbhOENb6IzPTswPQGtEriosLq5cztP0Quo7Pvq9TMvHhH
	B++oALeqUXI41pfMIy2gltM5QT3TQ08FoXy3SCWwAPTD/nGHeZGw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u6qmr1sv-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 17:35:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56BGZ59N027404;
	Fri, 11 Jul 2025 17:33:04 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazon11011003.outbound.protection.outlook.com [40.93.199.3])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgdu8x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 17:33:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRzsGyGCBeGCs+aB0dX0bM+8aHdL4GXABQcl+RBYf7ZjuaoF79wORXZ4Dv/VKa4bcl/EMFwb/Qbrtb9XXnrLJvfF5Jt6/gp9/AbKh3qaqtPOzfi0CpKgle410cQ+UFoc5UKYX9Ma/IAooa7UVjzDQhj+CIZTLGccuM9A7lXSP4L5Flf2NJ8usivYyvzlbA6kgVuXgOdKxB4E/1ANGD/RQfPQeLi8DS2qqzrQOA9sOQDcJjqlNzAivHVno7CGDxMopjHBKeG5W/TgHm0QHoM0zlaTKkW6IIVTVEGie8kLooXONarth9VYHjLtOPBBHBCG8A244wCkS+9lKfwJN73LjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFv7xos7JahdX2xI53cn2BdwS1kfSAS1NMsKPwE4C2Q=;
 b=Q1CzSKuA1zkdb452wGwJHXcORSjiHmQCPCwN0ADZBwl8+1HYc2FL3P/c742YxmgSxhNVk3v5kISItv1whnySuB7mHg412jujy5wiuE/CY8yscQs3Lpa9YBWaUNYXU+WimAY2ZlXPey4bamXWes1wMTyN9oPQYo6zmc/9PZzCHRvHOwNKCQfsUSqbXUDeSpqsRc4UmWbb2bxfAm7Tb6izPsCTTjW+F5wfUPsIpaNZ8qUbo5XD5Cg94SJMOIH7LocEWaDsn96P66d/3g8Ck9eNmEHlUUKHQRz5i6ljdPXGBVOCwfaS17jR0zdX8l1Ihd5qz3a1CtCU4/BGclxlfsRm/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFv7xos7JahdX2xI53cn2BdwS1kfSAS1NMsKPwE4C2Q=;
 b=dPpV9npyv3Ts4aTzdXVsROx55sfS+peCkuIdxtU9KwIt88D8QQesg8/nXQq0+O2bq0Xd0ARZ2b328I8R1fxSXf+5YTypu8Zm7fNHbEkpDLCBmGRRN3JOUYpxUMijD3VBTt9nNG3C7uSSZJJR4AuQeoWK+fiAb/agmsT5iVm9qhw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6457.namprd10.prod.outlook.com (2603:10b6:510:1ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 11 Jul
 2025 17:33:01 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 17:33:01 +0000
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-13-ankur.a.arora@oracle.com>
 <fe138d11-e0fe-4e57-8e51-a5521bad1b88@redhat.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
        peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v5 12/14] mm: add config option for clearing page-extents
In-reply-to: <fe138d11-e0fe-4e57-8e51-a5521bad1b88@redhat.com>
Date: Fri, 11 Jul 2025 10:32:59 -0700
Message-ID: <87qzymocok.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0152.namprd03.prod.outlook.com
 (2603:10b6:303:8d::7) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a2ba19-8b7f-4347-27b3-08ddc0a0fbd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gB4krCP148qvxY7LGYNEbWu/PA7wmgcWWZmWXfAlQ5Yu7L0hmh8TUD2XENzL?=
 =?us-ascii?Q?p3pY6CYmCiBp23GacwsU1wzxVTlceQICQ+cQq5CxPmVdCY8jSjsJ4GvqrYJX?=
 =?us-ascii?Q?NS/KE6JO9dSJn8Xs9pcIK5aUdmojBBytMrMTsv6N4C6o7Mf903ktTSXhdsq9?=
 =?us-ascii?Q?/7GVq3WIjkZDUexrihC9Ajvl8Bu51JSuypRS8gHPnAx7ZS8WED3UdLnybkJF?=
 =?us-ascii?Q?aGMTqQLl3SEG/Nz6E0LQQYo3mt1T2oVJVk2AXnjgXgtaBhRKJTB1kM7rl22x?=
 =?us-ascii?Q?mtEOFD/fwVCJHcrebsRPdq/1NPcKcF8ohtGRmQ6bRbNrQDYScNqBRCHpOL7V?=
 =?us-ascii?Q?vqT5PDuw4ph3KBtft23zOhIIwZfK9G5BXk2RJmO0eQblOH2yuzJrUDeR23o9?=
 =?us-ascii?Q?DKV+Pfg9ljNc6ZYYB6hh+2mB2LWY5HkRicYxUXuagomPcU6V/kKkdqfzzkiV?=
 =?us-ascii?Q?NikbvIxLLEurC2+1p5lIfbb4N9c0Hsk9Ks8Ibsw3gGazo6SMoHoJvAjRA4l/?=
 =?us-ascii?Q?JtiHa94hc6EfFDFtaGfMAQptUW+sNfDt+2s0/Kxp6IkyjjHsiMFWkgLI52Cv?=
 =?us-ascii?Q?csC759cBJLBVcdRlaMnWqsDBov0UpNoZ6/Pcwx1V87IwxhOjj+vdyRAveExo?=
 =?us-ascii?Q?TsXONx1BTQvS8qz6e/BcKj2bJxZe7IJLNPgzKgnRzgUhFV7CDJq7NiCWT5J4?=
 =?us-ascii?Q?SSqhJl3A5DWeQaEYJli8fgkuWxxfVleK9WKXNM94/OsKc9MEWRjiE29SaeDy?=
 =?us-ascii?Q?ZaaLBgTmjYR4d/cmLyRLSm5pxipmT1q9M4S3AkXnDn4mefh5o26OCGgjoYtX?=
 =?us-ascii?Q?rLDO0Bi7Tx1z2Q0QvDdldow0k6lqS0+rKpylUuyaWKRxMKpsU4Huo5uXOoHn?=
 =?us-ascii?Q?cdPxylFZPrLivHUFIg8hN5yrtNdivwX1AQl9avsX7zIcdpkWX+SggF5xkL3r?=
 =?us-ascii?Q?dbI3BPl/aa6kRPDTwDKfquzwArrk9bpLxoaafhdDTAtijaFZV6f9lb1t3kYJ?=
 =?us-ascii?Q?kqVvQ06rwpThGBNEztCKL1VkaL63U4XWsB7094VxCguO2oA/zu+HlXB5QDtz?=
 =?us-ascii?Q?GuwUtGuwKiE+iAG/0Q9WDpQEaCMC9M8rbKruiV6tr1LrQRxXVWUtmYDBRSzr?=
 =?us-ascii?Q?NOM3nGR6MFsMu2+W5OBFQsEO2581wVn19gNL9pwf4a46mC5HWSmq7HQGnY3J?=
 =?us-ascii?Q?aPw6n9LXKHb5OSW5xCo1Txj5FFGMU5Q9VjLS2m6GfbTx6wP0QzyroZwlL4Ta?=
 =?us-ascii?Q?fOAi/kdZoZnGA8JRglbb7NhlZdZEfHSTt7Q4NHzH3tkauOAkgvnhWAoVDwhy?=
 =?us-ascii?Q?ymN2FqYF4grkhohvQZPsOYgbTwOMM0Yms6/NLjKt+KEqdpWG0cliTMLMLpbk?=
 =?us-ascii?Q?1kDXXL/uTIC9LTqptlUb1dK4lBdk/XatgnxA2lTuVqdC5eQnFxsdZXrkOnDq?=
 =?us-ascii?Q?r2xFG9XjDb0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vtVJfHwNNBnVgDuRdmKFxV4nF6F/f8nbvJRG5yC7RWPsV6r4IpmZIL+ExP93?=
 =?us-ascii?Q?ZrvXFyoY4bvoLH8OF8pbqMyeCVUwOrQgbbwVBB756egkmLClwXoKB8zpLRIZ?=
 =?us-ascii?Q?Uy6R9+7K6rjuoNpARJOzV1QWBGhyDv+bn23FiTFTv8U8KM4m7IPcj1CNkFjy?=
 =?us-ascii?Q?83YvzNcOjXeExLMi2ZcW3Lk9+mm+v003PUyNSgpScPTS9lAabuIJ83Ttyub8?=
 =?us-ascii?Q?cMzS96uWkuguDqgiYwhFmuhj4/ior4BF1I7JRZSeaWyOtxgfaYZHvwbsgUtW?=
 =?us-ascii?Q?eUVxGHq34TMQghJL+ZJBty7Sl9r62f4l5z/ChHuAhh2q571bDa2XbvbDWkTC?=
 =?us-ascii?Q?ZkcpuLOlHns9U3sFF4g1M2QMYIPJnGAIyei7qwJIr5U2ZRCCsAsQK4Wk/w1X?=
 =?us-ascii?Q?LqdMI1VFJtVZ0uZPZx6epQaV2a4fe9IlHlxb8gEcKNCyswj7Pb4Z65vkdA1d?=
 =?us-ascii?Q?H63Npf0FzZc2G42EFPsKBvVZg9nlsPqgqb2GCW6pGq/vslP6CZqLNqm+e6O6?=
 =?us-ascii?Q?wCYjW8jwFIQzMkJmnX8OTdxx1IPHLgLG+qESRYkYzSFMUxIWgfBgjO3Bgx3s?=
 =?us-ascii?Q?wGGysAncbTAvZ2OJhBqTNO0D40jCZOev5hU9YJTmKgV6UoEM/kzX0M66S+ga?=
 =?us-ascii?Q?FRdPjaSni7/oKWsmFH5EgwZn9F0U5aE+bEhKtmjjwKSBwIftGPk+m5DMDXwk?=
 =?us-ascii?Q?vKICxQi7tTjAidjqXwDvEo8qcXD6v8H5vIyNywTaZh/zxw2F2DXv6Cl2xSTD?=
 =?us-ascii?Q?V4bq/aiGamaUCYLcOeTW6PFP6qCkRhOlMybZBLO6Ciye1Ul1NHljxYu9vXpz?=
 =?us-ascii?Q?ptpISie8cLuT+rWXcUwUbDlWCeC0d/JbMUDdvNsv2IK5DqN52fYzhup3/NDv?=
 =?us-ascii?Q?DG12x4aClQVEwJXkfGziugMO0lmI44k7SPwEK4it3yoGZNnikNgIRrDmA8PC?=
 =?us-ascii?Q?7v6wW9/REZTLMG2q0J9plD61c9J9GjoMhZKmaZIzLwDS1zNyHKbTELvfpzAB?=
 =?us-ascii?Q?cbFaP3Iq5LmPoSN0NccVQYW6KQyw3XvQjIiB3QaLcllGAd6rkzJQjc7SMm3Q?=
 =?us-ascii?Q?Q9lSHUK2ZvCdpqjSrdrlfxDfhuEZj1fwjjPy+yGZb/KJiocHvkf0Gdao6EUS?=
 =?us-ascii?Q?16Co2wSaUl0Y+vQ0uXggUR7bDjL7lTqS3CNqdZRpGFS4GDdvgm4EaiQpuHgD?=
 =?us-ascii?Q?3NiPUJWckyeDIY3hu92nH3k/e03tOX1zEpNv0h1xmvRmxQ1v8Ebl++DiWEdD?=
 =?us-ascii?Q?60dCuwh4pX1bp2oZ9MrhfkrB6QNTgYDoiaK7/ySmZCrk2gzNbpagHEIMj2a6?=
 =?us-ascii?Q?b1SJo4iHWVPaJ5ngW2r2bgx02SySMp5YZl1qjpHgHAewKNLfl6hQ0MMCRC3F?=
 =?us-ascii?Q?N0vNwm30hPx/RbjspCNKnOLagppfMtp3q0dNFPB71plm75AfHQ0AWH+hoT/N?=
 =?us-ascii?Q?BrE5NryRwLXje7Z0mhZfz6ZSWiuBgUGTq6xKG3oP/ljknErjhqLQya3gDuDf?=
 =?us-ascii?Q?h0d6dnOj0UMu5DDwCxRIVeMfa4WvWdKnftW6ReK6rSn70m4yi+1wcFolLIHq?=
 =?us-ascii?Q?IvfuxgOo1EMvrso9eavYCgeOCW1X1Cybntax8/CulvFCukjah9c0R+mT7ts/?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	64NtVgEXHbC0eLBToa40QxvSFMGl0hhORwaKl1mHSri61W7UySvFm+swz9FA1K4vbgtge6Qd9Z+JZw4CnM0Kwh9ZHNBSM6+NYLDDQHo9PgXz2uX5x50u1RfdIqrc55676pAQUKFenIWEKAtizxk2lSDVuXUxs5VYV1V+h8Xe+rSemYkPLeTurA15abtOUzSfHhv/Aeb2Xt+BtUeBbVoT6vx4Lgb6cMq5X9uYDo0pCoVItGKZ+NiT04U42NcLsveJGnXVqW2VwWxz4Da+OaznOH13xukGvf8aBXAkzJ/9mWqrKzbambD8jwL9IfL/Z/0XlKmAU/g5PCUKGYJNAbdSqvKhNMPypETbW8UCLJQuwhoJiDsMTq70scXLr3u0O06X2FGXXGhmz1zBheCDLGSkb+I1enDoSpcaGFpyNFQaLevHUmUxJpPvzvRF7Wa+SfuzQuhiCFltL32j7iRObv1cl3E2Vz1QuTwh7XYYIvYlB/moOg1eTyk5bo0U2J6oCb3feNDvFHbk4LOlIP/u1Vii5MnXsTS466BbpD5k5KjU/rpOjA1hLcgHVWhINhrSDy1AdB8Zw0EHSQlIYmBS+/4sYdjN0R2YIDWPrprDqVAbU9o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a2ba19-8b7f-4347-27b3-08ddc0a0fbd4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 17:33:01.0464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jlof7QOM5264VDAbadnHN61mRrMa2ZOIB354Ds5e3ivyz+Qvoug0Ip2Zkjzisj2VufHlBPSFGCKkMDGrjga3u4/y2O5A9C0I1wOfsqZzYdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6457
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110128
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEyOSBTYWx0ZWRfX/2FMcJ/C+pTj vIa0l1UO2y5grQLHSNLDaGa3mUCSs6YRJuOFkGFzvJ/DVFdes/iaLeA62MOpjv8gWmjbOrCN8iQ TYy0YbRiceSS4dskdWKrULeDR+BJlsDW6jhB1dPuzDeLaDe79kGiemmloOUFkjlH3frfoj08nLt
 6/L71jcVgK8F1uBwP7vFyKzC+ewrQLEnkB0LtmcV9F04G1msnBCaY/M25XzI1mKQrupv6+DROiM ErwxIpVf/EM4H62XH2mP0Ypwfb5nTwnitRKTun6YQkb0s4XcQJGDtreVvLPDgTtFIpmF4w6dxkX L8QJTtzEgoFZ7nc6m95uD8cFKR7qUm4eUJeKhSuprLdEcZEy6bWt6xwqrubS6GHnjkjCiA2t7F1
 lzxgrthOK6iB+YR8UAC9r1wCneDNRPV5Xdp0H5hSWAL2RUtiRvyuxZhuMdWnfVMZgX9mOOhP
X-Authority-Analysis: v=2.4 cv=H6zbw/Yi c=1 sm=1 tr=0 ts=68714b75 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=ZCfmum7VzfdetpSvuQ0A:9 cc=ntf awl=host:12061
X-Proofpoint-GUID: nSb9enIIH4ECgM2NaXwNfs5Vo_VG6sKO
X-Proofpoint-ORIG-GUID: nSb9enIIH4ECgM2NaXwNfs5Vo_VG6sKO


David Hildenbrand <david@redhat.com> writes:

> On 10.07.25 02:59, Ankur Arora wrote:
>> Add CONFIG_CLEAR_PAGE_EXTENT to allow clearing of page-extents
>> where architecturally supported.
>> This is only available with !CONFIG_HIGHMEM because the intent is to
>> use architecture support to clear contiguous extents in a single
>> operation (ex. via FEAT_MOPS on arm64, string instructions on x86)
>> which excludes any possibility of interspersing kmap()/kunmap().
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>
> Staring at the next patch, I think this can easily be squashed into the next
> patch where you add actual MM core support.

I wanted to do this in a separate patch to explicitly document what the
responsibility of the interface provided by the architecture is.
That said, the commit message didn't actually do a good job of doing
that :D.

Copying the more detailed commit message from my reply to Andrew,
one important part of the clear_pages() is that it be interruptible
because clear_pages_resched() implicitly depends on it.

> This is only enabled with !CONFIG_HIGHMEM because the intent is
> to use architecture support to clear contiguous extents in a
> single interruptible operation (ex. via FEAT_MOPS on arm64,
> string instructions on x86).

> Given that we might be zeroing the whole extent with a single
> instruction, this excludes any possibility of constructing
> intermediate HIGHMEM maps.

Do you think it is best documented in the next patch in a comment
instead?

--
ankur

