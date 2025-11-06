Return-Path: <linux-kernel+bounces-888094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487FEC39D4F
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10CF1A21CA2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2512DC772;
	Thu,  6 Nov 2025 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="WNK0LGAD"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16867286D55;
	Thu,  6 Nov 2025 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762421575; cv=fail; b=HEruKW0IrKOyg/KvazDn4avp4PpMSBbu8JMEYpQ1uUpB3hCSG4+Jb4jfuMNSCvAOxYtxCW9nxYjEMUVCVBUAIe+Bjd9xGyDuh+tMwoqYvuvpdoWbyQLta9xKQwuqB2h8wylK5h8FnI7vTkHmM1W6s3maTy/Y0Oq9CNxuNDTKX70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762421575; c=relaxed/simple;
	bh=iYcHOw7cu8cgKvw45fzo4U1UCvwMRtnr07YCvUTRGa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=iPiqM8eLXBtgZNosDGBfBqWq1DNLxqPpAtstCYTSL241tbg70kqP6ZPeaB6OU3vWVUZgLadlvLJCyA/Pt6eZUpARUH/vbL1USymRwNJuTOO0+YpUT/kBZu6om4etCBInV3bV8rXnZrSxoqYRPth8RcsCu2znEN5Y8zcZ7PmBzCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=WNK0LGAD; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A69Ji781339748;
	Thu, 6 Nov 2025 10:32:42 +0100
Received: from osppr02cu001.outbound.protection.outlook.com (mail-norwayeastazon11013064.outbound.protection.outlook.com [40.107.159.64])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a7g9nbpuh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 10:32:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tM3uA3flX82pcsGDCYtrSaUZIkBF5/BHJZOcj6+b0Fio856TyqVkeWMCePlouwdlthj9rHjX2T/g4Vefs+lUoXZy4ZTJgpw4UQGPrPy+WwMTGni4g12zdc8XPtCKZShs1TQOlD04BZQXrnZGqoNkybBjPyGB1/CjSkO6iw5ZxegZM57joTSaE8HoWv/hpuiS44FcLmQqDWSejRVbtX+5HHupq5VExder9yOzGrzd6CrHt4qjzIwkkpEQAwh6vFVnaXxZvCvt1LjHyi7eOewY+ku36aQYRBSozHJkWgSV9DQrp8uZXtNsWc6qD7EMyn1hKvUcdUnlHaKG88P10CZssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbUE7XDGw+5KX+MGTtKg0/SGLpuu8zvUo2T9nOyuX4M=;
 b=uP0e7lUqTmG+68tDW8/RqxaFw7ea6P53rwjWDGtwuxysI7yWnNHlWoDBdKW3yQMsy6HTTla1P5lHlZBp0cq62XhBSgnFk1+ekbBEAAGzfPr2nUsl8HutXkviEu4QuP2M0dOgCUuRSeR2/BfeFLQ3QPsHR/4yKdk9iHDPEMY67nFjNrt8+CFfrqW8AmoqLc3DkmivDCS3LiZFJMSFVPeQ5NjyOH8JBVE3ou6L7UArFknB3CNEdOf8U1sj4K9/riuC+5uAsK8q/5VlO8hc8C9E/nbFKX+C0Cb/TKS+ubafh2Ps6xGXdlE7pSgARUdg5//86nZ/Uzh0gidnvjxGhrzbnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbUE7XDGw+5KX+MGTtKg0/SGLpuu8zvUo2T9nOyuX4M=;
 b=WNK0LGADaf8CVk5F3WOqDsznmoW3jXV4nOd0VNg9ka1keOIIbgyWSykv3DrTadl+IGKX4ri19M/OYIxJ+nwwaVcoyI+njoFkSnnHb5xHiARFrp4lxwhTv2eWxA8lZLHU7fNGzHLPQZEeNzDfPJBNi3T9P3nivUaYgk+16LttN9zF6i/7lrEC+x53GabJczTNUQ8L0KJAWNh9/fpwsuD9jFD1S2xNQZ5Jdtr49amYUgDeL1p0Y0ROcbrdDWO1v0Lw/56reKRDlu/lPTMlkQbQAzERDC6NawFNXv/oOceN6GLoxxoVsl9Arj7FQDxTxQsfkG9tpE30+R3bf4g3ySwmzg==
Received: from AS4P195CA0032.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::6)
 by DB8PR10MB3276.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 09:32:39 +0000
Received: from AMS0EPF0000019E.eurprd05.prod.outlook.com
 (2603:10a6:20b:65a:cafe::ee) by AS4P195CA0032.outlook.office365.com
 (2603:10a6:20b:65a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 09:32:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF0000019E.mail.protection.outlook.com (10.167.16.250) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 09:32:38 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 10:32:42 +0100
Received: from localhost (10.48.87.185) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 6 Nov
 2025 10:32:37 +0100
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Thu, 6 Nov 2025 10:31:50 +0100
Subject: [PATCH v2 3/3] bus: rifsc: add debugfs entry to dump the firewall
 configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251106-rifsc_debugfs-v2-3-f90e94ae756d@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019E:EE_|DB8PR10MB3276:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c0dfe4-5198-418b-fd58-08de1d176d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGpKYUdsWTh6VnNIMmNVcENHdHMzR2xhd1ducTJHMWc2Wkc4VUFSUkIzeXQ2?=
 =?utf-8?B?bUFpY1NDUkttWU1VbVVJblNUQ3FoSFE2TjNOaWZuWVBsZmpUNEp0Y3J1ZExG?=
 =?utf-8?B?ckJKYzI0YzNUTWxHTUw5Q09pdWg4cUJ6QVZreTVNb3RaY2MvSktCSFd2eWtL?=
 =?utf-8?B?Z0RJZ3lZSThCNm5ReVl6U2YvbklqWFhhYmxZSWJ4Y21FVWk4eU1ib3E3MG05?=
 =?utf-8?B?U1pjdTlld2QvcEtqVCtPK2NiTmJmTzY4UCtCOXlXdDlwWlZoMU83TnVicFZ4?=
 =?utf-8?B?ZURmeEg3TWV3dVFQb05nZGFacnBzUGNNZ2l1TC95K1NoUE8wU2dCWVl3cllH?=
 =?utf-8?B?aGV3RFM2S1Jod1JrOGF2eEFYTjJuanp2NFYrV20vakQ3WUh1TVVIZmZGcE9S?=
 =?utf-8?B?WHhwRTNjN0FPZVN5ZlZUd0pVTWpQR3A5RUVYdVcvZ0hxYnMxSmNlRHR4ZytU?=
 =?utf-8?B?a1A3dDZDaTBad1dxTFhEb2lPODBBWG1KNGFGQ1h5bk8zM2gyazhZUmNjR2N2?=
 =?utf-8?B?MnRQaVpNbGVVTkUrR3BWeGU3ZDM1RUVXOVpzbE5aOUJmNHVBdGJNWFltWDVj?=
 =?utf-8?B?ZGNUKzlobnpNT0x6ajVSRkJMZzJZOERiV0VxVXNhM1h6RWQ4Z1BzbVV0R3ZJ?=
 =?utf-8?B?b3d2SmIzSVdKK2c3aFdPN21TWFR0T3NWZjFJVDV0dGpzM1BQZTBZRkhuMTV0?=
 =?utf-8?B?bEIvSHBjTjhIKzJUQUVsUm1acGR6ekhnL2dqTDFvMTBKeE5sOUZZelBFb0Yy?=
 =?utf-8?B?MFpVRWYxTW9GWkNQTFdxemhOTlN1Q0NUSTk0bFZOTUlQS0FNRWZ6aXlxZGda?=
 =?utf-8?B?bGNIc1kwcDdkUEM5alB4N0VaSDZjUXRVcVhmZkFQVk5PSllRWmk4b1JFWmR4?=
 =?utf-8?B?R3FIR1BpcEdhQmYwOTJXQ01rZ1UrSnE1WmQyMDFqUUc2dVZ1aVAxdmxZd05k?=
 =?utf-8?B?Wm5RUHR5aGQ3OEJzNW0zTWU4ZXliaXdIa21BUVgxMm5CcEFWVW5KNWxSeTk4?=
 =?utf-8?B?MFU0YXczU0trdVd1RGhFZUdaekEvVWY5ZW9iRXpUN1dIdVBXTlRyWE9pZGgx?=
 =?utf-8?B?Y0czalZjeVlkSW9DeXFITjJCWk9wV1phNW1RbmNyQ1h2L0xrN1VkUnpqeE9Z?=
 =?utf-8?B?L2xkQXVnUzExWGM4bjEwNFlKd05MaXlkVnpXeW5vV0hzQ3AvdTFLU2VKeE96?=
 =?utf-8?B?N0xHWmJhVkY3bCtweXpLc3NQb1ptcVNNUU95Z20xZlhLejAyS2tKdVVqZEFL?=
 =?utf-8?B?RGVNdzBwNkN4bkcyLzd5NkszUnFGSHNrQ1VmNkJreUxCWjU1N3I5Ry9WQUdr?=
 =?utf-8?B?OUpJeDdwMFJidE5KTnpuVkZkUGkxSmZhaVZDYy8rMTFtdDlxOEFmOHJtMlFS?=
 =?utf-8?B?Mi9lUFZGU3FuYTBmdUN6YzZEdkJ1V3MvMmlMck1ZdlFBSlY1YXUwd3BkbXRC?=
 =?utf-8?B?UU10K0tJSEkvYUEvZ1R4T3JaOTNGUEY1QlRHcmVxZjFZMG10bmYvUjVvNkhC?=
 =?utf-8?B?VWZqUTNRR3dJMWJMR05rRExMRUdpWU0wcTlYVmtXRXozZlFsQ2JyLytQcDRQ?=
 =?utf-8?B?eUF4K0Z2cWd6WWhqY1NvK2VkdVozdVpIemsxNVpOWUtxUkxFMlZEZWhOaWMv?=
 =?utf-8?B?TlRvd2lsVXNDTVNnTEdoa01QdVpjWUx5YjNpTGJiQjAyaFE2NGU0cGNTeEZO?=
 =?utf-8?B?WVZvOUd0c2pHVVllYjdIMGJ4RmlsMW1lckVWd2wrVlllSUl4L0lUY0hTOUJl?=
 =?utf-8?B?bUNxc0xmM05UVGJSMEZGWWZWTDZtZk90bEw0d0lOcUUvUTExM3ZkOXZVWHdY?=
 =?utf-8?B?WGpiemttRTZvYnJkMjdtQVRzQ0kwZFhtZlBibTdyU2ZzKzN6ZnhPdHZQcDZ3?=
 =?utf-8?B?Z0crcnpzVmVaUHcyNE9zZSt5M0poK0tCYkxkbWxaTmwrWHJVNGVoUXBhWWsx?=
 =?utf-8?B?TnY2SkxQUzdxeXZ4OWt2WHlQK2FIN240VXE3RkxCVmJ3VDR3RklFVGJwdDdP?=
 =?utf-8?B?MGN4a3c3aCsxRFo2VWtyelAxMDRlbWJGUmhPLzVrelc2ZGpPMmIrdVFLNTZU?=
 =?utf-8?B?bjMxZEJMa00vTVdFQ3FJemJacFpLa1RtcnEyVnk1WXBJNGdkR0VLOW01Sk00?=
 =?utf-8?Q?gFNA=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 09:32:38.6407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c0dfe4-5198-418b-fd58-08de1d176d3a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3276
X-Authority-Analysis: v=2.4 cv=WL9yn3sR c=1 sm=1 tr=0 ts=690c6b39 cx=c_pps
 a=JRzJ8T7PdTfL/uBtHARA3w==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Wpbxt3t0qq0A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=sv003Xou3s-jQteCACwA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: GWGol1fWY4ikYMnyNPC3oLKdeULV9Fc6
X-Proofpoint-ORIG-GUID: GWGol1fWY4ikYMnyNPC3oLKdeULV9Fc6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA3NiBTYWx0ZWRfX+3mR9AG7kIJX
 +4Yh9G6xEDtnYWAEZouLKuyEFiSbkGmEoXoNL/1c8RBq2cjfb81vXN2P7fRsQ5PomFWb0a6f4aL
 pxs0t/lhIfDtfX5tmfnqUcJcA2laBokCm6RgKbwe3WdeHIeb4CxYfVH1bXEs97opOP7OB8SHMXl
 pbmADKDYWphNnz0mVxNpk1aBLB30dChar1+iavZVt3CwyAHAP0Md9DwfMDzBJdc8PNKDu1Xg7ov
 IzeaDdPoCS5mx5vqWWYl9A4cAjRBavB61+6w6BHLESEstR/23TkFMFVtqkJrfuBlQCMHBJ1u3lI
 18mnkLsgWruaqfleAkcbB47VNctrFlrynVBSm1oi152qek2E+yOJBDTzYS+AqcG0zCq3KSTMIdC
 9p4MQNuLeY0l19+vXme9DP7Xs63BEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060076

RIFSC configuration can be difficult to debug. Add a debugfs entry
that dumps the configuration of the RISUPs, the RISALs and the RIMUs.
This will allow to display the whole RIFSC firewall configuration at
runtime.

While there, fix a bug on the computation of firewall entries in the
probe function.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 drivers/bus/stm32_rifsc.c | 597 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 593 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/stm32_rifsc.c b/drivers/bus/stm32_rifsc.c
index 4cf1b60014b7..debeaf8ea1bd 100644
--- a/drivers/bus/stm32_rifsc.c
+++ b/drivers/bus/stm32_rifsc.c
@@ -5,6 +5,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -25,6 +26,8 @@
 #define RIFSC_RISC_PRIVCFGR0		0x30
 #define RIFSC_RISC_PER0_CIDCFGR		0x100
 #define RIFSC_RISC_PER0_SEMCR		0x104
+#define RIFSC_RISC_REG0_ACFGR		0x900
+#define RIFSC_RISC_REG3_AADDR		0x924
 #define RIFSC_RISC_HWCFGR2		0xFEC
 
 /*
@@ -70,6 +73,565 @@
 #define RIF_CID0			0x0
 #define RIF_CID1			0x1
 
+#if defined(CONFIG_DEBUG_FS)
+#define RIFSC_RISUP_ENTRIES		128
+#define RIFSC_RIMU_ENTRIES		16
+#define RIFSC_RISAL_SUBREGIONS		2
+#define RIFSC_RISAL_GRANULARITY		8
+
+#define RIFSC_RIMC_ATTR0		0xC10
+
+#define RIFSC_RIMC_CIDSEL		BIT(2)
+#define RIFSC_RIMC_MCID_MASK		GENMASK(6, 4)
+#define RIFSC_RIMC_MSEC			BIT(8)
+#define RIFSC_RIMC_MPRIV		BIT(9)
+
+#define RIFSC_RISC_SRCID_MASK		GENMASK(6, 4)
+#define RIFSC_RISC_SRPRIV		BIT(9)
+#define RIFSC_RISC_SRSEC		BIT(8)
+#define RIFSC_RISC_SRRLOCK		BIT(1)
+#define RIFSC_RISC_SREN			BIT(0)
+#define RIFSC_RISC_SRLENGTH_MASK	GENMASK(27, 16)
+#define RIFSC_RISC_SRSTART_MASK		GENMASK(10, 0)
+
+static const char *stm32mp21_rifsc_rimu_names[RIFSC_RIMU_ENTRIES] = {
+	"ETR",
+	"SDMMC1",
+	"SDMMC2",
+	"SDMMC3",
+	"OTG_HS",
+	"USBH",
+	"ETH1",
+	"ETH2",
+	"RESERVED",
+	"RESERVED",
+	"DCMIPP",
+	"LTDC_L1/L2",
+	"LTDC_L3",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+};
+
+static const char *stm32mp25_rifsc_rimu_names[RIFSC_RIMU_ENTRIES] = {
+	"ETR",
+	"SDMMC1",
+	"SDMMC2",
+	"SDMMC3",
+	"USB3DR",
+	"USBH",
+	"ETH1",
+	"ETH2",
+	"PCIE",
+	"GPU",
+	"DMCIPP",
+	"LTDC_L0/L1",
+	"LTDC_L2",
+	"LTDC_ROT",
+	"VDEC",
+	"VENC"
+};
+
+static const char *stm32mp21_rifsc_risup_names[RIFSC_RISUP_ENTRIES] = {
+	"TIM1",
+	"TIM2",
+	"TIM3",
+	"TIM4",
+	"TIM5",
+	"TIM6",
+	"TIM7",
+	"TIM8",
+	"TIM10",
+	"TIM11",
+	"TIM12",
+	"TIM13",
+	"TIM14",
+	"TIM15",
+	"TIM16",
+	"TIM17",
+	"RESERVED",
+	"LPTIM1",
+	"LPTIM2",
+	"LPTIM3",
+	"LPTIM4",
+	"LPTIM5",
+	"SPI1",
+	"SPI2",
+	"SPI3",
+	"SPI4",
+	"SPI5",
+	"SPI6",
+	"RESERVED",
+	"RESERVED",
+	"SPDIFRX",
+	"USART1",
+	"USART2",
+	"USART3",
+	"UART4",
+	"UART5",
+	"USART6",
+	"UART7",
+	"RESERVED",
+	"RESERVED",
+	"LPUART1",
+	"I2C1",
+	"I2C2",
+	"I2C3",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"SAI1",
+	"SAI2",
+	"SAI3",
+	"SAI4",
+	"RESERVED",
+	"MDF1",
+	"RESERVED",
+	"FDCAN",
+	"HDP",
+	"ADC1",
+	"ADC2",
+	"ETH1",
+	"ETH2",
+	"RESERVED",
+	"USBH",
+	"RESERVED",
+	"RESERVED",
+	"OTG_HS",
+	"DDRPERFM",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"STGEN",
+	"OCTOSPI1",
+	"RESERVED",
+	"SDMMC1",
+	"SDMMC2",
+	"SDMMC3",
+	"RESERVED",
+	"LTDC_CMN",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"CSI",
+	"DCMIPP",
+	"DCMI_PSSI",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"RNG1",
+	"RNG2",
+	"PKA",
+	"SAES",
+	"HASH1",
+	"HASH2",
+	"CRYP1",
+	"CRYP2",
+	"IWDG1",
+	"IWDG2",
+	"IWDG3",
+	"IWDG4",
+	"WWDG1",
+	"RESERVED",
+	"VREFBUF",
+	"DTS",
+	"RAMCFG",
+	"CRC",
+	"SERC",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"I3C1",
+	"I3C2",
+	"I3C3",
+	"RESERVED",
+	"ICACHE_DCACHE",
+	"LTDC_L1L2",
+	"LTDC_L3",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"RESERVED",
+	"OTFDEC1",
+	"RESERVED",
+	"IAC",
+};
+
+static const char *stm32mp25_rifsc_risup_names[RIFSC_RISUP_ENTRIES] = {
+	"TIM1",
+	"TIM2",
+	"TIM3",
+	"TIM4",
+	"TIM5",
+	"TIM6",
+	"TIM7",
+	"TIM8",
+	"TIM10",
+	"TIM11",
+	"TIM12",
+	"TIM13",
+	"TIM14",
+	"TIM15",
+	"TIM16",
+	"TIM17",
+	"TIM20",
+	"LPTIM1",
+	"LPTIM2",
+	"LPTIM3",
+	"LPTIM4",
+	"LPTIM5",
+	"SPI1",
+	"SPI2",
+	"SPI3",
+	"SPI4",
+	"SPI5",
+	"SPI6",
+	"SPI7",
+	"SPI8",
+	"SPDIFRX",
+	"USART1",
+	"USART2",
+	"USART3",
+	"UART4",
+	"UART5",
+	"USART6",
+	"UART7",
+	"UART8",
+	"UART9",
+	"LPUART1",
+	"I2C1",
+	"I2C2",
+	"I2C3",
+	"I2C4",
+	"I2C5",
+	"I2C6",
+	"I2C7",
+	"I2C8",
+	"SAI1",
+	"SAI2",
+	"SAI3",
+	"SAI4",
+	"RESERVED",
+	"MDF1",
+	"ADF1",
+	"FDCAN",
+	"HDP",
+	"ADC12",
+	"ADC3",
+	"ETH1",
+	"ETH2",
+	"RESERVED",
+	"USBH",
+	"RESERVED",
+	"RESERVED",
+	"USB3DR",
+	"COMBOPHY",
+	"PCIE",
+	"UCPD1",
+	"ETHSW_DEIP",
+	"ETHSW_ACM_CF",
+	"ETHSW_ACM_MSGBU",
+	"STGEN",
+	"OCTOSPI1",
+	"OCTOSPI2",
+	"SDMMC1",
+	"SDMMC2",
+	"SDMMC3",
+	"GPU",
+	"LTDC_CMN",
+	"DSI_CMN",
+	"RESERVED",
+	"RESERVED",
+	"LVDS",
+	"RESERVED",
+	"CSI",
+	"DCMIPP",
+	"DCMI_PSSI",
+	"VDEC",
+	"VENC",
+	"RESERVED",
+	"RNG",
+	"PKA",
+	"SAES",
+	"HASH",
+	"CRYP1",
+	"CRYP2",
+	"IWDG1",
+	"IWDG2",
+	"IWDG3",
+	"IWDG4",
+	"IWDG5",
+	"WWDG1",
+	"WWDG2",
+	"RESERVED",
+	"VREFBUF",
+	"DTS",
+	"RAMCFG",
+	"CRC",
+	"SERC",
+	"OCTOSPIM",
+	"GICV2M",
+	"RESERVED",
+	"I3C1",
+	"I3C2",
+	"I3C3",
+	"I3C4",
+	"ICACHE_DCACHE",
+	"LTDC_L0L1",
+	"LTDC_L2",
+	"LTDC_ROT",
+	"DSI_TRIG",
+	"DSI_RDFIFO",
+	"RESERVED",
+	"OTFDEC1",
+	"OTFDEC2",
+	"IAC",
+};
+struct rifsc_risup_debug_data {
+	char dev_name[15];
+	u8 dev_cid;
+	u8 dev_sem_cids;
+	u8 dev_id;
+	bool dev_cid_filt_en;
+	bool dev_sem_en;
+	bool dev_priv;
+	bool dev_sec;
+};
+
+struct rifsc_rimu_debug_data {
+	char m_name[11];
+	u8 m_cid;
+	bool cidsel;
+	bool m_sec;
+	bool m_priv;
+};
+
+struct rifsc_subreg_debug_data {
+	bool sr_sec;
+	bool sr_priv;
+	u8 sr_cid;
+	bool sr_rlock;
+	bool sr_enable;
+	u16 sr_start;
+	u16 sr_length;
+};
+
+struct stm32_rifsc_resources_names {
+	const char **device_names;
+	const char **initiator_names;
+};
+struct rifsc_dbg_private {
+	const struct stm32_rifsc_resources_names *res_names;
+	void __iomem *mmio;
+	unsigned int nb_risup;
+	unsigned int nb_rimu;
+	unsigned int nb_risal;
+};
+
+static const struct stm32_rifsc_resources_names rifsc_mp21_res_names = {
+	.device_names = stm32mp21_rifsc_risup_names,
+	.initiator_names = stm32mp21_rifsc_rimu_names,
+};
+
+static const struct stm32_rifsc_resources_names rifsc_mp25_res_names = {
+	.device_names = stm32mp25_rifsc_risup_names,
+	.initiator_names = stm32mp25_rifsc_rimu_names,
+};
+
+static void stm32_rifsc_fill_rimu_dbg_entry(struct rifsc_dbg_private *rifsc,
+					    struct rifsc_rimu_debug_data *dbg_entry, int i)
+{
+	const struct stm32_rifsc_resources_names *dbg_names = rifsc->res_names;
+	u32 rimc_attr = readl_relaxed(rifsc->mmio + RIFSC_RIMC_ATTR0 + 0x4 * i);
+
+	snprintf(dbg_entry->m_name, sizeof(dbg_entry->m_name), "%s", dbg_names->initiator_names[i]);
+	dbg_entry->m_cid = FIELD_GET(RIFSC_RIMC_MCID_MASK, rimc_attr);
+	dbg_entry->cidsel = rimc_attr & RIFSC_RIMC_CIDSEL;
+	dbg_entry->m_sec = rimc_attr & RIFSC_RIMC_MSEC;
+	dbg_entry->m_priv = rimc_attr & RIFSC_RIMC_MPRIV;
+}
+
+static void stm32_rifsc_fill_dev_dbg_entry(struct rifsc_dbg_private *rifsc,
+					   struct rifsc_risup_debug_data *dbg_entry, int i)
+{
+	const struct stm32_rifsc_resources_names *dbg_names = rifsc->res_names;
+	u32 cid_cfgr, sec_cfgr, priv_cfgr;
+	u8 reg_id = i / IDS_PER_RISC_SEC_PRIV_REGS;
+	u8 reg_offset = i % IDS_PER_RISC_SEC_PRIV_REGS;
+
+	cid_cfgr = readl_relaxed(rifsc->mmio + RIFSC_RISC_PER0_CIDCFGR + 0x8 * i);
+	sec_cfgr = readl_relaxed(rifsc->mmio + RIFSC_RISC_SECCFGR0 + 0x4 * reg_id);
+	priv_cfgr = readl_relaxed(rifsc->mmio + RIFSC_RISC_PRIVCFGR0 + 0x4 * reg_id);
+
+	snprintf(dbg_entry->dev_name, sizeof(dbg_entry->dev_name), "%s",
+		 dbg_names->device_names[i]);
+	dbg_entry->dev_id = i;
+	dbg_entry->dev_cid_filt_en = cid_cfgr & CIDCFGR_CFEN;
+	dbg_entry->dev_sem_en = cid_cfgr & CIDCFGR_SEMEN;
+	dbg_entry->dev_cid = FIELD_GET(RIFSC_RISC_SCID_MASK, cid_cfgr);
+	dbg_entry->dev_sem_cids = FIELD_GET(RIFSC_RISC_SEMWL_MASK, cid_cfgr);
+	dbg_entry->dev_sec = sec_cfgr & BIT(reg_offset) ?  true : false;
+	dbg_entry->dev_priv = priv_cfgr & BIT(reg_offset) ?  true : false;
+}
+
+
+static void stm32_rifsc_fill_subreg_dbg_entry(struct rifsc_dbg_private *rifsc,
+					      struct rifsc_subreg_debug_data *dbg_entry, int i,
+					      int j)
+{
+	u32 risc_xcfgr = readl_relaxed(rifsc->mmio + RIFSC_RISC_REG0_ACFGR + 0x10 * i + 0x8 * j);
+	u32 risc_xaddr;
+
+	dbg_entry->sr_sec = risc_xcfgr & RIFSC_RISC_SRSEC;
+	dbg_entry->sr_priv = risc_xcfgr & RIFSC_RISC_SRPRIV;
+	dbg_entry->sr_cid = FIELD_GET(RIFSC_RISC_SRCID_MASK, risc_xcfgr);
+	dbg_entry->sr_rlock = risc_xcfgr & RIFSC_RISC_SRRLOCK;
+	dbg_entry->sr_enable = risc_xcfgr & RIFSC_RISC_SREN;
+	if (i == 2) {
+		risc_xaddr = readl_relaxed(rifsc->mmio + RIFSC_RISC_REG3_AADDR + 0x8 * j);
+		dbg_entry->sr_length = FIELD_GET(RIFSC_RISC_SRLENGTH_MASK, risc_xaddr);
+		dbg_entry->sr_start = FIELD_GET(RIFSC_RISC_SRSTART_MASK, risc_xaddr);
+	} else {
+		dbg_entry->sr_start = 0;
+		dbg_entry->sr_length = U16_MAX;
+	}
+}
+
+static int stm32_rifsc_conf_dump_show(struct seq_file *s, void *data)
+{
+	struct rifsc_dbg_private *rifsc = (struct rifsc_dbg_private *)s->private;
+	int i, j;
+
+	seq_puts(s, "\n=============================================\n");
+	seq_puts(s, "                 RIFSC dump\n");
+	seq_puts(s, "=============================================\n\n");
+
+	seq_puts(s, "\n=============================================\n");
+	seq_puts(s, "                 RISUP dump\n");
+	seq_puts(s, "=============================================\n");
+
+	seq_printf(s, "\n| %-15s |", "Peripheral name");
+	seq_puts(s, "| Firewall ID |");
+	seq_puts(s, "| N/SECURE |");
+	seq_puts(s, "| N/PRIVILEGED |");
+	seq_puts(s, "| CID filtering |");
+	seq_puts(s, "| Semaphore mode |");
+	seq_puts(s, "| SCID |");
+	seq_printf(s, "| %7s |\n", "SEMWL");
+
+	for (i = 0; i < RIFSC_RISUP_ENTRIES && i < rifsc->nb_risup; i++) {
+		struct rifsc_risup_debug_data d_dbg_entry;
+
+		stm32_rifsc_fill_dev_dbg_entry(rifsc, &d_dbg_entry, i);
+
+		seq_printf(s, "| %-15s |", d_dbg_entry.dev_name);
+		seq_printf(s, "| %-11d |", d_dbg_entry.dev_id);
+		seq_printf(s, "| %-8s |", d_dbg_entry.dev_sec ? "SEC" : "NSEC");
+		seq_printf(s, "| %-12s |", d_dbg_entry.dev_priv ? "PRIV" : "NPRIV");
+		seq_printf(s, "| %-13s |", str_enabled_disabled(d_dbg_entry.dev_cid_filt_en));
+		seq_printf(s, "| %-14s |", str_enabled_disabled(d_dbg_entry.dev_sem_en));
+		seq_printf(s, "| %-4d |", d_dbg_entry.dev_cid);
+		seq_printf(s, "| %#-7x |\n", d_dbg_entry.dev_sem_cids);
+	}
+
+	seq_puts(s, "\n=============================================\n");
+	seq_puts(s, "                  RIMU dump\n");
+	seq_puts(s, "=============================================\n");
+
+	seq_puts(s, "| RIMU's name |");
+	seq_puts(s, "| CIDSEL |");
+	seq_puts(s, "| MCID |");
+	seq_puts(s, "| N/SECURE |");
+	seq_puts(s, "| N/PRIVILEGED |\n");
+
+	for (i = 0; i < RIFSC_RIMU_ENTRIES && rifsc->nb_rimu; i++) {
+		struct rifsc_rimu_debug_data m_dbg_entry;
+
+		stm32_rifsc_fill_rimu_dbg_entry(rifsc, &m_dbg_entry, i);
+
+		seq_printf(s, "| %-11s |", m_dbg_entry.m_name);
+		seq_printf(s, "| %-6s |", m_dbg_entry.cidsel ? "CIDSEL" : "");
+		seq_printf(s, "| %-4d |", m_dbg_entry.m_cid);
+		seq_printf(s, "| %-8s |", m_dbg_entry.m_sec ? "SEC" : "NSEC");
+		seq_printf(s, "| %-12s |\n", m_dbg_entry.m_priv ? "PRIV" : "NPRIV");
+	}
+
+	if (rifsc->nb_risal > 0) {
+		seq_puts(s, "\n=============================================\n");
+		seq_puts(s, "                  RISAL dump\n");
+		seq_puts(s, "=============================================\n");
+
+		seq_puts(s, "| Memory  |");
+		seq_puts(s, "| Subreg. |");
+		seq_puts(s, "| N/SECURE |");
+		seq_puts(s, "| N/PRIVILEGED |");
+		seq_puts(s, "| Subreg. CID |");
+		seq_puts(s, "| Resource lock |");
+		seq_puts(s, "| Subreg. enable |");
+		seq_puts(s, "| Subreg. start |");
+		seq_puts(s, "|  Subreg. end  |\n");
+
+		for (i = 0; i < rifsc->nb_risal; i++) {
+			for (j = 0; j < RIFSC_RISAL_SUBREGIONS; j++) {
+				struct rifsc_subreg_debug_data sr_dbg_entry;
+
+				stm32_rifsc_fill_subreg_dbg_entry(rifsc, &sr_dbg_entry, i, j);
+
+				seq_printf(s, "| LPSRAM%1d |", i + 1);
+				seq_printf(s, "|    %1s    |", (j == 0) ? "A" : "B");
+				seq_printf(s, "| %-8s |", sr_dbg_entry.sr_sec ? "SEC" : "NSEC");
+				seq_printf(s, "| %-12s |", sr_dbg_entry.sr_priv ? "PRIV" : "NPRIV");
+				seq_printf(s, "| 0x%-9x |", sr_dbg_entry.sr_cid);
+				seq_printf(s, "| %-13s |",
+					   sr_dbg_entry.sr_rlock ? "locked (1)" : "unlocked (0)");
+				seq_printf(s, "| %-14s |",
+					   str_enabled_disabled(sr_dbg_entry.sr_enable));
+				seq_printf(s, "| 0x%-11x |", sr_dbg_entry.sr_start);
+				seq_printf(s, "| 0x%-11x |\n", sr_dbg_entry.sr_start +
+					   sr_dbg_entry.sr_length - 1);
+			}
+		}
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(stm32_rifsc_conf_dump);
+
+static int stm32_rifsc_register_debugfs(struct stm32_firewall_controller *rifsc_controller,
+					u32 nb_risup, u32 nb_rimu, u32 nb_risal)
+{
+	struct rifsc_dbg_private *rifsc_priv;
+	struct dentry *root = NULL;
+
+	rifsc_priv = devm_kzalloc(rifsc_controller->dev, sizeof(*rifsc_priv), GFP_KERNEL);
+	if (!rifsc_priv)
+		return -ENOMEM;
+
+	rifsc_priv->mmio = rifsc_controller->mmio;
+	rifsc_priv->nb_risup = nb_risup;
+	rifsc_priv->nb_rimu = nb_rimu;
+	rifsc_priv->nb_risal = nb_risal;
+	rifsc_priv->res_names = of_device_get_match_data(rifsc_controller->dev);
+
+	root = debugfs_lookup("stm32_firewall", NULL);
+	if (!root)
+		root = debugfs_create_dir("stm32_firewall", NULL);
+
+	if (IS_ERR(root))
+		return PTR_ERR(root);
+
+	debugfs_create_file("rifsc", 0444, root, rifsc_priv, &stm32_rifsc_conf_dump_fops);
+
+	return 0;
+}
+#endif /* defined(CONFIG_DEBUG_FS) */
+
 static bool stm32_rifsc_is_semaphore_available(void __iomem *addr)
 {
 	return !(readl(addr) & SEMCR_MUTEX);
@@ -207,9 +769,19 @@ static int stm32_rifsc_probe(struct platform_device *pdev)
 	rifsc_controller->release_access = stm32_rifsc_release_access;
 
 	/* Get number of RIFSC entries*/
-	nb_risup = readl(rifsc_controller->mmio + RIFSC_RISC_HWCFGR2) & HWCFGR2_CONF1_MASK;
-	nb_rimu = readl(rifsc_controller->mmio + RIFSC_RISC_HWCFGR2) & HWCFGR2_CONF2_MASK;
-	nb_risal = readl(rifsc_controller->mmio + RIFSC_RISC_HWCFGR2) & HWCFGR2_CONF3_MASK;
+	nb_risup = FIELD_GET(HWCFGR2_CONF1_MASK,
+			     readl(rifsc_controller->mmio + RIFSC_RISC_HWCFGR2));
+	nb_rimu = FIELD_GET(HWCFGR2_CONF2_MASK,
+			    readl(rifsc_controller->mmio + RIFSC_RISC_HWCFGR2));
+	nb_risal = FIELD_GET(HWCFGR2_CONF3_MASK,
+			     readl(rifsc_controller->mmio + RIFSC_RISC_HWCFGR2));
+	/*
+	 * On STM32MP21, RIFSC_RISC_HWCFGR2 shows an incorrect number of RISAL (NUM_RISAL is 3
+	 * instead of 0). A software workaround is implemented using the st,mem-map property in the
+	 * device tree. This property is absent or left empty if there is no RISAL.
+	 */
+	if (of_device_is_compatible(np, "st,stm32mp21-rifsc"))
+		nb_risal = 0;
 	rifsc_controller->max_entries = nb_risup + nb_rimu + nb_risal;
 
 	platform_set_drvdata(pdev, rifsc_controller);
@@ -228,12 +800,29 @@ static int stm32_rifsc_probe(struct platform_device *pdev)
 		return rc;
 	}
 
+#if defined(CONFIG_DEBUG_FS)
+	rc = stm32_rifsc_register_debugfs(rifsc_controller, nb_risup, nb_rimu, nb_risal);
+	if (rc)
+		return dev_err_probe(rifsc_controller->dev, rc, "Failed creating debugfs entry\n");
+#endif
+
 	/* Populate all allowed nodes */
 	return of_platform_populate(np, NULL, NULL, &pdev->dev);
 }
 
 static const struct of_device_id stm32_rifsc_of_match[] = {
-	{ .compatible = "st,stm32mp25-rifsc" },
+	{
+		.compatible = "st,stm32mp25-rifsc",
+#if defined(CONFIG_DEBUG_FS)
+		.data = &rifsc_mp25_res_names,
+#endif
+	},
+	{
+		.compatible = "st,stm32mp21-rifsc",
+#if defined(CONFIG_DEBUG_FS)
+		.data = &rifsc_mp21_res_names,
+#endif
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, stm32_rifsc_of_match);

-- 
2.43.0


