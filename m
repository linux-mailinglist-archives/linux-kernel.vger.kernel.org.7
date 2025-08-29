Return-Path: <linux-kernel+bounces-791958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BFCB3BEAB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29C758668F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A6B32274F;
	Fri, 29 Aug 2025 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZuiJwcTD"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010048.outbound.protection.outlook.com [52.101.84.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF34C322742
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756479527; cv=fail; b=UdW2nEjpzC/65WHEkQ/iAxEt6XGMcfhtWdO+oRpJ+438Vn6AuXAOhidnxfqOhvrANOXJg3ebzKg6BTWDp27EXlpHNaZHn21XYSzQjZm80UhvSJknKF2oX9UPedvN1YErCk1nBluX/PWLBQFyHex7RRJIUZdNlhM8CsyTMAXsPu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756479527; c=relaxed/simple;
	bh=mvdyjWqjATgmI4J8wemM22+1hLVHme3K2A8+fVVrAA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d49oMXXOgs7AfcNjD5YFkTp5t16sgHAfMyQC48986zELY9gXuJO7O5VDETFo2nkwz1CxKR5tEwsKBApKcOuYQ7bFGhyCIYa1jmGNXgo2YYDGIg1K6AiHQITFa/3IyD/cJ8+QW2ymjf68CJk4fx4YkHcWXluS5K8Pey3dUn8xSG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZuiJwcTD; arc=fail smtp.client-ip=52.101.84.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wi7rJ3bHU7thue+gHL4dnUitP53jmub09nahadK5ln3uO5Mx8NBb4OfBefTW+QIcTAwmt4AngPOVKJjeWqTAJCZ6e4/qNNN/jR9oFN0JPwtKqlQFTnay1YIU779/p72exQAqbyeW7DpNfIfV5ZTMnRpfR+Fu/0fGgHEtLH6SuaRevf7/v53/4Pk/egcF90DRssUu42A9u97CimEGgwD2j1o2kp8bWjfRtez8CbmrnV2zf8geZs5SbgMGEcPamvJXrbno8osbH6xmHop/CXFWgxgofFCKkbmlU3LgPDG0t3QTayzSnP/cXjWgzcX1c557xw7qFDDIiGzKRxbQ5Kavog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1AiWIKEakfMqGj+X8mFHeX13FcHe8s+s4/jtekanxI=;
 b=ggQjXd32NnJM8YXM5Yw0bSjwFDTBUGZWU4dYs6XvDtDtipu65Rd0fgumJoBn5ELNyyO9p/c6KIspC/2efDY8v3QifnUrTzniVY5ebo7OutpeQKaUCbaYS0F9sjrZF0W0aub+DPQe2QoYJ4WXcTf4EkwVJ91tMndIW9RyQxtuMeH5Bft61MCnbLEhX30mvvVjSGZunHW+eiQA3RAAnB+jyREUcmqkFGmbfvrxrTpWo72AWOOUNJ3id0VvZivuCmZisO7Le9ZgLQDXnVzRcJDToNUMUOaxDOkLPrPOB9C2uUza5fm1T5JQQmi7Kcw8CtyG93VJc3aFifmGkMDON2IONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1AiWIKEakfMqGj+X8mFHeX13FcHe8s+s4/jtekanxI=;
 b=ZuiJwcTDA0cbm2SUnyd3aEMGx09NxnY2hiRAopKwro9zUXe5SMduS1bAa1liqlpuV0i2a5xvQve3H/jMZrtP1GThNHMuoDRLq8nMJ2uc/M1qNDVVWZlflSZ+Qy/QErDw1LYQlpeFXU1ElOYkPTbP4sYrHaRLdDTB6QY0DI0tW/nODz3Y9s4l7bGddoCu+NB6qEKRS6H0F/rBQZOIcomK0CPJV39Dk+mBhAg25lMFyH4lmnJUOvuq1LTbWfpte+LoNephnrJ09yTpTdlsBP4kuNduh4MbbjJezhYkesXUlH7eGfjkT11EJ0npS54rLdxc0C/4/0lTTyp8XMymP3ZLEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI0PR04MB10760.eurprd04.prod.outlook.com (2603:10a6:800:25e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Fri, 29 Aug
 2025 14:58:43 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%5]) with mapi id 15.20.9052.014; Fri, 29 Aug 2025
 14:58:42 +0000
Date: Fri, 29 Aug 2025 10:58:35 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v2 2/2] i3c: master: svc: Recycle unused IBI slot
Message-ID: <aLHAGzrjooC65acL@lizhi-Precision-Tower-5810>
References: <20250829012309.3562585-1-yschu@nuvoton.com>
 <20250829012309.3562585-3-yschu@nuvoton.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829012309.3562585-3-yschu@nuvoton.com>
X-ClientProxiedBy: PH8P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::28) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VI0PR04MB10760:EE_
X-MS-Office365-Filtering-Correlation-Id: 09615095-bce3-45fc-4a3f-08dde70c8b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IM2po6nRmC45WtfCK0YVpcAtoSSGNPn/gCowkWSKhTREVP5b6X6p/n7QQAdM?=
 =?us-ascii?Q?j8wdVqHFisY6M0Qm6Z6sPQK3O8wJVlO1L//glPTs/Vf4gQ9xCGMgJbyiKNnm?=
 =?us-ascii?Q?D6yeFzg7+6wajixb9WI3V/lHJyhg3u/9opO55H6C9P5sJQ9c5DeoBgzkLIdF?=
 =?us-ascii?Q?F2hDgdY+SbVgJPLkUTnA7OWdFML7bPFi1Zfx+qEk74YHiBpyIchDVGzRcJvn?=
 =?us-ascii?Q?Ryyx8aNifYl1HvyT14OaibiA+DRxrQYd07RjAQszSg+q/BepYJD+j3Hhpi95?=
 =?us-ascii?Q?WTIYC21UsUnDst7o05jqHuJe1sIBu9gsfQ5Th78lop9nf+uRKDKhrRbvuG9V?=
 =?us-ascii?Q?B6ZCrQKP9r8mdRqVZ1AWiTcb/74/pOVHBATDKOkq8WLHwmelFk7yN14rnCuc?=
 =?us-ascii?Q?5Vzz2hMeTtYdaIjZAtw2Pde23/Q4USd/d+J5mn7wz3AAS1+ldVc9UIAHASuy?=
 =?us-ascii?Q?x9fZHLxCh7wuBe1FWkTGUgsi1rfnwX9kWZVTmvmQ1qOUCl5H9J/j8KKKd8ZW?=
 =?us-ascii?Q?OuXyO/5zHu7lNHnHZG1bmfh7X8vtXYgeeNYRoG4II52SN7YU0tbuT7XnmKpA?=
 =?us-ascii?Q?ty0OZ2iP4Pe5+5CGcF3ZnAYEMa2KxMmmuGRV0Sxfoeat8UqfuumYa/IYqFkJ?=
 =?us-ascii?Q?DwZobnYpLQjWXhZ0CKsYXjpdW/JwYPeDFaI2SNDkBPFTku8jGdj4HpX1u6Ex?=
 =?us-ascii?Q?7uA091VShYlxiZ7HIbEauc9WriTxt/QbajMr5B5v5Z1C3GNkUuE+819obpcG?=
 =?us-ascii?Q?JK01YDWkTltqGAMJN3cuJF7fHLcE1qMSzGB8YQxD73ivhRi6iIr152VRV7L8?=
 =?us-ascii?Q?hr+GMkjD3NMD6jB4oMePpPfLMvo+e7VZcfS4znNuAOGj22/peD2Ih/ONi4Jp?=
 =?us-ascii?Q?VaLL98zlJii8mwU0YFPpBowufy29aqCIojbJ9X18z/LHCpA1kuWf347fdUQ0?=
 =?us-ascii?Q?J87K/4iVpeGVcHKa69PGlwFy+Ey+lPW1hLWLvbjssnzXlcFZOL1CmkFoAF7q?=
 =?us-ascii?Q?H9rHgF0wBZ2FEUmdDg7xxG//q2mkpGZWlzrN5O4bMa837haj+4J0EUwGim62?=
 =?us-ascii?Q?GGt2h7qFzMZccwxUtJspzMZdNiDSMs4OxoBop78DsYaqVHKpCu4LQLSIkRiz?=
 =?us-ascii?Q?+OAmXhLtDCr0URoivTn7UfbpEwLkHBTEwH56C6LGaIcmH+AMrteJqOcluD7J?=
 =?us-ascii?Q?Cclm3Fayyxo1DlJNIFXA2s//R8VoHetsVu/p1gFHj1MRRKUd7Zf1A7lt0C69?=
 =?us-ascii?Q?J1qxSMM8p6PIDO5DxYUSH8Ixwssv0D8MzjVzAYmex7ijmpr1XkE5ww/YBuYl?=
 =?us-ascii?Q?cOr243FDMRwsxTxxmISq5uS+VRSaRGQ42GRP0t9VpRjS3FGMrQR0OjPSZRkQ?=
 =?us-ascii?Q?eh0/oiaY6jIENYnoQKN5hVdf4fkFOF09AHShvGtvjwutiP4+rlT5blWaJ6Nh?=
 =?us-ascii?Q?s06bppzMNcDFDYc4V+Ngu37577d8IwQDW+D9UuBhNt+WOV7+IRXT6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1+XzhVNPdCxsCfbr0wHWBFB2e9DaVYqTfOMrTV8n5WJiFwod3X2j4nVv1CTZ?=
 =?us-ascii?Q?Y8FdLEiHLWai0kpTs4w+j70Yrt5XnZ4T/5NeuN/tKEpZ+76LHd7NJi70PRz6?=
 =?us-ascii?Q?QUbgy9Dy0K5X9IQD7TGKnDott1CcAc+ExCnCKOnzbof4VMPy8uFs81wL0zHS?=
 =?us-ascii?Q?pLQvcJi7Tywx8Qw9vZmAN74pwPQ+VPzkMko4npg2cUdQlO3JgSV3PEWtkjvn?=
 =?us-ascii?Q?2ibGXwwkwbnLfM71z9QNPprkhUzjZ56ljEbD2Tnodn2uXyxgfq/SdJRj6Lyb?=
 =?us-ascii?Q?F0RbFuAnxFU96cM9FMmBfg6CHQeslmJJOTEGwXwpReOxf5wpuoJEMahSwgVB?=
 =?us-ascii?Q?ZDiY90nuPG5MdiBo/2JvlvU3urQPsQSY0UmGAsf8nQ9EnYwEtq95hUCjPF44?=
 =?us-ascii?Q?54NFy0Yic9V5cympoKNy9L9WVLUfhZy8ZDOqWn3lIWzQEATh3V9HIgmMNpHt?=
 =?us-ascii?Q?4mZcU0tu011AeM+/XZYAKEXx2FsJqNjnWDGk8wsFX/lYfC3LqET9DkdH3oWU?=
 =?us-ascii?Q?C1TbFuNnnPt4kkRZS1fMPaIfTl+z5KuHTYIL4Z6lMgnQKinw0Ka7vY6fWAhP?=
 =?us-ascii?Q?Qjs4Xf3WCXPei4j0FTnkMk0JDIWbWClC+RQaHESAbh0MSuRYiy0ASmtmZugm?=
 =?us-ascii?Q?uVpssgHYACV0LfjwOtxdHKFGnQJIFghnLd+qR8kxYNTN1R1r3hBD1YH9RXF1?=
 =?us-ascii?Q?B9gD8z9SiLUbwdtxNqAzktI8B9U3ALQQCwt81V5f0fJm5StONx35koIfhTFU?=
 =?us-ascii?Q?8ChEw3jcRhBS8MUKsoBMQm95zMQdIj7CBm2CHEewNYHf8eig6oUBl89dJn88?=
 =?us-ascii?Q?fwdLwUAhGCW51J5Ih+81mNnYvp76mF4y7DQhjm8Zf6XejIZYvdJ8vqTpYx7M?=
 =?us-ascii?Q?iSLiY7FQJHW93s42nq+EgWcWrycQsurdZe3vixixRqpmTridPOfic8yon1pI?=
 =?us-ascii?Q?n5RrC0W8ykZUHYxct/iiWeNgsb9xejNkcl9/Q5tTRj+m7bogKR1As+Xqr7M3?=
 =?us-ascii?Q?ArC4+Tvsom3y0rNedjxsfr3PaRb5tugZQ9StxTIQU7lraKRb6qEzS7GU5bu8?=
 =?us-ascii?Q?rOv4GOgPubB6wqxsQ9F7zPJj9BKY0wWi0bGu4I/P8OHKlu89hiJvzuOcJOBd?=
 =?us-ascii?Q?8BnnTxH76HRmhe2U6+Sxrqklq2/e/7XYMZ8OUtOVi4ygvgD9lPN8ScEltses?=
 =?us-ascii?Q?YfOf9tr7WIlrqdRp9xZ3gUI2f9UgAZCzhvDD97MwNpI/N1m+ArQf+hS2cHqX?=
 =?us-ascii?Q?UGpFXO+Yqp/OtZfQ/TnDd15ylxr3iuWHL4udclV3eOLa2/gRfrn4s2hUTCcn?=
 =?us-ascii?Q?LVggXJdfggIWmk/UiKYmI8n46zPedlda1RmD+3PItccu1Lf27+zMb4OoIQmZ?=
 =?us-ascii?Q?JFvECpls/jWqRUA1f/htfzAKKRqaNxrTUS7Zv9d3HusNf85HfkKv4CK8SOYQ?=
 =?us-ascii?Q?gO6YpWPqfbVajGLS7uBZXI80dEpa/vcyuo6WQelS3NTezvR/DGg8IFSi7HTz?=
 =?us-ascii?Q?64gSti0PiawNOUnkgL0usO7JNjiCLb1X1e0RnZ68tUS7FuJ+PnCjSgFK8BDV?=
 =?us-ascii?Q?NU1etuTVocvZimOoOfVQyWFtN4v2lvWaXDOVtpL5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09615095-bce3-45fc-4a3f-08dde70c8b5c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 14:58:42.2064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OArPFOsF6gXAiq3rEJZpVoYMaqpWLImjHNKUcRhn9UNdRcpJouPVQUAYHXYKe8HhnRofKNxzebxeKseLQJhow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10760

On Fri, Aug 29, 2025 at 09:23:09AM +0800, Stanley Chu wrote:
> In svc_i3c_master_handle_ibi(), an IBI slot is fetched from the pool
> to store the IBI payload. However, when an error condition is encountered,
> the function returns without recycling the IBI slot, resulting in an IBI
> slot leak.
>
> Fixes: c85e209b799f ("i3c: master: svc: fix ibi may not return mandatory data byte")
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes since v1:
>  * Add Fixes tag
> ---
>  drivers/i3c/master/svc-i3c-master.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 8e7b4ab919e3..9641e66a4e5f 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -417,6 +417,7 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
>  						SVC_I3C_MSTATUS_COMPLETE(val), 0, 1000);
>  	if (ret) {
>  		dev_err(master->dev, "Timeout when polling for COMPLETE\n");
> +		i3c_generic_ibi_recycle_slot(data->ibi_pool, slot);
>  		return ret;
>  	}
>
> --
> 2.34.1
>

