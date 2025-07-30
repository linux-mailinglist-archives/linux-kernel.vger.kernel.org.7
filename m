Return-Path: <linux-kernel+bounces-751082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 731E8B16516
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8EAC188FAD7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3FB2DF3EA;
	Wed, 30 Jul 2025 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LpF9fOU9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aztwENFM"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421982DCBFB;
	Wed, 30 Jul 2025 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753894783; cv=fail; b=BrXp2rSXcP929p3GDoJGpskrUEBg8AeIg/GG32/SuBFoOY09X/vwRK8OuLStlUDWn06qYKejPq/GeytvsVNZcHFME+loTf5Ad3eExvMBMRCdGvkc0B7SLUG0h32q4J+5P2w4z+fM//LejHOfC7HB8O5PAlmd17y7EndiYytV/sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753894783; c=relaxed/simple;
	bh=8dhQGGbBA68kzyXoNwLreA5MxoWwYxy1k5MZuOp7Org=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uSB0ddutKUOZATERL8x6atg0XsIVMUjbWobFpRNxo2x6pDDGebSBD/pCOZk37XM/lE8K8yJZaTD3g6FxA2ZNs47HZM6vo29MR7sQngRwqbk269wfKrAOQ5XXQpi7Ey5G+9s8ffirp6w29Fzqqzb3k6Lxx4fSkH7GV/1okszyF7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LpF9fOU9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aztwENFM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UGN9F8005516;
	Wed, 30 Jul 2025 16:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=fpMokJf2jX42vy/UPl
	vVvcVsxk514LDwot9sEFsKGGU=; b=LpF9fOU9J1ikqU8aV+VXv99AFBcgm8Ncsa
	qL+8mrexM86j0DNUJzZt9ynMIS7gEXrqAwiSSYP3CEPJ2FNMkf9Rj9/pB24tfJlR
	Tu8HupE5wnRPZWnKr0i3gVDtUZFfY72yc6VbGlqcYnldlpRHzwPjdzX9P4x0KVkp
	MbG7Q4FkjMLnpCgaZzSIN3n4LGLDq4EGdBVM4wd90aMOnvEXRTvLDNSHC4yIgfsa
	kbyUNKUVht3xP0h8Q0sB8VQS2rOtbkuSpLXvbhneFKNDWU3tgAJEe8jKwUoIN6Q2
	Yxreccs1F9+9UfoTWli9Eve6E97IRZjhgSmQFJCA9+O7vdMGQ0pw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4eagg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 16:59:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56UFtKJY003092;
	Wed, 30 Jul 2025 16:59:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfbfbr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 16:59:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7aiO3x6lV0jZ2Q++EM2jCVhSxplffdI6fGKYXyhnUGkWfCaUwD9mZYez3/uz5mNWHphbUGBeAdWOqLZxqs8ABJ5Tv1+HPxIrDCcEJre2m2Ca7eFdR8gO44HqYwcQeErgwT1px614V0/zdf8TqSaQoIlV7EaESe9i+6j0OFgWYPca0/+3CEyv0wGq+6BAsmpTZohyzz5jf8UBOL9ktyJVx+OsW76KtxEke68gfjbYZs5ulqgQEC7jCvXLoaMr6KNMkcoA2a6DAgm94WCYwThInUuUKtjR7s1Qq01bfrSR2FrjIPcMX2zb3yrJikVbLprX+VKz/joz37d3l3t3GlHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpMokJf2jX42vy/UPlvVvcVsxk514LDwot9sEFsKGGU=;
 b=tNTK3LDuQJtMRWE8aYbCCUnazmTpuGTAVe0yPzNuN5GpcR6j8c8UJBcnkW5imiN2DYcvEhQEG7hHRJP7jQfd8vWGKyIvAskkgryL+KVSDVXu+gIwnAq35XOJdQFOQObH9BYsLu6kvVi9VmVJscrB7i4yHjsBoWDANoA57QifOZ4B7d7nkohpThnJyfJztan+PXgLqATF2LlWWZdmYWQWckbh6xx4IbyQJvQ3pAtk1dH3Jp8SH70HR/d03+cV3sljNOjpJzPRRR1/8HrwboK1i4ZKWcx+I8ZOJQJtnvXWvCbt96KbpAcEaxyrymUsOiyv4SWIepeHv+z2dNybnKF2gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpMokJf2jX42vy/UPlvVvcVsxk514LDwot9sEFsKGGU=;
 b=aztwENFMlv5vNtULbYbVoq0iPMQjQQliWjsend9D9r/MTMTOT+kWcD/K2sEdQhunEce4JagWKkZFi3jX07EOBs9o4QtaRybXklRugQxCow0tSLbTl/TuCd5bH+sO95jkBarNScywhLXqKweYnn9wzZQxydeRTPvMHp03oA8iZTE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB5050.namprd10.prod.outlook.com (2603:10b6:610:c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 16:59:28 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 16:59:28 +0000
Date: Wed, 30 Jul 2025 17:59:25 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Greg KH <greg@kroah.com>,
        corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
        josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <a1022055-52bd-4948-9399-908b29ca140a@lucifer.local>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
 <2025072854-earthen-velcro-8b32@gregkh>
 <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <20250730112753.17f5af13@gandalf.local.home>
 <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
 <20250730121829.0c89228d@gandalf.local.home>
 <aIpKCXrc-k2Dx43x@lappy>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIpKCXrc-k2Dx43x@lappy>
X-ClientProxiedBy: MM0P280CA0106.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::25) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f52568-8d3f-4f3c-ee09-08ddcf8a71ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?co2JkUVUv4IBv9CCqWlI0uCBcFq3CdDP8RydVAgmZjVzNqoVNsRZsfn11S0b?=
 =?us-ascii?Q?XedHOf86L7VxJ47ZSXokqsEWZ3RlRYXCG8I/rJoQvJOOnYAKZ0annq3+bpcA?=
 =?us-ascii?Q?m1fXhLZdDwNz00m3q5wcMSolWatsOJ2bD789Ze+b/JC8IWXQR1GnOyA+Id0t?=
 =?us-ascii?Q?MYpju0pwMuwVHUSD/trjDJyaQdmrS5Rqa3fhdIRJ20RDsAlkGyM9Ivi1AWWN?=
 =?us-ascii?Q?dH2euTXrtde3NGDFQtbnBTxngKLubULLXba+JkiOk89AjDvSX+8O9VCjPOCG?=
 =?us-ascii?Q?fFUD1hkLUgejt0novcyEamUuPpix45iYSb9gPSDxkXnP/t5MfT2Tk4+xQhfX?=
 =?us-ascii?Q?nq/LCh5yACXqrIQ1WlYHPmNc36c67Xf3Un6/6NYSYbUf+ywGlNTQ0eMNMZ8p?=
 =?us-ascii?Q?pz6Cv1nI0nxlpzilQn8o7syRo7J0DkGG7hEHG/3FVFICvFDQM/cJA0ELheRg?=
 =?us-ascii?Q?vm7612y3aZqyABhA6hjtxZ/9QAOZevhOYfTlw9tqN3Nh11MRGTlpUXUE/Sg4?=
 =?us-ascii?Q?ArbFFzcskFJ+fVNnB4VCp32zHbOUdxM0BSb7CVKMryH45obwRd+jdLn1G3fB?=
 =?us-ascii?Q?QAhFGtC/vMnyrmdOjzfYjgzAuFk0MK1pKl58hjuYbkYPO671PEu+6N5ZIiDd?=
 =?us-ascii?Q?NO53y9jMNu5k/l04gGuExepQe4baKARQKk1QHo0ZRuw7R7/pOD+uZ/7Mad96?=
 =?us-ascii?Q?H6W9GyBqPxw03qqPUDjYPghn/hP/z4HFLa50AZl9n+No2WJyEGr0nyICldKo?=
 =?us-ascii?Q?TGZWgMBPDuLEkSivPvFIu6AgLCwL4WZ8RBgyA6qkjL+5kTBBGJahPRYGZGpE?=
 =?us-ascii?Q?2b8NeHJJuVov08Y2tW0hNQ+P6cFpYeOfwVUo2YLo5sJJXt2US6WxT9Kry+J8?=
 =?us-ascii?Q?ruhINfnlypZ5du/GizAKBThnVw7K3XgLYCH8bpLRt6A626A/BxbTsMGrsx2x?=
 =?us-ascii?Q?+YPNcn74r6L37btSLVVQ4ZK0RuR5TW9dewAiNxh0I0NBh7WlYPfb8C+uKBL6?=
 =?us-ascii?Q?KyrizhSdItjVqUI/sSfQOSFJliT9asLjso3FJ3sr5O5YTjAxTM6w3HBqucee?=
 =?us-ascii?Q?V88y/1m1aCjCVQGdx5ss7voz/4/QqZPbQfqKyFHc3xjPJoaMp0xpaz3GY272?=
 =?us-ascii?Q?tB/gE847jqz7fKrGM/biq3ivaJMpHOmHSwtNB0zPXfzkPatagxDyoMFhOqJB?=
 =?us-ascii?Q?ZurSdx+lc6txHb7iuQOPAL3qjXD6f0aOBCVszlDQYoTSGsk+X/ICdNqEDSuS?=
 =?us-ascii?Q?p+SSMn02dqMvW/XEDk8ro/AjBTMsH3bZpndh3TEeBM9mNWoXH8DEivrDy7RG?=
 =?us-ascii?Q?YA+PVmFusFgTh1o6+WEIzpeElI1+IDWxkKWkRWtAgYsG3fX+rgmUYrACIqZ7?=
 =?us-ascii?Q?K80bcHGOt1oQ4aEw4KZ34d38G90blgrHDCdJZdYAgEzoBUk+khaV1ZkMY4XE?=
 =?us-ascii?Q?+01hTaQWw/I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p/yEvrRNblib40CU3oi6+d7nIfVI9lPQW9pBbvfUJ08+DKNnQBIa0LQQgvXk?=
 =?us-ascii?Q?eR64QXdCBUdmP4K3txCNtzCEH/GzHgVcAJCsDtMaGt8znk2+GJqnPCX1KqIn?=
 =?us-ascii?Q?hRoeN+ph8gK1oQuC3Hcn69L794Cf+liDv7WOqYLxHc8Sebv2IGwf29eQ65Qg?=
 =?us-ascii?Q?gbY9YCswhqib3e8wESLssz/KKszu51/IHtM65tBhAjuGuSfYcEQnghLUhTQg?=
 =?us-ascii?Q?qGjmc8husFGQHNO5mW8/tTfx5uTveA+supcxSdLMblun6kEQYrppT53ViODr?=
 =?us-ascii?Q?p5DDHQcRUJtcpd6gLfecgUg8OlWznKC1uZUmyskfUj7hAu7TaK5RXJMfv4CM?=
 =?us-ascii?Q?jZAXNd30cHEjplB0QPcDlImyH2C6pGYfqFrBg6c0mlVZc3276u4d0/uzox/e?=
 =?us-ascii?Q?Oag4FTMKDaM+UMkW6NxyG5EzJ4FfE1ZjHmcWle4IiEgVixfGJIpR2OWVGO82?=
 =?us-ascii?Q?NNUu1VV/DsHAnFyHz9FS14Bx5vTxTRNrRjN/9HVgI9XjeVuNcGcXYS+fD/U9?=
 =?us-ascii?Q?DvnfXqBhH8ys7P21KlgjiMxG9N2IV/UIKVRtUeE+POPlzh6zxq/UT20o6u2s?=
 =?us-ascii?Q?MyVhEGeSlAX5PGdOthybbXDwvocBjSgLJ/hpiUw7/qRvR6LgXGXk9addWUX6?=
 =?us-ascii?Q?l2+rWctbVsSwcc0V0hAPmTMkpCRS8meLUlgcH0PMJNIdEHhX+XBRWGpdwtTl?=
 =?us-ascii?Q?iEoEUyhkY1PZYiihAWh0RQvBwv16QuK0Uwsjq0gxXrsujp0pWvMlrHNBLj0X?=
 =?us-ascii?Q?MX/2PBqgd3N3DOLlG3fjdBgv/tAp5jeyTLRBFMr4W77U+AJzvAW3X5NKkFV+?=
 =?us-ascii?Q?Suvsg6A2YXTGKK9DjFK3Ln9rLVWy2M1RRM3VczyNdcSNC7bz1jdC+TI4LbOA?=
 =?us-ascii?Q?5XI8UbZoFBB+okHHkLxzJwgdLInoDpS8vr9cHIPyCFeDFXPv9OznxfNJr3+k?=
 =?us-ascii?Q?Vw7KzChlt0qAit5MukJkzKLNipmvFaOOfsYbZbwYuNHFtixZ8WeArjs+0Fhn?=
 =?us-ascii?Q?oxQOgaG1z8uWUTxyASEfKmANxKypomP+VYul7C84cxbXPa4a39c6pODgtdKg?=
 =?us-ascii?Q?JhgQxfO3rBHg89zcUef7f+it925/x3y1zx6CaJz/yVfD7kEHsP75MXpDat4t?=
 =?us-ascii?Q?+27AzyDPz6+Yg1h9BmNANAXsY5wLFvMUJRMR5ULNp7xfbAptaPN6U9rrMFjZ?=
 =?us-ascii?Q?O3b2AHJBbOTlfHedF+YoTjomUOGU76QkK/xd9eRZVmQneCL9x5IrXbXOsf3T?=
 =?us-ascii?Q?JgZGrxMGgc8ByhMug/DeNYKgSvkV6EAwRIOhD8pUQ7BRaYu6F7PEbaqm97/l?=
 =?us-ascii?Q?2hRyms3L2opZt8ds5J/O3OB7E0DxGNxgqwOhM0jIvcST3gMiO1E+x9L8swpZ?=
 =?us-ascii?Q?RGl4F2VG9hwWdYbGJSKTcXHCY3JWYqRUDaoKQ+4Qz9cpH8dA/HlttN3/gZlJ?=
 =?us-ascii?Q?OHHh/I2Knt0Ujn1I2ZBfvL6vO1YO1eyfCcHAukO8N1GiSc8hUDi+YGC62okI?=
 =?us-ascii?Q?IeYNbpAjgaZW26paf0Jk+SzjD+yqB0aEaEtD8Idkbdj47rB2UJ98W6RyptMr?=
 =?us-ascii?Q?dMK0naj5ehib+hIRJH7twCWY3LSTtsrMHTU8ABmQ0xpPUDJjCLA5mlUrEDKV?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OuHmQyYwY5o9D1Uuwb/0QBpo0VeGLa7vblylfz+H7wdmgLuCQvE+3ddu3UneOwbyzT3VgYKF3GrtergQ0WVD0Hl3qIoFruS/GMNcJzh2luNw4F3gM6Gf6b21Du979gno3pqwipSgWzgStGv36au7F2L7mM8XE1Wj3m9qB3tWPksa11EwL7d4szSH7Fb20VWz3zaiQNHGVIXnLAnGLqqrXqX1T6SS7BqTfw9/gK6RkJFkPo9zabJPL6TwSxG51DcxFJZU6jSDqEbNWJA+aajCx0pOxOKXNchynSAnPeFAli6h5ZcOlMRrl3Zo+RMo9YsTavQ6Coe36CNNoh9sY27T0yZGz9L2hb2X88sHdPeBtdNLfUhelxsa2wIeT9CD6olOfVCgzQTFmc/1Rr4SEMLb2X2iZiJranJ5iCeVfaCVLSrUXGMckQPvdH77TlDYP80Z2eIiA1zldrbQLJZ82Ng6j6XX5Pm0hZYf4p08OesVD+f62ljI5F90ESJgKIeJhE1j/okxDX4Ytjn88+Y9vORdM0m2akszHeyxiVmFIzpNeVXHofYPMZ5cVmNSSUdxF8x3W1uwCGltTDb7+crvuXzVgk7L9yUpEts9hyGfMlo7ekc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f52568-8d3f-4f3c-ee09-08ddcf8a71ef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 16:59:28.0997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8lJ2ITDge57I+dAC4nDSOFV3IPrKcqKcLcNi8DYcHZwFvQE1vrVRCVzWErQj3t7YMk/OhohH3Gy2Z/ygNalQ8+1T6KP/YgzuSUviqDP6cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5050
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_05,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507300124
X-Proofpoint-ORIG-GUID: u4dIFj3hPAM6HsDuPldj4wkf1qzrBrg-
X-Proofpoint-GUID: u4dIFj3hPAM6HsDuPldj4wkf1qzrBrg-
X-Authority-Analysis: v=2.4 cv=QZtmvtbv c=1 sm=1 tr=0 ts=688a4f73 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=THeSjdIftEhl9wbGLgoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDEyNCBTYWx0ZWRfXyW+8eQE0fNqv
 fqD4icHEBaU2is7fgQjqY+YrUM+OAo+FZ8v8KRsp+XWnxuXGkeE88jt4HR3WbcIjobGBjvYOdMg
 sJFKnPq/RTdB7XavFAIERT6EQ4H6SvKF/dyfPof0sUiQqYQZPZkzIKkJFVjqxE+kxhy3pbkzhwg
 LirLLm47Dijliy/QoUEm+SDQH6KgH2tO7WDggmTkBjU6GbOij7bybF9ed31bZjRzamaLYedzk68
 DIoZT5dYvW91Sq3qCy9ToKwZhC6Wb0jdp52o/2gq5fyZgzshBvJTdrvPHsVlB7PNJsOLIYDQ4mg
 gINBwex2UKaNmPVmpxE7cbdSkQtUTe5r3SE7oG+G7dIyDNPpoRjHwYpLspllBjWbEFmuJx7CDQI
 8NnCgbqAF55/Ps/Vd7boI2Xn8ynlGGJOrGbQLoUOSuCcsuF58PUsOHg7bY1TNtNTxeOOGWMu

On Wed, Jul 30, 2025 at 12:36:25PM -0400, Sasha Levin wrote:
> On Wed, Jul 30, 2025 at 12:18:29PM -0400, Steven Rostedt wrote:
> > On Wed, 30 Jul 2025 16:34:28 +0100
> > Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> >
> > > > Which looked like someone else (now Cc'd on this thread) took it public,
> > > > and I wanted to see where that ended. I didn't want to start another
> > > > discussion when there's already two in progress.
> > >
> > > OK, but having a document like this is not in my view optional - we must
> > > have a clear, stated policy and one which ideally makes plain that it's
> > > opt-in and maintainers may choose not to take these patches.
> >
> > That sounds pretty much exactly as what I was stating in our meeting. That
> > is, it is OK to submit a patch written with AI but you must disclose it. It
> > is also the right of the Maintainer to refuse to take any patch that was
> > written in AI. They may feel that they want someone who fully understands
>
> This should probably be a stronger statement if we don't have it in the
> docs yet: a maintainer can refuse to take any patch, period.
>
> > what that patch does, and AI can cloud the knowledge of that patch from the
> > author.
>
> Maybe we should unify this with the academic research doc we already
> have?
>
> This way we can extend MAINTAINERS to indicate which subsystems are
> more open to research work (drivers/staging/ comes to mind) vs ones that
> aren't.
>
> Some sort of a "traffic light" system:
>
>  1. Green: the subsystem is happy to receive patches from any source.
>
>  2. Yellow: "If you're unfamiliar with the subsystem and using any
>  tooling to generate your patches, please have a reviewed-by from a
>  trusted developer before sending your patch".
>
>  3. No tool-generated patches without prior maintainer approval.

This sounds good, with a default on red. Which would enforce the opt-in
part.

>
> --
> Thanks,
> Sasha

