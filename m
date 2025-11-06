Return-Path: <linux-kernel+bounces-888093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77256C39D37
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A2D64F982D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E3530C62A;
	Thu,  6 Nov 2025 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="PIPGM/qC"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44465286D55;
	Thu,  6 Nov 2025 09:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762421565; cv=fail; b=XyN1fsArnPECa4fHwC3kETX2GsUsIITh22WKRHVjv/TexDBcY9CpHkuZvm6b2039mNtFk9EqhFZ0orRZEZO2OH3B6va4HMVKXr+meMbWW/7Y1uUNCP4mIbL49bIKm3kzSgOaIajB+AtCO/78Ryr1g0SwXSuMrld9FPpdKx5KHWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762421565; c=relaxed/simple;
	bh=J5gn1c1YJCnEr8s8+vDrFb51OmO3v4odHS8UWj/AM0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=j5PJePO7xe0rZ+z/FkWFi5OUxr9whXMAbp61EJM2LJ+d4dHHzbeOzAoHe00jXG9YRPbmXR1XHmXzKLJNBdQIJWNWooEUZsbsUX17+LUcwd983+xGTYJDii+AzvpaFdpXL52z9vfzJo4jAu0uH7FTJbi/P3vc756+dlgaiOLkk50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=PIPGM/qC; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A69KMmL1382487;
	Thu, 6 Nov 2025 10:32:31 +0100
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11013056.outbound.protection.outlook.com [40.107.162.56])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a7g98br1n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 10:32:31 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lp/tMmJDkwixFAWuxtW8TaXrq/oZGzPiWF6asA8FEcGdM398KsJnxcEKEaivvuNHnMZBFcOAr2mYCpzw+8MZyc5LcbA3mVgKtTw4oAitnnm1Cxpwzm4gCV+5PDNuOZX9KDk6fUbnrksOr/2PzjZe/bopzBY5dpu2PWrtYuY5UvYHntNcaX5sFEtraHTOKewxW3tOe7dRRgP5AKJVtOuu2kx7ezCYS+qSRkPwTl3oe87ahvpCPwj95a6nb5oq5+xCiGY2NxsdeRu2JG/cgefTYXDPEILAj3IigGemxC0cLA3JTNruDviaxrVzdhpR/cEZyUE38nJZ2HfyR41HqdnaLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BO0JNAmNGRkNmjqd9C2xk6cBARTw892mhAx4MhH4KAc=;
 b=rjSlNbqaCMvFQW3oMFxr8Z1YPtjqVxpDDXqUXUmBfLgBkASOkEI9OO/Di+dNXGPqbfmQswsvCO2aIVI78gUM2ydKpqset7T2ci8fKr4EHhcwATksD3CUm+4ZRGsmHY63MaNG4yYCbM4WH7V8rWFYSfv+SkL9kUI9jPjKzD6yfDGGv7LGCwUgFSU7mHbaDJVbEo5vGpf8D7glw5Ur+kSWIKvHKUgBwT4rFAP17EGo0apZv2T5uOrZbKEPF4fM1WH05SnAMFZfgpeh6UeJNjiqPFr/og1O+mPVQhi32nBJsyz97Q9Sp2vkUfRvywNquWa6xN0AMk62PvXsfXI0f3MWBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BO0JNAmNGRkNmjqd9C2xk6cBARTw892mhAx4MhH4KAc=;
 b=PIPGM/qCW8bf0Z59z5uBzxtAkdHhYTwRhQsOKO3cmnvLakg4m/Fk1O1bnHSB6rB74Pok63W8PsNbWvSMbleMaIYnhOrwwjA4BmXim8EhRrApgq2UYRyYMQuZczOrV7ArtiXqsFIlMT3928LEZjB31k3vwuzfrKrG7Go9oGtCrIIkPIhGvcFbj+hCpxRDIRDeS6+fe71vhOjMao8BU5wTdWjS/+YVrxYjrNA/yCKAjyoDjhEWlAjeuSpBctmhuMScGcPvDf0piTOVzhjkCKfKI5DwMZFP3kwLo4hEPcWMaJqQA6/gRP05BABqqhgO9bsLkGVm0J1fOzhOcUBM2otv6g==
Received: from AS4P195CA0026.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::12)
 by VI1PR10MB8232.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 09:32:28 +0000
Received: from AMS1EPF0000004D.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d6:cafe::79) by AS4P195CA0026.outlook.office365.com
 (2603:10a6:20b:5d6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 09:32:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF0000004D.mail.protection.outlook.com (10.167.16.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 09:32:27 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 10:32:34 +0100
Received: from localhost (10.48.87.185) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 6 Nov
 2025 10:32:27 +0100
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Thu, 6 Nov 2025 10:31:49 +0100
Subject: [PATCH v2 2/3] arm64: dts: st: set RIFSC as an access controller
 on stm32mp21x platforms
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251106-rifsc_debugfs-v2-2-f90e94ae756d@foss.st.com>
References: <20251106-rifsc_debugfs-v2-0-f90e94ae756d@foss.st.com>
In-Reply-To: <20251106-rifsc_debugfs-v2-0-f90e94ae756d@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004D:EE_|VI1PR10MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 283b4aaa-2076-4bda-c7c9-08de1d1766b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDBUbDJXNDZ6b2dzQmZIYkVsUnUzd3lsOVZvMFd3WlZkblhleHduM2QrdHdS?=
 =?utf-8?B?ci9GVHBkNFRQOTJTRSszbVRHSFhkUjdQS3NEVGtOOVp6K1pyZk1uUDdySXp1?=
 =?utf-8?B?TFM3bWNlMHB2Y1dUUGVFWDJ4eEtiMVlrZzlGajJsS0RpVzBUVVc0UDFkb25W?=
 =?utf-8?B?K3R4MjZEQ0p3UDgyaW5vOVFPcFp0NjhQSnBzWUlZRTllNUlJTG1paTVOZlhQ?=
 =?utf-8?B?T0E3d1dMTFdTdzg5WFJXUVBzMCt0ZmpjaG9mS0doUWwvTk5zRHJwRHpEclBQ?=
 =?utf-8?B?RkhtaHUzb2wwUTM3dmNnanA5ZWhJME1mUGxVNks2UVgrcmRlcG1kbzdXRER0?=
 =?utf-8?B?bzNtTXlIb3F3VVQrKzVYeHJzTExWV1VEazNlenFHTi9naWRRTUx1bDJCRWxU?=
 =?utf-8?B?RkxJdGFmci9YRURpb252SDBhNHQ5VGdROTYrY0YvSEQvUWwwci9vRmlNcmUw?=
 =?utf-8?B?YnFQWHJtdTVnSFFyVnVyNS9RVkFaK2d0TjV3OVVXZExIMWFXSVBXb3c4WEts?=
 =?utf-8?B?NlN4UGlvcURzaEw5U3gzbUovbFFTNkdaS2Via2E3MytHQTRXU281SVJGZ0ov?=
 =?utf-8?B?VzVPQis0NzhoN05LZ0R0ZFZSdGFSWDVBKzhaNkxkckgvUXNsZ1JYZDRtVEJT?=
 =?utf-8?B?WXV3aHhxbXZjZXJzNU4zdDNRbFpCcE5MaFprQnpoMXlqVHhWckZ5V1BZZW1F?=
 =?utf-8?B?YXlXcFZEYTRUWUt3N1FsUDE1MmtNcTZKSGM4NWp6bU5wQVJ4bzZMYjBjWERO?=
 =?utf-8?B?Q01EL2FTVFI5VXNqRFZmRnd6UXBMb1BPbTFMQVhCMko2anIwcWNVNWVtK2Fh?=
 =?utf-8?B?MlpBOGxFQnF6aUU5eDlaV3VyVm1vblpKeUtqeEI2OHduMDJsZkFYSi9YZ3V4?=
 =?utf-8?B?cUJnYTNWZDc2SXhTTnRnRXgzZ3J0dEZTbGtRanZDenJXYmNvY2JGaFhzLzFs?=
 =?utf-8?B?cXNPTWhZQllITDIzSzROY1lLcGhMODVCemlSTnhqdWp5MjQxSklQY29GQm51?=
 =?utf-8?B?R0dudnYxeEk0Rm9RRzZkbHFOcWNGTGxDUHNLeFd3enp6WldyNUJxYnZ5ZWxl?=
 =?utf-8?B?bkVMUmZlMDVSL3AyM3YzMlU4b0V0TUZmbktVOGZ4b1g5QnkyWno1K2VOVVJH?=
 =?utf-8?B?SzI4cVBjNlc4ejVITExWLzdsYnQrczJwTmZuVW9qbVk1MDc2bUdHVDA5Z2h2?=
 =?utf-8?B?YVBHd0VYcmd4NlIrQmVJNGV1N2ZvdThjTytWbjlpU1BuYmJTbTFQLzk3bERS?=
 =?utf-8?B?bHpXTEE0bUJ6N1ZuYnh6clJqeDZkUDZwZ09QMnNBemQ1ajYwd2xqWnM3QUU1?=
 =?utf-8?B?TUFKSEtlVG0vV0FMM0sxOXFPMFpObkxPYTZxbVJaQkpBczN5ekhaR29aVzAr?=
 =?utf-8?B?eFRaVDdkL2o0Vk5tVGNVcnJzUTRlcVVyTUZJMTQvMDhLVldJM1RWY0xvUWZF?=
 =?utf-8?B?UVVOL2ZlTlM3dXhRcTNkVWFZU2hZc1h0T2RXYkNXYlpVMUtQL1BEMkR3UUNX?=
 =?utf-8?B?dGg0YXRYYmx3SkdOR2pxZ21IUzAwUkFGdHNYdGpwMEI2NVJZbC9ZMTdmdDBy?=
 =?utf-8?B?Rmk1Vk4raTFCeDhEZTIyRW02YzZ3Q1lpMlJFNk9qRnJabHc0VktBRnBmMXJX?=
 =?utf-8?B?cHFOZGxKYmtOYk1COVBqcnF3eEhnb3RCWHJrNkZVcXJGZnJ3cmU1Z1M4WW5v?=
 =?utf-8?B?eUpyWkJDMzRaeFFpY1NCWmRDeGs4d0dxZUFDelRScC9hTHE2a1Z6NWNSbTRD?=
 =?utf-8?B?bWU3Umx1ZG9peHFXMnlMNEk4MjZzWDFHQVNUV2F6Y1l0L2F3R1pMTFc2NW9B?=
 =?utf-8?B?WXRZcU51Q3F5cmxROWowUjR5WW81cHd4MllBUWZTRjBtYlNWbW50SHhBTFEw?=
 =?utf-8?B?SVUweE84cmk3Z1VIekY1ZzVFbDhLRmhzZWkyQ1RoUXFIZ3BUVWZxaFF2ZStK?=
 =?utf-8?B?QkFtWUFPWkljRGJrNTFHNVEwRThuOEc3QXFMZUo3WVdmeVEzT3JnWkNzbFJJ?=
 =?utf-8?B?TFg3WmZBMEg0Z1VEYzcyUExhUUtEU0U5WTVIaVYvcWMyUlZ4Q3pRbjFhVzdV?=
 =?utf-8?B?K3A3aDA0UUpsMXlPNkdmS0JHMnFUWjlkWUo3ZXYrMEVwL2EvK2d1RzlUSXM5?=
 =?utf-8?Q?Vat4=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 09:32:27.6760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 283b4aaa-2076-4bda-c7c9-08de1d1766b1
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8232
X-Authority-Analysis: v=2.4 cv=K+sv3iWI c=1 sm=1 tr=0 ts=690c6b2f cx=c_pps
 a=Mlku5byoIyj4Wp75YdBBDw==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Wpbxt3t0qq0A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=GThSmsW_2FqIp-Q6p0QA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: FZ40OLBveMmzv8YizF07WlvCVUpJJGbk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA3NiBTYWx0ZWRfX1HusUymFnHMO
 31TEfGBsZk20WfzyfZ6neMgR+nGSc6AX9qTyyYSs9MVlY0ULXWIcIuzKN5GT+6fxqQQ6IFxyXDd
 Sk2jRMqbKQs9tg7WLRvCN+eyXNP6b9fdS6i5vowVtx8a9IrjmfdyD3kxxatMgu6MQq70awZCtJU
 OwQ5507iWqwlOh+JhH01OZIJAogYN5xLDc/Y8UyZnwPEvfhX3NLOmbP5jwbG95mVLVAxHwaFlRE
 /Lid5q8PyxBE/3vgOMGjPL3cETL0THgjnh8Kz0DNRc0pFWxPW+ox98JlFEcIvm11fuqJPxO0XZ1
 ma1+EHNd+jNb3gA9cxkfOY5NqovuAM5gam14xIUPc/Xb9THPk+3QFO8AUrdfXqYVmSWfFllnkXx
 tRvLyHdF3NjgnczmIGYUrNKNOI1yeg==
X-Proofpoint-GUID: FZ40OLBveMmzv8YizF07WlvCVUpJJGbk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060076

Similarly to stm32mp23x/25x platforms, the RIFSC is a firewall
controller. Declare it as an access controller, keep the "simple-bus"
compatible in case CONFIG_STM32_FIREWALL is not set and update the
child nodes.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp211.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp211.dtsi b/arch/arm64/boot/dts/st/stm32mp211.dtsi
index bf888d60cd4f..cd078a16065e 100644
--- a/arch/arm64/boot/dts/st/stm32mp211.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp211.dtsi
@@ -94,18 +94,20 @@ soc@0 {
 		#size-cells = <2>;
 
 		rifsc: bus@42080000 {
-			compatible = "simple-bus";
+			compatible = "st,stm32mp21-rifsc", "simple-bus";
 			reg = <0x42080000 0x0 0x1000>;
 			ranges;
 			dma-ranges;
 			#address-cells = <1>;
 			#size-cells = <2>;
+			#access-controller-cells = <1>;
 
 			usart2: serial@400e0000 {
 				compatible = "st,stm32h7-uart";
 				reg = <0x400e0000 0x0 0x400>;
 				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&ck_flexgen_08>;
+				access-controllers = <&rifsc 32>;
 				status = "disabled";
 			};
 		};

-- 
2.43.0


