Return-Path: <linux-kernel+bounces-868454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 833ECC0545A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4204030E7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C1C307AE4;
	Fri, 24 Oct 2025 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ftZHE2T6"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013002.outbound.protection.outlook.com [40.93.196.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666D92C027B
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761296544; cv=fail; b=BCf/nZvEHvz2r8Cb8LZDylwH8b7L165JUjEGCh50Y4pWqI6Oa25RUNfwaSdUd5CIviDklZqjUkyDsIzngFzqZkRvY+N8n54u0K5EUYLbvARIDsji1podwbXwcnsaV1jorCx2ioZ+i22hFMoPAfJh+ruPWZEIa/b3BQWB6yxPjLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761296544; c=relaxed/simple;
	bh=CbECUz3Oioi46lHDhHz+SvQsUtK5qrhMNwhvbpvaCuI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fhAaukBFaLXv+9ASmqGAjC5BFtJS4iScVQC3fccPND/qHrYFGLQUOg/QydhuXcf9fbMNbdU0gw21qs8Hm0SjpvRaYIlReHBE7W7u5JIC4E4MxCFhWOSqI3XqKvYk52T4nq4dlT/zaVMmxWzwXwH4Jm4HGaIiEnnMcfpMlBDDUlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ftZHE2T6; arc=fail smtp.client-ip=40.93.196.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BR7w+nNlqf9VPgFrabxkttoy/3f426qo90f0VKhZLbYCAPQ1GCIKuKF8b5gN92aSn8nQqHcmPaM6Kd91dCF/HBAnD8FIJvHcsNhOdeULwIwyIeaSlT6HYHc3VR1sRvtTbPtLdbGNZYBpy8rbUw0EH2yD+EGp3XnEIfiHqJxRGfgTip+eug8O9iRSwNpfSMl3QiDO6KJbaXEMoYOr1P3MY0QzGo1agvLifTfFAYwjBN3AwENjOOUA4QkTvLiNIXe1Y32TZuVHrt2lGbXAXk1xL40nKXS5Y/uswUhXTqWX1Q9I2iOYO11u95kx76SRtp5+8iatwGv4gleLCwG4GPBPfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDdGYqt440YGEMcxD53xq9W5C0pFEE4qOkZOVY3Wy5Y=;
 b=K/6MRSTSbt2xrzsmHSCDl8Qqvk+Hgak8kbcnQJxUfYFatJOBIx2ZKhKCZcCLOjwNM3boxGvkp2I//pT6vc6kv7+VaDgXsI7Dn5WgkHcPNgBQVrleST+OPrp3vwCLuGent5T3wQ43LdjsGuiXJ93+T7iSMz2T+YR5tlHEh2QHppWVcZ7QsM5UGzk1vbzIOVI5t3pPhhWp3hvZ5NqEDxllR3leWKut3k7mgx5GTGoMlBje7UPWxZCey9zeIVTZrS6XZVXAQeGKM5+BTXaD8yXrQGU9E6RrBgnE4g2/jDaPacvtZgaJ4cvlwBELRsEj7UsRmLza1oyFnUZXD2NhL8B0nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDdGYqt440YGEMcxD53xq9W5C0pFEE4qOkZOVY3Wy5Y=;
 b=ftZHE2T6YJV7h17FhCa6c7AuTEDoCKvuAMY7Sk7ET+P7wnkjcErhhtDh5HygwCDJ6wqgQ2i0ltSa2NPADZ+7zyGLPqjeAJ4NVtOtAnfPvyxXMh3jScf+9Tu7XL4D2YfU4iQpSkgDlIBY2GsVq6ydOOb37f+77BBg9br1NrGAaocnSNoiSi//p1OW2DH4J/1f5op33+XvQsFyC/tshCy6vGl67jyDnT314vUkTKqilHeafJ59nK34n6cRKnIVC+aSPl93cRLycsCTDL0BbOqxq718AUEW8rfA0W7NtaI+XP6egXgVZ2zNVzxj8gnsPjyZGxLLdeKrMi4XjhIYB/FPJQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 09:02:17 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 09:02:17 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "muchun.song@linux.dev"
	<muchun.song@linux.dev>, "osalvador@suse.de" <osalvador@suse.de>,
	"vivek.kasireddy@intel.com" <vivek.kasireddy@intel.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen
	<nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>
Subject: RE: [PATCH] mm/hugetlb: Fix incorrect error return from
 hugetlb_reserve_pages()
Thread-Topic: [PATCH] mm/hugetlb: Fix incorrect error return from
 hugetlb_reserve_pages()
Thread-Index: AQHcQ2GjKInT3bUUjUO7F0yg/LEZTLTQ/5YQ
Date: Fri, 24 Oct 2025 09:02:17 +0000
Message-ID:
 <CH3PR12MB754879F2AD53D8317BA13AB1ABF1A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251022102956.245736-1-skolothumtho@nvidia.com>
 <20251022143906.2780172-1-joshua.hahnjy@gmail.com>
In-Reply-To: <20251022143906.2780172-1-joshua.hahnjy@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|MN2PR12MB4374:EE_
x-ms-office365-filtering-correlation-id: e10ba3b5-c25d-4aff-9679-08de12dc0860
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xVDgQnK0+mezx+S69oViS1zV+jcbF0KNxMiEIA+QHqzH3MwZcKgDiJ+ewebw?=
 =?us-ascii?Q?r/W6IIAj+EJTYkqsyW42ap+bYocEv5Ea1gQxq1TuGn8ab+MCxY2K6CGWPsCf?=
 =?us-ascii?Q?h55143nP+t+hSNknLl6QD9tSwjYQ33lDgmw9QhXMd74ShpVKVQpGAuAPI2G0?=
 =?us-ascii?Q?Q0mrGcZfuJh/ALaROWR4poyQCw2tSXTBnCWpw+g+/oLiaDGWZL+v8cyW9yxU?=
 =?us-ascii?Q?qWYrYmCe02iTC9nGhQpTpnMuWu/cSWb9e8n4Vai0042wsdQG+K8waAnXE26k?=
 =?us-ascii?Q?dNdcTKwC+jzGcubnb0ln7NIdjiQ5Gu9RT8/PF7vUBMKxcq76Vlur0EbrXSCT?=
 =?us-ascii?Q?2vtqQBoPPoXCNcwe87+qeD7kx8heB6yY6pV32Fiy72thLmPBDfLCks7kWU4n?=
 =?us-ascii?Q?uiRxK3PYrRiud8u757Wm3wd5UIXOTRZxIVNFqB3gplYpTDfKPC2TgThw0cNZ?=
 =?us-ascii?Q?2PLVb8xuaX9I2DZo5SGC182FIvZIObUEuI6YTkMXNOQuJR3v5WLi04xT6DKU?=
 =?us-ascii?Q?iwEmlN7rIUBUnAD1aAhbgk8Azfss8RUPL2M56+uJ9Sr6i3edjjoz7xmUDm4+?=
 =?us-ascii?Q?3QONAD5OH/SANTPT2kyM6gqyEjdGBTccEFi6ePVPeExt936wedOuYMdyW1lQ?=
 =?us-ascii?Q?Zpw033u+7QT/uKu5IIhFtRwMmXM75Pb6FFTIl3w+seVg0YIVvOdpg6SnmNoJ?=
 =?us-ascii?Q?pMQW9TQLwblyUkHf6GY6bHAA5nZ5uLkCe2E8WYTyAaRJw8sYv8dsSzt6n/w2?=
 =?us-ascii?Q?vtGMYcx60pZVuGX4w+g8guG9iORkRz9edxsWqbXiTWhvOZk/6eJ9/q/B9z6d?=
 =?us-ascii?Q?C4JcgG6M9HdgSoJY1HeVnya1woY+74G68S3T1lf0KlH9Qe4/aQUlxvTBcmLq?=
 =?us-ascii?Q?9NrFv2nB8wQU/6GHs0OyMdiK4az3mYLVB9W1I8GCMA/5Bl+FHCOqFCysSAX5?=
 =?us-ascii?Q?5OybhfSE81pyOB+cahff4FGAdY3YI7wP5aZ9i7l7LaztujfmbU6cPKU5whpE?=
 =?us-ascii?Q?4hygMlTjYZVvcz8WeqzH7ytU1ei4QGknq8ojSkNn97nYtaS85sZG/zRI2sDY?=
 =?us-ascii?Q?vWy7EyFAIKl4k6JzJe0m2sFXDUwIBgda42oP5tc4Xkgx8eW3vwsDS4PO0RwW?=
 =?us-ascii?Q?NfN9agOw4mSNUEEWFqvyam8W0dKQWRhlpibojmdNnforiLz7NJCrsRLdgUbj?=
 =?us-ascii?Q?gWHZJr+1/ZB5LqJIWHXwcDeWMatrJz+oDHDp5kmBwVseX6jg5lFaKi2W4Fm/?=
 =?us-ascii?Q?d3/4Vi5qHOxpP7IV9nEm4X4NNYKdVoc8T3gpgO0QMdnB+pjYcEu1lWGNr5D2?=
 =?us-ascii?Q?rHd6bLXXtE2dvXk1b/RIIRPLXqjryJiNxVg48DsCuf+S3qUs9HvMR9XR71o5?=
 =?us-ascii?Q?nvFPfDjj8q5qfoG52iqCQDj2kM66WPLcz2b1Uk2CB5rNdSVd1yNKjV7ouPN3?=
 =?us-ascii?Q?mFQBdzShuPVLGABC7iVy9WsAwu8/K8hUc/ZWOvgnbHRgLpan9NrFlB/zpeLx?=
 =?us-ascii?Q?u/BAyhK76p7ajLb3rZK/VFWoWB5h7SZBCyWX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4+/JLQLgYsE3UoooB+2tfqsTa6O/FChYJ7c3WrGvg6vWW+75mPpwEFqbToPh?=
 =?us-ascii?Q?0mQG8Tyt3Lph9GM3XG+aPpQoJJRa4Ip2ul6lNN61PvTPI8jazGNO3HZOVVxH?=
 =?us-ascii?Q?umKjZmJAAD0p/YWdOPhY2fH04Wum3Mp24xUbEoGmXI/W6Bi5stn7HagU8xVU?=
 =?us-ascii?Q?tFlpbMy48MKCHQOk8mEvl7/rF4WuZffB6UEAnCqtmrD5DXBb38b1e+CDWVnH?=
 =?us-ascii?Q?QWyTfvES0a7QHuMzkE9yEVqIq7gzxyLKAsh3ijE31YQSp26cJSW6BVqpWQ4s?=
 =?us-ascii?Q?Qz9LL8gZwM2F8yDJ6GW9PvU7tYi1ZBgbzG+OQOakJJiGctCIsS0IVOMamm6Y?=
 =?us-ascii?Q?I8vZkGQ/6XwP28p7bFjzQXm67Q0UNqWi7x9VLtj2fVXfz7bRX/XoPH1vzrb1?=
 =?us-ascii?Q?eoOPYr6XfxhrnbgUXr94+dncd/e+K/Q3UEj9lKuaZGpx2mh7FTn+Zfdkp06q?=
 =?us-ascii?Q?KbLNoall/fA2T/pBPcPzdRZ/Vhp1uLsezyVs54eLUe/nJmPX1e8VumDdtO0V?=
 =?us-ascii?Q?FbMMqb8rf3whMFPP8Qs2hEJRjS3ox+XbEj+hbK/qDNtQIucstgdjzgm5wSeg?=
 =?us-ascii?Q?MV94QbeR/UMsZ9H0EpEYIeOKHNK0/YSW9+ogf1TqmC5cCc6K+11Orp0+B45J?=
 =?us-ascii?Q?SZCcFU7JRQVisGu+UVNri59rMmxA/+sdMDEr82uD/Fyt+3HaZ1JYmLrdRSVc?=
 =?us-ascii?Q?X3aZ3SvTSse3YplYDU2cul58CJROHb43imcBs2goLzVZfJjcoT08nDuwNTkE?=
 =?us-ascii?Q?OpejVIq72tl6xCDJ2ntye383yG4x/9/UacD0wrYQc8fo2LTSbJpVtpRis9Nb?=
 =?us-ascii?Q?HXXlJ5X7ux/C7VgXte8/2JPxDCZ7rTYU2ilPJYO0LsEcnLDJvMbkquP5fNVx?=
 =?us-ascii?Q?DFV/KusPp1CKBnf1zf51E889y7CEid8tJRbn/Y/24gglfxI6PDrDZGS2mqzG?=
 =?us-ascii?Q?6Yj3UNT3QxANYO3kCCqrltBa/loAn39EVNcqBkGA7LUVdrk+hy7e33mgbBpS?=
 =?us-ascii?Q?gBoAWLoLBJdCA9MjMzhsDuzD/6UHSZ6YVWcwLHGvH6h9f5grxP2XG7gTkD+C?=
 =?us-ascii?Q?QR38JUSr5KlXWzqFQ/+WrdY/pF8d3uFS+iAhCVacDSDzLmcfsUVcUm9Z+rHS?=
 =?us-ascii?Q?iL3Alr54JMrwoh3cvO93XXGnM8H2WDluUM7mHwP3XMoy3EdPFvk1SIsNhicx?=
 =?us-ascii?Q?V7xdayWZNd7rAr/wz1nr6Kne5tqx4A7n7DHxlsmo4++rKb4IJG2zD9+Rq9ZC?=
 =?us-ascii?Q?83B+oGSooHxszxOUT9nuOXfbSbFuOr/8CY00ESSClcgetQGXiKA47kFZTngN?=
 =?us-ascii?Q?LHd178xMx9q0Ap/QkZKMdIscmqkcAZnNcOEjFrCTylVMSt3vwlKq59FwzfcY?=
 =?us-ascii?Q?V6ZlB+ialkc9y9DFezVe5J0yZKjH6J1c9PeG3x1KRu6MNgADGNYmAqlpKlUj?=
 =?us-ascii?Q?EMEnPcxKbOlzD1N5JCUms/KI7jilYOj7ZFFzx6Mul6474QHKTNU/PFRlS1sn?=
 =?us-ascii?Q?bd8WsYN2iv+9y2OmlnGg24lWoVbUpkl4j73siqEpeLw0VkRLNHZBYQwfz1PU?=
 =?us-ascii?Q?efNVB+FmuUQPLOJDeH+DfyaTHKdxGpXACMk9rXyl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10ba3b5-c25d-4aff-9679-08de12dc0860
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 09:02:17.5398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4Qepz+d0cvBy4XAZEmIHrB90Dea2XHDh/JX2E/oOcf0a7JtgoVUNEdRqefpKScT06OmSlX+xFLlYa+Dvq64cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374

Hi Joshua,

Thanks for taking a look.

> -----Original Message-----
> From: Joshua Hahn <joshua.hahnjy@gmail.com>
> Sent: 22 October 2025 15:39
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org;
> muchun.song@linux.dev; osalvador@suse.de; vivek.kasireddy@intel.com;
> Jason Gunthorpe <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>;
> Nathan Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>
> Subject: Re: [PATCH] mm/hugetlb: Fix incorrect error return from
> hugetlb_reserve_pages()
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Wed, 22 Oct 2025 11:29:56 +0100 Shameer Kolothum
> <skolothumtho@nvidia.com> wrote:
>=20
> > The function hugetlb_reserve_pages() returns the number of pages added
> > to the reservation map on success and a negative error code on failure
> > (e.g. -EINVAL, -ENOMEM). However, in some error paths, it may return -1
> > directly.
> >
> > For example, a failure at:
> >
> >     if (hugetlb_acct_memory(h, gbl_reserve) < 0)
> >         goto out_put_pages;
> >
> > results in returning -1 (since add =3D -1), which may be misinterpreted
> > in userspace as -EPERM.
> >
> > Fix this by explicitly capturing and propagating the return values from
> > helper functions, and using -EINVAL for all other failure cases.
>=20
> Hello Shameer,
>=20
> Thank you for the patch! The goal of this patch makes a lot of sense to m=
e.
> I just have a few comments:
>=20
> > Fixes: 986f5f2b4be3 ("mm/hugetlb: make hugetlb_reserve_pages() return
> nr of entries updated")
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > ---
> >  mm/hugetlb.c | 25 ++++++++++++++++++-------
> >  1 file changed, 18 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 795ee393eac0..1767f7599f91 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -7269,6 +7269,7 @@ long hugetlb_reserve_pages(struct inode *inode,
> >       struct resv_map *resv_map;
> >       struct hugetlb_cgroup *h_cg =3D NULL;
> >       long gbl_reserve, regions_needed =3D 0;
> > +     int ret;
> >
> >       /* This should never happen */
> >       if (from > to) {
> > @@ -7308,8 +7309,10 @@ long hugetlb_reserve_pages(struct inode
> *inode,
> >       } else {
> >               /* Private mapping. */
> >               resv_map =3D resv_map_alloc();
> > -             if (!resv_map)
> > +             if (!resv_map) {
> > +                     ret =3D -EINVAL;
> >                       goto out_err;
>=20
> NIT: What if we just initialize ret =3D -EINVAL in the declaration? Then =
we
> can just preserve the original code and goto out_err here.

I personally think assigning the error code makes it more readable with wha=
t err
we are returning.

> > +             }
> >
> >               chg =3D to - from;
> >
> > @@ -7317,11 +7320,15 @@ long hugetlb_reserve_pages(struct inode
> *inode,
> >               set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
> >       }
> >
> > -     if (chg < 0)
> > +     if (chg < 0) {
> > +             ret =3D -EINVAL;
>=20
> Is there a reason we set ret =3D -EINVAL here? I think it makes sense to
> preserve what chg would have been returned here. There are two ways this
> value
> gets set; for shared mappings, we have chg =3D region_chg(), and for priv=
ate
> mappings we have chg =3D to - from.

Ah..I missed that region_chg().

> For shared mappings, region_chg() may return -ENOMEM, and I think this is
> something that we would like to propagate, as the commit message of this
> patch suggests. For private mappings, it does make sense to set it to
> -EINVAL, since we don't want to return a random negative value there.
>=20
> So maybe something like this? (Including the initialization of ret to -EI=
NVAL
> from above)
>=20
> if (chg < 0) {
>         if (chg =3D=3D -ENOMEM)
>                 ret =3D -ENOMEM;
>         goto out_err;
> }

Makes sense. I will update.
>=20
> I'm sure there is also a more elegant way to handle this : -)
>=20
> Although, there is a rare case that region_chg returns -ENOMEM because
> add_reservation_in_range returns a negative value equal to -ENOMEM. In th=
at
> case we want to overwrite it with -EINVAL but will return -ENOMEM instead=
.
>=20
> But this seems too rare : -) Maybe it makes sense to change region_chg or
> add_reservation_in_range to check for a negative chg, and return -EINVAL
> there instead as well.
>=20
> >               goto out_err;
> > +     }
> >
> > -     if (hugetlb_cgroup_charge_cgroup_rsvd(hstate_index(h),
> > -                             chg * pages_per_huge_page(h), &h_cg) < 0)
> > +     ret =3D hugetlb_cgroup_charge_cgroup_rsvd(hstate_index(h),
> > +                                             chg * pages_per_huge_page=
(h),
>=20
> NIT: Should we just unindent this line once and include &h_cg on the same
> line? It seems like the original line also pushed the chg * pages... to
> before the open parenthesis in the first line anyways.
>=20
> > +                                             &h_cg);
> > +     if (ret < 0)
> >               goto out_err;
> >
> >       if (vma && !(vma->vm_flags & VM_MAYSHARE) && h_cg) {
> > @@ -7337,14 +7344,17 @@ long hugetlb_reserve_pages(struct inode
> *inode,
> >        * reservations already in place (gbl_reserve).
> >        */
> >       gbl_reserve =3D hugepage_subpool_get_pages(spool, chg);
> > -     if (gbl_reserve < 0)
> > +     if (gbl_reserve < 0) {
> > +             ret =3D gbl_reserve;
> >               goto out_uncharge_cgroup;
> > +     }
> >
> >       /*
> >        * Check enough hugepages are available for the reservation.
> >        * Hand the pages back to the subpool if there are not
> >        */
> > -     if (hugetlb_acct_memory(h, gbl_reserve) < 0)
> > +     ret =3D hugetlb_acct_memory(h, gbl_reserve);
> > +     if (ret < 0)
> >               goto out_put_pages;
> >
> >       /*
> > @@ -7363,6 +7373,7 @@ long hugetlb_reserve_pages(struct inode *inode,
> >
> >               if (unlikely(add < 0)) {
> >                       hugetlb_acct_memory(h, -gbl_reserve);
> > +                     ret =3D -EINVAL;
> >                       goto out_put_pages;
> >               } else if (unlikely(chg > add)) {
> >                       /*
> > @@ -7423,7 +7434,7 @@ long hugetlb_reserve_pages(struct inode *inode,
> >               kref_put(&resv_map->refs, resv_map_release);
> >               set_vma_resv_map(vma, NULL);
> >       }
> > -     return chg < 0 ? chg : add < 0 ? add : -EINVAL;
> > +     return ret;
>=20
> We only return ret in the error case. If I understand the function correc=
tly,
> this part is only reached if there is an error somewhere. Should we renam=
e
> the 'ret' variable to 'err' instead? I think that will actually
> add some clarity to this code path, since it's not immediately obvious th=
at
> this portion is just error handling & propagation otherwise.

Ok. I will update.

Thanks,
Shameer

