Return-Path: <linux-kernel+bounces-734871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F10B0876B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51744E60EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EEC26CE33;
	Thu, 17 Jul 2025 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="A/gRC94l"
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9850A2690D1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752739111; cv=fail; b=m6u0zj7FYLiUPaGguNqkjQNm32ti8MuXLCjOToxyzjpZQCrPov9kFXlIJ+AjVJMfufoHi+OUeg1avzDXcf62Z+bsGVjAMzPQs9I6Bd7oYU9jqfM1DQu1JouKCbF00/jVhxzEVwnWweTKuh3R3A9Ougg/+nCZEI4GG8mEWEhEvvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752739111; c=relaxed/simple;
	bh=d8ol1vEcn+MsRKkVNkpXfEpFoFLTJrzgty00N9kPFmI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bkbq6lKlboTPhbNP8YJejCA1i/KFK19R1n4o8KHU+l0s3DbEJqZYzGVG2cF89YV9gb8+yx5QPJ4xF5r3Zq27pvMJz3lhsEF3eolzk4MumK9hDH9BIU5IK7zk5cbnI+Ls5iKy1tJlhaEl2KsRtTMWRzEZ0EDpVRI7+kazCtymjw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=A/gRC94l; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1752739109; x=1784275109;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d8ol1vEcn+MsRKkVNkpXfEpFoFLTJrzgty00N9kPFmI=;
  b=A/gRC94lWy69R6Jg1meTgfwFCHkGbQ8XLj7BU3Div4Ex/t5gZtIXv8gg
   05h5WvxFE47HtjyqEY9vIWFR8JOt4j4Icuu/7pR+zzwshl8r4owxyOh9B
   gxk2meuvrRmCbp7CPCvA8dXKLMoTo3DSO9Xah+9imAmeZtGTxZfC+oUyE
   TklVQ90DMbHcL9kq8fyA47H6xqXlAWplnNP0UslE2mi84T1y//2adFtrz
   uC+6ipzu3YLXBxSs/Snp4DWscyhpA6X4lcoFiZreS1Gpxu/iWZVhaPS0h
   0puir9gvLV/25wyJQzXWQxMwbVk9uF4LwE+L1AFhyAgo5CFjq4k6jtEYh
   Q==;
X-CSE-ConnectionGUID: CQ1Vs01ATGi7bSokeX/rjQ==
X-CSE-MsgGUID: 9I11Dsr0QtWyoE4Nm6WKlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="161390975"
X-IronPort-AV: E=Sophos;i="6.16,318,1744038000"; 
   d="scan'208";a="161390975"
Received: from mail-japaneastazon11010051.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 16:58:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xkic4EFQ3gLUp7aez6IO1EoLo5RPmX6qCcdnF90ds4SuUEuoDwwu3ZMfV3jMqhhgIhw67hr6yGxfyzeteDZCmOxwjEdSTK+mlytshpdVxFwHXcJoTQWkAc9kcJ/tnWSozmE872+P9hP67B4zFxzDSGkEy7Htan1ZKs9VfZbbwFtTpPYvipydW3wHSaM8GoTsoVfuZrC7r03Msb6AYsBxEuIoosaGOmYb5dSJLohxx8zxRCXpqPevzEc5E2voczygl4zJu5Jt1bhauLe4d+N43d81JV83taQOXosPUK4L35CH2IiMAceeNwEqVisxDn1d5IccEo9m5jQeZu5CQcbCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krytkblhx0x/J2kLttNuNOARvR8a4eFnrG+5z5SXz+s=;
 b=cAyb9cLKI3rHoa+/C38re49z+OxHMqAYs8fYzvhLlEmgWbCAu5jVuDPetik+UkPzrvcddP8g17gCo7OSDDHGDBhW6C6a0BpW440RRb1Bt37tOCHStSU3oI+LuFrF/x+UJiN3qTUJI+Bxp8odDg1K2PEuo94bDOiQhY6iDzf7xVoC4v9C+SMUJy6Y5XLwPG27DsqGqXivXLQb14mSDZ/dfJRV0rsyUO92T1D2glg9pmP4Ybhb2wQnULFZm0r2t8CKdhokhqNAGahOLNaAwHA05InxEsTJN/JGIUK/HC0B16Qz/tnFkxdJJ76AMWOIADJVRYLy3pUe/E7iV4xoAkHaXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYWPR01MB8806.jpnprd01.prod.outlook.com (2603:1096:400:16a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 07:58:12 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672%7]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 07:58:12 +0000
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
	<kobak@nvidia.com>, Sudeep Holla <sudeep.holla@arm.com>
Subject: RE: [RFC PATCH 05/36] ACPI / PPTT: Add a helper to fill a cpumask
 from a processor container
Thread-Topic: [RFC PATCH 05/36] ACPI / PPTT: Add a helper to fill a cpumask
 from a processor container
Thread-Index: AQHb8pLahQIav1oKZkGXV92fpQioe7Q17FNw
Date: Thu, 17 Jul 2025 07:58:12 +0000
Message-ID:
 <OSZPR01MB8798B26E19F73A1468FB85408B51A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-6-james.morse@arm.com>
In-Reply-To: <20250711183648.30766-6-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=3f291ea3-b2e0-4e56-9174-7e96785177c9;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-07-17T07:02:19Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYWPR01MB8806:EE_
x-ms-office365-filtering-correlation-id: adff5ae1-9965-47a8-509d-08ddc507ad6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?dHJzMmJXV0QrempnTTZDOHdCN1RUYzBiUWNEaHJHTXNGb0Nob1RTdU9C?=
 =?iso-2022-jp?B?eEFjeC9XSWJKTkQ1UnFVb05hQ3pFQ0l2Z1NrdHhsY0Q3TUdQTjFSYjk5?=
 =?iso-2022-jp?B?ZnZSbUFMUGZkR09qbFl4bWRUaFFhUXkvbGxndXo2akQ2cFM2REJXb0ZH?=
 =?iso-2022-jp?B?a1VCWmJJRkg5cWFPb1BUUHdRVFJ2ZVU3UW1mczBtdmF5RnlxOC9ZUUp0?=
 =?iso-2022-jp?B?U2xrTzBmenFRRE4zR0tmY0Z5VHFYd2lOZFd2MElzeU1yQ0JSRkZnOGcw?=
 =?iso-2022-jp?B?TnBVVGI4cVlJcXBQeVh5d3lvSVVQWWdKZzFZR1FENWVMTGxWaDVLY0Jt?=
 =?iso-2022-jp?B?L3BpaGtXeklMa0JHeDlNQzJmL3o5RHNiUmFjT1dmcjM2YjJqQzEzcGR4?=
 =?iso-2022-jp?B?QTMwMUlGcm4rdzF1VXNGMXArdWF6bFZwY25UUy9mSGozaHZ4QjJOTjZT?=
 =?iso-2022-jp?B?a1BnSTFESFZZUVpuaHdXOWVFbEVTR1MxM2lVQW9WaUQ5bEliNHRuZ0dV?=
 =?iso-2022-jp?B?ajFWdGJySE4wamFDR04yZDh1cHNHM2RzblBkWktzdkRIUWJrSW9LaE40?=
 =?iso-2022-jp?B?azNOcjZQSUg0QzdScDZmeXBEUlJPQkdtNnBiRDBoc0tHalpYbWpXWFJ0?=
 =?iso-2022-jp?B?ejVJamo1WmRSdVRkeVd2WllJNGJyZ1hRY3RFdXZOQW92Nit0bm5EWU1P?=
 =?iso-2022-jp?B?Ykx2YTV5YjJyRkxaRkwrNThGdGI4MlhxNldkUmE1Ty9WYzJuREkvU2dQ?=
 =?iso-2022-jp?B?R3dmM3I4Q1hlbW5PakZMcWdkVkh5UUR0dUViOGtnUEphYmkrdVkvNjJI?=
 =?iso-2022-jp?B?bDJsRFFaMlVTTUlkTndKOFlraURKYzM0L0RwWnFLNUdXNlBWUEY5M3Yz?=
 =?iso-2022-jp?B?bWx5ajAwcFBkMWxibU1wY0NzaTlPQXlRMGJzMlVBaC83WVhOZFd1cjZ5?=
 =?iso-2022-jp?B?OFBoOXZsRlVlR2tOUlJWSHRjb2tteTNjTk5pZTZsdzVhcTdPVzFNNDZC?=
 =?iso-2022-jp?B?alJwUnAzTUtiVVZpZWFLRXhLck9aMkhMaUgwZDFyMUlESitzVEFZNFdz?=
 =?iso-2022-jp?B?MHk2cWhQbmtVOEc1YTdXS1cwcUl0a3hneXpFQ2UzbnJKaHZjSkZJSmVv?=
 =?iso-2022-jp?B?ZFdQdVN1NzdRNHl0dWdGSFE0REI0UVpDV1o2M05YSDlXS2VJZElzTU1V?=
 =?iso-2022-jp?B?c0VKNWs2WG1aTU5BMStnTmRTamdDM2d4cUI3cWptdGxyc0I3a1hTUUpv?=
 =?iso-2022-jp?B?TWZVTU82M0grYTdMQTRxZ2d2STYrNjNPajVtTzlxS1N3a0RxVTFJTEND?=
 =?iso-2022-jp?B?bkxnenQ1K0UyT294Mzg0ZC9TSkUvZU1uWkpJK1BDV1RuNFA1bW9yZHJL?=
 =?iso-2022-jp?B?enlnN2x3NHF3N1JpbXpxZjhEU1BhNC9JbVBJTDAvYlJVNWg3VmtnMldv?=
 =?iso-2022-jp?B?YjA0ZzlMZUE4VlBYdDZEMk8vUzdxTmpaWk5RUGZlcWdmckVXV1FTZnph?=
 =?iso-2022-jp?B?WHdOZmVFU2dldHVuektia0pQRkVRb2JQd3h3M2ptTVVySzhyU3B3UThn?=
 =?iso-2022-jp?B?R2hQL24rdER3bk56SURhVzYzUml1QVkxVEJweXREVjQ5U09rZTdDanM1?=
 =?iso-2022-jp?B?cFNRektVTGZiZzBrRDlkTDhLa3Q3ODVUdmhvNTNxRG9jNmFKd3l3aUgw?=
 =?iso-2022-jp?B?ZnFFbEw1Qm5zUktwcU1YK1BiTHhlMFlCMXF6cDBmb3RJbkNwdHpHWEI2?=
 =?iso-2022-jp?B?RFVIMDY4UFRpSXUreTRhQkcvN2ZpVmZ6aGhJdE1aNU5PVHltcW5iYTZn?=
 =?iso-2022-jp?B?a0hNMUljRHNtQ0k4NDU0NEtGZWkwTFZycFNyUFZ2QUpJeXI2a215QUJM?=
 =?iso-2022-jp?B?bU1KbDBjS3VDRkFFKzBVazJ1d1FEcFhDQUxJSnd0QzZDSVloM1hVR0pt?=
 =?iso-2022-jp?B?Zmt1MDQ1SU1IZ0FscHprNGMyNFBoK1prMWcyZDhpY1I2dm5ENnVGU20x?=
 =?iso-2022-jp?B?eVV0ZVhwWld5RVRZdTA0OGozaW8xVmtYWTgvQ1R6a0xpV2pSZzF2ejBa?=
 =?iso-2022-jp?B?UnpqcjRrUUxwakRjc3JJTjAvdDI2STlSdU5GT1BpbitFaVk5RUh6V3Ja?=
 =?iso-2022-jp?B?aVpjUmMrUFJsanVxd01RZG1WR29SekRKN1N1SGhFTUVEaWdOR2VUOWQ5?=
 =?iso-2022-jp?B?Ni9hQmVxTEQyN2FWVTRMY2F4czM5UmNm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?b28yNHpPb2dkY1FQeUhuZk1nWThBdHhBeTZoeUtyTUc0QlNVenlQb0ND?=
 =?iso-2022-jp?B?dHFPQ05qN2dlby81SlIzc2lsSlJLN3JldFdKelBiUXNaZjYwaFhaRDBu?=
 =?iso-2022-jp?B?VzZwK09PVXFQdVJMdjdOcFMwYmlYSkhyRkZnWVNoSFJyWVZtQVVUQXZ0?=
 =?iso-2022-jp?B?NlpEMDcwWmM4SnVRZWdzQnNrcE1oZ1ZIRkluRE9ObmVhblF0M1dWa0RL?=
 =?iso-2022-jp?B?S1F4TEVPNDZ2QUU1WGxub0hobEd2TitRUjF6MHpHWlI0VlZscitzc3Q1?=
 =?iso-2022-jp?B?VTFDL0FaVlk5YUJQNkpLRzhrK3Z0YUVvK2h0T3RydDRhQ2hNVWIxbDlq?=
 =?iso-2022-jp?B?MzRMT090M0VEd1JVNTM3SWU5azV6M3dXSkt3NTBCcG9vNHorcHZIamJZ?=
 =?iso-2022-jp?B?YmhGWTBKZnZNdWlWLzVpZkp4dWJDYmFmTWYyN3FRRTk0SmhqMng0YXU1?=
 =?iso-2022-jp?B?RDE0NW1yWStFRXRCUEkzTHZkSWhaOW1XUXhyOXhLcE03REd5TDdnU1pv?=
 =?iso-2022-jp?B?ekVPSUtIdDNVWjFqT1JMd0R5Ti9meEl3a2NyMDBJYUNZZkR4WlorNjBX?=
 =?iso-2022-jp?B?Y3o4K2pJS3YwSUk2Q25QUy8yVUo3OWx3MENEZ0VLNkNJMUNrQUFnVy8w?=
 =?iso-2022-jp?B?a1E1R3Y2N0R6MTV0cmVaSDByNE1PZnJsRXpUZG03NldsdXluYTJkc2Rz?=
 =?iso-2022-jp?B?RjZieitOMFdCR3ROeGRxKzd6YU9ENlhnZlI5UU5qbW12MlJ1WVV1a2tq?=
 =?iso-2022-jp?B?aHJOVDlYdU1OVkNnMTcya21Zd205Qzl5WDlyRUZBVC9ocE03VEFpQVk0?=
 =?iso-2022-jp?B?b3BYenNtRE1XUnFHeXB3UkhpK1hnUVJxT1pMNWJiOWR5UHR6Um0vNXh4?=
 =?iso-2022-jp?B?UUxpeWF0UmtaRnJpZWEyS3VvUktMdC95ekRTZ1VJMkoxL3lKRWxaZFNy?=
 =?iso-2022-jp?B?UFpLNVIxZGlKYVJFNmp2WG5ON1ZkeWFNZG9LbkVWdmZzUHV3KzlJS0ti?=
 =?iso-2022-jp?B?LzFqMTRQZXdOYmcybWNzUmE1V3l3b0lnRWtIa08vQVppa09DQS9NQ3k4?=
 =?iso-2022-jp?B?aTZSeVZMZE5HZjQ0c01xMUE4VHE1M0pXalNFQVN0dlpvWHJyVHZQdkpD?=
 =?iso-2022-jp?B?VDVKZkhYN2ZESjJoeXEyNkZYbTNRcmgvanRYK0FCaTAwb0tDL2xobjZo?=
 =?iso-2022-jp?B?YVRWM2h5UEdZTEllZGx2UEZRQkpGZHN3c3c2Q09wTGhZZkNJbjdNYTBS?=
 =?iso-2022-jp?B?dEdiVEJkR0hEMkk3OXBIV1FibkRMOXp6blFwTU5rY0VVWDJkYkg4Z29v?=
 =?iso-2022-jp?B?bnh5a3JnZlUvbjhSY0lreEo5dUx1a3dHZE1DL1BrdWVnM09nK09MeWVN?=
 =?iso-2022-jp?B?NHBQeUlBTjYwaU5GZm5hT0hPeXlMbVM1VTd5U0ZPSkxxUkgvalFtR0tC?=
 =?iso-2022-jp?B?QWJ5R2hxdjRiOGNpZlVCMGthVUpCZExaaGl4UHAyUTZpWmNMWTA2bnhy?=
 =?iso-2022-jp?B?NHRFQURUb1Zwb0JKbkYxSFZtUnBSMDQzeTl6bmxsc21ZcjlMVzFNeVRR?=
 =?iso-2022-jp?B?NXN6R2R0a3lsMTBzSzNZWVc0VUdNR2xJUkQxMGdZZ2haQXZFUU52ZFZE?=
 =?iso-2022-jp?B?ZXp4N0RmMmpEU1BBeThIT1Mva0piYUlOZlFNTitwRlRmSDc0WUZ0Q0Nw?=
 =?iso-2022-jp?B?QzVVKzVMeWFXZlRXSDhEWlFCSDBpQW1lY0FrUnN5YjFreUdUYXFtdVNF?=
 =?iso-2022-jp?B?a3lGVHF5bkZGOHhrOWNVc2NENld2cXhPcVllOFdZL1gyWnlrZTE0NDlY?=
 =?iso-2022-jp?B?RFE1QXRUS25jUitobGlyOHprNlVpNXFqbDJyeE5VYmdmMk04WW42LzF1?=
 =?iso-2022-jp?B?bzFhZVpJTE1IbTNTVW10SUF5N3UrUDUxTm5SQ3EyWVJjanpPZFBTeCs3?=
 =?iso-2022-jp?B?Nk90V05WT3RLd1VuV29xZTA4QUwrR1M3eWUyN3gwaDNEcE5NTE1HNTEv?=
 =?iso-2022-jp?B?bW44aEVJRjRpbzNobWZJdzdUTGFoUUpVRENwYlR2Z2RpdTF4Z0s0eFRF?=
 =?iso-2022-jp?B?Q05jL09zakQ0bGExdndWVjhTSThIOXRkSmI2STJCRytOMWNMRVo3MVl3?=
 =?iso-2022-jp?B?RHMzN0Vldjd5Y25qQ3RuMWx3VWxGWEltWDFJdXQ4eXJqZWkwRkl6VE5H?=
 =?iso-2022-jp?B?akNINjlKTEpwYU5RWTdQa1hSSHIwUVNCVlBmN0QzaVVJYnpnN3FuYkpj?=
 =?iso-2022-jp?B?Rmk0U0lxQnFDcklMYVJua3A1dmxWWFNxTm9NODVrREh2OGRmUVlQMElB?=
 =?iso-2022-jp?B?N0M0YXFHZUtXYUNCa1lxek9ZTXlDVXQ3dVE9PQ==?=
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
	rjCs51b0btwK2WOCcvc47SBxHZDBE9Ix/0E8uD1j5dIF+KKQWRF0mUJwJ1F2bwfErorRB/GA8VdRy1ZVMzQ7Eujel4dPiBANBIqArh1/RZ+kMo4WCbfL7zbUQA5quWG2oyVmfDJi8zn7YTC6p2IN9dapu95fmzfzVfNnv7ukZFjX7UU1Dy9bebxi3xprWm/PMAjZrlDrwz2gVeCEnbhuIVuOa8vjYu7h1YoJ+WJgvyFAIr+SlraXD/d6lhwKQbrxsebjY8x/AHS39SQ52Etdiec7WYw9mNmSbShQZ3o8xT8Ifa7J1GSktqntPAWY31hjzXLWQPCQdPu8JkMVeDDhK4YRE7j1TDxW62SpoMhbXp8xIOOwX1/LwfJnC0X0qbds4qPXwxLgkdEdOtUHU9tZnHzZj0wN+CNZINdC/ROOh+AWkBDhPYYpp+FJ+BjKYL2/lEz6EOftSWhK/fzYxyT03g1a2Zfpi8Ph/pIPtZq1b2BhUCu9qoTcPdpDfaGKWO9PSPuwe45Pa31jVZOz8G1D5D7YY8sCoJ4wbEp6ODsJfJ431cfA2AwYXFMby38TdOQc/Rzj9Pl461RsqS25KKjk9BxfaDjQqnw50INk8+j9ubyduUcDMxAYtCwPh6uYUycF
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adff5ae1-9965-47a8-509d-08ddc507ad6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 07:58:12.1389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Auvh/iJEEvbQH5KvWiHhhAkwuqu8WS1YJI/W0syKzrQjnb8VWLnh+n99Cm2BVAMJJGYldif4StaVk976XBQGPsOC0lE2PYwqFH5kQlGMBkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8806

Hello James,

> The PPTT describes CPUs and caches, as well as processor containers.
> The ACPI table for MPAM describes the set of CPUs that can access an MSC
> with the UID of a processor container.
>=20
> Add a helper to find the processor container by its id, then walk the pos=
sible
> CPUs to fill a cpumask with the CPUs that have this processor container a=
s a
> parent.
>=20
> CC: Dave Martin <dave.martin@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/acpi/pptt.c  | 93
> ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h |  6 +++
>  2 files changed, 99 insertions(+)
>=20
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c index
> 54676e3d82dd..13619b1b821b 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -298,6 +298,99 @@ static struct acpi_pptt_processor
> *acpi_find_processor_node(struct acpi_table_he
>  	return NULL;
>  }
>=20
> +/**
> + * acpi_pptt_get_child_cpus() - Find all the CPUs below a PPTT processor
> node
> + * @table_hdr:		A reference to the PPTT table.
> + * @parent_node:	A pointer to the processor node in the @table_hdr.
> + * @cpus:		A cpumask to fill with the CPUs below @parent_node.
> + *
> + * Walks up the PPTT from every possible CPU to find if the provided
> + * @parent_node is a parent of this CPU.
> + */
> +static void acpi_pptt_get_child_cpus(struct acpi_table_header *table_hdr=
,
> +				     struct acpi_pptt_processor
> *parent_node,
> +				     cpumask_t *cpus)
> +{
> +	struct acpi_pptt_processor *cpu_node;
> +	u32 acpi_id;
> +	int cpu;
> +
> +	cpumask_clear(cpus);
> +
> +	for_each_possible_cpu(cpu) {
> +		acpi_id =3D get_acpi_id_for_cpu(cpu);
> +		cpu_node =3D acpi_find_processor_node(table_hdr, acpi_id);
> +
> +		while (cpu_node) {
> +			if (cpu_node =3D=3D parent_node) {
> +				cpumask_set_cpu(cpu, cpus);
> +				break;
> +			}
> +			cpu_node =3D fetch_pptt_node(table_hdr,
> cpu_node->parent);
> +		}
> +	}
> +}
> +
> +/**
> + * acpi_pptt_get_cpus_from_container() - Populate a cpumask with all CPU=
s
> in a
> + *                                       processor containers
> + * @acpi_cpu_id:	The UID of the processor container.
> + * @cpus		The resulting CPU mask.
> + *
> + * Find the specified Processor Container, and fill @cpus with all the
> +cpus
> + * below it.
> + *
> + * Not all 'Processor' entries in the PPTT are either a CPU or a
> +Processor
> + * Container, they may exist purely to describe a Private resource.
> +CPUs
> + * have to be leaves, so a Processor Container is a non-leaf that has
> +the
> + * 'ACPI Processor ID valid' flag set.
> + *
> + * Return: 0 for a complete walk, or an error if the mask is incomplete.
> + */
> +int acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus)
> +{
> +	struct acpi_pptt_processor *cpu_node;
> +	struct acpi_table_header *table_hdr;
> +	struct acpi_subtable_header *entry;
> +	bool leaf_flag, has_leaf_flag =3D false;
> +	unsigned long table_end;
> +	acpi_status status;
> +	u32 proc_sz;
> +	int ret =3D 0;
> +
> +	cpumask_clear(cpus);
> +
> +	status =3D acpi_get_table(ACPI_SIG_PPTT, 0, &table_hdr);
> +	if (ACPI_FAILURE(status))
> +		return 0;
If pptt table cannot be got,  should -ENODEV be returned?

> +	if (table_hdr->revision > 1)
> +		has_leaf_flag =3D true;
> +
> +	table_end =3D (unsigned long)table_hdr + table_hdr->length;
> +	entry =3D ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
> +			     sizeof(struct acpi_table_pptt));
> +	proc_sz =3D sizeof(struct acpi_pptt_processor);
> +	while ((unsigned long)entry + proc_sz <=3D table_end) {
> +		cpu_node =3D (struct acpi_pptt_processor *)entry;
> +		if (entry->type =3D=3D ACPI_PPTT_TYPE_PROCESSOR &&
> +		    cpu_node->flags &
> ACPI_PPTT_ACPI_PROCESSOR_ID_VALID) {
> +			leaf_flag =3D cpu_node->flags &
> ACPI_PPTT_ACPI_LEAF_NODE;
> +			if ((has_leaf_flag && !leaf_flag) ||
> +			    (!has_leaf_flag
> && !acpi_pptt_leaf_node(table_hdr, cpu_node))) {
> +				if (cpu_node->acpi_processor_id =3D=3D
> acpi_cpu_id)
> +					acpi_pptt_get_child_cpus(table_hdr,
> cpu_node, cpus);
> +			}
> +		}
> +		entry =3D ACPI_ADD_PTR(struct acpi_subtable_header, entry,
> +				     entry->length);
> +	}
> +
> +	acpi_put_table(table_hdr);
> +
> +	return ret;
Only 0 is returned here.
There is no action to be taken when the mask is incomplete.

Best regards,
Shaopeng TAN


> +}
> +
>  static u8 acpi_cache_type(enum cache_type type)  {
>  	switch (type) {
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h index
> f102c0fe3431..8c3165c2b083 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1541,6 +1541,7 @@ int find_acpi_cpu_topology(unsigned int cpu, int
> level);  int find_acpi_cpu_topology_cluster(unsigned int cpu);  int
> find_acpi_cpu_topology_package(unsigned int cpu);  int
> find_acpi_cpu_topology_hetero_id(unsigned int cpu);
> +int acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t
> +*cpus);
>  #else
>  static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)  { @@ -1562,=
6
> +1563,11 @@ static inline int find_acpi_cpu_topology_hetero_id(unsigned i=
nt
> cpu)  {
>  	return -EINVAL;
>  }
> +static inline int acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id,
> +						    cpumask_t *cpus)
> +{
> +	return -EINVAL;
> +}
>  #endif
>=20
>  void acpi_arch_init(void);
> --
> 2.39.5


