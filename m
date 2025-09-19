Return-Path: <linux-kernel+bounces-825267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39252B8B766
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC023BCCA0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3E42D3ED1;
	Fri, 19 Sep 2025 22:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g5S2aZE6"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012068.outbound.protection.outlook.com [52.101.66.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11B1202C5D;
	Fri, 19 Sep 2025 22:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758320433; cv=fail; b=CYiYmZy8SiLGCxRgwtSFQynWWIpqoE3BCGwTWsXCdRlUYWP+kNki8BCEzSu3i9zx4xErYhPJ2l7rmhHKAhIkRKJalkXQFBHpaRfSEI+HbXv9MIArIZ1SIqLkHBWrgQlsAlRLrZB/e472ifGm/udOoEZk+CUx6G2qRvKdlF9M2KU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758320433; c=relaxed/simple;
	bh=dazljmAAmJ+Iul7wV5e+vn0h9Ldb8ucTaRmULsZVNT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YFAIkEymF/g0aLVUpzFpm+RWyyoATDHiBnRYEJteZ4tPXZpaXQanKqH6ym5GRc36IVP3CNFUjOFQlKNdbvf7vQCR6IJB/NF6E0EQZ1H4gNNRRZkKS9oUkxR6UY8H9uuH00p26cqZFmsB4SJHQYOpG0FplYocafI5awSJu9wKEwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g5S2aZE6; arc=fail smtp.client-ip=52.101.66.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6lYltRmDkmi57x3R/n5QONUYXng8PziKRszCbRBMy9te/ngL4QnsQAL0f0q2z5F8HDQ3ie0nyQz9P+6/HOAnPDpD0YyW0uJmC/qw1Bnz/4oId6sDpvUZ91em4N6k6n3dqqohceF2t05DdbSbXZ3U3AdwsmQbqKzmj+Xgn4fd6SwCyQUXiTsfU7L4y6DoInNvUrKuuSKd3rRe4L//oiEtyExZbvf/8o/0FdzfkcywFMA4bRB6xJn44TesaK8Bq0u5+oXXp+MQDtezZP3jF05mpLSAFtf5b0boy/7dmF6T+vlr6bK3wpVeDgB8/c05k2WDR69SpoBGa7AM+W2RuLp0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dazljmAAmJ+Iul7wV5e+vn0h9Ldb8ucTaRmULsZVNT4=;
 b=bX/j3Xp/63iY1U8IEAZmje4EBBvy8yq4Fw85BAxz+vTQDx5Dpw37kYNYcSkpFNdyAiMTs0CBYZnUiUiLkZefrP3h0aYs+u2/pwyeVPa6y75QF1zmXoEzXjfh3irWGWduvHJVHdK014nbXz57qGin+xQmi3h2aSvWVnByKmp7EBAwiF/6YD5HPocWMT+45IteRnXawGgjg7L/wMhiwu99bxuba9lFB9zv9ImgbCMkhDbqlp2XONUG1vloGKArcR8qarXPKwM1uAHhF/eXkafaNRjeGGOUg/USoQcVwIIePueJUJN0+y7G35IHey2KeMxofvRwa8blmS9iDpfC2xRKNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dazljmAAmJ+Iul7wV5e+vn0h9Ldb8ucTaRmULsZVNT4=;
 b=g5S2aZE6Ag/DwWrir3nIAkTUJEg2hTYrjBjYJBp7MHpt0NI3JsF2HW3J7xOAEeOecd/Jf6osjnmswiS3i9jcL7Qs34gZPLKFGm0VQBhCUDWk/wmMT5Kjt7C/kufgTD5ahrMldv2aE2LEcuTK36ZemUjqO8iMk9Wv9O8z8qbWDcLsAG4u8vvXy3FmYr1geJfwEgUBVLFcX4y/vzxjB3jHpOdrROigjzD57W5+WuoTCbqpXfFSM5alu+puV/E0inuqVBQQn9aGKr19o7MntXB+uyK1aNn7iTzmI22oy23vgChyet5aSqdOhtO4zJjNIWewMLc8HjdqfJvcDE0bP1Gr9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10304.eurprd04.prod.outlook.com (2603:10a6:150:1e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 22:20:26 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 22:20:25 +0000
Date: Fri, 19 Sep 2025 18:20:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"bjorn.andersson@oss.qualcomm.com" <bjorn.andersson@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] usb: dwc3: add layerscape dwc3 support
Message-ID: <aM3XHv7VcOGLz3Wo@lizhi-Precision-Tower-5810>
References: <20250602-ls_dma_coherence-v1-0-c67484d6ab64@nxp.com>
 <20250602-ls_dma_coherence-v1-2-c67484d6ab64@nxp.com>
 <20250603012259.gyat6ungxyufhhbe@synopsys.com>
 <aD8NxfmJjSMeQKOu@lizhi-Precision-Tower-5810>
 <20250919211703.gbaqcc6mhtgolomt@synopsys.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919211703.gbaqcc6mhtgolomt@synopsys.com>
X-ClientProxiedBy: SJ0PR03CA0376.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::21) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10304:EE_
X-MS-Office365-Filtering-Correlation-Id: 51631d23-3450-4e4b-ef87-08ddf7cabb66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G1oYcc9jb5HHvQYomOsMLv3zi3NuUuRFiGiYRprtyfyh3Atp3kRQ+Xd8Apiu?=
 =?us-ascii?Q?5huhHGZ8I2cZIYBQyotkzOqfdCyAz8NefEu/35P2284LLmQxpImdJhilJfu3?=
 =?us-ascii?Q?bywBKTq+mUdKxzLDqk8VkGtHOJoYhMuSVuWVDBEu5zILb2Qy6/L/vBQUnM3l?=
 =?us-ascii?Q?N68nI+Tk0CpDxxsUzstcCfwCIboSRjT7AzsOPmU+v/Gq5uYgOjIChKG72Fqw?=
 =?us-ascii?Q?TMUvvUiJtwADY9OL1Z0U87iDe+5vVLHg40miBYy7qWfZzt7NyOHqmi14ayGg?=
 =?us-ascii?Q?kTR7544DkJ0Cln1ZYKPw6151gr/4J34BDKLKEvKMHD4Qtd0JXwC5bInalB5L?=
 =?us-ascii?Q?8R4A3LGUgr8l/mNUOaS/Y0h4PnwoBcNCYxoJ8VRcfoO1PNT2CNKqeP80tXka?=
 =?us-ascii?Q?NfXw4qKnf+xj0YN4oWlf6PVrsKz7cEFjNtqVb7+EuDMYfRByNtnnd+hxnRb4?=
 =?us-ascii?Q?j1+Hm5ckXkDb2LRnYRrfxHRtbJvlMeTfxbhahiB/1jt2KNZmcoUnpGdOFpZv?=
 =?us-ascii?Q?zkxSdocWh2sG3eaMsQUDn5C9FtXux/HgovomUba9tZeC4vs3tKlUZYtCCDRQ?=
 =?us-ascii?Q?v7jcjfW4MWZpG5lhR4U0BwUng3uguUzksNuLw1Y1CwCB91b4pHWOteBw8xF+?=
 =?us-ascii?Q?T8PPHw8SGfTlIfOrxlBcv6TAamuAXv/TJ3b1YtQdBLi4qI9ZRI4DixaWyOQC?=
 =?us-ascii?Q?RnxP9kO1XhPrrFTTfxMISrRofgw+Lc+ZShCvKThODILaOleWEJirak4VWFno?=
 =?us-ascii?Q?JW1BVX8ybrwyEgkHxDDLYzILgo8rFw0q8VeCrxYq/SSrSj05DbARVXBtXaAM?=
 =?us-ascii?Q?erBSDbnEAGtJQ1Zm5iNzTAvOBDH1icINEuMh4GfQ+KuIVdmUV1Ruv9s6yiPp?=
 =?us-ascii?Q?8O7FxvJScmtMxR8kgtllLZiXiy7A/nVP2t3d7rb0slPbvB0jGbB/jpea2DQM?=
 =?us-ascii?Q?r4ErVmjyBYn0KZa0pop/jInOu2oIqOZzB41BsAK0H/VrAlZdFYUTuRrBL1wE?=
 =?us-ascii?Q?rMyHW+E4H6uZGXWl3wyxur5Hb4qByUsM8aGJRQ/eocRyr4wSmajWab9jGFeE?=
 =?us-ascii?Q?xX4ru2D9GbdUfaR+2/ovPC0tivpTkLlXxD0gjtAlWy9DbqSu2ai9J/+65OaH?=
 =?us-ascii?Q?9MoQvJAQwOYzdkm8wc0bEd5j0fKZ+zHst6P6ZOpbDjM/IvOWu4iBMoNShLZK?=
 =?us-ascii?Q?OdJURkYSoSiCsCpdTLrbH3a+FePFNJVkAiVR6nKY2G6iM0KMkOuvVEIGqtnR?=
 =?us-ascii?Q?+ciGfowN67G2mATw8EUvYZEqgWQdyembOextMsMlOkJoynPji6X6KYvkmIfo?=
 =?us-ascii?Q?qFqgUxufEcwcf4+p7hFQDIrgO8sBd85UHjYOG1ha0F2zZHBilnBKKmjW7km/?=
 =?us-ascii?Q?5uLJsO5r+k/rogfgyPwHjkZ0Umk+eSVw2eDYpxsXEYdGsXfvSnrXVNFs/7Vo?=
 =?us-ascii?Q?IwFoYXrUAOMMAHAHGvwgW0T5Ka9rNKxxOELT+7thVMS35GnRB0TS+z/VjgE8?=
 =?us-ascii?Q?xbiJ8KjLRKvUdqk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IWr0l9b4861x1QSzwK4eBhhVTL2CLlpLW6c2QOfywQmej4aO5PwBoFkLgI3O?=
 =?us-ascii?Q?3jr45dRUCGikQgwlIZ4W4I7b/2pEXz5zXNOVtkvQY4+ucYWj8iBRXIEBE/Pt?=
 =?us-ascii?Q?345yVrBEKwYt9OVu3CtZNIYpJLa5sIO8T90AXBVLc/wKme+TP5NBUh3GiNR/?=
 =?us-ascii?Q?cU6D3K460TMi6K3ZcaguBJNwm6hLoowvRT94lQ2WCR1p+1p+5TaU8Zkcyt5i?=
 =?us-ascii?Q?lWuSZGnI60BCKn4LFD8C88NaNbYkcHavS+GtfIUB0ngz81KvwpTJ2GqGPm7F?=
 =?us-ascii?Q?Zfy9UzlL2XMxqXRNvltwVH5k8OBXqD/LDUjuOlZ3x/VRuNhxl5b2ytDX2s0h?=
 =?us-ascii?Q?3ka2yYLsgHHRQcjpLXzJ5sWX5B/DJGbykYn9zDVeZUpWGpbddesBklQ5MIcp?=
 =?us-ascii?Q?ov/lAHpj52RGvNqfuqKc/ofOsWKkfp9WDDxGcy9lojA2Lb77FEMZB17pM2+s?=
 =?us-ascii?Q?4g2I3qW8bNzcnZoGBxPqlstjg4Kp8yC4MpxxvxHB2kXXsHuS2pBOobVwWgSU?=
 =?us-ascii?Q?6+zySL8ZYqoFr0BsA60z8Cgk/cD/QpKPCMGI85ITQNJ1vIudOYLXzV5NxH9d?=
 =?us-ascii?Q?53NLRI1vol0GIwOD1gEkTbiBgvp7A3VKnVl/0Mj8lEvQkfi/2S2/PYYv4eu5?=
 =?us-ascii?Q?jxl0wHs0D8c1wbHt0R4S8331xfRAUdpyP4Z2TeEB1ZBamz7PNH48Pq4QyVCl?=
 =?us-ascii?Q?8AqvKvQpUs2rhzwNzd45D7abwYRJ1/W64zFbymTpk6VR2cpbDy6ylXfaiGIQ?=
 =?us-ascii?Q?YAXAuADiYAQzq6WRcSyToHstK4LGrm/kBad78W1KX6Uhnvi6QxQASW60UDOc?=
 =?us-ascii?Q?WhNUewU41NpxlmzY7F5nkI2FGcICNRZTCo8oumgvmxGU14gkjdSzwzuG6mIm?=
 =?us-ascii?Q?XUXmI2WshTuBtCxy19Ll85n3EyghyqPykEz8YWjlnnFV+AFL8enge4O6vkyj?=
 =?us-ascii?Q?9Nw6XK2PrYSgo60+hSYOs5kBcJPcC/iDM999BJQi55k1SRB1M295LmFfCVJC?=
 =?us-ascii?Q?fowd/gXv+uS5TU40Brh0kqofQe/mu+63xhRNMGxeM6u3UnkzHuSGWXF9Ff6r?=
 =?us-ascii?Q?YnuLclB0dki4agO1fKwnSo7w3lJuc20v7pootM1lxcYCaumVRolUEr8zxLLc?=
 =?us-ascii?Q?vWN28FYeAhCBLxXQOLBI4gLr62orBsaO2YPAAh+arMWJS+PIehSLtGgUTkTa?=
 =?us-ascii?Q?Swl1FEk+u9DGvLyOgpS3teIb3kP5O4Yqi+I/3ONLSlSiJR/Vidl3wiKhZUmk?=
 =?us-ascii?Q?ywE75yLVJrAseNH4wPtXfradn91WgR6NHwEBxEPC3cL8DQYm36kZVBtNAyGu?=
 =?us-ascii?Q?kg/BFG1CTalA9oLx0BiqTsKStsPRsQSI78Qk7WAD4h70ZsmIf5BdUb2TiRdP?=
 =?us-ascii?Q?q6gN/xKt/Vs4RrFIkPRp/PhUoby8dC3YnpNbcEquh3+VNuzipLHhnDmJSN6d?=
 =?us-ascii?Q?TldgKDUN9AJ7YCvXfaJtQfMVb1e3LOvqnOQUPMLy9abhVnn/XKTDsMHtmG/3?=
 =?us-ascii?Q?YbzuSmTGu6fNI53py045JSDacfPLq3ethZgoGodxM5W38hl8i2MKLENtn7wf?=
 =?us-ascii?Q?uB0KqfcjtjZuYAd/QmK22EorHAv4ueCj1471qTiz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51631d23-3450-4e4b-ef87-08ddf7cabb66
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 22:20:25.7808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +c6Hte03X4usnbhkHMBXWoqmzUpwjOknftkjuNhKAZLx8mAw9OC3+80D0tPJufsEpkobMkd1g8NbuNoqKKN3xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10304

On Fri, Sep 19, 2025 at 09:17:04PM +0000, Thinh Nguyen wrote:
> On Tue, Jun 03, 2025, Frank Li wrote:
> > On Tue, Jun 03, 2025 at 01:23:03AM +0000, Thinh Nguyen wrote:
> > >
> > > Is this something that can be enhanced in dwc3-generic-plat glue from Ze
> > > Huang:
> >
> > Yes, I can base on Zehuang's work with little modify. Please let me know
> > when his patch merged.
> >
>
> Greg picked up Zehuang's changes[*] on his usb-next branch.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-next&id=e0b6dc00c701e600e655417aab1e100b73de821a

Thank you very much. Let me work on layerscape base on that.

Frank

>
> Thanks,
> Thinh

