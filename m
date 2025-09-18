Return-Path: <linux-kernel+bounces-757144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED407B1BE47
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5DB1897F7C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E84A15746E;
	Wed,  6 Aug 2025 01:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VqvGHgUG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C1HVLuZ4"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01D328373
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 01:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754443569; cv=fail; b=pWW+zA640DSfiZr/NkT9gSXw8mNIu0s/kyF8xNSsLtk9xSTPqwwsrmrEytHqL3LMZmwdE8T0QsFHsBli78p0Z7CQERgzmM6AnosZ7PR4h+Jda4KTz1CYi6Lzoox56mv8WrvXDgoPxYLwQ3gzVfEsfakVowet8XwABvbCv+yKVrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754443569; c=relaxed/simple;
	bh=/d22gb13vvphVQuqO1fsEHnDdBASyKEVkz/Kqqzqwp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NrfEcKGY5zGcua3kwUt+5+KRDP9eINE9OTIqSQmCJpWssICeyduOn5BRG42cPbuSXXX3SrnTCLvgLD7KxgsFNe6uL4FgtZwY5wZqX4f8yUucPhFalD7Yz/c/6ozGXHcKlNyMCOd00b9ISABAgs01+mE+H8huaHDeJhldWHrn1cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VqvGHgUG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C1HVLuZ4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575LNBCU025753;
	Wed, 6 Aug 2025 01:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=fKXqq91Cm/z8cSZJXq
	eItCifTtPoAMgroC7/sJLFAiE=; b=VqvGHgUGIIy/SCyjYNO0YE59zso9Gm5IMi
	VUGXyDhM50MPJcZbxOehshHOhzR4BGRmU1OOr8nxE9qgYWJHs3KjLxYWo/dQlcuI
	YrC9oZqiGvopunNFK8hoNnGBdGZ5+K98/5YBJMsWwsM62F66/BKOatdEcescZFYT
	tOlaKY9o4qW7iUU2AtGAho7r49tQvQqcZGP73xDLHz4/acI2whPGXGL7qOYjNjLt
	TgoHjPFoLxDe4F0ksWeU12Ouhd+cIxE4M4NgP4TYTN0iIYjGYynFdW5u4qckimxV
	+LWjtCIl4TzVHvfiycI/cR6m8QJag1KaJOmb/ESxzCH1kBxngPIg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvd0k3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 01:25:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 575NNSPj018396;
	Wed, 6 Aug 2025 01:25:31 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazon11011068.outbound.protection.outlook.com [40.93.199.68])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwqch13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 01:25:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drdC5Bz/XM6TFBvpHo6QHGoHjPgwpw6HJ2oc5Ycx6aJXjiQ1yk86DLRRLCA6QSjCjmo6kEYbk8q+oC4Oy7G5XyM+/pR/1dpczvxsYdflBndrs4OPTTNpYyKQ+6+vm7VFOSt942EuWDRt4gu8fZKVhzkjUJCqwk05LkZiSiv5ZMNvgRbdF8xes2NVMhvEf+NmlzEDgFiWfWPbk4Y+gqNq4y6QBFDb3XzPxIcLpoXJjpAXaBYlOi7i0WMVyXBB6i9u7FOBsDZMYVRCRh3MFfhVPRdv3lDgUJEiDQ4bMTzC8XkUmPVl3LM+9Z0mqbH8m1d/w7sxdM7wDHTTOLC64hbnlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKXqq91Cm/z8cSZJXqeItCifTtPoAMgroC7/sJLFAiE=;
 b=EnKxVv03Iqydng5JLvDntukq8ORMy8c03j+uOpkhVJrRE47MYXbhZBmmr4Q2VHvY/pB9b6XaPbuWOtce1xjwAq4zu5OAjW9TV5iwtHU2pHtpupNoMtACF2GmWsu9YAFWEFsbwy1lTp4ceajzoWTlYg9lsiXya0r3WxaIGsM2jzv240l/8zW+tlZYcjqAuLO84HptSaFVkx2v06zRXt+KcsNjSuX1/9SdyvfxVHE3dCACvcVZ9F91uX/i4bAo0XHB9BW+QJVN9/7eOJ0/IgfJEX7WWaUgMLquGEaj9Roe2v2+e8F7dPSVNSf4I+r1uRca9Ol6K74Dki69+z1vCI50PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKXqq91Cm/z8cSZJXqeItCifTtPoAMgroC7/sJLFAiE=;
 b=C1HVLuZ4j52Q39ne7CAykhlvoQrjbkUlN91ZXni4rZ0PyWFsej8Hlu1x6ckWrNDa6FcUT8m9+I4LqF7GssMyqNxnh7U+o7KnRBcP9kEcfN6VMPyMQOQqs64flbkOkS6GXA3o+/PHyF6uGxjoEBv9VLzPtPN7FbC9t+SD6Pir/t8=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA1PR10MB7388.namprd10.prod.outlook.com (2603:10b6:208:42c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 01:25:29 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.8989.018; Wed, 6 Aug 2025
 01:25:23 +0000
Date: Tue, 5 Aug 2025 21:25:13 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] maple_tree: Use kfree_rcu in ma_free_rcu
Message-ID: <l7kladnev3bfxcg2n2rk6hdi757vro5warlwp44ripj3qmnsfr@2jlwi7hhsfot>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pfalcato@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <20250718172138.103116-1-pfalcato@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718172138.103116-1-pfalcato@suse.de>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YQBPR0101CA0264.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::11) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA1PR10MB7388:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f40b72d-15b1-4b93-394a-08ddd4881d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?236n43mZYRFlW0GJGu2V/KYXm6sLPV4zsBSJH8DIGyk3QlATFW2Wv9oqwGSI?=
 =?us-ascii?Q?nts6huU4szyAi6y2070CiHf/I3iMbQp5DJhLzeA269hV+yf40dQIJYQh+Zac?=
 =?us-ascii?Q?NSnSRrsjB2GhWd/LTLGckRS38pbkIs/3gO8VjYpiHYLD0LNuTqtTQNRLb5o+?=
 =?us-ascii?Q?J8MCkutIFxe/fQ7ncPkPmuJ4UeDw3S7l01ysCRgRxkhkoRVaUgGH16MCI8Dp?=
 =?us-ascii?Q?CByuYrym01yBmI6axluNWwfL1qtXpEFALNmkkHPr2eTgqzXT9OyTz38AfmdX?=
 =?us-ascii?Q?D2b0O2UNG8Cb13g+oi/fdAkKzfim6CvRoUTsjz4pJtdshhQhuTWL9uZ3Ems3?=
 =?us-ascii?Q?0rfNGNu78xVk6H5vL+VL4PZEDndXMD8+mMrRgAbDTgmO4BtMViqwP93VkTiI?=
 =?us-ascii?Q?o23f+qFigQf3ZVAPG59v2MZXJ3vauy5jWKJmriA7aM2uGIwZ/sSdxLZXKnZt?=
 =?us-ascii?Q?iS6znhbArotd3wAjRT+Qx+EnxKZnHC5jRNrfP8fW0JtI/gQcpu2V4ixL8SNd?=
 =?us-ascii?Q?LKj7un0eZ2864Cb/U7HSNjQKsdzQ8iDDPttvQ7/risc2TUBlXyHy/r/WnXYS?=
 =?us-ascii?Q?QZb+wcVZWl+lMcaV5pAFd2ql8imxqTL+fF5YxVztFp8BQqQXVuBSzdfTQA2E?=
 =?us-ascii?Q?f26s+zJQr7Vc+G0PXzhU+5DGe+foOxxOpe9yqxhso+RsylC2TIw49aNS0dH4?=
 =?us-ascii?Q?4NaoUI8WmHERtc5JTwS/0zpir15pnUpk95N35a6CAmsWW5lZRIBKGg5fZrQG?=
 =?us-ascii?Q?RA5IeHuCZP5yyg+N29+LbYXrVKtR14cmX6nFVgmu/aO/5dxaFr4l+Plnpcuy?=
 =?us-ascii?Q?TgdYzW4/ZsUDIZ6eEwS4vdOBERf0yjpd1wKotbp3pAHMbKhaK2pbkmFX0ZTW?=
 =?us-ascii?Q?fwytZaqgXvXaRSarcsW3oCQVmLbcoqS0ovbt1sgg1U3XFsewcdRkNr5YyjJB?=
 =?us-ascii?Q?W+ppR2M7CnDWWXkbHw+YjNaywKgw049NSHocH0gOKulhMZ7fwzwuDKsSshi9?=
 =?us-ascii?Q?tWuVLdbb0brSUKSfF1WKyrm7ALpTgY+4Ai0DnCd7MR6EBlPpmDq7qwJT0DW8?=
 =?us-ascii?Q?8VkCPqKKn9SCkVTlrJuqrWjQinZH9VM7xAbEFTRqUToYT6AB6Vefz0y6M76r?=
 =?us-ascii?Q?IZx7eNMrewvNIblpmqk+jwgH38bTve6tpyc7w7vl/I6uQLKoOgxz1xA8bOdY?=
 =?us-ascii?Q?0tl1jPMF7Z2eDrtcLcGKli8tVClo9/u+MHefl7rCkqG8hgLuBl6rIJHolGRQ?=
 =?us-ascii?Q?dH5gqtptsSsVAw/Rzj+uZ+eKq+7uoBbDumg0ZdZhrvuUG4I0tXJLRe2ZwD4D?=
 =?us-ascii?Q?kmL15vHgGqfEz+hCjS0HKw1fF8HG2/g1CNGMQDQF7xXLD9hhIlhVPQd3PHuP?=
 =?us-ascii?Q?TO8SSSHFCIm7xHfqDRZv35GC+T1ggFQ6BBW0felLgbGXj85wLpb4JrbJDEf6?=
 =?us-ascii?Q?PeaSOi1w4EE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OUosynYKXvTxmpJqC6KZ0E4aDsLX1IOCMj+6hf5N6EC3fT6/GolLkbq8568l?=
 =?us-ascii?Q?3cxArPiudQKi+Ltno1jHGfKeaiN5hZNjDZbuaNk9Yhks37QUdPrKwZFuqV6s?=
 =?us-ascii?Q?rL2WfHx4IEbQElDL//aX1/2Lb+7AGlrNoyLwc0mY+MraKpD6LJBkOUx3ahDw?=
 =?us-ascii?Q?dDBjEyuIC1OoyOiqkXj3BjZbqT6ROl/gLbs/tTy4KcEke5iO9n+NgScVh7Ri?=
 =?us-ascii?Q?6yy+gWBkcKVtvy+iBWLeTBKTtd1qHCeYPZURdo85VxpeMy9s93/ptEsqLF4t?=
 =?us-ascii?Q?MrGZkuK5xbrk6Und6uC+Mzg5kic2aP6PplAHy/SzFKuf5WGPbVCmpx8hqiWc?=
 =?us-ascii?Q?hD2wjYVGO3Gk0iXpC3kWb893pkahbv6Fs1m7Y6fFyVev89ViU3xbdjFCNQhD?=
 =?us-ascii?Q?CbNAW4mIMs9XsP6Dsy4xKz6bGV+/9euV3k/suQ3HpvR2Ti8zE1fltDYVACip?=
 =?us-ascii?Q?SFpwp3VZOMb9duFBR7Gv4qZVjq7VVfx9qbg49Tw83NQ20Xd4JvY25X2Vc/5B?=
 =?us-ascii?Q?5NLPITGdO775qaOhTrLJc39S47hQ2Vq7ZcVgZm5+Ty82KJrufai/1H9lgD+E?=
 =?us-ascii?Q?pD2VoijJVwfGGW88eh/5luKpnAPERHdZ47NoIwXZPIwLoCaiIlkuCXmhnpNG?=
 =?us-ascii?Q?5/NJ6XEbzlmwVNwggsN4kDuCzgy1qUGNHNvUmcHCHZ6TYYdC6URmL/T4SwGt?=
 =?us-ascii?Q?0oOu6Im7HstWf/BC0Iw4x/6KFVllQkwTxXxs33nrNBcf+dQtWscs06GheJm8?=
 =?us-ascii?Q?ABi5zmM0x6lXGfJoyEQENcyoRHM+8svOKCcXB3Qr4MTkDQpN5COuAmP4HBC0?=
 =?us-ascii?Q?ibwGuyWT/6HeCfFSJby7c+SczxHr8bRFzmypgvH3gokjv9jl7ADTN6VWb3MP?=
 =?us-ascii?Q?ZkNJi4bYDF92HlnftO178aiZMR1isbP0ps7G9yKxz5/U0ZiFqruatq6xbk2r?=
 =?us-ascii?Q?7XOPB1rlafQpOBN4CLVWlIhEvsKW46k9GC4N9wfbekWXxQsmR32+SWb/eesR?=
 =?us-ascii?Q?CbSdsLaTZsvcBoYNPOS62fK37Hk2oD3LrKvBE8gGmHHwNWdq6AMW65luKaU8?=
 =?us-ascii?Q?MLEo0SCRf5UE4VpaFsgzp5WEOaSFrbk0R1ySsoe36jKjChQl6ZwM/vp5ZiUZ?=
 =?us-ascii?Q?MfYjIm53rxHBijrxFr4zoJsNWvdXcmeZ8GXa+j0yR3xRgygkwwVPi+nxyJBu?=
 =?us-ascii?Q?fEfXXNQOfbrtdi9ck2//jFmzNX65FsPgkp3rRUdal612mZTxNv8ChZIHy6e1?=
 =?us-ascii?Q?N3khBAmbCtXu37JkHC5Qb3ereNrlNAWr1umjUj9RjUF1INWLhL7EAtUEnrIf?=
 =?us-ascii?Q?JOjcy7swzVTgUzmErZjPGA+VaTpb7mrQWuf2E6tMYBq51A+xnyXuW6ginh8n?=
 =?us-ascii?Q?A8/PyuZhPCvc6C52CdB6l6DqVYtbjYJ9oFqTd61ULJN+QsjTaGh1Ob8zfP7s?=
 =?us-ascii?Q?lufUIN+B/phC4kgzDfSl1mvTF0qcwSsfdLsXKwvOrJAnJGOARmxFaA5c2Xow?=
 =?us-ascii?Q?qd2dI1F8PDbCO2DuYlFwyk7gDc8je/XBhhg0M0JKsvdjlyrNwYGeVstVbRMV?=
 =?us-ascii?Q?tcA8n1U5Frlkzg1So52qjBhgv6txARams8qVOKidhXesRovrcAzFGSDl77H+?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uNiHL748JOVuaJEJPWdabA+Z+mIiMS8SsYy9bVA+wIsu61gUd7CnVK6pL4fonE+hXEnoXv7SBiAK6VzOdj7SRhsJ/vedwZWlh2+dUifdlnmp5hCU9aE9BA+pcPL8C/dknzcSLSIuBOZ7NE/T9C5Lo8qAofZTCMHMYPHMeXySJ/95klfPy+X1X1jJYMB2GjDntxkIyhiIfNTUwZeUrezrh2KVbtB+P0xlk/GGDLfXljF1dvbu/ER4ckYSVLrj7dv4GnLKpMlDFYEbPOxE0vT7zqygIhlqn8CZL6vvzrYmpumuimi9HO7uKnpd58LlPMzZ2pUCXIq0VgjRRQKsByZmiKL31tF09G7aeuJXQ1NqW9XCShRBECeecd4HJya+KUCAeIIyIuFBR6OA7mMbUW4tcm9LmCY3Y/YfHlfRtjixGshghhWgg8dFPl3g6QIzq4g5GilhRkG60+3T8EkrStmpQ29H5wTykC7DFqMF0FULqahiu5HN4Mv9ZiaYpKKlq4tSQShSL9mJ7MAmRoXkYVn8TuDMmSm8/ZLtCF3jYzfFmIPExe9dr+Ozwu4LfZMX/kkbn3ecxVBdr1+XSnJt7ALA7KYWb+BPV8qej2fgzths6q0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f40b72d-15b1-4b93-394a-08ddd4881d3d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 01:25:22.9259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+JuZO0Y2Oz8LZ3m+8YQpdy80YDJxb0jLg3TJcVD9ZKL7J1rNzt+EgF1APTY2rWWFfSu3U1m/WvmwkVNxy1chw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7388
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508060008
X-Authority-Analysis: v=2.4 cv=fYaty1QF c=1 sm=1 tr=0 ts=6892af0c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=Lrb82dZ0rfzKyZ-0TcAA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12066
X-Proofpoint-ORIG-GUID: _RsGy0M2oLuG8qTIMS-bfWFdFj7G4SmD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwNyBTYWx0ZWRfX7NSOD4HfBu74
 n+NWAUiDs1ZzGp3els8mR57TWvlZ9Ip244mtXYxj7D86bmQaYu7I5U+hJLKaldnbS72ouN4AYZb
 mqqy1KscZIFx7B5ic1ClKUMhek609LX8Dfn+IrSCOy5LVqSLTLimTreanuteuWWS7IucO7ycTDu
 EdojarsLLWojxI5C0mptNNfFAFHwYtAYmfxlrXjcbLtc6EeJykGzcVqtIT7F3631ZXtwM53XgTP
 O7wrmUmtUQaCqv1ZT0NwKcYFr1jw07E6FWBRfQFvROv/DXZ3XncD4Ot6oMxeuh4SrkPQ2ettCet
 1SSrhGfFAlRNjNV+C1rFKV2cWjiufWBVIZ0qqGLruq/eetkny8RjLaMzpBjzl/SZrTDjRfFC70S
 RqaK9eTs3BQoPlL9i71v9wyqa3SSwjxiTke+oZSVr4jEaRkDjqBStko1CXB3OWO1qUUJtzbf
X-Proofpoint-GUID: _RsGy0M2oLuG8qTIMS-bfWFdFj7G4SmD

* Pedro Falcato <pfalcato@suse.de> [250718 13:21]:
> kfree_rcu is an optimized version of call_rcu + kfree. It used to not be
> possible to call it on non-kmalloc objects, but this restriction was
> lifted ever since SLOB was dropped from the kernel, and since commit
> 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()").
> 
> Thus, replace call_rcu + mt_free_rcu with kfree_rcu.
> 
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> ---
>  lib/maple_tree.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index b4ee2d29d7a9..91da2d9d00c3 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -191,13 +191,6 @@ static inline void mt_free_bulk(size_t size, void __rcu **nodes)
>  	kmem_cache_free_bulk(maple_node_cache, size, (void **)nodes);
>  }
>  
> -static void mt_free_rcu(struct rcu_head *head)
> -{
> -	struct maple_node *node = container_of(head, struct maple_node, rcu);
> -
> -	kmem_cache_free(maple_node_cache, node);
> -}
> -
>  /*
>   * ma_free_rcu() - Use rcu callback to free a maple node
>   * @node: The node to free
> @@ -208,7 +201,7 @@ static void mt_free_rcu(struct rcu_head *head)
>  static void ma_free_rcu(struct maple_node *node)
>  {
>  	WARN_ON(node->parent != ma_parent_ptr(node));
> -	call_rcu(&node->rcu, mt_free_rcu);
> +	kfree_rcu(node, rcu);
>  }
>  
>  static void mt_set_height(struct maple_tree *mt, unsigned char height)
> @@ -5281,7 +5274,7 @@ static void mt_free_walk(struct rcu_head *head)
>  	mt_free_bulk(node->slot_len, slots);
>  
>  free_leaf:
> -	mt_free_rcu(&node->rcu);
> +	mt_free_one(node);

Why are we still using mt_free_one()?  Couldn't this also be dropped in
favour of kfree() or does kfree() not work for kmem_cache?

>  }
>  
>  static inline void __rcu **mte_destroy_descend(struct maple_enode **enode,
> @@ -5365,7 +5358,7 @@ static void mt_destroy_walk(struct maple_enode *enode, struct maple_tree *mt,
>  
>  free_leaf:
>  	if (free)
> -		mt_free_rcu(&node->rcu);
> +		mt_free_one(node);
>  	else
>  		mt_clear_meta(mt, node, node->type);
>  }
> -- 
> 2.50.1
> 

