Return-Path: <linux-kernel+bounces-883972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 878C5C2EF47
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 03:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 778CB4E5302
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 02:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700E9239E88;
	Tue,  4 Nov 2025 02:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="gXD7pBXx"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD00123ED75
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 02:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222879; cv=fail; b=Wd02ifpmtkKMN8SRUK/SjSPIu5gpEsze+ajS1iSoLGi9XXVbO7A78Pb5uThTFEZt+mviAmlSYc0NtDFtl6xl9HyoqbKA84H+pc1j6ihKCXhI9PzAs1CyvD/XkF8/DRR71tA7+JcXhVb5LSSZP8bgnEjRfSw4sv6annJdS1/CAOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222879; c=relaxed/simple;
	bh=Phef3yCNhkDkmejzHw9IU0oMFfNu0tBkcawYsgDR+gY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N3BzBN3KmBnug+CXtwALjmAffBYCuwykgHesj7nigFnpbpFc6y70W1wvbzItp6+USzyA1+n3kAmZ6bfb6q/IvXusoRZtiYyZfPJ9MABlOByE096LydtfWwngHH4c0r8hbBIBT8vRfg3m8V/w4vsVbCNaK5cgwRlt6rZb2XA4OYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=gXD7pBXx; arc=fail smtp.client-ip=52.101.85.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2JLqLlzjIILMIVyAwX4eJpEbmXMibfALYO/6KIUY3F0mKrNBxa+uJcetKklE8+3NsxLBRNPTogSnMxu6zp65RAlokcOUNk5GcZ3dBaLSKYrgSp66Tbs6czQ+QcDPxiArM562W0y6Zs2gFEF2hnWkutXs3RR6/kcbWzaraLJ13jbjWWSD8t1ryh45VKKFBTfnbm56+X83M93mfTB+EENyeSSTj4DyBWNziUK/3uePz+bTP5K/4SRRrS1mxKftnU/EdG7PVxVaieoJQyDAKNq7J1o9tlAZ6V513LLhWktIsEi4imX9lUUqHJ1yeE/DJ6aymICcek8OInylOmjoplTPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CN5u5lJcucx7UhIc+g3W7rTlErKnk7LF166cBdxtE/w=;
 b=K+2JM8Hfe6e+f0OTKg49vrOSu/Xlvu3gRM3iajEQlBYF9+r35P8cmUgCGCMmzZKY7TJkAuVNWq83XqBSrCB/uS9cyKdaaD4ID2QBwGdaCH6A0ReqN86e5h3w41AyIZr7BID8PlgWC2Yn4IqvhkfrbhFPPrZBFHlwKeoGJOks0wEfjwRJhV1wvU/La35uvtDhCsIpOMyfvVigtTYnuOkmyu3yzwLtJVaRBou8zw490iKw5etcSr80XrGVgospQo63yabR3jvXhlpmTpJ7PiGbncUt/bGmTCd6IwdQgl9k8wt7E8LG2ij6evrIgW7E6LqFXg52BII1OOmrBHDJJQ29vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CN5u5lJcucx7UhIc+g3W7rTlErKnk7LF166cBdxtE/w=;
 b=gXD7pBXxAEWCgjtVXNOCfm2aFm9f2CtDrMIF6xfzns/tzzpnPJKT1zGlllykUEoanreus0lfRne1cz0xei9UxiCalQrVlhmRy+avMN4WcRckNwZ+ZYsY2bXBXjlocJJKLBVilk4XaTdbAtlKzUpcc1m2D+fDA818mKK/eWxWTAiDBdPcoU9n/setqrxlmL3KKSGBrCSFggEj9yOFqdww7VP8nUdZ3vKtF6T7G6rG2xR1iFsNbNOujQcedKS4ddtvd6kjEkHzdiun+Y3c4f229KyHm3Bqu+k6KrZN89F6Wgzv35rR1Cz1T2lOG1mK0lsIk/1urllmgfOHaWup5kFtHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH0PR03MB5893.namprd03.prod.outlook.com (2603:10b6:510:32::6)
 by DM6PR03MB5132.namprd03.prod.outlook.com (2603:10b6:5:1e4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 4 Nov
 2025 02:21:15 +0000
Received: from PH0PR03MB5893.namprd03.prod.outlook.com
 ([fe80::d003:bc08:7968:c605]) by PH0PR03MB5893.namprd03.prod.outlook.com
 ([fe80::d003:bc08:7968:c605%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 02:21:15 +0000
From: Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	linux-kernel@vger.kernel.org,
	Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@altera.com>
Subject: [PATCH 1/1] firmware: stratix10-svc: Fix devm memory leak in Intel service layer
Date: Tue,  4 Nov 2025 10:19:05 +0800
Message-Id: <df381bab9175b12c378ba233e7ea77075e7b3229.1761806203.git.kuhanh.murugasen.krishnan@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1761806203.git.kuhanh.murugasen.krishnan@altera.com>
References: <cover.1761806203.git.kuhanh.murugasen.krishnan@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:820::15) To PH0PR03MB5893.namprd03.prod.outlook.com
 (2603:10b6:510:32::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR03MB5893:EE_|DM6PR03MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: c9cf8e33-4482-413a-684a-08de1b48d46e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OYs/Ir6rXYvAhnKmWZRESSwFVV2MslIxSvgwdDRIMRVC9UXI16w1mWJBlFJj?=
 =?us-ascii?Q?n7SwaT4Mmj9fCR65tvQIGnLc2p3yDzZTwuOH5pQIBKjJgsIwMDLOgbcrv1Ym?=
 =?us-ascii?Q?u1vwvyEzPy+OvsTmmHK4X1vwP87jp2caNon1UBjrFjlC650JH0MO7OWE856H?=
 =?us-ascii?Q?+bvj+W8tUG8LxzTYn1hz749VsypUtk4KU54ghmM3unP85qlnGzSTjO/L0+fU?=
 =?us-ascii?Q?pymFfBG8TPStQf8/aaCCxEKsBR9uc5wynLLLU2JfdTlAJoPT3wl6iVEuj7By?=
 =?us-ascii?Q?ZgJziWvliXr1G2fYvQRHLbKBYUqXXxrZmTb61Lc4Kt1dfzX5ZYAMdoQyYe/H?=
 =?us-ascii?Q?yPZrV5i7mpSSTIVyN2Mzf8y5LqmNuubJCxksRH2bgTLdDkzz/m282pRwpuTK?=
 =?us-ascii?Q?no0vomNw1UtUkyiusKs40fYsJV7qWUMjeg+jeB4LKrvnno4f7BCeFg1PLoOE?=
 =?us-ascii?Q?ssUUFd04HWkYFq6+XJ4ZNFpdbSiv/bctC+PQOer/rGkYfxm4kJHkKYWXbPOa?=
 =?us-ascii?Q?Cct9boxoyKz/7gnh3xNS9GSOfU5Ng6U4yszANoU6eW4OWxc1X30tlWvCLHtE?=
 =?us-ascii?Q?ihXP59ue6Q+xzMthsO9LYjSq+w6wC5jmknq5aq0ppUXSFJG+oAteOR49fNJQ?=
 =?us-ascii?Q?jlOZ14K60duptmG24Q19I0nQ7qFgTWrmAKq8V6wP0njBIABzlLGXrcSmKtuC?=
 =?us-ascii?Q?R0rdJwXrVycmz3MP9vmu4r+hZ+nexkFUo3U1oryymv5cmiN//+coat54CM85?=
 =?us-ascii?Q?nNeXWPMgbxwUl0o1D23k87dXhcY4u+wnPq+yTf4Y1jNurM6dimJSsAKFNMIm?=
 =?us-ascii?Q?E2Rp8Jy67hZk+bZvm1QBW61+XTRh/k/JhkqtnM6OUQZL/1XBSB4hPS/Fc7v0?=
 =?us-ascii?Q?rx/YzuKo1Twiao9OxP/FGW6WXN4WYBFLRc4roxrAKJzLjoYynC5I9Y2Wa1v1?=
 =?us-ascii?Q?B+adEwemHjli8oL/b5HA3lm2Q5iKrnmqQdeooGUilUYAtAG2W3fwZRKDp5o2?=
 =?us-ascii?Q?+h36UAUNmjDHgoTv91uOha9dT9VbC6yNi5x8If5/H+liKFnNtJlHyRikmaOa?=
 =?us-ascii?Q?hcfAVeZpu7N2U/ex4Pw8IUNlF/DKMNo3waBWTNBdL9ea7b3Ph28c72QAyhw/?=
 =?us-ascii?Q?p2aOPLTp99Z81F14CeBN3gfgDW9K6M5BsflU0wCGLnogrNa/xd6ygVCjt66t?=
 =?us-ascii?Q?PtM0WZQPxx/8ieXgUayMyC4BoSjHPu8rYG23QN2fWFUUhki+n52u/+zf4qfZ?=
 =?us-ascii?Q?Ao50/ODQHXS8auuAgl/afCvPS5E5pKW0ffpBdF6cikkV1sLPasXPshum+FpA?=
 =?us-ascii?Q?PZxeC5ptN/7E7W1G5eEV7a7lEUa5v930CRQg8Rn65FrUEJZl7FK0pJ2sHYio?=
 =?us-ascii?Q?0wyEkyODhwKlNlcDiyV3cI8sTiFCtrKi10tUl6n1Wfku5d9NwTqCpmba8ERr?=
 =?us-ascii?Q?QPtMyiqMrZFcXAqTETjdewAWEVD+Jd0f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB5893.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7HmNI0PWOW1lL5/UBrozb8zAe0cG5fDzQMaF9gUUA8rnWRBHV/w8EVZ6F05Z?=
 =?us-ascii?Q?kRJxij+z2eLk4BORDH5gRjQ9TI/ujOgOfF7qzUJjgHTXfN9vG+MGG44nm6tp?=
 =?us-ascii?Q?vLHFi8DaaK3qpTGxZQ0e2EfyXTRkjQOuIkkTq5FUt60Kz6i0IdqT3/PU0TfM?=
 =?us-ascii?Q?LBpQ5vVVX6HAo1cbd4gmHpesAh8h2+3Zu/PyrKNMG9K4etyOkXUJ1gGeGdUA?=
 =?us-ascii?Q?idKuS3QEQP50rml2P/AZlF95AR4F80YGsuyscraXqVblmjUeNKX88zi237mM?=
 =?us-ascii?Q?iKPj5VbL8GrNSb4Csw9g7zTYybggcBQ9Fz1g4sVmr2Hotx+4FtxquKKYlEA8?=
 =?us-ascii?Q?XETr6G2CCOP1Kre5zGbEW3+RJfwiTyHFmfoXqqA7wwxbf7FswQLLSmicOpYu?=
 =?us-ascii?Q?Kf+4ZVZ/7SdPyN6tT7sXqQoRzHBdhKv3w77SwEq8o8LllsAJBZb7dPyjQSCc?=
 =?us-ascii?Q?dgBabmc3yIlmlpbZUX9l9Fjqx5LBZW4imS9wr3KvybD1InsdMXyivuc5+gRK?=
 =?us-ascii?Q?cTyIzO/Ga6QlNMecoJnaTvMqvUkTko62ME217mp00/rfzORUT0phQc+ilxDm?=
 =?us-ascii?Q?qxuoG8sjHbjuSyGP2NRX4bJXXciCggI5oMsrfd0pVL/0pvfGpw+IJ3UiaKYp?=
 =?us-ascii?Q?XY85EBM+mz1v4JwntQVOyFa/7iOO/HLDNZ12qx4Ndn5UFnJotrBRd4ALiFSX?=
 =?us-ascii?Q?5O+qd6F4pmmgUxW6oaleyEgycrkRN3zH7ORZ/rDfsWyUCH6K1bf1HJa4xDyi?=
 =?us-ascii?Q?55X5Jlham4x1ASjzoYNvZfm25Nkn/uoQwN7NjrSe/gC+hRiiRXp9oOvCQ0u7?=
 =?us-ascii?Q?nWdDMeONOoMYEuuA6e86wg+1d2P3ARHTbfqsB03GB2rZGR7wBK+0bcc8rz/y?=
 =?us-ascii?Q?0nPCfs57QsMaYblkrQ3Rzpn0dIPZXy7tL3bxc8kdiEDQZYj1U3fL41jAkyW0?=
 =?us-ascii?Q?OwcjnPloHbJHTbHeo1AsGiLMCI1IAiXMwCYfHIVf7sEPNvrlSDge04YEA/4m?=
 =?us-ascii?Q?nTtC62j/OSTlOv0A/AcY0kyG2PY4U/0W1NLpr6kbxf0NQVCipkAPRRJPYBRc?=
 =?us-ascii?Q?se0UPpK+sLGKE7Db6tURaDSb+CFMhP2V2YfGPRabgyX6kHb0Vro+1aIgTZaX?=
 =?us-ascii?Q?M4smZUYT6lS1W7RDoDIWD3IV5OhyEfVjCnEJrBlyKw/IIlqETXC/VIAs8DdU?=
 =?us-ascii?Q?w+5ONNTloFlpLTgCC45R6psfF15zDLYzOIqm79EczROF3tBZ5ubQWiKF9+ZX?=
 =?us-ascii?Q?javMmqmIqf/3wqaKgXhMkSZfs/uLKEWy6JgUSjqEmBxRyshtZL7hjxx/lq2y?=
 =?us-ascii?Q?i9iffaWpi8k/pLB08ZC2jp4z8dwxRiKXdgidsln9Yl+uO0NqrnMv27qCzhAw?=
 =?us-ascii?Q?tzMrISv0Rpiyi3bQGiEuqoINeeO9vEopLgCUhW/qutbZ4BYWHuax3pzsyV/i?=
 =?us-ascii?Q?huMFk4PAj62o2gAIikE8i8pO6Qxt+WXRfyeUVnvNvVCZ5tz79nLTBtHu22lB?=
 =?us-ascii?Q?8DCwd1vL7/52RnRSYyJutK/NPkzOzFzoQMaM+hnRMJVkmFAwpX8ZokSv583T?=
 =?us-ascii?Q?haNygirlVq+T/aPoUsXxW0a47Gcsqy6ggUj7IZbdCRSw9oRcpI9cg61RCJqg?=
 =?us-ascii?Q?9cEM4x4tUeuPuq/vmWCUDuQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cf8e33-4482-413a-684a-08de1b48d46e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB5893.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 02:21:15.0030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjC4rN/PQGtLE+NLqtnQE6MYH1nkKXEBnOfCeMlDZcwu6YH93ZwppnE7t2Z5Ykq+b1MdFqNJ92WBzT+Own39WVm+EZ8C5VvedNq1BSlojus7NZq2gR8jwWzXcXDVMz75
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5132

From: "Murugasen Krishnan, Kuhanh" <kuhanh.murugasen.krishnan@altera.com>

The Intel service layer is a static driver that remains active for the
entire runtime of the target device. Using devm_kzalloc() in this case
is inappropriate, as the managed memory would be freed automatically
when the device is removed, which never happens for this static driver.

Replace devm_kzalloc() with kzalloc() to ensure the allocated memory
persists as long as the service layer is active. Also add corresponding
kfree() calls on error and cleanup paths to avoid leaks.

Suggested-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
Signed-off-by: Murugasen Krishnan, Kuhanh <kuhanh.murugasen.krishnan@altera.com>

---
 drivers/firmware/stratix10-svc.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 3acfa067c5dd..17f4c9359dad 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1798,14 +1798,16 @@ void *stratix10_svc_allocate_memory(struct stratix10_svc_chan *chan,
 	struct gen_pool *genpool = chan->ctrl->genpool;
 	size_t s = roundup(size, 1 << genpool->min_alloc_order);
 
-	pmem = devm_kzalloc(chan->ctrl->dev, sizeof(*pmem), GFP_KERNEL);
+	pmem = kzalloc(sizeof(*pmem), GFP_KERNEL);
 	if (!pmem)
 		return ERR_PTR(-ENOMEM);
 
 	guard(mutex)(&svc_mem_lock);
 	va = gen_pool_alloc(genpool, s);
-	if (!va)
+	if (!va) {
+		kfree(pmem);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	memset((void *)va, 0, s);
 	pa = gen_pool_virt_to_phys(genpool, va);
@@ -1831,6 +1833,10 @@ EXPORT_SYMBOL_GPL(stratix10_svc_allocate_memory);
 void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr)
 {
 	struct stratix10_svc_data_mem *pmem;
+
+	if (!chan || !kaddr)
+		return;
+
 	guard(mutex)(&svc_mem_lock);
 
 	list_for_each_entry(pmem, &svc_data_mem, node)
@@ -1839,10 +1845,9 @@ void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr)
 				       (unsigned long)kaddr, pmem->size);
 			pmem->vaddr = NULL;
 			list_del(&pmem->node);
+			kfree(pmem);
 			return;
 		}
-
-	list_del(&svc_data_mem);
 }
 EXPORT_SYMBOL_GPL(stratix10_svc_free_memory);
 
-- 
2.25.1


