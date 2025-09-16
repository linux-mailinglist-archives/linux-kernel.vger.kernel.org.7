Return-Path: <linux-kernel+bounces-819658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67517B5A43F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA825244FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED44283FCD;
	Tue, 16 Sep 2025 21:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Mbx9RAz0";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Mbx9RAz0"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010039.outbound.protection.outlook.com [52.101.69.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80E82798EB;
	Tue, 16 Sep 2025 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.39
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059325; cv=fail; b=LZnLQ2s50IHQGrLPCLU0Nq5gS8xCq44vE+Drp2+C6gjgzj1CiLdJbunmBzykn592N2Z5I/19M/IP2OSILNuxsqnRc5SRq9Gob7qInCw3wS5Esmmsoyx6em1g03WyItsjtxYy4wPmz2C3D7QlhF7s3Nt2XIK7CF1Rn43V/ouaUHw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059325; c=relaxed/simple;
	bh=hG92y/qRk2Jdhrld7TrMxcG/gvOWkxb4RQS2TbPOOZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MX3/4QtAiLvUPq6mwozslXmsOxnsbmCTQD8QVfPVC7yW6onfz/HJNuub+gq9gZTengOIkycQgvhR+0xYOLtfQp50BWYCh97JivtWC9cZd3k3elChdVOBBHKzxJ4onMDWYmWScccSHTfQw6l8OG71ov0+TkbCOTbfJFZt4ejK1ZM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Mbx9RAz0; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Mbx9RAz0; arc=fail smtp.client-ip=52.101.69.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=MxLhe6O4fi1PCrsxk1WpNTOAWbT4ocA+amSSGWY4n6kiJzWGIJQyXXfjeqkF02o4WK3xoTk11un4hhhsy+84IYPkvwp68+hzUtqZ9FlqAZMl7KWbd0lCW7Tqk0drPDhaLn8fM610NRCWRQw6SWwImCeMIAgLQh2dw+SkUzh0OYD4VA82IrO+g9EizR3CNYwq8M27X5JNsbCAUNJpV3Vx/xZWhb/MjwaQBvPwzMGriyAUJFf9g5wg9QsE6asELKcYuiWCJvQa9vQVCikSZGyP3mVNCJKtKgfG5dGB1ePqMnyCnJOqhdvznaS1t0YtUybYa62j5jUvEOrzPXslKZB6Bw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HO/z33gZvWtAF320W99bJPwyU7ZtNQoA5vuopySLNx4=;
 b=m9Ro0FTKLo2ClUGyVJ/uYOJkcUxwiAbTnnQkCxc6iNsG+Z9y0FwxZHb2N9o1mom03Wdzm3T+IR14CQMIL3g1LXNxaJZZ9zbaPx4hNfKPIGPmKYaWAH6Uy6/E5RtiaGbMptVbiv/D/iJ6TErI2qs37hbeV1b7DIAQOB6efM6Vf+uzTHVGq5OVJDzXQbNFA+P7jPiqB+hzT72LHBCG1C2f1LyfR/r70yopioYc4YnkcqA3si9G4E7v1t+0MsUA2F2ZPyA2zPccpRhRbzV654jVGu1iKDnmLCVQfNO/lftuAmB/yTxzGasxeuK4JDpVVURNHZbPk2dRwP3hYpQ7/x7CIg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO/z33gZvWtAF320W99bJPwyU7ZtNQoA5vuopySLNx4=;
 b=Mbx9RAz03WH7BTcqbl1cxoeWMDK/JK18xYNfEnRmlG0l7L1kr7fMWnEQakGfB8v8iatEU0xDhnSufg15hG6jeottuQZ5zV8LQUGPYKkBO0tE66mCC+FZP4XwhwOIQKNZArFhC5lYU3arP5UNFn97m7Wqdty7x3ulA2QjMw7TrZA=
Received: from DB7PR05CA0064.eurprd05.prod.outlook.com (2603:10a6:10:2e::41)
 by DB9PR08MB6714.eurprd08.prod.outlook.com (2603:10a6:10:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Tue, 16 Sep
 2025 21:48:37 +0000
Received: from DU2PEPF00028CFD.eurprd03.prod.outlook.com
 (2603:10a6:10:2e:cafe::c0) by DB7PR05CA0064.outlook.office365.com
 (2603:10a6:10:2e::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Tue,
 16 Sep 2025 21:48:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028CFD.mail.protection.outlook.com (10.167.242.181) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Tue, 16 Sep 2025 21:48:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alMPF0rf0lc8SwjUdwg531QQGke02yn0R8zqV3QLSmeLnNTjiileeyfppEHR38O9RSS4iZVDR+MFDTQNKVGXdmSlvtx3FrQMWmDA4n/tf3KIHYXpSJIOlDQcA7nQhZK/eNnQJOgHiNKSZINRkyXXqvc18yvG0niXm21Xmx2UyGe9Mohedaj3lllwCYwsMIVPnGV/6gj+Iv+OFt/a+9mykqpgLwwyxLYkaSY9z1DzfReZk7O9WVD8mWU53boZej6cBO3FLymovp9YuiOi3IL/EwiiVKJNAa498GyN/a3t3UNxCDmratvEsznEswsvIbY1DgBuOjfbOO/Uc+haiIRYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HO/z33gZvWtAF320W99bJPwyU7ZtNQoA5vuopySLNx4=;
 b=gz83HvDUpwTBxvwJR8+40Xd/jfXrSDUR7OhX7pnLwPMW4goeJPCROv+d6he4AMkeE/9U9zR6kAjQQQUgHTgOiCkKVLqAOE7GXYGKYOWih5P6VeQAm/kPvOjTaBE5qQb5b/h6cwl1TI2N5g1VdbuV9Db+l+krlB02+WQKJ/3TjJVQB4DLq7Fjz/fAIAyaFI8cgVjNYcQVa6JKSlNAGi/G5v7d1aO4IuZZwCjvFH0x9Wo1Fs7JaL0YZmDoXGm76F+0R8d3khiLju++r3JPcul+iKPw7t2N6X8U8+e41l66+sahmqwI5FeWesN/h+aM9hC9nwmJFJpYmYfQPqkk9uNW/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO/z33gZvWtAF320W99bJPwyU7ZtNQoA5vuopySLNx4=;
 b=Mbx9RAz03WH7BTcqbl1cxoeWMDK/JK18xYNfEnRmlG0l7L1kr7fMWnEQakGfB8v8iatEU0xDhnSufg15hG6jeottuQZ5zV8LQUGPYKkBO0tE66mCC+FZP4XwhwOIQKNZArFhC5lYU3arP5UNFn97m7Wqdty7x3ulA2QjMw7TrZA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB6374.eurprd08.prod.outlook.com
 (2603:10a6:20b:338::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Tue, 16 Sep
 2025 21:48:02 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9137.012; Tue, 16 Sep 2025
 21:48:01 +0000
Date: Tue, 16 Sep 2025 22:47:57 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Will Deacon <will@kernel.org>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
	dvyukov@google.com, vincenzo.frascino@arm.com, corbet@lwn.net,
	catalin.marinas@arm.com, akpm@linux-foundation.org,
	scott@os.amperecomputing.com, jhubbard@nvidia.com,
	pankaj.gupta@amd.com, leitao@debian.org, kaleshsingh@google.com,
	maz@kernel.org, broonie@kernel.org, oliver.upton@linux.dev,
	james.morse@arm.com, ardb@kernel.org,
	hardevsinh.palaniya@siliconsignals.io, david@redhat.com,
	yang@os.amperecomputing.com, kasan-dev@googlegroups.com,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v7 1/2] kasan/hw-tags: introduce kasan.write_only option
Message-ID: <aMnbDcPMPvKXG7k+@e129823.arm.com>
References: <20250903150020.1131840-1-yeoreum.yun@arm.com>
 <20250903150020.1131840-2-yeoreum.yun@arm.com>
 <aMm69C3IGuDHF248@willie-the-truck>
 <aMnGUr9zeutyPpAg@e129823.arm.com>
 <aMnVarvAvQuJCWXy@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMnVarvAvQuJCWXy@willie-the-truck>
X-ClientProxiedBy: LO4P265CA0219.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::17) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB6374:EE_|DU2PEPF00028CFD:EE_|DB9PR08MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: 594fa77a-097d-487e-e30c-08ddf56ac9ef
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?bBHE8PwyIzx0nuy5wx94ZAXXzan33wgK8jGROMoUdqrsjWVgjhrIi11G1W6b?=
 =?us-ascii?Q?BCY/3lMkKt/taF0qP3NoiAsF3JKpclHjuz1CuUg8cAWBjYpRFX0RDX1FMVya?=
 =?us-ascii?Q?9Wbto/bgX3M5nzYK+JRC2dUJuCuG3pMkyK8qiFdm+oryoZuCXTC3JBBntm10?=
 =?us-ascii?Q?GuhR1hMqsTbUCkI9uQ/qH+Fo/wp4JFRf9wmCLsCb247OY0jJHwbAv4Q5flrP?=
 =?us-ascii?Q?kHN/kgH6rkvf9t2SM+7FrD7nkjMYw1siBEQBBiYUSVhJlKpNg1XMT47uOalV?=
 =?us-ascii?Q?1qag9PsReHf6lcgtEg9vNneK0L+NREp3cBG21MvFhqmMlfSlKoXmZuGiUwqT?=
 =?us-ascii?Q?gMtI9CAQpMmm+POMfyYLpTVLWn3xzMR9flUNTIpO4IpBW1JDslp12gAfKqex?=
 =?us-ascii?Q?J4+Jt/3Jm99lcpLevJhcZvSfm+qyqn10i6f378u5ep8trc6oLbS0XDDgaF/u?=
 =?us-ascii?Q?wFQaQCvhZBaP5ABqqvZUKvHyNJ7UiHxVVmdCNxqPFbb8SR79Rno2rcqUEfjn?=
 =?us-ascii?Q?Hl9WAt7nMzAqpyplzrQJUpZdx1kIkUAAShrBX9xDM8oENLm45xBy6pUv1Fyo?=
 =?us-ascii?Q?dBoC/OnHrcsWfV9p7YiMJf90cUxQAF9JBLa29Dl44ek2vBqb3brYrhDjTz5G?=
 =?us-ascii?Q?TkDnS5WAAmIVKHekslGHqmRXSm7uGIyCReHBFQ2NOEPsaNVLllcTAM9yXQ/f?=
 =?us-ascii?Q?9Vam/xeWLDqDbMk9sHpxbQ84laHdZyNxPJdSHk+Pt1VsfryPN1tRz4mQUgTH?=
 =?us-ascii?Q?j/p1aFIutPI3KeGPWK5or1Oa4wo7dNTrppYGWYPyqnsBhSL/pkWZF6d5m/+f?=
 =?us-ascii?Q?TwVTnJ1thczcIuqbAyJ/pM+7FbfJss0OS+Q1Q2xqmtCUoMHba4MgbboeAPUe?=
 =?us-ascii?Q?4ti9KEargSyVAC2qoqt5Vfm7g5e0rqFihKOGSZn8a+W1s9Vjm8U4KUNre4aw?=
 =?us-ascii?Q?A7rbH58WKBkNr3gbiuYSkIQjl8mQ4l1RcGtguYK/w33cV74FjpQVMEd/HjmG?=
 =?us-ascii?Q?+TpCMNCtC9FYfF4cGLkb0AncIKVjTVYL8QuK9576oQ5z1LQqa8Eh6bPzQr4g?=
 =?us-ascii?Q?gHrr0wB0NKHPiGRDio1XmpxA3RmD/VQQPpRIukIUXjEE4NFGglN1yB40yQkT?=
 =?us-ascii?Q?dfkClyhBfFCYXOpQ16H5U+3FN9acfa78HgOhC0TwNqvS4GL2t3i/Oj2gJE9H?=
 =?us-ascii?Q?B1UCdUhFByKCuPIwIXtIXmOMSCrIaeY7SuPvRyBlhiEzJbUq7iojy35zNaa/?=
 =?us-ascii?Q?HI8fZlKKWZ6xB9fz0VrMsk+keK0kqZp6WPp1WMAOFT9E5pYQcFE7lNFXUXEd?=
 =?us-ascii?Q?1YH6jpKwIDQps5rOFsvIDQHHnK02kqZw5kLh9n1jIfqfnEEMq6hQRw6fPSJd?=
 =?us-ascii?Q?G9lnb5zzZa8F/vRaUV3Q8suh4oRQPlBaiKDhCSu0mY3kjEduBg=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6374
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b839ba99-e08a-4102-88c0-08ddf56ab56a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|35042699022|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ndaevjSwn3Cy3PVs5GpGRcPF/TTTwtAfiECNtq2OpQ+Ch9DwM1rdzr+qzju6?=
 =?us-ascii?Q?Xoo/D/6CtNP1fLeHgYtaJA9rafL10l+LKfqcuGlKqtgzi98yf6uc2nKjxf6X?=
 =?us-ascii?Q?mFiooskWlmSjHj3y7fl8KZT5l2LkqaM3Z49jw0Vl5WdrGO82ZJrwI4MoEEdV?=
 =?us-ascii?Q?zsFwqeOJPyzLGin0RKswGI0T0QcbdFibiNBsxwLgI5uyjrywGVmFAs5V5KEu?=
 =?us-ascii?Q?WetY9uWPWXg2uT+qAGvxa5+PfOBpXwZJUyH9Ltv73uMIcRE9XGEoeGIfX6Ea?=
 =?us-ascii?Q?qSRhjjh54piZ1Ye19PRQNet6LCcuUD73VpvQbip6Di6w+zpv13EWQR0FQmZC?=
 =?us-ascii?Q?Yp2K0XllnSQlU+3atf2798z4LlybUYujEXTxmNk86IrOVLA93W/scWl0WGtG?=
 =?us-ascii?Q?F4la2LzhUsGaXEQJf03FzJfvqTxS4/lvD16byGXOyeUsOahFFJfKrnlQumwq?=
 =?us-ascii?Q?8Hl0OgdgM8dwUtUs4ms8T5KvJQCq5fpxMIKfyDslZ53qzA+Zs6koB4lYRIfF?=
 =?us-ascii?Q?/QIw4V5UUJcuy2D2YD1juHW+gy8+N2a41TonoIGBXNal2Hu9ufpEU93ZCGe/?=
 =?us-ascii?Q?jc0znI8Dw/IXbE2DKoEXbwAi+KFZP+GAm2Ya/Nng4S2hH+rQ+HGLRy1R0dC/?=
 =?us-ascii?Q?NN46BHljbQeh0B5E61rmBmJJAjfe8e9L87HzpOZtRfr1VUP4FnoDtl3bi9D7?=
 =?us-ascii?Q?DiuLXeGzZrSv1yBsgczQClhgImmCiuDjZPwaH4knO7+bFtqHMxLIPuwCOEVf?=
 =?us-ascii?Q?mSel11KyWHHwSPO658/pE69MIl10/GfJCwz85Y5wIIYyBklQbd8+yHBWpsIf?=
 =?us-ascii?Q?hKbgDtTec/8tAB3NLA0rlKQcVJFNQcyO+oXE2t+3e1SxAbE7CsO18wOLxCRf?=
 =?us-ascii?Q?+hu4FlmOcEMrIlwiTLYlqwc8s6dchPPrf+Hx4myjOWySNkjt7GXvQmFVoZjH?=
 =?us-ascii?Q?psj/FyFeFxbM6RZPIc8ZehyWXzMXksKxv43icqdHBa1t222OIbXkdXk5iTbB?=
 =?us-ascii?Q?g8kVLQn2ZLQh5V0+rVFYgDx0BrsmWg8uY+aluMQF2ud7C42wHSf9f6OMOldI?=
 =?us-ascii?Q?iK3IbRutSHQdPI0sGMBb81jwcwgnnn/MHRxMT50E12wVjPsehI7zU/XQNoDe?=
 =?us-ascii?Q?/1oSJALFhXicrUIt8fHXxzrY3PxEuYcO5erozZ/zTq/n33R351EWqeorAo+b?=
 =?us-ascii?Q?9/GSYOg6EoohDl1rH3os9lWKeuuzEYsnc+Y+VNmcqXXg8Q5yRxFkmdOi3pCs?=
 =?us-ascii?Q?dazzELp3Jc1u9unxnbsb0QCSfr7zq0WJo+8bNczGIVsmLHqTqhKRvZj4BRsR?=
 =?us-ascii?Q?sfhyph0Z8jYAsmRddlN1cUu5bzy+DaegQAZDmhvjq5Y5MUcMBUiYEZ5CIrGJ?=
 =?us-ascii?Q?nYpAeuxdg1I6SYvPgo84J9P95RRSCDcMKo8eVYT+ClAqJFuup+h1mdiOKYZf?=
 =?us-ascii?Q?YiUR2FCWH+feZ9UgBtT8ePBPbtHNLQawFhwnbOLSlJZsHd9AIhubM9Vq4bXp?=
 =?us-ascii?Q?1OlmVLtxcuwNHzg=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(35042699022)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 21:48:35.8769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 594fa77a-097d-487e-e30c-08ddf56ac9ef
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6714

Hi, Will

> On Tue, Sep 16, 2025 at 09:19:30PM +0100, Yeoreum Yun wrote:
> > > On Wed, Sep 03, 2025 at 04:00:19PM +0100, Yeoreum Yun wrote:
> > > > +	switch (kasan_arg_write_only) {
> > > > +	case KASAN_ARG_WRITE_ONLY_DEFAULT:
> > > > +		/* Default is specified by kasan_flag_write_only definition. */
> > > > +		break;
> > > > +	case KASAN_ARG_WRITE_ONLY_OFF:
> > > > +		kasan_flag_write_only = false;
> > > > +		break;
> > > > +	case KASAN_ARG_WRITE_ONLY_ON:
> > > > +		kasan_flag_write_only = true;
> > > > +		break;
> > > > +	}
> > > > +
> > > >  	kasan_init_tags();
> > >
> > > I'm probably missing something here, but why have 'enum
> > > kasan_arg_write_only' at all? What stops you from setting
> > > 'kasan_flag_write_only' directly from early_kasan_flag_write_only()?
> > >
> > > This all looks weirdly over-engineered, as though 'kasan_flag_write_only'
> > > is expected to be statically initialised to something other than 'false'.
> >
> > For the conherent pattern for other options.
> > Since other options manage arg value and internal state separately,
> > I just followed former ancestor.
>
> I'm not sure it's the best option to blindly follow the existing code
> here. To pick another kasan "mode" at random, 'kasan_flag_vmalloc' is
> initialised differently depending on CONFIG_KASAN_VMALLOC and so
> allowing for the default value to differ based on the kernel
> configuration makes sense.
>
> But that doesn't apply here.
>
> I'd recommend starting simple and just having the 'flag', especially as
> you already made a small mistake because of mixing up the 'flag' with
> the 'arg'.

Okay. I'll change this.
Thanks.

--
Sincerely,
Yeoreum Yun

