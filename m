Return-Path: <linux-kernel+bounces-725219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11319AFFC1C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E200B3A4ED5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B436928C5BE;
	Thu, 10 Jul 2025 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pf7HbS65";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SnRel/31"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0CF286D55
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135896; cv=fail; b=RNt/Ti+5f62lowxGkVMcAol41l2Rc1kSruXarsykcdUHeGosD2MvNfAvaCLPRyRvriiLooVFWP9DDSeO+69EQ1/XH/QeRZY5ppewj3MVNcEgeKIZmn6GdK3ttXTV+2Gwk6OBuZumeSSIv9vWglY2bGyNNqKDZvIEBiUF5aMA4Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135896; c=relaxed/simple;
	bh=TcF/2JpRYR/GmOxHhiqqpn7wfhRGTKF1XrZTLOSIVr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nhvPOXMYVAex+axpuHknl45bx6xNjp3b+jqCFx15opPT/vxSEBiCHuofFBjHJ29snM/hPMtV6yOkyc9STcEJyxogZ8ge8LMMGviBw273Dy6w7Aj1iuIlr+u3EVNpvEnvfGl31jkfPCGgSYr2NmkEOcyc+lI/vkazJipPcVoX5Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pf7HbS65; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SnRel/31; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A8Hldg014771;
	Thu, 10 Jul 2025 08:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=3hft6Qen8ntUtwtNKI
	RN9fE0UZrTPomF/R+EzBaGDRU=; b=pf7HbS6537ZKzCxTXGy04thX5YoI7Nv7OX
	hWd24Zpuyg2UZqUgIGzor2M4VnfQzXbGSRAxn4hg2yEsIY4UNEjXE+kl+1NjceKs
	0nIdndFrShjFNIlmNHfjlphowOlmugOKuUmGWEezUo/IzOTNx7qX2hPrQUx1GMEo
	6zpGMOFXxweA4xnslSaUTUhJiIOpX7MuB9p/v2LAc2pqWOkas5NovGTcebup1NLR
	zfM2s0H/YsIY+Sxe0A0PzU/oJaMZV71ddhgGd6/EADgFh3E570p6lV8J5ZrQvi/X
	TR4TseXf5evHuRcGcehMfvSKAUgBWBQb4rtlBNmlYpbu88TzKdYw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47t9v8r0aq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 08:24:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56A8Dhgh021368;
	Thu, 10 Jul 2025 08:24:37 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgby024-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 08:24:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAVfeVxqEggMKPRVx5f1/l3sHLa6lmjfOUhzHK5TIJXkXgJh8a1DY4fXYb+/PAQYce4c4d6od46eHMWfW5A3NdOB3xGZ+lARpdu/zd7pUdu3dXbtrS2XTKhnoubiud4KeEgaRkPdEai9IlS65QJbPoHa7Z+33geFajM4nFXorgzwjU71YCPqRsiR788JzwtCRM4PCBcrQPn39IrBxd+QgtW5MTPt5d7xEKfmJcom+dBjddKrN3Ck6Ayxbt3szKRvAmq0Eno0jhWdfMJEMdYwPVx/iU9jU2YoRx/ynQjcBHqkQZRfisYT0t6R2s4v2hZSqcounB1uvfSg6fNxHgEWYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hft6Qen8ntUtwtNKIRN9fE0UZrTPomF/R+EzBaGDRU=;
 b=gF0/N92Iwdy0iGo8qP9dpcvCoVLZaaKLm4UylDtuKqvWp365YhOsHQVocG0rTgOMhqnytRRgx5ZUHHRK2ceZwFE9wbNWVV+bRqBC6e6YtaizD30k2qXh/BhV4XnpPemSsOfTPXfPYO7mng5COJJBd0OphIn6RXIoYV+4p2oNcsI8F97dx+zcN2KROFYKArT2Y0sE6tMkZJZUb3UhmkgBFOe3trb9I7uws38hNWPIQqBeq6jT3XRfhLv73Ic8gTm/5DamCFQXIZByTACHyPCbPxXz4iuIXA0ZB6vOCVWlc4N7gEa4Tx/th4CxDjDWewcs9AvIavylXUQ/DA8l8hsOYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hft6Qen8ntUtwtNKIRN9fE0UZrTPomF/R+EzBaGDRU=;
 b=SnRel/31KM2wGAjdNG+RqOBDXtrkMB5TU4yIxQRxfIV5jVBoC/MKl3Hyr0dR6tbHqcQtGPcC4IE6RFQtkaRc+dasFlSHJHRhqkO8Tr+wgUX5pI963qnjkdE1Dsqo/2VDUP0NflkzLq753n5qVv2TbqJgpJsZJedRxDhJW78GpbY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN6PR10MB7466.namprd10.prod.outlook.com (2603:10b6:208:477::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 08:24:35 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 08:24:35 +0000
Date: Thu, 10 Jul 2025 09:24:30 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Xuanye Liu <liuqiye2025@163.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: simplify min_brk handling in brk()
Message-ID: <6fe9455e-0411-4c4b-b070-b8be2da76b3d@lucifer.local>
References: <20250710025859.926355-1-liuqiye2025@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710025859.926355-1-liuqiye2025@163.com>
X-ClientProxiedBy: LO2P123CA0089.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::22) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN6PR10MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e79dcd1-498f-4b92-d750-08ddbf8b3433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ncCnhYpqFDG2FMYPRLRbgeuNniF5pCPHqSqpA4kTqFSMOZstGxVB7TOn+vxs?=
 =?us-ascii?Q?O4NqeSjUa3lzUPMuKT7eZwFfBbvWjDbsG0liASCUljZ3wssxbqImjxfKMbIa?=
 =?us-ascii?Q?lrisn22n1fDAxInTDgHL5RPKz5Nh7a/CaLPTAkeWj3jhcMH/2HpGs+jMonYN?=
 =?us-ascii?Q?txUS/5YFfnBJ82tRZA7fIu4gGWWMBepiSUexOLVnSIU0knZLKOwaEpYRiQa5?=
 =?us-ascii?Q?nGh2pP1RvxuHgiEtqvq/+w72P9ho1kALU9yEuJim1VlzgobGgUW/7X/fVn5z?=
 =?us-ascii?Q?AsUaTXx6F7x3qPYOA7dJ1bl6vMEgBVQv5UKrJKAFjcfaBOxzPvmEq/P0MpUW?=
 =?us-ascii?Q?yXwcngCi9bskrOh52LWJ61gnXDA+4B+4QYmpobi4j34EzzfMzMPp/MfIUoxH?=
 =?us-ascii?Q?1kJoVnez+O2Vw03Ve7pAdA/2xHD39Hgfe9EKwO86b6Xq0EvDCbMAhUE6VJ8P?=
 =?us-ascii?Q?N7dJs/29UzsK0kNMAGrqJv1XTZIPBTUicc1UMMQqISLY3h5MpLJAFIvC1Hzg?=
 =?us-ascii?Q?4R5pNqT6zYT0IRWhrY4IUL+jdnbTPy0hLxeMfkTOVOoRG+YP+52MINORauwb?=
 =?us-ascii?Q?ySQUSh43zxTzgx6jlk9KnWp7w/ETNXNh3MiO4kI9DSmVEjop5HqjzFwGLmqj?=
 =?us-ascii?Q?CJkc0nXqFHSteoJ/W9xA2dHY7ZUH1wklOY8lDMgZG0Vm325zZmtXI8sSplSS?=
 =?us-ascii?Q?/urbFUqZcOxlap6xrCUy1ld4xTanpKhLUbPvf9X0mn2IrlXIzbVWltFBv+tA?=
 =?us-ascii?Q?hS4IqVyFYQK2KhJEyODfUH0oVLfAWFyodCL5Fav+KP8Lo8SkcsT+50ZjCim3?=
 =?us-ascii?Q?4+7ZvRr6ymQqZNzJdFuMZPodiWhM9oFkvfDmp0LMS2OZbhbRt7HKvIkM6XPn?=
 =?us-ascii?Q?trB1t8UEkYGIfJLikDboMnajh2e1hzWRfir5mCIYyZgqVe9D+f4hcmm1UDQ1?=
 =?us-ascii?Q?Gx7Jj9IJR0lPf8AZLarv/I1bDnQx3pw5mG3wchgT/mli82QoyVtHuKduAvun?=
 =?us-ascii?Q?5QY35iuuq6pshP7SdvJ3OT1pPBi2rX5MCUdpe+yl6dcBpP3xgykYF/h/pOnX?=
 =?us-ascii?Q?iWJM+hxTbi2fgPPCOedrQcffnNoQmOEzSS4JcplRmi1F6JawXP2VIbrV0rqT?=
 =?us-ascii?Q?miqG7zvfH2pwzgnDL5MMOwPEbHx7k6NvZAihF3p0EpaXbfp7jxsOrLD/7qhk?=
 =?us-ascii?Q?i3RkcB6o0+AzDZAOlFC45+OwksSeAjtqI2H6vw0fwUfdPDyiSf4hmopdvNTM?=
 =?us-ascii?Q?tLvfPkNHZlWus69FOcjtSTc/APnrbvSQ9rNBZMdQkai9j8QMeyWGN9Gwgrv5?=
 =?us-ascii?Q?PZwW+ci1V2Hpgy+IqJA/FDWiOSJQigWR9yrD6M+sW0yY3G0wI1loreMuZ8/8?=
 =?us-ascii?Q?jrSWO7r3zkrQe4sgfPk9kX1l2JCgF+WWHUVhkm1p26kA+jW8ROqff7aZqErn?=
 =?us-ascii?Q?9NHX+/FOTb0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kh2qPE4xaWTM/c8FozKSL2niCcZP3TVGEGNbBlMvDCKQw/5XDKD9vKDq3PdW?=
 =?us-ascii?Q?LpIQDhKFlGUKckH/r6PHsw4bepicC6AYQl/2Kbye8+0KWc++MXOIKfbxfddH?=
 =?us-ascii?Q?F3jDWS78jH5byn3ut+FxmruCGkmfzOKT8lDyGXUmvJFwXrvDapiJ1pUXBQbd?=
 =?us-ascii?Q?sbXzF+LAwbbc2MDj3f+BYV8vq6RT5z/AOsR7RXCEc4hS3G99BncNIYGLqXWQ?=
 =?us-ascii?Q?t30n7dvp5+WME0OQ0bCp9m9/5xp6/Gmp845wcDuzbaRIr5zTysuzVFcQhI3O?=
 =?us-ascii?Q?US/CihkoGLzzb9e3MJUYxijc278B8IavoZbpt8pXayhKeeaL6SF7VwDgK698?=
 =?us-ascii?Q?97U/y94y/LpCGSjXrnJPGuo0QWHr/STi9zRoiIvv2bm9C5qqAG7LKzSzMm7I?=
 =?us-ascii?Q?RUDCS13He41sotdZDRk2jmpFpHnYsX6ZIxeCqj/9KmK+01wNub9Y9lD/Mbuj?=
 =?us-ascii?Q?TPlUH9SH1QSp52pyh3QarUNGT1rzNpSGRcF7HEhLUv/Jbx3z1evVSmQdxpZQ?=
 =?us-ascii?Q?ew9ulKRRKEEYbsySTXGZ23UNiVpxfrVYn9V3h2oo8wr6/fp8MVOXr12O3bN2?=
 =?us-ascii?Q?4TMPOn7m5bB6DjXawjCB5MTeckH2vS/R/E3PK65KfNcDGQ08e5mPVl/WAokc?=
 =?us-ascii?Q?8tfzOtPXdQbZ1ykPS9wXa3qJUnMsFIDgsa9XBusR+OvzYiNJKtYkW4UwMSuN?=
 =?us-ascii?Q?6KBTSMyJF+60+vjdk+eI9xe4VLEIjTyJcS2iS11+r8nvrEm0jWKSPI8ocy4P?=
 =?us-ascii?Q?MIL5FXguOxvaqPYHpqWI1rMphYMUJFnL1PI1UBJewCKEn07eZjdyrXFadxQ2?=
 =?us-ascii?Q?PLb4++Ygfadxv9eS64eTeVBd0EFRpCRnaj2jiJF26cE3IrP8b47mD4bAYJdS?=
 =?us-ascii?Q?Kxi44BRxnx3D5ZKSVqJWcLKy12o+u9jNOIku6GZ0vEPrZochzpYmMgLsWeOf?=
 =?us-ascii?Q?AmGyTDFo6O8rNMuap8B9DhUnoMux+92SHlgmCsJGrrp/6HjqMtqCdeG4bv71?=
 =?us-ascii?Q?Rw4+AJiLJHZPvv2WhOBpDI2hB4pnIvR61c+imVe/PdFW4uEYFhuDknYogrfw?=
 =?us-ascii?Q?cLS1bGpk/uG/7sgrMeg6mq4MLq2iKuei0rBnLNGMnsGaHu5gdb3L/ZF0Tf1+?=
 =?us-ascii?Q?NSCP10RnUrYFGGD+gP6t+pcfupoUs9Y3Rvh6HEVRluuw9V0rDU8B54uDfadV?=
 =?us-ascii?Q?F2lnqFGRbXSsJCem5gOlqB7Cx7pGz7y42bJAmLPIhec4CFk82P79kUfHo6Nk?=
 =?us-ascii?Q?ACSfzJVzp0Mv8KSaTC8/k30WxJZSA/9X5YSYENSP1pcn4ZaKisIQbwyfjDmO?=
 =?us-ascii?Q?BQfOmt2jqXaTu3C3xaIMoQgF2F3V4k4BvPMrDyAlXXQAKkYNFx27VWAizNVb?=
 =?us-ascii?Q?iaBJOvibTt3KVWEyLxVa+zpsYsRccrnsPgslUkzdYx8zreT5/5V3mCAw6lMz?=
 =?us-ascii?Q?4QWD7VEFDn6AxHINfUERxKSEU2LcTLpvAlgGyOEC6hT6Qnh/Jj1jF3/VzGxX?=
 =?us-ascii?Q?V57XhxpW7K3rrgW4H3SwPIzP6VVK0QYvlTfNMDW5lRu5n7ye+1OIrJnAurcD?=
 =?us-ascii?Q?w4k1BIdavD/MayeKfJHUBFWHYfHKo6ejDuTUfVoO4GunAqmHUdtRzelEASIF?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8y6UNMf2TJ1yROZvPp8k3tg87J0syWNTiUIjQQekUNiv2zZaluTQS3U/r3xqY3cl2QCxxa5LU3vvrlJ1Ls9H/bT/VTYTvj2HCy7mzNMPwnv1XM8pKQZyblDf3K7bsmp8lh6Oz+evMvuRE8cFjG8xUBz12zwJH12UVrvGt8UOH/3/CkpFWLb115qEO+lLYgNNHrq4y2+GayY3A1KAqJkeSHlTYkxsEpXdc0RC3lSII/yEpYMnhXdgKEhAF9ZYLJuldakD7+Q7amBwCnl9yY4LypbVC9LZIKXPHqEmzHO5kb7evuc2l5Z9GlziStclFs8YQFcJ2FAPZIYTSM11zK/yIS87IeC2LSkvx9qgtN83G2nN8+KC+poum7gWJma2nIFWlr+GLxmK9iSzVVuhcmA67qmDLYUpWuLfVvE0BGrDaRZj/vRNarNw/z0kFrfGdVMxPfFav8G9q3zyuz+pSRkJWnZ/7rd7JQyAc43U1jQGBSWgfZ0Rojui9/5H/BtuzgrLmESAowmJWYo44Lm9UI91YpLPw85zOC0IDpySRw1bQxC8yPEhyB54ZLNgmGE10mPcad1jXb+H/i7wqHrhJuiNAT5XqLRlKHDCLGnK76gf9f4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e79dcd1-498f-4b92-d750-08ddbf8b3433
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:24:35.4352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGg4E350xZ5mtP6w42Bi7YOKcs2OAhyQ/H5RNAFcSJ6tLyoAdnsGqdgMpFPP0zRjtivuSCWoMXFhhQdG0gB2Y2I8HQHZESfa6aeWVLWN9YM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7466
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100071
X-Proofpoint-ORIG-GUID: E0G8v8h4UDHnlZqifvGqWkguPjR0lTO4
X-Authority-Analysis: v=2.4 cv=apmyCTZV c=1 sm=1 tr=0 ts=686f78c6 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Byx-y9mGAAAA:8 a=yPCof4ZbAAAA:8 a=Z7NndTzdiX1okUkry1YA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3MSBTYWx0ZWRfX6XRP8p8CRfDR PtsxhpRmB4Q3hgysopG/au0Li00IpTu2fdG6zWP3t7pNr6pyvlPpE8uf3ZxJ0SeGZC/G2X3QcQx 9OPseuCL3b9gmZCIuDEcL8/r8HRy+E12H+mHUlBmFAJbu58mx+ddyp3ldHhebqLGwYTjEYr9XTR
 8XXSDRZjQ1ObfZBtQM9guDvW0WOVstLmthLUPqn2KYTEa+T39RJyllTV5xbHROfWqqafEyMR4lP i3vOwxcGeIQArBuX8cm9Vk1Cfc27o13HCT/R6SICiFTV5bX1k8pE1aTBEYxxiF9nl/92j9qTSF9 /mkDNIo9QEFRdt9V9lTbPMSjbMHJXSTV0jhneeG6jRx6LuOqzChA9t23iCn0pixEGyHEnVLhfB7
 OwCYJbnD7KflBWFES58jtRKjpxwyvXQXwH+tt8HD7sQBOnk2DszcuPG0qI46e16v+PXzRADl
X-Proofpoint-GUID: E0G8v8h4UDHnlZqifvGqWkguPjR0lTO4

On Thu, Jul 10, 2025 at 10:58:58AM +0800, Xuanye Liu wrote:
> Set min_brk to mm->start_brk by default, and override it with
> mm->end_data only when CONFIG_COMPAT_BRK is enabled and
> brk_randomized is false.
>
> This makes the logic clearer with no functional change.
>
> Signed-off-by: Xuanye Liu <liuqiye2025@163.com>

LGTM thanks, nice cleanup:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/mmap.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d8fa373e4ac1..7306253cc3b5 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -127,18 +127,15 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
>
>  	origbrk = mm->brk;
>
> +	min_brk = mm->start_brk;
>  #ifdef CONFIG_COMPAT_BRK
>  	/*
>  	 * CONFIG_COMPAT_BRK can still be overridden by setting
>  	 * randomize_va_space to 2, which will still cause mm->start_brk
>  	 * to be arbitrarily shifted
>  	 */
> -	if (current->brk_randomized)
> -		min_brk = mm->start_brk;
> -	else
> +	if (!current->brk_randomized)
>  		min_brk = mm->end_data;
> -#else
> -	min_brk = mm->start_brk;
>  #endif
>  	if (brk < min_brk)
>  		goto out;
> --
> 2.43.0
>

