Return-Path: <linux-kernel+bounces-743440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A393FB0FEB9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 04:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FAD216FA81
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7306E3F9D2;
	Thu, 24 Jul 2025 02:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="pVyE+DPO"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022106.outbound.protection.outlook.com [52.101.126.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27E8AD5A;
	Thu, 24 Jul 2025 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753323566; cv=fail; b=J/zkj9ZT0onSsuTP0Q/TUzYv5OnhtLm+KEIGs6Oi7FTzh0jk3t/3Zgrmp5IunQOZ5GB/zlPEq1f+lCQf6pjJTYvmue1KgEhvUVWcycKy32TgxuF/nNxLOdBgkTvrkO0Rpr32/6WylScsA6232GucV0/pAHeRPdL/DwZuXuWdf6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753323566; c=relaxed/simple;
	bh=kaE1v62t+6duWvqxYAp2wvgFR+AZyMNoh+/eeZ265lw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SvVYCdQLmNFvxUDkGpEau1PSbJlz+gV+ZDlUyDwj0nGSUGwL12vq2ro7q2T+JgPVaEJ8dvZB6u/RG3HC+ttwuP0oQIJSH4HgjNa6JXyLyXGnYWWEL7zfZo/dWxfV6nbpKFPgSNwZhbr14l/7xnZL3fwO8iU/Z3tiFVt1gHM45tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=pVyE+DPO; arc=fail smtp.client-ip=52.101.126.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFMW2WL87s/wMCS6pfRDiyNMJdF3AjJQv6KWm+uNKFIBguD9KX3rQ/H49dfv7BZG3sQJKSSDbPefVLaxqYbqUjBzVMbC1bBmbI4LKd2fdskQ5GTwtfJ4ZjSHAntEn2JG0mwEXMh9jTvRtpnzCAB0MgHi7LzcmydwoZmzwUw8G333DKbtVD1djcuuWu8TQxbQKG5KsMnbTK5ydoLG3PNYDlVDtMD5h84NbfqpXA38DRa/nc7HZURwJMgc+R7y+fwjvt0BdV3GCEXKnbWmWz0cjBh0XC+8TWDz6eSfXKcayRjVGjjYmHfAIgHLldMdA3SIG3jMUUbmZlYO7v0y1rPuUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sFQKhbEO5uOF2X5gzf7j85LFPAksbLUTeAjaG2inFs=;
 b=c/bW9y7ulQddhMvzLDCW7vJIVPyfWQgb/HGfYmd6ZlmoN/ZlWR2I11S5F7PEte+7OJkP/dvJqPdOqRgsVIpF2hj39a1RrBfOf3Dwpos9jdctK/i+Ea1onDdRRJJWBpzS2j3eqVnxzixvkNm2DcQXzFAINHcE8kZbGMF6PDgob1ehTAj0DF2X7EFxBz+D/Pli7tC4El+6atNO/rlc5an9XiZt++6l/EbtfjQwtvDNEovoNllMNHRIercFt5g/Hz/w6XC8C4DxtQ51rDH3FNhI//vvRqo5lt7/AW/LMZmu8AvLoQD9lk/36Tbgz2kWYNxQJVMPmLf5ZB8BeLDk2qgjNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sFQKhbEO5uOF2X5gzf7j85LFPAksbLUTeAjaG2inFs=;
 b=pVyE+DPO75X91gNm8gp3IDlvecFRiz2k0ZAkOCD8mwchtWlAwJMiZyeDOrtuop91/ZRhpVd4fW0Uk0aVA4uViU1TWGuK28BsFJyBOnTfB5m3QBfnItM+nJfTOp8YJfMI78YAYdJj/mRIrAvngTDgb4CsLLiJr5a/8Jiog0xy6V65QxGhf1m2IGTDUPctuir2kIwgO/kIPm24CGxEdp/Q1B0iNhQvJlSWUvhnzPf2hFy66OwI7hp1nCHtuJRi2U7uSliBzgvXwSvJb6SdaSW7w6Kx0jVQr3aAmWZPrp6cLsOfSRtLOTJHfTZ/MHFpJfPxZgz/K/T0kZjKluj1nlGY7g==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TYPPR06MB7979.apcprd06.prod.outlook.com (2603:1096:405:2b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 02:19:15 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 02:19:15 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Kevin Chen <kevin_chen@aspeedtech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v3 2/2] irqchip: aspeed: add debugfs support and AST2700
 INTC0/INTC1 routing/protection display
Thread-Topic: [PATCH v3 2/2] irqchip: aspeed: add debugfs support and AST2700
 INTC0/INTC1 routing/protection display
Thread-Index: AQHb+u5GY6AhyQJs/0KoaQA5Nmaf5bQ+RGiAgADJr1CAAOz1AIAAkTJw
Date: Thu, 24 Jul 2025 02:19:14 +0000
Message-ID:
 <OS8PR06MB7541B3BF750D9B4CB6520BCDF25EA@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250722095156.1672873-1-ryan_chen@aspeedtech.com>
 <20250722095156.1672873-3-ryan_chen@aspeedtech.com> <8734aotfdq.ffs@tglx>
 <OS8PR06MB7541516DD4FDEBD72A764042F25FA@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <87wm7yrep5.ffs@tglx>
In-Reply-To: <87wm7yrep5.ffs@tglx>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TYPPR06MB7979:EE_
x-ms-office365-filtering-correlation-id: ead8416f-18aa-4f01-e1ce-08ddca587c74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GjrggWcemOSOJ/MrfNplSQKqnW8hQgKSclvAHTGUPeZAdoYxQaOLcfxy6Dk1?=
 =?us-ascii?Q?Rq7EaXsxct3AvuoeNsWn2Fw4onnaUoW2V2FD0Uzk8OgXd30D8Js8GW9zarV4?=
 =?us-ascii?Q?yVel/sNA71P3mcgrSOUqXD8C17F5oMpny+w/Yit9qdoiqTQu6e/3wrbL0ppx?=
 =?us-ascii?Q?3iRcJc4VV1bsFniC8sVDHjd9ExPbcU0pvXhxzwCY6ldPgHFw5jBu+Q9V+ZZc?=
 =?us-ascii?Q?mv26QRo/Rs1CfpPYwZldPD/oObjgsGPpPzBlH4ow/DiD9VtpYOvV1yEYnjDj?=
 =?us-ascii?Q?MZIjIfkYGIJszCk3KIngtJpP/lxjYUJpsWU53BsGp4W24zIJSxQVQWkeZj9F?=
 =?us-ascii?Q?Vh9oZOPCrj2o5vIMTNHv6QdCwXzAfE4NtnweaUMf5Pj0yRyOxY1bEEDA0G0R?=
 =?us-ascii?Q?J7AtBOtRvILRJM9qIRh1QWckdvg/WUBWc8Y/y2m/0xlvfhSQYpEqOhUrYXFP?=
 =?us-ascii?Q?Y0M12WJgRZRyiN5FeogwnsUrdXAi6z0dnHnDaGomNI2vgyAbc7Gij6ruoy++?=
 =?us-ascii?Q?/yXOzb+l09PH1DFpkb87ZvZ1i+2tuCRiVfXyqXKkKzOegi+RQr2TgEPUdYvD?=
 =?us-ascii?Q?NNKvyrnbQWIuFE2fru/7vEdkL6GKmtIELepDoII7dD/6VK8tnVmpXXsBwiZt?=
 =?us-ascii?Q?Y4qkvR4XEJs+4ENc7CiQl2WEfmo6QCJpuL0CElhuHmddvsoAI7xOSYYzm7iL?=
 =?us-ascii?Q?wwIHMc0ffPEh5+HPSJ3Yaj1Vx5/+ZYUYbOHIa/JA0YFDkhMii/Nzz/S8ptRK?=
 =?us-ascii?Q?xHsTVnSQJ0OUABw2D40Rx2bfS2hSY2POKKL51eUN92k7q+24tyGuUMY0B1ws?=
 =?us-ascii?Q?lrBWMZ12l9fKhHtS/HEq9EL/4l6+V7IJoto1THDeytui9ceAAEVujHhMWtNC?=
 =?us-ascii?Q?OHEg5Lj73k5zYF4DCEJYpiOJEXe+IER5b9+WlB979L5y2M20ubFZ4x301oiU?=
 =?us-ascii?Q?/SYk1yCGbtNzNu7BAaUQdnkVL9R0zb2xru3BL0dHP1iiUnwI+EeFV62o78bB?=
 =?us-ascii?Q?MH9IgJHODVphvpe20BkrzBD6Gpfy5zNf3W7ynWyiRIqyZsdYQLtHCPpxM6Rb?=
 =?us-ascii?Q?yrZc+Ir5vK6lcy1BtaqbD0K80ezo5rSNtocuPk4+TJI33Ek5GhEBnB5WJlP9?=
 =?us-ascii?Q?EukiaUZEpDC64VWLZPIsnYqyQlduENiNAtNeGtVkK04SCw8vwsR140pfC+5K?=
 =?us-ascii?Q?YYAbhePI0u6I6V9cuAmjOAm5yIAbAM3zwNVWbHu8A8EzdotiXTI66Oja+qo2?=
 =?us-ascii?Q?8s/6Ep8p+KS3ae1nebMPq+5eJQ2jUsANH8CBLP3kTRcbLhpWYCi/deOPfiIm?=
 =?us-ascii?Q?DnNJ+HD3xcjTBjEOFJJKgi25kwZO9Ek8pjLBuhXlEG8D0rqHO35arMjnJoJc?=
 =?us-ascii?Q?iv2gMA1H2Z7Ib+Ifhffgyp17UTz82PTOPAwgUm0ojpJUOBN24nsyda4Ij10w?=
 =?us-ascii?Q?MoaZaOYbx0WLHythYmzyOqXW7gUFNmBu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?25tX09KfQtT/oM19vFqraThpgUmEWp6nIz7hLhs59JONhDrsWO4Z5HeD+m49?=
 =?us-ascii?Q?DVNkaIReOc7PY52wL26k8Uy6BZPqK17JtB2zx49pC7Fa5LWGmEA5p0bikq7l?=
 =?us-ascii?Q?Em5i2v1ojiRvq9KurVMhqB8kjW08elZwWFTVPa0ZRS4Asofcvs2VF6TPm8G/?=
 =?us-ascii?Q?rhQGglv68AY2dqqo4N9F18a69g4f0fAKG/txALj0un9/GXl9SdoWnr3gr3ok?=
 =?us-ascii?Q?vNPU0KtpVlTiS1le8oAWOz9u3ZJrXXmsLtMjeFYfyiGuLTuNR6a/32cCPqGM?=
 =?us-ascii?Q?Fdiqg25KFmSWk3oyU68XBlKW5GVc57ebaP2jYp32Crpo62edvXHLBwMkNQD1?=
 =?us-ascii?Q?oLUA4fypsho5WvjOZb5RhXEx8d8v+LlC/3IvLJdiuBJEOyHUZ1JVBtb3A5ma?=
 =?us-ascii?Q?SgYKU1Up7Xwb0n5EAtIW/F2j9tBAMJoLQm5PUtOUVKGzB19bCpiPGz53105B?=
 =?us-ascii?Q?hqh+1avcHPoAmEI2er/0wqwyBONukR3QhCJS0vggc3OeoVyb6DVZiGDgkTAB?=
 =?us-ascii?Q?Pd+P3TPhVHg4poXx7ggg2Epj4EHf0XxsYzZ9+E329JKw5+qqKabs3M5EIPX0?=
 =?us-ascii?Q?fj9qlHm+9BevvjU6acKTyvu2HMeExk7tJTRB7+4iSgYq13gu8Aahhp0Q0i7g?=
 =?us-ascii?Q?RukmoqYgWCCU7maR5ZjHKQtX2qq0JQ80dPf4lR7PO1X2wqJzjf5SKBPkyiFk?=
 =?us-ascii?Q?UIFLFYpx/UFAeAMamkFl/uRGHsT9XJkKpi4n9pdi3NWhIOKXLUUNsDGCq6kw?=
 =?us-ascii?Q?QtH3+ojlLcl/p8IXPj8ESJVpKnNRddkQjkbEbOzccxwhaYzDbbhH+apovoip?=
 =?us-ascii?Q?YRXvCpQQnHS8Hnwf9/SIP8TBpTgCLKfzZE8K0wKVqgT1On6HntNaSWIsX9Bv?=
 =?us-ascii?Q?E3L7JfH/ZXVGvFe0lhgxvAwjwRnYbYOOZIUdX99d3Zqg5ABbyHFLr4gD89Bl?=
 =?us-ascii?Q?SIhZBIq/us5Kn9tiTSYmkKfxCD71xs/Y5keIG3O15IiKX0H8PA+RFM7kl2lo?=
 =?us-ascii?Q?WwKvx/ZnpADSEU9Irx2MZ++p4qctTG2ScU6ItpRBApLjD7sWWdxf3uqCNSJ5?=
 =?us-ascii?Q?qhmHpvmKmjcmLCNSQ0ny9NlX2frRJojiTooqRGZrxVMtHcelF2XRwJkMhSdd?=
 =?us-ascii?Q?UhTMz72qegCnUsQkWuDlI1Vq/aTW2k61DMf+bKi48L8x9xlFnBrCYqUURW2t?=
 =?us-ascii?Q?0ktG9dvHjwaGOQBjFsC9F7vO2c0FKzDajeFBdwaOT1XK+HndoJscYCR+k2Yu?=
 =?us-ascii?Q?MRwkX7Sae90s5A4MTDIMlA+ceNDwo70/0QeIS/9IUVuXsqESXz//M7gS6+ym?=
 =?us-ascii?Q?I71a1wFOOMTgEDPhD+fVr2Xv5nftTDlPF1BMMCQIzVP91Mvdr8lstko1g7tM?=
 =?us-ascii?Q?i6HdeP6/U53YGQid/KKhl2suRjcjItvrpwln/vMvdXNQO6fA29mUb7OA0dHd?=
 =?us-ascii?Q?S6Mmb43xaYDJavRCQOn1i6+LEhUWqxh/xf8S+VDBZoYBa660DRDcG4t49UPG?=
 =?us-ascii?Q?/0zWc7chVjKkEO467GV02YJON5HFecaCIJGA6usTYYaH09IROk3XFh9wMpHR?=
 =?us-ascii?Q?eI+dg23qXJ3bYiyQIR+w5EnC4T2ftNWRbnbytZYQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ead8416f-18aa-4f01-e1ce-08ddca587c74
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 02:19:15.0411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZyu8A1DmuEzdfENCzV1oYsrnL1vJGmgqs+OmwA6OUqdk0Q2IJGYYPojFl+I4rhjQ5eocazihdSl/vT4/Knrq7hyNSwWNgOl8p2hQ5YrKsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB7979

> Subject: RE: [PATCH v3 2/2] irqchip: aspeed: add debugfs support and AST2=
700
> INTC0/INTC1 routing/protection display
>=20
> On Wed, Jul 23 2025 at 06:02, Ryan Chen wrote:
> >> > +struct aspeed_intc {
> >> > +	void __iomem *base;
> >> > +	struct device *dev;
> >> > +	struct dentry *dbg_root;
> >> > +	int (*show_routing)(struct seq_file *s, void *unused);
> >> > +	int (*show_prot)(struct seq_file *s, void *unused); };
> >>
> >> See the chapter about struct declarations and initializers in the
> >> documentation I linked to above.
> >
> > Sorry, I don't see the struct "> > +	int (*show_prot)(struct seq_file *=
s, void
> *unused); };"
>=20
> I fatfingered that, but that's not the problem.
>=20
> > My original submit is following, it should ok. Am I right?
>=20
> No. Read the chapter I pointed you to.
>=20
> > https://www.spinics.net/lists/kernel/msg5776957.html
Thanks, I think your point is align the struct member names.
Will update.
struct aspeed_intc {
        void __iomem		*base;
        struct device		*dev;
        struct dentry		*dbg_root;
        int				(*show_routing)(struct seq_file *s, void *unused);
        int				(*show_prot)(struct seq_file *s, void *unused);
};
>=20
> I have replied to this very mail. No need to paste me this and the pointe=
r to
> some random mail archive
>=20



