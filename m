Return-Path: <linux-kernel+bounces-892949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1470C46309
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62A51885D64
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E643093D8;
	Mon, 10 Nov 2025 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N4nzYQQP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TsLt/Thy"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E623081CE;
	Mon, 10 Nov 2025 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773365; cv=fail; b=C4C+WsT7pSViTMc0QS3B197CCVNMaWHlHtAFf6/gQQYmpefc8rgHkPPw/9DvZfJHW5SgDEk5Hxle4+p69ki7+wLgGtN1lPe3lBi/zZgKrcwC+cXG0TpvOxdBnxqvlOLc3uAZzHriKgvV8dXksqAOQj761A07jtwQAmeXYY+VZXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773365; c=relaxed/simple;
	bh=QZI10MIGLiQ+See/3F6MYh7vHUFyKI8sZlJ2zAGcExU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ddtyuKwT8lYlUQK2X7LIBWpUYauXMnAUjiZYGuC9gpxlLaEzom/56CEKK3dWqRYuQPEdE7t4GASBKuR8T60gWezWc6q7BaxLywcoHTn1ZeIpaDpiB3008HFXGv9sI9ITenqQnU51/qGObuFqugg50APhmGKtMXHv3ora/H+jBvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N4nzYQQP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TsLt/Thy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AABDMnG023910;
	Mon, 10 Nov 2025 11:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=40GPSmxr3szaUIUonY
	Rrxd6PzhS08OLIKF20vL1ade0=; b=N4nzYQQPKAxufAKQexhKIWiqASvKcs3uYk
	+upRHQpgCcZlf+aND4cDjbo9qBUQTMQqICKkwgf0aAPh5c07PhtXLXJBr0bQCWU3
	XgxwrWBdkM17Wtd7nUPSz4Nx4k1EYlCyGJXHy+VxU+QqAwsRD/cNf42yyoqu03Oz
	ab8tjNV8qKUstH23mD58Z9J0V3NXfq42eZCpTfZbcDTm829ML9zjGTk8psy81eam
	+rp0mhL5uWxJgmXqx1fQXOAZZa+Qzv8DPj4aJ2FiSmYCUqSex/T99SFmXb6n+vZc
	S39sWxGABP8QKR9xSRnQSoLpyUSyhAYGAXIbv4+UeMptn91IkczQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abeggg1eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 11:15:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAA65uC007447;
	Mon, 10 Nov 2025 11:15:38 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011053.outbound.protection.outlook.com [40.93.194.53])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va8hh5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 11:15:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNSafow/8xVwPz6QRLfnIC2/Ua8EvAK5/u4wnaXbLb0k99MAfrLRAnp68ES8JNBVC2SmsdluZD20jXNkr7496dpUnZsss9C0O+o+PQO0CusKVsxIBqQ3I39zYfp96Yt5wW+bhQJYi0wNuZTDuz58i339IklJNNb2sJi5DEoeyDZz0R2BgWtWsQbDN6p09z2XirvF9ul/OEM80B7zPq8pPJetJS3VsyJUgw3GEpHn3u0qRjauR4YxMOWpyMXnz2YpAfU7BytWV3ZO//FRb4bXqP8m6hVxVVB92S0vrDVty6AC5HbhtbEHFQLMKeOLcfFVWe7gZkNtmsWk5liy7XVtYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40GPSmxr3szaUIUonYRrxd6PzhS08OLIKF20vL1ade0=;
 b=uZo0lPopkVHvaQur9kFZKbzWfPOAi7WjsNHKJWlzkB+gJ33bjyznNIHXIyAnlQTqrLKl30pygKNPCX/nNFodsXvgiqA0XBBWfYXfIaAqz7NeQ/a08xNtwVzIgm8jUlKdTFsfTeH+TCT+imI8UReVKjEuoXAOweHtBHLHAwnSQzXw3fvJH2oHXhAgWf53LbtBg2myEXIXzQchs4GiCgboxS4Du4rxrayuK/glyHWEwQGGVRPuKzbJd0P9S1o3VrCgBzDTTdR1ILwJxwO7kdpB6HQ3usGqpOTGrlvUOw6fSFNdOP2ZyZNspMWyqcg5upGxoh2aRagIRTxy/9mjr6Yhhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40GPSmxr3szaUIUonYRrxd6PzhS08OLIKF20vL1ade0=;
 b=TsLt/Thy3y+uO7+w11EQlxxNDECC48Bq2vOi08cnlqA6nIPAhGmU/UZwuDTkF7uMpprdT2Gntpi5WLtBFeXqt0HvDm+zC1s39SVn8ub+W0gF7DW1BAbUKWpwdBDfynFTF85ZnmohDuJjg+ixu2uvLGfcuty8MjWxP845kSf5siI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7701.namprd10.prod.outlook.com (2603:10b6:610:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 11:15:35 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 11:15:35 +0000
Date: Mon, 10 Nov 2025 11:15:33 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Dan Williams <dan.j.williams@intel.com>, Theodore Ts'o <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Mark Brown <broonie@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jiri Kosina <kosina@gmail.com>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for
 tool-generated content
Message-ID: <db93c591-8a1e-45a4-a33e-a0578054a8cf@lucifer.local>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
 <11eaf7fa-27d0-4a57-abf0-5f24c918966c@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11eaf7fa-27d0-4a57-abf0-5f24c918966c@lucifer.local>
X-ClientProxiedBy: LO6P123CA0044.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f64c33f-ab86-4e1c-93d0-08de204a786a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QjmDAy8UgkVlbYz+kFHoJY7MMnyZ4UyuuZeM4pQHP/V02dA/Lxs2O6zg8IiB?=
 =?us-ascii?Q?eY4Gn3hrCYXGvbUhCQFImSzXZBA/fEOdA6W4vmk1qF38ejdpOrfXcnRrjrHt?=
 =?us-ascii?Q?HvbhTmOWpvkeq+w5gW3kbDixfhNoLp3bFcOOpRdi9jl2ap10jUGqYo7Axaaf?=
 =?us-ascii?Q?3k6P9XsCRfD6s7I//UZnorBCSewafZgARnw2CuJxI+5uMRirg4PBTeCCHP0F?=
 =?us-ascii?Q?4OVrw9fchm1kPbCFdBn7uogu2z9KLqtGA8m4NTg4zPhUq5mfYzRnz7YzOZFa?=
 =?us-ascii?Q?lI5ygCpd3Ek3397UUG/z4Dun/CgprRuIr0Jc57izqAkux/0vU5If6IMQnp9M?=
 =?us-ascii?Q?/lz8++LNFhtksry3cJXNpweoCJtimEluF3ihmEcltOH7T62AXl5rOhhcKm5R?=
 =?us-ascii?Q?jww27R0eEzKSVKMSI8k69iDNjJ5Uh7WfPzAN62QACOk7XVlkXQJsQBaop79E?=
 =?us-ascii?Q?RoQklg6Nn7dfzz14DXwQ4e3/fxa4D25UhSWIpfjHtT1S0sVqJrp/1sSy7MMy?=
 =?us-ascii?Q?Djh/JXb2ZM8dTGPlN0QQOVUE2cigOBFnUMaJNNc7F6tb77asBYHVkyPCBVQX?=
 =?us-ascii?Q?pHxcKRzZq58rh5Hy+IxAE+Q0GJn7ZCAE6F4NNkAynGYURrrtrT/1otfB7gHg?=
 =?us-ascii?Q?d0MMMB6481pZmTNQAC8QdKL+0qdBzO1jN67XgkwjCAvD5cawy1ArpF2nbfgT?=
 =?us-ascii?Q?sKFiuHkEC97KhayBUVRhM3d9GyNbNjfm/SLYgj72koQ+y36XSv3CULqEwxhC?=
 =?us-ascii?Q?B0VF10yZYnXuOLJQgLcxRoo5XqYCriaSfh/UliyDTAs3aVTknPyoJMeJsTvm?=
 =?us-ascii?Q?iT7O3Tn0LPiCXgqw4MrBj215YiMwDHQ5c14WpMs1TqCRVYQhHllUnJoluSta?=
 =?us-ascii?Q?f+mlOzrRizOlCtBmQTwdFXzeHITKucdlP++gSPYhB7Ivc48sv99yyY6qEj99?=
 =?us-ascii?Q?ctOzx26pJbD1uon1MQCXRnGN0GDRVFObY/JU41U4k+ArHP7QdTG0VSHk/0Kx?=
 =?us-ascii?Q?N5dFae0tyj+ihLY0JQzh7E+fWdziIta+KbKuLzqsQ7LyblnUi/5VFdmjQzYG?=
 =?us-ascii?Q?AnZ/QneGA8yePK6Wl3nGQ/kD+5+eMljrEnX+LrcUkYiGAh1nGtV6cstBzp6V?=
 =?us-ascii?Q?UCtCZMDwAoDtPmlx8hLxzofK5zxmpy8bHyZbXkDrcs/Drq0pEcI/RdGeRe5l?=
 =?us-ascii?Q?vfuydjubZKfEXfz7hqdt8uI628UXUF56OyvnOIDSIvsz02gZrJ4DLEpdBuOR?=
 =?us-ascii?Q?E3ZWvG60QdIN+bM1oBBTs/GfQpZiHjMECo1NOH0Q4Q6O4QDh713nGs5A9mqW?=
 =?us-ascii?Q?yjPIl7suGCu/571EfkzEaiYJ70xGw/FLAFI30MvyiQ/dleGiBHUnf2Bt6Rj2?=
 =?us-ascii?Q?kKa8ntQnyy3KLejJ/FZP5VPn2DKFYonAZkx712t3Ukxl/q9lPNDr13DCwtOJ?=
 =?us-ascii?Q?1nVUApgTgu7A5U5rLvMSvmSJj31WiB/73J7brY/Tf7nJ2hK9pGw9cQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?coBjDfiuzmILWMzlCfC8GHkrAJaas32FWO9dRcciw70Mpwn6APyvIcG98LqP?=
 =?us-ascii?Q?NqS4AM8HjAdyYDBQZuy+3e+9V1SJyTsA4axylZGjvw56ONVHzg5IZSnN/C6K?=
 =?us-ascii?Q?w1/WsNdgyqNudR0Ecv3hU3PI/Uu0o5Tuh0J0vbhFMYwslyt4xTHBguCAat5X?=
 =?us-ascii?Q?xZyFYKQMw2FE8v7hh4ue4Z6DIffrjaMV7EtbBrmpSyAHy5os3lqwRhZC560A?=
 =?us-ascii?Q?2GSPa8zzF7t0IFKFINJARxIhtmXQ8NR4CANvHFWtvo7Znw5CYoSROOKiKqAS?=
 =?us-ascii?Q?bJnEfOwlnTxozfxgBPDBUwSoAN2ZEfxIeCM7cmyErswb17TKmm+7R/msG3yS?=
 =?us-ascii?Q?Q9o46zAlWmiAkfglMKUQ6CXU8P4wwFRV/PbA8dNGqj8nm6K8DuBUE8aALEpv?=
 =?us-ascii?Q?VOuErGq4j2EyRHrErkLsaMgI+47wviArQeA88ay/NExn8d/WM2KVgB9DYU1/?=
 =?us-ascii?Q?HY6ewzo5OknL356p/CJz0i0B6c5qOxRRH1x1gzb8fsByK3Uq+7lctKvGvX1a?=
 =?us-ascii?Q?8MyFqhJK/IKgtbQgotgmhxUiUhzgvXSazHmCkR+MhF58Ct/CZn2G5gndG18Y?=
 =?us-ascii?Q?A1bVsYyheM9aoGD+MEJNrsOjgdtauyQIdgElanzM0K76pFuenL3kC1bnd6B0?=
 =?us-ascii?Q?3dy5SXVb1IPlnCIqGX8DOAxScEZnzFHZJt4iU3sGRq+W7YEhj0bLiyAy1Cm5?=
 =?us-ascii?Q?f7DXQEQ9j47Y33x4k2vjdCr7WtaK4+17LmeqDuDmy+DKEoVo295/NNHf6CSu?=
 =?us-ascii?Q?aQflUEnO4WyGtdlh4rC1dTAYhfGXypZsyr4Ph1SgesLG3bG81yApWh+2LptL?=
 =?us-ascii?Q?dno7HeIlPjjC7X4/338EhMiU1LC/GybOIn/Rt7zr9sHCYdgDBDGKSfKbQmvw?=
 =?us-ascii?Q?5MZibY2XU/O+tJM7YTua3qFvl8aLUpxNNH8KMYwjev3YMPjdW4aLjC632Mrs?=
 =?us-ascii?Q?uC3ad/G94/q+PGLuDNE0G6LOJ+2wXGv8Y62XgbCH5oV90n4fC+mayq1LqLZB?=
 =?us-ascii?Q?hwK/4GNkgFPU4qLuxL99QBuqzo7LOfEtjzzouuRXZy1koV84myh0JIrwiDAU?=
 =?us-ascii?Q?lB5HZgBGXzl6YaDJhFVeoNeLsOqdRLg6wlvJfQPBh13ALpBds2OXAUr8I3ID?=
 =?us-ascii?Q?smaeFYRiWVQXIzyauEFp2kRppr7sEG2+5aoWp3/z1yBRURWDPcvcgCSpCDGR?=
 =?us-ascii?Q?SlxGY/4WXs/CNGcLDf7p10bfyjsoUs9/oglnDRoenvbJycYYynHovHBvTgfh?=
 =?us-ascii?Q?zfbhdZwKYN/wTmIryxlq+ril/b4nUTwxGWTTU9xZsykGa4KbJJnchy9AIetz?=
 =?us-ascii?Q?tIGsJG4dzG9tBbPeAZ1c7p/N0eDLbdytco02S5litvgf9vUtxCcjDB6+I4H+?=
 =?us-ascii?Q?M2YYbGPFGdLepS0Y1YuJOu+ZTV7C/2uzg3RuA+KqJsmLRT7B9mJ2i6vxgUhy?=
 =?us-ascii?Q?l9S2v9RTCwaig8ZVH6sKgIKNjFJCU/bszuU1SfgwLXhBEhPE9kPNEDUQw1ku?=
 =?us-ascii?Q?KNlQn4mw4ikwJj/9873Bl9hVMXZJbBYjn6DjnUSmWpj2aa93B6fb0ABpODvA?=
 =?us-ascii?Q?qrLlNbNdhrShnVdS9rJugzeeUT0eW47UpzMjsDzrNNK+dUPidV876k4sicM0?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D4eKyAnhWUIBmOGnrrmgZHa4soAePt2LTjwD1+Umxs2m/2kZKef2/JxTUlcalNp9ALVJtAul8ucJbYWu1BkDhSgYYIL68t9jMZtBwwKwpYJqwmnlXcVBGrnTzsjVGNkcxF63TVcfpMaPvsZHHIJdzz6b1gTKxWCF9KK45IYWZbwGDrdmTTuDPDHIuQ/hNQydcL4rlC7VENiABPBUCA9QQOV1RDkNy8AHESXJk8uDZvoSkw4YQ4J9/sUkkeWT8zBuDL+KXpy1B91vlz/6YX8HXVYLHDGSTq6wxC4GAFfcwbE8vYjzgkmKFTw8YHWew4yqTNwtsdd+MywdVdYWBSsH1ugNDSU2QrSjf1HFQ2LVgJT877MFTWTs5Jv+6/0OWeVHy7ORn2ouaBJbNkM7gZpJPeU3yQrDgKnD3G0KJi3EMVQzcpo/mvGf1yv0Ksz5aIjNtSA3jaJYzmLsKOgzH3ShxJgvtF2Hw4HI5LyLVaXvNfbhTK37DXOKZcx2cR/GOs/lWQt/32uoOnga7jdSiCbzyssmIl9EzjPzSv7FpypDDZ+XSa/+DsI0th0uyr8uaLMuXroLiZtZjk7o5bmgcB40vkffYQisKPCLk/fAOyHBcLY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f64c33f-ab86-4e1c-93d0-08de204a786a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 11:15:35.3790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2otk4UFn34BhWj5+jKyfT0yr3GdZ+mqqrWNkmolPOiUZp++uLyEUAWkF5hmxMFq1hkyhTTgSlI2D6rEEYPBzg70UxLjrd0ey713f6GBG0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7701
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100098
X-Authority-Analysis: v=2.4 cv=COMnnBrD c=1 sm=1 tr=0 ts=6911c95a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=meVymXHHAAAA:8 a=07d9gI8wAAAA:8
 a=ag1SF4gXAAAA:8 a=c9NBvfEjpVyztheQ0awA:9 a=CjuIK1q_8ugA:10
 a=2JgSa4NbpEOStq-L5dxp:22 a=e2CUPOnPG4QKp8I52DXD:22 a=Yupwre4RP9_Eg_Bd0iYG:22
 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-GUID: UQZYCKmz0ys3DN37wBQENjkb6K9WSRST
X-Proofpoint-ORIG-GUID: UQZYCKmz0ys3DN37wBQENjkb6K9WSRST
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5MyBTYWx0ZWRfXw/K2CC2zoar8
 w5fVqgupn09BTc3c+MeOODoiQEnJy5QBoTaGCsyxvvzOlr9MMjfouUStASYMtwtujmKUHkCbpKE
 wm1XsFVd5WvKdozte5lRKIbvRhgpH2Go4zlXx9+FNmDcXJcpN8t3wMTFHB3uLBXrw5dNMCVoBG5
 ni0yZRx69ewh5roH1Ni4cAoLLSJw1OpJe5WGw9HQ4deWbLYCF66UEPT2xqTUB3Q3+rfKnw9j95a
 3C3Opb2fwChZqxNLFdzRx1R8HBEJbLCPCc5z7BMXr3+DqwVb/SQptAr2rlkL1adABNxhRUnZlVy
 /T0bDb0czHoQ3iT+f3LG2igf+jNO1t7OAyzEd7EElNanGJv+rcBgxpRQsW3Ce3Wk4R/LVFNaGsV
 PIuthfGxgydKyRSqsp47ZKu1X0A11w==

+cc potentially interested parties.

Apologies if I missed anybody, just scanned through quickly.

On Mon, Nov 10, 2025 at 10:48:04AM +0000, Lorenzo Stoakes wrote:
> I think it would have been helpful to ping those engaged in the discussion in
> this area in related threads, e.g. [0] and [1].
>
> [0]: https://lore.kernel.org/ksummit/49f1a974-e1e6-4be5-864e-5e0f905e1a8f@paulmck-laptop/T/#m30873ef3dc9bd2c4c95547e81efff3085474f2d9
> [1]: https://lore.kernel.org/all/7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local/
>
> I'm not sure what the process was that lead to this, but it feels rather as if
> the community were excluded here.
>
> It also seems slightly odd to produce this in advance of the maintainer's
> summit, as I felt there was some agreement that the topic should be discussed
> there?
>
> Obviously there may be very good reasons for this but it'd be good for them to
> be clarified and those who engaged in these discussions to be cc'd also (or at
> least ping on threads linking!)
>
> On Wed, Nov 05, 2025 at 03:15:14PM -0800, Dave Hansen wrote:
> > In the last few years, the capabilities of coding tools have exploded.
> > As those capabilities have expanded, contributors and maintainers have
> > more and more questions about how and when to apply those
> > capabilities.
> >
> > The shiny new AI tools (chatbots, coding assistants and more) are
> > impressive.  Add new Documentation to guide contributors on how to
> > best use kernel development tools, new and old.
>
> As others have pointed out, this is strangely gleeful, can we please drop it?
>
> As mentioned in the msummit thread I have a great concern about how the press
> might report on this kind of change, as I fear that a 'kernel accepts AI
> patches' story might result in a large influx of AI patches from enthusiatic
> people which will have a direct impact on maintainer workload.
>
> I don't think comments like this help in that respect.
>
> In general I feel that a more restrictive/pessmistic document that can later be
> made less pessimistic/restrictive is a better approach than a broad one on this
> basis.
>
> >
> > Note, though, there are fundamentally no new or unique rules in this
> > new document. It clarifies expectations that the kernel community has
>
> Hmm, I'm not sure the conflation of pre-existing tooling which always required
> some degree of understanding vs. a technique which can simply generate entire
> patch sets with commentary included is justified.
>
> While I _do_ like the idea that basic principles that already existed still
> exist for LLMs (that's a powerful notion), I wonder if we do in fact do need
> some new rules here.
>
> I think saying this also pushes back on the concept of maintainer-by-maintainer
> policy as 'it's just like it always was' doesn't suggest that it warrants a
> higher level of scrutiny.
>
> > had for many years. For example, researchers are already asked to
> > disclose the tools they use to find issues in
> > Documentation/process/researcher-guidelines.rst. This new document
> > just reiterates existing best practices for development tooling.
>
> Ironically that document is considerably more strident and firm than this
> one :)
>
> >
> > In short: Please show your work and make sure your contribution is
> > easy to review.
>
> I wonder whether we need to be very explicit in stating - please do not
> generate patches in large volume with no involvement from you and
> _emphasise_ that human involvement is _necessary_.
>
> In discussion with kernel colleagues who use AI extensively, there is a
> very clear pattern than a key part of usefully making use of this tooling
> is for there to be an 'expert in the loop' who reviews what is generated to
> ensure it is correct.
>
> I therefore think we either _should_ have a specific rule for LLM-generated
> content or should (and it really makes sense actually) have a broad
> 'generated content' rule that - you _must_ have a thorough understanding of
> what you are doing such that you can review and filter the generated
> output.
>
> I think stating that we will NOT accept series that are generated without
> understanding would be very beneficial in all respects, rather than leaving
> it somehow implied.
>
> Being soft or vague here is likely to cause maintainer headaches IMO
> (though of course there's only so many who will read a doc etc. being able
> to point at the document in reply as a maintainer is useful too).
>
> >
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Theodore Ts'o <tytso@mit.edu>
> > Cc: Sasha Levin <sashal@kernel.org>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Miguel Ojeda <ojeda@kernel.org>
> > Cc: Shuah Khan <shuah@kernel.org>
> >
> > --
> >
> > This document was a collaborative effort from all the members of
> > the TAB. I just reformatted it into .rst and wrote the changelog.
> >
> > Changes from v1:
> >  * Rename to generated-content.rst and add to documentation index.
> >    (Jon)
> >  * Rework subject to align with the new filename
> >  * Replace commercial names with generic ones. (Jon)
> >  * Be consistent about punctuation at the end of bullets for whole
> >    sentences. (Miguel)
> >  * Formatting sprucing up and minor typos (Miguel)
> > ---
> >  Documentation/process/generated-content.rst | 94 +++++++++++++++++++++
> >  Documentation/process/index.rst             |  1 +
> >  2 files changed, 95 insertions(+)
> >  create mode 100644 Documentation/process/generated-content.rst
> >
> > diff --git a/Documentation/process/generated-content.rst b/Documentation/process/generated-content.rst
> > new file mode 100644
> > index 0000000000000..5e8ff44190932
> > --- /dev/null
> > +++ b/Documentation/process/generated-content.rst
> > @@ -0,0 +1,94 @@
> > +============================================
> > +Kernel Guidelines for Tool Generated Content
> > +============================================
> > +
> > +Purpose
> > +=======
> > +
> > +Kernel contributors have been using tooling to generate contributions
> > +for a long time. These tools are constantly becoming more capable and
> > +undoubtedly improve developer productivity. At the same time, reviewer
> > +and maintainer bandwidth is a very scarce resource. Understanding
>
> This is absolutely the key issue here imo, maintainer bandwidth. Glad this
> is in the opener.
>
> > +which portions of a contribution come from humans versus tools is
> > +critical to maintain those resources and keep kernel development
> > +healthy.
>
> Agreed entirely.
>
> > +
> > +The goal here is to clarify community expectations around tools. This
> > +lets everyone become more productive while also maintaining high
> > +degrees of trust between submitters and reviewers.
>
> Also very good.
>
> > +
> > +Out of Scope
> > +============
> > +
> > +These guidelines do not apply to tools that make trivial tweaks to
> > +preexisting content. Nor do they pertain to AI tooling that helps with
> > +menial tasks. Some examples:
> > +
> > + - Spelling and grammar fix ups, like rephrasing to imperative voice
> > + - Typing aids like identifier completion, common boilerplate or
> > +   trivial pattern completion
> > + - Purely mechanical transformations like variable renaming
> > + - Reformatting, like running Lindent, ``clang-format`` or
> > +   ``rust-fmt``
> > +
> > +Even if your tool use is out of scope you should still always consider
> > +if it would help reviewing your contribution if the reviewer knows
> > +about the tool that you used.
>
> This is great, I agree very much that we have to be reasonable about these
> uses.
>
> The final sentence is also great.
>
> > +
> > +In Scope
> > +========
> > +
> > +These guidelines apply when a meaningful amount of content in a kernel
> > +contribution was not written by a person in the Signed-off-by chain,
> > +but was instead created by a tool.
>
> Yes, perhaps useful actually using the term 'meaningful amount' rather than
> trying to be absolutely explicit about what this entails.
>
> Also allows for maintainer discretion.
>
> > +
> > +Detection of a problem is also a part of the development process; if a
> > +tool was used to find a problem addressed by a change, that should be
> > +noted in the changelog. This not only gives credit where it is due, it
> > +also helps fellow developers find out about these tools.
> > +
> > +Some examples:
> > + - Any tool-suggested fix such as ``checkpatch.pl --fix``
> > + - Coccinelle scripts
> > + - A chatbot generated a new function in your patch to sort list entries.
> > + - A .c file in the patch was originally generated by a LLM but cleaned
> > +   up by hand.
> > + - The changelog was generated by handing the patch to a generative AI
> > +   tool and asking it to write the changelog.
> > + - The changelog was translated from another language.
> > +
> > +If in doubt, choose transparency and assume these guidelines apply to
> > +your contribution.
>
> Yes agreed.
>
> > +
> > +Guidelines
> > +==========
> > +
> > +First, read the Developer's Certificate of Origin:
> > +Documentation/process/submitting-patches.rst . Its rules are simple
> > +and have been in place for a long time. They have covered many
> > +tool-generated contributions.
> > +
> > +Second, when making a contribution, be transparent about the origin of
> > +content in cover letters and changelogs. You can be more transparent
> > +by adding information like this:
> > +
> > + - What tools were used?
> > + - The input to the tools you used, like the coccinelle source script.
>
> Not sure repeatedly using coccinelle as an example is helpful, as
> coccinelle is far less of an issue than LLM tooling, perhaps for the
> avoidance of doubt, expand this to include references to that?
>
> > + - If code was largely generated from a single or short set of
> > +   prompts, include those prompts in the commit log. For longer
> > +   sessions, include a summary of the prompts and the nature of
> > +   resulting assistance.
>
> Maybe worth saying send it in a cover letter if a series, but perhaps
> pedantic.
>
> > + - Which portions of the content were affected by that tool?
> > +
> > +As with all contributions, individual maintainers have discretion to
> > +choose how they handle the contribution. For example, they might:
> > +
> > + - Treat it just like any other contribution
> > + - Reject it outright
> > + - Review the contribution with extra scrutiny
> > + - Suggest a better prompt instead of suggesting specific code changes
> > + - Ask for some other special steps, like asking the contributor to
> > +   elaborate on how the tool or model was trained
> > + - Ask the submitter to explain in more detail about the contribution
> > +   so that the maintainer can feel comfortable that the submitter fully
> > +   understands how the code works.
>
> OK I wrote something suggesting you add this and you already have :) that's
> great. Let me go delete that request :)
>
> However I'm not sure the 'as with all contributions' is right though - as a
> maintainer in mm I don't actually feel that we can reject outright without
> having to give significant explanation as to why.
>
> And I think that's often the case - people (rightly) dislike blanket NAKs
> and it's a terrible practice, which often (also rightly) gets pushback from
> co-maintainers or others in the community.
>
> So I think perhaps it'd also be useful to very explicitly say that
> maintainers may say no summarily in instances where the review load would
> simply be too much to handle large clearly-AI-generated and
> clearly-unfiltered series.
>
> Another point to raise perhaps is that - even in the cases where the
> submitter is carefully reviewing generated output - that submitters must be
> reasonable in terms of the volume they submit. This is perhaps hand wavey
> but mentioning it would be great not least for the ability for maintainers
> to point at the doc and reference it.
>
> > diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
> > index aa12f26601949..e1a8a31389f53 100644
> > --- a/Documentation/process/index.rst
> > +++ b/Documentation/process/index.rst
> > @@ -68,6 +68,7 @@ beyond).
> >     stable-kernel-rules
> >     management-style
> >     researcher-guidelines
> > +   generated-content
> >
> >  Dealing with bugs
> >  -----------------
>
> I guess this is a WIP?
>
> > --
> > 2.34.1
> >
> >
>
> Thanks, Lorenzo

