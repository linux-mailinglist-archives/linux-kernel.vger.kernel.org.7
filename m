Return-Path: <linux-kernel+bounces-898829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF95CC561CD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF26D3A9FD5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED4732ED2C;
	Thu, 13 Nov 2025 07:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZQAJrSDG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n08Z4zg7"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFD1242D90
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763019978; cv=fail; b=fnjO3JGzH3/aE28UXnGQiv6iv8DcgitqHc3mmbmYIuGb5p2kaxVuuXg0BtSyH7BWiBu+Bv5mUGvZeysPzASr0wXlthK5xtKydhmKBetDBF66Eu0zsGiQGAIh6g0fSVkQx2N/OUxPbMAK+WwRpm8uoJyQ7/zAywTyuGRY51SjdM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763019978; c=relaxed/simple;
	bh=jbGjbqPq3eYFj0RSOvPDe7NGjXt+y09nN/QmsICW9es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VjVyCVhBaCVx9ZPo8ZGt1Z/KHkb9f/yw1YRpC50GSx/M0PAJxaiJv6rwWmIA080YE7UYufYD28fbxOmK5cbE7VfT7f6cCcZaEZ+ou9kZ549bsMM5pK/PZhK0FeXZIbEVADQJHkGUGBWKCXBJ0Ycc6Ws19PR4bCLatbgUfBBXxro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZQAJrSDG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n08Z4zg7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD1gMB3023114;
	Thu, 13 Nov 2025 07:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=wbdMtO/Ke5uCoz6kft
	cUVIsP2Uq1DC5Qyz3ou68PZYI=; b=ZQAJrSDG1S7TiKlWULSjNSEbqEVSe67CD1
	MYZP2jfgIYdIrKdBy/XliJVvkzJhe1h416Pc5lKFhqunHksnYCvd3V+pT1eCvVw5
	VwcCtmjltNFJ02vk+bWnDyHUjrtt9E80FzUYbILN8C07PtoYyXd+VHJmON+GKa2/
	4BDE/r7kuUAk2HkTNHgkLkeCpG7WXTO51NUbRzMoU2wwQBw2exILU08/3qMta8tj
	2IaGPce0JKQaEauPNXtpuSGZTcEc+Zk155wgXIZbYZrlSqwWQ8H9V7benag4ME6D
	CTH+c5BTIqy+IClopWOiPayXJBS40P2pomHxN7uTI5Z15zj1zZ8w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acybqs5c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 07:46:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD6oI7Q029232;
	Thu, 13 Nov 2025 07:46:06 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaftsd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 07:46:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7b6ojj/CY/FrRCI24kCZJ9VJd/ucA/W4kpVhJ3j9qTf7mCLSAGeVS9Jrwm/3F5Fp8BiIzlt+oIIWKKKHYST8pT83v1va/zLBZh2ljPRmicumzDY5k0Yjv3DC2jn94hE2PEdSWIJDo0yYdiQfr1hI7NcfVcvW6Q64HlJhCwCdcRjXQFQU6ZH4k6co94jeaEou2AgYbKXIFDox5nUEYy+VcOUCdmf5iy60gZZtHjdK5MY3Fv01Atd6Lftf9UXKeMVno+quNKzXBNY9cXuGgJGCYTODbexVLCOY6i/SAMHE6bRqjljh5rhVpc6Mq63Ybq20GGskaobe3+SIQcS/omrxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbdMtO/Ke5uCoz6kftcUVIsP2Uq1DC5Qyz3ou68PZYI=;
 b=NL0i+Amic+FePe15CR6dlUwBxRwq/xO6Z/TAJZcNJuDqXwIndKJMlDWv9Oz0l9rgKNseDacb2yaaQFzcV8dLL1rUmrltRHAXnIbroZW47ERtvwJgCQH3UuBIyblpI1Pz15GKsJ7HJLxOiZ52lCeBiYH9XQUVe0kGGQ+RL9Gj1mVQVkuPaGxTqBJ9xIqaXehaI3iF01/ll5s+9ohudAGBZ9xNHe0erLpVuje0Yy/DTTcMmipB1gvH35yjp5mVuixUJJWgNvajX2MGFYVVxXmAn+WfGONLXKvNCCidl7paTUZa3EVUv+xrRa5D9Djt08WruneujgSbDSs0q8EkICn6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbdMtO/Ke5uCoz6kftcUVIsP2Uq1DC5Qyz3ou68PZYI=;
 b=n08Z4zg7pWhRTPF7rflInoJ/epxsc5AJFV1RVn9BNWlxcQ/Ti0JNZRNNLSHqScaBVk5JKoxOYSQ9iq4Rc/LL5LGLCZouB8KkndbIBBrzbJdvPdW0zUzlRioXv9xBnDpYwSK71ZmDxRewprt0+b46gxgAXv3G8z7jX6uKE1yt+24=
Received: from DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) by
 DM3PPFC82B87818.namprd10.prod.outlook.com (2603:10b6:f:fc00::c4c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 07:46:04 +0000
Received: from DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935]) by DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 07:46:04 +0000
Date: Thu, 13 Nov 2025 16:45:36 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] slab: use struct freelist_counters for local
 variables instead of struct slab
Message-ID: <aRWMoIUFO1tOFFai@hyeyoo>
References: <20251107-slab-fms-cleanup-v1-0-650b1491ac9e@suse.cz>
 <20251107-slab-fms-cleanup-v1-3-650b1491ac9e@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-slab-fms-cleanup-v1-3-650b1491ac9e@suse.cz>
X-ClientProxiedBy: SE2P216CA0062.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:118::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7341:EE_|DM3PPFC82B87818:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c373ec-2b33-4777-caf1-08de2288a8cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WAHL+svEkEGMX8ZWHdDmJAGaR8cGkubdlSo8YYyfHLeBHeRLv992DSBjE08t?=
 =?us-ascii?Q?7NYuk9V5rFudseVaDnvXA8EGi8P3fRsmqdXlMuh5Y1cbDqGKNx0LPp/hokmR?=
 =?us-ascii?Q?eTdpAQUYHLr98xhUoBAYmT7YYWcvpM/TqZ9RVrNucaQ/T9wLckRIQm8f5Jgd?=
 =?us-ascii?Q?P1GU8qfcbYRNAFN+YSzY67KIg0EerRmK2OmC7lF6obtsrcw8epgiWSiwrBrO?=
 =?us-ascii?Q?UpHwSmZu0TyOOC8mvGrZbjaq2MYLKhdnItR7dqrfsYUWldtVrhANEq8gMZTW?=
 =?us-ascii?Q?/UmIQhAGLWC8rzjqmtQM2slmlVOp0PPKz0CYgQkbt3VeGOE/ufiKwdmGQj6o?=
 =?us-ascii?Q?4hoASjrIJp5bk/cSgIeyY1+/IhZ5DYl1j4++/0Srg/x1m2QfCOcm1OZVHNoD?=
 =?us-ascii?Q?jJ3tCMr40gV7EAJ8I1ThHYKQ/nt9r/G3cGGquULu8mqz2/m+VYbIIRM53fvd?=
 =?us-ascii?Q?bYLuIW4xzytFMkQ3p4Ygl8SXXH+pa06zKcbHbH0a8zAwZeOcmmeKYGbwXOS0?=
 =?us-ascii?Q?qKRXJPYCp1J0n6MhDb7HhV29WGmw7aCNx5idHpCZ5qp8PPEMwHqf3/PGqXxl?=
 =?us-ascii?Q?5TjBYaR4sVn37EXFRX0yWHLf2A/DDp03MXUW+JABn2C4Ru/0nxgH27v3wOUv?=
 =?us-ascii?Q?qgIK7gfaZIdYQ1TAWPaNstGhBZ088jBu1Gq9SL9mlPXqlhd/uDfIRAqPNaGc?=
 =?us-ascii?Q?3T0LlD6KSCOR0/+cqie7o/kxTi2zmDb/OV6rXKRJWEv/FSm1UwR1MHQ3c2mj?=
 =?us-ascii?Q?srSvkGXiXQ/NSKaUBp0/mMw9oVO2O+tYDYg8J9PLg85XRnCAFHmZdFVtvW4K?=
 =?us-ascii?Q?wCeOgQ00d1J3uFl9kSnPn0V0G/AOLyXryxgqrMsFzacw3fB5+nuzWARyg5f0?=
 =?us-ascii?Q?FS64QvWeuliNSD7TAHOtiGREnAaFqAaDlqXj46TK9XmvuLiaNyKPYvpJU34W?=
 =?us-ascii?Q?3cSZTAqjzVmaVg74j0xmG0mlgWtUpYIaA27KWU1a5XmPm4dqpSY7uy1EV5CC?=
 =?us-ascii?Q?AJwNUZY08rXwlNsgZCOKx7bP0bzo/8fWXePtconuqFbrBEYJJGqrMv92rKu6?=
 =?us-ascii?Q?aplgNdN49498RNbAUDwD14MxVrtemqy5u7F5ZmXdOCrshRAGcwL/DXFLMqyR?=
 =?us-ascii?Q?YqwvYyCHAuETnnrji/U/KtPxvRAt2AAMSSkcHejmg+L2aVWDPWizkmxGT9HU?=
 =?us-ascii?Q?pb/3vrssM+pNdygIfSG+f+4FzJT16XLrPBhUxzehrKM26rCwh22yohGLFwoS?=
 =?us-ascii?Q?vQ1C9HePjxXMNQLed6A/Dx02UL4cnmN+kGgFI8incuUlOqQj5nQX04WAKK09?=
 =?us-ascii?Q?WurRhgdOqwP4Y34yXpw8c/Up5hnfBzkcLkLbgI79+TloLUt2UYActK75bt0J?=
 =?us-ascii?Q?bBaPu8Zu2GmVwJLIOxGTERwBcOzXAEeunqTvtNUv7nBdD6bzpuQ5walPYYHm?=
 =?us-ascii?Q?DCjz08SYMyr8y90XYMjeG/klYtALOeer?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7341.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b9VadrghXAC+k0M9VBO/XinK6cHduzXkHMXvcAyfGmpxA2GShcGQm3grwX3W?=
 =?us-ascii?Q?8qAKQoGpGkQht6h3HE48woMrBMFuROcnpdqgpRmgLQrlmOEb5BOC0RL08Ta6?=
 =?us-ascii?Q?d+YTNJPhTcFngyRGivFPyhCLxJfrn0ICOpn54pBwkpZIPITr3dRPyA/HkPzd?=
 =?us-ascii?Q?WMvhn2l8RLbO7yCgHHxVbDsINbP9F1/GSKZredYwv0UgrlqRyTuszLzt7lol?=
 =?us-ascii?Q?fRUY4uEY/E5PhRokSiVlw7GwlnWdxpsWUa8DYKUWipvY1+m0384NA/SX/RHU?=
 =?us-ascii?Q?xnKSAHOe33dF+9v0WRIpj9w4/1V4sgZjz8Sj51yJMh7MGOlT7rNDIC6MnsSQ?=
 =?us-ascii?Q?Uui97Zif9iGyJ5W8LCukFQuNhBoHJDKzhOER2N+0IOgoszKl7dX5AmTp6iZ+?=
 =?us-ascii?Q?N/pU51JwmTrZlzB/sdvYfrfYjnNVJHoV9Tx+Q2LhTnuyNJ/WIUsrk87kfoYX?=
 =?us-ascii?Q?lah4rXPx6b3TPf9T3H+IJD6VZNQR6CyLXyP3AFoyZqX0LfQqxuNPvecfUrdw?=
 =?us-ascii?Q?+h+h+ZX8orUAoFXkfbtzfDO3w6YpsrqiGFq1wDpk4n2Yz+6Uc594j8cqhEf2?=
 =?us-ascii?Q?yvkXKee6i8wZN4lkbWEvZvm6jhC2oImbQW9ZsjXpGn6rgQaJJYms+NKjkvp0?=
 =?us-ascii?Q?esbgB95sMeFcLh39gfE6BA8yKcxoitJXCvxnn8KI1rpJLUq9d+UGhLArlil8?=
 =?us-ascii?Q?HjJrvRD72wqdI63Rh3E5RcejkAYgUx5gMeGZ65eJpcjEG5Zzn9ldOUFJhiuG?=
 =?us-ascii?Q?mjjIGTaiBzPnFQnS9+F/mLZRip7anaQXyzah8Z5i0pNFcsLCuIfdUeCunPwg?=
 =?us-ascii?Q?+WTZJgYYYpExjCaiVgAw9Wrk11IDx3RiDAW9IpsRHLdCGRn50uUSyaTpFCnn?=
 =?us-ascii?Q?qwhOlcZ4xQkL4+s77GHlrDIHrOSvdWLghArOY2LcGuukQ9oL8ToEVPSVuF7Z?=
 =?us-ascii?Q?bi56y9zUkwHf/eOBc+ujHGlGXEfb5lcKwqXHsJrntt9a7tjm7i8Y5Sw9vRVJ?=
 =?us-ascii?Q?C1q3j+3h0xS9SjzpGw2lkWq2zV0RMRywRtHrVoViYqCFjAS41B3fPx+JcNhx?=
 =?us-ascii?Q?9Go9/fAmVZXil1f6Pbal9wDBgiXbZFo0O4rc9/m2gYmZIdr9MGxeMk+Pdc4z?=
 =?us-ascii?Q?wnw2r1y2sw/sTPyMEkbQdHV0ksimCHBdxHu5iyYeQ9c4eEhOwX91PIPy6oDg?=
 =?us-ascii?Q?72t28k2yBe27eZzc9cSsu8w6Rjwd7EDPaCmu4HXTkVAuI1cG0ZY0RFaioVLT?=
 =?us-ascii?Q?1XNZYu15G1WoRsur4eHgeD58msmKTs8h3+2PfvW4QyWFM3t4e6EUaObQxzxm?=
 =?us-ascii?Q?dhthsP7BsUasO8M3Pm4xldOqMV+02vde0fq7rOBGYAT3X2GZhAhlmIDzqDoU?=
 =?us-ascii?Q?vz+iHKasB7x/Np2M4MeYJUc8DqXqihJlm2avwjoXFyMQMxDq9GxrTIOT8K5n?=
 =?us-ascii?Q?Dxi2lmuTVNkSq+MVdN8FydnBuY1NjJ83/Z75Iu3b1j9VgXlk0Nxn235bIVTk?=
 =?us-ascii?Q?QE0rgZ93pT46JHVsS8DKeDkEgAMKS6jJk+Fp9kx/pLD1vnMZFKO2ZJSWQUhm?=
 =?us-ascii?Q?yzNvjPWY5CG8etjGDyNdCLatD9HAvUXKWTv1sfNm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nztm6MMclFVQoBQmRcm2AdZfKpN2lpOOwL1dWW31rWXSj7mfcZFGip0AE/Ru65H4Wh0ogth1psik36SG5xAE/Anvr6t5dLASEZgn66gPW5bp3PLQ8gVsEN4c25RkbDb1yAmPa3jFPSAbtX0fcm9JHhBpYfGObpTZR2CFH/ckIqsyresSbUKIZGkQ5sR6yZ3CpdA8WuXEZ3+HZTEWdluc+stqFImCraRhQJWklgBKsritapupOfopXLqwuHeP62w4mQmIoH4Sj5IeWHYLWLwGS6Z+wAk7gPeCkagMWIdcvTNKYbGtJxP01JnAgLd0XttpkexXiJtojTTbe7D/Q8YA9igBmWfRm+sl/74Dcl8JgStjgmgAV/OW7wq9UcUsoxHGhf4NNXb4jPrCuaUeFR7krMSYRF9sO0nOFKZPyOvWlsD84bFQYYYV/2l/AcuVylSmQYlzk2CJB3Q8jo1s/t76leer1Ph6kkkmBorL6HZOVtzoO+RlrZPlXrDxhYc+DbxvcEhBM94TY3KE8XdzcLSAXoZtk8xwsKsjpN0YObM7OvgdUPByCqb7C1UKUMXT4MZkzkvzoGMTWxJRpcErXYTeYikrz2r8pr0G+I3nb5v27wc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c373ec-2b33-4777-caf1-08de2288a8cd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 07:46:03.9461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0Zq31/fbt6aXkAq1oUD8OH9zknj7hKqtSQOJqg6Rn1ULKxwmODLTfEvwj0NRgj6ankFqMEF3VnBUd2i61SJEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFC82B87818
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=949 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511130054
X-Proofpoint-GUID: ic1qEI0vh3tf3uzsH4PfEDFtslnD3mHk
X-Proofpoint-ORIG-GUID: ic1qEI0vh3tf3uzsH4PfEDFtslnD3mHk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0NyBTYWx0ZWRfXzGa49Q1JWIGG
 yhAsYGLE9a/fNG2TsDU/j6pKVHMCtaTLYDi8CxzSZHxoQ6/XUgsqLXgT+OQrLooMIsru113/CX8
 vt0rnCSbdwU0ZqbQOd3daWnvqZ5DzmaSYW2GfND9l6EsuX6voHSW+8eAZvm16TKGm/YGmufo1zZ
 yRpj5+F88bGcF9Z4WHN6osrLR6ve6DnUq2tRi/pVx3eaZX0kO3U2Lhxz4fmUOHUWSFWWbqMrL96
 Yj9PXcTsMhNGqWVybzxOBm4zoNwIVMj0bHSMu95C5B7/t/oaTt7aLe+EvzkVrE8MkuXMrhM7KaD
 iE19z6i5RDxI2EyXp4dWcnEHf9InEl4Cq0KEr8FWQ9IFmWzzxInzMg0zM4bRcMelGDK8HQgfu8d
 zDdkNecGXSSL4Puq1n0l4PPvvO3PqhBn7Un63KqTKYOQvlUK2II=
X-Authority-Analysis: v=2.4 cv=X7hf6WTe c=1 sm=1 tr=0 ts=69158cbe b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=GjZSFUo99zoroA9jFhcA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:13634

On Fri, Nov 07, 2025 at 02:51:25PM +0100, Vlastimil Babka wrote:
> In several functions we declare local struct slab variables so we can
> work with the freelist and counters fields (including the sub-counters
> that are in the union) comfortably.
> 
> With struct freelist_counters containing the full counters definition,
> we can now reduce the local variables to that type as we don't need the
> other fields in struct slab.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Yeah I've also been thinking there should be a type for the counters
instead of declaring struct slab variables like this.

Cheers to -fms-extensions! :)

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

