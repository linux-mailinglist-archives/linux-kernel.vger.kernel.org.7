Return-Path: <linux-kernel+bounces-773650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA1AB2A437
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F5837BA5CF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B74E31CA63;
	Mon, 18 Aug 2025 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XrBvsWWi";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XrBvsWWi"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013037.outbound.protection.outlook.com [52.101.83.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09D031B13A;
	Mon, 18 Aug 2025 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.37
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522717; cv=fail; b=a2AoZ4UsQX7fDRy7SwT/5ZJDgKE5VVdySBHY/P37Ee/pimZvd6r+QOcCi9atZP+3e0ujYM4+sWrEQBLorc3qDC/J5un2tbKHTCWSxB9I69Z3aU02KWQezI+iMk/YZ6ss7EWnywLzJ5c7AOLp6hA0uRzmre5ruqppjo9oB+l4uY0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522717; c=relaxed/simple;
	bh=45pbpJs+Lz1OIsP6+d2VDJlEBmGp53Zyl28QOOVI1/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jWhasPHmmWijDNQQFtN0ogtlIbAlq3JimBVe7PHz202nwer24RvHtMRtxs0aBn/jfNquhukpy+dJB9sPX/H6/Cb5Ac5rGzkvqvf7CyvY6Sf143zfqN8SRm3u76nsEjFjZRS0+W+G1CjNA8fFjK3hQmdoNUYC6liLtNuiU/fZcDE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XrBvsWWi; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XrBvsWWi; arc=fail smtp.client-ip=52.101.83.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=aqQnWSZ4HdCWGIs4ftaZWo6ySkPgLvp7fVlKP2jx4uvpzDUHlM/DWhiWN9lnjJ+Qp2arsrXI8EvW6PMhIJDvC9Zt6v1EIyVEaAx79XFMVLURz1shd8lbja9PFoPkN3w9iZ5+341PEknQeTi7AESMAkdB9NjLVzpP6j829+CuIJCiis+AudNVy0zFBPrgB0LaR2H5XZgWaUDsiLEQ4g1NQ7e3TB3+Qj1lHBqqvUZHMwBv2sjbTmDYCybSj5vKfQL9Oa3icMl8lkKT93OVKDedXVtKDtZ1OxuIsg0VcYIat2capSMRkiKSNj3EebxFS9ub5gJQ7nS+D8uI6xxGBxsY4g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yLSX+HNfkM3kyN+gL4jKSVpM1YNgfoLpyH8V67D8/Y=;
 b=V6ramsYPNKdscnxwmV/9NUQZvzixIDfJ6iSzduzLcFerExE66ktqdlsmVtwYfkGLDNKWNxsANyMiqwB5rFo/6Io21OllfepMvI8NvsOvJqrR1S79/ZYaDjiXJ6yBL67RtF4HR7dw1MKKNPDLKBqLLCatWPDNyTXOmNjuSdBPIhvPFT32LlWAt+MH2O5MAvGGukI4hZTwzNoP9X9pAx1twYxRmGl8AZeh2El1oMcqnwp7xmcHzvkK+vsw7/HrShglR0iHBoHb0xucqCEA05vIrdOmaFr4n45o7XxGuC2iFofqcz8sBrNR/VJm/aFoSkmPFKzcLUU9A9d9mQIS5TWZyQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yLSX+HNfkM3kyN+gL4jKSVpM1YNgfoLpyH8V67D8/Y=;
 b=XrBvsWWi/H0Lv3R6yx+ybnRcTYxRVd9IhGMLZRBtAKr1J64vwxXPSLrSfhrzd8F1LNBTQbayudujucjvbC2/AKiMBfdtLytwAm/LYo10q1GXTjco6z7ZuwG2Sll/+Irdrdaf9uAwj/G9H95Uacj1ezMnb6t5FJKWHG88JmmVpcg=
Received: from DUZPR01CA0078.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::20) by PAWPR08MB8839.eurprd08.prod.outlook.com
 (2603:10a6:102:338::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 13:11:48 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:46a:cafe::16) by DUZPR01CA0078.outlook.office365.com
 (2603:10a6:10:46a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.21 via Frontend Transport; Mon,
 18 Aug 2025 13:11:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Mon, 18 Aug 2025 13:11:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HN+zCdMA4LfrULOsg/jqlkudWLIH8cG+QQvRMVUWdY2hUSickE1qPYMx/rC3FwWVW22hRYBzwPwxMm3sCVp5gQKrF4ORKS+0nqLoHaMHWtKXWYHGPGEupLmJk193XSP+vMD4crMUn1iV78/pGCj9Mp+A8b0n/s+0CDwCQ4W4gJn1L2XzOw82UQFrTBt7Ng79Gn0SCvyIWsOim4QV99P8rSpq4NWEOwFjdbfsz15ws6bZeBULqdH/yBkK/JfjpNeTScxa4qnapTZjENzHR9NjTg431D4Suf9RQA+zLmud5aPrway/GypS3pkSvLg19kJkSheWi3mGlo2iSD0LXkNF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yLSX+HNfkM3kyN+gL4jKSVpM1YNgfoLpyH8V67D8/Y=;
 b=xcGNmjUI2DSOJHNMgclIUME7+lcB20T6IKVgsjN0V77FZUTSDcr3BrWAFDw56Ly6nXSDeHyy6SBEbPLSQOqtdEoXSwWFYwjjoSBLU61d28jBHmITvKL50WX7Nx5CfCSfOQMNcdBp4+mJjzzyiiGmhJ0oTCHIcr2IRJdWzYeUFIH1CTVTmGpXaUMPyAcZswY8rjj2O+Gq87NTjp2DucXR1unxF+P1mQUN3pqz9QIldFjm1QIGWeewUSk99TL2cphskfGlbKJ9bQdjWesdHp6aeNhENu/ilXBqVU49GMPsavbUT8Yx0MLAFklqklBgMMBH4KPMxes18UE0ki3HZLEVLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yLSX+HNfkM3kyN+gL4jKSVpM1YNgfoLpyH8V67D8/Y=;
 b=XrBvsWWi/H0Lv3R6yx+ybnRcTYxRVd9IhGMLZRBtAKr1J64vwxXPSLrSfhrzd8F1LNBTQbayudujucjvbC2/AKiMBfdtLytwAm/LYo10q1GXTjco6z7ZuwG2Sll/+Irdrdaf9uAwj/G9H95Uacj1ezMnb6t5FJKWHG88JmmVpcg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB10144.eurprd08.prod.outlook.com
 (2603:10a6:20b:630::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.22; Mon, 18 Aug
 2025 13:11:15 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 13:11:15 +0000
Date: Mon, 18 Aug 2025 14:11:12 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com,
	vincenzo.frascino@arm.com, corbet@lwn.net, catalin.marinas@arm.com,
	will@kernel.org, akpm@linux-foundation.org,
	scott@os.amperecomputing.com, jhubbard@nvidia.com,
	pankaj.gupta@amd.com, leitao@debian.org, kaleshsingh@google.com,
	maz@kernel.org, broonie@kernel.org, oliver.upton@linux.dev,
	james.morse@arm.com, ardb@kernel.org,
	hardevsinh.palaniya@siliconsignals.io, david@redhat.com,
	yang@os.amperecomputing.com, kasan-dev@googlegroups.com,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 1/2] kasan/hw-tags: introduce kasan.write_only option
Message-ID: <aKMmcPR8ordnn1AG@e129823.arm.com>
References: <20250818075051.996764-1-yeoreum.yun@arm.com>
 <20250818075051.996764-2-yeoreum.yun@arm.com>
 <CA+fCnZcce88Sj=oAe-cwydu7Ums=wk2Ps=JZkz0RwO-M_DjfVQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZcce88Sj=oAe-cwydu7Ums=wk2Ps=JZkz0RwO-M_DjfVQ@mail.gmail.com>
X-ClientProxiedBy: LO2P123CA0094.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::9) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB10144:EE_|DU2PEPF00028D11:EE_|PAWPR08MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: 70120f7c-81b2-42d3-3fb0-08ddde58c97f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?m2Kv/vpxgEyY6lYBTE0rYGKBcnsLcMt5+w3/OVSJ7MXomC46M5tlOpTtFpnT?=
 =?us-ascii?Q?LQC8lJGrwIi9aVfVn3XeJV+xGnHADbPpFWalP06h82pNjHilVRefLfv2E7Q2?=
 =?us-ascii?Q?OgVfBJx4Usy4W6CLGEHFEVHJwQW0GHSJ9U8lmFBDXFuSQmzUc/7sUcG7KnJO?=
 =?us-ascii?Q?qIVk5iBgTzejuMOvtbRjkvN/ObkhUzr4Tgk4dMEJCCznb9Z/ooarUaB9fkZX?=
 =?us-ascii?Q?iSYFMfkCwSmy+LGX1hXbBkCBAbal2Ya41mkBOlWgHHm/RVqCb7yil5qJ+mN4?=
 =?us-ascii?Q?8s5ayGW6tR+WB65ljpnSme7AzLe3G6PAr4nnYEyP9FROb3uQ9D2vq17+Rttk?=
 =?us-ascii?Q?MySqkIq1uQ6s47YHmMKsIcskrI6ELRjX0NcSK9oh/IcBcEhGSJFVv99UtVQL?=
 =?us-ascii?Q?y+dKHNNDXXBhufwlyYw+qWjJFGjppGHCMzT9qly3CAgTrTKGyGI5lFfymUEX?=
 =?us-ascii?Q?gIOjm/Ud9gUAjmTrDpwi0U2ju1ChYoCATBWT/T+soWmbXVHI5OcGA+vX97wm?=
 =?us-ascii?Q?lBSBxN7hP+ljAjNUFIH6+Sg1OW7MgLvoTH/JVJar3YUru9tpiQI/KEQHc3uY?=
 =?us-ascii?Q?GZH+zRNW/vdk8zsI4x38Olf8Ec5ikeCqyVkZl7whDvZaD/o9a9hXVa6KIx4c?=
 =?us-ascii?Q?Sg23j0XwtJS0Q2UzPAtDbH8Wgq+qR4m66T2oVZQXQ5mAi3H/ukBbMMtdzO3e?=
 =?us-ascii?Q?Fvkx9Z1Vi33wUBMFC8TLjBoJKDpNDvUJENG5Inns2sYA84IIpwsVSK4rO7/y?=
 =?us-ascii?Q?bn+O+fsIrYiq6fJXSRnqd4oD93I1YY5B6H+CFROc6NxmMXYDvHrOX4QtV4JD?=
 =?us-ascii?Q?WR/6nmSHR1jiJkfsYZquqFW446uKCPpGgwX48JCrUndll1BHcg34bybKEhPE?=
 =?us-ascii?Q?5RY6dbjHjmaqojhu3aMerpF/t5DZrduxhCXuck+Xqm76NjbNLIegbL6LGOwK?=
 =?us-ascii?Q?hx6ua1KY30zKaGk95FtdG5y1VGaELBY39Ho5XPNyeGskQRv6ftg0G7NBjdqp?=
 =?us-ascii?Q?S1PKdn2c84Lw5N/153I+t0sdvW278rBCtr9VpfcllkRiFYtueF0zebJxFjKN?=
 =?us-ascii?Q?16niBVfc9iOcn8+kbgrsAAwPlWCs5DoQ6wsgLkklAsnbTdTd2UHT/xIwHe3E?=
 =?us-ascii?Q?zxjot7FxBzJi55IV+OI95LJF0gKY978qvV2gKpLXxXLyexItz1kH7wtxmH01?=
 =?us-ascii?Q?N1R0XIE50isld0qfewTr38LE0DDiLGr/6Mo7ttQTU1NU53C7vnYWyXwrz1Ck?=
 =?us-ascii?Q?bqHuEA/wVjZ4YX+VcPGEyOPPHCOT+yx/Hl0PtlIBvLhvTTAPStDdUBUj+3yp?=
 =?us-ascii?Q?sxaLuZln4DUn4yuFqFwoLglPQUx7Q/rg6oW2WPWlF98rYnz0aGGSCwNkHCt7?=
 =?us-ascii?Q?yPIvLtsa4bH6Px/rg3fhZ4xz05rzKPBQ+azAjGU5cNlzBAP0IrGbtMao5/ck?=
 =?us-ascii?Q?p+XzZPPcVfM=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10144
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	da1a94ab-69fc-48e9-eeb0-08ddde58b648
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|7416014|376014|14060799003|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IJoODDviXApvdPto/fdEIskiJtWYh/1NOR+zXe3+VfJiDVlXKGUKzx6cWsVT?=
 =?us-ascii?Q?qdZO2Iii49RWA/Pzfci65JdJAYTZOjGFFjwtUwQwevT3Cy/gwRe61XF39mAG?=
 =?us-ascii?Q?WEqDIDQ7KPC2qwMu/ACW/acSZc8b9nXo8ny6MTLCaXhnnbOZrGvs+7bYrzid?=
 =?us-ascii?Q?nDnLFTGIAILbuVB6Jdkr+O8LEwTlmaMXdNdh69Wr+lby2gFI1FCMZrCySlBl?=
 =?us-ascii?Q?Y9xAPgM+03ocT7xUEQfFX+3sOgHflrD0liOiwgtmNuBGudL39As87PWlBj8B?=
 =?us-ascii?Q?ev5lHPBnRHDzjMkt+tDsL2EWCt2yLcztPgGTothT0bpbvP2iYXb3ohGpz7JT?=
 =?us-ascii?Q?JwVUC0gWfccn51Xzp31vULZ+/nAnjHCmN9t7Vtu7lHumjJ0WbVVIqVXnPyQi?=
 =?us-ascii?Q?Q+GDCkuhQc4nI9MD8p3EV0/iD/hY+Z4aidfT4IPimc076sr230JMVAmTpBhC?=
 =?us-ascii?Q?0GADHCVJW2hL+MTsHJkt007k6wNRVeNvSZvTXC5pWWRABFrFav64QxzbJx92?=
 =?us-ascii?Q?jbCjhEz++/M9E0fI/GzSSpbGOyx/ipU8My0y1sulkon1JDR5YJxoF38iBc7x?=
 =?us-ascii?Q?YT47icyJf89ZKv/k29Y5VCodqHCLPNT6X4BvKtZ+hTzIBpXdFrGPGZ3NPr1W?=
 =?us-ascii?Q?H73sxaBEW0sMZNRJFxWfK0HRhA/vdhmYS2hCNjlQm0BCsezqPllBSjN7thqN?=
 =?us-ascii?Q?lBaCWTSb+bRyXPNIwRxGfBaLvWZ4BhxF4WyrusBuaY2fpt/ZtsShU3mC3QP9?=
 =?us-ascii?Q?0T6t9FVl+bcIXxZ+IW7oAboC8HADT/uDq6Re6c9mjMmt5KbhTS5v6SMn/xjq?=
 =?us-ascii?Q?xLTIRgW8WDBB0JZ2OeSCEiBZgJXuwQGs/5qrxycNBH1rp+VieDep4v9Hhmxz?=
 =?us-ascii?Q?cj8SUJzBpFzxU2HfrD1DMDpSuznxiBmyiOvhNius03ynzXo/EnkkzfIpmk2A?=
 =?us-ascii?Q?2I3AqY29sdaf2jt5nq6yWW0THN5MUf3aNbeahNcRYynAVNqEKfYy3WnH+pqc?=
 =?us-ascii?Q?tV+5L1vVTXoE8HdVdDdKd1wkTOWgBaMmaJHay0/sKL8qCepWumri5A8G3D8V?=
 =?us-ascii?Q?MHvYzYLRVqsE838wUWc4ex7KqY8KsorhRkl4l+SOD0/NTbHBWJc5aJPrBd0J?=
 =?us-ascii?Q?h/s/XLFqB0f2mrTzPofFNi/oi8zkn3AVlMkvD986vkOzbRX0qfLV/uKEDC5s?=
 =?us-ascii?Q?7KHcvA+u8MdW7GNKojINq3GeEeE5ByflhQwpv/F2IAPizys7xXI5pDMj806m?=
 =?us-ascii?Q?wOBapgEVf6Dq0un+Z3yUCkCMFl9V7u5ncDRGy5UQTZAFVWszbZou9UdIcYdg?=
 =?us-ascii?Q?qcX5EckXO/zL8rApWXJHUAzV+dRMJCCL7hsU9XIIEm1J3HGAM5m6rCZ/e/VX?=
 =?us-ascii?Q?+JmURH41sjFnmeBu98OFDZ5jAtR1lklvK1In5hcRcG0Rb8getkXb9QDI/PIq?=
 =?us-ascii?Q?pgtCOJSBHAWm7cr4rcdge3J2MgjZpT+tKxFVXt2itEHhMZnCge9KTj0Ex5C5?=
 =?us-ascii?Q?VncGdkvf0o/W/GZBQR+qE3+s2/fXAgNz3l8e?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(7416014)(376014)(14060799003)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 13:11:47.4373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70120f7c-81b2-42d3-3fb0-08ddde58c97f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8839

Hi Andrey,

[...]

> >  static inline const char *kasan_mode_info(void)
> >  {
> >         if (kasan_mode == KASAN_MODE_ASYNC)
> > @@ -257,15 +283,26 @@ void __init kasan_init_hw_tags(void)
> >                 break;
> >         }
> >
> > +       switch (kasan_arg_write_only) {
> > +       case KASAN_ARG_WRITE_ONLY_DEFAULT:
>
> Let's keep this part similar to the other parameters for consistency:
>
> /* Default is specified by kasan_flag_write_only definition. */
> break;

Okay.

> > +       case KASAN_ARG_WRITE_ONLY_OFF:
> > +               kasan_flag_write_only = false;
> > +               break;
> > +       case KASAN_ARG_WRITE_ONLY_ON:
> > +               kasan_flag_write_only = true;
> > +               break;
> > +       }
> > +
> >         kasan_init_tags();
> >
> >         /* KASAN is now initialized, enable it. */
> >         static_branch_enable(&kasan_flag_enabled);
> >
> > -       pr_info("KernelAddressSanitizer initialized (hw-tags, mode=%s, vmalloc=%s, stacktrace=%s)\n",
> > +       pr_info("KernelAddressSanitizer initialized (hw-tags, mode=%s, vmalloc=%s, stacktrace=%s, write_only=%s\n",
> >                 kasan_mode_info(),
> >                 str_on_off(kasan_vmalloc_enabled()),
> > -               str_on_off(kasan_stack_collection_enabled()));
> > +               str_on_off(kasan_stack_collection_enabled()),
> > +               str_on_off(kasan_arg_write_only));
> >  }
> >
> >  #ifdef CONFIG_KASAN_VMALLOC
> > @@ -392,6 +429,13 @@ void kasan_enable_hw_tags(void)
> >                 hw_enable_tag_checks_asymm();
> >         else
> >                 hw_enable_tag_checks_sync();
> > +
> > +       if (kasan_arg_write_only == KASAN_ARG_WRITE_ONLY_ON &&
>
> We already set kasan_flag_write_only by this point, right? Let's check
> that one then.

Yes. if user specifies the write_only == on.
>
> > +           hw_enable_tag_checks_write_only()) {
> > +               kasan_arg_write_only == KASAN_ARG_WRITE_ONLY_OFF;
>
> Typo in == in the line above. But also I think we can just drop the
> line: kasan_arg_write_only is KASAN_ARG_WRITE_ONLY_ON after all, it's
> just not supported and thus kasan_flag_write_only is set to false to
> reflect that.

Sorry :\ I've missed this fix from patch 3... this should be == to =.

However, we couldn't remove kasan_arg_write_only check in condition.
If one of cpu get failed to hw_enable_tag_checks_write_only() then
By changing this with KASAN_ARG_WRITE_ONLY_OFF, It prevent to call
hw_eanble_tag_checks_write_only() in other cpu.

As you said, kasan_flag_write_only reflects the state.
But like other option, I keep the condition to call the hw_enable_xxx()
by checking the "argments" and keep the "hw enable state" with
kasan_flag_write_only.

so let me change == to = only in here.

>
> > +               kasan_flag_write_only = false;
> > +               pr_warn_once("System doesn't support write-only option. Disable it\n");
>
> Let's do pr_err like the rest of KASAN code. And:
>
> pr_err_once("write-only mode is not supported and thus not enabled\n");

Okay. Thanks for suggestion.

>
>
>
> > +       }
> >  }
> >
> >  #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
> > @@ -404,4 +448,10 @@ VISIBLE_IF_KUNIT void kasan_force_async_fault(void)
> >  }
> >  EXPORT_SYMBOL_IF_KUNIT(kasan_force_async_fault);
> >
> > +VISIBLE_IF_KUNIT bool kasan_write_only_enabled(void)
> > +{
> > +       return kasan_flag_write_only;
> > +}
> > +EXPORT_SYMBOL_IF_KUNIT(kasan_write_only_enabled);
> > +
> >  #endif
> > diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> > index 129178be5e64..c1490136c96b 100644
> > --- a/mm/kasan/kasan.h
> > +++ b/mm/kasan/kasan.h
> > @@ -428,6 +428,7 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
> >  #define hw_enable_tag_checks_sync()            arch_enable_tag_checks_sync()
> >  #define hw_enable_tag_checks_async()           arch_enable_tag_checks_async()
> >  #define hw_enable_tag_checks_asymm()           arch_enable_tag_checks_asymm()
> > +#define hw_enable_tag_checks_write_only()      arch_enable_tag_checks_write_only()
> >  #define hw_suppress_tag_checks_start()         arch_suppress_tag_checks_start()
> >  #define hw_suppress_tag_checks_stop()          arch_suppress_tag_checks_stop()
> >  #define hw_force_async_tag_fault()             arch_force_async_tag_fault()
> > @@ -437,11 +438,17 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
> >                         arch_set_mem_tag_range((addr), (size), (tag), (init))
> >
> >  void kasan_enable_hw_tags(void);
> > +bool kasan_write_only_enabled(void);
>
> This should go next to kasan_force_async_fault().
>
> >
> >  #else /* CONFIG_KASAN_HW_TAGS */
> >
> >  static inline void kasan_enable_hw_tags(void) { }
> >
> > +static inline bool kasan_write_only_enabled(void)
> > +{
> > +       return false;
> > +}
>
> And this too.

Right. I'll move them. Thanks!

Thanks!

--
Sincerely,
Yeoreum Yun

