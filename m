Return-Path: <linux-kernel+bounces-773579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5404DB2A1AD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3520C7A9DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E883218BE;
	Mon, 18 Aug 2025 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="UIWhYVaM"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012061.outbound.protection.outlook.com [52.101.126.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD073218B9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520548; cv=fail; b=DrFr+A0gKocdYLHwIPeH6rIVsXBNXmQANyNwzh7KEg8+UbKNZYBgSeOGCrI8irHfjzfv6oM39loaEoBgffoAQlXYOMQzqxNYjb/GjcBNwcJ2JgFoahCI2xU0YcM0hW3rg6KCDjP6/AHCQebrCcthr79ejq0O35fo8t7jv1PBNG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520548; c=relaxed/simple;
	bh=Oq/O/4jf32/X3Fg7Z3P9pePt2sfqm9iY0zUe/M1jTFg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DuhZiXq2G00oX9e2b6gqrvZfZ0J7GFCkgaO/HHdf1NVZUGepHwKwuqU0POHgMrGq9OWeiJDOt2vccUXL/Ec65BckLVxAScm08AKZOZaf6mnlQ7V6iTFUjDnVlZPrage6EtbIF8hTsgubR1giellaK+dvR7yV8DuN1k9Y2yAzNCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=UIWhYVaM; arc=fail smtp.client-ip=52.101.126.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZyNg/yfxUVjcU5tmReaBSqatYxOV99C79hS5wLL/KzbMdJWIzm0mB0WjA4Miv0MrsfZikHwEaQkd+9NMWlSg8WUsEuLpATWNCcudUxsHLAI8KkvdKG6y1hv/8QHK7uSunKbIsMS+4oqHLm5Opb6toyMZCxpOWaIOnBANuAkOLZa+VGLBVPwnTtfTvHQZ3oJG6Tef3IDSLUwtzDNc2MiCsYtu7F1C9JBAAISC+uRHpldNGsplJ6cXOisSCDY7SNnXCA/0EHF0TOCXFc/I1jb4sbYLYYbKJH3wn2HuWcaPlIbHaXx8BTpf86wsRtXTZ8grRnr1w9csWChvzC0ikS4uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5E/qitFlTG4esKCBNTyg8NLlNbrhdI1l9GM3EBl3+N0=;
 b=JwdNcOlg25CtijbnOT92xD7VIPRq2xkVg1DAxJevZ4bZGaALB0QoAgOMD5Sx3ReaUXPlojLrp9h6Ox+CsGfXBwvvV0pyFA81GEk1T2hyaON4U0/2uLZmYNM84Ap9zjZtslITNt8+F9K1RzK06IW7L5z3bkck1kVOcfTT++aiSQ9AM5C6bHI4baoGIf2GZeKuGaXsaZqQ21eKrCWP/38q13LyI4nYNj7feJvY9ezLIpsPUchUFmBhBfjzoHHCq+tFmyG6bKk3w9LBjjX0EOECFQGV3jYWkX6xLJufABFn33EDGmEL7Z51D2x12Ec0UFLpTvIo+NyAtcmzJIDljQPE5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E/qitFlTG4esKCBNTyg8NLlNbrhdI1l9GM3EBl3+N0=;
 b=UIWhYVaMYbkFioZJq55qqFj0mtL/uAW7L5BGC5JTRK1dDVNO6oWE2Ut9K0cxwyObmDYAlEYE6K0LZeVC9/eaVb+afpJJxo2j/2WHu9JLR7RQNalVjRzyd8v6RWuqnQz0YJef8ws3BkNG2rQrXvCBrUneXPQPviaWV0zhKyg7Q761Okx4FEip4KqiHFilPWas9aAm8ASqhnfB2xuCmASREOah4QZspxDw9hiDH5dOIXzLNdlZgmTPWa3mWEMxAxDnCXTUG4EwEgJ8XvCnd5Vyf13q66GtOgnFlZprG6KkgcgtrNwN/GVrX+VOenX0IjkPmPSqXnemA/9N+zx+GLK5wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TY0PR06MB5379.apcprd06.prod.outlook.com (2603:1096:400:216::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 12:35:42 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 12:35:42 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brian Gerst <brgerst@gmail.com>,
	Coiby Xu <coxu@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] x86/crash: Remove redundant 0 value initialization
Date: Mon, 18 Aug 2025 20:35:28 +0800
Message-Id: <20250818123530.635234-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TY0PR06MB5379:EE_
X-MS-Office365-Filtering-Correlation-Id: 1795bbf6-b793-4c60-dc93-08ddde53beda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|52116014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jQ5QsK00YXQdKiMkFSfdomBeplYL52MtNUybU4Vku+gLXza95OptccjHpYaA?=
 =?us-ascii?Q?vl5jQ2vtYQft/WP+DY5tbgysEh4q05wBC3oW+KBlBACfARVA7fATcxs/wugQ?=
 =?us-ascii?Q?5hbJAx8ICdcw+rx4WpJiBmE5A1uyrwyykhYgHBC+p5fTdcM4eHoG+YaGLELr?=
 =?us-ascii?Q?KkZvEziWK6IwpI1nqHwGDFKGlGu4m8+pS97mfIU5LnLFUXPYWdlTi0sXfVVv?=
 =?us-ascii?Q?vyjRsKRw8RV91DMzrHYhXUZyxi4J0wIm2CmMj6hlsVzP5fsHqP/PC8p392Iu?=
 =?us-ascii?Q?VQZKU3a6YiAeAIUwlMjXpUn5huKZKgLBhZWCinBtun1m7BnJMbrdnu4pSJXY?=
 =?us-ascii?Q?hQ4ZINLufz19cxWUN0hqx8NLJ6nKetlYHSYfpvEVSvP3tR8ScdcBSOcZ6dWH?=
 =?us-ascii?Q?Z/1Pu+x1kDOl6S2aCVLtZ7oLHupllSIiU80HEcjBNV3jM4AtxEbD/acI/58E?=
 =?us-ascii?Q?7a4xIex55ElCm+2siOvzFPwVCzKD+Q4u/o58zFGakH3SH5ktrnRjphJUkdZ9?=
 =?us-ascii?Q?guTa/IS4Tm0pz/aYvMps3gmhblYQgm4CQOxtM/wcj+/n2oz3Q2amKKkxCFX2?=
 =?us-ascii?Q?U/Lbl7mjvOKxAUsje5BzgWJbs0PXzp7XXtyYOL/j09LasaFfsnAfrVd/r3B+?=
 =?us-ascii?Q?/p4Rp49+y2K4JAP9H5wd7KfPOnxjiCelDfAsFSCmuO2TV1fnXDBn+cWE7gi8?=
 =?us-ascii?Q?ZZpo9Sz15xc2DCObtu8s5iaW+8JPni5sEBtTJuCshcO/V6D2cfLlrTwKC9I0?=
 =?us-ascii?Q?/6R3nLiUD3r9/Q9xwBpYaavJFgGdzPV2VZ+K78BaBHncmnCXnxtkIGvqzlDj?=
 =?us-ascii?Q?GLcotVF7oaiG5IDRT4mZArNXWMLdeSpa4D9gpLbh1z3fXQ02aQQvZbb9hX3J?=
 =?us-ascii?Q?7L9fj/FYCcjhxDXfiMyI2br2XUpgkeSClzX6VLoCk89AohtYsfxvlboYw2h4?=
 =?us-ascii?Q?w3srmnfCEJQAXw0852py/HZpAxSlanuWBa3Rrlr3VKfFFodjtn/iA29Of0Y4?=
 =?us-ascii?Q?HPMGgbMt8+vi6z6kHSNXdgxxottBp3nQEKI6H3eKOH4+BVczvAblrdRicwpn?=
 =?us-ascii?Q?cGoIBbvIDHCYMmw+X1Ry8BXz53H3OlrPpwZzA3jGRtLrQ4Mo2e3FUTfmavs9?=
 =?us-ascii?Q?mD1Gm48Fzkwi/CZ7I7IrcbUDPOXN1RotIjy3YfywHY7f4plSCLj6E6QyIw4S?=
 =?us-ascii?Q?/sG/eVXy3qmqp2k1BPnbmzJ9T7b7uLRixtWaHCK134wmShqtG5EcmN0S+2oq?=
 =?us-ascii?Q?d9JltkMQhVslxd0yzF0RTLEOc88V2kle6Js1nC1IKFI+gVQVXdQHZMROtZCj?=
 =?us-ascii?Q?iCFLt53FdCYmtYUsakqGFF+t00rZv90TxDQeXQ3501ipEgv0pNjF6QKy88uF?=
 =?us-ascii?Q?z0/HD1a4UPytr8mVi031mi9iiMXMENGNsz5Px4Srd3fqUfmbZddSKTy6Mv+C?=
 =?us-ascii?Q?jZ6y23j7qn1THw4HUE/jfICv2zB8Lg/ClThQGBKkXHhyLQvghHrZz+sFhRLo?=
 =?us-ascii?Q?flFCo41o0knYKYc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(52116014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aeL5zHeivDgQvMsjRFDpeAy1k+DbQUbcTuT4fNJyNawkoB6FJuJ7iyjX2t4t?=
 =?us-ascii?Q?G9wY/k8rsQCJfT5b+42EwOu81TjpC2PeVjDI0CRfPjOK9j8njQ2DfB0GtEjM?=
 =?us-ascii?Q?Ax74JtxpNWRk48Sb2pZbd4iwsItpnt/87enHNSwMPx1GnIKnaEjUZtU5tOLj?=
 =?us-ascii?Q?KVxCWLf1uGaQ62RG23v3FrdiLwYH54Odvw4QKVDeVOjvjrUlN2ldq3FRuWuB?=
 =?us-ascii?Q?BuVP0fUfxWHT6YbJMjvIm/dHFhQFTmVSltFvzsArV0pLDbWQVaPlw/6JUg6S?=
 =?us-ascii?Q?c7pegXdIN83KYrF7ObvT+USLwDkX84eogsw/LlWWIevqMqjy2Llx4WTkrjnN?=
 =?us-ascii?Q?N2eNCkgP368wsGpZ5KIjnn8DGPQIWW5XUwjyHsP3tS8/imwyjnSUJm7Wc6Ee?=
 =?us-ascii?Q?KupBHygxchmqNFCRO/EuOq3mAHyiT3A7ASF6WjcZRcJCFH24SJoDLjYei8XN?=
 =?us-ascii?Q?RP8QKz2rwFXUtg11tLgGWctDeUvMFDufmS3tHr/Il2MOKNJLQi/3CYIrZ9/p?=
 =?us-ascii?Q?5IXDlDIa4eMxH5yg1uxnO2ejMBPf2AnEtdHLkBl8Yyre5bDeE5c9i0lN7+I7?=
 =?us-ascii?Q?Rc/9lEn9GIa4APJpB/555Cw1KORXP5yrE/EYfwWZYizyI0uHpP4+PLKCO/wa?=
 =?us-ascii?Q?lrZtH5Ploa6i6eNDYxQp12geJtSjjLLeCCDX+Yx+tgdwCVBWB13BibR8pw6S?=
 =?us-ascii?Q?s9rPHQf1WvUSyxC/Q2vbSSDa+0URD2rOPutD/qkW8pjsof4e33GTvFiSfd6U?=
 =?us-ascii?Q?4qeWOhT/om95HpOZGpOUtRVMK+pFe4Lw27C0xE5dJxVUwAmqUN+QTHDbvEPp?=
 =?us-ascii?Q?mPlj8gjubzC+LKZUKfJ0Sx838BqilKYkXwuuYH4XbLPtkesW1F/4H4TD9l3z?=
 =?us-ascii?Q?pYQJ/6DNpTOq5uvl08iDkTDfdhd4tb0PlFhwkGxGYc+yETDBmppG6iPD4BCg?=
 =?us-ascii?Q?aFbysrPYmW9UTwINiSCeuW02/D/kmQqBGfN4ViZ1A7fuhyDlHTLcc6ftOSL1?=
 =?us-ascii?Q?rwcs9oKEUVhSpw9Lr0cfQUV1jsEL3F+aNrKqovpPAZ8/kXI36YdoZxcsbdF9?=
 =?us-ascii?Q?6+wB1nmy3KitzZnMf9mF8jRns5Xr4PxUQTxhSIdzLUvm2TdIrTS7UKrmc7a3?=
 =?us-ascii?Q?MOzo9HA7Ap0vAtfTSPiiq/m6oYkWMhEXGSOUEhEhDH0cPog6SCQzqmRVbv78?=
 =?us-ascii?Q?4iFna5A/sn5e3RGrThQhqEtRiU0vDecnEHx79/rlT1lFSq+3acPii6gVguIm?=
 =?us-ascii?Q?0ZEofyOuJA+jOSDYg7mFIXPyrO7JNiQjf9a+011Dy3UinuJhdgowuYX85Gwa?=
 =?us-ascii?Q?OfDyyQITPb1XP3CuvPCoJLQHpPsoH4oCZo4KgPTLqttlt+C/5Lagau4kcFMk?=
 =?us-ascii?Q?YK72Y1i7mzZR32koKsiw4mhy1waSJrSnWXmArMRL12AZ4YzV2N67koBPC7IB?=
 =?us-ascii?Q?61r98idm6wPnIucEKmeaIe21soXbrjNWMh1rG3AfK+5NT3OiIulGN/SRe94y?=
 =?us-ascii?Q?BDwqoKDEl6/SKGNOyMlc/3Po2bwtjhcg4AJGNXroxSjD5L1Z3bFKxBtseXMK?=
 =?us-ascii?Q?1Oic+MLYkW4Pd1IQGPxwx6kHUENypsUwCOz12aIk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1795bbf6-b793-4c60-dc93-08ddde53beda
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 12:35:42.4862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QYTJSd5d2oz74i+f61Ugr6Fz5NMqYwEoR05KLYoBqiEywdnVj2CKen74TNuTj8o5v+xlEWUiZmRT0KKL0uQiKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5379

The crash_mem struct is already zeroed by vzalloc(). It's redundant to
initialize cmem->nr_ranges to 0.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 arch/x86/kernel/crash.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c6b12bed173d..60bb24ddd36f 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -172,7 +172,6 @@ static struct crash_mem *fill_up_crash_elf_data(void)
 		return NULL;
 
 	cmem->max_nr_ranges = nr_ranges;
-	cmem->nr_ranges = 0;
 
 	return cmem;
 }
@@ -332,7 +331,6 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 		return -ENOMEM;
 
 	cmem->max_nr_ranges = nr_ranges;
-	cmem->nr_ranges = 0;
 
 	memset(&cmd, 0, sizeof(struct crash_memmap_data));
 	cmd.params = params;
-- 
2.34.1


