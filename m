Return-Path: <linux-kernel+bounces-833790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86C8BA3138
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C521C02A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B441279DDD;
	Fri, 26 Sep 2025 09:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ZntUPmSS";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="GXKW9F2n"
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D5927AC3A;
	Fri, 26 Sep 2025 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758877664; cv=fail; b=G6AKoelHuNBBFOl6kPMDhCX3Ib27G1j+33fWrsBwuGZZbZKTx6NIyHmfW+HzGWtR6QYiNMGDSqJ12zM/kQnNLXyTDddELdk2Zu4rvouHIujHG2G/Ju2sgyPGikpEqNKwuAYdZQo6vfMN7udjiu99Bc4Tq9+H2o+hckdt98ykrjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758877664; c=relaxed/simple;
	bh=BiOJ57fXAEX8T+68yxyUj1jlMosQ7+DUnianOhor3/0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q60WO6Jfwqkwmb3RGdrRCd1GxBtSRXHzXvVe/CvsKcUOn6uDfHTQ/Dky7vGP17nWObOtv3d0QHnkIOMeY7jzxkJg2o+GtdIXeiGXyC/BNXrNlRPsko23sWjFR5zjuoA7RLqu8fnFwKLEJ9ber9VKsLXjyK/ITKn1rc2uPR4NFPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ZntUPmSS; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=GXKW9F2n; arc=fail smtp.client-ip=68.232.152.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1758877662; x=1790413662;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BiOJ57fXAEX8T+68yxyUj1jlMosQ7+DUnianOhor3/0=;
  b=ZntUPmSS2WzgsVs5JiegL4VGQox6JJF5Ft/nQUec1jdmMbw86NAtjw5l
   V2t30QoArG2NolAf5tbuVelL3yUqtUBIQRhDP2ALuEjJe0uBq7ZEWEj78
   RZXRf18Zn8g5iZeUQHfBzZdkv4LuGHgBWb0hG+H0Oit2kM2ndsDxN/sbp
   48rrsPKxXpcZeeK6nyhIyVr3F7TktdC9CkbAzZrquGMtcHgecOpCtdRjx
   GIbkyjou2Zk90UZrvCQJiw6HctGB1oXvcjYZ4GKOdjGhRvtaZ8ZaK3m6L
   TLmYd+grhSwgNU/TjkCthtWLSBIOnfZnX1MvbilUIGSn9kfy9UPbmeFR2
   w==;
X-CSE-ConnectionGUID: 7teLW9Z8R7uvo9RsLygZPQ==
X-CSE-MsgGUID: hSSBAgULSqejaK99GTI1xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="79948199"
X-IronPort-AV: E=Sophos;i="6.18,294,1751209200"; 
   d="scan'208";a="79948199"
Received: from mail-japanwestazon11011038.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.107.74.38])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 18:07:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlmrezGXRBVpCOXva6Bm6EKr6MwckZJULXAFCoPdJHTbS0CLO4DCq2cjMFfYmUe99QC1zYHwO4UxVyl5w+wXqxPyhCXJkc5PFvZmipMbS+cVG1Vyiw870X8TpjGcFf42YXrcb4AThJSUkE+MjedMC3UF4XPA/uzmZr6nqLkXC0CCSGqr770qaTEvAXqa2fziAiKXiNa9HjWX3/6rPFkfPOKDjSycn1XVjWj2YRhnJXMc4kztGDTBEc6fkfH+JRrHA0jB4NskFhrrLhfG4VqgcRGKocWGJZqRPXDyxFy9sRQ8ZEqwDYoC/QyRHiHVBGYR5hRBcRs+xmlLKnGlsWpjew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLwkwDnpg+TeMYUpiZl3fcCIX7B3pAHkaAaeT8wFqeI=;
 b=ec3NwLsQBLEKSgGlimL/23ltbwJ1cK2OTcpTcB1QTgs6F4zPAsxedy7jUe5OxXcr0sj9aEBythaUFVFfxKPSoJkcRvMXZ+V8gkTRKv5TYrP9zTIYGTEv/mO2AIJEbyhXy/nW0oT0efBmMxu49ViGWcPcl/2JY93RHc7dkpZaO8B2JfttjDT2xSqvQSvB7xrVMhoWEjx66R4bZiI53s9hDM8zvUqKnTG7Z58CjFQ21PbmysDIjhrCxegI3E7dV+2SJ/mGKqysih6FhdHPi7CymPZ9M7f8PYGc27seavchUcM9t169hJ8gwlNbwO4ecgKk15ho+6foZJ8EUzgLrEzI8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLwkwDnpg+TeMYUpiZl3fcCIX7B3pAHkaAaeT8wFqeI=;
 b=GXKW9F2nttBim3fSP5qerr0woodgxR14REWAwz+W5lVbDehpArR+PM5TodpmfLFsctvvBS+nPuCFAuT0MK1Qo3a1NuyVp5X3154deOpEHOWH4YAx6uabUmeh23H2AcnZ1xCrU/Od6fjGfv5Ejl4ghm+OQQ3duZc5jCtIcM+GwnaMF1qvp7KRclXNOX0OQeqJ7n6pGCn8Vr3vVOpz0xJegKbhwEIRvQyeyZfbSS43TyQJS3cVuu3EqpbS3YXVL0A0uX/eIxvyOmJO5XFFsi5Vj2CY1r2K/MVl5XwgnA2H7kk4EQiGdTvT8VUvbApcRDqh+fZYtAPr2hFtGtII4qAPgQ==
Received: from OSCPR01MB12819.jpnprd01.prod.outlook.com (2603:1096:604:33a::9)
 by TYRPR01MB12666.jpnprd01.prod.outlook.com (2603:1096:405:1b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 09:07:28 +0000
Received: from OSCPR01MB12819.jpnprd01.prod.outlook.com
 ([fe80::2809:3a6d:2dd0:ea9d]) by OSCPR01MB12819.jpnprd01.prod.outlook.com
 ([fe80::2809:3a6d:2dd0:ea9d%7]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 09:07:27 +0000
From: "Koichi Okuno (Fujitsu)" <fj2767dz@fujitsu.com>
To: 'Gopi Krishna Menon' <krishnagopi487@gmail.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "will@kernel.org" <will@kernel.org>,
	"yangyicong@hisilicon.com" <yangyicong@hisilicon.com>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>,
	"linux-kernel-mentees@lists.linux.dev"
	<linux-kernel-mentees@lists.linux.dev>, Randy Dunlap <rdunlap@infradead.org>,
	"Koichi Okuno (Fujitsu)" <fj2767dz@fujitsu.com>
Subject: RE: [PATCH v3] docs: perf: Fujitsu: Fix htmldocs build warnings and
 errors
Thread-Topic: [PATCH v3] docs: perf: Fujitsu: Fix htmldocs build warnings and
 errors
Thread-Index: AQHcLp9eGOPqqMFeBkaGaXRGHU60ybSlD8hQ
Date: Fri, 26 Sep 2025 09:07:27 +0000
Message-ID:
 <OSCPR01MB12819E309F236061FAD98416DC11EA@OSCPR01MB12819.jpnprd01.prod.outlook.com>
References: <61aace07-890a-4b55-8e84-935ebc4a3be1@infradead.org>
 <20250926043748.3785-1-krishnagopi487@gmail.com>
In-Reply-To: <20250926043748.3785-1-krishnagopi487@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=6df8ef27-5cf9-4602-8542-147df914592c;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-09-26T09:04:46Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB12819:EE_|TYRPR01MB12666:EE_
x-ms-office365-filtering-correlation-id: 9b79cc98-0eb4-4e84-7839-08ddfcdc1dc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?Yjl1bzJDdnFNbFE4d1JFcWVHMHdnamJCa2lpcmlpQjVIQ2h0ckd4N3VH?=
 =?iso-2022-jp?B?MUM3bEl0dVpRTi9QeU5YeE5xWTNLcUdNeHpNTkxQb1ZkSWdoOFUzSG5S?=
 =?iso-2022-jp?B?eUFFaEovZ0E1WDEzSWhuSHBrRlBiQjQ2VUdONURrcWFzcm9wYzFuMnBP?=
 =?iso-2022-jp?B?SWl5aFhHclRnSmFwbWEyMHlpdkVVaWlOQjRseldHbS92N3F2b2c4WENh?=
 =?iso-2022-jp?B?SHcwbXZwOVYzVUd6eHRnYnF2SDkxT0VDdTcrSUxlQnFWRVByWHZwczlW?=
 =?iso-2022-jp?B?Uy9wQUdGYzVZcFE1Njg4eEYxTGw5bmlreVhNRVB3VytPL0Z2MGYxMDE1?=
 =?iso-2022-jp?B?RktiVXJjOVd4OGxScG90Z3N4bTFCZE1oeFBoc0ZvdzdWNkZQRlpWWGlL?=
 =?iso-2022-jp?B?SS9ZeW0xRE1ieHFYd3Irdk5wVXEyTFdNRVBpZjRGWVIveTYzOUIzSEJn?=
 =?iso-2022-jp?B?UmZWOUUvWnY0ZjUxWnJaSExSTFVUdnhOb2NpMXplZXdCRHQrc0ZMd1BZ?=
 =?iso-2022-jp?B?NVJ6RVdaMStldER5NFRCY0ZuNFBBNzRJWHNMWEd6aEFUOExrVmxwRXY3?=
 =?iso-2022-jp?B?VzRwcE44U3h1MXZFbjVxQTZpSEtHMXhhVXlYUEYxZmx6WFJqUXQ1L0g0?=
 =?iso-2022-jp?B?Ukp1Z2JaRFFuK3IvTlFFR3U3a25KdWowa01FM0d3N2t3aE9ZaDJqNktQ?=
 =?iso-2022-jp?B?VTlUZklKaDVvUWhOSk9KVUZIaHVNUzhiV0FSRzNBUW5wbS91NTZGeVlW?=
 =?iso-2022-jp?B?dkxjSFNoZkxpS3MwdnN5alJ3ZHQzc3FkUU5kSE9XR0J5TVRUV3FhTWxI?=
 =?iso-2022-jp?B?enlGVkg4T0piOVdETXhkN0JTdDZzcUs4c0NLWE9LVDd2OG91eFRvLzRk?=
 =?iso-2022-jp?B?NTZJbzBpZTA2U3ZUQjFKQWQ3eDl4V2Y3Q2ZjRVloNW1oMGFNRzlDME5S?=
 =?iso-2022-jp?B?UGFsYk5DTk5qT1N5YktpbmtkWFVnL0FldnBEMlZhbjF4UGF0bWc2bERi?=
 =?iso-2022-jp?B?QUZIYkdXYll1ODFlYVlGeHJqaVpsalBTWVJxSUE5OGhpckhKdTRLUXM4?=
 =?iso-2022-jp?B?YXFrUW1zR2dDWHhMQWtwclovVWt6d2pmb3hNMnVIQjB2aDZ2cFUxTlhj?=
 =?iso-2022-jp?B?OHI3YU0yMkZCdzlQc1YzVWd1T0FWRWNjYjFWdEp0RDBUYk1Ca21mQlpB?=
 =?iso-2022-jp?B?akZ4WGdqbEVUWHRRQWI1akYrbmNvTGo3aDlLdXRzSkVoS2ZIcFhoc2pL?=
 =?iso-2022-jp?B?TjdNdFJYcmtsZ2UwcDYvQ1RyeEZPaUQzK1VLNHhEQkQvSldRMnI1ajdS?=
 =?iso-2022-jp?B?RDRVdnRYV3haeDJpbUlTZnVUemVHM1c0Z1U4dUkvK1pGb05LVEpwSFNo?=
 =?iso-2022-jp?B?UkpoVTIrMng0MSt5MFZuWUxzckJtVEtwdk9GQ3d0WGFLT21lY1VZZU56?=
 =?iso-2022-jp?B?eFNMVklzb2tUU2NBN003aHpGems5NzN0QTBrMzdrZFAyZ0ZoZUlnMUpv?=
 =?iso-2022-jp?B?KzFCRUVNbldGOTRVYzZkWVMrcnc2ZHFEU1ZUeUNnZmN0amxZbklBTzl0?=
 =?iso-2022-jp?B?L2NDVXZxN0hFRDFyeExBZ3d6dTV3ZzNaTXVEVDJlU1Z6d2FYOXg2OVBu?=
 =?iso-2022-jp?B?OFVnZjllTVExdVk2ZUt1WlBlN1pQNGowdk9QYks4U3p2N2tmVmVWK2U2?=
 =?iso-2022-jp?B?enV2UWMwb0hlZXNzZ1FvL1kzN2NPVUIxQnBMeDdxWVR1TXpUVDdBclQv?=
 =?iso-2022-jp?B?aU50WWZWb0Q5M3VDT0dRSDE2Y29OekpIZU9mek9HTHluV1FJa1BsMThD?=
 =?iso-2022-jp?B?V1VTWDVid2JKQXJmbmU0ODlISmxlY3BTc2tDbXRwaUlDcmhOR0lJeUw2?=
 =?iso-2022-jp?B?bTgvVlVNUTBycGxSSUlNT0ZMcDhxYnpVdXhsTEoyT09iQ3hqTmxNaTlH?=
 =?iso-2022-jp?B?dnpNZ3lGK0pBYnNESndsOFYvT2p6M2YvK1BrL2p0UWJ2VnkvYUp6MlUv?=
 =?iso-2022-jp?B?Wnp4RkxDVm1MT2VVWkp5amp6b0lzV0lzMVhUSnUzcENhWDJTaW5XTFdS?=
 =?iso-2022-jp?B?bEZ3THpoNEpPT2J2ZVVteGNYTi9tcS9XdEdJWmNJSHdTNGU0b3NHTUd6?=
 =?iso-2022-jp?B?S1QxZXhpSzhVZ3FsTlFiOTVvM2ptS3MyVXk0WE1BZ3ZuNFI1aEdRTGVZ?=
 =?iso-2022-jp?B?WXByS2tIWmlhbzRCa1VhaWphYzdvVng5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB12819.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?NVBibkV1UkcyOGQwUktUOEphWlZLYlRCbE1obTZZSU1oREtTNlZXc2Nh?=
 =?iso-2022-jp?B?OVpoQUt2aG9sTy9ZbUVjUTBpdk1YWVNkcndRQTlleDRlWlM5WXJCOWVO?=
 =?iso-2022-jp?B?TnZWQkkvazMwbDNQU1hWdzl6cDVlSEs4MnR4R1pZaFhsZDk5RFFraTZo?=
 =?iso-2022-jp?B?ZFN1V1pEdmhOZDREb0E4YnVuRTEvOEViN2hKTDR1L3dtVmViWStCcnBu?=
 =?iso-2022-jp?B?TGtwWExUd1NJeGZiWWp4VnpldWMrb0ZrTHBRblphZUJqeEZORkxyNlU1?=
 =?iso-2022-jp?B?L2lwN01XTVRaK1dxYUZNS3lLWmtVM3B6K2VtTUFHMmZzWVl3Y2YwdEJu?=
 =?iso-2022-jp?B?dkxjdjZURHU5SSt0QytYbkVvY0RTcFgrQnVPbzFsTzVGNSs0eXZtK1Jj?=
 =?iso-2022-jp?B?UzlUUU5ZTFBaak1qeXFhNTEwUDVrdVFyOFhqbkN0WDNmRFdSQUdJbjFL?=
 =?iso-2022-jp?B?NzVPaGVaYVFrdzlRcEt2S0NKbEpKY1ZPVHRVL3BXYVlXNGlxTG9pU1g0?=
 =?iso-2022-jp?B?MElMNDdMT1d4MnNwUjhIWEJxMzJDbWZ0NW1ITzNSd0JmV3dzMnpHNXkz?=
 =?iso-2022-jp?B?dTZLalQzei9tcmhtemVFMFkyOENPN2lwRy9VUjB0ZXNBNkJzRENCWHU0?=
 =?iso-2022-jp?B?MklVdzl6K09oY0lmNXNvQk01UjdnZ3dtL0k4TlYrbkpxeGZUMTE2Tzlr?=
 =?iso-2022-jp?B?K0FxcFh1ZFBrOE8rOU5JZU1SeTFmVm9yYktxeHJYWWt2c3VyMlh5enU4?=
 =?iso-2022-jp?B?UUpSU2M3SG9uUStRaktITnU2ZVkzbG1Wc0s4cDF1Q2loWWVCSGRXR3JW?=
 =?iso-2022-jp?B?RGtqYnA1UkZoNmRWeEx2aEFvYTFMaDNaK0krUjJESHoxT1ZFTHgzUlZD?=
 =?iso-2022-jp?B?ZUhQN0JZOHorVmhkYktwWVRNNDZWTGwwVndLeVZWdEgzcDQxQlRMYnJs?=
 =?iso-2022-jp?B?a0xkWnlMczY0NWJDQmZkdndtNUZBQ08ybVRNN0dtcGNIYzRIZWxFVWk2?=
 =?iso-2022-jp?B?RE42WE5BbHU2OWp1WUp1MUtEWkJNblo1SGNUc0wwYTAvbTRMcW41Zzhi?=
 =?iso-2022-jp?B?czRNbU1uWlAzUWhCYVAxdy9aL3RCalFmb3FsaUpmbFE5UGVoeVFiMlNB?=
 =?iso-2022-jp?B?QWFRVTgxdmZtdFJkMUJBVTg4UUdvU3Nnb25JbDRYV1dGbjNZTlgrN1FC?=
 =?iso-2022-jp?B?MWo4OE96VnBFUkE3cEVJbUFNbXdGQUp4L0ErMnRGQ0pad0tRQzhVUllD?=
 =?iso-2022-jp?B?MTJhU3FYSHZmSW9ueDJnM3NTK1BjK3JqU3dIbURvWHNTZnJsemtkTlhP?=
 =?iso-2022-jp?B?TzhtWE83UTZ3dmN1SU9xaTdxTnlSdUJMeVR6WTNJNEIwY3RNSURlZDdp?=
 =?iso-2022-jp?B?ZU9hTFp2NkpoMEJnQi83M1Vid0I3SmtMcnRiWEdORWo3MllVQS8rMlQ3?=
 =?iso-2022-jp?B?OEJmcXVHTXlGRW1vZEgzaVJDRWtMOVdIOGxVczRGY21ueVZwQ2YwSC9n?=
 =?iso-2022-jp?B?OGJ4WVdTenNJUDJNamJhWjZqNlM0dmZBNXVBLzgzTiswRXlYNCswdEIy?=
 =?iso-2022-jp?B?K2pMZ3NPSTM3YmxyMll0eXBXNC8xL0FWRE9UaEtrYXFaYzkrd25zSFZ5?=
 =?iso-2022-jp?B?TFRpOXVQb3JpR1k0dkdWLzFvRTFZWU9idDNkK0JZaTRubmo3UTdhdDQv?=
 =?iso-2022-jp?B?b3V0VVlDVW1qRXNuTGR4SjVreGZ1b3d2aUFON2d5N1hQWERaTFdCNG5p?=
 =?iso-2022-jp?B?emR6dmJOVHByRW0ya2VZOXV1VndEaXFtYllEVUNHSnUzUE1tTjJ3dklG?=
 =?iso-2022-jp?B?Y0FFUXRDUjhXWExiMGVJZnl5RkU3YkdHV29VTVRwRmd1TUFkbVhtQUVl?=
 =?iso-2022-jp?B?SlQzaTVlZzNYbnJSQUYxYXYxeW01VDBES1BvM2RHSjd6Z1loOC9BcGx6?=
 =?iso-2022-jp?B?TzVtTGdRaVFBM0RtSVlYczlNRFo5cUZFMUdyaVJTbG5Ud1JOa0VKSU9m?=
 =?iso-2022-jp?B?TU8yNWxicWNBVklnaUZVWUYyc1JVam1xMUw0cFdkNmV1ZnZEcXFUcG1W?=
 =?iso-2022-jp?B?RFQwa2pYT2ZXdzNndnFGY29PeXEyeUFjcVlJSTBHZzAvTHpGbUcxVzZP?=
 =?iso-2022-jp?B?RnBUdEFNMFo0ZkZxbkp5QmprbkdnODJnck9NNUFZS2p6MG9VZTU2WVhK?=
 =?iso-2022-jp?B?NkNMNUlXWkYrbG16T3ZueUdwdTBWYWlodWlVc0d6eEs4Zjk2bllJblZp?=
 =?iso-2022-jp?B?K1h0YWx1OWxhTlFVcFRNMzJVTnZZQmZidDI0dnZHQVJFWWcwSktTaG1G?=
 =?iso-2022-jp?B?b3IybDJ6TEtsbUdxNGl1Rm9hMDVTazRZQnc9PQ==?=
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
	2rE1WTPXOV3C0TZzwRaGKrPam6KgzOD55J6Ov3ZJN/ctemdWloz0Y4ebYMgPYdGpeSFTMTfNlg1gHyiQXshk3msYc2k4Tfg3Xvn62am6rzCmhdMnqNFdOvCvW3jOFGfoDvj2obyvZDG3FgdLPhizWwiWHQtrkuSC10HLE96PAMY3BZkXS3gcxUSRpDQhpfqWw6kfC3FR1sWw+F2XkoI05vv6XrDziGHNyTy5LGZDGEEhJBChHTyN72yOJIsaWyBvY5dAntbxSQlCUcmJ5rXMh2KAC3eCEGoPtUuhWF+aD4DKF7S48kW4qJjUyYAFjjH9w2145+9DrywFFPInvY2kMl636HYmfvVcWVsv2YcFkWPgahBX4ixde38k1v2MpVAF1wW6E48jlAWdVR+YsEMT/GPFK9RapNo6B+sS8bA93KMtfrBdaDzW5lX/90OuXW6DjZ049faveJGF2ElBfo3XofuYUSgHxQ+wSuoM3IKxZ2XfWrRyLTSIs9kD2kgyp4882O6Wrf6a4HGr3s0bbZ9TvMDuNu2/M91EqUC2sdGmitTMQDPSSSOOpR52YzekM5GcCMn+rbUs9l9OPh8xh2rcXW0aI1QCQ71hupsCx0RnmmY/1wahRJ3g1nPyN3E92i9T
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB12819.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b79cc98-0eb4-4e84-7839-08ddfcdc1dc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 09:07:27.9179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vEzp+aSrHjgkXNPioy8mG67V0yhLNMlfS6blDrFDhbyVxRjPHegomMDBBnnuH/MbxO62VdvfFIJ9m200zx2KxL5/zZNFRnVmCDGFsZ9lGnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12666

Hi Gopi and Will,

Many thanks, Gopi, for submitting this updated patch to improve the documen=
tation.
Reviewed-by: Koichi Okuno <fj2767dz@fujitsu.com>

Will, please consider applying this patch.
(To be clear: base patch "perf: Fujitsu: Add the Uncore PMU driver" is curr=
ently in for-next/perf)

> Running "make htmldocs" generates the following build errors and
> warnings for fujitsu_uncore_pmu.rst:
>=20
> Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst:20: ERROR: Unexpect=
ed indentation.
> Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst:23: WARNING: Block =
quote ends without a blank line; unexpected unindent.
> Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst:28: ERROR: Unexpect=
ed indentation.
> Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst:29: WARNING: Block =
quote ends without a blank line; unexpected unindent.
> Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst:81: ERROR: Unexpect=
ed indentation.
> Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst:82: WARNING: Block =
quote ends without a blank line; unexpected unindent.
>=20
> Add blank line before bullet lists, block quotes to fix build
> errors, resolve warnings and properly render perf commands as
> code blocks.
>=20
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> ---
> Changelog:
>=20
> Changes in v3:
>   - Properly render perf commands as code blocks (use "e.g.::").
>=20
> Changes in v2:
>   - Remove formatting changes unrelated to the fix.
>=20
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
>=20
>  Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst b/Docu=
mentation/admin-guide/perf/fujitsu_uncore_pmu.rst
> index 46595b788d3a..2ec0249e37b6 100644
> --- a/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst
> +++ b/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst
> @@ -15,15 +15,19 @@ The driver provides a description of its available ev=
ents and configuration
>  options in sysfs, see /sys/bus/event_sources/devices/mac_iod<iod>_mac<ma=
c>_ch<ch>/
>  and /sys/bus/event_sources/devices/pci_iod<iod>_pci<pci>/.
>  This driver exports:
> +
>  - formats, used by perf user space and other tools to configure events
>  - events, used by perf user space and other tools to create events
> -  symbolically, e.g.:
> +  symbolically, e.g.::
> +
>      perf stat -a -e mac_iod0_mac0_ch0/event=3D0x21/ ls
>      perf stat -a -e pci_iod0_pci0/event=3D0x24/ ls
> +
>  - cpumask, used by perf user space and other tools to know on which CPUs
>    to open the events
>=20
>  This driver supports the following events for MAC:
> +
>  - cycles
>    This event counts MAC cycles at MAC frequency.
>  - read-count
> @@ -77,6 +81,7 @@ Examples for use with perf::
>    perf stat -e mac_iod0_mac0_ch0/ea-mac/ ls
>=20
>  And, this driver supports the following events for PCI:
> +
>  - pci-port0-cycles
>    This event counts PCI cycles at PCI frequency in port0.
>  - pci-port0-read-count

Best Regards,
Koichi Okuno


