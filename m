Return-Path: <linux-kernel+bounces-734454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2ABB08204
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2923B9993
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E886725771;
	Thu, 17 Jul 2025 01:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="aC3PR2s6"
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1595B17A5BE
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 01:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752714361; cv=fail; b=QCy7OfN/RNxxbWV5e2DaQFn6l6/WmtLQYw2f6CPPNUURw+Rnp6xOy+G8+/OUWMmVs264ePLArLFDh7ds650mfrAJcLSCS9zmLdQ+5VN2emZc4ZdHmVilxOzQtY9ibSujBfrgISF05SY4JTCA1t2VLoxTF0UWOQSsKUaFe7UKYYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752714361; c=relaxed/simple;
	bh=r++flkeuoHWVwzXtI3reb1uw6SivqZ7eIDkOJX1Gcbo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Skl9mI1hYYjZHZ02z82gjiW9bsWU9LhTnvVYBM3TqRBDRZhI05lwc9bFszkdIyxSTSfCAPlB2+uwPGRHUsI6n2XA60E6WT4MAyrhykY8apVl+6ZBXMX9eYPzUyuYqmRfc+beddbXgk9uRUvdQZ7LJ9Nip1lyeI/WDoxBxFv5eZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=aC3PR2s6; arc=fail smtp.client-ip=68.232.156.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1752714360; x=1784250360;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r++flkeuoHWVwzXtI3reb1uw6SivqZ7eIDkOJX1Gcbo=;
  b=aC3PR2s6CSzNuPcz0FYV4Tzi8wJmWXn2Qj8cWyk9wKmL5d0oH/lubPWQ
   ww9Bqnhbmeuom2wdfg30Rw+q85twKriamjZNmGDfeD5bGYgcx8QXb728b
   20eMemotXjHU3nENyWUHyf+uCSI2Kdp9BZ5EKmzv5VQMeD8qAaP8mrWnv
   7vLjjz7zPBFDIoiLKO/Jd5ifNCMSOKoDLcUE2hb4TtwgJLabsjw1JPD45
   3/ox+lZ5RHdIYNekfbW0NcAJNgd5cxOChUS/ezHz9E9PYRFOZvaHZms5k
   DPZnrB6fsnZoJjQ6syZ+8cuIQeegEuNetZgNAjKzRf3OWaMT25nk+4Jdj
   Q==;
X-CSE-ConnectionGUID: yZveoR5ATy+D3wE0xoZLSw==
X-CSE-MsgGUID: 9MhKO4+bSvSpMWhU5Ca++Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="162355842"
X-IronPort-AV: E=Sophos;i="6.16,317,1744038000"; 
   d="scan'208";a="162355842"
Received: from mail-japaneastazon11011038.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([52.101.125.38])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 10:04:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsniNUGvCRt3OYwJviLj9QIWvBTbPYTtaQ4Q5y0Yulo9QvXCDBGVHrZ7v0f+LOQdcXc6pfVkuYQJ4Hd7/wAkXnz/RNbCSYk9ak9l6PbV6sbocrhgqjzPeoNLr5QqA81UBGiw3gMhTSfNkZbu73HP2qHj8N4hYVbzw9GPgE5adAKtGcRtRICG2N8Ny/kPFmsaiU9jRKioljAIEKvRhT1DTPToaqBCCzvorc/50HEJpkSCzF0qOS80bMDaQ8zjw20qlYfSJ5FmlL4JYFNpFDUkBCzaaOx2W81sJHqPXgyXsiiJjH4LD7APtvmApx7g99vN2FT7CpogdSjkNq8xOssGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyGP509grphr6L/Mh9FEl5l3BzlhmlwMcGDwHIm3UOE=;
 b=chcaw/d5t6rWGOUbl42oPHFRref4MJ157UOjCdD7iV8ayrCsGcOUbsFBo6Rl4tNgX41vd/y3Dvle58XhbUORiLQ7/EIdBNAfWaGu12LqSdGF/+o5Bmqo8jLkW2zVAjgOcu9QIUkfdVniisdPr2EGA+SHvISuyZKAhnjTUfnHmaFQB21n455cXpt0FbggzTnvwxxAB55ONuzuyzhEKQ+d5X7RIxgL9QH2nJjpCbbz4jmNkuANR1DR+70G2j4GzYHojHyzberNapTabIompJSgwVOav2I8GWZ+PjAORlmxZwjnzqcVFDgMKx3YI/1Pyww/gm/Chc28ySWzENFdUMcRsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYWPR01MB9837.jpnprd01.prod.outlook.com (2603:1096:400:233::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 01:04:39 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672%7]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 01:04:39 +0000
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
Subject: RE: [RFC PATCH 16/36] arm_mpam: Add MPAM MSC register layout
 definitions
Thread-Topic: [RFC PATCH 16/36] arm_mpam: Add MPAM MSC register layout
 definitions
Thread-Index: AQHb8pLvNDZkiG3tI0+6SdsU1pKeOLQ1hJwQ
Date: Thu, 17 Jul 2025 01:04:39 +0000
Message-ID:
 <OSZPR01MB87980409C12B21D619324C5E8B51A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-17-james.morse@arm.com>
In-Reply-To: <20250711183648.30766-17-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=b3c1c7f4-7c5b-4569-91ce-ad81716e1b71;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-07-17T00:51:06Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYWPR01MB9837:EE_
x-ms-office365-filtering-correlation-id: 91e2720b-c235-481c-d621-08ddc4cde7c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?ZzhCaTFwcUJPdVdVUHl6dGZKOXg2a0tpSjMrd2xQb2M0Zk56MDAvTDFK?=
 =?iso-2022-jp?B?OTVMbEVGRTZCWjhRUlZ1Q0haekZnbjdQNlVxcURvMUdEU29iYmRvWHRx?=
 =?iso-2022-jp?B?bjlPdWtZb3M3S0hXK2c2ME9kZjFYTWZRY2xOVUVkNWlJOCtJZ251ZmFz?=
 =?iso-2022-jp?B?bG1McklvS3BSemdDcXBXVlpHMzF5S2o3RG5NWnphM01tc0RvTGRMZUZw?=
 =?iso-2022-jp?B?T1o0aHp0c2d4eVBPM1J0a25ld3dQV25IU0ZiRVhhTWRTeWE3NTRYNDNP?=
 =?iso-2022-jp?B?emVRdmdjMytnRks5QllVRjZlMXhSd1pCS05nL1JrRHhlZzR5YXk0SWNY?=
 =?iso-2022-jp?B?T29ONS9Qd3FRVDc2TXpQZjlDR1ZjcWsvQW9ka1k4djdYSkp0K25DMDZN?=
 =?iso-2022-jp?B?b2RrNStBNjVBWUxQTnFMVXF6YkJoSExseDRaY1hoUm5WWUNITXp1NmJC?=
 =?iso-2022-jp?B?ME13aWl6TTJJaUMwdGZoTTA3T0hUWS9HUExKWWJNNXlGR1VkeGp0MWFL?=
 =?iso-2022-jp?B?a1VaY0VxSzFiREhMUnN2SkhiUlVkK3JXaG5tVjB0V1JsWmNsWGlqZ3Q2?=
 =?iso-2022-jp?B?a1NWdkhhSUFReVpINXNLZndvd0pJVkNacDlCa1JxUFdGUFpvMVA3MDEr?=
 =?iso-2022-jp?B?eUZxZWVDTkV3d21VS21RamkrSFNtSW1xYTMyNkJ4WTNUUmRjcHV5c2FE?=
 =?iso-2022-jp?B?OEpqVmZWdEJqMzUzUXFsNWU0anc3dWNMdS83QThIWnhiUVUxbjF2YlpV?=
 =?iso-2022-jp?B?SXBjRUdhMEVnbDYxM2tNdmhYZm83NCtYMUdDV0duQmEvSTAwd3J1RTky?=
 =?iso-2022-jp?B?d0FNTlphckpNMWpLY3BiUHNqMERnUXYzVVZQV0krbE42aEVKZWpwbEVP?=
 =?iso-2022-jp?B?M2JMT25hQzNYSDZBV24rbEw0Yks2R0VCWVFrWjgreTJlUkp5dUc4aDFT?=
 =?iso-2022-jp?B?LzhDYlhXYXRjM2VkbkZGeVpvNFgvMHNpeUlsNERPbXdNQ3FybFVFNTNa?=
 =?iso-2022-jp?B?Qi9LNXFCSUJ2dW1pbWZRQkxFMlgzOUU3enFRa0ZEeWdtckFGWEtrVDlB?=
 =?iso-2022-jp?B?bWRhN1JBYWw2OFBNSlh5dFdWdHp3N3FtQm9BOVo5YzhLeWI2TFQ0dFlp?=
 =?iso-2022-jp?B?aEtidHlkdk12YjBZa1U3SWZJWEJDUWd5YUc2VHFGVlN6bFI5cWE1ZmZu?=
 =?iso-2022-jp?B?d2hXRDhtd0VUSC9BMnNlank1dklYdDFHTUEwSUNoY0R1NGtnMlFEbHZR?=
 =?iso-2022-jp?B?N3lXLzU5MTY2NGcwb0hNVDZiMG14aWtTTVlNZnR1Y2V3TnN0WFZiT21S?=
 =?iso-2022-jp?B?NlBka01hZE50cDlLS29sbUpUY05NZjgzUWlYUzlRWkt6MFJFS0oyb21V?=
 =?iso-2022-jp?B?WC9BbCt1L2xaZENjZG5lbmZQVWRiYWNtdDNZVnZkaVVFc2RmMlhRMSs0?=
 =?iso-2022-jp?B?cUNLWFYwNVNHZWsydi9XN3creU1BWnh6UDVMUGNQdy9DcmZXSmhmNFhH?=
 =?iso-2022-jp?B?c2ZoSXU2ZDVOUXFFdzRXKzc1ZFZKZjFpaU9yNEgzR04xNDVyUjRPZ2Jy?=
 =?iso-2022-jp?B?M3FKU1lYSlF5M2ZpbEJBRzRaUDBFOTBoY3dBKzZBMFhGK0FvdzNXUStv?=
 =?iso-2022-jp?B?QlpQb0N5NnI0bzhkNVhuL09sNkZwbG91ZXRTNzJYZXRzVUtVZUJhZXlv?=
 =?iso-2022-jp?B?d0luVHRiZk1IbC9RS0cxUnd2K2xoejYyL3N1ajgwQ2NnRmp6M0dmT3Z3?=
 =?iso-2022-jp?B?anhFc0czR3hiclhCWTRHK3kybTJRVVJkQy9VMHlVOXBPZDBIR2ovRWN0?=
 =?iso-2022-jp?B?dzhFZWdZa2duWCthSEhGdGpsazBBMEtTVlczQU9tVUp4YTcrR3BxTWFz?=
 =?iso-2022-jp?B?MTFGbTdnbWdDZGVFVUNQbjVFWmVtWFVhMXJEVm4zQVp2Y1lScmg4QmNT?=
 =?iso-2022-jp?B?bnJtNEFmM0xSMDFXd3RBcXluSmdEamRuY3BoaElpUjRFOFBTV2pwYnRo?=
 =?iso-2022-jp?B?MHU0Y0NkMnEvZE90aXF5S09WUSsvejZxWnJPRFB3ZjZ1aGlSYXBEWGZW?=
 =?iso-2022-jp?B?V1pNU24vYXh2eWJDNUpTR25TaHBwYXdtTmRWcTZGSVo5ek9DOExBM1Bt?=
 =?iso-2022-jp?B?ZlNPaGtDeE9OdGhHa29PUTlCamk5OHJkbW5PNjBFanVya0hLTGlwcUc2?=
 =?iso-2022-jp?B?aGl6ZEdsSnVkL2tRMUtVbmlobkZtMnVh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?SVR1bnBaT2RheTZjMXNTaHF3SkhIQUlaeXp3VVVHR0xWbkJNUENTcnYx?=
 =?iso-2022-jp?B?NUNrSXUwMEkva2VSc29JTG1IVXF5OTdoVlF2NjgvQk1ScHJwQnpDdWRi?=
 =?iso-2022-jp?B?elRTRDdJbUk0c1RCZzVBSG9Fd2psY0JBTXN5YytOT0p0dWFCQWhORGQz?=
 =?iso-2022-jp?B?L3ZyWFJmMUJqa3NxVWNoT2hFb3EzWW1MUEE3MitTMUhuVXhjMU5FWSs2?=
 =?iso-2022-jp?B?ZnI4S2FxK1J6L3BMeW9LUGRRMnZValZ4R1FjaS9iZWNRUVZqdHlwbVkz?=
 =?iso-2022-jp?B?V1FCaGVCQ1FoZnNYb25uaFo5eFBhRVBjWDlNQjVPbXdmeUVaM2t2Ny9G?=
 =?iso-2022-jp?B?TllsbENvYWVMZVQxVE9wM3B0cVUyckltYXVVQ1VQcldRa2FpZlZ2TzJW?=
 =?iso-2022-jp?B?NWxyc1I5WUJFUXFXR0RhbGNOMFJKRmM4QXV3Q1lpYUpDMDhraHdqTWZs?=
 =?iso-2022-jp?B?clZuV2JvYlRjTElYcFVvYmdZOEsveWoyQTJZYkFqZkNJMnRLSHZySGVI?=
 =?iso-2022-jp?B?VEQ0NXEyVk8vc0VyeEIrM1VBeTB3bllRNlVNODdGWG1pVEJBQXdzcXRL?=
 =?iso-2022-jp?B?OTVhNXVqUUtRNlVObjlpOFNuR3RXWWt4YmNYUnRzbU9qbXBQUmd1RkNW?=
 =?iso-2022-jp?B?em5oY3dqd0prYTF0aG8xNVh2U3dzT25Jc2kwMUhKMGllTW4wOEFtOFNl?=
 =?iso-2022-jp?B?SXYwQjdIT0tJN1NrMWlGV0FSMm1mMjJ1NFVBMUtGUlM0dDRUdS8vRWt0?=
 =?iso-2022-jp?B?eE9wNnpGaEh0WHVIOEFKK2hhdU91eklXWDR3eTltZzYrbnNXWE42Q2NX?=
 =?iso-2022-jp?B?VlpLTGJnbXRMUmEvd21OemRXSTl1S2x5UUV4bVppU05sK0xQbnRLUnhU?=
 =?iso-2022-jp?B?bkJyZUxYelRRMnpHdUpGZnNiQTNsdHRWVUNHSnhVRS9SMDQ5ZVlWcmhq?=
 =?iso-2022-jp?B?VWlsZkszTlhtc1BWMFRlYXludnFKRjdQcERCQytuZFRYZlJvbGtIWG5I?=
 =?iso-2022-jp?B?cjRZVk5NTFFMQzBtTElvR1pSaldGNFFobDdDMnlhUEdjU0IrTjZYSjhl?=
 =?iso-2022-jp?B?NmZwZklSSzBOYU16THdTZFh3NW9ZNWNXcFNGU21RNmhlZkk1VzBKZTFF?=
 =?iso-2022-jp?B?enhIUlUwUVZzOWZsK3FqS2xiRlJZMGZJYXd2WkZpWWlNajlkSjBCWlph?=
 =?iso-2022-jp?B?T3dSUGQxVjluOVZhQ09hb3c0SHJ5Nms5Zld2U3RZQVR5WDRTSEJyKzZ0?=
 =?iso-2022-jp?B?OUtBNC80djhpcEZycWduemZTMW5XaHFYNzdtSmt1NUFnTkE0am1jSVdR?=
 =?iso-2022-jp?B?SDhObzc1c2tlRy9EM00xaGIrTGFoMnFGWHNWaVpsL25wMHN4SlpQQ1M4?=
 =?iso-2022-jp?B?L3YzVUZuSEZZSThqWWdMKzNRS1dndSthR1pCQkgyODNhMmk1WlpBWnFV?=
 =?iso-2022-jp?B?TXpWdFh6OHQwdWpmQUN2MW5VS3d2ZDJDZmFIV21ua255dDdtaWpkUG5X?=
 =?iso-2022-jp?B?eTJRMWRpUXBFS0VMZWpmN3hyQUsvajU1L3JYMlcwVHpSMlpNVGZGV0ND?=
 =?iso-2022-jp?B?TkhOMXV5YjBZZ2JyTk42T1p6aUZhb3VnRGE1S1I1UTIyWHdrWEpJcm8z?=
 =?iso-2022-jp?B?K2paUFZadmZXV3g5TUxOV3V4MG12dUFDVTdmREFFME5iR1NtNGhOQlhO?=
 =?iso-2022-jp?B?S0MweGNlSmVJc3dPMnYxeU9zOExoOVVrZW91Mk9SU1F2bWZCd0NGMklR?=
 =?iso-2022-jp?B?NVNhMVRsaGNpVHYwTE5jT1dZUkFRNzRBelVrSXYwRlZCVE1LcnV0TytH?=
 =?iso-2022-jp?B?YSs4NzhpMFU2a1FKUWY2cVNKUWxVOWZYVDhEQ0pzcGdBUkg5UTBFT2dl?=
 =?iso-2022-jp?B?OVQ5a1poa3YyR0k4Ukx2T21rbFFmZXdFZEU2d2JQSlNOMmFFRmdoeUF2?=
 =?iso-2022-jp?B?MmlvV0JLQ25KWm1DZ1lwYXdOTm8xL3BHMTZGa1o1VnZ0enNSdjFSYXJv?=
 =?iso-2022-jp?B?OFJBWWpYT2V0K01xUjdmK2huMUJRcTlxbkhTL01ZeDlSWDg3OHFLM1RZ?=
 =?iso-2022-jp?B?bkJ3UmlTYVdIdnMyb0hHV3dxTUtZV0xjN0Z6aXMvMG50WGMvM2FKUnBi?=
 =?iso-2022-jp?B?TWJNei9SK28zS3d4VFl3cE8zT1MrMGJVbUZZUWgwaXJ0Y1d3RHhKN2oy?=
 =?iso-2022-jp?B?QkZKNnp0RTRpRkdtREZFWTM1OGxPWHJoeWdCOEk5VUpKbWM3a3lTdzdJ?=
 =?iso-2022-jp?B?d3FiaVNjZERndmZJY0QxK3FKYXkrWW5ReEhGMGoreE5yYXdKVC8zQW1B?=
 =?iso-2022-jp?B?Mmp4QUhmdzAxTW9GNWdFK2lRaEEvVUhtdGc9PQ==?=
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
	EZNxnrUp2oqd3B5lMc35BHGQEz2pAGH7ISAHR5k7w9Gk9+qinw4k+rj5uBdiarGjglDNc43ly4NEAvmvJT5/12Zw6d4WPWbSdD0HM3CSIB8XjHON5Dkas+3kOsg5D8iJtOyPSO3i7OMII3T3xrNhlnsaZ3kvXudY+LUr85DVi8/B2NIm9Juzud0REklwnpwJ529h8E9h+TL9zfDNVyRtoBD+1L8QDAqpbx8M7DLeMYs0ZFpsJ1/CymV6ApqobqhTmJrjeUKZSjSQloRjI6byM7BVY+Rv5MIwA3vVxbRdZ+5nPL6A8Q33BITB6pG7HDslrVbyGpf1TqxrTotZddQlC3kawEvzXVpa/uWjkE3eMi6i2VYyZ8zg+aSe/1dklntw1I8M/Q3iaGYIK9AdyECEAKHMMkoZXSk87KyhlB5Cve7vI9QzmEqAO1mE/decdaySZdRXeoEzU3I2TuuCKBt3NLMPNxM/bydzpWkXR1FnO8QsTWp9GOsoOLy/Pl7LFFhd9+uNxusOBi3WvUbS8zDE3+W3M60J1SbcxB2G6ykG0G2CIgAMwRow1KdgnBTXpuzO3+wsUftRQTsrX/wP90Sfkocu/kxd81irXkNTtALxHtI0lEWtAvX4MOYSgYGbc3/X
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e2720b-c235-481c-d621-08ddc4cde7c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 01:04:39.1530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GZZA4X7Rec68IdD4TFKvlvbvyYOtdAuq5CqpPNIK4Zj5mssDybrqMKD6hjyuSbHeXv/v7va2p02U2E+e1dibm5WHS7yVV7/gWjC8lLhYwYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9837

Hello James,

> Memory Partitioning and Monitoring (MPAM) has memory mapped devices
> (MSCs) with an identity/configuration page.
>=20
> Add the definitions for these registers as offset within the page(s).
>=20
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/platform/arm64/mpam/mpam_internal.h | 268
> ++++++++++++++++++++
>  1 file changed, 268 insertions(+)
>=20
> diff --git a/drivers/platform/arm64/mpam/mpam_internal.h
> b/drivers/platform/arm64/mpam/mpam_internal.h
> index d49bb884b433..9110c171d9d2 100644
> --- a/drivers/platform/arm64/mpam/mpam_internal.h
> +++ b/drivers/platform/arm64/mpam/mpam_internal.h
> @@ -150,4 +150,272 @@ extern struct list_head mpam_classes;  int
> mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32
> cache_level,
>  				   cpumask_t *affinity);
>=20
> +/*
> + * MPAM MSCs have the following register layout. See:
> + * Arm Architecture Reference Manual Supplement - Memory System
> +Resource
> + * Partitioning and Monitoring (MPAM), for Armv8-A. DDI 0598A.a  */
> +#define MPAM_ARCHITECTURE_V1    0x10
> +
> +/* Memory mapped control pages: */
> +/* ID Register offsets in the memory mapped page */
> +#define MPAMF_IDR               0x0000  /* features id register */
> +#define MPAMF_MSMON_IDR         0x0080  /* performance monitoring
> features */
> +#define MPAMF_IMPL_IDR          0x0028  /* imp-def partitioning */
> +#define MPAMF_CPOR_IDR          0x0030  /* cache-portion partitioning
> */
> +#define MPAMF_CCAP_IDR          0x0038  /* cache-capacity
> partitioning */
> +#define MPAMF_MBW_IDR           0x0040  /* mem-bw partitioning */
> +#define MPAMF_PRI_IDR           0x0048  /* priority partitioning */
> +#define MPAMF_CSUMON_IDR        0x0088  /* cache-usage monitor */
> +#define MPAMF_MBWUMON_IDR       0x0090  /* mem-bw usage
> monitor */
> +#define MPAMF_PARTID_NRW_IDR    0x0050  /* partid-narrowing */
> +#define MPAMF_IIDR              0x0018  /* implementer id register */
> +#define MPAMF_AIDR              0x0020  /* architectural id register */
> +
> +/* Configuration and Status Register offsets in the memory mapped page *=
/
> +#define MPAMCFG_PART_SEL        0x0100  /* partid to configure: */
> +#define MPAMCFG_CPBM            0x1000  /* cache-portion config */
> +#define MPAMCFG_CMAX            0x0108  /* cache-capacity config */
> +#define MPAMCFG_CMIN            0x0110  /* cache-capacity config */
> +#define MPAMCFG_MBW_MIN         0x0200  /* min mem-bw config */
> +#define MPAMCFG_MBW_MAX         0x0208  /* max mem-bw config */
> +#define MPAMCFG_MBW_WINWD       0x0220  /* mem-bw accounting
> window config */
> +#define MPAMCFG_MBW_PBM         0x2000  /* mem-bw portion
> bitmap config */
> +#define MPAMCFG_PRI             0x0400  /* priority partitioning config
> */
> +#define MPAMCFG_MBW_PROP        0x0500  /* mem-bw stride config
> */
> +#define MPAMCFG_INTPARTID       0x0600  /* partid-narrowing config
> */
> +
> +#define MSMON_CFG_MON_SEL       0x0800  /* monitor selector */
> +#define MSMON_CFG_CSU_FLT       0x0810  /* cache-usage monitor
> filter */
> +#define MSMON_CFG_CSU_CTL       0x0818  /* cache-usage monitor
> config */
> +#define MSMON_CFG_MBWU_FLT      0x0820  /* mem-bw monitor filter
> */
> +#define MSMON_CFG_MBWU_CTL      0x0828  /* mem-bw monitor
> config */
> +#define MSMON_CSU               0x0840  /* current cache-usage */
> +#define MSMON_CSU_CAPTURE       0x0848  /* last cache-usage value
> captured */
> +#define MSMON_MBWU              0x0860  /* current mem-bw usage
> value */
> +#define MSMON_MBWU_CAPTURE      0x0868  /* last mem-bw value
> captured */
> +#define MSMON_CAPT_EVNT         0x0808  /* signal a capture event */
> +#define MPAMF_ESR               0x00F8  /* error status register */
> +#define MPAMF_ECR               0x00F0  /* error control register */
> +
> +/* MPAMF_IDR - MPAM features ID register */
> +#define MPAMF_IDR_PARTID_MAX            GENMASK(15, 0)
> +#define MPAMF_IDR_PMG_MAX               GENMASK(23, 16)
> +#define MPAMF_IDR_HAS_CCAP_PART         BIT(24)
> +#define MPAMF_IDR_HAS_CPOR_PART         BIT(25)
> +#define MPAMF_IDR_HAS_MBW_PART          BIT(26)
> +#define MPAMF_IDR_HAS_PRI_PART          BIT(27)
> +#define MPAMF_IDR_HAS_EXT               BIT(28)
> +#define MPAMF_IDR_HAS_IMPL_IDR          BIT(29)
> +#define MPAMF_IDR_HAS_MSMON             BIT(30)
> +#define MPAMF_IDR_HAS_PARTID_NRW        BIT(31)
> +#define MPAMF_IDR_HAS_RIS               BIT(32)
> +#define MPAMF_IDR_HAS_EXT_ESR           BIT(38)
> +#define MPAMF_IDR_HAS_ESR               BIT(39)
> +#define MPAMF_IDR_RIS_MAX               GENMASK(59, 56)
> +
> +/* MPAMF_MSMON_IDR - MPAM performance monitoring ID register */
> +#define MPAMF_MSMON_IDR_MSMON_CSU               BIT(16)
> +#define MPAMF_MSMON_IDR_MSMON_MBWU              BIT(17)
> +#define MPAMF_MSMON_IDR_HAS_LOCAL_CAPT_EVNT     BIT(31)
> +
> +/* MPAMF_CPOR_IDR - MPAM features cache portion partitioning ID
> register */
> +#define MPAMF_CPOR_IDR_CPBM_WD                  GENMASK(15,
> 0)
> +
> +/* MPAMF_CCAP_IDR - MPAM features cache capacity partitioning ID
> register */
> +#define MPAMF_CCAP_IDR_HAS_CMAX_SOFTLIM         BIT(31)
> +#define MPAMF_CCAP_IDR_NO_CMAX                  BIT(30)
> +#define MPAMF_CCAP_IDR_HAS_CMIN                 BIT(29)
> +#define MPAMF_CCAP_IDR_HAS_CASSOC               BIT(28)
> +#define MPAMF_CCAP_IDR_CASSOC_WD                GENMASK(12,
> 8)
> +#define MPAMF_CCAP_IDR_CMAX_WD                  GENMASK(5, 0)
> +
> +/* MPAMF_MBW_IDR - MPAM features memory bandwidth partitioning ID
> register */
> +#define MPAMF_MBW_IDR_BWA_WD            GENMASK(5, 0)
> +#define MPAMF_MBW_IDR_HAS_MIN           BIT(10)
> +#define MPAMF_MBW_IDR_HAS_MAX           BIT(11)
> +#define MPAMF_MBW_IDR_HAS_PBM           BIT(12)
> +#define MPAMF_MBW_IDR_HAS_PROP          BIT(13)
> +#define MPAMF_MBW_IDR_WINDWR            BIT(14)
> +#define MPAMF_MBW_IDR_BWPBM_WD          GENMASK(28, 16)
> +
> +/* MPAMF_PRI_IDR - MPAM features priority partitioning ID register */
> +#define MPAMF_PRI_IDR_HAS_INTPRI        BIT(0)
> +#define MPAMF_PRI_IDR_INTPRI_0_IS_LOW   BIT(1)
> +#define MPAMF_PRI_IDR_INTPRI_WD         GENMASK(9, 4)
> +#define MPAMF_PRI_IDR_HAS_DSPRI         BIT(16)
> +#define MPAMF_PRI_IDR_DSPRI_0_IS_LOW    BIT(17)
> +#define MPAMF_PRI_IDR_DSPRI_WD          GENMASK(25, 20)
> +
> +/* MPAMF_CSUMON_IDR - MPAM cache storage usage monitor ID register
> */
> +#define MPAMF_CSUMON_IDR_NUM_MON        GENMASK(15, 0)
> +#define MPAMF_CSUMON_IDR_HAS_OFLOW_CAPT	BIT(24)
> +#define MPAMF_CSUMON_IDR_HAS_CEVNT_OFLW	BIT(25)
> +#define MPAMF_CSUMON_IDR_HAS_OFSR	BIT(26)
> +#define MPAMF_CSUMON_IDR_HAS_OFLOW_LNKG	BIT(27)
> +#define MPAMF_CSUMON_IDR_HAS_XCL	BIT(29)
> +#define MPAMF_CSUMON_IDR_CSU_RO		BIT(30)
> +#define MPAMF_CSUMON_IDR_HAS_CAPTURE    BIT(31)
> +
> +/* MPAMF_MBWUMON_IDR - MPAM memory bandwidth usage monitor ID
> register */
> +#define MPAMF_MBWUMON_IDR_NUM_MON       GENMASK(15, 0)
> +#define MPAMF_MBWUMON_IDR_HAS_RWBW      BIT(28)
> +#define MPAMF_MBWUMON_IDR_LWD           BIT(29)
> +#define MPAMF_MBWUMON_IDR_HAS_LONG      BIT(30)
> +#define MPAMF_MBWUMON_IDR_HAS_CAPTURE   BIT(31)
> +
> +/* MPAMF_PARTID_NRW_IDR - MPAM PARTID narrowing ID register */
> +#define MPAMF_PARTID_NRW_IDR_INTPARTID_MAX      GENMASK(15,
> 0)
> +
> +/* MPAMF_IIDR - MPAM implementation ID register */
> +#define MPAMF_IIDR_PRODUCTID    GENMASK(31, 20)
> +#define MPAMF_IIDR_PRODUCTID_SHIFT	20
> +#define MPAMF_IIDR_VARIANT      GENMASK(19, 16)
> +#define MPAMF_IIDR_VARIANT_SHIFT	16
> +#define MPAMF_IIDR_REVISON      GENMASK(15, 12)
> +#define MPAMF_IIDR_REVISON_SHIFT	12
> +#define MPAMF_IIDR_IMPLEMENTER  GENMASK(11, 0)
> +#define MPAMF_IIDR_IMPLEMENTER_SHIFT	0
> +
> +/* MPAMF_AIDR - MPAM architecture ID register */
> +#define MPAMF_AIDR_ARCH_MAJOR_REV       GENMASK(7, 4)
> +#define MPAMF_AIDR_ARCH_MINOR_REV       GENMASK(3, 0)
> +
> +/* MPAMCFG_PART_SEL - MPAM partition configuration selection register
> */
> +#define MPAMCFG_PART_SEL_PARTID_SEL     GENMASK(15, 0)
> +#define MPAMCFG_PART_SEL_INTERNAL       BIT(16)
> +#define MPAMCFG_PART_SEL_RIS            GENMASK(27, 24)
> +
> +/* MPAMCFG_CMAX - MPAM cache capacity configuration register */
> +#define MPAMCFG_CMAX_SOFTLIM            BIT(31)
> +#define MPAMCFG_CMAX_CMAX               GENMASK(15, 0)
> +
> +/* MPAMCFG_CMIN - MPAM cache capacity configuration register */
> +#define MPAMCFG_CMIN_CMIN               GENMASK(15, 0)
> +
> +/*
> + * MPAMCFG_MBW_MIN - MPAM memory minimum bandwidth partitioning
> configuration
> + *                   register
> + */
> +#define MPAMCFG_MBW_MIN_MIN             GENMASK(15, 0)
> +
> +/*
> + * MPAMCFG_MBW_MAX - MPAM memory maximum bandwidth
> partitioning configuration
> + *                   register
> + */
> +#define MPAMCFG_MBW_MAX_MAX             GENMASK(15, 0)
> +#define MPAMCFG_MBW_MAX_HARDLIM         BIT(31)
> +
> +/*
> + * MPAMCFG_MBW_WINWD - MPAM memory bandwidth partitioning
> window width
> + *                     register
> + */
> +#define MPAMCFG_MBW_WINWD_US_FRAC       GENMASK(7, 0)
> +#define MPAMCFG_MBW_WINWD_US_INT        GENMASK(23, 8)
> +
> +/* MPAMCFG_PRI - MPAM priority partitioning configuration register */
> +#define MPAMCFG_PRI_INTPRI              GENMASK(15, 0)
> +#define MPAMCFG_PRI_DSPRI               GENMASK(31, 16)
> +
> +/*
> + * MPAMCFG_MBW_PROP - Memory bandwidth proportional stride
> partitioning
> + *                    configuration register
> + */
> +#define MPAMCFG_MBW_PROP_STRIDEM1       GENMASK(15, 0)
> +#define MPAMCFG_MBW_PROP_EN             BIT(31)
> +
> +/*
> + * MPAMCFG_INTPARTID - MPAM internal partition narrowing configuration
> +register  */
> +#define MPAMCFG_INTPARTID_INTPARTID     GENMASK(15, 0)
> +#define MPAMCFG_INTPARTID_INTERNAL      BIT(16)
> +
> +/* MSMON_CFG_MON_SEL - Memory system performance monitor
> selection register */
> +#define MSMON_CFG_MON_SEL_MON_SEL       GENMASK(15, 0)
> +#define MSMON_CFG_MON_SEL_RIS           GENMASK(27, 24)
> +
> +/* MPAMF_ESR - MPAM Error Status Register */ #define
> +MPAMF_ESR_PARTID_OR_MON GENMASK(15, 0)
> +#define MPAMF_ESR_PMG           GENMASK(23, 16)
> +#define MPAMF_ESR_ERRCODE       GENMASK(27, 24)
> +#define MPAMF_ESR_OVRWR         BIT(31)
> +#define MPAMF_ESR_RIS           GENMASK(35, 32)
> +
> +/* MPAMF_ECR - MPAM Error Control Register */
> +#define MPAMF_ECR_INTEN         BIT(0)
> +
> +/* Error conditions in accessing memory mapped registers */
> +#define MPAM_ERRCODE_NONE                       0
> +#define MPAM_ERRCODE_PARTID_SEL_RANGE           1
> +#define MPAM_ERRCODE_REQ_PARTID_RANGE           2
> +#define MPAM_ERRCODE_MSMONCFG_ID_RANGE          3
> +#define MPAM_ERRCODE_REQ_PMG_RANGE              4
> +#define MPAM_ERRCODE_MONITOR_RANGE              5
> +#define MPAM_ERRCODE_INTPARTID_RANGE            6
> +#define MPAM_ERRCODE_UNEXPECTED_INTERNAL        7
> +
> +/*
> + * MSMON_CFG_CSU_FLT - Memory system performance monitor configure
> cache storage
> + *                    usage monitor filter register
> + */
> +#define MSMON_CFG_CSU_FLT_PARTID       GENMASK(15, 0)
> +#define MSMON_CFG_CSU_FLT_PMG          GENMASK(23, 16)
> +
> +/*
> + * MSMON_CFG_CSU_CTL - Memory system performance monitor configure
> cache storage
> + *                    usage monitor control register
> + * MSMON_CFG_MBWU_CTL - Memory system performance monitor
> configure memory
> + *                     bandwidth usage monitor control register
> + */
> +#define MSMON_CFG_x_CTL_TYPE           GENMASK(7, 0)
> +#define MSMON_CFG_x_CTL_OFLOW_STATUS_L BIT(15)
> +#define MSMON_CFG_x_CTL_MATCH_PARTID   BIT(16)
> +#define MSMON_CFG_x_CTL_MATCH_PMG      BIT(17)
> +#define MSMON_CFG_x_CTL_SCLEN          BIT(19)
> +#define MSMON_CFG_x_CTL_SUBTYPE        GENMASK(23, 20)
> +#define MSMON_CFG_x_CTL_OFLOW_FRZ      BIT(24)
> +#define MSMON_CFG_x_CTL_OFLOW_INTR     BIT(25)
> +#define MSMON_CFG_x_CTL_OFLOW_STATUS   BIT(26)
> +#define MSMON_CFG_x_CTL_CAPT_RESET     BIT(27)
> +#define MSMON_CFG_x_CTL_CAPT_EVNT      GENMASK(30, 28)
> +#define MSMON_CFG_x_CTL_EN             BIT(31)
> +
> +#define MSMON_CFG_MBWU_CTL_TYPE_MBWU
> 	0x42
> +#define MSMON_CFG_MBWU_CTL_TYPE_CSU
> 	0x43

MSMON_CFG_CSU_CTL_TYPE_CSU?

Best regards,
Shaopeng TAN

> +
> +#define MSMON_CFG_MBWU_CTL_SUBTYPE_NONE                 0
> +#define MSMON_CFG_MBWU_CTL_SUBTYPE_READ                 1
> +#define MSMON_CFG_MBWU_CTL_SUBTYPE_WRITE                2
> +#define MSMON_CFG_MBWU_CTL_SUBTYPE_BOTH                 3
> +
> +#define MSMON_CFG_MBWU_CTL_SUBTYPE_MAX                  3
> +#define MSMON_CFG_MBWU_CTL_SUBTYPE_MASK                 0x3
> +
> +/*
> + * MSMON_CFG_MBWU_FLT - Memory system performance monitor
> configure memory
> + *                     bandwidth usage monitor filter register
> + */
> +#define MSMON_CFG_MBWU_FLT_PARTID               GENMASK(15,
> 0)
> +#define MSMON_CFG_MBWU_FLT_PMG                  GENMASK(23,
> 16)
> +#define MSMON_CFG_MBWU_FLT_RWBW                 GENMASK(31,
> 30)
> +
> +/*
> + * MSMON_CSU - Memory system performance monitor cache storage usage
> monitor
> + *            register
> + * MSMON_CSU_CAPTURE -  Memory system performance monitor cache
> storage usage
> + *                     capture register
> + * MSMON_MBWU  - Memory system performance monitor memory
> bandwidth usage
> + *               monitor register
> + * MSMON_MBWU_CAPTURE - Memory system performance monitor
> memory bandwidth usage
> + *                     capture register
> + */
> +#define MSMON___VALUE          GENMASK(30, 0)
> +#define MSMON___NRDY           BIT(31)
> +#define MSMON_MBWU_L_VALUE     GENMASK(62, 0)
> +/*
> + * MSMON_CAPT_EVNT - Memory system performance monitoring capture
> event
> + *                  generation register
> + */
> +#define MSMON_CAPT_EVNT_NOW    BIT(0)
> +
>  #endif /* MPAM_INTERNAL_H */
> --
> 2.39.5


