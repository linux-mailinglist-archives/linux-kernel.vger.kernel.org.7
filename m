Return-Path: <linux-kernel+bounces-828897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE550B95C85
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61B83A2134
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D87322DA5;
	Tue, 23 Sep 2025 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y/ZFabT1"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013050.outbound.protection.outlook.com [40.93.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103863218D2;
	Tue, 23 Sep 2025 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758629408; cv=fail; b=r7gFcnbujnIgoTX2CD02GSdXUmOISI42QeSMT6k+bDgT9UzNEyDtMshT49TCwWihCTl+LgJlWZgGFd9YxJVxBqcWcaIdbVOBFl0fsfwEgoRfrssMJOWt1mCiaAReGxsEhvT+gGoGOuvOR6BcFXAIeh636rfKFzCGTMY603bse+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758629408; c=relaxed/simple;
	bh=uNDvwWmIqG2zAfg3uOeSjy0g33hYHs2Zy6tZyZePXxw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eLLTKm4NbEEqIr0BbbvX/UCizUx8QtMxr4RdRHBW4gDADQwwU9MzzLdi/8lj5lF/7dV2ZzN+WygnOPoLkUF8s2laXwb5Td8Nl8E7lOqYmimgPivgxfJYM/XLthLszBWKooW9qxh8CIq9doPmv1iYkzEkn/NlEa8nbaCiU4nk0Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y/ZFabT1; arc=fail smtp.client-ip=40.93.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUXOxLgNlDJU7zKRsSZ4g9KkviuaCHRmgYU7RBqqUwtqX3osVjRYe4dcAdLJlbwuhtqe0NYAx2w5TLOyK0gX7KdCZrG/T5OPFqAPpyR+qP3cZlYehw1VzT9zDke9lvLa46JCoRym1Duj1LcQ5/of6pSGD66aEo3QeOB2PvYzSA6Gcxpr5q4YKsBOcN29h5JeYLqBqrqI4qyIp2aUR5ofFMHuI4dXDqzap+ug4Yb2z7syKjGRm7800oaKVz1++2vFJwqqQmOidhzqWkAYpWrQ0QueQOoEC29ijzzi1UDqWZA/9WHXPGoJImk4lcqUXEDFFULpEPc82cCiYrKH5arvyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEn5tb/pr/1rRGN2K3iQJOiT2J+EAeRuoIc4mZdrSnQ=;
 b=D0Sdn+2JGadG2Byx5dGiJa8GGjoeHHSJRT0Rbynd1xqeX5uQyAPJujtccqXYFxp01zHiO3J6SWpR8flxcgDIlvXsG7cAaBKy/MM2BcDEvWutP0Idgl0I8Ojk6V0ldGBf22SXOFg/jWkSo1dv3fyaFhsNTNXkGY7wzAri8JMd5TKysLh+Y4xzIFNWP2Or6co53XMPot3E0ZrZf6ho/CqTjvvGxr2WPEbqMjBzOEV05wTSdKwjWI1hm/+xRLDHyxQ9hoBQrpbuaZAD+TBKeDMjS2v7XrsqO2wXLTjyJushCqp3gChhPc0SOp07Tq9Vnl/gV8hsZW2cpvqOAKTe846Yow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEn5tb/pr/1rRGN2K3iQJOiT2J+EAeRuoIc4mZdrSnQ=;
 b=Y/ZFabT1fGH9Nq3pAjJyxHojfQJKeIcrcLGSz9w5enyRriGOHv3ZHaQSdDMuYJkgzgLMlNeaYWC6I4ANNMPOR+567PC5r5M5MBOXqveeJPCpknv2pVBnxR+OcbnnYkN2HaBaNV7jJ2EDupCqfNsLhM0vYDmV0UrrOpaw1AUszSSrGmXFjB7pyzijyAyCn3je2eufcXMiQnVZKg+07h3IjTqQd5r/wVyaTwIJpm/jD0Smq+DwB2SrI9EY5PYp9kGf0DFxYJjrP4VluuzpreoAGPlr7yGWVKuL3GdzDBx+gE5IvYUQr0SQ0gB0EDP+bnq7t6n8UC/kEoIG8+qCNAz40g==
Received: from SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12)
 by SA3PR12MB9107.namprd12.prod.outlook.com (2603:10b6:806:381::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 12:10:04 +0000
Received: from SN7PR12MB7324.namprd12.prod.outlook.com
 ([fe80::36df:d252:e8a1:b651]) by SN7PR12MB7324.namprd12.prod.outlook.com
 ([fe80::36df:d252:e8a1:b651%4]) with mapi id 15.20.9137.017; Tue, 23 Sep 2025
 12:10:04 +0000
From: Ciju Rajan K <crajank@nvidia.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: "hdegoede@redhat.com" <hdegoede@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>, "christophe.jaillet@wanadoo.fr"
	<christophe.jaillet@wanadoo.fr>, "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, Vadim Pasternak <vadimp@nvidia.com>
Subject: RE: [PATCH platform-next v2 1/2] [PATCH platform-next 1/2]
 platform_data/mlxreg: Add fields for interrupt storm handling
Thread-Topic: [PATCH platform-next v2 1/2] [PATCH platform-next 1/2]
 platform_data/mlxreg: Add fields for interrupt storm handling
Thread-Index: AQHcLHcm6Z0odC0pKUuQETaOejuC7rSgmSGAgAATrnA=
Date: Tue, 23 Sep 2025 12:10:04 +0000
Message-ID:
 <SN7PR12MB73249D16A95B8C87E9B8AE5FD61DA@SN7PR12MB7324.namprd12.prod.outlook.com>
References: <20250923104452.2407460-1-crajank@nvidia.com>
 <20250923104452.2407460-2-crajank@nvidia.com>
 <4d131477-f188-7a42-e382-6168299fa5cf@linux.intel.com>
In-Reply-To: <4d131477-f188-7a42-e382-6168299fa5cf@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7324:EE_|SA3PR12MB9107:EE_
x-ms-office365-filtering-correlation-id: 71b6fe7f-08f6-43db-ab3d-08ddfa9a2100
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?VTeUGLyEGM0n/tD/N2SVoqoEUf0IPN0/gdxH8rYhVaSBSbCPLqwQBPxB2k?=
 =?iso-8859-1?Q?4fSzClIgoh3CtB6HHwLGl63ciyW2V8Rr1E3LSyvMp6JAqM90XyT39srSeN?=
 =?iso-8859-1?Q?I9CVdkycJUH7Lvyb45dDvoq2EPzyhjmz4UhU8QSaNaxAXlclrO3dI+kfeZ?=
 =?iso-8859-1?Q?NKeCcVu3YBpow6x3+0HiGS/HB72/Qlgx6elkuC1R40VSiKcJ/il9UjAlqt?=
 =?iso-8859-1?Q?8a5xMREACLQLAm4+GV22eEd49DBcgQXNaNMzkml7l3V6BcswsQ3w+26SD5?=
 =?iso-8859-1?Q?mI8iJXktmNCROc6B7ge9Bs50aJPyAvrSDq+yRhD1atRPdfXTSEkqXZhYtt?=
 =?iso-8859-1?Q?yXZTSG/2qHK/RTSvuWu17sh/sYsNZzDJIWaiXjsR9R2VjNY4ZAcWKHBDxt?=
 =?iso-8859-1?Q?QGJvPO60A22YIq3Uphc+jk9N3AKjxuM24z+qPzbvhxJ2dUcK1XQEtuDAzj?=
 =?iso-8859-1?Q?N7s78DtEFpRF0cmrRY6fvNJkU8BoKceIjsFr716pg2kiMowfU8P+yCODdA?=
 =?iso-8859-1?Q?jWda4Ac+qXMzfXDu0WsDP+emyWotBQPyt2/KqVx+rSFFG9vBiekbeVLlM2?=
 =?iso-8859-1?Q?FGylia++3Q0LRn/tINKLnEOVMVgDwSsXYoAQpliyP8cnEymJX+LAQMFfUU?=
 =?iso-8859-1?Q?Efc8Lc8Cug0J3GUozsstYNfjX0HpLC6U4C8zF6kdE111Mc+W2ivG+S2/cp?=
 =?iso-8859-1?Q?S2RY3tGQ9tmrgzMX3ZtjOJN7r2zf+lRB90D9ypDqCh1yk2kIlFOPlMonWV?=
 =?iso-8859-1?Q?rGrhI1lSY6D1nyzAMuW+UzgBkkYdn6SepUwifD1p9i1nqmBaaSCgnEPfyI?=
 =?iso-8859-1?Q?q6HsY9bpmNwWVZ1FZjQovrR9F+2ziF+n4CRkIOfq1K9zd2hSfJq+3b0wXS?=
 =?iso-8859-1?Q?e5hugbu8YMewQdZP/2hA3xeNPWakqeWIXCSB19fRZskU9jSzK5ilAoS9Xz?=
 =?iso-8859-1?Q?fAP1qvSRglD7DGf93rAU7KjOQm0uVhpWrZKcUCfPD6VXS+WqLPWu0C9zUg?=
 =?iso-8859-1?Q?WZiddwNwcYVBteyHRhtVvTR23+NE0zcIlfXk+HOJjEOSb0udqy7XOOHGrK?=
 =?iso-8859-1?Q?KqwAxCxdU/HfAc3wQLXQUkrwCrv37SrmOU7kDV6V8Lmisf0DC5eM5y/Bl8?=
 =?iso-8859-1?Q?tSlKV+3h/AKVYFXtNqccF6bKLjSd7GIzvYDm+9j41B16JRLSBI/mLALY30?=
 =?iso-8859-1?Q?xBfoK5h1wyoLpuEEZwV92h43DQTEl/LQ/cbVyRn3p/tUcqdbbYJsPptl7r?=
 =?iso-8859-1?Q?7840N/x40CDt+RoL1EsEhAvyePUCAI89b+s/qAGjHxTcLMHmzwGTxge8bL?=
 =?iso-8859-1?Q?ZswSDTJ1Sg45VhzLqfpyzi3pkCqPbxtfM9fUxmwJNjaJye5kKnap8eGu+0?=
 =?iso-8859-1?Q?E5FPur3iYrC8oMUjExJKWCIGWvQT9/S0uux3yjhnlRBUMbL8C80v8N07K9?=
 =?iso-8859-1?Q?Wc7WGN2HNbBN05LNNloli09gEFugbKrMneti3PqSQJ+hnyp0A0eikWXIH0?=
 =?iso-8859-1?Q?ZFZNX0Vg//aVaB0Nuuy/FpkkOI+yDwBQM2Jfa3c46U+w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7324.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?dDJIkFA84CUBL7HzOci1Lfn7cl1nsJ4Su/+l+iIRKaG+GYbv83a04rbNOj?=
 =?iso-8859-1?Q?QFfKNbhNhmFc5/tlKMrObAtd2OR/h1D4hUFqzVxrgRrZUcZFQIYHUh4zij?=
 =?iso-8859-1?Q?ER0lPquIIT6hJHCFvalVcsJB2bEjry7nQ4VdIMq0CBX6z85vnH0MGLIBXB?=
 =?iso-8859-1?Q?FGuPekLgcIBLampu7pvMO+X//CYUZo21OYdnXkercVQuCbkfVKYX9Vi3XV?=
 =?iso-8859-1?Q?VHK0UMGpjVCdwxgWjXZR5ScUOTg39b3DuZkkEp9spUvpzm1eLF9yI04PWG?=
 =?iso-8859-1?Q?5cAb6IUIz6wo75Obya/Lprt3cTE6JCSRQgd8OCHf06R7h2oUgJdBXOPrmi?=
 =?iso-8859-1?Q?0vsVZegksok3dphC7cYNXJz1/nWbgK5mnLjGQs0VE8pFvksaL53tuMU6/I?=
 =?iso-8859-1?Q?FmacNCU4LX6uqefEZQoyGgqnR2DGOzdzM0heg8gzZorhFbRokj+Uz59eBp?=
 =?iso-8859-1?Q?djxdH91shUhAl/oIsT3pjEYFAnnXv2NBMvso6jY3hhu3ilG5k0+LV1MMZr?=
 =?iso-8859-1?Q?iMnM8l5cn98KDhaZUXA5fgyLtR9dOnYLWZUyquY3BfW7/iWeZGLywz1vCu?=
 =?iso-8859-1?Q?njpR/5BmjhmkzUQG3xGNWhVasiYLxJh/Vn7L0XjZUaUy2hDbAZO7ihRw7F?=
 =?iso-8859-1?Q?zIUm7451/ZZN8Ln3jzkx6+nWIPizeykiyHQmDLBeNpf3euP4nPERO4iuWK?=
 =?iso-8859-1?Q?+X5E5Yg/eEMKZ4qqJam+zheoRv8ucdLQCVg004PHSpCZNjIw+AMTyFl6SY?=
 =?iso-8859-1?Q?UqnE7WYT6NIOrkTYxWxZEN8ISKjebJVbxZCNOxoJJ9FE4U7PwLCvDbEGeZ?=
 =?iso-8859-1?Q?ISZn97EVZAJgH2OO1Dm7LkHqCbxUQQdD7MmnjlGiWerBhma2LMy6OZd1FO?=
 =?iso-8859-1?Q?sinvRObWu0qaP3qIT63/C1f8eK1/sOJtmMcBYh2ZfMVVUiqqMyTi3Xuy1+?=
 =?iso-8859-1?Q?kms/VZvGaBJtDBdLHVl5A7p+a21WHhyCAWjarDgpnq6iYxhOFQrYutDwxd?=
 =?iso-8859-1?Q?NC3DBnoheneGculf0UmQuptUWswJiex/wHnom/8EPBjk/GYsVRB2rS7oKO?=
 =?iso-8859-1?Q?t3pHzTvn8AIG4hWhwv+EBptDYpFnlN9kqVzvmVB6umeHrEOnU+D0b2Vy2w?=
 =?iso-8859-1?Q?+LmPhcUqsmT/21KuuAir4mSWPJ7YRitJxuc0LSGfXuy/xTtrPdJSP+VQpS?=
 =?iso-8859-1?Q?/pO8XlVeqNkfEmu/bUXPdZyxUL6UVHao2NF2WHtKI/tRXtPTcq1EJa2dTp?=
 =?iso-8859-1?Q?Hh/7AalIVE9+2Q66tLwRkALJemfuVw7HRvJ51LjhbmDE7JHspoXXVYNDXk?=
 =?iso-8859-1?Q?nuDxBO3ZDXzrwzNTg1Xs005EoRAicatd3D/TjVxUPH/bgfYd/tikZ5Q6lJ?=
 =?iso-8859-1?Q?X2fEp7C2BE1HotJZF5X41mvO2RPLobOcIqv2rPA4f22h97mOT7Fyshsxgy?=
 =?iso-8859-1?Q?RApCXgrNyGmES6aEfNymCrzIC3bSnYjLd+iGcphy4dhEC/Sy1U4wv7qTh6?=
 =?iso-8859-1?Q?kOl0arsZeDNCJE/7c1Q4ljNCcngt0Yc3oIVGrI2AQsnQygFLvgH1woJyiY?=
 =?iso-8859-1?Q?RRlID0W4bwQmz/FezObzy2tD+Dwa2hdACNWZUb3jBHfMjv3s87uC5mfOYe?=
 =?iso-8859-1?Q?yTYS0/VbMmYb8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b6fe7f-08f6-43db-ab3d-08ddfa9a2100
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 12:10:04.1596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sqmh3SLWLmuB+VL3mjWi2Mw1jVeYpJj2qC/h1n/YFn/W59yF2mcuvbuGzzj3ODuaViiL2mpH0KsmxY4gYo3BVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9107

Hi Ilpo,

Thanks for the review.

> >  struct mlxreg_core_item {
> >       struct mlxreg_core_data *data;
> > @@ -180,6 +185,7 @@ struct mlxreg_core_item {
> >       u8 ind;
> >       u8 inversed;
> >       u8 health;
> > +     u32 storming_bits;
> >  };
> >
> >  /**
> >
>=20
> I don't know what's the benefit of having this as a separate patch, the
> fields are getting used in patch 2 so it would feel natural to introduce
> them there so the entire change would end up into the same commit.

Combined into a single patch.

Thanks
Ciju

