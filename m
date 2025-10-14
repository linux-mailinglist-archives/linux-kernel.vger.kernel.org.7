Return-Path: <linux-kernel+bounces-853070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79707BDA94B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C87264E8B54
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A1223D7D3;
	Tue, 14 Oct 2025 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WYaiaysI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kQxawFfA"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688D9302143
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458270; cv=fail; b=LBTSM/cHnmBvpq2IdbN+4hv9zf60IpH1gx/BQxszd9ZcqkRz9kht8cPDFZHTUVJX7FAMhpMG/Wgky3iPKYUTgxG/M2u9p6YbxH1QkJ0vaPK/rQNZnvq4LqyWKio6r2N/URgIXE9OyR5zbwS5ZfMwvukkbFrZNKqv+JzsAQVV5XA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458270; c=relaxed/simple;
	bh=HMGKIqxIsg7Lx4ipZkhxvizOevUYy2qDi0GeFBt2VlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AuzIwFo9ZuSpFTZ0OODqQ9BZMipo9Swy9M9taype1ktfTOb3GRVE31RsubEOqsiIPylKtLFBueTZJkJdCtzEsRQOluxUHEJutRdqMyoJvEjsnv2SN+uYaZUP6xeq0Pppevw5NdYN7zjgaJX+Lmx+0mkZ3j8cZYsn/2MYaA8s7Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WYaiaysI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kQxawFfA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EEf7qd014431;
	Tue, 14 Oct 2025 16:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HMGKIqxIsg7Lx4ipZk
	hxvizOevUYy2qDi0GeFBt2VlM=; b=WYaiaysIkZJT966+56lP/OJojBFlLTF0K2
	qrvXFDiyjfyxneIJoIgnzHDZQ6C8le88RqB3FEiWZdth6AxXWdcLhunByqQ2EW0E
	Jtwm2tpDE6Rmci69U/gEhVNlhuyK+Hpam3wGaX3Z0K47q/DswQ4K+oJnf3ezWlSJ
	lBIUaz7oKyV5a3O/wtzYcDt7l6pZZkLaWSOF5ZR+c5RdV501piPaEspTa7wXboEs
	4JW9OAGZxIDTCfWeBM4+7kAVuf+UTPFuoGo2R6KgOvQRPDMtXJHt9q367l/DtRfm
	mNjUS6TYi+6sr7PDBTzVR2KMO+rQfA9WMSiLpJoMWlPu47UfA5Vg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ra1qbuks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 16:10:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59EFqVHs038439;
	Tue, 14 Oct 2025 16:10:44 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpf5rea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 16:10:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RL/YSTjymVOjmr3jkJCSOVOYr44hINrYcEpjMutA6eT9ywP4XvnSE4UN4eRf3H/ahuWC/QUN4eRUbLn80WsufXec//ITgsiA2zHeBH2MfdCKgNCY+7cVCCZ9LDDOeJzO9U3f98OZpvXYBUkMtMB0bmHrYFZslfSUtavsPwLpm9UXHjfVPcdbzBUkiSLdMs9ZAhkMmattl4KOAIpKMABRibgOj3mfrLgREbPcZyc3Io8t/qWEWtpjzpeGsQUAhfDG5mqefxG8SvOdtfQPU27NgRD+PfCOkgpSSL3OlHF5mEM8wOR74Z4XwvN/J9Huu3gQMu/xL9fEhsm7uVeuTFzmmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMGKIqxIsg7Lx4ipZkhxvizOevUYy2qDi0GeFBt2VlM=;
 b=SKVLI9BBfQN2nQm5wdGcwAy6Z90QrVu1cmcnpwWVVUopKwVLIh+CrtkIm0j4mhYhNHHWzDSPaLlv5aWIDTSACrwJL6rx9CLq/6vjyLc3K7XmCUFNsZFQi23nbJEvmrZ9QbjDW7RGtjBV9fWXUvZUqjSPVRrIjWleyEAS6esUyfuAdYtO0dF+NDZXMn34S2N7C9EUrhELr7LbpaUroFdvQOVAp7Nsxe2cAZic14FbB4U+UJfXa63lntANLccBNqvfiZkzxn25tO9gyisV1l93mp7Nu0xbMaMzU11cv7WGUu0HkAOkNP5bwIfe4Yjs+KKBwZq+hMaoIKuVg1jGvzHfbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMGKIqxIsg7Lx4ipZkhxvizOevUYy2qDi0GeFBt2VlM=;
 b=kQxawFfAA0wCPXxqKJq6onPdwSpU8rvep0HVTMuB3TM16ju9T/pAe9l7jl5LmpMpkNOgqDYJA5t+l7kFFkfJ/QOyzAQ/GVzk5gbzPFy9yiD/9oG4VXnsi6MX0cdCSSM1Jzn+DW1fJ4YJEjS9i7KRnXwXzzauubBOOH4BYEak5Mk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB5866.namprd10.prod.outlook.com (2603:10b6:806:22b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 16:10:41 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 16:10:41 +0000
Date: Tue, 14 Oct 2025 17:10:39 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, baohua@kernel.org,
        baolin.wang@linux.alibaba.com, dev.jain@arm.com, hughd@google.com,
        ioworker0@gmail.com, kirill@shutemov.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mpenttil@redhat.com,
        npache@redhat.com, ryan.roberts@arm.com, ziy@nvidia.com,
        richard.weiyang@gmail.com
Subject: Re: [PATCH mm-new v3 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
Message-ID: <7d3ac12c-c3a5-4913-93cf-98c887f67397@lucifer.local>
References: <20251008032657.72406-1-lance.yang@linux.dev>
 <f33735d3-b38d-4b6a-aeba-b415e6b24ea2@lucifer.local>
 <0bfdbccd-9d4a-409f-ae43-b44bb7347d70@linux.dev>
 <f7392f43-b8f1-4e6a-b9c8-25ad8a47f82c@lucifer.local>
 <d2e5b099-94bd-444d-9946-182807443539@linux.dev>
 <c44e198d-7d46-491e-adc1-86cc306c27db@redhat.com>
 <e2c77ce4-c260-4d10-b9b6-93a507080e61@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2c77ce4-c260-4d10-b9b6-93a507080e61@redhat.com>
X-ClientProxiedBy: LO4P123CA0216.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce20f8a-a6d0-485d-8a6c-08de0b3c38c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K0dj8p4GU6FmYGCSQgcz0r+ixTpUMKj6SI0b35wO0R/+e36/HGLi/+4Vx1cJ?=
 =?us-ascii?Q?LoPEKqcP2umLkCWmPioAYqJb6iVnCgcp9k/oVsZX3J5+wAXOKPaL7GkYuWrc?=
 =?us-ascii?Q?wPRa82B2wYmW4yGlwEmOBLJmt8wHtN5m/Y1vFf1yrbMY/chudhZyzy2B4XUq?=
 =?us-ascii?Q?yMEIWmdZ2fwR7pwnBTRIJEzgmaxgWVLH1txPDkOUEm96WQRWVYutHERlqFBc?=
 =?us-ascii?Q?0o/Vyw2ZEPgDbOuf4Om7JAquSMPPh9iyluI7JgkkhxSxLYjOkEA3wgcP6tsU?=
 =?us-ascii?Q?sEoaQeiMw9kVzwF/kl01srmGD9ljJesFhELAe4yhWPRis49DbYb3fsKuhOHw?=
 =?us-ascii?Q?sm8uG4OQWUmZhktQFbV/Aay1QbAJQPA/69/AP9Lb7GiWL9lQEjUm29BHAD2K?=
 =?us-ascii?Q?pwuhVjjrJjOmV2+5FPvMd9pEN5ru1z2DT8ZY5HgBpeMWrGL4wKp2GnVEO5jJ?=
 =?us-ascii?Q?f/72aNweVAYNn3ALthKl+Vtx75cbe0iCxPSdD6bw+TR/nYdUzWR86lWZyo4l?=
 =?us-ascii?Q?sHHQA7wprjLguh/FcG6Aqf5/wzg6qtx9FkSR3bu9NnTakLmUH36h8/j7QcI0?=
 =?us-ascii?Q?//Xbkc/2mnM2phGLN9+UAnNgg1uONLoO8TrBq8dlLeA/Vv+YUGLDr2YH0h97?=
 =?us-ascii?Q?l0Om7Bpo0FSEKr5W5yXb/CJcXjXdDW9O7vo8H2Ps+ZXxDxs+FAGFboMvMlxk?=
 =?us-ascii?Q?gNaBP2JeR9UaP894WMkmfbvZ7OBMO54kkfY49ssf73yBDwjtmHQg6C4xm3zn?=
 =?us-ascii?Q?WRs5KZFOelib8SIi8NwLiyT67AF372Et9S7m4QO7bzp4NX5Nt9p4qwFTxbqI?=
 =?us-ascii?Q?L3Ma5Yu2je0B7uW0ChOVPUlVx0rzYKuT5eZ4IeZSnY2CoeeydGRW2vWW9OGm?=
 =?us-ascii?Q?auJjRNBeKf61ksjywBDHojBWnCfpfL3YPg0FuimZzJVFvGB+KejZDuHyeZ18?=
 =?us-ascii?Q?ZvOc6PTT/qe+RzwK72YsuUdLFn/y1O1aiIVg5p4VRIlekNJAx8CBwtfBnNt2?=
 =?us-ascii?Q?hAFnFrDKXyrg/rc3ODl4tYSwhVnsiB6EKq6Lctuc/C0vpXNJ7KfXa3ZPbO4/?=
 =?us-ascii?Q?SMqn90g1npGCknLomciU9P6uy+voQFfhXJgymcks52nhJML2Z5YM3TkAmicS?=
 =?us-ascii?Q?K0HTU3K/0hv92Az9Sf3kC6sKpjpa4FZurGjh+L0Gk+pG0y4bs3Ekyzk0yLLF?=
 =?us-ascii?Q?EuxhHEzYr3KEYdw8870+G8j1w0DlSEyU9m/N5u0wrmdkjjYLsTjobMRwkWcH?=
 =?us-ascii?Q?YMLHZsdsYOwTsTS8Ym7JbNjkKgti9wmvNoEhdf+44m9WfuJjYYqEQIm30BF2?=
 =?us-ascii?Q?ZUt5HQEJPU3NR7cnAQdcbqWxENPFGk/Zj2zrdutMJELuS7iS+iwu5YF/e/f4?=
 =?us-ascii?Q?Tyj0QQG55DvPNsQaWlb2luDMEjh5lfXncDKW/i6PZbBXduE+/IlJSUgAM47L?=
 =?us-ascii?Q?xNtERH72/RF0HadDEmcGvoERJAZriPcb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L8rM3WDp0wbHbjAtQmr+ALVG4XfgpGeiX5/pZDLWMjD/IDnKiEd5G6snhPcQ?=
 =?us-ascii?Q?XKM+fzb1fEpLKja9AAku/7QtiCVmnCnKDxb5T/T8sCyMTA0ax/Hw6IWJKVv8?=
 =?us-ascii?Q?ZXeppd1DCBy2f/hitl+8s/aGAfTKZMQW8CH4T/AJNNbRj2L3KeK+A7OqBNh+?=
 =?us-ascii?Q?W//Bk5Q5GTntNQL85ORHk/jfPayJX1vT7+am2IdjFyokZqol9s9591GyoUIu?=
 =?us-ascii?Q?5s+Aw5D025h60PdqVit5TooItJgEIumgcpqnLBVrB0Mg2xAD0xCixfGRHyUU?=
 =?us-ascii?Q?eB3SGq2hsKyd8GUHGaJEAIbWH/ZQ4cSBKRkP0k8yJ6zrTS4fxvskrUQvqdCP?=
 =?us-ascii?Q?89toOGGSNIMr3x1Zz5AKXgbmuoevoOl1kWZYSnruv7gxh3bK47Kvs8T20I8R?=
 =?us-ascii?Q?kQxreqGHEcpu/CVbCD2oYlLL73FinhqXe/zVio+hbGri4dWYBJPPB1pLTJWM?=
 =?us-ascii?Q?oY43mdX+qN6vd/1aSRuFxm1PjTcGyBAJSyoaZ0zeHputXWMXf3zwZAxL7dvh?=
 =?us-ascii?Q?deLk6qXFgIQGc9/gtLQa+RuVdUoqy4AmVyC0plaHdCtlMvzn5VIXNVOEYfy2?=
 =?us-ascii?Q?Nk9UlxWVrKQOd8OYImNWEIsfqLvy3R6PtRH1XIwaSQRvH5zsXcB5yVF8OVLu?=
 =?us-ascii?Q?QDpqd+qpbPttIgeGF1cqnhnc5DCwzdJVWrFHqBAneRf+QpdpFZHKjaBvDaIN?=
 =?us-ascii?Q?5lrltdOIiIzqmpL7DWH9qdG0qhtygeQiMiSvreIEtkAEY3+08NIvZGnC+ewS?=
 =?us-ascii?Q?va4CAmcANoLtJvd6Cmls2dBFimQwtTyQa+gQfsnQUyJAfMqDtyO7jA73P7GU?=
 =?us-ascii?Q?sjaUmrscnm9e5Rc2IuACzSlHWOuSpTMvYdqlN8ENYcS/bP/+iSbIjVkyVnSF?=
 =?us-ascii?Q?Ni8ux7HjaTSuenILJRJMUX/HgG/h+g1eWhf5m1WY0PnrUOXnYnwonNCw25u7?=
 =?us-ascii?Q?28R9/oBx+p9ong7hQW+UR7gwQuaifZE8MhVzjGGYEUYmFCoJcWDoHi+Afcyc?=
 =?us-ascii?Q?C9Y9rhuv+g98QNNU09zX2pjGiBLeMAKMUUK+ezcWshAxtgr7QVU+zyTK8d20?=
 =?us-ascii?Q?aoDqRw6bKSyuIA59pEtryj1U7WXH2oo1u/XO+xgzZSmu6Z1uwKReR3DFnJnw?=
 =?us-ascii?Q?uRjWx/ST55hiHQYIfhid1DLvsMHqnVBQqaHtL1vz98PGvnpsWuG3tH+0lVXT?=
 =?us-ascii?Q?Qjqaw2Z9a6NSdeYi223wyLBuN6YXAQfmQV+kqJPFhXJCwOaU9paw2OhCFmku?=
 =?us-ascii?Q?OKZlBgo8tArTz0KG70j2xQA9HQxLc0f8DHv8D+eNaV0ExiE6+xQGVuScYEdt?=
 =?us-ascii?Q?Am2oWre0zYy6evWAZjtdFl2yGtrnE2afWmpovSW+bWLpMPbqBjM5kboOaUsD?=
 =?us-ascii?Q?Bz4L7e1C0xtR8tDaNUDG4WbKTnRCeh8AwpzFJ2hIV/StP0PycbFpWeOK8RSr?=
 =?us-ascii?Q?iQRo51SL9w1ui8g0pyQQYvWr73NGWTpvMrh8i8YC6ucB96ldmm7BwRNCQrQT?=
 =?us-ascii?Q?aPKFDTz+k50DbG3w1FDYsR9mV4Z06mVENMN4/7AnEu2Lb+3wlaVs+C783Jof?=
 =?us-ascii?Q?CUg5LGtDhIkKZfjw33QtWQpi+pRs+5SdE4J39wC+00+66mLvTa3k7gQigMfI?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	++civuhgfwkm8r88eADoGTkXsFhTndY61bIf9XMEKGfutspkLcQvIiRMzKNS9XENFgxLM+4Kw1yFwUUbY2V/z6kUuSaVR2qEIG6flRkZA3MHriD+2SI7mtcyk5IDFn3vn0xhKZQC9rqJfUv/w02UgJwb8Fos3aq+qdrPvIEi3Gn7nAqh6D256Tr67xgyZ+DJelMZujyk+ygiRS5UyWdd/TAv8ZpiIia+8/wVvOy+FF44RRv3e5Dc/iTNQe8OBXpamJceppyPeFyRyOAd0D84+ZCzETvaJWU4NomW6Nm4i/AK7wBRXqYCNsGHzccSm8Sa78twUvtax7K1ft+sGgKAGisbGuN37qp0K1cT9nqui7O2md9HFWB9ZP41F0uIjQKRBMWSftlg6ica1WJlizElwJmEBBIrqQJtNts+fObPnISKISpM1rTE5y3OvCYxW9GzYsft0h42SF4UuDN+VONnFcYhPlgAT5i8AmIvg8hG/euwtoxCh650nJ9LSysAJD6kpZZTXrP6ONpu5CLqLu9qXNxr+ArlObPNZco5vTpXYHg+zNpBjEZ9l8S2xR8b3IB36/hO66FKSoDwpPa03GKNv+hKNnxqVmtSst7rgvtcJDA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce20f8a-a6d0-485d-8a6c-08de0b3c38c1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 16:10:41.2245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8CnPOPmGKePFcUDmMraR++wv1wwzbTiMNDA54yM+Ihbq6yVWMjbQLUzk3nPS6NXDWM+gwMmfWkIWlMgHE1MuNm061WkmKr7kfJMfUcWwYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5866
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=852
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510140123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA1MSBTYWx0ZWRfX+IxmU+nE8m7H
 AAlBefwfZnqJcqHbc42sVuZAS7NSS6K05PMhNNTUK7Qm8XSiN6KttmwACcFi/0+vR1ssDiqePHP
 5xo75B4eyCABb5FXRMHcWulnj4Pp2GyNCnk9ueUmhfN4xCopmUgLjUxHbQmc+VeJWpNnogEDufi
 687GC2cWI9h9Dh4wdlKO6qS7r3Vgu2fyNZzArJ5GgU402WzBBmeA29IKSQCDoaAVo0Grt/y9rto
 fJq4hbMoZ87HrpFiS4dxzfPV0VaoPvIfPLqzUKDG4OGQ7u1vQDPa8PLQ47Zma+I9zg5vq1wFuj+
 CC/k4s+spMubwsjQQ9/aAw2qxxTRdMVTLSuucS6j4K5Sk3IG89BLZqqdHFQPr3LriB3GUDTDPMH
 EJXZRsbi8vocMlfsOjB3b3QAV03rbvC/3gmAELC2OGbMdtS0wZ4=
X-Proofpoint-GUID: zbgC8C0mNybD4yWScSeiiAzacHVNqy1q
X-Proofpoint-ORIG-GUID: zbgC8C0mNybD4yWScSeiiAzacHVNqy1q
X-Authority-Analysis: v=2.4 cv=GL0F0+NK c=1 sm=1 tr=0 ts=68ee7605 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EB_fGugrAWb0RtTbTjAA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12091

On Tue, Oct 14, 2025 at 05:33:18PM +0200, David Hildenbrand wrote:
> For the sake of progress, I assume the compiler will optimize out the
> additional pte_none() stuff.
>
> I absolutely, absolutely hate is_swap_pte(). To me, it makes the code more
> confusing that talking about something that is !present but also !none:
> there is something that is not an ordinary page table mapping.

Yeah it's nasty for sure.

I hate non-swap-entry swap entries with a passion.

We clearly need to rework this... :)

Naming is hard however...

>
> The underlying problem is how we hacked in non-swap into swap (and that's
> exactly where it gets confusing). Well, which this series is all about.

Yup

>
> So, I don't care in the end here.

I do still feel a single guard condition works better than having to know
implementaiton details so would still prefer this change to be made.

>
> --
> Cheers
>
> David / dhildenb
>

Cheers, Lorenzo

