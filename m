Return-Path: <linux-kernel+bounces-736289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DFDB09B09
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A33B1AA6252
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469AB1E8837;
	Fri, 18 Jul 2025 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ue3v70QQ"
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421931DE4E1
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752818176; cv=fail; b=L4H/Uw3SdynxwySwCow+n6gusQw1DApZVQydX3Wz4ANtrgfPSHjVMfEuwB7wB6Abv0AiIORiyBTkKOgLy/snWNaBm8g30/arbdzSBJESIWzQodXX8n4IwfgXwu3PMWAaNT2ssN70oPW7PJ5024e2T7kezpOmGTGK+VAqDidSDvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752818176; c=relaxed/simple;
	bh=EpX5ki4uEDrjgg0L33EglrMa+bqkD0yir02x2E5D2kc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MFzegdm7EEnWy6LDHp/mWuxTK/syacRG9lKyDZ0WrjpahT+Szyxk6crFFbnqVg4+AYef0wXSG6R5nHUxEQ+F7eTk+gjgvbHPpKtAe6qaeAX6UKE1T+1xmueAtitkGvT39X4Mf+s53kB+WY06OusV9sIJokuamkKao2/hrRF1VC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ue3v70QQ; arc=fail smtp.client-ip=68.232.159.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1752818174; x=1784354174;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EpX5ki4uEDrjgg0L33EglrMa+bqkD0yir02x2E5D2kc=;
  b=ue3v70QQj3VZppD/gwAYxKZtDDwnFDN55Ozj+6i0RfYLREle0xyOX97R
   bmF432BJCx1PH5Bq2oMfFEanzRUH1amYxZ0bOJMy8UDxBHP01vwjTKF1/
   ZZfSCqpPLRsXnhgZjyvhAYYUWzBKiioBO5xLxNWttpaey1loe2/f6HzHx
   VYhOXP+M5TEIIWkCW3/sqxey0okqL5H/hy+eSRzQ6h9gzv8Gsvg3uSjid
   3s7DUbqrtWqjuSwEU2F/J/BnYVPmOYgD8wAEdHMgCHSIO1In3kDcNwnuH
   QilVgdmrn12VCkcL5jeojmlNcabx3CVuXusJzavhpHdsvY2+AaZSkzjL+
   A==;
X-CSE-ConnectionGUID: kbY2mcoMR/yU+50weLgh3A==
X-CSE-MsgGUID: slK95jUmTMKgMxO08mz96g==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="161946400"
X-IronPort-AV: E=Sophos;i="6.16,320,1744038000"; 
   d="scan'208";a="161946400"
Received: from mail-japanwestazon11010045.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([52.101.228.45])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 14:55:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwK834KGBvDsiTxv3tSjqtcVwl5gH0cXRNnV2NGrt3Q/wCD/dRtI1FRzpSLxX4mBsYefrGTjLp5HSW8W7fhNazPpPNZLAC0cXCh0LPWwH0b/NPStOqBKVyQDSygdxxETHk+1HW/d3Aji9Ga5XfhsEjBkQjM/G+DTiikt7FQxCNOt+NEwYLrvr3pbpT7P6VObfyJ7lifmounK8LMxTh3hKcoSqag0Y9Zm3VurMm3gF21oEBUHlu4TpB8k4chkF51kl8PUkBZ/xUzEsNR4sw3o1Nv6daygJks5YvIKbeMO0nReeFR6Hf2PDjYF7nV2iJV0xF5BqBE6AxLOCEc+Lcz99A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7krkLtfj3AvK9kzSMLqK4Hhjyh/vYPSCXhpDn1//gA=;
 b=A0AOJBQSEuMSTADf/ozeEhz/KNdjatxfEG+fjEMCa2t87RGmtAp3FCiY7yeHiiD74VarmTZzh5HxoQ9E5BV3INS291XHPpXoAb9ZwyyAP+l6Km8OcIa0UB8Ew6wa1wTJ4imygrjDOtsSGkNoK41X6JNaoWmh15OAOCpv8C4PdPDWvqtKovxRIwLnP/e3XGViek+ZhaxVLWeEh93MjOB6s1jwS15MBf90SGn2BNvU3ifal89l/m19waLQP43T5F/NnvdXTcbrj/8xh2cLA+Bc8Kq5DL8kK//XGcFO1XlF2b3hB/QGxmueF54uon0rrwfEz+QZppVTsO6QyuALtZw0vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYCPR01MB5584.jpnprd01.prod.outlook.com (2603:1096:400:42::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 05:55:01 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672%7]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 05:55:01 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Reinette Chatre <reinette.chatre@intel.com>, James Morse
	<james.morse@arm.com>, Yury Norov <yury.norov@gmail.com>, Dave Martin
	<dave.martin@arm.com>, "fenghuay@nvidia.com" <fenghuay@nvidia.com>,
	"peternewman@google.com" <peternewman@google.com>, Babu Moger
	<Babu.Moger@amd.com>, Borislav Petkov <bp@alien8.de>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "bobo.shaobowang@huawei.com"
	<bobo.shaobowang@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, "carl@os.amperecomputing.com"
	<carl@os.amperecomputing.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	Xin Hao <xhao@linux.alibaba.com>, "baolin.wang@linux.alibaba.com"
	<baolin.wang@linux.alibaba.com>, "lcherian@marvell.com"
	<lcherian@marvell.com>, "amitsinght@marvell.com" <amitsinght@marvell.com>,
	Ingo Molnar <mingo@redhat.com>, David Hildenbrand <david@redhat.com>, H Peter
 Anvin <hpa@zytor.com>, Rex Nie <rex.nie@jaguarmicro.com>, Jamie Iles
	<quic_jiles@quicinc.com>, "dfustini@baylibre.com" <dfustini@baylibre.com>,
	Thomas Gleixner <tglx@linutronix.de>, 'Koba Ko' <kobak@nvidia.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] fs/resctrl: Optimize code in rdt_get_tree()
Thread-Topic: [PATCH v2] fs/resctrl: Optimize code in rdt_get_tree()
Thread-Index: AQHb5BDoGYH617ES+kufYfYeCAFpnLQ3h3Vg
Date: Fri, 18 Jul 2025 05:55:01 +0000
Message-ID:
 <OSZPR01MB87985042129BAD34812742F48B50A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20250623073154.3320458-1-tan.shaopeng@jp.fujitsu.com>
In-Reply-To: <20250623073154.3320458-1-tan.shaopeng@jp.fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=fa5149da-78e4-4a89-8b67-5ef26e34ddcb;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-07-18T05:49:58Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYCPR01MB5584:EE_
x-ms-office365-filtering-correlation-id: ec09e3be-c362-415c-0d34-08ddc5bfa290
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?ZDBKbnAwK0VweXVmRTFZQnJxZ1g2dTJQdGxzMm8yUnJMUWk2cW1KTE9w?=
 =?iso-2022-jp?B?eGtLQStiektFUStCekJMWEtGbWg3cVpOemJJT2dHY25UM2VzMEsvYXZH?=
 =?iso-2022-jp?B?c0RiZTZ5V2hzeXhqRjVBUk1ablhoa0FrZi9GZ3hiWmphbHZNSlg2dWNF?=
 =?iso-2022-jp?B?b3BKNEhzZ3dVSWVJMjgyY216bmhqajB5bFlhYm5PNzY1THFzbTg0M3FG?=
 =?iso-2022-jp?B?aXFESWZuc2hzeUFzUThtQXN2QjA4VzdLVXl6NG1LSS81azljYTR2MjFs?=
 =?iso-2022-jp?B?dWFDT3o1Uy9nMnJwS29TNm52YmhJOGFqOTVOd2JROFVHaWE4ajRxVi9v?=
 =?iso-2022-jp?B?b3lpaHVQVE9xS0pDbXMweWUvZnV4dDdBbmphdks0WWxsTWFmMU0rLzBN?=
 =?iso-2022-jp?B?RDNtWjFQczFHWEFLWXRDUWU1Vm9IdU5JYzZ3M1o2cEZHUCt5Ni9YN285?=
 =?iso-2022-jp?B?N04yRTc0MU1TNEtWcDJoRFQrakxGRXF4Ti9vbVZyeXE2TFJwNVVKMTc2?=
 =?iso-2022-jp?B?MGFScktNd3RvQ3VieHYvby92S3RQYkV3Z2V6N3l2aThLblVuZkVLdXVJ?=
 =?iso-2022-jp?B?MnlrcEF3RDdvM2JNQStwaFdJV1NXeFMzeFNkSjRjQVJlMkFhRWcyYktL?=
 =?iso-2022-jp?B?UzRyQTV6SGZsaXdSNDVpODhtNEFaRWVqelpYRk1xWXVBNTVkWHlFVnIr?=
 =?iso-2022-jp?B?YlNWYnN6ekZMQis4eldoL1NWalBmU2svMERxWUNMM1lCTVpzS3J6TDZB?=
 =?iso-2022-jp?B?TWw1Qk5jY0RkMDRWcXdXci9ycnJTQVZYT1pPVjVKWjc5QzR1dWhZMFV3?=
 =?iso-2022-jp?B?SVU2MXUycG5xU3F3K0V2c05CdFdXRThnVEhKUnNTL1cvSUphcTJXcGlH?=
 =?iso-2022-jp?B?Y2NLci9ocjNoQlBxV2I5aXhjSzM3a2NnTk16cWFsOVloZEZFVGhkZS9v?=
 =?iso-2022-jp?B?RDc3dDFmQ0syZHU0YUhUVnU0V2Y2WDUraGdWV3p5SU81M2cyZVJDSGc1?=
 =?iso-2022-jp?B?WDB1eC95eWgwY0FoZVVkbEFoVWtlbWxFU01yemhFdDFGMXpGaFBoWGhz?=
 =?iso-2022-jp?B?YjdNYXR5QWx5ZnlsUkpUcEVWQ3hQMmtQd2d0OW15Y0l6bkFNY3h6a09l?=
 =?iso-2022-jp?B?Z2YxYmgxUWJUOUtxRVM5WkZTYzNDcXo5K2lmdHRHdFlaSURRZ2Jhc2Uw?=
 =?iso-2022-jp?B?M0tsclRJN3pQaFRmdHA5MU1XYkNxdFk5Vy9Tb1pyN3FGMEMwUFYzOXNK?=
 =?iso-2022-jp?B?eGVrdlJPb2JhZy9jaTdRNTVIS2EyREhSRFZ6d0pUVU9aeVh2NU1ZTXVj?=
 =?iso-2022-jp?B?ZE5aaWxYUlZWWWRFcTZUV1BFQW5KWXJEOXRsMVlvMHlGRUZFaWovOWVz?=
 =?iso-2022-jp?B?anpFakgwRnJkNUZBTzZwdWUxZFRyNlZkTmErUzlmVVJ6ZjFvWitiRk13?=
 =?iso-2022-jp?B?S2lMbnk1S0hxTDRnNlBqeStsSzFvQVNLVUhNU0tSelBnQnVhdkRVSkw2?=
 =?iso-2022-jp?B?dC85dEh2aWp3WS90MVhiSTdTK0JjOVJGVW05QXM5VzR3dDhyUzhvYlFt?=
 =?iso-2022-jp?B?Sk5kUnlVVmR0aHA5c0g0U0NMRFd4elZyZUpXNTM0bXh0dHdkeWhmUW1J?=
 =?iso-2022-jp?B?TXlPa0pHUW5aOUtIYmNLYkpOcmxHbG1abDNZc3locG9XSG5mRVdqR1JZ?=
 =?iso-2022-jp?B?R0p0emVMdmNCaDdRWmZ1NjZjamszbEJpbHMxckJLS2gwNStxK00xblhu?=
 =?iso-2022-jp?B?bk0yMUF2a3JxbEY0SlVIUnRHUWpzV3BpS0JpemZTck1uWHNya3h0Tzhn?=
 =?iso-2022-jp?B?SXp4bm9uNTNZZlVLZHo0UUlmYTRCa1FKaDM0TWZnU0IyN2poeHRqVkRm?=
 =?iso-2022-jp?B?L2xIZnFLaXNoSmJNNmdKc0RqNzN0UnJ1OEtFb2dBY243a1Q0cWkzcFpU?=
 =?iso-2022-jp?B?Y0htckdRL3d1ODBpWG1weWd4STE1N0oxZS8zL1M4MTRJSGRRVG5RK3hi?=
 =?iso-2022-jp?B?ZDN5UFJFQ2U1cXE1Q3lwTHp3NUx0eDIwNXRxWlp2TUF2NnpWS3hsK3l6?=
 =?iso-2022-jp?B?Qy8zbytmMEtVakRWUk9tcXl4eUQ1Um1rNTBES0Y4MndxVks1Nkk0eUR5?=
 =?iso-2022-jp?B?c0tWckNRNDVjSkozRzFqblo1RTVRbE9UQlZqL3ZIeW8zMkMwOGpWUExi?=
 =?iso-2022-jp?B?L1NxSE5YcGNvdWMxQS9YUExzVEhWbVQz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?K1JybjI3bVhIU2ZFVTBtbWtLVlN0MnNIWW1jK3lsY1dIUVlYZWh0cXo1?=
 =?iso-2022-jp?B?a1lZUkpFQXVTS0NtTitPZng3WTFJc2hUMzFjK0FQaWVmc2V3czdrUVFu?=
 =?iso-2022-jp?B?dTQzU0o3T0tacU9MNFBOVitWaWZxMnl1SGEzdFoxZFRBWEFiRFFjQzFL?=
 =?iso-2022-jp?B?RFhJQ08rZ0V6VjlNRnJjTVBJN0RhaG5BalZkamtJa2ViNHNFT3pjME5k?=
 =?iso-2022-jp?B?ZitiMTlUeWRXY3JVM1o2K3grcnZ6ZWIyckJjNUszWjVrWm95azN0SDZa?=
 =?iso-2022-jp?B?UWVOUHZCWFM2c2Ryb1RhQlJubkZHSXhQbkVoQjV6djZYekI0RkhMN2FC?=
 =?iso-2022-jp?B?b0ovei9ubGxkZXNiZkZONUNPQVkyMDVsZ3BzTUZzZFBkaEJlY3diM2dR?=
 =?iso-2022-jp?B?czEvRUpRNlBQMStkWFY4TjRRS3dOMCsyeUNWbFlzaHBGVUozVXNKUzBU?=
 =?iso-2022-jp?B?QVErREJhdEVjL3VaNkFYUHRxcUNSV20yYVdWQWFDd0xCNkpRSzJvTUJk?=
 =?iso-2022-jp?B?Qm1iWTA2emwzS1dQYnVyTkxQNVZYVTkySVVqSUsrUDVhOHRyWjQxbFFx?=
 =?iso-2022-jp?B?NjdoWmZRUGtmdlhHbjhTZEg2RVBBMFJvMFp6U3NPdjRjb1FVaHVaaExJ?=
 =?iso-2022-jp?B?Nm00MGp1UUFqcVpQaUtWN1M1dFhiQ1FrQXNvaWNIQnlFdW1GSG02QVla?=
 =?iso-2022-jp?B?Qk9xeE5YcW9kbTJuWG1yYnd4ZmdXQnJIQ1FKbCtvdWQ0UGQxQmpxdSs4?=
 =?iso-2022-jp?B?bXJFd3hPWS9PYWFyT0J2MmZNamJxbXFBRVpEVzNQSVRxdGF5U2puVTY3?=
 =?iso-2022-jp?B?ZzRsUldvZHR5MzhSWTQ5Mko0ZXNjcXVSTDB5NzVnS3FMNllCd3RRRmhs?=
 =?iso-2022-jp?B?ZVE5N3grWlBFeEdKWWtUdlZCZ3doOGIwQzVhb3F6MUErQS9iRGh4U0U3?=
 =?iso-2022-jp?B?TGJIbTRhZEpaa0ZSNHd0RXhOWTQ4NTZlQ2h0YitFYlpERFVxTitXNGJq?=
 =?iso-2022-jp?B?bzB0WDRhOU85cjRzQ05kbk5rYUdoZno3TlN6Y2dhbEpmUFJ1ZzJmMGRn?=
 =?iso-2022-jp?B?RmthemUwem9pV1pmOTRsYytzeTNjL2xSZWdmMTRMcDh5Yzk2eG4rYkxk?=
 =?iso-2022-jp?B?d0k5Wmk4NU5ZTmdPaFV0THhzemdxNWl4Tm9PNFlvTXpOZ245b1hrUXhR?=
 =?iso-2022-jp?B?ZnlxSFhMQ0V6bVVpT1UvdmxNQWVOWkpSSEdKVVljK2NEejU2cFJrbWdF?=
 =?iso-2022-jp?B?S1dDSmxyZHpjRzd2T2hrZGw1NEdzZTJKdWV5QlZrdmIrMzZnbmVsS3R3?=
 =?iso-2022-jp?B?c2p6alF1YVJESVBXNm9EQmdiRlYveDBoN0JTNkZXTXZyRE5MbGpHbjAr?=
 =?iso-2022-jp?B?OUZlL0QyTnRGZmFZZXd0bzNrWnVMb2J0WVp1NUJvajdlMWg5d3lBYmh6?=
 =?iso-2022-jp?B?Mm9LZUpUQzZWdnBORlpjdGl5Y21zWlhEOC9sVVc0VDlDRzZsY0dzVFEy?=
 =?iso-2022-jp?B?U3gwYWdpcU5xeTRwRDVmYU5ZT0hlM0tXenZRa1ZzRDV0VDZDM3MzaWUw?=
 =?iso-2022-jp?B?RlBLT3JVTnBYV3B6VHNRQ1VCc3Q0MnFEOFN2L2lvdXhsc3hqQ0JRNzh6?=
 =?iso-2022-jp?B?aDJJT3ptNDBCeGxPSGhjTHRUSXE5UENMdHRuZ21raHZCNGpOSDJWc1JK?=
 =?iso-2022-jp?B?R0JBeGFub3NTdTNISmp3a09sQWJ6RVZ2T0Vsa2FDT0tScmNTd3RkUFJ5?=
 =?iso-2022-jp?B?NTJ0bnQzWjhWZGZMRVRkSm5NOGY1NXEyVWlKMWFMM3NFcEM2UURMcEhH?=
 =?iso-2022-jp?B?RDZUWjdvS1BOYTczVWgvQVMzRG5hdldLQVFMVzVBcE9WS3BlTnVSdDZS?=
 =?iso-2022-jp?B?NWVSOS91enZ3VzVFTDYwRFpKb3lnUG4xZ21nWWxiZ0p2a0xNMWhGMUxR?=
 =?iso-2022-jp?B?YkJ5T05TRC9qc0N0TEpuc3krdTVsdXFCQXh3d3hhM3dpUFE3NzZvY1dZ?=
 =?iso-2022-jp?B?REExNnJ4Q3V4RTgxWWFYdEFNNmQ2YWJNSkdGUWFIWTRXNG9tUHdoUUl3?=
 =?iso-2022-jp?B?Mmo3eEl4VFRVMUI5bm5LMGJXRVNjSDUwc28zbkZBTFNpRi9ZSU5rOEwy?=
 =?iso-2022-jp?B?RGlsTTkyREt5VUNGMlJKbzVoL1RNWTBScFY5TmI4eW9TeDRsYVlTVEtR?=
 =?iso-2022-jp?B?R1JjYXJVd0lZNk5OMG42eFh1T1k1dlZCK3BMNUJ1czdacmFlbWJlZEF2?=
 =?iso-2022-jp?B?dGtOR1RQTlptckdKdXd5Ty9QYW55aUtvR3gwb3pmN3k3ckVsNitTak05?=
 =?iso-2022-jp?B?MWdMTzl1Q0t1K3NvZ0xZZlcxaUFRTUxOUWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9hS8FE6dbjSgcYW1f22QuhfgF8xiourEQWqXGBiKNJj/Opegv/yXfbSUdz//sn80Z/vHJ3M8PTRUX6YXxfzl0us2fbgqSF4d3Je3Hu6RYjK+KLQZGSPvoDe8pPM57dsZclyoMsk98MU4Hq2hbNM963d45L8O88N7QYUNiiMhxdI6iAhmm6x4+XPNoE6UGxVXIapQRBJxiPYrFIkWrwiPtnIeNfrZlCQTzZxOBv/63926G/7AbbnfZ9XXrAhucifpYNmeVcle3tozmSUouF8ry1AubK2X8WLG3o8aOposRkJNMNODup8VLDDmRTY9RN4svlNE/NU6V2wgU2vqiXSq/XH+PfjtVdEPcsf8d4VbHfpON8C6SVtK13JiHhFoww7AdXq49A5HW2K0VH0RoOwMk+G/lUkhHgmCnoBOuLyGd3jb8xdwa8pJCWChkFo0EWp4TNA5bOGDHN1DwlCkNXmUz6gYECRqGBcX6bzh3dCuUO4VRBLeZB8fshTz0ek5EQOTfGwnEtGNnACBCs+m5YOEIGjuXU5FZLuRv29cIMm268rBgjuqGIRFtOSx4JyJS/v1a9+lKiiX6Lj1qY11bCSyyDMY0QS9l4n1W0Le49unBSFd8B1vA909oFpGhGNGZuhV
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec09e3be-c362-415c-0d34-08ddc5bfa290
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2025 05:55:01.2795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: goMBoSgAjlqqTW7Nl2mMtVQ8d55ijGzzaKmTtVOVP9CZhhGZCVHHikensWP1VySXR0Xx0sHMTEuGmVoUoaGFlmSnOEEln4dlwgThc/6FPdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5584

Hello Reinette,

Do you have any other comments?

> schemata_list_destroy() has to be called if schemata_list_create() fails.
>=20
> rdt_get_tree() calls schemata_list_destroy() in two different ways:
> directly if schemata_list_create() itself fails and on the exit path via =
the
> out_schemata_free goto label.
>=20
> Remove schemata_list_destroy() call on schemata_list_create() failure.
> Use existing out_schemata_free goto label instead.
>=20
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
>  fs/resctrl/rdtgroup.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c index
> 77d08229d855..5f0b7cfa1cc2 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -2608,10 +2608,8 @@ static int rdt_get_tree(struct fs_context *fc)
>  		goto out_root;
>=20
>  	ret =3D schemata_list_create();
> -	if (ret) {
> -		schemata_list_destroy();
> -		goto out_ctx;
> -	}
> +	if (ret)
> +		goto out_schemata_free;
>=20
>  	ret =3D closid_init();
>  	if (ret)
> @@ -2683,7 +2681,6 @@ static int rdt_get_tree(struct fs_context *fc)
>  	closid_exit();
>  out_schemata_free:
>  	schemata_list_destroy();
> -out_ctx:
>  	rdt_disable_ctx();
>  out_root:
>  	rdtgroup_destroy_root();
> --
> 2.43.5


