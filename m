Return-Path: <linux-kernel+bounces-752769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2886FB17AAD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A13544671
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA814207F;
	Fri,  1 Aug 2025 00:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="rJftKGlz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="Vy5gwyDy"
Received: from mx0b-00273201.pphosted.com (mx0b-00273201.pphosted.com [67.231.152.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E618B360;
	Fri,  1 Aug 2025 00:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754009886; cv=fail; b=mcb9y0i47bwC7SyULp9UbuNb92kKl5/ODPf019hKvxqxwx/uUkpCEWprGNX4If1GCw1tgL2dX3agta9d8as+YMTlLzpMd7+ppMFORYPXlSlsXk1/wpkkWvTA71VKsePgRWzrFNT4E22UV/vha9dZ+hZFBZzo2AlN+EC6yrotetQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754009886; c=relaxed/simple;
	bh=+iy+/djOToPY218Nu8S7PR67hLnAuz0OwbJHO/dlLnM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PETHMcxlpcICNABbHYjqt/yQI/oVD9Ocq45eWK+YQxLpve0hjNUl0zTOC77VQgdfru9SWsOK5R6CRYXZ0Zai7f1pruTbYPv4NGBXJyHCjbqrHB7lKAo3yfqrFPh8M4wpYl+xV+UlRXCYIi1POjVtCKM/2UglZMNoHebuhOGnN7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=rJftKGlz; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=Vy5gwyDy reason="key not found in DNS"; arc=fail smtp.client-ip=67.231.152.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108160.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VNWFAl002096;
	Thu, 31 Jul 2025 17:24:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=2MTMppUK7jYhlMD+lah2GwjondMSFSs+iAMk6z9uEc4=; b=rJft
	KGlzdxSvX8Li6+WseUWWDUj3PYS7sKNzV/JixJfQ7edd2Q/rNK4pQ1brI7qhEAw2
	X12cb84VxNDiQ7rVBxFDCLFrhVd4fBShbMTRPWvx9ZStWWFLg1+kPcASGwKBH22m
	/OlbgyuUuNIFBZbCjqx6D+lIr8qUUwLLXzHYez99nBOYWBycVcTqFj6MjvC0oaEL
	Xnn8HTf5hwF7Z/WXSorBsZcE1vhFsYRfFKwmBMJDMUG8yQ9I8Qea8Tyf6CkeR5ca
	sen/l/36sBROvI6Q5zgAW44y3EiyfQ+J6kku+FNcua8SdrKRGkUere3YU5FtqDHz
	hFdY9x4dDUOnQqLfjA==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020073.outbound.protection.outlook.com [52.101.201.73])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 488bq7s2ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 17:24:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXwUGUEuIeaSsHBx8HBdb8Qfaoawb68qde3ifSC4GZLvoip9a6vg4njxHoLJdSIX4PT90NcdyBwlPp8aK1pVtuADDaGqYZ+YXj3ERrBuui4CLSrIzIuqq6MKLIpTvspl5Es3YrIhsmJ7/e2hxBqerM/wyN5bKMrDv2h957xl41wyQBxzMZulk2tpuZOMCNhg9R45WAPF4IpCOxmziOzGt5Pz8lFNBHXKmOZG4MiGuNy/zydKXbkkZx7WytdXRv+n6vArfwbtK9kKqsCjzTvMVW0WozKXYBh55DLMSNo+QapDcKmcNksF+FUtOTKXGDPY2T+rJGejoioWmSBGCh7uEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MTMppUK7jYhlMD+lah2GwjondMSFSs+iAMk6z9uEc4=;
 b=RSMxbK/rAl7AS4HYSvarfq9eJWytiSxZbCY3J7nm+C0EW7XBRLEXU1O3DKt1djEkZ5Ctc+/Nt7q4MxbyKPFdSyG9f98R1k+NXGvUi/f1QoyFDOzF9NI8GEGR74LCBXKzQdbs/G/7SgCES0Cb8Ar/lQuobh9Nj4Lel1WRsaE4XPc6wGkMdgJk8v/aZ98yQtOjE9P08PiW8xz5wLfBMB9WGsUmi5mqaaZEAKviDbiNRHaR0T3D043vo5/tQbGlP6Ex+8oH695RVGHC+uKwArCZw2CA0bfWa+Fp3zrzW24ljNk+X/aqvL/7tmCpuXOlf8sh8M4Dim1qY7QfR1MSrkWSqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MTMppUK7jYhlMD+lah2GwjondMSFSs+iAMk6z9uEc4=;
 b=Vy5gwyDyGdnuC+MaFqgxZgIbTKySQGDGsbjq4e+bJHfu2wPzg0erBsyV8CaG7leX+UEY1HYDfNbjtB/vCTzLhHK9oZ7pfL1HLzNM2vQYf/StmSAOi1Y8rdKZcXAvhM4HEf+smQ7kkXTaLhO+d65/N+BGzJhPlIIheb40i9qlLqM=
Received: from DS7PR05MB7288.namprd05.prod.outlook.com (2603:10b6:5:2cf::10)
 by BY3PR05MB8004.namprd05.prod.outlook.com (2603:10b6:a03:360::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 00:24:06 +0000
Received: from DS7PR05MB7288.namprd05.prod.outlook.com
 ([fe80::d1a4:ed92:eb4d:8b24]) by DS7PR05MB7288.namprd05.prod.outlook.com
 ([fe80::d1a4:ed92:eb4d:8b24%4]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 00:24:06 +0000
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
Thread-Index: AQHcALW+ZQjjgT9X7kW+00L4/dZ7pbRKRqWAgACfQICAARNYgIAA+nkA
Date: Fri, 1 Aug 2025 00:24:06 +0000
Message-ID: <9012E729-4E7E-45F7-9816-301C0342A2DB@juniper.net>
References: <20250729182142.4875-1-makb@juniper.net>
 <aInKb8qr689ytM41@darkstar.users.ipa.redhat.com>
 <14D2606C-3492-4A32-A55D-428F1ADA9327@juniper.net>
 <CALu+AoQzQGypYRWXLiu1zfipL+H++x2H3pnL1uZgXPCFvumDiw@mail.gmail.com>
In-Reply-To:
 <CALu+AoQzQGypYRWXLiu1zfipL+H++x2H3pnL1uZgXPCFvumDiw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR05MB7288:EE_|BY3PR05MB8004:EE_
x-ms-office365-filtering-correlation-id: 53f82146-d25e-4874-f219-08ddd091ba1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gXzaqUFGOUhE1/+ny7ZGzPrjS+C/6bwnCbF6nzA6lqWv38dLapjXMzHFh9YG?=
 =?us-ascii?Q?/xIRZt71odk93JF1C/v5Ew6mwYLJOoGjMrHAMVmfDRYgCi6F8X9euXTiXAdr?=
 =?us-ascii?Q?55RLFZUFMhx/ZFMgZJtk7W8qTefxQjMYlXQaDWAPubJtn1m5hPJz6thW4kxc?=
 =?us-ascii?Q?odKAC8auewNZDKN7DnnfcAR0Wig4KdecIPThtuD1ZPJzlU7vMh5pb/fY9XM3?=
 =?us-ascii?Q?6L01Tiny6meZt9ONDxRxvVuTsnaFzwgEqOL17IoL4shc0oZbFZ1Vw7gxkXHF?=
 =?us-ascii?Q?U7iYX7OCTxxWXH1yFUL2QlUYMXQe8XVMg5PGARNuTzSM3NzIql1YPN8/riH9?=
 =?us-ascii?Q?3/Ass0fPTJ2kuQ2nG6PrSe6V0l8xu9lsejXgf7jPk2JDErdqwa28FFKnb2oZ?=
 =?us-ascii?Q?b+Lr3FqbM8lRsO6IEKRvrOtjP3TaiysOUKUxSkG/S9N861wH7hSykBBCJxjh?=
 =?us-ascii?Q?wIYZYi75fciamqVdmFlPn7gB5vZS0ZAMB0NJzgGYWFiCbVlEDfhaeSJQ1o1W?=
 =?us-ascii?Q?W+U4xEP3/Sulh9f8aOg+drOwMrY65tgqDVHe6ds4dH59E9UbO9t0FYT3drF+?=
 =?us-ascii?Q?wEK7ihES5bhI4ULGth8AIZOdtum+Owk4qDFju3D89VVs9b77mVSvXdsj4bMo?=
 =?us-ascii?Q?QxXEsmseGgKvrVi/t1SPXtZ++VEiPI/4SYMzz57gW/D55qjCNfUWYrY4fJmb?=
 =?us-ascii?Q?97sLDzQE7O+PfPte32q22zl22jR6HwFBFyvfQWBA6N66KsTtKatp+Rapowtq?=
 =?us-ascii?Q?BCtNU5jutnGCXNvC71r/F9jSLMeVX2mEhcWK407T6g2MjaaVa1mW2GsdUZxm?=
 =?us-ascii?Q?jLvLt5B+I/1PhvuzJ15G2GHZ0SQGYbaNFneQ6dy+L2IcYhfAtJbK/8oMOzA+?=
 =?us-ascii?Q?u/ZTVVaa8FLOGFNLH8s6GzSeW2SZzm0rJEe3Zf6pdspMN6Lm3ubzrYiTHPSR?=
 =?us-ascii?Q?S9jDUeszaiJdV4+/hdlWPwULRWukyK2mY/Yat/saMUTCFsHXh9nE6oE4GF6L?=
 =?us-ascii?Q?n1Y0UFFmk2dHhpdW80gtRB4vBCGGlALdxMExkNqZLYFKiWgbyeY/JW89L7Lq?=
 =?us-ascii?Q?CeNFWrS7mps97tMVNAaYA0v5aOKFctgYSJd/viqzYjE6LoGmiOb/GgmEr6RA?=
 =?us-ascii?Q?78w7HeSey7+dhNQyCNaqgvhlvlilCyGIaDgSOsf+XofeGbsXJvoIFUWiHMkz?=
 =?us-ascii?Q?zYkdhsfGJJoKvSlc8fRilDU0SCXeODOL7FaE7e7ryadpbz8e7bJu0EfpgkC9?=
 =?us-ascii?Q?x42VL8sfQ5DWcPVpAbONgK+UzkjTOK4zsr4W/OvBuzWMM8RO6L2Cs9CHMGLr?=
 =?us-ascii?Q?stIuYlXyaszzUY4pCM0A9b4nuky8eIfbJoxNCT6CsdHKItM3UzFGE1OZpmEG?=
 =?us-ascii?Q?f9KYVos847J+8a1IJbfNRp13eZSCPRGBP2hK3KuWNeR9UNyVZT82nWITxdTg?=
 =?us-ascii?Q?k68eBG2asFD7oZ3PEPhj+rj1dAJpCfo+KRgGVVfgbW2KTZcMSxcrUg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR05MB7288.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5t5WJnNOG+5d2rOphaLgZmX8Cul3ACfUnrrc0WnrgKGYHkqKrDcVv1VUBLBs?=
 =?us-ascii?Q?jK+i5WB7oUJr23XhiTI4rCQVPIxb1whBE8l7j16lreB4IJ/GkZqquCsafKyE?=
 =?us-ascii?Q?O4xiu8IuygOO+Ik3FLuR6pNNUBECZFsZ9lZ5PpZnhsBNex8lUEIIj1u3XhJv?=
 =?us-ascii?Q?yfUsgZ4jmqHcp46ndfGNxaOJ25aJIxlakeXCzPQf7s8LZWCy0oi/7ezF5Wlt?=
 =?us-ascii?Q?7pQelkPjJA+kmYWe6Op7cwHPyQy+kqr2MGbo+G2H6/CPz/NlSmbOgmu8xsFD?=
 =?us-ascii?Q?UVJbPrRuCGbZTUEZURjl3Y5PASQD9lhBROaGZ06mlqnhUhaO0mRzejp0qaoj?=
 =?us-ascii?Q?LtBi4lfmMF2g3wYWh+hL/B+viitjsdXDw1xZk/LuQeyp4E/Y8EYGQcK3wykW?=
 =?us-ascii?Q?+CkjXp/HCTSmoi6v1ypSjUXfEQ+JywLaNb/TxX/9R9PP0cdmoPdhVW2d431H?=
 =?us-ascii?Q?Os645ekiaWvlVbHwavugy/bIwgg8X6XzRv8MUhalquU3hsEe8/YKoDBgGwku?=
 =?us-ascii?Q?9Bzh8eHAzSYTAicPga5i1vGxPCkklwYmrP6KJUuq45dFer3yYUy0IhRUdu+R?=
 =?us-ascii?Q?nuaPdwoWZV8baYQFGWhbRXSk3qQqy5Djg/myNJHN+aQL92+HSJLACyPOMd07?=
 =?us-ascii?Q?JFXQa82TglWBGgNyhIRb2loS+Ev8z9LkgdfI/NLcx7yPmecijZr9A8bcefhH?=
 =?us-ascii?Q?Tha9LW0iRfQDyCOU9mAJLkLPGn/DcyyPhJsesllHyZqZqR+t2xtiF58cxYz+?=
 =?us-ascii?Q?PTTqck+BlRZI8MCdmNzrwIbanLlYAqkZE9kKrkdl8n/2BFdvxKV8qpwaMt41?=
 =?us-ascii?Q?yPw41riz894Oah1FrBhb9PZQwNdKuC7TjvNrtSzXMCFC1mx/tG50HPuvBAjM?=
 =?us-ascii?Q?qecm9gS97kKcrIdDOUbSpC2lTw55YXGI8Cc1E37fcbqTiJZ3F5z0Bzpilzqi?=
 =?us-ascii?Q?sDQUq+x5JSW1UJwLHhRdHnvpZ9G6mon1lxzmGF6k8G0tNaXXn1l7FE9AE+GH?=
 =?us-ascii?Q?7e6LPkCSoYWtnmJ5hNIxcAykcDda56rwteLs+l90HJh92e6OLRx4I9D0Zi1x?=
 =?us-ascii?Q?Sl90HuD1NAdQbjHaKLlngP96/r+o/copNuqYATT/uhGS/elCEkdZ4kcwsTru?=
 =?us-ascii?Q?9otGD5D8ZF/+qsm8IzjHKboySo+BcZ6zLD0bLzxA4hhOs0P9cf6bzdwTcLYR?=
 =?us-ascii?Q?bBVNQ5sqUc6l1aCVeHA9zW1HCxIldnB+cYvHYDdaGI40+cqEp2bkAdR12Rkf?=
 =?us-ascii?Q?iYE6+PxHKb0RWejAL0MYwdeqh1JmU734PgZS/Zj16xqENCpMJUJY/9goY1QU?=
 =?us-ascii?Q?n35yDkBn0VywyiH+elq7hJIx70Qs/a74+tg+fINqHgPnqLDngoq2OgmL73vY?=
 =?us-ascii?Q?QTzsOqrpSQUfdBi1XDoTXBWmBQ8/xpJFeJ1vgMsHZBPxeFIVnf3nvB2+5ndP?=
 =?us-ascii?Q?eHE4GHuaL5kv5JfJWQ7Arp9jMK4H+gD6fwSLBIZl7zuhS6a+385XZ0zUdoTM?=
 =?us-ascii?Q?KLPrcHBPJTslQQtsbWJRydGIPIVbH1GKRKjZw85gdUAP8funWOmPz4SjEwrQ?=
 =?us-ascii?Q?P6I/ZN2Ed8xVZPyZo/S8WwFO4yqhIDMbYRMnH3Nm?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <34E8B8AFB284A44689EDFCE833A9F89A@namprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f82146-d25e-4874-f219-08ddd091ba1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 00:24:06.7314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b+w0IDDKvjegUcJ/4LfD5u42/QadjugP9FJ9OlYn7HEdM2yRhPr9213QH5N0KzpYa+pggvQNSo1pWsQJyNOxww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8004
X-Proofpoint-GUID: xI4ievmbr7BxI9naNR8dfrAszxzc1Km1
X-Authority-Analysis: v=2.4 cv=PPkP+eqC c=1 sm=1 tr=0 ts=688c0929 cx=c_pps
 a=kTz8n/oXhugbiFfz+wFpMQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=rhJc5-LppCAA:10 a=20KFwNOVAAAA:8 a=pIV2u4D_VXOSVoivhE0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: xI4ievmbr7BxI9naNR8dfrAszxzc1Km1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDE3OSBTYWx0ZWRfXyH8hSpc7muWh
 zEgDKPBDwP5KiZg2CCxLJpRkG13X1SCjKf0TqRhuujHEU651O06rZdRaYLO+LhQ/3/Vo4KOV/jP
 9QAGXEiz0Sn0zYJ55zGYZPb1MBI+HqR91LFmHC/iFM8KDIElSNCSgZgB53gfO5dpEuNtMSBA5W7
 q2Y3u9lPCiKKsCztKZ2b+7VTmYKMQohVyeHGC9NmOmB+12WiRJPcXvDIj1hqEqlHavXw6zeDvRl
 7H777pVgvrzsEHZ6VJmt7/kZL6yroVDkFn9mNSwl3E4kayKkhBLdUrg0nVYoYdQVPc70zrZFMiv
 WjqMeczH42AuUgC3TwfKy7k6jCvhgvRygRnJA3befWpSBaHFgjPnNY47zXI4xOVii0She+AR2Vb
 S9TjmPm8k4nyHE8Tf3AbR1gVgUvME47geVtyoJlozzPgC1O3zlAC0yX1nmxlvvGLV948JCQ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_04,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507310179

On Jul 31, 2025, at 2:27 AM, Dave Young <dyoung@redhat.com> wrote:

> I worry about it since dtb is for providing boot related information,
> weird things could happen if the kernel versions are different.
>=20
> About arm64 and powerpc I think maybe just nobody noticed this
> problem.  IMO it is wrong as kexec is designed to load different
> kernels not limited to current running kernels.
>=20
> Otherwise the current kexec_file_load syscall only supports passing
> kernel_fd, initrd_fd and cmdline,  no extra param designed for dtb,  I
> don't know if there are other ways via attaching dtb to kernel or
> initrd.
>=20
> Probably you can try to add a new flag to the kexec_file_load syscall,
> when this flag is set 1 then use the current dtb, otherwise do
> nothing.  For arm64 and power,  ideally doing the same is better,  but
> I'm not sure if we should change the old behavior, maybe they can go
> with  default to load the dtb, but users can choose not to do that.

Hi Dave,

Since we're changing the default behavior on x86 by carrying over the
current DTB, and this could potentially affect users, maybe it'd be best
to put this behavior behind a kexec_file_load flag, as you suggested.

I'll take this up in v2 if no one else has any objections to this.

For backward compatibility reasons, changing the current behavior on
ARM64 and PPC probably isn't advisable, so we'd probably want to default
to loading the boot DTB, and users can choose not to do so. I won't take
that up in this patchset though. That can be taken up in the future.

Thanks,
Brian

