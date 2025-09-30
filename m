Return-Path: <linux-kernel+bounces-836926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0553BAAE5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B9B1C27BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 01:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C251A5B8D;
	Tue, 30 Sep 2025 01:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TI30xcFI"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2686D2F4A;
	Tue, 30 Sep 2025 01:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759196129; cv=fail; b=gF32qx9IUT07pGxz9nW6HP4mViyW7W1ytU+zNN9jSFudnfYX/3hmkv2pF4rEkbSRvteq7oW4uurgY3sr4pZu2WthKY14oc+J0PJQ62Mz7i6u1XdS0zKmVODI8m4xRZYDMOji0FQMuSm0CVA6yNql+aARVNgh/ZYXI7gFlS/W5cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759196129; c=relaxed/simple;
	bh=OvgOhlq4CrMKnl/dSdxixnfGN4J9qFuBIBNRKud3/Vg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pjgGTc3tFAdR5GA8FAn7lwNRCJN3HSRrn5llXb7S//YcPz9UlfCqPpwdMURMEUBwPgm2JftfmDwlB0c4pDRQNeWMIGcto42Q2X3MUhmIdtFKZkAYjjnhFv7Kp5phPEfCEORcExoFJxStRW7CtAMHOVWgeIfKakct7Lkpovl3xVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TI30xcFI; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TLqAfm000984;
	Mon, 29 Sep 2025 21:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hfAI8
	zTeQwMetNvD3sfifad5HjGVrDmvspVpunRYrt0=; b=TI30xcFILyaA0PLceARr7
	llRLY1zQxKtCnrhEe9MFYan/ApiCoQnEfBbS1IuLPacaumFUY4gl1UfZmBSjTUHf
	RMetSIn10E/LcJbECkzjtrXupQ+iGgTYCm1RyZC/gdZIGzo1zIQTnhRpr+aIEIbz
	kkpEVc+U4tihI2aVMbxSpwpz1/ZzDMVMehowqO94t7bVN5JSL1uTWKGoPzjkIv2F
	LwxsppkAHRw8+FVNWUxeyjBxpqz84SZD3zqxejfZZvLINlcXzJ6Eswr5eQvY4YtA
	K6rulvmlEHHfMNUMBQzsetylfSvDxibf5/kk7fHgZbF4Clw3+qykwhdQMWGwEbHL
	g==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013069.outbound.protection.outlook.com [40.107.201.69])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49ecu1ndrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 21:35:17 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Up2skJgheVLjk9eUiIgZ9Pq8xbF7eQkmQ0TTB7V20xByfBlCAzWvfwLhn4u0uV5XKqVNg1tRF5S/xYF0/oW9GJ/8lM6ii2E6e6GefsHx6IAV50D71pceiD816DLI7BKU87fzopIwt5NOyo8D+VgCbNoG+HDjoLDqSHXNaFvM95z6j4T7bJBW8sOgA5z7q/bVqyDcGXADLymGXyCpzPAN7BxT1wZU+dGJWHPWw0PARH/Xtix9K/xJVLhwutSXLW0wCtVvXbC8PYZ/tUiQ6fWfrihEd9btSt4AKl8twx2kRACZRtjD39WK7si2aG6OwVS2S+fGDMpYPpQ7lB3haMEvAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfAI8zTeQwMetNvD3sfifad5HjGVrDmvspVpunRYrt0=;
 b=BAqqxuDhEEsS47k21uGyOVe6rl7t68agW1RoyQBiEv8/LC6A0UEMeht1DNEpi7re5MiKGHygz3Xwy9Mt506HUaxcPz74fyqsDA51op/b686nHUK12RkuHmFXWQWXS3/dWiFMTHAsC/NN6xHS+GVACKe4Mz7welg3pfoYMw5/6DAI9Tpkf3/YGBrOZdkU8T03C9JISIll/cTa3nNmbUOikD1Ca2+BQe9ljQIGcLUKmw+HoYM1e24aIxvx3xNvWkkMffKo4ZFH0kI2kn6kAZaReH6R6BcIP1021hlZwwRLBrpiSnPAi6tci/V0qZra/eCfk3qjmiMHxZvq4ci4KL+zhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SN6PR03MB3903.namprd03.prod.outlook.com (2603:10b6:805:73::33)
 by DM8PR03MB6232.namprd03.prod.outlook.com (2603:10b6:8:3d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 01:35:10 +0000
Received: from SN6PR03MB3903.namprd03.prod.outlook.com
 ([fe80::fcd2:bdb0:9ae6:af40]) by SN6PR03MB3903.namprd03.prod.outlook.com
 ([fe80::fcd2:bdb0:9ae6:af40%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 01:35:10 +0000
From: "Na, Joan" <Joan.Na@analog.com>
To: Mark Brown <broonie@kernel.org>, Joan-Na-adi <joan.na.devcode@gmail.com>
CC: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel test robot
	<lkp@intel.com>
Subject: RE: [PATCH v2 2/3] regulator: max77675: Add MAX77675 regulator driver
Thread-Topic: [PATCH v2 2/3] regulator: max77675: Add MAX77675 regulator
 driver
Thread-Index: AQHcMS/G7S/HZqG0/0yW3Ta5wtuYwrSqbWqAgACE6KA=
Date: Tue, 30 Sep 2025 01:35:10 +0000
Message-ID:
 <SN6PR03MB3903849DDFA8F4CC8EAB512C941AA@SN6PR03MB3903.namprd03.prod.outlook.com>
References: <20250929105618.177511-1-joan.na@analog.com>
 <20250929105618.177511-3-joan.na@analog.com>
 <aNrEIZBhh6PllyOy@finisterre.sirena.org.uk>
In-Reply-To: <aNrEIZBhh6PllyOy@finisterre.sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3903:EE_|DM8PR03MB6232:EE_
x-ms-office365-filtering-correlation-id: d8512f98-2bcd-4484-9b05-08ddffc19819
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?Ku1L0b2xBt7kyS6m5ydeHVHfDfAalc78dOnYrbgylgcamk1O6T/tYB5a?=
 =?Windows-1252?Q?FI4JkLpCYgwfvqQo6FlPIdytZVPqnjBywWhFg7Xrak6noN6FgZm+qWrl?=
 =?Windows-1252?Q?25Fr3yTOV8M/PN1YvbZJX192KZNFsGdossdTCDpBHO3AJyc1P/EuG3Ns?=
 =?Windows-1252?Q?TSlIMmWhNygoEcqM4iSrlxgmkCiBNe9huuECbZaAH3nMgykeSd8wgxFe?=
 =?Windows-1252?Q?651n470SStP2Kef17LeA0zBJ82b2cbCI6mZB+1+Z29zrUQkHL6Rmft4q?=
 =?Windows-1252?Q?AifJAO8q0U7LE/LIrDpXSsGsQs5ywsAvvwlkvCVhDpVuc9KmuEGvBFo6?=
 =?Windows-1252?Q?DOI8VYSwd7gtSVYthOBtZ9Lp9Cuub57BfNi9DpM7TUI2PoYM2YxnqO71?=
 =?Windows-1252?Q?kc89dFN6D7MrRTZ3F2a22ZyjgGVoqUgyCimRvxxMUy6hvPUejjLxjprv?=
 =?Windows-1252?Q?tQLA2pa4+NvBZ96OpIZbOwyreMekqn9LUeHXldJD3ZHgwJ2YTevZwX3A?=
 =?Windows-1252?Q?px4IX1LkTDXUmwYEMRUbTPydDK8FxXMPhcO9l01qzfdSSvWj1+Q80ImO?=
 =?Windows-1252?Q?Sh6Y8oCLHvdsaxftb/3z0cIlYjVBm4igdGDnUPgmrBm1/o+qoTggPVcx?=
 =?Windows-1252?Q?/C31zBYulPcq/EKfbZDz+EKJ8jlt8D2ysvDFuTeR7rpqXAD8v1jGPHvo?=
 =?Windows-1252?Q?pHprpFw0wYG8hBmMY66VmVD4MNaojIF25pDJC4Byh+T87TRDVE4RaRCR?=
 =?Windows-1252?Q?HEMDP8YwmWr3y+9SgGBziecAbqGvkbdBzzNwySRD3dHHUs8mWOoEokXu?=
 =?Windows-1252?Q?597HWdLKhY3AawSPh6oUYrUOiunnndepqKwSgF7xd7RG3B0HSRweH7CM?=
 =?Windows-1252?Q?NGkQnJVcNFiRnfn4QUnznp3mC/b9EDv0wLwAaE3KmnyFfHG6Qyh/WKIa?=
 =?Windows-1252?Q?LVXxWKWRSHkyojzmETTWXsjtI2iC0IrQiQA1a/SOLzWlYvgCjJZKdHjP?=
 =?Windows-1252?Q?LRsL7/p53drXoghdKISjVbGTDU8RU7kalBnPgu2Y3Oi5NrwjpaQ7ZKck?=
 =?Windows-1252?Q?gpI/bUVtHRZUqwoWErD9BRyIQrWPbQiqW92rJHSdN6tgUVRqxaptmWsh?=
 =?Windows-1252?Q?4lfiyZ3CkMyX65fDGx0C0d5b+yrAyUkJULxBop0pmBLUVu8FGMg6Wpmt?=
 =?Windows-1252?Q?usuutBqjWq9YYVLURxKNrdyGqkNvHiYiyEmLskNuFFPTfEYh7foohnF7?=
 =?Windows-1252?Q?/c9zi7KUzjtAJeKC1eHMZfnRzC55m2q06iTcG8r2MkCaBTksoqbKXDZ4?=
 =?Windows-1252?Q?N45X0pSAqtLksUew8HY7ZmmXhcre1QFFvN9iKIZm09a2n+0xolC/WRfj?=
 =?Windows-1252?Q?2DPQsgsDyfxyqihfI+0lGuWviz4gzUgo27GcnhqVJDVZiwq1gZ697Wu3?=
 =?Windows-1252?Q?QPQDmmGwiEak+4QrOj5oFGv+O5BGJyW1XqVUCx/sPymn7KvCP1uePnVu?=
 =?Windows-1252?Q?+ptWkr/X99LGt2dyzvYXLK3fxkeDomfs2CPEyIQBYHl6zh+H8n0AoWxF?=
 =?Windows-1252?Q?5fNtMcdfO6ymNnHqiit58Ngu7DkAPzEYjfiQGw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR03MB3903.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?04QkVlUVInu3Iewl0dLAgfJb2C7/8ctnfeADo7PttDseJuy2pWn+YwVd?=
 =?Windows-1252?Q?Kodh9YuGNFuLBOdFh6BMIv/MMr9Km/nCFJeHlU8pd73tv28eDhccLHRO?=
 =?Windows-1252?Q?MkW35ryvfFWDFlsEhO62gHldjXIgkyiYJXin46ze4GVxRD9f2hPfCSBo?=
 =?Windows-1252?Q?ng5vDEgwrzBrW/ehS9axZE14Uv6oMp6fzxBe/K7xRvZM8Dri8J4IsgEP?=
 =?Windows-1252?Q?ktfg2AgHLQKyQwJxzCNnz2THfHOu43om49/M9nlNKFzmbWGn7BLGCHDG?=
 =?Windows-1252?Q?oPRlhJw+ev+EdjutoNfhfLSADMkerIoleLmLyRx5MfrHwx2xcqtCPPhd?=
 =?Windows-1252?Q?hdFac6ChEJAz3WjtjLEzW6OzaHjv6GjRYfOH+ok+2LX9M6OzXJWoWOI4?=
 =?Windows-1252?Q?nyBnnArMaC4GIdJg+oJE6YfABdNTyToKco6NomeBTi4QPcLYGaXMdJrN?=
 =?Windows-1252?Q?ROgb+06Wvvn/c1cfZgHYUAiF/4pjld2ptvwtGYhATjWkp9cbWw3haxKU?=
 =?Windows-1252?Q?VrEhPQ252dN5R84LzIdQX++9hXWWA8Znft5x4q0FVnHiTcHBZNnkAoON?=
 =?Windows-1252?Q?rupIvXjOenucJEwQqX1IIE4pBM1zxuCF1LUEzsvihDOAtTUnlk8bER41?=
 =?Windows-1252?Q?HiEvRtXTgrOGBGI1pMfzh20NLU5uJGCeOx40XJ7WYDwXUC72IwcMCkj3?=
 =?Windows-1252?Q?+eIVlOOehcEj0QPWqRgeDciv46YttFCWoBAwwEhTUEHVDrCY7WT8Mzlx?=
 =?Windows-1252?Q?xHE9PicxItyEJ7E6SiUtooj6OkGl4jWSb5F2dbitTmaHhLCAHs9yJ4ac?=
 =?Windows-1252?Q?Q1DxX87lMnAAwminAgRkbTELtFEtqM9qQQbZLuGSFwrzdemtBIzwGXHk?=
 =?Windows-1252?Q?KRUfFiHjs4ldEWL3SXuJlro7qvMBipxPZ/dLPzNqxSjSqo0qeF4taHqk?=
 =?Windows-1252?Q?W40FnasoMb1WIS92o4demXDX9pVEik8/SFLx0wkK/P+Caq/5fWhueCEl?=
 =?Windows-1252?Q?PqPA4i5ZVZ42d4L/czVUVGNkJ3GGNupz8uP9YAGDGkdDFluZ7e9bMD7c?=
 =?Windows-1252?Q?ATulJKE3TNGKPP7tIlaXpOZqoZ748wDJoH4MH9FvckIPZBLFFpRRsysf?=
 =?Windows-1252?Q?OeergSLDuzwQhpZ2/1EsxGZF88/xWU1GLdEdEWuEUOS4XGW51Y82VgOR?=
 =?Windows-1252?Q?zj+U0j6EH0gOblJChOEh2NCgBuFS+IOniPOtxqd4JathXrRYjN7h2GHc?=
 =?Windows-1252?Q?OpQYlOCqWcVlViQlkTf2C/v8bSBY+8PFvgeY4PSssVuPLoj0AmSG57ye?=
 =?Windows-1252?Q?29aik62UPlvTR39aUfqSK7pP4XWGiXFfEiEuME8AkH5XRd72ymgkaeCf?=
 =?Windows-1252?Q?9ARieDhcrerlgnzaXjR+sKMz5sqS9ESrMSKO7nh1oxO5us9GqgBjgyZw?=
 =?Windows-1252?Q?hoaJKPGnVfb97OGJagsuzLajcFtzbzDynDmBSePFBgYzWZJMfZmibT7z?=
 =?Windows-1252?Q?/mO93DBAxNv+jgR9T0GPMwg2bBj6jnPgR5YkZWSuf7tQpUfXT5UzaTqY?=
 =?Windows-1252?Q?txZbfjqu77sm5D8fzXHhgtzNK9DXB3YiwirRIxrmwGVoYOpaNKd2c8A5?=
 =?Windows-1252?Q?bOSejz3977QKzFg9Y+ou/QN8KHv8cIPhcOv6JKl/TbBTMMEyY/6AFU7g?=
 =?Windows-1252?Q?MTowpu3X7gE=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3903.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8512f98-2bcd-4484-9b05-08ddffc19819
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 01:35:10.1631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KPOgAmJUNRSf416e1JxcrC1kSTWusCwR9SeMUOSyUeMC2cTH+d+JH9b3BHJABs8r6vA/x/YzJ2nQWxR3IvC3mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR03MB6232
X-Proofpoint-ORIG-GUID: FfWY6-rNTBLGtNDS5f_bwg--zDRdgNju
X-Proofpoint-GUID: FfWY6-rNTBLGtNDS5f_bwg--zDRdgNju
X-Authority-Analysis: v=2.4 cv=A5Nh/qWG c=1 sm=1 tr=0 ts=68db33d5 cx=c_pps
 a=x8MjW6KKBoBq+i/1BMmcjA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=N659UExz7-8A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8
 a=gAnH3GRIAAAA:8 a=y6t1UuIGLJ8N6cPep_wA:9 a=pILNOxqGKmIA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA4NCBTYWx0ZWRfX31opT5UDAqlh
 0eRjcd3W+JnbIDwDJemlgEfPKoRNenWqZioPc0oKzRo8/ROp6bNLHU270lYzoIdeNxpfmA6dpMA
 YQ/Taf0qbtEA2495db4gki0QRKVrd1Zku37x736IBzkEgAJhtzbD86sxpSUAxxAGoKHdDKiijtG
 IabqnvWPYCObIfjf5P3BorZ/7AHIC/BwLVTUCBSdiAJeGQyU64uNvUAE2DKaKj8onafA1Bgo6T8
 gu16lMlfT8zuFMPn1JcjLMl21Ll/qhSdy1exPGshY+S7nlBYmSesTTVlNzIgUgIGotyJ1tcV5pT
 LO8s9PNGLkoHwMzG1beY7lbIbPVxeDufyCZtziUAKK149bOC+UpXfzv8vuMiqer0vCWR7A2iXzn
 NkdrU/5khInRpVeHm76mezuceBmdNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270084

Dear Mark,

Thank you very much for reviewing the patches.
I really appreciate the valuable feedback from you. I'm currently working o=
n incorporating all the comments and will prepare a v3 patch accordingly.
Thanks again for your time and support.

Best regards, =20
Joan

-----Original Message-----
From: Mark Brown <broonie@kernel.org>=20
Sent: Tuesday, September 30, 2025 2:39 AM
To: Joan-Na-adi <joan.na.devcode@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>; Rob Herring <robh@kernel.org>; Krz=
ysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; =
linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Na, Joan <Joan.Na=
@analog.com>; kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 2/3] regulator: max77675: Add MAX77675 regulator dri=
ver

[External]

On Mon, Sep 29, 2025 at 07:56:17PM +0900, Joan-Na-adi wrote:
> This patch adds support for the Maxim Integrated MAX77675 PMIC regulator.
>=20
> The MAX77675 is a compact, highly efficient SIMO (Single Inductor=20
> Multiple Output)

This looks basically good, there's some review comments below but they're m=
ostly cosmetic rather than substantial.

> Reported-by: kernel test robot <lkp@intel.com>
> Closes:=20
> https://lore.kernel.org/oe-kbuild-all/20250927.cU4bEADk-lkp@intel.com/

There's no need to do this when you fixed a bug in a patch that was never a=
pplied, it's only relevant when fixing a bug in code that was merged.

> +static const struct regmap_config max77675_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D MAX77675_MAX_REGISTER,
> +	.cache_type =3D REGCACHE_NONE,
> +};

_NONE is the default, no need to specify it.  Though it'll generally improv=
e performance to have a cache so _MAPLE (plus a volatile_reg() op for the i=
nterrupt/status registers), it'll cut down on I2C traffic which is slow.

> +	/* Debug print all parsed values */
> +	pr_info("MAX77675 config parsed:\n"
> +		 "  dvs_slew_rate: %u\n"
> +		 "  latency_mode: %u\n"
> +		 "  drv_sbb_strength: %u\n"
> +		 "  manual_reset_time: %u\n"
> +		 "  en_pullup_disable: %u\n"
> +		 "  bias_low_power_request: %u\n"
> +		 "  simo_int_ldo_always_on: %u\n"
> +		 "  en_mode: %u\n"
> +		 "  en_debounce_time: %u\n",
> +		 config->drv_slew_rate,
> +		 config->latency_mode,
> +		 config->drv_sbb_strength,
> +		 config->manual_reset_time,
> +		 config->en_pullup_disable,
> +		 config->bias_low_power_request,
> +		 config->simo_int_ldo_always_on,
> +		 config->en_mode,
> +		 config->en_debounce_time);

This is a bit noisy, we don't tend to print the entire config out during bo=
ot.  It's also going to be formatted weirdly (eg, only a timestamp at the s=
tart).  I'd tend to drop this, or at most make it debug or vdebug level.

> +static void max77675_regulator_remove(struct i2c_client *client) {
> +	struct max77675_regulator *maxreg =3D i2c_get_clientdata(client);
> +
> +	dev_info(maxreg->dev, "MAX77675 regulators removed\n"); }

This is a bit noisy again.  In general the driver should be silent for non-=
error stuff or parsing ID information from the hardware, it makes it easier=
 to find important informtion and with serial consoles lots of prints from =
many drivers can end up slowing boot noticably.

