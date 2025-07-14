Return-Path: <linux-kernel+bounces-730440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 797D2B04491
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1284A3AA977
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B41425F97C;
	Mon, 14 Jul 2025 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cr4ea1fq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sDV5PzOO"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF87125EFBB
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507637; cv=fail; b=p2p+yvmqEq22QVnjQY1ohU/k6JY9tnO/MET0B5z53w2NGC0huGAEE5qUVTSK8E0w+gp6kjfs/R8aMiMx2m7unhjvZbCAfxkt4yqqOgV6OPM75sH2yZQRjdPuMNBcP4D6ZxmjjAkuhAKyEmsZvPha+oqTb6qI9k5LJ8emImKHoR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507637; c=relaxed/simple;
	bh=QuIJDePLP9TBcaG9NF/ajN/3aBd0grI3P7pYfW8ioPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y5Uli4/0ILNrealVMGk6+yhYStCJtsXhROjVc071S41hjgOtOb8SQinMExedHJa/0sLee3pLfINkzL0SDUnaiajzfrASs/7oIOZxAe2GXbGtuIxeFO0kcA43Fcnox+tWSlAND9rMy6Hc+UNx7Fgk98m3YVRd45Lg5Rqz5QyiuEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cr4ea1fq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sDV5PzOO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z238026750;
	Mon, 14 Jul 2025 15:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=hKSvTIbquFXpvw08+2
	6m076clNI4RTB1UtjcWhvb+TQ=; b=Cr4ea1fq0tW87IVWtQGzbJQNE+gMf4s9ua
	psYcDGF2VHFB1+Qwpihu2gTF67BcXe2QBJAO6sRYSod/lkPIRBaompyCOyByTWP1
	Zn3VHZr6H9uHhgny4zpOAuEE+Byb2SuNjbM7o0HQMcWJex1Dm1Xn4jJA0bVsE8SZ
	pYGrWOo4qb2HMZ6c+2AeUxaHf7h0oFNlgf5BZMinaUhvmkCDoFxE8r0Rip8JOIeQ
	8p4kgELFA98HBA0pW28sZo88fpUXDn8KmhCuoo2Uvn2jXE6FS5gaKemypa9DW/6O
	eMQWooarQRSuGczLQkdudDivkGFntlDH/DpYT9STUiMOxw5K6VnA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjf4vha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:40:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EEkidR039695;
	Mon, 14 Jul 2025 15:40:24 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58p8w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:40:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9WCHjgWVM7qfiACMMHcZFqJaBNACuI+3PDRHx7abWRuyBxe35WHI0rUtfDo/oUsQWJD+utZi8KvGRQLRTFoxoCo8ymenSlXOyDvN82hNrJf67aYFSOtCIJsH/BQLthb5ILbH0WUzC8Ryedu40Y1gXFmGiEeadt1id3qmU+ARmTYEpVgHyP8AHSZvplid7drbx3glQbGdio34LEjJVHYDaGYUUfr2r4fj7OfOfRGnjP2hvkJKwmRp36FwJKbu6KmBaMgLAb6YPzcgL5VoNM30yNwQgxITbd2sHQ/O2DsQFBH8XMIVbpJKoRS/+I/qFbcRpOENGXlXzeykYfY5rVfBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKSvTIbquFXpvw08+26m076clNI4RTB1UtjcWhvb+TQ=;
 b=HyojVg/eic4CWGi+yNe0arpd9XIKRamrbEJPUvusOk4mcGB4s34fEGo0lMGeokTqBZMMsOK53KN9k/wQscGEkNPFe3E2RUcVRkheNRw/WePm6Rh1JGTFQP0YR4zk/a/tDicKBkbkaeV+O3DXKREyWOixMgxTkL5Q6hTEI9gIHqEmbVW5QzyPI5lChAp4MWbuq8CZ7gIfnMPXBbjdjw3ZsrnsFODsPblVnclXEtCnUq96C0A4oJ+tqnjIV5xDVNoJDf4hM/7q9lLm58x4pyd2BCQCGoINNIruJTCVzvqpclc4bLrnJX2eamIjhiBl3Maow/+zo2sRVUXZ4yTIRru84g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKSvTIbquFXpvw08+26m076clNI4RTB1UtjcWhvb+TQ=;
 b=sDV5PzOOf7+ukdHbCKaYafbedtmUiR75lYfagExRnu1/n014PioWLaXlM19xzuTMaTzk3Re0LZZgy2c002Ggary1ST+Y4KvS+j4MDygrw+Hucmi+kq6QExE4Ur4LvBM02KJV3eJjhZFScG/pJLam+GtAMm5rw86R9xbsKj2WuYM=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DM3PPFBD8703CAB.namprd10.prod.outlook.com (2603:10b6:f:fc00::c46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 14 Jul
 2025 15:40:20 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Mon, 14 Jul 2025
 15:40:20 +0000
Date: Mon, 14 Jul 2025 11:40:10 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, Pedro Falcato <pfalcato@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH 4/5] mm/mseal: separate out and simplify VMA gap check
Message-ID: <qobzvdfztjh2afjsba6v3wslwajr26yjfuscl2xjxsleugch5g@xdz7rhlfcv6a>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Pedro Falcato <pfalcato@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <f010ec1ce65f35dbe1fbd82ce002ea833a7128f3.1752497324.git.lorenzo.stoakes@oracle.com>
 <ky2jvl6uyi75qwfmpwzmwu6qfnlwxshk2zunywe3pve2pshdxj@p2ihhzov3imx>
 <cd3516af-8481-4418-9f72-a7738a9fd024@lucifer.local>
 <d0b345c8-29be-4ca4-8243-de16583c93e2@redhat.com>
 <16e8ac61-d0ec-43aa-8467-17a3c2ea5962@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16e8ac61-d0ec-43aa-8467-17a3c2ea5962@lucifer.local>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::15) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DM3PPFBD8703CAB:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a5660e-af9f-45dd-43b2-08ddc2ecbd5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HmQbFPYyhWkJ7IVIq/m2wKzDLmS+LAxYtNt/Yv5S2sch6jducOeZZWiASwek?=
 =?us-ascii?Q?iofOawiPbrTWEbK8v+jrRRecokUmgsp3FlZzl7ekH/d33dVnzd/tnZsx4cEE?=
 =?us-ascii?Q?BnxfYnmr7sBP+puQFpP8OtaimCGZbJ2xQy0z94wI7OuMlg0M3uJjOZuomGqF?=
 =?us-ascii?Q?btVt2L/gRvwGCrQWTOm52SH15/b5VluxMLzjvGRMZ9srUmbptK4SHGXJCJbe?=
 =?us-ascii?Q?gCkbyDzoz0HSHQPI2At/pA2D+6tYY+gXd6PuIlwldctygRS5ltyOB3Aw3yp0?=
 =?us-ascii?Q?mxp/tGi4nc9+7jx1mxQQJOCUYbP1Na5mD1djDhSYld8TideE2fQeP3Tvdnkm?=
 =?us-ascii?Q?HpVcx+xpgiC/SEYpnDp8lfu50T46IVDpBdzrud2eemijgmsoZSQsw33Yho6J?=
 =?us-ascii?Q?A/5sV9wHbriQpqej+HVGpze5XBYG7a+9F4Wtk3I24doUKCww+hDBiotfiK/P?=
 =?us-ascii?Q?6r3Uq/+RLpXjO4jQrsC32cyME91DV0wUiRkOMcsjYc36lo4Kf/TRt+ZVFXve?=
 =?us-ascii?Q?qT54B2kQ6qkNZb1hUbKTnZxr2FFcz0XM0TEatdcODi2tjNDsXWAFpYgB3QZ9?=
 =?us-ascii?Q?7DtR1jKlt1Bn41X1sfPmX0ghU6KPJbwvSDrB4p/Htd679IfhoZ5uQKkIvRAe?=
 =?us-ascii?Q?OOTe9uIzHl5b0M5Tm6eSPm/P9empzH/wS8cAR2NCiMBeuFcb3ppcu1V8Y/T+?=
 =?us-ascii?Q?dxuOHHTFuEPPNEr8C+RNGD80d6Q74pTQxVS3By8D6jlBJ+vs+A4dzTev/Zdk?=
 =?us-ascii?Q?wuNlload0MCRE3KqNtGxgS/oMPEBVwMAoQnqhFSh16WumRO2qRILj3GEe+xc?=
 =?us-ascii?Q?Pll4K6i0ioGD9uv7BERyv3EfEjwT1YA+0cQ+m/MZU6u5Xaof+OJVRgwhxkvc?=
 =?us-ascii?Q?bJUfxWKlQY1rONuwybACqoyab5J6N9J7j4HFdJcZtKAaARsJd4YrCYBrQsJt?=
 =?us-ascii?Q?zss0LombkNlDHPss7dhHASoo08oI0ovNGKyrIynBTWI/hBd4nTnb9MPiuV0N?=
 =?us-ascii?Q?/PqPxxDJj8hr0O15rwQAU2QpL2s56AsROnZqwazbEeULnv7RF+R08y/JfC9J?=
 =?us-ascii?Q?UJYaYEQ3rTLsr960DDlV4VJThKygprEzDJ8RdoqN5DFzt2vIoQrMreD+pDJY?=
 =?us-ascii?Q?6G6o0sxXxJ0++T9i1K1sLu+ZnX9953QpbIV9zmx3KQdqSUKIwsr66MvVSVwb?=
 =?us-ascii?Q?3dcyTyfob3F3ZsUNRbvf1MEcWrfr0jYwM7jfwGQofcpWFSi67cw3oiddot9l?=
 =?us-ascii?Q?kuL3x2pDoe+L9Dh6CBGgMsPVNodttWFNY9ChKr+7de5P4484b9dWT+RkcOc8?=
 =?us-ascii?Q?sdxmoB+dakkuuf6w3f/QHsyYNVl0cZD/GVLgPDJysF4sCnPgovmYM7MhlACa?=
 =?us-ascii?Q?CbslK1YgyRPrHCOV8RCVyvMSiSnjGbLMAVv5wBPt0LcAE78R+20o8kk/qSei?=
 =?us-ascii?Q?o4Zm/wYAGl0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1hHb8ELiZP/rCAET/aNbgrRfxtSuYMDrlFuSlHm5bsNiccEaQb4OEsOP1Nms?=
 =?us-ascii?Q?k/3GFF3ste4Z5HawD0vieIURmmMP3rzTiniMADbjOE1CIFaKlaEYxw6WT1aV?=
 =?us-ascii?Q?K5YWS2MLTJ522vW9sliYB5yvU9ieF7WSGhHFBhE79x3qcuVytVMdGlq6mFhZ?=
 =?us-ascii?Q?f2K6f95NzwZgejY200JATdFVG4BenLOE84uqeDCbP5XvROviK/DdIeDvlOh2?=
 =?us-ascii?Q?zOSWEjYX3ZkIY8SXtMCijXR2j8uCIxIMG/DZwhH4nfK5VPOhjWM20sKZZdYo?=
 =?us-ascii?Q?WqkeEsba7sjGSqPAJwL+qWfLmT7jZctC1e3q3MGnbBFUVE2CTWEm6izXrS2N?=
 =?us-ascii?Q?ECN3fVU4C4+2tEBOrlRFnFFDxw8pArwFbgRQqDlT8n4GioGLPaPZnm+fNH/5?=
 =?us-ascii?Q?EmeW6vwnRe6ldWJaJNOzapMPjMFF09LnhTrPh6DvbqoJUkhe7QepdVUTPWa8?=
 =?us-ascii?Q?ef7KxMOMfWrU3wrndLr6NiUDLbOt5RIZ83Er/4rr62huF9XE+ETtd2quEvKl?=
 =?us-ascii?Q?6iL9Ux8dY/Qew2UmUbFesaH0S7044lUZ5d337TaprL+377tQv5IfXQpK9uSr?=
 =?us-ascii?Q?s2whO5WdCwGzBbwanDRwweuTfZUAI1Sfc2l7mUDESarq6S7R1fyFPCEJN2Cr?=
 =?us-ascii?Q?N8GRcGBrqlKLxIng3z5WEsTQKiPojy2/cwH27L1EE4jNrIjLXqqImZYJmvCb?=
 =?us-ascii?Q?WmTPn1wJkIzqvvD0U4LBol9X8sereu1lTPF3wHcZiu1nItc3gHOkuIs3R/N8?=
 =?us-ascii?Q?w8WltZ/yGjZ0tdWHbn0KXd1tneDPxPC33Toou9+u3vcdkICUVe1ANtfpSGI8?=
 =?us-ascii?Q?81reT9gvXv+DAHmbIDSYSjyS5Ce3/GYtIKHpIQpp5LE6trMACC+ZYTGMAGuL?=
 =?us-ascii?Q?2VcR2oiPZN/vB6dH0PKaSOTm1iuSkp2L5F4//0qHJEUJdx5mQQ2LYB4gsM8Z?=
 =?us-ascii?Q?31NSzfP5OtvjOSBXjD0RwVG6Wn2faI/8ljPeom+jlJxQrJILt0hkrLbXWkcA?=
 =?us-ascii?Q?6FW5eKcJtFPA0eTWndfxkEPXeseEey9i87h66W0MUCBOnTLVHqsQ5F+tGeUS?=
 =?us-ascii?Q?0/D6/0ZmjMkcejeEroWu8yMY0+yv2Af1GM9Mzy2GZZgvvDYUp2Uf+PpDrvH0?=
 =?us-ascii?Q?YOWQQlpcpJ7kyxVLTWRJiXOnZMyewnnSNumrDdnMQmVWd9Vk4t1SC3kisb/K?=
 =?us-ascii?Q?TcjfVPGzXnL++QwV7EimjfuYZ6TJO8uA9wV4GDRpTqgDkLQSv8hBrggFl0UQ?=
 =?us-ascii?Q?8e10V3ECcEuvqHSJDXX25egyyihkAAQoht0GQkmUoTEV9QNt9qtgFmWanFpD?=
 =?us-ascii?Q?RB1CVnqKhjlDNCXcHNtCh3qEXW+UQXpq1CBcs1WhiSwMoab9vKVx5Uxb78nH?=
 =?us-ascii?Q?XF0bjYs+m3JiJkBfewDXykU5HGEayImU/khuKPJg587I8nC2Yn1y7YaiN+dW?=
 =?us-ascii?Q?LqyjfhVRX3Yy7PBaeogbolKqMFv6xHKQkdvgsTLFAR+BVRIEYhmUd+6rOyNx?=
 =?us-ascii?Q?oDXzfv4jzhFrLTEficAY/a8ySrU5f0ZYyI/S4hr32DCHI2/S8UfWdceNR2eP?=
 =?us-ascii?Q?kD3GxZA1vpr0wRjt2kVROtjryCVdrU5tLKgJ6ff1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z2Ufo0mzrBuBmWRr9uwfMT1hcga/Er0uJW52X1fUXg0GilFjp6Lp1t1iLBlE6wU2Kma0hleMgtTPuT00U4DbRXufJgQEiasFRqYbW546aOXhj+Lizz2TS9xbJFdoz8iMdrS5yokIYy4DUOpwo0fXV/4Anf3skKF1IA0ZSAX1FuetiBPCyObS4YJUTpF7wyhskf/9SBcsETOfkLEySAok1tagWFgd8NbTRJk3TKkrQFgFgeusp/OqTuGKft0+JB3nXh1QTnQt9/GYcrwy7DmN4wGoq9oUC5cZz6ow4ySGcU1heaXfgN+agYZhDXUjqjbwabUNASL0nJ/thPOBGnlrAJd9xQPAZGRW3e+FgvZYFxVzKgFA9sy0NT0zOO28r9NSVH8TldY2Ce6sMxjR3EYWBmsvrbVnBGK8TTsqjPfiI9Ywbv2du4zz6wyS8d8x73zf+c1808HMNE7B/GWmydZvwL475FcBmcEKzWGGteF4IIhWsvdUPF7Yrd4aDPq11KCm66L8z4H2DfUkZKDMGGrzt0uN5pBs5qN3tUhS12Mb+D3BNgZcJiTlm9E+bgKpUqGiaHR2VtBkf1GwvMKBXPD+kR7L5+zhqBf/Zrq9sgd56M4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a5660e-af9f-45dd-43b2-08ddc2ecbd5d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:40:20.3192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRxq1xvbzuochuuS+RD+WbbCWc7/QgPBn7GABeE4F1dD5PAY1Lep0MMwVnecpXjyUZT+8ewKZD06oJQmlQSP2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFBD8703CAB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140094
X-Proofpoint-GUID: jsnPsst5WIBmnsmdimVTRCpWh1eroN1Y
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=687524e9 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=lXgNiro_HRjWA3FmjhoA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: jsnPsst5WIBmnsmdimVTRCpWh1eroN1Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MyBTYWx0ZWRfXwhBGV9MkrKo3 D8R0Of70GXMyxYtx+w6TJNA0r5e0veB4Smngk1OOOuAy+TunnvUlCN24LgbC6WRLG5vxpQb4whp mQGK9ihjL+UT9GRV7zuJUnOBvvKPJNNKmBpoydyfboJn30uqvOMwDjWX9wv7TwRkn+pLkQaVS0a
 N0N0LOvhROBUjSdFlDSb55LdB3wQRLEjj1ehD3vA/NyM6o72/qZoaq5mHOhibLL8otP3TQyhqxB rXZwLP58GL0C90ROY6CIDPd4oarAhjJrHHB91GPuMI1R5hqKIRS8ZWKZNwiDqpgqSpHj5zCFudt DuZU83LM0WfMG0RSs3ooPaFMYW6uiNluLDsbjFnQfxPW/bcAExJ8JHa8jB70eQOWKzWX/93SDwW
 zxdqjMT9JGNaiefoSZgcBHmgb353Zs4hF8B1PzSjCVsgUD9lKqzghVq0XwCTOdrJTzeai1Wa

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250714 11:32]:
> On Mon, Jul 14, 2025 at 05:25:59PM +0200, David Hildenbrand wrote:
> > On 14.07.25 17:23, Lorenzo Stoakes wrote:
> > > On Mon, Jul 14, 2025 at 04:17:23PM +0100, Pedro Falcato wrote:
> > > > On Mon, Jul 14, 2025 at 02:00:39PM +0100, Lorenzo Stoakes wrote:
> > > > > The check_mm_seal() function is doing something general - checking whether
> > > > > a range contains only VMAs (or rather that it does NOT contain any unmapped
> > > > > regions).
> > > > >
> > > > > Generalise this and put the logic in mm/vma.c - introducing
> > > > > range_contains_unmapped(). Additionally we can simplify the logic, we are
> > > > > simply checking whether the last vma->vm_end has either a VMA starting
> > > > > after it or ends before the end parameter.
> > > > >
> > > >
> > > > I don't like this. Unless you have any other user for this in mind,
> > > > we'll proliferate this awful behavior (and add this into core vma code).
> > >
> > > I'm not sure how putting it in an internal-only mm file perpetuates
> > > anything.
> > >
> > > I'm naming the function by what it does, and putting it where it belongs in
> > > the VMA logic, and additionally making the function less horrible.
> > >
> > > Let's not please get stuck on the isues with mseal implementation which
> > > will catch-22 us into not being able to refactor.
> > >
> > > We can do the refactoring first and it's fine to just yank this if it's not
> > > used.
> > >
> > > I'm not having a function like this sat in mm/mseal.c when it has
> > > absolutely nothing to do with mseal specifically though.
> > >
> > > >
> > > > I have some patches locally to fully remove this upfront check, and AFAIK
> > > > we're somewhat in agreement that we can simply nuke this check (for
> > > > various reasons, including that we *still* don't have a man page for the
> > > > syscall). I can send them for proper discussion after your series lands.
> > >
> > > Yes I agree this check is odd, I don't really see why on earth we're
> > > concerned with whether there are gaps or not, you'd surely want to just
> > > seal whatever VMAs exist in the range?
> >
> > Probably because GAPs cannot be sealed. So user space could assume that in
> > fact, nothing in that area can change after a successful mseal, while it can
> > ...
> >
> > Not sure, though ...
> 
> Yeah maybe a sekuriteh thing where you want to be sure the range is in fact
> _all_ sealed.
> 
> I'm not sure that really makes much sense in practice honestly though, because
> if another thread can fiddle with things, then surely you've already 'lost'.
> 
> if you expected to touch a VMA where in fact aa gap exists your software is
> _already_ broken because you're going to segfault.

Since this is applying a seal to a range that already exists, we are in
a race condition anyways.

If a gap exists it might be better to fail and exit as it is insecure,
but really, if someone has created a gap then they could have mapped
whatever they want..

> 
> So it just seems overly theoretical to me.

I don't see a theoretical means to justify doing this, so I must be
missing something.

> 
> I think we should error out if there's _no_ VMAs at all, but otherwise succeed.
> 
> The semantics of 'all VMAs which exist in the range are sealed' would still be
> maintained.
> 
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >

