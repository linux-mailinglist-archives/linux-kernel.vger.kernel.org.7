Return-Path: <linux-kernel+bounces-807018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3183B49EF3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C254E205E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E4B2417F8;
	Tue,  9 Sep 2025 02:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Ub/zQZVF"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013071.outbound.protection.outlook.com [40.107.44.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6809E2222B7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 02:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757383621; cv=fail; b=J3C4s/FsIYGscxF90bwd+uNVrPN5/VQDsbK82fJ7ZMQJqXkBlL8eo4AQOrEoXW/3ubUOb8wPbB77QiarL/Fllib2Itrq6zuqR2LwneeOcLIURqNXtBYBvwK3nnQvP0CioxGWkcsCpyFb4F6JZ3LpEuETsdgTbtads5lNKjxCBhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757383621; c=relaxed/simple;
	bh=PqZvnyhgNmp72lDF4VckDbFmg0SB4Z8LCwTuU54Ajms=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=W+mBrNzkcLIU5dDLYkjhGtrJ7vVn8jY6V896m+IksWnpKsKs2WHwXXzqplSg4RqMN7j7141M5KJs4OtblGWKAeDS7Nhw50rNEzWOjmT5u8RlPLvNpL90PzcJ8MvSxn0d+IWyh76HmMxLVOGYnVy03LMR9OYTfieRfwCCbS/ZjHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Ub/zQZVF; arc=fail smtp.client-ip=40.107.44.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a84wGMK+c3KZ2x2ZenPXTwQIuITzfc/Twrz1Ste9RtXx9vhi0H5G0IkSEjcc6DMOAraTvEZfKzMptdd7x+vRoH2G4Lf9ziIUBgDSIKVbQFlNM/M+1ouIiqmASbwDPqUG7H62fYaN+oXEYTzmfmZ+yNMIbgMB0zygBOufb9K9/DCsANc8dv8op1O7Lh+n3t2t3PztzvBzHoJHM0dW28ylwPGkqeKXN4cYVFiVy3BNd777rvZvT3qnxbE29UCZpEHJLHF1krYO8NO/rfGLjx0Cnu7Yl2oEfTbTfqj0uWCfU2YIqI3zJLpTjjmy9jU2YT61P5k7SZfdTkLo4cclFuHRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xUSiZXp99MEx+xcqSfBGyHzaKc9+obp9zydLMJa57U=;
 b=TkwpdtZBTlTvAUGMGDOXSgfz0G3OiueivibidXJf2uojuivjy9t6MiN2Howm7wybe2fHtA7vmU1NaTiffsrZI4t7nwsAW8+3XqbtEOwj9RIHeYNepsVyFQDt6AKSpwLCY7SUtfb/MVesCBz2WB8/qn3Xwq57thXIOc9mlRzwXV9Do6QGPIAzuPmnyGM2l8zpJRaf/36XxLafc3FhoMGVYD+qNi8+ztDmeY9fZUuqEmFWOtZv81KqFCzANDXnPkIKAsJ7O81M2w2aYJYQ03IB8oNs2aH/UkTpzFo193bYo0FEpr8kHjv85fpRdBZNtX8u22c5nUecIpWFXhPZ6sAwYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xUSiZXp99MEx+xcqSfBGyHzaKc9+obp9zydLMJa57U=;
 b=Ub/zQZVFU6foZoVTLXBmqIyWj7KjJ4OBajhpI63eXo5TOGflo6o51W5lZrYF2Y5N4TZXKItAsc+SsY6sEk42Y6vyqFsGwdEF2mPLWTPe0OkJi1WAfS7TwCnm9n5UzV7s/sgKp/ONkAn0edvFtOuir2NWJrZoPAHaObBB2ZyZfH5YjvOwJ5qve8k2D7qRny/voTNq9Pbl+0+QaH1lFAF8KcZRS7xQqNY3UNvu8evnS49pUtDVtXp+DW61QwWBPUa6+RZe7SbcbwJrTUJwC2KOe1V4NGrhijLj3ZMCMYqMyvor99DhEy3k2CJjCoVfEVUuQay4Lf5FKOHiCu0MPKsESg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com (2603:1096:820:146::7)
 by TYSPR06MB6766.apcprd06.prod.outlook.com (2603:1096:400:473::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 02:06:54 +0000
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5]) by KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 02:06:54 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com
Cc: richard@nod.at,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] mtd: nand: ecc: fix "writen"->"written"
Date: Tue,  9 Sep 2025 10:06:35 +0800
Message-Id: <20250909020635.381570-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0126.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::6) To KL1PR06MB7330.apcprd06.prod.outlook.com
 (2603:1096:820:146::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7330:EE_|TYSPR06MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: e22ebec3-0bbd-4e78-1a72-08ddef458c39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XSyT23uVdVEJ650ppz02dicdxl3C0jigOIqrU8wo0y8CcZl0ksZ1UskHuf/h?=
 =?us-ascii?Q?Z4KcIAZVAlhpxiFMl9xM74Qr+XQ9nJwgdzNSQF1pIW4ddUvrJI9Zu8eTWwLa?=
 =?us-ascii?Q?7i97yuu6H5mD2ngjveeY5JQfMkOR1wKlGGrF7IXTdy/Cd59YpUxYMfImuAsh?=
 =?us-ascii?Q?4QQgGF/m9ruw3luUCVc8Tg4brcahA+JL8Eel4QKmLMQn1rZC1ni788O7bLtf?=
 =?us-ascii?Q?Tt/xN/IRUTLxlUpXhQumgkakUHkmVDvu0WoJqX+4q51XauvTSk4KjbNwnZgE?=
 =?us-ascii?Q?gdXEYL7XJRcc9bToN9ac3sPJvyS1naNlD/n/YVuK//LVq1UJv7LPJ33BqSwg?=
 =?us-ascii?Q?sdf9ObTJYBZw/+7gt3iOM8twdfBOFUGZZsShneIXz4LIkYlhsvHl1k7l7hZ2?=
 =?us-ascii?Q?wG3TxXB5KAAYyS1Xac4Bu55zpUjXdYuwW3g6JVSEDBI6ZGuAwHUr01bADrAc?=
 =?us-ascii?Q?E1X5u0rirxijPVVC4LHbiujV1cR6eRcV4OtkdeY3dBXhBowxIWukZDIsdhHH?=
 =?us-ascii?Q?oiRhDihUkwIZSHYlZ5plGmyhhHbn7jTySgWMIiG9qLhA9ui9MR61Nc2/vwV8?=
 =?us-ascii?Q?u4x9wMBnTkRzIOFT74XGSG0FCsgj+jLtbd+1XxSbW2ORlatNcA79gNHv6JT3?=
 =?us-ascii?Q?AmAqqqDfIcfHuhVNbcFDIUE3mpsKVXFjrivKynAAteySnxDn22k9cr18+5GO?=
 =?us-ascii?Q?Udip/CIdlcfQnMHP9Ehqd3+6mMtGArbOkFN+B9laRdWqKmhZubzAAxwSSyjl?=
 =?us-ascii?Q?jRzQBcbYQsDZzjmv03S7yyhS+t2o/gQxlFxioIpF26ZnQaiaZOPf7QENq/9e?=
 =?us-ascii?Q?C5OAUbnQ7ZawrM9zNpuUmu8z/Inp7gDbFghctRLVoFfgQeAe/Louq4fRhj8f?=
 =?us-ascii?Q?dIAs+Cz/W1u5CqnIBuKraB3wU5yARscog4AUg6MH1pGaQyv+pa+9AZkQa6Pf?=
 =?us-ascii?Q?sM7M+2PzUO40Q1WkE63A8wOOAXT5h6Yal418TsPaDbptq7kgBHo9BerDS10t?=
 =?us-ascii?Q?4VPLgV4nUqxbJjBKNITVlN9hDWQIZe3qjWh15JFuQbhgVVReajrlVs6+PO6J?=
 =?us-ascii?Q?o1V/1vjKf9fVnoASURdlXvR2X6mGy1b64aCYkFai2ye8vBfQTQDz8ORX+Uzn?=
 =?us-ascii?Q?GklZwUeJB4pGAzDp8XKKdB760X2md/IowvI9vF/7Qqzh56z9MszdGFMhy57s?=
 =?us-ascii?Q?TVHqhSHBHoM4tuQeLB1q+F9KLANMMYrIwrBAqqWsI1B98mUODoVr4FfAdvEy?=
 =?us-ascii?Q?KBGds0ngnGnJsXZbOPaCIzU5YPB/9N4Iy/2mvYPPpZLXKB3tqkJcRsFI/BP2?=
 =?us-ascii?Q?WDkHkPyw316HSYtDnyjifs/wuYK7zePENryRAlkM5gf9iiXI5bHBqiLo+yco?=
 =?us-ascii?Q?BLz283A83ib/zgocbP5t6nBzBCJQXvrABPLOGC+XVa1v2cz1EtT/Fc9R+7KI?=
 =?us-ascii?Q?qqrfi6E7ZDivgiEzNPUmCRhM1OMlAcad0W5mOxH8/Y0TyNF2YWrvGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7330.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7PjXaKrp6dXcdX5GuU/6Zfmq4aYcSs5ex7KZkYYFZQZ71wCYTLdloqhhwDI4?=
 =?us-ascii?Q?3+fNP7IX//opSnSQkvdTAOTx47Y9EpYLShZUYEWQ1g6pssObUnoSwHvuaV+T?=
 =?us-ascii?Q?2z0BCqOFe5ntzSJDukqW+JdaQbXip8MyJjqMX8sflb/SObjHKix0X4gtscRB?=
 =?us-ascii?Q?H85A/F8RFD7OLoIKkt82NyiRaPt1b0IgVaLfnAW3TNh+COmH5iRv5zK6pVq2?=
 =?us-ascii?Q?lS8SyTravlCSY11bv9LgmIbIjl6Md727sbMgne7ejQSz2h3oMYKNXC+zCfr2?=
 =?us-ascii?Q?4NQ4UZZ6vDQyFvVWHAdqV2719Htm0TQjWGVX+PuKX744bSTAbC1E9FYrxV3Q?=
 =?us-ascii?Q?1HuqBe/ZKingFfUWMqjozDKK/2/OhD3Ajk2SLOew2Sr56Yh3XUf0DI3ijNtK?=
 =?us-ascii?Q?MdVMp9moEnq1xtaSeV9dRmF/4Z79qEJoay5LSoE7SdPO+Li8fyo+zVdZUpgu?=
 =?us-ascii?Q?BCv5CflK3DN7dQo53ja0HT45vxHz2pXD3xE3+VWYE9poPD/Z4fRBYm4QK7qF?=
 =?us-ascii?Q?uo87cMjmzkLQJPlpQ5BFQSvYDxCgrUfN3lI7kXH0qN7F0ScoXPMlcfTIdhzv?=
 =?us-ascii?Q?xi2u/EVGKVK+Gv5nojn8m7/WwNuvCEToDWWwWGfMo7fLyKYm1z+aIa/wAnvO?=
 =?us-ascii?Q?5AhZf3DGLnHkETFt+RY7o7crkMeAts9HuOHsJiLhdn5vzbvj414uJFDkZCFJ?=
 =?us-ascii?Q?mvUxNQY1PjNSoNIYV1LqOEwbG1+lN/PGfeqbCzm6DYN+aobvOAsMAzwz3wY1?=
 =?us-ascii?Q?tgFbwqa3GMqOn4volvaeqBSKD8LYXCxxYS/DmCpcThQx3+teVp2MJe6sC2bs?=
 =?us-ascii?Q?LbjCdtnG8rN/sCMBVolSpMQ4PN4hncM7iFbiJCNZbiswUQiFKHxwvTEtZqE9?=
 =?us-ascii?Q?IqWEdiRaMVihQ4T6EUi/kOapC5kaNFL5BJrdjPPvVqZekLT0IHzDKDo9qUde?=
 =?us-ascii?Q?HRpbdFJC3LFkPbvsr4WEvenPCbUwwBYmxAg2R527gTnO4B3qUeiCQKLIOb/y?=
 =?us-ascii?Q?AhgVOwClF0r5NU9BiBT7fKEBCN0RLb65BWJ8VJBiyZcW7lAuMQw5ETtC7eX5?=
 =?us-ascii?Q?F/1HyJxYv5Yaz/B+TJ4ttBAxE85k9SE3+fGEaIazZdHpbF0rdR9YEnERSNmg?=
 =?us-ascii?Q?6XAA5AWH/NV2xj0e9Ky++HCncDfyHMi+EEXNak0eDzRbyvaHK6h/8quKlKuD?=
 =?us-ascii?Q?8e4W0RrvlO1HeS3XGn9MEwNlpXnmAd5A9SixBsRCTng0ZD5/SkkkZami04Ri?=
 =?us-ascii?Q?hawlWh6hVnuHMPj8LvUc+e3FaYDHHVEp0Ta7mxxh3mM+xXxxBtj2XN1OaJ5Y?=
 =?us-ascii?Q?JFsRyh5DJ/mPnpmipbHiF9u3RgEIGejVGzcbDjczJ50y4mGZ38XXJWbnc+IF?=
 =?us-ascii?Q?Dy0EVFN2RIw3eTGPqbLGYApfI/vaoMkPdSOapIbxm+wTe/7SL/8Z174Ectp9?=
 =?us-ascii?Q?QSCU+0lv1CmRSxxl7HS5Z7NnY/MhmTZXtHu1Z0lK+5DlQgCXamHLuEoX1Sgq?=
 =?us-ascii?Q?vxNCe10Cw4vPp929vuBnqHgGyHzZhbeRdUmtHuI56z1vndJN1Jw6AHkImrl1?=
 =?us-ascii?Q?vYvLQc6oPYgWoqmIx8tNiREbG9CPnc2SfHOULNu0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22ebec3-0bbd-4e78-1a72-08ddef458c39
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7330.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 02:06:54.3137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yC0Yydjjuw/CntbiXcMytmVaSYq6qHM5weDyrjGcYA0HZS+rJj/lhVF/A3TrHlxq14yylA8y/McjIdUGGQ147w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6766

Trivial fix to spelling mistake in comment text.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/mtd/nand/ecc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/ecc.c b/drivers/mtd/nand/ecc.c
index 8f996e8d61b8..6ccdff3fc913 100644
--- a/drivers/mtd/nand/ecc.c
+++ b/drivers/mtd/nand/ecc.c
@@ -552,7 +552,7 @@ void nand_ecc_tweak_req(struct nand_ecc_req_tweak_ctx *ctx,
 		memset(tweak->oobbuf.in, 0xFF, ctx->oob_buffer_size);
 	}
 
-	/* Copy the data that must be writen in the bounce buffers, if needed */
+	/* Copy the data that must be written in the bounce buffers, if needed */
 	if (orig->type == NAND_PAGE_WRITE) {
 		if (ctx->bounce_data)
 			memcpy((void *)tweak->databuf.out + orig->dataoffs,
-- 
2.34.1


