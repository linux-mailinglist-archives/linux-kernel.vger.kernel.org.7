Return-Path: <linux-kernel+bounces-732964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D97EAB06E39
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6DA189DA8B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F245F2877CC;
	Wed, 16 Jul 2025 06:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="LrVf2VLG"
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C0726E179
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752648643; cv=fail; b=cz7YfedsO3/U3K2/94Ak79SAmt1ZWXBnp23ISCWoamaTl+IAlqK9qZkt+0/5vjSVHCPFMJr6a2Q2Amw408u+KC/DCrXuUsdy/1DBXxYiLHxXjJRFC4s9uLgSq1bsOj5h/jyPEWps/WHqZKHJAx4CCvTOl1bdzPcelBQ+BFzPZIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752648643; c=relaxed/simple;
	bh=+H2TOnbBgxUMMNKRHrL0P991mgy6FuBFP3vbP2OqXyc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ue41TSU2GTLb7hTtr9FQViCE0jqn0RlMLmEwbgZYfeknICSuZoTYU6sZ8P7SskW6mJC7rKJWcorBQaBabLEE2G1FJMu0tPavqZuRwYhGKxWKPZORzqv10oTYH3Vo9G7J5LckLses0xWNjEZVFp1eVFJ96b5oJc7lK384uay6bec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=LrVf2VLG; arc=fail smtp.client-ip=216.71.156.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1752648641; x=1784184641;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+H2TOnbBgxUMMNKRHrL0P991mgy6FuBFP3vbP2OqXyc=;
  b=LrVf2VLG2aSjHHavF8XP3et1GGWk5WIUqOP4RKAZ8/4yY8+R94kG/+MQ
   g33gCI7N/aGpgivdFjoRgYLEr1UYQY9Iw9AvS9M64t6OdYoIiRPnRF4rU
   qu42xN4zhgrSEB6FaMsVJq4yCpuRywA12IjT6uyDB9ppY6ReBgjJHClt9
   bv8V9UJosmuyMqZW91tuPwYxPyb69pEw79kvRccp6bqHHxG0Fo4+PMH4w
   MvoQWT96UdKKVjlVAPpmr1jEKpO0Q1nLCebyN7RqMHQ8aqw4nQh7UEo4M
   t9G9uRG6UjK0DrbB+9u9rRZuKPk0p1qK1ZP4Yr7DTq72nVDA8+aSGEtnb
   A==;
X-CSE-ConnectionGUID: rUZJx0ibQOW982LjkZZxSw==
X-CSE-MsgGUID: 7XYi1mOQTAK1DsqIxRF4Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="162662049"
X-IronPort-AV: E=Sophos;i="6.16,315,1744038000"; 
   d="scan'208";a="162662049"
Received: from mail-japanwestazon11010047.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([52.101.228.47])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 15:49:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSjRdEbEMbR+qwbKpcIghkzKoMTUia9IUN/20hdUD7c51Z8Y23tzxjtSFX/KeyO5iOzDeCI+Yn46Cb2tPjYoFGkN28UTc2ZSANjfNnKbvroVW4J54s5F2QuHXnIArIKMD8hDhkj/GLFva9ts5VLksNk9XXbP/AfvLrvgJ35Bdfwg16UJ/5Aa7iyMRFXXGXZq2ymKZVO7rQbJLGjmokQcTp4dVyHNBi3IAXk3x83Usvl2IE4GJeCPdchczbiIXfNJEnaogAjcsZMiWQRYrw+r1/QHscSbS52l9w+5dPYO1Brv+ag5DIyetgc0W8S5rU7pnNIWgxLyt2XjBQzcfQ0VIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feJV4wpKK4+kiiAFnxenDkwjwY7y+ddgk1M2g9RMxfA=;
 b=ZZgzari6HyOyaJThrcnER5qnYTyBhturZ2cZQnn5MiJ/2EjVX1so7eZVw2pZsfPpHy2Nob2H+BixaSV5IX7JXRVMUOJM0lADk2GFutir/8KEjNSfOYTHl+msVKNCmwzOI2k427HSZDM8duxqdhUBUld5880eL2dNqnUhAbUcJkH9h29X2JY1t+bHct0W0umdyPUN8z7SvfzkyBPmz4y5TThwkyAswLu++p5fcABvp/GkhpCsXOPM1fErid5CjRhJvO20r0rDns9VVgOPWiLKygVyvBeQsm1ciaUfnA+n5gF/3l4Ip2JlZUJrNdQc+mXZ1pI4jeARn9fxhdr6eiDxqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYWPR01MB8282.jpnprd01.prod.outlook.com (2603:1096:400:165::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Wed, 16 Jul
 2025 06:49:21 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672%7]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 06:49:20 +0000
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
	<kobak@nvidia.com>, Dave Martin <Dave.Martin@arm.com>
Subject: RE: [RFC PATCH 27/36] arm_mpam: Allow configuration to be applied and
 restored during cpu online
Thread-Topic: [RFC PATCH 27/36] arm_mpam: Allow configuration to be applied
 and restored during cpu online
Thread-Index: AQHb8pMFQliP6V+zF0Wi1HZVo7Pom7Q0VYog
Date: Wed, 16 Jul 2025 06:49:20 +0000
Message-ID:
 <OSZPR01MB8798812D121619E9BB9BDF2A8B56A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-28-james.morse@arm.com>
In-Reply-To: <20250711183648.30766-28-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=7651964c-a365-43d6-9105-9ecc59af39ea;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-07-16T06:46:22Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYWPR01MB8282:EE_
x-ms-office365-filtering-correlation-id: c249534a-a392-40a8-9ecb-08ddc434e498
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?TWxKRkQvaTB4NTdKeE5aS0VnWlBsUC80c1FuckdneXN6SUN6bTVXanl1?=
 =?iso-2022-jp?B?VW8yS1pRK0lGemdod0QwaXlPaVZ5L2lNY2tCVEJhajBvNGhhRm00aHdI?=
 =?iso-2022-jp?B?SUpMUGpUNE5pd0JzRTBYSHd4aWgzRlFPVC8rSHhyeXlSaHRjZkVON1ln?=
 =?iso-2022-jp?B?VWxteFp0UThKUTlpTTFGaUxaSFJQYktrVUx4WVpja3V6RWlacGp2SzdG?=
 =?iso-2022-jp?B?Q1lVc2VmdVo0SG9rbElKNEZ6Wm5PSXJrVDNTTndsNmEzQzF2Njc1UEx0?=
 =?iso-2022-jp?B?ZWp6UUNCT3o5L09vd25qcDdGR2VJOEFzcERDa1M5ejZDdkZlWDNwTDhD?=
 =?iso-2022-jp?B?TzFyZDNud3E4WjRYeUxwNmlURnQrZ21oODFFVFZ3T1RBbWJscTc5bVdZ?=
 =?iso-2022-jp?B?SWF6emZIU0tjL3hJak9IOFpiTXZpMjZpZlhJdnA4WE9DL3N6Wi9HNzcv?=
 =?iso-2022-jp?B?RUxqeWtmeEFLcDJWRE1LazlpVWRoYTR5UFpLN295L2R0NW5waVdQT05v?=
 =?iso-2022-jp?B?M3hNSlRBTjIydk12clUzYWtqVXBDQm54eVdtQkhsQkF4T1RnUzRlc2M4?=
 =?iso-2022-jp?B?bVZXWk1PMHptNW43RGR1eTZEVTlwUlhSR1BkMFlYVk9uelpOWjhNakFX?=
 =?iso-2022-jp?B?Q1NKUitBSTdIYkdaOFJtMWpnN2ZzRTJteWdVa0NSeVlTMndsWmUvcDRj?=
 =?iso-2022-jp?B?aEdKWkd1eXkxdEVZMTdQMWJocmI4K2VXNjBOWVVNVG02aG51d0YxNUd3?=
 =?iso-2022-jp?B?Q2ZPOFR3ckdMYjVPblFlZDR6QWdsQzFIaG5MSlNzcDdWdmUzZDdVbm9U?=
 =?iso-2022-jp?B?WG0ycmJuOEZzbFVhNTRLcHo0aWN3Zm5IWUwrU0h4cm9XdUMyYnd1SFNT?=
 =?iso-2022-jp?B?NjVRd2ZpN1RlTUdvR2RPb3ZFZFc0NHNVMFM2Yno5bVUzVEVpRThjMTdo?=
 =?iso-2022-jp?B?Yk5KTWkyMWg0QTRUN3ZPMzZQOURkbW5ZSlhDMG9Pb3NadlZYeHZSdmZ0?=
 =?iso-2022-jp?B?K2xPWkRURXUvVUo4bytBVFdoendIQ21WbmxNYklsbVU1cnIwbExMZHIw?=
 =?iso-2022-jp?B?NmZidlJxdlp3ZDc3dVU4UkhQK2FRT25aZG84YU50eDhvbWhHdmQrTVJs?=
 =?iso-2022-jp?B?TUY1Z21kRUNwRGJ4a1RRSElMTjl3c0RPa01XTUJwc0E0Q05qc3pKcHVC?=
 =?iso-2022-jp?B?MFRGQkZXNXdaTHZxYURzNnFFbVA0OEpSS0hQY1JpTWl6RGplRG9zQTlp?=
 =?iso-2022-jp?B?SkdvTTM4eEVYRGw3KzY2ci96S1V0emZIaE94YnVNWlFoUDRuTWpiOWo3?=
 =?iso-2022-jp?B?cGNzdTZLVEtPWENOMzFzemhRMjBHT2cyc2NQVTBMSVhaU1dEeE9yZGdr?=
 =?iso-2022-jp?B?ME9mZHJ0U1RrdDcyeU9BWk5FeFlJR2o3RDVnMWpmbmYzSXhSUGh2M0FE?=
 =?iso-2022-jp?B?SDM1SGt1QUVFOWovbFlITUh5QkRQWjYyL2xObTRiN2IrQmQzUlBGQ25V?=
 =?iso-2022-jp?B?NDhnd3hXMDRyVkcrRkhDOHdJb3M0bkdva0x2dnFHZmhGWlJVV29xVk5X?=
 =?iso-2022-jp?B?Zi9UT0NkTTQ0c3o5SGxMR2x2SVFjOWh4UU83MVQ0WHNBbGpiWXdIT3NF?=
 =?iso-2022-jp?B?RnU4SFR4QWN1MDVlZ2RKWExBbjV4YkJFeWI3TXdVb09iSDY1Q3djSisy?=
 =?iso-2022-jp?B?RkFGR3l6SmxZQW0yL0xHeDN6bmZ6MnQvOWJ4RkJYRGJIRk0rdE90K1BS?=
 =?iso-2022-jp?B?L0xGZmlSTFJZcmNoenl2ckFObnFPQU55QzA4QUI4TFJ4anlzSDBGZDVy?=
 =?iso-2022-jp?B?bHhJaW9SUmE3cUc1YVVnVjh2cTVUSXhKWHFNVTBXb0E5Y0hwTlFvdDdw?=
 =?iso-2022-jp?B?THVrZGIways3UEd5RXZ6b2hKNkZEU2dBYkxFNjVuQytZa1lUR2xFNmJE?=
 =?iso-2022-jp?B?V2NBZ0t0MTErOHJTcGRXR2NLRW9ydnFhSUZ6SjJic25XTVdzMzhGKzRZ?=
 =?iso-2022-jp?B?aW5SRUxsSTZBaEJKN093T2txRjdHRWtsK2kya0dzYkVkUEdTa2RkbEJo?=
 =?iso-2022-jp?B?QjdldE5hZG5JVHZHTFF4WFAwRE4yU0hxdU5GRjNmeElHR25jaTlUS0to?=
 =?iso-2022-jp?B?MDQ0elJiaFhleE1lN1lRNkM5S3VMTXRzZlcwd1lWa2ZqcXpkN0JNV0NI?=
 =?iso-2022-jp?B?U2dTRUQ5N1ZtckhHK3MxaE5aZ3ovcFQw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?WnVWTUlqYXJEN1hwYWZsWnhUOGFwKys0N0FKck82TlZseXRac0tWRXMv?=
 =?iso-2022-jp?B?SUw2emVxQkp3T016Y0F4NEZwM2RGUldiWkdRTE9CK0NVbWhUMWJIM1h2?=
 =?iso-2022-jp?B?bmxhUUFUVHNjenJIYTdpY25rbXZ3d003dTJNVUFhL3d0QU95cE9keW1a?=
 =?iso-2022-jp?B?M2g0NUlxaE8yeHRzRlVIemVUOWp2amNvUnd5WTlIbXZIUE9BejAwYnNP?=
 =?iso-2022-jp?B?bjlLUXgwU3AwZjdXSVFrQ20zWEovV0dmcE5jY2JqWFRyck9JLzRWQlhJ?=
 =?iso-2022-jp?B?ck5DSFZuQXd1dTNROGVBU1pXWk0vcjBtbDQ3d3dJUktEQW1zN2pneFRv?=
 =?iso-2022-jp?B?c0laenVmbm01dGNvSklUU1dvMnRZZCtGTk0wRVl3aVJWdXVyV08zTTk1?=
 =?iso-2022-jp?B?bXgzbjBVbTY1V1VNTC85N2hpQkhQdWhGM0t2NUVrRXVvQnZ6My9yaDBC?=
 =?iso-2022-jp?B?b2Vybk9wenorcmtTa3plRTRmM0Y1NTRtVTJwTlhnTTNnUGlxMzFDa0Rm?=
 =?iso-2022-jp?B?UHJ2Wk8vdzM3TXh6dE1Va0RXTFhMdlZWTkRPamVuUyt1UmtFR1JiNS9E?=
 =?iso-2022-jp?B?aVVmdHM1Z1liVTRZcHBBTWtraVNROXpPREFZaEk4RTZYSjdpa1h1NVJF?=
 =?iso-2022-jp?B?Q3RZSHhvLzRNMjNwSnZPczlXdS83dVdSOUpRWVpQSW9iQUdWSzdyYjZG?=
 =?iso-2022-jp?B?NEYvV3NPelZDajREK1p4WnZ0ZFB0ZThHQXRyWEwzNTJsNDNiRmQ4bVpJ?=
 =?iso-2022-jp?B?RXBERWJhdlZyTDY0VG5hM0IyUlZHakc2aVZyT3FUUDQ4Z1UrSCttQ1Vl?=
 =?iso-2022-jp?B?ZlM5aENlOWhzbmRTTDNaUHhXWWR4SFNXamU0WHNKVlNFMlNOd3pJd1Ju?=
 =?iso-2022-jp?B?R05iMDlLVGJWWTBsV0YxcjVmcTlIZVRrOXFDbkQvL0RtTld4MXNKRjhu?=
 =?iso-2022-jp?B?bElYeHNGTEtMektGUmgrMDYvNkZjUkVPR1MyUDRuK2pXaGtrcG5jUmRX?=
 =?iso-2022-jp?B?UDFhQTZNNVM5QkM0c2hjbC9YdzR3TFJYVmRqcDF4WTFNM2krUHJqOFp2?=
 =?iso-2022-jp?B?MFUvL3BsM0dHdGxMQVZiV0ZRMEZ2c0hmWU5IQVQrYWM3dTQzU3hqTWRi?=
 =?iso-2022-jp?B?UzdLd0l4dWc4T0M1alFWbEhBM3QyZjNmeDNSZ0hpZm9MY1I3UENBaVRY?=
 =?iso-2022-jp?B?L1pQWXN5bVRMcy9aeUdkVGxqeEFCN0t2VmN1c05YYmZoQ2x2WmRPMWYw?=
 =?iso-2022-jp?B?OFVtVGwwVWt0dml2bm40Kyt4R25yeEthTmpZYmF1SFg0NVROVUhSeUpp?=
 =?iso-2022-jp?B?WUZoR01jSzJuVndxSmR0T1pIanlzQzErU2J4dzJpNFNVa1RHQ0pvNEJT?=
 =?iso-2022-jp?B?VE8ya2YrbVJZaFdjbjlwTm9XR3lIbFFlK2NLd2RzSXVPN2tnZUhsMy9F?=
 =?iso-2022-jp?B?S0RPYUR3bjN5QlJwM1RCMkZrRmFZVE93MHVkZFJyU2NvcHBLdFlHdGVi?=
 =?iso-2022-jp?B?N1g1WjdBc1JkR3JGOGplNzhid1MzSkIvZjJBYzdia0VFZ2hBbnlnQXIv?=
 =?iso-2022-jp?B?ZTZNRnlmSzEyVzNLSGZHbCt3VkVYRnBMZWgydyt0WG91TXJwRXRLTVpi?=
 =?iso-2022-jp?B?QkEwNytZbkNQWmZEZjhaTFVtL1BpZTlpN3hVUk9BRzY3WE43WkhBUG9m?=
 =?iso-2022-jp?B?VTNLTUpTeFk4OG81TmJBeWhBNEpqcHFQRzd2eEp6aFRScmJWaHBEVm5a?=
 =?iso-2022-jp?B?RGxzWkczZ1hIR2sxczZ1YXZTMHI5eWVUSVkrL0d5ZU5ZVlgrZ1BBOFRF?=
 =?iso-2022-jp?B?aUtKWGlycEhvMHlONnFzNis0S0lkMkIxL3hlREx1SXlvcVBIdkFrVlJ5?=
 =?iso-2022-jp?B?VEZRV2tsMFNvMlhxSkhXc2tVS0FyNHhFYzB3SHZXOHNLeG1yWDdsTy94?=
 =?iso-2022-jp?B?SW9wMDc3a21vQUh3Vm1JazFzdFJqK1kwdEt6b1pSWDZrd3ZhS2FyZ2Qx?=
 =?iso-2022-jp?B?UFRETkJreGx5eG12VWhteFFNZ1NQUkZ1T0Q3U1ppUlV6dStnMytKQWZz?=
 =?iso-2022-jp?B?VlVyYXdwUGthUHFOZEVqTU12K3RObzJGSjUreml2alBvYjF5TndiQnhm?=
 =?iso-2022-jp?B?enVrMWEyNUpjN295Q0Z6WXN3SjhxRkNCbFZiYjdWWDFtRmQrMVdJVTBh?=
 =?iso-2022-jp?B?TVFCTXd5VkR1Qy9DSE1IUFRLdVN5NG1KcE81QmhwcGhOZExjV3lKN2g2?=
 =?iso-2022-jp?B?R1phSmlWS0E4U1c0RkNBUmpEMHhPdytXdyt0VWQ1RnJxQUszN3dyMXAv?=
 =?iso-2022-jp?B?ZGVzVmQyTGN1aUU0TnlKUUtxMEhUWUJFRFE9PQ==?=
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
	RlO3Qby1DUzmt0tDvwd1AIsONon7cWBS/99YH8jP6kSZfyuPuky+FNxHrM031w7uxu4l4GvdXxkUtwwN2Y24G3mlfYdlwralT3JdNoQaS6lcUMbuGO0uSoF4x2hBzZhF7qOo3oF6J3s2XWjPhhBkzli1mhjxdfUiK1mWjN7RQ+NBHJOI/fOb+WMUOoMUv+HcGSG6SRKxg/+j2p2iHPOUnZuzafchO8REc7kIJmekMjyto4u81K99Hyy1gwUGO2NdCLHwJJ5RX3ldMro7nsUWOitZWYYhnKo6ju6+oLRMm7hHkGsvvNv2joaNmsSduo5Co5u44yhNWXPZ00IjoMgq4HCJaIbAaz+wyKb77xX8g+jXOQTBP3pBTiE3duyqNmqwOalBv8f7m4jh8oEusfRsGJuSs8CUQ2Nn24tQJHjjiXQ7+0KpIBdkxaIiK6hOxwAybjaZOosyVo03RE7JoUIwgFcxqAFi/w0CNltqdOWEeys/pV3f4lqBX43T/6BJER988VMVc87yD7uSeE+DaE6s9c1riX4XXwF0A6yH7RJdCIXbUSr5xG5m5UA78YiWN14kVgxdlx4l6Eay3yPdWSrQkdQ37/wXKuas3T9F2J4cBZmQVmUIFaPfz41rV7W4bL+1
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c249534a-a392-40a8-9ecb-08ddc434e498
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 06:49:20.8763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iIck5eWoikLy4xySVthdKcKeumz+ta9uJX3qn+S3cQgVqMSIBKvUsMZ0SxKr2LwXfjb3NgJSTtLoLlF6HqcQcu1lkJDQ+NVxb5Cf09SgoPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8282

Hello James,
=20
> When CPUs come online the original configuration should be restored.
> Once the maximum partid is known, allocate an configuration array for eac=
h
> component, and reprogram each RIS configuration from this.
>=20
> The MPAM spec describes how multiple controls can interact. To prevent th=
is
> happening by accident, always reset controls that don't have a valid
> configuration. This allows the same helper to be used for configuration a=
nd
> reset.
>=20
> CC: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/platform/arm64/mpam/mpam_devices.c  | 236
> ++++++++++++++++++--
> drivers/platform/arm64/mpam/mpam_internal.h |  26 ++-
>  2 files changed, 234 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c
> b/drivers/platform/arm64/mpam/mpam_devices.c
> index bb3695eb84e9..f3ecfda265d2 100644
> --- a/drivers/platform/arm64/mpam/mpam_devices.c
> +++ b/drivers/platform/arm64/mpam/mpam_devices.c
> @@ -374,12 +374,16 @@ static void mpam_class_destroy(struct mpam_class
> *class)
>  	add_to_garbage(class);
>  }
>=20
> +static void __destroy_component_cfg(struct mpam_component *comp);
> +
>  static void mpam_comp_destroy(struct mpam_component *comp)  {
>  	struct mpam_class *class =3D comp->class;
>=20
>  	lockdep_assert_held(&mpam_list_lock);
>=20
> +	__destroy_component_cfg(comp);
> +
>  	list_del_rcu(&comp->class_list);
>  	add_to_garbage(comp);
>=20
> @@ -909,51 +913,90 @@ static void mpam_reset_msc_bitmap(struct
> mpam_msc *msc, u16 reg, u16 wd)
>  		__mpam_write_reg(msc, reg, bm);
>  }
>=20
> -static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
> +/* Called via IPI. Call while holding an SRCU reference */ static void
> +mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
> +				      struct mpam_config *cfg)
>  {
>  	u16 bwa_fract =3D MPAMCFG_MBW_MAX_MAX;
>  	struct mpam_msc *msc =3D ris->vmsc->msc;
>  	struct mpam_props *rprops =3D &ris->props;
>=20
> -	mpam_assert_srcu_read_lock_held();
> -
>  	mutex_lock(&msc->part_sel_lock);
>  	__mpam_part_sel(ris->ris_idx, partid, msc);
>=20
> -	if (mpam_has_feature(mpam_feat_cpor_part, rprops))
> -		mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM,
> rprops->cpbm_wd);
> +	if (mpam_has_feature(mpam_feat_cpor_part, rprops)) {
> +		if (mpam_has_feature(mpam_feat_cpor_part, cfg))
> +			mpam_write_partsel_reg(msc, CPBM, cfg->cpbm);
> +		else
> +			mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM,
> +					      rprops->cpbm_wd);
> +	}
>=20
> -	if (mpam_has_feature(mpam_feat_mbw_part, rprops))
> -		mpam_reset_msc_bitmap(msc, MPAMCFG_MBW_PBM,
> rprops->mbw_pbm_bits);
> +	if (mpam_has_feature(mpam_feat_mbw_part, rprops)) {
> +		if (mpam_has_feature(mpam_feat_mbw_part, cfg))
> +			mpam_write_partsel_reg(msc, MBW_PBM,
> cfg->mbw_pbm);
> +		else
> +			mpam_reset_msc_bitmap(msc,
> MPAMCFG_MBW_PBM,
> +					      rprops->mbw_pbm_bits);
> +	}
>=20
>  	if (mpam_has_feature(mpam_feat_mbw_min, rprops))
>  		mpam_write_partsel_reg(msc, MBW_MIN, 0);
>=20
> -	if (mpam_has_feature(mpam_feat_mbw_max, rprops))
> -		mpam_write_partsel_reg(msc, MBW_MAX, bwa_fract);
> +	if (mpam_has_feature(mpam_feat_mbw_max, rprops)) {
> +		if (mpam_has_feature(mpam_feat_mbw_max, cfg))
> +			mpam_write_partsel_reg(msc, MBW_MAX,
> cfg->mbw_max);
> +		else
> +			mpam_write_partsel_reg(msc, MBW_MAX,
> bwa_fract);
> +	}

0 was written to MPAMCFG_MBW_MAX. [HARDLIM].
Depending on the chip, if [HARDLIM] is set to 1 by default, it will be over=
written.


Best regards,
Shaopeng TAN

>  	if (mpam_has_feature(mpam_feat_mbw_prop, rprops))
>  		mpam_write_partsel_reg(msc, MBW_PROP, bwa_fract);
>  	mutex_unlock(&msc->part_sel_lock);
>  }
>=20
> +struct reprogram_ris {
> +	struct mpam_msc_ris *ris;
> +	struct mpam_config *cfg;
> +};
> +
> +/* Call with MSC lock held */
> +static int mpam_reprogram_ris(void *_arg) {
> +	u16 partid, partid_max;
> +	struct reprogram_ris *arg =3D _arg;
> +	struct mpam_msc_ris *ris =3D arg->ris;
> +	struct mpam_config *cfg =3D arg->cfg;
> +
> +	if (ris->in_reset_state)
> +		return 0;
> +
> +	spin_lock(&partid_max_lock);
> +	partid_max =3D mpam_partid_max;
> +	spin_unlock(&partid_max_lock);
> +	for (partid =3D 0; partid <=3D partid_max; partid++)
> +		mpam_reprogram_ris_partid(ris, partid, cfg);
> +
> +	return 0;
> +}
> +
>  /*
>   * Called via smp_call_on_cpu() to prevent migration, while still being
>   * pre-emptible.
>   */
>  static int mpam_reset_ris(void *arg)
>  {
> -	u16 partid, partid_max;
>  	struct mpam_msc_ris *ris =3D arg;
> +	struct reprogram_ris reprogram_arg;
> +	struct mpam_config empty_cfg =3D { 0 };
>=20
>  	if (ris->in_reset_state)
>  		return 0;
>=20
> -	spin_lock(&partid_max_lock);
> -	partid_max =3D mpam_partid_max;
> -	spin_unlock(&partid_max_lock);
> -	for (partid =3D 0; partid < partid_max; partid++)
> -		mpam_reset_ris_partid(ris, partid);
> +	reprogram_arg.ris =3D ris;
> +	reprogram_arg.cfg =3D &empty_cfg;
> +
> +	mpam_reprogram_ris(&reprogram_arg);
>=20
>  	return 0;
>  }
> @@ -984,13 +1027,11 @@ static int mpam_touch_msc(struct mpam_msc
> *msc, int (*fn)(void *a), void *arg)
>=20
>  static void mpam_reset_msc(struct mpam_msc *msc, bool online)  {
> -	int idx;
>  	struct mpam_msc_ris *ris;
>=20
>  	mpam_assert_srcu_read_lock_held();
>=20
>  	mpam_mon_sel_outer_lock(msc);
> -	idx =3D srcu_read_lock(&mpam_srcu);
>  	list_for_each_entry_srcu(ris, &msc->ris, msc_list,
> srcu_read_lock_held(&mpam_srcu)) {
>  		mpam_touch_msc(msc, &mpam_reset_ris, ris);
>=20
> @@ -1000,10 +1041,38 @@ static void mpam_reset_msc(struct mpam_msc
> *msc, bool online)
>  		 */
>  		ris->in_reset_state =3D online;
>  	}
> -	srcu_read_unlock(&mpam_srcu, idx);
>  	mpam_mon_sel_outer_unlock(msc);
>  }
>=20
> +static void mpam_reprogram_msc(struct mpam_msc *msc) {
> +	int idx;
> +	u16 partid;
> +	bool reset;
> +	struct mpam_config *cfg;
> +	struct mpam_msc_ris *ris;
> +
> +	idx =3D srcu_read_lock(&mpam_srcu);
> +	list_for_each_entry_rcu(ris, &msc->ris, msc_list) {
> +		if (!mpam_is_enabled() && !ris->in_reset_state) {
> +			mpam_touch_msc(msc, &mpam_reset_ris, ris);
> +			ris->in_reset_state =3D true;
> +			continue;
> +		}
> +
> +		reset =3D true;
> +		for (partid =3D 0; partid <=3D mpam_partid_max; partid++) {
> +			cfg =3D &ris->vmsc->comp->cfg[partid];
> +			if (cfg->features)
> +				reset =3D false;
> +
> +			mpam_reprogram_ris_partid(ris, partid, cfg);
> +		}
> +		ris->in_reset_state =3D reset;
> +	}
> +	srcu_read_unlock(&mpam_srcu, idx);
> +}
> +
>  static void _enable_percpu_irq(void *_irq)  {
>  	int *irq =3D _irq;
> @@ -1025,7 +1094,7 @@ static int mpam_cpu_online(unsigned int cpu)
>  			_enable_percpu_irq(&msc->reenable_error_ppi);
>=20
>  		if (atomic_fetch_inc(&msc->online_refs) =3D=3D 0)
> -			mpam_reset_msc(msc, true);
> +			mpam_reprogram_msc(msc);
>  	}
>  	srcu_read_unlock(&mpam_srcu, idx);
>=20
> @@ -1806,6 +1875,43 @@ static void mpam_unregister_irqs(void)
>  	cpus_read_unlock();
>  }
>=20
> +static void __destroy_component_cfg(struct mpam_component *comp) {
> +	add_to_garbage(comp->cfg);
> +}
> +
> +static int __allocate_component_cfg(struct mpam_component *comp) {
> +	if (comp->cfg)
> +		return 0;
> +
> +	comp->cfg =3D kcalloc(mpam_partid_max + 1, sizeof(*comp->cfg),
> GFP_KERNEL);
> +	if (!comp->cfg)
> +		return -ENOMEM;
> +	init_garbage(comp->cfg);
> +
> +	return 0;
> +}
> +
> +static int mpam_allocate_config(void)
> +{
> +	int err =3D 0;
> +	struct mpam_class *class;
> +	struct mpam_component *comp;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_for_each_entry(class, &mpam_classes, classes_list) {
> +		list_for_each_entry(comp, &class->components, class_list) {
> +			err =3D __allocate_component_cfg(comp);
> +			if (err)
> +				return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static void mpam_enable_once(void)
>  {
>  	int err;
> @@ -1817,12 +1923,21 @@ static void mpam_enable_once(void)
>  	 */
>  	cpus_read_lock();
>  	mutex_lock(&mpam_list_lock);
> -	mpam_enable_merge_features(&mpam_classes);
> +	do {
> +		mpam_enable_merge_features(&mpam_classes);
>=20
> -	err =3D mpam_register_irqs();
> -	if (err)
> -		pr_warn("Failed to register irqs: %d\n", err);
> +		err =3D mpam_allocate_config();
> +		if (err) {
> +			pr_err("Failed to allocate configuration arrays.\n");
> +			break;
> +		}
>=20
> +		err =3D mpam_register_irqs();
> +		if (err) {
> +			pr_warn("Failed to register irqs: %d\n", err);
> +			break;
> +		}
> +	} while (0);
>  	mutex_unlock(&mpam_list_lock);
>  	cpus_read_unlock();
>=20
> @@ -1861,6 +1976,8 @@ static void mpam_reset_component_locked(struct
> mpam_component *comp)
>  	might_sleep();
>  	lockdep_assert_cpus_held();
>=20
> +	memset(comp->cfg, 0, (mpam_partid_max * sizeof(*comp->cfg)));
> +
>  	idx =3D srcu_read_lock(&mpam_srcu);
>  	list_for_each_entry_rcu(vmsc, &comp->vmsc, comp_list) {
>  		msc =3D vmsc->msc;
> @@ -1963,6 +2080,79 @@ void mpam_enable(struct work_struct *work)
>  		mpam_enable_once();
>  }
>=20
> +struct mpam_write_config_arg {
> +	struct mpam_msc_ris *ris;
> +	struct mpam_component *comp;
> +	u16 partid;
> +};
> +
> +static int __write_config(void *arg)
> +{
> +	struct mpam_write_config_arg *c =3D arg;
> +
> +	mpam_reprogram_ris_partid(c->ris, c->partid,
> +&c->comp->cfg[c->partid]);
> +
> +	return 0;
> +}
> +
> +#define maybe_update_config(cfg, feature, newcfg, member, changes) do { =
\
> +	if (mpam_has_feature(feature, newcfg) &&			\
> +	    (newcfg)->member !=3D (cfg)->member) {			\
> +		(cfg)->member =3D (newcfg)->member;			\
> +		cfg->features |=3D (1 << feature);			\
> +									\
> +		(changes) |=3D (1 << feature);				\
> +	}								\
> +} while (0)
> +
> +static mpam_features_t mpam_update_config(struct mpam_config *cfg,
> +					  const struct mpam_config
> *newcfg) {
> +	mpam_features_t changes =3D 0;
> +
> +	maybe_update_config(cfg, mpam_feat_cpor_part, newcfg, cpbm,
> changes);
> +	maybe_update_config(cfg, mpam_feat_mbw_part, newcfg,
> mbw_pbm, changes);
> +	maybe_update_config(cfg, mpam_feat_mbw_max, newcfg, mbw_max,
> changes);
> +
> +	return changes;
> +}
> +
> +/* TODO: split into write_config/sync_config */
> +/* TODO: add config_dirty bitmap to drive sync_config */ int
> +mpam_apply_config(struct mpam_component *comp, u16 partid,
> +		      struct mpam_config *cfg)
> +{
> +	struct mpam_write_config_arg arg;
> +	struct mpam_msc_ris *ris;
> +	struct mpam_vmsc *vmsc;
> +	struct mpam_msc *msc;
> +	int idx;
> +
> +	lockdep_assert_cpus_held();
> +
> +	/* Don't pass in the current config! */
> +	WARN_ON_ONCE(&comp->cfg[partid] =3D=3D cfg);
> +
> +	if (!mpam_update_config(&comp->cfg[partid], cfg))
> +		return 0;
> +
> +	arg.comp =3D comp;
> +	arg.partid =3D partid;
> +
> +	idx =3D srcu_read_lock(&mpam_srcu);
> +	list_for_each_entry_rcu(vmsc, &comp->vmsc, comp_list) {
> +		msc =3D vmsc->msc;
> +
> +		list_for_each_entry_rcu(ris, &vmsc->ris, vmsc_list) {
> +			arg.ris =3D ris;
> +			mpam_touch_msc(msc, __write_config, &arg);
> +		}
> +	}
> +	srcu_read_unlock(&mpam_srcu, idx);
> +
> +	return 0;
> +}
> +
>  /*
>   * MSC that are hidden under caches are not created as platform devices
>   * as there is no cache driver. Caches are also special-cased in diff --=
git
> a/drivers/platform/arm64/mpam/mpam_internal.h
> b/drivers/platform/arm64/mpam/mpam_internal.h
> index 1a24424b48df..029ec89f56f2 100644
> --- a/drivers/platform/arm64/mpam/mpam_internal.h
> +++ b/drivers/platform/arm64/mpam/mpam_internal.h
> @@ -190,11 +190,7 @@ struct mpam_props {
>  	u16			num_mbwu_mon;
>  };
>=20
> -static inline bool mpam_has_feature(enum mpam_device_features feat,
> -				    struct mpam_props *props)
> -{
> -	return (1 << feat) & props->features;
> -}
> +#define mpam_has_feature(_feat, x)	((1 << (_feat)) & (x)->features)
>=20
>  static inline void mpam_set_feature(enum mpam_device_features feat,
>  				    struct mpam_props *props)
> @@ -225,6 +221,17 @@ struct mpam_class {
>  	struct mpam_garbage	garbage;
>  };
>=20
> +struct mpam_config {
> +	/* Which configuration values are valid. 0 is used for reset */
> +	mpam_features_t		features;
> +
> +	u32	cpbm;
> +	u32	mbw_pbm;
> +	u16	mbw_max;
> +
> +	struct mpam_garbage	garbage;
> +};
> +
>  struct mpam_component {
>  	u32			comp_id;
>=20
> @@ -233,6 +240,12 @@ struct mpam_component {
>=20
>  	cpumask_t		affinity;
>=20
> +	/*
> +	 * Array of configuration values, indexed by partid.
> +	 * Read from cpuhp callbacks, hold the cpuhp lock when writing.
> +	 */
> +	struct mpam_config	*cfg;
> +
>  	/* member of mpam_class:components */
>  	struct list_head	class_list;
>=20
> @@ -297,6 +310,9 @@ extern u8 mpam_pmg_max;  void mpam_enable(struct
> work_struct *work);  void mpam_disable(struct work_struct *work);
>=20
> +int mpam_apply_config(struct mpam_component *comp, u16 partid,
> +		      struct mpam_config *cfg);
> +
>  int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32
> cache_level,
>  				   cpumask_t *affinity);
>=20
> --
> 2.39.5


