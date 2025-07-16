Return-Path: <linux-kernel+bounces-733022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EF5B06F06
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D102A189A5F4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4502D28C01F;
	Wed, 16 Jul 2025 07:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="IfhG9mXc"
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645A54A11
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752651297; cv=fail; b=Xyu3yS9TCTvFHd8p9zpb3b+5FfYZvk88gYkLMcrNV2H6zJUT68UvTQLfR+Wfa6VYFJ3R9VzXS+3VGpx+rl+5DX8oK2DzhFhc4R3WxeaR5OS05kfuFK+Yx6ftyDF/KK6tftpUl/nRUt2eMkAUdjHEScNdHmcXpHq3H/UMaMqKWY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752651297; c=relaxed/simple;
	bh=J3l2sOU2DFSRGQDTDkzCa1rdSWOCnp53a1SWHt01W4g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BbVlA1f91hZTHL5DFhQdP5frsfAfkY2d/+IBOzyv0Hm8twpfL06iE8+usap4amAEsOyDJxIKEBQKd7ZuL+T+P5Xz5E2rOX0s9gyJtq8m6Jkjhg3Xg0C8u0Msw7rlcOB3YA7N27ek12aveP+8rxNAT0sp0P+hrVAQ4tWKXsYW+i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=IfhG9mXc; arc=fail smtp.client-ip=68.232.152.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1752651295; x=1784187295;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J3l2sOU2DFSRGQDTDkzCa1rdSWOCnp53a1SWHt01W4g=;
  b=IfhG9mXcfU/HbRsXYZKwmvPHqfV0Pz5kV4sjx6l6Jk+k7q8YJk2wWCx9
   YfJmLLieUxrAWJE+D1xEzQN+IRFY6QpeQAYKN0F008LYE7plyjxUrCXaR
   JFZB7JATk10V/x5hXvIIme/MQE8lDlIjjpdHeUDHYj/SHOu0gwRgs+97K
   p9nojJckojOF9CD5KkHB0UQfAYROyfWXCtrYRPXfFCWgrpdPwnjL5xTbH
   P8xIJaMmwofZ0OMga9DppcrRYnX7LFXkwJAhsfQ0XgAxpoUGhvmnScsdi
   j1nkJhNbSAbDElVG8Sz5wV3thzSoKT5eAWP3RE3OywgNbs/i2t2lSYVz1
   Q==;
X-CSE-ConnectionGUID: GGvkFF6DQPOM6Q3awJvNBw==
X-CSE-MsgGUID: RPd+ceUOQ4iVr6Dpku5IoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="72677897"
X-IronPort-AV: E=Sophos;i="6.16,315,1744038000"; 
   d="scan'208";a="72677897"
Received: from mail-japaneastazon11010005.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.5])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 16:31:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUXREjoIYGZMau9qvLiBCOO0WhWO/dYGBqVAm64VDVUQrmAOvJ9WjhEsTytk322J38jGslAkcBdXhMjJkR7rnzHhvM8h3RSIGJ4Q9nwmCXpL8uShmAh5Y6rJWSKxP5F7HVTfpdr1ZF0PO/xuNelPzSd9l93fG5aiB3dNTgdqa6jSpq611Gkcb5uj3RZWdv8r4bkkWpcwwdE/BW5VEuG1u41FqT0eGQUGJLZHLMJ23rg7E5r/y9deacXizycG/AvXs55gJv9NbhwX8tYvsCMZJ4NfO/lEeQoXXnJRBBpD20MhrFJ3hpLgCx68q/84Hxa2uZboHn1zwQJWKgkYb9Ortw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYrD5DUk47S4cuDkYC0FhnSYMaKGNHBndcDnppwV12U=;
 b=b8wgfukQB82uFf1xXc9P8OBGwHRL3WlK5d64onx1Oj6arzWc3o8pZcWDzKRDygvBPPdia7E9hl7QJ9OQNswJy5Sp2T4oAAL2IZxkwFufKYVh+bKoeDoGy0zgIBd1LjpCu3uLe78EMymv2oC9orHf+tEDnTJhefgdU4WD9OX3dcLYnWN6jF3YtV6N0v1bBnuehxB+p3gNnCqMkQwc+uNZDGmK30wV+D1N9/oeQ0m6ZaZATHOEZkxWMB6uw0nSBZgBbDA3SrCkxA3MQKTK0ZyeZloDSTbDTtP4FX0WL0van+mzg42ZPuLATcX6qYWJeZg7/tKMFRGBDRYCn5BbR6gItA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by OS9PR01MB14305.jpnprd01.prod.outlook.com (2603:1096:604:366::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 07:31:25 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672%7]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:31:25 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'James Morse' <james.morse@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: Rob Herring <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>, Rohit
 Mathew <rohit.mathew@arm.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	Zeng Heng <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>, Carl
 Worth <carl@os.amperecomputing.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, "lcherian@marvell.com"
	<lcherian@marvell.com>, "bobo.shaobowang@huawei.com"
	<bobo.shaobowang@huawei.com>, "baolin.wang@linux.alibaba.com"
	<baolin.wang@linux.alibaba.com>, Jamie Iles <quic_jiles@quicinc.com>, Xin Hao
	<xhao@linux.alibaba.com>, "peternewman@google.com" <peternewman@google.com>,
	"dfustini@baylibre.com" <dfustini@baylibre.com>, "amitsinght@marvell.com"
	<amitsinght@marvell.com>, David Hildenbrand <david@redhat.com>, Rex Nie
	<rex.nie@jaguarmicro.com>, Dave Martin <dave.martin@arm.com>, Koba Ko
	<kobak@nvidia.com>
Subject: RE: [RFC PATCH 25/36] arm_mpam: Register and enable IRQs
Thread-Topic: [RFC PATCH 25/36] arm_mpam: Register and enable IRQs
Thread-Index: AQHb8pL/ydsOasyOj0OV22KVGGpjDbQ0V5qg
Date: Wed, 16 Jul 2025 07:31:25 +0000
Message-ID:
 <OSZPR01MB8798186D954C5D36FDA3FBEB8B56A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-26-james.morse@arm.com>
In-Reply-To: <20250711183648.30766-26-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=a6c4e751-20fb-47b3-a20f-79657d5bcd93;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-07-16T06:53:46Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|OS9PR01MB14305:EE_
x-ms-office365-filtering-correlation-id: 942aecf2-deac-4aed-2e40-08ddc43ac553
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?YWJ4S1dwTGZsSGhpZFd4Qmo0Qmx1ZEMyZGdiNSszUDMvckhvRGVUTGVP?=
 =?iso-2022-jp?B?U0dLQlBGdEtOQkthOGgvM1JkL1BibFhBSnc4d2ZyQ2hsSXdwRi8ybTEr?=
 =?iso-2022-jp?B?N1pPNFJXajRMSzg5TVlEK25CLzBSYmxIYjVGeWRmVngwcUYvTGNCMlpJ?=
 =?iso-2022-jp?B?ZGc1dnFrVFA3QVlFNHExVVlBQjRxUFEvZTBYdG5DQlA2REY2UHFiN0Rs?=
 =?iso-2022-jp?B?VkxiTE5CMjhheXZLeE12UzhCRGNZeXZuc3RMTVpPNytRMXF0TzNLMVJV?=
 =?iso-2022-jp?B?QytmalhvYzdjbWM3Nmlhem4yK1RNY2lnSzVNNFFnZHVEcVptN1owdm1K?=
 =?iso-2022-jp?B?ODZpM1M1ekFZY1dPeGlOTFZCc2JESHpoTXUyeVpwLzVyM1Mwa3lsY09W?=
 =?iso-2022-jp?B?OE5hZEJmM2hzQ1A5bXg3cUw1cXk3ekF3dWszTkN0UWdJbDFrY3lBRzlM?=
 =?iso-2022-jp?B?QmRWTU1wdkVrSHkyaGtEbWYvcmF6TmIyUndDMkc5MWpObFRuM2pKNkx3?=
 =?iso-2022-jp?B?eGdVNFpZUnBuNzZBN1ZTc00yVVlSa1Z2YXhxQm1VWnJTY01sT3hwWXZ6?=
 =?iso-2022-jp?B?OHAzWEZRYkdUdDNJc3Q2QkpNSWRqSXZ5ZWRxa3NDNlBnbmhTRjVibnBC?=
 =?iso-2022-jp?B?YkhFU1BneTUrMVdmR1lSSWFHR2R2ZGFQOWluMURRdXNFa0R1ZnAzU2ZS?=
 =?iso-2022-jp?B?MUtJYmJxdk9PaVg5RlJsYjVXY05ONUdkL3Z1RldRMU5rM0tNenFuTE5L?=
 =?iso-2022-jp?B?MVBGbERJQ212NEFQcEh3dExTZmQvclVNUW16TU1hTDBVUFFhdEtHMzl1?=
 =?iso-2022-jp?B?UjRaZzNVbFZUUjNRbnMwaElxbjhVb1VYNU83MTVFZlVWd3Fhem1mWGNa?=
 =?iso-2022-jp?B?V3NNK2VZdTNNQUZtVlh1bXNuaUphNnNYNVkrR0RaSEtpZXh3dzMzOWx2?=
 =?iso-2022-jp?B?S3JYa1hIcmsrMUhDbmY1azJua2ROTS9GYUFoVUtZeVB4QllhY2lIZ0li?=
 =?iso-2022-jp?B?enpLYnljSVFXanFqUU5vK0MvcEVxWENDK2dNMVZsOTRoYXRxTkJvZW5K?=
 =?iso-2022-jp?B?UTNJSWNEb2grcGUxL2MyOHQ5eTRBOHhKbm5Ca2NOMC80aDRhbmMwdnJq?=
 =?iso-2022-jp?B?K3ZmelZRWE1DcmZ0VWl2Q1cza2Nyd0lYMm9tNkVObVdsZFlOSDdoM0RG?=
 =?iso-2022-jp?B?Z0cyOU9jVTRmVDFDcG5LSGEraUNGdldBSEZ0Z0p6RDA4aWFVOTlpcHZJ?=
 =?iso-2022-jp?B?Z3JycXAxZkFkeHowekZzU0JkMGxpMUFlcU90UmxvMGQyY2x0YmNMM2Zz?=
 =?iso-2022-jp?B?ekVWUlllVk84NkdEM1FvclVmdHVBMGNuWnVGcnZ6eW9FdThZdmxiU1JT?=
 =?iso-2022-jp?B?RzZXMGJSYUNPd1V5U2RBaEoxSGZ1STlEL1ZSMUVDTUgzVWRrOXZmTEFs?=
 =?iso-2022-jp?B?R2FmZWFLaGpORUl6TGUvcGxLK2p1cU85SU1yRmw4Zkc2WFMveXZnVlYv?=
 =?iso-2022-jp?B?eWVRWm1vQ2hWYjF4M2ptWWZGQ0VxaFQ4aFlFYkVUUDRoNnpqbHdsWDAw?=
 =?iso-2022-jp?B?K2tmZFZlOVRFTWlOUFBkMTFEcEVIWkgwZlZTVzR1RklOK0g1T29kd3Y0?=
 =?iso-2022-jp?B?NXY5UHpaWnoxdXQwMUw2dXREazJ2MWN2V1FwVmpybzBHWlNzSDNuS2dM?=
 =?iso-2022-jp?B?d1VhNHkwZUZ6WStEa2lObDZmVFJxam9HWHY4MjlwYVFxbkwxbkQ4M3I2?=
 =?iso-2022-jp?B?dVZ6TXBVa0lIWUZLelJJYldKRERKd0JMaFdnTG9ZbTBjMmFzaEozYlRR?=
 =?iso-2022-jp?B?cDB0NElTWG5hWndjMUtZc09LMEd4WElISS8yS0FnU2lNWGM4aHc5VHVs?=
 =?iso-2022-jp?B?SmVET3lYMHBCeFpqemNmbEpUQ3I4R0k5dmhXRXRFVmIvL1VIQVlpQ0Rx?=
 =?iso-2022-jp?B?VDkrUXJWMXR6NUZQbzU4am4wajZ4bk5OWVJTaWdvOWFTVEZ3UzFXekhy?=
 =?iso-2022-jp?B?a3E1ZVNWVDJtVy9IcU5kUXhsQ3VqNGdOUTF1bFc2bTY5L2lncU5NTVhP?=
 =?iso-2022-jp?B?YkRqemlUL2szeTFXckV6MXFKNjVkdU01OTZHSm1RNHJhZUV2c2hVVllv?=
 =?iso-2022-jp?B?UC9sM0ZJOUxwZzAwODdSRS92WVBGZkhPUlJFOVVldVRobDQyUVp1VTY4?=
 =?iso-2022-jp?B?bVpEQUR4OUxjeTAxZGFIRmwvZzh4S0pu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?WkQvMzZBczdyQjduL1AxMVhUd0IwYmlEYzZGYThBVndUQldlLy9PSmxE?=
 =?iso-2022-jp?B?anJhYTI2bExTM1o0S1dQNXpKQ2VrYldGaUhNTXQ3Z21FZ1pZVTltajVp?=
 =?iso-2022-jp?B?b0k0WnhDdUlHQzFubjVJSVgxSEQ0bWxKRTk3TVQ1VkNRNnRZekJwbVgr?=
 =?iso-2022-jp?B?Y3NXbXRKd1hlUjUrUWNVOUVMTkM2V2l3bERMaVg3THZNSUhSNFJlazcv?=
 =?iso-2022-jp?B?S1lDaS9jTzQ4RUNIbGlLT1J1d01jSGE5WTJJL01WNjNMNUVndHFCdE1M?=
 =?iso-2022-jp?B?andoRkJlaWZGb0p0RUp0eWRSeHdTRWxXcUcyWmdOankvZUJjNC9ZaEFa?=
 =?iso-2022-jp?B?bDBhMFZHTlNqdHVyTGc1MnNISmJVd2plaUV5VkpjUDVYOCs1cTE1OTNN?=
 =?iso-2022-jp?B?d1RKWjZGMVp4SzRlVGZINElNNVdCVExXSC85Z3poMDB2M2UxZWx6QlVj?=
 =?iso-2022-jp?B?N2lENnpGYTU1VFE5YUF1WEJ1RGhHYkhGQ2hCdE5xdm1xT29KTW5yeWZH?=
 =?iso-2022-jp?B?T1pIQ0s1Tjk2aHArT2NkTXVUajdnd1dHQysvWmRJa0N2KzFDcjEvSFhS?=
 =?iso-2022-jp?B?a3ZCbkFnbSsyVCttN3hrR0tFRDRieDFmV2ZreFYxNTY2dEdRUDdzcDFG?=
 =?iso-2022-jp?B?WWRlejBVSzNQcE9zenZIeXYyTzZVM3Npbld5RDhPSFNSeUhWTjllN3or?=
 =?iso-2022-jp?B?WWM0NWlGTFVDaU81Y2dkNWNMTlc2MTAwQ1hGZTZIK1BsY000am5GbmNi?=
 =?iso-2022-jp?B?ZUQ5MDVTWlV6U0tyUnQxa2NBdHRNeFZtL01UaFgwd3ptalpmRTVobjFp?=
 =?iso-2022-jp?B?ZWdHSEdxbno0YUhuRzA3T3A5T1Nld0ZYYkN5QjBRcTh5QzFibjc4Vkdo?=
 =?iso-2022-jp?B?TGhONldwWjRzWE9ZYVY2VjVmSzBzUnJtWmFPd0hzSFpwSlBtbzZPQ0dY?=
 =?iso-2022-jp?B?NDR4NE1TeFJ0TFIyd0RKc28xNEI1SHUyWFpOUHFuWmJ0NEdJdS8xZndS?=
 =?iso-2022-jp?B?NE45d09XZ0pRQzhwQjhQRjZPaHc2Vm15bkVvTGxuWVRETjlFL3AvWWpm?=
 =?iso-2022-jp?B?VzZiWHE1QmU5N0JyZ3phc2RNQjdZVzZDSFUrK0JzMHJyNS8wd3pWVEVD?=
 =?iso-2022-jp?B?ZVd6TjhJYmI2RS9LbUlaMGJacHYwYk5NVXl3WVgzQXh5UlI1Ylp6alpN?=
 =?iso-2022-jp?B?cXREaWhRU1p3aWY4Q09LMjV0b2VWcmNkZzZWUGVsSTFRVWlCU2s2NThK?=
 =?iso-2022-jp?B?aHU1NXRBWVJWODZLQ3lQSWVXdGV1WXk4bGtLblFCNy9wSjg4amxKK216?=
 =?iso-2022-jp?B?bUNEMURxNXkyeEdxK1dCNXpnZDR0dXN2V3hqY1ljcTNoNHVsYllzVmFT?=
 =?iso-2022-jp?B?MkNaRXBnb3p2aVkzVjQxSEpGUFNPU2pJL2ZGTlp0czFaTFQ2Q0ZnRmJj?=
 =?iso-2022-jp?B?RXBYaTJXMTgybjJ4bUFZYThZbGpaUzk1b25nTVBEQ1FhV2szc0syT1FW?=
 =?iso-2022-jp?B?NTNYY3VuS3N4L1pPWTJ1cm1DMm5mQkZweWNVWk91YVpaMlJBL0cxb3Zn?=
 =?iso-2022-jp?B?QWN5YlFZMkZzUDkyWFZqQ0ZQOFo3K1VLMzd2ZW5Lb1FxQUZFMldaOXEz?=
 =?iso-2022-jp?B?MVlaMjRMVEpRV012T3RpN2xoUWo0NHRid3A3S0lWQ3UvcE4wMnFHK3ov?=
 =?iso-2022-jp?B?MkYwY3pGdjVReStNcEhNUXR6bnRtbmRTUklGVTByUXZxZFN0QW04L2Jq?=
 =?iso-2022-jp?B?U3FEV1N0U25lNEpEZStrSytpcFprS1liMXVZUkVOcEZnYWFZQjZSaDU1?=
 =?iso-2022-jp?B?aHpKWHlPY1Y0dU8xcnBaYkFUZGxPTEV3UEw0aCthV3kwNHc0ano0aU9O?=
 =?iso-2022-jp?B?dzFlVnA1RWlnTWR1OE9hdkR2MFpFZ09kUHJVOUpvYWZPd2pEdkNlNHZW?=
 =?iso-2022-jp?B?STJjZHBIL1dkYXp6ZmhCUzlydlRFWEJQYXFBOFh0cFprdjRmMEtVT2Fq?=
 =?iso-2022-jp?B?ZnBjUGNWRnJhTXY4MHBxblZhUHpzeGRIWFl0TU0vY2pLNGxXZ1VyWjk1?=
 =?iso-2022-jp?B?bnFwSjgzTnVCNzV5MWl5dnFvR0xoYXRGbnNYNkczOTBhaW9nRkY4WGU3?=
 =?iso-2022-jp?B?RFF5QTJ4VHh6QUxielViOUxpSWx3c0ExRk82LytUYmNaZE9PelY0VkdD?=
 =?iso-2022-jp?B?N3kyT3lNSC9zU1hmUHl3OVBPdzl2Uk42NS9FSlRCdU51eXZ4UE8zbTIr?=
 =?iso-2022-jp?B?LzRHQWEwZ0F0ek43UW52a1AvOVdhcGlBVTFKbXVRL1JqYks4N1NXcHhM?=
 =?iso-2022-jp?B?NGdHV2JwZy9BNW5uNkgrZG56NFpIYTVpRGc9PQ==?=
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
	O4WF0s2WB+8dHr/BKsF5Vze54Syfpzm3b8l7A7aUNGJ4p5iKJJ5FZFqZLvt+n4b6AL/ow/zL+AFP7a1zfu5a1pycWzJ2ZN/kwgHzoMETGps0V+YBGzY5W+MlOEUc5hqtg6KsJx37ZTFR+f2FyEfT5s4D5lBRe1CYhgpTZfA+ocIQ09OMHLhGC3qvU+3oOqqop7IUVXoa51Hj8Gb/O7l5SsnQHI/H7ITAsh3lMdVJdNkIC3UQVOoBw1yONYzoM2cHj0qU+Fs1uqeSifT54Jdy3Ep5b7lKUpUbtRLu96bmb8+Fsnh9WEep57zQnKA1jLl0rmRM8ZVZeXmp9odmYlizYF0dcEcygAXuPtpzx2ojBwkQWaqTnFzFZqhDWyGMwOLfOC/sYFXEvoFPgOTpb8Ju8Q23Gg638qu/rNbrrvNhFUoLzrlkA3/sUcXqwbEO//rsO8bSFRvUo0oFKyyVABQKUNk4HSXmIUiwj8xn1MxQ3CMnB5zlch0/+kGX7xkSOvE5WQDTxpyipiLXkvzdcZuf97ULYRn1tznuTOioM2Q0E9Ch+r/ODfgVqx58GZr6w4ilNmkBtsQn9N82XXNKWkFmfe6uEO2dVQMpevh12GvCg1wYmYVxJGBhSw7SXzYKmMrK
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942aecf2-deac-4aed-2e40-08ddc43ac553
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 07:31:25.4090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pU7Kicx5lJ6PlvHupYo2AFe4iBi2Q/HqFxhG4/QqqixJJYgTNR62xRTrW2BDkIgx8uNXfy1aWpCuj555+AP5xZB1GYTnKVCaCiubDiy30Mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14305

Hello James,

> Register and enable error IRQs. All the MPAM error interrupts indicate a
> software bug, e.g. out of range partid. If the error interrupt is ever si=
gnalled,
> attempt to disable MPAM.
>=20
> Only the irq handler accesses the ESR register, so no locking is needed.
> The work to disable MPAM after an error needs to happen at process contex=
t,
> use a threaded interrupt.
>=20
> There is no support for percpu threaded interrupts, for now schedule the =
work
> to be done from the irq handler.
>=20
> Enabling the IRQs in the MSC may involve cross calling to a CPU that can
> access the MSC.
>=20
> CC: Rohit Mathew <rohit.mathew@arm.com>
> Tested-by: Rohit Mathew <rohit.mathew@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/platform/arm64/mpam/mpam_devices.c  | 304
> +++++++++++++++++++-
>  drivers/platform/arm64/mpam/mpam_internal.h |   9 +-
>  2 files changed, 307 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c
> b/drivers/platform/arm64/mpam/mpam_devices.c
> index 145535cd4732..af19cc25d16e 100644
> --- a/drivers/platform/arm64/mpam/mpam_devices.c
> +++ b/drivers/platform/arm64/mpam/mpam_devices.c
> @@ -14,6 +14,9 @@
>  #include <linux/device.h>
>  #include <linux/errno.h>
>  #include <linux/gfp.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqdesc.h>
>  #include <linux/list.h>
>  #include <linux/lockdep.h>
>  #include <linux/mutex.h>
> @@ -62,6 +65,12 @@ static DEFINE_SPINLOCK(partid_max_lock);
>   */
>  static DECLARE_WORK(mpam_enable_work, &mpam_enable);
>=20
> +/*
> + * All mpam error interrupts indicate a software bug. On receipt,
> +disable the
> + * driver.
> + */
> +static DECLARE_WORK(mpam_broken_work, &mpam_disable);
> +
>  /*
>   * An MSC is a physical container for controls and monitors, each identi=
fied by
>   * their RIS index. These share a base-address, interrupts and some MMIO
> @@ -159,6 +168,24 @@ static u64 mpam_msc_read_idr(struct mpam_msc
> *msc)
>  	return (idr_high << 32) | idr_low;
>  }
>=20
> +static void mpam_msc_zero_esr(struct mpam_msc *msc) {
> +	__mpam_write_reg(msc, MPAMF_ESR, 0);
> +	if (msc->has_extd_esr)
> +		__mpam_write_reg(msc, MPAMF_ESR + 4, 0); }
> +
> +static u64 mpam_msc_read_esr(struct mpam_msc *msc) {
> +	u64 esr_high =3D 0, esr_low;
> +
> +	esr_low =3D __mpam_read_reg(msc, MPAMF_ESR);
> +	if (msc->has_extd_esr)
> +		esr_high =3D __mpam_read_reg(msc, MPAMF_ESR + 4);
> +
> +	return (esr_high << 32) | esr_low;
> +}
> +
>  static void __mpam_part_sel_raw(u32 partsel, struct mpam_msc *msc)  {
>  	lockdep_assert_held(&msc->part_sel_lock);
> @@ -405,12 +432,12 @@ static void mpam_msc_destroy(struct mpam_msc
> *msc)
>=20
>  	lockdep_assert_held(&mpam_list_lock);
>=20
> -	list_del_rcu(&msc->glbl_list);
> -	platform_set_drvdata(pdev, NULL);
> -
>  	list_for_each_entry_safe(ris, tmp, &msc->ris, msc_list)
>  		mpam_ris_destroy(ris);
>=20
> +	list_del_rcu(&msc->glbl_list);
> +	platform_set_drvdata(pdev, NULL);
> +
>  	add_to_garbage(msc);
>  	msc->garbage.pdev =3D pdev;
>  }
> @@ -828,6 +855,7 @@ static int mpam_msc_hw_probe(struct mpam_msc
> *msc)
>  		pmg_max =3D FIELD_GET(MPAMF_IDR_PMG_MAX, idr);
>  		msc->partid_max =3D min(msc->partid_max, partid_max);
>  		msc->pmg_max =3D min(msc->pmg_max, pmg_max);
> +		msc->has_extd_esr =3D
> FIELD_GET(MPAMF_IDR_HAS_EXT_ESR, idr);
>=20
>  		ris =3D mpam_get_or_create_ris(msc, ris_idx);
>  		if (IS_ERR(ris))
> @@ -974,6 +1002,13 @@ static void mpam_reset_msc(struct mpam_msc
> *msc, bool online)
>  	mpam_mon_sel_outer_unlock(msc);
>  }
>=20
> +static void _enable_percpu_irq(void *_irq) {
> +	int *irq =3D _irq;
> +
> +	enable_percpu_irq(*irq, IRQ_TYPE_NONE); }
> +
>  static int mpam_cpu_online(unsigned int cpu)  {
>  	int idx;
> @@ -984,6 +1019,9 @@ static int mpam_cpu_online(unsigned int cpu)
>  		if (!cpumask_test_cpu(cpu, &msc->accessibility))
>  			continue;
>=20
> +		if (msc->reenable_error_ppi)
> +			_enable_percpu_irq(&msc->reenable_error_ppi);
> +
>  		if (atomic_fetch_inc(&msc->online_refs) =3D=3D 0)
>  			mpam_reset_msc(msc, true);
>  	}
> @@ -1032,6 +1070,9 @@ static int mpam_cpu_offline(unsigned int cpu)
>  		if (!cpumask_test_cpu(cpu, &msc->accessibility))
>  			continue;
>=20
> +		if (msc->reenable_error_ppi)
> +			disable_percpu_irq(msc->reenable_error_ppi);
> +
>  		if (atomic_dec_and_test(&msc->online_refs))
>  			mpam_reset_msc(msc, false);
>  	}
> @@ -1058,6 +1099,51 @@ static void mpam_register_cpuhp_callbacks(int
> (*online)(unsigned int online),
>  	mutex_unlock(&mpam_cpuhp_state_lock);
>  }
>=20
> +static int __setup_ppi(struct mpam_msc *msc) {
> +	int cpu;
> +
> +	msc->error_dev_id =3D alloc_percpu_gfp(struct mpam_msc *,
> GFP_KERNEL);
> +	if (!msc->error_dev_id)
> +		return -ENOMEM;
> +
> +	for_each_cpu(cpu, &msc->accessibility) {
> +		struct mpam_msc *empty =3D *per_cpu_ptr(msc->error_dev_id,
> cpu);
> +
> +		if (empty) {
> +			pr_err_once("%s shares PPI with %s!\n",
> +				    dev_name(&msc->pdev->dev),
> +				    dev_name(&empty->pdev->dev));
> +			return -EBUSY;
> +		}
> +		*per_cpu_ptr(msc->error_dev_id, cpu) =3D msc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mpam_msc_setup_error_irq(struct mpam_msc *msc) {
> +	int irq;
> +
> +	irq =3D platform_get_irq_byname_optional(msc->pdev, "error");
> +	if (irq <=3D 0)
> +		return 0;
> +
> +	/* Allocate and initialise the percpu device pointer for PPI */
> +	if (irq_is_percpu(irq))
> +		return __setup_ppi(msc);
> +
> +	/* sanity check: shared interrupts can be routed anywhere? */
> +	if (!cpumask_equal(&msc->accessibility, cpu_possible_mask)) {
> +		pr_err_once("msc:%u is a private resource with a shared error
> interrupt",
> +			    msc->id);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int mpam_dt_count_msc(void)
>  {
>  	int count =3D 0;
> @@ -1266,6 +1352,10 @@ static int mpam_msc_drv_probe(struct
> platform_device *pdev)
>  			break;
>  		}
>=20
> +		err =3D mpam_msc_setup_error_irq(msc);
> +		if (err)
> +			break;
> +
>  		if (device_property_read_u32(&pdev->dev, "pcc-channel",
>  					     &msc->pcc_subspace_id))
>  			msc->iface =3D MPAM_IFACE_MMIO;
> @@ -1548,11 +1638,193 @@ static void mpam_enable_merge_features(struct
> list_head *all_classes_list)
>  	}
>  }
>=20
> +static char *mpam_errcode_names[16] =3D {
> +	[0] =3D "No error",
> +	[1] =3D "PARTID_SEL_Range",
> +	[2] =3D "Req_PARTID_Range",
> +	[3] =3D "MSMONCFG_ID_RANGE",
> +	[4] =3D "Req_PMG_Range",
> +	[5] =3D "Monitor_Range",
> +	[6] =3D "intPARTID_Range",
> +	[7] =3D "Unexpected_INTERNAL",
> +	[8] =3D "Undefined_RIS_PART_SEL",
> +	[9] =3D "RIS_No_Control",
> +	[10] =3D "Undefined_RIS_MON_SEL",
> +	[11] =3D "RIS_No_Monitor",
> +	[12 ... 15] =3D "Reserved"
> +};
> +
> +static int mpam_enable_msc_ecr(void *_msc) {
> +	struct mpam_msc *msc =3D _msc;
> +
> +	__mpam_write_reg(msc, MPAMF_ECR, 1);
> +
> +	return 0;
> +}
> +
> +static int mpam_disable_msc_ecr(void *_msc) {
> +	struct mpam_msc *msc =3D _msc;
> +
> +	__mpam_write_reg(msc, MPAMF_ECR, 0);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc) {
> +	u64 reg;
> +	u16 partid;
> +	u8 errcode, pmg, ris;
> +
> +	if (WARN_ON_ONCE(!msc) ||
> +	    WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
> +					   &msc->accessibility)))
> +		return IRQ_NONE;
> +
> +	reg =3D mpam_msc_read_esr(msc);
> +
> +	errcode =3D FIELD_GET(MPAMF_ESR_ERRCODE, reg);
> +	if (!errcode)
> +		return IRQ_NONE;
> +
> +	/* Clear level triggered irq */
> +	mpam_msc_zero_esr(msc);
> +
> +	partid =3D FIELD_GET(MPAMF_ESR_PARTID_OR_MON, reg);
> +	pmg =3D FIELD_GET(MPAMF_ESR_PMG, reg);
> +	ris =3D FIELD_GET(MPAMF_ESR_PMG, reg);
MPAMF_ESR_RIS?


Best regards,
Shaopeng TAN

> +	pr_err("error irq from msc:%u '%s', partid:%u, pmg: %u, ris: %u\n",
> +	       msc->id, mpam_errcode_names[errcode], partid, pmg, ris);
> +
> +	if (irq_is_percpu(irq)) {
> +		mpam_disable_msc_ecr(msc);
> +		schedule_work(&mpam_broken_work);
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t mpam_ppi_handler(int irq, void *dev_id) {
> +	struct mpam_msc *msc =3D *(struct mpam_msc **)dev_id;
> +
> +	return __mpam_irq_handler(irq, msc);
> +}
> +
> +static irqreturn_t mpam_spi_handler(int irq, void *dev_id) {
> +	struct mpam_msc *msc =3D dev_id;
> +
> +	return __mpam_irq_handler(irq, msc);
> +}
> +
> +static irqreturn_t mpam_disable_thread(int irq, void *dev_id);
> +
> +static int mpam_register_irqs(void)
> +{
> +	int err, irq, idx;
> +	struct mpam_msc *msc;
> +
> +	lockdep_assert_cpus_held();
> +
> +	idx =3D srcu_read_lock(&mpam_srcu);
> +	list_for_each_entry_srcu(msc, &mpam_all_msc, glbl_list,
> srcu_read_lock_held(&mpam_srcu)) {
> +		irq =3D platform_get_irq_byname_optional(msc->pdev, "error");
> +		if (irq <=3D 0)
> +			continue;
> +
> +		/* The MPAM spec says the interrupt can be SPI, PPI or LPI */
> +		/* We anticipate sharing the interrupt with other MSCs */
> +		if (irq_is_percpu(irq)) {
> +			err =3D request_percpu_irq(irq, &mpam_ppi_handler,
> +						 "mpam:msc:error",
> +						 msc->error_dev_id);
> +			if (err)
> +				return err;
> +
> +			msc->reenable_error_ppi =3D irq;
> +			smp_call_function_many(&msc->accessibility,
> +					       &_enable_percpu_irq, &irq,
> +					       true);
> +		} else {
> +			err =3D
> devm_request_threaded_irq(&msc->pdev->dev, irq,
> +
> 	&mpam_spi_handler,
> +
> 	&mpam_disable_thread,
> +							IRQF_SHARED,
> +							"mpam:msc:error",
> msc);
> +			if (err)
> +				return err;
> +		}
> +
> +		msc->error_irq_requested =3D true;
> +		mpam_touch_msc(msc, mpam_enable_msc_ecr, msc);
> +		msc->error_irq_hw_enabled =3D true;
> +	}
> +	srcu_read_unlock(&mpam_srcu, idx);
> +
> +	return 0;
> +}
> +
> +static void mpam_unregister_irqs(void)
> +{
> +	int irq, idx;
> +	struct mpam_msc *msc;
> +
> +	cpus_read_lock();
> +	/* take the lock as free_irq() can sleep */
> +	idx =3D srcu_read_lock(&mpam_srcu);
> +	list_for_each_entry_srcu(msc, &mpam_all_msc, glbl_list,
> srcu_read_lock_held(&mpam_srcu)) {
> +		irq =3D platform_get_irq_byname_optional(msc->pdev, "error");
> +		if (irq <=3D 0)
> +			continue;
> +
> +		if (msc->error_irq_hw_enabled) {
> +			mpam_touch_msc(msc, mpam_disable_msc_ecr,
> msc);
> +			msc->error_irq_hw_enabled =3D false;
> +		}
> +
> +		if (msc->error_irq_requested) {
> +			if (irq_is_percpu(irq)) {
> +				msc->reenable_error_ppi =3D 0;
> +				free_percpu_irq(irq, msc->error_dev_id);
> +			} else {
> +				devm_free_irq(&msc->pdev->dev, irq, msc);
> +			}
> +			msc->error_irq_requested =3D false;
> +		}
> +	}
> +	srcu_read_unlock(&mpam_srcu, idx);
> +	cpus_read_unlock();
> +}
> +
>  static void mpam_enable_once(void)
>  {
> +	int err;
> +
> +	/*
> +	 * If all the MSC have been probed, enabling the IRQs happens next.
> +	 * That involves cross-calling to a CPU that can reach the MSC, and
> +	 * the locks must be taken in this order:
> +	 */
> +	cpus_read_lock();
>  	mutex_lock(&mpam_list_lock);
>  	mpam_enable_merge_features(&mpam_classes);
> +
> +	err =3D mpam_register_irqs();
> +	if (err)
> +		pr_warn("Failed to register irqs: %d\n", err);
> +
>  	mutex_unlock(&mpam_list_lock);
> +	cpus_read_unlock();
> +
> +	if (err) {
> +		schedule_work(&mpam_broken_work);
> +		return;
> +	}
>=20
>  	mutex_lock(&mpam_cpuhp_state_lock);
>  	cpuhp_remove_state(mpam_cpuhp_state);
> @@ -1621,16 +1893,39 @@ static void mpam_reset_class(struct mpam_class
> *class)
>   * All of MPAMs errors indicate a software bug, restore any modified
>   * controls to their reset values.
>   */
> -void mpam_disable(void)
> +static irqreturn_t mpam_disable_thread(int irq, void *dev_id)
>  {
>  	int idx;
>  	struct mpam_class *class;
> +	struct mpam_msc *msc, *tmp;
> +
> +	mutex_lock(&mpam_cpuhp_state_lock);
> +	if (mpam_cpuhp_state) {
> +		cpuhp_remove_state(mpam_cpuhp_state);
> +		mpam_cpuhp_state =3D 0;
> +	}
> +	mutex_unlock(&mpam_cpuhp_state_lock);
> +
> +	mpam_unregister_irqs();
>=20
>  	idx =3D srcu_read_lock(&mpam_srcu);
>  	list_for_each_entry_srcu(class, &mpam_classes, classes_list,
>  				 srcu_read_lock_held(&mpam_srcu))
>  		mpam_reset_class(class);
>  	srcu_read_unlock(&mpam_srcu, idx);
> +
> +	mutex_lock(&mpam_list_lock);
> +	list_for_each_entry_safe(msc, tmp, &mpam_all_msc, glbl_list)
> +		mpam_msc_destroy(msc);
> +	mutex_unlock(&mpam_list_lock);
> +	mpam_free_garbage();
> +
> +	return IRQ_HANDLED;
> +}
> +
> +void mpam_disable(struct work_struct *ignored) {
> +	mpam_disable_thread(0, NULL);
>  }
>=20
>  /*
> @@ -1644,7 +1939,6 @@ void mpam_enable(struct work_struct *work)
>  	struct mpam_msc *msc;
>  	bool all_devices_probed =3D true;
>=20
> -	/* Have we probed all the hw devices? */
>  	mutex_lock(&mpam_list_lock);
>  	list_for_each_entry(msc, &mpam_all_msc, glbl_list) {
>  		mutex_lock(&msc->probe_lock);
> diff --git a/drivers/platform/arm64/mpam/mpam_internal.h
> b/drivers/platform/arm64/mpam/mpam_internal.h
> index de05eece0a31..e1c6a2676b54 100644
> --- a/drivers/platform/arm64/mpam/mpam_internal.h
> +++ b/drivers/platform/arm64/mpam/mpam_internal.h
> @@ -44,6 +44,11 @@ struct mpam_msc {
>  	struct pcc_mbox_chan	*pcc_chan;
>  	u32			nrdy_usec;
>  	cpumask_t		accessibility;
> +	bool			has_extd_esr;
> +
> +	int				reenable_error_ppi;
> +	struct mpam_msc * __percpu	*error_dev_id;
> +
>  	atomic_t		online_refs;
>=20
>  	/*
> @@ -52,6 +57,8 @@ struct mpam_msc {
>  	 */
>  	struct mutex		probe_lock;
>  	bool			probed;
> +	bool			error_irq_requested;
> +	bool			error_irq_hw_enabled;
>  	u16			partid_max;
>  	u8			pmg_max;
>  	unsigned long		ris_idxs[128 / BITS_PER_LONG];
> @@ -280,7 +287,7 @@ extern u8 mpam_pmg_max;
>=20
>  /* Scheduled work callback to enable mpam once all MSC have been probed
> */  void mpam_enable(struct work_struct *work); -void mpam_disable(void);
> +void mpam_disable(struct work_struct *work);
>=20
>  int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32
> cache_level,
>  				   cpumask_t *affinity);
> --
> 2.39.5


