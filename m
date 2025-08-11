Return-Path: <linux-kernel+bounces-763130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62546B210AE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E779A18A036B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445102E7BDB;
	Mon, 11 Aug 2025 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k7g36XTk"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872962E763A;
	Mon, 11 Aug 2025 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926635; cv=fail; b=Z1JK2fgkp9Bu4Q5j2zQyo/rdXCVW6MN/oifgbV2HTBlw5xy85BA/RTHk8FvL6frqasEU8LPdrq9nGsDzusjke7n8MkhqnFe3ORGD/IvXaudxwmjAcUroDJypDFsZLu59nvE0J83zdiytukufB+2aRMRdh2U9OXEe49+NYub6aZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926635; c=relaxed/simple;
	bh=QGkXnI996U4JG+u1KbLXP2Tis2tTV/2ckcTc7RWFObc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Oye6MOGw7gjV/pgeoKQX0UxT6xrJDdRAvyGF3JDD05CJgo2JctgGLKVMlKOiLe/dZg4uubPUiWRGMy85VgAMW9gdBxpdE/DkQU+84dBkX19cwEoNyZ+XbX2xg2NkJm+ST+2w5IdUqlqArjDo8HqZ7r8005MLipTQB7O7phY3K/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k7g36XTk; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oo06xY19OiVi2406zwnF+XbvLugPaazyAebE0zzIkh+dpdSrEMiDc7kUr41uOudSUQs4BZ2ro23FARVU6DbtSV/JnpPqbVVgOcLClHkFbX/HfM3OvKC9ggD8sveSfZ3NNqxenVVxd1xIwlxIu38jWzXhaKz0eh1WVV9c0/ePMCHnw6D1V/ZqXTG8D1ciKggCJfA4RDkL6gizwL0ee6HxVe0xyNl2OTjXYx2L/EGBwUK+8Q1H5iv3Lnv/18JKX2EOEb6qsfJLQywvkw8fN5pq9I8s8jicf1+NXz8469o6/9fc8Y/hjmo9p6y+fSIMoMPh+qRjJi2k/B+88Fc4pmGoow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5DVX+guOyXL8OW2o8xvH+HyL3N6KHgD+SD/3B3TNw8=;
 b=HOJUKTKxEqFFdmNqY2kAzmHQTh6IYb7vqSeGu4cx84CYFLLTaTDSxIv9lX+K+0bQCAVDX7TbXVaNTaLIzW2Z2LwhUkzYfLqPN44tnYoloZostLmWFx/9ik9GuhvpJywFrClMu1ElBO29T9pw8oirq3JEm+aYlG9ApGc5PUIzCTK4LSZPnfSh1vACuIxnPFz5eUp8xZFU55MwNIaxNqZ0hZp3qRc4J7Gf5spTOQjcL4CbQuHqxmWUQ+ou91f9gBOSW5gohcptwD1vg/yz1gMhBX7vMXjU3+5uddIvhIvI8b+vppaYoEkmPib9eYSSUQ5BsxIllaLWycAqRfXZFp9r8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5DVX+guOyXL8OW2o8xvH+HyL3N6KHgD+SD/3B3TNw8=;
 b=k7g36XTkUgV+o6m/TIfUZ07kfsy3/LamiGYdnl4hjToTNRG+0IuOrf+EtfsQwQl1laMLUVcckDMTT3Soa+TmqnNfSfiHAU4Ud/q+pqKdLWeXwBcT0NpTX2dGb7R491R4/oVtDFwYE6iHruwPgQ+Qu5K4vN/ILqf+7RHwCU/VjRM=
Received: from CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15)
 by DS0PR12MB7654.namprd12.prod.outlook.com (2603:10b6:8:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 15:37:08 +0000
Received: from CH3PR12MB8726.namprd12.prod.outlook.com
 ([fe80::9532:640e:4b24:7dbe]) by CH3PR12MB8726.namprd12.prod.outlook.com
 ([fe80::9532:640e:4b24:7dbe%6]) with mapi id 15.20.9009.016; Mon, 11 Aug 2025
 15:37:08 +0000
From: "Chary Chennoju, Srikanth" <srikanth.chary-chennoju@amd.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
	"m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
	"Chris.Wulff@biamp.com" <Chris.Wulff@biamp.com>, "tiwai@suse.de"
	<tiwai@suse.de>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kalluri,
 Punnaiah Choudary" <punnaiah.choudary.kalluri@amd.com>
Subject: RE: [PATCH 3/3] usb: gadget: f_sourcesink: Addition of SSP endpoint
 companion for Isochronous transfers
Thread-Topic: [PATCH 3/3] usb: gadget: f_sourcesink: Addition of SSP endpoint
 companion for Isochronous transfers
Thread-Index: AQHb7NiIYw8NFgvj/EqrXJrsZ06NirQh3cGAgASYFMCAN1vz8A==
Date: Mon, 11 Aug 2025 15:37:08 +0000
Message-ID:
 <CH3PR12MB87267AEF07FD710412DD6ABFB128A@CH3PR12MB8726.namprd12.prod.outlook.com>
References: <20250704114013.3396795-1-srikanth.chary-chennoju@amd.com>
 <20250704114013.3396795-4-srikanth.chary-chennoju@amd.com>
 <2025070432-mustard-mongoose-1716@gregkh>
 <CH3PR12MB8726582F9D4C3902AC94B5CCB14FA@CH3PR12MB8726.namprd12.prod.outlook.com>
In-Reply-To:
 <CH3PR12MB8726582F9D4C3902AC94B5CCB14FA@CH3PR12MB8726.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-07T10:13:19.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8726:EE_|DS0PR12MB7654:EE_
x-ms-office365-filtering-correlation-id: 5f78d571-0450-497b-c0b2-08ddd8eceec9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?r9biavldnXRleGGfoGD8XiTvXjgSIFQbYXUcrNtfytfcg+t4veJDPX7Fn+fR?=
 =?us-ascii?Q?7/gHvF5AuGYv+eJuJsyF0XUAWB5auPxmpvqu+0GuytZsetLvWHAWfJRe2zo4?=
 =?us-ascii?Q?F+EjgoOL0sQ/q8OswXL4HhiRINQpTYhRrzDpf3fAVbv6ba+hX6qIV6JIXma6?=
 =?us-ascii?Q?5fU9ugauDcCOqD6PC5hdildsMw3sDg6M0+tyl+BKqBlwrAXzCF+K/CofGNpG?=
 =?us-ascii?Q?facYqGLUUKEbm1/ft+pJCt8Uohuu6u7lVUFf1IG1OMHzRQBDYn3MIXidclvV?=
 =?us-ascii?Q?BrsUqi0Ia3EvwoZ+yX/Z0OQwz/tqXC6Na5VXuPuEWsfK93sm7Xj9uTqnv+pm?=
 =?us-ascii?Q?Q0El9E/4ZfvYLdXAbPurBOd1fw9DHJuw914afqhwlmCZKQHCbKETeBdx/uU2?=
 =?us-ascii?Q?026gYedtmPLF3vj/QPATShuT/qSU9KvUOcO6btbFOhUsBSw5unF/3tmSGZPF?=
 =?us-ascii?Q?ZbHfBG1Q2NnezDFeh8GYLEnRsBA4BVbSM6RRI1DkY4uE2v7Hy6XZwnbb897/?=
 =?us-ascii?Q?K0izQIoU6jItlJsWGDGav5ByYINXDdTtJVe6ztO1KdOKvEngZuJ83gaaY2GT?=
 =?us-ascii?Q?i28ejk/F5qlwe4alRPPD+yvGU4BdL1mcuDmiGHi6IMZWD3wguLotzvxwQkWM?=
 =?us-ascii?Q?HQ3BSTGwP4dfRBdQhdbwtFZwDO3ZX8VS9ZWcqWG8ATlmGysp33uRCZpeQqCv?=
 =?us-ascii?Q?EKnIATXnS91e4N7qVFQUtBgJ0ZWaDa9MXR1Vg5AekSvKQXJh2B1hhZnjn5ND?=
 =?us-ascii?Q?MOSDBkggCKV01rUofiwATMHT5Mxy7ZZ8WQl8/VclJVxdXkOURGJFAr5Zg0f5?=
 =?us-ascii?Q?GRfBtTHBLW1JIPSi6arRO67jIIltzFXWPP9mcfXFjaRGut7hH3XJMwJmSwRu?=
 =?us-ascii?Q?6gzd1DCL0bD0CjsPoNnyArD5t2y98ftED749dSlUOdj1lXMUXoQ75VJIVtFx?=
 =?us-ascii?Q?BMWCM/umdoAyCddrYc23QZZ82dva5SYVLVi4rJVLbbzwFlOQa/tNzdgof6lB?=
 =?us-ascii?Q?g5Eqqsc+AfQTC/tVdeoK5ymCGoy7GW4uMOXwrTQW2BhfjZLiueS7smeAoHIC?=
 =?us-ascii?Q?UwlFXYMG1dUk9YJ6HD963UvsTGvzZWRRX7YfcHv4zp1mAfM5nb5jyGrHYPBD?=
 =?us-ascii?Q?truYXzq2/VH0am5PDHMvl4EE/ROcrCT3AfEmVzT9ZqSO9P2Wq5esxr2Ht3g4?=
 =?us-ascii?Q?c5IlkxzRvH7Fiqjyc4ho7rM+RRbwU7WJG7VrcCRgTS7ABbtz+4ZcQWwQp6bn?=
 =?us-ascii?Q?RhO68UWkqwi/Kq6Bul91s22giAPUba4iXWG3lfftePSWRsIh9cIN+LAbWv7s?=
 =?us-ascii?Q?Gue682j1wIHRAWAT36OGgNOHyaZyu2hfuD2kdTuNdOWcLN+kfNP/0lTIhBn3?=
 =?us-ascii?Q?7FR90Ce+fC+ByrOPXIkMcqL/qiJhVtVOvCceu+ZHqj2d3ZYZymBgrEiZleb9?=
 =?us-ascii?Q?MNg28lKOmoxqbphADQkJwoJfXOp6urncPqaEHI5jGBRvO5QUv19Qdw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Mcfi3zLx8a4HL1Udftx/l+Smx3itctAda5i7MNCGN15QOD43IfGz0B4FO81C?=
 =?us-ascii?Q?phhw4YnbcjoH+UJ/m6nrnHEt0755nxJivOpf0+LyFy5D64Ps7bOoHvCG13mg?=
 =?us-ascii?Q?4JAK1AKl9QECMxZCaoLmCjgahHZ4pQFArD4CGc20p0HvbjjUWf0BQTg5IDXo?=
 =?us-ascii?Q?9vKNJSUfBp6gt14oKNOfXlPy6j7gyW7tK1SxY19B5EnjFKraWEYlH4uGSUX6?=
 =?us-ascii?Q?WyZTGG8tw/ToB+SsjYJBhERVd7R3qg+o9xvQu2GATfOKjLgMpeJAx78dGqiI?=
 =?us-ascii?Q?foCRjkiLIImX/TwEZOdPwIN87tWYBqyy4HnGQrjsZGz9uUiaghKXS5MpFlQF?=
 =?us-ascii?Q?OyJemqXeMKTD0ZbLaG7XTKaRKiKGd34JCW6ebcN/83LdxW+sIlQp8IOM3fJk?=
 =?us-ascii?Q?eKL25EZVsAIMQe+dOurBS3GxBX9ri4+vrzX3HAufAf33EGACCUEaXS1L9y3E?=
 =?us-ascii?Q?gWmuRrbgqqueZqSjEY8/uXuxnCcD3DMLkXS6fdnW1VmhuXM0wo7+tK46eij+?=
 =?us-ascii?Q?PP0bzXQ6rQY0dcZYUNlDJ9oY2NnQgS8iygS8gDVsuHh9J7MiLml4LiwqfoeP?=
 =?us-ascii?Q?roTDMeln/uZYqOWKwSSKO8LvLd3oMUYMNrlyQGPwScx4kIpz0Esi2iugsToK?=
 =?us-ascii?Q?kBhlqG214PNN5aGiMEg9EgOJkAr4qMDN2REZoLTFj9AaTOjtswPJelMvVK7Z?=
 =?us-ascii?Q?00EolAzWjObup6k6tYJ1QHMkQaehl2C5E8MoZAgC9oJpWs2zaZAm0PXaG7iE?=
 =?us-ascii?Q?7Dj8hHjx/xgpCTNg5MVLcEaOOpzTNWDPUeXnozxHg9G5c5+H+JN3VhzpBpta?=
 =?us-ascii?Q?yKushPAlyzSuaJYYNja+6Zfxt2xIW7l452QKmIu++pP7s+sv2CGmZpEj/Kz7?=
 =?us-ascii?Q?6MyfjcO3z9RJ4aulsY9MGuCxQhiFopM7kmYHPDOlHBFD1pAqtj77+LqkUMKa?=
 =?us-ascii?Q?Ch5oAEU1eWRA89Ef+StGH0o4Pyaz6xzP+IX5eC00SNnYbvhmQ++784yL5l3o?=
 =?us-ascii?Q?FJmeCmCr475BdaTuoPELttrFA7iOeLBc5DT6JqbKju/mFQDSPtRjbD4hHyWd?=
 =?us-ascii?Q?x3doc2AqKxoUMy52z0tOES/uiKYCxT0GowlnEuo66jk0ilsK+BPkCpnhVAGM?=
 =?us-ascii?Q?nrmerY3hJhGTkPNfR7BcieKx9IZPB21aLFvCKo/6Emyl7toicDQxx2XbQXHY?=
 =?us-ascii?Q?FWemzeAPoL1nQJg30woTdI9qplcmb8GBNEDkx9c3t3DvKUtsL0HEp7hNnq1H?=
 =?us-ascii?Q?fHY9Mzt0aSGjKbGIjGQyRyflGc0ZeUk/Ud5jxLAPRojDNIG2gJiFacSkd2N0?=
 =?us-ascii?Q?rXopQ0/xHGMMZkDtrDIK60eLZirP5jsGscYpXresOGTE7uzpXCvZdwCHjKqH?=
 =?us-ascii?Q?s/hXLCRPcO5dT3YECxO7y4UD5utLZkr/xOPrAJEZJtlQ8u6s14EypXUb3ItB?=
 =?us-ascii?Q?Ycam+aK5XF9O0Zas0Ke6DQ2gjGnOhpuCghnjOAKPJRH5t/TE1+FYtjSV3xUU?=
 =?us-ascii?Q?Arsoz6oJAdaHBZ/ORaqW9ftiNGt8aqK1tNKk+Dw/JtyG6D/7Ui0dM3VCWBEE?=
 =?us-ascii?Q?csVdT6FGkuzqfsAvYK8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f78d571-0450-497b-c0b2-08ddd8eceec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 15:37:08.6419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J/0jYIsYcOnzZpgOIBk/B08SOSm5WSSX1lvmgeChbdMwqBW5vD5LZDNj2B8Q3p4nrfQ9/jEPw8xQ9+Sm+8qGPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7654

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Greg,

Please let me know if there are any comments for this patch.

Thanks & Regards,
Srikanth

> -----Original Message-----
> From: Chary Chennoju, Srikanth
> Sent: Monday, July 7, 2025 4:09 PM
> To: Greg KH <gregkh@linuxfoundation.org>
> Cc: Thinh.Nguyen@synopsys.com; m.grzeschik@pengutronix.de;
> Chris.Wulff@biamp.com; tiwai@suse.de; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org; Kalluri, Punnaiah Choudary
> <punnaiah.choudary.kalluri@amd.com>
> Subject: RE: [PATCH 3/3] usb: gadget: f_sourcesink: Addition of SSP endpo=
int
> companion for Isochronous transfers
>
> Hi Greg,
>
> Thank you for your comments. Please find the inline comments.
>
> Regards,
> Srikanth
>
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Friday, July 4, 2025 5:34 PM
> > To: Chary Chennoju, Srikanth <srikanth.chary-chennoju@amd.com>
> > Cc: Thinh.Nguyen@synopsys.com; m.grzeschik@pengutronix.de;
> > Chris.Wulff@biamp.com; tiwai@suse.de; linux-usb@vger.kernel.org;
> > linux- kernel@vger.kernel.org; Kalluri, Punnaiah Choudary
> > <punnaiah.choudary.kalluri@amd.com>
> > Subject: Re: [PATCH 3/3] usb: gadget: f_sourcesink: Addition of SSP
> > endpoint companion for Isochronous transfers
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > On Fri, Jul 04, 2025 at 05:10:13PM +0530, Srikanth Chary Chennoju wrote=
:
> > > This patch is created to support super speed plus endpoint for
> > > Isochronous transfers. Now super speed endpoint companion is
> > > accompanied by super speed plus endpoint companion.
> > > With this change we could see the Isoc IN and OUT performance
> > > reaching to ~749MB/sec which is 96K per uframe.
> > > The performance numbers are confirmed through Lecroy trace.
> >
> > You do have a full 72 characters wide, you can use it :)  [Srikanth] :
> > I will use 72 characters for next version of patch.
> > >
> > > Signed-off-by: Srikanth Chary Chennoju
> > > <srikanth.chary-chennoju@amd.com>
> > > ---
> > >  drivers/usb/gadget/function/f_sourcesink.c | 23
> > > ++++++++++++++++++++--
> > >  1 file changed, 21 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/usb/gadget/function/f_sourcesink.c
> > > b/drivers/usb/gadget/function/f_sourcesink.c
> > > index 84f3b3bc7669..6499e95e0e9c 100644
> > > --- a/drivers/usb/gadget/function/f_sourcesink.c
> > > +++ b/drivers/usb/gadget/function/f_sourcesink.c
> > > @@ -232,6 +232,12 @@ static struct usb_ss_ep_comp_descriptor
> > ss_iso_source_comp_desc =3D {
> > >       .wBytesPerInterval =3D    cpu_to_le16(1024),
> > >  };
> > >
> > > +static struct usb_ssp_isoc_ep_comp_descriptor
> > ssp_iso_source_comp_desc =3D {
> > > +     .bLength =3D              USB_DT_SSP_ISOC_EP_COMP_SIZE,
> > > +     .bDescriptorType =3D      USB_DT_SSP_ISOC_ENDPOINT_COMP,
> > > +     .dwBytesPerInterval =3D   cpu_to_le32(1024),
> > > +};
> > > +
> > >  static struct usb_endpoint_descriptor ss_iso_sink_desc =3D {
> > >       .bLength =3D              USB_DT_ENDPOINT_SIZE,
> > >       .bDescriptorType =3D      USB_DT_ENDPOINT,
> > > @@ -250,6 +256,12 @@ static struct usb_ss_ep_comp_descriptor
> > ss_iso_sink_comp_desc =3D {
> > >       .wBytesPerInterval =3D    cpu_to_le16(1024),
> > >  };
> > >
> > > +static struct usb_ssp_isoc_ep_comp_descriptor
> > > +ssp_iso_sink_comp_desc =3D
> > {
> > > +     .bLength =3D              USB_DT_SSP_ISOC_EP_COMP_SIZE,
> > > +     .bDescriptorType =3D      USB_DT_SSP_ISOC_ENDPOINT_COMP,
> > > +     .dwBytesPerInterval =3D   cpu_to_le32(1024),
> > > +};
> > > +
> > >  static struct usb_descriptor_header *ss_source_sink_descs[] =3D {
> > >       (struct usb_descriptor_header *) &source_sink_intf_alt0,
> > >       (struct usb_descriptor_header *) &ss_source_desc, @@ -264,8
> > > +276,10 @@ static struct usb_descriptor_header
> > > +*ss_source_sink_descs[] =3D
> > {
> > >       (struct usb_descriptor_header *) &ss_sink_comp_desc,
> > >       (struct usb_descriptor_header *) &ss_iso_source_desc,
> > >       (struct usb_descriptor_header *) &ss_iso_source_comp_desc,
> > > +     (struct usb_descriptor_header *)&ssp_iso_source_comp_desc,
> > >       (struct usb_descriptor_header *) &ss_iso_sink_desc,
> > >       (struct usb_descriptor_header *) &ss_iso_sink_comp_desc,
> > > +     (struct usb_descriptor_header *)&ssp_iso_sink_comp_desc,
> >
> > Odd spacing :(
> >
> > Please follow the format that was previously there.
> > [Srikanth] : When I ran checkpatch script with "strict" option, it thro=
wed out
> two Checks. Please find the snippet below. Due to that I removed the spac=
e.
> >  CHECK: No space is necessary after a cast
> #53: FILE: drivers/usb/gadget/function/f_sourcesink.c:279:
> +     (struct usb_descriptor_header *) &ssp_iso_source_comp_desc,
>
> CHECK: No space is necessary after a cast
> #56: FILE: drivers/usb/gadget/function/f_sourcesink.c:282:
> +     (struct usb_descriptor_header *) &ssp_iso_sink_comp_desc,
> > >       NULL,
> > >  };
> > >
> > > @@ -428,7 +442,7 @@ sourcesink_bind(struct usb_configuration *c,
> > > struct
> > usb_function *f)
> > >        */
> > >       ss_iso_source_desc.wMaxPacketSize =3D ss->isoc_maxpacket;
> > >       ss_iso_source_desc.bInterval =3D ss->isoc_interval;
> > > -     ss_iso_source_comp_desc.bmAttributes =3D ss->isoc_mult;
> > > +     ss_iso_source_comp_desc.bmAttributes =3D 0x80 | ss->isoc_mult;
> >
> > What is 0x80 for?  Is that a #define somewhere?
> > [Srikanth] : There is no define. I can create for it.
> > >       ss_iso_source_comp_desc.bMaxBurst =3D ss->isoc_maxburst;
> > >       ss_iso_source_comp_desc.wBytesPerInterval =3D ss->isoc_maxpacke=
t *
> > >               (ss->isoc_mult + 1) * (ss->isoc_maxburst + 1); @@
> > > -437,12 +451,17 @@ sourcesink_bind(struct usb_configuration *c,
> > > struct usb_function *f)
> > >
> > >       ss_iso_sink_desc.wMaxPacketSize =3D ss->isoc_maxpacket;
> > >       ss_iso_sink_desc.bInterval =3D ss->isoc_interval;
> > > -     ss_iso_sink_comp_desc.bmAttributes =3D ss->isoc_mult;
> > > +     ss_iso_sink_comp_desc.bmAttributes =3D 0x80 | ss->isoc_mult;
> >
> > Same here.
> >
> > >       ss_iso_sink_comp_desc.bMaxBurst =3D ss->isoc_maxburst;
> > >       ss_iso_sink_comp_desc.wBytesPerInterval =3D ss->isoc_maxpacket =
*
> > >               (ss->isoc_mult + 1) * (ss->isoc_maxburst + 1);
> > >       ss_iso_sink_desc.bEndpointAddress =3D
> > > fs_iso_sink_desc.bEndpointAddress;
> > >
> > > +     ssp_iso_source_comp_desc.dwBytesPerInterval =3D ss->isoc_maxpac=
ket
> *
> > > +             (ss->isoc_mult + 1) * (ss->isoc_maxburst + 1) * 2;
> > > +     ssp_iso_sink_comp_desc.dwBytesPerInterval =3D ss->isoc_maxpacke=
t *
> > > +             (ss->isoc_mult + 1) * (ss->isoc_maxburst + 1) * 2;
> >
> > Why * 2?
> > [Srikanth] : Please find the attached snippet. For Super Speed, it is 4=
8K bytes
> per uFrame. For Super Speed plus, it is 96Kbytes per uFrame. As per your
> suggestion for the above case, I can create a define here as well.
> > thanks,
> >
> > greg k-h

