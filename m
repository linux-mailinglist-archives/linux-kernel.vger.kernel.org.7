Return-Path: <linux-kernel+bounces-774619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D54B2B51A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F6D74E4D93
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780A227A931;
	Mon, 18 Aug 2025 23:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tvEYtR27"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6501EB5B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755561337; cv=fail; b=izLTvt3s8RnCPSL4Mrn6mszzPPevoB5c3f5pRnK/xUkwXv+h0ThPdvdH6WajwqKI++nT8JT4e9TRNLFpJdMajS0rwCYyilBXtCbc2gDdd3ZFWdc8l5uSUPXCHpozAO9x00WnGAADcdCFWrbXq5ETrgwo/qdaQSRhRUPP12akRj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755561337; c=relaxed/simple;
	bh=AFF5W1Wv9d4Gts8JGDpZVGAH1cacwFj6CqqzLSigD8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dV4mia+lmR3NIEYAVN0ZslX53lCVBxRhhAd6bSEePPxAnSlNP1BYk+Fnkeq5yu6+D6X6jt5vDjF1S7oUD/5zlODQHPYMM+2fRXn5YVzED/+b1t0e9hxnKj3DrrRR6WsUsNDUJ0QgwKJmfMntb7FQonNX8RAuh2LO/6gou0E9/rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tvEYtR27; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHumC661mCXlNSccfZTuR7nWK+589H5g4EtQUhXsEslFu1Rd/kmfGrfqFM4YhHICwI5CijrBw1YVxAdGCKi0KTlEkB2gfaY+T41eZVqn611u9wA+sfi6WX8mf8Ao6R270avd9x8hXLKdOe/tqEVwgVXPZZe+RaqLxpdZLW3HOcNBR33bFNcrN0n0JNItFPYTYgik2qFTVAE2ZS1xqM+LfVoLuivPRyCRxeQp3tYDfPjSeYlBIwhp23bH45AWXvQ0f6gm8f370W0KnNjmwEyUWoHMqltRMkB5PI0Q4x9l2jMa+OjYzbBPhV/+NCtfl4adMz7ofNSho855HxMIjbSttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0lSKtaqlLoP1q5HbGRu5aLkxjtXntTwY5JVSi2Fjfg=;
 b=TPFY1X+5XCVJLTulZ5hhsI/SKrL+FdlyianOz6fZUW2T6QLAjjGu43MWDFPmnuUBcvRTY7kBa0pvxRk2yAy6sDmKtj9UE9uzMMRdUfKzpGiqvevDVuymLOPP2lKK7TIvuxGFH2fJpTpItWy/bPRcp2oKPUWBPxxYKr+WGUtpHRzlkLLlGPKv0idG8oIiOrgyz/UpibAF0/O8ACQw0nFEgsJincKmKxVXcCxivYnrrlUS3U/XR4Tm40S/dotAiv2btdDzU6tlBLcsaGuzQlfNEhyeTniFZvuWuuF2SLc1SyCK/7zD8dEijyiuIxPL02NQuo/wTGiSCFY8xmJfO39sVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0lSKtaqlLoP1q5HbGRu5aLkxjtXntTwY5JVSi2Fjfg=;
 b=tvEYtR27Gqvwm2mRUHky+qnDE4yXK5hXzK3s2iJ7yTkCZI1spXh/vJ0BSCEvR0Jw+GnfXmvjFfx6gOs5DkqXNX7BPa/eZiRa5G+TMlWWliAsiZv9ZcLaC/p1KW5qb9oMul+A1Bk8pEopbTq6cOMzQlXBYiVwhuMgx9zByqqktGyWXzU8Z23nP1qopYq/f8XFg2BjV4YVUD5YlLFqrOzeih5UdyAwUTQH21OudctbKThNycTv4p44of6SeaI4gb44gN/7oJJmmt7VQv3z0Kd9ec6bVECOdwBZskA3NSKu+IYG+x/DR504xkCrQvwb5THXzJwapU7u4M3jpECK6QT1Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 23:55:32 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 23:55:31 +0000
Date: Mon, 18 Aug 2025 20:55:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: saeedm@nvidia.com, itayavr@nvidia.com, dave.jiang@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	Markus.Elfring@web.de, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: Re: [PATCH v2] fwctl: mlx5: fix memory alloc/free in mlx5ctl_fw_rpc()
Message-ID: <20250818235529.GA1098127@nvidia.com>
References: <aJjiRqLx9TEg2NFj@bhairav-test.ee.iitb.ac.in>
 <aKAjCoF9cT3VEbSE@bhairav-test.ee.iitb.ac.in>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKAjCoF9cT3VEbSE@bhairav-test.ee.iitb.ac.in>
X-ClientProxiedBy: SN7P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW3PR12MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: c3fdfb7e-1659-4907-0b24-08dddeb2b709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Jtc1lPugmuUX9BwEOEfYTKsy337y2gxGlzJZgEtJIdxXVJ2wvw+x/g4rcNZ?=
 =?us-ascii?Q?BHVeBoAJHrwXNAMERoHdJY9Y9hKrt9ERckar6BxuNE+o2MpiNpqzqBEx4LHP?=
 =?us-ascii?Q?JakdTxlcdQXHMXJpR0sD4mlJccmQ7MICmYFZVeyXJr567FEJQODLJ6joK6Ny?=
 =?us-ascii?Q?2Cd9KysLZ1qHSTbz3q88/fqXMDVvht+Ft9D5sOCLusWQMCt6MkaU/5sWR1vP?=
 =?us-ascii?Q?y4RnMPLfa5bixcFBYNk7rAYbrxN073ThqoqRc6fFFreNXFZXHWKfwOcQ9SAR?=
 =?us-ascii?Q?E4CKNr5rTXm11As7QRJObBodVhXv2DpljA826Sll/ssXXZcqy3nBkSbuzowe?=
 =?us-ascii?Q?7jwUfaZr/YabQtvXaynzVZKEVwKg4iEeRCUpsLZPr+iaqd/6so0t3iqVhdcu?=
 =?us-ascii?Q?d7hWTZYf/xTIByYzuuKVh5HPLACdWqSXaNU2R0eFe263D356/Oswf1t3B0BW?=
 =?us-ascii?Q?POBa+0NsLBfHQLJxSQWofEWEmW7Ym+DC40p3MFZoCsxTLe/gUYvhDqOYdvkt?=
 =?us-ascii?Q?fdq5cypWaQI3M9sRAiGrCsKoQ/h9BG2P2i53CJ0BtgBE42ie3LCAUmPgrGyA?=
 =?us-ascii?Q?o2tyMUpgZGWxGrKifmRjkC3oJykivIJCrljyJeBwPiLskUUsvEVJoZ/tu0I6?=
 =?us-ascii?Q?TVEIg8xLKWV4h+3rB9J9P9sDR0ymSIhvB37ydzlbMKFDznoczVdTgjz7JMic?=
 =?us-ascii?Q?PRJWO9xcccii2JWyJ9uKFEOCEdUJwXS3Kl2el25hccVevDM+WN3kBYuXdluQ?=
 =?us-ascii?Q?HPVRaNq6vGm/2UYuyGWcO72L4bvMVnI0rD6WKKFDFVsGYT+XydTNUFk7apoC?=
 =?us-ascii?Q?SdCeRtMyPORp0qTRwvcrgRSeoMe6+GCS9DQS4UHryPfGoBCjcWgUF1LZqKdH?=
 =?us-ascii?Q?BL5l8W+jNNZuhPGgqfqt+zX8iPvgHr6d4Kj5393KeGZLfkCEUPGo1anE2tbe?=
 =?us-ascii?Q?Z4Az47Jr5D2fG6fgZ6AvpvVdzjwYHgcg4QfYWq/L/J2KU2KsuvCG01U3Y9g2?=
 =?us-ascii?Q?S7yfvvv7yNf1YU5VyTDeu/N4/Et7+HPj6Bkkdn1f5SNPvaIXezqxnB+pVUBG?=
 =?us-ascii?Q?fXWD+QAm+K/GJGhK5S0GrvNkmHrT3/QSuQO4trDrZ6QenNbnX+4Q2YYS4HG2?=
 =?us-ascii?Q?sxEylVl8FAr4ec+5zMn2Tu586iAu7809U3xXGexgR8A/AfYiX9L1TFvRXMSy?=
 =?us-ascii?Q?GcHPWV72OxLadmnGaSnORNCwxnofYC4ChlxiHsUjN0spQRm6F/sRL4F7Vwq+?=
 =?us-ascii?Q?gpmru1q+H5nzJ5ppRqyPaZ6XDabZdeSxVzUJnld55/WxJX54AEezTKzGnaOi?=
 =?us-ascii?Q?8yau1wdW0KfyYFPDaTZhbstPN8xMg/3vU5B9KkUNL4mfySkVR1kUE21o/vP0?=
 =?us-ascii?Q?wGOkAUVR+/ccJl2rwIhQpWT2DqMG8vbJcJBKb6Ph4xT/Klke2g+ix61c3PDS?=
 =?us-ascii?Q?xn0h1TU6LDE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ogHURXioQ5+qdKFczwB+9jFynJ+7KazaQ+aq0fvgk6/i9BZ0O5QQJooAEZjg?=
 =?us-ascii?Q?5rssp9HG/S9YjWFkhFlEQMiX/beBi/bnuKHsmXI9XeaWz87NwhFK8YDNm75u?=
 =?us-ascii?Q?YnJe73AZAZoV3VvAKvFrW4Cxy/cyWnZAAKFm2EYOLO1ua1hrPiSEaiur8D6Y?=
 =?us-ascii?Q?zDRdyHi/g923bYu5JWKYdQcZflh6303nDM+rz3NuobmivasOiZzf9kUHCx7f?=
 =?us-ascii?Q?/hlQwIi4ZsQ6L+USNe64ZNdq/obw599Q5IucJPhzV7xuEQXKT5teXPX3J6Np?=
 =?us-ascii?Q?+G0jYTGjsa6LHKU1Pnft1i0Hs3Wb326S+3y3ikbUJJTjfxRwBr7cmTUvP054?=
 =?us-ascii?Q?JZ14SdZOaEwaJW3grBX3kHuUhsJTG9sbOYF6AuoHnsYT8Sp1a2+HDL/x4eX6?=
 =?us-ascii?Q?qoRPBO7iZgn+I9quGwf76pETes9nHTyeReUqBUJXUbnt6DgdRu5cr2vyEyYV?=
 =?us-ascii?Q?kzs/lAjw6uYLjg/zEpCkseoIUYy//emAjKIPTbM0ypPk+egYViGmicA9UAkD?=
 =?us-ascii?Q?m9FaswJ4fLYlXqzvu1CpQOgkV2jD5geCO8EfmyD20GLk/huIb/vH37lUJcBL?=
 =?us-ascii?Q?A+vmoRGCoOEt3V25MTk921NdNy/K4Tzfshy41s0Dq/rV+u6aEKn7pkMgcTFj?=
 =?us-ascii?Q?ck3NOBtjoui1UlMDhzAvjzvbwbbbywLWXwAm1Y3A6JM0iew/pVzx3m4O0sFF?=
 =?us-ascii?Q?efcBhRczf0K2EcgZj1xdCb6c6CmO/1SV13O+DQWwT58g4ZNIe3edYTAeNDax?=
 =?us-ascii?Q?ist18aqzA85Qih8l8Lger6+6oq0L8ACbt6r2dO3RVqfsr/3zf2q5xXSMgQRG?=
 =?us-ascii?Q?wRWtWkzD7Qv3/h2Z0Ibt7gcLbMfhS4S6SjqbAJOctmgsA86OSpldRQ99VQ86?=
 =?us-ascii?Q?ZoDcfXOptEjtOJilkqmm4NxDrXcPCIJLQFd4h+aYUzepPDxBjkmCfDYTKpyH?=
 =?us-ascii?Q?SsTXlpojd2mxj2SneWYMhN20lPEsNc3qwAyzUyKi7wEBLU7Lur7xVEmcGu/B?=
 =?us-ascii?Q?yTX+rcCF3qUZK5W2N4PTTTCZM5FZC5oUiN7vU893beptk9olJfVsExCkeurW?=
 =?us-ascii?Q?5lye9NaJUiYYnRfO4wLChSaNaDvqLyUEwPXJwuw78x0iQUxxtHmyCmG0dCV+?=
 =?us-ascii?Q?9/bkKPUwSPR4tO1IgSKsT4NVtDsXK6CJf05pNIes74NslFoF+nPCAlv2fBEA?=
 =?us-ascii?Q?sxeeIW+kUTOwLju87lCbvm+lOvvWceUXFmLdZItuTDLqv5DBpngWzSmWOmL8?=
 =?us-ascii?Q?rJpC/TD1k0RkxNSx4MQr+T2rAV25VeMCyvv2Fb/QvWny9c0/z7RCew+jbidc?=
 =?us-ascii?Q?OhYdea5apIsMJvqEdYq9dwrEJvmOqRojfCf1grCbbwbRh4HGOCx+oqPYEH7J?=
 =?us-ascii?Q?qzpn9Hu4Iy5wcVQL6eqUcjTaQl3GjBw/BwBIbaBCVS9mIaueLjiM7qe/Pn3z?=
 =?us-ascii?Q?rUDMcECTJFlERvl8Z6812Rbb4CXS9sFYNMGJsCNs7QllnAlBar+N5TsWGd0P?=
 =?us-ascii?Q?wk78FDl2X3MpxzZ9PLpBCPYdQH1s/LMNGJCkJIqjkBRjMoFn+VGiFSll8gbV?=
 =?us-ascii?Q?RXcEBkxBxN89u6iPWvFYmzBF8Eok3wh/oFstCtI2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3fdfb7e-1659-4907-0b24-08dddeb2b709
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 23:55:31.5047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6T55Ja9ActHlDPT1pb7S0bhun7RmZsgBuMOxay+hqxyuoqTMbABa8pr4jQiefaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476

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
> ---
>  drivers/fwctl/mlx5/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc thanks

Jason

