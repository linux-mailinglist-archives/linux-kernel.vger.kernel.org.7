Return-Path: <linux-kernel+bounces-897436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB13C530FB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81527560336
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B613469E2;
	Wed, 12 Nov 2025 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="C+ULakdu"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5C83431FD;
	Wed, 12 Nov 2025 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958453; cv=fail; b=lgt8tQpyk4n/8CxGqbaWQgJ5G1uCL3jqioY7UJfcgIqJQdb2VSswOly4khnqbYWOu1xN9oHBIvd7J91WdD6/ENwcb00CIsl7Iy512OlB/Y801zGxEttsvNQGFjzZmRP9Bdc8QdgR5HgErOv40K3LVaZluVsTrgbXftCakThRQSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958453; c=relaxed/simple;
	bh=aXFC97UwoNLurTQBOFkYdqsdrjLdBncluKEW6QV3oDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bgSl8SNYpU+HTJ0P8GB/ZngqViKUL+gAlxYKjn6uc9MilXheN7Pd8XJNOMY3jIVi0cCE0ccCW7cArc6veVNSn8QONIGduR6Ng7oB7s8WsV4gm6gJd8NU3xdVEKtSbWzkEhqK3rk/8d7n20xtc+pYhG6gHsfuy46uf0L4UcnEBJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=C+ULakdu; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACEZFBr969546;
	Wed, 12 Nov 2025 15:40:39 +0100
Received: from du2pr03cu002.outbound.protection.outlook.com (mail-northeuropeazon11011061.outbound.protection.outlook.com [52.101.65.61])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acreu104a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:40:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHEWQfdoOrVGjn0mu+IVCOhmh1dQlhrYcEs1DFeDCSeSxEQumGcWyEAoc599ng9cbZd+lYQNg4b55gNuNQTzriOU8ftaKlIvh5S+Ly67BpE3kj8n9o5x9b3YOlUlefBlnCCcjQVCXfiN9QoaksfoSpz8KoO7ViMkf30RXBldAyAmElmaRZ4GOtQFGeGyAOrkc7RwcOUtcY+ku0m2AP0AVqix7wYkbQ05vVBGZ9IVae2OFb6/jZG1mZLhBzjElQf++M/1ryUkeLYB/p/75qJa7FGuUWuBE2x/D1zh8bT3bNUZfeE/h3O3H3gRFIT/NB23ztbTooWR3H0s2M+r6opSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8yQXrkJ0i+Z8+ZkP3hxRefHuxJh/VQSECDB0Yte1l8=;
 b=IsU+0B9lRI3Nmnfkdp0h7sd3cgdpQVHkMcpRRzoxzGAdHyMjGngwZp26HZJPhTsplzz0PE72fyYwxqTy0utGN5kyII5THMBk37U2aQIOsCkkAKSM1tcwxr4eseixAJKIfrnRh4vbXqyS7+X7sI9uddh2F6XKZ9nF2AeBdlkpM4PaZX64qf+47aFaV++SgkNT5K8C3IADYVyaMh0YFmaxsF4I+foleIzbrefcVt2d0bwHdmfJB0RpW2cwWn9ylBI9eGRih+0ykUEQOsv3524/FtN3FS52LwgEEF5LrFA8tYawWwdyDtiYCt6ubQxJG8y0YJEd8+qbhFbf7fqXa6h0SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8yQXrkJ0i+Z8+ZkP3hxRefHuxJh/VQSECDB0Yte1l8=;
 b=C+ULakdu5XfsQ1VHPi19NbssJ62MSdKA39P6Z/xCLOTIhJFSmqPzeWukGbZmMsiDuETGevQmrrI2og3gpAhxwuf+P20CrkdLicEwPCTyzh/ZKWMtlQeXzj/Gx7nPNVD0J7+7DWITs78bFlAoC2IJCY6X3eG7zUpvxUOkoTxL2tztqguIjYffnsOBBWEKELb4I2p0tdlEFvRI16SwNhxsh4KWlExbWTNGOyIMmwoyKwuAUUgpx2DB/Gbe5rEUbRz6H8SqTGsofWRjkqkQvNqJ10aADtqGFLWFdG0EWa3OpZm9/WD0eTiC22vmG+v4Uy3M+Y0Rv8HeaRboOiF/qSTZTA==
Received: from DUZPR01CA0297.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::8) by DB8PR10MB3628.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:134::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 14:40:38 +0000
Received: from DB3PEPF0000885C.eurprd02.prod.outlook.com
 (2603:10a6:10:4b7:cafe::cb) by DUZPR01CA0297.outlook.office365.com
 (2603:10a6:10:4b7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 14:40:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB3PEPF0000885C.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 14:40:37 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:46 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:37 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 15:40:26 +0100
Subject: [PATCH 09/16] ARM: dts: stm32: Add LED support for stm32h743i-eval
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_update_led_nodes-v1-9-f6c77739113c@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885C:EE_|DB8PR10MB3628:EE_
X-MS-Office365-Filtering-Correlation-Id: d6540fa9-f834-4f30-117b-08de21f97247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekRjeFhwS0xaZVNVUGk5eTNRUktvck8rZ1cwbm5iWm9uakJZamJXbjdEOEFm?=
 =?utf-8?B?bFNobjFOWThzS1VGamR5U3NVWlJZbWVSNXJ1ZHFLNGdzRy8xVndOTWNaRWo2?=
 =?utf-8?B?MHFibHhwOXFUTnprZ0ZxR1lLNk5oV1lzRXZBTnprVzg2THFIWkhlcFVuT3g1?=
 =?utf-8?B?Z2swKzQ0bzJGM0pIUTl2Y2pWcEtMZVRsQkU1Ry94MVcxdFpCOUIxSUlHR0Qw?=
 =?utf-8?B?Zyt6UUtSYXc2WTU0d2R4ZUhaRnRueU5aYTVTZDVwTXgrbVFZNGI1WVdCbEZ1?=
 =?utf-8?B?eCtJWG1yb2h3L2prTHNxTVhGeVJHS1BOdUhWdXFLVUVvU1BPSTA2ZGNpYURW?=
 =?utf-8?B?U2wzcUFwcTR1bHdKcXppM1I5N1RQc1c5bkpCYSs3L0cxVkVqdXhJeDMvN3do?=
 =?utf-8?B?ZWQrWEsvZ2FOSXlFRkhKT1BRckVhQTBmQ2JxNFhlUkZnSXVuSVh5bGNqT0ZI?=
 =?utf-8?B?T1ZaWVZrbFlzV2JhS1ZTTUgyYzRKN2JzRUEwVXM1VjJsd2ZNaVVJcFdxeDNL?=
 =?utf-8?B?UzRoRWF1eU9XaEdYZDhiNkdBQTZ3NHRBUWRCUThlZGlDNVNwNFIrTlJENndl?=
 =?utf-8?B?M2gyUUlqbDY1d1VUZkphaVl5MnhZbzhqWDJCVmlXYUY5NTFuSlg2ZWsxeHdB?=
 =?utf-8?B?ZlQ0NUp4ME9maFFPcVl3Y3o1dVdzU25sWWIxMnJNZWhVYVo3ZFUySTcwcTYx?=
 =?utf-8?B?RXREUjdzY1g5OVhGbGZUSWVabU9CSFFoRzlPMCtQZEZ6ZmNIcXplalhQQ2ZH?=
 =?utf-8?B?Y2ZuaXNzdjQzSkZQMGZSNWRETUFDT0hoOW9UZVg5QW9xby9lckdleE1ya3dz?=
 =?utf-8?B?Z0x5dXhRcWhWWDFhYy9NeGVqcEpBanNJcWVUaGxQMzI4WTNBM1NzelpuaVlJ?=
 =?utf-8?B?K1NXQm5rUUpTWWV4ajZDcXNqRkJDNzJyU3BDT1p6UnRtM0F0Q0pTNmFscDNO?=
 =?utf-8?B?Vlk5ZmduNFVDcUs5MFR4c1g5eEk2SUlsdmppZkJTNE9JSkVHR1NjOEZCazdL?=
 =?utf-8?B?L1gvbmdTbnFRcXQ4MHZuZUNMN0RKblJSdk5janZFQit0TVBaYTNuYUJMM0lw?=
 =?utf-8?B?VXZBeTFBN0s5Qlo3aGNJMStuZGR3SVBFT0RvTC9zbFFFOWdrcktvVjNnTDdy?=
 =?utf-8?B?Z1RGSUpyTnJWUEN2TlNrT1pmUGZ6WDUzdlkwamkyVmNJRTRoK05la2tDMG80?=
 =?utf-8?B?NTRhQ0VYU2IxVmlWWXpQMzFyendYUDRFTTc0VmdFR25ReXVuMjhSSm1UeTVz?=
 =?utf-8?B?aDBFSlZZQ1BJc0trWUx6WlQ3QitYWFI0TkR6Z2tLZGtzTS9ZZk1GS2RJOGx1?=
 =?utf-8?B?VFl1RVcyMXUzSTNzMTlEb2dJaldiV0RBbUo4dWlkUVRiWFl6aW1PcjlTNHFp?=
 =?utf-8?B?YTIzd0h3M0Y0VGZxQUduTks5ODZ4ZkhvYXFqQWtBU3M0OURGYVZ4RmpRM0Ji?=
 =?utf-8?B?Z3ZtVUliT3VmVkFsZkd2aTFOcjVHM09HdmQ4RHJKRW9xSmVyWFNuaUlWQTNJ?=
 =?utf-8?B?SFF6Sm1zZGRuTXhiaE9EeXhldnFoU2UrNi94U2VkWUdid3hnQ0Vrb3JoektJ?=
 =?utf-8?B?eWVHd1RJUEhBOGtrazBWSXk4TEU5YXpTY1RuZDZXdTJaT2tUdG5ncnQ1VmU0?=
 =?utf-8?B?TVRyU1pJakNiOWRQOFJBTGhMeGZIREFQelJQbzFzN2M5OHlhSURzTVAxYmNC?=
 =?utf-8?B?blNlUjV1RUMwRTlVYVAzVFlCNDk1NmRsZWF5TU1xcFZKbzhPdHM5bW00T0RW?=
 =?utf-8?B?VGRDb3VPZWsvRENSZ0xUWGZ5UE9ZcS9oaE9CdTlRNTBibVBXUEFDeG1qMWhC?=
 =?utf-8?B?TC9QcjZteUJZMFRTdEFyblZTVUVvbUdpUWtFeU84blVkdDA4MDF1RGk2YmRQ?=
 =?utf-8?B?WjBZMjB5eEJXUHRqMkpxZTFsdFg3aTA1cjhXQ3R2OWwwZzRMY3ZUeXpQRUVs?=
 =?utf-8?B?UWltMkpabWVqS2QramZCeXBWK3E0VEsrR2tCQU1uRERYbGJEZWg5SXFCMTAy?=
 =?utf-8?B?MkZ2ay9DV2djWHlEajRLTU9XWTJWNms3cjR1citMQ09nME5ndWlkOGNIMU9s?=
 =?utf-8?B?eUlNbUNnQmpzb3dpUVl4VmxITmZQZ1JrcmxEM3d5ZmxFb2xMbE11eVlFR2Q2?=
 =?utf-8?Q?JkJ4=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:40:37.9969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6540fa9-f834-4f30-117b-08de21f97247
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3628
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOCBTYWx0ZWRfX5LIj+/TXAHcf
 gMsAb4uJmtC2WbeRREvXQDVDV4Qm84Jv8owGjpAs642Btg/uDtrdD2Lnujj+fJfbIQNrQ3wxNjH
 gJSa3VQXxkW/xtJ5oUvbA3aeHYeKVvQiiknbYyzYna1IhwXtevnNd3FPooREqrJ58Rhmx/emil7
 6fW9vOOXL3TpL7OpTTBkSleEx/F/9jxIBOAEyqJrG7siqJ9njgrhM6CX7Wh2BooabEygMj1Wh5k
 iwQ5RzZunGQ3LUQG1b7kr7uT40sDnJkiPeQTgXVvJyEUFV/fPUV0FqN3Q1QGkqexbwEBJZ/Vizx
 7DxCjgF1eOfW6g5i7+wGb05oFt/LlWkfVSBKmRXoavzoDVf3+0cbschxDMai9NU8tNRdsAWsRAU
 ffb4zrQiyLp65rnaMMQEGu+B45zrzQ==
X-Authority-Analysis: v=2.4 cv=D+hK6/Rj c=1 sm=1 tr=0 ts=69149c67 cx=c_pps
 a=EUaLOA8Z8AdjKRxvbO/E2w==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=DTfS_Qm12qqBGa833i8A:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: it9dtcJ_noNIzEoPJBSnyjyjgry5Lvzn
X-Proofpoint-GUID: it9dtcJ_noNIzEoPJBSnyjyjgry5Lvzn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120118

Add green and red LEDs support for stm32h743-eval.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32h743i-eval.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32h743i-eval.dts b/arch/arm/boot/dts/st/stm32h743i-eval.dts
index 4b0ced27b80e..4b3e0c5a9009 100644
--- a/arch/arm/boot/dts/st/stm32h743i-eval.dts
+++ b/arch/arm/boot/dts/st/stm32h743i-eval.dts
@@ -43,6 +43,8 @@
 /dts-v1/;
 #include "stm32h743.dtsi"
 #include "stm32h7-pinctrl.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "STMicroelectronics STM32H743i-EVAL board";
@@ -62,6 +64,22 @@ aliases {
 		serial0 = &usart1;
 	};
 
+	led {
+		compatible = "gpio-leds";
+		led-green {
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpiof 10 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+			default-state = "off";
+		};
+
+		led-red {
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpioa 4 GPIO_ACTIVE_LOW>;
+		};
+	};
+
 	vdda: regulator-vdda {
 		compatible = "regulator-fixed";
 		regulator-name = "vdda";

-- 
2.43.0


