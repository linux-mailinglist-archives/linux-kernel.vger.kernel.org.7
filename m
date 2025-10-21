Return-Path: <linux-kernel+bounces-862670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3566BF5E29
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B5119814F7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237B332C948;
	Tue, 21 Oct 2025 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ndd5o2py";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="wCcKujXL"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33782E8B8A;
	Tue, 21 Oct 2025 10:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043835; cv=fail; b=HX4TGvxx6SsHX352yelmlgAkqpfyelJcONJJuqVRLET+YNb1WOmMcjLO6t55EvFh91zTStrwaL8TRVD1xYz2XwGJBnEwqd8HQ/YGcdzmXtMG70VzbVyxFX2j4QJoKlUxj68F/dMQOB/0oAG5rwiUFTUxri2K9FRy/Zn9xaN5CgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043835; c=relaxed/simple;
	bh=8K43xn8jdweY6TXEWUlkz8HS77zoj/g5sp9WQyoCWPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d5BXIplYzXrlUqVkpJLM3lMz5My2PJL/9YIVuF3JWhl+h+vkbqVmbzDUUOBCybt7WiRdxbXMMAELPr2s5hZi39Z+zONhBJo8T3U6gtAbaWnPbYRvlr7BzrjrtYjH/Tp8ENagCvBLqfo4JGiEXV0nvoG71Wt+1c1g10NiXUVmzFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ndd5o2py; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=wCcKujXL; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59LASk2D2958765;
	Tue, 21 Oct 2025 05:50:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=8qkO8xrDNtbPkK9AVAg/dkUPEQzfq1UDS5jPOxB5yGQ=; b=
	ndd5o2pyxb4fxKnmdjyygVESZqSm2UonUxHx9zv0rfXaGzHefg+DV9o85ulqXmjp
	WTOaZGivkCYpz4bxBrhABBiD2D9mY8/u2ixS9QUYtmS3gBfZPkTAJX1DIsiFNyOD
	R0x/qCF90OsA7vepLUdi9gAKy5/xaqM7FR0g+jJ49Zl/t6lmhuMBoPrVrHer8BqQ
	xn+UAHi9aW3JctE14HUz+7znZSDKYYh0TcGZ+p7uxwq0QyalscfX3CJ5aACBUzSD
	Ht2y2Ss45FGrAOI1FVmYKkedkSEklz9u+qf1XFJlRcPVaSM91KCu6Hnt59/vdGuF
	szx57XpQ++R+v+yYjFjhGw==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020136.outbound.protection.outlook.com [52.101.201.136])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49v7aj3efx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 05:50:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wn7akZT7I9d0NkGrsTrlHR3J6SlWSmXqGSvVoOtjD0PHzgJPuloqbT9Dd2WHppbrbl/NA6M31woA5qHGF3NE+h9V849hw3HQ18odiJf0+SHtAm/0tHHrnwY5+dtWDCDoYQifcJupfdJvITNw+E20+qgEQ6QIfk3kFKhc873hK8S+XD0gK6zJPqwZbkJJ8AWk2KYE/sUmH8Aj6qZoocRkuqfam7iitIoGx6/Sln+VVqgEbCVY0pWYbkBz7uub2HorSBq1/YH1Zf3Z/Hw6+XL1nrUwPxT1bf6ssIuQ5PAqRcxu0W5AU8jVxIQOvdRgTXprD9TJyLYDZJIEx+5pCGgHEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qkO8xrDNtbPkK9AVAg/dkUPEQzfq1UDS5jPOxB5yGQ=;
 b=EEbk/FUrgSTcPIs1cPA6ZIinWnb98A3LExZv0zi6/UNWsOosaHeS5mm0Q1AoWmbUCN5IB+JD1MKb9qTAz8lvsiMzXD3dmWYfUch2vtgia2oOyAYHrTij4P4I9+3BV+XozE+1QyB0aslHYiM9CspcNMNIo2JSYY2dbkew3McQpoAPhOO9GMxF9XCICd+qj8JaEPG/jrFo0xjv8qYNkJ1xAxmVo9slkoSp9u3FqG7HvmMOu/tKCjz4e9uZWc8fKiWjXMH5sGKP+hh4qFvu2cL3EJd2HR+eEI6u2mtoC9rd1Vo+6PGDE+8MTAgjGYonkJOTCQs99RDnHXESbW78QES4BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qkO8xrDNtbPkK9AVAg/dkUPEQzfq1UDS5jPOxB5yGQ=;
 b=wCcKujXL/2zb1ntwPOl9PDDGjmNSFjFqh1eichw+XxhhklSWHdwHqFVDMKQSP6oP0+cbcx+gBiMSZx+EiJNnWOMTiN1KFFJCkTTdH/TQKE/U3YI2U7vCDbWPP6pvJzDqsomYQtljSbFpoR9uueNOJ63ibWQ5DdEI+QUQYQLljzk=
Received: from MN2PR01CA0046.prod.exchangelabs.com (2603:10b6:208:23f::15) by
 LV3PR19MB8513.namprd19.prod.outlook.com (2603:10b6:408:1b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 10:50:25 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:23f:cafe::a5) by MN2PR01CA0046.outlook.office365.com
 (2603:10b6:208:23f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Tue,
 21 Oct 2025 10:50:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Tue, 21 Oct 2025 10:50:23 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id ABF4D406552;
	Tue, 21 Oct 2025 10:50:22 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 6DB63822541;
	Tue, 21 Oct 2025 10:50:22 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH v2 02/11] ASoC: cs-amp-lib: Add helpers for factory calibration
Date: Tue, 21 Oct 2025 11:50:13 +0100
Message-ID: <20251021105022.1013685-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021105022.1013685-1-rf@opensource.cirrus.com>
References: <20251021105022.1013685-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|LV3PR19MB8513:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bea453f3-757f-4276-40f0-08de108fa364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PR8fnac7RRUooroF+2wmbbfVf2TROIXVq85t3p52ifN5rAzc75xTOsCbzgXZ?=
 =?us-ascii?Q?MB8b1jSjwvz9njDETRmqpAjOJiYq+xQxoQ0aIkaTa7/vJis2oYRVedDQlMEP?=
 =?us-ascii?Q?oC84/Xn+Bw/5id6f6VeqECUR/GK3I5UpfhE+64s7q0hccCRZh9QiQfX7S7WB?=
 =?us-ascii?Q?iKY4WAeo9C9PQKJ+mHJS71UO0VNAcipItZnEna+cwQutYDZaXMgL7qSm3Noo?=
 =?us-ascii?Q?CiefmeplRZ+jMFmv/yls9mRkukJ8jeInFmuheLspwpXLgDNSwEPEUpy6+0vE?=
 =?us-ascii?Q?k6FZvhk5aifqISXGS1vM/CqreTeE1/IwK0qfsB5TFCBacFdoTTzZWbErypc1?=
 =?us-ascii?Q?NUDgoO61W3W3xNr+9jUpv5noD90SWfnSDJtVe5kUWzOMStKEv3XSsakhNCsk?=
 =?us-ascii?Q?Zge2mXFiRqAVB9zgXYFBBXQgarju2NbVDrJ9b02QCA2h1ApC/yxZLjHXJlwN?=
 =?us-ascii?Q?706c9IINY/gTLk+lGQPw2NoTSxqxXSdBZFjINRr/c7tt1f0mQPEI8Nrr5mE0?=
 =?us-ascii?Q?ZS+xgkANrHssDFXM5tarV77mHb3ItSmXu0LsJTyrBWwJAeQN7HdO5b6egLd+?=
 =?us-ascii?Q?VWNIdV0zJkdERiUuEb8ZkRvB7f2pIr0LqSSEZyAJNTBbgdj2OC8TT9PlKycQ?=
 =?us-ascii?Q?LkGPpH/vccLf42RvST6K2EsD2T/NpHv21QRTIyc1T+JS74lsMdcL6YzF3fYS?=
 =?us-ascii?Q?GNmgyHF22etgp8r70EUMxVl2Qqy/6kzOAqjFeiG5ZVZ4pl8TNE3kNile/9Ye?=
 =?us-ascii?Q?pFVM2hd+gAEfMl2NE8xRrDpWnm9R4d/htOxV4x2ytxKrJPGquBxTsRl6vLlb?=
 =?us-ascii?Q?R3iE+NQH4lWfhjXBb9Rz0GwZ+ltLitWaZPt52egnYVcpCRAYo5qpck2IE6bu?=
 =?us-ascii?Q?ttHTUyQBJcUI6rZnvVX8nRLkrTojwWYhCWDnGd5gHwNdQI5fmN1fxvOA+nus?=
 =?us-ascii?Q?2rCdyW2ZavxO0WYuZzUqBIbkhLufcCArrhhF0TrpCyfD6hhnvIT95aM23u41?=
 =?us-ascii?Q?o0nDxxklRxSDmB9Rbfyj70crj46dqyPZnaYE0hF0uinnwrXjUZb7O31PwDLe?=
 =?us-ascii?Q?bGLxzue9NSdtK0PaQ1hUqKVDjufWEYDN6sYddSPofykQW3a7xPvf9LugA3u8?=
 =?us-ascii?Q?QZIZOVziMq6cHubXU7Ft1Xkmvx6UPXoulKnTkmIo1dugrStXiwK1aCX71RE9?=
 =?us-ascii?Q?PCijD9wQIlVE94KiXzrqmt1rIek+qxcTcrenl9ZOKgv8j963Ew9Hmr/ACdKE?=
 =?us-ascii?Q?VQMvY3jWZGXQd2yTe6KTkBD7UWFJZ5iOQa9Qj0rXsZHtZVnaqer6DtLsqhjo?=
 =?us-ascii?Q?4b1lcaNn+4u3XxG0IhDQOeM1UsEWaFXpojus3vmmQmHblFQfcLExDvfi/9Lh?=
 =?us-ascii?Q?zUrIioWnxLWuXxiNbkAG1ua37yhSG5sBNl8W8qSPbF33jGMcnXQAWbzzhRLG?=
 =?us-ascii?Q?DB9wUWzIomUSxUANsfhj14LXuvS4G6vh+UBydMymPS6PyFAxjTFlVAFhBZ2t?=
 =?us-ascii?Q?G4XZBM27lxkaA+PWM0LK7bcJe80Ss6yToZ3C7DYg1uRNwaNRt5KdIgiX9+y+?=
 =?us-ascii?Q?nbr4Y7Let2ACOCZndqE=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 10:50:23.8750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bea453f3-757f-4276-40f0-08de108fa364
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8513
X-Proofpoint-ORIG-GUID: ZYO53NlZ7CsEzNQSqLKRr6C9LseiHZ3t
X-Proofpoint-GUID: ZYO53NlZ7CsEzNQSqLKRr6C9LseiHZ3t
X-Authority-Analysis: v=2.4 cv=bdNmkePB c=1 sm=1 tr=0 ts=68f76575 cx=c_pps
 a=SjKxu3n00dGHhKqS4WZ18w==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=9fJfBgaK4NS20Kq2ylQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDA4NSBTYWx0ZWRfXzAS91ASObWhU
 TKAdzOC+vtBToluo5eD5R7TkClSo3XDdyymr8foESja3T00TMfDh6oCAaeEMlrbhO1p9N9kzQfd
 Phj57iSaORFs7bkMnw0pwfv1iOdGkbFSyavXaVtZaAjXYDThE/SXMngBV87iXeuhEQ42PJChQx3
 5+mmB/9tozvvPvU6odf6SnQ8jTfDrDjEJDP68wW62SrVyUNZORTsp5lVTdnunB8XDENhJKeaPMe
 6Mh/Zcq5CC964cEaVKW4fqKOF9x41nTknvByuWAQU+qbymcSz5ibRqUKDXHVgxviLvdnJpIix9O
 YgfKwTeLWtIAASLO+7e4LUMvcLtQClUP6IDAlzI/X9SZEymHZDva4+dg81fgtCnozMFBWn+E0xx
 gySTby69TK8mlLD54UdERxGYPge+HA==
X-Proofpoint-Spam-Reason: safe

Add helper functions for performing factory calibration.

cs_amp_read_cal_coeffs() reads the results of a calibration into a
struct cirrus_amp_cal_data. The calTime member is also filled in with
the current time (which is defined to be in Windows format).

cs_amp_write_ambient_temp() writes a given temperature value to the
firmware control for ambient temperature.

The cs_amp_cal_target_u64() has been moved into the header file so
that it can be used by the calling code and by KUnit tests.

cs_amp_create_debugfs() creates a debugfs directory to contain
debugfs files related to calibration. This is placed in a directory
in debugfs root, named "cirrus_logic". The purpose of this is to
make it easier for tooling to find the files it needs by keeping
control of the layout under this directory. By contrast the ASoC
debugfs can vary between kernel releases and doesn't have a strictly
stable naming convention. HDA does not have a debugfs directory at all
and enabling the general ALSA debugfs (which is normally disabled) has
other side-effects.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
Changes in V2:
- Added cs_amp_create_debugfs()

 include/sound/cs-amp-lib.h    |  12 +++
 sound/soc/codecs/cs-amp-lib.c | 148 ++++++++++++++++++++++++++++++++--
 2 files changed, 155 insertions(+), 5 deletions(-)

diff --git a/include/sound/cs-amp-lib.h b/include/sound/cs-amp-lib.h
index 43a87a39110c..5b094f8e8a6f 100644
--- a/include/sound/cs-amp-lib.h
+++ b/include/sound/cs-amp-lib.h
@@ -47,9 +47,21 @@ struct cirrus_amp_cal_controls {
 int cs_amp_write_cal_coeffs(struct cs_dsp *dsp,
 			    const struct cirrus_amp_cal_controls *controls,
 			    const struct cirrus_amp_cal_data *data);
+int cs_amp_read_cal_coeffs(struct cs_dsp *dsp,
+			   const struct cirrus_amp_cal_controls *controls,
+			   struct cirrus_amp_cal_data *data);
+int cs_amp_write_ambient_temp(struct cs_dsp *dsp,
+			      const struct cirrus_amp_cal_controls *controls,
+			      u32 temp);
 int cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid, int amp_index,
 				    struct cirrus_amp_cal_data *out_data);
 int cs_amp_get_vendor_spkid(struct device *dev);
+struct dentry *cs_amp_create_debugfs(struct device *dev);
+
+static inline u64 cs_amp_cal_target_u64(const struct cirrus_amp_cal_data *data)
+{
+	return ((u64)data->calTarget[1] << 32) | data->calTarget[0];
+}
 
 struct cs_amp_test_hooks {
 	efi_status_t (*get_efi_variable)(efi_char16_t *name,
diff --git a/sound/soc/codecs/cs-amp-lib.c b/sound/soc/codecs/cs-amp-lib.c
index 8434d5196107..f9d5c4adf3f2 100644
--- a/sound/soc/codecs/cs-amp-lib.c
+++ b/sound/soc/codecs/cs-amp-lib.c
@@ -7,12 +7,15 @@
 
 #include <asm/byteorder.h>
 #include <kunit/static_stub.h>
+#include <linux/debugfs.h>
 #include <linux/dev_printk.h>
 #include <linux/efi.h>
 #include <linux/firmware/cirrus/cs_dsp.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/overflow.h>
 #include <linux/slab.h>
+#include <linux/timekeeping.h>
 #include <linux/types.h>
 #include <sound/cs-amp-lib.h>
 
@@ -46,6 +49,16 @@ static const struct cs_amp_lib_cal_efivar {
 	},
 };
 
+/* Offset from Unix time to Windows time (100ns since 1 Jan 1601) */
+#define UNIX_TIME_TO_WINDOWS_TIME_OFFSET	116444736000000000ULL
+
+static u64 cs_amp_time_now_in_windows_time(void)
+{
+	u64 time_in_100ns = div_u64(ktime_get_real_ns(), 100);
+
+	return time_in_100ns + UNIX_TIME_TO_WINDOWS_TIME_OFFSET;
+}
+
 static int cs_amp_write_cal_coeff(struct cs_dsp *dsp,
 				  const struct cirrus_amp_cal_controls *controls,
 				  const char *ctl_name, u32 val)
@@ -73,6 +86,34 @@ static int cs_amp_write_cal_coeff(struct cs_dsp *dsp,
 	return -ENODEV;
 }
 
+static int cs_amp_read_cal_coeff(struct cs_dsp *dsp,
+				 const struct cirrus_amp_cal_controls *controls,
+				 const char *ctl_name, u32 *val)
+{
+	struct cs_dsp_coeff_ctl *cs_ctl;
+	__be32 beval;
+	int ret;
+
+	KUNIT_STATIC_STUB_REDIRECT(cs_amp_read_cal_coeff, dsp, controls, ctl_name, val);
+
+	if (!IS_REACHABLE(CONFIG_FW_CS_DSP))
+		return -ENODEV;
+
+	scoped_guard(mutex, &dsp->pwr_lock) {
+		cs_ctl = cs_dsp_get_ctl(dsp, ctl_name, controls->mem_region, controls->alg_id);
+		ret = cs_dsp_coeff_read_ctrl(cs_ctl, 0, &beval, sizeof(beval));
+	}
+
+	if (ret < 0) {
+		dev_err(dsp->dev, "Failed to write to '%s': %d\n", ctl_name, ret);
+		return ret;
+	}
+
+	*val = be32_to_cpu(beval);
+
+	return 0;
+}
+
 static int _cs_amp_write_cal_coeffs(struct cs_dsp *dsp,
 				    const struct cirrus_amp_cal_controls *controls,
 				    const struct cirrus_amp_cal_data *data)
@@ -106,6 +147,45 @@ static int _cs_amp_write_cal_coeffs(struct cs_dsp *dsp,
 	return 0;
 }
 
+static int _cs_amp_read_cal_coeffs(struct cs_dsp *dsp,
+				    const struct cirrus_amp_cal_controls *controls,
+				    struct cirrus_amp_cal_data *data)
+{
+	u64 time;
+	u32 val;
+	int ret;
+
+	if (list_empty(&dsp->ctl_list)) {
+		dev_info(dsp->dev, "Calibration disabled due to missing firmware controls\n");
+		return -ENOENT;
+	}
+
+	ret = cs_amp_read_cal_coeff(dsp, controls, controls->ambient, &val);
+	if (ret)
+		return ret;
+
+	data->calAmbient = (s8)val;
+
+	ret = cs_amp_read_cal_coeff(dsp, controls, controls->calr, &val);
+	if (ret)
+		return ret;
+
+	data->calR = (u16)val;
+
+	ret = cs_amp_read_cal_coeff(dsp, controls, controls->status, &val);
+	if (ret)
+		return ret;
+
+	data->calStatus = (u8)val;
+
+	/* Fill in timestamp */
+	time = cs_amp_time_now_in_windows_time();
+	data->calTime[0] = (u32)time;
+	data->calTime[1] = (u32)(time >> 32);
+
+	return 0;
+}
+
 /**
  * cs_amp_write_cal_coeffs - Write calibration data to firmware controls.
  * @dsp:	Pointer to struct cs_dsp.
@@ -125,6 +205,44 @@ int cs_amp_write_cal_coeffs(struct cs_dsp *dsp,
 }
 EXPORT_SYMBOL_NS_GPL(cs_amp_write_cal_coeffs, "SND_SOC_CS_AMP_LIB");
 
+/**
+ * cs_amp_read_cal_coeffs - Read calibration data from firmware controls.
+ * @dsp:	Pointer to struct cs_dsp.
+ * @controls:	Pointer to definition of firmware controls to be read.
+ * @data:	Pointer to calibration data where results will be written.
+ *
+ * Returns: 0 on success, else negative error value.
+ */
+int cs_amp_read_cal_coeffs(struct cs_dsp *dsp,
+			   const struct cirrus_amp_cal_controls *controls,
+			   struct cirrus_amp_cal_data *data)
+{
+	if (IS_REACHABLE(CONFIG_FW_CS_DSP) || IS_ENABLED(CONFIG_SND_SOC_CS_AMP_LIB_TEST))
+		return _cs_amp_read_cal_coeffs(dsp, controls, data);
+	else
+		return -ENODEV;
+}
+EXPORT_SYMBOL_NS_GPL(cs_amp_read_cal_coeffs, "SND_SOC_CS_AMP_LIB");
+
+/**
+ * cs_amp_write_ambient_temp - write value to calibration ambient temperature
+ * @dsp:	Pointer to struct cs_dsp.
+ * @controls:	Pointer to definition of firmware controls to be read.
+ * @temp:	Temperature in degrees celcius.
+ *
+ * Returns: 0 on success, else negative error value.
+ */
+int cs_amp_write_ambient_temp(struct cs_dsp *dsp,
+			      const struct cirrus_amp_cal_controls *controls,
+			      u32 temp)
+{
+	if (IS_REACHABLE(CONFIG_FW_CS_DSP) || IS_ENABLED(CONFIG_SND_SOC_CS_AMP_LIB_TEST))
+		return cs_amp_write_cal_coeff(dsp, controls, controls->ambient, temp);
+	else
+		return -ENODEV;
+}
+EXPORT_SYMBOL_NS_GPL(cs_amp_write_ambient_temp, "SND_SOC_CS_AMP_LIB");
+
 static efi_status_t cs_amp_get_efi_variable(efi_char16_t *name,
 					    efi_guid_t *guid,
 					    unsigned long *size,
@@ -215,11 +333,6 @@ static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
 	return ERR_PTR(ret);
 }
 
-static u64 cs_amp_cal_target_u64(const struct cirrus_amp_cal_data *data)
-{
-	return ((u64)data->calTarget[1] << 32) | data->calTarget[0];
-}
-
 static int _cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid, int amp_index,
 					    struct cirrus_amp_cal_data *out_data)
 {
@@ -400,6 +513,31 @@ int cs_amp_get_vendor_spkid(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(cs_amp_get_vendor_spkid, "SND_SOC_CS_AMP_LIB");
 
+/**
+ * cs_amp_create_debugfs - create a debugfs directory for a device
+ *
+ * @dev: pointer to struct device
+ *
+ * Creates a node under "cirrus_logic" in the root of the debugfs filesystem.
+ * This is for Cirrus-specific debugfs functionality to be grouped in a
+ * defined way, independently of the debugfs provided by ALSA/ASoC.
+ * The general ALSA/ASoC debugfs may not be enabled, and does not necessarily
+ * have a stable layout or naming convention.
+ *
+ * Return: Pointer to the dentry for the created directory, or -ENODEV.
+ */
+struct dentry *cs_amp_create_debugfs(struct device *dev)
+{
+	struct dentry *dir;
+
+	dir = debugfs_lookup("cirrus_logic", NULL);
+	if (!dir)
+		dir = debugfs_create_dir("cirrus_logic", NULL);
+
+	return debugfs_create_dir(dev_name(dev), dir);
+}
+EXPORT_SYMBOL_NS_GPL(cs_amp_create_debugfs, "SND_SOC_CS_AMP_LIB");
+
 static const struct cs_amp_test_hooks cs_amp_test_hook_ptrs = {
 	.get_efi_variable = cs_amp_get_efi_variable,
 	.write_cal_coeff = cs_amp_write_cal_coeff,
-- 
2.47.3


