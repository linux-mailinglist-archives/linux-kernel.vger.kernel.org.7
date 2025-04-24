Return-Path: <linux-kernel+bounces-617317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD83FA99E5E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 03:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF05E1940E20
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 01:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F19B1C861B;
	Thu, 24 Apr 2025 01:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GTPZjhR0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IYm4QXey"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805BC2701C3
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 01:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745458741; cv=fail; b=oitElB8w1RMjpEcDaqlFhhVLyrl68hTPz+iD9JIkJqfRVqu32vRwB3pwPahNQDmkIM3DQHja2NStclXwFUlvnSxZDK1X5Xuey22XBDLOGO4nEW3aSWWh/M6LCK5/VbkuKvBMzbrE4qpTIAUvWOpB/q4PbSHJ0+v60iX+Xt3hWtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745458741; c=relaxed/simple;
	bh=+dFyeJZi00n+XxuO5LyQF/YRaQJkKGJLd19Hbv7CqOE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mCi4Lm+UCJwsuVFLi+NCGIZAVp/Dz+PTtOY6rgBnHfG9q8C1DNngQFyJfs5pIYPq+aCbXjNJS0E3z65lNW0x8cA+XxxtFMMvs41lpkszh195Suj/KaMh+jH+zTnuTG+8pD9v8Y5DZ3feVJYMA13E+CBdGe0Ct2PJv6P35bdEKHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GTPZjhR0; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IYm4QXey; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745458739; x=1776994739;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+dFyeJZi00n+XxuO5LyQF/YRaQJkKGJLd19Hbv7CqOE=;
  b=GTPZjhR081zKCmLLZko3VN0qmFm3pXHlvOikT6CFLIEXkRCL6FjWN3UY
   UnhBUmP1FYm/9k6HQJXUL7sxwRYe91t9sbq/fETDhUfASOPabCMDuUr7X
   c44SLavYnqwdeaxtvUbUjOO+iiM1K7fawj+WwDA8dnYtPhv/7/ImWxBDT
   zhTBdN89tdJd8IcZdfUf2W8dPAlruZM0aYnMut8jKApHZfnSeiI6d911m
   h6BCPUM1viXxLWsnxNt4FurKZchATN6XUVtFPhvDy8jhTYQI3aF5Mi6+i
   ErP04zbQ7IVUk3rLbofUw9xA0O9PshhMc9zifeZduX52O9tZjwILv6ha2
   A==;
X-CSE-ConnectionGUID: TiOviR/yQXapm5wlGmOJKA==
X-CSE-MsgGUID: BxREDhHaRt2j9FfwrBeAkQ==
X-IronPort-AV: E=Sophos;i="6.15,233,1739808000"; 
   d="scan'208";a="82235623"
Received: from mail-bn7nam10lp2045.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.45])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2025 09:38:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/BsHyNQGzmyIpNZgyNUiUXiy80C6On2U0EVkFoxTFSY46o2oZ0Iuf44BHoD+jL/7KTmFs+3lJuC+CkfKYcnEDSv1cLfOMBP0NctRC0bvkkHrBTFmmIWGkM2Zbe0c8+1qqExBGzMiwvlAToZX9aZn/XcUfpykBAVabI9Szogabe+ewxlANUtAH0HcHlXrJUb8f8t7gNA/3dTIGicT1lm3EfyYrLd6HlqDwvzTGoKdz0j8XOZgu5k6YD1Ruh0rGRlGF/NVLjlpisU85XvwE3Fz+oXPjmHIdCi4eHcIBrtWkE3vJdMZXCMOVOjv1RfVDlEbmgZtKZFBy0qb+eCYTJchQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dFyeJZi00n+XxuO5LyQF/YRaQJkKGJLd19Hbv7CqOE=;
 b=xwN7bRgMNJH8D44Dct/dJoxuOphsP5+W13y25R+q1E0shRR3qCsPytKnbLxY8xsdtBH6jTNvAUhVvlqxr+wc7Fo2kal8ULjPZfCshKr+dPkAhCWkeDFR9f6mQSZraQ1GoR/SjIqY7/5zPciK6iJLBPO8JU17+MG8EHv9juOS3AJfeXn+sinRE24WLwOvwHQHJIP4xs0vvVdY1EItkQKPp+wugmr0dTU3d8c53K4JSLjA4USJEfIF1PhhclyQOnpeYlJ7jVwnd9B59l5kK9VcJ8DKz0fv3llvuqXYqCs2ux/SYHHa5GlNVDIje3b8ZISHWhDr9g3ws7twrnIVJ9ADRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dFyeJZi00n+XxuO5LyQF/YRaQJkKGJLd19Hbv7CqOE=;
 b=IYm4QXeyCU5BATQDr5oR/2vNlX3BTCpiWs3MUHFvURphdIaUbr0OyujCpglcwuwBucsdNxUrZQQOkmknBlc+Q0AGLMryC/t+LHCnnPF1T6/VXjBIvEugzRUSHceovhmFS3c5+sxN/EKfYzDUHeQXPRImrcdpkHAn8cOm8c8zgyM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA0PR04MB7419.namprd04.prod.outlook.com (2603:10b6:806:e3::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.23; Thu, 24 Apr 2025 01:38:49 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 01:38:48 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Alistair Francis <alistair23@gmail.com>
CC: hch <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, "kch@nvidia.com"
	<kch@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "csander@purestorage.com"
	<csander@purestorage.com>, "hare@suse.de" <hare@suse.de>, Alistair Francis
	<Alistair.Francis@wdc.com>
Subject: Re: [PATCH] nvmet-tcp: don't restore null sk_state_change
Thread-Topic: [PATCH] nvmet-tcp: don't restore null sk_state_change
Thread-Index: AQHbtBXkRaJhNx23GkqCQ4XZYkQLd7OyCxMA
Date: Thu, 24 Apr 2025 01:38:48 +0000
Message-ID: <w2nqgyguk5kcpci3j6eaiiy6cztriy3t5iddlqf3kggehudkhw@cpbm2ochdd46>
References: <20250423060621.632581-1-alistair.francis@wdc.com>
In-Reply-To: <20250423060621.632581-1-alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA0PR04MB7419:EE_
x-ms-office365-filtering-correlation-id: d5bd59a6-aea2-4815-c599-08dd82d0c2c6
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nxS0IED4v08m4WtYVnBfvDOfDE4j2C86Auwq0vYJdD+4lcoAeEwVme1CYV6S?=
 =?us-ascii?Q?OeO79H5dH964FuZUcEVjw5IW3ZrSuZHfIl15T5ctFAPwXOEMq/+yiU9UsY8f?=
 =?us-ascii?Q?Fif/dzVG5iFfJHQDtomPDeUCV8rERTOe/x52OM9AtKn6H4RSCjsXI/dtPwjY?=
 =?us-ascii?Q?FudeJRXBZnC5FfVviKqD7ImyRuX5/p58ObRVIakNkcv2e5g08p8UlC3bo3TT?=
 =?us-ascii?Q?AjiPqewosZ+NnsRqydSKTSZi6ng16Hi8Vo1SxeJlS6TVKzjGQBcPd0usJKLC?=
 =?us-ascii?Q?Cl1ftYgqMZLAxiW75vDPQd+pJKIH/qmqCWUAd0gfat9Eb7Sg1oxNOMUL3iuh?=
 =?us-ascii?Q?XywQkvZGBhxmNO0g2c+c7mno53Ml2g4kNGMo3A7ystsza8OyKFKRVJk18bXt?=
 =?us-ascii?Q?/OoLhXshrzszWGOzCp7U8lqI5EM6ge1OyxudQ6pLL5nHNqt4UsQRVhN4DJuj?=
 =?us-ascii?Q?iVuI5AAC0gkzgh1SZljSzugBhxnmt05LyuBW8mvYTd/Op4d1FX358ZFYfP+5?=
 =?us-ascii?Q?k4Xck569yMFVnvzyKyHjXUDrt5xvEpcfdKRoyH1KvUtWYE9m1YFk3kS92r6v?=
 =?us-ascii?Q?u/Pu/trfmL8m05jmvWGMASDXFVLZPIT2P3GBmHuI0801UIZbgPpda42afax8?=
 =?us-ascii?Q?yMQbw9AsUm+wrsUkXzL4FaIcWGhMLMjFD58QZMut0gzyALxOgds3RnjGZUTh?=
 =?us-ascii?Q?hADw1Cou+74sn8PlOSQgfi3kC1nexIYnQPzUVt+tpwI43Rk5rkzz9fFnl+Cf?=
 =?us-ascii?Q?8pqW0j8RIpC4cfZDzxPRZpqXJhOa1wKFCdKMbGeLdj8oaVMYp8VmNsEfE+nl?=
 =?us-ascii?Q?GK8iq5GxLXkn0VEIBAkKHHuJfM7Uh1MoPS5Ij60iA2AJhdIv3UzNF1TSQ1XQ?=
 =?us-ascii?Q?21mSNUJlERPnU35pOasq7u0bMBrxcaE9Pxbwa1lIo2Pgte5nBgCfLEUYNCcJ?=
 =?us-ascii?Q?mCp64O4D8SJHOr1pPtugcg5cx3cjPR5dyfSk+KB0NX0zlLK8IUZs7EhHodI8?=
 =?us-ascii?Q?XPgpfor0NuMTTu0H/skom6T3LRqbaqD/FS9GGqCMPIkUysC1rzsHXWLRXLGn?=
 =?us-ascii?Q?u9XnUhRD7I9cakutrtN5S0TfMW6q6tGopLOA5UNAhYXzJIawYQjvo9TdFBHI?=
 =?us-ascii?Q?A7OQe26LtS8zdY8Dp5wb1bwzUZQDKhiCsktpz9jSAmKA+oImufgJt1KvxL9b?=
 =?us-ascii?Q?W57w9TG8LaArfg1ZX9JnJ6C3Bsxb7xFLFXRiXX14s59H9dSd43v6PKOMYEQt?=
 =?us-ascii?Q?GIW3BiH4i+aTl8wOi3M/bbyZhpbhY9fbqAakuyeqmsiL2je4vD26rrvyBTvb?=
 =?us-ascii?Q?EMByAEm7qfDbpfNECuJcP4fYwVJwdJVZ9voUgcvLeU+NOcQsT6dKMxcaOT3s?=
 =?us-ascii?Q?cJyXyi8pl0NOEB0zso6GYkIakqDCKAv6CXrET3G5SAt4GJm0egS0nUXFYI0I?=
 =?us-ascii?Q?oYyzDI/iPsJPdwpiv7NF99OGa/aFGCkjdlpVNijb9MLL3INWvkJnH5wE9qAw?=
 =?us-ascii?Q?dQMyRGB6Or/Pz1E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dCYnFRdP71ETeW9aeaHsx/Iiiog1BkkZI+Nv63l80f5fL7sAW+pckc21I+yE?=
 =?us-ascii?Q?YMRtL5Gnwoy4uZCqcfR4c2Rz32gGXjrrJUeVQIked2PCIze0/ab2FFpmMmMJ?=
 =?us-ascii?Q?aPv+AyYx4yXHnyBFn+N0ifPNGrje4SoBr3Uk0GyFyURVnpT6XVhGtquUZONI?=
 =?us-ascii?Q?36svOzLCEHmJpRdLPZ3h9r7B2T/rz9PlF2QKncwRxHhoVmCDlTRGYQSpC/bN?=
 =?us-ascii?Q?6IiR/D656BonWMnWQrRZ6Rbk28xI25tSa1KyVYxreIrY4vGJ6z3jUWEMVMqJ?=
 =?us-ascii?Q?tiYCv4eH2emajPJYG7nAOu/WERWGPoemA2B22/MYx6xbrVj6medFyrrYHGZV?=
 =?us-ascii?Q?Ry6P4P26y8GUj53ujPvHEocjQaUScO0P8DDIbL0Cac4DGOXOhaxpY3WPEGfO?=
 =?us-ascii?Q?r2n6BLG+2Erk0UNzTyfhiFkpAfTmo5Q7/+i1d86BDz9JydR4OjxuKPZjHjOF?=
 =?us-ascii?Q?eKgc2tX221szbVBRbQj9f6eUxdve4wnAzwvgFhcVUmCTPnXbYXanxKnLEruI?=
 =?us-ascii?Q?F2fdjiHMpG3QoArpcbxrHIRe279A5sZgIMcrB+AA47lX2CXM5X2NhD9WNVGO?=
 =?us-ascii?Q?+LS0/+wkQh4KD0zYACrBvOx4Vd8MT9tarlCcF4Q0HX41j/jixb2jueyELJuT?=
 =?us-ascii?Q?E7lcnt/pQxLpNTo7JC66Q4qRUvLxnp/0dVcCUdS67+7OOfCKGN0uimcip6+7?=
 =?us-ascii?Q?68SgaHY5CGYpXlxBWuRhf4SAsfHENMLh3B8KjT/jt6GwrIGQ6mj29vSC2+Jl?=
 =?us-ascii?Q?fkXAbXgLP9dfKwQBttHvHmSiS/GGr4RuT734Q6LemmJ551l2KVtI1qRITFKP?=
 =?us-ascii?Q?yL/TUnhLTzOU64pZ5SjwWlKx3dxkItS4qIfyhW7/QLBARQd8cIKfatjUKKBs?=
 =?us-ascii?Q?Uq91RpQsBhVTWo0Y4Q1/OqVAUNyhxsYjzajGTq78D0dyWl+HOxplib1NjV6p?=
 =?us-ascii?Q?/8isg/T7tdl5tSb1CAiLoS88kSU6xAJjIRHhfGWS3QaCVJu84Ol6fv1M4Ua7?=
 =?us-ascii?Q?4VkJd8JUycuARSjpKJJUIupWYpfiUSoi/srYOMtHViVNwJAwzd3mn7/FsQQb?=
 =?us-ascii?Q?buFQ5NKhVsvK+0tJnfleAwIPAgcqckNCwygMrrs7+bW3M4kBqmipxxxM+n7b?=
 =?us-ascii?Q?NOJ2RuE2HovZ+PYjMSN9vt5P5QAjfE8K6c5JeL9t1q4gtxkPLkzpUeN7pPEk?=
 =?us-ascii?Q?5gcOyj1Oxobe4nxOeV4Lb9jZr4aqH9zlbdkamHBv1HR56KpAgOCtFBoA2/sP?=
 =?us-ascii?Q?p58Wpv2O1jm750CAZciaMFOi/BYSkn4qCuoCqS9XF+3WglhpYOtfbgrsowCS?=
 =?us-ascii?Q?hJWFV8snKIys1Bk0Zi4JrDv+ABc9z4mHBBe2YwDxl90FmFWBjtOEX6ojP5ke?=
 =?us-ascii?Q?V4K2N54itvoFosx6AH8n8bjimH9JLaXTtwcomkClZagsUuwOv2rdDnE86Pff?=
 =?us-ascii?Q?zDhoQt6h50jGxPs+zg98HOHrJ+DO833IJaRIh/2XwyD+fTuPcCX7nfxaZIxZ?=
 =?us-ascii?Q?lYYZBPS4imXNj6avPKwPJ6nuT5rvHXYqkHXd8azorHBalYp28glpBjlxrEZO?=
 =?us-ascii?Q?aqGq5S0+znvIws8OMNLp4KVfLe0s/MluqrCvTbygtjcnUJny9rOo45jyP/nP?=
 =?us-ascii?Q?3Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <721B277FC73497459FAFA4450D2ECD5C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2eLMOlB4Is0cajGc4GHc9c4l78BCFHDeVwIyS45TDC84t6wtNhqikK71LeYza7OVHiQ11QsQHdcF1d4ciW9dc3xUBb4XSAgpAsjAVA3HDy9NUJY4+bqhez7gzmRHzSSUtpoMdy7yLodDpJeoHUl/8gr9maSJADHgmdevf/f0dRDZ/7NG1Mr9aV8Bn/pKUo2jQdbvFZEAoLxrW8bLTfRpeAg8Xo+aLvcfHUOWz4eGIirNhgp+jeAZWhtc5tZpPylsmnA4ZA8St7Zwzsdh0dKCy+Iz4Zu00AiT4aC4KTz9uOcFafpZD+MBe1iztzSda/o6LJYgtMFzrMwe69NFia1+UHRcDSdDhl7WeRiSEQ24df3kuHLXndevWlr9rFK5deX1FSZV6mEiSZHHKq/jTrrCzx3+JRWaMF5azmkV2v4Bqt79Hlwkv9I8jUsG0L+I7P6PhoYZ4lclqhvT+9AL+Xf92ouR6fy9Igrxkt8OOGVIvH8F2x4zRrfUHBLVfl6zlR51RRrGhAjSxOHVrJqX8kNimPJ+qp6b0Pq8yTQ9pHsx9mlfwcM9dGXcUM1LH17zMCltXcoFXlYXUMGe7GDdHOeYGYw5b9IXj55IFazevhZbSYACi5m8Eb3tkaD9JS2ETrAg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bd59a6-aea2-4815-c599-08dd82d0c2c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 01:38:48.9016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r/LpsC/wIXw+7sV9/ElYkikiTEjsChBCbJJPj0VpWfccids3Cvz7ebymHHixLV33TBh+TWvmk6YADbXKenQOUP+BW7Ek8fH/g/4z9Eu8YjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7419

On Apr 23, 2025 / 16:06, Alistair Francis wrote:
> queue->state_change is set as part of nvmet_tcp_set_queue_sock(), but if
> the TCP connection isn't established when nvmet_tcp_set_queue_sock() is
> called then queue->state_change isn't set and sock->sk->sk_state_change
> isn't replaced.
>=20
> As such we don't need to restore sock->sk->sk_state_change if
> queue->state_change is NULL.
...
>=20
> Resolves: https://lore.kernel.org/linux-nvme/5hdonndzoqa265oq3bj6iarwtfk5=
dewxxjtbjvn5uqnwclpwt6@a2n6w3taxxex/
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Thanks for the fix. I applied this patch to the kernel v6.15-rc3 and confir=
med
it avoids the hang at blktests test case nvme/062. I also ran whole blktest=
s and
observed no regression.

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=

