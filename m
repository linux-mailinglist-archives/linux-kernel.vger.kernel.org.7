Return-Path: <linux-kernel+bounces-766388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B16B7B24606
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E2F1BC3B12
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C322F7457;
	Wed, 13 Aug 2025 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="VUXJIYS1"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013030.outbound.protection.outlook.com [40.107.44.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C457021256D;
	Wed, 13 Aug 2025 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078102; cv=fail; b=M+5mXgHazC+Igld7/jbmPqkWfCsQW5OKvA/7KPhdTVpmH2qHphUXaNHYIuHpSHDMbTKp7v5tJRbgttgAIkj+gjE7Y0ehQTOwvIT6f8Dg9CdwBgRaoZdJi9nWj2G5+RaI4a8+gQxK7y4JWtAXYhlmUQAUelu35/o4PA3dkpnFQj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078102; c=relaxed/simple;
	bh=05Aepkqd5nMrYcB2pvLRAkFt3wEtA2yAKIO962nthkI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KRcFKPnumstvuwpVdnEKSyqQw38p4y424ybtnogGqSzbrXztnHK+M2DHM+N1b2u+7tVs2KEPb3nkcAlkqpYVDSr3HFXfamXA1pXuEF6ONLzX38wqI+jDXchmhDdrm6gYx3DyP4vOmOtCMO6xGU8/jQSNKhvOKJpKHdkaNKByq8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=VUXJIYS1; arc=fail smtp.client-ip=40.107.44.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myFiUIdFWF0p5k6EDlRy9HVWiHF2jWJkcn5cJa+N9yl+hQ3VaGpEDjsCPLHYz1KGXNBY9FPBl7vNKcHgfpO/MxPBEaa2jGaHcMyos5+8mKIRJrmxqUB6v5KiaKNKS0x7W2gcBSMXMtDPtk3ajnSxPs4i0egF4RM7yn3Yq04Y1ihNU/grhiLc6nGVnoCNOlvt5IKF2gLTldexBLkzuV0EUVrd7E1PS/O5Nih17TfLTNdeJyRncDHabE5GBmendIz1UfFKSVlzyfcsZbiWh+Bi0ZLw7ZqRMTdC667t4VjpqdWCS13ozX7Km0zs27h9p38tLgzj6ZAFSDqWPSa6cR313A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/uJKLvsWcEocoMAq5OY8WfQe2Awo4Jl8pqs2Qcgjrg=;
 b=Pl0nIbYoBHPuaKVK4HH7+Kw5A/PYPg/GIYC/DWn0L/Lp0fk1V6dtrOr0oHETdXBYAuA09Qi5Pl5+uAOIGTFRKbvc3SIp1EFH8URveyWGyBNKx6WOsSSwoCxzq/qjSycXZZ/jV5WIfmvVsSR/Bw/obJ8e6CXTST5M7TBSqTTeBHPD8WhgQoiBaj8pFKHjK/c5DWp0UtZ8UN0StnCo/vz1ccEygYLny9mI5AfN5ARPQDQRszBW8LuewVSzl/Sl2dzhvUPWDKN4q8ER1QaQYaCwPU8lTtzH15lYxFwkbzNu2EmCjQ/RhavhckVaaf+cN8gzc2Zd78Rm/cW/tU1I3yg3WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/uJKLvsWcEocoMAq5OY8WfQe2Awo4Jl8pqs2Qcgjrg=;
 b=VUXJIYS1kdsQdvh2+EH2omXGJrdDA+0KSaViS47X+jblKAEkt/tIJsQ1ahHNziuoXgkE7tzCmJ6y2NT8QIyie8bnPSVmydMOYNkvcTP7hMc6lSHjyF/VbMHjaPc+05uwaH0jv2kHCLvmyEhtx/Z61BXOA2ljxsZTh8dOmky2ClrNieq/bGtlOzZXUgs0ejmifGQyzixxfoxuHbN+wliA0xGFOrdmlCqveo8sK2E2NS0lYE5PtNFjbTNM9hHCbSoBx3C5P3NczFo8B2F53cPU26hgAQD6I6YZIdS4S8dCshKLn1zITKPNDne9dPwR7pWRml54cip/zpCvagLMEfcQIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYZPR06MB4978.apcprd06.prod.outlook.com (2603:1096:400:1ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 09:41:37 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 09:41:37 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linbit.com (open list:DRBD DRIVER),
	linux-block@vger.kernel.org (open list:BLOCK LAYER),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] drbd: Remove redundant semicolons
Date: Wed, 13 Aug 2025 17:41:24 +0800
Message-Id: <20250813094124.553070-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0266.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::19) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYZPR06MB4978:EE_
X-MS-Office365-Filtering-Correlation-Id: cb40c70f-645b-4ef2-a361-08ddda4d98e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JnrWYVncJyj9bFOKIMJykmiaZsMeX6nINDBfjNJvepAa7AJPpxnpn/ElZ36g?=
 =?us-ascii?Q?4RUpM3odQ7fJCFloEdYmN9ZnrDxKHvwbdcMYhYkTQ0LVNewmaneLnpy8+SsI?=
 =?us-ascii?Q?MY4RIDPwJsfcS/QzJmKx+Yzjh2yE8GqM/ge2i94Gvcdwn8c/N4zlJkkjViuj?=
 =?us-ascii?Q?4gry0nVdxhJX6PT80Y6g21wzzwZtP5Wmui69bwa4Z3EPYrxZ/DDD7O9GkD3+?=
 =?us-ascii?Q?EU/3KNbHIteXhspC/IRzKPrI5yi48BsAk4EQDg40mhel0X9Ld04RiyYfVFPu?=
 =?us-ascii?Q?iqvrmsreeUQL7gqil/RdSkOnMH8QxekAf2vAgXXCsIj7RaBdaV1/ZvxBF3vf?=
 =?us-ascii?Q?nofSy1x3pYEo8tjIDOYvtduZIiVuTVUMEyJ9a5wsvRhtlPtxNJAOXSl2VEMg?=
 =?us-ascii?Q?UbL5NwkHivMnUEnQA20mMeorbuEDaXOwgeo0JTFSz946lBydoffA4/XSyLa3?=
 =?us-ascii?Q?6o/1BUnxCvtpsfjlLEc5yjgr6VXrzGOrjjKcJ2cYgjGHt4Co9vhD3gZYWzLH?=
 =?us-ascii?Q?pE1RE8cM+JJWvLRKmnaP1LMPlJnzeUE8xzQWjSCYjGh+KfyzGBHmXfPI5pyY?=
 =?us-ascii?Q?9aehkpujBnYMOIQQblvaldZiBzm5uEI7LOykRAqmJo332+iJiXqmiXwTq789?=
 =?us-ascii?Q?qQUTM9VqIK+sLCcHM7jF1zfgoKRwoymP37hzJmCESxIF+hSgrAfCRmJpwkR2?=
 =?us-ascii?Q?9UwC43w3Dgm3/6fcDECJsGIw8XqzGVoYH1sLj1Tqp3dlAOa71Yx85sEoYvKE?=
 =?us-ascii?Q?wf162+H8J0XlYonb3L7G9/m3PbUxySkmeSV8fvB3FOb7pjvDDqJMz0eZ7M/M?=
 =?us-ascii?Q?cMoZVK8FtLghM8LF2pdslmSOX0aGsF0u1NM0ivrBLyCR+xg8xbKTSHiAcBpH?=
 =?us-ascii?Q?HyjIvA30fMcOkfK0ix8rU2vZD9abwyXG+WNxB6OJuJQJmhzWzfgnIwqyZpV7?=
 =?us-ascii?Q?0lT5irdkQMfINurMo+xVN7afNubR5ObJcb6S/EcS4DgG3Xrlo0Kb7Chqnlcv?=
 =?us-ascii?Q?S8H68GZ15QPSVtlzPVFAU73MOGAiD5gcJkq0IjSvsDZUO4XRRjMeljmhhjwY?=
 =?us-ascii?Q?kRWbOXxdcv76hO2q4PFgbF8pC3wF98IyMtnJKpuRHB7vK0SgvvNg8ySkv0qV?=
 =?us-ascii?Q?EVhUbHXY3k9SNIzdJTxlhEIanqB7HGCU3rwy7sS/PN2XX3c3C6t/WhIfEBzE?=
 =?us-ascii?Q?YajfRCQR2bcE5o9bZXBUiwkADGwrgcchORdQ/6RFZvHb5Cn3YMXE7H2ph3SD?=
 =?us-ascii?Q?WU3ql1Lqbeh742kOuPINX3eXW/sSAd/DlTgZY2D0kfvrAVj73HWbrLO68j53?=
 =?us-ascii?Q?t2pfHVoM5Kv1U1m2iQqgJxJoCrz+ZCO6wkHRr7nZvGi7HeT/x/gsoJgD1OSZ?=
 =?us-ascii?Q?yHakLBdYBFtYOK/MJpL4Hr6WexJJ9vcmqVCuiF71torXPYg7thqunwbBGwn+?=
 =?us-ascii?Q?FxSvfOs4RGNDJ8U7qOwNLcecuEwUu1cUf/FUZ8rVAcLJFNeIUdaJKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7S2+IB+CKjp+iM1/2BrInl1juUj9ObnTWmjxVGRv3kztGbdyimiIzdoyCAqY?=
 =?us-ascii?Q?+8Qbmft9HPxj5hg1qwt2kFKdoCqs9/aNOGqYgsxNkzmJdCrBGJy9TvMSV7Aj?=
 =?us-ascii?Q?wNsFmo+72rfV+brhpm2RBIDWObRbFqDed/775NM1oFo7GJjQ+ZiJpXCq8+Vc?=
 =?us-ascii?Q?EnIDaIle9fSmoymd+TSAR1VdnFcwufRMGE2aXDRXs+wqoNRqWQ5zf9LdqjrX?=
 =?us-ascii?Q?T6UQfZobtU12lF+aJnGHHklbGrMPw2cblSJ5SkUYa1qVV2NAWktitbW/7Fuv?=
 =?us-ascii?Q?TfwTHucczf/jaVha8QUSfvMvD1UuoxGEbdPbXdS8zPGob5GmYIPYCDSHOtv9?=
 =?us-ascii?Q?tv0bZiQDVfGzDCgMe6IQ1yBMG+Rltp0aVHtqHe+uoTRKHWro36J3truct7kR?=
 =?us-ascii?Q?8BZWEwKutIpj6VIg2drR1OucGcY4KmJQ4YknGWfq+lLKb3awY1PHwIGRpuXn?=
 =?us-ascii?Q?qaio/mEmLToSOceybuZ4KOiS+eTaUK49axWWx1kjmJp6SjFwFp1CQAV87v9W?=
 =?us-ascii?Q?ieU3ttjNXTAu9vtWcFjf/IxyXsnw0Ym3ZqM6Lcb5GLK4TmW7lg8z6n3h15Bj?=
 =?us-ascii?Q?8cThb4IL0THcxf3zDmg639zCvHqohUkdzASIN6x8OEars7eMvW84/MUcW+wQ?=
 =?us-ascii?Q?QbA2DmQKcjQtTEkA3J9CimJEyw+Mdfh8kr+U5T6XbE0a7jUVj/L2Gtf/Gbk4?=
 =?us-ascii?Q?6QRGrRm917TgDPh0sT3DmKe/+sECrU+ssdMXVhMHV9AfqPut39Nwm4lplfJJ?=
 =?us-ascii?Q?b4rZpXXDsx57BHuwh9AZL00U+L3XgARAdnmokzCKVSksgL82i3p7WgrE5Kna?=
 =?us-ascii?Q?dgZsoKcgItR3fKp1LtOAJig0bZGSV0B0GxADvSduXjsu5tNP7qINVawDdQVT?=
 =?us-ascii?Q?sRt5KO5RNolN6aCiP7iq1YXS7H/P2g65nvTUe4y9/5sOAffl9pHoLVg2QAak?=
 =?us-ascii?Q?LimPpPd2v4YPWuPP16SB8ntchqp8OHccdw2eo/8lEZot4XiYBquIacxfiJgg?=
 =?us-ascii?Q?BVszBVQVKJjmSf6UcfioLfNzBN8CZD5G24e6OBhsHd1mb0xsxcvcCj+YVJua?=
 =?us-ascii?Q?U0EQg8+EHBukMipXqnidHOKT6HNZiV6davMScorcj8wzGboKABLQF6kcnB2Y?=
 =?us-ascii?Q?s2Iulqi9d8fttHWNxDX5zjhxK0wmJZ6KSR7zcyoPM04KNGIUtfBHw/EpqkQQ?=
 =?us-ascii?Q?gCJqygeEoEBTNxm4xL5B6QUD4TGSl7YyEHo5ko0dNXdOoe0a9ruf/xmvSOdO?=
 =?us-ascii?Q?vAQ/EmkF3rLu2F1pctIMjJCB66+0AhBxiciDJFlNSC+a5jdA98VbW7qObVdy?=
 =?us-ascii?Q?wDz7pbWJMBb/GkTHuW/Z3D/VoHJ/MIEsirEPykaLGW0QyOpUURslRqN2/nmn?=
 =?us-ascii?Q?wSURp9/5GGJF6xMr2PnwdbLBZlhwwxeiOY3Ck+p4SD34+FGeo4JxhcAjXw5m?=
 =?us-ascii?Q?cLjTh3yFkDwLBSoJQMSc+YozbLfDjVO1CYfrw4/w2E5wm4Je1tufD3ccNO/a?=
 =?us-ascii?Q?rcv/NjT+aVYNikaYafyJ6S9bn6eclSaUaT8o56dfOtrtU8TX/YpEl2vP29PG?=
 =?us-ascii?Q?geprymvRG5Gh3V27k5DBg+/Mf5pYX4cGFttgjdoS?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb40c70f-645b-4ef2-a361-08ddda4d98e3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 09:41:37.1120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCqJvRiltpvtBNEvv6rX842UwbeykMxEeHLNdJSDi1VTYQZ9BJOmuq7yH/mQ/1YEeEFiO0Gs/h9UoA95FrXxYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4978

Remove unnecessary semicolons.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/block/drbd/drbd_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index c2b6c4d9729d..6616334d3813 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -2274,7 +2274,7 @@ conn_set_state(struct drbd_connection *connection, union drbd_state mask, union
 static enum drbd_state_rv
 _conn_rq_cond(struct drbd_connection *connection, union drbd_state mask, union drbd_state val)
 {
-	enum drbd_state_rv err, rv = SS_UNKNOWN_ERROR; /* continue waiting */;
+	enum drbd_state_rv err, rv = SS_UNKNOWN_ERROR; /* continue waiting */
 
 	if (test_and_clear_bit(CONN_WD_ST_CHG_OKAY, &connection->flags))
 		rv = SS_CW_SUCCESS;
-- 
2.34.1


