Return-Path: <linux-kernel+bounces-730026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92815B03F4B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2606316D140
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8462425486D;
	Mon, 14 Jul 2025 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fzIZ8aMd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t18R3Jgu"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C469B253B60
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498523; cv=fail; b=Z1/BRej3HEhHok8cyXJRkcj9AyXeRqvnLt7LQaTFqS19Y4z4H+eCCPcXfspg3r+hCrDjrObsEOY0AoeXMi3aKEyoOF0kfTiJW1+d9zc8VT+srPJr866GsC9BN6yxNbeT6Og1vpfauA9kyr5VJgGwtKh242HeRwuW879Bfx0HhA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498523; c=relaxed/simple;
	bh=Uo+bi6QXgza9WJjTfZc0RF+dbA3NmMmzK8BlyRCq0IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MpMNrexuoa327DWZeLOk0AH6/WIDN9P7prdCEYxw4WcLWwr38z3R4TLlYS2uRG3JRPeZWA7t7efQr2EBUw3hYXpRyWEt6sGV/lZj7FdkfqiTU86G1LXtjO6sYFvJjwdxo1V2hMJPVpodlg2m/xMVJsGTQzt0myauKAo+IXN1Mto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fzIZ8aMd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t18R3Jgu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z4aI001230;
	Mon, 14 Jul 2025 13:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=noXeocpVPjMGKvtPp6koEjzZ8lql9PO9RKmZuCFIAnI=; b=
	fzIZ8aMdmCVWUws8S4s8AS4xlDnidZUwINJBl8eizfXk/tz/6mWEaeMzVyUY9trF
	LeEAZ+X452j4NosY+EvETfvwvwu7r0PakpwPuXYKW5BnZhfzMtrrNa+jUmfqDlC5
	xaKMpgxEl/iqPcFQn5m7BOpPzfPw0GJALi7Sjmy27OEOZ0YhyGWLb+n2nhKNxf0k
	TMa9XRfv0v2Se5+1Oqpk1iacc/yHFDQEe05lwpXMoi1V8h7EO576JjAEEbO+9doV
	ukp0kZJHOpdbfi32W1n5BcBxb1kFxVWP1/KgnFSTWBLXIMKR4bAqwke5R7R4DSsH
	SiHsm1hUZ7mjkNIPpoPc7A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8fv2me-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 13:08:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56ECA79g023939;
	Mon, 14 Jul 2025 13:08:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58hk36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 13:08:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtrSBsDc7tyZOQotNPR8pv43pS7iePDyWH4DvylcaKafRo1I3n5P/dEg/sdX8adJc5VUvSiAFUSnThPQ3BDXpTe1qmBDHmPN2F0i9j7X8pI33gaGzLSaWAvRdMCY+8vMwX02gA/svFlHGu2zmAu7KuSmtwPNwRpUs0lvShKeB+D2SUK5Bd2GLZkHsM0q18Bhp3WvaXskFGaBik9O5H6NrGp3Lk7LdAX1yr/6iAVUjw6qfEmkU57EfUgfoBElrSHPhC2GkhMWKob4fUMHAvedTKd50ZETJlhzoRN0YLwlVfsyD6BSGFxSGZ9xjDn4DV7VnwoAl9/xk1qTC7P9oOv8mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noXeocpVPjMGKvtPp6koEjzZ8lql9PO9RKmZuCFIAnI=;
 b=yuFjM3o8uGXhN7U5etgh9t8b3B9qFV1p0tjDmBXq6yt1P5nNjH+VQ58nD9wh4xdRTU5p3t2GTLydHaR26a9f+KdNgpBaMtZfHh2iAGcg9Vj25sHamUmRg3OGTF8AxLqQG49NItpokTbcx71KNPA1b4eqASb2ienDsRg3brnhzCTj2rJqRsMBKYHAeECuSJwvfSbm7gr6GO/qkXAlBK7oPBPP/NKrV7AUKCCR2N7jnTDrIVq6jPMCSFUHymMICOAnroNhHVJJoS7wIHzdsjUBIUjinSPbTSQfFzQ5f84fRmot/0EJbESiNOGR/OER2KgTPZU9vtBgf/2ZlxuT2UkWXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noXeocpVPjMGKvtPp6koEjzZ8lql9PO9RKmZuCFIAnI=;
 b=t18R3JguDewl3nqgukJ+SQCrDU69NsTYjZ92ykTxefXxjITWmnMPfYnDjQGcxwvzMTbmqABUiVl8KYEfxBbQknp6sIoOZRvtsDzhswODuCCakJeOJ5TMOCCsYNsvpFHGCIWR9vlJ//nh5U6ZV2l94wkwVjNr00fZ+oYSspGwzJs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH3PPF1F3678C2B.namprd10.prod.outlook.com (2603:10b6:518:1::78e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 14 Jul
 2025 13:08:20 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 13:08:20 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH 4/5] mm/mseal: separate out and simplify VMA gap check
Date: Mon, 14 Jul 2025 14:00:39 +0100
Message-ID: <f010ec1ce65f35dbe1fbd82ce002ea833a7128f3.1752497324.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::29) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH3PPF1F3678C2B:EE_
X-MS-Office365-Filtering-Correlation-Id: 847f11a8-2683-428a-872f-08ddc2d781c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7qr7ZWSgIMnjlOPXfxUXwAmDka27db5JB05gFbc+ovFTDLUiwesoXmS6uZdW?=
 =?us-ascii?Q?GCeUYqEidyJ5iR7cWDlfNMqLKNaqguzM/Xav552IKCHkeuC0kgI2pt0gTrWT?=
 =?us-ascii?Q?Pib3Dc1iuin416rkUYpyYIJz8H7+fqnetVrgg7l+UPuQXzqhgnV8g5CUE6wH?=
 =?us-ascii?Q?uv37S2S/UHn3aHIaTLXyVeW44TRTtme86G6vyZyY6uN7Lp6oIIy1wL1CCWJA?=
 =?us-ascii?Q?ma2bloNQ15tXXNMWUBbcNteYWzqBLHrMVzqJuq+25eD6G4dEwJIaB25AhlZC?=
 =?us-ascii?Q?xnr0V5NioSAknUFP7gaa1QBHVTCCxrzg+I6adWDpPTZ1El82yD1V1+TCp6Ch?=
 =?us-ascii?Q?ZVKx2wIToS+FYr9C5zU5eK0jTgI6pykKDgl9o4hqo/ifhzZAPGeXQbuJsaIb?=
 =?us-ascii?Q?0VtPHDaG6BFxf1LazKbmJb07a9mSKCdVvc/poH+4ehydhQHBX3U6q5Jakjqx?=
 =?us-ascii?Q?Vr0+YRTVWc9sfNJ8felXh9iWhWPTTJ5+QjAtku/VwmTZ9TJTAPF+i0vNBPQs?=
 =?us-ascii?Q?fpy/6Pw7UbEitkmICUL2tjxRowhA18Kdz+X9n6ytvma+hcwT+EWu8CvBHCaP?=
 =?us-ascii?Q?DqxUULTFYzFLG5VqpTpUBivSkzlyyxzxSLD0g4EsIhLQjKzVLRImda2/rrxI?=
 =?us-ascii?Q?r36snIGg+gYfO+E/huDxMM4cxV0jyPzqkqxSepvBDyi8FeAIcXS2a3zAzW1e?=
 =?us-ascii?Q?ITMpZy9gEPuNA1B4Zux/rdPot2/EDyGip6xgI5mVBmoCVwnSpqwSB89gmIFd?=
 =?us-ascii?Q?pkq/EeS4YRTL81IzzZWnDjNhtklX8Q3WABEt609CeU2qBMTrxwjefOkTgbYD?=
 =?us-ascii?Q?1IFZA1EbA5d41X8OzCykObQxn3pWDnYBJMX1lDAksDdrutBSN1ab6eHlnC7+?=
 =?us-ascii?Q?mqnaK4cOilim7Cm3I49LuUThljt5ZeIk731VnmUnIGn06ApFACl+A5x7hM/r?=
 =?us-ascii?Q?k7ebCQcv9WeavrAp5kZ3WqqMUv7TtwXdRbO51bJIoNtzxO/Pr5qHBKpF9htw?=
 =?us-ascii?Q?DjtPbm9cKov8DNTHej2yHwHHN1aHsXkAKACuIQ+T0lwckzN5ec/BbF594xcL?=
 =?us-ascii?Q?lBGjK6EWPJkkXsujqcv/BWVxNeQtfYnv7rxwSNKTPFLfxlzGcfeckICjsxwB?=
 =?us-ascii?Q?/cm/+IjeuVNJSkED/F0800H/+piREV0CQrEYA8GmOFZH5NopGtzdeFZWefeq?=
 =?us-ascii?Q?pett6RHb7tK/cWaEYAhOfAIL3XxXmQgYJB9IH0fIQOruk+/j/1ESk/Vt3jCj?=
 =?us-ascii?Q?0M39CHI15x4kwUhw6nQYEo0TioAzzzrewgttUogKdVNGG2mh5vp/dy69GDcH?=
 =?us-ascii?Q?Dp2L1vsFHCH+mOJC3aacDkSj3uQx/QkEP3zCxhpU3zjNpZtduVcZ3Il1kJiq?=
 =?us-ascii?Q?K0Pf7CEwthTln8RXzaqAfR3Rolv070KwmgISxoMk/lASlnqRO+tKFtA3X+xu?=
 =?us-ascii?Q?Fvp9Do5tjnk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D84YDAyzWdlewl4hxAslYIGPKOMayttaUD6FOe+HobRo1PJq/O6RqrODJp2b?=
 =?us-ascii?Q?knw/8cmet6TsEOaQau77FJvOLZZR0XL3kzWOy4whwYOidqntXVqTWvdoNY7+?=
 =?us-ascii?Q?HVDksxF4At2goTDG4q8u1WOxaF9Tj7tjn7N0F0sD1NDwDzvMYg63Xolv5TPH?=
 =?us-ascii?Q?UHiTVsXkBFUgd6L3RO4UnOOjAUlQJuHh+M0fhYvzwlVlndYac0VyLZzJJtVW?=
 =?us-ascii?Q?wBxVERXmwZ8Lu61NLBIc5ET5dxyvJ2AqNz560vdke9u7lzrmtBoOrC4goimY?=
 =?us-ascii?Q?QqZKkWpizknTJMbmeXG+CgsiXXLr7HieImVbiHX8PVCInVlsZ3YbdpJPsH3Z?=
 =?us-ascii?Q?feRxNSgbOLtsKttl1k+AWkJX0hlCYxsCjzUZeHfw9l+ZSNr03tcFNvaLOfr7?=
 =?us-ascii?Q?jouvnd6zTyAVdenMxGv1WcDiJ692clKc4iFC1JxUpHMkldViSHJ9DAHIhzHj?=
 =?us-ascii?Q?hmuQtIKs5Kf4g6OJdNccIFPP+/8QtAYKayCNdMSl6E8I787RuZ1atiLDtpqB?=
 =?us-ascii?Q?uPZfmYddDCTMnw/Z9lFdBxFQZDgLqEqEA/VSyquTRnwYRUhyCIqjXwATE7T6?=
 =?us-ascii?Q?Wf1+5gTj48GF2fyI+7QppZnI/VkaV28QCDfNFZkRvta8MNClLPubx/25eTH9?=
 =?us-ascii?Q?c/HC0R9wYP2SexDFMNjeDzUxIKVyapSzCpj7FoL05PA8hR5W1fs0mN1Csuwr?=
 =?us-ascii?Q?SFZkHlRc+xR9FgCKWpWBQVEZ5sFRrS/mli4n5RtKh/RUHoKfvtHya1o90dct?=
 =?us-ascii?Q?QZwxFDW0KIwfYAJTbHH1UjSuLSYrzlf7LO/3zPR+r+lv7cCa6faMbn4SbqiS?=
 =?us-ascii?Q?QdpojY11IzFZ7lzFtQgrUvExGa68DguDxLFBuzVO95fusl/pcpSD4A3UlTa7?=
 =?us-ascii?Q?GM+xsGVyUUxWM4hPfnkCq1CIhzNRE7DbcfLT/6UmhSpdTd7HVGfrKq7KnAbi?=
 =?us-ascii?Q?2Pl3QeBj7C7MwJPllJ6G58EXNtoGYWNMp5ixCB3cm2mfzFEoCdYknfWuepDP?=
 =?us-ascii?Q?WMeY3YOPiuxkk1zOouBk5PUWlxu9Qx/MIe7jVGD+e4LEvB43fqOdJtu9XL2R?=
 =?us-ascii?Q?31keqdDNLuWSwW4lJ7GISAx1zkgrB9oD/V9dG2MbYBYj3/4mOyL8kXO40c2C?=
 =?us-ascii?Q?jHlmKNYuk1w3xzSYXwmzozDUBzAYT+UhY34VrrUL3l+gf85QIyKSom0T8WDW?=
 =?us-ascii?Q?JVeylPPmNdixaRIMNZ2sCVBnL4z1T5VTQeuWHBQUU8t6R9MBIoTskNlkk4nG?=
 =?us-ascii?Q?Thh11ppdAyHzCePLWZZ03aam2sTvpfZ0h+MnyHsofRkt2xtWDJryYe8jsDAD?=
 =?us-ascii?Q?qWJv2HWfYf+RHSjWkTEHno/j3RHPHyMFfwJffzYL58uUJ6qM2M2D1MdwzxNF?=
 =?us-ascii?Q?W7yDOojIgvSdJny6JsS0G1KBbDqsaMaBLHospNcTLevgxKDo+CAPy/XRZTve?=
 =?us-ascii?Q?WtWYRzWoBvviayQoP0V6e5FOrkKc+K1UzOmePqWVdQfUqdFbRV1RobsaH0cS?=
 =?us-ascii?Q?znNLh6V+jSYmgr17p58A6D7XbtCo020e9xmY7L5kpZ34bsUcWnBN1Cc7l+Nk?=
 =?us-ascii?Q?eD47s7BygnfsQw2av4zJy5Pcz6siCKhcnjEO1fvli0Qkx6xuULNVklhcFpP+?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h4M2GpdEqeI7yEXp3vqGAXR3ZYKV/YL2KlrcWINiDgmsgf8TBXbl/UZpnyvvixyLAV4tamNpfHSgLKFFvwDNuQRWZNVsUGhFX3UoBHvKmfdpcyuT083A/VHuEgsS2IvS9JiGj9G08q8uccnIOmBm4Khf5OlzVmkDjstCs0RqWkRvctylaW2XiRWlkbmhwufaZ/L4P0D1ZHwqWKhuYQ1JFOltY7y3o+NItFxw3LBQfH33C9kPHdEOkSye8v/CPvhdzcdSuA+jNNVlD+XU0F1c58yLqOZCWCCMSKEtMHGragOHom2NltMGqxlFoUYG+PdgMfSt/M9WAof9yCFBC4lfrV9eHUukIAqr8Ndd+moRWz4Evk7kFiNWKZdia+mR44UNau4pamVT3bBwcx8NC4HRgq4NxfhhS4F3dKlVwFKhLMoJpDgTO9mVJdlwSmWZARiVjUQ2PgmwreveS7A0r9p97Jzt48WNzjNz6mKbAzcMV/bCz2TCIjA59Y3JvSD3NCMCns/W7mjnas4ZBaLvPyeWvOwkGD3vV/dbFzxj6+l3+kr29rInvdVC4y4VnPn6PXWJRmJu5pVbupzNNb5MmoTkKTnVEZ6gpZUaE2EHBOSR99I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847f11a8-2683-428a-872f-08ddc2d781c7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 13:08:20.8157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lRA1pDC1xa5JleV2oumimXUi1+OpBDAUgXrneZMMrPd95KempL2tZkovdccBUsYnrF0RDjNkQVct0zTIVpjKz7P6vhwal5zLil/ZxC09mQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1F3678C2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140077
X-Proofpoint-ORIG-GUID: fxuCNbKFnwpIuMZpkHoxejQ6bJ7bkcGF
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=68750147 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=HR7nC9x9inSF9eXenEgA:9
X-Proofpoint-GUID: fxuCNbKFnwpIuMZpkHoxejQ6bJ7bkcGF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA3NyBTYWx0ZWRfX/57F5LMnx68e 2wFJHlpxpmPvwUY2sXqWgj2CMyjVKlGayOCOwVIgeMxvCltjvoCfHYQpZUJAjiDk8FaNlHmRJG7 30EyA+RD+l4H6w1B9d26rJWJGA+aajbYvPoHyu/mE7U6YKpyl3H10vo/04g00RHysYqGuyB+Dup
 4eLllEdTe+pS7BgA4fXhF9bSKYXtvK81VCdg7kohz6Ftv+I/ayBHH8KUuNkU8zgErVDmE6EFibH nl/2yBCWx88q2NymbpxdY4xtxT8oY+s0IfWgrVze39gPz/qDh6KPpXpTHDhFs9tzZ2D0AamOMwD VDr8W7DG/0QpQ+HsdVGkPjuaOnrLCNEcbBKlxg3VpM6GY199MTTW9S01u0SNANevBPK5bHKC1F1
 gfBlF8NCNLyKGywPMIe3HQVmFVe3kDC3mymdWdT3K1B8f4uXrNsbjyPvOtP8YAIdLRanOoHe

The check_mm_seal() function is doing something general - checking whether
a range contains only VMAs (or rather that it does NOT contain any unmapped
regions).

Generalise this and put the logic in mm/vma.c - introducing
range_contains_unmapped(). Additionally we can simplify the logic, we are
simply checking whether the last vma->vm_end has either a VMA starting
after it or ends before the end parameter.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mseal.c | 38 +++-----------------------------------
 mm/vma.c   | 18 ++++++++++++++++++
 mm/vma.h   |  3 +++
 3 files changed, 24 insertions(+), 35 deletions(-)

diff --git a/mm/mseal.c b/mm/mseal.c
index adbcc65e9660..8e4c605af700 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -37,34 +37,6 @@ static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return ret;
 }

-/*
- * Check for do_mseal:
- * 1> start is part of a valid vma.
- * 2> end is part of a valid vma.
- * 3> No gap (unallocated address) between start and end.
- * 4> map is sealable.
- */
-static int check_mm_seal(unsigned long start, unsigned long end)
-{
-	struct vm_area_struct *vma;
-	unsigned long nstart = start;
-	VMA_ITERATOR(vmi, current->mm, start);
-
-	/* going through each vma to check. */
-	for_each_vma_range(vmi, vma, end) {
-		if (vma->vm_start > nstart)
-			/* unallocated memory found. */
-			return -ENOMEM;
-
-		if (vma->vm_end >= end)
-			return 0;
-
-		nstart = vma->vm_end;
-	}
-
-	return -ENOMEM;
-}
-
 /*
  * Apply sealing.
  */
@@ -184,14 +156,10 @@ int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;

-	/*
-	 * First pass, this helps to avoid
-	 * partial sealing in case of error in input address range,
-	 * e.g. ENOMEM error.
-	 */
-	ret = check_mm_seal(start, end);
-	if (ret)
+	if (range_contains_unmapped(mm, start, end)) {
+		ret = -ENOMEM;
 		goto out;
+	}

 	/*
 	 * Second pass, this should success, unless there are errors
diff --git a/mm/vma.c b/mm/vma.c
index b3d880652359..b57545568ae6 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -3203,3 +3203,21 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)

 	return 0;
 }
+
+/* Does the [start, end) range contain any unmapped memory? */
+bool range_contains_unmapped(struct mm_struct *mm,
+		unsigned long start, unsigned long end)
+{
+	struct vm_area_struct *vma;
+	unsigned long prev_end = start;
+	VMA_ITERATOR(vmi, current->mm, start);
+
+	for_each_vma_range(vmi, vma, end) {
+		if (vma->vm_start > prev_end)
+			return true;
+
+		prev_end = vma->vm_end;
+	}
+
+	return prev_end < end;
+}
diff --git a/mm/vma.h b/mm/vma.h
index d17f560cf53d..bfe9a04e6018 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -598,4 +598,7 @@ int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
 int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
 #endif

+bool range_contains_unmapped(struct mm_struct *mm,
+		unsigned long start, unsigned long end);
+
 #endif	/* __MM_VMA_H */
--
2.50.1

