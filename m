Return-Path: <linux-kernel+bounces-800039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F7FB432B6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC82116E17C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9C7278161;
	Thu,  4 Sep 2025 06:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="cTXU3gVi"
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D712750FA;
	Thu,  4 Sep 2025 06:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968124; cv=fail; b=jNp+9j649N/7IfrMST/JaegerlpJC/T6OTKTsy800FS7GmJpa2jlonY0TuuKNs13ZKjxKBuaEWXszcfCioz1WiVhQBtZ9QdeapNBHOBd/uKFxobum783xvOIWgCYZONUH9Vps4lSmIOIkMBsRYX+DVvJ0/7JgWj23qAiMZjodbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968124; c=relaxed/simple;
	bh=JrtR7fqGHrju3yOs0JTN0U2804lYJVIsn+PaZypKatY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jkUU+p9U8Wu7Oo1zcLXbM+pmNcd+as7a9VM2LN8Eu/I/RV1gGWeGhLU4oL12McdCyhUlXV+4XHtKbs+kgnjTyggi0mRk7rf7xoHjIOSzjQYZm3Zie6vx/cHK7rglJ1LRJ2oepGMxsQ9RZfDzbSauWRlfhM23o4/cATBhvGsK4iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=cTXU3gVi; arc=fail smtp.client-ip=216.71.156.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1756968122; x=1788504122;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JrtR7fqGHrju3yOs0JTN0U2804lYJVIsn+PaZypKatY=;
  b=cTXU3gViR/TJc3LhXMX9uJp767mAS9EWWElDl5QFL7pK2TA56nFVbDL1
   f36SNnXe5ngpdk/JWB3V95LXacS1MifcWL5+Q09ICcD3BQIAFe6jSCvIH
   5xPqKZtelUTby8+IultBO5+iFqYIRVJ1wU/xISqMpiW/07Cfd77JlgH0w
   v1T8DoLVLyyNCzF1Hu9GI+kEdfGm5dXtDn6Epr9S/4g1R5YKtvfCP2iqK
   9xZ/LLvoGpq4I0XHvvPXuzsyudQuX2h5FP5ZMNfWkUDaelKv+RR8x+New
   dAoMrzmhrybitItbNwt8oARvQfPqdKbMxJSIYRDOtr/QscIwBwTRN7tnU
   g==;
X-CSE-ConnectionGUID: mwM5uG1VSh2plzIpH8bogA==
X-CSE-MsgGUID: jZkEniDjQR6Cki7CZ7DW4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="166798952"
X-IronPort-AV: E=Sophos;i="6.18,237,1751209200"; 
   d="scan'208";a="166798952"
Received: from mail-japaneastazon11011001.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([52.101.125.1])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 15:41:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LI88b/tQbLUGaxCoECi+D1XIocx05iEyOhGEE3N9Pl6r+ldDW4k+CYDAUtD+/57iEJ8NhlmFYhV4cNrbIDL98yLnjyWmaYrBu+rvzVxH98mzlq6XwhBwKdEd2oVWqsEGNKhzZLkoP+v7XGsAYS7BAw7gABYwWMOWoOc79+RFb37FAykf0yzsi7/cMtqWz/uDFQs2PoLuL9G+yDeEh1qqbC3xJX3AplQrsskMVCJsVucKmeshim6N1gg1eiodCqYmjFs/Fi78ev1kAkhG22v2/1BKQsc7Ktm/q3ky5pPnx1DvwWUpmp+OabFJxCD2RSm797QfKK9ZqG6W7YIK6mfzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrtR7fqGHrju3yOs0JTN0U2804lYJVIsn+PaZypKatY=;
 b=H2TwhecKWM11FNhv31ue40drjvfUhL8FMfmAT1RQsWZJFC5hTK4TM1QXFf+jfV3+JeyTl/Lh7913cRj75HLP49nOHzlBkNrSc9nJ+8q3biFzSGiff3IPebuXyKARopZA3FSpWaGMGAcd/DlClDd9brNN+S010itLtCo0vqWsYt+ITEoOuvr5fVhcVAW7BAI94stJgXsvrDiJMQq6qWZrV8u7lW3tPLiPukv8lAwSsgpCei/cba8G4X5GAoyrFa20x8qwmYJpuSRnru6ghNP65+Ass3W6Ux5VyPg7Rsoziw2UxyW2MumE4RgMunMykx3R29zUgA/i5Urr7YUa6ZMlrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSCPR01MB12819.jpnprd01.prod.outlook.com (2603:1096:604:33a::9)
 by TY4PR01MB13415.jpnprd01.prod.outlook.com (2603:1096:405:1dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 06:41:47 +0000
Received: from OSCPR01MB12819.jpnprd01.prod.outlook.com
 ([fe80::2809:3a6d:2dd0:ea9d]) by OSCPR01MB12819.jpnprd01.prod.outlook.com
 ([fe80::2809:3a6d:2dd0:ea9d%6]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 06:41:47 +0000
From: "Koichi Okuno (Fujitsu)" <fj2767dz@fujitsu.com>
To: 'Robin Murphy' <robin.murphy@arm.com>
CC: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>, Linu Cherian
	<lcherian@marvell.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Bjorn Andersson
	<quic_bjorande@quicinc.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Konrad Dybcio
	<konradybcio@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Arnd
 Bergmann <arnd@arndb.de>, =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?=
	<nfraprado@collabora.com>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Koichi Okuno (Fujitsu)"
	<fj2767dz@fujitsu.com>
Subject: RE: [PATCH v7 2/2] perf: Fujitsu: Add the Uncore PCI PMU driver
Thread-Topic: [PATCH v7 2/2] perf: Fujitsu: Add the Uncore PCI PMU driver
Thread-Index: AQHcDZd8X/ma0tdSYkGYj6phhrIvT7RjrbmAgB8EnkA=
Date: Thu, 4 Sep 2025 06:41:47 +0000
Message-ID:
 <OSCPR01MB12819D172FC89A6A8C26226DCC100A@OSCPR01MB12819.jpnprd01.prod.outlook.com>
References: <20250815034751.3726963-1-fj2767dz@fujitsu.com>
 <20250815034751.3726963-3-fj2767dz@fujitsu.com>
 <995e093f-7b6c-4701-87af-2f4d21b08ada@arm.com>
In-Reply-To: <995e093f-7b6c-4701-87af-2f4d21b08ada@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9OWQ2Y2E2MzAtNmY2ZC00ZTc4LWFmNTAtMWZmZmJjMmJk?=
 =?utf-8?B?ZmY4O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI1LTA5LTA0VDA2OjQxOjM1WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?B?ODFlMS00ODU4LWE5ZDgtNzM2ZTI2N2ZkNGM3O01TSVBfTGFiZWxfMWU5MmVm?=
 =?utf-8?B?NzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX1RhZz0xMCwgMCwgMSwg?=
 =?utf-8?Q?1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB12819:EE_|TY4PR01MB13415:EE_
x-ms-office365-filtering-correlation-id: 37b769aa-de75-44aa-3ef6-08ddeb7e1edb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SGJiMjlFU2lyYm9UVWlIMnlUQkM1UlBDalBCWTFkMjZFeXFRRmcrdWZ2RXFx?=
 =?utf-8?B?WXBpR2NjdnY3dDZWMXZlT050a0EvRWY3c0gzanFlRDllOVZsa2grQmNSZUY3?=
 =?utf-8?B?ekdwSTVkK3M2ek9iRTBVSmJSUysxZzZGVVhnQ296U0tOZ0hpMlVrRkJUeTZl?=
 =?utf-8?B?bXhHakpweFdXMXY3WE44aUVOYkNsRlYzNjJlclowbEVRTzFHR1M4T29qQ1cx?=
 =?utf-8?B?d1FNYzk5V3NVOFRQUVBJaFVmdXA3MWNxRVJDTlVtSmVCNzRhc2ZFNkZ6dDMr?=
 =?utf-8?B?dmhjZ0hYcG1HSGVuVmo1MXNJNWZ2UnFCYzVQUUkyTkkwVkNVU1hFOVovTEFz?=
 =?utf-8?B?QjJ4S2REZmxKdGdFWmJhUVd0eDJ5c09LdmxZTHNyS3JBVVFTT2dTOGU3VHRV?=
 =?utf-8?B?UzBXN0ZMT2Z0a3p5UllIekxsTTFZdXdrYXdFek1NZE1ydkRER2FzeTRtQm5o?=
 =?utf-8?B?S0wwekZWZWduK3BaRmM3bitPVDl3ZEllVDhQQ2QzckNrSXhxZXlFbkFBSW44?=
 =?utf-8?B?MWlkdFJabGNnTnNLbnhBTlh3bEcxT2xIaWZMbzkzWTRaMzhNSnhUTGhlTWF5?=
 =?utf-8?B?K0Z4TTRDQStwdGZXQ1piN3VucFVsekh5R3ZIeDFFZ3dIckFIa1pRQTdzZ3Iz?=
 =?utf-8?B?Q2tyNDFGZ1BsUVpTZ3hmZC9uQjd3eVRValNlRWZXZDdoMEdadEpSTittbGRY?=
 =?utf-8?B?MmJFV2E4NjN3S0xueFhjN2U0aTd6UVFJaUpwdGpuZk9IdGFYakt2bU1YZzly?=
 =?utf-8?B?WURZSEZJcjl2blVjVW9QRmlXZEpFY3JrWFQxSzIyNzFQdVRyRVhCR1l3SVU2?=
 =?utf-8?B?cHdab3U4dnh0d0txOG95blU1TzJqSEgwWGVXeGlzSG4xVmdWb0FOQ3dITFNP?=
 =?utf-8?B?cjhTYUgrWnl4WWZuOGhDUkFPdTg3UGdCbmhxSnNiL1pJcWI3dy8wREErS2Mr?=
 =?utf-8?B?dnF6UG92Z0FkditkVXdJcmNyeVVtcEgvU01EZ2VKNXpENEtzcVpQWFlabHYv?=
 =?utf-8?B?UmRmaDdzYUhtRXFSQzJMbW1GalpQdGVIVUxZNG50SXRwTDZxeEl5bUR2czlo?=
 =?utf-8?B?VHFSY1RsYkFxbVNLaGRhUGNZVENnMXkvQiszZHNnZUJOdytsTkczbGlyaUND?=
 =?utf-8?B?c2JXUDZYbkZkb1c1TDI2L2twMHVFLzJjcEZMRURBeFR3UUR4eUhERFBsdkhj?=
 =?utf-8?B?UUxjcUszTlNOWnM4WmVNd2E1c1VsN1BDTW9seXlJYlZSM0lFL1lNbjV2T2VF?=
 =?utf-8?B?TWR6aStrOFNsaCtDQTJUcmYwUXNJaFFLNEs2Q0lOdFRTWTZwWkV6cjdmaXBu?=
 =?utf-8?B?SjZrbzdWK1RPVkUwWW9NM1NOMG1CemRENUpXL0lITjdrZDFISXo5OTVXZkJn?=
 =?utf-8?B?NW1vQmRBR3NTa1A3QjVXbHAzLzdyM1FGdG1wdFI0WXhYOXd1amlSdHNLdmFs?=
 =?utf-8?B?U05YR21IcWErLzB3cEVYRldaM2lldzAxbHZQcjllU29lVnNtc25zS0loZzE1?=
 =?utf-8?B?RDZFSnJBZDNSazhrbE8xTHNXbzQwYW4yMnk0UjhkaWlhdUZMdkRzUUNzeSsx?=
 =?utf-8?B?OWVybTJkUE5RbXRhMmszY3ZCRmlSbUptbEc0SXFxd01yNlNqeGRaMUoxTEdY?=
 =?utf-8?B?c2E0d2c4RVZySStOSC83UGFwVVp5Y3Ewc01DUkx1cHpUcDdLT2NEWVgvWDlj?=
 =?utf-8?B?WkpXTmZ2TFhFMmxPYjQ2UkVhUy9HZUtLTmdBcnVpQ2UwTmluZ2dUYXlRVXVz?=
 =?utf-8?B?bVF0UCtwQTdZOXczWm1uSkI0bHY1Q2tBUmw5ZmYvYkdwcHUxS2JsRlBrSlZC?=
 =?utf-8?B?R3NqbEtpb3ZveS95MnY3c3FNWFdDN2JzMmNYVHBXVWVBWnBVK0dBNGdCMVlZ?=
 =?utf-8?B?WTZKcFVQMllXc2ZnUnNYZWNyS1d3a3NLaG5JTzQ2TEY1ellFTGRrbHZ4SnYr?=
 =?utf-8?B?MXBMcytJUENsVitOTGJCa0Jld3hTeUl1aHhYTkR1VlA4L2k4ZVNKRTZyL2dH?=
 =?utf-8?B?RitmRTNqZkVTZko0VUxFVzZyNlY3TWozdkpCMUZ0MGI0anhKUlAwVHpLcy9t?=
 =?utf-8?Q?u3PCwH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB12819.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmhCRkhxdXJRNnNhYkdoczl5RSsxb250cy8xSjFiTDk0KzRkcG94S1BhbTk5?=
 =?utf-8?B?WUx3OWVlRnV2VjNFYzBTcGs2UTR3UG45QWZmVDN2YzRpWmdORjdsM1hZRlQ0?=
 =?utf-8?B?THM0UUZxY3BteS94VFRkMVYzdTl0TGdtaG43Uk02eXJDNDlTQkpMRDVzU1ds?=
 =?utf-8?B?MVIzekZsTEJudU8xdElTbGorVjd4K0pKK05pMmd0VWpYWWJ1eVZIRlphVGdn?=
 =?utf-8?B?bkFaWndrRmxHd2xobzBUSmNCcFR2cmFRdXhtSWpkTUZkdXhnUXYvUEFjc1hZ?=
 =?utf-8?B?Nmt5ZTJzK04xNzBMTU5KVTRCYzJsV24wdUoydTlXd0VwanFJaVJFYmE1eGph?=
 =?utf-8?B?WlRMS0dRRkcxaDl3YVQrZ0xhdHNHU0hSTVZRay8zcUF5Y2pxSlo4SUtFM1ZB?=
 =?utf-8?B?ODdFSjVWMTNkQ1g3QnpMcFJPTEpPUkRLYW9QU3JsMmpGMTM5R3htckNYT1Bu?=
 =?utf-8?B?bzFEODY2LzFxOGZpVm02M0Uwa0hsdzBpRkpHMG1PS2pYbCtiLzhMM05ocyty?=
 =?utf-8?B?NjFVbSs1dXJJWmxCSWs2RFpzaXd6Vlo3ODVBMlV1a0RIQnBPOGdONXphTXVU?=
 =?utf-8?B?Wmo3YlVDNE9TQSt2MXZVQVRnZ2lRY2IzZ0FaTTZ2Nk1mRXhNVW5xSEpsbHVE?=
 =?utf-8?B?V1ptc1FjWG5heWhBVDNFQ2o2VW83VDJGTExMNGxEeGRYYmFIOWc2dldrbzlG?=
 =?utf-8?B?cjl6YmNGZ09kZmRNZ0l3QnhIc3dnUmJPazY2bUpyNlRLZlpoQzZwMHcycHdr?=
 =?utf-8?B?d2NhMFRIMVd3dFhwMHQ5djF0cytJNUVxV3dpSHEya0FUUDA4YmRSWHdIbEFJ?=
 =?utf-8?B?bFl1bXNiNjZrRWpZQ0JnL0FXeERlZGhlM0xRcFliUFRlMzNJRFpFNWFsMk5u?=
 =?utf-8?B?L3BvUnNWTFZmQXQ3QXgwRzYzRDJYOTYzelFMRVExelNlQjBZcFNMUEVMNXpr?=
 =?utf-8?B?RGVQLzltQjN1ZlNISDVJRk5RSHdOQzcxclN4U2RncXpCazZNWlhMSFVKbnlN?=
 =?utf-8?B?bS9wc1R5RjVwdFdOVnBMRHliTzh2bm52ZmYrb2xjb1lzWkRWN2RzemZkcGtM?=
 =?utf-8?B?NjBHY3BRTXhuTWVMdUhVTlFPL1F1c2ZHS1JOSHMybFI1ZElzMGsvaCtWZXpY?=
 =?utf-8?B?QjVJcnpWZExwcXowTlFlY2s5UjZUcllxOFViM3lxSWFlaStkN3kvSUFOMHJI?=
 =?utf-8?B?cGtuRVU1b09DaUxqOTNzU3dUM0k4cGsxZ2ZrSXo5VHhRZHBPY0dGY1ZmcU00?=
 =?utf-8?B?aGN5bEkza0VtclRjNFl6aEErd0hVVlhUVnp2eGE4UkZQdzJESTVFN3VJZTI4?=
 =?utf-8?B?VnljUGU1c09wYU4vK25yUTgvbVNqbzJsaDBYdFJNbFU5bWJZejdZTDM2VUVw?=
 =?utf-8?B?SENKZU5wZjh6RmVhamxJTnZFd1FCcWZWYk82dWNVL0Z4K2xiTHMycU5CMWFx?=
 =?utf-8?B?RjJocXJ1UDNOcCttMmY3YjhQWlZ1WnJSTEhaRmxLb3huV1l1L2xIZ3dpRm96?=
 =?utf-8?B?bmhlOVpXbEsrOVBtWHR2U2d1YXJrQ0xQMHp0Q2JGNXNNNDZQdXU4OEV5ZGpy?=
 =?utf-8?B?OGEvTGJzak5BazluMTRHa2dvajZtQlo5Y0R3SHR3UjdsNmlhazVaMjdaeVJY?=
 =?utf-8?B?a2dnam13eHA4VnZPeXpwdDVlaGdSVFMvSnpwTWg3MnlLNGZaNE5LbHNTV1pk?=
 =?utf-8?B?MlFTR2JTWXFtYU11VGhxVUg5TWpzbHFSL2hBTkJGSmtEYTZtS3QyQm1ZZGZ5?=
 =?utf-8?B?NEJicUJMaUlrOG1VTXorOVlveUltOTY2NllwK3o0RXVVKzVzdndnM2VTQkZH?=
 =?utf-8?B?M2YralRHRHEvNkl4ZGhlWmhPbkora2hsRS8zcEJyQU9sSlRvSHMweDdQYVFq?=
 =?utf-8?B?K0RoWjNnVlZwUmdXWGk2eWZjNkMvakhabzMwL1lWWEsxQlVzY1dKaHJSRlNw?=
 =?utf-8?B?NUlFc2dVUFpqVktEdWlWaU5ud0ZaemVndmhjV0hMMlV0OTFPT2hLYmExVVp1?=
 =?utf-8?B?QzlEWm9xSWFzd3YrTnRROUVNYU4vWHArQ20xSGpyQXhxUmlMZXcwc0Q0REcy?=
 =?utf-8?B?UEwvRlhiUGhoTGFJVnpqNUs4MjJKNGNCZHdGRDVvRk9Lem51Kzg0dTMrT3BW?=
 =?utf-8?B?OHViOEplNk43TFdrUzNzT2thVC9ZUDc3TkVpcWlLd1lkRDdwdi9RWkZ3Q2s4?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wEMAT9NGsFWShCzRkJlRuNUxgtypd9f8lJN1SGo0+XgwvcDVliGjNDAwM1sjj8glcGxSHaWx9fGMMUX4U528Jo57e/iYSFU1d3fZu31qp0BAD3HK4pSFdGumnsnJybclt1nagUYMy1LrNRwwxNZhWfwYpHQj4XJvgRKpTzSRISk+6pHQfdFn2ffJJXRLcxS8dDNFGkmHAkceKoWhoORFwyId96vgSRYq5wmZXN9UJ9aM9yOHlplqMD6MXPL3YemCeAVuuLNWXXOT3GZ/dfUk8c21mp1h9QEI8kjE9gp65tTT0ada+/gyaD/MuAg/q7tJml4SexjF89Y10O7VM8U1Vo/MwHbYqDbx10EjNR9otJt/F42SpRnwPw8x0+BwVpHCm8inIWLEM9h+No4TeATbrZjZA1ZYgox5UI2ytflfJyWoxUJ27JxLNVvFlQUS3JjKW8hkhnA3yoCDTpNN0MdBxORDubnq7fzMhYhx88oO3RliCbIrQW9YQNmyPOYsT+Xcj63gmOFAeCInx75Fp8kUtnUna1nYyJ/ypJANf4wHWb2AsGU5qxlJcTCkLGGVUQ51w/OUzBD2QzsCpARA9bCQWgTdijyOrqelOvfCSQBhJsMSIJRaybjdOyx57n0afYns
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB12819.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b769aa-de75-44aa-3ef6-08ddeb7e1edb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 06:41:47.2258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WQSYGnBNF+lzltlSUFo+WmJgudycBfWvU+bnXGoE2JGjOZDKOtvUUtappEQO92x6DZRX+zPkHQIGCeMkEOUW20/xmcFDEqAYSAuIDs5Xjmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13415

SGksIFJvYmluDQoNCj4gPiBUaGlzIGFkZHMgYSBuZXcgZHluYW1pYyBQTVUgdG8gdGhlIFBlcmYg
RXZlbnRzIGZyYW1ld29yayB0byBwcm9ncmFtIGFuZA0KPiA+IGNvbnRyb2wgdGhlIFVuY29yZSBQ
Q0kgUE1VcyBpbiBGdWppdHN1IGNoaXBzLg0KPiA+IA0KPiA+IFRoaXMgZHJpdmVyIHdhcyBjcmVh
dGVkIHdpdGggcmVmZXJlbmNlIHRvIGRyaXZlcnMvcGVyZi9xY29tX2wzX3BtdS5jLg0KPiA+IA0K
PiA+IFRoaXMgZHJpdmVyIGV4cG9ydHMgZm9ybWF0dGluZyBhbmQgZXZlbnQgaW5mb3JtYXRpb24g
dG8gc3lzZnMgc28gaXQgY2FuDQo+ID4gYmUgdXNlZCBieSB0aGUgcGVyZiB1c2VyIHNwYWNlIHRv
b2xzIHdpdGggdGhlIHN5bnRheGVzOg0KPiA+IA0KPiA+IHBlcmYgc3RhdCAtZSBwY2lfaW9kMF9w
Y2kwL2VhLXBjaS8gbHMNCj4gPiBwZXJmIHN0YXQgLWUgcGNpX2lvZDBfcGNpMC9ldmVudD0weDgw
LyBscw0KPiA+IA0KPiA+IEZVSklUU1UtTU9OQUtBIFBNVSBFdmVudHMgU3BlY2lmaWNhdGlvbiB2
MS4xIFVSTDoNCj4gPiBodHRwczovL2dpdGh1Yi5jb20vZnVqaXRzdS9GVUpJVFNVLU1PTkFLQQ0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEtvaWNoaSBPa3VubyA8ZmoyNzY3ZHpAZnVqaXRzdS5j
b20+DQo+ID4gLS0tDQo+ID4gICAuLi4vYWRtaW4tZ3VpZGUvcGVyZi9mdWppdHN1X3BjaV9wbXUu
cnN0ICAgICAgfCAgNTAgKysNCj4gPiAgIERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvcGVyZi9p
bmRleC5yc3QgICAgICB8ICAgMSArDQo+ID4gICBkcml2ZXJzL3BlcmYvS2NvbmZpZyAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgIDkgKw0KPiA+ICAgZHJpdmVycy9wZXJmL01ha2VmaWxlICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiAgIGRyaXZlcnMvcGVyZi9mdWppdHN1
X3BjaV9wbXUuYyAgICAgICAgICAgICAgICB8IDUzNiArKysrKysrKysrKysrKysrKysNCj4gDQo+
ICBGcm9tIGEgcXVpY2sgc2lkZS1ieS1zaWRlIHNraW0sIHRoaXMgaXMgYSBjb3B5LXBhc3RlIG9m
IHRoZSBleGFjdCBzYW1lIA0KPiBkcml2ZXIgZnJvbSBwYXRjaCAjMSB3aXRoIHMvbWFjL3BjaS9n
IGFwcGxpZWQuIFBsZWFzZSBkb24ndCBkbyB0aGF0LiBJZiANCj4gdGhlIGhhcmR3YXJlIGlzIGZ1
bmN0aW9uYWxseSB0aGUgc2FtZSwgdGhlbiBpdCBzaG91bGQganVzdCBiZSBhIHNpbmdsZSANCj4g
ZHJpdmVyIHRoYXQgY2FuIHRoZW4gcGljayB3aGljaCBQTVUgbmFtZSBhbmQgc2V0IG9mIGV2ZW50
IGFsaWFzIA0KPiBhdHRyaWJ1dGVzIHRvIHVzZSBmb3IgYSBnaXZlbiBpbnN0YW5jZSBiYXNlZCBv
biB0aGUgQUNQSSBISUQgbWF0Y2ggDQo+IChhbmQvb3IgYW55IG90aGVyIElEIHJlZ2lzdGVyIGlu
Zm8geW91IG1heSBoYXZlLikNCg0KSSd2ZSBpbnRlZ3JhdGVkIHRoZSBNQUMgUE1VIGRyaXZlciBh
bmQgdGhlIFBDSSBQTVUgZHJpdmVyIGludG8gYSBzaW5nbGUNCmRyaXZlciBpbiB2OC4NCg0KQmVz
dCBSZWdhcmRzLA0KS29pY2hpIE9rdW5vDQo=

