Return-Path: <linux-kernel+bounces-603652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4EEA88A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 19:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7C817CDFE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 17:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFD4279904;
	Mon, 14 Apr 2025 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="tHqgWEv1"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011074.outbound.protection.outlook.com [52.103.32.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859F628A1FE
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744653466; cv=fail; b=fEndcgVnfrK1TcyP/wEhtMp9U59y++fAaZuwCuEO9mH+LZeKFc2NOtwytYFvsR8BOcI5kAX9WtEn3CAO07GkEgzKHwHk2T/KsZGhSPF/2AvQmo1QfCIS8beUJrF6H+mmeiaji/rH9HjG6qtbABcvLqTZAuj/ymywM3Jkr2pAoPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744653466; c=relaxed/simple;
	bh=2cVquHEfRPunshMhUaAMUOyLEbRD2tusC/83U+rvKR4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=A/tn05pzfqaAKFD69xgETVJbcDzHueb6MsnBrc9W49Jb3sHryQUXyXQAPGvD4CoQ60lOPjhTfSc5tTn5UQkflLCwq3nUCnQwT3CmI6xYuPPMoFA6DwBqaQc63IJPFXnvWNudrjI6h4oUILEQFZJZq0f8h8sVeNuIl+FhYlyLlLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=tHqgWEv1; arc=fail smtp.client-ip=52.103.32.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljJtg35ZLPw/HSHxhU8H5lxouC70c2fbV6D380ktGw1rsUkszOIAwhrFxtMimIzSIf6vYfHfnKWf1yzuJbRvn8acGtTSylUvoeVel97j3E/01mgeUC/x31pPDGPNn9PdOmsBzgtDBwBg4z966TvieKL7lDPe5wM1NzvpOSCMwyBNDPCUEu5TnA9aikWPOaJibX3aqPndjiORI1STACo2528DyHorKvwbcvFBh9Mo0tl3pTAoKv1czCgfhemvxHlLNVJ8Yqe+CTzasUQnmEMrzOFydagHj7MH97E1SgMu+hhNjg3cRmSNw2ZikHvavI1k8Y9YRV3ITwI56mJDYoLr/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kai0UgTYPyvlFlO/J0jfVcAaIfZPhexchYdyJmtwQbk=;
 b=YGUAzcnHoBfSqhSBdqvvEuwgiZA9j1GKhY9KuTDqKn+if3LkwRxnT9PdskRIOpj2yEc5M+ZdeGtHgeExEtb21mmJul3nNpYJM/BqotAbuApw+D3MT6gla6wah/MQGyRjlqMpsePYrfgWH2eck6xnE78CSwalBwRVFgHR0zrMSXbsanaiYjhjpDwakOWCv1GXvGMiTIFAFW//pP3G9G9i9Fi8/tsrZUmGhMk7TnuEWT5xcOP+uvcRkQoO4AGh5l0y9cT8/wWF04cQMnIQAJJCRQxCjz3PHWOTxptNtFuWJzJxf1lEbBC7rTtMQS4QKAiwWCWLkZaBGp6L/fj0cGn3GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kai0UgTYPyvlFlO/J0jfVcAaIfZPhexchYdyJmtwQbk=;
 b=tHqgWEv14YSHEDMl9DVvCyzveSQDCSOms59bxNiOiL8H28EAeP7Ahd2IPFhNWPHLY918xke/tEuLMCkCY+HWukYhWRibRD3zfEhlUJaYqCkzgV3+MiHOfdPcIoUuHkCjV5sXRm/7sugj9HwGhlgtrog7fwkkB8hofaVMdKVS95W+1TFECbBVWNZJFitakzXE3+oph7jCmBtZ04ctuLj7Pv/+DPWX3umhX3sU1dycgOmK5toAa6DWWZhka/zS0Kupv4S4aWEObe2eiwmz2wmNVWCCIYCOPzjCZjA4zAVtckxf+oJZ1MTJ+fjJ7qF+gPi/uQXOlcxsuiSfwrofauOqNw==
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 (2603:10a6:20b:63e::17) by AS2PR02MB10374.eurprd02.prod.outlook.com
 (2603:10a6:20b:545::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 14 Apr
 2025 17:57:41 +0000
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::58c3:9b65:a6fb:b655]) by AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::58c3:9b65:a6fb:b655%7]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 17:57:41 +0000
From: David Binderman <dcb314@hotmail.com>
To: "jgross@suse.com" <jgross@suse.com>, "sstabellini@kernel.org"
	<sstabellini@kernel.org>, "oleksandr_tyshchenko@epam.com"
	<oleksandr_tyshchenko@epam.com>, "xen-devel@lists.xenproject.org"
	<xen-devel@lists.xenproject.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>
Subject: linux-6.15-rc2/drivers/xen/balloon.c:346: Possible int/long mixup
Thread-Topic: linux-6.15-rc2/drivers/xen/balloon.c:346: Possible int/long
 mixup
Thread-Index: AQHbrWZTlrpkrx2gg0SWv5xq+subcg==
Date: Mon, 14 Apr 2025 17:57:41 +0000
Message-ID:
 <AS8PR02MB1021776B93FEF6D425C7223389CB32@AS8PR02MB10217.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR02MB10217:EE_|AS2PR02MB10374:EE_
x-ms-office365-filtering-correlation-id: 2838e0d5-97ff-430c-2fee-08dd7b7dd9cb
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599003|19110799003|15030799003|15080799006|461199028|8062599003|8060799006|3412199025|440099028|21999032|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?9KEpoXN0OIAabFtfiO6Ud3abovtlN8cBIyI85vnAh/7fZBi8vRtA9WSi5m?=
 =?iso-8859-1?Q?Jdmd6P3p4qBKK4Z2we+iRS3NEtKDFuTvJAmPC7/f+goaHN1NXmkG3t7Mc0?=
 =?iso-8859-1?Q?aqoHth3EMZ41hUf+/ntMtL/6nKjGIrPQUC3R0EcvniVOkMpHkeMXPdLf71?=
 =?iso-8859-1?Q?Y5KHiW6fQRI1ZRVwqTsbaNTtHWSb8aMmlpFeHxwPZrt22srLlemGCA3ZjL?=
 =?iso-8859-1?Q?mSznN92vK5crJl8NDSjDF0gUHkKA2qwQEj1zgN4e9kMHzsiDDs/kxdez6U?=
 =?iso-8859-1?Q?wUBsOl2pZ3ve+zSlj+J+o8divHJqsmXAJTLHP8DhTRVST0i3aIStPZpQBM?=
 =?iso-8859-1?Q?k7QOdmABMM9pfJRWBnMwLCYtwRu2kLv9wmTAcE0qaXpqH2/GlQ2YwZ27ag?=
 =?iso-8859-1?Q?g00Xf4PDDHJmC2CuOB/thTLIAkvteEusMjnkBNu9DeOGau/n0s1WPoS8E9?=
 =?iso-8859-1?Q?X7d1qAjyAQOvzcr6nshd0dsd/JQlwHwhzBOUJqxGDPFGihabJic+FsJPTL?=
 =?iso-8859-1?Q?L/B9woXQxLq7iz1SklXyhy6hUNW3F2zulEm8kFWSbRP5y9AQ8VDV+SweL1?=
 =?iso-8859-1?Q?pGmPPkcyY7J9KPpsymiQ4JC4igphnR9r72zHyDnJjuDnBvs4EcFJfPXRKV?=
 =?iso-8859-1?Q?TKmKdb3Zxu4BRrHD5ZgRhc4qs8bdJ2pvIZcHdL/TsPJbI+pMc8vY1G846/?=
 =?iso-8859-1?Q?1g3nOlKWmtfYDiyATkwsQHYJ4ZWUm7xsQeINUGAEzx3rlQV18Ju3nvNXuF?=
 =?iso-8859-1?Q?i67rbXiaAoLeZT+XjrpY+vOTRhaJgxdf6ZfrfWzLtsumeT5Mi1sBs7/XRf?=
 =?iso-8859-1?Q?+8iwyC4pMeG0uKMxdAG77BrNTXw48/WmewckNEBtqLEz72QbrKjOYYK2s3?=
 =?iso-8859-1?Q?MjhPBumV3NYnEk2VRqJJYjQs0VhO5UfUL6pCrf/Z4DIeDJE62MDRcSUxRk?=
 =?iso-8859-1?Q?VxcQ6F4AaK/mp5ifP5c7Nx1mmA5zB3zr/cToLtlgNJW5G4ZR1P31nS/ZYr?=
 =?iso-8859-1?Q?vNTIJd697SsDMhZHoq+5FsM2Xtzp2etEwYvtKbGCUeGV0QqUm0yQwHLGNQ?=
 =?iso-8859-1?Q?9qFwFxuHl1HcjXwq143PumXsig2uFkydAhH4vnUNbIifasgjTIGgs7CPwm?=
 =?iso-8859-1?Q?lBT6U1HiRo1P7QdUJ1ili4X1f326uutA34fInMVwzZ+7G3sa9xcNTv0bdO?=
 =?iso-8859-1?Q?WK9xHvksPNoMyg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?/JkNyDEdXDk3TKgi9aeSGuFcR02deHBSsFf+shsRuFPC0tUddNadn8LjRc?=
 =?iso-8859-1?Q?2YBB17miKez0Zsk519dDqaZ7R7Ubq62YRD1Hn88dc8NpK6CvcMPkh8YtLj?=
 =?iso-8859-1?Q?FsjubJ0yd2n3N0YdJIFDjuvD/2tApzgDXBlQ2uUfEms1N/Bv9jbL8mukv+?=
 =?iso-8859-1?Q?7zlcKggoY8TSkR4JWVHyS4ZX7GbUzNsnLJekLHW/P5pXg++ns8DsViZFBl?=
 =?iso-8859-1?Q?okabTGTQePtOjjS7Djglyrxd+RzwFxaEVuSo0+gKu0jPcAOoRrKYC440sa?=
 =?iso-8859-1?Q?Wmex6Ox/Bze+jIfrcrxl4DI/btIPuY+Q//vlu5MztZ3WEYSnzofVTNN4MS?=
 =?iso-8859-1?Q?0fX3Jy+sSKHCSeR9NZDg+a74/jIowU3rccDBJFHtCsQuLyR6yMXJWnFDyN?=
 =?iso-8859-1?Q?3r44TYqVEQEYhH8lwpHdR+DJZKyxYcrmmbMHHETzgJajBNMgN61AQe00P/?=
 =?iso-8859-1?Q?WzYJ3NEdQVUf7zCTfe8AS2/xjFhMcZ+UJ1FgEWh9/HU2mT146Krvu30syL?=
 =?iso-8859-1?Q?vxhumCyssKWsHV0oavKvATHMxtEZKruiCrFEKbs0TBhmpmHOhCighzf+FQ?=
 =?iso-8859-1?Q?3PeK8fPzQkWtb9UHJOr0Di2Yym4669p/7ut19mcv3YWjhQVjhWYo2YWOTW?=
 =?iso-8859-1?Q?JHrAEzIDOBCWapRtxY/D+XhU4LpPEoU+b++AVyAqg0aXPtNL+VYR9Fkn7B?=
 =?iso-8859-1?Q?8TtGNz0Z7bKsQ03TvFmnqZroDbOY25mKE7pS6MQW1IMBTlqMDv3OW1cFUy?=
 =?iso-8859-1?Q?4orJcDaoHQN5kTsMjXerjSA9sInuLKP2LHg4g7W5JsCZQ3giqLsuOHJDUm?=
 =?iso-8859-1?Q?YcDqZus/dXX6t3/B0gNX4wnTRF17GOwmwMys9+FGFJivKlmndTrNPw7/6o?=
 =?iso-8859-1?Q?WbRrwUaV0CoYVHnuTcSJg0S+t24C98gMmrZoS0TYM8tigyrH0n/Nm9mbb3?=
 =?iso-8859-1?Q?hpgnOzDUq5VyaIYkhSRV1l5DjFMzrzKxO1RQZDcN1OZMc4kcYYngQqv6xk?=
 =?iso-8859-1?Q?qFqF5y3pJuxr5sirDUNUBOVKGXhGtSHj+Gfm18/hoWuEU0McQNvvwy+YKH?=
 =?iso-8859-1?Q?lV8bXpg48TZXG61Ic7Vjymaar6bXp1q9KfO0hYtLWmxhRKEEuyWR4T31b/?=
 =?iso-8859-1?Q?xxgke6fNWKHK+S2aIo9oWbRB4D2rmeijuo1sadtIi4UQREb9RghFNuvuFJ?=
 =?iso-8859-1?Q?p8rNQV2uezQ2t1WTnTPEoFcVz6TanLGOPqOZIaB8rIiNpfhKoHros3EOBT?=
 =?iso-8859-1?Q?zpoIm9vHm0weTVHw0B0Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB10217.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2838e0d5-97ff-430c-2fee-08dd7b7dd9cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 17:57:41.0969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB10374

Hello there,=0A=
=0A=
Static analyser cppcheck says:=0A=
=0A=
linux-6.15-rc2/drivers/xen/balloon.c:346:24: style: int result is assigned =
to long variable. If the variable is long to avoid loss of information, the=
n you have loss of information. [truncLongCastAssignment]=0A=
=0A=
Source code is=0A=
=0A=
    unsigned long i, size =3D (1 << order);=0A=
=0A=
Maybe better code:=0A=
=0A=
    unsigned long i, size =3D (1UL << order);=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=
=0A=

