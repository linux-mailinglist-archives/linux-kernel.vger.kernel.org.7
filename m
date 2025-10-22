Return-Path: <linux-kernel+bounces-865192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F595BFC7F3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E586E0DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464C534BA5F;
	Wed, 22 Oct 2025 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="bRqu8IBa";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="pK2lySvn"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E89E34B69D;
	Wed, 22 Oct 2025 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142590; cv=fail; b=iLBVOaWulgnLg8DR6Q8AKgpIN4hxnFrHpaJHMVJcPQa48iPj3ajyuekdmKSW9KrrFSA7UrTOWt4rrFCRY5ibNROW2ON9f+lJzBUz/CTLAqsoxZzvR3ULx38Sl+x2wk+UcbIPYVR5/55JY14PDn6Xvn7Qa+mO/WKEToRcWn1/7AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142590; c=relaxed/simple;
	bh=8qJ9wRGtmycNHRcZRo798LTkAk/fJU66YOh8zsFW8OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkIwxDqXx2v86qs8mdo6i3wMj+9HZArwDadCuvZFJmXVu4OHCim4nURcpKKRsUFY1y6CYJbYjTVdPCi4zl4m0BcD1MwEIsTX/8ugz1nZn7FZ2s/5fNu9nvuonq2GjesoRKNZLZNsmNRRyZRoxBJQA8G0zuvobqiIC5bmZiJ9PIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=bRqu8IBa; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=pK2lySvn; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59M3j1ei3660629;
	Wed, 22 Oct 2025 09:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Ms/+XzCSNGIQoKYr7u2NbDP0AOEGEmXTl68C5y4n9+M=; b=
	bRqu8IBaqlcvsQTkVVv9AfJQJw8Kw8kfy+E/8PnqQIqhn1ZQmZ2DiG/2wwUJHnwS
	rc2374ggjCmLfEwtjvKdrhXzYx/5/UpgsC06B4XbX5hSGR36zhGpLd7M5MbGWSao
	rqbkSBqq0Nw48MtWfXatv60EhbApSJAhj1dE88ZQWDze7SKamLpesE5RA6WzlEyV
	27HpXhBoUeIJMlZKG9qRB5e1JKUoNApeqjlgCQrj6W8jjNWBoiTdJZbEHNWn/xpz
	5yGVhIspxErGAfLtYHvamfMGnFvjx6CRZ/BUxhLiF9WfpKRVi987hjE/H1G74x8V
	9N0S5qxnNHYcNJ3fTiRYOw==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020139.outbound.protection.outlook.com [52.101.56.139])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49xqmqrmw2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 09:16:17 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfz2DRAPieGxjP5II1qAX/QgQx85HrYUaRmZs1vyXa/RthlC9vKAhruiA+DgKX0yu0T8tT7ufcdJGQ10xFnku/z1irqLka6ztE8f1cNa4phZVaf+xbkwRooQN2YAFuKhpli8Zxd6YDLLOjAL4BG4w/MNOGPYju4q5zvT47WDzqwF73HrAO+/eE/PK6iDX0Of74E3yeG6bkfh6yFY1oK6tZdhYOfjPLt91JRHGWj0iKhiOSXa9T4vX36Dj3xac3079eR4dSdKNwINJoBPyNwI6uj1xRs+HULAKqQYBHCQ5d8pJsy+pTZ1vkQ/fbG2kPBoYuqmFoZi2Pnh8d7EKPmn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ms/+XzCSNGIQoKYr7u2NbDP0AOEGEmXTl68C5y4n9+M=;
 b=U0U3UxJ/2BlSIgEIAPqUVgBBgxB7tXuE/uoXIQLXzSi7ZNf4yxdKbtpXsiEp4uLvLtmte4m1BWDak8W7XmLW5dkb+MZqrXnB4/QqHU/Tg9moXdxSqdzM+HFNJ7O2IHrPYtDrMfWn1MQ6SfPh6pujfaZeHHS85J2UyFB+b/q1AGX2pRU5oKXJ9YHpGtIys5y726Gpzs2G9UR7QzDQgwFhDU/1pqs0+xT9JtIL1/BSEAtTBctavaHQni1qWyzhSiX/t7vxV5iFD+PSQ5vsic4Df3+UVUVzEUE7JzAbn8DwBaDdFoS73beBHXcFka1VRdpYpx+rR7cuHncXvVAXL/QyYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ms/+XzCSNGIQoKYr7u2NbDP0AOEGEmXTl68C5y4n9+M=;
 b=pK2lySvn579+42jQv+bcPMZ65G0jbT+1iKARff511H4skfNBkl2pQxzfa+UBWTB/Upz7jXgewnEuAwAVlpoQlHe4MZRkq4zTX4OMQf+gKe7awUX5dfO4vqz4tzq8/6tL/BXjB0JFpznnKUr414ukmO9lG3uI/9CO8OqINFxcdp4=
Received: from BL1PR13CA0166.namprd13.prod.outlook.com (2603:10b6:208:2bd::21)
 by SA3PR19MB9525.namprd19.prod.outlook.com (2603:10b6:806:496::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 14:16:15 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::a1) by BL1PR13CA0166.outlook.office365.com
 (2603:10b6:208:2bd::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 14:16:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Wed, 22 Oct 2025 14:16:14 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 9E930406547;
	Wed, 22 Oct 2025 14:16:12 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 33E84820244;
	Wed, 22 Oct 2025 14:16:12 +0000 (UTC)
Date: Wed, 22 Oct 2025 15:16:10 +0100
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 11/12] ASoC: dt-bindings: sound: cirrus: cs530x: add
 spi bus properties
Message-ID: <aPjnKs7D7b6hbloo@lonswws03.ad.cirrus.com>
References: <20251022133914.160905-1-vitalyr@opensource.cirrus.com>
 <20251022133914.160905-12-vitalyr@opensource.cirrus.com>
 <882aa222-fe4f-4724-87eb-4480de91919d@kernel.org>
 <a567b0d6-f489-4d71-be52-b7d8e0179d51@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a567b0d6-f489-4d71-be52-b7d8e0179d51@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|SA3PR19MB9525:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c1e65c-a818-4478-24ba-08de11758f29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|61400799027|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXk0ZHMxWTJXQlk0c2hPVW9qT1JTaGswNGpqa01KQnRvTXY0SzQ2a1o3VGZr?=
 =?utf-8?B?c0F3K3NPZ3pnSEYrQnhGYzF6b1A4ampEQ2E1TTg5UC9vYm5tZHF5R2FPeXVO?=
 =?utf-8?B?SjNhRXdLTUhVMkpkN3hVeVBuTGtXdXZDNGFnN3BnTzJSL2VFRXk5ZmM4OUtw?=
 =?utf-8?B?d2dpU1ZlTFh2NGxIa0xsWDBDR0RNenRJWm9VQU5FaFFlbTM4Z2hpUkR4djJC?=
 =?utf-8?B?YnFHSFp6U3NIa2t3bjZwMHF1VFFCTHhraXZnVlROcEVKWmVlVEU2c3ptTnU3?=
 =?utf-8?B?dXNlNmxXMUZ6enFKd0FVbHNyK0FRWkEwTzIyS1hSMjI4WVI4ditmNDRQcUlk?=
 =?utf-8?B?aTVNaU9JNU8xMjBOT1FVNTA5N1NBOUNDMDMrU0FiTnF4Z3JNcmtRelZ0emRG?=
 =?utf-8?B?Y3VLcmQ2L1RKb1M4bWxKMHVHVzlUTU91V3llM0FhaHFnNHVHZ3ZJM3RKdGhl?=
 =?utf-8?B?WlE4TXBVMjdYc2d4d1JFY2o5aDViaElvYm5mQUcvM1czWGhFZElOOWtMTDZN?=
 =?utf-8?B?MEtsemE5cWgwNVVmMjZEa2xhR2J0OUZyVkd4YjdLMGdPN2F4cVU4UGJtSS9y?=
 =?utf-8?B?RkVKRlB4S1E2K3pMcG5oanIxVm0yVkxkei9samp0djRCT2hsdThYRHFsOXdU?=
 =?utf-8?B?Q2d0UnpXT0QzcFJ3REFvVGcyZ25CK0h2M2pNVFl1NmoxNk9VOGtjNnlsTWQr?=
 =?utf-8?B?SGFlSW5ZZHhaVm9BQmd3amV6Z2dFVDhobVVqemZqVlc2RFB3RGZmVHc1T0gy?=
 =?utf-8?B?eEo5N1R0QWJ1cEZGdnV0QUp4OWpMbHZuVllFUUlzWDVsMnVyajB0bVBRWDc3?=
 =?utf-8?B?Tm9xK3FzbERPNzVNbGdBMmdFNFEwckxsMmZLSWw1ZUZ6TGNKZHpXdE1oR2Y4?=
 =?utf-8?B?UEJWMXlpYVNPc3I3TzQ2bjM5ZjZ1ZFVRR0hjYnhrd2cyZ3ZoSDV6MFc0YUVO?=
 =?utf-8?B?YzE5bzFPSnIrSlVvV2t2N3pCT01CM0N6OHU0YVp1ZlpQK0ZRcGhkUWhydEg5?=
 =?utf-8?B?RVNCT3BURk9zUTRSdEVvaVVlU1pyZnptODhOYUEyeTMwRTVHTjFRM2kvQ1B0?=
 =?utf-8?B?SUIvNWZVUWxhNlJUdWV5OUgyMUVmRHV2WHk2QU51dnJkMjgranpFOXBwQmFI?=
 =?utf-8?B?dGl0NTU1d2VNaFJiMGZLVjlJNkVkTGRyZEJ0cmUxYktVY3U3VlgzSjkwbjh3?=
 =?utf-8?B?dktVd3Y5b1YzTlVOMXZoSHQvVWVUVTZLRHArK3MrY08vSGliYXlUb0lUUjA5?=
 =?utf-8?B?ZUk0L2hyamoxQTgxT3NtQitkK0dPT1BUc0c3YStEUE8yVllYVFh6bjltNmpz?=
 =?utf-8?B?Tm0xdFIwVVVIZG1sREpqd0FONHYyVThqRkQyQjViUEMvcmowUHN6WnhScnFi?=
 =?utf-8?B?WG44RFJrOTZpZnNDaWFyT1JyWlIxd2dlby9TaVJJZTJGQTBIZ1VlQXZZTEJ0?=
 =?utf-8?B?OTBnTy84YkprTDNHR0FDYk1qMmZBdzg4RkVXUUxMVWU1ME9ZUVcxUEJ5eDlq?=
 =?utf-8?B?WCtNV2poV1orakNMaFBMeDJOV3owTm1BSjhFb2t6NnljaENJZmlVNVpZSUFY?=
 =?utf-8?B?VWx0YmFNK25RYVJSZjZiTG0zUnptSVYvRXRjRFN2Z2dSMEQ1SnZGUzAwY09w?=
 =?utf-8?B?U29vdzhNVXp5cG5qWmdpRmJHci9qMDFTRG44ZCtNVklMWitUcktabXowM08y?=
 =?utf-8?B?eDQ1SDhRS2pKNiswdndxaHYveWVVM0poelkrUUFpR0JOOXZNZjNVWnB1eHQ5?=
 =?utf-8?B?MXpOTTRCTVlEWVlLQ3JtbDNLYmxzUUw3MHVZdzJRNlo0Wk1kYS9ZVk9jL2RM?=
 =?utf-8?B?K1JGclhSbFVOR1AvU1VZWllaWVUzVEJwRnU1KzdyYlBvNjV6eGhaZDQ2ZnFw?=
 =?utf-8?B?VVFsSFlFbVR0VnpDNEdzRHo0azBzNjZwdi9JUlcrMWtZWlRzWkt3THhlQlMy?=
 =?utf-8?B?cEtyYlZLdGEwejgyalJGdWJCMGhXaUIyMXVaNjFyZTVyOUozVWkzaUhWOThB?=
 =?utf-8?B?UUUyTTAyYlFFTjMwWWJTbHhRSzZMZ21zT2VkRHkxTmlXVlluL0VhaFA5NkxE?=
 =?utf-8?Q?rXsZG3?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(61400799027)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 14:16:14.1813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c1e65c-a818-4478-24ba-08de11758f29
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB9525
X-Authority-Analysis: v=2.4 cv=G6gR0tk5 c=1 sm=1 tr=0 ts=68f8e731 cx=c_pps
 a=HngsKjkEkW2FdqPxnP33Yg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8 a=lHSPuTySHuMYzVEfzQ8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: DhuKfL87K2Y4zYK8u3UgH1EyPQX6IvQ0
X-Proofpoint-GUID: DhuKfL87K2Y4zYK8u3UgH1EyPQX6IvQ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDExNyBTYWx0ZWRfX5GIQ1mm5BXf2
 RLlhCoXqDVroKQQEu8b3ftMEGCzQ2nFtyxRWNethBhTR7aaInY6iK2PvRFbGdwgajXzOGYkfzvh
 vDBcmS1GroPfk/lbjHxBq/CmhQDbAUOcTvau2OzYt8BGcRF/5MVqFj3RpVGTcxFyrsEib3ZI96o
 uFgaR5elvu+eIYOYYRc28U1D3Ol9jzBF8BQjzUCGK2yqByW6MxnO+rCfT/eTmsBtAZWeFmmU+0b
 Y7tJe9YlWN0lgvc2f6ixIF2zRPQdVKZjzyAe7zC9e8EMr78qdHpqPAFZ4RYM6iOH8vSMWcM5awq
 SR8poBi+WDJ9rXtGDSEkihdy1K4yEn9eoTZIjLQnm4BqwQzflqcYbyXjApcuOhNLH4m6+kdQzoz
 K03TwHvBaU4UzW/9rC/1M0T82/4Jpw==
X-Proofpoint-Spam-Reason: safe

On Wed, Oct 22, 2025 at 03:50:09PM +0200, Krzysztof Kozlowski wrote:
> On 22/10/2025 15:42, Krzysztof Kozlowski wrote:
> > On 22/10/2025 15:38, Vitaly Rodionov wrote:
> >> This patch adds property for cs530x SPI control bus
> >> with max frequency 24MHz.
> > 
> > Why?
> > 
> > You described what you did, we see that from the diff. Explain why you
> > are doing this, e.g. hardware is like that? Old hardware? New hardware?
> > Both? If only new, then why this is a separate patch?
> > 
> > Also, since I expect new version:
> > Please do not use "This commit/patch/change", but imperative mood. See
> > longer explanation here:
> > https://elixir.bootlin.com/linux/v6.16/source/Documentation/process/submitting-patches.rst#L94
> >
> 
> And after looking at next patch I understand why - you add SPI which was
> not there, so this patch is not correct alone anyway. You need a ref to
> spi-peripheral-props (see any other SPI device). My previous questions
> still stay valid though - how this relates to existing devices and to
> earlier patch.
> 
> Best regards,
> Krzysztof

Hi Krzysztof,

Thanks for pointing that out. You’re correct — the SPI part is added in the next patch,
so this one isn’t fully correct on its own. I’ll fix it by adding a reference to spi-peripheral-props
and will address your previous questions about its relation to existing devices and the earlier patch.

Thanks,
Vitaly

