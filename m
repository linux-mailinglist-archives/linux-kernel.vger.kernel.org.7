Return-Path: <linux-kernel+bounces-726007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E1AB0068B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C197BA870
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1098C275B16;
	Thu, 10 Jul 2025 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="M/WeUJqT"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2136.outbound.protection.outlook.com [40.107.237.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F46E274B29;
	Thu, 10 Jul 2025 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160996; cv=fail; b=qwDUb98HHe3OfvwffsltKYr1KytsDNyvHPCvuag0sCKkFxtu3EICqIWnOLuUb6dN+l4cg8+QVOa/1gcKk7Idr9NeXTXgJ1O/7OHBasxP499lHojexvuzBlKfEG9Bz7O+2fhxb6TWPMZj6QqNuFiQvt0fp6KgD09/+/Inzkay3zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160996; c=relaxed/simple;
	bh=njQMyIQb21/8PBLu3navFHJfmozUQPu2MynsYdoZt5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gAbYI0/T5A0Ws8h9R03Q0VG6u6l9BgvD6o6YU15lrzkOaGsGUO8nR/q3BEkQV0BN/cUM+7dwFvUS4TU12Qkq6OZQqhCqTjYuz078+mCERnVkujnK7/FLejn6L221ULqpqclX0RwtxTegm8kwHdDEoo4bnUxWkBAGSX4fTe4JONI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=M/WeUJqT; arc=fail smtp.client-ip=40.107.237.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIBLhNMe+qjcj3OYVq2q8yeNIasjc8PdVM3xkoTlV8FG9PIJP/LPHYN9aIz7GlXOQINmsaezuJ1JoP5TDJC0zF1XHD/pm/Lx5zehy1Y/909295pzcRWYvGIeq29bKJPg9Ao/5BasBl8eYgeaBrQ8zzbLbPZjXa9nsZO+EGOqiIk27p/4j46mKGEA0gBp0RdhCSr/lJ4GkWLgUa1bUSWT1CMCwjlHhO8WChXXTPt5RYvCPLjudancychgfkFBy/hT7AdSkNjB8Yk/ySR90D7urOnCjY+6Lj7HUUBAGvQoCYTMYSkOwqLQEpFPD5PHLEfXkkx6KbuJFspYTyCZPZz5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuOexVFBFQxHoI9x0UEwd5VAzvbKMb6/1/oBDm3GLyU=;
 b=Wb8Bq+6c0aladNECOXLH2AOzdLdxSGDeXGqjk++O3FnlwzFEzOJrXwPYrMX8VlenZypdizs+NSNjLl7Digr9O8GSbDboOyjnogqXUgXTHUxOEfXrUonOsvFryii2mo1Wr39dIDQrJiVLrxRDGWEKQjnv4bb/YKDghHZfRIvY/2zCwtRJNSdY+/DPf9Jh9/4lNeAPEepueUcAzDMSM0QJ1R4KgeVp37btk8vZUY3l/eY2AQUxlFBaX/0MTVbIILmM8qHnKQDOZrqjPrWXhFB0fnqxtE5R0phu5rGV9/6z4s7EKhwYlQ8kCPnsPfY5p+J7mOkBxekemYmUjCJHTddKug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuOexVFBFQxHoI9x0UEwd5VAzvbKMb6/1/oBDm3GLyU=;
 b=M/WeUJqTq2AlP4T2I/7bGynPnWMbZZBxW/qKsA2yPclRovrr+eEiCukYoYhbJoqxmPDc9cVmt1YvvqMRM7WtEX63mBCUg1dc/96enSqZToJsNMEPkni0wVgQ+dmaAWb7UyEq3r+lszQx+DZwecbappvALEHI2kqe3NPthFhFoMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by PH8PR08MB8487.namprd08.prod.outlook.com (2603:10b6:510:25a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 15:23:10 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401%7]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 15:23:09 +0000
From: John Keeping <jkeeping@inmusicbrands.com>
To: linux-rockchip@lists.infradead.org
Cc: John Keeping <jkeeping@inmusicbrands.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-usb@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC/PATCH 1/2] usb: dwc3: disable for USB_ROLE_NONE
Date: Thu, 10 Jul 2025 16:22:49 +0100
Message-ID: <20250710152252.2532020-2-jkeeping@inmusicbrands.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710152252.2532020-1-jkeeping@inmusicbrands.com>
References: <20250710152252.2532020-1-jkeeping@inmusicbrands.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0621.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::21) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|PH8PR08MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da4dc37-2a02-4079-7360-08ddbfc5ad4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BIm5CJxcBRmzYlBQBmei0YasTX7KKe7VDeEuzQFp6K2nipqPGd2jB0FuPT/B?=
 =?us-ascii?Q?ApViU0bL9ss4IM75v1zm7bFCEMLlAlgj0mf28EIIESb9U4o1fec2PGGUUJ8g?=
 =?us-ascii?Q?lk5v6WGJ/NuyWF/gqB1ItU1nl/J46K+rvMnO6R9JrczjH0s9LiTcAmFpdgs1?=
 =?us-ascii?Q?rhcIrEMg84JSvPXdzPVz9C3uwYkcJa8enIGfPNA6WHcWYFARiBLJF8R0RKkO?=
 =?us-ascii?Q?epKiduNmIjlw2gqWtEmKdXKW4wMwx3r9WtvTGeqJ/PJ+5G4q8F7MdVSjC9kj?=
 =?us-ascii?Q?ufjFWI5+rNUwGASjGCtKvxauhJlILnxP2L5BrTvDFGNKx45qA8Q3c6SwERBs?=
 =?us-ascii?Q?99BMaEHEw+L4KGJRDiwHgRK3jOaa6x5R/i3YlEW7vM5YrvAaYDJoAKj3HMrD?=
 =?us-ascii?Q?XRrqh42t1pMsYUL2ovN6aPXlOzT4Xhv3vhYbIYheRbnjivjN60eKCmsMMbLY?=
 =?us-ascii?Q?JjQoAUdtAX1AZRFKd1X85n0Y8gKl/KHybmeeMuJThMHXdXxTj6GqkRiTngMU?=
 =?us-ascii?Q?MDc9cX81O1wrvcrATVxZp8TefLkCa++vbclWpXVa6cEREPyZxN+uTe7qt4ZP?=
 =?us-ascii?Q?6QhF0xR2YIkJXDvWq6EtE38cQCD3EJ5kaQ6Hs5b2kUzSHaCwmj7M8Rne4zrc?=
 =?us-ascii?Q?B0eDMUI0eCCDjiIlo/vuSaS4mzfRe1cvbo5SufDajlpQbHsqCofRle6B0HI3?=
 =?us-ascii?Q?WixwdU5EgC7wsrAJG2LPzUEdw6o2rOHmpjultvPOppvXORL6fLKvFEk/a8Cr?=
 =?us-ascii?Q?P1hMj3BLP+843By+bwK02sHBd5563T8ZZpeXfcMtr+TlqKaU0IhkSyZbxdKv?=
 =?us-ascii?Q?ZVxy673zqvUBoJ6ndAaze3nthQw+zUa7kK4qSO3Ok3VMfLIvwNNg+srm6qXi?=
 =?us-ascii?Q?hARhTTy0C0Kr+9aVn5x1swHdKjnOw7PtffawCSDK+roS2O9E1VXi3NkbDgu9?=
 =?us-ascii?Q?RPN2W2JTZuUSVALmPz2ohMVIjCG+XYb/Jxc8G2W+8ylzSSxz3DmQ6isogQ4X?=
 =?us-ascii?Q?6CLz4cHBtKA7NABOJpT6VBq7b6mD7rPZECQfRTr7nnwPwV7CF06Kpv60aL8Z?=
 =?us-ascii?Q?3mJ8hRg7gVqMWh2nUoqV3nE3p8IrVFsna2HMiFP9i5BRsK5O7iKPSt6mD/Ki?=
 =?us-ascii?Q?L4bGmTdAXdkteMmxFSQavkFVa1mfceO/OSnizJIyGgGbwFKEnF7L8NkYWLox?=
 =?us-ascii?Q?cTrjxsE4GNu8agb23XeaZsnvfBPgzPnL+e2OwUMxNX3qUJP3uGyjDz9rpckA?=
 =?us-ascii?Q?BfIdNohs4Q/fxIN2gGtm8KO+xxKLhSaJVWXNp5SrEgP7omsPGg3ah3yUCJlE?=
 =?us-ascii?Q?SDK4Oc1cpa+VeLSvqxWew1oqFbOjfSBMEJKindZyNyShjC/zA8tCZk62HoNb?=
 =?us-ascii?Q?czPA3tdWnv+7wwJxKDI1UzqXQE5/BDnX3ywcBKqaUrAF6k5WsF8ydX+EYvo6?=
 =?us-ascii?Q?TmQcnxBC9eStARoNw18VDF18CccG9Y4fHMZyOrfIbNFTiAiMAMNYEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR08MB8282.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TMdosDCOU/JrT4UqlJiAJaw1rdBGZvo20OOFsgptbDUSq/xeAauZd/bm3zog?=
 =?us-ascii?Q?zybR334iNRpMurMvie0+OfWe34QJNRk+Pnj+E5++JqnWW3Aq2nl6NedMYL6G?=
 =?us-ascii?Q?TObAbM15GDBb5VwEbfS7KKXy6DZBx+KoAQJnbUiU6zy73Cp/BsRRkkiOn7Ki?=
 =?us-ascii?Q?3d7upQ/saRYDgFOIBr4GAO6BaAsjvgQSBhr5gyevNVq1tgePHe98+KZ7X9tP?=
 =?us-ascii?Q?E1qWPIH4LLcEG3Nccc1lgClqF14lFZ5BTzP3cPa4Nh2yRaTEEdE/3sJ4Xrvs?=
 =?us-ascii?Q?O9wdUecogLb5F08IPaJEwlDlHQD/Jwuhc5f2h1oJYvavfRI6SLOBszJEHP1z?=
 =?us-ascii?Q?1yJF+Xo2RAStFz1MhQWn+zqD6RAhk2oZPHx1r8dnmvaVlJCwoLwicriJa1Mm?=
 =?us-ascii?Q?fXiHzuBCbAYYzVeBgGeKXIvS6Hhl1uQWPPy6qWej0uj4pqYisiR5kd5EyumM?=
 =?us-ascii?Q?AQ4ZG7RBKi7A5HZQXLLOFlZYhoLBhbpB5h66ZmIVirejQs8+9Uo4+DN5U4ho?=
 =?us-ascii?Q?6rCBgj3o2+mf7AIhrpc8c6xTzWtfHRIVKmOajh0vbAOnYnIMZFFhxVr9D62d?=
 =?us-ascii?Q?m1yt4U/kfRhQAt7ojNrZOObz1V2FeFV71irlT5jPbaxeWhVn2QvZ0qF7WDGL?=
 =?us-ascii?Q?HD/b5YmxBJJvFIrq0uRmZdQofVemknzMyXMxa2apSS77qDEia8T7Oni4UisS?=
 =?us-ascii?Q?dNJI3PouaaTVVr2Nk7LreqAuM6iTAO/htKgNa8+Gf6fAdulw+G06Gr2B4Big?=
 =?us-ascii?Q?YSEvmvKdVKWi8V+iUojIbTWqxDGYpmQ5dc0pH8RMzetBPCMNceN4qBkEca4M?=
 =?us-ascii?Q?hel/+abrwNW/PKRoeWqzCs1v4of47XMzWVJ+E4xEnVblYB8FZ9ClUFWTdJ3d?=
 =?us-ascii?Q?QHERXvnUAr+vCw4Ln9GeamhKC/uKtznInKsjCYooDB5GHcniM8LEPxLnibmN?=
 =?us-ascii?Q?FkBbz1Ger+B6RKyX3mFLnbBD1yxmt9RSFc77uaH+i0o2S6SOT+ZWIGZudmPa?=
 =?us-ascii?Q?bX7CtTI1ZixcGgtQ0Yxu7qSYoD8T8+r3Ebe5f6YZOp5mrz8dkTDSTuozlGWi?=
 =?us-ascii?Q?lt8sqLJurC3y/clhCgMiHaPMfxnFd2nQhKn0RkImP6VvMJmsIZlRz44aG5JI?=
 =?us-ascii?Q?7w3+5PER6BXEh2W+f8t2QB2fLJ3B9MZ0QNS7a4AEaV8tn003rAgZmLj5mPhm?=
 =?us-ascii?Q?44B/U3yoXHW/fThxhn/YmGEGRJ/5R389jxRH+YXKqCm9ThypTpsbHnKwBe5i?=
 =?us-ascii?Q?Rl1bsUSuh7P73Vw/tdErr0fW49mE5sCrDwUkdtf6nkFhBznduEIXLAnH83ZG?=
 =?us-ascii?Q?RSm1BS2wZQ1SVT9fqW9b+FM+LviN13qPxzAm5KsGT0sHDvFY32JarJjY5Ev/?=
 =?us-ascii?Q?N0ncnxXVv9/qEcDyxkce1NMKybq4jokvF8YmKnMSssKJtYWwrtvtZwnHyiA4?=
 =?us-ascii?Q?1AxBf5Vb5SSr6SmPoGh2ZD2tMg5oX2jHMRCPkKV3+EypHW4hdpiI8KrYzwgw?=
 =?us-ascii?Q?5D0K+hwFXJi55DsP7i08IoK6TrIcRL4H5pGH4buGRaFx4L/NgBJCjJBuiPHP?=
 =?us-ascii?Q?8DpxnVcmBih23UyucfMHx5N/FqWkkJJqM5n1ylgJaIsVAQUXGRAjZpavjZ89?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da4dc37-2a02-4079-7360-08ddbfc5ad4a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:23:09.4882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xP3bqSRRcqvqvYY3Mm5qEFVDNiBIEQSKeMQsroFYuLJxPytXRg7K+0MmMkO1hMOe8Qu1Znq3pHICaEfTCXt6qSY/XNxAzVkMlbbgnAhWMcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR08MB8487

When the phy is acting as a Type C mux, it may need to reset when the
cable direction changes.  But this should not happen while DWC3 is
trying to use the USB connection.

In this case, there must be a connection manager to notify the phy of
the orientation change and tcpm_mux_set() ensures this happens before
DWC3's role switch is informed of a change.

It should not be possible to go directly from device->device or
host->host with a change in orientation without transitioning through
the "none" role as the cable is unplugged.  So ensuring that DWC3 always
informs the phy of the new mode whenever a plug is detected should be
sufficient for the phy to safely reset itself at a time that is safe for
DWC3.

Lifting the special-case for desired_dr_mode==0 in __dwc3_set_mode() is
sufficient to allow using the unset mode for USB_ROLE_NONE.  The
handling already disables the old mode and then simply does not enable a
new one.

If an external device is notifying USB role switches, then it is not
necessary to set the default role when USB_ROLE_NONE is passed.

Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
---
 drivers/usb/dwc3/core.c | 3 ---
 drivers/usb/dwc3/drd.c  | 5 +----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 8002c23a5a02a..6573cca0eeaf5 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -177,9 +177,6 @@ static void __dwc3_set_mode(struct work_struct *work)
 	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_OTG)
 		dwc3_otg_update(dwc, 0);
 
-	if (!desired_dr_role)
-		goto out;
-
 	if (desired_dr_role == dwc->current_dr_role)
 		goto out;
 
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 7977860932b14..8f427afa8eb93 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -457,10 +457,7 @@ static int dwc3_usb_role_switch_set(struct usb_role_switch *sw,
 		mode = DWC3_GCTL_PRTCAP_DEVICE;
 		break;
 	default:
-		if (dwc->role_switch_default_mode == USB_DR_MODE_HOST)
-			mode = DWC3_GCTL_PRTCAP_HOST;
-		else
-			mode = DWC3_GCTL_PRTCAP_DEVICE;
+		mode = 0;
 		break;
 	}
 
-- 
2.50.0


