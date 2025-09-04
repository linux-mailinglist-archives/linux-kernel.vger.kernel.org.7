Return-Path: <linux-kernel+bounces-800188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF37B43463
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B785178CDB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA1E2BDC1E;
	Thu,  4 Sep 2025 07:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="3u8EkE8i";
	dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b="jSf92e6L"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD9029E0F6;
	Thu,  4 Sep 2025 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971673; cv=fail; b=pO1NE6B7yiJN8+CYPSvTAPuIYU4lVvQSTywbYW3PJ5nVafyLGVIt58m0e48plKNY+DfXvG47atP15I5XzdU2eT/f8+VPo1HhuKRQhjkuY9ckSjWeObyDnyUqF9mKbfBjxNrmXDpePaV3HLy4XVS4yj+2k9BBtVAX+9sMwRpTgII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971673; c=relaxed/simple;
	bh=bXWjibzgESXHxUbmE3TpQvDUmOoOT1sjw2JXGWihGoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EYUBm10GYUWs2P1MXL1jjXZ+raNWs96FxMh7fed5N6XdKmCqN86aymnxUrhZM90gE2hpULZO+SePiNvDCwGysOhwZOM3UxM43mr8vXjDfAHpMj+WgjL62LaGJUmB8Eq3jrv6IVSp7uoiWKqNcJ6xpbGdZITB+W2j7kTy3secxE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=3u8EkE8i; dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b=jSf92e6L; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5846kZf5003278;
	Thu, 4 Sep 2025 09:40:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	v2NjFXRPIYRIzUqjKHQMJWi908tf+3SkM8Vn3J6902g=; b=3u8EkE8iMCPWm2gs
	7kKpY0JL2KpeRqkSLlKowTiBllu+kWMdk7jU3BSMhyI97fGtRr0VXzalLXnxA2j5
	UGcRs2/kAh37FHUw8TFnjKVP6mnkoCih/m/HxYTsz4V4YTCGzA7U26oHXLzLqXQO
	gIeTLk+umh500j0yEe+/72CjM8X9982YxIvEzKnhn0hoJIYvE4ikT8+Pj8eczi7t
	q1uGTymumbc7UumEQWbrcwbOSy9Pu6ArC2/ALEkybZEYjALeZOMkpoRmWLFG9WEN
	mZhSrZLJXkU0g9H5Xzd68R9NVLIQz3cAwePN1EGhOdLoxVoLZ5oR801gyGliCCSh
	w3ITVw==
Received: from mrwpr03cu001.outbound.protection.outlook.com (mail-francesouthazon11011046.outbound.protection.outlook.com [40.107.130.46])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48urmxmmh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 09:40:58 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AX2dC80WR+YAPUN942IUa5UkfsNKFBXSSXoAnE9nJeuVkN4GeKAJrKh7315B/8a6C/CuruDrF8ZOSOETszImvd+4X/qRfl+XqCVTogWWqGn5NaUj8k/BmQC80XGdL/fFOdUB2k7vVr3aEQrKIh6yQYzao3qEn1WEnopMiwhQmZryDjEoAZv+8f7DMeqhdQ62ZA0PM+kDmaf6y5org218n7OLAn7Rf4CKa1E58KUUGN+zi1qMyqmMbNATM3rfOA9Row5U2kTBNyce0mthQENU2+rha7jWnvjxZkCjksLzYFv8NUyStNrb+p1MoO49hYQk4Na5p/12h/b+tepgxi+MOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2NjFXRPIYRIzUqjKHQMJWi908tf+3SkM8Vn3J6902g=;
 b=SlMRd44orDYVMQUitsLHibcAq5HYiw+Fs91tppAEWtTa0xJRE0spRN/xY6x2HoaQ/JS8c7lKGjhKDTVzAB6gKHsFj6JOC+wFAHhebQgvDvYUtd4sIVE/331gW/mliUMpCmafjMKB9S3Z7wUPs7cs4+NwYqFOR3SUDJ9PqPEyU/bWMDxwtmESXLN/axAuP0Dju2zKLt62IbwbORDjzv4O7821IPnlSEvizGx0tCCgY9JCSPdXk6hekKL5S6RdxiQMk0jyUKB/1cwn8i+NdVud1uhT+tqQHLgbbXem42WXc19fjj2cpV1AYyfOhPiLhBgVkeS0MwgHJRWDcpb4Iy9UoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stmicroelectronics.onmicrosoft.com;
 s=selector2-stmicroelectronics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2NjFXRPIYRIzUqjKHQMJWi908tf+3SkM8Vn3J6902g=;
 b=jSf92e6LVmIunvnkYxLTpBL9gL6jX53BDHE0Osq4ujAxmskeiisc23jssO4NN5O3D07iz43aT9vazDGfzJzgQdGAYoRSt8+8gPFPp4qzSU6C0+GeJG1lhSDMSKsiVM3nWmke4a+dbivNPcN3M6eQPdVBQtVD+vgNsfZucgQ2njc=
Received: from DB7PR05CA0053.eurprd05.prod.outlook.com (2603:10a6:10:2e::30)
 by VI0PR10MB9335.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:2ad::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 07:40:55 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:2e:cafe::16) by DB7PR05CA0053.outlook.office365.com
 (2603:10a6:10:2e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Thu,
 4 Sep 2025 07:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 07:40:55 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 4 Sep
 2025 09:38:36 +0200
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 4 Sep
 2025 09:40:53 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Thu, 4 Sep 2025 09:40:57 +0200
Subject: [PATCH v2 2/4] arm64: dts: st: enable ethernet1 controller on
 stm32mp257f-dk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250904-mp2_ethernet-v2-2-05a060157fb7@foss.st.com>
References: <20250904-mp2_ethernet-v2-0-05a060157fb7@foss.st.com>
In-Reply-To: <20250904-mp2_ethernet-v2-0-05a060157fb7@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|VI0PR10MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0f95d9-d93a-4fb2-4381-08ddeb8661d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UExsTExRNkpmS0k1TlRmTzFucTl4QWpXbS9rSDVkYWdGNStGcEl1d1NnSDcx?=
 =?utf-8?B?bUhkQ2luakx5NUhrV29FMURET2JwcEdPMU1RNHh5ZUhxdExZRjhyMWh4S3dT?=
 =?utf-8?B?K2dKY0FCdkdzVERGUFYyN1I1ZzlKd0NTT1MvZmp4V1dOYjFsUTJaL1lpVUR1?=
 =?utf-8?B?b00xOFFNWGY3NC96dDVudjlSVWVETjgwUk1OdXYxbldTTkZUNVNUd0RHTlA4?=
 =?utf-8?B?K1BTWFgrLzMrTTFpSW9RTXhGdGRpaEpvT0kzWDNibm9GSklpWTFpUkRzSWlT?=
 =?utf-8?B?WHl5NEJzV0FTOHhEYzJEUXhtVS9COCtzTzhGMzdRUS81c2hFZnZpZlVXMkdY?=
 =?utf-8?B?ZXg1bmM3RkYvaWc2Nk5UeUx6NnJtZFdPQ2tBcGJiWm15RS8vZnNPOUhPdjRq?=
 =?utf-8?B?MVFxUHR2M2lIL2QyZXc3dVIrSmpGMDJ3aG9WTXZSRGhsMFZ0ZHB3ZkNJT1Na?=
 =?utf-8?B?TGtSd1lzaWlEVHZqUlhNbjFLeGFYVTdRZVl5T1RJVkZ1TjI3SG96djVFN2Fk?=
 =?utf-8?B?NnI1Y3FDWXluVGROU2FMczVDLzBya0pVSzlSOGcrVG90SHNxclNHN1hTWXBi?=
 =?utf-8?B?WWduWXg5THQxSUFJQ0FpMSs4aTQ5MnBkUFdjb3dITitIbURhQ2ZSQ1NGQ1VN?=
 =?utf-8?B?WnI1aUJTTzBhMThLSjFJS1NrcWR2NmsxeTdycHNaN0RBOEhuMTRrUHlzM2No?=
 =?utf-8?B?SnBET0JSS0FiemVzL3dldXUrc3RDYmFzQXluRmpIMnc2WXhlc2VRSHlQdXlk?=
 =?utf-8?B?MmVTQ2JPaGgxbTZ1clVsbEF6Sm5ZVFZCNGNkOU9lamhmYjFmY1pLWlA4aC9j?=
 =?utf-8?B?eGpDandvQW5oUGtkMWZINnltTkFDWFBMaS9NOHJhSkllNTVmdi9BelQ2VFli?=
 =?utf-8?B?STlBUFhwVWp2bnlPUzU1Tyt5OUJFK01tN1ZCZVBBZy9TM3RTWGdDeC9nVkY0?=
 =?utf-8?B?TEhhQ0FFTFNLOVEyU1BDSzJyMFVzdEg3MTcrM2hmWldHM3ZnaGdPZEdSdnBX?=
 =?utf-8?B?Vy9lMUwydnhScFFta0RRcm40UHRib0JNOGxibjJ0ZWRQOGE2VGpEeWFpbjFN?=
 =?utf-8?B?RmVKeG50LzNpSzdGSWIvdDMyQnBMcmE1Rzk0N0huU2Z1SU8vbldHLzhVOU05?=
 =?utf-8?B?UTZLWjNaa3podVl0Y2RHMG5YVm1yWjBzMHlIMHRXYkRSeTY0OTFZYVdGRWVk?=
 =?utf-8?B?RXNWaE5xU0o1OERGeHN0SnZHcm5MVG03NUdPWTBwb1VvZldNS0tXV3E3ZW5k?=
 =?utf-8?B?allmaHg1ZHkyeW1tQnNWbmhVc3VBRWhiS3ZkbXZGbnRPU1dyeFBzVk14QlBX?=
 =?utf-8?B?amd3NXRKTXZ1MCtncVRIVDdLT3BHZ3R6NGlMcjdINCs1Wkh5emE2dU1vR2pC?=
 =?utf-8?B?cERvUGtoTmMxRGszczMxYkRlRUNpRUk1ZjBSNXhGQVVTTEdOZGhVZHd4WFdv?=
 =?utf-8?B?bjFUcUFnUGNaTXFEeXhzNTRZN2htSmwrdmpnc3MyaWpoRHlCSVRrdTh2TVZu?=
 =?utf-8?B?a09kd2pFd0hMSDdla1JmUkRnUCt6ZUZINDc4RTdGcmxJUm5GSEx0N3dBb09X?=
 =?utf-8?B?QjJkYnhGa3FXN05QYk16b1lFVzVDTWVCVE52OE02YUloU3ArZE9aTldOdVhN?=
 =?utf-8?B?UDR0SGxZa1VidUVwU21sdjBIZ1IrT2NpSTFWRHRnZTJNM1haNlovYnFOTjN0?=
 =?utf-8?B?NElHL29BSktGMndwNXVOSFdlejFXTVI4a3ZUNWV2emlRd3BVRzNkU2dFSE9P?=
 =?utf-8?B?QmFWd2VwZjZSM0ovQlNNS1gyb0hGK0ZLdG5IeXJhWGdxQ3Q0b3JESWtTeXFC?=
 =?utf-8?B?Ukc4enQxaTdCc2YwRmtCdEtocCtYNWltQ1QrL1k4V2FMblhGT0tuN3FSUW96?=
 =?utf-8?B?YzI5K1pTaDcxTXdHVGE3REJXVVo3V1hreWhXK3Y0dzdoNnhUSWdkQVN5blIr?=
 =?utf-8?B?NkgyZEpFZ2IxbFJwTXpKeUFDYlpiWHhhZG1Ya0pIN0tHQXoxYjdXMnBaMU5M?=
 =?utf-8?B?dFpCeG16cXZoSmlHdWM3UHNJaFM0NW9HdnFXc0V1UlVYRUQ5U094ZStWTlpu?=
 =?utf-8?Q?i4AeiJ?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 07:40:55.4870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0f95d9-d93a-4fb2-4381-08ddeb8661d6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9335
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNSBTYWx0ZWRfX4IdTqFwk6sqR FoFRyPVZ0NL6ZpxXHakq04kYeoVoLRp60mSWFoap2VTGauWjkOIueH1+h95rZ/GZOIkdoReJJB1 +06PVLRX/JYB+SiliADgQqStkj5sw+lzGwQ0/Rpexo3PocImVbnvWK6mjbcSTncrqLm2Hwy4z7e
 UAxER8b1Gk8xMObFJYUHTZeV2HPpERZp0w8PloOQcOX+SPukAqZ29mZKe2JV6gUoFT5m4kkhVug y3mLczliyvsYDz+QAhS++JECB/urYzZ3twj88drCbJky7HbmBdk9v8DXW7Ptdo4aWMCmTTcHrUB iOgITeXM/jCnW13ZDCBD87mC/wCyK98t6DRORMyvsX2gvOwVN/BSZIS2JuOaMxoYTTg+44nlQSj RAwBIy3x
X-Authority-Analysis: v=2.4 cv=dqLbC0g4 c=1 sm=1 tr=0 ts=68b9428a cx=c_pps a=Kx/ru3W+vGGB7AfD4Pa2Qw==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ei1tl_lDKmQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=FUbXzq8tPBIA:10 a=8b9GpE9nAAAA:8 a=dXDWfB-bZQmw5_4NNMkA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: q6RyGvfgEN8a7wCXhNXrNGqb7ZhPNgMT
X-Proofpoint-GUID: q6RyGvfgEN8a7wCXhNXrNGqb7ZhPNgMT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 suspectscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 spamscore=0 clxscore=1011 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300025

ethernet1 controller is connected to the RTL8211F-CG Realtek PHY in
RGMII mode. Enable this peripheral on the stm32mp257f-dk board.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
index a278a1e3ce03aa379d40ef807d268bbf31a04546..e718d888ce21b6f124331543c09c1e66e6304964 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
@@ -19,6 +19,7 @@ / {
 	compatible = "st,stm32mp257f-dk", "st,stm32mp257";
 
 	aliases {
+		ethernet0 = &ethernet1;
 		serial0 = &usart2;
 	};
 
@@ -77,6 +78,28 @@ &arm_wdt {
 	status = "okay";
 };
 
+&ethernet1 {
+	pinctrl-0 = <&eth1_rgmii_pins_b>;
+	pinctrl-1 = <&eth1_rgmii_sleep_pins_b>;
+	pinctrl-names = "default", "sleep";
+	phy-handle = <&phy1_eth1>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		phy1_eth1: ethernet-phy@1 {
+			compatible = "ethernet-phy-id001c.c916";
+			reg = <1>;
+			reset-gpios =  <&gpioa 2 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <80000>;
+		};
+	};
+};
+
 &scmi_regu {
 	scmi_vddio1: regulator@0 {
 		regulator-min-microvolt = <1800000>;

-- 
2.25.1


