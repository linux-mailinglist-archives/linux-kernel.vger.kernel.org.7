Return-Path: <linux-kernel+bounces-745434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282F3B119D0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0749A3A9D2F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02872C08A0;
	Fri, 25 Jul 2025 08:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K/H0/ibA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iQE8KlLQ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4563B2BF3E2
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753432244; cv=fail; b=bVz0PafwwMFyhfWw2jOWobWGyrdW79T1ERYgIonKWpgfI3TXHlThMs01XPn5dXecE+8rWwp9LixajUlOn+r7y4+tQhDvSzjMKMsP5Yiu7wyxB4Vatk9jyd+oh82HgquYdPv9sKX1dc4phVMm9iKrw1m3dU9XWPIHlC65aOL93/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753432244; c=relaxed/simple;
	bh=Zw4d3i9wzd5z+lh+CFDUYn8l8KuUnQI9pQ6xFjStNmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SPqThlvChFEEiJVKKHQn6QsSQMv6u83MrH9GF/WyUsRsA0+t+ajMCbNjiC/q6SPPp5uez/aqjNbyEIPd9+BONTbmrCij7wccDQBvszrc4rqoUgHWAoyd7S3NLwlQXtUwQwk5eCJez8UIxAn80lGFHPJ0vCe+McbUAHSFqEK01E4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K/H0/ibA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iQE8KlLQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P7fwCt005985;
	Fri, 25 Jul 2025 08:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=G1zeGnCTsRdyomLkvxm5D+ochJWQTSytlYVuY5dVXGE=; b=
	K/H0/ibAdNo30iTy9vSYTmQZqMFnArtpj4B3vsZzBMqFCARqgt8iIQjqk6qEI/2a
	VVDkb6uNocIpjUTLaLslBhqD4+99VSs6eYrd6L1tb8czmivaRGLveIm6HcSXrVoJ
	6vl5UJ3ESAEk6Um0+PdOb0JRG35nYzsZbCnyU3rXo1y/bQO0hZ6CW9AMAUzpAn5h
	gnDJlBANXvjHE4Ns4RPkd9Y9cUnkuiPwmTG0coFrOQQXFpvnhmVg/Dhszim1UYO5
	wjn1T4vyndvm630riqOPVjFzMLra3JS1FdS3yoartGrBUrYRa8g3rcwX2xmQeiJc
	Y18Ixxc8knYQBwV3tIiBXA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w3vgm8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 08:30:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56P6NX87014404;
	Fri, 25 Jul 2025 08:30:19 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tk5gfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 08:30:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bas0wmQCyE3y+Mi1K6sssuWQoq1G9i2o4CUZLVJFNaW2ly890SzYqGQH6mWMRza9cBvs3cEnusjnqzeNg32+j6B9gLMwU3l5B4Ium/eGSl7G0SNRyA/aoO2YyX4NCYaoAGUnvoJsDRlz1WZE/iI/Ce9o9NR+dU3403U0lWoqchxrrqIfaMwcmr8kZ+2dvheV9xllv7mmF9ciciSaKd/MA0g579BkuyTWNlfAEajq7LzXwJ7q1u5yd2u0Ch0a2sup7gFtgARwWctiWj9JdjC9TFvkB8vTJgTLkUiqFUC2b5XLRWPE5ZFnC0r2DYkU53z8BH+bpR+Ox2UvDYKKhFKHag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1zeGnCTsRdyomLkvxm5D+ochJWQTSytlYVuY5dVXGE=;
 b=viX1/CitrXsivPO4dwWRjq9Kuxnqy0ls192W0NrkcCsTXzxDxc1BmuNyb1oTrARWw0/LAd4UNiiiO5uo4cx+VWAaeQkbjuxnLiYwRZYCeHDtZlUla3XryMvYhmqc3IS8zpqgnDIwrTjfCwGsTxEoHQpyQ3RLvQsr/GLw9r00EVEbpvdq0KutcRhPWHBq+1VpDs1P49BmHAx52jgfc2Fm4+5PolFcFETFe7jzXu2uac8hQS5YuawtBxvZ7QvaeZYYWvN2RuS13YsOR3upDojwaOgqepFvPIf5BAPL+J2GdSA8ncO/7oTcA6O7erHuPnlqm16c2EQVJmbbydXYMlfibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1zeGnCTsRdyomLkvxm5D+ochJWQTSytlYVuY5dVXGE=;
 b=iQE8KlLQUgJ3mTHq79zpCObVZvBLsGuwy4KFzBBF5mEQD8J6CDXJl+C3RBNksz/eHIgcatzEofHU1ubgDmQOY8wxjRLtRc+JZet9QzDX6FVqpXVKHugD2Qw2E239ybepAZD4Ykqeh3B5jLA2bndjOhn3T+jQfAPNEhROI/jpBYI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4717.namprd10.prod.outlook.com (2603:10b6:a03:2ac::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 08:30:15 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 08:30:15 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>
Subject: [PATCH v4 1/5] mm/mseal: always define VM_SEALED
Date: Fri, 25 Jul 2025 09:29:41 +0100
Message-ID: <aeb398a77029b6e7377cd944328bc9bbc3c90537.1753431105.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1753431105.git.lorenzo.stoakes@oracle.com>
References: <cover.1753431105.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0315.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4717:EE_
X-MS-Office365-Filtering-Correlation-Id: cd4706c3-0cd7-4771-d8a5-08ddcb557af4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h+HoPfE/wMcANx/UgyUPtF7pwYZXMvKwLuqlbW/QC1wmTBXWYLt7X6S6SP17?=
 =?us-ascii?Q?M3A58UxxfjfruYmGP6eVl4cGDMfU5c6qy7YZe4ovQSJuXbHNC+AH/wcyyrsI?=
 =?us-ascii?Q?CIEQYQ5mL0rDznN24WMt1BqUhWG0CAc3aLJlW5iSOKn2wx4kQUv0T6ys1hbp?=
 =?us-ascii?Q?QwN2RwWT5miMTlweudBafgMS3vLtk4IRfomX3Np7SdxI6U105xH12mdjXehp?=
 =?us-ascii?Q?JAP1hJTeNtZip0BAaY3T/Zaebj44YFRF33N8wLtw002/lmK6awai9AbRbFWW?=
 =?us-ascii?Q?E5skqdgH+eW6zJYXoqOwo3zNYC9SkAaMHZWvzmj2Lvyw+0ic4Qx8LkDQSlaQ?=
 =?us-ascii?Q?OUmq4brpZIFFABpBuROhWrTId4XahlhW7bdeWyV5BBCgoR+NNu53IrXIxHsV?=
 =?us-ascii?Q?+vkGikZgZqBGsXFi77jeDZ7cdE69Pmak67qFbjzkeV2heb1ny36v8QkeYngZ?=
 =?us-ascii?Q?WcNbbpGrGsWXGZeL7GjMcX+lLNefDauVqDepX6AfRHx8Qq2aesA4iWBfjMDY?=
 =?us-ascii?Q?Y81nHOJLYu3nzNu5Ek8CVcfazTTkm1QPkRNZ4OEJyPg4FHkQFMhactd/cYXj?=
 =?us-ascii?Q?0cFEiBQHBxiu1SQ24RZcnmPrqH+PYAZGYskkw+k2AyEF//ywdr8uYXASR7FT?=
 =?us-ascii?Q?mbWUCsjWLeQ2x9+0EsQEwiX+fdiu4/6puHM346qg4jMJgiO+rUca0lDJpNx4?=
 =?us-ascii?Q?Dy+whfijjMl/aQylglS85F9ZSkD49actcZY4aROjxR4wZUcDH7XuP7xQ7oaC?=
 =?us-ascii?Q?zjlc5L0jZaLoU4Pm3/rn2UUqWr6r8yJ71NXbfrVb4Gz9RyrYtsGFlj2sKPEQ?=
 =?us-ascii?Q?yifGp8wK3sdkMPi2WoZPvPpv/5VTUO34G06rJyI4IgOp/CjYfo/DO4EzexXC?=
 =?us-ascii?Q?ctASszpeZXYNB+56KTcGRrJjm9ZhEaDCtiqHB2WsTqpKPI/jLkGcuI67U//V?=
 =?us-ascii?Q?rPi08xzEMK8t3dcViW4mL/gNeXbPO8OHslZv7sR2naNGqSWNxtbL7fIPEIDt?=
 =?us-ascii?Q?Shx+tW3nLdEf/YvxN38eloC3q4RgicyGu++wjIiw48s7seo+OZy9INTzLulZ?=
 =?us-ascii?Q?S3v2hI4bss8SRMD57nAofDFqX7FSu1kxPrN1OHqvMAPhn9k37w6ockXL7H5k?=
 =?us-ascii?Q?ktoRZBw6c9izrB2KAL/TphC7PNFq4yiGMB/+WsLT7cHZWEBfTCcPmyzG5fZd?=
 =?us-ascii?Q?GhM6le2ylye5W6eZiqsXKHXRDJjxMHus/XCPcksXeScNthWQMJnDae7Nei7d?=
 =?us-ascii?Q?9mnuU78MgEf+l5bYrS5riYyxXqWYU+URcqHtwLKGvKmoRnwhOR75pF7OIyJd?=
 =?us-ascii?Q?97XdZ51zU2yDAaGtU8ZBysd3rwL3DFN6hg41BOUVG4JUJ+iHD1FTmRHygFvN?=
 =?us-ascii?Q?aZ1XDx1Zs2/Ktc/yW8BsosvDtmstiZSTtlF4nXsCu/Av9csQQmjtS9M/G8nW?=
 =?us-ascii?Q?eMi68/6cLZs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XU4W+Wv37o1kQP7ispiapUQ8XUEk2572r9WXHR8rHEKSNZ/joCIfOGflrL/y?=
 =?us-ascii?Q?0TUJUSboV7ByyBZQHlRXDwIWVuGjPa38eKsCzY48fsymXBtIauWH5/ZAVyq9?=
 =?us-ascii?Q?Fl7xRpMj+dkiOhniQ1gmh5hi6PWkah71RRcggAuQNhq7chLsTtgnZARAlKVZ?=
 =?us-ascii?Q?DbVpLzmgFw6ig00s0wNgktG0vO9CZwh+Ea+Ed++xEc3RUK/l2O1mJf2oPRqo?=
 =?us-ascii?Q?4hdnxnN1VQK+xOELbKXqUIlHxKRcaqw0GQnrioYfBGVkarTGXDL8UDHzXlRh?=
 =?us-ascii?Q?kVu/e4Qo+c0+F0K47VdRd/uE5xhmIUpyBVFr6cPBtKl5hZdxwULllt6gteBr?=
 =?us-ascii?Q?2pqHUO/1a9rkNoMPD26Iw0PA1bGXPTcSaHsUlVvgJ7v5jsOej56h3Df9ZqE6?=
 =?us-ascii?Q?4dgUTiHybsiZctBYB7fI9cryjsfp3ZNG2ChzY/hXvkfx0GlQ9iuY93gmvkXl?=
 =?us-ascii?Q?Cb0AK2FP9Qlh0I0ZduJ0flYySlhFLxXQZ6Oc5aQIh6liCLk/ON4Lwh92mRU6?=
 =?us-ascii?Q?aR1vFd0g11Q1dIWtpha3KHh3+97XZr6ziFWh54+rfIkJliVEGvp34k5lePUZ?=
 =?us-ascii?Q?QkrPS5yX7g3VstOCmIQj8rhuC47bxOUb3oFEDWjheQgnxZFXZzcebYarmEq9?=
 =?us-ascii?Q?e0LkBPVa16dqwg/IF4wo2b5MQjp67DrPfyVdd8Z0gAjmp0+PMPmgAhREGMDQ?=
 =?us-ascii?Q?biZFBxE8FbnLeSSG0dTR3+Ta8YVdvrJa8gwWQY8rlctsbl4T1ZzlsiSzCgO1?=
 =?us-ascii?Q?X+VvDp3lVpRHcA+z8yc3SIjDASXUbcVR5v9bD3zxroNaguiYOk2ON0XtNPWx?=
 =?us-ascii?Q?Y/K+1PZC7TbwCTkd357GLnsmtQEod7I2lRZdV+2zKpNIQko19iRkrLP8jeFb?=
 =?us-ascii?Q?oWQLLLlaCA3/EAeNZdrLDHn8tS7MYUbbi2tHUt/vX4Rg98pPrmsCftOC3hJa?=
 =?us-ascii?Q?IHDs9tDWjXyWtmp7/c1KbAt3FX5lCzWBwtTM68FeM0ZStFebwYZkDsuO1qtE?=
 =?us-ascii?Q?9QwcrQ2h79IQXXZJtbDoUqkf8bUkl5p9OIRbFKSRxhl9t2TsIPJIHL9I+sTx?=
 =?us-ascii?Q?rcXUy8yib7OPVF+nhMsvAhZTJNjhgEpUMxsTR/btI2y5pK9Q/wuNZvMijIRr?=
 =?us-ascii?Q?kVSyaIKIB8qoX6vuufv/TZaQvFH+fDg7AmYRhQCkM+1k2fXNZM+2Ams99bN/?=
 =?us-ascii?Q?+3gdoYKXF7y8lAcpfTnySH4zJKLEbtNSwTzbBm00hpM7V6hbCGVJQxXESPRw?=
 =?us-ascii?Q?GULUGX+FSkOFI9bh6JvrGTXxtE4iQ+4ZrXz7ph6pBaKtgfCXiOp2UXToTCpo?=
 =?us-ascii?Q?Tek5Do7tFh9UmS2uCQrdEB9eoUyuWdX5GjZQ+0CbSD5SD/3WXXNETVomsphK?=
 =?us-ascii?Q?HY9RQnQFC1nRsJAw6xrn6vN0qrYMgLNxJToogmG78JZquQZT7WT7pbSfh23L?=
 =?us-ascii?Q?FdsBh2jdXu2eI7teZ3yd5Y0SEUkLqVdc8eRjQl/WbZ9B99AKfCXHnBpXPgNC?=
 =?us-ascii?Q?+2fw02OaIHsxSWkWOK5BJzgBi7fExqwSqZQekulNn5HAZKDkmGz4YEBqToUD?=
 =?us-ascii?Q?1k3IFpYAiX5ACJHYirN8E57Ja1WWHw2YVEexvZUPyi255yyrRdv8bq7xpct0?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4wQTtoxSObvgYvgBsSj7sBSGjK39rCJciFgGQ4AhJ2m14m/KeAyW9DAhBXRudDm/T6MwSaWmg1rXLLPPr5R4o+2FY9gRFx/clpKtAmnGyms2HM/VyRM17lomN/MWCtD9TJppQRNsxRAWwh+VOHrYBkylaN06TPmpx44CAvPz8vLzvzCYUm0V9gh8Rx4CogPHocM1h7+kYlewrfwkK9fjIkMuq1nnEJmysYG+CUhJgF62Tc5zzQX8Rt+M/wXSYcEGMX25hXLyFqOO8xlANWgbvURFFlAdsbZnk2YoM2FhJ/BfBTXJ/py3YC6gvTaM7Hd989QWB9JNzeBTY5LC93Ou6M5/Jvu/X2stRegporuy117Vpi1s8TXjNkrXJmSviilM6zJF4bViIi6dSJt4JxtOntdBYil0ov/SyUM/4i9uNx2V7qplMmNY46Etjlrvnfr380uGFZtFiSiNzQAqafi+EhU18URai+JvRVB9nSE0ru15jAjxEkxIUgMS+L8JezciFDawXOMGjQY/yZILToVebaxk0CFG9uJ2SUL+43WbKJ/xEuaw1BxgUCVwc32bVVDSE5lpDUnrsmc3aINQ0Kc0RU2uVBg12zZf/BBvydvG79w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4706c3-0cd7-4771-d8a5-08ddcb557af4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 08:30:15.2841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwt5LwuCqCWbu5XeQgLtqE4g3ohI7vx3C6fSAQVXRj0QHk7iy0ujWW/TrEC4uMbheCVXnYuWBI9CwVNqdcUwICPlH5q/V/F+z/LCJsDwI0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4717
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250071
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA3MiBTYWx0ZWRfX7gC28fIz4UzY
 ijEP7aO6GK8xt9F6qBCvhzOSpnIaJ6XCgYEcGxEelpHUbzHmv/WHiyQt4PanPpkkW4/cCWv8+eN
 wWrtPfyMC8Et7xYg7Qw2v0nriNnk8QlJDceYsY/UFOxeIuQKbZ7GQO7iQzq3sP6WJEXx+9PQenO
 6QDTettdwlnJN/op7FuwTi1If2SD5l5XDWW54GPVBVkj+9Gn+GWGjHNztvL+Vqcfmd1syJXAVLT
 E9MAkovNGx0LTFCEKfamv5DGCDtHEwDw5QYQna/Feiy4mrOc+7V+IOoXOCRky0oWkcni7ovzwyB
 f8JTqgqx/sRpJneUN4igZhIYmAISHzlmQhbwY+u+R/ieJptUwmymZYjzAu2kNGmJZ+xxCQTcaA7
 GUV+hyLYosWNYqUFIALJnqElK1Ld+WZTX1YbNamMvaN3jRu+D+AZIEn4O3L3/eOGBJl0HF6t
X-Authority-Analysis: v=2.4 cv=VqMjA/2n c=1 sm=1 tr=0 ts=6883409c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=20KFwNOVAAAA:8 a=gxeMIzJwE0WXKCnSo1kA:9 cc=ntf awl=host:12061
X-Proofpoint-GUID: vlEOMA8iSWajndTq6WqEISj0iFwtl2qD
X-Proofpoint-ORIG-GUID: vlEOMA8iSWajndTq6WqEISj0iFwtl2qD

There is no reason to treat VM_SEALED in a special way, in each other case
in which a VMA flag is unavailable due to configuration, we simply assign
that flag to VM_NONE, so make VM_SEALED consistent with all other VMA
flags in this respect.

Additionally, use the next available bit for VM_SEALED, 42, rather than
arbitrarily putting it at 63 and update the declaration to match all other
VMA flags.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h               | 6 ++++--
 tools/testing/vma/vma_internal.h | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8e3a4c5b78ff..ceaa780a703a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -414,8 +414,10 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 
 #ifdef CONFIG_64BIT
-/* VM is sealed, in vm_flags */
-#define VM_SEALED	_BITUL(63)
+#define VM_SEALED_BIT	42
+#define VM_SEALED	BIT(VM_SEALED_BIT)
+#else
+#define VM_SEALED	VM_NONE
 #endif
 
 /* Bits set in the VMA until the stack is in its final location */
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 991022e9e0d3..0fe52fd6782b 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -108,8 +108,10 @@ extern unsigned long dac_mmap_min_addr;
 #define CAP_IPC_LOCK         14
 
 #ifdef CONFIG_64BIT
-/* VM is sealed, in vm_flags */
-#define VM_SEALED	_BITUL(63)
+#define VM_SEALED_BIT	42
+#define VM_SEALED	BIT(VM_SEALED_BIT)
+#else
+#define VM_SEALED	VM_NONE
 #endif
 
 #define FIRST_USER_ADDRESS	0UL
-- 
2.50.1


