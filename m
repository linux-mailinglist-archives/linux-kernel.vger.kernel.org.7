Return-Path: <linux-kernel+bounces-763128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 894AAB210A3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5553A70FE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DF92E7BAD;
	Mon, 11 Aug 2025 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="suAazuzc"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92602E7BA6;
	Mon, 11 Aug 2025 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926593; cv=fail; b=t1KCz5ddc2iK2rgfqDgSnWJ+S4wewG3FuM5O1y/mhBK1NctjxkG6Qs+VV4UcqFZyTv+JFayw0F/C8x9/XUZ1qpr1N/nHcjaBuzRn+WF+xYVhwODdRQ9PenuxCBjS4PIxaxzJc8zEWLTypwPZuHHdrONsnSMNoV8C8c7fGDuZGHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926593; c=relaxed/simple;
	bh=3R0URGHwJRCup1tIcQExw4xq6tJHyXcD7dJTBSXAqIk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D6A55E4Q4YKImyO2qYS9T6jYR4BlWALkcvVQst4aIFUdFKfVagSoiP+fOPAOoz6spWUhuViLS/Uaqea6X4Qq0CWond2tv1NwrO+TXaOKkXzLU10hAfHFsyzI9fM9C13axJ9H9DYehIjnSRa3U8hYkJSYjNYiKXTXfmZq38sA9aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=suAazuzc; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmPWyg7R0hVEZWkeIiy+mIXkCHcQYEC2bMg3E/AVV8xGJE6PH/6RwHS5xTTu2eBnUQk8SC/x91vE9+QeYehmzvuGixq6pJKL/1C08Rlmxg0dpp5PJggAsM9sl2GhN80i22TK52AyeZDIVpKdUuA6NDQekaMrZe3lOm5MMe++6Mr2b5B4XXSVWDy6pucxmOdLsM/0Ds5hasdZRD9peoMo9/X44BRzJlnqgIpjBjtECF+VzZUI9D2HXumtkvFiH7ovibYh51dMiju2oxhwJIXXAkBhlbbeFhcMpmtK+qLp3YEcIBiO9ivCSOPqmjZojlCLd4K7Ej6dm0T4U3aFiYXj9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CC7kQ92Jom3bIF51j9palV0u12im+Fub+FLnrDCKBA=;
 b=GvzbDo892+dZXvBLhrukAu8VrNtb6t5RifXLUcy/rRUZ9r2wcL1CI3IXU8N6rLjlo+XJT3WZ0cgUhYR6U64YCvv7ejV63uDSgiT5p+ZTn42p7L798JCBx10NOr6SAy3I8y2yvgzbRUC64r6UvY1CBG7QHfKlGWE7+4NADRX2IjPqPNLGpAJbyx5ySt2bne6a4EY7Wlt6HcGqaKeOs7HH4bf2nQX4rbSP6CzRTj8yV466Py5C7f4lSJ10CAKxwDm8p82ASjkHbIhQiKWzMjhvzUB0MUbk/YYjSolRqjFJpYe3O5Gg5GiWO3Vvr3X1x/sLkkL9+jWR9UhWND73ZRFZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CC7kQ92Jom3bIF51j9palV0u12im+Fub+FLnrDCKBA=;
 b=suAazuzcuurvWnnoAimfCanLITRapbBFUkWted5Z3ym5Qnv2/KX67yNp/Izi1Ty/PAgFkW6ejCNBPle4kIYpTvIxGls2I2iXCaL9nDbOLor1PKwMokwjDZ6iYGPiGnh8q+45iI7V5AByQsmeH3rfaQ363XTItqKgLkVQX7LdmC4=
Received: from CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 15:36:28 +0000
Received: from CH3PR12MB8726.namprd12.prod.outlook.com
 ([fe80::9532:640e:4b24:7dbe]) by CH3PR12MB8726.namprd12.prod.outlook.com
 ([fe80::9532:640e:4b24:7dbe%6]) with mapi id 15.20.9009.016; Mon, 11 Aug 2025
 15:36:28 +0000
From: "Chary Chennoju, Srikanth" <srikanth.chary-chennoju@amd.com>
To: Alan Stern <stern@rowland.harvard.edu>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
	"m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
	"Chris.Wulff@biamp.com" <Chris.Wulff@biamp.com>, "tiwai@suse.de"
	<tiwai@suse.de>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kalluri,
 Punnaiah Choudary" <punnaiah.choudary.kalluri@amd.com>
Subject: RE: [PATCH 2/3] usb: gadget: f_sourcesink support for maxburst for
 bulk transfers
Thread-Topic: [PATCH 2/3] usb: gadget: f_sourcesink support for maxburst for
 bulk transfers
Thread-Index: AQHb7NiJoa/s1NjXRUqSEvUDsPz1zrQh+q0AgASDaHCAADL2gIAAAz+wgDcdOxA=
Date: Mon, 11 Aug 2025 15:36:28 +0000
Message-ID:
 <CH3PR12MB8726A85B8D425323EDDB96D8B128A@CH3PR12MB8726.namprd12.prod.outlook.com>
References: <20250704114013.3396795-1-srikanth.chary-chennoju@amd.com>
 <20250704114013.3396795-3-srikanth.chary-chennoju@amd.com>
 <cf2940e3-5430-4e84-916b-608c33028a7c@rowland.harvard.edu>
 <CH3PR12MB872633800DDD386DCE8169B6B14FA@CH3PR12MB8726.namprd12.prod.outlook.com>
 <e5f4942f-4a0d-44a6-a2b2-7d567d4d0ddc@rowland.harvard.edu>
 <CH3PR12MB8726F8F10AE2094B5E94861AB14FA@CH3PR12MB8726.namprd12.prod.outlook.com>
In-Reply-To:
 <CH3PR12MB8726F8F10AE2094B5E94861AB14FA@CH3PR12MB8726.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-07T13:56:52.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8726:EE_|SA3PR12MB8045:EE_
x-ms-office365-filtering-correlation-id: ca3bcf5f-5d7e-4f24-c007-08ddd8ecd6b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ChgomvHQiKZz4tde+7qqyfxE1Jm1Ep7iVHhTzr/ER1mKKegPV54e3flTZLib?=
 =?us-ascii?Q?RwAJChOv4ipdbqYvkETXn9BhZ2WjdN7fBfTBhzdaxL7pg5N1ZJMtFT4VUv3G?=
 =?us-ascii?Q?4ZY4S2XpzvfZ51zQS2qpBkro6cStojSjdJYbHTN8axa86YpCcieT1OR4vxzX?=
 =?us-ascii?Q?EcQbLWTlBdYTwh+ciEHjXFlA1EBGfSx5Q4UFNMJIX4POMEuAhbLurj3DyQN/?=
 =?us-ascii?Q?su3DnZwkV/grnvaF7B2QqmWLb4tjwNgx7s0fkqXmqS+gCI4CSTb9/wzmiuvF?=
 =?us-ascii?Q?H4OmqQ9BNwHKVRkDoPEMk36JYSG50hm6pBkbWL/nviV5vvDZLlkTU5mXBaHo?=
 =?us-ascii?Q?2s0LmSzNgjy7B0CayLQMqAdoznrlbi5FKZQPLaGgN6Lb4+8/E3Ypm8mKS2Hg?=
 =?us-ascii?Q?zeBxVL5kJoSd0XJZmOoSW7I+AWZfwV/h6/fvQA9lxrHQ/vYhfbs1K3XRzTaA?=
 =?us-ascii?Q?vPI1tK5E8jCaOXsk2Kxljvhbut1kQw39NrY0M5RYI5NXGq8N/dQwYRu6Uk7x?=
 =?us-ascii?Q?EOicSQXfNtNrgRJYpgbLl5APHVFYAAYymC04YKytgRQHEokfDI7B/5yxfWxb?=
 =?us-ascii?Q?1N0140w0/O5Kcm8V5GyMxzqIGBtpdaYk6GzjMTlBkT/C8PDxUk5I4wIxW+gu?=
 =?us-ascii?Q?sPozfde8cpjSjF1ZqSgoIGbNfLyGNCRCKRDBn2M3I4NjoVcYnVH1RRCGp4Lw?=
 =?us-ascii?Q?wPhKQsHpxQjcws8fwsE1ZxUVzJsDZL19JAiVCCHOn+MRFSbJrEXPdkugGlMr?=
 =?us-ascii?Q?+XxNXT0VkMqoT6J+cCMEndshf+UQgZlcN4qe5F5kxMZsFL9EniS5wtvOcX97?=
 =?us-ascii?Q?mLuYH6+b1noZyDCKvnnggObsPpb/E5Cn1Go6JKXbIFO7NbYslpobS2zIblEa?=
 =?us-ascii?Q?vIKkiUZQl4aUMNgsqTp8TNQG+qtAC75vPQxGPkpsvSzyjkG/15R/waedE3wU?=
 =?us-ascii?Q?I2Rl1u9hWdxmBl1RAz0Nuz3Q6KimfAnBVbwhtH6NKbdHeHCuRJRHU5TMTFc4?=
 =?us-ascii?Q?cnJr2SYe6EjWZT3EKWjzqOp8uqagWS6TrbmVfsGCn4gapCrEVfjsghFZokl/?=
 =?us-ascii?Q?Jl9m8dkLu5EqinNBcAa47SJItJNxl5AoSjq/QovzfIIBMfQM1GZiP8ZsTTnF?=
 =?us-ascii?Q?xJl2cB3hOVnGGZEu6EEQu3ZWz0mJ0d3zxkqMgVkN5DHiIeaE4S5GJIEV0c9W?=
 =?us-ascii?Q?ifaMXndeL8xQS8b4fC+XujUaHCe0XsO2/DFW//YdvOAgysO4n7vQUQBcfkXp?=
 =?us-ascii?Q?c1RRYdRvhoDSf8c53vQZqmSeg+4EU5AV35jj54F0WDViLQwHEomFMsrq2IJc?=
 =?us-ascii?Q?/70shOc0tN+FfWLAoY4VOxQ2q+9oFyJ8bKn0ehrK/40NVXUspvg5M+8nkKNZ?=
 =?us-ascii?Q?fxO5n502TOC7RYlyQkitwk8wZ4TBN99C4WF/gJ5y2ixWF6u67Loxcgrc/KRg?=
 =?us-ascii?Q?PHBGPkJL2QKDuKZ/QfvARg3KLUbxx99RjxNDCQ770krEzMFl/1p8LQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HBbu3i/vkO9j5VXKNPcX0si7GK1TYUcGMGfimcfKQImI2f3Xn2a3oi0aEY7G?=
 =?us-ascii?Q?Dpmtp+G8E6QhEL0ySbWJNGIgb1BVuMmyOLnXOUnTG75zJIYwwTHwkHPM8wL5?=
 =?us-ascii?Q?Atr+GKsxUhNH4DN5v4bRC6BR2Cq+CMSvYhrx/51TRIAhVnDxsnxoYiqO2A1l?=
 =?us-ascii?Q?7pxNxC3EKnioGJS2GAAfTCOxpYjFIC06E556iS7Vf3Igp+a3jsFv4irZfq2I?=
 =?us-ascii?Q?d+39ENyJ627bYAt0XkkpHXoKlDCJ5jTj9ygUSD6J6nsqEqBE3zoyNIULIE5e?=
 =?us-ascii?Q?XT6AGuvQWMtYI9dJ8f70AP8QF+M8QiGuyBKe1w9O3YTAFYuekYxC8I0JntGt?=
 =?us-ascii?Q?lxJ8YZfaDrMTiPjjXEl3mtwA2L43AXyUc6ru9kPkAPI25MWgoRn2D0wxLBOl?=
 =?us-ascii?Q?+aNjQqc5AugxHO6TkCXTtJFOm3XzhOUklyT5FRke8182SDg4uqrG8hT8fNqI?=
 =?us-ascii?Q?e89+v//xVcjK0tTuzJiWHp1/Vq1mUWs6zwfoNlLLdlI8mGV3xsTiN3TH2nRS?=
 =?us-ascii?Q?Dq+PSNOLmgZg0lGUidUs8IetACXPSxSpC5tXcCGUXFb3Zc2qD8pv5e/BRxH7?=
 =?us-ascii?Q?fG2cNtRxv8HZ4iW6X8ie7N9m9ANSXZhNHNRyaEJBK/bFom5GbhJ4DPqQNUux?=
 =?us-ascii?Q?zsKUnJsZ96B78z95pvIz5DfhPVUNJhCjtZFqqqEhwbeST1EqW9g1V2uMdPOF?=
 =?us-ascii?Q?KLOOW+C6UzqN+qlpCAGWThDZoj+60h07yeBBIqt5zdGyRuI58rjTtoL2n7kO?=
 =?us-ascii?Q?1yPkFOoIghI3FOtHDZIOS7eYG142u8LugktB1m+sqzlogd15r4P3xqeLaUK5?=
 =?us-ascii?Q?XCi5jcg5UBQ0ASQal09KsKfaNQrSpgZBRZ6bI6Pv1BC/RzJ+T9Y4JoCErskj?=
 =?us-ascii?Q?whECpu3eYp/xdBcKi9aDAkWpzB1Uuo0lBF5BriZjqvTGki3y919f3j27jkDm?=
 =?us-ascii?Q?RWMtSisHNZE2I/kLQL7lGL6ehFxFyBW/xvCwwuGY+NG2SBSQNLXufiSjoEXu?=
 =?us-ascii?Q?Q5z1GquGadQf3QkhxbnoQdl35//g5qaVt2zXvDlBp/hMFJw4QpZstO6FVbpO?=
 =?us-ascii?Q?MN/sZjqqQU5DuyPHPwdGDxCKpmrdQQ5iynIlD6EyVoKuLPPd5Ii3Aedz/mlg?=
 =?us-ascii?Q?U5/Qeoi7tD6cuApmomV/+OUCpO9lopI8L7adwItdsFnX2Lp5HpqHoSk+M8Uu?=
 =?us-ascii?Q?ju/AWt7ASzlqRUrDXwemmHUY3VnuzhdgGorEDN7RyB5tLIoFEjTbjuPcfM//?=
 =?us-ascii?Q?pjYRdS45RzFPA0FRZIl7mRrqNO94ye9UYjb/JQNt8U8DOdag5a8zip4Y5bcc?=
 =?us-ascii?Q?duMIp522WzCZ3PAcILbvia7KWomB2XtBoSQpMbsIXmp6bUuZUx8tNgrkwzFD?=
 =?us-ascii?Q?LSxQqna2d1W/1YJ97Yg2IVueQgMXfAv/EwZKvBO8G2Ht2HmokDnaPS8DfLIA?=
 =?us-ascii?Q?S/3pCnKssBo09X9PpoJac7br1OEoK/WsMcoAbfZE6PDBVFLkdb0H0wWXIt3T?=
 =?us-ascii?Q?MKJELMLzSrpifQ1FqlF+TsgvJdLrLuAoUoo0JdueixbIF9feCkn6KISNN4lm?=
 =?us-ascii?Q?IQeREd0y03hDCDi1pP8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3bcf5f-5d7e-4f24-c007-08ddd8ecd6b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 15:36:28.2599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xnz7XHXwe1lvzS+AwWfLl3NhArQzF0p0Az+cNV+7mRzhU3GDUtswVXYlW5D9k4IBAbmBZOgHdlVVdatAGOzsWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Stern,

Please let me know if there are any further comments for this patch.

Thanks & Regards,
Srikanth

> -----Original Message-----
> From: Chary Chennoju, Srikanth
> Sent: Monday, July 7, 2025 7:31 PM
> To: Alan Stern <stern@rowland.harvard.edu>
> Cc: gregkh@linuxfoundation.org; Thinh.Nguyen@synopsys.com;
> m.grzeschik@pengutronix.de; Chris.Wulff@biamp.com; tiwai@suse.de; linux-
> usb@vger.kernel.org; linux-kernel@vger.kernel.org; Kalluri, Punnaiah
> Choudary <punnaiah.choudary.kalluri@amd.com>
> Subject: RE: [PATCH 2/3] usb: gadget: f_sourcesink support for maxburst f=
or
> bulk transfers
>
> Hi Stern,
>
> Agreed. I can remove the comment as I have added the check for the value
> based on user input.
>
> Regards,
> Srikanth
>
> > -----Original Message-----
> > From: Alan Stern <stern@rowland.harvard.edu>
> > Sent: Monday, July 7, 2025 7:15 PM
> > To: Chary Chennoju, Srikanth <srikanth.chary-chennoju@amd.com>
> > Cc: gregkh@linuxfoundation.org; Thinh.Nguyen@synopsys.com;
> > m.grzeschik@pengutronix.de; Chris.Wulff@biamp.com; tiwai@suse.de;
> > linux- usb@vger.kernel.org; linux-kernel@vger.kernel.org; Kalluri,
> > Punnaiah Choudary <punnaiah.choudary.kalluri@amd.com>
> > Subject: Re: [PATCH 2/3] usb: gadget: f_sourcesink support for
> > maxburst for bulk transfers
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > On Mon, Jul 07, 2025 at 10:49:26AM +0000, Chary Chennoju, Srikanth
> wrote:
> > > [AMD Official Use Only - AMD Internal Distribution Only]
> > >
> > > Hi Stern,
> > >
> > > Thanks for your comments. If you are mentioning to have a check for
> > > the
> > value which user is providing, then there is a check which is carried
> > out(#34 to #37 in the patch). It limits to max burst value if user
> > exceeds the supported value.
> >
> > > > > +     /*
> > > > > +      * Fill in the SS bulk descriptors from the module paramete=
rs.
> > > > > +      * We assume that the user knows what they are doing and wo=
n't
> > > > > +      * give parameters that their UDC doesn't support.
> > > > > +      */
> >
> > In that case this comment is wrong, isn't it?  You don't assume that
> > the user knows what they are doing; you do check and limit the value
> > to maxburst if the user's value is too big.
> >
> > Alan Stern

