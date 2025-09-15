Return-Path: <linux-kernel+bounces-816534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 911E6B5750F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B0687A9CED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399842F99B0;
	Mon, 15 Sep 2025 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="U0xbQKRN"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022092.outbound.protection.outlook.com [40.93.195.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0D22F9980;
	Mon, 15 Sep 2025 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757929357; cv=fail; b=InW1KZTQ8WIMTqTM2rPLFYV+ssvjdbnfVXntn8auimX/S/IpEOex0mfnfQt1B0ioTX318ELEFUmWiIIQYuPGZmmlTWbxUvoKUV47XZeIaPZummGfO2f6/25CqxnBJfPFdCCR5/A1803HpkV3Z9hS3kO9uHh3XT5HbYvegyiwinU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757929357; c=relaxed/simple;
	bh=/J/JwkTazSxuKVhkjcacvDMmVgY+8ov+ZEhWK6Wfq54=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=I9fWycpfubs8qADrSxkZ3Ei/l1zC9Dr9FpHFPtISErfIgse4C83FBBaK/4NPQWAdTWrU+nJQCm1/ITgIFVeaAY7y/OWQ8Hvbck5cukFMP7QL2xpROShH8PWGwUVmJ/akYnh36vW81GDJ2/SIduJYSIIN/AZCV3tiUq381Pk1fgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=U0xbQKRN; arc=fail smtp.client-ip=40.93.195.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMzN8lw1LS1/NfFxLR0tVqJKV2PnPfNpiO3XBREb99Jb8wtnjvDBCZDFR4v+eo4fKmAGvbmWCyXR2pV8iBwQ+yS7FWva/NAioQLfNoIUO0U99BmMSP/ES7OU5GUr1aF8XyezpZnTP1ZWESlP8PHwM/7IiAWA2OSV1hc9mMDSIP7Q3Rpn5jI7MdeJU1jU5nMMvgAqYv7qG3j/ce6PtRBkFmWgP6BQZAuMtL+bllY+WgBbdUZYRHsFNK371QCQXEuVUPeCz1xxF8fBgIE9C0uKaQvNyZISidc09PWAkv3+rRNvrektODicthNtEGM5V3Hfpsu8yM3IqYl5Zg+yZlBUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUL93Iy1ASdFSsf/2Tk0XZIJtzDHW5nPP0iWtIEbmw0=;
 b=wF+/uD6OWF6t+Pl8CYQHN0gDBg0r+iz7nBub2Xjtc9JWL2xR1rr4wB/rUQXUiePEU6SfeLAGrfX3yw4o5dG9YJC4ntfOhEQyg6EF4DaZhQ58oqhEgrsbFp2Ky4B+xPRTCNxKubNlZRr6dJuer/lkpMohyFLIaY8Wzl2SkiPCzRvutcxu6LtdnddTWGQlZxF4m5bc6fpm5DD8JToIJIeavgfud/HYD9IXp0pDFDnoFIr3RcrshzDGIuw0LINpVLirT1jRMIdV711mRclxcP8cKe1OFW+asgUX5ytMnHzQ0TiZ69S5Ki19GXlAnFAnKmP87GcBWHQe1OGIaw1rEvkJKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUL93Iy1ASdFSsf/2Tk0XZIJtzDHW5nPP0iWtIEbmw0=;
 b=U0xbQKRNhVCjRlD9JaJyIhAseaVu0g3UkK3yUl/OrQ+z2fvrHVOXWcj361Nd3qOps+0ciFYLAUkM+b3roCO6lmkbsGdcZ+zwy3NMmnf6V7qnH85uXCqqeFPHyFdk9ldQwbctpnrY+/cJrqfLGToJec5eM4Se9h8vqG62XAil6yg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by LV3PR08MB10352.namprd08.prod.outlook.com (2603:10b6:408:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 09:42:32 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401%6]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 09:42:32 +0000
From: John Keeping <jkeeping@inmusicbrands.com>
To: linux-sound@vger.kernel.org
Cc: John Keeping <jkeeping@inmusicbrands.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: serial-generic: remove shared static buffer
Date: Mon, 15 Sep 2025 10:42:19 +0100
Message-ID: <20250915094220.2959202-1-jkeeping@inmusicbrands.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0387.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::15) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|LV3PR08MB10352:EE_
X-MS-Office365-Filtering-Correlation-Id: bd350f7d-d63e-4284-55fd-08ddf43c315b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BJ+odrNKJuDPjhvIztEAKs+qe6VuHeJAFS2ETi5YMCrf4D2Ihkc4z/77dxiD?=
 =?us-ascii?Q?b0OSZJ6jzlBArxan21HaU0jq/fUTz95pft4ABtwhJzdTHacjBgakKAx3MCUM?=
 =?us-ascii?Q?dLv2Orrs6WPlYZ/39wK7/ZoE0K3ksDirhfuEUnpdPRPUyzRpDkBDOAdDFApV?=
 =?us-ascii?Q?pr6J/SLUFGeM0RU4jSk28WSYFRwx5b/p34xetpSXHvMK9PWv7xd/oRYFl+Yz?=
 =?us-ascii?Q?ew6fWP/M3WCxNpcxRo8yOZ6cDeuDUKbQuiUiAxVytETAL9GdhDb8DYr5aMom?=
 =?us-ascii?Q?2HX2NpEvSQ4DzFEW4F47hvHFQWlbfQIKk0t+9X1zad9ob3A1XOOAdo91fjpL?=
 =?us-ascii?Q?Wt8PCp19Jw6YF92CFAH7WhA+sPOOsOqsifqOkmrYDqtOfgQDFzSnSG2alHi+?=
 =?us-ascii?Q?uhLqfMpsH6y0pl+v0ved2T3r8SLPTXQhyKYPhae5V/46lGucqTeqQgh0PTLu?=
 =?us-ascii?Q?5EOILP2MfMopgD/TRz+cbaUugNn9SyasHfQPXK6cxQiV2Jarx05mZmcQ2pH6?=
 =?us-ascii?Q?OVMtsM71xliL2sTVI+SkNZCP/mH8Jx8SOehVahw7IQwsGlorYkQQl30qHBqi?=
 =?us-ascii?Q?2WGqHrC7/3yg1hcAuL7nH12PhugYbLvsbQxCSE2WT2XcvEyQx+RHqWA/kXWe?=
 =?us-ascii?Q?+YuvCbvA/4dvTwUx5DbO3qNcuO2JTRFVFxS1u2ijz5FsIx7sNBRU0Aaaloxr?=
 =?us-ascii?Q?i3n1sO6vD1RyLSY6Toy8Lx2iqyrNLewoApgVsQ3i9OX5iOiKUz2hToGwhGKs?=
 =?us-ascii?Q?TRackdrQ8K5hbGNnWmEnOs8+/A51z/Ja21cpiWfpNuoplkoXznczGVI38ESW?=
 =?us-ascii?Q?xeeneQPe5igwMiPmAp7Qu+T89JS7Nzfds3tg6aQlW3yIatNFgy1wl/0KrsiM?=
 =?us-ascii?Q?qHw+XpKgWeJo1FS/yVsA0tC9snUprjgBENiVrvS6MsI9WOIt1Rzx8tsZT9Wq?=
 =?us-ascii?Q?xtBH+bhXcD/+QhW0YkX+z7NU9krkGBEPY8K9TUhBeuo+3M1tA3uo8tagysbI?=
 =?us-ascii?Q?sVX4u7GQtyKC8KI+W9yYBJ3ukgFnX5PMCnGvlt8yH8wMb80gF+cd03jZ0wvn?=
 =?us-ascii?Q?Yhex9ENrta9tZd++BFeYpWbu3Kp4+ohV9hwPhA3Hg2/8JeFckFUKsWJzdfc0?=
 =?us-ascii?Q?Ni4rukiXv8JzWLSv1xs1nslaxQja6WNL7clUdoWRB3KrtJBpHjn69utEjDbf?=
 =?us-ascii?Q?NkC0wuLFe3JpQdWecQKBI90me3UAf4/lTRexXzbRi4ptIm2oPfwZUVel6NVp?=
 =?us-ascii?Q?eG5vP4h4SPbaG2uwKSJdig2p8mdcA4+0/8jENy606s7LaqtvwxEroLd6s4AJ?=
 =?us-ascii?Q?BexR6F6YJSPl6225Ocrb7MvxR9OJTNhix9jsjaDLUPL2mn2UKH3vMpLvs/B1?=
 =?us-ascii?Q?1IVlBqQkkmY1zUxvVh3kJMfPaKJPVM6WA+FST4w28l/rFDq79zeOud+4n3HJ?=
 =?us-ascii?Q?FRkzkq/OqzFXPJ1AVGmcoiNdKBb/pbSaR0/9DIHKccjwFGlzfGzeHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR08MB8282.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SbgBFXfu9V863OynFUGTc9vAX+gUCsTbbZbwZ2yyBVppgC73nv6ZtDeJrjmp?=
 =?us-ascii?Q?8zsHfS3km3o7ZvkhsxqWQE4OcY8t2ZDnVhrgWjsprzdbeO/3D5WR7e3RVM3x?=
 =?us-ascii?Q?iChCILRL/53BU4rJjgD2Tr2AFoo/AtitVvG2XcQUsyh8MZ2bp3lk9910V7lu?=
 =?us-ascii?Q?k1Ay2m9fk0dYMRV8+rPcpfFZ9YkpAZxpHy5YravmsoGNNjsK/R+qTDBidQoo?=
 =?us-ascii?Q?GdBhGWi5GvZH6r/j8TF6aCB9LL1nLiA5aDzCfoKV8GgpLvs817q8fIhG0Jw3?=
 =?us-ascii?Q?jMpqAv8igiahGMTkg9Jtmh7RprxpsHbkEkSQtA1b8aLfb4r8Kyl2W8P3sx3r?=
 =?us-ascii?Q?DVyh7RpbCZoIpdi1Ya6zspHLOezjk7KKG+RVjlF8oxylPKqPPRhPQVG0mpEc?=
 =?us-ascii?Q?HrUQPRs9cg7dHVV7OES3dsIpHDl4Bljd+hQTmgE33shHYqEsomNwv7rYx7co?=
 =?us-ascii?Q?B3fl9pYqe+5BFTMD5AzYMezuLoFnmybMkbCLB0IIbKSMuOoIRuvGBIbmJJk0?=
 =?us-ascii?Q?gC38JhPNo4HaEa1p/EKu4rtv80WZxNbAcGtV3qLubne/n5qHiYTffPFXVyfO?=
 =?us-ascii?Q?WnXLn1Afxu6fG1EzER/Clt5TeECseVwwTVOumhFPHaf61sqIeDINlVnpFIJX?=
 =?us-ascii?Q?TT/y128Js823wZvpU22uA30mA2B2ouPIvb7eVHdSaGjUbMsH67Ced7WOKMoy?=
 =?us-ascii?Q?SKraLuweYXNO0sRHY9A9T6r8vmsSfizNs9ZWpQ3iEX2KM4C3bHMpY2TpWzLK?=
 =?us-ascii?Q?fisixahvRXsWuhz7DzzIvOoEt4cVN2BzsKjkftIacGQhbFi6dZadF3ljqd3j?=
 =?us-ascii?Q?S9o8zT3ewKaCFz/WMXqQUrSMLwypQCkZiXjMBVv9zK0jSCCcB5IF63CzZU3C?=
 =?us-ascii?Q?qFIrzCs9ieZDEbhN3PJFcuWBTBxKs9GVTw4QvAllSPBna5qJueAcXkUxbwd8?=
 =?us-ascii?Q?pfuSV0VBzyjpaS1IKpKRsHOdrjVyMVMQ8o4alyYEexAldkINQKJxBe4Redg4?=
 =?us-ascii?Q?fOMAwCQBIoJpnXdTl0jrJlig7LHy0XKwmQun3uIqAr977U5L4XckZMGbdLl/?=
 =?us-ascii?Q?R2qXgRWrJJpXVFWmgzQpxOprXt2cVqnO4uViflihFo9yTh4P2LAUgbw+pI71?=
 =?us-ascii?Q?vw9A1VYN9DHTuId7VCmAiUzeAKO54DG6HoPzMdOO+b1fMovSXVFC7C77Kfu5?=
 =?us-ascii?Q?CziZtau9ZqHH5zntSCb1wIMyTA/4uaCvuGIFF4sin9rBaZi7+7gdvoKYo5uE?=
 =?us-ascii?Q?cyJ7mW4YMXuuaBKs/BkNAwv442t6TtnwKQUIfy/XHq62IVcTa3ARi/0nlcUr?=
 =?us-ascii?Q?Tog0qZryqCsuX5cI+tyFV6m52kllYGxkgAuJiZ+VtBP0AsM882ZbJ0O8/mgV?=
 =?us-ascii?Q?xtAA99nyzD8kiajQSN4crOw4kIN4dZbEQN+S21wNNF482YWkFP4CNQBmQM0v?=
 =?us-ascii?Q?CDoYoOmrm8DwzT5BD5GcwjVLHWrCZVgPpMRrn03wa9YMv3Pp0n3OJqLl7wkH?=
 =?us-ascii?Q?VSx3SpB9g121ecKCxsKztdXa3I5WSPesvefEH1QBu/rnu8ORMzERFuECnh8C?=
 =?us-ascii?Q?8AiKHdeZ/ROOjTlzk62cuINQmR3CnFEkffjKd4Y90Sl1a7/mtK/4z7ITskuW?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd350f7d-d63e-4284-55fd-08ddf43c315b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 09:42:32.1891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39he5b2+2A8kheO0PqLk0xSnHFIDD8N0OmhyfIAFxTBFQnvFszVGSMdBe/k6x8x6bnqxvGBn6kJ1+b6Kl51CjSdlwKXlcU3O5yQubPcPouw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR08MB10352

If multiple instances of this driver are instantiated and try to send
concurrently then the single static buffer snd_serial_generic_tx_work()
will cause corruption in the data output.

Move the buffer into the per-instance driver data to avoid this.

Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
---
 sound/drivers/serial-generic.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/drivers/serial-generic.c b/sound/drivers/serial-generic.c
index 21ae053c05767..766206c6ca75a 100644
--- a/sound/drivers/serial-generic.c
+++ b/sound/drivers/serial-generic.c
@@ -37,6 +37,8 @@ MODULE_LICENSE("GPL");
 #define SERIAL_TX_STATE_ACTIVE	1
 #define SERIAL_TX_STATE_WAKEUP	2
 
+#define INTERNAL_BUF_SIZE 256
+
 struct snd_serial_generic {
 	struct serdev_device *serdev;
 
@@ -51,6 +53,7 @@ struct snd_serial_generic {
 	struct work_struct tx_work;
 	unsigned long tx_state;
 
+	char tx_buf[INTERNAL_BUF_SIZE];
 };
 
 static void snd_serial_generic_tx_wakeup(struct snd_serial_generic *drvdata)
@@ -61,11 +64,8 @@ static void snd_serial_generic_tx_wakeup(struct snd_serial_generic *drvdata)
 	schedule_work(&drvdata->tx_work);
 }
 
-#define INTERNAL_BUF_SIZE 256
-
 static void snd_serial_generic_tx_work(struct work_struct *work)
 {
-	static char buf[INTERNAL_BUF_SIZE];
 	int num_bytes;
 	struct snd_serial_generic *drvdata = container_of(work, struct snd_serial_generic,
 						   tx_work);
@@ -78,8 +78,10 @@ static void snd_serial_generic_tx_work(struct work_struct *work)
 		if (!test_bit(SERIAL_MODE_OUTPUT_OPEN, &drvdata->filemode))
 			break;
 
-		num_bytes = snd_rawmidi_transmit_peek(substream, buf, INTERNAL_BUF_SIZE);
-		num_bytes = serdev_device_write_buf(drvdata->serdev, buf, num_bytes);
+		num_bytes = snd_rawmidi_transmit_peek(substream, drvdata->tx_buf,
+						      INTERNAL_BUF_SIZE);
+		num_bytes = serdev_device_write_buf(drvdata->serdev, drvdata->tx_buf,
+						    num_bytes);
 
 		if (!num_bytes)
 			break;
-- 
2.51.0


