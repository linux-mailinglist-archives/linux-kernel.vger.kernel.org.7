Return-Path: <linux-kernel+bounces-723673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC29AFE9CB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1583D1895ECC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ECC2DF3CF;
	Wed,  9 Jul 2025 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RlpNTcIl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f8AG0ytC"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52E7287252
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066861; cv=fail; b=If9+UJhd7fF+NCPe0YhMFBhy6Gx+7/WXC4frbSgDgGFxJP3iFTAvgl/1Q0F2NytQa2YiCZYZZitrioScac5DMGISdbqmYXwqe6wL3+XFm0iYyqUMg138ScHiOoyayTkpl9int3fWjCAT5YnRry+ZYSH1LEmP2tMFsiWeKSVdEu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066861; c=relaxed/simple;
	bh=99AyPySTadO2VmnIyRYKHRxp9yrmmhLMFrnoBf/1dlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iVAkXC9cs3zJ7XW1Xk9rmrS3JSv/krSyjpyH797sMOYNWUs29EQ64QCw7vCB6uncoGNQvQKvccsY+voON5PGbuOT7OBDeLFkLwSJgH6YR40kHLQwT2wHZOd6hwexQQTbhNrCa9mOXFLr8qOmbKv1yM3o7amX+4IEjO91LQa2mBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RlpNTcIl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f8AG0ytC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569CbKwQ008618;
	Wed, 9 Jul 2025 13:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Ta2ib2SJY1FjwQLfEO
	hOvh3vqwip1JFnjYcqlvAZOx8=; b=RlpNTcIlC01DAo4ukQcu+FUt19ssrFUPKS
	VKm8YR1rqnPqd9M8mh4V7XJcxb1po5oSKIcSzYdPMlowvfhw+TG2mCYNRg+A2jVz
	bvacKVlhwa2OftF5zK0B+AZmX/UV4sKVuydKfxrF9xCXUMBfkp148r7sOLPmyxop
	7FNjSKL8D4hKJeevMkgQFg2N/yPDKbn3qlCaGDgDNyVxQWEk4TvYg03fU1vce/Ms
	3r/55nUcqc5FE8uyYBJc+M2UbY1J0K8/Ss8dMVbeTjw6gKdrCCNmv+B2njZKfZ20
	RHjDOVZAYCzVnLON2F/yEKPbelXfe1m9ccsD5CaPmI+VY61yfKTQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47srk5g2yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 13:13:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569D4Mbn024391;
	Wed, 9 Jul 2025 13:13:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgb7adw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 13:13:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFLPfP+9DhI7EhjJCUMtvBYF9ZbQqt1naXQx5Qf5TKYpobqgPXsgYJqmxZURA2bhuHvTUZHjRPYP9I8maAQkVH4osatl0EW7FET3qnfav1fFFf4FJQliw2Na3d9qdUUqxSDJWPkU6Nka/LQeaqaHVVDhQkuQqARZIgnKG8nJIp5MK4ADUKOCaSfkM84olD/JB9j29Vgqaf2UR4fhovj6TP+Y2DU2Kj40Sn+cF0UU7ltJbiKKFm+k78nGQbFXmgd5YtYwOkelqWfQHg3MXnxHbcaKWrmuW92g/0IXtZmcQi4knYPimcAPtxrtSYmHmky4+bEmJs+FqIMLvTuXkCO9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ta2ib2SJY1FjwQLfEOhOvh3vqwip1JFnjYcqlvAZOx8=;
 b=MY1Q743zsP3Fqgen9888cFoPL45YXCQ1c4irBlD5kuc3w0NsRLeYt3wKbFtSzvNF5l4b6BJZzBVqDSRpSmo5QHnuk0oXDjr9twzW7vgizhDZkrXP10s67GqNUUBpprVegKv8RdAG8yngnUaWbF1n2i1j6aFdswEgCiyM5sjHv1H3KAeI5Mreyd1IhRSEkgtBp/fyXWcrlL17xYNuozyfRpO5ZO0FevapYDO89UiiBM3VGqjY2RRn2Z2/Jf2eK8TdWSyyygLDG8MAW9930Vb0WIz3DKm2v0EDeHXUnlPOn9tx7hJuR+LDqzxJd04JntmyOpRGNvD93aEIQ5QU45ml1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ta2ib2SJY1FjwQLfEOhOvh3vqwip1JFnjYcqlvAZOx8=;
 b=f8AG0ytCVaIxp6/upv4c9GetJfTbjXNWTmnLheIRW/SvQLYJVDMr9ZMB2sv6N2GmL1l/cMMPMTTY+s7VpMXaTu/8cmAe9Xq/1rJIv/tGag+nGoZJZexrZgPVb362jGos0D+VVADle4s9UDt+GfMvXXsDH4z7MetoeP1f2VWC6N8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA2PR10MB4426.namprd10.prod.outlook.com (2603:10b6:806:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 13:13:40 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 13:13:40 +0000
Date: Wed, 9 Jul 2025 14:13:37 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, hughd@google.com,
        david@redhat.com, ziy@nvidia.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: fault in complete folios instead of individual
 pages for tmpfs
Message-ID: <d0b24095-d7fc-459d-85ed-9c0797e9fca3@lucifer.local>
References: <440940e78aeb7430c5cc8b6d2088ae98265b9809.1751599072.git.baolin.wang@linux.alibaba.com>
 <20250704151858.73d35a24b4c2f53bdb0c1b85@linux-foundation.org>
 <4c055849-d7dd-4b9f-9666-fcb0bccf8681@linux.alibaba.com>
 <007c4a94-c94a-418e-9907-7510422f8ca4@lucifer.local>
 <23f1c3ab-16ca-41db-b008-22448d9e08f2@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23f1c3ab-16ca-41db-b008-22448d9e08f2@linux.alibaba.com>
X-ClientProxiedBy: LO4P123CA0402.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA2PR10MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c995f8-bcd2-41d3-84af-08ddbeea6c55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/KGQ20bEUvJSnpfOg7vZyGWt6kTBrdPPpqcSO7MOaLrzQNQH2IbQB6Dath8N?=
 =?us-ascii?Q?SaX9a1tZH4U8wHz8VlzkYch2G33mkW3UPKF8cwBNHgJhJmI9IwqJo4tYd+Ok?=
 =?us-ascii?Q?a4Y8i8/+MMjxpLqHY/EnMmC+XbDFy/hMgeqIVlQ8zexDKz91FpCdRIFWmUhP?=
 =?us-ascii?Q?u7aYcgQsshAImkihLuM6h2RyStZRosrYZgBXwBrFjbHNxBNUQrZ5RRwwLSb8?=
 =?us-ascii?Q?5QPxgrRgWth6Qd7KITygLa46hOQDuHCrfU8ToNizZrH5KBssSdC7oUHp7E2s?=
 =?us-ascii?Q?SW6B6oqyvkwmZnHcggNEs33L7UJazG3B+eMJsEIVoUzH/QUabT/wdzmP7Dz/?=
 =?us-ascii?Q?Gfzbq2jSX43WBa8Q/MsmsjEleQ1q+Lm6AfhhW6cz5gLV6HLGAJMvh8TgVoFt?=
 =?us-ascii?Q?RkgdjrVRNb+2OI24n+WJnLzAXNEL5iwmZfCivtkgbbIkJRVdwb98T70WmU/+?=
 =?us-ascii?Q?pXJDU0eH8+5xbfDMfl25RAQ8GfJxVqbwPTICUYJVzc0ITUmQcOKbAuwfi+jb?=
 =?us-ascii?Q?YedVpan+ITop2IRmn5iNh1R/TVHw6yxdyazEjRHIOWsDzLFmPOkUHLZACBo0?=
 =?us-ascii?Q?Tc/zTyFtSbX+BLVdzZaxBJZWfUbUofsUZFaYs/fG4Qgls/PlFtalV9tttB5g?=
 =?us-ascii?Q?HyB5+djIENt6O8T5wfww9HZ6o4QHQMkmh6qjSwLiY542xavjTUgAcrEm/5aw?=
 =?us-ascii?Q?TtGCKFnnF2HqDI59PAjUunRAwlYphA/jPywZ83Cv3kVdJ7d1igY7JoY/j2BP?=
 =?us-ascii?Q?dE/BIQbsHBPR+gQ1nraChH2wbI4X7ZwdryWRt949nQlW4HVkJy+mRX2K+GDK?=
 =?us-ascii?Q?Q3NU5hBf3nUdwtUQfHP8Nti/2ont3FdSEYBZM2G/8fZ8rRHuZU6ksdJRTiwh?=
 =?us-ascii?Q?rPiHwk7Mjp4IPYwmTR1XkSbaUHp8nVBY4sZIUyDO4T5MFYU6GyY5TcWGs9t4?=
 =?us-ascii?Q?vEjsKjdknzVS/dX5slGn+EM9R7XEhnutbcxPc/MGw3E3PtHFPXeaixI4TAlN?=
 =?us-ascii?Q?cmU3ypICUyS2lDgeHWK5PR12rwQ23xcrWcLYObTw5sGpWfV687eC1DyEEmR2?=
 =?us-ascii?Q?uNSNr1GD0b4PlqdOi4j1HN/eZc5qKOcUSucYZZb4eESCAO1V2wH+ebWEF6bJ?=
 =?us-ascii?Q?8S/UmHDYWnBuLEMrYGDmI/0rhszU6zQuVOaD3dy8rNLPUg5nCQkufGMrx+Rm?=
 =?us-ascii?Q?1r91jYHJVJVsEJ63BwDLCMxji2Q2orJMTi/Gic7qu0Erdq1Hk+jMcjrmA4ud?=
 =?us-ascii?Q?Zh817gtJd/s6v/HSaouHzK+c/96UjtDXCWLrS8NHJkFmxqRUKf4dEQWJJwJW?=
 =?us-ascii?Q?aNYj2s/RloXmZrDgy572z0Ia23oldXdSK6KCEAvMVSWkA+ZNrK4d3+B217Ob?=
 =?us-ascii?Q?etk/QBHklVBHTyseSToO4Vp+pb4hR/j9T+j6BzXJuDPkuzqytVZZ3wLDmtNb?=
 =?us-ascii?Q?unmnh+MMcF4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hw7xpACcLt8A54jXv011lqHXlGpIkWexkrnHuKLOmd8vlyteUZJe03wjnaRE?=
 =?us-ascii?Q?z+hzzJwpRoYezx8YpdgZ6s0VoX/yJ0mQFu9WZgWt4YrfeoYEbE/GkMbzqB5y?=
 =?us-ascii?Q?s4VrJC5gV9rFjxyy/tolsqJFhsvaELKablKEpQuKK8r+4FM+ZW9NiC/V6UOk?=
 =?us-ascii?Q?FdTxiQTiczyc12+ayxOritGW/mov3E8fzSV1paPpk+LMVCyp5Mtos/4UnM/q?=
 =?us-ascii?Q?Cq7M83J1NOx2T8NAJbzJCKj2rCXhqmMCDCoiJH7vK/55VIEQCLO6mkdzG6Vw?=
 =?us-ascii?Q?k+blO7UyjVLHPmVpHQZ9XROhKIIgzWwhv3FlJ6KBPcbLVBmHUNjzr4CyRV+u?=
 =?us-ascii?Q?NsdIYT1UXA8/f9fMyF7gAf0ZihqLRg8U1RJpNXaHhh8AeZudzP3KRY+HxVxz?=
 =?us-ascii?Q?I1l3XUKucwOOBxx1093CA4DtXOaRIol2E0GTO2K1K+pDK5tboxsW2j2hGsSc?=
 =?us-ascii?Q?fDO07VsNR5Lqnj9M4/KE8Oz8OzAVDhZv2+gw8cuXXMyoNg0s0pkacBOll6S+?=
 =?us-ascii?Q?0UblJAzKVIeCDZmJ/ONIDBojSQxzFv6HDu5/4La2zC5Fw9Q66rOg94WQpFTr?=
 =?us-ascii?Q?xi03FywXtcHHf1UZBuXnfWswX4WbXYYmT8ivrDSOG/xOmFOBbhpDna3gZamt?=
 =?us-ascii?Q?0g/94N+iIP5ULt40dcmUhcAwwfBsnNUFoNaob2vQkG+IgWJFQEfkPD4GAeUB?=
 =?us-ascii?Q?eiK3/Poqr3V00BCdBx6TmOtLQ1s14IffO4H1oKIguA40woOkGcBWmRWPIWMI?=
 =?us-ascii?Q?D/CBnQdYWX2Vwb/QekIZIkPl/BdfDxCDgg5ML8i1kp5F1hU5crsSS5kWvy3E?=
 =?us-ascii?Q?8ja+8mHIgymCDQu6zryA+wcs7rUWRd0J5vQdFdmNydjqmUSkQcIr+brii2D8?=
 =?us-ascii?Q?oH0suIm2zj8ecG8lize8zZ/Ux9r8QKLnGZMngwJ5FSLDfJbMGM9wLW8akLSC?=
 =?us-ascii?Q?HEbQF1qrjTdtFV3U3bAbH3wsw29ov/nlLvdxa+fHJw3Gn4JlVkPrHI8IDDd9?=
 =?us-ascii?Q?cdB07ZMcQczWOHlcm17WVGzRK66JTjdmDgxbkMlWhFLrQ8FM0eKZWWUgh+3z?=
 =?us-ascii?Q?vlpXydgsKgZgDIGCNyItyQpeHDVwOqKfnDUdMKeaSigvfBKXWZlPsFpwyiDZ?=
 =?us-ascii?Q?DIFZZ4NIV/TsA8hsJ3WfdpntovLCKRlAN/er+lhk4+pGir58GAnSq2H9XLdc?=
 =?us-ascii?Q?MeDTp4BmuvyOypN9Fi7ipfhn9h/IsYyg4BsuNg4oN24jk1r7rgIxPDyfDN11?=
 =?us-ascii?Q?xY7jN2CcbQxOTnBwzVI3h2OUZaddbp+Kp75hJai4kFHypLc4TFctZ3wielMN?=
 =?us-ascii?Q?Rk+saY1MQ4M8iO3opBSu8RBIkOMfEJGvDx+LRwPxv39T9NM49IW555LF2eS2?=
 =?us-ascii?Q?Vq/5eyXKuIKS0LcVkQTyRXT3IcTOIrrGiCcuxz+Vgl+HruxmweK47vVspTEO?=
 =?us-ascii?Q?q/76UJ3dBeZtIDX+tFhSNdkLrCp2IvSoV4JHmt8HAuw6FO+z9XyGmISgE1mt?=
 =?us-ascii?Q?MbFq8w2sJAHLfhV+Mk+rreH9mg/j5b+fLK7NSXMUfOO4+6gq/GScGGCtz4Np?=
 =?us-ascii?Q?2/04+3rNJ+aL3iIH725HoNj3yHHh/jvCIDa7hbnX+B2XO67vuMEw0Dwp+1pv?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cmloAs0WtdYK//V9vMwsth8ht3Q0zN8rp20L5bvBvPPWkbKihvm+N2U7WNmVdrb/lXbHVTuWxI0bQ58e8+HH8j8Dl5W/Ji4YVp8PTJAdsTMvLikMtbV3Z3lDqMkZ2s+rel6jEZj+1XKqWiWw1lABOK+sy+Sqoe38xelmeykSeq7EuCZ8etWGN85t21hgGsUxgJVr4X1RClrgzHFtq0adelGm6cPu6W5s8rx5QvCeHOqr+svmgY1QVkxs32QX4AXq+4WHDoC0zllx0SzmZ/+KGfSd0XyzcBbSSRYrF8KVLh+R37TJex5R8J1uvyF3almghCHYZlnJnYl6ohfdMJh+jR/KvHmYXFe7uVRqr0VkuDyO2zARyxehUT0+Ax74z4C3NaRjVTP1x6SUKzS/t8pBiH6HvfwuwG/9nJ5DwYLIJV0Vr8azKvTpryGXX8LPPnzcNImnkpBDs4ECw/2FOPcHVZpdrarGFFbZ1tLSp+YeGjfWL/Pm3MmJKQJ32lIRS7Li4UQdFAUTTG9/UBPUQAGmoiRQGxo+OQ8cP50/CWj7zSGFX83Ly79rgmJCjsxYvdAq3RD4GyI7vI2JMU891AIK8a+BoYBZU4A0i3Jl9nsgmbc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c995f8-bcd2-41d3-84af-08ddbeea6c55
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 13:13:40.7122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tnl0HzdxZ18nFXroDGlIRNc3EGwL/vW+mPjb5b+EXE2oL5SIGDl6j27GhqfiW2qEa7oUQQwmk3imyjd/6/wJA0smKXZCysA4Wc5E97MtvZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4426
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507090119
X-Proofpoint-GUID: e3SQydBJqhCvCowbqpyRu2VPRHhO4s5_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDExOSBTYWx0ZWRfX+hE7zNqHuWpe qNEz5lQJH+IuZvypMEdu+4ISks6HKR+WMs6CPU2MKBsuBR8iW9KghCfJUCsm47Y5ciwot2cCU3w Bq7uIWZ91r5GQZKbUwUYJPHhCgDE6bqMGvyaULlTVccpP8/35zCxKzhSv7Cr9gHmqTScSBFwG2S
 KuibXERzmTuJE14mkDuUBDL3lViUgOXixm5Bu8+HyTQ5O/0u8eUdpp8qSRA02+qVdMpgfOcgZeE 75XcH1nZuT7foghzeIGRHw2Roq5bwqvL9mv4R8i8SLv3pyVxNaPC6uvAjUZacCXgbh6b8bL4ZWg 3eFHwSagA+78hQCJ4oAIctRIn+evprn3g8P3WMUgsID+k59qwnvFuDPJChpCazSQKi2MsDbieHh
 XkrzHRUoPJeQZa8X1CMk+UbOMwxyePJzQUJPkmEFVUJff0kY1r+uqRMx6c+Ifc3gpiKdb6gs
X-Proofpoint-ORIG-GUID: e3SQydBJqhCvCowbqpyRu2VPRHhO4s5_
X-Authority-Analysis: v=2.4 cv=HJPDFptv c=1 sm=1 tr=0 ts=686e6b08 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=SRrdq9N9AAAA:8 a=TC5ZSXh1eE4sImm5m3wA:9 a=CjuIK1q_8ugA:10

On Tue, Jul 08, 2025 at 03:53:56PM +0800, Baolin Wang wrote:
>
>
> On 2025/7/7 21:33, Lorenzo Stoakes wrote:
> > On Sun, Jul 06, 2025 at 10:02:35AM +0800, Baolin Wang wrote:
> > >
> > >
> > > On 2025/7/5 06:18, Andrew Morton wrote:
> > > > On Fri,  4 Jul 2025 11:19:26 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> > > >
> > > > > After commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs"),
> > > > > tmpfs can also support large folio allocation (not just PMD-sized large
> > > > > folios).
> > > > >
> > > > > However, when accessing tmpfs via mmap(), although tmpfs supports large folios,
> > > > > we still establish mappings at the base page granularity, which is unreasonable.
> > > > >
> > > > > We can map multiple consecutive pages of a tmpfs folios at once according to
> > > > > the size of the large folio. On one hand, this can reduce the overhead of page
> > > > > faults; on the other hand, it can leverage hardware architecture optimizations
> > > > > to reduce TLB misses, such as contiguous PTEs on the ARM architecture.
> > > > >
> > > > > Moreover, tmpfs mount will use the 'huge=' option to control large folio
> > > > > allocation explicitly. So it can be understood that the process's RSS statistics
> > > > > might increase, and I think this will not cause any obvious effects for users.
> > > > >
> > > > > Performance test:
> > > > > I created a 1G tmpfs file, populated with 64K large folios, and write-accessed it
> > > > > sequentially via mmap(). I observed a significant performance improvement:
> > > >
> > > > That doesn't sound like a crazy thing to do.
> > > >
> > > > > Before the patch:
> > > > > real	0m0.158s
> > > > > user	0m0.008s
> > > > > sys	0m0.150s
> > > > >
> > > > > After the patch:
> > > > > real	0m0.021s
> > > > > user	0m0.004s
> > > > > sys	0m0.017s
> > > >
> > > > And look at that.
> > > >
> > > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > > index 0f9b32a20e5b..9944380e947d 100644
> > > > > --- a/mm/memory.c
> > > > > +++ b/mm/memory.c
> > > > > @@ -5383,10 +5383,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
> > > > >    	/*
> > > > >    	 * Using per-page fault to maintain the uffd semantics, and same
> > > > > -	 * approach also applies to non-anonymous-shmem faults to avoid
> > > > > +	 * approach also applies to non shmem/tmpfs faults to avoid
> > > > >    	 * inflating the RSS of the process.
> > > > >    	 */
> > > > > -	if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
> > > > > +	if (!vma_is_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
> > > > >    	    unlikely(needs_fallback)) {
> > > > >    		nr_pages = 1;
> > > > >    	} else if (nr_pages > 1) {
> > > >
> > > > and that's it?
> > > >
> > > > I'm itching to get this into -stable, really.  What LTS user wouldn't
> > > > want this?
> > >
> > > This is an improvement rather than a bugfix, so I don't think it needs to go
> > > into LTS.
> > >
> > > Could it be viewed as correcting an oversight in
> > > > acd7ccb284b8?
> > >
> > > Yes, I should have added this optimization in the series of the commit
> > > acd7ccb284b8. But obviously, I missed this :(.
> >
> > Buuut if this was an oversight for that patch that causes an unnecessary
> > perf degradation, surely this should have fixes tag + cc stable no?
>
> IMO, this commit acd7ccb284b8 won't cause perf degradation, instead it is
> used to introduce a new feature, while the current patch is a further
> reasonable optimization. As I mentioned, this is an improvement, not a
> bugfix or a patch to address performance regression.

4Well :) you say yourself it was an oversight, and it very clearly has a perf
_impact_, which if you compare backwards to acd7ccb284b8 is a degradation, but I
get your point.

However, since you say 'oversight' this seems to me that you really meant to
have included it but hadn't noticed, and additionally, since it just seems to be
an unequivical good - let's maybe flip this round - why NOT backport it to
stable?

Cheers, Lorenzo

