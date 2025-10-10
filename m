Return-Path: <linux-kernel+bounces-847812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEE7BCBCA6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 940D43A73E5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 06:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42CE23506A;
	Fri, 10 Oct 2025 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Fz1taVMm"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EA53F9D2
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760077942; cv=fail; b=dGjn5N/coqBHAZktCOeMPp+e1N1PV2OLY/Fjws6qc14+1adVONU5OqKiGlCWBDnhyq5nL1mYVXxU546XTzPuJkzQ7tNBv+GcwlQoIm+dc1Iv+q7F50nRk6bn5YZTQohvB9wJ9F7f60qaS+adLg1xxGO+lpfPoHXAYHLTIwm0pfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760077942; c=relaxed/simple;
	bh=a83p9dET9/VwfpCMh+pWs/MThOOYCA7jIsGFsfjTBnw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JxBN30AS2uJ0wao/OSzGCXPc5OMIiox++k6vvCbQPh/XDyIwLaXg+xPIC9LySErRTSEN0wyGDJ8fVM45x1So3SqGmTa1l/ZReF4T4rLTnlQtbf1QlfWguc0nTo6lzyQxnhFYPf5tWMsx2OBQjSfhd/MEv3Vs5jN4Qv9qcpOFDSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Fz1taVMm; arc=fail smtp.client-ip=52.101.52.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcQXngguqmXRAtQeDBophYM9l1BFbaJiXukpQEMrLu4aNEqyTlOV/5F71esChDJTp8QcqEXAJcNb/OccNk5hjS+C19GQ6tRWVVmfUTqbdGKm1lt82446S6A4H/jCNLJ70caSkbFIlUGly1pJI4mVlP4XHxTkIrXx3QmivnLrpA5Q7KimS3lOzabDQLT/9sl1hf7wW8IMZT/kqvW7v4DZSAlUUFo9KjXbUrnS0Lhs9v3JrAie4BPEmajpY++UrCBDx3BZS0NGwEnjhGGwf3fbKnZMS9hlPUgBn8tnWlzvkffZH1nuRHyS4WCZ9ZaGZMImU/vtCN2XqCuW2qiejSv+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osVjU6/3HvPxoKbGOzab4V9/CWq3EJ0SikkkdAGPHyo=;
 b=MlOMKHIfPzNLf+PvFjKNaB35FlqRYADPvs9tWF5c1/MBEQ0GbBXzDrlKLjm1xiyW7jUeuEFWdHEVuMaTjoRv/sRflfyhpzwcBCHlXeeKgkmpxsHUims596j+Qx+xn+AEueD5av+pwuTl7OFI9R7s9hapx9SGZYfEWRMbEGx1RjX+NX4hdtsUbBENPaxTlvBLNS2am7CrAWGBFCa50XS5syBCwVSP5vhWisvM624QH+iJZsYGvWjHelgjKE6y2jN9lhS1s0LhTN4Cj0rcg5WnmrkwRX3QGx29Yz6dXf6mPkIf9asLtuaV4wS6MZkC9Al6s3cKxKiBfgYCIh2kePAQvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osVjU6/3HvPxoKbGOzab4V9/CWq3EJ0SikkkdAGPHyo=;
 b=Fz1taVMm04QyRGHSC2crRbAHm5mc95hE15aSUq3vHq3yQo8zEvnQVFK4pi246upe5ekFYabOGt8Zs2mXR8KMm48Vx7JwEV6S4xvjnnUbtUTe/YK87oZrTpylroD2qOEmiXB27o00DIb5qGOG8ssekofulKX/dFSIjr07YhaVchiTeqpn63tOMFavYUKX1g0lFraAcn5Ou3XCqQjLTfKWAeMjpGp4/wa54euNtIlfUYbNFpZVQEnb4Evz/ZERtnF6JJ5f1LE+iRWdIxXg+8CaMOAPZTv58cZNCoL6Ypw1FaOQEhtUcd5t0s2wm7ldJy5kOl+pRqv2Jr5pasASlLQmWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by PH0PR03MB6656.namprd03.prod.outlook.com (2603:10b6:510:b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 06:32:18 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 06:32:18 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	linux-kernel@vger.kernel.org (open list:INTEL STRATIX10 FIRMWARE DRIVERS),
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH 1/1] firmware: stratix10-svc: Add definition for voltage and temperature sensor
Date: Fri, 10 Oct 2025 14:32:14 +0800
Message-Id: <5797fa3875f39c30ab5c942310abc913344335a6.1759914326.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1759914326.git.khairul.anuar.romli@altera.com>
References: <cover.1759914326.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|PH0PR03MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3ec8ae-88aa-453e-8263-08de07c6c2b1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PR0MDqTwhr+JTx92FiSoDcWrUkeH8Dq/gj7LlUOmdyGpgSitiykQCOC78Cwy?=
 =?us-ascii?Q?vdPnnCGBgNbxudxtBr8jcp1YpNnvvotX+b92uK6t0dZtMH3KAK0U9ilZN47d?=
 =?us-ascii?Q?A+SrvwO/YLTqiVRSzVdGQdyH26XeBhN3zZj11W/72w/zBHL62aSdYvMd5p0V?=
 =?us-ascii?Q?LvP6ztNoGZYvHeQ4QZBLWI2VzDZKFffLcob8G8Zwd2V4tHtYNHKhPfxR5reO?=
 =?us-ascii?Q?LL+eooutTO2+h2BAl0oJ1V1ZHpovYE3TJL3Sxd2rs7Eqr81jLwJM7dCTA5zO?=
 =?us-ascii?Q?Gn0kaL0FPS/M74kNFMkPNWjn+vSaHpD+bLTABIAGljVIYU0LF/qS3Ve3ioXX?=
 =?us-ascii?Q?Vc6GfhtIX9AZHlLfkLoN7mUrLaR2gR+x1JYRGrSg9rBS4hY6BEfRkygV1OyP?=
 =?us-ascii?Q?flOfDn54Yl3YLaIDMUL9FRXe9OowC9qE5dnjXRuY0m4oy18AXktGG8hneppp?=
 =?us-ascii?Q?UajAULLLas1AXFzL015sjzlAuXum7vVk7qIL2141GDXnK7OAJNwKiSt5AUXx?=
 =?us-ascii?Q?yaNRYHE3liSzcm3a6L0DhZudYaOEizK1SzuEF3DD62gYZomKJrDj3LskQjsR?=
 =?us-ascii?Q?zJ1AwZ9W/+wN0hHCewcsSHGaEnTNUXGjIflXmMQBwazCu0VpjS7VvnlSzCmM?=
 =?us-ascii?Q?/V6suFT1+/XpVMqA5sw73ah0KRpQd08MI5fC5EjQm7CYfZDnbzt7WruA5YGm?=
 =?us-ascii?Q?79x1ZI4+LC3130Hp4bmtCG8C6YxdkKoA/deRCkWd+Rncs+jRXFolRDxexBJI?=
 =?us-ascii?Q?Ghi7EAiU3crBY5MEqIWc/OEta3HOBNHbVi3VanYrM8//um7JCVDYJV9Uk6t8?=
 =?us-ascii?Q?l+Hv1SfUihM/os6MKt9S1HljJ/oIfdaMsO6izPB0QgU2rGLrVg49Pp5MSIT4?=
 =?us-ascii?Q?bkidbZ2ndWvG4gDXsJqXA4keOADMyzK99ISvjeLHcW2NqHflTmFsC0Ankwta?=
 =?us-ascii?Q?wQH2NXo7iGVIzhG3q2K0R8tSoI3czDYCSZgs/ZJlPu1x96uvc/PMNOFcABFY?=
 =?us-ascii?Q?c3Y217l6rOpuvkk07qlF103PF7kWcUhzkYski9V12/kOI/49O5pWjSs7bjK6?=
 =?us-ascii?Q?rz49TVRZveJmnPPkV92vdtcmRZMubm2V9u2hmNStQyYddWwBJ1IoRBcWskOK?=
 =?us-ascii?Q?XIJEgYBkq69MU/RlFmZCtRkUQhlJktg0aBDBF9QdDg8MqoZswEKbTJhSEpiM?=
 =?us-ascii?Q?nKUgpAh7TFWA1/z37MLRIe426QKZnKFQRzxjZlWjIPEBEW3DIW7Oa4X1Ph29?=
 =?us-ascii?Q?OJA9Eq8rLzCyiCtpCM3tsjdSfC/zcdPiAp4AWmYRKnxRkTftVZqmEL8IxHwb?=
 =?us-ascii?Q?lh/0Q8+QlpnqtAOb7LwnF+CUO2jcIEEuifrLdTLArEADnDHkWuoHQxkGJXt1?=
 =?us-ascii?Q?/UG/SiMvzxP18FnB1T+4ygW6WmmY7OxFw9Hk9mGhcB/988erJCoUEc240T4A?=
 =?us-ascii?Q?wghXzl/63IGfGboREdjdretF6Wwl5iHI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RxueRN/ZAqIKNQxxP/es9F96OvMmtTNqjg/CKCiaPqTjCMrjHnyywFyX29/J?=
 =?us-ascii?Q?tyO6//OgrKVOmla2l3214YYL9FQI2CswCFklwAmx06yNbYRJODuLelshSYck?=
 =?us-ascii?Q?nyqRNkZ+5e5fh3n18UeT+zCgHKaWCTP+nhqKbIOFcj/T9xahUsaeDagxhAsk?=
 =?us-ascii?Q?KOEY5S7Ijmp0dSCMpbrtLU8MpkDXtw399b8826LMIImKRzw3wphVjHTfJDaw?=
 =?us-ascii?Q?3JGLI/qJlP2vipffQyMoLNLR3OkVy8DaHzLLVAjX2q7odaZnlLyMmMxTN/fy?=
 =?us-ascii?Q?S2L35T5B73fYunuIl5e0a00BuEEZeFeQ9KUQ1oNzxElic9iPrWmDsLKt7Jx0?=
 =?us-ascii?Q?4ijy6X81edDOc0Z0b1nronGJxc8QqmbFg4hpX3hp4G6T6MplM6YSUumNIlWX?=
 =?us-ascii?Q?oki9Ue2bdMJ1SEL6RYOhJ7xNc9Wd9e1EXbprGhTf+IQcPYOkHzu/RpjGZXJO?=
 =?us-ascii?Q?9L0qp/CCJk83IA+cVk6OKe1yJrI+IJJNWTo9Pyu3RFed4CzwWTAHwom6A2Q6?=
 =?us-ascii?Q?02Brj9Q+1n2qZC40qI7soVpRNBc2CAqCYZUu0TaO4HKN6kXK5sb5LGxn6bFn?=
 =?us-ascii?Q?/P1pVVH/RIulUkYUwHop9S7wSwPDPZ9Ad1qWpQx62tnx4v4CnFZZU8uArWCz?=
 =?us-ascii?Q?StpgVCsCaTEcICT6rw+ZonlfrMgjJ7P2lzVUzF1UC3oR0hRo+Dn/k9aTSPZC?=
 =?us-ascii?Q?8a3HG5TL7ZfCjJ7OMjS57hhjeHaEECRtRySdDc3AqMssdeCi20X2GS1Jt6Pk?=
 =?us-ascii?Q?RYRLa4VK1B/kVClC3r/7bDfV5z5H4h0FAqJhTUHT1t0zXiRnvfhZHwxWALPk?=
 =?us-ascii?Q?4jT+Ji4kAALNvEzkNfWL7Ma0XzhAAO1Zs648HGEYUfA5lVBVO8xanei7mIPO?=
 =?us-ascii?Q?Xu32I8kopfuB/0olMzwSHPvnMW9DQJRT61SfReLrCX7GoeQ2s2xumRLAlt1O?=
 =?us-ascii?Q?NXKna7fUkdlPjJ2m15yDn5c0VsJgTsx0+RQGK5RStZSCcMJGXfOf2LqpqZpr?=
 =?us-ascii?Q?pxd32NXFXQTA75OIIY6+gOmdAOtTIFBIWggvQioC4fnVqOItIFODcNBvv+eO?=
 =?us-ascii?Q?pPuqFsX1ZH/yQNvcJGF327Tsj0T4BCHlY5knBU6ggFOkaIesrkjY+YrFgjSB?=
 =?us-ascii?Q?31BMj7l4shoh05DP3ePM0vqziYTEx1k/nybRnfj5yITONJ3gctD+5SUXX9gK?=
 =?us-ascii?Q?ZkCzcjRkOe1nXkFItLemtJbffK8tipjQb7SyYuLi0psP4icWX8ZxyEoWgDQq?=
 =?us-ascii?Q?KYS49MJEdw57dYWneIRO9XM/RcpGFXTY4oL+OBGWp0rMjpb/hq+3Vc8kug8w?=
 =?us-ascii?Q?rMEU3romlHX63Aiqgy10VW6R7F0iD0jqKQw94xpQwWQjNKBul4OX5qYNohFo?=
 =?us-ascii?Q?RDAf/AdozAKcPcrLcIALoO4LWKJuFQGP0e+LDHPPdFg2Fu1+TuBoMRGG+mA1?=
 =?us-ascii?Q?QJiSGjxvXxm4nZ/OpeZE45EKyz7K8BvRh54I5e2cp81ydTFswnnBR6uFio/J?=
 =?us-ascii?Q?/1wVv258dSPSVLrauixuEiDWyr9EUYY5LIRlehmgEJ8aWeAZif9TkBjT5/bG?=
 =?us-ascii?Q?5XLX+N62Rz7rDyeEr96fV8HcVxKxeqOPLMws3JtpsRxm/a+RpOy8mkYWoSgA?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3ec8ae-88aa-453e-8263-08de07c6c2b1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 06:32:18.7254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYgRKbJl5i7BVx+grPojXuj+Aa5EI1NeP7gGMFYjc28Zt5XeROaUF3BD7rQxlPTgJtx5r4FyMYG2P/6AKTPFnhdDFzlioecuIqTOJuCQ8DI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6656

Add entry in Stratix 10 Service Layer to support temperature and voltage
sensor.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
 drivers/firmware/stratix10-svc.c              | 21 ++++++++++--
 include/linux/firmware/intel/stratix10-smc.h  | 34 +++++++++++++++++++
 .../firmware/intel/stratix10-svc-client.h     |  8 ++++-
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index e3f990d888d7..5a32c1054bee 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -34,7 +34,7 @@
  * timeout is set to 30 seconds (30 * 1000) at Intel Stratix10 SoC.
  */
 #define SVC_NUM_DATA_IN_FIFO			32
-#define SVC_NUM_CHANNEL				3
+#define SVC_NUM_CHANNEL				4
 #define FPGA_CONFIG_DATA_CLAIM_TIMEOUT_MS	200
 #define FPGA_CONFIG_STATUS_TIMEOUT_SEC		30
 #define BYTE_TO_WORD_SIZE              4
@@ -341,6 +341,8 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_RSU_MAX_RETRY:
 	case COMMAND_RSU_DCMF_STATUS:
 	case COMMAND_FIRMWARE_VERSION:
+	case COMMAND_HWMON_READTEMP:
+	case COMMAND_HWMON_READVOLT:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		cb_data->kaddr1 = &res.a1;
 		break;
@@ -525,7 +527,17 @@ static int svc_normal_to_secure_thread(void *data)
 			a1 = (unsigned long)pdata->paddr;
 			a2 = 0;
 			break;
-
+		/* for HWMON */
+		case COMMAND_HWMON_READTEMP:
+			a0 = INTEL_SIP_SMC_HWMON_READTEMP;
+			a1 = pdata->arg[0];
+			a2 = 0;
+			break;
+		case COMMAND_HWMON_READVOLT:
+			a0 = INTEL_SIP_SMC_HWMON_READVOLT;
+			a1 = pdata->arg[0];
+			a2 = 0;
+			break;
 		/* for polling */
 		case COMMAND_POLL_SERVICE_STATUS:
 			a0 = INTEL_SIP_SMC_SERVICE_COMPLETED;
@@ -1197,6 +1209,11 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	chans[2].name = SVC_CLIENT_FCS;
 	spin_lock_init(&chans[2].lock);
 
+	chans[3].scl = NULL;
+	chans[3].ctrl = controller;
+	chans[3].name = SVC_CLIENT_HWMON;
+	spin_lock_init(&chans[3].lock);
+
 	list_add_tail(&controller->node, &svc_ctrl);
 	platform_set_drvdata(pdev, controller);
 
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index ee80ca4bb0d0..7306dd243b2a 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -620,4 +620,38 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FCS_GET_PROVISION_DATA \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_PROVISION_DATA)
 
+/**
+ * Request INTEL_SIP_SMC_HWMON_READTEMP
+ * Sync call to request temperature
+ *
+ * Call register usage:
+ * a0 Temperature Channel
+ * a1-a7 not used
+ *
+ * Return status
+ * a0 INTEL_SIP_SMC_STATUS_OK
+ * a1 Temperature Value
+ * a2-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_HWMON_READTEMP 32
+#define INTEL_SIP_SMC_HWMON_READTEMP \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_HWMON_READTEMP)
+
+/**
+ * Request INTEL_SIP_SMC_HWMON_READVOLT
+ * Sync call to request voltage
+ *
+ * Call register usage:
+ * a0 Voltage Channel
+ * a1-a7 not used
+ *
+ * Return status
+ * a0 INTEL_SIP_SMC_STATUS_OK
+ * a1 Voltage Value
+ * a2-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_HWMON_READVOLT 33
+#define INTEL_SIP_SMC_HWMON_READVOLT \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_HWMON_READVOLT)
+
 #endif
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 60ed82112680..520004a5f15d 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -11,12 +11,14 @@
  *
  * fpga: for FPGA configuration
  * rsu: for remote status update
+ * hwmon: for hardware monitoring (voltage and temperature)
  */
 #define SVC_CLIENT_FPGA			"fpga"
 #define SVC_CLIENT_RSU			"rsu"
 #define SVC_CLIENT_FCS			"fcs"
+#define SVC_CLIENT_HWMON		"hwmon"
 
-/*
+/**
  * Status of the sent command, in bit number
  *
  * SVC_STATUS_OK:
@@ -70,6 +72,7 @@
 #define SVC_RSU_REQUEST_TIMEOUT_MS              300
 #define SVC_FCS_REQUEST_TIMEOUT_MS		2000
 #define SVC_COMPLETED_TIMEOUT_MS		30000
+#define SVC_HWMON_REQUEST_TIMEOUT_MS		300
 
 struct stratix10_svc_chan;
 
@@ -171,6 +174,9 @@ enum stratix10_svc_command_code {
 	COMMAND_MBOX_SEND_CMD = 100,
 	/* Non-mailbox SMC Call */
 	COMMAND_SMC_SVC_VERSION = 200,
+	/* for HWMON */
+	COMMAND_HWMON_READTEMP,
+	COMMAND_HWMON_READVOLT
 };
 
 /**
-- 
2.35.3


