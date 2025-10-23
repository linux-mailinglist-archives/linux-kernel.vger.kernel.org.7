Return-Path: <linux-kernel+bounces-866779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 313F5C00A05
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6847119A4DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAF5303A3D;
	Thu, 23 Oct 2025 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F3dLHnmJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bxAiVkS+"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573452989BC
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217675; cv=fail; b=fKV0uWbWOn8gDK0Otpd1Abjaiat8B2QGqfwp0VASFY1k3BPcRtDKLdfGI7jC6ZaAp6xLvYUsmMQ5i22goAlT/zdZHYQSOj0BohjS5fZFzEfAiuUjbrv7gdwOJwk5v882Rk8zkZywevb1sC6k/x2UFIV9mrvh35IZ/BVvC2q3zAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217675; c=relaxed/simple;
	bh=WHaYzawbzWgF0TPYQh1fK3pa0R0XYDyr9M0eHFz1HgA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eGTFTHanghD6dkbrwdMJU8WNr0wBsrw6pmf/x4uItcheLgxhKWT5UBIXGaYjWO2wmnuD9ppParjR+N8SeeYzXgaWHzAr0QPVsk4OT6u0H7eiMOFRr1EtcQ2LwOGg39JLspEt3a0fNuXOGyZ9X+Xkjk6d6cV8n71KM1WoN+tSEZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F3dLHnmJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bxAiVkS+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7uN6F024524;
	Thu, 23 Oct 2025 11:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zbONV0aPhjvg2uAjlZq2h2YidrgTbVtREO5W/neDN6U=; b=
	F3dLHnmJ9VvuEiP180Uqr+/Z/ebe70arQOUUk0VuhlKlrELRplO7baI5PRlDqr8/
	TnXJH9rJAZ8ZV6t3lT912sBLP+deKO2D9owV2mrFwLV6oSrihImtUZYy2rdCXKcn
	5l0XsCZ1yAlZ9jkZS1ibJhnn7TI8HK9rNl6/2MmBD65IVJQb21ltRwp2wMRYGMBs
	dGQw6vccNFDmxCzSyyHeav7LWMp7HtxsR5cz+B54dySru0x4Wop0iHyTXYRpROTz
	gs5n6pP8+chwhKpycCXjgR3fTmk4fscUooOBtR202L59+FaFtHtactnWsP4N1jJD
	016Ux/RBpzCcljW1mLUzdg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xv5wj9gt-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 11:07:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59N95NDm012357;
	Thu, 23 Oct 2025 10:55:19 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010064.outbound.protection.outlook.com [52.101.193.64])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bee42y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 10:55:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ovo2QSjLpkk4n8wYXn9nsaIeovwDFLX0cljKgLKBqHhKEXQDTh2SnfzOqrEi2wPzIibGSk9JshtxFV/ruRZiCSsVNghWxzO+SmlQj/pPZ+i5T9ObDPnMsPMCZIcxc2pqPWQT4bwdNDNnjUmtWW9EQ/EBBz+WZQPxQ9MXbkJ5fzZr3+iytBA5SPvC47xDo07R+bMKUuIhlQXBGXV00ufDUu6wl1tu5cld+OwTJ4UgD1Xf2AJwYf8wQUU+ZKABOdX3FPpcGql0xC3YUoRGzo2iVzBld4QxIt5kLVlgL7jgO38Qh+sKlaV6rUdTg5IE3bXw+5osewvL3YL71xCoyiHoZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbONV0aPhjvg2uAjlZq2h2YidrgTbVtREO5W/neDN6U=;
 b=veBcSg18R7AsB6YQj9Rz5zhLSf4ph5YlG87kWlkZCrkb7bfZzoZ43FKTf/JciF9PwPheiixh8wkMcvkjqTu9/nSzhfEKRcSvU1DhLqDEsgx2dP+fobfLgkUd//YgImX7F4QuWg5uQOF9G7tZCvnDwYaGLZQiKIwfrRJ1Civ7/tzSSrYk9uPZxaYmxv1gDSc1dH1h2XTouvSDO2ZwwF6mLnVh75gV2NYoeLsVTofuDBe9Z13gYsj+BlTEU7qhkkmM/dwrGn7l0oNjndCrqgIT4zL9/nJ2qvfn6e4Noc2OhzK8Y5F3GXUFp0F3zMqludnfpIPSnmixwFp2HGKy8i/3/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbONV0aPhjvg2uAjlZq2h2YidrgTbVtREO5W/neDN6U=;
 b=bxAiVkS+Rw5Wzy8F+LaGcHoHUm8uYDt9zAhbfVSjY4Bktn/1VWADV+cSYUaV3c5U4cznmYY0xJ+ZwBQ7pH1V/OJHutrqgMwAFDl44yznlmjITikdcyaMJTLRXKWydApvWZyrrhb+lXAWQKSwX0YzO3MuWpaJvPJ2kC0nLZd2u9k=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CH3PR10MB7645.namprd10.prod.outlook.com (2603:10b6:610:17a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 10:55:16 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 10:55:16 +0000
Message-ID: <8d1d9153-810e-4e2b-804a-760bb3523e97@oracle.com>
Date: Thu, 23 Oct 2025 11:55:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] nvme-pci: Add debug message on fail to read CSTS
To: Gerd Bayer <gbayer@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chaitanya Kulkarni <kchk@nvidia.com>,
        Wilfred Mallawa <wilfred.mallawa@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>
References: <20251022-nvme_probefail-v2-0-26bbdf94280e@linux.ibm.com>
 <20251022-nvme_probefail-v2-2-26bbdf94280e@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20251022-nvme_probefail-v2-2-26bbdf94280e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0258.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::11) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CH3PR10MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec6ad18-9dee-4dbd-2593-08de1222a61e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXRzcWJ0WXltbW4wV2RPS1FFckZqUExkdkIyWnZYSEYzdDJqcjh5UGpMZlZU?=
 =?utf-8?B?bHpQbjdYR3ZNZ0xqNmZiZEdVRmdmWSttc2dtb2F6bC8rbk5CMURmRytRVWtK?=
 =?utf-8?B?WGQ1TW90RGVicnEwekIvZXRWazFMajB6L3c4S2pYRHpyV1B2S0E4b2VNK21z?=
 =?utf-8?B?c1N1eFZYUEovM3dtdWZ5eXdpMzBHRGdXMndrMkwwZ0dKNW14eWU4MjZacUIy?=
 =?utf-8?B?L0FZU2NTclRmamRDY1cwakdNaXluYUVTNXNnNzJONzMwUkxrcTNWTEFjQUpq?=
 =?utf-8?B?R3dZNGprT25hMkVyaHRHM042aTVrRDZvdFFwM3N0VzdnK2dQQXZnS0x1QW9E?=
 =?utf-8?B?TG8wdVY3Y0dLbHh1MTN6dDNBeGhTeTlPd0JJR0pjUnkzcnVpbTNBMkJxOUpB?=
 =?utf-8?B?bWRJVms0YUJ3Vk5FNEhUa09Gd2tzZjhwTDJjUnliSlRHVXVQWXRyNXdoeFdH?=
 =?utf-8?B?VjVXakZGc3ZWd1BvSFVvWUxjdUxsVnB6Ymo0NDVzVU9uVTRDM0EyNTdwVWVJ?=
 =?utf-8?B?ZnJVeDdHUjdJY1EzZThYUlNySnhVQWFXWWE5SWFMT0Q1QTZGREpySkFyWVNZ?=
 =?utf-8?B?clZia2hrZVF6Vi9hS01HREJrZ25mWU9KSy9RbUlOWitzODBQVEtqUktlYjVB?=
 =?utf-8?B?RGc0REl4WlJ5V05NcDFicTBva1VMMy8vaVppblRITkYxK21ndVl2dzVGS3Ju?=
 =?utf-8?B?bmpRYitTN2NEQk1uVm5oWFdNTjZTZUxTMzFKaVlBSWVjY2RBK1ZUUFh4ODFQ?=
 =?utf-8?B?WEdwSHlaVS9LVjk4eUxPOG9JZk0xMXlubStTOTR0RksxZmlPWVZiVVlFandx?=
 =?utf-8?B?c3RGVlA4bUxEZlUrSVJEdFJmUTkweWR4NlpUREdzOHdkdmNqd0JSZnphOE1X?=
 =?utf-8?B?TWp3VGFHY1plZGZpTDQrT2JPcXY3MGVQU3dja3NpQXFzVDE3YXUrdS84L0k1?=
 =?utf-8?B?a2dQcWUvVGRlVlM3M0pibWUvTUN2amd2RVo4ei9WdWwzQzc0L2I2VVprdERo?=
 =?utf-8?B?WkdBL3AwaldjQTJpU2J6MUR1V1FwMEdVVDBsMTB6N1IyL3AyQXJhWWQyejYy?=
 =?utf-8?B?N0xzZm5HVkJwWFR1SE5pZG5pNXlNOURremdKY1ZPdGdQUkUrc29qY0l0MDZH?=
 =?utf-8?B?UC9ha3BnRHhxck8wWTVhSWFjb3ZOdjNjKzdSaE1FekRKUm1udjNxeW9sV2l6?=
 =?utf-8?B?ZFIrL3FIeTRLTlZxNEF4WGxwdVZSYitSN1M3THFQRmlnYzVCSHdtK2ZiYys1?=
 =?utf-8?B?b2pTa29DYWhGQndxQmR0RUsyRGtxK3ZKU253L2o1QmdxTERTdHlNamFydFQz?=
 =?utf-8?B?UmE4Z2toenYwYTBtaVlxYjR6M0JTWlZMV1FZWjMrenhtNUlNanlNL0ZSZ0Jh?=
 =?utf-8?B?aUFxWHdJYm8wZnFJeTZraHFBdThjS2ROSEdvVnhJaXY3R3R0N1ZnejB2WjFk?=
 =?utf-8?B?SXYrRlE0YkFxa2hna3Z5ZFIxaWZPZUI4dUdvdjZCQnhJblZWNjdBNXdLbVdu?=
 =?utf-8?B?UG92Vk9ZNnZCRWFabmV3VTJSbnVGRlZ4SlByQW1hdGU5b2h1WEkwYW1makM0?=
 =?utf-8?B?NWdSWVF5bVFUYUQvVjBHY1pxRlRPcGFhWTl3dFdQT0tkd3BUL01tMWpSNlVt?=
 =?utf-8?B?WW5KTkdscXg5SkJBSFpDNVd1OTRNUTM2R0JzT2hmRDlQL3JJNERwdmg0T2wv?=
 =?utf-8?B?L3h3OFVoejFQOXNySVBRejI0NktKbzBTa1JwTGVBTUpsYmZZNERVQmUvd00y?=
 =?utf-8?B?YUZPaGh2QTZaQ1V6K1NuSy9LQU9QMUZWUUF2aUJzc2JtYzVVUWRQQkVzZTJw?=
 =?utf-8?B?Y2w0TE1qY1M4dEhSLyt4SjNWRFhVc0d2M0tCQ3ZvQ1kwSUIxOHVGZ1dacVdv?=
 =?utf-8?B?Zzhhbm5JYUhXU2dnRkR5NFo5Und4d2kwejI4U0VERTBtY3BvRng2UzhsdVBo?=
 =?utf-8?Q?wj2yc3E4cxWJ6q3PuTZiHg26xeAhgaTF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEhJTjllK1c1SWJVT1BWZW9EMGpVZGxNSEFhVlM3WmEwRDhyMDB5UXlFbFF1?=
 =?utf-8?B?V2ExSjRPTktLU3ppM0RWTTR5eEJFdEtBNzJxeXNjeWtQdzBENU81akJ6ZFZB?=
 =?utf-8?B?bUJtWnVaL0I5MEk4bkFrWXRBRWdhKzdNWG02Mk9od3lCUEdpYmt4Q21CU01a?=
 =?utf-8?B?Wm00WlJHYmdPZ0NZYUoxRjZtUmhQUFc1ZEcxWmpiVnhEQXFXRWNXSGk0THRZ?=
 =?utf-8?B?WFBkUGEzbzl5bWd2WjZVT1lxTXcxczFyY0ZjVVZEcWd6Q1AyZnVNLysyakNQ?=
 =?utf-8?B?aWk3NGZLL1lHVVpDZUZQcHN5ckdnbmVnaWlBT0prM1FtYSsxbkpaNEVnaGVr?=
 =?utf-8?B?YVduNW9Ka0tva050Zk9LN0ZNcG91ME5aY2tYa1B2UzVTMTliY2kvaWdpUGFy?=
 =?utf-8?B?RTRsc0kxQXlJVEkvVjdYcW4vZ3p3SGdpUVpHSmRKbk1sbSsxc3dzSXJUbVll?=
 =?utf-8?B?SFhiZWhNVDlSK01sZ2w0dDNrcklCQXg1TnVjVXhuK09RU2crbGg4S01ZSUNw?=
 =?utf-8?B?bFlyckJwLzVSeGNVWlMyRGZMWTYwNWRjNkJ1NTM1M3lmRkJyTXZBTmNoc2xp?=
 =?utf-8?B?Mzg4cFpnNFFwVERRMU02MXo0M0FVUEhxYzlaZzN2Sjh2RGxOb1FmdjJKWlRL?=
 =?utf-8?B?SUlwanFiRHBIL0huUlZnblRFTXZsaXh6eFRQWHNrNDVCTHRCYUwycGZYL2JN?=
 =?utf-8?B?UUdMb0xWaWFFTkx1UGN4c2h5bFFkY1QyK0Zxb3FPU1llWDloWHNhSFlUMitt?=
 =?utf-8?B?SzBxb3V3ekhMRXUxSkpoaThiOVhqNURXM1M3NG5oU05ZZUJkdlhqZkRYSFlx?=
 =?utf-8?B?d3NaTFI3UUJDZDRxRDYzYlJsbUZBNmJWbGFsbkJzeUlNay90WnRGMjdzcUNT?=
 =?utf-8?B?cm0vU3pDY3lSMjdQRDRJUzJZRGl0TkRDNG9mS3JCQk91ZThmTkFkNTRpdHRC?=
 =?utf-8?B?LzlYbDZYd1BXNHZEWTV0VFUxdHo1MGZCQU1JWGJSMGwxc0pQdGE4aTBORHVs?=
 =?utf-8?B?YUFWL2lhMkN4eGxpZUxWUUVJcU1NNElhNW9zMHlIR3ZlemI0K0Q5OTBpWG9Q?=
 =?utf-8?B?OVpMbXJ5Rmw0Y0RWUVJUUFQ5YmdKd0RTV1oxcllOS3laNTV0YlFTVE0rRlpy?=
 =?utf-8?B?QXFzVGJ6Q3VkbGF0TGhkbnZPL1RETExjUGRmYlNRR2w0aWlrbHYwZXR6UWYw?=
 =?utf-8?B?K0dobWZjeWt3a045QWQ3YWQweUYwMDJLS2lmQUdlL3RDU0JDNFkrM3lFQmtz?=
 =?utf-8?B?Qmg0RXI4V2MzUjNmR1prekE1aks3WUpvUExhMzVjZUFsejFEU3FNYUd6TnE5?=
 =?utf-8?B?eE1JK2taL0VkWXNZZlE3c3phaWdZT1N0K3U5RkMzV0g2RVVUcXFOZWNRRE85?=
 =?utf-8?B?WGVSNXNkNTJ0VW14MExiNEpsU0hmdzFDZWFVMFpwa1pyRkhMclB2ZGhRNWFY?=
 =?utf-8?B?VlB0UkVZWTJHSjBFODAzOGYrNHBFRHp0Uy9WYVoyOHhXcmxDWEdrZnVob2ZZ?=
 =?utf-8?B?d3FjLzIwSGVlNTcwTTNUQmtMQUozcGhlYWROOWlTRHdIR2tka2IzQzgyaWhV?=
 =?utf-8?B?SStJQ2IzdGNlTVJrenpkVmZsVjhGK05hcXlFdGNSc0hKVUY0Um16WWR6dWkx?=
 =?utf-8?B?MFhIRFlpRytQclBYaUUycG9iQzdGWkFuL0J3L2ppWDY1RG43VkMvcHMwQ3BD?=
 =?utf-8?B?TGlQeWtieUEyajdkSXlSSmp4cnNpTWVrWU9mRGgwKzhycVVTdHBtclNkblJP?=
 =?utf-8?B?Rk56T3hEMTlwSU1hLytESEpNRG5aRGhPQjlza3h0Zk9kaE9CZ0xnYmx2aklv?=
 =?utf-8?B?WW9EUlZsRzBoOTkxaUptOXdmc2lpOEpVT0NNRmpRN2VqVGRrbGZPdzZNb3Jo?=
 =?utf-8?B?NDJLVkxsZFQ1ZUowVlpOOVJOQTRRY2xwSFFtMlFqMUd5MHE1UldvM204MnRt?=
 =?utf-8?B?c0VDOExJMG5Xell5bmJYZVU3VWFsVDduL1N0d3R4RXZMazQ1Qml5TVZvNGRE?=
 =?utf-8?B?dlU0aWl0WUhqSy96WnBXdmVOS2NlM1ZPelNXeDY0L3loSWowRWxOVTZKSHI2?=
 =?utf-8?B?ZGpmRHRlRWVvd1dFd3RUaXYwYkdZU29zZU5QN04yZVZSL0JmS3p4RXRDcjJJ?=
 =?utf-8?B?WDByY25qRXpIMGFkNE12eUxucmZiZ2hqU3dUVjRDSmdhSUFPc3Z5RWIwM2NO?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Yn+K4hFPRfPQq51ZNUgnc5gM2nj1HAWQJiDRO59QbEgfe1roqXHXey9l7LsZwNma6R+AB/KF0T4H+Un7O+3BalxaIdnj3VolDyCjYWlXGpFVznhtzmJ4dAIlafLrW4F4DmlbJwV9weI0HCVh/HlELK/7S1Hcux46ohaRxSNIIBU1QBvu8Bm8tUUHjBK2FvfrIpfOFyzrj9mW5t1hbeXFXsdXZ4BC8/dxMUqMIcFVTCq7VlVPkSImRROXyFBGS+QicodcDAumiLiJ2NRRRLn6WFC43ft6X+LzOKmxbqzYA6ev2uOVgcq07rlrTZ6w1oq8Ovo8yq4Xof1uqsjNzbRHrs8LqCiLOFsvxLlF44Zir1sW2OULGg2fU0uCahtM3Usc8bYHDLuhDMo5s0Sc9jTZJk+J9vco73zTSJioih13qt5zuQrY6QlfL46rmKiqlgWF/5B6DoInhuDCUt+b9Fbr4Xr86Aum60h8zlgQFYBA0IMz6WEWz2UgsfKvYFCY+Y5E90QRtdaYssOCc5DU/XUiYPiIl8z6WTp4IxOW4w3buuJ52PuuSj5iKgK3IqmGp6vC7j0FHNwm8LarIu1+ACQrjsh8bO8gXXn6TDqPgFbU+NI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec6ad18-9dee-4dbd-2593-08de1222a61e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 10:55:16.2149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ujm9IVLBDv5j3xz9wtHxtcVLsvWNAOUxoQZQC+IlNaGDD1s9p4vpsB3hEFP5IUNZOYWl/RvJ0Zk7tDPvJ8Mrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510230098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MSBTYWx0ZWRfXyCD/WA0lWUX2
 tuFTMzmC2zrK61w5n6FtQ+yxHZ7JPe1pFXfE3+1MkSSq2EsGrs+++XeXbTyd3GZr94Ub7LKUaf9
 xGD8MTeMaz8/LNdSywMP4DuKXfMoMHUv73VvkU6yzmVJMv3rrPupyRr7CI9NlRP9oUhox+CeIsE
 ePK00CHg5zFFi2NRo6oIr6ON6iOisDGNzGeOs4t4SGudV5psH1SODtm2OrVhbCxh9GTTDukueqh
 6y6f814k9eSkO8wOz9WLpGFRSr3RLRTUz3I82l2Jokclxre8+juNMSqoAyYStTF4qb3/W4HLLlE
 t1hqODYBqOV+heBjDuB2hzow5dU00z7HoSJaIOFhT+L4PrCp2MtQhsmPiGDI+PzvuVRKqTh7qnu
 gwI2ny1L4Xz5SwGhT5/sBm1Czxp57A==
X-Proofpoint-GUID: JuuxUfvs-LmVBb-tWz-gjzVn4prv6j4o
X-Proofpoint-ORIG-GUID: JuuxUfvs-LmVBb-tWz-gjzVn4prv6j4o
X-Authority-Analysis: v=2.4 cv=RfOdyltv c=1 sm=1 tr=0 ts=68fa0c76 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JF9118EUAAAA:8 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8 a=0rgUnqHS07GhZTABNXoA:9
 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22 a=cPQSjfK2_nFv0Q5t_7PE:22

On 22/10/2025 11:33, Gerd Bayer wrote:
> Add a debug log spelling out that reading the CSTS register failed - to
> distinguish this from other reasons for ENODEV.
> 
> Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
>   drivers/nvme/host/pci.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8c624960c9f67e0cc8409023de5e532d6ed9b3ac..ce563e93d29443a25e9236d0b6d8152ee85796d7 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2906,6 +2906,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>   	pci_set_master(pdev);
>   
>   	if (readl(dev->bar + NVME_REG_CSTS) == -1) {
> +		dev_dbg(dev->ctrl.device, "reading CSTS register failed");

we should add "\n" as a good practice, no?

>   		result = -ENODEV;
>   		goto disable;
>   	}
> 


