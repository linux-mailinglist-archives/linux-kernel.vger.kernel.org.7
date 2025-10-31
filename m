Return-Path: <linux-kernel+bounces-880640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A58D7C26384
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 293B24F565B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DDE286887;
	Fri, 31 Oct 2025 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Qvy4zdJ8"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022137.outbound.protection.outlook.com [40.107.209.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6E31F09B3
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761929165; cv=fail; b=ffZg0q5yhZ3H/s4R7LQiesmxrNXy5keEKSdnFvzHYVD5QXmdMjnKDW4QQusPfWWGpfHW7UynFalfpLlhVC2k+TP1IJJV1QcHROOrQSHtzHIAkwA3l5yHkhXwPnawPDjVC/CSnx4UJvjSd85ualnw0S3v+tGmgQ/Ke3dINHsFUlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761929165; c=relaxed/simple;
	bh=spe89dhf426qBo0so+8QW/+BtAjIAAwX2K0XFJrG1ZI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GuCMumY/SGleDuZQ/Xs+KRMpSwR+qpMwztc8qvX9S7CzludP6qOmb7mvWqaq0FUp7w4sRWHxOYyq7MyknWHdKB8wZ4+nLEB0jsMbtv7bp4vwkKiZ2ZZ1Nr7X2KG8lFXuwjJ/O0xDefqwzl7DKvbpUQlg87M6g6xftKH3gnpkIU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Qvy4zdJ8; arc=fail smtp.client-ip=40.107.209.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXvuUMjmWUOL0d6F6jaBrezzqoC33b1I/vLF9NQTxiLj+sXAhTYRtubV5jKBpyO7wRJacDSeJMSYiDUgFHIiOFol574EfUlvvW0BdG4ZzsjrPVmf6yKbBpa6gJl1qf2hNpQE5o4Y5zPmI6Tb1IWQm9iJVedkvtGXAFXZuFEGLFeYl56Sc5E4Eysljchbh9CSbIDp45qTkqbsz+xP63vlsFR7JaS3qlLltcshlnc3/hcj5LsmKAzVN8nybg0XgWVSifDTJA0vjd1CzzRea+w1+cFnGYwbLoe7fF7ew37BaQJXj4l1mII85qiBapdxulWd1+AWFYsv1QFJu13sAgkcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spe89dhf426qBo0so+8QW/+BtAjIAAwX2K0XFJrG1ZI=;
 b=ynsvoaszgwGE5lWumW41ewdOrbPyPW5OtITFGqzEkoaMiSvlbT7iR7RVHkEp0Gx8ckDiXoVZhaRABdi6M8btV7QkShnECRNxP+HXC6HRJA/DGRh3AY2/E7wU9XOMf1JGFau3Ibory46wC2c+xXYFgpYn0Jbw+VJbVeOxROorXxZCqc58G/9XCs0jRJclQiCz+Ynxb+q1bpukIpFZCqtZQLuRkYpE1G8hx335uFPj/9j0kab+YxACDhw07xogP7oMuQYKQnt7I0NgJck0ca1rUv39r7BdRNeO3mE94ObBK7uD8GpMGa8rPAQ3YKaXWySNNNUFNnIkyyoB0oelRbPSXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spe89dhf426qBo0so+8QW/+BtAjIAAwX2K0XFJrG1ZI=;
 b=Qvy4zdJ88MOftAE4LpCTTukAEO2PEFUig7IPkzAfjWNGGsJ81lTpoRL2MM/wACOc/Aj4+T4Uv5ih1lHmuCiSRHDa7JY3Oy53NkXaR0CGz2bcxmPSZhdg/BXktt9E9N+hUy2Ls42QoXFEDIqrg3hmVuFrBYlUBkfPWH6+O8Jzh+s=
Received: from MW6PR01MB8368.prod.exchangelabs.com (2603:10b6:303:246::7) by
 BN0PR01MB7197.prod.exchangelabs.com (2603:10b6:408:158::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.15; Fri, 31 Oct 2025 16:45:56 +0000
Received: from MW6PR01MB8368.prod.exchangelabs.com
 ([fe80::1f1c:cd78:aa20:86c4]) by MW6PR01MB8368.prod.exchangelabs.com
 ([fe80::1f1c:cd78:aa20:86c4%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 16:45:56 +0000
From: Shubhang Kaushik OS <Shubhang@os.amperecomputing.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>, Shubhang <sh@gentwo.org>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shijie
 Huang <Shijie.Huang@amperecomputing.com>, Frank Wang
	<zwang@amperecomputing.com>
CC: Christopher Lameter <cl@gentwo.org>, Adam Li
	<adam.li@amperecomputing.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: Prefer cache-hot prev_cpu for wakeup
Thread-Topic: [PATCH] sched/fair: Prefer cache-hot prev_cpu for wakeup
Thread-Index: AQHcP7nufbPJe92xekKQPJRIOuWzsrTajIyAgABqYICAAT2hgIAAUlSO
Date: Fri, 31 Oct 2025 16:45:55 +0000
Message-ID:
 <MW6PR01MB8368D20CAB164517819E9C8CF5F8A@MW6PR01MB8368.prod.exchangelabs.com>
References:
 <20251017-b4-sched-cfs-refactor-propagate-v1-1-1eb0dc5b19b3@os.amperecomputing.com>
 <c22de852-f2f6-48d7-831f-ca2a06365783@arm.com>
 <d1cbc53d-d4cf-bc5a-6468-89e9a1d86f33@gentwo.org>
 <b8cb522a-83be-49ec-a4ca-5c084757fb67@arm.com>
In-Reply-To: <b8cb522a-83be-49ec-a4ca-5c084757fb67@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Enabled=True;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_SiteId=3bc2b170-fd94-476d-b0ce-4229bdc904a7;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_SetDate=2025-10-31T16:45:54.185Z;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Name=Confidential;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_ContentBits=1;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR01MB8368:EE_|BN0PR01MB7197:EE_
x-ms-office365-filtering-correlation-id: 77f601fe-883d-4f6b-46e9-08de189cf64e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fP2c3H4goIAO6otLKsOzpYIMibOjN0r0g4RTR3VWueSpTiogZDZXiac6wRe0?=
 =?us-ascii?Q?5BpTsyOMCfx1HaOvCCXzptEbdoMa+bQDnCOwJwltBXEWo4uMpVqM3VKQu7b5?=
 =?us-ascii?Q?Zxjua7Txrr1HvgPzdMA9vXCWAp5O+CK29sCvgTuHBNi9feWcDDFhh+SVvIW4?=
 =?us-ascii?Q?uH8qrxkXtQO84+/aQQqMCW8bojx2TW2vEXrMc1ojvCCetxWQaXkcnpPAFdv3?=
 =?us-ascii?Q?0R4p4iGcBnsDrdmKkKFbBO/oyXqT5GAQhvYcLaICaLUuF8XfhUdlXqzZwH9+?=
 =?us-ascii?Q?7NmojORQ5RO4FbvHkX++plrq/G26UhS3RhShl3/HdWY+Zu5HEP/XG38BlVA9?=
 =?us-ascii?Q?UIbtyTgWQa7VKSmAY3oefndD+m9aA02pOFiCkdLIH8gRNb6i67fs5mleOsKQ?=
 =?us-ascii?Q?WfdK8Q5ekjunwXwetCbT+jIjLmThUmH5qaiLBDohzelO5A/xMZM+/SHIlbTG?=
 =?us-ascii?Q?JQxmT5ONFlTf38idpFfzjTE7AHcZkk3lNy7y+iG1X0mgRvw4OCjvWYp5XnEA?=
 =?us-ascii?Q?WzZ60egQehmQWyhyMojuIzimxaDTt9+jSdGvnKWPt5we+1NRIb5lFK+ZaGOk?=
 =?us-ascii?Q?2qjkGHGlGWK8RbPPTsFULNElKWXSlhb7zHTwlSBwJFBoxRcMzq+9w+b//FX8?=
 =?us-ascii?Q?d524Ctuw1aS4QQ1xYY8KCEnBpPSNDhsKyrfNKjMTQX6xdyzp8d4x52o73kku?=
 =?us-ascii?Q?0Mu4eWVM8e0RpbbI5xoeN7oZlrbnL8PgLqPxCfId0Bxc3W591S5RRTh7YB/J?=
 =?us-ascii?Q?UTq7J8wqe/bcaAdI/F1+JrQlJPlxxY7OXjs2lFjpimDBTVAFZMfqrx48HtZR?=
 =?us-ascii?Q?eKIOIvNsdAZIfDBfIvhkT0OQRVKtHLgJbl3sbTIABhMdktqRV4xsokdnN9QQ?=
 =?us-ascii?Q?Mn5xDdIaeFUKuoME8qWy/6BI11rLGyMNsdkg5/I/axR8fwTnIvLVzVHH4D92?=
 =?us-ascii?Q?ra+7ltti59nsC3sAwRBv3MYE8y1XagFvo1/ySgH9y/kuk55B/WzlA5pht1c/?=
 =?us-ascii?Q?z/pvFbTR6Ir8evFK9uAK+0Lf4LAMOQNQpu5KwEGvsRuiMHwgXDBC39TXec2M?=
 =?us-ascii?Q?R2b5DI8QsyZfcNtfLkabOyCRRhWq29xFLffdBpXJWbERKzVrKDTjFWC0vZA2?=
 =?us-ascii?Q?zq3p2PsgxviLbse4hxj7O3rH6+d7n58AusxpfpSd35IS/i3D5rJiR7T5Ysbd?=
 =?us-ascii?Q?HijlcFEJ6JVhK/WxM8x46ojvw9MXUQx7xO3qgFGUhLyf8lEmFWavsSqAViX0?=
 =?us-ascii?Q?GkRv67TOc0mIoC/nMYhEMki4XaAqUcbK36gx7l8iBohllEUr/vIAG+/7C5Ki?=
 =?us-ascii?Q?IGF4Da9rEbgtSf5eBRMYWw4/EwMJJONY2Le+YaHWygLjWJmhlWwkYZj34fKW?=
 =?us-ascii?Q?HYwE7xn8VIpjCTA0MqCD0+zWy2RYqA5QySLVsrlM+EpC2+oRZ2YTUAUeop2E?=
 =?us-ascii?Q?CAU4o2E98FSRh/M+KR+Ti3Pco4mUgdNuPXcLuNJ4rh1nu/TxceWs3+NDppDx?=
 =?us-ascii?Q?F7PVh7fbthTQIcEjDI/R+svygadRbG0xyTEikgqxaMgZLMyUe7e8PQsy1g?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR01MB8368.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MUbDk7iUSTOsLf9hPwuvhRkI7XTUsinbmgfKmRzpz8/lqwjLwVYT0+ICj/j1?=
 =?us-ascii?Q?JJvEfFtese4Dx4J6cwXKe4KPUu52/FJXAz7dzglGFzcICnHhQL6jTCNn1zPY?=
 =?us-ascii?Q?HKwC2+yaqV4NSJmveu1eBDPGCxAZAf1dXtlcuUtQ76MSyl96xySZq1ogN7IF?=
 =?us-ascii?Q?OJyDiZtTs3lGXh/1ncZcjcrdNDUa+DCLebZ1kGhunW1ML85LFIXTfmi6xlhC?=
 =?us-ascii?Q?j/D8REnMh3Gomrl39RPPIwLrowkNmAGvI6e8O8xoLNC54YYdUGGf934gzg98?=
 =?us-ascii?Q?pNYP75c+Fq3bML3JrbH0WBgtkcsaztWKfGo8Gt/wYVM0vfPXugOYoz7HLsRR?=
 =?us-ascii?Q?MmhpO3AuUa9vGPz4FRPZoDquFovR5evFw0/MIHfEa8bLla41IwkvHXVC5gLx?=
 =?us-ascii?Q?Mv9bWv+b3zzUw5mOzQdxBjunwWfUSxCeDPz1LY/WLGGJ8diW7S2kvTUGmimf?=
 =?us-ascii?Q?IlCPjGM1eY4f9kLt8iDT8M6XEj3uGljgh9JCKXnv9nRr6O+YlHjBb90ViZew?=
 =?us-ascii?Q?WSdCBHyArouYdSQ6O04rBzDvZjX9FVX4rlAfJc2vuFE5L8htPbgnnQG0lLMr?=
 =?us-ascii?Q?CZSchLKcCOdk0wY4IOGxOWr96zx+nLh2EpWWz0ccedZ6byy8S1lwVtziX/Jy?=
 =?us-ascii?Q?1pXcQngdGH0EmXtfJO1fSOYarSArDcet6ECHiCmcl/eSY0pQ60A7kNySYnrb?=
 =?us-ascii?Q?qGomzrOuOFo8q7inJvA5Xxhdxq/4joVSItZZTKkxjnS7nX5MK8Q/c3Vn/oeb?=
 =?us-ascii?Q?2TPgsaCnV16mkj2pGKXoSuKlJYQo2w8MBqe5PJBzAXuyvtSecxDnnGPtiES2?=
 =?us-ascii?Q?859fE7hS66nCGJyRAMopsXtpQ5mXpmQTk/V1VQNCgQk3m6d8W9abrF50nIGd?=
 =?us-ascii?Q?HUVoemNrCdbJzQSwJ3ZZhH7tdAsj/TcmB0uDHgjNuTRKbWURJJUTKZDl84c0?=
 =?us-ascii?Q?/Ys909HTi2hylQoM3G3wol8kEjMs44Lw7H2haGtbe+5SiJ8OnYzOtoApKTVq?=
 =?us-ascii?Q?SI0mA+9vfIJtM5D3dujpn3gFluWmzhcCV16+XO5XRJPifL+RTDCmhILTMwe6?=
 =?us-ascii?Q?mTT4kASvwGZu9W97XLysSafABGfx7DY5w6J2DdrRNZvoTkL8F5d2CnPS//z4?=
 =?us-ascii?Q?lXc17aHjnFpyb2HZQe1y4LoLNHUXzAq7hSBjpsbMm9pQIDwgk66kBNO+TnIo?=
 =?us-ascii?Q?ecPNDtZbveaIpNf9Ix/k5Fz3eMuXLNubLN0CUyRaEoXOTSW9knpJ8t310biP?=
 =?us-ascii?Q?YeaOUGMliz6jaTANd2yLQ841zfk8n5UatEZdtxy079XwD1TbX+NqCyGCVMZP?=
 =?us-ascii?Q?+n19ozDkgWEn96hylbOl3v/RF+3W4GiQM7m5SXUmSlyOeCQ7gNKMpS0IU8o7?=
 =?us-ascii?Q?GRPPA6hpIw6h9gh4X1QDxUX9pEoANIdJRz2a1NMuLMlU4Lru23rLbKZQczd7?=
 =?us-ascii?Q?PUYniolgJc8krULrRmGFxGQZoMaQpLrQ5uSUkKZDouAhPxgzjv+cmzJvEHN3?=
 =?us-ascii?Q?XuUhBX7ofs1rJVDMtbkuyfoqviSjr3e37r6iwK/V2zVZA88kSBtuvmlmQmU9?=
 =?us-ascii?Q?A/HSMbQDFUhH/C0vvobvRa9ggVJFWPFtFzqDd5gdEP+U+ueu69f3E3C+eEY5?=
 =?us-ascii?Q?INYx6Y31gULV8AggypvNS3Q=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f601fe-883d-4f6b-46e9-08de189cf64e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 16:45:55.9101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m31TuvLDzqLLv8a1HjojD+U1Pr1ILy9kWu+t/MQrioSxt1c5HWzPkrrS7Fn2pr+BqnUpneTiD3uxe6YoL0xYVY9djuGePPLcueD2spJKuhJILsi1YYEqfI9soSjcAmMd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7197

Sorry about the confusion. Upon CONFIG_SCHED_CLUSTER enabled, we have the t=
wo distinct levels of
scheduling domains : the 2-CPU groups in domain0 and the 80-CPU group in do=
main1. Yes, I would have to avoid EAS approach altogether
as they require asymmetric CPUs.

Regards,
Shubhang



________________________________________
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Sent: Friday, October 31, 2025 4:32 AM
To: Shubhang; Shubhang Kaushik OS; Ingo Molnar; Peter Zijlstra; Juri Lelli;=
 Vincent Guittot; Steven Rostedt; Ben Segall; Mel Gorman; Valentin Schneide=
r; Shijie Huang; Frank Wang
Cc: Christopher Lameter; Adam Li; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Prefer cache-hot prev_cpu for wakeup

On 30.10.25 17:35, Shubhang wrote:
> The system is an 80 core Ampere Altra with a two-level
> sched domain topology. The MC domain contains all 80 cores.

Ah OK. So I assume the other SD is CLS with 2 CPUs?

Does this mean you guys have recently changed the sched topology on this
thing? I still remember setups with 2 CPUs in MC and 80 CPUs on PKG.

If this is the case, is:

db1e59483dfd - topology: make core_mask include at least
cluster_siblings (2022-04-20 Darren Hart)

still needed in this case?

> I agree that placing the condition earlier in `select_idle_sibling()`>
aligns better with convention. I will move the check (EAS Aware) to the
> top of the function and submit a v2 patch.
I can't imagine that you run EAS on this machine? It needs heterogeneous
CPUs which you shouldn't have. Looks like that Christian L. was asking
you already on your v2.

[...]

