Return-Path: <linux-kernel+bounces-773104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C0BB29B71
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D152A18A6573
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FF029B8C7;
	Mon, 18 Aug 2025 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CjoBP3za"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013032.outbound.protection.outlook.com [40.107.44.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5E729ACF0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503921; cv=fail; b=AoUvYAsHvP4paWHgPLqZyb0QEbd4qPMgJy/kvHSBn8Vnk7DLERO4ibJcIsM+vnyLBm9BeiW/WkfcP7QwwBNoKv5LED1wKxRUWCAv8/FNO6dw7VRwmZqKK2QoMdNhsHbj6QV1l2Hr9x46/JA9HMNJPa3tjR86dqRrhfEfsaEgrqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503921; c=relaxed/simple;
	bh=6H/XOL6hEFEnFLKn2BPDPVutJ3jOfwnNJyLyn7oNIRU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lbZKwx5iHqQsN605HTRQ0HweqPxMwCnKJriZC/mz9Eiv+pfARj5t/XjJ6GESDT00Gqj2tABUIBVf/UUBSbi61Z+ykOfCpZGwn6/OfRQrLjpMIeCyhG0M7OGqG14JAVvUOCdvF+3NKqS/cR4aD/JNMuikEqchYD77nGUFGhHcf2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=CjoBP3za; arc=fail smtp.client-ip=40.107.44.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ay8wJtKhQrwkwNl7zaBdH2iSv0rcqCclBV5EBOWlEJFZFxXJOdbvbsusQYrpAbm+IOBVnlm+MDDnplG5KA8wGrqjfOSgoePhU2v43OBe9DDYufMaTfEAyz3LCO4Wjv27WEoatPQnCzxj3j2a8cTkzj3GRg6Chx0pXOTn2MqBIDoIDFY7SsxyIJg4ltiO0xBBzT67U8xQSVkmNmOR5AfYQhEmH6en2FTa3JtQS+FN3eOwmYgP9TebYTKQ13Ha1R6C9oe/vr1oTV3CkWj6aIqkuYyMS8GaAI7H8lCHlGTostZ/IB5MefXijUl62oizOflmMAjQdw+nwGLiMJsqYG+bmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnO0qhs56rPCr7FcdBr2izMtmuDapPzEv9xfGkvoAUY=;
 b=tUx5r43ZPiu6jTp2t+SNvfNlI/00nUQc6HjLaeoKJXfaYKrFbrDnZlnfs/s4J86wOmx4ko1Ac/J9BszfS/T+ztP9VlIFXDZmq8qNsdpDOZR3F+DgGcQLVK9Cc37ivTJTPQjdQ8l2kvFeHRdFAsDjcGzNwaux/duXVcp16sD0/1A/cVhaKF3aee/wF23lq2dTm+stSQdw4KbaVdBePio+TzHpJg2E7QuaZMKU3xqll+KcVCFH5G9Gr5t/nRwBhHkaVZNIoIN716H8J3yPEq3vOgHeXiOBjIOOb1x0iWd6wPNxFvLGTVhjwsTegsMtg3jRdHBvCIChG3rXd/dNkH9Vsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnO0qhs56rPCr7FcdBr2izMtmuDapPzEv9xfGkvoAUY=;
 b=CjoBP3zafsCHWpnZJzvNADdWR/h8UIGc90YCdqJUk9wXrGybE2uLmHL5DZ4xkd0fTyuJ0O2ixlUO+y49jY/4fSvY4Xqe81C63PrqaA9MxfjL5yKEPTtrI15/Vdq4lHg5esI26cAg8kL+M4e5kPDsWyVzoKvVcNzS5z6McrLPrJbfCCyoZLo724XfZ/o10luLReF2xirzjMP/xL2p7SfZfkAS/w379/FYdm9paEHKB5YcxXe1GaYSeYDwpdm43etE3tgXA3OH1H764NEBs2PHXVAvLdUv01eDpamCCfDhGWRVqr2VMjZWVwhhyP/LBmzpdnRL3/4edFaiBHye041trA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SEZPR06MB6016.apcprd06.prod.outlook.com (2603:1096:101:f3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 07:58:31 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 07:58:31 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: sudipm.mukherjee@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] parport: use str_plural() to simplify the code
Date: Mon, 18 Aug 2025 15:58:22 +0800
Message-Id: <20250818075822.479693-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SEZPR06MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 65774911-879c-403f-914a-08ddde2d05b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z7H5WkZ0Mij8as+oMSGQ1v4cC37Co4Lp2/zDxkzzM01qL44w49iYuGHl2QGs?=
 =?us-ascii?Q?mX967rpIkXYppid2f6idao4oLyo7up/6AR8Gko91yAjqsmOfmN9VrROPZ8EX?=
 =?us-ascii?Q?QMPL7IFOwbrLNJsY7j7hx8qJfuL1vdwu3XaGLf7v9kjjtdf0hv689d4FLV4r?=
 =?us-ascii?Q?1tI0H7Ix7pE+MoIWUGRlmvlvgBvb/A5UVQaImac6zUjWLiEErpE5EThfKsQq?=
 =?us-ascii?Q?NjDPeIgkKl7d+T7jAgjNSbldSs7dGlPa5fotM/6kv52Xcxc+xNf/Ata1IDo1?=
 =?us-ascii?Q?dNZRMH78Eo7SHue4UVCJiwwCUEaSVyIe3AXPIHvdMhfvzzmiGwsjDe8zVVFN?=
 =?us-ascii?Q?z29Jfh4xv2/xbUcc7LBpBWwPXec8KiXslazjS2Wlqhw0zDZ4xIVeMN86Sohn?=
 =?us-ascii?Q?AYSDbiUM2ov361EF1mnGE+iEmuv9OkbGDh2UupEfrfkoD8wObDpLmYTysVQT?=
 =?us-ascii?Q?g6q6xpN7F2rhTL1cjJlN1cF9faEoP7rm7RgCvB22ufOGSdxmspD1FkuGiQI6?=
 =?us-ascii?Q?MPn7tVppqnt/IjbBBW7ld9oaPWYwSbM/0HGxIzkLOruXoxbvWQDU5DU2x3sK?=
 =?us-ascii?Q?1Cx7jAeg2ZAWr8lc/vsqI7V8h8T+4+2mRs7EmnLykP5mPMW8Q5T4/8SWpJh1?=
 =?us-ascii?Q?yDU9MjzEuQ4B4ePKKDozGPpD001lwcGatK/wOAQuo6tws/hhndc+wVRbVrYW?=
 =?us-ascii?Q?0M/4JqCRpuRQ70BtCa17l9HoXYzT5FvTJ5PNXnpgsoDvNw1AqJbd5f50BHSM?=
 =?us-ascii?Q?/RJUh32NbND3Dx76dVwYjzp/2fGdooqHOQiz6QGMyHARLpQaMqOubD/EnZHC?=
 =?us-ascii?Q?CgIZ2qkEC0QFgAeQiresE7HwOdl9ioQyMnKkMROIsdZnswGHtz+DaLwa9yRJ?=
 =?us-ascii?Q?lqMRtz11e5BtZS8C3XQcaP3m93KxJ+Iuu7Lhw1W+LKuCDhUO+DHdHmj0V6ax?=
 =?us-ascii?Q?z9KlykXK70b+U0wMfEHzZXQEEj+IuKh6Y4fRQtemkNk1mbb8UU9LGuKPmElM?=
 =?us-ascii?Q?/AgOf9yaoBH58dVNibUk3CTaRcobC79GgxgsuhV5ZYgWiFWBBF+FyxZvf6xG?=
 =?us-ascii?Q?uc2t+qHe8TmO+YMh7uKcE3I5yS06wZZG+LEc3k8MYcjRBiJ5/1LuItGgN0y6?=
 =?us-ascii?Q?6gCbpcCwalH7aqEDYUiHGr3rAIL9d0hpnK6YbEPlEyv+RbEYuYdujnx4P/Mr?=
 =?us-ascii?Q?3G9pzUifQD2D6mVq8orK87KgI2Xeb6rjPdUmvsv+twqlEx3puiW2K3Lr/wD8?=
 =?us-ascii?Q?LH/vcyk81wc4zQ68+Yv3WsaprjkvfkFCN0D0qHQDlh7KdFIPMcGp17+dPCDv?=
 =?us-ascii?Q?2wtS/5W+Pwpfc/PwXPoetrM0xpfxQs+agH5MkpcK+Jou+jRzP4FFofR/QO5b?=
 =?us-ascii?Q?FjM6nfi8fJKrXSVmdN5G93E6aqMmQ69KY59RZl7/NjXsC75PaovkEpscs0kI?=
 =?us-ascii?Q?6mlUYOHV6NSLi4ZdFd/qbLKG1SnnxZ2o9xH1FIQgAkPhvZA3UTATEaGweMlL?=
 =?us-ascii?Q?9dqJrQ8BKzD1vfw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YcGGleicGOuKxp1j4Eu3Hv7RkMPMPYcJwCaVJTnkQS/hNfcGzRr9CO4qdUrW?=
 =?us-ascii?Q?IN2zHfo7+03OQxoM2PPQzhxNDJN6lYJljF18RRxjR4ShjDsYpQCTvqF1CQze?=
 =?us-ascii?Q?Ysd1+5anCNZulV0bxCmdYSk8KBgVGo2oXwaCWwITIQju509Grq9aPavsysW7?=
 =?us-ascii?Q?lkE9ABVG8902FyzoKE4PVHXhnFboqHKTpQplKfZGHDaOnCth7xFY1Zg32/u1?=
 =?us-ascii?Q?F9VVB/M4iJGD53KbjlDFyIyrgpVKazaSoB2w6xNYWnPbF25hxeQSrZ5rKxDX?=
 =?us-ascii?Q?F2yTCDG+81VIvAnb+TchlL+vE6qi/d7yJQOKZUa+400Cs+5Yd1/HsaQEeLYf?=
 =?us-ascii?Q?rJSdjeUWhYUHEjWY8PNs4F0TRcN3cm6KiVBhk86KO/J+bga+PnE87l1t4p5F?=
 =?us-ascii?Q?OfQ/jfqWiUyF6zacV8AwJFkPFGXXkM6px7wqj0qFj2YbSDz5aQlWoPm7K40R?=
 =?us-ascii?Q?n91tI5QVh8VOLKjeaNfRlOGc70ZdjGr4Gtc9Ly+qpDWlw65J2WR5YMVD+2sR?=
 =?us-ascii?Q?S6FZCFKGsU/C2qJNvGid5XJTa1xW9VBPdx8FwSZQzzELOwf1QSIejAmtAwc0?=
 =?us-ascii?Q?k2yZ3xKeCnKXsZnP9eN08iel3bGfzxMhU+VLsU9iSP2DoE4qpI3llV24NqbF?=
 =?us-ascii?Q?mWy1n034c6E9jB4E8Q2KPaI2hLFYnNdfGDaIsEhBaauMgB7s4quNDUQ1cx44?=
 =?us-ascii?Q?mc2n8nDrFPs9ABbMRp1msjrcvelg/3c2XDC8V8/wSMMw7J85EG8sQLTScMH1?=
 =?us-ascii?Q?nX9caO1evhnUHIlxDRU1B9Fgoumhf9AmSMBiPyelHRrp4TIrmTKG6B5U+7yl?=
 =?us-ascii?Q?lB4Znycg7yz22LZbbEURB8NkJuL0bc4zaIm9gPPeTro5TJ5tOVZtBNw7ovkC?=
 =?us-ascii?Q?YkvJ7RxiNULg8FkJGY6HAoPCE+u3qtV2gYTxktxRzDpfZvddNeYN3mLHUuBa?=
 =?us-ascii?Q?7nQ6CaWLJktEQRG8QPSO77Qoc+7KCnyNRq7/Azq2YBna3A4v7bciOCj6NfZr?=
 =?us-ascii?Q?1CbLbUQis9DR8b7Estiaau4w6F8rCCxtYculXJv4CbOjrdjbgWg3PCEuKFgy?=
 =?us-ascii?Q?UlgBXlF4By3OLWaowzhwl+4A17V2rn1KjDFnrhc1txm6DCgLqUqhKqgrg5Pw?=
 =?us-ascii?Q?SlpjS0+/uubvlsE3CPzlidflDP7Kl/EOfBlULjoHyVw3j1PQjqRacF0BBW74?=
 =?us-ascii?Q?FuocTeMm4OhMJouuQdUk1v/nIKc9qtV3xJDLfAC3KQV3Zu2dBohnTNbgj7/H?=
 =?us-ascii?Q?G8UchxQaB1r8IsobMNuQ9HYb/yiz3Ofyv0Ae0U7ciqmUS2kl4j9Y87WdmLay?=
 =?us-ascii?Q?UPxkRrhoprw7+S5h+Q8mc+jtQfkiTnFDZwGzOGiKb5F0H6H/RaWyLoEKqzTT?=
 =?us-ascii?Q?mYrJ6FVT/+FOzlIUhuOVzaTLel2n4XHwgvlmSCR4uujtGDvc7LuTFXn+SHih?=
 =?us-ascii?Q?R0FlVL2DwOUVc0xo3pPAVLkyE+P89louR2PDZIt2yxHBHOLYNs24pVApmx7B?=
 =?us-ascii?Q?gyVO/KkSJIFqL9Lo/j3a0XvuX/c/WAlR2BgnTVK4W9B5BVQvoGb0uARROqrF?=
 =?us-ascii?Q?o1cKA86gyUk7bsmyuWPuKO50ASe5VLl2OF9aMOkN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65774911-879c-403f-914a-08ddde2d05b6
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 07:58:30.9782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ae05j/3i44CluLlQtlKp9MO77RO9czrxgOZdvUJn+NonRS3JmbDmVol1qx+juhz9wTgctkaI4AYzaw4+aheYmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6016

Use the string choice helper function str_plural() to simplify the code.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/parport/parport_ip32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parport/parport_ip32.c b/drivers/parport/parport_ip32.c
index 0919ed99ba94..a45ce3338199 100644
--- a/drivers/parport/parport_ip32.c
+++ b/drivers/parport/parport_ip32.c
@@ -372,7 +372,7 @@ static void parport_ip32_dump_state(struct parport *p, char *str,
 		if ((cnfgA & CNFGA_ID_MASK) != CNFGA_ID_8)
 			pr_cont(",%d byte%s left",
 				cnfgA & CNFGA_PWORDLEFT,
-				((cnfgA & CNFGA_PWORDLEFT) > 1) ? "s" : "");
+				str_plural(cnfgA & CNFGA_PWORDLEFT));
 		pr_cont("\n");
 		printk(KERN_DEBUG PPIP32 "    cnfgB=0x%02x", cnfgB);
 		pr_cont(" irq=%u,dma=%u",
-- 
2.34.1


