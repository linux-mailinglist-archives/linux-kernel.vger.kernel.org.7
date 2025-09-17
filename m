Return-Path: <linux-kernel+bounces-821039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DA8B8029C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B493A1705F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EC42F5305;
	Wed, 17 Sep 2025 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iaZUPpCh"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011026.outbound.protection.outlook.com [52.101.65.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB6D2DC354
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120181; cv=fail; b=Qi05ES/Wv8b/EROQcZaEb4f/9cEbfl0OeUr2u9J9PRuls0/rvdDkr20sx/z9DL5BBWs6TLVjaKFZKtUSTbdK9OS5+TRb+J/lS+/i3qQgps+7f/EeOCVvc3m3YAbH8aRHrfMU92ahcO+mnAma4dsG/1nUG/Fdfajcx3gan6DJp8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120181; c=relaxed/simple;
	bh=SjFX01fCHAwaOgZu1TWF4EVb3pDl4K4IrowN0y7vxcg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rMb/0Sb/6vKHRNLYCEpB1BoU1qFvqAIpqoYA+XqxO+1BiIBTLEIlOYYGHvKwBD2PBkSkApG+y72O0Hg0vdIgjTy7IOUAul34e+Q3Pe11g5VDAvYIHOBL/d2l2GCj6H5Xm4XmtirTl7Q+dASEkyS/eQYt6VHxr/XQfxvfPzQbukg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iaZUPpCh; arc=fail smtp.client-ip=52.101.65.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wApgvrALZEODiaevAPgOdE0Qsyfq9CYLZUdPJnOQx/ETCS8USe9oadzfl+1Cy4E59bNGR7gmBkpMsWh6m4sLwbv0bghduXVHOZXfxOzVBpzFLrXYu9KF7NgH4o+C8eCzBH8Zl2Hx4YqhBU5fFnFKOzDfx4b7rjHzv9ygUMuWF2AoVwM0PGPYviQT0aQ8Xf2rV13Tmi7ShkSs5T1xfKh2oH4igafdhWYe5BSbIFCun6FUutlUJRgwAVoBmc2koatQVZh8HJeI0W1+p2MTNS4fV7IAvQGzvyL+s7I42O7kkfmKKGO8zsmxZDHwZr/OTo7ZudFPkwrpRnJd7zrfA0r/Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/dXsaI2fkLR9ZplizLeFjCpOcZJjlUNP5p7FDOa2g4=;
 b=hIpdSoTlzprkxiGrIIkyT2wnOUgxCMjlXAu2Rvw5UvEmN6cN6T19ex+JXS01dsfodiM2bEjXtn2pnDm4/6dgBirtg4x68KwEZ6j8C6Un9nq9ejgdv6+TYvlpkF5LlQNEVeILRHRZbIPpyYjNUku/NMZkGT8HexUwSNX8xHwBnbY0/0PGupCGjp3QUkBtWsk0vMpX1rkQ+IYjwWPkSt2YWvbTU8F8IOXmLZwDNpQvMBoKDL0KJi9iRdRYLQBm0b2xb4S+bil9C7o34f8GSuOgZnc8P0OcCeEOK1C0eNyLw8h++rM6Fo5OYFMDdU6yR/R96Pk4TnA0hv+FhZuwOY+rwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/dXsaI2fkLR9ZplizLeFjCpOcZJjlUNP5p7FDOa2g4=;
 b=iaZUPpChFp/BarbwhQ+904SyOJMJWRvfnaQibm7zHds+ZC+BwM9+Y6fQ+sHvIEho43Ggij1Ou7U73/HMybQPEvt1FEfJVxLDURVkkIKN+6yOpWRqonwkrXadoEwOP0S/db7ZRa17H1KnVGtmUY0rBS9gAaabGvbj9MQaCkKzK8FkvsvbM0wO77aikwojLZ7wbmbEGQRSPBCEsP0yHBKudaXFGWM0KlDOH/ooCUQZzzixs1wl82jFZGcCKJDaPrzilGQL+SWAtBb62ExvStebNMuoFTTWN1dG/DK7mNUfj1iB8BW57mc/E+Su52CiVKHjCTG/zpDo7L8P2Vw1kL5nZw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AMDPR04MB11651.eurprd04.prod.outlook.com (2603:10a6:20b:71c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 14:42:56 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 14:42:56 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mailbox@lists.linux.dev" <mailbox@lists.linux.dev>
Subject: RE: [PATCH] MAINTAINERS: Add mailing list for mailbox
Thread-Topic: [PATCH] MAINTAINERS: Add mailing list for mailbox
Thread-Index: AQHbqRdZjeYIsfEs9UCRSSO+lwEZE7SYcD7A
Date: Wed, 17 Sep 2025 14:42:56 +0000
Message-ID:
 <PAXPR04MB8459D9A3BEB0E677E83A7DD98817A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250409061813.3209600-1-peng.fan@oss.nxp.com>
In-Reply-To: <20250409061813.3209600-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AMDPR04MB11651:EE_
x-ms-office365-filtering-correlation-id: 47b71981-2ce8-4daa-31a3-08ddf5f87da2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oP+HKhKKJoTbQyi2HGDfy7Px5uPOqcmI0g0WEMjfp7VVSY1l7TnpaWF+fqBH?=
 =?us-ascii?Q?ygaqKJC79q3nEUTRZx78l2SfSoUOLsHHBS8bBERkR/4kQdmU7RYfH5yyTdeI?=
 =?us-ascii?Q?k/N7lkHED4iYrELkoWJ6r5qx8NzsM1MWhGf18XSFe07glaLKhPd17iw0qVOy?=
 =?us-ascii?Q?dcgaSTqRk0LrhPqe2gswHjfERuFuTdU6tbXYRkwz4UmYb4lRVXjO+J8DbrJ1?=
 =?us-ascii?Q?7lH+pKnF1jxl9t4Y8iXirfdCITZEWv92K3l9XuZbGj3zbabExq4iGWARW2Ac?=
 =?us-ascii?Q?DsuAVzJuwiOcbMNsOCpknoyyQ+YVlksXRh7RuoGBqET+VmLSJi7UkHP8SP47?=
 =?us-ascii?Q?PBHJN7//E3BxLMgwYAL+6hBnOHg1OIaj4AcSxUqpuHZiLfA8S4aqpCwJ6SZk?=
 =?us-ascii?Q?NQ6JWhOtHlXuj3GuRKyZKThR95aoSwlPQ2DzjBdAVPTtK1yRchdNMS2I36gj?=
 =?us-ascii?Q?3izzKfn75IpO+xkyqOAIadJE/dwsAB9ypJQWGyOuU4dWhfRGjUPrHrajePvK?=
 =?us-ascii?Q?TtTXRFr5I7tzwHx425ZujIblqJfxJFSueTOvJMP8LGu8Wd87VHYhi841AYsz?=
 =?us-ascii?Q?EJsW6D4dBAd1E5BAsp52/l5IKK+hF7wj3GlY8ONyWGZdpJUzVoCR9pS8J6BD?=
 =?us-ascii?Q?TOv43pBfDNischr7inTrXI6awk+OHfBZI3ni1r4yu22IBF2A/36OVP0ad/HL?=
 =?us-ascii?Q?n7JzWJLJIvdUyiqgbgWna0YBgZSVvJdTPTqM5z7+wCjQX343d7cJqafKheWC?=
 =?us-ascii?Q?eSsvbdJqU7QVhjlhdwd/mlPYiJyL3Pf2b8VwAgGUsyACdjdu/w2dyeoDnfHE?=
 =?us-ascii?Q?EKf2LyQo34CxoFCYuogpOLrSKaDbg8KM9QCGdD5qtDTx/0LwqtRMk9qAcyOX?=
 =?us-ascii?Q?hodKYGdJ4au0Mn70JEuYv6SRLlJSPcwkA8eQSxBEOnlDvwEOIOAz+fx6ZZbt?=
 =?us-ascii?Q?SaWdd4Dm4C/bU+9WUpNP1ofhMegjjuPj2N9aAuMeW5OFcLLU/XltPV5CxtZt?=
 =?us-ascii?Q?8qUgZgKRkTyfRqM4Urswsx8rjvDI7he/eFP86qFO+v2WkXoTDsxYKzdTXUrF?=
 =?us-ascii?Q?Y3dyWa1g6/B6QXAL8oOCUbsbq5WiTPu0N5TCZTXrWMuHpQYEKlPFWoqfviC5?=
 =?us-ascii?Q?arNK70QqQeMoJ6/v+rqUHssHc4GxBfuUJL2KtsVQXVQhtvW5Zr0nTbdXpI7a?=
 =?us-ascii?Q?8w1tGIjh7S87Qeg4fzVMSFvlpOU4scKrkqQ90Ul0E5hlx/EeeZId/Xxi2G9m?=
 =?us-ascii?Q?pc8VSDcSBzSdR2QMdvKKVs0StTwoGWutHqjd3TN0H0h1brEqNshlX1Qqfbts?=
 =?us-ascii?Q?SdBrqFZPtPzkjNaWunyqwl/LOQ1uSta0oZe2Uhoj8MIXcCHvIBEB+PGQDkfh?=
 =?us-ascii?Q?7I6H9eTmtAd0bJdL6EyoGip+SauHKRCsUoH4o2GAGg+jYxjjBYhjYDDf6z3Q?=
 =?us-ascii?Q?Ri9WePynLlM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pMCJjgpO96XSPzbvtOi06k3FWYkljmE5BY/cfhcLQ2DBGwkwsh4X49WP6Z4R?=
 =?us-ascii?Q?s3E5Cr9sH7zLWfsFQNB3bVnL2Dm6qedji/3AuHMvAuOca7CYbM4VD/U49NnI?=
 =?us-ascii?Q?IjlAKkqjOMY21RFAE8GqtvWXkPHVCiMrMSDz88bTYI4XTzMLpRMz+qvHxJfy?=
 =?us-ascii?Q?1rP3/VQN1Q7+ICqtehb/7CcHL/2PoUSur1XVNBM5J7aNqy4AfW8fTXk2cYNM?=
 =?us-ascii?Q?nPU2w0T4xPyKqgI23Mcn3tfCDn7j6oXnoby3kZ283n1pQcBsEflCizCIW/Pw?=
 =?us-ascii?Q?Q04/9uswlKd2XGjnq90E+hgwltWptKtfdjGzbmpNkl1+L92GxKDG1K4FKaSl?=
 =?us-ascii?Q?CbZxRLFu7jRB5R+VzgsX8o+ICs5U7Nl90aDwmLqszANA9/oMmT5zDT4+UXw1?=
 =?us-ascii?Q?lxfEMqwvlB5JZhMBOhiD+UJHQgvL/AW63wMNvCJJhnjO+2dHtGg4FZiWia/v?=
 =?us-ascii?Q?OWg2+npvEWsScNr4Qa5JaEMjQIduOZDC6DJDGSgEoiE1kD/SW3Y3Be8ej3YF?=
 =?us-ascii?Q?p553dH5xzebfh8KAv+9TUUhryRTEglTXDzH6zRb6gqh+sq87ecfptzK5DIu9?=
 =?us-ascii?Q?jj7VzScNg22/pwQ43XvrwNncHz1iSXv0gWDQTvwjoKmkcx1A0sO/irpgLZdr?=
 =?us-ascii?Q?sVBzlbju+Vu7YTw7/4C1Qqd2LuLs66AesTcYbTehqDeAv5b0z5SKarPMfy6f?=
 =?us-ascii?Q?IzJQrLcsV2C0h5VJVPaXnP9ZjkzBHThWfOUIyR6l8xDjatvQp4RwVv0huD4B?=
 =?us-ascii?Q?LyQhsRecguHD67GoWdKAG7OtQLVMSjy4SQpsLTod/drTvIBfalio68jbmJr+?=
 =?us-ascii?Q?yUyHzf7oHEpzrvCeP+cDl7sqbbE7ctVkxrtuMG0DnyGHBk12ZImcLQazLFKM?=
 =?us-ascii?Q?2LNVJf2QcL0azuCxPWOHcA2cKlnxm8clpUPyfPUIAhuRDKNDQdOLz4vkdsmd?=
 =?us-ascii?Q?Zr1Dt+nQ2c34H0rBKSCx+/TFhl/YkwOUTTI5NfVNjo6es0yLrBHcJ86gBQFm?=
 =?us-ascii?Q?cgFcTAuaC5aJ+2zovFHdMCA6oLCn1R2RafdNX91VIrCuTajMAwJ9scw69k1k?=
 =?us-ascii?Q?odufR0LREmYJoLgMkF6sYxJYst/gP96tJJIWx5bQdhRomtZb27nuMjhrwfBt?=
 =?us-ascii?Q?dgbdJUmvhMHzshZoqsTtUPdqwpDIx9WtwxZ8hg00NomFEqLhpEo++mxEJVGT?=
 =?us-ascii?Q?hIVyLciOqNSdUvNV9ysLqJ6DtWq841L+b00SS3MwyTf5bl131oTwkU7v36aA?=
 =?us-ascii?Q?psfHfcGs+op+o4q7XUNiqcHWcnM90EAyOxw8SK4ks5jZFnq1QcqqGsy/kHg3?=
 =?us-ascii?Q?XWmU366EThn9hlNwXlh4dZuUwjlXk+stUlAFM6DIwbYxJ23etdAJWKSHgd32?=
 =?us-ascii?Q?/qhZ21qDxx7OuCrocS81IrHhDOxP1qJP7l7vI3g05aQudsITS7EdfwYewKq2?=
 =?us-ascii?Q?ysp6fbb4K4K5gMMh0xOHwpmU1QnYB72b4biBQUw3zzc7et3aeX8aj2r3cBmn?=
 =?us-ascii?Q?Vs66derxgMNSxzcIUkQ0MmUSuG2/tYiUE6FYyDdJqOB3O2iKsB7PLJ3A5oRq?=
 =?us-ascii?Q?VvmQvvxJYAZEmdNp3/w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b71981-2ce8-4daa-31a3-08ddf5f87da2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 14:42:56.4310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FKWcF6jz36HWg00IaRp18gG30+GIBchI5SScq9nkFORC03oHhgYVT/sAY1IHh2soCinBPALAs9tHk7wPNWQd0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11651

Hi Jassi,

> Subject: [PATCH] MAINTAINERS: Add mailing list for mailbox

Would you pick this up? I think this would be helpful to have
a list to collect mailbox patches.

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add list for collecting mailbox related patches.
>=20
> The mailbox list was approved, and shown in
> https://subspace.kernel.org/lists.linux.dev.html
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e406de86df9b..063381bd7735 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14155,6 +14155,7 @@ F:	net/mac80211/
>  MAILBOX API
>  M:	Jassi Brar <jassisinghbrar@gmail.com>
>  L:	linux-kernel@vger.kernel.org
> +L:	mailbox@lists.linux.dev
>  S:	Maintained
>  T:	git
> git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git for-
> next
>  F:	Documentation/devicetree/bindings/mailbox/
> --
> 2.37.1


