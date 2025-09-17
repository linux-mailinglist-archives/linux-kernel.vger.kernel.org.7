Return-Path: <linux-kernel+bounces-820909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE58B7F9FD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709E658753A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC58323412;
	Wed, 17 Sep 2025 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ljOPSB+T"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011010.outbound.protection.outlook.com [52.101.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA56316193
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117193; cv=fail; b=SaKdPOJatIMAxsH8oqkkpwonddK8x1Han9lxQUE7IQhJgw3L2LHgrN+Fc1/0tGOXZNgSZC2bSgRsbA9IUtbAwXqdgwhLWvDEI7L/snXHJ/WNTWNs7reSjjqCBjkp4GdTBoZTYt3cQ7RTs/8/TNKL11Pm8yfRQK2tHU1EZ36CHcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117193; c=relaxed/simple;
	bh=qRJaPtROz+9Tx7xTrQ1n7AbfrWQmj0UAG9jBvV/j0hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iIQss85Aaaodax55SQ8+dTYm5kO9IMXqZZ1Mjf+B1e5M8wvamv2/+W3jxbNBpvRmvmLHmlQV0oZMRsSDtMbeQPOJRLsYtcEFyhre6jwbEyVUsTR4r3aPOq8u8zBtD4YEa1fHOrKRe9SWc5zAFrCGFGjcxladzTM9U3lghf3xyDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ljOPSB+T; arc=fail smtp.client-ip=52.101.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwR5sfqBSOBSDziOyo3G6zhcn5vfPmGJASbV+5CME5ge4jC/4A4U4Iy7u/6CX02EiL4jvQSNn5EmZpT0N5paQHP0jp1RlT3tY3WmyJg2A1MQjDBXsmAr+CAUm6YPzzq0p6DHTh7SG+oKgEYvUZ9IaLTVr1YeGDcU4rtqt0ItPmflTbiY9rKtpo6kemRzmZjCNsKGMB5uyWOp6lg5a1N1cv0OD2QHlh449i4M6pEjfnYKqStO/6Rq6ZW5OfqLU0N1mo/40J1tRtf0lY78O/AGR1iCSJIQ5e4YtQHLMZ7MZi29zl7vd2sioBDz6SeGO3QeJttjRXN7S7/Ka1MWj8U6qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRJaPtROz+9Tx7xTrQ1n7AbfrWQmj0UAG9jBvV/j0hM=;
 b=xMf0ZGwYnV4AynPItiyKYKOpJEgajVMQnddDQaQ4RFfh2AzH8053o1B1FlE3CLguiI8N14CplkoRqquhCtjnLV55sNFM89jge1K7m4JW12g2fzH8XS+Gdi3t2P1jofPo09I2vof3n9RJcrPRMdlSwUyG8Zys2/dNZsfbpcDsLcnkTdhMLIjZ3jZDEte3T694JvuwS/yUYaifosG2pJBtgCW8G0b4ZUPV2oFsQqYyjoi8KBzRuc9LjIYs19Sl+ds5t4givwPHNBeyFz3O9woKVo6Qv/eO0hLVHc08Dpa2dY6gTWRz+s5hnv5v9E8HboJvRsAXao+vasdOSaIQxnaTqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRJaPtROz+9Tx7xTrQ1n7AbfrWQmj0UAG9jBvV/j0hM=;
 b=ljOPSB+TyEphFncc5l/e+RvlJWKNIQgnLnItAQLXbG8QZbFBw3P2VEhOJgnnE7wSm67SCNpLAKKxL2g5dRmQ6cgiRfTQcD8rPN6ANWVm5hW3ea/pZIoOrV0RQGPO6JdohYqdBwFA0TI7OE5kda6JKVXPQslY8G7e6ianUEjgmu+KhW+e2q13oepVO1JS1lgI7klETeSKDn05wyrmG2OX6LEpgHRHw6lPbZIAYFN4otSHGyAt4W8eh1MRBlM8vvoEw54VLhrMq5FHGSk3MKJYG9WKEZXwUAUhCXizHYGcspvM0691Anp0s36XM0JKwea0LECKxch/8hhv9u1Y7KKMpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB5PR04MB11253.eurprd04.prod.outlook.com (2603:10a6:10:5e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 13:53:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 13:53:05 +0000
Date: Wed, 17 Sep 2025 23:04:44 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	"open list:MAILBOX API" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mailbox: bcm-flexrm-mailbox: Remove redundant ternary
 operators
Message-ID: <20250917150443.GB28673@nxa18884-linux.ap.freescale.net>
References: <20250904112926.351309-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904112926.351309-1-liaoyuanhong@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:3:17::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB5PR04MB11253:EE_
X-MS-Office365-Filtering-Correlation-Id: 303b75d8-8b26-4510-2ae0-08ddf5f18682
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ufrE6gqTpHk/wIgTaFsbKFRZ7kt0CxdNveyeJuBbsKmrym7Jvoq2hAvUUo+h?=
 =?us-ascii?Q?6SmGzJw1ldcoNTPWLj8Jl2iQ7u0Pl896xNHdngeNVkyzlqbsgn0aG4K+uPmw?=
 =?us-ascii?Q?nq60RyvcHZEdN6eSNVMRS2ctp2mLHY17hCscO0/fV+Es1J/TaZ+IBKkjHvio?=
 =?us-ascii?Q?3z3Zr1GflrkhhDiWV07R3nk/jM4QxNIvRIaVfsOcT/OdBUj+Tw+UReODduIV?=
 =?us-ascii?Q?tZv3uwqqLyT+y8MgXnYwlU3AoLzWUTMfryueH6bzXPQ5yVTexChwYexuxDiM?=
 =?us-ascii?Q?y90wfQNvjxVkQd4kByGNk0isjmQDLiUHbz4d06227YFEVv5JzqXnDZ25YfKk?=
 =?us-ascii?Q?9wO8xZiwpmThYimx2jqZYeTG8e4pEM7KSzgcPAXYGrBWebehDlpALrqGboAB?=
 =?us-ascii?Q?j0D6Am3z7kz27pXlDUJlOlJEI1szYRrNIB5/bJXj2T2PtY7fe1rjYkQyErBG?=
 =?us-ascii?Q?lykf1dwbT1w+FcczGwEPNKBuxz6Yj7HHyN3Jhxcw9/zgbzIW9yRRaMJx/vbC?=
 =?us-ascii?Q?yUynNHkphuNdUESZM0OU5m1/bR6olWN/udnZt+8ev6bTNh1aTZ/o7v9igrZ4?=
 =?us-ascii?Q?Z7ixX7Kb9PhcPdpDmVN8Tzilx2T+skUGxVM7FR34PRJvAa7ulYccp2So8OeU?=
 =?us-ascii?Q?lqfc9ZaJr6oGzsEq863Sa90XEInClAGtWy81d07S0hohgtv8Srosm8i1QAyc?=
 =?us-ascii?Q?S21auBRF+MQRkA5omtCcvXhN/P0JWs2kf38Z35vyp59YARW1wzoeZX29gmI8?=
 =?us-ascii?Q?UrYr86gwDfMxjKtG4hk6gw7UYVB42S1uAC7UHYmDVl20IxcbqddLuoLrfvFN?=
 =?us-ascii?Q?5LTsBkEs9biOgoj0ERV/zEZOjxNDm9MG7N7CFEaSjVIwaNIEVvmrI8P6oHU/?=
 =?us-ascii?Q?ZraAK2zAeTu66vt5AvL6lfjIaAqbjd0rUCMmtp58m4cxj7E8aNQYNm9vnUFA?=
 =?us-ascii?Q?L1FzTFi8YJDyhoplZqER8e3v6VecbuRpKrQVnpHfb3YDe6UJODPc5zXPEetd?=
 =?us-ascii?Q?d2mI8AyOpq4WYLtARynp9wZ+y+LimRuMH2/zkdsmCBRpcGaIIwV1HPEWZh/o?=
 =?us-ascii?Q?PDlllSVIsnvaQDi9EqV8e9qqbMZSdxr1sWGnvC6+gO8ByeldJbhCA2r68VRO?=
 =?us-ascii?Q?ZDDOXz/UQ1z3Lz+dPUDHjdtSGPCchoV7/hmyLprP6XerTJrETkq2QxsiHKan?=
 =?us-ascii?Q?QwoFpW0KuY+OGZqpMb+KUy94p9jgHaGqVdy93kuAzvLNybP4CQOQwbc7pAhd?=
 =?us-ascii?Q?Dr/kVv5tVnr1FFlcB20jOJNu76xCdn7AQtW1zn5VWDbEwc4aswavrh//kyHI?=
 =?us-ascii?Q?zK6UYFs+UXczmuEh8P4hrMISbyidXx9jlt/t9sRwgpvQTpKHDLkczWk81+9o?=
 =?us-ascii?Q?q6AbNsS7FRS+qL8vH8X9nZpakhpNgUgEymMzJiIj4IcuAuRP/sWs2aMVbCdZ?=
 =?us-ascii?Q?yBgxrgZGnCTcyjc4Vw2pWo9i9xz6tLbmwB4cc+uzyIUO/ViNbxUMQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?98MI9StF/iqRNviOrEYiwd+Ddacp3Nm64dJweGPvUdYZpySL9pMkWc93JPTm?=
 =?us-ascii?Q?/lISRc2F4M/TG5hDogY/YvuXRb7LkC+hsx09OPAhZ0PmMHzA8g0vWSRU/ejM?=
 =?us-ascii?Q?CwT2QPorXHC4gXNG7ksQnsDjLOnquhyxeQpyg/+ad/7a/aEseVBorffCdam5?=
 =?us-ascii?Q?SeOx1dOp74NwtzWrPs48GR0OpyZnlNs6FP4VAyPIfQnJOm0tOhxJBwHevye3?=
 =?us-ascii?Q?M8oOzqVa5iHbCgNNMTchH/etmRQpzs0EFWt+odSir5pNWQsHWi987KgcavBB?=
 =?us-ascii?Q?Iu3KgdmXafylvRO2TIXy/gRwxHzWpha3UdjWDDcYSEx5lfk97IyfbFqtnEDL?=
 =?us-ascii?Q?1Wb9TOtx4Dekia9YkB8IGI3xa6GN2ausbwsSSOChCId5iacCb0SHELTWOyPB?=
 =?us-ascii?Q?Lu2xFA2d+Ggh755B3vA5WF4oR7ScA1NpHaUHDkD03Fuo4gjL7XLrb1U7Z+g1?=
 =?us-ascii?Q?SFF119exsZ2pAfE8yzvUc98y9KUpd+jJrmGxI1Uoiyw4tpGxC3ZbAYc6oGEP?=
 =?us-ascii?Q?HoSSeimxujq3g8+tOPJFLwDaxJZtJ8Mu2KvVvKjdEVuu0LHPWHLc0GL2t/bR?=
 =?us-ascii?Q?iCUrGufBnak1MVDXam7JivnPuD1XDHntxSGEsFboGsbCHmucm+Z3onya4PQu?=
 =?us-ascii?Q?5ApiXPET084DpQfgieoDibbH4II9Oc0gPX6i19Bp1ym6kIErt3kXDAiFW630?=
 =?us-ascii?Q?81JKpmNDOfhb6PvLYczZ0sJdcv+opRuv6GtPGaMUM4mdblXysdy99Ln2tVMG?=
 =?us-ascii?Q?dpOuxtaecpa9x4654aRxKhi8smE3TH7YJPr3XynvYSL0jTziJwyA+eJyrSNt?=
 =?us-ascii?Q?y0ZvWRM8X1T0O67rNamfZuI11/fzUKYArxW9Kd6sbkVMMjmHeh8N1irIhuZB?=
 =?us-ascii?Q?f/CzYop9QFsQag3vH+xQWdeeCZoa+bRU7Z7PKCVV2eIWDaKfxpZpJA6Dxorc?=
 =?us-ascii?Q?ctnMCtYBfsW7hbvdhj60tGAiPulAG3G1b2IpvSd2gPGjpVl86+IhXJAtAi3W?=
 =?us-ascii?Q?qnnPaqirfZ7YldLubMTC6tSmLjRy9P9P/LSCxDY9ZotGZJ6dTGtjQTyrWtim?=
 =?us-ascii?Q?Wx/cp0wpIe3TxCY26FV6a9yWJrF8Gxe1YFmTPX3KNCkNvdj663BIXZ/0fu3P?=
 =?us-ascii?Q?gXTjTL1pQAzyO8AJB8KvswhuE1BkuEfbdB/csw95+QYsTJWt+jgULckOpXEq?=
 =?us-ascii?Q?4SPSjS/5ldBb2Cd3qF3X7oZHr6rzmUNjsKZ7wVmmIE/R6w0CbBeIBei5uWVR?=
 =?us-ascii?Q?PI9j0fyYxaIBhB5bHeqonnJ1Qy9SS3CqnBt/hNCqwAWyce0X7kAcixb419bW?=
 =?us-ascii?Q?rGAE/qddIvcbWOAJeqzxyQHlWgYPubK4Znrko8MIwl84jZ3HpYeMjlIP2mZo?=
 =?us-ascii?Q?Oaxrnq4uGNpTArVUZ/fWy6hoGaKccMpkqiJMHj4tlket5a+l0/3xeN7avVdr?=
 =?us-ascii?Q?uqFwKwFyELU47B0uWrbuGEQjaQfARLMDAUSAvPPqOrQGTbf7UMqEgtVkPbDR?=
 =?us-ascii?Q?ai2sJsvAGARKrnAHg4zvTmO4I3P1uQC5MusQ+1EB1HEZ54IVxZI61jmahyFR?=
 =?us-ascii?Q?1A2M21Kgx+GbVdI029ydoYUhWOAgn/PhVxEeLfJo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303b75d8-8b26-4510-2ae0-08ddf5f18682
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 13:53:05.1679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RakHuYeLfW4CVDJ80m2KCG1lKiDf4k7MyjrSTZQHX79Wc9R47IChoj7aAPsAy6E6PaDqSItbyV64da2j2jsEzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB11253

On Thu, Sep 04, 2025 at 07:29:26PM +0800, Liao Yuanhong wrote:
>For ternary operators in the form of "a ? true : false", if 'a' itself
>returns a boolean result, the ternary operator can be omitted. Remove
>redundant ternary operators to clean up the code.
>
>Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

