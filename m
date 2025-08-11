Return-Path: <linux-kernel+bounces-762071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC969B201D3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9586A7A2350
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A042DBF40;
	Mon, 11 Aug 2025 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="C7fh9CNo"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013012.outbound.protection.outlook.com [40.107.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D971E2307
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754900874; cv=fail; b=j/rEBz58mwa6pgwoGCEQ6ZwoifasIGdk3VMQQ+KDh/9yEP/31/33L1yP2Z5oCeCG517a9rNnsgtHxqRkarhaFdZYY22G/tyBeEYaNE3+uKT37Hpwvf+CJwI0UapP5IBfvCrkvJ68ArOFTNdBsyH6esiMRt+qkxQZ5ErV1iHZeWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754900874; c=relaxed/simple;
	bh=Z8PAB7yjpk7GpZTh26AJMe9wzxd/72S+H+DR7a8s9PE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RmBbgmkMxqu55n/aGYeg3tGIj8QiED2ClMhQkgCoCF0XGJwazjZl95Y3rjlfZ0ODyAmRWHbG5CUhNN60hO3HsRGLP+j0JYbPTqiS8GBhRvET+h6hgnlbs6wSviV8Ho1i3yAjvRSNmxACCylqCr7ZiK6eZeGk5ZrXExKbchhgdu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=C7fh9CNo; arc=fail smtp.client-ip=40.107.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaPozOWTnik89Rq9wwV/GErPCcbEyAmkAnADE9RDXZIs356xlikVhF6FwK9DhJ2v/im5PJeWLEEhZgkKCIWojHRdtKoU95fozATWzA4Us1sOEzpvUgsItkBZ7ndHnhmUUfL6eo5cYMyImQEzf8rIf7jFJTDQBUhhWohW/gaP39FW8MDx1XtLqR79B/4Y3tWnCFo/SZ2eE+SjNAb3AggEJzYaZeXIHuMTkZmzHuMQElyPlkuMEDsBREayMUa/zti4LFKFBvEoK1sy/uDMmjrvUQtyrtmMWTTClWx1MG2BOciKuaBp0n/LOJGT9Io62/5crqWx8COde8TONqwqanDUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBg+5LHXB6d90V7H5yCd1Y0B5gD8AKQ0tAMM6u+Dg98=;
 b=sDAz3rXfK8gFGb38IEqsGnTFb12fDJHsd6VSur8yNX23ISlrXmJ0w73Ex/r59AQcPWEg34uOPpNFq0kiRZT7gNE0+mr6ZdymPSo61H+uD36T+3Zrq5h5+YttbcW0kMprdm5qV6A/D4C89sNG5RU/kAIGWDuj0eq2cGtyE98axfk42vLriEp2a1f646RysmXnuDuCe4Hfllx0PzCZgrr/VqBAkibgtCYoHXgxIo/dcVFk/kDJ0hDIHAJbOTPqoVYCAi8D2lBwhOgr6u1HEoERSjozLg0XSVcqvBK7RF0ZT0JVEKRgyJtMYiMpsSU5Kf95qsN38NtKUUE6i5d1zSI5hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBg+5LHXB6d90V7H5yCd1Y0B5gD8AKQ0tAMM6u+Dg98=;
 b=C7fh9CNoy6KebQ8J2QC3sbkSh7tr6Ecx5AtUIRqv3AZj9oToF3fOA85Y6qaPXVjWK+Vgjhzs9rdy9Z7j7yNoXniO7Rfr+AjLQpUg8xoCJiOC7SK3tQNzIhHEL3ygcFQZGMUKqpc9cA2WuubWxay4LISfpvrVi72sCsQyEwh8ANjJmMhH8gMe6iI3gDxjftcuTl5QPGClUYOPRMwT4y+2CO0W4xjqQDRpUO2SFxLlzqpcOtXhqSViJZKeLH27UevE+/M32hivw9H0/Wch/XPUY6FEJ+VstdC0lu5zLTReNjDxzndIe84lqD12xdbMw5acHEABR2I4Q8OvtBtuJJBDhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYZPR06MB6916.apcprd06.prod.outlook.com (2603:1096:405:42::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 08:27:49 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 08:27:49 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org (open list:LIBRARY CODE)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] lib/digsig: Remove unnecessary memset
Date: Mon, 11 Aug 2025 16:27:38 +0800
Message-Id: <20250811082739.378284-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0278.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::19) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYZPR06MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ce3168-f8cc-4fc3-7d63-08ddd8b0f4ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rPuivf1LHrhuniCjzWG2rfdId6gk23KTwBTFFldeLoewcwpQSbBGXPMCz5NZ?=
 =?us-ascii?Q?E4rqzub/MJgpdlFBZrl1pKyQZYernJ54cps8FRDtP12PF9m/TiRLOQ/U9GXF?=
 =?us-ascii?Q?8Ro/h2nqM1E4Q/gUkflg1O2V+5Lhq8nx/oEXn7a9jvykU2Kh56CPT0YAGLto?=
 =?us-ascii?Q?VlJ07t6v1mMWKMdrXhqqMtOnZRdPae/G1PDQ4uiTjwrxw5UzYUCvfOLUx0Dx?=
 =?us-ascii?Q?nw7oc6aJ6+8ZFJv+1cAQXgrbEG81d6AQaiToj/MLvkkqCRXHFzfzhokx8x55?=
 =?us-ascii?Q?U9P/zF6bDex6rPFO7w3nacHhFkTwpFXLd5WQIRmVQUzKVgWd6f1ec9+pxfzR?=
 =?us-ascii?Q?u1C7myLnlLJCKGg4O8DlRIPZQCzAy2ETgxRVxzRKhQkERNND9cn3jFp32CO+?=
 =?us-ascii?Q?5ipkDEOqjJEF75TIK1wHcNijkDE4Jb8vhZa1xwL2TZ+VoC1BUvHYHAxV6wkr?=
 =?us-ascii?Q?y/kqn3no2P6jdp02QamelnAioQmxtI2gUiq6FaEJ+fl2V6WojLDdr2NA9/Zh?=
 =?us-ascii?Q?s/dZ6It8WMwXGe772xovI6Go5TBgreAaFmY1eh1cL4aTWWOtOXHtd5P6dR7+?=
 =?us-ascii?Q?tj1qcbanhuALSIegQVOiJmQad9/fIl6bnIfYT0LjLwojFYvnOAVz60ZS8og1?=
 =?us-ascii?Q?7huUMJ7Cy7IutGY8b4bJPbXQGXoFYwTeQl38YrQ2bSBN9xqQSNPK0TDMpfmK?=
 =?us-ascii?Q?dO+VUcaxTNZB6TC6Yxct2+p+OMHGY5q4JFOKjqqCcz9Hpy0lSxIMyxH4+JhW?=
 =?us-ascii?Q?zvokY/Qq5BYcvjzsWEWAwZGj5+Dh9uv93ODNybc3+yt80thBUHtdnjh5eAPF?=
 =?us-ascii?Q?QbilcJJMDynQI2Yb2DO0kbDHUduKbO0MAz2hPMcbFAWR+cvfVfm0Av9epBBv?=
 =?us-ascii?Q?CKt5udDd9fXEfWljcctNOiKlEr6lWQvQIxmY8uGvIi4xHtQ+k1EFw+zyAlLc?=
 =?us-ascii?Q?7u9c8mZiPeVuqEPp53EUW6OFOvbsvVRtXe5B6R1simP7Zbmm8VssZgOgpu4k?=
 =?us-ascii?Q?5H5br7hR2/BiiXEM5QnSbA0ANmQQNt8HuFywvYrtq1W7LHPsZCf4UKwpNxQh?=
 =?us-ascii?Q?pXaXL8paB7nkuh3JI5iEyCF8wOP/wH6TNw3Csb8Pe7AXqSEI4NCYYaJxBAeH?=
 =?us-ascii?Q?SEyRfvqM9vR33Mhi1NdgL5FbB7sHpKAoxVvqlWOkZ+B5/BY2vskaYzmNeJKg?=
 =?us-ascii?Q?ZsvMbgE4HJSyQytX+e5wA+tBTEryZmxmWk5cM/P/yx9WHUyyDK/UTyfqZcEY?=
 =?us-ascii?Q?SSG0zKMHSYX5Yx27vtIdyNeIDUGe7jBFT7xiscIwBP/We8JKtAUSLYlvulmV?=
 =?us-ascii?Q?kX+5CzgH5HyQLsLQvC2GKQ4/6vcG6GhNalHhARURoQzqLC/bPiL6HEKw+Czv?=
 =?us-ascii?Q?yk3GSnTz65ogApIr58Tm86LwvNPI3VeBinMuzDjgvmklEoWJHceXSHafhsNP?=
 =?us-ascii?Q?ij3yA3b3Cj4bvjX0GLEi9uZyXLeYnRMRO9sSS1LjzaI6Zv1gIP6z2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?unQY5gE00p41+4CuwxZbGzZV8aXgLIiHjevhVDCObpimh6XoHQPucvaiD/Yf?=
 =?us-ascii?Q?Gi96jnKKIWBpN2v6g9Xq7lJ/eazt03UzIE/Ys00QXt/lkMy0fslM4vAuMeYj?=
 =?us-ascii?Q?cgIfw8sj3y0rWJ5QT9EY/jdeJz/68KBnry8hTZIukAgA74cTo6fmZ0pO0/t2?=
 =?us-ascii?Q?EDLf5RgFPlcWJ4LZWSOzYqiPJUsglNroIvbmpG+ZnRqLyhOLD000sgLzW+8w?=
 =?us-ascii?Q?n9rVs/qDOewMxVge83MQy5UdXclmNVuFIIt/ltQBHoP3NRWaMRFyvSitYxoS?=
 =?us-ascii?Q?DW/Re9SoO75cQlLXhv/G0eQQYI6xEjytcPS5LZ9LIuW+S300x5Z02bEXyycF?=
 =?us-ascii?Q?U6YnL/jyVP7D1menFiSqROwoJCxjwOg4UEaMfCGVuVC/9/oVJXjdtPBED1mP?=
 =?us-ascii?Q?KGH8faiCVGv7iU9DPAQybzANJ9uVtAHSIRbS+e76usyd1u7chR/SYUZbaokk?=
 =?us-ascii?Q?HOYdiLtgG3wSWItpGBOgUwX658RmyVAe1WQblcY89E0beKSscI8xuDXTMbGa?=
 =?us-ascii?Q?BErFmpffIvlnxCfqN50ANlahHXeXSb4eG6/8WHoAOsWgjwsVJLILy6Y5UWJx?=
 =?us-ascii?Q?GsLJig77bmeILJEFnczIgvnS59eX3igZS+aTPuA5Nye3Aip0YXaW8eoTfrEr?=
 =?us-ascii?Q?BI+/MW/SD/+Sfaa70KecSXIr+6o6WECl506087RlgD7WlL++O9GpKzpAai7P?=
 =?us-ascii?Q?5OLLMV5mt473mmlTgqqIM9lEs8mCXF2H/CxGNx0kOETBO1NCMtx9dPN7adkF?=
 =?us-ascii?Q?fjVW6eAKVlBXVA/CuqjCaFrOhiS6xcI8mW5dDSufc7EPGMy9dgbzhpBcKOwe?=
 =?us-ascii?Q?ZzLbusJ0Zsmw0jv7BOfi9iwEYj7Q4Af+Q+NzH6pevFu65jAkCfPVoSnQfsUg?=
 =?us-ascii?Q?Cw2hylvbjunU9k2Ec9j+1dit8dqTmDQtWt7t7y/kWyHO9HnE0qXrRbRethzy?=
 =?us-ascii?Q?7xbt+D0KyTNmnrbZ6JTM5jn6kKFOvIiJgs7NnBcj9n0iVUctEb44ecqJuqBU?=
 =?us-ascii?Q?9Hu66XcIO+x7t9RfsiblIwYVL38xSGaue8FF1kIf8lg7xt6eSRorDFHlAWW3?=
 =?us-ascii?Q?2oAcV/NGXtOmNIQGNc5YN8KdIHI9Tlc2RyaoOQ04PRRT51rrU8Ccs7Fd9lYl?=
 =?us-ascii?Q?EBOS60iHvHqwtP85EOq1SzaYGtukx50By4JZDNMMdXPW5lS1ASFb03FL+PY+?=
 =?us-ascii?Q?C4AAEH/mKmBh/4J3SfXwBqphVt3TIAqN7t5ueQe0pyc4wNP+4DDRHOK/1RE5?=
 =?us-ascii?Q?NF5lVbWogOsjG6sqG8Ah5nrMhdPTexIOSSmfErUKpxoILCkYR1EdzA4yNXOz?=
 =?us-ascii?Q?4cl67GUsNWW76ixTiL6En6t54fI2ysVYMWnYBX0guYpxY7aYI/DUf4ErZkWm?=
 =?us-ascii?Q?JUW1NxMotdKmkf7QKiqHckp9/tr5nC4Kb1r9Gy8U6LGFZEzNHPJsTQlCSycs?=
 =?us-ascii?Q?ulPvFwfF/lEHBdiwlnwZ8hhWvukIPOx7LP+pJXZ/qgV7ep8gE1bbAwu/kpeh?=
 =?us-ascii?Q?KP5iA52RmKME29Kd/oyTWyIBP/jrJtjvExkZekCCTH+7XXG+91ki4h0iOR85?=
 =?us-ascii?Q?NunPGvxQiI+23pj8jbhuWpEDFqzDDtI7/mu8zwy1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ce3168-f8cc-4fc3-7d63-08ddd8b0f4ee
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 08:27:49.3765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opJwP73BeUh3QIbmIo28Se4bl/UaRRdelZ5cGatw05xjiLZLMDL9zR28ZF8jsHc/QCevYIX7TG71Ejnd/YU/xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6916

kzalloc() has already been initialized to full 0 space, there is no need to
use memset() to initialize again.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 lib/digsig.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/digsig.c b/lib/digsig.c
index 04b5e55ed95f..2b36f9cc91e9 100644
--- a/lib/digsig.c
+++ b/lib/digsig.c
@@ -159,7 +159,6 @@ static int digsig_verify_rsa(struct key *key,
 
 	len = mlen;
 	head = len - l;
-	memset(out1, 0, head);
 	memcpy(out1 + head, p, l);
 
 	kfree(p);
-- 
2.34.1


