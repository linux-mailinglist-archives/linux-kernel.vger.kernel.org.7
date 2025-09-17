Return-Path: <linux-kernel+bounces-820078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 414D6B7EB75
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926841BC2484
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 06:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D6D2BD037;
	Wed, 17 Sep 2025 06:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="cO65aV/U"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865F32853ED;
	Wed, 17 Sep 2025 06:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758091503; cv=fail; b=UQFT29iqybTDVkT5JRuXkhpg1qNsG2MtvfllvmqlalUYAnVwFVCUPVdck9/ClC8k2KUxd+giu9SqU7pwE2LwqEqdxnXJcotW0tj/ND2/2boN620uNQd9+hAtejK9lkUprRVdS3VkmPKXZAmSk4SJ4fdODcRKW89SOwgWM9Y06qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758091503; c=relaxed/simple;
	bh=xkKULkV7tunBhcoZXXgLiK0oA2ULDH+/IWUmaIbVoBk=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CKkUXIUC/dtodgIAIas/CrdO3fFJ1Wp1SaC6LTKMFcYNq5/p9GPQW9LKYlKWtgSrMJVQsf9l2zY/FMfmsYc5Gq9Zru7tJdOnQgL1t2xciwc0S26xxNKr/QokmwYD8Pvn+qxPIZNPF0biVTZ2cFU/Gj1uvS+GjqHcLMsSOqaShjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=cO65aV/U; arc=fail smtp.client-ip=52.101.52.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8vS84/ODF7TGWcUisyPKHjvg88yAe+/i29nY3yu7nekLDCJc+zSRv2AByoLDJXzXYolUn8ZAwRUXcPBo5cn6G9YyHFQCftk61NwsVWveuv+xreV1q/ymak6XT1ecR3/7aT067+iGzr2EaGrkgxHKSvCcDHxn/LFSmCsv+l1RPx7uTlmLJT2vNMU8nxM4LmUcFcQk91R2VAg9tPwnRyK+3ah5PtuAkgX5umPlEtQPwVPFS7QIm5OLy9SBZ/3csZTBaCgRT+M74dAKqXPU8Ecubbw5PYFoKvv6yDP86ESpYjSDGui+5eVqL//qJRJe5fF5nxF+epQZTXhpaziNgg0zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOXMLPz8JhPh2kACnW6/COuN7QZNxlwG55/nvefTawI=;
 b=GilW14IZZ21FkGQWd5OYTRCXukIqJqrE3VXJTET1A9jdMnBgYF31kNpxY4QyBHK5JpGgQtEj1yWR8u0mtErLaWPuUGOSHgPIbFe662+XhLoaoLBU58nGjq3QwvKX3ceZaNd78JbwuVDRB6V9ueSiat1GEtBNlNsMXoDqUwy5kBySBFYhoj4A+IxHG68sttB8xrIrgBoMQAQrYQ5BorTksuCVXl+mLDxZdDpgyoxtRVeafa+Cw912OCmqg3fBM5u2yg+ONEYt0Viok6XjEPIxxqm3qompTbJX1xrh/f6iYjr2h5Lz8r+6i7C9ixKMUBOff/yFHfaALe8jRkqbzDousA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOXMLPz8JhPh2kACnW6/COuN7QZNxlwG55/nvefTawI=;
 b=cO65aV/UMQn5fsPpNkLNEMUZRrYvBn61vq4yHzNVKUuog3DBdTln19Y2JY2U4qulyqrUB00x54wDUCuqBkxISmZsupYNQEN5bJHyVEtdbNjQRsZ93JCuyMbRAhT3kTJFzwerPCoPJjCW5S41wipQIhGjZ4S7rIaPo81jj3HSNdHRfzEx3daVI+PTreAjxW+xik1tppH1BGdsTa4BL8+/yFOJnOXkgAuGHMQ+boiT1FDFtO5cDzrg6tQHesTnSE6//5+SabZOl1M6yCfhtWxxcNanYlDbWcPUFyk4NuN1mkYkOOST9+Imm+oT3cLENnk1PWTBsTV1x5kJzOoXerBNUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6088.namprd03.prod.outlook.com (2603:10b6:208:311::22)
 by DM6PR03MB5338.namprd03.prod.outlook.com (2603:10b6:5:24a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 06:44:56 +0000
Received: from BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::76:3ba7:5679:37e8]) by BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::76:3ba7:5679:37e8%6]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 06:44:56 +0000
From: "Fong, Yan Kei" <yan.kei.fong@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v3 0/4] Add 4-bit SPI bus width on target devices
Date: Wed, 17 Sep 2025 14:44:50 +0800
Message-Id: <cover.1756881243.git.yan.kei.fong@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::35) To BL1PR03MB6088.namprd03.prod.outlook.com
 (2603:10b6:208:311::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6088:EE_|DM6PR03MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: 252c810f-7319-417e-5475-08ddf5b5b69e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qzv8xgrWbdn/eflbf6MKSJw0zHzX1Sf+kPHt+Ab28F9z8yOrAUg+8EJtrEYW?=
 =?us-ascii?Q?918dcEDD1X7yBkgGK29nedzo0R5dtfGcf9lgMFV2a3nqlx2SCgO8RHNZZ/VS?=
 =?us-ascii?Q?cir38Gxpb0qKXj0ccD/vgJQej/jOSTcYvtKjS2eXZ1Qo+Yxd7ZsAOmJtLtQc?=
 =?us-ascii?Q?Pth458b288L51RJsAAqON/bWKJ6KpjFo3JZZ3tvK9zf723CZkJvEWOyhvLII?=
 =?us-ascii?Q?YZy5pbImeapBWm2QOwkxsxN5wNLRvo0tWgMZrCvE6apJTvZmUDREOnnVnc3n?=
 =?us-ascii?Q?BkoRkRtqOMX/9FLSkx/KWKfwenZpFJVUSzlUDzSpcV8tZ4phgjyxhhCsJbvW?=
 =?us-ascii?Q?97Fky1kNIlHRvKEXtkJigHm3GEiPe28Atpt3hwgg3NxiMNR3xm8RdFkxvvwF?=
 =?us-ascii?Q?4FEN8jvza7+LlIU6qSzu94I/0CWCrtMw8JjiSPCxUfv1fZrcZzpkO6+s0VSM?=
 =?us-ascii?Q?1bcpdcq+gFPomldlJha3roufyxu2OFXJtTrqUk813Jkk/epYuFXVrGXQ34KP?=
 =?us-ascii?Q?e9TIXtB3t74zSRI4g43W7z/1LEi0InCT67VkArtLY1XeooODYnpL5wedOp5A?=
 =?us-ascii?Q?T/2wAONDZkDRrxWLjv8DsU99YRAbukynON8xp7uuc5dN7654nNDpoPQOicvo?=
 =?us-ascii?Q?hMbvHE+wk2jXwUp9F0K4MA58m0J2QYb4jf2uGplucGPWiuIsrqj8EBk2I+BP?=
 =?us-ascii?Q?a68FIwztdspa3tPDz94Nv9wB49aNeAyc5KpDVa0DqsK3Yyk+AiWyvqZA0uNw?=
 =?us-ascii?Q?8255xxRAvGzs984bMn+gXyEmfpVX8l9hNPA1MRR5cKhcuencaQgpYpT3niE5?=
 =?us-ascii?Q?5RAr8adt9UifJombXeyks5gsKjY7vDzDf++D7FSrfgksvyMxJgKcjLKNEsyE?=
 =?us-ascii?Q?uX5KOUs74vUr5TX+Q1IkyM5vwFWIkpoaaXtXw/7A2L2NuyfinJBLdTCbKg7b?=
 =?us-ascii?Q?uHcJIdUupBGDCSCALVoxdsQ2y7FEjE/OvUTWnpHe460WeacpdKCmgDbyAkKv?=
 =?us-ascii?Q?gRtEu5I7poNAhfBqdcwtYn5yboUfh2+f3y1MDLhKoqi4RstftxoK+aSxp1Tw?=
 =?us-ascii?Q?ZRgwxu0C+8q2XTOu7mWCFpaBjrXNeSYRfGikLLRZnWndkWxmZpGld0yFKyMR?=
 =?us-ascii?Q?CA3EOJWhtNQm4GMJU2Aif6t7Qd0mYPRO2vuqXFbsJhnrUM+2gd8yTrdgeKse?=
 =?us-ascii?Q?hKC9Jbdo5y9aQJDTXEvSCizv5HoDT0I7odWFGqXYHMxcEPdTTNKVTDMKdMQT?=
 =?us-ascii?Q?xHTN0eq7K2uDDOX3yZqkcRcC7U1RHrygsX0k9wAOMj8JCxbfYxJFUMYwv71z?=
 =?us-ascii?Q?yvz/yVRM87ZMKVbQIsbUgCfOIhEKYmk90qIviufD++lVZ4TPyzI1gMq+kprl?=
 =?us-ascii?Q?6MtdVOGtW53FU1NK+89epPeMI0By4wvFrsk0XXcWruq5V7tThSviI5TAJm7N?=
 =?us-ascii?Q?cTVJuz5MXkk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6088.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4STOAxvpbJP9Eo/sQsVJ7hE7+5Z3Br37loYGYlX9t+5o8Kz8YH43aZVYMDAm?=
 =?us-ascii?Q?OdFZlAmKDEkwe53dEcwkm5zLpMPZxqiFz1XKO26G+W7CzH/QobgplscifwV+?=
 =?us-ascii?Q?vB3x870AOuFYfDyPlEx/RZFdGzCIYUnBSTy3FSazo3gERk0ElW+VY8t4E+vc?=
 =?us-ascii?Q?GlIg5mNZ7KMEUTL8zLjWjQ2v29uRP/eIznGzTDDexQMEfuXSD5Fdlew1H9hI?=
 =?us-ascii?Q?6AqUkmVPUXfu+d7cAxwUYNFdOxyUR+TMkAlXMLQu4ZRdFbH9+yNnTrWU0oSk?=
 =?us-ascii?Q?obpZnizgyUHBgSo2RkcSm8KyrZdd1rK1hFhiSIYkJHborMw432x4IwxgUkxw?=
 =?us-ascii?Q?nU58mCi2i4ejUQFcL16UEgwH7epnXIhchBL4b8BKffoeY9OYqlNPtl1U13Cu?=
 =?us-ascii?Q?xKPnNYe8vB1N2fTmbAJzoDWT5yNn0MGopAQEKEFsv6a+5y7W4XNAg8Ak5gaS?=
 =?us-ascii?Q?frZUmPmFeIsGtiQAq7+tYEdwTZooT5FZ5omJl8Cju1PoihZrrvpiqNqfHrtY?=
 =?us-ascii?Q?Wr80QBYLW/PrEQo1WE+qg7yOQ9jinSdGu3jvlIvKDt9hpfGPGPNInnSeGljQ?=
 =?us-ascii?Q?amQDXKKin9esfmFq3SjVeSD85FRoR2fw1Yinsw7B3/01uFphx/nA/+trAvwT?=
 =?us-ascii?Q?A8u014j17egtCJrP7orJd1W0/CKCS3b/yS67Z3eJYIr4iEJWRlV9GUyymdP9?=
 =?us-ascii?Q?35Qvwvdk+ZPBxeDB7KiG5vq+TWTRPneaNNTOLFOzNRssNMYWB1Ly+mhEFPBo?=
 =?us-ascii?Q?CAHyRDkmlO/80mkil8DqraGgb1+bmvDgsejEXnpp2K2dxtiKzI53NT6Fdk7f?=
 =?us-ascii?Q?GkkoxA3zhbS/7i3jz4sSxns5j/fY3XiQgp5c+KUrmtxSWUPNyeD78aKSixQe?=
 =?us-ascii?Q?p2mjKaIWJt83dUE+N8b/GCUhxg1T8P7xzT0IBPlNe4ytT0+8hmn++P9Hdczh?=
 =?us-ascii?Q?n/0CXizSnSRB4BR9ucVn5daI69jVL9Y0GGT/ZutbYhQyRTl2LIT8syvSqpm9?=
 =?us-ascii?Q?R7Qrn6Xkg9GDV/mmWuPQGx4qTuNUB4xd2Zg36fuKLstqupXWDLizaA9MPteR?=
 =?us-ascii?Q?nWoBHg4FsmRyOaU3zRfHvrIz7X1uLY/MVrL9oir8n/mfOtJykCr9InQ/AGub?=
 =?us-ascii?Q?58PI7Rms8WrryjxzCAYLdFMwWgEB1MLmfCieQMY3YdMDVjxHnsNs3ZOxRZEs?=
 =?us-ascii?Q?znFfqhQGtj5yaJIVZx6x7Y+TqnfmPYXHmoU8Yso6aqBCUnaH13Tyo4X3DZ1Q?=
 =?us-ascii?Q?gV5DCVMuWqbJdHZQ9nEURh3lDZjL0dUABI4MPhbHb1ZtYv/ujrSQlpu3GxFE?=
 =?us-ascii?Q?UJvLZvb5KlTukbaWXt+WMsCNcbRIg/ODzrrJRBC+kntqSpfEEXorM0pn/I9F?=
 =?us-ascii?Q?0w3xoiNPda/RHNCurwj9VKHNGFAI4oJc1oXMOKiBPTDnbKggju7ylD682ByP?=
 =?us-ascii?Q?8on3VDIDyoeu0v7M/DZPipTbgfy887ebo60l0gvf1gMOHs5cTBMtK2tyJEbx?=
 =?us-ascii?Q?xVkwpAWHQJjQOeBjWk6P4UoWWrAWVfshrbmFYWHh0hWd9WkG7ynp0aHp/+Ht?=
 =?us-ascii?Q?cc/kMNF7HIo4t87K9uTVqP6NCTd8B7vxZFSzYtQG?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252c810f-7319-417e-5475-08ddf5b5b69e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6088.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 06:44:56.1418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjkuSeMaeLePJ9DsbY807rzu9NemAAwykjOEqNm/CjIPnO69ZCEJwXfUVZ1hbv9enze0DJsyvO1yE5+ko+Z74w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5338

> > Add SPI bus width properties to correctly describe the hardware on the
> > following devices:
> > - Stratix10
> > - Agilex
> > - Agilex5
> > - N5X
> > 
> > Signed-off-by: Fong, Yan Kei <yan.kei.fong@altera.com>
> > Reviewed-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> > Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
> > ---
> > changes in v3:
> > 	- remove the unalign email shown in the commit message body
> > changes in v2:
> > 	- rewrite the commit message body to align with 80 characters.
> > 	- add additional reviewer
> > ---
>
> You have a series of v2 and v3 patches in the same thread. Which ones 
> should I look at?

Hi Dinh, you may look at v3 patches. Thank you.

