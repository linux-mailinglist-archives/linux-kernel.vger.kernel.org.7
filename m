Return-Path: <linux-kernel+bounces-724721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E887AFF63B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552D3542F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE6F25484A;
	Thu, 10 Jul 2025 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YeHk1gDO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KIt/jMBh"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513C0257435
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752109208; cv=fail; b=gIEwJQKHngGdLzT2C2zyudHjecl26lQkeW6OdSkxipTl9wBSTqjzUbwFMTgsfpeqO3W8YK0kW/R9zYyHLJ1E5q7wOLKxjvnxZmbA9G2+mAH/IkRIpzrYq947e/SgpK8YuMClRUesI+k4+73uKi28D0q2UbpKGLZqAS8IFkZY0Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752109208; c=relaxed/simple;
	bh=rVqx1ljWkOytDo/ElfBQTPoBvtfmmNSrT3qcmH3E34M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qg6VA7K0TZnBJr6zW4hr9UPPqa0kdgBY6bpi+exVi5UsPfZbA+gF6sloWS7v4AW3KLilNjs073+EoxLCbpKbBrtP+XQlIs6H0ZmylKHyN0rC7877E+/KBSikitCscuYJNAAXyxVW1XDI8cObGciGDYlET0zxy50vIvx5gUjWjmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YeHk1gDO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KIt/jMBh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A0HDqA019555;
	Thu, 10 Jul 2025 00:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AWAL5HG/GXS5rVfjXNV6TqFibtg8TeODN/c1FR7vCWU=; b=
	YeHk1gDOiiY1IZqH1sX99Uam2lGrIbx+QvT9QtSpvwnVLMk+vFqnaLHuUh38EAvH
	qwHuwVrVnGPTBieitTqV8RgngyyEaEjbCsPaBF9UzbB3vlJyw4ShRGKMs5APHTMz
	LFfw0pujsnM+3Db5OAGvrNiyFRxuJ+7DFRoUeH7H64Y7vSglR1+X4V4oXBkf7jId
	Z2LO+xZUFDquOJy4DmtiPjUmQZqbJskyG24dq3JMWzjnGI8uI8O/irT9+OK2Vy0E
	JDQQsCTrrlix84d9AAhUn/dI4OHqjFLUHI4C/7sbJlu9SIxQgJVQWDomRrDEmAnp
	bolnB8jOi5TUBE7pa8tIww==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47t2u581nh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569MFbRV027404;
	Thu, 10 Jul 2025 00:59:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgbmryr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAefJ/ALT223gZLub4D+k+/K9s91eb/lrAWqVgGTnDJOOBAC4nIn+1AL3pSZRwFPC2RQqSoP4Hb0x+X6dSzZx5LCjC/PQ7VEH/kjHJcMGdHKUltWGy38a1lTmDnsG49Yo4EvCPNcWqDGVJxoTUuiv2dgL2+SHnz6Cbld7KuDubsuSIGkL87l3/OeAfgfCnXjxEsehcwLDEGKmJ/kP2QvLUY689p4jFQL/KmoVFIk43LgAXgS48JQFgVGi1QYMN18RCVW8XUs3w5ss+b0IuhiyTbgos/9haq5S/9cttRcbjh9pSVt8z3B9rcZHvKL+YK8mrRaNCpRAmvBKbhssQ3IsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWAL5HG/GXS5rVfjXNV6TqFibtg8TeODN/c1FR7vCWU=;
 b=pVmaDT0gefp9a7Ej0vubq9+jWYBOILYhyZYIYnnaFSs11kOKCMriH8Z+btkknNGNHoQZWG5PB3OhchbPTEIiWCnHVRA0Ivy0aDKHi1G78NTV9kdPlX785qAm0rr7EHctunfj4ACL76ULWxPyhrymzHZMgdL/5v9ssrPordvrPB7ith5lTNbN/nL85YdgQuMcFnMHPa1pE87wqlUdpGZ9qP8UoC/sn4z/kXUiji4mdX8A7N9E7Y1y97BrlXP9MirPZKXbAeQi7E5VUowTZMcePuXwVvFm7WNA+EFOB4ZGDNJDm8rlL11559Ox5B656LllQQmPZQX0EVV9TjCbXBV+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWAL5HG/GXS5rVfjXNV6TqFibtg8TeODN/c1FR7vCWU=;
 b=KIt/jMBhM9sUQRUKZxzEF202xqkTJnpIHWC5dURjTRQCZy3PPN7L8+9viv8yjUQiDqOmM0fS7vwwlRZa7tCpik5XOudLp46tGACoyIpfrxupJwri/ZVcyi2qbpEoyb/pjgC0fDX+WZwvcl7xVlxuFj2DAfa3vuFt4V+jKcQBn30=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB8078.namprd10.prod.outlook.com (2603:10b6:8:1fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 10 Jul
 2025 00:59:42 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 00:59:42 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v5 06/14] perf bench mem: Allow mapping of hugepages
Date: Wed,  9 Jul 2025 17:59:18 -0700
Message-Id: <20250710005926.1159009-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: b44dd9a8-b4b0-4fd1-37b5-08ddbf4d0d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rDEayV5Su5WZKZjcgVuutwPTSpV0vN8zxDjuKxlgYJtC1wz2oZSLB5E8Yz1n?=
 =?us-ascii?Q?PtAODzUYooZZxJb8piZ1MWI0ynFwduFgYlZhXp6P3E0slt3CqwZ7BudWlPX1?=
 =?us-ascii?Q?akb+KCxcy9dPEgtbd3tKtgXxko6JO5QRIDc174nqSdcmAa5Wpj2Jw00MEeLW?=
 =?us-ascii?Q?ka5QglRfQvItdfmCsJ3IeKAHd+Hq0uv4mmlkEcuKsgJQ6efIbWHNkqnx+dMa?=
 =?us-ascii?Q?X7h0HZuV+7Cs9Kq0KzeM8fB+uPrcLnL4DI+sTXLYn7Ajzw1LG+UG+M89IQMD?=
 =?us-ascii?Q?q1b8YfKWqXY4IgUimZjyT5Vv5lh4bU6h0HBx1Qc+f0VXdvDdqil/SG6hprq7?=
 =?us-ascii?Q?z65vSvkPUVLwJfF4N4QrqkNBh1abcJ5r7pPqXv1X2uPI95EvGdUS0oTfcoE/?=
 =?us-ascii?Q?pj0mpURC4QQ6zL2Voj6OPfBvxBKM1KxS9O15+Fbtnxdk29i9uwUtch8TcksI?=
 =?us-ascii?Q?b8GPEj4OFpmyMnK1lpyh0EXRpGYzIIRF0U0ymXDWKW8bZWUQ0bpbL9PdGh3x?=
 =?us-ascii?Q?3Y+cE04jh0G/0+ePFGmyQak1KUMz/q+VWEeNctyJw/T6NtO6DUnwAnJgrqPb?=
 =?us-ascii?Q?PLGRX87lGIhRyDxMatunoWhRWFFXtcn8U3au2nb9ikkYG3PZLVJifgOkA81W?=
 =?us-ascii?Q?Jn5ha0fLn40xBL6D1uH5BXfoPPtV80GfZldNrTtdj+hE9kY/pxQQ/0iuHPhx?=
 =?us-ascii?Q?S55AxUIGy9zRVMk5UNrZuBPEPOe/8h8uL2x/S4iemx3LyGg9nGUymlURS21o?=
 =?us-ascii?Q?bBA/NsKxZeZK8qaN2p9Y1iW8GdWbAwJjaQZOuFgFXxAEaLt3P+Y6Y3oUr7i6?=
 =?us-ascii?Q?9UmtZQQp7S7I05CQDRPATg1eROdv60cInxtw2nTCulZ2We0AuP8UJUXabPjn?=
 =?us-ascii?Q?TJxi956UooLDohjIYUq81cVtOK9F0qrA67Fh1dOByQmAOnpZoN6fZL/nPA/I?=
 =?us-ascii?Q?mYySV7f4I+gUdDvN7UNJXFUsZJT14SBEqCHf6NI1yveb2QxgVrp63ZQZTh0R?=
 =?us-ascii?Q?vDJu/2NJnaitn0L5n7m5iVBkPU/PevDGBy4TQMM9uczli6kCTWe/ILIaGxFc?=
 =?us-ascii?Q?qf8RR3zT5IRCG63PTcxnd2Yc3NI+XMybfJlef5dre30tFST+lcaWHesj19fK?=
 =?us-ascii?Q?hdfjqKIiiGIbljmR+eo5U2yUJ3fdPYK+BQ2Pfb9NV9ynJv/FKuHydrjGR7Dc?=
 =?us-ascii?Q?U9eZewNwwqhWm7vlW0yarvp9rPfW7DwbiMYWOSdJHy4ga0gAdnjtJqyLF4tR?=
 =?us-ascii?Q?5gYzi1+yHJrWJ1/UJ8KFQndb3BopknaJhUUW54K155nhSojZniLWsn89+YQm?=
 =?us-ascii?Q?O3Jx1FfvPQHXS5XHN0Ut59/9sL19QMmwbClTb5z7QNZSdjTGfUmvQlYgSFap?=
 =?us-ascii?Q?Lcg8hUWROVcO45R0W/EgGJ+Sd1OMKtA03ao+ccuMOiQS+XVLJWfZ23eHk0Q+?=
 =?us-ascii?Q?oub90Z52RTQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SuRUdRQ7YETKBEExOogkmfOOU+NXhHR+DVJGp34H3aXPov/1LXai77fmNkdv?=
 =?us-ascii?Q?rUGhxCAwYyb4Iai6bo/X+kZpqru2lM0GhxA21AWx0k0LA4fC5CHMacP9r1i6?=
 =?us-ascii?Q?YvKfY3CmUUwEi18LsggIcydQFKAmn77XtcA127ln0lJ5hmEUABWHFrgmlQ+S?=
 =?us-ascii?Q?1e/qXG78Fvu30HAyTY/qZVV5d3deNwJbVfdv/Brw6yEg7Kb0hWiXXwf2L6Ak?=
 =?us-ascii?Q?FACncWALVnMUrWbH/9QdWdUVx0kSGAnyBPH8HQ6l2cZ0+FZmyKQ6sNA8ZQpi?=
 =?us-ascii?Q?P/j4pykw/saIagbjY2jqL4Hr4/m2A8EStdBfQRVio7RPIyRDwL++pDQ/rNlf?=
 =?us-ascii?Q?LkOwB1EQeq701q62C0P0Vi9NWYmWZbDskR70XGI52vrz8O0wFGgKjFlcb1Pu?=
 =?us-ascii?Q?S4pcm9mUvAZTgiDKvZj+CuVDj/gro9yYzJDqxis4xbPtcMqOM3QiHjPu5H2Y?=
 =?us-ascii?Q?lDhaxt/KXxd8Nvav2WNanq2xBR0dX/5dqKtVl9jNsmUNs3mQQgffHD1F8FUa?=
 =?us-ascii?Q?I4B6RiYpmYhgG7X+Dgvxr/ZZMH02b0drzMvKnyhvowg5fVmC3HOxjxBTQP+S?=
 =?us-ascii?Q?rz8cD0frOJNIi2s8UoJgAgCa4HyOSpNbf/SyH2yUUOGp39SKE+yM1VCOVc+i?=
 =?us-ascii?Q?LclX6PzoPvaXu7FIFc+TYFRq5fxB7xaACbRhVkksAv0s/jVz3SLJqrk6taVd?=
 =?us-ascii?Q?+cZBE5Vy2KW7tiIEa2j4rFxPQz3+VRm4lr4LOHBOvsw1LxzIxnvnBKkMNo6j?=
 =?us-ascii?Q?Qinkeg5uVJhbR6TY3HeIBRySW3VipQV9Nw6jKtA8KI9RRXsCydVZRi3iKDuK?=
 =?us-ascii?Q?f3i2cMqk3+y8Vm6R4wekaU2ExreQfNQEt2f3swJnkBizJNTOXcgDMgRplYXl?=
 =?us-ascii?Q?vlrmPm+Lqk17GTa3RDgqUpnjLFXn1WPykmP5tUoDTIABhsDAYD9odUIB0MXS?=
 =?us-ascii?Q?4EZWh1KReoOItZbamxp7Bpn1tG6HRqyVGsXMjqYyyUipYdy6L6f3Jc3EzsO7?=
 =?us-ascii?Q?CnKy/LG+APZqrLF5YxvybHK2JCVmUjI9jHA2ld3feRve9fAgsCyaiqDVQsYQ?=
 =?us-ascii?Q?3IsYe9LDCnlcPWvUBI6AIB2GAL7AJOGYcZHptP0d/RxYrZPU9JL2YGYUTc6y?=
 =?us-ascii?Q?8reChh1Kytr1z7l3kcaH03jLYnttqTK4ad4LEeBH4QIy3alarQOlXEvr34+o?=
 =?us-ascii?Q?IsSZMDOwaVZFRa5CIT6lmW/WJWDcIDByW4EmbSiQKnEurHyrndaePuVrndHk?=
 =?us-ascii?Q?0/Jr0MYZQeGux1XIKmGe1AEu43S22Ey05Tdw+g3N8B8/gxkEf2EXvSSpvI77?=
 =?us-ascii?Q?VZnjEf2B09ykFapXGqfBx9C1iNyqMrfvQyirAlF3jP5MbArPhjA6ZZ1S7YKj?=
 =?us-ascii?Q?F7b+KajZCyPFp2Rgel/olIPDpctnIPLy5ZoVha5nzI3bPcts0q2aLJU1E9ud?=
 =?us-ascii?Q?QCobmFeRayf0/42oqYZMNE2zG4mFEgFxMlUPPkFGoyOtVyujjyZ0uMnuTAUx?=
 =?us-ascii?Q?A/LCYgHI7SUZeA68DxFFDDkfm/Y+mqgdvLhDHGfcwpXi6rUTQKReyJR6iMV/?=
 =?us-ascii?Q?wmLcYpoDpRXmf/Z/wMIVU/tmTI4/MRo2wphLk68kaBpMoixrTKO5THRj01Ty?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JXz+L9igwPEfELIDhkYkMgjw/KF0/lQFKArqFMtFJaUgApOO/0iT1R1JRqoHs9S2psDqy24Q4B4GM3eXMtYQiO1/MnZnfavKCcf3SDElgak3zf4y/fViwH8RLZ+eZka0mFeRDoZgiSMDa030TABzIKdZizYe9ULHFuAKUCof5WC8c1StK0bF6RZpehQBS/eRvt2i37ygutjfyqUa2h2N7oc4FgY468pg4kUVhERqmrtEQV1MN8vJFNm9jpm0nau5FOpLnzpmvkRIaIvAUEs1sFt+ZhdFaU/YpDextz6DP0dZpY4osRMizEXut0EMJZj6l6wFKamA/wJIgZUFzBj96uolcQk09uW7i0hPw5PLf9zpiZZx6lzS4um4B/ZWCXVgrQ2GyNgSgWT5CbX5x7rCzday4efZbLbbhyHZVrtN+z3zUT2mK/YfvFbOrJ8btqKlicOHsxjstmOPVoS2LbJrEICUSbEE/zR3w5XnkwpB+5JIU3zbeHDHNEsT1Fla4oPlngaqP3Vqs9CYMe0Nw/V5rDi7lCqLTyOT1I0bROX0e3C4m98hHUXXjUIyD51vB4diAQ2FoGGkCAtWcUL25lXItdE/+cg1wlWnE+dPZLmVwDs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44dd9a8-b4b0-4fd1-37b5-08ddbf4d0d4e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 00:59:42.0249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEZsBwdyWEwokR/awqWE2Bb7YM8Fv63fRcc5o98D9wdpIlJz3LynlV+xjRnJxlQrbKVChEiiaTvveXruC0JXV2tIdW3zAfgFVmnBO03fmNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100006
X-Proofpoint-GUID: m2bDougtTXcVvZffcnCiqS-XRsQ7XLTN
X-Proofpoint-ORIG-GUID: m2bDougtTXcVvZffcnCiqS-XRsQ7XLTN
X-Authority-Analysis: v=2.4 cv=Av3u3P9P c=1 sm=1 tr=0 ts=686f1084 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=2txnUkrh-zOa5si45iAA:9 cc=ntf awl=host:12057
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAwNiBTYWx0ZWRfXzYG/ZHW8pFgu ihSwLPpY/4VJ4Ql2mwAMFV4V9yrAGVhSN8HcEvUm95Cqw3q2Z42D1Yg52XDkBmXimeeRndfTd8k CJwZrhryA0Xmyvm8em3EfsTR5+LlTYao8Edtx19DyICttaj6IG5XDrY0Hu94e1tI8vsa9UPvmnG
 wqAhqouCru28unxT1YfdUii2cTe7RB9uaDtLzS57g4OhsASL6wjjNKcNum105gx9OvWqRZlz0u/ mZ3kICARMiFfREejbHESu8oLRk5nCXDTfgoA+ZgRR632BA57ZYE1/kL7vEc93inInn2CKXA0/02 LYrOfwSNiGfN1KFL+LEGdJdC4+w1aHkY3cZ+dqE06nn3HAQPBkcuXYl5bg9UAFArcENaKewRudR
 o2MQEjJXRJbwdW0sBdQSABaKr4vgYlDKybM5sMB858zPcchbodSQtnk+qWFMi4VyXOG2nQY9

Page sizes that can be selected: 4KB, 2MB, 1GB.

Both the reservation and node from which hugepages are allocated
from are expected to be addressed by the user.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 tools/perf/bench/mem-functions.c | 33 ++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
index 914f9048d982..e4d713587d45 100644
--- a/tools/perf/bench/mem-functions.c
+++ b/tools/perf/bench/mem-functions.c
@@ -25,11 +25,17 @@
 #include <sys/mman.h>
 #include <errno.h>
 #include <linux/time64.h>
+#include <linux/log2.h>
 
 #define K 1024
 
+#define PAGE_SHIFT_4KB		12
+#define PAGE_SHIFT_2MB		21
+#define PAGE_SHIFT_1GB		30
+
 static const char	*size_str	= "1MB";
 static const char	*function_str	= "all";
+static const char	*page_size_str	= "4KB";
 static unsigned int	nr_loops	= 1;
 static bool		use_cycles;
 static int		cycles_fd;
@@ -39,6 +45,10 @@ static const struct option options[] = {
 		    "Specify the size of the memory buffers. "
 		    "Available units: B, KB, MB, GB and TB (case insensitive)"),
 
+	OPT_STRING('p', "page", &page_size_str, "4KB",
+		    "Specify page-size for mapping memory buffers. "
+		    "Available sizes: 4KB, 2MB, 1GB (case insensitive)"),
+
 	OPT_STRING('f', "function", &function_str, "all",
 		    "Specify the function to run, \"all\" runs all available functions, \"help\" lists them"),
 
@@ -60,6 +70,7 @@ struct bench_params {
 	size_t		size;
 	size_t		size_total;
 	unsigned int	nr_loops;
+	unsigned int	page_shift;
 };
 
 struct bench_mem_info {
@@ -202,7 +213,8 @@ static void __bench_mem_function(struct bench_mem_info *info, struct bench_param
 	if (r->fn.fini) r->fn.fini(info, p, &src, &dst);
 	return;
 out_init_failed:
-	printf("# Memory allocation failed - maybe size (%s) is too large?\n", size_str);
+	printf("# Memory allocation failed - maybe size (%s) %s?\n", size_str,
+			p->page_shift != PAGE_SHIFT_4KB ? "has insufficient hugepages" : "is too large");
 	goto out_free;
 }
 
@@ -210,6 +222,7 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
 {
 	int i;
 	struct bench_params p = { 0 };
+	unsigned int page_size;
 
 	argc = parse_options(argc, argv, options, info->usage, 0);
 
@@ -229,6 +242,15 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
 	}
 	p.size_total = (size_t)p.size * p.nr_loops;
 
+	page_size = (unsigned int)perf_atoll((char *)page_size_str);
+	if (page_size != (1 << PAGE_SHIFT_4KB) &&
+	    page_size != (1 << PAGE_SHIFT_2MB) &&
+	    page_size != (1 << PAGE_SHIFT_1GB)) {
+		fprintf(stderr, "Invalid page-size:%s\n", page_size_str);
+		return 1;
+	}
+	p.page_shift = ilog2(page_size);
+
 	if (!strncmp(function_str, "all", 3)) {
 		for (i = 0; info->functions[i].name; i++)
 			__bench_mem_function(info, &p, i);
@@ -285,11 +307,14 @@ static int do_memcpy(const struct function *r, struct bench_params *p,
 	return 0;
 }
 
-static void *bench_mmap(size_t size, bool populate)
+static void *bench_mmap(size_t size, bool populate, unsigned int page_shift)
 {
 	void *p;
 	int extra = populate ? MAP_POPULATE : 0;
 
+	if (page_shift != PAGE_SHIFT_4KB)
+		extra |= MAP_HUGETLB | (page_shift << MAP_HUGE_SHIFT);
+
 	p = mmap(NULL, size, PROT_READ|PROT_WRITE,
 		 extra | MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 
@@ -307,11 +332,11 @@ static bool mem_alloc(struct bench_mem_info *info, struct bench_params *p,
 {
 	bool failed;
 
-	*dst = bench_mmap(p->size, true);
+	*dst = bench_mmap(p->size, true, p->page_shift);
 	failed = *dst == NULL;
 
 	if (info->alloc_src) {
-		*src = bench_mmap(p->size, true);
+		*src = bench_mmap(p->size, true, p->page_shift);
 		failed = failed || *src == NULL;
 	}
 
-- 
2.43.5


