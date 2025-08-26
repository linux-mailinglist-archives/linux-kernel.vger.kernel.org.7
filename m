Return-Path: <linux-kernel+bounces-786428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F13B359B0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8847D7C2CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D4C321422;
	Tue, 26 Aug 2025 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="UxFlHp3r"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013049.outbound.protection.outlook.com [40.107.44.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47192FDC5A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756202384; cv=fail; b=YS/DL/dwgTTOwnYxjNvYsbw02IVq/kBWZepBLCZLkpn0zkF3tK7cZ/X97FN2HTeyru/lMyQ0mbezrkUeDCvoT+2sDG4+yPVDlqYnDOtVXH5mXdTxdH1z64H0v6rfnIQI1HZbeoFR4ywClqvFmBlCsVaaBUi1dK86PjeTGzSW/ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756202384; c=relaxed/simple;
	bh=cIu+K+OTfwjN5ZdaIOkr8lxIM044CewU5o5GPgOJkMc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=f75KZ4ssK1ORG2PvazyRzwA2OSqMOSdbdGw3N1+LwR5J/SaGw7kyjbVHYoLS2wjNOcdj9pYUxyQM276striOJLWFm8EyHsAmluMLmsjrBn3s8+qqP5urX2UAZGvbR6cjK2E1330fVzVdOL3jsjGM1gNoGmsjBDOUY7YbbC6RShM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=UxFlHp3r; arc=fail smtp.client-ip=40.107.44.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O51zqlG72lSIb3gxdWe/xg1i0VFgRPRFLrOQcXO4r5CEcK0wmpgdlpge3DahKJGubUNH9wo353CSDCd9V9+JRfFLELoV9GNkjQjdp2hRSGXU+90GMMA/tRKelbQQbyL13EmxWvW3FzzaZ2WOztX3wnogm/kewqc/I/m6c576ocA0v6hjxn2a58p588z5vs9/x/TijdQWOf7wH5b63aGKjxQjrv7vKZwpqdeoKLQagxns37UJCjJGymC5ABexETt3cvvK7hxcy55SAV69NtEy0DGoNcVakzi8qaI+NnxYrO8VYJrksZHGmiRaGRdXVUXB4MwLhtyJQ1K6BusvbQE0Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOml1wANZD37hiSF0YAi2U5PmSH0azbckwPmTYvVFhg=;
 b=IeoaCIeUSNVtYCcBPkBezmgBWslRVop3Fh2Vmrm86Z1rra5XXE3JaW0jWFmRBGZQDXd9RXDSQQMpn23iFxyR8XKdu/qybbT8svqcl800Oc6Bao78upeUsSFTxSa6hfCUgcjaP3nPeOu67VzAZ6doCE3D8GXZIa4GS6KjbwA6uZtqdRl8vH9rpSihsTtOH2nKGR3BhrXF+3TldepMrZUiOZ/g8wBOlgOJgY3RLrZGqP7/hWxilaMwtuxeMzJ3RUfe8hHHJB/gExWHOhCUmmzz/zlEhkr360XONvkVg+ydg63w6obPvu3ZV1WYTAeDlWuTdH5WaHsPI8h0EVw+qPp7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOml1wANZD37hiSF0YAi2U5PmSH0azbckwPmTYvVFhg=;
 b=UxFlHp3rLs61vequ4NKhQsSkM1ti0qUMEAe9dco6etFmg3+kBmXEckgjkMfS95pkdT0B74Mwm5J7VhaecMGZZ58AWOJ7kDzvn3GZFv0xTf9cPlRIj6NGLjGuMwX/3cbvA0m0Ww76jvBLlpRL1XcA3qFeY4oN+DBbYfLtY75XEFGm/f38Zgk3tjpzgHH4xs4hBOX8yiM9I98r5qgPQ2c5YDTJy/0hLDXshU6dwg2FDVY3GK1iXr5zza6tepH9Aq8cjOrx3fo4k/4kTjLZGZwdeKSYgZ1KgnwK5bax435nmZe+nEKlZU1aXg6I8KbS9jUzum1J13AMvKu7gOZm14Kj8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB5206.apcprd06.prod.outlook.com (2603:1096:101:8a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.19; Tue, 26 Aug 2025 09:59:36 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 09:59:36 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Rubin <matchstick@neverthere.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] staging: gpib: use int instead of u32 to store error codes
Date: Tue, 26 Aug 2025 17:58:59 +0800
Message-Id: <20250826095907.239992-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0067.apcprd02.prod.outlook.com
 (2603:1096:4:54::31) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB5206:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f230494-f843-4e08-d9d9-08dde48737ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ILe61rpTju7J9m1C1OCL5HxyuRNP8E0vCPp9zrzDx9j2ar0zDRw2xGI30QSm?=
 =?us-ascii?Q?Wrogx+VMot0LkWYjFxlExgEbuT7y3EF8erAkyId5NuszJtcfVqo8AmIykpdw?=
 =?us-ascii?Q?7GfLTfDCgWYD00gmi0iw5L1sbvX1iFOMqJSiQxNOpsIA3cWOELjqvPRswGHW?=
 =?us-ascii?Q?u0BLyp/KxnF07Qz4giN1fyIENHe0H5mZDXggL7QndEiGVYZctO682lgkMt60?=
 =?us-ascii?Q?YGJxMz2SadxEQCUcqb9gacCVWzNEUx0eoIV0C39/Jg/NFiwmniVZzhT7biD4?=
 =?us-ascii?Q?eok3RV9DPCvM3GM1j4EdJ9DV1udMgcS9gPoPZ4fMSzkttywUOJGPBrhrt7CL?=
 =?us-ascii?Q?M/MYO/KNcB8OmUwm0pjtuSFC9BFB3pDcs271F2SKTMDrdZQOmDOO71PxCCyh?=
 =?us-ascii?Q?n1ofacH/j/FcGWg0kHvaIuxbjM2hP1Jq9na3SC7cP9+GS/ARlsR/1oNPjtbZ?=
 =?us-ascii?Q?dNBNIgc1Qs3tsLpNCIsLfiFyM/sfT6idKUnXe9irSgHqQNfveyWNBrivwMzu?=
 =?us-ascii?Q?Lx3qTuHEnEsyZ+V0cgKFWZP0LpN2+e53gu4RrLSxX3hcoDMy83bnTSzFFcZi?=
 =?us-ascii?Q?t9y9N16ntbCureeODP3DSKmac0p/ff2B2HtLKk1SwMraDBPAZmRtwpkI/CqT?=
 =?us-ascii?Q?/f/w/iw3SaQ47ko5M7lfBLSGiuoCV2i81ZKp6wO/zfcH2fVP2dl+5C/yXTeb?=
 =?us-ascii?Q?KSyj31SCivZL5ACUFUtyX1WMRbGPg8VYZMptBDkMaG8LVcdRc+oqtxBGXMxK?=
 =?us-ascii?Q?Z0IcSaLyT7A2ZPKe3hy3Hz8sXNM1zfWAxDiP9kYEsDlIMXImtZbXfbwP3h0s?=
 =?us-ascii?Q?ymFJMe/BIqigIqaP5bhDEKngnky0L2w0420Z+UD7ck1Y+AS6klEZ4MybDFoZ?=
 =?us-ascii?Q?AeNYCw/JJrX0X+2VU0e52HZwyKSsLZWKAJDPqGYwdf3Y26vLWz1U6o89W3DX?=
 =?us-ascii?Q?GQLofhUgkts4vhaHxWTibk9DOzZdppJmWpQaLTfNsIolI7lvV7z7LpQE6srl?=
 =?us-ascii?Q?DzQlT5AmokfBYIMt8AwLdB6qwdTk5fV+T5pmrZjBWZXjj9ALxlWgkxnAu0EB?=
 =?us-ascii?Q?mMlOz0L9OEcyT7wA8ZGwlscMrc/aITRj0+Xui6snsf9MBQi7ez39PvxSnjUk?=
 =?us-ascii?Q?3uey5Bg2kQFdjLMIFSSZr+944DNz7aZ1gFlmPYOR2W3GWfVLLXZtL1VC5Agh?=
 =?us-ascii?Q?7cywvklw+hm/99zm4/hIbgF+ZRRJmRQIDSS0FMS6+oySIEK7odRCv7z9CJQ7?=
 =?us-ascii?Q?vJrLbDqSHQqrbGX7nd2nqNeUAkRVrQp2hlWA7VXmB003TtftOqm/sJUEw0I9?=
 =?us-ascii?Q?N9AQELoKHMHZXVo7qitLnX6GNceAWi/qrZPMJFHkO0cQh9PqQPINy2qRDjjx?=
 =?us-ascii?Q?U+HYLRlmXCG6Gn7BnfJnxjjEv1vEzcNc/E2Dpvcn6fx83rvUgHpIkfxTIZiA?=
 =?us-ascii?Q?XLQrz8W++LFl73moL8L3mqVlbk6KLRY3Tsw5xyzprhZsF+PJty246A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pMz1kh3IRe66QfOcmMLwGTCceWcJKnRdxOO5HkgBXnaU9ExpmmqeFBeBxiGP?=
 =?us-ascii?Q?AyMmrzBlt3bReOI0GNHLE+TtoJjD7UkcKDNv8jlwk0zdokdtgUzQ9x4JNV7o?=
 =?us-ascii?Q?kWdqBJDSd8B+gTQV+TXhjUX1mh+uTwU8sv2/QAxUinUFnmm05GDyBvlG8enn?=
 =?us-ascii?Q?piVCwkgIbcCzEDwLQ+j+5oHFoH+ssNfZ4pLEhv5Yj+/lm//sfe3Sx7qVeJw5?=
 =?us-ascii?Q?JrHdP3eZPjnj5xYgLC+99cSjFi0PMW5HBsz8kn4o16EXJK6Ja0+q+E5pRuEq?=
 =?us-ascii?Q?dETbjcfz1i/BibJCZz3MJs+O+lufmawx1THZJVbFDZezZPla8OD6Z17w37S+?=
 =?us-ascii?Q?jJMSQe+gvJduJi/hPOdS3jebq1LQRp/QtRsS8hMabDS1PzwxSa3ghiz68Ibt?=
 =?us-ascii?Q?RQIkLadB/QMtjUJnHKyM+0RFth1FrNDSeLL+12w0iYMBBqfJnMjKLVwXp/SJ?=
 =?us-ascii?Q?0l+dn55q2o0LsGABFZtAEOZVodIiP29zODIm5W20Jo5XTyJneK4psdguXrYk?=
 =?us-ascii?Q?udUjGjKo+ISFduKPa1zsEVCRM8uQNzYmgKwJ9bZvVYWrCJG6XJ4GkLw7me+k?=
 =?us-ascii?Q?zvTaMJDdQsL1WgZ+xoycuflpTHr45t/8SJNFhJoAX5eWIqTiRD7H10rhEK6P?=
 =?us-ascii?Q?zeKrKkh/wuuYfUG9LH629XOUz71YCsFpWAjpwgIFbYZvGa3GBu7V76MYNwPL?=
 =?us-ascii?Q?8/p9/8s2cjVdDtkCRmBnI684g1dm/WN1HFyEKhzfiwkR+MZGK+xiSm8nHYfZ?=
 =?us-ascii?Q?+Vqu7rEFXs5zSD5ZaUhO+eTbnqFpDx4UkOhTtU8HW4tUTgkIqsEYrHLxg+zx?=
 =?us-ascii?Q?TctVQLjMmUGftQeJu27ipvChog6XF0LlftogliT3XxrSWyaEvPNAxtsJoS22?=
 =?us-ascii?Q?7lOEHqLID+sw+av8MBGJ+jZSJDcMNbrwaNiAu3nV6MqS1fIsyr32wrJYii0l?=
 =?us-ascii?Q?v9qlkl1oFIsh5GwBt78j1Lga3wsED+xRYRwGs4KbVLZDHXQhI7W3MXZcq5Iw?=
 =?us-ascii?Q?sA7skQNbOywMWrK05Fmb9cceCQpDBMN2YWZCZR+b7oxDS76wb48F5qiNPU3W?=
 =?us-ascii?Q?IHKd0zNgYDPQBolFGNwgsVvRGgqRRz+RiQOgS6oNmukvYGLyxcf5O+SwMkOp?=
 =?us-ascii?Q?4ZaMp0dEYbfqhpR93BqprFVl5RrN6vFQMG/F0g+zG8UZFMExsJgb8pZq/28l?=
 =?us-ascii?Q?+lcLAF8S4gpIwNBDWeHqL8I0SpkyxpdVkHaY/Ag6ffwV3RF/SxLJ3YivOdfR?=
 =?us-ascii?Q?NakXt1iehveq6Yabl6jDuAbz8Y8ogIoS/qXf0Mqdk/94Jbfz8/4+rr3v6bXP?=
 =?us-ascii?Q?TG9C0jF8HdkRay2UqHt1ImGwUgEMcY2pK/os3PcMi0D3DHT6duWp5nxUnlZl?=
 =?us-ascii?Q?vHeh3oWxZEbH4P0WhmTShlzGSbMLo1L+bIGFKXV1VUddUsREaaRPkKWliwcg?=
 =?us-ascii?Q?piFeKdWh1oV39l6LSozKHFP0E0uMqlFKYeYbEuDAMElh7kXg8vq+HWSUwDDS?=
 =?us-ascii?Q?S1z2tKxN2YlaI79CP2vLf0GqK0YzPtmyCCEY+uKriRE/fmjTuG0rcEyQtzmi?=
 =?us-ascii?Q?SZFrshdE6cRUFPCZ0nq6nvdIA/iFO7NDy5shFHsf?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f230494-f843-4e08-d9d9-08dde48737ff
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 09:59:16.9994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8hgLefkhK5n5kCjb3dHzOWhYPhk+gOrzjn0kn37ImeRC0jNunmrbMQI587EsIyKHy7IVxEDRbV9M6NLzQi2kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5206

Use int instead of size_t for 'ret' variable to store negative error codes
returned by bb_write().

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/staging/gpib/gpio/gpib_bitbang.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
index 22a55f3f794d..374cd61355e9 100644
--- a/drivers/staging/gpib/gpio/gpib_bitbang.c
+++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
@@ -726,7 +726,7 @@ static irqreturn_t bb_SRQ_interrupt(int irq, void *arg)
 static int bb_command(struct gpib_board *board, u8 *buffer,
 		      size_t length, size_t *bytes_written)
 {
-	size_t ret;
+	int ret;
 	struct bb_priv *priv = board->private_data;
 	int i;
 
-- 
2.34.1


