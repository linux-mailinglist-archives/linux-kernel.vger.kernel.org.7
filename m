Return-Path: <linux-kernel+bounces-823282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6944B8609B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB51165F59
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1A6313274;
	Thu, 18 Sep 2025 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OQ596r5q"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013038.outbound.protection.outlook.com [40.107.159.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16AD244692;
	Thu, 18 Sep 2025 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212868; cv=fail; b=GrEL6//31O1OU0nS00GThL4CICbRJPKA2Kn4ygngzgrmjnlV/PCwCzfJHqD4UuIPveB1O4rhqT/rBWFH7WmROb2NSNE3xRvntQ01iHsl8oordEw/X+/iKRwvwDca/9fcRsz3UuAL4vQJMNBv/iggu+W1y6MOBfctHeDCyBqYrOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212868; c=relaxed/simple;
	bh=Fc/5sI4mPCRm/jaSHmNk9CdJsHDgtn16REw6hwtZbUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HwmpJR0xTPaJAAmmCaMnB14ZzQ/5dd4GP3sPaCfrilzJ94n86+HZHNN8hlHHNy87yKcURG89I3fWro7a62RFgrI1Bb23z+5MqOA98FqZug/v3F7OFLRD7cpun9rGpBsqZw3USBdURSd0UoZFQQ8uHA9RU+++GGH2z/k8WbS7Rbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OQ596r5q; arc=fail smtp.client-ip=40.107.159.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTaGPgMeGr2tyVrzycsGc3YIg1m+gWt0fnkTiCHK0cqoEdd+10jhR5KUnvLmnSd08Vv1DlXcClRbcXCHnTyDN2ZI1F4AR9uzAfMt+3gL4V6u1oC0ySF8Lu20YelRUQfvUaUWOhcXoSxeXiddXKkQ+eKP3kjxj+c9K2WpNKuAhqt5Sz66G8JeYaN6xbWI3kevTqLfOjZkNnmCD9P0NbFFLX+sUYwtjBbhEjvTay6GdnZIgK+2MIfOPrLhWKEPqClul2Xh+OwaLHPh3ziyx1bn16JJhkwzRH6rTVQI0x1zgWmc0dcJiTuaVSy97CKB7YSmc3GnpZ+yk2OF/hAi1rUo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wmb5tMt6bQWsUzqeSHSz5M9hC4HuhnMK/UCBM6T1Y00=;
 b=v+xSeELloRCdq1SpKo5w5NeHz7a6qhFvNyS6oQGifGHgZrx3UKzNUuFtZia0fhZFsi4/P7uNKBFQY4Uk2HpiA64esxA5Zmv0lSntxnCFilwkSXfK2D8w4B0z9IFr6MaQ2sYQtern0qN7AcTCDLupl93NiT9PBzFN/J0RMmY/gTBrzHLMoF899VCmfb9U8SLZqe5bBLx3T7RW5hJuaAe2r512Z/PCyGdOg3/ZRKq7OgyzAGAWlbmD7wBLlm312OTdq5hPvHz65QuHujjRgkRRanVmPvnA6l4f0RxuVXE0pyGYEumDUr1N3u+ehGLOFENMm9TpO58o8f4KjNiiX6Yz3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wmb5tMt6bQWsUzqeSHSz5M9hC4HuhnMK/UCBM6T1Y00=;
 b=OQ596r5qA9UiC2lZdKprlDafyuS80oZT2KoHjzMoV5flvH0RWVl3gPx/Ffj14nIf2zuQHudI8o/E6+rd1aG6PcPXrY5tk8K4IgRFfOYGf+JJlETxN8Ov/n4VM8g/bCdzqBfNEDDDxwaM+QExE27ukhJndH1BCTTQtZS3NmmJgtkJl4YqKuwZsc0O0xp4Y1yXpvJiYBrXFrnKQfWpTjyw0Uu5VAiZPoJ9oOsmiN4avLSvJA26MKu0yF8B4oiRfQaxyTnbHhWxDnbTi2w/FWt2QAb5ihFDgTwR1Ro3p6M1q2InRBOh9F3m2ABqnRGhFb5vRByKFyB2CidsM9nIP9paUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by DBBPR04MB7883.eurprd04.prod.outlook.com (2603:10a6:10:1e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 16:27:40 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 16:27:40 +0000
Date: Thu, 18 Sep 2025 12:27:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: Durai Manickam KR <durai.manickamkr@microchip.com>
Cc: linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	balamanikandan.gunasundar@microchip.com,
	nicolas.ferre@microchip.com
Subject: Re: [PATCH 2/4] i3c: mipi-i3c-hci: add microchip sama7d65 SoC
Message-ID: <aMwy9MQOf3pG4Fvw@lizhi-Precision-Tower-5810>
References: <20250918095429.232710-1-durai.manickamkr@microchip.com>
 <20250918095429.232710-3-durai.manickamkr@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918095429.232710-3-durai.manickamkr@microchip.com>
X-ClientProxiedBy: BY5PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::29) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|DBBPR04MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: 2415b783-fabd-4a47-b2ab-08ddf6d04968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|1800799024|52116014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PcU7AyTDdIRsYILbSNOGPVgMYyAjo6b60x+LzGE6SKzZArPdhMGv1mUS5Pkj?=
 =?us-ascii?Q?hChJYx/TQP5Tb6cnsNIRKPIGY8ONdGkt3szpPSHQ5y0nRR4Z28sLqX8B8n5A?=
 =?us-ascii?Q?xOIstoCXkzWmo0MODjBvosZQ9b4ivZ/aNAVkYdU2+2vxYN5ypIsfEsAnur+U?=
 =?us-ascii?Q?/on+fXfP4anMJqyHFCx1asemT1Sl/c/C3lVkL6T1nryeYTW6g6jQHhZgqnlZ?=
 =?us-ascii?Q?PS1rz1EfQgZbSWEU+M6jwO1K/M65mravTBIYXPglGXjg9wtB2bp8lgivhAbz?=
 =?us-ascii?Q?ULbSuH4vabgJOq/zJt0HorFOHZwOdK2nk0cfvIwnXlo3+DpsON25vNsiNfL6?=
 =?us-ascii?Q?7oxCUbqhf1MwSZ4xf/l8sN9xWqn3K5hOhELxdO6LTPrHTRYHbdOmkTLNmEpC?=
 =?us-ascii?Q?dMfFDP8Zfv5znqC9U2kTFFc+3vH0dpDMyQm5HPzV78UFUsSkzCki1I0d8FRv?=
 =?us-ascii?Q?Oq8SLH602ovZQ0O3+lrqu7FI8TZU/k7EOILNLuYAGo35X8aZHKPncACJmlgo?=
 =?us-ascii?Q?l4vienDrDAgBCqQv9f85pdxIl5l772MSidbf2VJfz4W0Oa782iGWSf0kQkuH?=
 =?us-ascii?Q?zJis2ScaYl58Aucxl4SCkWWStApbiKk8dyxZ39yYxDBEJ9fFA7DWVqxYo5SP?=
 =?us-ascii?Q?gWg6KX6HguBrzjx/x58b4ykk9wkTeei8jW6os75iBzqJ0OMzghjXopojLVFf?=
 =?us-ascii?Q?6iEXEAe8flE0vahWzRIF+qY+f466W6pv0HDZjJ8Gjsbhxe8hsigRfLOle3nR?=
 =?us-ascii?Q?ycFD7B+dpStO0BGFBct8HcxuBCQGHdDVOq7VkeH4FjCnt+R7EzBjbm1Mdkuc?=
 =?us-ascii?Q?Cn1l5iwWOQSRBfzLP1BNilUvwsOMSkeSOuQs3dE0CdqHenHuTiog/HKxEiLw?=
 =?us-ascii?Q?dBLayVfyEGfqo13QuGgOoPbW8ynKzXBA8mA+Pec+VNP5rRslfkfe1OPiGpHC?=
 =?us-ascii?Q?/uk0PnhbzlmpmRZw/N1rgwy7xh2eV2vfx1ju2QFab8AFeHbdoG0iZhdTnlma?=
 =?us-ascii?Q?2hfAtURBmMpdFc+7x+uUan4+PB27LgZyExBM/lJGTmHMvEweEzkxeYiaSGeI?=
 =?us-ascii?Q?O/Gb05tlP920u/CuJ4AFh2k5yVIPeMkaeHwp3ff+WFTYu8Npj7rkY2IqMzpF?=
 =?us-ascii?Q?rA+KBPMFGz4Qep1r+j5IycJUaXRiYWGaZaFHH3UlwSb3Stthd/xWhYd0jIeB?=
 =?us-ascii?Q?CkxU1NgJoRQ62ll8u9H4v28DlHFRN9w7gh/sYF+Oub31PnM2JTaxRpTfpLXZ?=
 =?us-ascii?Q?bMkmCS0xt39e18PdMNUbIdtjaFy5hGuo7QAaCTKkVLBqD9DqaSdQmeyRxSzN?=
 =?us-ascii?Q?a35VLnUBBSI9fSg0p08apPfzRVXIedgq3WrivkYl96LNoTEyCxH0G9Kj/KrO?=
 =?us-ascii?Q?DbRdW0+ZxSCq6m+Ket0yvfj1BW/G09T3nu+upTiEt0Dhh7cysRMmjOGrCUA2?=
 =?us-ascii?Q?yeGQAnWdVgmQ9XsJLhJM/GfJOm9ysYCy9l5hTjjQV4FN4T0LwtUP8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(1800799024)(52116014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nhnuytLGYFS5d7qgp6gbX3shkhoTlR6r3lxaoA+tj1j7thyjQ+V6wbZOZJ8N?=
 =?us-ascii?Q?xwm6x4BOW5BL2MY+JEz0kPmDiF54+xOiWw0zbKFW3msNTModRIgQFlbl0kHy?=
 =?us-ascii?Q?8Q4C7DRniBXeHXibfd4S6EQiWQ5RD7hHyWda4R3S0VB4O1YOnd4qGMahIyfo?=
 =?us-ascii?Q?hG6YnDbBp6x70mDTn2dK+kDdE5vMH/L6Z8snQyj/UMH9kKChXTv2MHdEcvXq?=
 =?us-ascii?Q?ISGCrBzmyrGlKQUy5fu/IRjEs4qh7hmirk6MMs2u+CQp4Tl0yXvnl7uu5T5B?=
 =?us-ascii?Q?0/vZrbLvAMphU4quKMCZ2rzgJfVLHhyCl82YwYq32WJaT2F+NdK0Lpuq728f?=
 =?us-ascii?Q?9EZIROrn5s/IehKJabJ7hQ5/YpRd4XW0vtNrcQRHxYq/1r1TbUtb+SdqztlV?=
 =?us-ascii?Q?Jwp8/xbytwzSKV2ExVMV7/D8R4qVqo48tCWxTRQRCd0MGeiEp/O1skT1z4pt?=
 =?us-ascii?Q?Sli9b+4oU0uqyO+ET+LsQa7HIVZhPumrOYvZLuEN/DBvwAtEjbkjZw+DNy8R?=
 =?us-ascii?Q?FICNxL84dtayneG28ykhlJCDhoItcihMabSIBbDpMAtVJQqFPclGtoKjwgs4?=
 =?us-ascii?Q?fxS48OCduiHcSqcyTyqcyyuOgHMjFh0T1LXLa+0J3HjCohNyNBT5+KGskiVJ?=
 =?us-ascii?Q?DYB2IjBy6IgFTeaKa5ECRr0L9AypmGb5BjhkCAGIL/d6ZjG2kcW5JQoTvXqo?=
 =?us-ascii?Q?Y6duXkp7WHO1aAjMQiaIp1PJpNWy9YRMJ+5OXoJWu/9EKJpOKQdiklS+6TGx?=
 =?us-ascii?Q?13PuMkb4ysicJo1sCEQ0C/PrYqtue5P4kGR5uhogAo5yxWux/CxLZV+6y6yn?=
 =?us-ascii?Q?SqPba39Ce0nHy/dSo4sHJfvOot4/iYaPqxeZeh1hZrRqv4JPAHsOoWn0QrpV?=
 =?us-ascii?Q?9KAHNOS3KVnVanYifYSUcI+zj8+lefKqbWpbIgV5B37FdHfv+JJ9h6UWs5pv?=
 =?us-ascii?Q?zOYz2PHuyAergo5M+XdlF8U219YHi+XtMJfkGhvdL4wYAdVGVrR0cVhSWxX/?=
 =?us-ascii?Q?y6XkRfAvpemX19Xv+V0OMMb35oScLhNf3KDLjTZ2kAuzzs75d3Tt8hMs9pLE?=
 =?us-ascii?Q?Um1eB1BD8I2ScAfpMlXva+1viJLREm/T6VtlB4DzqqPTkfVv+Aig8lJdaLGO?=
 =?us-ascii?Q?9wsxaEcR038CCrLk21gpHSr6ODyKpN7qtbkl9lnqmhp7h5e9XJjADR6G+VRJ?=
 =?us-ascii?Q?mhGnGRIRgfgXTc+rgQjdFJq7q+aNL5YGcUjZEyvBjwya256t/wcOpUI5LKqq?=
 =?us-ascii?Q?X1dUi28FOtkqWmzCH/7ETtqBnCqFBdRKvnsycDvnvI/O8bjSTKAljpwwtbx4?=
 =?us-ascii?Q?9X7nq9kSZPYzvUkvkOQ8UL6otUyNpLAkrpQ5Rfi1Kte3AZETTUlCT+YAe4/G?=
 =?us-ascii?Q?8nUnXJSv9+AJVBtzXMb142UfghTmhObj9kkjN1DpQ9lgT5gM/hAw8YsYwxMA?=
 =?us-ascii?Q?hJXNS6xl7+wsH43FSXKzl7y3cNg/IoRjqBqx2/xwJ0syOfGRyejPap8v9WgJ?=
 =?us-ascii?Q?EmrtVPPFzMasA0EUUcOgM4yPx+uDZYqEgG9FjxRB5ODriSm/qKjAg6xyX1Pk?=
 =?us-ascii?Q?PGXK4yNF5aUHn8IJ2RBh0UvKbR/FUfOYztaV5V9v?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2415b783-fabd-4a47-b2ab-08ddf6d04968
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 16:27:40.4607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncOhd4JbXU5IKIZrlgtcAQDNKgy/iQ4csMW1iBgBEbgfDxFKA5S9JrrBoki8TPRaH3TMthiJgBD/e1Jc/mADzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7883

On Thu, Sep 18, 2025 at 03:24:27PM +0530, Durai Manickam KR wrote:
> Add support for microchip sama7d65 SoC I3C HCI master only IP.
> Features tested and supported :
>            Standard CCC commands.
>            I3C SDR mode private transfers in PIO mode.
>            I2C transfers in PIO mode.
>            Pure bus mode and mixed bus mode.
>
> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> ---
>  drivers/i3c/master/mipi-i3c-hci/Makefile      |  3 +-
>  drivers/i3c/master/mipi-i3c-hci/core.c        | 28 ++++++++++++
>  drivers/i3c/master/mipi-i3c-hci/hci.h         | 12 ++++++
>  .../i3c/master/mipi-i3c-hci/hci_quirks_mchp.c | 43 +++++++++++++++++++
>  4 files changed, 85 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/i3c/master/mipi-i3c-hci/hci_quirks_mchp.c
>
> diff --git a/drivers/i3c/master/mipi-i3c-hci/Makefile b/drivers/i3c/master/mipi-i3c-hci/Makefile
> index e3d3ef757035..f463afc4566a 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/Makefile
> +++ b/drivers/i3c/master/mipi-i3c-hci/Makefile
> @@ -4,5 +4,6 @@ obj-$(CONFIG_MIPI_I3C_HCI)		+= mipi-i3c-hci.o
>  mipi-i3c-hci-y				:= core.o ext_caps.o pio.o dma.o \
>  					   cmd_v1.o cmd_v2.o \
>  					   dat_v1.o dct_v1.o \
> -					   hci_quirks.o
> +					   hci_quirks.o \
> +					   hci_quirks_mchp.o
>  obj-$(CONFIG_MIPI_I3C_HCI_PCI)		+= mipi-i3c-hci-pci.o
> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
> index 60f1175f1f37..cb0673d62c03 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> @@ -8,6 +8,7 @@
>   */
>
>  #include <linux/bitfield.h>
> +#include <linux/clk.h>
>  #include <linux/device.h>
>  #include <linux/errno.h>
>  #include <linux/i3c/master.h>
> @@ -651,6 +652,9 @@ static int i3c_hci_init(struct i3c_hci *hci)
>  	hci->DAT_regs = offset ? hci->base_regs + offset : NULL;
>  	hci->DAT_entries = FIELD_GET(DAT_TABLE_SIZE, regval);
>  	hci->DAT_entry_size = FIELD_GET(DAT_ENTRY_SIZE, regval) ? 0 : 8;
> +	/* Microchip SAMA7D65 SoC doesnot support DAT entry size bits in the DAT section offset register */
> +	if (hci->quirks & MCHP_HCI_QUIRK_SAMA7D65)
> +		hci->DAT_entry_size = 8;

#define MCHP_HCI_QUIRK_FIX_DATA_ENTRY_SIZE_8

	if (hci->quirks & MCHP_HCI_QUIRK_FIX_DATA_ENTRY_SIZE_8)
		hci->DAT_entry_size = 8;
	else
		hci->DAT_entry_size = FIELD_GET(DAT_ENTRY_SIZE, regval) ? 0 : 8;

in case other vendor have similar problem.

>  	if (size_in_dwords)
>  		hci->DAT_entries = 4 * hci->DAT_entries / hci->DAT_entry_size;
>  	dev_info(&hci->master.dev, "DAT: %u %u-bytes entries at offset %#x\n",
> @@ -661,6 +665,9 @@ static int i3c_hci_init(struct i3c_hci *hci)
>  	hci->DCT_regs = offset ? hci->base_regs + offset : NULL;
>  	hci->DCT_entries = FIELD_GET(DCT_TABLE_SIZE, regval);
>  	hci->DCT_entry_size = FIELD_GET(DCT_ENTRY_SIZE, regval) ? 0 : 16;
> +	/* Microchip SAMA7D65 SoC doesnot support DCT entry size bits in the DCT section offset register */
> +	if (hci->quirks & MCHP_HCI_QUIRK_SAMA7D65)
> +		hci->DCT_entry_size = 16;

The same here.

>  	if (size_in_dwords)
>  		hci->DCT_entries = 4 * hci->DCT_entries / hci->DCT_entry_size;
>  	dev_info(&hci->master.dev, "DCT: %u %u-bytes entries at offset %#x\n",
> @@ -753,6 +760,10 @@ static int i3c_hci_init(struct i3c_hci *hci)
>  	if (hci->quirks & HCI_QUIRK_PIO_MODE)
>  		hci->RHS_regs = NULL;
>
> +	/* Microchip SAMA7d65 SoC supports only PIO mode */
> +	if (hci->quirks & MCHP_HCI_QUIRK_PIO_MODE)
> +		hci->RHS_regs = NULL;
> +
>  	/* Try activating DMA operations first */
>  	if (hci->RHS_regs) {
>  		reg_clear(HC_CONTROL, HC_CONTROL_PIO_MODE);
> @@ -788,6 +799,10 @@ static int i3c_hci_init(struct i3c_hci *hci)
>  	if (hci->quirks & HCI_QUIRK_OD_PP_TIMING)
>  		amd_set_od_pp_timing(hci);

It is worth to add a callback set_od_pp_timing() instead of use quirks.

You can create patch change existed amd one, then add mchp one.

> +	/* Configure OD and PP timings for Microchip platforms */
> +	if (hci->quirks & MCHP_HCI_QUIRK_OD_PP_TIMING)
> +		mchp_set_od_pp_timing(hci);
> +
>  	return 0;
>  }
>
> @@ -803,6 +818,16 @@ static int i3c_hci_probe(struct platform_device *pdev)
>  	if (IS_ERR(hci->base_regs))
>  		return PTR_ERR(hci->base_regs);
>
> +#if defined(CONFIG_SOC_SAMA7D65)
> +	hci->gclk = devm_clk_get_enabled(&pdev->dev, "gclk");
> +	if (IS_ERR(hci->gclk))
> +		return PTR_ERR(hci->gclk);
> +
> +	hci->pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
> +	if (IS_ERR(hci->pclk))
> +		return PTR_ERR(hci->pclk);
> +#endif
> +

Use devm_clk_bulk_get_all_enabled() can be comaptible other platform.


>  	platform_set_drvdata(pdev, hci);
>  	/* temporary for dev_printk's, to be replaced in i3c_master_register */
>  	hci->master.dev.init_name = dev_name(&pdev->dev);
> @@ -836,6 +861,9 @@ static void i3c_hci_remove(struct platform_device *pdev)
>
>  static const __maybe_unused struct of_device_id i3c_hci_of_match[] = {
>  	{ .compatible = "mipi-i3c-hci", },
> +	{ .compatible = "mchp,sama7d65-i3c-hci",
> +	  .data = (void *)(MCHP_HCI_QUIRK_PIO_MODE | MCHP_HCI_QUIRK_OD_PP_TIMING |
> +			   MCHP_HCI_QUIRK_RESP_BUF_THLD | MCHP_HCI_QUIRK_SAMA7D65) },


don't suggest use cast this to pointer. You can define struct

struct mipi_csi_drvdata
{
	void (*set_op_pp_timing)();
	void **set_resp_buf_thld)();
	u32 flags;
};

static const mipi_csi_drvdata sama7d64_data = {
	.set_op_pp_timing = mchp_set_od_pp_timing;
	...
	.flags = MCHP_HCI_QUIRK_PIO_MODE;
}

.compatible = "mchp,sama7d65-i3c-hci", .data = &sama7d64_data

>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, i3c_hci_of_match);
> diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
> index 69ea1d10414b..e57f8d85402c 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/hci.h
> +++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
> @@ -37,6 +37,10 @@ struct hci_cmd_ops;
>  /* Our main structure */
>  struct i3c_hci {
>  	struct i3c_master_controller master;
> +#if defined(CONFIG_SOC_SAMA7D65)
> +	struct clk *gclk;
> +	struct clk *pclk;
> +#endif

Needn't it because both are only used at probe funciton.

Frank

>  	void __iomem *base_regs;
>  	void __iomem *DAT_regs;
>  	void __iomem *DCT_regs;
> @@ -144,6 +148,12 @@ struct i3c_hci_dev_data {
>  #define HCI_QUIRK_OD_PP_TIMING		BIT(3)  /* Set OD and PP timings for AMD platforms */
>  #define HCI_QUIRK_RESP_BUF_THLD		BIT(4)  /* Set resp buf thld to 0 for AMD platforms */
>
> +/* list of quirks for Microchip platforms */
> +#define MCHP_HCI_QUIRK_PIO_MODE		BIT(2)  /* Set PIO mode */
> +#define MCHP_HCI_QUIRK_OD_PP_TIMING	BIT(3)  /* Set OD and PP timings */
> +#define MCHP_HCI_QUIRK_RESP_BUF_THLD	BIT(4)  /* Set resp buf thld to 0 */
> +#define MCHP_HCI_QUIRK_SAMA7D65		BIT(5)  /* Set SAMA7D65 SoC specific features */
> +
>
>  /* global functions */
>  void mipi_i3c_hci_resume(struct i3c_hci *hci);
> @@ -151,5 +161,7 @@ void mipi_i3c_hci_pio_reset(struct i3c_hci *hci);
>  void mipi_i3c_hci_dct_index_reset(struct i3c_hci *hci);
>  void amd_set_od_pp_timing(struct i3c_hci *hci);
>  void amd_set_resp_buf_thld(struct i3c_hci *hci);
> +void mchp_set_od_pp_timing(struct i3c_hci *hci);
> +void mchp_set_resp_buf_thld(struct i3c_hci *hci);
>
>  #endif
> diff --git a/drivers/i3c/master/mipi-i3c-hci/hci_quirks_mchp.c b/drivers/i3c/master/mipi-i3c-hci/hci_quirks_mchp.c
> new file mode 100644
> index 000000000000..f2e54e6643c0
> --- /dev/null
> +++ b/drivers/i3c/master/mipi-i3c-hci/hci_quirks_mchp.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
> + *
> + * Authors: Durai Manickam KR <durai.manickamkr@microchip.com>
> + *
> + * Microchip I3C HCI Quirks
> + */
> +
> +#include <linux/i3c/master.h>
> +#include "hci.h"
> +
> +/* Timing registers */
> +#define MCHP_HCI_SCL_I3C_OD_TIMING          0x214
> +#define MCHP_HCI_SCL_I3C_PP_TIMING          0x218
> +#define MCHP_HCI_SDA_HOLD_SWITCH_DLY_TIMING 0x230
> +
> +/* Timing values to configure 9MHz frequency */
> +#define MCHP_SCL_I3C_OD_TIMING          0x00cf00cf
> +#define MCHP_SCL_I3C_PP_TIMING          0x00160016
> +
> +#define MCHP_QUEUE_THLD_CTRL                0xD0
> +
> +void mchp_set_od_pp_timing(struct i3c_hci *hci)
> +{
> +	u32 data;
> +
> +	reg_write(MCHP_HCI_SCL_I3C_OD_TIMING, MCHP_SCL_I3C_OD_TIMING);
> +	reg_write(MCHP_HCI_SCL_I3C_PP_TIMING, MCHP_SCL_I3C_PP_TIMING);
> +	data = reg_read(MCHP_HCI_SDA_HOLD_SWITCH_DLY_TIMING);
> +	/* Configure maximum TX hold time */
> +	data |= W0_MASK(18, 16);
> +	reg_write(MCHP_HCI_SDA_HOLD_SWITCH_DLY_TIMING, data);
> +}
> +
> +void mchp_set_resp_buf_thld(struct i3c_hci *hci)
> +{
> +	u32 data;
> +
> +	data = reg_read(MCHP_QUEUE_THLD_CTRL);
> +	data = data & ~W0_MASK(15, 8);
> +	reg_write(MCHP_QUEUE_THLD_CTRL, data);
> +}
> --
> 2.34.1
>
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

