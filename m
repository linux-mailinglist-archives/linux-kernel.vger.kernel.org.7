Return-Path: <linux-kernel+bounces-734029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1724B07C2E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F24C1C41BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35192F6F81;
	Wed, 16 Jul 2025 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZYUgn1Zw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uqGUqw1E"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AD22F547D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687529; cv=fail; b=heFEG5hfUW+A/2ShCs4wvu9ns0Mu1f0edyNSkPgdshQclb/VyKanl87DUaDXY7/sYOWeYieZtcgfqWTow1WUQsyvc7pQPIfK1fbJQkJCphGwxznQZLIBH3ChA1ZxrPAHvK9C/BhFjSvVMJdwynhJLhGBog7Q6g/ih6pPRiGWAAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687529; c=relaxed/simple;
	bh=nzUCU7GC4HSG2YzhHgHnFmCtdviAQ0jSpiajTdKr0pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bc6d1pbwH2AhYDhkWJSFu9z/bbqq+WhmZ4xExXeTKEvt31a+ZcCXL2Q1m+E7sguE7zmDlPQVJBMvMlJhBw61q1vUGjxwD3M87V6B15cVPwiG/6NT+Js3/n0iOf4Y+2VP7ZRdqlwrduJMmfzJJN/FyjbG3Hzijz3kIu2C/KNn3ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZYUgn1Zw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uqGUqw1E; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GFqkHF000641;
	Wed, 16 Jul 2025 17:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zDaDtXPQ32h4kk41uQ4SM7EXYw9scIbNKgrxxVCQFfE=; b=
	ZYUgn1ZwNqfTkYfHQEml3gkHcRxdmNYSZH9uHHhEF9jVbmvyb+xR6pJfSjlg/gQa
	4MAflhE7GecW4VXoFXERoocDLZHvYpV3OPZ0yHoiIDlUYTYAaSezFHCFlhlcXiuO
	nzUPKSAlo3FqLS+Jm/YVapzIVmwxF7hY8z7SGezedmAzEWqSxRe52/qAwgrvoXcF
	yAU7B3YZ9ApIjvYzaQdrdVRcYfPF71rY7sVNfrGcUCShQTdDWyA/VKHuWgyLBaWC
	ugtKPy8PybroPE1WA0aAtSnxemK1ndhI9wkf5c5YrHqstGVeslvuToYYVfEbb+8X
	ogrGivx3+Gal09zCbmxsaQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1b1f1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 17:38:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GGjssb029769;
	Wed, 16 Jul 2025 17:38:35 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5bcnq0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 17:38:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wvy+RRIguE95bkMkwYzgcazEd8T9GCAhz+I1rwwBq3vXbkwhtyp0s0QGtPbmHy6j352s9qdMvLpECfZRmgRLnlEQf6aby0/pz+plguJolR6lnklKbbEKWfbcJtaQJwrAx1evEgaZhzXdZ5KSN+Nx4RJoeWzBsr77arSzBvVlxvi4zDOeheUAh+n9YR/9mhjILj3ii2lN6L7HPSPLmKTocyigS0g9AC454afyOqp1EV/ZEFMtkq+U6TVSoO5ko+2SDTZropSf9X5wROpOrHTu+PnIHEUe8Mu4Wrxf+vlzUzlPBDrbWEyQOQo0AJ+zS+itXaKDfbxS2x7pv32Mu2IE4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDaDtXPQ32h4kk41uQ4SM7EXYw9scIbNKgrxxVCQFfE=;
 b=fhQA5AujJdhtdH29NIYKEbX5QHi00Tovfe4XpY1gdGJw9Bq7qUaf44RdJFAsdQLcTii3mgDH0sLDRVt5Fmo0VokBeF0R94+d9PWxSH4CZhlSnMLXThN1abds+xs3hl8fXSavhOYj4kl6IrD9XLCKbL35xi+ndZIdyLxsPi7ncu+de/a44JBJDwGFZHqtXg+6zVF13tH49CvjZq865Gh6VYLuXTbOgq17mfQZklaw0369WHXgZwgseXqUqjHmmwyDNHUMhndqx9ozSCt6wS4/xWxm3jdPOD7PWuzKVHycgddj6Eq2jXBQJFmrc6Wp2ApGnU8vqsSGZP5dRK0bP9WV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDaDtXPQ32h4kk41uQ4SM7EXYw9scIbNKgrxxVCQFfE=;
 b=uqGUqw1EtCKwpL6TSwHvQN6TBQ9uk1HWb5CR2vGRXOYAS//nmIDVkrx8K5fFoYQCPcLcCL9om0X+b4E5ip8TzEMHo7vkc5HOk7wVAyRaNLmtZCG7nn+f7IqXNpa/rbrUy3puH5mD1l3RYIuFZSuPmWDjLZ26EA2+PKLNqk+FO88=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SA1PR10MB7683.namprd10.prod.outlook.com (2603:10b6:806:386::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 16 Jul
 2025 17:38:20 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.8901.036; Wed, 16 Jul 2025
 17:38:20 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v3 1/5] mm/mseal: always define VM_SEALED
Date: Wed, 16 Jul 2025 18:38:02 +0100
Message-ID: <d0e9b39c9d1abceb0ffac341c6fae96186c5d843.1752687069.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0460.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::16) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SA1PR10MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: c7fba4ce-972b-432c-2578-08ddc48f8ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eT/qLmrP+vIfuR6iR8IscYXjDHUWbU/gaxaYO3LdQvvUlFLIfi4dS2yynHK3?=
 =?us-ascii?Q?072Vf+ldkpT3G+6jIOoSaddkt0+U7mbYFBwopI0hx/455AuML4m+l83KMRyC?=
 =?us-ascii?Q?atGO1Kdx7umDKb1xuaPj5pBXwrf7CAea1Vzklk82Z9l5Ryr4cDxS/kbLizi3?=
 =?us-ascii?Q?vLmuCDIqTyrPc/ZXP2nOFeg9DelPIQRJ6wPViM2pmjBuMsvp00lOkTfq5m+z?=
 =?us-ascii?Q?CnVkxpI+GVUWwu7isGk54sG05Hid580tRH4Q631WvBc44w3xvJCIrJd8L/T2?=
 =?us-ascii?Q?uecB2c8OlVBiAt2n6X99pgboUeS4keLhG5xPmN7+s3XcMoQxvWsyZl5CYgzW?=
 =?us-ascii?Q?bIuJX58xCdUAR7K6B6f6D9PgNSQWulzR9iO1z51aRPHuULJaRsrCmXN5DdVz?=
 =?us-ascii?Q?yEIoPd4P2t/5NNsJ+xwQffbwhUBai1isxB3zgeNY3+uhIeo4A+MEFt/gFUu1?=
 =?us-ascii?Q?05ywBIjA219BmcnLWtK0giCMdVbikZN7H4DrFXGbzaE71wmZyeo6wm6uepCo?=
 =?us-ascii?Q?6JZk0dAhzCUM085jOxX89BgYAR2fJwsJ2LvUkse75CdSd5G4Wko/NQ/yQTfE?=
 =?us-ascii?Q?E6Z7OS31Gwh1+9Sq+zoIGOxjZrVLHFIphBLbBhiNTT0xnt9tkKOsGzZt0Wc2?=
 =?us-ascii?Q?G3w5PLgIB6ekzSYdKmxtUT0wYqaIwtJyKB8PqisrfyO510o2mQ6+GHcmGmdf?=
 =?us-ascii?Q?rINm394sKbhcMKAQEJEBI+ZVJTKJ9E/eDqacjRQOtnwFwMUl+EQh6MFd42lE?=
 =?us-ascii?Q?4pKI6NVwi6rSFijGlGf4niyW+BGJ+1rIZ4eEEc2xhrpShEpU341nFVRXAcrV?=
 =?us-ascii?Q?/rfejbAgZs+ySz80JwNR4nwz1OKWBaulvIo4RoHu7v1zOZCzf5Ys146xFREr?=
 =?us-ascii?Q?elxMtyXFlalGvbv2mGOoY81NMQWDhrak4rFw+Z5mDnl62Xqe3PxDQSKZSCFD?=
 =?us-ascii?Q?IdGJwQQES9LvSMwli3cqAxApGUozgd0Tekt8wdQwQB8cwx3HnF8D+35qoHJ/?=
 =?us-ascii?Q?8WzxY9vap9fNj1rnrVYxMhRZZM/iZaGqZNwqpsvRtwWER1AB/aCTilr3Mx75?=
 =?us-ascii?Q?AwgrvzVbfSGfyBU9m1umxOT335kCfh7W2GVXGNW2q+5SWpHraW+iri9q16Z7?=
 =?us-ascii?Q?BQtcn2wYhNSdfXd4NuC/XRqE4SUWLf28OFHz8v+p6/e62UYxtenkrsFvu4IM?=
 =?us-ascii?Q?iKjKXi2ooGbTUrWVaz9PCVsj0uhD3jFgg2qTjU/PyHtiVru5NHk6nUWhlN1p?=
 =?us-ascii?Q?uqyKWl1W8xulGYVliAmviLcMG8E2n2ljPhDFlw37zF2a2oIH3lJc5nY6cAAt?=
 =?us-ascii?Q?h23J+Fzmfvlkf1FvRHZ6QL0RqffEOpyrwOqOdC1NkTcGxoCK8t/LTw2PEWvF?=
 =?us-ascii?Q?vtcjlwfJxTH2uUPV05+Uf+b3BclF/vt881E6j0Q2gjCcQbPXWXbPNBIzkOLP?=
 =?us-ascii?Q?hmPdRn0MJDg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zl4TMG36O3CCAS83U4+NVGdJ0Q+4J95P170xEKL6g/tiYZfGcm05cAdlX7di?=
 =?us-ascii?Q?vZuKmFwygu+jUtBrD+gZlyCPTJkT5zHa5IgLll8mizkRcicvwr77XVhyE05I?=
 =?us-ascii?Q?/g2UszDWBKAI42Ts7CLbxMOHfPlb4NCl80NAdljfxjppCiyQENpW1AQsIiNm?=
 =?us-ascii?Q?ESBU6fK/Xx7OMNFvwDvFqLdspCojt/d3gA9Ge3UzK0sqE7LEL2cFBnItmTsY?=
 =?us-ascii?Q?TmXBXBtIxV6J7LdeGFXuMwIBiRUZmhKV4xJ72Pk1n4/2eaSUo/mKIYW2FzO0?=
 =?us-ascii?Q?uLbqCbMrCD1AZcmqAYJexUPTsw0Aypcz7SNh4Hn8wW4wrqntGEW7HFCUuB34?=
 =?us-ascii?Q?Bg6oBDC7v6mX0IN8Hpi+y1rhrxZg3YHizIsE1Lwo0YbPkxHP/OYQrbSApb/3?=
 =?us-ascii?Q?E/Qc4fi3VQdvzoFWU6AA23ibpwc0irUrf1jR8l6RQkSr7wRlpcuKSjdlyaZb?=
 =?us-ascii?Q?11NyZSQZcdRnXeQ5SCBPNdbd8XbreAhUU7XBmgGI0tan4LHQ8MIcaB1s/ReC?=
 =?us-ascii?Q?F+k1SKrF4fj80AUNyeRtYZfYbxmwbphdxr/szylJ6I2ySzIHfl1MYIrnrEsi?=
 =?us-ascii?Q?aOJF5eguMCVMtyn/PJRJW4haK9q6UdZwXQ2rZE0x34HeG3Ach7QgYEN1mwua?=
 =?us-ascii?Q?1Sd2t8pFwmmWzn+2I8lJWIOhgPhzoNgk3L7hGY5PdLhhB/WiNwVDGAn8nE4/?=
 =?us-ascii?Q?mnmf7CaOfIbPCDqFpgMHsZ0AQaAwg1AMyVsmq1rVOkeavttTG5Q43GsCJG3a?=
 =?us-ascii?Q?5AaK1p7+s9TXymNTFTwiyLTFIfSnGtIsjhRb0AyKjQOS8DZeAM2H6P+lqZyd?=
 =?us-ascii?Q?o5aRAJsizlwibPXtovqEPswNQu/JDYbQLkQmHgvj+5LP46ifFZZnPf6vfJmq?=
 =?us-ascii?Q?VTP/FQDdYtvbaxaM1Rmycx14b1CQNY/TANYte/b2QpzHN/NoTe/Fof8JMTMz?=
 =?us-ascii?Q?XllhvZYTXcncVCm+O0iDQPHf+TLS06BuGBaI3AknbB6P9xJA54lXI8y41n3V?=
 =?us-ascii?Q?UpQK2fn24KOrBRfJ8bCnQEJV/wVtQwTGvdsuXxtqHjbOdPhFDsLuyVETmogj?=
 =?us-ascii?Q?WXRnIammER9g302IMHcrFupyXku8M34lPHF6aDdn/8Q4LAKJFW0JhK0K2BzZ?=
 =?us-ascii?Q?R6Xu01FADlzr0h406Su2uNeL3Xiggd7I75ZPOpGkud/2MSiagoP6K+Sus4iK?=
 =?us-ascii?Q?nIFALKwrfsTQWZcNHvdzPQDMvRFL1xq8DNB8ICM+6MX514BXrkYYbgOrozLd?=
 =?us-ascii?Q?ELtnV7SQhtp7KIkjX3kln9wTSEd4xGNrpBU2UuDMKB5oknHc8e0PGi1aPagf?=
 =?us-ascii?Q?ncqAVSjI9PB1S458dA9zc4ZLDk58B/o4Tt8QQMCNONpNtXGxTTHw70E6+mhm?=
 =?us-ascii?Q?M7CcaUWS1TggxF0Mt1sgn4oZLspgTgQw3lQ8fBmqGxgfjfm6z0+anBpZv7xZ?=
 =?us-ascii?Q?bh2qp04hZaGJlyHLiXFsuGP2Lxam7wetjZ8joSnIHb1JcusWkqthit780ukV?=
 =?us-ascii?Q?f16OGsCaPQeJ76+YP6neZVvLdDmVqFvUG7QTfzWURa0jlkAS67WQLjvQnk8e?=
 =?us-ascii?Q?rLpiF/wN6e989X5YBA/Qg/DDd7V3lvUHxunh/exY3mPJyvBaRQBbvzFtjKR5?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BlvNCTajG7zNnfQ0Y99OGhhtUSfM4frVF5FjqzX5SWiLX7kuDdpS8O7mqyGmo5lQhkMnaW5p2dA6xhSv2qRQ904s+IWAI7sMsk5xQkXxdl1LsN7a2D5beIANuCVxuGr/TxhVYIJ7pmX1yv/CEK5CgPRyFltn3x0i+PGEipOxryArj4NJvZRDjUe1PCVdddAO6yT7GkIGbpDHQUlPQjlak9ADMSkhnKl+mgxnYsS+SRiT+8Vt2whuGh9qZ6lcNTv61itylwdQ2r1yGtr432CgYh4x6JhqYpNyEbjWF3Fr8GTClgEdi4h2IESXC6agSRIaaLYMrEDrxwe1hJY2SSN5GKwQ3SiU0hJtWL9AfTIPwqTzBnxUsCStuNbKH5fpkeQS3PB23gmxOOBOBCXoTPwcmarEzyVr5DQw2EfaZ1lmKq/vf+tLD6tfxMRBU6rEJtfvWdElgqQAud+domKCcmY6+kvBgLoVgdawLGUXvEc29H1G0D9s/dI/V3uWk4DcyfwkHKR0OUJvBRuTjl3HZKlJtKe9XTAL1RbYqBRxWFN2lzxXTPZbFrWxf0UmpesZSvpG3t+XqWDZyaJO9/vAvFDqsgflZz0xsJBVku06fu1h82M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fba4ce-972b-432c-2578-08ddc48f8ea3
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 17:38:20.9349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BChVz4UwqDAAcnfCf0Wmd/F0ClUTaZ5qKwtcNlw2JdbGM9u9F7Cni/kjRHbIxJ1KYJYmSrcQMP06rR+zguVCr9bewyK2UvDhI0Ni4O/6wSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_03,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160159
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE1OSBTYWx0ZWRfXwmJXwLsQd6oY DbMMBOBLdis8Bp+bTIU/FWj2ZxD8fvw98zqO2xTOeUM2vUk978miyZ5tLsz3VmUizRkCQeYyYuv TmqGmdy16R+WyObRu27JHP09//yhuSGeYfdfv/LcbBYqfDuQGodUxVyeXPYyYuDEjaxdxbTXRao
 vs7Ki/ehN3/y7n5r6yXkhS223JpBjUC2kh3hJEVMTmDilHwU+/pT4AeMHYD+y8mzHijeExXo5gE YRQFpx7WHI37vVTRIkemvtviU1pxzfAYYvYRQCoaDf84vFVpeG8A41E1yNYam95MbAR419mYeci 24cx6CPg5pspDv/P9AvVAz+An0NJHcQCWWYos1bCrNF30XeDJrRNis/86j2u3pZ14HM0+brgJTe
 KFsZ+gBZmLgN4MGAIyzcjCH54KH4MB1xIDkTfzqh0mzqeuZ2Qx/AshB3vAbMxeWo8ub6kP4X
X-Proofpoint-GUID: HqnL5JOddfo689ZyqMqZS29YPzdNkj2Y
X-Proofpoint-ORIG-GUID: HqnL5JOddfo689ZyqMqZS29YPzdNkj2Y
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=6877e39c cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=gxeMIzJwE0WXKCnSo1kA:9

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
index 805108d7bbc3..fbf2a1f7ffc6 100644
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


