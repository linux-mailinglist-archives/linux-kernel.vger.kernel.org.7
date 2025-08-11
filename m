Return-Path: <linux-kernel+bounces-763126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3417CB2104F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3E737AD424
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23F22E54D5;
	Mon, 11 Aug 2025 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oftYfYUw"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667702D6E5B;
	Mon, 11 Aug 2025 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926544; cv=fail; b=CUisKOU/1UxLEhR9VktoplkVxn/V4IVIPjCl91vV93tFFeZftz8Knbv+l0O4EcOQNg0j7Fvwr6fy2TSYdruMW2kMdu/xuiyODbIyHQB+Y0GLkRgJzacMv2smiWw21cESMIG3qriT1oQ0FS5OfZDCJzxV7Oyp9apJrTKw/PPIgJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926544; c=relaxed/simple;
	bh=B+YabFwkqAbg4ZnlZtLnf7hoPVz6k1PH/cmXxfDY0ig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hXpYvqqLVUJPAOccZz5j3MXv9DGL/o3/LZKta2Ap2FjNwYR3VQLYQgK8Tj5sKPXublENX5xFBAwnR3XNaRZDSDNlG4v4ho4cY+O/0Uopa2CbxGQ9Fcw0TQS2qdR7yjUOcP138etkMdpA0XwVGdqKE8W6nC3E0au0kC5RhzoHujk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oftYfYUw; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvgXh26xdBVhLT3BGi81vpAr03Pgdfz8lahOPPFiDkDNyQEYAN+JRGZac0o33gc9NvHa9YugD/0O9dEIWceapjlFoXq3Z0p/aucwF+l7vhYefjM6QTQeeknz1lyhnyJkoEXpNkUVFnt1tUzRLVndYVxTMmO/QzjeTqm70L9jqdGld1eIIWBEc/kswfcWvJ//XiMFUn5bzAJI6AQQw/q8Zo75nuX9tueNMlCjt9u6staLBjEjec1H3mqFzIZPIpFw5Fv5wkMPO8GRA8GseogDevwn6Y+QDF/7Bv/3AQn5YmgOTLk/4wFDlUG0nafJxVOvgTo4zXAAb9Qea/TkODWv+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+YabFwkqAbg4ZnlZtLnf7hoPVz6k1PH/cmXxfDY0ig=;
 b=MIPd6UHPfEg6iIRSW2fdbqJefP4vXiJ11u2gjBD9O3sHjOroKACNtIut8q+Y65nSci1dN4P5AfnaufXSzDgH5gcy0EfaDcTynxGowaO0JQJHBhv2WbiCyEP0KQDmWUGCmvVeBLiQxOwz3OALg5+/wN/d5vbvXmo96+AbuWstn5pAUHkFXTqBNahuZOWJx8tace3ngRIb6rFXofDpv6UZJ0/Axo1iTaxfM+UpnNc5MrGCr65ZSRme7hHlcg9ukxRgIdFmNSYapURwcpyIGLGNbx8mNZkMxLbX6U3LuoJo1+7nW2JJCKDON7THtYoi2YOykMtalQW2/SIOPmRX/p6tgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+YabFwkqAbg4ZnlZtLnf7hoPVz6k1PH/cmXxfDY0ig=;
 b=oftYfYUw37Jw3zwr7TlUjfMLuPETkr5yRjDc28n4OBebmtmuY6jVvIXZbl7ODJYOxx3hRHm5v6df36nJPL+8seUBmtUmyBSgijyh+7ajC+3u/bVd7Iwp6pZTmuk9B8aM5lC/KL2EgsgGscB7xC9OQZYKGlhTOr6k1izr6yXoyKA=
Received: from CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 15:35:38 +0000
Received: from CH3PR12MB8726.namprd12.prod.outlook.com
 ([fe80::9532:640e:4b24:7dbe]) by CH3PR12MB8726.namprd12.prod.outlook.com
 ([fe80::9532:640e:4b24:7dbe%6]) with mapi id 15.20.9009.016; Mon, 11 Aug 2025
 15:35:38 +0000
From: "Chary Chennoju, Srikanth" <srikanth.chary-chennoju@amd.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
	"m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
	"Chris.Wulff@biamp.com" <Chris.Wulff@biamp.com>, "tiwai@suse.de"
	<tiwai@suse.de>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kalluri,
 Punnaiah Choudary" <punnaiah.choudary.kalluri@amd.com>
Subject: RE: [PATCH 1/3] usb:gadget:zero: support for super speed plus
Thread-Topic: [PATCH 1/3] usb:gadget:zero: support for super speed plus
Thread-Index: AQHb7NiAwNWfLFJOhkyHnTxCcA43jbQh3fAAgASe++CAN1Q5sA==
Date: Mon, 11 Aug 2025 15:35:38 +0000
Message-ID:
 <CH3PR12MB8726EF467E63B31CCD4BB7C8B128A@CH3PR12MB8726.namprd12.prod.outlook.com>
References: <20250704114013.3396795-1-srikanth.chary-chennoju@amd.com>
 <20250704114013.3396795-2-srikanth.chary-chennoju@amd.com>
 <2025070407-walmart-mobile-c0f7@gregkh>
 <CH3PR12MB8726ABAFBCBD1DD1DA3B1000B14FA@CH3PR12MB8726.namprd12.prod.outlook.com>
In-Reply-To:
 <CH3PR12MB8726ABAFBCBD1DD1DA3B1000B14FA@CH3PR12MB8726.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-07T10:38:41.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8726:EE_|SA3PR12MB8045:EE_
x-ms-office365-filtering-correlation-id: 08e2ccf0-2ebe-451b-d68b-08ddd8ecb8f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vRbmOztO3vyED7ZVY7kQNnzayC9iOOTXujINxNNyazwpayVLIbKAaC3aRljQ?=
 =?us-ascii?Q?Iut3I0hv1eV5Na+sg8w0s/0fqHY7oflQAVY9OJZlSY53bFbSk5dBVqMUkcLj?=
 =?us-ascii?Q?2qpwlTU1bFuq88bsNUfo2MhQgVpCV9b1YRcsecNv9PNeXd/i9+ISluKkuzyA?=
 =?us-ascii?Q?UAgPm/ylYvPA2c2R4t3a8mULngaY2kgK5xSE5QOCD09PpeY8+c17SC76nNyN?=
 =?us-ascii?Q?+AOtPXxpMC3mW/6IoaWsifxzvDoRp0xZi6PF6ftP46otwYpatXEkNppnConp?=
 =?us-ascii?Q?+L0WfRTonN4q0fR844cKFDXgUHUdbUhmaJgSX89cuSJdRS04CbJdbhGCjyXW?=
 =?us-ascii?Q?+t4GYQYlhsgVQkKv0CajZ1UACN5mW222HSghd2c9vvxiCQ+oah9FLK3PbAzr?=
 =?us-ascii?Q?tuLG5LrdPXojmR0qUg2Yb3ZJyAdZbi3mAOXZys8wM8d7wuE2yVI7UaClPP4W?=
 =?us-ascii?Q?rx5PL3uPLzBQQUlBKZrVhLUUL4nWoxNcFB/qV04awWXIr2mlYEPrWbgGJeyQ?=
 =?us-ascii?Q?5zss347pQaW0k4pItM2/jR6EBiQ3xT4llX4RGmQDYKSbNlXMWn+oVm/QACMN?=
 =?us-ascii?Q?cOpE4BnEQ1LM/tzpR5WqTL1GdEdOFnp2rIi7FLXeTuNGGYhb24iWU5sUOTjt?=
 =?us-ascii?Q?E+hqs5vLtFmU8vYqoMMaiwLTS51OsfSRn9kErhjkDqguXxEU/i+xTTjy4wag?=
 =?us-ascii?Q?Y2tec9emkVVOZ8l5ZETUVrnXi685/kHWO+uKxlnffdGI3y1c2o/qqBYtEBbt?=
 =?us-ascii?Q?j3FOqCDPeTq3FWpcDFbC7PYVTpGOW4Z7+IgxG4zJkcYlY6ZZxRdfratlLY6E?=
 =?us-ascii?Q?z8UnaRzk7Nb3mj59EUetEvVgUt4Pud5WwskITkoOIMBh+TVOjtHVGseZ8YbN?=
 =?us-ascii?Q?UhdCglwyVouPcvLp0JsyXAbtnUxAsbKwSbN1YbxSNTf4d9TTmzwcU0sVxMhH?=
 =?us-ascii?Q?HRYRthnncqRs9sYa4X6N1LVga/zCjM87MvYn9TzuInTkaJFaHwkGX+LV662m?=
 =?us-ascii?Q?BcgIFUJfqDkNf4mRjj0/6wTxgyH+YK0xvv4K0MXOKu34FvSBehAXFqR+AoIy?=
 =?us-ascii?Q?p0H2IKi2HsvoG72OAhE/J4w+Wa0d0NGtgODqmztImD4FbAkD2otlNynnt8Ul?=
 =?us-ascii?Q?8u0/OjKWAxXqVm7eV18zwQWOp20bjAE3n728QBNbAEjSzps0O8VfQ0YK4whT?=
 =?us-ascii?Q?b/ipaPWD2xZgv83maE5fUKj1QzNqY8cDYlKl0SqJ44DqLeIUCzQgCeJif+lx?=
 =?us-ascii?Q?gWuj2bsNp7fNKKM8IuTksaIEw10xVOZlKFCzJ5TT0ACp/VCOaRv7+lF4afxw?=
 =?us-ascii?Q?NUpx3Z7YEoXKe+Sa19io+f4b2XeN+GeNZtI4YVVO5cWKBHpAYNgb4+JSHnYW?=
 =?us-ascii?Q?VkvWZd8TzRsBoFmJX7gHE9WbEg7RYd8xpAE3pBVs1kppZnN2QAX5EtiJ2jnq?=
 =?us-ascii?Q?C8FnLkAn4VTVUg9kPL4RsHTFP3SttBXUJtOqJ8U+vlN2YodN9azYwA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1xFy5Pwf7Qb8XjTpk7MrM0ici7sKCM0zjOKp2dQE5XUZH5xyE0Dtwgj9k6ah?=
 =?us-ascii?Q?2OiKxdAT3I7/dKzHUbQThVvuE1EfG/VETeK4GbTIZmx9QthhhHVTOw25u51B?=
 =?us-ascii?Q?l2L6Srx5XRI6mRkezFeBAUI2/0qyD4YZQjoPwkaQl098Uuh4049ZIakvBphu?=
 =?us-ascii?Q?9bRXUXlMjax1KWOEQkroJnN1tYi7TDCUCuyQwPgGNY3aLnAtkqh/0UUkSXpt?=
 =?us-ascii?Q?MkB4k8jGaWUoShHMm0iLdndGFUK8XC4dDEXnBx8FwS3rztFETo5X0nik80Zs?=
 =?us-ascii?Q?dwZmhLIpwZmspdgqHNx57Sni18AlcwGNvbXkGnvLmC+BNK0bfjZBZnNb7jWc?=
 =?us-ascii?Q?roRmoZCvVGyIKdNAgr50CevvN2aCwM0Ibzi7d05UzHHEG0SAaDqZTZDE7VfW?=
 =?us-ascii?Q?wH7k7YAAJajteh8iPzBJZINADtCGwY1gtpOQ8IYCAl3tJDdw0P+3qtACiEun?=
 =?us-ascii?Q?pMvuUf0+ojcGyt0OLaMENR+8bIK+MzcjCnGodl3s0RXKC1yEnc0Bb1iHTUk+?=
 =?us-ascii?Q?wGwrpCP8yL2qfYoPkGkCSK8ry/MFRjsUcx/T+aFIXqd6XMWQEhLjmHcEqoEp?=
 =?us-ascii?Q?Y7KMYtvZkjA5TH5C7NvDPFPgyBIx1P75flS+SKMhZxdZvk67IKU9NsBMPRx7?=
 =?us-ascii?Q?hBYqXYNRqzc7qNRQ754QkPx/Hn/2n6dNo5XG2rb0vdbpc66CN5P43epbU4IC?=
 =?us-ascii?Q?7VW9ZSJaWzQIoS5vvIck/KMArY3qqVfDCI6QhsnPcGOSDFTLbFEXjpF9UaJ3?=
 =?us-ascii?Q?AbtQ2Y5D/7E2pDKTM1eLpwJWDHhVHUSYTvhpg90vkKlBw5xpFkq48ACfWrzw?=
 =?us-ascii?Q?+a4vKTLpXCo/kMHTBhRThB/XzZclpMcPrM0mFtFUMsO/RbBEqjo92Bp+ro4W?=
 =?us-ascii?Q?KPsnCxc41Z9ujHKNALb2FuBW36LMMP6kHJJpX65uRif0YA8PIav57J5/tMRf?=
 =?us-ascii?Q?rReIMLXQoq94J28KTVANCTeMeWuvNWxCMadkojAg8y02Q0f/40DaXhusbLot?=
 =?us-ascii?Q?6H/LjyuUcsljxVfnK0XqETEC0NW7U8MdffKNEXKxtmE/GkQEyAihnJyyklwA?=
 =?us-ascii?Q?leyO1rCh8b/79oFmxJWXbblK0wDTX59/aQs3kSUJLdNIEL0F+Dl0vW3rVI49?=
 =?us-ascii?Q?9TVvWhnlNQPP3cCu/sTf4V4LZe4IFbU5ST2lCvxW3lE4A+8Of76Q1UWQAqrb?=
 =?us-ascii?Q?8VleER/Vx7MaCQjGHyoiltPn3MZwHJoHQO8bbZK6iEdk2Tw3KVjt9Bb0eNof?=
 =?us-ascii?Q?I6pvdxWVDzCbH7667FEzSpnP1EqQWHKB9MhJYOYWGkrVYWgUvtzTSgCcpig5?=
 =?us-ascii?Q?FatQEE1HYVLiswN+BpklipSuNEV/zbVBSELAPW1Ki5F8gd/tN1Yg4qmfwsgS?=
 =?us-ascii?Q?8jEevBYybItbb/InhxagrJTQTHmnUXD65U0R0zYEH/R0uFhcCy+UafRSOrxW?=
 =?us-ascii?Q?H4nKNm6Jy3J6hdMtclWqHJQ8peeozcmT7FTmQggRZYLhA1zQ8v90t7sqPU5k?=
 =?us-ascii?Q?ymK4hxp7X8567NFafaUZXjUJsHOleyDAaZQsnCPpBmHC6G1b4SoD8TOaM7Dy?=
 =?us-ascii?Q?Msc6PjJZU8TuPRabyhs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e2ccf0-2ebe-451b-d68b-08ddd8ecb8f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 15:35:38.3309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p1ZWSKZyQng0D7N4ek5xPmX7TkXa/7FKXq3SALvr6/JueEahozvmuLYJQ/o/DLTRU3447+S4Dk4KVaQTY1Lanw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Greg,

Please let me know if there are any comments for this patch.

Thanks & Regards,
Srikanth

> -----Original Message-----
> From: Chary Chennoju, Srikanth
> Sent: Monday, July 7, 2025 4:12 PM
> To: Greg KH <gregkh@linuxfoundation.org>
> Cc: Thinh.Nguyen@synopsys.com; m.grzeschik@pengutronix.de;
> Chris.Wulff@biamp.com; tiwai@suse.de; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org; Kalluri, Punnaiah Choudary
> <punnaiah.choudary.kalluri@amd.com>
> Subject: RE: [PATCH 1/3] usb:gadget:zero: support for super speed plus
>
> Hi Greg,
>
> Thanks for your comments. Will make sure to differentiate the subject and
> commit description.
>
> Please let me know if there are any further comments for this patch.
>
> Thanks & Regards,
> Srikanth
>
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Friday, July 4, 2025 5:35 PM
> > To: Chary Chennoju, Srikanth <srikanth.chary-chennoju@amd.com>
> > Cc: Thinh.Nguyen@synopsys.com; m.grzeschik@pengutronix.de;
> > Chris.Wulff@biamp.com; tiwai@suse.de; linux-usb@vger.kernel.org;
> > linux- kernel@vger.kernel.org; Kalluri, Punnaiah Choudary
> > <punnaiah.choudary.kalluri@amd.com>
> > Subject: Re: [PATCH 1/3] usb:gadget:zero: support for super speed plus
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > On Fri, Jul 04, 2025 at 05:10:11PM +0530, Srikanth Chary Chennoju wrote=
:
> > > This patch adds supports for devices which are capable of super speed
> plus.
> >
> > Nit, you need so ' ' in your subject line :)
> >
> > thanks,
> >
> > greg k-h

