Return-Path: <linux-kernel+bounces-823577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F268B86E1E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F5C481147
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EE53101AE;
	Thu, 18 Sep 2025 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I7Mj/zjc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j63DkIsB"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355DB2D63FF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226858; cv=fail; b=DVTF/8D/tYU9uxMIvnyTQnrDwNodp+VoJruGEB2v4IOU2aB/GwK9yUHvgqBJaGcqu1DOgMGhVTKH438oYhjqjZ9Ricw6oPp1sMjEUMVovjah7JTiIM3QwZCUOU1ooCl+q4wvu9mzJqM7C3dkf3P5Hl+536HGoePeyfcZ7UN96d4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226858; c=relaxed/simple;
	bh=aFl4gyow+qWBayHWucv2RQLup6l6cgYuTPURwRf+c60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F3yUusveH2zM7PqSguP5SzH2eEKhGYjOgpEeBLhhACczjAaDyKaHsX+zhJMZxzQ2sgPjeofrsum1xIzlYsZM/7xdv8zXUDvtTHoYfMwDLgKic66TKgsyL1cX10sOOSAJdW4b8kE0nbq8Gfomf4Oss9OIolruQb6mDA4Tsez5/ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I7Mj/zjc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j63DkIsB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IFuJl9007055;
	Thu, 18 Sep 2025 20:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=0r35XL0GwAZwChYxIl
	pnGwNr+4WmNbYKHEKdP10Qk6E=; b=I7Mj/zjc+6w2gD9Ikk9spNQ+zlHUTNGv5i
	b6FGcvKeRCJ8Mlr5AVgvgae1hATB7Cl9pAXgASUtSY0I+BG836j4+d/DwDhiFodF
	V8t2eh/ZKxGss/EhSAJ/D8Wjx06zgy6pUh/pUy+ohHy4yOBBmzpmWnFjhC4MJfSb
	Z354NkNFIcZEgkSlj8lTJAyJCcEwg0t7kDU+67QHBP7W6f4tXZSInGfWJAQvBmND
	8hpiR+QC7KK2849SnjvFhoiMc+lPuL9tBsQ/gAsmI/9b7U9UjLlFhb1vJ1nHgfiu
	eW/YRMcOs7ByF9hpq1N2uZR36ZgdeRU3NhVljmw8O/PXMWUTOzvw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497g0kcchy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 20:20:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58IJs8NA027235;
	Thu, 18 Sep 2025 20:20:38 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2nxfb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 20:20:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9kj7kPNdP5zxq9/zXV8CA7sPi5OKfKaSeb2XSXOTDcgSqaegLQTRSrwbqewaXY2htYqr4GlsJkzrwFrKKsEIfXFBoBZE5dNN9gqy/m+TE6ifZ0Q4VMrmiHMcfeQxNFBHyzCVR/B3GQfCH94+cL6Q8e5mHAz3627KR5cQq78cOgaUayI+pTQzexMaKTcj+9JiQ1JZaTrc5SrZ3rMAplNwj8DIMNHQHJ60dzyuEu2BZBHNCbMu4oICHqiqN+lgVLXzUDrNqK6v1bGWDxAS+wwOQMv/RQreR2J6ESD5bGcJI4asII/WkLhnQ+5m/3ZSi9FhDAQG8GcZMloKR2ng9QhMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0r35XL0GwAZwChYxIlpnGwNr+4WmNbYKHEKdP10Qk6E=;
 b=P5skNUqcCA6iUdN3O2lViOAgF1zMVpjozmrJl7U8YAnQ2WGO2mBtkV8rEKKwjQZ2/NsXuQvwjhvdjLw8DRfVqimabqxCkL+BlDI9LidgXA+VgfrC9ssRWX2CIvHegFEZIxpmJBhOUngDhwOJc3/xKCYIdyQQdt/TOLNEwWxuGQrEiN78767WCqShnNnGs/o8lqTP7wMElmEdLa91FgkrbtWaRPSWU+M7/ELDsWNo/u284ShfX0yne5k/RTZQFhTAzCAFd4IS8Pfl+CWwg0nQPKIg8gUXDlaTxVR+SJZQ246gil5oQKkHXpZUXS6OCBHsi8/oEJ9vWQuZOGPU3/G9vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0r35XL0GwAZwChYxIlpnGwNr+4WmNbYKHEKdP10Qk6E=;
 b=j63DkIsBlYXlNpwLG0/xFvQnhkQC7JJ7Ntg2gJKSdWYcixpxKGW1Ttt40ty7Svhaheun/6zp6Qbjktf7w8Tt3+EaKnS0AkOwzbPIpo4ZupmkPNUHqcHiOEI+we3T9idQIZY2LKgEi39KrJBuSBcgLylLCOZY+OibKCxqDGwOi5o=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 20:20:36 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9115.022; Thu, 18 Sep 2025
 20:20:35 +0000
Date: Thu, 18 Sep 2025 16:20:32 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Gladyshev Ilya <foxido@foxido.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] maple: fix incorrect rewinding in
 mas_empty_area_rev
Message-ID: <4a72mtf5n4mzirudx3z2z6b72ropqs7f4kp2dlezkib4k5em56@hiw63iieahph>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Gladyshev Ilya <foxido@foxido.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250918182544.1400748-1-foxido@foxido.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918182544.1400748-1-foxido@foxido.dev>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: MW3PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:303:2a::15) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH0PR10MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e48ebec-3b2e-4034-0c0e-08ddf6f0d371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xCrc24S7jrwhMjck+rnEASqb/FBFkMweZmZ5XHSx02daU0ylsXQMWH0FG5Zq?=
 =?us-ascii?Q?/l5BB8oYLaw7SJJ3vYAemFWYUveVdmNFBzNKUlEoy8nyRZV6DbaJEqtxPKtG?=
 =?us-ascii?Q?AgNEyUW5s2KTtELmSQp9OlHOLzyAJM2OVz+vWHY4L1tJpS9drqUO2NXcdrG4?=
 =?us-ascii?Q?nZi4RIK5DfXcovczypjF0Ra5GWVrmvuDzRMv85VsmKpvaExAQpWgUrwa0Wcz?=
 =?us-ascii?Q?WXdB8A6vgO9192XPdydOAy99PYwWKOIf/sQE4SKu/nkk6dlAoC8KXhn5Fx5n?=
 =?us-ascii?Q?04RSBz8fGGlHOLSz9E1r7HAxK1Z9CQY8mmagO7D9JL5lNnw1hpVhalqPU130?=
 =?us-ascii?Q?I4yoFojB68ISxxSFqcE5uj56QgJnY+u1vPRlc373zLHBtPfNblbdn7B7gTFT?=
 =?us-ascii?Q?16OWHYnzCyOVfZVDqc4GwsuM6gK03McsPmfgCqhaLsqIuVnwgzQRjwwCqFXy?=
 =?us-ascii?Q?mjP5beN7SMtMETgPkrzn+jSSjNPqIlZpohreWKTZq+gPB2Cf6HL0HwZW86TY?=
 =?us-ascii?Q?qhUjFW8N6dyviqAJOWnK0hiCqKCP3UJEaZ8GGveFGzukZrorsSgd+0xqkQcF?=
 =?us-ascii?Q?WbjIkj7rzNAYcx4P6S3DrdCPbhBfVHU7zRAEraT4/3bN3uL5czslSPV8LwD3?=
 =?us-ascii?Q?h6gtd/Msh1at+Y3XJkz4XhkH7avQK8GTeO6Y3XDcVChUw4xLn0cdGnKcFgwt?=
 =?us-ascii?Q?sZGk37lnRgEKlepPzN46CklvRHwmViLXm2D0ca9Y2MYtl36nf6OE43hjvlFb?=
 =?us-ascii?Q?njsz7HYZNWxncoabS2bshAay/qcPRp4OB9wYTOOQasjeC4yOyL7Z4LakkuF+?=
 =?us-ascii?Q?lUbwn3SYSw/wvWYb5QWnFfAjdfqyj5NXCdqt9tYFinUxfpAkxLHczU7KVYpn?=
 =?us-ascii?Q?JiIanviMxsHOgb45VqVAKXz64wHlE7ch2rFugjEUV3SmSz0rRk6vFt6s0WFx?=
 =?us-ascii?Q?rI8Wm9fTzUG//bPKLx4ebIRIpLWRRE55CwyrovYN/+2/EjFl6WOzY9Rmer4i?=
 =?us-ascii?Q?0fj4kbJMek5iJQxM2C5aw1h2IstARaqvZwiNHk1XRAXltyqwK67wDAspSzJO?=
 =?us-ascii?Q?Ljd7kNG8M0bEqMtmOaQFHYmSD7gOsSZ41MrLnXDWyzAJCZ2sHokDcl6SmC9+?=
 =?us-ascii?Q?DYCc1J/q8MUPEMEjlGNv7UtK4llGRqE7Ke7PvVVac6EwxT44blilleEi/pj9?=
 =?us-ascii?Q?bKgqYbFHwKtZj/kWlDftksWSCvR3K3z3aPVPm0FVKoStTIv6FRktClNwZQwH?=
 =?us-ascii?Q?/N+hoFw781kG3+DKj/xJWAWwa5HGpbqxeR98waR1G3fizW4lDSUVqEY3HBTe?=
 =?us-ascii?Q?/1iKk7+wA+M5XfdQypg74jcjZ/h43fbSA3qDAhSRsscUK4XNkQy5ks/8zZ+7?=
 =?us-ascii?Q?SN8UX36uaI52l6MaA/BkrjTPUuoblOrYgCZNKRD3emZPBprpuMNkokRaZK+M?=
 =?us-ascii?Q?T5Wdr0XLQps=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AHqd3wdV/jb4GcqpEtLz+yZOdscyj22VlGsvj8xDu0I4S5qv8Ygz8cCRmMyj?=
 =?us-ascii?Q?h6D75cJ5wbG/GuJwpIYE1znqIUimCAWbK+Hvo3PMg3Fo1BZWyBC3GtciftOx?=
 =?us-ascii?Q?nIRlOwMUL+Z9O5y+ydTemixZWJI1BjFTp3pM19IhNL6dOGJ3uh0ALv+wmMuq?=
 =?us-ascii?Q?dAX7VFm3tmkDApuG1q2i0k+ngCJ/4yMX7FEYOnWKixz/xRNZ5oxAt9Jbex1u?=
 =?us-ascii?Q?Jp7+nrRvabsNpZYeNRv2seXnB7493WOlALyWkeeYPxnAdlSrUyhVv7eMdttK?=
 =?us-ascii?Q?1M6tKw6UPBMjEL4Gt5l4+hwRnFoKzDLwH3b6/6DSSBJ5/dEL7F9+jjyiEata?=
 =?us-ascii?Q?RFRIAi++81XPXfv2TwLntLK7MEvamFkdt/PB0daDjPuZjuUYlQ91KRzP783G?=
 =?us-ascii?Q?U2G90Vwwyxqzn8MEbGGJi932RAk309WvqlDyXju0kCcLAztPbCztOOO6JsY1?=
 =?us-ascii?Q?qE6+/hgL1kXNXsY76EzOht0nRQCVl1FnewuHWfwauaZaZnao0RHN/VRBfiJB?=
 =?us-ascii?Q?S3LBt+HYlLSZsgjWYjVk/5nMcJpq9X9pUfprj/EWPC9V4Wpsmg1P8LyKcB05?=
 =?us-ascii?Q?Eddi+Ntu5BdS5XdPiw/tVZLNEcBCSfF2n60rwJb+cfwSflrKb0er+Eh/Z38/?=
 =?us-ascii?Q?EWBAGgtHxYzrnx+gH3y9p16Y4LjhG3fdnO0NO/KX0/SNtM1nzhqGAWd+tArX?=
 =?us-ascii?Q?gksOQL2xuPDkT/i+XWXcurIaE9/cA+0oHAGldPhADJaC3CYATmmNOfXEB0hs?=
 =?us-ascii?Q?RX4qWg4L2OZGEvuzx4llM2TMJfQmFB/gCkUhvANXnrWbTVfUVvA2E7zgJosg?=
 =?us-ascii?Q?K8Kj8pcDCKIyRr4002s9n5nEPMt/ecDN7tZSVFwJ5JJWi38vyLyITYVXB1VP?=
 =?us-ascii?Q?sINusaDQpKOUAPuMjM5cuwYP7psS5BRyfVfyZFrdeTSK13iW9ACAGQ2QLQ73?=
 =?us-ascii?Q?nfIOCHb9d1UBxjz6RRyuQvSgQUgRdT2WOTLa4XvloOXRFtqXij8TMd2DDqAb?=
 =?us-ascii?Q?hycNzbsrhLM1krm8azzIhR3c7gg1waMnsAMdj+Jsr8rPHHcUe0/ktAAHC5Kc?=
 =?us-ascii?Q?IMq41pLAHZJJmzqhRByAeMNyPKnvYgRFN0LpkCYu1WkzpsI8no/o3/rZtJwQ?=
 =?us-ascii?Q?i1/pEVgcdNe/CLUH++COfbdU6CiRtng+AXig1voclaPH5Md3XSeozieC67aW?=
 =?us-ascii?Q?sgrK7hdGPMD5WrHcuajcKDOS0M7cEa0T8wQH9BvRQQim1WzU6/HbB+cG/kt6?=
 =?us-ascii?Q?eXijmHKs0FHsepTrdksBvz2gs75bIgqb2C8NfGvQIjKK62OctWbHAtmfQEdv?=
 =?us-ascii?Q?bOpMUFu5BCi+kpk4+B4RKAfd6QZ6Kx1tzG6F3wVr7pd4mnuM4NT6suzt0Cl4?=
 =?us-ascii?Q?Y+RZN/sZ5c5IcnyqyEQfZQfVQJbsrgd9wcibBI8s1SwSlrlrLiHPz7bEYU7M?=
 =?us-ascii?Q?MT2/WvdZjVBb6K8prmrhCtGqbKWrUy+j0xi0ldpNiaUV53GqwO4Ubk9NkNxP?=
 =?us-ascii?Q?/w5jA6B2vNGU+HtIcpxUkQ4uTkSKwET7yw0w+hS6nLj+skvI4DFXA02jKx93?=
 =?us-ascii?Q?4KodlirupwXCzEvPdyD0i/QKuEwglo3Zk1bI575P?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VBJrIvT7S45YrD+TKNWMC+vK3XZ+PxR+X8wTJo8QIk6RVE+1aqem2RIac8pShKYjKFuEZouDbxiTJBTYAOs8Uh6zu/t4E26GYcjz3jas31fBCEs0KcqNFG/nHdXVYzr7SQQmNtswUkVL/Fzq6SLx6u+g0KZxktXOKDZCzIXzmPZJ9ZgGjn2I+dR6XzCswG195gdSq5fzevb+eRyBc5VBUEpXWjJpT3R7VFpRhGQ9Qm5+ypvLFmMSaIEMvHz6+Q6D7sJFMDBZ9Bj22Y0Tl/8h1KST+ykgqJFodrzcd+51ppOBKPzmsvgxGr69/JENzmn9M4O1SZVIJTaHDo1eNWwpBxyS+62991dUbUC2pu6Pc9tB+krlCK4+mIn+ynV5Vh3vho55JIX7esAGq7c+k1KsMNKI1yBgydMjeLLPxA4Ncdz8DiHs/O7vahFf24T3rKmS9LZgwraUFJNyylVibT0Qubb0Wl0f7UmUlwrC1m3sNFdGa9RsUCdBVrH9sTnG7xqEvFWUIxdmtQup9uq/hTOtZpE9995CfFDnQlnRRzXF2zT2VCkevm16U7HzgqkdIrJLEXYXk9SKgQm/vglJBcYdsC//wAfqXB89AnMiSk7T4v4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e48ebec-3b2e-4034-0c0e-08ddf6f0d371
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 20:20:35.8512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1uhb+OEBLB2bTsewkPP8n46G+dUtqZStpYfkP9pJjw7y2LwWidupfIhgsUKN6+d887ABIZHm4w/3Xhx1QSATw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509180181
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68cc6998 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=qmrATZglqXC2hZybYncA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12083
X-Proofpoint-GUID: 9HUUhP61NHYwoVC39iF9pXdwNFCi7r7S
X-Proofpoint-ORIG-GUID: 9HUUhP61NHYwoVC39iF9pXdwNFCi7r7S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMyBTYWx0ZWRfX+MpeUVBv374s
 TeDbGzoZy2z1qPU60HSZQtxkRahw03gNOxyGt66kER44jD3XoX/l0wvMGTqOSRoeEYX9JpMgYep
 8tZW/RmaI0ktpa/w6Tqm9YYXCF5oXzqcELr2tv6owR2Tb+wDB0ydUv777zejwt8Js6Z1qLkgUxu
 r4GMtU39lQgcokswHg3vlKE3HbhJW1E28+z/vHwSsQXb1sK9jIGODbA4HM8lUwG6CEJfZtGAVjP
 mTw6SZQfx+HoLZakgrMdfwBkJ84sqaj1bvZHnPYEgPSaH+hDVhqIbLmMT1zyx7m5uuuCytnH0/f
 Xqp1UkDsMuxRUnLZ0UDX24XmHiK4fszxBFpcu3EmN37lnY8DnfaPId54eqG3z/HLSnYrjmgC0Td
 z6BR5sHaYQIgR9Sze9arj0/dNXQ9Jw==

* Gladyshev Ilya <foxido@foxido.dev> [250918 14:26]:
> Previously, mas_empty_area_rev was rewinding to the previous node if
> some offset was cached. This could lead to incorrect results because a
> useful gap could be skipped. However, this was never triggered in the
> kernel because mm subsystem calls mas_empty_area_rev on non cached mas.

Can you please produce a test case, ideally in lib/test_maple_tree.c or
tools/testing/radix_tree/maple.c that triggers your issue?  I add all
new tests to one of these places so the error does not return.

You can build maple in tools/testing/radix_tree/ and run it to run the
tests.

It also helps understand the issue.

> 
> This patch unifies the rewind logic between mas_empty_area_rev and
> mas_empty_area, so they both rewind in their correct directions.

How are these unified?  They are still different functions..?  What is
the correct direction, in your opinion?

> 
> Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
> ---
>  lib/maple_tree.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index b4ee2d29d7a9..c7790fff4825 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5138,15 +5138,15 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
>  
>  	if (mas_is_start(mas))
>  		mas_start(mas);
> -	else if ((mas->offset < 2) && (!mas_rewind_node(mas)))
> -		return -EBUSY;
>  
>  	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
>  		return mas_sparse_area(mas, min, max, size, false);
> -	else if (mas->offset >= 2)
> -		mas->offset -= 2;
> -	else

This does not make sense to me by inspection.
> +	else if (!mas->offset)
>  		mas->offset = mas_data_end(mas);

If we are at the start of the node, go to the end of the node.  If we
are continuing the search, why are we restarting the same node?

> +	else if (mas->offset <= mas_data_end(mas) - 2)
> +		mas->offset = mas->offset + 2;

If we are at the offset less than or equal 2 of the end of the node, we
advance two slots.  This is supposed to be going down but you are going
up?

> +	else if (!mas_skip_node(mas))
> +		return -EBUSY;

Go to the next node, which would be larger addresses or return -EBUSY?

>  
>  
>  	/* The start of the window can only be within these values. */
> 
> base-commit: cbf658dd09419f1ef9de11b9604e950bdd5c170b

This function is to find a gap from top (highest) down (to lower)
addresses.  On entry, it needs to decrement the offset or go to the
previous node.  You are resetting to start from the end of the node or
incrementing two slots.  Failing that (which will only happen when we
are within two of the end of a node), you will go to the NEXT node
which seems the wrong direction?

Can you produce a test case that shows that we are skipping a gap?

Thanks,
Liam

