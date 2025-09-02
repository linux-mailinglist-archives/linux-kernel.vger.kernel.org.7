Return-Path: <linux-kernel+bounces-795678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 099F2B3F650
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869641752B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFD52E62B9;
	Tue,  2 Sep 2025 07:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hBSp52dk"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013062.outbound.protection.outlook.com [52.101.127.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D9D2E5B09;
	Tue,  2 Sep 2025 07:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797200; cv=fail; b=oLmikCTNXGxh2Ts/sODCXY01Bdct44tvypI/GH/kx3P0rrPNmI7D18hiMqeqanT98z56EB2Eq5b98WuD2X86qhfLGitX+bA6vUfSnH7wuO+kzXkcDvRA5qlOwW58SnXqUZQsRbK+7FEnx52E9IlrrIxRMSz84VKwK6gWugSkjd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797200; c=relaxed/simple;
	bh=Wk9+FGXdzXHX+wyK8NmPnFcWB0pI1L055Z7MaaFRgPI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Psjhs561T1P+exdX3zc+NyU3c/MdrO2fKRp5upeipWuTqTGMkdyVPHeCNMFWprmkeR7zfidPt79FzwO/Ikwn0e9WJARo7QZmvpxzAq5a4TjU2UiGOFmBsKDLSqgpBf6dW0gqWu73fQSAzZlT5uLoaEqhX8MUVEL21JvXkiKxqT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hBSp52dk; arc=fail smtp.client-ip=52.101.127.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhoEwXo3Uu19UHAMHOADB/gAC1YnQIqZjlb6wcSVlt7MnDHXikOGeU/n6TsxiisZ+vcof2F6DsIFrzVlkv3F3Y5gc4lgdbHeSnQl6vcOj+y3jE/CAXsoUzSMkk//yCTg9hySPim0Dmse+s7IRMjom8oCQO8Yg1ZBKX7UzkviJeNZHQsZWN4GKYerdnKq8jmsU5TChdrxX9XHFhlMa+H79t6+4lJDeuT9MVWr3jBQ1Yqp4M/xjWJD9tLUurPen40MMFYHJZNkQIPEHxkBmtGZaTkRFuqN/qxw0OY6JJ8ceqc1uhy8hzYFz6gmzTy3SKVlytOYyjYVN7ON8szvFn+KEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQwvRc6PAoeLGnahZkFi/3UIaPcUN8nfdim3MPCdcoU=;
 b=HqhAmbDMNF6Q9frKyxt7wJFjW6GYlr9nqhzn/RLVrmd7wj9xxkKEEn4y+8uJm/58BdghQx24p6ey0i7+J2RjQUMZyC80gVFVGVAU7GfuwUqKweL7hHJ/Z98S0cVxRML4TYmfkoH28htXKwLEaFWkFMjyJknGLI1PqxylwBUV3/awkFuZYZMhn4BJeZEx68u866HzapnFmlrapmhcFA+Ow8/R0MbUzLVKEOXJ6HPWJ9INVZ0dujXzjmQ2pKE+oQaadgY7sCdMVPHNyqHOc81RbTVxxt6exicxPqk9q46YOmyX5RWMKCNb2aCazfsHqnXDi1hbNsFiurnxwnXxbGB4Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQwvRc6PAoeLGnahZkFi/3UIaPcUN8nfdim3MPCdcoU=;
 b=hBSp52dktTlIsdiBffrt4X0UTRDHHPbrS/5E06YeTIw2S1PFLA+q8XfVpZMyINOjpRoNKXIkzfWWjS5nf8PzgTknT/QLe1J4rFcCd3HY4qTmTLBz4+XILlWtVHcQAxzuEJlGBR2cxDW5x9BxBVJJb0jdgcS3PM5HAIFJJXjzZiCZI+E0+mqHDnSKimTNkX4QAcLwIHGZ2laToUASfHEVz+u8QECxGYUG/EmUDHjd/AyRTpystdVJEZ03+5PV3QYzheRXwLvLc3ZwlTymB1Y2heXXR+RVm2YYJ+Djr0v2N88PdURAXU7cKaqKKWzNaJqbogDzmxvfHfqCZRIs3jp0QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7335.apcprd06.prod.outlook.com (2603:1096:405:a2::13)
 by KU2PPFBB5DAAE7B.apcprd06.prod.outlook.com (2603:1096:d18::4ab) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 07:13:15 +0000
Received: from TYZPR06MB7335.apcprd06.prod.outlook.com
 ([fe80::7b7a:484f:5ac8:29a3]) by TYZPR06MB7335.apcprd06.prod.outlook.com
 ([fe80::7b7a:484f:5ac8:29a3%4]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 07:13:15 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: srini@kernel.org
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] slimbus: messaging: fix "transfered"->"transferred"
Date: Tue,  2 Sep 2025 15:13:05 +0800
Message-Id: <20250902071305.88078-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To TYZPR06MB7335.apcprd06.prod.outlook.com
 (2603:1096:405:a2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7335:EE_|KU2PPFBB5DAAE7B:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fda099f-23d1-46ec-696a-08dde9f02f44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?emXyLlADYV1vW/qR+inxkHUz436c/D8Ubx6uvNxoJENNWyybznDzrRtv2DNw?=
 =?us-ascii?Q?o6/Atflo3PEnsvpc9E4/UI+JX99fl1a/b5DN7dw2xHX/iP4qEc5/zA6hXigh?=
 =?us-ascii?Q?yoUD0zodJT2xW+YCOLMhnU4XfLlhClioa8mqcwCRpq0pumgHiqxN3eT98ZJQ?=
 =?us-ascii?Q?w/bfMTsEaMlihcSQodLI3zW+zOHAxvOMmqp25vprEH/c/jwu0XDmcCElIf1s?=
 =?us-ascii?Q?4QFfmBBPtkwMpFahDApzPt8ogd2uLv7OLD6bAV+QWLlBMOCnWyewK80bTIhz?=
 =?us-ascii?Q?9fK3RYZsaIl1v+HeM98tYooGZsTdeFB+ZN+4/T2lMdiSVxtNxEaUrToZ5doN?=
 =?us-ascii?Q?AxqUuE4ufPOvRZq0MZU/fY9ICUqY3NJL5KhGEb+uf2zB2nNxbik28iRm2sis?=
 =?us-ascii?Q?xuk1rYM8cUN8Pn1X2F0ixQWWSQZ/6gz388iZ7UXOaPuOjSCycfBQvqhpGlew?=
 =?us-ascii?Q?Y33doF/Baj5bSZvXoMudAdafrlbxeuKstBjFWG/3fHmIDyyFGl/wqZFZyVQ0?=
 =?us-ascii?Q?ZEf61lnVx31s+NYwxhV7sv59xQwheV6Jq0DTkwiaODnA0YPCwxU9B++GkKJO?=
 =?us-ascii?Q?BbodMleXwGWndvUHOmrJqVwgENdxHg7ZQ8bWZnuYUDFgt2FL+OXkq8Yvj8Vr?=
 =?us-ascii?Q?VYndH9dBOa4iqxHveKP24JCUaurPdFTD5n08BGtBigfWgyS+uNKQ6TOOsyve?=
 =?us-ascii?Q?a3W9uCOT5Kln3N8Q0RNlQK/NcKGojwjEtKfqWx5XD15iCBt3ItbnoUhMtW8V?=
 =?us-ascii?Q?Tn+8xJ5u2Nj9WFmRIxYX4Ld3wGIfUxlf09FISlNFMy5tN3VRhjTwk/S5JJP3?=
 =?us-ascii?Q?vhk2s1S5EM4DVDOM8ZLIKX2OCp0H9ErArfunNXccKRjo28N4L0DPt6fI8qgp?=
 =?us-ascii?Q?+ZGtUgyWwpry8Ctzzi7SnOCOHDHN2tK9h883MrKZf7rvo5Pwbsm6YE5uInQt?=
 =?us-ascii?Q?AR9lkaT+H/sMT/70WVdYFbF48+1bXk6NXUWbVHd1jtf9oPxllnwfIk3dp085?=
 =?us-ascii?Q?i4nkRlsVOcRm4fWkk8bigzxdiquL74fi0Oex3M8czbLqjoTX7ZZX2wCvrwXx?=
 =?us-ascii?Q?0KByUI2rJ7Y81p7aEun3yn1yCw+hPFuPLNxjQxRns56U9gAVmtV3nf8QfY0F?=
 =?us-ascii?Q?ojOv+RhRDGY4xIvcRoWw3Gd7D+4qLrg/1vXG/fd2uSTHPTBz/VjGSHqk2xVn?=
 =?us-ascii?Q?iTSxn3qd7ruuElQVzKKdXYoWt0fn4Tr/lfuKYJfMsjjk9dC+91E9YiLh1ylU?=
 =?us-ascii?Q?alc6Uouucnpz4vLCHrj9IDpCh4QmKqyiA0F2foDuHGnCQwi/FcRUM2ExAqZs?=
 =?us-ascii?Q?jisuBj7sEoB6lRMeSzCF4Zej5rXw2RKk5S2P3P9ORtUTCllw14r7k+bmBk8F?=
 =?us-ascii?Q?+RVIjTPh7qruylfBsUwOIRmKeZQBxvygeSlPSqsq1hFbkIhSwsV1yuFj21Zj?=
 =?us-ascii?Q?oft363xrBIha3VjNeIxpEpqdo2x/lXczaIQvDUv5S6u3gpEP9eJWiw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7335.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LQ+HgH+QnRH3xeAz4zkXuajUt0eyBWhwkY5XznBO8NdcsYWA+GhpWhyItpuL?=
 =?us-ascii?Q?oNKU5CxX21yd2I9hCtsxUY5xJLdF/wVvSdVkk6oFFureF5GKVCrGdITw5XEi?=
 =?us-ascii?Q?hQMHgDP6UyhwW4Nuw6Zeo5QPImcbaSvSqFc7lhqABfEP63kGPy3VMqCMQNTi?=
 =?us-ascii?Q?vaBDYxSo5+xu+hhhwoZayVW0qGNwQPrWO1DqmHJx9BFb0eQokz4VylruIKFo?=
 =?us-ascii?Q?vnMYpKy0Fi251rwjsoJ3cNnjI7U1Z0m5WYvasvLoPctF4wWQzxp4nRJRhTvi?=
 =?us-ascii?Q?sikiUh5jHs+jW062+G21XaiEk2O9x0E7DrXJhylXBf2Ikhxd6HqFi7FKHBDT?=
 =?us-ascii?Q?6h2JbPABOo562FK4PzyMB32m+dy321oRMNQ8EDN5/PJ+oWNqGeLE/eTdck5F?=
 =?us-ascii?Q?I6aIKtIWgeujC2COKY6K4bVsPdcYJwZxrkrjMezkvtFoFhMoDvLbBOZ4vGvy?=
 =?us-ascii?Q?jwAI5XGTJSK81LnTYv33RevwH769Iq5ZlVZNY6BKMJSCaB7k/bBXxAYzCSmd?=
 =?us-ascii?Q?FGDiL1tjasdezGgdZ5LQlaRlgRHm61OmBQhtg1buaenVio68a3FUFxcETP+s?=
 =?us-ascii?Q?4aiW2IiNviBAT1XMOJd99H4IGcqIAtfBXwfOpzERGwXxuTGJvu4UhDaapDhd?=
 =?us-ascii?Q?ZorwTk3Ar7YnfI6n22cVcRJAyEWvWOD7Q906n58A4Ir569lja/pyqqvIdZ4X?=
 =?us-ascii?Q?NZ4PCG4kzJh06CYSGn7iKvPUlrFvdrQxRagbsDrMQd7OUKWQPzcY8ZZS4TIm?=
 =?us-ascii?Q?E25TKe71DI8e3nU6ZrdnWUrYJYIms39I6ASWqmOjyb463FECbVUgTHZyCIb7?=
 =?us-ascii?Q?wYdE4bUnPJSiKmMgavd+qPzJ0wNqNQF8rHdYxP2/DKrvBRrCO/LorFbBH4i9?=
 =?us-ascii?Q?gxE+iwD+rjLzVWCLaNLZ7KeZy7FsXbK97BofpKqrdtmmBaCqdCB5TwizDMTg?=
 =?us-ascii?Q?kUXteWkcEnebEUBQuthgcrsSqTucZiY6JnIr+JUsglE8mbHAXyGCGGuQAPBK?=
 =?us-ascii?Q?fyEh22UfaLtjCzqoaeBadcwq+RbPC7XHt6uKCcKXDvkFzN6d/YESgKE2F8t7?=
 =?us-ascii?Q?Roa2SblKIcxqNnz63lN95xSXgitrpkQEAwASMrRKv7HyTQ5qoLvY3/CLMeRE?=
 =?us-ascii?Q?1LmmpdN0jJXeyTERjwIY42oOYSO0RZIdGF2y1fRuMhPMCL8TQjl+xA384rV6?=
 =?us-ascii?Q?LMuW6O07MT4wetFhTDEB1ez9Uedh7i5ugfDp01KGvzKnO6dPbyGoCZ0M1Jmo?=
 =?us-ascii?Q?VD261EMOQbmIGWFDCWnGYRotvr1y9i4m2e73nwTPjUHy2tCRR5QqCGh/ZSej?=
 =?us-ascii?Q?2kGe0W/lsKbs+cl1lfof7fJ/ZfGhbqUE5gSVrOGGMkpma48Bfpk4N2DBP9RL?=
 =?us-ascii?Q?/y71kfzP3vQoWshD++1rtF+UhkoTwGBU1bQ/RyPccJsL59qrIGPdpKj4+y/+?=
 =?us-ascii?Q?8Ul6OiofX1XA2SZ1v6E0+z3DeafIVOkcFyhaTCgxygSaU1xU3xQ0ExJMk6eW?=
 =?us-ascii?Q?nN0d1Mkuym1NLHTovsZ6R61ZMXwSY0rCy4H4TP2MdzicLEwte5BPL9rWUX07?=
 =?us-ascii?Q?TdeDa3TlSbYqBBFD1HuSaP+F0V+XemVWHAKmSiBn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fda099f-23d1-46ec-696a-08dde9f02f44
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7335.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 07:13:15.4441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+FkcAIsoO/A5QNqcPqKbiqy75ZXHWbxAOGQAULo489HUGLAIijefbyysRXVo67cIK8aM3V5GvQ0fSB97YnoyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFBB5DAAE7B

Trivial fix to spelling mistake in comment text.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/slimbus/messaging.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 6f01d944f9c6..9ae0a5a5dafc 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -224,7 +224,7 @@ static u16 slim_slicesize(int code)
 /**
  * slim_xfer_msg() - Transfer a value info message on slim device
  *
- * @sbdev: slim device to which this msg has to be transfered
+ * @sbdev: slim device to which this msg has to be transferred
  * @msg: value info message pointer
  * @mc: message code of the message
  *
-- 
2.34.1


