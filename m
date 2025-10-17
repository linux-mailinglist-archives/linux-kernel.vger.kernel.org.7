Return-Path: <linux-kernel+bounces-857918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9C4BE83CF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 746084F35E1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A3C32F758;
	Fri, 17 Oct 2025 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GTR+UCSN";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="XJVNnzbC"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02FF31691F;
	Fri, 17 Oct 2025 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760699125; cv=fail; b=I9EIYl/rVhVA8ScYZjP+b01rbKhdC30ExxbuIziZDkBk5fqd59c7WWDnmEt6FqgDBKNlRwSfrew6UhUKqUDtOFSFYosVV66vskHOSiP337jPWZW7Cy0Vm4SN7otF2syqHdOtZjpOwmJd3BgjBG2iPKd0BdvNR+oToIW9Z9JSXwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760699125; c=relaxed/simple;
	bh=A4Likzk1mgGHblHvGbBE4swxDqSsCjdzslem7xbD2MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHDif52k2xUNVULfY9N9i45CCUlwX8zGcpGu1B9EnReU3VBhlIDwCKRV4IPItELIjVT4kZ+ZCz9qyh5+d6CubPoSY9fTQ6JsWZ2xihHwFYDrQh6HJwpo9vopA4EP2KLdvmg29AZ91G6d/FjtgkRaMUun+JQb2J+Y7cPYETa2Gog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=GTR+UCSN; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=XJVNnzbC; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59H0YkTQ4021107;
	Fri, 17 Oct 2025 06:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=ukvYPkS27HpSzYjCkaN2QxYkHEckGtfysiLM8yqvqQU=; b=
	GTR+UCSNtb350rp91AjirKnCfOjSVbpfhLBi/BVKvObVx48a+1hJoh5p6ZuDj54u
	+yDz1kbqV1w3I7sCyT70XS4qXnxXEslUpfuS+PoFynh+ZU+sYZs38uaO7N0RNtML
	6weaTnWLNm8+PB1kdaJFxt8i7Vx+jZJenhoU6N1eV8MppNaZfHxo+ssJk0E/oCJU
	7rOre4LWoJMXeCcl52uDmgzZhYiXj6B07fzD+WxrstBn4gxOUExUV1OfJ3wQPeIC
	5nJzpN+ZmnDiCJfD7v1xzpBWiL9VEyYAXWFyzRvGXDbkV5yCzWirf1jpvBTQuMQz
	9OEVqpc5CH0xaAQqCYbBuw==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021117.outbound.protection.outlook.com [52.101.52.117])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49ubc98gck-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 06:04:23 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KN1XaFJ/c4ElfdW9ePb9N6PWp2wArokjr/nODttWZ8n+KeZY84FuwG0U7pSzt1M4JYShYI3G61I0yWS90V3FHpTaAoD7kskO2fX4jH1YMpgOasVsMfqb+xxLYy0h8rHrMo/Vn4J+TbgI6l3PWSg7oFja2gfWC/WPsgzfKxna7QNn/wHG2/fAJHhj2yl2dflcFGzo5l0AEPxnFuA5h7HI4Pj1ikKdb6ddQ8Nz2V+4hyvMVOP3tTjU10/Svmpmdvy37syml5xvl95ay2XLl+haylEMKo99ceqgugoovjz8Xo9rYoSzSQ+rA3/EPHs3oDJ+df3R1aWzVHvsFgSoux1UzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukvYPkS27HpSzYjCkaN2QxYkHEckGtfysiLM8yqvqQU=;
 b=XgWh21J/RkH3DL0hkYdc36LsU+OrC6Ax9nGJmf2KV0GK8plXns3cCMRoLFHAxbaoeN4HyA2vbPEaJik//ttdPgGLx2nutSJvW6F5RyWF/dlXT3cbBeLAMhlPyJnrBkqgqvYb4Bd5DMqwRcS5iYv5ieEe8jbmNf6tuTRtJ3BChow/mLOpJ7BZFK+ewatvhX2qRmQJ+lIR75pNgNurXHO8nfHbcVmGjymF+Ib0GgnNM/1vi0ZRjJYgVOe2U0Izfq6Xbr3Mg7La6bv9L+PXTc04ubkRmlKLi+O7kBqkA2tuR5AUFTn56Zh0yHB95zXLLVON5AyIJ8Um/di8VJv9H5MgNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=arndb.de smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukvYPkS27HpSzYjCkaN2QxYkHEckGtfysiLM8yqvqQU=;
 b=XJVNnzbC8sUa81evBStjGOUa68Xjp205+5oPWkDtgE/+9+X8TE9HjcJrPmCjSHcXfNc+iA+pGwEEuGI0TW5dba+ly8aSUy/15bxMZuQZlI3M6nbBt7QPjzvOvfxCZdCKSZi1vriKDWJR7uRjForYKqi7uDlGkIm2prinN9LpOSs=
Received: from SJ0PR03CA0173.namprd03.prod.outlook.com (2603:10b6:a03:338::28)
 by BY3PR19MB5044.namprd19.prod.outlook.com (2603:10b6:a03:369::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 11:04:19 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::83) by SJ0PR03CA0173.outlook.office365.com
 (2603:10b6:a03:338::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 17 Oct 2025 11:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Fri, 17 Oct 2025 11:04:18 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 37068406547;
	Fri, 17 Oct 2025 11:04:16 +0000 (UTC)
Received: from [198.61.69.19] (EDIN4L06LR3.ad.cirrus.com [198.61.69.19])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 550C9820249;
	Fri, 17 Oct 2025 11:04:15 +0000 (UTC)
Message-ID: <123bfcba-dc3c-4b67-a2d6-07745358fc23@opensource.cirrus.com>
Date: Fri, 17 Oct 2025 12:04:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/7] Rework the awinic driver
To: wangweidong.a@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, arnd@arndb.de,
        srinivas.kandagatla@oss.qualcomm.com, cy_huang@richtek.com,
        nick.li@foursemi.com, hangyi@everest-semi.com,
        alexey.klimov@linaro.org, niranjan.hy@ti.com, shenghao-ding@ti.com,
        linux@treblig.org, thorsten.blum@linux.dev, yesanishhere@gmail.com,
        ardb@kernel.org, ebiggers@google.com, linux-kernel@vger.kernel.org,
        linux-sound@vger.kernel.org
Cc: yijiangtao@awinic.com
References: <20251017101106.370742-1-wangweidong.a@awinic.com>
Content-Language: en-US
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20251017101106.370742-1-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|BY3PR19MB5044:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a0f947f-4718-4610-8d37-08de0d6ceb23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVNQZGFncTZBSDk5aWttbUg0Ui9LVWNKVWlXYVNkcXE4L3lUbkFEcUFXNUlo?=
 =?utf-8?B?cmZYQW4zd09DV0o3czJDR29Lc1c3alYwYzBhTXNsbzZyY3ZHeEJqYW9ZNXU1?=
 =?utf-8?B?QXFBbUxBeG5uWS95S2prNWFkNmNwa1B4NU5mQ2lvQy8rd0lCaFU4cVU3VzZv?=
 =?utf-8?B?dTRSM2FTNW9iQVlkY0paMjVPbU40dnBzbmpKOUR3dHhqVnJDOTI5VVBEZEli?=
 =?utf-8?B?VmNKNDlrUlMwK2N6SmtwcDlBWDg1SHJtcGJraytKK2F0YzdTK0gxdzZZZTBU?=
 =?utf-8?B?blR6ekxEeVd6R0RmNjZCc21yL1MyQmNJNUQwYXgyWjVpR3dCUjRJSUoySVYw?=
 =?utf-8?B?bDhheG8wK3Bmb3FELzRmZjkwY05KbWdkc2JpcW45UU5uek5rQXhvV29FeTlS?=
 =?utf-8?B?RzZuZzlXRTVNS3ZWVDBBRjJITEVJcjhUUHlZb04zMVlBSnE5ckRUUzZ3a3NI?=
 =?utf-8?B?MjVHaENEaWlYYzg5QjJZc3NzRnVkK29qNEJaWThXR1hNc0tTczhGb24yMmRo?=
 =?utf-8?B?RlRGLy9QcnVBYURjZ2IxMDVrQWI2SGFsa1paVmN0aWhBa2pBclJQbkRSaU5Q?=
 =?utf-8?B?bmwwUkprZ0k4aHZ4RHlISzdJRWMyRFh3ODJQOVdUcndMdXBZbnJDd2w4eTVn?=
 =?utf-8?B?RzBSc3VtQzR0YTdNWEZRMUdNSGtBNm14MTd2MnZoUTJiaUhERGJ2VEhPRjFV?=
 =?utf-8?B?SUZoTHdXamFoWHdveUVLRWlFVXVMa0tWTFVacy9xUnFjMDhxbzV0bkFvTlJp?=
 =?utf-8?B?d09rWnpJRHdSVlZKbXVJMDlDWSs1bURRODBzV3RHaUdTdXBqV21QMXNLblRo?=
 =?utf-8?B?SXd1Z2xlcHROVUkwVld5U0Z5cXk4NU9sblcwb0xMRlRwMHViL1pibnYyTzU2?=
 =?utf-8?B?YTFkVkZhYjI0ZTFOZTQ4TzFGWkZ4a0ZlQS9VSVdrUklqeTRjbytUbWpzaHla?=
 =?utf-8?B?THI5VVJDN1lEbGI4N1hJQitWdDhRVWR0WnQzQVQ3cWl2RFFGdzMrTSt3UU8x?=
 =?utf-8?B?UlZwVnlqTUpjVW93WlZVbTIrU0Jlbks3ZjA5MTZKWGtTRHRqTDRZTGVBWkxQ?=
 =?utf-8?B?Qi94Y0tXQ1VGWFovc2h6bFRZV0EwSnJ3SlpBQnYrUWNMRFpSQkxaNEpqRFZn?=
 =?utf-8?B?S1pTeXBrUnlKOXFCV0hLUEJCK1RxdTlFTXJPWU45VS8yMjNFU283cjFGb3pH?=
 =?utf-8?B?UnRSbmNzeTRQRDFDb3lSajZIQWp4ZW8vZ3I0UmpZZUIyMURhZlFoelRQTmNV?=
 =?utf-8?B?Y3kxV21vRzZRY0N5c2dCTCsrYzNnWmMyWVBPNUpFRzYyUmlIYmtqaFZGQlB6?=
 =?utf-8?B?WndyR0N5NVRMZW54RTB4OHBXT09McUtTL1hmUnYzNnlaUE9JNGtkSzNhRHpY?=
 =?utf-8?B?Z1JCbUpGMGdIYkpXTjFCNEozZkZBMk8wUHdhci9hQnpaNE5JdWl3M0MreVZl?=
 =?utf-8?B?OWc1azZ2NjFjR1VmdllveDd1ZmdsaG4zSTUzUmE3MmZDYXNSc1FPN010cTY4?=
 =?utf-8?B?U25lOU1takt2eFBWUTExMnN5cnYwNzdJUHNLWDdjZSt2c3J5SG11VE5DeGo3?=
 =?utf-8?B?Nkl2Q0VTZ2M1VWN4ajJ1amszRHpyYWVNZlprQSsxWkdwdG53bmkyb0Z0U0FU?=
 =?utf-8?B?UzZKb0NsY3RIbVV3VFhuNy9FYjdkUDZmRVkrM1IxcnIzSmR1Q1lEOFJJZDNG?=
 =?utf-8?B?Q2VyZHkxTGE0elJrUGNKN21LaGhXQWlmQm9DMUUwUWFDYUtXcEl6ZC96Z2hx?=
 =?utf-8?B?WkpOelZ0dk5ITGs0eUk2YWcrMWNvMFh6WGs3elNwWjRHTlpnQTkyKzRvNVQr?=
 =?utf-8?B?ME4wTjgzejVFaVVnRXdiS2RQM3RWc3VjZGovSk5JTDV6MmM2SUJxa0xXQjRq?=
 =?utf-8?B?MElmKzVUWWFETUlTNDhFdnk4ZTZHUTZQSVJJUG5oeFdTQVBNQnBrQjVEMG51?=
 =?utf-8?B?ZmtQd29KU2ZCR1VGSFVGZHJCaU9WMk4vYjBTcml4TURuYXhrUFVsbE05Nkk5?=
 =?utf-8?B?Y1psYUhxT1RvelRkaUxyVnREd2dnYWEycXZXYm1RcVB3azJJWlBZQTNZb1N4?=
 =?utf-8?B?d2R6b29EZ2U3U1NhQ0g3Q3FocG5jUVBmWnAxeTJCWmZRMGNISnYwbHdabk03?=
 =?utf-8?Q?erSv0Yc1/+ZfkxmHNNVKAtnvC?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 11:04:18.2430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0f947f-4718-4610-8d37-08de0d6ceb23
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB5044
X-Proofpoint-ORIG-GUID: oRl3xZxeCa7mP7Ut6F72q-Fl78aQ_WGl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDA4MiBTYWx0ZWRfX0qewL5J8iJv2
 KnV8BEzNR+1k5krjYNxfg0KKTxQGz7teMtruqwXvf5eyWnrvsVfJlxgm6MJm8Zz20Apzjzyy+2h
 tQLq+ZWA10J2lCOJUo+9/AqXXWmhwXClEGbmOrlx8EtZJoIPZ85q/6cu/5iHCSPFvIpQ67LcJJ+
 iEgleLbLOmGYDFWK4uFiOq7TZwPuVeJ78X2KmxBDTxogw+MmvKdPUd/FV4MsPPkz1TQJwxtVD38
 eGyJwQxwr5loUXBccauttM6K/hE9qt0a9QDFn3Uzy2es6RmT12n8Jm0r89pDLQzOXmNe1/IdyyK
 U6Cb+I+n4k/9czM+qCYWafpnHhWLpDX0vzT7TGYx8aEKl3qlMGBnTM6svAkT53fkzaD+4NabvEU
 gvczoSIRB55dyNkJipk13n69lctAcg==
X-Proofpoint-GUID: oRl3xZxeCa7mP7Ut6F72q-Fl78aQ_WGl
X-Authority-Analysis: v=2.4 cv=H7bWAuYi c=1 sm=1 tr=0 ts=68f222b7 cx=c_pps
 a=nUtUY41U26iC5jD0qKn5yw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=rAIUexmuAAAA:8 a=zxBkCtieKWvCaKq7P3EA:9
 a=QEXdDO2ut3YA:10 a=GZfmMn6OKCOH3ZLcxICL:22 a=nl4s5V0KI7Kw-pW0DWrs:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-Spam-Reason: safe

On 17/10/25 11:10, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
> 
> Rework the awinic driver, extracting common components into
> separate aw-commmon-firmware.c and aw-common-device.c files.
> 

Please remove me as a email recipient. These are all awinic
files, which are nothing to do with me. You seem to be spamming
a lot of people who probably also aren't related to these files.

You only need to email people that get_maintainers shows as
Maintainer or Reviewer, and also the mailing lists.
You don't need to send to everyone who has ever committed a change
to Kconfig.

>   sound/soc/codecs/Kconfig                      |   14 +-
>   sound/soc/codecs/Makefile                     |    8 +-
>   sound/soc/codecs/aw-common-device.c           |  508 +++++
>   sound/soc/codecs/aw-common-device.h           |  206 ++
>   .../aw88395_lib.c => aw-common-firmware.c}    |  150 +-
>   sound/soc/codecs/aw-common-firmware.h         |  211 ++
>   sound/soc/codecs/aw87390.c                    |  118 +-
>   sound/soc/codecs/aw87390.h                    |   16 -
>   sound/soc/codecs/aw88081.c                    |  357 +---
>   sound/soc/codecs/aw88081.h                    |   33 -
>   sound/soc/codecs/aw88166.c                    |  819 ++------
>   sound/soc/codecs/aw88166.h                    |   58 -
>   sound/soc/codecs/aw88261.c                    |  427 +---
>   sound/soc/codecs/aw88261.h                    |   52 -
>   sound/soc/codecs/aw88395.c                    | 1333 +++++++++++++
>   .../{aw88395/aw88395_reg.h => aw88395.h}      |   58 +-
>   sound/soc/codecs/aw88395/aw88395.c            |  576 ------
>   sound/soc/codecs/aw88395/aw88395.h            |   58 -
>   sound/soc/codecs/aw88395/aw88395_data_type.h  |  142 --
>   sound/soc/codecs/aw88395/aw88395_device.c     | 1720 -----------------
>   sound/soc/codecs/aw88395/aw88395_device.h     |  214 --
>   sound/soc/codecs/aw88395/aw88395_lib.h        |   92 -
>   sound/soc/codecs/aw88399.c                    | 1027 ++--------
>   sound/soc/codecs/aw88399.h                    |   93 +-
>   24 files changed, 2929 insertions(+), 5361 deletions(-)
>   create mode 100644 sound/soc/codecs/aw-common-device.c
>   create mode 100644 sound/soc/codecs/aw-common-device.h
>   rename sound/soc/codecs/{aw88395/aw88395_lib.c => aw-common-firmware.c} (89%)
>   create mode 100644 sound/soc/codecs/aw-common-firmware.h
>   create mode 100644 sound/soc/codecs/aw88395.c
>   rename sound/soc/codecs/{aw88395/aw88395_reg.h => aw88395.h} (91%)
>   delete mode 100644 sound/soc/codecs/aw88395/aw88395.c
>   delete mode 100644 sound/soc/codecs/aw88395/aw88395.h
>   delete mode 100644 sound/soc/codecs/aw88395/aw88395_data_type.h
>   delete mode 100644 sound/soc/codecs/aw88395/aw88395_device.c
>   delete mode 100644 sound/soc/codecs/aw88395/aw88395_device.h
>   delete mode 100644 sound/soc/codecs/aw88395/aw88395_lib.h
> 
> 
> base-commit: 98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09


