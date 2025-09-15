Return-Path: <linux-kernel+bounces-817101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EB7B57DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0EF2A1F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2071F541E;
	Mon, 15 Sep 2025 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="M+GXgnwX";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="PrCmqsSt"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F221C8631;
	Mon, 15 Sep 2025 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944177; cv=fail; b=dJ/MyvoydSwioEDYKlxUHURQB6ghxX1PyB28rxioeBR375BksL3sNvnSYftXVtw+FvcCeI6hbF/JLEMJnrYBuC/t2Y41TqfO//hxjdWu1UWmqg3BUdYfUQTAgJe0YCrGCC1TCC6wXHkcuzF+qn00CWu0QTiFp9Fy9fxNU0ScGCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944177; c=relaxed/simple;
	bh=Em1tvWBHSc7EtnQfmX1GXWxxQfuW5U946i3wsjK+cmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flpz6ptZ2LtuqCxrAbGOSVD1WjRRv+Krxj4zHx8HXAZCCPy3tJ2Ps6A2+FhwkoiF3pk0EQmiLCU2i/0AE3UTFJ2d66KjgcEd25zk0UM0b1HmhFrK0mrl828YsT5LOB8ovXt/EbFSrQuesUMocW3b0E0tIldL8W/wjXJv+LL97HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=M+GXgnwX; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=PrCmqsSt; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58F7Go2v2072713;
	Mon, 15 Sep 2025 08:49:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=fvd/vjG06Ix0+DkupIR9K1ir4dFr/UPc4Ys8AA7DMgs=; b=
	M+GXgnwXVCAbAi2aj/z+GNkaTx4yUgiTnCXmKHpj8s5XuNnWuE+lIr9Fj5uMn9k9
	KCeI4LYBLG6MLCW5t07C6O0LCv4KP664kUo3FX6RflGeffJ2MyrgFPlSg7vwaIb/
	Ty+mKJDF71erQoGUMBoDQ/Ka8XTB68Tnffm7RLhp1bo/kVjVtEnT7LLTgwBgmLzp
	XRwcPc8K9RvTjT3zR1Qgik55hAKR+sCXGzlBUZz+9ec2+f2E5HU02Z1/K1ri+Mv3
	M9t2MgATxkCP7bGZhQA3B0zO7AapgCKGwCQ3aLv+ngTcQ2WI2jcGE/dkoIH5QQDq
	GD61mLCMAAw/2Ju/dD+KRA==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2117.outbound.protection.outlook.com [40.107.212.117])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49551j35x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 08:49:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vt3IfV4NWhCqocruBBTI10xEPHjH4cap1GREfnuWJpxwUG6PuEHh+FXBGbM+qB6eb4ddZs3CuKZjKTq5x0nxs/gxa+eAjPXb3WEb08O01UaBAJEDx1wxHkSvX4lPqbjKfMNQIcoGMsTdtUMXdkszCd2C28sTqf58u34TGOMjfKU+6EePcCe35s3HgeRwzG+tMNaaIoRlYn89oARUsIYIPqnYiUAqChxQfVbr0aoaWF6O926PiV5o8O0xQ4eypNSkBjc8PdY+kBk0qX26j+uJCPqPeDYTZJ7uJ4DVmYMRqsur0c810K7an9/TjGWZfx3DZ2guFuyUTV+3GsyiW2x0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvd/vjG06Ix0+DkupIR9K1ir4dFr/UPc4Ys8AA7DMgs=;
 b=wKYHWcquXtQzmzNHeN2lgNHdJiLGGu2TdkwHL02mA21Df3bnJJSgwi6Uwl2qpq2kArtNh+zig50HVr/CEL5yJXEqn4CVDyMA7bMwk+2vpmwNZJTx4UAsAiOyS42/02CwXi+/8Qu8jvDkoqy1XzJP9Cuv0ehIf19QqiWeRFvCA8Ca9sDheQcEhkcM9UO7LESrOYZ+2QRtDurgb4r7ds4WjZSVwoTznCMCFbmySMvtsv51eOQSpymSmGco7wGDrJ4Q8XF/EqULw6TGxBppVMAoDU3iZYapQCgPJ56QPhP3bzJhhHdDFOm3aWX+cnyCBqF0d/t+bHhd8OriAgKSnyyeHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvd/vjG06Ix0+DkupIR9K1ir4dFr/UPc4Ys8AA7DMgs=;
 b=PrCmqsStuGW9tfMWJbTtlYBnZkvTFJRux5+oEBLc9ASWbByKbxZhjKrzFKbBuHs5JjI+QbhiqBMtk3ShvntPqPkx8w856KGmlggXtnCRUReocw9upV5zRZ0UpbHaLmMEV2wjBT8wRWyC1VeV4lGEckXfrsIU6UloSBbwef62DA8=
Received: from BL1P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::16)
 by BY3PR19MB5057.namprd19.prod.outlook.com (2603:10b6:a03:355::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 13:49:14 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:208:2c7:cafe::11) by BL1P222CA0011.outlook.office365.com
 (2603:10b6:208:2c7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.20 via Frontend Transport; Mon,
 15 Sep 2025 13:49:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.0
 via Frontend Transport; Mon, 15 Sep 2025 13:49:13 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id D755D406541;
	Mon, 15 Sep 2025 13:49:12 +0000 (UTC)
Received: from [198.90.188.46] (LONNCK4V044.ad.cirrus.com [198.90.188.46])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 9EDDD82024A;
	Mon, 15 Sep 2025 13:49:12 +0000 (UTC)
Message-ID: <5f0db8bb-9eff-4f11-8705-7250fe715b09@opensource.cirrus.com>
Date: Mon, 15 Sep 2025 14:49:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] ASoC: dt-bindings: cirrus,cs35l41: Document the
 cirrus,subsystem-id property
To: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20250912104612.361125-1-sbinding@opensource.cirrus.com>
 <20250912104612.361125-2-sbinding@opensource.cirrus.com>
 <20250912214140.GA1359075-robh@kernel.org>
Content-Language: en-US
From: Stefan Binding <sbinding@opensource.cirrus.com>
In-Reply-To: <20250912214140.GA1359075-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|BY3PR19MB5057:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a438803-d6e1-41f1-fc62-08ddf45ea800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tml0RUpEQW1BcG5YWG1neXBCY0ZQa0F4SFFaSitIWDBNNGRSTEpTaWl1QTFY?=
 =?utf-8?B?VGxFeXJlNHdxelVVSExOMkpsaGd4a0hRaEFsWmdLZkM4MnQwN01ScWVsblQ2?=
 =?utf-8?B?d1dGKytlUTAwRnlJdEV1K251R3U2NnNYSHBSQTNSQ0N1Mi90M2kwOG9PMWlQ?=
 =?utf-8?B?cEFTKzdvMUhBbkNpS1lYV0ZidlI4MElBYkRLVFNTT2kreGFIZHRyZSszd1FM?=
 =?utf-8?B?anZLSkJQd3hFb0R4Y3lLL3laOWdFa21HRTJTV0UrZUZmZkQ5cloyYXA1K0dD?=
 =?utf-8?B?M0w4Z0VCb1A2dklSOUNDbzN2aHRqVXROaG90WGZkTVBYWklmajBVM3orbTAy?=
 =?utf-8?B?L1A0TUR6WVpCWm1wR2dOR1VqN2RMc0NHSDR0eWJPemFnSzMwNmh5U1YvMXUx?=
 =?utf-8?B?ZzdaOE5Ob0pGNTRQWVU2eE9ncUVhZ1BkeTVYVy8ybUttTzd4UjJ6ayt3a0xG?=
 =?utf-8?B?aHA2c0UrdmFteGM0dUtwaDJBb2RXdnNmUWdxYTZGdkVYMEhXODJzSFRZZFcr?=
 =?utf-8?B?eEdUc1NHL2tXM1pCRzJ3a0JMSk45TEQxZGp5YjExeWdXQWpjNHdRMjN3bFFu?=
 =?utf-8?B?cTdVTTFFVU5aaVdBRlJtKzM1dytwVVo0WGExYmI4RjVKeTVyVUxKYUNYYk53?=
 =?utf-8?B?eHhlbS9td0tDQzRvMkJPQWozakR5cWJMUmgrQlhEU0xzdHBpVUJ3NnhtMGU5?=
 =?utf-8?B?RkxROHpCN1gvdFpVYWM0ZmQ5NEFHdDBmQ2RvU3NlMjlxeG9YcFljNkVVVnVT?=
 =?utf-8?B?YWlXbkgxS2tqN25nMGVrS0RLUG9CTlhhd29GWnVKNzVPZUxVcy9pd0ZmcGo3?=
 =?utf-8?B?b2JMNG8vc1NuWktvZXJKS0VzOG9lK2pqZGNjVlpPTVN4eG9wN1hCYStpMDNs?=
 =?utf-8?B?ejJDdm4vbVpDU09aWHRoaFNtS1YzZWlrd0xndGpuRUtIZWVGV3Z6RGNpUWtw?=
 =?utf-8?B?MEdHeXpWa2M1UEdaRjJ5RXhXNGxiQzIwZ0R6aVVnSW83TDhHVXZVMDJzU2xJ?=
 =?utf-8?B?L1p3ejlGeWxCbW5GREthRFgxRWN2TWdxaE1QcHhhR1JMZC8zcE5CK3RHMWNC?=
 =?utf-8?B?aFRkcnE0em9GL0Znb3RES3VSOHYzN3E5RmYrcVlMdWtybklkUmxzV0hLK0VE?=
 =?utf-8?B?UDQwWnB2VkZxdERlWGFsU2w4aHRWTzEvOXZiTWxqV0lMNmRyemRMK1RieEc1?=
 =?utf-8?B?K3lNMGllN3lpV3pUL0N5c0I5S3RzZ01iOEhtSldKWE1LazY3YytEc1RTNzY3?=
 =?utf-8?B?bTFIdHhJTjh0WnFFUzY1dEhoUXUwT2VKaE53NlE3dXoyczhvb0ZzT1c4R2RW?=
 =?utf-8?B?TG40OXllVkR2NjNoaFN3TTdVbzZTWmlBcmtYVUFBYlY3TFVVNmhFYXBZL1cx?=
 =?utf-8?B?bDhkVkZmb2pIb2hVZHQ0Y3UrZmZORW1Qd2lNSUlNOXFlVlhoZkVXZlRKNzJr?=
 =?utf-8?B?VDhZdWhscUczOUQ0WnJ4dmZPRmVwNzIxeE5zQm54WndwdXAvRVUwWnAvczJl?=
 =?utf-8?B?YkFUYWRFcGM2V0t5bjFJLzJXcVFnUi80bmJ5RUVVQ05uM01VQWg2aENDSmh4?=
 =?utf-8?B?QXZlTnNrSVpCcFZIM1hCL01HdVRUMHhkbC9jSWhnQS85QmxiNEhldDJDTmh3?=
 =?utf-8?B?U0dCTnVJYlZVWnhpNS9raXRnZWpyakh1dTNEaFBMdndGMTE4SGVHeWhNdUpX?=
 =?utf-8?B?RUxFRFpMMmVFb2xuaEc4cTg3c255Z1BKc3h6WnVaeEJWcE8yQkZQbnp5WFl5?=
 =?utf-8?B?bEpOQXRsVGowc21Wck9HcnJybSs5RHNnRXh6b015M1dIUEJMYlVpVGdqZTdG?=
 =?utf-8?B?QTA1TUorWVFUMEVIaEpodHk0YkNOVGFjdStDNklHNHJRbG5aUU1wOWFDaDJv?=
 =?utf-8?B?Q3RQWWxWZDc5dmdzUlVJTXpsOE40STVsSW9wUUxNMENtU2wycWpYWE1YeTJU?=
 =?utf-8?B?ZWlBWDg2UWtSWFNQbkxranV1STJsSmg3SnFXZ2w5UytNNkorVXFoOG1DcDNr?=
 =?utf-8?B?S3Z0WEpMRFJDK2JmbGZoUnMzV21sbXh2UW0rVU0remdCMkVtUzNYdXoxMXg3?=
 =?utf-8?Q?GPSJUB?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:49:13.7021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a438803-d6e1-41f1-fc62-08ddf45ea800
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB5057
X-Proofpoint-ORIG-GUID: Hm42aX_JRJiM4dKGV_o2SORN9zIyKR3_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDEzMSBTYWx0ZWRfX7czSOSmL+QoS
 gomkCfPzE+P9d+tNTSNhw1EWhzUQR66zo1uDOpF3KIIctnavD29qVzm/RpJzhYU9tVV/+fg+8Hk
 7737XMVo5iebNTzWDMGv68xcGYZ9j7iQYNMBU1zn7xT+buxrBYz8y1XVFgd7eXFT8A77KK2uVCH
 UkrJDIP9eCTxBnKmvJbEUUhuvDyhlGuaTnHa2C4Wa6PdiNy3ywoBSYdJew118P6bd38OL2FYVCB
 UHsOB53SBMAChv6Hp31OE6mQAsbUw2Oa8oCg1TFLMtNLmqvgl0BbBJoOBHA1eDteq7dARtHtzSL
 +e0JVpSJDzdUuw5Na29nLTvRanwVRExnthBdvPEJJzjDlNKZjd7i0hvwrR+8qs=
X-Proofpoint-GUID: Hm42aX_JRJiM4dKGV_o2SORN9zIyKR3_
X-Authority-Analysis: v=2.4 cv=YNyfyQGx c=1 sm=1 tr=0 ts=68c8195f cx=c_pps
 a=SOPUSA9Jr301X0CsWhpWpA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=w1d2syhTAAAA:8 a=iyI_tp7LkCIgslWRgcYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Reason: safe


On 12/09/2025 22:41, Rob Herring wrote:
> On Fri, Sep 12, 2025 at 11:45:37AM +0100, Stefan Binding wrote:
>> Add new property: cirrus,subsystem-id
>> This new property is used to uniquely identify the system if device
>> tree is used, to allow the driver to select the correct firmware and
>> tuning for the system.
>>
>> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
>> ---
>>  Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
>> index 14dea1feefc5..a9eb9bd7ad9c 100644
>> --- a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
>> +++ b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
>> @@ -151,6 +151,12 @@ properties:
>>      minimum: 0
>>      maximum: 5
>>  
>> +  cirrus,subsystem-id:
>> +    description:
>> +      Subsystem ID. If this property is present, it sets the system name,
>> +      used to identify the firmware and tuning to load.
>> +    type: string
> Why not use standard 'firmware-name' to just say exactly what firmware 
> to load?

The DSP driver searches for a compatible firmware (and tuning) based on what it is able to read from the hardware.
However, the SSID is based on the system, and cannot be read from the hardware, therefore it needs to be read from the Device Tree.
On ACPI-based systems, it is able to read this from the ACPI _SUB property, and to maintain compatibility with the driver between ACPI and Device Tree systems we need an equivalent property.
In addition, the driver actually loads 2 files, firmware and tuning, and the SSID is used to determine the file name of both files.

Thanks,

Stefan

>
> Rob

