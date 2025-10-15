Return-Path: <linux-kernel+bounces-854963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD20BDFDAB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 289504F035D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E29338F2F;
	Wed, 15 Oct 2025 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OvnVrcad";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mTqypEGw"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E61330D43
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549344; cv=fail; b=s/npKhRSW4MT1mrT8QPLC7q67uo0N5O16nVy8XtuF8nD2wozGM6Vp4ySXl5rXcvZ9lho2b+2XTDz7+vH9YfD3vFE5f7+BQeGU9wZCISMHrIhqo3nNOEQurHRbXf/RqH7/QrlhXIKIR1QwKZuvRlllI1TM3qiAmNJo7So6F27+co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549344; c=relaxed/simple;
	bh=z0EYwFUbB+p3gFM0RTRJHPIED/Fcfvdue4/+wLizjJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P9oPVpOt7kVjSCxPZM3Nu9Kbiayrc0hcVhzlAqNYhPSsPS3V/QWCCyy/+3AYFQaARbLLkGxUvFlg8BZlqJlYcHMSLm/PaY8NhegJXtViMyNKrMvK+KGJORl8Z9r3ALURsPUGUQN9CWRXn/Oa9QMdUTbgnG2bd87QHktTEQw/RjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OvnVrcad; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mTqypEGw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FGC8B0027600;
	Wed, 15 Oct 2025 17:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=K1TW/mujDpobcihkil
	//fnI5JaKtAJ7/wqworO2IbPI=; b=OvnVrcadicZ7t16m44TR5ylKB2LwwXqsno
	BULEVfIyfUx7syyBAOypjk/lITWYE4HwVkbGji84O/sYkbFWaj6KMQBmkGxJwB31
	6O+pruK1Ja8LXkHxQ7fGHgaAb5/4vNpjmuXN+qjXVUZKhEgA43PFb5gcCePmf0GK
	DrJv4+zRlAaa3iCpZ1ytmcE5sPkZx+4VGv7HWZwJ19ncWYDfQtWH/gVfXsOOIVnH
	7TXQ5ejiqYytjnvN7fwUV32EfvZPb571FSRinFVvaxjN1vWLgdmM4fvr0w+8nkXk
	IyHCYorywgjNxOaeNX8KiEHo5PIURJiDSBbVz/Nw0orH7gzmZT1g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf47q2pk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 17:28:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59FGTCEG037497;
	Wed, 15 Oct 2025 17:28:22 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpamvb4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 17:28:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnBe5IQeky/hzoGQ6WjDy85D8IMwxplHx6UiZN5BqAZe3vwj+62uLtfC5FxfhW+Qc/osdUt63JOMPVVNk5SarKmpTB0to9he2WVKx9GWBt9xzO+q07UrYBLqwX48ZGT+Ev1yaWYoUmHWd2AswKcxGl/4Nig+X+EscOdExf10iEWSE8FGEex5VidNWf47TEZWcnuiijlYTHZTAo02AxTtP6rt/yz/HhZQxwwhH6TsftnAVsJBTl/4hmNLZOmYZxXW7zG6IUsTlRLVEgDmSMgWTSKh+dAnMX5Fnrf4V1Xla6aBcwUTMt8XARPjFIOCAXcXnBMXbXTrNjiTIp4Lx1a9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1TW/mujDpobcihkil//fnI5JaKtAJ7/wqworO2IbPI=;
 b=wqxicpc5Jd5U0wxkVVpZH1RQHlhc9X5AufBEnD/rzQt/r9zxcZBaM1D1Bh/y15tzGARrrmzKJf/8YGaDnYqKNBeA8Y7kudAhP4rBJFCUvVesGcY+Lcm+wCCNAyXeT6Pv8fqcAlZGRzpKVPwaK1L31DrlPc4ffrIpttmt3eb/NnRjCDgKfKlUdfdCSPv3W4KPdCZv7Zlz6W8dTL6El8sPZL0ENwB3MNE5z++pbeFtMxyxevHtT4ZnAk/SC41uObnbJjOusfygnUNgJ/Yx2kU72zLlBSpuwrcscNhmMaj6rggzIrjRLy2PCdCF/kLhFsHsjgA35SP/7YvLlMAy9MFJIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1TW/mujDpobcihkil//fnI5JaKtAJ7/wqworO2IbPI=;
 b=mTqypEGwzscPxTcQK6H92ixqWLuPt4lpkW3QdvNIyaTMGE7RvJRBK0G1JewBiKjFHCQwTs8qH9FBHUQ+tL+1FhyqMxT45eibDALgobXvdQhCzxBAbNwpoVCTYOqUwxUOy/2g6nyvt3i3mADxUl6rsGz7UcVo2liXPW4rf9p/l0E=
Received: from MW5PR10MB5764.namprd10.prod.outlook.com (2603:10b6:303:190::15)
 by SJ0PR10MB4591.namprd10.prod.outlook.com (2603:10b6:a03:2af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 17:28:05 +0000
Received: from MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::412:f26c:21fc:faae]) by MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::412:f26c:21fc:faae%5]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 17:28:05 +0000
Date: Wed, 15 Oct 2025 13:28:02 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Feng Chen <feng.chen@amlogic.com>,
        Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>,
        Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Tao Ren <rentao.bupt@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Linux 6.18-rc1
Message-ID: <3exillpepa4jjxsjkp5vgn4347tsvt7q22m75tp3ncavkyzgl7@juvt3p4h53km>
References: <CAHk-=whPJTtX5u1m47fPUD2g2Dc=Did_6OqCVj6OQPKFgfKn9g@mail.gmail.com>
 <f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net>
 <c45a8502-3af2-4d5c-a660-2922b4e040bb@roeck-us.net>
 <68841c19-c54e-4837-80bf-d180f2c35499@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68841c19-c54e-4837-80bf-d180f2c35499@roeck-us.net>
User-Agent: NeoMutt/20250905
X-ClientProxiedBy: YT4P288CA0077.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::6) To MW5PR10MB5764.namprd10.prod.outlook.com
 (2603:10b6:303:190::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5764:EE_|SJ0PR10MB4591:EE_
X-MS-Office365-Filtering-Correlation-Id: cb585a98-984a-47be-f78c-08de0c10336c
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?OluN9Bb7+xuGvYW7twp9sbja9ylCg58Qk7mkJDggqXohQ905GhJB5zQF6oWO?=
 =?us-ascii?Q?EQHQgYTjCLtBkb5qcZgfZaqkU9Ro5weGS0X3XGJp6AtEBWsSJJRy8NUVpk4H?=
 =?us-ascii?Q?xfxwtNV9ymNl4e9OAdqV+0SIfeOztkSQSUXP8aPIu5d9cwfqcDVuIwhQEnes?=
 =?us-ascii?Q?d69bZLBg8HfoyMGi5qGSS6cGhFtXGaxHWaHQ17H2Z0IENe3kTR0uSAy1esWt?=
 =?us-ascii?Q?riJcJBbzm7CRnA3y2l4fT3n+jHNn1feybpQXyy/wmpdLuqYMxdlZj4ar08gc?=
 =?us-ascii?Q?LnjXzFQY/MwRkmCEJt+TKbfVNzF66LQtTVO5XnmvaXA/M7Y4Oz3zEH4GuamP?=
 =?us-ascii?Q?EY+DUWaIUblyM1E9EbFdY07jRfsoREmcK0rsrIH6m/6LlzH7fKEswoGOODmx?=
 =?us-ascii?Q?aDT3D0/0cNO5CoxBHbi0nebTYXIFuld0ktcQjBIWUoAe9/hG4J/8HlERF6y2?=
 =?us-ascii?Q?0cxT0YB6Eu7aIibbXqIWCXtVECKTfQf7Xef3Vr2kZgd19u4tbYlcyv9C9tLV?=
 =?us-ascii?Q?YrOL6mobRuHqdJBs8jBYZuaGDcTFrIfw5xVTIdk7yNXIhJ6BD2RBcP8wMIu4?=
 =?us-ascii?Q?p4uPy2k7MNvsGy5pTm+b5vKBmtVPMj/HURBEho68OsE3t83iEaVX4NiA5cKI?=
 =?us-ascii?Q?G//MiwDtI1iS9WX5wbsmQi3xvzd5mMcMKLLgUZKHb6TohyfYJRuQI7YqE6jV?=
 =?us-ascii?Q?1/NqJsmZuSC7zW5N/H/IAHaxRjPm0gyO2zKGNggOB8uvNqEr3RG+qVoXrH4c?=
 =?us-ascii?Q?tMU+5fNY6nnmCNek07nBQAy7dCA/Xp4mkdaRf8LaRfg6vt5tBeNdqbyEmNgo?=
 =?us-ascii?Q?YflIInmgHPfsCPO+cVqrdvXLz/BVdsDzzvY5YCMlfJA4WsYiIdxtYCY0d9OB?=
 =?us-ascii?Q?RW6jncxbKHML/XLGADaYyw/739cokdKw/DiHYjkcrbdNOapZNM5eN2hJVLv2?=
 =?us-ascii?Q?PlPakckwAu9rRGw4wmYkhMbC9hiE1PyPTSizo7ziueTrNU7XkmzafC8Bt2Tf?=
 =?us-ascii?Q?JFa4Cndw/Ehycj3G+foBoN5AJa/N0i6Rh0/lIGMRgaYRkb5YFHncD29+hb2a?=
 =?us-ascii?Q?tAZWZgBc0sFpKjZwl/a1DLYY3ggQyZwOAI0/MuCpv6ZuJXNJH9T1V9Td0Gqe?=
 =?us-ascii?Q?og+6QrL8Om/QLuj7+8aOMC6U78iDw4DAhUy8FR+0BPOwjFRbVI0RQJNMxsQM?=
 =?us-ascii?Q?ILu6KwVh16G2zpXRRCdYgbMtqbVA4kOdh6HjSDAyV1WY7gBkNkcYe+C8U4+5?=
 =?us-ascii?Q?EQHBukUId3xfRzIQk+LzJgGLuCXWvGWs+5/T6lS818AWMWpJjjMU3n/Pmk5t?=
 =?us-ascii?Q?wstfAf5VGw/xncpG1mRE4sD0rIe883kA7cxA1cYgbBD4Ge/hLHkuOZYDZ0Bi?=
 =?us-ascii?Q?23gxtMSndzlP4WYxoreCNk6YVbszL6urYhfq0jrDyLcZgXqsWQ=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5764.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?n4+qethxVTzb9AggLwg+6zY2maxLfDDEjcB/D9sd/a/cGkYDTPPzV+B+l8lp?=
 =?us-ascii?Q?QXynKTh/xyqgx2gD2sjCy/sMpLtsc+nojNQrN4bn2Wa2otVg5yz/OFlRemz8?=
 =?us-ascii?Q?2mqM72v1YpLCRR2N5uwl51CouM2yv/Kgvap8QYgw8AO0tBUp29TcGw7mMyuW?=
 =?us-ascii?Q?LrqbmnBlUY38y5DBojUTyZ8teQIm+2Q5WfCVAWvs2fir0GsNjeS4AAH8Gm8R?=
 =?us-ascii?Q?gGo74xxDzm9ZnOMO5yBpBL8qSHlmbqObOBSaiTzhk1/CRZUTMt4uKYDhPN5Q?=
 =?us-ascii?Q?zTsSLlC/YLfeJ3VTEYCVoND5hbYzjWTNnosWx3RnE6scxnk6hpK1UfJzhq9c?=
 =?us-ascii?Q?14XWiIWESB8u1Ih6L06cpHU8COTI5zh0NibUY2gsGAtYtzCABr19iUTogir/?=
 =?us-ascii?Q?Goeb6PtoJIR/WlK9u+q3ETxtllLu5Mb/1mE0+oQhmGzoY8Kq+zDIoYYhdu3G?=
 =?us-ascii?Q?DGRRZk8eS0JI50OAfdCuNPXgjzZLVQrErW8EiOzi1jWM51aqfh2wiHIjQmdf?=
 =?us-ascii?Q?h6KRPiVOTOY2elI/KsMFjDwKp2Fvs2dZUSch4k+GtvfQ79Mfq8BOjqf69vwy?=
 =?us-ascii?Q?XZ73ST7WF+fCtmF2zcuO+a0Kqud8CbhCtkg/wu7u7omaF3FlUYimLPVIK/nF?=
 =?us-ascii?Q?hGjzInOXvphNoqLcsNkFttBccBwpymkjrhQlQAIt42jex80QcJSYIfF4+UF+?=
 =?us-ascii?Q?XZ5+tZHjn3R0Gs0p7nKnnUQe5Npb2pxPBzfrUM/aALvdwol3b5hOLa6em+D1?=
 =?us-ascii?Q?NtSdxV9oxSOb9i1wYW3vRkZkvRbyNS8Q0rgRXToonpGjx1MmUXBC2eTKzRnK?=
 =?us-ascii?Q?Z7vD6b6zWDOu3A2w311B2+mDXzXAiTjTtTxe6ZOFKKh27yoCuCMni2Cexur7?=
 =?us-ascii?Q?SyU1N1cBwI0d9GtKB61PLMVBocYaAITPSsmsoGrUDSdUkuuGeIbK3l+q0dFj?=
 =?us-ascii?Q?tFNWWktg1keW5PAs5B/Dbjb17hm4SEyfMH+iohkUe4nXFvM0eSZPiBau2Z6x?=
 =?us-ascii?Q?GJUPhaq7N6MsJyqGyP11/0NNQr97mdqnt0CcyEaaPPytW9m/QyUpbTblNN7x?=
 =?us-ascii?Q?vX+AR1zgURXE3iS0S38TBynBipDPly+FsoShrFcPvOFxy/IBdI8JexBTiqNq?=
 =?us-ascii?Q?QnuC9OtsGOqRpkXlaaZ4Blj7E+UGvVfsSgKuWjVSWumKPmbBm5a6c90c0hPX?=
 =?us-ascii?Q?TjXkD5j9gW/zx6kq7SXPybTap/dwelCL3PW4ChQO1lYYQaK+PGNHFfhCiOLs?=
 =?us-ascii?Q?Dz2OELZYk9od4pkhaBOp8dKYVpu8szMghAXiRaZ0uUlZ2LjHYydBE/6XgGVJ?=
 =?us-ascii?Q?KQ8gpdmDyGZo0Nch4RSv2UpkHJEy64B+r050B2SulLFL3fR2S/B519ryD8gb?=
 =?us-ascii?Q?Ai8NlRVRyqZZgEvC4I6LKJT4hUjjim7f+Zlmw+rNdfO3h7NhJFqwZXg64k7b?=
 =?us-ascii?Q?+nqha3HYPJnue8xf94tRWni6u4iZjMsOFVW5MnzJ9WSuMzaZ3sXQFml0Vbjb?=
 =?us-ascii?Q?WYLPiOieTo1alqeQveqJ7MBDFMiDVqUKMM7BPoTDA6JqGiWDCtkSkLqXij0M?=
 =?us-ascii?Q?DjNAzv9v/JhhL+QkF6bBCT+JY7g4ChfT7EOABbt/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bYyVXPskwRNWA4KMLslw8V0lbens9PkEsAu+H9pzc9NRy2V2qNBrPHqeAo20SGTcuH0G8OtxWaBEGMHuCE/YTC91XvgAXHBfLIBORr2tx2fQXwC0Tf0lXOy+Lfp6OWVKRaPV4R/InmaJtvv4Ah3V+odlu7NlgD4+CsW50Bn4L4PWNcXS/qpoJ+nqCzrr1o2du+XHqYH9Mb1Y6uuLL04kJQTSu8qlCAKnqhYRZm23z4TDcDv7Yc8hIxZqrHlqUGhYvv2uqxM9gJSr7RIj/dWp/c/rQBU50FdvalwsC+Cha0gc7tiZGBBvW4M1CWK3ibmUSw1z+seFqPinjNkMQFjbfZFDL6L4nVDw3ssgKNufGgXp0hD5qsepCfIfw0Xpwex6tZYgKJDCZVDF9h/zANj0vL49imleV2PM9NZc8BBKd76ndnEBQc7aNQpWaaf6RwPbQ6DLKMPNFQyVa7z9rpxkpuPRt4iyGl2sy37hgpIjFqGzOqQ5L0hxyPp4etDI5hwmD/ZwdHNpS61TRylAVrUyFr55BRdNBd3xKUWED44lfJ8IwosmtZzP6bc165YE1wJ+YafbxLc9qs4jGHqjoWHLEf1vSVeNwL5UuWpIc+njYIg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb585a98-984a-47be-f78c-08de0c10336c
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5764.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 17:28:05.6577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMZnzloPd/2H7J3Ey5J9NY7mwV8u0U7k0y7rkwuCnKG2ukj70nVqMCgB46PyiSRilyYO0w7vGSm4v4d69z/t4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4591
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=997 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510150127
X-Authority-Analysis: v=2.4 cv=SK9PlevH c=1 sm=1 tr=0 ts=68efd9b7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=e5mUnYsNAAAA:8 a=_jlGtV7tAAAA:8 a=VwQbUJbxAAAA:8 a=ke4vfsUvb1ByCZe-vuAA:9
 a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22 a=nlm17XC03S6CtCLSeiRr:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: aXOvC42xkawHbJagC4ErQ4ipMn72TfaP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNiBTYWx0ZWRfX/ZAMZZftUFO7
 9QIU9t8U90xquuSmR/vOB9HCHriA1x+2ffBhDDDC6CFJh8woRj6zTd784yH+/bxk9IO9ScAwh4L
 qA9yyGDQQ1nnRig/1cUwZANpimB6atLoZrS23T0YV/rvLqtRUDSC8hZIPIVWj9OPf2pTDq/soW1
 4gMME8cwlAY41ecObbg3ci4WYWKEm6ZhOkZZdkYbXgYvhMSx0P7m8FKlJ/Ya1cCX9AvMa9J5C1r
 JyVqe15/JvfogsZ6tGV4G5NruXaSns4Kj3CSmZt0aAP1mDrkm2HuwLmEaA0vaDN5ckFrVspfUSM
 1LoAaA/IB6b/v/9xLEQm8cu5WxozrgKUrJnxI1/S9mILpfaFqQwGRJPp8nNfdtualRlDSRwOv8q
 cd78vsdanuhFyEDCT2rmHKEPIohgMQ==
X-Proofpoint-ORIG-GUID: aXOvC42xkawHbJagC4ErQ4ipMn72TfaP

+ Cc Vlastimil, as you are indicating the slab merge.


* Guenter Roeck <linux@roeck-us.net> [251015 06:02]:
> On Mon, Oct 13, 2025 at 09:46:44PM -0700, Guenter Roeck wrote:
> > On Mon, Oct 13, 2025 at 10:08:26AM -0700, Guenter Roeck wrote:
> > > On Sun, Oct 12, 2025 at 02:04:32PM -0700, Linus Torvalds wrote:
> > > > Two weeks have passed, and 6.18-rc1 has been tagged and pushed out.
> > > > 
> > > > Things look fairly normal: size-wise this is pretty much right in the
> > > > middle of the pack, and nothing particular stands out in the shortlog
> > > > of merges this merge window appended below. About half the diff is
> > > > drivers, with the res being all over: vfs and filesystems, arch
> > > > updates (although much of that is actually devicetree stuff, so it's
> > > > arguably more driver-related), tooling, rust support etc etc.
> > > > 
> > > > This was one of the good merge windows where I didn't end up having to
> > > > bisect any particular problem on nay of the machines I was testing.
> > > > Let's hope that success mostly translates to the bigger picture too.
> > > > 
> > > 
> > > Test results don't look that good, unfortunately.:
> > > 
> > ...
> > > Qemu test results:
> > > 	total: 609 pass: 581 fail: 28
> > > Failed tests:
> ...
> > > 	sheb:rts7751r2dplus_defconfig:initrd
> > > 	sheb:rts7751r2dplus_defconfig:ata:ext2
> > > 	sheb:rts7751r2dplus_defconfig:usb:ext2
> > > Unit test results:
> > > 	pass: 655208 fail: 0
> > > 
> > 
> 
> Update on the sheb (SH4 big endian) failures below.

What is the qemu line you use and the memory configuration of that qemu,
or is this real hardware?

Are there sh4 configs that pass?

It's a bit odd it says "fail: 0" here, Is this message about something
else?

> 
> Guenter
> 
> ---
> 
> sheb
> ----
> 
> sheb:rts7751r2dplus_defconfig:initrd
> sheb:rts7751r2dplus_defconfig:ata:ext2
> sheb:rts7751r2dplus_defconfig:usb:ext2
> 
> Bisect log:
> 
> # bad: [ba9dac987319d4f3969691dcf366ef19c9ed8281] Merge tag 'libnvdimm-for-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
> # good: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
> git bisect start 'HEAD' 'v6.17'
> # good: [58809f614e0e3f4e12b489bddf680bfeb31c0a20] Merge tag 'drm-next-2025-10-01' of https://gitlab.freedesktop.org/drm/kernel
> git bisect good 58809f614e0e3f4e12b489bddf680bfeb31c0a20
> # bad: [8804d970fab45726b3c7cd7f240b31122aa94219] Merge tag 'mm-stable-2025-10-01-19-00' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect bad 8804d970fab45726b3c7cd7f240b31122aa94219
> # good: [30c3055f9c0d84a67b8fd723bdec9b1b52b3c695] xsk: wrap generic metadata handling onto separate function
> git bisect good 30c3055f9c0d84a67b8fd723bdec9b1b52b3c695
> # good: [f79e772258df311c2cb21594ca0996318e720d28] Merge tag 'media/v6.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
> git bisect good f79e772258df311c2cb21594ca0996318e720d28
> # good: [f1455695d2d99894b65db233877acac9a0e120b9] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> git bisect good f1455695d2d99894b65db233877acac9a0e120b9
> # good: [a16c46c2402026162111ed9fd1fc28d25223443e] dma-remap: drop nth_page() in dma_common_contiguous_remap()
> git bisect good a16c46c2402026162111ed9fd1fc28d25223443e
> # good: [a5883fa94295f1ef2473eadd84cc1e24dab9ae18] selftests/mm: gup_tests: option to GUP all pages in a single call
> git bisect good a5883fa94295f1ef2473eadd84cc1e24dab9ae18
> # good: [08498be43ee676d8a5eefb22278266322578a3e0] mm/ksm: get mm_slot by mm_slot_entry() when slot is !NULL
> git bisect good 08498be43ee676d8a5eefb22278266322578a3e0
> # good: [719a42e563bb087758500e43e67a57b27f303c4c] maple_tree: Convert forking to use the sheaf interface
> git bisect good 719a42e563bb087758500e43e67a57b27f303c4c
> # good: [b9120619246d733a27e5e93c29e86f2e0401cfc5] Merge series "SLUB percpu sheaves"
> git bisect good b9120619246d733a27e5e93c29e86f2e0401cfc5
> # bad: [24d9e8b3c9c8a6f72c8b4c196a703e144928d919] Merge tag 'slab-for-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab
> git bisect bad 24d9e8b3c9c8a6f72c8b4c196a703e144928d919
> # good: [83382af9ddc3cb0ef43f67d049b461720ad785e6] slab: Make slub local_(try)lock more precise for LOCKDEP
> git bisect good 83382af9ddc3cb0ef43f67d049b461720ad785e6
> # good: [af92793e52c3a99b828ed4bdd277fd3e11c18d08] slab: Introduce kmalloc_nolock() and kfree_nolock().
> git bisect good af92793e52c3a99b828ed4bdd277fd3e11c18d08
> # good: [ca74b8cadaad4b179f77f1f4dc3d288be9a580f1] Merge series "slab: Re-entrant kmalloc_nolock()"
> git bisect good ca74b8cadaad4b179f77f1f4dc3d288be9a580f1
> # good: [07fdad3a93756b872da7b53647715c48d0f4a2d0] Merge tag 'net-next-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> git bisect good 07fdad3a93756b872da7b53647715c48d0f4a2d0
> # first bad commit: [24d9e8b3c9c8a6f72c8b4c196a703e144928d919] Merge tag 'slab-for-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab
> 
> I had to revert commit 719a42e563bb ("maple_tree: Convert forking to use
> the sheaf interface") and commit af92793e52c3 ("slab: Introduce
> kmalloc_nolock() and kfree_nolock()") in the 'slab-for-6.18' branch to fix
> the problem. The first patch can not be reverted in mainline since other
> patches depend on it.

Both 719a42e563bb and af92793e52c3 are listed as good in your bisect
above.  Why are the two commits you name as the cause listed as 'good'?

What did you revert to get sh4 to work, and from which git branch?

What do you mean "can not be reverted in mainline"?  And which is "the
first patch", I'm assuming the first one you listed (719a42e563bb)?

> 
> There is no console output (earlycon does not work) and qemu exits almost
> immediately with those patches in place. I have no idea how to debug the
> problem further.

Never a fun situation :/

Thanks,
Liam

