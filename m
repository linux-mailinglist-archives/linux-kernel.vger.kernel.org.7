Return-Path: <linux-kernel+bounces-897428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BC7C52E05
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C2A504AE7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C77733C53C;
	Wed, 12 Nov 2025 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ZOkx9Ft5"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FE32BEFE0;
	Wed, 12 Nov 2025 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958448; cv=fail; b=qhN39zQrLQqtAqVFIBJE4rZyRmjc1X8yGpBUPq0hOco5fuycPA0qKZLSe0/UQctSdDMLd1GQ0RI83WWvyO66zYu+3Xzlm5fCpCU2o+QSsKc6RXeDIjPNPKyDakgkm2uWRRKAdIqlXnKfEiIM06R9fI9MckINGEHBJkkJDBjzuvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958448; c=relaxed/simple;
	bh=FGZkrweuyb2dkoO6tAYK8K3WgwPLzzV2e9PkvtDWrUo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=B/m4/2g3sKDK/5BIjIpeLDra4JqmSeA/V/ucsrVBN61IbRmJSdsHqKXE2Y2bocNIo8vLZhzuuLTPPVOyfAfxk0SRadsDzHGNj6pwfu9+w3NgJBvng/0QITr98dIFlzgt4k9YZaYloPWcZKT0mDGBG7OSQCNOX7QhTmkGIIQHm28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ZOkx9Ft5; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACEZ1Cb971493;
	Wed, 12 Nov 2025 15:40:35 +0100
Received: from as8pr04cu009.outbound.protection.outlook.com (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acq20hfhp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:40:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVjtkhVSdZHbqPWvS+1GiAnjGMy7GbrLgURtcaslCs/HjGWMWcRIevtwn6DH5bMGJ+qt/QE+Yf4c+xHBZ0cQitetzL2icEbhTHsp1nXsAfz9GUddfo7qK/M1+mA7va6HWMEOJWa1uSCw6FX4Ty2EZWx7qrfEWiNMZ/H3je8l6sIqVkVWwKfWkwLtL5mnuv4oaV7TV8FPMqeDSxJin0Okv1aIoURx672YY1rEAAEt7q9fuPCo7ixxMuFNCPjHmDj3X7beJ1hhabD3UD/lz4sfqlIYSI6a6HrVuZ6uu9LoACoUnoVETCF42uui0M78KgKMIGhknECw0EMe44P8LYPTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqytMNzbU864lz7sDOlBeq8WS09fFDNhS6001lXuvwA=;
 b=cOXHoUS+T+3lT2PKDl+tDrvB//7bk0LdAIf29XUa5+r2GzH3JRYscY16j3q8Kl/EbOHqed18h8kxiNYoy301tRW3jbhroQquF3LhZg8u9OK57OMZPp1QFtRvIv7OylCttZSNaibCcxiJZRTqOpDHxi89uuAIQqZ+RDkAGJBeMxdNINqiWwL2j+592p9yMr+xOlacA/ISNqGDXgO6puMLK6tno+VRMzfDG85h53FiiUmNy1EJLsLbOSBfdBsSJd5o7cYvphe1ilCRqqPyA4b1UHtk4f0+05kQ29thMsipVYAnXN0iUrDHGorIPf1Omns6Mg/Ray+c07VNq5zVvxAb/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqytMNzbU864lz7sDOlBeq8WS09fFDNhS6001lXuvwA=;
 b=ZOkx9Ft5YEWsTqRKmMw6JjSy0n9/k0XyuLTMAI2tZ9QErBwKcE3pGA04cbnlEhNL7SzgYK3PjlQHJ40TBEaZvNeh29a/bAmlhtcWVNqhW161aOLEJIn0aHjfPpiUu+ts7mAbgfhbSVakxmlwGxcGMKVQms4J0ZxYIQ+6XckzdjBVDfz4EWQmHkH6SvbFb6MmAiIOfpGMKrko99+BE0NISWCOazvqj2j4xO/FE/GXupsN8XBnGi5OxbHZuosKItzY79AKZmgW2IPgJL8L08aXt+kqNmpWNsBNrcOKDSBIyBsMSyhxzx5gVQ/cq07W7PC2Ee9KkwcgSla9kRCJPl/t6Q==
Received: from AM0PR03CA0022.eurprd03.prod.outlook.com (2603:10a6:208:14::35)
 by GVXPR10MB5935.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 14:40:32 +0000
Received: from AMS0EPF000001AA.eurprd05.prod.outlook.com
 (2603:10a6:208:14:cafe::c9) by AM0PR03CA0022.outlook.office365.com
 (2603:10a6:208:14::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 14:40:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF000001AA.mail.protection.outlook.com (10.167.16.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 14:40:31 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:42 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:30 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 00/16] Led update for STMicrolectronics boards
Date: Wed, 12 Nov 2025 15:40:17 +0100
Message-ID: <20251112-upstream_update_led_nodes-v1-0-f6c77739113c@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFKcFGkC/42NQQqDMBBFryKzbmRGq9SuvEcRCclYA9VIJkqLe
 PemnqDL9+C/v4NwcCxwz3YIvDlxfk5AlwzMqOcnK2cTQ4FFRUSFWheJgfXUr4vVkfsX2372lkW
 VyDejywapJkj7JfDg3mf70SUenUQfPufVRj/7T3UjhepKTWUq1HWN2A5eJJeYGz9BdxzHFxH+5
 HbEAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AA:EE_|GVXPR10MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ed16d7-ec06-4df9-0573-08de21f96e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHBLbkwxTnRwSmFOVDRJNW04aG1DVjU2dDZ6Slc2d21DNjJteVFzYTJablBQ?=
 =?utf-8?B?dGR4V2dKYVp1dVhlMnVIcWRVenZRMFdvOGI2WnpvWVhFTXc3WGVlSzBlNnBK?=
 =?utf-8?B?ZXd3dFNtMWpZTkR6czhXQ3hIR01wb0pyYVRPbm9TSlM5M2pwOEFMSkMycTEy?=
 =?utf-8?B?V0haeCsxbDNoNmE1N28wY2p2TVhYQUtkd2wyN2V3LytmM3kvRUNBT0JQbUVm?=
 =?utf-8?B?ck8rYkdWTS9XdzJlYzhCMGV1WGpiK2N0Z2sySVNXQ1ZHM0w4M28zZUtwSGFK?=
 =?utf-8?B?V2VrNUdiY0xSUmVJajNYaXBDN3d6dnlKdnZ6Ti85bDRZU01pTGxJWC92YTlW?=
 =?utf-8?B?N2MvTTFta2c3SlVHTVVXUFk1dFZ0TmczS2tTNWVUL3U0L2J2TVJHVWJablFP?=
 =?utf-8?B?UHBOVjlIbllxcGRmMVk3T3VxdFc5Z0JmOU9ISTB5TzNLQnp4VW9lVHhyQnEr?=
 =?utf-8?B?TlJ0dUF4MEdnaWJjaTN1bXZuNUNFaHFmWkp5eWFtWWlHakN1Rk9ONzlJQ1Zq?=
 =?utf-8?B?dWc3QzJkSEVGVEFmM0ovelNBYmVsTUpWMTkvK2JiRW82YTRVZTFYMWV0aHRo?=
 =?utf-8?B?NWwrK0VybkdSc2pyNkw4WGtzNFp3eTF0S0VId01rQXdvY0UwbWRqWG8zZndV?=
 =?utf-8?B?U2xBOFBlU2ZRdDYvSi9ZMDRRRlE0YS9wWjdqMGp1UUlYS2ltNmI1c2NSYjhD?=
 =?utf-8?B?WnA2Rm1lTmFGRVJhWkRhc2YzQmdlQXovOUd1VncvRVJvdXlZb1FxZmlrUi9L?=
 =?utf-8?B?YThMcVp5Y1djZzYySFhhZFVtYWE4WU5TOFNYWDdkeHBYajcvMklJcW5USC8r?=
 =?utf-8?B?eUI1SUNERGtBNDB4MUpseklnV1hwRkV4MnNsaFpac3RXeG40OS9FT3Bmd0Vo?=
 =?utf-8?B?Y3NPVFhEa0dCUWgxR0VvWFZqQXFHVksrdkJtcHlhemtJaDErZ3Jib290TXRq?=
 =?utf-8?B?L1poeXpxdmwrNUs4WE5tZ3ZCT05tbjRoUXF3bU1NM3I2V1Izd2tLbmMyOXhp?=
 =?utf-8?B?eENwSHY5bUNGNjg0d2t1bGN4N2t6M0dEcm13RmhTV1NnMDJxYlkvU2lBTHlI?=
 =?utf-8?B?VGJHSGs4SHU5dTJpWVZMdi9mTy9XRDBSTi82VnNYQ2Y0ZXB6dlc1YXQyN0Nl?=
 =?utf-8?B?L0ZIeDF0WUtxRitGbk93aG05bG1kRk1ETG5jWHcxVDZTYkxHdk1tVEJXVUQ4?=
 =?utf-8?B?NnRmUHcwQWxEUElYMkdiSHFDR0tqU09UUjQzbEZkZnlaYVVteWxNQ3dzOHJv?=
 =?utf-8?B?WVJUSE1iQjIrdGdlazhHNTE2eldyNkRaZ3dIdUpvNm1aeGYrdnRIR3J3MjU2?=
 =?utf-8?B?VXhUZkVCNXJvR1VOa2Jmb044VjEvR0p0QXpyOGFRbUN2bS9nZjlPR1JNRjF0?=
 =?utf-8?B?di8yUDBMQklvZDFyY0daaHdMSnpVa2xCM0dQM3k4aWJ4OE1wWDlLRXFIeWtR?=
 =?utf-8?B?ZE5IYUhzRzI5ZGlnNDgrRkJ4Z0FQVVlaNDBRQWV4bEYzOCtTeUxVVGNkT2VG?=
 =?utf-8?B?SHdwdG01OTkzaVdUbU5ERlNBd3JidEJOMVJUWS9CNi8yWVBaUUJUWGRrR1ly?=
 =?utf-8?B?VS9ybXI1Sk90dStuTmRzNFh0eG1Rb2NtWkJuLzBrV29xNGFEM1JEeVlpVjVL?=
 =?utf-8?B?QnZkK2FqUlJRZ0J4ZG1KemNKc0IwZWVLbmx0dzROcmQ0WEhJeTl3dEtFbWl5?=
 =?utf-8?B?WmhVNmgrYXZrY3pNckRCWXdFSzU5NGhHaGEzRWdQallpNTErb1dMU04yNWJR?=
 =?utf-8?B?WlBGbGNpODF1VzFwMUFxYmt4c0IyRGtJZjUwcXN1Z25sSGdYeFl5ZlVWT1NZ?=
 =?utf-8?B?MXNEcXZWa2xLY0UvTFB0TEl3U2FCYk15TWlhRWNDeEJQTGdlRVF6TTFLRzky?=
 =?utf-8?B?NVdQSVA1OE9CM0l5cVhBSmhmZU16QldiSi9Lc09ydUE1OVVvMXM2L3p1SGNz?=
 =?utf-8?B?STRXTUMxU09KMUR5cTJWejhxVEtMY1FKTGlPM2FYNTVlb0dJNEdhNzd5cTM4?=
 =?utf-8?B?UVlhbVM1aXgvb05GN2Z1SURrL1RtN2NPRUR4QkFJY2FrVzBOTlpXUitoSnk4?=
 =?utf-8?B?RjhETzNTK0ZKK01odVFoclU3UGZKNjZpSnJIc3g5TERaRHhzN3pQUVRNbnR2?=
 =?utf-8?Q?U0MY=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:40:31.5421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ed16d7-ec06-4df9-0573-08de21f96e6b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5935
X-Proofpoint-GUID: hNjJmBhdIOTYrWLQT9zIrQnD5DkbtAFK
X-Authority-Analysis: v=2.4 cv=LaQxKzfi c=1 sm=1 tr=0 ts=69149c63 cx=c_pps
 a=2LjHdM9d3nU5CJ51ne9XDg==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=WigURcRRZJDv32fA7DQA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: hNjJmBhdIOTYrWLQT9zIrQnD5DkbtAFK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOCBTYWx0ZWRfX8LMLiB4F5i8G
 QWQgiG/W+oKNB91ntazJVhsvUMLx6op9F+hRKtzWJcipQOZErWH19zSfXd6fzNEZdtRPQ8PBxAi
 CO7I8VZAMcsDKqz3YqDA8oyz+RPmMUIIpknvNnLIHU64J/CmOqf7J+eMH0aArUKJm2PvV3N/krq
 QaCnbeR5vvKCYREiQMWnF34//MpFsahUFKBXOyfTWXJe85xwjLEj2eGFBcXzb2dFnOoZ9Jc95Kb
 BBJPDwTlQX2Zhso9yUdb+nXc+WV1NMVNJnpX7ptpngyFaLAEKhbWOU9ftxKZqFGPvopcemTEBJc
 3uR4zf8x3tzmY0XhG/KRx2eyobjPssZ6zOl9rSAx90fAIr1ZFlvmj7DH7eFAStZlDn6nXR4UDEN
 gNJzpAjCeWVsPp4ZXe79aD/y4+KDsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120118

This series adds/updates LED nodes for STMicroelectronics boards by
adding new LED nodes and function/color properties.

On STM32 MCUs boards (F4/F7 and H7 series) green LED is
used as heartbeat.

On STM32MP1/2, blue LED is used as heartbeat.

On STM32MP1, red LED is used as status LED.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Patrice Chotard (16):
      ARM: dts: stm32: reorder nodes for stm32429i-eval
      ARM: dts: stm32: Update LED nodes for stm32429i-eval
      ARM: dts: stm32: Update LED nodes for stm32f429-disco
      ARM: dts: stm32: Update LED nodes for stm32f469-disco
      ARM: dts: stm32: Update LED node for stm32f746-disco
      ARM: dts: stm32: Update LED nodes for stm32f769-disco
      ARM: dts: stm32: Update LED nodes for stm32746g-eval
      ARM: dts: stm32: Add LED support for stm32h743i-disco
      ARM: dts: stm32: Add LED support for stm32h743i-eval
      ARM: dts: stm32: Update LED nodes for stm32h747i-disco
      ARM: dts: stm32: Add red LED for stm32mp135f-dk board
      ARM: dts: stm32: Add red LED for stm32mp157c-ed1 board
      ARM: dts: stm32: Update LED node for stm32mp15xx-dkx board
      arm64: dts: st: Add green and orange LED for stm32mp235f-dk
      arm64: dts: st: Add green and orange LED for stm32mp257f-dk
      arm64: dts: st: Add green and orange LED for stm32mp235f-dk

 arch/arm/boot/dts/st/stm32429i-eval.dts    | 65 +++++++++++++++++-------------
 arch/arm/boot/dts/st/stm32746g-eval.dts    |  6 +++
 arch/arm/boot/dts/st/stm32f429-disco.dts   |  6 ++-
 arch/arm/boot/dts/st/stm32f469-disco.dts   |  6 +++
 arch/arm/boot/dts/st/stm32f746-disco.dts   |  3 ++
 arch/arm/boot/dts/st/stm32f769-disco.dts   |  5 +++
 arch/arm/boot/dts/st/stm32h743i-disco.dts  | 27 +++++++++++++
 arch/arm/boot/dts/st/stm32h743i-eval.dts   | 18 +++++++++
 arch/arm/boot/dts/st/stm32h747i-disco.dts  |  6 +++
 arch/arm/boot/dts/st/stm32mp135f-dk.dts    |  6 +++
 arch/arm/boot/dts/st/stm32mp157c-ed1.dts   |  6 +++
 arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi  | 10 ++++-
 arch/arm64/boot/dts/st/stm32mp235f-dk.dts  | 10 +++++
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts  | 10 +++++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 23 +++++++++++
 15 files changed, 176 insertions(+), 31 deletions(-)
---
base-commit: 53c18dc078bb6d9e9dfe2cc0671ab78588c44723
change-id: 20251112-upstream_update_led_nodes-30e8ca390161

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>


