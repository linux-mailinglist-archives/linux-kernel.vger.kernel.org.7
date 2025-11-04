Return-Path: <linux-kernel+bounces-884853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B62EC31523
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF123B0825
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2DD329E52;
	Tue,  4 Nov 2025 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="gLvSXXUe"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3733332938B;
	Tue,  4 Nov 2025 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264526; cv=fail; b=tkh8xkKh3ME1E3KMEYPpx/LlgyiEyKrsmYLwo+w0XXJCAXgMzKH1XVxrY/D+MjOE/GWI6Xr94T3IP853vN8qEXkAOgyt+GPX59577LzpUDJX+I4SMy5sz0NF9qjmv/JQX1Ti8LExI5mCMrFi10wMEh8sMUiCIWBm4909pj7NIzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264526; c=relaxed/simple;
	bh=V/U54QATzvh/g4/7sycmKUbOUPg54BHutLF+HF8IaSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eldhNW4ETfv0OSqvAdpjO8mPf+qjtBQqpHcx9vJr6iQ4JAeTMkyWk5btFoocOQx8Ap6Nb36FCdwajOXkrpqWxC9SCt+3V/5IZ2oy6LqMnJeCzF5+ThPUOPwzNv8fUbAWpdlnvoCS7AT7RMHazNKav4CdC12ADjTCxw1ccNeeFKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=gLvSXXUe; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4DnFlY350660;
	Tue, 4 Nov 2025 14:55:11 +0100
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11010006.outbound.protection.outlook.com [52.101.84.6])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a7g9n0vwr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 14:55:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1MeKJifc0NfMsBh7ul5/XnSWwXgAIbPw8eMkEt28WNmDrJuL1WoC5gVMtSTdmvFj8KwiTxbAWdKA098hHYaXahEWndhokga+bBPzxRHDQY/M0+SUNgtGbhYCKsxvklcyEp0cy+oIf4CbRRUMwLCxj62bbyXK+rdYA1Bjb11kxb6SQUpnsTOLQBoFpYfOWtfdDxulUEabsezCbbMkTEAoiaFLUMMIahTUrSue2d8Lu9fRFB4ZLVSpoToZSrzkkz+Qq8zDhBVX1JFSbhMOMNao4XCNGTlJPq587Zfo8fHJnRpI5+kGLH/80+WXcLo1eV74xvPfsggdt+O5Rj/zEsyzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dicJDKRmP0us/562QknHNC2P4K6uCwLeahACKtaXRcQ=;
 b=RKbD6fhqmLJgvrfdpOM6sPEu7nXRvGc+XTdaXez23cERx1pjahdDIX2aO+8HHfiYZnmc7Hwz0cWHcMrU4df4i+5PTW4jj5buWdPfr3PB61QodxPT1rF3Y3lzkdqgt0FWOW7vSWqjBhUgUauSzUIrpGZ8BLzPI3K/7QRvJCh620RFvIq9RduYDknQxvY5I6EMJKiWneSD/5R2SVrLKHxjwnakzKqCD/3pX66ddSfxx52A4Mwx+f3o9voUt/mzDd9trTk09dnhj4pNdUDjX2iI/lNpv+CaHkQbsL3t9Xp4PSSD2Q27ucgKnc6diGm58d68A576k8SDZA/PyOsJIJTp5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dicJDKRmP0us/562QknHNC2P4K6uCwLeahACKtaXRcQ=;
 b=gLvSXXUeF2yqjUImlC6fBt0LFgE8BCD4r6dedWcfMezW9sLj/RnQB8DIdgBoHsx2DFtXksuku3pG8p04M825e+zb/Yrjb6R39+25ckva/cLwVQljgSWJvnzjOhSibQlj5wbK4dui+EeMS0YrO4rZsz8MULANYL66mSxOIR+qQvLBt6CnbVsP0FzmRn/kLWbOomNlTVYtdcX2ZRE2HgswMrAea1Ze6F8AD7fsUQE9aEgHklfc5663tJWXmiO40J4pJ8wkDIrajIhL+gQ432bvOYodqJ3C1CR0FyPoAjRFrC9xIl77qbn1H/n/Qgcmi5Dx2R0FSc8QXs0di+HkssZjxA==
Received: from DUZPR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::18) by VE1PR10MB3837.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:164::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 13:55:09 +0000
Received: from DU2PEPF00028CFF.eurprd03.prod.outlook.com
 (2603:10a6:10:46b:cafe::43) by DUZPR01CA0029.outlook.office365.com
 (2603:10a6:10:46b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 13:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028CFF.mail.protection.outlook.com (10.167.242.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 4 Nov 2025 13:55:09 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 14:55:01 +0100
Received: from localhost (10.48.87.185) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 4 Nov
 2025 14:54:28 +0100
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Tue, 4 Nov 2025 14:54:10 +0100
Subject: [PATCH 1/3] dt-bindings: bus: add stm32mp21 RIFSC compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251104-rifsc_debugfs-v1-1-7ebdfbf8d33f@foss.st.com>
References: <20251104-rifsc_debugfs-v1-0-7ebdfbf8d33f@foss.st.com>
In-Reply-To: <20251104-rifsc_debugfs-v1-0-7ebdfbf8d33f@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFF:EE_|VE1PR10MB3837:EE_
X-MS-Office365-Filtering-Correlation-Id: a977fc53-eb4d-428a-48f3-08de1ba9c49b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?by9pVFgzOGhrbXQxME40Nk9wdFVXU25DZXlqcWV1cWp0ZW1EOWpNcWd0Wis1?=
 =?utf-8?B?d0xKZjJOR05VUCtEOGhsK3hrRkFKalIzSWg4dnZQNjJpOHdHbFcxbWlTWTlG?=
 =?utf-8?B?cUFNRmVEd0ZQaHZvMG0vYmNBRnFyWXlUeWZEL1YremtzZElBa0NYQlgwcUly?=
 =?utf-8?B?OWR2TnREQ3lCM2FzbDF6YmtNWlhiZHc1SDNEWUVwNzRyV09oVjBnQytDUnpP?=
 =?utf-8?B?VU9mSGxKMWprYlFRSktobU0yZHpNbm1hb0I2U1dJWGp5VFZmNTZrSkQvRDZW?=
 =?utf-8?B?bGlDNW11QjY4aVNFN1RGZWtOWG8xcHljN1JiUFdZR0QwdjhUa2FPeEk1T0Fv?=
 =?utf-8?B?YncrcVIvREUrWG9HTUQwMCtQQmxweE04K3dkYTBneWpqTnRmUHd4N0FXYkxw?=
 =?utf-8?B?S1Q1TC9LQjRLai9CVU13bTVQM0tyc2lkRmlUS3BVMmNwaStqUC9vemZYaVB3?=
 =?utf-8?B?OFViWmRqR240VXQraVVlSHJJakJqSTY1TWNrVlBoamdjTFhpS1p0MndxdTl3?=
 =?utf-8?B?ektYeUphbTJaZGQ3ZmpxcUc3Y0dZZDViV0hUaEdBWk1DeFFad3QzRU9YUUdi?=
 =?utf-8?B?TFFzWm1aY1NDOURGdXQ5RTBRa0w5bUo4eUJkL1hqT0NhUXZ0ekVrbW9PQmdt?=
 =?utf-8?B?ZVlLQmRMeEZKdHZ1SmJNOGFpZzd5ZngvVlJsenV5UUNmdVo2VEE4UG9uUjhC?=
 =?utf-8?B?djBVMjhzM1lQQ1BuVm9oaC9OanZnSlVGS3FPeGtZdFp5Y3I1L3FGcGJPc1JF?=
 =?utf-8?B?cU12OGF2S2NzR0pVN0NqSFNrR0FxM1R5UHpRWVZWNlYyZmM3R1ZxWGJ3QnhJ?=
 =?utf-8?B?UkVKY2dseDM1NzZ4QlpyME92cDIzcUNCNmR0L25VYlVRNFh2d05CTHV3VUFs?=
 =?utf-8?B?M01Bb2xqS2JGdi9ldGNmWGJnYjNUWkFQR0laZmc1dWt5b25rRG1KK2UwVjUx?=
 =?utf-8?B?VzdjS0lNdldWQ1Bsd0JSUDkwWDJydU5hTWNER0hwVk15dGxjMUdaVFhQM3lV?=
 =?utf-8?B?UDh0amlEUHF4R002TGo2Q09OQlgvZDRwNkFhUWNCNVRMdnd2Y2p5S3Y1NnEy?=
 =?utf-8?B?S0hpdlJJcE5RTHlpOW5HbjNpSnUxV1cyMGQ5M0x1YnQwVXVOK2I4Y2ZuNG12?=
 =?utf-8?B?Y3pOV1dGVWZyMzNxeGQrMFFEMXR0TkpvOGNDYVdhQ3J6NEw4MVZQR3Vzb0xB?=
 =?utf-8?B?dkkrQ2dXNTRwVDcxQ3d3NmVZTi96WEMwYVhBZ3hSaklGWHZ3WXhVVkY1ZFV5?=
 =?utf-8?B?UjhWc2ZsSUR6enVkaC9jZ2g5clQ2WUJvdnlFUDZsa21vZmVlY3psNEN4NXZW?=
 =?utf-8?B?RnhnNTJEcnJxMHYzWCtkd0RJUDFFeU1mYjdkcWh1bkxaVHNoVmhrR25MNUs5?=
 =?utf-8?B?RXcybFQvRDBETTNJSzNnTGpDV0F1ZFRSb0FDU0pmN0c2TjJkYWRWVHU2ekhh?=
 =?utf-8?B?QTBaUlhWVGNxY3hzUzZ2cHZtbkZERTlRelAwb01hOUx5b0FWSmwzN1k3cW5x?=
 =?utf-8?B?cFVUQ2MrcjlrZmVwSk9PdU9WRmtuL3B2dEtiWWhjVGJIYlNJQlBwTzBTcC96?=
 =?utf-8?B?U3JzSDU2NVB3cmsyWTFIV21MeWlHNGZHZXhmMHBOR3g0eDlFUFRVeXhCUG1n?=
 =?utf-8?B?eUg5K05RNWpuTE8zZ2dGYXRCNzdLL2QvQzFCend1Wm94SXN5MldVd1RoNzYw?=
 =?utf-8?B?L0pRWWk1S2UwcXFFVWdlVDlaa2VkK0poVkxVV0hBMERRNTV6dVFkVmJIQVpP?=
 =?utf-8?B?dThlTFhZVkVDM29tSkVzOVVKR0tXZEliVTBBbWYra1RNU09LdnhSSGJJSXJB?=
 =?utf-8?B?V0JLRXEva3RHc3RtQk9FT3ByaXBWbTB5RmhrVTh3RTlJNWczVjBWOXdwMTJE?=
 =?utf-8?B?VlBva29qd0dRbklKNUZKQmtJc2dvbnZUMkhvYVIwOFgwczVlb1pnMXNydWpB?=
 =?utf-8?B?aW5hN085bmZURThvSmYwRFpocXVYUit5UXljZzlVKzdNYnFGUGRDdG5lZDB6?=
 =?utf-8?B?UmhDSlc2TmVUNDNqWGF3QjBHR1BmZWFTd1ZENFpEcmFVQTNSc3dvdDd1K2dR?=
 =?utf-8?B?SGFWKzYySzIxNGdKbkdYRENMZW42UkdtOE4wbUVUenI5eEVPUDFiVWZGZ1li?=
 =?utf-8?Q?D7fo=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 13:55:09.3946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a977fc53-eb4d-428a-48f3-08de1ba9c49b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3837
X-Authority-Analysis: v=2.4 cv=WL9yn3sR c=1 sm=1 tr=0 ts=690a05bf cx=c_pps
 a=65o2Amv0Ue3sVzSEE8tp/Q==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Wpbxt3t0qq0A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=Od9f8wzskGMPMKVYy8oA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: wU5Q8Cv0x-FXnaH8yY2bLH7goA54HA4A
X-Proofpoint-ORIG-GUID: wU5Q8Cv0x-FXnaH8yY2bLH7goA54HA4A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDExNiBTYWx0ZWRfX+ex8dm/Wr65Z
 km1iExlin7HqsKuiYrtB5FKChmEi48xxpmlFvhFgMREIANgmLG7vIT4n86rnWErpFThBlcgAFuk
 3/EqoCLKjUGuw1ncM5Zf9K9wteYr7QsgECgGY4avAkkSG6j74DMFDU8TU7xgQy/pYkD8+aPcaVp
 eywMY+yU+oQCAPaJrn0Ebql/yKFya5d4o44JM27XxAWcjR9UD3MgUEPuLa/reHy2tOpbX98RT3w
 IiGKxic3bFtMxXzygFXrIAxj4/WwQawAfZtMPc8HkTqzPTWaRZISAWGS03VMzeSQhDPBw+S+KqZ
 T75U/3uRcQQDkaJwmswa78F5ItWHvFQn3MoUSZXwj0aq+qc8BVPV4LC46mtGP4IFFQnLIpU1hUa
 TUrPj0Y0jC9sm+HyYWShsxUwJ0LJOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040116

The STM32MP21x platforms have a slightly different RIFSC. While its
core functionalities are similar, the wiring is not the same. Hence,
declare a new compatible.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 Documentation/devicetree/bindings/bus/st,stm32mp25-rifsc.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/st,stm32mp25-rifsc.yaml b/Documentation/devicetree/bindings/bus/st,stm32mp25-rifsc.yaml
index 20acd1a6b173..3952c99cac6b 100644
--- a/Documentation/devicetree/bindings/bus/st,stm32mp25-rifsc.yaml
+++ b/Documentation/devicetree/bindings/bus/st,stm32mp25-rifsc.yaml
@@ -33,14 +33,18 @@ select:
   properties:
     compatible:
       contains:
-        const: st,stm32mp25-rifsc
+        enum:
+          - st,stm32mp21-rifsc
+          - st,stm32mp25-rifsc
   required:
     - compatible
 
 properties:
   compatible:
     items:
-      - const: st,stm32mp25-rifsc
+      - enum:
+          - st,stm32mp21-rifsc
+          - st,stm32mp25-rifsc
       - const: simple-bus
 
   reg:

-- 
2.43.0


