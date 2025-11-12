Return-Path: <linux-kernel+bounces-897006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80322C51CC7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4989C3A9519
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE7D2FD7A7;
	Wed, 12 Nov 2025 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="FgOuBEjT"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770A02F9980;
	Wed, 12 Nov 2025 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944457; cv=fail; b=lm+rwl2WuMKpNlgc1dprZem652Y75v5GnPXmkqM874lGH4M/P/A8bWnqqwFPIy6F4SF2rTIYMRPa588oza9OqhheGmPcK4OyQoJNurOM33AEekZbFC1UyEUbw8wj4pJ0AKeU+8H54dHpIOLbNvRZqvGJ6eBU0Yw9uiy5DlcZAUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944457; c=relaxed/simple;
	bh=tpaEtGNWhQBp21K4jzISmMIqVTMDWlKW0w1XN8HnagQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=cP9BiGWQ16NgmuL+o30kgzXtJ6KdHmx3vKPEDjQY85oIiJX0K7KzXv+J72epygFUQ3UpYzgjPA0lVfvIw9LZRI9pMDGY2IaKXIkfYEpt/auoOcrBIYXKIegfc3GVBx31EXspahDy8davjS3Dwi4qXoCqWhp+etDq1jcqJoyTWTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=FgOuBEjT; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACAdejl531077;
	Wed, 12 Nov 2025 11:47:10 +0100
Received: from osppr02cu001.outbound.protection.outlook.com (mail-norwayeastazon11013052.outbound.protection.outlook.com [40.107.159.52])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acreu03p6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:47:10 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJKzlFOWIodMCJ37G6kjqpS4vfVV8iKyJ8xlhnaQfxhKa56z2t+++iFWLwx0Q3W7gFYWE05BJNXoiBULyyL4Gar2b1/rTq8dxjSe9F8kgyyBLGC+ppdx9eHN/DlVF/MEtnaDN2CLrA9iWYBM/8HmgwDGp4NJ5VayudberwPmb7c8nS83QqkeSf+PNzBDYGP6sydsulPNWgdzWzmDPA6rkJPbDdsh2NsXl5R+1Ka2YlWvH0oVjtHHDgJqzPlKCmuK+mPqKKPkpfyy69dcxMtrTINR3P3sl4Hu0N/GxEXU89cvOrESykMpomRqMVmX35ZwT00G+bHAo99O7fxd+wl2Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hfto6ldBbq6SssQFYFLJli8HNqlGHBesR7Ocmh9PvdU=;
 b=qF8E8fz2mvshgkAiXUx9oxcwaCUKZMidtZuCLYssxPNpwBaQbWThgtowX1rbFYV5LZTOCXM6+HgnVlD9meLuJtzkoH/jL6FZzQT9AhFGl1Ln1UN+a6f7C1WMnDmTy7T/TLAjh4SOWvAXJrF+aTebMPPRsmWGnLs/VwkW6wKQl6gzz5CcGOIsYUgvPbqLIJlIeymvaLNBPIikcHAUJoLE6TAxCh/gUZf1tB2z88v1VTvFtAhINnvT+PKgr1CgkSWpom94i7llUBbyds/0wLSn5lx7QDinJk9yPfVS6n/x0nf/Hfpw1fd5HR5/UQge2+rJ6C+m3r/HQ/TS+zhlfAf0qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hfto6ldBbq6SssQFYFLJli8HNqlGHBesR7Ocmh9PvdU=;
 b=FgOuBEjTXKmwBEy2HBc53XOdtPa+sTB+jObYaKkcFjb7KOLdzyEt/Sxs1q3Cz1NkVHqF1tr2LIBF1im825hmlmvjFuKiRqzllDzLW3r9A2rHOtYoL/QBVgfQnP4hJBUxsTR4jyLv4zD2VVYmTQr2+SOwJnlymBuSVcSzgF1FhL6co7GWpgy3N6S4XNbr4Z0ayBfvucWtxQN23cx9YBOeIFCVu8VFCsDSsBjTiGJ/8Z6LsEQqz/Etc+1IFu6O2GZH6xyjFNKbHoQlYmP32nhsMOHxt4yGNs+5ciD+qg02QMqC9tZ3GDBFDeXZHDTfFaPmGow80SE855QtkZ1rq5q8WA==
Received: from CWLP265CA0503.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::9)
 by AS2PR10MB6542.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 10:47:05 +0000
Received: from AM3PEPF00009BA0.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::6) by CWLP265CA0503.outlook.office365.com
 (2603:10a6:400:18b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 10:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM3PEPF00009BA0.mail.protection.outlook.com (10.167.16.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 10:47:05 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 11:47:13 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 11:47:04 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 0/6] Add boot phase tags for STMicroelectronics boards
Date: Wed, 12 Nov 2025 11:46:42 +0100
Message-ID: <20251112-upstream_uboot_properties-v1-0-0b19133710e3@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJJlFGkC/x3MMQqAMAxA0atIZgtNUBCvIiJWo2bQlrSKIN7d4
 viG/x+IrMIR2uIB5Uui+CMDywKmbTxWNjJnA1mqEZHMGWJSHvfhdN6nIagPrCkvDFHVWGdd5XC
 C3AflRe7/3fXv+wFQ3U+OawAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA0:EE_|AS2PR10MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: ce15b6d5-88a1-4597-48a5-08de21d8d1f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1gyb1R5bDl4TlBHb0F5cyszclh1QWlnVWdCbkhUT2RhV2E2TEdtTlkrRjJs?=
 =?utf-8?B?NlhORXZDR2lIOE9EY2hOWDZQaWlvUHRDSEZ6OEdzaWJENkplNkZpUVl2TFQw?=
 =?utf-8?B?dUZEeDZSS3FVT2tnK3ZhejJVRjRkdURDanBsYis0a1JqVXBZdXhGZEx2aDVP?=
 =?utf-8?B?NnMwbzZyNjVhOFIrYkY3M0c0R09SNVlPNlc3Y2Z0bW4xQ0EvMjg0VFpUQStw?=
 =?utf-8?B?Um84Ylc0RUYxNUFmYTBQNEc3VHRzNURnUnhQaDFBTGh6ZmkzNnZMaUFqZ2x2?=
 =?utf-8?B?OWt6MFZvdGVMYTA1WGhGazFoVzVsRXRNMk5oTG90YUlqYndNakdYNW9TdXBN?=
 =?utf-8?B?c3A5VStKNTkraGhVZFYwUXJhbzROSWFZQXZSN2JPcS9xTDlldytpVXJNNTk4?=
 =?utf-8?B?SGlvRC9GSmFNSDlWanRhV0lHckJtUCt5OXZCdkpRZDgwYU5acVZsVzBIL1N5?=
 =?utf-8?B?WWNDeEVuUlZxUmR3U3dxSm5RT3FrWXgzK1lvOE5Md2plZTBWbE9ra1FGRXFP?=
 =?utf-8?B?WjNnNjRyQ2hvU3FSL3IyWXZaN1kyTkdCNFJZb3U0SXB2ck5NSWt0ODZDSTBx?=
 =?utf-8?B?dU02dmVFTmpSbUJjTkpuSUVXdUFsRDlPR3dtVkFoTmNSZjVVRHpETkx4SkFD?=
 =?utf-8?B?TEkrYS9vU1lQSmZLRWNlaEMwcDR4L1B4QUQ5UTVkTVVkNWFWSmFLNHl4OGNs?=
 =?utf-8?B?NzNRRGl5YmoxcjRWK1JHQjczQzNDQXo1Rk5DTTg1eitWNU5yYVByVzJXWGor?=
 =?utf-8?B?WWlEVDh3RXJPM0ZKQWx4bFppQThQcmI5WE1tZitTWlh1Z0pNdTF4OEc0OFVE?=
 =?utf-8?B?N2xhVUE0OUF4UjVGTnNrOUozeUpQWjE3Q2N6OStVcnJHcEZwSWZzbTlGZlpG?=
 =?utf-8?B?SEJJNExiNkw5NStuZFdIMlh4SXZzekRHSUJ2aEhzcDdSVG9nTDE5WEl4b21G?=
 =?utf-8?B?M2ZDMlhNcVNBaloxUzB3MEtKOTNlWVJlZXRnYS9LZStoYjJSeUM2Yk1RRmp4?=
 =?utf-8?B?Z3dWN1NlL29paVJPM2g4S29MdXpiT0NWbGNFQ1NSZGZUL3I0VTlnUEx2Q1kr?=
 =?utf-8?B?aG4wYmdSWGRLVG9ERDRPM3RKNyt6TTdiSkswTTNZR245aDZKTnVxd0V0bE01?=
 =?utf-8?B?aWc1MHByTklBUUZMYVVGa044ZTh2WUMxaCt0Y04xbU5xOTRFeDFCQS9BMXJG?=
 =?utf-8?B?OUhaY0V6RTVMY3o4dUNaOEhXblp0T0dCQWFMaHpmQ2JYbG1PdDZBT1RUWE5p?=
 =?utf-8?B?YXkxRUVSSTU3bVBJelRrNHR3bDF3ekxXTmZyZW9ZQzV3L3A4V21WWEZYL2w2?=
 =?utf-8?B?TG5nSHVjUUZQOGlKUDBNK2twbnM4Z3F2aGR2N2lta3dHbEtYK0ZISEJxSVZU?=
 =?utf-8?B?UmhZdHNOWmltOGw2Ylh3b2xRTHlYTXRZWWdZcnNnSnZ1c2Z4ZWc2Rk5ZQVdO?=
 =?utf-8?B?VjNPT3JjVU52YXZXaGhSNmp6aFE3cXh5RElVdFduV25Xbmc0QXlUTmRsa0ZX?=
 =?utf-8?B?Ni95N2o2KzhTc25rand1UDhpdm1aYzFucUlhdDVlQUdLODgvSkcxQ1VOQUNu?=
 =?utf-8?B?QWU2cld6ZmJTN0RLMmVEc0pFTFo0VVgxc3cwZ1BLaGNJbmRzOW9zYld4K2h4?=
 =?utf-8?B?RllPOG1qUTNBVTJOVGVaZ3dsUzJlbUdQWE0rS2ZRWHQ1SmpNT0xIZUpIM0JE?=
 =?utf-8?B?ZlNDYWc3b1Q4bE1aNWlhWDU2elNYblVhUzhrRVB6cXYraHlPVEJDMWtVdGVE?=
 =?utf-8?B?Z0N3SG9WTG82SmpJWVlZek12OFNCK29ReGtON2FybmF2SmpITHFQa2l4ZVFT?=
 =?utf-8?B?OTJNY29pNVhOWW5USUFzQmxaRHlCcjJWZ1ZETkhGc00vamUrb1VyUERYcmdQ?=
 =?utf-8?B?ZGdSWk9TLytBa1U5NTNkZnBacjdQV0N4eXgvQjM1WVRJU2lWRGNWdVZybjNR?=
 =?utf-8?B?U3FQWVhVTk9NZXFpTUE3UEJ4RXJ1WjRWeUI3K2ROK25mc0hiTis4VnZpM2NG?=
 =?utf-8?B?eUxBUkRIelNySGhDcVlZdHJrdG5PTlJVb3VHN0s5MnBhS2NHdzJHYmtxVlIv?=
 =?utf-8?B?MHBmTkluZE95TDU2NEh2RS9xRnJmL0ROMStFZWJ1bkNaNGliMHVqT2lQYVNs?=
 =?utf-8?Q?GmRY=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 10:47:05.1380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce15b6d5-88a1-4597-48a5-08de21d8d1f3
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6542
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA4NiBTYWx0ZWRfX58XZO8Hd7IC0
 oHvjGREjlYtfQrdDgQG8TsGZgMzNDKEJgCMoSvrwIyRQiOLEmdDMgA871EzSPbvg+T/+uog/lkx
 iRQ2elyUgm/t3AULSieqEgRTSXD4mVbbxMTUS5dleHjW3BoyMxIAqG3kOC53PJ5ia+eLWechdhe
 yJdC+/SrdTgIyVfUIhNpHunYrtKgimW8U1tR0v9p6nh6Yepm2/zyXneaPxbbrgOkmrG9SzYA0CD
 3JItMXW+jmFB4QnoWiHARQxSaksxZAriZiyFOwdFKfkzn36vo9H/GtiM5VwEwyY/5OxQoIgEnvG
 Dtz9eb6IRnzUG8kN5CDb+RvGImowW1lMbHbxdjLdeW8OqQ34DidPk/Msxglt3UZXi5OJamoSEcf
 c8VNmHV79HMyWw8bP3yx3MFX01A43g==
X-Authority-Analysis: v=2.4 cv=D+hK6/Rj c=1 sm=1 tr=0 ts=691465ae cx=c_pps
 a=1plMItIg/2aKyTZzCDpi9Q==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=tf5JQrcXl1QFNXzbJ9IA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: brWYArT7KXuNeZ3whiqxFem8Xq2dE9u-
X-Proofpoint-GUID: brWYArT7KXuNeZ3whiqxFem8Xq2dE9u-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120086

The bootph-all flag was introduced in dt-schema
(dtschema/schemas/bootph.yaml) to define node usage across
different boot phases.
    
To ensure SD boot, timer, gpio, syscfg, clock and uart nodes need to be
present in all boot stages, so add missing bootph-all phase flag
to these nodes to support SD boot.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Patrice Chotard (6):
      ARM: dts: stm32: Add boot phase tags for STMicroelectronics f4 boards
      ARM: dts: stm32: Add boot phase tags for STMicroelectronics f7 boards
      ARM: dts: stm32: Add boot phase tags for STMicroelectronics h7 boards
      ARM: dts: stm32: Add boot phase tags for STMicroelectronics mp13 boards
      ARM: dts: stm32: Add boot phase tags for STMicroelectronics mp15 boards
      arm64: dts: st: Add boot phase tags for STMicroelectronics mp2 boards

 arch/arm/boot/dts/st/stm32429i-eval.dts       | 11 +++++
 arch/arm/boot/dts/st/stm32746g-eval.dts       | 10 +++++
 arch/arm/boot/dts/st/stm32f4-pinctrl.dtsi     | 12 ++++++
 arch/arm/boot/dts/st/stm32f429-disco.dts      | 11 +++++
 arch/arm/boot/dts/st/stm32f429.dtsi           |  9 ++++
 arch/arm/boot/dts/st/stm32f469-disco.dts      | 12 ++++++
 arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi     | 11 +++++
 arch/arm/boot/dts/st/stm32f746-disco.dts      | 12 ++++++
 arch/arm/boot/dts/st/stm32f746.dtsi           |  5 +++
 arch/arm/boot/dts/st/stm32f769-disco.dts      | 12 ++++++
 arch/arm/boot/dts/st/stm32h743.dtsi           | 19 +++++++++
 arch/arm/boot/dts/st/stm32mp131.dtsi          | 21 ++++++++++
 arch/arm/boot/dts/st/stm32mp135f-dk.dts       | 11 +++++
 arch/arm/boot/dts/st/stm32mp15-scmi.dtsi      | 26 ++++++++++++
 arch/arm/boot/dts/st/stm32mp151.dtsi          | 29 +++++++++++++
 arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts | 14 +++++++
 arch/arm/boot/dts/st/stm32mp157a-dk1.dts      | 43 +++++++++++++++++++
 arch/arm/boot/dts/st/stm32mp157c-dk2.dts      | 43 +++++++++++++++++++
 arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts | 14 +++++++
 arch/arm/boot/dts/st/stm32mp157c-ed1.dts      | 60 +++++++++++++++++++++++++++
 arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts | 31 ++++++++++++++
 arch/arm/boot/dts/st/stm32mp157c-ev1.dts      | 36 ++++++++++++++++
 arch/arm64/boot/dts/st/stm32mp211.dtsi        |  7 ++++
 arch/arm64/boot/dts/st/stm32mp215f-dk.dts     |  1 +
 arch/arm64/boot/dts/st/stm32mp231.dtsi        | 22 ++++++++++
 arch/arm64/boot/dts/st/stm32mp235f-dk.dts     | 11 +++++
 arch/arm64/boot/dts/st/stm32mp251.dtsi        | 27 +++++++++++-
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts     | 11 +++++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    | 11 +++++
 29 files changed, 541 insertions(+), 1 deletion(-)
---
base-commit: 53c18dc078bb6d9e9dfe2cc0671ab78588c44723
change-id: 20251112-upstream_uboot_properties-22480b0b4b1c

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>


