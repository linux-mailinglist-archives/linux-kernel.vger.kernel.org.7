Return-Path: <linux-kernel+bounces-750234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D38EB158EE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317753A3943
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B141F3FED;
	Wed, 30 Jul 2025 06:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="SBrnT2SK"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013031.outbound.protection.outlook.com [40.107.44.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4182629D;
	Wed, 30 Jul 2025 06:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753856798; cv=fail; b=a6xcj3znMgXjBJthV/RSI+9fbhn+2IYwb6b6oi/hxJ6BjvLd32fEswMpbcMQqe47XjssoYISkXtH2q1K2l2fslt7d5yt/4jzyb8F2tqt5b9BrN04iFMRR1aQuyBdZg0EQg35gaidLMYV/kDTeQjIkJwqAcTCt4McUlikBeIAL7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753856798; c=relaxed/simple;
	bh=jM+QL8iXySW+EHgewBoR6V+K7BkySJf2J7t3Laothsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cQWoRswsiLG3/arA/1BccmC26F24PtfSnsgGa2z/q5cPW4FjM1P0xf2XT7gqpuOPaMFI9C1YBvNSETQbJ5VkSi30lq4AP3a8s7kiKrPoFGbGeOqFVP5KzKcDo9vtecDJcBeLfjilg1GVi1Zz2sYmlDljmIEqZH2zJf/ksKJjyKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=SBrnT2SK; arc=fail smtp.client-ip=40.107.44.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfXaMluNAHgwGeJChiy4zIcw7kVO13cDQoZ/xjaI2y65IdyJK+fuZWOqCyGvEyvQvPIcgJIpx+QItc5SfTe1s95r9hZ57yFgobsU+Q7Jg+6RPiN75VjANf+WeN+0jq+5AhO1wQ8c2jm0iyItguBj0lLYtV04A3iE7a3OpXdGhFwbZrhni/5TDCGwewEEY+4uD/53ydlWHe30OVHvqnwgE1p8zsh9DacnDSKbBB8ibQRvshYJ8ju2iyiZdeorZ+ZHsn/HJ9jrpWN33O4PMRcQaOvp7VnzmyxaUTj4ulFacjFOuCEgdFdWYAUY9cIGBfGAUkEFrJW8z/nEXerCXm6RMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgrZYW7bcQ/Y/3JSiiE197cCKOh+UDWK+eJSHr0TUdY=;
 b=Rr4rIfnAdY52ijX+w6fxpcQx0OtPrawLdGD/lPiQc3WGioMCwkihD3PqWOI6dsloaxaVObej5j/SWxIPgknoAigHbS8PKTnSIybW80d2BX8Y9E2riJCAEGP5ZxZ99rXtEwawLcucJITjY6wnm8SeaqxzHGhg40VekJGThel+kopx1I0fZ0Jqm2XCjRO3zRt6QmKtpntcJADNCqBHLNC9Bs+9EnuqmxCR5wilMbgxrzjNW6oYVS7bpON0TiQoUOb6oUsatdShewej69EqdJdu905r05gl8m4e9/QGVKm9bV71x0KgUlWvAD7z4BPfQRDPEJ9BGn8MF0yLCRHCJNg/ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgrZYW7bcQ/Y/3JSiiE197cCKOh+UDWK+eJSHr0TUdY=;
 b=SBrnT2SK4gnB8pDYf77tTsMXNe5XV8WX3Z/vqScYX4mY1IgufFPbgijhH0iaJSu/HTxYoauLwMOeXFvsux0AblZmgdmnpSv5l9D7qrp/SVj0zgdx/Bq4xfCApcCJGvOeBwYdqcAQbRCGU1qmrQjtEmQpXfZebZxYdpIpYNoA41spjHIWJx3TmS7HUcuOqUB8mZh2VjFtXy7tnmhspVIOvGZufnjV0+urr9paDPKPURmbKNpGzzu7IsVqhiLsCXkTa9REfoMo+W0YLsRnf1a1bXaao5XgfFjAVhsoG2dFjgiZiCeVQDAY6r0vXpqMNjtpUN6m8oxYNiYzAp707GKucQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYPPR06MB8052.apcprd06.prod.outlook.com (2603:1096:405:31a::12)
 by SEZPR06MB7292.apcprd06.prod.outlook.com (2603:1096:101:251::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 06:26:32 +0000
Received: from TYPPR06MB8052.apcprd06.prod.outlook.com
 ([fe80::5cf4:4746:d56a:157c]) by TYPPR06MB8052.apcprd06.prod.outlook.com
 ([fe80::5cf4:4746:d56a:157c%6]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 06:26:32 +0000
From: Pan Chuang <panchuang@vivo.com>
To: tglx@linutronix.de
Cc: kernel-janitors@vger.kernel.org,
	Markus.Elfring@web.de,
	linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com,
	Jonathan.Cameron@Huawei.com,
	u.kleine-koenig@pengutronix.de,
	angeg.delregno@collabora.com,
	krzk@kernel.org,
	a.fatoum@pengutronix.de,
	frank.li@vivo.com,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v9 1/1] genirq/devres: Add dev_err_probe() in devm_request_threaded_irq() and devm_request_any_context_irq()
Date: Wed, 30 Jul 2025 14:25:54 +0800
Message-Id: <20250730062554.269151-2-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730062554.269151-1-panchuang@vivo.com>
References: <20250730062554.269151-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0348.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::11) To TYPPR06MB8052.apcprd06.prod.outlook.com
 (2603:1096:405:31a::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYPPR06MB8052:EE_|SEZPR06MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a91107d-fdc8-488d-6b89-08ddcf32064e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mD6bMu0WlrB33OCt/oB1E+l7nlHI7k1wFxEtXIK7lHHbymnRXJ4XdjHUYxc8?=
 =?us-ascii?Q?j1nP51Hw1SOBJlM0QxQm9c7OQ9KSONXuHhFMgXsZ8dlCNodcVOji1lRkfpJe?=
 =?us-ascii?Q?RiPSZ70rQR6sLjvoyyfcKqvRhZfZey5zgSVN6V5icaggKQlrc2JZra6l/xQ2?=
 =?us-ascii?Q?yqCpk2Co3JFC8vA5ACqC2Kn5jjB2QMMzQR0DEWK9d91HffFfg38LA2CWxKJN?=
 =?us-ascii?Q?XI9GOBZ0hz9DA/dzeULmd2+ADodLG72MHQZTxKhTMHImiryi8idahqPDN5oG?=
 =?us-ascii?Q?zh96wxTl+wybguxzHiod+ooW/MFVszR1eLz6DIeHzcaEduYvwbwCnmwaUZyz?=
 =?us-ascii?Q?zY/38Hau398qMRCAoVACgycGUp9iPPFkK5Vzu2757oKi0LEUwuSpMVao+aCf?=
 =?us-ascii?Q?jq5iS2KeOeX8IHWj6ZBCJ44nUgmJskzMm4jDw0cMm6Qz10pBlm2hxMYn8YWp?=
 =?us-ascii?Q?MTsfXjHH9jYGLIDd5pbL9PCV3UJ/fyqY51O0Mic6VSPF0oca8ZmoWRYA4yCb?=
 =?us-ascii?Q?wYiW4emYCKXRbxSrapiGAIeFLAgP9vfiUQltzhxVrpA27Fd4d5ElCJky0l5E?=
 =?us-ascii?Q?N+m8rO+nF/qiCqeBPZSSVXRz48p+59NuZpunGhP0sDHakant1qHUplLaXCb+?=
 =?us-ascii?Q?TST8LW6xR8ben3Rzqau5dS63MMjCYeCHh2+Ihjeg7UisrHtsZLzQPDf/pL5v?=
 =?us-ascii?Q?re4XDPoYaHKH+OktgxNFl2Yp6o97Uvn0CcmhkV5ZuhC5ALE7eMMidYpqWkC8?=
 =?us-ascii?Q?Ivx0rpz6j9ZeqDNg8zmwfETCM+U4FqmF/riW37o9hg3+hhaZSsItBBhJmAmB?=
 =?us-ascii?Q?Ma1bmhehBMmIYpcyp90cp7pQ7C5kMyOoZvbNvbC7fe90x/7jjV0eyLZh616T?=
 =?us-ascii?Q?JAZT98sF8keWQHfsrAihCz4NByWVULiukJjIwr7fn48vnR7hM1VqYOqrycuR?=
 =?us-ascii?Q?/pn31MIYJ9dQJCnU7ZfYYC3Ha1he7L1rZ9bEAiSMGCbtqMNfnmUdLlOb0Y9f?=
 =?us-ascii?Q?x9XkKSdiv0bfoO797u5JoqFuEljatjR/PrlGumpUfZxN5rPsb+Myhqvc3AGS?=
 =?us-ascii?Q?2EmmkM02sSUStM0BAlMYvIMmiAJ9yV3EqnWkD7He+d417O7BuRe3eoI57Zry?=
 =?us-ascii?Q?GNl27M2XG+vOoCCfAMpLV7fXYbeybXMTx1x6qyuO+S4dPKOeH5bYH1l5LDSi?=
 =?us-ascii?Q?cIITMgM4EYQlCsWbegAISKkG6zzDHaVXKfO4yICuJJI3AXfDiNiWpPmOBBxR?=
 =?us-ascii?Q?qffNJ3/Oy3IxqAcVXO02rtdVNJOMQf5kSnY3GPc+Jlz6f68IiQD6UYKGAh82?=
 =?us-ascii?Q?ay/1dwqxveLCUAMr/RFAzWCJ+5Qh4rsRKiIjSGO20v8MqLk4UP+edREugdjQ?=
 =?us-ascii?Q?t/6+RL68TAJHXviXcY4gNRj0Uy+Vyoe+HqjvZ4SweuzV+5rPDumVdFmM6wCY?=
 =?us-ascii?Q?AVI17rMtg/1nqkTFwmvFkakYrzjq1+SklEM+tlrImt+jYh1ojaKRfg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYPPR06MB8052.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BbPt+L3ZPnPx1xkecDYwKjCIk4mySo8QDp/lDsBEoZf1zPlxK1n9r8rW6Mu7?=
 =?us-ascii?Q?f7aaM3OQWx/JkdVAwwSp9ab2oOgulcQAAqqUdA6WKi5Ek2IphlR/LtXqK28b?=
 =?us-ascii?Q?6zV5YmEo356YTRJwf23ox1WBevZc0h/WId6nPoF2T6iRpIkvy7NzBJS4IWhm?=
 =?us-ascii?Q?P9uQrrISN+VuhyVPahT15BaLNoW87toUppV/Ui7dJ601B9C9WNBb22XWzx46?=
 =?us-ascii?Q?jpZtEGsJIUqj9r5TKU08prnsYLplVbsp7n6Pdu4FHbR3c1bUIyceFRgCgbs5?=
 =?us-ascii?Q?LMAzXZU1/9u8rtQtLdKmPJMpmNGY/4wCDtU5flc+fQCOTe8UQdS9gvp1WBVo?=
 =?us-ascii?Q?niHJ3Ssb0pRDk8ZAem4SzvNpecG7PpJUi028J291JV1KT1jE7yaIX37eUmto?=
 =?us-ascii?Q?HmFE5nsPdqR/mxN3/eQqXaUh8NJfocSsT0aeZd1Np9yBpbtF8eBjFotSJo0Y?=
 =?us-ascii?Q?Uda42h+sNUjexolHDTzyOueLg6SvJUxYWkCMNjfguY6u7fSY+A29mLv+sKq9?=
 =?us-ascii?Q?bsbfzMytFPo5j9JwdTPZk/NufJXA9Oy6Wex0sPP1CfDUEtQqIDoHeEKvB7ra?=
 =?us-ascii?Q?hoEPhkuYVa+cE3I936d0AVQKz84p5VfvmkTqXSMmD9IDvDMOtnyAj5807uBh?=
 =?us-ascii?Q?G/0yO1YR8TwQdEiyszJnr6NXty+hdBpN/n2dPoKrb8/EeMyVMG7BJJk1XwMW?=
 =?us-ascii?Q?GC43XjAi9eSgvf0Em5AS6TckUq8a00wdrTTTEtL5fqOla3gA6RA2qxpIAIz5?=
 =?us-ascii?Q?QPm+XGxf+GSmmDKHO41Zu8cYDxT9rhAvPt6TaJ7dkpG7bDdviJIlWW+XoHZ+?=
 =?us-ascii?Q?A0xKf3x7yGz4nsp8pOEucQKXh26FP4E778WlRPjZjVF9RTa6uCZMCoSMvvKa?=
 =?us-ascii?Q?FRYwr/jJsgjJ2GAuMY+oyAjNmFoKd+qJr5WRVSiJVw5ukhAOtUgiOfvwl0AC?=
 =?us-ascii?Q?siUHphtqVlK4no3SyGHOi+gGrFUoSikVrOWOcF0rVbrr87SeaZVgkb4z917w?=
 =?us-ascii?Q?06hEAG9KS2S7cgxva3sYK8lDNUlJ9TbkgtL+VqKk/Z2O4rmMsShC9kayTlv4?=
 =?us-ascii?Q?MJeKRTTAQ+rpI6nz3hcax54HnvDbpm7YAx31e4NjWnxbSPwAqjTP8UgOVFQM?=
 =?us-ascii?Q?arWeH1DsWOX7Q+aAChQn+KjSe7+NF+i0pGrbkwkefN/Dhu+ba7dwZvRh1lwu?=
 =?us-ascii?Q?fam+NIp88Qq8S5gLsXwF6nJU0Fo9FxmndHcACNskMAFGG/n/Z+0SuZakgURj?=
 =?us-ascii?Q?VBpnIEqiiCWB30o9aHJAP2EIfNPhgrySf5adBsAcjqLaRxPQzyRovDdoPDZg?=
 =?us-ascii?Q?F5DHeuUF5Ds3MEWfAf4PaU/rqDT3dPISIYxkAj0nHiVAiB0hQlwgX1+5uEOU?=
 =?us-ascii?Q?avwBPZNu5y6SMXcOrJ9HMbVGsdsv59pQb9uPACoxJl7cJYFD9bU8J9Vzd0T6?=
 =?us-ascii?Q?ganMlWZf4lO9jt3OpFz+2Tvq1tjbJuZ8XpHWK0/pWq2qB1yKIzcVUf+Iq2h4?=
 =?us-ascii?Q?fRkl7HZ87P4PUthrjuv+q3enPRh5r3M4N869TNvsxnLtanN8mP2Exa5G9LIg?=
 =?us-ascii?Q?h9VU0lj4zHW9X88droouJA0iyyUlVO77uuy9Rw8T?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a91107d-fdc8-488d-6b89-08ddcf32064e
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8052.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 06:26:31.9855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIZsmKxafCv2ATb4/RADYazTXZ1EYrynYa8lSDML7MNsLlVNSESi4IArlnOT+DAskm5oqXy5Q9ghHAY+liIx6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7292

The devm_request_threaded_irq() and devm_request_any_context_irq() currently
don't print any error when interrupt registration fails. This forces each
driver to implement redundant error logging - over 2,000 lines of error
messages exist across drivers. Additionally, when upper-layer functions
propagate these errors without logging, critical debugging information is lost.

Add automatic error logging to these functions via dev_err_probe(), printing
device name, IRQ number, handler functions, and error code on failure.

Co-developed-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 kernel/irq/devres.c | 121 +++++++++++++++++++++++++++++---------------
 1 file changed, 81 insertions(+), 40 deletions(-)

diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index eb16a58e0322..dcbb9d0cd736 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -30,29 +30,11 @@ static int devm_irq_match(struct device *dev, void *res, void *data)
 	return this->irq == match->irq && this->dev_id == match->dev_id;
 }
 
-/**
- *	devm_request_threaded_irq - allocate an interrupt line for a managed device
- *	@dev: device to request interrupt for
- *	@irq: Interrupt line to allocate
- *	@handler: Function to be called when the IRQ occurs
- *	@thread_fn: function to be called in a threaded interrupt context. NULL
- *		    for devices which handle everything in @handler
- *	@irqflags: Interrupt type flags
- *	@devname: An ascii name for the claiming device, dev_name(dev) if NULL
- *	@dev_id: A cookie passed back to the handler function
- *
- *	Except for the extra @dev argument, this function takes the
- *	same arguments and performs the same function as
- *	request_threaded_irq().  IRQs requested with this function will be
- *	automatically freed on driver detach.
- *
- *	If an IRQ allocated with this function needs to be freed
- *	separately, devm_free_irq() must be used.
- */
-int devm_request_threaded_irq(struct device *dev, unsigned int irq,
-			      irq_handler_t handler, irq_handler_t thread_fn,
-			      unsigned long irqflags, const char *devname,
-			      void *dev_id)
+static int __devm_request_threaded_irq(struct device *dev, unsigned int irq,
+				       irq_handler_t handler,
+				       irq_handler_t thread_fn,
+				       unsigned long irqflags,
+				       const char *devname, void *dev_id)
 {
 	struct irq_devres *dr;
 	int rc;
@@ -78,28 +60,50 @@ int devm_request_threaded_irq(struct device *dev, unsigned int irq,
 
 	return 0;
 }
-EXPORT_SYMBOL(devm_request_threaded_irq);
 
 /**
- *	devm_request_any_context_irq - allocate an interrupt line for a managed device
- *	@dev: device to request interrupt for
- *	@irq: Interrupt line to allocate
- *	@handler: Function to be called when the IRQ occurs
- *	@irqflags: Interrupt type flags
- *	@devname: An ascii name for the claiming device, dev_name(dev) if NULL
- *	@dev_id: A cookie passed back to the handler function
+ * devm_request_threaded_irq - allocate an interrupt line for a managed device with error logging
+ * @dev:	Device to request interrupt for
+ * @irq:	Interrupt line to allocate
+ * @handler:	Function to be called when the IRQ occurs
+ * @thread_fn:	Function to be called in a threaded interrupt context. NULL
+ *		for devices which handle everything in @handler
+ * @irqflags:	Interrupt type flags
+ * @devname:	An ascii name for the claiming device, dev_name(dev) if NULL
+ * @dev_id:	A cookie passed back to the handler function
  *
- *	Except for the extra @dev argument, this function takes the
- *	same arguments and performs the same function as
- *	request_any_context_irq().  IRQs requested with this function will be
- *	automatically freed on driver detach.
+ * Except for the extra @dev argument, this function takes the same arguments
+ * and performs the same function as request_threaded_irq().  IRQs requested
+ * with this function will be automatically freed on driver detach.
+ *
+ * If an IRQ allocated with this function needs to be freed separately,
+ * devm_free_irq() must be used.
+ *
+ * When the request fails, an error message is printed with contextual
+ * information (device name, interrupt number, handler functions and
+ * error code). Don't add extra error messages at the call sites.
  *
- *	If an IRQ allocated with this function needs to be freed
- *	separately, devm_free_irq() must be used.
+ * Return: 0 on success or a negative error number.
  */
-int devm_request_any_context_irq(struct device *dev, unsigned int irq,
-			      irq_handler_t handler, unsigned long irqflags,
-			      const char *devname, void *dev_id)
+int devm_request_threaded_irq(struct device *dev, unsigned int irq,
+			      irq_handler_t handler, irq_handler_t thread_fn,
+			      unsigned long irqflags, const char *devname,
+			      void *dev_id)
+{
+	int rc = __devm_request_threaded_irq(dev, irq, handler, thread_fn,
+					     irqflags, devname, dev_id);
+	if (!rc)
+		return 0;
+
+	return dev_err_probe(dev, rc, "request_irq(%u) %ps %ps %s\n",
+			     irq, handler, thread_fn, devname ? : "");
+}
+EXPORT_SYMBOL(devm_request_threaded_irq);
+
+static int __devm_request_any_context_irq(struct device *dev, unsigned int irq,
+					  irq_handler_t handler,
+					  unsigned long irqflags,
+					  const char *devname, void *dev_id)
 {
 	struct irq_devres *dr;
 	int rc;
@@ -124,6 +128,43 @@ int devm_request_any_context_irq(struct device *dev, unsigned int irq,
 
 	return rc;
 }
+
+/**
+ * devm_request_any_context_irq - allocate an interrupt line for a managed device with error logging
+ * @dev:	Device to request interrupt for
+ * @irq:	Interrupt line to allocate
+ * @handler:	Function to be called when the IRQ occurs
+ * @irqflags:	Interrupt type flags
+ * @devname:	An ascii name for the claiming device, dev_name(dev) if NULL
+ * @dev_id:	A cookie passed back to the handler function
+ *
+ * Except for the extra @dev argument, this function takes the same arguments
+ * and performs the same function as request_any_context_irq().  IRQs requested
+ * with this function will be automatically freed on driver detach.
+ *
+ * If an IRQ allocated with this function needs to be freed separately,
+ * devm_free_irq() must be used.
+ *
+ * When the request fails, an error message is printed with contextual
+ * information (device name, interrupt number, handler functions and
+ * error code). Don't add extra error messages at the call sites.
+ *
+ * Return: IRQC_IS_HARDIRQ or IRQC_IS_NESTED on success, or a negative error
+ * number.
+ */
+int devm_request_any_context_irq(struct device *dev, unsigned int irq,
+				 irq_handler_t handler, unsigned long irqflags,
+				 const char *devname, void *dev_id)
+{
+	int rc = __devm_request_any_context_irq(dev, irq, handler, irqflags,
+						devname, dev_id);
+	if (rc < 0) {
+		return dev_err_probe(dev, rc, "request_irq(%u) %ps %s\n",
+				     irq, handler, devname ? : "");
+	}
+
+	return rc;
+}
 EXPORT_SYMBOL(devm_request_any_context_irq);
 
 /**
-- 
2.34.1


