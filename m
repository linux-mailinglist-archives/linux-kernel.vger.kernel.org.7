Return-Path: <linux-kernel+bounces-724719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97043AFF63A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D282A561FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3183A254877;
	Thu, 10 Jul 2025 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aMTrnzJO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hvasdBEt"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39302550CF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752109208; cv=fail; b=LseHmEr31VT9dyeAWRpT2Tqrawk9GGAQQf6+yk0xuxrSuFTgO1fG+sQ0GYct47rKubeBgiuYHQN/f4zeEkWcTVIEt0IG+AO0GbNWVpFQIEpXuK4oT1YcFnPUggqw4Bxols0QKXftxAiBRi7+IJkqNAh9EsvR583kpg0yY5DNapg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752109208; c=relaxed/simple;
	bh=eiBObpu0OyICRV1/hb2bfl8DFGvuu/LO+cfjMOwW2go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LJu62ODwMzTl5FY4UGTQEaDlZhNopKqh8lW3AdH46TlE531L8mEzdOfVG9JcYiFv0NG8lOVQEanVsuaLfVV+0/7RQ/gGHZMAjkXKGAwOMSlMhpTiwhxfMTp94OX1yIueT5GA+tu1Ll0hLUNiICtCzeSmqcSDCj4SYTrQfW/AhkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aMTrnzJO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hvasdBEt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569NH0NA010606;
	Thu, 10 Jul 2025 00:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=XJpzPmcLv9ICMmpCagrffm/BX6P4D/XvtKHU5qQVYJg=; b=
	aMTrnzJOA7+zOMKPgAfWqCrDZOiQ8Lneal5xRt2gurSOcci05CH9uBM+mA2mKIKL
	HFKyBSmJWsI2f1JUP7uo/eD1j5W5fOeYBbwFjhKdj0sK7C6Eb7FSf8gJ+3Mt+Rst
	3R/tdwC7qlnHtEr+Qk6OjkC9j4GKXdpZnGNpW47kBZ/fXlsziu1sIATzPDG36GGg
	9l9TXzQpc2800mbwlYdGKQHN2oM6undac29Lu0LTHaqcWuhS691p1zFAWjpljgq8
	MhdPqOUXq6oYfSCNIgSrS0Sp9iThZm4GLG5oFPqNRL/kPpl+YkBKqog+8ldAnEOF
	hNGNF3cOs1jThCOJO6/l/A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47t1y103dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569MFbRU027404;
	Thu, 10 Jul 2025 00:59:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgbmryr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLnFA/RCX0usKkODzf/TcX7MpwhG4aayR54/D6fIW/xQzxbWqbYgfcbo0EPyhyD6TcAsjVuZnytGqrU2hbEaGErWjKdtQM6JKP4s0hp7sCB4U4gBShvHDsmw0eDGcsk5Cbv4YzAsprfegvJ56uXtEQMJow04/3gMYkY5Jcrguj7XF9F14dsUROwmJK9W+KF+Ym7WRpGqbpjdq8J7RVXuBVZewKPgjEdyVFneg1JxWN8Ok3r/VXhwWDcex6O90IfAi+wWnk5TkhTFAXiEwFylsrd45RmiBJj/rhXCoYbCIL+b55vUBfQln0flBmVEoqTc2uIaV+9ikCbqcPetPBuzHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJpzPmcLv9ICMmpCagrffm/BX6P4D/XvtKHU5qQVYJg=;
 b=eg+xf5wSmWSOqS3Go5e5KjnOzx6DC6gQlLPNk37yKjk0DS6OTsT+Jq8uDqfx49tlnsbp2gd2eZayRfPkwTEQwVjJHk2DlUjEDoWNSXYywmu5AS1M9TYmMZ5Gx1cty4hvAwpKmyqU17GnWQCaTqfWEFXfZJTAWrCVVoLH9W1hz3ZE7844Udtse2UbE5lH36b3+goycMPmPDaOBMRT7rhduxHgQpGD+IkTHFSVGqzo0L+Gn4hmEXXmZlY23EhQkVGLhYeylM19D+39mgbd8hIJg6u0iNYLFIMAE8djZcutYGA+X/EgL/7keHaoHCGGmQA6Zr31JtLhlcy4Q5exjel3XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJpzPmcLv9ICMmpCagrffm/BX6P4D/XvtKHU5qQVYJg=;
 b=hvasdBEtTO3R665C0aUOho61V+FwqYfg/SpePlIUBkpOfCUnu+okS9D1mRnF9bVmMhVNMeOdTres0sVzr3VVK9LPUkUwPUcB2UMaFCQri3mPJCziXUPFJ0rlTaKN4HLB1PB259f/JMxsh6G7ifqU5MoQ2c4Awss4N2JbCaqe/jo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB8078.namprd10.prod.outlook.com (2603:10b6:8:1fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 10 Jul
 2025 00:59:37 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 00:59:37 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v5 05/14] perf bench mem: Switch from zalloc() to mmap()
Date: Wed,  9 Jul 2025 17:59:17 -0700
Message-Id: <20250710005926.1159009-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::10) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 0862a96d-2b89-4830-583f-08ddbf4d0ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cH8iVyQWPp7LaP++a0NhSyZX/16sB8qBoqbRSiubnZxsabHLl4AKywKSketP?=
 =?us-ascii?Q?1S9nJbDLRkvUMAV9dLx5c+1M+mXTc5+TFO7i6CTLTqwDj3D5lhy1PQ6NnBco?=
 =?us-ascii?Q?9oZ/fDV6ljOf0YKLNOnK4f24+3E/3bYdiHO7guZYi0clLTtGQtDh3rvMld7C?=
 =?us-ascii?Q?udJseNR8PR/b4Y55AkAiu27+rvPKFi/6KU4O6j2aHVH9V8oolLfTMwyGGQKd?=
 =?us-ascii?Q?14Oye+wbgHxv8hIqYVf2+3S7N+FoteQ6cqpnv9wqLGHO1+kbk23vplFNZWXp?=
 =?us-ascii?Q?pVDCMZawoua/0f+G2GGs2jd1MwVmIguc6Pm5v2p1KsN7zXo6DqV7vTly4ZfH?=
 =?us-ascii?Q?VKU8CD/pWCfthiKnc74Lhp/X8eWgxEhxkSLLVslV46GrPAnwDNHqO/nNpbRb?=
 =?us-ascii?Q?9gbipjg9zIOKkoKW0+JlzTHxBxtA8j1QG1q0vGFm5XzfUXlpFqYAw1aCp2Sl?=
 =?us-ascii?Q?EqFX7LshDIFCoGUo7m4BTJKjWf3OMmnQph2B7IWA3AcEz8UxdfA+fIfIey98?=
 =?us-ascii?Q?FZ2ZOyDcqu6ryuFsWiHrD+qNIr5wfotVqG2AP2sZNCyxcgsUq8ZVH2MPonGy?=
 =?us-ascii?Q?8qkS9fnuvf+pZwWm2tYwSaawqFsaHQvSb4kvKtfuj3AaoLrf9PU6vCmXLHYO?=
 =?us-ascii?Q?58uifokb+Z2JYWrBQXh9Q8NB999O8oTSfyzwU7/WPBgEhnHeZP2s6JFCUUzl?=
 =?us-ascii?Q?PsWS0PYUa29q9pxDouxE3I5KWe889DsGDKg9PhnJ5V1oKfLDObei+Wr7oONX?=
 =?us-ascii?Q?0hdy41szco6C8uV1l4eQfOnVaGmVCZ6H1QayJgj2KX+84lYubdSVaK1oFit7?=
 =?us-ascii?Q?6XW34JyW4sUvFZlJGebvOVAL/ijwEi3RJLn2vDD4zv0ozc0XEvS+Xp9Bo+b1?=
 =?us-ascii?Q?SoZ84N/rq0Af3s/Qv82UhP/ipVGENseFtRQJS4d+7xKzZivJQ07Ko2gGmmEl?=
 =?us-ascii?Q?gNLR8/o/zZHCiD2aoIEkyIFyDHNV12YDmlov2T4a9fVdzGSNWsZcly6BLUUe?=
 =?us-ascii?Q?UcFtcafmGOI16YsgqwGKBLOWVSQ8BT631P7uvHgEentaiE5hdY8XqNhhWwwW?=
 =?us-ascii?Q?UMRlL6SGOMbU5E+2/Nx6tXhEBicwNHktMOSqjlkc2t5ezpur3TFh1uAxymdL?=
 =?us-ascii?Q?4HlnjJNsB1JSmIEYtKcU7xeGleKyVbVFTFcdC7kKfq29sTihYtJ15kPg1z3C?=
 =?us-ascii?Q?B7XWGvO+B2nZpi1VhQkRkMxSekB5ErM7NbXogDd+5E0Ml+0XxuUITSyKxVYE?=
 =?us-ascii?Q?hgVNmDBwBMvP2drKLz78fMHmUD/OIG9jAXFzQRsEOzVJhZR50O5PxtyoQV/s?=
 =?us-ascii?Q?6mVOXYmZTmLX9oTvCsiyPb+XZ3ga81c81kid9Z8ulKzId5ynapkEgb6+LBUs?=
 =?us-ascii?Q?Tl17WZBpUBOacNrA5T/S82qMPApe4CGbvWwVYYx/eCV//VeTis6aw5Is4GMY?=
 =?us-ascii?Q?RbpEH+zOfrY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bkebHwJ3ToHR5Bp9quxYcwVUjBBc2xmPfs8vNpAuaqqU1Mqmk/ldzUTHa4Yz?=
 =?us-ascii?Q?B4ucYBEmnxZAICLix3kN9iqdGzSWckUNMsup7av2ZwHLp8t/WjSIA08CAfSm?=
 =?us-ascii?Q?sxGu2vaGaGhXPyo+6I/JF4E+02g4AY0c6uipRfwZ687y46mylDimJixWreM8?=
 =?us-ascii?Q?kuDz6KzvQ1KvVl8w/z/npk4kUZ9y3Nmp5k9IkI/9TK2Z350zYdcd5TmMtrA8?=
 =?us-ascii?Q?seKVGbaQmhfz9Lp6WdyneQsdpRXja1/S6vlksH7mFH0Ac8XJbTZkDjK2mDzm?=
 =?us-ascii?Q?HeKgD2mn8yrJDgsWEMuJHv6jHrbIlg/ztgLPbZkHFklVn/Ihbq5o+Wj/Eapt?=
 =?us-ascii?Q?6AQtS3sjrrNhg1AG7orYws+kojPZfFzBj80yw0+3J5buIHylEO5HV3p6fvnZ?=
 =?us-ascii?Q?VbLbuhYF9hN16DTcdFHhLKW+5N55/+GlRCd0UWI3A/Wu+KMuivxRqs/7FgUH?=
 =?us-ascii?Q?vlRm1rrM6zKVLI+AunDl4g5UuYNBAgO6yJHmSEtOlEwvOl1f6HQaRWBO88Rh?=
 =?us-ascii?Q?9+oFZpKzdmjR2VUgg3UfDsPqw6d+CHhqcKt9o3rl78c1jQtkgcVBoxuN/gaV?=
 =?us-ascii?Q?8o8u1mS6sjuy2AlO42IbGNlmXoPF1gNz5Acd3YfGvjpnp+owpmBpiVkX1lHC?=
 =?us-ascii?Q?vhnUgGPeNHdaaKY6RRwpyZ0fqiK5P3h8dV6u0BzWf/8FxoSphjvz6fpobW7V?=
 =?us-ascii?Q?jPzhrzv2n1nv4DbK7ishc4DCt6jI2Nm4JUyVti2oH/x0lhuqJHAOJLJp9O3U?=
 =?us-ascii?Q?96/Y/dklwVgVpXGD1nb8QjJW+gJbs4sxwVEWTET8pqpC3NIa64uhZAUoimZY?=
 =?us-ascii?Q?fgRdGFtQqeHvSGaZCJOyFU+Q8eMV+EpU8KlX2Dt4pOJIdUWIfMy78TMTucr5?=
 =?us-ascii?Q?XCX+Xx14qDrTPY6Nsev8FD2SGwxNfH+1XwgmkGO9XCa78bfmQfdJaNR6PJs5?=
 =?us-ascii?Q?f9G6ou2VXpZICrrIV6hVYpYy8oXH48cMvGgnoaJbW4DBJFddu/c8GmbZOXgT?=
 =?us-ascii?Q?lSVMJDzafWqyCpjc4RF2KIY7J6F2Yrt1PTZOTJf9gRrxZ6MK4e8dCOvm5KqP?=
 =?us-ascii?Q?pf/liYWameJgs0q4u7iwV7oG2zHS6d1M+V5ghiJ7TTSLKU0F1NMndxHwKzfy?=
 =?us-ascii?Q?jeQAnRY6u37m9CRMboo+qBwZwD5CXadQ2byBLxIOzky+yo2yXgpgsMnvwGO5?=
 =?us-ascii?Q?Rh3h/IN5TKarH0euy7d7daGU91JRRw8Xs9ei9Ccy4BxM2C/sEV68/cgSEhTQ?=
 =?us-ascii?Q?QanpwIR8Z4M3nk0Hdbr5A6eZbgzVJ1xkV+RP1QOZ40jnzVSmFf3xUtFXawfR?=
 =?us-ascii?Q?9BCbRCdYSffcTMNhgIbtIeBKDOzkIxr8/u5E8wv3KJwawkYJeZfCA2OoQGv7?=
 =?us-ascii?Q?F0uMdGPEUIdy/BMlfCX/XlzeckZl/36JRVVENGnOQV7NulvOutrendysU7GC?=
 =?us-ascii?Q?AJfPl0DV8a3zrG78uMB44+/zQ0Aa+jivcUH0dy3SWuhra0ECIcv045drnvA6?=
 =?us-ascii?Q?+yI0o3p0TWmzLa2XPxUVQyOrMQ/FrxooAJZ4CLLMLgHNdmZNUTiqcdjZdwg+?=
 =?us-ascii?Q?Vd5zVW+dZoKKC/rwNbcuMA+hMjDP+76rclbD6WFoFbhzBsLKsz8uQ27gAOcX?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ISkVHoQ6b43/5G3l9RTEGwyfsLqnThIN3VPBDq6NC5FLQAdzcAFYt7QlXCHnqyYGPa+0lbPIZZMMvRWLW5jJ/lBgmu5X6zhIcq2J2wL+iu3lA+As5BhWG2FZWnvMO8j9B1E4SNQBQ7JbW0m+q1jHYPaEEPg80JPngjn/ZtWCKvRfwRKnel5ReyOxbEpkKEww87omZIU0pN0VXAVFF8quzuQKEqQnTcdWA3VS/OSG9N/pvMSjdzeSiVyflBwnlm6dsRDkMYaignguFrkTfeqzc1KwEC+XBSjeW6wAV7LnQSvZMnr5xTF3xCjunmmX31DXwPFKhNMMcJBBL+BBHoZlPHqAtxvJ+d7N1xKQWwugA19chGIsuGzdOmJ/nVhiLxGNsM/S0o3OjY/+tOY1i3ycTMeq5yjp/WUWByd9fCOz2CjXLXiXtTOsKEcLO6oNXlCtrGCxZ9Bkd6MiwWEVYIPHK1eJJCsThwdGdUVy4ryp7hAhIh+6vTjZX1+nNy+mnKSfSe2slLdjukcE/uAd5jZmPJ6NTcsgTHqUTwhIZNixiSpUARPDEV3rbfYSxPsQIgP6xWx/vmo4K7qn2FuVsm0IlhhQ9y568vkwB4BJcRhrhO0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0862a96d-2b89-4830-583f-08ddbf4d0ab6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 00:59:37.0782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 014fDl8bmE453u+/MaafHkH+rPi1vKmvEcKlLjcekKPlU14rs1AhONmXj01d6T1Y7rnnb5yf0MjoWCjsL7bG8Pp/ppCiFyxOxw0NC4YB3O0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100006
X-Proofpoint-ORIG-GUID: N7FhP7ZoqOamyXpOhfbMSY4Bdyw8T8s4
X-Authority-Analysis: v=2.4 cv=UqtjN/wB c=1 sm=1 tr=0 ts=686f1083 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=cBhH-oFK0cR11e0Nsv0A:9 cc=ntf awl=host:12057
X-Proofpoint-GUID: N7FhP7ZoqOamyXpOhfbMSY4Bdyw8T8s4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAwNiBTYWx0ZWRfX2EG58uiRru2Y Q3dTOtsGUOIc6ta3IJn8OIR9B5s37HJCZPlrM9fSp/w9TrzJ5JhnXTqjNBv1HtsVAe9SpSEn3tO oJsY1lZ1XKX31RVOmtou81NXqbSQiMtfg1Kl2N25WxR8khQQnu4eNU3+90w9T5eDJa+17BtnDdi
 qPmbQdwPBY+GiFkNDO0YYLLWz4spCQAGqQRjEvqUinuAqTNqTfBJEcgSnjwMCexUxgxJcTu3n/O onNfp1gl6fXjqROgmld9U6jA5EU2mCVQLN6voWddB9/cIo6N+ZnrsQWjUnKfcGAkh+kYyAjorx4 sYAG2Ol86w4rvcC4w6foprJ1BriVcLKX+VNJ6eO2x7Yta6j+v42LdflnJkVBbDl4XE/4SqdzY3r
 wGo5tPO6Y8Ai5x5f7qqI1s/MVx7htRr2rojerPf98HnoDWTatUwRBemlHYTYcsXC1xcpbQrl

Using mmap() ensures that the buffer is always aligned at a fixed
boundary. Switch to that to remove one source of variability.

Since we always want to read/write from the the allocated buffers map
with pagetables pre-populated.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 tools/perf/bench/mem-functions.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
index 06d3ee6f5d69..914f9048d982 100644
--- a/tools/perf/bench/mem-functions.c
+++ b/tools/perf/bench/mem-functions.c
@@ -22,9 +22,9 @@
 #include <string.h>
 #include <unistd.h>
 #include <sys/time.h>
+#include <sys/mman.h>
 #include <errno.h>
 #include <linux/time64.h>
-#include <linux/zalloc.h>
 
 #define K 1024
 
@@ -285,16 +285,33 @@ static int do_memcpy(const struct function *r, struct bench_params *p,
 	return 0;
 }
 
+static void *bench_mmap(size_t size, bool populate)
+{
+	void *p;
+	int extra = populate ? MAP_POPULATE : 0;
+
+	p = mmap(NULL, size, PROT_READ|PROT_WRITE,
+		 extra | MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+
+	return p == MAP_FAILED ? NULL : p;
+}
+
+static void bench_munmap(void *p, size_t size)
+{
+	if (p)
+		munmap(p, size);
+}
+
 static bool mem_alloc(struct bench_mem_info *info, struct bench_params *p,
 		      void **src, void **dst)
 {
 	bool failed;
 
-	*dst = zalloc(p->size);
+	*dst = bench_mmap(p->size, true);
 	failed = *dst == NULL;
 
 	if (info->alloc_src) {
-		*src = zalloc(p->size);
+		*src = bench_mmap(p->size, true);
 		failed = failed || *src == NULL;
 	}
 
@@ -305,8 +322,8 @@ static void mem_free(struct bench_mem_info *info __maybe_unused,
 		     struct bench_params *p __maybe_unused,
 		     void **src, void **dst)
 {
-	free(*dst);
-	free(*src);
+	bench_munmap(*dst, p->size);
+	bench_munmap(*src, p->size);
 
 	*dst = *src = NULL;
 }
-- 
2.43.5


