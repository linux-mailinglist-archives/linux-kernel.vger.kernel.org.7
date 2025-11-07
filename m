Return-Path: <linux-kernel+bounces-889638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52412C3E1EB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 02:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0548E3AC5F3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 01:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C582F657C;
	Fri,  7 Nov 2025 01:24:15 +0000 (UTC)
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021130.outbound.protection.outlook.com [52.101.95.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75152F5A11
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 01:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762478655; cv=fail; b=jgHx8itgBPGQmoslKKHlav5rj/Y4Q1oTaNsG8bRGazQUaGshvAulTZ1+sJc0GgB2oG1bkqE62Z7+vLHkxR4iJh4Yw+ew85xKUNelbkMX4lwDhen32y5NuLPCtg7+zMYT9NPaqC93de43Yb9m6aVh6KdQr5FYunF1mbb3eBBYu2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762478655; c=relaxed/simple;
	bh=qT+naIY9eoi5X39cTl/ObimPTk5pbncI60nbWuv6HgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G5umJqlUAsWbJ3TM+LXD19OHxXrNOPHFV91Q0DXm9febL+TRmI7oEJhGl+QUnVLmpHCTc5+gjEuyR6VWtn4SlD4KSTWAczzj1ZhFzWJyWUS5Uv6n6ml7W+DtuM3tsBXn8BAA/V1OwUyF1VM0ZMcMrdCOTEdozi6oQRZ+a6/q9iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkKBxadgGuAZEFNmjeE/4y15GedNiX+oalbM5yDeOSuhHlwd2DzkWfhc0n4V+focT9Zaf/oSQEY+jwxIFTuFWC9+KEWJycH6/BrPNkFIbzkJxY1mxpk5XP5+HH+v7h/Fl0+m0GZUoms4Tn5DuJJK76GwGWeqoMln8NLJoLBv9Z14yB6LBkccZaZBOXKRLl2RwTEthIRnf9J6Bf+KhQT790+vm4+rnEnuZSBpYJdOQ03j+FF/LpmjYdlyBlk0z0f0G8CPusiYyEwLiVCvycjUrJWby31BjNxRaUIpaoAHKeimEMBMVqZVuR8cGhhz4a24Mt+8lCijaSO/9tTl1d+Txg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbAhoWEQV+IXmWLjoY/3Q82M3vnc6SAdzltOy1m69pw=;
 b=HTfUYs/ESzd+JPgm3pQXcIPmIB7NIKsWB+EAsoVUhgIl6l1nIXgxY9qJJ757FctT/okTgLjDDN7BanPsz3o9slKLUbU2+dE+Tonkc3kpveHvnU3OAbnq1V1J38gMyBKLWP4sqTelALbJyqPfXStfo2X9dkns0IaKllMU7zUlFTVkFtX9SqzMx62tXvSwx0KjaoQYe6DQTDsdNqG2uZdg/+xVI4r4e1HsRA3vNPH28sFxA53MI2cxted9wK1KgbdsMK88Xo3UNyEYuhQcPUzrWXUYX+MnPX9JeypggnLLh9kuJ4mFHrIVJR0lZVsHK7lQ22wRHFIJQZOnyGJbPL3Tcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB6922.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 01:24:10 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 01:24:10 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: tony.luck@intel.com,
	reinette.chatre@intel.com,
	Dave.Martin@arm.com,
	james.morse@arm.com,
	babu.moger@amd.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: dave.martin@arm.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface for CBM reset
Date: Thu,  6 Nov 2025 20:24:00 -0500
Message-ID: <20251107012401.224515-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107012401.224515-1-atomlin@atomlin.com>
References: <20251107012401.224515-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:408:112::13) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e77a2e5-8f54-4136-3e4e-08de1d9c5a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lf1o3naexJbEIxTYlGRMSP7nwJ9MkzY4UjmkhyVxe9nS0XK0MdNyN/U31aWK?=
 =?us-ascii?Q?d4tw7NIqLMUBP8vuZmBouxWx0eM4NJbLI3YMyQ6cFYBcNvtKozpZ4kvyekHG?=
 =?us-ascii?Q?QF2MK7pjjPkM2IvyVDaV4QN6DwTzL5cadNH53Bn0aJ/p1rJfPTFCDzHdnrRO?=
 =?us-ascii?Q?vQURGm9Cf9lh/G0ufQ8AsqD4L1sboX48GTDbTjEOaoR6L2rh5oH9IRbA6Xi7?=
 =?us-ascii?Q?tYmH5zAOtDKU5DIzXlR+zS/L3SPHl5ghJj2ZjZSttaoLeBXaB4hAstOAGQRF?=
 =?us-ascii?Q?khJ9sE4QoAklhDmNDhX276qzgbEShAVzEp8JHwE5YuNZMl/oum2PpjcerbfK?=
 =?us-ascii?Q?WEkBnrPqDoHR3nbBMlXaK6aPmuwkHrbUpzVv5pGTR/zBB+5Z6EOf6X/dejME?=
 =?us-ascii?Q?MnrLJbH/zLDjyRE5i5RZ77UEXrrQuFraYtCxzJ6e3CfZC8nrZUMieZ/td1No?=
 =?us-ascii?Q?MHwXP7ymeRvUZPO7iMWZcS5gM1ly+Yg3edrp1DazTResr61JhkZ1cOMkOiZp?=
 =?us-ascii?Q?LsSBLEKoK0lRrhSTnKdaYC1vQxu7OdUKgRZzIRW1x0BBwcm2HT48NgpeQl94?=
 =?us-ascii?Q?vVPrrb5MD5WdzTpi/cM8SVQtZq7C7qhtev2X8/LKMwA+EzmW16NwaBrsJ9LN?=
 =?us-ascii?Q?PoRBUkJ/pPwftif0QNISRu85R8rNlXGp2rSBuMKcAsTlocOeRc+UfScW9CT1?=
 =?us-ascii?Q?bN5zLbzAZTv3Ejmo1aQ3pecvaZtWYBnuDvhQ/YG5B3B1rIJOvp7YxQOP3dGS?=
 =?us-ascii?Q?PVSVGXRhJupa7/CyUkUdNjPTUs4xLOJvuoNhljQJCMGITQhaBTSU2TNKZYLm?=
 =?us-ascii?Q?VREclnPXIL4jQhUBddtFVQxUQbvknJnWPZxL4+XLGDA4dJl5kTQzBuFAC0+r?=
 =?us-ascii?Q?WJpxI9f4S+4Beg3rxnr07VJQoxZt/tAGRC/fuJJR9Z5Ca/CYDPej+4QVDVuX?=
 =?us-ascii?Q?/YhNpQiWTvjU+gDJxdEbP2YPmGha/uSQ11iCrH/0x3Gp5h8AHeFBlqoXU7M+?=
 =?us-ascii?Q?JnH0pXxFKlJhj/38oqwsfHH1+uEgZr5dErNSccsSef8lYkDJckcTcPnFedeF?=
 =?us-ascii?Q?QioJq2AJ1uIIrPPwmMMf8erbhsqy+Ayplp1KSuS1PzeBfbAjnyGH5SgVaByD?=
 =?us-ascii?Q?6Dsu+okD/CdVXY3/8iKPDBC1rUCsMMzMZZIOCQCUCNjtMKMOnILusx2UROTl?=
 =?us-ascii?Q?dNNh5PcKiUcs0niXMNsfI2VaU33PVr4A5Zo+4W3Ag11ER+d+qKqAXXBHNfWv?=
 =?us-ascii?Q?8BOp+XT/P3yOUeiKuy4SEvOpg7t0qHe8NCawsp4c9u1ddI6nb3ZNX/IDqL+7?=
 =?us-ascii?Q?xxGAeesQW3JXzxhDDOTZhsjiBtUfq7nFiYLOdeeBSFVaSlF1cGC7QKzkgvlq?=
 =?us-ascii?Q?dn3NzYtWbaC+2UryZWoqjl+R+OMMHSOChYFuUd9u5LKk5EPY8Fc6/ITqiop3?=
 =?us-ascii?Q?UCZD7VD9z2bZxpVtX2kNR5Y7wSt1xpDA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ov4pM4V7Dm8iizRI+Wm4914Xa/RncURAK+XyN4oSe9hcp68jWrhcJ6pHumyr?=
 =?us-ascii?Q?I2BvZORVYvb0jgMv2rpex0c7hcw8DBQCGuJ42qWSqNdrn/V6BO2huwWjvdad?=
 =?us-ascii?Q?Nae+ps7S5Sc+VUAe/x7U2wP9N+Vi5Bmba6flVTlnzAP01ooOoHHhntwd9NHj?=
 =?us-ascii?Q?2JAlqRemj6KI8q6Ehq2sRW1htzG3IBebj0xKU3LuWPbgM0pTJiMgVErowDtC?=
 =?us-ascii?Q?EbNJpQE1YK4qeW9NfQjBJAex7HCIunYIaPreMb53veUpcgpCU30jpgk1zl50?=
 =?us-ascii?Q?wqEXz5GUyaBpYj6mxdOWjIo+T8Wc+uliCv4IlbAmrGYpd685IChy2DLhNzI+?=
 =?us-ascii?Q?eErnRcqT4R1SL7d65RWmPccmefLwWWS8hLdfoCNsNN9udfXvksJlwcDpUP45?=
 =?us-ascii?Q?vullabsfWjFMcrl0Qe+9i+YgWDykommv/iPcynU48j8CSp8nNE/j8GjCBy2K?=
 =?us-ascii?Q?2NG7J91JZuzwo7H2ZT+pMC2mEKfRDoKp23DYO+h/yMQEkipsnby4TM35qXq5?=
 =?us-ascii?Q?I+tlL+KjHZSJR4E0M8TM5/7VfYohWo/6jwvJ7+m7raoZMaDBmNV1Il/h9NEz?=
 =?us-ascii?Q?4Y62qoKi/29ZuSk/ygVUbGlMTcAkBtoyQ7d0OE8kW+CR72lS/E8Ors28DHUy?=
 =?us-ascii?Q?znH2akj8DeXkvyKrpg9wsdlrW+MoDE93s7kYuxqc/AiIsALj1KeoESao+dMX?=
 =?us-ascii?Q?o6yhy6JB97qVSdD0eyFhu5GRiFFLmLPfLDUKELqwrQ65JIoY+Ig5yN9lAG+Q?=
 =?us-ascii?Q?BeTkLzCVU5wWakuyMM/cuu20C2iJGggMIDiwCn7jKyQbB8wZcZPcDbfOwcRE?=
 =?us-ascii?Q?geEh/8xTGcU8/d+x2WXjBzUOelSgz1uI3OaMUNpgX6hXpMTqXY30qlaPXWID?=
 =?us-ascii?Q?lfZc0u9GMArnkM1IWrf39T8wkRUnuGC88bflW+7cnk112Pj+/DmC1/e7bfPR?=
 =?us-ascii?Q?N+YCx8NztOGLao3/okMPBB/WW7/NIWvxeSLwChy2HdvF/iLkd9I0cY2CKUee?=
 =?us-ascii?Q?5jyJUVNA+Qec6tGz3iHOP1XNlBYlUxLNk05XK41wUpNxhJzny2TR4xJzH5UD?=
 =?us-ascii?Q?+RkKto/ZrS1c0wbmfFMcvWOdALcIr5SuxpTWZBV0KjSvQ+136Z5FCIbzFjSo?=
 =?us-ascii?Q?o4CAjbnu5Ri8VLDL9KtomNaWAYvPrx7n9skYeXuYq1lj5whacCr0g3K4F6tW?=
 =?us-ascii?Q?jGB9awQqbt/BrHEC/uL+790HeybqQ8yhhjv/s4WITt8qe0LEGW6uTLpSOhQM?=
 =?us-ascii?Q?7136IQM9rCegUo1w1p/Heqg6QdyUSWGa3wWZzUl6EXkLW0mXyhj8DDif6qYb?=
 =?us-ascii?Q?CAPgxZ6/OtyjXo8A7ooFBG7YkiiVg0WSiWJG5xnQimBtU4YgBUn//rpZ6oYs?=
 =?us-ascii?Q?JPDZb7ZhYUPbn5wYQbXlg2OwXcME47KivsLp4GF8QF6pMegElbdxFaHw5ulo?=
 =?us-ascii?Q?no/NxatJ8jIkyPmlRwvIeM6guqRE6402Kr2vU7Tk6vhodGjlzpMwd1TJO08W?=
 =?us-ascii?Q?fHJEXX75b0riN1DTdanxh7wFw3HXjKe1bF4TFKWMwxbzRNA/+fpoJ3F86Jju?=
 =?us-ascii?Q?kzAwRWC7cm8PJbMTUWNk/DBCXAl7VbsJLAhL4BCn?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e77a2e5-8f54-4136-3e4e-08de1d9c5a7c
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 01:24:10.5804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P84rdnPTNwFvJTkEJi7gC+MLZA2mkrCyVju8RLE+72VGMnVnbKrIRwW+AtdOVeDdHfrD6jSBK3ceM0bCfpBlbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6922

This patch introduces the new resctrl interface file "io_alloc_min_cbm_all"
to provide users with a clean mechanism to reset all I/O allocation CBMs
(Cache-Block Masks) to their minimum configuration.

Writing '0' to this file triggers the logic to set each corresponding CBM
to the minimum number of consecutive bits (effectively clearing them to 0
or their smallest supported mask). This simplifies the process of clearing
or resetting the I/O allocation state without requiring manual CBM string
calculations and eliminating the need for multiple writes to "io_alloc_cbm".

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 Documentation/filesystems/resctrl.rst     |  13 +++
 arch/x86/kernel/cpu/resctrl/core.c        |   2 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  23 +++--
 fs/resctrl/ctrlmondata.c                  | 117 ++++++++++++++++++----
 fs/resctrl/internal.h                     |   3 +
 fs/resctrl/rdtgroup.c                     |  10 +-
 include/linux/resctrl.h                   |  30 +++++-
 7 files changed, 165 insertions(+), 33 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index ccc425b65b27..9899bc716459 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -213,6 +213,19 @@ related to allocation:
 		written to /sys/fs/resctrl/info/L3DATA/io_alloc_cbm may be reflected by
 		/sys/fs/resctrl/info/L3CODE/io_alloc_cbm and vice versa.
 
+"io_alloc_min_cbm_all":
+		Set each CBM to their minimum number of consecutive bits.
+
+		Example::
+
+			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
+			0=ffff;1=00ff
+
+			# echo 0 > /sys/fs/resctrl/info/L3/io_alloc_min_cbm_all
+
+			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
+			0=0;1=0
+
 Memory bandwidth(MB) subdirectory contains the following files
 with respect to allocation:
 
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 3792ab4819dc..44aea6b534e0 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -276,7 +276,7 @@ static void rdt_get_cdp_config(int level)
 
 static void rdt_set_io_alloc_capable(struct rdt_resource *r)
 {
-	r->cache.io_alloc_capable = true;
+	r->cache.io_alloc.io_alloc_capable = true;
 }
 
 static void rdt_get_cdp_l3_config(void)
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index b20e705606b8..0f051d848422 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -57,14 +57,19 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 		hw_dom = resctrl_to_arch_ctrl_dom(d);
 		msr_param.res = NULL;
 		for (t = 0; t < CDP_NUM_TYPES; t++) {
-			cfg = &hw_dom->d_resctrl.staged_config[t];
-			if (!cfg->have_new_ctrl)
-				continue;
-
-			idx = resctrl_get_config_index(closid, t);
-			if (cfg->new_ctrl == hw_dom->ctrl_val[idx])
-				continue;
-			hw_dom->ctrl_val[idx] = cfg->new_ctrl;
+			if (resctrl_should_io_alloc_min_cbm(r)) {
+				idx = resctrl_get_config_index(closid, t);
+				hw_dom->ctrl_val[idx] = apply_io_alloc_min_cbm(r);
+			} else {
+				cfg = &hw_dom->d_resctrl.staged_config[t];
+				if (!cfg->have_new_ctrl)
+					continue;
+
+				idx = resctrl_get_config_index(closid, t);
+				if (cfg->new_ctrl == hw_dom->ctrl_val[idx])
+					continue;
+				hw_dom->ctrl_val[idx] = cfg->new_ctrl;
+			}
 
 			if (!msr_param.res) {
 				msr_param.low = idx;
@@ -123,7 +128,7 @@ int resctrl_arch_io_alloc_enable(struct rdt_resource *r, bool enable)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
-	if (hw_res->r_resctrl.cache.io_alloc_capable &&
+	if (hw_res->r_resctrl.cache.io_alloc.io_alloc_capable &&
 	    hw_res->sdciae_enabled != enable) {
 		_resctrl_sdciae_enable(r, enable);
 		hw_res->sdciae_enabled = enable;
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index b2d178d3556e..6cbf4cfaf974 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -688,7 +688,7 @@ int resctrl_io_alloc_show(struct kernfs_open_file *of, struct seq_file *seq, voi
 
 	mutex_lock(&rdtgroup_mutex);
 
-	if (r->cache.io_alloc_capable) {
+	if (r->cache.io_alloc.io_alloc_capable) {
 		if (resctrl_arch_get_io_alloc_enabled(r))
 			seq_puts(seq, "enabled\n");
 		else
@@ -758,6 +758,50 @@ u32 resctrl_io_alloc_closid(struct rdt_resource *r)
 		return resctrl_arch_get_num_closid(r) - 1;
 }
 
+/*
+ * check_io_alloc_support() - Establish if io_alloc is supported
+ *
+ * @s: resctrl resource schema.
+ *
+ * This function must be called under the cpu hotplug lock
+ * and rdtgroup mutex
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+static int check_io_alloc_support(struct resctrl_schema *s)
+{
+	struct rdt_resource *r = s->res;
+
+	if (!r->cache.io_alloc.io_alloc_capable) {
+		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+/*
+ * check_io_alloc_enabled() - Establish if io_alloc is enabled
+ *
+ * @s: resctrl resource schema
+ *
+ * This function must be called under the cpu hotplug lock
+ * and rdtgroup mutex
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+static int check_io_alloc_enabled(struct resctrl_schema *s)
+{
+	struct rdt_resource *r = s->res;
+
+	if (!resctrl_arch_get_io_alloc_enabled(r)) {
+		rdt_last_cmd_printf("io_alloc is not enabled on %s\n", s->name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
 			       size_t nbytes, loff_t off)
 {
@@ -777,11 +821,9 @@ ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
 
 	rdt_last_cmd_clear();
 
-	if (!r->cache.io_alloc_capable) {
-		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
-		ret = -ENODEV;
+	ret = check_io_alloc_support(s);
+	if (ret)
 		goto out_unlock;
-	}
 
 	/* If the feature is already up to date, no action is needed. */
 	if (resctrl_arch_get_io_alloc_enabled(r) == enable)
@@ -828,6 +870,47 @@ ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
 	return ret ?: nbytes;
 }
 
+ssize_t resctrl_io_alloc_cbm_min_write(struct kernfs_open_file *of, char *buf,
+				       size_t nbytes, loff_t off)
+{
+	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r = s->res;
+	bool reset;
+	u32 io_alloc_closid;
+	int ret;
+
+	ret = kstrtobool(buf, &reset);
+	if (ret)
+		return ret;
+	if (reset)
+		return -EINVAL;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	ret = check_io_alloc_support(s);
+	if (ret)
+		goto out_unlock;
+
+	ret = check_io_alloc_enabled(s);
+	if (ret)
+		goto out_unlock;
+
+	r->cache.io_alloc.io_alloc_min_cbm = true;
+
+	io_alloc_closid = resctrl_io_alloc_closid(r);
+	ret = resctrl_arch_update_domains(r, io_alloc_closid);
+
+	r->cache.io_alloc.io_alloc_min_cbm = false;
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
+
 int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq, void *v)
 {
 	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
@@ -839,17 +922,13 @@ int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq,
 
 	rdt_last_cmd_clear();
 
-	if (!r->cache.io_alloc_capable) {
-		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
-		ret = -ENODEV;
+	ret = check_io_alloc_support(s);
+	if (ret)
 		goto out_unlock;
-	}
 
-	if (!resctrl_arch_get_io_alloc_enabled(r)) {
-		rdt_last_cmd_printf("io_alloc is not enabled on %s\n", s->name);
-		ret = -EINVAL;
+	ret = check_io_alloc_enabled(s);
+	if (ret)
 		goto out_unlock;
-	}
 
 	/*
 	 * When CDP is enabled, the CBMs of the highest CLOSID of CDP_CODE and
@@ -928,17 +1007,13 @@ ssize_t resctrl_io_alloc_cbm_write(struct kernfs_open_file *of, char *buf,
 	mutex_lock(&rdtgroup_mutex);
 	rdt_last_cmd_clear();
 
-	if (!r->cache.io_alloc_capable) {
-		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
-		ret = -ENODEV;
+	ret = check_io_alloc_support(s);
+	if (ret)
 		goto out_unlock;
-	}
 
-	if (!resctrl_arch_get_io_alloc_enabled(r)) {
-		rdt_last_cmd_printf("io_alloc is not enabled on %s\n", s->name);
-		ret = -EINVAL;
+	ret = check_io_alloc_enabled(s);
+	if (ret)
 		goto out_unlock;
-	}
 
 	io_alloc_closid = resctrl_io_alloc_closid(r);
 
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index bff4a54ae333..f50f1ab562b0 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -442,6 +442,9 @@ int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq,
 			      void *v);
 ssize_t resctrl_io_alloc_cbm_write(struct kernfs_open_file *of, char *buf,
 				   size_t nbytes, loff_t off);
+ssize_t resctrl_io_alloc_cbm_min_write(struct kernfs_open_file *of, char *buf,
+				       size_t nbytes, loff_t off);
+
 u32 resctrl_io_alloc_closid(struct rdt_resource *r);
 
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index ea320dcf8aba..bd41ab5a8eb4 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1995,6 +1995,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= resctrl_io_alloc_cbm_show,
 		.write		= resctrl_io_alloc_cbm_write,
 	},
+	{
+		.name		= "io_alloc_min_cbm_all",
+		.mode		= 0644,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.write		= resctrl_io_alloc_cbm_min_write,
+	},
 	{
 		.name		= "max_threshold_occupancy",
 		.mode		= 0644,
@@ -2195,11 +2201,13 @@ static void io_alloc_init(void)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 
-	if (r->cache.io_alloc_capable) {
+	if (r->cache.io_alloc.io_alloc_capable) {
 		resctrl_file_fflags_init("io_alloc", RFTYPE_CTRL_INFO |
 					 RFTYPE_RES_CACHE);
 		resctrl_file_fflags_init("io_alloc_cbm",
 					 RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE);
+		resctrl_file_fflags_init("io_alloc_min_cbm_all",
+					 RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE);
 	}
 }
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 54701668b3df..7987d458ebf8 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -215,7 +215,10 @@ struct resctrl_cache {
 	unsigned int	shareable_bits;
 	bool		arch_has_sparse_bitmasks;
 	bool		arch_has_per_cpu_cfg;
-	bool		io_alloc_capable;
+	struct {
+		bool	io_alloc_capable;
+		bool	io_alloc_min_cbm;
+	} io_alloc;
 };
 
 /**
@@ -415,6 +418,31 @@ static inline bool resctrl_is_mbm_event(enum resctrl_event_id eventid)
 		eventid <= QOS_L3_MBM_LOCAL_EVENT_ID);
 }
 
+/*
+ * apply_io_alloc_min_cbm() - Apply minimum io_alloc CBM
+ *
+ * @r: resctrl resource
+ *
+ * Return: Minimum number of consecutive io_alloc CBM bits to be set.
+ */
+static inline u32 apply_io_alloc_min_cbm(struct rdt_resource *r)
+{
+	return r->cache.min_cbm_bits;
+}
+
+/*
+ * resctrl_should_io_alloc_min_cbm() - Should the minimum io_alloc
+ *				       CBM be applied
+ * @r: resctrl resource
+ *
+ * Return: True if the minimum number of consecutive
+ * bits to be set in the io_alloc CBM should be applied.
+ */
+static inline bool resctrl_should_io_alloc_min_cbm(struct rdt_resource *r)
+{
+	return r->cache.io_alloc.io_alloc_min_cbm;
+}
+
 u32 resctrl_get_mon_evt_cfg(enum resctrl_event_id eventid);
 
 /* Iterate over all memory bandwidth events */
-- 
2.51.0


