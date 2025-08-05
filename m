Return-Path: <linux-kernel+bounces-757049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 264C0B1BCF7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50EF627643
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2512BDC15;
	Tue,  5 Aug 2025 23:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="bP9KI4a/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="HqnPCJzW"
Received: from mx0b-00273201.pphosted.com (mx0b-00273201.pphosted.com [67.231.152.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB62D2BDC02;
	Tue,  5 Aug 2025 23:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754435574; cv=fail; b=NrXsLDQ4hTE4o+YfGl05gto009r82BWi5fL+4BG7OEluSMVAgrw77yPW0iYXpb8t5dEZ4SYoKiQ3jlOsdZ9Zlx2Jx2h8f9b/8eyvid0Su4Rv/PrKYk8zE3IZKSfhVv+mTpkXrOQbSxAMuC9SsNPw0fdCmkqMfTVhqALODIRv7dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754435574; c=relaxed/simple;
	bh=MtfvruoDA4W7P17ACL0ZgS+VWCceU7v+E3DPg56Awa4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MnxbvpHO8Gak2WCJoGU+XgTeFz8iHZ0AQT2+D4meOPjliC3BHqXkkR1hsjXpfTgEV7ldBXxD/q/JIJWGKNDL1Z/28cGFuXVHuGh/MkINEkIy4PBQIm55dIjZAALH0fVImTBGoHP9l1Dzl/j3YricmQO0t2utr6BFxDa5YQ5pv54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=bP9KI4a/; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=HqnPCJzW reason="key not found in DNS"; arc=fail smtp.client-ip=67.231.152.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108160.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575M0CTK009481;
	Tue, 5 Aug 2025 16:12:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=MtfvruoDA4W7P17ACL0ZgS+VWCceU7v+E3DPg56Awa4=; b=bP9K
	I4a/0zPOGR1EZ+0Aeb0Ht03vcKs7r2kVAaExtXMTOSv0b8z6wiwFpG3uHXMm8zvS
	22ZZnoxsuv2TsJF9GV0qhGC27+2ByNaieeJB6qNQWqeUZlPSvVKy+s+zLaJl8Ewd
	PtjgWqlClYFcYuOk5NtZsdrkJ/hsPaQ3fFrMztJexa4qgSZxQS0bbZvIYcbLycxS
	6DYJ1ApjkbZxOI1YebACPfdvs5FxUey5exR24BNGGQmKZuiYl0L3Ppr1vtjQ4Gfo
	vgS6+wNt73UPkVYt3FBReQWbDaD1kNenNmu+06xsKJVs6Ylg6VC/ZG1wFlcAHE6/
	51XJ+MIX4zj7DGgZdg==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020125.outbound.protection.outlook.com [52.101.193.125])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 48bq01rnqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 16:12:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WaepYppGo8bXnkIxg8rujMh3b2QKRo2ejsqMgXYmHmd/qPJehHQTLCIrVYPlW1kToic0o+t20GUTCeBQhRb183Vqjy1XCPuKqWNNwHbGBn8sh35qVlhFjU/Vj7cRajXi2IutM7lXZAi99FXVlKFdsvPOi2/Z6ZetcKE0eH/IBY3U4M6Cm6UH3+E5iyf1S02wMWHpVh97h/kZ3SglWVSdvaiPxquy09ND+t2nG+9L9RXQpyKR7jJfV1xgNQkoaqoG72sYSa15vg+f3MRvJ4GVtH9xyIZeHYIetUtN7UIrGbs3Lcl7mVLfTjBc4SxuDb110eEtZQnmGkzitcNlMKKMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtfvruoDA4W7P17ACL0ZgS+VWCceU7v+E3DPg56Awa4=;
 b=ZufGXrgSCq7DqpbaIaUqayaF2IOM02oaOf901TYhs4h6wLlx1rHfgnkmR7MNhfMhSp0z89rX+hGVlt1mH156Erko0uiqh8fw+63DXbrj9++l7F1K6QoUvtHf0czbVWscm8E9oQrIrIwcCeE+Ko5yswQSs3JilEp1qMgsmyZ7AggQLlf/0KNFRXFw53/7mGBNKe7kcoy+ihwj+rZ4vuIlwfMsH5NpFkT9GJxyG3rOoIETTC1BIbfFoY7/H6r1rDZueMKVjSdf5DPNR/wHRq7BSDkhxcmgFuc4oWbgtfC1iimltvGZcNZeybUOCGWR/N8QQOqVldqBivL8XqLNIUJzRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtfvruoDA4W7P17ACL0ZgS+VWCceU7v+E3DPg56Awa4=;
 b=HqnPCJzW62wT7AYg51g9b6kRS3ddle8wpiLUoOFcwLsKCN6WjEaLFv81dSNgzAr6IKXZMCY6xrokefErmtrps1seuFKlDNc+iyKqFELzyHR85r72e8aIcCMhOFuHTLPPRnpSTFgJQGOh6RQdwkRbPDAcFBgCTmGpMAXI/z/QZS0=
Received: from DS7PR05MB7288.namprd05.prod.outlook.com (2603:10b6:5:2cf::10)
 by LV8PR05MB10574.namprd05.prod.outlook.com (2603:10b6:408:1f5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Tue, 5 Aug
 2025 23:12:26 +0000
Received: from DS7PR05MB7288.namprd05.prod.outlook.com
 ([fe80::d1a4:ed92:eb4d:8b24]) by DS7PR05MB7288.namprd05.prod.outlook.com
 ([fe80::d1a4:ed92:eb4d:8b24%4]) with mapi id 15.20.8989.015; Tue, 5 Aug 2025
 23:12:25 +0000
From: Brian Mak <makb@juniper.net>
To: Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] x86/kexec: Carry forward the boot DTB on kexec
Thread-Topic: [PATCH RESEND] x86/kexec: Carry forward the boot DTB on kexec
Thread-Index: AQHcALW+ZQjjgT9X7kW+00L4/dZ7pbRNIAYAgAESSwCAAiPyAIAEZRMA
Date: Tue, 5 Aug 2025 23:12:25 +0000
Message-ID: <4EF3C437-1D71-4E98-8397-7813E2CB7403@juniper.net>
References: <20250729182142.4875-1-makb@juniper.net>
 <aIwuSFKSUJDI6ULl@MiWiFi-R3L-srv>
 <5A9FE2FF-800A-4458-9929-124EB89FE1D9@juniper.net>
 <aI7gBld/+yKQ2EXM@MiWiFi-R3L-srv>
In-Reply-To: <aI7gBld/+yKQ2EXM@MiWiFi-R3L-srv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR05MB7288:EE_|LV8PR05MB10574:EE_
x-ms-office365-filtering-correlation-id: c6540b05-cc37-48d7-3e76-08ddd4758a90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1X7puRmFL6+tUNxWwjJz40ITlX/uQDEGUVeFw+K/cGW6dqKUCmdO3lew9ccD?=
 =?us-ascii?Q?c6rhksAx1tLmHCsJvfpCdRvIA3bLLXgSdzXsDFy9K3kYNzZ50omUJwbzgSpy?=
 =?us-ascii?Q?PGdZYkO+Us/6xaavrkHJFdpw8RlnijnuLiUEiSzTdcTwm8wssUk94QOyBF7+?=
 =?us-ascii?Q?QWNdy7KQYxQiQufvRvy1EWlSEkRT3btY+6r929am3cckUoc9PaqoU9cqQZEt?=
 =?us-ascii?Q?kGyiC7x2XTtz8MkZ9FotJf/OygR/YX9K2imbMRWgj3iQEb7wAh30/ADVvzmW?=
 =?us-ascii?Q?NgfFsAKiZVOVfdxT9yGO4hePFMs0I/qRu9cmmrifTutBkqxvlgH3EkDQKPMX?=
 =?us-ascii?Q?8ZB/FtmPZijvtpVx5PRzTQ5ZBYL9cKNbaY7T7rONtFqt6ch7mqTI1XAPtUNe?=
 =?us-ascii?Q?uume6R1ZGkraaCrUVg1CKfCgxoLryq64Bfe/d2XAWP9rJAThtO+5mPxe6yvo?=
 =?us-ascii?Q?G7vOoIgdcL5yKluamVwYZMIWqEenvE1aL5yxAwCG3jVL638Pk/BEp8oFu1zu?=
 =?us-ascii?Q?sBeupyowKdG86SaQIWXaAEEgGuunoefeA7oWF1zPLUbbYCVhNhOuFdBCIKG5?=
 =?us-ascii?Q?onWI4eD9/t/iXFg8CZ6imTtalQg7MOMUvWvI5V2xTyU6rRbPHNkC0pDBWYdA?=
 =?us-ascii?Q?UV/JY/qzUe5ZH34hmA5SFUQMH59WOtnb3UwdDPG8Dun7YcUB1qE2jALzeeDG?=
 =?us-ascii?Q?uTCf9dMq3tfBHMIPZDY5WFgDTmqgdYjYm9r34aRCowtCbbUp1lBAEwEPBZ4b?=
 =?us-ascii?Q?kZCt6s/I2fKR7+DCoi5joV5aALmBTn13/WuHHzOMXduQ5pomZebM6jWk/3uM?=
 =?us-ascii?Q?maBFJtpg3p2XvTtbOOUQDzm73scn8ri4KP2cDVQcVXDWNUoLBWAAdOeg5MQK?=
 =?us-ascii?Q?YjUwE+BCqCbTDSUPBMR/3EKf4yaW6fEWmcp+5YkLIsvZZxc6J6mSlgam3tWx?=
 =?us-ascii?Q?MNxTxPbyQKAyllL5ymZ4VTsuU60Km6R+qoR7d58a3eC54TBdnP2nYqpxAst6?=
 =?us-ascii?Q?rp2Rj9O0EuI6os3SRiMOu+18HOhV4fEb+5+Re2HYRdOq9VAmUFS18o5NnHIJ?=
 =?us-ascii?Q?ScbvMwihuD1m35V2yYLbIUqUZauN7o+h7phuFOTjvqYTFah13foMmFX1Rp9P?=
 =?us-ascii?Q?o0LoR0rVxN3oiV5TpZiiyozAMcszZIzyGkjBq9ZL4I70XM3LTnLoYaeyUiPi?=
 =?us-ascii?Q?kNHWlty8Ix3G/IoO/q+6eM7vwbbZR9r+qNKNbiDidWTv7jf1W2WXqFQ+i3DN?=
 =?us-ascii?Q?pxzz6kHdwftrHI9A67sA6veyCojf5rei8taHo1984hujfqIa6W21L0FZsYcU?=
 =?us-ascii?Q?alhWgl8bAE8Z2dYSXLkI94Ymhn5eQ9oaHq2dW6DdSrCkPg54K7d35/zrSWD4?=
 =?us-ascii?Q?N/KBwLWv14zAfz/2M5jDnA8+kMOWsl+1RL3Fpaa4bhKbJaJBUXOkQkU5ZbIc?=
 =?us-ascii?Q?Z5z1ABtsMnlaR8Hs5dPFSXq7WzKRPJgL4QyV1g1uV8AeuMHbxWXePJUjjzWg?=
 =?us-ascii?Q?h0ch5AFgkqRcXe8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR05MB7288.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RNxI0uqOk1lKDAWHAig8ws0Da0Z0jevnOFFd1v/h9nscnSbgf6ZBODMcEdta?=
 =?us-ascii?Q?YTume0oQXdHhUb6U2QNzoc6R63NYrFKwUI3HvGhcglyWaWGt5+xeJd2ODhFF?=
 =?us-ascii?Q?BCzeFU+XF002/xgeJm5pO4mowtm6gAEtY8ib40PQ2PeGhBNeauBpXcXK6zlW?=
 =?us-ascii?Q?QgtzqmPnMzI69hUcHTu4tqJY4mEvFy6qhbTza4VEkrhO2/raVkVEA/PZDkOR?=
 =?us-ascii?Q?OwgyaxmVtq8gpnw2dabXF4w4Fu+z98xdfabM5z47jpWDLXIxoSMSq1MOuO/Y?=
 =?us-ascii?Q?oyfmtTkg2ecnq8CTjhjoW+Z2JVbYXlV/KvYcLfEzbRix9Q26Vrc1q56sL7w+?=
 =?us-ascii?Q?eJkPGj4tQ3IAK1BtQmDypLkAAenmGvnuNZ/q49AqPskrkoA0wfQoIpFj+a1W?=
 =?us-ascii?Q?IOQXjBf/v4vZsKFv3Sjaom/VLMurkvLNBhPnUV43ZmcWSgLD4AbGcGaIknQG?=
 =?us-ascii?Q?ZychZvev52uEUqPQGfbpuAJB52xyXmqdXsQHlGV9i5qwJ+tFDPu1cTl+wY+0?=
 =?us-ascii?Q?PDbYnMB8rzId9m12wrWt09f5TFcGItHaahK6FT7HXQz8r5Tvsnr2EBf5me+1?=
 =?us-ascii?Q?K3evywbOdYnAOn01/WHijlmLkJgEAyCs/A4yLHq9aBjj/NoI662FK0FEW+ia?=
 =?us-ascii?Q?stmyqDaMOQxNQpMLhltTvaHPxy/qh0zxUw0BUdUatk57mwlvpz1hDAkQssOx?=
 =?us-ascii?Q?aU0IDMTKhiRWlAQcvjxQMQ6rLD6nZfr2JnyIjj3ky9Q1f67/Gjb7xFVOrXXu?=
 =?us-ascii?Q?T6mhEU9L2BdYnQkf9LBs3lLxMMR4Lnq6fMgvVkXoj2qlDX8qYOCyLvKzBMCt?=
 =?us-ascii?Q?XswKjwMoMH0l6RQp+XJGaSFZNEW9CHJP7GC8YO20ae2Xg9QZjHb/51BPeC+l?=
 =?us-ascii?Q?CB7tB0xO1Tbgg2SPVJOQb7emHgOr93OWIRU3yKTe32mSV6Y7sICKo/iWfOTg?=
 =?us-ascii?Q?LFtAV1YWO9I+/WJ5D01g6THu0Kydoyins3MmuiYKOh2RRfqeDEa84zoeItM8?=
 =?us-ascii?Q?vbZZrMNGCUjYxd7fC6gEuoexkI9eoThN4qEu6v9ddyC8ICgpTbq2jVf/ndoP?=
 =?us-ascii?Q?r8c3r3d6WktjgkDiIvn4VnfpD5vMDJDP0vg6eSa+vb0WV+jOHR131TJT8wri?=
 =?us-ascii?Q?P6HL6rQ5BqQUJbcfTHwtC5382YJWJBA50KkVoThvloV5e/Ml8UkKHLaJFAsD?=
 =?us-ascii?Q?egyHrHr86XH3QDTjLnU5eMv5L6ZvZXCSqecUkBNxvXrAjd3jsTZtUINai9wx?=
 =?us-ascii?Q?B6vlI4hIsvXU9W7ySaC0CB4VAj2zoNvRfCjGiVU1AVmH0eiMJOxgVf8qFwaW?=
 =?us-ascii?Q?MwrcAHiBicWKL0qmD0po8yQRpJmonC+HBqqP+uaME4stmYRp5ffRuhpBqpxy?=
 =?us-ascii?Q?25KXu6uhfF3FzblwJVLWgxSWtHueIJxJIJhnnzUisXyUfHmIgIM6bTeYFb1P?=
 =?us-ascii?Q?5TZwvbONYslSm2qtMXiOsPNqjk8kFMxkbOPbGvPk9SKUFK/3rgxZ/Lse7LXJ?=
 =?us-ascii?Q?ZlG0eckHdvNX1Erh5wRX/4jo715+QYyb897NxIZquJCEiWagl1PIc1HCzUcl?=
 =?us-ascii?Q?4MHHuzruj0hlF3KdsO/lJSQg80FUvMYJHMvPA9Uq?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CFA5370356791C43BBB84E4472A55ABB@namprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c6540b05-cc37-48d7-3e76-08ddd4758a90
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 23:12:25.7304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jNUUK4uy9c5xms6lUCVmBMmob5PPrBVf/KNY4Iip5ICGiYweb05j8AOCE8TL/virX15oz5ZHuiuykLn/IqeeuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR05MB10574
X-Proofpoint-ORIG-GUID: A-0vFncVUyoZq7zDE_ycZTVhmTvzLF9c
X-Authority-Analysis: v=2.4 cv=fpbcZE4f c=1 sm=1 tr=0 ts=68928fdb cx=c_pps
 a=bwebfZLPylI8eKm9xdhY/Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=rhJc5-LppCAA:10 a=VwQbUJbxAAAA:8 a=OUXY8nFuAAAA:8
 a=20KFwNOVAAAA:8 a=cHn8m1s6wzayIwUR3RcA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: A-0vFncVUyoZq7zDE_ycZTVhmTvzLF9c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDE2MiBTYWx0ZWRfXzQZia/RZAN0h
 tiJpErHKi3sYWkKaNC4ik9j21AztaCHnZHIQDrJBFHkPUpZBi+dvgHYTphMkONq9/IbNQls6V73
 hQ3Z25Tbrs3612RObAMH4Zot++AeO9uvS69yYyiRnj4gJokkyanZqNnYh7jyxpsSeY7fp8dkKla
 AmC8WJg4bKb6CB5XzDQDjjeNd05MSZxSnnnFW0HP8fuOTGysveMMs4mh4GB8b6KqIGkX7Cwq+KX
 7wEZNKVhY6+TrKs1cRLQfokd0wYEmjk7vNf8VNUKuUxHeYmvG3a+XTAt0NQJMyRVtdwPTv45ymC
 Fv0AJkEeUvIKODsvC9pCiGwm1AOR/d7h2Geeb7YI0WdHmcoON0bW8MPPDgByJGt/rms6ghJesye
 AnPHpM3XxKeS4MK8b04c7DQN74T7GC0aE+2J3JFbm4THtGoPWFiS3hEMAKnFEsyn7Jc0JhWI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508050162

On Aug 2, 2025, at 9:05 PM, Baoquan He <bhe@redhat.com> wrote:

> Thanks for the info. Please add these into patch log to let reviewers
> know them. We don't add code w/o objective.

Hi Baoquan and Dave,

I've raised a v2 patch with the requested changes:

https://lore.kernel.org/lkml/20250805211527.122367-1-makb@juniper.net/T/#u

Thanks,
Brian

