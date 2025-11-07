Return-Path: <linux-kernel+bounces-890335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7557C3FD2E
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE7A18938A8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACF62FC01B;
	Fri,  7 Nov 2025 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i7VR5jyN"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013027.outbound.protection.outlook.com [40.93.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9215421CFF6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762516511; cv=fail; b=Q6q22+kHRqnvvOGF4hVO5Dh2hgpZbZrLruF8BExnGMoIB3dWCfj3jdaYBRBUhGJcRhs6GT6I0e0v6Ybi2W40KI9NkPg8/v33vXxfN5VwMUstGYkjMTzhUagDGeWEp9Epc4VUW3NNeI7wiXOkwsxkNVQpNlnZ+UvTYLAYlKJ8Nv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762516511; c=relaxed/simple;
	bh=UHFHmX7NYbKRgcvvUSQYT53XGRZrD3Bau3yXRXLg6a4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gt26lJhMhEkcDAyVTOeVmZar9lbOKyGO6YFxtlFyzen1lhfCgJ3GicKlq/35ppJaDw9mh93Bj2ug2maCqhBWb9jRB8r6tMbcs34EL7P5ClWRr6QFXhOXB/J34bq2ckDypea9d1luEnfXEHAN4FEHPPdjptOanaT/Bh/oV9lNj40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=i7VR5jyN; arc=fail smtp.client-ip=40.93.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asxk7/W6HCzaS/leCdaoBroeCON7DzaEzoBcWMjfg1VsbzYEFE4gZHwEc9NYjvTpBD3fzqkZ8y8XseF+0Xd+faaLFzIM5HWccZm47DrYGKHHT5HVzv2BrpzbQRLwv0AHn+7MuCgjb6mGiajFt5vPzz9ec1Idz+UzkAbwf5+0W2a42S0S5uoGKjI/wMTRJMQktpo+m+YFXW9yqkbUWpwYf8rCa9u6FTKyP4NmMPHI5WW+IGXwdvSAg5LQuUkoPwWprB/dkAdlCyFyl+Q6wMfICGy/q8W9hR7KydKv6V2Gc+Y12ktOPWCIfNaKTc7dOEt0SgSTtvaG7TsVPdKUHT5l0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CctWZc9KKI9EMTpaspEuce9jJHj/hy5L7BzuBUUity8=;
 b=TymtY7SsnCNZ9LN62MCWGvMx5RDEJFIsWMULVC+/mOSCCsEyAm8fKrYydbzjWF0NG0tp38PlZkrOFE0V31gsAqSSxnLVzrp2EU46iXS/mJejxgoriMz2YZh8VkVpFd7ft6OgF/a3q8aQpgCaR5XhVyhAPR2wJ8knNairLayhB04/ioACzzhtKNHskEQkiXW2O8gTlvx93qxy9SIFllw/F14yVsRMDROlmKOqqHygMpROYuMoLqhoZrxLPv0KSNsxLbv28iGMQzhE9cNoik/+pinKfkbO6fx2eudWAxtnJiM/UHOTqKFSbbV93TD0cYVZ4kNCsCU0CxUyaFNQ1I/2+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CctWZc9KKI9EMTpaspEuce9jJHj/hy5L7BzuBUUity8=;
 b=i7VR5jyNoyG6iUHXDXTggzVHlcm6eaht3ds/8KtjiqCFHXRzh6OszDuUpN0w93TWi8ap5YDeB+C7WlXKncfcnYxomc7qovDlnPaM1Xhn9MXY6DTZIx0mTBYLhryEoBTWQQIy2cp2q3sN0D76pcRpX3kPbX48xu0DakRdUTaEKPs=
Received: from DS7PR05CA0076.namprd05.prod.outlook.com (2603:10b6:8:57::13) by
 DM3PPFBD8703CAB.namprd10.prod.outlook.com (2603:10b6:f:fc00::c46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 11:55:02 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::50) by DS7PR05CA0076.outlook.office365.com
 (2603:10b6:8:57::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Fri, 7
 Nov 2025 11:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 11:55:00 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Nov
 2025 05:54:58 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Nov
 2025 05:54:57 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 7 Nov 2025 05:54:57 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A7BsvlK2928509;
	Fri, 7 Nov 2025 05:54:57 -0600
Date: Fri, 7 Nov 2025 05:54:57 -0600
From: Nishanth Menon <nm@ti.com>
To: "Thomas Richard (TI.com)" <thomas.richard@bootlin.com>
CC: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
	Gregory CLEMENT <gregory.clement@bootlin.com>, <richard.genoud@bootlin.com>,
	Udit Kumar <u-kumar1@ti.com>, Prasanth Mantena <p-mantena@ti.com>, "Abhash
 Kumar" <a-kumar2@ti.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 2/2] firmware: ti_sci: handle IRQ restore in
 BOARDCFG_MANAGED mode during resume
Message-ID: <20251107115457.i6tkt466bp62mwp2@whiff>
References: <20251017-ti-sci-jacinto-s2r-restore-irq-v1-0-34d4339d247a@bootlin.com>
 <20251017-ti-sci-jacinto-s2r-restore-irq-v1-2-34d4339d247a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251017-ti-sci-jacinto-s2r-restore-irq-v1-2-34d4339d247a@bootlin.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DM3PPFBD8703CAB:EE_
X-MS-Office365-Filtering-Correlation-Id: e0fa075a-fd03-4bd0-ec09-08de1df47b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M+/WoEu2iAPHw9CPc3dbtv0UQKBMkKlD/5I5iP7Klqval0nARqzCr1ABTrXy?=
 =?us-ascii?Q?ofoWQckgHNb7j9j6S8RVrF6yLI9lxJhhK9xWW0Kj+bGvup4oFamq2WDqs83Z?=
 =?us-ascii?Q?Qvn1nrT2UbAY4kIOPiWbD//KNe0GvKWu7NaokQT8tdqWtNflq5To4m18gEyh?=
 =?us-ascii?Q?2qDnsMPQVxyYOSkbcDidJSIpOU5ocHy+Ieq5qB+qKf7CyOP7JC63fO+q0Rje?=
 =?us-ascii?Q?W2NmUIIhltIgnRinXJfb3+DZJjklPxiC25WkL+seKpEdJzaShDce/pwF/9Rv?=
 =?us-ascii?Q?WvIcwa5MSAzbi9w9p0ziKPjxqFkHhsHODEOmqjSaEJkc1xUO8RglCgi45Po5?=
 =?us-ascii?Q?4Dgcd9LPyShyBO4pb8jqJnA/qbIVigV362X/rDWpQGJYuTowAFZ2SAG7VhSK?=
 =?us-ascii?Q?Oo9ORsxgLLrtO1Iw8KEdwFhFgRhQ3ZQ6VjsixQhfep7h/0TDKBMTuiekWuDh?=
 =?us-ascii?Q?j4Qot16Q4npEUUzz/mrx86pRaCRKFBu3Zs1o0PPzQ1jX10Mhz5b464htGyCF?=
 =?us-ascii?Q?nssmZRPDC8jbc84pWIHlKfZHisoifK6xY/KPntD43uzkvfxoyBhevRIDkpsh?=
 =?us-ascii?Q?zM41E1PjDlpVRyoMve813+NrokUIABLIhPUU40dta4TFi5YWmWH/gojuorNk?=
 =?us-ascii?Q?PugWedMbZdYk6ri5E7NKaItLzAeG4Aab+qvXzHkuqwNrzbNDUjxfSyI42zhY?=
 =?us-ascii?Q?22tLmR5Gm4q25v+S9g3SU9Ad/SjZzXBJn4LSNKOg9fCyONcOrhpkTfp6eCpq?=
 =?us-ascii?Q?n4LZS/x9sE33SkdLEtFNksCiDMlxI6gHLKXm8/FxlpSztAquose2kWFHSWWU?=
 =?us-ascii?Q?eCpiutAsa3LL4p+xUx5alIx0DDfPoki265jDBjDGMCc3K4s/yOvTY+63/hk8?=
 =?us-ascii?Q?VB2S4rPV6y2P6JywWnHewIiqUXf5uUmeAKCTnlmEuiZrt67hRq8kQS89kTzk?=
 =?us-ascii?Q?2MCxDsK+OXLtTc2/2deHsSmSJSAZcLpG5hKTKqUN9ruwMopNpKal8yED8Yww?=
 =?us-ascii?Q?6r2YGxLbl9sah+z4+agy+lQWTaTDDC8WBKe/YMD9QsdEJISrxXACjcuMuv4r?=
 =?us-ascii?Q?GOrF+yBLOERRF1SLvslQOo+kkv3G194OC/OPLn4DSQf+2IJCavJXhHgucmpk?=
 =?us-ascii?Q?a1LHDXrevYgTYrs6IMqpWKioGOCAHRTJa0t2Ffmeunou4zWBLV4+YDnnnlrm?=
 =?us-ascii?Q?irlmj6LqgB7YpsHIYtwNF6IzUOno6uV/0Ej2aFN/2ti9DrIaTzTfDrMdXxaA?=
 =?us-ascii?Q?7//0yCqFAyeMaDP0L9LIaRWIjLHM+ewJGc+wWLIXj9LCL69EneEidfrCn3I4?=
 =?us-ascii?Q?2+ThRXCpDtOMEePOdkp0NG8Oz4M9yIc1yBwJP2LsVDbMrlwglEgCvNaq4wih?=
 =?us-ascii?Q?CBy03Ies3J+y06wxwFxwCZQYim4OAsAA9LZA7Itasle7dfLagofkr2iUhIMO?=
 =?us-ascii?Q?E23o1eBKkct0krLPyVoXjMKp4IOiKZyLO5rBHM/+ZWrFsQ3BwWxxjrfhewg4?=
 =?us-ascii?Q?Y+MCpbSp/h5qSdGQAuJHtIp/EIPVcvugwvV5qoTBNvqUUuj8wmcOOBa/k3Nc?=
 =?us-ascii?Q?7TV7/AAK5ny9HqAiQVI=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 11:55:00.9103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fa075a-fd03-4bd0-ec09-08de1df47b3c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFBD8703CAB

On 16:44-20251017, Thomas Richard (TI.com) wrote:
> In BOARDCFG_MANAGED mode, the firmware cannot restore IRQs during
> resume. This responsibility is delegated to the ti_sci driver,
> which maintains an internal list of all requested IRQs. This list
> is updated on each set/free operation, and all IRQs are restored
> during the resume_noirq() phase.

Couple of drive by comments:

clarify why is this not handled by ia / ir driver?

> 
> Signed-off-by: Thomas Richard (TI.com) <thomas.richard@bootlin.com>
> ---
>  drivers/firmware/ti_sci.c | 143 +++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 135 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index f9f1a67e8e66b0a4048fae04ce31be54ca5cba7a..a211f8805dd21c7675b8cefd61929ecfda8e0f7f 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -87,6 +87,16 @@ struct ti_sci_desc {
>  	int max_msg_size;
[...]
> +
> +	irq_desc.valid_params = valid_params;
> +	irq_desc.src_id = src_id;
> +	irq_desc.src_index = src_index;
> +	irq_desc.dst_id = dst_id;
> +	irq_desc.dst_host_irq = dst_host_irq;
> +	irq_desc.ia_id = ia_id;
> +	irq_desc.vint = vint;
> +	irq_desc.global_event = global_event;
> +	irq_desc.vint_status_bit = vint_status_bit;
> +	irq_desc.secondary_host = s_host;
> +
> +	list_for_each(this, &info->irqs.list) {

list_for_each_entry_safe ?

How big is this list on a j784s4 class device? is it worth creating a
irq_desc_hash and using a hlist a better option?


> +		this_irq = list_entry(this, struct ti_sci_irq, list);
> +		if (ti_sci_irq_equal(irq_desc, this_irq->desc)) {
> +			list_del(&this_irq->list);
> +			kfree(this_irq);
> +			break;
> +		}
> +	}
> +

[...]

>  	ret = ti_sci_msg_cmd_lpm_wake_reason(&info->handle, &source, &time, &pin, &mode);
>  	/* Do not fail to resume on error as the wake reason is not critical */
>  	if (!ret)
> @@ -3961,6 +4085,9 @@ static int ti_sci_probe(struct platform_device *pdev)
>  	list_add_tail(&info->node, &ti_sci_list);
>  	mutex_unlock(&ti_sci_list_mutex);
>  
> +	if (info->fw_caps & MSG_FLAG_CAPS_LPM_BOARDCFG_MANAGED)
> +		INIT_LIST_HEAD(&info->irqs.list);

probably not worth doing a conditional initialization here.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

