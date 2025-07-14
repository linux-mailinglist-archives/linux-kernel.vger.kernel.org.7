Return-Path: <linux-kernel+bounces-730239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C80B041B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B003AEB01
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC81246BC5;
	Mon, 14 Jul 2025 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="POngNVdT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vu6MZDr2"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A1FEAD7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503510; cv=fail; b=pXU0Zm1eBm6bSU/MLhNlQe6jljaHtR8TeU6HIjnKvPGGMC85LLZ0C6CGiUIcYNkyFgetO6fqhkhA6iunUzsqV2eC7KvsWe3owHTXV4rAtOlGJ5i9C3BKhPRXfc6iNXEatH6Sow1GOcTgVeahyw3CNg725JYOHmIJK671xcwPdLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503510; c=relaxed/simple;
	bh=TUKJj1aQD8mVRGbeg5ojxNB6caoxrF+Tl19q2JryQd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s8vEDfTbXzMpik6R6rkdmgcCoqRUuxp20s0CSr2n9qdFbrV4XYovWt8RliLfpmicYk1HHTlPvqfcVndwt/MHzvl31A89CBJtNlu2yEcQ0WT7iGZ+fkGYsqzZLotBz5R7ljEknffjsPbKwH8tLLEOArvpkk1tJRy16sG87ihycic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=POngNVdT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vu6MZDr2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z3OJ001213;
	Mon, 14 Jul 2025 14:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=JIo6sH0hEguG4jKIcM
	h8Cfu0FIQMLugQHHcN6G/muR4=; b=POngNVdT1LN20csFuROyR5M/dbA2OSyHog
	VAvhdXWp0334sJC6bU71IdNT7LZ6soqC/7ljqLnLyHcKQT6srOW6EYOr4x/ukUkx
	nMMzHo6a2CG5Rbsc+/cjRqYR3baI31EUdMqRm29pknwytcvXgJHChLWSK+CHNySO
	4jE0sY4yQZSpg6bHagW/Ks28vhXng92UWNVuY8ofgbIbHFI+FyFh6GN3DR8zpl0A
	5Jv9cwaZJ4RPbKm9NxGiS+si7SczOMducTScYbNkHSA7fBlxjpylIoPPOQlp4QQU
	YSaro6Dpy5mwZDccO5oaw6nf7pKVKBDJqHyHPwbOAsNeH7RRlGtQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8fv8f9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 14:31:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56ECYXXi011523;
	Mon, 14 Jul 2025 14:31:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58kmjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 14:31:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPNYHAWnlmcvNjzb/pGZEBywvlfgWqEBl93kd8c7hiXHnlj0zTrOaG0Iv2ROJtHwf9vu5xV6EH/kApoacKhX2ufFuvKravh6rxGTnTb2xV6xBwwpO77LipIo+z0kxg9r0LwMf09ESqIh+cc9M0KAQVRn95CmKRnsA97nL0rBMCYw2XTgZvVSXrJmGkLZl1v9m8WcM3EJWaVoKwi7EbmGv5O1bc0HxZU93IN01Ow49b7p7XJjmicJkHm4+5aNt96HMPit9639YCBAChp+hnZDvUINGZrwpgpy6WYU+h2KS+rOUEelqh6+4hMF8Pjr6iEnIHGwZoR5xCr5wX44g1w49A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIo6sH0hEguG4jKIcMh8Cfu0FIQMLugQHHcN6G/muR4=;
 b=dCt4ATOvQevRQFE5cX1FBhU+SRhtwDGNXbw7pvPn1XgOH3khBeye+AG1nevuTJtLoH1AWBKt12D1abgihcyzqolENO9comFDXAVIMMnr+aUGZkWXF+FYAFoaQbHsUVtIVJEmheYZqzuS2UXyDT64MRDgHorLeEQb1t7Mxl+Mc7J/AnzMiHDS+9PWzXlN5Ko4SggoABZ+yI2TapU/dfbjzu/itcYJpx8NK29O/uNT4PB837CmOdaSQqDjCZHAyZ5v33oPT0raPH2jcWvCUT/6sIiPlVpD+bwf/H//Ppd2vZfsiaU0mDISJjBCX9twqhaVQDUOvvg7RaBMJEAYh0pxzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIo6sH0hEguG4jKIcMh8Cfu0FIQMLugQHHcN6G/muR4=;
 b=vu6MZDr2m29JFtT8Gh/phxf5XULAAZ70Jc5trCSMS0wejURckEciDtvqEVu7QxZSdlCzykldB6uMcD/96dMxmI8u9k0z6Z1YihKECE3a4JqtpXgIwRSjyYySFOVr+PR+Af8hoSyt0+EjRrwlehewiLqTS2jLlxE1vaZd+DJkXZ8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH8PR10MB6339.namprd10.prod.outlook.com (2603:10b6:510:1ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Mon, 14 Jul
 2025 14:31:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 14:31:30 +0000
Date: Mon, 14 Jul 2025 15:31:28 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vma: refactor vma_modify_flags_name() to
 vma_modify_name()
Message-ID: <77f45b2e-a748-4635-9381-a5051091087f@lucifer.local>
References: <20250714135839.178032-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714135839.178032-1-lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO2P265CA0263.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::35) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH8PR10MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: a36d9049-9cca-41ad-01dd-08ddc2e31fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hIwBc6AMMuhzCt5p2DiSvmiNmKzbbXHU2iLGHM7OCLzG4SG0XsfQbcuzQmOt?=
 =?us-ascii?Q?LU6bUp4f1YqPkzOFilfCv+kZSjztsvpHLRdgtI1kgD/pgM4ydZjnrxK8ZSPi?=
 =?us-ascii?Q?VdtCTNDKmO0F8gS6cu0AyNH/D65oxcZlDMLx8hJ2kyLpQlEmF/lnGadkYiXe?=
 =?us-ascii?Q?DOCTIqSIFpQaMlOT7Qu8sVihu262PR6wSSLifcyHO4ct886ZF3iS7PW0Gptb?=
 =?us-ascii?Q?nzlcDdhie1o8tNQFfNXI7qr3lEuo2Ef/lgeb5XNCBAI37NsvbLjynh2YztP4?=
 =?us-ascii?Q?jm96eMM9V1SwAG+VFFWuye8gdLsgjhtUyDqb7dh4HsC/iOnOaaNeAxRHjmgE?=
 =?us-ascii?Q?+nOCuoxYGgHsTMkN74heS1SbTsJuLW/T1tkXU1ixzv1bgOgiwGt8tsA2/uRh?=
 =?us-ascii?Q?oucP7PaALq1p2FoP+9R3tjqsru/yiP8LYsEnYQhv225YUpw+1kr94dhJKWCI?=
 =?us-ascii?Q?ViYUPXWrmxUpNBO0+jHnHxu6D+Z7F900NJ6Kh7TCZqGbTQif8wKPfFW95brU?=
 =?us-ascii?Q?WlUAj4X10bqyfaYluDGKCx+1fDsIV8j+xIruW0DK9oGiMXFqAXk4DkpFpBSN?=
 =?us-ascii?Q?/gl+dHYEZyo6VAVhvWMKtZqmZECm576qSJ7WnCwdzH2Y3zpgXNN1cP3J//GL?=
 =?us-ascii?Q?zm7v8+0Vsv676uk18R1oyZEPp9si3MEY59wNYFMPu+s0N61NN77o3Zh+LnGB?=
 =?us-ascii?Q?DiTzqeR0pTgorOEDAzcopEgV+BiLBoZijVDk8kKq/8Mvbjt4AyaqAufOkXnO?=
 =?us-ascii?Q?OjLzVEqbTFFBv8v67kR6ayTZboguhYMeoruaPA6LsoUptKHvFXy031ClOUN9?=
 =?us-ascii?Q?JMN+PSskNEhHv/XD3h8KWN8B++98kXTheWlTHa/eXylSOZkyPaX4nWZx2vTQ?=
 =?us-ascii?Q?oK214xkVNOQxvbwaFwaq56rIDvULhNDdkIsDUIOfD0XQM/F+aYsqwjm3dfVj?=
 =?us-ascii?Q?uJk9cW7zu2cQw+L7LOxVZEYR2sP63yGTMd8N8gb+HeuxpGpsPJv5knIs4GLP?=
 =?us-ascii?Q?vJff+Mki5+N2B/OZuqnKG8uGIR/JqQ6I2C3n1hMTLCCuROhuUyiBbQqtxdtP?=
 =?us-ascii?Q?552JA4YcGEOdCVv4vxS6o4Is7JQZAmOqhhIdLH3M4qn2zAuKkOfIIAZRQGxA?=
 =?us-ascii?Q?hVuUbuZZN+BxouzdxIfvUcXDP8WxUwX3FyYnMpsUsikWguJK2O+1Zt4HXDaR?=
 =?us-ascii?Q?BELsdQqeHrmbQjwqkHxTzW4Xf5M1zuMN84p4cf3+aoZ233tOSZFBrJtBP2oA?=
 =?us-ascii?Q?i5IHerStyFumrBSE1w6G+IxVZ0g3csJi6RURwiyb1N4xpKrtH0jL00rYtlvn?=
 =?us-ascii?Q?cIA6HRxY8BeyQrNhCzCIyHbhAcp9cfE+PNs9GkzP7+u8dDoOAZu0dG2Rbrws?=
 =?us-ascii?Q?Hzfh5i6JSAGRXHRf9oCHTslcOnHTGfFl4UwI4DVftd3kGzDJcDXBgnteOghV?=
 =?us-ascii?Q?ZhUnb1VTxow=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ul2XKbqeCdiROiIfxYuYEDcYwQIrB0YaEgsTIFQP6ytnFl6k5mnfIR/TQOt5?=
 =?us-ascii?Q?1ZIC4ChWey1D3WA5mDeCNCTjqC+BvqMQK5pwoF/KYgstKzmacVNFFW7IUXyj?=
 =?us-ascii?Q?/Xm+RgJy3BqsH+wx6rAWybVMe+LTXy5kfX+22etJhf1RCJtpENJBL0xFC6+4?=
 =?us-ascii?Q?wsUS9YvWBGgFlurzCmx1J4ZRz/qyJZ2T496bf0IfCImqAWIXRyf3iEeuhTP1?=
 =?us-ascii?Q?cpiyUEUKb5sJmInBzggrBUC8PE771Wz/VrLl8HT6tXsTK4TpRdHvQ45zVpiF?=
 =?us-ascii?Q?PLwLzzymYeZIjCPHus9SBDzW9fIiZQ0CQmKgxn6C4oPP4PacLo7Ha+S9ZOfG?=
 =?us-ascii?Q?AjdY9Y9dGbw7iPmQlEcIHXcCS8MiyvV/yUJFI19F+aeGMnVo+G+HWDsxUOiJ?=
 =?us-ascii?Q?DYIMSeoFLsEGdacDNKJtBi8rCejzCpwC0GIWE8zMOoyDT6i3wIdxWLXafYZR?=
 =?us-ascii?Q?aqo52DrJv2coRCOL54ibgq1oIflzFwe4OaJwbj7GAugd9BcTXEvLJ7nLQV/8?=
 =?us-ascii?Q?DSHdV/ROseUHDva558g2AOHG18BdrLnywBA+DF8gGpOAettfK6kISPZuBR9p?=
 =?us-ascii?Q?CHjbpFTPPwusqZBgfbgrzgVo2R52ujQE3RBKLSj0h/4VqTDnX+PhXwMIJzcV?=
 =?us-ascii?Q?4zabFYTFJJ8vzpUkPwdEs3tOg7D+G2thOcEgMLgAc37/lFCE5mJbUMn8RUCc?=
 =?us-ascii?Q?RsL50l7U0aMXLsenQ9o18456LaAfzyCNOr2mHrw65QMchMWGhd1Rl1Mgu5mv?=
 =?us-ascii?Q?UxrwxEhkgWH6ci0W0e5ZbyiquCK3pK2WBL1pTSz80N+uvnBRIE5pQjB+oGxu?=
 =?us-ascii?Q?LLae8QKU8dVTKEvYdfy+3LYHhTSwUQOPjA0vsJrz0TadxPQ468UvSe3Ezaoa?=
 =?us-ascii?Q?WNYgYk/a5f2q6Qb3u83hNXZJNxhxTQTef/av3rRU7BSPPi62V535bBDBnEcQ?=
 =?us-ascii?Q?Py4QZQDgN4SZiHyBz7l5Se7dLQ6o31wFqUXdpwkm7osTHVd/jhebc4w0cd6l?=
 =?us-ascii?Q?7zSXBkd4nkJXpd+1VWbOGt2VHDx5Pdlo8JSWpKUXMvLVek8O06CB2LeiWalu?=
 =?us-ascii?Q?+wivSEMp0TGXKTsCQRAP0sECfnLfnCPqztT7QhCeFMhbzqE7KrTEptTSkHO6?=
 =?us-ascii?Q?mQ3S16UEYMparEUoFW44z8ZQ2mRMi8Rdb3BCo8fPWyF06y0X/Vjkqw1MI3Zn?=
 =?us-ascii?Q?9xyCkM8ROVF2grORXbolboOsqM9DPrF+1fbolF47OI+6AlaIWpPKvr7epTiN?=
 =?us-ascii?Q?o/X8c7co7rNnaRdx3MZgto521GrFIakKy1C210CarVfohHlcF1JJdLLCrgWW?=
 =?us-ascii?Q?kQu+sU0NUOOxnlBHLHOY0JqiwQ8bT6OXRyjojDdbBrzJHFUpvOC/A/SeYyh5?=
 =?us-ascii?Q?TF23z+EOvjVANMFWaww3hPN8QMXcD2Kccqg8v8kXTpuBPBZh9ZL2mj5BSUbk?=
 =?us-ascii?Q?8TxCRYMIIaF/8HtybMNWb8mHczAORaoVQW/rGf1D7v9mlR89H7LxnhzpjVbx?=
 =?us-ascii?Q?/ipLAGgr0BT1P9LULygReGKDqG+2I8Vop5ZpLKV56qxV4TAMARDnwkwp0UcY?=
 =?us-ascii?Q?6Vk5IWtKV2U0QYTJj0H+5EhxpnYd0sDwLwlnpNHeNXBTe7Ymekbej5VBmjbi?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KCt1GnrEF280aYWuUD+NUFRZYlSI1FETuUZxvttGZwuUYC+TeD/FZVshWXF+JUBvjRA6VR5BrSp9L0OLAXRCvr1PvwN7y2+AWskTlFLnfUqbhardTzI0tLjDmRFYEtvPSuHCNoEJptGV47l11IOSin1npAh5wVioUgInO4iL/KGC55ZofwFy0By+AGiCjnL73mFA3NfCWZBhFJAhOQr1Hse5vtcjSnAlYgJJWSV1RFV2voHNtwqmCa3LD1sGAl2LdHbGcyH5WE+5/0J9nsbF6xp0pPr9LYjxCPlFA/2nB2OJDCYMgH7HWsW0IMcZOvn9DrcNRFLkaW/CN2O8tKmXwoZQQVqyfqTMjweu7ZJbBMVZSKlylh1gSu8MZbZki41eXptEZkuOfl/jMuLhM4JP3+MglmKMMuXZc7Rv9OIxVUlT5/BPeLwONTRZUSg4Ku3y81E595q5lL1E/mTqKs0yzHb9Mh/WxZu4Z5rrLClzVyAUqQZb1uUgSD0MMungghsd5kgUqIZsLg7Sw8IQQ2ALW5jwBbr45haS72EpkPd36AdkZJUv+Pl9Yp1Yoa7ahpV6+KN36MKS09xeJmeu4+JoNgOJ6TubPp0VyqiRLubgx/o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36d9049-9cca-41ad-01dd-08ddc2e31fd7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 14:31:30.4690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jE6tBTvTT1P1q4fS1sLuxIMRu5zfAN7sJ1/er/KkXkj0Z3MHJkLBurnsVuu4GNwKYNWuOUH7CPiotLOhsl2VoVGeaDa45ggpEpqRCleNU3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6339
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140085
X-Proofpoint-ORIG-GUID: Q1pl8-EYXVla-0CzfT2cOMk0aOBI9QM4
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=687514c6 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=LcJnKhPfy0itpdnqrioA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12062
X-Proofpoint-GUID: Q1pl8-EYXVla-0CzfT2cOMk0aOBI9QM4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4NSBTYWx0ZWRfX7gDSAx0rkmIO b3H5GCxw8xe3kc/e54GNDf8vNcrWa8SvyqyIyT+7P8Gkbuiu0+PRCGqtFVuvxqSzfJGhO+Xf0Qp le/SwZG7dYJE8dTQJxPL/HQcu/OcDSVm4ly53DuFTotgRBXX40eFUfCPnNtkNmAMP1efoWWGjoh
 iDb1l2uaQF5cEoS87kBcETpmwgYIfyJyY4iZaApDI+wMK706H+KEOIRItoQ2YRoNqYDQ1qBrkVA 0zZ9i9gxNh/VOw10UkLLsxIA70zRoB0pS/KvkwyL4AZOXJpAJQgp/AOacX+TwR9sF/EaOcCtVui T0hcVv9M9Gw4Ab7jOJxo3eR892rouWMsyUPzvImHwmHA5ccnxOxMT7+71xHPVtBNjohZQvH7Gxc
 0NWxIgEt1dHqbbNXk6CZOG+dbu3tU2HaX62hmZtXZ1gK193KoN/9a+ngBJCW03dT3AGS1OLg

Hi Andrew,

Trivial comment fixup fix-patch enclosed, please apply on top of this.

Thanks! :)

----8<----
From a5bf29319f6d2880f3269ad87f6df7fd63f0860c Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Mon, 14 Jul 2025 15:29:59 +0100
Subject: [PATCH] mm/madvise: correct comment

We only either update vm_flags or anon vma name, not a combination of the
two.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/madvise.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index afa9e4db2adb..bb80fc5ea08f 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -145,8 +145,8 @@ static int replace_anon_vma_name(struct vm_area_struct *vma,
 }
 #endif /* CONFIG_ANON_VMA_NAME */
 /*
- * Update the vm_flags and/or anon_name on region of a vma, splitting it or
- * merging it as necessary. Must be called with mmap_lock held for writing.
+ * Update the vm_flags or anon_name on region of a vma, splitting it or merging
+ * it as necessary. Must be called with mmap_lock held for writing.
  */
 static int madvise_update_vma(vm_flags_t new_flags,
 		struct madvise_behavior *madv_behavior)
--
2.50.1

