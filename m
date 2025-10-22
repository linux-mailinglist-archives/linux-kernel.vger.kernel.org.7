Return-Path: <linux-kernel+bounces-865546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 622ACBFD58A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC1C2347E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40ED26FA6C;
	Wed, 22 Oct 2025 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="EMhUrQ3M"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021127.outbound.protection.outlook.com [40.93.194.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005D926FA57
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151509; cv=fail; b=e+T6OPT9fnnIYZU4Pa+J3xVJfvMTQ/2SmMAwfB34zHwBYjrXjWLCIJqVKYnZtK6a3HhrK0CwQs7ICG8qv4WY8i2iVQfUYRhS1XhUNOR7seY/33JPAC0JoEcV/E8tS8l7e1BFoQFOzhdMlYHGnR7vKLJ/2/Q7twLXHz31Ieayoxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151509; c=relaxed/simple;
	bh=lQUYYladNGl8l66Mf3B+UgUjdVtABlZLgW59B/FiG6A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DMpk9IrMei4xL0RodfqHNxJk95NtWw3lr6ynXv0JsPeq1lT7Gk21ITg42OJ3shs7bod5DKE9qkK6OggLOrfujSdi4HaRa/eQWdgXJGtsyaM4wdiKQ5rROKefGrMsoSOAalkYe1RZWwwKDMEGTQQe4IofzaBqmkLeS0O73tXmk/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=EMhUrQ3M; arc=fail smtp.client-ip=40.93.194.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BifuG1doa2yPJC/5/AdHT634EKCT7inCChsTYZxHbm9u9F1W8gobM31wyEehtjFdW05PozI7V55D+Q/65D2yzX4qIUWohiRPl5mwHQtwE5AMFu2B0Z9a4bQRH5nHRHbqcK8rGxoC8Ct3oR/jBtHoT4DRGE3cGMkF1HUOba4hl631YAtqIqCstPsFakvgLB+CxGGuDsTAHftwufvsm3BCRsk4m6S6GSFu4wPoPGrX6CYrVm7E15SpEV8uALPibDqJMte/qpmomxBwq7YFcO24/jCWW/VeamZkkZqvEXk7jTUItq2YEAzAmS575w2RWnu4tvYluky9jmtscFR7u3F/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOq6fASgK3r3E0ZR/uvCyKCaT+DFe+lVUio3Ybq7cbw=;
 b=ku7+r4SqFf68P7wCdHRf8yqTFoWZ210VCb+An+O9b/oxOxl6Lt79b6FawFjN37OCSOPF6tTfCT/WdE5Pj/27PBTx/wVJ4A2WZZ4/GagTitI3mUf2ArWZiC9IpPZdKDHVOeyMbOlkTWMVbD/Q97Jsmywc7otR+rx/m0YiFa6dVqF0LDWSEJDY0iRmQMSJ26aveq/kSOg0idMQPJBL8DXCBnOHQCshwVl7p5KYkPIj42idTV9kAgRUE5LD0FpuRPiYKkbsh8Xa8DN5lqYyGxwwveWXh5r1y7oeB37n5nVCaT3C/4adZylOxFPcm53QwE5mrbA5KsOfvhAP1i+dgxHv2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOq6fASgK3r3E0ZR/uvCyKCaT+DFe+lVUio3Ybq7cbw=;
 b=EMhUrQ3Mft4d79sB8ZETdMnkF7jEwbcnBUKH2feqMtBN592k+J3sojqP4TvKAhlnLvLX4tWDDChrPrfKDpnYpiZuqLtM1K4P7yPHmq5T0gIqSaLnEEFLMn2c+TBPV47B3KJ3AkZQmdUftffKYDbTv7lPfS0KmcWyhgRWoSbyZM4=
Received: from MW6PR01MB8368.prod.exchangelabs.com (2603:10b6:303:246::7) by
 LV3PR01MB8651.prod.exchangelabs.com (2603:10b6:408:1bb::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.12; Wed, 22 Oct 2025 16:45:03 +0000
Received: from MW6PR01MB8368.prod.exchangelabs.com
 ([fe80::1f1c:cd78:aa20:86c4]) by MW6PR01MB8368.prod.exchangelabs.com
 ([fe80::1f1c:cd78:aa20:86c4%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 16:45:03 +0000
From: Shubhang Kaushik OS <Shubhang@os.amperecomputing.com>
To: Phil Auld <pauld@redhat.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shubhang
 Kaushik <sh@gentwo.org>, Shijie Huang <Shijie.Huang@amperecomputing.com>,
	Frank Wang <zwang@amperecomputing.com>, Christopher Lameter <cl@gentwo.org>,
	Adam Li <adam.li@amperecomputing.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: Prefer cache-hot prev_cpu for wakeup
Thread-Topic: [PATCH] sched/fair: Prefer cache-hot prev_cpu for wakeup
Thread-Index: AQHcP7nufbPJe92xekKQPJRIOuWzsrTK/PMAgAJIdIo=
Date: Wed, 22 Oct 2025 16:45:03 +0000
Message-ID:
 <MW6PR01MB83686E267D323D9012FAB53DF5F2A@MW6PR01MB8368.prod.exchangelabs.com>
References:
 <20251017-b4-sched-cfs-refactor-propagate-v1-1-1eb0dc5b19b3@os.amperecomputing.com>
 <20251020123648.GA851830@pauld.westford.csb>
In-Reply-To: <20251020123648.GA851830@pauld.westford.csb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Enabled=True;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_SiteId=3bc2b170-fd94-476d-b0ce-4229bdc904a7;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_SetDate=2025-10-22T16:45:01.246Z;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Name=Confidential;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_ContentBits=1;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR01MB8368:EE_|LV3PR01MB8651:EE_
x-ms-office365-filtering-correlation-id: 4bc40a8c-e831-4b21-523b-08de118a594e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?PxdQfNIxiFD9Vncm/hK2HHrPVuRpVSPKpaJM2w6Ox7oR0qR63YPmi/8wsH?=
 =?iso-8859-1?Q?igOF0H601AM2FOokDZsdgcP69cvJl0ZfZO7gemJmunp7JUvvHXZxcMAtnr?=
 =?iso-8859-1?Q?0jBU6KKV/rewalbRrn35ro6KW6eKvDOxKaTfSYtCAUk6EjfnTKX+6VIUh0?=
 =?iso-8859-1?Q?8KWgfS6CGYf31tI/xCZXN7UpD8wYIGu4QCdxclihDRwULPfrbtmyP0plok?=
 =?iso-8859-1?Q?8jDA+zJu3HA51kbe1vJygzb/t+F1C+nHFR6mQiPF2FdbNE9ddQ4IQ6oUYx?=
 =?iso-8859-1?Q?PZkk5bkgP+iStQmSu7l/juKrfZTio/7pW1ZvlDs62/dCYNKwnj0QZo90qj?=
 =?iso-8859-1?Q?sd1twnsZ84MP9+YEbiSZu1Q2Duaz3mXZp7PmpR/jqrVsL41h5G5W5tHwtu?=
 =?iso-8859-1?Q?Pc+QzRYAsd4wnPQ0JowJff4/TRHdHFs1X+pTEGND4QkRhqbfYkQG/plJAp?=
 =?iso-8859-1?Q?WBSmBIX+yeCrQDBJEy/skGcvsiFxE8QBmWi0ADdZRHurE1XM26rsmy957z?=
 =?iso-8859-1?Q?ErpSX7fJbGxRvmdusdZLWcMptazpEtvQqy0Kze88F7pdhCp1Nbf6qSojK9?=
 =?iso-8859-1?Q?qSzVn9Tu8WnRM+POsCPYN6GbafsCx/Qy0EzC+vLaLDjAEjvH71pjn2puU8?=
 =?iso-8859-1?Q?mtID8tmiOGLN8HN4WinK9ztg+uqMW789nglQ4HbT/Gmki6N0C0zcIQeCc9?=
 =?iso-8859-1?Q?7iJCko+N5oVqghHeXNjKyfuwLJcN+gB0lTWQw9QeJ08RhEq3v9q3U+owya?=
 =?iso-8859-1?Q?LLYd92drm5p4rk5DECNEcm5BQmu0PcdSXeLrNLRtmI+eI/j2Dfj3PHMwcQ?=
 =?iso-8859-1?Q?Ff7ZME4bfo34F79ExbwxvXmZd44Z5ZNz6RWV64TgQq8DDGwKtFy1jGQ2K8?=
 =?iso-8859-1?Q?+2o+iEbnmq8u3s5xDX0/cvBNrOYer7xLTzLqcSfcLPGX6zmmzmnNOyxN17?=
 =?iso-8859-1?Q?91IxZ6kO93F5g/2CeKBIE+KjH2pKL+pdqlbdr70KxkNdn9W00mUXm4CvaK?=
 =?iso-8859-1?Q?1LtjyZlVCWHBRMEJiE2jSZtX3ZRl08Quqo2d0APz3B2B3LEwyBpRgeRva2?=
 =?iso-8859-1?Q?6Qi7Phz4d2plToEbUkR0QHLJS14Ux2BId7djzdFmCcBlll7zEGXIq7whMb?=
 =?iso-8859-1?Q?R7KXgRou9j9VIP8+/9xV/ZaR3KIiwPUVoyW1L5AFWYI6LOGe/NZfoZ/p6I?=
 =?iso-8859-1?Q?CmiJGCL9wvVhTJ6aOaEs/CzBPqX+993TDgKyKdHQAojsOR4kwTN/jkHind?=
 =?iso-8859-1?Q?5MX3ndmgNFZmdfl9kMuWutJ8uO+YkkUs8WnrxDzyid+n7CZBShSs+B/fxB?=
 =?iso-8859-1?Q?mwv8vC3Z1o5fe67eGg5ro0HO8Z1pqeAurHu5C3VmncS4FsD4rOs8U1RCVa?=
 =?iso-8859-1?Q?Y8TGoMvj+fFVRPKxclfu5ikzI7Malj832nHxouAP7Vhk3cvy6sl7KDy4ie?=
 =?iso-8859-1?Q?59MBex7AF2owAU5gc/n3VMImo4O5rIj2kVLfZZePR6kLJ5DHwUkjy1YLeu?=
 =?iso-8859-1?Q?MuGUN234CN0hfW6n3T4kDTxM6cEHuocJO/8pO/8hyzAhZrKly+0MHhzZd1?=
 =?iso-8859-1?Q?SakbZQxTXO5rhYwdnfyXSqQFwiF9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR01MB8368.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?I51fo3Ogs8TDCM8mxPd4/1uWSH/2/YYosHOe1r+6t5pIsMJ+J8KuWEl5l8?=
 =?iso-8859-1?Q?ByZiUs1J0PbApDXlkq99yy0bXLWTiTISyi2kFGde+oTElGb7Nr2rKoVkZX?=
 =?iso-8859-1?Q?pPEYVNWd4ss+zx0Ivo6FfMGiBW4E8YJ4PIxIYa/b2apIERpmETT5dDcOPK?=
 =?iso-8859-1?Q?wmqvNz8FRXCUhJKb72yMM9nBBDklqGgU9XqrItqtljtp9r6sQnuMdS0vtJ?=
 =?iso-8859-1?Q?8QGxXmgQ6Q0fwADI4glEk040BC6y9C7GY/VO1KAddl8s1GMZvRelRRap4h?=
 =?iso-8859-1?Q?DS55CcJDfMn3yK2NJGmzs10Q4TwW8yEifPGXvVw32P0Jr6uL1IrbEiZlUT?=
 =?iso-8859-1?Q?GkeUewKjicFb9UdnyDyBR8jYTKGYgItNjDhwrO0JPQnTvJUJZnqjrTtWeP?=
 =?iso-8859-1?Q?9NXFt+nf2d7uLI6/1i9+KZwwRNEkiaObt+qUw820fNWD0cInZNY4z7dqE9?=
 =?iso-8859-1?Q?FrbsqAFuzcSXs9ThJkDMhoL4eOgCjHxfrVJth1meXaGWhHIHxP76mZmvpN?=
 =?iso-8859-1?Q?w+FNgP7XCtBeda8gdJnXj5kMio9HYgQ9Ps8NjQrPVBe4PFL/p7NDV0KE13?=
 =?iso-8859-1?Q?vhamqSjoDpCISwMTEe0l3R1vz5k0ORxm0QEtOYZb4VtFVlvwHNrbQc4G2b?=
 =?iso-8859-1?Q?BvCIZ78aHah/4eHEsGwtubG5ZE3pxCmyl9T9+APg9XkoMIGi4Sjs8dM8JN?=
 =?iso-8859-1?Q?Njr7ODGgF1Kt5ZgsoExDEaRltupUiD2Mo82elnhUhuAgToQnuSjKHVWl/s?=
 =?iso-8859-1?Q?V/u0Y0Wab3lWv/cvshF4K2G4HOLtNCSxYXJHSmf4uVR16Sk3mvO8tupUdj?=
 =?iso-8859-1?Q?DegC9Zc91arhplBW2bVFj2cRXAFV7c7GtO9rXiBl7ux8Q+1Ht0GRpvu6cQ?=
 =?iso-8859-1?Q?LyvVprwFum7JawE3T64koKFVtmXzzukYdCqkBTK7apqlUSKUfENJdbchTt?=
 =?iso-8859-1?Q?AYK4oM1Xjy/1qq8QCa1b847GJqmKN0seUP6qTI5mUCiWhj6K3Jo1nGpQPb?=
 =?iso-8859-1?Q?rljQxfybo16ARPCRncFdPYa4+qwFR5wJJkT97P84eHg60BCB7e2CHqB1sS?=
 =?iso-8859-1?Q?c2+hokn5UXrWHQKXYs/E2SAzXejIptZj6vJwx0e4wOIH1mcTMXMfdl9zey?=
 =?iso-8859-1?Q?Aw95ooGf7ghnRaNiMdaTIOtYHt5sJlkCAWfIEEqFGZl6tNjj24CdlT/D0D?=
 =?iso-8859-1?Q?hgPnur0y08OMpLzzWrxKe+40l7hAWYqNCH1mqEL6KaWeYvS3t7QonpjBIM?=
 =?iso-8859-1?Q?v525TOLfGawBIi8fAUfS10vvdIDxP3YDrlzHipnP8Pb1eRWzog7Cx/tcJB?=
 =?iso-8859-1?Q?FMd8uYrIfWFJXJTcgvLL2UjXery8dhm82L5teaUOpgHzyUFjqZO1oQu3dj?=
 =?iso-8859-1?Q?EB1LZkbI0T07U8S6GpFX5QgZVnzsDH1fpRffuta35jzAVToBV8M+X1TWvZ?=
 =?iso-8859-1?Q?GNzdNQdOR5k8OX9UzIXQWEryhmb6JZn+pCuZD5Bdn/QRbTgf1qB34O7/4j?=
 =?iso-8859-1?Q?htcmusxf5xdGzQ70sMN+vn48FUUnk4AX9THS5BbE+/iYkgmb8mwzg1I6+O?=
 =?iso-8859-1?Q?uHZl29F/EjLf9lzXGK3ib/C2SwQbeCz4sSl3aJnXdbf91Ryqr+zEm2TNJ1?=
 =?iso-8859-1?Q?e3YjbFY7tsNX5DerUIJNyEv6IlHIoyYSqY4f8sGV80dV87LaM00yYZOQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR01MB8368.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc40a8c-e831-4b21-523b-08de118a594e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 16:45:03.4512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Md1FySKP1eO61QCgkhZK2AMplOUQui1oJ9GyG8a92YHUpQK35g+F3x3/WB5HWcOSOTSUrapo/8zPDBU1/uQZ33Bpx9URPQiPa/rsuFI51GjR8vW44K7VIkyr+1FuV9u9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR01MB8651

Hi Phil,=0A=
=0A=
The fast-path optimization was designed to avoid costly load prediction and=
 instead favor cache locality with a simple check. This trade-off yielded a=
 small performance drop (~4%) in SPECjbb 2015, which benefits from aggressi=
ve load balancing. However, it maintained performance for cache-sensitive w=
orkloads, like AI inference (~3% improvement). We are investigating this ba=
lance between waker/wakee affinity and the overall load distribution to bet=
ter understand its impact.=0A=
=0A=
Best,=0A=
Shubhang=0A=
________________________________________=0A=
From: Phil Auld =0A=
Sent: Monday, October 20, 2025 5:36 AM=0A=
To: Shubhang Kaushik OS=0A=
Cc: Ingo Molnar; Peter Zijlstra; Juri Lelli; Vincent Guittot; Dietmar Eggem=
ann; Steven Rostedt; Ben Segall; Mel Gorman; Valentin Schneider; Shubhang K=
aushik; Shijie Huang; Frank Wang; Christopher Lameter; Adam Li; linux-kerne=
l@vger.kernel.org=0A=
Subject: Re: [PATCH] sched/fair: Prefer cache-hot prev_cpu for wakeup=0A=
=0A=
Hi,=0A=
=0A=
On Fri, Oct 17, 2025 at 04:00:44PM -0700 Shubhang Kaushik via B4 Relay wrot=
e:=0A=
&gt; From: Shubhang Kaushik =0A=
&gt;=0A=
&gt; Modify the wakeup path in `select_task_rq_fair()` to prioritize cache=
=0A=
&gt; locality for waking tasks. The previous fast path always attempted to=
=0A=
&gt; find an idle sibling, even if the task's prev CPU was not truly busy.=
=0A=
&gt;=0A=
&gt; The original problem was that under some circumstances, this could lea=
d=0A=
&gt; to unnecessary task migrations away from a cache-hot core, even when=
=0A=
&gt; the task's prev CPU was a suitable candidate. The scheduler's internal=
=0A=
&gt; mechanism `cpu_overutilized()` provide an evaluation of CPU load.=0A=
&gt;=0A=
&gt; To address this, the wakeup heuristic is updated to check the status o=
f=0A=
&gt; the task's `prev_cpu` first:=0A=
&gt; - If the `prev_cpu` is  not overutilized (as determined by=0A=
&gt;   `cpu_overutilized()`, via PELT), the task is woken up on=0A=
&gt;   its previous CPU. This leverages cache locality and avoids=0A=
&gt;   a potentially unnecessary migration.=0A=
&gt; - If the `prev_cpu` is considered busy or overutilized, the scheduler=
=0A=
&gt;   falls back to the existing behavior of searching for an idle sibling=
.=0A=
&gt;=0A=
&gt; Signed-off-by: Shubhang Kaushik =0A=
&gt; ---=0A=
&gt; This patch optimizes the scheduler's wakeup path to prioritize cache=
=0A=
&gt; locality by keeping a task on its previous CPU if it is not overutiliz=
ed,=0A=
&gt; falling back to a sibling search only when necessary.=0A=
&gt; ---=0A=
&gt;  kernel/sched/fair.c | 11 ++++++++++-=0A=
&gt;  1 file changed, 10 insertions(+), 1 deletion(-)=0A=
&gt;=0A=
&gt; diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c=0A=
&gt; index bc0b7ce8a65d6bbe616953f530f7a02bb619537c..bb0d28d7d9872642cb5a40=
76caeb3ac9d8fe7bcd 100644=0A=
&gt; --- a/kernel/sched/fair.c=0A=
&gt; +++ b/kernel/sched/fair.c=0A=
&gt; @@ -8618,7 +8618,16 @@ select_task_rq_fair(struct task_struct *p, int =
prev_cpu, int wake_flags)=0A=
&gt;               new_cpu =3D sched_balance_find_dst_cpu(sd, p, cpu, prev_=
cpu, sd_flag);=0A=
&gt;       } else if (wake_flags &amp; WF_TTWU) { /* XXX always ? */=0A=
&gt;               /* Fast path */=0A=
&gt; -             new_cpu =3D select_idle_sibling(p, prev_cpu, new_cpu);=
=0A=
&gt; +=0A=
&gt; +             /*=0A=
&gt; +              * Avoid wakeup on an overutilized CPU.=0A=
&gt; +              * If the previous CPU is not overloaded, retain the sam=
e for cache locality.=0A=
&gt; +              * Otherwise, search for an idle sibling.=0A=
&gt; +              */=0A=
&gt; +             if (!cpu_overutilized(prev_cpu))=0A=
&gt; +                     new_cpu =3D prev_cpu;=0A=
&gt; +             else=0A=
&gt; +                     new_cpu =3D select_idle_sibling(p, prev_cpu, new=
_cpu);=0A=
=0A=
Won't this be checking if the cpu is overusitilzed without the wakee. It=0A=
might well be overutilized once the wakee is placed there.=0A=
=0A=
I suspect this will hurt some workloads. Do you have numbers to share?=0A=
=0A=
=0A=
Cheers,=0A=
Phil=0A=
=0A=
=0A=
&gt;       }=0A=
&gt;       rcu_read_unlock();=0A=
&gt;=0A=
&gt;=0A=
&gt; ---=0A=
&gt; base-commit: 9b332cece987ee1790b2ed4c989e28162fa47860=0A=
&gt; change-id: 20251017-b4-sched-cfs-refactor-propagate-2c4a820998a4=0A=
&gt;=0A=
&gt; Best regards,=0A=
&gt; --=0A=
&gt; Shubhang Kaushik =0A=
&gt;=0A=
&gt;=0A=
&gt;=0A=
=0A=
--=0A=
=0A=

