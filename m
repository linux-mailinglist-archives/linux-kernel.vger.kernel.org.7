Return-Path: <linux-kernel+bounces-841148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C877BB65A5
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 605C64E976D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AB72D29CF;
	Fri,  3 Oct 2025 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="oK/Z7qRK"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AE828FFE7;
	Fri,  3 Oct 2025 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759483166; cv=fail; b=qfm/Wooar1t9eGhvVGGzx5Hu+phHAyhk3zeWGFsN6sx5EFsJTC3TQ86nQh0Hu2AZ/lydFA2CGbj4IrjZ1PCVaRC8eXiodMzE+yslqG6CrP1KvuNdghUBNap57k6xZ//dW9W8qi2xnFD1FcetlGO0ZrEknJb+qOt9pzdPhVPzl/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759483166; c=relaxed/simple;
	bh=IVqFPIhgRdeHrP7RfrjxnKfzqaQECKshMUC3hRnlzBQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ccmTK9rrPvYF88F6neUbJ7/P4s91Kh19M9E9KA2pt7M5BXzNBjupXDSmhDI/lARjTg+7GAqBuuDzi9ENrGC8GkJXCbIUgmpctAFPKo4LmNGWULhO3Zq9krTdUQzKsSETQl4bMHJUfJ8PaPKgs3viqzd7vF+35+WAgYCRn9GcUqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=oK/Z7qRK; arc=fail smtp.client-ip=52.101.43.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CA1L3Vj/PTCuoyFD9PhgMZm+4wtRBuEaVZqXIuRcMnk5nH7DAcfGEjuVJIWnh+K468YgXJLb2SVT9uK43NkmBpa/xsskrj0VQq9mM18Xbu9f/0OaZ7f4qcB2C99DbtWxXHjlNNAEKOQMM4UkrgElvRANZCuMcspFoQftVY32/ikb52Q3rKX6KbVs/6ciVvuRcNnpL2M9kl7EE7PeEbHp1NAaxESyNElUGNirRzxUHDiV6m095zEnBJVsVlH3S7OH/mwKsVuBOdnJtWJAYhxX6iH1J/uxiootkcp7UVLx0UF+m9mmX2Tz9VB0QDAttePVNhTYqty5aJLNebpNMUvkZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTUsbGPD9EKZ2J3OSZQuQez+MjMlpa8oEz3NPAWwoaw=;
 b=oLd6OFKDEbKLmM2F9mqzxFF9IOj/JXSYMdJZAhbCj6GWo0TH7Kunbui021kgOZwJwBtXLScEuzhAF9J2LGCXev7OgrTIiHUcW81tI0Gve3A4GpKXLORKBNvw7e6/j+NPZyYo8TtKdV4pm7a9JxVxMKjeaKP4sTxzmZzTYzQRQXf/nbTiiiDzOyT6oF3k6teJ7yYjl9ds2u00zf259cULosevmNImxB4RnlkzJiml7elYm5lFM66fFGW+rQQQS784blk4IxaiTs0iOWx/+YE/SWO3E2flSYQBTSeFaZTvrqHwpmUullKzmFcHD3nCZJrSCMbVzMFf9cYHoZqpCc8C0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTUsbGPD9EKZ2J3OSZQuQez+MjMlpa8oEz3NPAWwoaw=;
 b=oK/Z7qRKbnQWGfFumjs+ElSPPMMFZkvGkO82fBKsOm/mKkAvj/vGKQBImObNyA4LmZVSUvKhCZhQjZb9/g2sSj+jcns2+bwwVIW+q2w0eLJSwZ1auo97whAUTJxllweWd1ZrQpnatnzHZUceFh9uwGsVY4+IqLD59pE3KC/aZjjY5KbEd+G0FiGt+XqXChUlZtrijDuhHsAt9e58ZBbtfrY6Zv8SFrO43nxGfEZWRc+V6adI06/wbaOet0YD4xlijTwXFzOeebpNjSvjP6Xuk9u1NvIMPtCQpoPkkLVyZZ9YxxEzQy25nL2ePazkYsnWzT5ktfm2jkZz2yDTgW/1LQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by PH8PR03MB7245.namprd03.prod.outlook.com (2603:10b6:510:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Fri, 3 Oct
 2025 09:19:21 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9182.015; Fri, 3 Oct 2025
 09:19:21 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-kernel@vger.kernel.org (open list),
	Ang Tien Sung <tiensung.ang@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH 1/1] clk: socfpga: agilex5: add clock driver for Agilex5
Date: Fri,  3 Oct 2025 17:19:14 +0800
Message-Id: <e7e7e105327aafd54e58d1786a7a55ff0ea4aa9b.1759482803.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1759482803.git.khairul.anuar.romli@altera.com>
References: <cover.1759482803.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0063.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::8) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|PH8PR03MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df99ab6-a709-43bf-528e-08de025def5c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3E+LYVD5nndURh5Euz6qiNpNZtz3SA3xH1a23uAKqLx/PdcSOh6DG0ClPmkH?=
 =?us-ascii?Q?uu9IDA/cyFw5692bWSvfrpM5+0ObRsPlKKmRz3gU12BBZK3JBIUE4SXMDr2z?=
 =?us-ascii?Q?XmE1vXWSTz47aWbalFmU9gkg4xh08U9J/eLHd47nULjcwf5NUPSKXjgGw8de?=
 =?us-ascii?Q?xH6wSgtg/9ZwQc1XitAW7fGnq3Fh+yItoHRfbB3iO2k7uk2Ff2Wbzj9S73i1?=
 =?us-ascii?Q?ybEh4qvIXQDxCswrwjM5YVFM57BvXvUhhUZspUyDcJ0QTf7bnbrkFKaSDkwL?=
 =?us-ascii?Q?Ot+Mmen1pNV5suSxsOdRgTBpXw2bRC1SHAADfDSTapUkLwS/FWE3Rv0CuHz3?=
 =?us-ascii?Q?yUbgN/EU7BxVj0OJFE0rXN+mpQKB4jVxr5Pq8DsFGN9ZLrEo7iXmjB+2DOMZ?=
 =?us-ascii?Q?Y9yUifjCkBxw0Y/NyWthKvfQ7Uy9K2SfD7OtAe8JoK7uoO0/IPlupgjalgYh?=
 =?us-ascii?Q?eHf216HA6/dVgplh2W4GQIoiPEzPzgFtjKTfn+ygsk3gUMv6hdOaxZfBLtEO?=
 =?us-ascii?Q?GBYFi2eNNJHmAz5NnfjkrJ49TOhQt3BAhRSOs8cNVqfz2grZNVq58fKNxqtj?=
 =?us-ascii?Q?u1q/CIu/nzQ7Ly03mmbM2jJh/+HJVk9QYt7l5m3KesDMg3Mjk/fySABCSZWg?=
 =?us-ascii?Q?mc7fzkP6f/YrINoik3HADHQCGR38CneMc4Lt4pthyZh6stgSdTauHW28T2c2?=
 =?us-ascii?Q?G3jEFyCzS9vd4rhh73LOpm6i57GoIKtuALiZcvfWupSaRPTSMW7TcPDe+UOE?=
 =?us-ascii?Q?E5aQ3AzYRQ/jSbvYwEj9/eGhMN+CeEDvP8laPE5aJ+28Qx8qJKW1+38rGyOX?=
 =?us-ascii?Q?F2ARd1mmFKzfYKjjM3eGD+a1gzktfSqWxGacRTBYEf9B30kQU6kQXmhV6Z++?=
 =?us-ascii?Q?OKcwiAV3Fkf80/6u9hkphc2Faxq7c/oGly4/KI2kznCZ2ZcJ5aHpwnsMohLh?=
 =?us-ascii?Q?C8eb2ubhdi8lMN7pixDK4uGsD2HUaQvJ3pomJf7gpnGL2XTaDrTG6QRFZuZq?=
 =?us-ascii?Q?1s9ftn+Yf02AqfllXZNFIdJ/H4FJ5pmnkTaALATyoud0pufOWMiCrvd3xf7e?=
 =?us-ascii?Q?lc1NT7ZQEF1eZyFhzJ/tuhaPFrZlCD3eB1wXhycUL2GfX1RhSCFy/7yB4C9r?=
 =?us-ascii?Q?hxMyBuBWePTvrUa2BcI4q5m/7wOGbfXq+qlDJW9YXc4kIuNWf18qvdyOpSCk?=
 =?us-ascii?Q?hxo1essfdixAOPvoNHS2oz91AYy4F1RvVr5EzQVgGbH3NEOsILrd+ZIlKfkF?=
 =?us-ascii?Q?mN9QRw5Fkl3CscYhT/DXSdiEEoXrua/FFb01IvkKmO50lZD/eapit9vhHtrU?=
 =?us-ascii?Q?9x7/IgGbfZUQFbS4TEvCfOPGX03JJXlqVvSX5wKXRpb4STjVbkrbIgmjvUvL?=
 =?us-ascii?Q?HrLGsDtk5ds72+40WF5vnBjOSRF9swrpL5O2AaOoonuTm6Mt1LwSvTw3qZ3N?=
 =?us-ascii?Q?BzQmm8JdSfwiJ7POsTftgchO+GSmMyBt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OLmzLS1x376YHtsPRg/QOBXJZnics4c4ybMhYud/cbHeIy4zMjSIX+OgC5GK?=
 =?us-ascii?Q?lIiM4FJh8H+WcK3zhf3A9OIKe76wJkxCYiGoh10UF4Op13J6jlZoWsAdY++N?=
 =?us-ascii?Q?EbyE3WmOpWIRWGHxRHp8DHUrNVNqG1iMR4I65C78lXV1cyHbdFmVIthgfC+v?=
 =?us-ascii?Q?Hux1Au9obVE1EGc+ax3SV0RU74cSSJi1ELIpHvNImEcXR1pJwv0EplxZ6yXH?=
 =?us-ascii?Q?sOh48CDgkreHk5Mpf8qxIAgxQ8YovWy1r3Kw24XULVMcaabmbgluBboESTNi?=
 =?us-ascii?Q?yGkwZdazZviOljqXfUQLOioz3h6eFVVHGZyyZOiqg/ael+Mi4nBoHbHU8KcZ?=
 =?us-ascii?Q?IFcGWPyCYYp4YElRGmoDODvS51JTjbpYEBOntiBMHkLuPkmkadpFgr3HHBk/?=
 =?us-ascii?Q?nbmTlaFAehE5XW1tuWd0IdI/M/EA92WqsGiszMWzWXbgYmlhX4VlIiBcdu3Z?=
 =?us-ascii?Q?2xamzdV+rv0M58Dfu8kLjS3/k/o38VIWJCAOUMMeKciGiS2aieUFuN42tblc?=
 =?us-ascii?Q?i1q/oKxclQ0N9yujRFC418ntWv7gRE2MPusvE7+tsYkLemL7c/XZ5COXlXWB?=
 =?us-ascii?Q?WDHxfI96VD/smGv/oGklZUBrISAITexdRtFwf8ZeJ7WhWUH4ygrpI7JkNxKn?=
 =?us-ascii?Q?CMRMmKomefL3M1farjQmk9Srto89wStgTM7Y1O+rDCtaw7zOqfbQI0GfQzOx?=
 =?us-ascii?Q?2ozklUjCT1nCmn5wuFyWpiiTpSXhesAWZ7R33XZorXqF28uOztyAb00dL5JQ?=
 =?us-ascii?Q?5Z8CdhO+b7Vmxuc6GZMvsREOaaxw+E9w2PkzyRXb4/rK0Y28Rwx+tkdz73Lv?=
 =?us-ascii?Q?by9KmJItsM6T6vxxZk1tB6O3rtfZvm9L+5/803RCia00LbjM1zqZdcoxmrt/?=
 =?us-ascii?Q?mYIST0HxVFwUyL4P8pP28I1FxFZlrja9ObVQ+3n2v34X6dAdfZO0yfd9iz3B?=
 =?us-ascii?Q?TURAKbJLI6hLXGC0YFEJkHFhAxV9ouefHYtAbGNCVAlnLIdVkj+YSv1xeYB7?=
 =?us-ascii?Q?gS4nC05SRwmnEY94k4rwv+zB2Bv2NTXRm4b14R7p+VU0Yg85nyLndWd3CDuk?=
 =?us-ascii?Q?duk53hG3WzKqrBOOn8FsiU0p+codbBmKe/hBL6Lvca2YT4D7jaJHNA4oAhPX?=
 =?us-ascii?Q?m4ZvpQTqjK1yv0r1SNLnrCMmhKMSP6hPpZpyACj98mBj/ELJXWpGbnc7ywzO?=
 =?us-ascii?Q?nZWlgKW6H72mXzP7McTfi8wzIoC1BzLQxkdUDOo5Mve9896zqe+5as1i+AbB?=
 =?us-ascii?Q?M2mBHPV76LyfxH5uROAUXqcKdfznOZq/E9diHkSWJp5NZ2omx6B5VwSaQqAP?=
 =?us-ascii?Q?9QhijGdaIBikanj5lHZ/a8l5KseuApi3z+pHwgCQZxxp8yoYNzmVC6IpWwse?=
 =?us-ascii?Q?onE6hIkmhu8reGfbkn71T72MlK5omvcf2GY2vywo/SokP8Fhs+RSypkvfTeG?=
 =?us-ascii?Q?DJ8JEsSBEG2MSOsV12gUtLW7kqYFyzhZk3Zjs9Rx1qvSr/nmMm+iHE9JE35v?=
 =?us-ascii?Q?FGAdbs2J8HBOwtSvWvRsoSXhN4brIKvX4qw8dnv3ha/mL6ddc+2kwrDGfGKJ?=
 =?us-ascii?Q?zy4WJMeSBs7Nkw3j3t7zDb67SE8rNaGjGPJC4bmUvkg/a1VbGiiyQWo9pZbH?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df99ab6-a709-43bf-528e-08de025def5c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 09:19:21.2769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dz1rRb9u/vkXsvM7W4frNn9ISikaEvtRsBg63c/IuN4eHq2R1IrWRD/YwAjaE7/y7inOQ9LNrpF8zbKWkGNMuBug1qv4qBTSb3g722dqNV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB7245

Add the new Clock manager driver to support new Agilex5 platform. The new
driver got rid of the clk_parent_data structures as there are no 'clock-names'
property in the DT bindings and use parent_names internally. This is based on
the previous feedback from the maintainer.

Signed-off-by: Ang Tien Sung <tiensung.ang@altera.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
 drivers/clk/socfpga/clk-agilex5.c    | 563 +++++++++++++++++++++++++++
 drivers/clk/socfpga/clk-gate-s10.c   |  53 +++
 drivers/clk/socfpga/clk-periph-s10.c |  41 ++
 drivers/clk/socfpga/clk-pll-s10.c    |  38 +-
 drivers/clk/socfpga/stratix10-clk.h  |  43 ++
 5 files changed, 737 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/socfpga/clk-agilex5.c

diff --git a/drivers/clk/socfpga/clk-agilex5.c b/drivers/clk/socfpga/clk-agilex5.c
new file mode 100644
index 000000000000..0013fab81357
--- /dev/null
+++ b/drivers/clk/socfpga/clk-agilex5.c
@@ -0,0 +1,563 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022-2024, Intel Corporation
+ * Copyright (C) 2025, Altera Corporation
+ */
+#include <linux/slab.h>
+#include <linux/clk-provider.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include  <dt-bindings/clock/intel,agilex5-clkmgr.h>
+#include "stratix10-clk.h"
+#include "clk.h"
+
+/* External parent clocks come from DT via fw_name */
+static const char * const boot_pll_parents[] = {
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+};
+
+static const char * const main_pll_parents[] = {
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const periph_pll_parents[] = {
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+};
+
+/* Core free muxes */
+static const char * const core0_free_mux[] = {
+	"main_pll_c1",
+	"peri_pll_c0",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const core1_free_mux[] = {
+	"main_pll_c1",
+	"peri_pll_c0",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const core2_free_mux[] = {
+	"main_pll_c0",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const core3_free_mux[] = {
+	"main_pll_c0",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const dsu_free_mux[] = {
+	"main_pll_c2",
+	"peri_pll_c0",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const noc_free_mux[] = {
+	"main_pll_c3",
+	"peri_pll_c1",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const emac_ptp_free_mux[] = {
+	"main_pll_c3",
+	"peri_pll_c3",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const emaca_free_mux[] = {
+	"main_pll_c2",
+	"peri_pll_c3",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const emacb_free_mux[] = {
+	"main_pll_c3",
+	"peri_pll_c3",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const gpio_db_free_mux[] = {
+	"main_pll_c3",
+	"peri_pll_c1",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const psi_ref_free_mux[] = {
+	"main_pll_c1",
+	"peri_pll_c3",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const usb31_free_mux[] = {
+	"main_pll_c3",
+	"peri_pll_c2",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const s2f_user0_free_mux[] = {
+	"main_pll_c1",
+	"peri_pll_c3",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+static const char * const s2f_user1_free_mux[] = {
+	"main_pll_c1",
+	"peri_pll_c3",
+	"osc1",
+	"cb-intosc-hs-div2-clk",
+	"f2s-free-clk",
+};
+
+/* Secondary muxes between free_clk and boot_clk */
+static const char * const core0_mux[] = {
+	"core0_free_clk",
+	"boot_clk",
+};
+
+static const char * const core1_mux[] = {
+	"core1_free_clk",
+	"boot_clk",
+};
+
+static const char * const core2_mux[] = {
+	"core2_free_clk",
+	"boot_clk",
+};
+
+static const char * const core3_mux[] = {
+	"core3_free_clk",
+	"boot_clk",
+};
+
+static const char * const dsu_mux[] = {
+	"dsu_free_clk",
+	"boot_clk",
+};
+
+static const char * const noc_mux[] = {
+	"noc_free_clk",
+	"boot_clk",
+};
+
+static const char * const emac_mux[] = {
+	"emaca_free_clk",
+	"emacb_free_clk",
+	"boot_clk",
+};
+
+static const char * const s2f_user0_mux[] = {
+	"s2f_user0_free_clk",
+	"boot_clk",
+};
+
+static const char * const s2f_user1_mux[] = {
+	"s2f_user1_free_clk",
+	"boot_clk",
+};
+
+static const char * const psi_mux[] = {
+	"psi_ref_free_clk",
+	"boot_clk",
+};
+
+static const char * const gpio_db_mux[] = {
+	"gpio_db_free_clk",
+	"boot_clk",
+};
+
+static const char * const emac_ptp_mux[] = {
+	"emac_ptp_free_clk",
+	"boot_clk",
+};
+
+static const char * const usb31_mux[] = {
+	"usb31_free_clk",
+	"boot_clk",
+};
+
+static const struct agilex5_pll_clock agilex5_pll_clks[] = {
+	{
+		.id = AGILEX5_BOOT_CLK,
+		.name = "boot_clk",
+		.parent_names = boot_pll_parents,
+		.num_parents = ARRAY_SIZE(boot_pll_parents),
+		.flags = 0,
+		.offset = 0x0,
+	},
+	{
+		.id = AGILEX5_MAIN_PLL_CLK,
+		.name = "main_pll",
+		.parent_names = main_pll_parents,
+		.num_parents = ARRAY_SIZE(main_pll_parents),
+		.flags = 0,
+		.offset = 0x48,
+	},
+	{
+		.id = AGILEX5_PERIPH_PLL_CLK,
+		.name = "periph_pll",
+		.parent_names = periph_pll_parents,
+		.num_parents = ARRAY_SIZE(periph_pll_parents),
+		.flags = 0,
+		.offset = 0x9C,
+	},
+};
+
+/* Main PLL C0, C1, C2, C3 and Peri PLL C0, C1, C2, C3. With ping-pong counter. */
+static const struct stratix10_perip_c_clock agilex5_main_perip_c_clks[] = {
+	{ AGILEX5_MAIN_PLL_C0_CLK, "main_pll_c0", "main_pll", NULL, 1, 0,
+	  0x5C },
+	{ AGILEX5_MAIN_PLL_C1_CLK, "main_pll_c1", "main_pll", NULL, 1, 0,
+	  0x60 },
+	{ AGILEX5_MAIN_PLL_C2_CLK, "main_pll_c2", "main_pll", NULL, 1, 0,
+	  0x64 },
+	{ AGILEX5_MAIN_PLL_C3_CLK, "main_pll_c3", "main_pll", NULL, 1, 0,
+	  0x68 },
+	{ AGILEX5_PERIPH_PLL_C0_CLK, "peri_pll_c0", "periph_pll", NULL, 1, 0,
+	  0xB0 },
+	{ AGILEX5_PERIPH_PLL_C1_CLK, "peri_pll_c1", "periph_pll", NULL, 1, 0,
+	  0xB4 },
+	{ AGILEX5_PERIPH_PLL_C2_CLK, "peri_pll_c2", "periph_pll", NULL, 1, 0,
+	  0xB8 },
+	{ AGILEX5_PERIPH_PLL_C3_CLK, "peri_pll_c3", "periph_pll", NULL, 1, 0,
+	  0xBC },
+};
+
+/* Non-SW clock-gated enabled clocks */
+static const struct agilex5_perip_cnt_clock agilex5_main_perip_cnt_clks[] = {
+	{ AGILEX5_CORE0_FREE_CLK, "core0_free_clk", core0_free_mux,
+	ARRAY_SIZE(core0_free_mux), 0, 0x0100, 0, 0, 0},
+	{ AGILEX5_CORE1_FREE_CLK, "core1_free_clk", core1_free_mux,
+	ARRAY_SIZE(core1_free_mux), 0, 0x0104, 0, 0, 0},
+	{ AGILEX5_CORE2_FREE_CLK, "core2_free_clk", core2_free_mux,
+	ARRAY_SIZE(core2_free_mux), 0, 0x010C, 0, 0, 0},
+	{ AGILEX5_CORE3_FREE_CLK, "core3_free_clk", core3_free_mux,
+	ARRAY_SIZE(core3_free_mux), 0, 0x0110, 0, 0, 0},
+	{ AGILEX5_DSU_FREE_CLK, "dsu_free_clk", dsu_free_mux,
+	ARRAY_SIZE(dsu_free_mux), 0, 0xfc, 0, 0, 0},
+	{ AGILEX5_NOC_FREE_CLK, "noc_free_clk", noc_free_mux,
+	ARRAY_SIZE(noc_free_mux), 0, 0x40, 0, 0, 0 },
+	{ AGILEX5_EMAC_A_FREE_CLK, "emaca_free_clk", emaca_free_mux,
+	ARRAY_SIZE(emaca_free_mux), 0, 0xD4, 0, 0x88, 0 },
+	{ AGILEX5_EMAC_B_FREE_CLK, "emacb_free_clk", emacb_free_mux,
+	ARRAY_SIZE(emacb_free_mux), 0, 0xD8, 0, 0x88, 1 },
+	{ AGILEX5_EMAC_PTP_FREE_CLK, "emac_ptp_free_clk", emac_ptp_free_mux,
+	ARRAY_SIZE(emac_ptp_free_mux), 0, 0xDC, 0, 0x88, 2 },
+	{ AGILEX5_GPIO_DB_FREE_CLK, "gpio_db_free_clk", gpio_db_free_mux,
+	ARRAY_SIZE(gpio_db_free_mux), 0, 0xE0, 0, 0x88, 3 },
+	{ AGILEX5_S2F_USER0_FREE_CLK, "s2f_user0_free_clk", s2f_user0_free_mux,
+	ARRAY_SIZE(s2f_user0_free_mux), 0, 0xE8, 0, 0x30, 2 },
+	{ AGILEX5_S2F_USER1_FREE_CLK, "s2f_user1_free_clk", s2f_user1_free_mux,
+	ARRAY_SIZE(s2f_user1_free_mux), 0, 0xEC, 0, 0x88, 5 },
+	{ AGILEX5_PSI_REF_FREE_CLK, "psi_ref_free_clk", psi_ref_free_mux,
+	ARRAY_SIZE(psi_ref_free_mux), 0, 0xF0, 0, 0x88, 6 },
+	{ AGILEX5_USB31_FREE_CLK, "usb31_free_clk", usb31_free_mux,
+	ARRAY_SIZE(usb31_free_mux), 0, 0xF8, 0, 0x88, 7},
+};
+
+static const char * const cs_pdbg_parents[] = { "cs_at_clk" };
+static const char * const usb31_bus_clk_early_parents[] = { "l4_main_clk" };
+static const char * const l4_mp_clk_parent[] = { "l4_mp_clk" };
+static const char * const l4_sp_clk_parent[] = { "l4_sp_clk" };
+static const char * const dfi_clk_parent[] = { "dfi_clk" };
+
+/* SW Clock gate enabled clocks */
+static const struct agilex5_gate_clock agilex5_gate_clks[] = {
+	{ AGILEX5_CORE0_CLK, "core0_clk", core0_mux,
+	  ARRAY_SIZE(core0_mux), 0, 0x24, 8, 0, 0, 0, 0x30, 5, 0 },
+	{ AGILEX5_CORE1_CLK, "core1_clk", core1_mux,
+	  ARRAY_SIZE(core1_mux), 0, 0x24, 9, 0, 0, 0, 0x30, 5, 0 },
+	{ AGILEX5_CORE2_CLK, "core2_clk", core2_mux,
+	  ARRAY_SIZE(core2_mux), 0, 0x24, 10, 0, 0, 0, 0x30, 6, 0 },
+	{ AGILEX5_CORE3_CLK, "core3_clk", core3_mux,
+	  ARRAY_SIZE(core3_mux), 0, 0x24, 11, 0, 0, 0, 0x30, 7, 0 },
+	{ AGILEX5_MPU_CLK, "dsu_clk", dsu_mux, ARRAY_SIZE(dsu_mux), 0, 0, 0,
+	  0, 0, 0, 0x34, 4, 0 },
+	{ AGILEX5_MPU_PERIPH_CLK, "mpu_periph_clk", dsu_mux,
+	  ARRAY_SIZE(dsu_mux), 0, 0, 0, 0x44, 20, 2, 0x34, 4, 0 },
+	{ AGILEX5_MPU_CCU_CLK, "mpu_ccu_clk", dsu_mux,
+	  ARRAY_SIZE(dsu_mux), 0, 0, 0, 0x44, 18, 2, 0x34, 4, 0 },
+	{ AGILEX5_L4_MAIN_CLK, "l4_main_clk", noc_mux, ARRAY_SIZE(noc_mux),
+	  CLK_IS_CRITICAL, 0x24, 1, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_L4_MP_CLK, "l4_mp_clk", noc_mux, ARRAY_SIZE(noc_mux), 0,
+	  0x24, 2, 0x44, 4, 2, 0x30, 1, 0 },
+	{ AGILEX5_L4_SYS_FREE_CLK, "l4_sys_free_clk", noc_mux,
+	  ARRAY_SIZE(noc_mux), 0, 0, 0, 0x44, 2, 2, 0x30, 1, 0 },
+	{ AGILEX5_L4_SP_CLK, "l4_sp_clk", noc_mux, ARRAY_SIZE(noc_mux),
+	  CLK_IS_CRITICAL, 0x24, 3, 0x44, 6, 2, 0x30, 1, 0 },
+
+	/* Core sight clocks*/
+	{ AGILEX5_CS_AT_CLK, "cs_at_clk", noc_mux, ARRAY_SIZE(noc_mux), 0,
+	  0x24, 4, 0x44, 24, 2, 0x30, 1, 0 },
+	{ AGILEX5_CS_TRACE_CLK, "cs_trace_clk", noc_mux,
+	  ARRAY_SIZE(noc_mux), 0, 0x24, 4, 0x44, 26, 2, 0x30, 1, 0 },
+	{ AGILEX5_CS_PDBG_CLK, "cs_pdbg_clk", cs_pdbg_parents, 1, 0, 0x24, 4,
+	  0x44, 28, 1, 0, 0, 0 },
+
+	/* Main Peripheral PLL1 Begin */
+	{ AGILEX5_EMAC0_CLK, "emac0_clk", emac_mux, ARRAY_SIZE(emac_mux),
+	  0, 0x7C, 0, 0, 0, 0, 0x94, 26, 0 },
+	{ AGILEX5_EMAC1_CLK, "emac1_clk", emac_mux, ARRAY_SIZE(emac_mux),
+	  0, 0x7C, 1, 0, 0, 0, 0x94, 27, 0 },
+	{ AGILEX5_EMAC2_CLK, "emac2_clk", emac_mux, ARRAY_SIZE(emac_mux),
+	  0, 0x7C, 2, 0, 0, 0, 0x94, 28, 0 },
+	{ AGILEX5_EMAC_PTP_CLK, "emac_ptp_clk", emac_ptp_mux,
+	  ARRAY_SIZE(emac_ptp_mux), 0, 0x7C, 3, 0, 0, 0, 0x88, 2, 0 },
+	{ AGILEX5_GPIO_DB_CLK, "gpio_db_clk", gpio_db_mux,
+	  ARRAY_SIZE(gpio_db_mux), 0, 0x7C, 4, 0x98, 0, 16, 0x88, 3, 1 },
+	  /* Main Peripheral PLL1 End */
+
+	  /* Peripheral clocks  */
+	{ AGILEX5_S2F_USER0_CLK, "s2f_user0_clk", s2f_user0_mux,
+	  ARRAY_SIZE(s2f_user0_mux), 0, 0x24, 6, 0, 0, 0, 0x30, 2, 0 },
+	{ AGILEX5_S2F_USER1_CLK, "s2f_user1_clk", s2f_user1_mux,
+	  ARRAY_SIZE(s2f_user1_mux), 0, 0x7C, 6, 0, 0, 0, 0x88, 5, 0 },
+	{ AGILEX5_PSI_REF_CLK, "psi_ref_clk", psi_mux,
+	  ARRAY_SIZE(psi_mux), 0, 0x7C, 7, 0, 0, 0, 0x88, 6, 0 },
+	{ AGILEX5_USB31_SUSPEND_CLK, "usb31_suspend_clk", usb31_mux,
+	  ARRAY_SIZE(usb31_mux), 0, 0x7C, 25, 0, 0, 0, 0x88, 7, 0 },
+	{ AGILEX5_USB31_BUS_CLK_EARLY, "usb31_bus_clk_early", usb31_bus_clk_early_parents,
+	  1, 0, 0x7C, 25, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_USB2OTG_HCLK, "usb2otg_hclk", l4_mp_clk_parent, 1, 0, 0x7C,
+	  8, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPIM_0_CLK, "spim_0_clk", l4_mp_clk_parent, 1, 0, 0x7C, 9,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPIM_1_CLK, "spim_1_clk", l4_mp_clk_parent, 1, 0, 0x7C, 11,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPIS_0_CLK, "spis_0_clk", l4_sp_clk_parent, 1, 0, 0x7C, 12,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPIS_1_CLK, "spis_1_clk", l4_sp_clk_parent, 1, 0, 0x7C, 13,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_DMA_CORE_CLK, "dma_core_clk", l4_mp_clk_parent, 1, 0, 0x7C,
+	  14, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_DMA_HS_CLK, "dma_hs_clk", l4_mp_clk_parent, 1, 0, 0x7C, 14,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I3C_0_CORE_CLK, "i3c_0_core_clk", l4_mp_clk_parent, 1, 0,
+	  0x7C, 18, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I3C_1_CORE_CLK, "i3c_1_core_clk", l4_mp_clk_parent, 1, 0,
+	  0x7C, 19, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_0_PCLK, "i2c_0_pclk", l4_sp_clk_parent, 1, 0, 0x7C, 15,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_1_PCLK, "i2c_1_pclk", l4_sp_clk_parent, 1, 0, 0x7C, 16,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_EMAC0_PCLK, "i2c_emac0_pclk", l4_sp_clk_parent, 1, 0,
+	  0x7C, 17, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_EMAC1_PCLK, "i2c_emac1_pclk", l4_sp_clk_parent, 1, 0,
+	  0x7C, 22, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_EMAC2_PCLK, "i2c_emac2_pclk", l4_sp_clk_parent, 1, 0,
+	  0x7C, 27, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_UART_0_PCLK, "uart_0_pclk", l4_sp_clk_parent, 1, 0, 0x7C, 20,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_UART_1_PCLK, "uart_1_pclk", l4_sp_clk_parent, 1, 0, 0x7C, 21,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPTIMER_0_PCLK, "sptimer_0_pclk", l4_sp_clk_parent, 1, 0,
+	  0x7C, 23, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPTIMER_1_PCLK, "sptimer_1_pclk", l4_sp_clk_parent, 1, 0,
+	  0x7C, 24, 0, 0, 0, 0, 0, 0 },
+
+	/*NAND, SD/MMC and SoftPHY overall clocking*/
+	{ AGILEX5_DFI_CLK, "dfi_clk", l4_mp_clk_parent, 1, 0, 0, 0, 0x44, 16,
+	  2, 0, 0, 0 },
+	{ AGILEX5_NAND_NF_CLK, "nand_nf_clk", dfi_clk_parent, 1, 0, 0x7C, 10,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_NAND_BCH_CLK, "nand_bch_clk", l4_mp_clk_parent, 1, 0, 0x7C,
+	  10, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SDMMC_SDPHY_REG_CLK, "sdmmc_sdphy_reg_clk", l4_mp_clk_parent,
+	  1, 0, 0x7C, 5, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SDMCLK, "sdmclk", dfi_clk_parent, 1, 0, 0x7C, 5, 0, 0, 0,
+	  0, 0, 0 },
+	{ AGILEX5_SOFTPHY_REG_PCLK, "softphy_reg_pclk", l4_mp_clk_parent, 1, 0,
+	  0x7C, 26, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SOFTPHY_PHY_CLK, "softphy_phy_clk", l4_mp_clk_parent, 1, 0,
+	  0x7C, 26, 0x44, 16, 2, 0, 0, 0 },
+	{ AGILEX5_SOFTPHY_CTRL_CLK, "softphy_ctrl_clk", dfi_clk_parent, 1, 0,
+	  0x7C, 26, 0, 0, 0, 0, 0, 0 },
+};
+
+static int
+agilex5_clk_register_c_perip(const struct stratix10_perip_c_clock *clks,
+			     int nums, struct stratix10_clock_data *data)
+{
+	struct clk_hw *hw_clk;
+	void __iomem *base = data->base;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		hw_clk = s10_register_periph(&clks[i], base);
+		if (IS_ERR(hw_clk)) {
+			pr_err("%s: failed to register clock %s\n", __func__,
+			       clks[i].name);
+			continue;
+		}
+		data->clk_data.hws[clks[i].id] = hw_clk;
+	}
+	return 0;
+}
+
+static int
+agilex5_clk_register_cnt_perip(const struct agilex5_perip_cnt_clock *clks,
+			       int nums, struct stratix10_clock_data *data)
+{
+	struct clk_hw *hw_clk;
+	void __iomem *base = data->base;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		hw_clk = agilex5_register_cnt_periph(&clks[i], base);
+		if (IS_ERR(hw_clk)) {
+			pr_err("%s: failed to register clock %s\n", __func__,
+			       clks[i].name);
+			continue;
+		}
+		data->clk_data.hws[clks[i].id] = hw_clk;
+	}
+
+	return 0;
+}
+
+static int agilex5_clk_register_gate(const struct agilex5_gate_clock *clks,
+				     int nums,
+				     struct stratix10_clock_data *data)
+{
+	struct clk_hw *hw_clk;
+	void __iomem *base = data->base;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		hw_clk = agilex5_register_gate(&clks[i], base);
+		if (IS_ERR(hw_clk)) {
+			pr_err("%s: failed to register clock %s\n", __func__,
+			       clks[i].name);
+			continue;
+		}
+		data->clk_data.hws[clks[i].id] = hw_clk;
+	}
+
+	return 0;
+}
+
+static int agilex5_clk_register_pll(const struct agilex5_pll_clock *clks,
+				    int nums, struct stratix10_clock_data *data)
+{
+	struct clk_hw *hw_clk;
+	void __iomem *base = data->base;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		hw_clk = agilex5_register_pll(&clks[i], base);
+		if (IS_ERR(hw_clk)) {
+			pr_err("%s: failed to register clock %s\n", __func__,
+			       clks[i].name);
+			continue;
+		}
+		data->clk_data.hws[clks[i].id] = hw_clk;
+	}
+
+	return 0;
+}
+
+static int agilex5_clkmgr_init(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct stratix10_clock_data *clk_data;
+	struct resource *res;
+	void __iomem *base;
+	int i, num_clks;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	num_clks = AGILEX5_NUM_CLKS;
+
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws, num_clks), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	for (i = 0; i < num_clks; i++)
+		clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
+
+	clk_data->base = base;
+	clk_data->clk_data.num = num_clks;
+
+	agilex5_clk_register_pll(agilex5_pll_clks, ARRAY_SIZE(agilex5_pll_clks),
+				 clk_data);
+
+	/* mainPLL C0, C1, C2, C3 and periph PLL C0, C1, C2, C3*/
+	agilex5_clk_register_c_perip(agilex5_main_perip_c_clks,
+				     ARRAY_SIZE(agilex5_main_perip_c_clks),
+				     clk_data);
+
+	agilex5_clk_register_cnt_perip(agilex5_main_perip_cnt_clks,
+				       ARRAY_SIZE(agilex5_main_perip_cnt_clks),
+				       clk_data);
+
+	agilex5_clk_register_gate(agilex5_gate_clks,
+				  ARRAY_SIZE(agilex5_gate_clks), clk_data);
+
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, &clk_data->clk_data);
+	return 0;
+}
+
+static int agilex5_clkmgr_probe(struct platform_device *pdev)
+{
+	int (*probe_func)(struct platform_device *init_func);
+
+	probe_func = of_device_get_match_data(&pdev->dev);
+	if (!probe_func)
+		return -ENODEV;
+	return probe_func(pdev);
+}
+
+static const struct of_device_id agilex5_clkmgr_match_table[] = {
+	{ .compatible = "intel,agilex5-clkmgr", .data = agilex5_clkmgr_init },
+	{}
+};
+
+static struct platform_driver agilex5_clkmgr_driver = {
+	.probe		= agilex5_clkmgr_probe,
+	.driver		= {
+		.name	= "agilex5-clkmgr",
+		.suppress_bind_attrs = true,
+		.of_match_table = agilex5_clkmgr_match_table,
+	},
+};
+
+static int __init agilex5_clk_init(void)
+{
+	return platform_driver_register(&agilex5_clkmgr_driver);
+}
+core_initcall(agilex5_clk_init);
diff --git a/drivers/clk/socfpga/clk-gate-s10.c b/drivers/clk/socfpga/clk-gate-s10.c
index 3930d922efb4..dce3ef137bf3 100644
--- a/drivers/clk/socfpga/clk-gate-s10.c
+++ b/drivers/clk/socfpga/clk-gate-s10.c
@@ -239,3 +239,56 @@ struct clk_hw *agilex_register_gate(const struct stratix10_gate_clock *clks, voi
 	}
 	return hw_clk;
 }
+
+struct clk_hw *agilex5_register_gate(const struct agilex5_gate_clock *clks, void __iomem *regbase)
+{
+	struct clk_hw *hw_clk;
+	struct socfpga_gate_clk *socfpga_clk;
+	struct clk_init_data init;
+	int ret;
+
+	socfpga_clk = kzalloc(sizeof(*socfpga_clk), GFP_KERNEL);
+	if (!socfpga_clk)
+		return NULL;
+
+	socfpga_clk->hw.reg = regbase + clks->gate_reg;
+	socfpga_clk->hw.bit_idx = clks->gate_idx;
+
+	gateclk_ops.enable = clk_gate_ops.enable;
+	gateclk_ops.disable = clk_gate_ops.disable;
+
+	socfpga_clk->fixed_div = clks->fixed_div;
+
+	if (clks->div_reg)
+		socfpga_clk->div_reg = regbase + clks->div_reg;
+	else
+		socfpga_clk->div_reg = NULL;
+
+	socfpga_clk->width = clks->div_width;
+	socfpga_clk->shift = clks->div_offset;
+
+	if (clks->bypass_reg)
+		socfpga_clk->bypass_reg = regbase + clks->bypass_reg;
+	else
+		socfpga_clk->bypass_reg = NULL;
+	socfpga_clk->bypass_shift = clks->bypass_shift;
+
+	if (streq(clks->name, "cs_pdbg_clk"))
+		init.ops = &dbgclk_ops;
+	else
+		init.ops = &agilex_gateclk_ops;
+
+	init.name = clks->name;
+	init.flags = clks->flags;
+	init.num_parents = clks->num_parents;
+	init.parent_names = clks->parent_names;
+	socfpga_clk->hw.hw.init = &init;
+	hw_clk = &socfpga_clk->hw.hw;
+
+	ret = clk_hw_register(NULL, &socfpga_clk->hw.hw);
+	if (ret) {
+		kfree(socfpga_clk);
+		return ERR_PTR(ret);
+	}
+	return hw_clk;
+}
diff --git a/drivers/clk/socfpga/clk-periph-s10.c b/drivers/clk/socfpga/clk-periph-s10.c
index f5c1ca42b668..f12ca43ffe7c 100644
--- a/drivers/clk/socfpga/clk-periph-s10.c
+++ b/drivers/clk/socfpga/clk-periph-s10.c
@@ -214,3 +214,44 @@ struct clk_hw *s10_register_cnt_periph(const struct stratix10_perip_cnt_clock *c
 	}
 	return hw_clk;
 }
+
+struct clk_hw *agilex5_register_cnt_periph(const struct agilex5_perip_cnt_clock *clks,
+					   void __iomem *regbase)
+{
+	struct clk_hw *hw_clk;
+	struct socfpga_periph_clk *periph_clk;
+	struct clk_init_data init;
+	const char *name = clks->name;
+	int ret;
+
+	periph_clk = kzalloc(sizeof(*periph_clk), GFP_KERNEL);
+	if (WARN_ON(!periph_clk))
+		return NULL;
+
+	if (clks->offset)
+		periph_clk->hw.reg = regbase + clks->offset;
+	else
+		periph_clk->hw.reg = NULL;
+
+	if (clks->bypass_reg)
+		periph_clk->bypass_reg = regbase + clks->bypass_reg;
+	else
+		periph_clk->bypass_reg = NULL;
+	periph_clk->bypass_shift = clks->bypass_shift;
+	periph_clk->fixed_div = clks->fixed_divider;
+
+	init.name = name;
+	init.ops = &peri_cnt_clk_ops;
+	init.flags = clks->flags;
+	init.num_parents = clks->num_parents;
+	init.parent_names = clks->parent_names;
+	periph_clk->hw.hw.init = &init;
+	hw_clk = &periph_clk->hw.hw;
+
+	ret = clk_hw_register(NULL, hw_clk);
+	if (ret) {
+		kfree(periph_clk);
+		return ERR_PTR(ret);
+	}
+	return hw_clk;
+}
diff --git a/drivers/clk/socfpga/clk-pll-s10.c b/drivers/clk/socfpga/clk-pll-s10.c
index a88c212bda12..ae80814cfa92 100644
--- a/drivers/clk/socfpga/clk-pll-s10.c
+++ b/drivers/clk/socfpga/clk-pll-s10.c
@@ -182,7 +182,7 @@ static const struct clk_ops clk_pll_ops = {
 };
 
 static const struct clk_ops clk_boot_ops = {
-	.recalc_rate = clk_boot_clk_recalc_rate,
+	.recalc_rate = clk_boot_clk_recalc_rate, /* TODO this is wrong*/
 	.get_parent = clk_boot_get_parent,
 	.prepare = clk_pll_prepare,
 };
@@ -304,3 +304,39 @@ struct clk_hw *n5x_register_pll(const struct stratix10_pll_clock *clks,
 	}
 	return hw_clk;
 }
+
+struct clk_hw *agilex5_register_pll(const struct agilex5_pll_clock *clks,
+				    void __iomem *reg)
+{
+	struct clk_hw *hw_clk;
+	struct socfpga_pll *pll_clk;
+	struct clk_init_data init;
+	const char *name = clks->name;
+	int ret;
+
+	pll_clk = kzalloc(sizeof(*pll_clk), GFP_KERNEL);
+	if (WARN_ON(!pll_clk))
+		return NULL;
+
+	pll_clk->hw.reg = reg + clks->offset;
+
+	if (streq(name, SOCFPGA_BOOT_CLK))
+		init.ops = &clk_boot_ops;
+	else
+		init.ops = &agilex_clk_pll_ops;
+
+	init.name = name;
+	init.flags = clks->flags;
+	init.num_parents = clks->num_parents;
+	init.parent_names = clks->parent_names;
+	pll_clk->hw.hw.init = &init;
+	pll_clk->hw.bit_idx = SOCFPGA_PLL_POWER;
+	hw_clk = &pll_clk->hw.hw;
+
+	ret = clk_hw_register(NULL, hw_clk);
+	if (ret) {
+		kfree(pll_clk);
+		return ERR_PTR(ret);
+	}
+	return hw_clk;
+}
diff --git a/drivers/clk/socfpga/stratix10-clk.h b/drivers/clk/socfpga/stratix10-clk.h
index 83fe4eb3133c..d1fe4578b3e0 100644
--- a/drivers/clk/socfpga/stratix10-clk.h
+++ b/drivers/clk/socfpga/stratix10-clk.h
@@ -73,12 +73,55 @@ struct stratix10_gate_clock {
 	u8			fixed_div;
 };
 
+struct agilex5_pll_clock {
+	unsigned int	id;
+	const char	*name;
+	const char	* const *parent_names;
+	u8	num_parents;
+	unsigned long   flags;
+	unsigned long   offset;
+};
+
+struct agilex5_perip_cnt_clock {
+	unsigned int		id;
+	const char		*name;
+	const char	* const *parent_names;
+	u8			num_parents;
+	unsigned long		flags;
+	unsigned long		offset;
+	u8			fixed_divider;
+	unsigned long		bypass_reg;
+	unsigned long		bypass_shift;
+};
+
+struct agilex5_gate_clock {
+	unsigned int		id;
+	const char		*name;
+	const char	* const *parent_names;
+	u8			num_parents;
+	unsigned long		flags;
+	unsigned long		gate_reg;
+	u8			gate_idx;
+	unsigned long		div_reg;
+	u8			div_offset;
+	u8			div_width;
+	unsigned long		bypass_reg;
+	u8			bypass_shift;
+	u8			fixed_div;
+};
+
 struct clk_hw *s10_register_pll(const struct stratix10_pll_clock *clks,
 			     void __iomem *reg);
 struct clk_hw *agilex_register_pll(const struct stratix10_pll_clock *clks,
 				void __iomem *reg);
 struct clk_hw *n5x_register_pll(const struct stratix10_pll_clock *clks,
 			     void __iomem *reg);
+struct clk_hw *agilex5_register_pll(const struct agilex5_pll_clock *clks,
+				    void __iomem *reg);
+struct clk_hw *agilex5_register_cnt_periph(const struct agilex5_perip_cnt_clock *clks,
+					   void __iomem *regbase);
+struct clk_hw *agilex5_register_gate(const struct agilex5_gate_clock *clks,
+				     void __iomem *regbase);
 struct clk_hw *s10_register_periph(const struct stratix10_perip_c_clock *clks,
 				void __iomem *reg);
 struct clk_hw *n5x_register_periph(const struct n5x_perip_c_clock *clks,
-- 
2.35.3


