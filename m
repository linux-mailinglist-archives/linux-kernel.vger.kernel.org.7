Return-Path: <linux-kernel+bounces-710192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA84AEE854
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 22:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5C1189D99D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 20:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E253289836;
	Mon, 30 Jun 2025 20:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tUCv4wWS"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2082.outbound.protection.outlook.com [40.92.18.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87231230D0A
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751315611; cv=fail; b=u1u206lbU4bCV0WSHp0uk/olMP2IIHO6fCrpwjdK213KM6KEEqEvfX5RaaKApeW52CqJTUh0xcVq+qoqasCfXCpCUHWc5j5ttyI0Nj1jq6wmcV8pWVbCGIBMOiRivIbd4nmhOc9442Jf/dLoBxtlzsRJCfjPd5IZcx5pnUVdD50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751315611; c=relaxed/simple;
	bh=BC5O4q20CqF47Q71h/dleuCTZgZ4OjfWG0IfI+8RPZk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ivras3KL+EIGwSJXvfxAIjcEkUPp03tkdWIxFs0TIW2aEkGvAz+aIxEIlQxQNiju08gA7evf6b4UxyGlQdxM7o+u5uQvthTvOGRazWeJt5HBe7b2ks892QyZGBSs3mfH+yx6pxaZtoo4IRsTFORG6LZyqwOjEpawImHdl2QZUIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tUCv4wWS; arc=fail smtp.client-ip=40.92.18.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHYL4WII0xr0/ENGuINdxQ2nTWE7hy0KOhkLZqMxD7GYQdiKTRKCq8b1b9hskQpgtxyJgKjeHXDVr4xF8cHKiKSGsHGSXK/4ERk14iwYIwRYNfRD17tVnJzC9Z1nDkaAi8fzGFEX3cIPswu3/L1Rigly5/deImQvQqMxkCgwVkECQJc+QR+T8dYVBC/Z9Ejtnzcu0GJ7wZ/ehv0ybAXpJsCgQRopqot+WHlJVu8YN+GFk09gr0+AE2RpNHPGyxv4mNILDHkhrjLCh7yi7MBfPqETny3boIQOzcZcpGwxeCsJN4cY9jEuQ8HUfsRCVS7HSM22VbwlxC9OOdOzuGCn4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiIwSQE+tzuH4cP8zzLxw9oQ+qsSdBvaOeUUV/AxrXA=;
 b=kGOz/KD7TyNzMgCJNdtikVlo1Ng6DN8Jq8iuYcbBFGQFLHdr8ovqaoY7XCmBTqxsbhjCdS2le+CzS6KiiaBE7DS5GzdVHGHUCqXRqnCQQOVfN95eOCJpseIIv94iKQ4BD1T0CS7Bk1lnsFKeKldIWbcvaQ24CB5D8t3UZyL3Oa8ntmvIM1rJ3VoLfQiTvMbFnIl1iMGM3DVqt1+hGoAdi9ZSyhdMUud2E45VTqZzgdhfQidTKP8sW7fkp/dEyjNN1gMBEJ4NYkGatqvpCWZGG4/dxK7xlN5NQNpIxrZ/686vINe21gCJUuW3TXJMjySXktOyt7MUJr2J1obV7kIGTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiIwSQE+tzuH4cP8zzLxw9oQ+qsSdBvaOeUUV/AxrXA=;
 b=tUCv4wWSrzKR38esUXi0IrFrikMedYEeXa23Byx1MFfFpV7JtUICjm6VB+wRBv3Ys+iiSDDQQ3vz1TvrgExKq8CkOpxWlHGvbmCLHLwbZObemfjyMVSDiI14PnHJ9h+Wo5L2E99c8gNzWFDCHmFDAJw8NNhZ/gBxfGXjA4tS8c+A/Od4PE3i1LHTviw8zhfzbaTj/HoDlcT84SCd6RRnuzMGPtWxClcabFRg5i33G75J9zCKOdDu13KeKSk+ZsvD1W7JOC99PEnMaYyNs64/xiTn1K/UzeMJMyK0szhp1e39NQ9WeBqFT3gkOH6KHt5uv8ZLzpGE7D1fHgwgiVkMVQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB7885.namprd02.prod.outlook.com (2603:10b6:408:148::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Mon, 30 Jun
 2025 20:33:27 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8880.030; Mon, 30 Jun 2025
 20:33:27 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stuart Hayes <stuart.w.hayes@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>, Oliver O'Halloran
	<oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>, Keith Busch
	<kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>, David Jeffery
	<djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>, Jens Axboe
	<axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Nathan Chancellor <nathan@kernel.org>, Jan
 Kiszka <jan.kiszka@seimens.com>, Bert Karwatzki <spasswolf@web.de>
Subject: RE: [PATCH v10 0/5] shut down devices asynchronously
Thread-Topic: [PATCH v10 0/5] shut down devices asynchronously
Thread-Index: AQHb5g50hLzoIKjPX0aJu72CRNsME7QcLIsQ
Date: Mon, 30 Jun 2025 20:33:26 +0000
Message-ID:
 <SN6PR02MB41572B532608AD12685ED678D446A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
In-Reply-To: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB7885:EE_
x-ms-office365-filtering-correlation-id: 8f2a5ad6-abee-42ab-b3bb-08ddb8155e32
x-ms-exchange-slblob-mailprops:
 iS5pQZgsAQBBTPzMDFr1VvMROCokhyHmB0lQuuHICqaLQMEEJBzRA0nJ728J5dCoOJU2NxqoxBTBH3mgbZXujw3t4oNZNLg+/aYVw6oXCgk023k/F59FESCuxSfULkUTSjF8mKrBrCyQhsEnnhT0OU3PLVf/xcllNxVS+wMg1FG3Lq9+INnUg3rAC49CQb1gXcomVfiLjrV4AGqA9w+3xvztJhXdFtfsfEI8wWVqvFmqbhPuzdY0aBrWmY5WtrSDYzPhPqNXeOlv7uCKkhbZ9N3El4IrHEJDKm16z+CQ7wqRaqPxeFgT16Q5rEZw6uK3bCdl4kxu28A10UCtlb1ADxW2iK7q+LDxcdv37Wnw6a/XuGQEJRz2DHZDSn3VM+bmjgsfvyfW7259piaiJGGbsT6Gz/Ucz9IfvG9iWlnSgOJnSLQ9bn6YmiqORZB2sG4ti/kXEOnksyeJs2HMuYPenc2/0uOnAEkKaXmkucrY4RpCRwpfubBFZFfnvOwB06/dOlSltpMKHB+P1EVhObyG0iFnLPatPseATxUlnBi1tv1jVl8lwrZMSBnYuwpPo0E7flFMbjDPZ1u2EycTSUpeQf4hj6Kb1ERPQ2x/Fk+khQEW0iD7DZ9eYuVuP/wQqmSBjGYlg5B9wreeIZOOEjjg3zh06YrjT7i811uZTEwWszxKL0qoXqz/2cNgXnGxh1IMierbbyTnAh/TkGm4GC16802Z24sX2R3s28PuM9t0Kzh721PGC1kfTr2wnRbAY24ICzYOdBXJlGlMC8hEfXGiGPqGuGbEfkzn9k4Nh+9Ld8NtEZtLbvapBK+be28YZ2Wm
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799009|8062599006|8060799009|41001999006|19110799006|461199028|41105399003|40105399003|4302099013|3412199025|440099028|39105399003|12091999003|10035399007|102099032|1602099012|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?w6sHWcDGSwGg6GcmA+OIyceSBvHKZqc+plysKtM6nJwWmohtswCXIwPRiZ4R?=
 =?us-ascii?Q?ursCikyce9+luY1IhlNzkQ209F4enOnt664/paDS9hrrGiecwuV7gdnzkMFK?=
 =?us-ascii?Q?FudQNxsfxWZc2J5WW3tb9hWLiTNPe8EoG4dpDegjNyWe0+98OHec/8txYsgj?=
 =?us-ascii?Q?FWjJaOiZnyFGrbMGGYTtVb4+Xh7ee5LLv9nGpi3m594KvQXaIa0f4Ot51rl6?=
 =?us-ascii?Q?kQ974dzwTmnqKaLWpRUVB2MAVXZf779w4VuJadoabTS8IG8Ujfw056hAXRcv?=
 =?us-ascii?Q?OZ8X2GpFwv6elbEoL1Ky2Oko/l9WmRUOaXKRDdK8JOX0Ao+VmHsBa73pEYcx?=
 =?us-ascii?Q?sRVhGZX8sdNhMq7DMcLIojVMO4CkzuHflyeDAmoXED/qN0enaz3dOSioEfT4?=
 =?us-ascii?Q?mm0RDa4yEVaeWVJg8IZCP6fCZy5wPE2FJijz46x2coVp259xSC1u0bqhOqN+?=
 =?us-ascii?Q?YHjNCZfydVpXx5kE3PKznqEWSLPRKqoG5SYGkGJu7blEarOzui6m1pX14jqU?=
 =?us-ascii?Q?JnMGmTG79ESNPfw4HyvLvF6PJmRed1TorDxJ+JMWMw2A1dmSwvzm+Li7hNQD?=
 =?us-ascii?Q?jnvhsSb0FdXBWP+TG4ngEo9zmFm+QfhxwvnvA416s9ym+Zl3G/eSC+SiXqjy?=
 =?us-ascii?Q?3xR06W2B3Bz68ETh+rdEhhWCnS4Ar/gtnsHC+HiZONzxLEhRm3zISh0IMMv5?=
 =?us-ascii?Q?J/DOPgd1/LvgFFGL/m/lzXQ2vrXHtKIaW/Mvi9s6tLXPLsP1pIq41SzT0MQF?=
 =?us-ascii?Q?UfwXhGheLNVbUBfjOduEZqfAuJg5yT/+tIEqmI/aXrsxCXY1GSWt3pKqjKtG?=
 =?us-ascii?Q?ELHOozc7o+AevPWgL5zaVoQO94WVLFI70J08C1zxnCCeBfG5GwY9+9xgbrsQ?=
 =?us-ascii?Q?g7ufJoNdvmZAeHeMoQf9fi5e7W34UBCWGH10JkuJuokVpOZk+mMW2c3D0K+/?=
 =?us-ascii?Q?sFEJaaz5TsGcYJekGzKIBxODNPT1+8KWu1ORKKsAGgnupwSE3Ifi5+LpcZJB?=
 =?us-ascii?Q?QIG3yhH+L6a3d1GKc4TlHlFa7xVReLLT8i7V3ZjHxi47kKlAmqc80Ed5eraW?=
 =?us-ascii?Q?BylmYiPBoIREXHZQi8MwjHxdw+l/K65lfRpbfsCWGtaCDmqVC6Kx4XDro5U7?=
 =?us-ascii?Q?IYYB7Y6qRaPYDxVCAbXgTG5lVV34zd0G5IIs90q11X40z0XXVONke6Wc9g9p?=
 =?us-ascii?Q?72WDCJqP28K5680KoBkEii6/KY3cBnWiPP91haqJs9D6ODDuYZIul1Z2j+Et?=
 =?us-ascii?Q?7vUmi4pWXSEJT20nNjRcXqQEAAo/xWohIbwv2SSBhxuHBRjMuGrfpI00sGcT?=
 =?us-ascii?Q?wholCHtXqgedMVuK45UmwHtq?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?onH/qWrsFWI+1UaEzehrRjb99CQgmE/KTtfOFdSSRpF7OnatxAzU95Zsuicm?=
 =?us-ascii?Q?LQJAigxwGjCPthBetM7kEvLGCRkjUzEnqN9w8o2FgfUZRTDj8mCJTtW4kbWs?=
 =?us-ascii?Q?PY0pDE0rippL13kJ9i0f8gFe6rqVmHIH76lXu243/d+qA0iJxKk2NO+keeYP?=
 =?us-ascii?Q?/ZfN/gwE+l9vyQpf0Ir0nfMQEFHQOHk+JMauAWg/ii7Snew6W4cDGaAejJDA?=
 =?us-ascii?Q?eYSxcYBj9DKf36PLcQ6NYZy+J5eoVgGZFRN/KIRqb5CnH5qtSFZsQg/M3TcL?=
 =?us-ascii?Q?je8Q7/ciIuc7fKkDbWHq5NNwTIhJVasehsh+7zE4u7rAkXTBCc9GusrTXES5?=
 =?us-ascii?Q?FIM20vMSK6xivAD3sE5Fj4GVtEKAufA+hm1nCQtFC1gProFK+eX94K2lcW5G?=
 =?us-ascii?Q?zgcBjENKChRrRXac/cuLAsb3VyA8HQGGIqwCXoU8gkuGNLOEgPh/nSVtK1h0?=
 =?us-ascii?Q?lZAhx/lmPzgnc0XA6+0kTl28bszTJO8dosFnpODOTZmeZDSCFlS1UEmpKrgq?=
 =?us-ascii?Q?aDaeRD34xlWcD/47sZrOp6ZV0O4Q10UBMD7zvBMOBFtdp2iItCmzZYwg4+qZ?=
 =?us-ascii?Q?ew0TDEjYFbG96yyJLXPQed6FbFt8wV0Cm/nndfhBZcIL9ZpPVzZ65L83YRzz?=
 =?us-ascii?Q?yijzwy6YDQtA/AeRfufhPPPU7xp+luByfnFhoPH3zrk5T8IVt64SOu9PPiW8?=
 =?us-ascii?Q?SRMpyKNmmXRjbpPl/KonOP2tWqHvLZgGOOcIqwK5RO4PWkY5QwZAAz9YrGLR?=
 =?us-ascii?Q?bbMITnoPcZcR4biRe8LJ6n7Su/Y2el7/HnUG/2TGjlw2+6JmflStlilRezcg?=
 =?us-ascii?Q?mBU+nO5gQtJLKS7c48mqw4pNEDNc64gkA14t592GY4mUXxJYGir9doIZnsmf?=
 =?us-ascii?Q?vYsQX+8QqxgCjYCd9+a1Y8K70bFQthI0Kz2oMKhuaNGl46x4Vi02U/JQrzwM?=
 =?us-ascii?Q?jDpD+AQvxl+xzO64HQPMVlPujokYESMPDo4FWpIGD/hj4Hbe1b0FviBGdhuF?=
 =?us-ascii?Q?3liSKTdBFwvyEMwbvhhbJM5x+kcqn86jcKNssZP1tZKl2/fhUA9jNhIbGoQW?=
 =?us-ascii?Q?3agiXyca6JJ+GD1lsbqQ4BR+OFSxCVZNROIZbP5GPtNAGFoHfa5CS+OOU/RY?=
 =?us-ascii?Q?T//BL0NrCOzKNimWGegHTLlqbxGQQXBKF9v0Dz7f3WKYQwehoFlWrpBJaYnf?=
 =?us-ascii?Q?cQUSo5hks/22bci5r7Pwyv6ygWANbVRzMaXrzwSOtrp5x61kbDiePg0P0vo?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2a5ad6-abee-42ab-b3bb-08ddb8155e32
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 20:33:27.0160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7885

From: Stuart Hayes <stuart.w.hayes@gmail.com> Sent: Wednesday, June 25, 202=
5 1:19 PM
>=20
> This adds the ability for the kernel to shutdown devices asynchronously.
>=20
> Only devices with drivers that enable it are shut down asynchronously.
>=20
> This can dramatically reduce system shutdown/reboot time on systems that
> have multiple devices that take many seconds to shut down (like certain
> NVMe drives). On one system tested, the shutdown time went from 11 minute=
s
> without this patch to 55 seconds with the patch.

I've tested this version and all looks good. I did the same tests that I di=
d
with v9 [1], running in a VM in the Azure cloud. The 2 NVMe devices are
shutdown in parallel, gaining about 110 milliseconds, and there were no
slowdowns as seen in v9. The net gain was ~100 ms.

I also tested a local Hyper-V VM that does not have any NVMe devices.
The shutdown timings with and without this patch set are pretty much
the same, which was not the case with v9.

I did not repeat the more detailed debugging from v9 as reported
here [2], since there is no unexpected slowness with v10.

For the series,

Tested-by: Michael Kelley <mhklinux@outlook.com>

[1] https://lore.kernel.org/lkml/BN7PR02MB41480DE777B9C224F3C2DF43D4792@BN7=
PR02MB4148.namprd02.prod.outlook.com/
[2] https://lore.kernel.org/lkml/SN6PR02MB41571E2DD410D09CE7494B38D4402@SN6=
PR02MB4157.namprd02.prod.outlook.com/

>=20
> Changes from V9:
>=20
> Address resource and timing issues when spawning a unique async thread
> for every device during shutdown:
>   * Make the asynchronous threads able to shut down multiple devices,
>     instead of spawning a unique thread for every device.
>   * Modify core kernel async code with a custom wake function so it
>     doesn't wake up threads waiting to synchronize every time the cookie
>     changes
>=20
> Changes from V8:
>=20
> Deal with shutdown hangs resulting when a parent/supplier device is
>   later in the devices_kset list than its children/consumers:
>   * Ignore sync_state_only devlinks for shutdown dependencies
>   * Ignore shutdown_after for devices that don't want async shutdown
>   * Add a sanity check to revert to sync shutdown for any device that
>     would otherwise wait for a child/consumer shutdown that hasn't
>     already been scheduled
>=20
> Changes from V7:
>=20
> Do not expose driver async_shutdown_enable in sysfs.
> Wrapped a long line.
>=20
> Changes from V6:
>=20
> Removed a sysfs attribute that allowed the async device shutdown to be
> "on" (with driver opt-out), "safe" (driver opt-in), or "off"... what was
> previously "safe" is now the only behavior, so drivers now only need to
> have the option to enable or disable async shutdown.
>=20
> Changes from V5:
>=20
> Separated into multiple patches to make review easier.
> Reworked some code to make it more readable
> Made devices wait for consumers to shut down, not just children
>   (suggested by David Jeffery)
>=20
> Changes from V4:
>=20
> Change code to use cookies for synchronization rather than async domains
> Allow async shutdown to be disabled via sysfs, and allow driver opt-in or
>   opt-out of async shutdown (when not disabled), with ability to control
>   driver opt-in/opt-out via sysfs
>=20
> Changes from V3:
>=20
> Bug fix (used "parent" not "dev->parent" in device_shutdown)
>=20
> Changes from V2:
>=20
> Removed recursive functions to schedule children to be shutdown before
>   parents, since existing device_shutdown loop will already do this
>=20
> Changes from V1:
>=20
> Rewritten using kernel async code (suggested by Lukas Wunner)
>=20
> David Jeffery (1):
>   kernel/async: streamline cookie synchronization
>=20
> Stuart Hayes (4):
>   driver core: don't always lock parent in shutdown
>   driver core: separate function to shutdown one device
>   driver core: shut down devices asynchronously
>   nvme-pci: Make driver prefer asynchronous shutdown
>=20
>  drivers/base/base.h           |   8 ++
>  drivers/base/core.c           | 210 +++++++++++++++++++++++++++++-----
>  drivers/nvme/host/pci.c       |   1 +
>  include/linux/device/driver.h |   2 +
>  kernel/async.c                |  42 ++++++-
>  5 files changed, 236 insertions(+), 27 deletions(-)
>=20
> --
> 2.39.3
>=20


