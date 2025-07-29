Return-Path: <linux-kernel+bounces-749817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E82F5B15333
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847B01882734
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD6624DD17;
	Tue, 29 Jul 2025 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G9aDuOBE"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB04B1F4CB6;
	Tue, 29 Jul 2025 18:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753815543; cv=fail; b=Z2Tg2kv/ahGeeqhgl4Df83tRyV+MrhdCqz8kaHRaIPsZXfZAkSn3aCyaI/hZW7K8V9ZBOTmqC2cSZkvdVTTZ31VH+iW+xfDeDF523cKEOw5qebr7O7WGWzRUECDLlUlm8SofzHt84jQ6oBIjmuWt3W71PR7hZtIYUtP8Tgx5eGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753815543; c=relaxed/simple;
	bh=NQ2suYyNXpfMkbtvhiaSr2wDZ6A9ybGRYl3VtbDv4+U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lW6N4JH2a95SpxdDTFGZXyO7Y6SkFJhuBks/iEyQv0DC7ZdETZCBuLaTkerugqSK+re6J1Wm0HGEDEv+UbiH/4lJ8iB1ohBHgILHcAyF4hhNMuyH140F1VR1JP8BfBpm1zsMeqtOheILesVpkt0ZYx5AL14rI/GEA5qRu/ri5fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G9aDuOBE; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3eCJdWSLK8APWEZaVbvM3fNYYcAX5m9yej5r3JkIffmPMYu+dOk25FMenBrMkvqVZwbwHFXw97EvVUyz70jfHHvSihsJxxnelCSKPY+NdX5kR4/TZSVphzzu/w/65VknzW1+LI1ZBqe7ls06nQcLxP+Xm20SjlKjJfXdoMT/1Xb/qDKfvWbnPryzbSnHVd7fKK/AVCN53hqyBJPXB8h3CKTw+JeVgjCTC3XrwNrEXnoA2urgodEt+acrs23US/nkDzmtWFZfC+0ZabPBgL51l94V7h5Y8g/6FF3Byvn1OV2o8IgBguqaE0JC1xAVehw0v9nBFS3qt8D6WrOTO7Aww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwzNhEfAQmy+G3Od6Oy87+enaRQWD3uctYEpPruI1x4=;
 b=IfoInAdoZPezwYjbKbfEI8ryn90rWi3J7JEkJMSgLgUELrwR9jJ3+y30oetiUShf59gfopON5pMiFErmxgkOd4l7dJvd95H/EdLp+dhoiEhz22sRonG360UtS/theVNpywFaOKrUrMLv+DDJ3JdKYPLPIwvpvhbWURm1K+qQ0x8f4O/pmOWcUf8erj9gjDVdoaX4lc/Wi6aFKfO7sGJWuUkV0xV7mHi6UDJou3nJP8CfhmaLmV0FQSDppwEULSwPLeYsFOlwTgUyeUd4dDXFfvIgXfdc2K2cXk8MpICHN2xKnS5KrhM2eO2Z1g4rdf6MM/X+HoESkl3vn/KFK0tpGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwzNhEfAQmy+G3Od6Oy87+enaRQWD3uctYEpPruI1x4=;
 b=G9aDuOBEBc+1wBXCeQ3KYAF/Wc3HNTZokW6GKC5ne+f/nJIXI0sfzOrLKEGErUgeY+yblevqnYqBj/x4W/ElSaSgBZTNyd8swJ5yKG8CD4Ql8vEbKeecwCe+f0AfRFNYWP3oI/qGrbupEaVdrOWGdxrr0wwSXCpGEy+KHWEQTDw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CY8PR12MB8299.namprd12.prod.outlook.com (2603:10b6:930:6c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 18:58:59 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.8964.023; Tue, 29 Jul 2025
 18:58:59 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Yunshui Jiang <jiangyunshui@kylinos.cn>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "chriistian.koenig@amd.com" <chriistian.koenig@amd.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"willy@infradead.org" <willy@infradead.org>
Subject: RE: [PATCH v2] drm/amdgpu: use kmalloc_array() instead of kmalloc()
Thread-Topic: [PATCH v2] drm/amdgpu: use kmalloc_array() instead of kmalloc()
Thread-Index: AQHb/GRvSIf599cjs0WfIsjWFyqzsrRJfH7w
Date: Tue, 29 Jul 2025 18:58:58 +0000
Message-ID:
 <BL1PR12MB5144C8E5EA47A1B65530E71CF725A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250724062951.328081-1-jiangyunshui@kylinos.cn>
In-Reply-To: <20250724062951.328081-1-jiangyunshui@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-29T18:58:41.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CY8PR12MB8299:EE_
x-ms-office365-filtering-correlation-id: 9014cad9-43a9-4dc2-f0da-08ddced1f9ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lnv9WA4xXchAp7Izpar7AutyDUByCcuLhRutkMkGKjwe2Y1GQwRmKtBsbfKf?=
 =?us-ascii?Q?F2QtbghIy5peXs9zpHPtGf8gXkUwPryfmm2H/W+RjfDNGeE1x1IXjkqSwrWq?=
 =?us-ascii?Q?94Dir5cfltDL1keW2tIdu2t4lL7ikTT7ssUI0wxlZ/6pXaL9tspVdPhlV+ip?=
 =?us-ascii?Q?d9IGFRYshgc9iLfEY1fcgVY8i8RXL10PpBPUAyW9BJiyRxY8L2N1slwj5FJU?=
 =?us-ascii?Q?DcjqD2oV1o3Fbevmzj8IGb/Q59ZOmi3w/0kNnTzTKguVAZgq67RHFtSuRiFh?=
 =?us-ascii?Q?i8pT2tLagLfIFcO+5++llJ7fol60DTIYhsGBtvYmyeSEzyKaCyVM4d8ZIeRS?=
 =?us-ascii?Q?pduLyAcdKVyqrQK0mRi4LhX0RWnf5xlUs9+zbcenyNNxE+Kf2rZZJXcVN7WW?=
 =?us-ascii?Q?6YZhvalMS3VNqQzCUUX2LimphnF3JkRVc3eZrwNZaPtbRNxgdOYV7gsbvKx8?=
 =?us-ascii?Q?DrHzV3iVUerwGiQwiWrU7QQ0jSfU1cpzSKg/kT7haKfcNbEg0F//ap3eXWwF?=
 =?us-ascii?Q?e+O4wPmi8M7zaGVXwHQR6GUcVdd0vgVzUtv8Ym0lJA0ZXC5fNPdamX4TSU+7?=
 =?us-ascii?Q?DIz4adu3NafxyBjdZU9D8sPrvRHQWdIAtRbyBxPgcAdTQE2Qi6n6RDgK7/xj?=
 =?us-ascii?Q?PSPny3JndzXHXXpsrY0iZC8X7IYzdu0bkbTtStvWlTevLHXYZjwiAdO8LLxz?=
 =?us-ascii?Q?gOjVmqAVGneeBXZwHerBy/zSklYEXXqy9M/Gy58H9jFfF3I85N9YqsLE9Aei?=
 =?us-ascii?Q?0jOpXLj8rgxphZF6nJ4AefMFQrvEKQ/JKhTljgAtmIf7o3wisXWsoybZpFR7?=
 =?us-ascii?Q?QtR2SE6JAMKo10EbyDiqYdDei1AR4wHxWW3YS2P2Lmrebo95RJPQblYo4KD3?=
 =?us-ascii?Q?9evLoxih/cMet7qhtCRd0lz5Pb1RMcc1cqquvB72H1tQME6Wf/4kehmtjygW?=
 =?us-ascii?Q?DQMkEv8cLHwmoMMvwH7frEqoitDcp6TtD9ZVms7ayp11xFtI2jkpzxPtiO7X?=
 =?us-ascii?Q?XrLAhOqnW18ildvcOZ2ye88VJEJFh1Fd8RE6AcaVOJ+QN2Z69+69c7heQ7iW?=
 =?us-ascii?Q?n80nGwINxVrcqilA6VN3gXfhKey0PiBKffIBuyo8bH4YL2T0WSBFR+UikbWu?=
 =?us-ascii?Q?jkJJNY49onPXdHpKcSgKneIvufYA3ERduzetSPhVCZQJLra7BxnrmRBCGAHP?=
 =?us-ascii?Q?gZ+zQz1sbQ9YoN05Mlq5gkfN27c7xFazh3mvJJxyixBHHkjR9rSrlD6ZOciU?=
 =?us-ascii?Q?6CmBHGFNmMQTmZLrdKoJjfGA6qypEEzi9jYuDCakTdJcoYi4pM8TGHem7zSo?=
 =?us-ascii?Q?HfLnmiyFeS5wmPwn3c36BGsaF+/mj0jIZ3CWM5LwbDxrWSr1frzLcj9kzsf3?=
 =?us-ascii?Q?bMYDxgzerYU5b5WGnCcYU+KiQFvZlQx6grQr2TH1DvS4EKE4tKEPhBkexDOC?=
 =?us-ascii?Q?KDrFb0niFQJofEl9rwQ/0sB3O391bB/g9nK+x9IJ7BSspsKsK6lomw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?X9VAQQ7kkNQjQqIgg8YwJPCcoQ60CZz8gNxbMq0eAvjZ9zeOiiATIMGn48cn?=
 =?us-ascii?Q?/200vax6Wa+gDH2SRkKes/Y/5tMDxjniHPEj3mlqA10ajPCmD5JQgeio7ONg?=
 =?us-ascii?Q?6FEdqgBesvTLPkl+4JajcfUDRh825NY4EpUWwOnhpRfruN1JxdIeU4obKbmu?=
 =?us-ascii?Q?yU/3+IXXKCAa5JnlIwXTRmQ9KmK6heva+hWmQR/ytav6YwD9a9ik6soTmArH?=
 =?us-ascii?Q?GkMZmqAtJ/4cPia9qTR1PHTrBHXxMq4xYQR+mvBe0JRoRB8PJjobPxFb8i6r?=
 =?us-ascii?Q?DTPx1As1TL5WQSWRwEXuUMH8jp4nz1u07PJML+IDcoLGH3ys2YGrx7klGT9m?=
 =?us-ascii?Q?vaCxdOND2iZ5rcYG3zTJesyaem9G6kNsg/+pc5iuYreXT50M36AXNVODvQ3f?=
 =?us-ascii?Q?k8EhrCm4tDg21mz6uMUZLMeZ9kqlsKMZbDln0+RakMkiK4JHZIbSCj41XchS?=
 =?us-ascii?Q?KKUEp6j30z605X2ilwbid0rD9p9KdcSkBrNhx6N/ueNc7ci1Lmk19MMR+Ssj?=
 =?us-ascii?Q?YtzRvQzGCANXtN69fOzXOtKWN/RcQ3zHNWTs99T0lVynleiDAEw7Rhug3Ibb?=
 =?us-ascii?Q?kPBZgJiY5eSp0BZ0kLvdGCkpXD0QGOSXnVubWLyhO62u2TUbpluKq8Fh738Y?=
 =?us-ascii?Q?eyfDQjb++4B/OaXfZ0jn8/JIlQ5PzVU3yIwk6xg/aYSaxOonsnVmd7HF3e9Z?=
 =?us-ascii?Q?fo78SkGW4dKwTWXBvSNEMWLNr1fY8cFtwvZOf0qaQnXcD+2MMU3TIzS/YY6+?=
 =?us-ascii?Q?GD2x48EJlQxFFXcWZwASMosXnXZH3OhaD5u3ZK7X6e7HmaA0+qpjLlHM7dxf?=
 =?us-ascii?Q?FbELuHhuskGTRCwZfOD9FR+bViHqQgJTCfNdwAv1NzY62CpiRf5EjzJxvl4W?=
 =?us-ascii?Q?4DU7zHKjdXAzP5+PRrbvlybnDJjCpmVZhZDz0xw2469UYXKUqRm0draI54se?=
 =?us-ascii?Q?KoJO3fmMiWj5e0vqpRwfJVeIyrDnbOHDRaRi6Z1FawdX0nG3dcyqXzXoaION?=
 =?us-ascii?Q?mI8rBIMOrl0PlC+5RKCrNZfalxr2OPSc/hEFjaFrgwUYP4AAYlntOrQWqadS?=
 =?us-ascii?Q?ucG0rFVMNZnAAo1p34NAOkbHc1vBQBkHVqVoq3RkPesqdAbXz2RT3iBPJXhX?=
 =?us-ascii?Q?5F8bLO71Aa+VjlUKTDaIkJbgKpMalQ3APoiu1hpmAR0gnsp4ciJP+q8NHvg7?=
 =?us-ascii?Q?T252kTl5e9FbIdpk5rXa9owAUsccvSSA1tp4BB5t/eTn446otZS+f61E86RH?=
 =?us-ascii?Q?+EpbCkiDuDw8xf2CI6rgkt/3P4xsJo6xj8D43Ki0gETIURRuvTOh8oDG4l6u?=
 =?us-ascii?Q?Kep9MyEKYpa6PZTpsilHBEkXyEIhOynmq6Ids+X5b4PlyoRRohrvyX0o0Gl4?=
 =?us-ascii?Q?hXZKkPTi51w1PYNSVa2n1FeXz9bkysUfnz2it5zXGE8XWix04MSI0vZQ0a5T?=
 =?us-ascii?Q?pXRQWNqBrfPe2E88uqAocXiiFlndmN8coH0QDntciPURzZEcli4kX7NuxOZZ?=
 =?us-ascii?Q?xYHBq/pprq8rPsk7MdF3r9S4Crv0TN5ByA/Wo6UpGa1pn9QJf2tho1j1yGRO?=
 =?us-ascii?Q?u0ZogyvXVUx77akVDUI=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9014cad9-43a9-4dc2-f0da-08ddced1f9ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 18:58:58.9616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uO6uLlK4j2nKE51sLQ3JM6iLtVFn30KO4Ym55qkhEsibApoyTQRxE7bPmWYnB6uV3yF/v9afH+CqpqcB0g4mcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8299

[Public]

Applied.  Thanks!

Alex

> -----Original Message-----
> From: Yunshui Jiang <jiangyunshui@kylinos.cn>
> Sent: Thursday, July 24, 2025 2:30 AM
> To: linux-kernel@vger.kernel.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>;
> chriistian.koenig@amd.com; linux-doc@vger.kernel.org; willy@infradead.org=
;
> Yunshui Jiang <jiangyunshui@kylinos.cn>
> Subject: [PATCH v2] drm/amdgpu: use kmalloc_array() instead of kmalloc()
>
> Use kmalloc_array() instead of kmalloc() with multiplication.
> kmalloc_array() is a safer way because of its multiply overflow check.
>
> ---
> Changes in v2:
> Fixed incorrect kmalloc usage in v1:
> -     *bps =3D kmalloc(data->count, sizeof(struct ras_badpage), GFP_KERNE=
L);
> +     *bps =3D kmalloc_array(data->count, sizeof(struct ras_badpage),
> GFP_KERNEL);
>
> Signed-off-by: Yunshui Jiang <jiangyunshui@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index de0944947eaf..12f5a1b9ff8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2563,7 +2563,7 @@ static int amdgpu_ras_badpages_read(struct
> amdgpu_device *adev,
>               goto out;
>       }
>
> -     *bps =3D kmalloc(sizeof(struct ras_badpage) * data->count, GFP_KERN=
EL);
> +     *bps =3D kmalloc_array(data->count, sizeof(struct ras_badpage),
> GFP_KERNEL);
>       if (!*bps) {
>               ret =3D -ENOMEM;
>               goto out;
> @@ -2719,7 +2719,7 @@ static int amdgpu_ras_realloc_eh_data_space(struct
> amdgpu_device *adev,
>       unsigned int old_space =3D data->count + data->space_left;
>       unsigned int new_space =3D old_space + pages;
>       unsigned int align_space =3D ALIGN(new_space, 512);
> -     void *bps =3D kmalloc(align_space * sizeof(*data->bps), GFP_KERNEL)=
;
> +     void *bps =3D kmalloc_array(align_space, sizeof(*data->bps),
> GFP_KERNEL);
>
>       if (!bps) {
>               return -ENOMEM;
> --
> 2.47.1


