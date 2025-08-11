Return-Path: <linux-kernel+bounces-763507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85E5B21580
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6157E62421D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EA02D63E5;
	Mon, 11 Aug 2025 19:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AnJUByxZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Em490eJD"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B4D25A655
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754941241; cv=fail; b=q7mlEq5vwWximP7KiqZqdPLuJ5FGaDfwvyFcZUnUSuicXLxSPQNjrSBooYek3GQMQZ3z3rlf9+udOwsD56+LvAAac6Vh0izYOfPdGOewjv6Id/40ihb4lYY2qxlo8/tbZ3npbVCYxTvsHxAxeBn0vHDUzXUYZ46VYPlUxijDs6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754941241; c=relaxed/simple;
	bh=+/pq0gC4tCpWax4PFDgNqEoVT85CgvIdNcPEWLeDED4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uW8hIKZKoIdNwkdxSfA7HmSKZdaG2EegF3aEiPhg7TpvAl3O5bnKdzALDPXMv45+n8+35hSrx2gqot83AaH2BqP7NyqwZ1UUch0+k/hfr+Vv9LivegHbLmxRrRS5RYwWfHaUPKFxcJF7NoIi9Vd32FhOvWMtCktOemK8DBsABIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AnJUByxZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Em490eJD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BJXx8t022481;
	Mon, 11 Aug 2025 19:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cry8Cr0g1XX+AWBc4NVie310by2v+0gfg5v9DsGT6lw=; b=
	AnJUByxZFMiiBGFE6DbFS+V/ZkusRyi1pNUqqN87Yu0Asp+hedq5gdlEZmgVRcOz
	Bcmb8C0zhhXQOBpak/SyMeddsDPuFXPP4mHX5Uh7uYc9ymURR8DiNd6liOZTPYPp
	2JsKNfiNM2OV2zzLTpI/QeLA25wxJ4oclQ+RhsWRWwOZYEOnXJFvxYrYijhKmMT1
	wSyBmOtt7Rqz+cMKE4iP/VU76ib6WqM3gylQkKz3OvL9p3lkLJvKG12QNd6bVEir
	lhwIEVDi1V+0F1Mq+hLYJ99YEQ79slB76fNUmi7boeyPfIBytrXDy/OHBon+qqr3
	euMZmaPJsfOfJCxOdR6E2Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dwxv3a6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 19:40:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57BIms7K017405;
	Mon, 11 Aug 2025 19:40:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs92hk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 19:40:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3JLuEFRCGAtLQxnuelrqHl9MM7w0j+2jP/yZ3kQoslVRthtdidpmvF3UDgS5PtvzCCAZIF4p3bMxosD6jVPByXHA3Zv6tLVq7WGQcRr2eZzn3AjrB2j1tKU0h8Ao/BwD0htvGUi/xTWlBk+Q8+x5Mf9sbvKnBWGXZ3ZaNdWPTIcddrao6UtTVq72sPUgSsDA3VkUKSyo8+ANolK18k7BhuKP2GnFKpPeBU21EiC6evZjbxLb3vcHI8lc32dCpYLflpWqJPeuoVBTJUEdDfnytmM8e2SdY7ZOZNkIhVz0n44Df/Ohg4480IUiN2In/LgGhl4ezqR8DOyaxIk0Q9KrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cry8Cr0g1XX+AWBc4NVie310by2v+0gfg5v9DsGT6lw=;
 b=Y6eaJeJkdaR5huK97yUgOROT8doiXQMEBrzmnTsEEmqvSDXZngaQxEQbledbzIQIDIPddDQsw5xW0JK9oTMTsQ4CczuzT8O6sKG61N9+M+akYSVa2BlGNesX58nj4XkyVrZmOxoVvU8orvfiumn6U/efwhrf+lToCWMBlCl+d8R6Q4VMQzo/+4JvzlvmZc8ejccjLxgS/DE36h5CmbNf53khlsmWYWg/5aajskBXhrY24hBtMptg+XA8X53XmUKPAQ/+q+BdWDRHZugGBuU8tE+hvyWpQ+vHNgvSrMy9mEUNAknmBxOseeiDTM3heSe6ZWtylTkdNq4jT53p42147g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cry8Cr0g1XX+AWBc4NVie310by2v+0gfg5v9DsGT6lw=;
 b=Em490eJD9vbz9sWEKKFcl+8NC+VU1DaaBNqa6YOx70OsokBhao/A2vs5gZx3wpPvBpp9pA1r1ZkJtuYAcyUimFmlvoYVW4dfNxPEhM0GXSx6ijcqbL4BgxnGrCW/VGXHAsd0CRFqsgphOar7iuei4dEMMdDZ/5UW2lOyEs27rs4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH2PR10MB4134.namprd10.prod.outlook.com (2603:10b6:610:a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Mon, 11 Aug
 2025 19:40:12 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9009.021; Mon, 11 Aug 2025
 19:40:12 +0000
Date: Tue, 12 Aug 2025 04:40:03 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Jialin Wang <wjl.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@kernel.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] mm/vmscan: remove redundant
 folio_test_swapbacked()
Message-ID: <aJpHE0hyaRw8Reig@hyeyoo>
References: <20250811182500.42670-1-wjl.linux@gmail.com>
 <aJo7_B6cQc1EucA1@hyeyoo>
 <CAG18JnwT1P6W6AwQX0nKDiGTBtObzVXNO7RgO2B-ipnC3D4xGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG18JnwT1P6W6AwQX0nKDiGTBtObzVXNO7RgO2B-ipnC3D4xGg@mail.gmail.com>
X-ClientProxiedBy: SL2P216CA0199.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:19::22) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH2PR10MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: 62344b76-e16f-4025-a150-08ddd90ee315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGZzb3hHd3V0bmNKKzFKbk9ZcmFjTWRIRE1PekVWMGs0TnNyU1A2MFpMbCtU?=
 =?utf-8?B?UXJsd3FCdk9iaVhYcC9KQVNNbnpPamlUNGgxbFFUcVFqaC8wTTNLWklzclBr?=
 =?utf-8?B?S1p0elEzRDUvN2k4RHZFUTc5dlVaZ0cxY1JkMWZwaXYrY2VjVWJma1ZSMktl?=
 =?utf-8?B?cE1XeWRtd0dNOUNCeVFYK2FjM0ZUVzl6dGxOU2RiaVoxaXZnakYwdVpqQ3VE?=
 =?utf-8?B?RFRXQXNKMTg0RkliRzdwUXVQZ1U1VlZXQVpFZS9oWDVRbmxtYUorOUd1cFdB?=
 =?utf-8?B?Q2xubnhBeUdEZ0xRb1FEbGNoK0JTOUFXa0VVeDdjakkxK05Xd0hwbTdoNm1R?=
 =?utf-8?B?ZzdqVjRmd2JkWWxBZXcyYW96Z0FkUitKL0p6SCtGMW5JQ0huTm9kS3UwL0dt?=
 =?utf-8?B?d05JTWR0a0ZkTUoxQTBrNEVFTEJZcjM1OG5rc09lanRoT05UR1FoWFRjZk5S?=
 =?utf-8?B?RW45Qnk4K2xKbDJlQnRoYStzRHZpYnp6eUhseDJqdkZSR0lCamxpdUtTa0dC?=
 =?utf-8?B?eUEvQWlXZ1ptYUcvdFIzMERPSDFBN3BrQlYvaHM5QWlVN3hWY090TmdaK0Q4?=
 =?utf-8?B?MWpWS3pTaFNlMlNwVW00bGtpQ1BxQlE1dzhvNHgwanRmV1J1OGpmRlpFbXNM?=
 =?utf-8?B?TDlIVEFoL0NCZ0F0eGtaZDJaY1NVakxLbXJidzdSU1REVWhYc0FtVWF3V0kv?=
 =?utf-8?B?aEd0eHdDS01xSm9DMERnUkorL3B0bVRkZldWdlN1YUhuYUVvVmJVZ05qaWRS?=
 =?utf-8?B?cTFrNkY1YVJ6RGI3akE5SWMvUjNOMTlVL1FneVVpbTVIMzFwQlh6dDltcUVH?=
 =?utf-8?B?cGlUQ3IrSTN0WGl2VnFaU1BNS1QrbmhQcWM3RGdIb0liTCtodnk0K2J2SVVp?=
 =?utf-8?B?MVBzU3NRenNBTzdUY0c3aFJXWUxNbXpjOHZMT2pTOE5CQ1U2cXJpSS82bVZq?=
 =?utf-8?B?Q3VOZEgyTW42WjRHTnVpS29iMS9LN0JxWWRSMkF6VFJzNEMxWHdpU3o0aUdp?=
 =?utf-8?B?MkF3RjkvdGZOZ3ZWZ05EZGlZaTFvWXdOMHdFS0hmall3RHlhemZ1MXc3SXk2?=
 =?utf-8?B?L0RXOGowNnBjTUovcm5hakhzckN3NjNxTXBtWFdLR1oxYjNFUC9BMUY1L3RR?=
 =?utf-8?B?ZVdmOU1jR09OOWp0MmZlZCtCQ01XSDJXL1BKYkdVREFhMSs4L0g5c2IrblRi?=
 =?utf-8?B?eHgyNVB5MU5GRURheHhLMWlUekNHVWNoUXJqTitaTHRPbDRBOTUyZC8xMVVD?=
 =?utf-8?B?VWlkQ3IxWnZVNHFNa2NaSXdCcWdkd0ZUQ1E2Y3NZS0lxdjhsNlg3azZ2cUtt?=
 =?utf-8?B?M0xSbEhFaFZTcFZOeURLeW9tU3pDdWNjd2IzS1pUdTA1eUY2TFBkSEVjWlhB?=
 =?utf-8?B?RVdBSE1oVnoyZW5HOHc3WVAyVkJsWkl4Vk1rRXhnOUFPYWIwVG5peHowaVdu?=
 =?utf-8?B?dklNMm9aWDltcSt1T2lMZHRJdHBLMkt1aDNwRHV1bllXL0NSVWJZVG44NHN3?=
 =?utf-8?B?TUJCaEFLSzRxRCtrNnFQZXRWOTEvSThkdkRhbmZWRStRMXF4ZFIzUkhCMXE1?=
 =?utf-8?B?WGttVjBMV2RUYThtVDhMOXRmZDJtdC9reFZweXVBbW53WmtwWjJZdXpBK0M2?=
 =?utf-8?B?TFpodzFQb05rMFFRRjVwd1ozTWRKMURLQW1wUnV6T3prWVhRVHFwQlVMR3B0?=
 =?utf-8?B?ZFVON090SFF6cHlkMzFMYytEWDc3RTVid3owanlrcmVkK1craXcyZ2xpem5V?=
 =?utf-8?B?amFxNEJYNVRVMmR4Y2lXbE13bkF6REFJYmRRN004VS9pQjUyMzA0a3hrWndt?=
 =?utf-8?B?dGFWSy8rZUNKUUFSNkpieENJRVJoUi9xU3lSN05mZnFpbGZpUFhPMDJHcDlL?=
 =?utf-8?B?QjVjQnArZ1BNT1ExeEh2WEVEZ2NoWWRkeVFNM1lrZHhCV0pSdjRWRmpjVVNE?=
 =?utf-8?Q?Y9s6nQGFKHs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bG5BR3hFVElyTWcwU0VaRk9TZGxndlFFRnl2V0dQckp0amlST01HVU8yaEUv?=
 =?utf-8?B?K0ZlSGIweUxnWFE1b0RyWEp1dVBDdFlFMDhJVlNCVUZqRWYrdTljbUlCQ0RW?=
 =?utf-8?B?YUpkS3lqM3JLZnpWM2FTYzdYQTJkZS9tYUxHbTJBY0JSM3NrVGpVcDIrWWZl?=
 =?utf-8?B?V0p5RWV3K1R0QnBLcDZQS1h6RU1EUkJueVdCdmh1QWZmc1hKWWR4dlJkeGtr?=
 =?utf-8?B?bEFHUi9WaDBTNDVWYVFkWUdxMFQ5UWQ1K2xSajVHbUtQa0xUZHN1QkdlQWw4?=
 =?utf-8?B?U05FbkdGV3N2SW1uZyt4VVI0UGpSWXlnQWdQcm1BQkxBdmdCRUxvQ2VIeXZa?=
 =?utf-8?B?V0FzVVpkQ1ZkMFMwZGJEdjNOK2FpV28zQ2xTZXVKejZ0czFGamdMZ29scHZE?=
 =?utf-8?B?aTJpN1VqVTJjWkdpSTdoZUxud0sxbjZOSldZYVcwa2FZem5JSWlCa3BWM1p3?=
 =?utf-8?B?TlNPRVNmMWFUY3JQTEZDcWd3RVc5dkZVNlgzeDNYR2tySS9VR3ltbm9KSDlW?=
 =?utf-8?B?b29EbWZpaDlMY09tMThja3VCL0dTaWFyYlJ4N1MxZ3JjZDM5bFUxUWQyclNh?=
 =?utf-8?B?akhzeDdFTFhQQU9oOXlOL1BHanVLY3FZOFM1TlUxaGNqOEY5V3B5MDVyRW9l?=
 =?utf-8?B?K1hDaDlrcTQvbGxrZFNMaWRIRWNpWmUwSFJJdFhhdGtkR1RuZGdzY1NxRXU4?=
 =?utf-8?B?WkR0TXUvMnZzR0FHaitNVm42WnNqT0NNYkdZOVB4MVJnMHNPVUV6ZmttOVBj?=
 =?utf-8?B?MmluZm5uN3VvTEV5d3NTWjlhaWVtWGRUVVNpYTY0YUNWYkVPeDg0Tnp3eW5P?=
 =?utf-8?B?VXIvdEwreHpGWUR2SWdUSXVvK2xZeUpBZk1zbUxkQWw4VVZkaUU5NnFUanJM?=
 =?utf-8?B?VDN1Qk0wSG5QU0NqellxREhFYVZ4UlhGN3FRbHBwbFpDUHk1K1hFR0hDZ21Q?=
 =?utf-8?B?RDVjUmxCZzVoYlB3cFFCTnpjSkhTSW1xVldWeE9oZ3NYMWFHYks4a3ZyZ3FX?=
 =?utf-8?B?dDZmakFMVlBvWmJwTXhQTDF6Q2RqTUw0ZGV4blZjUlVQRWJTaCtlMVNCeTZm?=
 =?utf-8?B?eFlRK3dtM3FNN2FPUW5oT2Vhb1dIa1lHelh5ZWdJVnNWUDlpY2YvdXpqUEV1?=
 =?utf-8?B?WkxtK2VxSFRYd2JvNGRFbE8vLzlkRG1wcXNVbVA0Q0ZaNjZwQXJwRmVTemFn?=
 =?utf-8?B?S0lSaHFiKzZKR3BzckN2VnRrZzN6SGZUT0VlaHZ6c1YvNXpCRElyR3hqLzho?=
 =?utf-8?B?Zk5RMzVsV3kyWDQ3N21Ea0pCMUhlWWVnc3N5bE9vWi9Kck82L0h6S01vUnhC?=
 =?utf-8?B?UG5ValNNYlJnZlAxUEJ2Yys4cHJGcHJPS0VVem4yMFVOVjZ2YWhRaWZ1dStw?=
 =?utf-8?B?b0V6SG5JZWFtU080WmkzUFdlb0xZUFFPUDY5SkRwTkdQVGtoTHRrTTc0OE9R?=
 =?utf-8?B?YzdZWG5nOGpyTC90Umc3USsweVRTSGFCYmJmYk5YTmp5NVBzMFlrcFlITnZa?=
 =?utf-8?B?SXcyVmZzYzF4dTdxdTVjbGM5Z3Zjd2NLenR0d2JPQXdhNnk3MnBsU1lPQ3V2?=
 =?utf-8?B?OEFiV09EbU10d0xiZ1MzWkd6L3FFYTdOcmkrWDZuc2lLU0hWQ0djeVIzVUh2?=
 =?utf-8?B?OWtjdTZRREpubVdQYkY3OTFqOW5XUzlCUUNFZUZMZkxQOUhyV0ZkMy9Tc0NU?=
 =?utf-8?B?TmladWYvZzdnMktoSDBvUGhTUkRnc04raEdJZHJsc1REb3ptcldOWVd0cHI1?=
 =?utf-8?B?clo4aHBVWitOVzdZRmJieWhubkpQNmI1ekl0TlRYNDBmOVhOcms3SnpHVUll?=
 =?utf-8?B?ZXBzWTl4L0Y1b01uS0FIZGdZN0prajdPYU9FdGRBSmxTK2NacTBOOTRJVy8r?=
 =?utf-8?B?ZHJNKzB6eHlvaE16R251MllDOTJNMGwvTEIrd2JVSUxOalhrRHE2MkVMc3pt?=
 =?utf-8?B?QjI4a3dKSlRoTjRVTlM5aEZ6V29SbFdVU1NFcE42bXg3bm84U1E3YThWcU1G?=
 =?utf-8?B?ckVLbUdNRHgxWXdtV2ZwdU9KRlJoU3U0R3BQZzVXUTY2ZEREL3JudFFsVXJ0?=
 =?utf-8?B?M2x0QWowdGdsRU95dllqT21ZNTdtRnZUWWxyLzllRVAvWXp6ZkJVM3J1TEtj?=
 =?utf-8?Q?6ciDoJOthbLFx/wULaIxJBiRO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eINbYd47OtvT9N1Qf9oJcPnDCdMTRZIeo8tRu/pLb7DYotBOsfEVG1HOXwunhJok9qqcrPq/ul+NIur4/tBRKTo+iK6uAJmFNyOu6hck6gfLiHNh3kr0OdCZNntVQ6w4GWt3fIcXffuZmaNyhRvxHSv0hBshsrycrqLgtgk1NG1Mwoum2zYed54QomuHlvKhbEIdyR0aKEUVvOslETRgueTc9KU+MT+3ZgviPOpdxOz7yFfeOXfpYoPUWtXkacIi4LIrhAPnjYHxg1B71zBpdRumWJNOF6CpbqvcRLXE4cz/CkPN9vv6/1ApqOf8Rbz6IgDI+X/i/IS7oSu84t6sLFJZc+BmJuFrVzgI4rEVhyy5hUd9vG4YHKpTZnUqb6otUwh+IiR7Qzh9yO1dOkAs2JQ9+QxSd5KT7BNzMGGJG+PMoIpZOybQvb+28UBuOZiCfawryot4wM030Ls0/CbPoavfUdtvYMo9h9Y6hxVJF/FHAVXaze7ENAz6Y8nXpJgziqg1fyiMQx+2DTtA+4uSO1AJdmc/O0eZIzFX1B8iQK3jyaK4L/GqlyocL7aVmnR7sK+rQYBkAD/Lty2C7ZTuVycREl5Mbi7RruSraswmDLc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62344b76-e16f-4025-a150-08ddd90ee315
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 19:40:12.1893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vstBBi9xEzhibY3m6SHvilQZ0gFvscx1b/Ir0olcgztcJCSKxyM5CCHC4iKWZJ3gKkKArWEcpe/s2zeEh76Aiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4134
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508110132
X-Proofpoint-GUID: 1zmi6_l99ybVaQnLfBAXTgNndLumicON
X-Proofpoint-ORIG-GUID: 1zmi6_l99ybVaQnLfBAXTgNndLumicON
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEzMSBTYWx0ZWRfX2MEUQA7DMvkB
 +0J167p9O/gx0u8jIo/pCimbQbIxZ9SolX/rNV7zY7BHwyigbJemqf3H3hYwKGHsM4pCQZpTqY8
 JIhiGvFtswyNmjcx1DGOOX2jCJO4aTyDpICHs9taRiuRoEcpCNybDXubXH8FFuA5LQVGXS+etBU
 Uz2RijG/uEcVdGCm/lkWFDJlferymICxUTxFiRA73rXwy6Yva8Tgf56etTE4/EBN2+48+Kx/5RJ
 +JIhWaM808iInXQ9H144T9skIbMYceRdk3hIl81IlwAtMS4qeGSQfeinRK8iAVbtyrwtGS1hstV
 mY+Ji397HD3qESxVH9v7TBItSS+hsI7COEactBl8yDcNK3hLAnjsjIc0NQk9PCblt07XDbt6eH0
 mzenQdWpE68XZy0Z+pOrQDJCPDJlY7lS+uiprKKayo/v7ZkxoDN8MSH3sII+qZ81YeoeD9M4
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=689a4720 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=lv4aHYfSfG89Rdyl9BgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10

On Tue, Aug 12, 2025 at 03:21:12AM +0800, Jialin Wang wrote:
> On Tue, Aug 12, 2025 at 2:53 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> >
> > This is marked as RESEND, but which patch is it a resend of?
> > I can’t find the original one.
> >
> I sent the original one to the wrong mailing list and missed proper cc's, sorry.
> https://lore.kernel.org/lkml/20250811181839.40336-1-wjl.linux@gmail.com/

Ahh I see. I couldn't find it because it was not sent to linux-mm.
I assumed you sent it a while ago but didn't get any feedback.

> > On Tue, Aug 12, 2025 at 02:25:00AM +0800, Jialin Wang wrote:
> > > When !folio_is_file_lru(folio) is false, it implies that
> > > !folio_test_swapbacked(folio) must be true.
> >
> > That is not true.

Oops, I completely misread the message and really sorry for that.

I thought you're saying "anonymous pages are always swapbacked",
(without considering ! in the expression), but you weren't saying that.
Probably I shouldn't have read it so late at night ;) 

> This is the definition of folio_is_file_lru() in
> include/linux/mm_inline.h line 28:
> static inline int folio_is_file_lru(struct folio *folio)
> {
> return !folio_test_swapbacked(folio);
> }

You're right that technically this can be simplified, but I see Miaohe
tried this exactly same simplication a few years ago and it got some
negative feedbacks from people as it makes it harder to read the code.

https://lore.kernel.org/linux-mm/87lewqbpad.fsf@yhuang6-desk2.ccr.corp.intel.com

So maybe not worth it?

> > MADV_FREE pages are anonymous pages that are not swapbacked
> > (and thus can be reclaimed without pageout if they are clean).
> >
> Thanks for the explanation! I'm new to memory management, so this is
> really helpful for me to learn.

You're welcome!

> Best regards,
> Jialin Wang

-- 
Cheers,
Harry / Hyeonggon

