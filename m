Return-Path: <linux-kernel+bounces-774259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A90B2B083
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C69F4E3DE5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8512236E3;
	Mon, 18 Aug 2025 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K11roxEX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7063E194A60
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542024; cv=fail; b=mqjv7XDjuwnX4ldbD3Z4xBjQ1GBU0iH2ONphoNbsUly58yijEVl5Su+yuUGcKjXmtvkz27MXGXXaI30L5xjVy+4zYVPZ4gCt/ynqP5E2+AIRm6PlFmIKjL8e8Gy+/x81peBAwIarUkK9yRUjkKWX5NtTZRnObPgc8n5Sg+skSHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542024; c=relaxed/simple;
	bh=HrmPmOoIfEriYsMT6cXdTNxiZbGZITb1hOKqjBkayXo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o1iF4DLq3JfmlvoNnvB6/Ifyu9q0O/w44nyJyuTWHXEncv/Sg5hG6TgZDE1qJJ0e1crdT/1snRM6kN9SR/cGXfS3+/BO/+5ga4r9JHFYLI9fjiIiR5Roe7gorIJSiU9HF7N7Hj8LxCOxPYNEHKppsqw6i0Hjvwu9lmV4KGa8SUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K11roxEX; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755542023; x=1787078023;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HrmPmOoIfEriYsMT6cXdTNxiZbGZITb1hOKqjBkayXo=;
  b=K11roxEXy9ax2r49uiMBm89Y3sJV+TeIZdupiTKOM+jtFv2rVqsXWC34
   DAJ/espMKKIJDgLLAS2WI3Nrm93w0c8T7mZpCRdebNNyhF85fGTSaxfv5
   7xoOZ5DtDRs+KsRNgTQRhMSrzv9mp4XJ8epI8HPq56uto7g4ka5TD1os4
   uWznylnjjUxTQPWtuHsuXUqEawFPGKxIhpaRU/vosz7R7+WWZCrOFT88Q
   KoO7DTesObDThGYiQjAp06mB9HObYqeJ8Z/o4LP+oUeEjrTNeMPrIUD5V
   e4TOk1MgKPewgLk1vFBMDFgO6sA/3KrqNK83oznOACpmogDFwTXAD8hxu
   g==;
X-CSE-ConnectionGUID: P69BOJfHTYKb4hlfQiVUrQ==
X-CSE-MsgGUID: wFhw+sIKT4S00jC2CWGLaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57486797"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="57486797"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 11:33:42 -0700
X-CSE-ConnectionGUID: y4x5MCueQkmCS5X149unwg==
X-CSE-MsgGUID: scg0M8UUQcOsH/boFQf3vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="167149178"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 11:33:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 11:33:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 11:33:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.69)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 11:33:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQFIWqds7E1Tb9lie8fYB4WnovN30cm3NzwR4JzGZhrEKJsS9lPctOX7EB2uMCrlE0cI8DpIq+UFLqwnx3AK/jGRCUs2YqzBuXMC0oSb3d1RsZRLL+FGdpbwf66jCQpOnK3ull7C94f5iAtem43z4+Nu3y7h/6rN8pCCAJyGLC3qeOnh0EyILeZZ09qdWFbMSxVqIPn4U207MML44QorJOu8GfE5T6gq/CukCmavn+98DsC9qOiU7J1+ZwHYGuRTVWGpU0dh/5rW83/CYOvyWvPPpn/8169T/GIxrmzMKyyPZnputU/P0cAsVmKIgzd+YCVtDa5iui4ulw+41pWT7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f53QOQfXWInvCRUAbHD6MVkCXFC//q2D5Iyp6q5mwGs=;
 b=y9srfTceLG9I6Qmos2s21Xk/2jarSpaiEhVwPwCpsoJdXHuHStgTK1R/LUrCF/dUxf0/Q2bgKvKOn5EG1bMWKUeM3KbRPnk1ZhqY6TlftKVYjvQ9xjbv2v3JWI/ZaUVGLhIruOMDzc3YQ7VoI9J0pY74E1ajI/8YQrmGjg2gfjF+WlqqAs8sXZIR6jE1pU0gJsWo+pt+vSXTpBXfPmHwANmi0hh/lvWJnOdH8Hm9VGJJNanfqn83PDHCY4AjWIdPCMtxJ6R/0cB0/K+mg9VEp+33mHLXv2gE20yUL8HShNegcZ/jCuwVzMqLyTcC39GEBDFh5Mo13JH+MX44RzModA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB5128.namprd11.prod.outlook.com (2603:10b6:510:39::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 18:33:37 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 18:33:37 +0000
Date: Mon, 18 Aug 2025 11:33:33 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
CC: <saeedm@nvidia.com>, <itayavr@nvidia.com>, <dave.jiang@intel.com>,
	<jgg@ziepe.ca>, <Jonathan.Cameron@huawei.com>, <Markus.Elfring@web.de>,
	<linux-kernel@vger.kernel.org>, <akhileshpatilvnit@gmail.com>,
	<skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] fwctl: mlx5: fix memory alloc/free in mlx5ctl_fw_rpc()
Message-ID: <aKNx_YW2jzWz2nLq@aschofie-mobl2.lan>
References: <aJjiRqLx9TEg2NFj@bhairav-test.ee.iitb.ac.in>
 <aKAjCoF9cT3VEbSE@bhairav-test.ee.iitb.ac.in>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aKAjCoF9cT3VEbSE@bhairav-test.ee.iitb.ac.in>
X-ClientProxiedBy: BYAPR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::32) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f630dd-4caa-4e6e-afad-08ddde85bea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ovHfs95x25rt/U/tAPT3T8MWsuT5sfm2XB+TBtyytSkzIfhzsYPjXirZuXsj?=
 =?us-ascii?Q?z8q13Zlbxc87cHzjmzeTW5JsG0/hDCKgQ0taUR6N0FPza2uNw/CZIY5A4e7X?=
 =?us-ascii?Q?arNTsv36opx39QpucCf6k7H0sFjylms+0iS1tMm9IRCY7vrNjUjmKSni9/xY?=
 =?us-ascii?Q?QN0tDu3Si7sJQVL1Owpu3tPseKioRsHuj7yb8boxceXb5wBPEn5nUBFgYj3Y?=
 =?us-ascii?Q?8tSRMRwwxY3I5cyeasFwOECvRi4TV4YmC6v3BWklPoPqaN7QTCu8ZR0kjY/z?=
 =?us-ascii?Q?TJyNSnvBMRLgna+IOotrusXzp+YjZ+oKqoD0xXglLbZxG6nT4kNVgBS79p3Z?=
 =?us-ascii?Q?UXQhas2h3u+ELgC/3gK4TSz+sLLwjA90YUbAvUzjaOMKGvLqB41eJf+MckcL?=
 =?us-ascii?Q?xIDk/cRwXV5pE4qVw1uR9UnQZ30ZtxnQEbIEzz6go5fuRdt+Mrg8TswLfMOU?=
 =?us-ascii?Q?HSF22bo/tlaYaai3s08AhVKcT3+jo5pkH225K6Kx5u2c+cn9vt1TUZWVpyT5?=
 =?us-ascii?Q?TNRw6ee7bPNrxCAviLNKSbMF43rWIvlPDSfU3t9pvba/+j6fHAt4aSnng232?=
 =?us-ascii?Q?kb0roNirnjv6HcaCnuz2ka2Uu85ex8pzaWEs5jFJnzMbgLncayoKfarB09zy?=
 =?us-ascii?Q?p4InfssWBvUB1X1ZQZdEOWQnwgeWMftmCIhIuyFCpeKKjgs1Pv+jZKAhr8aF?=
 =?us-ascii?Q?nu5ZwHwDSM6Q3eaMgakX8c665/hmEfooLqQZEOhRQI7sxaeqJFQ+AHH6X0TB?=
 =?us-ascii?Q?X1PrQGAKYXLVg94hJD8tsVjiYMTm5ovcAvc+abCDssPK8PnDQFcFgK48Ezs6?=
 =?us-ascii?Q?kfVwAOIOQXqbkmXOMcTwnpQw76nMKElYRnR8f7TAA67u1ysSxg4I33qDJy28?=
 =?us-ascii?Q?79n6aa6C7WRe8ZbtOO7qLobiRRZpT5AKpr1Y7m0e/5zJEDmvnJgYnTctsZgS?=
 =?us-ascii?Q?IECsjxfMGOXGRuHVKTcIjh4HhUCLkPcU5DEfTtWSvGvvg6g1cJ58mFS9yhuk?=
 =?us-ascii?Q?rQ8yTWyfVifqkKMJTGLCj6GrmhpYH7EsiXRE7JsqCyHWFLV90b5I/jvyEKK6?=
 =?us-ascii?Q?CT7eZHJjb42hB9GIwaWxVYxcSTBK4iwmzEq/tj0wVBiaz0Hmwu0cgzc2OQ4U?=
 =?us-ascii?Q?o+uRBSsuVP/i3BAd1RfZdjw8H9D1LJzZhRwTF36TspZM2ue0CsHLQWi4nhAg?=
 =?us-ascii?Q?RqVqITN0V6/BSNE5Gk10qNT4Ak0mXZOj6J9FVponBsP5bcA1Q0I6BPlnALNn?=
 =?us-ascii?Q?AImT49NOW/oq+oEFm8D2C4XaXcn7xmk7MtR8sB+hFFONdaFAenPInUnx14EZ?=
 =?us-ascii?Q?MLBqUc2Xb0r1i2Ny3Wqr2ya9HNTE42yHv4YJW3v8ou/CpXdots5S3NMBIJZU?=
 =?us-ascii?Q?AtNHuV21lGj60dJYq6tIKBo3UzAbaFlEW8SRcO+iIhbr6zxxNZRFbvS3Equ4?=
 =?us-ascii?Q?AVKWumMBceM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zsZGn1yE+ChwSl7QXxV0pSQjaOFApH5A2xfA0vcGLi++qf7JYZkqg1CnKBOn?=
 =?us-ascii?Q?2zIY6NBjtdWKEj+O+A2l6OZaVBhnNqzKrhgT9TeprWVsAsCWsddGcXkJ30oe?=
 =?us-ascii?Q?MSvtYEhST1JJi8M1DUJA3YIpASZMeLI2qv732fMdqClDL/daPSTUcHAantdQ?=
 =?us-ascii?Q?jOjDv1uLr0ayGYneARc+9eLd8048FcwDCYw3v6E+2h9bXqelmvk/YEqnuQuC?=
 =?us-ascii?Q?J7M2Bewt3XD8+biLTagKoJ2Dfw7JMX05LGKBaUg97e1yQpCPMLa37Q95/ekH?=
 =?us-ascii?Q?av4GbA5+Db0wM7gf7WaAj3I/Vr/GLLgq1TOMz2E+8C/0Xi7yF+bM8MCUPnS1?=
 =?us-ascii?Q?pdQB2mXvLxrNchVprKzuAT4CGvfsY8gcwzhyrVeKCLWXAYDnol4r+EZbaf66?=
 =?us-ascii?Q?JuYu6G9g1U0qGgI2Hq1ilKE2rFjfqqjcIM5aS82x8M6K3jj2Vf8/fG50Ahf3?=
 =?us-ascii?Q?tjvoI2QBH1IKNPEROShesZCxAlItHlV8g7rqx3+THQervNlwt5TJ/ToxQ5iq?=
 =?us-ascii?Q?rUaAgATx7UYuCgN38f3n5clj1x45HZWTZ/+sjrSg0n/U6/BU2+V/SEmnqDOO?=
 =?us-ascii?Q?rZ/6A23G+NwIrJiMAx31nfxiJv9nClHnhjTpPr6s/8THQpLj0qneaId9sPbf?=
 =?us-ascii?Q?QQm1bmUT+nOHU5ZmVHoRM6OyqWEf8fb60y62sSp0jYAiTjpxFp1zyUjOh7Yo?=
 =?us-ascii?Q?n2KPnGLh9WPhjmvlCdSZ+fK8VUQcTQ0eaFF33OpGWk/LqtB12ecP7i8CSuqa?=
 =?us-ascii?Q?qk1JerQ+UVjNHgUMFcpsV5/e5YqADLN0iHXEqYY2/Zih3TwNbQetyX5/tmXA?=
 =?us-ascii?Q?1D358WsWN58I98KjX+5ZwCENDZNStTVNw7kPwaDXxkFOb7wQ8bUEwZT1zTrY?=
 =?us-ascii?Q?S893EFd0V27181I3TYxFtu9KZIs8J503sRThdCk0pvsCCbBicrUjVLdLZSEg?=
 =?us-ascii?Q?vH2Z5wiibZf3f9dOQCwjip+4vKrBHZJsoSBR/eYbDnZyPwxXFqtYYrEtS5SI?=
 =?us-ascii?Q?HJ6LoIScsjWlA91MMmSIJdc+Eb1Mr6ezH4/LC5HnE9Xiv3YJ5syi8AsJPx6Q?=
 =?us-ascii?Q?nQsE/C4LyalwwLFomBYHCu8ZNOoS6QBLMCgTULmsOVAgJApRzcM3iQL6FT/c?=
 =?us-ascii?Q?AXc9sucDgnTM+zkhVxlOT3LpJGFwcJzkUzbirXNnLspY+kpbj3UCT2VUKUn2?=
 =?us-ascii?Q?zHsqzD+FfvzBuMcStQpccmORaFfT5OBJU+pWad8pr68Tp8RcVksMngMblDnX?=
 =?us-ascii?Q?Ec6Wm9zzSz4Zbm6A7kDWsBywFbiFcOALArwoCeOnMiG0qwyPlbH9EWHYAN9D?=
 =?us-ascii?Q?Tr2gooYf+nnRXZ7QDLpwrakBah6Aa3NSbMYCxQ61Fe+w8tahLVcP0rdiQ5A5?=
 =?us-ascii?Q?lV1w5GSWjrAG3wK1BHOEU6fG3gsgv139nrz0FWInTHNIPQD/62oie9vvhdUt?=
 =?us-ascii?Q?D4KS6gowDOcdVNtTyCjcEH9XG2thw3IJHwuS3EUiTKdavXyLmSH7UpCVpxp3?=
 =?us-ascii?Q?xQgzfCf6im+fDtgQiJ3RdXcrpUF86oT7IVYZFMvbFnCrpWlPEMVTR8XpF28Q?=
 =?us-ascii?Q?qqq8yB3boV3Hn9A0B30RhL8zrG5nA+NiuTLEi5ih3gdY+9h7xhtX5+5Mj6QW?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f630dd-4caa-4e6e-afad-08ddde85bea7
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 18:33:36.9656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAKxmbbzTa/AayvvmL52wVGZ3ia8NEeX1sPQQzg5pxkEJ5yA2nBmJjRPQSklWekaiZGhSRsHWne04csAZH+uHWRBAtjIfnKKeLgBk2b+Ghc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5128
X-OriginatorOrg: intel.com

On Sat, Aug 16, 2025 at 11:49:54AM +0530, Akhilesh Patil wrote:
> Use kvfree() to free memory allocated by kvzalloc() instead of kfree().
> Avoid potential memory management issue considering kvzalloc() can
> internally choose to use either kmalloc() or vmalloc() based on memory
> request and current system memory state. Hence, use more appropriate
> kvfree() which automatically determines correct free method to avoid
> potential hard to debug memory issues.
> Fix this issue discovered by running spatch static analysis tool using
> coccinelle script - scripts/coccinelle/api/kfree_mismatch.cocci
> 
> Fixes: 52929c2142041 ("fwctl/mlx5: Support for communicating with mlx5 fw")
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> changes v1 -> v2:
> - Update commit message with details on why this issue needs to be fixed
>   as suggested by Alison <alison.schofield@intel.com>
> - Update commit message with details on how this issue was discovered
>   using coccinelle scripts as suggested by Markus <Markus.Elfring@web.de>
> - Carry forward Reviewd-by tag from Dave Jiang <dave.jiang@intel.com>


Reviewed-by: Alison Schofield  <alison.schofield@intel.com>

