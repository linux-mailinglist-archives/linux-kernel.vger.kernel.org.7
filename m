Return-Path: <linux-kernel+bounces-807405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B85AB4A40E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 930721B237A1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E8030BB8F;
	Tue,  9 Sep 2025 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YLXK62ut"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012061.outbound.protection.outlook.com [52.101.66.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A542330B51F;
	Tue,  9 Sep 2025 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403534; cv=fail; b=b6yiGiRISIcVTwzqp1uxXAPuVpCduOABNc34AGA+ASNQM0/m8zKrpDxPCNbd/SsRQ5aCurB8XqJrZ5rILrGQJoGGZ67wVSHX5Zp2TsYH5xdgf7fFcc7e+u9usyd/IBUjuvHg9zxHU2uoAxREjVpQ5Zuf10zKaETI1uN34pitrU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403534; c=relaxed/simple;
	bh=xsM5G+b7O58Cz/r3dK5V590UhBjLIBTXQk+mPvQDiL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gmW2+TivUZYSNSasN2tLOOPaFRoBVE629ysRBpbA8uf522yussNVXZxAAHJ+ZOqs9PREBwT2EwplfGbjI5PJ6VnCe1V/pW+gWRz/7Ik3NlSPwOtZm344jSO9rBOwqaAnbTLCEVdj9VHHmRocpgRD14t9bA0rSs6HNJdYun0gUFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YLXK62ut; arc=fail smtp.client-ip=52.101.66.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ba1WZHECMJF/wbBEmvfQsE9itiCPkg1afhvohYW70O0Dp2JGoaEgxgRu6VYwb9SdvoHQE2VbtDFqGnMx0NksU99M0Bp78FDCTciKocI2ZGeVx/yq9o3EbRDRcjP+nR/+IFN+OYxZqtBsPlAvc4mCRLYGW1MTYPN77kqXmMtSZdFLXE14ZXZBYIplxq1dfdaS687vZ6IVbuT1T5tcXNk+cgPxoZFQXRixQB9JqLdSURUqOo5Gh9qxCbCF2z61zQu1YLP7vegWcFeAKjzRfHhOc5oc64B1ivzA3Sl5JF5PemrvIQmwl8Ez2pZITC6cWl0ZOJw0Qd3Z1mND9RrV4bVNrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vh70u+5tQAg0kZyoexPpFEtXVM6giXrn22xcCRccjQ=;
 b=MdcSYHeG9rktu5KyhmQCOV914JxGdMQhzniewLydQ+1Q95d7sSsm2+yYOR/F1aGCmlMhvyUiohS3ZbnvxEubRqb1P+jYBmHXZWl98N2muF3drnSCQCgKnNdpxW3lPVRoNfWgi7u4hzlLpjPg5kp1FasquhNGJrwqzRRPgAr6E2S59nggVSojqlsYIBsRMLugGiH8athe8/wGHg31MLULK0PGKRm2yUeuJ80smJwajQrFRkvy5XSDAfhOnnYV4fXNj6yqCM1PytoAehN58hLEb3CkmSvz+Q4q74FJGkrh8F8+8SDcv3rSo/x7lJfV7WTjYGBjDt3uWwF0RJnlQunEnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vh70u+5tQAg0kZyoexPpFEtXVM6giXrn22xcCRccjQ=;
 b=YLXK62ut9BsX5C3L4ru2IJ/+qMPm1B/O6HSASnkfCivWWDyqwhGu/mJzp68b9xpwet/nffgaqYjrzGGBQaYO7wDHoLngnpqwlBNmxLkw52kGRtfK713zisDLTiwA1wD6rk30xRG06Kvujx8mq1XCfa581k1S0hP51zql0h+oqf4wFpw+u6jDcvs9/nz0KLPWqI7hsptatFIROVpwqua6avH9GyUGs5BVVPLAvrbqOdUdjFdopUBQONr265MjB5eztG51+mpuuS7ZcJueMScOKk0wzhs+hN7CNYu8n3fgAlg9ajm7i5Qz9Ny4vXBQOPUPoT+ZvZFBIDLLPjYVzbeQXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by FRWPR04MB11174.eurprd04.prod.outlook.com (2603:10a6:d10:172::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Tue, 9 Sep
 2025 07:38:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 07:38:48 +0000
Date: Tue, 9 Sep 2025 16:50:13 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Brian Masney <bmasney@redhat.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] clk: conf: Support assigned-clock-sscs
Message-ID: <20250909085013.GA26483@nxa18884-linux.ap.freescale.net>
References: <20250901-clk-ssc-version1-v2-0-1d0a486dffe6@nxp.com>
 <20250901-clk-ssc-version1-v2-2-1d0a486dffe6@nxp.com>
 <aLdmXcdJnoeXEJaQ@x1>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLdmXcdJnoeXEJaQ@x1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|FRWPR04MB11174:EE_
X-MS-Office365-Filtering-Correlation-Id: 9665d623-cf20-4429-c551-08ddef73e9be
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BJY9T3X/mOgJNnhfhbf+8UJYPP6H3g06bEEWZ/lWOI5XNplWcTe7TTQwda/4?=
 =?us-ascii?Q?4fUfez/hif3P97bgiBWZUsni6IR7i1xXFdxIVgtKh+tDgd61LpqqmbbOiw6r?=
 =?us-ascii?Q?bAteIjhTlKbDeAesRlexSQF2QjKjy6VzASfA/KnF3sJY7HTqotPe8husQfZm?=
 =?us-ascii?Q?bAyKyKNW0eqsIvaUXPAXPqrXDDtYvaaKyURpBk7mDdKJHD3Rx3z/8nQqvjV1?=
 =?us-ascii?Q?j47dkLz+FGnhSJoVc6d0WdXl/N2e5jcDCXLSV85NCufLNLZ9iiwXNfl0qWkr?=
 =?us-ascii?Q?X0/RXBH6qjAd58z8qDV5WCS5LS+hHLyq4fbeOW8F7/0ay07DxvAN18tMKK7b?=
 =?us-ascii?Q?G6dFQxFFGGVuKYZhdVpuxur7Hu4VhOkenvOSpPsKS86391kwr20bzz81R64m?=
 =?us-ascii?Q?QeWEb6/YTQ8qzazmYI63IG6G4kQquFNiDUUq12TohaQ03e4c+fauZpyMRRgi?=
 =?us-ascii?Q?j7Clax8N+F4Dah+z+UTn3s8HKhpNeL9YbVyASnf+TCtjNJemZsIl7YlL3pl4?=
 =?us-ascii?Q?B7TzXPgWbwcmNp8OzDnEteZVbsPUKVNJhv0fE/8IcxK+SSTwA3/sQPtVFDET?=
 =?us-ascii?Q?7oD0BtfI6CHHfeMPqXFpqxoJh38N0nAsGFC7VooAPe2Yst2r/NJlUlmvUHL5?=
 =?us-ascii?Q?mrPDOXsWIkKxCpvvOJ6d6klkAaaEgW7/zmAsY6+8bXjh2E+wxROYELo45q6c?=
 =?us-ascii?Q?5ySkqKuuo4hgbIlRwSPiCkAnluD0hJ6GkSJlVgdXRtkDrNIJxIDXI6DZzQB6?=
 =?us-ascii?Q?6HsjO3YYG4PFqpY1w8MkmYa2+YTip5y37U0pyvjQypzQF5YJyp0+z7OzWWae?=
 =?us-ascii?Q?2BgS2fP0iI7vH5KGJB7vexJQMx4NBmx+TMM5xNr5xKUoQ4DY/bm8+6BspnZV?=
 =?us-ascii?Q?GpdjYlcSK5YZOOxNYRl/1SNpp2QTTnxwbuakcVgtTDa3/+FA/ZDX1Bva12zG?=
 =?us-ascii?Q?w6kzyY7pyaElEFv3H0sPbvWPQIzbsUO2HAB7ofia4Q1I+cJKsOPN78uk+8qJ?=
 =?us-ascii?Q?lbgZ7uTNWnMuBSNzvFRRR7DMRP/HEcdU0uAXeNYiiTyajA1Q5MzmVk1SVpRo?=
 =?us-ascii?Q?N6H0MRY6pFHS7CclVjm3kF5WIEoryUaAZ8bCOxVBK2J9fwtKx8H4JFJYayNB?=
 =?us-ascii?Q?vDfV/hSZmyvLGTKW2lJ2FGlyT/6sZy5a3dclSAbBZ6mrav3rMR7o51CdnNzc?=
 =?us-ascii?Q?YrYQ9V7AgDKUQ8Rm2A26IJ59gaBqAXKZt/V1n2GaKkkIH0MIGXiHwIG9Z4e+?=
 =?us-ascii?Q?K8Ie7RoMm7EBekXvEQF7Rd+/tuie6yu8hyQaFARvEiLt0bfNaYp3ydbC808/?=
 =?us-ascii?Q?kdHcue7TLVnr2NLk153c1+mx8aM9XHxr4uNxMrAv7xrJ/SBj0L+7CROnpA6y?=
 =?us-ascii?Q?r484EbhhdBocPBo1b1Lkyo36Sbb2xrl0kxhNG/doAaGHIbs5PUtjgRlcGe5q?=
 =?us-ascii?Q?de7y569N5TKbEeVQ/7xlvNJni69LL89gpWbY8jc2AaFEOxBk9gblBYho+pkQ?=
 =?us-ascii?Q?colITlSobibOBnY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9o6M5fIpLQ4a/KOLOrXYdI7UwsGPvBlIWrLZQYrtkAP6hSSnnyH5ev/V5G4F?=
 =?us-ascii?Q?mLGxsLFe5W4ggTFFch17CnLf8clY0D5wPsMqOB8Hz5veKNh8gozGdvzoemSx?=
 =?us-ascii?Q?CFqogXsmSRrmqPZzSInVJNvFvB3Upkwn3jZW5MygI3KuxmXp/DjvOAEGWUZd?=
 =?us-ascii?Q?zZRYXST84Qk13zWjMnfemKkN9bSBfTfsc+Kk1CFMmX0l7idUHZpsjPAyePCR?=
 =?us-ascii?Q?cRHeBfPv0clkShIXmTScatzt3cmKEQKu8FjujIxf0HTyv3bBHYjkUpzYlBrR?=
 =?us-ascii?Q?VxdaXbs3MrnaUnSwDzFHl2QODf7ZlFzpEzXl2AflRhpWsCjQzkdpTyK1pSP8?=
 =?us-ascii?Q?hUASQegNoMT2IHb81ujuvT/e5zAhlWsBuDCCo9Kcp11v33CgAXp4PGOD4Gta?=
 =?us-ascii?Q?DyNnLvg82b4HbICojRZTl2rWZyrZjrF8SFLt7DuvjSP8hVTH2x9fG6t3Eyu3?=
 =?us-ascii?Q?4mwJ53NviWwoh6MBCHvN70znjE7Gb5QabcvY0sGHUX7lmMxN6QK1WgdMjVsS?=
 =?us-ascii?Q?YjO2WNUxN05SabOGm4pJ/tSVa5s9dy4/xrC+mCziUmdTPrzEzd4Qb1K5hTji?=
 =?us-ascii?Q?svBwy5sxuiisI4JVtjmtbKAXyVYJRR5ibeGte48oIXeiTvA2+9rdajCLv3fg?=
 =?us-ascii?Q?8FeAlBa720gZo36DRUm043CTh28smfWjwm4nS3umxBbDo7ALqTIED9NAO7gB?=
 =?us-ascii?Q?FJBegDWGBFKF1yeTSeZ1ujW/HCoGxcph5pEG2yn2McA6MGeXscepMkQIzZ0X?=
 =?us-ascii?Q?UCLIxRAdeIYPL8v9lKR4nLL4kPeLOucszi09U8inH1WFeBJKX4vgBX+KIjQb?=
 =?us-ascii?Q?tBjSv7muAGSO5QdYGdkv3eN8fu3PrZ2PCwxLjMz9sFn9tU0vJ50WKccYXGxW?=
 =?us-ascii?Q?Fr2G+MMSqssXVvlcb7BTfvgFhZubYH8hHstcuurlq7wlWe1zZM1zVf1xeiPC?=
 =?us-ascii?Q?4Umvqid9zzxZcNrGNlwQ2Xe+CFen+B3j8bIx4WU1d6lzMo0p8mXG5WmwIVUw?=
 =?us-ascii?Q?mOTGsRKmFSfS0aNHz9rEJdj6x6w9dFE+cTQyNjpBTo1vO3deOebo0iC/PW5T?=
 =?us-ascii?Q?JPGNn17Nihnzj8spt+LcBGLa/6me//BnKdhia+1ealUM/oKa8p/9cPRyizcb?=
 =?us-ascii?Q?q48OVaMT7XE5UF6noEIinZ2NXxg3ynsUa3WJse357BWAjP9Pd3DFq+ZwrgH8?=
 =?us-ascii?Q?p/Sn6tAbf3CoH9OMsQY4/TYzfyqlWSePoNVBeRrq9F1o+mliMm6m7YpGtKcB?=
 =?us-ascii?Q?DK9ExDx4b8CyEyhIPSdT5LzlYXU9ZeSm87j4vFW/vdrV1EDGgaovyGGV4Zcf?=
 =?us-ascii?Q?fLAmVid5kQ4Z849+6frqmDx6vDkPiUXbjiWiHMZetN2aqXFVipzFKNkqC3ap?=
 =?us-ascii?Q?sg79/I8O/MXUSPoEGmNPRZ/QvEf/cmGbSWdgeucJnMgEY9qktUOCPGn9QAyN?=
 =?us-ascii?Q?66P5fHyQ639uoXgx/BMz1dlQcVl7COXApL7gxvCM3NF/kOmQHcRZa5qdlIT5?=
 =?us-ascii?Q?TP7zjjMSksICJWXsMfPB2/FjJkneXwOqw0Pk+iby2Oc1iVmLCyO669QIXaKI?=
 =?us-ascii?Q?AT8Iml9ZnLUECW6nXcPLZYRGrpekWYB05qY3AEIQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9665d623-cf20-4429-c551-08ddef73e9be
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 07:38:48.1176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8oZVnISvRwx+sawGcip3HmaY/Hgu9FT8L6SbMeX1FUqzP98pa6kggQeUC1aglXLKVpMOJbMnMlCSdsaL4as8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11174

Hi Brian,
On Tue, Sep 02, 2025 at 05:49:17PM -0400, Brian Masney wrote:
[...]
>> +		if (IS_ERR(clk)) {
>> +			if (PTR_ERR(clk) != -EPROBE_DEFER)
>> +				pr_warn("clk: couldn't get clock %d for %pOF\n",
>> +					index, node);
>> +			return PTR_ERR(clk);
>
>This chunk can be replaced with dev_warn_probe(). Sorry I missed that in
>v1. Otherwise the rest looks good to me. With that fixed:

dev_warn_probe() could not be used here. There is no 'device' pointer
here.

I take __set_clk_parents() as example here, so use pr_warn().

>
>Reviewed-by: Brian Masney <bmasney@redhat.com>

Could I still keep this tag with keeping pr_warn()?

Thanks,
Peng
>

