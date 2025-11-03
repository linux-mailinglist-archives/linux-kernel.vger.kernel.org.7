Return-Path: <linux-kernel+bounces-883632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 607A0C2DEBA
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 571EE4E1058
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47E5320390;
	Mon,  3 Nov 2025 19:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="nWke9GtP"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011026.outbound.protection.outlook.com [52.103.33.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388261EA84
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762199014; cv=fail; b=EkO9XV6TFUJV36aJvV4gEOYvJcMQ+wrIPbY+kCeRzBBUuM5+kVib8bK/WfJnRk8jlsIS+r4b2i/lDPwcP/9u0pB97+iMpT8lds5MH/t+9/pZ/K+I3kFHhIfwyaeN3sWTHHxfW1g6IuCfGJHfSaDWesLo8ZAI9EIe/+Q9AlafmtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762199014; c=relaxed/simple;
	bh=O2wIM/hAp3JekS+kdmXJ9+Ktjiqm2urjUbnPK5wVpfg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XWN0SDPctobMwd5N4qU5TIOc6z4c96G5LKLyPVSVQjAMbcze36/wpCDtVsnc5gjpbwnnP7VmgBRfwyIX3OoCoT+pPU7AXONTh3ZXGtYKg1R7JYs+JRw/oPiLb6x/+oo6OTxUJpcW7KIW7U7L7hXb1LuOY33vrsFUtnz9c8xCUEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=nWke9GtP; arc=fail smtp.client-ip=52.103.33.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uU0FDgehBBQZXS6juPipzd74RIrMiI60TrynZy7aU9EESfcm1RJ3qIVRXZZDCRuJT0QnC7FkyiCIgwlQsGsgakEQzw+jY3UiBChvWmatLAtNW302aKJyQVhYTT4QIV2O2DbpiZiDSfYk/9ab8VFPtSpqvv4Di2I3VtC2ff7ch3Mdfqkfgwyi+88jyYwC7yxZHs9cFHMapHkS6m5SRgAiPWQwnAenKEe/3MqHon0OoapAXG7m2bAI2qmNQ1AMHwHux4uUB6nGie4B+RprQVR2rMNKZoXiQqAqbjyP+3SheQ37Rsxw0x3m+H92PPWOiyX1WvHHERLv1bbhGUp9HnaqUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA4bnzzZaAxnxqoutX51qa4+DghIAvbwvE3VSsurnp4=;
 b=RniTBXW9y0VX1h48WmtrPmEwXBcMujhuugHf5gz6lG6YFcldY4v1nZ7XcaP3RZpf6hJj0azsR2is7NyTxn4Vz1rnOSXLNh9uR2g2kiDeTqyv+3bwMAcwCFQRTQQu8I4Nks/xqqVtMzt7rl5+U286bWSO2FFE+uyIqn29wKxMUPRf+HFx0b8somi7XznBgf3ECK2seHdM3HARK8FcGAEPyzR/Yqqk1980YmckEzphVIMx4G/3i08Kn1y5JnDeBrHWSvkavxC9tkwhbGtdaVnwR3DknMVxoVljZp9PqqGhS8FTHzLed4nBG5CEHnu4HNhu+mRyMI9zxHdzzN9CqmHnOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tA4bnzzZaAxnxqoutX51qa4+DghIAvbwvE3VSsurnp4=;
 b=nWke9GtP6bmA3sEZW/lUzbldFOQg62RaczCIfq0JVNpsSAW79A0NzmUnokOIibNjGNWaSWvU96x4JYXJL83Y7WCu4mWSCf8uD4ExmvB5Pc1hXcHTbqnfha42cdRO1Gr8huTwDJOlWv9KJeqR/5pcl4nGWZrLjgLDGopy0f5+/DKDcxfpdGKwGKWLm1cGklvA14tGMVGD6fdMD7TYcdnSD5sNUN4HioAs4Fhqsr5Owk7g0xaHXvcWS+YN72Sm8HT4iYpDlNriI1e2mWHgqIGuUGytF4ZhHVrfMJ7Hn0GD1rwj+JYXAzjzbudOdyp6SKoXwQELsP60unUd/eK9mtUFNA==
Received: from VI1PR02MB3952.eurprd02.prod.outlook.com (2603:10a6:803:85::14)
 by AM0PR02MB11634.eurprd02.prod.outlook.com (2603:10a6:20b:742::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 19:43:31 +0000
Received: from VI1PR02MB3952.eurprd02.prod.outlook.com
 ([fe80::60e5:4de0:ff18:2fb1]) by VI1PR02MB3952.eurprd02.prod.outlook.com
 ([fe80::60e5:4de0:ff18:2fb1%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 19:43:30 +0000
From: David Binderman <dcb314@hotmail.com>
To: "harry.wentland@amd.com" <harry.wentland@amd.com>, "sunpeng.li@amd.com"
	<sunpeng.li@amd.com>, "siqueira@igalia.com" <siqueira@igalia.com>,
	"alexander.deucher@amd.com" <alexander.deucher@amd.com>,
	"christian.koenig@amd.com" <christian.koenig@amd.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, LKML
	<linux-kernel@vger.kernel.org>
Subject:
 linux-6.18-rc4/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c:96:45:
 style: Same expression on both sides of '/'
Thread-Topic:
 linux-6.18-rc4/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c:96:45:
 style: Same expression on both sides of '/'
Thread-Index: AQHcTPaplsnNyD4TBEOr63QObFdABg==
Date: Mon, 3 Nov 2025 19:43:30 +0000
Message-ID:
 <VI1PR02MB39524B46A1A8D8E49E197F5D9CC7A@VI1PR02MB3952.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB3952:EE_|AM0PR02MB11634:EE_
x-ms-office365-filtering-correlation-id: 5c87c6d4-51bd-44f9-dc0e-08de1b11443f
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|15080799012|15030799006|461199028|8060799015|8062599012|19110799012|51005399003|40105399003|440099028|3412199025|102099032|21999032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?QpFfVvPLPfFAki2TfbVbMZWnQK6/R5aiJWJg8P5X8iffQEGQAFGjnx/AUO?=
 =?iso-8859-1?Q?xBE1bz3NmROHctRfO2rNhQsybsmIdR5d9uD0AjYX2zFy1wuFF+VFoV8oec?=
 =?iso-8859-1?Q?HCKN9KiU5mAPUA96z1L+9BYH9hp+xltvcZoYrivyPEhrGXWa5nlVp9ky90?=
 =?iso-8859-1?Q?9iQ7sQRhBaeGM/+jkut5Gn7qvjpDobQ9VlLCqiARiqX7bJ+fx7ttV9eOvs?=
 =?iso-8859-1?Q?FZSQgfiO/JDM/hVuGaVxaN0Qf+HZW23xjUBh2FlHMk2SxGTjseFcyTorWg?=
 =?iso-8859-1?Q?ZSpCjk0HAlfU9qCWGQmO8zPoKDA5GjFXmKeIvkMHE+uOVCXdqZ3Y84UdZq?=
 =?iso-8859-1?Q?1CelE3JhXl5irH0tJjr5dsAyt48faPZdGJA7aRTs/CcOFxK40Y4rT/3iUk?=
 =?iso-8859-1?Q?13g3q3Nn4K/jwR41Ee+uroT6C2JUgndSrSTzTvW81yTm+VrnpLgLHnRdNs?=
 =?iso-8859-1?Q?uIpxF3m9gkDNstBDpUegC07yC85RMzBIN674DXxyjnumeReWOC+8x1E9pj?=
 =?iso-8859-1?Q?42gfcUDhIR4naBatP0SLXhn61Che60iJFhQzlQw08dGSr27Wekj8Yr58Z3?=
 =?iso-8859-1?Q?tIBEOOmootV/jjV4MguY1/jaSoMwQDZ3utLFmwSJzQLlq2CjJTod4Mi5TK?=
 =?iso-8859-1?Q?1aJ/46TQBVWVjMB3PDPkpl1j3gzOiKwv7woPykfH+++h4+J73mJ6+1U5CP?=
 =?iso-8859-1?Q?dK+JO3izab0NM95NGK4/8/1QqIZJIr69leVeyC0nxaSh+EnGWnM4nGC8jc?=
 =?iso-8859-1?Q?fohZui0XDl5W8yLcVx2iKFLtHaZ+Bi/t+pSH1mHC1Xmyjs3PGLOKxDZVF3?=
 =?iso-8859-1?Q?VpQoF2gge5xpiumq1/6a7E09JTAg3saGZymRSpuu+A1b/ONCW2zd5blRqz?=
 =?iso-8859-1?Q?LJvkvcdbQSWz9QQJFVUbp9wy7rPzLxqMN9YvtP4+lAb9tURztToASIj5OC?=
 =?iso-8859-1?Q?u5ZQiKpKqsW3s+TvuH10LQOcqKPaNU0ax7aglF9NjF2R5ssx6Mf/fu8RwR?=
 =?iso-8859-1?Q?TqXvYcLDdXW1SR/ihU+cXaFgW6TBvpqveOP/9gCOAp3QzzYsi79BhnSSxQ?=
 =?iso-8859-1?Q?F2ReQ730lk0n1p7d8/xpcRbX+JqGadewqGhaCNbZt84VVEVkaTkh0DtoOK?=
 =?iso-8859-1?Q?W3mpWNyJ7FcLy+L2u+IqDqetM4fA7vCfinXNMp/g05oYKqKZ1orOY6b7l6?=
 =?iso-8859-1?Q?9y3u6FpIEw6V2VDnsUT5y+4bDhtgngIYjB9xuxmQCjvDtZKIPF2C47Yvmg?=
 =?iso-8859-1?Q?DdJcLp5qtJxzKihfx6Hg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Dw70Ak8tIVFoM4OgP+grxSjEzek+KXPpbOGV3eohJwwkBPGZeMK7lYLp23?=
 =?iso-8859-1?Q?fVVidz20lI/rsJh3pxAzSIvCz/nwZ8pMf5nBJ4m2fAV6o0vEYXGjbrSKaT?=
 =?iso-8859-1?Q?sxlSGIb8NiuJVGx/ZjezMe32Mf6rzUrxrfy0meyyu/gEedvn9lj5uzpMHm?=
 =?iso-8859-1?Q?WI9k4RWNgED05kTgrF4A9euQJITffkF+ImNM/TACpJ6mq6Pe0Fxd7uS6jZ?=
 =?iso-8859-1?Q?bXBpp9hULhNHwmyX4l3IKKS1fHpx2Jv27YP99zVlc+/V2XbodS3c7kmSpe?=
 =?iso-8859-1?Q?faqVOSmHHRMkciU31BnEKxfnm7klKTHkqJ81HmhAzA53m9/SW3hTaImOyC?=
 =?iso-8859-1?Q?sDxu9ZKpBqIww3m4REmQsXm0BIypdit7IaHUdmt/0OfXdlbDTDBoRNAyEs?=
 =?iso-8859-1?Q?2NBpsEMX0/DKCSdXdQXyojWjTBQm3XYNv0dxwFNPamoVaLLPcFUMdIb9Cc?=
 =?iso-8859-1?Q?YaAY+7nLbcb5Glw8EFtYsg+inY3aTjeUgpcO0JkJkULiBN+55lUmfQLQvb?=
 =?iso-8859-1?Q?5p6Uq7gvX95qP/gaNZvZqWkQ3jwvipGv1o38yInzmlNRaHiwX8GyJzSCgW?=
 =?iso-8859-1?Q?LsFzvPci2v41kyoFh3gp8JnvPNKUxpNxOkUUdGAmmfvVIPD3awEwL/7gtu?=
 =?iso-8859-1?Q?bQTcMFJOrHlhML+nmW8jeBIy0UTcXQLA3w8nV6T/8uAKMP7JGWgBVBTmg6?=
 =?iso-8859-1?Q?QJMx8/h8ksAH9rXqEREXqw4Zp9/Kz4YtoQeIIfa0UgAZ77DjYvP2p2iuW0?=
 =?iso-8859-1?Q?jahFI0I98K61A69aQu0cjho7VBnxxJiJl5j07lDkAoCBs8R57QhXo3HoCZ?=
 =?iso-8859-1?Q?vFf38rbKNt1/VmzuTkBdWAJpuapQLN+1Sn/3AGz3iRlqXfTS0240aG7nr8?=
 =?iso-8859-1?Q?vEq685bRf9Vg49smlZuAqqcuKX4DXwPzrXr+8qAAWUot6rk65yT0nIzxMA?=
 =?iso-8859-1?Q?arQT2O6J9tn15xsjV9PBW2dhNNqbD6mSeHoBaTHb+WLW46zQNbocqCS43M?=
 =?iso-8859-1?Q?6LrsxcUr68mzuPC8IEC/JfJgNUV6PxJFw1J93pbydrqRO6M2B8duyha+6b?=
 =?iso-8859-1?Q?A4G53WKyYoA+RibL74rPyg2/3VtXYIGoUp3MynyuXbuivNVQPMRvmbyjDg?=
 =?iso-8859-1?Q?kwD7IidU9BqSHP1eT2mnojMKgDsga1MjMKddKEmRpA2n1bNQ3IVMnLFDbM?=
 =?iso-8859-1?Q?QYf8kJI/4Q3DlSJBAfH3cqmZ/p4lVdOLUFla7F+AeDgJLQ6gPTpXQ/W/6N?=
 =?iso-8859-1?Q?ZTpGRAwrpPKOsTuR8cTQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-5faa0.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB3952.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c87c6d4-51bd-44f9-dc0e-08de1b11443f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 19:43:30.6173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB11634

Hello there,=0A=
=0A=
Static analyser cppcheck says:=0A=
=0A=
linux-6.18-rc4/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c:96:45: =
style: Same expression on both sides of '/' because 'sizeof(dpp_input_csc_m=
atrix)' and 'sizeof(struct dpp_input_csc_matrix)' represent the same value.=
 [duplicateExpression]=0A=
=0A=
Source code is=0A=
=0A=
    int arr_size =3D sizeof(dpp_input_csc_matrix)/sizeof(struct dpp_input_c=
sc_matrix);=0A=
=0A=
Isn't this just a fancy way of setting arr_size to 1 ?=0A=
Suggest code rework.=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=

