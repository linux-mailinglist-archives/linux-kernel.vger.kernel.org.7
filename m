Return-Path: <linux-kernel+bounces-763815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA81B21A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 04:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2AC163684
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 02:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A622E0915;
	Tue, 12 Aug 2025 02:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="VEMmeo4C"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012006.outbound.protection.outlook.com [40.107.75.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC412DCBFC
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754964627; cv=fail; b=plMP6dKIp+Lg4gMsZbQgSLzT3yaTimQGiVlrr/j4n5e28gYjWptf89d91k946D55yjZUVuYr6cJY0Nm2StcVLlgM6ZgKOhy92YsMQCGuxWFAIBgduFGKgvoz/EjjFm5GMMh1PJNizraPl7+71lmYrphcA+3ErOpjmhgCoAXCNUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754964627; c=relaxed/simple;
	bh=bKz92CPN5gNcYKUR8G97yVahkTDGJQ/b86isqxYiyxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UVzfA7Mb8dkVF7JchrqgibooSafTD2bKG7BXoWnpUoDiPFHhOgZeKCU6q+VHafrC/fl+A9f1svubm3Dy3e+bcMBxbiUJGMC5LGHHYhednNHtEnGifPA4JEHUtwX8KR+go5NRZLAjDDVSji4W4dK3i9WckAlB26U3vJ2Ep0Q4UOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=VEMmeo4C; arc=fail smtp.client-ip=40.107.75.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUrWF9cMOnZTRoCpRxuU89hduI3a4vy1j0+2krMS3mRhjjxkmq5NWPWLV4Fq/+UbIaOifw0fG9EjUWA5BbVeCsCQecNPF+owfT7RY6hRQ9PDIoT3MFA4KLrBt+6tclvLeyMoGCbTBtGM78zu0JZu1dsKx4FafAGFPLfxgxKg4swin64NIC5Tqyi8TygEETXPhyCz26V2WbOvjPBz7muL6WQIywSHa6wEcj/Gf/F90q33EhYABOIGT1DzCe2X2mBzyvZ2aB/oph+9H/CZqXsTvuEPNwlmzlkkcWL+oPEFeFfOT1Hf8/ayjEGhEgP9/+sSp9gbdIlfvXu2v7HIMlqXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvSdhWyzwaosbp0Z5y14WgHgPUsAZv2q/RkuUb57lGs=;
 b=HsxY13LowGDGUG0ZzuJ70XtqL3in4jE+JGxoj1SbQEBQefSSXE9cmY3Trc7ok1AQJJnnJuXHKP3WkG/21gD7Zh2JwORttWA3v3q//K+URHtMeBxSbo/mP/r58uhVcKlrGtQHNuLfUo030TNOKxV/01F2FWAA8btn2hU0xdOs8g2CGUMrNb9VPtcGbEnFRGVwtsg8wfliVYJ850BlaIs2LvUzhVQkQg+mmLPgFau2c4z5BmUh45j6MsCim77ZIuB94NcsSUOFfcPcNxVkOSD+DF/qiFY0wNR9ook6fgnYr1sBrUbyAvUH49+mQMZyB4JTK2J6NFXH9v+hnm/GCqS1rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvSdhWyzwaosbp0Z5y14WgHgPUsAZv2q/RkuUb57lGs=;
 b=VEMmeo4CkE8MLMAvhWx2WmHGqmKTbleIeI0SfY/7f8DE8+c2R2+VIYvl8MAq6KkT1VuDxJUB8N0FowTrHT3YLY3vXcfbRfjIjo6+5HUN9LPpzEaNwVl9RnSt2kP3BjmMIyZ6vX+hL90Do/a/SNvmiYCg9eqVRlfMXCYvMnwsM+k/GE09xlXFF07iVN968DnQrPtj7rTxgc2F6kNX764UIYGHVvMnk1fBktFp5+r5wGxKWkuLEjlBhqgsHbhpWp94sQ4TQCu5VO3X5wUhqNDv33WWo9LE/mj8seZZXPMoJa/U+aZ8BVSB85xAphC7rHWES5NXKB4z+mmAJOhrEU6c6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by KL1PR06MB6733.apcprd06.prod.outlook.com (2603:1096:820:fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 02:10:20 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 02:10:20 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	linux-mtd@lists.infradead.org (open list:UBI FILE SYSTEM (UBIFS)),
	linux-kernel@vger.kernel.org (open list)
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH v2 1/2] ubifs: Remove unnecessary parameters '*c'
Date: Tue, 12 Aug 2025 10:10:07 +0800
Message-Id: <20250812021009.414756-2-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812021009.414756-1-zhao.xichao@vivo.com>
References: <20250812021009.414756-1-zhao.xichao@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|KL1PR06MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: d419e124-aa6b-4096-25f0-08ddd94563b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pmCets/qFjqEttV+hsv/vb0MwUNeZJbj+877SawArKEZYAV6pcBJ1ENylmy6?=
 =?us-ascii?Q?NLl4WIRyaV8mMdjWsHsJpe+a5Cepe54cFkYpCQx0FDC1dowmK1/IrUusD/hO?=
 =?us-ascii?Q?oC5JLlmOrOfBMEB8Pvnjln+yV9j5+3O/WVZ+0m9QJm5X41Wqw5LLoiEp0c4R?=
 =?us-ascii?Q?8vT18iLX7GN5FSEhbkXWuKKmDH+yhS4Lbf69BffKNEq5N3n9/B2JrPXSNAGP?=
 =?us-ascii?Q?tUdUqLZyKzvoYLe0g9Ve3gYYR4WS/7VRe6MyfkIQGT79kj+94Bs3iDm9Gp0t?=
 =?us-ascii?Q?GmJ8t1ViNXPtP3ki8kQGoPRk/hHmwW2a/jUr1R3XfPY+V5GxkDzLVkb6TCEr?=
 =?us-ascii?Q?2QePVIUU8jIIl+GbU43RZdQn+yxMF6mHGzdzktyfy0k+5lnOhs5jk6tKUV72?=
 =?us-ascii?Q?/jibBGVP7TmxfKdM+SdaWudX/gOACHm03lXLKRsZGQWnUEdjfLp5ub5j4b2m?=
 =?us-ascii?Q?YS2QKMKBsxRtbFiYOtTAapsL8dZE/mQ0HrypGlVWTQc9Ahkd4OM3sWxA71SL?=
 =?us-ascii?Q?brKEQQE8dExtRs2z4dfmPRP4qMzwhUqWxyQ2YRZlfZNN5oe4CJ3p3q6xOz3t?=
 =?us-ascii?Q?PpxsspNfPnTh91T2YPtU2yVYK0sGhsGC/+A+3/PCtoRCTRIPq5tXJ6z7baID?=
 =?us-ascii?Q?71LaaFFqBTcZ6gezBusGK/8cW1nSQtDaAHKd9uc6LSsyerMS/jQ7h53EQXF4?=
 =?us-ascii?Q?aIgOTkKuKLOqcoW0pmYtRiewO/yuHsTQf127Hi8z6o7pwj6FQ3ZXGCBv5OOg?=
 =?us-ascii?Q?dLMKtohdYd6DQlt81eDnxc0+RmPpXW4IRr+HARvR9cLi+5NDwgYUlVPrLKip?=
 =?us-ascii?Q?1dJANwFltx+AiJrKviz73B4GdIJ7PO59gTKCW/sD8e+UPeLk2PFYUfwZMUsK?=
 =?us-ascii?Q?Pd+2r1d+yyXJU5YiG5xmv+MuPGhPArt6/bRi69wsoLJAPovp4rT2rNnM0fIq?=
 =?us-ascii?Q?mYBzGuwLr7JqGbpn+bQGUiCbBCl4T6HhU7BnfBcfmdeV9KLliTlau+imhl45?=
 =?us-ascii?Q?vtgN2sY2SimFlEZ8FRCdXq0rYKTmYSbMW5MKBEeFhnidYORx8onVj09m7Bye?=
 =?us-ascii?Q?b9uKNaY+EvCxoh0FHpFkSKuf2HS66yn2In7HyIFd5UZ2T2zaeX90iUuvj8Wh?=
 =?us-ascii?Q?NA7dcoMy9qhfziDQ/8BLWFA25kJMkqud+hPJPkVI/KdwkJJiu5PaYCnEc0En?=
 =?us-ascii?Q?QMIsdPkrDiGRXL5IGqMG55vw3kopr+N6VUs1QlydbAh6rr+BeoYb+BGR4jdz?=
 =?us-ascii?Q?b+QvdY+qYdW25ZHghy+upi9u6wAKzEcc5NW/uX1ExNin09Jr/Uhll+BQTS4c?=
 =?us-ascii?Q?70UT67EM0LEa1iJIGErH/bw8hWY5xQ0GZVSpKjslmjafXDgSmHrWGp2090QM?=
 =?us-ascii?Q?E9cg27mXWo9UkdNep1sTqwgjv4ifd9Or9taDv/Ai74RRfv1kWnwsOWcetsJG?=
 =?us-ascii?Q?HUwAmDbvBfaHp9xPEF9WDNG60+SSenfhfcXsj9orbrgw/2VJpr64kQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OVjUO658I9MwG5TGAoV1A3+sEOWSntMiibKuktH85uqmTPDyiq3JA79kHYDx?=
 =?us-ascii?Q?OAlvFUfU4+yi5892e+dQtztFGbYeJwAPoeD6gmeUShYUcD7eBDx/MHCMLWhQ?=
 =?us-ascii?Q?Jsj7beez7YV54RzlxOaBJ6PAetZqGvD7d75sR2RuFcnbnAMSba7JD03UItYl?=
 =?us-ascii?Q?K8Md+fMEjb6Teufsk58TUoRPD5rPhhUUsJOogPIC8AEIYLm4X272pzX9vpgz?=
 =?us-ascii?Q?kdSmq6KijxR6E/onnaMfYDUCaNSlGHHgZarAqVcGvHQ1bF+qz3iv/Y4eoq/Z?=
 =?us-ascii?Q?3LIBQ0YC6N9HMeZDw7YLh6bvVHVqA/MoI4cSs59AD+ZvQtgzdFUYpqR/BJFn?=
 =?us-ascii?Q?NF5m+P/I0AoRqY59tjSlj86W7uizZN748pVrE8ORLDIQpPIeG/ix3Vj+u0kl?=
 =?us-ascii?Q?62DJgeRhzm9Hk/I72tW5cULCMqgE3ThPQMjPZST2518TRjctZEfRT5td70K5?=
 =?us-ascii?Q?nu5irP6J6guqjiRhLfCGcR1gYakgC5N3s5rg4q9nT84FmnoFz2kvVKzg1sn5?=
 =?us-ascii?Q?0soCBLh/uQ22DUux7SPSBmpYhibDf3APLZEOH4vT36s4Jw2Y6VyQAT9d5spu?=
 =?us-ascii?Q?1gT0cpncffQYZmHmi1kN5ocSU6KIgbsz5t87IYWxRncn3MvDObZXP21jfhPJ?=
 =?us-ascii?Q?VG9BG0MI3Znk01JSr14Q6ut6ED8HUAU4qpL5n7xC3zvQ06ojG44G9vFiTvMm?=
 =?us-ascii?Q?SKe6ko4xJaSbgfccdJk/RDVqTei0KD8ldYyzJyyrUGL1qOmVUxoGpRMeCbmP?=
 =?us-ascii?Q?GNPcB0CrzLftMMIqu2+ZytF0W2cQdj+VmVe7+cPno22kaPU82xvWlpCcG4gb?=
 =?us-ascii?Q?Vr6CLCjPO5SMwIWSuXNhbhFzrMvDySo8GyRxlzSRLNjHzrgVz3hC4XzKjLiw?=
 =?us-ascii?Q?VAfJn1Xu4lECf9FVAmGc9Ti/lbxm5+uKVYJ74iEa9F9MzHeglB+eBoi7j7Cm?=
 =?us-ascii?Q?SCYms3iFZnxKOj23adguJKzTnbQZWQGh0qnn4a4jVZ9fPNo6jPxRlr6afF03?=
 =?us-ascii?Q?XF9bjIR2uvPIyUvqGXQypw2lZ73mDzybenz18fG5dezhotL5TYxNdS5DVoTi?=
 =?us-ascii?Q?jcUCss3JZcl2wzRTr2ubSIQJ4Eh9Q2LDDpwDJYIKgBB3kupCMqgvxE374oq1?=
 =?us-ascii?Q?SNFS/Z/avBN3TPUapOj5UtfWmzbxMiyWU1TxS99fnVbFqP73O+ISTcX88WMZ?=
 =?us-ascii?Q?2nUVcgAhLPOWUz3cPxENb9OEyiQJTcPTvp0Rpkpioi26rNCThZPxiKmj+LGn?=
 =?us-ascii?Q?qc3OdcD5uSJgxlOOHNTaS9UHpYIgKAj5eFAcgYE87YEOM18ydKI1vs693q4U?=
 =?us-ascii?Q?8Ex4KFILKu9O7kRCiivC74A1C4clM0rBv642hHPYItm0TIKKQoejDlDxODiX?=
 =?us-ascii?Q?LbOTIuoFU2IhyNL5XuKvV4mhgleGtGkGrv0dMqu+JoOW2f5BKjuc86Q1T4Ws?=
 =?us-ascii?Q?13Fa0oaeJgmuBwWIwpLneVxvx0HMUcsMMTbfR5B0JiNjjjj9F8TH/j9JuVUY?=
 =?us-ascii?Q?ExL61bRdJ9beSM7IUG+c9wbqgYZINaYg7640cbAab/JqXKURA0HlKm9WzsZt?=
 =?us-ascii?Q?K474ui/inVfIDo3mh4u4J6JM8eiafKUZx/i+KX0n?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d419e124-aa6b-4096-25f0-08ddd94563b6
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 02:10:20.7139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYRIOXwPAekRL7uyRn/0UVdHTgJMVkpSAtYE05kjyJQ35pn2NdK3rGWYxYoZ4UvVVoIXG4qSkn78gwmdLtOy9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6733

Because the variable *c is not used within the function,
remove it from the ubifs_crc_node function.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 fs/ubifs/io.c    | 4 ++--
 fs/ubifs/ubifs.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ubifs/io.c b/fs/ubifs/io.c
index a79f229df475..e0dfe6827d65 100644
--- a/fs/ubifs/io.c
+++ b/fs/ubifs/io.c
@@ -395,7 +395,7 @@ void ubifs_init_node(struct ubifs_info *c, void *node, int len, int pad)
 	}
 }
 
-void ubifs_crc_node(struct ubifs_info *c, void *node, int len)
+void ubifs_crc_node(void *node, int len)
 {
 	struct ubifs_ch *ch = node;
 	uint32_t crc;
@@ -432,7 +432,7 @@ int ubifs_prepare_node_hmac(struct ubifs_info *c, void *node, int len,
 			return err;
 	}
 
-	ubifs_crc_node(c, node, len);
+	ubifs_crc_node(node, len);
 
 	return 0;
 }
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 5db45c9e26ee..5d172509091a 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -1743,7 +1743,7 @@ int ubifs_write_node_hmac(struct ubifs_info *c, void *buf, int len, int lnum,
 int ubifs_check_node(const struct ubifs_info *c, const void *buf, int len,
 		     int lnum, int offs, int quiet, int must_chk_crc);
 void ubifs_init_node(struct ubifs_info *c, void *buf, int len, int pad);
-void ubifs_crc_node(struct ubifs_info *c, void *buf, int len);
+void ubifs_crc_node(void *buf, int len);
 void ubifs_prepare_node(struct ubifs_info *c, void *buf, int len, int pad);
 int ubifs_prepare_node_hmac(struct ubifs_info *c, void *node, int len,
 			    int hmac_offs, int pad);
-- 
2.34.1


