Return-Path: <linux-kernel+bounces-808894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171D6B505E9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889E0562AFE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26B2352080;
	Tue,  9 Sep 2025 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HkcBk0Mr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DBDHhwqa"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2555E303A09
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445037; cv=fail; b=eqvDhO2dFhQE89XxGKbljsKbgulkUDMgXY59MuMdWphfs/ISkCx9e5bRgYTx6UtLc0bpfXN9nHVVsTD7Xz/FTaapRixwMDMlBJCuI1Wr7bYShYWMWFNRcsUsOGMaK0mZYWsdPrtxNJwD1DB1ZTjGAUzlNc2qKusIQQDFLnZH/mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445037; c=relaxed/simple;
	bh=IkxOHndmxcko6JDBoOSrNfK0Fst5gE/Xn46t2a7a5J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KOYAvWAjuG17lrtEqSKGwdRx+0D9YjQkIDwXur4pGhDoo843MrjXykBxeskYAOApZg+Z1pApaZPmcrWmAJjC3IC1Y4X9exTrxJkUbR8B4iqhQSknwuntgPvrRuPCOvZaV8K892l9Z6ejenx1fd6OXrVEP651zKFPqHRZpGhbLqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HkcBk0Mr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DBDHhwqa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589Fthhl014132;
	Tue, 9 Sep 2025 19:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=g2U72sBQQi9zEVl48APizX2RYuBGje3WZfM8HgBfvUY=; b=
	HkcBk0MrzB762AobRdsL0CyNn4UVOQWF03sW1Bgd+Hodce8uvEin0Y5T9NW4FKxS
	Kdfh8ALsE4Bz07HAFJCLCxfduZizNVJ7RjiQI8ETWgw8iAk3WgBQ3coHd7HGbmsJ
	aVUS72n0SjJYuHfgnOh+iTluCrqYXRq0YhetgdC3KOiu3o/hjvq3kBrgl8UAaiBI
	zY1jot1U+LXK0JuFP3C/WwbVMBSC9gvtdzeNxqFo8Ww3dB0PJAVWDJ1yUXFhKAUx
	DyolYJoCf3cDwMoY90SQZ/wtYNydNNB77rRG6U2Nh5KM3IXKEsNXTs6HwCRfLPh/
	k7RPGYbp8kiHWzobJRzmPA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226stnx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 19:09:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589I545U026089;
	Tue, 9 Sep 2025 19:09:56 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bda226m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 19:09:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBeUwuptKW9gHzb/sYxGo6u/ghr78/za4aRQ3AY6DOHpgoA4FBTZSspHYeNBjuraTZohRlm5LoDhk996hZfsgRizWV6NiQjxDT6wd9qNn5dCdcVsBfsibnq0DiPZA78pzrZYil963Tr/K4pjS1LhuSKb7PLga9dXwocJ/4vTgmuX+LoKQUfZPW6qjn1pgKn5GE5V5LroFdUwdcUaKrDLDUyF+J1lwrsfyWe/47ElMTuZGfNxzzXwa8dturENkEwQWnWgqkTTtJzcyVu4KLErHfcqhuQlbob8abvijhRNcQ0JPWPQ6tgveJZO7JomxM8pEGN3ZXKdQ0gdzuMy+PPqsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2U72sBQQi9zEVl48APizX2RYuBGje3WZfM8HgBfvUY=;
 b=sB9vpTFpsuMnTCw4jxk74MDHHUkjCkcmHs0dCm/IG2PNcnvNq+wE7Atl7x7AUDQOc9ClgkVOBtjBYYm3god0gB4b8OaftrErim4hlWX8M+PaFELOb8YmINJ7Dn8ZkBrfA7OABkAHqM3K9yBjgAnyJu5il1znrBdkJv0e+K6HnOfFCMltpG/V8AeLUb+VycCMfjE9d02CKnhRuyEggBnGl87HXLlZEQT1ibp1sLZdhu2+2GsvhMIobZuMx4Dgq/MevBgaOiXBQTEbgcHo4VhhnHisCBAakNC6lm5rOyKC3eB3DU0ZBLBPmda3/U3WL9Dj9txlw0FBMDo/AFc2MeOj0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2U72sBQQi9zEVl48APizX2RYuBGje3WZfM8HgBfvUY=;
 b=DBDHhwqa1S9xAQ2oVMgzXoJJUiElumkyQ6yKPklfh0DvgvhINP5LlOvNkjaSvKAuqL/5Ct2BGNPCJB4SSAPDR2pAcv/rllR4TK0TDOeyYVNopO8dFbQ2UEPjtBAVkzabpPZb81EeG1MBUR6U9hDr5fF5Cqzu8WoZbyaoIu36/uI=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS0PR10MB7052.namprd10.prod.outlook.com (2603:10b6:8:14c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 19:09:53 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 19:09:53 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
        bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v1 2/9] mm/mmap: Abstract vma clean up from exit_mmap()
Date: Tue,  9 Sep 2025 15:09:38 -0400
Message-ID: <20250909190945.1030905-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250909190945.1030905-1-Liam.Howlett@oracle.com>
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::23) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS0PR10MB7052:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c9394f-67fc-4d96-5a7e-08ddefd47536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xUHJUN7S90tFh41F07UvK5AGp0T2k6Icxzgh2nkQwa2XWoZxJJhCteQNKmg4?=
 =?us-ascii?Q?N8WSYXgxVVRep7JgUWzllIVdRMNhujQt39xpBeHKCzYJUNLIitFCOy1Hd0p9?=
 =?us-ascii?Q?AzyJrLObK+hBT2Wi+xseM7LZtOOp33SAse+syX8482NDJm6APLfxqROgxk4D?=
 =?us-ascii?Q?kC5+MCF5ubNGQmEc+lpuF3w8J+cSfWXPAu5L/nWwY8/EfKubavd3D7YFAL1D?=
 =?us-ascii?Q?QR31ACfGqO9rXVgCncrLmFeqjex7UIAhIJAxwiAtKuRMV2PtkZLniOCmWrBD?=
 =?us-ascii?Q?ckOCv5hMsbpBieTYfF7z8xGDL5LJKjI9pgo4tlxg53FhXwI7ZIk3CI8/anrs?=
 =?us-ascii?Q?t0HpVLjfSbrao4hiNBVdtMWyaxc4hxtk2cwdxb27mtJcRIWTlBXia0+/Qv7h?=
 =?us-ascii?Q?Qo8Zgp+0Fld+DCpoDfbIRCYfQYdziNkRPKsKEqzAt70K4yt2MiajGdmRJxSH?=
 =?us-ascii?Q?4fsFTvaYVkQV1GMjn1yT0MN7vXnXYtcNoG/RoC5n5vuke2YLyjBYrIhMO6EW?=
 =?us-ascii?Q?4tNf4x8ZyJCWtauz/u50CsG1bOX2xI+9MpJHx/ACqEdYRBjOwgRxHr3EDYyg?=
 =?us-ascii?Q?w0CdAOYrC47cLP/05l7QQE15RDj4aWBLkveRznLlQ0FRfFsKewjkUyj00ATY?=
 =?us-ascii?Q?FFdBCwMKt9V9EYVb+V2DxKelU5iMZI3ju1KZuctBcoOM8bPb7AqnATokHTKs?=
 =?us-ascii?Q?fm8Lyex+PvsEsu6D/C7j265aDfRKwYe4tztidbHAL55rr11PoLIrhK/+ZuT+?=
 =?us-ascii?Q?C6/rb2fpulwAuppH5225fDxHgf1gOn4qsjyPaPV6jYaSnHdCGV3ziga4EmBh?=
 =?us-ascii?Q?BV4LjHqRxAFVPdyaHOaJXbRLZqDOp1YzQ2QEhYH3rn28mGZvxAvlNiGYfi3t?=
 =?us-ascii?Q?eiy9jzILCKi1ijUygBgrmya3S2GDR3eEHS9qUteyVYoiQbryHcehfLXTyLhZ?=
 =?us-ascii?Q?92W6G/x7yYl1phHVt9ZiBnZEj5HTe1uqkui//vLfnfQmYYv7vIY7v1Crf/Xh?=
 =?us-ascii?Q?znWAjAb5fvC0XSu1aJ6L3D3Zx+2sU6DWHSKCy1lIaxCUhKrB0P1yIYEi4nDd?=
 =?us-ascii?Q?8Y1aKCyVImMBDMw99P2so7TjAcU5dpH6weVR9eO9Mi9RDV17wZuIfkOxzRKm?=
 =?us-ascii?Q?N2uDmvdDGPaU6LYAr+G50pAU5na+mKSANLJJzZG8whDK4xrE1H4NlzKtg9az?=
 =?us-ascii?Q?/C1Kfzwg/hoIfgYXlkjTVwuE9o4DgjLhr3MPMY+KvEKJYZToJI4gBcOEf/l/?=
 =?us-ascii?Q?9jE1O2zjEcwP3uiGvZZIlBMW9e9Jioxf+2D5StOhx0RLE8LHq0cVZoBfAl5i?=
 =?us-ascii?Q?ghWYY+InUgNQz/llYUFJx/RsLfVSkiR6D++hJSap9vMcNI5z2nQAMS78R/b5?=
 =?us-ascii?Q?RgqJyfIZZALfuWzDpqN/Vk8vYEbU31iuocg5vMRQMc0EZhLjeAsJ8U8kVq4Z?=
 =?us-ascii?Q?Nk38xBXvWdE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G4W8ca10Wkjuovm1inUy51CVZuohYjosvaJE0cctyg8qA8qD2Fy5GLV5ToWe?=
 =?us-ascii?Q?28lfmx6e18jVnhAtXX6buEgI3MjphWXnw6vjZmwGEfYSpJXqpuQc+SPp8tUx?=
 =?us-ascii?Q?s21oG9izbp4dBELpS2BLqeLLvkZvESP7xsDcujjOmDZRfzZaHb13WrC8IBt/?=
 =?us-ascii?Q?eHjeGPw4poKCgrhtN5TnpeChukFopyQ/XBdiZbx9u+iKqzAwmMCqccAAMdqm?=
 =?us-ascii?Q?mVBdRal/cX7n/bOtjCOJqq3QiJncFbdOxIUjPVXl3Ocfx9d/w+US7+lbv+zc?=
 =?us-ascii?Q?X9/J4iAMPf+4zXLojdgYFtu175poSDurpLXl4oBclHQQ04XUo8ZNyHXs2hbp?=
 =?us-ascii?Q?MMdUXa/VWssg32BwUXhgWuOBGooszmRSs2y/Sg7eqI4vr80l3lVQbe7xLwGw?=
 =?us-ascii?Q?Hy/wjXQi/3bdUrrKUKEpY1ylg6LZjxOKHOQpSICWGM6LP+ulEO8eDWPHpSLX?=
 =?us-ascii?Q?LQcWPFd2xHEkYfFQoGIj+4BW1jSc5cHqtwYzmgpLV5ayW9P4ToMAk3i5rvM2?=
 =?us-ascii?Q?UfKJiSlniJPI5K2Sf7v20uLMZ+j3J/DJl1fE8+zZ0IH00ZWmYlunxqmkGv/F?=
 =?us-ascii?Q?Dww2kfMZOH8DX+ONT8BlAEV04n6EGjFRR3+2WTZCm6Fj0MbpGcVP5nvxRHDb?=
 =?us-ascii?Q?w7b+aZbJqf3h5JkrPQSi1XbApYH8aLhM5Mm4HKNElzli2T1xpDqzXY6sIbEu?=
 =?us-ascii?Q?ZsCJcUUZ2dULF/S4Tk4xPmgHqc7G0nftZI7KPesxJ/s8cRx/8kvK15vzvTnM?=
 =?us-ascii?Q?NahaSdd1Wv6jzM6abLWPnGJAvNJcFSjrXiEZuklnsr1XkSTN/D4NzCShae8l?=
 =?us-ascii?Q?P6sR769l3EqDuCauMRbQVpF6pqjRRS2UTbCq/bLXON9GJfrQHdlPKdZUG1cB?=
 =?us-ascii?Q?Kr+MO0S7Qgr2GbZPty8+M1Du8Nh8hVwpb9DhbJosqOZInvknDBg5p7A7oVnn?=
 =?us-ascii?Q?CwldG5d9oLaVBRXzjQOn8bXJImJnGHDIHPjVZs06uaDIbYf7Lx6CoypbPG4H?=
 =?us-ascii?Q?aS/36x8tlzC74q6xX8e0ySspgI5th48YBETZl54rjU7eIoneHUp/9K5+WhvW?=
 =?us-ascii?Q?NlMsARXm+j9dNq9N2zSAMrqBd94vsQTdZ0nWnSVQEkvUMD7B8ZQphHfXlNKP?=
 =?us-ascii?Q?2I0mgHAe4pGRzEpo8Nz9gYLfRdjigEtdZGVSo7cCoQHWllT6u2rR8TE5I+98?=
 =?us-ascii?Q?1y9c0WUhsZcYKDKpgyjOrFEK/mMJr/wuqQ7HD5Xx/NSQacxdeilfu1QVBpZT?=
 =?us-ascii?Q?adGN73ugAhmTc5sZ05Tr48Nr+z+mV5zt/T+mU3Y/IDoEleXAKLkXleQ57Q2E?=
 =?us-ascii?Q?Q7rgYNyDmZUBAaPLHKicMKgi8Aa20sBe56/OjMNkwHa3GcUnQg71xcJxdCD2?=
 =?us-ascii?Q?rzZnskB5CuQwWP/5Tdi0+FylJzafz88Z/AuLieJwCQr33SRxLgWmw87zVCF6?=
 =?us-ascii?Q?xu6q+/6mORzmII6ebEpMYJBMx/5A1hnrGxPY++fwzY8OuEZPJFOEHee9scfs?=
 =?us-ascii?Q?4gdk9FBtdBodUIDB1a4hiqGHhKHWb7ShgqvwFkuNTs8ybBZO2ApJ8LS89yZw?=
 =?us-ascii?Q?4RrlkVecJECWy+OaiaJUrKpfeu9exdI3qVkRm16Ag9IMHqayc/YD9q+9k5N5?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Bmgjc944qmFajARY+2FJONoi3z04DxmbQRleJur8ePsuOYiberJAcSQ2CqrgL+u1bIGuuCEEY0gqPLf6NaToYzQ9JzGwrNqheDnpcV7MexARg+zf13+C5DD6S1NZ7LqJpVjcHicakLK8Xr724KTL/+X9UDc0LY7pvzl3KTMeu0GdMpvNz1DZwlvOjske5m6DYpaJo9THxlmpJQBm6dwhc3pl1EW4bbIDYeBATBvjP+vH6CBe2GcpTl8qRVo061C4JCV6487FZPiac42ozd7p+wGdXjCLRGJ0KNcdjXpyKoP0nte6UrU3+YDUzfPq5ZSwPRZz+kARKNHFXVH0Jc1FswsepHXm49OFlaVpNoZBFQMltzGFCu2cJ4K977qNgp8JwZ1bDJtNPK04+zlcwdNcVaO/HZA4pcPaG9dqH9pA/RVn5ggWgwFPUtymIBmEbXqiy9J6jgXNus5t5oD681UStd0W/Yu0knBi3MCXcJHzNUwDBbYDfVr1rrMr+9wDTlO3wv5/YFVVhT86oPipyXRaN8pYmFeyGn2sQfnEIm8COIS5+B68H1ceuEo3vnAYd4e5v8nfQo3RpvkhqiuqfmC8viqQRlatWG95Zxh7ogAQk8o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c9394f-67fc-4d96-5a7e-08ddefd47536
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 19:09:53.6427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCD++dcUV2rBLiggt4tHmR2AZHoi31aVbSkYF++xVr8EM8Nq6ljuskHWdB3J4S1N2VNagvfk7uDk961BQs9Ptg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7052
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090188
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68c07b85 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=DO5yfXpT9pfNaLUI-vsA:9 cc=ntf
 awl=host:13614
X-Proofpoint-ORIG-GUID: 1Caq8_O6o30lXwB7hllqj2tpSQamxn_l
X-Proofpoint-GUID: 1Caq8_O6o30lXwB7hllqj2tpSQamxn_l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfX5ET57jqTGlED
 2zSLyeABJpWIOxczf814YQ5yFLv9f2A4S52OmPlsJEvxMfesW1k1O3Fot02Va1cpcKUEMKo48JB
 RwhwZFmUDbEsn91VBAI8va4VhDocbHiM2cG8Muc3f9gpz7CZqY2/2a9ImYnG6UnWmwBjbP3+XIZ
 EmL97kZ5csmxVvt5KhAmIKxGNfc22BD1j5BJBdd/DFO/c4eEg0vaQGGq7c/zp9tQqqHRnfpZeQS
 6iwVKcDA13USe+QR3rPnPMREGzL+xJg3+QvyAnCbjTf1f5vwQm7nPqSGM8PbM3IPylwwcYqMmE4
 N/5rEKN7RjjrNaF10P76IqBpxFo8jegpk+XvYg65n1RzdOe9+n6nN+q+OIuqqdfN+/+d72uyzk0
 6TDkX0/bCT3SpCgHE5F2pdLRP7PT9A==

Create the new function tear_down_vmas() to remove a range of vmas.
exit_mmap() will be removing all the vmas.

This is necessary for future patches.

No functional changes intended.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index b07b3ec5e28f5..a290448a53bb2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1250,6 +1250,29 @@ int vm_brk_flags(unsigned long addr, unsigned long request, vm_flags_t vm_flags)
 }
 EXPORT_SYMBOL(vm_brk_flags);
 
+static inline
+unsigned long tear_down_vmas(struct mm_struct *mm, struct vma_iterator *vmi,
+		struct vm_area_struct *vma, unsigned long max)
+{
+	unsigned long nr_accounted = 0;
+	int count = 0;
+
+	mmap_assert_write_locked(mm);
+	vma_iter_set(vmi, vma->vm_end);
+	do {
+		if (vma->vm_flags & VM_ACCOUNT)
+			nr_accounted += vma_pages(vma);
+		vma_mark_detached(vma);
+		remove_vma(vma);
+		count++;
+		cond_resched();
+		vma = vma_next(vmi);
+	} while (vma && vma->vm_end <= max);
+
+	WARN_ON_ONCE(count != mm->map_count);
+	return nr_accounted;
+}
+
 /* Release all mmaps. */
 void exit_mmap(struct mm_struct *mm)
 {
@@ -1257,7 +1280,6 @@ void exit_mmap(struct mm_struct *mm)
 	struct vm_area_struct *vma;
 	unsigned long nr_accounted = 0;
 	VMA_ITERATOR(vmi, mm, 0);
-	int count = 0;
 
 	/* mm's last user has gone, and its about to be pulled down */
 	mmu_notifier_release(mm);
@@ -1297,18 +1319,7 @@ void exit_mmap(struct mm_struct *mm)
 	 * enabled, without holding any MM locks besides the unreachable
 	 * mmap_write_lock.
 	 */
-	vma_iter_set(&vmi, vma->vm_end);
-	do {
-		if (vma->vm_flags & VM_ACCOUNT)
-			nr_accounted += vma_pages(vma);
-		vma_mark_detached(vma);
-		remove_vma(vma);
-		count++;
-		cond_resched();
-		vma = vma_next(&vmi);
-	} while (vma && likely(!xa_is_zero(vma)));
-
-	BUG_ON(count != mm->map_count);
+	nr_accounted = tear_down_vmas(mm, &vmi, vma, ULONG_MAX);
 
 destroy:
 	__mt_destroy(&mm->mm_mt);
-- 
2.47.2


