Return-Path: <linux-kernel+bounces-749346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5935B14D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0728B18A21E3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE5E28C2C6;
	Tue, 29 Jul 2025 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B6c0zO8J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JXhmXou9"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA8728982C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753789798; cv=fail; b=UbUfpozuRrnUACFMRtt6NJC4yoX4WFwL7Cie8xi13L1TMH4ikTfz9i9xSlUYjYJh56Tepa1bqijzUpWJdy9dPG/MUEsggMHeeR05dQGn0l8SogOVt4325e/D3ZNznXW1cXWco0Of8Lr/lSVMNUAit5D40Q1nPxbdHma9ng7nUZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753789798; c=relaxed/simple;
	bh=TwFNqFNmtoKqZHP1DQTjR2Cy84VcT57DvtjzF1ethI4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KaVItmlt4JaX7JBmT4EeCDle4T07yYdrBCJtx0khcTYQZ6PT8OAtFzvof1DqHZ+ItxWqXJp/zMxw7Wz5/3u1s/tw9XCbCnYvbvRbOs2duDFxxXFJ/+VehTK6DC/bbAloPAMG9oLo4KKT+8BFv2N6vhPn2J2QTjPuWVmUMt9DmeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B6c0zO8J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JXhmXou9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T7g2RM020957;
	Tue, 29 Jul 2025 11:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=kv3P5ai4VJ/0mfr7
	F30/VsnBFuGI1lrOFm1EEtglUPM=; b=B6c0zO8JtUROZgEix/MPBVrrJQUQ1bWm
	JKgpzaT7xQyFBDNxRS3+SM37qB9AVAqRPsxHEBL+oG0Z1tcoIh7jTsRCbzNC5pVG
	X0e1rbZ9wpaqKuYATN9MjkZceeo+BreTl+5VYqoikKkayaRh0VtSTHFCWEXb0Sc0
	OIAW+W8j6DeCnb+3lC1qqs6oeBaZtFmevLs5K/evli7ACfwgwIyVOFHXxeayKYi1
	8rXQ6jGIQq/3VmTOkW7M8dBlQROTxQcdTbX37fnUbNLtcGkkQDiz9aUuCmdb1WeL
	OYUmgD0GUOX9YBv35YohmH+8rte16Kr2ubkNvc+XUnngcR6pCd06kA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4e7jnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 11:49:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56TBSkEo020452;
	Tue, 29 Jul 2025 11:49:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfg2t15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 11:49:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LR9BsPlODZiJjOYANzzwFTAUa/76+Fo25oGGmJV9jIlS5FJo3RJIHxDpRD8sowSvNM26Dk8wy7Bb+IZ3bhzwWRLxWl5RY4pajnWhw1F8ztSgW2YHVCP5pTqN+g7piNQjPpC3af3+E1Z9WZbIQjTSjDkxursOgKoSa3B9VfpPZfc+9MF1zM4ZSxR0KC86/DjFzaFxzKnll6sTzDQIg433BH1P/hNa2EFicUx1blguL6RdG6em6Yu8GHXZOrPbAfBye0470Jh98ANFrRUvXQqKHHdeDWH5NKIHSRuyIl4dINYI4aesC6+tpZdtTrBl/lF66vL8DnSuQAb1g/OwGI6SAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kv3P5ai4VJ/0mfr7F30/VsnBFuGI1lrOFm1EEtglUPM=;
 b=o/lbS/VgyhPJdVu0X46eGhdPHBAkPQx97NuT7kGGWtRzNa88xh8q0Kgzv63GbuU+xHDVXCSwlZJ/T88z2G4gCaRHu0at6rr08+/xhzXEoBCIKC5O0cLcdUK6wWEyymqAXtsSq1jsfRdXk01IFiCguIqWTCqfrIK5hfsgW2epOI4OQqkxUXEem7SmYpnpoN1CxbB9Du+rholY8/0i1lZUBw2EyjKqUT0/XH1piFBNNZNklEsv3p4u2asyqhU3sVsCK6vW6oihF/+1FhY382SHJhgIHLi7ZBRjOqBZQZGLGfS07zsRlgYGO9Ak8Lf+9AbH/Za9s9YtkrRhKmKiyEOmjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kv3P5ai4VJ/0mfr7F30/VsnBFuGI1lrOFm1EEtglUPM=;
 b=JXhmXou9lvvo0EfG+tclh41T6rre0qRIKr+pz3EwmoY43Y+/ecFxEadvFyGjIM0FXpsqs3SYMy+pnlO+g1OEvfwsE8Xq8cUcL/vbrglxcXYC3Faq1kFkfbaHuTFT0jbXyz39jfWJO67nMnEayk+/VjARKYdj5jKjxuoWM3Fiq3I=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5166.namprd10.prod.outlook.com (2603:10b6:5:3a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 11:49:36 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 11:49:35 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH] mm: correct type for vmalloc vm_flags fields
Date: Tue, 29 Jul 2025 12:49:06 +0100
Message-ID: <20250729114906.55347-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0114.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5166:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef0344d-0086-45c4-f27d-08ddce95fda6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qT9Am1WpuDpnpapgMDPTZas9ay+yIkQbmfLOhw4OZ04BhIEhXchww2Qfxmyo?=
 =?us-ascii?Q?sdNqjcYFLh6L/YY6G1oZ9hYjUv2DGtpsxorR9LG40DuhZEgV07SSGKC+5J63?=
 =?us-ascii?Q?IKuVDkpqOkIMGUasfPVX/p4VPMa43WZV8rZulT+K2VZufoG3CIh44ArGLMdL?=
 =?us-ascii?Q?bPuHyNWup3ge1D0408U6v98ocJnuvK8RXrX2fbj+IoTDzBHvFSyl6Pe008+C?=
 =?us-ascii?Q?TJeNanlJFg3bQ4/h/SGs6bbrAxi/yPakArjM7tzgRtyUPYL10HNoErW7DikM?=
 =?us-ascii?Q?k5mt7MZvnrYTb7tw5RYEt1YxcwjHi2vrS5DAUt3zJ/j1tSs+xkU1esRnkYI3?=
 =?us-ascii?Q?uQw4HH7zAyws/0pQbs0b/0itaGYS/hb/VFPYpR+iVrpune/X91Rw5vVhBAP4?=
 =?us-ascii?Q?Qm4pF1Au4jAKCfZn1MoyfOQUQscJ8O7wgFQV+RqAqk0WDI3c2CrtfflPhll8?=
 =?us-ascii?Q?+K3OKdTVWXarjEWTxHaA2QCnmXAepQhjjlQzZhPcJwR63wdDcKFP7K7D3d/t?=
 =?us-ascii?Q?Q0SIuiG+OIDRa6FyGzmTYh+aw5VEqAdBc3k3c7opYp61Tr+c97b4u0nEJ41/?=
 =?us-ascii?Q?Os2o9PFA5NJoLEwnm91oxKb90ldq51/bQ6bsM7F0s+X356r0bgYpJg8RsVIN?=
 =?us-ascii?Q?FGgtIUyZMYCgCGl5kSG3HOpL4V36iSsXuGfIdJybh0/YDAyz/UAcZqfg4chR?=
 =?us-ascii?Q?1nI3o93zyP1ZDTFBUdXiG/0k5cZvTjYFRfQUTuFh3qzHu+8v8eSvgFodH2iK?=
 =?us-ascii?Q?IjkmjliYdSyDjbKtSdsIyhW2kgisie5EuseSbq1Bl8c+kxZ7zpFekExUly7F?=
 =?us-ascii?Q?ohhgTsJ8FWoHJW7CeMudMHOor3uYjMFBaO5nobwXZQEMS/AoqVd8Jq7udDGB?=
 =?us-ascii?Q?irfVZzzHwVvM44Q3i0kHKDQ30kJVgHU6b24vsAktQu13RQ9Hp1JBtpiDNyBK?=
 =?us-ascii?Q?uNjMh/jUMh0KY2X2jZkOzHkKiU2so9xr8Guo2G9XSj9Tm9n5a5aFFqpYAi/G?=
 =?us-ascii?Q?+VqCZI1uuUaxOS/n73PNdB2prcYq4avyTKq0Bpbk2o9PBhtToT7UEbyIRqxs?=
 =?us-ascii?Q?198Mb6NPO3b//L2h5x4cWs18LNqCwvX7vqCJFTDoFagXDGrHYK8UN/7MrtTJ?=
 =?us-ascii?Q?w9RySUEw4cvZascGM3kDRwbu9BNpDnTpqytr+hCZGhkqttSdv2q8o3zVyYBB?=
 =?us-ascii?Q?CAXAeOfPyt+QECvTP5aXjhvNvWklxnDbbvps/Qbq7tqk55opRB7VBiuXgWbd?=
 =?us-ascii?Q?BAcJosc43mYW9utTwidW/pA82hMHf28/kNcLHBMPckweBvY4TijkFLYDUeHP?=
 =?us-ascii?Q?O4V+G89sLYh5+slXLfLDnUcajS4u4YVTHzT05vhISrRZkg8lxwX2DNdGUV87?=
 =?us-ascii?Q?nGAbb98CBO0NGLzEDob9VQkuzj+u/tMjqnkNoQgGomu6bfR7ueD9aTbkjOzo?=
 =?us-ascii?Q?Ek7q92PsHWo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hcDNnBi64I3tUcZ2tGnV5DogyQS4EXZjWt1Om1iUj2hqac4K8TMce6nFADF9?=
 =?us-ascii?Q?wHfIMDB+SewFbNk7M/XT1Ldxe+xd0pqzFVsWVMsaGH7DZQCuGHZJwgDmgoVm?=
 =?us-ascii?Q?FdUevOVOLjaY014aA2/dTc86V/azqkhk1Eb6DfEv4Uje8T2he5sBHcpvNo2f?=
 =?us-ascii?Q?MfhrciJC5E3dqSsxjhBQohbMStlUyXqGhBsULF0ZbfsRXod7+0YOJUq3uLay?=
 =?us-ascii?Q?JaIIrujWE24Ofc4FS73WlSWWQfS7taOcHq8t+f+lUcTHaQvtwAM/1Nv5e/KM?=
 =?us-ascii?Q?+0QY+cXZQL+I+9cxTc1f7wNwzO4kfirncs4CUusvcIzRfgqhOrgP8QtI+40I?=
 =?us-ascii?Q?qWFyjq+H7bvtn+XE5OGHqoXxhGC3tM5IVyzfRZAiDS8+2uBk5aPXeu3Tzm8B?=
 =?us-ascii?Q?/OahUx2biM58j+ZMQyrHKmBHCuUFp59k1DykeKGkNNmKHVg2PyB72zoy0H0n?=
 =?us-ascii?Q?xf2gU3I8mez5AWkfcInjRmvwl5J8Z8u1PKiUKSoNS7Ydm5WbNglSOGMkgC2v?=
 =?us-ascii?Q?9e+ABPj6bVDMASTYlhaGckuMz7gmHO89+u/Mih5rruE1NmvRXD6HT2rgdNrz?=
 =?us-ascii?Q?OzjFL2xX5yhou8k20AXFt3GNIdKVyM5iVBMaRZSfWVz36u2ol863tAz8Q4gB?=
 =?us-ascii?Q?87zye9vkLxiLMKHU3v/5Pu26l3h8m/H8WleZpCInOCgzfYg0gzmmjGGGEbq0?=
 =?us-ascii?Q?4iuj4BuxTrbyBgalTRTwO5xYUkKP6dFleVoqC68hdx9v+uWfmQxtqyufN6mA?=
 =?us-ascii?Q?DIgVhZh4MjL0X7NnJf3s70Kh8C3+Bgz1lcUXJqNE7j/0UDft+EGbvSmS+N2F?=
 =?us-ascii?Q?3TMeGJprbeG/w4pn62UMBiafWZj5LMO5dT3ZrSoY30ro9u573kHXp+Oap0AE?=
 =?us-ascii?Q?Aedh4QaR5sTvhK3TH2r7UziXPZrvsqi55dnsgd1RgDaIUmMwRmk3a3bpAFE1?=
 =?us-ascii?Q?jM6Wj8vpCMXFD0tCUwGcMm9GHrCiUMSvNwDlVoOmMhT0eS35HckLdCjAJSo0?=
 =?us-ascii?Q?7BcUbOgrmjxAiWEdvSJiM539STyTU4+84ElX0vnNQEQ+bqoNOEB1ml1Rq42s?=
 =?us-ascii?Q?NIuHHesRrbFQR9E+8aPyxne5o4K4uEbK72SezyWDrA5hS9yyAu3wGkj4C/sw?=
 =?us-ascii?Q?JSo1vbN10czbLJ1OOlzfXVQ2xKH9VNofIAZJBdmzsyonQqRy2R/Nu/7ct1vS?=
 =?us-ascii?Q?0yYBz8STxMtUi2+fRMK+V3c+xR5zoLmLiNdltL+0ZrB03SutqtGOSBfFT6HN?=
 =?us-ascii?Q?Z5Re0k/wkEf2gJw0Cf8pn5Uc3y9a0JF7B/weMaefpXkgQ0L57vK8USKfgR3d?=
 =?us-ascii?Q?ghcXk6Eo4R6IERyadQPFcMHWF4HsAVi/l2yTsKV9eLCh9WAIhPrGCkxi2MIp?=
 =?us-ascii?Q?teWPIRAnCkC0DXZXwrOtaWcsY6VsRJPXhZd2yWjQ5OdEPIG1XLvEfbF1TEH/?=
 =?us-ascii?Q?FVP2OybdDAZf8/YN9Br79l9jourL4wl5+nDk6/FnNkQmjSkNz+T/AKxW5ZJk?=
 =?us-ascii?Q?emExSEOvz8aKIVhBY7H3pxnJjkfKuKRNdbvJb27nhrsbsq/Tur2a5+Ijd9Yd?=
 =?us-ascii?Q?rZc9oVa603Evqxuz9OGbPSmErI6JEi3DDCaH6l1Z4cDRKAvaNGwklfuhv4cf?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FHjMfqPJcYiMwATBiTENACIzyGbTE/OfqJGMDoAG7URTia9FSoQn8Qi2WXJsQ3i7wJY/bylc+pMm2QElUrQwZ3rHDrVe3IRrs36A/3RrXAVt0XsAecgOAyaT/0yGBG3GoQosvj39repuHJqI5e3cj530EN+9aVefeKHIOBHMtmBWd/rLYXIjB2pW3KF3Vyj6dRNpFaPGul2RWDVV0eO1q+ZQ87A2cAQPNQ/WMRNbrXFoDKfiNaVH1WtoW2oc+bsQg7+kBQgb+rrKCPxmpg1rE+/BE+1oR+/FLGRerxtxcBVe9subujKxaxqkexKfoga17BDhl/KFSmLHMd9yEQufc8kut7yJgtlbsAj5xyhRKMLmGvOULACUO4EXnR1RJj9+rYD8pf9UtbsAf1D+QLUDCIy/OsQfgtq0P/xaJWWPFDOG0nZ3hFUVbkrzc7QlMwqBrZudtvYR+j9bpxxr5B1S+YVhzztGzCwyfzu+evWxUKg6L0rCmoidD8co/uYUMahCpVF3pBvq1C8YG6V81SSN/Q8TEaDJMLSC/GbA7OJy+cNRgyB5tjUakQNDbpoFaHkuZp7vRBL+ZLYh/YU3322UIOlXNzuNgKRIQvz5okoZAlw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef0344d-0086-45c4-f27d-08ddce95fda6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 11:49:35.8153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUC2yigIFQY0nBhkfkMfj57ly93sgsygX1TF2J99PfoQf0W7svS6nv0WfW3ooYxB1OFeIMHrjqnI5AHHASvZ4JESu+4rUIDqdadqsAIQ+cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507290092
X-Proofpoint-ORIG-GUID: rC9nvvEwjW96eVJdTGpkQYTgqmG60BBg
X-Proofpoint-GUID: rC9nvvEwjW96eVJdTGpkQYTgqmG60BBg
X-Authority-Analysis: v=2.4 cv=QZtmvtbv c=1 sm=1 tr=0 ts=6888b554 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=KTszISoipgktlPMuHwkA:9
 cc=ntf awl=host:12071
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA5MiBTYWx0ZWRfX5+0ORgAzwh+P
 1tMJk7sYoAHgC2eFuptQmDfMmLDVwrtqqor71Lc0YV1E3VsPg3UE2GOTIWaFTTUOjlbOcXOHHVD
 5orlL3hex+bgSCaeKX8utrf4i07OIN5VvAN79I81Mzg3woSFFfaT4OFJRL3NCPc9ocTk5fdhyl+
 uHIZv3L+meyTVSjoe3TVwRPawIdJPgCtt7ImJMq3xM8vrZzIih6QHipf/lG0g2U6WdMlEOc8m0l
 NbI3yS0fpLhfYXebnVjbDAz0ABQWh7ahXhvXWlJF51bGXt/jiR48EyU90AkaM7MQbtEGpNGcR92
 exkRF0PWyG30lMVQqZxGXP+aie6a9dF7uV1lwyyr8eZoM7CXXsCzwzK+i8frGWL+hx40yM3Dwt3
 ImcZa//hEmxXAr7LoCpbIjOzZ0FoPToWt00RuKj5g4qZQ7BQ1mKHOimlLjBnV/5EqKVRrqX/

Several functions refer to the unfortunately named 'vm_flags' field when
referencing vmalloc flags, which happens to be the precise same name used
for VMA flags.

As a result these were erroneously changed to use the vm_flags_t type
(which currently is a typedef equivalent to unsigned long).

Currently this has no impact, but in future when vm_flags_t changes this
will result in issues, so change the type to unsigned long to account for
this.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Harry Yoo <harry.yoo@oracle.com>
Closes: https://lore.kernel.org/all/aIgSpAnU8EaIcqd9@hyeyoo/
---
 mm/execmem.c  | 8 ++++----
 mm/internal.h | 2 +-
 mm/nommu.c    | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/execmem.c b/mm/execmem.c
index 627e6cf64f4f..2b683e7d864d 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -26,7 +26,7 @@ static struct execmem_info default_execmem_info __ro_after_init;

 #ifdef CONFIG_MMU
 static void *execmem_vmalloc(struct execmem_range *range, size_t size,
-			     pgprot_t pgprot, vm_flags_t vm_flags)
+			     pgprot_t pgprot, unsigned long vm_flags)
 {
 	bool kasan = range->flags & EXECMEM_KASAN_SHADOW;
 	gfp_t gfp_flags = GFP_KERNEL | __GFP_NOWARN;
@@ -82,7 +82,7 @@ struct vm_struct *execmem_vmap(size_t size)
 }
 #else
 static void *execmem_vmalloc(struct execmem_range *range, size_t size,
-			     pgprot_t pgprot, vm_flags_t vm_flags)
+			     pgprot_t pgprot, unsigned long vm_flags)
 {
 	return vmalloc(size);
 }
@@ -256,7 +256,7 @@ static void *__execmem_cache_alloc(struct execmem_range *range, size_t size)

 static int execmem_cache_populate(struct execmem_range *range, size_t size)
 {
-	vm_flags_t vm_flags = VM_ALLOW_HUGE_VMAP;
+	unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
 	struct vm_struct *vm;
 	size_t alloc_size;
 	int err = -ENOMEM;
@@ -373,7 +373,7 @@ void *execmem_alloc(enum execmem_type type, size_t size)
 {
 	struct execmem_range *range = &execmem_info->ranges[type];
 	bool use_cache = range->flags & EXECMEM_ROX_CACHE;
-	vm_flags_t vm_flags = VM_FLUSH_RESET_PERMS;
+	unsigned long vm_flags = VM_FLUSH_RESET_PERMS;
 	pgprot_t pgprot = range->pgprot;
 	void *p;

diff --git a/mm/internal.h b/mm/internal.h
index 28d2d5b051df..142d9302c2ae 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1391,7 +1391,7 @@ int migrate_device_coherent_folio(struct folio *folio);

 struct vm_struct *__get_vm_area_node(unsigned long size,
 				     unsigned long align, unsigned long shift,
-				     vm_flags_t vm_flags, unsigned long start,
+				     unsigned long vm_flags, unsigned long start,
 				     unsigned long end, int node, gfp_t gfp_mask,
 				     const void *caller);

diff --git a/mm/nommu.c b/mm/nommu.c
index 87e1acab0d64..07504d666d6a 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -126,7 +126,7 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)

 void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 		unsigned long start, unsigned long end, gfp_t gfp_mask,
-		pgprot_t prot, vm_flags_t vm_flags, int node,
+		pgprot_t prot, unsigned long vm_flags, int node,
 		const void *caller)
 {
 	return __vmalloc_noprof(size, gfp_mask);
--
2.50.1

