Return-Path: <linux-kernel+bounces-766024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8996CB24165
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D5D2A4253
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB152D23B2;
	Wed, 13 Aug 2025 06:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T1m8mQ+Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qL3CKWad"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0A92D1F61
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066321; cv=fail; b=AHqYHP1+zGaYzINEBK5ThKeS+LL2a6k4C+AqqIZtkLLUlW2i59xXBxvqvg6a391tPd3o17LIwJybuaPxypmyYaHLrZ7dNtvppbPPuW7RQAyr3EGlijRKvw2GEmV4qdKP/npdGkZbFbk/OmGWnovXxHMszSEGenFhBkueuAKb5Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066321; c=relaxed/simple;
	bh=TmC+ZVVnMoQ/NxviYkR/75eqZItgcFJhQz8leDc6xOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GcsilAKc1eR66NH2sn3h5lxii7zc8PQoH53k2KeUizL9A2YtxY13XekFbxExZjYk4zED2yxwNCHpoo4bCvb1zNWRZ+JZ+nMw6YRM24cu0S9lkOcGwmHUEvT34iYPiMEInJBHjqCK6ATIYWKIndvVTbPPlvzOlZ+uVaCGELeKfi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T1m8mQ+Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qL3CKWad; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D5uaFN025561;
	Wed, 13 Aug 2025 06:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=+UGJYZZ0F47J6ZI4BE
	+nY1GWa4L6DuyHY9FOhHEUp6Y=; b=T1m8mQ+QCQf0TqxFi+wz8ojuUKuFmDtJLo
	bhwAgp7bHYmZGsIx7hcPUb8fQa94SIOA6rV0Nd8f+UTj7NIwux2+QNXbH03Xv7tQ
	KRFuL/ml4IktCA42w4YqmFjYCQSmqNOwfMg3LsZg/dqRy75eXakTS9DvRPgoa4h8
	olnMvzzFegBQPro7KRHkAE1qnwF31ev0PVXxl5dJpHTHfZ5h/AmqMxfniwULO0H0
	61ULK0hJ+6bgXu7CuEoheo3AP8u5doDbv2gbfD/WT4MikSz/teelCiX71Hc/wD/T
	Zq4PEHH1+brRgAPXNw6SHozO8pyYMKpVc0r0Meo+DO0ozpNPL+KA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dwxv6f5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 06:25:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57D5KFXZ030195;
	Wed, 13 Aug 2025 06:25:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsay7ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 06:25:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JiCerp+AJAuTAaLdz/mvGLNptfS+HHc5cTd9wm1UIGq3DNg4HbLojLHoIKdf5E0JdZKsq0T0H5vPW0kVhILnTzCOjxd+PhiQPfg8hrcVYQj891a/8XfY6cNkCMMZgMk3fh9rvz6hweodDoNGnjBYBapyukZNt6DQ6PZEJi1M6zDkxoGo3eManv1h7UnO2avtmr3CvZ6/GQ/PPA8ty8wCy8dt2VeyGNidOBsK8rNyAjFwkKAaQRBBRC0p+YpVlf26l9IcWsjR4h33KfzCs+1JAgHlmmpSOGEAzWhGyI70e+1lHVCLs7TVoURfZFC/GY+hPjdfpcAgRMIjIj+oy7pjIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UGJYZZ0F47J6ZI4BE+nY1GWa4L6DuyHY9FOhHEUp6Y=;
 b=DhZFWrWbUth2RjAflzvEewajbYY/xVazZQX/2SOsOL/Z1bsZfBAE2/72k2NQdIzM1Eb6U0BVA3jvYUr82haPvTrbQiKb29zhDxVtTDzjBsuqpFK0vw5zerfGYm2H1HIzcgk5U86s/2A2f4JIUCDpSG3WFpDFGkVf2QxivOTMJB1F5e6mtMp6qhJ1qeIn0/r3t8hn233e2SDWqKs0I5WvBBBCNfcBLCSvMP9vNYKWlweCBYliXPk+ra0Z/XeNg0unBsgVATmpivOkpkL/4VvQ5rI/z7YsEelnAWYE+9TMl+WuCNzO8J/JkkQL0/UGGwTT9pdf5zgCJWz7v+U9V1bRew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UGJYZZ0F47J6ZI4BE+nY1GWa4L6DuyHY9FOhHEUp6Y=;
 b=qL3CKWadUa8fQ8ie5bOz11HZOf86GBCPn7KzjkMyDO2Y0orKpDXKfIH1rFQf0bYLligJUa6T97Vo/by+CqejqF9QYGIPNA6dppUT1Vx0/xF1/iB/H0PH0gjn76OwJXRhm1j93gVlGri0wO48tADcv9qkYrEeLnDW7VW7sJIbzRA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BY5PR10MB4353.namprd10.prod.outlook.com (2603:10b6:a03:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Wed, 13 Aug
 2025 06:25:02 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 06:25:02 +0000
Date: Wed, 13 Aug 2025 07:24:56 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linuxfoundation.org, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com, kees@kernel.org
Subject: Re: [PATCH v3 11/15] perf: Make RB allocation branch self sufficient
Message-ID: <4fe85a3f-fea3-4364-a013-6eea1b69a341@lucifer.local>
References: <20250812103858.234850285@infradead.org>
 <20250812104019.605285302@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812104019.605285302@infradead.org>
X-ClientProxiedBy: AS4P190CA0048.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BY5PR10MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: 71cbf621-144b-4c2c-a937-08ddda3222dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aeuZ3Bft+yBurw3B7NuaI3t2SDu2UgJSCqO9NgPKxqM1kQIaXN16AM1D1e6e?=
 =?us-ascii?Q?Df3vFPRXy9YxJ1T0T8pooqbtctH6HWExZ/70W11PlfAEP4b75RvNzlj6ccwV?=
 =?us-ascii?Q?cuQ9Z+0kr54Rgi+tx8QVNz6VP2x7xjt+9r1+TMTMtpAO/ufvGIB6UnYU0R2G?=
 =?us-ascii?Q?DFskHaZaMMRm8pLBP7rP1kStR4vOtpcvrZGwSYH40/n2WrMpUaDbyU1dUxaG?=
 =?us-ascii?Q?ptT5E0dL2F56hMt55G6+FL4I28KBGnV6jFdUZS3votwABtbZRBncOLm6IdKJ?=
 =?us-ascii?Q?EQOQUd+DndJhHF6NlcFB7s0kRMZaJ6z7ow2ovgQ/L3xsNJZyKEHZ6MGPHqyb?=
 =?us-ascii?Q?Mskgr6q6HCzn0mwqtXsHiDmc4BpmDd5+cuiW3mS18t9DVV2+aEC7Rg9rdaZv?=
 =?us-ascii?Q?qFmkL3vgLxFwJggza8MAAwKiffhQTsDSssUcuE7LILnjilHv61bb3cQ4NfgI?=
 =?us-ascii?Q?Ocxh5IP6E/rZdw/mNimgT/HRIHg3Z3/XnhP1ylTxFXAEjy5wrIi9kt6KhGeT?=
 =?us-ascii?Q?UY79njh5kpqylXeIhWF+R3TJThqRtbmLrzWIbyc2RblKZ40IVdr7O+jVRtxG?=
 =?us-ascii?Q?txJrMnwkiOtvoHFsLXVZSo26BybtAmR03ad3+/Aq3nuVFzHS5zvgoCjRPQ9a?=
 =?us-ascii?Q?U4QeOscBqatH7nzZ7UstdsBZFFCzTbHYY/IeA5R3GptvAIfzkem0QQ5Vz5d5?=
 =?us-ascii?Q?5U8pObBHim2NXV8Sy9SmB7f+B2+nz2ygtLqw8Uis/nyj6mwWqiLuhCh1nBIB?=
 =?us-ascii?Q?iZmatjqDIEzJFKJso1uiwXMhF49yzRSL9BRlM5fPmCk33EbQvrexHLoC8qjI?=
 =?us-ascii?Q?Zc2xL05NSq59eN8j29GYR3DXMcHPxPD2WigEZfSMNkimOIDF4NZq0zrf3SLT?=
 =?us-ascii?Q?V2AmW15mW0AGHypPmtjiGR7OkOO2tuWexq/15DsoBjUM0vxYa78P9rM0fa3Q?=
 =?us-ascii?Q?yYwMk9tvXaWbSLBfCpK+E05+6rGYEtR9jVzr3C6c57PXxBSDuEWvjGwMTCvw?=
 =?us-ascii?Q?AlxrmfkaLtXqaATmMER8hThZvLpJb3onv8AJUq7xFi4BuOfgkNlK8sZJ17fJ?=
 =?us-ascii?Q?95JFasAdgQ6y6YHp8+H1GTlDGkFPS+F/+ZMpEknpmBIKa3yOBeOF/9xqPry+?=
 =?us-ascii?Q?z8C/c333aW95aP0AW+0uYP0Tp3RaaCY8N/AFCKCmrXb+BtwqMewD0j/oZfl3?=
 =?us-ascii?Q?6f1P+pz6rnNOpJf2GRKIOO7SFqs8llMeYLSMyr4FB1c7FKNU75USpTbVWFPQ?=
 =?us-ascii?Q?MU2fhRcTdVjlNWSaeEEuAwiW4kp4kPeAiK8Ejj5I1J/TTNaf/Zrd+EZU8sWJ?=
 =?us-ascii?Q?yGl07fOOyp8V0701R/UhKz/8zH6WAGdi9T+kJ+eit+9SPAEF99EmHAD5lKur?=
 =?us-ascii?Q?z1M8FBvQCAg6hqrv0Pup2U8q8B/0/oXhQhgrZvdomKLDW9Ig3Fl9d265UItz?=
 =?us-ascii?Q?rv02hOT/Kas=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8A8MD5Ppr9LgVXP11KwQKH9EN0dgzdM4YDCeiGOGeRNRlDV1FnaqoGQOIkNP?=
 =?us-ascii?Q?3fw80bXoAaufQ0e3CpdGJrzu1eNY7O66gP52vtsfjkyT1TseURqLoTt7eSs2?=
 =?us-ascii?Q?oW46rR8xMPbZK8e1/IVquG+iipppxq1/tHC+VD3e/Lx07ChwaPwUDZLVeEt3?=
 =?us-ascii?Q?EVihpPWGOSTARRBQsRBrphOgnGAWa09O6fXIfkIvDUwgdlDpmC0NfcBnLjY9?=
 =?us-ascii?Q?eQwWhsuKctuCKgsZR3a5OjE3E8iVG43OGFISoTVul71e5Wl35QSf2QLH/xKG?=
 =?us-ascii?Q?vc55fWgrMGdCUg4zFtNz9mi8bflL0KxuvJiyWMq/EdL1zHe7HVlD0PSXExVL?=
 =?us-ascii?Q?CPDcxUfrU5YbFaulpXIpxe+U9UUd7J7Idf0Jglj62fp0/7ydyQXljYBT91/x?=
 =?us-ascii?Q?/a2/b3iex9APq/28gO81hrpeGPTuMphp9HPrMSHZAq9vKJTb0JJJCQKuUtta?=
 =?us-ascii?Q?CobBiLe0KWv29TK5gevXhNvo/Irw2QYqPjGFmSw9c3jXnmyGzwWTiTQD/dbQ?=
 =?us-ascii?Q?ugcj+9gxMzj51ozh/RpY6hEAYWb/qNMlzVNUW6Ap6YVRFW6+gSpzYuLZSPlX?=
 =?us-ascii?Q?L1XM9MsoXlW86+Fikce47PJ8a4Gu9Aa8m3ytcxf4kcQPMu7w9BT6Qj5sWOGx?=
 =?us-ascii?Q?pTUJLSV4J0BdJ826DnDpIszsRCwFfFhQBErrRGlqsuHZypHGwGyLpVGwBlrD?=
 =?us-ascii?Q?9UaATPARllTIV7qcSoYhBZ5r3BhL/UnlhxomMN1rZ2FJlv5kuSBMeiaz/TMU?=
 =?us-ascii?Q?j3hB6I/kY9Qf/LaZ8Ravr7noBJpU//5DUv5UwxYQTRW5Okfu2To5syXKs8l+?=
 =?us-ascii?Q?MhHN6yZwrqKATbzClOGEh42sYFkLVjy+IKFI+iK8rbSWO6CIdDZvHusQrzvM?=
 =?us-ascii?Q?XudsQo6VcNxTK5uo8qhlkK3MmotDpZ8xP9I9NeABfqTPrmsctk9hnFFK5SxT?=
 =?us-ascii?Q?uJMCmbwQW7s9ifkzRLyyzCach0+fElRD6EbSqgfIJ9L8Lmks1uH/PDcitR9f?=
 =?us-ascii?Q?PjyAWeseiv9f9+NPO4Z14jsBedVHqvfACQvM0/Erk9XxvV2QR8Tq36t6tTLm?=
 =?us-ascii?Q?I7xJo9MpYdeVSchmbxDDzuwmPhff49Rqm4gAiYEJaZZjg6Rik/GnwHb52Qfq?=
 =?us-ascii?Q?PA5pnFfsO4vukqIvTsjxNPiC6D4Hy+hAi7CpzXz4Aysz7i+Kpj2v80/2cPY3?=
 =?us-ascii?Q?m2GdEzNMs/YVJV4RR/l/AE6TYjIPpUFMTB5Z7kwSczrwH2OQwq5C+fa/CxWB?=
 =?us-ascii?Q?5CtcPRgvDw/ABz0RrMJ+IbnrqqkfV2diPI0IW1Oz31VY4pmbeDL2cy49E2xl?=
 =?us-ascii?Q?jN7Vk+ffMmmQzfHS0BnaU6kDG+PSOZk9mrlfLO8SKtBo0yZG4eVlPLx3SqJU?=
 =?us-ascii?Q?ZHdbbwNWePzvPmZvpaLjE71IKYkPKYCjzqbL5WlMgxVKDU6NTmJ+EX2MCBJU?=
 =?us-ascii?Q?mMNjlCLwTwMqiLM4MDwQ8hOgUw1R9hdPcgOrJDo5IacZ8siMJleNu2yfzSC8?=
 =?us-ascii?Q?6fG2UzYTcDyi8QeKieY0WQGxc1GtxjiiA1iIWZM2LkNgXeAvrrBN13AdqTwi?=
 =?us-ascii?Q?sRlkkhjZ5luKLWIGAxQSny/N/wkn9pp//91GE/d8L4AUeDn+p3jt9xIqOGRA?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0XRGvbdtdNj1AhxUQVfR/5scX0zSJzgSTfy9wKwQ6tcrLVF2lSZdCu/AL17PoFjvF/EXiMLB+9ImXyMCFtoScVht5E2q2crtmSw+FlEvwEkCvxed0ZVTNq97LsIFrJzgSXYxVWmcV54iMMhv7/3cjV5OKwCaUZzNh4B3h9t4yEFz/cQ+a53ekGuhMR0YkqWGMt83oojvMSi++uHsJ4DsbTMycW9olRyhuCp/wLQqjK9YLFV/R7tmyB0m77Cewu12DoIr204/AOlvxEXGEC2Fkj+r6uHjdKX6SlmPAuHU9spqvNay2RUwlQ8pr6521RSlfEltJpuoXbSkCVDSvKO/eYwDSf57Yd3nplgVE+6eOUwIRyyYZ+cSkuAghW7GJhu/4OcYvMeICqrz/sKh13oynsk0pR5FnnVFepgnL1TAcJ0gR4dEFqGTmTWGWfb398cJgPZ8JHWPUkQTWRBn+SUj5FRZ76HeHk4FK8/9xE8UhQQ9iB4o82E8p67NeB21nR3OOX2kEKpDgKJrhvPbaLehzSGLsLOxeCuxvrgWRQH4H76A2cHyuWYTcBO6mzx+PbmW3QDkQG3FR8EuTfFBs6MKcVt1hIDhxV8Yo42d6CqeJSQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71cbf621-144b-4c2c-a937-08ddda3222dc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 06:25:02.5376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PuTad6PybxnUfIKxDtba8s4Ip2VBj/apXE9fb3tJxrHcdqX3MXpuekb0gLo0rfUjaubk6iEDg3BOQF9RCT+L+T9/mUy6/Q3GMMGUCDYmhmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4353
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508130060
X-Proofpoint-GUID: elIx0DGadXkK6Cx_F-qGOWvBu5aHd5jU
X-Proofpoint-ORIG-GUID: elIx0DGadXkK6Cx_F-qGOWvBu5aHd5jU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA2MCBTYWx0ZWRfXxWYbQD4OBkr5
 XV6P2NBVbx0TSmEjkdEugPJ7RcDoRchY/GlEearLiffNsqj4O7h6MqROUseLcM8skPaqkwTdnva
 2/x2cU4poelAS3H0Rp3q2CaUB8XaWuLAynk+YblyM0jmjNuGYHTER5YFHWSeH0iPDzvygg+d06S
 T/jps/PfH0pmdgmdMYn6iKcU+1rmqSA4QzYudkRdYlDSeaikynYx8h/Ys3yJcZf1+Ud3TefqXOD
 8Q5bYZoYs0gm6GMz7s9Nv7CqlF4Mnh7ga33Q+wjx1UMbEzWMvn6PjI/5ZoZk/O4l3CAFzvQMSRo
 VT7VfC1nvTbUhvr33/RubrRIzZi52c8SYbIRWyqyUe7na/4JbwzoTiGO6eYZ4mZD8cuKPpJu6tT
 gDXRzRB26kaJLa0/4rlFaKxvENUtzNvn6yfCYrSkCdxVmbWyVj95NI62bnDLDR+qedCPh8mr
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=689c2fc2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8
 a=r344kw388HAGseRd6Y4A:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22

On Tue, Aug 12, 2025 at 12:39:09PM +0200, Peter Zijlstra wrote:
> Ensure @rb usage doesn't extend out of the branch block.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Nice to separate this out and make this bit clear.

I'm guessing you're holding off on putting the rb decl into the branch as
you intend in a future patch to separate out the rb branch too into a
helper like tglx's original did?

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  kernel/events/core.c |    6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7116,8 +7116,6 @@ static int perf_mmap(struct file *file,
>  				 * multiple times.
>  				 */
>  				ret = 0;
> -				/* We need the rb to map pages. */
> -				rb = event->rb;
>  				perf_mmap_account(vma, user_extra, extra);
>  				atomic_inc(&event->mmap_count);
>  				goto unlock;
> @@ -7136,8 +7134,6 @@ static int perf_mmap(struct file *file,
>  			goto unlock;
>  		}
>
> -		WARN_ON(!rb && event->rb);
> -
>  		if (vma->vm_flags & VM_WRITE)
>  			flags |= RING_BUFFER_WRITABLE;
>
> @@ -7190,7 +7186,7 @@ static int perf_mmap(struct file *file,
>  	 * full cleanup in this case and therefore does not invoke
>  	 * vmops::close().
>  	 */
> -	ret = map_range(rb, vma);
> +	ret = map_range(event->rb, vma);
>  	if (ret)
>  		perf_mmap_close(vma);
>
>
>

