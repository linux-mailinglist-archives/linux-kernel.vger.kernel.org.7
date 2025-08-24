Return-Path: <linux-kernel+bounces-783653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3388CB33044
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 15:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F46161E87
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 13:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B972DBF5C;
	Sun, 24 Aug 2025 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DmN96eXX"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013015.outbound.protection.outlook.com [52.101.127.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956452DF3EC;
	Sun, 24 Aug 2025 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756043748; cv=fail; b=u8lR/V2SW6it9BOiknZFD3+rfo9yPSDl4OSp19b7ev+sJYcRyoU8bXMtowaIDpoigChJy1fLkVtWRIGTdUyEOjXphGEA3s+QSHbnQ6/QRC25ClPa7IGGeRNlc6900zWy9m3wRiMTXS+Ifz2wS/D/IK22xdO7LPWkvriiQ9x0+CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756043748; c=relaxed/simple;
	bh=qiLEtw5fzUEfNVVd2gJCbHJCCDGBmDp3InBorDmDk9E=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GxN8/BifA27hvjiHeFRFypJEnquwCuFdvgF7ecWZqmrLnwk5r1M4+6dwWn7gPWO/jUImYRITS/eOVAWGtgjrMhL3MDLCQ2eddiXwI4DGJ8Sb/dOQ3q3g+buqE5vjTtRKrslJcziZlcYa8jag8oxS18hvdiW5SZ+wyRNmBrDmH18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DmN96eXX; arc=fail smtp.client-ip=52.101.127.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dV8Al7J7Px3pXkfIRabiihWHVei7GnzVAzxgj51GmcmgUQBWvXbUs8s38V6gqxnkkqGeR64y2a9n9bRZLOPcRkyKccE51oxK5F5wOhrb8qpNb4C50QNXwPSbKeW4JdK8vUb2wdzsqNPCWtMVu45Co7tgvP13ddmpkqn6ZKosbiwPAgbfOu6dKG6mTYk+6loddnehRkIQ/SXn5qDfEv1FNCc5VDx9iU2Pyj7FovQMYYg+RMjdokmf3W6G0Xg1ixHqA4NQ5KtBmSfSgjPiBsIMcsod/4lJRrJXenZ3dYHQtKG/stf+a+TXmsiTTnZ4x9XfpQd1sQlmuM19Hkb2Qevyrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOZO3vTgQvsw+FZbYYzWu24g3JEr5qLgPr9xw+IQ72Y=;
 b=G6tIjEAw27CdDs/cPSiw6hknPmAWF2xqrztcEkSSzElJYIh9BfdqcuhSeUD1GkUdbYfrcD4sVi8ChEPDOcMAVagrbPJe0o++q5xW/9evudC9OqlGx0kgEn9x5UBB3jYIIG98YuYZsblph/s4azGfjDABTMDmSEfJ7PMJZ4MYjv/6IUiiTPc2QmqMyU4uKnfx63A6MYaMI7+iJKPgqnnCZGWFs2TZ0k16jUR6cA1p0qEvbS01k4mSQL5lEgr3HtLfsR9uRMhYIima0v0mWzSgGDR/Xk63gWbxvKtFBHMfa8t44unHNUVQ+sQVE8Pu4P+hXZ+kAJeeeVK1yE9yJMr+nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOZO3vTgQvsw+FZbYYzWu24g3JEr5qLgPr9xw+IQ72Y=;
 b=DmN96eXX+QfF9diHCYv03DK3dJugeM9k3APtRG2RlhiRjR/0+5RLbLBTBQWqdSBg9eN+ElOVgsQvwdNTmUx9gh7F1bzBhcL/GUR8EclR9pPqYCx3s52FsIs4cBbWaFZpTisZ5X+tQAXlJgTCZxVS9RO+Qm9Yjg8hFentGNpxZup4gdeoj5Mc3T2zOqPLMrzajTc6XirjvCg3oB3po9LvJO2IP8yC6lKvFVLlQRQobBgkHnlG/7oebxnaB15SRKV7NLz+aBXzmqO3YnmvsYHA3Awzc3yxSvjyBuFGYBRfupwoaRLDQ1dTavaLdGWI/JhLDg2tQAjzyu/8F+80MY/FoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB5685.apcprd06.prod.outlook.com (2603:1096:400:283::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.19; Sun, 24 Aug 2025 13:55:44 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.019; Sun, 24 Aug 2025
 13:55:44 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Philipp Stanner <phasta@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sound@vger.kernel.org (open list:SOUND),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] ALSA: emu10k1: use vmalloc_array() to simplify code
Date: Sun, 24 Aug 2025 21:55:11 +0800
Message-Id: <20250824135521.590780-3-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250824135521.590780-1-rongqianfeng@vivo.com>
References: <20250824135521.590780-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0113.apcprd02.prod.outlook.com
 (2603:1096:4:92::29) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: bd31fb63-4694-4086-a979-08dde315eb68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZbIIx3ejae+ERDjrDAlkQLRGE8/7RfJlJ9NJg5F5u70GtzbtbcHiAGANf53R?=
 =?us-ascii?Q?JVOwke3YQ2yLmzMp9j4/TjZj0Y58okV4EXl+hz1/iwGjpaEKl2EBVXy5YyWT?=
 =?us-ascii?Q?Aea8+GAQcMuVSmUOjpxKpZeyHAaMnmtyYTuHVBXJ8UPD4nUOoxDVecWJtIk1?=
 =?us-ascii?Q?uqR7PRMhcBcMlPccJLL/G1p9M0MnhaHLu7yA0h69A55XUiGJ34+/Z5fHJOBx?=
 =?us-ascii?Q?HACLCJ0Fn2SukHgDXfbZ1uDGYScwJCN/Gir0dkBFbWlVt9mu3IUGz06aNee9?=
 =?us-ascii?Q?oFJwxamSrkczXxI4UaXFDrlBWEy3bn5ykO8Hf08o3T5uXgABqlL0sBzy25Y1?=
 =?us-ascii?Q?Dbm3oV9oNU7idP4ohXR3qqpPhJ3isow8xK++vcGkTMbtoZ9t40tx2fqjsWyB?=
 =?us-ascii?Q?67m+xevF+lv1kzIcAbDBYsCuB6SNJcCTM7Fa7oppW9KhswbsNlHj706izC9p?=
 =?us-ascii?Q?cc56EIEcGrG90C9GNN0aj3EgR1hQ/bi4o+AIYP20ip0hIA0c0YeOHHtNRgBw?=
 =?us-ascii?Q?Al9EmaBS+xN9SRmZj7pefSu2Eo275B/NsMBF/T0XLQ1Hrvqw+LdE2yrQFAnK?=
 =?us-ascii?Q?MSxrQeVjlex4g0/HXoEyJWN0Yu9jXASVpd/Ihl8gb5LXOg3MtegcKaKlFgdw?=
 =?us-ascii?Q?p2faCTQ95rlXP1Wuie89BJuG8DZY32ZfaypMPD48B1wPRls518gS9kcqDL9H?=
 =?us-ascii?Q?nIHGZDLkNyCHG9MqgQlEU80EDuQiNQVs66pkxWx50ROks1/ibehxXfFhNSUX?=
 =?us-ascii?Q?Z/O6vj8aAEkzepcsRirPeEQfPgDiL4EE1MgPniD5kEr2BhteEO0zilqdG8GH?=
 =?us-ascii?Q?2jOe7vtKcEfYTTI3KlxLXu9vUcK1kkozMbnp20bOLEGzRY0Oz/8r7SJQzVA0?=
 =?us-ascii?Q?UkNzgtxpxASitSi+gK5jDpRyzBzoNHWyUnpxpzgE0vNCdTflijPCQ3kuoyYV?=
 =?us-ascii?Q?efEYaqoYuKvhnYlmCauPm3rxWgEguMVujqNMgGavknEkrp20X/+jNEYj3ccH?=
 =?us-ascii?Q?30Zz3iKGaEDy+uD2ALJ7oGmDwwnnmgm/x+/9OaFrku4LhBKyj92TPWiYx0va?=
 =?us-ascii?Q?eDxHegnPvbyLhrnzmbuY8n/D9k1baFIhEslh/QgAvKb6IwgBb3Nh/dbmolIR?=
 =?us-ascii?Q?+rhDFZR8RN8FoRm0gY50jkpIo5UhioDnISJZvJYfgyfO/B/CeC/11bGJRwJo?=
 =?us-ascii?Q?zqIjCKR05ooboLVD6VAkbyz5gT9cEK3/GiNlUoIBQgiQVug2tK6/H5y6E/JK?=
 =?us-ascii?Q?Xq3DHXpeOa8gjk0q4GgX00d14zlK5M5BolGrr3EcPR08BY3mdPrx3EDCKftN?=
 =?us-ascii?Q?VjkO1qNN9UJx+rqjiGgJm++JFHnhnFw3fLBwxqhpkcf1uK3WGHdzQ17noUVt?=
 =?us-ascii?Q?leIeHpSBc2On0CnGWApBlZb4qisglLVINk7mMxpYiOV8VtytJW8G66pI9rkg?=
 =?us-ascii?Q?sVgl/oSNK2yZWJFg76bZo4Z/vVWlGDR0IkwxVTb+e2DF2QNYBZ6vxg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8y2CBUHDbUYLMCcYyK7r7+zTtXGb21HVYohu9pK94/tm/OidOJ3YhkagzqLS?=
 =?us-ascii?Q?vsYShq31nyBd5oSomfmTOZN91h4KcPKuhPn/5ZVXM1IsJXtRogMQI2xYmIBp?=
 =?us-ascii?Q?uQXJsX67mCrH3VUL+fKI2UToXfU85mM8mHC2Wn64YJxPjzzFhxgOlvQhKwRK?=
 =?us-ascii?Q?kRlr5e5nCEXnuk6gy1bnFMbaxZrY7/JxCXdKVXjO3bhplwyRiiqY36JwsUqG?=
 =?us-ascii?Q?I5Nu358ZNqNHrnlNzNqc3TxWD7lJNgmmqol5FPgQsA4C3vpMlNLtlavqdl0o?=
 =?us-ascii?Q?fcEMoHjoteboBYtfY3KuWo4j47L7jebBzX0gDgL+dpPqNvxfJDVjIoTzcfNi?=
 =?us-ascii?Q?Ti6bxf2Jo0vMvN8MMaF9vqgko3Mtnkw6fOevw+LpE0QR6jqtwbmoy92lToVF?=
 =?us-ascii?Q?uMpPGaZDLWzhKfnFKs/+NWdyCskn7JNklbgrBEyvge1zTfHm/KEIow0nyVcS?=
 =?us-ascii?Q?uYEBO0L/axkinBhj5PmOz7Qhhlzm+IKEcZa8V8h4s1TF8PjbLU3hwzduzqhc?=
 =?us-ascii?Q?yJWEIAHY0FdQkrQXik4YOpvxmRHjuon97wdIK/TmP8QZEJO6YGQKf0W5t6Y5?=
 =?us-ascii?Q?JYxXmDJChhaAY89Rb/BMTF4Yx3EYqe8kOeCkfwHBwodNoRO0WAJjJ8eGxSMU?=
 =?us-ascii?Q?Z6HrFF81R65yCAbbITK/4DeO0aESlG+y0N/9Gbw6W4SpFF7go4bXh3aJIwer?=
 =?us-ascii?Q?FFj2/+EKWiKxbzDBvMd7zjlJZGArLv42f4ohGQ0NN7uIM/93xAfxDmld3KTT?=
 =?us-ascii?Q?owNW4ABPKGKJow1pycdFdQpAT+4Y7t4/XJHCKWPK7fYwZhrs68TzDzAmvrxk?=
 =?us-ascii?Q?VYpOehaxeGl686/jrUXBNz+nT9IjdCFlCDsWKOXS/wUKBZmmKMjTPi3ezdoY?=
 =?us-ascii?Q?UyG1bJMIIgleFyo7didBXLpGr9lEZ54Sr5juZSY2I/0FFOue6aMeAYNRSLKX?=
 =?us-ascii?Q?1K5AnIBtFfDapXrzhzVjEGfobFRdrARuUFsjvxzJ87PdEvrd8aeEMym2pEIE?=
 =?us-ascii?Q?E7ojkNVnWJjs9Sfsg0pC/ULOiEDVfu6SxYsHwG19ZEyaKnAW09U9ORC2jhTc?=
 =?us-ascii?Q?ONrSwyL6Th5ubHjt+wSDVCAUsDulZXvPCbId4u+jGoOToIrL47/fFupErE84?=
 =?us-ascii?Q?UJd/h+xQIjTA/MhvaXe5Q3dlrtBsjlBpUmuYqJI5PZpQ/CE+e60EFDGYdqFx?=
 =?us-ascii?Q?lizFrOfMO0IMZ5/KQXWcB4fB35244Eunu2EDlo5TA1KICj2OQSik3qh5bHac?=
 =?us-ascii?Q?2xByfmEt0KyIzlnVjz6WI0Y+jeqp3MGncAvietjgA1oa63Sow+UWWti+kpDu?=
 =?us-ascii?Q?7fYnfUqIDPdec5pbDorXXtPuRuyLtvYmMMlJGGJayPArWSHyX4YUs1j6wxE4?=
 =?us-ascii?Q?/7lyQqYH3EALGfnMVLlH5lJ3BuY61xQv2D1q82qsJUWJu/9hvgtu1mLI5y7s?=
 =?us-ascii?Q?VqfWPCAKhmZohskxTCnHUdseAe4guNreV9ehmqQWJaSZfyNtpgV7YVDFzioT?=
 =?us-ascii?Q?bw02L3IankLGcVu/8qQnC5ERoV6LgEl1RYmjsk5zzx7pwVfKLSNMiXVmGCPZ?=
 =?us-ascii?Q?ouRWfVAaxFNwiV0i58mgP1m6WZYsTvqCVIcLAqf1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd31fb63-4694-4086-a979-08dde315eb68
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 13:55:44.1847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QlpcaZl7pQQLQKAp9bWr/MYA7irDcTty20cPcRObO8tHQUsMphExIFv4vTG/0wu6gokJUdgbm/ZK27ZS+l3esQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5685

Remove array_size() calls and replace vmalloc() with vmalloc_array() to
simplify the code and maintain consistency with existing kmalloc_array()
usage.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 sound/pci/emu10k1/emu10k1_main.c | 8 ++++----
 sound/pci/emu10k1/emufx.c        | 2 +-
 sound/pci/emu10k1/p16v.c         | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index bbe252b8916c..f6ae78956eca 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -1579,10 +1579,10 @@ int snd_emu10k1_create(struct snd_card *card,
 		(unsigned long)emu->ptb_pages.addr,
 		(unsigned long)(emu->ptb_pages.addr + emu->ptb_pages.bytes));
 
-	emu->page_ptr_table = vmalloc(array_size(sizeof(void *),
-						 emu->max_cache_pages));
-	emu->page_addr_table = vmalloc(array_size(sizeof(unsigned long),
-						  emu->max_cache_pages));
+	emu->page_ptr_table = vmalloc_array(emu->max_cache_pages,
+					    sizeof(void *));
+	emu->page_addr_table = vmalloc_array(emu->max_cache_pages,
+					     sizeof(unsigned long));
 	if (!emu->page_ptr_table || !emu->page_addr_table)
 		return -ENOMEM;
 
diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index 7db0660e6b61..130e713fe248 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -2648,7 +2648,7 @@ int snd_emu10k1_efx_alloc_pm_buffer(struct snd_emu10k1 *emu)
 	if (! emu->tram_val_saved || ! emu->tram_addr_saved)
 		return -ENOMEM;
 	len = emu->audigy ? 2 * 1024 : 2 * 512;
-	emu->saved_icode = vmalloc(array_size(len, 4));
+	emu->saved_icode = vmalloc_array(len, 4);
 	if (! emu->saved_icode)
 		return -ENOMEM;
 	return 0;
diff --git a/sound/pci/emu10k1/p16v.c b/sound/pci/emu10k1/p16v.c
index e774174d10de..ca732e6464ec 100644
--- a/sound/pci/emu10k1/p16v.c
+++ b/sound/pci/emu10k1/p16v.c
@@ -795,7 +795,7 @@ int snd_p16v_mixer(struct snd_emu10k1 *emu)
 
 int snd_p16v_alloc_pm_buffer(struct snd_emu10k1 *emu)
 {
-	emu->p16v_saved = vmalloc(array_size(NUM_CHS * 4, 0x80));
+	emu->p16v_saved = vmalloc_array(NUM_CHS * 4, 0x80);
 	if (! emu->p16v_saved)
 		return -ENOMEM;
 	return 0;
-- 
2.34.1


