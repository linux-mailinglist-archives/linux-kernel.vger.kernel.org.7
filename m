Return-Path: <linux-kernel+bounces-783651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71579B3303E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 15:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E00597AF4E1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 13:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163662D94BC;
	Sun, 24 Aug 2025 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MagnYlWV"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012012.outbound.protection.outlook.com [40.107.75.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B242DCF64;
	Sun, 24 Aug 2025 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756043739; cv=fail; b=SUsTo3v1nwMZFoCVn+s5XtJjVQe+9Eo0IS8gX8uN1VDlLXgvyHrISX9OXcj0XR0mVOycJmmMCJffJSm/f50TikxyPzOqFuUYwh8RDFOXtaK/i7qBpOa1zoJm0Y24BCzNHxOL7/POuxJuaJqgcw8Wjh6n/ow44sVhXKJ+4TydAIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756043739; c=relaxed/simple;
	bh=biQWkaxUUXhg5gSaLZocFOviSzW5DlOidG9P4rEToqc=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mAAyD1O+TmkdV5YoP6b73jVgLoyc1i303Ez8vbfyuSeHPQrADnfEYSXE+NQPjW3G38ueP4mZ/pAQU3rvUsPy1be8sY5A9wBexp31RGNN9Yrs5+Ys/HSQ2Gl5+cSgf9bhGRtAow7gnFgcw0YyWAcOEKSdHZo5GZ4uHuLgBcWbRuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MagnYlWV; arc=fail smtp.client-ip=40.107.75.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qiuet52NpbHUyAVgrvFqih3LC0Ev3vkmLNxhlSx6nly7uWOtCPYn7UwxBq7+h0EO/LDN2FNPFlghj1bz0WgBuDR6KoTA1QCVJifWjzO+xvkbnKil8IM3gwrwn7XiZKQn1K0Oc1QqPELjoiBqssJBETie+iGXMy6Ue5SHtSchKOQ4grvN644iYsCIlmMxhREIT0ZguGLy4sPzpXir9BcFzs6ia9ESqMUe6Dg5FC2hqOvd4LlzlbRzo4x5xTAdo3cjflVsRcwt/MDqp5PBCF40sMsEdgGEqoAlEJbevi3XtyKMHWlYTjWZlzROAi3+E6Q8w1WQ2PTb5+Xhl7j53sn5cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hE+V9dbxo72ZY5Mw1IlOjlOnoN5BgQRgSql3IbwNbck=;
 b=IWyzOVCj2AFSKNxdrZC4Z858tv0pgdH8tD36hmTXJZFequXCPy3s6GJw7gi5KTHp15TogSPAKuiy+lRkxrZA46L2ECDNQnIW2gqg99ubXaE9uAVLYKaTdEDynAs90OOzbE2l8f4PJC1UEEP4i7OzEMbR6L3RcgsQpWskUScwGsMOVfF+eSY3rlbqTzj3zlxZnRVHUnLncU9z+Nbn2Myfr1ZdOrjrQT5bhs1J46L3r29+oJ6x4SjloC2qROtcMMjI340RP8cywEF1WEoA6IEP/UzfGSSH6Pb655HMrI0idgYzpPJSGXvn+jJHoRAyXMJEyCRcXXvq6itimeuZ+smVTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hE+V9dbxo72ZY5Mw1IlOjlOnoN5BgQRgSql3IbwNbck=;
 b=MagnYlWVHs2ac7kv4FxbTsjyw+wWqDHRL7uQmpXkdFFzoz5lyeywPXTfeZc2jDSaemcbNeQUKZFTf7pTkHG7Aj2veFXjhvbnqkpSqmYtANalIh1lZeQMF3TRBiqzIA80oPAWUMGlU86T6NeF53G3BPsMTwmnNyJRp2FZB7ZLYEQNcov+ZrcQ0gvg6sMsHdyo8qHyU47wENHmmudWLUO/IAxRGqyya+rVdcV3pZcC5ckDTrYknbSsIlunMUPz+EzgfNy+VNNLpmC/eMzJtsRO6IotyBr5eGROugUl73M/UOCtqNwDae4dCa0k7fum1lEeAuaYGB8UjNo6Oxo2kn4vew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB5685.apcprd06.prod.outlook.com (2603:1096:400:283::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.19; Sun, 24 Aug 2025 13:55:32 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.019; Sun, 24 Aug 2025
 13:55:32 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Philipp Stanner <phasta@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sound@vger.kernel.org (open list:SOUND),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/3] ALSA: use vmalloc_array() to simplify code
Date: Sun, 24 Aug 2025 21:55:09 +0800
Message-Id: <20250824135521.590780-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 64dbc079-3210-4875-75c9-08dde315e466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5NvRdvz654qskuJP34uJvmrETuvY5umi2hNGkKFsrhtWfrYCtW9zA17CdlRv?=
 =?us-ascii?Q?JSXIQ1WcclrwgrIqkV+iJux6bR5cmuh9y/FKFBvNV0aIuuxiB1Q9+PUi0t9m?=
 =?us-ascii?Q?3OytCa4blhI1LeCSNWAl9RmBx56nkwq9/yyxbcFgmWsFAcaW4JHm/E7QOmFF?=
 =?us-ascii?Q?ZepIBWKOXrgSMOzPS1mtFWrJ+GFuGCi5znMK74wQLsmPeEjtgf6rFUVSvWlp?=
 =?us-ascii?Q?/rP/inSPuJFktb2k7VKhLfjco74mCZtB0+OgWvEBurrCMG+LFBFhDNx7Sy3y?=
 =?us-ascii?Q?PLCOvPdVxgM2Luys0PKY8tt8+vTXtsqA/jKOC3NYL1LR3dr4q8vpiSzCgd1U?=
 =?us-ascii?Q?KS4SRoIZYdJPFsWbA6FE3v7HYr/sAeHa5I3IiKGCUpXapiOWIfK8DHOK+9X4?=
 =?us-ascii?Q?vJHESnGgFgbIDj0MNBvtx55waVmGc/1bjjong63WnL9sCh6jlMj+fr/Ugg6Q?=
 =?us-ascii?Q?hKl1R2QLICBRMWaiZhbMrEvlUGTAL7hF5GEZyLnODZE7dD/RJFogfKffCb6p?=
 =?us-ascii?Q?rF3tNmg6l9CmBl5lSDIGszRAsEmEXxCNqq0U1Rm1LmxioX0vTVmA5fWGHzjT?=
 =?us-ascii?Q?o19QcXJIxS0m2MO20ALxOnxl7/MC0MA8U9WdNh4IXKxJV+I3S1bHRHxnx4TO?=
 =?us-ascii?Q?EmP9vf1jPBVuwxFPErznsS2vvmp2XZrqtMdsLchvD1s2DxwYhD6DnguNmE3b?=
 =?us-ascii?Q?NoUqkhJNB7HIeO2AacOdAgaar7pqa/3Q4uht8OmvyFEj9wjCtniRK3Kp34vu?=
 =?us-ascii?Q?JuO9VV17xaPFgRaQeW+sZ3yT7+Y7enZPHW4a5dnfgriirMNZw6M6KSFxQ28A?=
 =?us-ascii?Q?/J8T4PgNlI1zLT4D1r2taJGymoPdyg21EQF89TkSHm+RQaQfN9p1VSGZrPbz?=
 =?us-ascii?Q?juZjnVvOHAxjMimfbYsm5JAS4BIEfNiadUq6gPr0GRt6g7AJ3vOfO+gKnbXB?=
 =?us-ascii?Q?kJdyWxEQJukzxn0DVx+8xSCjRs+1B6FFesMxjLSIP5ObIX/YEp/9/yvdYT52?=
 =?us-ascii?Q?SJjBRRTu1QQiCbAnto0UfTuusUsUbvx4EYI97hQLv4iNXhfxTVRI/eMMjKwI?=
 =?us-ascii?Q?hYtej41myCZXn2Z629AvNvhxAAxAYTkN9Z3r8ikL6W9XA/vDD0uU/a8NpfFQ?=
 =?us-ascii?Q?ky1u8thr+gbJZpBctvVyhaUG3jMZaYUh9FyQOEzjiD+dc9bOLDr+DP8RG86X?=
 =?us-ascii?Q?Vy8f8s9KA7kzJm3oAxvHgyRcMnhjzzjYtrB1uKo90z3X3Dc30WtnvczUQMQH?=
 =?us-ascii?Q?QXk85sqGXiZXtRn5d3It32KrE9DT4HHtnYKG0E1+HDVLewBL43g27FAnHHdz?=
 =?us-ascii?Q?xOy1V69kdASupC7NaboUpVeB6XaBX8bVDyVAgiIcHgVjqSI+3+z7FzpdREPW?=
 =?us-ascii?Q?Rzlk+Gacpkjy+gBqd9MqhXSRZ/D8IU608Y7cNkcx0iDVd/IcX2WjGJ/cjs08?=
 =?us-ascii?Q?qGtzKQF3NpCSzRHz/lCA/WAxS+WLXrIuk025K8aZnzQkzcwFXY/IyA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D9/22POSCYvjfnPTdy6+bJl6OAdjYVj3zdGGZpvFpkzH77zBvLhUT+wt3Dhd?=
 =?us-ascii?Q?muV6FQuusu48UroeqGHxrlz3qQrFfur8cjcmb502BN9YS3wLYiTKjT+WgJWd?=
 =?us-ascii?Q?/eFW/pnRv/0FUPoPx5Z7zhpMddoyasneFvVUATJ5hLjUmh9oVtHVYxSvaFpu?=
 =?us-ascii?Q?CUNfFthK2T68tdtWbVhD/PApZhGIH/4hKYeaXObwSSzJIOGGWZEtMIG/sjJ7?=
 =?us-ascii?Q?k6qKrO+TdLT1Nb5eNTjxAb4ZLXhMImcr5Y9A6AwsD22BjX9kJF2CgMcqzXT0?=
 =?us-ascii?Q?WYycHWMuFoEE1rihckxmCJJVQOswcWDZkrpJwgn5+kpDdIGf9mTcmH/pPRqk?=
 =?us-ascii?Q?03MWercJkA2l+PV+8hTlNsNKvSidLyJO2/LaVexfs47ZcfZwoKF5xuq1JQgF?=
 =?us-ascii?Q?+zNcrPqA1Dx2EHMiI+pS3rIcF4eD1zqlTSU3uKz8SwYImUwk2guwJrze7orH?=
 =?us-ascii?Q?mLSWKRWrhudjb/g6B0VkqA8/7fdDBHxHuyIOTBgAnia+tuMjeH8zUaRAaCUT?=
 =?us-ascii?Q?Qo3B0g1uinCN5oMteGbaQ6QBLa07VHIR2CmEAeUws3U1jWuJmiRtIugL9YSP?=
 =?us-ascii?Q?GY6f9LKGNI0mCCmziTayF6ZIwjLMDiizQXmKhNYDCLgUzGQiK9KUuZoNvl/X?=
 =?us-ascii?Q?9bsh3M2jI3E5SG8ueOpbqNr57lHVZ9qvRkkK2Y3YnV3MfydLbgUphVhkIdiC?=
 =?us-ascii?Q?gDuQfkeMrU8CeLLqa7HanGWqBayV/iIGWvFemwMhjLUtlGoByCD4aY8dZ3nX?=
 =?us-ascii?Q?MpyDkOiYLHX+3F76YSYLdqlJpcHtymWbhZkGVBDmjApmeXNLHsCRXnHp+uzU?=
 =?us-ascii?Q?kW9WiZiFnM0xZW06JR5+Hmn2WWxdM0JQ5Sl3fOcrv8+HOPXka2xDJobmI8XH?=
 =?us-ascii?Q?qRFL/bFZ5Ky3hC/fak+Nv/NRkGok7/N1bOkunkRssIjSzngrDmJ6JJSppKoX?=
 =?us-ascii?Q?KNiHm5HlbRARlXrGfxcI9nf0c/iiC8bau+0rZXsxjTWQgvDYsugBYTAfCXl6?=
 =?us-ascii?Q?myluvB96KzY1LDVe4CvOWnIjchxzpwDo0+7ejZVA3LEYePfYE8FuqKsFPwAV?=
 =?us-ascii?Q?dwmVzueDg8Qdn3Z+vKI7ru4xTICIx1ssqoqnwSfQsTtDU9Oo13nhteDiX+S3?=
 =?us-ascii?Q?/P7lKnp+BxqXlFdxXZaFpkbLBSEjtbpKy/Ohj3zi0dfUpCvAoGFJj8q6i5Su?=
 =?us-ascii?Q?SI3Rf/pIaCBDjaquO2TlNG6MREgrNIbrufu1I3m4IadvRHrfSm+c0xmVNnT2?=
 =?us-ascii?Q?fB6VziFwgf3yQJdpJ6AIWLsns9HyrzMRRQoAAUwH2l1A08CbCNqSU8aeovkX?=
 =?us-ascii?Q?/m2goGLGfrp0thDTq4Yf6WZeoxdP/XiX/16MMhTsaDscZDbjzCMzPToIySa/?=
 =?us-ascii?Q?cYu/jePjZBHRkpIXpKG+fpBIkWHhhIISOtLCjHdeDDo53yY0k8jw8iCsT5tR?=
 =?us-ascii?Q?Cv67EJ8H9lwRzTGi0OfG18/PqmJM+ZArNmNhDGqpHgg51Oghg2R/99hABaF8?=
 =?us-ascii?Q?qJytDBVw9lja/8CC2CuQHnKwCGP3r35+cTbRQwsSI241rfQuA6i1S72UwFzv?=
 =?us-ascii?Q?QC1hAmOvyVB48eZi2PP64cU8/gH1vCKH+URB85jE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dbc079-3210-4875-75c9-08dde315e466
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 13:55:32.4552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYzKbgoYDrHGCBCFX5/3aBcPKB2U5Dgn0t9kndobabstBAkdAZDGrfSHprLHQEs3kTF1BquUWwUZUTEZAGOkTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5685

Remove array_size() calls and replace vmalloc() with vmalloc_array() to
simplify the code and maintain consistency with existing kmalloc_array()
usage.

vmalloc_array() is also optimized better, resulting in less instructions
being used [1].

Link: https://lore.kernel.org/lkml/abc66ec5-85a4-47e1-9759-2f60ab111971@vivo.com/ #1
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Qianfeng Rong (3):
  ALSA: cs46xx: use vmalloc_array() to simplify code
  ALSA: emu10k1: use vmalloc_array() to simplify code
  ALSA: maestro3: use vmalloc_array() to simplify code

 sound/pci/cs46xx/dsp_spos.c      | 4 ++--
 sound/pci/emu10k1/emu10k1_main.c | 8 ++++----
 sound/pci/emu10k1/emufx.c        | 2 +-
 sound/pci/emu10k1/p16v.c         | 2 +-
 sound/pci/maestro3.c             | 5 ++---
 5 files changed, 10 insertions(+), 11 deletions(-)

-- 
2.34.1


