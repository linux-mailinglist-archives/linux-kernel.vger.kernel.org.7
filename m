Return-Path: <linux-kernel+bounces-788858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C533DB38B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A27654E1679
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850763002B6;
	Wed, 27 Aug 2025 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QioK5NgD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HpK5Qu/1"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45E22E7F30
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 20:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756327530; cv=fail; b=jTc+JW6cwkdgKsyHpQENPFqGYm5JBIIrLzNQzcphsPOz/0LQi6tLzduO9nLnDPJ5WE2T6mUeYnbqWCD9JGK0WjY4/qi65f+du23Wrsu10k4oYhJFtb4lZzwhNpLcVSDNeRI+rsS6LF6a2tKDD3LQ9AvJWwVCF25GqQgetnXZCuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756327530; c=relaxed/simple;
	bh=PoTaGlNvrxTQ0GuvsSYnXIv5mrOnzfQ9nJPlK8f4XL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qAUgkfAnW7Zs8n16P9ORaeiVeZvsgTNBCkEJ5oJAxFBjoAiDVXO0BlkhWKCt0C+0Q8REoThvpRvPYKPnlUwXeNg/koxNPaxtDj5ViQvGc0TOLp57y7gtOeEjmi/mB0Gj81WtaEn+QqneuREdix2Yzyud8oSmQQvgATpk7KIrBDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QioK5NgD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HpK5Qu/1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RJtoNb023620;
	Wed, 27 Aug 2025 20:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=qUgvZLe9Y3e/8R07y0
	WvZM5pA5p94cWZn+OhWH6HNrs=; b=QioK5NgDnRDWKou1zD/agvZXRcdlHm+4n7
	o4BgNBeMy6I4hGscwvT8uFbzMsCZbJAnw3Qt8GrsrD28+AVC3kcmQpc+zUllH2Gs
	iMS+0uuBCFajtiJBg8vjhign7T5mR4WJA81sB1W+Kl/qN0/wohQ9XLibwbi9g0Zy
	MbUEGh7UyyVctBvBGvJbLMTv2gqAP56sx2KZn7cnbKBs6IsdluMaG+OdEVGGGI4P
	yuwtjskcxN9YVMwYOxyBgXFnXEKCTkrepxHzgr56a7F/zuZu598u+Oztp4dqQ+Xo
	fC5haI91KBx0TFyEKT0BEquXYdmXcXXT0J55ryzNMCRIubGWPtow==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4e27cpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 20:44:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RJ93NH018984;
	Wed, 27 Aug 2025 20:44:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43b6355-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 20:44:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUm0UnZCNVSEG4my1brWJwWGVHAn8nST5R3HOhGCXEal0DxFfl9hTpDVNl4vIu5v8sS2pTqvzMFUOQnQX8b5ZYm9dgYSbPAlrwl369TOiosi/K9w0EkqRh60GEk1Mi/OLobZ2LJ5iv7JO4AbNwXZ/2xDwgfAu2ONS4aPezi+Pqau9Szke9jtiBo70weT0lwGHDfciqJYjk7XpTUxybgoo2awJEH2Knxbn6KkyWO7y/ntVDerXR/2Q765Loqv9SEIzWAh5kYYP14ph3fQ2N6rhyaJgupYMCzM8T2bHb8M9aKVDTRIkGxv27Tl079NbPfgSU16uv3LVJy8VRQuyFJ1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUgvZLe9Y3e/8R07y0WvZM5pA5p94cWZn+OhWH6HNrs=;
 b=ix6GyTOH6pkn8Vn+iHjRuDXQLPoSpYNEY3j1OWaQ2weuKK9mULdgNI234DGApYL0bCaG/NDLCQLZPj0VsV1Z7UdPLqBOC5f+yreoyUTBsKb/78ymRqGBRheVhgvVcO6Px6tFTq7WXs6lXs7CrhwN+IZxGAltjMIZkjNMPRh+SEaUXJm1TLkHHZwt5Guvp1e+3kicQ4rsgWPwtLJfVAAqqDr0TGZ8KeHGPHYwjrAlGemGcyiDwsq8rJIZ7ZqkEyDLRZnCsFa614zo2CUExToeqp7gXbO4PR2G0lfmFRQ8+9H+k+7HYYzo5RrL/2Z7oCVi4NlrR3R6D0k37afxg3nmsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUgvZLe9Y3e/8R07y0WvZM5pA5p94cWZn+OhWH6HNrs=;
 b=HpK5Qu/1Dj8OxUpwdvhzTBKTkCJVSHQEx5lyeTQZICw+ypDH6GDE4620rTtBwYZd5ThwY+v2jOevo19Cct8v4DcwDToXYqpWtDx37yXpxbcXqnH9eYF/fEVVE3isbFkfx/jZDiP+8vYkS/KYaJ88XiAm2ZrzFDT5dgZLbr4AlHg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 20:44:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 20:44:30 +0000
Date: Wed, 27 Aug 2025 21:44:28 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
        ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org, shikemeng@huaweicloud.com, kasong@tencent.com,
        nphamcs@gmail.com, bhe@redhat.com, chrisl@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] huge_mm.h: disallow is_huge_zero_folio(NULL)
Message-ID: <6e6605f7-0249-4c5d-afac-e85e8536b0b6@lucifer.local>
References: <2aa3f478-9c87-4102-b83e-bf235372d834@redhat.com>
 <20250827150330.280399-1-max.kellermann@ionos.com>
 <30f52bf5-ff37-4e22-ac57-7be0b03b1f51@lucifer.local>
 <0de24b30-70ad-498f-9eac-01596c8713df@redhat.com>
 <4927ed52-a250-4ae8-b596-6f81020eb31a@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4927ed52-a250-4ae8-b596-6f81020eb31a@redhat.com>
X-ClientProxiedBy: LO4P123CA0436.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH8PR10MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: ab9bd68d-9924-4306-7e37-08dde5aa85be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7GwqSCkP0B6N4ArsDWFwKtU0FGar5c/JJLMIMmSBj6BIwOxnyKGAE8ZWi6FP?=
 =?us-ascii?Q?BoAni2myDRsnnXJE7ps4G3/UyUaZ4imY072mhvi2U2ucNw6YK/w31GwtRI3k?=
 =?us-ascii?Q?QF6B29NHiByLIZCt06g6ljUeMB7n2l+kzEmFf8TAGEkzJqG7LnJiDLx8I7tz?=
 =?us-ascii?Q?CwUwB05Gx+wiUOHwjTElRzfWkKdL+HefA5/717fMSmVbj6tj/vHFAF3erT6Z?=
 =?us-ascii?Q?z8V6nhVEtaqLznWz0BuVxkSRsxve/jRt2+7Xe/Qpuxfg+KsHrteTbSe15nOT?=
 =?us-ascii?Q?iK6rv+Tj5UvI1j8NFJb9LAKnPkop4W0PprKuGnO07bevm8PY+vb4yq+ZmsXE?=
 =?us-ascii?Q?GINfpYxUW2kI6O+9cCoGP8s2TRRvDoSZ1g5h4/6jR7t7MdWdI3l/4V930hDG?=
 =?us-ascii?Q?mgpR5sW34zhVLI4Qu2+JZh/nc8wT4KgSO1ciL01uMcJ0cRgVZ/X12Sm4/k84?=
 =?us-ascii?Q?upIWcdTdcVquD+1fKrSXpiSJ7s0pqNrVgca3BIPon25W4YVDPmXs9ZDFlaAj?=
 =?us-ascii?Q?2gL+SYStsm6uriVmMOlYJ9tBYhaSVBh/3J6X1a2lYRD/+KPx6lgkz7shJU6p?=
 =?us-ascii?Q?YbkG1BMJfi2t6job6IwmbZLlwEjY26BCdtsFUdhhtBkth6aRCtp9w9D+sEni?=
 =?us-ascii?Q?0e8rI0Ev0Gj23FQQnVpGIwjUjKdpkaO8hjd1WJLR4xRgzpmWVSiFCnliGAP2?=
 =?us-ascii?Q?ROmB556RS3QMNaT69wsrPvYTGRZOY3XPeXB0CjbkJQGEf5esYpbxvZ9A7tvP?=
 =?us-ascii?Q?ihJ7UekNm/RsMkb+RjARCm5RAEqua0fpDSOlCgh0hXcdN5EkO9a64+HfoOQ6?=
 =?us-ascii?Q?sLycqi7QKgN4htTQWXTmgV1/9YhqZkBhy5AJ28lsvkFkMWBdE8AcFoico0AU?=
 =?us-ascii?Q?q0sHZlHsr9OBvvIgORrSDQo9LBYGM3M+kdtFZflbju+WlSfyyYahdiD5W0xc?=
 =?us-ascii?Q?lYfowDa4m+6sawHsnBR9HlyhGKHvgHwq4c43YrU7wQPG/dByTzQOZI2J/Zzl?=
 =?us-ascii?Q?4qNilqNotOyiZVktep/cSJgcKZfxRVSkyNHHSphHdKqrIbQnJncN5TxQiAD6?=
 =?us-ascii?Q?D10CPfgEo41Ndc2st+lWaYjgVezvWR82/QxXz9OKfcIezvrsPLSh9/4tr4Vh?=
 =?us-ascii?Q?juBjaFzhdf3wrG2BfFKDUzoGC+6KQb1LnJPEExKsbhRvaLjDIMxCAzCR7PI2?=
 =?us-ascii?Q?5hCDhzJvUOjnfx99IFWbXuLovZtLP2bcL0CuizYzETB1xpmJ14zROgposdPA?=
 =?us-ascii?Q?1GeeWRyfWCSnMCHOZ4GHSeSoVh6d4vcsT1CcSu1oxtpiyOP1oen306SjPiVV?=
 =?us-ascii?Q?TAaikZw9ahGRU7yDxNiY5yGlAzMjk7VIx8C+cpQmkmxrncunNyi9ZlRdye1i?=
 =?us-ascii?Q?tGn6CwSlEPVd/0dCzgem4JkreTFNd4NcrR83Wl2lkPQBhjp0Cdy+E/SJ5S5H?=
 =?us-ascii?Q?WkMXnWeHmZU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QTSgFtB0JduAWm0oi7zz4nppBuKgOMqz01zIIgHA/gxQ+1hOadnUq1QSRtEi?=
 =?us-ascii?Q?32iiH8zY6jSDhSbqSeEH81Amc6n4+CtiP1o2ecCx8n7ip1FDe8BpaBLnFqLf?=
 =?us-ascii?Q?7VCFO1c8W04n/lRfryQ7vrbD01XTdL0ylSAD9PFofcOGM1ZJ38Orux9SN/MB?=
 =?us-ascii?Q?Pc2x1H07cRQLYZaLgwL1TpP8w3LcURRcQzDvSnDOwr8F5yg/Us0xzh7ts2M2?=
 =?us-ascii?Q?7gnGNXi+gS04bDGVPMwS2fgFqLOBhICM/kFx8P0KMvzQ5yip40HX0QgPfZUg?=
 =?us-ascii?Q?WZpzGVG2SGB8599BmvTiSSEuhWzwP4z5W7tPoBEY2YrdE4RlsOnIcrkzwum0?=
 =?us-ascii?Q?LksUy3mKkPOUE12ZUBTl9B8yq6dZRqc/cCypljVCWkejuDs//vuKfVMT3u3K?=
 =?us-ascii?Q?KHRe90GsoXC+hWl9Y9/1Id5mcbu6mSliU9VTiCUwQEGurRaKh9k0ILCMfM1B?=
 =?us-ascii?Q?VMORURHWZoV/rsTnjDKc9/b7IDcp+hOV9xGFRbW1fps+fk7HrMdl5Ixvyith?=
 =?us-ascii?Q?+k2jNZOpffEtNC/1TvXz1sCtPzvx7/GTmH1USvNt/pok4ZsBLD9D3ZcNjLpP?=
 =?us-ascii?Q?B70mDowiPNWFdTjtMPYw+SgSYwgY7GIpQmYcSP9cKSzVLIQ39h5TekY5eDYG?=
 =?us-ascii?Q?VvBZ1jAkk3RMhLzEKUt/de1+QGtRPKAKbjTdKlyWvzbSOk48WL1lBilVgt+s?=
 =?us-ascii?Q?u04a9sk9YXJ8x+Aoj2EcYCmVAfbOJ14JII7koqlSfRfQAOljwCcvv5PmWNAB?=
 =?us-ascii?Q?SXnPMg1C5TNBU/yxtsAc6PwlIj1o5VzAxxXRWSqsN1LfGR9rqKkbpmdnBmmc?=
 =?us-ascii?Q?1KedRo/uJPlHide1HxpQUJ3/4vT9Ozpun/NrVP0EPaTO1HQo4VFP5yMwPYQr?=
 =?us-ascii?Q?adBUF7jrYHTiMUpblWcxHyDl75NnFOgnf7w1OWfaoeuyTz066s5kuIbEh+tb?=
 =?us-ascii?Q?CwPHoniWIRuFuPW/Rcbozq4mUXrv2AdbPW36YYY5pumZTU9fo1c5RK7adxnt?=
 =?us-ascii?Q?iNdkb2uvku7p/PK+XPguWirdhlu/8VNwHTHfR7oYZpsiMzZMGx/MTrftzUXW?=
 =?us-ascii?Q?ZdmzhMSjK8FHj5F3qimNzWe3ky4OjjXNm+W7GyDZ/ehxiQGdZKIwrHG+YDrS?=
 =?us-ascii?Q?bXjviy7XPTOLC7LdWZARE4L7ut8RNCoTETI2AlUePajotNB2ETl0map80zr+?=
 =?us-ascii?Q?W/NJEReEcbca7h2B7ogOsTAeInIdMwmEDjRcBCG+lXrMc5AfS4wbC34dK7eM?=
 =?us-ascii?Q?xAByd1cyJcxbwCBKmOMydyuiiRxb1p2BourwYTnjs1RbyJCKWuLd4FTYmqP2?=
 =?us-ascii?Q?1x8+sxJFUG87YxDFCfcoF3+tp81KOZDMjqYoUb4jfEoaTmqx0sQzUwPVWNCk?=
 =?us-ascii?Q?6uUHPsUEHBYtk/Lcpvq9BOgKIpmFj0+cAc+z7q6fXhbJE57/XOQoJf7X8hzV?=
 =?us-ascii?Q?Jm167JHgbtGhvKb3ZJr6bTh3TgVMINoJqiNNhoct84fgrM0aeu8I5MsXhnpF?=
 =?us-ascii?Q?4aO1xAqQq9FKSCRwIxtHG+14u73zHywEol6sTjIV0xzUXqv60dycncB+RMxL?=
 =?us-ascii?Q?JEMCBhszkdzz89x5Rhob9ICVjR4nkM03yXaeCn50O5VJZxpAKdNjvkWrSIYv?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fwgxlHNjduSQkMezlgYw0Q9ZpYhFYKah+SiRs0jLbPQO+O0ep4B5XJ3of7+JRLApi98Z1US+CJJks8C/1IbNnXwjPFRFOun0L7EUuF9McJeqcvTNHZMBql8xKcKHZDnf9MjQKIZltUFx0HA2Yn7vxmXWRHPVWU3ZzSfTIExUZeMOP66jcO9rRbNIvQEWX219kTqQDrqVjyTRovpqXJTqmYm2SFA55zidDLvxuzHFOeEooZ+iN89T6vmiQgoRfV0juJCesBOA4qEhXGkcEn0TLsPnQy8zrq2YOeUu3AyzqOzomiBsphzWExuoGoDxReUTdl7EM4tnEbTHglD37ClFnhlhirU4+KLED/QqZiPKOyQCBpqmnQRPwdjEA4qKVGWCLhsJy2oFh1B2bCUwPH6ZkEoOAePZH9CtZqDbMp3wtTO78J4a6Cw7JRaWXfcOp0I58kxeCnRJmpsypR7yudxsYfPiuUGYTlqI8VTqy8Y0ZXjlDYvdwWxFcZwqeXXGK3njP1iW9mLvQdBylLyYeEea0TJh34LeIoXpFMD+7e9pGOQMcefox5Ci/MdGqEbHwpyfQ3P4+bAMy/qberxTNc4y/++ZiSGiMHMPx3poTeohgOM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9bd68d-9924-4306-7e37-08dde5aa85be
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 20:44:30.8278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EP/zuLnHc+yI4z0FpA69F1xVI8/632gcwxDyn9yMQA9biRYCfSfmk6YXzdR31bbIhO9MBDBlMnYK3eMGIip11MNhJztBim2ZwhXzflJGhLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=581 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508270178
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNyBTYWx0ZWRfX0mz+dJ5ZjPiZ
 ztweaz6AZhvFaHj/fO02/y+G4Nv8VjQ4/kx3l+ufO/AKIJ4JQgdYOGCB/i2IvV0xkUSSRSQWkTh
 SjAU5/CCNvEKuKGPn6nFLQnFNTOe23CHn5L+XDOqP30Ct5nkrYhExiyJRajwrDfgv63c+xbVSh8
 QmViCmVk3glhj3Ygx5pZoQvb3XGlsnUk+/0fc4863HI/3omxL/NscpJds9JT1qOrEV2udiun6fW
 MAL3zsnBmmwczSdDvmA1j1Zw8/y+thUK7knXQ+x4QTpfZvUfib10BGqowAQWmu7HnH8M1uLDz8D
 mHTfqMsuOC+IB3dcP1C0MrX1VJjOmZMJXSCfBnn6EeOE5Jyvk5Uu5m1W62x6PKQHkdHxjoO2Lc4
 IWEe9HKY
X-Proofpoint-ORIG-GUID: SqLcLCcb0Jx9Xdpg2_W5alH9dStD4Fs9
X-Proofpoint-GUID: SqLcLCcb0Jx9Xdpg2_W5alH9dStD4Fs9
X-Authority-Analysis: v=2.4 cv=IauHWXqa c=1 sm=1 tr=0 ts=68af6e33 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=UgJECxHJAAAA:8 a=QR1_AwVaVhTKdPJur4UA:9
 a=CjuIK1q_8ugA:10 a=-El7cUbtino8hM1DCn8D:22

On Wed, Aug 27, 2025 at 10:26:09PM +0200, David Hildenbrand wrote:
> On 27.08.25 22:01, David Hildenbrand wrote:
> >
> > > This seems not so great.
> > >
> > > I really think the VM_WARN_ON_ONCE() should be in folios_put_refs() based
> > > on what you've said.
> >
> > No.
> >
> > Everything in folio_put_refs() will dereference the folio and properly
> > crash the machine when doing something stupid.
> >
> > This function, however, will silently swallow a "NULL" pointer.
> >
> > >
> > > >
> > > > Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> > > > ---
> > > >    include/linux/huge_mm.h | 3 +++
> > > >    1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > > index 7748489fde1b..bc9ca7798f2e 100644
> > > > --- a/include/linux/huge_mm.h
> > > > +++ b/include/linux/huge_mm.h
> > > > @@ -2,6 +2,7 @@
> > > >    #ifndef _LINUX_HUGE_MM_H
> > > >    #define _LINUX_HUGE_MM_H
> > > >
> > > > +#include <linux/mmdebug.h> // for VM_WARN_ON_ONCE()
> > >
> > > Please don't do //.
> > >
> > > This include is suspect though, huge_mm.h is included from mm.h and thus
> > > this very easily might break some arch that is weird about this stuff,
> > > because a ton of stuff includes mm.h including things that might absolutely
> > > baulk at mmdebug.
> >
> > Jup. Very likely this is not required.
>
> Took another look and including mmdebug.h should likely be fine, because all
> it includes is really
>
> (1) include/linux/bug.h
> (2) include/linux/stringify.h
>
> But originally, I wonder if we even need mmdebug.h or if it is already
> implicitly included.
>
> huge_mm.h includes mm_types.h (where we already do use VM_WARN...).
>
> I assume there we get it implicitly through percpu.h, mmap_lock.h or
> percpu.h
>
> So the include should just get dropped.

Ah nice, let's do this then please! :)

Thanks for checking!

Cheers, Lorenzo

