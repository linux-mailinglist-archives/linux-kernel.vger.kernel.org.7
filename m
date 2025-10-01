Return-Path: <linux-kernel+bounces-839224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 070C2BB1174
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B7A18923CE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FC72749CF;
	Wed,  1 Oct 2025 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="kht2Ri95";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="bK76176d"
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D2A1D88B4
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759332922; cv=fail; b=DXkYnzH05pg3asdH4JHdxpEfJarVx2OALG4BQc17XsX67qGAl466EM8UszVscfC8p2SS9o+fn2AT1xJ1JZplH2wAwDVH/LsJiRVFsaf7ZgPG3SRfEod4BIKpfcUhEk73ixp+DC1BhktG51UPNHiFSOzHu2SETGYc6H1W15BJmrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759332922; c=relaxed/simple;
	bh=iHbtBD09ZLdZsKrDbmOKEzlg19XyX61KRnqAZ8ZbVWU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YKJhUREsEON2C1ti1afeOafVpjeinOHHVQLJKBvblQ0YhOCFlK82OVZKlVBA14EMwLRqeAS0GkYR6gx+lN2I/bev2N5AMCLQJYe0xdNM6LrKRiEUzX0sQ73dOC7c9bcxZoKIFZWiHVd4lHDOdyxMhSDrNq5BNe5zqjyeJ0SAZDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=kht2Ri95; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=bK76176d; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 591CQcgm113927;
	Wed, 1 Oct 2025 08:15:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=P5YauUWe5pSD1
	Bu3LNIQpKpBnlaNJJ3gKupfL29/6LM=; b=kht2Ri95eXAC15Vh95uJJMUw3Y3ZA
	n/aIja+6h6S6lnivogXkOwSzckgcDInbCsAW/+l4iWJlUCHqIdqX1dov8qIyLenP
	UjtEdBTc2bu8gFvvX6kRsWdMXOLr8s8/DocoEvZ4X5HoQ3UtG3TlbsYRjR9BBWBR
	G3lkSdljRB4LlXEdDa1NNU8iLxmBgY1dXls3S5uWLmjTT9iWT+Pe18NkfbvF+gId
	QLxwQxk4XM/jaDzCKEcqo1bKziJw817UA/sxMYl+4fwwchmWFG+pW0sYmqK9nj28
	RJiKR6iUf3HwLFiWbcFOM1ag00fVTLgCqvwUSnggAXr/WZU0npSc8lYlw==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023075.outbound.protection.outlook.com [40.93.196.75])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49gnw4a7kg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 08:15:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbEKCFs5mQy8TJMDqAXBG2rQgngjwWZ227CJconLT9pR0uCdyedfaWzJtFWEHKYmyPwMOCvCwL7KaEk71Tb0I7MG6mtJ58zr9ArvpFLlgU2vMtRrnBEfZ2vIWUUjn5uRgK9dyZtll2PLOvAN41PHD4NmgG317YLBneG5IkIvIr9++U1/nnaUzBui47Tu7iybuRw3fFnrKIdlDUQ3/+79V8tL2NIWq03NKkl7exdsnrEcQD5fYZpXjAIWafDz3evEABOS7tQS8akfiPMUuwYqEtGBX2N1YAOECu4GfuMOgXjrmYzYLdvVRjSsabYAV0TtBVdCwdyFBKowjz0UZcLyfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5YauUWe5pSD1Bu3LNIQpKpBnlaNJJ3gKupfL29/6LM=;
 b=PvkWaacUAdhI69mMTFN5y1d5R/hu4qm/iRtwZ2owInFEMRlFBfFWJiobz1VAcip9Dqz3Y9faETl6J2+1cN1XnRlCZBovN+k5svBwtc8oGjO5va7BDXv8oQiiF+cjaXjIYUVCcxirt3PeZTxEP6dJQ4uYLSy4/OIsAKA3kVDoCAQtfohc/T9lb6YpJYdHKDtVGGtK8ZbsHbRUZQsyF8BraLM1MZornjgVy4nMGAYWFnfZY6HSFuw9Jk5oKaUPST+vpYp7Ge694zpwCRoi3Z8XrnB3UdQNKEYgwAPFBdgWchoNA4hmj+lGfifFeLnlZpgkeZOzpUYuu/8mjqIbFtsbDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5YauUWe5pSD1Bu3LNIQpKpBnlaNJJ3gKupfL29/6LM=;
 b=bK76176d74wTkMM4ZtPuq+pKAj285uuGwnwPIZ4wgfS/+GT0iLLmstA1tbhcw2z8f07BtBlJl72+OmIcXpy0x/6f5nbnYIAsh8YylaoMd3EP9vCjvkurYxD0lTkxb4SvFbSfHunso4uywLJHkTaZVp4Jt7bT5GVGhKD+ZhN2EYRLL1Tb3oVJOC/FVef2H+rabJcFktsyWrFUzUD0td6A6SdvBq2sP058X0B1sO5aNFkEDyReqX9HpTQDBPePCoulEKjR5k/98GImne45vLYlL9xHxvU/mX+YsKWy6VM+s5KGRzycbnRlW5cq0Sla53p6FxKV4poS1zLWJO0/iMcNfA==
Received: from BYAPR02MB5016.namprd02.prod.outlook.com (2603:10b6:a03:69::27)
 by CH3PR02MB9478.namprd02.prod.outlook.com (2603:10b6:610:122::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 15:15:23 +0000
Received: from BYAPR02MB5016.namprd02.prod.outlook.com
 ([fe80::c759:bef6:2ea6:d47a]) by BYAPR02MB5016.namprd02.prod.outlook.com
 ([fe80::c759:bef6:2ea6:d47a%5]) with mapi id 15.20.9160.014; Wed, 1 Oct 2025
 15:15:23 +0000
From: Vincent Liu <vincent.liu@nutanix.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Cc: Vincent Liu <vincent.liu@nutanix.com>
Subject: [PATCH] PCI: Check drivers_autoprobe for all added devices
Date: Wed,  1 Oct 2025 16:15:07 +0100
Message-ID: <20251001151508.1684592-1-vincent.liu@nutanix.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::30) To BYAPR02MB5016.namprd02.prod.outlook.com
 (2603:10b6:a03:69::27)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB5016:EE_|CH3PR02MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: 588e4827-0ae9-41da-7939-08de00fd57d4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cItgfe/StiRLag/9exG9M/KjsH615l8jWixLgAqlU7lsqJp0fyk0kCpeF9Is?=
 =?us-ascii?Q?AJ6ypzmYQ3LFhb34Pj3NzLl96G7xs9tIFXtK6e2hdLG2q0ceFbk59o1Rs0wB?=
 =?us-ascii?Q?+lCzVgXLyEK4hLIEzQNqW6nSlCP7TPVKbvmlHHqKwVgpGzNbQ1WllGqOqZpn?=
 =?us-ascii?Q?AwT/7k0PdXGmmWWJh5mtz/tjL4vhYwPcF8K29oBWh3ZPnHwyzrW+UzPD4Dze?=
 =?us-ascii?Q?Ix6JijnCi+m46skP7FFlPcmuMGsYFHepDG7SOZjrBmtIuT04NlUViULTWBA6?=
 =?us-ascii?Q?M9d1nsgHGRXeDxbGfBPv7xD6pbkevYk+DDhaOlYp9Oap/H2+T2r0chZLD1FM?=
 =?us-ascii?Q?rvydPcoCXTUJ/BKUJZVd64gXWQkD8TqqzSDo0OzQwyi2H0jw3Noi58/vzVUv?=
 =?us-ascii?Q?T5LcjKPHznZZNQkHgMd6xPNEJlF5SXJ5LwvJvr3Nm5dpZX3XvOQ2rmb0hQN8?=
 =?us-ascii?Q?vfB8oN0z7FA/cyuZTMDt/MPEgBjEvltQsYDClwaao9EDMdcy32NuXPCBzedD?=
 =?us-ascii?Q?tSXvFmqL22QxGcM0fjZP8+AyBFp3CCpfrc7Sa5LHfjTsgmX5r4QbnMjNpa2h?=
 =?us-ascii?Q?0Km+QaqntyvVkaOmpcE2HVVMXPLVGl2HofiwsopQGkxRXZKQCcYwpd8z16eW?=
 =?us-ascii?Q?XSxE32K2VjuPfwMFlxwRcODBNbDE45b5oCwftYIZAjdA3noUSDivtvdY4/pv?=
 =?us-ascii?Q?GbggcPrOlHvzFM3d6ba/4vYKTvgt9VC5xK1Rtx0E0yYDpoGsBS75/a1g6Z9R?=
 =?us-ascii?Q?GKy694eDTGCSnzaqqBsQkMIPMv1O8Abqxgthjxzuaze1uWXwJVgH/bI2FS2V?=
 =?us-ascii?Q?03/JJhY1E+CI9Vqhdlu8oSm9tLirEanCh6ni28CZuT38VqVTxRNtmUJbXowy?=
 =?us-ascii?Q?Viyu+UC2tWt2tJ4WbfIueKtKCH+e9v5+mb3ZFaBDg5DLGkOpEJQJslwG0PYR?=
 =?us-ascii?Q?lP/ch1wj9p7fH+gAF9cYG4kSolBPaxM8hsEv65K8x/ZYeMWNtvrO/PhbxtGg?=
 =?us-ascii?Q?ZO10u+EgTRCDyTJz/cH9v1NeKihvgJ5k22dkQbq6BzvGca1DK9IDIUp+ttvS?=
 =?us-ascii?Q?n9Ub+eaiscwVqHOjd/DlKx1wMUOu4QpRQzaMM1350N6lsRU+Bfle2CLyzuzw?=
 =?us-ascii?Q?CazNnbKKk0PeqwaumRczR6pwNygPk8DxY+2dgD4mq8pmGU8/3cQRPJBfITcH?=
 =?us-ascii?Q?E3kE3N+n8+PfCHHXkFicy0MwOBAJ2b0BMyCMV/1PtFmJnNZ+jhR8D1Vnx1LI?=
 =?us-ascii?Q?Ik4ZT0QBc23FOyodahG8Hix/CPToQR5wk2rzJU5WykX8xj9/jAmo9Serg/gy?=
 =?us-ascii?Q?SSotgPeafkhb/i7zlkJ7tUYWLjpowKuXO5jcgEFYpwhiMjFquJJFSfcdqq7g?=
 =?us-ascii?Q?3ZU7bTahak5JE62L6uCPTNQQXnAkHQf9kj4UDGbzuuTBxj5PkKKuZxuRp4ML?=
 =?us-ascii?Q?1nxDYVpClrkmKwSzqygORna5dTYjTn7J?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5016.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GhHlJm5wnpdGCDJ3a0i+8RulT7RwgpPTIy93l4j8Y0JBktKpN/6N22LnEusO?=
 =?us-ascii?Q?EYwCHxuMUwmId8xP9jECbIS/dibql8zpS7mb6SLd5qonMugjr/pFZfO6bDkR?=
 =?us-ascii?Q?ADhEUqX7Z+3mrIuJYtnQnksNp43u1Y1jzPcSfTzY+g7svMTJCcoarjClc0gt?=
 =?us-ascii?Q?PuZ7tsVcr7im61LXHxrbWkfMT1SHPZ0rcwCUyEcorQk1ePzbeptmVjYOSoO0?=
 =?us-ascii?Q?3Ldtjtfw9NVJety2YXiXY7j+eksLpqd1mi6GKbpVvz3+0TjqvExJez3xoyjk?=
 =?us-ascii?Q?WBYBYD9lpJpZfhc7FZ2cp/z8RhhyMRS1Vkm+6kRh7bQyz7LU2wcKzIsBG1ep?=
 =?us-ascii?Q?4p16YKrGI40eHhPVC97Drs29poKXmw6bJjQrUbY7w3rhQSGJKXMccD+/KHK4?=
 =?us-ascii?Q?gZKA1tRlIVk9r1p/XtMB8skGHZ0Tl+hiVyKhvBpN8VyRb8d8uYqs4p/hUlDs?=
 =?us-ascii?Q?/2cQ684Q10qYBxLWrQUtf1TFU7ozJ178lfJw+kPedYXUK6zkmoy1UPDdqEna?=
 =?us-ascii?Q?AtyH8Ypfi1+XIY4ZJX+jXP+WJJQ922u5rVo68kR/dkQ5nL6aR1cVOcJ0+T//?=
 =?us-ascii?Q?Acv5/rI9f1yhJEKCWGCG6bMbYavPQaFKK83JW4hV4Lr9M2TDIcefCi6UIo0V?=
 =?us-ascii?Q?Xt5NBqv7CAleImp0xVYV4sPMtA7c4UfZYUl5Y5FTXtUM6GK4iVYYZTUP9Vvm?=
 =?us-ascii?Q?0fomTWupy6lFJY+H+GgqRS5X30apSFsZXa5q+AJNBGHgdO2xeLpN43ADqV+m?=
 =?us-ascii?Q?QFtCYhTUB7vgvOiVWEiZ1bFoeX22xwVB8d0mlp5phWFGrK9G9W0mgGtXK+Og?=
 =?us-ascii?Q?qbm3T5/EP1SS45VmKhCDtK8UPnA1x9W75onwO8CLe4MBT1VGwgoy+R38T0Mp?=
 =?us-ascii?Q?e9H2+xssdmxq1/EghJX7Isw/GbrTVKzd+W5fljQxllf/5am+0RmRjJlzSptj?=
 =?us-ascii?Q?/xJd62QYTVgaVZA4pMZZFibqm2dqoszgtVhCRksfyjL8TJphty0jRwDH8iAy?=
 =?us-ascii?Q?hoIxuqJ6CNpAp3TDhvQvoBGIc2dmH2TvQBPQaB0I+dT0PA6OfTYLzEDOOu9G?=
 =?us-ascii?Q?KI1ztZB9lZQq0Al/HNhxKbIKJ1HvI0ECvrfepjQbOpe+5Ek+mzuh1vwjAikL?=
 =?us-ascii?Q?457MGbEmXfig+eOx2s8yn5dpfTNwspHk2UYJrqdmaF5/UBDs3gu7lkycpuCv?=
 =?us-ascii?Q?SMGIBdII2cP5B5+ruPQRgjJ4vIrGBFwTTvGRh1oe/QAWITdnIpib89X3WnrK?=
 =?us-ascii?Q?iNrkC2+1w/+puusPa++oL07v8rLbWJp4BFfio3j5UDvKzEOgXVUQXuKthcMu?=
 =?us-ascii?Q?lJXgOWQf1VWkIJMhz/W2dBBzljWE8mHlScIlHS1PpIKjTgXHtlj6fhLtCUUl?=
 =?us-ascii?Q?JcEVIOsZt0a3vnRRYDp8LjxK7WWXsKWs7wSXvXEGgM1Toz/VbV+LGUf/u1mT?=
 =?us-ascii?Q?12MLGV4x4xuJ+rYXDo9NDMoEUHQdhZHN51skojwwGMQQyt1WJRj/T+WuYj6D?=
 =?us-ascii?Q?FU1kzTaj8N3kXynIB23miIVrAldEB82BdLzWxshSGkEu2yAAvo0QjlEQhqxG?=
 =?us-ascii?Q?gwntUzCV+ORPEyd+WTEMiSL+CEMihGznAFSBgZipUxx7kXu24rdwm19fmido?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588e4827-0ae9-41da-7939-08de00fd57d4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5016.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:15:23.5251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vS7KwSDTVdccnpnvEwzhGS7lt3RKv+tceDEWZ5ezrkH7Act2r6NtQzvzLFc77nOeOJl1U9pnn+FcOtqz7JJxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9478
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAxMDEzMiBTYWx0ZWRfX9tcrfB8Lduu1
 +4mjbRA7xOfh33sipHfBBhVJ1IxqvdMysOiPE+iKj42yEU0kBMlhtm5Ag3FziuzKLanWOoCyVMb
 qTddlj+cYnWPzcQBif5zjdHpg1WUQBSESe5Ed0UdPBiddBiGIURIDCQut9+I1cu1ez0tUX5fqXP
 r1LFqsnMlfNt9cSXEZJCP3x37jxkboxS7o7U/x3i5o5Zvnc8JULAGQ6MgH2gEV/zF6LJPBpkccA
 BmDOSUettYPGEiHzXwEVaAZ0o/lgWT56cUcbsVxlBc1fxfFX5APiIvi6wOO2HJslp2p4Il9HK8o
 F+Fo8AzGyD3nAiIJgJxT9qAQAjE85hrx7PPJIGmbODVqX1GMZd9fqV7PX26zQ+sV9fvl2+ytUB/
 x6Uaree358F2bWRrHvv+4C3DpBc/vA==
X-Proofpoint-ORIG-GUID: QiUdnlPQaC5msHdFIwhKEOYw2iIM6LE2
X-Proofpoint-GUID: QiUdnlPQaC5msHdFIwhKEOYw2iIM6LE2
X-Authority-Analysis: v=2.4 cv=AsbjHe9P c=1 sm=1 tr=0 ts=68dd458e cx=c_pps
 a=ZwnHHYtbhvZyeoWvue1Gvw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=BaWJ-9AYJO18P6nO1WQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

When a PCIe device is hot-plugged, or when a VF is created, the
drivers_autoprobe sysfs attribute is not checked. This means that
drivers_autoprobe is not working as intended, e.g. hot-plugged devices
will still be autoprobed and bound to drivers even with
drivers_autoprobe disabled.

Make sure all devices check drivers_autoprobe by pushing the
drivers_autoprobe check into device_initial_probe. This should only
affect devices on the PCI bus as device_initial_probe is only called by
pci_bus_add_device (bus_probe_device already checks for autoprobe).
In particular, only hot-plugged PCIe devices/VFs should be affected as
the default value of pci/drivers_autoprobe remains 1 and can only be
cleared from userland.

Signed-off-by: Vincent Liu <vincent.liu@nutanix.com>
---
 drivers/base/bus.c |  3 +--
 drivers/base/dd.c  | 10 +++++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 5e75e1bce551..320e155c6be7 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -533,8 +533,7 @@ void bus_probe_device(struct device *dev)
 	if (!sp)
 		return;
 
-	if (sp->drivers_autoprobe)
-		device_initial_probe(dev);
+	device_initial_probe(dev);
 
 	mutex_lock(&sp->mutex);
 	list_for_each_entry(sif, &sp->interfaces, node)
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 13ab98e033ea..37fc57e44e54 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1077,7 +1077,15 @@ EXPORT_SYMBOL_GPL(device_attach);
 
 void device_initial_probe(struct device *dev)
 {
-	__device_attach(dev, true);
+	struct subsys_private *sp = bus_to_subsys(dev->bus);
+
+	if (!sp)
+		return;
+
+	if (sp->drivers_autoprobe)
+		__device_attach(dev, true);
+
+	subsys_put(sp);
 }
 
 /*
-- 
2.43.7


