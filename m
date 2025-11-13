Return-Path: <linux-kernel+bounces-899308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B057CC575A6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5068B344F37
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218AB34D913;
	Thu, 13 Nov 2025 12:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f2kky85F"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012033.outbound.protection.outlook.com [40.93.195.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455AA2EA470;
	Thu, 13 Nov 2025 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036109; cv=fail; b=Vco0T4F68pIETFc5thw9Fq6H1M9wW5uJbVLtXlidFSPlUKj6WjGIrTSnv3u8bY5YRpPxfhCLK72Pv9HNAmYA9SlFutlQ7wLVS/Jq87pdbEfNL1v/YnF2fcErdSDBRNZ52U/tpLKWKeBockkAQwpisdis9zLKroPhTrvXxzWXrn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036109; c=relaxed/simple;
	bh=/+jZlzx/QfmNjnSGbO+grUfslORX52XMktO1fosd77s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gyfa6RDgBVvmgU653HEpkICEi8wbbs358xRQ+VqQdv2tMjAWrximR1zAWisUbVCDeNMk+VFyCOgLLYNAJiESi1IO/IQhlyIJa5dvnbE1utoR/8dWHoXWKW/RAHxRXHxdKZ7oGrRoyro4gSJOTY/SS5Q3fr2rLeopZy4zUIuPSSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f2kky85F; arc=fail smtp.client-ip=40.93.195.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ervb7l2Hse0FTKr0qgBGa2wBHqWtYPPBlqtcJh0bMX9JW9fex9J4DQauXKTIja8v0bEhh0XiVpkBGNQc5yovHiBkjO+ezsRnIrtFlHfQMqGUHYfzqz0TLz8g/917f4KXOUnMsTJbfaXTvI8sFdOwP2MvSESddQLqUosbITZlrcmrg1RLAx7b4AxhS9Zwc8Ay6zPsZg/7MxaJj9Y7ZrcrkPR0YY6dadOK+ywdJkXlSu3BipNJav3irkBz85RR4fl/eXngjpVghdZOYfn8apP2uenkisJHWT8dFXYHm5OqAJpO2Te5Gl1lDL7rYS75zuFTxWuaRtP3U/EnFZh51gH8mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kni+uprTvh4HbnOvPSWuU/+R6LdqI9scCjXvyN/5gVI=;
 b=A96uMaSTVYcXfCOYqdTr6RsJlrMkPd+gd41X54OQuxqiiQD10aTv4lgyFo5UFtah91Xek0DCNqZ1g+dqGaBlcaMhXW/PL/yqLRAUoLxA91qIJvRuwqeanUEqyyjHwUx5RiNDAhtvovkyOksBjehzD+cCjFvPHX3+XidxqAPoeaCyaLIJ2qqkF6mVuAzOE29QMrs8NSQoG4xN6N3/m0pzhbBG4iJKi0O6OAa8HNBj5KVqni/AfkRMrXG7CKFmiR8Zq/xqFaIqhAXTULj9St9529iJuUZWkze4HOspJDP1Vm6Gdx5ewM1p4yyi7hjLOsRDoKAz6Xuwx/U/z4xzxarDOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kni+uprTvh4HbnOvPSWuU/+R6LdqI9scCjXvyN/5gVI=;
 b=f2kky85FlUpUxepTpICTD3kLWOTBoCXpWKHL/5FrSNqLmzLP6TCaZMOuYTXsiJ4kzzrOUSLHBo1hi4HE2ZySfjMpKlNkV3VULGs/St9R75Of9Vt2iXDkpKIcceNrPxObjlXoV3keyIjCEH4af71oqy3pM5JPghMDZqcA4W7P3RY=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Thu, 13 Nov
 2025 12:15:02 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 12:15:02 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Conor Dooley <conor@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH] dt-bindings: usb: dwc3-xilinx: Describe the reset
 constraint for the versal platform
Thread-Topic: [PATCH] dt-bindings: usb: dwc3-xilinx: Describe the reset
 constraint for the versal platform
Thread-Index: AQHcU+zDcCWaPQULXkSxJV7QRsA8c7TvZ26AgAEcEiA=
Date: Thu, 13 Nov 2025 12:15:02 +0000
Message-ID:
 <MN0PR12MB59537C0F520B40977620BFCDB7CDA@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20251112155430.1326426-1-radhey.shyam.pandey@amd.com>
 <20251112-bagging-diameter-4ebab1f9ed45@spud>
In-Reply-To: <20251112-bagging-diameter-4ebab1f9ed45@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-11-13T12:04:44.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|IA1PR12MB7712:EE_
x-ms-office365-filtering-correlation-id: 3a260c1b-9a15-4e10-dcba-08de22ae45e6
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?I+CBIQV+uDa92p9qUvMITFbQ6gM1EgjBUgwVS0aBZ9ecqSBqJAfBNQfDZYbn?=
 =?us-ascii?Q?z4mHX/XppjMRg6SZ5FU5rVuxu6/OtqrnRBhsPxYmFTyTwf8DCeHg3c1MrFqO?=
 =?us-ascii?Q?ZxTZvzVzZMzTza3Kkfkr7i4ZpxBgaCwjlQKcBjBieFPG5uJpCs9wgIlkuWEF?=
 =?us-ascii?Q?X0ELznjsuXj/NGjAIox2A73reCsOLwQgglBkmo5jlPeg1xSULNB0OnMxw0np?=
 =?us-ascii?Q?ldsmxh6ZNko6pXeNfT2sLQ/kNi2irJCTOoobLNc44DGlv8KNKDIr2F1XhnoU?=
 =?us-ascii?Q?Xz7Tyyba9QS3n9VRkP47T/l379bP2xBqYKTrftH84n6UsvcBLgtgQ1uDQzPN?=
 =?us-ascii?Q?BG35qutbtXoQd4Sv++6wcZKMsk4vH9tfDYcezPoGwhQpDieOYWY6fz5IV1IF?=
 =?us-ascii?Q?dTXmK3m38LTYbVHJdctjaatdX8JskdnLzFWiM56aWfsn4MxQQMDSIx+XaS/v?=
 =?us-ascii?Q?uPtIh0NAzvPKV4hDEMcQKDq/GeJB0dBRvpXGRSsqnYeCUK0ewzPPjtZwl56u?=
 =?us-ascii?Q?6jvvOcFF8CZos1sSfkYb+xU7s3Xln1AfwqfV5+8jYexnYOWPcUy9OUnHHUB/?=
 =?us-ascii?Q?nPm87YAJnaSMGCsqXY9nnOpNrneYNZlXA5WXtmAYdyfH5yh7mdLuD54cJYbw?=
 =?us-ascii?Q?eu5n3DihHwN0hxxBDR0s0xzsGTBor0usItTI+fUDwUkOOTuUIZXLxc08unv6?=
 =?us-ascii?Q?Q5olQtVQedCYXXRgg9e6uFhPyhEXG1Dik9f0aIY7KXkAZ8gTvNei/yItntum?=
 =?us-ascii?Q?Gnav7JmjhbQcmuphFWIoRdCKwnmltaRU9UGPl55eCzVMUrFmUJHpAz0XxI40?=
 =?us-ascii?Q?Q5H4RS97pbsL2O84y2ajspNh3SiQV+bMFAQGJJzaHtzjEICnymw20J8imoYD?=
 =?us-ascii?Q?ud4gSKSTzWXrabvaKBreeW5heZusbcLbym7F69DVP35XpBUpjDZDr7T/D7NR?=
 =?us-ascii?Q?BmUDRMACI8MTi2n+6G/2SDtSxlqKjtcxL0xQNPW4izBET7CcyfJVkKyyLnsq?=
 =?us-ascii?Q?T5exUNQeLf4U1Ji7FjlYXwhwtWSTKU/1n8jBccf5AvERSOl0GeDSg8MV1GXF?=
 =?us-ascii?Q?TFPYytcEZ4pLk788vOUREa1r3MrFl3L5avUWNYYp7MKUci5dzz5+gA8I8x8O?=
 =?us-ascii?Q?+THCBRCKVe/4fZCrXHpCRyU5zIS1eL0DXo+f8y26LXO0nBS1niXMlsMQL7Fu?=
 =?us-ascii?Q?FpZ0VHdLdgeM++wqy1YcWr4h7qAdBkZ4w+HPAeTm9hnvs5aaxOoN50bVDUcw?=
 =?us-ascii?Q?A87rl138z1csmd2GnLg48MIQMwZ9JgJ8F1ijFKa9V9EYiJcNNT3epSW+F38W?=
 =?us-ascii?Q?uBgCabvmmq/21BPqm+DSsj49A/4xat5pScYevE6JQdGPA+nMRj7T0nvaG9Ds?=
 =?us-ascii?Q?SckIYsZ1qP96sQtIMRN1kNRAEiDVq50ElG1Ek6Tg+mK4dYUMbdTT7XD4GDEO?=
 =?us-ascii?Q?eiEy+dOahwJfzRTXmGv8ngtfacJT0wYLklZzT/8wXugi1KXJnpVsF7wYMwiG?=
 =?us-ascii?Q?DnjJKtQIYC0BFZWs4nJge+xtDiXR9mshAlZQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?s9KPBxiWl6k1rf13Ywxj5OEKyw3U8SMs70a/mqc9fy7TdrmMxAstBmLT0i5O?=
 =?us-ascii?Q?3wnc489f/N1ueeuxqvDP0SQWxLq/cQNAXNn4fn37Nk8HMHqljbINHECidUiJ?=
 =?us-ascii?Q?lbOng+Dq/VUWn3BkXdGwKMh8frozzIODd/RypyNd5mVIrC2yi3m3qBu9QuD8?=
 =?us-ascii?Q?qBFhFCOrMt6ObU5rd8iKqNWHuR8opzziUnzHN/FM+z/9Lbz5sjIwki3nOEi9?=
 =?us-ascii?Q?+HeL5ZhL/pwATQLreU9GJPKcJq/ltryUXEvSJ1XvHXuBeEQQCuzvXi/6eRc+?=
 =?us-ascii?Q?pKkYF3iU52Lj7RPhNIQOeOJzoNbEL1nh077rPA9fHjUm0oh/jFXImS1L1kLx?=
 =?us-ascii?Q?6O7hFKQDDhs1bPt9/+kO6YXzRkQkv6oxLIJlyXSQjw3mLaakPEgr6mUovQop?=
 =?us-ascii?Q?74dfwOInON0FykIRPvAyJhuuolbyTnhz26+q6C/PucvgjrXh1Eky+aozFuGU?=
 =?us-ascii?Q?sFI4g7mYdhQKC9SHR6gyocRr1Jyo7qWlyZSvOq1EuCcsIWlU5aTYfr6kKD7Q?=
 =?us-ascii?Q?fJq/m1BWPfCzLlO+Rqgm9/n1Ttfh3voGA141TC2YdoNMn0QafLcxdmP8t2Cg?=
 =?us-ascii?Q?8aWtrKNuw/8GnNrB/qywpbADHxHI8C4kO1D3w8H5mCef6fOxP9iEE8wi5Nk9?=
 =?us-ascii?Q?vVkaUoccEJaqSt5Vl/9GZV/Dg7i9cqMrOVqgLhwRLYA7nTuX0bAyEszkSazu?=
 =?us-ascii?Q?meqP6gdoBMpi6Ec3DPRZPjvBqMNSLAuO85wbw5Y+1wDFLTMEFDlAzvOhnSLE?=
 =?us-ascii?Q?sf2h1b/1j8lQqhcjTK82YQNcxPg9sb9XBIhWZteFQDVvrTiklfu0QhGc+AIQ?=
 =?us-ascii?Q?WadPlngsNKy26ZU6YjLcEnXX3+u7tk44cYYi6fiUOHEyvIO7ZV+a7pmh74qI?=
 =?us-ascii?Q?tTG/caZn0xpVvIfyA+RX9Xz+Us2AUqIOwWlBWET1wm7z4BFlGqn12BCsYDcm?=
 =?us-ascii?Q?uk8Omd0Dwa8iV+4hcatto45jHkyM2eN7oyI+RpW93f1Q1ZU+vlv9gc+p7DxS?=
 =?us-ascii?Q?5MvZYyWyABiwiCMs0qB0tUi8zF0lHiB6qXNyIlj5BFU0jQ9hmnQaFy91sb0R?=
 =?us-ascii?Q?yuCq/2gBZrmW3XnUIm7w4pPYL2lgqnMj8XBgZ7pzMIqeRsAtc0Vpoxgtqzu1?=
 =?us-ascii?Q?GAdAmRfMIC9dW8yUz5uOkJ7uh6+V5n1Fcxoi4pPrcj4R7r7yfOXewnldyicX?=
 =?us-ascii?Q?5bAeybgpSBPc2Ztxs98ugy7OAQ35WzI9Vvk214/QuTAGyBYMJtXxslHv6DVw?=
 =?us-ascii?Q?aeP0Q3tAZ7JRTl7kBYDU0lMYrKoNzqI1yT9tDkuzMxXlxx1KqM6g3ZlXcBf7?=
 =?us-ascii?Q?z2rA2/ylk/0+/I0pDw1uaNQVa4PjIAqwdPAb+QDkcFy4RX5Myoka+S0xmRyO?=
 =?us-ascii?Q?zv75bTkXrZeYlnQWx2b9y4nzTUcslbDBxXFaVYtLvUglP9dx7rsH5OLPJ4uf?=
 =?us-ascii?Q?yeNn9TXyx0JB+hG+QzVEEqmt9x80Bcx4x2C6+OnpS6R/EVOyY9oAdXACik4N?=
 =?us-ascii?Q?cUPjYXFQV3+JxD74KuSJaTXBZX64NfbX1nw+FdLQc2gyx+aa5ljYDPnvVDNx?=
 =?us-ascii?Q?7/e/1ZfAgRyVkG/FNkE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a260c1b-9a15-4e10-dcba-08de22ae45e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 12:15:02.5214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JEoPRS20qn9U2Zs4fx7cri9jIkU/4+3epyHg0lPUL1kECL28cN9mbgZLvtsQI/XN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712

[Public]

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Thursday, November 13, 2025 12:38 AM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Cc: gregkh@linuxfoundation.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; Simek, Michal <michal.simek@amd.com>; linux-
> usb@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git (AMD-Xilinx=
)
> <git@amd.com>
> Subject: Re: [PATCH] dt-bindings: usb: dwc3-xilinx: Describe the reset co=
nstraint for
> the versal platform
>
> On Wed, Nov 12, 2025 at 09:24:30PM +0530, Radhey Shyam Pandey wrote:
> > AMD Versal platform USB 2.0 IP controller receives one reset input
> > from the SoC controlled by the CRL.RST_USB [RESET] register so
> > accordingly describe reset constraints.
> >
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > ---
> >  .../devicetree/bindings/usb/dwc3-xilinx.yaml  | 43
> > +++++++++++++++----
> >  1 file changed, 34 insertions(+), 9 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> > b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> > index 36f5c644d959..cd0cc9da242f 100644
> > --- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> > +++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> > @@ -50,17 +50,22 @@ properties:
> >      description:
> >        A list of phandles for resets listed in reset-names.
> >
> > -    items:
> > -      - description: USB core reset
> > -      - description: USB hibernation reset
> > -      - description: USB APB reset
> > +    oneOf:
> > +      - items:
> > +          - description: USB controller reset
> > +      - items:
> > +          - description: USB core reset
> > +          - description: USB hibernation reset
> > +          - description: USB APB reset
> >
> >    reset-names:
> > -    items:
> > -      - const: usb_crst
> > -      - const: usb_hibrst
> > -      - const: usb_apbrst
> > -
> > +    oneOf:
> > +      - items:
> > +          - const: usb_crst
>
> Why do we need all this oneOf stuff if both have the same first reset?
> Can't you just set minItems: 1?

Thanks. I have now set minItems:1 and defined compatible based
reset min/max constraints. Doing some more validation and
will send out the v2.

Example:
--- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
@@ -47,6 +47,7 @@ properties:
       - const: ref_clk

   resets:
+    minItems: 1
     description:
       A list of phandles for resets listed in reset-names.

@@ -56,6 +57,7 @@ properties:
       - description: USB APB reset

   reset-names:
+    minItems: 1
     items:
       - const: usb_crst
       - const: usb_hibrst
@@ -95,6 +97,28 @@ required:
   - resets
   - reset-names

+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - xlnx,versal-dwc3
+    then:
+      properties:
+        resets:
+          maxItems: 1
+        reset-names:
+          maxItems: 1
+    else:
+      properties:
+        resets:
+          minItems: 3
+          maxItems: 3
+        reset-names:
+          minItems: 3
+          maxItems: 3
+

>
> > +      - items:
> > +          - const: usb_crst
> > +          - const: usb_hibrst
> > +          - const: usb_apbrst
> >    phys:
> >      minItems: 1
> >      maxItems: 2
> > @@ -95,6 +100,26 @@ required:
> >    - resets
> >    - reset-names
> >
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - xlnx,versal-dwc3
> > +    then:
> > +      properties:
> > +        resets:
> > +          maxItems: 1
> > +        reset-names:
> > +          maxItems: 1
> > +    else:
> > +      properties:
> > +        resets:
> > +          minItems: 3
> > +        reset-names:
> > +          minItems: 3
> > +
> >  additionalProperties: false
> >
> >  examples:
> >
> > base-commit: b179ce312bafcb8c68dc718e015aee79b7939ff0
> > --
> > 2.34.1
> >

