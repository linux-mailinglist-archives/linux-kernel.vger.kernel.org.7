Return-Path: <linux-kernel+bounces-773536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ABBB2A196
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E8D18944C8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B2B319860;
	Mon, 18 Aug 2025 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zREnkxsi"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF34149E17
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519748; cv=fail; b=mVUK+QXBfc4EG9SrDUm65d9mArUjGLetNxu2CjjLsoc/GdfKgomZcXWxQMQkdRatHgTrupHo4rqyuoJtWBU2dABA5xJjR0pGZPDnJKxT/2XkS2A7t2pKWjC9BwrMioey5JBRgdMbjlpOT3pll02iSZn3o+rDLURd+heBgdY7WNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519748; c=relaxed/simple;
	bh=fSxMRAAaqt7pcu5ZX4GiuCVhNDWygm2lws2avCiZado=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YtVAMQOmB5GU8bzpWzCHYe25zML6BOt5oRD4H3PsezouHpOHsj2TzwsfxEX9GtIGD7AYEuDx9Go/mzlB135udMAGXKjKqpOArIOVWmwoERiNX4JOTpalpaY3xZBzRUQ4Ikj28LJq6pr0BuXPE+A1za4tmoxA4qYcdqdLD9HT8LQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zREnkxsi; arc=fail smtp.client-ip=40.107.96.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kk5U9wxjQHYDlWbMOtBHv7h2MqTV3w1/VmqsPLJr4CvbByZbYaUQoN9+uV6fBEW3LDyrbqKTOfcqPe79L+b7TkpIqfSuiOZ344xGHgNegLExLUdSp7sejoSOoBh8L/crWB0g9zBIGGHh9dEGVTVy3D9nyEr41Lab/AF3sfcbcIRomLxF1j1bu4fwZIlIAlslWx1+2BVlbs5bNEQTmNM0H1FsCDLAtTFp0ISmScx1MQqXFTKctjV+EJqUqsTYpB4d90xDnDaqCqKZN/c9fdLGoyETlhcjmEg3qRZLov+Gmp5qSN0l3R+2jYOpgLCXZ/b8mSP+s0DkxE4Cn8oleznRIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7lY4yAlWa9eawfEs5Rb7jzOlosHKKqd2SBKhOLuEjA=;
 b=YGwOnw/kKuz0+NqpMbSzNru8fGZxA/BEqXBvpnaGSnsklK+aGt3DheI3rJtf9P+uFtzdba5FXPUZdApZfooU691bD9qUwCdk6ma10BMGPa4wTacG+PX8edOLysBl0BW36EGKz0aMwx5oK46tYxtYFqI7BZRsjWjn7P7L5Q09OG/jsWYP9KxRFvJ1qSkoAvTERuPjZBEWeVEHuUjFmKPMTkOPY+6hjZk891GfPwulAWzrVkaJ8MDOHmQYUlZMUrQuMwPaJ0iwDm39DbocSXysIF0LXgUpleUJmvbcpJZvzbKHZ/okIyjJ1UddJr9pmZiqK1jTjAbf4a+sOZYF7nHhmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7lY4yAlWa9eawfEs5Rb7jzOlosHKKqd2SBKhOLuEjA=;
 b=zREnkxsi63R8w/z7xESKrFWiIm/zQ7YwiE2+0xRSMFiOCmZ+WBlZhYflZ4Vq0wfSfyj2cIktHgXoEFrcw/voKUqGaIckheXZXt2ahAg0AXw9Whteu8uFQy06TbXPDBzfcFRJZoUNYjvu8EmhoAbl5TbmL5dha9HAg1Kqvhr2frA=
Received: from BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11)
 by SJ2PR12MB8135.namprd12.prod.outlook.com (2603:10b6:a03:4f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 12:22:23 +0000
Received: from BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::d4a:9dd1:afd9:1c70]) by BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::d4a:9dd1:afd9:1c70%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 12:22:22 +0000
From: "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
To: "Gupta, Nipun" <Nipun.Gupta@amd.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "krzk@kernel.org"
	<krzk@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"maz@kernel.org" <maz@kernel.org>, "linux@weissschuh.net"
	<linux@weissschuh.net>, "chenqiuji666@gmail.com" <chenqiuji666@gmail.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "robh@kernel.org"
	<robh@kernel.org>, "Gangurde, Abhijit" <abhijit.gangurde@amd.com>,
	"nathan@kernel.org" <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Subject: RE: [PATCH RESEND 1/2] cdx: don't select CONFIG_GENERIC_MSI_IRQ
Thread-Topic: [PATCH RESEND 1/2] cdx: don't select CONFIG_GENERIC_MSI_IRQ
Thread-Index: AQHcEAny9LoDasCHL02fh0sPtUe83rRoVRyg
Date: Mon, 18 Aug 2025 12:22:22 +0000
Message-ID:
 <BL1PR12MB5333E94CBA4297B21F3621C79D31A@BL1PR12MB5333.namprd12.prod.outlook.com>
References: <20250818063244.1242634-1-nipun.gupta@amd.com>
In-Reply-To: <20250818063244.1242634-1-nipun.gupta@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_ActionId=ccd3cd4c-3742-48a5-a696-57aef981a1b9;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_ContentBits=0;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Enabled=true;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Method=Privileged;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Name=Non-Business_New;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_SetDate=2025-08-18T12:21:34Z;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5333:EE_|SJ2PR12MB8135:EE_
x-ms-office365-filtering-correlation-id: f42d601a-c32a-4036-30e2-08ddde51e256
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?licIXnw5lKqFQlKhS67Lbmsw90smxJoxWyb6ZljYyCJu/Qw0nYDR5NUpDLgn?=
 =?us-ascii?Q?pwL80mTEWgzvoSlevDFsuWYZD4DbNMHuACjmSS8P/TFxbtM2SWhAtY3OHc3U?=
 =?us-ascii?Q?V1Dy9WJeZGM7AFJ/bl4f2LJIqv/uwRFxZu0he1h4nigxA/lc9Yp+y0BaXh3S?=
 =?us-ascii?Q?h+DEPFcrX+BZyDD/8OIRrDS6K9MWIxHGw2Am92ipo4gsdiSbhLdmDdTirbti?=
 =?us-ascii?Q?NgS13rh3BGa0DJHGDXVpOqI7fEa2A7kWPrUjs0sjRu5kr5zudjeIbHUkbTxP?=
 =?us-ascii?Q?va4RTCcapOUurxg/jLh88KpnSCC0xTMsbGZ+kIIE2Lq9mvM4wL/dJQxIDx5T?=
 =?us-ascii?Q?ePwr7AuUWqSPkjRrkGDH5Eo5GBWlsTKI+RY3vAeH1Dv9xIjTcmoMXk67wDBm?=
 =?us-ascii?Q?y7XzeXWacLe+Gz9TlceOmUyVMt8qplY5eJtvh8P7hW8/1L6E8n5E5mE6tAT6?=
 =?us-ascii?Q?hMG69or3T7I9KJJhY++zY7cHzHZKy/m9OK5gSD3B0kffUGpVX23nEvO+T4Oj?=
 =?us-ascii?Q?WmNshLjw4b8fD2pDvT5zHgIXd9pwd8PEjJqNZKRa9xoGHzoJpglq941jGWmT?=
 =?us-ascii?Q?kWsdf1aRI48zbUWYO9PF5jjtZksfgC0l7YTtk1+qxNNoS+HKwHX7yzmsykuU?=
 =?us-ascii?Q?k53dVzJpHmF0O6hJj4iufWV0tztfUuN5vbWipIZIqGYxqsnGkiscDvwZKdqL?=
 =?us-ascii?Q?0JfP9hUyj9NiOW4JzB8yjhd29MGvemGSI/HBF0rIuYKLUW1y3Mseri7ac2Mv?=
 =?us-ascii?Q?O7Pf1lEKOYoZRcmpJLZNCiUQM/g848dJCcZFKor7XP1+GSXr+KLmLZc3+h7N?=
 =?us-ascii?Q?UMOjT5fJydfgx9WhzS0Y/E1AC2+Xc/NHKgd1g7uKeU3dZl3U66dYlEk2Nnrj?=
 =?us-ascii?Q?8zilKwucW1yVXI02sbSpM12aPs5KwN4Uc6XW1QQQxBEEkgHr6rbU70ePoKua?=
 =?us-ascii?Q?0Mir7jQ93CGUXR3+fjiwzwz6zx2d6Fr1mPL0gQvrBh3kI1FGXatKnWZfg5Ve?=
 =?us-ascii?Q?efBIDb/5vwNny/ZAW5xLmn+VqBhyw6N1QshNuEYfC+DxP+dYOl5tv8KXsU83?=
 =?us-ascii?Q?RXmxRQmxyAYahLCG6tzrgYFz1p1Y1jBWhmmzqQ16eS9+Koy7eQ+L62S8Dm0T?=
 =?us-ascii?Q?jDJj+vYweUFeBkJJGpn6T4g47aIY/F3dzhGQ0OcfYybDdrnwHroF9s9ZdynX?=
 =?us-ascii?Q?/wBRnYj0Ff0SwUfYnSvC2+AZmSRox3Ttft/ryqJ7W4E2cQfMJ2ngwafwPdS2?=
 =?us-ascii?Q?w8eiqCLAEY9tGZ+OMhdsnXV4j2R7SumJizLI0JHHjh0z770R//ZIyDcX2Z10?=
 =?us-ascii?Q?e9fwJpWqPblmKW5t1DCbQlwo/vf2tQnhlAFQUc9sjjbqgeZZ6nQo+8uPqvEJ?=
 =?us-ascii?Q?i5pYQE/WHJvmaUvMSSdwOkxgV3a5hk1XVa1XkHEmpdoJKpLRmajJvc6ZmCYV?=
 =?us-ascii?Q?Y7VrO5Ay/s7tCPYkzYCIKoRRfmuBC31IMGnBm3ENDiBPvp6C0ye8qg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dmDztRuISc+fMibiwyb8qOxFjnJiR6w49/6yaXFUQCdPPy3ijAu8bUzRGz6f?=
 =?us-ascii?Q?rfoPcuQ14BM2DVpT1IJoqt1XsEJ8Per4FlnoKjNk4k6Whf2qM7I10iVyiKn3?=
 =?us-ascii?Q?KjCO865SKeayEq4cGgWeMmY4N1suxvUnXrQODy/LzCPJ9jErbR+UGjv/wNn2?=
 =?us-ascii?Q?cACFs7C53YU8glF0GrVuv3tFxeWzBbkBZR29HhQhPJxPRWoMXFv0uTaZZaLN?=
 =?us-ascii?Q?mx9J89Ntu5MotvbjCHu0zVAfk4at9bsDNZhsPlyQkOzc+hp/Bz4gyg3ULbEB?=
 =?us-ascii?Q?77JeL46RxI+KvslbSaF42xpInWiZ2nbDmQV7cyPb1IPJdrGD/pm3sIXdZF4T?=
 =?us-ascii?Q?xz3HsCFxjLxdi6oHOi63M4qijd3Hvlzn5tBuqFWMjvgHA0i7+uoa542BglQg?=
 =?us-ascii?Q?znVHRsvE+ZtwDv1qgpC9gMoCTVjraDwFI/LK/PsOfLpaptWghzgKc8p0osJT?=
 =?us-ascii?Q?uU9darCvNiT+y3yCz89p/hYjlVSbSmExPNU8jGTyVWBZZHXDC81eMrRIbqKS?=
 =?us-ascii?Q?JpDyK2kaxLsKIvCzaHlM5iMFu2lvzUYEvOJxnKH6+H+HCKB+XexchMaF782B?=
 =?us-ascii?Q?IWnswkiIy9SYvUdSHwIqLGUPffo/FIGh/tGOCz6HUFuoNWh+i+SMFYOdoDMt?=
 =?us-ascii?Q?GwSv95rh8ol4GxxdVJ/TKkQcmcKeg84OKM2xQ4XznIo89oXOFaabYWxip3dy?=
 =?us-ascii?Q?cHqPhQzwH7D2Q9WuqfIYSYEWevvYmNwtkM4mjDHWUpxWwk6mW70Klt3EN/k+?=
 =?us-ascii?Q?p80+DwVncL3VSut+pNioGd3KG54jU3gyZ3m4lN8a1DVmdpDQYAwg8UR0mikc?=
 =?us-ascii?Q?khFpiV0q853NSnyEyBJSts10+HyL2IxIJnItcsFJHH4zQ7n7Dmb0bYxuZTNr?=
 =?us-ascii?Q?S0Rs9xFTosMBdr2dpJPlKE4tPJFCcHPPQbIiChmDXvwebgM6zG+7KsMMUnSj?=
 =?us-ascii?Q?gC51dKbLqVTAoRko3X7ai29pF5861HSaIdvdronYva/C4jBTB0snc+LgNNlf?=
 =?us-ascii?Q?H/8XLKr14c1emDVDm6/Lu7LSK74sJWkmdGXHuwK2gJbvRy2JBpCZuKmA7QDH?=
 =?us-ascii?Q?V0G4XY18HOTbKOvsOGk46G2gAp46b5LA4iB0qKqqn5ZhFmIJAO03jdYvZO+R?=
 =?us-ascii?Q?nT+8FQRF3FYGJfkyRdr8eqGsV+GzblZAm3ENY5XZ7FCtFlg+sk29xaHAbzVQ?=
 =?us-ascii?Q?6+6MWJ//FhnBfJQbL2k5qtvDEit01kuG/1PUqTqH4e//xcbhcbgoBiNcXwTs?=
 =?us-ascii?Q?aXG53dziI4LTZANj/V+9rgBadFX3iwCoV7UW8ONk7LSuffXEXoG0vTxgky+o?=
 =?us-ascii?Q?GlVx9VONPDpGM9+RUt2CgCGfVe4wEH3ip6mYFYYwG4f03tv+CiKDGrZD+TFM?=
 =?us-ascii?Q?AJmMTUENhGEAY8h2HpkwQ8uM9Bd7RHWpxgFIl4uC6KsVwWtLUqJP3S+RDAO7?=
 =?us-ascii?Q?Bp0MF7HNmn6FqHW5GPSA+MQZTbwl6xGKEmhu/wnE9XQoDyAWoXkj8wj4F/hY?=
 =?us-ascii?Q?bWiE741vXIQvcn7qJpwbnj089FSoro7ZG7IVLGzuIVwpgzTr58FGlaLHrvq0?=
 =?us-ascii?Q?9MSYLRNCPTx+fHGT9zg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42d601a-c32a-4036-30e2-08ddde51e256
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 12:22:22.6874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Nc2iLzyUeq/QUAnZGWG/Kgh4QHfgMsWpefSFmf/GiILW2JS1/7/1QPS/luXCDoh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8135


> -----Original Message-----
> From: Nipun Gupta <nipun.gupta@amd.com>
> Sent: Monday, August 18, 2025 12:03 PM
> To: arnd@arndb.de; gregkh@linuxfoundation.org; Agarwal, Nikhil
> <nikhil.agarwal@amd.com>
> Cc: linux-kernel@vger.kernel.org; llvm@lists.linux.dev; oe-kbuild-
> all@lists.linux.dev; robin.murphy@arm.com; krzk@kernel.org; tglx@linutron=
ix.de;
> maz@kernel.org; linux@weissschuh.net; chenqiuji666@gmail.com;
> peterz@infradead.org; robh@kernel.org; Gangurde, Abhijit
> <abhijit.gangurde@amd.com>; nathan@kernel.org; Arnd Bergmann
> <arnd@kernel.org>
> Subject: [PATCH RESEND 1/2] cdx: don't select CONFIG_GENERIC_MSI_IRQ
>=20
> From: Arnd Bergmann <arnd@kernel.org>
>=20
> x86 does not use CONFIG_GENERIC_MSI_IRQ, and trying to enable it anyway
> results in a build failure:
>=20
> In file included from include/linux/ssb/ssb.h:10,
>                  from drivers/ssb/pcihost_wrapper.c:18:
> include/linux/gpio/driver.h:41:33: error: field 'msiinfo' has incomplete =
type
>    41 |         msi_alloc_info_t        msiinfo;
>       |                                 ^~~~~~~
> In file included from include/linux/kvm_host.h:19,
>                  from arch/x86/events/intel/core.c:17:
> include/linux/msi.h:528:33: error: field 'alloc_info' has incomplete type
>   528 |         msi_alloc_info_t        alloc_info;
>=20
> Change the driver to actually build without this symbol and remove the in=
correct
> 'select' statements.
>=20
> Fixes: e8b18c11731d ("cdx: Fix missing GENERIC_MSI_IRQ on compile test")
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Reviewed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>

