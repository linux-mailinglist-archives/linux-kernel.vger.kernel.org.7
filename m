Return-Path: <linux-kernel+bounces-813113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B35B540D9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E09AA36EF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9C022FAFD;
	Fri, 12 Sep 2025 03:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZhZ3BlhW"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012056.outbound.protection.outlook.com [52.103.2.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEC3136351;
	Fri, 12 Sep 2025 03:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757647499; cv=fail; b=tN7gvT9m5FqxXKzuErwB6oUDOz751XbQHKoUXlG+Sey3/fMfx/ex9vSs5eA8THJYxc3EOZfhk31eods3WqGy4fzNJPYiUrhshL3kidAUjSDWcgNnhw8w/kL9ckogrx7EHqa9Dw5RiI/CkDLFeKMXfQAm+MDKXoXh0rH0WMzvH5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757647499; c=relaxed/simple;
	bh=pwiyOeEx0bYqH9pA+XlxYBa3q/aFBePwopg0jKcOUEo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OTVg65f1PDv74DGlhXdSUJsfEWdcCEahElxfZghb5x1aCoOTIE02A+dJiQGb7kVewW0uvIQX+1odIWAz3n34ugJWEwr9jmL/z6cIidRIr/+MYhO/EB4QtGl9AVlxdLpDNKhqvXmMZIAyrhECzwe9ExaRadbblMYGJLuso25sViQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZhZ3BlhW; arc=fail smtp.client-ip=52.103.2.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMCs9jGc+QClq1ecjTz1+iV4ZYtti4efyFmUAiVF0BW0ckWMng594INN/ftwciJ7UMluYORBX1bK+4n4Ty/FKuNdasYtvg0DUKosgSzDW/5NuKJRAH88KECECsUVO2LWuKbtZNKMYOpCmlxknKXA/yJP4IJPSsXzyg/U+mIyxFfaCMYkbvmfxXddmsCDPnB3l+eUrnjzXQyJNmp+tKKXku24xlgjC7LVH/BaB75RCo9QhhnA1W4v9aI5TyfjHI07fg7aA9dY3Jx+1isMgJ9dndffIH19pOHbRqPqEt2uUmnVNhzxqpUMWQ8xtbOsokDmrn97JNvx863mqfDXvE1IzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwiyOeEx0bYqH9pA+XlxYBa3q/aFBePwopg0jKcOUEo=;
 b=q9rYQ3KtyhBdK8hNdWWLaKokuBJh2kAks9viaolzZ4mjA1yK1XIlMXvdsovLhv3KPmmQYFu6hxDoW+1hiXnhsx6ufURPafGxVr1N9fVWBRtikBoEHytNscXRxSqmHrcc9sREMMNdUADKMDk5JNwzmxf0bqBMUeHoP6/FXzrPQ4196F6dfsewP6orgXHBbkw6fMVPyiH+iXbxvGrQwDd9pncKOajqbZRcsCSx8r8ok/5c42ggpo5neRNMO1BwyrTQD/AxnuRnPjlIfP+YlAImntdW3Wp42mKr5rJdOfBALqhBa2U3yv3pR8VcAHmWiEqde4+xoqStFwrZTYE3TYKEdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwiyOeEx0bYqH9pA+XlxYBa3q/aFBePwopg0jKcOUEo=;
 b=ZhZ3BlhWmPqV3alqrFARVLdWFH9nckfxPTy8epRbD8EbScIFZLO6zzcTEztIapwoUG5CCc0ujGuizjlqxSDzBJ72k7lZqnNRHZh00nHHWCX7R3M9ztX33kakY3KltxNpi3cCI+ZTKn/wwnk02rCCUBvcxQYtSsTFXZBl9EiyNBCtR/0NQm3MoQOoDTpIqsMU6PVHNX7mmDPrFF2UceM7uY0B9AYV7F5f/06VJYxzwKPTO9BL+PccUAmOWHn9sIJUQu0+50ELMwkzNDpQtExfhBfmtT786z+zBGQWyx73ZTXClk8QWZZstOB5prBpzeGg567E/3Lyf3kDqXt4CMWaag==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB6841.namprd02.prod.outlook.com (2603:10b6:5:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 03:24:55 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 03:24:55 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Prasanna Kumar T S M <ptsm@linux.microsoft.com>, Thomas Zimmermann
	<tzimmermann@suse.de>, "deller@gmx.de" <deller@gmx.de>, "arnd@arndb.de"
	<arnd@arndb.de>, "soci@c64.rulez.org" <soci@c64.rulez.org>,
	"gonzalo.silvalde@gmail.com" <gonzalo.silvalde@gmail.com>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>,
	"bartosz.golaszewski@linaro.org" <bartosz.golaszewski@linaro.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org"
	<linux-fbdev@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>
Subject: RE: [RFC 1/3] fbdev: hyperv_fb: Remove hyperv_fb driver
Thread-Topic: [RFC 1/3] fbdev: hyperv_fb: Remove hyperv_fb driver
Thread-Index: AQHcIasCn50A4HP2yUGHdjWciNX7b7SMKV0AgABbISCAAapbgIAAtPSg
Date: Fri, 12 Sep 2025 03:24:55 +0000
Message-ID:
 <SN6PR02MB41578C2984A84B4D0AA17943D408A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <E2D7F2119CB4>
 <1757437112-2509-1-git-send-email-ptsm@linux.microsoft.com>
 <8a958fe8-fbba-4bd6-a79d-fd310f08f8d7@suse.de>
 <SN6PR02MB415755A10BD2C9D0E7F847FCD40EA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ccc6011c-d1bb-48b1-bf35-6fea1b1e8a49@linux.microsoft.com>
In-Reply-To: <ccc6011c-d1bb-48b1-bf35-6fea1b1e8a49@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB6841:EE_
x-ms-office365-filtering-correlation-id: 5b74e0ab-0df6-4735-9358-08ddf1abf194
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|8060799015|8062599012|13091999003|15080799012|19110799012|461199028|31061999003|10035399007|3412199025|440099028|40105399003|4302099013|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iHQPQVQt0iDKrZQnBERr8mvjQEckHGM3naJHObaIEWT1h83tTCJJL1pzdUsL?=
 =?us-ascii?Q?clTQmN02QyxjofFHWA7veS2Oc8ra/793tEpEPjzG262Ir2tqAFqsVnle6x+h?=
 =?us-ascii?Q?fUoPTSQctf7861dIC3JNig12CpAEnGaXwqrAwHIvRIakutJu7X4jD3W59ifP?=
 =?us-ascii?Q?hcEeLd0XZHnIg3vg3Y9sGyoph9U5iu235PMnHpnKgxBSDEO/MzLnQ313Rx1h?=
 =?us-ascii?Q?Z6wdOFTH7TfTWlf/ZEsjZ2nrrVA3aoCZA0wG66UktzR9EO5wOaaP5KHNvm/s?=
 =?us-ascii?Q?sIZTwQWJ1w1PFCl1o30TuTw3CT6NRWZ+3Xv8xeKsmiHg+f6+S1JNWgA15aM0?=
 =?us-ascii?Q?p6h2a9mcD+rX2LcgQA0ZRRveVqbHBPwugGcQkudc5KRMZU60u6fST2yUvexv?=
 =?us-ascii?Q?kc5LkqHipmT6+124ZbzAhNPuPMKgyip08QnJmtMYol7qMarThrcMrgk6FwTV?=
 =?us-ascii?Q?fvwKy98+KMDUA1GR0LHqThriMNpG7s0VnKOXjwcR3dXeWvIHekxiz127R82t?=
 =?us-ascii?Q?6qweeAYVMjtqqbx7sOgUkhqWOhq+mJyxdMkqYZyBYcGK3jmVdD6UPRTdDNYY?=
 =?us-ascii?Q?apHgLnYtcknseBnluCaLcXWL/wGtv2tD9pmt+Tze9icYcRb4wj5zN9nkjgn5?=
 =?us-ascii?Q?LCbv2LahMG9+raPloKTNQ0KO4SmeC8Z0Q6lGV5RNvDbT+jS6b/iMR5cKLt5M?=
 =?us-ascii?Q?/b7ycL5xYlA8prylax1seib1gwAKlZSNPv1HHvoa5nqdT1+dY44366fmjDEM?=
 =?us-ascii?Q?60Jsf4FiKjA27YNb6lfjc39jdhC6VVbBIzoCccZTHMwNLAfjt+CugyVctgOM?=
 =?us-ascii?Q?x6UYSrX217vA0+klrcNcpmg02BeLjmb9fZU26nBbDwCJzyp7nN3J9jhqhft6?=
 =?us-ascii?Q?BZ9H1TOj/VE5Hw8a1JlYdYIH290r8Ot809CMmNkZx9FDgIgZmG5sHvrmFsLq?=
 =?us-ascii?Q?vdAAVI9Vvqr+Tx2DeozP6/n0/vkYza1RpeA83WSZJ4bdpRvXAEMDNBy10aZ1?=
 =?us-ascii?Q?wEXaCJxntsD2GsbFX938qBKEF7VJALcL8p0dFuCDNK4IvvaYCSQU3l0U1FPJ?=
 =?us-ascii?Q?FFwa/amLTuGvlvcUMYHkfOE59DPabOHQkdGhg179vVdcC9ckXCJa5DgmJ6Zc?=
 =?us-ascii?Q?9kqUCOMiwLAx+EGz054YBGKvxj9n0DaRRnfG5LPIuSG74wQtGzZ7gOXOcvzC?=
 =?us-ascii?Q?+P7zbIIncqBqPqyrbu9bYtEuFLyHI+N8tKKa31VNHBc5+RZNfwDYrFRiJaGk?=
 =?us-ascii?Q?2omNFUDxFyvG1AGVqxL4qM9Uvhyi3Z8vbx0QkSMfFjSdJ78s0/v7xqe3rtyA?=
 =?us-ascii?Q?rlLndpIh4R1BG0nN0yEnuJxK0UujAB/QP6KQA38Q2V7bJw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sXb4WgPFUHaxCmIDpSGr4QJa/q7zj3Tnzuj+Htz7+kOG60rYOMtsCH7s/Suv?=
 =?us-ascii?Q?/R5GeA6OFPI9/4cqa70Xo0/spQKGExn5kZEGKbZRTZifc28sCYxJ9yVnlCCm?=
 =?us-ascii?Q?lQYBad3wGXWO0IpGr7bYrL6OR8RksMV5azwejruk76fPXrpZbyAGy4GAYatY?=
 =?us-ascii?Q?BtklEXYnEd6+nd4/y3TLx676Kpr5iY0FrfiRIKhOSoaiRftJMh2VPQKmRdCZ?=
 =?us-ascii?Q?6g1cKJe7oao+uANLGJDEo12/9Vjejp5UQE2k5Ywar1dh6UWVx6jgF0M/6m/h?=
 =?us-ascii?Q?TtlTLk0HmgBDpwnixlZtfh2NOudaYhUlw7qR8cZ4mN49TvOL59scxbbkFop2?=
 =?us-ascii?Q?N5Xr7uV0gDz41AjT2usCOWqX8pBPp2W0bxizgd61HecekunCL2bSPezfEsJg?=
 =?us-ascii?Q?zPGcwwIGsiCSMar3weVoY+dL9u/BpBQgvOevhATEvC5E4CNtU3qnZHbc0JaE?=
 =?us-ascii?Q?Yo0tFcArcfuRd4aboorZdJxgv+9tZ+inZVkZ11aKcSrwJ7bh4nZqXksxAzEH?=
 =?us-ascii?Q?605d0TCcJfHsrucVTYsjOgG/qlD3fpZQXM5qgyCbN+ANIqPbDDiFzddf1w/n?=
 =?us-ascii?Q?Bf9XEIx48x7r1xFv9RUfJk//2tSM8CxW5DYkvGaMUVOcX6mJtDUrQTXx5AdY?=
 =?us-ascii?Q?OzJVzxH8VDVPgPE3viVlLe/4rJvOZkwIm89FSNPyD3sosw1ijpJV+5chJDdj?=
 =?us-ascii?Q?XdxKMny5eu8RdNosnTPq27Lv4LP82fdMxvCYbCrfxvHrfzNceQhFgQndxfuu?=
 =?us-ascii?Q?2bXdAP74P0DXQ2b++rfClMD3W567PQ71KD2TBhYOfLfnRN+jbp8YaruPgu5Y?=
 =?us-ascii?Q?nMVw4lPrOFSSR4YjvmcXgqCWWpW24VKF40aSrl+RF/11kZun5iNbP43HYyaa?=
 =?us-ascii?Q?3ZgcgMd7nttTRhI+f5dnjfIPahdjnjJ49ozfsOtRNIc6JpzsOC12joatp6co?=
 =?us-ascii?Q?O6DcTINRyoTVQJESSB7vMQOG0jnwYo+IdxZbPQR8Sq9NuZ1Kc8VZIb05ZS7W?=
 =?us-ascii?Q?p4BIxA/lX3p9r9D79iTfM0Y7dcAN046QdgjXtRX6TVOn45WFxQU2yH7SYJlr?=
 =?us-ascii?Q?LJzok8bS1SzD0rRA4cdMv8sXQU6jWqc41/DtA+kIX3JO6FTsuF4ggDwI+/xo?=
 =?us-ascii?Q?M4I1lrEJ05erSlzTbaaSD0U05EJmf4mXGwLaiFfy/I5MzasUYymIIEt51aTr?=
 =?us-ascii?Q?15KbiO59l0wWeWW02MRNafKEHdYiAmlCxjwZip6v2TGv9Z3Yps7mCP5bIdA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b74e0ab-0df6-4735-9358-08ddf1abf194
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 03:24:55.0789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6841

From: Prasanna Kumar T S M <ptsm@linux.microsoft.com> Sent: Thursday, Septe=
mber 11, 2025 9:28 AM
>=20
> Hi Michael,
>=20
> On 10-09-2025 20:55, Michael Kelley wrote:
> > From: Thomas Zimmermann <tzimmermann@suse.de> Sent: Wednesday, Septembe=
r
> 10, 2025 2:36 AM
> >>
> >> Hi
> >>
> >> Am 09.09.25 um 18:58 schrieb Prasanna Kumar T S M:
> >>> The Hyper-V DRM driver is available since kernel version 5.14 and
> >>> provides full KMS support along with fbdev emulation via the DRM fbde=
v
> >>> helpers. This makes the hyperv_fb driver redundant, remove it.
> >>
> >> I'm all for removing obsolete drivers. But hyperv_drm likely first nee=
ds
> >> to merge the patch at
> >> https://lore.kernel.org/dri-devel/20250904145806.430568-5-tzimmermann@=
suse.de/
> >> It's been tested and works well. If maintainers from Microsoft have a
> >> look at the patch first, we could possibly land it fairly soon.
> >
> > Thomas --
> >
> > My testing of your v3 patch series for vblank timers ended up getting a
> > WARN_ON after about 3 days of usage. See [1]. So I don't think it's 100=
%
> > ready yet.
> >
> > But I agree we need your synthetic vblank timer support to address the
> > Hyper-V DRM driver performance issue, before removing the Hyper-V
> > fbdev driver. (See [2] for a description of the performance issue.)
> >
> > Second, isn't it customary to mark a driver as deprecated for a period
> > of time, before removing it entirely? I don't see any documentation
> > on the deprecation process, but I've seen it done in other cases. If yo=
u
> > grep through all the kernel Kconfig files, you'll see entries tagged wi=
th
> > DEPRECATED. Also the driver should be updated to output a deprecated
> > message when it loads.
>=20
> Is deprecating the driver a mandatory step?
>=20

I'm not aware of a mandatory requirement, at least not in the sense
of it being documented in Documentation/process like other aspects
of the Linux kernel development process. So I would say it's up to
the Maintainers for Hyper-V and FBDEV as to whether the Hyper-V
FB driver should go through a deprecation phase before being
removed.

Of course, the purpose of the deprecation phase is to be "nice"
to users of the driver by giving them some warning that it is going
away. That gives them an opportunity to raise objections, and/or
to do any necessary migration to the replacement driver. I suspect
there aren't many (or any?) users of Hyper-V FB that can't just move
to the Hyper-V DRM driver, but who knows. We might be surprised.

Michael

