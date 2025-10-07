Return-Path: <linux-kernel+bounces-844285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6F3BC173C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 064F64F61E8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071A934BA3F;
	Tue,  7 Oct 2025 13:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="UmvegrUm";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="e5iW3Md0"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C05834BA34;
	Tue,  7 Oct 2025 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759842934; cv=fail; b=jchNOsxRg2E12wGsogfOV48KesvpSX4uhC0cwhj73hf9fPu7jnUqK7zslONrlS7B2lB0M7nmlEaDjeWz0mBdj4fxC8YKYSAwMtBBZWPdHqgY6UkauzE4H+p9sxgWUO058ef4pS4pEWAFLy7Im3qDjYtrK64O7kgctNevJLjQukY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759842934; c=relaxed/simple;
	bh=Xb5hOnDZ4EfibR9xzW3YoRiQ2OI/M5wtkP0f8Yaz/x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzUxyXXOZ5y7Z4VNBBf8bQF4zRwvUHns9fJ18NTMZOs71nLh+WY8H1jhvofajurhve96RkKRjEs0nMMlsYMKRuUvX63RvF91ey3vmJvnC/d2OdKixYoyQShsk+OVGVa3XfPeFhn713mJX1rMtDZKpVbs30janTMAIlFgX3gIVvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=UmvegrUm; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=e5iW3Md0; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5979NTow1815837;
	Tue, 7 Oct 2025 08:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=ag2gJrtf68+wQy1SoFEL4rfzNkIFOYzHxusrYRIJLTg=; b=
	UmvegrUmCGVGGda11j8i7NCsMsu7cugtp7y810jh6YtJn1YZvfLYp8BNZCVOjSIL
	giE52U+GC8KgWlVbXZ6qR3QHvJqqUzG0e54kxHCShJbXeNC3rYVHC9Xvu8WIgzos
	cxvCNUnD5yUJ9ycBHRynEfDKTsZMuDQhwOmuBJhm5KTKTLcrlQpbncP82ODXtkTp
	NHxHK87I4YX+6J93ojYU63Zrk7hBUohs0/W5/tL7KVE2qbLfxW7ldv5Qj0B1+WBg
	8FV4ssH14ftKl7hGx2C+zk/IVouUzIoCRGRfv61rLhWWtAAcA6yg8G94JKMuQSHg
	NRNBeWoQm0/s0EArP42HpA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022128.outbound.protection.outlook.com [40.93.195.128])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49ktb7a3gy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 08:15:26 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZ+H/y+q7NE2tcRw/Lx7VrrcShnLsihencQxhEufi+YNNcmRHgmAfVmyYmkGOQwaz0TmqpLvJVeXIzO2/0XrCYye/eIsmS1EL2JIRidklS2zGVKPv5nZXWsLF7DJLWSMNwIQ0Bkuy/amNY0Ve4vlYDgTqALe1aBNXY2iCRlDrJuaaHU5r2vE101gUm4jgBuUZMjJolSlgd8A2JnSLZZi12AZlr/hlsFjpTLVaASMikJ1C3Kwb+2wakazAXepyYDQuL3yT21apfrO6WtfALeexmem++0PfLYiS3WoGczSOlNf/fmpLAI0XDTnsa0SM99Ri9TtxuI/bNJuNQM2kFULAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ag2gJrtf68+wQy1SoFEL4rfzNkIFOYzHxusrYRIJLTg=;
 b=QHIr95M5BQLMBriShF9bt6nKndkM6cTc4cUvz8bt43J46qrxK+zSkfN4vj3Oi/3PbOjUVTdrCs2dJcGbjqNYRrGXDcpcmMgtqxX0I4m2AXrzRExPLnzpvGFcfKfuioXvOwX1WZZNLPwG57C2qn9bIvUHc447eeCGRBo5qsAAzQ0KBl7Xsrb+yfOmkyOpQVgKkUPsK4Gyjmx0SoXP6eQ/t8SBm+3grF8OKeMgLDhyjAkGtqgtDksk/kA0HEdOAzADsXuJ0ojPfSIet/xYjdKJaqpUrnF5Y28hIgg7uQTyQJx/yadM3jkgC0R8k6Jeg7aARs1w6iHAYBAeJmask76cPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ag2gJrtf68+wQy1SoFEL4rfzNkIFOYzHxusrYRIJLTg=;
 b=e5iW3Md0jGIPIKQA9t3vnoK4wpIiyDdLP1Yz5K++wK3XmCTSGS+y58vlajIvNLgIdEAtp4Yx9jLZ+oO3A8PptdJgoeBp7Z9gCh+LjJdY9qU6SYR5bB0Z/DkxaJjDFovTqykP6xwZY+udcbMuHDvtLvIIgONErnFyRNjlB2FHVQo=
Received: from SA0PR11CA0194.namprd11.prod.outlook.com (2603:10b6:806:1bc::19)
 by DS1PR19MB8619.namprd19.prod.outlook.com (2603:10b6:8:1e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 13:15:23 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::8e) by SA0PR11CA0194.outlook.office365.com
 (2603:10b6:806:1bc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Tue,
 7 Oct 2025 13:15:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9
 via Frontend Transport; Tue, 7 Oct 2025 13:15:22 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id B5B5D406540;
	Tue,  7 Oct 2025 13:15:20 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id A26D7820244;
	Tue,  7 Oct 2025 13:15:20 +0000 (UTC)
Date: Tue, 7 Oct 2025 14:15:19 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Sune Brian <briansune@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound/soc/codecs/wm8978: add missing BCLK divider setup
Message-ID: <aOUSZ2pnxRfxEPi4@opensource.cirrus.com>
References: <20251003091304.3686-1-briansune@gmail.com>
 <aOTrsYllMst3oR03@opensource.cirrus.com>
 <CAN7C2SB5Re35yGYsqr14hGXde3nTKLX2Aa3ZbuJ9xuT0m07uxg@mail.gmail.com>
 <aOUDbF/i4+9PXc1j@opensource.cirrus.com>
 <CAN7C2SBsFQJ2qNe0HLfpG+6cuONtpChBnq6fuFkd_CGkLt2c5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN7C2SBsFQJ2qNe0HLfpG+6cuONtpChBnq6fuFkd_CGkLt2c5g@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|DS1PR19MB8619:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b4777d-d260-4241-b14f-08de05a39240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|61400799027|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXVEajM0ekp3RlhaeXhtN2VJVTFsWTVnWUg1QWZZLzF1MXlzVzQ2TWcyY3lW?=
 =?utf-8?B?aEdMSms4RHJUVzVPSW9sUk9zeHdvUExqNTVaUXFKTm9SR2FlOWNMaCtpWHE4?=
 =?utf-8?B?dElLbnlIZEdZMXI4cGJoQnp1V0JydnpCRmJPRVdtb3N4QVZ3aTlXS01yN1dN?=
 =?utf-8?B?UHZUc1piSGk0WElidzUxdjJmSEZHK1pndnRvQmoydWpybFBTUko1Y2l5amps?=
 =?utf-8?B?SGFmaHBsRUx6OVl0cHBqbkZ3VU9TTkNaWmJYbVRlcTBvOS9MUDg3Z0hHWFo2?=
 =?utf-8?B?S2tlWkpES0RXN0RQdG9yeVpxcjRvV2NnOVJSUHJxeDlYYjBkb1VrZXg3dE9l?=
 =?utf-8?B?cXpSR3FISHdyU0l1Sk4vWHZuMXlrOGZsNDhQSDBjNW9EUVJlc3FrV3ByVk1X?=
 =?utf-8?B?bzRPR2JUQkFmaUpGMXlJL2ZaZE84cGZGa29WemNQY3NSVUdFb3lvMHlnTWdj?=
 =?utf-8?B?QU1DQk1GbFNSZ3U4cTB0TUdqTXdzSDdkejlLem8yZWs4WWtHV2xyaXplaklE?=
 =?utf-8?B?UnJET3A1Q0g5SnZ0QUxDYlBwKzREQ3pxOWJQV3ZkWXZrc0c0MHNPNkJPbjlX?=
 =?utf-8?B?dHcweExNZlgxcS9NQ1RtMlErS2psQzFpSUxUeXZDeWVjeTlmV0x0ZHpvL1NB?=
 =?utf-8?B?RldtbmZGSUorbTVtNjZ4NzFYNkROaHpNK0dNRXZMZzcydm1iOEY2eC9uOEN1?=
 =?utf-8?B?dzRUU3I5WTBOOW5UMHpKYlF1WjIvV3doN1FyeWN5L1VNalorbHpQUEJiMXFD?=
 =?utf-8?B?ZXlBVW10alJsQUVTYlhTYzhHM0tKY0pmS2VLODV0Myt1Z0ZKbEphakd5M3dr?=
 =?utf-8?B?ZkJZZXJUZmdsb0Z3aDRRTzNrRTdJUjlXcElvbVZGbDJrdVRtUGc3WkdDSzBl?=
 =?utf-8?B?NXIzaEVydWFNbDh0TE9JQ3FCVnVKUFJCS3BnbFE2ZFZZZmxFMXZMNU1xRWF1?=
 =?utf-8?B?aDd3T2YyWktoa0RMZGVhWFE1Yi9ZR1QvSU1ndW4wcFhYbzVmeEZUdWF4Uzcr?=
 =?utf-8?B?bzhHT0cyVHR6dEZnQTlqMmhLbmJSbG1iSENkRC83bWxNcHl5TU04QTRuZTM3?=
 =?utf-8?B?dVJxTitxSXk2M0pvN2ZPeTBJd0xIOGJ1eGhEbEl3ak5GbnE4N0FqbkkzRklI?=
 =?utf-8?B?WmlUOGpvRWJMWWZBYk1IZUVRRmJhVndRUE5IY2VqNWFMZ2dxenppbG9xNCt4?=
 =?utf-8?B?V081dHRDQktmdTQ3VHRaOHJ6TXZiKzB3SUpnTmw0TUFGQWs4M2xVUVV1ZXJO?=
 =?utf-8?B?eTY4aW10S0JVNWFFOHBHU1dmR29DSExIbXNPOXdDbzVmeGVuUnppVGFNcmhM?=
 =?utf-8?B?TkFvWHk3c0d2dkxkemF3TlFJVWpHQnBWQVBwOEVYWmllOEFGZEh4NmU2Q3BZ?=
 =?utf-8?B?aUkvYmdadmpSd09IdXFrZWkrSlE4Tmp0RFJsUmxNeUhZdWtiV3ZzL3FtWnVM?=
 =?utf-8?B?VnFubkJqNUFYa0hjWjUyNmFRb2xZWFVpQjR5amw5WVpwejFMWlF3OVlSQzFU?=
 =?utf-8?B?Z0xEMWJ0aVdMelJRdE1lWG45RXNUejRURnNHR1lhSXNBU1VvTW0zSXYwRUtj?=
 =?utf-8?B?WWRHQzFabDlSc2IwODA2NURKS29EVFloVHpVRFZ5RGtIMkVETUlndHhYUVFn?=
 =?utf-8?B?SEZkdmsxaXFGVXZNT09mV0Mxd1ZNK0hteWROUk9JNmt2dm8vbm9UaUhpbjVX?=
 =?utf-8?B?QXZvUE5IUWlFbDZQZ2R4OXJ3MDkzNHh6WEZuVXU3K0gyVXphSWRIN2tKN3ZV?=
 =?utf-8?B?OUtUNlBrMldZRk95VXBqRkkwaTY1NEJlampaeFZrU1FsTTB1WmtDdUt1R21r?=
 =?utf-8?B?RU1uai9OYmZrdWNEK2hxckhiSUJBRnZBR0h5Skp4eHRQc0tBaW0vZ0N1T2Ew?=
 =?utf-8?B?WUhwU2tKK01YckRZUEZJMVdHc1oyTlZydXlzYVBEZUE1RXVVUU9nZWFvNzBP?=
 =?utf-8?B?OG55WW1WUU5jOExSdVMyNDl2aGlnSDFrQmh2MW5qQlZjNVVZa1dkay9LS0xF?=
 =?utf-8?B?Mmozaks4bGQxQmthR1ZvQWhGZEpnRmxXL09KeDNjNURMaHZKUTBMOS9zMDJ6?=
 =?utf-8?B?V2JBb3lDL3l6SnJiZS94UmZiQkZhb05LOGhWVmMySWsxRmozdHZuQXMzTzR6?=
 =?utf-8?Q?RPfo=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(61400799027)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 13:15:22.2009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b4777d-d260-4241-b14f-08de05a39240
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR19MB8619
X-Proofpoint-ORIG-GUID: coh9IeQnqOjaorMDgzSHwD5PD6N5Ak80
X-Proofpoint-GUID: coh9IeQnqOjaorMDgzSHwD5PD6N5Ak80
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDEwNSBTYWx0ZWRfXzPmVFowfX4rg
 S+MLCDHYpbSiRDVHVjUc7Qhi5oBZ0wkC9z69flAffvm1/gIr7XtH/l+WCrivEHtTYNrS5DPNUmw
 3vHgRUa436trk6UxWIWb68zsgxThYydd29J7UO8PF+nZe3w0HGdXe144I5ndGeS2hCQKRTDz79G
 JrvjelOrgJ/TqeI3ticX6x875pVvs/VDfsX2z3VWuxFFUADVwZ1xDwVxiivChcfpgjUASIE8oae
 ZoqVL5aZOKYh8YdXb7K+rjvNT7V9Opb2+YVCFpjueRYU/lNgQpyKDX+QGj6ALq8LMeJtKopNRbd
 +J3fuomWSB/XakDDk68ND7Cw9JlhknEG7vFv+RqElZOCZgGjg5cgS4m14nxqhUWwh5fACYb1UwV
 vj8m4kQMnuH8pxY/8zdRIzrsBKsoeA==
X-Authority-Analysis: v=2.4 cv=ePceTXp1 c=1 sm=1 tr=0 ts=68e5126e cx=c_pps
 a=+WkigaN7fx4UYWmYucrQAQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=w1d2syhTAAAA:8 a=1qH_0-QTjpgOK4Tlm7cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Reason: safe

On Tue, Oct 07, 2025 at 08:48:40PM +0800, Sune Brian wrote:
> Charles Keepax <ckeepax@opensource.cirrus.com> 於 2025年10月7日 週二 下午8:11寫道：
> > On Tue, Oct 07, 2025 at 07:22:10PM +0800, Sune Brian wrote:
> > > Charles Keepax <ckeepax@opensource.cirrus.com> 於 2025年10月7日 週二 下午6:30寫道：
> > > > On Fri, Oct 03, 2025 at 05:13:04PM +0800, Brian Sune wrote:
> > > > > The original WM8978 codec driver did not set the BCLK (bit clock)
> > Its not missing its right there. That said your way is probably
> > slightly more standard these days, but we should take care of the
> > interaction between the two.
> 
> What my missing meant is if run with DEBUG flag on that case had never
> behave as expected.
> MCLK and LRCLK both is correctly outputted. While the current
> unpatched version will generate
> wrong BCLK complete break the codec. As such I proposed the BCLK patch.
> I had not investigate deep why it never calls but the "int div" is
> loaded and computed by where is a bit puzzling.
> And the loaded it simply with div on actual mclk/2/bit_per_channel is
> also incorrect.
> As mentioned in previous explanations, the clock register is a fix
> table on dividing # that is a LUT with restricted # allowed.

Yeah the existing code expects the machine driver to call
snd_soc_dai_set_clkdiv. I am guessing you are using something
like simple card that doesn't do this.

To be clear the bulk of your patch is good, updating this in
hw_params is probably more normal these days. But we need to
make sure the two paths don't interfere with each other. Think
of a system that is already calling snd_soc_dai_set_clkdiv() to
set BCLKDIV, after your patch BCLKDIV will be set twice
potentially to two different values and would generate no error
messages.

I think you have two options:

1) Remove WM8978_BCLKDIV from wm8978_set_dai_clkdiv. There are no
   upstream users that I can see, so this should be fine. This
   would mean an out of tree user of snd_soc_dai_set_clkdiv would
   now get an error so they know they need to fix something.
2) Only run your dynamic BCLK code if wm8978_set_dai_clkdiv
   hasn't been called. This would mean any out of tree users of
   snd_soc_dai_set_clkdiv would have no problems everything would
   keep working as before, but at the cost of a little complexity
   in the code.

I am happy with either approach so which ever you prefer is fine
with me.

Thanks,
Charles

