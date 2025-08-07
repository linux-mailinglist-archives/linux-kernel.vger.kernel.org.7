Return-Path: <linux-kernel+bounces-759244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4694B1DAE1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2ADD723F55
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7D126562A;
	Thu,  7 Aug 2025 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hwq8V5SQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V4lzC/qF"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC0F2367DA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754581159; cv=fail; b=hNHJzaD3K6Xj+yfANzqHQGIWNhOLO49pMf5karHckZSmEwLuySYaPtNqMMHI/WM/w7u0K7SO6FDDJaodPhPBauN7cpzgA6t9GKoCCPlPR4VjJXOS25IGvHiZn2wS0Wzp7DILhrqIA1lCpujXpewbf7ysxX+S7jhDNm+QNgVW01M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754581159; c=relaxed/simple;
	bh=3oK8KZ76lB8gN3/tnoWSdOciATkpN8pUK1+dQlofuHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=luWaKh1GFbPdHddCA8sVAEKweptU8ZSHoSCRIKJxBCwNLbljE0yTMxMl/dFERhChUDhOfTeIP0DfKnxsOfgGgDq9MctzjjKBfPIH/L+It7n3FXLw3ZSpHX1BoO75l5E/DUg0wLE094LVE9JXK1dyIvOHN2WD8Embp2yiamju0FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hwq8V5SQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V4lzC/qF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577FSq3p027311;
	Thu, 7 Aug 2025 15:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=xEeEiM3AsMJxzQ3c93
	pR2D95qOI5QsEdL+nk3zXJfjw=; b=Hwq8V5SQGkyiV+MfstnnSU6apVf7rbyg7a
	ZiYJVh5aHNFd7s7u/y/HdzGxtVuuso5zXtvIKp5YCuTJUDIgFRJGkjH8Fktq3wWt
	Qk1Q+w58m7QzFJYUCmi0n/41VdKMFo28S+qbZDarGM7gSQGuPUTyq/1YkelhnpNo
	t8GnUMaqGNlu2KgGYpJLMWZncOvCh3roAHCz/9YY4z1abgsLOUE9IxsxydQEcL9v
	S5sknojTNvB3njpQMyWZrw0IhpD6U+Cre7PGdnxZYwhZBB0lnPiWCXbV0LnAg6Rt
	+beHmIqw2+ypt1t3Jp2ABTtSaa+Kk2sEyAXvBwKqjX8HnzR/H73A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvd4fsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 15:39:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 577EJEct028190;
	Thu, 7 Aug 2025 15:39:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwnu0c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 15:39:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v00ef9tfZaa8RZnZODxVVcMGDlTFqbgY4YmwZm6b9YZO31ySXYe5oNMYlTbWN1EqzdHJcsNQ7gDd63Acp/PaVX6w85HkaPGjbjrrFfcBtE40pNnE1Qp3CcPdfOyBB0QmuCMOOI7/6QVklMcvuL3UBoDDqbOY91Z+KyGDabq6//uIjfx/Nii9siUYXNiacbF0xv5jtUHlMsnZo11BqH3pCT/PRSVkl8Ek+0TPB6qt4jIf2doaw7n3s37WJVE1sr+PIRpo6UerQtTU/CDSmMIJiljpbrz9Q0d+1YXBvs1Z2D0y0s5iwiPcL/uuIV3qQWP3qlkBqZm1DZGkE5FjWdSAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEeEiM3AsMJxzQ3c93pR2D95qOI5QsEdL+nk3zXJfjw=;
 b=Bj7iDVSO9a7nX+xALqtKQhDz4S5DlBVJ664IQ3BWYaC7fydSxn0xC9yziwhPqWFMVLk7PPDFBc7hsV43YutruDcNOAkfcB5e6P/GOpmB+QJeQjAf9GjjMGwLXkk+3bOsT5nNyrrJc8e+0/AiBF4tuA6bxi3Zs0il5aJROqz0pnA8UqsFiuM/ooI0ZJev9Mq9n7r/CwD/tTtii5ku9eL6ZIbLn88zEWUdPl9zTGpWjOwXtiVnNDX9qduqBGE3PLCX1w5r+HEdTAqLmuyZZTNChtULDT8x9OHyoPOvWA8cCihUytP2oyrbG7ocYx7bvAgnBcyOXdvt+MTgYqEf6vLiLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEeEiM3AsMJxzQ3c93pR2D95qOI5QsEdL+nk3zXJfjw=;
 b=V4lzC/qF9EJsecN9nOeilQ8XG4/BgbYr4ojHoTJg6gbRTeLOvHco56kjs1OQzIz+MRdpSB21zL/V3Puk24QXEkZzLSR4gCL9CdHq8VmX/KOcyGI258tJbqW58LKVElRyJWaSEoyCZykEBHpilUfn64ZPMIqiBiYwr4pl/xYIgWs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4316.namprd10.prod.outlook.com (2603:10b6:5:21d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Thu, 7 Aug
 2025 15:38:37 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 15:38:37 +0000
Date: Thu, 7 Aug 2025 16:38:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kees Cook <kees@kernel.org>
Subject: Re: [patch 4/6] perf/core: Split out ringbuffer allocation
Message-ID: <cd206fce-0a91-4501-a863-d398dbca197f@lucifer.local>
References: <20250806195624.880096284@linutronix.de>
 <20250806200617.450396385@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806200617.450396385@linutronix.de>
X-ClientProxiedBy: LO6P123CA0050.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f17267-6885-468d-0446-08ddd5c879da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TtZ3GKtY1RDQP+mJNG64zdqAsszlXRqqAOCNkyNF94q8padtyNtRg7CDVoXu?=
 =?us-ascii?Q?JaipxKn2z7LYckQDvTcDJgPzErl8S1morwsE9B2ooUBde2S+x4P00ufN/XQb?=
 =?us-ascii?Q?95AeuVtvfWp0T3/e5bmNsFHRkJVl2YOS/Flq9crxai5HcEzk32fXDlaSda33?=
 =?us-ascii?Q?3goamQ/7KSP7BbT9GO4QZxEg7eD51tnMzXO9zabgGnz3odidfdsPMj0FoRVa?=
 =?us-ascii?Q?6PI2kWtr4KeORl4LRZt/lmyw0E+EgFZPfnmAFyzvnDGGicTf5qUnnXpY0Qm1?=
 =?us-ascii?Q?D7RNdCZ1NZxM2HpP8C29DpK5HM8b4BFHkNvMwFqqrTEouG9yM3HEVIg43YdU?=
 =?us-ascii?Q?nfIPPUwH1LiqBnTXLnlZF4ruzZCPFedZNRkOfqsgZJR8IjO1CvJqAeyuwARw?=
 =?us-ascii?Q?LWW6ih8iPS5P0SdunjIv7aKsLOE4LDB3IdPeWPRBUxOgTpvqiSQIIshCQUWU?=
 =?us-ascii?Q?ljDidaXKI5Cw4IKep37i/YcO/+QaGOwGXGl0u3E7r5SzUiL62+krw/4uBBRV?=
 =?us-ascii?Q?8fW6YpXxD41Hr/rq6MQdxqpuFUOtFQyjNa8MsZleu+QMaWB/d9RVBNcjT0qQ?=
 =?us-ascii?Q?Q7IJvk6XH4YMshKNh34nZ1GnhS7uARjAWm1Fk89bQxt/ENbXV5AGFS4LlpzY?=
 =?us-ascii?Q?Lt6I2KCtE0rLxWc49IQK9xqT+FT04vjWAPM3tsVXIlLL2trKIN33HstCEz3b?=
 =?us-ascii?Q?Czjt4ziaWcnh3S7ZjBr9C4tEkfcbO7x+AcfLDXr4J+BppOMtJJj9V5TUk0dd?=
 =?us-ascii?Q?AgD+aK1KovxSAA3ABSecMsQezywlaqCYtvZhYMdiVx6YKXdvLo2Uti1NOA6Z?=
 =?us-ascii?Q?5VX/qdXdtQkrM+WnRPt2DB5ULWxwp80LrifBQsk0HkGItugteUbDcOlq401L?=
 =?us-ascii?Q?wsNztgwsdEFX8m/epfETRjl1NXbogTnoIJ4TVSa0NCA3kallrcpjJ9rnB+NJ?=
 =?us-ascii?Q?XHCkU6EzjYReWhwznPsSeB7ZFgYp99NjzHc9W70rXDrauDfHjfoh2vwHmVyD?=
 =?us-ascii?Q?VuhjQ88mgeO1vyPbnb4mdgtp+tdHqGGQ1YKWusHuAABvEk6oO8eOgtJob9gZ?=
 =?us-ascii?Q?VinTBANveOYQ0deVLSrVci656Y0YZXtXJT76RohGBXgENtJsPmzGd/ixPYkY?=
 =?us-ascii?Q?elJTZC6HtwKKq6QJ24Hjesxmdwj/kKwKKlGBlgmSxaqFjqDXVGifNhLcQU7F?=
 =?us-ascii?Q?QXcJZ7Jq02so2BmCnNnVP2eIPhDGMxRICee0x83LOhHt76oIBv0NhT9wlV0u?=
 =?us-ascii?Q?sIv/1DmQoDCSW8T1j3H2ZTlmzhJ1MaW1F3OTIbGfjQ0Hajj98W8GLIEFzG8e?=
 =?us-ascii?Q?rAWuSJsIJGdIX0LZNFQwqjGYpoP2yGnX78Wn69aGw46Tn+blFXprEUyIMo9w?=
 =?us-ascii?Q?yfSsGdURCzhSN0fG7BsL9IIECR91E8FPm1JAW6N1HHQ35nxruESurMNdKiqO?=
 =?us-ascii?Q?q5+PKHvQgc4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mWIN6PmrnjnO9HmbXP5HyAmMehnzDiHrEn5tR1VIEbywcXGaCrVJFuuGHwuY?=
 =?us-ascii?Q?0Yv0c4DvLKwZlI6BGlmS4akCuqP6iotrn8LlTdEPwdjzfq+tjhnK2OUq0U6d?=
 =?us-ascii?Q?pcJDVPEm3ltxMhgoO8FX6SXZBOK/0pkCBKOs/QIixeez5kl8Q4sEb4zO3f7S?=
 =?us-ascii?Q?0QX2srbj/zWgRmxPrIp1SMBsAedKZXDCjW/0edWedxOcStj5ZTnsSHJgPqmJ?=
 =?us-ascii?Q?uni7K1RBYp2vT9vB2pIWVbSPu4SCGGUKz9wViCRcvVdvW3LYa8rYkJgWEoD0?=
 =?us-ascii?Q?+z/nFG6QBfeJl9YqvZzVo4I6MzFo0KhdZpIIKWPPwa9qt+HpuFjVB5WOml8v?=
 =?us-ascii?Q?OIIkDorKyxjOELVYpRGoJBOAjXUwEOuDSnd9yaMMhIXujBuYGh9h0JquiFSm?=
 =?us-ascii?Q?OhnoUW+FefPgD9quKnR9zDVJ+6UuBM+tzr1zmCuzR+DPcai0VY7g2D8S0g6U?=
 =?us-ascii?Q?FSwWey7x3MzvDZLqxMXABHdLAY0geEBrLIROUqRot98f8yaITvrZvG9KEIi4?=
 =?us-ascii?Q?IzG3iCnuPe07XncVA15SLhrPnwwEoXu72/bIk+RkdQ5neKSrXa1nBbYVtd8b?=
 =?us-ascii?Q?FnuBMRrzoKyshIHbe1iyphcU/ztLc0dsEGbd+E++WuNXAOSI28fk0gLygRNQ?=
 =?us-ascii?Q?hr7fkNqtL1MyMG3LCJkOJp4Pu0VtQnIp3G/32k9OOY04r277CXq6W7/rdsFp?=
 =?us-ascii?Q?i6l1+SlqaEmF9ca9iBZgO8Al9915YSjrYcaTC7FqpFUsPOED6zyTpqB9CsBA?=
 =?us-ascii?Q?aPhlgxmrV239LFeOUt3EROekllYjSmW6oJJneUp91HNdqvXEnMyfOiil4sDS?=
 =?us-ascii?Q?VmaeTUggY1vyWr/Bn1xcwEeQrUNFve70fFT540E/vCl2oY72i4VZZqQ3zWWE?=
 =?us-ascii?Q?XLlEf1T/0n0qRHUXfQQ638M6oNzpLOhDOnaLd6Td+J2b9VA4tdL+k4FeEckW?=
 =?us-ascii?Q?hWTlTP7w8MlfQKIUJvLvJ8oKYMzXcCEcCX/9jesdK92Fhna6hTk3C9Y2okqH?=
 =?us-ascii?Q?w4nGZBmbeg4KVkbVXAxeOY1Y7+e8CukBMtH86FLzDCcgjLcPNyNyRSKNrhqN?=
 =?us-ascii?Q?EUGkuqQtU+3Xjxi/cRPT2GG72IZmwu4t4HpLhUQgjIgrIVTSRSf9gdU7hI8V?=
 =?us-ascii?Q?698YzblhS+xrAwKcoFNpS7NR7/c7YA4K8+ldOMJynZ87Skvrgt4+ldEl1uNc?=
 =?us-ascii?Q?VolReCBjVrSYwathTiPntqSuaECWWy+5v6HhFuVNCJRwtmf2wA1tNWm41EJD?=
 =?us-ascii?Q?mZNuLVkoIp+vsAZiIrm9lv4Ib7XhlIGD84DjJqsTYHWUxFwEXVuiBGHa4XYw?=
 =?us-ascii?Q?F1eTtY8PdEo0/Suan3bA10oMWTgCWp0w5ZxjicIgB0AmIhoTNaY5mBjMPpVY?=
 =?us-ascii?Q?i0TXOXVbwkDoah51sTL6l+TlshQDzWNzXktIZqzS7sGLczWa/5+hMxyRdTDI?=
 =?us-ascii?Q?bwGAH/7Yetzmz4lzfcDVyABuCQ9156CLgVaIT/VFoQjLSqTMx20fZ3LZWxDT?=
 =?us-ascii?Q?P6MXfpJHKWfJccOa6+pm8JfxEwVWmaNyz8qSy98N3Y761d+tgeRb+eC1CJ1b?=
 =?us-ascii?Q?ZzNU6Ju19YF6DJ9dG2bS5WqTH4WtRb8QLJH6NLObsmPYlSE0VDuNKUSQStIa?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gU2VcUKr/eaJ/Btat/NCdXBpnE2zjA+MyjzCnGh6b88BKhHv1w/7e872nD0lEujY7yH3xj+/batcuHxFonDREj7sRfb/p8L10Bq3E1HHErN/8HosIA0KScENyp6yNVzurXg0TbHyQeDRi2h7Kzs+8sKRG0p0C2LCLB8XvcJu+UrByAI9aE6xMup+0WXKEMtjDVxRGX6gNjFgUno8cB1iGmiDRjU2iv9oPrcwbl3G+YI1GxUXC0vki0vaMX7vBvyEPTOa6L/hWdBP6r7bvMYVyFhEXUY/GKGx0V9Quwa1ZOI/bmHUvbprU24nGymFkVB1Qd46CTREs2cT8ZZfRRtGQaHUpYKeSoHrMKlEis6Akk6kOKgvsxBT9PCLgFqtDBfGsdvQI3Y7ZIQa7UYqFUZXc4Iy1FV0V3Z6vo4vuMPrU343qW+Xq5rzSqd40JsucaMj24tFVqAnCYqgqijl5v/povXyoTT0g7dPK1a8vxvhSohKxsNDuvrSBnyI9jxiTBTPI+u+w7e2A9lrcQFg4VGNptrnLxjnzhcNlDX99xigaeAMycbanCNu2HA2RaMEFfmfJdxj7ku9Yf+fBjicGcwWsh3IRdtNfHFwnVAeWC+5xuw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f17267-6885-468d-0446-08ddd5c879da
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 15:38:37.2809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBZlRrEbMY2tTaSZyNo7m2o7yFVTcVi+ni4j+XSq3OcJZqa1UGF8xwBKB0MrNZPV/6l8TlRkUOPed0NVyPA3gbABxnwPCsLcz16eGemOH8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508070127
X-Authority-Analysis: v=2.4 cv=fYaty1QF c=1 sm=1 tr=0 ts=6894c89a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=3U6Uxi_kE9xsMhLAdSkA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: RP2YPs-jHX6iNUii5IzYugCrYcR1C3FX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDEyNiBTYWx0ZWRfX15hygu+3RRZK
 576mEgsvI9lg/sVwX/zJz3clbudD62/9oSgIUg0ikbzJHxKhsFdRVtAO9XVUCJN2SRt1RfxgcZ0
 gFg8rCuTuF9SV9ToVDVzt8is8X4bhhDAhNKvrR1TUsTkKJyW8dIPAs07Xp0oyDA9MvKmOVHaf8C
 Ru4Tegl8zLSQwpAueAAB7/1Yl84UQr03HT8RkUQ7DLhPtHoSvHjWUbc0pOrjmPvGx7UJe3nXzbx
 LePYskLZ6LNeg7e+WgS5jQYsx9xnT2lU9Gz4AezGCiMU2fV4yWKLUpnSBcKUo/OT6wTFyx2L3R/
 3jvEojZEfr0qxwVVgWZsRVu5+7Za7W/d3vBoq6puXVq/uljLfNU93m6r1tFTSE0N8hQb87n1/lj
 lQhYDC3oOf1vmtRIHnnxIZ1DEAOEZh2Vg7j/mosTqH82+b7n2fIBXbZw+eqH3ZNarOMP+oV2
X-Proofpoint-GUID: RP2YPs-jHX6iNUii5IzYugCrYcR1C3FX

On Wed, Aug 06, 2025 at 10:12:58PM +0200, Thomas Gleixner wrote:
> The code logic in perf_mmap() is incomprehensible and has been source of
> subtle bugs in the past. It makes it impossible to convert the atomic_t
> reference counts to refcount_t.
>
> There is not really much, which is shared between the ringbuffer and AUX
> buffer allocation code since the mlock limit calculation and the
> accounting has been split out into helper functions.
>
> Move the AUX buffer allocation code out and integrate the call with a
> momentary workaround to allow skipping the remaining ringbuffer related
> code completely. That workaround will be removed once the ringbuffer
> allocation is moved to its own function as well.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

It's easier if you separate out the move and refactor but am going through here,
just to check logic:

- Separate out checks into perf_mmap_aux()
- Add some comments
- We use scoped_guard() for the &event->rb->aux_mutex lock
- We actually return -EINVAL instead of stupidly relying on the default ret
  (such a footgun that, have hit issues with that before)
- Instead of proceeding with the rest of the code as before, we temporarily:
   - drop mutex event->mmap_mutex mutex

And then we explore the other differences below.

There seem to be two bugs, I've noted them inline below. The most series is an
inverted event->rb check, the logic below assumes that's fixed.

THe second is that you don't seem to be doing:

WARN_ON(!rb && event->rb);
if (vma->vm_flags & VM_WRITE)
	flags |= RING_BUFFER_WRITABLE;

In the aux code any more. Maybe first irrelevant, but second surely is?

I noted below inline anyway.

OK moving on, therefore perf_mmap_aux() does the stuff in perf_mmap() that would
previously be execute which would be:

~~~~~~~~~~ 1. ~~~~~~~~~~

-- BEFORE --

	if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
		ret = -EPERM;
		goto unlock;
	}
...
unlock:
	if (!ret) {
		...
	} else if (rb) {
		/* AUX allocation failed */
		atomic_dec(&rb->mmap_count);
	}

aux_unlock:
	if (aux_mutex)
		mutex_unlock(aux_mutex);
	mutex_unlock(&event->mmap_mutex);

	if (ret)
		return ret;

-- AFTER --

(We already checked that event->rb is non-NULL)


	if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
		atomic_dec(&rb->mmap_count);
		return -EPERM;
	}
	... < scope_guard takes care of aux_mutex >

		// Temporary workaround to split out AUX handling first
		mutex_unlock(&event->mmap_mutex);
		goto out;
 	}

out:
 	if (ret)
 		return ret;

(seems equivalent)

~~~~~~~~~~ 2. ~~~~~~~~~~

-- BEFORE --

	WARN_ON(!rb && event->rb);

	if (vma->vm_flags & VM_WRITE)
		flags |= RING_BUFFER_WRITABLE;

	...

	} else {
		ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
				   event->attr.aux_watermark, flags);
		if (!ret) {
			atomic_set(&rb->aux_mmap_count, 1);
			rb->aux_mmap_locked = extra;
		}
	}

unlock:
	if (!ret) {
		perf_mmap_account(vma, user_extra, extra);
		atomic_inc(&event->mmap_count);
	} else if (rb) {
		/* AUX allocation failed */
		atomic_dec(&rb->mmap_count);
	}

aux_unlock:
	if (aux_mutex)
		mutex_unlock(aux_mutex);
	mutex_unlock(&event->mmap_mutex);

	if (ret)
		return ret;

	... vm_flags_set() blah blah ...

-- AFTER --

	ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
			   event->attr.aux_watermark, rb_flags);
	if (ret) {
		atomic_dec(&rb->mmap_count);
		return ret;
	}

	atomic_set(&rb->aux_mmap_count, 1);
	rb->aux_mmap_locked = extra;
	perf_mmap_account(vma, user_extra, extra);
	atomic_inc(&event->mmap_count);
	return 0;

	... < scope_guard takes care of aux_mutex >

		// Temporary workaround to split out AUX handling first
		mutex_unlock(&event->mmap_mutex);
		goto out;
 	}

out:
 	if (ret)
 		return ret;

	... vm_flags_set() blah blah ...


-- rb_alloc_aux() failure path --

BEFORE

WARN_ON(!rb && event->rb);
if (vma->vm_flags & VM_WRITE)
	flags |= RING_BUFFER_WRITABLE;
atomic_dec(&rb->mmap_count);
if (aux_mutex)
	mutex_unlock(aux_mutex);
mutex_unlock(&event->mmap_mutex);
if (ret)
	return ret;

AFTER

atomic_dec(&rb->mmap_count);
.. < scope_guard takes care of aux_mutex >
mutex_unlock(&event->mmap_mutex);
if (ret)
	return ret;

--  rb_alloc_aux() success path --

BEFORE

WARN_ON(!rb && event->rb);
if (vma->vm_flags & VM_WRITE)
	flags |= RING_BUFFER_WRITABLE;
atomic_set(&rb->aux_mmap_count, 1);
rb->aux_mmap_locked = extra;
perf_mmap_account(vma, user_extra, extra);
atomic_inc(&event->mmap_count);
if (aux_mutex)
	mutex_unlock(aux_mutex);
mutex_unlock(&event->mmap_mutex);
...vm_flags_set() blah blah  ...

AFTER

atomic_set(&rb->aux_mmap_count, 1);
rb->aux_mmap_locked = extra;
.. < scope_guard takes care of aux_mutex >

perf_mmap_account(vma, user_extra, extra);
atomic_inc(&event->mmap_count);
mutex_unlock(&event->mmap_mutex);
...vm_flags_set() blah blah  ...


DIFFERENCES:

If we get to the rb_alloc_aux() bit, we're missing the:

WARN_ON(!rb && event->rb);
if (vma->vm_flags & VM_WRITE)
	flags |= RING_BUFFER_WRITABLE;

Bit for aux case.

Otherwise, it seems to be equivalent.

> ---
>  kernel/events/core.c |  134 ++++++++++++++++++++++++++++-----------------------
>  1 file changed, 75 insertions(+), 59 deletions(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6970,12 +6970,76 @@ static void perf_mmap_account(struct vm_
>  	atomic64_add(extra, &vma->vm_mm->pinned_vm);
>  }
>
> +static int perf_mmap_aux(struct vm_area_struct *vma, struct perf_event *event,
> +			 unsigned long nr_pages)
> +{
> +	long user_extra = nr_pages, extra = 0;
> +	struct perf_buffer *rb = event->rb;
> +	u64 aux_offset, aux_size;
> +	int ret, rb_flags = 0;
> +
> +	/*
> +	 * AUX area mapping: if rb->aux_nr_pages != 0, it's already
> +	 * mapped, all subsequent mappings should have the same size
> +	 * and offset. Must be above the normal perf buffer.
> +	 */
> +	aux_offset = READ_ONCE(rb->user_page->aux_offset);
> +	aux_size = READ_ONCE(rb->user_page->aux_size);
> +
> +	if (aux_offset < perf_data_size(rb) + PAGE_SIZE)
> +		return -EINVAL;
> +
> +	if (aux_offset != vma->vm_pgoff << PAGE_SHIFT)
> +		return -EINVAL;
> +
> +	/* Already mapped with a different offset */
> +	if (rb_has_aux(rb) && rb->aux_pgoff != vma->vm_pgoff)
> +		return -EINVAL;
> +
> +	if (aux_size != nr_pages * PAGE_SIZE)
> +		return -EINVAL;
> +
> +	/* Already mapped with a different size */
> +	if (rb_has_aux(rb) && rb->aux_nr_pages != nr_pages)
> +		return -EINVAL;
> +
> +	if (!is_power_of_2(nr_pages))
> +		return -EINVAL;
> +
> +	/* If this succeeds, subsequent failures have to undo it */
> +	if (!atomic_inc_not_zero(&rb->mmap_count))
> +		return -EINVAL;
> +
> +	/* If mapped, attach to it */
> +	if (rb_has_aux(rb)) {
> +		atomic_inc(&rb->aux_mmap_count);
> +		return 0;
> +	}
> +
> +	if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
> +		atomic_dec(&rb->mmap_count);
> +		return -EPERM;
> +	}
> +
> +	ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
> +			   event->attr.aux_watermark, rb_flags);
> +	if (ret) {
> +		atomic_dec(&rb->mmap_count);
> +		return ret;
> +	}
> +
> +	atomic_set(&rb->aux_mmap_count, 1);
> +	rb->aux_mmap_locked = extra;
> +	perf_mmap_account(vma, user_extra, extra);
> +	atomic_inc(&event->mmap_count);
> +	return 0;
> +}
> +
>  static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	struct perf_event *event = file->private_data;
>  	unsigned long vma_size, nr_pages;
>  	long user_extra = 0, extra = 0;
> -	struct mutex *aux_mutex = NULL;
>  	struct perf_buffer *rb = NULL;
>  	int ret, flags = 0;
>  	mapped_f mapped;
> @@ -7055,51 +7119,15 @@ static int perf_mmap(struct file *file,
>  		}
>
>  	} else {
> -		/*
> -		 * AUX area mapping: if rb->aux_nr_pages != 0, it's already
> -		 * mapped, all subsequent mappings should have the same size
> -		 * and offset. Must be above the normal perf buffer.
> -		 */
> -		u64 aux_offset, aux_size;
> -
> -		rb = event->rb;
> -		if (!rb)
> -			goto aux_unlock;
> -
> -		aux_mutex = &rb->aux_mutex;
> -		mutex_lock(aux_mutex);
> -
> -		aux_offset = READ_ONCE(rb->user_page->aux_offset);
> -		aux_size = READ_ONCE(rb->user_page->aux_size);
> -
> -		if (aux_offset < perf_data_size(rb) + PAGE_SIZE)
> -			goto aux_unlock;
> -
> -		if (aux_offset != vma->vm_pgoff << PAGE_SHIFT)
> -			goto aux_unlock;
> -
> -		/* already mapped with a different offset */
> -		if (rb_has_aux(rb) && rb->aux_pgoff != vma->vm_pgoff)
> -			goto aux_unlock;
> -
> -		if (aux_size != nr_pages * PAGE_SIZE)
> -			goto aux_unlock;
> -
> -		/* already mapped with a different size */
> -		if (rb_has_aux(rb) && rb->aux_nr_pages != nr_pages)
> -			goto aux_unlock;
> -
> -		if (!is_power_of_2(nr_pages))
> -			goto aux_unlock;
> -
> -		if (!atomic_inc_not_zero(&rb->mmap_count))
> -			goto aux_unlock;
> -
> -		if (rb_has_aux(rb)) {
> -			atomic_inc(&rb->aux_mmap_count);
> -			ret = 0;
> -			goto unlock;
> +		if (event->rb) {
> +			ret = -EINVAL;

Shouldn't this be if (!event->rb) ?

> +		} else {

Because here you're dereffing event->rb in branch where !event->rb?

> +			scoped_guard(mutex, &event->rb->aux_mutex)
> +				ret = perf_mmap_aux(vma, event, nr_pages);
>  		}
> +		// Temporary workaround to split out AUX handling first
> +		mutex_unlock(&event->mmap_mutex);
> +		goto out;

Noted above but you're now skipping the:

	WARN_ON(!rb && event->rb);

	if (vma->vm_flags & VM_WRITE)
		flags |= RING_BUFFER_WRITABLE;

Bit in the aux case no? Unless I'm missing something?

>  	}
>
>  	if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
> @@ -7132,28 +7160,16 @@ static int perf_mmap(struct file *file,
>  		perf_event_init_userpage(event);
>  		perf_event_update_userpage(event);
>  		ret = 0;
> -	} else {
> -		ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
> -				   event->attr.aux_watermark, flags);
> -		if (!ret) {
> -			atomic_set(&rb->aux_mmap_count, 1);
> -			rb->aux_mmap_locked = extra;
> -		}
>  	}
> -
>  unlock:
>  	if (!ret) {
>  		perf_mmap_account(vma, user_extra, extra);
>  		atomic_inc(&event->mmap_count);
> -	} else if (rb) {
> -		/* AUX allocation failed */
> -		atomic_dec(&rb->mmap_count);
>  	}
> -aux_unlock:
> -	if (aux_mutex)
> -		mutex_unlock(aux_mutex);
>  	mutex_unlock(&event->mmap_mutex);
>
> +// Temporary until RB allocation is split out.
> +out:
>  	if (ret)
>  		return ret;
>
>

Cheers, Lorenzo

