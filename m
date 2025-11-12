Return-Path: <linux-kernel+bounces-897431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D668AC52DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8497B426745
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D474F3431FA;
	Wed, 12 Nov 2025 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="osccmdBa"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6E033C535;
	Wed, 12 Nov 2025 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958450; cv=fail; b=Uy70uRbk8urcEHKQ1rFwIFpUJjoqFNQoAcfIZY6WaukeEadxaOjD5B5vYOqtJS1hIxgGZbSR+qD5itN0ePE4l3P+NXwN58fWdKwWH+TN5YyOKfwBPchQxxL5UvWpiibwQwZJWyP45zuTarU/EwzjkUEgJfnptePP1YoF9kzkFUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958450; c=relaxed/simple;
	bh=jNA+ffKePJe6EgCkGLgIv05WKJuQcpDDYE0n//HGKx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eMlmLWzFonjUIIxvYg3SNvAr9WQ3bCg+XY70ZcdBPYQZvYXTS+7CeR7qB3MUYK72IFkhwwsEBOZx4RF4GwZcH5I77dvE6v2UuIRbF7IEFxEEFbwMk2AdIbZxewM1gvagEpcdSV7NTEwF8JjK2omL6HzmOg/YnDH4MvXfLw30oso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=osccmdBa; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACEZDZK1483187;
	Wed, 12 Nov 2025 15:40:38 +0100
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11010026.outbound.protection.outlook.com [52.101.84.26])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acqa79dnj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:40:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSScYjRR4GB7OpCxIz19YPSVJWIkRaU4NMfBXCdi8j7lBo90joks0s4LuOFt66UB8oPJrR85czOJllKRK7v890/INWGjzmQDpBpk3JYeuJdzUAW9aKoKRRrtp+b6xFhKbNjoq+zdxOV8jlRsvZCoLrP8hanaMWOayjBsWFM4SN8bfgY7rJkNXr8otKO0dxW+y498XnmPHMVEcyBPYxnkFJmmQva0r8FyGhGFLpwuOUCpGTJYrtvZ/2oYLCHoFfhRNLsJKqqIRxvF9gQiYqwIvTm2mMtIMZ9MCsdx7K+YDnzeB6Rp9LuU8veyF9GvUstSTH+c3TmJv7AHGvDGDBiGIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Rl5+9s2qWu7OAM/6TYH+ehlp+pWSnbWRaTyeS7mnPc=;
 b=qM5q4qFdaimx62HXxfqqX2bOt9i9tR3+nMz0eywxw/fnm3D71nOxbyC8lYOs1nqWZNL22JBB2Wxiy+PiCuUjkkpEhdaDuCLj15yZdWMA9r2xiM/+fckptD811DZ6wO+zkW0nN0+E3x7lV0ZMWOxd6zLYkcPHqYwNygm+Gdr8UphQebITweOwIvMZJ4c34XXEZGzAv4X9CPVH557scp+q3Ts1WTz3e9yUYu6e53nBGZkxNiMYkvYEPfzbmr4l1sTOuukRIkFyXP8zLFvapkmaQ64E2MO5uFxCRgVcMHEwB8pFKFk5FsA/2jVnzVXgmBX3S+e8ujN2mZ5hqxm/5ZervA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Rl5+9s2qWu7OAM/6TYH+ehlp+pWSnbWRaTyeS7mnPc=;
 b=osccmdBacChk8ePFygdjE1pO3iTUh0dMjNCjP9GbXXeYXDQuu61Xmn1G2yg0bLYTM7Qy2dRvdYG02NX01lDkVkwPHwABiXjeWsuFIjE0SGf4JFt75CUBDBO2urQcEOw7cD5mfCsfSSsT9crMfFgP0zt/3aYqOalBI///f4JNR4KjQJ5uLcPMihy1iELcaxthj+kue4OmVNwx3qxYYiG3R05dmUu7qQjQjTXj6FRpwU9YWNyjsTxWSHqkJCSIcThPzFt8xB0nrbGHkWz3IhMVLOnLZjdIOUZA1czXVLR1zz//i1a7Qn2Gii3GPwowhVjLJzVgLAvVSzPfh+OtMoJ8+A==
Received: from AS4PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:20b:5d4::6)
 by PA1PR10MB9001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:442::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 14:40:33 +0000
Received: from AMS0EPF000001AC.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d4:cafe::c8) by AS4PR09CA0018.outlook.office365.com
 (2603:10a6:20b:5d4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 14:40:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF000001AC.mail.protection.outlook.com (10.167.16.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 14:40:32 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:43 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:32 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 15:40:19 +0100
Subject: [PATCH 02/16] ARM: dts: stm32: Update LED nodes for stm32429i-eval
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_update_led_nodes-v1-2-f6c77739113c@foss.st.com>
References: <20251112-upstream_update_led_nodes-v1-0-f6c77739113c@foss.st.com>
In-Reply-To: <20251112-upstream_update_led_nodes-v1-0-f6c77739113c@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AC:EE_|PA1PR10MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: ae148e93-6e12-4adb-0eb4-08de21f96f29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHNwdVZUZ1hYSEs4aGFQeWZSTWpwSEZMdGxTNGozRzhhQTh2M0dtUjAyNmov?=
 =?utf-8?B?TDlxVzhVQy9QT2xIQnpFVWZmMjBPQkpZV3lhTkU3QUpyN01NWGIwUlV4Mktz?=
 =?utf-8?B?VnJPNXhxS0ozWlhtZnIyYmlRNlplMGlYRS95YnIvRWpxSFgwZ2wrcDF0aFRx?=
 =?utf-8?B?REM3RVdzZUdtTTVlekZRKzdpV1NEL3pPa2FVVzUzYlpobVpDUW5OeGdkSFBu?=
 =?utf-8?B?bG91aVVRbHpXSzd3Rk10K1YzejdwVkdRQXJxTWlRTDBQdFFHVjU4RzRveFJw?=
 =?utf-8?B?dEpTd1ROdDJ3UTQyQ2tLdUJJTzVIVHRMU04vNW9KMnkvcHJ5YWxTUUs5dXVY?=
 =?utf-8?B?a0F5bnFwSGNDTUpHK0tUYXFSQU50MnliVkgxSEw3V1IvK3J3blE0QVBZcUNy?=
 =?utf-8?B?bUpmbnlWM1E4TkFOaUFOUW94UUVVaWxvM1V4S0JxeU1qZzRldkVFV0dXOXRF?=
 =?utf-8?B?L2cyNUNxZm9MUXZZTmZjbEh2VWs3RDErcDQzSWE5cm0zdEZrVGRqd2kwSWcw?=
 =?utf-8?B?Q3NNTE5ndmtuWTFHTkhlVUY4L04zMU1Mem8xZXcvcHJXbFRvUUhscjhIN0ZD?=
 =?utf-8?B?ZTl1Y214TFN5OFQvL2VUdmIvQ0Z4ZU4xU3JnM2EvRU10aW5vRCtxTzFEUmph?=
 =?utf-8?B?R2V2TGNzcGYzSm9kcjJHQmFoM3hpL1lTUTJwd1BaZkFycnUwdEVaL0padlBT?=
 =?utf-8?B?K1Y4UU9TUExmOHd4aE1XdFFUQzhMd2lCSUFpVUdQMk1mTHRQa3NBd2J5VFBr?=
 =?utf-8?B?N3lCOFhvRkhFa2xmTHRqcXB2d1FaNTlxMHFqenJGamZGbHdMTUhUTVJ0Y1NC?=
 =?utf-8?B?WnZpd3YyTGxZRVA2ZGtmc3BnNE51R1RJSHd5OXZWeVlJVXZPV3NOL3NpOEp3?=
 =?utf-8?B?cXlpRytJTmQxQldGVDFiTWNybkVtSlpQTWxMMGdCalgrUlBWKzF1emNPYXZj?=
 =?utf-8?B?VjRReDFnZStjSkVGMy9aTkI4WWxMM3NQRklMaFFZQzRxL01qaXhaL2ptNGpj?=
 =?utf-8?B?TXFkbWFiYnU1cTVTenpTejBiWTVHb2xBdkFPeUxxTHpPN0I3SjZ3cmRFTGUr?=
 =?utf-8?B?ZmMzZVBRWkRScEhGQ3VYMHZhM1R2V3BpUkpkMHZwb1F6YmZBRTRoL0NOcmFz?=
 =?utf-8?B?cHNNRmNkMkppa2RpUVVpRzQzNEF6ODd4UFNpTHYvZzQwOXJ5cnNYWDc5TGc5?=
 =?utf-8?B?dmJYWm5NaWl0Z29TbTJwQ05IU296WVE0b0d3RHIzemx3SWw5eHJad0JNTUlT?=
 =?utf-8?B?RTRhR2phVWlnZUxuWEhYN1NQSXN5MndwWks1MXE4L1dqNXVnUXoxSjhMOWJR?=
 =?utf-8?B?a2lIM1puektSelU2RW5KK3FobE1rUitQemZXb0NWMkh5ek9RYkw1RlliUXgy?=
 =?utf-8?B?QkZza3h5NGJjTkVjYThYMzFxNnVkRjNhbkVja0E2anVEbTNtR2RRQXZlY2hs?=
 =?utf-8?B?RUg5eGgwU3FueXl2YnNjd2F0ZnFVck4vWDBjZUZtSU5TZlFzc0ViVVVNakI3?=
 =?utf-8?B?dU5PditDQTdQV3ZWbDhySVlmZzhRakpFdERSb1pua2hjV0UycmdKMzIwRXVT?=
 =?utf-8?B?YXBvMXg4T1VVQmViZFRBamZMZjMrTmZ3d214Q1d0dWxuVUg2cFBHN0pxbjBC?=
 =?utf-8?B?UUJkM0xTVXVmNjIvS2tQN2dnQkJsTlMzMExFZFpPdXQzYkRTTXdnQzVSSG9r?=
 =?utf-8?B?SFh0ZE5yT0h2RUIvVmlnRDRHbkt3SFgvSlZzT0FLeEhWZEtrcDZ0VjJ2NzRO?=
 =?utf-8?B?bU1wS1pkRW9DSHdIY2lCdHgyYURVWjIwOENNN09sVkgrUGo5WTBCcFEzeUhV?=
 =?utf-8?B?TTdyaHFVcUgrUWFtSXN4TmNCNlRzKzVoZzlVNEdRYkhySk1NQVBNaitrL0dI?=
 =?utf-8?B?cDFkck1ZL0ZOSDAvK1hGTWp2eHFNenhEWURIR045SjNPdEo3RGV6b1FPTW9n?=
 =?utf-8?B?NWJUWUtkeVB0TENpWnJneUJpRFA2akZXS201c3M5empsT3NoSHI3TXhrUmx6?=
 =?utf-8?B?bnBmK0hHQ1pRUXdKMlpoMVg1QnpOY2FTTEQ2M0lDVHJweTFKOEhva0w1eCti?=
 =?utf-8?B?WlZlc25vUnAxWlpPWHdmS0luWG5BbTdsQTc0ZndxaGViTm5JZ3hRYWNiVHIx?=
 =?utf-8?Q?vaCQ=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:40:32.7952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae148e93-6e12-4adb-0eb4-08de21f96f29
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AC.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9001
X-Proofpoint-GUID: rUfxTOsAHdYqPssAVGTLFZXWTsXEY7TQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOCBTYWx0ZWRfX07O4nLjDC3pl
 zglhk9CMonKMH7l1d0iIIellxQxHTgpgfCfETj+pBZlvdGJcgB2jOCnmWvNDT2Ge9gOWIE/xIJs
 IK2SgyzdHthMGvDxDy6dUQCwtcR++COEM9nYG/t5zS8ntKo4ilB75fabDaaAN9GMYH1+hdieZUf
 sHdPwcU+otlmZxfOwEZTW67/36wd7wN2Gf1W8Netls4dat4xdM2zaE4XClY3j1tRBX+fHzTX1Bw
 Ud87SRtjcPgYy9tmhImdt543+TYRiDsV8lCCGn65rCg7CAqwS1dV/RK3jil7FDCOxWjIGnDnnVx
 mZpqM+Ap4AmrHSapM4aM/x38MJiR+BvpBtw5/kLaWSQZiJIp9BFvMfGLaw1pC9/YHG/P7ken/do
 /CYO/4GzoSVmb7qB5pm6GbfiavdbNw==
X-Proofpoint-ORIG-GUID: rUfxTOsAHdYqPssAVGTLFZXWTsXEY7TQ
X-Authority-Analysis: v=2.4 cv=VoAuwu2n c=1 sm=1 tr=0 ts=69149c65 cx=c_pps
 a=/z/ujZMLhdj11oxtLm6Teg==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=NfShEiaLPU-5VWSYspEA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120118

Add function porperty for led-green node.
Add LED color property for LED nodes.
Reorder include dt-bindings.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32429i-eval.dts | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32429i-eval.dts b/arch/arm/boot/dts/st/stm32429i-eval.dts
index aa224d7a9e2b..36415d4d2ffd 100644
--- a/arch/arm/boot/dts/st/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/st/stm32429i-eval.dts
@@ -48,8 +48,9 @@
 /dts-v1/;
 #include "stm32f429.dtsi"
 #include "stm32f429-pinctrl.dtsi"
-#include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/media/video-interfaces.h>
 
 / {
@@ -85,16 +86,21 @@ soc {
 	leds {
 		compatible = "gpio-leds";
 		led-green {
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&gpiog 6 1>;
 			linux,default-trigger = "heartbeat";
 		};
 		led-orange {
+			color = <LED_COLOR_ID_ORANGE>;
 			gpios = <&gpiog 7 1>;
 		};
 		led-red {
+			color = <LED_COLOR_ID_RED>;
 			gpios = <&gpiog 10 1>;
 		};
 		led-blue {
+			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&gpiog 12 1>;
 		};
 	};

-- 
2.43.0


