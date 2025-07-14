Return-Path: <linux-kernel+bounces-730229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798A4B04190
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8318F170EF3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4381E2459D7;
	Mon, 14 Jul 2025 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KbnOEU65";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mQ5ABDrw"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1762571C2
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503120; cv=fail; b=S65gibMlKvtwtNuuvuhuYCDtCVyaY16WyN5IXIrKxwzsMNMLlUCasmr0qtxXglvfwZB336P3FOIwjh4G45yfjUtjEcvFvKRYbyOdOMnAroINSImhec+YNVvai5d/qVW1BB2gPgfcMw8jpqPs7Mc+iKZ7aPAe9wVfTodmWzIGXS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503120; c=relaxed/simple;
	bh=Nht3omKscgxFigJ5xfvDP4FNL31+huixt86Kh6E6Hdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M4bunvm1NDNRwnKeBdE3D2pSa5lRmVmNfOqf16UAG48LW1G62mZJfvA/A7oBqtkdWfzc3cZ+/TMryfh0cs4BhezHpExSzTDDsoGSV+xI8ey1RaYbDURt2AC2HMaIupl8AF5bMMP9qCYp4S4+jqvG71JEAjfhBqwzZWMJ2RLHzfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KbnOEU65; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mQ5ABDrw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z5iC031167;
	Mon, 14 Jul 2025 14:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=0WngFmTe3CLCR7WUKH
	ta9Jo1IXmqvEPdbhLwtuwFCqw=; b=KbnOEU65QgqSXOAOES4xhUu0kizk4T6yBz
	2shag7+AfPfmNissIiLBcMVfMz7G4Ez3niQwjdYJ5OTvKtf+5iCWDxANj1uszmDG
	ttp0TZitn4jyF4ICIC2kMJSfWJ8DRkr2eTEZCQXzgQpXMLlQtba7eSCR802MqQAu
	0KDPJW8G4EkoMt/ZCripdvyMT2NIRoOAIu8aLoply2GX2tRQ+MdaXWNXJEX+GksK
	+Wd1RfI1i8omWn0MW/JJ4LSzz6FEBPdUcMbxNJrwbW/HnerJ1TFyyN6tqX7HEiwI
	oJNznyYwIBMpelyMQRTt65YyTlN7SYelw/6ZdidX6bqkjeu5CgOA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr0v7me-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 14:25:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56ECnKbV039688;
	Mon, 14 Jul 2025 14:25:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58kwfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 14:25:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEy73/x+imzSkIJ0IYwPQGB3E0O19WKpoYw0oRCuB8aX5ZcGFSnhT04BbwoTKy95nYn9yEkSngbVNmUyrDMnL3ym70DCDX08udlvJc9zSRe/AjgUtc94TQ8lTo7iNLkdUwVkxpHOungcMWdzg1zEM8NaP3Lsne3R8/MVzO6ZcL9NkqUodzU7Zx4bOinHll0da0nNGUt9Pnu2VO7IdjvFxwQsE5HjS2bkHI1Cl476WLJvpoiQ5/Or+LC5WszMhWyFFw6dONdi/EubexEDAwoWl+X6VrCAT+j0h7xYKrjbzYCGFLwxP8qqTjUCEelpLWk+vIWB5pjEmgjX1YXYfhcgwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WngFmTe3CLCR7WUKHta9Jo1IXmqvEPdbhLwtuwFCqw=;
 b=ViOcE/ObcwbeZ1DROxGXBKDwtpWpB1eRQLrFH1urE97VQfBkUUP+6LKhXaA9RkNopogOWuSz/aLekm3YdVBNcTyKBgpZoLQ1MZ8OLecD/59b1x1CO0HhiQm55aoNsYLgITY97mOg75IMvwBFIel2/e12DlAww9ie7TdLuiijnyamlw5t253xs9t3VPVC3mVZIB4pgmkeUb4to3NgAUujO+duHptclWGvyIStX2sF8tUxxm6ElyErdln+T510NZ6NrWyZgromLFo5rN5JWT8nR6YuWaq16ulP1OCiEGYVvBSe/wX5B6BUf5BQBV6WXRaNzuyMViPCWRbmB++v8IXOyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WngFmTe3CLCR7WUKHta9Jo1IXmqvEPdbhLwtuwFCqw=;
 b=mQ5ABDrwW1a/PhxJOlqbSot6G9qI8Rud5qgZ/o9Yah6kdoGCKNWVOZn+6nsabFVAfxRd3aRO+KdmEyjcoMDfZOMXfHpBPo+OttFUaC9IG536ASQwM6WxU5gIR0K9VnESYU03FYV454DtWuA05ZNKopfqKSPR0eeaJuJ6jZ1Ys1M=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BY5PR10MB4177.namprd10.prod.outlook.com (2603:10b6:a03:205::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 14:24:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 14:24:42 +0000
Date: Mon, 14 Jul 2025 15:24:40 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vma: refactor vma_modify_flags_name() to
 vma_modify_name()
Message-ID: <a4f46ca7-9531-4f6e-828d-256311756a15@lucifer.local>
References: <20250714135839.178032-1-lorenzo.stoakes@oracle.com>
 <ee19189f-7510-4ddd-85b0-34d6319f8fc6@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee19189f-7510-4ddd-85b0-34d6319f8fc6@redhat.com>
X-ClientProxiedBy: LO4P123CA0232.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BY5PR10MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: 47f2088c-9d1f-4f06-097b-08ddc2e22cb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tXakrXtaNkonLCfHFd3h6EPrdnsST/CjImbty7GMKWNCoCBKcnaOHKn0STJq?=
 =?us-ascii?Q?bRPObEbqdrqDh+At+TZt6l90eZmBNFKeZVX1Lk/A3hRWhP1+xJxtVpQMNpSL?=
 =?us-ascii?Q?MoQmpHS1QCtXiZFN0rjFQ97bqECngMX4TKQ8opHrgO4/fv3Fx6wds34hsbSX?=
 =?us-ascii?Q?4Lm7/YQJnxPRROYtXNpoxEbYnOXHst/BhEJ88LacEdgnnDVbUGWqs6IXZ2iD?=
 =?us-ascii?Q?Vv2GfQeXVMbIuGFaWrB99r77TQTzrokNLVZ6d+6Zz1jwEU/VmrvNhEfiboOP?=
 =?us-ascii?Q?DXFf83EJm1LyPtRnVJNcjUVg2JlBOpeMsvLcD09NIOMOtifKuOfVKNuH0uJ9?=
 =?us-ascii?Q?49MGa5pWmVyyE8q8FCoSZe5aKu6W5hJsYjfTVVU+o9EPgpeqv4rQTNQvbSpl?=
 =?us-ascii?Q?oi1e0QCspb1oBPP7OYujUcoPcxQm0M4MbzYiEw7Aq/jBWA7tDl6tFAoa06++?=
 =?us-ascii?Q?B55C+T5rt9ptZ1sUdLJhixAqVLoqe47crq2rkVb0j5Wnkg1mCf+x4A8STGb6?=
 =?us-ascii?Q?OTPVKEw0N8L22OI5RzOVAJaRCZ5hAxXAjCk6s5n9WPC0E7gwfRLuLzbcC+Xu?=
 =?us-ascii?Q?ZKW3SVBRZo9l+bwoGcKB9IBtMBVe8gOrsLifzJ1ut5R6idOSRTSECO/Uz/i3?=
 =?us-ascii?Q?XB/JCrPj9lAobIiyhpm3aqGMqbcV7aG0NW2dK5DbUL9wKP572SzZDhNnv8Mg?=
 =?us-ascii?Q?IpUtgmKT92n9opRjXHbvqAb1BYBkdL9iOfKNtO3+ebGR9vuQLCLt0TWY2eWX?=
 =?us-ascii?Q?iIfDubRFDekIvkynfOyUhE4PsfRiSsAMPiYF4iJUuS/Re0VPRdgtUGAP0B0t?=
 =?us-ascii?Q?uC+iJnQvm+iUrr9ZKL3ZKI5pDVIFbOBZbf/30zKOIYZhAVHNGz2bACPYLNg+?=
 =?us-ascii?Q?RPpRLmB5nDoL/bOpgQxdtRTyz1CgyGsVtv3cM+rvna6boZAE8uy3fGNk0Osb?=
 =?us-ascii?Q?lTDJF/ODkwP3OnTiR2eH3u6zuWvygFDZ0P/FM+oFMaXfPp+2eiKgA6Qu5U8+?=
 =?us-ascii?Q?/4WpdvlzOdvF0GWOt0egmFKOpG0n8AnWhCHb3FJLDu0K1OUdcxs+lryQ+k/I?=
 =?us-ascii?Q?wKNBj13AIlzuuJwlrdMgcYdeikzvVbyF8Mo1yNPAosAJRIT7SPrHw7gd9fg0?=
 =?us-ascii?Q?aIz8uhlaZHi5fin5DpZvdDZYkw9aRshT7QSwdjmG89oPh9KjgyCtYAs6YM1J?=
 =?us-ascii?Q?K1Gm3xAFJL1/F1jzm9WRJ9d8j+Kcq2137/+ILh3hscVxRRxFsD6NerrqWZos?=
 =?us-ascii?Q?/YRYY3aBU6BPbWd443DemLZWwbwrvq3Eq189WveW7Lbn6yMQY3kOYS1fQfKl?=
 =?us-ascii?Q?q71JdwhXhBmF8+qu+OSbw0gWOYT8X5LdhB7czNpIK6L1l6T92GLuVR62MQzJ?=
 =?us-ascii?Q?HJvjkUZ59Z30iMIVgVXSAwbRrU0krgvR6iALOoACWTRJXEoAkKa/yOx9TJDc?=
 =?us-ascii?Q?RuuzxtXY+jA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Nw4OtTQwdNDS+xLz1lFM3h93A4FubljhYqzVS4/FLs7MV3k3MZOlXjSbhB8?=
 =?us-ascii?Q?uxSKfd7iTO2qt9ntG01kKPFiL4XuQ9UuuJ3oYOnqLLgZ/WvTZ7igrrsWKXaU?=
 =?us-ascii?Q?zNyX+s2+Tn43KRFA0qTNPCam/CrSBVWCWxKM96J5WbI4dAq8yTomHHl8NzrR?=
 =?us-ascii?Q?fZb6s687bA0Vy1FMatBIZXA8i3Jc2OTYZ1KKk8VuRlwYF8/VY40HHzVgcVbG?=
 =?us-ascii?Q?pgnXKRQiVRAgQrOKGsN2gYppfSkBm6QKUCbmrftIYXGGhDrhuJyKq0aLVL8a?=
 =?us-ascii?Q?JuZ6WbeOxxLq4HzcTGyqBBaLHJNUt3gJfIWp9IUwdJOsQc+GBppFXdsUYW20?=
 =?us-ascii?Q?8rxeoT+pe0QDIYA+cm6JNBcYKxQ0/ZcDse04HNybYeCvru0qwxjY/onih+vm?=
 =?us-ascii?Q?63vwnnlsb2NFLZ1ZHnFA78g66+WCaSlG9tzIufNfEkOhPPV6dLy2YmG9wnvE?=
 =?us-ascii?Q?zN+uym+MX2306cxCizOzYqUYJ9rw+QaWAOb+BKlwb/UZ2A9ntWbfhHejNzT3?=
 =?us-ascii?Q?aKNmWlRPAZD7K+2fIgd8deNgfwgPxkPIt9zqPa3QozQoEWtDWEIcM757KbZr?=
 =?us-ascii?Q?6CIo58D9XVXQygChlbA5zSi6B7OW8Bw7yKSIc7Yuzv7S4UA8rw5yQ20gvG7l?=
 =?us-ascii?Q?yugi8vl8AIFRIMTGoNZVKVcTlBphQPXhbM+3xHrp0lm0gTV4J6c0P3rrlvKj?=
 =?us-ascii?Q?ZXJl4yrpIRd41fuCl2+7yT/GjKeT+yKtHb8dOigHLuWkm4z2K6yfW3mVp6cV?=
 =?us-ascii?Q?5hzhnbD00SIp1WgnKTiwDN7LJdK4Dl6Evp2xmidiCqkIKksIjezPAdJZlAS+?=
 =?us-ascii?Q?7oCVQKCRTVb/gS+jWkd1idvMwrHyB6xl1azB5BUgU8kuDrQHOjKgjYweHsUh?=
 =?us-ascii?Q?l3K97BoW7wFRz3RUs8XcWF5yGDnYTuJ/lnSwtiRQKpWu6v97N7PPZNGy/1nT?=
 =?us-ascii?Q?Rt+nruQtEZ+rdpaDozrJpXclyLIGtm/rtf2RxtYsjpf4XdaSXToem1pS07zX?=
 =?us-ascii?Q?oloz2uo77qzOIHilSEKcXJPs91jsgdhaBaai8Wb9yTuhfcjs8W7m2hpsfZBj?=
 =?us-ascii?Q?0iWAx0TcVqerN3lYSSE/DzWHOvo0PBFWawlP5GJHQV2fy7OvPpA7IO0RRrOr?=
 =?us-ascii?Q?Kq9pnhIch4qBCduaw2B6ePEUXaXv/J0GGcbZzU5FdQIukunr+K+q3HgfFwik?=
 =?us-ascii?Q?w8G1DTqTx/q0Pth/tvKMHrqQdq/zXmmNXNOqTXqrtFHpZeBxLjrpOlX5svEV?=
 =?us-ascii?Q?XTw+4SO6zAJzUJfGjFRnhNG/1XuFfmmAo7yJkYHxTNQb/xpu1XVLMs2wtxjo?=
 =?us-ascii?Q?JvGcTO4Wip6M6r6nNx7u3Faw9aqTRZSyRvK5XPn8HossnX26R/W+0QlxhrDw?=
 =?us-ascii?Q?nGFVIWXevw++UZvXkxVDHnQ4hj0nS6TCuNmAC68JeDcEiu6vGo9qwYVRg6Tf?=
 =?us-ascii?Q?9dTsicId4w+hNCTCHszo8jtOMd+ynNbV1EeDTXFYTHRLc+5V2Kxg35og0EVV?=
 =?us-ascii?Q?kz6dgankHeqCZD8mskKdFjCYX1dziJhNpKRiXSpcWspclEQ2r/RctetuVpzk?=
 =?us-ascii?Q?5V39Yh53Ovetk7qyqgxFEALBJgPx3gyr1l97sA9XQlhZtIxChkpab5G2pWU1?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pqgNLmh6jyQOfsetfuOmhursbbhkLfheu5E50AVa6Wj3R4dOKzHValtDdxFYVx+U3zKL5m9DryhTKcoeTnLAhtBqjmrDpQT7uoe439sZxIFI2CXBOS82krYpi1u7wp5qYa9bkvn1IHam6+MNXB4SJ8tznbjuFHkDItW/fnkWss5a/MIawSDULKRrNdA3N8BNIOg785eWzBpWjLhdBLgfDFS+jlyjg134NLvHpTBagBRtj/XQEHH1wDfNUYP9yvXGVsY/SH95J59x2+F75wl2ahAdTomFoLviHfrx6INWsg4A4z9Bw8/GS5PjZtaBcl2QMSu/8L7nLipQ09kyTLH5jWx8IVp4shMmikH56GyNT0e5UA4fRXMLNEPBe0Ie5s3zg4MGp5qyAZRtBP7UoUpc6mfjqOQOTvmvCa6QU0ipe9q9LtENuI2p69V1TT6idoQVnXCx3FWpWAke/cyvqDT9Nvwe7LVbiHvtLYAQm2/fStzOGYTRoi0qnYWcthMfdTYydJ6/cs3s5YkhOC9PJi9GhkfV2DRm4oG+VqKGlxAd45c+ZFQdY065c1Hn1Q1WZ+8w3YBBdkQ6gXLF2/hiBaPUbYD9KFPje4p6gmVdP8oPj5Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f2088c-9d1f-4f06-097b-08ddc2e22cb5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 14:24:42.5621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEjMdXi1HVNOtRu1p+vlGJEj14y14AniJASBCBISMzOpKtU7pRutbO6/1LCoZ25pHFet2oNf9wsBFK3gCN1Qjcp5cei5xJNZL9qioqYaMTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140085
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=6875133f b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=jjjkWS363zzBL8K9OdwA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: ndwKbopu1bpTpKvxj48ASqZ2MqQqMWy9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4NCBTYWx0ZWRfXwwMjMj1HFToj n6TgLFudy7kYunMfX5ajwyOJWr+klZpXdvWNq1bpG9iizUubjkUFABdZJviZFcT2b3x2uLgwoi0 myXK5/2E6ZK5y4jkkZGXRryxzm8MONd2bwZEeZLzOaTYf+3vB3Cu76SNPiZZUKv3hCnRJAuOrOW
 h9DWIW4Cgc01TyDe2EquK6dyzq+bmQOnrIbesrpBVwXwiJuE1iRqL5QRIU3nIrMDSCMguttbhqt 0oizCSgdojUOwN7VB4Pzk1uMwjKGVXEQXLUnLcLB97vCoLVllk04tn17iQvZ43Kb35dFQaQuXpZ 9AM+w73pugndwV5b4ZqM3oAq/kiBn3gZOJg5tfNKfnBwM/zehftFmaEc5kvuDOMswHyutaSWM5v
 nEp5OguLtNp5We7koxU24xLdEjX51qI7bWzj6BYYc10hCXWNJIniEk5MZMydCR42grV8aOCY
X-Proofpoint-GUID: ndwKbopu1bpTpKvxj48ASqZ2MqQqMWy9

On Mon, Jul 14, 2025 at 04:18:13PM +0200, David Hildenbrand wrote:
> On 14.07.25 15:58, Lorenzo Stoakes wrote:
> > The single instance in which we use this function doesn't actually need to
> > change VMA flags, so remove this parameter and update the caller
> > accordingly.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >   mm/madvise.c |  4 ++--
> >   mm/vma.c     |  4 +---
> >   mm/vma.h     | 15 +++++++--------
> >   3 files changed, 10 insertions(+), 13 deletions(-)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 9de9b7c797c6..afa9e4db2adb 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -162,8 +162,8 @@ static int madvise_update_vma(vm_flags_t new_flags,
> >   		return 0;
> >   	if (set_new_anon_name)
> > -		vma = vma_modify_flags_name(&vmi, madv_behavior->prev, vma,
> > -			range->start, range->end, new_flags, anon_name);
> > +		vma = vma_modify_name(&vmi, madv_behavior->prev, vma,
> > +			range->start, range->end, anon_name);
> >   	else
>
> The doc of madvise_update_vma() is a bit misleading:
>
> "Update the vm_flags and/or anon_name"
>
> I assume it's xor? Do we want to sanity check that this will hold true?

Yeah should be xor, this is just a remnant of a past age :P

No need for sanity check I'd say, as the only code path that does this is very
specific - with behaviour of __MADV_SET_ANON_VMA_NAME and new_flags not updated
from vma->vm_flags.

I can send a fix-patch to update the comment for madvise_update_vma().

>
> In general, LGTM.

Cheers!

>
> --
> Cheers,
>
> David / dhildenb
>

