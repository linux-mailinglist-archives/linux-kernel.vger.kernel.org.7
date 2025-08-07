Return-Path: <linux-kernel+bounces-758843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E422CB1D483
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6058580195
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50C3259CBE;
	Thu,  7 Aug 2025 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="TER6kELK"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013045.outbound.protection.outlook.com [40.107.44.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2D31DD9D3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754557185; cv=fail; b=kepFZ+ptIuAWT7FwSdR/UTpsJuR/DlbCtkpSCeWSbEgH/GXlA405N7WZ591C43nH3UDTL/rC0UA91ouu86FckgIxDvHL/GVkkuc//S6xPhqjyPbBMrGHYu63+papiqwIjg8o8BSNV5cbjr4KlviPl7H1mpzVZcazWKp87KnQmnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754557185; c=relaxed/simple;
	bh=a2z5Ps+fjz8xnUrLHwF2c+MhrYUvLiW4V7AVGSPXm8o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tOCNCYuGnepqWJokE0eNBvo4gfUnncittYM0Of88nkVsZZ3nnVTWdlmvGWVYRDdo9bDPngVwr7b8DNxOclWRyRINdI5EUhORuWYIbpimamItfdZHgdUFm8Ngm3PeKZCKCNnJLkTIpv/Te2tiSfd8kc8c6s0PsAnSqAkIg8wfMXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=TER6kELK; arc=fail smtp.client-ip=40.107.44.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qA9JMg6BWteLAXEQbiIA7gmUJZJyb6ll5qxZ/x39f8wWnizAZDK2640kidS9KOpy70s6lqk1mzf9OPfq46d4+8DHIMeRYHVd2uUH5xxDMZcxlxSnecmiR2WD4PO5miU5crf/zbXp119s3lPhOaACTr6NmtfuRTP5ocilPDCStyhdhv6AeQ3f5uR2KZnUiesne4t9nbuU39Lxb75HxbXyGCUODUEtX/80qlBOn2qPblRjsMVpOptQfggtt8lfLx+rqoqvPTOjGBLzPnv5WtEB2sIHfjzY46No6IQh/qpEnZDNMHPU22+OqNkM8uOctxpkqdVYsf1jfPnHe9ksDPC4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3oRwo1nQwUgTQwYBdItiMEKw8Hu5jHIVnV3xZ/VR/U=;
 b=ac8DvXr+Pll0SoarqrUVOuUJqWLx9eLtiogJEBUjV1B66qupOAWyh55GvQd2xUWCz5qchZUYL/DwupfFtgAomdq84n4QBu0eGaE/KVO7IRdBOlnGHn9U9PXmE6HuQAdbbw0NGcIArKvc4OHmhSuqX2P04ZadIN2BneB0mYPFXeuUdztgutZUo3m38MH4r2V8V5HORSct0msJZexjPA7fiyp4NXl3ZjGPJnANBnBxcbTayBVrekrja27adNPXfTmKqvLz6PQfkZt/VIoBHaQnZ6OiSqIj4s/uVeWtDjNGV2jvzauEKfSh/KVPjsCR0Jp0Rq6N/IiFBA0gmLalDVcjQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3oRwo1nQwUgTQwYBdItiMEKw8Hu5jHIVnV3xZ/VR/U=;
 b=TER6kELKQQ/4upxDbcIfZk9F21+KKWbPek9tC/f0VABR7i/WsZeFvTUy+nKkxbM5OISFkDU9KTOeEqNr8lQP8OfQ8Uh45VdiCm0CZFYqRa1LeJJnKH9qgb/vVkgbKy3HpObjowxRSFb3Ag0gUpgSxCkaShkK6Uz0j/zXG8aRSwGv4XniiN8H9RrpacdMoOqaySFXI0ZQVapqq3N7fbbTVGqIqOIZ6xwN2xkWBwNT1cDGKDv1j8+uYvRAkngCcRE/BjvwyjLG2yvkRIazMoVrYH+MyRbyJ+NgV+MgFoU7HNevb4ap8Qxp17A+A9pluaVD+gl7ON/7D8Xy5uzAKoiWhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by JH0PR06MB6581.apcprd06.prod.outlook.com (2603:1096:990:33::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 08:59:39 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 08:59:39 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: w.d.hubbs@gmail.com,
	chris@the-brannons.com,
	kirk@reisers.ca,
	samuel.thibault@ens-lyon.org
Cc: speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] accessibility: Use str_plural() to simplify the code
Date: Thu,  7 Aug 2025 16:59:30 +0800
Message-Id: <20250807085930.429665-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0110.apcprd02.prod.outlook.com
 (2603:1096:4:92::26) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|JH0PR06MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: 27908cfe-d10c-4cfe-81ee-08ddd590bdb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FIEAugbn/4mUknLGA1l53in0Vf4GdIlfnbi0Vk5DZmuw0EhwVq9ruMa9s8AO?=
 =?us-ascii?Q?DWMjvTEP2bkzK/VjvcyUKdutzxd8gf1APgvln+PPgXAfoCfs5RZ/xr4r2woY?=
 =?us-ascii?Q?M6bZNHHU5T47BWtSjaFalx3t/EJesbRUyxHsW55I3zWP0pdGa1Guy4otyhON?=
 =?us-ascii?Q?I6+xSLpp0O5VeKXpXdg+fsxDefaJRaZreQ4pu7x8xOLEubuVbhTyfrN5o702?=
 =?us-ascii?Q?+0qRkHF3Ddh6tKQwokIWA6pXKyTWQISt4qZse4/Z2b3lMQHPz5wj3zUpJSIi?=
 =?us-ascii?Q?fQY8/fUI9R0jeoKee7PM+H/3DoFI27pb4maI/mqWUOcEvcOQ0EsheZ6SQq0y?=
 =?us-ascii?Q?NkZuMpJ1TJKQQoQxY9RavG4SkXxYkp3p4P7JPIolNmXl2MxZfoQKryfRU8Eh?=
 =?us-ascii?Q?O82pegOnYVB0OEoEKeORHITO5IvjyEwfd29Qy3kkXtg1FDgNuxmn/dtQqALd?=
 =?us-ascii?Q?HK1havg4lVjVBCNfG++vs24NkEp2xEJ01Z+g5/XOe1NWpR1wVM6ICAwHNefZ?=
 =?us-ascii?Q?h+4mKxZz0Zt7EjGhP8BjVgCY4hIAolGB3gTs2Tki73g/VPhK8OQry1bdh/Qu?=
 =?us-ascii?Q?Rw/BYCvF2a5DYo2aQQadsdmwtQmdda75J+5U6dYD+RxbbSfYcKY0ytxDYVLQ?=
 =?us-ascii?Q?EKEaJTguuBEe13d9xAPZpXFf9Wu5cQpXUKzCzMvINB9OZ7sSqaaasyKEzIOL?=
 =?us-ascii?Q?DUg84eMxF7/atf0ujUO9ZJ5N8fsAvsgrQx6Jm14omiZd9zmmko5uFs+cxEn9?=
 =?us-ascii?Q?ZGZ9uXVOOeGPzt39plKLQDE5O8i3n9uC9iZU47cY95AMNmYk7utgZtT7J4Ry?=
 =?us-ascii?Q?9Dp5ViJXiZXV8GBavyqqkKBb4chZs3y3PYdKNkn0NyGZDRKcDnDOzg80uI4y?=
 =?us-ascii?Q?P4CuGwIV6jSWrVt0Xqv+fixloMFKba1uHfd7hjVqVSGx55CGPY3Q2N3UpSK5?=
 =?us-ascii?Q?3LtZw1EUBXAwLa56ZCGnbpijA4Aw9QPpokJDKNx8yDNcLhYpxAC8DI+P6JKb?=
 =?us-ascii?Q?XIO+10ClaHaf7zO9EhAPQWZlOiLpVx8Bxmnd3N+hkGegP0aBs2FUabh6ldji?=
 =?us-ascii?Q?Ch9b0D2K/JYa+UAms/v+nsDV64EeZF6GxDm5J4p5/wg2pWRFdhQ2xbeKl05S?=
 =?us-ascii?Q?puLC8SVF6zgH2gRNJoTu0jAKs+L73mMpa3ltwQ9R6W7Ayy9Jld3BQuaaBiX2?=
 =?us-ascii?Q?d6xDFPaq+f6mt0g3EwCkhcgsvIh4vwOxfo855jAEvoGCEeC5avkMS754e3eV?=
 =?us-ascii?Q?3j8HN6vrg5yB8VbJAk+aBZxL2x3G25zVarMzIZQoUSbPsjNgC+kjsdboncPZ?=
 =?us-ascii?Q?6AYV/5qc8vARl8chUBo6lEwHc7fsx3iG/9nDG7kBL4y+pgBFTKPM8cVYbm0X?=
 =?us-ascii?Q?WzrIOOPVTr6gEq09cQAvvGsi81FHV83dk0u4o/pfXO3wG3aG5Dm2btVgR02d?=
 =?us-ascii?Q?LHMzB1uRAy7gX5TGog+WQrU3SbpFZdJoakhinJlqY7gebWOCHcYVDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TGbQ8yE3JfLZGx0gEz+/e/BlSHoFvQ86Pl6k6zPtQ9+6CVkrv0AQNcvnmMVM?=
 =?us-ascii?Q?2N35No+0nhSiVhuXo8hbupmBcMDlunKVXnxT3GSZ8oNQhSVl/heaK2mrFoqa?=
 =?us-ascii?Q?PdfFN+7QWqOonF/7VBNKawP1NTmcT2Qb8X1dmOFrWXVoPRRczVriS0bMQiWE?=
 =?us-ascii?Q?I0PeqBS8eEGwdefdxJezom49IjCBRHXtBZsr5s38slwMoP+REAoGLY8kr5Ft?=
 =?us-ascii?Q?fnT+2yFeaT1aAinffLBUSje0/kKo6Nl4E2grz6Hauk/ruO0ivtlXb1M4tSl8?=
 =?us-ascii?Q?j47/uU8EZNFKzv/RvNsL5jtEJDq4ePsPf2MfGPeLikOSLGNIKF/J+a6ZHfQA?=
 =?us-ascii?Q?qwgZOfdQwSsLqN1Wz56VP5zcDAAVvS2MVea4A16GfyFBYSoXGpkesFKCdGh3?=
 =?us-ascii?Q?KtKZ34quFHk5lnwuzxt8xRRbD1md1a3Fc8+1UgSZsx7FqJlKUSyPm85uDoy/?=
 =?us-ascii?Q?A7J5WmrJslL2Itf6ypFkMk7dPSul2eSGcBqws26uMYj546hS/uWbDzpDzKeR?=
 =?us-ascii?Q?vSVanMTiMWervPnkGNk2XZESzqe9wCxb3k0VJZIHbej3oYGbYk5k3P1r0e1D?=
 =?us-ascii?Q?JnIdNzaTa+fh+AXEC9z3DdlZUc+7DQqFNMCK6nfsnVKu1xzy+HvvOgFDIGwV?=
 =?us-ascii?Q?Dv2uSarpc2iGmfO6jIMcHDqblfIE7qgr92Wefj6dOj9v02ZpJ8p0jzu7wiwt?=
 =?us-ascii?Q?Yd0YKIfxCEP486brsKm5X9KaZZRN2KvyiW6IJnlzp8J7jYWyLfAb0IPWE8Nh?=
 =?us-ascii?Q?DTPH+TRH8/sSOTK27CQ5AL+qBKOiJQE8sIfGB1EkcIVW1ypD7STiNmQsHq2y?=
 =?us-ascii?Q?aNxiqJYmTfvk+CNT4XShPGxjeWX8dHa+iJV8O3y1i434uPLn+EAkoq1ID6gH?=
 =?us-ascii?Q?mNJ22WOMWpgMf2TLtUrkS24/QiJi692bnmJMHPbkGwjxdYdVIGIPUE3B5K3H?=
 =?us-ascii?Q?3hKdN0TyAxapssKBpcjnLhEcM009dUjTj4e9rV6WH35VCRiNwxsV4aQ6hxD7?=
 =?us-ascii?Q?SULVJd2a0GgQOg0G9ibWDbTTOhwQ2Tm+rNIWxusYKVQhR0YbMPKULkkC8q92?=
 =?us-ascii?Q?W/iGn01QHs+kkXTXrOAp0doixgL1wQolvu0IbICHUxW7Y1icBpoYVNWyLyNX?=
 =?us-ascii?Q?AJ6ncpoYZOBRTQH42RcobocGaWeJGbIVf4wv75e0BXt/MKZb3iPB8lD1JxBz?=
 =?us-ascii?Q?hjJ3bB7t9IPlYxWo/Dcak9qQxskskYrQ3cwqpbIEpDtmtApIbFnyv9NO4Sbl?=
 =?us-ascii?Q?8WHY8gobXEfTLi9SRosDNzN4kP6X1dvPbaIguiJR4mnE1wGM0OjDE0mf68vZ?=
 =?us-ascii?Q?ySHiT4SF3V00N/s1j3Ia32uuxlpdXRfqOWbbzeZdgexvPfd7BylzCNRDP9XI?=
 =?us-ascii?Q?Yt0zdeL+KUeDuPhXTKD8uDTUThs3L6WFrJfhn0YTzFqgfzcCBB7qxfiwGsaK?=
 =?us-ascii?Q?JxunsCz0amfkwZz//aHXClkd2ilHKgZFjRtpidCcHlrJo4AaSIDEcibWYR8K?=
 =?us-ascii?Q?nhGJnBZD5u1OSP9SSHkkkGrkApquwrradeze9JTJEs7LrvWSiBNpA2oCfrzO?=
 =?us-ascii?Q?pA8/w1135rfnHlH5HgWMpxeIfuI7VKPjf+BnbITd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27908cfe-d10c-4cfe-81ee-08ddd590bdb4
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 08:59:39.4291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmknbB0hhzWo6pcAE4T0PRYBk/iai7zScN99XNa5e5lcHyO9kTTq1nLK2mr7+3AtsLPZzY+9WgUqbBQbA0bQMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6581

Use the string choice helper function str_plural() to simplify the code.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/accessibility/speakup/kobjects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accessibility/speakup/kobjects.c b/drivers/accessibility/speakup/kobjects.c
index 0dfdb6608e02..57139971e997 100644
--- a/drivers/accessibility/speakup/kobjects.c
+++ b/drivers/accessibility/speakup/kobjects.c
@@ -98,7 +98,7 @@ static void report_char_chartab_status(int reset, int received, int used,
 		if (rejected)
 			snprintf(buf + (len - 1), sizeof(buf) - (len - 1),
 				 " with %d reject%s\n",
-				 rejected, rejected > 1 ? "s" : "");
+				 rejected, str_plural(rejected));
 		pr_info("%s", buf);
 	}
 }
@@ -740,7 +740,7 @@ static void report_msg_status(int reset, int received, int used,
 		if (rejected)
 			snprintf(buf + (len - 1), sizeof(buf) - (len - 1),
 				 " with %d reject%s\n",
-				 rejected, rejected > 1 ? "s" : "");
+				 rejected, str_plural(rejected));
 		pr_info("%s", buf);
 	}
 }
-- 
2.34.1


