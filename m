Return-Path: <linux-kernel+bounces-771054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF444B28248
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6B81CC4400
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF5524E4D4;
	Fri, 15 Aug 2025 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="deJisWn1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lZ16yPuF"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EED5226861
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268934; cv=fail; b=DfU5W5MJH+zU7lLJLip+FUCWTudaSZQyBFB0XZkM5RhhH70PXusSGsHMB6K14DGSvuul35tLAQP0JlQvqpcVnvqz6yNj+FQiddOXIzNPZsYZeZ5NcQ9OWIV7bkQWd6ulYCgkJFDxSVbfZxsYDvsH3RrW3ryzAGWEIMHDj9Jb0Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268934; c=relaxed/simple;
	bh=ttV8nsdpNZN3ATfCGXyy8Kpy6xSKwWpIV7nGPGo9I1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KXfLBp5i3v6PpK8oOPE1N4mQyEND5+BYCF1bi4t/c6rUcKMxEAbS4x9JjDGQH84fDjh1kUDrWCnXfwGgMwd7D+uO2qBmZrE3R8TuZjGGuG/ZcVz72zThjCvC0/WPz6zFnSbiJ/8lkS6Vo4pLP9DyPOstA37F3acbOuBCyoueJdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=deJisWn1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lZ16yPuF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FDN43J009183;
	Fri, 15 Aug 2025 14:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=JO7UjgvVczgpCDSGbc
	7Z4YyQ3r30LxKoz4pCZXlA2mM=; b=deJisWn1keRpQl5r9khEV/Bm7H9k3lQsa5
	mtNj1CFG+9TRLwSWoAK82Vj8GLb/XplujY8hLF26lZs4BUB6i8aJmYL/RPS8t9j/
	C0fy5VJoHpAK7GZfR5/E+rLHvn3YXfRPbmRasaycWKQ3T25Zs0oKJQfg7rGdoZWJ
	IPziPPbl+9N0cDVYG1G34cnf8oBRij7TPnwBZz4OJ66RpPdTW/IFOaAUfuYztJSA
	ztN66MVJVRq484+z4hMN60ssQrka4fia6YeAsBK6hok6E1ksH5tuxgzUUZRf4lny
	WMywz5ht65JrWGUndXIXg+CD8xdkqfgG1bAFOKZWX952pSiWrq3A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcfc74a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 14:41:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57FCnr03030076;
	Fri, 15 Aug 2025 14:41:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvse1xn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 14:41:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+L4qj/amF8bOhilvsNFIvNVl31sIW5KBziGF/EIzfG6n89Qalc1844yPhH8X7TDypUWbStSAk57nfqyzAsr67uZfb92F7g1Un++FRIEe1Suqth4ph1ITHRXzPZ7bLMMk6sdut5tuMXW7FxzyMyAHaOXInyz4j/DuziovWGpCUG1kM1oAdddBZFYb/tS+eNYVMfeoPiVqjfEYjC38ZbnlUpyXNB7Y5LtuEUhj9d+jveeMTVNAs8c0hYn478LrGwuOunHm3zDlpDKw/5zybyVPTjiCpdTJtQxz7PD1kRqtUi77Zdg4sUWk5CRJXyAoknsgyN8HoRQiShteJO1qHKIOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JO7UjgvVczgpCDSGbc7Z4YyQ3r30LxKoz4pCZXlA2mM=;
 b=F/plZgAzVYlS5P56g0/dZe2NcR4FMqGAuLxDQ3F6aDLOxyfSbw7ezjismsQKMDwjw1iEfKqMuR5XtXw49LwYVxVgphRzCETR7QEoRPQPkpvVbu7XMjE5mcpKnDeUDa2fNKmLDtjz+QVyGYNUgPtgrh2Kij0DlpuAmnbkw1X0wJL/1lTUhoW11+xsmHGWEZ/HIpMTiM5doN6D9qDDsbPTuGVjNQVS7C8LNJyvsE+ec9F83y5fu8lGuJRwjHXYRtdL0ZgOC6CgSCsmMgt54oH0sNGWMn0wYePUygKJUJp1UeV9r8MXLXblRcGbeA3fLvLtcsikJJSBazWyLmyw+cJtqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JO7UjgvVczgpCDSGbc7Z4YyQ3r30LxKoz4pCZXlA2mM=;
 b=lZ16yPuF5uDjarp6/PPanJJk+O1QTM3eWLm6p1yx7gT9L8PWQbgMIdPITuRYFBV2a0qFCbPQD258WgspKbKgazWlz/VHXmMeExhTHT0O9efrp7z9Asanu9IieufJBvlD+aNPmolKzlZnWT298ajiksTbbEJPaDbKXHBmUxfjH0Q=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DM4PR10MB6232.namprd10.prod.outlook.com (2603:10b6:8:8f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Fri, 15 Aug
 2025 14:41:17 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 14:41:11 +0000
Date: Fri, 15 Aug 2025 10:41:07 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: zhongjinji@honor.com
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
        rientjes@google.com, shakeel.butt@linux.dev, npache@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, liulu.liu@honor.com, feng.han@honor.com
Subject: Re: [PATCH v4 3/3] mm/oom_kill: Have the OOM reaper and exit_mmap()
 traverse the maple tree in opposite orders
Message-ID: <26larxehoe3a627s4fxsqghriwctays4opm4hhme3uk7ybjc5r@pmwh4s4yv7lm>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	zhongjinji@honor.com, linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com, 
	rientjes@google.com, shakeel.butt@linux.dev, npache@redhat.com, 
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org, 
	dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com, liulu.liu@honor.com, 
	feng.han@honor.com
References: <20250814135555.17493-1-zhongjinji@honor.com>
 <20250814135555.17493-4-zhongjinji@honor.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814135555.17493-4-zhongjinji@honor.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0400.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::10) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DM4PR10MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d6b1d4-8306-4999-26bc-08dddc09c744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q1tImtQBibFEn+1DfXq33//IwzCY/9TY6nAXl3kLSCFjoNKj28SM34xF6X1d?=
 =?us-ascii?Q?FFBXXAwcJ9nDY2pm2PC2x+iWxti+Utn+YRT1wxy8CJtwxPyC5a4gps7Zjvse?=
 =?us-ascii?Q?zJFAY9Lzbuqd847xXSKek4QqXSYKHdsd7lmfe8o5qhT/eNEV5UJQZFQPzAiJ?=
 =?us-ascii?Q?Ym4W1vwqNyw5rNYjd8CI6JKvLOV20x49ERWeMOFG9G1wQrbAe8iiRxteLHVt?=
 =?us-ascii?Q?q9W2dFFfQ9Vgzn0nRqly/VJJ5E9c7vIpZTAMhiPvDa/duc9QqRO2f7YdKc/L?=
 =?us-ascii?Q?mZnbnTF3fdGFrT3HpQAwx0+6fOlyI6qCzGZEez9h76xc3HDayQrkWnhqAe18?=
 =?us-ascii?Q?oKrszZYHTLVnIVoePYoaXrqsjGbqbgb6d7aeX+tSuL8sdLKqUVGnl8FNrUUd?=
 =?us-ascii?Q?c2UDY4t8EID0ks5NJRRYxh/0E7mE8IE0ErY+ynMjVxqw7qSgA1D60VyUoQDR?=
 =?us-ascii?Q?NzqULcP07YuFe0w4dQyjC+wJcDIpQPHGsvXMArB0v672UfDGYsf0akDXGyzI?=
 =?us-ascii?Q?5+OV8D7X4JtmhgJ30EOzZdknzeZhsDEhjna6HuWLG9Xa/OD2LVrxR+o7VYMn?=
 =?us-ascii?Q?X4lyk7QHKCg8V9i3aH+L48vL5pG71JZG+I9aWeRfCfLFh6gBIRS82DQt3H5v?=
 =?us-ascii?Q?r+/yLjoRI3udDOfQCdqLJsqnS4QoyK7RXT/D7kZXkbrxz478lCbr6bI2ssG1?=
 =?us-ascii?Q?OSRv6NGncFvE6uqogfHMSM9QSMl/0yZwdxmNRuSKcWmmG4Cco7loSs4wi1Am?=
 =?us-ascii?Q?ntek56uyYyCqMY82A0upEewFgqSCMlMgyCdQ/i0szzujgDt10otVQhkfN9zb?=
 =?us-ascii?Q?9SgTXGBDAOGFesruXxMH+354ZUfzvU5gcpBk9aJikD1hFMLyd+3aM+nb2wSb?=
 =?us-ascii?Q?TblgMvzO8J6gHCCDu5EkXloHvbvkr6oFsVUI0tQVf3j/9Jp+G0g9dTqmuE5d?=
 =?us-ascii?Q?wYlZZVJOqCAnPmi3vkSWs3VAxi6ppA+hr1Nau/+uF2zgpsdnAvTjRghtqbRJ?=
 =?us-ascii?Q?FFgFxojt2vPWwR29RnUCnyKA9jUZy3aZOSinlYatQbMQMZ1VmCAJprhyBj5/?=
 =?us-ascii?Q?mWEWX4V0QHOTkq6YLWdGmZPPOsPBjIR2mI2xQVJGC+Va6wSLedk2rFaBPJNp?=
 =?us-ascii?Q?yNtOmjhUxfGt0RqjXpSjtzia9nt/9AxgOvvLjA1dtdId1AxlzjaHlFQJfgWd?=
 =?us-ascii?Q?QJwNrbNJo9KBuXUR69IlvfyTRg9tQSl/O25fpquWeDgFk3rsrGE+50YEk3iv?=
 =?us-ascii?Q?Zq7RFkwjqgLgk0e+RO77Kg7C2MV+JcDI/bXTJtfTP0NI0dzB+WMVFsmi1Hbk?=
 =?us-ascii?Q?j+tlNR/bFwx3n5V8vMikBl6ipxSgvc2DlbO08hv2bG/hmPskzZKDYDrxb8VM?=
 =?us-ascii?Q?+FgJtJO8gWxBHffBQuhW8KSDju2M5twUAm0BKMEKrtxTsJOIDTd8ZRcIzxWu?=
 =?us-ascii?Q?c2dDwE3HW84=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BixBgKGnp9dn70mzRgolSWSfbeNB9/E2IPdy/FSxXGMizGhhbdpXeW1LCtiE?=
 =?us-ascii?Q?5AZhKfu92Yc3nLWPALQY+LsgUI6aQ5l6tQIV6i3QVyV2yp43JwJhI3AFf15s?=
 =?us-ascii?Q?IITYP3Jbye1fdHI3YmrKZkx/2sVVCtLgMtj+I+y1QtvrhahcoUXNtv2qUnJl?=
 =?us-ascii?Q?a2rQBqTh6OOczoZOUDPusnXk6A+ax6JaM9Lf0oGbaNbL3tYZtiiTChW82Isk?=
 =?us-ascii?Q?cRLjFuJOVIPFKP/6lWCZO3Q1a0uM+Y+1eWf1ZG47BPgSqmcKrM9I2uA100eG?=
 =?us-ascii?Q?MlBYS3Uo+Ec9cCVfRWZEranacUvQ8Jdmb3KPjoh/K0ccNwAwSwiHCLBIKPpE?=
 =?us-ascii?Q?OgJMXuR/Dr4FuRWxcdSVn4Pck8FdDtH1Un89OsSjLIsDdVn4P7+PzsZpdEum?=
 =?us-ascii?Q?OdUN73rvHlfvSlKyR7s+hdoOvdRT7ocIDLXbGy8K/rDuIpK2uxQXJ1CzWlcL?=
 =?us-ascii?Q?csJP4k3snLNEASMSs5Q2Tz/GayiOIvBqxDWU7NX0bFHXjt/zdGFH3LlM/JwD?=
 =?us-ascii?Q?GMxJnVHDxJNhiuAoydwN3S6aSd/TrnbOZT8Sb+rL8+yuKOyHUmTqDaZYM6Zu?=
 =?us-ascii?Q?wn9rskOUFXA6/ZrnxLJNyuzYvBY2ajjj9N2tQ4caWlle8/mQFhvsUAsdPfPz?=
 =?us-ascii?Q?R+lg68m5qZrjwM4nYRO8VILb2doiE1ALS2yJzKb1mH1OTFdHaeBJxEGrrB72?=
 =?us-ascii?Q?5pWngAuze42muR2NacHTjYI1myzKN3DX1dnsn+NuiAyfh8egJDdNZBcH/rGM?=
 =?us-ascii?Q?ZskvpWLPadeCc0JBS01cKWEsE2riy1jDRoFIeKs9+glgbVECUGXxxaFqrUjC?=
 =?us-ascii?Q?NKUC7F4NMUeIRH4ayA0eKax4Tmf/CigAvPJP1FPKTH0bIm9WAhamtNu2EQt+?=
 =?us-ascii?Q?hIRbfbN3Ai48x/cBeCocy6GHGujNugAlHKC7YpqNtK5PLjHzjwzk2pQTcoWq?=
 =?us-ascii?Q?v2Qh1V2Lh8sPr078fAuerQeAjatJMk2g1Lvl1ZAabTA89GlfTy0k8Whk3X0d?=
 =?us-ascii?Q?WM/eeFLniG6f7E/iFLuZttwoAC8mCyw7ubFDR70haodHLSU+tpHL1NLtH1Iu?=
 =?us-ascii?Q?SLJwCFCFH0IeMECEr9KgzOWnmjw6Mpil32DA17KRz7EKJcKNGxIcX/FyDgEa?=
 =?us-ascii?Q?LSaJIdr5DeLOrlTxEnZ8RJUiQ9s7i/LEYQ3v7iDZMcH0/guh/03Jte6f3oAG?=
 =?us-ascii?Q?PAAtkh6fNteEnx0Qg7FFwboi4FykrCsjJEy5LK0kbN59gu7RZ+No10UUVte9?=
 =?us-ascii?Q?53eQY9Ak6PZRS7u27e9f5UhYlkDBMXEPhgkHAWqzJjzwjRWGPXmyY9wmqt5Y?=
 =?us-ascii?Q?8xm+7CfNJvnK0pBDZOmbrmurcvc5ATI397IUoDJCSLYkQl3UHSt8rZLc6C8W?=
 =?us-ascii?Q?MhAc8kNwrRseUXXy4bi35McUVgfQLWlQ7vind8Km9GhzoxTW+cZN9KG3rCDi?=
 =?us-ascii?Q?PzV1dSy9BwtT8Y7cc3Fmpkzyfq36lf1YRfgr1qnsGVr0yBgYkOtZpBM1R40T?=
 =?us-ascii?Q?azIb6TFKCzIzIogMF8ox+zPwWACC9XJ5oSunREIQM7iTogKKPK4flj6f6471?=
 =?us-ascii?Q?fLuTXeSB+afpB7ii6hiLemnECcGgr3BDAtFJn1bd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oGRkWoRjydqNrctv4+ujz99EDfOAFZhZP41hyrVznXJAH4dISlmkM/50yQiCam8XxCCpizYnOIXRCI8sVt1+ZffmsJ7NriF4oHsxoFWHghhbmJHrwOWFDfNwmuuUoNDCh1y1Av9CJoJ1C0EkjzpfTSq5lm5XlVwP20/oIZj+fwHho6YEMNhHIWhNJfoeJG7bTstri5opbcF37UtDwkAKpuE8gozZJsHSsesMWlcqwKCFrVDFT9QNr5RDBLz7dBDuipx/hb+VGm9gGHqTYf1gn05T53p4FGH8Q1sA16WgejxLuYNbDEafzALTqBQsdjAkHyQ6J+5OBRCC2FAr1vwi4jEu7zTFiJyZw9jopd7TW5P/MVytITn1XfSO2VjX7RPcXkeASeHbFZ1RtYYkUv7PL7yvcDujFGQVEVQXKUExhg63AWNHKIvjBMBc8SwNgehmi8Nq4Se0X4W0IKkdt0AOw91N+NlN/F8Nf84Vl6MMWQmtwqz3Mi9k058tR8NoIL/vUtJITMi2qG0CBoTtha7DJwbV5++TNnBNJ0jAOv9UgR4QSCL2qQdoJOtnKmP131j4f/l+MbqC6dzRANfQwdyCPlBL6IeegRO3EpC/joVhNWE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d6b1d4-8306-4999-26bc-08dddc09c744
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 14:41:11.3817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Os5YaKapoA8No8Hps57e29pcrZzxpHHiQGibzDW/z8jTNRdweE6GpcGJX/As89IfcSjxcrnWmG9If6BwaP1GZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508150121
X-Proofpoint-GUID: Ylq_ZkvwpAx8EKW9FOu8hjixAzQsGHmI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDEyMiBTYWx0ZWRfXzJspC/bX6ndQ
 gshL558rSKsaz0kAIsKvO1o4i7Xx1xs52tsZybcveKgWe5lxUUmuDCdsWbNlFjg8ZzMZLwia8Gg
 nuZOnvmtYWC4cW2zDJ2bxbV4IzShzfZqXDCVr7DSmCvmyNvMixiDZgpE9lA5n2wmXShXBtKGEys
 23ammQtk0afxTVdArPfsEuvioC1GBl4IiDYRtKjKK67Q4ZCBLMjS/Mq7wEa6AvDs1Pm/HeqvEDt
 W5fMtPD/no6VVCpF5qVe4k5LzYj7A0igM7t5VSMDQMGtNFUr+X7X8JnFLjL+TPou/k+Wmw9de1Z
 voDzjxzOQpuEzSyuMR7+GUFwluuK+KwZyNCYojamI+LiKL2lyPO2apAxXx6x6YsUd6XKSTYVpbx
 g0Ch4QLxNcHAjBlY6dF3k2H55neYpu2FFfbmpk51UvAVuE0BDZ8saXkX8UpA+hvZPv8dnyk5
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=689f4712 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=CvlTB2HrAAAA:8 a=QeEF-Z0EElGHHH1IXSEA:9
 a=CjuIK1q_8ugA:10 a=67QrwF-mucXG56UA-v15:22
X-Proofpoint-ORIG-GUID: Ylq_ZkvwpAx8EKW9FOu8hjixAzQsGHmI

* zhongjinji@honor.com <zhongjinji@honor.com> [250814 09:56]:
> From: zhongjinji <zhongjinji@honor.com>
> 
> When a process is OOM killed, if the OOM reaper and the thread running
> exit_mmap() execute at the same time, both will traverse the vma's maple
> tree along the same path. They may easily unmap the same vma, causing them
> to compete for the pte spinlock. This increases unnecessary load, causing
> the execution time of the OOM reaper and the thread running exit_mmap() to
> increase.
> 
> When a process exits, exit_mmap() traverses the vma's maple tree from low to high
> address. To reduce the chance of unmapping the same vma simultaneously,
> the OOM reaper should traverse vma's tree from high to low address. This reduces
> lock contention when unmapping the same vma.
> 
> Signed-off-by: zhongjinji <zhongjinji@honor.com>
> ---
>  include/linux/mm.h | 3 +++
>  mm/oom_kill.c      | 9 +++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0c44bb8ce544..b665ea3c30eb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -923,6 +923,9 @@ static inline void vma_iter_set(struct vma_iterator *vmi, unsigned long addr)
>  #define for_each_vma_range(__vmi, __vma, __end)				\
>  	while (((__vma) = vma_find(&(__vmi), (__end))) != NULL)
>  
> +#define for_each_vma_reverse(__vmi, __vma)					\
> +	while (((__vma) = vma_prev(&(__vmi))) != NULL)
> +

This does not do what you think it does, nor does it do what others
will think it will do.  It's not the opposite of the
for_each_vma_range() above.

vma_find() calls mas_find() which has a different meaning that
mas_next().  mas_find()'s behaviour is a hold-over from the vma_find()
of yesteryears: it will find the first entry at the address (if it's the
first time called) or the entry after it.

mas_prev() is trying to replace the linked list behaviour of "go to the
previous one", so it'll walk to the index you specified and go to the
previous one.  It will skip the index you passed in regardless of its
existence or not.

So what you have here is a broken interface, you just don't see it with
your code because you don't happen to have a mapping at ULONG_MAX.

This should not be merged as-is.

Also, there was zero mention of the new interface in the subject so I
almost missed this being added.

>  #ifdef CONFIG_SHMEM
>  /*
>   * The vma_is_shmem is not inline because it is used only by slow
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 7ae4001e47c1..602d6836098a 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -517,7 +517,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
>  {
>  	struct vm_area_struct *vma;
>  	bool ret = true;
> -	VMA_ITERATOR(vmi, mm, 0);
> +	VMA_ITERATOR(vmi, mm, ULONG_MAX);
>  
>  	/*
>  	 * Tell all users of get_user/copy_from_user etc... that the content
> @@ -527,7 +527,12 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
>  	 */
>  	set_bit(MMF_UNSTABLE, &mm->flags);
>  
> -	for_each_vma(vmi, vma) {
> +	/*
> +	 * When two tasks unmap the same vma at the same time, they may contend for the
> +	 * pte spinlock. To avoid traversing the same vma as exit_mmap unmap, traverse
> +	 * the vma maple tree in reverse order.
> +	 */
> +	for_each_vma_reverse(vmi, vma) {

How is this possible?  Both need the same lock..?  What part of
exit_mmap() will race here?

Why aren't we using the MMF_UNSTABLE flag set above to avoid it?  Or the
MMF_OOM_SKIP?

>  		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
>  			continue;
>  
> -- 
> 2.17.1
> 

