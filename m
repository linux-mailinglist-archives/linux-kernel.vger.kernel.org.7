Return-Path: <linux-kernel+bounces-858488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7F1BEAFC1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D707471DC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFC42F12D2;
	Fri, 17 Oct 2025 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="fejDpFCL";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="ihQEL+Qr"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C12C0F92;
	Fri, 17 Oct 2025 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720279; cv=fail; b=slVQrJUnOjrJoycJXsLi5udkNP2CA78Robqvh94odlF0yrfkwN7o59UEd2YEvDYuNfGc8Mv35OA6BtADeH/DuxBBHZzmIy1KGsxawez7JzkHl9PfycfTBu9G0wPmSpmM+8qxLsc+LDAIEWgKXeP4vcw5pZTpJGK48jcWKACVang=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720279; c=relaxed/simple;
	bh=7gWzX8/mewedR4skGrPMWSZQUk0tc4EisgGlzv9l2F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtanFKwdje0BMzWtdA4lqugW+dHF6ijdi+DC9BvwVvGCgVfvONHfA09AijMjW32fIMtUhVvlrF8qVsSDTHN2Smdg1i6SMFRcU18eSBYqYZZQInLtsk7FFd49Qr4/K93KeZTwa5Dcu3fjO/WdQrhkU6JtQvA0u3U9JZOYHIS8Rsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=fejDpFCL; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=ihQEL+Qr; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59H0Ykp74021107;
	Fri, 17 Oct 2025 11:57:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=LV6tD0RGIoNS93ooyVi6GvGnSf7Ko7JrUGP30atv4jQ=; b=
	fejDpFCLP0EhSh4fbBdlsbR52kHIWHDLXJTg6ZpCeAdJfCWqZDx8qrRm3nZ1d8m2
	Ny6XDHei67UFaRK7GFBblp07lMaAXstXIkNJ7JvIru9k4zXYtNFikfVAJP/FgKoy
	ckr5HH7wb8ag/WvVo9mJE9XxHKMYOAHoxDqzL2JqpjL+FW8p7LFzuAX3ipSCJpeh
	EJDCyv11276DsRVxv/kSFagqI+p9KYiiNi4CBop1xTMhz7X+azNa0Q3HEYgHjfFC
	Gjpy3+G/yi/x2HW4MUnjZuQdEdCNWsEg0TGLo94uzstlBEorNp5OB06rW/6XN7J7
	Z2+7wJ1yJ/Oy0jWJ7Cgo2g==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020072.outbound.protection.outlook.com [52.101.201.72])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49ubc98xxn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 11:57:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8mzvjgrZcPpf+fkmOyZHvOUKEScuk/rdQyX6aO50aj173I5mDWyGthX2tWA2xWqDdmavyhpY8EsKreykOjyi4Z+af8AtwpMlqAIUrpKL5LFije7NU/qVfo1ciQ1A9y7r94Uqr1+JaxkEgJQxH4ck/u0VcS1v7jEkJX0lTGhHZXdRbGRFEigV3dNve0D5sIam2a2JA9tQI/Is7563d4hVCo2Re4pz8loL65fZhHMmebSYxTht1a9Lu5KrT58f4zOaKhsUcdwqe+QxLZbfnDA1HpmjLR3asUJT6YUZCh3iC35b3TwLTGWbSyk+BKCqTGmgefemdc/uoesaYq5lv+hZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LV6tD0RGIoNS93ooyVi6GvGnSf7Ko7JrUGP30atv4jQ=;
 b=IxCsw4fMuBS7zxai66COm2dIwEHP3Sh8G2sTJ1sDzUNRP7BdBB9oRGOJgMfwxp9hW2tOuzfUvyUeEJ/Tv8xi1g2bqavw+XY82dsap7IHZISl9C8An71+9zjhOdskcETE5YEnEcQtLJOryu1gdV9iJ+Gt2DaLFf4sjRNpRFDNAAGcV3bnXf/qBp+IP/L9svMRJQ9VPPzVVj3Nx9e7mQCKHR9ybEoiKaZh//6mOb7W5TznQm5jrNI8v1uaYBd13ZRIkxGfvnA8CAQt6VLyFyCzmsaT5kZwTNv/ymFVL9BVwFRb5PnPkt6W8KqsXXg3zMbadCGpkaQKwAWU+EfmZ83Pxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LV6tD0RGIoNS93ooyVi6GvGnSf7Ko7JrUGP30atv4jQ=;
 b=ihQEL+QrAxc+UPppDO9qkAvcg8rP2hH2PJlzSMDLN9ZYSpHM1E5kSO8ZUM/Yj+6zoyCmP47u4yVEGzk43F0MnSXNsWJPCY0DqXPv18H+uGMYnShUvobOBy+GqsBpjGZZ0WkTv7T8VEIDjC8VR+8nPRV2eOVtyHnFflym0LD2b9w=
Received: from DS7PR05CA0045.namprd05.prod.outlook.com (2603:10b6:8:2f::7) by
 DS4PPFF446EBDEB.namprd19.prod.outlook.com (2603:10b6:f:fc00::a62) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 16:57:45 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::a) by DS7PR05CA0045.outlook.office365.com
 (2603:10b6:8:2f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.5 via Frontend Transport; Fri,
 17 Oct 2025 16:57:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Fri, 17 Oct 2025 16:57:44 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 216A1406547;
	Fri, 17 Oct 2025 16:57:43 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id BCA37820249;
	Fri, 17 Oct 2025 16:57:42 +0000 (UTC)
Date: Fri, 17 Oct 2025 17:57:41 +0100
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 09/11] ASoC: cs530x: Correct MCLK reference frequency
 values
Message-ID: <aPJ1hS-YD2M6nsJi@lonswws03.ad.cirrus.com>
References: <20251017161543.214235-1-vitalyr@opensource.cirrus.com>
 <20251017161543.214235-10-vitalyr@opensource.cirrus.com>
 <a16503e6-870a-43ce-a705-27c0ea199303@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a16503e6-870a-43ce-a705-27c0ea199303@sirena.org.uk>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|DS4PPFF446EBDEB:EE_
X-MS-Office365-Filtering-Correlation-Id: bb9ceaaa-62a6-48fa-6e29-08de0d9e4aec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|61400799027|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TStJaS9SVm9WZnY2VEFkL282dWJYR21FUlpFVW1qTEZHd2ZEUHJ4Q2gxcUlO?=
 =?utf-8?B?UCtFMk96OFpZY1R2b0pDOC9HcFBWV0tYdllFNkRoNEE2WjhBbDAzYXBwTlQ3?=
 =?utf-8?B?UFR4ZzQ2RmJ5M00wYjhEMUlNYXhYbGJRTDBiRTV5NXpuUmMrS3F0eUZhV3Iv?=
 =?utf-8?B?NGlPU0JDNGFuSjRHOVU0Uyt2VHJ1RDhnaC9RT2U3ZDUyamZjVUc3bmtRa1Bh?=
 =?utf-8?B?emxDU0tVdkVubjNERStwRzJFVXFCd2JpdHM5UXJsTXlQbkRsZ0JjSkFXdnJK?=
 =?utf-8?B?djlwc3ZNdUpmazhnRmk1UkN6QTZ1T1RXcm9BanBpVmZLanZvMGxUSEF2WTNY?=
 =?utf-8?B?b25YZWJUeWhjZUdtQlFSTDhjVjZEeGRoQ3ZoY3B6R3NZN0k3emlQaWt6NDhu?=
 =?utf-8?B?bDUwQzFRTG0yMmtUcGRoZUdUdnk3eVhvcmRnOGRpQktXL2M3eU1ZeTJwZzkx?=
 =?utf-8?B?NHRhNlo3L3owM0tXTDdRdXFmbGhnOVlKTnJreUFqeXVQUnJ3TXFHVkx2WVcv?=
 =?utf-8?B?VzdHZ1l2blRrdmRQNWJuclBvNDdFVTRRRUVlSTJsMWNWUjdwYjV3NWtaNTNz?=
 =?utf-8?B?V0hGT1dLRmFPdmNwckFLMURoT2xvbG1mQWtuc2gyQkJXTkVXTEJMYkdCazlZ?=
 =?utf-8?B?Y1FaUlA4ZTRBWVMvNHVpTndLdGFGYUlYbFZDTUtJK2loNGF0L3F5ZlNaV1dP?=
 =?utf-8?B?SVcrYTkvVEdtZ25GeGtwcTZtRTlnVzhFOG5TMC8vVkg5ZkNremNRSVN4NVpp?=
 =?utf-8?B?R1p1UGlaZC8rMHBhYVhFU1JURjh2R01DYjRzQmZIWXdPbkFGdnVZWlpNTkt3?=
 =?utf-8?B?YlNGUHVFcE5QN0xpOGZzNUJneW4rVU1KNVpnbWVRQkd5aS9Ma1lDdnZxaWlD?=
 =?utf-8?B?NDRqZ002UmVJZDNqZGNSNDlWeFFDbEVyWmtUWWpnYnhrMmp6YzJQN0lxb1po?=
 =?utf-8?B?U3VORnZmQzVxZTB2dkpVTyt0QXdTVk85RlRwbWkrY2lVeEhFS0JTUHBRbC9z?=
 =?utf-8?B?MHpWUCtKbVJxdHZCbUo3alU2U0pFNG9GTG5JcEZKSEcyZE8wbUxCYUJ4NGlX?=
 =?utf-8?B?Y1FVMVd3S2xGUWQ5Z002RDE0L2g4YjF0a2NyQkthVWZrNlZVc2RuZ25sWjRF?=
 =?utf-8?B?MGlVMEIrMXNmSXFHZlVmNi8vNnB4QXQ5NkpTeHExWWE4QzJzU2JwNzVwWndN?=
 =?utf-8?B?Z0xSQ0xNSVRnVitHa2FYektHWkl6c2l1V1ZYaUhlS2RSOHJ3WFN1UUJKL2Fm?=
 =?utf-8?B?bnM0Mnd4QWg4bUtXWFNEUEhGcWRhaVphTVh0OUZCcjJMQ0wyTGpCMy9XYk5k?=
 =?utf-8?B?aW9zK0FGeStvcnN3QUY4MWg3bEl1RkNSTG1sQUoxM1prLzZCT0hUU2ZyNUFx?=
 =?utf-8?B?Y3A5c3A4SmtncnZQNFJJaXVzZmUxQ3owUE44eVB3Y3p6SmRTOUEyM1kvbFZO?=
 =?utf-8?B?RldNc1ZSdGdaMWVKSjQzS1REakg2eVhtY1VaTGR6NTNlU3pTZnJQM2JTMlVN?=
 =?utf-8?B?ZkE0Ri9kWk1EMWhhbE9Nbm9obVp0QlB0VHdhOHFqZGU5TjBETEl2U0x3TlJs?=
 =?utf-8?B?NTVwa3hwb1JuTE5BZmVkUmdzb0FKdEZ3ZFJaWW40MDBCWTk5eVF5Vy9sZlZZ?=
 =?utf-8?B?Z0p2R3A5S0JxaWVyWTRMcFdtUHRjY1Z1TWRpUFg5eWZNb3dINmp5MVVlbWR2?=
 =?utf-8?B?WTZDa2x0enZxUGVPU1F0NkdnTVNOcTl0dTc3cW1ESTZUZUNlZk1xWEdXNHps?=
 =?utf-8?B?Q09FUnphWXVPay83NW0zN0l1bkFFWGJTaTVYWG45QlBDOXFhamI4K0xFVGl2?=
 =?utf-8?B?K2JlU0pRRVJXNDh2bU1Pc3g0Zk5GTnM1V3haY1RVSHl1TWYxTzJmUVZqVVpO?=
 =?utf-8?B?bU5NYUZ0MDk5WHo1NUgwTUFtS1d1T1BwQjlnakJtL2dQVXlPS2RFR3p6MkFt?=
 =?utf-8?B?WFRXUG9zSWdtd05XQjVDSTl4dDJXUVN5Ty8rN2hhSFBNSDllZitRZEdseUIy?=
 =?utf-8?B?eFZBVFNhK2N5R0RwVnpzd2hEdDlvNWZhYTczZUtlbFZobisrME5ZWmduTHR4?=
 =?utf-8?B?cTNTb2xta3RMenlrRVBqOFpUTmw5bHJEMTR6eVQ0Uk9tekxKMmRXdnYwTWxQ?=
 =?utf-8?Q?VMA4=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(61400799027)(376014)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:57:44.3720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9ceaaa-62a6-48fa-6e29-08de0d9e4aec
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFF446EBDEB
X-Proofpoint-ORIG-GUID: TIZfYS_l3QyOjZrgMprfq9Ql-1B2GTnh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDEyNiBTYWx0ZWRfXw/MqXKxqHotn
 3wKdZd15iAkAElTADFPqauwKiaw5pG3pLCRYUFAs4dInmka2nUSLAJVfr8AxloFkiRXuBiRVWZw
 toyz7mePXizUS8s+sZz1Qk02zw8iHA19YEqGfaESoSBgcUJsasqs9r50WKTlAa9pk3vqQCAEa2s
 N1fY2uj8j0VDLpsmPfyHyUJCEODqon+efcvRsOaQ0SPz3nACePQFh8MSqnXHqvCUR+wGBF6OltO
 9wOYOWc40bk03rJHTY6BZGIXoEVQLeYSi9fVaDsixSq9D7vxauWoHAaBWH6fxbsoS44WiWFes0g
 xYOe1tQVnbKRhGC45TT7MIc5mDByLttc1M8RWPA/PX1m4U5mQf6ZhZ6UYK2yKRsNQFbGX4lgrhc
 I40V2v9KoK3gRV5UsGCIQuGWQnz+9g==
X-Proofpoint-GUID: TIZfYS_l3QyOjZrgMprfq9Ql-1B2GTnh
X-Authority-Analysis: v=2.4 cv=H7bWAuYi c=1 sm=1 tr=0 ts=68f2758c cx=c_pps
 a=IBJHqVCGmmUWI27oiwGTEA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=qAyo7-W0RYy2w9U-SnQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Reason: safe

On Fri, Oct 17, 2025 at 05:44:06PM +0100, Mark Brown wrote:
> On Fri, Oct 17, 2025 at 05:15:36PM +0100, Vitaly Rodionov wrote:
> > The MCLK frequency must be 49.152 MHz (for 48 kHz-related
> > sample rates) or 45.1584 MHz (for 44.1 kHz-related sample rates).
> 
> >  	switch (source) {
> >  	case CS530X_SYSCLK_SRC_MCLK:
> > -		if (freq != 24560000 && freq != 22572000) {
> > -			dev_err(component->dev, "Invalid MCLK source rate %d\n",
> > -				freq);
> > +		switch (freq) {
> > +		case CS530X_SYSCLK_REF_45_1MHZ:
> > +		case CS530X_SYSCLK_REF_49_1MHZ:
> > +			break;
> > +		default:
> > +			dev_err(component->dev, "Invalid MCLK source rate %d\n", freq);
> >  			return -EINVAL;
> >  		}
> >  		break;
> 
> This will break any existing user that sets MCLK won't it?  Hopefully
> they were managing to function, even if the clocks were out of spec.

Hopefully, there are no existing users yet. This was used only on our development board,
and we’d like to fix it proactively before any users encounter issues.



