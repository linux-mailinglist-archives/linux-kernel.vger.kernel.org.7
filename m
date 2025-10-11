Return-Path: <linux-kernel+bounces-848944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6302DBCEDE0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC0B1A64F5D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 01:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD3E7B3E1;
	Sat, 11 Oct 2025 01:29:03 +0000 (UTC)
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020134.outbound.protection.outlook.com [52.101.195.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C3D29A2
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760146143; cv=fail; b=QLqQBSg7mZeN5+ZtizBxYIFVjReXhhZPcb0qj6+RMjw1LZvBHBzDfNUhxsRla+76YysPER8J4Qdn7+5+c1z3ESrfqBaFfpgMR9vTpNIyv9/2Q6j4mKtJP5O6CMV0NchxbcQblDinIE0Krkk0E58hLFHMaG7HepMpyQzG9tsLLjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760146143; c=relaxed/simple;
	bh=3WNdG7yczxG0WY+7r+d/2eBVzEMkhdmAtoHjOK8xRtY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rfSKRFdrtLFwjGpx/rO2tZBGACkubxVLvHa9Q+A1D5nZ7vnLzWxNjtgSxmYpJxQEq/rqMS0p43+GispopQ9pqlaqtyV0VUTSKJQOPqWjkxGgCWNXbml6qimlBoKGh5mJYou/M+/jK8fYiiM684iGpUjsHy6iWET1XV/J4TRYzK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDrZeZuOrBZPjedByXLNDq4qFyczkvsePl6V1DpAJ0qah8AzZcsnr2cFO/hOFlOg7k8Ws2WXwzCGGX8UaKSaphsWTUXwu5zbX6mewQLtqJ/TSFMKRIl++ALep8uquAg4kJNiG86tLPDw3yYxRlVYJxUyMKryFgG9gHng4BuDLPe91nbi/pdueI41aSANNor97srHTkPGYuHXxI4mp8MLti0/rcWPYnIgmWq/7uzEqa4lvnCorMpionbo47scExUm2Z0d6sT27Y/D8Y7avQsaE+OWWgw8204vp0bSBv4UxTDQC5Jx8NB9/9SR/5bP9AVj2XKROt76LI5GpSzx9id09Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NVfnRzmsCaDcHGneNpjGVAxOx7/nuWMZcT2yCSJX2s=;
 b=B7WxWwyrwx/Nn4ie/QOcj8LQ8bbV2fBWptUds2UA2hbJydZep+hxkvv/UBdHYENt4NXxL4y7dep131Vk6Sjbigmtacp5Na8nzKkOCWhdaMRkDNso6fgGb5MHdWHvSXUDPB59tNi5EBn4Jl3RjBKhgz0vfSjyVaD4407ZT8/5ccWsZAK0r89zRUl9Vo0ZyvZHx+1aASct0y7702zen5o/GUBYc+m7UomUP4/1oZfH+WDVNhiIRXNKR6mRz/mKlefN9KsCBC57ZU0ciDebTHsHc2gWR6Z1l0L0M+/x+kIPdxFPSx3EZXuyIZzsXfY1LYH61xBm5ap87xkYumvf2Gqe3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB6259.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 01:28:57 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 01:28:57 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: gregkh@linuxfoundation.org,
	nathan@kernel.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: riel@surriel.com,
	frederic@kernel.org,
	atomlin@atomlin.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] tick/nohz: Expose housekeeping CPUs in sysfs
Date: Fri, 10 Oct 2025 21:28:52 -0400
Message-ID: <20251011012853.7539-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0060.namprd02.prod.outlook.com
 (2603:10b6:207:3d::37) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 5705f0d1-98a2-47ed-e595-08de08658c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G2rpcMHkkS7x4iqXXaDwclgVR6F9qIEze9vy25yCZJIWuziqxpOlvmTvp/FP?=
 =?us-ascii?Q?BwhSh+24c0PxapXMCJJtAfjpoHbjCXVoLUGMbbrlbsj5JwqYF9FbWhjseGhQ?=
 =?us-ascii?Q?T2XhEdIBnI0f0UBVY8h2GgBk7YuBi44T227xSJqQxvlMCH4hyae6MWIPk7ZT?=
 =?us-ascii?Q?ua8r+8drGM0Hrd6YGWO8vaiWDdJAbhi18fuWCVW6kbmY4+/VlMCsMMLOsZ2P?=
 =?us-ascii?Q?e8RHlSAGch/m4EeRxFoN9yMEf7Je0nsKazl1S+4ytkvvvYYsYRau3e73Wwuw?=
 =?us-ascii?Q?1IMvoi3H28Ifz2gzzLNRAOYKIaX0w9EVzR2eiXwF29UqUicFvtnoqBmNRX3H?=
 =?us-ascii?Q?6m//QU/0S5Yfjn1/KxBz9K0W452V/L7malhOSJiHUNv5z8/K1pgdqdb7xp9u?=
 =?us-ascii?Q?DaFa10b5ydENfBMrYWJPJwGaYAKxW30AKUze1LVT/m0eYZcZ5mm1odnsEAaM?=
 =?us-ascii?Q?n+dskfvmWmJZ3g1SUX4Tstm3cmXxMQiYXB6OQu72gTOsVvShx0Z/xH6mDwvc?=
 =?us-ascii?Q?XY3cwrn54vOkZktIwtMUXR2snrFqWLNSkjiTihhMamauXdtt/7xBeeIzTz32?=
 =?us-ascii?Q?J+xXbkBuaBd59h3RdULAAa4jGcqVq+SYco4oIMxCRmBzPhJ/A5BGu74/xSxw?=
 =?us-ascii?Q?OTBeHjz4GKDKqZZT7i/DIBIQwXYDB3Dxh28sTR8ARbANz/KwwaN6Xl4yrtOT?=
 =?us-ascii?Q?IVhn5ZiF+3DHSumhBtnMcnphBPSBD31nnFaBSAEcPdhZURl5ASb8iglx/K7s?=
 =?us-ascii?Q?jgE8EU+wgvBa9haBnfYmpr1aAOsQjfX57M2RWXdIlxhYm4Ygz8eW9j0SyPXV?=
 =?us-ascii?Q?ZnyFTMDEL3SKc//bGLyHklL/zboyce/SzOkgrjOPyA9IbMb5qVSVANchHfNd?=
 =?us-ascii?Q?sYdlkrR/mE1eqtauQ8f2Jhkq08h8BW5p3hi2HayAGB0LNcyFYA10WUeMMXlW?=
 =?us-ascii?Q?CGT+KjfYPMI9K5nmGnlGVLemATqujV1undQHCZ8OyGkkf1NbBmSaZ1W8tNAe?=
 =?us-ascii?Q?3ob4HRfqiQ8fxHIf95e/j5NrrKrYxGg36sgPR3oGpoHVKni/qaNJajDZIvVX?=
 =?us-ascii?Q?sSovzw6Hu76f/EpVFCfJQvImsM0NMMx2SC+lIMa0aV69N4Edb3czE2/JvUiI?=
 =?us-ascii?Q?32k4s5nNjIBgc4sISf5KYWQukwzYQlpZhyjbk1qS7G5MMSxNi8o2E4frZgXU?=
 =?us-ascii?Q?7AhycUz6Rhw31BtwLkPrYZncWcTEGGz2pcm19/w3nk5hQbYul0N7cW4Dhp32?=
 =?us-ascii?Q?v0VGRTbr1IJCma00kCNyHrNdB9eS62r7pUHqNRWpOHGnd8IsaGob74fFUeIt?=
 =?us-ascii?Q?/Y2WiaMaxhrPTQIl3ZyNiHRHrk4bKG1rWtIWCUeMWRZBJZA0A4/E9+A7C4af?=
 =?us-ascii?Q?szqE9EtGwt7aEur53AvavNyKaM1g6DwZChx+wnxvEsDxOz1UBvT0CNCoY6yY?=
 =?us-ascii?Q?S2hbl3355BJASeS1V3Kn3Z0ps0jvcBgN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tZEd2895ik16jpBgILW/nQuXxgj0QsO8uf/mSUlJkrKgAcAsh4hMbTAcVwof?=
 =?us-ascii?Q?VOWnFMMEevij2RMZAxnhPChvIh43d0qga09ZTWF8sHeRC/cUm271fkQBm3cb?=
 =?us-ascii?Q?VMBnxCsl3JEess47/4FyVhHD3RdWhYi/MAR1wKN54LVN7+xHvmRPz9tNBTsy?=
 =?us-ascii?Q?e6bxVkMzqb5szeOOvsO1uROPvUZ2MC+KNAE6r8+SDgtVzVJz9YbVPHKZFcC4?=
 =?us-ascii?Q?z2L7eglVQTTZR7kZY01odmEwfSNJPxIc9Go/6pUkqn4p5m43xH5yA0EOXF8d?=
 =?us-ascii?Q?CTotaVZSoMMwOjtDRkfdXKAChp55g0FphcTB4Dxkp/zgvA/6j3BwP+cbi3ug?=
 =?us-ascii?Q?x+YK6M8qxPkAX3Go71w4AEH7UnkkMoZ7YfYayAD1IhyHds5u0ODfQ9bmRl48?=
 =?us-ascii?Q?BG2glZ+YFmOcGIHIUdpS2CMVWSLBmHm+OejbPlzQ9tX+zBMy+9op9LH6IssW?=
 =?us-ascii?Q?EKsTsrULfEOcgmnJU0JNBT1P4ZJmZ5fV+SEX5jB1kE9Bv+5iBOVVG5JKBSwk?=
 =?us-ascii?Q?Yh7MwHEfOAkMNL6dDeKhOQ4XgQn4G8qzPc2kEYov1WGo4fGTTGMoZNdmuJmH?=
 =?us-ascii?Q?m7kjcAkl349/G4w2xwjhCsfDpR6lurJHMgLKveV3wyPUaBiW6BSE07tGI7zL?=
 =?us-ascii?Q?NNfWio1CLsYxapcpNuaMn+X9uarn658L293Mry2GZVqyfq4iEd0ltGLxlQ20?=
 =?us-ascii?Q?2VyVMHY/+KvcBR522lYtHccBQwzYh7+AAIevfLUj0umwVXZ2jfZiN0JxT0Q6?=
 =?us-ascii?Q?wCV0Uy/SVmT12GfBNpe5c4rFbu6qiTQDA36SFQp2lYsAs7ztxyt8lJPB3zXw?=
 =?us-ascii?Q?00z6VTqkhnoUj/YdmnEjHXmfN7R2dMoGtDBNGH3dBE3HDbhM5yu9XFD9SppX?=
 =?us-ascii?Q?w0j6Zo73rsHYt7MsZdLpQMwNp/xKpkAfY27OV6d6NPerwvwRuYZMiQj3J5cV?=
 =?us-ascii?Q?pHWiEueoeFRB8go7KdgvLdkWOwWNYFvNiRUmMf9f8cU3wtzgAmyGsMD0JNUn?=
 =?us-ascii?Q?0rfAS9HA8MhOyAJ7HTI21WDSW4DjE4MGSReJbrTp7wJHqkJ/wSh7KZcoc/+i?=
 =?us-ascii?Q?HK2jNPCrIRBZggVM04WZQqKW/kHivtvom+B27u7DBlmgvx/b0Pjs10uvWRFG?=
 =?us-ascii?Q?+2uDwdaTO5mxIKp+ppg9XJKeMvl0i8UovhGikxg4vIlvT19yboF04KaynfTQ?=
 =?us-ascii?Q?jPRa4rYoGtQIQ9eHBSQ/rkBpnkCxzF/QZe0Iuf/YSqrj4KDHB95PK1Jd+v2+?=
 =?us-ascii?Q?lJRrrDNArXXjDXP8wXSeQu1rbljjV+kyaEe043wKOjj2TWHj71N5WZ05w2wY?=
 =?us-ascii?Q?u7eHviM/1Z8Npr6dWcMaN/fd73OAdI9PE/uFukJagiE/1lmYbX9a+6gNR4pd?=
 =?us-ascii?Q?h+TSOqIVashdd3SfidTZJFT4IhKw8upunIewF8lpmldRpmNMiqPBaMQXk/Yj?=
 =?us-ascii?Q?mgzd+olRicAPuD83g65xukNL1+e3MkRZWDfbBwrudR8AtN+lI2jTuiXlGgU+?=
 =?us-ascii?Q?p96XJR2BPvGyqf++PRzD2fhTHIQNBfjHMgQcI9u78r8qHPvOdHzvcqjdWGAo?=
 =?us-ascii?Q?Jco/WNcXT/oWP0mYIzOry9dXU/VcTxJVZbX0zmyp?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5705f0d1-98a2-47ed-e595-08de08658c16
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 01:28:57.1519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uC5/DRvjkB0jMEF/juedtwnp+EffBhALbq9iaxx+SYg6Dfrx/nmUkyBOb1BxbX2cigNTMozsrZ11Vhp0Xawczw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6259

Hi Greg,

Thank you for your feedback so far.
Please see the latest changes to date.


Changes since v2 [1]:

 - Removed redundant else statement

Changes since v1 [2]:

 - Refactor to use an if statement (Greg KH)
 - Use DEVICE_ATTR_RO() instead (Greg KH)
 - Document the new file under Documentation/ABI (Greg KH)

[1]: https://lore.kernel.org/lkml/20251007012958.16666-2-atomlin@atomlin.com/
[2]: https://lore.kernel.org/lkml/20251006005853.76335-1-atomlin@atomlin.com/

Aaron Tomlin (1):
  tick/nohz: Expose housekeeping CPUs in sysfs

 Documentation/ABI/testing/sysfs-devices-system-cpu | 11 +++++++++++
 drivers/base/cpu.c                                 | 14 ++++++++++++++
 2 files changed, 25 insertions(+)

-- 
2.49.0


