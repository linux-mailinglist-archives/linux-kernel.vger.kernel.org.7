Return-Path: <linux-kernel+bounces-753225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD815B18042
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6CA91C81162
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA43233D64;
	Fri,  1 Aug 2025 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="vmJVvkfJ"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BC61F5827;
	Fri,  1 Aug 2025 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754044497; cv=fail; b=l4e2x2tSjvXKadXp9dNJ5OFfu5gHWGMXhfod9Qu7IAw+HDHyDonL26LraHGirU0YxBs86Gsa1k++4bzf1pV/1UyjumvLqnX9m/xCrnavi+zE9RMHcdjiROODSsd2BNbYRzcAS4803BtVX573WCXWwYuOqbVnB/R9Tv2UZpux3dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754044497; c=relaxed/simple;
	bh=PQFt/Bf165L6Tsw3yTS3akFaqSZ9dxKExXBOUObqSuY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PEZT9XXBI4PkslGlqaLXxpC7ZQVnBLfNzXe0s049/SrpDvUSM0vRUoQvfi4Yq+4xYPq1zz8NaH9P27/DvVXbvmvFTmdUGKsJj6SV5Mm5Ukcpt22X/De59u4530Dg1Gcn0z4ZKcMxgtaEDL3O+mQ0ZUFX+2tFne2F2xlnDayMK70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (1024-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=vmJVvkfJ; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWN20y6o5qeOl1+Ioox56eqTmDvw4koqI1emjKt9mEu88rt24lwflpvpumdu3gjV3S4fnETFX1w4ZV7XY+mmVW7+t5gV0mm3ezAZnym3jm5Zj2xi1rhOVQyMWG3RMLA0K0USA7rVdil1qj3pB7CPKBCFYjdHZqwdFpHDG3YSQEwibewcPW7iUVGurQ9Urrshs0x8Ri/pd4NRSpySWc2bH+4tP9Z1vEMetXlfSED9cbyRBq9I6pu5Umb0tj3fqtu9634ym4BbGNwn4yHv1SIBh6m6lzY2MOfGtKc4SCUbEcO5SMQYjvl2EF46jmQexp8XYdlYM7oTAhWiiaEaAlL7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7abRtlnz2KanP/ZYaLDc1XnduAIvy5GbSPME0n5YIzk=;
 b=VLR4hS4aX6h0SFrScAJqHqy//Zq7fKvVWVvppmZzchkx08Sxc8daKas8cZLH8uEvzfunRhb1Cuja5jtSmqzKKxhCJtCZExqn/UqXYwekHaUzpy3lhHHAl2RmRbmTPhOd1w1Awvf+Lh9E75nWhsWhitd+/KorJf3xlMrhz04hQBFGmxfAE6h3rAxl6b267w0Rvu9beKWast1+5pwFKu//P5pjNnWyE5ExINfOACv/fHFGwUBo/FJ77R+LeJJKN/5PS+6J360QHcFXsCUMGKyVZzDr04+ynMeA8QXI2SiyhQkuj5AWfCl7Xt8Rb082du2mJxrZLtl/23oGH1vVWSNiLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=einfochips.com; dmarc=pass action=none
 header.from=einfochips.com; dkim=pass header.d=einfochips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=einfochips.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7abRtlnz2KanP/ZYaLDc1XnduAIvy5GbSPME0n5YIzk=;
 b=vmJVvkfJbTVq7rUJqaMLgHVj21uoIP4JtSXLO16cOkuyHA4R4m2I/QLVIOPf5+K+yK1tIWX3De8xmnmk5Suzb/FqIgJiNHDbIapcMClP7sJUKnIRazaKCekG4ZinI5XZS5a1Rdz791iMnyNE1q3YjEvO1kavi5XSqDCHW8W+meg=
Received: from SA3PR04MB8931.namprd04.prod.outlook.com (2603:10b6:806:381::22)
 by CO6PR04MB7809.namprd04.prod.outlook.com (2603:10b6:5:35f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 1 Aug
 2025 10:34:53 +0000
Received: from SA3PR04MB8931.namprd04.prod.outlook.com
 ([fe80::f323:b482:8b18:af1d]) by SA3PR04MB8931.namprd04.prod.outlook.com
 ([fe80::f323:b482:8b18:af1d%6]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 10:34:53 +0000
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>, Conor Dooley
	<conor@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland
	<samuel.holland@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Min Lin
	<linmin@eswincomputing.com>, Pritesh Patel <pritesh.patel@einfochips.com>,
	Yangyu Chen <cyy@cyyself.name>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Yu Chien Peter Lin
	<peterlin@andestech.com>, Charlie Jenkins <charlie@rivosinc.com>, Kanak
 Shilledar <kanakshilledar@gmail.com>, Darshan Prajapati
	<darshan.prajapati@einfochips.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Aradhya Bhatia
	<a-bhatia1@ti.com>, "rafal@milecki.pl" <rafal@milecki.pl>, Anup Patel
	<anup@brainfault.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/7] Basic device tree support for ESWIN EIC7700 RISC-V SoC
Thread-Topic: [PATCH v4 0/7] Basic device tree support for ESWIN EIC7700
 RISC-V SoC
Thread-Index: AQHb3rESAJnHCmMu6EuhdqV2JGFLn7RN4TKQ
Date: Fri, 1 Aug 2025 10:34:52 +0000
Message-ID:
 <SA3PR04MB8931098CC4A73E8FDD481DA78326A@SA3PR04MB8931.namprd04.prod.outlook.com>
References: <20250616112316.3833343-1-pinkesh.vaghela@einfochips.com>
In-Reply-To: <20250616112316.3833343-1-pinkesh.vaghela@einfochips.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_ActionId=1f9ed64a-8621-4907-a990-6e8641f3df89;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_ContentBits=0;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Enabled=true;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Method=Standard;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Name=879e395e-e3b5-421f-8616-70a10f9451af;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_SetDate=2025-08-01T10:30:24Z;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_SiteId=0beb0c35-9cbb-4feb-99e5-589e415c7944;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=einfochips.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR04MB8931:EE_|CO6PR04MB7809:EE_
x-ms-office365-filtering-correlation-id: 657449e9-c57b-48e9-363d-08ddd0e70cee
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|13003099007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4PjbfoyRL0JgA2+wDG11xR5U/tKI7hm7ugQgdU2S8zhLM9353xnoD0VYKjwx?=
 =?us-ascii?Q?g221PP2f4/Gw86ZLhAjjkH3Fno5tmdl28jScVJAHVxoE12WuU2R67wsTCBnK?=
 =?us-ascii?Q?ejWx5oVZkrOar0ZquAF47qSoMA87w87ShsYIOBy1/Z5/JTa04+Dbq2vvU8nN?=
 =?us-ascii?Q?0yqYpvtCUgNo3hKZ5r5tNF7krET1YJJIIOuYI5p5XRU4wMY/W3cIVjcjcRHa?=
 =?us-ascii?Q?yN5QoacFP2J/T8UMzfDfHW1tbnj+FXSyWP+WU7Ls2ovaHJPZeKZVQ55/5Are?=
 =?us-ascii?Q?90NBj7SE4oL1TbjyLk07Xq/VaQ0WoaR808HCyu84rpAP4IfelXsQq40HqMnk?=
 =?us-ascii?Q?U3TK0HgTDeuyZPttIsUo8dgF3HbNpNyBlFGVWD7X62am/KjFwS3t60i1cIca?=
 =?us-ascii?Q?aDMlyLiKZv5JkHLB4UePCK+ZI+2tBbYiBQKMFZ2sOhw8MhtRoGe2yTt3supi?=
 =?us-ascii?Q?qglWUZLYjHYBmm8ORfQY7pYB7rUsd4gSYcHZGQzgLFfi/tf6RaQ9lzZFn4hs?=
 =?us-ascii?Q?WzjFLaeC4FGred8MMoevAryF7skvvIkIRrbG+t7foGKLJJtViLUC00601Vjk?=
 =?us-ascii?Q?CCrBrl68HpWwc/V0V3u0BI3TH8fuw9Zrt1DfTyNLE3ndyU5bVp/RtP0Rx1zQ?=
 =?us-ascii?Q?7TifnweEzet+yYBHktqfxexBLhR3avC81BE5Jx4H/Eb1vAlLlM8Lkfj+Auiz?=
 =?us-ascii?Q?Z8R8wI+M1922z/LN5TRu7G/ovHBPwDgplkMUsMwkqMI8tvWTLlcRE2Oawq1M?=
 =?us-ascii?Q?m59PdDZ+n0eU3L3zukImfpjZJi7DSM7q2MbJfY8XJBGcrTvnPtuRwYL6UFhU?=
 =?us-ascii?Q?hz3cEzilt3GRIBrDlKjEXvgo7oAFnrzBWmYf7nBmzsT81w4kU6ZJVToWpu9P?=
 =?us-ascii?Q?zBberlkIxg0ev57R72xkIsYmn6jwsZZoMI5zVTK/m7gWP3udhY8vQuOP2tdK?=
 =?us-ascii?Q?E+LvtgExe07GWSStX4JZBblnq9foiI28+LdYVxKpTEM9LUQqalBuuRqWSfjq?=
 =?us-ascii?Q?kPGYpX4Ctf6mnO/DJBs+znAEaA8Oe5CP/BJ5dKYLvMecjdOie4/Jb0H/jesm?=
 =?us-ascii?Q?Zn3Mq1U7cOfTiBBnplZfFJFPGLuGOxNjtgd9iq47zGoAIo5PoYtud7D9cUTv?=
 =?us-ascii?Q?7V78J7Kcacy5ppiZvXTQORYWoZVgZnTdHabcYOKOPEg/GzQNf0zbpR/W4GXn?=
 =?us-ascii?Q?fYs6CQS01eYO4RjuOvfQfq45ytA6abG5hpP5avrTAZckKPFHTDCO5D/jXkr7?=
 =?us-ascii?Q?eEw76SEaItRq7DaKFSHfczVMD5kBbSlX+RXtiqYzzhzDND44hZcuLDO4ns9L?=
 =?us-ascii?Q?zVewlyUgzph3kATrYDK7n3FSXv0mdebjjNJzGO3CbwdQvEneDeQsU2GIt5+q?=
 =?us-ascii?Q?fkXPxuHh73SqzdCe201TPOqWDxmD1t68P66fAR1qFeR6o74Ie5SShx79tfJD?=
 =?us-ascii?Q?W//LjwEnw2g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR04MB8931.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eoCMTludD/QEyWed6w9IhC/gqA/E0LKGxxsF4Hm9/HG/48q2j5bRbW3clgrY?=
 =?us-ascii?Q?4rHlZyzOBhdZk8WxFvkgQxu8IsFEz/T4ENosMdb3t8kg13jb72+aYB0GzKXa?=
 =?us-ascii?Q?EW2LfQZaa+ovxmCP39DiYUZh6khqBfsHVXK0zB78VY9OeFzAWtKeDuoEzOrW?=
 =?us-ascii?Q?66QNb1QSZIVnzr279oWzrH93J9pZmaT+hRLJmhImvjG+Gbd+M2bkKqc6nt27?=
 =?us-ascii?Q?xtrNQs5SRJVv6CHlqC9xbwsl1rLwE0kguz0uBB6agdfZU3s7qUwU9lyJeXmv?=
 =?us-ascii?Q?2YoYAtTocRFotQP28rTFy4FhksPcky8R23mVJKlPjvaeLoRpERIyHW/5nlOj?=
 =?us-ascii?Q?+3TDTNcIvAHRLbTLEov3XHOOmoWnCfX0qSOO37grzSnzLgA8uzGldYGlmT62?=
 =?us-ascii?Q?bfbtzYSVZYPZSqwtESHcUmXheALqgwtdueUpUg2j3LqO5gqTGUq4QcmLPZKr?=
 =?us-ascii?Q?W5RVk0F0RdB/mFrrxuUFWA/N7NJ5awao8NB5A99O+oDWYuXgyLXmq9dVFgk9?=
 =?us-ascii?Q?XreVcd35KCE2BkXAGm9VUZbFVjnOAfNxK/0xUrFRcHk321tJ/ULhWYtwm2bB?=
 =?us-ascii?Q?K2KgCkrnf6/xnoKVTuL81KhgcSGKLiTdd2v9RJFIEk+UlW4gZoZiF1dqUxbg?=
 =?us-ascii?Q?BLr3K/rITVSMRbQhBYkwBW/9CHq5kd/xGwWto1qQCiPBFrBlTSl4TnJp3bzp?=
 =?us-ascii?Q?6/OQGCf7lPt4IkbrFFGG8P6DmlgA35WT9qAKiDN7z7oJ/UajmE0sn8GHIm0d?=
 =?us-ascii?Q?xMTeSpzpMsyE9jIe9OyefEC4za3YAfOj9EhMA+ogp+iMUrmFs0q7qQ84Higi?=
 =?us-ascii?Q?sgtTZVrWOTtlIgmQv/3fsJcR3cKVeSidq5pOcKL505R4YPSRXclRYKiVKhVS?=
 =?us-ascii?Q?vWU2DjIkcob7O9RMC99AXWWiGxgHDJrZz/jC67DTumMWXwJBkQp4OxOzLab/?=
 =?us-ascii?Q?PkQYATo3wqJoMcmxCAzv45BKl/BO3CXglmW4g9Y5vcrnnx4JlMufjPpJhG5g?=
 =?us-ascii?Q?sysClawQwCF6hU0cq7EWwPlCtXWeYS8GovD+EeGz0ViSjDCWuCjcWIXpYMm0?=
 =?us-ascii?Q?fwVgxnl73w5S+huh0iXVG/L4VU5b+u+HZ99wJ+Ft98/9bplfWtwhBsco+iyy?=
 =?us-ascii?Q?6esCrqGc1HKgNgYaWulDEtm8qBOiFRBCm4ykD7idQtZEB1kVgrcpb/tKjDZI?=
 =?us-ascii?Q?sI5JyEri9R92LwfEr4mr0G63Gt9b59K9eL0fe096Y5DDgt/Sns4y/JmA+x8r?=
 =?us-ascii?Q?RSjVawfm9NlNsPrKAiWtOG7PPg5QpMmam8bpzAYAQFQfBoNNZaNCRl5qjVsj?=
 =?us-ascii?Q?X2Bpk/BJkYj482t/DHntqQx78tZ6+7eEPVLJ6rQqMLaw4JtXkeUVbFrjyz3j?=
 =?us-ascii?Q?HQJ96hMcWOX1Yw2vWcQaz+unwLDQOHF2flxU9xc9dyorqcJ4/dVg+EEG/kfu?=
 =?us-ascii?Q?hcAXCsdQiwtgJSAGf2Y5IIsSPyX0u+FVoHDiMTlKg4YsdrfDc38F1LdKsDbc?=
 =?us-ascii?Q?u1tTP4VmnPtrbmWAQN/hpVjKidJuJdUuHmKSL/RU0jJZg6te2pwD//bq28xZ?=
 =?us-ascii?Q?mC6O+EnwFcNyfZL4bLJZLRIThWXO0yKxZbof9Ou0oIDZgzbQT9AAIT39BIYs?=
 =?us-ascii?Q?3g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR04MB8931.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657449e9-c57b-48e9-363d-08ddd0e70cee
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 10:34:52.9338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0beb0c35-9cbb-4feb-99e5-589e415c7944
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oIUXke3aJB5nB7CJy9cxjJ3nvEW8lqnHGDlypK7MZu5MW1IWSrlnKXyHZTLyGE4V4uKrQhmkGjRQLqVbhlByimCgAnSIQ+DpMynUnZOZkb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7809

Hello All,

Gentle reminder to review DT patches.

Regards,
Pinkesh

On Mon, Jun 16, 2025 at 04:53 PM, Pinkesh Vaghela wrote:
> Add support for ESWIN EIC7700 SoC consisting of SiFive Quad-Core
> P550 CPU cluster and the first development board that uses it, the SiFive
> HiFive Premier P550.
>
> This patch series adds initial device tree and also adds ESWIN architectu=
re
> support.
>
> Boot-tested using intiramfs with Linux v6.16-rc1 on HiFive Premier
> P550 board using U-Boot 2024.01 and OpenSBI 1.4.
>
> Changes in v4:
> - Rebased the patches to kernel v6.16-rc1
> - Drop patches that are already merged
> - Added "Acked-by" tag of "Min Lin" for Patch 4
> - Corrected the commit message of Patch 7 (Patch #10 in v3)
> - Added "Tested-by" tag of "Ariel D'Alessandro" for Patch 7
> - Link to v3:
> https://lore.k/
> ernel.org%2Flkml%2F20250410152519.1358964-1-
> pinkesh.vaghela%40einfochips.com%2F&data=3D05%7C02%7Cpinkesh.vaghela%
> 40einfochips.com%7C806aaa42dce241c4336508ddacc83209%7C0beb0c359cb
> b4feb99e5589e415c7944%7C1%7C0%7C638856698032875512%7CUnknown
> %7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAi
> OiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D
> rybUbD70SwOCscQQPb8BHNCuCRArtIC6WuAhBl%2B9NXQ%3D&reserved=3D0
>
> Changes in v3:
> - Rebased the patches to kernel 6.15.0-rc1
> - Added "Reviewed-by" tag of "Rob Herring" for Patch 4
> - Updated MAINTAINERS file
>   - Add GIT tree URL
> - Updated DTSI file
>   - Added "dma-noncoherent" property to soc node
>   - Updated GPIO node labels in DTSI file
> - Link to v2:
> https://lore.k/
> ernel.org%2Flkml%2F20250320105449.2094192-1-
> pinkesh.vaghela%40einfochips.com%2F&data=3D05%7C02%7Cpinkesh.vaghela%
> 40einfochips.com%7C806aaa42dce241c4336508ddacc83209%7C0beb0c359cb
> b4feb99e5589e415c7944%7C1%7C0%7C638856698032894093%7CUnknown
> %7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAi
> OiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D
> RPTdRCpWIvS93NgzWSnuelxcMdiS4xyQI4tKpUoVOtc%3D&reserved=3D0
>
> Changes in v2:
> - Added "Acked-by" tag of "Conor Dooley" for Patches 1, 2, 3, 7 and 8
> - Added "Reviewed-by" tag of "Matthias Brugger" for Patch 4
> - Updated MAINTAINERS file
>   - Add the path for the eswin binding file
> - Updated sifive,ccache0.yaml
>   - Add restrictions for "cache-size" property based on the
>     compatible string
> - Link to v1:
> https://lore.k/
> ernel.org%2Flkml%2F20250311073432.4068512-1-
> pinkesh.vaghela%40einfochips.com%2F&data=3D05%7C02%7Cpinkesh.vaghela%
> 40einfochips.com%7C806aaa42dce241c4336508ddacc83209%7C0beb0c359cb
> b4feb99e5589e415c7944%7C1%7C0%7C638856698032903170%7CUnknown
> %7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAi
> OiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D
> gt6NHMFR1H%2Fd4o7sasfWyeE5kmMmnGuioeU1C%2FEf9AM%3D&reserved
> =3D0
>
> Darshan Prajapati (2):
>   dt-bindings: riscv: Add SiFive P550 CPU compatible
>   dt-bindings: interrupt-controller: Add ESWIN EIC7700 PLIC
>
> Min Lin (2):
>   riscv: dts: add initial support for EIC7700 SoC
>   riscv: dts: eswin: add HiFive Premier P550 board device tree
>
> Pinkesh Vaghela (1):
>   riscv: Add Kconfig option for ESWIN platforms
>
> Pritesh Patel (2):
>   dt-bindings: vendor-prefixes: add eswin
>   dt-bindings: riscv: Add SiFive HiFive Premier P550 board
>
>  .../sifive,plic-1.0.0.yaml                    |   1 +
>  .../devicetree/bindings/riscv/cpus.yaml       |   1 +
>  .../devicetree/bindings/riscv/eswin.yaml      |  29 ++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  MAINTAINERS                                   |   9 +
>  arch/riscv/Kconfig.socs                       |   6 +
>  arch/riscv/boot/dts/Makefile                  |   1 +
>  arch/riscv/boot/dts/eswin/Makefile            |   2 +
>  .../dts/eswin/eic7700-hifive-premier-p550.dts |  29 ++
>  arch/riscv/boot/dts/eswin/eic7700.dtsi        | 345 ++++++++++++++++++
>  10 files changed, 425 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/eswin.yaml
>  create mode 100644 arch/riscv/boot/dts/eswin/Makefile
>  create mode 100644 arch/riscv/boot/dts/eswin/eic7700-hifive-premier-
> p550.dts
>  create mode 100644 arch/riscv/boot/dts/eswin/eic7700.dtsi
>
> --
> 2.25.1


