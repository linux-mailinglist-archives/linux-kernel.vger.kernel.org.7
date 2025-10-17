Return-Path: <linux-kernel+bounces-857215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48436BE635C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10D3F4F13F4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 03:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026F725228C;
	Fri, 17 Oct 2025 03:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Y+EVfHYd"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013043.outbound.protection.outlook.com [40.107.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7182019DF8D;
	Fri, 17 Oct 2025 03:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760671790; cv=fail; b=YJrjNu8e9f5SCdeiN5wxkM7M+I+OeSibIqdd7lXKQGUloOiOVqRpUElRdeiZS61xnbRpj/jNGUT8LZzTLbngL7EBH4pPlNPOvfGLH1RuYzP604Zip7sy910dMVh2OWDXvKbGW8I2mZFCQ4uBNuMteY0HjvqBSnKV3BFcLr8snk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760671790; c=relaxed/simple;
	bh=jvyhwlMkxkrjV3/+3E+UFE+4X0putaqSvy3YtOY10Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sUzyCOQBiLYz8OVvm+MXDF3Qk/jDTPc0n0RqiYV0T4jT+Agt0O9inezKcqvbdCz7OTBAhVAWP78H9Yx5qoi3g3e3aeQlKP2e4zmEJTfFFTMA+dE+Rc0oFTfccFvQlVlnvCQaw/ktj3QFm8cbrUeq5W0Sumw+ytAysVbuNb6Ivaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Y+EVfHYd; arc=fail smtp.client-ip=40.107.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfbzRFE4brb9JQejD2wdNC7RwzPvi+VSzrDM02fHJk0e6v2e0SFtV9rUZp84UichJcGHp+FvdE9tklih1WZvy5SyxYqD5ULM1xNyY6MbI9zwnlYYMF8jmuIJgLrelMUZvWNDb4SXxsQw+soZJGFcHCqH3dQrm7piq85852keGE1+VZ24N3gQ9mWP6BqL8RwZd/5lDG3cDWliU7OdySqARlsDX3JktxPIAfaTjvOy95NwvRRAHztPc92/dHffMUBrPpnhudnW17L+HKMv9qq+TE+pJ6I1IgAT8oHadjU46MQyKhrxYMqeK9v4ZqKPLP6EcmWN5ira373DUBhKf8RYRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J72+ZS3jG7runGLgwBrdi8ymWi3KINO5KLEGdDEZtrY=;
 b=ZrH3GnnCDKPVD7ED3iN8LcJ27wg/xinAp6Nb0efEkXakQpNptziEMBD7CSZvCXyOi4HkfFNU4yFMZK4PtSchhD9D+tkSWGOfb8fGmCI4IGAHe5TJye/tDU+j6YcdBtD3vBHo2KDhFddtsyNElT0z00GHRZnkNSgCAP0Waj1RF4CM6oTkWcajZN9IezQAF4bMmd3apJR5pKo1sQq/GDwYctkkJYFrdfMQ+7nNk1yWseUd2SBmTtMeiEQuSRKdtPSoS+ZoPDvqe+SALA4JctigTfxJhRui3Wb7BxH1bg0Xw1Te3OhOGFCpv/PFI8CPdlACPuzPTZNxD4nydGAm3vozVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J72+ZS3jG7runGLgwBrdi8ymWi3KINO5KLEGdDEZtrY=;
 b=Y+EVfHYdvFI8thnmeHAmlM+i5KuxXD8U2BI2V/epcjMUyiOWy3EgZmSO83+C7GNlPSQpwHkBZ99NFoG7hDjvSowSsPAvz6hug7zUpZ2jZAzhtg+NintLMLENeIHyFvOUVIIEEgjJQwq6HF+0ehuFDnSKX1YEnZvFkdlPb8bl8OfMJPjnlc6jhY1eWffpluzMdjdH5CrjfVBUZV+1zlYuwf+FeyTUzrF6W4f0cB8k7XljyscSPEbMpefz5uAPNfe4M4g9/DYJVYmLlMfpRzxseMu4utt+1DgAU6HYfQ04L+gn/MiDsiSv+afJtgFH0Psj7steTsigqLLT9Zz+4UhG9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by PH0PR03MB7017.namprd03.prod.outlook.com (2603:10b6:510:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 03:29:44 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9203.009; Fri, 17 Oct 2025
 03:29:43 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthew.gerlach@altera.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH] MAINTAINERS: Change Altera socfpga-ecc-manager.yaml maintainer
Date: Fri, 17 Oct 2025 11:27:36 +0800
Message-Id: <20251017032736.3206400-1-niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0090.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:22::9) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|PH0PR03MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: b87a968b-ba46-43f1-ac4b-08de0d2d69f1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M/bPQQKKKahcXRLgY5DmyO0Wh/P/8f488xb29JdXsnIpg6V3lapkaxxA9Nhy?=
 =?us-ascii?Q?oNjqQSAoJZkmoCzDst1tF5pSbvdjDWllnSnnWnHKqrbQqKAReqg1zZ4IXX0G?=
 =?us-ascii?Q?1bwBI++XXSGVeTBk6gjCpKxanH6SkOiGymdUpZeaRbUpmSWZSibkPht4iQmR?=
 =?us-ascii?Q?a/+yhzlqfZgi6dvFGUjqhSNh0vWKat7sGKz7uQ6c7I8+FoBUjml4mjcZlqBZ?=
 =?us-ascii?Q?178+mIQRFjj6DIwiBMKd0hpPyWkfrIh7QOp7h6OUOw5t9um9Bvgp+cRRQAFW?=
 =?us-ascii?Q?RoV+kOyXQsJAzcQ9G6xPVX98HrI3WM9TwJwZ/qxcgCDbEVtsstBmBDo4S+Pv?=
 =?us-ascii?Q?J+gs5i+DUjyqk3Dv7Kz3C3yq8Nw1HNX6Ao4ySWkFzsIPEmuf9QVsXVv7sNB1?=
 =?us-ascii?Q?Bh/pKrcYyCQo9ZdeN0UN0NRtPMu/BVRp3alyh9onFNYWZD1ijKng98bWxglf?=
 =?us-ascii?Q?JAZisk1eFaZbMwUBfsBQJ9rm7gaF276Y+/z5NpmJAVsJ4rTjcPaY5pH6WNiZ?=
 =?us-ascii?Q?ohUPTpzNJ7S0EwK//6ZgOIUVPwFBQ6qIgMjXA9gw43mcWvai04Yhc5dhky9z?=
 =?us-ascii?Q?buzQ8IdDAt//e+3+0pOyw7avia8duN9K4MN0eYx2YA6j/whvuFzPYAZiR7Vf?=
 =?us-ascii?Q?MC1CKOfSdxMm78FHOxMF+kSJNux5Aa1cluxsseNPphQkRjxGde8CHuBcaSnv?=
 =?us-ascii?Q?YfM78D7UZll6n8QMwE08SqhSoZMJ7b+TqGqIa3zgZWD7OVzGlCLt5pzo+Rsp?=
 =?us-ascii?Q?neIFV9zmVoqNd+teO/7meo1EmTj/4E4Oz0lobATKCgmvKp3DglUxawIlJ4rT?=
 =?us-ascii?Q?fzznAW8y+xLD67QYxcjwmt62kS0NtmMBzRBGYRk558NFf0EUYac7MLgVExS5?=
 =?us-ascii?Q?vsankOHRxW+21PvN0mn1/ERD2GhxFbXy0imge94y8NY0d/d0VM1Vp0YjzTui?=
 =?us-ascii?Q?XCoUurI/lcywdbff747z3jnYWCTiGUl9Bdwgi7oP8+kEdrEpSGCoVNmy+qtj?=
 =?us-ascii?Q?TOROZwgKApWZ4KtiY78rCgXUTUDaLx9Eo532Ym43dEYjv/LjznLJrVINHBf5?=
 =?us-ascii?Q?ieNxaE1TQQ1i/EjJiao2qdF/dEcLTYQ+JyVLIT2iA4bziLBg0owd3+wOFcj/?=
 =?us-ascii?Q?WBXvCCsMnYILucddHBMl8BFPgUQnWW0o2tMIe02JUpH/7kt1v3ncOOQP0TzE?=
 =?us-ascii?Q?0tqE/GQyD7mnoZHbzNkr1qKqfQycx8tx7ouN2yLxe2JS4n1ATZ8IxnlV3ZzK?=
 =?us-ascii?Q?SpR5GxruZ9lkZH/XPWAZZ8Wtv5uHhQQ3NvZqiDhx2oEDsBpny3D84HR1h2jW?=
 =?us-ascii?Q?5yeM4/NYz8bwH9vdTI1jUrRrR74D8/FBvf4AiGuFYhyQdT5/kuMil+Kxlx1P?=
 =?us-ascii?Q?ms8yKlMRhmptbxREblGRBY6ls5U8/dkj7g9+5cELCTiB8YuHprGLQKJG+hUC?=
 =?us-ascii?Q?j2MkK4ljP5HbjHgq4j+cA6md5JNMdNxmEm9l2FJpp/uUD/prfyqN1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z8R0Tx70jlyq8Vse9FYeoDv4vQcWfYOJuaKO06rzgbGZpDNYVNOgnDhAQEgJ?=
 =?us-ascii?Q?izZHszRWgijpUWJZVsZhpqPu0ogVBS9ryuKlj6gMRodXgXR+aBvPyNEStqEZ?=
 =?us-ascii?Q?2Pf2DXWX2foaEUMzPPDV6bsa+gi4Dm1iMVxTPeQMQpQ6xPvUmkjDehOUD7/I?=
 =?us-ascii?Q?rIc/DdcdSLOYZpb22e8Rpufrpde3L8idBx2xNayZK0eRrciEY1vbEcZ2t51N?=
 =?us-ascii?Q?xHIa08fPXPHxCFgiMq9g70t8eymQZbUNLz+BwLK8phLXlUZjLDTnYBEQuJfk?=
 =?us-ascii?Q?jecdp7CN5Z9CZMpZ/7C7WeCZTLI8ypZMIWY/Zuf+DdTcPjD0KuW4awXPavFa?=
 =?us-ascii?Q?E5fecYUPdkFxVbVXJcp8OWUFgVKV4B8udHNiSVop1uvBO7oRWdufevVjyqiC?=
 =?us-ascii?Q?YEysweYAmS4hVd5jctCTzP+knhFkxKUlkUK81YUquOHLPVVM6dAgkRJijufY?=
 =?us-ascii?Q?qY0DXIUhVgUKJwsv1kU3vMRW5hRya0o8mAH5+fkv/+OrL2dmo5HbzNO3jqvY?=
 =?us-ascii?Q?WBZ41sxKXgW6qtv0LYSvMzgeq07RsZnhxz1w6HpDwil5nKd0iXihB04EmWWT?=
 =?us-ascii?Q?gCtjZStK+wSD0PiSJW827iqp8gAMRI6eDBvYEiDJgQMmcB2mwD1CVGJYISvT?=
 =?us-ascii?Q?qfdu+/IJFuTfeoRMMqESNocvWK5zGcMB1FQuXtQQYh1E20+tH6RMB+2lMHT5?=
 =?us-ascii?Q?L8EKO5zOrKJyeB6ogjHIg2ehle67gwV/uFNDyG1U2F9MqTzkJ0wyb/HVss4A?=
 =?us-ascii?Q?OXYQKzilPdQl4GOxjJpJS6cz4moqQmkFiURNUud1cYKXmrgNzVozNcptuHBr?=
 =?us-ascii?Q?ogesnnm/bCtNuXCMNh6tSIeyNE1nTPRA/b9Xu/yjlY1QbUPI1hWuQlPgjmAL?=
 =?us-ascii?Q?THIhRKZSjzBTJPhmaQ5t4UIIM7ncbplzZ24bmwJCZrXAycWhsrHMmbeEvIZk?=
 =?us-ascii?Q?hhdEVgDC38NDszQKCQuRgd84elLohFqDzm8DRZf6+fdIMkL0xtiVL/7lRdMo?=
 =?us-ascii?Q?r4tC++R9b6J6ZexT1FR/TjC9Bko++QhQr7Y6WJQAlanByN6VRIwFTbgj/4Mu?=
 =?us-ascii?Q?RlVPQdXUQJurJJX85e0+MojfhFyiKtow3ifcRipmV3HZslmlLbx3hWBFGsiN?=
 =?us-ascii?Q?VJITaSQEdItb6rv+mxsYea13gRVZGIHCG3tBy/5zVNVW2qM7UCNvhniKjrVZ?=
 =?us-ascii?Q?s7pQJxQItSifkiCTLOmcZTkYTrZarKCxh2E9R5zhExlzWHgQXYMeIovyTpJm?=
 =?us-ascii?Q?T2HELpS7jPT5rOS+hV9+q6MFKq4mtUmFRzAq0K7OepHoXL28tpkqO4a+XrTj?=
 =?us-ascii?Q?/ResziPduIbOLrn5kIhHb1EwtcYMmCH24/vfkL31nb2HdK91WslyXz2TkDJc?=
 =?us-ascii?Q?6Xq6q72zL7nNsF6g/FG/mgSfRhRbifjc8ETZO7ZJPs7gdhVA8sMq9PFqk1Yt?=
 =?us-ascii?Q?5BmjN18dUVHS95DU3kD+6HOkEvUx8pNDl8NribSKZ/Ikpapsk6IEP/G3lgM/?=
 =?us-ascii?Q?bLV00x1NaaXb0k8V5tYYdHgffk5fSyKN9ud14B/+u8j75B8aRoKG+EyR/78h?=
 =?us-ascii?Q?EOxk8QZZ/ywSq1FGRQBI67UQrlskWqRgLYbN62Raiv2XAHWCAsMBpPnhloEP?=
 =?us-ascii?Q?ekH2/P7lXLZ59raiqNLjlO2soDC6mbz4fl8rtZZ7a4Nu?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87a968b-ba46-43f1-ac4b-08de0d2d69f1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 03:29:43.9149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00Jt5sJEizz314wAF/hdYseX0MfMnJKt45kO/NyLlj326a12QirZ0dvbQUPokKIW37C+NzmzMwaumk+x8PK+oqlrcrLsTAhanO4TTa8lUjad+IAdvnLTOH1dX6J79vGZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7017

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Update Altera socfpga-ecc-manager dt bindings maintainer from
<matthew.gerlach@altera.com> to <niravkumarlaxmidas.rabara@altera.com>
as Matthew Gerlack is moving out of Altera.

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Acked-by: Matthew Gerlach <matthew.gerlach@altera.com>
---

Resending the patch with complete maintainer list.
Link to previous patch Acked-by Matthew Gerlach
https://lore.kernel.org/lkml/91cd7ccb-e821-48de-8d52-f8889af80a08@altera.com/

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..bd97db99e75e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3362,7 +3362,7 @@ S:	Maintained
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
 
 ARM/SOCFPGA EDAC BINDINGS
-M:	Matthew Gerlach <matthew.gerlach@altera.com>
+M:	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
 
-- 
2.25.1


