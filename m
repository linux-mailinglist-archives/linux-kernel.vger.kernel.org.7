Return-Path: <linux-kernel+bounces-730022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C49B03F48
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B861017B8E8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B162517AC;
	Mon, 14 Jul 2025 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m5fW/K3W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Cd7tWHtR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C0B251792
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498512; cv=fail; b=Dy6g9VAmNy7sJaClB/Cl8mWt2QxHooLsw008ZniMFTgljVVy2QDLCd62g8MicE3bDfvggM8z27cRwyVcyRmqrF/J9er1vw890NIJud1GceDUaPHJ9Nbmj8347OsoDuJGvUlTW00+ZWI6f0su3N0Jk5iGfkcQLGRdxzQME1aVYtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498512; c=relaxed/simple;
	bh=iYDd/QbxJmref+iT7vozmDI+Y74khjoXDZohge/4zVA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=m7gNcMhytWaLLgz5L+x3HUeVHAXwH9aAng9b7Fdmdjsd2u2CMrE3+OqlPABeSLUmpjxWYmF6qo1TaNn1D3MFZ57Au1ZbRMnftGFhsKphu6z5AUeDdWvcqC+gDUBbJjL4yNmGXowwItb6tbfr6d90LHi5nLyNJIhLwTq8vgb3lT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m5fW/K3W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Cd7tWHtR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z3G7004547;
	Mon, 14 Jul 2025 13:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=hUzTlWhtNtdzKmpY
	7bQe3HlQAgXKC/ivLBOY9Zh0eqk=; b=m5fW/K3W3te5hWuRUFyXkLMdCOrEuM9S
	5YCM7vuBO3hW1XPIJPzIlZtTPHBoXplfkWKG6VO9eUEWVoVn+NbOePWUR8XHMuDZ
	DE70l6BRp80sJEI7uUTFnGAStSz2i6buMxY66RFoGdw9Vcqm5LjkB/2WbIYrDhEm
	qbNmDSvsPrjUesMMcxXpys5+Xh5Tlm1Py6chOE2VIvwt14VvCSj9EPHeWsbByF9X
	5r9C2NpY9W9xsPlg1P0VxwLMJuMwOgWm6Vi98h7ThVnCMHtPAar1sD8o06SPBH5q
	3//rOhTQzGveUPECkZosBVAbf8u1hsTMqEiz39pFhotV5VrYd9cqGg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx7v9g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 13:08:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EBKvGS029612;
	Mon, 14 Jul 2025 13:08:11 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue589q62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 13:08:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q26Q5Gp9PUSpNBBxiN0m02ClC6K3NBofigj1shSWEcmS8/aAJuYaieaAH7kzndc04MzDMsDlleXzGo8IUqXmOTCt0WMJuXbe56DaEmwS3HgB1SvIlGDEoCdi/KF9PhkhpxHTrZKpKpsPXOKSr4uDRlqNjJPGgvD1yNrEpmAwZfi+AjhF4texuWDXzlkd7NUw4ecelvtN05tgz3NoSXmdEZWhrCzOnJd/fpshVteiXrlB0ADkJPkQeFSxjOs8ch7Q52vR92vIbbNQJCsQBwNTHH2Wl732163QovPQU7So4l7Lf0+ujwMbNYSdzr18o+lWcF5eQskxpH/6i/+l7pdspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUzTlWhtNtdzKmpY7bQe3HlQAgXKC/ivLBOY9Zh0eqk=;
 b=AJVDc/LX+wBfg3rr1FNeTI91fuHPFinVK7YhrOqeaIDJViWLP6/BQzyNF4PcMDd3jwCX5uY1k274wsORKgq1M7unpWoVvCzBlzfw4XkVjZqwj7I5Q0lS+7rFl4EC0CAtpaKBCIxxHifX7lJp4UKnHfV4SVYLBSiOOHz4+M57zu17fxmzPRHZPU2w1HVw2i+dJiFib5X6wtetUCOoms3W744eT28xm2m75nGRrAmIvnk4KjU7YjMmy01/MVyCza6bdoR3G3Cqln//KKGGRvprxT1uIib0spbe1urtPoLuEGEAIyAEDyobciln42xklzgJE/8h5IQKHZ/ZYvzCPld3tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUzTlWhtNtdzKmpY7bQe3HlQAgXKC/ivLBOY9Zh0eqk=;
 b=Cd7tWHtRC1f+VCjBx0h+nRTvFFyNOIZE/pSqhkf1/2UStandi236oy7X0aUuBhWo+VRbRxIjsanRVm7qN2x7kWvmQHwmS94maGf+Wiw03szo1du1+cZMJ++ILXTOJCpZrpAMmr3kzBkRleeDobEetDSWWlVqqex7+Zmwrt3f+38=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB8057.namprd10.prod.outlook.com (2603:10b6:408:291::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 13:08:08 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 13:08:08 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH 0/5] mseal cleanups
Date: Mon, 14 Jul 2025 14:00:35 +0100
Message-ID: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0664.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB8057:EE_
X-MS-Office365-Filtering-Correlation-Id: f44b13da-e811-4d24-afb1-08ddc2d77a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BuIsQ0+b+gwy+G26qkhBOG4qF+e/2Ja+5DlFUYXMNAFTDAAqeMVy5QAohIqL?=
 =?us-ascii?Q?llKVMGTtdY7vlhUV3/4tCrLbDZ6DZ3g1uhz4xNXrYUk4LzQ4V8b48/v+RC9V?=
 =?us-ascii?Q?6PrklNlwCrr0JdYANM1nPo6Wj7YKIK+yv6im7ripkG3zKoispFEj+DnFuR2S?=
 =?us-ascii?Q?8qvogxLzUzx7LVPr8VjeeoUqBe9CUrY2i7g/OQ2mcDpOAAryReR7CJaPgAuw?=
 =?us-ascii?Q?kkVxrJ8Le7BXY9tinpkSFT4TjEWijUlUBWbZoarabV4/joY+DoCbgX7vkS+M?=
 =?us-ascii?Q?7F5BgO03mupym3Sjm4/Mr8j2GmI1fFleffbRCpFpNiJNwyn5GI5OdrxAVlrz?=
 =?us-ascii?Q?vXAMCkl/DZ1z0nZczf7GYw8qYLPISm1VWIOKaF4MkIcKFwYRVjNF55qpKWcP?=
 =?us-ascii?Q?ypMjvf+BBDsOiXEK3w/ySbIjMkqFyVsK3M1m89vvhUHMSlC9hEyLBMjCBA/4?=
 =?us-ascii?Q?OhI4Ho7XilWVb43LcsVeFUq/J5BV8hnPUU57heZzUMt7VvyN6JS/DEydbeQZ?=
 =?us-ascii?Q?gu77krpewPJ0Rq0A1t4H9eKvRHRulojqKbhBQrpOmKJKWr/QDgoW2lnM3nXE?=
 =?us-ascii?Q?oTpJSlbp9xJsK97fblUIOiV/sRpE4mnq1pgcYu+qKPPCqPziZtIr39JYkh4J?=
 =?us-ascii?Q?zoXX5Lz8W9OYJ5vH4xAPNEwkIau1sfDckdrngD6Xb5ZLc5/sm2k1ZBZnfK+l?=
 =?us-ascii?Q?ASl+4jv/HAfr15mMJVR3GwgMPZC1GnJEPQZsJXWp4lij1Ir6cruWCAChxHfQ?=
 =?us-ascii?Q?bzbkaIJYNuKNSlea/aMlJJzJFReGg/lQBmL6VoBK+iNCspW5rc/RLGlF5E+1?=
 =?us-ascii?Q?gMnZQLFsl/NKTDLFF84UsDOoXJ2dNC3HYuOeT7cyClZMgyQfHIHJ/ZEHjl8M?=
 =?us-ascii?Q?G9T2GmE5+o2X6JrUh9rI2h0TAHt6GEIf0/KjXfWIoLNWbxE8HBpje+jg+HBw?=
 =?us-ascii?Q?iiCpWsbMJzVDHVrlA4kpK5scxFk8jXUJPC6svsTDOQV26AIz8cO6Ey9drZL5?=
 =?us-ascii?Q?1cDdHF8rRJYWe4MLhzJCQVJCwfFT/CCgez8Si3G6hRBupJ78kfqUpNhzMwNk?=
 =?us-ascii?Q?8TxHa+6Kn/8Q85fmUvAhkTWgJBHnJbdc040w1yEAx5hYHoCItC+HYtT6+r2s?=
 =?us-ascii?Q?sE2Jh2CNHw+geyPS5ttgRpBuwDGYM3HlUFy4d5pz/jRQAeoqT2Yg0EEBbatH?=
 =?us-ascii?Q?hFRBIFToRB8SYCqG51+zW6kJXNgZMhQy4gt0P/1NwTdMYBiCRndPwFiTYRsf?=
 =?us-ascii?Q?ylxlATIL2lZlfTiggd7eCxTtLjRRne9RvodPGnxNS44VhQ1IETlBZniJkIzI?=
 =?us-ascii?Q?e7yVbi8Q84iw/0BZFWuNGChwTq04rFt8LxcbBTKE8L40EDpQKNRSlI7dmSR5?=
 =?us-ascii?Q?yQX5gHKslH+uqx1VPMxcc7TiKa8RAtPsJD1y1I07i8IwmiodID2LRnzp22Nm?=
 =?us-ascii?Q?uWQdT/CTgfc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0o0loqU/kTNmi0Xpvn/dCy269ChpFUEfXtRN8NpSOghO4Kv9skVBgMtcSKr1?=
 =?us-ascii?Q?XzcQ2sKeorJ+R+IJJ3H6njrunuR0aHa9bgZkXFH1PAwv/WSmZKFGpvZvau3x?=
 =?us-ascii?Q?c9wkVys48K1P84Ttq9NAcD9XDPXYwDCHoSJ+Ne/aiYprs4KUwkkhW/0X0QPj?=
 =?us-ascii?Q?MP0Qn3Yeh4nr/S+VHU8dzxjM3JGZYW7HJWmo3MxCrNw+yRLgpLi8rbnmwfG1?=
 =?us-ascii?Q?bH/aqwRbslHaQSeIfE7hqv3nE4bR3iEKc+/7KkH5mDKXI6sTtJSo970jJInL?=
 =?us-ascii?Q?hQm3lxcCvfh8CJuG70t0MrL+a9gkTmXEj209r6Dl3dF55oYSxOJJew3dP7CK?=
 =?us-ascii?Q?59sFD9IxQFQ9SiQTg6/r3pan71EkcHicN/PBLmBf5OS4pEctlfP4ZrVXZJ6E?=
 =?us-ascii?Q?p51HVPPRKfGyhWTxfON1+9QxMn3NXWAO1fL4vqAVZEFhvtEP2WFz1X86ld35?=
 =?us-ascii?Q?OEd5NN5pre3ILefQejqwnekS/uxJ6Pb++T+i/fDEgqAWgi8rVEAQb9qIJ29c?=
 =?us-ascii?Q?aq1FVp/8UNVSD4hHUbXdb0XGmTCoQ/EZFoQPPLMrd/BU+nsyTgIfLRx1jeYp?=
 =?us-ascii?Q?9boEDxm8ddNSywKZllpmVSr/hBzoD4VB7+tVAMzQGIVTMRfUjq9jeeBYQjkR?=
 =?us-ascii?Q?h8cTbOg/57pSTylciyt9St821LTV+hpENePq/6uH9U84qgLBe4sTGYpdO5RQ?=
 =?us-ascii?Q?yGtAfKUoqWG2Cp6cABIb6UYEWUo5jiCFp3zgSLciD7q4sJTJyVIK7SDbahD5?=
 =?us-ascii?Q?2AZ+y464EjtK1TPqTDN8XmytHEhQwmSc3xnzhO8nBUj1B4ST5JOGu7OyuW4V?=
 =?us-ascii?Q?EBlwu5PlRfDLdnD+fE94tltAN9lk2L+qDrlYtgwSx9flvHRuraEObVKmO+jX?=
 =?us-ascii?Q?Xp7tqH4XDfmFnZ3cHPRFVvvJZ31oxdck+dgGrZjHdgPJOgnPxRInHZU/os6H?=
 =?us-ascii?Q?TuWX6F7UCcHNXfUl9gton2WsjTAawKhgobhNM2p0JjKtYQHDEUReEFzMeZ+m?=
 =?us-ascii?Q?B31cUppix4SDNlVt2vQQYYFpyblalbwN24xiYyy35hR/mbOldtlk//crOTRW?=
 =?us-ascii?Q?mkNnwOYwCvWvegtmRDs7fDqoJEiCLKeyOQQhXuBOIWrW/WfCgz0brgyA6mVL?=
 =?us-ascii?Q?PGK/2FoBRdjfObdIC4inLezE3Grn0zZC5I8vi8sSuHBfMVXy18xR3nDWpG/Y?=
 =?us-ascii?Q?YACwd9ovBZtIH5lD80B369haRE/qNp4jUzedNVedqoYy5MfD9cy+cgvc/lab?=
 =?us-ascii?Q?EIA0vQsfOc9Wpy296ILALG/vfWUEgUYywOT433Z1gCT6fR6RR57GdozaPSb/?=
 =?us-ascii?Q?CvOivkNxyWP26jfu4NBdPvK5PxONTkLSl6QtUurh+H364NrdDVpRdIY8cIzF?=
 =?us-ascii?Q?YMTWgCsvMiZ/gz+IjKzDfB9SRxcu6evwYX9Z/KxRoW6JAJAyyiNFjFjl3ght?=
 =?us-ascii?Q?PIZUrUjIKeqYZlUKlXO7IjyeYGjTk10V8MsL46ezwIbjnmfUk7xzNtZNABpr?=
 =?us-ascii?Q?DejpdDWnuK86YJ8FVSqYHeuAH2homuU2KQGAvYEb+wa8FTz4h5wlqJRFpchG?=
 =?us-ascii?Q?vxrZNbTWn4eJgPXiCdM9elJBbT37y0TBv+1WfxZRXSu3/dZiLv08QyqKDQjq?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gVMA0WYuafc20W/+cEwwBfT+nnXhJhWMZdvcBRDQzDk7bC2Qv+EDenNhOr8N3hy+tMmMqpVVJaLhwxlNUQ1BkQesr7aL+ZuMTooO/PWzJVdsYjDezMBO9OqgEEzjDYVTNwGyRZX9Wqz9IBfe6aOpPF/UBpwHP/XIWhJr+w2vzzz8EhVZyx/pi5ZmK0w5o+y6jNCMEhsEcfxUdmfwKNLs1NEMfhDVgbe5hSgXxZQWDR3c8XcDk26dVXKyasQG/ycMS5hBw2Qcb2bC8WRcJ8efIHWuFIrwUlc7JWyYZiTYg8qSdfssEGlAxQyQBzysVidSDe0f0iaXOsxmBNaptzHPQeB6lCNGsjjlpEsyOjDbpgl3WeQHT1xrRZGm3NfD9r3Qy+vPNy9Gn6RDvu33jZ+i6QKYX+G6ex8kDhSeAMKax7WvTpD4EDyd3pqKjlni9lk1R5e3LQB2Xjcp3IBV3qOVggVORD8zphZSFYYc4+GfcyyCzKQCp7LOHDYf/PZBKbu92H+vwQYMC7oBcovSDIod8SXdGtWcMOi16i0ZfVRr77ci1XN419tNQapCapbapRQbCyDSx3BpALRCVAtnZgHb6OV25CcfUPdcA829/lQJfsg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f44b13da-e811-4d24-afb1-08ddc2d77a2e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 13:08:08.0796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYYeNJLNj6ihH/Lybv26aw2ULkuReOSdgtPkizUonrxlLDr/CUf5od2elwv3RfLnPJSlBkkQCRxkIXxSNgLzxU841I/PpmmW5v3IDlv9LXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8057
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=852 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140077
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=6875013c cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=lR1zYxYQoQmSYbKFvREA:9
X-Proofpoint-ORIG-GUID: AJFGEUDIGt19i-gKfQESCsUjpTfHH0Zm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA3NyBTYWx0ZWRfXyjyLQp84Qy/I /xYDF/pNwySMY9708NgTn+t6ilM5FhW6NncEQEvb1wgGgpE8cC/1btIVpmoESjJQ7HqfY+/27yi rX+8Vg5qjOp/jz4ttx/M991jAEm51s86V6TBiJxjFRv9MHvrkUUV9s/AeyrCMa9dlYAq8VbMjg/
 eO/VhVZ7ERy7pWSjY/QKeLZQicIhJ21WmbCTN58Gkh1MwD3Ke4QV/ftjjPIIAjFheT4Y2frHKvN 2vKvC06p5x/TtZ3YUEVx/WH7Mlzu174PWq31wwnbmfg+xb/tSWG6+DN2jFtw0KTBlBcVXgfUKkh rbw1p6U6+tdufNyA23NLkKzMIvYL06WaPqerm+SQS+8TWAKF3lkWR8tVOLuoaOux6D5e4jU3L+W
 pjeGBCGWoQZm+lQ4tJ0ET6gOS6quw9VraI5xXehoC+IPI8t2WwbTHeyvGThl5p405a4b+dHv
X-Proofpoint-GUID: AJFGEUDIGt19i-gKfQESCsUjpTfHH0Zm

Perform a number of cleanups to the mseal logic. Firstly, VM_SEALED is
treated differently from every other VMA flag, it really doesn't make sense
to do this and complicates logic, so we start by making this consistent
with everything else.

Next we place the madvise logic where it belongs - in mm/madvise.c. It
really makes no sense to abstract this elsewhere. In doing so, we go to
great lengths to explain very clearly the previously very confusing logic
as to what sealed mappings are impacted here.

We abstract out and explain the 'are there are any gaps in this range in
the mm?' check being performed as a prerequisite to mseal being performed,
and finally we simplify the actual mseal logic which is really quite
straightforward.

Lorenzo Stoakes (5):
  mm/mseal: always define VM_SEALED
  mm/mseal: move madvise() logic to mm/madvise.c
  mm/mseal: small cleanups
  mm/mseal: separate out and simplify VMA gap check
  mm/mseal: rework mseal apply logic

 include/linux/mm.h               |   6 +-
 mm/madvise.c                     |  62 +++++++++++-
 mm/mseal.c                       | 161 +++++--------------------------
 mm/vma.c                         |  18 ++++
 mm/vma.h                         |  26 +----
 tools/testing/vma/vma_internal.h |   6 +-
 6 files changed, 116 insertions(+), 163 deletions(-)

--
2.50.1

