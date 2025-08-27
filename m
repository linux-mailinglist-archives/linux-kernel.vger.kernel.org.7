Return-Path: <linux-kernel+bounces-788643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F4AB387C0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F04189E069
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549092594B4;
	Wed, 27 Aug 2025 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BMCqBJNX"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012064.outbound.protection.outlook.com [52.101.66.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB942116E9;
	Wed, 27 Aug 2025 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756312079; cv=fail; b=KuaED2xLtfRonP7bW33OWtuz2tMYFolTZdfLnxw9AbTz3BeOdcCzDY2Qc87G6Vm7SnbBkOuiLqqTIDf/muXAKYXgij1MU0cSL/cJAhcJ4H+w32/Xz09TowrBw6K9iXvQ/K/WjZn1SdGTsedYJ/wsQIdykJLCsj3Ikegn8GGck1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756312079; c=relaxed/simple;
	bh=GfnDHPtKNhqPGh/SKGgPWPCCzD462y9zjIeaOKM/+Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M+8ml/blUTrNj4lNBH+nlmdHvBW8JGhILWtJSAXyS9/O1JibqhHrHE30LA8eRHvJxhPa2T3wH1d3TsGvxS+GvgiFCFnVzAuXUnqEe/TlnMA842VHEsLgt+S410jy9lzQzR4XIN66qQO7GmK/0X+qs6WGS/Xy7zlZHe9ZPCJZNwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BMCqBJNX; arc=fail smtp.client-ip=52.101.66.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d35Vb75JDsvYztChNKOzoNtte9r5NKig5fUqFVMKfwdAC1Kwz5wduxFM81VON1aDaEttu79nzJnOKSaDC8x8BW3JGbXFVOsNSd9pEVGM1u1TEOr/BhKtaaKBhL3eLXlX+GtB5jRgY5o6HNBVO5YnDspuVCbVWB87nCBS/wgmHtImlwsptltBCx11hYrkftXBtmE9RjZzlEvWimgcvFMAC5II2VmdkebI1HPaYhE8Vkg9fFr1kZKhSslZJWNP64uZM2OjCQqHB+2qgckvrfT0N13hk9TBtI2OEEzxbYL53YlQocczN/87EQ9n91qqUqqVMM2sGqGS3qtFju5XhqTa5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jyb6u2Zfa+5Edu1PYms5x/vpvawtGexBKZ45IOc6Srk=;
 b=zFTTFUbesbfKd7/eYBnvGV25qzCM1mDjIqSXsfOaympskEM3fqdt6NZOJMWIJjLCuNjcqtNdeMSHvqUizSazmIHVAh204hP2Pa6t7cyDA2S1Dqw5BQPoi5Pd/pAo+KPtDnWy/Y8VHPsGEPni2bZ9Z0ld5884RlRrPMQVz2qViGTnueu1AdoYfOeo58cQawoJzhQPl5HBxXX7MoCr6TmyzZaGySHeeKLHSkcLtsIkzG6M1PaTTCb7p/m6cv3Q5xcfkD30PO8mcI6yWdX2TCkvzbyjKbSoiV37c+OQHRC0m0ZBlOfPnxnGoZFBJS88Qa53hsks6uU9903AKYGGOWOt8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jyb6u2Zfa+5Edu1PYms5x/vpvawtGexBKZ45IOc6Srk=;
 b=BMCqBJNX0WYmIWWAErmO4kxiUzMjQrx1hA2nfQXWe5QqHm10wbHFxtmP3nOWM4qYlwPkCVqxK8PLKWkJNhWOrbaeidsSUhRPmqfHKmFVehIScjoDfnX/mQAteODjqun4EB8o4JBHR5LDg/lJWg25ow+1wG/UETqq3z8UyIDiMfhjkDiIcODJB7BO+aWuKNVQ0zQ5X4GJqi/BfBV/RHwuBvb6BwlagbGcHHW5HW7Bu7y+1soSnQtWYfeg3l9etYHH8i3rwm1CkT2xX6O7PwQ41JJItPXZj+vS6JTLLnOHmmTHPCP3VMszkez7KRoovp49vUa/X5vsohGNzP6axvJFrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB8069.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Wed, 27 Aug
 2025 16:27:53 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Wed, 27 Aug 2025
 16:27:53 +0000
Date: Wed, 27 Aug 2025 12:27:46 -0400
From: Frank Li <Frank.li@nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ciprian Costea <ciprianmarian.costea@nxp.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, linaro-s32@linaro.org
Subject: Re: [PATCH V2 1/3] dt-bindings: nvmem: Add the nxp,s32g-ocotp yaml
 file
Message-ID: <aK8yAsRUypksjzyq@lizhi-Precision-Tower-5810>
References: <cover.1756219848.git.dan.carpenter@linaro.org>
 <eabdbf4c0b74136b77e16eaca5d5e64d5c4a97a0.1756219848.git.dan.carpenter@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eabdbf4c0b74136b77e16eaca5d5e64d5c4a97a0.1756219848.git.dan.carpenter@linaro.org>
X-ClientProxiedBy: BYAPR21CA0017.namprd21.prod.outlook.com
 (2603:10b6:a03:114::27) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ef8182-f705-4655-3688-08dde586ac41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0xe+iQkk5QYdpErVh7wFkd0BRwPzG0GwiNfflK+7uI+O99U5EY9ox+6qY+8u?=
 =?us-ascii?Q?CTJhQVElTaE8wuhfHOJvkyLuHOzNtGgPZkmn8wA1e4dh3kZiSwWwlqgpcKpX?=
 =?us-ascii?Q?UcDbd1wUS6BsJQ6TKSSKkQEEyKB/pyON2Yg4pQ9xIWRUtHtQQLryPhaNHGSz?=
 =?us-ascii?Q?j41C7Mdb0PClX6uNHxjnZgY3g0UiXAcuG0L631UygQJDPsEl9cSIquRb9uEm?=
 =?us-ascii?Q?b+x17kigAvn97xFA1XPHipckTHjWPZK1a+fiej1u+KbLusXI/hLou2jFVTpU?=
 =?us-ascii?Q?Exc39DbXkM0x+YmyjDtWUM9jWwhPE/tyKLiwVC9SZ9uw5UD+T6uJsyzcCVBx?=
 =?us-ascii?Q?wo7AaX7e4OTkaL+ZAan0A0FTrst7YwefYPwYvv8ZEPE3Rqyw+urkvBYnEjwO?=
 =?us-ascii?Q?Zect03E4NXKJ+Jx+PRJjfWIhSoZ6mMGAlATkhV1SZtUbxPVLUlo3o6ExfYnT?=
 =?us-ascii?Q?T2s8fswbGDrZHScKoPbLZjs6FGRfJYI/q6b1ILnfftMIVSex2cmdrbRfLEfv?=
 =?us-ascii?Q?GNFGJOhLo74d2UfaEn4UQohtQMUOZnDLmSeX2lFaSPvgbFWGJfpIYrJ64n3I?=
 =?us-ascii?Q?13iVsqAy9djlkd0nJ8dv63PEBM36kDMbmhjlZwOnqlP8AKTbXQngnnL/lDtA?=
 =?us-ascii?Q?nx7290GEpBeBfSjCjbIG8x2FfL5stBhCOXif3u1T+OwwRIyKm012iO2+BbST?=
 =?us-ascii?Q?eDTCGnsJTQz47F1JGWvCLw7Ujt7mE5ekohTXvbWqiKgam6NUlZF4Z35h+W5p?=
 =?us-ascii?Q?jzpNdETS6KsaJ6VTaxPXanifrepjGviL6lhw7MpjKiccIC62K0ITtSykLPDM?=
 =?us-ascii?Q?smowk0+hr/ae7EbEbCOpGVQguftvTe5Uws+klUk/GrREgWG14W/hR1QfcH7D?=
 =?us-ascii?Q?t5SBZ3V7qGaYbT+/O9EYSDX9+9Fp3duLgCXW6DCM7lSkuY9XPhXbSKcUiH7F?=
 =?us-ascii?Q?gDdPF2Ehv27iP3M+r6aL2mUoOC7e60Y/7PWGR/dLLXO9Ey59zbbDUBI9dPfZ?=
 =?us-ascii?Q?CQgHOmW+MCTUkqrLP6+AzDjm9iVIGJcZybBcf3z4Jpmx/xhUIb1o+kalLFhs?=
 =?us-ascii?Q?W7tjKSlBo95dDLzQ8q5cvHxdl9Vx7Whrnh7OhO2ieAdp6Afn8Vrbl4JzpQaE?=
 =?us-ascii?Q?kZvTcoNbmrxbaIakIHB3dUrsxcz+4+dnRp/xzdgrWl67QzEjYLfWwbJNUtIw?=
 =?us-ascii?Q?Jodvu7woceoJ6VkXIlUavMvMflZ7fG98gRG77/jLtFJpmTKQZSFK0vFHkt4/?=
 =?us-ascii?Q?KYiB/ebXjgT4ejzM7iu5ZIT4Kl65OmhnC0JGE1cSxM6TlVP0nq88b8Yz+D+W?=
 =?us-ascii?Q?j6Shlb8ylRd0resyqJrmx9HgEtubqzAf8/fD4VOmXKWL3bmQFTPGZaRGNLcm?=
 =?us-ascii?Q?4wey9NfWrBAtYNd9LgcKx70TCQdKtq2LMYyLd42DKY5+RAYK14YtWVL25PMW?=
 =?us-ascii?Q?VHVbKlPuyIv95xYB1TQpD1NlpSqksSEd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EfCAgZ3f8BxXa/09JXO6TEJg+3ryy+UZqIJaG++UxFXBn1WNYYKpAJ+cU01f?=
 =?us-ascii?Q?BkMQ2sisVkYjj8g9YkaAojaCElclcV8EzBJfN4AUht2ILGN3QC0QDv68/xyb?=
 =?us-ascii?Q?4Nkv6ozBaxIaSdBh2jVbpOsx+EvirVBW8+KsDL6xfhpDfvqnPcDcXZs9qpRz?=
 =?us-ascii?Q?rP7hsNBamx5p++IbNbp9I1AYfLVY15rnQeyM3D8pJ2uwkm7NKKYQnuZq5O6u?=
 =?us-ascii?Q?XZbEt7XRES2wrzacU3V4PgcqJWbXNsrvPljRPw1sD1OcK+oJAjLEddXEseBc?=
 =?us-ascii?Q?jhbSijjvztMahqTZsH1z9hKyPjp2rJXASj6xsNs5y5yXqQeF0s9shcoWGSrk?=
 =?us-ascii?Q?dH/346PKmiHmMe+vU8OD6g7xl7fgsjJnIfWIgw1XQQYrGbaS5j/aYO2Lw8Ql?=
 =?us-ascii?Q?BcARlB2WkYJRWIMUWHS/NxlJal2rdI/3PjDfcydXdmIloVen13XTQPnOKIy/?=
 =?us-ascii?Q?YFxEuKux385Wwl04RebfPsNUCw+7TqErwt10UZa+4DTsLLOT+BTswWM7wvo/?=
 =?us-ascii?Q?TMdMcKZs8sLYcZGILKRg1S9zT9ijj8Rmgc6kqEmCKteAuuGP8xhc+0kszgRM?=
 =?us-ascii?Q?/ai58NqiqBZcJoTxOJ3eybFHCPBGwAM1KBv+IUWVYZGB1cFrKSf6gStwKXz9?=
 =?us-ascii?Q?K57SB7qH6zHbtjrNiXum30NKZVbzz6TQ5dUnsVIOQQdsyXmMsSWodr+QHlks?=
 =?us-ascii?Q?aHFe1z1DIZtMjTf0qE3FCIMcOeXiN+SzUHPymXkkVPcnXqkPEUBG/ACgfLSp?=
 =?us-ascii?Q?82YNIl/rQBGpDZu0U+QDILqfxjEqLFFGwB6+FctGc7ZGxMnCWxeF3CvkNmX9?=
 =?us-ascii?Q?YOtkk9h3UtuRo3ffEvnrzTLbB2D9gD2jwx9WdALJEfvY0w2Ng9ql2tK8QXkv?=
 =?us-ascii?Q?OlZf9WlwbpdpaKuaoKWmm7XHNfkx0yTRvrE1OPy2Xhp6EeFHhsOIM0rDj2T1?=
 =?us-ascii?Q?r43uEoLRNsTxJ+6UmHJMlEEzUXcRzsQdkQC00ILMNS9XYbEe5jJAYKypM9Fx?=
 =?us-ascii?Q?iBGD6NBSAOYgVSewiT3Y+FyKCE1svdJfwEqQI7C12J+NML661MBcTx+APVQH?=
 =?us-ascii?Q?PlmHcwENvdsSIODrLS9Sd4+5BuRPuTTo7ND8miLk5XYmxhO3CyL1KfjT7hYg?=
 =?us-ascii?Q?hnwEGhWWerYjOzspQSOrrB2h+C9TtY+35CuEtCeavYFHAKXMNOV+pK/Xyc5h?=
 =?us-ascii?Q?qT5BFYUizWvoM4XR+iNdrulpxBTBiN57sble1n28zJWDeGebcRnrJkLLmj8I?=
 =?us-ascii?Q?soFUaOmhU3+8Olr2OAs1Zc1xw20U2pVCfYzCgFPSCoCnz2kML9Sv+7JSfP5v?=
 =?us-ascii?Q?g6r+ocuX54s2JSQeWlwP/4/FX3HvV+7tQzVYU/R2RFOLTXtxrBI/jzykaAS9?=
 =?us-ascii?Q?SBJ0NKCiq/86lJexIoxlnTAqJ9Nx9a4ICC5s7MiyuX71a1BpmEEkbaWLMmTZ?=
 =?us-ascii?Q?5d8atGA9SN/rPQWIRY07bssTtDFg2k3xN+h+EOW/6MwmnM0Lq6UBZ7KM+zep?=
 =?us-ascii?Q?AZQ98QwLsM3ae5UwWIbAMAMV8/13+eeV09TMM0rjJ+ubYPBf34sIeSfBxH1Q?=
 =?us-ascii?Q?nQQSucUOU7Rz58rNSLQMdrqs3Euz5NosfrMxJ8YW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ef8182-f705-4655-3688-08dde586ac41
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 16:27:53.6446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6XTtSTrNlaANGf6VnyiuUdGJj9Ux+PuYg2XvhICMnFZ5H9bGTvnuzODj2pbcXfz9rDK3uOjUyMCbZNTOPQtbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8069

On Tue, Aug 26, 2025 at 07:38:03PM +0300, Dan Carpenter wrote:
> From: Ciprian Costea <ciprianmarian.costea@nxp.com>
>
> Add bindings to expose the On Chip One-Time Programmable Controller
> (OCOTP) for the NXP s32g chipset.  There are three versions of this
> chip but they're compatible so we can fall back to the nxp,s32g2-ocotp
> compatible.
>
> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: dt_binding_check DT_SCHEMA_FILES=nxp,s32g-ocotp-nvmem.yaml is clean
>     make CHECK_DTBS=y freescale/*.dtb is clean.  Particularly the
>       freescale/s32g274a-evb.dtb file which Rob mentioned.
>     remove bogus include file
>     remove redundant "reg" description
>     remove #address-cells and #size-cells since they are already in
>     nvmem.yaml
>     Fix email From header
>
>  .../bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml  | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml
>
> diff --git a/Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml
> new file mode 100644
> index 000000000000..01adc6093c68
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/nxp,s32g-ocotp-nvmem.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP S32G OCOTP NVMEM driver
> +
> +maintainers:
> +  - Ciprian Costea <ciprianmarian.costea@nxp.com>
> +
> +description: |

Needn't |

https://yaml.org/spec/1.2.2/#scalars show "|" ">" "" 's difference.

> +  The drivers provides an interface to access One Time
> +  Programmable memory pages, such as TMU fuse values.
> +
> +allOf:
> +  - $ref: nvmem.yaml#

Move just before examples in case need if-else later.

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - nxp,s32g2-ocotp
> +      - items:
> +          - enum:
> +              - nxp,s32r45-ocotp
> +              - nxp,s32g3-ocotp

Keep alphabet order for enum

Frank

> +          - const: nxp,s32g2-ocotp
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    ocotp: nvmem@400a4000 {
> +      compatible = "nxp,s32g2-ocotp";
> +      reg = <0x400a4000 0x400>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +    };
> --
> 2.47.2
>

