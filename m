Return-Path: <linux-kernel+bounces-762315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BDBB204D0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314CE3A99BC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E11C1B424D;
	Mon, 11 Aug 2025 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OC0fxZpu"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43144A21
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754906548; cv=fail; b=d/f/l+ElrZmro/3gzuigiIAIu014BFcvrmCwqxMJbCnoY0Mc1jYezla5Pz30LZ7gZc96Yi3UCmj8s9oHoYvteFrnEwOunTtzgx6FAfuWZpiu9oGUkE5enowEd21TDBOGdvrIwvpJjZhjMMN5GvK1Nt1To81KojJnurrEnPG+2CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754906548; c=relaxed/simple;
	bh=TvGaAAfD752lxpJRKwUtwPX1S/nPMWZ9CrQY8qlRT60=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lvjCPqAVAHGvvyfg+CjKWB9KqeHxWJ5zLQKpdcW2q1Gz2REAR8DiZ9OgKBhKJ5edFpJ9IXj8x7Vzmjr9n4om6ypnY9CxQ0p2rGL3YsoV2EqZRXogGsc2H4MS/slJbQs5hbqlw/ok07Zep563apu9hs3p0T9E6f9xCU9UEQw9DyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OC0fxZpu; arc=fail smtp.client-ip=40.107.95.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SctXsDYZ1P1DOhqC7EdqZ1BlYeN+B98v/V6NGb12ad/+NWiRvg+9ePq/fi4sc1Z6MixXno0paeB0M9ZMc+FX9YdOVl1Tal9n6SdNo9l7FfYIPXjuiLe7TOIDJGq8Ibd5Ik6wsrXVLrpNvrFyMCwSQ4gBIgbKeL5FmPJnI0n/VIS1YOCCFxCUtns4DDmnxeVY0doO+v4UadG+nJtvCvKjt3aEqVlNsd6hsgLRK4FN6N1qUjN9UIqHarrSlkGvzaYzv/fCUrarM5jDrI6gF/5aRoMXRguiIp9dZUcCJ6Bd6JqkO8N94iz3IbEgJZbpaKyRT7MY1LGP21IvfR+5ADoJag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OW9cSvo1TfniX10RgigNm9JvhvQvPk6OSoCHHSAq8jA=;
 b=pQf9wbsQV1AmMtmspcaEhN8z+mMPwsxozDaUE+v21EZkZ+NTQsWTs54mrK4XATrJcdxPn1SXZmF0svpYI/1oXDARSZipiUwWywRccgrt5gOsAtqktWJC3QVxBLQY2vdOY387kj14XW7fa4XiIL+JasX5HNsY//yLA+2elms8zZPaMmXVZKfo6L51cdvHXALrUhkqo4h27nwz++x3BUqm0/fph4fm88lZKQbAEwcQ6amLC0fywk9Bk5+NNDf92N3T3S4QisqcNdcAJjhh4ESq4V1cGGrA9XcYBSe3gFvOZG29y3WL4DC9CY5G5R6BV7IN8xht6Lk4YWYH7b9AQ0GjnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OW9cSvo1TfniX10RgigNm9JvhvQvPk6OSoCHHSAq8jA=;
 b=OC0fxZpucegwL3bGLuo11j1OhTlM8JgGFLNkE9jKsKIAVuXLTGTO/XwzSdIfBIr9Z9vXZZc/8fsj732chd8CUPCPVqH/6WtNF5HkVOFEJiUzJG4f+2DVGzM94ZpwevDVC70ibGueA1jTCknKrQOmpIBDbUZA+Fo1LHveHBP8Qck=
Received: from BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11)
 by SA5PPF916D632A9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 10:02:22 +0000
Received: from BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::d4a:9dd1:afd9:1c70]) by BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::d4a:9dd1:afd9:1c70%4]) with mapi id 15.20.9009.021; Mon, 11 Aug 2025
 10:02:22 +0000
From: "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
To: Arnd Bergmann <arnd@kernel.org>, "Gupta, Nipun" <Nipun.Gupta@amd.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, =?iso-8859-1?Q?Thomas_Wei=DFschuu?=
	<linux@weissschuh.net>, Qiu-ji Chen <chenqiuji666@gmail.com>, Peter Zijlstra
	<peterz@infradead.org>, "Rob Herring (Arm)" <robh@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, "Gangurde, Abhijit" <abhijit.gangurde@amd.com>,
	Nathan Chancellor <nathan@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cdx: don't select CONFIG_GENERIC_MSI_IRQ
Thread-Topic: [PATCH] cdx: don't select CONFIG_GENERIC_MSI_IRQ
Thread-Index: AQHcBiOUopLTsBy75UK9ZyCyLhGgjbRdP+Tg
Date: Mon, 11 Aug 2025 10:02:22 +0000
Message-ID:
 <BL1PR12MB5333024F220BFE80912D45FA9D28A@BL1PR12MB5333.namprd12.prod.outlook.com>
References: <20250805161059.4006484-1-arnd@kernel.org>
In-Reply-To: <20250805161059.4006484-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_ActionId=113ce19f-9abc-476c-9c41-922ca4dfaa9f;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_ContentBits=0;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Enabled=true;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Method=Privileged;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Name=Non-Business_New;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_SetDate=2025-08-11T10:00:38Z;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5333:EE_|SA5PPF916D632A9:EE_
x-ms-office365-filtering-correlation-id: 753165c1-8345-4fe0-cc4f-08ddd8be2a7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?9Zl8mBkR4slXZ+pZwj9dmcdK1V4bM4OqpcZZ6a1LSf6hZX3lEU9s1c73b/?=
 =?iso-8859-1?Q?uc7bu327mbP0lJdK9mkN6yY9Aq6pSd0pizSowBdWfNQGWZsg8S1FsCUeYT?=
 =?iso-8859-1?Q?1etdTrT6JDYiZnsVyTy7/Qh0W+KXjuDGeA8Xx/g1bqxAMJuktLAUVqfHtR?=
 =?iso-8859-1?Q?T1BZrzIRM6VXC2Boq57FyNpZ+dWWApvPR3hXeSrz1jrgfNiR8PtAkvs+JG?=
 =?iso-8859-1?Q?HkOeg449BhW6G/8uoXw753ilb9laqoQy/Zbo7TF9hUBLnTAP1ggQTr9vF5?=
 =?iso-8859-1?Q?v0A91eipGO65SauvKVsiuFqX7f4H887cA4w+/pvg+EzdLp6zQHxUYYAqA2?=
 =?iso-8859-1?Q?zfFvU/soJf1refhPR8L3ULJ5sV5Z+jzRkj0xvZA7x/mFhkJ9haLtrmTARO?=
 =?iso-8859-1?Q?RgMLTk75zrE/hMqBe7hwuR8LBEncVNY7JvIfAcMMPhAOM9sjsOFyykub8u?=
 =?iso-8859-1?Q?TpPvb5J4FKLm/LFJdtO+3xVsfK4FoWRpnnMOFs2wBhs/Iujxf9hDbHFVBX?=
 =?iso-8859-1?Q?wVXdcP5fQgMAz0gm43EPVKwhXC7MlUVY5yY8SiKC/vitHEYAJhMS1e7zHm?=
 =?iso-8859-1?Q?cjwGeqQ4RE3hSQ0zbyBTGV9QMNlFSfb7s2U6hgZgQBlhEvJGvmm3Pa4Vux?=
 =?iso-8859-1?Q?b/3MjAr5msNR3oR5B2FejIzZ1igcQL+Usq5MwnVv8CTbQExHiIxYwf5tSL?=
 =?iso-8859-1?Q?k0AZumGQM7NLONxjRRPwcxQP9Yn/NM8LsTrSs0KpRsuMuo3zual+0FB078?=
 =?iso-8859-1?Q?6y+bNJky4pO9FNBmRtWItqmuJQ3qRwyk+6fz0MDUAA5pulfKVFZdgtM1Eb?=
 =?iso-8859-1?Q?ge9BmLm9mP6fMvVydLQsggV/X6inrZEk3QiTbssABtOVYSZTAK9LXOUtW3?=
 =?iso-8859-1?Q?sFFdoczwLUhh6UFkm0wp2b/HC27bdXN/z+9Crbo22mS70GnRXAhbTCzjxT?=
 =?iso-8859-1?Q?5CIUnnhioarXWc7nlNMxLO0z+4M5QBJNPzBCE56A34kvQTQCTSqMpfk/1r?=
 =?iso-8859-1?Q?G29IfGl0d3dQqc9sM3FQu9a10AM2h948U4oj7yRAfug1e4N7/4wI4SfuVE?=
 =?iso-8859-1?Q?kK/zQ18xKbtcok4Mgc2gL4xv9DpJVoaiWKwb5W1neRMyWj826GaxBDXK1p?=
 =?iso-8859-1?Q?6ge/fMojOWPddYQb41w1wno0QdndYXjBsXfHA4wt9ucdzwKpWo7gORbqQV?=
 =?iso-8859-1?Q?2SSEXJel3gyoX5EcqYmE0UwRcJDy7iZylPMqIpiRKbIZ43+IJ4A5mAi+7M?=
 =?iso-8859-1?Q?t6k3sfvH/8+TBLZxTwNOOAgLHInpISko9a5ZIhbAjYM2hgZ39oBgkNSLhg?=
 =?iso-8859-1?Q?EyBWjVIQbQrjmSrkNecSOohGnv9wTSQdwtiFw6P4Fk4/oTOA0FTUIxkATb?=
 =?iso-8859-1?Q?v2/b8t0xhwhQtEwXjIVOeT1+57ScAwrQGAtQjl8H+bTROtQxpGrEQTLBYE?=
 =?iso-8859-1?Q?Fs+tjpdbuKbpCcTmSLcjNWoKmxBpjciXaitdkMyrDzG9fPmBamN+kfvbTc?=
 =?iso-8859-1?Q?6Pwk/9d1/JY/RSH7j29HblR+8hIeUk5bOwpXS272F9IQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CZU6dt9r/Ehawk30jwTNM6YEnT31rgw6okcxalejCLv3EzF4bB2N78DiJ0?=
 =?iso-8859-1?Q?JaBRA+FUaV1Fu32vTeU7hWXGQNuib240XWqCY1R9+7Px93lVCCXiHwemWE?=
 =?iso-8859-1?Q?g0Y3ENZZPXllEIn8XP3Bs7r5GohqhQdqbWy/i2vlRNLFeFDa+vKNR1kHqP?=
 =?iso-8859-1?Q?LitO0DI7538i+YmmKoxrFK3oChghjpiHUL29kVoBdj7n8HYMGYFd6yWdOg?=
 =?iso-8859-1?Q?u/vR99iW9Sd2+cAi5uc1Wxtxvec88aMRAPKzspce3qZ//tl9tcznDyklGV?=
 =?iso-8859-1?Q?OHCdKQAqL6BbKRo+ng6y/28pRQ8IVsRXbgSShIuUcY6HtJQUbpu7DDBzf/?=
 =?iso-8859-1?Q?/sJghk9dd6Lyg/wLJ0/Iybt1DjC3yNBLqJh9Uqa4f15OZs6r0RT1QTmB9O?=
 =?iso-8859-1?Q?brh0DTB3dz5vQaZBjvdFIqZF8dRupTuaFs4LFt+oiGyGqcRNlvJvLQKzaW?=
 =?iso-8859-1?Q?J9DissLfCUsTvAfmH7sHE85y6ouAGkt6nHvgWscM7lAW6v9hlE3o/z5myK?=
 =?iso-8859-1?Q?2h+OEIjLzB9JSrF7R0EOF8TKhGOr/3MorRKwWZ/kwKIbBXalr9VabxrPLE?=
 =?iso-8859-1?Q?/N9VR85uSkFwAJLEaGXPjaGvwzWlskJNE+muHiXCrbihmPxwKxeTou/6bm?=
 =?iso-8859-1?Q?FvVYzpoDo3uir0DUdAz6uKKCrd8EEKDbO/RfXI0p6snl6r8XAv3/2OmZZ1?=
 =?iso-8859-1?Q?idppKz9BfLHx3u8B5j9pRYCHFTGKaqcElTKTtt8GP087wYOSZXUcUj3pVn?=
 =?iso-8859-1?Q?5Tu/tOEGCfjHDxxiuo6JTZihrwVImoPerWDMv7Bfg4eb6UAviqBKGLuQa7?=
 =?iso-8859-1?Q?YRkosyF0VPHmUt2KOSoqPKMhy1LTmQf+rJuwsis2PR6qZ21ZwMI1E7QkIG?=
 =?iso-8859-1?Q?X3X+Q+XmnMMuB9GZP3Z6U5Vg0VucTTN0lLvemAy/5HSYYH1VPrcvyRhmzN?=
 =?iso-8859-1?Q?g2l7nj3LLp89149/LhvydFmnOW5mpt7exzdFrIegpwQhqjfIByg+Z9KLFl?=
 =?iso-8859-1?Q?ARg7AbLqHtm1WdPwsugOInIxhX7zBy8CD+POhq7os/Y0UJysprv6iufSDp?=
 =?iso-8859-1?Q?3oWt45+WWB2ehQeGIuKMOotqHgMMbGGI2/zUhCMgFFTiG01gbLWjJ+it1u?=
 =?iso-8859-1?Q?8e0+mRdeVUm33lg3OAyhZH++/r8YeRMatgnit2twqra0DrPyeq1+d4L+DS?=
 =?iso-8859-1?Q?2texOzJ+QYGVtNW9wOSXS/rD0WhLTmmRELjT1lBmYx1P0m34uCIq3FpV+4?=
 =?iso-8859-1?Q?4eTVR+oY5Uvrkx1ADu0Qq5gRU7z4u6fic28mX4OUoM9Rx+mGsQmYjmGKEA?=
 =?iso-8859-1?Q?i4uQlDWesU12q+9pcsjJtdHysClhQbnmCQWYFFx780AVzNZElPlpHe9FbP?=
 =?iso-8859-1?Q?5zXwkfa3xPasMbR1vVdH9MHXKhJva1PKCz2uyklcew+hHTgaU0te2NxM3c?=
 =?iso-8859-1?Q?ta/+rc1qF+x7tLLwiCW/LkpJHg1Vj2Hvfx+jeZlcAwZVFSnsr+O/nrj8bZ?=
 =?iso-8859-1?Q?ELSPX8WykeTVbux67ccFnYg/vm2ZPUVfnaQS40v0bSSif8prWXD2UbTCBJ?=
 =?iso-8859-1?Q?A92Nm3f2eiafZEJ9S/KQBf8GspEWNEj/kcEAoM9wZ1MqGUaYs/e696KfiW?=
 =?iso-8859-1?Q?nIMjVK4NRet1Q=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 753165c1-8345-4fe0-cc4f-08ddd8be2a7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 10:02:22.4144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XXjMJujNkqgHU1r8/rU/Ty4HyAlAZmz7qvRG+Tiue8sTDtY5BWD2IJ5nj2HwboX4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF916D632A9



> -----Original Message-----
> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Tuesday, August 5, 2025 9:41 PM
> To: Gupta, Nipun <Nipun.Gupta@amd.com>; Agarwal, Nikhil
> <nikhil.agarwal@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Marc Zyngier <maz@kernel.org>; =
Arnd
> Bergmann <arnd@arndb.de>; Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Thomas Wei=DFschuu <linux@weissschuh.net>; =
Qiu-
> ji Chen <chenqiuji666@gmail.com>; Peter Zijlstra <peterz@infradead.org>; =
Rob
> Herring (Arm) <robh@kernel.org>; Robin Murphy <robin.murphy@arm.com>;
> Gangurde, Abhijit <abhijit.gangurde@amd.com>; Nathan Chancellor
> <nathan@kernel.org>; linux-kernel@vger.kernel.org
> Subject: [PATCH] cdx: don't select CONFIG_GENERIC_MSI_IRQ
>=20
> From: Arnd Bergmann <arnd@arndb.de>
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
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This change looks fine, but a similar change would be needed in vfio-cdx as=
=20
well, to compile without CONFIG_GENERIC_MSI_IRQ as reported by kernel
test robot. Do you want me to do that patch or will you be updating this?


