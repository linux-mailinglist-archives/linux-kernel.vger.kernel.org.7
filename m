Return-Path: <linux-kernel+bounces-742054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63817B0EC7D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2680B1C26A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679C1278753;
	Wed, 23 Jul 2025 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="gK8kl1SR"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023090.outbound.protection.outlook.com [52.101.127.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E489E27814C;
	Wed, 23 Jul 2025 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257406; cv=fail; b=kkpiWMNm3vuOQa1pPzDJe7lKX5ubdkWLoJNOhB42iYCDHsFTlrHMhBDqkZ2KyOxpwzz1F4zbEKv6ywtN2K0wzJbA/9eHzAEzyDCG/JAUl745ZtRgfYQkrpffpb+yVLXKll+fSm72xP/7dbMKEnhZWhucK4ICp3kZl+S1HNi88XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257406; c=relaxed/simple;
	bh=K+kYFy0KgIxtto3fMRMxTWM2otLojquVAxf6F4l1pCk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IKc0+/bEfzkMFsAvc/l/pmWbMgcNwyb8UJyeHHMq+SJzrC0Q7HGeFk4l1Rd/ghLsl5hP4ToBJ/SuB9m47aK5TI1bxDdsIkmHZ3NxX0kJ44pvJ2cHj6EzBruy83e7JhxXlfkqQj7NBj8RBG9SqqDKHI/MPL4w3sroaerGhUeiFls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=gK8kl1SR; arc=fail smtp.client-ip=52.101.127.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfrgJjg36rYswzhw0/xnaVkp8OoKfn2KYtQiN8hguL0HwHj8KPSzhhhOTyf+QVTy+eq+DFqCo3rTyI3RuSMaLTy+dVLQrONjgpXPqWgU7pPKBv2ecIsQtZHXQbCE71KgUdVChYhz89EhWwUgupSCzFWCCFHMBX1pKi1fMH+XL44eh44rei0tLxxIIMhOnCCj0BnTYZ/K6JiYeXHkSZIXAS78LMCyZIl3OgMUGkYE388u4w2dzH1vkyyArHPtJcCtHwVsQIYC6+UfUBV46ZihGZEOwpuBPyT7tLxie9xvtnABHpklu68aJNwlpqklvqwreJZScrnmmJ1U3fp5nkQ46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0zvcPVgo+2fOBzfabx0n956537MpCTydj0jg4qP7tw=;
 b=hRMmN4pGX1QGylTMh7KiStIcCtKr2+tgg6tIwnVGyz/4lzWVS61J3LlpgzCLRN7G+ioWOMR1E0Rs9iHr2eWBqXLxQgngjDxTU+w6htexH/LqYAx8YtIu4ZSDgrcO4SfnA3uU0BoP3rBH9RA71EsMJrZJk4jpfjVi+rX6BvBB4jkiV/TCN8LCEj2tCFQ4T3rWMI55HwZZfKSL9/EyeUYiJjLugl0FCdriYbcSu0HW/GBgjXxIJ4nW+lhB7UMRj7m5v9qiXlcfM2ra0GpfNjAIb00lAza5Knrf7y0sK0blXBqwjujpCuwvI1SHGVwrKEOR17/eIctsnpXOk7L2IfvPYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0zvcPVgo+2fOBzfabx0n956537MpCTydj0jg4qP7tw=;
 b=gK8kl1SRrUFAfn9Tb+diaue3HFED+yDE7N9WrCCOsJWt/ReXlNrUcspn+ILCGt+SccTGEzrcOLq0GJmd+hw6HQJgY8LjUvbsyFpic/uLmEIlJyIgoMoy3d/F2xIW0AmsHModWSZk76mDs95I9OhEWW1nBpn6rvTZ5iP9Hz3cx5+JUhWCI4S+9OItG+EObIzKcAfpAV92OWKR5CH7Xcn8RU7ohUObponiZdsrUIu5pCE3iykgE//rrN+n9mbXZFao0muKgwZArPtii1SzZATEjFjW21ECSMY83gmQdOpss20ZllizxDK8DzICeZmm7N+DY4VdfCcDpYnwHAS3ObTeaw==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TYPPR06MB8020.apcprd06.prod.outlook.com (2603:1096:405:316::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 07:56:37 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 07:56:37 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Rob Herring <robh@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Kevin Chen
	<kevin_chen@aspeedtech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v3 1/2] dt-bindings: interrupt-controller: aspeed: Add
 parent node compatibles and refine documentation
Thread-Topic: [PATCH v3 1/2] dt-bindings: interrupt-controller: aspeed: Add
 parent node compatibles and refine documentation
Thread-Index: AQHb+u5GGJR1Lh1PR0C5h6er79qfsbQ/J8sAgAAvhtA=
Date: Wed, 23 Jul 2025 07:56:37 +0000
Message-ID:
 <OS8PR06MB7541F7F2775C3BF46C97957BF25FA@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250722095156.1672873-1-ryan_chen@aspeedtech.com>
 <20250722095156.1672873-2-ryan_chen@aspeedtech.com>
 <20250723050120.GA1231854-robh@kernel.org>
In-Reply-To: <20250723050120.GA1231854-robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TYPPR06MB8020:EE_
x-ms-office365-filtering-correlation-id: 15e6a5e5-df5b-426c-691e-08ddc9be7387
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oi1jvt7AIYNzWisCYq/eNxTCtJ7ZaBfQIM4+2K5bmhLjbEMAbzHK+7nGDjb9?=
 =?us-ascii?Q?NBq0I40XfpB5uSHY1QpIxSegLFraLxaTUt4PMpmn++hpPmPGEluXszFtnAaY?=
 =?us-ascii?Q?z6oZXKOBZkzC8VRFYIM8oNEoe9jBIovxHFWU+i/Ga92q0KZgXtfNqYdxoQVU?=
 =?us-ascii?Q?VqvB693B/9Fd9hXNrpfnJNHRA7CFwkEbUHOmBwkBamm/bJPH9UXyOVYLMlOd?=
 =?us-ascii?Q?0g08lYDBkQ4VON2ZuxdOhWfKUE113KaNbR53Q4TmRkSaEQeAMl/G/JLYIcmK?=
 =?us-ascii?Q?NoaSzRksgVnOkb4EdSHdH/00kFFQETB8NqJqO0qZdHpjR9mZrKpLvzgZUgQ/?=
 =?us-ascii?Q?PjEiDj7LYyOYtXofTmDifcytiFxaIVMMAQxMgDkg94F7cnMSyU/kbRa6/q2r?=
 =?us-ascii?Q?skPSMqRViqWXS8oKsAu2ZdQsh2rY6LgnH8Xg3QXRQrb8sKF/ysIj5xNUuAR+?=
 =?us-ascii?Q?CnXEAuwUbGyHnTCY6Bragt9gsF7qoE9ClZHbjPKYQn2F1lJq0tzZnZUYG3DY?=
 =?us-ascii?Q?3PuoHQtpaNankWJlOZ2cv19oPB0CTOB2hHgqRmM89wh5xTAKCLdCcgfACLKQ?=
 =?us-ascii?Q?AWB1NCYyAGwjdFmhtdlPxvUcqK6Fp57i+exGZDQxh1dCLbyNbiYSNbOSFcz4?=
 =?us-ascii?Q?b1yQqMWBW5VvOPK1XJwbzKIGWA4aj+j0ddktSRzojjlgeiFcp9dHYhW3eSv3?=
 =?us-ascii?Q?kkANsj01DpkDYpYbjQzWORbk4PQBw1RbLT0C4bvRg6gQ7perCl6PnWhBQVLN?=
 =?us-ascii?Q?BmXZTapogLJ1kqAeE+HbFb8egg1u+oUWN5+e3e/JmZNuYzkORV9ZxBSw3Hnq?=
 =?us-ascii?Q?yXiA3zm+Iuiys+uCgZnClNnFeBPYS4Z+ZfFNdqrB6XrJl0sx0AkOi6cN31iY?=
 =?us-ascii?Q?cfLrIHygtmbeNAAyUr8MAaSV3vqLrvT3vLALwgx7ksEu+RYEb4R9EKwRIwKb?=
 =?us-ascii?Q?oJ10JDP6DWLxrjaOdwXc1USOGsvvzyMEDjg3GoO4b+hYXGCxh4XUybg3Ng6D?=
 =?us-ascii?Q?EPWxXyCjVSxVFxaX8TbjtDqQ92SSwQXZ4DM1arCtc5U1QTJKgH3RLMG491qG?=
 =?us-ascii?Q?PaVctasYQGZ3mXG4ILBnBMFmdz1SXcdqfFH8SvLKI6YUdRklVmdZxDd4//xA?=
 =?us-ascii?Q?1ZlofxYTBrl8D/ojP4q/C1iqKTX18y4NZgcSMEl0j/fgfN/zLPOriXmkpiG5?=
 =?us-ascii?Q?Z+sWXZxZ0f3pvkTFlfTZ2IJOmJs02x1hNWNAAvl4A/zWl1FLALKAQiIV0JTQ?=
 =?us-ascii?Q?lusGCEx7CixEB5IdSubImyJ4kWlYsleaXOYUEe81SQ9+bRKLQs2UzcFZ42Xt?=
 =?us-ascii?Q?ZLHZoA/gDvg3RgGkq+Fjb2+zhQ5fCt2pyKzBFmZ5sSiL2G2FLiw+bo+/CbSl?=
 =?us-ascii?Q?Z+0YdrNAZftLLuW2ht8Rv4U+NkoDDkHEzp/UXlWB2pAsCgbt/sT2h8erf6kd?=
 =?us-ascii?Q?SJ2sVjMCrcQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hbcC9dskq5cHZlQymyPYT5/w5CgjiIbh1P7TuFlLvVrzjBZR0KDl045uamYK?=
 =?us-ascii?Q?CkeW/deh9jgwNchkvYtN1+euQ+HNntoQgEFzhLIs1wxvqAtD22uiqnh4glRB?=
 =?us-ascii?Q?P9gfQKS3Sey3OFKVP7kWBMIuPu5V6XjWyRKRg/1/gMXzrP565ZN9q8xrf9I0?=
 =?us-ascii?Q?XNHFZb6HGuUT0MZhZ02c1A53mwJIMe1T7EXKW8qA5EdFuY6ue68L3t6zCVjt?=
 =?us-ascii?Q?GUxlmQITPVYJ+0Vhr9TAvyB42hIeupyT9jUCftPdGLrSDprfeA2Ee5ES3aVK?=
 =?us-ascii?Q?0S/sONCZ8EAbaCVbc9pXfqbVzA2Tw73RhtB+ynKepD5vq2eyH9p6wUsEnk4b?=
 =?us-ascii?Q?R6CMHRL4ClpQHNHJrjQ7EjZMlhy8zdQQko5rbuBcFi/P5bW1poNpW2eanaj1?=
 =?us-ascii?Q?iVlXIvhy+UbMWMFgIjDEjauSeKrnC7NomIjhKQpH9BImIrZ64xz/qcmENt6Y?=
 =?us-ascii?Q?aSgpZkSG48xZSX+HblW/mzqY/swqgnxyHyb1buCGF46BHry1nV+6+eIHcxCq?=
 =?us-ascii?Q?IUWIco8n2gZbXLlR6ufKwB+sN6M7oiMsUuZJTEJLEp7SnlNKK/IzneLaXOMF?=
 =?us-ascii?Q?TwMpkeSclJ20qc3Z41+KfLrdlh5njsgaHScWmffpDy7/hp4ql5MfQX0YsYSZ?=
 =?us-ascii?Q?46mbHnGccjNVkhLlXM0+Nt5ZVucnEAxiEA7v7i45kCoKyIhD+2UUgsII9/eA?=
 =?us-ascii?Q?bdI0KxR6VjSkLTWrPAJ7NthXLQcT7aPTH6I7N7h/0bZ9EXoAayqxloyp3Nd/?=
 =?us-ascii?Q?5xfenLruU9a5WRVGWnk2AynnXMndS72lpCicTd8ILXowhkGC0dqMd9AuwwcX?=
 =?us-ascii?Q?nR9BiKuQ5Bc7MOQfKrjYKVqC8gZKwXe0K+Z5ZJGavD2F86BdklGEwBeksBlw?=
 =?us-ascii?Q?yaUk8EJ84izsDOQgG14ZKiWCc4kic29/xAa4ee6q8g+vafBzIAPnZsJ54nrC?=
 =?us-ascii?Q?x+QIFAo5rkgpUAivqMgDNlpxvIOOdhN0iHy2vmrgn/We9EXUJ4hi2Ysi6aYU?=
 =?us-ascii?Q?RTSofT1Avi6pw13agvow5V3Ju6xonslKbe6r+REmVWZSwZ1YlkQqD+d5lokI?=
 =?us-ascii?Q?O5la719qX8X8jvOKjLmfNQiqboSuMddJ6zfHINaL4XYrO3ga91/KnzQdii11?=
 =?us-ascii?Q?g2k9crHiGpScM5FmtIIwzJhlv/V+xBSYYpWP3CUXGZBchVuipCp0ZgG8Qtu1?=
 =?us-ascii?Q?BHA90p5bInOYNh6PpVUqjT6xEmX3pwKKj/APrH7i6+cSynJ2ZvBWJUQG1sbd?=
 =?us-ascii?Q?/4gWhCyVATYvp/xEhGIPbgMk0SK4/PYv4nrJZG2IuK5GLUwGYizp8vMV7RJX?=
 =?us-ascii?Q?AWZigysT8r5hp3IJc31MKxoTdbcUklSDR4JAumAut/LvN8Oml9nne3W1HDkm?=
 =?us-ascii?Q?z8NsK+PUZqcjive27YezHOpbr5MQAhYcXk1GjJwS6aMvV060yAB2/KM+DUnc?=
 =?us-ascii?Q?bkXUaSZrIUEyRbh8v0XdL273yzPO9F3d4LQamJvwuxJayU+SC6OGjh1qIomQ?=
 =?us-ascii?Q?4eVCqJPrbnRqRNAxY3BVvkZegF8sXE9WK2Pe3tT7b/mhlqiJmSO8bWFG+rzC?=
 =?us-ascii?Q?Gt7ovVScLp0R+alhL6199vVBcUsDdBjKcK3y/EAg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e6a5e5-df5b-426c-691e-08ddc9be7387
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 07:56:37.5202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZyInrYg0XcSFw2ThoKuXHnugPutOTZeACEBqIXRf1cmyWokViwH08/6NoK/P5M2d4qKnQ1NFqk2JvN14dAIlOFMg0+eLI39Ef7YsgQvu71k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB8020

> Subject: Re: [PATCH v3 1/2] dt-bindings: interrupt-controller: aspeed: Ad=
d
> parent node compatibles and refine documentation
>=20
> On Tue, Jul 22, 2025 at 05:51:55PM +0800, Ryan Chen wrote:
> > The AST2700 SoC contains two independent top-level interrupt
> > controllers
> > (INTC0 and INTC1), each responsible for handling different peripheral
> > groups and occupying separate register spaces. Above them, PSP(CA35)
> > GIC controller acts as the root interrupt aggregator. Accurately
> > describing this hierarchical hardware structure in the device tree
> > requires distinct compatible strings for the parent nodes of INTC0 and =
INTC1.
> >
> > - Adds 'aspeed,ast2700-intc0' and 'aspeed,ast2700-intc1' compatible
> > strings for parent interrupt controller nodes. (in addition to the
> > existing 'aspeed,ast2700-intc-ic' for child nodes)
> > - Clarifies the relationship and function of INTC0 parent
> >  (intc0_0~x: child), INTC1 parent (intc1_0~x: child), and the GIC  in
> > the documentation.
> > - Updates block diagrams and device tree examples to illustrate  the
> > hierarchy and compatible usage.
> > - Refines documentation and example formatting.
> >
> > This change allows the device tree and driver to distinguish between
> > parent (top-level) and child (group) interrupt controller nodes,
> > enabling more precise driver matching SOC register space allocation.
>=20
> That's nice, but is an ABI break.

Sorry, Is it an ABI break?
I keep the compatible aspeed,ast2700-intc-ic, not change it.
Just move it to be child, and make aspeed,ast2700-intc0/1 to be parent for =
aspeed,ast2700-intc-ic.

Older : https://github.com/torvalds/linux/blob/master/Documentation/devicet=
ree/bindings/interrupt-controller/aspeed%2Cast2700-intc.yaml#L70C2-L86C7
     bus {
        #address-cells =3D <2>;
        #size-cells =3D <2>;

        interrupt-controller@12101b00 {
            compatible =3D "aspeed,ast2700-intc-ic";
            reg =3D <0 0x12101b00 0 0x10>;
            #interrupt-cells =3D <2>;
            interrupt-controller;
            interrupts =3D <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
                         <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
                         <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
                         <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
                         <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
        };
    };=20

New parent and child
    bus {
      #address-cells =3D <2>;
      #size-cells =3D <2>;

      intc0: interrupt-controller@12100000 {
        compatible =3D "aspeed,ast2700-intc0";
        reg =3D <0 0x12100000 0 0x4000>;
        ranges =3D <0x0 0x0 0x0 0x12100000 0x0 0x4000>;
        #address-cells =3D <2>;
        #size-cells =3D <2>;

        intc0_11: interrupt-controller@1b00 {
          compatible =3D "aspeed,ast2700-intc-ic";
          reg =3D <0 0x12101b00 0 0x10>;
          #interrupt-cells =3D <2>;
          interrupt-controller;
          interrupts =3D <GIC_SPI 192 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LE=
VEL_HIGH)>,
                       <GIC_SPI 193 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVE=
L_HIGH)>,
                       <GIC_SPI 194 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVE=
L_HIGH)>,
                       <GIC_SPI 195 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVE=
L_HIGH)>,
                       <GIC_SPI 196 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVE=
L_HIGH)>,
                       <GIC_SPI 197 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVE=
L_HIGH)>;
        };
      };

      intc1: interrupt-controller@14c18000 {
        compatible =3D "aspeed,ast2700-intc1";
        reg =3D <0 0x14c18000 0 0x400>;
        ranges =3D <0x0 0x0 0x0 0x14c18000 0x0 0x400>;
        #address-cells =3D <2>;
        #size-cells =3D <2>;

        intc1_0: interrupt-controller@100 {
          compatible =3D "aspeed,ast2700-intc-ic";
          reg =3D <0x0 0x100 0x0 0x10>;
          #interrupt-cells =3D <2>;
          interrupt-controller;
          interrupts-extended =3D <&intc0_11 0 (GIC_CPU_MASK_SIMPLE(4) | IR=
Q_TYPE_LEVEL_HIGH)>;
        };
      };
    };

>=20
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > ---
> >  .../aspeed,ast2700-intc.yaml                  | 158
> +++++++++++++-----
> >  1 file changed, 115 insertions(+), 43 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast270
> > 0-intc.yaml
> > b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast270
> > 0-intc.yaml index 55636d06a674..bdc4d8835843 100644
> > ---
> > a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast270
> > 0-intc.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,as
> > +++ t2700-intc.yaml
> > @@ -10,6 +10,33 @@ description:
> >    This interrupt controller hardware is second level interrupt control=
ler
> that
> >    is hooked to a parent interrupt controller. It's useful to combine m=
ultiple
> >    interrupt sources into 1 interrupt to parent interrupt controller.
> > +  Depend to which INTC0 or INTC1 used.
> > +  INTC0 and INTC1 are two kinds of interrupt controller with enable
> > + and raw  status registers for use.
> > +  INTC0 is used to assert GIC if interrupt in INTC1 asserted.
> > +  INTC1 is used to assert INTC0 if interrupt of modules asserted.
> > +  +-----+   +---------+
> > +  | GIC |---|  INTC0  |
> > +  +-----+   +---------+
> > +            +---------+
> > +            |         |---module0
> > +            | INTC0_0 |---module1
> > +            |         |---...
> > +            +---------+---module31
> > +            |---....  |
> > +            +---------+
> > +            |         |     +---------+
> > +            | INTC0_11| +---| INTC1   |
> > +            |         |     +---------+
> > +            +---------+     +---------+---module0
> > +                            | INTC1_0 |---module1
> > +                            |         |---...
> > +                            +---------+---module31
> > +                            ...
> > +                            +---------+---module0
> > +                            | INTC1_5 |---module1
> > +                            |         |---...
> > +                            +---------+---module31
> >
> >  maintainers:
> >    - Kevin Chen <kevin_chen@aspeedtech.com> @@ -17,49 +44,70 @@
> > maintainers:
> >  properties:
> >    compatible:
> >      enum:
> > -      - aspeed,ast2700-intc-ic
> > +      - aspeed,ast2700-intc0
> > +      - aspeed,ast2700-intc1
> >
> >    reg:
> >      maxItems: 1
> >
> > -  interrupt-controller: true
> > +  '#address-cells':
> > +    const: 2
> >
> > -  '#interrupt-cells':
> > +  '#size-cells':
> >      const: 2
> > -    description:
> > -      The first cell is the IRQ number, the second cell is the trigger
> > -      type as defined in interrupt.txt in this directory.
> > -
> > -  interrupts:
> > -    maxItems: 6
> > -    description: |
> > -      Depend to which INTC0 or INTC1 used.
> > -      INTC0 and INTC1 are two kinds of interrupt controller with enabl=
e
> and raw
> > -      status registers for use.
> > -      INTC0 is used to assert GIC if interrupt in INTC1 asserted.
> > -      INTC1 is used to assert INTC0 if interrupt of modules asserted.
> > -      +-----+   +-------+     +---------+---module0
> > -      | GIC |---| INTC0 |--+--| INTC1_0 |---module2
> > -      |     |   |       |  |  |         |---...
> > -      +-----+   +-------+  |  +---------+---module31
> > -                           |
> > -                           |   +---------+---module0
> > -                           +---| INTC1_1 |---module2
> > -                           |   |         |---...
> > -                           |   +---------+---module31
> > -                          ...
> > -                           |   +---------+---module0
> > -                           +---| INTC1_5 |---module2
> > -                               |         |---...
> > -                               +---------+---module31
> >
> > +  ranges: true
> > +
> > +patternProperties:
> > +  "^interrupt-controller@":
> > +    type: object
> > +    description: Interrupt group child nodes
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      compatible:
> > +        enum:
> > +          - aspeed,ast2700-intc-ic
> > +
> > +      reg:
> > +        maxItems: 1
> > +
> > +      interrupt-controller: true
> > +
> > +      '#interrupt-cells':
> > +        const: 2
> > +        description: |
>=20
> Don't need '|'.
>=20
> > +          The first cell is the IRQ number, the second cell is the tri=
gger
> > +          type as defined in interrupt.txt in this directory.
>=20
> Don't add links to legacy documents.
>=20
> > +
> > +      interrupts:
> > +        minItems: 1
> > +        maxItems: 6
> > +        description: |
> > +          The interrupts provided by this interrupt controller.
> > +
> > +      interrupts-extended:
>=20
> Why do you have both interrupts and interrupts-extended? They are mutuall=
y
> exclusive and both are auto-magically supported. The schemas only have to
> document 'interrupts'.
>=20
> > +        minItems: 1
> > +        maxItems: 6
> > +        description: |
> > +          This property is required when defining a cascaded interrupt
> controller
> > +          that is connected under another interrupt controller. It spe=
cifies
> the
> > +          parent interrupt(s) in the upstream controller to which this
> controller
> > +          is connected.
> > +
> > +    oneOf:
> > +      - required: [interrupts]
> > +      - required: [interrupts-extended]
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - interrupt-controller
> > +      - '#interrupt-cells'
> >
> >  required:
> >    - compatible
> >    - reg
> > -  - interrupt-controller
> > -  - '#interrupt-cells'
> > -  - interrupts
> >
> >  additionalProperties: false
> >
> > @@ -68,19 +116,43 @@ examples:
> >      #include <dt-bindings/interrupt-controller/arm-gic.h>
> >
> >      bus {
> > +      #address-cells =3D <2>;
> > +      #size-cells =3D <2>;
> > +
> > +      intc0: interrupt-controller@12100000 {
>=20
> This node isn't an interrupt-controller.
>=20
> > +        compatible =3D "aspeed,ast2700-intc0";
> > +        reg =3D <0 0x12100000 0 0x4000>;
> > +        ranges =3D <0x0 0x0 0x0 0x12100000 0x0 0x4000>;
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +
> > +        intc0_11: interrupt-controller@1b00 {
> > +          compatible =3D "aspeed,ast2700-intc-ic";
> > +          reg =3D <0 0x12101b00 0 0x10>;
> > +          #interrupt-cells =3D <2>;
> > +          interrupt-controller;
> > +          interrupts =3D <GIC_SPI 192 (GIC_CPU_MASK_SIMPLE(4) |
> IRQ_TYPE_LEVEL_HIGH)>,
> > +                       <GIC_SPI 193 (GIC_CPU_MASK_SIMPLE(4) |
> IRQ_TYPE_LEVEL_HIGH)>,
> > +                       <GIC_SPI 194 (GIC_CPU_MASK_SIMPLE(4) |
> IRQ_TYPE_LEVEL_HIGH)>,
> > +                       <GIC_SPI 195 (GIC_CPU_MASK_SIMPLE(4) |
> IRQ_TYPE_LEVEL_HIGH)>,
> > +                       <GIC_SPI 196 (GIC_CPU_MASK_SIMPLE(4) |
> IRQ_TYPE_LEVEL_HIGH)>,
> > +                       <GIC_SPI 197 (GIC_CPU_MASK_SIMPLE(4) |
> IRQ_TYPE_LEVEL_HIGH)>;
> > +        };
> > +      };
> > +
> > +      intc1: interrupt-controller@14c18000 {
> > +        compatible =3D "aspeed,ast2700-intc1";
> > +        reg =3D <0 0x14c18000 0 0x400>;
> > +        ranges =3D <0x0 0x0 0x0 0x14c18000 0x0 0x400>;
> >          #address-cells =3D <2>;
> >          #size-cells =3D <2>;
> >
> > -        interrupt-controller@12101b00 {
> > -            compatible =3D "aspeed,ast2700-intc-ic";
> > -            reg =3D <0 0x12101b00 0 0x10>;
> > -            #interrupt-cells =3D <2>;
> > -            interrupt-controller;
> > -            interrupts =3D <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> > -                         <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
> > -                         <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
> > -                         <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
> > -                         <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
> > -                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
> > +        intc1_0: interrupt-controller@100 {
> > +          compatible =3D "aspeed,ast2700-intc-ic";
> > +          reg =3D <0x0 0x100 0x0 0x10>;
> > +          #interrupt-cells =3D <2>;
> > +          interrupt-controller;
> > +          interrupts-extended =3D <&intc0_11 0
> (GIC_CPU_MASK_SIMPLE(4)
> > + | IRQ_TYPE_LEVEL_HIGH)>;
> >          };
> > +      };
> >      };
> > --
> > 2.34.1
> >

