Return-Path: <linux-kernel+bounces-833006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EE1BA0F87
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B5F3A8910
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67CC313278;
	Thu, 25 Sep 2025 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WjXQaUCh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BOMJt3Nl"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E4D1E0DEA;
	Thu, 25 Sep 2025 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758823408; cv=fail; b=S7fi0Gd7dTDboPyrioV+C1AvnOIlOhAH4VtzzYg67HnAMaJLm41GBciL5yDOnMkbhXhD0MIip9AGNGpQYv6ZYl3R3yIDDbBmVoAW07so4H0b2F6Qau66DM81gMBhMicSiNhwWoIEZrdQiFJEUuLlOtddCOpuSqyTEfMFF8gwzA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758823408; c=relaxed/simple;
	bh=/wZ14y6IFot9kMlWOQ+dvNmsNOssNpy1GpMj1am57hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pd0KrrahKay77bpldqjaE/55sRSyHc1MveA6Qbyrlr8jnYFimS5A/8G74b/GwXcd6aBDrsTlB1hpBIm8b0rfVaPt+8EijQDPrf25JFtxjNtQgQedfIZ0oPIIyCS700ZzmlgCVJdD5EvjmdU1bXwfVBYKbCKWSqhRLMgF5n/cUuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WjXQaUCh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BOMJt3Nl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PFu0Ne031128;
	Thu, 25 Sep 2025 18:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=iDSP4M2RMK7fKHPxUc
	vaiiezgHhf7YHRCOVoqQmEZeA=; b=WjXQaUChTcncDjkeT/xR9Vhddc30TsssAu
	JmsRLOaJxcNqK5UGKp17zOkTUYjVVdJ5lBiiKKfotWwbdRNIM1NGDM4we/FuFh1L
	iMvR4uytOrE+kIr5Rfq2OHY5FM5SR9NtVYMrwWtn62KbHXWdhfKpCxTBy2p+nTSm
	O+EeSs7zGK8f9J3SX+myljRiW+t3SUTg0YnqfFlLBKXvafTUGA3oS4LWBX/1h5iT
	9r592wGzUyHSVnJA6ziSnbrDiGPotJSerUxIVZU52J/1t0VWKnU+mfvWW0k45keb
	fe+6vmYu3aIL8Av3S9RheVIhEfuHlDr55N7518o3vzgqnH7EddsA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499k23jkty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 18:03:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58PG9w2S021644;
	Thu, 25 Sep 2025 18:03:04 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011069.outbound.protection.outlook.com [40.93.194.69])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 499jqbcue6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 18:03:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2oshXO02qRqXcPywk3GrsNZ2EW2wN5hWnqlNTRfqzuHyuUpdSu8nQMte+OjVj+6ss4CuzKD4IcGPtPRsVSb57dBD5Z9ks9bpe1X6nuwvi2HFrgtG53u+nUm6n34S5xqe4NjdGoY3arNqnDwh6Fgm78+Q2r8+h19IrPX+ct7p7a/vCRY8SuP3NHxl+MyLHemE8hBps9MQeaSmqLbWg5R32QM/ewwbqiOo8zRhjdSR7DLZBTTU2IlKAtziSoqE7DMt4J4aW/V73vgVkt9Xyb+YwwdjbzXu5PjGKFgjdO9PZaBggNiAUwKfnk3UNQZtxqi9s/Y+BwP8BLC4RqJoeCpUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDSP4M2RMK7fKHPxUcvaiiezgHhf7YHRCOVoqQmEZeA=;
 b=qfUnAqVvUVsgh+6SjS4/AfVW0DdntMWve6heMxFLVqsKtGR4zLdeTvgN5+WsmWyuuGQsalXJ/VnUXUQasFHSzQLrWjrCBI5U43cwG/ZJ2tffJjv335xaQ97jshaPL0xX5rrpRKnwtHZ5GvD//D9LDsnC8jWYiJCpdyxKKJtcLcwKimsj0X7xnUknF68YfcevJ13063sxEepQPjAX4HrppxDr/J3/EncOIzk80JFZbrkCkZuejb6EUSUviDhuOfwEQd2cw76Wepga3bBk2QDeJpEXF7Mp7qeGEcobFZ+oVN3lnJhJch7zAhLeuXQnelH4qIJUG5oarjYBCXus6cxEWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDSP4M2RMK7fKHPxUcvaiiezgHhf7YHRCOVoqQmEZeA=;
 b=BOMJt3NlDyyZn4sH39UGMeslvo6Az1usVwt/9AAivLSXBPTs2cAtgqPDXiCE15pE9FLZtrAxZirF5VvtjM4d4azk7JTB2ypG72/873PXRGiX26Mrkv3i762xCM6SSPv12V8lD5Z4SYZxhuk4dUb/hm16kwuwzgqjCl1crmhYAKU=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ1PR10MB5929.namprd10.prod.outlook.com (2603:10b6:a03:48c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 18:02:59 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%7]) with mapi id 15.20.9137.021; Thu, 25 Sep 2025
 18:02:59 +0000
Date: Thu, 25 Sep 2025 14:02:55 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Elijah <me@elijahs.space>, Elijah Wright <git@elijahs.space>,
        Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Uladzislau Rezki <urezki@gmail.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH] rust: slab: add basic slab module
Message-ID: <bypo74mzotejpsjdqd55sxygq3wjffnnimpm3vhm2xr5bddmen@lt6sr77ys73g>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Danilo Krummrich <dakr@kernel.org>, Elijah <me@elijahs.space>, Elijah Wright <git@elijahs.space>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org
References: <20250924193643.4001-1-git@elijahs.space>
 <DD1SGLU4180C.361W5XLH76XNC@kernel.org>
 <73d7d53f-439b-44a9-98ca-0b1c8fbc1661@elijahs.space>
 <DD22FI7F2ZHT.32SL8PXFZZHV3@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD22FI7F2ZHT.32SL8PXFZZHV3@kernel.org>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0421.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::23) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ1PR10MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a0f1e8d-6057-4dff-eda6-08ddfc5dc312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oFEVLtXt3rlUQTgEwkaGdeX9jZladt8pOijOxRkve9R/nyFgNYMGBH4OqxIS?=
 =?us-ascii?Q?6zaX4Vj4hLubC+qpJEQtyAR7NzC5S7XQ/bFqAd/qwJSMjEH2YBgpmGBzjYEf?=
 =?us-ascii?Q?CcJAxFrJearbvXNwEkljpJA/+WK8JnoZlBy/Pm8P8362e6zi6dKFu2AdY/S3?=
 =?us-ascii?Q?5rNV7dyLZSLLg+0h/AoC9xuCnk+5LVv4am0BTRKr1J6F7dPlMvuwEw7sFTcb?=
 =?us-ascii?Q?WoMe8kxd8nGT5bKRqBqx1OUK2jLJ9M/PQYZHDd3/USoaGjQ6iqMrKaUxKlsa?=
 =?us-ascii?Q?OTmvDSh0ztWqgTbmHspQlHV5fqNPbVAow0X36GNC+TmZuhWITlWC2XvgrrSI?=
 =?us-ascii?Q?+lPQ0kIrdhTC2MBPtbEhQh8bCzhHknbGktZWsjOS6SG3W3xHAEluxJwZ1CnM?=
 =?us-ascii?Q?6V4v1gWgEtBlk3iApGMVHG4WFaW8uBv9bdNE7/x2myr6XoHjhqeKXWgiz+d/?=
 =?us-ascii?Q?tmmmsdNtvpLhhokOJa8drFi7Dw+WSRX46ks7PdiIYrCpdqIoeyHS7Nb143O1?=
 =?us-ascii?Q?3o+f3mdxDjqN5OFLYtvs+fXoogPcTHhhOvOorf2pjZVOq26CnDV9NTnHGU8H?=
 =?us-ascii?Q?YZw829jUOW68Aedqk26KvMU7fkSK+fH4RzSGTTrrD1SmxWIWCzSVNFQrSQIO?=
 =?us-ascii?Q?zj7Srrxk+xV3MyfDIW3X8dRbZSvAXtNW1jdN0lE5H/wEw4m3r97XtaXOq1Ph?=
 =?us-ascii?Q?2FvGMLiSO/i+8h+caSM2Zi6VQTmseIK7luhHqHo9a7rTS39ZsDUxzz3TSYRf?=
 =?us-ascii?Q?al994O8HMObGrMtvUfqh2GPxxp89wfwzzQGGrf7ge1m80Z0wBbsunRHtorIk?=
 =?us-ascii?Q?DKcslQ+OWjxRSYzu2AMRItmbtvBR9WStuIX14IaWOwuScYMobbfm53o8mLuE?=
 =?us-ascii?Q?5J5j6mFuIa9ID3I+MRJ5TihpbTYCAZMZoyzN+vaogAV/Q5axAm9aoS+bk3dh?=
 =?us-ascii?Q?FaHsC84xGZ1ZhR12EdXXEbgLpigeCp5MgPDNvUDevyEYIjatUbV1ETNBtYcc?=
 =?us-ascii?Q?FrZbKlZF9tv5vR21XcPyxhul7o5tmD/hi1pH2JvG+VnYEuBdwQYSvCx9o3Vz?=
 =?us-ascii?Q?UMayNcKl+cF+AWFJjp8dmb2GhnLH1mvUcBZNSX9cqFIHsmkcjVE6iiPHnfl6?=
 =?us-ascii?Q?GAftaLotJu72N9xd5wxlMZLbheuuiEMRt3RNgft/AfE+J0jAQw3/l8EN1s86?=
 =?us-ascii?Q?ulabh54IebJnBZhzXEhBLhVpJUV7gIBkZg+4mi7oOEpQX6VhQgyE2jrOMr1/?=
 =?us-ascii?Q?qwaNvgR6STn+B82Yfmk8Tw//AVWJgGWF2UI4Ro8EGzlUw+cEXRTtyVl8h92v?=
 =?us-ascii?Q?HMHCkTZkYvSjqQP/8FBKMUToeqL6PCC50WgM24NQ9GU9MAgVZE9RNupATrk3?=
 =?us-ascii?Q?KkTkEMnt8FUxW8NFEfRAWpgHnxlisj1ldoe0Mnn6mWmEnZjyfA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FnSKJubrqILjGAMNiErKj1Rurq/TEulquzU9ZEQ7jv2sWr4qp+W705E42Cxj?=
 =?us-ascii?Q?faa11AEf/BEKrAVP/E6LICMFz+qitSK89o6JifVFliJOzi82wlpVf5MwsWlE?=
 =?us-ascii?Q?z8PVAc4ealnZBZo9rhgcof0xpcC5UMXCS0mjBAMug7Cuw/564O58vwEo++cL?=
 =?us-ascii?Q?pJ12aYyRpu/igIYt9HdoUVlbhtlx91GJAjE0xsL6iuwx2wzCNKZ3ByTpMSg/?=
 =?us-ascii?Q?EJqstoC8USvjZuNhajfFCdOLxyizFImLOGTy0YGRnyfaRaqMHhJnIZ5nTzl8?=
 =?us-ascii?Q?2nbRVr3r8TGROuicccmuPTLEK8awhHOXl8209ZW+1RYFQojTXVqyyLJrZ2up?=
 =?us-ascii?Q?hrW6g8g6AVJTa+/CCkU6hjM7Tw5UDYh49nvwSpeKdfIazsLWZUP+icrzr5bU?=
 =?us-ascii?Q?khRuPP+9ijVT2IWP+TnYbTOe6lYq4caAtEjfmYiUIzhtFgri4stndtQA1Ewc?=
 =?us-ascii?Q?KAeq1ScFCM0osPSBmu+IPWdsCV4WHTfV6HPynKSqUUm0N3HUnVPLUc1J0bmK?=
 =?us-ascii?Q?GdYtP20YQutOq/2iZebdviDfMmB7PzqngPc5pEi8BLEivug9xlygPGIlkV/F?=
 =?us-ascii?Q?3bpGiFHPbdKporWh411WJxXTMMseXsh2hWdi1xcQtahXzC0TDBJAqmFxLWqz?=
 =?us-ascii?Q?qZiVI5PXUfSCtVpzCyGov3eykuNPrxIxQK5jOLBIQ2/cktzfbXMAzwFQfHwl?=
 =?us-ascii?Q?SGJBUrKJ3VPHRi92u8/GKpkONOyicTFwHznS4rpDNuIvwQlZFJagaRKk8Ddl?=
 =?us-ascii?Q?ciMPW1NzWkb8xkChcR6cooaymHvgZHn1p84392Pc+bn7+3MhjBCSrzrEHLUR?=
 =?us-ascii?Q?zPhouHgxkyWEZIYobnqT8VLYR4USQuzRzL/aFc01H3CCgSXKaJwgK7zULP9m?=
 =?us-ascii?Q?IuFm6HmlNVsi5oc0pTMVbxnyUOq2Qsoy/mBjtgmvUThh3d1xoldCONwdI1tl?=
 =?us-ascii?Q?Av4cWzfKhMjxIthHfYfF7tkgDw4ZS/BPn5ExiqIGcccUbYnNm/p5sWQc1/XV?=
 =?us-ascii?Q?9dq9Z+QMMd2/NL0YqR1SeAIdhH5qtxGy4Bne+IZPdOXAvTQnJuha/oerIpRo?=
 =?us-ascii?Q?J9OKugPeeNHtsYriI/916Fj6QyPP0M/HrgOh63xm5UhEds7wVLnLHNkHPQk7?=
 =?us-ascii?Q?rjyIww9LG0GlWO60dR8XukYbKvUVqBEdvB/NYr3HChbyWuqAymwYxnEMf5Zp?=
 =?us-ascii?Q?dMz3PDaEIptjHqTS1JV7fA6KdCzFtZtKKkUfzraNSgt9xj/fuOd6YL57VYkn?=
 =?us-ascii?Q?FQt3Onzel27801sYn8HtTvEsSn+fVTIvIIfDalzzBWr1yVbQnol9DvzQ7qgr?=
 =?us-ascii?Q?OFXtHobVvYbnI94p/kObxHpQzAXwrKLPce0evvZo4Fv9nmGhoEk7g0ACvHcO?=
 =?us-ascii?Q?z844L7YoOsdmweIsyoOBfNmmKml+JmRQNfCAtCd0OjYJC3B1LR+kqAs241f5?=
 =?us-ascii?Q?vd6vHeRm/xBxAH7kBqJY3SuMRiWurvpIRR7oH2SMRvDez7qCUiWeZ3Xe458t?=
 =?us-ascii?Q?HpbQABXshj09AB6C9KnN8CJloX2wvcjT25HPDRMVolrehgq2pi3jyYLth2ab?=
 =?us-ascii?Q?oozdwxqH52exV8ZqXArqUeeGFuJIefroUhkrcliD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	78wDHNFRLsXGyuFX1MNjaYjqLw8zpKNjUKt9mvhLz09TzSE/vwktbCCZQGE1imw21JKRtLWLDxEvNjwFRS9z+c+Oyu1C1Hb3ZUvbLsAhRF2sURGMQDFy7oaWiPKPCmmhlijQq1AWoX6uZmLYldEdGW1TU8dYIrSd8MdOkjpOuPlknDvn2JYlE0iv9tyjlV+tV19Q4AV2K5RmhmdIMYx9opXTQZkfnST4G8Yf1aFE7P8lnTVdd8EIgpj1KZ5rc0Me9s5FpfjTM6jIUPOaRHzJRsnSi8RHi2USA1UQSJ2EKtG+kQdpLiCqdugmMBEDHFwTyAybvRy9hmF5IC4QYMW8maMjJ2SCZtHJwpJMsGRkOw50D1qNO/knvqkgpILbgZ1lZDAZ0Zjg/8wRHBPvjenfsSZF4MTiOdP45JeJ2lP+79M6cAr4ZTAWDJxVWuPGRyLSD8heVgv2ZPfqFFDfG/SbM3CKDlsCJHL9URXAAL6YVFZW5dH3L/8a/AGwkIszJfGFJcWQA+eAVxpvD0zhbQHQFlGTpEnHAek0tbbQ6GT7Tt1EHz1cMvkthJg9+c5r5Jr/IZK42Lp/Gu+MZGRqjgVxsqtc2Xz9e/peL2u4+KCtaZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0f1e8d-6057-4dff-eda6-08ddfc5dc312
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 18:02:59.3366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMJ+aE7TJ50UFQnLpfxTXpIDaE17EkHTqeLDOMdHUKsI0OgW2QAEoq+OFmfZqhJyQ1lgqoje1zjXZiahwOFKxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5929
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509250167
X-Authority-Analysis: v=2.4 cv=C5XpyRP+ c=1 sm=1 tr=0 ts=68d583d9 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=_TxwUh0iadtM2wQqHLgA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12089
X-Proofpoint-GUID: lyC6TofDxlssui9e2wUMeLNX4E7fByyp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNiBTYWx0ZWRfXwIxxiAyevHUH
 BCmRL8oUzq3dVxWxseDp02QMFZlLRkiGVsptijTiJ0hR6oh6WV2B4HLq678mEc4tztClmff7g67
 CAqhoOJ0AuBuHFObYwq+7z6taDIhfUTwEh/tdAzxVoO7gMjrenwtIfar2R59ucsj7b19MJcOOIZ
 wg/BjPnAvB6T57+JGcB9L0xnK53mNNr9xytKgwxibUPoXm4oZs3sQl9qhc2WSGCip+d8s3tXXCB
 bGn8sPdcVtwVkVhpMH+qFi7qraDOH3dxR1gaytjntY+BuOCOdXc2/Z7N81k8YMEB401pixCI1Zj
 HtYTo6CmGgpFoywlK64lPxDdxtFd47si2gQ2UBFQu45glMVJSi1He+b99ziHFCabQ/opH8cCZyZ
 UeLy6PNxkrgNtstb+sbnAqFQlDEItQ==
X-Proofpoint-ORIG-GUID: lyC6TofDxlssui9e2wUMeLNX4E7fByyp

* Danilo Krummrich <dakr@kernel.org> [250925 13:43]:
> On Thu Sep 25, 2025 at 7:20 PM CEST, Elijah wrote:
> 

...

> 
> > I was thinking of maybe creating something like KBox for kmem_cache but 
> > I didn't want to touch allocator code yet, I figured I would just create 
> > the groundwork for that to exist. rbtree.rs uses KBox now but I'm not 
> > sure it should, at least if it's going to scale to many nodes
> 
> Ok, so you want to support kmemcache for rbtree nodes. Ideally, you should also
> have a use-case for that, but given that we'll also need kmemcache in other
> drivers (such as Nova) anyways, I think that's fine.

This seems different than what exists on the C side, at least to me.
The rbtree is implemented by embedding the links to the prev/next into
the struct which is using the tree.

The above sounds like the nodes of the rbtree are allocated on its own
and not part of another allocation on the rust side?

That is, the kmemcache would allocate the struct that contains the
rbtree linkage (or nodes, I guess), but not the nodes alone.

Thanks,
Liam

