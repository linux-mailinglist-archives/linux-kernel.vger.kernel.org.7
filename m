Return-Path: <linux-kernel+bounces-750990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFCCB163C2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7BA97A5E79
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753AB283FD6;
	Wed, 30 Jul 2025 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PWBeR9Z0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qpgDZeoi"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EC1433A5;
	Wed, 30 Jul 2025 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753889688; cv=fail; b=FUO6MMDi31MCNQt8D4WeUv17NE3UJKJlb3bS73dBPHu6AKthb8wwbD5qQ6N6a+27J0RU9hRaWMIlKgEqmdmHKjUjjVznZOE4azfJA6ptQMhim529/+ptB9cRPdGTl+rmNub0P4Wwy7Q4gm7o8CNxvRTZh2sWCvRuOlU1TWdMDeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753889688; c=relaxed/simple;
	bh=N5yG6GcRK/GkpqGmQgIFrrtEltFroMVH8aXvtwgns0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l23biiaHVxdBvuesXHjRtpVR41eHtjPLd7LSyuh6DKWYum3Ks66zgPcdy59dIdLu4PtdsNr0oJPM73l+L4K04DNZbDJfU3zawxgM1S1upYC4m5jTt+dX2u7FGQrgvJ1cVdSQKPecK7wzVqp2Dy9eU0CKG6GuAE0cOdylM+S6QZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PWBeR9Z0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qpgDZeoi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UDMrQm012110;
	Wed, 30 Jul 2025 15:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=BbzDH7ZQ3/pvVlgqRy
	1k34NADlY18SEprx7HtsRh7Kw=; b=PWBeR9Z0lYTmrj7q/O+8rQuCOcpWqa7n4B
	ztOXI+9mTHzqN4efF6HdJu4Np1HB8PSv/HwWCiOSL8GWOcgFAMoad69xjBEq6qNB
	2WR2QksAMoAVpNKOsi1n5mnPUlXeM4wQXjA/W0zjqsRctqygfn7yY5Ea1/pITg6u
	kDT4oBCI2EkGDai+g2dQSrk7lPikOqPCoVw10emTn9uQe3Q+LpH3vHGil9dCCooF
	cPSt+JeQ+1WZa6cBJCxysPKsXfEo6/p6vOoCPIs7nqUmJa83PmXpJ/19nt6yPa6T
	OIIDW6nDtT47GMCssnVGi/KrQov1sKINCi5vX/5KeDzxI5Izj4kw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q2e2d6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 15:34:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56UE37ZP003057;
	Wed, 30 Jul 2025 15:34:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfbcd8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 15:34:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R62fN58YesviEzTFIXo2kRN6yDpFdtrDKacwz2lKNvrsqnJB0dQAndbrpD5b9S6gkKe8Pq0Esj0fZvQ0ikPFr3QC6OaKNFrFYaHDhlJ9onzEihpzXQpTzRW4HNFsOYd+uPc2f/v6pUjjFe/o8iEV1/tluJCg8QKGxR0YYpiucNaY61IDLUFINQeiE2rLeaPuAShsZ4M6tirURJ5dNYNK4tVAeyDCaZje6P5zm3hV2YfNIEK8OoQVHpIRmEZumWWQwSrtNfNIOEz3vnq5ngVV6AjAglaFxOEjHSXlu2c3EpaUkjxYeovQYCWt1K/9EAZAHavJHO0EazGZbmsY21159Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbzDH7ZQ3/pvVlgqRy1k34NADlY18SEprx7HtsRh7Kw=;
 b=EqnkRheG6nTduGkZse7D7w2YLKVjb7mAB3jEOhl4X39+uFoNp2g/hKV00McMK4/y4f4Y2IBRqXr6WhHM7sxsuFpSjUOZdHJ4wefBQPAqccpwYv8vB3o95xCIZLAzlvOeaIJ2e2LwsN1mjE8KSRjjbdOxaKkJq6DkTHO493ifjvZQm7st45TeiDHZcMxbb/KlFGhFQdMe59dS99fHlKIp6ohYcolQvCKtS6HHw68n8U1x81YgPl7347ZI3+kjyAsWhj3V6siSrC6a8yDU8LOWLagf7AYAJxl9UyEhSdJSZw/aqZXB20Uf4Bu+reeGwGohtm9Y/d+RkMWz+FJV6Cjgew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbzDH7ZQ3/pvVlgqRy1k34NADlY18SEprx7HtsRh7Kw=;
 b=qpgDZeoiq6yb6RGL1YN6bxNT8VBCh8cEe0DoYL+bJPXWBJVDzFEtZVlfnvWCgN6gPmg88VDANYMcH+pxI+lE73AQr66397KPnwC9FcsR+0aBUYN2kSxjZm/d8kIVkDWHG8MxiGamfGjmxK46g3Oox4vyZLW66JS9InSFvhk4c1I=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8276.namprd10.prod.outlook.com (2603:10b6:208:57b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Wed, 30 Jul
 2025 15:34:31 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 15:34:31 +0000
Date: Wed, 30 Jul 2025 16:34:28 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg KH <greg@kroah.com>, Sasha Levin <sashal@kernel.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org, workflows@vger.kernel.org,
        josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
 <2025072854-earthen-velcro-8b32@gregkh>
 <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <20250730112753.17f5af13@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730112753.17f5af13@gandalf.local.home>
X-ClientProxiedBy: MM0P280CA0054.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::24) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b42b6e8-11f7-45a9-4153-08ddcf7e9448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TPI8s747AmjkqMSYypuV7Lqa4lgBtft9G0sR7Tss8PGnxvwcY9DDcuoJfGMm?=
 =?us-ascii?Q?m/Mb0pZFpXI6f/QBPgyuYTfp8bCrJfx/1e5g2OwxIgZkVcCvf93FfMqT9oLp?=
 =?us-ascii?Q?EbEL9cJ+ZUAxipU8v0H6r6QUkEej7vS+RHiyzVFNsvous32o5l4O+3q1V+gF?=
 =?us-ascii?Q?FOrzYZ2IUUh7X3RD8fnVjE5O+M6D5X/j3lXcdG4QHprkrdjkMV32ueKyVg/9?=
 =?us-ascii?Q?TEH8FyaolN0De2X6H2XqYYViJlkPvJuTQF2Vzb8W3h3szADvjErQo2s1y8b6?=
 =?us-ascii?Q?OTAFjAyNuE8rdwnWT5zZzNMihcvPWPM8UpiOppxmPZu7/JzDGhfVPL/8uMvc?=
 =?us-ascii?Q?E9vZYwFfBbqxekW5R/6jLaSqD+XmoflVdUJn6DEIc9V2fD1UkDmOD3fUrOU0?=
 =?us-ascii?Q?VHAlkiwQNt/kCwdQBPY6uvbpEkn97+VjQVrWXquOHLUnPGP1cheRdSvahNJr?=
 =?us-ascii?Q?iBsa0ff8MoKVsCyhMDhgXi4tL07hENw++Irm6RCLPpnsxnlMRfpNUj1PowZt?=
 =?us-ascii?Q?QjhvjR9AT62na9+uytG4/BJCxE2IppubFZorPE9uZhPI2sN4l/8QtKiKL4iR?=
 =?us-ascii?Q?vT5DYHyjec0ulAda3bKRdUGxjnJncpu3tVyzKytwDOMV70IrT0iBChvXAfUe?=
 =?us-ascii?Q?XX++eLmQd72jy+Vjs9FtpwCnYoBF8rNbrehSJDULcwdaUg7GIyf5/o3DKH7f?=
 =?us-ascii?Q?2IOeK7OZ8oReFXKh58L9tbWEPrv8jWfCHAmpVESf6rRXPh9f3DPQeHtf1h3j?=
 =?us-ascii?Q?c0Ae2hhcMAuI0A8CPBIozfdmx3bkPN9eaq9/ndGXXEFapIG2spYtYuPUCVxV?=
 =?us-ascii?Q?E6SaKeZ2i9fMlVw5Rn2ohGBy9wuv14ZrrCC7sTN6x/AI7xATME/NXpy89cEQ?=
 =?us-ascii?Q?zGH7V/c95tyPzg0zQeo2nP5+Gbt7RlJeqNfgRrMNBs51p1QVWRZXHSXsX2Fo?=
 =?us-ascii?Q?dCJLF6iD0Q8jWC3OlwCY5vneh7OD35nVqTchHEa1RA2ptzadms5zR+X1awzr?=
 =?us-ascii?Q?AfgvO96rXWjO4NPpfZkW7h5xJ86ENwg5rILn88wfx9dc5b8UPuWiLTLL8UIm?=
 =?us-ascii?Q?O4hmjlep7JgLyI8i62s195AqvlmjY04MqvmPM8Am6rwQ5FJpjvhRWla5gsA+?=
 =?us-ascii?Q?oWXY4CM1IlnOUS7JK8oU+tjM/t4vdblt3B3ca4SjrfsflHbXzTK6JH8EYmaS?=
 =?us-ascii?Q?zUyPGt0IP7IQ2f4d+g1X0SeaTw0ZM2wz6UQWF0D8QgVkRUxJ8nq9lp7+Esq0?=
 =?us-ascii?Q?FpCli0epy7xlxYHdNjpMOGucgHZJXnpW0l85ZjyTSk4naxumkg1cR3LcuPMS?=
 =?us-ascii?Q?z9UWJNiuJNeodUZxVCd9IxyQah0Jegy599dfsy9P+hZjtFlt/wpNEKMi6CZ4?=
 =?us-ascii?Q?XbRj7YjfAwyukrTiEXynTnsGnM720F1ptOWjEJJQHwg/C5cqBnj77xepYnlF?=
 =?us-ascii?Q?NC0uFdAXXso=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jm/xxyAHxo0ou2E9wd5FTVs672hka99yXyyV3d+Y3rL+df/IvpGpyOKcedbO?=
 =?us-ascii?Q?9EgV3SjlIsPIWbMuNlpctSenkFYChsg+TlvLEGhabePy4YitY/ETyp77582H?=
 =?us-ascii?Q?r5NxO9C/Kn0dkRxMBrsft6iHhsrFiJRvEs3nQtdZ9yhKY7pcjCfA42hqszdz?=
 =?us-ascii?Q?xMzh5dQJOWsEkyJFqZQ2lYl+XhQ8R7zVVE9nHNkmBhhGuhNB0e8/OpwkfAh1?=
 =?us-ascii?Q?yCfOWoKSPjDz7VNpWO1qg53+8XGOs3tVUxt6wVS3hFEWijjIs4AxKyhXVOBQ?=
 =?us-ascii?Q?Ta+9TrOZkyEECeMbhuUrhflBocAs6mSjmcXTMCHYWZtzcavSw+ROdgm7lNUJ?=
 =?us-ascii?Q?OdIpBCtvQ4ZyNqzzcCLBIeFoIPmuvEFX1lS6pSBY0GKSSSw6fbro+jKbt4BW?=
 =?us-ascii?Q?5hTs/QtAfOa3IYnzVUHiRvvRoblOLeldzVYwfEFxX4VIpSRwa6u0Xvbc93uS?=
 =?us-ascii?Q?OtvfgCehaE1JadkZIvRy+bMeV0scVgfcBPXbpPTvc7HknUaAXJQQbWP+PvgM?=
 =?us-ascii?Q?EFy4wI2/AbZG+zxXpXy5kwfjNJdiZoIUwBG2YFni/tFDpd9E5nEYvPJNSCEL?=
 =?us-ascii?Q?16/57222vb5SUmDeF5CAhfYRP1VSPLF45Tt63tl8dIk2O2ehkHWRuvG/V2x4?=
 =?us-ascii?Q?sSZdPLbzouSl7AQNtB5b84bc+So1cIg+14rcJtoFWi7lN/gocjUq2z7ugTJk?=
 =?us-ascii?Q?2b3y17rwXnZLbMBINkubEsXUX/wPbBWrrHt2yqqaQDRhsXfnttcLC2+SlqBY?=
 =?us-ascii?Q?H9ZEUSRgWaqVyWWqUW7xeCfvBl3SJyOuraZEcffMNaInRkW7XM1+QuA51rUx?=
 =?us-ascii?Q?quN3Q4djZnKyYBYWL4uedvIJfHHF+8srL8eFdkG0SnlLnKwNLZY5wNcHIjUY?=
 =?us-ascii?Q?wd3EjhUYkVJtAY+m+FCrDcCvGFKhp6SL62FQ5H6FzWkCEN11Q3GW/2H6Q+ky?=
 =?us-ascii?Q?ZErcm2/cquIeilhSjzZNrIgwh1xAPIVMMa+/QuiY1CjGsu18rKtVK/cR6pQE?=
 =?us-ascii?Q?K0+3rRH67LRaTVTP2qIRAnSd6xL5uiw0ubzHWCsTfd3utJfWN2SuSSetUjLI?=
 =?us-ascii?Q?lfOTQt8Al2w1gTyBYTks+q2aPOOhztteDQ8H2vBBcP6Yr6nIM1sR9dt1885A?=
 =?us-ascii?Q?G0fUjKtzNKX4gxtvFuxCQXWwVKNZiOOKD+/iNkSQtQuav+OdFQZw6HQ1W/50?=
 =?us-ascii?Q?9e6EmaqhppeC3sq4iK5K54D9r61mv2k+9gS2bLhBFPmdk+yvrvTkPcwqgjee?=
 =?us-ascii?Q?8VVjbSXkc5OkH0cF+L5CKBUa3iAzXdsUYuhWmCGNuf8SU/YQKhK4TKuL0gtl?=
 =?us-ascii?Q?8ktlGBkrJFOEzldq76D7ivCZKQPRCUkzN6qoGmqixbmVJefQXC8RMwTHI+9G?=
 =?us-ascii?Q?vnRMeTg4VPRCQzfEd5fr/I5lkXHr1MBhJVx2fMmQC/b/fXz0lX6caRA8RzWn?=
 =?us-ascii?Q?cvSQSFBT1bZLkoVULu2qKNldEIyVttCeILbSuyEV5sUUppQN7aoz3VI/1TPH?=
 =?us-ascii?Q?7IFH98LOPlrOMxNtdffwD7ggdoTG2em7mC0ZqxznUeMkoCQIpkTbdY7sUPdG?=
 =?us-ascii?Q?//Ce/TnKC3AWoy3GR6+/Di1fIYbxa3d7YzmUS/46ZTtW38Ae8OaDMqx7sgeQ?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h5O8ygTJM2KECLQwgfFPIBqP0L71MHSw00uLylHp8wyh8ylZ1fNX3CIYFaVBqo2glf8iFkYAS9pmDoMuAH7uGpOb6LvwNIyxjfOwNu9yeyt2N/zzsak9hdea4FOaOJXBlHzd4CyQNLQgAvl46KW6ikhCSYOki736VRM+iV4xLIQA1jKsMMOUaaikAjiA9ez0sswX2cpneoCCwOgKUkg7zuNQcWQPYzcoNXaaUqlD2aTh9jnZegG117aiCZniSO8roMZTO8IYH65aZuFpkQygzxd/vMWNrzghcDbnn1/ICDz28VHHmhbT0RNYSA1fkr7ch9O1WTo+w2NqaxFNXnwgGK+kfhycIZm63XofYc9fTyIsXfzzMU/YGmTGE37lDmuUAMhFfcZ9zlqI9OkwSynSZztWLjrXQHUkRxB/P9HxlaGuq1quYYBDoyXY8s0gXBI71tVGERyj0s8tkpuFLrGf9NttrLulx7++s2Qe8uoMHnUOWhkGDdZ8d9Q3Ec2G/zf0H1w2Urw7Oyx+mLTXzNvdBwpM7l/C30K1FYoO9grVBaMYbtKySgxnXtMtt2QltXIYN8fj/9lThXn7oV3UXJns20TwKLnCprCOdfyG8GGp+5U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b42b6e8-11f7-45a9-4153-08ddcf7e9448
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 15:34:31.7669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5KQX3Dc2tEHeNc5MRqU0fpJqQjqetdv8xEhnTt6c8Ep5xOOhFiBLpxmR3wKFKK2L5/l5Ob+/wQmuccaur7BKg6wlGiydA4nxUosl6uMGi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8276
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_05,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507300113
X-Proofpoint-GUID: oQ0AkFwU3GEo9PIAZmvVH2DpJgQTTow9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDExMyBTYWx0ZWRfX07lq5aLS6+rE
 Wk+TTCrjKbjAHzb6YQa274L7DZvBlMjNd+Wnn4DTJYJTvICcX0uH4wJLTd/XlzbI/WyMOQJDIHD
 p6bgc2/j7uzXc2+v9+9LitcimYo0lU4+loTP/tuYiDI1Z/HBsmrXAZgm0/qa7URF3OyXRhdU+Pz
 lQGX71LFIhw0z5qE8tfM1Ydi7aLFCPSlg69uJ/Wsyg4xEaqIxtAVM+nt2HGKX9PqDH7+VTPmjhv
 f43wirTxvcXtngisEpEPu2yL69Zb7Ns0+1/CgvkML4nSuNhKXeGyRX+fODy1eRgHWTn0P7s/6QI
 yU9mvGfv9ELOWz05+3FerzlTPQmyjnAp90R9LUeeicuq01XiqBfYe53LO0akes1CyH/WiBYxlgn
 rT4UXT4bErxCJWpxvrYWiwk7N1xYOA6F2NFIVfLmJp6knGfmrTHWPPTqgaxBGzkK78dpnChB
X-Proofpoint-ORIG-GUID: oQ0AkFwU3GEo9PIAZmvVH2DpJgQTTow9
X-Authority-Analysis: v=2.4 cv=A+5sP7WG c=1 sm=1 tr=0 ts=688a3b8b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=3WJfbomfAAAA:8
 a=yPCof4ZbAAAA:8 a=PQhV6i5PZF-3McwAvtgA:9 a=CjuIK1q_8ugA:10
 a=1cNuO-ABBywtgFSQhe9S:22

On Wed, Jul 30, 2025 at 11:27:53AM -0400, Steven Rostedt wrote:
> On Mon, 28 Jul 2025 11:52:47 +0100
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > On Mon, Jul 28, 2025 at 12:35:02PM +0200, Greg KH wrote:
> > > > So to me:
> > > >
> > > > - We should establish an official kernel AI policy document.
> > >
> > > Steven Rostedt is working on this right now, hopefully he has something
> > > "soon".
> >
> > Great! Thanks for looking at that Steve.
> >
> > I think a key element here has to be maintainer opt-in.
> >
>
> I had started looking into what to write, as in the TAB meeting we were
> going to pass a document around before we posted it to the mailing list,
> but then I was made aware of this thread:
>
>   https://lore.kernel.org/lkml/20250724175439.76962-1-linux@treblig.org/
>
> Which looked like someone else (now Cc'd on this thread) took it public,
> and I wanted to see where that ended. I didn't want to start another
> discussion when there's already two in progress.

OK, but having a document like this is not in my view optional - we must
have a clear, stated policy and one which ideally makes plain that it's
opt-in and maintainers may choose not to take these patches.

I'm not at all a fan of having a small entry hidden away in the submitting
patches doc, this is a really major issue that needs special consideration
and whose scope may change over time, so a dedicated document seems more
appropriate.

Thanks, Lorenzo

