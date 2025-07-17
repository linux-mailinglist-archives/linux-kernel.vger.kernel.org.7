Return-Path: <linux-kernel+bounces-735280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A7AB08D35
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9E43A750C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B692C17A0;
	Thu, 17 Jul 2025 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JJWGajZ4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qzj6sOZq"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B6B7E9
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756079; cv=fail; b=oqm8F5/rPsOVL0zXtV4XgeUVJFn+Ic4fvptmMYtUy9lQxYpIpFz3HbwsJodQY5ynoKHon7ZvAnf1CUK9XdlC3lFooow1tX4a5zqXldbrSLDAa5xNdZr9OiPFoZnUJ7YAYkppXHnSklqEBDZYH8qHqcKLeC1J96pgDgpm4gB/YVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756079; c=relaxed/simple;
	bh=mBGL7kIieK4bTe3DQzLaFhQWmj0jeRtJMZf2CqNtKx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JV/ZUeIxRzM2+eP6b+oHW0hFRatCZbCoOlhY3WDiwVno5XD3DsHqVLTdlH45cDV8zFG/w6SNvpZa4H/wpuOpiDVUld8evr3+Y8y4rJsAEJrbNeTKsDbILUzWyfW4J8LZWfb78ouNwDfcUhVyMdoPcsJVOYromSekN4i5wWm2+4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JJWGajZ4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qzj6sOZq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H7foIE020696;
	Thu, 17 Jul 2025 12:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6ASH3xKDpCQjR29/y7
	e6Vapk5oL6GitpEhUCFfAAXis=; b=JJWGajZ4dATia1D9ie/ErSVqhuez4aTQY4
	LJsZ2jH8itM8zDjXWF6qxXksZXeCbHYDzpAuwkLASgLyCHesH1h6ooDJ6eVPitd8
	HfPyWKwgBmt5M+Q95NEL0+00VuunBiT3WmXhRVPmTjHEFQb7iuoxq54WxrJDGnRa
	uhuXrHX8L7SWCZlVuX6sKuWpF01vMTbynf2DD4Ig+l3X2IEd3/MPBgrJCkwwRqUn
	+5AQLo9IOSQ7JiT1LqAmMSHo84jMZAF6DrSjvTJq9F+97KO5eM1hQ+FwpzEeiref
	XypwbLBfE8eKwjFiyYPxLBunP7e+jAyMi+44zhcvKNLbJ8nqqZXQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4tv6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 12:41:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCKqjc028978;
	Thu, 17 Jul 2025 12:40:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5ccbe7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 12:40:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LW5V63j1IHiQzEkKiKYevpOvkykcYPGkfNOWo3OfhthktDdpe4tK3Hc4Fh5oUIcNAp6PM3+J7ikKRwjh9rtENbVr1YYae/wPp76qyqxiKh3P27hsgtMUrxdH2dH9rrxNgFKkh/yJyye6fjvomV4Kn12H2uC5BI3XdChe+tnFvs6AyDCj2Uz8mgQ/yf3seJKkuAZF7HWdXMbRpKKiy5CrcWxhIGrCa2TZtXkTLUrjujBgqP6htcwiCl4MxEHDU9MlnUqli64jHez6WtGPs15sonAS/VxduI3RlNt18haj330ckxN3BToFaxj39bqUTXJ6xGxBUjqBhjs799DrYybQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ASH3xKDpCQjR29/y7e6Vapk5oL6GitpEhUCFfAAXis=;
 b=NJGm9gcMPrT7tz153BphkilMHEpDxsUNfLldEE1Elj3rvP2PgnE3ukd8eLiPwodwjFg0eXPDp67rJLRi0IITWlCtLVd0xyRrK22rv16LO2z8NfMbYktF/d3WMQr0Iy7lc43V7h1rnTHEEkOJEBc6gRibJuLw1mWvn0IaZgoQ9uY4jbYseO/Dzl/lm2yru2c1ULRJZdbqZIJ6qEsex3q9NblVqyOBv9JjPzk1v312ak0T/HMsyhf7qNBqZihIsVvVXRVJ4/kXNjrjcgtjegQN6i0HvNKzmbQZ1JcLR06kz8Uu2WQuLM3JtI8YtH31zD6lipioYVgczsI7Zds9VR1gSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ASH3xKDpCQjR29/y7e6Vapk5oL6GitpEhUCFfAAXis=;
 b=qzj6sOZqvSQ/lmFuf2UU4yvcZN5E8d9l0IGBeh2yl9d/2ON+xPcmp2Shtr8h6Ua2xMGcD1iJN54lyn3mxVFvWlElwcbBMmUQs9R0kWXYotf0TA1e4jyZX6mCty61oK6E2U98HBW0cS9qpMPH8Q/W+poSWglkEMsdqNqSkHrSvjE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7246.namprd10.prod.outlook.com (2603:10b6:8:fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 12:40:57 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 12:40:57 +0000
Date: Thu, 17 Jul 2025 13:40:55 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Balbir Singh <balbirs@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>,
        Kirill Shutemov <k.shutemov@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] __folio_split() clean up.
Message-ID: <1cb14f22-bb17-4997-bfb3-6f1d1f984d3c@lucifer.local>
References: <20250714171823.3626213-1-ziy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714171823.3626213-1-ziy@nvidia.com>
X-ClientProxiedBy: LO0P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7246:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1a86ef-3b83-402c-d2d4-08ddc52f2d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4tcL8C3WiPO0EklnfglC+2mJTmghiUMQUXXBgUFeZABuge5Co2EK0NQyPoFK?=
 =?us-ascii?Q?KShGIqrLc4PcirDG5aICy+jzB6xtFjUQ4cc1xb/WBp9dRZhyAx7aBvnDdbsr?=
 =?us-ascii?Q?TqMFvm+/JO2RfyG96yvD192dO2P9p3Qk62CqbcDrGdhc9P1o7+J84e0z61KR?=
 =?us-ascii?Q?WMH/cI63zgb/q4EO06utEvK53yxKTG30TKPNxu5jG0w1Z/sT7hSRCb9GlkdW?=
 =?us-ascii?Q?dsrbVv0ypBLTnwiPCP8zkV+QOsq4Rni60fWT2KbAP9b4nul8mtyaxzZlvoVo?=
 =?us-ascii?Q?6pBDXpcfRaUcRwpRMUFDEBMYEkmscVBLVBZU9GtnM+imVdLoeho02fD5ge6E?=
 =?us-ascii?Q?mwRGg+iwHGX1jVe7XPmHVS9Gy1Ev8mxvw570KpsVZnCz7nAxkFzRmqpLwKUW?=
 =?us-ascii?Q?zsVUCjvpGfVWcpDaONQQiLFBOB+gf2/ovz2mzUSA5lru6+N1MkzKbBgMl/Yc?=
 =?us-ascii?Q?fT39XNl7tazZU/ZYWXXC1UNV/TUO0KHAY5Olisght8ii677DdLDc8oyofsmr?=
 =?us-ascii?Q?1Lg0xHRwYCcp+/zdy3uyyJ22CP9Dws1kgPjA06LwVzvi9BpLzANJChg+LGF1?=
 =?us-ascii?Q?SOIzJboCshONAXKhtv6XG7rvq9D2T+sEcIfKj5FutwOXZwuuAeAhoBcPdBB9?=
 =?us-ascii?Q?oF1bZMD+gdKc9G3F0DqxeItzBHthJpw4pI9Lyer/XPiSX3h6vQxUdVenMhr6?=
 =?us-ascii?Q?H8/MwzKuO8K38znubZ3T1AB9RoLNplyVGtTiflSHYGazRV/JHtYkEizVID7P?=
 =?us-ascii?Q?BezBi32G9UksEP+VVEOXrQWIFwjxYCaQN2SRWVbMhz4UdPXhmiXcU0GqSfRk?=
 =?us-ascii?Q?kebkZJtzgDzjR+tGMmy8rhWxe2rASgj019nLg4opR3gx4/MweaIjndjNYJHO?=
 =?us-ascii?Q?htKjEXA0mMay42cKkMPVfNdNfbyC+6SCjYiENhKVZDAXj1SuyNV9Gfx3gSSL?=
 =?us-ascii?Q?E6T2WZzeRFvKjLriqCbT3H87+Q7NSZlq8Z5k5cJrPphe8E1yN0WqRq67EPgX?=
 =?us-ascii?Q?n+d7MPyfi3/WZt7NjzGnzr46lc8NFPWwqDDXAU2bZZYsvtR8cRh+6nefuIBq?=
 =?us-ascii?Q?Scu6UrDr7WGKpFhgcAG695c3F6cpWzf0hgIOAmiZs3szRQzE7d9EXkZQVw0W?=
 =?us-ascii?Q?mcBQT0frOq6KMQ5s2o9rNJOut+x5Sut+Qx4soc6syjpPyQ/oor7CUvrmrS1r?=
 =?us-ascii?Q?N6mXWBi9agCwSy3xEj5mIggWEye0utmdusHjV9o6ljULEyIMKFCGFWrojNIz?=
 =?us-ascii?Q?XLfEluGLgOJ2n7JIiZ90gr0Ds6HKcC9WwDvSsOMoNSZn7NnvSSMQrdKcXAkv?=
 =?us-ascii?Q?ay4DmZhhYfxQgRQ6hTrc4tPROkk+SZYH1QwoMws9flIv2qt3wruXPxTBveJ7?=
 =?us-ascii?Q?CB4/l156wAJl6po4PKhMY2MpVE54J2wM0T/u0YGV8MP4x5YXe7xNPPrMEDzL?=
 =?us-ascii?Q?GMkC4fqSfuw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2z9DiK4SII/wofMplnNUVlY2brqZ44fJy4Rh2H0MSGjgBqCuTcfNRbgCRaQ+?=
 =?us-ascii?Q?BItavUy0Me54PtXSyRpzEMFIqwAV5jIrtybIWC4HRVF/lzatL/P1tQzUOv/t?=
 =?us-ascii?Q?Kjos2mKOASbl66IJlaJU6ZHs1dc5lZo+zm0OVPXDPca7mXP1GbbkeJXgEP9U?=
 =?us-ascii?Q?Y/achY8928Jx/6oukneoLGDOxWgopE96NufT4XQ8weYZ8TlZwsnndM3BaY1e?=
 =?us-ascii?Q?4oTi6Qtjd0VudVqGXjWLtWu0VoDqEUxZep8PG/Y5xfez8xNBVR+HEa/klJWz?=
 =?us-ascii?Q?xlmljGMFfZze0Zx2gb+oa4saw8XjzMECX4m3oqlNx5nKS9CVkF6+Bh3KgtLB?=
 =?us-ascii?Q?l6R+kXLNYj0zWSbOI+HvfALMsKzRtsINwqt5boRZr0omPALN5rHhiI7JOb2E?=
 =?us-ascii?Q?jmCCC42e8yi87zXx994H4blsGaYj+wlzK7UUyoeXQZ7Zurtlcq349XqaSabE?=
 =?us-ascii?Q?MaF1kHDF8Qq1/dHOIb9hQiSehxKYZyiawjuNnMtBHzutzunKFs6siA76FMv0?=
 =?us-ascii?Q?Y/4cuhb1jdj92MGozTm/ptu6hcy2vyvSu4qi8zueecOZyw8u/YCQD7qKSfMP?=
 =?us-ascii?Q?r45EwUh7Z5QVbchKQJmLDNRgFtn4+1NCy4mYPxgS5XIRSrX1wlGNi0epdfh8?=
 =?us-ascii?Q?27xxGYLqaImKc3YRPL0uQGvjieRn044mALyPHP4UE+zgQYUNpqnDGS98BLO8?=
 =?us-ascii?Q?cf5JVQA5dqvO7kVelIB4I6xZTDTWSfrTyIw3d/a7mi/9uWi60VC0Fpf68c9c?=
 =?us-ascii?Q?VB6+jQP6ZD5DWJMj86tWP8pRS6qFtv8pFqfKA1LAHSqDCneun73qLFFMQ2RJ?=
 =?us-ascii?Q?EGrDTv6jfNfKxdGZXYWmXPGJRRkUrFPAOO2ZMOigU+ek4gmoNixkqsVBBxVV?=
 =?us-ascii?Q?smqx3ESE/MTCYCSOfJTbQxhsuJ/SxO2Xw5ISexKTsbyVmmKD4wkeDAq5L2wI?=
 =?us-ascii?Q?4wL4jTmDrbTLPR/yc0qEUi3evHnBOmXSFbWzLnGx3RuDTOBVow1/pSQHPggi?=
 =?us-ascii?Q?L8rb/0Q9ntLlpgFcP7Msd1ZaPYPgQ0H1kdVaSHa2tHFkmj1ED/Ty0PPjZqJ4?=
 =?us-ascii?Q?u2WXqhmamPom+2p5W6yGMwSLDh+VLUEBxxtmzEV5vXDvSOnnUp9Mf/J9V/C0?=
 =?us-ascii?Q?LedBpqSiTnwmuFz+r8SuGzhmP23Lnum81TPrkg5WuAZR4ifAiN4Y1Fzkn3GN?=
 =?us-ascii?Q?sWfoo0ESqGQgA2x8sty+BfoHtoCgdE1Cw92rzHbMuaM+NP/Y4q+DBWLQ9yA/?=
 =?us-ascii?Q?KgmNWhV7QFroWquE0E1KXniHBtGKqM6gkVqhya8M4wcsRuPSvHJSVoi86z9i?=
 =?us-ascii?Q?DHPLW7EHJdIjS9T8nKhuKYQnh1qwezyfzUus+xKJSv0GTVbAkUmfXoVXCCkY?=
 =?us-ascii?Q?Tl748k50v3TXR1Pl1l4zdUISp2G87VV50Sv/c8IEdM4lHDxxq7SmZy7stPEM?=
 =?us-ascii?Q?wWIL1jAnyjZ7uhT3v2T9JpWZl5JspWH2Jng1KThgxl3NsJfN2No95hPCBOox?=
 =?us-ascii?Q?cb6vpWStWTZenuKD7Z8c76CsL+/DVAC92ycvIEu1Pb0ltCmo5qE9DUqo/gnl?=
 =?us-ascii?Q?Y6WtRYIkuC2NlettijK0KRiDmatB7UMPPHswvSZo1Qt0E7REeZ8aiinrK7Tm?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iJFNodb6PIT2iYN4N2EOvfsgfGjASfc9Nu2ooK4zzhOmofdfiRWLcRoKvKwmBTjP5/bexDWNRVrLWt0/astTUZ76hgfmS2JbBkB10VzSbik5Upjs4janzxiFORnC12TxT7dUhHy6xvq47PaIqIMShVw2SI1ZWNFMsksZ7VIZ9LWbZLBbkK4bGZ5aaG2t/f2yJWQbHFVVJvQRNmUUsID7M08npOXJ7JLHQSxsRpuOhkfFDhS/7bNUSz8/7bxvXXaT3gc6ivYGZQtKJwGWgtI3+7Tyy/Paa6CUiEZpfln7uz1Q5c6dq5PhtuSaP3JL3YEzbbPct8BJ7waGtk48olKCTgnzuxfCIMD8WUGMnxSBxoBDbLsmUMUD1NqzaN0UNhvc5I4lP4ENIhz5ZARucZdcODLzruhRS18M+t0Vdwna49mxJBjf85AUkJx6Q5IIl1z//g8l1GcSm0bK8cylXKHHedTvBgHPL+uZj5/MiJty/vZObEefceb79JXzlU36lWB23cXAqRX+4p13K+Fzzs/3pfQgRXLGpLkqhtRt9z/ahPK35xXPQL5PrGJh8xzYch6bLW5Mrz7ds+Cxj0M7C+hLN2Td3FGJW82ljbfI3IBf+WY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1a86ef-3b83-402c-d2d4-08ddc52f2d4a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 12:40:57.1444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1swj0Gdkh8ri1bxrIVK9vJXEA0qojN8A2IiOKdgt+eViy3xBgUTZtUHsN2i6nG7PtOBZEY10VB/HEoq0Z7212fdNE4qRGvXGCHL4b2Oyc/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7246
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170111
X-Proofpoint-ORIG-GUID: a-ggIzjroyjdZuXuvb-5kLQh0RsYUxqA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExMSBTYWx0ZWRfX57F2cI7LoVYB ESmf3Tk7EHKkqMx3bl04jXdURvhvHCk/mfOJs1FopvUncIQz6Kfvhuj/gpXqAxV1evl9dFvC14D Ax2A6oTOaTePEJ4Jlh5T3V+MaClcQq8z3HHe/uer59GF8TCiXaQaKMLL3cQkDjAW8FI8+gBc5KH
 wPGTr6bD6YZgRsgAu3wqOSDINxlbvdoweHdaKMystM0io/djUMFCMSfjxIF2nZ/5LOPdfacJ7vb B7sXEroQcDbx3q4RAhaDBvv9kvGExoBqskRZLYMQ5NQvJxhmFs62waN8i1vKBXZYu3Wy1y+/bVb 3tCLf4TnFlTNPXHsaU1u/xHe0VaaCytuc+UvgxTX2n0AsjZC3L0nFCDLL6yQDqt9a3AGcLupa/s
 7X0/Ef2wq7bCv0bj8HrCAWRXMWxOxwk+eheRBcl653vCQ3FoM0MuBS6ZUn1ZA2LutDFhB24R
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=6878ef5c cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=AZRG3czThSGdmE6_LwIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: a-ggIzjroyjdZuXuvb-5kLQh0RsYUxqA

Hm something has gone weird in mm-new with this.

The patches are in the correct order, but the 2/2 patch, 'mm/huge_memory: use
folio_expected_ref_count() to calculate ref_count.' contains the cover letter
and has the suffix:

    This patch (of 2):

    Instead of open coding the ref_count calculation, use
    folio_expected_ref_count()

But immediately prior to it is 1/2 - mm/huge_memory: move unrelated code
out of __split_unmapped_folio() but with no cover letter reference.

Andrew - has quilt got confused here? :)

Thanks, Lorenzo

On Mon, Jul 14, 2025 at 01:18:21PM -0400, Zi Yan wrote:
> Based on the prior discussion[1], this patch improves
> __split_unmapped_folio() by making it reusable for splitting unmapped
> folios. This helps avoid the need for a new boolean unmapped parameter
> to guard mapping-related code.
>
> An additional benefit is that __split_unmapped_folio() could be
> called on after-split folios by __folio_split(). It can enable new split
> methods. For example, at deferred split time, unmapped subpages can
> scatter arbitrarily within a large folio, neither uniform nor non-uniform
> split can maximize after-split folio orders for mapped subpages.
> The hope is that by calling __split_unmapped_folio() multiple times,
> a better split result can be achieved.
>
> It passed mm selftests.
>
>
> Changelog
> ===
> From V2[3]:
> 1. Code format fixes
> 2. Restructured code to remove after_split goto label.
>
> From V1[2]:
> 1. Fixed indentations.
> 2. Used folio_expected_ref_count() to calculate ref_count instead of
>    open coding.
>
>
> [1] https://lore.kernel.org/linux-mm/94D8C1A4-780C-4BEC-A336-7D3613B54845@nvidia.com/
> [2] https://lore.kernel.org/linux-mm/20250711030259.3574392-1-ziy@nvidia.com/
> [2] https://lore.kernel.org/linux-mm/20250711182355.3592618-1-ziy@nvidia.com/
>
> Zi Yan (2):
>   mm/huge_memory: move unrelated code out of __split_unmapped_folio()
>   mm/huge_memory: use folio_expected_ref_count() to calculate ref_count.
>
>  mm/huge_memory.c | 289 +++++++++++++++++++++++------------------------
>  1 file changed, 142 insertions(+), 147 deletions(-)
>
> --
> 2.47.2
>

