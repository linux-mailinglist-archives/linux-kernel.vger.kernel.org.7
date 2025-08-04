Return-Path: <linux-kernel+bounces-754731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD015B19B8A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03660177128
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 06:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FF022F74D;
	Mon,  4 Aug 2025 06:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="pn39XbRR"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazolkn19011032.outbound.protection.outlook.com [52.103.39.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82DC226173
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 06:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.39.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754288621; cv=fail; b=T04aepjgrKiKviI/r6SpM+vsOYLDuuRUR3jY5+KXoh9mbOF5yhDFdX2N/yVS9wA0JTLInL+8SN4FpX1UyglF6jTAqPPOLNp7yL3XA5ixJ8unyeldMyU0NWx2HjivGwEerYiVD0Ds+PF2mjtG1U6EB3yrebJTO7bvu3SvejK0PF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754288621; c=relaxed/simple;
	bh=TLIFyoh07CItsaAF0e/ChJqo0zIlc0BI+UfULFdIAFU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ocNuMUP/xP7h9RZwaQu622fdXe+HFl10wl1X0bPARnR7/HMINcgjbOJVT41AFNXMxR1nx5ToP3i01j0EFHSsItns+pXk7NZP2InV1TMiyFdUkGewcT1Z2zowq5+SUzXigjZ/29LDeerTfOoInxYn+Hh3Dka6gycwUx4I0OOH+qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=pn39XbRR; arc=fail smtp.client-ip=52.103.39.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9FNB9205T/ONhZ8I8f4Ztj+n+j2/OXtY7yuMci8MZH0p+8VnHR43ULL+bCL5NHTW/xyYKssolgBWX7ooYhpgYKJX6Jm52VRI57Q35D+qgVIOoOTj/ZdMIEkM8hvfgbuDuXutLvxDIswjtZhD4wl9M68l05sx5ut4r1AYbjR7tvzJ0jdRfD/1v3X/5kEqDDuD4dQrmxiryBh3RycXjl8p1lq9EEm/78fkQgENuiM4eRWlIZjZsTTfl5GbsuwBlzt3H+rw/+V1xn5X24J8LRVn0TXuzpoqY4zzEzh4w73ZPMZbB1vfdM7HtUUIlCxoWvggO2Fl8pImcKWRWYoru7jBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VurZuiBmdk/NuT9SGGY3RioaOspNuk13a3HNyeOO3I=;
 b=ndX1Rx1a5IzMx5dL7QDPKOAbDKvFx2AHkuTj4D2AEYu2sB6b7B81AgO5p8Fitgo4IwaOTgdMxex9sNslQIb1nnJyDL91wRjsqeFDwVTn/YTgHCpC8EYlQBh5lQuAdlIPIJIZwlNvHLC3OvtQZn4YmRMCBPL0SElhXN7pYLuEKt/VgIHwmpzXzM25hiw18fhauI0aKckN0LT+YY3v3aaNFTKf1Ll3gJSU45I8d9Dh2UYnDdcizWvjdjHuCwuhim9vBxj+o055cvV40uZUGieR54tC/68L1Dt9rZD8GEL0LFLOYo5hAWVIevcoDcew6O3IaAUdvJHrmMfFtzJZL1DMdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VurZuiBmdk/NuT9SGGY3RioaOspNuk13a3HNyeOO3I=;
 b=pn39XbRRWN7Cpw0m6FA0xLnjEzvGw/4y8id7p3OouFY7y57uFtfJhkuFss+h1H8XqKHD+45zdS2Xvp84qVMn8XRe8Gl6dHdQhpZkybIwbnn6NfM7gf/0B51dQINtDA2tjdPBmDGpT0MOiNYVGJ9DktY6bpB/ZpuUNvN6AFIb1ma1dJhvWDtJ/LzG5B+uPl6kduTEZFCwfEVlk1/jeJiMCw+ch5cPxQzmR9UtKqpaGS5SS6g6I0nxQ2QTnaVMLo7duZpYUPhUPj8mUM0WKSPPYU5v8CmPX2iReJHjpQ/XJGEMWdKYRe37Cg4dE8kyjGcVozW8ZL5Lh52zfw1bY57dIA==
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 (2603:10a6:20b:63e::17) by DB3PR0202MB8986.eurprd02.prod.outlook.com
 (2603:10a6:10:43b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 06:23:36 +0000
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::5556:4de5:6245:a3c]) by AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::5556:4de5:6245:a3c%7]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 06:23:36 +0000
From: David Binderman <dcb314@hotmail.com>
To: "dwmw2@infradead.org" <dwmw2@infradead.org>, "richard@nod.at"
	<richard@nod.at>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>
Subject: linux-6.16/fs/jffs2/readinode.c:189: loop can never finish
Thread-Topic: linux-6.16/fs/jffs2/readinode.c:189: loop can never finish
Thread-Index: AQHcBQfRDoZHJasgNEalzePb9X2IJw==
Date: Mon, 4 Aug 2025 06:23:36 +0000
Message-ID:
 <AS8PR02MB10217F68E5D37ECD491495E669C23A@AS8PR02MB10217.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR02MB10217:EE_|DB3PR0202MB8986:EE_
x-ms-office365-filtering-correlation-id: 8a02c3e2-2eb3-41e8-8f23-08ddd31f71cb
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|8060799015|15030799006|15080799012|19110799012|31061999003|461199028|3412199025|39105399003|40105399003|440099028|51005399003|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?rPU/Uttc6355fbugwMPusZo/pEVEm9VoD/cyEztt3V/OfzxaxoopQyvjTb?=
 =?iso-8859-1?Q?Q4Rkr36hSajxQxhBaReZ14zDQ7wORRaeubZmb9UTf6qDg1TabqBYQ1DbY2?=
 =?iso-8859-1?Q?IUE6bSO8B2v2i2zK9OPP31dlCOgqekmau7FEawWnp/5mrDHkHg0xLQRb3u?=
 =?iso-8859-1?Q?SZr9w3nRhVReQGcipkqZyh2bTy0qNtmVcnXMJhy1b2qolv+IIc2441GvU8?=
 =?iso-8859-1?Q?feHtWE9izMKHuWCIJNFQbVFpZJwLX4Clz8JhukfCirBBr3wm9pkNnFyur8?=
 =?iso-8859-1?Q?m1yIFGpLVcqejUv9iQdZvT/vC9bmDUoWMlsJ1YNWD2pNRl2gR6iYejP99H?=
 =?iso-8859-1?Q?k3oxpGgk3e8h2HpSHFQRjsu1n4KlOrGewVfF3NtPE3+kSCQn50hP72W952?=
 =?iso-8859-1?Q?at4Wx5eIvT2o+4xBg/fYBtmmm0I7sOflbGXTvqlARw/Ui2DaeETjI9pUR6?=
 =?iso-8859-1?Q?CZqz/PyfJCg82Xsu7lzjAo34ZmxVTXQBwYXIr7Mn6llLr1ehwkmY34QWrz?=
 =?iso-8859-1?Q?0kNt+UbLLlib+2ZfYQg27mgFSxp9EqYKLTibOSMejlK+IiSiso/GSxv7kH?=
 =?iso-8859-1?Q?v4diUGJ4XA9RQnB1/QKzRjjVgQTWG3OoxlHQaVno7DaiUmkP5LOcAM0yZW?=
 =?iso-8859-1?Q?cfDZKf6bv8jJF1T+GQvM3iYZgKaqH9O5WHHMrNpGREx+P1VecK+fXoMAe0?=
 =?iso-8859-1?Q?+XuOYNJzia5Ak6MK2R63fmv/tArLIAodLxQMwno+2TgqJRuNdrHil7ByXH?=
 =?iso-8859-1?Q?Ms8dj/0cm+gQw+dngENoUinERKsqmiNpCVpPQ0mEAmB0LZY2eRIhiWEJEL?=
 =?iso-8859-1?Q?JSo4er8ytb+WRyT24lSFpNeSTyH/xS/cuzuOkvAPIH2C+AdF4JbTgcOxCv?=
 =?iso-8859-1?Q?Fpbtw5VeLTPsAqFqwup9l377dmuW/Q4DncT4FcfjAUkjFTaRsROq80Bz5M?=
 =?iso-8859-1?Q?AHcNBh29YSVp80oRs8uy8fJgyxmUWUq8VWcvlagXlE0tcYCIgOS8nPaD9X?=
 =?iso-8859-1?Q?TSgxQnh5b9KJEaHDVmDzWZ+uct/x44yDqr0rn3mLQxWYIhkRqYSD9U6Yzv?=
 =?iso-8859-1?Q?4O+Nj9+sdaL4kEP/Q7rn4eFlZ1RvbhGma+XoJ4AdEaJfgUeus/6Pxx59Vv?=
 =?iso-8859-1?Q?WlV1bnd56C1772yi45A+o9OETdrbyFYbDFMIczRTkI6ILzDhZsCWF3puVr?=
 =?iso-8859-1?Q?k5mDNvPKFSzL9jJ9PL7Y79D+GFxqPtYZbbh3ZV9NP8DD+diHAUzkV2YANz?=
 =?iso-8859-1?Q?nVOOVEK9J8k7IBhXKmUIhGSpmqwiumkX8lbyjkoSg=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?p9kCqJWqwLEfeoj2/rn+C8zH4el6QxBggW2K8+b/dNzONncB/6JYXPZK5L?=
 =?iso-8859-1?Q?hPzPJ4KkTmFZytP8YB7cdeA73PqE5UK14L8hPfIbokkyYOaTv10wvLHloS?=
 =?iso-8859-1?Q?suMSz8RenZ31FAxFRoaGRV7bwvj/A8WssSwwaKO6JAFzuXn2JdzaBwP5dk?=
 =?iso-8859-1?Q?SC+YDLXxtWgM9m/CQCyWfmfQ0wkpO015BmbItYmMJ2BccQPxXlPljnmZeg?=
 =?iso-8859-1?Q?Wv9ak7hrIf+o/pWUh7WeQEqWS3t+Jt4gXOZqmMt6Hsg1M8lzoC9MooPDim?=
 =?iso-8859-1?Q?PnRlHhuFQhZOnBYx0PuvjX6D8ixD5td5hw8jMtSJ8EnYfBz2wOZKkcErEb?=
 =?iso-8859-1?Q?bmuL3jtOA9PDj26wXw1AhSJ+uGGPdvB0QoVk79PeOj8ALQuH8OSRVPsHbL?=
 =?iso-8859-1?Q?cCKTmDrOanImx6Wfyp5/NhaJYe3fC6g64lvnh2Fr4xDg0liCbnKL18/fWM?=
 =?iso-8859-1?Q?dMy3MBQxraM7xnFhaEMRlCaz0Be6xuQiHDbx0zWFZMS8zdX1rH84uCQ+kS?=
 =?iso-8859-1?Q?Udqt53BbP1PRMLAu9ZXbnOOC0K7TTfqvrqE1BstQlVQfSW1Xw0ObDYx6N7?=
 =?iso-8859-1?Q?s5YL8izYLCF5scvi0sHzxqHoBveHEyOd88LdvZk0lZBiQNNfAz7jgaRtKY?=
 =?iso-8859-1?Q?kFYJoV8iB5wQI1d3121Gu+XcMbGntRSx9fHflMXHwYgSee0AP50iBl9hwT?=
 =?iso-8859-1?Q?ItzUNeKqpWR/R0u+RiPHh0SZ3Jo3M0oWjZvTmUHN3QanjLPk14dPzsnRBj?=
 =?iso-8859-1?Q?vZV1p7O6t1gEjUfNdT9IP6BNxVIbyj8+mwYeFxPmJgSK998BKJf5q/TUQ3?=
 =?iso-8859-1?Q?yjHZnjSnQFJfUqqfff6trhRW7fl60RD8xhde3cXgSNp3P4z4wWjTofA8n0?=
 =?iso-8859-1?Q?asa+6biy8C7UdmhD0JY8eMvXXzCAJuYg3hNHCbKdjMuJElWwOPQ28qAVeb?=
 =?iso-8859-1?Q?7KAQz9vcAcjiD7czS2458dlA+6XWvVpvwH6+gjgnZ1jhHaao39rS0nnP60?=
 =?iso-8859-1?Q?RpyVrG9CjpOsEHfeuukzMC7BmcdrSwgGJVT0igssQPtFz+/hcRtKOlykpM?=
 =?iso-8859-1?Q?H4L/YrRUwP3jnkPCIRrf18N4FAn+bXuumVbBn134I2kPb59MuJKgY76p9L?=
 =?iso-8859-1?Q?Y5XLWPD1SYPWUjDLwyI22KTfDcsqsVv8Y+1ZWTVxlTkbZDdaXkpPiqhWki?=
 =?iso-8859-1?Q?j4WjK2GvoJ7ms1ZmhR658ahkmeGsYl3VxbX2Kd6lsxXtbHWjl6bQ8srZ7a?=
 =?iso-8859-1?Q?dSFqFWY0RnLE3TDSEQ6g=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB10217.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a02c3e2-2eb3-41e8-8f23-08ddd31f71cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 06:23:36.3013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB8986

Hello there,=0A=
=0A=
Static analyser cppcheck said:=0A=
=0A=
linux-6.16/fs/jffs2/readinode.c:189:24: style: Expression is always true be=
cause 'else if' condition is opposite to previous condition at line 187. [m=
ultiCondition]=0A=
=0A=
Source code is=0A=
=0A=
    while (next) {=0A=
        tn =3D rb_entry(next, struct jffs2_tmp_dnode_info, rb);=0A=
=0A=
        if (tn->fn->ofs < offset)=0A=
            next =3D tn->rb.rb_right;=0A=
        else if (tn->fn->ofs >=3D offset)=0A=
            next =3D tn->rb.rb_left;=0A=
        else=0A=
            break;=0A=
    }=0A=
=0A=
It looks to me like this loop will never finish. =0A=
Suggest change ">=3D" to ">".=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=
=0A=

