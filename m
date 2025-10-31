Return-Path: <linux-kernel+bounces-880780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B046C268B2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD563421936
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B919351FB2;
	Fri, 31 Oct 2025 18:17:32 +0000 (UTC)
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021142.outbound.protection.outlook.com [52.101.95.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DD834E755
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761934651; cv=fail; b=p6+7IINBNAylI4hQQ03HXAlSrhgBJfamDuiUlkvqWSn0A1jnyxXTo5CxdyqV+0JayowrSkCabJcwqwtU6hHeJHSAFAqFT8YqSrEKRMtNb7WJv2WCaoHmPYQ4QEyBEt0mMyZmOHCSEiJWIfCVhD5d8PylmTtD+XcwcLNWU4MK5Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761934651; c=relaxed/simple;
	bh=oyknOj5diMplzsOxfrys8niJiNj0rW2Ci/zI2rJYKac=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OvUWHS6//cYVJO3NmASp/w8PicrGwrgNEN1UzXflGd/px60ygotvdCqjo7XdbZKYpLbKqot9IDwOZ0syU8sxPCzslmapEix2WysnLV0L0eRjXyR3R/IvfqnHk9MeEOlh4PY3eqtyV4Y6K0sh6pp4h1hSZqlnm4t5fVkgNXpPBe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqZwzSyCIl87/uNaxv89qe5U+Lr7nHbcwGy9GMDWCiSoyytR0tRVRJD50WBtHy+aoIjwqKminuZ1gplnuQPUr4DcKnvLgl7cFU/fG2Ig0xffd6vHbnYz4JYwpGGfLub9oEgFJ4gW0bg2qaQ68OHAVeR6/JiHf9e3SrvREa1nczwA5JRbttPPvTkqI2wS8zI8I7kltyZm/sLgucc6u10HEpRTJDJDCioALr2b8eUedqcvwSe7qEQ+pRDyoHyTTCQOkclXMpwBpBO8uQoZt6NWNVChTSpIwZLwvao8/ics668eL4q2YVBFTrGBx0cnooJrPpibtjyt7+n9PgtB5RJ7mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FHW6elh7R1dCBuxKbjk+Ko7FhlC4TQ1250SZwsGMuE=;
 b=uKTGu5YHrNsua+YCuM4k76cj3OnHg3no2UD0YcKe0AJk743OIcqJ4gJ9CfxLaVGfdpp/0YSFE9VVrQ5wmDq+dXN3AAeEhwCVEoN0J/eNRnR7WyMLlp3qMBLKDeyYYttqve1mlBJkTwEuDO5AYDtw98uIShgvAzP5mMSSXbwqmJK90jJZDxa3HAOQvUWMjbujsSclqYc4N+To+XHHnrpPHKSMkskXSuxqdQlM9VYk9WayYP0EMk+HsFF1f7JE7ZVtZmgUV5Yv/fILYGjjN09KDA3OEjaHpkXCh47AB8M8ADfpHJTLSzx+mi8ECBVphWPRr15NKRJlMKyeOsCJqJdO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOYP123MB2719.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 18:17:26 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 18:17:26 +0000
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
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] fs/resctrl: Show domain CPU list in schema output
Date: Fri, 31 Oct 2025 14:17:20 -0400
Message-ID: <20251031181722.250851-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0766.namprd03.prod.outlook.com
 (2603:10b6:408:13a::21) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOYP123MB2719:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b09c34-e23c-4a7d-c678-08de18a9be91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e4piQOb3yCVBD/1AUXhZ1slkGV1XIZ4CrGVkAw3uA/xAJQ1z5HA+3UygWYv7?=
 =?us-ascii?Q?eUpL0TVt0G7w09viFvSwUDK8tlub2Xz/u1C+05u1SrXWSky9TmIg7xP/7vJM?=
 =?us-ascii?Q?04FZYlqfAaGXQ1VqVGtb7KFsdYPkVCEKAKMjGBR4TfqaNnlZAxcpdhvR3tQ/?=
 =?us-ascii?Q?0jsHBs8DLuKFZli/Dq+WAUMLzx8ykm3PqIe+rGaYSen4C0Z4PKrZIOF/walp?=
 =?us-ascii?Q?p11OmP/D80er5yvcE1ct2JwwwXfqWu4RwaHcSlkPS3Jm/crA0mKsO5DdA31N?=
 =?us-ascii?Q?DgoF1PWrNXb61zq6iJvuMT7j6C4ZqSUmJwxnAWlOCrOTDZXpzskVQmnOiM7k?=
 =?us-ascii?Q?x58uVv7VVshdpUStLyTWrq6DnArgW8cMVepdoOaqc3iMoas2NvWMDd/pWXcK?=
 =?us-ascii?Q?gmsT7Hz7ZqVyb5VKsTZVow3Twuiuz7FF8BWX3r/BVbQpKSoFQTyVHpl4xpWw?=
 =?us-ascii?Q?6COcuK+eZR14sdhw4mxJ7w9w2/girOhsu5XLbIajfV9KaPtFpyav3kkFxjhP?=
 =?us-ascii?Q?sODOB7NkaCTxkGDUh4ms1jxpjk2l+SiHDKqdj6adyB5lfxJh7Iyb4lyNITLK?=
 =?us-ascii?Q?WitZ0drvwtH0ZU5AKuwh3jiBg9oQxHvT+qaH5hDMw6en5RrhI/Yd8SyjqEiz?=
 =?us-ascii?Q?89pJ2rFlAxGUGy2F4D3grG9PRGu+Cvb3OATc6/D9UF/R7dIwOpYJ6qQLdhto?=
 =?us-ascii?Q?4ljoSsd4HnxLRMOlondMzq/BZwLy1zZfaCB+35ni8+dFMmxbEkYxi3qlZWUE?=
 =?us-ascii?Q?nTyGhIqAoSTZZiUgf0Q3ZFJ93G7hMSSxUIuvlb1MO1093dvbtPPR/aYFQl74?=
 =?us-ascii?Q?NH+s7wv8+qale5wnnb13PMlB5aWACw+G519HUKbrJpJj/G2UXDrnFz6JCcbB?=
 =?us-ascii?Q?uXMYP79SWsKxAum0u3W41MYx4EwJwgfXfz0rpKp53VeKkhMSHAV4lDhHBkTd?=
 =?us-ascii?Q?ePOahjj9liY6mmp1lnN52e/16Jv2PqX7/kEbOvizC3uHD23QaG79RO5bMD/r?=
 =?us-ascii?Q?knMbqXFfuVaeaDneAhMt6m0PJARx7Egh/Jp68rVj8oBgqEE04DFxnpinMaeW?=
 =?us-ascii?Q?lNUvkNVTjsVwDUtd9XtWzMkfkfrzOgGmFAa0A3M9dOUlOXPVHYsabYpw2OzG?=
 =?us-ascii?Q?7ez60RERUpBzE8p2BGSoRTveW9ji7CBv6CmdAlXoLU6i1x0EzfJmrHpt8H+d?=
 =?us-ascii?Q?KSiqCit3RrU2hFxemi6NrWKaQprZ8AK2b8PvO1wE24IVA4qRCosWByCNQIm9?=
 =?us-ascii?Q?v/olo2cz6xQu6QOzutWoAm4pwQqPB78BiVsVtseEuXBct0Me7eJwx0jrbVWR?=
 =?us-ascii?Q?Q7w4fgM65xicAUonmx7yIlLvbfeOYzeHtETOCyRAiTn+16tWpeSXQrCTtqa0?=
 =?us-ascii?Q?ssvda9dA+jaPiJOhlSYeilQUox4vhIXnwHdSH10xqPMeLwXCKQ2Dy6srCZDv?=
 =?us-ascii?Q?Z7iSOlfI5uDRCm9SrhscOZMgD7sUwlDy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m+k6R3vI6Sy092FfBybmk5yXrXv4klaKT6kLcKHrKdI9spyCoejUaRLTPcKK?=
 =?us-ascii?Q?kqDVl+ShyNEwI1p21a2v+jsn76QkTGkiayZZ4P4sf18xsVX5wYLjN8K9sMqM?=
 =?us-ascii?Q?dov9xcrejtBbjPPKhzZjNNhCGjyppWjI3Ndeaq8M4qjSjGZ69542oorAkYXZ?=
 =?us-ascii?Q?BV9Wzl3FcNiQ8hMz+Z4k9pXi9+xCBg5HAAq2H0SUlSIkW3C+rGw0dGQQMiQE?=
 =?us-ascii?Q?QLg6BGn9RXfbN0gfJgGm6mUBP62LLtHNGDdXArKF8xrXaWsHjc0VNd43zzNs?=
 =?us-ascii?Q?NQfVGN+5lBdnrz23Sc0QlMn/zVpYzqtQGp5gsuUxwUmcF/rJN0kNc5UKIqad?=
 =?us-ascii?Q?wPThdVJlwpYRQGduMrMsegAx+QALfIQWppx9Kd3iEa4BskIXPAoy27JAuIWR?=
 =?us-ascii?Q?JKAzvgyjLzvzGwQ9iD+WvnsRZjww/6F0X4p9VPAnnUZHCkCLjfBbZIL3kkT3?=
 =?us-ascii?Q?AYW9yttqqriCtjFRN9g8obmHat1DAZEEX+eNt3jzotF4KpftiVEk0828brBl?=
 =?us-ascii?Q?a9SPclTYe7qkojrM8GEhT2doYPGP05DJdlzFEqYGcF7lBQDgor0Ws2j8QptN?=
 =?us-ascii?Q?grCpwpkOIFSMu9q9b+WQCTL6KsJzhwvFf9EXSYhlaCmzF2MbPx5evTlsLxcw?=
 =?us-ascii?Q?S1jakZPNuvNIuKLG/tPkwqpslmbzkz2DaNQYJxGEBD7j1pues7GM3/XYaHS2?=
 =?us-ascii?Q?6TbEyteHEUeCLV6zEqxPE0iiVgiH4AV2Z3ZNhLQ5UTZgwP6ojd7OSTj1Wdmb?=
 =?us-ascii?Q?Rui38NPaemRLFRXB6gQ3HhYn2imwqaxzRA4bIDMxYZHj7VhMLvfa0rvE6M2l?=
 =?us-ascii?Q?BYLgvLUp96ymnBcLopi+znU48y92QKgtzFoCa7SGSbz6MlqtHviiTv15j9Ei?=
 =?us-ascii?Q?ZU64dQZ+ezaOGM1SCTd8Wsz0vIF+1L1pq1esrJXBE+JcKFhuO4aID5/scdJB?=
 =?us-ascii?Q?IA3Sjq6HOiUZemtzJHxCeU3MapyecGhpjCCoNvw3I9nBjRTUMeLVowaOfB7F?=
 =?us-ascii?Q?+iSxmPkmS0LTqDR24VzL8wTpH/Yic0DKM7GHHkRBJacw7XczXx+erXr0B04e?=
 =?us-ascii?Q?TTsDfWzQVrXW/dWlTV4MZ8HGMNNI//BLNqlkihZ6zngVhNhepZCojdoX2pyP?=
 =?us-ascii?Q?1vDNDxv8xVKAlauZu0suSd9IHP9PWnsMMQfLoFlzNMGz7baaWL1NCuYjPyHu?=
 =?us-ascii?Q?PxM7MiiKCfFym9vE+HwV8HmLfjXiGDh9FSy15gkN/LydAqBMT6ErDhMcmJq/?=
 =?us-ascii?Q?jbcUiakUSMX9Mdsof6tCTWH4DDRm3cCPUataOxCjZmMN7uGMKaOY+Zd3Ssjl?=
 =?us-ascii?Q?+DR34n37RSAAiPhbbLYoHV/0H1Xsj4NUp3SZ8chHsl/aALGiz7OaQmJYnAx+?=
 =?us-ascii?Q?PSziDzV+tR19xkM/CgyIpVUrXhogcMlmHELa/8E8QgX4e/4l5lw9TcsVthbL?=
 =?us-ascii?Q?iZQiV68U2NeS75Xdut52W5w4fTBTsZlLTuVmKoTwvEOKO626VX//+KRUGhO6?=
 =?us-ascii?Q?flkwJsAbjGdxqpqmo09uT+JXGK+O56QkP4PDtk4u/eV9nvccOs0AHn7gR/DN?=
 =?us-ascii?Q?/N9rIK1EgHOZ+QxfwYRbd9cOgWKQNOfWxHVRuwW0?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b09c34-e23c-4a7d-c678-08de18a9be91
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 18:17:26.2531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THONZ38x1A7OyzyfxszboDXTuOfWhwciy/6wiTrFu54Xs9K1VooZYpaPg+jVKvW06MRjWivCjQJ1JktsihvHag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB2719

Hi Babu,

Following up on your work in the x86,fs/resctrl: Support L3 Smart Data
Cache Injection Allocation Enforcement (SDCIAE) series, I've prepared a
small enhancement.

The current resctrl schemata output provides only the domain ID and value
(e.g., 0=ffff). This patch updates the schema format to include the
underlying topology, making it easier for users to correlate the resource
domain with its assigned logical CPUs.

The output changes from "0=ffff" to "0=ffff,0-15".

Please let me know your thoughts.


Aaron Tomlin (1):
  fs/resctrl: Show domain CPU list in schema output

 fs/resctrl/ctrlmondata.c | 4 +++-
 fs/resctrl/rdtgroup.c    | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.51.0


