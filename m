Return-Path: <linux-kernel+bounces-787604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72324B3787F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF603BA6D3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F19308F15;
	Wed, 27 Aug 2025 03:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Ali3v9oI"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012005.outbound.protection.outlook.com [52.101.126.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C972A304BDB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756264515; cv=fail; b=V40nJp5EVcbLaoJxc23UC6E8JbTtS6DjmP7S/qpUpctDHvIkkN0dGfQhhdvDsI6V06XoYNjgXJtgA/tZzWd34SAILkd9fmEN2ceuhYazxA3EGzHliStrNHx9mxZFin53Qr/DyATT9Kfpag/ovH9pyPFMfpNWEjJd4CYYPGgekiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756264515; c=relaxed/simple;
	bh=xezOnPUhxVEafxF283/midJjB/hlsDbX0bVJTgbs8dI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VNkl8zBm88wehNE3jTLYZ0IZbdt6lBMImk4aFvAbichuJjMOnkZM+SevbxXmRRbfB8m5mkZW2FMU6KWzxZq5U1qBsm2Zkjmsew4YKUYLSJLFEzs1AlCfTGg5ZVb5AapRKYQVj4vrPynlpvn0joZkKAjt/pPs/7vjTWFA36Go8is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Ali3v9oI; arc=fail smtp.client-ip=52.101.126.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0fe8NPm12Jd7gFeZYnqDj3t69i7ip30+EmQhDCWvAuKsuc0ILK1A/vz/bMb0E+wdy+Z4HNXeYmS7IJVXHyp0NcUttC0uQV9KuYdm3U9FnRvbRsn9CdCFUpSGnkpwiG1a+f5/kd5aX0PSYRiiXYiQVlcdrL8ygmk0TPAyxrbhBwksR6VbBfzlIiPjcn/NCyenZLM1ds6UCMIkqdWglwLo4GLdDPVBi2U8dI3PNE8C5OvXDDLqKJsaikYjbuK1UNMHG0t2pOpHmwdiCdJcQFe44UNNSekoXifaDFmnHIFjrZ9atrWREHt1DrK4xGN1Ca0HSgUUpbT35ih0ZxRD5P9aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWkuU/+b5aFT5zzJmCOh4PQgP6BS3CDukAc7+6RYQO4=;
 b=X2N/sxxvDQazeoXj5YlTxf+XcmVmZ+LkaiX6R0WnYslKijcAIF8jAbzu7bRcmq4jIrHfHp13WzubxLFzmJIlkkbkV/TZMbpB9Z8sBJoWL5U8eU9Ww2QKMZL0JZ1CcTNO5mp1JR7mljkhUW7u5ibIRuneEZB25wtYdOZaeEKI9z1kmgA0VzeNOEQ3yMdAO732eRc3krz/oBUHZliAfCTz0SMX5SjNYpZMBtXsom2iYIqHsMziRkH2xoXtsUl3B3nCVrQTjJ3HtthVN3lll55IlkMad3QuMcbkDsJ5DBBOpIgbs+g5jXGjmS/JG7LUVNaN6BsmC3l+5hF10Ruy8m10sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWkuU/+b5aFT5zzJmCOh4PQgP6BS3CDukAc7+6RYQO4=;
 b=Ali3v9oI8g7C+0xnvMPN0EeFSrcJxCw/75CsdMG4Me92g1yCC2iUOO3vOI52xE+zKVvCQIpHaocR3gHmWv2DLRLjtUDSQGcM8kDfUx1Xe0ea7RJpMQ0PvgYDgo/0GHFa+Efa1+UabLldCBOkaZxXz5IY/t+KTdIUINdYGCEimFVOpNgU/jeoCEjc8Eh61sk7WsiIjiic9szL8f1aPW0ot22Qvvii68bT8QBP8E5RSRn4LMrYoEKrzC3bj4fnsE0P3KAdrzCmvefuBtT5LSeE2fe2ArgtXVAHW21x1r77lCqA0fcthCc2npQfPv6JKSAgBKI3O1MqsnTovtS3YI1Lhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SI2PR06MB5412.apcprd06.prod.outlook.com (2603:1096:4:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 27 Aug
 2025 03:15:10 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 03:15:09 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] staging: rtl8723bs: drop redundant conversion to bool
Date: Wed, 27 Aug 2025 11:15:00 +0800
Message-Id: <20250827031500.91732-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0169.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::25) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SI2PR06MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f4033be-3c63-4d4e-2878-08dde517ed86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5k1OeGx3BtnAdLcwOxK3kF0dmia6IZmXV8YwCaOM3xbguxfbW7NJdFFY9dDW?=
 =?us-ascii?Q?PhEVeoRzkPfip+aZVxMaMZ4StS6JY7eth3LKcWaoo0X7PCO4U8gOdTDmJbGF?=
 =?us-ascii?Q?9hvtej4vU6HNhpg41S2v+0+aftLJPAYiFjxYCR8AsipIdFGxgaStd0/7zQ8C?=
 =?us-ascii?Q?FucWQqEfquWczaWhvzD2e10qyZM7nDjLI87xkzFr0j4UojDlPNb8ooFqLlIK?=
 =?us-ascii?Q?O5ZtCl2kYGDXB52Mx7CePrkdkLW+YorVBfJ3t0IKzJMhsqilTWm3x0jANspk?=
 =?us-ascii?Q?vFmf4989HOlp204nlh4u4AKSV5oLd7SwFG0aka/MzwibGInFJTFVgUqpXwPw?=
 =?us-ascii?Q?rLcm5Uo8PfWASs0eQH4giRBnppbdiK2MnxwK5vTaAqv6BkMTEWTAY0fl9btq?=
 =?us-ascii?Q?jNY5C2lD7XE+GzBuqQsQHs0gCH06UAy4mSttyYuDWZCeJoSXWbEMcaeQnQwu?=
 =?us-ascii?Q?H8he5TXpAsbLz7BcdcIyLO8slLj5z3GwfHrcMes2CApE9OEtJCsp7Wl3d1H4?=
 =?us-ascii?Q?lztJ5XQ90Ibd93yoSmhzOtjP2gDu1vzKbboIGaLoJF1DFupHu6xcai0oL22q?=
 =?us-ascii?Q?QkU9vtLN1VvrkINVQwT8C9A5w4vewNHBMze+HJDyy2C51bzOJkTgm5fy2yNz?=
 =?us-ascii?Q?YeALZ43BNhTWvW7XguW11iSnd0SsvHWIarNBAYM8ghiUc0VrjiqUebiuLZRK?=
 =?us-ascii?Q?Kt44HvNWI3leO2bhIQfXIGhLuDmag1dBH6flj6PW/q44r8Uc3DAju2BK5ZGD?=
 =?us-ascii?Q?9lCeSRsKIB+FrXV543OPlH2AGojz1vxyI+aDUJ1QzOGy/I3UMqS2rfMl56Vy?=
 =?us-ascii?Q?BE7AzMwHaYRssoTq1FTQgYYGxt1RPCrlN2FTT01pwjTANQvyb0hOPhFCSVuP?=
 =?us-ascii?Q?mkHd2MoUYJeyH0oNB+MfTCEFh7oHz5sVdhrPY+GJDI5Nf3JYNIwitQExOe6R?=
 =?us-ascii?Q?ItJAVZH5+Pv3YqI8LZxnoD9+gX+3Mj0rj2+Ee3A99qVbVqOZE5AXEVH3gxiA?=
 =?us-ascii?Q?xh+7MfWU5CHmX6KLUHb0YA68jwM8K0Ow9YJCHOBc+ccFirDtRIAJ7b8dMcyo?=
 =?us-ascii?Q?LWhn+vYqqmrrLgl0jC58mNllXVVYCOpWytI4f9SwJ7iiz1/tTSxNCKbprREK?=
 =?us-ascii?Q?mfFd4HFVq1vzlvlPef+3iTuM1B8rpo3AWNgSZh2u+MEjYh0amr6TILr4n1kl?=
 =?us-ascii?Q?KUrJRYGYkxXjAZ8lblDrdGNRC2/RQK2+RHHQkjeg242N050QDYIkptlp8eGS?=
 =?us-ascii?Q?awEHPv4uACHPKh+lyS7RHmGzbHUTtJpjHJyrbqyj4qYrkY3y76B9c/PrvZAs?=
 =?us-ascii?Q?MboOXpeYkdqY3rrr2oSi5IBx5xELFZe7ZEce/gRY4hx3s+Wc/BojoZ+1DBul?=
 =?us-ascii?Q?ebFr+F0utPKY0ND53yV99mFl7LaMvM6tU1NanJ/Eks4pmV6GGbBcFgU61K7l?=
 =?us-ascii?Q?H/8oyIjJtRceRPZxYGkLDAOJ3dJHAlHc1THfj3MCcR5PbnDHQcYj9w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9JG2GueXLhEIB0smMDIOflnQ4rib1v9acItvskuJTod79BnctWX1GEb/xZR4?=
 =?us-ascii?Q?pHFOcf8lTP7wljcmp5cRdbVrEyavuTQ2cSo/rAgySGSk5i1txMt13LG1Ty9F?=
 =?us-ascii?Q?8Ms2+QJ1sGyv3so6SLCRpStgkQ+omWRsnsGZxOjPvhnDZr0jCLS1YvK6QWDI?=
 =?us-ascii?Q?8uyeMAh+fB9+a5bZIC4GflwqjWwdZYzDh2qOT8azixWenroTiGI4uhZYB125?=
 =?us-ascii?Q?0rB4vbgqUh4hhdXn2dtkqm1t3FjElAKnhJV+n9QuNdx4rqZ6/YhAW5TDlkmc?=
 =?us-ascii?Q?Kq/AZj8ofkg7JjE1IVtYp8nc9WOph+WfYTsVxb+da1bRMR21aa7nIi7W1B8e?=
 =?us-ascii?Q?Q4s1SqeljbDoCle8+pyzHqJ94sNtECqfs38t57D1L5kvifnMCpaRI67SCShn?=
 =?us-ascii?Q?KYo3PSaEzCwUoQvF0yW79txmE1hut2mBhMjFBNGp43wI7JMoLXcNzb09u0a1?=
 =?us-ascii?Q?6K0iPrLIdNItb9V73CTG9i55Oy0rOn7+MZV8XPFp76EleZi2BDclYtcE3F/h?=
 =?us-ascii?Q?27PfbKsFjXBdAE8OlMiYwZEHPF12F0AcC/MrTULE6hKGuvAp6GJVEBbsYclk?=
 =?us-ascii?Q?j/neQvhWq8uyhjeYXhCVXy+z+P8tid8m3xz9UDojEE7Z3ClOrVM+qoxFxhwx?=
 =?us-ascii?Q?qgPfAmiKEsBDOWYRgQiSMj5WOJN2pJl3R8yizNWFR9Pbt4qL9Rgws9Sw89te?=
 =?us-ascii?Q?nZzMS1kmb7ApqT6lbKadFcguXpj1imNQNRmeqom3ZvEFt7i9LY4XIyWGFKdO?=
 =?us-ascii?Q?SDtW+sBBeOPdvj4glrbUL9efWQV6G6EbFL82oprlvPRwRueJ9dI3oCLk/047?=
 =?us-ascii?Q?gM9P8rXsWablig3UXPu18lv1yga4C7ZfPR7nGM9tCBuMdPGJvsuHpVhJqO6b?=
 =?us-ascii?Q?kj86NQy8mt+66IeIgKnOGWCKy0a61OG0w4pMZBUcuLleQbmkehe0/8YqEB0l?=
 =?us-ascii?Q?KQgBg8qlvulRG0lIn5XHyXU93XLirsPueguHq6P3HOZa7p8H55IoOtUR8CYi?=
 =?us-ascii?Q?2zel9gaglWu2ED2WOnFFZkOTsoj0JFT/aGFEZMeRcDCwxiKiU2GCWGuBZssm?=
 =?us-ascii?Q?jP94g39tq1OQk4HcdHk5vo1SvTA1ElnH9F+AVFLMlgW6H+a6S4pryp3jL4t0?=
 =?us-ascii?Q?u2laMrB52VZA6Orn5DEO7z1rLcNdCuk6DfSZHJ0OvitgxZXdHQpq2q0or9MS?=
 =?us-ascii?Q?x8USC+SWGik45rb9hJYb6p7XusYy14t6naiDDeFM4nqsz3691MDdHZWne7ML?=
 =?us-ascii?Q?271uEtNnlwwiYGhADjNiFgMkFEUnnRITVCHEekSqAImVGCKQdHXNBcoCAeEe?=
 =?us-ascii?Q?J3/Sii4VaoUMJ59kSCR3J/vyjooZNwExdoSwTm5c6lzFsQjkms3+V1QIcJ07?=
 =?us-ascii?Q?7LnCFt7MgvMqaJZBl4le2MyYcxuYdGuBjG2elGeLUhwCM26Lg16JI+GxKazV?=
 =?us-ascii?Q?EHzDQYPSdE7jL6Ls/BISozQourZ1A4TfPyTzcszfFOd2WnZ4co+zjgU/8lsM?=
 =?us-ascii?Q?7RnUmmrLZWKjzrlwZdpiKOSkVe9dBreOK37Q7OqXZdJDriwx0qMW95V1AeTY?=
 =?us-ascii?Q?dIMR5eDdrm1GIRWNkPXrA/wQfw6MHpowPEKSi2/H?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4033be-3c63-4d4e-2878-08dde517ed86
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 03:15:09.0808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Nvf0JEraBBzX2D1DRR/+w86a0WLtkCKOzGC2prXMw1qdpRhsQwLXKuMXTYzrhBT009rE8j8kkeTPK8J3obBjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5412

The result of integer comparison already evaluates to bool. No need for
explicit conversion.

No functional impact.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c        | 6 +++---
 drivers/staging/rtl8723bs/os_dep/osdep_service.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 692d0c2b766d..570c99192d3f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1597,7 +1597,7 @@ inline bool rtw_is_scan_deny(struct adapter *adapter)
 {
 	struct mlme_priv *mlmepriv = &adapter->mlmepriv;
 
-	return (atomic_read(&mlmepriv->set_scan_deny) != 0) ? true : false;
+	return (atomic_read(&mlmepriv->set_scan_deny) != 0);
 }
 
 inline void rtw_clear_scan_deny(struct adapter *adapter)
@@ -2136,8 +2136,8 @@ void rtw_ht_use_default_setting(struct adapter *padapter)
 	else
 		phtpriv->bss_coexist = 0;
 
-	phtpriv->sgi_40m = TEST_FLAG(pregistrypriv->short_gi, BIT1) ? true : false;
-	phtpriv->sgi_20m = TEST_FLAG(pregistrypriv->short_gi, BIT0) ? true : false;
+	phtpriv->sgi_40m = TEST_FLAG(pregistrypriv->short_gi, BIT1);
+	phtpriv->sgi_20m = TEST_FLAG(pregistrypriv->short_gi, BIT0);
 
 	/*  LDPC support */
 	rtw_hal_get_def_var(padapter, HAL_DEF_RX_LDPC, (u8 *)&bHwLDPCSupport);
diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index a00f9f0c85c5..509d00321b10 100644
--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -161,7 +161,7 @@ void rtw_buf_update(u8 **buf, u32 *buf_len, u8 *src, u32 src_len)
  */
 inline bool rtw_cbuf_full(struct rtw_cbuf *cbuf)
 {
-	return (cbuf->write == cbuf->read - 1) ? true : false;
+	return (cbuf->write == cbuf->read - 1);
 }
 
 /**
@@ -172,7 +172,7 @@ inline bool rtw_cbuf_full(struct rtw_cbuf *cbuf)
  */
 inline bool rtw_cbuf_empty(struct rtw_cbuf *cbuf)
 {
-	return (cbuf->write == cbuf->read) ? true : false;
+	return (cbuf->write == cbuf->read);
 }
 
 /**
-- 
2.34.1


