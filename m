Return-Path: <linux-kernel+bounces-876032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B81B8C1A6DE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E75EB3594D1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69636246BB7;
	Wed, 29 Oct 2025 12:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="cTzrLIw1"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012064.outbound.protection.outlook.com [40.93.195.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D80625393C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741090; cv=fail; b=N9ZZ/vf0P6rVEzBWdMqyuYYtnAgM5mcb/OJdquS7suzon94BZZaGKv3+GVkm71KAdH3LaMNuTATL8FcXIQz4aFL7yAy5/ly2jJwHWI/xr8kKASfFdX5VvC31lIvpZqVUSjDY0kZRRgMEfye4GGsTtc3z2FV/rKdTNzkRHxqTZPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741090; c=relaxed/simple;
	bh=cH9IwXKxZwP/E6j90dBWFgRwRqzR/TV+VXhUiTyEK9g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iaeOeP0FSpU6nmGuVJXVXqQAi1yJQmpqo3Vs5qTWKAG78g0InC+g9qmeVqgg9oKWiKIVsuW9cQUJMNPUl24i6x2e95m2N4Q4Bz/wgnN4c9GY5OO+ZjuKCqKFz4IFB4NjmxM9ZMxGUPR0y7GvQ6T/RK0kMaKe9sIPFaiL6oQm14Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=cTzrLIw1; arc=fail smtp.client-ip=40.93.195.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1aZPoNtM4CjZ4W3LNurVNYQpcqgNnKHxdylRCP/SyPvkcJW6aQTZxU42+GPGbICtatPA2Ica131vTvvWBjA3pJ67rtJW7/TDLfI0gzAGPFThKDEaZ7fscfhFxU8ZKzEEvAhMtFWM5LMqDqcCGpxoGRHUU0f95X0eV1uloR+N6JLl+5jbpLO6eW0E1kN48Nhww4NqJ4x5ICJBssXymEyUkDCWB0RnLUGt7BtvN5t/QcqQQKebF9gGWyT6PGiuDP13Z6nUwhMRVlqeOBqe2Ciqgwzi7lsx9jSKQ4GsJfx2/VVnwUI8n8Xq46hU12DOSeP0PrXnfEylxMgULhpQ9QCew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84ZfuVINhDsGQYmc1PjIntLmb1bXCVub+Q8IkaaFPvY=;
 b=mWMEMuUxh/5jGZ6Nj/srJeJC4EBuMPuTVF7KFsRISecxyj1QWctfVe/ft7RKKI50OUFxLWCVSYYO16Daiq6PJX0UW2Nw5UiUyi+6lRp4ySe+9uumd6eqrewiHCTFM4h4tdJ9SkSuUHzV/99ISnDM2IU1Q2dC0dLX3v/bu46FUjA8RvdwozZ9lCilA1pe2iVnB/O2vEwXDvcZSGREOKw+RMnekMjTeren4IShKvKX0c/LMAW6t9y444clcm6+BXIZ6FhdfYYDQQa2z3OLqkSpCzxAa4Oa68q0bcJuLtqRn0q+vEFlaCE/IBc5LoJMUMc4++bXeJttBpjDE1ph5aggtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84ZfuVINhDsGQYmc1PjIntLmb1bXCVub+Q8IkaaFPvY=;
 b=cTzrLIw1gdE1txMZCd4jzD3Sa8FuN3ASPnjZK5RJxazJHQAcA9iO9b4wLLMofznidQQq5sxAxW4auPIJfUrX9/xvXeTzpQPUHpdgnwkyz8H+e5okUETZ1vH+XG8LwmywRv7e6N/tKnJmuj4VMZ+SheLRfN9lJq+W73HJO5/djMBIoTiVdyysfydQLU0MV693T5Lnz8bYGdYRTn6y2qPZ7SnjIu54hHvITK0vPVTBh60cOtfr7k21RtpYmt63hv+T8tyDrOAMqleg9mx/MzBdaFq22ORhFyVIKFUVaG9BhoOu1DJbXx4/avNaK8ubRuNCeyP20MIRld/LEhZ3xYw9RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SA3PR03MB8232.namprd03.prod.outlook.com (2603:10b6:806:45e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Wed, 29 Oct
 2025 12:31:26 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Wed, 29 Oct 2025
 12:31:26 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ang Tien Sung <tiensung.ang@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v2 1/1] firmware: stratix10-svc: fix bug in saving controller data
Date: Wed, 29 Oct 2025 20:31:21 +0800
Message-ID: <b28ba544224536391e3e7e2c1aac9c31b5b01216.1761740742.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1761740742.git.khairul.anuar.romli@altera.com>
References: <cover.1761740742.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0070.prod.exchangelabs.com (2603:10b6:a03:94::47)
 To MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|SA3PR03MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: af18a471-c301-4717-a3ea-08de16e713cf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s/M6ceN5tJfoiJUA2mmO+YbGqd4pKhaysyhBxU9mYB6rrPsHFOIxtdnwLvmx?=
 =?us-ascii?Q?P1FH+3vWX7cc2SKo1M74SnpR/zFhrAVu/sehff2J6P2U6/mzVmh2ezVD0Lbf?=
 =?us-ascii?Q?BmgnmWKeac4inS7mc72wHqHYdWM1kHOcWrdJsoLF8mO1MoZAQNpB/ckmRHXi?=
 =?us-ascii?Q?LRVlXsI6oIYEQw2fxkPPHzIXIKyQmIy1edBwUM67YhxS1HhpHLZpEigxnfFm?=
 =?us-ascii?Q?fJctipKhH7pDSedMqs0iv+NyxV47IptYxH34tnD7K5PviyJ+r1lKCxLHBVU5?=
 =?us-ascii?Q?P+4FGF4F/n960MOIaYfqnmq1ZQaJsdNpEwLnXzbeve9/3FRduuZXk8wpHiei?=
 =?us-ascii?Q?wWdJOQLNsMJ/gJ4NONILqouFQT/p4kl+UP0rSGxXUtjkc7KosM8zuJGgHZfc?=
 =?us-ascii?Q?eYZJRZ3QN5qoDE0Ig6jOWhgsUL2ZpFYMsfIVchcPOrk3uqYQvMft3KrvY4p5?=
 =?us-ascii?Q?XIX63Y7YLDCjxVqDliknpPVMff7Y5+9bwQnoH7lKwx0/IQat1j7foSCOtyAg?=
 =?us-ascii?Q?9VXNh6XwDobGQK381KccsPpnX9KvUviH7GqE2BulV/L836y3mgBblk5lUocm?=
 =?us-ascii?Q?dVBL+rxM6Ugt9bKBpZQMLMpm6qy2hwC/nUuVPWgz8UtEqQkvSp3xbEEVgC6Y?=
 =?us-ascii?Q?49roFvFbOf8PMeB2F/UsBpeoTyszXtHz9vlwGiNhhIBV4Ph9n9Lpy5XloSC5?=
 =?us-ascii?Q?IHiM3nVBrZW2zQ0jXntjfrXO8bP9EfMBQD3flO896Ry+TEFwSsrCnYWJ7Tzt?=
 =?us-ascii?Q?7qYrGvh+FrYnUo0uzO/j379d47R5yMRFWUK9pdoNUThr/oZ8jwyzMI31gPEC?=
 =?us-ascii?Q?UGcUabiLpnblDkmgst6iZK77N7BTi080dFrPRwpcbNIy7PcKDVSd8g6By6Ef?=
 =?us-ascii?Q?TymM6RzjaBYkE0gIguyPSHgF2IAzlzG4OxbU0A8msljbKRBOWa7BHvEyL37s?=
 =?us-ascii?Q?5h7DHFdJ+XsbTfv5UPGdSziNWVuagVu4TW82hZNghh7+L6PxWNecFNROHod2?=
 =?us-ascii?Q?f6a7UkNv0MLuMOfE+wYdE/DIGjaF89qMgyv953WVqIAbDR67Pb4ys19iL7FG?=
 =?us-ascii?Q?rgWrf+M5+finsa9qsBRzPO243ddrvnpjrO1HHb8wl0y0hzOx7KDZaXq/O6Yn?=
 =?us-ascii?Q?S1vc3+Y1xTvIoAI9rq/RrIm8arsmFMdNGg1hdo1quq/hfGENVIs5Adm4kIlK?=
 =?us-ascii?Q?K4kIVx8b4U5tsPEQPRRK+g1KNnbA7rU+6Ay+HhezXT5TNwOa7jDQvFa1VpZj?=
 =?us-ascii?Q?3oNFccjh6dP4a6/Epl3AIR1XCxyce+4Oniuyt6MQvbLmJ9Vt8Tm1PpJA/PdF?=
 =?us-ascii?Q?rs07b2hdpG3uQyQuowCXA331nwoqKk1FSYwDLXilJt5w2afnYxMWta13AYkR?=
 =?us-ascii?Q?1KIiSUjKxnQKrpqN+bz/VwjwtVadLp8na/LaxqXl4VlSlGOooctQGGxkQnLV?=
 =?us-ascii?Q?k8EMgap4e5l5RZCNLxG37ZNt9Y26Jcxn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/H3l3oczyeE8NgLxcuF4825mr1WKiS9qTmVeASIIEgM+q7b5PpJrsmLAshDJ?=
 =?us-ascii?Q?c+CAKXy8hUEK7Dh6gVciDLckYB0GZTMHEUKqnqE+wj4pWivHsWXSgDTQD52O?=
 =?us-ascii?Q?iLbSfQ4DWYfRLzNEOE472hSGhJ4D13uViOd6m4bpAiyQ1EQEmqz5J8PtL58k?=
 =?us-ascii?Q?+/rwfqPYWoZb6vIYJYzzwZ6499RQ2rWLAJOltBVBxq+TuSNHvjoA3wLXEfiN?=
 =?us-ascii?Q?bPJ68TG+2VvauQE8+4YmBO362GdZCoaaCveM3/3B8QmD7af3Bsi4dj4BHiwp?=
 =?us-ascii?Q?g6bjtKfOdddBhk0/dIHJf/odi/EoBSxXgnoFAmg/QzMvxKNQtjQUQPdE9gfN?=
 =?us-ascii?Q?xLNaNwAvkt7/qFTaSgS8xWWsCIIH8bxt3ZUVfYn6SEZNd0ZMIAVh6xFNmC/a?=
 =?us-ascii?Q?7bplKS+fQrPhBx5nfLXLFDEp/sGm0+Kiez6YqKvd1es95CPPaaisRG5ztn9h?=
 =?us-ascii?Q?NIBsyxT3Qy9/GbxonFUuc8BF7Td2G2YyJv9yzlJGXjw+FCKwXWpip5SjJIP5?=
 =?us-ascii?Q?g1s16qvvMww6GeBkwlCANXeLyZKnczfkPzk/VOCkwyYWlMlQgjoWzVDPgH8Y?=
 =?us-ascii?Q?LMip9TAOh2NveuNo7PPVO5Puw0qlIovBeNnz8PM5GNvg52Q0uyWuhn/ITNMa?=
 =?us-ascii?Q?zkQI41Te4bO9AJ6y9Bs6NMjw25M1EI+WlIsOTkHs2InF2dmZQemMPcP6OX4t?=
 =?us-ascii?Q?Q+JxAx4wwpVf2Klw8IVwb3VrKitAXLYW5JHhKWd+fDbyMErgxCLqLXU5FmhJ?=
 =?us-ascii?Q?C0pAKiTKqBOBjgTmapfo3KsH1RAgjxGTAO8IIkrnV2lW1ur99hsh9XzMcphk?=
 =?us-ascii?Q?vWC8mWZWc5sodLw0b+QiaMALD4mSgsLyoPYv+1fcql0qRAi7Gwn6bKTZiUtk?=
 =?us-ascii?Q?9TDjgrhVqGiE1Fq5ZuAxZXB+DOoBqLVaidO4gE+uY9Ao7+TAibS8fWxweHkA?=
 =?us-ascii?Q?unWrxsxkCIygnsMHUIFy4FQqICKq5+VAYGO773CqyxmSon3H6pcMK/oU7aU1?=
 =?us-ascii?Q?tvZStuH79frN+2awnfCuwYiWVd2Gir6kAYKB16ezkP4h9Pj5ud+pQGR/0pf+?=
 =?us-ascii?Q?Up6Re6yqCDavrI+4zqQAib4HfJ+H2B6b/if1qdLCbtVDh3P98N4+QGk5bYfB?=
 =?us-ascii?Q?2H4OM756jmaKvH1FAtV67H9lqpkzIzy8LJvl6L0ZXAu7NyULwlOVUEtY3mfT?=
 =?us-ascii?Q?u7nTlcfiYC38m7zx8CSGuJ8yDlw80/LCHJ4+Ya9gy/g+tx2RbBcPIP+wePXv?=
 =?us-ascii?Q?4qSlwWSk4ty1fQYfk4BuQV1vRdHtAniNJ7oQsDBC3BBzV+vimUbCbPMSBy5a?=
 =?us-ascii?Q?I9WFOAx1S4Ahw6LcYXfZhKkpkQW7toTgdj+hRxuvjQEKWLCwCUJS7rfI0puy?=
 =?us-ascii?Q?9PgPwBzsM+m8NNFsgxXr8oMXShHMtJ6CsilNiAszXfgm+AKSMzT7+CaOTdEJ?=
 =?us-ascii?Q?A4aEqnViCAGzsKNrfPgHrcofcRQvUhfG8VjHv26cjmNIK/7kLAYWpsWcz1GU?=
 =?us-ascii?Q?XRolbECpGTQgcGmCAt50MNRglqjvtwp7Fmq0hvS5vAo/lcwiziQsTFFR9WnM?=
 =?us-ascii?Q?V4MZ/W0S9JCdc8+QTyA82aAgIjbX+l6exL9lZ10IEuXkhSSZ+cRb6NxPL5c7?=
 =?us-ascii?Q?33YueoR2Z+y7wb0z1S85U6I=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af18a471-c301-4717-a3ea-08de16e713cf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 12:31:26.3694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmpoarUcMRgzir1J/GHN+2l9Qp5e6k29xbB61SZUIRY84JrQa51irPfvT5HxidxrquQURt7CXYO2Fgf9BSh4o1YJOtn0C5c7OzB+YJSudfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB8232

Fix the incorrect usage of platform_set_drvdata and dev_set_drvdata. They
both are of the same data and overrides each other. This resulted in the
rmmod of the svc driver to fail and throw a kernel panic for kthread_stop
and fifo free.

Fixes: bf0e5bf68a20 ("firmware: stratix10-svc: extend svc to support new RSU features")
cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Ang Tien Sung <tiensung.ang@altera.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v2:
	- Add CC that was missed in the v1 and original patch from 2023
---
 drivers/firmware/stratix10-svc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 3acfa067c5dd..41f53d1e9d91 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -256,6 +256,7 @@ struct stratix10_async_ctrl {
  * @svc_fifo_lock: protect access to service message data queue
  * @invoke_fn: function to issue secure monitor call or hypervisor call
  * @actrl: async control structure
+ * @svc: manages the list of client svc drivers
  *
  * This struct is used to create communication channels for service clients, to
  * handle secure monitor or hypervisor call.
@@ -273,6 +274,7 @@ struct stratix10_svc_controller {
 	spinlock_t svc_fifo_lock;
 	svc_invoke_fn *invoke_fn;
 	struct stratix10_async_ctrl actrl;
+	struct stratix10_svc *svc;
 };
 
 /**
@@ -1950,6 +1952,7 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto err_free_kfifo;
 	}
+	controller->svc = svc;
 
 	svc->stratix10_svc_rsu = platform_device_alloc(STRATIX10_RSU, 0);
 	if (!svc->stratix10_svc_rsu) {
@@ -1981,8 +1984,6 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_unregister_fcs_dev;
 
-	dev_set_drvdata(dev, svc);
-
 	pr_info("Intel Service Layer Driver Initialized\n");
 
 	return 0;
@@ -2002,8 +2003,8 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 
 static void stratix10_svc_drv_remove(struct platform_device *pdev)
 {
-	struct stratix10_svc *svc = dev_get_drvdata(&pdev->dev);
 	struct stratix10_svc_controller *ctrl = platform_get_drvdata(pdev);
+	struct stratix10_svc *svc = ctrl->svc;
 
 	stratix10_svc_async_exit(ctrl);
 
-- 
2.43.7


