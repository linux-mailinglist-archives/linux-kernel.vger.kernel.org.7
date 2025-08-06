Return-Path: <linux-kernel+bounces-757450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C75B1C247
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E360F16D546
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DDA28851E;
	Wed,  6 Aug 2025 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ANfkpbmY"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013056.outbound.protection.outlook.com [40.107.162.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA112882AA;
	Wed,  6 Aug 2025 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754469425; cv=fail; b=gjP4JqqMJAYLX3pIZF4j4fzJ1PsnCw1uRFNxv9EiMTrzKRLOMbh8MAJ1mAjPe7krFNAcdjwjZb0939prxtXVbCnfbIkBTXUKoPheK4YmgzQkscqzZLNt24W22nshFNfKF/txI/mxeA/lU2pFpfRIoIrGLrMYHL7rYc7KGkddFu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754469425; c=relaxed/simple;
	bh=O6NS73chfvNWq5Em1qQPYUb8Xi21dbTvexBWqMo+a0c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=enXUliwmw9Cbnkrsh1m/Z0/d6z2c2KhxZHiUQoGsm0hDCORdJfGJ/AAr5qwbPl0/Nt3m5hYGrV1X0JQ1ZaC2FrFocR+kLC7CGczrBryKmkaxaq6bRHLCpJJym+9SgTKSMc0j47sCM6gUDXgwzRhdLvDHSNXBD8RhWxOhaauEJ8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ANfkpbmY; arc=fail smtp.client-ip=40.107.162.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCXT7lzisSBy7YI1AaKWuSZ1La/fW2+MttQekYCro+RE+mV1BLZDfCIEqkswEu0kZjxXfP7YPMBpedIhy3VG0J2giSVQ4I8Tp/w8KEvvRGBkBvTCiLNu7/ndWW6Ow3fckWg/P+JoPVSf0pLh0RGxLJBYdTxemhIZgkgltYmGGVaAIZOG7mRh+Bd3G2mfQd2fYORgvyYcax5vz8dBQ6x/D9vPmaHAKSCBgZKLPt2pmEsI0l1hpcbppqX14L1EdsZs/tGWdq7F4e0TiING+x9PG6NPRP+KzZCnmThu6Vo5TO3yJxePRfgWbbSqq1al72vuWtlVSRXddVzUO2d9lAcXYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tW2Rf5dQkFCxvDo1QfktfO3yxQes5+H2lVaVHz7cjbg=;
 b=DKWbDbSDFGwnNxHURnN3dVcB8Br8YONqXkVMP2pRSMyKOhf3H1KHcfngZgxVDz6euNr31KaExJF8QzhzzNMTNS5WkhHjv+y6J3jfA2LWbDP31V0F6T1DpO0dXF43R7eLzchONguFV0WI9IRhB6Jw1PsKoRl0CSvH+ubcNFZWaZlQwSfIRdrzo9tufv1oh7irlVOmq8Acmg95RvGZUteyoRXI0Z6cPRNHVGg/0xLpeFkUhQ45zbqqKxRibc55kxHDp3Iu3mfHf+LkpAp0YHYbccQbqEVxD0kdJESmLPdtJWjACTcli2a4LFkHhfI3JFgGYYl9KI5vuOFuilY0lOKq8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tW2Rf5dQkFCxvDo1QfktfO3yxQes5+H2lVaVHz7cjbg=;
 b=ANfkpbmYCxxNbs7oHH3qIzHws9gIwWwdPgX0ZfEpoysGmkqhIzWTIL++ZloKcjQgStR8CygzbkZ2SG8VuVycXmihTS45lS9VEmTGy+RnKTyrU3IUj8LBRcdJ6v2HO00AkH/vXQwy4/EfNQWY1TI0GjhCh3hzD36laIBN7lT073S6gIcs/yBxjXanKY/59A4xWTwb9TSczi7BlXA4CRTccRUv9wFzdHIsIVz9zlY2eA8mMh0lPzpNr+D4L/SdRB3n5l5k08Gx1S2eD7FcytdgooZL5ukuAYmR/RwMCqYZvmvKtRQXb66UkcGG2pVpFf9tNxT/4DDaZJYZsM8t+fACWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GV1PR04MB10870.eurprd04.prod.outlook.com (2603:10a6:150:20a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Wed, 6 Aug
 2025 08:36:59 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 08:36:59 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: gregkh@linuxfoundation.org,
	mingo@kernel.org,
	tglx@linutronix.de,
	jun.li@nxp.com,
	viro@zeniv.linux.org.uk,
	thomas.weissschuh@linutronix.de,
	andriy.shevchenko@linux.intel.com,
	stern@rowland.harvard.edu
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH] usb: core: hcd: fix accessing unmapped memory in SINGLE_STEP_SET_FEATURE test
Date: Wed,  6 Aug 2025 16:39:55 +0800
Message-Id: <20250806083955.3325299-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::31)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|GV1PR04MB10870:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e3dc45-a68d-4d02-38d9-08ddd4c46887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2wQmwlLWI8dEArQdN1ZrVLov00XEbtKbo/XH74sxLgz2CAg1kh4l7YNu4KN0?=
 =?us-ascii?Q?IURKFXxCQj6b11vnW/gAlzzIlVHZ+LtXNMt8wfk/g3zPDKuoApv++hqJ1a0t?=
 =?us-ascii?Q?ZJrcCjTPRlLz0bAny4AVKh/HcnELXI7CyJJtlt56N4Z31b/WzuDJV10g8Jfg?=
 =?us-ascii?Q?IwbAwoxMktNDGVit/LO7b90/MbbnD9PkG2qjRzxnpepm0UeUZa++k9E5EFlm?=
 =?us-ascii?Q?fRuAA/uPWZdY5azHFi3raBGWuzOntGwKTEjbecqYs6OQLTrVcQuyBbq52b6i?=
 =?us-ascii?Q?C1DSwjr5MprBGypmXG1yPrZ4I9NJN7kGzznfs7XYyIjyuIsCLnml+RvSnDEH?=
 =?us-ascii?Q?XetpW4RgEXVcTI3moCFUDCP7DUDjIiIEr9x2YrZL2AMI7NjYAO1omAMzJn9D?=
 =?us-ascii?Q?+lxejRyPhGk3k/yljEOr2gLK3HNHftHu7POEk/UeF7dCb6JueXONwPX1mr8m?=
 =?us-ascii?Q?8IOF6UfITw2obrFlavG2t+od2JBh3igrkS9Hkd6g9okhFNC6FU2fLR3ShHLB?=
 =?us-ascii?Q?jYfGAjuu0Oc/9EUM+67ChUAzDc1yWVLGE8REw6ppEvb2zFtAU7QevX0aWgDB?=
 =?us-ascii?Q?CkLzGa92FO1TOh6P/YzeEQGOzbaTvP16LDwy6LVdRJSrdpLRIGuG1uwddiPu?=
 =?us-ascii?Q?EH9Hv5iY7AuL8CzM5y8m6A4z3ED1k9aHcq8Q2ggUsdd3SAWpTvfy3vExuGr4?=
 =?us-ascii?Q?N+JUkJzhQjW4MYHIXod/NpYYgkKDmjlKzjmW4wFb3HNIMfiyeHj3ciI1kX1B?=
 =?us-ascii?Q?NtCSzjoPy42oyWaALpoVLIfieN0bZ+8lGDwnzEbhQnl9wE61dNZMa2RYWtnQ?=
 =?us-ascii?Q?rZtzcAW7Li5sVwtIGApXPKAdAEJUMoAmraqZN0U6o9H8GtFz7phmjVrPJs/A?=
 =?us-ascii?Q?xWXnF+1wbegeRXTvYUTzjAFcadpR03aD/ZLsQ93GRC5YL1yaPgs9DqH3iLw0?=
 =?us-ascii?Q?xNxn1V8Trpqb4K/qVKLnmiRNeu1SiYWA5mBNFF+wt8BpNOXbVj6pJPDSsykk?=
 =?us-ascii?Q?zAhnVj9vSxB6qM3LFyyRelGWNz8Ej2JliRL35q/7x/8ENo1CFEnTieNB/fFG?=
 =?us-ascii?Q?Vyo3tx1Y/tTchOyg/CdrODofDG7x3mirANSu3ZoehUX1JULvNRC6yPpAWPSi?=
 =?us-ascii?Q?73ILl9/ctIE+0DXNlDJWBpWWtBbRw4EY8Gx2mCHHiMoGll80q9fDWvunPjaI?=
 =?us-ascii?Q?JQ3OcrqWWib4elToNLEanTqWcm/jDiIAB+k2C8S5Sq38xgwOz/WI5rS7nkM6?=
 =?us-ascii?Q?bgRDnZv07hkhxFKTDUNp48Jfme/6MjbOih5mkOSbkaGPOJbIV9sgpEYCx22j?=
 =?us-ascii?Q?DYOyqthQztRScRyxzR2D5LQd7fvj0DUCZC5jKHygMH1YXoutNLeVKY/c8rgX?=
 =?us-ascii?Q?TKaJV+r2YmBZJ8NjL+btABrMORY0ZmmdFHlsp6lTFH2tBgzcYoB5qVlqOfyF?=
 =?us-ascii?Q?GJGWDt9mBNa953dO9fU+1UupCdH8TBeJokD97iKjv2PO2ZjzIvw4RQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xqsKFf0y6J8GNiGTHVvcU9/HSLMbaPA33tQN08BV2vChHnLak4Rd1/hm77g6?=
 =?us-ascii?Q?LeyS2t5mgqmE83CI5FK8elclDKizlpKjnbXN/lTWrT2oxwQ+7EZYilxPnWv7?=
 =?us-ascii?Q?V6yEF061wCWjRX59ev0pJ+41MvY7uT+FlGL8LkXnv/NVs1dzxJYPBoQRXa+K?=
 =?us-ascii?Q?m8mf+DMy+JkNPbcsOeSV7iOrsGkWbKUE5HbdhtpSZ3DYpSu9u5BoGSRLHifk?=
 =?us-ascii?Q?dvbOwYQT1WnI66tj89V6nG4EyytL8OZIzjlMe33XnNMQN2yrC8B4H1liZE8F?=
 =?us-ascii?Q?HdHIB6EJQlH5kDP560cgB1aGPaR1+8R6Rfyv1p9XK62/dUmMfdg+iJbxMKcq?=
 =?us-ascii?Q?EKFpYFBBKcGpwGQWyUV2OFfxBGQWek//JehwG1kdqhfB59DAQYQJdzi84dua?=
 =?us-ascii?Q?0fh5ZLJvRwk5aAz+SdOkRwyCxkwopmdnKPx5cLSI8CrXhCxU4p9jzuQkJxEK?=
 =?us-ascii?Q?Fl1AuL/kPkrI/5rvX9dNVRw7/00hRmXKY+r+nUKVcJlqhJBMq+8dkYwI5GHG?=
 =?us-ascii?Q?2uuBc1qATz5KyGMFzLuLJYyrim3ZsGXhbafuRx/sJ9Bdb0JnPCGU4FHWAKgu?=
 =?us-ascii?Q?/PHzWl/yR8d9JeUzo1bmWd6CjoPyPi+0PkcnPtq8Rb7V894gIOACddp9bGBR?=
 =?us-ascii?Q?PJKlEJtFEYdJ17usEymPNfi6YwD2XBF/Dbw6h4gOudQlv0L916596JJXEK4Y?=
 =?us-ascii?Q?JJ9i4Pd2zAE7kXVlvdbTFLn+rAKLJPoxyR9A+QwPB8qHCqRYGARz0pd/2Y7j?=
 =?us-ascii?Q?i4wq29UDEpDuUC/YXsbk1nUkNEZF4U7J3Roxtz5BGlBewx1cSxMqW7a65iKj?=
 =?us-ascii?Q?GtnhUaXEl2qyiUF6kcEyMkkemVRSF83U9JZvVdllPxDeGyvikvhFfaDQ5F+a?=
 =?us-ascii?Q?/VX/Yf3UyzFbtgPo4hauFT7B+kMGEMOJMLBAFX+i6xNmIYu12EiOMkclFQ5n?=
 =?us-ascii?Q?ib9Px+PuY7qQY4I4+rKGB6vWWimE5vktKc006Jkhu4IjYWER1VfEAohlhH25?=
 =?us-ascii?Q?JniBeiBJ7g7DPruifRpzwzn8A9biXcgTHgLGluV5AmQtgQRwibdNGk3H+qVO?=
 =?us-ascii?Q?HD/3vZJo74fx51TjeW2BSyEjBjTS9x1nYOIW3A+d2rbgYXQAqJ5dFhRdzh5C?=
 =?us-ascii?Q?1L2qP2SLYZv9RSZXvR/WsfNVxtBRTIew1R/gTNke6ZqM1EwAx1QeR4jRTywE?=
 =?us-ascii?Q?yxHNnxzDTQkWQ9HT9wbjBxlrsTIE7c15j78UrKjLoP25HPm+wTfUjtrMt7yF?=
 =?us-ascii?Q?a60trscFK9DID7MJuGbT3wfLkIwW1CodrrpKj+lWNihBsQRVymjqRa0TV+wj?=
 =?us-ascii?Q?BBrEw+dLnUEw+ve79wikz2aSQ4O8+kynj8SluPuKwpnhz0FZ1g3WVhYejJmz?=
 =?us-ascii?Q?KekST8JjzjgSNhid0vlWnY0B78OUVUd3kJMxIQiwuE28RfPUbhtkb7T4FxhR?=
 =?us-ascii?Q?NGmD4cJZoDkR13f5YrXheHfSrUJjgqq5xnT7MUDWfe/x1J1dTkGjDcr9UwvR?=
 =?us-ascii?Q?1xhLOp9hif3sIk+7FeXdE8c4pyl+1v98hLtR3dRvazdVogfzWkGSoFmBDk0s?=
 =?us-ascii?Q?7JffJSzUkQIL2aVV72p+NTbWJeSYaNRgHNrqDAO3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e3dc45-a68d-4d02-38d9-08ddd4c46887
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 08:36:59.5020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Ezr1j9NrNz9TjHZuuc8C3rRvXiKzpklYY2IV/VU8Y1ymliWeC7f6d0SYjWwATgMQQjc6gFPcoAiA14csMMdNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10870

The USB core will unmap urb->transfer_dma after SETUP stage completes.
Then the USB controller will access unmapped memory when it received
device descriptor. If iommu is equipped, the entire test can't be
completed due to the memory accessing is blocked.

Fix it by calling map_urb_for_dma() again for IN stage. To reduce
redundant map for urb->transfer_buffer, this will also set
URB_NO_TRANSFER_DMA_MAP flag before first map_urb_for_dma() to skip
dma map for urb->transfer_buffer and clear URB_NO_TRANSFER_DMA_MAP
flag before second map_urb_for_dma().

Fixes: 216e0e563d81 ("usb: core: hcd: use map_urb_for_dma for single step set feature urb")
Cc: stable@vger.kernel.org
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/usb/core/hcd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 03771bbc6c01..c4a1875b5d3d 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2166,7 +2166,7 @@ static struct urb *request_single_step_set_feature_urb(
 	urb->complete = usb_ehset_completion;
 	urb->status = -EINPROGRESS;
 	urb->actual_length = 0;
-	urb->transfer_flags = URB_DIR_IN;
+	urb->transfer_flags = URB_DIR_IN | URB_NO_TRANSFER_DMA_MAP;
 	usb_get_urb(urb);
 	atomic_inc(&urb->use_count);
 	atomic_inc(&urb->dev->urbnum);
@@ -2230,9 +2230,15 @@ int ehset_single_step_set_feature(struct usb_hcd *hcd, int port)
 
 	/* Complete remaining DATA and STATUS stages using the same URB */
 	urb->status = -EINPROGRESS;
+	urb->transfer_flags &= ~URB_NO_TRANSFER_DMA_MAP;
 	usb_get_urb(urb);
 	atomic_inc(&urb->use_count);
 	atomic_inc(&urb->dev->urbnum);
+	if (map_urb_for_dma(hcd, urb, GFP_KERNEL)) {
+		usb_put_urb(urb);
+		goto out1;
+	}
+
 	retval = hcd->driver->submit_single_step_set_feature(hcd, urb, 0);
 	if (!retval && !wait_for_completion_timeout(&done,
 						msecs_to_jiffies(2000))) {
-- 
2.34.1


