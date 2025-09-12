Return-Path: <linux-kernel+bounces-813306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53253B5435B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739FB1C86632
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F90928D830;
	Fri, 12 Sep 2025 06:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bR9I9iLf"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D869525A322
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757660080; cv=fail; b=fjnuf/LAkuz8ia7dMrtSfcnh8vaoKcKgAbxZ+UNQEXU3IKiwmoqGvn9xylZWOH+KRPOpOMdSdbuBkq61O+hDTK1Q2fHdWZItOSVjOToSbbaAD1lMapmNDmXqx+OuLD8mpmtAzTMXy18m+S2zsNcdlwj8emEGj3ktAfozw/+GuM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757660080; c=relaxed/simple;
	bh=Ne8+q8ZdTIEcp8j3egVRX8SXZ8/6QmGXJ2zVpuiWZq4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BGuu7QXZganLqT153y3fsmSiHuFyH3W7emyEyJBlKQbpczYnCI5S+FiD/pGoVeBrFs7lcX+yPIT8Rc9VZG5v/rL6kE06FWkUKPDGpgcWa2dQzV5zoBEemDy95AcKR6RtH4yTWK7xJKJAXewCWvuPAV0k/EdLaG+0CeBM6myBWcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bR9I9iLf; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQFdQYZDzZfa05nT+EAloSwLFiXUTTRQRfdT2U7kBWVsYZbW6ylT3U0mexwoVK8WwmeY6spQWdw43ghb/xvmxwHugWlPv0xvV1eBQ/7I5TqKelHHKg9DU0siDWcLIpZ+52I9ybJvYRxEOPbhWxe7wC7/p508oL411tYTdyW+XtFyXEzqSFb59z2NlsSw4KGaYJHoZwfN5cEhzDRNcpF+Bln3I4l1OsvxCPjksDmOUNFQhp2BhX75CIqNUCGZCKn4Wp56h7o/Jy7MNSCfEoW3pbsDX2QCj+KN/NzVZx7mjow1D+FhLNygNA/NY6KOpjfQ6ov9Lr8HNonQue7QVDhStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9E6NA3C5SEcB6YsGQyTXNvPuTxKgL9XIG3j21wgRRc=;
 b=vFBowQ4NS6fs+fXxQePrWaSggdnpn93DMWU1kd4HIKEtTcYR+zZx+s7cqUk/L58HkHdz1QCwYNxzvUglVZ8zgsYkh/8Na/jC4AeMdx3W4loSNd37PKilXxlTdlK/JKPGaxkK/plrtZcRKqP65SLYAbUfp7q0YCqHXKQBK7C1UeVE6ueuJiumcnexJmFNyuKnFFdH4vjWN19Z9Euc+pjrGiENiRwnNJF3mTA/vLI9e7w99+lnXBBGX7fEtCe0cvTZU2hW1JEYkupGfJ2SmHNfI0wVTaFvPhsmIEfswvYiFkN+VpKOnJWfWZ1qqOGMVg51roBg3ZBUyoUzctv7A1aKnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9E6NA3C5SEcB6YsGQyTXNvPuTxKgL9XIG3j21wgRRc=;
 b=bR9I9iLf5pB1Sj00uvjG04RWBwZsal/GK5DRDKc5idsyPJupasGHQQ3PIzh66dkoNGw/1j9U8MAUmMSO8MnWtT0T1RGepQxo6yhzZubUBs2RkDT/sSEMvZ2xuFS3rxL7/67GkzSRPA8W95qczfc86Am3PLoomJLlRRtIdOt0Q5A=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 SN7PR12MB7372.namprd12.prod.outlook.com (2603:10b6:806:29b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 06:54:32 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 06:54:32 +0000
From: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
To: "git (AMD-Xilinx)" <git@amd.com>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>, "Frank.Li@nxp.com" <Frank.Li@nxp.com>,
	"wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
	"quic_msavaliy@quicinc.com" <quic_msavaliy@quicinc.com>, "S-k, Shyam-sundar"
	<Shyam-sundar.S-k@amd.com>, "xiaopei01@kylinos.cn" <xiaopei01@kylinos.cn>,
	"billy_tsai@aspeedtech.com" <billy_tsai@aspeedtech.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Simek, Michal" <michal.simek@amd.com>, "Pandey, Radhey Shyam"
	<radhey.shyam.pandey@amd.com>, "Goud, Srinivas" <srinivas.goud@amd.com>,
	"Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>, "manion05gk@gmail.com"
	<manion05gk@gmail.com>
Subject: RE: [PATCH V2] i3c: dw: Add shutdown support to dw_i3c_master driver
Thread-Topic: [PATCH V2] i3c: dw: Add shutdown support to dw_i3c_master driver
Thread-Index: AQHcAWRgHgzNuWUIgkCsDHVkviqO2LR+JTFAgBE750A=
Date: Fri, 12 Sep 2025 06:54:32 +0000
Message-ID:
 <DM4PR12MB610914E1B473AB7D4840103B8C08A@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250730151207.4113708-1-manikanta.guntupalli@amd.com>
 <DM4PR12MB610977A84E60005E87C1B45D8C07A@DM4PR12MB6109.namprd12.prod.outlook.com>
In-Reply-To:
 <DM4PR12MB610977A84E60005E87C1B45D8C07A@DM4PR12MB6109.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-01T07:42:56.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|SN7PR12MB7372:EE_
x-ms-office365-filtering-correlation-id: b7aa52a6-8adf-4735-4c92-08ddf1c93a58
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|921020|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WQGfeVdjwpGTpBs13TgJn5Hp/z5h1D/9isGWhrVVyKe5WUXV4DAoPzzyAeoB?=
 =?us-ascii?Q?ty/9M6GN2YDEV7970J3QleVMa91FhnfHkbHStRVhPAJNkwuucRr1ZL+/Iq+Y?=
 =?us-ascii?Q?Eyo4xVDbFnaGMJaKW162B/oiPeyB2zrRrJhW4fRRAyGwujQ2CG+SYkdMG7KE?=
 =?us-ascii?Q?NRhc+I49hp94f5k/QBNLr0nhzyg5ox8wgXiqfiGt1cDsmGH5aYg3CnDG574f?=
 =?us-ascii?Q?y7dXceneC/IWN55fHqxqS5fXsFXOcZJg+K9AehUHVEWG7C9FdYzq5cBC1yi/?=
 =?us-ascii?Q?wxyZbr41ivLx03PfUM60uTdMusDNBuAHQ1CbYbJ0yfHn82dpxVDiIhrFSuWb?=
 =?us-ascii?Q?TRk3KNJR04+P4FRQHwzodLVZCR6oYW31IHhii1by2WywuAWpdScqGfJLSkMx?=
 =?us-ascii?Q?8aC9Mp+heD2NiGoLyUepgd+WUhYqTln8HSkCEVp6vIdom3tPTQhh+dWj30le?=
 =?us-ascii?Q?p2JWK1nXviZIG2pyO9R8Hu7fu+TEkXPz1/6MwaiotkS0ZvAHpfvr9oZ2g25C?=
 =?us-ascii?Q?Ma9ZZn1I3YkxT//bERo5hsHtPl6p1vDvGu48Lg90yVeRJxv242Ny1lJr5zdU?=
 =?us-ascii?Q?39CNDcv19b2MWpDBTfwfZeLZwfygR+doMjb3seT4OkkbOBhNVEvzvWkDqWRe?=
 =?us-ascii?Q?ObUFb4IGln0s1AJGGWcd0UfRVSIa8l7Hio9r1uBrLLpictbCvlIoaOWGaMZ+?=
 =?us-ascii?Q?bN/ZyjYUd4ryOg8VaZ3s1ti/h8NKgd6opmj58LXQGEI7j+x0RYEJzH3euHBM?=
 =?us-ascii?Q?/aLI479CZzmtS2/868M5RH5N89OhlxDNmRS/zjS2Rw74LYNX73YtoC0XpaZ4?=
 =?us-ascii?Q?fSeoVIRkUYjw1m5VnHob9yHnoQ1vGrTdkNFhCHAnQgMZhoFnT60tDocK9nkm?=
 =?us-ascii?Q?nqockLcrRBMUbRRFZK3ih8YYWKbEywB4QGJxXKn/DntglEDYDwUocf8Y9U0A?=
 =?us-ascii?Q?y58cPV5lwDz3cpW/w045wnK+7XfqHDVE3bk1Solw7ez+ysRJoK5cbYeIq5xH?=
 =?us-ascii?Q?QVvsQiXGwgYe0e85UHA/xZQ3Sd+rIVfErmLv3z9ZSKsklEX4Qr9FVzOABXFB?=
 =?us-ascii?Q?+qiiy+jTltttl/X1ywV9B9tgRmuSvUyQEK89uX56Bkko75+a0GXgEg+muO/0?=
 =?us-ascii?Q?CE1IGzJ/wuLHJVyt4VxQSI4Yr65kJ0ynFqH1eCkO9b9ITyZ5lvzwZ1px3Jvl?=
 =?us-ascii?Q?EcTjYlIFr8rWcwA4uM8+6k2WNpQeSjljqqyFI+OAW1UXajeLi3C8AUzAx3Bk?=
 =?us-ascii?Q?fA/x+Ac7n6dMzKvJojHwT/W2wrZ58JXQuBPQaZ2UJX0aQ+9dc8jRi56T+FR6?=
 =?us-ascii?Q?Zfn93E1rcgsuo+2ZiI/MNWDTF08RxplqCgrdCRR6W0b5cP+g0Ed8+0Pj/ERf?=
 =?us-ascii?Q?cXQenr+L3WPJEaey//tJZ6Q9DGli0zDLcJZvNkyltJTF8Tja+DRA7HKJLnk/?=
 =?us-ascii?Q?wpHDtPOJRiXq6GC4H2mPKZVRxkDloGZrLsn5ibXqT51nSKqSwSh92PuNbo/K?=
 =?us-ascii?Q?hTxww2NLEnQ7uFbD3/gCgQXpMXp/ezRYRvHr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(921020)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6yv4vs5skElyh4bgklWVODsxm9SyT5HukBLWdmiGn4AYZfCMoVUL3qG+s3ql?=
 =?us-ascii?Q?GJ92lJJE60k044igsFbOorGLnkC9IQ0pCMsLAsCXfjrrkJ44V/NZOkjWButn?=
 =?us-ascii?Q?V67wCl7ekPe7Axpv7tIlsI4EmBqoVIXoqaLpV6InhENfd738DQUVhjTSO7XW?=
 =?us-ascii?Q?GoZP1zjXwtRskzzp+AySGe8FDQr1EKK0O5chaFc9thP3YBWjGQisSwnzrWV8?=
 =?us-ascii?Q?ccvEPlCxCxq0wRpGqzZg3dw3TOMZcgyK4sN9DqXpFad6ymHcgiYz3xJdo5QI?=
 =?us-ascii?Q?+TN46KIRvqgri8VsrkuL3JyMMn+HMjRzyHl45fWrPF8u2pjrm/zMaa1lS9dL?=
 =?us-ascii?Q?FoIXWpvfu9imqhZ01m4lUQ7mMGSJpev/d2ImMa2c0Ev1mVr+yRIXlIi0/bx0?=
 =?us-ascii?Q?lu0SvNjl8PgvAWqEjzZjjHHxvSFjHm1Zy34DcatRpL+pXu1yeCXZrW8lJDbr?=
 =?us-ascii?Q?TyTcbn2+pPHQnnAQitxhofoB7MTOW3cApNm7MRgVlJLAwTSObVk9gANw6F9p?=
 =?us-ascii?Q?L9gbGLN0XYBiMBkIUSYumOhUkLtiZWPuoSTY5yiSihVL/JRRlpjMR1TcRpqN?=
 =?us-ascii?Q?1OZF7/tYgCs6Vs4K0pZPBqKvYmbxtuVyB1nR2GNj+6QFNB0l07MhG9fu26iE?=
 =?us-ascii?Q?S9AYzH8eXfWSXOkQ4Fik0cJNvzD1P4RpvyRGnHbmAJ/cbHm4zR7ktNSmpgva?=
 =?us-ascii?Q?fVXb9z0+MRFkBJFMcWemEOov8U6jctN5C65iQxUpJ62vnsfX3N09j2HVEMvZ?=
 =?us-ascii?Q?wSw5nPSsh2CmIDJyLM+RWd7ZYCFD5fEdMrDhVlGmT0JoTXU+EMwynVEwJNkM?=
 =?us-ascii?Q?8E3R2fJTm5rWV9ZO6WUDUAmn4coaHdhArEQ9LyIC+sb4E7Mc6OLmaPYKbowZ?=
 =?us-ascii?Q?uspCiT7rYqh9SZzivVqef/wk+0Yk4nncJbY3xFEWF+9oHgWDJdol3SZ2W6Gg?=
 =?us-ascii?Q?1xy2g9tMXGUSJg37oDI9PjC46j8mL0FfrZYTOFjLEzN4/bePAmUKs9V+kX/A?=
 =?us-ascii?Q?+QnrER80QACfuTRNC2oq9d4ZfFMAp2+RGLxSl2axeuywPMQMnG2TzZ4nNCas?=
 =?us-ascii?Q?f1gY5floWNpVviSbeBc3TXKDxDWAr50GjCwskXhj5h2v6Z3l9qv5oRsKNwH8?=
 =?us-ascii?Q?8YUoYpSQ9uLZc83LMBQb+acZ3oG5OnMSYwcO+bxSCIfJNO6cR56I3KARE7J/?=
 =?us-ascii?Q?DTBkaBuUUX6qgrk5OCHolLoJoe2VT1TsTYytQLYaaFyOERBah7WBmPiDXGc5?=
 =?us-ascii?Q?XhRPoYQBaCltN92nbzuau9mOqUX4cCmQdNj+sj6xq7RqNgHbgFBh58Wesyty?=
 =?us-ascii?Q?ra7iHFXHHOi/DlIfSTrUydv/w8WtMsWb4MVUHZcKZDUabRb6c06UzzDJCuWE?=
 =?us-ascii?Q?8gsdIkPkz4VvnFKraa6eKrUtJAvCvzSQnb3Yg+CyTCklOA9qdn2FWBxxH7YQ?=
 =?us-ascii?Q?e6JFzoGbLOd30+yiDYc8i+ka2wFcDA6C7qmBTLAdoWodSNhyS4a8SxDZNjZE?=
 =?us-ascii?Q?FgXlE1QRpCmjdwrMoafuix45CY5PxDTxjNSRFWP/RzCyhJ/qR/6hHCDTy7Vb?=
 =?us-ascii?Q?YzWd5yBoTVxjchlCAjM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7aa52a6-8adf-4735-4c92-08ddf1c93a58
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 06:54:32.5989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ig171NY0wuKTuFSOvAmx0ikYE/+FeY5r6VctxoXz7zmm48yFOq/SMKT1KHcTMnxp6386nKNerQvWJcgYtXCJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7372

[Public]

Ping!

> -----Original Message-----
> From: Guntupalli, Manikanta
> Sent: Monday, September 1, 2025 1:18 PM
> To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>; git (AMD-Xilinx)
> <git@amd.com>; alexandre.belloni@bootlin.com; Frank.Li@nxp.com;
> wsa+renesas@sang-engineering.com; quic_msavaliy@quicinc.com; S-k, Shyam-
> sundar <Shyam-sundar.S-k@amd.com>; xiaopei01@kylinos.cn;
> billy_tsai@aspeedtech.com; linux-i3c@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Cc: Simek, Michal <michal.simek@amd.com>; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
> Datta, Shubhrajyoti <shubhrajyoti.datta@amd.com>; manion05gk@gmail.com
> Subject: RE: [PATCH V2] i3c: dw: Add shutdown support to dw_i3c_master dr=
iver
>
> Ping!
>
> > -----Original Message-----
> > From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> > Sent: Wednesday, July 30, 2025 8:42 PM
> > To: git (AMD-Xilinx) <git@amd.com>; alexandre.belloni@bootlin.com;
> > Frank.Li@nxp.com; wsa+renesas@sang-engineering.com;
> > quic_msavaliy@quicinc.com; S-k, Shyam-sundar
> > <Shyam-sundar.S-k@amd.com>; xiaopei01@kylinos.cn;
> > billy_tsai@aspeedtech.com; linux-i3c@lists.infradead.org;
> > linux-kernel@vger.kernel.org
> > Cc: Simek, Michal <michal.simek@amd.com>; Pandey, Radhey Shyam
> > <radhey.shyam.pandey@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
> > Datta, Shubhrajyoti <shubhrajyoti.datta@amd.com>;
> > manion05gk@gmail.com; Guntupalli, Manikanta
> > <manikanta.guntupalli@amd.com>
> > Subject: [PATCH V2] i3c: dw: Add shutdown support to dw_i3c_master
> > driver
> >
> > Add shutdown handler to the Synopsys DesignWare I3C master driver,
> > ensuring the device is gracefully disabled during system shutdown.
> >
> > The shutdown handler cancels any pending hot-join work and disables int=
errupts.
> >
> > Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> > ---
> > Changes for V2:
> > Removed pm_runtime_mark_last_busy() call from the shutdown handler, as
> > it is being removed in the following commit.
> > https://lore.kernel.org/linux-pm/20250704075225.3212486-1-
> > sakari.ailus@linux.intel.com/
> > ---
> >  drivers/i3c/master/dw-i3c-master.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/drivers/i3c/master/dw-i3c-master.c
> > b/drivers/i3c/master/dw-i3c-master.c
> > index ae1992665673..2d16b7d74743 100644
> > --- a/drivers/i3c/master/dw-i3c-master.c
> > +++ b/drivers/i3c/master/dw-i3c-master.c
> > @@ -1762,6 +1762,28 @@ static const struct dev_pm_ops dw_i3c_pm_ops =3D=
 {
> >     SET_RUNTIME_PM_OPS(dw_i3c_master_runtime_suspend,
> > dw_i3c_master_runtime_resume, NULL)  };
> >
> > +static void dw_i3c_shutdown(struct platform_device *pdev) {
> > +   struct dw_i3c_master *master =3D platform_get_drvdata(pdev);
> > +   int ret;
> > +
> > +   ret =3D pm_runtime_resume_and_get(master->dev);
> > +   if (ret < 0) {
> > +           dev_err(master->dev,
> > +                   "<%s> cannot resume i3c bus master, err: %d\n",
> > +                   __func__, ret);
> > +           return;
> > +   }
> > +
> > +   cancel_work_sync(&master->hj_work);
> > +
> > +   /* Disable interrupts */
> > +   writel((u32)~INTR_ALL, master->regs + INTR_STATUS_EN);
> > +   writel((u32)~INTR_ALL, master->regs + INTR_SIGNAL_EN);
> > +
> > +   pm_runtime_put_autosuspend(master->dev);
> > +}
> > +
> >  static const struct of_device_id dw_i3c_master_of_match[] =3D {
> >     { .compatible =3D "snps,dw-i3c-master-1.00a", },
> >     {},
> > @@ -1777,6 +1799,7 @@ MODULE_DEVICE_TABLE(acpi,
> amd_i3c_device_match);
> > static struct platform_driver dw_i3c_driver =3D {
> >     .probe =3D dw_i3c_probe,
> >     .remove =3D dw_i3c_remove,
> > +   .shutdown =3D dw_i3c_shutdown,
> >     .driver =3D {
> >             .name =3D "dw-i3c-master",
> >             .of_match_table =3D dw_i3c_master_of_match,
> > --
> > 2.34.1
>

Thanks,
Manikanta.

