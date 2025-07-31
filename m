Return-Path: <linux-kernel+bounces-751578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D8AB16B0E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0F818C6584
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A88A23B620;
	Thu, 31 Jul 2025 04:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="p9zz8u0G"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2088.outbound.protection.outlook.com [40.92.44.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B1BA921
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753935166; cv=fail; b=pW6DbXOt5JFDaMDlfID9AD7nXQGF9/yRxAb1AvJlBiX0eSYknHNIHeMPaG6g9iJ/bD4MzJzpJaGDTtErIStkajHwkpWwDxmD9rZfS2DbgA1Jlew98XLlbaHQ3y7kec0s8w8eAC8w7ku6GmTD3ykzjSKh4iouDRDO3+cCcLuFXL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753935166; c=relaxed/simple;
	bh=DUuiDHA3QpvyuJ/zZ3jHdZh95EhmAYRv1qEI/vFDxH4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FTgLmVVqwqYo0YNCooZeWakWROK8hUVI8yHm1EfEDdlQcBYJJ6xmyYf4axx/rXZKAjqRVYTFsZFwbL71bsyQoQHneu5qeWLkCVzZBViwnFEGMsxO2i5aOL47j2ypRJS1+scrrHUSXqZ3EC3j2/hRZn/Ygl6Er9PbgYM737lbg5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=p9zz8u0G; arc=fail smtp.client-ip=40.92.44.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=db9hOloRUSonyMLw/FXtLJQ2w6RwhMQEt7BkEARI+9eVswhiozQ6Ap31mN6Tb/X1FynDkSJlKOqBp2q+jiZK2q9eRvgQm2iKBTzkUcmbHnT1yVhs97Hw6BOyC4RIYWIp68o+dNHtI7LRWykNaSafSTorXwulVjQC/067a9nzRTDYNmjiHKjQG+AXPmbJK5QDxFKSY0u4kaMrFTfvQqnv+ZBeLWr8zAVjLCxcMtyBTOixvkUL42JQYY6pBVmzyutzoruyNzEOLU9LXf4m4ACHxsOqH0OvqEPcYdsGNvAVgwwr1Xz4QHKc4nj6JhtBDfUGs6uNrBKjIj6XRxHZRewaRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUuiDHA3QpvyuJ/zZ3jHdZh95EhmAYRv1qEI/vFDxH4=;
 b=Ti1VTeUMQS9w/DCwGcs/Xu/zARFMY9Kbz1L9Yz6wtK01qfnxyWwplZYSCgWKO28IIZdTwAfPehZaov5yDYvHaUWvwTqim76ih7djt/8IzBCZ9Exk50oPKZPQan6RaYZMBtJQHgM7VSuq5Ib20hsduo1QWTAnLJpVCwjx4YWTPOJHZC+4965KzndLJE1J1oNrv0FbM782ZGeNsQIDE5oE7JYm+buZydEwDvBYT4oSIUMPI1M9oN+rqAHFTU/9imASWg3MlJLju6fkvOGg/rxKhHvZkNsDzMQImbiN2g5hg6OslQ16B4kRNGyFLE3tZQjDSFUxmZ2nb/Y5Lwk+XCmpiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUuiDHA3QpvyuJ/zZ3jHdZh95EhmAYRv1qEI/vFDxH4=;
 b=p9zz8u0GQzzBYivOlNz9B9tNdPEoeSBA+b87LGffCKpC3hwyCrAnDiS26xv06ke8uqBmDrJdKkkY1WXvoGlkMhE7TsUhi5KfPoFyqHxSRHU5CreuBDHUG7R4j5RlgIRkKNN+SBYFIykf5vCUvmdDAreK4yP+15pKrkJss2xQuk+gkiTCJ9yGvsaduq3gBcd0AN5Fkt3KVC3uVcAXePTLQpSSGdOzton+qvCVgvXIo+A0KitQJLrpXkWFqlR4z9QX81Gl8MsqPCDhKU06wRHI1g/MxEOt8gOU4aOR6meGyLlyLtJfUGTHf0AXi73FSHR5lin2yOXybHKPCacPA3sZcw==
Received: from SN6PR17MB2477.namprd17.prod.outlook.com (2603:10b6:805:d5::31)
 by SJ0PR17MB4893.namprd17.prod.outlook.com (2603:10b6:a03:3bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 04:12:40 +0000
Received: from SN6PR17MB2477.namprd17.prod.outlook.com
 ([fe80::c94b:9ff:95b4:eb55]) by SN6PR17MB2477.namprd17.prod.outlook.com
 ([fe80::c94b:9ff:95b4:eb55%3]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 04:12:40 +0000
From: Alyssa Campbell <alyssa.b2bconnect@outlook.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Uncover NRF Retail's Big Show Insider Information
Thread-Topic: Uncover NRF Retail's Big Show Insider Information
Thread-Index: AdwBpkJOsiVf+W2GRO+9p4Gf9hDEOw==
Disposition-Notification-To: Alyssa Campbell <alyssa.b2bconnect@outlook.com>
Date: Thu, 31 Jul 2025 04:12:40 +0000
Message-ID:
 <SN6PR17MB24775DC743DD718E1720E935AB27A@SN6PR17MB2477.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR17MB2477:EE_|SJ0PR17MB4893:EE_
x-ms-office365-filtering-correlation-id: 2ebb326b-bcc3-40a3-e3d7-08ddcfe87db6
x-ms-exchange-slblob-mailprops:
 CLk2x5OX5VaWByBIbrvOWE8ZJIq4Ba9O1cA2I0GD8bRTR3iAslqfsFs1u2EyBamy8qbQpzdExDWDtTYJhq8z9FoQ04VthEhPop2IiTlGw8oTJhSkcaBjgdSjKdi98N2ijmoI+s2ezqnDetpBbl1aOkLaTSftBWjU22i/JMwJcY3CmW1JhpNGmWHXRolVHvxe6LJLmEArK2kz9mH8KzhwnG9caXDzLr0GlqHk+as8gNVx/IWC9BuBI1UVXuEV9LNzhK8AolW/IF6jOUXw40aImVyqa3NhvDfXGm+GYOGsl5t/EZ0zPClPo36PTrycepF7fK9khv0Gs2BSUMrS+702D35Rs21+KqJUyZJZ9xY3ZKJ2HU2STIaGwwY9fXs/b6lLbWJ48vkVJ73nfMhOh/yi6SWa9gxcwr/Eb6z88YNf8PoYRTmczVdaxi2u8ispX+uYHErP2xXBwJUGWkJKnB811N/jwbHeTVrQqW7KnPsWtdTo9stRffP+1zUS8fPExbWbRwcQ54XNQhPTL04UzSctRxZJSrB0/GqB5VJ/e4yQQ/hSwvOlH7g3vufB3DX0O2QQLlisngFNAD/59TCCATDomU7nmF82bP+1WXTlkWf5qwEtqiWZySSZn9idS4bgUPb/Tvxqo33wb5/U9gmH76jeTrKiM3S0neudm940uC2451J8NZO1T+bkRfRs6dJkoVHshSbThurZFHn2DNeKmb2tPg==
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|41001999006|8062599012|15080799012|19110799012|440099028|51005399003|3412199025|40105399003|39105399003|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?2/P3D89ijm3txgyXb8IXqNjchyxJbYowvA7iGq7XnJebZBFm8HbBpnmvPm?=
 =?iso-8859-1?Q?J65OlEXjGp9mnQDArMRurlXzPv1zIXOcJdsdf0XAJBfRqhyzD06Vj2jKWV?=
 =?iso-8859-1?Q?9w4xIkHh8m4LiqUQnEB06Exz38L/J+AxVCuhKQ2yrJxgI3Q/iSBM6C2eGO?=
 =?iso-8859-1?Q?g8JI5EfKCy2ebCJsnGp0zqVBheC/yY2SjPK5obxyCkX49YcUgeGPUd2aVM?=
 =?iso-8859-1?Q?Qnn9+S9EAM9mTlHcN296Ofj5b/BAJW6gEAOavzyaZZoU45cuxkt7VnWXql?=
 =?iso-8859-1?Q?wcixl7rj3bfEOsqgUmxFrCYPaBv2dMVTibGY7uciFshCkRgxQcMRS4wzQJ?=
 =?iso-8859-1?Q?oIBVb/Yd162JvlSNo0enqd5yRs9prDi2KoPGUY/1W19/orO6hphkmqamIe?=
 =?iso-8859-1?Q?yG0Ux+3C0hPuf5x+semgeqMUPGD+FSbHwNE5WXdaQ1OC+SQtNfprFL3qgY?=
 =?iso-8859-1?Q?+aEFtEO8xk5tVcCbVZ6DsB5qNoIvQXtEnIxDpiKfebuGtRLSwRCuJDY4wJ?=
 =?iso-8859-1?Q?KplLI1ygBRV4H0/MVqBfeTkocjQcILcSFQ0L8Jl77B6JTevxzTt9dGuL2W?=
 =?iso-8859-1?Q?ixCL03Me9hxflmxNarGNotuyFm3WMTQchP3/d3lKTbwPPuV92V21BwVzyu?=
 =?iso-8859-1?Q?C4NRE6G5wHtkDRmKqGsKiWnMdSiQ4LaBCP96qBHNNe1fJ2bphVO/y7p4AZ?=
 =?iso-8859-1?Q?VJV2v9df7HNkrqGqi4+eH85xngKavxcDrS9ZsRObVsZbX+JqRytb4UfKtI?=
 =?iso-8859-1?Q?PVdkIXpiiXUbvkbTNRRMnAJn30ztAm3eSIshs6je0VpKXitGZaReMstq7w?=
 =?iso-8859-1?Q?PC4APl1Cs5jEonuf/MyJipMMgjB/eUS9hSyMihAAXaXxVeHGdiQXZEsmmo?=
 =?iso-8859-1?Q?3fuKjYgXHI2meZWF2G0sggLD/Q0hSMiwa1Mt0zlkmTtoyp7m81u+yGPJHX?=
 =?iso-8859-1?Q?yXgssjtufWasZtUgmL2iNras8cO6MlYYkzTnmToyipz3xUZi9uL6FfX8l1?=
 =?iso-8859-1?Q?f0/f7Yp9f0Idtq4VZFWZrbGhrLU0D1WgymwPwRD9EvVc5pYA+pZxYXMpFQ?=
 =?iso-8859-1?Q?JcSmp6DTfra86zhD3nOoWKU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XWgRo/azh8gTgXxrCkt8YmnIvYx7Nmq/ZHqcT0utp4Xqzppml/ScuFL55r?=
 =?iso-8859-1?Q?DzooVtuWscx9QckDjMREoYScb///aBfWaF5WsSROw6LIB7mWsLcoRrNC0S?=
 =?iso-8859-1?Q?dNStdiolpGrSmqLmeZZ2KJHrsxSClwHHNIWjz5S0guECGfLA1Ri7nMDNkY?=
 =?iso-8859-1?Q?VDAGg8FZV8d4eCbCjfPveNjCSwyie1R9OHuL6ZalyeqBKu1/6K/Nec+cxp?=
 =?iso-8859-1?Q?4JCaRaYFoDE3d5M4HHYW4gGmpb3nkpPbHIPuoGmjGvWw8K35bTNQUPL3OL?=
 =?iso-8859-1?Q?9oRz4fPPzwBsFLIVab0cPsvZ6puvoffyilE088po3uh+S8sY2jnfdz0MTv?=
 =?iso-8859-1?Q?myzrq9O4CQyfGWB44ez9cP+WWDggPhmWer56j6SfsYM3mcJfjrKv/oJBr8?=
 =?iso-8859-1?Q?uruRINg+EEb7cPS4wF2MpIF9wWvx241DQ1X77x9X4DOlsNWzllHpIOLjZ7?=
 =?iso-8859-1?Q?N14ZwkOYHgz8RHTMdEiEPzdvzynSFKHERSzcru3eeJ3jhgwgukxVv0Mu7g?=
 =?iso-8859-1?Q?ek7J0Lto72Bqs5Rp9USaU+tplNDEeIio1yPKFPN0Oc/YBkxCIc7PSXQPV9?=
 =?iso-8859-1?Q?cmt0vhTIjOVmk3bDMlvf8VTTbysW9kc6W58UOFNfjz7kFb9zk3v65XIXAm?=
 =?iso-8859-1?Q?jZ9pdyQshsmwsWINrnTObyXfs42ASR3TXj4JxTeY8/QcTQshDJLdeX3DEJ?=
 =?iso-8859-1?Q?Zy2vhFGiv/wHOnSscjjn6O3CuanjsNyyiYMllMwu3zQ4hUPslgWVpZgxlf?=
 =?iso-8859-1?Q?gShNve8/loDJzvwHyyf/KBABCty9bg2P1PbnBx+PTpnlvoRk2Ldvy3IjI2?=
 =?iso-8859-1?Q?PV0Kapba5XRYqjTCF7puh9xajgzUSO/gfmRKzgM7wU67ab86NHi886d76p?=
 =?iso-8859-1?Q?97zChUGCi9fLzUbuNb+ZyBUl2nB4P8NLV2D0UMwCG91f0RLoUdAPQgwTDF?=
 =?iso-8859-1?Q?RG0KoAgFWnf2wRcHu/GzylyVEHlBJuVkRcSvCcynZfZrjNr44nfDTseENr?=
 =?iso-8859-1?Q?GaM0fn+Pauvs8yY8O3a3q9ieYi4FQnGWj9YnswFVdyIJtznCSMQ1MU2PW+?=
 =?iso-8859-1?Q?VFqEU3vCyO7hBbJJRZ0i8PshrLWYFZ8Iodb2kTJ6YSpUM7ubWnHCzdvRfk?=
 =?iso-8859-1?Q?8W2l9lFNwn+FZzlPXJ78NbAHAtqku5LPOuOAgDabzMmM6PXGCnKboykq8N?=
 =?iso-8859-1?Q?1jR5PakJsWGk0SFbcM1mXlVw2gaC4w2NHcqhbvOi3iRz0bBGbgS7LUqkQn?=
 =?iso-8859-1?Q?qraMqOQZdVHVRdRzaT3QIKDhyjT1mss05LIGGvb6DXah37+2+Amu2fcA4T?=
 =?iso-8859-1?Q?We/2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR17MB2477.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebb326b-bcc3-40a3-e3d7-08ddcfe87db6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 04:12:40.4887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB4893

Hi,
=A0
I trust you're having a good day.
=A0
Would the NRF 2025 Retail's Big Show attendees list help your outreach?
=A0
Attendees count: 25,000 Leads
=A0
Data Information: Company Name, Web URL, Contact Name, Title, Direct Email,=
 Phone Number, Mailing Address, Industry, Employee Size, Annual Sales.=20
=A0
Let me know if these leads meet your requirements, and I'll share the prici=
ng for your review.
=A0
I appreciate your prompt reply. Looking forward to your feedback.
=A0
Best
Alyssa Campbell
Demand Generation Manager
B2B Connect, Inc.
=A0
Please respond with a 'REMOVE' if you don't wish to receive further emails

