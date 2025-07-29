Return-Path: <linux-kernel+bounces-749779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56350B152D7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6423A4351
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977F623535A;
	Tue, 29 Jul 2025 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northwestern.edu header.i=@northwestern.edu header.b="Thm3QAFY";
	dkim=pass (1024-bit key) header.d=northwestern.edu header.i=@northwestern.edu header.b="kYa8znJ3"
Received: from evcspprf10.ads.northwestern.edu (evcspprf10.ads.northwestern.edu [165.124.82.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2B046447
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=165.124.82.241
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813769; cv=fail; b=eiQ9ZMFtCVwXwfgBACkWkwOw9ToYG9SufJYrxIKiy6wuvNV6yuuwQGLz39YwiiKrtBXJwz5eDkbmCrT9lyXl1rXHaz/cRMNrlcof80rQGbl08Jfw3grXE3+WydOeh+w1/UxMs4TEP9QUA5hajckAb46OIPFgf3xHbYDk1/Iux/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813769; c=relaxed/simple;
	bh=ntVbOfSUqKlHNFF1M3o+vlYzWNXihyto0XyCt+EpdzE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a+gdb+qNmPJ/aRk9j4Hh8XQrQOKJg+qSOMNAResIc5iUkhcLW4m87BNpBwppawmwd/TnkJjHvL4Uu52voeJLgUtU7I7uXldbstaZiN5vjS6UOwhJrwduKuzggC9mTO8epEeA0Z/s0rbwAS4xsdKkwUP9EXnU/7wgR5KfMT1yJnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=northwestern.edu; spf=pass smtp.mailfrom=northwestern.edu; dkim=pass (2048-bit key) header.d=northwestern.edu header.i=@northwestern.edu header.b=Thm3QAFY; dkim=pass (1024-bit key) header.d=northwestern.edu header.i=@northwestern.edu header.b=kYa8znJ3; arc=fail smtp.client-ip=165.124.82.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=northwestern.edu
Received: from pps.filterd (evcspprf10.ads.northwestern.edu [127.0.0.1])
	by evcspprf10.ads.northwestern.edu (8.18.1.2/8.18.1.2) with ESMTP id 56THdeUn028541;
	Tue, 29 Jul 2025 13:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=northwestern.edu; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=proofpoint;
 bh=07Gw7RMtloLM44kl6BhqzuVh/GlUuwY7y0Oro3NCYvI=;
 b=Thm3QAFYfu8kXWG+P9hihy617ddGPshtbtJJLZvY46di5ukPyjl5izd5xepAc76XDjba
 RnZWU7PhE15kds/9YQtvUG9QQl6OkkdZp14mLp03DS8hUOO5P0aZApL/ABDNm5O5QRI6
 nm0WwbXdWfQ+0SOOMI5z6qvNqMQErVhnqpUCvtM81N+ep9dXGQaVv1MDz4VU286uu5zL
 djkEyGK2onqH9hb/0kL2zpCBkH3tsMqG1zT+AOjghRADjB013L5dHL20++HM1+EDiwRp
 o/Ri3DaBVNpftza+CRiEeO+tUm57NTLUxpSCr5mSnx9HIh/olrMcI329pxR1D40gSJLZ mA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by evcspprf10.ads.northwestern.edu (PPS) with ESMTPS id 485d75mttt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 13:29:09 -0500
Received: from evcspprf10.ads.northwestern.edu (evcspprf10.ads.northwestern.edu [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56TIKBna022823;
	Tue, 29 Jul 2025 13:29:09 -0500
Received: from evcspexch01.ads.northwestern.edu (evcspexch01.ads.northwestern.edu [165.124.43.179])
	by evcspprf10.ads.northwestern.edu (PPS) with ESMTPS id 485d75mttp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 13:29:09 -0500
Received: from EVCSPEXCH02.ads.northwestern.edu (165.124.43.180) by
 EVCSPEXCH01.ads.northwestern.edu (165.124.43.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Jul 2025 13:29:09 -0500
Received: from DM2PR04CU003.outbound.protection.outlook.com (40.93.13.99) by
 EVCSPEXCH02.ads.northwestern.edu (165.124.43.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11 via Frontend Transport; Tue, 29 Jul 2025 13:29:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XtVscWBjEHw+AHBa1lNu5EqWz470KQDIN+tOqAvB43PV7Lo3Hc8ZK/Q4kW7fWtBDC5jiGDU15n2CHNxcwJzEx6pq2QhDd2qkKuyWpJg+aouKjEy+bUKSFnIOeVtOjMZ+0A0LcY38nfF9AMDdgKk+wJlLXQ73mYsm26Ksd91nHfFpNgaukc1wET+6QuzMF6qRfcCust7o1Eq1zFLdj2W2Rzp4UK334aC1d0hli5hfhh+1bAYZAQS+EqvFNR8/0s5rKMXzZyi4H48EnP8XuobQmQcDCgYQao+y3eAxEqjyfm/pBs+Kh9phav0nQDyOKPk+6Y68mRvEsS7ceV5sRK5pww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07Gw7RMtloLM44kl6BhqzuVh/GlUuwY7y0Oro3NCYvI=;
 b=wdFm36VVBF9PeWKXAJM8pjGFjVFh8ZTWUZHYjSy0R6ZH+VjhoUCsfPQXkIuzf8Ndy4I4wR9v598rQ+fvfIrmDGEeKEy19yNetmYi1RxQYioxUHMLB+9PNScKEcua9pQqi+g0czTW5PrN9OENsA747KwOZzRt0YbeNYYIJFLnUuXvgwmUUThA3HXrRej71Q+Sz6Wzdicbg9eG6K9m23v+xCCuSK+iVopU92eSZDHDmXxjDH1HwT0yL1IY32a+aDgHZYMzbOChUfRZu77+QSSbX9xz6KylhC8Tn4XikC8z3vpgBv7Dg2FSTxPn5GJNPALqY5hpIyKA94cKLj6nY3O8yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=northwestern.edu; dmarc=pass action=none
 header.from=northwestern.edu; dkim=pass header.d=northwestern.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=northwestern.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07Gw7RMtloLM44kl6BhqzuVh/GlUuwY7y0Oro3NCYvI=;
 b=kYa8znJ3Jlq8SH+QxUE3L2IIQslgmBqU7ekKiE5jqvzR6dXzQ+h6G9Oe/p4xsivo5N4MtCTN6J7TP8BTtPAUIEgOURebI66ApO1sKskxZTEHyqR/Fsve4346wS1NZpe+jRA4yJdG1gCSyhPKqrthVvSVvmk2NfSg1fM675kIAmI=
Received: from BL0PR05MB4674.namprd05.prod.outlook.com (2603:10b6:208:2a::33)
 by DM4PR05MB9582.namprd05.prod.outlook.com (2603:10b6:8:105::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Tue, 29 Jul
 2025 18:28:56 +0000
Received: from BL0PR05MB4674.namprd05.prod.outlook.com
 ([fe80::2a87:1931:383a:f54d]) by BL0PR05MB4674.namprd05.prod.outlook.com
 ([fe80::2a87:1931:383a:f54d%4]) with mapi id 15.20.8964.019; Tue, 29 Jul 2025
 18:28:56 +0000
From: Zheng Yu <zheng.yu@northwestern.edu>
To: "shaggy@kernel.org" <shaggy@kernel.org>
CC: "ghanshyam1898@gmail.com" <ghanshyam1898@gmail.com>,
        "duttaditya18@gmail.com" <duttaditya18@gmail.com>,
        "r.smirnov@omp.ru"
	<r.smirnov@omp.ru>,
        "jfs-discussion@lists.sourceforge.net"
	<jfs-discussion@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] jfs: replace hardcoded magic number with DTPAGEMAXSLOT
 constant
Thread-Topic: [PATCH] jfs: replace hardcoded magic number with DTPAGEMAXSLOT
 constant
Thread-Index: AQHcALZhI8GgsN5OSEOFkl9iEpHHug==
Date: Tue, 29 Jul 2025 18:28:56 +0000
Message-ID: <BL0PR05MB46744E1F59F1E41E2C2E014EFF25A@BL0PR05MB4674.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB4674:EE_|DM4PR05MB9582:EE_
x-ms-office365-filtering-correlation-id: f4749d9f-4678-4c2b-f042-08ddcecdc76a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?WjQy6WuiuE6L8ogmI3IOpWZxP43rECHTnng40pM/aupL+vJBC9Nzwp3fh7?=
 =?iso-8859-1?Q?K1QkZAeBquPH4Rs6wf0Oz9BkqsbXsPrf2a1JoBoEGuUGxdSrdNjcKjx2mh?=
 =?iso-8859-1?Q?4vnjADZ2s1wC40gox+yUwIeYQ+iEl+jf3gFCthnrOehQGisuxDU7l7qrC5?=
 =?iso-8859-1?Q?8e4UoPQV7C0ZIFUS4CSJD5hYSp2VunRyk50wTv3B+6yWUVowdeozPzze5D?=
 =?iso-8859-1?Q?STCWH/1fzFlRfBdfJ8A/O16jVGe0rSgteC/X+5cCJIireRda/HEtn14wdN?=
 =?iso-8859-1?Q?3BMQ1trBqC1MSmL0AR7mOCqCCCpizy+tm9Gh2RmOktYsx9ifz/JNOAjQF2?=
 =?iso-8859-1?Q?jfpeQCe9xRafG1w9sVoIAx3H/QCEb+4I81X6vXS/JJL8kLZFHYiaTM31Qk?=
 =?iso-8859-1?Q?opRvDBUNio6OKu8uu6bk+DUKyYMieeRhhxU5up4NVNB7r8xUf4UC2GFelR?=
 =?iso-8859-1?Q?xIV5FJrYkeSftuHw3QpPReQcnyA7UHlCu5g/5TiJ2Ok6baYDBqBVo1pEeF?=
 =?iso-8859-1?Q?t8DTtzzJgZBjSFT+zpmu0Iq9o3EimPKDPJnF2lK14hSlxz+2lKHX8Cp5Ab?=
 =?iso-8859-1?Q?DXzdD1GXr2XSeRV2QQpiz1ZSRCx/gLlXlEyigHjoZ0i1SjBIlNjHwPrlRQ?=
 =?iso-8859-1?Q?Oo9LE2KLy9lgJYqnsqdtTuQshEAvYhyU3D+YMIndZePOPEKvqyGKeZn1RH?=
 =?iso-8859-1?Q?UOaRanbwiif45ep//2bluHIPNpjO5aSJiXq/xCgi9WFHCV08ry44PmS73T?=
 =?iso-8859-1?Q?+afz76FTfy9whZWafDB0EnUcfdgsoUnVt8tVDMgPDHWWc6DwTL6uIYDzZ+?=
 =?iso-8859-1?Q?Dpvm8v5nAHfatDgDuWNGxeXg1N2RAbtEqZpbnS4pIpXpVNMLLHEGfAFf6J?=
 =?iso-8859-1?Q?zuhKgq/iqAw7Rg1z+oOt2QXD+mqo0/Kizg4QC7V1k0toEnKxBt4QKrbeAh?=
 =?iso-8859-1?Q?grqXzODLMbEd/dIyOAnBkF4dshP9Fz01QejmDfxnaymrxOWowuhs2vduv6?=
 =?iso-8859-1?Q?PvbYnM8h99w+VjzPxsPlymgAivkeUtCzFgVcroVUaGNQlJlhze44LNz2Yc?=
 =?iso-8859-1?Q?Od5KZ0rJMlpf9oyh9HbU3y7pcVVb2n3ZybdlKthnCw5TByFAumPwUo3wyy?=
 =?iso-8859-1?Q?yJKzsyOZYr7dNmZAyjrrcrp31VXzc+PtuHti5ndKcYRqcSlverh+xe+NlZ?=
 =?iso-8859-1?Q?vQ4aIKEJa83T007v8ifOgRJYKAPRXwM1fmgd6+5pc6nsWRiXzr0VSQyLGd?=
 =?iso-8859-1?Q?i3q29dFkLxbhqxjSAYZVhtwjv58GhKgGqaC7nFgG3JgCw3QMeBh2SQYSCO?=
 =?iso-8859-1?Q?gzMBt5Njjt8YbOD8sSS6q/lL1vpUHysI2x/lgEdJ0W0dIQqxXRbeJ3V6nP?=
 =?iso-8859-1?Q?SrrhifvyC9vjXEDGjkVwonLbIIk5houz+r/IKxE0Xet0z6ra4Vtv4yLmKQ?=
 =?iso-8859-1?Q?4fbpsVPR3FF7BvpUva18XnioIIxF0elmO5Y2IHwcnM4OaeJrYhalXsXkJq?=
 =?iso-8859-1?Q?8i/JC0Ugx+27LuQkZswgsOF1LU+mPJ72m/TP8Zly0Dfw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB4674.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?um0Cj+QSDmdviqwEz7iInflII6zlImEVJXQ3fw9A1Mfd5zmpEP41fDSAZB?=
 =?iso-8859-1?Q?PKz/SCH4+kHOEzgsigw+NCys9VnpVeU5O/M8twPCW9W1HQ3ggiJOQA+csq?=
 =?iso-8859-1?Q?uKCcmGkcxSAlNimuqfWwklbobgXCluVPQzHwT0TDCBmyis0WsBiOWz9hnd?=
 =?iso-8859-1?Q?BW6dBcgETWi7IgXvmCY/KqVw1/RqIrS42UocpdlKp16xsVISh/a9yGe/Qu?=
 =?iso-8859-1?Q?aSyTas0MuPXz0AXLYijZfY/6tqL055IPlH8IQ6gtapLv2bSsctOh1f1BHu?=
 =?iso-8859-1?Q?pcq2jTj8QVqW2G+/V7NgTwzTWM7hyX2JZoDUpFOs+DgS/iiG+XMailf2E7?=
 =?iso-8859-1?Q?hQypUMz3s/0TR1rXuHFJBVUQeDY8VRF0HXIksHYk4m+z/fUt4EN46flTM2?=
 =?iso-8859-1?Q?MCrlC3uZKtflLZNr1iS/b2OK5ae9ucYiYZG1gkF1OaKQUDJMhpffcv+W8d?=
 =?iso-8859-1?Q?HA1ccU3onA0YEEcwLcLhYk/F7+B39aDf1F/dfsEH+r/K0LAH+2DNhGLcVB?=
 =?iso-8859-1?Q?d9+080C+KupSc+3wdAG7/F9LiQxkScJDF0+SqyqYRsTlMMRypQ8hb+MEeu?=
 =?iso-8859-1?Q?jXv+SeYgPNJGBgwN6uB5wA1642IAj7SOl5bCp1+NJGbMCaiymFN1TyszIY?=
 =?iso-8859-1?Q?3DAFAHFnPqAdbh2CF4YlCAqTEHAfE32sJaz70Z4rsVw9vg5YKYClVqvj5l?=
 =?iso-8859-1?Q?DTvoIxcGib93amljbX7VkXYcaZ8Dt7L+pXNziIiurrapcTWA2s9h4QAkYO?=
 =?iso-8859-1?Q?Opv5OG2wcKvRIfw3JmURQR2VjsN8BSiuK7+BBKFIezY5oyaXb6RV+W/sTX?=
 =?iso-8859-1?Q?WWYdX63mJGk89bCxcWUE/bza2u6hsW5EpaKVcdz5SuR/eOCMWcOu8mJB+s?=
 =?iso-8859-1?Q?YklPpfPMGC0F+P34bQ91GPOP0wwf1tjKZfzFH1EVrdR8cgm6G36VrFMTZu?=
 =?iso-8859-1?Q?roKy8Gj2m5vHc3ofoXCYYqpFbdyFVaNjrA7Hst5EILs8PejrYVtJXIpH0M?=
 =?iso-8859-1?Q?x8P837uhuY452pxzfH15jj+uPmu0b2G0Zp7Kv1sBEd/JNRv+Gy9NLuSDcD?=
 =?iso-8859-1?Q?iLOMqsWV+sQclu9y+Yi+xxQstQRftCmZ24ScWDGyspOmerJyzEmW5T3Dka?=
 =?iso-8859-1?Q?nfwsaHCi/5Sphnco8MP2cur0RoSyIb3z6GX/d4+CHIEWQgD/yYE/hNAwbd?=
 =?iso-8859-1?Q?3bU/EXQxMQmJzzL5KuMVIpufWDc7uRAVt0pD5tQkNwK8SsoLk6yGDf1SpF?=
 =?iso-8859-1?Q?iWz+iqbonxFtBBh5Rn8ylcYdEOt2SVgky6bb8oxpwOa5s4kYKdiJRBMGic?=
 =?iso-8859-1?Q?TKPRgH6+UTS1CrZh3I+5JijNST9NarGNHq6b2wPf0AnV0clm+/u6GOKQP/?=
 =?iso-8859-1?Q?2jCU7vm4UjsHgGHq3sMVfbuY4GCx7fNGwpiTm1eAFJ8UlLDTcx6TOoauR+?=
 =?iso-8859-1?Q?fCtfg1UMRDSLrsUn8AgtCoXr31igP7a6Bbz5N3tSnjdv2IWVk2zWlANuHT?=
 =?iso-8859-1?Q?42ZJ4kHrdUgHJpdv0UOMVRBqPvKxhrmXuoefTVXwAIdwsEJ1KXW0l76xtq?=
 =?iso-8859-1?Q?IxnB7o+pkNVHPPhDa6gQokHX8m9pLmHofZCHW5tzfNS8sJoOKXjkwGg07j?=
 =?iso-8859-1?Q?mXdFrbbwtA7qZH2DkWMAKjYJMz1Qc+lOLhQco4wFrxZYCBHss2KY1AH2UQ?=
 =?iso-8859-1?Q?F77kDDEFEC0T0xv1gbQN+s/i//r2kxJvz/aAo+mO?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB4674.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4749d9f-4678-4c2b-f042-08ddcecdc76a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 18:28:56.4752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d76d361-8277-4708-a477-64e8366cd1bc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQLe3SZDne7xWAApxpoLOQ6D/7d3E/vlP2wO23r3GZ+qJUCfmTIOHqctk8XOYPUGDYK7z/NIctYGqKijHfFNC8nSoyK6f5+6eZRaeJYX+ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR05MB9582
X-OriginatorOrg: northwestern.edu
X-Proofpoint-GUID: n2iSwocXqxcKfld3uFdl6lo-EL4EUdXq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDE0MSBTYWx0ZWRfX+WrpjFltvk0n 1AiFibCTNnkQq6KufP+P7EaHX7zFNkUSh1mAFoOyZhZpIejRU92/rB/KDroTNlwbFzvAJiuTuMC a+/art5oIwCQkIJgOmSkMrQkwGo9T7ZofOfeA29DNMrVxSsaz9U79GdhSuS2yODRMkm3SJohM6K
 RvfePaZD24eIs+/EpNCfXfGr8cw9R8Pq2HotGVIRf45r9zXtxrVFrAaa+QUjkLbvh25EV7SqY3H ZM+KyPNwjkLLzC5EXgsxlF/YqwCDlUZ4LQtYZwDWWpFa/POiisz6J7CJN+GWlBmh2gjzquQftjY JaaRcu8ihXoCa9NDaewPTzdJ5TlV4Eaa9Q/yVhFO8y2MLTwkkjnEMcse68bfhCp5xSAIlHaCX0R H/6OahnX
X-Proofpoint-ORIG-GUID: Pqh0kHxsl0aEsS6kJ48HfeXbuBjs5dFg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

Replace hardcoded value 127 with DTPAGEMAXSLOT constant in boundary=0A=
checks within jfs_readdir() and dtReadFirst(). This improves code=0A=
maintainability and ensures consistency with the defined maximum=0A=
slot value.=0A=
=0A=
Fixes: ca84a2c9be48 ("jfs: array-index-out-of-bounds fix in dtReadFirst")=
=0A=
Fixes: 839f102efb16 ("jfs: fix array-index-out-of-bounds in jfs_readdir")=
=0A=
Signed-off-by: Zheng Yu <zheng.yu@northwestern.edu>=0A=
---=0A=
 fs/jfs/jfs_dtree.c | 4 ++--=0A=
 1 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c=0A=
index ab11849cf9cc..0ab83bb7bbdf 100644=0A=
--- a/fs/jfs/jfs_dtree.c=0A=
+++ b/fs/jfs/jfs_dtree.c=0A=
@@ -2903,7 +2903,7 @@ int jfs_readdir(struct file *file, struct dir_context=
 *ctx)=0A=
                 stbl =3D DT_GETSTBL(p);=0A=
 =0A=
                 for (i =3D index; i < p->header.nextindex; i++) {=0A=
-                       if (stbl[i] < 0 || stbl[i] > 127) {=0A=
+                       if (stbl[i] < 0 || stbl[i] >=3D DTPAGEMAXSLOT) {=0A=
                                 jfs_err("JFS: Invalid stbl[%d] =3D %d for =
inode %ld, block =3D %lld",=0A=
                                         i, stbl[i], (long)ip->i_ino, (long=
 long)bn);=0A=
                                 free_page(dirent_buf);=0A=
@@ -3108,7 +3108,7 @@ static int dtReadFirst(struct inode *ip, struct btsta=
ck * btstack)=0A=
                 /* get the leftmost entry */=0A=
                 stbl =3D DT_GETSTBL(p);=0A=
 =0A=
-               if (stbl[0] < 0 || stbl[0] > 127) {=0A=
+               if (stbl[0] < 0 || stbl[0] >=3D DTPAGEMAXSLOT) {=0A=
                         DT_PUTPAGE(mp);=0A=
                         jfs_error(ip->i_sb, "stbl[0] out of bound\n");=0A=
                         return -EIO;=0A=
--=0A=
2.43.0=0A=

