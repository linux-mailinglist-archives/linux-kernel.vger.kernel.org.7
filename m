Return-Path: <linux-kernel+bounces-807268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E6BB4A256
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065024E5C44
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029CC303C81;
	Tue,  9 Sep 2025 06:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gKzU28uW"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5DA302CD9;
	Tue,  9 Sep 2025 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399640; cv=fail; b=p3QxmzCS5J2nrZTTcpT3jG1i+BWvTHp1iu8sdK7Is+ROKzAvZax23nS/2082cQtoPCEdTBO9H+FjT1Xk5nW+ZMHvIxqaHjEqLZy/AnMaFJ5i2xrkM0anVNKSNAgaG/sxrXaDiZMwH3zmfIPN7JGkoCUYMQ4IB2L7m95hFjDHfHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399640; c=relaxed/simple;
	bh=NqAEL9L7HGQdtstuCqnYf9tBmx7lDMRGDQPAYRau7+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iT9cK9zXenyGYRKV6iR4a9szbvqXFAD4pdPYbMlsJq1hIgTYFSPPXWt3gTa98hL2JdCNn2NkKeHWjPvM+0XowL616fZ0lAcFJpJ2+SSRYr0J3HBpVtyaPUZhjbwqhS5TlK5h1MMCK+xlHIYyA/Kq+bORW2WcdeatNhh2OuPJnIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gKzU28uW; arc=fail smtp.client-ip=40.107.130.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4EBoTDTiwmnz39aVlsdgtY8hTdOUhZzM16sViruIGHQD9v7g9XwduEwg6Dp9ZLX1vy87s+gK8tgTHFCjLnUoI0lK4BflgDwI4qR2snLWu9I2/v5N9SKtVrsM+2zSxvTZMbuXfNpAiZeYMYgDUpO7QZg3p1cJh8P0BvU7RllBoQAL6HyUZLIdJbXgRnyWn2F1gOWq/x7keWzYFTDdIusplC3c+SgYqbx0PXwNUP5R5mqfkCd0TdA3wsEuKF+U3a+5vqTk5Gje4jnEUx+gX48SqwmQmF+uXuLAyJPX8S78YIrUdFo9ca761fwZ18RJPR3vpZPGCneYn+3/+X3vlvrrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9P+UtAULenAtDmfoHDqCK8cxA1Aint7GtHE7LMtZiK4=;
 b=JJ7ThrG6Lj4bIMklmApHvVh+inZMZBFIERyCVL8AvZO8j3EnAFGhtowk1DioS3+EEp/pdth+4/6mcrLFgSxBZZJgxOBAS4+zc5F8rsLJGFe+83bhGGf6oK8VnoUDBlwV6vlRwbQ7tBzDwtxYrRQ9O8PIGo4mL8k4OKXD9C3Zn4r2DaMWwzRpMzpvEh38PWH7JW3WAHyyqxoXUqGBbu+X67dLHnDeB9HzxEBm6iBV4LE+pHUb7xsUq57XsDWJH/m5og5wSBC4lM0gvYpHqmWKrOTOBwXmybdaQkCkMc0jPp34G+madOu8mV6sKdVsRuPRSlEubIYPhfixQAhgfyE/Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P+UtAULenAtDmfoHDqCK8cxA1Aint7GtHE7LMtZiK4=;
 b=gKzU28uW1yegDrH7tbfs8pvX03nue9UYpANOtSDSuZYup98O0evFQE5GmukuBi/UncbLBlrTDI08P+J++P52NFHVZ3y9kP86rVqI0C0cpCW45pjue6aiN/V/YMyXec7NZGrusjBLHGJoDoeuFM9MYyX06bg2zTtQ8pZs5IUhBsmxSOtYc4KB+l0PN4M9tH1JagkHk+3mYpg1GfHZZz9n8Xqky2uGFQettHv7Nq42k5KIiz9rAAFXmy73Xqyt9tzO9a4WQFOKD+bkpdE7gHHK1C1/1rxqbwMG+KVuS+ytC2B/8ylFM8up4/LWsE5lQOgxONPHbdQVYw2hK5V0coFojw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU2PR04MB8744.eurprd04.prod.outlook.com (2603:10a6:10:2e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Tue, 9 Sep
 2025 06:33:50 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 06:33:50 +0000
Date: Tue, 9 Sep 2025 14:27:55 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Badhri Jagan Sridharan <badhri@google.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpci: report connection status for non-DRP
 devices
Message-ID: <onbkvlvsljeco4nfpt7mkg3bsbxkzg76ppue5huxypd4efyxoh@otlo7zb5ty27>
References: <20250909-tcpci-non-drp-connection-v1-1-e09c7d877d44@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-tcpci-non-drp-connection-v1-1-e09c7d877d44@oss.qualcomm.com>
X-ClientProxiedBy: SG2PR02CA0081.apcprd02.prod.outlook.com
 (2603:1096:4:90::21) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DU2PR04MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e574afd-a58d-41a9-0d14-08ddef6ad633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lmdu/YIDkr7bSe/IGdKqkf/B+d6cBjDC0DAktJ1ZXEIn3c0w6R7Qmx4d+ymX?=
 =?us-ascii?Q?/L8g8Ozb9HOg6ICatqEiw/UG8uVOiUg4167CndDLEExtT9tl9oYERZEHIOLb?=
 =?us-ascii?Q?nQl0k8JJi9NSs9Ap+DcKOsK2PyZTxNOuV3fMHj5G3rIUCkiiDcY3ZoYE0vSG?=
 =?us-ascii?Q?FG1HlbhLzojA+DjXGCHLY/oJV9M3i3o9bl6y7U590n6EyLq4AuyNC+A7PQzp?=
 =?us-ascii?Q?8x/B9Kvet/ZBqh0CjeYxHBpS0d8Bt4aMnMFVMkU7fdSMmhqGDQFllAiNbEM4?=
 =?us-ascii?Q?eyCiZBkjV8ZK366eVLZ53aSHKOT3ZcWaG0mFJerWUW27SA3+VTyN5/ZqYttV?=
 =?us-ascii?Q?tdoyIQihwcsYWuV/Zgi8pbAUNaNJ+sI1AeeSAyrQ69M/BRcDLqbigivxNys0?=
 =?us-ascii?Q?llco/BHI/kghgWeWA3vKOBp7250yLqNUBt3aAVoqY1DvgEY7boYU+Dm1wIf0?=
 =?us-ascii?Q?r5hHPcWxevSNfcrTxwVwzd2Y50SiP+huwbAu7SpV49cXNqEBTXnlSAOUtNpN?=
 =?us-ascii?Q?MY1FVWHS8ZNRUiVXpvtUEA5neAyiCf6SaDB1txsKI3ySNNrZbQFcoPG9y91t?=
 =?us-ascii?Q?7iw1GH4S6F4lfkSFUt5CsGN197CSPjEXln0zs3Y0+kLYJYAm6ec+j0s5SqLT?=
 =?us-ascii?Q?ybznrLhxoHDqd9iJ9o2X9tv7T/fPgDGaA2jD5AIKgPh50YOR3dwfRauRiAmk?=
 =?us-ascii?Q?hbmzDauZxIIL5mBXxSCPcMUKo8p1Fzxn3XiGXqDXBbsMvgee2TLErkef2xEg?=
 =?us-ascii?Q?NJFTXFGhglHTimNd7bXYq/uzSNBF53MJ2uW/77p5i15orHU+g6+FOhXIA76A?=
 =?us-ascii?Q?ZfJNvaTZSi842qcVfI6tdRDRyk63QWPglDhYdFryoOIpUySnsvMRsBA7qSnc?=
 =?us-ascii?Q?POVArma7js1WcwQXyC4ck3RAXTMyDStcGRTOVdqdu1/K7mWGjbBzBx0eOLhD?=
 =?us-ascii?Q?DxBi4SGuy4aVE9LX7+6bd1YvUHrLWy9CY3Vw9zd3Z5tqwy8lJIP/fT8mlMrm?=
 =?us-ascii?Q?1T847TI6d5fhlj2JFoSK6a87n7iXf8AUoBWg+A9FClvlZA+w2hulPbslorct?=
 =?us-ascii?Q?juKabO6UqxLWcV8GyL3WDrur1UgPJRfLEpCzoYLxrvtZSOxjmJ22IOxqZgG3?=
 =?us-ascii?Q?EXnNHstY4jsKt60rOwbO3aANYzIeI+U8LRuyyRKHvi+FnKJtUotcS5gDKKyj?=
 =?us-ascii?Q?4maiirZ6JCCHbO8LgxPzcB5enPvykUogK9nPBbRwKPYd13vlnj6poqRvD8uk?=
 =?us-ascii?Q?a3sioGJp4588W7H9aAGfF01S2FzE4D7P5L9ucLmDDCr/bnd+zb0XNjJCleLw?=
 =?us-ascii?Q?5O198jhNgvYgZXKmoYqYkPetvi2pnMsQG9RybjliUuzK0CVdAp3o+u2cImZH?=
 =?us-ascii?Q?26wg9DqcBDlze/Ix/F/fjVVKBdTkn99cAiwOogWRYnrE42KB9hJpidSb2wGt?=
 =?us-ascii?Q?Ez2QMSrDFmhyvSda0yiutZwAsiik/NZsVi8A2tBy625J8EqioHW11Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aUR6fjuKNDvQovD6Q5c17FM718KKVuurh/jgCM/9+d/a54Ootkl/zg1dwucZ?=
 =?us-ascii?Q?F8spTROc2t6XsmphjrqpLmt2dp7soDZSwnC892hCk8ugEn87fWwph/lVfo5K?=
 =?us-ascii?Q?K1L6wz42mE8xEMC4VWc7jQHyXwNUUxR1WX2N31XCE6eibcXPXurRUgqBr45H?=
 =?us-ascii?Q?c661RlRs0TuDa0F2xahylZf/aCucTTTh2LQCvgbDoBDyhEqswSWhXXWQQ16E?=
 =?us-ascii?Q?pzsZ02m9DSftNPUyNIc67BnOH71QlMOXr5uy2cfjRjyqd5q1quglPyowGAZ5?=
 =?us-ascii?Q?AvYMXImbQ4FB6st3UnftIc4xKNzUyfrOj61h0gk41PKfSw7eDfy+lCQ+PPx5?=
 =?us-ascii?Q?7nBUHvXb+cT6r5kHELXO9XzQtN5UW7nZvz6IUn47GbFMHA3GOEpLnZBQWF8h?=
 =?us-ascii?Q?RlAjimI8LSQ7oIBI+HbCZeOWQGouXm4vQApRdz1O3YYjh89MLkrd0MAL+BhB?=
 =?us-ascii?Q?NF4gcXkzo9MHglURGo3QYrdE6fG9JeMC/vhDsz2x5WFBxGCAzOiXTKSM1oUm?=
 =?us-ascii?Q?Yd/Q6md0uxmc4BNe985CGRwZXtVl+Uxa6FGHNaCotdVcIinZ1ir9T+OlbttP?=
 =?us-ascii?Q?Z051aH6qp4Dkz/H6NjZW5aGxECKT3ZlUSMTardxExoK6sq8F8I6dsrlO5FYL?=
 =?us-ascii?Q?5pF9De16WkVyG34A5uuPgr4nhoMx6gKmIAvUkAQXWZbUj7pffbXNbn0nvg0E?=
 =?us-ascii?Q?DCJrJYh4j25L8NxAJu+yrlTLznIS5sCrzEF7/dbQJD+eL+hgDfPuPC2GvV5L?=
 =?us-ascii?Q?M2keaN9QzLI4gdqtf1WL+sQ65erheLOJhRTqsjzj7VnT7tSmOJoCt5QgfzMb?=
 =?us-ascii?Q?kV8x5GYiTjwVkLwnW+LnfOxsS0OFA86YkUnkLaNgMaRuoyloT/lNqvnfbZTy?=
 =?us-ascii?Q?VsbKLinOW6hmOhVtokaGLhHeWPier1bfzfdf2Hb43i5HGT/zuh0uREibEurQ?=
 =?us-ascii?Q?t1BXpL+3bmQgNpKy6apytwXSCjccdnFAftrqHV7L6SnUs7VKhu6h22nxCJKP?=
 =?us-ascii?Q?6uvXk9i2gKApf9y7yNa6DWDddK61YcwnaJNuKY8MlhOQlur+/IgBhphwo2lj?=
 =?us-ascii?Q?tDeP0bCtskbkM2+HYO5sUXqiRr4WPvjGcqG7/ZS5I42cLRKeUU4J9XI3xBUC?=
 =?us-ascii?Q?AUmf3WEX/MHals0CRpdOYyifyNyWuPHV3W7sJw8j+6Ej6X93ATQFKdhimAxC?=
 =?us-ascii?Q?tVulaIOSLSwb0j88oVt7xlnW7w2Mri0D0xne8U31tgpT+8elnUgtF4j1CHdh?=
 =?us-ascii?Q?aVWgo6okOJqU+Z61E45GM0gabgz6z9nPQRSDCuqIBYRkVyLzlxzk5WYD0xQF?=
 =?us-ascii?Q?FXqPy8AAzPHrjpNxhLfWZbLxNlQs5QNQhHU1A6DtbfdRT/it1Twpo0bQKpWT?=
 =?us-ascii?Q?LEKn8drCqTMyc4t8KQTS5miTSP1KIX/urZ9ZmdAFW6oNqJdcI3BTpUmos2DZ?=
 =?us-ascii?Q?EErEbr1tECQdTY3SU87vTsKI7GlzcVQrRDsyEDNjqW8WYLD8LJ1b9i2np15n?=
 =?us-ascii?Q?DG33sRKF+SGmGeeqQdh52e5rx5smlgaIbV0HMggndg0JZwH/Pi2PkgNFBAnS?=
 =?us-ascii?Q?uiLzci0Eg1+cqHTwpbF5rMbA0ebzta8/cONNiooI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e574afd-a58d-41a9-0d14-08ddef6ad633
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 06:33:50.0737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9+ePvhp4FW1hPpLrx15MTYU9B+imIBXjyiI8nh37YEE3jJ0Luv4stUYcjHTK+oy/lzoo1XNFrhgbiniCI4JBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8744

On Tue, Sep 09, 2025 at 02:36:51AM +0300, Dmitry Baryshkov wrote:
> TCPM core calls start_toggling() unconditionally, but TCPCI simply
> returns -EOPNOTSUPP in such a case, ignoring the current 'connected'
> status. Make TCPCI driver check CC lines status and report current
> connected status.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/usb/typec/tcpm/tcpci.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index a56e31b20c214fc509423d2f8602d3599c1dd2c1..9d57c73b49674858d799790c5c8cb0d929841def 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -178,6 +178,8 @@ static int tcpci_apply_rc(struct tcpc_dev *tcpc, enum typec_cc_status cc,
>  				  TCPC_ROLE_CTRL_CC_OPEN);
>  }
>  
> +static int tcpci_get_cc(struct tcpc_dev *tcpc,
> +			enum typec_cc_status *cc1, enum typec_cc_status *cc2);
>  static int tcpci_start_toggling(struct tcpc_dev *tcpc,
>  				enum typec_port_type port_type,
>  				enum typec_cc_status cc)
> @@ -186,8 +188,17 @@ static int tcpci_start_toggling(struct tcpc_dev *tcpc,
>  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
>  	unsigned int reg = TCPC_ROLE_CTRL_DRP;
>  
> -	if (port_type != TYPEC_PORT_DRP)
> +	if (port_type != TYPEC_PORT_DRP) {
> +		enum typec_cc_status cc1, cc2;
> +
> +		ret = tcpci_get_cc(tcpc, &cc1, &cc2);
> +		if (ret)
> +			return ret;
> +
> +		tcpm_cc_change(tcpci->port);

I suppose normally a CC change event will result in calling
tcpm_start_toggling() and then tcpci_start_toggling(). In this case, the
connected status will be reported by the state machine. So are you calling
tcpm_cc_change() repeatedly?

With this change, the tcpm log print another one log as below, is this what
you want? It looks like TCPM has detected an interference.

# cat /sys/kernel/debug/usb/tcpm-2-0050/log
[   26.804246] CC1: 2 -> 0, CC2: 0 -> 0 [state SRC_READY, polarity 0, disconnected]
[   26.804270] state change SRC_READY -> SRC_UNATTACHED [rev3 NONE_AMS]
[   26.806636] Start toggling
[   26.817832] CC1: 0 -> 0, CC2: 0 -> 0 [state SRC_UNATTACHED, polarity 0, disconnected]  <---
[   26.818403] VBUS off
[   26.818407] VBUS VSAFE0V

Thanks,
Xu Yang

> +
>  		return -EOPNOTSUPP;
> +	}
>  
>  	/* Handle vendor drp toggling */
>  	if (tcpci->data->start_drp_toggling) {
> 
> ---
> base-commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
> change-id: 20250908-tcpci-non-drp-connection-bacd9a5d24bc
> 
> Best regards,
> -- 
> With best wishes
> Dmitry
> 

