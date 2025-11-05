Return-Path: <linux-kernel+bounces-886591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EEAC3606D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F79463B55
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C077E3168E5;
	Wed,  5 Nov 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="F0M5lVuL";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="TYJP8XJx"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CBD2D193C;
	Wed,  5 Nov 2025 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352498; cv=fail; b=RCE1+GmRXZTgF9VQbt61txc9CBGdpQA6kBmN67ql99mo4uCcgUAgmWjNUfFgp4W1YsDXnpRWtTNxkTdOHTWOblKtnOF4DkN8uGiTX6xjM8WNAyJjebUAFHv9nOroStCQvbvIUzMR7raA+aLbyRnaBg6uQ9l0bMPYSj9uIwixnZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352498; c=relaxed/simple;
	bh=mu8nBgoouIJ9QmkcZlo41fHvkXidhNAMdNiqFq2zcnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Av+vRkYMrdIle6AwVhwtcgZ0O5t5S/LXhS8sHrfamRsAzX0jS81JGjGobMfLOzwryJ9zNWY1YrD1mu3nO3SywnqdefYqSjeJu22U3DrpS7BjDLDsm2I4z1Ma8c0yM7yTWSJKVj8w+Wvlx/6y44iJealMJdKwndzwnCCMwUZJS3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=F0M5lVuL; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=TYJP8XJx; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A55pu4Z2013230;
	Wed, 5 Nov 2025 08:21:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=rtf7b4akYH6RBQjZuwzYaeeIqt31ScB379vnkCHxYgE=; b=
	F0M5lVuLilFpDH3v0UZYGQI/wZjK5A8j4OLYRDBMzlNBVlO2h48svqy/DNw5aIwP
	LH+2kfIB0uWR4qyTQGeD2m5uc0lsPIAkhA9O6aM6wg5pKmHeb73EMAdZg2SmSgvy
	SMOFRb/h5kH3UUES7UQTNiG5E4kKhV2GpfSvw48w9m0saO58IyevNYbPUPbRqrBL
	NflQhVhnvUsaP/7hvXqLgCYSW/kHOlYV3BY68X2eJoSwetBDHemgqxn/4lf4tq56
	oX5hocMc7iFH96XqVPTjBTDH6Jnt7g8RP71v4fad13+t8fhW75Sag4n3HsP6tu6E
	BOqMJX/XB53WbtEdVSKnBQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020079.outbound.protection.outlook.com [52.101.61.79])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4a7bwx1ygg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 08:21:35 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8ObB/yaHjgbOHcJ3Ln4rtcHCuf7HObv79vTDrd4y6OmBy4WaepRNNvAId4Db6nH27ySnMwdRV7e0zjgnuFWicPuAvDjzSuJ4GzbR+GEYAKejY0/+eqWYB9USMwnv115P/eGWlWpf8fNUl7Cw1Hj6W6lMGGRZ5D768CR4gKbPc8X1m5hr0xfbia47QVtx64aE0EkTf3QgGZIH42JiEGCI2Q4O+ZppEcpcIsiGQt19UMz90nd4prlOcHx3RvECcUoUC3BiN9ad9y+8YmhwqaWw3YDxrJsiCQsX46LHFo6jU9UwU1241/YI3Q0/U8IbTg4Lvq3NV9QPH996YNz0EBFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtf7b4akYH6RBQjZuwzYaeeIqt31ScB379vnkCHxYgE=;
 b=ZWGbYaAqmcwBED8Vh+Ht53M9nLlHvgoV/jrHblmGgaS2XDlehJd9QLhRukp4vxGcn1+2DqNpvcDWVwdYPj4GO+nawiV1PnJN69V6u2dtfIHMLfR+ZSTDpP1pKrX2QxF1/evWrWBM2RyrcAHn8JHdgow3tCbQgrKu05ocEXhexlBt84wnXQ4OhezsOXJeimaFwU+cleonCoUVElWgiheAMhfqIa/gEyrchQ+1Je8rKD0bt6HBSSZunS+uFgPODr8Io9TTsv2sNy4ynN8qJnC7elDTjx1eYwAgxak4pLPoMlVDPveDNHz+I/0C4DJOoa8mtd74vVFCANj0O/O0nYdEig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtf7b4akYH6RBQjZuwzYaeeIqt31ScB379vnkCHxYgE=;
 b=TYJP8XJxtzoZ9T0UzNX5RoMiKryCyJ3ZCItzTUTnYP4cTaDroC60Fe6PtAxaU81qssWTqNNVu4BXsrUdW1f6F3Rve4A53EB2OkfkWiU7QOaEt1IBWiULSobMgDSaqvaeO5X4YGXmmR/r+g1IHuRgove/4i/37H29A31YnUmPZSQ=
Received: from CH2PR18CA0013.namprd18.prod.outlook.com (2603:10b6:610:4f::23)
 by LV3PR19MB8367.namprd19.prod.outlook.com (2603:10b6:408:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 14:21:32 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::7f) by CH2PR18CA0013.outlook.office365.com
 (2603:10b6:610:4f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Wed,
 5 Nov 2025 14:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.6
 via Frontend Transport; Wed, 5 Nov 2025 14:21:31 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id E0229406540;
	Wed,  5 Nov 2025 14:21:30 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id D2766820257;
	Wed,  5 Nov 2025 14:21:30 +0000 (UTC)
Message-ID: <66711258-dc14-4469-bcb4-d341f4572488@opensource.cirrus.com>
Date: Wed, 5 Nov 2025 14:21:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: failed to add SPI device CSC3556 from ACPI in v6.17.x for Cirrus
 Logic CS35L56
To: Iakov Pustilnik <xyapus@gmail.com>, david.rhodes@cirrus.com
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
References: <CAHRbhAkDcYQj=VQrNdc7T7WfDfiuDWpnk2s3pjoeouptgy_K1g@mail.gmail.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <CAHRbhAkDcYQj=VQrNdc7T7WfDfiuDWpnk2s3pjoeouptgy_K1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|LV3PR19MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: d5cff05c-64b9-4aa3-1b1a-08de1c769e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|61400799027|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0Z0OGovZzI4T3lteEZ0Ry9uMXVVUkt2b25BU1RzbHhtbE1adGJCWTJMRmFw?=
 =?utf-8?B?VUdBZ0U0SW9tN1lpTG9OOFk4ejdBZ0lrVFJ4dUVqME04dmN1MkIyVmVHbzlS?=
 =?utf-8?B?RDBxTXc3d1J2VmFHOHJjWlhSemZwTExKN0RyTy8xSklDM3NsQkdtOFFXR3o3?=
 =?utf-8?B?VEdRMm1PdlpyVUJScE8wblNzR2V2cy80OHo3T3FJU0RrUnFraTg3QzcrL0hh?=
 =?utf-8?B?b082R096TGJuc051L2RlcFNVVit6OG5IcXgxdjgvQVptckRUZWJKTWRLTFho?=
 =?utf-8?B?em8wOUJyY2RqZzROTTg0V09FYkllTUd0by80N2RybU04bDMxdVpDR0pLemRq?=
 =?utf-8?B?K2xtZlpRT1ZWWWdjQkI0d2dLVmdZYy9JT3lhK1ZldnAwbHg5SVpVbFdaRndk?=
 =?utf-8?B?dWU4Vm5zNWVyM0U5ZHZOZ3M5WVh1OWZ1czZyS2RzcVpFQmJXcWV4Q1pIMUlP?=
 =?utf-8?B?aHZMOFlSZDNGMXhzeWF3S25WOXBiVXNzdmJ4RnhWY09ZRnY1NXlZRnFERkN0?=
 =?utf-8?B?Tzd4VysvRG92QjBaUHFXcWZZRHV1YklvWWVCWFNHYnNHZnc3WEVocCtPaHlZ?=
 =?utf-8?B?REZCckZoZDY0dTZObXl0WHhlejBTTEt1ZTI0ZHZWRUdTazk0dm9Kdm1mTjJq?=
 =?utf-8?B?RWJ0a1ZMRGVuRUZMd1hQOTFrZWJDM2xFY1hKWXUyNzJLRjlQTmt5YklQdTd2?=
 =?utf-8?B?WUZmRUI1eXo5M0U3dFdPc203bWp0M0p6Tk00MG9wWFEvNnF3NXJEWUhGajN3?=
 =?utf-8?B?aEUrVUwrQVpTZHh1Q0d1N05PMnd6ckE1OS9MTG1XaG5WdHB6dnhiS1F0M1dV?=
 =?utf-8?B?elBEcTJSVVFJdXlIeUtuMEVEOG51VDFpcGE0UTZSQXVwaGM2RitqenBNQnNS?=
 =?utf-8?B?UGFPR1d2VGZ5UzZKV0ViaUQyOGZHZXYvbnpJaHh5ZERLNkQ2QlNHbzgyTGk3?=
 =?utf-8?B?UzJmSHhLU1NYRWo2RWE5NTZCRERrVW44WERVRUI1Q0ZrdkUvNGFvd2VGVW4z?=
 =?utf-8?B?S3YxTHJ1UlBkZFB1c3c1RGJnOEczTzgyQWRkWlBPUjNRZUhrQnpVWE1tbGU4?=
 =?utf-8?B?UGhTN2ZaK093eE54R1psdTVYODUvOEl5Q1Y5QzBXK3gwNHJmSFZmeE1sb0JX?=
 =?utf-8?B?eThNVHZDcEpNVWhoWERyQ295K2d4QUpISGlWczVIdmZTSGlFenlYWVlpK1Yx?=
 =?utf-8?B?eGd6eFloM0FueEJVYkxpcnRSM1paWHpOTDBqeWhTQmZncmxYd0tjUHJYYWVB?=
 =?utf-8?B?UlQwQ21lNFpkSW1UUnRtRTk0L3luSjhzQ3dhZWtZSDlMWXpEaFN2OVVHY1ps?=
 =?utf-8?B?RFA2eGhLcHB4TC8rMnhmWFc1UDBCU1pIekJ5SU9UNTk1YzJXMUNkL3Z2QVBM?=
 =?utf-8?B?clExaUFrODRLeEwwWTdZbU54Q0d0WURyN3Y5K0ErWkpQSXhNZnBwSXN1cmwx?=
 =?utf-8?B?aFVXMm01WFpOdjJNNlF5ZDFiZWU4aW9FbFRLbExzUmF5OW0vL0VGWngyVXgv?=
 =?utf-8?B?TTdCemg0ZWVxVk1mZUoyQjVWSTRGelhXeThrSmk3RDlpN2p5NWJndWlwblo1?=
 =?utf-8?B?a2hKYVN3NWh6K0E2djZmZm5uVjNtdkVIblJvdklDMEhPNFNyc0hhNStNK1lN?=
 =?utf-8?B?ZUdQcWZISVp1Smp5aTdWSUFwWmlyYXU1SkUwdlhMc2o0cnlvdk9jVXV1YWVN?=
 =?utf-8?B?c1lQTmJiMjNZVllLcDJLWElFdHJQWEgxNWpGNlZDZEw1UFRwbU53Szg5b1hK?=
 =?utf-8?B?NVFZb0NnS2FlM1hVS2ZldVBYYVIvdCsvQWcyMjllYWw4T0RwU1FLb0YyVkdG?=
 =?utf-8?B?OElQVVFtZnNQRXFOSDlIYzJRQTVXOGp6MUZzRURIMDlDUk9BMk9nR09tWGhn?=
 =?utf-8?B?TjJEVmpSclNnWmEvczNrcy9SYm9NSCt5bHFQR3JSRlBYaEllVzFjYzQ0dUxP?=
 =?utf-8?B?RFFkclZTZXM5OUF5YU0xaDI2T0RqM3N3ODZhaU9FQUE5MlhwMFRPRFArQmhW?=
 =?utf-8?B?cHlCWWlzV1RtdVlNK1E3bjFkaDJaVnZFZ044czFGeloxeVNSV3Btam5VSHZH?=
 =?utf-8?B?ZEc1MHFsZXU5a1pvbW1KQXJIR1AzZ1dxK0pva0tPM0pVdG1WeS9neFNEa1FH?=
 =?utf-8?Q?M0Gw=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(61400799027)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 14:21:31.9100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cff05c-64b9-4aa3-1b1a-08de1c769e58
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8367
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEwOCBTYWx0ZWRfX6jEtPKxOL3NN
 j82X0rhuzXI6U2Nqz5HZ88+eCyfZOwbcxMVlSKaA4p50u0RkviFs20wC6xyiEVfaNua5Afq7N7I
 pPF0iiaA9TR1j9dn8AX/kfI6z4OJh0cWMi4EivrCyXuB3z8YW37SidwkmnjsBnyo2ASSiXlw51v
 YoJjqO1p/aW3CjKNF8LVCcsNes7QvI/Fu9hSkitX8cu9fhSrZTBEASd7AvAHM2LTwTyFafx9G1s
 7CaP+i3ykRcKWfPbA2en/YuYnyA/Ov6sxkTmD9XTf2IpbvA+V9uvnJEtlDU8YTf2SfYJ+FIHAUm
 nB9qI7US101wivGV0iSVKPFfOvboMAihqNpP4X4mKOa8BEtJAF/OyVF+rVFvJJngBktqu5hirYM
 VQkaD9NTZLoWpN+/jR058LDnyOVGYA==
X-Proofpoint-ORIG-GUID: 7Ol4XDM2PG-zTj2TZvxm1NhFRidpDGAu
X-Proofpoint-GUID: 7Ol4XDM2PG-zTj2TZvxm1NhFRidpDGAu
X-Authority-Analysis: v=2.4 cv=FpcIPmrq c=1 sm=1 tr=0 ts=690b5d6f cx=c_pps
 a=tlGIxjjmudfNB24gcMuLIA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=zWkPoKW7PBNjo0c95wkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Reason: safe

On 05/11/2025 2:13 pm, Iakov Pustilnik wrote:
> Hello to the Maintainers!
> 
> I'm using an Asus G16 GU605CW laptop which has a Cirrus Logic CSC3556
> audio subsystem.

Duplicate of

https://bugzilla.kernel.org/show_bug.cgi?id=220152

We have been told that Asus will release a BIOS update that includes
a fix for this. Until then, there is a workaround on that bugzilla
ticket to apply a custom SSDT to override the BIOS ACPI.

