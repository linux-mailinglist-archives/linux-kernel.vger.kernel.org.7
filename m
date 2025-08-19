Return-Path: <linux-kernel+bounces-775000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1955EB2BA25
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359F71BA146B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809F426CE39;
	Tue, 19 Aug 2025 07:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="mryC3xYI"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012065.outbound.protection.outlook.com [52.101.126.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BAC25D209
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755587112; cv=fail; b=A+dNWw1VtcUo9uwbeeM4L+VXy2HZ0f3ofkHTJ/rH7aaBydpAbWaiD4QF3qao8VnK57jqr+aFdy2nf025lYyxpsNJCjduZDT9zWh9IooZyMYd2Yjmyzs4rPhcHZULgK+tbJGxOKEjDe4SHpXwDdoJ9kNoBDkD8oicVqrliEVOpzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755587112; c=relaxed/simple;
	bh=h/7QypmLA6C+wBKjWCe0JuIL1XJd6imhf+lLKWRCurA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JDYQYuhGxpep7ZcTUpphr092OZ7z3MM2DDL0eUSzXaeOFn9vvNfZELrhps00yOP5kw0H99JTlutc9AA92CLytV0rKJuzNtj1TdE26IUvKhSbmKf7R2hU3LQmQJqwdZWjNg66l1D4iP0TYHeKV0gGBybGF1/PaaRSBgs6/6NFUu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=mryC3xYI; arc=fail smtp.client-ip=52.101.126.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWsA3bO9dvtg4ahczCkkY2s4pS4lGDmdxDx53wecvJOwfifFYsfw4ZmYn67w1uQQZ0/wk1Mjo/8cYRm6Jih2BRghjUmfK/bBdav9l8/5UWMqBcCZ0/RI7pHIiNxLzVVvzy8JvZOHNUn048nsurOVziS5i9oXzyfZ8LfzS+1gGEAcK4FniXK95bvfZqw/YCdMEOqkvfyKF0kYdNpTezOtTdM3tpgqEbDCD0JrhHrEAMgkr2ZqxTJC6Unl9ZOTbCI6nwAZMMIQKaluji9pM51RvgpuskaVW763EXBx8q8vcesD9xf/n6hJu45g40yBvGbpNjklsrIGOtgZFxSdTyIqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbBYLID6wJKaQt/PD1oQ5ylMpxjhmhSfLVxlv10nm1A=;
 b=iZKzT54dmqjRRxhFCsPZ7rl5dkk13Lcz/fc+ewzDneeVSfoCL6F7l9mSnrshOBMMo/mwF+7bYF/lzjccg6HM0b/St9GSnQ/g5cbocWL0SCpIjLWsdTZqdptuR6wDwff6wmhFDxc17dBGMNVxRg2z9QZd45Uvt2sqL40B/EmEGic7puKaqCQlSL9pBuqJzeJSjlBHfu1xynNp9x8UxeXqwy8FhcTWY1GPoJ6ROHxBpe47VjyAniDnV5mi5mw3LcJxmfS1x/WkBFqt+awZVfMNAAKTbg/CfXiPctK7VbdSo+Cy1orzZZkuMz/bRmwyej15nIjYfjX7tJeG4oT4BeEkfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbBYLID6wJKaQt/PD1oQ5ylMpxjhmhSfLVxlv10nm1A=;
 b=mryC3xYIVan7at/CmU9c7uPQXpESHNvdDW6nd3uIANhV0JFV0TBiUdZJy89j18v7YtMBU8LlxU0CRjVLdfTchmDrRO4BfRPYeagRehpJ80vzGcVoaMkF2kMjM4Sczank0U6HJaeH1igHcKKGZM3xyc9Rb/CApvdJd1NvM3vV72TMZUM9XEYfmGm9eLTN+vYXj3CrO3Ok08xagmm8jmWRsyGfWjJ4xtckO7VYWtgQX/2CoA+C+x5r3zHS3YVwV2MSciMHgpQ8BK8+UQHJqkWKxNaIx8Yp1ZBjHF7JVBXxo8YEJonznVq/f+Sf+0JQO80WIXIuOGqXDrwcpVt7vDtFDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYZPR06MB6355.apcprd06.prod.outlook.com (2603:1096:400:41d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 07:05:06 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 07:05:06 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: jgg@ziepe.ca,
	leon@kernel.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] lib/test_hmm: drop redundant conversion to bool
Date: Tue, 19 Aug 2025 15:04:57 +0800
Message-Id: <20250819070457.486348-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYZPR06MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: fa5477d0-3d6d-4c37-4fe9-08dddeeeba48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gZyObII/MzefhnYn+RY4a/kwSUhIj1tmV2VfIz1LPKen6cxkvIgCHybIwN8W?=
 =?us-ascii?Q?nVQrauvOMYLOABJggRLEUvqEXLqrW8y8bIObcFIeoORt8j65AYrDEO1lAt9X?=
 =?us-ascii?Q?QEqykb51a3RFspNrygqPNs9EAzwzwxfW/cg7Ltxb7Y0syAw0Yi9Xv1ePpqcV?=
 =?us-ascii?Q?z/gcOdOnPprMhPqmf3hLL7oRnq+h3Ie3i77MtSd2zqpu2tX5WZgmNf0qLhNP?=
 =?us-ascii?Q?A9LMklRy8kMM6m/m+Xx6s3JgvAq5R2Ue3jPhxyZQKEQyEi93mUXyEpq/bezo?=
 =?us-ascii?Q?i5iYEnnOep1yquOHvFaNc6cx0Bhmw/xeQ1VARgwjyl3z9fo3ZeS6Cvc5TPSo?=
 =?us-ascii?Q?UUttQfCjd5GBCaSez7PXvWiSda9E5lqzCBlYjpkGgOjCgnpfkiYbQP87tYTZ?=
 =?us-ascii?Q?zoS3n1N79CyJk8JI88YQFpj3vrsvyMQHgwyS7chZyNwSyD9kgX0tkjhv3l31?=
 =?us-ascii?Q?Asdq3XDHlm89SUqj5ulN7D8UdyHNLQ1MuaiQeknBe0qg9iO4VfKm7R2ZP9hL?=
 =?us-ascii?Q?PutVRbv/4t5SFZaG760zB+2nJsw7gDI7NSX6ZnaCb/7sXu7EW7hnpcIx4vO6?=
 =?us-ascii?Q?x+2C5oE7ayn3FfD3W6cYqEzuf6HdEOqZEbe+ii+qsitrjkrJnutxNoc1hlJ3?=
 =?us-ascii?Q?mIRxLdz/RmPmvzdpiA3Q+HyoWxt3BKlVL12kBMIE/zmUc6NvVf3N6+a4ICf/?=
 =?us-ascii?Q?BK7a4+4hB2YR4WwvsLIeFpBnIvorG0jzmhZn7Y69ABT9ioDtGVVQZdErwGha?=
 =?us-ascii?Q?6+AtAHIlBMerAyT0A4xweh8RCZcWcCEoIy5RmSFjvXjdZojS2txUECyP0swY?=
 =?us-ascii?Q?Slpn50JNju1Vi7M2SSwrM5Wvswedw5jmqP3lzeI8+KII8LbSQaGPijn+BliY?=
 =?us-ascii?Q?A/VGyBIBEK4kmx3wq44tD49ykj+OVT9FEPA+ai8a2c2YcZ3Q3om7gEdewryl?=
 =?us-ascii?Q?Dm6HAPghKOvB+ZApA/Coxtn+45ZmNVEn5qmJQAlUHrrjgGprFElc95o03xoR?=
 =?us-ascii?Q?0EsNwAv0HwlAv/PPB+eSDms4+E34+h/qe1CiBpkjqRR1WFL/yUR0HtpvDLh+?=
 =?us-ascii?Q?qRVh+Pjs2G4piXqu+9QaevOzSQgWTbv1tx8h4/9Gf6HnqbAPpPj6Xl9YRiaP?=
 =?us-ascii?Q?BvCkg2lXmji++JG8O2jAiD9kHb2dwWqfx9qepdV2z3OHqZN5rQgbSeFQPQHO?=
 =?us-ascii?Q?DtC/65aeFxadyfM0GqJgryI5RKnVSm9SKUBjKhjlcNFzesNrj3cMqS/7DeZ0?=
 =?us-ascii?Q?gKsAJYxugEx8MyGHRV5q6FV1FXkQ4XCx58g6FF426LPEV13in0nPBO8FYsZB?=
 =?us-ascii?Q?txVChKn8Pzk1Lg1QreD0K8tjiNA1h/mvD/0PnHCKVOhaqBxZLFdGbTgpxqEG?=
 =?us-ascii?Q?cH3uqbBFu9XXRl5gQXIswcvztoca6C8M/24TnFmECswARPZVL6U9Y3s3Nb2p?=
 =?us-ascii?Q?eL5bmq0J1YdG7Jrqq3k0oLtFtP2XogI+J+15jW3akg6VHqncHnGwPA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W6N/AHH1r570X87IPoyFaAb07xu4r2voAZlnMvBEnREC5BNYdrbTYx/TSjOP?=
 =?us-ascii?Q?z/LAsP8El4Oh2l76U32+u+dRSEmPHd+uEtv3QUTjmPgV2upHCBnUdErC/OSD?=
 =?us-ascii?Q?Ng9URgM6962rsKT4SXWYCuF//ewv4YEVKZ3053vusb/05b7jVmh+EMdEwbPS?=
 =?us-ascii?Q?3QM1qo40mtxEcQzInuOyQEdISyYrX+E02Mm8ixlAuGi2xmo4aT+lPZFVrNwl?=
 =?us-ascii?Q?icH7fkNFR1E3bhw8we+3cijS66lBD4/kG+Db2Er9TnHKZR4odUiSNpKB7dFZ?=
 =?us-ascii?Q?hsh+p9pTC998XgGdEUngQVPT7V8ynIvkrm3oDJAZSPgOPufWcrC9bFf3q/Mo?=
 =?us-ascii?Q?D4ZRRaaHB0hS9ANPu0xitLu1npChUHVonP1d5ZSzcTHuEpnmQNDDY5ECofg/?=
 =?us-ascii?Q?FCul4oB194YrCb3o9eMdObThhwEOeYzlFc58nXN5UNPHUPxD/YzfXyxIbw6H?=
 =?us-ascii?Q?TF9JW0ymiRN7X/ARZ8gXFgj4NAkppmTzjxH2WbFUUmpzp9cCCGG6hJT7MfT4?=
 =?us-ascii?Q?fBZ5xLhQtUcJqbqf4Y2uiKtpL45/CkZ5S2jvlLQwE/WwtN8IGnTd+Ck8+p9e?=
 =?us-ascii?Q?OCYje0NmfiII2zeBqzn5rLxYqQir5blu7qcgCow0RnyjsHWW8N4VaINUZhTg?=
 =?us-ascii?Q?pbhOz2Ot4FkDoeNt28bGy1njRCyR1Ma4FXLFwI+xTG2zRBtmMROeglhqsXa6?=
 =?us-ascii?Q?XL5aV3G53tqlwdYz+RTSA2CQP19uedIQfdW5TjtE2TAwUnFoKTH7Ld7N4owA?=
 =?us-ascii?Q?ssIPWuCqCgR+LUU2odx6At9jYcZYPt15bRG5wriLNwQkKB2ednm4GrbdLA49?=
 =?us-ascii?Q?Foxq/dmnY9DIzbQr+LM4ajy9EiRaZs3SRVnbzmogWdRorYVCvd5gcXGlyibI?=
 =?us-ascii?Q?vimj5cEcQ2oLZL2Cz6MSf19NzFBlxGe8DcRQUTZ1fqd8HizFMC+4HlXwTjeG?=
 =?us-ascii?Q?R73EgVNUPP/uUtmRBKzrg9+v1uHqMA/kCqmAW+5nelX4jk94NFDOFQRJyqyq?=
 =?us-ascii?Q?DxhBoZnPcNLmjom8YNj97pLf2W5j7PhYa56e159/Fe0XvRdjtIhCLSOYujF8?=
 =?us-ascii?Q?UNZ915j7t165P/QZeXQxvVinc3MEXB8t+ICZOl7vqfb+EHp9ZV4svS2SI9K7?=
 =?us-ascii?Q?vcrsLkTiLrat2C5h/orYBfUvDwSGtkFU5rZSfUwFMdXpbBrcGfciq4UGsdwa?=
 =?us-ascii?Q?EyvUGHb5ukzllzeO0HV1YHxe4WnIcB0Y48mCSMIFuUimWcDkJqFoYGr9AUyW?=
 =?us-ascii?Q?PAY2GZgOQAj6ZPUB63HsZKKOOnfdH+o+JNY2iIOUk4ZtkWTudi/iVUAVJsj0?=
 =?us-ascii?Q?uInC8KTXeY7E92A29RYH6F+O/LidmvbKBpk3+4zdVP/7piuF8FaKcMuFJy9+?=
 =?us-ascii?Q?4hv+hS73dqYYWK2DpcwW3Zvs7U6tPRaEdFH7MZiX7IMFrmYc2/rgzA/qXrcM?=
 =?us-ascii?Q?A69/thT5DsYC+t+SQ9rhvjrYXiQnfxwZzgKtSpapVcLSHlevckpaY2DLKTLO?=
 =?us-ascii?Q?RP5JTNzuyeB31klWL7NfV2krAyzTqAJDbpXOsHGR8a9vDl8CBnNwrYzgO58o?=
 =?us-ascii?Q?8cTe2MQxTETHxz77w+QGObV8xQpwk1yCKiLcsFZu?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5477d0-3d6d-4c37-4fe9-08dddeeeba48
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 07:05:06.7771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYVnvq8IbhwQaGawF5/CMWdlba+rRgficoUW287+5jLIAjFCz64LtzAGXznQz7tOzyKYREDDmMDpVHyq1/BviA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6355

The result of integer comparison already evaluates to bool. No need for
explicit conversion.

No functional impact.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 lib/test_hmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 761725bc713c..83e3d8208a54 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -140,7 +140,7 @@ static int dmirror_bounce_init(struct dmirror_bounce *bounce,
 static bool dmirror_is_private_zone(struct dmirror_device *mdevice)
 {
 	return (mdevice->zone_device_type ==
-		HMM_DMIRROR_MEMORY_DEVICE_PRIVATE) ? true : false;
+		HMM_DMIRROR_MEMORY_DEVICE_PRIVATE);
 }
 
 static enum migrate_vma_direction
-- 
2.34.1


