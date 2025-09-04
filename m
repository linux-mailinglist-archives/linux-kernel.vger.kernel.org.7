Return-Path: <linux-kernel+bounces-801593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 454B6B4475D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D241CC1F6A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B2128313B;
	Thu,  4 Sep 2025 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="qUWfkb9o";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="bfc8w8mr"
Received: from mx0a-00273201.pphosted.com (mx0a-00273201.pphosted.com [208.84.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454771F872D;
	Thu,  4 Sep 2025 20:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757018054; cv=fail; b=se0Dyhr/pvhMZYKqaBgaHFmRG9T7R+5LsDAxnLDLNHex9wvjE5AVGi6j1UireeOOB+P3tKrurRsY7XNSf6UURH3N7jmyVzQ4ujlM1PxcjPn+anjmj+VV5W7w3Ptvb4hLGUcW0HyDlUz04C+xUvFG04TRBGU2Vkg5ebD2NccmxLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757018054; c=relaxed/simple;
	bh=jpgBRa9BC9juHQV5KrKH501Z9A/JCzAD4EQ9UQoxo1A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dRcJVX9xPqpImVsY0uqnfFzwwkjQD//dclp7xtKLIkxoHwQlo15elXzHLmRqYPzkDYxjUd8aXuHmZuYFklRLAkc14STJNJYOjYSqQbXoO6uK4AsioZvE5N3j9lU+udhPOKM1ENDH6xdA5uuCTIZA0E0XrNwNAulkGXxwb/DUYo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=qUWfkb9o; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=bfc8w8mr reason="key not found in DNS"; arc=fail smtp.client-ip=208.84.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108159.ppops.net [127.0.0.1])
	by mx0a-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584GYnY0002918;
	Thu, 4 Sep 2025 12:58:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=pFA+dN8v6Wrhb3qQUpZ/arg2r3bzDZUs1Y7rOtgirsA=; b=qUWf
	kb9osDPJImfSVieXhqhq0lAJjwVZp1rEllGbZ0kQvp7smBg8gd6HWsdw5auD0+RK
	oNT4Aql55BrEg4uPwQhS3w1tMrndNpi9GdMiz2qPSTnAsUFsDBimT5VGKbS2HfW5
	NoKqdhgs0zUC72/D6i83LHb7Q67Pa5XJTcB9fRxK7HRjH065saoYu2E3aY3sOqQs
	X/z/AkTGGGi18xtD2atT/4YEq6wvltlKgn28sdTBYyR1SG3naP6jrxvPeDKYlu9p
	/FbnAqejll7X1NjTn3jFE03lT/92kFZpZubhtjFlNHFMHUsA6TMAj0yI7XK2q3Kn
	CzVeOw5iE9sEm5Wm2g==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020080.outbound.protection.outlook.com [52.101.46.80])
	by mx0a-00273201.pphosted.com (PPS) with ESMTPS id 48xrytbcqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 12:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ao+X9V5uKISb7b2BR8sgv4yKzDF/XHhgPCv7rjhZA+mbpFY8Lk6TbiMclH/tAW/kf9pVCBGzzTCqePZeQLKp/4/2jRHMfI1D3DJqimvEUrRmqp9xd5s8QbZHCbFq3LEMyB7lBn+W30gjLkzJ2Iaus5H2hbykBu53CjueFJSjI9pWS/T/9YrdDJo1kV2FA9ZGV9jKrrTh2CWK8+TVpiuD8R27OLHq3U0u59pdoNy8UXKmJ9WJo4D0GWIVb4AAhNH/oSAxXN0OKYlbUE8my7e3jjLvH2O5PDylZy2/s9EG95VTI9af6y1K5NDH+nxtMepHJFJyUwG+Ast59gefJTuJIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFA+dN8v6Wrhb3qQUpZ/arg2r3bzDZUs1Y7rOtgirsA=;
 b=Mf/3wmgAl1XH09IFXvsJX+f2lWuxBj+KxvObXO+2qP2hGJOQe1hrFQcSU0RsV92BtiKjESn/aL0UypRFIYI5aCuGwVYmA8wRN8Q+l7Quo86FZEKVF35c/A08Xxg3rGPKSdqajVtobLb4coetDC4VmPeV+nz6TeR/FYQmT4PZfmOpHDHDjYEbzR8XFLxPmKe8DP37faxxfCzGrLeLauPM6O6WTOnLmamFMsLY76BmXeXO7/xi3lgl2sfxqFvZST3pgUONkqusX7oabm7FZTu+wcbNi1OY2oEUd6so5GRB/Ys1Sm+86lPFlznVDrFGCZ/XM3364g4PeFSyQReknCRQvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFA+dN8v6Wrhb3qQUpZ/arg2r3bzDZUs1Y7rOtgirsA=;
 b=bfc8w8mrFUDRNQtcXZw8vJLnyhc43OJR6A33pvjUesKspbSLmA9nHXrigmYs8Qoe4oG324gctfgV+waUjUohZot03NO7yobjq8TlE77PCTkyvvg17HcqeHtsDcRJWFMAmqwAtyH7dGSHAc2qreOjzW7p1lwB+VqoR6dtjfxVLfI=
Received: from BLAPR05MB7284.namprd05.prod.outlook.com (2603:10b6:208:296::21)
 by BY3PR05MB8370.namprd05.prod.outlook.com (2603:10b6:a03:3c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 19:58:26 +0000
Received: from BLAPR05MB7284.namprd05.prod.outlook.com
 ([fe80::3d79:19d4:e1cf:2224]) by BLAPR05MB7284.namprd05.prod.outlook.com
 ([fe80::3d79:19d4:e1cf:2224%4]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 19:58:26 +0000
From: Brian Mak <makb@juniper.net>
To: Baoquan He <bhe@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf
	<graf@amazon.com>, Dave Young <dyoung@redhat.com>,
        Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov
	<bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin"
	<hpa@zytor.com>, Rob Herring <robh@kernel.org>,
        Saravana Kannan
	<saravanak@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] kexec: Add KEXEC_FILE_NO_CMA as a legal flag
Thread-Topic: [PATCH v2 1/2] kexec: Add KEXEC_FILE_NO_CMA as a legal flag
Thread-Index:
 AQHcBk4oB5XugUC7+EiYsQsd7ryXGrRsoOkAgAA/AQCAADfZgIABBqSAgAW3BoCAD8p2gA==
Date: Thu, 4 Sep 2025 19:58:26 +0000
Message-ID: <1683D348-3A7C-484F-B21E-7828B96AA263@juniper.net>
References: <20250805211527.122367-1-makb@juniper.net>
 <20250805211527.122367-2-makb@juniper.net>
 <20250820214756.5c7b551e4723d9f0b5dd55e3@linux-foundation.org>
 <aKbZ1h5mjtfoFMh8@MiWiFi-R3L-srv>
 <20250821045319.72e81f40e021e54e2131ac44@linux-foundation.org>
 <aKflAV8XNjqeu1Dj@MiWiFi-R3L-srv>
 <9F68DBD7-8A67-4FF4-AC99-5D485D9F9313@juniper.net>
In-Reply-To: <9F68DBD7-8A67-4FF4-AC99-5D485D9F9313@juniper.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR05MB7284:EE_|BY3PR05MB8370:EE_
x-ms-office365-filtering-correlation-id: f3c35982-666d-4ccd-46c6-08ddebed694b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AAfN79iIlol/vE3PwQTX1xj8AE8qS8AA2554Lx01oNYdbG4aSdF58WcmqPhp?=
 =?us-ascii?Q?EuW+I5QZnuuPFNn4phH6JGdaDkIYRYXAHmgD1ivAjMZX6rKmA7psKwSo3aHv?=
 =?us-ascii?Q?Hp2ohrFPpvh3JRfzdff3jpYyObRIP+7hzWKGNP2e7FApQR5zFYPbwmnHis2j?=
 =?us-ascii?Q?Hubw5L49zgjcYnRo+OMfZTTg+XjDGjZgkDG0yr3EQWZKAjtes+p1i8+CCnCx?=
 =?us-ascii?Q?BA/NtetBTkGB15+qZDDZvaFYMQIClTKTbrf6a/XYFzqYibOKK0Mt/W+snn7d?=
 =?us-ascii?Q?0WWis0lOCPEr2HZoJjp07aq5MU8dpYjygA0XFLSPYUtCbl/lna8Y8ogn2iGi?=
 =?us-ascii?Q?FY+zGW+s09clp5WSbzAk6YCUlSZiIcpkmziNeSeSBkSecPdOYhPXfcv3RHcm?=
 =?us-ascii?Q?+Anq6OvRHrKGZALL7Eq70530Ai1fiNK+ZfxCfGQ+79gCoaHi5M8gQ019w6Zj?=
 =?us-ascii?Q?0DGBe4LpUMihaYg8iQch9yEOZ+AzDNbojj7sXLqwZCNIif2XSufQN4LflgLl?=
 =?us-ascii?Q?3drJAjwX1I5yuVFuA0khrcQAD7xuPLt7lw54u38jN4sfUv2ouYxOwtz1pv0p?=
 =?us-ascii?Q?tx7qwM5c7Xf6EyH4zKD1a8F36HAl/HFQLsZ7I9tJiBFla4sK/d3QZAQG4aCf?=
 =?us-ascii?Q?6R7rZIjzEFsFvvUcaAgtfZNZh6iS7SYkAi7vcq4843SjBeTd5PLx3E19h8Ip?=
 =?us-ascii?Q?2wkY3rRL2CjFJhk85LO7BRdwSw/PPmUEt2MmRtFWWhgnjSTgL5OvYKcLZNWh?=
 =?us-ascii?Q?CNqOwiljty6aNTOQgSF/0gyaGZaOpleYcbwA3kJLd7+hQ2PZQRqouDKwSb2z?=
 =?us-ascii?Q?UOdUd0mY8YzImmLuHM6cshMMAf/IQatfN1f90Zn13Gx4y+MojAPNqsNEqryu?=
 =?us-ascii?Q?5/pISuzTGaEe9iFEBoJTdQlwQbE1McCI53GP7fUOETCKsZ+2w3Vau4RVFhcc?=
 =?us-ascii?Q?+d2tO5ILYeYTPpsU9Ytsu9qyjw2ivI4OIWjStzkC7TgQBV0FU6G/ahcDKbiy?=
 =?us-ascii?Q?hfEpMZTQpTnmoAzfWYhbKagAMjEQpLdyKpEHtc3njv316N7sjAjmLGWQ5ZQV?=
 =?us-ascii?Q?tDpBTofzwn6rdfO0GEpx/yWZ6A+6nH6sGW8uuomS8hvA1MNm5G4rJVf6QblP?=
 =?us-ascii?Q?SCkgGeBgVYHg76u7MfpeArB9MDZZXgmQVRJ8pX7zMJLzZl2DUAG5kzlolpDp?=
 =?us-ascii?Q?2HQAa8kQlNTqn+btAIoarefcpGaBEBillSQj3SWvoD2p/OOfq/6UMDQYhW0W?=
 =?us-ascii?Q?YlWw8oZcc7Z9d3eUkZYLO115aG4m4cQR1jIc4AUqgyQowkGU56g68EeJM4Hc?=
 =?us-ascii?Q?Gq4+K6Z1RaD3y7GkW3xBqshTdmav0D1yg0dThAwrp2qZfPPuyIe5jJMsPcKX?=
 =?us-ascii?Q?+cr15SPfqMkjbD0xd0R08FbdSNMl1llGj8cPYO0Hb2HWN+GcgqhNP+iEJ/3k?=
 =?us-ascii?Q?Q8YAniUMCwQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR05MB7284.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UOtKGUKDOj7jjo6oJh0XeVwHzIrCVc99EVUf3y/jWT0W17x8WM4s2xe3tvoH?=
 =?us-ascii?Q?y+9XWoW7rXJelYVceFsuTaworCYYIVw7BFFyiTNCSSnc8hCFoVLcx3hiTE/q?=
 =?us-ascii?Q?mpHHvBPz/NUCw0mrjeT5l0wmojOg/0nmqWCkTTlJNSO0RwV+/SK8k8Hb6B+s?=
 =?us-ascii?Q?xi18rhkHKhRtWkQ4r6ULVisMO1NVscxCYxoHnozwPr5X3S80lMxeY4r+cZVp?=
 =?us-ascii?Q?BbXAxNwz6wPRqSqY3J/3Xa1HmyEgSZ5EfYAm9pXgSNo8B4svnrlMSoz7gcqm?=
 =?us-ascii?Q?YkmandSzgqhE5hhAgeXE8odWazaDJjHiPigVG46dXySXYJvXd4dbUuUFQDQo?=
 =?us-ascii?Q?ncNll+AOwRG7N53EJdyyWMPJ/eR1VYY9I1dRsWHYpCHc346n6P/HcxTfNSt2?=
 =?us-ascii?Q?z9f/AKhCO7Vdg20uKY4tYq6dMPSwQjFCB+MjonZ0Lnut69VQD3OBee0tcJIm?=
 =?us-ascii?Q?2Mo8bj1xTnCaBi9n3cWnI1+jjkB6ob2/8EL1Gbw73bhqm+b3eizjQq4uDpYl?=
 =?us-ascii?Q?Ko0vWtzFCWs4FkHaoGz35+rp0DzFTZBIs4ic+jjPa4se4gdwT6AhHMZS32KZ?=
 =?us-ascii?Q?WdbWGpopAoyLtYQhivXKragTbzp0VlFcIrRmr29EgsuGY9x+BKzyQT759cH/?=
 =?us-ascii?Q?v7sJSrcH93ezo0eQ/8tBIfNpcWjAkE5SdPNTHtWCEUv9leGlPYgMoEKmtPp7?=
 =?us-ascii?Q?Gh1b2KdZzR4JrtrKYLI2ybBiTKGmaCXSwlDOAbo28MfNKYraSFLQRTU0/BGV?=
 =?us-ascii?Q?V2S7Y7uat0bMeavz92YzDV/qEjD7ZlIymxwbfjTQFl4/Pe0wuk0cdiaN7nLR?=
 =?us-ascii?Q?BImdA9m4dX04FV1Icz7wDorHEL9LvzlACh431pnS6dyZhU9n/cFk2XaZxHhj?=
 =?us-ascii?Q?Qi2D+0ISn/qHCCApClAUpsQY3xPz+KY/qiSCI0rRrMm2zBv97e+5nYhTiiQi?=
 =?us-ascii?Q?cew7FNh4a1FKYhQfGA30ZkMO/vcBigbAZ4ogIPzorGK3hQNbUJi0sY5MpIN3?=
 =?us-ascii?Q?T86Lwk8n11U3Npcn77rO63eiqW0gEsIrC4+dYHioxpfRp/jjtd1AfoYII7xT?=
 =?us-ascii?Q?3pcN6LeoKrSw2K2svhQAJsQhcgunsqNT+tVazj0dcoXQHpjgBv2V49de8BOl?=
 =?us-ascii?Q?vNedi3oeiY8ce1oWNKe3IOxKfchIR59a6NA6wgjTQpdYmXunTMRA9sqsfNoc?=
 =?us-ascii?Q?394s5sMCL07WoPvtXFr463DibET43TbUC787m/ChC9E7K22bxF/pAoaMpmwp?=
 =?us-ascii?Q?TRUBtxfhIBh0c4ErJ7ibaA+UajNch/OczktAJJKtwPDs1vFNynQyut59E+Rq?=
 =?us-ascii?Q?+HZA2h5LbcpJkJIKwKTt++UkHdN3x/q0Ayr27SzYKx94RhRzlDAyw+iQc1n6?=
 =?us-ascii?Q?TNHVIXryzF1o+gtFx/C/y/He7rk+Osm6A6NU9mCxvwhQ/8YsMQHsr6+Zepeh?=
 =?us-ascii?Q?/0LrO1GzfPpR8PnmlxTSbrbgmXjoZkS8BIB+dVuX6nIagT6vM69iVsjrQ/jS?=
 =?us-ascii?Q?Xfn1nAwG/t9qwkmEZdB9VX3XWcw1NPv9zEHDzrd4nwpjGhnX7VU0/VVWyRp4?=
 =?us-ascii?Q?wlkvJwSYrjfbphjaVDVuCHjm/fKBYlZOsrCclbl+?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2E1D8F21CF408645B28729E1765E65A6@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR05MB7284.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c35982-666d-4ccd-46c6-08ddebed694b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 19:58:26.2437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OOtznzkueqVHLxL3pkgneH1Txds7hy0siIKEALRA7hR2X826zq93g+gsCIy2ZbWupcyiKqebSF+cZtrsyrlNGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8370
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDE2MyBTYWx0ZWRfX15JRWd+5fdaw
 BW5lgOj4pI9E+oyx9yRu0KWLNuJ94SjcPGOc434djGtcHRfE3mHQ7v0Ij9S8mpZ5tjlGhyj9sky
 1KLC+mj7jIXRFlt+6RZpxX+r7+ptz+tb8kpO06Hbfqnf2fRnsQ1c6BajcYvg79L1zX8TMS0hjj6
 XexTlFLkTuAfeZvFActfNCjF2j1WjjpfMEzIPmxFN077ggJQlMPBCWCOF+2YopWxm5IkE8MoHRU
 br9HAxIXsj5yZJ129WAWYTu9v+K5enr9nN4C1IkhLuWUjGe0/a/FmAR/4989Wacs5o3byEOuIVM
 E5bL/7zYymytHVJnjMxbZ/+mxsMlOkDtauPQ88rPq1IwtQ+x57+LsR7Bw0THSO5TbPUSk/5SCzE
 Jswdyaws
X-Authority-Analysis: v=2.4 cv=XM4wSRhE c=1 sm=1 tr=0 ts=68b9ef64 cx=c_pps
 a=mPoTjFGc+mEQF3C7Fih31Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=rhJc5-LppCAA:10 a=VwQbUJbxAAAA:8 a=OUXY8nFuAAAA:8
 a=20KFwNOVAAAA:8 a=vggBfdFIAAAA:8 a=oGMlB6cnAAAA:8 a=1XWaLZrsAAAA:8
 a=Z4Rwk6OoAAAA:8 a=GwIJR99yofqPgWEKVJsA:9 a=CjuIK1q_8ugA:10
 a=cAcMbU7R10T-QSRYIcO_:22 a=NdAtdrkLVvyUPsUoGJp4:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-ORIG-GUID: 7DVZ_qP71MU3Bmnj2G93bTlGHvHvJR-F
X-Proofpoint-GUID: 7DVZ_qP71MU3Bmnj2G93bTlGHvHvJR-F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509030163

On Aug 25, 2025, at 11:49 AM, Brian Mak <makb@juniper.net> wrote:

> On Aug 21, 2025, at 8:33 PM, Baoquan He <bhe@redhat.com> wrote:
>=20
>> Yeah, this is a good catch and great fix. Without this fix,
>> kexec_file_load syscall will failed and return '-EINVAL' when
>> KEXEC_FILE_NO_CMA is specified just as below code shows. So, for this
>> patch,
>>=20
>> Acked-by: Baoquan He <bhe@redhat.com>
>=20
> Hi Baoquan,
>=20
> Thanks for the ACK!
>=20
>> And, by the way, has the user space kexec-tools got the change merged
>> to allow KEXEC_FILE_NO_CMA specified?
>=20
> I don't see any recent commits to kexec-tools to support
> KEXEC_FILE_NO_CMA.
>=20
>>> From: Brian Mak <makb@juniper.net>
>>> Subject: x86/kexec: carry forward the boot DTB on kexec
>>> Date: Tue, 5 Aug 2025 14:15:27 -0700
>>>=20
>>> Currently, the kexec_file_load syscall on x86 does not support passing =
a
>>> device tree blob to the new kernel.  Some embedded x86 systems use devi=
ce
>>> trees.  On these systems, failing to pass a device tree to the new kern=
el
>>> causes a boot failure.
>>>=20
>>> To add support for this, we copy the behavior of ARM64 and PowerPC and
>>> copy the current boot's device tree blob for use in the new kernel.  We=
 do
>>> this on x86 by passing the device tree blob as a setup_data entry in
>>> accordance with the x86 boot protocol.
>>>=20
>>> This behavior is gated behind the KEXEC_FILE_FORCE_DTB flag.
>>>=20
>>> Link: https://urldefense.com/v3/__https://lkml.kernel.org/r/20250805211=
527.122367-3-makb@juniper.net__;!!NEt6yMaO-gk!EbJyF8xO2E51MyYdN3_zqCBBMj0JK=
oiKoPuG_8vEctQMk9uCyjX0LdSEH_FGkPDV8egxzc7w$
>>> Signed-off-by: Brian Mak <makb@juniper.net>
>>> Cc: Alexander Graf <graf@amazon.com>
>>> Cc: Baoquan He <bhe@redhat.com>
>>> Cc: Borislav Betkov <bp@alien8.de>
>>> Cc: Dave Young <dyoung@redhat.com>
>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Rob Herring <robh@kernel.org>
>>> Cc: Saravana Kannan <saravanak@google.com>
>>> Cc: Thomas Gleinxer <tglx@linutronix.de>
>>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>> ---
>>>=20
>>> arch/x86/kernel/kexec-bzimage64.c |   47 ++++++++++++++++++++++++++--
>>> include/linux/kexec.h             |    5 ++
>>> include/uapi/linux/kexec.h        |    4 ++
>>> kernel/kexec_file.c               |    1
>>> 4 files changed, 53 insertions(+), 4 deletions(-)
>>>=20
>>> --- a/arch/x86/kernel/kexec-bzimage64.c~x86-kexec-carry-forward-the-boo=
t-dtb-on-kexec
>>> +++ a/arch/x86/kernel/kexec-bzimage64.c
>>> @@ -16,6 +16,8 @@
>>> #include <linux/kexec.h>
>>> #include <linux/kernel.h>
>>> #include <linux/mm.h>
>>> +#include <linux/libfdt.h>
>>> +#include <linux/of_fdt.h>
>>> #include <linux/efi.h>
>>> #include <linux/random.h>
>>>=20
>>> @@ -212,6 +214,28 @@ setup_efi_state(struct boot_params *para
>>> }
>>> #endif /* CONFIG_EFI */
>>>=20
>>> +#ifdef CONFIG_OF_FLATTREE
>>> +static void setup_dtb(struct boot_params *params,
>>> +                   unsigned long params_load_addr,
>>> +                   unsigned int dtb_setup_data_offset)
>>> +{
>>> +     struct setup_data *sd =3D (void *)params + dtb_setup_data_offset;
>>> +     unsigned long setup_data_phys, dtb_len;
>>> +
>>> +     dtb_len =3D fdt_totalsize(initial_boot_params);
>>> +     sd->type =3D SETUP_DTB;
>>> +     sd->len =3D dtb_len;
>>> +
>>> +     /* Carry over current boot DTB with setup_data */
>>> +     memcpy(sd->data, initial_boot_params, dtb_len);
>>> +
>>> +     /* Add setup data */
>>> +     setup_data_phys =3D params_load_addr + dtb_setup_data_offset;
>>> +     sd->next =3D params->hdr.setup_data;
>>> +     params->hdr.setup_data =3D setup_data_phys;
>>> +}
>>> +#endif /* CONFIG_OF_FLATTREE */
>>> +
>>> static void
>>> setup_ima_state(const struct kimage *image, struct boot_params *params,
>>>             unsigned long params_load_addr,
>>> @@ -336,6 +360,17 @@ setup_boot_parameters(struct kimage *ima
>>>                     sizeof(struct efi_setup_data);
>>> #endif
>>>=20
>>> +#ifdef CONFIG_OF_FLATTREE
>>> +     if (image->force_dtb && initial_boot_params) {
>>> +             setup_dtb(params, params_load_addr, setup_data_offset);
>>> +             setup_data_offset +=3D sizeof(struct setup_data) +
>>> +                                  fdt_totalsize(initial_boot_params);
>>> +     } else {
>>> +             pr_debug("Not carrying over DTB, force_dtb =3D %d\n",
>>> +                      image->force_dtb);
>>> +     }
>>> +#endif
>>> +
>>>     if (IS_ENABLED(CONFIG_IMA_KEXEC)) {
>>>             /* Setup IMA log buffer state */
>>>             setup_ima_state(image, params, params_load_addr,
>>> @@ -529,6 +564,12 @@ static void *bzImage64_load(struct kimag
>>>                             sizeof(struct setup_data) +
>>>                             RNG_SEED_LENGTH;
>>>=20
>>> +#ifdef CONFIG_OF_FLATTREE
>>> +     if (image->force_dtb && initial_boot_params)
>>> +             kbuf.bufsz +=3D sizeof(struct setup_data) +
>>> +                           fdt_totalsize(initial_boot_params);
>>> +#endif
>>> +
>>>     if (IS_ENABLED(CONFIG_IMA_KEXEC))
>>>             kbuf.bufsz +=3D sizeof(struct setup_data) +
>>>                           sizeof(struct ima_setup_data);
>>> @@ -537,7 +578,7 @@ static void *bzImage64_load(struct kimag
>>>             kbuf.bufsz +=3D sizeof(struct setup_data) +
>>>                           sizeof(struct kho_data);
>>>=20
>>> -     params =3D kzalloc(kbuf.bufsz, GFP_KERNEL);
>>> +     params =3D kvzalloc(kbuf.bufsz, GFP_KERNEL);
>>=20
>> Wondering how big the dtb blob is, can you explain a little bit about
>> the kvzalloc usage here?
>>=20
>> Except of this, I have no other concern about this patch.
>>=20
>> And what's your plan about the user space kexec-tool change?
>=20
> When I tested this earlier on x86, the DTB was allowed to be up to just
> under 64 pages large before the DTB failed to load. This is because it
> has to fit into an early_memremap() mapping (relevant code snippet at
> the bottom). Since the allocation can be many pages, I changed the
> kzalloc to a kvzalloc.
>=20
> For the kexec-tools change, I have a draft change that I've already
> shared on this thread for testing purposes. I believe you said you were
> going to test it, but I haven't heard anything back from that yet. I'll
> raise that change for review properly once this kernel commit is in
> mainline.
>=20
> ---------
>=20
> void __init x86_flattree_get_config(void)
> {
> #ifdef CONFIG_OF_EARLY_FLATTREE
> u32 size, map_len;
> void *dt;
>=20
> if (initial_dtb) {
> map_len =3D max(PAGE_SIZE - (initial_dtb & ~PAGE_MASK), (u64)128);
>=20
> dt =3D early_memremap(initial_dtb, map_len);
> size =3D fdt_totalsize(dt);
> if (map_len < size) {
> early_memunmap(dt, map_len);
> dt =3D early_memremap(initial_dtb, size);
> map_len =3D size;
> }
>=20
> early_init_dt_verify(dt, __pa(dt));
> }
>=20
> unflatten_and_copy_device_tree();
>=20
> if (initial_dtb)
> early_memunmap(dt, map_len);
> #endif
> if (acpi_disabled && of_have_populated_dt())
> x86_init.mpparse.parse_smp_cfg =3D x86_dtb_parse_smp_config;
> }
>=20
> ---------
>=20
> Thanks,
> Brian

Hi Baoquan,

Just wanted to check back on this. Did you have any further concerns? If
not, would you be able to provide an ACK?

Thanks,
Brian



