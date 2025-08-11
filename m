Return-Path: <linux-kernel+bounces-762811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3655CB20B22
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5404A3A5E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E45722FAF4;
	Mon, 11 Aug 2025 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cJLfi1s2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f1FW+MZO"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EDA2E265D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920617; cv=fail; b=YGRjE95bAuiDkdZQrasBkVSnyZ7FXZMQ9KLuAFVxt/fSlJu+G68xImZWPdkH4Q1eW1RbDbqR3KGah5C+3E6OKjY711H8ZtWLKvTixJmtX3lPZ6Y0o4qBwCJ1BwjKGsDSWoFm8/vSiw+dtf4chLd5+UxQDBu4UcSMREBPqB4URq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920617; c=relaxed/simple;
	bh=5Hwp1kk6Qh90GY1BFIPEs42xM7Ut/CCBwWio/F+6HkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U4AejRV4ieOojVvz+KjsdUIN8xVKDQtG2SwmyW3Ea3vJ3Mx4S7Tpta4JjO11jRoWku0myGenr7O0bpVMxQQEAXgooseRDj2BcM7XUcfStSq3iawkkznP+NGsqjkqArRfl07jk46pKDN/VvfhkOE4ozspmGP9jGgwshlDJS2R3Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cJLfi1s2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f1FW+MZO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BDMuJR014035;
	Mon, 11 Aug 2025 13:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PsOCLycuvAwPtGQj18
	PvIBrFIb7kogLZfeE6/hdLnOU=; b=cJLfi1s27r3mC+xL13xlO9H5Wmo2P4oXls
	8Zj3HbIwaTG6yTV467GD7VLkA0vPv8qZcwqEYhVCHdbt0+V9khxpePzlLCR/yI+5
	cENkn0Z5YUWzhhIQDTHgcC45laUktdzX3yrlgU58bf3sXYvM2oRP8PJDYPGAEJTj
	FM7ZpUA0DAlAN81uAjSXJnLwz9zLd+nMz+MXO9XAmAoNacnnEqcRNrYGA8ZvKTMt
	/FPd+Pv79trLBza26IqfTWoaZ5bONPMYMyWlPr21AiMIXeTymJ5dfnQwwyexzjcd
	iFrNh3fCQSd1cASe05pD64jWR1j0+dMURoIre2ZkbAtpSZP64iAQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dx7djjt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 13:56:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57BC60eg009846;
	Mon, 11 Aug 2025 13:56:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsexvfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 13:56:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ea/hYr1pFkj3EpBwnbbbynCKitIO8q55zMAVNyR07XiBMizBCVdpF57iK2XsR6aY+GKDiEc/T4goWjthtu+QUNffykf1e0VAGEWpEOgqmsG3OdOWUHqoFU8J+lFnBITRqc9mcmLuYy0097OaDEljB9c5mRrQeUxLTBlmHrh3ZcQfBpA1tYfx5ZWkhlj5WmgTPvXloErpBOclNZN8oo8+IN+cbBP1we9OpmVgtK2OMOnYqVB0QAxVpSyiFIiJns7WLSlo/7nhwKq/rchY3kXzSXZl696AkNP/FYA/rhOWSDFk+R58gu9sbUoAWIPiDKjcGqkvSAHiaxodfuRsRbRcUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsOCLycuvAwPtGQj18PvIBrFIb7kogLZfeE6/hdLnOU=;
 b=BKs65anJArzC83NlBdl3pgxzgoSI59CZXVXXDzm0+xh2ifbMrlfoE4mb11n5uDr7iTGOVB73rngccqYT6F4oEKQpB+ZaomupGns04i7spj+RM0TegKarzFFjYFKs6DrHo6LkHJXJgGXS8VZ+KPyIhv+pYNTT2bAGgtmE8HMs0hPciJXI498tOtGstAWW1tuf5V1hByOEedlLcg945DGJkvKhlfQ0e1xlFKhVSZDddHTkNSkuQ7E4yAtkoIyVW1wX2fcJ9gFED+JbKrDu8y/17YCtd735dmSc2W2hXBEY28lpbvZf1g9cEn6lm8gTXHO6ViiHzYMri/bC6oz++IVNxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsOCLycuvAwPtGQj18PvIBrFIb7kogLZfeE6/hdLnOU=;
 b=f1FW+MZOmXBKW4EKaPLha8JxSdzNpjmRujnSrddf1gXk6zDQQ8r0tIK/7kcOyVe60miYvcYI/1rFPbWSyVVcZ83oQheeB+K+PQn2esGpmgygN8xzY2VYtUxpIXLuWHVEd+9K1mHtd9QXMFJzWMGA1Q9nzZkAjEwl9OOPDNmDB7k=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPFCAF322559.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7cc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 13:56:34 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 13:56:32 +0000
Date: Mon, 11 Aug 2025 14:56:26 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kees Cook <kees@kernel.org>
Subject: Re: [patch V2 RESEND 5/6] perf/core: Split the ringbuffer mmap() and
 allocation code out
Message-ID: <bbf55749-3fba-47b6-8151-39e66fec8950@lucifer.local>
References: <20250811123458.050061356@linutronix.de>
 <20250811123609.729827000@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811123609.729827000@linutronix.de>
X-ClientProxiedBy: MM0P280CA0053.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::32) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPFCAF322559:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af989fe-633e-45ab-56b1-08ddd8dee091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vd3cYA5UC2SZE0Pp5Gag78jGRhQ/6XME2hVqg5nmTazlshDFLkIUz/I9f7L8?=
 =?us-ascii?Q?qN41/7TJ6Z62yDUo7Ov+9f8LXhC2K1lCR6RpVcqNsxuau8K+L+Ga6mTG7irE?=
 =?us-ascii?Q?zUp1qTcUu3unexVgIVXkaKp4wvPSCszrF3YWf24mqb8YZPKo+nwmntXgTz3b?=
 =?us-ascii?Q?eMzIrcSv77nEEBO7j6a4hytYW/fl4SCwWGtO5IkhTShFF9TmImRjAs0Q+w/O?=
 =?us-ascii?Q?7UkQ5kZTUOLmGjJACUYl9kCKNjsYFHvgRi5LOix8ybFR4QswwpYtvdiyZyjj?=
 =?us-ascii?Q?5Eqaf8Kpy55/bXgXYHgqMYUt2lbD6bKphnsgd5a75BeJgVw7Li5iOQiSqcCX?=
 =?us-ascii?Q?ymUP0m7Rum4wKvKnmouRO1aG4AvjMdTJ7OeEOqFeV13b39cQJUNjn3PjsQ9c?=
 =?us-ascii?Q?g6J5qvg8RUhZAuAumbvTYltoseK+mEdtx3Kg142X59pxatDrQ38qWlzYT42W?=
 =?us-ascii?Q?IQ4evTJQYGQuQ3K+RG1fQ9fYrphRjLOvc9H6ZEcB3mZsJGNfE0USPp4Qixo6?=
 =?us-ascii?Q?smQdY4OOG2cEmufDd0RZMAgSi4dgoFF47klPg70KiB7Cgqn0ydU+eph4iOwi?=
 =?us-ascii?Q?RrkinB7tFNR7xOc/g0M9A/+ZnmVdYyTKzXXdDqCFoIroorDD/fPyXQaziXfV?=
 =?us-ascii?Q?nKx2OFvn2OJl4aRGPeGzru/8Ee3o/t/a2l/29xbyyR54XKscoiLBwwGSPC4i?=
 =?us-ascii?Q?x0T77aGU1sBmv3VLuKKbZmo/YcsMgSDUHOg3JAuYJDli+K5bYaHD4vwfVmPp?=
 =?us-ascii?Q?7BZsaUjjMr52LNuY3UbkpBH+g+wwZURyXHJbT2vsQygiubzFgr6FbVTKCdPV?=
 =?us-ascii?Q?js8N9t4xgTfp3HAe4n85WVoJc9cx6+hzEEUdWpAQ7OT/bAludtx9pPIHNq7P?=
 =?us-ascii?Q?1/LV1fZ65bkkL+igneBVmzUL1VQvt9DCcWY38xCHcrKId73gSyVXCc5b6ikH?=
 =?us-ascii?Q?eJwUiyVlEqoYAqS02bDwkW3iMaR9ME7YgVBmz1CuFo5e1JbDP0EW2gPIEzxC?=
 =?us-ascii?Q?amClsaVC/op2ZBDHFuG2lKC9TdS2hXrS30V/1ucGJ5CyEieF8npG57MpEAJ9?=
 =?us-ascii?Q?/j76iF7Sn9GXckNtjLFhQ8hioqrbueeR32/P2Y/P1NSVJmn0iVMqesmOVQqI?=
 =?us-ascii?Q?CKhdmiy29G0e1Nv2pW4ySJA7JAH1ji8fFcqy1KCuS2dEn+pGdvUp26QYXRJn?=
 =?us-ascii?Q?42/+w3Wuo5NFzhzqDZViycTh0RX0+ppa/K7pWDynEXMdOV/MUFFg4u5Z5/gh?=
 =?us-ascii?Q?yz80i3TNP5ibIM+OHDKaE2ELFuFzpa33bBLPxpuQmy5e2cNNhf4JCmScJCda?=
 =?us-ascii?Q?i8k2t/5W6DIPgNPII54GxFkTGRjeS56LHja3iIzFXb+4WYJxl2c1NHNQ+WoV?=
 =?us-ascii?Q?hC8YTBBDBCDrzymp/oeMxPadOXGp0tBtCn/RrVOhg0CIt9lrwQw+7NFyE8OX?=
 =?us-ascii?Q?j+MPixtCKnc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zIQK0KNjt/7CEpBbl0rSz2qSq9xGDceFEEIWQpOM5lr7PhS/BXS7LFB1yNSb?=
 =?us-ascii?Q?u3l71xoaSgW8RE2lQFKT6DT9yOWpkTl28+IEH9bxVJIFEkAHGeQacANfaMBw?=
 =?us-ascii?Q?i2EQ02zhVEBXObqXQSEtgo0Gb3hxE41YJoYPMqbOM6BalrFBidrR97QUjCIp?=
 =?us-ascii?Q?t0MW5kZlRpVmK8n9IdQSJMUL8UyIcExuT3UEqohpYb5YyobzvZfziV+qLkE0?=
 =?us-ascii?Q?Ce9VGRF7/3bvwLwpT617HHzftsLhpCZQrTOjzIPpamkIzaB7vl5wACu6INNF?=
 =?us-ascii?Q?hIPwavey7ycVqtqpW85Br879GHKbEl/OllGzMISnEcRpEkYIbcPOZvsETH/J?=
 =?us-ascii?Q?95CGy9A6s+PuJUNjTqiPKdf3h8+Om3TRQUHYtO1W/TNEF5voqcZgoE/+wIDI?=
 =?us-ascii?Q?GIsIhL4+VqgVCw0M4+PIhBc3eyLrP5nh3zpgbLJBGXed/z9ON7M+ooyi1frv?=
 =?us-ascii?Q?QxvtGAuy0CsnFJj9Z0ec59sUWnpZ1cy3xGQLwz67WSm0zoWG8ucR25j4qqWi?=
 =?us-ascii?Q?tRA0i+vPQA4dVBU4SAz/bTnZu0GJHcxUbz6eiWgVP0CK4ybhp0cuYVzv5KH+?=
 =?us-ascii?Q?LToSh2604REPha9dFrx5CbAGedKOFy0GgCOE3/kLibdScyitMcgvE47zBjfU?=
 =?us-ascii?Q?o876Ww/52Kjo8BYIOqfsOmzufkMtyTT6NVVWbwtwHcEYP59yEe6Trl+Gcwts?=
 =?us-ascii?Q?MrTrxuEv8Vgfgfh3CCTYaNSoJYz07KbHugyNTIL2t7oF+U3tYHAiyZt23cHd?=
 =?us-ascii?Q?ir63iCD+wVZAv6USZbmlaWL/urDEiAXLFg5CkDISVLzkvwmuj/1wZgfQGkHT?=
 =?us-ascii?Q?04kceYtSZ/YXq8vvHI10Mjxb7ZWZRwrULelFqm9FRie1RhXDMaBbImUOsXBN?=
 =?us-ascii?Q?Av3CnTiNCp67PoQXQeP+T13GaZ8ucy13gA+XcMxCwSKRT7xK1oolKbmL5eAD?=
 =?us-ascii?Q?R09sXAG9KbulmbnkdpH5uvR4cfhOJYX4M0egOLWozdVStaCSeGREFjKr6bRo?=
 =?us-ascii?Q?HrPjnxnMz2uLWrDf9fMzaWUAe2Qj+gRUjUe+z6xRuc9BEQGM8IVdd/WqLB9O?=
 =?us-ascii?Q?1UsiEbxWHT8QLk+K3sC13x00ww7pMktCrxgq+npWNV0GKxVKepBismwwkyuB?=
 =?us-ascii?Q?FjZMIFQWlK+yFs6pX7OmD8p2bGDKUUAhJ6nAnamjG4nyfx4riGsdwsozpago?=
 =?us-ascii?Q?Ga4zXgtYbJFDNCleEc6PrxqDtFsBIJ+Zam43OhM6z5sQ1COBDmubeprn3CyJ?=
 =?us-ascii?Q?NLKAkTa6DRnAJH0vpYNQUQlt8yho77fIU5bgCosf5inMEYog5jxOJvyJNi85?=
 =?us-ascii?Q?CHQV34reF/C7h2cgpULDM+j99LPd6afyjS/81rVPrBMATTHL8n2x2eUU+4AP?=
 =?us-ascii?Q?Id+R6wbhStO8bOnYw+VBDg/DiwWnoUBZIaWCcWBP256mj2NnURYUPKbB6sLz?=
 =?us-ascii?Q?46BCpUxl44AZ2P65cm6hDX4wflfil4DxQ27LeD0hpJfWju87F8JsxOb0jObM?=
 =?us-ascii?Q?tr4yrI27295XZjYdSCzUVZqqdefm48vFk8nMDsVGo0+BjDufE2JAGsW33T4Z?=
 =?us-ascii?Q?HQEFAAynxPF6d705EClEUuVMFPcUGatepGscPvHihGjFdNtco/bz89aEOH7c?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gUI6fnhYB9G0h6f0Y/BshYfR6ieqze7Q+D/IpubJGuytDVJvc7YZvKq/vsu8rb9UeAWmAc3jP1Xu2rkX4+Jf0Ya8Aq1VJQTDJIZt8ejzKR3tG0TVUdSVn7fWMNQ7KAJi3RTK5j9rlQfTbpiOa6Pc8EJlD2sCVVGXTGzJh7wLfk21V3McOJuwCwcMXXkgDgoHMo1mYMoy1IX8YDa8Eb66k63uqCwoLDKvAupojIgBFukULje3cm5P8ixs+FUgo4oMSV6IgLiqlBMF6P2hFebb9+jitOXNiNduJwEcFrABJNXLnVqqJk33jPRAYTDlrhLOD5P5eCcr1zFvYy668wCEn+wE6hWB9JckgELwf8C+hztVc5X5vjCjgWr3aOC/JAIF7qmn5hkqwj54fBNv95wGNTxlkpye2nqbn9J5HbGOawKI1zWc1UhjFWZOWs2B4eFQO1IzdQmbDP608VBVi3Kcr3UnvBrQrkwc/lzBRZarQxhpst11vX8tq0QimJGS9HaKzCO3C2vOBjEHG9GYD02rZNjaZXfo8WQGCaMUjNfbMOzgtV52JNuB0tXjjfUbWC2v8MJEpxNKVw87n/Abi9DIrC7YB3cJiHXDnm7Eaaydm6k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af989fe-633e-45ab-56b1-08ddd8dee091
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 13:56:32.0370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qk9UhBpfKLWzxDva/VFQFMtqPgpF0qeLKKQzBs4OotOK0uUamSV53bBa7HAzmyzFQKCUvWPf9iTaW+/C26XtZ3ysjo5vnS40jP5TqxEufQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCAF322559
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508110088
X-Proofpoint-ORIG-GUID: 16_F9grModtURuUXhKbtB751SyCkR5ab
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=6899f697 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=uawgyWh4HyNtZSAWacsA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12069
X-Proofpoint-GUID: 16_F9grModtURuUXhKbtB751SyCkR5ab
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA4OSBTYWx0ZWRfX3fz25mz8fZRf
 i7ZmHops1ALXlM93qm/SL5CrncDgglCyNxDJyoTx1Hz6CUFEsSwiinKV1XGkOpSC7JkRHNkO+pO
 tbVlsw1vZwcdJzGqbV3X4VCxeOsrchCUamTsctPWPXjYiomgW1/s+Kr/Aq6iTHypRDDYnS8hdrf
 fB2TXiSH76JwUuAWbDTL9ZY8/FO/eV8ZUxYXCTjniApqs3jhG3goq6Fm3kTk3lVlR9t/HLRkAl7
 F8onOp9dxZmsM4TAaoIpqqRGXgH35OphmVj5nwpX3j1OGNCYPbA5ZSpKx1hWk12/1qCL783+fEL
 NtpJYw6m7cTldp4Re0Xq0vmt0OSY2MgxeF0r81E7XpVMs0AkaKsdOFyM9d6dHWMOCaDMv5+hHwE
 M0dPl+PkT5bNaFH646u2/zbHYW8BcyOtWdAPoS9ZkYLHIdzkQ8n7fhib8gmMfvjn1nJRY260

On Mon, Aug 11, 2025 at 02:36:37PM +0200, Thomas Gleixner wrote:
> The code logic in perf_mmap() is incomprehensible and has been source of
> subtle bugs in the past. It makes it impossible to convert the atomic_t
> reference counts to refcount_t.
>
> Now that the AUX buffer mapping and allocation code is in it's own function
> apply the same treatment to the ringbuffer part and remove the temporary
> workarounds created by the AUX split out.
>
> No functional change intended.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Aside from nits/code style stuff, this LGTM afaict.

I've done a bunch of (basic) testing locally and hit no issues as well with
the series so this all seems fine.

So:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

>
> ---
>  kernel/events/core.c |  176 ++++++++++++++++++++++-----------------------------
>  1 file changed, 78 insertions(+), 98 deletions(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6970,6 +6970,70 @@ static void perf_mmap_account(struct vm_
>  	atomic64_add(extra, &vma->vm_mm->pinned_vm);
>  }
>
> +static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
> +			unsigned long nr_pages)
> +{
> +	long user_extra = nr_pages, extra = 0;
> +	struct perf_buffer *rb = event->rb;
> +	int rb_flags = 0;
> +
> +	/*
> +	 * If we have rb pages ensure they're a power-of-two number, so we
> +	 * can do bitmasks instead of modulo.
> +	 */
> +	if (--nr_pages != 0 && !is_power_of_2(nr_pages))
> +		return -EINVAL;
> +
> +	WARN_ON_ONCE(event->ctx->parent_ctx);
> +
> +	if (rb) {
> +		/* Must have the same size */
> +		if (data_page_nr(rb) != nr_pages)
> +			return -EINVAL;
> +
> +		if (atomic_inc_not_zero(&event->rb->mmap_count)) {

NIT: Can't we use &rb->mmap_count here?

> +			/*
> +			 * Success -- managed to mmap() the same buffer
> +			 * multiple times.
> +			 */
> +			atomic_inc(&event->mmap_count);
> +			return 0;
> +		}
> +		/*
> +		 * Raced against perf_mmap_close()'s
> +		 * atomic_dec_and_mutex_lock() remove the event and
> +		 * continue as if !event->rb
> +		 */
> +		ring_buffer_attach(event, NULL);
> +	}
> +
> +	if (!perf_mmap_calc_limits(vma, &user_extra, &extra))
> +		return -EPERM;
> +
> +	if (vma->vm_flags & VM_WRITE)
> +		rb_flags |= RING_BUFFER_WRITABLE;
> +
> +	rb = rb_alloc(nr_pages, event->attr.watermark ? event->attr.wakeup_watermark : 0,
> +		      event->cpu, rb_flags);

Not sure I love us reusing 'rb' here, perhaps we should declare:

struct perf_buffer *prev_rb = event->rb;
struct perf_buffer *rb;

Then refactor above to refer to prev_rb and assign rb here?

> +
> +	if (!rb)
> +		return -ENOMEM;
> +
> +	atomic_set(&rb->mmap_count, 1);
> +	rb->mmap_user = get_current_user();
> +	rb->mmap_locked = extra;
> +
> +	ring_buffer_attach(event, rb);
> +
> +	perf_event_update_time(event);
> +	perf_event_init_userpage(event);
> +	perf_event_update_userpage(event);
> +
> +	perf_mmap_account(vma, user_extra, extra);
> +	atomic_set(&event->mmap_count, 1);
> +	return 0;
> +}
> +
>  static int perf_mmap_aux(struct vm_area_struct *vma, struct perf_event *event,
>  			 unsigned long nr_pages)
>  {
> @@ -7042,10 +7106,8 @@ static int perf_mmap(struct file *file,
>  {
>  	struct perf_event *event = file->private_data;
>  	unsigned long vma_size, nr_pages;
> -	long user_extra = 0, extra = 0;
> -	struct perf_buffer *rb = NULL;
> -	int ret, flags = 0;
>  	mapped_f mapped;
> +	int ret;
>
>  	/*
>  	 * Don't allow mmap() of inherited per-task counters. This would
> @@ -7071,114 +7133,32 @@ static int perf_mmap(struct file *file,
>  	if (vma_size != PAGE_SIZE * nr_pages)
>  		return -EINVAL;
>
> -	user_extra = nr_pages;
> -
> -	mutex_lock(&event->mmap_mutex);
> -	ret = -EINVAL;
> -
> -	/*
> -	 * This relies on __pmu_detach_event() taking mmap_mutex after marking
> -	 * the event REVOKED. Either we observe the state, or __pmu_detach_event()
> -	 * will detach the rb created here.
> -	 */
> -	if (event->state <= PERF_EVENT_STATE_REVOKED) {
> -		ret = -ENODEV;
> -		goto unlock;
> -	}
> -
> -	if (vma->vm_pgoff == 0) {
> -		nr_pages -= 1;
> -
> +	scoped_guard(mutex, &event->mmap_mutex) {
>  		/*
> -		 * If we have rb pages ensure they're a power-of-two number, so we
> -		 * can do bitmasks instead of modulo.
> +		 * This relies on __pmu_detach_event() taking mmap_mutex
> +		 * after marking the event REVOKED. Either we observe the
> +		 * state, or __pmu_detach_event() will detach the rb
> +		 * created here.
>  		 */
> -		if (nr_pages != 0 && !is_power_of_2(nr_pages))
> -			goto unlock;
> -
> -		WARN_ON_ONCE(event->ctx->parent_ctx);
> +		if (event->state <= PERF_EVENT_STATE_REVOKED)
> +			return -ENODEV;
>
> -		if (event->rb) {
> -			if (data_page_nr(event->rb) != nr_pages)
> -				goto unlock;
> -
> -			if (atomic_inc_not_zero(&event->rb->mmap_count)) {
> -				/*
> -				 * Success -- managed to mmap() the same buffer
> -				 * multiple times.
> -				 */
> -				ret = 0;
> -				/* We need the rb to map pages. */
> -				rb = event->rb;
> -				goto unlock;
> -			}
> -
> -			/*
> -			 * Raced against perf_mmap_close()'s
> -			 * atomic_dec_and_mutex_lock() remove the
> -			 * event and continue as if !event->rb
> -			 */
> -			ring_buffer_attach(event, NULL);
> -		}
> -
> -	} else {
> -		if (!event->rb) {
> -			ret = -EINVAL;
> +		if (vma->vm_pgoff == 0) {
> +			ret = perf_mmap_rb(vma, event, nr_pages);
>  		} else {
> +			if (!event->rb)
> +				return -EINVAL;
>  			scoped_guard(mutex, &event->rb->aux_mutex)
>  				ret = perf_mmap_aux(vma, event, nr_pages);
>  		}
> -		// Temporary workaround to split out AUX handling first
> -		mutex_unlock(&event->mmap_mutex);
> -		goto out;
> -	}
> -
> -	if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
> -		ret = -EPERM;
> -		goto unlock;
> -	}
> -
> -	WARN_ON(!rb && event->rb);
> -
> -	if (vma->vm_flags & VM_WRITE)
> -		flags |= RING_BUFFER_WRITABLE;
> -
> -	if (!rb) {
> -		rb = rb_alloc(nr_pages,
> -			      event->attr.watermark ? event->attr.wakeup_watermark : 0,
> -			      event->cpu, flags);
> -
> -		if (!rb) {
> -			ret = -ENOMEM;
> -			goto unlock;
> -		}
> -
> -		atomic_set(&rb->mmap_count, 1);
> -		rb->mmap_user = get_current_user();
> -		rb->mmap_locked = extra;
> -
> -		ring_buffer_attach(event, rb);
> -
> -		perf_event_update_time(event);
> -		perf_event_init_userpage(event);
> -		perf_event_update_userpage(event);
> -		ret = 0;
> -	}
> -unlock:
> -	if (!ret) {
> -		perf_mmap_account(vma, user_extra, extra);
> -		atomic_inc(&event->mmap_count);
>  	}
> -	mutex_unlock(&event->mmap_mutex);
>
> -// Temporary until RB allocation is split out.
> -out:
>  	if (ret)
>  		return ret;
>
>  	/*
>  	 * Since pinned accounting is per vm we cannot allow fork() to copy our
> -	 * vma.
> +	 * VMA. The VMA is fixed size and must not be included in dumps.
>  	 */
>  	vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
>  	vma->vm_ops = &perf_mmap_vmops;
> @@ -7193,7 +7173,7 @@ static int perf_mmap(struct file *file,
>  	 * full cleanup in this case and therefore does not invoke
>  	 * vmops::close().
>  	 */
> -	ret = map_range(rb, vma);
> +	ret = map_range(event->rb, vma);

Have gone through the code and convinced myself we always set this by this
point :) I seem to remember there was some issue with me using event->rb in
a previous version of my series to add map_range(). Perhaps it was
positioned differently... Or maybe misremembering...

At any rate we used to have a WARN_ON(rb != event->rb) here so it's clearly
an invariant since hey we're meant to set this field anyway...

>  	if (ret)
>  		perf_mmap_close(vma);
>
>

