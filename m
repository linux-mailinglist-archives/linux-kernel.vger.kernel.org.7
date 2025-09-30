Return-Path: <linux-kernel+bounces-837464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE63BAC5F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DD3E7A2513
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43A12F549D;
	Tue, 30 Sep 2025 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="UxS9X5NQ"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0742F23B62C;
	Tue, 30 Sep 2025 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759226126; cv=fail; b=RsSTSPhsn8expKOvtownV/FV9lHTED7vE5ENJ0Kei0k7i7uYz4ax5FgwCxr6ShQfYoMQxmFdegs2VCxLvoPOAZK7C1TqYakqcOp93AhOHPo1iphwtVypTwRWfhuXEjOZQhiuSeV/Jw9m7w1LeXP9wMlTuIigVaGksGrseMgEGLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759226126; c=relaxed/simple;
	bh=j7w1k7UneTAIUlssQnUyRJk9R6CIhKVfZzfOjBfxsdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eQrufTmIIa8JxguYJJFCG4d4MElCL2r3qnN3cp60tBw5alWScIYEp1veNdd2TdLft+SNOO4KcOtYG6U6V4iWljcVTH6af3iM+fTKWcd2TxrcV4P7owGPgBNMDzpgREd02xso5c7aEGjXIV1mj/cZSTMfkzoHeZfnBML4HLEzf3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=UxS9X5NQ; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U9k42l003259;
	Tue, 30 Sep 2025 11:54:58 +0200
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11010043.outbound.protection.outlook.com [52.101.84.43])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 49e524b3qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 11:54:58 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hcca34owKyO1Y15NlyZq0yYp5KQOJCCDhfsgdKjbq6avEntBA78AXBNB7NIbHKQEnFtCXIUKbrU7+cCwf6Os3+B/AiuwEhwQa3AoGXlkR3yvz2MoJ6C/mkqigtsO8g3Ic21nzkN0A2rDrjJBLIZJhelqYba05ix4yOjHGnWfsaBDsGfap66Uu/0I3ukp9u93dVWDMwabJF8exr45wLHd03CLMoOFEqlUMj3P41P4+Zpny48K94EEMNNtTrugbnhpekmhfXS6T/qwMW9y6GesdTL3ywlClKaIQc2PAe3cx9XK2pzSk+5AMcN+0DcC0+MuqjnyxyG2RfsttFx/ogskLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICPQnJcxjTGGYfv6Dy9nKyUegKFelqGY/JtMdJA/fVQ=;
 b=lbXruHfTiYBqzgreGr9jynF05ih2Bgqox+BLmxEo+7CYLn1F124rGbzkj5f7o+q0+biYigkewT7BOu587y0QXXpbp6U+mPaBHHjueZDpvJZbYEoAfhE/TVWJ7/bq5VlDmKlJ7lNjWKPxWbrH7XN/naiXcDDIlUou1fAO1j9Gpz5DOanUI77PNRbbtyeJSJ3ey1Ua+7pLGeD1ABIPjcSnlcq+i2h0+PIAr3r404u21AT+XXUBnSlFSx+mNQc6fzh3TuAaXGTIoatZAxOvgDw/W2EBMWuEPdni0RbyxNa9W1sCZdBGVJD+37WIeRsOzLP6sflYOVwP12pfWzdd2BRmbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICPQnJcxjTGGYfv6Dy9nKyUegKFelqGY/JtMdJA/fVQ=;
 b=UxS9X5NQ2+30VaOU/mDyqQhaeIBHlENxzHHG9myAStgCMyCW5fWGqp0mtiGNt+8E3UWj0fG7m55h0915AZxHSXif9GDeAbSw6SYje9Sm0nvm0GY4G1cQx4FCH/ZhxyIHGohXgHV7e6yG4/CZjsNQM5Nu3lEXjRsjAz+YMh2Way/9kCRK/BRTnErh0zDGFLDHkDBQEmoHrXgGSzAKk5lMF0o1xpSpCQr4YZFmhMgI4lAr1n4l2XEhbee2hH6MFCpikMRDC1OCk8bkfpCoXdSIGelJ+E6cjPNT+GJU3DWfZ3tQGufVAdAOwnoaVNnxLYwL9eCqTCZZBESIYdPHL3NE8A==
Received: from AS4P192CA0039.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::20)
 by AM0PR10MB3330.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 09:54:56 +0000
Received: from AM3PEPF0000A795.eurprd04.prod.outlook.com
 (2603:10a6:20b:658:cafe::d5) by AS4P192CA0039.outlook.office365.com
 (2603:10a6:20b:658::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Tue,
 30 Sep 2025 09:54:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 AM3PEPF0000A795.mail.protection.outlook.com (10.167.16.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 09:54:54 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 30 Sep
 2025 11:52:37 +0200
Received: from [10.252.12.194] (10.252.12.194) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 30 Sep
 2025 11:54:53 +0200
Message-ID: <9852fdbf-c4bc-4087-a5c4-e65c3fefb724@foss.st.com>
Date: Tue, 30 Sep 2025 11:54:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] clk: stm32mp25: add firewall grant_access ops
To: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>,
        "Michael
 Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
References: <20250924-b4-rcc-upstream-v8-0-b32d46f71a38@gmail.com>
 <20250924-b4-rcc-upstream-v8-2-b32d46f71a38@gmail.com>
Content-Language: en-US
From: Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
In-Reply-To: <20250924-b4-rcc-upstream-v8-2-b32d46f71a38@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A795:EE_|AM0PR10MB3330:EE_
X-MS-Office365-Filtering-Correlation-Id: 66dd6a06-e27a-46b9-3693-08de0007684c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUJJZXRiR0paWGl2SFMzOFJZLyttNXpsL0JjdnRQQTZxQUZ2K05oQ0JuSUIx?=
 =?utf-8?B?NjZPTEg5c0g5QjcxeWF6Sm1xM29oU2RGdGRXVUxUbW5nTVQ5dU5iSG5PNlIx?=
 =?utf-8?B?Y3RVeUxyWEJlU2tsdUZ5VnpleUEwUDNVK0dCcU9HZ3dBdTZ6T0oxZ1M0RWRQ?=
 =?utf-8?B?M1dnbWd5anRkZlB0UW1tS3V2bE1TTWJ3cU5EblZvajc5RisxRVpsR3lYYndE?=
 =?utf-8?B?cndoM2hnNFRrbDFhR3crOTJhM05kWjlXaytmeWVSRDROLzZxbFFta245WEhE?=
 =?utf-8?B?bHpmenIzT1RabW5KZlBxR0lONkcyMDJLNEw3US9PaWJ0UUxFd1RDZ2c4ZHY1?=
 =?utf-8?B?UHFteU9TSnAxVlpsREQ3V28xekNiYnVtSDdwQjVJcGdaNmZ3UnM0bURMSWpQ?=
 =?utf-8?B?WjVJeEJMY0pTdGIya1ZDME5nMFprd285eDRqMWJjQUUvK09reVdtbFBKeVZC?=
 =?utf-8?B?SjlubmtjT2NIeUluRCtrUlA4M1dIREIzMmE4bm5EdlQ3YzVrSmhrQkNCaXo3?=
 =?utf-8?B?dWhLdCt0S0hXNFI4V3pFMSs5V21RVlFaNGJvK1pGOVVmR2NENHFoRVdNc0hT?=
 =?utf-8?B?Zm9zR09uWno1aUQ0SDBqRUN2NlE4SS9BZk1lSHFyV1h1NFZpUzkzUmNjSUhx?=
 =?utf-8?B?UGdFVE1ZS3NnOXR0bVJVdlZlelJicE9wSHdNMm02QklmVUw0NUdIMGJNNzVV?=
 =?utf-8?B?VHc5cTV3Sjh2QTZsRWxmQndEVVF0MUZ6ek0rWGJHeFdxSFBBbW12elpxZ28v?=
 =?utf-8?B?aW1nYzlZWS9xOFlRQ0krbVhMTVluajRKZk5neEdJNjlNaHlIVlI3ejM3Y0xC?=
 =?utf-8?B?dWI3RjRaZG16Z3lxYzJ6ME1mYXFXSDlIaFUzMGp1LzRzc0ZyMllJUTJZYUNj?=
 =?utf-8?B?dWxlR3pTMy9vdDJ3Z0VoU1BrVkMrWFB0QjRhYWRCWkNKQzIzOVBCR2xSVWJo?=
 =?utf-8?B?anFzOHBPSVdTV005UkxpUk1UTnNLOHJBTGF4aGpwZDNUS1JwbGVGcTc4eTdj?=
 =?utf-8?B?MmtLbXZBbExVNklzSEdYQkY1Q0VtNFpMakpzaHlhaWxXMGFoenRjTkN0dnda?=
 =?utf-8?B?NGlxR3Q1Q3M3eGZVUW01Q1d1T09ubSt3eXVCNXBGVmM1SFh2MjRNOVZ1L0tE?=
 =?utf-8?B?MGZtNHZRQmZJZ3JudEZtWWpUSGZhTzBTaUoyNGVDOU1ZZzJJZ1RMOFFkSEts?=
 =?utf-8?B?Y0kvc2tNaWxJZjVTaVZoSFFmMEwzMWkwYW9MM2F4c2VVeDc3NnRTc0FtYjJq?=
 =?utf-8?B?MlBrRWlnTDRIOXBibVdMaTBCRzVvOVkyNVJJeTZydG91amVCRS80N3YxUWhk?=
 =?utf-8?B?MGVvTDZLdWxqSWQwYzFPbkR0NUQ5dmxsQnpVM29PWVNYckJsemdTMXhBSnR3?=
 =?utf-8?B?YzgydzJrazdzS1IwQ2pISjFyS0JhTnM4NU5VQ1ZKV1I4MUtxek1BbHNKcTlk?=
 =?utf-8?B?NzJnVnBvVEo3K2pBeGZ2WEtRUXNzcDViMEVPYXJVUkp1d1FYS3BoYVpkWklE?=
 =?utf-8?B?RTlCMGRJY0tFWTBoRjlwYVVHTXk5NHdZR1N0ZUMrOUNZbkQ5cS83L3hNNUYw?=
 =?utf-8?B?a0JKTC9rVEtyT2t3VXRYUzNPU0RZTVdPbG5QZHR0aW9ycjhGQitxRTNHQ3FG?=
 =?utf-8?B?ektiVGkvTkg1ZmlnMnphNGgvQXFqN0R4UXRUcngrd0FsU085eEY3M2s2MEoy?=
 =?utf-8?B?RWhNRC8rL2M5UTRJakpHS3JlL1U3dHVsdEJJdkc5c2VKV0hRdXR5dEJGUDZQ?=
 =?utf-8?B?U1B4ckd1TExIOVJHQ3dnYVZqSk9oVTY1M2pZS3RGdDlWWmVjbUcrRHFvWFNs?=
 =?utf-8?B?TFVkTm5saG9BeGRZaytLQTVLc2tDdDc5TVNEODEzNE5jL3VoNlV1ZnlWa0Q2?=
 =?utf-8?B?V0F3SVNYZTFqRVM1MnBJSjFoY0cwVlV5RFYwRFd4SUo1ZnUvMDZlMXl5N3pl?=
 =?utf-8?B?QUU5MEVySVRjKzdVOFVPdEg1empQZk9yZXMvRzY4Y2t0ZHZVN1BxNmZxbWRn?=
 =?utf-8?B?RmhtRjJyMG1WVnd0RUdEYVpub1NtSURmZVdQRlFqamcvdzhkdmFQOStWZlI4?=
 =?utf-8?B?Mmk4dHZwSXV1Y0IyaW9BVktXVnNNckEzd0JoTGg2ckxRemx2aTRCQlg0NHdm?=
 =?utf-8?Q?wo7E=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 09:54:54.6934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66dd6a06-e27a-46b9-3693-08de0007684c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3330
X-Authority-Analysis: v=2.4 cv=HqN72kTS c=1 sm=1 tr=0 ts=68dba8f2 cx=c_pps a=+6CRCh6JdYl0EMJOUlbVVg==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=0JIAMnr-4CwA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=8b9GpE9nAAAA:8 a=pGLkceISAAAA:8 a=aT3F-kPXq-byaCpL_MkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: y0PRR6viJRZ3lNQUqc1dBD8BWsxuqxMX
X-Proofpoint-ORIG-GUID: y0PRR6viJRZ3lNQUqc1dBD8BWsxuqxMX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDIxNiBTYWx0ZWRfXxAJBZ1D5DvHh 8HisLaVf/eXv++wUuyJ6Enz5/fjXquk9Wk+VWGlAmpTLZazzAJp0tM8CRSTQehaxSEoCxjBfRRP ILffaiOwfScDU9MyQyZQTCVCUb0yF3hkBtJ7Ar/PvSFZIVLcm8q7ENrdpCKA8gnpTf+iAA0438Z
 3QP6rELqdcpNEvbbpDEhuJhzKn6i0XOQFRkZe9q8BWSLLQ2gQotZnvwAikbbigzs2vZFmMmGNwz L2vnQHspa/RQkECOXk39ysclSgVf8x63JKDXnT+HeETwx9/YW+F+eVYb73gi2Xr/MRJufw0rjQ0 Kfj7Y2ZxvEOkYBY/fmGt/7Rgb89oc3gntObC4SRJq73U4fpLi8NIEACW7oUbwZzQJ2IGQmUb1fK
 xE2q7EKAjK9upMU0VcV41HkGjBB9Aw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509260216


On 9/24/25 11:44, Clément Le Goffic wrote:
> From: Clément Le Goffic <clement.legoffic@foss.st.com>
>
> On STM32MP25, the RCC peripheral manages the secure level of resources
> that are used by other devices such as clocks.
> Declare this peripheral as a firewall controller.
>
> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
> Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
> ---

Hi Clément,

You can add

Reviewed-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Many Thanks!


>   drivers/clk/stm32/clk-stm32mp25.c | 40 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/stm32/clk-stm32mp25.c b/drivers/clk/stm32/clk-stm32mp25.c
> index 52f0e8a12926..af4bc06d703a 100644
> --- a/drivers/clk/stm32/clk-stm32mp25.c
> +++ b/drivers/clk/stm32/clk-stm32mp25.c
> @@ -4,8 +4,10 @@
>    * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STMicroelectronics.
>    */
>   
> +#include <linux/bus/stm32_firewall.h>
>   #include <linux/bus/stm32_firewall_device.h>
>   #include <linux/clk-provider.h>
> +#include <linux/device.h>
>   #include <linux/io.h>
>   #include <linux/platform_device.h>
>   
> @@ -1602,6 +1604,11 @@ static int stm32_rcc_get_access(void __iomem *base, u32 index)
>   	return 0;
>   }
>   
> +static int stm32mp25_rcc_grant_access(struct stm32_firewall_controller *ctrl, u32 firewall_id)
> +{
> +	return stm32_rcc_get_access(ctrl->mmio, firewall_id);
> +}
> +
>   static int stm32mp25_check_security(struct device_node *np, void __iomem *base,
>   				    const struct clock_config *cfg)
>   {
> @@ -1970,6 +1977,7 @@ MODULE_DEVICE_TABLE(of, stm32mp25_match_data);
>   
>   static int stm32mp25_rcc_clocks_probe(struct platform_device *pdev)
>   {
> +	struct stm32_firewall_controller *rcc_controller;
>   	struct device *dev = &pdev->dev;
>   	void __iomem *base;
>   	int ret;
> @@ -1982,7 +1990,36 @@ static int stm32mp25_rcc_clocks_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> -	return stm32_rcc_init(dev, stm32mp25_match_data, base);
> +	ret = stm32_rcc_init(dev, stm32mp25_match_data, base);
> +	if (ret)
> +		return ret;
> +
> +	rcc_controller = devm_kzalloc(&pdev->dev, sizeof(*rcc_controller), GFP_KERNEL);
> +	if (!rcc_controller)
> +		return -ENOMEM;
> +
> +	rcc_controller->dev = dev;
> +	rcc_controller->mmio = base;
> +	rcc_controller->name = dev_driver_string(dev);
> +	rcc_controller->type = STM32_PERIPHERAL_FIREWALL;
> +	rcc_controller->grant_access = stm32mp25_rcc_grant_access;
> +
> +	platform_set_drvdata(pdev, rcc_controller);
> +
> +	ret = stm32_firewall_controller_register(rcc_controller);
> +	if (ret) {
> +		dev_err(dev, "Couldn't register as a firewall controller: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void stm32mp25_rcc_clocks_remove(struct platform_device *pdev)
> +{
> +	struct stm32_firewall_controller *rcc_controller = platform_get_drvdata(pdev);
> +
> +	stm32_firewall_controller_unregister(rcc_controller);
>   }
>   
>   static struct platform_driver stm32mp25_rcc_clocks_driver = {
> @@ -1991,6 +2028,7 @@ static struct platform_driver stm32mp25_rcc_clocks_driver = {
>   		.of_match_table = stm32mp25_match_data,
>   	},
>   	.probe = stm32mp25_rcc_clocks_probe,
> +	.remove = stm32mp25_rcc_clocks_remove,
>   };
>   
>   static int __init stm32mp25_clocks_init(void)
>

