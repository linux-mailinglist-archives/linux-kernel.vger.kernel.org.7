Return-Path: <linux-kernel+bounces-805337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84253B4874A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6D83C5061
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23712EC56E;
	Mon,  8 Sep 2025 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="gywmY01X"
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D99B2EC081
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320340; cv=fail; b=oGIa6tg3gh9sSLJ55sS+B0WyLDrOnguP3YhlQ2z6I9I4mpCxzsJ/Jym8gxLj/kwutTGHZ2RC31nigBYi5CL9zFrkmwXUHMfSQynxNWpte08jZ+dUxD8kbrn6gpg5zdnHDo5+EJrjrnvieciFtv/XH0JZzE1HytBg0cyS/JVBeU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320340; c=relaxed/simple;
	bh=z3W2LjSPX8GssMD52lEDpofXDkgEsvNst2EmKXvgxpI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EXBllDlnS3PoTUHItLG7+Fs7F6ziLA5LcP5eay4wgNJbjJGPvrquahJUeFM00P8iIMOfo0pgfFsHmZAf8+0Sj/9GpK+MLlwvIyMlkxgDsdSGqAiDzKJHQIGbIzTWGIujkcVAn9DJ79wGp93cDBfW1fdqmA97GgAYlAGl/V7alDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=gywmY01X; arc=fail smtp.client-ip=68.232.152.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1757320338; x=1788856338;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z3W2LjSPX8GssMD52lEDpofXDkgEsvNst2EmKXvgxpI=;
  b=gywmY01XmYWyf1ro6AT3oseTZFgUTks1/xfMtqELwquSTcU/lEssKhDd
   eigVSXc/q3prSvWlKuhjZ2PiWsbU+lHCui/RWku5+fNeuiWFZBy8JPd6V
   T+Qbp3bHMb9vUlj1N0GP/+4fDhcNLlTEcbHcOu/N0SV9u44FK1H1g7elP
   sAEgJFOAWhiBKXsFmw9bwuHyVXquWUKMZ3GqAdhZ37tYW4IANyRX1ee6B
   c5eLNQ24EZ6szhDXzVoZQE3K5KgsTlVFnSBrSmSKZ9ZCW2xNgnHCZqQc5
   GBk+3f6q2ak7t0boJnvuv+YR+NVnw5wNqqMmnbQRJCJJJ47i0byTcd08k
   Q==;
X-CSE-ConnectionGUID: x65iPuo/S9uVAIkPKfvXcw==
X-CSE-MsgGUID: L+lC5Q50RVG8Uxgj6Q+nyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="77990099"
X-IronPort-AV: E=Sophos;i="6.18,248,1751209200"; 
   d="scan'208";a="77990099"
Received: from mail-japaneastazon11011027.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([52.101.125.27])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 17:31:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwwmRGswgs9UDjODdz41m5tzWkVlEgADn/qbB+mZR34qxR999uLeWZx1k5bPgqTC2V8JO5aXfi2CeP+CCCbFsaNjrDih35xDeRSih+J64mlOLY4WhqPSZPwybXx4PQ3Z5K4ZnlajHusYUc30atDgWcxypB2Ie6lWqsh4JycHoAyrfxP2ZRxP08mTiGQAWwbDcM3vEzDFeY7rQzxLWWX0tQfoxwYF+y4Vnaaztx5z7kfPV7DkdIKm3t1UnKQfzLV4DX0sE7SxJd6tUs557rPRBeX7JD2dIP+j21ETHv7lOybe42wxqAql+TxW9yoUxD5hgMZTVlsgqPE4XERX7y0DKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=key79Hj1DnsO00Pqy3mPcFvNyXS9qPduvnjTR55fN1E=;
 b=rwNvlYvVRRblLKC3pr9BMytWnE6+3ylm0oZY3GjGSsx4xqP8uyJQhtSkFJrp9IlmtWGbHejazXODJo4TzzLX4KISeHYkNAoJpgix4TCf7Kv7LaHNhrWvsKS/zFLi8zMzUF8XyuvQeH7CQviBR9Di4cSl6/FK5tMdNpHJYyjGAsHVjpmz6m6+ZgBwK36vYgfMq0zw3r2w0S37+Ioq2S0hV3pMz1HOWgizAH7D6gUu1MZpiqTBSWSOrlz0LNcv9GVHzwkGaRQpQ6XQRCgPAB3qwY+Z0Hvxmzpnvq+1wvmBNCRtoMcPAJcKI+BVTSYnd6vwl70AQQDZxtyaMfCNBBEvlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8804.jpnprd01.prod.outlook.com (2603:1096:400:18d::10)
 by OS7PR01MB14361.jpnprd01.prod.outlook.com (2603:1096:604:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 08:31:01 +0000
Received: from TYCPR01MB8804.jpnprd01.prod.outlook.com
 ([fe80::b2f6:161a:adee:a32c]) by TYCPR01MB8804.jpnprd01.prod.outlook.com
 ([fe80::b2f6:161a:adee:a32c%3]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 08:31:01 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'Dave Martin' <Dave.Martin@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, James Morse <james.morse@arm.com>
Subject: RE: [PATCH] arm_mpam: Relax num_rmids parameter advertised to
 userspace
Thread-Topic: [PATCH] arm_mpam: Relax num_rmids parameter advertised to
 userspace
Thread-Index: AQHcEdSzz+C+Rvs4sEaYvBlEx8HiC7SJEdFw
Date: Mon, 8 Sep 2025 08:31:01 +0000
Message-ID:
 <TYCPR01MB8804C19B48AAFF1DBB1588498B0CA@TYCPR01MB8804.jpnprd01.prod.outlook.com>
References: <20250820131621.54983-1-Dave.Martin@arm.com>
In-Reply-To: <20250820131621.54983-1-Dave.Martin@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=d5d73d41-3f70-43d7-a030-3ae767b541fe;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-09-08T08:29:48Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8804:EE_|OS7PR01MB14361:EE_
x-ms-office365-filtering-correlation-id: 247636b6-efeb-4a72-0fe3-08ddeeb20b46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?T2I5V2ZRWlpUa2ZxMFB0L2Z2ei9CRGVFYkk5M3NoZ3hlUmFEbkRYSk5l?=
 =?iso-2022-jp?B?TjRqOFp1QTlrTWdoSmV6WEhlOUhxNC9iT2pGbGROR25ON3NvdWdUSVVR?=
 =?iso-2022-jp?B?R0w4clpYUHBzN1JBU3hMZGxJbjRqaHdQYU1EWk94aFdsMjl0Sm5TVUNV?=
 =?iso-2022-jp?B?QW5BMUhEcmdaSDJpWVQrb3N5dXo5NmFqazJMYjF3TitPVnc4amwrQXlV?=
 =?iso-2022-jp?B?YXdZZFR5RkZOaDlmdXBtd2lLdUd3cjM4b3NkUzd4L09HL3pHSkhRZ25p?=
 =?iso-2022-jp?B?T1ZTTnFXd1UxRUMrR1pZVHU1L0JGMWd5VVFBUFNpRjhqSGdqOVFaNWwr?=
 =?iso-2022-jp?B?NnpzRXBEOGpiNWdiQmdQTWNnVGp3RFYva1V2Z1dCdENqaExhclBvR1dS?=
 =?iso-2022-jp?B?a0t3WFZZcDJwczRuTTAyODc4UlRrVTRTMENDa29GRkFGdjBreUNjV013?=
 =?iso-2022-jp?B?QVRnUUFFUThxdGREbFRNb2FtTklBYWN6WlpZcW9uWUxNRGhDQmtXYXhT?=
 =?iso-2022-jp?B?ZmdwaDJOcjMwU1ZwdTRnL0hmZ05YWllwV2xGSnRRT0pMc05ydFc2OFRI?=
 =?iso-2022-jp?B?SlRSMVBtUlNHUDEwV1NteWdkUTBjOHdrdUUwMFNrQlBGdUYzUnN3RllI?=
 =?iso-2022-jp?B?OUkxOFBOaVN3VlhtTXhNTWVEYXVpR2RRUWE4a0JaaEdiQ2xaMmlLOHVk?=
 =?iso-2022-jp?B?OTFaR0pHd3NLdzh3QUZzRkorN2h0Y0JqMkk2bzhEaFFIcDJDVU9lSTRP?=
 =?iso-2022-jp?B?WVVNVll4dks2a0ZjM0VMemdUSkVLT1hxRkJMS1lDZmR4b3h6Ymx6d1dG?=
 =?iso-2022-jp?B?UXMzenU1N0REOGpGamQySlc0dmtSSWphUlozSzJ6cytOTm53ei95MkNx?=
 =?iso-2022-jp?B?RmdsNnpIVitRWktLak9zN1BmRGNEN2hyQWlwV1cxcm4yR3VNSGNkL1VT?=
 =?iso-2022-jp?B?OHcrcWl1dmVYQWdFV2lVdjA4MFUyRTZQSER2ZnpxeGM4RXN4cktpeUJV?=
 =?iso-2022-jp?B?dDljc1E3MUtwZ3JZQmFneE5CcTdlTWtFZUtndHl3aXFkRVhNcjhNSFZX?=
 =?iso-2022-jp?B?b0NPZkM0bVY5ckZrVmw1TldDUWlKV1dQd3lSZVEyRjg3b1hqbWpFcHg2?=
 =?iso-2022-jp?B?ZXpvYVVobHA0T3krVkdVVzYwM0FIWFdLR05NaWZFNEtQMHVPWGptekRQ?=
 =?iso-2022-jp?B?U1kzMm85dGIrU2NLOTA3aldLZlA4TVIzV045Wm1uMWRWNmEvdzh5a2c4?=
 =?iso-2022-jp?B?UVdkSExMMHU2Zm9GNGdJWFdXQ2NzYUxTNWZXS0JxZFZvOE9ob1hIdmpq?=
 =?iso-2022-jp?B?VFdMbU1wc0dDcDVhZE1PM2V1VXd3NWNFQnlXQkcwQzFoT05pTUdGNkZ5?=
 =?iso-2022-jp?B?QTZEWFBPTHpUa0lxNE44M2JJTUFTaC9ZSXpIWnZUbXorOW5LdmNOU29s?=
 =?iso-2022-jp?B?cFdETnRwYXpwbWF4WmNMQmZSVUYyR3lkTThvTmE2amloRFN3TnRQd1JD?=
 =?iso-2022-jp?B?WG1zZ0p0ZXp1UDdRMXdyb21hdEpWSEFYckVWL20rRDlkQVlRbmhFdVY2?=
 =?iso-2022-jp?B?VktiSHBHNzhGbWxjanl0L3hVbXBGUm1LcTBBSDVORG5FQWpBQjdnUVJI?=
 =?iso-2022-jp?B?WVI5LzRGeEVrQnJXMDFQNHhmZGgvZ3JmYXA5UXZ3dnFOakxyNm9vTGFQ?=
 =?iso-2022-jp?B?bVNvYXdIUjgrT1BXUGxweWlqaDJmUFRIYkxnZVJqNWFwL0xUeWc3cTFH?=
 =?iso-2022-jp?B?WXVWUG9XTUtpNURNc0xtWGxnR0llRjZXOUIvMkdmeTBQSXNSd2czblJy?=
 =?iso-2022-jp?B?TnQyVnBuaTg1TVVkMGxRbGoyVUlWdXM0QmM3UFNaZnBFaXAyN1RpZXZN?=
 =?iso-2022-jp?B?dFRZM0d0a3hLUUJQcmV4SjBHdFFpTng2aDlhcldrbms0WTJGM2xydXJ0?=
 =?iso-2022-jp?B?alFtYm9tc1dmVXhQa05lZ0pxY1lrYXhHWWlZTldDTFNIdEFqZEp1Z3R4?=
 =?iso-2022-jp?B?aEtINHRSZlQvamJBZFFVUXgrellHemVuYmZ2UzFtTjE1ZWtuQ1VBTkUv?=
 =?iso-2022-jp?B?RmFjK3dySzYzcmhWSmtlMDI4cmpGSTN2QzN5aUtFMzRZZXVyK1lSd3RE?=
 =?iso-2022-jp?B?ZmlncVBFMXFFZ1lYTjNrKzV1RUxvS2FoMlpNd3lndkZRM2tJQ0c3ejR2?=
 =?iso-2022-jp?B?ejRvQk1lZEdIV2owY1Nrei9xZ1JTUy9B?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8804.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?WFBwbHZJU3ZJemM1Q0RHamhYYlMyUWZCNHJIL2Vwb095ei9oVjNsSnNP?=
 =?iso-2022-jp?B?OG5UVnVRZGJ0QmVsMndwMG91LzZQV0VKYmU4UTN5bGxzVjlVWTVHc0l6?=
 =?iso-2022-jp?B?WkZ2Z0p1OGdWU0JtOEEybWNIUjNPeXpXODJHbjVUTm41K2U0MzZUeHp1?=
 =?iso-2022-jp?B?OXNEYm5qcE0yaFd5WE5ONnl6RXFWb2J0cnpLK2w5QkhtMDZnajIrdVBP?=
 =?iso-2022-jp?B?VDU2Sis5QVluMFN0SFVCOXJHUVpQN2NlYVhZcHFleldlTUlTQTN4Q1Va?=
 =?iso-2022-jp?B?TFNObUlhR2VsM1FDWXJyNmlJdTI4bXQ5SkhBeG9hVVVjdmlodk5wOG81?=
 =?iso-2022-jp?B?QU80K3F1Qk1DUEMvSkdSWkM4SkdJdWZ1RFJ3M0tEQnJJM3NSZFJZeXh0?=
 =?iso-2022-jp?B?RG1haGNDMnV3WExBaHRWQmlPNVA1VWgxR2RVOS9BN09yS0xBb205MWRt?=
 =?iso-2022-jp?B?THFMOGg1ME15djZwUlRvdm9PaTVPMU5IOVEwQWxpYWFmTTlSeEtKWWZN?=
 =?iso-2022-jp?B?Y1Z1ZjY5cTI3K2dnK2c0U3d4V00za3JTUGlpbzF4ZWRsMlB3UXA3c2Rx?=
 =?iso-2022-jp?B?aUdUYWV0Z2hzU0NSaEliWHFoMFRNSzIybVZISzdlWEN5NWpvejlkcFQ3?=
 =?iso-2022-jp?B?amNMZ3doT2Z1aFR1S2xGakVrK3kvbWsyZWkwQk1HaE9MOVgrRVRJS2Uz?=
 =?iso-2022-jp?B?bGhNKy9pQ09YdVhNdmxZaGYwczFTMURzNDRpSnNCUEZ6dTZJTGlaYnZR?=
 =?iso-2022-jp?B?U01qM2duWkd1eVFJRFd0Y0ZvZ2xWVEcxdkg2SmtNdVFoY0FTbVV6bzAy?=
 =?iso-2022-jp?B?T2VaL0FXTXJjTFpxOEo2N095VmhxYUpmbDFXTFR3Qzk4dzJMR0U4Q0Vy?=
 =?iso-2022-jp?B?NllJUWJJWXhzMiszbGFVQ1pmKzhNMjdBaUNhc1JRUW9KRUZId0dQcmVs?=
 =?iso-2022-jp?B?YWNiU0tKQzNhbjVZeUQzdTVNR3BBS0MwcDREcWlySVFMTnVDcTl4Y1VC?=
 =?iso-2022-jp?B?eXRxTVNTUXNIWE1NYmY0TGxhU1dHMXVxSE5ZYVE4M0RxaXlPNWRsQ2hL?=
 =?iso-2022-jp?B?ekwwK2hSTWVKdDhpRUFENWFoOCs2YWphNDZKcVJzaEZNL0pub1NiU3Q3?=
 =?iso-2022-jp?B?dENQZ1MvQkN5dlRSY1JtSGc5cy9zNm9Uc2hKQ1kzSi9ubFBMRCtRcHZL?=
 =?iso-2022-jp?B?VGNZUExiSWVQaDBuVHVvbHQxbHRnT0JiaGVTaVp6LzBZSCtLMUZ2TzVn?=
 =?iso-2022-jp?B?eU9mY0lmUnRzZHhlZklpREJBanZEQVg5QXlZSDVDRm0yQW1lYmhIZ3Z6?=
 =?iso-2022-jp?B?dTlaeExBVW1qRXhlc0xqVHFLSUQxVDg5VlpZa1FpUmI3NkhxbUpZQngx?=
 =?iso-2022-jp?B?OG9ocythTWQwSDJmcWsrN2FNbk5lMFFjZnhmNWg0U1A3ZjFsWFZQQ2dh?=
 =?iso-2022-jp?B?a2FaVHVNaFFqRGkraTlkdTR1N0sxZkpuc3B0MFdFTUpXa2h2MDdKUlFS?=
 =?iso-2022-jp?B?bThSc3VwaVl1Tjd4Nk1xRXVpWjl2RllvaTgwLzFuN2UySW9DRDRUb1k4?=
 =?iso-2022-jp?B?Smc0ZDkzWEtSZ1laMHV1dmVoTVNneDRGbUw4MGxNbTNOZmVmS0lOOHJ4?=
 =?iso-2022-jp?B?MnBlU3N2QS9uU2RiZ0xZTkVTcURjVnJwcGZiWFpBS3ZHSDhZVGkyM2RR?=
 =?iso-2022-jp?B?LzJyajNYUko3YmJGeEpoY3ZwOWk0K0VTc1RML1pmRGR4MG9DNUoxZlFr?=
 =?iso-2022-jp?B?ZTlGcUd5Y1drdDBRT1hkbWNGL24xcWRBVnhyYmNrbGVRUmNOdmVyQVVj?=
 =?iso-2022-jp?B?U3d3L1dMQUJFa3libXVEZHA3aUJ5OUlJR3U1OFFVQWwwMXA1eUV5MjZC?=
 =?iso-2022-jp?B?ajRjcnlrdW1JcWMrRGladHhwd08rZkhkTkNtVkJ0RCsxQWNPRE5odGJF?=
 =?iso-2022-jp?B?MWtuY3dEdmdtNzBEOFFtR2VjY3RQU2hIVDdVNDg4K3RYWk95QVRwdnpG?=
 =?iso-2022-jp?B?K0gwZHZzcVZNS29NanBIanNTTGdJNWptejJpbTJ3TlYrS0dwVHA1MCtB?=
 =?iso-2022-jp?B?SjF3alpZdENBZ3owSlFwelk0K1dRTTBtdWJnc1V5TExJSjZtMmZJc1Bk?=
 =?iso-2022-jp?B?M1I5MmVWZHV4R3ZIdUNIQ3VrcExGQmxhVDQvSlNuTHB0M29wU2l2RFJY?=
 =?iso-2022-jp?B?L0lpZlBMeWZtNEkrVkRnUDJyNmE4T0x6MUZkZWVxOVN0VzlESndYTVp3?=
 =?iso-2022-jp?B?RUhXQW1kYno3TmFKWmt2N2JTSmNSdkszSVF3MWtJYW00NmxPcE5SWWNo?=
 =?iso-2022-jp?B?by94akhBaTNQTExHdkhYWTB4WXlvbUZad1E9PQ==?=
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
	QkX6PhcdVVGMaoTHx1MdkmpByd9Gsge6RkZcPKdWTXUEbmDolp/HI/odxv03eHI5vob1yoKj7GbmvLHrmEOxIbe9vuam5r81BhuQzU7o4nZWVNMsZhVnNJjJzA8Q7xqdY08B2xipTIZrQhC/Pyma1AFlLRdvxkUDbEe24aBUsz3MIGRAnziACr9Fo2E5jTnCy0YUQ/yCs4q+hxYU5hExpJGuVsJVjrfhb/govvFDxixPjQbI0luU/FhsfAzQjplQ/qKqdBwMwx+cn0uBRi4eD4mIrQvGG+c8WKsdzgJnJCIRfd/PwIfIZrBcjfb1MWr+yP2xOggk8CkxOaShn01abhhDi2jBDGfiKEzkAgwXET9sHtCMoABBIEb1S9AHdCZ4/7h9zrknJOkAsni6qKVWYCHIXEsMTT9aUo94NjEThRo4Q2gwSUL9zYfQc7mK/q1u8UKp6qluX6/dTbMVCpY/EnffMcyM8kgJGI1W59FoM79YPbX2blm1ODkOXe5gyo3KaJo/hB8AP54XCPOEbPpnNyBJqfbUxDypuHmhwRNuCvckvWBiPnphmNI6xlxJQ4ncK4+/K+Wc7sctJDFg++umuW2ptZVNmshgnlJ4J6AxSDLvzBQE9l+APWbPchSTJu2/
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8804.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247636b6-efeb-4a72-0fe3-08ddeeb20b46
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 08:31:01.6994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cx2/kWkd9ir4hY8alWYLQCxHqahGKL+NokcflHTpOp/LZQBHtDDagMLAIg/gPLN/kLhGtb651dzWv9KsGvEihZmeITGFskTYKx0RdExd1Bg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14361

> On MPAM systems, monitoring groups are identified in the hardware by a
> (PARTID, PMG) pair.  Two monitoring group identifiers are the same only i=
f the
> PARTIDs and PMGs both match.  This means that the number of monitoring
> groups that can be created in each control group is the same as the numbe=
r of
> distinct PMG values supported by the hardware.  The number of monitoring
> groups that exist in other control groups at the same time makes no diffe=
rence
> to this.
>=20
> Currently, the MPAM driver takes the cautious approach and always
> num_rmids =3D 1.
>=20
> Relax this limit, by advertising the number of distinct PMG values suppor=
ted by
> the hardware.
>=20
> Code/Data Prioritization (CDP) makes no difference, since although this
> doubles the number of (PARTID, PMG) pairs available to a control group, e=
ach
> monitoring group now consumes two pairs instead of one.
>=20
> Suggested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>=20
> This patch is based on:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
> mpam/snapshot/v6.16-rc5
>=20
>  drivers/platform/arm64/mpam/mpam_resctrl.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/platform/arm64/mpam/mpam_resctrl.c
> b/drivers/platform/arm64/mpam/mpam_resctrl.c
> index f1e565cd1aac..f4f6fa9acfff 100644
> --- a/drivers/platform/arm64/mpam/mpam_resctrl.c
> +++ b/drivers/platform/arm64/mpam/mpam_resctrl.c
> @@ -1208,12 +1208,17 @@ static void mpam_resctrl_monitor_init(struct
> mpam_class *class,
>  		/*
>  		 * Unfortunately, num_rmid doesn't mean anything for
>  		 * mpam, and its exposed to user-space!
> -		 * num-rmid is supposed to mean the number of groups
> -		 * that can be created, both control or monitor groups.
> -		 * For mpam, each control group has its own pmg/rmid
> -		 * space.
> +		 *
> +		 * num-rmid is supposed to mean the minimum number of
> +		 * monitoring groups that can exist simultaneously, including
> +		 * the default monitoring group for each control group.
> +		 *
> +		 * For mpam, each control group has its own pmg/rmid space,
> so
> +		 * it is not appropriate to advertise the whole rmid_idx space
> +		 * here.  But the pmgs corresponding to the parent control
> +		 * group can be allocated freely:
>  		 */
> -		l3->num_rmid =3D 1;
> +		l3->num_rmid =3D mpam_pmg_max + 1;
>=20
>  		switch (type) {
>  		case QOS_L3_MBM_LOCAL_EVENT_ID:
>=20
> base-commit: b8e4905233fe45814b3c73be7e091f172cfb86ce
> --
> 2.34.1

Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

Thanks,
Shaopeng TAN

