Return-Path: <linux-kernel+bounces-721925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1342AFCF86
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376C53A65DB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834F12E11C0;
	Tue,  8 Jul 2025 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jNu6OK3b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S3nnoWBR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803E62E1C52;
	Tue,  8 Jul 2025 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989267; cv=fail; b=GBwlVs91gRUDGMZKyPLNbA/muAQQFECOSjgso4uxJ7xYGxQoZ4E68yjBb5SNDFHxmsndjMJuqu7lqjv/BKvHgV/UtRx9Fo+AivbpKRHE7SdajYfcC4UekAwcoStL0C2k1DN83amOmvDEFqkCh3cC7euSRuFsfQY2JsVQkhAEULY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989267; c=relaxed/simple;
	bh=7pJRQjEoFSF4DW2jpZ69dabwtGHRjmtlx822kUtOjd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GVGY/iqwdGlsutkyM8Cg2XiDWjzT0jnADomabpxzGyhvSlkO18tXz7EqtyHfOhGuEafOwRbrvPsaD4+oZf5u4xDaLuatvjLuLi5k113SjiKwURQGK4Jw1GYhmqLH8kpODvWNB3M8VZMK2pPfG++3JEpPdbAv6CPgDWDTz+d/ODw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jNu6OK3b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S3nnoWBR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568FVr9l012616;
	Tue, 8 Jul 2025 15:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=LUfKq1KbgIR9tuRiPG
	o2STuxEMHX2iuD4L2oMVYmusg=; b=jNu6OK3bLpF5WsCraBJ49SSWjEkayctuaR
	fe0X3hPFmP9otqG/lJ/6ELUaPdW7jIGrkAut5uHhBiQgFIgTv/W3i24gFltASheL
	YvXbgfuYyW6V3eeD3CImpFgSDm2D2E6BXdQxomFQFfYcsRrTKQyM5NdVQQU57ckE
	nK9va1y+hO3thkRrp+Sxkh4Qbxx1yHy4VvqMTJUL+ZajBBLHuY4tFAWMzJc9sW4g
	gmBUTSEjOLNdTLVIkPiia9zcipy6r6rdNZo2LI81tUQRKVYi87i2ujv9Um06qcBI
	/J63iKJ/PwwldJrpd0fMLPsVywpfKGIhH47LUgCWGhGp29G5/iMA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47s62300q2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 15:40:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 568FG9mZ027339;
	Tue, 8 Jul 2025 15:40:47 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg9s939-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 15:40:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jS/ZoGkmUQk1tQ7n7sw56Va1EIDi2TLqnST1shHmZU0daJJa1ack1NaZ5G2jDydACx946jpw541rQlcjsKNTSrvy+4h48KW4yrtdaVGS/fYi6Q2JGfu2yp9L+k6dCmQ5gSdrtU1XxXG8BGkkhQDVP2+AF3Kcpu14UaxzDURgukBjhUzyl7rpbCo+07q/ebs7LTcdUXul9Sf5bmtCZlJUiq1HsFA0blqFi5PIjSuQ6xh/WhoBZUiBzuH4URx5gfUaWr7H8tyYUtBLgY1u/vEcA8kj4PsAKMc5hlZhyjNip7zuyoIsrs9EjpudJZfqmXdzWgteCHj2Z1yARWL45Jsmbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUfKq1KbgIR9tuRiPGo2STuxEMHX2iuD4L2oMVYmusg=;
 b=cQKMC+CXQQ8zUVZ5rdpABUu3SCDjNrNpDsWekiztPVFkBEUXSfFb+i3gFHjWlw3eblegrWD9uTQtHydNhK5s70I1FuHNSz3G/sYGdDCUcpQNXAVXA6PVqsfga+7dptdLXXA1qG9/18+B2OhynMNuRYS7TqK8/M8JAfiSFDbzLegQDm5zFBdLN6T7yImvvzhrkRgW8N3PnESR9lLtaGIjQs2s5dZlHFduc/r0Ywjju7XsX0saP+KjoIQwR5InVHoLTOkMaIgF3DQrL3LNxvjVJ9xsY6bXc4qCz4qUG/mJUM2okRzCJlJxJtNI75R8Jp7EI4nLVbd7atreP3zqpaFLRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUfKq1KbgIR9tuRiPGo2STuxEMHX2iuD4L2oMVYmusg=;
 b=S3nnoWBRAUSt9FOx76zwWMkT8QsfefuaaYZVZDIbU1+p+Mbvj18v78hBcnvMAKMSyi7JJRrn71XDVrYgFH336JYp4+E2FZX4AqV8IYColn/rLfvVQNbV2qmLmi5OzPndq5EuebTj3nX0kxOM1WQHZqQglrg7qO6zck682fRDqCc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO1PR10MB4564.namprd10.prod.outlook.com (2603:10b6:303:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 15:40:44 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 15:40:44 +0000
Date: Tue, 8 Jul 2025 16:40:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Vitaly Wool <vitaly.wool@konsulko.se>, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Uladzislau Rezki <urezki@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, rust-for-linux@vger.kernel.org,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [PATCH v11 0/4] support large align and nid in Rust allocators
Message-ID: <8b014021-0e6d-4649-995e-97be774d59b8@lucifer.local>
References: <20250707164755.631374-1-vitaly.wool@konsulko.se>
 <824065ea-1f5c-4cd4-9917-4b7a91882af8@lucifer.local>
 <aG0HJte0Xw55z_y4@pollux>
 <54fc10ce-c3b6-4571-93e7-eebfc538d0c7@lucifer.local>
 <DB6QKIHD2VGS.AHEOXL25SSXW@kernel.org>
 <4c122436-db58-4ca5-bc64-5ca596f03952@lucifer.local>
 <DB6RQCZYHPSA.1UEPUVMC3FBBI@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6RQCZYHPSA.1UEPUVMC3FBBI@kernel.org>
X-ClientProxiedBy: LO2P123CA0042.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::30)
 To DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO1PR10MB4564:EE_
X-MS-Office365-Filtering-Correlation-Id: 530e2997-f502-45f5-04e6-08ddbe35cd4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9yegaZDr3JuiOrrz5rvp6PFYBLhEg8nkDSaR4b1Mm8WrziHeWg6TF77/bdJj?=
 =?us-ascii?Q?fzIa/q6PpZWSA3g//0xbA4j75SzxsX8G6bLsBSJM1mTU8XbgWegnAkahxSUY?=
 =?us-ascii?Q?WeFExHkGLTNifybkYWAAmC+5A2C90PR28oeih6ylILjOePCFZND4fcC7FOAz?=
 =?us-ascii?Q?Y0p3cj+sSP7g4JVKhzU63ZhFjkdig9p3FDiIPKevVtjFwMtgz5X0H0bRuxBo?=
 =?us-ascii?Q?WX+auWr5mNDtflaiEV8P6AiL/aT+SxFdJeTqAuc5vFeTnL1iFj8EEsg5wm8M?=
 =?us-ascii?Q?IwJqW378hJBcwzKO36sCCMBCwpV7szOj2dONmiqekNivfUG/Z1rxgDS5sej8?=
 =?us-ascii?Q?lcbOZ/ntrmxZBeNJioqzrLJcuItoOhIFgN9dj0NWmh9NBYQYLgU72q3mpscA?=
 =?us-ascii?Q?F57l0xKaWBn1Zd3i61I4FXlebPzAlxKlkjx8aFkceGlSiXQBpHH9iGIOA/YX?=
 =?us-ascii?Q?C0V03gpIcUxBtv3GlLOE+JeNDZL7JvqF1+/7qBbJpJOFyiB78yi9WC2Z+91+?=
 =?us-ascii?Q?1pY6UskSD/mDUZTheRaziGrxpHD1W1rGKWKv8Bjduo7gTJ8CHzNjkjSaW0G2?=
 =?us-ascii?Q?jJz33BLJUhPpQNSuApf4xW2oXP6r3K5+V2C/APT81b8rIlGWESK6hePRIDoG?=
 =?us-ascii?Q?8493dLlqUj/qYmc2YdHvSmcCvPs7XFJr16v8k72riyIEo5EGFoKTxIB+Mvtt?=
 =?us-ascii?Q?VUzUFYEyDAvJC5lpHdn3kIhF43CLzwE70igHI75s2WyEoBXazUnRTnB1V3R3?=
 =?us-ascii?Q?IflN/kmh0h6kHSGWYDbpxAmN37mmZhSBQ+9mHgwU47domvdtLtC9Sk7xV5qn?=
 =?us-ascii?Q?R1yeE6ryhTOCMAaZIoxcQ88x4CGZPnjmVIjAxNA+LGIMaW+l0AiVPHpbKUk2?=
 =?us-ascii?Q?5/HX0rnWbAMhqxX4JjZ8hONOVKMjr9iBRlRrfRcE1qyv0ksURtNHSEuFjXsN?=
 =?us-ascii?Q?o4xogos9IZoxdkZ8hfLygLl3k94YVn47GILOIPXjQ09BajkhUsG0kMzeiLo1?=
 =?us-ascii?Q?aLVsC2J+Qpzt5NDtOGsqWf3DeHuIDbzm+b4PtfynSH2nTWTG3f0u4LhC1fzh?=
 =?us-ascii?Q?RtwpLSWWkUqPxG0xzQQuvX76wqZCSso0hCS5/XGrjj1KDkDE6Rgpo8EvrKJg?=
 =?us-ascii?Q?OKY7dSziEQFjps7m9iRgFXfj4f0e+XVpNSDOsNnzGb9jnydyzOFHIzej+BnC?=
 =?us-ascii?Q?mzJbWiLaCeGzc6uAJTzZyGo5K0y/GHyK0giM3vzOp2azBV63xOcQsH61rAqP?=
 =?us-ascii?Q?6GsWd4Gw9HY/m7JKp9UP8OSR15juCDnvSW8+KN2mv2QS/zIStRBDDGxu0E97?=
 =?us-ascii?Q?zR99HG1tDJy97U2Ajan9Iyu2jXCGTxij9QhqRE7FK+IylM8tbPYBKpUB+SD0?=
 =?us-ascii?Q?Pu6x6RsFlYyQVNp6Ic2RvhrOSk31?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D+MrfG8Db0wd5CccG29vcJY2cYNvo6Gc/PQJWqYceAIGmyRhu8KpdTGYDKM/?=
 =?us-ascii?Q?H0I8n3w03IEmm86OQVtKJSGQFxJLHrMukaTEzjWNk4KhmbdBnaSy41VkZ8nL?=
 =?us-ascii?Q?0nbbC+iTUTq6Tt2odNDwp9PQyxXFqQAUS7+1iTzdC1cwhJbLzlzDxw2f01ii?=
 =?us-ascii?Q?Om+8CEy8e7eMWSwgDS+CeB/GlSs5a5HvqgvFTvb1HiLKkyUwPSsA0Todt3Pv?=
 =?us-ascii?Q?poqkfY+sSQdEBVfHyvvgIt5DPMHgIhbKZL1HJK6QObKOLouYFzfswQsNgnJw?=
 =?us-ascii?Q?Jy4jB0wQBbomKwM5VWI9MCa1EzVerDl6etdhJvaBXMW4Bnk0APdAYEDgbLE6?=
 =?us-ascii?Q?LtV5QejhmUGmOsQfdQJDS6lOQuVSqZPXqlkv2SRlcd+XoZ4qRukoZQCzWXwT?=
 =?us-ascii?Q?4rqgO/VUDzaZOzJch9CbpgCKKaHoHYQG49NH3MKNaEA49NOmMKJgiRiYeJgv?=
 =?us-ascii?Q?Hc6C0e2mwvYnGMM5xQHJh0VDssKuakUtDmFzUjkMcvPq13GRX5+RsRDHXT7x?=
 =?us-ascii?Q?AA1AJyh3th2K55NjERB4NVpzFlJxA3vvZXCGASYzwKg39Ih9n0nQcGDcNKId?=
 =?us-ascii?Q?5zEL8zNhtCqgyfZBrbuc2eUBBT3WDn5X5ios1sQD7spttC1Faesi0vUH31xI?=
 =?us-ascii?Q?ZdFusHIk0FPe9KxRFS24O69U/26CrRngRdPRYfwZTzfCUeGv6tf50bBXc9pp?=
 =?us-ascii?Q?nPj8Dtl8+FE8veYgRILL0z+/icW0xX43v1ooc/jqZgvrUUCYtbeK0cB0QG7j?=
 =?us-ascii?Q?yzh2TEtC2a+bk0Q2ophZivF7fAlSwomhf/Hejw5HZb18LDpUOEoLCod9pCh+?=
 =?us-ascii?Q?JivqK26TWLZ29J1j5xSB67/Z4hOjgc4AtfxLY5a7RlfdOKE0WYFcZd58/lzs?=
 =?us-ascii?Q?kFoYQTGwC+rOYgVrMsQG8pIttmWamHCfe4wGfPa0QRM0OMyZTl1YKt5dbUth?=
 =?us-ascii?Q?jDZMEGH+iI3Y4saeN8+o064RqBbTZsin/d6Vcgytd2nlNdonO9r6SJtXDbE1?=
 =?us-ascii?Q?mRCWkmFQKMmph/c5iSX2KiUs/TpnkJjXqYujj+vhQ9VbJVsOfPqdn9cDua8T?=
 =?us-ascii?Q?u24ABOMRJGq+vIBZ2Kw83VZpZ8l7uI2HBnBewgYSK2uPAJ/0pMRbXf72xp2A?=
 =?us-ascii?Q?YUXqRhz73QUiQM07Yw0VTx5tx8uQGGJR0p+F93FVbSzWtxw+AGp9/ftSj5Lc?=
 =?us-ascii?Q?l+6qzGddsd7tIV+lAF6UUMIh1fmT0o7ouseTCGPZCk6TLF2m1DtCD4Ctz7Zk?=
 =?us-ascii?Q?TbRIwY4gj4uQ/9uUopBc7ooWK9RgKflF8qc6YHRB3uPC6KNefYRI/gAksTL7?=
 =?us-ascii?Q?1Ui2zbIyJlc3qZMpw1//yQuPugYlWdhb54yjM+ZAyWC2w/ix6dgC8VetPnHW?=
 =?us-ascii?Q?hobPAzMvt5uscqIgeiFBGNY4ySQjVYfwB694tvFovZU4jm6Tms4kUIqjTR0H?=
 =?us-ascii?Q?53LxSd3L17CXwk/Ybw6Rf3AeEF+r7q9f4MHHCBY43ndWt1yMMTUZDfsENLLy?=
 =?us-ascii?Q?Qj7uVO/PeAZ3qlGy5R2mWguR3yI/IFIN9dVF+9rQXl/8tUFHWB+ynwMHspyM?=
 =?us-ascii?Q?j+pT1rZ0oQk2AxJqUar0QrpnTjV3QD7BKQyCG6d/PPYi3eziBRZbzQ0EmatO?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ovDKE0GzkWDi+DbBwiBS1Yxjki4j7UaFstOtkQZFipTVCO9Ox8n/f4A7nmIciVm/I9kPQn3qWfvBwX59axKyay7pBhgYW+jK32TzCE+aCpmtu0KcL4l/dLWZ8IKKbfuEWCz8n53WLVC0k/ZnzJI9hWYqQX/KhykTg9TfkEPPuQhTh9jKKn3QjGEU2is3xdJnSDTtPB4gLg4fbcWV/r+hH6lB66sZSxBRhuWfoN7fZwk9zROjuYRq+8qDgTslCtIOkFBINGrZW63I0bIjnMOe644tRdjwCx8rSdr4PqxdR5U+qcRkyKEoGxaQ2QvWEYC6X6EscpVJb6Km/illrT5UJwmHh3/m7zfSdU8qOSmRkivqbdSCjIjdZCaSOGe4yyvrqCwYsLSZjR1LK85bNqsD7kSj6YHV2PFjCwlWc1Q8u8I6WJnzM0AQhso3354OPIExfBrpie3oSusYpMRiZ9KaopyHtUJrUjTYNZ/H9SeZBWYTmdpybx8o2pUH4TUprHSHodc3DxD6jxDO5SNRZCGphfRo72egQrIhiUqHXUhispY6wHg8dQH4ufHRYz94naVJmi01TjzKLy7Pl1K6AKwMHx/g4cI+mVb/1K7/OkKhn24=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530e2997-f502-45f5-04e6-08ddbe35cd4e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 15:40:44.4430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CytRC0+V8FyPJeVM7GB1PE/llBgqOzSlFDPB5WuI+d9BpOZqNTs6UlwmqGEVcGnEV+wd5p0Zo8E+wnHVF+ap+UdUYCJJuIqAGzaDPsChbGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4564
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507080132
X-Proofpoint-ORIG-GUID: 08BFRrWOCzwjgAPUspRGiFAl-HOu3qj1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEzMiBTYWx0ZWRfX6TwZIkTD17zt q82xZqdL8yMLiLcDZPQ4YVpV3nsBPhyrWKp5bj6vZ/rb18gEuEtlqkENKtcA7rswgHKtbFRnj6P 5GVlNfraT/Xkajov0ojrSrIbmRQ+hTzz59jvUjYeriFUwfxWBv4yciHplVe0kiNFIbzIxaHp68n
 Rf9rarizZD+baT1nKU7jtCJzwQnO6b+OFpwBtkesle0lWWOI84ekMLxGs3CTJR6/Q1IZpNfIxKX LglluNVI9NGdyyASDyxPMNSbpift+p1BqgKrBVpNTJcVvbqIDc78TRxqfPHJJb7pqXNmQTsUCzH MPoh4eEJMWtiUARvLpOsz6bMx1PN+Iqd4srDvRFxNAD0pK2CnZ38Jx1ZM9fdeXGCBTPZjgcuR2e
 HYI/ryXcMzyo/CZYeFtX2o7QDihDJzqnSEDZq9tRal7H9SSKT7y8AuhmeGzNPz7HKW9tA1hf
X-Proofpoint-GUID: 08BFRrWOCzwjgAPUspRGiFAl-HOu3qj1
X-Authority-Analysis: v=2.4 cv=aMvwqa9m c=1 sm=1 tr=0 ts=686d3c00 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=sBcvgdA3ldTV9jqk8kAA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12057

On Tue, Jul 08, 2025 at 05:11:28PM +0200, Danilo Krummrich wrote:
> On Tue Jul 8, 2025 at 4:39 PM CEST, Lorenzo Stoakes wrote:
> > On Tue, Jul 08, 2025 at 04:16:48PM +0200, Danilo Krummrich wrote:
> >> (Please also see the explanation in [1].)
> >>
> >> There's a thin abstraction layer for allocators in Rust, represented by the
> >> kernel's Allocator trait [2] (which has a few differences to the Allocator trait in
> >> upstream Rust, which, for instance, can't deal with GFP flags).
> >>
> >> This allocator trait is implemented by three backends, one for each of
> >> krealloc(), vrealloc() and kvrealloc() [3].
> >>
> >> Otherwise, the alloc module implements Rust's core allocation primitives Box and
> >> Vec, which each of them have a type alias for allocator backends. For instance,
> >> there is KBox, VBox and KVBox [4].
> >>
> >> This was also mentioned in the mm rework in [5] and in the subsequent patch
> >> series reworking the Rust allocator module [6].
> >>
> >> Before [6], the Rust allocator module only covered the kmalloc allocator (i.e.
> >> krealloc()) and was maintained under the "RUST" entry.
> >>
> >> Since [6], this is maintained under the "RUST [ALLOC]" entry by me.
> >>
> >> Given that, there is a clear and documented responsibility, which also Andrew is
> >> aware of.
> >>
> >> To me the current setup looks reasonable, but feel free to take a look at the
> >> code and its relationship to mm and Rust core infrastructure and let me know
> >> what you think -- I'm happy to discuss other proposals.
> >
> > Thanks for the explanation.
> >
> > To me this is clearly mm rust code. This is an abstraction over mm bits to
> > provide slab or vmalloc allocations for rust bits.
> >
> > To be clear - I'm not suggesting anything dramatic here, nor in any way
> > suggesting you ought not maintain this (apologies if this wasn't clear :)
> >
> > It's really a couple points:
> >
> > 1. Purely pragmatically - how can we make sure relevant people are pinged?
>
> I'm very happy to add more reviewers to the RUST [ALLOC] entry for this purpose.

Thanks!

>
> Can you please send a patch for this?

Ack will do.

>
> > 2. Having clarity on what does/does not constitute 'MEMORY MANAGEMENT - RUST'
> >    (again, perhaps Alice best placed to give some input here from her point of
> >    view).
>
> In the end that's a question of definition.
>
> The reason RUST [ALLOC] is a thing is because it is very closely related to Rust
> core infrastructure with only a thin backend using {k,v}realloc().
>
> Compared to other abstractions, the main purpose is not to expose a Rust
> interface for an existing kernel specific API, but rather implement a very Rust
> specific concept while being a user of an existing kernel C API.

Right sure. this stuff gets blurry...

>
> > We could solve 1 very simply by just using the fact we can have files in
> > multiple sections in MAINTAINERS.
>
> Please not -- I don't want to have files in multiple entries in MAINTAINERS,
> especially when there are different maintainers and different trees. I prefer
> clear responsibility.

Ack :) No probs.

>
> > Doing a scripts/get_maintainers.pl invocation will very clearly tell you
> > who's in charge of what so there'd be no lack of clarity on this.
>
> How's that when a file is in multiple entries?

Well you can see which is directly related which not. But I get this is not what
you want! :)

>
> > It's a bit messy, obviously. But it'd solve the issue of mm people not
> > getting notified when things change.
> >
> > However, at this stage you might want to just limit this to people who have
> > _opted in_ to look at mm/rust stuff. In which case then it'd make sense to
> > add only to the "MEMORY MANAGEMENT - RUST" section (but here we need to
> > address point 2 obviously).
> >
> > Alternatively we could just add reviewers to the rust alloc bit.
>
> Yeah, let's do that instead please.

Sure.

>
> >>
> >> [1] https://lore.kernel.org/all/aG0HJte0Xw55z_y4@pollux/
> >> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/rust/kernel/alloc.rs#n139
> >> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/rust/kernel/alloc/allocator.rs#n130
> >> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/rust/kernel/alloc/kbox.rs
> >> [5] https://lore.kernel.org/all/20240722163111.4766-1-dakr@kernel.org/
> >> [6] https://lore.kernel.org/all/20241004154149.93856-1-dakr@kernel.org/
> >
> >
> > I feel it's really important to not separate rust _too much_ from the
> > subsystems it utilises - if we intend to have rust be used more and more
> > and integrated further in the kernel (something I'd like to see, more so
> > when I learn it :P) - the only practical way forward is for the rust stuff
> > to be considered a first class citizen and managed hand-in-glove with the
> > not-rust stuff.
>
> You're preaching to the choir with this on my end. I'm recommending subsystems
> that receive the first Rust bits to get involved in one or the other way all
> the time. And if it's only by reading along. :)

:)))

Yes well I like to think we in mm are forward thinking about this!

In the end rust is here to stay and it's important to embrace it and find the
best means of collaborating!

Cheers, Lorenzo

