Return-Path: <linux-kernel+bounces-879720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6FCC23D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DBEE4E4E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E512F5469;
	Fri, 31 Oct 2025 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="OCK57UnX"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A912550D4;
	Fri, 31 Oct 2025 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899403; cv=fail; b=gfrHMEuxewQbZYIljZcFFaUOrMAuqiQkmDf9sSI/WEIFDAUrxNsW/e9RHB/f4eErVFeTS0wpqxaz2P26bMhpoeasooGYekk7XwuRsNd5i7HLjiDoRiknl9kysCe/TPXVYo4/21A3xrk/INYo9ynHFavd7JvmRF8FPyfS5RHDVI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899403; c=relaxed/simple;
	bh=5eg/89Ws42uGc17qHEPRfE3KMzeG8y6urM9LAUHFVCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kT/bpQmkbgxcJINCSin0036jdCebVljOWQDKBFpVOYrL9dOzAwqSiKkB7998Gf9dsjbovZMERULDeYiPOrjNBbpkvz0fDx8g4nD91DZF+oFNGFnNtDwYsr4dWLZ2JIUGa8go1ovCCVJuQBNRliD2e1qslndCjdz5/zGtv6un7vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=OCK57UnX; arc=fail smtp.client-ip=40.107.208.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U71TVkvffZw1d6a8IsXMWom6lVq1OHAzRjJ249QRkJ7UTtbTIeZQFXJ4vJ4fykC8kjXPSyAMk2LAGlkuN5/sIWqaoOQjTfLLY1wtWciZFptWIchFlBFURaHSHGwJCO5kZrTvBuMo0QgLFe+c9eMxsKlGJ3F+v8/jaVNG6SHBKuVTP7lA+9vGrMWppru5UIGWOKtcm2HgHOtS46bC8tkD2rppxtsmQok3xdTLJLBrnMTBIhy1vTZLqwo7VrT/WPwO7RfOgR4LMZY9taBrvY+1abLSBJ34DdYfQcb51LLpcFMePcDvvebZUDI5Oq5N3vYymOYOq8MRmFSXZbDZ8zeVuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWPlYpeSkSPAn5CSuCLBEG+p32crzpKc2jI6UTb7KPw=;
 b=vjtaQoeUfls1fgvD918vVMlPlK8gmEzLYGcrUBUlpls6VKGjtZCceEPMg9idD/jCimPXjT+EwEPy2FUPrd3eXhOY6Culi7P2PHYTZik9bLob3HEDeskVdHjBYUb8zioOjTYM+P6zPS8VyT7AxLJPC1sn64vEwNK2BwMmhMwKOxtRnbSdPYpgte26uujULIlmhGkJObWLwmUdzKOkXYtLV7vnZ78XAFAR62G9bXU7771Nml04dLpAaIFL4D/SEXz/sAtQ101FodedqZYKWasQoxG17IpS+jLF+xGkt1Vl467f+UibltYiNHcoAQM1pzOCOBB1MAJVmtxuMActOgQLgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWPlYpeSkSPAn5CSuCLBEG+p32crzpKc2jI6UTb7KPw=;
 b=OCK57UnXhiKgb1ztZ0jQvDjT7Wpv1WZYvNHm1UVhXHjSKq1lmyFA7n2x5dbyqB700Zjq0XAPOLjW5/ThuL8EF9z8uvuTnTw4T33AO9LsIiBkeK2FB929oAPuez3s2mEBwHc4SHmzmAlumgNAU9ArMY1ylc0xxX74/lJtbNUMKx+PyEBCzIN4YQCTHxZcn+S0wFHFH4gBVVaH5ZW9jPLcdvgQMQFUUHUfSjknWXu4Dy2HprEfzO7EPmMOoJl85wirxPAcy0+LUuX01Fktglp5JKOe9Cqj2g3nWK5Dq364J67lotD5OjlXnNWLO5vUgcf9LD/KEnTjx76yNOM10wtwkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 SA2PR03MB5724.namprd03.prod.outlook.com (2603:10b6:806:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 08:29:59 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 08:29:58 +0000
From: adrianhoyin.ng@altera.com
To: alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	wsa+renesas@sang-engineering.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrianhoyin.ng@altera.com
Subject: [RFC PATCH-v2 3/3] i3c: dw: Add runtime PM disable quirk for Altera SoCFPGA
Date: Fri, 31 Oct 2025 16:27:31 +0800
Message-ID: <e7f2bd36836e042d34296ebcd1070152ac422091.1761893824.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1761893824.git.adrianhoyin.ng@altera.com>
References: <cover.1761893824.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0053.namprd07.prod.outlook.com
 (2603:10b6:a03:60::30) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|SA2PR03MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b6eec5-790f-40ed-2425-08de1857ad83
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?clq+cP+aA/1uZjd5A9Vf6gI2G5aGPHjt+aDhnfhHFomEZ2hYlKs3WMLgZZbV?=
 =?us-ascii?Q?x3+eW+LjpktiUkqYicz5UBZXphtT6uW+ltgyN5VBAUlSyBaEMfqMq3WS5qnZ?=
 =?us-ascii?Q?Vq/bARO4s/wKRuVlH6jgkfE8TzrGQ/2sbl26qN5pZna9JY28SduSmiOs7cvd?=
 =?us-ascii?Q?rgBYYHKgXy++BoBtehomyxBjAp/Es0Vg3WgAei4MuZ6aW8zoDd9pmMDUUUmv?=
 =?us-ascii?Q?nYodMyQgzxPlLIIx6iNJ3lZ4ChdkLluGEUV0TPzjL9mCaQ01XBUjLIuLgpk9?=
 =?us-ascii?Q?wQTHUx1BZ3yP5l9zOxFR+x3qR/joSbKoQe6+yELhgzUoihHublCVlyXP+oVB?=
 =?us-ascii?Q?VfhTiVHTrgtpciwtE5iiN/asklXvmj/wC2yR7OCbZLzmvbDAYRK9XGKN7Zgn?=
 =?us-ascii?Q?TT8bzpM73ed3zxQSCRZqnk/p68JfQq5ZRFEn2+UiLvwN6lsLg14DtXMOwynf?=
 =?us-ascii?Q?Oo4rYgX70Vy9TZZ47vRA+8hjqNgNHHaAUf8eQ2Ur4xQ55O800WA0tFXm0O03?=
 =?us-ascii?Q?J0OBi9/GJKWl36CYRF7YbuHrbjEpY10y+4yIbsQ2DB8mGMCYZJJ++DTBmFoX?=
 =?us-ascii?Q?k0XFSZrk85NMw9gtxeGSPsHkSVlNBCdPz8PrHrPMOw7ResFTLKMJdVsI3EYK?=
 =?us-ascii?Q?+v7hzhx0DpXmuYQ4bop0zzkkS7jOJ0zbHj5+QlMx7oNo31r2WJ0M/C+Fs2b2?=
 =?us-ascii?Q?UoX/CWJi4Po2us7hHxFH3setsxAMe+/UkPiM/XSas87GZmxScDeihNf8jGWE?=
 =?us-ascii?Q?R2kKIC32ur0arPWAHF6nJjc2/zdN4Ii1POiUsgZkLwI/TD1VytbYrWpcWm97?=
 =?us-ascii?Q?wKf0KFq0lpE1I4pvkInKJnzcDEQnW7E7ljHteHCw9tvuF0RwRJchpQdxBCL5?=
 =?us-ascii?Q?bWgXqE37loo9O94CcOLwOXvpX+8foTx/4kFKHyvgaCJACq8gND49C/W75IRD?=
 =?us-ascii?Q?HnixWpgkNxmYuNRYI/EHDhXBaOnrlAHXDMPltdtSqWsJ8oVTMpSE3X7+hliA?=
 =?us-ascii?Q?gUqM816aC3eCfI5mx3VcRQtr4QdcjzbwFBOO0ArLVqDCoYj3ub7mrRoaDGaL?=
 =?us-ascii?Q?0bRxijmqsYybMIoF5SEvyJJ8kyehvp22Uj4PXZMkUfJNfvtUSQ95oNzwI+/g?=
 =?us-ascii?Q?DNyPF+4l7Do1u9GjMdBFAXbg00zToezJgMxcimhV8X8ClDFb8QluRqbu7f2B?=
 =?us-ascii?Q?UhnkUajXu3AycPx03j0j8pkhvNPWB+EG8JODrd95rJu/LKWtLaFaQwGU7tgF?=
 =?us-ascii?Q?IQ1c0Nb+1YKey5T6zHR0pV1XQPvZtlZQelinKVcB/EelGZJVuDK9sZ7jyziH?=
 =?us-ascii?Q?RuYyjaW/vmCEh5V1T5CpTBSscakwjHXYYvzX0Tj/n2+R89yvopEJBoUg1Fyj?=
 =?us-ascii?Q?j0UQsuLouxu9kln4w4Ap42R0FJ7fegZYuuGrs0dvQ5MXeD6cI00FxiFx241V?=
 =?us-ascii?Q?oDZySjXuGu3RxC+Y/I8JPACS5H0wUo8rpNpM2BpcVzV10qWBTWRaOuX6Sxvy?=
 =?us-ascii?Q?KIZNG5p9pMb/fwY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8wa6X4YgZxDHNb8fCRQCF51/8+h5eq2Y+V6MuVlJB3nTMdRJgfRPR8n5/tg5?=
 =?us-ascii?Q?q0RjmRDOlAkOT1MvtMLL/RiQIQsjK7lDwrq/RuwyctMxyf+zhqZyN5M6VxbV?=
 =?us-ascii?Q?ckQSzf3FwqLdZeWDQn+L2dFZzP+oy8C8GxsSUxqm+K690zVsJC9mQMqj+73B?=
 =?us-ascii?Q?Y5etvXQ3QOLDIIAXIcf27TplXrJuWh36b87xuaABZT65m/SXW+EXziKFvQZo?=
 =?us-ascii?Q?NaJBilYta+xrCu9vSVeMSPJ5OpWDkcl7gn+Dh+yH3ROQNHpQJLNuJYb/s0oD?=
 =?us-ascii?Q?ObIwy5l01BHWSkvZ99UoZXpF47RLxvmVp7XMLN7qTJLPahbKGjxj4vYYGtxd?=
 =?us-ascii?Q?w1XYCtmglRny2DA9MsnijZUXOapNTai+0gs0GJxk7uUUPGdH/1ImxKYqgtZg?=
 =?us-ascii?Q?I204S9l9uqhVQ1lM3VDpSxHKYBxLEQRKalVw/eNBlbd8RlnVmKt7z2OK7Tsj?=
 =?us-ascii?Q?Xe+EDzAjLLKimeynKxb15ak3iMuBnr1vHoMFjUMophWLFVx9ZfVA87+A+37N?=
 =?us-ascii?Q?Qg+U3iInzPVA5NPFqMeoMzgmsFTYrhBJcFoZzdEjRkFGvdYblZCEtGFWmu7g?=
 =?us-ascii?Q?sZgVUhoLJTTHriSXXEK53nj7F/tjWO9zxvya9HRLFjj8uQ5FCbUlnZ6JUsy4?=
 =?us-ascii?Q?f2JKFloT9vxNiDKlBh0shgztrm+Eh4RmcAusYnlkYxAcVXgAs/xE0jgl31tJ?=
 =?us-ascii?Q?eDVw9IVXfzKcy+hjk7vBUd2pLUueNDPCRg7xykJp6HGVx0rnSBve44lxbDGq?=
 =?us-ascii?Q?bwnnXRQdd3hi1EgJCfNa610qIaAjFZ9XNwr7qEKYszvWjU6JglJd8rJUKgMK?=
 =?us-ascii?Q?/Cxc4J3weShf9J3Z+QiDu3TMlAJbwl9vnpQKWme4ozUFyoi3pWn+QrgUPhZq?=
 =?us-ascii?Q?kM5ecKuwJcXR2k22lhH/TGroQv/e2gCY0K3/cnuYyoFTpRHp0GTyQUcR2XJy?=
 =?us-ascii?Q?kWnU+tz1kbtTJviH5Z+o+N63j0ixf+yrwajDNtYb8gCYbkWKTrGb9jlLh+1B?=
 =?us-ascii?Q?GUxK9PTwI5fblbCY/A1qfmfpuU8Gt+iOtWciMN4V7Hqlyz1Bfr2sZb9GhRKU?=
 =?us-ascii?Q?SINKyOTgpre16gfkqImsEXvUGIpjLaeKs/5LA2SuETIvlZOahn9mXi3QwIy5?=
 =?us-ascii?Q?45se3WzkYRyYH+MaiCqOmULn9kAZrxKnM4iEP0EIdXZvWaikNRetA03UIJ+n?=
 =?us-ascii?Q?nRLug1V7dgJpJXLBrkLcXtkIF4hkOyiXXtBeJrc1kB2VloUo1np/YnsjUT6o?=
 =?us-ascii?Q?4zJHFnm6R7WgMC10BX+Nf5CHHYTRDomtCUSGrWdMEqiX8aiZaAc3KdZm8RsQ?=
 =?us-ascii?Q?3hQOIPVH8/PHCA6YtydqgiPBt9LzA0eAdHQsrP34C4hqksPPx7V+5X52VUWM?=
 =?us-ascii?Q?Ji3y3cJk7SmZo/xCXCWEX1IMvcT6lvbgOuAkBEWjYVmhozb9OZgPjHt37ooy?=
 =?us-ascii?Q?CsnWSmJnyrl6X4jwnAq/88hskfaZZZxT1HCeaCqNV3n3q1JFsWx+P26PTx7e?=
 =?us-ascii?Q?yxaZZpaRagpGMizPw8/DLF715OQBD9AMIAv1reSWfiZVdVGJS9+VGQU8RQM1?=
 =?us-ascii?Q?Z0lYbOo9h20BvLjJJ2bqmp6MfYxdIKzqwVhtOa0rSQ1D21+rLEax3byLLWMe?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b6eec5-790f-40ed-2425-08de1857ad83
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 08:29:58.8458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RxYSp1pdMI3PlWLdFvGaIZrpH3kil0rXCX3dtIq2GggdekgfQnqtDwN9BUUs5pdPYjBbSSfUdJGQ9VpgzeeKpzY33ggA4igJ4b+N5sAFgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5724

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Add support for disabling runtime power management (PM) in the
Synopsys DesignWare I3C master driver through a new quirk flag,
DW_I3C_DISABLE_RUNTIME_PM_QUIRK. When this quirk is active,
the driver skips all runtime PM operations (e.g. pm_runtime_enable(),
pm_runtime_get(), and pm_runtime_put()), keeping the controller
continuously powered.

This change addresses a reliability issue observed on some Altera
SoCFPGA systems, where the controller may enter a suspended state
while a slave device issues an In-Band Interrupt (IBI). Once suspended,
the controller no longer drives the SCL line, causing the SDA line to
remain low and leaving the I3C bus in a hung state. Disabling runtime
PM ensures the controller remains active, allowing IBI transactions
to complete correctly.

A new compatible string, "altr,socfpga-dw-i3c-master", is added to
represent the SoCFPGA-specific variant of the DesignWare I3C controller,
which requires runtime PM to remain disabled.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
---
 drivers/i3c/master/dw-i3c-master.c | 176 +++++++++++++++++------------
 1 file changed, 106 insertions(+), 70 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 9ceedf09c3b6..2a3a875b2607 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -227,7 +227,8 @@
 #define AMD_I3C_PP_TIMING          0x8001A
 
 /* List of quirks */
-#define AMD_I3C_OD_PP_TIMING		BIT(1)
+#define AMD_I3C_OD_PP_TIMING			BIT(1)
+#define DW_I3C_DISABLE_RUNTIME_PM_QUIRK	BIT(2)
 
 struct dw_i3c_cmd {
 	u32 cmd_lo;
@@ -635,12 +636,14 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 	struct i3c_device_info info = { };
 	int ret;
 
-	ret = pm_runtime_resume_and_get(master->dev);
-	if (ret < 0) {
-		dev_err(master->dev,
-			"<%s> cannot resume i3c bus master, err: %d\n",
-			__func__, ret);
-		return ret;
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		ret = pm_runtime_resume_and_get(master->dev);
+		if (ret < 0) {
+			dev_err(master->dev,
+				"<%s> cannot resume i3c bus master, err: %d\n",
+				__func__, ret);
+			return ret;
+		}
 	}
 
 	ret = master->platform_ops->init(master);
@@ -682,7 +685,8 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 	dw_i3c_master_enable(master);
 
 rpm_out:
-	pm_runtime_put_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+		pm_runtime_put_autosuspend(master->dev);
 	return ret;
 }
 
@@ -798,12 +802,14 @@ static int dw_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
 		writel(master->i3c_od_timing, master->regs + SCL_I3C_OD_TIMING);
 	}
 
-	ret = pm_runtime_resume_and_get(master->dev);
-	if (ret < 0) {
-		dev_err(master->dev,
-			"<%s> cannot resume i3c bus master, err: %d\n",
-			__func__, ret);
-		return ret;
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		ret = pm_runtime_resume_and_get(master->dev);
+		if (ret < 0) {
+			dev_err(master->dev,
+				"<%s> cannot resume i3c bus master, err: %d\n",
+				__func__, ret);
+			return ret;
+		}
 	}
 
 	if (ccc->rnw)
@@ -811,7 +817,8 @@ static int dw_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
 	else
 		ret = dw_i3c_ccc_set(master, ccc);
 
-	pm_runtime_put_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+		pm_runtime_put_autosuspend(master->dev);
 	return ret;
 }
 
@@ -824,12 +831,14 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 	u8 last_addr = 0;
 	int ret, pos;
 
-	ret = pm_runtime_resume_and_get(master->dev);
-	if (ret < 0) {
-		dev_err(master->dev,
-			"<%s> cannot resume i3c bus master, err: %d\n",
-			__func__, ret);
-		return ret;
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		ret = pm_runtime_resume_and_get(master->dev);
+		if (ret < 0) {
+			dev_err(master->dev,
+				"<%s> cannot resume i3c bus master, err: %d\n",
+				__func__, ret);
+			return ret;
+		}
 	}
 
 	olddevs = ~(master->free_pos);
@@ -893,7 +902,8 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 	dw_i3c_master_free_xfer(xfer);
 
 rpm_out:
-	pm_runtime_put_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+		pm_runtime_put_autosuspend(master->dev);
 	return ret;
 }
 
@@ -929,12 +939,14 @@ static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 	if (!xfer)
 		return -ENOMEM;
 
-	ret = pm_runtime_resume_and_get(master->dev);
-	if (ret < 0) {
-		dev_err(master->dev,
-			"<%s> cannot resume i3c bus master, err: %d\n",
-			__func__, ret);
-		return ret;
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		ret = pm_runtime_resume_and_get(master->dev);
+		if (ret < 0) {
+			dev_err(master->dev,
+				"<%s> cannot resume i3c bus master, err: %d\n",
+				__func__, ret);
+			return ret;
+		}
 	}
 
 	for (i = 0; i < i3c_nxfers; i++) {
@@ -978,7 +990,8 @@ static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 	ret = xfer->ret;
 	dw_i3c_master_free_xfer(xfer);
 
-	pm_runtime_put_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+		pm_runtime_put_autosuspend(master->dev);
 	return ret;
 }
 
@@ -1089,12 +1102,14 @@ static int dw_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
 	if (!xfer)
 		return -ENOMEM;
 
-	ret = pm_runtime_resume_and_get(master->dev);
-	if (ret < 0) {
-		dev_err(master->dev,
-			"<%s> cannot resume i3c bus master, err: %d\n",
-			__func__, ret);
-		return ret;
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		ret = pm_runtime_resume_and_get(master->dev);
+		if (ret < 0) {
+			dev_err(master->dev,
+				"<%s> cannot resume i3c bus master, err: %d\n",
+				__func__, ret);
+			return ret;
+		}
 	}
 
 	for (i = 0; i < i2c_nxfers; i++) {
@@ -1127,7 +1142,8 @@ static int dw_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
 	ret = xfer->ret;
 	dw_i3c_master_free_xfer(xfer);
 
-	pm_runtime_put_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+		pm_runtime_put_autosuspend(master->dev);
 	return ret;
 }
 
@@ -1272,12 +1288,14 @@ static int dw_i3c_master_enable_hotjoin(struct i3c_master_controller *m)
 	struct dw_i3c_master *master = to_dw_i3c_master(m);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(master->dev);
-	if (ret < 0) {
-		dev_err(master->dev,
-			"<%s> cannot resume i3c bus master, err: %d\n",
-			__func__, ret);
-		return ret;
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		ret = pm_runtime_resume_and_get(master->dev);
+		if (ret < 0) {
+			dev_err(master->dev,
+				"<%s> cannot resume i3c bus master, err: %d\n",
+				__func__, ret);
+			return ret;
+		}
 	}
 
 	dw_i3c_master_enable_sir_signal(master, true);
@@ -1294,7 +1312,8 @@ static int dw_i3c_master_disable_hotjoin(struct i3c_master_controller *m)
 	writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_HOT_JOIN_NACK,
 	       master->regs + DEVICE_CTRL);
 
-	pm_runtime_put_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+		pm_runtime_put_autosuspend(master->dev);
 	return 0;
 }
 
@@ -1305,12 +1324,14 @@ static int dw_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
 	struct dw_i3c_master *master = to_dw_i3c_master(m);
 	int rc;
 
-	rc = pm_runtime_resume_and_get(master->dev);
-	if (rc < 0) {
-		dev_err(master->dev,
-			"<%s> cannot resume i3c bus master, err: %d\n",
-			__func__, rc);
-		return rc;
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		rc = pm_runtime_resume_and_get(master->dev);
+		if (rc < 0) {
+			dev_err(master->dev,
+				"<%s> cannot resume i3c bus master, err: %d\n",
+				__func__, rc);
+			return rc;
+		}
 	}
 
 	dw_i3c_master_set_sir_enabled(master, dev, data->index, true);
@@ -1319,7 +1340,8 @@ static int dw_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
 
 	if (rc) {
 		dw_i3c_master_set_sir_enabled(master, dev, data->index, false);
-		pm_runtime_put_autosuspend(master->dev);
+		if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+			pm_runtime_put_autosuspend(master->dev);
 	}
 
 	return rc;
@@ -1338,7 +1360,8 @@ static int dw_i3c_master_disable_ibi(struct i3c_dev_desc *dev)
 
 	dw_i3c_master_set_sir_enabled(master, dev, data->index, false);
 
-	pm_runtime_put_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+		pm_runtime_put_autosuspend(master->dev);
 	return 0;
 }
 
@@ -1573,11 +1596,6 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 
 	platform_set_drvdata(pdev, master);
 
-	pm_runtime_set_autosuspend_delay(&pdev->dev, RPM_AUTOSUSPEND_TIMEOUT);
-	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-
 	/* Information regarding the FIFOs/QUEUEs depth */
 	ret = readl(master->regs + QUEUE_STATUS_LEVEL);
 	master->caps.cmdfifodepth = QUEUE_STATUS_LEVEL_CMD(ret);
@@ -1592,6 +1610,13 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 
 	master->quirks = (unsigned long)device_get_match_data(&pdev->dev);
 
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		pm_runtime_set_autosuspend_delay(&pdev->dev, RPM_AUTOSUSPEND_TIMEOUT);
+		pm_runtime_use_autosuspend(&pdev->dev);
+		pm_runtime_set_active(&pdev->dev);
+		pm_runtime_enable(&pdev->dev);
+	}
+
 	INIT_WORK(&master->hj_work, dw_i3c_hj_work);
 	ret = i3c_master_register(&master->base, &pdev->dev,
 				  &dw_mipi_i3c_ops, false);
@@ -1601,9 +1626,11 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 	return 0;
 
 err_disable_pm:
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		pm_runtime_disable(&pdev->dev);
+		pm_runtime_set_suspended(&pdev->dev);
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
+	}
 
 err_assert_rst:
 	reset_control_assert(master->core_rst);
@@ -1617,9 +1644,11 @@ void dw_i3c_common_remove(struct dw_i3c_master *master)
 	cancel_work_sync(&master->hj_work);
 	i3c_master_unregister(&master->base);
 
-	pm_runtime_disable(master->dev);
-	pm_runtime_set_suspended(master->dev);
-	pm_runtime_dont_use_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		pm_runtime_disable(master->dev);
+		pm_runtime_set_suspended(master->dev);
+		pm_runtime_dont_use_autosuspend(master->dev);
+	}
 }
 EXPORT_SYMBOL_GPL(dw_i3c_common_remove);
 
@@ -1742,12 +1771,14 @@ static void dw_i3c_shutdown(struct platform_device *pdev)
 	struct dw_i3c_master *master = platform_get_drvdata(pdev);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(master->dev);
-	if (ret < 0) {
-		dev_err(master->dev,
-			"<%s> cannot resume i3c bus master, err: %d\n",
-			__func__, ret);
-		return;
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		ret = pm_runtime_resume_and_get(master->dev);
+		if (ret < 0) {
+			dev_err(master->dev,
+				"<%s> cannot resume i3c bus master, err: %d\n",
+				__func__, ret);
+			return;
+		}
 	}
 
 	cancel_work_sync(&master->hj_work);
@@ -1756,11 +1787,16 @@ static void dw_i3c_shutdown(struct platform_device *pdev)
 	writel((u32)~INTR_ALL, master->regs + INTR_STATUS_EN);
 	writel((u32)~INTR_ALL, master->regs + INTR_SIGNAL_EN);
 
-	pm_runtime_put_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+		pm_runtime_put_autosuspend(master->dev);
 }
 
 static const struct of_device_id dw_i3c_master_of_match[] = {
-	{ .compatible = "snps,dw-i3c-master-1.00a", },
+	{ .compatible = "snps,dw-i3c-master-1.00a"
+	},
+	{ .compatible = "altr,socfpga-dw-i3c-master",
+	  .data = (void *)DW_I3C_DISABLE_RUNTIME_PM_QUIRK,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, dw_i3c_master_of_match);
-- 
2.49.GIT


