Return-Path: <linux-kernel+bounces-751084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6731B1651A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297D31891B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93B52DCF71;
	Wed, 30 Jul 2025 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="HGcNDAY+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="MomZ1WM5"
Received: from mx0a-00273201.pphosted.com (mx0a-00273201.pphosted.com [208.84.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1E518C928;
	Wed, 30 Jul 2025 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753894959; cv=fail; b=ep8aTl1h+KpQnKUEQ7LwFO3Jd+l03WWvrPs5v5iLqXVo0oQidPeWbCTNrsMMcDNPVmtgOteY66NYp5qTInJNN401bPdlRYh/8vHwuEEn6xxkhl5HN6fUj63uNLQOm9p6eRqfinPLQCJwrudzPGtwRGbDy3/rK8t18en9RnCoh1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753894959; c=relaxed/simple;
	bh=9N0n65y2gTu4OhEYAZz+xg4a2plEqL//98TVxBY4t/A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PTLMD9lQ8o397x7dCdoJFNo2igfhlbk+IxHX3o5Ge/sKESuPwNvtEEVCOjudc6E2pGtLwSJeUlvo50LyS42IHohWB+6lFdmKicgUi7gOil9wJPSDiudgxiIjvETWig+VSBDv6wp/40op3qqKGRrY9T+tlEMBztP7NSuwrT9lyIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=HGcNDAY+; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=MomZ1WM5 reason="key not found in DNS"; arc=fail smtp.client-ip=208.84.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108156.ppops.net [127.0.0.1])
	by mx0a-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UEK5BH025278;
	Wed, 30 Jul 2025 10:02:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=vGSbp1RAaiUTW5E3xBI2HKkhmUN1VrB/8UZoYfEGmOw=; b=HGcN
	DAY+5RFEBqWnye/yJOggPmmI3cgEeG8p9mbdBf89pc70LMAOomerCKxkV669N0vd
	EBTykKdykehTKvK7GbCGtS735LyDaWzGRtOsuugPKHm8CgNuE7XH9/56K7Gt0zq+
	a1/H3pyzjF111wB0MbQRiN5bAm/uZvRbVh1plkFNzawpOcJzMVYqm0/pINhjpDDF
	7RaO0Rd/nvyc2jq/YadI+noeoyuEZ3XSfyyraSZF+gnBeSpXBcYW+RA6tJ4lfKER
	Us2qXroi5/a11jdJtPTJm5aBVE3HMfnxVmdNr14WH9+5olGESwCj+LKnPWKH/r0b
	Ml1aZ+DnYNUlLI8eog==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020117.outbound.protection.outlook.com [52.101.56.117])
	by mx0a-00273201.pphosted.com (PPS) with ESMTPS id 487jreguk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 10:02:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpCQFQYeGjra97EnFXWt2EK1Y1AnZBHE1ZkfNdEt0uWp9gWJYODVdAbGaiFRImqZa+i+2JWgHGYRfe7oMUfJ7yG71ldXglk3KEvFWKV6+o1Neo+EFA5ODGguEyLEWCoZ2QwRlwSqcLVO/4spYCHDGvawSgQE3KCMgFa+EVSgNOfua/7SfWda1dW4ir8ye92OedJb9QVLHUA9gLnVLPImVxi2vau+FxC3i7O8meiQ39SAkXpsubpcREpq59WoeuQ4aG3YGSpKKoMMC9OX6KgOdXBaLTteDyHUNFtRt/+q0T45fpGI5SbIFhXaGsj3eiEhfZw4BDNOaikUHwdrnP7B4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGSbp1RAaiUTW5E3xBI2HKkhmUN1VrB/8UZoYfEGmOw=;
 b=a0VBbZdcrlpSjqdFhvQ4XWo0TIqivLEoX+09ISEXuErFLUky9wGEz3Y/QEQFJvgzxFnk7w2F5CdpbJhB4LanB/rjQ2A6/qDBI/zBuXhv+qhFALkvUCviD2Eiwgn4wtMNCm06Z7jUFdcnW/wamfhN04J+usvB1RIxmS41DQT2/NKhIceZa/YzHNDh8hexsLh20mZrcMagfbP5u35gAN5i4RVogXObtH7BVFQcssXirsRGZGWNccccZaKqIvOcAb6lOFUDTBnszT83j5rSEhUpPJIWpFtxM7y/lyEM7aNT94mbkiHNDQyFJDKfLAaNVSdfgFYIGyTzEEbSGtDKToQRNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGSbp1RAaiUTW5E3xBI2HKkhmUN1VrB/8UZoYfEGmOw=;
 b=MomZ1WM5GSoLOrfjmvtN0EWrSvQknIxpThuh9yQtU20ydx3q/Oa2SZewPU/fzErCI/LVgKPm03jtxMeAcUaI6oFw25OAElL3hCkpEUUZdXXBA+s9MuvlNZshJHUGyQ+LnJXBSHbAruWgnMOUMQx2yrGh/q/Y1MC485Q8vrT5sY0=
Received: from DS7PR05MB7288.namprd05.prod.outlook.com (2603:10b6:5:2cf::10)
 by PH0PR05MB8105.namprd05.prod.outlook.com (2603:10b6:510:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 17:02:08 +0000
Received: from DS7PR05MB7288.namprd05.prod.outlook.com
 ([fe80::d1a4:ed92:eb4d:8b24]) by DS7PR05MB7288.namprd05.prod.outlook.com
 ([fe80::d1a4:ed92:eb4d:8b24%4]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 17:02:08 +0000
From: Brian Mak <makb@juniper.net>
To: Dave Young <dyoung@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Rob Herring <robh@kernel.org>, Saravana Kannan
	<saravanak@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] x86/kexec: Carry forward the boot DTB on kexec
Thread-Topic: [PATCH RESEND] x86/kexec: Carry forward the boot DTB on kexec
Thread-Index: AQHcALW+ZQjjgT9X7kW+00L4/dZ7pbRKRqWAgACfQIA=
Date: Wed, 30 Jul 2025 17:02:08 +0000
Message-ID: <14D2606C-3492-4A32-A55D-428F1ADA9327@juniper.net>
References: <20250729182142.4875-1-makb@juniper.net>
 <aInKb8qr689ytM41@darkstar.users.ipa.redhat.com>
In-Reply-To: <aInKb8qr689ytM41@darkstar.users.ipa.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR05MB7288:EE_|PH0PR05MB8105:EE_
x-ms-office365-filtering-correlation-id: 9998f622-426d-458e-6383-08ddcf8ad15b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UkBrQB9daz+08avJ1Nqhbe0fyHxM8UYknX+ttlga9VoZJcq+jYwHKgLamdeR?=
 =?us-ascii?Q?fVYM0P0OdlYbBryCNz46jRSNR1QDihMEROgKaGpOrfOJAjuQv3ZasmUQCEAp?=
 =?us-ascii?Q?yKrIIy0S+wgaCdx0rrjvobR5MZisvGpXQxToF34c94G6efKIMOfQ8zTzdBTG?=
 =?us-ascii?Q?F8C53zhplV1a23cy8b/FUKjyT7kzlS1yAz2X9ThtnB8lulNRyffLSdPFFkxL?=
 =?us-ascii?Q?tOKJwRAe17ITpfwpV4+JzzbrLKszNA0Ubj9dAZrhuE4PiF9yuFuysS9hr43X?=
 =?us-ascii?Q?PO03F7gkKWvz4pxUirZn4xR+FpsDqVMEP49q8DunV7kV7uzqXlLsq/+9vkVm?=
 =?us-ascii?Q?Imxt+mRW83ijwQqdECeqQT8Zx3Ijm9hP/tmj3vonekMnmx8FNwLCCVSXvRKU?=
 =?us-ascii?Q?sJZ3FbFEZvp2KPlDrRXBxdOBA8Y41l1fvMaEwLePZ4ilRE7CaH7raxI6Wwka?=
 =?us-ascii?Q?T58OzmArALM7hPMWy6zy0RC8lc6n9WAir1Hu7lvIf/rpGexzzeHs5pGNqGcn?=
 =?us-ascii?Q?SfahT83YdOMlFbcG7lCI/uIbhw562s/sFurXSxnDpb0fqJz5pqcCvwCgkwO0?=
 =?us-ascii?Q?DN3L4zFV1RcEPhJRH96wguH0cni47e++MkxNs16PzQG4rZNRKbZo9/TMGINt?=
 =?us-ascii?Q?pDAnpPSfs0F3GFvwOGIOD82Xn5w4HaNn86EDJGd+vIMc3aL703Bx7zCR7Qh6?=
 =?us-ascii?Q?NW6TaKKaiTmbvQTQjIyuvyksh7IydTPVmYufyZKlH1k3xc3LZ0mJbRMQDaD5?=
 =?us-ascii?Q?SJwbMtDaQXfYHWmGvHIrTzCP9l73HQf9Cjy4Q1eJA04N04VBcqZNncARf5ku?=
 =?us-ascii?Q?yowVFR1+UHjRniWXTgIkUq+pk9aSJeAcONiaHUN7OJwf8jy6z77bDlBubG2x?=
 =?us-ascii?Q?/61D56MBCXSqCDoq4/MUm1zs+bCFKy7CLDMWHHi105SxBEUfBxYjHA6lc9o/?=
 =?us-ascii?Q?bYxZI/Hc/5itCoCcEKPHIlHFHk09VM99oK8HKN/tRtQBDNcoOFv3XYKKCn9r?=
 =?us-ascii?Q?ngvCJhxI7QLPyF2iiFSf6/EoOAVkXdYXgiUiU2u4KB57pV8GIKxz86gZPQP+?=
 =?us-ascii?Q?H1I4Pfjc9JCQXvxhYPtAf0nQBIxe0KWr6RR1eo6lxLdrQeRsf4VxwdmkF9CZ?=
 =?us-ascii?Q?rt8/P4beDMachbz1UkSzsfDxSdIji3XFDy0VK9qzQzJbUjJuTVg0czacg4vI?=
 =?us-ascii?Q?l8f9Q8V+s6FZ9V+asKHtvNWONedOa/e8PbFcobqzc5/skzxUP5bp3tEobnVM?=
 =?us-ascii?Q?ZUfDHvlUFHnE13HB7ykNx2sV9j2csSiYl3zZ92XL7ezRGaOaHzZ2t4dKEgok?=
 =?us-ascii?Q?1QDTnGtWCTElEQeJcSbnoLhfQDR4e9OcrNAOG+4RmtFJ+VqNoVoJz8gHoT9s?=
 =?us-ascii?Q?WkBK8+kymeIdrhxJWpXU8X6L9yx/6F1fIGxn2Pzzazhx85FEjgYkOenzM2Xm?=
 =?us-ascii?Q?WIelyHn0wTMS6r5lz2vUQxUB7d6YCiMW4UVTB+dMlUYy2FkgQpwgEg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR05MB7288.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/vtA6cC+fXmFlOdFjEEhUFNfzLt7gAwDhZ68HogRKdIfYBKKxT8w8npZoR+v?=
 =?us-ascii?Q?IIjEoLV9jKZJUBz2di8Gbve8ueY+z12Lks/bHfELxa5Cyi0uQF2vNGy5CHgh?=
 =?us-ascii?Q?kbNqFyLLkrzrSd7dJfKmGk3StEeqblcxTsnFj9gu3iLRYCaTtuz5yqyCPW4S?=
 =?us-ascii?Q?vOLvfUXtDAJx5BbeHDpsh3pxiB2ADilkBK/ivGUPuI9MaAx4c3xms/rHF91s?=
 =?us-ascii?Q?MR3mlGHMCE68xxxTcPa/B6F91SAEk5qDVx86HD96FIfvyq2a7aS7TVKg8Tku?=
 =?us-ascii?Q?nTdjb/5b84KLbyq6jurIhky8YFH7kQY/Zeiez5GEepuqZ+nE+RBxn3U2iz+V?=
 =?us-ascii?Q?ni2A4JSRMOPikpPq/ynWZFqrKCG/Jhtx9bdbIcdSNAdEVp8zMUqBc41rKwCj?=
 =?us-ascii?Q?TdB8L8Bu7ptsfUjdTq7LXOmc8xFcj5RxsdSZ//YL4fNNsuC0vtdPRUKzewaW?=
 =?us-ascii?Q?aFJuaAaMlHOpboLmmw1bw88pe0vTLMxhT4JHABtgsVCrq7PuvLXKbl/T+wCR?=
 =?us-ascii?Q?H8ewob44lLIrjBitSzOwLQD07iNSYPwzj5GJXzexiXsZ3V9UcnjwRNxHwCCz?=
 =?us-ascii?Q?YVTmJ7e7VfeH/ndtFQ1dWM0GuA7V47PrGz1nmaQivj0969/4S80FNmkw5Spz?=
 =?us-ascii?Q?6LBSYqF8JOOXsxoexmLqrh6L3++ON//LxfHydJGlH+bgY3xHXZbUmtMj3lmh?=
 =?us-ascii?Q?dTepVVYfLe6ijeMv+iG54US28o9vGMQ+hmGBYxY+8t/FD1ZcqSPH6djLNhMZ?=
 =?us-ascii?Q?jdtL0bHM9IkFyAbx7vAenYg9YnzYoPeMkOf+q8nkIm1G0jiVzUtb7z/KO07Q?=
 =?us-ascii?Q?JqV+YrIQRhk1MTwDFV6Ov9kosYXgJPtZuGQLS+gE2J/JYaGXdTM1NuyibOJR?=
 =?us-ascii?Q?baUXRI4L+dHS2iN1SRBqfL9F3povaiWaoCOPz4x3nGFoX7BGg32z01SNaQWI?=
 =?us-ascii?Q?FxGCuLRWubnaeE/Xk04tcIfqphrpjQaS1jWdf9H3yOd4Uyb/WlZbQhNYjxN4?=
 =?us-ascii?Q?w1/c7D753iWHDtfBJjvgFoTQB6FFnVe5g0tPmJXXgVQCCRbIlj69Ns1RPOaj?=
 =?us-ascii?Q?9pVZirLRVpCsL3SSla9rEq3GkLEyLRdNHX6YTPqGYxB97orZm0M2z/qra07y?=
 =?us-ascii?Q?bHWnNLk7bsSNvGodpc+wvSQbBgFtPt9i5i5M+/VW3kWDn82r0z7s3IF9yWLV?=
 =?us-ascii?Q?lvJQ3MDwUoSqoai1BrSQBewBfQ0C45Lf97yZyoLbu1CXGoDdTA8iLNRM3VIh?=
 =?us-ascii?Q?/Z+m9HxaECdvTVXeZxodYKUwlAqDv+Xb1b03BD8jhEtzzB8147up7zcnKf52?=
 =?us-ascii?Q?mplB99ktoDHGA+yI7n01YbnGad9tbqJHIMuwbjYCtG9pvcrIebWlR0T6JsWZ?=
 =?us-ascii?Q?EcghMNCfGOLlM46nzws2Ul2RMoVmNMAIXIusqr+3awlTVEk/TmpxslrmZXKq?=
 =?us-ascii?Q?yYCf72c0u/1kOHP5MweRCNhXYYQ6ZJ8rQuWVO7M/4ycHFTYSFA6kqh4xr71A?=
 =?us-ascii?Q?musTAmMEJx+IV9M9T6ylWOfzZZnqB6xk06sW44LOpZAxYLZeeJgoQLUFc007?=
 =?us-ascii?Q?4RaVvBSwzQvs9018kgWoVETauHelEeaVXua1Eb+z?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2366D0867B401F4D82472B7AA69A2427@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR05MB7288.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9998f622-426d-458e-6383-08ddcf8ad15b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 17:02:08.0922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y4JS6hxoYKEsdJRlSG08m5TibEMrTTf9/oH3oUBUV5BNVAlE3kvC6U4cI+muKFnrFl+EKSg+WusqeqjNAqJI5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8105
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDEyMyBTYWx0ZWRfXyUpXT12J+mcB
 luKkDWnfILgMIgFmKAtGK8Dzb+QOMAi2J1YnFWkF8NXoZgy3Rg4GkvXsKINx7YZuCZTbF3rGFIj
 /1rmtRzsD0slDZ0IkT9YkugtWN9jZKbnPZWjZz4G0obX5VfnxoV3zR5YMg0G2gLl0hkTgRmAglA
 b1OckLp9Yf27lOFlvo/+z+HrJMfnFn0NOwmHuFNKYDP6AlVpteA7vQg6Nw/1qoCnoE3D8cnVtJF
 19za+jb4/UWnpW/yesq3EmxU36nCgUVIVSBIkkI5HM+lPahgoVlUoQoLUiWfr4Px+ujJSwTvYQo
 YsR7XhTi0BG4jj+xuxihJNiBqpTwwI5QAHCU0jbvMBrJUlP+zyH7x9YVkQH1MYX2kEMAormjBu3
 CbOETA+K9Ea/Rh4v2s6k3kC0eyuyQRbI/gYVxoDUbxksVethy04yfzaDHCkOnzILTmKcZDvm
X-Proofpoint-GUID: BJNTHgxhXOzzz5JzTJzFUeMNlrDO4erF
X-Authority-Analysis: v=2.4 cv=S9/ZwJsP c=1 sm=1 tr=0 ts=688a5014 cx=c_pps
 a=v6Z6meDQFn3ji2zknzBGMg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=rhJc5-LppCAA:10 a=20KFwNOVAAAA:8 a=mM2tsFSK8PyXpeH1PXAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: BJNTHgxhXOzzz5JzTJzFUeMNlrDO4erF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_05,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 bulkscore=0 clxscore=1011 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300123

On Jul 30, 2025, at 12:31 AM, Dave Young <dyoung@redhat.com> wrote

>> +#ifdef CONFIG_OF_FLATTREE
>> +     if (initial_boot_params) {
>> +             setup_dtb(params, params_load_addr, setup_data_offset);
>> +             setup_data_offset +=3D sizeof(struct setup_data) +
>> +                                  fdt_totalsize(initial_boot_params);
>=20
> I suppose current boot dtb should be valid for the current runnning
> kernel, if you use kexec to load another kernel the next kexec reboot
> could fail due to unmatching dtb.
>=20
> Make this unconditionally could break the previous working kexec?

Hi Dave,

Thanks for taking the time to look at this change!

The behavior on ARM64 for carrying over the current boot DTB is
unconditional, which is why I've made it unconditional here as well. I'm
open to suggestions on this though. Realistically, would there be a case
where having no DTB wouldn't break, but carrying over the current DTB
would?

>=20
>> +     } else {
>> +             pr_info("No DTB\n");
>=20
> pr_debug sounds better.

Agreed. I'll raise it in a v2 in a few days if there's no other
comments.

Thanks,
Brian

