Return-Path: <linux-kernel+bounces-878465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A981FC20B78
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BBC84EEB2E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9572F261B8A;
	Thu, 30 Oct 2025 14:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b="rLFWZHa6"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021130.outbound.protection.outlook.com [40.107.130.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC17E1EF39E;
	Thu, 30 Oct 2025 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835533; cv=fail; b=RLc++FGKwrkPP0S8xs9I9SdaYhZk75kRL1dhvJU/GDo4LTp1Gon/k2CPM44o5oCA03b8bMbsPYqnGJlyrXqSNbK69PhGCF0OcreK0+wLxP+WVtoOL8XhU5hQUFwTDw25XZpVQXXEAzM3cbvkvFEliAGePrS7567yjqTHz7Ery3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835533; c=relaxed/simple;
	bh=UiO2DQCoRBnks0effpg3stlDRKoRbWEdUnRpIJx15Kg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p009/axSte7KBmAsV1bbjHY7cCtc0Z+bDbM0e0n1IduzMWi0kMxrFwlHtLqyWOdg+zU5CJLHP9gWIaxjygusQf7oAq4NX6EpOgWIu9OSH3baTHKMmTRfZeFBW9/ib1OWX/EvRMwkrCdamJcdDlPlnHbEIM+xZIvA5un0j8DHV+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com; spf=pass smtp.mailfrom=gocontroll.com; dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b=rLFWZHa6; arc=fail smtp.client-ip=40.107.130.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gocontroll.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJph2SoxdhQQpf3Rl0gMTXJRHvTWuA4AXQ+5mm+6Z/DGJW1iqo9QemRhpygh7ZMQe3mxF+m9A0QTKFCnBvrWpNLub4bCHgOm0Pf+tcfUXZ8FExomgNOl2dfwk9sLtZRTJ50QXYV/bb5J2kEkifrjAhuzVt3ZOPBSzDQalkoS/l5F5haoAYiEvg2bUIkZNn8OJoMg3MZCNwKPSSgmUpvXeg68nG6PaHwpXb8/3fOZSdQxMqXFK67qnrzEueBHF7+YC+hzzazAdLezw8eD1u1NvXnvXQDTIKziHKzNwL1ujyLcaF06DlUnhxg2XsBVpSMu+l9qhYiKujHt3u1oLyh4qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIhIA9dJj4V6HHlVlZdTk7mxiTWXGSFXx8TdIfdDFMI=;
 b=c10n+2OhXxEpbAL1bMBUynMJhgn4o/EpHvKP3EdN4ChzDrxsmX6mQXlPG/rtlSrwi87hfp97M3iXIcGd7khXzk0jb/9gAQK46Ed7tcXQsEs2MSiwjEVi4okoWbP0H3IfcH9+Fw9dHz37Pc5WHCsCzb1PRK4SvHhVe+kAIs13GRoek6hHeXtvXucsDdvhbe1BHfcoguDykJB4ea2NKoj9FVu6DCN0lVMQV1aTZ4EJ+WA9g1GDEVJNTSzIxIcKiQXMK1fUhHZ+GzsKiU61GBoDoambWy45VnpMEp79zkft8sXUf+Cp+QmtdxcqmVlx25AdqVz3GnVg8Kn2gv9ItAqQjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gocontroll.com; dmarc=pass action=none
 header.from=gocontroll.com; dkim=pass header.d=gocontroll.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gocontrollcom.onmicrosoft.com; s=selector1-gocontrollcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIhIA9dJj4V6HHlVlZdTk7mxiTWXGSFXx8TdIfdDFMI=;
 b=rLFWZHa6mbyYVRzUckn3yV+e5ZECYFi4rHcTEY81BbHW+R6VAfwxwjQgz/u8ek7kV8qFVioeC3oncbUwqvEYlu3Vu+v6Tt0JF+hd7paakXPqJRcVhwO0zO8GJsDjVjUC/AalgbgHg4gkR15Fdf7Z59fA4Ns28AI5BchLJ1OIn1Z6lmQCrF3+iLAQZvNBsjnl7Nju81k/Eyea9k0qvuEDFiVU+YFPzOPeKzk/+I64HMJIjz1tTfOl8jKeu6/G1WtwjtrEjU4X3yJ4F7C7GeUZNxNdzgWnpf0+0g7JGRp4LtfkLT1BB6WGIwLKaKgYDAZCWxUp777fvbpoPcx9tC2NpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gocontroll.com;
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com (2603:10a6:102:ec::16)
 by GV2PR04MB11446.eurprd04.prod.outlook.com (2603:10a6:150:2b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 14:45:23 +0000
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f]) by PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f%6]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 14:45:23 +0000
Message-ID: <036a04e1-3cb7-44c3-8836-3640f640b4a4@gocontroll.com>
Date: Thu, 30 Oct 2025 15:45:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: dts: freescale: add Ka-Ro Electronics
 tx8m-1610 COM
To: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20251022-mini_iv-v2-0-20af8f9aac14@gocontroll.com>
 <20251022-mini_iv-v2-3-20af8f9aac14@gocontroll.com>
 <a7012995-c2a8-48a3-abe1-5c227272f21c@gmail.com>
 <65202d1f-6c4f-4d4e-9fef-85cfb74ec768@gocontroll.com>
 <938f85b0-4c9b-463a-960a-f5f4e4092480@gocontroll.com>
 <20251029081138.2161a92a@karo-electronics.de>
 <4a47b9b5-f482-41b6-a441-7728572c5a0c@gmail.com>
 <20251029104838.44c5adcf@karo-electronics.de>
 <d05c62c9-7ed7-46e4-aa4d-27172741b5ee@gmail.com>
 <0667e026-99f3-4233-b3f6-e38273961d49@gocontroll.com>
 <20251030095434.1dc06df2@karo-electronics.de>
Content-Language: en-US
From: Maud Spierings <maudspierings@gocontroll.com>
In-Reply-To: <20251030095434.1dc06df2@karo-electronics.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0016.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::29) To PA4PR04MB7630.eurprd04.prod.outlook.com
 (2603:10a6:102:ec::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7630:EE_|GV2PR04MB11446:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cfc90ce-f1d3-419d-3051-08de17c2f4ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXNZd3FyRGQ5MUpzSlc3MGx6VUZQUTcrTlgrenVQb3NLSDlBby8rK2FoSVFD?=
 =?utf-8?B?WW9rYmJSeHhaNXBlYVVHelphMHM3L29FTDR0NXhSa3gyT01tRjR5NTJZbUZU?=
 =?utf-8?B?dUtYZ2Z3U2s2OERCOHk1aHNpUEZEYjRWMUdWVGNoblp2dUo1bkNIM0hwUW5Q?=
 =?utf-8?B?U0ovbTc1RTFsN0liTTRJQVl1dGUxaGRXa2ZGTkRHN0JxVHd3elRvTkNVckd5?=
 =?utf-8?B?RlhLdzgvMk9meHVqMS9tcHRneEsvZStGL2pCZ2loMGdpbmlyTkRZdnB6SVFt?=
 =?utf-8?B?OTZkSkkyV0o1akNaWXg5OVNocWwzeFd5ODNEVFBodTdWenBSb2F3NWs1UzZG?=
 =?utf-8?B?VytNYklFNk5YUDNxbkRQd242VVlxU3dnZDF4RDRCWDE2alpvQ3puNFpNK0Jv?=
 =?utf-8?B?S3l4YStDWG9WZ2tEQ0NkZzQxY0JJWGtuMzlwa1Y1OGt6N3R0OWhXYVVockpJ?=
 =?utf-8?B?QUlqYS91c0l1SEpqMzBqeE1kVUc4NDNxS0lObXRIN3l3b2dDcWd2WkVlcjRT?=
 =?utf-8?B?dk5YWit2TE56L3dkaTREQ1pvaEh1OXNwYkNjdTljemdBaTBVb3FieVIySEdZ?=
 =?utf-8?B?azErK1hlMnBIcGwxNmdVVitpWmpUQUlaTVBPQzc3QU9KUnI3d0pTVngyem1P?=
 =?utf-8?B?Z1ljME1Jc3JYMjhtcncwOG5OMW1Cdmdadi9QWGxtU2lheUZheUI2cTUxT2hq?=
 =?utf-8?B?c3FnZ2x2b2szY2RLUWZ3b1dMbldYZmxXQzg3T2t3VmNiMmR5VU9YelF0OHUz?=
 =?utf-8?B?N1ZDbEoydUhRbzBXZ1RBN3pjN0NIVU4reFVmZytBN282cHZkeDU2YVVCMlRk?=
 =?utf-8?B?UlQ5eE9id2lxNWRvMTJiR2dyU3JQbGZkNEJMdTFqU1BmbHJQZlpVcmJtbncx?=
 =?utf-8?B?VHBOZ2crdm1xOURtZHJlNUx5UXQ4MWJrSU5iNWs2dFJEVnZIdC9lTC9CelRz?=
 =?utf-8?B?bmZEK1VzUVp2TnVSREpqUGluVS9Yb0JvcXN1ZzNRTzNyWmVPUVJhZ0RYSVRX?=
 =?utf-8?B?V1NwbGdsSkxoUFo0OHpkSzlPRjhqL05TQWtCY1ZGWnFKdjlMcmVrb3o2Ulpw?=
 =?utf-8?B?MXlWTnl1cmYwMWtRa25ibG5ncTNIa1JQWStycE1kdkZ3QmRoMzlQODBhenh0?=
 =?utf-8?B?dGxPdGI4V1U0ZlFGOVBIZEpRZDlUQWF2UXd2dUhyYndZNnFHeW5GNEU2WWVW?=
 =?utf-8?B?MmZOVm00RytYeGViTmo2NVJrbzBCK0cxRElBRjJwbHg4eDRzaVgwR0hPRW9E?=
 =?utf-8?B?T1FRQ3Z3MC9kVnJYRitHT1Q0Y3lLOFZjMUIvTmZNZ1F4N1J0K2t2Ly9HcWVX?=
 =?utf-8?B?S2luNzIyb2RUeERQOHVNRWxUM0lEVkZhWTRQdUYvRFg1dXYvcWQ1dUlicThZ?=
 =?utf-8?B?M2k3aEVGY2prQS9NN2Y3T3U3eHJOQ1V2WGp2ZUtZQTl0NUFJeGh3SUU2aTh0?=
 =?utf-8?B?dmlFVnNFdFpLeW82YlRPU1IzRzFOS1hFcWR4aXI2NStNazNQc2VKall2ZTVT?=
 =?utf-8?B?V1hOSTZuQ3lYZnZ5ZGkxTzVXVkIyUjdPNTQxbUdxanRneVI4YU1YRU04REdP?=
 =?utf-8?B?MWQ3YzRxR2dOQTE0MmcyV2I2enNpeXl4U001LzZzcEtES1BwZGxRQ2xnZXVh?=
 =?utf-8?B?RTB1QXd6d1BQWWpGRVppTVJkejJnMWxxZmNWKzVrdHQ2MTY0U0lGYmI2cDRr?=
 =?utf-8?B?SlpjK2lHOTJXcXFHSmNwejVnK0szcStRVy9zZEtnTGxlNWUvc0lGajdQbTNB?=
 =?utf-8?B?bVdrRXlBTlRIczRtdEdPTWswaHFXbFdSWUtFVVdaRGRoMnJQOEcwc3l1d3Vs?=
 =?utf-8?B?cEVSQmVGRmx3MnRocHVUcHZNa3o1QmVNcDFScmtETVNMM0dWYUNPd1hEemtm?=
 =?utf-8?B?M3BNTDNkWERyN3N5bXJtNTBPYkNmT3hsclNrb3U3aURSdHdoMTAweVNPbUlJ?=
 =?utf-8?Q?7qq/RLkY9BrJFIFUY2NzffYC/hdwR4Mo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlRIVGkvWkExeGw1VnJob28yOUdkeFU2dGl3V2huNkFXKzBwTUNSWXJodENj?=
 =?utf-8?B?QytFYW1pS0laL2Ewc3NwNDk0SmRwbU92OEJvd1BDSzFOTFVsOFdQYUZIaHJN?=
 =?utf-8?B?Z3IxV25yMDFuajRHVHJ0YzBjMVhmcEpDdVBzL0VVbFl0YXVyNG5XNTRwQXZn?=
 =?utf-8?B?Zzk2eHJ2S1dweEQ1WlpPajFjZmhkQmxBdzFwZEZ2enZCUDhKNWlaUWMycHcw?=
 =?utf-8?B?R3ZIM1FEbkJJTjBRWDR1VXVzT2V2ZjRRR0RyMXdZNkZ0R0hib1grWmliU0Rz?=
 =?utf-8?B?aTc2OG5wdU1tU0VPUkVaUDJEV0JhWWNJKzlGMXB0UmJYUVFkdDNZWnJjVmdB?=
 =?utf-8?B?ZlVvaGZtMVQ3U1pPOTRCTU5TS1BDeWdvbHFSTFFEV3IxaGtDNkIxS0J5N3Ny?=
 =?utf-8?B?YXovQXgvclBVZTZtYlpEWHpXQzlhTmVKNExiT3NHQVNGZHZ6MGt2SWFzV2hV?=
 =?utf-8?B?MVZ2ZERpb2dYZVhMVUtNMlJrT1VtTEJrSVZpK2YxMjhkUjg4emRIQkZPcG14?=
 =?utf-8?B?U0ZtaHNZUkV0WXpQRVBYTUUzeU43eW9CM3ViSDg5N0VRVTBzZ3dzSzREa0h1?=
 =?utf-8?B?dmFDWjB6MkoxRis4MmIyd3BFdXNXZCs3U2JwenpaSkRQaFBvL1Q0KzNVUEkx?=
 =?utf-8?B?UWh1SlE3MGhUY29SY1lJeDF5aTQrdDJWbnl3TXNXcXV0bzZqaUNLN2dQUm9K?=
 =?utf-8?B?YTRUS0dxL0hueHBrNmNsS25DOEVyVEhPekRzVUxaS3NKWklXOWJ3NUVNQTY1?=
 =?utf-8?B?c2luUThYTXBkZW1LQzlkV3JGejhwYlhXbTdubWRkd2RvcG9lcFNWdWRJMElN?=
 =?utf-8?B?SzZ0VldyYy9sckJjTjhTMzc0U2NzdU1rRHJUR3RER2lxU0xTbXdPaWprNUps?=
 =?utf-8?B?U284SnRQUjNQUkViSDJCMFRzL3ZncEtST1lLOXJ4WmZIV2t2djB4cmNKQnFK?=
 =?utf-8?B?Q1hqVU1GMTMvaXRWcGg5bWdvb29BUGNHVVMxb1c5Y2JUdUFmZlF2YjI1V1dO?=
 =?utf-8?B?ai80UkE1aloyZWQxM2UzZUI4NHNOQWxqTVJmaXZ2R1o1NnRNQXpSUDJNbGts?=
 =?utf-8?B?cTRWK25ablhlZzFyRTRqQ2w3aEdjQkVZRGhIc0FRY0t1djk0VzhFWGdZWjZq?=
 =?utf-8?B?UGdCOGRxV1lkeTJES0tPREJMbW9hdjNIUHFVSHNBNnlhWWxpSWJNNTZialFC?=
 =?utf-8?B?dW5hY3F6aVNOdHVQbXk2cE5Xd3VlM01lakVicFErQy9saEM5emRJY0JFeHdW?=
 =?utf-8?B?bHhKZEdodHB4cmYzZGMwWGVERDlnWUZVNXpZRm9TMGs0cVI1V2J5a1Z1RGdi?=
 =?utf-8?B?dk1VWXpaeElhTVdvMEpRTngwczNPd21wcGNlRFR5NXhiQjJnOHBhdkpGeHhr?=
 =?utf-8?B?VlRPeGdlcW1IWWwxWWRMYWE3WHFVZitiYnBKdy9BODRQdGFQL1lyYTZPQXlp?=
 =?utf-8?B?MEN0NXZHd1d0R0o2TEFjQmd4eXQvZ2xIVTgxY0V5WVFzQXZBM0tDSng0dndS?=
 =?utf-8?B?OG1RZ2ZSZEJDUFloVGJTYXdaM0p1a0ZsOVZEUzRhbHdWeEhodGZYUkgzUlJi?=
 =?utf-8?B?bWMrT0d4cHlIT2xnQjFJbkwxUHFaK3lkQzh0MFk4M2J6R1EvbVM1TXBpb29s?=
 =?utf-8?B?VjRLOC81dUVNTGZ3SkNsY25nMEI4K0ZYMGtNWmNWR3pBMysyZXlvUjQyalM0?=
 =?utf-8?B?U1BmOXFwYUR4NTF4K2dXOXpWVlFkY3N2K1N5M3NzUzByaEYvaFFza0tMWGNF?=
 =?utf-8?B?TXltdTdlODdiWEI4RDM4R2xLWnU3eEhlVEdSNy93Vnpyb25uL1J1M24ySDln?=
 =?utf-8?B?S0Z2UXdtN0JaS0l2NmZFNGpiN0R4Vkt3RnA1WDFTa2RCaWI1UnJKRnRnVjBJ?=
 =?utf-8?B?bnNYNlFLc0RHVEtlWkRpVTFob0VSeTRlRWFJc2VSM3dyVWRyN2VuQzdVTlRD?=
 =?utf-8?B?ZmJpblZ2dGhKaUZ6UGdHNjZKUk9PZDdYWk15QzREaElNRnFXUGVHaWxlVmFt?=
 =?utf-8?B?OW45YjhZRFJFQVQ0RlpHYkhyZ1crOFAxbW9xbVBCelJ4SjRpOW41ZXpjY1hw?=
 =?utf-8?B?VUd2S0p4b1J1UVV5Y0pQMjV4SjdiSjZFNnM5WWRPb1FaRFRUdUFOLzhPRDF1?=
 =?utf-8?B?c1FKa2QyaVZIQVVIc3NyWG0rTzJXNU10eU4yUVZDWnFMb29laEtBa3dZVGVO?=
 =?utf-8?B?MVZmUklXTU9PSitFSHhNWW9VRFU5aDJ6dkFoYW1qMW8vOFdhRFQzQnFsU0N6?=
 =?utf-8?B?bVMrZTNZaXlING1LcWx2UHI4MXV3PT0=?=
X-OriginatorOrg: gocontroll.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfc90ce-f1d3-419d-3051-08de17c2f4ae
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:45:23.1436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4c8512ff-bac0-4d26-919a-ee6a4cecfc9d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vliVj5o+AaOj6MzwkIWR6bcrs9Gyo4BPIOe6munHN2xv0kfpS7nYLPZP0mJdIPRWRzcAEJZneNTGu75OXyS20dCDRToqmeqq4tpQPIQAdN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11446

Hi Lothar,

On 10/30/25 09:54, Lothar Waßmann wrote:
> Hi,
> 
> On Wed, 29 Oct 2025 16:35:25 +0100 Maud Spierings wrote:
>> Hi Matti,
>>
>> On 10/29/25 11:05, Matti Vaittinen wrote:
>>> On 29/10/2025 11:48, Lothar Waßmann wrote:
>>>> Hi,
>>>>
>>>> On Wed, 29 Oct 2025 10:42:17 +0200 Matti Vaittinen wrote:
>>>>> On 29/10/2025 09:11, Lothar Waßmann wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Tue, 28 Oct 2025 14:10:04 +0100 Maud Spierings wrote:
>>>>>>> On 10/28/25 13:42, Maud Spierings wrote:
>>>>>>>> On 10/28/25 13:15, Matti Vaittinen wrote:
>>>>>> [...]
>>>>>>>>> Could/Should this be described using the:
>>>>>>>>> 'rohm,feedback-pull-up-r1-ohms' and
>>>>>>>>> 'rohm,feedback-pull-up-r2-ohms'? If I understand the comment
>>>>>>>>> correctly, that might allow the driver to be able to use correctly
>>>>>>>>> scaled voltages.
>>>>>>>>>
>>>>>>>>> https://elixir.bootlin.com/linux/v6.18-rc1/source/Documentation/
>>>>>>>>> devicetree/bindings/regulator/rohm,bd71837-regulator.yaml#L108
>>>>>>>>
>>>>>>>> Ah I didn't know those existed, should've checked the bindings in
>>>>>>>> more
>>>>>>>> detail, thanks for the hint!
>>>>>>>>
>>>>>>>> I will have to investigate this carefully, since I don't have
>>>>>>>> access to
>>>>>>>> the actual design of the COM, so I don't know exactly what is there.
>>>>>>>
>>>>>>> So I am not yet entirely sure if this works out, I used the
>>>>>>> calculation
>>>>>>> in the driver:
>>>>>>>
>>>>>>> /*
>>>>>>>      * Setups where regulator (especially the buck8) output voltage
>>>>>>> is scaled
>>>>>>>      * by adding external connection where some other regulator
>>>>>>> output is
>>>>>>> connected
>>>>>>>      * to feedback-pin (over suitable resistors) is getting popular
>>>>>>> amongst
>>>>>>> users
>>>>>>>      * of BD71837. (This allows for example scaling down the buck8
>>>>>>> voltages
>>>>>>> to suit
>>>>>>>      * lover GPU voltages for projects where buck8 is (ab)used to
>>>>>>> supply power
>>>>>>>      * for GPU. Additionally some setups do allow DVS for buck8 but
>>>>>>> as this do
>>>>>>>      * produce voltage spikes the HW must be evaluated to be able to
>>>>>>> survive this
>>>>>>>      * - hence I keep the DVS disabled for non DVS bucks by default. I
>>>>>>> don't want
>>>>>>>      * to help you burn your proto board)
>>>>>>>      *
>>>>>>>      * So we allow describing this external connection from DT and
>>>>>>> scale the
>>>>>>>      * voltages accordingly. This is what the connection should look
>>>>>>> like:
>>>>>>>      *
>>>>>>>      * |------------|
>>>>>>>      * |    buck 8  |-------+----->Vout
>>>>>>>      * |        |    |
>>>>>>>      * |------------|    |
>>>>>>>      *    | FB pin    |
>>>>>>>      *    |        |
>>>>>>>      *    +-------+--R2---+
>>>>>>>      *        |
>>>>>>>      *        R1
>>>>>>>      *        |
>>>>>>>      *    V FB-pull-up
>>>>>>>      *
>>>>>>>      *    Here the buck output is sifted according to formula:
>>>>>>>      *
>>>>>>>      * Vout_o = Vo - (Vpu - Vo)*R2/R1
>>>>>>>      * Linear_step = step_orig*(R1+R2)/R1
>>>>>>>      *
>>>>>>>      * where:
>>>>>>>      * Vout_o is adjusted voltage output at vsel reg value 0
>>>>>>>      * Vo is original voltage output at vsel reg value 0
>>>>>>>      * Vpu is the pull-up voltage V FB-pull-up in the picture
>>>>>>>      * R1 and R2 are resistor values.
>>>>>>>      *
>>>>>>>      * As a real world example for buck8 and a specific GPU:
>>>>>>>      * VLDO = 1.6V (used as FB-pull-up)
>>>>>>>      * R1 = 1000ohms
>>>>>>>      * R2 = 150ohms
>>>>>>>      * VSEL 0x0 => 0.8V – (VLDO – 0.8) * R2 / R1 = 0.68V
>>>>>>>      * Linear Step = 10mV * (R1 + R2) / R1 = 11.5mV
>>>>>>>      */
>>>>>>>
>>>>>>> Because I do not know the pull up voltage, and I am not sure if it
>>>>>>> is a
>>>>>>> pull up.
>>>>>>>
>>>>>>> So:
>>>>>>> Vout_o = 1.35V
>>>>>>> Vo = 1.1V
>>>>>>> Vpu = unknown
>>>>>>> R2 = 499 Ohm
>>>>>>> R1 = 2200 Ohm
>>>>>>> Gives:
>>>>>>> Vpu = ~0V
>>>>>>>
>>>>>>> And:
>>>>>>> Vout_o = 1.35V
>>>>>>> Vo = 1.1V
>>>>>>> Vpu = unknown
>>>>>>> R2 = 2200 Ohm
>>>>>>> R1 = 499 Ohm
>>>>>>> Gives:
>>>>>>> Vpu = ~1.04V
>>>>>>>
>>>>>>> I am not quite sure which resistor is R1 and which is R2 but having
>>>>>>> there be a pull down to 0V seems the most logical answer?
>>>>>>>
>>>>>>> I am adding Lothar from Ka-Ro to the CC maybe he can shed some
>>>>>>> light on
>>>>>>> this setup.
>>>>>> R2 is connected to GND, so Vpu = 0.
>>>>>> With:
>>>>>>      regulator-min-microvolt = <1350000>;
>>>>>>      regulator-max-microvolt = <1350000>;
>>>>>>      rohm,fb-pull-up-microvolt = <0>;
>>>>>>      rohm,feedback-pull-up-r1-ohms = <2200>;
>>>>>>      rohm,feedback-pull-up-r2-ohms = <499>;
>>>>>> the correct voltage should be produced on the BUCK8 output, but a quick
>>>>>> test with these parameters led to:
>>>>>> |failed to get the current voltage: -EINVAL
>>>>>> |bd718xx-pmic bd71847-pmic.3.auto: error -EINVAL: failed to register
>>>>>> buck6 regulator
>>>>>> |bd718xx-pmic: probe of bd71847-pmic.3.auto failed with error -22
>>>>>>
>>>>>> Apparently noone has ever tested this feature in real life.
>>>>>
>>>>> Thanks for trying it out Lothar. I am positive this was tested - but
>>>>> probably the use-case has been using a pull-up. I assume having the zero
>>>>> pull-up voltage causes the driver to calculate some bogus values. I
>>>>> think fixing the computation in the driver might not be that big of a
>>>>> task(?) The benefit of doing it would be that the correct voltages would
>>>>> be calculated by the driver.
>>>>>
>>>>> If real voltages aren't matching what is calculated by the driver, then
>>>>> the voltages requested by regulator consumers will cause wrong voltages
>>>>> to be applied. Debug interfaces will also show wrong voltages, and the
>>>>> safety limits set in the device-tree will not be really respected.
>>>>>
>>>>> I think this would be well worth fixing.
>>>>>   
>>>> Before doing the real-life test I did the same calculation that's done
>>>> in the driver to be sure that it will generate the correct values:
>>>> bc 1.07.1
>>>> Copyright 1991-1994, 1997, 1998, 2000, 2004, 2006, 2008, 2012-2017
>>>> Free Software Foundation, Inc.
>>>> This is free software with ABSOLUTELY NO WARRANTY.
>>>> For details type `warranty'.
>>>> fb_uv=0
>>>> r1=2200
>>>> r2=499
>>>> min=800000
>>>> step=10000
>>>> # default voltage without divider
>>>> min+30*step
>>>> 1100000
>>>> min=min-(fb_uv-min)*r2/r1
>>>> step=step*(r1+r2)/r1
>>>> min
>>>> 981454
>>>> step
>>>> 12268
>>>> # default voltage with divider
>>>> min+30*step
>>>> 1349494
>>>>
>>>> Probably we need to use this value rather than the nominal 135000 as
>>>> the target voltage in the DTB.
>>>
>>> Yes. When the driver calculates the voltages which match the actual
>>> voltages, then you should also use the actual voltages in the device-tree.
>>>    
>>
>> Think I've got it:
>>
>> diff --git a/drivers/regulator/bd718x7-regulator.c
>> b/drivers/regulator/bd718x7-regulator.c
>> index 022d98f3c32a2..ea9c4058ee6a5 100644
>> --- a/drivers/regulator/bd718x7-regulator.c
>> +++ b/drivers/regulator/bd718x7-regulator.c
>> @@ -1613,6 +1613,8 @@ static int setup_feedback_loop(struct device *dev,
>> struct device_node *np,
>>                                   step /= r1;
>>
>>                                   new[j].min = min;
>> +                               new[j].min_sel =
>> desc->linear_ranges[j].min_sel;
>> +                               new[j].max_sel =
>> desc->linear_ranges[j].max_sel;
>>                                   new[j].step = step;
>>
>>                                   dev_dbg(dev, "%s: old range min %d,
>> step %d\n",
>>
>>
>> the min_sel and max_sel fields were uninitialized in the new
>> linear_range, copying them over from the old one (they refer to the
>> register range if I understand correctly so they should not change)
>> initializes them.
>>
>> Then setting 1349494 as the actual voltage makes it fully work.
>> Otherwise it complains:
>> buck6: failed to apply 1350000-1350000uV constraint: -EINVAL
>>
>> Final debug output now:
>> [    0.327807] rohm-bd718x7 0-004b: buck6: old range min 800000, step 10000
>> [    0.327813] rohm-bd718x7 0-004b: new range min 981454, step 12268
>> [    0.327819] rohm-bd718x7 0-004b: regulator 'buck6' has FB pull-up
>> configured
>>
>> I will add this fix to the next version of this patchset and include
>> your requested change in the dts.
>>
> Does it also work with min/max settings in the DTS that are taken from
> the designated value +/- 5% tolerance margin, so that the DTS contains
> reasonable values determined by the HW requirements, rather than some
> artificial number that is enforced by the SW behaviour?
> E.g.:
> 	regulator-min-microvolts = <(135000 - 6750)>;
> 	regulator-min-microvolts = <(135000 + 6750)>;
> Thus, the nominal value of the voltage is explicitly shown in the DTS
> file.

Setting that range seems to work:

  regulator                      use open bypass  opmode voltage current 
     min     max
  ---------------------------------------------------------------------------------------
   regulator-dummy                  1    1      0 unknown     0mV 
0mA     0mV     0mV
      2-0014-vled                   0 
0mA     0mV     0mV
   6v4                              1    0      0 unknown  6400mV 
0mA  6400mV  6400mV
   3v3-etn                          1    1      0 unknown  3300mV 
0mA  3300mV  3300mV
      30be0000.ethernet-phy         1 
0mA     0mV     0mV
   3v3-m.2                          3    3      0 unknown  3300mV 
0mA  3300mV  3300mV
      30b50000.mmc-vmmc             1 
0mA  3300mV  3400mV
      serial0-0-vddio               1 
0mA     0mV     0mV
      serial0-0-vbat                1 
0mA     0mV     0mV
   5v0                              2    1      0 unknown  5000mV 
0mA  5000mV  5000mV
      32e50000.usb-vbus             1 
0mA     0mV     0mV
   can1-stby                        1    1      0 unknown  3300mV 
0mA  3300mV  3300mV
      spi0.2-xceiver                1 
0mA     0mV     0mV
   can2-stby                        1    1      0 unknown  3300mV 
0mA  3300mV  3300mV
      spi0.3-xceiver                1 
0mA     0mV     0mV
   can3-stby                        1    1      0 unknown  3300mV 
0mA  3300mV  3300mV
      spi1.2-xceiver                1 
0mA     0mV     0mV
   can4-stby                        1    1      0 unknown  3300mV 
0mA  3300mV  3300mV
      spi1.3-xceiver                1 
0mA     0mV     0mV
   buck1                            1    0      0 unknown   900mV 
0mA   780mV   900mV
   buck2                            2    1      0 unknown   850mV 
0mA   810mV   950mV
      cpu0-cpu                      1 
0mA   850mV   850mV
   buck3                            1    0      0 unknown   900mV 
0mA   850mV   900mV
   buck4                            7    6      0 unknown  3300mV 
0mA  3300mV  3300mV
      30b40000.mmc-vmmc             1 
0mA  3300mV  3400mV
      spi1.3-vdd                    1 
0mA     0mV     0mV
      spi1.2-vdd                    1 
0mA     0mV     0mV
      spi0.3-vdd                    1 
0mA     0mV     0mV
      spi0.2-vdd                    1 
0mA     0mV     0mV
      spi2.4-vref                   1 
0mA     0mV     0mV
   buck5                            3    2      0 unknown  1800mV 
0mA  1755mV  1950mV
      30b40000.mmc-vqmmc            1 
0mA     0mV     0mV
      ldo6                          1    0      0 unknown  1200mV 
0mA  1200mV  1200mV
   buck6                            1    0      0 unknown  1349mV 
0mA  1288mV  1410mV
   ldo1                             1    0      0 unknown  1800mV 
0mA  1700mV  1900mV
   ldo2                             1    0      0 unknown   800mV 
0mA   800mV   900mV
   ldo3                             1    0      0 unknown  1800mV 
0mA  1800mV  1800mV
   ldo4                             1    0      0 unknown   900mV 
0mA   900mV  1000mV
   ldo5                             0    0      0 unknown  3300mV 
0mA  1800mV  3300mV

buck6 at 1349 mV

Kind regards,
Maud



