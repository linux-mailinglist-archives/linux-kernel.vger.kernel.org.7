Return-Path: <linux-kernel+bounces-734460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6412B0821A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF75416499C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410BE1D130E;
	Thu, 17 Jul 2025 01:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="nFDlsDVb"
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C37C1C84A8
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 01:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752714623; cv=fail; b=QKaOTBVW+p+hUYLWjJykz1mA13SK07ewiZLfGq0KUh6qkjzbhO55CZgl7Ns/gmDXNxeEZBBHOwPNofZPYrJMX7Iv3YezzSv+30kycrEjo7GCtNDa3aXJzvgc0uEzL/KMfkZ5s30gtXSdEu1gRTc++cYB725AQ6oz7/0Cj+iSkD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752714623; c=relaxed/simple;
	bh=8HbPoVAEKg++oNpoqvILYUIKJXijoKycKJLFVDSZZaI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=isH/8D7wHZzKTO5PRGfGdKL7G29jk2wyQuiGbUozbMTN1OymmT0Vp5YZu2OAV9f/ppo0foT3gxl0yzA2Bdt47yZSBMz8Ob4Qh69PztGTvp/JFw32ZDWEGMxyhFM9liAF7PgD1WnuAU7LQmTjLMMJDOPeEv/C/cxcruFV7k4HCyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=nFDlsDVb; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1752714620; x=1784250620;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8HbPoVAEKg++oNpoqvILYUIKJXijoKycKJLFVDSZZaI=;
  b=nFDlsDVbcSfLl3aNOo7iQ5IqxVRhkzWmJey0ySdN1dHV4fpiy0OybW0q
   KFkEzH7isN4cYPdkgzpRJGhmPJWGJjMfnEwml2Eq+DiA6aqT1duXdwnSJ
   L6iE7d/irafztCn8kBFjaop30u0P2kgJda1OIUHtlDIerel0sN7RI7mVC
   fGjvrD0F8Tv8PzvkUwbjtktBhIA+Ag/XFJAF4df0Rt0csvfM/1Zv1WFHj
   jnvQKS2g1zzWumoB9AH4EhH4niirE0ltB20sVefIgVcftHZuBiHiqC/0Z
   AR7SWEVVOCXjG3zpMHtXURUrmh83U/bHEWBW1Q0fhKYKxK1+qGsifxslS
   Q==;
X-CSE-ConnectionGUID: tcW18KeLQHKpo/Va2EcsoA==
X-CSE-MsgGUID: jiTE8CNuSyKEL3S/yO4Uhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="161407189"
X-IronPort-AV: E=Sophos;i="6.16,317,1744038000"; 
   d="scan'208";a="161407189"
Received: from mail-japanwestazon11010053.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([52.101.228.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 10:09:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaG0+zr6lGu2e5+Rj70SprE+00M9OSXxMpySBMjvZ1+Z2jIGiWZWbQwgs6epgwGtWLLk6EbiFOcVBpp1VlmIFk67+GRsWbPWS/jByQvOBAXL5x9x3olrkDIRumFHGCl7Qobaq/IaA0NqETm5BgdrBJs86xkROzeq+j5Zj5diDgYuLgCiE4zF2JVCSuyF1u8gXsBbGSmP1DokmxTGFn4Qpz8n8Y70TIGJkY/eo+dScFJJ/2YsgUzUpzblKVw7XyyXKwUzeDMIkpJkzaUqZdpxqwUeVMRc4CuShMwHvvaBl21KhBh6Pz6YMWA/tTnN9B6qo/WiaSNymEyqDpak8C7BSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOwuCibNEd9AotqJU7UxkSBlhTL81dNOuqZWZx/q53k=;
 b=ASN6bRKAANZOIzoTU5V/RBJWT44oC/OdQR+MTPsZAzs5EZbGHQ3iDIbf2kC2d7gzRJ9DUHS2+Pa8GSDFSTVuaDLmV0lIXkM52kmOUfqBT03sJsRGxILkxCxa7fngkJLfj0ragkETHtwCV/AGH2wfi2OEACwJ4x52lIdR5DGB+650c3pppF8VH4W05OT4hR2IZe+F4eNOcYdQbMfs/B1RfIqRSIRYx9b6MMwGWgdqCYybmCrvQb7TVsWxwvmzLSzPzO42SsgTjmLvk1v8GpcsgppjJPfPVTX5Nrvt1Xb1058hL+LILzftp6cMzblJDFJa/YrXTH3hGbWq1eYvKeeNPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYCPR01MB10228.jpnprd01.prod.outlook.com (2603:1096:400:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 01:08:56 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672%7]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 01:08:56 +0000
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
Thread-Index: AQHb8pL/ydsOasyOj0OV22KVGGpjDbQ1iM0w
Date: Thu, 17 Jul 2025 01:08:56 +0000
Message-ID:
 <OSZPR01MB87989B1F13F79EE70D2D3B238B51A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-26-james.morse@arm.com>
In-Reply-To: <20250711183648.30766-26-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=3251e8fa-cd2b-44c8-bd02-4b46b9c1b197;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-07-17T01:06:07Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYCPR01MB10228:EE_
x-ms-office365-filtering-correlation-id: 70138741-53c4-44ca-3340-08ddc4ce80ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?c0VoSnpXdjRxdHZESjdvSmZHVFVRek80L3d5Q2lmSjJaUkNLVFdya3pm?=
 =?iso-2022-jp?B?cU80b2N0Ni9uRGh2b200N09ZU1ZwSU1TQng5UDN5SjRRNG1VdU5pcE1l?=
 =?iso-2022-jp?B?QkhIRGEwUDNJanhvZjN0YjdNcjRXUkFvTFVNd3YweXJoTTUrQWErZkor?=
 =?iso-2022-jp?B?UU03SElFTG15VTF3b0U1K2IvNHB6aU9pendZbTM3VHd6emR5WkdlTEo5?=
 =?iso-2022-jp?B?cURkc2F3VDl4akY5UTBsZmx2ZDVWcmJYMkU3QkhqK29RcXFIc1NDL2dF?=
 =?iso-2022-jp?B?QU5ydCtvdi95NXZHSjdMMzhRWnFQajVsTFI5Y2swZ24vWHV3WFo1bi9X?=
 =?iso-2022-jp?B?VDRmRFF3emYyRTIzYUdXeVRuL2xtSUN3SS9vRkMrcGhjUzI2bEdleXU5?=
 =?iso-2022-jp?B?cCtZSHdLSWNjSzU3RjB0UVVyNUh6S0JST3dQZ0dkcG82d2tWeUpJT1hq?=
 =?iso-2022-jp?B?c04zSEh6eEh5RlRqVFVtYmp2emJFbjVqUTZXaXlGdkVmSmZmaFR5VEpn?=
 =?iso-2022-jp?B?YUw4b09xZVB4ZVg5cTMvanZJY3h4UjVKTlMrYTFNNExFUjNIdmloR2FJ?=
 =?iso-2022-jp?B?SENGZW9JcTN2aDUrL1pvMmI2L0wyNkhReTM3SENzTHU0cHIxQkh6T0p3?=
 =?iso-2022-jp?B?N1V4VFV3MVhGMEVnKzN3Y0d1dG9CNkw4VmJ4OUJuLzhQRHdHR0VyTzg2?=
 =?iso-2022-jp?B?NXJTem5RaFkrYVp6NEY4WlV4UUhXeVlEZTJUVDdRYW55TzRlVFdDNldU?=
 =?iso-2022-jp?B?NGlEVEgvb1VkT3JWbWIwR1ZNSVdkQVZ3WDZtenEzZDhMcFErVXNRK2xR?=
 =?iso-2022-jp?B?WGZ2b2JwWEhncW1jd2JkeHBIV0tJUHg5Z2o0S1l1VCsrNnZOVDFFRlg5?=
 =?iso-2022-jp?B?UG1DMEFvUE15ZFlqTnhXaFlnSDVNeGhMSlJQSGpWRUYyNU9WOVV5Rlk4?=
 =?iso-2022-jp?B?YWFJdWVMNjhoalFFRHJaQ1V6T2d2dmRFSDVXSGJ6blArUk8vRWZMak84?=
 =?iso-2022-jp?B?WDFPQWxkMFZiR2IxanlMT0pNWGxwQXFIcVlYSWg3NmNKRCtDRTR3dm54?=
 =?iso-2022-jp?B?TjhlSzJ0WVhUV2lzNlhoOWZPODhhNk5jdU9tT1d0a0tRQU5MRlV5eVVo?=
 =?iso-2022-jp?B?Zk1DRmlTY1JNQjlEaXBmQUFuUzNXZnhEMUVGZUhoY3AzdUt0a1lPNU1m?=
 =?iso-2022-jp?B?eTBuajd2ejMxZXpCc3dtVU9nUFo2cGUrTTlYcU4yaGY0WUhpZU5ZM0hL?=
 =?iso-2022-jp?B?MW45VEovanpqSVBXb2x2dFhNYVl4dWVmS2hhK0lXWkpJV2Q2YWNJeVd0?=
 =?iso-2022-jp?B?M29RcHpOWSswNlExOXNWdGdtRlMxd1YyNnYwYWJNTDJzd3NONWdUdHBJ?=
 =?iso-2022-jp?B?OFp5WUVkaFJrYWE2RW9JTUVEV01IamozbHpzMkpweHBOd3NnSjV2RTdO?=
 =?iso-2022-jp?B?STg1OFFZQjA0OGZSU1N1Ni94Mi9uY2tRYXI3czlpRzhKZmhJRjVlVmcv?=
 =?iso-2022-jp?B?OFZIRWE4T0NISlFRK25VVnJHM0J3Mk5OQnZWZnYzclZURVFKNHNTQzBq?=
 =?iso-2022-jp?B?WGRQKzk5dXRDdlZqTWVDR3UzSjRsMlQySTRCdWNTNGhFd0dXNVYvRk11?=
 =?iso-2022-jp?B?WE1jeWx6M01FcXNDRUw5cjd0cG0xallwQ0ZkTkF0VVNzUzFiL29vRGhF?=
 =?iso-2022-jp?B?d29aY2Y4Y0IycGI1QlV5cXBYaUE4VUlKcWdscGtycDZoRHNTRjZqVWNC?=
 =?iso-2022-jp?B?cVkyYVA2MFRrQzdIZCtabnBmTFVPendEVU83UmZOOFR5ZVhBQ3REcFdW?=
 =?iso-2022-jp?B?emZCdHhZa0NvQmF6UE15bnUxZVZFQzFiYWp4UnEzQkNrblpPU2UzWEFG?=
 =?iso-2022-jp?B?dEZZeloycXduU0orTFZWUHcrQ1JDY0FFcVRvRzBNKzA1RktTS2w5c3lj?=
 =?iso-2022-jp?B?Wk9KSHRGcU15WmxkVDJhWnNTcFlVZUlrQitrUXRRRDVoNW1GblgyV3Q4?=
 =?iso-2022-jp?B?Z1dvVEZhVFN3L2UvK25wU3V3aXJFZnllUnVNQUlNYjMxcUd5TlhiWDV6?=
 =?iso-2022-jp?B?SjJZd0Q0alJBbVM2b2ZVTkFsTDRaWlo5ZW1pdHhSR3ZSbU9oQk5TTFc5?=
 =?iso-2022-jp?B?enM1MnlDMktLMlhtSWlnKzd1eDNISVJESjRsY3Q4OTVhckJzeVJQMlZS?=
 =?iso-2022-jp?B?MWxlMEhOcklSWXh3R0NteGZrSVQ2Y3ps?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?R0hIT3prSmp0RE0yUHhsaWtRZW1YS0tKbjNwbmdYVlN3RTF5VUk2N0hZ?=
 =?iso-2022-jp?B?bnFvVXJMRlpUZDk3OElVNkZOaTlncXVsYTNzTHZxL2JiSlQ2alhTT1N4?=
 =?iso-2022-jp?B?bmFwaHJET2xRZ2VPZk0zcnJtU2NoK0dWZlc2ZHVtblkxMmdtR1FhU1d3?=
 =?iso-2022-jp?B?WnVvcWFNR3RjN0JtZDFBcG9LeFA4SDk5bVZBcnYvbHJVNUs1eFRyTGx3?=
 =?iso-2022-jp?B?bTFvYi9BRjRrZzdsUVVURHF1bHluQ3ZOWUpvWHRyczZ1cjdxOFFWc2Jm?=
 =?iso-2022-jp?B?ejFTMVFBL1VQQ1NXeFYyNGVaNlF6SHhjTTNEN2R6bDlCTlpOSXJOdis1?=
 =?iso-2022-jp?B?ZG1Rdjgvdi85RzNOem1jbUdMOFRWYUtCL1duMktuYnc2QzV2VG02WGhU?=
 =?iso-2022-jp?B?aUxQL2pPQ3drQWNxajNTRmkyOGRDSUU0WUZ1Tnp6NEorYmVoLzlDSnRu?=
 =?iso-2022-jp?B?eThJaVhPZWlkVFdYUlUrRy9uWWNTZUE0eEV5MGsySW5xNkNnN1FBWUc2?=
 =?iso-2022-jp?B?UnVsZkpUNzYwTkl4UTM3ZmxoQmpOWnNCUVpPK2RNOTl4WUJrRHMycVc4?=
 =?iso-2022-jp?B?Q1RnMm1adDM4TzFoZ05IQlRqL1ozR3ZUNlhIVldTb0RQSTh4Nmk0RE8w?=
 =?iso-2022-jp?B?VVJsdlJKMHpkQlF5Z2ZrU2JjQ1d1QUNwVGVUREJ4MWZsZ0N2SFFvOHpa?=
 =?iso-2022-jp?B?WGFkK1IzTjcyQ1hRdER3R09HNTJpaWs1cVp5bmhMWEJrZi9RbzJBWWdv?=
 =?iso-2022-jp?B?M2d3N2tra2YxZDBmWTdlQ2dqaE42MytWZnowY0FGWmtvdXh1bFlhY05m?=
 =?iso-2022-jp?B?WkozWGRFUGhsYzhId0FJOGRlbmNFZ21DM2g0SGQzTUFtNEtQZzhHMlNK?=
 =?iso-2022-jp?B?aGF4V3lraWd4aURETTNhTDJVRjZIdWtjcUtDenRFWVU1VmNvNjJ3VmVq?=
 =?iso-2022-jp?B?dVgwZWpySlNKeHQzVGRKYjJ5RDk1SE5INFhzVENUTVp5ZDVkUkNoTkpZ?=
 =?iso-2022-jp?B?UDF3RUgwQ3ZMNTZLb3hvYjZJV2h6ZlI3RkxUeXlQNG5ZMGl0cjZ0RXNK?=
 =?iso-2022-jp?B?T2NBMzQwcmNaNWdDTTZCSVFZZjV0YWx4MnhDNnYxb2RzQUVNaWdvQVNJ?=
 =?iso-2022-jp?B?SXdHNVF5STFXVHlQZGFBSGFWRndmNGFodjZGZU1XTE1BN2ZrY0NOTjVq?=
 =?iso-2022-jp?B?NWwvcEFORmphRnR5eDcyQjI5cTBNWHJCQzZXczJVNVkzR1pFZjQ3Rk55?=
 =?iso-2022-jp?B?Mldvdkhjdlp6Wm9TeHhzK0RYcU5LUUpuL2oxTlVKMlNNdFBMdVgzWTlN?=
 =?iso-2022-jp?B?YmRhQVdRQmd0Qy9PQ3k4Ym5zT1dSVGlINiszQjZ3Y3ZrK3FrQS9pRDZM?=
 =?iso-2022-jp?B?NU1mS1ZnQU54OEVtKzcwTEZBYUdGaVJqRW0wVGFTSHpnK1BpZ0JQcktw?=
 =?iso-2022-jp?B?OU5wSURlYndMcyt4YVZySk5vSzA0RkJwOExNaTVEcTIzNzM4QXBId05n?=
 =?iso-2022-jp?B?aWxlc0FRbHBwa0hnYU96TnhLYUpDQkpBcXhlVFM0RWxVcTFMWGxKTWkz?=
 =?iso-2022-jp?B?L2hCM1RFNTRKdnhnMSszY1lHZ2JMalAxbFpXSHhmS09pZlB1ZnhHUzJP?=
 =?iso-2022-jp?B?eW5wOS9YTFNpOVdPejZ1bzVjZ2srdUdka3NWWGswWWVFQW5hWk1xTmt4?=
 =?iso-2022-jp?B?b0U1ZEZ2Yy9heHpBcWJnYWtWS2xvZG4vTVBaT1VmWnF2RUVrZmlhV1Vi?=
 =?iso-2022-jp?B?dDJoTGgydWx2Y2lPRE5tZWFsMVQ2UmFTOGJOcm9YZGU0ZHhFTUFJVGM3?=
 =?iso-2022-jp?B?emZFYVN0bkZjaWhkcDhzNndHQjNCdnRDS3hiQlVGdWNmOFV2cFVCcjVE?=
 =?iso-2022-jp?B?MExncTl5Z0FiQzJsNllsQW5iWEt0QUQyM0Vpcm95ZGNJb0V2bnYyV1c2?=
 =?iso-2022-jp?B?S0ZNMTV6VGtKSW1WUmlZbmpBWDZ0RGZmY1EwSnYwNDdHcGFqYjg5dVdE?=
 =?iso-2022-jp?B?VVBPcTlHNDlsai95YjFzdWVMY3BRU3JmaTlWOFZKSnI3NTVtNXBPZzhw?=
 =?iso-2022-jp?B?WGNBaG5COG8wbEZoWXM1V2drcFRydlhyakxDWkkxYloxYVVYRVQzVmlU?=
 =?iso-2022-jp?B?bllCenlFdHMyUjhqVDgxaFdTMEd5YUdRaVFiNCtYVWhXNDh2c2FDZmRR?=
 =?iso-2022-jp?B?ejJPb2FoWmZqMi9mSWtpYzVwN09tcFpwL3Z3N0pWTzYrS1duamFyL3Rm?=
 =?iso-2022-jp?B?TDViTERiL1B2WG5NZXNzNGlERTE3dEFlM0tkcHZCb3pCbUxPcXVzM3J5?=
 =?iso-2022-jp?B?VXRPeUkyWFovQU9VNFljTW9pSGVnK1BGYXc9PQ==?=
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
	PrJ+CuIxcDtqQxQFGKaG+ruSOz3WrWTRP1PGSQrc9RPTht2ZS9Tm6WKT85uIEOFSXcIARoRHGIyTEBekaVBvCOq+WGEtVUzkl5DMj+D0fvTy0SEiLTSpRnd6CsobOXHEeuFZf2s5+9cSHu6Wi3XsfekyeVhDvUZLW5nIfZiR3sSkOsAQZMJClbIm8P/Q2lykHqo9YmAnglWUE9fsLQIn31rrcr73hEYsHv4jOaGWhvAiDW2lSS3hrT4SuCS+zipZPZZu58y5ri0XHA6LMX5WbEl7/4BVAsFtvmVr2e6Jr+FGKYf1lVTFeeJOK6EwlLjfo2jfKVytHEQp7aNE6hii2CELn4yyhkHqo0Di35poGheGs3jFPCn+kF+zzz4VRb8K/wbJplMSgIbnw3zEatSPAh7qlxI8tfwhxh/VwBR0P+mUTPdIPmsriBoW5U1SwlqCQbcqUIKrrIifcR/fF5b4lNfFBQuxh+A+t6B+GkRaVARK036oC9+OzCivp749SX0l4vYrGGnCkwl0icGcaNVxOGiYzOGd0d/HdhYI4wcPUFxU1jPoX6yepELgaPnCAzRgafJz0q7XK5tV8Y+qQxk4L2QayQjPxyMY7b8takffsZxu52Xz4roSzKBCUMcIguyB
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70138741-53c4-44ca-3340-08ddc4ce80ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 01:08:56.1642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dHwuBu036p/u98tmu1T8LVR3UwX0yJIMBibuw9FpM/BbDpEK21AcgMDIzNOO7yYs3cg/br4LAOW3fbhgJ0YWvZvDaWU1JADF41Hlj5qxhCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10228

Hello James,

>=20
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

In general, I think there is no problem.=20
However, the initial value of MPAMF_ESR_ERRCODE may not be 0 on some chips.=
=20
It is better to initialize when loading the MPAM driver.

Best regards,
Shaopeng TAN

> +	/* Clear level triggered irq */
> +	mpam_msc_zero_esr(msc);
> +
> +	partid =3D FIELD_GET(MPAMF_ESR_PARTID_OR_MON, reg);
> +	pmg =3D FIELD_GET(MPAMF_ESR_PMG, reg);
> +	ris =3D FIELD_GET(MPAMF_ESR_PMG, reg);
> +
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


