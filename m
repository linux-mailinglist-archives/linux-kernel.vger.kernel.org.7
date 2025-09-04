Return-Path: <linux-kernel+bounces-800190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58890B43467
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE904189EED5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF6F2BE652;
	Thu,  4 Sep 2025 07:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="wFYy9Iz/";
	dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b="Qdppk4DB"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748512BD030;
	Thu,  4 Sep 2025 07:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971675; cv=fail; b=iHTh0pPhGZgqT2kus8rp53LSmoNr7qT618mQqanTQ8eBLa5MmrinRYga7NTKtrq26BTanJFum1xZrns3c4JAJ/jvcyrSmx1T/tX6A3ra+XviYc6yNZW/CoAJ5C46QfqZ711MgMcjBNZ0xs+lS1iwIi/9og3IY0iSS1SpATSEuZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971675; c=relaxed/simple;
	bh=L664iqPNlgLYLxIs3zphC/cE2KDBB8pXoUz0BWkpItc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=mRzI0zYAsmtPARCrVw02xDZTxL7wn/iRdmxSA2OebVy5hsa7IRczQuWDnz64z24iIpjLL3hpheqwK5Bb9/icNMi3vc/4wE+8SAhm8429pnRYDk6/WnHuCr04lTVRYsfR/D2eUwvNV1otMDUtBAOjdkbVCL8AZAQ6Fi6idYQF76M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=wFYy9Iz/; dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b=Qdppk4DB; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5847ddvA017389;
	Thu, 4 Sep 2025 09:41:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=+jyhNBX2mIJcMnuXJWot8l
	/o05Q34ZnL61rpXNWH1b4=; b=wFYy9Iz/MCXefOZqWqdFFhEUufG0E2RSN8GJRl
	JT3xD8UFABAcIDDCmAYgJsUPGLHCDhabcrm9cCBw3fXupf0teNtdETxXKh8VTlA3
	+hEA/8TRWzG1j3N2Gx39Y05bbxTU7ru+e4q9W48PE/RoKK6LIglD/RE4Eoj3Blor
	G6GlJvxpyyfdrlGPL4RXrN4csBijRTmvdUFz5l+BCSPwK4uE3+MHRUIG3t3c+YMT
	p1rRCjrMdhGFg1Cw6J4UMny1kMj6wUVyckoLle50uwIFadZDkacOUfFbcfb3jQP/
	1Ul2GJ3gRS5e7wJaPmjI5jmQHfjex/pFfnubeceCaqwCGX5Q==
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012069.outbound.protection.outlook.com [52.101.66.69])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48upe7m800-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 09:41:01 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvSAwELy9eDoTX+046bEQTONnrXwAftcb/y0ohj10G/bOiGBJKH0pNXNF6Zy1AXbzczd9WrrQ5UAE0gsLISR5PHtdTwaZwo0AA9dVwcA/TLQhuUX6/ShadVrA7z6MymyRWTPRmTEoTccHM6Qc/8gd0hT2pNld9T/SUH5o1M5qAjFaBFEyOKLKOlzgoXp0hV/AjIqzQT3csxSXVYRXATAynSGlcxkz+OdCsMxlx16ex/mnmhIms1CL04eA97Kv0FDZHlpyDjK0/Ipcm55Dgr6tToS49dqVmfCdqnuYZyQDb5bc0Gcvt4Yo2daqVoE0lSuUBWZcE+8C75/Vic/tuuOXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jyhNBX2mIJcMnuXJWot8l/o05Q34ZnL61rpXNWH1b4=;
 b=Z5hCn7C2j9f8x4NX7Cl6wBe2qxkfcObFxbBrlTYe9NfPfhIRdOzXDF9gK4tQFx5Dab48ryC26gaibZW3PTyIKQlEdPTfCaDz982db4X5Gv0Is1dMwFIc1ES13j5m1QkPhkdYoTTK7XsXOdaeNv/MxUsvZy/HHn0XZ+tTK9YFJ6Qo6DdSiJcrQtGnisPC0CizwpkrfbKtnc/5iUiAkw+JSoEIqI7iOB2Zdob26/LwxsaMHqDsjzJtdZhp5kA1Cl2megUPoNyAHJpFCtq2gN6GAwN6YvsLKLrztCu1Lst6ObgJqUTv3xiaqelfoD1S9jj5oMIXJLaGgX9pbtM5N2pwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stmicroelectronics.onmicrosoft.com;
 s=selector2-stmicroelectronics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jyhNBX2mIJcMnuXJWot8l/o05Q34ZnL61rpXNWH1b4=;
 b=Qdppk4DB9PXJ3IuKqjuV/qCriXlkEwSLOwebvqE3+J9woGcB+av2BrFShWf76vMGKrfkHlc4YV+bIbZxdR/KWhIH6Di5HcyfMV7Aid7DOhPpz3cR4JCZHGArPQx3wKerliCcrnOSyJkalym/pmmlBICXzwcmfZteVhIeo2ahB1s=
Received: from DB7PR05CA0068.eurprd05.prod.outlook.com (2603:10a6:10:2e::45)
 by GV1PR10MB6393.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:85::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 07:40:54 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:2e:cafe::20) by DB7PR05CA0068.outlook.office365.com
 (2603:10a6:10:2e::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Thu,
 4 Sep 2025 07:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 07:40:53 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 4 Sep
 2025 09:38:34 +0200
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 4 Sep
 2025 09:40:52 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Subject: [PATCH v2 0/4] arm64: dts: st: add ethernet1 controller support on
 stm32mp23/25 boards
Date: Thu, 4 Sep 2025 09:40:55 +0200
Message-ID: <20250904-mp2_ethernet-v2-0-05a060157fb7@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIdCuWgC/1XMQQqDMBCF4avIrBsZo9KmK+9RpFgzabIwkUyQF
 sndmwpddPk/eN8OTNERw7XaIdLm2AVfQp4qmO3knyScLg0SZY8KpVhWeadkKXpKQp211oQXo7C
 FclkjGfc6uNtY2jpOIb4PfWu+6w9q/6GtESi6BvsHTlq2XTeYwFxzquewwJhz/gCnd/1fqgAAA
 A==
X-Change-ID: 20250902-mp2_ethernet-97ddde08f903
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|GV1PR10MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c35c5e6-8bda-4c3c-bcee-08ddeb8660a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEgwckR0WUlqWmNyaFI2SWsxQ3V0NDVndy9oRHZGWjlVa0pBRDZRV3JseXZt?=
 =?utf-8?B?elRHMDBQTFRkQ29CdTN1UDFSc0dBb3hYUXJkcXdxN2xWZ0dVTzk0MXNUVFhx?=
 =?utf-8?B?SUo2ZmRVaXBnYTNTOWY4ekt1a3lSZHROVTVSOTArRk0wK1FGQzVPTzdaSk5R?=
 =?utf-8?B?TXAxRjJ4c1ZITVJiVjdJZGZmbjhkMnVRWE9IS1NFZ3ZLeW5jamI5TjNEdThp?=
 =?utf-8?B?UGo0SDlNeXJqankvNnVoV0paYlkzR0Y5VVU1VWRScnhTNXd6NFdFS2xRUllE?=
 =?utf-8?B?aSt3UTczMVdDb2R4WXFaaFdxaU5VNDF2emRaMUwxRE8vN0k0OXd2bDNVOTFP?=
 =?utf-8?B?cytQWWtiSHQ0Z1BENEJQV0ZYd1dHdVhBUWVJN0FjSnFTbm5IY0JwZWlIS3o5?=
 =?utf-8?B?dzNVcXB3N1FYQXRURm5rZmRqQzNjZGpiUGVyVG9qVndIbDdDbzdFRmlZTDhC?=
 =?utf-8?B?OXRwUGp6YllCTkFSVk9tdkxNbS9LRU9UQnRkY0oxb3grckRNRTlob1huMDJB?=
 =?utf-8?B?Q2dRd3A5Qm9JZzhXYTVKY0R2ZEhSTm1zTDQrdEdaOGhJanNhT011MjJaNnh0?=
 =?utf-8?B?WmwvM3ovWE0ybTNlR1JscXh1b0FDL1RnYmQxK1VtWTdFS2JkTnFjeXRnSEt0?=
 =?utf-8?B?bnduQ1NzQ1VvWGN5MXFtWW1NRkhxSFNHUHgxWk54VzJmOGRnTlRVbTl6TkRj?=
 =?utf-8?B?Y09RN0w1d1NMRnNsWDRUeEh1UlBZaitiaFhJY2F6YTFUQy9zYml2QWZFdjJl?=
 =?utf-8?B?djRuei9Wbk1vQXJOZzk2UVRXZGlBR2lkaHpUUi9Pd0hUOTZsbjNCeVg5cWF5?=
 =?utf-8?B?eVViS0U3U2xRYlFvb3ZQeTBFVksycWNSNkhKeVlQSTh1QTllYTBIZ294UzRO?=
 =?utf-8?B?Q2xHdjZ1eXpJdFo3Z2dlNzhBL2FFZlVzQUx0Zk8zWWhyckRjRHFFUzBuZDZB?=
 =?utf-8?B?bFFZTlBaODZ1MXB4OFV0TTJyNEJGYmlyUU13TWkyZzBqWlJhdkY4SEJIcHNH?=
 =?utf-8?B?aUY0Rzh1OE5iZnRabWhweEcveHZ1QnZtQXNhYVlKcWt0djM4c2VSTTQ1Tyt2?=
 =?utf-8?B?bUtBNVEyazQ2NDllWFRHY2FLRmV2dnJBU0d3QU0xZnUzQWQ2OVY4MVVXYWFK?=
 =?utf-8?B?UmRLZ1dpSkFHYUtzZWozZlIxVXRGZGdsT2ZFak5JSWtNbXE2VlMzYk82ZWkz?=
 =?utf-8?B?RTRxaE02Z3dWY0hKaEVodkNDUXFIYnBTNGp5Z25pckNUT3YzY3IzZncxc2gx?=
 =?utf-8?B?T2JqYVFYQVExdmhVOUtmWFhIZUxlUmN5amlUUlcwWlIvUHlBWHZ4K0c1SEFN?=
 =?utf-8?B?MERBZTVzOHorYitZdzFKZmVBU1JFYld6TWRqcGorSi9RaTJqRUJlZzc1UVdB?=
 =?utf-8?B?ekJrWjJZc3lMYStkbXJZVjRCVlk4bjRUNjRLSmozS2hiRnAzMDZBVURQWnpn?=
 =?utf-8?B?STB6VW1aSDBNcGdPNU56Y2FNQzRQVmlaa0RYWi9nWCtkb3cvYy9zTzMwa2Ny?=
 =?utf-8?B?Mm96NzdPdzFaOGI4SXU3eDh1UFZuN0xHaFV6NnBvYkE2RkRvN0NndUZTbGZ0?=
 =?utf-8?B?WjVsejBOSzdEckViRmM3VCtkZEMyL0VNVnp1QXE4REpsT1piRyt6YW9OazBG?=
 =?utf-8?B?dEJ2NXcwbWdUbzRVWkZkTlVwNWcyWmUrZFRBWnNHMTFBZ2xrbUZnN2Jnb0Rm?=
 =?utf-8?B?dkYzemdIajgzTCt2QktTaW1ZR05XNFJFYkd2Y2JLcDFMTjlKd01TMmRHTjZx?=
 =?utf-8?B?SysvWXoxbTVESFI2WkdFaGdkNWh1KzJqam1IWkQ2L2FJdTY5Vm5oTHUrUC9O?=
 =?utf-8?B?WVcyRm5qK1FNOGt0SzJaQVh2dXhaT01GdFMyS2V2Wk5jRnRTTmhnSU11b25N?=
 =?utf-8?B?a3ZhOEhOamZQL3JQbXBKbHNBc09BaDRjUkFlTjFEWWpWVHFZNytYc0dWS0V3?=
 =?utf-8?B?K3RlU0lUSllicUdBV0pTM1BuaktZc3Vhdi9GSlp2bWZ6QS9RMm44VHI3cTNx?=
 =?utf-8?B?QlBmRlZuZVRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 07:40:53.4967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c35c5e6-8bda-4c3c-bcee-08ddeb8660a7
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6393
X-Proofpoint-GUID: j-KG0hgA8aBy1rriUda0wqnxqRbFJgEW
X-Proofpoint-ORIG-GUID: j-KG0hgA8aBy1rriUda0wqnxqRbFJgEW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI5MDIyMCBTYWx0ZWRfX9/Pws2Kv4Cn+ AYFkIsIo0dBArTtrT1FJeBkPNeNfSSrIAzvdxrtjegRcXbHuQO3hf/hWPSW++IA/z9bFF4XlkDF zNtiOg8et1rWlsxQpDvqJ4Boh8ul3FDTeK2FMmf2hVmiwX6TGUe8uJi4rJUEqQ3BkhBY9dWEG4Z
 jdWZDEgzOf16RACsux/vBnJZD1c28pQd+9uB8EiVehn0CPIffMKBXWoIHyw+ja7AYchSoUrw35i wzk+LmWkvKYt1gTbgCPgsLi5HlEGuRFVxGK1e4U4jaujO5xjnA8dVTkk0fwWOGAAWYcYewRLr4t zmNBMIsHgBGZovEXZbFLk6gUVhfFB687OS1s5kZM3bNbXQLyBHrXux4apbOYBli121IajKPdyoR rrpp1ZRl
X-Authority-Analysis: v=2.4 cv=Vq0jA/2n c=1 sm=1 tr=0 ts=68b9428d cx=c_pps a=NN78GPoN9wChDQH8zcTNzQ==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ei1tl_lDKmQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=FUbXzq8tPBIA:10 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8 a=aLYef2K2hjaO9teAgNYA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 bulkscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508290220

All of the current stm32mp2x boards embed an ethernet1 SNPS GMAC5.x
controller.

Add the support for it on stm32mp235f-dk, stm32mp257f-dk and
stm32mp257f-ev1 boards and default enable it.

On the stm32mp257f-ev1 board, we choose to keep the ethernet1
controller as a standalone ethernet controller instead of using
the TSN capable switch.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
Changes in v2:
- Remove pointless max-speed properties
- Fix property ordering (reg after compatible) in the stm32mp257f-ev1
- Link to v1: https://lore.kernel.org/r/20250903-mp2_ethernet-v1-0-4105b0ad2344@foss.st.com

---
Gatien Chevallier (4):
      arm64: dts: st: add eth1 pins for stm32mp2x platforms
      arm64: dts: st: enable ethernet1 controller on stm32mp257f-dk
      arm64: dts: st: enable ethernet1 controller on stm32mp257f-ev1
      arm64: dts: st: enable ethernet1 controller on stm32mp235f-dk

 arch/arm64/boot/dts/st/stm32mp235f-dk.dts     |  23 +++++
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi | 126 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts     |  23 +++++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |  24 +++++
 4 files changed, 196 insertions(+)
---
base-commit: 08a5d1b176ed503a5cef40991fc89549d85e8fe8
change-id: 20250902-mp2_ethernet-97ddde08f903

Best regards,
-- 
Gatien Chevallier <gatien.chevallier@foss.st.com>


