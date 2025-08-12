Return-Path: <linux-kernel+bounces-764341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDE6B221D1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CDD72037C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5A72E2844;
	Tue, 12 Aug 2025 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dArGwRlo"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013054.outbound.protection.outlook.com [52.101.127.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FA61C3C08
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988061; cv=fail; b=doqaNmL4GjvgslZPc4+WIAAUPDdVEKnHBeJ90DXSQCrh/F8NSOxE+j2Y6fCVOUT2jjojN+W/HxMfwfqSgaCmET24Iw+a9jhApRbcAicmgamlr/Dlhk/8s6z/hZuizP1Wg2aUfK0nLluGFMytwtY/13uVn4WgNezFi0gwxqDW8EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988061; c=relaxed/simple;
	bh=yUH9nQg8rguW9rnlDyr8SsnJlyLRxRn3fShBpyt4B5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Xdc9DzG3r9K2kpN04jXck+hEIav9wI52qGkmqD80dNKombLlr7WQn7ox5kmGAMYMl3ZWQUaiCN1IUz/op/B/un5gbtVafn3vqyBmfKnP+AU6H2hdRJ2GmTPoLm/J/MKmz9uxjsadC1NsQ+/w83aUPF8fmfWSlVqbNzI4hDK9Rjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dArGwRlo; arc=fail smtp.client-ip=52.101.127.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHwK076fttx8meh6dRz+dATnBq6MC2COH8EZu4Vbk9Zwa7tR7UWYSyvMshU/u4IEtb+yk/mGINlWp2iRmQ2qqpCnYLU/jryQ/AJRxAMj712abB9Ns9q3UCD+O4fNeGKxbPh1+68/758Tehtyw1UhpqULUy8JG9i+LXuBQwuEIVwmjtBSYOKdg4YFORnUOjJXsBoE+5Z4LuL9/TaFfT/m4XUvMtIVGi+EwWojBvWPDpLQfU2NL6DmEAHVih8tMCZ8/AQjmFX7TLSG0c1sv78xDgnXTfE7vUJpVfnVhUpOKr9GWv/khhY/X/rwyvkOngEX5CHHXd0iL5Gu4C6x46CSgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7Za4PHZHVgusGV7xNCP/zvs+9Lb2X6l4tf7m6uNhR8=;
 b=nFqWvZTeR+ONEorH4wWl63YVBvKcoU+FDnfvrP0ci04+xSEXXPp/4xml0jwX5/ZChxlpB6vZkvq7xF7htWuXPF0D31g5+dmO2A9u/I+nppHTsyA5MNtTvBgHW3QqQvUkgJA9Q/wCzqMgXXBfm/u0yBFjLLWT0tymgUkkapursd55h2AoccbJz+LBzZq4i6oFOwOmv5V1qIiQsqvcQ3HkOKgs4R3DC+JfaV4X8XwEWB1sMUFgCfSK+oYWBno6suGPMmSffOnCCYnzmMXVwb26gMfBWWUPgPdoUTtuUcyruz2KksuJkIa7PzU8z+8OcT5BZ002ELtwmcpLwVOl29B4KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7Za4PHZHVgusGV7xNCP/zvs+9Lb2X6l4tf7m6uNhR8=;
 b=dArGwRlojsAEYbZ+7O0H23jzMAWNt3HdwHZ5WblqoNMC1Oy1FGQzlMU9Z91KNucVmgnG1+Negtu740XzDysSr0y0ZNVOW9fQ+ThlIUL31L4oavsD4pnOZngkrlCmU5hZIuCem7EdNNIefFuTMZkmxH9eHJwbN/9u06cSHR0YJgetfFve6KXrtI0Bt1wWhKFj6qqZ76OP4PN8kTLvGVmdsvoAO0tqT2K7Mi9L+wEKnwC2Iq1hJyBa2z6FKbqx4jHVOMUjTxaVxK3M0wvMJckgIYaRQqDeC8hR3iK/kAELdj5UzGDVwa0YJwsUHpjvY6pjcrAW+dqLepDgvjisNjfE4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by KL1PR0601MB5822.apcprd06.prod.outlook.com (2603:1096:820:b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 08:40:56 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 08:40:56 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] lib: use PTR_ERR_OR_ZERO() to simplify code
Date: Tue, 12 Aug 2025 16:40:45 +0800
Message-Id: <20250812084045.64218-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0126.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::18) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|KL1PR0601MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 46675dde-057c-4869-f6c8-08ddd97bf43c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?60NE3u3M7qa20qSYDqrngdObRGGr+wX9UFiPNljNU6H3keBgcmg9jw9CcDc2?=
 =?us-ascii?Q?7OKoXnb1ujRB93Fk7T0lyZK3AV0Csl5loyq3k6uKB1mF/1buI36RihEy0iPs?=
 =?us-ascii?Q?vmbVFr8JsazqOi9o8bm91qxZqWiEPRJM3nGgKrKf5w0zPOnKCPFm3c4dysj/?=
 =?us-ascii?Q?YmlyyBTZi9S2+AL0wK8NQUsF1IFKUQq8lC3nzHxsnTQhmkH007Rqgjuzn0xl?=
 =?us-ascii?Q?/rhNNgy8TjczGJennfriYlBc7Eoa94R965iwBkLeX2zrAD+UPt1i5A7wITd9?=
 =?us-ascii?Q?0N9HEZmI6Wb2i6PZ2ipnbbuXMAZ+QuJGWa2znrgPrgSQoV0FEyAnqBhu1qxC?=
 =?us-ascii?Q?vULRhV7InABkiAVT1ipYkoQYrPXc1h8ZiHaqWNEkLEiNlQ4uHTmwyrXb0qcp?=
 =?us-ascii?Q?Bp06+Sl8s9iMQYDbdvJHCvwS1m5VMywpqtwnNygpohQTwfSUGUf0lecFVdl1?=
 =?us-ascii?Q?WikOxCXkZV6jc7FZkSrK8fFChj1PVKW+IM9hc99sMaZU3v/bgOj8/WNPh5XD?=
 =?us-ascii?Q?8+xdKbYgk/I9DxDYPw10pnfo7zpbWEIVjYnE6wwZWWfdnscVmmvmnGhhhu2C?=
 =?us-ascii?Q?3N1qPybOYXEK92yJyIoReNp0YaZ/b+gwLD7Ks+3AG9l3fU/ZkWDoeZIenHU6?=
 =?us-ascii?Q?ctqe/heNDG9cFnhb+tFVNC3nIlJrGxdLlS5v3BjFNYbFND2Ryp+oXvVCvhrZ?=
 =?us-ascii?Q?J/O+6EBLBvg3yLSvC5dG8ENquKBYSXoOd6r3Xyzow1u5OneDsLX2J+m7TjNg?=
 =?us-ascii?Q?4+aUmYb8y4BYEyrbkc3xqbfVXT27KYAc1rR7CLjAz3MrgQ3kQSJz8x8RjUH2?=
 =?us-ascii?Q?vMSxHr64LGpOFGtnc5Cim04ONVFR6x3ct+lCVr/R5q6ls7e0kblzlF2k1O12?=
 =?us-ascii?Q?hC73Oee8mUEQJwKFEBaurIp8E2uz4fnSVNvKtve4M/Gw+NFHLfa5XBgHLNjj?=
 =?us-ascii?Q?Sria3oRXqIQcZcqxrGntuh0tXiJy0XWz/Mh0uTRvZQlD8jXKz545R8ki+oZE?=
 =?us-ascii?Q?rLRNUFWjUwzgGiekM9gN6CryQ+1SrsVX24ivaiAaACCXDbMVa/acRfkwjj5G?=
 =?us-ascii?Q?Rm3GF/J9pMBqgGSbo9sgrja3gYoHYsvWp6bJi9+EPfrGPrhtCGt3PUSTDuUG?=
 =?us-ascii?Q?V0sp+0zXJ46BYckFx/orqEz1u+W2hHUBmVhToJTM42DLJAXEIM17LZCVE4a5?=
 =?us-ascii?Q?2vF4GOHX1P/kKFlslwZO0yAqBVNny4lS6rs/0z5DIymtTgE1L5bnXwJG1CiL?=
 =?us-ascii?Q?RO/4DDLau60LhMYRKZ95BjYJ34CE11iw2WNwPLR1DvKrP7C5m7if9uS4m7gU?=
 =?us-ascii?Q?KeVKWMcy9VetUTM3WjFvLrvDI8cZsWLzjhoHvWTBGit2x3YrJwX4YXH4R2ej?=
 =?us-ascii?Q?vwWySheEp2JqmXlJVp140FaubwULCHgF7Ku+GsGd5W5Ajo70r88LEhlSjsx+?=
 =?us-ascii?Q?f8EcXFAGPqVsYx42cySV0zor4I8pDKELSWOaIcClg+ixohq7Jdvglg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kdHeqWb3Tezuxsb6TyOfHGSz58mMalI3vrUZSIEuoTT7ISH1mdsiEAArtXqt?=
 =?us-ascii?Q?fAMfaeaHoDR4KtoaGt0nGhaLrMXZhs2KWGiEKse3t4z9iEYHLsn4ZbtlzqKT?=
 =?us-ascii?Q?GmWUak4+PdTgEJX7Y/0IOCc4uyz7GWKAS+pjHTK+Mgcns1HuWb4vQa/lDrun?=
 =?us-ascii?Q?nyMqK/uJrv3yIYPgmEdBZieaB8EyLqXqRAPHtMMptocGLIVyCjX/HEVFFRgi?=
 =?us-ascii?Q?uOSGuhLbardffGeIO7kfCMuoap2RSiFh8CydNB3/GWb7JeBxiI2u29cCu07R?=
 =?us-ascii?Q?ConDgolyJF7BS4huF94Er34Kxd1rC6RIaQ71dLIJm8o51SEWu7QlVQWFvTu3?=
 =?us-ascii?Q?qffsgVg2iHRyH0xv6zcNkpQpOKkr2wax9rg9ya6H8AzGP5rpUYAHfsg/3xDv?=
 =?us-ascii?Q?QAhq3FbzmwgOI3mArdoZpkE8Uh5gUNz/QezfAGoE4ES5BBwSlhPTxSxrpkGe?=
 =?us-ascii?Q?bsUAiQCgwcnX8lpf1TiUQ+lJyIzGkjgGm1QH3O4pE0gTlkUNidpM18PQnOwB?=
 =?us-ascii?Q?LsoRxOtpxJX+73apYZkZWhcM6UexZiwYHy3zFFATXHPko0lCf37+Om/RXm+y?=
 =?us-ascii?Q?SAzTyZAYwB7GM61pdii+DkUW5gsNuThPcuxS0Ja0c2dHVFE3C4+VnTVur8S7?=
 =?us-ascii?Q?i9FbBHcD9ixwurPtOCkr9KAVTrxRL8hkujjliZ0SlxWOEe90rA+PpqMx4DDJ?=
 =?us-ascii?Q?dfQ2FT+w4y4I1lN31hiL5VVGgjZRvNqcoOdUp5UiCxnK+/E+Z42+BT8u+zvK?=
 =?us-ascii?Q?19ZgI+hg9Lz598BcK5hCu05Lm0BSRcckYW3XLP3LayCBXnCt55tq+BFPcLmP?=
 =?us-ascii?Q?axpByOyOGObwoHvZ7HT+wc+gk3NquuTIYSLe182SrCU3ybgUrBlNMkilOUBi?=
 =?us-ascii?Q?uErwzFtwj3CNtM0n/aNbfHQ+LvzHbfMrPHVJPTRNJ4fwOvJdQWy0Pf9Sk2bH?=
 =?us-ascii?Q?3cdEjqBiPo/fiVDY0whMQsm8a1LOwq+Q6FNymTKOk1H/8tPMhTfaRAXhf820?=
 =?us-ascii?Q?Ld38ZPSECt1hn97H+0Zo9EiyNX/KK3D/lotT2S6hmm90jTDBTf16fEFa87Fm?=
 =?us-ascii?Q?cy2RRFlNfM31XmGt+m8xbxqVH/PG5WLTSMvGXfUTgZ0ffKEZBRaWDu3w4Yry?=
 =?us-ascii?Q?ivK32hRywJT6tOmX6jVQWcgHxgNeoiz61B/R6YRp13w/PShkULo+5UtfoysM?=
 =?us-ascii?Q?pjOiB/1qgUNgWtW9R4SEAJnzJbgSEZhLc10qhB5ZvWlbIoCogn+RPF3Cav3H?=
 =?us-ascii?Q?Q31vkHee9psnFPFNL78eEaBfZg4gA7ErwO1/oACDp14yVNwcJnLJTVX/4bW2?=
 =?us-ascii?Q?g83+do7z599+ovo9+bdozgfW7ye1NYuK+By1DLdHMDooZF5fA+QLAIA9CwV/?=
 =?us-ascii?Q?uT4LQLThjtPI9iAvOO6814aRfe/KZe88AK/FBsf/qWCnIIC4QqemnkEsZjfk?=
 =?us-ascii?Q?JA2nJCqKeIBbwJzCjbTP9MeXObz+uCL1dUimi4vDWbOxGo/eAmOZHjiizG55?=
 =?us-ascii?Q?bdpBG1/OQJb6oACCnUHCdqbq75Da5pnXKpPZkCd+XAg2IhLUOS5Osz2UWV/r?=
 =?us-ascii?Q?ZvPQr2aEhPzDoXmsyaftsNtB6etFZBENk67KT49o?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46675dde-057c-4869-f6c8-08ddd97bf43c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 08:40:56.0650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LkvrCUrCcDqUqTODpgDe122C6E6eY9nLzRn539l2sL6jpE1vRlC0FLyArQwQmEulmntB3jQeaPBR1DpfUeZGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5822

Use the standard error pointer macro to shorten the code and simplify.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 lib/fault-inject-usercopy.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/fault-inject-usercopy.c b/lib/fault-inject-usercopy.c
index 77558b6c29ca..75403ec50f49 100644
--- a/lib/fault-inject-usercopy.c
+++ b/lib/fault-inject-usercopy.c
@@ -22,10 +22,8 @@ static int __init fail_usercopy_debugfs(void)
 
 	dir = fault_create_debugfs_attr("fail_usercopy", NULL,
 					&fail_usercopy.attr);
-	if (IS_ERR(dir))
-		return PTR_ERR(dir);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(dir);
 }
 
 late_initcall(fail_usercopy_debugfs);
-- 
2.34.1


