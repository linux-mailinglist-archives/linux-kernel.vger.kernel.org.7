Return-Path: <linux-kernel+bounces-672559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9EBACD103
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 02:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E18A3A7ED5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 00:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E67D2EAE5;
	Wed,  4 Jun 2025 00:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="gBJJYoQe"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023097.outbound.protection.outlook.com [40.107.44.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85273594E;
	Wed,  4 Jun 2025 00:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748997976; cv=fail; b=p9DW9/kmzG5i/HHvf1D0+DqHWJ6v6i8D0t+SXS+rmLZZoDZGsWyFkRClUcXB8/4KXkKEUYKtb1MO0MgzjT23vAf37u7EZsxfPKOm4IqSqKyKPzZv7bI572xm1GhH2zwf91w5gXjoJpn7vUEER6Q5C5wqxQZw6YXek6r6wL7X/og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748997976; c=relaxed/simple;
	bh=ssfuCfbm4B5tRWj/VDDbgOz35WN2A3o3Z2wh//ae+ws=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fYImSCS9x+XL1I0e4UGSEgRiGkOoft1zZuZwzsMRlqRqdSOvOo+DeoS2ZLMTesBRsLX2AemSqLraG7IUIsE4cCJIdgS9lqrNAkbnmsQMU2FA1h5W3JSXvhCTwbyHYrYlFyg4P+UhLpjAhkBeH1KTT7ybQU0LAYalE8uge4LVp8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=gBJJYoQe; arc=fail smtp.client-ip=40.107.44.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXDURuGrqodRsdrBbk2krzZkrob6RfwCe8f5YhnxwFH5OuEeNTE03RuQYpa1cUcKND7mdz08xe4LdpjgkaZQcoJNhtui0lNnznNvSoNoCoYyKf6OM+DT/nEnGCHLlwH8VdHNiIz6/F/aIqavHFf0HKsEOjjBa60uZU0KiAiWL7a7nNd4gsBOCVO2p37kc0GSeQdQ6r+hWa4fYoUHd8PPIdXToB67xIxf97Kmhyo2lNQfkNtlznxTIGoXg3jTPU6sr96863CKAzLMvsZlIaXFCiPcC+FJPjPnRMTNUjEwy/NXV8dfxTt7q3lTaXr+cChVjXTRPBwcnpxDxpVC9kOkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLwfib8OaHjzoROki7ANG0RC4DDeyVmqfOY3ZSJYxD0=;
 b=b0YIjuKgAUqsgWpW98zYXTf5Mv34SgBvSDakL3HD6rt1Wh2Gvp6VF0PJ9LhYL41ohF83R9oB5CPeVwZ4Ct6fTQwd9S4QfE5bpDPaHOn5WcdP3qFkBPEn8ldQIQXR/Md63J9hbUO0Y9zhXUI7TCPYlsRgPoq9tD0Cq8eJ2nh6olsl2eThD8fvwEu3UhxJ42voSpSMSY0tobiNhTvrqXW4tEIqowuk1+M41YQYiu2dZXs0GxrQlL2Zk5Puo9+PSVLgKoyCsAIGh5YGa4g2ffbZkaIPzNSnP/5yTEIb/khWbmQBFVU0OmmScmAQ5BRR8WvAXw/deiV4p5URxMTdJe5hlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLwfib8OaHjzoROki7ANG0RC4DDeyVmqfOY3ZSJYxD0=;
 b=gBJJYoQee3mAuWjeXpQfGTWaeFDlNK8V0bRmNdiPRwfbgTsgKfZzaXYvGZWUV0so3TviAnPGlheSY5IJH46E2+/iNJ8sALQsd0z0slIdf7Wg/IwVfbQ11gY+j71XcO5jirBDLVthv7XI72RFzBXw//QZlOueymq/mRMjXOsespdx7V5AAida6JIBhl250eqkFxmseJz1Q+sRk8Zx78W1vLDUucAvF4JtMzozDnk6LDWyl7jIP1pazDktNpxpqd2HxAQXErZ979XkIWMClgGUWUOMCDV9ESZ4ak+3aQKFz1XklpVHfWH0EUF1IIOQG96c7DdLtXVBB0JfxyjDwSYjDw==
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com (2603:1096:400:45f::6)
 by SE2PPFD1755A465.apcprd06.prod.outlook.com (2603:1096:108:1::7ec) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 00:46:12 +0000
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b]) by TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b%5]) with mapi id 15.20.8769.033; Wed, 4 Jun 2025
 00:46:11 +0000
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series
 SoC
Thread-Topic: [PATCH v1 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series
 SoC
Thread-Index: AQHb1FzMRCeMloEvSUe4D9FkwuM83bPxKXCAgAAIIwCAAPe7kA==
Date: Wed, 4 Jun 2025 00:46:11 +0000
Message-ID:
 <TYZPR06MB656889259D6BE8846E2A1F65F16CA@TYZPR06MB6568.apcprd06.prod.outlook.com>
References: <20250603075450.133604-1-jammy_huang@aspeedtech.com>
 <20250603075450.133604-2-jammy_huang@aspeedtech.com>
 <273da934-deeb-4129-917c-5d7038930941@kernel.org>
 <a8c4ec8e-51bb-48f3-a47a-b7a848a44951@kernel.org>
In-Reply-To: <a8c4ec8e-51bb-48f3-a47a-b7a848a44951@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6568:EE_|SE2PPFD1755A465:EE_
x-ms-office365-filtering-correlation-id: 96c0c016-898d-46be-ae6c-08dda30133f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Rboir63XuhvKIzaEU/ZXp9ximFYvByOLInZWYy1B+Wvn6BRzY9hfG7Q2xB7r?=
 =?us-ascii?Q?XWxsKnmkh+f2/1fyS32Y1Pj0rE8nZsn9gi4pxOOJtOLiF7GDLRRG8WDczudJ?=
 =?us-ascii?Q?EhaHJUn+S05tKDpyx8Or/cBA8il7mdvrCDPZ5ZdJjJLigEPQtMKnnBP5XeCN?=
 =?us-ascii?Q?g2lYjEJFTdmwdMNI29Jki1OTpy+/9mciEryOqVWfuhGH8bXNkVyXkTA+xkKv?=
 =?us-ascii?Q?AJXE4yHvIQYHhaGZRC45TcNHbSBfKr93TCKY/9Pu1yxoPmwB1ZeP+UHPVDkH?=
 =?us-ascii?Q?BY8nYD6FcaXtn3Za2BZkETiIE8T8E64mB6aiksgD30hZIxTZgbrxNIDHA2ok?=
 =?us-ascii?Q?H9Sq+pesE8ffYw+LHtWLdmm0zk6E6Mk9zAbPqRxMaxSaH5V1+IZpmKnjVYAR?=
 =?us-ascii?Q?8H9xZVYerE8nVB3XcGZhbzXRcLpfUgS6xnQKgt9F04Bk8EldvQTDE7QwRflh?=
 =?us-ascii?Q?TsN+76mVEV4ob6HxNI6b5Tm7SBJDcMqfKAMqzWHOG5nbdZbY9OTqajSEat5x?=
 =?us-ascii?Q?h1XCmaZ/xlnG6D1nByRsT/G+VQTRibeS2fm6bmjHefsEf5A5ZqhNRmUAfImK?=
 =?us-ascii?Q?F+REeslKrxuXHlR/35CEjf+88B/N+FDatojCh+LEBt2sePgFT/eQY2CvtXNH?=
 =?us-ascii?Q?s3cyrnNZ2a7OeBwdTzOkveLXCaasZo9vEAmsS0wFoiFoCT0ufN2efU0hVdWf?=
 =?us-ascii?Q?3K1Zn5e2X1iP7N+xBGnNPJCDuyfYqI1EXhPo49u6V/QG0SzzAO8OWFtMyyVq?=
 =?us-ascii?Q?kZ1qwgtuH4AZT+ptDMn8elK/EI0R0qM6tKdHGkOq+avL8IzjlCRU6XQy4wZ/?=
 =?us-ascii?Q?XqLiQOdSPFXEzpkCI2bMHsKF1nlkSqZcSsDxqQmly9zsY9yyLmxfmxq+o2dT?=
 =?us-ascii?Q?HYreK6bbSNd1sW+wu7Bu5ARh2Cr8YydpmjC4kcAQ3w+oaIAMN0mqrbusgiQx?=
 =?us-ascii?Q?7Ty8TPshvo891dkSv6Ne0qlWTDDgAgFl7L+N3jppJvweAkDAqJg20LESZ+gO?=
 =?us-ascii?Q?tvzkj98d9pV6yalyQyCIdmu+joumQfHv7FRmhZzQJQ8IX7SK+08yKJxqX3+f?=
 =?us-ascii?Q?dehkYuIwOd2U7E0lBVXMTDyk49jeNmsMokfpcInPyC+3F9AYGwEV0FgKvf3n?=
 =?us-ascii?Q?mPBwwke6ceaP0xSulmk92mq8W+EIZJKJxexMrzT8Gduw3h1TGEv7o2SdkT/w?=
 =?us-ascii?Q?J7I6BAZYdr8w773/O5zUaDkJru1dvlwiw4vbbxEIxkqW3wPFSexc0p9SwyjA?=
 =?us-ascii?Q?swga6ACv9MnOQSv2DSwaHYbBU3z9g6OMAOItKy/FRNkw7R0+G6XuNcDfqxoI?=
 =?us-ascii?Q?wcQ7wSDUww4xnwEMAKVjmD60naTIJoXCyM+lypIyFUii6Cd3W8m1jO5EH5o7?=
 =?us-ascii?Q?51VLlQscqA+A4c0cVimvxXr25qV6faSG0eXasWDycjCvgRGTnCanY54Wevwe?=
 =?us-ascii?Q?A1Q4SvRpV1yQ2v6CYNIaqpKqcugk26yn1KzENP+N/FR0CVuLzArmWVtKDGwV?=
 =?us-ascii?Q?rXfc9nZpKPF59Fw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6568.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ep2FqF/lhgD2NbOjEensUDipfw2fn6rUp5C4T2ITROzsLIiOmtH0TC75Hhs6?=
 =?us-ascii?Q?eqhzAt9Cp9YF5qptF/LjLFOhOcabSbFNFEa6ZKrd3vpY7JIMJNXtZvn8zrpV?=
 =?us-ascii?Q?7b/5WA0uT+q8wNs7It9xlb2EOJl9CHBOeSYhATv4TwLMbmAF6pQ4Kg6iOwN+?=
 =?us-ascii?Q?m5tOmsGgZzy456JtUpwPIHx2e7lLZ582MvC5gsAvvyouR77h9tR1jCtNHGjr?=
 =?us-ascii?Q?thIs11/pRE6YMLd2cK7DqjaNN3e47snUVsjl/QiFCmiPEWRuPi0k6nYlw/Gs?=
 =?us-ascii?Q?hDzD/NZzUZlU34Zfy6g9tPDFC3NrJEJWf5z7cysKVCWRkOm2Ua91lf9Lvoij?=
 =?us-ascii?Q?nXAsguNBGzqtW+rwhaiaKA87yUFKI53EiqZKXvjae1deeakx7+S1xX7rn7+g?=
 =?us-ascii?Q?eHD9emiCPlG2PQk+rmwnlhu2r9x5QtwxSlsqfJSP/xsBIlN2tEOs1Mpzeb2o?=
 =?us-ascii?Q?HpqBZjIn77z5GGk8du1o/7mHiUTKzqkkcQLr5jh9U9pbF58WuGl0FXm8Dtih?=
 =?us-ascii?Q?i+DDh7u11L8o7zxt2WtKPbQ5VS1ASPffWb98fTZsMx4SONS7VkeJFSugTIYI?=
 =?us-ascii?Q?jGT39nUy1hXPXhsd7JxftZzNu341gPKMjIPufafBX6zlk5/zGBCeqHal7NeM?=
 =?us-ascii?Q?1vTVjtjAghGqR5ML/3eDJwYQ0ri2wlRkoqZ+JNYi9D+U1FddQPeqrk6a50YH?=
 =?us-ascii?Q?iZatJNdXpgrkGqHF/JqzSr8nGrXttfAGce2MEnccjXeZ4+rffsOJpYCx+MfP?=
 =?us-ascii?Q?ROBGpLkrvmLTcwndCZvmpomSORj4mTN0HHCvwbjEkxMec4tc6NnzURMavnhs?=
 =?us-ascii?Q?wr8763HSPi/Kb/x6dAvxWAzcH1rw+SALiuFX8gDKStnc2JiDAezN/FBCTXzN?=
 =?us-ascii?Q?VQ+9jTIAY+1N7oMMHezAKfvpouCsCOxl+e3i1iAnb24yXB/biTlL8m/XwCaz?=
 =?us-ascii?Q?ysakA9KfVsoVyw2fAWnp8BuBoCUuN+sXIyw+niJEf8s95kVkeM7S2V71dyOR?=
 =?us-ascii?Q?1vn2ogW3kf/WsvYota5Ot1dQf3VsFFpz0Pf94gWEMI1R58A/6+Mj1dogrAM2?=
 =?us-ascii?Q?xvgquA6l0nlFNKjyk6evkbs4nN6dg2eU581LdMZTt1xxkGvZDAPWFIcWyOQ6?=
 =?us-ascii?Q?drRR0rBHglt7d/aJ61F7FuYNqhNw09a1B2fmtsgZSuccZF6cRjbVA08+Wqi6?=
 =?us-ascii?Q?XJwNEhnn7E/xES+6kS+BmkWDP5XtnS15Mw/AvOCfCixmgU1smczsy9BePFnT?=
 =?us-ascii?Q?WE7G/Y594jwh9bwPR47stLZ80lurrZr989JR28i20cT4ifzk92/XUO0UqqNm?=
 =?us-ascii?Q?r+W9O56oNc2Nu9D6TTDMz4iNuAKQNEPUwkUHXWKYfwJpEJgIqWBeqN27n+3j?=
 =?us-ascii?Q?2M8EHcdMkRy4ml9MaxfCIYUw3qOjMGN1eIjBaBVAGbqxFrvwGO9oUa7WpA2x?=
 =?us-ascii?Q?AZfvaif5s/7Wx4KNKK99SzESD0lFItnVAM620oFRcj95MDEGNf/JiQDuiTRM?=
 =?us-ascii?Q?z6/RueVt3TQb0H9IeoUcBWlr/LGQ3JGWN8kh8Azvqkz/wGtHnuNKqQcLfTIu?=
 =?us-ascii?Q?sapozCoJCfH6IHYzLaOdLOP/4lTiDyTyRtAsmx7W+Sc4bPNNsjcyRR7K73Lx?=
 =?us-ascii?Q?Tg=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6568.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c0c016-898d-46be-ae6c-08dda30133f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 00:46:11.7961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hG7PoAjKy3Z7PV6FMMBGx8Qorx/A0STzxil9XMPgGyiyGDQhEqyc2++xPsUS+m7sNfeV67oSF6VXfwb7M/v5B6bwH9gyw+fwj6YdUtUDU1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFD1755A465

> On 03/06/2025 11:22, Krzysztof Kozlowski wrote:
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - interrupts
> >> +  - "#mbox-cells"
> >> +
> >> +additionalProperties: false
> >> +
> >> +examples:
> >> +  - |
> >> +    #include <dt-bindings/interrupt-controller/irq.h>
> >> +
> >> +    mbox@12c1c200 {
> >
> > mailbox@
> >
> > With these fixed:
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Huh, not tested.... so obviously un-reviewed.
>=20
> Test your code BEFORE you send, not via community services.
>=20
> Best regards,
> Krzysztof

Thanks for the review.
I will update accordingly and make sure test passed in later patch.

Best Regards,
Jammy Huang

