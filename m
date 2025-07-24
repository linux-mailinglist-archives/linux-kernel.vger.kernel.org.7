Return-Path: <linux-kernel+bounces-743685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5877B101C2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581F11CC74B3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AA1253358;
	Thu, 24 Jul 2025 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ObhGEbiW"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678B92512C8
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342194; cv=fail; b=AIABTnmkDR03qT3KKUA/kirEaf4i6mN7EHHuDAjvo4Rqk632RHU6+s+pFenBbF7igwkt+YQbs+wfEfvkgcdgRabsvDWqBlcL+0U056EsnxxT+OMFktoAazLgf6rtP+xaUGfYfaLU8tsbDh965aabf/QG+Pck+erlse8mHFM2YJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342194; c=relaxed/simple;
	bh=nRu7EyLk6EeAK0CqfaOXPRIHqp8XXcTNoHr0Vkc1tBI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mUeTL4BBME6ujJyaW/DIwPOIa0WyI/HSPdCn+rrDWTh+LlqY6wFX+lGYpfet+3EjMUb+seXbk9B8+IPEqFe4KoWn+VN4keDrhscjtjCrqNGwzPmFnDaijI4eQgw7y4LYDa6SWN61bU5NkWptMQhpkIANeMpNB6LqzJK0b5Y+K2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ObhGEbiW; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMDGTCJc/OwyMQIpQuO7Ue2CrtMzX1ew7z8SNMRFG6i3yVD2ihB+rsaT27YYr6FkJNPmuVuG23IrT64gSPFNkA9NEkA5gptzJjWU/v5VJ55U/7v6Gn2o81N4mW4bhlOhzzVT4HwMdmv0iE3vwtUj/YCl2EwcMO6f3P3XrsjaTVBV2J3M/pIqG2zFsFtplZHsofU3HdlBhe8xRZU6YMMaBWBDi1472AAhVdwSp4bKxkjtZF1EVKsz9vjOFWmWc06+9ER1rTPl3kX9vl2IeH+Tdf6dlhJsN2fADw/vsDgNm4GD9RIGnD5S9y0na12QClnx4iopHkXvz4Z0eNO1ofTkcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXlwRN6Hb/KDZMxPnwwHe4K7K95ClrgIzi06fzzvYTE=;
 b=x9F+nLqlJS6z0jK//fMuovWDna8dHZY4vDQivYhvQMpxQDx9X/kC8b7WeXB9PZ9cGUcAKvqJ681WiuZCXx0qZds4+jqwd7LSsHD2uHdzMcy3yzXZQSiG7ABCaCa+DXIv9JBFv932G22OrFlDgtAg3+BugdGU8XhVexF9Q11qwFY14NpRB5mgYJxeKOccy/xGGALvvuetk+E8709KvHZo3qRoD6+CkrqsqjIJpuP4UHMxOwq19pnxuUPnKeSYMC7DnIw4I5+4sL4BHGK6hWD3jBYGDwtZyfZrkkI0AdY3Wk54t5c5qOwcHp96MHOR57C0yW9xrYqKPuU5L7WePoy7ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXlwRN6Hb/KDZMxPnwwHe4K7K95ClrgIzi06fzzvYTE=;
 b=ObhGEbiW9qb0Y8jzTnHkaDcRgzJHiXT1zotRxN6AoElWRVPiz/ZUqTpVJ5+AlGxRXB814RS4u9/iOwbeleN0bEl0VZ+po9b7rs+g927Y8W1T4wusNOQIshsDNW1YkVF3yAyo/W1aR/REgUGX935DEZnupTYyrPbApXTP9Lqu/UA=
Received: from BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11)
 by DM4PR12MB8569.namprd12.prod.outlook.com (2603:10b6:8:18a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 07:29:49 +0000
Received: from BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::d4a:9dd1:afd9:1c70]) by BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::d4a:9dd1:afd9:1c70%4]) with mapi id 15.20.8964.023; Thu, 24 Jul 2025
 07:29:48 +0000
From: "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
To: Alex Williamson <alex.williamson@redhat.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
CC: "Gupta, Nipun" <Nipun.Gupta@amd.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: RE: [PATCH] cdx: Fix missing GENERIC_MSI_IRQ on compile test
Thread-Topic: [PATCH] cdx: Fix missing GENERIC_MSI_IRQ on compile test
Thread-Index: AQHb9h2//Phhe8DtRk2GSigF0AHfibQ2tz8AgAASn4CACiD8oA==
Date: Thu, 24 Jul 2025 07:29:48 +0000
Message-ID:
 <BL1PR12MB5333449243C7FE258728C8E39D5EA@BL1PR12MB5333.namprd12.prod.outlook.com>
References: <20250716064903.52397-2-krzysztof.kozlowski@linaro.org>
	<20250717133358.1541e5df.alex.williamson@redhat.com>
 <20250717144037.08e88ab6.alex.williamson@redhat.com>
In-Reply-To: <20250717144037.08e88ab6.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_ActionId=194e4877-6edd-4784-ba49-f2c534885c27;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_ContentBits=0;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Enabled=true;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Method=Privileged;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Name=Non-Business_New;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_SetDate=2025-07-24T07:21:31Z;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5333:EE_|DM4PR12MB8569:EE_
x-ms-office365-filtering-correlation-id: 8a66e1ef-7154-4d56-d2e2-08ddca83df02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5zcgSDvnJY9BIQN4mZx/Ck+ZI0HMiiHXf4sopLTKslhT99ebc6EjyeE3VCKo?=
 =?us-ascii?Q?vS2h+1EckjQfOCGerYMVhPvL5opmrIpUDu/3Mv1nKDAnTG8U/Uk6E11Nt1ti?=
 =?us-ascii?Q?38II3dNXilcVt0mie63hdnBaJl8OInGWQsXGGscoYJWonrsb4ThYIz7rzQ5e?=
 =?us-ascii?Q?dPiDX+mkVX6V18GNxr7Z0MqL42jQ8nxyRhC0eQFr0Lh5wz26qDsBUuX4qIFk?=
 =?us-ascii?Q?TLE8s2Yvb99NuYpuFXEjubvcyYg3e9+6tFhYD8TjWd7SnBozY2U1F3oVBM0s?=
 =?us-ascii?Q?sPKAgv2kwcrGqnKEAZTIS5QxMAc4nj/i9DO41U91kS88q9O9kUziy6lrdXEy?=
 =?us-ascii?Q?8E+MIOoBb+oreSGLbiuwWJ675zAGjGt4YPDr6Rb/ZChdCMX6sBuvIpgmwrxt?=
 =?us-ascii?Q?yvXzIUatG5ZVtqTtIv5h1TOWvy5+W/0HmypeqC2UjGC+H8CqMXe6QhuBXemL?=
 =?us-ascii?Q?shd4HcXKygu6LKiyIPszG/e7XjGzUV9GYR5+gJfBnrK8eAK+WeOGRezNYOMi?=
 =?us-ascii?Q?0zLyVR45+Ri3oV3wdIahHuqK3G44Ca/7wKEHBDWf+vpaQtE3PVmTnaa1vVe9?=
 =?us-ascii?Q?swSsdxhMfZhjHH+hg5t8lhgK+cz1LHla5dLKxpIUT5tDXv9dEHjYVFXe/7e7?=
 =?us-ascii?Q?uIQEMaNiHdCqEEDLtodGij8hRt4by6l48yS+UcouZUTwWpBN5JuRHI2EPj8+?=
 =?us-ascii?Q?OtvuuTLFmF2nIudt0skhKbXe5QhLzTjMxi/v1puoe4Iq4eOzyL09rBTD5Xpc?=
 =?us-ascii?Q?trXL4TUYouPMf61ngsIX94sQ0ZDyeKsZR/pJsi3C+aVi/3mw2t6ULmw5sMqc?=
 =?us-ascii?Q?rHbNOrHZLsKgYA/7QBu7x/57gi5KuV8FjaitRchMy/Dbr2BYZMDk2V1tPdil?=
 =?us-ascii?Q?w90cvtsBD9KgSyxtEc22+ZctTm7EBF5gP8pCxnzzhzG9FTK+VIMPWbLdn6ke?=
 =?us-ascii?Q?dt1s0I/RNX2ucBLbOC43eh92wehBoT2IFyL0D9Q/2LxYAJ+vlIpI+Wj7WO/H?=
 =?us-ascii?Q?RqOVbw0kr6/QO/q93LjqT9ji/808A4Tm7NUPIr1EyXocpArL1H7rSo8IxTgF?=
 =?us-ascii?Q?P/S9LGPoHPTtM45i/h31k0oAAPAOhfVVrH9SfrVqX7684gSk3lqVgTzq/2MR?=
 =?us-ascii?Q?AHJejVTJsjRM09PF6K3SAg90074xbqY3Rm8LqQJDvEPNLZo9NpryTqhqGgMn?=
 =?us-ascii?Q?0evHd49BguOI3CDpTajqFXPhJHRvZDRrvjpoOu5D0VfroPlLVpSlJTXFgrfl?=
 =?us-ascii?Q?VQkmkflXGk7Wf1eLlL3VDnfjT+TNbXkZjVicM55cBsaP5m4C/2gmVJmwfnm4?=
 =?us-ascii?Q?p3TQXGa36qlGkKCDEaMDyPaeSjJVqumRocgKOeBpejFqdmGA7cub8G/hEygx?=
 =?us-ascii?Q?cOyA7nHTyqECiIOEXK4NP2ggSXDd0EMQMzmr2BBwIY9vbe30mBAin0YtF1f9?=
 =?us-ascii?Q?50+FAsC72uSH836MVN4W/WYSUc024YEThUYuQGYgfT4lbqNeTDMl8cN/kQVi?=
 =?us-ascii?Q?r1BKtp9h17CNvFQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?u6sRFVBXvYz+6vir8yNQdgy4AfNlJuWb/VZDYo2YtlVsgefdzGhijCivAeAq?=
 =?us-ascii?Q?K0ksOHe6xSClOZb6/OHLAope/4ToAozZOxUDzZ3W9SYHrhUcJxEY/3UdWvhX?=
 =?us-ascii?Q?rygpG2eoU6RbFyqOfaQor+0lBg1um7WgLWgJxw2K8LbTNo5oIBNB6Q4wha4G?=
 =?us-ascii?Q?YgAF4fBoZ6KVfLfieGvLnSbtaQ4j3jsab0uxW8GyU+MoqleYZOBIS/BkLCV5?=
 =?us-ascii?Q?vGSbdC/zyIDlZg0tqP25lM560/Vs21Lw3tnkSppC3Lown4H6WKpNSuVXd/mr?=
 =?us-ascii?Q?Db0VqvSJ3Wb1l4ge94D6Y9tYmaKZfZt9dI7UkqaUm0+8BhLQrhCHjXAYYssc?=
 =?us-ascii?Q?kdK6H9xVCcKs2Qu64gsTZS11JHujx/iDsJ5p/q8CW5UUvse9StHR+cDbKRlH?=
 =?us-ascii?Q?Y9pCfsaIcsvEj5dSlI8xe1qKF4UTSkbdEaBLcAL3qHIIdJ/iR4yYtvZ7+ns0?=
 =?us-ascii?Q?wfXj1rLq/WrYrN5OB2WtsawGIsb4UfHnZg4E2+0oO2vz7AFcztM46Pb7VlqA?=
 =?us-ascii?Q?k31NDckeJUTsH/3BP92mFIF2h9pFKPqKNo7/anT1VgyNADWAxiJ+Cx+la68X?=
 =?us-ascii?Q?Et8n+/cBvZzbcufJE/UQK7GrZjmSD2TnX+Iew/KgZPS+HDXa2aTja7Hr7EYP?=
 =?us-ascii?Q?kF5v1HK8iR+pAs9srCo54h2q6MDF70owneTkiCDrqJOABOUjtynxlVFRmZNZ?=
 =?us-ascii?Q?1myQAiaG6dVTVNkEDj9h9sKtszHDpwQlofv3ovJwpMVF90tj3a73QqKxeATE?=
 =?us-ascii?Q?ZtZ+WHUN8N0uGt5bWN2HaFmLWBfefCwV1UYYy3kqP6KkR/wTawDJpEe4MUbg?=
 =?us-ascii?Q?1pnqn+UZSmjgGHXJhKYmkGmESywzS9k063mHbqVBDWuG5P3bAgJ3HAuiXtim?=
 =?us-ascii?Q?uJpsEl6TJ8ik7mV0S6c09fN7IXo7N8aA+3XEPqvjLvMiDTUSkwidxDeE7z+7?=
 =?us-ascii?Q?0fV8t8yMUSX2h0Tr263pjiYiDS4HsfHnj5vC1z5dgNavobkah+4nUmue9ynt?=
 =?us-ascii?Q?EeDvuEN5CY5VKJ9UaE8U5jT6h2INKeUqUrpHOENzluAOUUa36JyptTF9GPmr?=
 =?us-ascii?Q?ufhrnYe+ybQ+cO8IS0XdaA5Ocw9hE0MJWqQVLHoxdR8tP/y0Xtm37RJ9/Pej?=
 =?us-ascii?Q?efT0/5c7/jqE8x4Krf1JJN4pRGwamKN6yBU0/Zfc/ppmfT2p3a4DnxeTqdp8?=
 =?us-ascii?Q?0li7pYZdhOu6eo3BdE/xyDU4q+cVQUch7yJ/wVmBjO1ZONGYGK5w0wIzI+Wt?=
 =?us-ascii?Q?qZRG5yReFXcRC4+4sl0p2cN5om4DutN9jwnjc/zHI8wYIvS+c4FmrBCLAODb?=
 =?us-ascii?Q?SFfPwWNBXCME6JLDZvAjRHsDuxMLct48LjImyWs2KFapfGQrq9QIqmaQEK6Z?=
 =?us-ascii?Q?HOtGliwuZWWw/ycuXO9AQrjWdbEH9eogfSAZZfHBkI9I33xxvO5FDhgqv4sp?=
 =?us-ascii?Q?ZzcB1t2JcFlSzwAyVNzU6OHGBCciiO8NkO4Oxqwom86NQWfQuXxadgyhvppv?=
 =?us-ascii?Q?Jp0E61J4A/DViWjRMPwGGde/nkH3gMKZEt6CDAfHgmR65GL2zPIdasi/ODkn?=
 =?us-ascii?Q?fCj13ozDb6WagvAyVmk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a66e1ef-7154-4d56-d2e2-08ddca83df02
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 07:29:48.7403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XRrw7gRxjXgNozzBkHFLu38NzLTnGC7juoyOBIHgS33V5b4zyacoypwN7X83IsMO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8569



> -----Original Message-----
> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Friday, July 18, 2025 2:11 AM
> To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Gupta, Nipun <Nipun.Gupta@amd.com>; Agarwal, Nikhil
> <nikhil.agarwal@amd.com>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>=
;
> linux-kernel@vger.kernel.org; Randy Dunlap <rdunlap@infradead.org>
> Subject: Re: [PATCH] cdx: Fix missing GENERIC_MSI_IRQ on compile test
>=20
> On Thu, 17 Jul 2025 13:33:58 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
>=20
> > On Wed, 16 Jul 2025 08:49:04 +0200
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >
> > > CDX_BUS driver uses msi_setup_device_data() which is selected by
> > > GENERIC_MSI_IRQ, thus compile testing without the latter failed:
> > >
> > >   /usr/bin/ld: drivers/cdx/cdx.o: in function `cdx_probe':
> > >   build/drivers/cdx/cdx.c:314: undefined reference to `msi_setup_devi=
ce_data'
> > >
> > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > Closes:
> > > https://lore.kernel.org/all/b2c54a12-480c-448a-8b90-333cb03d9c14@inf
> > > radead.org/
> > > Fixes: 7f81907b7e3f ("cdx: Enable compile testing")
> > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > ---
> > >  drivers/cdx/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig index
> > > 1f1e360507d7..3af41f51cf38 100644
> > > --- a/drivers/cdx/Kconfig
> > > +++ b/drivers/cdx/Kconfig
> > > @@ -8,6 +8,7 @@
> > >  config CDX_BUS
> > >  	bool "CDX Bus driver"
> > >  	depends on OF && ARM64 || COMPILE_TEST
> > > +	select GENERIC_MSI_IRQ
> > >  	help
> > >  	  Driver to enable Composable DMA Transfer(CDX) Bus. CDX bus
> > >  	  exposes Fabric devices which uses composable DMA IP to the
> >
> > This looks incomplete to me.  The Makefile has:
> >
> > ifdef CONFIG_GENERIC_MSI_IRQ
> > obj-$(CONFIG_CDX_BUS) +=3D cdx_msi.o
> > endif
> >
> > The call to msi_setup_device_data(), the conditional inclusion of
> > cdx_msi.o, and cdx_msi.c itself were added in 0e439ba38e61 ("cdx: add
> > MSI support for CDX bus").  That's the source of the issue, not the
> > Kconfig update to build under COMPILE_TEST, but also the Makefile
> > should be updated to statically include cdx_msi.o.  Thanks,
>=20
> Also, we may not be philosophically aligned on this, but if CDX_BUS selec=
ts
> GENERIC_MSI_IRQ and CDX_CONTROLLER depends on CDX_BUS, then the
> select of the same under CDX_CONTROLLER becomes redundant.
>=20
> Independent of that there are also some ifdefs in cdx_bus.h that would be=
come
> invalid if the entire CDX_BUS depends on GENERIC_MSI_IRQ.  It really kind=
a
> looks like CDX_BUS expects a use case that doesn't depend on
> GENERIC_MSI_IRQ and I wonder if the right answer isn't just:
>=20
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c index 092306ca2541..3d=
50f8cd9c0b
> 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -310,7 +310,7 @@ static int cdx_probe(struct device *dev)
>  	 * Setup MSI device data so that generic MSI alloc/free can
>  	 * be used by the device driver.
>  	 */
> -	if (cdx->msi_domain) {
> +	if (IS_ENABLED(CONFIG_GENERIC_MSI_IRQ) && cdx->msi_domain) {
>  		error =3D msi_setup_device_data(&cdx_dev->dev);
>  		if (error)
>  			return error;
> @@ -833,7 +833,7 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
>  		     ((cdx->id << CDX_CONTROLLER_ID_SHIFT) | (cdx_dev-
> >bus_num & CDX_BUS_NUM_MASK)),
>  		     cdx_dev->dev_num);
>=20
> -	if (cdx->msi_domain) {
> +	if (IS_ENABLED(CONFIG_GENERIC_MSI_IRQ) && cdx->msi_domain) {
>  		cdx_dev->num_msi =3D dev_params->num_msi;
>  		dev_set_msi_domain(&cdx_dev->dev, cdx->msi_domain);
>  	}
>=20
> Then I suppose vfio-cdx would also have the option to either select/depen=
d on
> GENERIC_MSI_IRQ or perhaps get away with stubbing vfio_cdx_set_irqs_ioctl=
 and
> vfio_cdx_irqs_cleanup and conditionally building intr.o, depending on if =
there's a
> use case without MSI.
Apologies for the late response here, was on vacation last week. CDX bus is=
 supposed to be independent of CONFIG_GENERIC_MSI_IRQ.
Will send a patch to fix it on similar lines suggested by Alex.

> Thanks,
>=20
> Alex


