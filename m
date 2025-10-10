Return-Path: <linux-kernel+bounces-848524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F2FBCDF56
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 80F04356512
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763CB2FC013;
	Fri, 10 Oct 2025 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="D6GmpIw1";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="D6GmpIw1"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011039.outbound.protection.outlook.com [52.101.70.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C192FBE1B
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.39
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760113582; cv=fail; b=oqkX8Q77rWSt3385fTWtDf2LU1tjAmOgn43N+GrTO8wb8N/PurSofm2apZlwT/4RhEZUTGFrpFjue5DGzCiY/jWa3lbb7WTZpjj978dJ95zgYXxujnUIdYJ/H9CrGY6SlSBV/KKdBrmXpF5ei04i0rTinsN0zoLGOMkQPAymX/k=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760113582; c=relaxed/simple;
	bh=p4yvplakgr8hgwBUOnaAxExK89cInLMLrrr5QBoUcyc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PPdo/5Ce89mFkE2K8obsJ7Tc9m+jKrRs2USPhoPaqj4uR6IF01p5Jeaq60fcOrJD4U+PTraKEhe/PoKcUlAHGiRcfcvLJ6Mzr+y/UyZ3LsCw8fUcceA6JkdsPwy9WKGvq2U1tafCm2wuL/304zzIauIFGa3YKC9FqkScL6183QE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=D6GmpIw1; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=D6GmpIw1; arc=fail smtp.client-ip=52.101.70.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=g0B7lAhRSEJKrOVsL/eAItjpJgt5BW5EXcMDUdDZFLnA01LAw7OY+zfwZ5oetlzqYho5M3E5+BGb/kxCP+7T0rYit7Zww6b7xmnkvumR//8L4pIOFUMKToNgHc4YG7dsFpUTKbtrtpZ3DhGX3Y2eXlMJIDQCgTbwhlgzXSmDKscn7mohQe/M1Ep8O5Ojc6lwCWyl+h4/X6Jg1yQ6duhzrtbngmtOzH4QQfXDYa/uN/fFpqRdtWjcRgU/TXY1CQFA4L6SaRj/E6UlumTq98vgElKu5uMo8lFFjXGCzh1/SSGrxkieUW0mOtzNXWH7R5KjH5vRkC5Hgjl4MO5o9jnl9g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gx0pqA/JGafk0WimBfKa1q2JqRtbMgOaY1HjBl8PrVU=;
 b=nz6VK54Aq89xf6HGAnMb7YCSBk+rjDyu9ckIUf7NTiJbyh0uP6/t+EQtnWtbTnwdKeffwfqBGY1HVyZAbZhDqn/gVGhBTzk6EwmxsSlgR2YLf4Iny5Sh+qBbPLQQj3NCsw5dmdCvtYuHtG7bxfys3OrPHp42B2vANCPgRLca9531XeYiI9pigJWRElWdjWR9MVpiJop05e+D1SJxLUhAcz84NB8lLYil9hJOWFoiRXlUqBmy9F0tuwEo/x4xV9tbpB5TXVwhQRZuA96qk308k+1pxtQWsHRdijMaUJarUeQkrpIrWCZULDx7bZ+QEeuT9vdSKusoVAmrpULv86BDpA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=redhat.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gx0pqA/JGafk0WimBfKa1q2JqRtbMgOaY1HjBl8PrVU=;
 b=D6GmpIw133yfDhc5rw38lkCBnY8leS4clfXGciZ9w1LYgmpbFZaLb626/wRfOXKL6Rfty8z7Hew3htPSS170OEriz63DGrVhqHmzLka3DLNwX8C3P7KGzidMQea6vyVND5AA5fX0GDQfn5qnNjRDs+WCGFRhQU+68c7UaELS8Ac=
Received: from DU2PR04CA0027.eurprd04.prod.outlook.com (2603:10a6:10:3b::32)
 by AS2PR08MB9318.eurprd08.prod.outlook.com (2603:10a6:20b:59a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 16:26:13 +0000
Received: from DB1PEPF00039234.eurprd03.prod.outlook.com
 (2603:10a6:10:3b:cafe::4f) by DU2PR04CA0027.outlook.office365.com
 (2603:10a6:10:3b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 16:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF00039234.mail.protection.outlook.com (10.167.8.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15
 via Frontend Transport; Fri, 10 Oct 2025 16:26:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0bC0l30lLGLCAXEHzQOMeyVtq74uESVFWRQqmWMTKkFSZUds82bw2n9oaoOC2EgV06dLDBrYThpFKNJ3dmSZYKa8GfvoNYZWkX87gw8TkgY/y3aU0tfv//Emfb3bM1N+huR0iY4Mkk/9LSr6uLvc07Vz0826zos+TyH8KUHO4rwfdT7k+l72aK8E/osvGixDYuGPx1TQO1E8tIu6FNKvgbSPHmNl1Jh0Uawz+bTc/x5qUao4OMfYkmDeiX7nWI0vQtgvFrPljnnA/xqwqDmIdXTu9bLQuptvnblBRJT6YuYkiiO625tJL9evqCLIyZHuH43jFogbPEf9pq7OyxNPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gx0pqA/JGafk0WimBfKa1q2JqRtbMgOaY1HjBl8PrVU=;
 b=NkUXYYnCJjrCHuots+RY95VTSiYmoz1l0cpd1D3vVrXBCsGG5QCc5Hpj1n0ar+j89EpLEU5+vogj1VEBIaDXfBvZ9KH4iityXCf/Chsu37B1LN1gY8Lz93KsOCxGun1fSgm2/x9/FfmmD16OqhftZanzDpAi5YUnEokmLIp0UvsJ7aTnrDkBECpsvOFxPeLLPs/7hzdUMHJlXYL334PYxkc2IaHWfsroH0dkmkerp0PWQQj9co2p86RdCl1WjTeXQ2VDJQbGj60psbK6dRvi82CJPlMBbebkWOKBgfj66kjE4ZUbZhBm65jwvYu7sRc+kdso8S4DJaEcGZsOdo2cRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gx0pqA/JGafk0WimBfKa1q2JqRtbMgOaY1HjBl8PrVU=;
 b=D6GmpIw133yfDhc5rw38lkCBnY8leS4clfXGciZ9w1LYgmpbFZaLb626/wRfOXKL6Rfty8z7Hew3htPSS170OEriz63DGrVhqHmzLka3DLNwX8C3P7KGzidMQea6vyVND5AA5fX0GDQfn5qnNjRDs+WCGFRhQU+68c7UaELS8Ac=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by PAVPR08MB8896.eurprd08.prod.outlook.com (2603:10a6:102:324::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 16:25:39 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::4ce3:fe44:41cb:c70]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::4ce3:fe44:41cb:c70%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 16:25:39 +0000
Message-ID: <3408aca5-e6c9-434a-9950-82e9147fcbba@arm.com>
Date: Fri, 10 Oct 2025 18:25:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/deadline: Derive root domain from active cpu in
 task's cpus_ptr
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Pingfan Liu <piliu@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20250929133602.32462-1-piliu@redhat.com>
 <20250929135347.GH3289052@noisy.programming.kicks-ass.net>
 <CAF+s44Q4SDXPRfYc4Ms5TcJgRU07QJB5H5VOHvyrZ31x9z49nw@mail.gmail.com>
 <aNuEpt8IkvtkH9na@jlelli-thinkpadt14gen4.remote.csb>
 <20250930090441.GJ4067720@noisy.programming.kicks-ass.net>
 <45e40d5e-f0b9-4c77-af1e-6ac915518acc@arm.com>
 <aOOyF3EvIG5HKEel@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <aOOyF3EvIG5HKEel@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0008.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::13) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|PAVPR08MB8896:EE_|DB1PEPF00039234:EE_|AS2PR08MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b0fa6c-ad86-4915-fe81-08de0819b9f1
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?T1E4S3JmTm9oVlpZQU1aeHhvUlQrU2hwZFE3WUhETXowWUF2aDQ3VFZ1TFlz?=
 =?utf-8?B?cU5nT1I4TWRORWJ1RENMcU13TDBuZEhoMEpQZDdrcG5JMFA4MTF5bklldlRE?=
 =?utf-8?B?SkxJeVJVN1NDb3lDSnhXRytaUXhxVmVaVkJRQ0tlWGZGWkJveWFkc0loVzY0?=
 =?utf-8?B?TjdNSzdvb1IrejJXVml0d3dENmtSazN3N09pU3ZuNExLUGtuYVZkWExhRkdj?=
 =?utf-8?B?NXNEZ0Rubi9yOWNmNERWUHRVblR3RlZYK3luUnNRTWlSb0ViYWhDUHhpbFVM?=
 =?utf-8?B?U1ZicVpOcmZhcEtEQkNSdW1FcUFCVG5Pb2JtQ2UyMUJ3MStMZlZkdldSTTY1?=
 =?utf-8?B?am9KQWdybkk5OStaWmpYMDJSeXFOZk5BWVNnTDFmK0MrMnhJMU9PSTJPRUo3?=
 =?utf-8?B?ems4NmVDNEZ4aktJdkd2NllZQ1hiTnJZS1BpUHpFZ1VWMnVESCtJcHNFYWR4?=
 =?utf-8?B?SnpZamJYZW9HKzJZdFpQeWxraEtjbDNnZW5FTTJaeEJBT0xPU01PQ2xoeDk3?=
 =?utf-8?B?RzNYSnJPeWtDc0JmMkpJdllHalluVU1jdVV5NjhTYlJUMGwrcDNSUCs2elBx?=
 =?utf-8?B?Yk5ZUG9IU2ppcHBObEFPd1lheldvaVVqc0FZR2JBYTZvS051aWNYQWFLWkdS?=
 =?utf-8?B?STFwd3BPcFBSTktUZUFWVXJoL1lTQUxiTml6NzRBeXhGazZzRlFjbDUwaXBS?=
 =?utf-8?B?WUQ0Skd5RFBaRm9yOVU2S3J4M2dOdDVweWt4bGcwcXlUU0pXMG9mWGpFa1ZB?=
 =?utf-8?B?Y2VJRzV6OUVRaFJ2YmhzQmRSTmF5cUs3bitna0dBYk9GalJ2N2Jpb0Vpc20w?=
 =?utf-8?B?dzdmSTVvWFE4N3NsakRRNWtYT0locVN2U1FtZFFXM0x1V3RHK1RqVXE2UEJO?=
 =?utf-8?B?S2tOMVZmcEJmelByb1NHYmp6cVNmV2cvVzhRbm83eE14dk9FeWR4SXFLZjdW?=
 =?utf-8?B?ZXd5ZkYraFFXbTlXRFpZbndCaGo0RmFISmdZV3FOT2ZoaldTdkI5T2R5Smps?=
 =?utf-8?B?d291Y3UvTkRGMDNzUFZYaG9qQ1hlVWVRaXU5cVZSMmcvdVFIVHVEYVZRTHVD?=
 =?utf-8?B?bWt1ZEk5MFp4MFRrRHBVVThqWkJvWVVNcXZNSndUUzM5UXRCdUJRSllYUUZG?=
 =?utf-8?B?T1ZWMmgyalpYUTU0MW1NZVRrQkltdkwrakMwdlJxSXhBemVmRDhzVGpHaHZD?=
 =?utf-8?B?Y1Myc1JnNXJIRUpKWGNUdHQ4dmJSU2VxVjNETkhsQVU5czN6NCswdlFYYndT?=
 =?utf-8?B?TFp1a1hOLzVEcThWajFEdGhYbjJGTk9kdnNzL01kdzVIQmtUT3hmUFhkMUxW?=
 =?utf-8?B?TEFzU0JNMmRjelVodkZWeVBFd3hZWG5PQXUwTHVjRVMxNGdwS2pQaTlCbXlS?=
 =?utf-8?B?RzhvaUUwNVlwUEFrTUtjQm5RS3ZKYWF0WGNxb2FEK3RRRGV3a0dCQ3Q4alhI?=
 =?utf-8?B?OFRHa2taZnZ2SjdNK1pzSFJlOFE4b2h2QjJzLytqUGk3ODkrck1HUnNmSUpJ?=
 =?utf-8?B?dHBLdlJZdG9mb1k2Q25TcVhFM3JaSkd3NWNvaUp2SmU1MHlSTm9JVHdGUmJy?=
 =?utf-8?B?ekxCcjcyM0xsdkV0b2NiSTdnWjNkSEV5Z0RaaFNMMmdvaUFOR2VsWnJ5ejRY?=
 =?utf-8?B?REk0Sk9xOEcxSEo0UkxWRE55dFhjd2xnV2lTejl4S011Z1J6dm1kM3BSdkhB?=
 =?utf-8?B?UWFOSDBYejVld2tWZ2cwQUhHZGYxbDMxaVBTTEJQR2dyR2tZSG5pK3VxcVdh?=
 =?utf-8?B?VmFQQUVFcjBMM3ZpSDRyOU5DY2xoRVdYb3dUS29HelU5YUZxcGU5NGVsdlpB?=
 =?utf-8?B?S29oNEpraUJxd0xjdzVOaG5oSitEeEpPRUxoYTdSanRrdlJ5c1A1RDNXLy9D?=
 =?utf-8?B?TVZCaDNCQzMwZWRIdE1zcW1xTmRieGdtK2lDVjhxVDEra3N2ZzdGWkhtam1w?=
 =?utf-8?Q?9VpI6tj5I1I=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8896
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039234.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e124f484-8afb-4f7b-ae72-08de0819a650
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|376014|7416014|82310400026|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RklzM3BOWDhmRGhJYkg0TFdGbCtHSHJCOHRnZHJ2M25MNCs0OHE0VEFXYTVT?=
 =?utf-8?B?Mm5PWmw4S01OS3l0ZjRuMFRXRzl4V2owSmJwMlV5NkJvTTkxenBZNkhSWTQz?=
 =?utf-8?B?clA1OTZVNWttak9GU3MyNU5hM21Rb1dMTHFrWHd4WG4rWkhSd1Y2STMxRnlH?=
 =?utf-8?B?Qlk0ejJvcHgrUjh2bVdhOXFLU1FVNVdtTVRoSTRkRW1NNUJWU2NTcDg5b0lO?=
 =?utf-8?B?QjY0dG9EZkloTWZWRXZ1ZWpXdUlzMHlaUzZkSlhteWZBeEdiUnlVd2VhWURa?=
 =?utf-8?B?QXBKbUpaRldRL0RiekovNXFWVGNqbDFZdGNoYmY0M3lvRmxIb3F2WTlQeHJY?=
 =?utf-8?B?UnE0UUIxUlNQTkRWTnc5ZnBseGZkSjRUdGlUQmVLanlXTnJ4QTVUWStMV3hS?=
 =?utf-8?B?eFRIRm5LN1pxYlh6QWxVamQ5OGEzdi95QTQ3UEEvclpvUTRvY0tsbmREbzRB?=
 =?utf-8?B?L1JkaXZOWVF4anZaWVpaSDNSQndUdUN5N0p3ZE4zdkV0a010NVRuOFhNRG5w?=
 =?utf-8?B?V3UwQWtTZzEreUZyc3Yzd0FpWm1pWWxoN3lwK2J3UmMvdUdLUk5YSTZOdHE4?=
 =?utf-8?B?SzFHbFliK0xpdS9NMlYvZUF2WEdjT3lkRURramVYb2VPRStSN2FGc2Z4MGFH?=
 =?utf-8?B?bktvK2UyUytwT3hjU214SDI2TzRwN3lhb0RBYnJiWG92YkhTdkhpR0ZXdE1G?=
 =?utf-8?B?d0YxMWNxVUtubmNTSjNFNGthTysrTHU4b0hsNCtCTEpxMGxIYzZIdkVXRStL?=
 =?utf-8?B?cVp1MXZKOTM3aWllSE4zVVVEVUx6Wkw0a1B6MThlSU9rckRGaXpKZHhUc0dq?=
 =?utf-8?B?bElzdzRUT2NsbXoxZk9LcnFYcEFLMUFURS8xTjN5Z2ZNRlJTWnpaaitWaHJw?=
 =?utf-8?B?Rm9uckFvQ0dmNlFUcExZR2llUVFBRUNoNURIbVJhNGdIOVU2T3F0RG5mckFN?=
 =?utf-8?B?ejNkQmhuNFBPWnA4VDFCYXdQSGh1QWhoSjdKTlVtUU5BYUVTQ21JeUhsc1dj?=
 =?utf-8?B?MDhNMDdWODVhaVp4TzVDZSttMVdNZjBkWlhQeHlVTTZiR2xwMDJiTDYyTWNW?=
 =?utf-8?B?cVJHWDlkeXV3TXBHTFJ3RlNHblozTkJzRWhhVTJtTWxtWlRTUTM1RmkxMjRT?=
 =?utf-8?B?TkNTS3hQdjdLcUUzUjR6aDcyRUJRRlorWjBUSXhic3N0WTVYYldZYkd4NExs?=
 =?utf-8?B?OUhRUGRpdjJJSDBsNUNWRjQydGRhVkJSNThGR29yTWVFUmNUUjVhWHUrQUwv?=
 =?utf-8?B?ZDhieVBMUi9JYi9jYlV5eHRha0s3MXdub3hsOFRWc0V6cG42QVlhYnd1NEtk?=
 =?utf-8?B?SnVsVURGRFlXZjdpMVUvb25PUzRLdDRRY2tycmx0UDZqSmdaallIcVEvUjRN?=
 =?utf-8?B?L1AwL3YxY1BSNjdhVVBIYWEra1dUd0Z5M1BqNGlKUUJaazlmSWlUOHp3cm1q?=
 =?utf-8?B?U3NXNDZaTkRkZ2s2NU8vaHFnTWJ5RVVTL2o1M1J2U1RMM3ZhY09mQUpYaXZ6?=
 =?utf-8?B?RlBGU2hOWHlxZjRmbi8yZXNDbXJLbkRIQ2wwbWs2cXAvc2RtQ2g1OUE3cUk1?=
 =?utf-8?B?QTZlMHBVNmhYOGhSVUVvSzlhUjVHc1c5NThXY0h1cGlkNlFRdFlFa1MvTHBx?=
 =?utf-8?B?UU1XR0tmaC94RFlDREErclhTa09ST1d1T2c3bGhxS1hDSEJNaGxQeGNtUktv?=
 =?utf-8?B?Y1lITXFBSjA4VkdYbTl1cFpXU0I4cEl4RDdmajd2cWExNTRkcVFzaTJSN2lp?=
 =?utf-8?B?eGJ3SHIreEhvdVRLOHpTaVhFUVA3dHZCa3JoQU43MzlPWjZ3NFdTd0gwemRS?=
 =?utf-8?B?WnJNZ0JwQTgxTVFMS21rb1o4eVJsMFBLNGRpRkZRcmoybmRmaDRSaDhaSTdj?=
 =?utf-8?B?RUZ1SkI5S1FiTmF1MEZGc3F4a3h1ZXZVQ1RCbktYc0RvK3hGN2NZaEJiY3hv?=
 =?utf-8?B?RDlJcTlJWXM4aWtkVkF4eU5UbGVnQ0NxNXowYUsyQTJuRjQvdHFZdXZYT2VS?=
 =?utf-8?B?SGpmZXZ4K2VWWE9lZUtZelV0SEI0Y0FJVTdIOGh0dVVDS2dPVEdjQ2N0S2xJ?=
 =?utf-8?Q?jLyh0w?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(376014)(7416014)(82310400026)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 16:26:11.9057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b0fa6c-ad86-4915-fe81-08de0819b9f1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039234.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9318


On 10/6/25 14:12, Juri Lelli wrote:
> On 06/10/25 12:13, Pierre Gondois wrote:
>> On 9/30/25 11:04, Peter Zijlstra wrote:
>>> On Tue, Sep 30, 2025 at 08:20:06AM +0100, Juri Lelli wrote:
>>>
>>>> I actually wonder if we shouldn't make cppc_fie a "special" DEADLINE
>>>> tasks (like schedutil [1]). IIUC that is how it is thought to behave
>>>> already [2], but, since it's missing the SCHED_FLAG_SUGOV flag(/hack),
>>>> it is not "transparent" from a bandwidth tracking point of view.
>>>>
>>>> 1 -https://elixir.bootlin.com/linux/v6.17/source/kernel/sched/cpufreq_schedutil.c#L661
>>>> 2 -https://elixir.bootlin.com/linux/v6.17/source/drivers/cpufreq/cppc_cpufreq.c#L198
>>> Right, I remember that hack. Bit sad its spreading, but this CPPC thing
>>> is very much like the schedutil one, so might as well do that I suppose.
>> IIUC, the sugov thread was switched to deadline to allow frequency updates
>> when deadline tasks start to run. I.e. there should be no point updating the
>> freq. after the deadline task finished running, cf [1] and [2]
>>
>> The CPPC FIE worker should not require to run that quickly as it seems to be
>> more like a freq. maintenance work (the call comes from the sched tick)
>>
>> sched_tick()
>> \-arch_scale_freq_tick() / topology_scale_freq_tick()
>>    \-set_freq_scale() / cppc_scale_freq_tick()
>>      \-irq_work_queue()
> OK, but how much bandwidth is enough for it (on different platforms)?
> Also, I am not sure the worker follows cpusets/root domain changes.
>
>
To share some additional information, I could to reproduce the issue by
creating as many deadline tasks with a huge bandwidth that the platform
allows it:
chrt -d -T 1000000 -P 1000000 0 yes > /dev/null &

Then kexec to another kernel. The available bandwidth of the root domain
gradually decreases with the number of CPUs unplugged.
At some point, there is not enough bandwidth and an overflow is detected.
(Same call stack as in the original message).

So I'm not sure this is really related to the cppc_fie thread.
I think it's more related to checking the available bandwidth in a context
which is not appropriate. The deadline bandwidth might lack when the 
platform
is reset, but this should not be that important.

---

Question:
Since the cppc_fie worker doesn't have the SCHED_FLAG_SUGOV flag,
is this comment actually correct ?
/*
  * Fake (unused) bandwidth; workaround to "fix"
  * priority inheritance.
  */

---

On a non-deadline related topic, the CPPC drivers creates a cppc_fie 
worker in
case the CPPC counters to estimate the current frequency are in PCC 
channels.
Accessing these channels requires to go through sleeping sections,
that's why a worker is used.

However, CPPC counters might be accessed through FFH, which doesn't go 
through
sleeping sections. In such case, the cppc_fie worker is never used and never
removed, so it would be nice to remote it.

