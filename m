Return-Path: <linux-kernel+bounces-847815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8A1BCBCB5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45C514E4ADB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 06:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31DF24634F;
	Fri, 10 Oct 2025 06:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="GlAupR2x"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB911DE89A
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760078122; cv=fail; b=WPkDgyEoDACxUGRy7mGIeER8zxcnQwsaoDRkxTfSbEFZUo64Ts6qAXD6jE9cr5vgZ5F97cAKWyQTiHDhsqoKz9yYomocBYq9MI7unlURlApklkTnXKuzV5jf+oiV5m8qlpAFs0AACaSD3bxahAFkgDooqzNoektji0MKM7pk9rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760078122; c=relaxed/simple;
	bh=a83p9dET9/VwfpCMh+pWs/MThOOYCA7jIsGFsfjTBnw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G6l6Av2WHBc2TPDg/btIF+zFeOQKuEpQrOcHqBsDwh5i+8Led4Z4ShCUcB8eT6bqDimxQyHnmFSNHpTPb+RmTe4dRPejitY99Ujp0PBco1QOCk3VLliLr7POsq2lzqDomO0APydFSCMUmVDK6j0lS07vGwbnvnxbfOxNoiF7MOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=GlAupR2x; arc=fail smtp.client-ip=52.101.53.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivcyE6dZko0UKI86KK78e4QWVXYMgdE4o995bHdLF4OfF+E5tFmlHRx6EGQdHdqwYn1A9teRmypSSj6UAXYhlA/vl3Ka97IVasSWWiY49vg84cY43cXEzE5qS0f6wu87Xc83+lBUxHx1Ttscre5DDhowt8IUS+GalxX9PzAnlthaj5iYHMbvdZ/bU7NEhlVkhfNi4SxKbPpaywPzx53CEy0dlowuUIRqMET9sVVSwLjNhu3FFhNYU8R2/CL59HeCgaY04OaTnURDNfQM2rE2X++YiRstd7QBlij1cUijiO1uiagngwk9yrFzFeiFHp3XmniBWpMfLJ47PiQcZ1uBDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osVjU6/3HvPxoKbGOzab4V9/CWq3EJ0SikkkdAGPHyo=;
 b=V+fSel961PKUMembVPRS5XHxdnrpIAWr6RpAT2zK0rpLerKE+FkFILfMI+M0RRpiZaPIDglINbO8wVQ3HEK7WjyilegZK+G6ERb5gX7da4+LUhILqzSQ/TKHOWsU3cxvBZXg6v7iMsfWr+3AvKUQisMT3IFT5Xf2XcwsyhkUbUytc0ebDlW8PQgHtua31Epq2Mkay8qlc5iEAP+bCXPZpbsARv8OxILHqR5FrzdIby7X9pGDoJbkOu2GYuupSnGsqZXiXjdwRp8WJa0WAgQHmYinDsUgau8du0GDuXYOOvS6Pgx++hDkIaLz0hWDG02BZKhslczqJBsFJZBGyYGgUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osVjU6/3HvPxoKbGOzab4V9/CWq3EJ0SikkkdAGPHyo=;
 b=GlAupR2xphQ43EOnONaWbosWy9X54lsvNi7uhegqN8MyXMCXP9iOqlXv2MACa7hXe3Yo8gBL4wZtrIz8RYLndJIvalpk4sS8ElxcdjJGtOtxiqiBBLteY7NudKclF8GPenjKC7bGCorxP9+cFW71n9HD0EIxpsNb9RrPMh1SQOO5Ft6uphLsjGdVdlysLTBaRnX5C4MxlT0CThKZn90uwzLFDBiNp92Nj2/aTj/VKhwbVIRNyv4UWcch8BVIPkQemriVIIl3FHO5ig5A2sExwZTDzBAr4NGi4TNenTA1ADFbG4n2nG5+lo4MkjvekkSNbLVQD4dkqtQQeMyUT8PeiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by PH0PR03MB6656.namprd03.prod.outlook.com (2603:10b6:510:b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 06:35:19 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 06:35:19 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	linux-kernel@vger.kernel.org (open list:INTEL STRATIX10 FIRMWARE DRIVERS),
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH 1/1] firmware: stratix10-svc: Add definition for voltage and temperature sensor
Date: Fri, 10 Oct 2025 14:35:14 +0800
Message-Id: <5797fa3875f39c30ab5c942310abc913344335a6.1759914326.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1759914326.git.khairul.anuar.romli@altera.com>
References: <cover.1759914326.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::34) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|PH0PR03MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: d5e9478a-2861-44c6-fba2-08de07c72e2a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xji8vO5DXPH836bAvA7b/i/8Xh+FCB+RJrDvMnq4d44DNTA1bm1E+tgMaAjx?=
 =?us-ascii?Q?MV+lRFwWDLdFkXEpHzsAgCgkeXGj7ropflwdfgubhBHsVmolv9q0j/9YrKt6?=
 =?us-ascii?Q?RMOiqjcdAxRmS55PhbiBH1rI9uz66D6RQ8uV8zmY0wBWnqhygzQ7g2+HLhVc?=
 =?us-ascii?Q?2VfD3S+qeTGuv1HRxop+HgoyFatOhixrZg1WRdP7MlTleeWhtQuDs+7qyj0i?=
 =?us-ascii?Q?aWmCEU/IP3NfF6c61L8MQ3YqvB8OhxaPnOiB/J2grvMvo6KJsLCEeJVnDrlc?=
 =?us-ascii?Q?8kxlf9p8sEL09Q+WsC6PjChikAXZ/Y6KaK1ZDm1eFJS28odKlW8TpzEaT1Nx?=
 =?us-ascii?Q?RcUruJPor4TmMmrYSeo/zx793FPzmgz9aQN/5ux4ecN9KiFV4xsHyTfq9Cn1?=
 =?us-ascii?Q?neF2CVogo3JxVT7+/KRB7egYaHxOyDutAuzTQ+rW56QORm48ra9Yuw2JUsHG?=
 =?us-ascii?Q?iTQ5Rh4yMIhNLV1YQOv27pWQ1wX0INxr7R8ju99XpZxj/cnsBgyprR6FYUR/?=
 =?us-ascii?Q?6RLOWIy5kaMYWpgf7+0xwySj04SpEd+5+pNDqKqa2/N85Zn7m/cRzGVs/sqA?=
 =?us-ascii?Q?5GW2wIxptnyc4gOy60yWtQ6dCR24BKcbQNMrm2hdbBcE5whCgWHk5ldEEWFb?=
 =?us-ascii?Q?lmDDdeTQsWlPsozNeZPaeosiWoMLCHHIcWciSaoiilP2ks2UuO1+2OwrZ+6F?=
 =?us-ascii?Q?hkHevOVTK+pUXobn7xdrtySFUjw7rCYtHYvFJCFoI08E9BijMBUzBfqNz740?=
 =?us-ascii?Q?wEDkqLvQQYlTOkmf+pEfw6lJ86XJkMMgUbhYQloMoS38BF5TGLUcUZ/1Bj5I?=
 =?us-ascii?Q?Q3sJKVjX3TQX5lcXUmuNElh7ynpy1EAm5xYTsZEMSVcAYhEduwu/c7sRTNjd?=
 =?us-ascii?Q?Me1sjoCJcSselAm6NNT0VyPhiw5qFgsXyE27ISFAX5HAtb7jrtWQtx87OCjH?=
 =?us-ascii?Q?YXGI2zXBsoGKsUKHiX9emw7KfIHBB/izULQij/u6AmzMDOebctQUpBLrq/Em?=
 =?us-ascii?Q?vl88yk2F+Zlllac9VBsl8P+y9gT2JJBaCaXJ7pwwujDWuM2by1XWdQcfHdbS?=
 =?us-ascii?Q?Bso9CIQUE3yPIG1/J1NQeizk3gbht9vy83K3v8BHXaKIXXQM9y+2i3OMeHIj?=
 =?us-ascii?Q?Z+h7viJFYfKyx+x2DIR/FOzVVwsyBvPctCer3diP3kp6ucTQv1fRJyD2cMpX?=
 =?us-ascii?Q?95U98zUdlj68k6H8IacRS8sbci4kXESaJSNPrRzDIuD0PGgikRr0ADrOXG/i?=
 =?us-ascii?Q?0ywusjhQasy7LzAfRmXydpeLTJzu9jXZx9ZIluj03I1/2pCcmDzpzPJrKCHD?=
 =?us-ascii?Q?pGMKpkeBn6fKLJS70qDo+ahdXF+dhS0yfLOXFXzIhrIDiHGLb5mvlJfWjdKE?=
 =?us-ascii?Q?ZAZAWQgGIAVoffFUU2iYxW0m+HJHo5lNC7cgxZz80EffYs6E37ATeM561FUk?=
 =?us-ascii?Q?C1BGikHuj6vuSSVWzaFNhrzq/kkdirzt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PCTXVkOnumTFeJ4FIqPp1RcrDJjmbLDjHWZY61c+8YnM6q+WvPqdv4r49QbR?=
 =?us-ascii?Q?fyGz+fhL2i/C17KW5RN68PmRF20ml5gQ0u0vsfQCNQm0AfAhGMEpiE9no/GM?=
 =?us-ascii?Q?XZ8MEn6RnmPUlPFIvqz4liQ+G0K/JZAy+0zayRoQY9kDAgdFOs2etjtB7NbH?=
 =?us-ascii?Q?h7Ntmee4erjntm/DVXeK3DnLmIWxHP0rKhRuAK30WJWosu8aahzoiHLFXRSg?=
 =?us-ascii?Q?xz7rhOG7eLASyqSeuKfJ+x2XP1IEpZahkmIV10ltCupWgqE28jZjvBSX+bMC?=
 =?us-ascii?Q?pH4Q9ODXc0L3xPPo/76OkqTdrvL4IpqE0+DY4QbFufnFaTJG/LOIEQr0B1kb?=
 =?us-ascii?Q?ZlnjqdwcGIMlxe0iKFUF8JdEaErchk171nauyaxmxZs7XZ8ZsiBlC7MVSRx0?=
 =?us-ascii?Q?DWs6sEp5oIz82UIgsDLUBrfyKQoGrCVmdGz/R4ZmLlMb9nOXb19bhC9wz+wJ?=
 =?us-ascii?Q?x/9pBeTs1zGDsIlQFZbEH59piUBBK77Nr8buQB7hD9YiTnVRGvZBjhIbHT/Q?=
 =?us-ascii?Q?fIUkEVHMPc4hy+tcDKt/djChf1OaRyZN6nsIgw2DqqPKgStT+5A8TAPfOhin?=
 =?us-ascii?Q?9DHaol3q+GQ0ARDTE0GixEaAQyXbSZMLLbTkX/oXJ5t0cppxJG7WGpZmgsEq?=
 =?us-ascii?Q?SfaNo1qSqWxfQw+kvsoKzR6SjJbzO0mE/nIemf2O0t3W2itUBBocXcFUCoo9?=
 =?us-ascii?Q?Fox5TYdj+NBMXDP9gx1ZXI6pWqhQJmO0RkeaW0+lU+r62n1udWvUBpz6/eww?=
 =?us-ascii?Q?PYsjwIRPNab06yLeseFUsv1cNT6fNmRxtEnel6LobYl8+uot56e9r1oafJ4s?=
 =?us-ascii?Q?GR95ZASU/wVj/0j9Xx+sBd5rt2eAQnuIJh0HkakSRnLS78WYHwrUg0qTtVFF?=
 =?us-ascii?Q?15ltBLuEdaFMxivlvEqrsH0fyIwafv/WDTTY2sSrDqIlhNRYyu+LbZ4EkzOA?=
 =?us-ascii?Q?UZ2njGHy0OsvOo2kpR6sAX2F5xiHMNSNtUWdiHVpfHuFudcX8qhq+kaFWB2J?=
 =?us-ascii?Q?DbfEPQjQOOig1y3u7Qr7R3QuKnSjSyNIH4b8lRkklAlyIf0Wq3qFq4pOGdaf?=
 =?us-ascii?Q?N89AXYUKGaxPIOMxlHpGn/+uFtpU5B/3vL/WF4DKOiuH22gMxu8Xlln8FFPe?=
 =?us-ascii?Q?HHQQG3GfdK15n+C/JklhyVfChqecDf24T8dfghs6PhG0SLvpfdr0VOBDS9yf?=
 =?us-ascii?Q?6q3qqWQ5EFP40e8aDUDwiZuHjTolTbek7/n3rnePK6LVO0IArrz2f+0EVprD?=
 =?us-ascii?Q?c1H8YKRm4dR6Wjpk5qUzRveDtwoUpKbzgyD5bCBYgn/XQre52x5ms9qMehAl?=
 =?us-ascii?Q?3aJTXQ1iGEG0ri/YAONNX4/K1/YXQOCt4xk5sBCs0t2svsnT78EmiVgvUHiW?=
 =?us-ascii?Q?PTyUZiFWfOdTm0ryCS7blWT50jipzJ1AMtZoC864KXJuFLv2JYhxrul7ghjW?=
 =?us-ascii?Q?/SflZ+L9ZMGKozkLWY8t9VQ69+qmv0QXiGpEXSqQjLB5ATjPemsvqGtPVOnH?=
 =?us-ascii?Q?INiCyEn2vKs2m9qpIVf2JBvqN7867vzzn2wC2j+gnqH16YPa7b9TetKZqKfm?=
 =?us-ascii?Q?MXTcSJCIxzrJIfIN/N27HA0PCkuyH+x6v1pFx/zgDx7cf+KG8ocNqZDuxWgh?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e9478a-2861-44c6-fba2-08de07c72e2a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 06:35:19.0562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqxSPhIYEaCAuwHGKsCSbsM/H0jvlA/W0/yebq8DXuE31g9aXMeQfn8UTFGkWWXsrOP5SDJtm6RF5dzDAINMvasbpKDS6Z3FEO2dH8Ae6p8=
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


