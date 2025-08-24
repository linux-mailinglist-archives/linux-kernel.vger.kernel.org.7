Return-Path: <linux-kernel+bounces-783654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C45B33040
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 15:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C15444F48
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 13:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361FB2DCF73;
	Sun, 24 Aug 2025 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RSoDJRBu"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013006.outbound.protection.outlook.com [52.101.127.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69AA2DC329;
	Sun, 24 Aug 2025 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756043752; cv=fail; b=t3Ootp73KpLfI72JJ1imqeVR6ngaKqhPKvz0uQKbJjFf7DA5BxWcXPWzI6BpTYtJBZwUrfeMlx8a/K7sorOycEV0euFJroXhYcl8ZTpaaNpoikQMHE2sIKuj0S0uAk2Ez0Dy+9eEfop7Lcdn2sHbkDzwBQVUJp8SrTXrEyp7pHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756043752; c=relaxed/simple;
	bh=I59yzZVTbY85P6cgPybgLeC7PKQwNkescPFzT4CLmYM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d6JBoE2Wla/QBb45xxBBy7G9RzfKx7fj1rqGqr5UKglKFuXF6KUu/SojvACNlc1gKmTPvBB5TBSiwA0m7bt4AKNOV5zM7+myBdgxUfChTcNjT4NRr5Uq2psft6NZbhF9bbC3YSplOE0KDqVhtKcPV1NrP0VjPaBRMggZ1Smz8F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RSoDJRBu; arc=fail smtp.client-ip=52.101.127.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2xzljADqPumEcMU3oCiGn7SVVXB/O8+fQlSojRMOVzQd6MSZonMn68ZKFy7+BQj1kBnUBpJQ3LJ26FH62+BaeAD6O+Vs7TAxRLKVhd0fkguHmNQJY0nQcuhJlQiOLJ+Se2QI2/4Pigp9TKezdGP3GAE9SSJNpR4QynAi/3UJFJRCnimzICRnJF0ltZc5eYwQeF5+xQUk5GKVGMP/ltJAgR+8xsqWZ54V7VXeWAMQ5yZM1a/AB3btPXJHLkxtikJCNXy5mckjlj3yNi6+eI62/X4FFqHeYtzH1I69OYDwYMF0V+Q0ScgOzSCKpX76kA0mWi8MccqOYJjD6CABCA6mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXDaQYemZ2V35JlhomNkypwqFBuGmINbTUxkq1tD3Pk=;
 b=d1aoNDhwC8SAaB/udCS2g3aly0KWc1X6aRXa5n83nMSIdjK8KM3rxNoqyaz3SsJbekfZ+3mTTloz+MEm3Lv4cM5R8tJgJcGijT/+41F66vw5qgipLizM+h4Iq9WO5UMy78wFp2sjR9hREBz/QrlX5CnDo3SjB8miR/jrycYTHnQL3nt7K1E93u3he5PREqlixSjaOvSvzjG5NkPjqsXPcDt1ewQQSIT5nnPv3lD+bt9BuxslXlPoiQGh4RJdG+dviiAXfCuNhjQU8vsNOuZdrKUqgqOjQCF8oorAPLOQxhmr3Bc/6wm7QIe+JvcGfn38a9PeENFcHF2v8sRBB2Sm0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXDaQYemZ2V35JlhomNkypwqFBuGmINbTUxkq1tD3Pk=;
 b=RSoDJRBuF5gflBL1sqy1Jw90FW7okU1hTIc80iHFALtObdj4ib5XUh9RLmK+S2gIwXU7J2o6k/EUKd3JVXAzjgbFEJ3m9kAWY7gjHdPyk6fuHHFKQLZh9Gqy/tGrVOP6lsz3sK4GLKiU5xCDgdb9uO2Y5CTds8Wr+CTrPoVidZyAn6LPkAkw/MJ++gvxsoFpOxKxIfSj1CK5n4/8RsyrcRtxz2xQ3ehn5qdHlRAQWNFY2aWfs2dJJEOUrluv0KPZYUOd3Y5HimeiLKIMmRSlwhFNxfuzzPg1bqgzy6QKs98RG8dfjfIcpGht93bMUF9xMpZplr7PyHOzCJDqWiFS8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB5685.apcprd06.prod.outlook.com (2603:1096:400:283::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.19; Sun, 24 Aug 2025 13:55:48 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.019; Sun, 24 Aug 2025
 13:55:48 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-sound@vger.kernel.org (open list:SOUND),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] ALSA: maestro3: use vmalloc_array() to simplify code
Date: Sun, 24 Aug 2025 21:55:12 +0800
Message-Id: <20250824135521.590780-4-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250824135521.590780-1-rongqianfeng@vivo.com>
References: <20250824135521.590780-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0113.apcprd02.prod.outlook.com
 (2603:1096:4:92::29) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: b0583df7-9446-4243-ca33-08dde315ee17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1VpGR0ipCypDGX6HsXAYwSUMk+WoRRcmTOJLTg/eFMLOa1Ji5k6LUVdzUqkM?=
 =?us-ascii?Q?vPaESca1jh1Jq3NIepS4Orp9LKcculw2iwavk0JR3xX4bawo7BJM2heJOkQd?=
 =?us-ascii?Q?iW1iGwvf8fA8NwVJbyE7gFHu15/R7gCXrySSP/DL8bL66MUy+Lr4OoCQeK2H?=
 =?us-ascii?Q?evOnFeSKXhQix43kbvHeIF1umOM84qFSnEk81dCJe6jpgCeAWO1OE1qEFfEE?=
 =?us-ascii?Q?yNo0DdHT3o8myD2x8d6k5JesfCER7kbs9H2RtAXZiF08UUVYJyHj98iiCUEA?=
 =?us-ascii?Q?OnZE/QezqruA1dFyqWF9H0mvyj5ivOAaB3zNMHwVPuCkvQf/8nIXps9Bdydt?=
 =?us-ascii?Q?1AyiQLkqyYClljiIae0HroAC3zXDpSWlolkftEKDrmzL7DSvR/LsT/fULvwo?=
 =?us-ascii?Q?UaKnpj0qNSicTTcDb1dQRQxpR4uGq1kcf5XNn4f2I9pm1wqKUWtGTPlF/nBv?=
 =?us-ascii?Q?tCdVkbP1hvLGejsa1NsSko7Z5Pc5apxMJKMuurGA8EDzBQWXD4H6qDjL6r4X?=
 =?us-ascii?Q?c00ltOjpNDitya9P3I7wBtuaEOGIe4M1YSWIK0B3+Wim9SzDm284SqkHVTNX?=
 =?us-ascii?Q?6WsW3PMhRvGiEzmxDFd8pEiKAIRRip+b+zlmDsIjv4ahMbVjgL6TQ67z+4DK?=
 =?us-ascii?Q?KXmz9pwQOl47Rb4prVTfEgvXqZTNbO0d+Ii1l3V7n67JHQB/aVuWZjt1gXM7?=
 =?us-ascii?Q?SB4vTnDKy2WqtIa3grEGnAxkomFirm4nVJUm55bbOkqzZEtmW0W8AfBUqxSB?=
 =?us-ascii?Q?qrvwrxm9De3L+0sOa0OiCErzZWwHFsupjxOupWAlE4QMewYWiXA+Pk0p574e?=
 =?us-ascii?Q?bVlHhseKFrLAF7MFpwephGyOx1LDpVCj74eIdRlBQ1kXTq3VEUmwjpZGm7MY?=
 =?us-ascii?Q?1ahFiYE8OW8GDdxThW2wUMDVgpNBuPd53lR7OyyzsFBIPLtHUfQFlUurC18h?=
 =?us-ascii?Q?DttDcP09wC4horZiw/0yiMX8+fxMAlowI7GurxY2KY3idIPlfo/KYsvguMm1?=
 =?us-ascii?Q?cCf5dm4kWui6TpH+QHcX9fNugxa+vCMMMn9If+eTtY9Wud8S7xTlRYHOinW9?=
 =?us-ascii?Q?a4++StNiKgpYju/MJbJ35HR06H41wrGVx6CxwOsHPxSCDShmMZGLt7p2tEqn?=
 =?us-ascii?Q?Bog8q5naRMymIsLRYM/8B27+7BWD9itEmDOHpSZ4Wye1kM468H72zhh/eSHi?=
 =?us-ascii?Q?m69y1GC5vBHisyvtpEI4ieVzYLksBcXFEtzGhCRVWr6w8pUe8cgzdhenCIn7?=
 =?us-ascii?Q?ssQi0BxOyM8X27a2b8Jep7O2peHWatUUM2hBzt65YFS80eGpAuBjT7ecqwbF?=
 =?us-ascii?Q?FOTvpnoQQu5Y0OcnsmdXZVJQrnUfZOvAzTGzZIQuf/gjMFTv5Q4moSLuD4P8?=
 =?us-ascii?Q?IKBGvO7Cm8fjzAGrPyTbA/e52c62OgAZWVBHP4qqRroaxLuCe1LfEPc9Tbs+?=
 =?us-ascii?Q?6ZHHbNkzYwX9kUyXYhadEuELOOvd2gg4OAbJ5AF06gFeTjC9hZqFdg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c6Y6bTAJRfw+KwEaL07ryQZLX02YCSeHUJpJWAyWuF0xqm1OFtJZ/9glk23X?=
 =?us-ascii?Q?xP1YNcknmFH1rp+i7hMlGJSruOH5g3hlwIm4BAoF1LvU6xD/a8nciTCJ1JZl?=
 =?us-ascii?Q?JrRkPDRwC4I8h15cxNH0binCPgsGEO8GTSysXHyTJSKT1imVwWxwN+RnDfjJ?=
 =?us-ascii?Q?PA3hQ9L4JszQFeGXqFVpBBstUJWs3DDFPK1V5OGUG9G6BJAbODGLYFLHIYGF?=
 =?us-ascii?Q?scybeQVSHNfojvRLfS6cn65lxk98Qaz3YNFWaDYK018+OeczJ9eMcugtHza3?=
 =?us-ascii?Q?RScz5Ay5DE3RPWhzFN4W4yE4+XA0KUQOTRLbGrKhwP2tdopmEyUZw+7IsQxt?=
 =?us-ascii?Q?fj7GKoSECacZiEFvrO1upDsPudDgdEPXOzqOgnCHfDRaWzQL58/XAu/nsp06?=
 =?us-ascii?Q?r4X3w3I03YmdIPE5nDtTxdoKd00WwWPjrwZjOq5cC8uU7gkuJVKyJifJjNb6?=
 =?us-ascii?Q?UnfDk1702+/Y8AMB3eJAT/xrUBdtFATn4lEnAX4VM/h1eHqzMVJULjTHcP8m?=
 =?us-ascii?Q?Hydvf9IcfeuypWzox7R+2HxkyNyctx93fqKVjvf/S06ifYjFBZVMSilMOHjU?=
 =?us-ascii?Q?URbIQRyMFUyVxOdfHpaXwnGmuCnl+CfKBDYdpTPK5Ki8Iv04bxjpWp12sLjj?=
 =?us-ascii?Q?37kt+P3CtNLxj0FZC1FpefNM5HoBjV2fRZK70MJKv/dPcM8nWShyROsblQNO?=
 =?us-ascii?Q?iIXgzlUAm7kWN9EimjOofqJ8hZDsDJzFXsgKaPHDkETlD8Yv150B3D07b+4E?=
 =?us-ascii?Q?wbzajd4EvM7FmqrsEzwx83ifDcuIGj4fKk7bfTvsBXjXwwH0TrzG2SyAKsVM?=
 =?us-ascii?Q?nsifnE9r/DXbcno0elpaDZ7DClQz7qPakez9IFKe9qCkfJ0s6kyP8ccVk3nS?=
 =?us-ascii?Q?drsV7I9koBL+KmqNy+pz1yQy0ePGgiaOkduP8aW0/UwwQvd4eGJAeFnvDITN?=
 =?us-ascii?Q?okmh6gkMCa9QNUaTKaVa4aZZqyjJR8ZH3xdc/9p1qpR3ZGsujvkZd/m8ewOl?=
 =?us-ascii?Q?ehqV5RtCecNfoyhd2G6YfdtWOas9e+GhRnT7HXt7RXEht+j1w9UghSVzqLvk?=
 =?us-ascii?Q?au3EVaSFwPR1QN13NPSatXX6X1aNMbkJi1VXOQ1hi3i4PkDPUKwhVMLmekCo?=
 =?us-ascii?Q?/o7eHkD+Ci3FDIB4jTGt8kX+OdrFk+I/kntXX2XBA2NyCr1RLPozxqKTnwC8?=
 =?us-ascii?Q?ctcManVPl50eGZshOShfadse/UCXjDQjQbytOnmIszhmDWNuEot4E3arqagn?=
 =?us-ascii?Q?A5YliJF9Idd68UDlrGOvMkzsXuAyITAsnZhZN+7aO5ZvPsCk/8DB2GR7a3ZU?=
 =?us-ascii?Q?xjPdeJoMIRh9n9I+j2/zS/AoLu++GFbzbuk4jtUgqFPbqMND4dudCLNlvyt7?=
 =?us-ascii?Q?IJyfXNH0C5HMWFH6nwVyrywzYr8VCCkqR2lJ71+CGPiQsHq8iLmn/GaZFnum?=
 =?us-ascii?Q?IODJII7M2/5GLJGhMBZ9gLoUOpbxQTWIIyAz0WAxaiuijakJInXmjtmTbG4p?=
 =?us-ascii?Q?JX0MY00VBfBDKrP/133gr41nelymdp1lNQK6uQ/uhQOW4XCBXl28eNFrGpeb?=
 =?us-ascii?Q?dbGDMHsLjbdFkdeXPIZqMOfasMe6lLLrza3nLjjN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0583df7-9446-4243-ca33-08dde315ee17
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 13:55:48.6419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pt3w4qWoeWiQW9KhIiFxpxrQPVsouWC+vCWEQabnmpjijLKlVGMnJ7kU4klDeTfg7IpWiCUB+ZDAffdaZeE0Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5685

Remove array_size() calls and replace vmalloc() with vmalloc_array() in
snd_m3_create() to simplify the code.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 sound/pci/maestro3.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index e092097599ff..0170b432402b 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -2580,9 +2580,8 @@ snd_m3_create(struct snd_card *card, struct pci_dev *pci,
 
 	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
 		chip->suspend_mem =
-			vmalloc(array_size(sizeof(u16),
-					   REV_B_CODE_MEMORY_LENGTH +
-					   REV_B_DATA_MEMORY_LENGTH));
+			vmalloc_array(REV_B_CODE_MEMORY_LENGTH +
+				      REV_B_DATA_MEMORY_LENGTH, sizeof(u16));
 		if (!chip->suspend_mem)
 			dev_warn(card->dev, "can't allocate apm buffer\n");
 	}
-- 
2.34.1


