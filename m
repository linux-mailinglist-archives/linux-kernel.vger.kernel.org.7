Return-Path: <linux-kernel+bounces-762069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 904DEB201CD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015AB1707E9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFE42DC32C;
	Mon, 11 Aug 2025 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="e1HfR56k"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013009.outbound.protection.outlook.com [40.107.44.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81432DC32A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754900754; cv=fail; b=MO5dIeoon39f9Kvaa7D6/M1e8YfEgLUSyGWpWhubAo4ivW+BWz6ZFs4F9UimD8ryBLv7rrtwBbaN8YQ8NEMUTLjT/JWTlpzWC6mWQgmhRBQv4GxioY1IPKlWjIwLewSMNw2PF9wdBw8l1bhwUnLACxGW+nj/fYtiyoAxdHPn1PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754900754; c=relaxed/simple;
	bh=WhJLSyEo4SN4pT6VYO97pFLFNnPSP+R49UyyUb2ik58=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Q218Nvpqi301RXesbodvPxhXFzD3euHxowXzqIBHinpQ2CliocIj2zgLb+dPq6UN8PHQXAFhg4N5ONk+i70R0tWX6BGTz+ADAaOhJu5uboB8pyJiVL5mxaWaObcOELxdxJOrmynebReVpmYsmpIEqOiAVSSigE9xeoyJwXUDuV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=e1HfR56k; arc=fail smtp.client-ip=40.107.44.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPfD9fBPiVQ69QhZgIDXpSzmPI9KxUeQ8PwYMe4suwG8P9qXOU6zbtQXRmfw/Vin1ZT+VpQ1YLSyO2OoTxlXz57spqkWrGpeQkY1Nu9HxkmlJhtvQ8dmB9NfzcrHPugPY583dIm3ajxkA7eThh03pTXkhBghhjwuJNbJ0Nj8ZW2Vjp3U9oXChrdeJwm98GhNIFHVaIbXdJGpxYQO1ez9hhyOckRmDlB10WK9guIjiRar3fAUsVrBG7Nf6WHzIP/NeRkQptk4I8yhDqNp4xjIsoEjeeVVg3rSpMeqVnHGQypjw77mIQNq1TZxB3915NpKt7385UPTh+bXCwZTcVPixA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsA+DesLyO00s4NQNWCnKt3KDInZStXAb27C/VXosIU=;
 b=VeF2q4ZTw4hmehXeMBx8JuN6wt2u0wfQazkWk53Ny+YF4kmWvyz4R2TuQkNZSa2pZyxVIpyQO10DDXhEhSRSvlu5ptlpglatCkc0uORwW4HMDlM+lQpu0lWpWzit5zMMMnVQbwZM5vWOc3dOs9QaY1tg9MvY1WNkepbu/0/I82MIxR00+1zORMSoMREEmLYrCR01DbvTaBxta6uwmoyiFb56oMDqGfnTRsctwwzwx6fVvM5O0AwbmDVp3VkIVaAILT+BWWD4ojdoZ1v92hk6MELRokcc1K3yTSf1fCKrImQDbR03hh/5jN1aMuLwKUvilV9P4G63KBUa7KfZ/IxXFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsA+DesLyO00s4NQNWCnKt3KDInZStXAb27C/VXosIU=;
 b=e1HfR56kQroy+peZyoZ3XWo6/e5j+rydnUTjCv7F6JAidHnfclv3t4kw2GRWcpCJ3Km2QZG+nYes3a1fRIeKL4rfZovttX4Wytpe1D+F8XWtGucRWOLzpTp/zapz6GWbhvKXRQKL4n7US8KuPAbC3AKenXgBqRfKbfqewFZ09aVdBZzpEN8NsuPEX0/vVBxpitOuV/IlbuYs6W57TZu8DYU4b+unIFU9U/YQXXOizDmmwmfpPIUQ6YWVHoD6yERrfIwPPSj1b/WUWIb2AzG4j0czOZtKQ/599GB+C6Cj9QBw4f6lZD6kR8vGREpLZaP+PnB7F5xkPzleyaIEC3ABgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TY2PPF6D4CDC018.apcprd06.prod.outlook.com (2603:1096:408::794) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Mon, 11 Aug
 2025 08:25:48 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 08:25:48 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	linux-kernel@vger.kernel.org (open list:MAILBOX ARM MHUv3),
	linux-arm-kernel@lists.infradead.org (moderated list:MAILBOX ARM MHUv3)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] mailbox: arm_mhuv3: Remove no_free_ptr() to maintain the original form of the pointer
Date: Mon, 11 Aug 2025 16:25:36 +0800
Message-Id: <20250811082536.377896-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TY2PPF6D4CDC018:EE_
X-MS-Office365-Filtering-Correlation-Id: 09388970-b610-4e53-2fe4-08ddd8b0acb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nqtc74vsw0cAkhZhGEFGYryUs6s2nmMcvTzTWi3oNXOFYpo92DzXg30V25Vk?=
 =?us-ascii?Q?RMuTR8OHg+7ucf18RopXGGy21LHbgqKaHxegbYJysqvO6T5OxJCXaMbXvDgj?=
 =?us-ascii?Q?0C4b6YDclny9FdofG4P1s1VMgFZK2S7UbAxkO10BoIwECUZ2EfFCnkrG5Xyc?=
 =?us-ascii?Q?9Qv/e+i5kYuhSAm7E+Dsx9YYcXSw7liJzFG6jD3p3+rQQXpiA9/0Rea6h8x4?=
 =?us-ascii?Q?E/rQ7sMFWEwNiZlhED1/9hpbUhKKyVPr6JiqfE7sQYAjsUzSxTWs2d3BYAKX?=
 =?us-ascii?Q?6ylhVyz34bRiIEZS2uECDB7r48uqz6n3rYL4lb3u/XdxIyCtSmcZM6SQDMsx?=
 =?us-ascii?Q?9FW5Ld51ouRerSLsLcZnU0lTg+Gn42tMxiVfW8sOZn0nX6X+pV7api0FKFoI?=
 =?us-ascii?Q?PidXggTPOUJFYVY3cUflzW12lhwIo3ur4KaLJ+kChLFBoLoeDitdaPz/nJkO?=
 =?us-ascii?Q?Ifdp7brRJCa/q+Fz4aPiNpVA/kXvaz3ObpiP1BG9Jh83R3vaAdReABroSABo?=
 =?us-ascii?Q?L7s4f80oK90ckJSXzLyEm9DHktDvgazH25iVkwFL0Dbz7JLB95QxpA/gJGLY?=
 =?us-ascii?Q?b8IS+zSQb9siz5qxxAliHPyFkK62w8XXmNvBITmbaK9BVPmdK4at0dFHwCfI?=
 =?us-ascii?Q?wwDPEa6cnOAH0wHtFrZx24TADdETMYATF/NqSgEfbToGPSQT9w32Us38uHDm?=
 =?us-ascii?Q?XfbVi/wzn7zqNVdry/RgOqK7z2AmHzzl+Ry3m048bjjxMaUcVppNYeUc5Wk/?=
 =?us-ascii?Q?u4AedqLPQCOx8jlxpnJnpJuJ0PeFDG2LN4pT1nldGUzbwY8UAgB5fWckTEwY?=
 =?us-ascii?Q?rxFPrBDYwNEdqDKpd0RBTbSbVXeKHQz00JYhI1Q+WvKwxX3+b0sbJVdF46ve?=
 =?us-ascii?Q?n7K9whP50lfol1kuaVkOe2jxfMcrODPquhOP+hKpQsRe/kuzaWZpY0mbeciO?=
 =?us-ascii?Q?aLLou1MCCvSlLqfpPIAlBLHM3Bu2LCaOxxywVsKVr+6flrYwTBHVoAu0UfZz?=
 =?us-ascii?Q?zJ5q5B9r8I6VFG+D6lOiYtnALkoVygZItwKFAglsHGvY9b/MLEbyA4v4Bd7f?=
 =?us-ascii?Q?IviQwiu+Xcv82H63YwemU2YA/jvguw8H7QqoUAjFfjrR/myyzD1sfLdCdII5?=
 =?us-ascii?Q?lE5Ic3hz4o4wQny7roV3vzex4YlW2wJOobFNDCYIcaDxfrC8j7B9m6t+Y2Wf?=
 =?us-ascii?Q?wu6orq0neHzKTaYaTHyblLnKtLw+F1l+pDlaG7//BOhOImhszws6m8DNK2Oz?=
 =?us-ascii?Q?9U8o5ZQVHuD7VpNGnq+T1KRx43a7QX8J7YQ5PrqJXiqUpi3jpCLTJ9DmYh08?=
 =?us-ascii?Q?GKJOvgeUQLmVxcb2dJwi2wIjFCOUqDbZn7nUXZFj3H5pKiX2taM4st8fRE/+?=
 =?us-ascii?Q?o935ko3OHzhUQQmQr1omfkZFHsMJthhyLlIeFcnI9HlNaUmhiD6phgmS6oCo?=
 =?us-ascii?Q?KpLQFLZgJa+hbA27gN7y7a7ZY/y7O696ocClELw4bAV5ofdBGvF4ow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O8T+2LAQy45iwcJcgDPSFtHqSC4+GWIUL/M2WCQP36M3xZEx3Xg6vjmVFUQI?=
 =?us-ascii?Q?z3HeHW2gMlifWIDW1XRLcZHnclRz27xXyxvCQHQLuJwFs9Pj8INg3U1vh7Gx?=
 =?us-ascii?Q?YxCmVhaXCiTdnlePFZhu7tVq8iNI/kOOHLeYb8wC/ljd21MkSNRVd7oolKb8?=
 =?us-ascii?Q?n6Ex13Q1YtQkspaj4kqSInseJLSeO54q7aDyZYZWKU74MQDSbbHoMulyc9hr?=
 =?us-ascii?Q?wshMgcRDIrViKrXgKwokgAeh8fk+JRXPLCCuIa8nK2ObLp5LiHWtRfUZlzQo?=
 =?us-ascii?Q?6kyRjN8lk21JqxSFEiMSakFLfflme9dcjTnBD/ZoB9pnrh1d0J4OsohMgDDq?=
 =?us-ascii?Q?rLh8RUnupc6/ISHWEfiici/JQ0I2KHXaq67AoVU/YUD7gzNQPcZWnPeJG2/f?=
 =?us-ascii?Q?ucUnC8IwBbtssS3GAtbEFRl5ha0yd4SDF7a9eGUmCmLxPJFRNt7h3SIeCpdS?=
 =?us-ascii?Q?74lbCv8BC3u34qvaVx4td+h/pwcT0pKfpMefSMH8Q1nou4ox5za2cfRo2Ydq?=
 =?us-ascii?Q?nh3+myrytntUqAmgJJIpSxVD0lcIv4oKxWDMi99wvwnpr6ny4+A2dkeqatFK?=
 =?us-ascii?Q?/XFypP/3iq0zaNZt1cdnXLKGADZf+Ga7ufcPVIG3mibjF5XCye4w/KbK0STO?=
 =?us-ascii?Q?jawMjTSFngiKoSfhEOjgSVnpMVIeIHRoz5A2SLG3bTyD62QuyymiO/cOsAT0?=
 =?us-ascii?Q?GOPlQ7lfBWBwzHEHGuGrKq8tbsgxnnaDv9YTORJ+OeLtR0VVQVr+Eu2qdyue?=
 =?us-ascii?Q?laSElf/q7mOSf2NBxpTfFB7WCi2m6flOavQEb/9/WWgZ3uMSJRxITZ89EjPu?=
 =?us-ascii?Q?pqRlxoOqWkPSJUvF+zrGoO7bSIcFZi2lDh9sa+p4hIsSjn68YUrCAci1xqzM?=
 =?us-ascii?Q?mYnqsD9UYkr5b3Dtl0MWAl5J17xMtzO/xQcZTkWo8Pmf8zAcWVat6RYctBxW?=
 =?us-ascii?Q?z62jBTh7lBfKNvIfR3s2bBUcRm6udbZFaIrxS0zWzoUVn2v+5hBj6NqzPz5w?=
 =?us-ascii?Q?d2flBRrVI/lhTWC/oihjObHpjtlgWBDg60k7qbcOsQ5/WqIn/LVztmJEwPZA?=
 =?us-ascii?Q?A21sGybVI5IZxIb29mjxuAXA/YsJGXBYyAOqcj8JDLUMBo7dNQYPI6+N+43z?=
 =?us-ascii?Q?xnk+b9UWujxGdKOx5QvK7XeIS98HJSfBi4oV6wVS1EqZk3+meyGi0iyACX0I?=
 =?us-ascii?Q?qV5pSN4gBinrmg7i7SHaMPHDTKkLgrHx8VfkoRun3eq+V9M6BFgF1cFe942K?=
 =?us-ascii?Q?BN0l7fyUbPMngHMVofza0nIIKq6Yu/4vYxRSZLSUehSX4QqTHtxIwRLLmMrI?=
 =?us-ascii?Q?U7YjavQU8bz59/LvK81oGIrjN1oc6Z4Hkyi+5ZAXX+ukrPL3bgTDl5AlYQrE?=
 =?us-ascii?Q?ml9lL8OEthyVm+BKWraerszxAP8BulMoL2Ehmse/IefAQ/0zv4QCd+VVzIjk?=
 =?us-ascii?Q?esn8y/xzJyOCLgt5d4E0bnvabqwRWiEAbmcma1wQ8v7qNmhQxzbVrRBGEp/I?=
 =?us-ascii?Q?E0Yrp5KmYKMHgDgx0b2tZ5phNOyrDFOiUeakqJg7ywoSjaAMUxIZ8qMsEJVj?=
 =?us-ascii?Q?3bvt6L07y7WgviSjlGdnERm8cNEapYW23h/vPGIA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09388970-b610-4e53-2fe4-08ddd8b0acb2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 08:25:48.2005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aja/UV1tHqWXUl607nv6DP1UbeDvORcESjZMA4b9rOU0BuvSG3XOOmxhCjgIlzZ8GiQi/Ipx/dg7DOjhvPrH8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF6D4CDC018

Remove no_free_ptr() to ensure PTR_ERR() consistently retrieves the correct
error code.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/mailbox/arm_mhuv3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/arm_mhuv3.c b/drivers/mailbox/arm_mhuv3.c
index b97e79a5870f..0910da67f8a1 100644
--- a/drivers/mailbox/arm_mhuv3.c
+++ b/drivers/mailbox/arm_mhuv3.c
@@ -945,7 +945,7 @@ static irqreturn_t mhuv3_mbx_comb_interrupt(int irq, void *arg)
 			if (IS_ERR(data)) {
 				dev_err(dev,
 					"Failed to read in-band data. err:%ld\n",
-					PTR_ERR(no_free_ptr(data)));
+					PTR_ERR(data));
 				goto rx_ack;
 			}
 		}
-- 
2.34.1


