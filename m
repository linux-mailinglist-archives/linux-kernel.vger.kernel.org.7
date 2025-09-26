Return-Path: <linux-kernel+bounces-834292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB9ABA45AA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F731B2584B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F871F460B;
	Fri, 26 Sep 2025 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DUYZrBmV"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4555E2AD2C;
	Fri, 26 Sep 2025 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758899314; cv=fail; b=vB/+JleYAuJskR6jlDluEaPr4Xjt5k84OrYq2pSb8vjv9VeUT6H9C2jOvHVSoj5dkipo7AAIu+ijkrPhv6SUP53cJmfk7yuCq6cb40pOrxHLn5b9PYQp8933yYtnYBk2KlzM1XcaNFvLzaeeyWK4k+0BN1FbLMGK87uWIJzH1NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758899314; c=relaxed/simple;
	bh=KcQIgVFE/HRQZoxKvEVsknWbzN5PVHF2RhtbP6W0oJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mrjyGUzpGvucCga+fse7DtbfYRg7mGztCcZo408cF2sqTwtyB+YZSVrB6hW04IswGT9hem0YnINr73u6oXa2XTffaommycVSCy+3OomnRmHIjNXn4pftF6rLzPsyWXkAEFoNwY6psfAwoVazZZniqSCiS8kzge7p1+Gb08LL+7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DUYZrBmV; arc=fail smtp.client-ip=52.101.65.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZzyS4RVpxx/snrrZ87ojtCBkGhlnXssjGCtBmhCFyEqiU2qwRdea2L3QhdJa1Wa0QL9PO+PskBEKj/eeuoemrAcXhvUJvvFLtuSaA6YHAcXxqMCW7lrWZ9LSdn2XA9GplkcPeWrv6eDiphP0ah55HvmEf4T12qyQtYeDYxZaETCJDKRyE5xveC6BosSYPpTM6HE9Md2IL8JHreOhmPGOop5MlEqtkPvo6f8/NR4aE4Z+yXzk6Tg3NvM7/H5PISz52kQc8rj55AwojbymJw6ncQr4lyG/9SpD9H6pUOZWe2na6WJtSJAll0MBcWIYcGibMNzH1wtSNbob/U3IMXMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFED2Vrypt7wJOcBHGPewdAIGTpsIbzXX5Kb/pr//xA=;
 b=fisXtm3UEqGdbbJWbQJi8cdLV/IVGlRMyoVv0K99r9UoaAqmGjqWNPnAPMvmWqLE/EkBpxZcNFv7msBpNoI+e2jMX+p4qVMCMjYg6Q6NG3SJynTE1DU8fVAVVS555ynHJK5+ikLqdch9XeXPPtryseEb4O7R3IZjUOe3d3dwJjtYsFsO1Be8UzuO3ZRzKIN+wzlNItofqB7fWSySaxqX49DJpM5+mx4u1w6RmJQaQxRu1trmolnAGqq0N31jxCLuiXUddbPOkmQqDTN2j4QHMDvvg526Sqy/8ligNztYrf3sAsyR61zX53a8715S6uymZ3Tp7mv5kX6weOSDBiJIuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFED2Vrypt7wJOcBHGPewdAIGTpsIbzXX5Kb/pr//xA=;
 b=DUYZrBmV79EbAj0ZitIZfpM9YABSZMLA5z96xwdD4x+fSP5xsVpcZBI3vajwV3MA8sU8y4kgA5UwuUU/MlbKkXvSmgqZIegr5VtgMSWXrINhRq2Z97eTkiZxm/pgjjCyka7tY7gOc0chPOq9cBlaWgBKSbW8GIQtfHA0Z08mldoTULULbi8CR9qLQlea3mMh+lZBkvUS8Vrydu5lj9H3eQ1dclktPL/T41j//G3GeXNHKqlCVcQYJCnCj+j0Nb4Ldi0Sb6TT/a4ZbjKPD8GTrlYZKm9A3cCqrTdUTyG2LarC2Dlrw+Jmgj06z48W/R1fE7FYmhvjqjo0LZk3wXekqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PAXPR04MB8960.eurprd04.prod.outlook.com (2603:10a6:102:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 15:08:29 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 15:08:29 +0000
Date: Fri, 26 Sep 2025 11:08:24 -0400
From: Frank Li <Frank.li@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	bjorn.andersson@oss.qualcomm.com, imx@lists.linux.dev,
	Ze Huang <huang.ze@linux.dev>
Subject: Re: [PATCH v3 0/3] usb: dwc3: add layerscape platform driver use
 flatten dwc3 core
Message-ID: <aNasaARTt0gusNVu@lizhi-Precision-Tower-5810>
References: <20250926-ls_dma_coherence-v3-0-602b1c0ce6b4@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926-ls_dma_coherence-v3-0-602b1c0ce6b4@nxp.com>
X-ClientProxiedBy: AM0PR03CA0070.eurprd03.prod.outlook.com (2603:10a6:208::47)
 To PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PAXPR04MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d9a8d27-f2d2-4410-0304-08ddfd0e8d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|7416014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eNaqEGkuyZBQiBZ49s3wcvHnLJuoakhWiLJmgTnBAnREas8RQqK44XSCayLh?=
 =?us-ascii?Q?eLHpEtG5bAzWXX+T7rKfY0puieL3Ns+0CeZnUkHZkA1KYCTLA2+hcVijBy8T?=
 =?us-ascii?Q?RSR8hSRB27fF9e4rjc6CQyQ/Yc/FStKF+O9omQwv4EyIQiunGdGFQYBlqT6R?=
 =?us-ascii?Q?sobvuTiH9T5IHSJwWkrWBBKd7EethXC63+f3iTGeEECcI++k9mXCZOiM25MF?=
 =?us-ascii?Q?1mjCNZ9GnRjNvEYpll3n0ysQiOsIYYfhxAsuPAVsAtEU+HSKC3iTW9kxWboG?=
 =?us-ascii?Q?oPfn1SBH/av+jXg5INK2+HdnAtMd4LDMlpj8ET6zVmloeZF8K0f/RKGUqUcX?=
 =?us-ascii?Q?lhGFIqSTeFC3CbSL6KfaH0c6vZ97zwHLdOjnPXKch1ne0P7lg/NqsjuwckUY?=
 =?us-ascii?Q?APXMPkSxEhwN5GBp1rYc67LepKLAg+aRhzUsJpXIObpjiHskKtAe+7Az2Taj?=
 =?us-ascii?Q?bYKExKJADS1Mn3fsldu/GFA/XLmCHEm5OJ1ikxh93o3WEHktaFd+Ij/lik8l?=
 =?us-ascii?Q?ZlxgrW/yH/jVP2kDmUYu8ezJ4VWxSbjyTBgJ01haMDIgA9w0LMw3w9MRH0Et?=
 =?us-ascii?Q?F6ByRRRM3YYik/LNFktrsgmJAYvi6NfoHtaRcVPN/vB/N8tVZcxAevoMVwWM?=
 =?us-ascii?Q?Q9gaIGIQe5MYEQ5C/AjabgFPhrr+p2vjb4wlSJAfhamplOa2np1wD9J3Qsey?=
 =?us-ascii?Q?gUEeQeZKqjgAhCZPBv/NNKldDUMg7S1/k12I2198SmcNKd1ZmCKNLkg4Mbm1?=
 =?us-ascii?Q?Wp/9EWHrTHjfpEIlDdqgu6g8ChOf1M9VL4zXs5sfKyUUV07nxGqAlFRQ1m2m?=
 =?us-ascii?Q?jM5+WwsZwN0i97t/r9I8zXsKjNlTgbVaqjC+QY/qaV0MzFx/tqM5q3rKAl3P?=
 =?us-ascii?Q?eDNoOplJQh3ouBjNfZMu7ktECp8/rY8H3nESIn2gq7bq6jEqSSCi47/MQXeC?=
 =?us-ascii?Q?mo7aGwco2WiZpwjBxbRF3qwU8OIyV74s+qUfIYufOgK9TVZFgwFZMCPrpuGP?=
 =?us-ascii?Q?K4sxws82MGd1yy6qb6MmmQEHKTGHriGfQef2ShwN47rc/IoYyGvnXl60oYt5?=
 =?us-ascii?Q?KwrYeMfDNnVCZIcWlgvFbOebuLa0RizDk+r/XZDUcajy29hiuAxqb6kZtuOQ?=
 =?us-ascii?Q?/rXm7n471IC1w0Kredim4KMXkYGe3VGINb35EYcdT1GmPbt7lPNr/VleIQ/u?=
 =?us-ascii?Q?kNm7L1VxrOqWcMlZdzrSCfrDbluFomifwdxOYQRe4pMi0eA9glZ/sM5I6vYZ?=
 =?us-ascii?Q?sD6lIC34eYaaoL+F58m7EcJHBwxS7KNRQApzSorkxWwqdVqj+NaZbHgT2i9x?=
 =?us-ascii?Q?5a6w2tV1YTUm1qtIxTHTYZqbH1c44pPtKIdQWBY3r3F9LYdrdFjusAvnS26l?=
 =?us-ascii?Q?PK+bXbCIHFB2ExJl4K0kURzzw6S/q23UiNR5iAYxulIXx8mXJNI16FixTfgU?=
 =?us-ascii?Q?SASypQTGqx0v88zQ5fLZQicWRXj4P2LB4cX8IDvC6nDUldAJbqwQNQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(7416014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p9xDwvNnfxwCA02NR+t6a5LO1wzRGlt3NgH7qol0uPe0KHvJL4CH9jSEOUDM?=
 =?us-ascii?Q?MoH3PDZ4q3LdegUA3WtO1j3KY5sN/60tjIt9fOystSlPCApKRPleLM+nHPx2?=
 =?us-ascii?Q?Iv1tbi3VP2PcBYDk2WlIYAccMbImpPr2/GeKAiu6BgU6wI4ceCUEFY3QEWjC?=
 =?us-ascii?Q?U6yX+qkzJS53pCu3Fvor/E92tFX30DX+gpDUtBOHO6v0zevP7t1vuD4Ki2uP?=
 =?us-ascii?Q?n6vUiOmexQJ+s2ILK9oWUZbO1ROnNU47day9MoFot8e1odLMEkLW1G+HHmxX?=
 =?us-ascii?Q?1AMpJrbIs5MTeErm27ZY4HJiD1/fn9Ln3bQw2goIsARaAkVmW/0Oy9C2Z80B?=
 =?us-ascii?Q?8Yg5MSZkChyNKzYBv4SfIWT+cLd4o81o8l3jzbEC4IsveAmgJ5wlM43t+JZP?=
 =?us-ascii?Q?e2nsvFvsID38Ax9j4jpquLbCgHpsYiDzz8RzGnZqt/QnndwfAxN6iCs6H6Pn?=
 =?us-ascii?Q?RRhz8ynuS+B9HcsIclhe/X1dWGrL8CVnATTJgglHWo7Czm+TTxczQhvQcqBn?=
 =?us-ascii?Q?6wRAbWc81v3Px5C1tH6+ivI/LYEubOmwLnTYpjdg8gR7RSLZco87DUl6m73I?=
 =?us-ascii?Q?pqDd81xMfI3UitcEkFMdjzpoBW3f0YLif4HlwlppCs4NAXrsngCON1Eb4FSF?=
 =?us-ascii?Q?I6V6Lsh2llhzHtFPaFTZW+yiGyMX+q4Wv+YCIufUxx9fatA0pUzOi2NFYhCF?=
 =?us-ascii?Q?EAFvo/g4CycCebS4LWQLAk35nePdO8I8iBjbjexBTtkNGqOOanFFYUvjlQtE?=
 =?us-ascii?Q?vY0Z5JMZgr/RUkTjG44YOJ9nxP5QVUELlWcRKdhKipS1xBigTdTcokvlZKp4?=
 =?us-ascii?Q?C9b+S8G9yONFzQuauehaHmVY/GmqXlj7+0iHEJK3EShOocZR1tkHJCkaJf70?=
 =?us-ascii?Q?ysGwUqSIzdWruBlooFXsQszwahG9qb95mwwpsBVuwX2x0byrqubE152+mJ7D?=
 =?us-ascii?Q?t7bH6b7NElNtT1JG+lNSlv95/vTPqwr+Vv2s+RJ520innWQ7cA0wU7ESygt0?=
 =?us-ascii?Q?ePhoe0MdRuzTxM3umgobYWKJBz9Ia1MmzsvPgNH5as1q1OtLlbdUWUD6g9Fr?=
 =?us-ascii?Q?ezHb6vKJbwIlehliydIxk6j83MFx73j+pCd50F9N51xsmuzMSWmUGDyqKtCV?=
 =?us-ascii?Q?ky4zy5+rz+m8YnBvxgWCePRFhpnYUSk76qQiYxUgptV01mo4l317YIwQ+xvm?=
 =?us-ascii?Q?lwPUjswUs2pmv6A1iKCgcscOp03+IoCVnU3fGcF6Utc/Ym9f1jcM1hhPXbm6?=
 =?us-ascii?Q?f9qCzAwdTQ9cnev15dsjKaOz1AwuTapZDoxi7z3wabkhgedgp+ZIBb44r25k?=
 =?us-ascii?Q?AWv80tJxMmYxvodMcoeB5zo/NV0AjGUTROtshCMNOveBx7BWjXSYn7G6u0kg?=
 =?us-ascii?Q?EXFluRcg3xgmENC404DdEjqpHOH1K1NKXnqktcBNneOaHp/1YZprKBc9rYqn?=
 =?us-ascii?Q?YF68zmIC4xxdhylrBudcw6Vd63eEy4hgY0EmpQpqW/L7C2SYbv0xFAlst3PC?=
 =?us-ascii?Q?lqhEoAupETT6Gw5wcDalIwKng6Ut+qBQeUpzENjSYwhwTtnCLfhushtA/Ell?=
 =?us-ascii?Q?VKdmY0uB0yfmDNJh44TcmWmPhzcuNBjZgXtI7Tbm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9a8d27-f2d2-4410-0304-08ddfd0e8d0e
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 15:08:29.6438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkUVOiXugM52VTBskIg1Jb2TsgFKjsqWtLR1KwayTFwo+ySYHjq4xN8cVRFleCkN5qHDSYblhcL8ASLBv8faOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8960

On Fri, Sep 26, 2025 at 11:05:47AM -0400, Frank Li wrote:
> Add layerscape platform driver use flatten dwc3 core to enable dma-coherence.
> It needs set gsburstcfg0 to 0x2222.

Sorry, please forget this patches, I sent accidently.

Frank

>
> There are some several try before:
> [1] https://lore.kernel.org/imx/20240710-ls-dwc-v1-0-62f8cbed31d7@nxp.com/
> [2] https://lore.kernel.org/imx/20240123170206.3702413-1-Frank.Li@nxp.com/
>
> [2]: add new property, which was reject because there are no varience in
> the soc. Fortunately the below commit resolve this problem by use software
> managed property.
>
> d504bfa6cfd1a usb: dwc3: enable CCI support for AMD-xilinx DWC3 controller
>
> [1] was reject because there are not actually dwc wrap at layerscape
> platform. Fortunately Bjorn Andersson's below patch to make it possible
> by use correct dts dwc3 node layer out.
>
> 613a2e655d4dc usb: dwc3: core: Expose core driver as library
>
> This resolve problem [1] and [2] by use flatten dwc3 core library.
>
> 1. add soc specific compatible string at dt-binding.
> 2. create platform driver for layerscape chips and pass down gsbuscfg0 if
> dma-coherence enabled.
> 3. update layerscape dts files.
>
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> To: Shawn Guo <shawnguo@kernel.org>
> Cc: linux-usb@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: bjorn.andersson@oss.qualcomm.com
> Cc: imx@lists.linux.dev
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v3:
> - rename gsbuscfg0 to gsbuscfg0_reqinfo
> - Link to v2: https://lore.kernel.org/r/20250923-ls_dma_coherence-v2-0-ce3176396bdb@nxp.com
>
> Changes in v2:
> - base on drivers/usb/dwc3/dwc3-generic-plat.c
>
> commit e0b6dc00c701e600e655417aab1e100b73de821a
> Author: Ze Huang <huang.ze@linux.dev>
> Date:   Sat Sep 13 00:53:48 2025 +0800
>
>     usb: dwc3: add generic driver to support flattened
>
>     To support flattened dwc3 dt model and drop the glue layer, introduce the
>     `dwc3-generic` driver. This enables direct binding of the DWC3 core driver
>     and offers an alternative to the existing glue driver `dwc3-of-simple`.
>
> - Link to v1: https://lore.kernel.org/r/20250602-ls_dma_coherence-v1-0-c67484d6ab64@nxp.com
>
> ---
> Frank Li (3):
>       dt-bindings: usb: add missed compatible string for arm64 layerscape
>       usb: dwc3: dwc3-generic-plat: add layerscape dwc3 support
>       arm64: dts: layerscape: add dma-coherent for usb node
>
>  .../devicetree/bindings/usb/fsl,ls1028a.yaml       | 33 ++++++++++++----------
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |  3 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     |  8 ++++--
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  9 ++++--
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  9 ++++--
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |  8 ++++--
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |  8 ++++--
>  drivers/usb/dwc3/dwc3-generic-plat.c               | 33 +++++++++++++++++++++-
>  8 files changed, 82 insertions(+), 29 deletions(-)
> ---
> base-commit: c45d2c21b3889c520bf141d576eaecb25666895c
> change-id: 20250602-ls_dma_coherence-c3c2b6f79db2
>
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>
>

