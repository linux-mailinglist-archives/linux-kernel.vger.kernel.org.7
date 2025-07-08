Return-Path: <linux-kernel+bounces-720939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C27EAFC253
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30F61AA3A20
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC0121CC6A;
	Tue,  8 Jul 2025 06:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b="ahEcdlyz"
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F8D21B9E7
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 06:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.152.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751954408; cv=fail; b=AmqC5aAfxjNu1i1Fnhm6C6wlj/u+cL4zAhW/iwcTrJFWUGkfCfkh9lpiKKHgMYjAIxkd4KeGB2lvn0JSl901f1c7WhQmIrLH2qYHBQI8pZ1L2FwF5iX5jrbobJRypjhu/roC+hkMJ1of2oBSXDBEE9zw0u9I6YWK/aotIopxBOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751954408; c=relaxed/simple;
	bh=CekWdWV2VkViXP06SKIHQ+7STrJTe0rV3f5F3VGAwTY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=svEx5Q/fo7qqVUwHbEN7WM/UMZXBJ6vLVXBa1kknJO3Pj8WDghTOquu/5A4Ql+UVKtinmTeboWz2SqjYwsjFqSLb3nCVB3AK20wtOPrf2qUoiuESf7y1KR/uivfkBQ17ZZnowV27DvUBBACxse0wcxv48Yqitigx6hu6Tox0nj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenovo.com; spf=pass smtp.mailfrom=lenovo.com; dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b=ahEcdlyz; arc=fail smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenovo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenovo.com
Received: from pps.filterd (m0355090.ppops.net [127.0.0.1])
	by m0355090.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 5681NtqM019508;
	Tue, 8 Jul 2025 05:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM202306;
	 bh=uWcmgiK6rkvGcwbyKYowKWGJvtC2twz339x5jvbBL8I=; b=ahEcdlyzSIBp
	QosLZqIECiUqHlDPe673QG8IctGVBbKHyzJkwdBncFawDR/D9HQEChWNB/gudKXj
	83AucPARvfFywPR22RNQQ/5CezoNYI6PWqBrjdQD3XIij/GEWDHjO2/+tJPf41YI
	2KlxqjATGA6gjhThhlSFN/7d8Tb5f0QsbGXlTK/lD8VHYgxlShv6bBP8FxGTn8B5
	rzonFeZKEw3LJQ9/dJwGv9+LJzBlQowSKJhTOGyYDoScueSTCa+C5hjQ04U1dqsO
	CXPlr9yi1dG1SA2N/FpxZM0VASARzkKnN5x1v07q1yOULo8WC3O+5xTz5PQteJ1N
	anXLKRqvEQ==
Received: from tpzp295cu002.outbound.protection.outlook.com (mail-taiwannorthazon11011017.outbound.protection.outlook.com [52.101.110.17])
	by m0355090.ppops.net (PPS) with ESMTPS id 47qfcuvb3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 05:59:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIbhDYmm7XGWGQhgVqZA5hkt/hhmawJoIT3eG1HcpRQSn478W/0H94HSi2qQjS/+mNNwN5fptyYi8ewuKe5XjMcDnXSsaBZSC2S1h+HxDADhqjmL/ZACN0Jt4sorVftPSgq8JuggEgr5FnOf9AdzFhH1DinlmHaqqoz2N04hiom7E8n3OfNOrOLJqdfLkoLZdB1PyI34WdN4av4R46yQnoLTGmcHm9eykb38pBH+to2lpOjlP5YB5pambQWRxtawz5ebiqeaLJBNVj+tS+iYHHDMXSzb46FpRFvip1RhTkEXhl/PSgVB0aU6NWFcz/0InAiUL47KHbhm61uOuhesng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWcmgiK6rkvGcwbyKYowKWGJvtC2twz339x5jvbBL8I=;
 b=SBaHNvVTtNxRZ40Dd4EVtyxHHcE1UnWI0TLSh3DiyigzTawSGEAlatG1z2P/vXIxHCyuBYg63kfhDYW4QVBM4Jo5FL71Zlsp7ju+IeOthOacSkcSNyMvz7kMKr+LunuC9wNzCfNqTwGOZmDfgXb6tejNHS0MNguBCcBPzCNaoXZGsUqjpJMVs+yArvnIpmzCgHhXLlSnCtQ/cIChd80FMQ6LLdE81NGeaKauTqxwWPqnNt7/XXUxdX9pUOKt594XXJOlTg8IIoed7IbunjWOMV2xZ3qjAZPFrzizdQY90PxhznjobGlzcKo0f8n0CqnYZZU2W4rxwrCbY/XwQiZ7CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:b::13) by
 TPZP295MB0107.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.27; Tue, 8 Jul 2025 05:59:40 +0000
Received: from TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM
 ([fe80::b:a419:4f28:8c1c]) by TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM
 ([fe80::b:a419:4f28:8c1c%6]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 05:59:40 +0000
From: Adrian Huang12 <ahuang12@lenovo.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "linux-mm@kvack.org"
	<linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC: Michal Hocko <mhocko@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>
Subject: RE: [External] [RFC 1/7] lib/test_vmalloc: Add non-block-alloc-test
 case
Thread-Topic: [External] [RFC 1/7] lib/test_vmalloc: Add non-block-alloc-test
 case
Thread-Index: AQHb7PftKoF7kKL//0awl/f4hWFasLQm3ACw
Date: Tue, 8 Jul 2025 05:59:40 +0000
Message-ID:
 <TPZP295MB00136CCFA28CEAAF7E11B840B34EA@TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM>
References: <20250704152537.55724-1-urezki@gmail.com>
 <20250704152537.55724-2-urezki@gmail.com>
In-Reply-To: <20250704152537.55724-2-urezki@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TPZP295MB0013:EE_|TPZP295MB0107:EE_
x-ms-office365-filtering-correlation-id: 02efd913-0374-4cc0-b136-08ddbde4a0ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2BO2xANc4soPtbCB5b+YMli71QDqu1D3fKrQTaJRsmYLUQhNG/LoVaxETJk9?=
 =?us-ascii?Q?WzJdS5HWuA36hhRx0z/2MhT56RV+LYPe5uBUqjQyB2rP/z80emc9DN2k+MWd?=
 =?us-ascii?Q?yRz9PyueGxeFCd6ezHXo1a2ggl6dgl1XOvYampSxuGCWVPrnVPDzhw3gdDaD?=
 =?us-ascii?Q?AGXinwNzhMi7QkmDpyarptZKwJFTQrOk3ec2fYVjrQaUd28c3KxJXAe1MoNk?=
 =?us-ascii?Q?snsfroGWJ4+NDlcqJVYFtYDkCpOvwt/4ZArfHHDERLGQaG64G3jRHT3Wpc//?=
 =?us-ascii?Q?iTMVCyaCIjum0vig52+uR15EL5aDgRVUC71YPIGZbou5rmao3OTOqf9xr56V?=
 =?us-ascii?Q?DGzhl9L125j+qqPoKSzdXMWqbXPOuugpEkXNKrsJybJR0DxOzJxAhMX4ZwUs?=
 =?us-ascii?Q?I9AuORxPe56jGWvZRnEcWfFRjR6jbWkEtAhGyIvnDedGb+RCidl01Y8oKCb+?=
 =?us-ascii?Q?BH5W9nebDZ5i+zjddDS044EBmjhErFvZrlqETYBhSgHXwiYsthpbc6T4LVx7?=
 =?us-ascii?Q?NN2v6Tu74kpLZbZtePQDeRw4CamWXp1FY3QmrevINEA2b6TmKbnFrn0Sctt6?=
 =?us-ascii?Q?5tC4ireYhBggf0kIbPwC78DYTb+CYEPsfbctjGyasw/6yreMfVMZZQWKZmWL?=
 =?us-ascii?Q?VOAsF3jhm6RrurA0NfxpBJFLfTP7ZIOqZwgIO9DDn3WLG51QgstHMLAdorRJ?=
 =?us-ascii?Q?Y//jyM5RyVggQQLVUmXAwZHxaaKm38WjxhHUWbJR2L1ziONdRi7a7tjovPLH?=
 =?us-ascii?Q?DjQ/1+f1/z9WfSDiZx8BZd7GgkF3O4GaYDpw7j0L4JapHVA6awGMsnOxwWn2?=
 =?us-ascii?Q?AiAUEZxhFi4tOPfCwML291rfyD4+QOOHbMsspg1fz1w1zO3KADsgqZhHyCnY?=
 =?us-ascii?Q?fCWoMHRMY6rR3WhAhcgOsgm74AYcprB/egNnmTyEuVeV5IG0vMrldVvHCpQL?=
 =?us-ascii?Q?llDqdzUlx5QAWKIAuU2wglenCc6CN7e2jA3byJcwV2kJa0SFAEjJm1BFLY/v?=
 =?us-ascii?Q?mthwtmlzx9eAfOrA3wjh9VO9/pM8ONWsDLBXd4ID32aIhNqu5EOUUpcSUTqV?=
 =?us-ascii?Q?m8Dqt24uDr+lfkFDaitih4qwRJhVmkmIGP2LcAkJ0GC6szClm84xXSCJO7qB?=
 =?us-ascii?Q?Rp16E+omEyx4gpiOnFmPXB3b9ZICsvqyFsAHXTwnovbQKhwOiNlaU2L4HPF4?=
 =?us-ascii?Q?laWGirj3Vf1gzq7Hjd1dZ6ggeMWKWKe8geuZZQYfH0UK+NqP5qiiJVmATE7p?=
 =?us-ascii?Q?tU9+i1yqJ0Xfugk8gBhIV53rK4laAFifp3U7qGvyZkhlrHMGjYJDYXM3SsJo?=
 =?us-ascii?Q?ENpsQxDLbSCocllCY6rd2A5Ub42hQTgFkpWr/akx46Dk9/lodpJKtCdyk0Wm?=
 =?us-ascii?Q?VICBjTRJ3HP641feSMdA9X2pb/WSMmsPlijew+g2giS8kZ3abiSTEqSdcBA6?=
 =?us-ascii?Q?c8he3nhckpyDnq5DDgEjae2mgZ3X/kUcA9QyWB2gr6spBpUTpslDrw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JrZ+g8IhwuVA946L43kDlz4QNCIHjihj6VF+5tQARXVZwaEsAeXcgpJ1xxvN?=
 =?us-ascii?Q?dNjtyKLLTls6bhiiAN64qMusKs7e2W7QLO60ZMkPGmWNdphWQ4EXTPha/3i9?=
 =?us-ascii?Q?iHdrnhdZAjKK5SRqfXuHVGfEnyS1+0//g7x0v+ZfN52TKEzz985e4aQIG0vo?=
 =?us-ascii?Q?U5S9LqFGUd6QOpHO2CB+ulfGvWMdut+sTbKV6GdQfUvaKretBh9/DQJ1NRWp?=
 =?us-ascii?Q?vXchh2Ey9INPl1a2e9L0NufwIUzqiuHDWGc6ZUMLCeofXWNKvqN5/i8bqgTA?=
 =?us-ascii?Q?1hXQAPaFdF1rtjpOeZf50gLfWBuybe2RqPIZqIDe6fO3A9sF8BAFXhCeRUuA?=
 =?us-ascii?Q?pM3LEYqcmyJKytwQzKPAoJf1dSB099FE5z/h2PBT+oQxJOaf0mIY1zDqO091?=
 =?us-ascii?Q?gz4deXi3yBcNHsR5QrGafjEzT9PH4Sxtf/kcgP9PXHjvdZiZKF718mYUyUlv?=
 =?us-ascii?Q?mbG0VH2VVZMrClkw4si9BBoBl29zXjrwmYIHjOmBollPpMJk3YLa9r7uSCV9?=
 =?us-ascii?Q?dy9yw/zVvmxGrWZMajxf0czTFfqQPe3pGqzt2kjczQDEcMF3R8FkemCNdxCf?=
 =?us-ascii?Q?HVBq1WxL92Zo3pmzPrMtnd5EnJmM6KAArXgkN509RYPZY66ISJo8TGocX1wP?=
 =?us-ascii?Q?46k8lYr2rvNcVvftoJi8QNl6lBJvR6vQOBiKA8D2PzBcTCgPpYgA+fbJD0J1?=
 =?us-ascii?Q?D7O/vb4BgvbZn2yBNLKv9pail9bI7emxe1KU/IT4n4XO9AWcEvIGn3SNtgbG?=
 =?us-ascii?Q?BO7z2Mtyvqx6q0EeenwTogVgvgm76oja723AcUad7ryOFkTe0v6Pu2+oY5d8?=
 =?us-ascii?Q?sty4qZKMcRs/pzSxvw7UKGUUnEcOZs70O725xNqeKOGJ0p4fXbwK4e8UIjBk?=
 =?us-ascii?Q?bVlAOaMollAZeTQyMPtRFUXKSND3zgPkFTLIAen5KThxa7lBJJItoGc9xfa1?=
 =?us-ascii?Q?L9kbQ6X1UigAKdsDQNphhC7fXSok72l+w4KNyDdeXtT50n7qLSUj5beN+27Q?=
 =?us-ascii?Q?vUWpUqXME/xJqxpo5od/3K/co1PEuZt0bZEvYFClkiCQveHgqNfFKdatXdN0?=
 =?us-ascii?Q?mI+lVDpxwxRTxATCdmloprrhRMJyfqRd/mz63+QVAYYaI/39GFcEPF0m+RTO?=
 =?us-ascii?Q?DKfiId2v8o9CFAzvb6PGGLqTN1K9f2SVvp4vQfG9mjT0P0CebrtxgfHKOuTt?=
 =?us-ascii?Q?aY/rOZRqrYSvYFCNaOwVQhMYXJvUYCu+RE9jP7OJ3ISa39mZdZduTFG9RZS1?=
 =?us-ascii?Q?WrK42T6M1hjgwyGjoJNu+BIaKBasV81vi7RVDTU7e9ZkKGInqmENQz7ng4vk?=
 =?us-ascii?Q?bEWSi8IlH3cCQhgRNBQ1D3d4r6gqwEoN3n5ZqC0VRttjGWaVfdl8hZcFSHan?=
 =?us-ascii?Q?Fl/xl4t4OpzhH7HGxF6M+yKqoBMWguXId65eTCqcHkv4Iq+gcCkdHfpUlvGn?=
 =?us-ascii?Q?fKX1Arn8hh15xKv0MUCh5+YLvpmGmJTHwCChJZnNjSxZyVl9ytrq1jfvmWtm?=
 =?us-ascii?Q?uVCaWOaphXwf7JS0JS43C9I+7bsiE1HTsMY7RPIiMQMfb4BtL0aWnqEFQh/N?=
 =?us-ascii?Q?7o5arpjFyhcDT7EHSwJHXj2B0DhD5dFAmNmpho0e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 02efd913-0374-4cc0-b136-08ddbde4a0ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 05:59:40.7243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bONnObFJsgYlAZZA4tmuA7EjqaAkAeSZVAQ5kacxu/PDCbrmMEcAyjQD04CKBeo/nlCWc7uDYF60PiM4JvNRjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TPZP295MB0107
X-Authority-Analysis: v=2.4 cv=cavSrmDM c=1 sm=1 tr=0 ts=686cb3d4 cx=c_pps
 a=EWtV4QoBu8THM1s5R2pDnQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=37rDS-QxAAAA:8
 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8
 a=ml1uu-TMNYdvKuYtCJIA:9 a=CjuIK1q_8ugA:10 a=k1Nq6YrhK2t884LQW06G:22
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA0NiBTYWx0ZWRfX8xB8ZwaDT3Nw
 rjjjDPoTTFSZPNBswevIEGIWg6T3SLIipCtx61o9xsdoIG+AE17qOl+2boCAsbskklWRZtNdwNw
 68o/bgOPsZ/GmaHJe6FWoUOwwVlRPxU71DLDCg5oWn7trpHDnuqZYigYCAWRsEHehy2AWEKTfqB
 g28bQckGBV2kqO3YQpXe9NclAtKpq/aK3VG3eB7FVks+DC38ph9p7is9VznJYBLfl84scFNJvAu
 i3PP7v6Sz1H/zx1CrgGeWWR7AF9nJVR0HbZImvh8r5bQDEFR+xihStPz6yEYD4muVU/j903kjOL
 2tZbFAoCVp3QMM+mNnjkh9rEFtc8rj2YWV3A0c7BCpC/o452pzoMQ/L9csYP9jwgkZ0qeA0LLiL
 2VROPh8+p7/Z5pHMSFH9SxqUknuolELMUpN1tK/s1kOFNLojdPom3zCfNiCBXK8Tvoe6hId+
X-Proofpoint-ORIG-GUID: ubhFgaG8_bu2y-gOzoKMPnNy08Ok236L
X-Proofpoint-GUID: ubhFgaG8_bu2y-gOzoKMPnNy08Ok236L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_01,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1011 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=-20 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080046

Hi Uladzislau,

> -----Original Message-----
> From: owner-linux-mm@kvack.org <owner-linux-mm@kvack.org> On Behalf
> Of Uladzislau Rezki (Sony)
> Sent: Friday, July 4, 2025 11:26 PM
> To: linux-mm@kvack.org; Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>; LKML
> <linux-kernel@vger.kernel.org>; Baoquan He <bhe@redhat.com>; Uladzislau
> Rezki <urezki@gmail.com>
> Subject: [External] [RFC 1/7] lib/test_vmalloc: Add non-block-alloc-test =
case
>=20
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  lib/test_vmalloc.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c index
> 1b0b59549aaf..9e3429dfe176 100644
> --- a/lib/test_vmalloc.c
> +++ b/lib/test_vmalloc.c
> @@ -54,6 +54,7 @@ __param(int, run_test_mask, INT_MAX,
>  		"\t\tid: 256,  name: kvfree_rcu_1_arg_vmalloc_test\n"
>  		"\t\tid: 512,  name: kvfree_rcu_2_arg_vmalloc_test\n"
>  		"\t\tid: 1024, name: vm_map_ram_test\n"
> +		"\t\tid: 2048, name: no_block_alloc_test\n"
>  		/* Add a new test case description here. */  );
>=20
> @@ -283,6 +284,31 @@ static int fix_size_alloc_test(void)
>  	return 0;
>  }
>=20
> +static DEFINE_SPINLOCK(no_block_alloc_lock);
> +
> +static int no_block_alloc_test(void)
> +{
> +	void *ptr;
> +	u8 rnd;
> +	int i;
> +
> +	for (i =3D 0; i < test_loop_count; i++) {
> +		rnd =3D get_random_u8();
> +
> +		spin_lock(&no_block_alloc_lock);

Since there is no shared data to be protected, do we need this lock for ser=
ialization? Any concerns?

It spent 18 minutes for this test (256-core server):
  # time modprobe test_vmalloc nr_threads=3D$(nproc) run_test_mask=3D0x800
  real    18m6.099s
  user    0m0.002s
  sys     0m4.555s

Without the lock, it spent 41 seconds (Have run for 300+ tests without any =
failure: 256-core server):
  # time modprobe test_vmalloc nr_threads=3D$(nproc) run_test_mask=3D0x800
  real    0m41.367s
  user    0m0.003s
  sys     0m5.758s

Would it be better to run this test concurrently? That said, it can also ve=
rify the scalability problem when the number of CPUs grow.=20

> +		ptr =3D __vmalloc(PAGE_SIZE, (rnd % 2) ? GFP_NOWAIT :
> GFP_ATOMIC);
> +		spin_unlock(&no_block_alloc_lock);
> +
> +		if (!ptr)
> +			return -1;
> +
> +		*((__u8 *)ptr) =3D 0;
> +		vfree(ptr);
> +	}
> +
> +	return 0;
> +}
> +
>  static int
>  pcpu_alloc_test(void)
>  {
> @@ -410,6 +436,7 @@ static struct test_case_desc test_case_array[] =3D {
>  	{ "kvfree_rcu_1_arg_vmalloc_test", kvfree_rcu_1_arg_vmalloc_test },
>  	{ "kvfree_rcu_2_arg_vmalloc_test", kvfree_rcu_2_arg_vmalloc_test },
>  	{ "vm_map_ram_test", vm_map_ram_test },
> +	{ "no_block_alloc_test", no_block_alloc_test },
>  	/* Add a new test case here. */
>  };
>=20
> --
> 2.39.5
>=20


