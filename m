Return-Path: <linux-kernel+bounces-848938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8BABCEDB3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1754B1A61EE6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 01:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C7213959D;
	Sat, 11 Oct 2025 01:18:46 +0000 (UTC)
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020096.outbound.protection.outlook.com [52.101.196.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37158635D
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760145525; cv=fail; b=k7Da9FyqgtqEsx1lIEr0f5Am9sOBOcyRutcEeteR4ju/Y75YS0LLoqRlbafyFscjFb5MPF/47kIZTWkY0NZyFdokjjEWfWO2e8mZN6e4NuNeGcQYz+5w+ozbXgGYwfzwZvNjrrvQIJyQzmAI7xFmTxmo5DYHlDOIrf8FpfRZYhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760145525; c=relaxed/simple;
	bh=UrOD97PtOQ1cDzBXfX0SE3fQ04W6g5nkZ7GJbVw+ALA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HOI8px5JVRFO74A9ZxlR9mpKGbInd/QCvjjfxv2JrUaGHoBz7YFScMrGJUWgNLn4/0BPqpn64Y4xk2FDEY48xEpPjHtRyvb6D6tkUNYzXH2x2mVt94FKZPkZpJnp8iBGOjxPF+hbXtBGL/Zx3nSctqBVINn2NGToPyk76+umyEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHxc2OygGcVciUZnPWpoOWnpaaZqG4OZPDIp3QBk791RxDxNaDIy4OPcDAa7H+onOoXmxTRC0xujq0fw5apQs20Wymi0qfzWtoYRGd/kqOeBP42hxciZEqVqbXFlfm6uUqwxzJDs/4E2nMSnNBvPfzSAj1ioM3ErlsHbzAxn1Ak1ZUsr0RpqBcRMlsVa/xe0pdgWtTZ06ogXf6FmeiGa2DTKipcI/TTAjUBN20woCv9J0IW8GQ9HEv8Fayoeou/EeA1qP7tQQobxg1mrKEg6ihvW8L/XwnnaqNKoCHe8a6SeUJVaEMesktzuAy3gLF9cIChk5O1utz0irrLBQFyeWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTilEALh/V76cCeF1sah6FzaE9ebsA1Mme/L11vgoko=;
 b=GUM1Fh44rqW/CspC05XaHDSf/f3qmXqG3O16nBhfGrmjeTZiobf2Vn79qX2XWGmDeAm0ci9PdgeT5b9np5JP26g1XmHFO4wKgFkWff5NNvUbvWAGdNdqYvfhtvvLKMe7CFm4vpS8giHqdh2Al7ku+Bd1IEQSfvJV7OsAM8FQMXzLj06r/QGnCy1/plmecUD43ROMb6K14QP1zFqZExPfKzgvFQde9R6lVPcD5/qVh7E1rFcRvPQIW9RruercBBmIq6Z+D9K0o9O3pSEi6mSDsW2ZB+q5uJ+NJTzSLjSoMqxpv4VN+QUq7qD6DC94Sgy5FUPgaJrB3L+k209je++DHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB7766.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 01:18:41 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 01:18:41 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: gregkh@linuxfoundation.org,
	nathan@kernel.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: riel@surriel.com,
	frederic@kernel.org,
	atomlin@atomlin.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] sysfs/cpu: Use DEVICE_ATTR_RO for nohz_full attribute
Date: Fri, 10 Oct 2025 21:18:29 -0400
Message-ID: <20251011011830.6670-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251011011830.6670-1-atomlin@atomlin.com>
References: <20251011011830.6670-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::25) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a3619f-c34f-4b35-7c39-08de08641cb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9S+DwR6JYP70ftI8mQYmmbGrzBVPzuZ4Vj/rnObXxKcWQQlVwkGC4ogBpM6X?=
 =?us-ascii?Q?1m6uD6bB1A+NIXtOg1dQLQSBElj+jdZQxrbSMxPDiY+X+j4iEwhTtPzOss+5?=
 =?us-ascii?Q?UTjStZaoG7+u5Sux+FHSUa9xUqvXDCX9n/R0HQOabv3Y/DFvCrWmUpDdHmHS?=
 =?us-ascii?Q?cea0g9Ucyp0XgvHdqO06mloGKxUc//gNV8oQm3R1MMwSwuDOBam6eHoyof9C?=
 =?us-ascii?Q?J/ciXqYW4WxBXMmCS83q7HdAFS3IicMlpF6vKSeJJn+llSSKnPl+N7geJXAL?=
 =?us-ascii?Q?c7rvoXb9CCNhQ9Pa/JAHSVV+jQzXOcyow0US2smFlNe3ZYqugJtkg8NaOr8Y?=
 =?us-ascii?Q?vga+BlUFiuD31kynnZOfvwa3VJkZlcCr9yrmODtDB3ZQLptyY0ueoZfHyRab?=
 =?us-ascii?Q?2jNQiI7mXbTsJvVyl+EAAkbxATQfoSitih8+t5vNZTYha22ZEISexp6dv7Vv?=
 =?us-ascii?Q?rC+9+mXqPE4B9Hxhw/QQdSrdxjPfyvMoWUObBlzf6o4rG/hkyr11XqQmrFYx?=
 =?us-ascii?Q?/A2caE9mLqMStwsdkBVDkuF8Dz48BUOmnxQvY5LCpQ+GY8mDJ4MVkeUZcbGN?=
 =?us-ascii?Q?ZvZO7KCj3RGgQjezn3M8F6T+UK3CTk6/PQN3W4WZOf13ZZsK9k++XkGxlq78?=
 =?us-ascii?Q?E/DEqc5+OfXZvJ1oyIstWwQwlJB1MnuKxEWqghLVaW0Sdmk/BUQd43MHPzjX?=
 =?us-ascii?Q?e2Uq0aGjf4l7c2F51Y4DlmbX1wJi/7CDfGaWII/pW4CPH01zYPftY/lFLiDF?=
 =?us-ascii?Q?XVvr3EyarPE3E/3xwBuksq3cKypIeXQXa+wDtb+6xv2CLgr05lQH2iG+3n2s?=
 =?us-ascii?Q?if70nEz456jsX5X24lguAjUgMeFIAM1xPshZspI8lcjeedQsUCYJVBkxU0gB?=
 =?us-ascii?Q?Is+gJy7nnuiDdLj6lTPHi2QxFtWvTe9b5vlioX+5zuNUffzA1ljgpZj9QDon?=
 =?us-ascii?Q?U2Ssb36I3VKwEK5QHeApH/Qmc4ide46Rd0urwmFz+g+4WDGlJmqfhnvtWEpo?=
 =?us-ascii?Q?65GfNUk7ZbwDBu3MokaupTqsNVUwc9ff2UIayzYG3mNb8oSHShHKJ3lLah6E?=
 =?us-ascii?Q?rQ0FCcw49QNMDVnDkpmJGgDv4s1G7mU09HwBVe62TL1WFpbjpW4oz3dsG7u9?=
 =?us-ascii?Q?7Hrzw+BIdg3m/pL6XYkB+jCYr0jA6qbnObSjoBKAz4jlwNooP08M0TGZWDfz?=
 =?us-ascii?Q?qwPbEwSA1+cRcshu9ytkruqCPTsVw1ls10xYxTcOrlPdlQrVle9UEapyLeKx?=
 =?us-ascii?Q?tx0sAnmsebOXh+K8MDL69C5cpvDLPd/wr2pSEqngYSfcij5JLF3j4bJ3xksp?=
 =?us-ascii?Q?uKu2AXmYBokUmuelxRUq3nwDvWAyQQZr7WFKODGkggvKVjtUUqo2GqF0dYTE?=
 =?us-ascii?Q?S6abf9vsr3P5KO4XovEfO2XdlDWyaUlAe9zd7rS0mCyP3Omhdc9NV4OLFxVG?=
 =?us-ascii?Q?Iy2uTTEsbWgreTXTRNNiVpqlNeOJHwrD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qe8RUqawiEfrWt1X6PkN42Cy76+d1CJcth1TDPn8DsaKIQgw2152d9DDF8cA?=
 =?us-ascii?Q?3m5HTkAllFUNtEhAVMb8Ay8deVZb7YjeUbUN3NulnJxn0/BrQUrowsSMz0pr?=
 =?us-ascii?Q?pPBiiXjmWHMEb144ftu/AOE08w0wFBCfCqgBiu/zWzFWjj6u8qN1gB8+st6P?=
 =?us-ascii?Q?ySulhzArdIOhjp4XQ2MM42WGLVuIB8z4w5yba1RpNIOwlRxqQsr4FJawUGjf?=
 =?us-ascii?Q?iw33pjjKdiwkdH8XU6FJjveJav/JXbhvf6PGRZvjHCZZhSPBIXMJJlNwRfjC?=
 =?us-ascii?Q?Qyi3vcZatqHDq5/SVIBhtB34sNmf1B4J22qnPjEvuJ4FehQ2Q1DvtdkiSD2N?=
 =?us-ascii?Q?rmChrApp33dbztEqE3DnuK54A+m/bK7mmTarJ0K6UP9MIqonFOVxSm53AKhY?=
 =?us-ascii?Q?oreQNdl3HOkFkUNP2ik36Vj13h5LJ0xt2BIqWj0AdnrD7LvRttkSf9AkRwF5?=
 =?us-ascii?Q?Be7/N1eysN24JZhRLQhZWJDWAFfkHVigjUYXkSYd+7fo2nDuH4qifWp+RDPZ?=
 =?us-ascii?Q?B//SMDR2FylbZlrS3zQHstVr8nvUJTKVN8t7obGHL0Z5YKru0zIpc9NuCQUA?=
 =?us-ascii?Q?ZMLLH2EOSPLeAX2F33Bqka7ISAeuqaOBDU9+656H0eMFDqoJEwlOqRAbhRKk?=
 =?us-ascii?Q?lFRZZumlrKyJyEt3O4apBPXc0drfAJzXyZP0/uPC9fZ8NwbuYXkqAzQs5XLB?=
 =?us-ascii?Q?cJi7JDffq94k9aP0BlYrsvtCqFkEv7aiRXW4G6ZJHdkkQmC9ABsQ/6fn9IKH?=
 =?us-ascii?Q?6GTSTBlkWn/s5qS/t+UK2dDusp8FdLiT7i2X/TE+d5oTgirHniumAmzaECyU?=
 =?us-ascii?Q?3G2F/WRYUHVcKzlUGAkHZalD7sKAd4nnl0vmNYfiP2c21yNWsTaezMAce3NB?=
 =?us-ascii?Q?TbNyHQyb5VsSEfAILG2rGPvm6kBtzYwgCbbLGnspuW5nH2XWucM6vXVH/kDA?=
 =?us-ascii?Q?D27E15VGuoJad/oO3RAVqBLRouVQQa7ikP+60WMN+ULLouClX+o9xJKUSlvn?=
 =?us-ascii?Q?ujHEgFGFCDE4vzOon65YqI0RshhOrcalBRS2YjS4M6nGmkqPXbO5FBWcGv3L?=
 =?us-ascii?Q?GCjKNztXFZ/9slzUM6oHV2+qhcrH0w9ROpTqWIhBp6ekojHKVamHgU/Dcmwt?=
 =?us-ascii?Q?6Fgb1hESWOiFt+sfBvwT9IELwJGowkLaI7Pqx0w2ydGhRYdbSOMzDuBZ07BK?=
 =?us-ascii?Q?mSIPgzivfeMZdx62MSd4tyYcdSbq0UnRKR6hO3k1SlH4+CrjqEcHwDxigtAc?=
 =?us-ascii?Q?E2BDuLZcJJHxb9QjcjkSLdgnG0XHvLfgzOL9goIhL+d97NK9rJ8+TsBiO/dT?=
 =?us-ascii?Q?kCr6e579Y8ndp1415OcaoGjYHnZy6a+0LpREdx8ikAgQT2vcDJpsfQJX8pqD?=
 =?us-ascii?Q?25LjhuiE7ZdGe+gL0puUSI7DfBx6iwF/o7djrRQ/jPUecxHy+s/4CSrW7z/Q?=
 =?us-ascii?Q?N+ZZSIPeL6xtEMrVpGiTxGRBxMxse1qzGeeSM9k1uhoIBoDpLl0pS5gubv5I?=
 =?us-ascii?Q?+SPFg/VQDtC+BOXTlBZWy1b44qVl+E9TGFNZuIQmGtd1BUk9YfbnGs1+u034?=
 =?us-ascii?Q?lrkYvuPR8FU8ac7adykL7fk67CxrEzeuO++adlOB?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a3619f-c34f-4b35-7c39-08de08641cb7
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 01:18:41.5225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCKQiX0PgGOcoqSXa8CWLC6H5BOQMoIy1CzoVBBZOk+SN92vGeuIg9EOqUxf62n/xNH0yxtaH4trA3ibi9aRHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7766

The /sys/devices/system/cpu/nohz_full file is a read-only attribute that
reports the CPUs configured for tickless operation (CONFIG_NO_HZ_FULL=y).

The current definition uses the generic DEVICE_ATTR macro, which
unnecessarily requires specifying the file mode (0444) and a NULL
store operation pointer.

This patch converts the definition to use the dedicated DEVICE_ATTR_RO
macro. This correctly expresses the read-only nature of the attribute,
removes the redundant mode field, and simplifies the code. As a related
cleanup, rename the show function from print_cpus_nohz_full() to the
standard nohz_full_show() for consistency with common sysfs attribute
naming conventions.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 drivers/base/cpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index fa0a2eef93ac..c792ec66462d 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -301,12 +301,13 @@ static ssize_t print_cpus_isolated(struct device *dev,
 static DEVICE_ATTR(isolated, 0444, print_cpus_isolated, NULL);
 
 #ifdef CONFIG_NO_HZ_FULL
-static ssize_t print_cpus_nohz_full(struct device *dev,
-				    struct device_attribute *attr, char *buf)
+static ssize_t nohz_full_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
 {
 	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
 }
-static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
+static DEVICE_ATTR_RO(nohz_full);
 #endif
 
 #ifdef CONFIG_CRASH_HOTPLUG
-- 
2.49.0


