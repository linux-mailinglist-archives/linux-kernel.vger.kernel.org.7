Return-Path: <linux-kernel+bounces-851539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D070BD6B3E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FBE518A8252
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6222FB628;
	Mon, 13 Oct 2025 23:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="uPjHg5VM"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847992FE587;
	Mon, 13 Oct 2025 23:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760396970; cv=fail; b=LpdmVp5BE4Hk6jOtF2FIMLBnMvVagTtZocPEaN+qKKKCqZLvQdM8n5hzRKxtwp+an8IgeVUR2qK7qSssU21AKon+UcF/2qxrH3JLPnafDyv7909UErjABSx0tZLETsKjkQvjwrvC+EuJFU8MVchjsWT31nqp3E8RxEP+Tkbcj9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760396970; c=relaxed/simple;
	bh=ihd0jYcUrnvBKr6L9JhrSAAOffsZARAu/bBTNRwO6DA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MUE3U7oZzUGIgcDO9WFTwgzH+8YXzwLcxmBgapvRLEEk08Um9HrhOgsbhAe4SfjdUelYxbmgpvihIqed3gdfgQ2tKizmErK5jGwYFbErM4RzKPHQzzwPpQ2+TipznGL79QlR9q6IDoDQv02SpUXV3ZFzfKk1ofdcvzLK4cC6M1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=uPjHg5VM; arc=fail smtp.client-ip=52.101.48.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXShb+BzFXYNiQkN6fmALCKsT0aEd6triIw/UpiWSpovkgdPfT+6UArIN0SLgCP1dOQ0c+5nBD412wNz57ex+169xRFwi1f2AQSnoz0lA4nYgT8VFI0SEk3MTWN5dLM4Lp35uhtj1WWekwcFMmWJ7jwALw76ib6+P14DQ6TTqlu7Zv1rDsE8wORQwn45pM9tM1eApvlb4dfegBfvBT8x58fqkdD9Khc9NFh2oVGwqKFL8iBE2xbdXobE8SncDBXVELa9SHGYqE+bKzs+p4n6ScIzQW+UgGK9cF6lgxxVWYijY/3l13V5C7isSveN7/PUvUabtHs0+5bGqPdaguBMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxgXdH9XZTMnYckwsmuMqAY0D6HyM4CQWha2GNYu1i4=;
 b=hORraDqF3ioFq5zdnWmM0o7HTAHJEDF0gi3LPpv4WmdaLuNFYRAURa00Wb8MQYdoTtNtxBEUXFQ2lUrP/w5M95fnxRabl7SuCoOKtyt+2HpZ229TJfTtL5OB+GOXIZdrLMz1PoKfpqlsoWGQ2aoJWciQvtnnHaoNCy64XMMto6AorMtbTZ8ffPW+k/m0mrUveq/YKn//RZL71pcBUVi53RJ2zAUiNipOd+D/LKij/cms1Fl5Ox+qHtiZgH0OfhqGPsqFBV5YG5Ji7XLsc6GLhnhn1rHDLz2fVXefdF91I0BzTIBOhmfIuHa4t2aJR1aM0MnxYCIvvh/jeGhzSjjwIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxgXdH9XZTMnYckwsmuMqAY0D6HyM4CQWha2GNYu1i4=;
 b=uPjHg5VMwc33FGPlo3UksARlpuM72myJxdjibpq8SWD8tUv5FBEyRXmt2wrIMRn3IpmFWrUYHDc3m0BWUg3U4/OxfxTE2Pri+nqQ599/JHUG91SeVuKjBcm2rh1+L6UatfNqzyb+uDZ1kMQ9lHvabmKuZvHJ/OKQsIdsndBzDZpPovWchzrNEv45RSlmu3t1PH+FcLhz/vjLOw9bxLN2UBRygfHrj+NVfOQnbRDt7Og6pmQgtDlUP3Yiz2WCsDi046HDxLS/EkIdsrB5aDEAeusuZvPY+38xiuuYiSuEcbw1y6+xJjK0EjxQcpeAWrp8pZtXI3m1EyYOi3FXdu00TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by PH0PR03MB7017.namprd03.prod.outlook.com (2603:10b6:510:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 23:09:23 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 23:09:23 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-kernel@vger.kernel.org (open list),
	Ang Tien Sung <tiensung.ang@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v3 1/1] clk: socfpga: agilex5: add clock driver for Agilex5
Date: Tue, 14 Oct 2025 07:09:16 +0800
Message-Id: <9326ee66cb8e33c0fe83a24e9a1effc8da252ff2.1760396607.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1760396607.git.khairul.anuar.romli@altera.com>
References: <cover.1760396607.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|PH0PR03MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: ba953e05-385f-4159-20e5-08de0aad8bad
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q+W/GT0/009pUFNS4O1gPnHR4Fw0ckX2ZKYYQHocTWu5IZ6XvpnGkLJcMkkU?=
 =?us-ascii?Q?Pg2Qv/jlp6+QKCbiSsZPKVmLBTvducMJlD4erRwPLy82dN4NEzjzN23VtKQT?=
 =?us-ascii?Q?C3XCSpkuYtkfsi7cMd85DLtezUkeDO/RVJhOh1RnMIC3jAFtRh0GOCu2qvue?=
 =?us-ascii?Q?fZR92h/prR+bx+hS5okqsPkbQDt5JZhrID7tJExbsiYx3ipdjLqROY9H64e/?=
 =?us-ascii?Q?bKymNUG4q3ROuHk3obknK+CFh70boE/gyAc0/boo9xnUqrM+vqWfhFN/M9Ny?=
 =?us-ascii?Q?rbpkayu6fK36VSUE5j7MhnfmJcEaMV9paFuKcg0nPlgR4jp2siVaWHZFAxpg?=
 =?us-ascii?Q?1vHWRt95dQeNzccMAzdfQE25uOS18kbiDhu0qvztJtys0KwWl4GSXpvFUjFP?=
 =?us-ascii?Q?BcbMEmvb1wvBuTn7RYNpQ2rh3klLnu3isu/epinyfJJ+7rfwQ6JM38hQwEcS?=
 =?us-ascii?Q?8VNxjRJo9FSc/qO9bhpM2G/JFY0Vwm2ntJYHmiNlYhDCba5Jh5jKBZsiYyIe?=
 =?us-ascii?Q?QL3sJ2di6BNpHUKpRu4mmODG1JTBY2b4eP6k0NHPXwtdUj+Bo1i0Qd4yYgub?=
 =?us-ascii?Q?L7WUExjGbqy/uMGiNagY41yd3bT2Smm18rnpqaZMaym8EiGa4uoD1cESZ9oy?=
 =?us-ascii?Q?4LANm6Ny/0g7eQgDeZfUDRC6BDdVqmHxZ1Uv7EsSB9su+OxT8ivR7xtA/Zzt?=
 =?us-ascii?Q?o8l+L7uYi46Dqn1BI6RQ+vibRzP5Y9bSIu1uixLpfFOW72u5czD38cEZdfpS?=
 =?us-ascii?Q?bbLJlUxy2Wconjw8YVbdPLhfeBUyf6IcYGh2eSEmtgH69SnAvmClYQ+MOph+?=
 =?us-ascii?Q?D4qd8yivd1cxvXF+4goyn7C6Jm4C84iUcIvUmfGv+d38TuKpyabKt7G7154Z?=
 =?us-ascii?Q?hoejd3LPFNUsXSbIEzBk+GDh89K1QW1KodxEULOUZxG+jGuZxqUjUfDrtDcs?=
 =?us-ascii?Q?4G7MD4h1HaYvFhxPBIMODJjuxA92rMO0qPx3AvUKx61bbc3ZGV5Yp5O0YImk?=
 =?us-ascii?Q?Io+i9MZmswi1mQwfyRUc8WIRQ4CjfPSyccCFgem3STqoUaG1zBjgxk7CjsPp?=
 =?us-ascii?Q?6eEWL2ckLjXzS2K0uSXgX8v/SKYsxZqDFAyV8zTc8FjAti8v1D74Kn7vh2Oa?=
 =?us-ascii?Q?cWvvMJN2Ft3pRqScNgZl5AqK0q/tNk3dFhGvWpzfJJIvtWEiRRmHk09wakjw?=
 =?us-ascii?Q?dHZ/Zpi7SOmgAgUtH7QcRvNPpQerbxjFSZXNRQFwI4aBRIvrehuuCKMbalTy?=
 =?us-ascii?Q?VSEbUtEy10Lyi8N1s4Rz4kB3yFCnjJtcgDB5rqltdKlppafa0dvWcKwNDr/D?=
 =?us-ascii?Q?kZ/0NPYMF5htvAfarnF7QZ/vWE8YXpLSW+rLVrnCq9X1i46r+AsMF5o29h/g?=
 =?us-ascii?Q?WO4hvonRkYtE3Kw9nWn1mkd3+i05hE95q5uyyQEZgBZdm8fSgI0Eo33IGeZE?=
 =?us-ascii?Q?iYxoUZhHT5BWhVgVkUVdrqLnLvGuzT/+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d0HP/4Wl92HrIdNKuf77oEHxdLC5nbWyxzy6XQNyKGlMlMPhcvLECl2eKUdg?=
 =?us-ascii?Q?fmvxXa1I4f6ZQWSOXH5g+INllyFmdUdBrBo5jaTqEzfHgS4oPAJB7kYKbfxG?=
 =?us-ascii?Q?avCocUYThuDrmK3ULAWOkBuY/4WZHiYmACpYpQ7kIBByac0yzu0reL2+FZDB?=
 =?us-ascii?Q?a3JbvxewL/HwvK/OOUIwh7hFSatPTLo7pgEXnJDW0/OFvO6grLAKtx6oQSZg?=
 =?us-ascii?Q?12cTkEG1phxhDh4pAgAYoFJwmLCaOd/sy4tazWxoUo2i0zy+gL0kdNn+FZkF?=
 =?us-ascii?Q?+CZeIlMYGo9Owq4551qrpaNDEKmzf7uK3ba76jPDpHKR/m80llVqp4SJPH8s?=
 =?us-ascii?Q?wdQOvNaPtt0UM02NTY9+If9L1voukU0uPFYBCA4eXOYtsYPb3MnjPMMH5Yni?=
 =?us-ascii?Q?WEN3uF4f/3Qg369huhO9TusfXN4C/7unPPIF1ig4ebK9hLJ7Csc75z0cCI0r?=
 =?us-ascii?Q?ujgOdWZtJW3vm+TCS27Qpz7inzqE+ZPfS0qhNva/zsQHJKx76BZ70KdSqBEv?=
 =?us-ascii?Q?1iHhitIDrMwoGrNmmfuccZqoFuYdQ6xLn5q8kxFKd9TsijD8sR345JeqRWIY?=
 =?us-ascii?Q?1sMMSVI7Z3vFFfA0QnahJuPMy2ZhvSRc78ScG9KPofi9afLedq7aS+r6bhUD?=
 =?us-ascii?Q?2rYqs9tmIFAlEhfqZTu1YRBw45BxNNloWOc9xAPpbV5ZwKDNhM34wn6als4S?=
 =?us-ascii?Q?cLofThVlc+bVw21lX7B+ZRY4mXE65zF4RmCiyu2U/g7yWV9k8UPYtDnG+FB0?=
 =?us-ascii?Q?MvcOVe+PstA41azIvnnGhrsoDajI0Tj+bZiAui+JtNHLZ1BNTHCHCAdE+8nU?=
 =?us-ascii?Q?Gwns7oqcmhMn9oXVmmwjk44ESeMT0vIQyuolLpwghn+uJg+Ci4fiHofEs8nC?=
 =?us-ascii?Q?heug10bxFsPnEKGJJyB/HE/lC1cjltQvdEQuBnug05REB0ocMPFZe5COHzoT?=
 =?us-ascii?Q?y7dY9g1ivPYbOhNbNC090vE/3b8WFqx0B/3poXFaNtF+DixxCqHTc++SuJUs?=
 =?us-ascii?Q?KR/PY16Jjx+6C+QZS97U3vwtiSmYBX4AA1vBc0kQCmu6wVSAC73gC00fderL?=
 =?us-ascii?Q?x8Y5eIwTHXrag/kIJBr1b1tYVplbxElCWUMSZMTV/3CPws65KkuTyJh+X1/i?=
 =?us-ascii?Q?sS0/SnuplDfm87ppbVKSP76iwDUAHQq1Z6BHUPC3ENpHLsuRO58N65FJEeuJ?=
 =?us-ascii?Q?16PnunxnApaSxjEh7fapBaKucdm1WdPoc5RcwWDbx7xpp1Y0dnJiEIOGnWkw?=
 =?us-ascii?Q?+IMUfE1pFVftdfTKocMeyLPO1cNHFEaAUYTRN08Gmfck26ONOJz/H+XTVZWR?=
 =?us-ascii?Q?Ve38Tz/Xg+2wBQctKaE+DuGZ4WqxtK/UmUCdEZ+gccL0JQjJIC55vsKbwV7e?=
 =?us-ascii?Q?82yeb9N23AbGWAunTtHJqILRMpzdHI1A1CG80nZafAetDrvXGceMYI8X1PJ3?=
 =?us-ascii?Q?r1yTb8gfYE61HzrYmzSPxby6R7CPphtYdc2/zYY1a4ZaPqfz74DcmsgqdLxG?=
 =?us-ascii?Q?Wcdl6I0ghL1GHayBsRXPtSgnp18cZ7929TglkcxlnC5c5hbfQ/B0HtjnJIGC?=
 =?us-ascii?Q?laQu8YmcPTjH90RYcWXSo+yg7uG1KSb+p6/FolC2DeFmyeTcCasJGEry4LWO?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba953e05-385f-4159-20e5-08de0aad8bad
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 23:09:23.0094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQzgOuBPJzXTH9HBy1dDp8So0e+MTVpzwmS5B3GqfsKuIYYAPZgAECFyckopQjoZvBz1HsAdfRNwTOmHqn+d8ZhmyZNXKarOT8l778cxuZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7017

Add the new Clock manager driver to support new Agilex5 platform. The new
driver got rid of the clk_parent_data structures as there are no
'clock-names' property in the DT bindings and use parent_names internally.
This is based on the previous feedback from the maintainer.

Signed-off-by: Ang Tien Sung <tiensung.ang@altera.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v3:
	- Fix warning of commit message line more than 75 characters
	- Align the code to match bracket.
Changes in v2:
	- Add clk-agilex5 to Makefile
	- Add Kconfig to include Agilex5 clock manager
	- us of.h instead of of_device and of_address
	- use devm_platform_ioremap_resource to simplify the get resource
	- Fix bound-checking coverage struct clock_data
	- Clean up harmless TODO comment
---
 drivers/clk/socfpga/Kconfig          |   2 +-
 drivers/clk/socfpga/Makefile         |   2 +-
 drivers/clk/socfpga/clk-agilex5.c    | 561 +++++++++++++++++++++++++++
 drivers/clk/socfpga/clk-gate-s10.c   |  53 +++
 drivers/clk/socfpga/clk-periph-s10.c |  41 ++
 drivers/clk/socfpga/clk-pll-s10.c    |  36 ++
 drivers/clk/socfpga/stratix10-clk.h  |  43 ++
 7 files changed, 736 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/socfpga/clk-agilex5.c

diff --git a/drivers/clk/socfpga/Kconfig b/drivers/clk/socfpga/Kconfig
index 0cf16b894efb..d88277e2a898 100644
--- a/drivers/clk/socfpga/Kconfig
+++ b/drivers/clk/socfpga/Kconfig
@@ -13,7 +13,7 @@ config CLK_INTEL_SOCFPGA32
 	default ARM && ARCH_INTEL_SOCFPGA
 
 config CLK_INTEL_SOCFPGA64
-	bool "Intel Stratix / Agilex / N5X clock controller support" if COMPILE_TEST && (!ARM64 || !ARCH_INTEL_SOCFPGA)
+	bool "Intel Stratix / Agilex / N5X / Agilex5 clock controller support" if COMPILE_TEST && (!ARM64 || !ARCH_INTEL_SOCFPGA)
 	default ARM64 && ARCH_INTEL_SOCFPGA
 
 endif # CLK_INTEL_SOCFPGA
diff --git a/drivers/clk/socfpga/Makefile b/drivers/clk/socfpga/Makefile
index e8dfce339c91..a1ea2b988eaf 100644
--- a/drivers/clk/socfpga/Makefile
+++ b/drivers/clk/socfpga/Makefile
@@ -3,4 +3,4 @@ obj-$(CONFIG_CLK_INTEL_SOCFPGA32) += clk.o clk-gate.o clk-pll.o clk-periph.o \
 				     clk-pll-a10.o clk-periph-a10.o clk-gate-a10.o
 obj-$(CONFIG_CLK_INTEL_SOCFPGA64) += clk-s10.o \
 				     clk-pll-s10.o clk-periph-s10.o clk-gate-s10.o \
-				     clk-agilex.o
+				     clk-agilex.o clk-agilex5.o
diff --git a/drivers/clk/socfpga/clk-agilex5.c b/drivers/clk/socfpga/clk-agilex5.c
new file mode 100644
index 000000000000..62545eb7d691
--- /dev/null
+++ b/drivers/clk/socfpga/clk-agilex5.c
@@ -0,0 +1,561 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022-2024, Intel Corporation
+ * Copyright (C) 2025, Altera Corporation
+ */
+#include <linux/slab.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
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
+	void __iomem *base;
+	int i, num_clks;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	num_clks = AGILEX5_NUM_CLKS;
+
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws,
+						 num_clks), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	clk_data->base = base;
+	clk_data->clk_data.num = num_clks;
+
+	for (i = 0; i < num_clks; i++)
+		clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
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
index a88c212bda12..1be92827cd93 100644
--- a/drivers/clk/socfpga/clk-pll-s10.c
+++ b/drivers/clk/socfpga/clk-pll-s10.c
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


