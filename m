Return-Path: <linux-kernel+bounces-831918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A803B9DDF2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170BE4C0915
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073F52E974D;
	Thu, 25 Sep 2025 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0cz6Q++Z"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174602512FF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758785841; cv=fail; b=Se5eoKYOxiNjKfrx7Hvt/dOzOawUr43GUQ2KhKG30P8mKeW522xcI5J2i07N+lKMd855P6xaKE3EPTepZnKITKdCaoL0utzKbuZQUpdNCZd/rT2WedVPfk6x8j9Yfs0sjh5uK+VX+0a+5IELg8FqXW9fQrwex8yilK8AKfI6r+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758785841; c=relaxed/simple;
	bh=wXpYQBz+sxgySiUrgpbnVFZ0YbRN45bY3IwkgIMCo9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MV7kuupG+BuMZTyoBFiqUMUtBaKCELv9dqSUmn4bQ8WJIkpfX085O+ZuZ/bopKOqyhF6evq9S76b6pXk9SSlJgiKcZZ7kdnZbPXoyBt1LXc/4GlLY+uk9glIp9yrmDBDuMT7VIj3F2W87csCQP2CdZhz+1G5XT70tCYrJo8GSq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0cz6Q++Z; arc=fail smtp.client-ip=52.101.53.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qa7YlMJ0vjGHBfQh6T5OjOLmc7FfLKB6TRQItQ69hlc9IEWDkNdmvVxy2iopK9DevZq8GkT1IHOtaFOnsib9NTSrh8YONTPZedxKhi26180ki7K2n8F3ElXqTgpIny0YEgu8EIidieiALY3n9Yp1NgJyu06ZkNu44r8txJL4i3I/8V6K8ni4Cq7kIVUTUHRHMZtfRWRsu2hGx7egcFGBeX6ToLn2xww8VSmfa/Ws9onXTapRXpPbnfDs4L/Rl7Zb8vREx1/s7Y8c8f+57vBXGy9AhN4UpKK4tG6a5YzKaouTTGhc1XJbMFcJI/NDSQzFdDl6xnr2kUM2HHxC5Gxs/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCqx4ntq0KMyuhmabign1cqL8kUftohyOPlylcNt6f8=;
 b=dyCW/mj7brLKcDnP3zcjWR9j9JU3wdQxstQQ/xBgcLhJkkPPeQh304PHblYStABmCUbodAKz0Jw2pdiW1+PrnNETMSwhWGcz3BqhAQA5e/p2t95lB9kQ4EIP8rbeJjtC2ePcMpItd/bV3dKNGU3m5XEv4DmzVr7RZhiIv6ry/8DgyGn6jCmnzE84T/9uITMAyDnUmUtqHR7qOpunsBw0sDigJkE+08lixSd+9TMrDxW1/Y/09+JvN2CTn4mYgeRrN0YBjds2nYhg+nnUEqlFjf+pmHrUFUaQjV1z5+raWUfhqMqxvrAtT0Rdv969zIX15VqCvhhceGHxtCWJrcOojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCqx4ntq0KMyuhmabign1cqL8kUftohyOPlylcNt6f8=;
 b=0cz6Q++Z32jRD6S49P89cqhpJdXUEijgLHxojyL/GIksJiCKf9T6Gj9RGEF56BO6MheDzgSkpjCDmDKm05shUQqK+ToyHwIxSiClABqhhvXrhoT4V0VQeOytZn27oMMBGEZmLqMAJZhQ6lb59qJ3Tuc8BNptRaLOfjzO48Bb7FQ=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 SJ2PR12MB8692.namprd12.prod.outlook.com (2603:10b6:a03:543::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Thu, 25 Sep
 2025 07:37:13 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 07:37:13 +0000
From: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
To: Jorge Marques <gastmaier@gmail.com>, Arnd Bergmann <arnd@kernel.org>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jorge Marques
	<jorge.marques@analog.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Frank Li <Frank.Li@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "git
 (AMD-Xilinx)" <git@amd.com>, "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [PATCH] [v2] i3c: fix big-endian FIFO transfers
Thread-Topic: [PATCH] [v2] i3c: fix big-endian FIFO transfers
Thread-Index: AQHcLZBu2lcu7eR7HUOLh6RNKtQOPbSjfYIAgAAEBYA=
Date: Thu, 25 Sep 2025 07:37:12 +0000
Message-ID:
 <DM4PR12MB6109367F36487B582ED8EA968C1FA@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250924201837.3691486-1-arnd@kernel.org>
 <2wtpklapw5ogsevuvk2l4ngvw7hymer2y4cc454h47u2d7tq44@4mknmpk5yzil>
In-Reply-To: <2wtpklapw5ogsevuvk2l4ngvw7hymer2y4cc454h47u2d7tq44@4mknmpk5yzil>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-25T07:31:15.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|SJ2PR12MB8692:EE_
x-ms-office365-filtering-correlation-id: d72824a3-018f-4311-2dd9-08ddfc0657cb
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iOGjZ+L5671q5ZDHU5rm4bqwfDwxZE3WUr8DAfTCq757aTte5NzPef9HR7uC?=
 =?us-ascii?Q?0PV+5P3PmVxw3qCp/Py19YW417zZwXP7snlxPK3oxDXNPgSI4aKc6jyqwwPc?=
 =?us-ascii?Q?fuvOJpkpxH52AWLjU1ye0695P5hr96+yx4SBHlEKQHpWR9tuI6E4d2OogJtF?=
 =?us-ascii?Q?070sfZxFZyKex8BS1rbg5O+/TyLzqZkCLwdo96moboifQOypoorAmElnGer2?=
 =?us-ascii?Q?Dz7cqkM3Uduoj1/NJrVuY8Cf0Tep9/lhN5oak+W2Ognfu/DFAjCfC6qCGuUc?=
 =?us-ascii?Q?L8x29lythmrw4JNUZZKZ1dtPUmeFmZEB5u1yW4M4Xb39NRP++De7hsONwYR0?=
 =?us-ascii?Q?7btMd7+i20D1GnQl6AKW5uqe+fQmZicS/bhRXYuP2SaU6Um7951Is8qJ/VKK?=
 =?us-ascii?Q?TmuYELrWmOGi6plynOM91Q0fULC9qcT+MAXOf9eBWZ08vCEjI9wAdaZPZVPY?=
 =?us-ascii?Q?MmX/d59R2mbZw96nJpYNrMtMcju6Qsoe41y/fOwJJJRizLT91oaxab38naXo?=
 =?us-ascii?Q?L9twJjzjOX39XCMVrrw3wrB8uBFhZRnX5KDENuyHgIb3RCBb2SFN2hyLIJUf?=
 =?us-ascii?Q?9y+t6gudVrJ7c3rDpNYjtFMHkSRS8tS4UDpB3LtjeWqYcD2Vzo1GlMOf2tNu?=
 =?us-ascii?Q?gjzoENYPNY4PsI6HUVawjMkyoU7/KO1uupIaV2wvecwOibb5vcHKFHAgwwZu?=
 =?us-ascii?Q?rsIqQM3cA6NQHkx+FqJuUQFRZd5h5SH1xOkD6ENq11kZ+oxLTJDpjCVkHRKF?=
 =?us-ascii?Q?H3ZY/aDFPc1IRBjKpowZYy5q+AMQCYiBWx8Bt+Ci/Hl8S7zMJJxwWNlDOx5C?=
 =?us-ascii?Q?vBOGbB4A6P+brqNcKPKElNr9fl0HmyyEBxG4BMuzTGrgZNHnX3nmnwLH76v3?=
 =?us-ascii?Q?ChEf8B5qC4Qkma2MffORKhSZoRp63/CbHWPelsWMq5imMEDbpEhKLWcU4JiQ?=
 =?us-ascii?Q?eVUf25V9LTUlRl3Ipurrg1DoGnrSztAAY372pm6lWYdFHrSWSqqrEWKFAqdT?=
 =?us-ascii?Q?dmfDg7/JxqhBqwp+oJ8l5EH6Jh19KxDbwhv12G4oQNUT9TuF0pv/mH713JwA?=
 =?us-ascii?Q?pJz/nc66srxi9EHMtITlDhUCE7uNU6OarQmXmQCRG8t+RYm0shDDVj7bxK9s?=
 =?us-ascii?Q?wA95brLm7qAfNvplpjIVlw5NwcdSWjGdCR4IhUeDnLQfk+vhVircBlU42i3f?=
 =?us-ascii?Q?x6/KqZXtArivJ1WxS3TAUVxQvGTfpP47D/CZbk+E/rDNfjOG9ulHEcH+/rIr?=
 =?us-ascii?Q?YdTEHVT1AjNuaFjSFO2PflHv6N/VoMLlnPWgTBvBWJD7qT2le+0mxLRW28HF?=
 =?us-ascii?Q?SD6b6EDKHzFLwA5KeXd33RlP1b2kqzbGVLpQAVK/6GQxmMo37dvC6KS2Q94v?=
 =?us-ascii?Q?Nnq86IucyKWlMklbd6JxkRgB6YSJHyMDBOa2nNIZjYqTgAHmLsHDi9SO2n1N?=
 =?us-ascii?Q?rZ+LAv+p+hSxwFhKeGb0dwniZc7VyaldLHBxn9TLzeHRZEhwpfqsjsU/X4xL?=
 =?us-ascii?Q?TLbt6dPRIuyIzQDpjmAVVb9JLRvnQsZuy3qG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rxVNQ3qGvMX3HO+0qXAV+OY+7wQVoUFuC9oYNCkIoBC3PVMXGumYa548coy4?=
 =?us-ascii?Q?D3n8Zf5mm7dQ20o60di9/YPEutYzy4xGsJ+At2/47zdsjEiMoHABpHKN2qK8?=
 =?us-ascii?Q?hNjjgSffeHecsX4UIl+2XVq3/6tL2BFEvqxHAuCm+gOR5NtIZWG/MFZh+nz0?=
 =?us-ascii?Q?dzMi3Ff6BhAGev4wW1m34psPIahd1VnH/lFFoCyAyEMtcqpoZZ00kiSpjmZL?=
 =?us-ascii?Q?PISPdNos4/W+f4T1TTRO+ZOa0hNQvEeFc63XHZm3j/1LPXGbE8ESz1W1rnUY?=
 =?us-ascii?Q?lRzXcWOZM1ec2zJtemZY0zNoAw9BtRikhTy7TTD4n5RQIpuSlMxBJFPSsuPH?=
 =?us-ascii?Q?LO7Vyf5qEh0ZJRXcv7RwazIHi3IPF8SW2zw7josIjhbOyZ/ujKCW84k0ae02?=
 =?us-ascii?Q?HC5ruA5ynFfPth25gm+y/EPExYRDZZ/saU0P6uOHiKQrQciHoaTGJ4aXVDal?=
 =?us-ascii?Q?zye94e9T4VHS62mIbJEBShoCmn8FNJzVz5CdyEEVl48sPDmzl6x7lIk21e6f?=
 =?us-ascii?Q?dNNxfi2jSIT0xO4R4h6cYbWedVX9zQrgIYPFvYDFxofvuGZuT/w+1CTR8LSU?=
 =?us-ascii?Q?NqQlHW2PA1jv7rmMJnYC4cLDas8cjNRwDlyrptntZFLrB9wPyeoU8n7DMzfv?=
 =?us-ascii?Q?a65MgGbRO2vDSti9IGToWq+E+qQsaHNO7WKJa0yZJkzQ+Geh2UmIyZzo7kG6?=
 =?us-ascii?Q?U3+9VjuDYlcVwy9gfyEdsTSkT4JEVxNKaM0jpLDyw4mMYfignWvhL7Zi1CDs?=
 =?us-ascii?Q?zjPTEGgPG+bBgARGCzNn9JalVn67hcQv7k8DcDYBbMOQ8Xt8WnGJG8rnnvSk?=
 =?us-ascii?Q?PbKilAnynTvZsA+PV3QphxzYER9IaBnNdalrScKJk6ddpt2yBua5QYvMXWzX?=
 =?us-ascii?Q?Nj1k1qCnkAtqE85+myZTdyjilUVXYG2hQdpwjWySqrxyoRG+RDQ82HYjnVLl?=
 =?us-ascii?Q?0PND6fPtqZ/djPqfXrDpzmhRsxO+y4xwosw6RCxwenOzAZDL3qns4B+X0wez?=
 =?us-ascii?Q?zzPGNUpgSR/uiWP37juP0+sRfzBYgmV04KJjqDof8vAdYPGvhn/9l4MjU3ut?=
 =?us-ascii?Q?mIq++DtXoFrdyboVlewXZyI/9Kl/EB2SDBtRoOtGceZTgGMw0VUz9ubthwod?=
 =?us-ascii?Q?bO+o5N0b0STAUsgJOex3uY10vPqEW6atKiZoX3E4wiJ4+VVJ10bOGJPtLS+V?=
 =?us-ascii?Q?3v3BF4UdiPe9SD9fyf6/ikFCeD6MMk14gVaGc1B67mAnnaChmt+gfWU7zV17?=
 =?us-ascii?Q?hzmNIutzFUdBwYLhNSy9h6ndDQXaSxYpTavUDgNYYE0qwfRmRTaEcjTfV0Za?=
 =?us-ascii?Q?FWYsw0U2pGraksbqa+dyJ7YfmlbTWuonlv3N6YZ5ZUC8ubYsFxFeSlbBzOIA?=
 =?us-ascii?Q?nZJh56K3A9gQsu6NmHtjvIm4sSZ+Z6Agh4QYfZUxvAbpZ8Nv0+UKlB0ZDDzg?=
 =?us-ascii?Q?7MTYcFajT961wVGElEqTz5Ok/kARIfOpuipv0gjfbZhy2IlUQQCs3UjoiIoe?=
 =?us-ascii?Q?2QKlcPTna6niX40Rc5SwbOBcJl44MJZqqmPFQNWTWP414FE0xY7syBmoDXnC?=
 =?us-ascii?Q?FI7HuzwoJs8upZBRuXs=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72824a3-018f-4311-2dd9-08ddfc0657cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 07:37:12.9240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y6X/sFiM5HYLkT5nJIjjz3pIePYlWqs0wTUCgx14DpxRXJ/RsuXWFtNg4gO20h8S13IZ19zY/ahVDt5S/RaVbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8692

[Public]

Hi,

> -----Original Message-----
> From: Jorge Marques <gastmaier@gmail.com>
> Sent: Thursday, September 25, 2025 12:47 PM
> To: Arnd Bergmann <arnd@kernel.org>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>; Jorge Marques
> <jorge.marques@analog.com>; Wolfram Sang <wsa+renesas@sang-
> engineering.com>; Frank Li <Frank.Li@nxp.com>; Arnd Bergmann
> <arnd@arndb.de>; Guntupalli, Manikanta <manikanta.guntupalli@amd.com>; li=
nux-
> i3c@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] [v2] i3c: fix big-endian FIFO transfers
>
> On Wed, Sep 24, 2025 at 10:18:33PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Short MMIO transfers that are not a multiple of four bytes in size
> > need a special case for the final bytes, however the existing
> > implementation is not endian-safe and introduces an incorrect byteswap
> > on big-endian kernels.
> >
> > This usually does not cause problems because most systems are
> > little-endian and most transfers are multiple of four bytes long, but
> > still needs to be fixed to avoid the extra byteswap.
> >
> > Change the special case for both i3c_writel_fifo() and
> > i3c_readl_fifo() to use non-byteswapping writesl() and readsl() with a
> > single element instead of the byteswapping writel()/readl() that are
> > meant for individual MMIO registers. As data is copied between a FIFO
> > and a memory buffer, the writesl()/readsl() loops are typically based
> > on __raw_readl()/ __raw_writel(), resulting in the order of bytes in
> > the FIFO to match the order in the buffer, regardless of the CPU endian=
ess.
> >
> > The earlier versions in the dw-i3c and i3c-master-cdns had a correct
> > implementation, but the generic version that was recently added broke i=
t.
> >
> > Fixes: 733b439375b4 ("i3c: master: Add inline i3c_readl_fifo() and
> > i3c_writel_fifo()")
> > Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > This was a recent regression, the version in 6.16 still works, but
> > 6.17-rc is broken.
> >
> > v2 changes:
> >  - add code comments
> >  - write correct data buffer
> > ---
> >  drivers/i3c/internals.h | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h index
> > 0d857cc68cc5..79ceaa5f5afd 100644
> > --- a/drivers/i3c/internals.h
> > +++ b/drivers/i3c/internals.h
> > @@ -38,7 +38,11 @@ static inline void i3c_writel_fifo(void __iomem *add=
r, const
> void *buf,
> >             u32 tmp =3D 0;
> >
> >             memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
> > -           writel(tmp, addr);
> > +           /*
> > +            * writesl() instead of writel() to keep FIFO
> > +            * byteorder on big-endian targets
> > +            */
> > +           writesl(addr, &tmp, 1);
> >     }
> >  }
> >
> > @@ -55,7 +59,11 @@ static inline void i3c_readl_fifo(const void __iomem=
 *addr,
> void *buf,
> >     if (nbytes & 3) {
> >             u32 tmp;
> >
> > -           tmp =3D readl(addr);
> > +           /*
> > +            * readsl() instead of readl() to keep FIFO
> > +            * byteorder on big-endian targets
> > +            */
> > +           readsl(addr, &tmp, 1);
> >             memcpy(buf + (nbytes & ~3), &tmp, nbytes & 3);
> >     }
> >  }
> Reviewed-by: Jorge Marques <jorge.marques@analog.com>
> > --
> > 2.39.5
> >

This patch fixes the sub-word transfer case on big-endian kernels, but it s=
till does not address the scenario of little-endian kernels accessing big-e=
ndian FIFOs.

With the current version, i3c_writel_fifo() and i3c_readl_fifo() only work =
when the FIFO has the same endianness as the CPU. On platforms such as the =
ZCU102 (Zynq UltraScale+ MPSoC, Cortex-A53, little-endian), the I3C FIFOs a=
re big-endian, and this patch alone is not sufficient - transfers fail in t=
hat configuration.

We have validated this on ZCU102, and the mismatch between LE kernel and BE=
 FIFO is still an issue.

On top of this fix, explicit FIFO endianness support is required, as propos=
ed in [PATCH v7 3/4] "i3c: master: Add endianness support for i3c_readl_fif=
o() and i3c_writel_fifo()". That approach adds an endian argument and uses =
writesl_be()/readsl_be() where necessary, e.g.:

static inline void i3c_writel_fifo(void __iomem *addr, const void *buf,
                                   int nbytes, enum i3c_fifo_endian endian)
{
        if (endian)
                writesl_be(addr, buf, nbytes / 4);
        else
                writesl(addr, buf, nbytes / 4);

        if (nbytes & 3) {
                u32 tmp =3D 0;

                memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);

                if (endian)
                        writesl_be(addr, &tmp, 1);
                else
                        writesl(addr, &tmp, 1);
        }
}


Thanks,
Manikanta.

