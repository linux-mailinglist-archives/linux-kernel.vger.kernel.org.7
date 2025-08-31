Return-Path: <linux-kernel+bounces-793255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4B3B3D13C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA0D189EF00
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 07:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCB9226CF1;
	Sun, 31 Aug 2025 07:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HJwdVKB0"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E032F22425E;
	Sun, 31 Aug 2025 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756624465; cv=fail; b=TKQJ+X9c3ZdKxYd7WgoGLL3q10BR4ljj801Q7Yjvi1ZE8K1xb+ulJyYDPe6LjFeYrIS6YXFi+ocs0Wg/aEtKP9H3cu5IgcNw0aBBUCTX09yelOJcogjjwhWyseotZLsVBZ6OXxvnsfrFn7XNohaV4u3cx3O5+B5slkRrqIXk4Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756624465; c=relaxed/simple;
	bh=SZDLESGWJ7DkdteCWNg3UV1jIZchLtOXPP0tuhmdygI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oaxPM2PqRzYQBX2iq+rOp5o4Nne4uQc2JzGxzGJsQrszAsvb+zOv2Sw/OF3h19J9zTUXbWfy0CbnrTA7QGpy2TasQZS4Om+BUTxwGlKFzseN4iDtzJZpvSrlvF27Vm7lGWBMcCUceeibMpCzav2QhUqGkQ5zylX0yBWbadDx4DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HJwdVKB0; arc=fail smtp.client-ip=52.101.66.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2nbweMjI6dZuCB9bnjDo8J5F4U3Y4Im2BDj6I9Fo+BfSTR6hr0u55jELe7Z4Afl+urw5YP88AbNfAuPNSgyFBXMj2v0iY5TUPjeHEvCyNFopMIPVtXHOAxIXW1OLgQqaiIeYfRoz9m8T2sm9Wh3NMhu9c223vTdcsI+zhizW6r8/9+uEGGN/w0dabcQppdEbkqJ3baW6mpfxuWiIgfYCW0iAfa2VZaiba7v+aOstunsZZCa9Qc2LnjuuSp5YjVYeIQgMwzq5hpRD1nnjSdYhEnABrupQUsfzUYl6RYL73g99LYfCp51pPk5eL+xWVqJXNvYSFgwBE9Ss+ArA6n55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FiUyJUoHYFh9KXrEQa6sV5bevJsoUGDaoUdH+ioQRQM=;
 b=IoYzQksKmljZWWFwn5VT1GURAS47MVqdkmoQy95LYRyO+vvrXlpJEFTXALOWKtoeP+J6zpDX6hvXFlSI/ZF2giDAKhxshFWm4M5M8R2lw7c+76C3BGAnL5rmnKpZ03poP4x8yO2dVp2jak3bf6/Q7/cFn9r5SNK3OlYWR0pjykP8fGR5vjticVaN499M0+Axni5k1pdwxJVhg8xom8VvsgYH/vvUjF8kB7Zm/pO4E+8Fs2kBiyCJflqFDXAAkhid919VtRuABo3at0nuaxz/ARv7Uj0L8ObGkNbGHOymbKQ8Bzw3se4HPQTIRSvyuss36CBxyGMzAT09R5RoEBNzPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiUyJUoHYFh9KXrEQa6sV5bevJsoUGDaoUdH+ioQRQM=;
 b=HJwdVKB0XoRqUXod5OgAvQr6AcpVlnDXcqIQEW+rAh/F3srBg1f2nMxNHTghEYG4Sji/vX5wmfeZrz7FXdtI0bEK9NUwQOWrhjf+UOa790Ow/wAKGeIn46dq0PB8URY53uZ8Lsdu46WweWv6+/I6tzHc0OzYepmjlwnm/SyJrqm98mxY7odyUXHMdo5YwYq7ILavmRjr7JZXV3n6AKV6lgf9X12iUGJ/0i8G8fz0myhr4BZ/4JWoiIs92P0QV/4fmbz0j1WlfNh8vE34CAYHKTBfIfYupiZw/tiUbCYEb2I8eOBuRR5JweFnYW3XeMDnI6ZZk6qwkGISFT7P/pu1tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8174.eurprd04.prod.outlook.com (2603:10a6:102:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.12; Sun, 31 Aug
 2025 07:14:21 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.011; Sun, 31 Aug 2025
 07:14:20 +0000
Date: Sun, 31 Aug 2025 16:25:38 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, arm-scmi@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] firmware: arm_scmi: imx: Support discovering
 buildinfo of MISC protocol
Message-ID: <20250831082538.GE17728@nxa18884-linux.ap.freescale.net>
References: <20250827-sm-misc-api-v1-v3-0-82c982c1815a@nxp.com>
 <20250827-sm-misc-api-v1-v3-2-82c982c1815a@nxp.com>
 <20250829-satisfied-carp-from-camelot-bddbfa@sudeepholla>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829-satisfied-carp-from-camelot-bddbfa@sudeepholla>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 04fd79ed-475c-427a-3b55-08dde85e0196
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EGLiSSpapUPRdbT0i/R0vFgrWbAQKlqMrVfPHKzgGlKn+QE8zL7p11F95LDJ?=
 =?us-ascii?Q?OLIb9/JscuzUyMAn2YlnR5iBceATaOcCNFNVvumY9PZr4qxgS1169V8Lb30i?=
 =?us-ascii?Q?MlQ0PPHtAMRErKha+ek4EGJP9HRGD5RKu6vqduA9jm7xlPENV8zBXivr/+ww?=
 =?us-ascii?Q?zJ3fOZbHkDG1FA+UCKmT6sFMuTMSr5n7PIMRN49rsWENvl955cG83d3SJY4L?=
 =?us-ascii?Q?Z4J/J7gYt2NRD809KCF0UDvqUNELYBLwqwwmUfDIWBbths49Zq/Edy81mybX?=
 =?us-ascii?Q?anDZgkMhdb+dIZAMlzGNwyP8+tE0OEOQfK3vUbD1Jcw4LFdr/SYGTwe9fmWo?=
 =?us-ascii?Q?4w7zxInEPSE/Q1ilcE+I/x3dhr30zEAxXbJLnHUXvkBkUHsMuwcWw6DDyojc?=
 =?us-ascii?Q?zTauik1QNhjFBDpXmFm2wJhTMY2yv63zklzXctInfn1SMTAx3SE3aP+7dcMP?=
 =?us-ascii?Q?3iqxjr11yG+3QtcRDUW7RUMWcB0OgxmkM1s28VDC/9PjngGy1tua+g/g1Ipx?=
 =?us-ascii?Q?OdIDpC/UzogxHsdpusxF0bjT3heh0p5S4gvOJ8OL93sRKobw6HZcGKevoKlo?=
 =?us-ascii?Q?aOyFxO0xTGkc6dPPhQw8Yb4FvNbt6VgLANT4qkwvp9r34C4RyOQQ/fwHMTCe?=
 =?us-ascii?Q?f0lAcsndyGKBwkSfhHJOzefHpwoUtEVxmaL2oyqqPaqMW9pc+L3N0lWAMoyS?=
 =?us-ascii?Q?VgxsFfP1YSUJZnFvhd6X+livVLcB4Pscw5XMiyxvTHcru3PFEPMqKo8f3ivA?=
 =?us-ascii?Q?LojAHnyHnGIrEXOwtIQ7x6T+KWioW2DHJ8HvGNmuGUeJDfnaK1p57BonQLMH?=
 =?us-ascii?Q?iBiemw3DZE18mMAGbQMPgHwMQK/8WSKZrvv6qC7OBV//xoanfZw6OXDaJgEB?=
 =?us-ascii?Q?sWnVKE2evbr3qpNRqrqRyLUZYJK1E1LelK1vnrfoygngbT1kgcvefKhlZm3t?=
 =?us-ascii?Q?AG6S+G6iSEg2ZrQ8rihj2Q0Mwri+Y0uLAFoYxtAMYnZRJvpFph4MFZCvUr+R?=
 =?us-ascii?Q?DILF60C+W1a5bAZLgqa3wiD0p8fEnuDUbuGLAFqPoj996WKxnt02YVsffvDa?=
 =?us-ascii?Q?hxWYCLDtwnGeFYMFi4yUjSjSh4DWXTLR+GE6H8SgHsC8bXnJ9FZz03bfbyRV?=
 =?us-ascii?Q?MO1urDC4r4pxUKVq1P3WbfR2joUO8VPElk+0IF+kVMcHjTfAv5Cw0g9JQ6Jb?=
 =?us-ascii?Q?gv6C1D5OUHgDen9onPqsD34gLZUHtgqsrnVW43TL273h/lOj+AMNkxH8rcEx?=
 =?us-ascii?Q?0T/cfcydynwj9t45AVee01lv6B81l/dwreGKS/Ay51VGXrYblKnmQDfV2VPf?=
 =?us-ascii?Q?3qFHMnvNrV1JWMrEA5T5S96Qs3o24H8M0830BEhIgZ+MNb6ZsPmwZ2DUjxHI?=
 =?us-ascii?Q?QFxV4MufMBGmAIkTjaMjS5aPTbHmqglxMHc3ApOg4wlsjR15fm7PfJB80A4M?=
 =?us-ascii?Q?VDQURGNolBBALFn214j4dDSFRsiRJbxSgjuaYGzibank7cfY9KY7BA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cpobRF83tOnSxF1mkfBxddCQicEF04+2iSpkTmV+o8K5ZWIcNKWaz+IfPAGu?=
 =?us-ascii?Q?C/sUjlZ0+uo9sF2N1asxJPykC62BSWRe09KnONzqorJ8/o3ILD7+nckX7ZfY?=
 =?us-ascii?Q?2i/1gjvEh9bgosqqeYVaSuBIkdpnxOeiuy6bPIQDsBNhdYJaMAfKGXbCffU0?=
 =?us-ascii?Q?viXinkLwNabhK1hyWPU/NDAK+TzJzB/H48AwF0zV2do6oudxeCUtQU+alCo/?=
 =?us-ascii?Q?aBn24+IrT7mt7WMuU/3y5LmSWphCUhlYZK7kbCAjvdVtSG4VN266RptbS0wf?=
 =?us-ascii?Q?hEdKNAuKn8svNUcKsJUlZ17vOr6lhQ6vL5oynCAMeCjSxsXWBnz4DH14XEPZ?=
 =?us-ascii?Q?Pb0rZ5I4+Trzu6LoiTS3gc6i+PlsKuVlnLNw6ax5agImoa5QSevsJwxgubAT?=
 =?us-ascii?Q?MEXOu4WQ6sEX3GkX3Ck0j5xiioYG/4mBwR23Bo2ZM9owTjYKzTpK1CdKivjl?=
 =?us-ascii?Q?U241jlmRG7wciCxwe9MlXwe10fBA03KBixSfRdRjhrUBIXAaS0nbU4/+5jpJ?=
 =?us-ascii?Q?LPi6WAC3IweaBdBQJ6+KYYbBhRHPF032cvIaDj6YGS2BvQavvwqKc+GooOYt?=
 =?us-ascii?Q?xkCV0KK3xIN7P3dnv0ojC0jxO+dR+4cjBtkZCG0ya37NzMddWte9/qvOAilH?=
 =?us-ascii?Q?K3r+PBtL51OP3e6EFr7BhcJ5SvdldUT+dfTRzG40lvl1N3mnQfUUAXZCgMil?=
 =?us-ascii?Q?/udLH0aPvAaHZlcCvsteen4xiNB43vQ41vcPDxSLZtFehBQUbhK7b4Hm/iHt?=
 =?us-ascii?Q?pc7xUz1/Lfcra9eAsUpZLMKWPnelsdDSCJ5HGfcfnFEt0fqRH8tqWEfYr6ae?=
 =?us-ascii?Q?xEUpHkzpU/xEcsVvjM5Ipvc1TkiyOTBfsDt69ODuDEr4yPV95Fwg0nZTjhds?=
 =?us-ascii?Q?juYrpZSIeT6o2OtHiy79fX/ukm8fgEOSjvClQNOtBsFgg0mJ+ang3+GLzWjV?=
 =?us-ascii?Q?t4SLlHJpbkmUbk4n2wHwXwzPjUJGOU9fE4BZSy0/V80jistDddH4bhczEkBY?=
 =?us-ascii?Q?Ia8eggSaxZi9l0hemNFhGePCWq2aMuKAQ+diEQ74QWhWSqQyIrR48uTWneN7?=
 =?us-ascii?Q?NHwsAtN22KMF6Qwcb/n9BXz3rT9kn05LJB4CAdnAFuLjoPmwCBECX1HMrnw/?=
 =?us-ascii?Q?55bh15v2DswAruIEf5GdV3LtVbI/Nz3sSnmCEo4msw6uYF8jNt1vShmlBo85?=
 =?us-ascii?Q?weuI3zPkssu1/jQZ1iNo6wkKZwnb9XUvcwRtvl4yyQfGqjL5Gg5BPF5ioSSq?=
 =?us-ascii?Q?bz+tM5ierDOk+iaxa4Qqs9TIZEGxBoh05OqHRU4zPLlRyM9qelDbMBehKofF?=
 =?us-ascii?Q?twzZMohTD1M3cOWpqYIOG+0Y+VSuzp4HlzUl25wCDsPykkND614Dg7YWUg9o?=
 =?us-ascii?Q?lV1PK9eaS0LXQvUC/QlQ0eMkpnOd6Fp2T31WyRPKL14bU4BkK+y6XMd8Ulme?=
 =?us-ascii?Q?KapKDfn9wS/FflAWMhFKVk52d6G5ZaczX4tvdBhhaIPleJ52q98y6dC57NAx?=
 =?us-ascii?Q?2NicQhlrflWdTI/O3Ki5hKAzWhNzKd7h38ypstKdHOlfftYdR45dVT0smC4g?=
 =?us-ascii?Q?3iEECmodTsvZCBRR78BLncCA8VfrYNKeUc/horrP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fd79ed-475c-427a-3b55-08dde85e0196
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 07:14:20.8721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5eGC8x9U04ekTtWAiBgEnebMOl2ZsDF5cHu805gwmL0zc6FH6NAg309wEzki/b2H95KatZMJdLETZ2pc9a/zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174

On Fri, Aug 29, 2025 at 11:48:56AM +0100, Sudeep Holla wrote:
>On Wed, Aug 27, 2025 at 12:59:14PM +0800, Peng Fan wrote:
>> MISC protocol supports discovering the System Manager(SM) build
>> information including build commit, build time and etc. Retrieve the
>> information from SM.
>> 
>> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 41 ++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>> 
>> diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
>> index a8915d3b4df518719d56bfff38922625ad9b70f6..464afeae8267d8c1eca4c4d5e008eca6d741c6ff 100644
>> --- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
>> +++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
>> @@ -25,6 +25,7 @@
>>  enum scmi_imx_misc_protocol_cmd {
>>  	SCMI_IMX_MISC_CTRL_SET	= 0x3,
>>  	SCMI_IMX_MISC_CTRL_GET	= 0x4,
>> +	SCMI_IMX_MISC_DISCOVER_BUILDINFO = 0x6,
>>  	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
>>  };
>>  
>> @@ -65,6 +66,15 @@ struct scmi_imx_misc_ctrl_get_out {
>>  	__le32 val[];
>>  };
>>  
>> +struct scmi_imx_misc_buildinfo_out {
>> +	__le32 buildnum;
>> +	__le32 buildcommit;
>> +#define MISC_MAX_BUILDDATE	16
>> +	u8 builddate[MISC_MAX_BUILDDATE];
>> +#define MISC_MAX_BUILDTIME	16
>> +	u8 buildtime[MISC_MAX_BUILDTIME];
>> +};
>> +
>>  static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
>>  					struct scmi_imx_misc_info *mi)
>>  {
>> @@ -272,6 +282,33 @@ static int scmi_imx_misc_ctrl_set(const struct scmi_protocol_handle *ph,
>>  	return ret;
>>  }
>>  
>> +static int scmi_imx_misc_discover_build_info(const struct scmi_protocol_handle *ph)
>> +{
>> +	char date[MISC_MAX_BUILDDATE], time[MISC_MAX_BUILDTIME];
>> +	struct scmi_imx_misc_buildinfo_out *out;
>> +	struct scmi_xfer *t;
>> +	int ret;
>> +
>> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_DISCOVER_BUILDINFO, 0,
>> +				      sizeof(*out), &t);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = ph->xops->do_xfer(ph, t);
>> +	if (!ret) {
>> +		out = t->rx.buf;
>> +		strscpy(date, out->builddate, MISC_MAX_BUILDDATE);
>> +		strscpy(time, out->buildtime, MISC_MAX_BUILDTIME);
>> +		dev_info(ph->dev, "SM Version\t= Build %u, Commit %08x %s %s\n",
>> +			le32_to_cpu(out->buildnum), le32_to_cpu(out->buildcommit),
>> +			date, time);
>> +	}
>> +
>> +	ph->xops->xfer_put(ph, t);
>> +
>> +	return ret;
>> +}
>> +
>>  static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops = {
>>  	.misc_ctrl_set = scmi_imx_misc_ctrl_set,
>>  	.misc_ctrl_get = scmi_imx_misc_ctrl_get,
>> @@ -299,6 +336,10 @@ static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
>>  	if (ret)
>>  		return ret;
>>  
>> +	ret = scmi_imx_misc_discover_build_info(ph);
>
>To align with other naming,
>
>s/scmi_imx_misc_discover_build_info/scmi_imx_misc_build_info_discover/
>
>> +		return ret;
>
>The document in 1/6 didn't state this as mandatory. IMO, it is not
>fair to return error if the return is NOT_SUPPORTED.

I should use:
if (ret && ret != -EOPNOTSUPP) 
	return ret;

Thanks,
Peng
>
>-- 
>Regards,
>Sudeep

