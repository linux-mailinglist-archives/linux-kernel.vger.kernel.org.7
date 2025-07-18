Return-Path: <linux-kernel+bounces-737232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D20B0A98C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BCEF179EED
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B312E6D3A;
	Fri, 18 Jul 2025 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="i2GWZ/dx"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2094.outbound.protection.outlook.com [40.107.22.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E0A80C1C;
	Fri, 18 Jul 2025 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752859994; cv=fail; b=J8I8riEWosv0ymuVMI02MG1d53dGm+XoM4vxMAO1ebZdKsIeq4YKtfUeDDm3yEaf1tMnPJRHzGQCQiEGAE7rD+mG59agrrEWWMoDh/r20wrQkLv8u6SZ6Q+hr34egBzvhhtM25SCHsFFpvDoknDIr8w0/HnG/5JTxywEB3ipObQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752859994; c=relaxed/simple;
	bh=8Zh5W39tp3NasQHlm1kky8nJQnoU5ZdBlhj17cCijxI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SY7svN/jwU/pAHVhVn7n7oToQXtOZQA9sm5j/QYiQBb/E9ngAA7SEt4BvBRj7T2AoeqGEXlUdO5l9etXfDmUuBUrxHn68xz1gtCMQq5qJRGD+S/Rd8pN67w6pI/ztfPoyzmWdxw4o+6Leq3R0yGaf2uQEGBI27wfmYeLXea6mGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=i2GWZ/dx; arc=fail smtp.client-ip=40.107.22.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQ+OueDHc9eMwu1ie2KonlFLV7RrAQ1j789BIioDcTziy/nNrH4zMwYJ2+OC026bDBdyK4B1e4vDcKwtet3b8l5OKX0d3WaHVU9oenNnSQHkPn29DCsmXBSUkrCEWRiNaSzmVF1rop8SN3iBKoUmgAblPEKIirDCXF/HvwV2JHUzYc9BQKMafF0fsVqxkGOiHsu4Sw5nVD1dHhGof01AWO/CldLnlhrG3RWkVJCAokIlhrGQc66zK7K2XvqNus5msm3mjbDS4TXTa3Wi52XunawMLk/8T9fU2Wv8FXd2mEWOZCEFqgIcFgRFEr0NQ3nCOZSqUUo1s+wuowIeAXprpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Zh5W39tp3NasQHlm1kky8nJQnoU5ZdBlhj17cCijxI=;
 b=tuS0mpLqGBlcb1Yscpij/Ho0vtu0Qb2hQpdPgX5DmRkOYH7BwTbOfT8F1R1LkQDljVNN+pVKyOC7YSUn2ynldk1/ajfJyFPuUVDEDaghj+ZHiHk0d8BQkkpk0NChKICCVbutanmPB1TcHJCPYWYwHTZmibl8Z4wWVAEalmxOmNweC+b1EGvLOfObQtGVAfmmWxo3qMryCFRSZRN2AmjNEaX0u4xSGwbWuze24wCPI/AXhfPq6FCDdgG5YjojmlH0yWTOp0g7V3RmAq3aR238dDBJ8pXBc1MzuZx8u2zmo0y8RGQDr0nmYo+uTZ69C3S6M3s99FwGAuqtfMiOmZ9uIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Zh5W39tp3NasQHlm1kky8nJQnoU5ZdBlhj17cCijxI=;
 b=i2GWZ/dxAhbp/KbPRFm0Yk0iLIl9X9OOo5CU1MIv9U+1vpMIEcqFEbeEDxgRgSzwKdTal+On5xEC2AFqmu000p3mvQNUsM0IOOqOcFdb0x2qE+wFTP8LJlCYkE3Z9KQzpmUDd7im4pKvRU2KSPDzuTjMtsGY3+FovK7ka+0vv2o7vGQoyV60SOJ3AsjiysY7N3OQxzwUuUp5FyKS+e0T0ZL214xYYf8nz0pif+KLw5OeGsmZdXlpYjk1o0dN/tD5nAMLDoQtESzAZbj3xZwpTkqkTMr6ySfW2dbv3KLxPknsJGm07GzkfUsIF8kKM4WhOBdiOb6kzgQe7oVx1QPqcg==
Received: from DB9P195MB1212.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:294::16)
 by AM7PPF7FE030CB9.EURP195.PROD.OUTLOOK.COM (2603:10a6:20f:fff1::755) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Fri, 18 Jul
 2025 17:33:06 +0000
Received: from DB9P195MB1212.EURP195.PROD.OUTLOOK.COM
 ([fe80::2d26:fa56:5972:5247]) by DB9P195MB1212.EURP195.PROD.OUTLOOK.COM
 ([fe80::2d26:fa56:5972:5247%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 17:33:05 +0000
From: Christoph Stoidner <C.Stoidner@phytec.de>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>
CC: Stefan Wahren <wahrenst@gmx.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "upstream@lists.phytec.de"
	<upstream@lists.phytec.de>, Primoz Fiser <primoz.fiser@norik.com>, Andrew
 Lunn <andrew@lunn.ch>
Subject: Re: [Upstream] Re: [PATCH v3] arm64: dts: freescale:
 imx93-phycore-som: Delay the phy reset by a gpio
Thread-Topic: [Upstream] Re: [PATCH v3] arm64: dts: freescale:
 imx93-phycore-som: Delay the phy reset by a gpio
Thread-Index:
 AQHbzJ5IkKiCUrqPH06p42f/+549BbPiDcKAgAJsSwCAAChcgIAABDUAgAALOQCAACRcAIADjdKAgAAQWYCAAsNAAIAD9cmAgAChPwCAAAtVAIA4UzkAgBBNlwA=
Date: Fri, 18 Jul 2025 17:33:05 +0000
Message-ID: <ad5e7450c5cf3a2f9a5d3c23f7219eb08be31062.camel@phytec.de>
References: <b2ea6b7f-3623-4486-82a0-cab97053a53e@gmx.net>
	 <34a4441d4b4ed8db7cac585ce93ec2357738cc11.camel@phytec.de>
	 <7f6d7199-0a20-4370-a8b0-1d05326af052@gmx.net>
	 <bf0eb48fc72f4b0abbf62077c2f1fe4438579746.camel@phytec.de>
	 <967484d9-4165-4b75-bbb7-a203c36e8beb@gmx.net>
	 <517be266ebc3b55da53372a76a139245f8945cd8.camel@phytec.de>
	 <5afa6d62-4a3f-4c28-8165-363075ac36d8@lunn.ch>
	 <a948b903766a82897e5fc17a840ab40e29f5eda4.camel@phytec.de>
	 <8e448625-b4ad-4bf1-8930-6fecdedb1d8d@lunn.ch>
	 <78ec24d09d129d52d3442f6319cf1ef5b6ce7f3d.camel@phytec.de>
	 <739f93d0-4cb4-4f1a-8792-84502d4beefe@lunn.ch>
	 <626bca58-e481-4d6f-9bb7-252c040f4b3b@norik.com>
In-Reply-To: <626bca58-e481-4d6f-9bb7-252c040f4b3b@norik.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P195MB1212:EE_|AM7PPF7FE030CB9:EE_
x-ms-office365-filtering-correlation-id: ee2bb20d-34c1-45b5-51f9-08ddc62127b4
x-ld-processed: e609157c-80e2-446d-9be3-9c99c2399d29,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|4022899009|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RUZQWm40Q0kyS0lsWmFFcXo4K2hTamZYbk4xR3dBNHVpVCszV0NSbVpIN1hR?=
 =?utf-8?B?alU0cHh5aUkxN3dEd3FEdzA0YWlUa2xsdzY5SVkvSHZMdXRUZEptR25URkp3?=
 =?utf-8?B?bDlzbW1oQUJYY0NqQlg0WlpOMmdQTWRCZnJ0c3pSNGxGL1VjRmFtTDlvMHl0?=
 =?utf-8?B?UWg0cGVObklZNHFxeTdwZlE5bnhJeWhpUSs2RVBCcGQxMFFicWhBTk5PUk8w?=
 =?utf-8?B?WGUvdUprN0dYa1RFYnFMamJUSFM4akZDdm01ZE9Oelc5REhmVVdGaEtQckVo?=
 =?utf-8?B?ZzVRdmg3NiswU204ZW42Rk9pTnZSZW1xT20zMW51YS9ocm50K0hQUnAxNVBi?=
 =?utf-8?B?eWxicVJvbTBTTHErYjRLTzFjL3hTeGlNMENvL0lrVUZvbEdSUUtnL0x2a1d0?=
 =?utf-8?B?ZE5OVEhOeGhBMGJlenk4OWxsZG4rejlkOHJRVjBSRVd1VnZFckxFSlk4UE5N?=
 =?utf-8?B?Nzl6M04vVkl0RWhpMHhkclFwMzdCWEorZDQ0M003Z0s1SURUQkJpZS9HclBQ?=
 =?utf-8?B?QUZGbW9UTnJJYjEzUWdpS1pzYk5iTHNhdjFTQnlwdmQ5Y0hUV0MzOGdDaWJL?=
 =?utf-8?B?N1lEb0dDS1hQcHJpMXJuQVZwS0JPTlA4dlJSczliTHNML1dFd21iWDYxcnJC?=
 =?utf-8?B?MVo1RkNsbGpLN0Y3VnZZeVpxVWEvVWJ3WmtpUVJERnBleTE5YmZIdE1DTFEy?=
 =?utf-8?B?d09aUG05VU11MVBxQ3JFT2Y2aWZWa2R5Qk9CdldoQ2o2NVI3T0pyUklVQzZo?=
 =?utf-8?B?ZE9uMUU2a05GRU12cVpqYitPR0xRRkZ5ZmFGa2EyT1ArdW9ncnkzR2p3WXBi?=
 =?utf-8?B?Q0tJclNadE9kYW8raWozZTNVbkZhai9iNnBVc0VuSkRtSjA5c3dGQ3U2aWRh?=
 =?utf-8?B?dFN3TGdOQnU0U2UyZEFvWnowYlRjbm5QbTk0M2lxNXgxTXRXZldraGQ1R2Na?=
 =?utf-8?B?UHVHUDUyS21vYzFEZG8vMDFlanhadXlvOERqK05Sck4xVHgvQVkzcXBqVW1Q?=
 =?utf-8?B?SXZNU1pJK25peGZlYlc2Q09aYzNEVU5RRGJ2NDhpQWNOZ2hUcmN1eDZSYkto?=
 =?utf-8?B?NCtMam4vcjA0QlBwUS8rekp2ZUEvaVU2SmFNTG02cFg5MVZhUFFNb1oreGNn?=
 =?utf-8?B?K0owUEFucnJXemp1Z1FUTFo4M0RpSGZ6ckw3SjhwQjBldjBaa2QwWjJNYzV3?=
 =?utf-8?B?b3g4anN0NlpnaXZmYjlLalgzWmRlMThTZWh5KzA1TzlHbzRmUEUyRDVKWkFp?=
 =?utf-8?B?aFpKVWNQNW9yaGtFVHJHZWJsZ1lXMnVJdFZZY1VIdXYzUVNjSHIyWUFHaGNj?=
 =?utf-8?B?enZmQmhTUGdaTG8wTDZoblZReklDN2xvOVNrMzJncXdWMmRLcnhCb1hRWjBT?=
 =?utf-8?B?ZGtSVUorNFlnOVp6OHpkMGRvdU02SFNmdndIMmpvQjRCdm85cmpCV3Z1ay9P?=
 =?utf-8?B?VDViTXJ6RjBzQSthYi9xR2V5K09EeDlLSTFSenZINENDTUg2S3ZqT0JnNlBi?=
 =?utf-8?B?eFhZZ3dBdTMwLzkvQW9wVnF5QnJFemxKcWZRaU9LRUhoVlVCZVV3TTM2UkVk?=
 =?utf-8?B?ekxTRHFuK1FDYWg4K1M1a05PRjZVZEo5ZlpIckx6SkQreHdFU2E1UG1PNFZY?=
 =?utf-8?B?U0xNOEh3WnhCWWhiVDB3RHJXN1NuU21VL3BTT2NWdk9qZmROcFdZeWVQTTBz?=
 =?utf-8?B?LzNVcEppNjJKOEMzbmRKQWQ3OUZ3S2FaOC8rNUZpeEQ0TUs5VGpqWVQ5T3lX?=
 =?utf-8?B?RkpEU2d4RUV0Qk5XV0MrQVZDUWY2MTBMNngvNDVTRHg1dGtQek9RaTVsTzlv?=
 =?utf-8?B?K0ptWURTZlJvVEkzWGF3Q3NReEtVOXpaN2lsQmhpMldyWFhDckQvejBrL3F3?=
 =?utf-8?B?dnlIWFBNRmtBdlRmSUtJei9pRDV5aVZ2aTlQajE3K3gxRlNxMHNoTzlVTGJN?=
 =?utf-8?B?OUJHdjZUUWVNZWF5ekplbm12eURydjF0ZnlOdXA2TnFxSVAzNmtyeS8yREFr?=
 =?utf-8?B?YVZuNGFPZTh3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P195MB1212.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(4022899009)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUtqd3JaMk5pSG5uZElKUUR5UTZHakJyOHM5elpXNU5qbDZzOGJ3VzRmb2pM?=
 =?utf-8?B?T3hNdW9MdlNycDA1ODVTNU1OTUZtOHNEemM4RCtWRWRaSytLdXcvTE9HVlRj?=
 =?utf-8?B?TUlSTW44ZVhVTytJSGd3emZjNnRuWVc5U3Nwc1FLSXZRMlp3YkNUd3ZiQUZv?=
 =?utf-8?B?SFZudkZsaVVrelkzNXZFamJWdmdBcGJhVy9EMEovK0tBT0xzZU13RnRUMnJl?=
 =?utf-8?B?ZUU1QWEvT2lBQTZJc0J1S3VzQ1NxTnlVN2FhQ2J2eVhBZU9yMFhzNlBmaFFw?=
 =?utf-8?B?SEk1LytLOE9tRXcrZElsM28xK2s0UDNyc0pZa2JaQVRNT0gxOGZ2MXh6NE9G?=
 =?utf-8?B?WE9ZSGNlQjVsaHNVbHZpNWd5MVVHOXB3YmowVHFpVXBjeGlGWCsvVGNteGRV?=
 =?utf-8?B?NlBSZkhiekZoa0hxMWQwWFBGemlyVDM5SGQ3SnpCWnUrS2Z3N3hPWS96ME9F?=
 =?utf-8?B?OU5OOUQ3SWsza2orY0twTDdYbm83Vlg1bmtlUU5JQWk5N1pHOEp3dytlamFF?=
 =?utf-8?B?ZFVNZkx5anJYOWNiNVRnciswWWxkeHRUR2JJVHJGNC8zcTlVaG16UmNUMVF5?=
 =?utf-8?B?bjZHREIxeTZ3SmF5anZTSkYvY01Vc2JuSVJOQnY0MW1SSVM5KzlvNHNWMnZL?=
 =?utf-8?B?emQ1eENsdzAwekd6aDAyOGFrMjJhN0RHOWtHdUtnbFhQNTVBSEdpbHBzNVpt?=
 =?utf-8?B?QTFWVHZhVVBZa1RsSTdURk9wVlVUSEcxbVA2K0ZYdTR3M1ZRSG0wYUZpT0cx?=
 =?utf-8?B?cXNrWGZVWTdaS1RiQlhRUm5RZ2xnMTRIRURxZ3U3VEN5ejVrZTQvTWxnQ3lE?=
 =?utf-8?B?T2R0M1FuQ0pScnl5eldiQkVRUE15a09JZU5va0orTzl3RmV1R09ocUhiU0tT?=
 =?utf-8?B?VjVoSmx0UzZlWGVIQ1VaT01iQzAwM29aSjFQRmJIOVBjck9NMDRFYjJBYkZx?=
 =?utf-8?B?c1FLM3pML0hhR2ptMTRXUzFyejAxL08wMWtoN1FyRFFQa2JMMGVZc2d4QnNL?=
 =?utf-8?B?MTlGUG9zYkQ0b0ZYcmxEc2dlTlBXWFVTMFpjVnY0ZEROT2VaTExZeVRFbW9K?=
 =?utf-8?B?TWxtMXkwaVdyRjcyZU5rRVFLQXdwVG81c05maW5tMHNMRDlrdFZraDliVVl1?=
 =?utf-8?B?SWhNT3daRHVqd2UrYjR4dEhRQjBJWFFkREhNU0JXOE5UUVNTeFZ6cnFxcktN?=
 =?utf-8?B?RFdlUW1WcHArTEhneTZTVFVwWDBwbS8xeWhwS2dJeUhPbGdDSVQrL3N3bHF3?=
 =?utf-8?B?UmljcVhMSktCUTZWeE1XcXgyT25HSGRIK3FJVmg0ZU1ZdjBtN1cwRmdPZnBH?=
 =?utf-8?B?blpjVUxUY3lGbUMrYkVBNUVKSlRtUjZzVWI0eDIyZUlCNUZTY3UrSk5KUXVZ?=
 =?utf-8?B?VEUySDdkQjZPZU5CZ0tacG5pU3ZEcllnU3haY3NrQTZmMkFac0RqdXJTS2Nu?=
 =?utf-8?B?WG94MnFvNWVwNFNZcjZTaUlMVkJqNVg5ZnB2WXlhZGhYanBRbXZ6aWMxV3RV?=
 =?utf-8?B?Zk5saXJ4U2xRQkFoU3lpREdoa1RybWIza0pDUSt6WEcvS1NPN0syUHV5V2VO?=
 =?utf-8?B?SHh6NGhjMmFQS0RuZXUwbmgxWnJIbGhWM0IyaFdmNWd5cjlyRTJHbEFWd0RG?=
 =?utf-8?B?c0N5UVREd0tCdmVEa0gyWHJpcDRRM3dtNEdyUEFaNmJmcCs2Q0hML1hEQURG?=
 =?utf-8?B?Tis3YzFwc0lIZitWeFJkcU4yaVNyK0J6NGFPVjVGUnRCNUYwVHI2ME14ZDBB?=
 =?utf-8?B?L1dZZTZWS0lMdHYrZ0tkY2dLMUttN3pQbTMwU3IweFkvWnh3TU9ZV1l5Rjdo?=
 =?utf-8?B?VVl0TzdqWGNMRmRRSTNESjlwWnJDdmdaYTBvTldiU3R5dzM3UzlIVFlLUG1H?=
 =?utf-8?B?eHEreEtmcWVsZjdybFd2aThKbmVZUVRQU1pBZWxPcHArTnlyOTNHOGhGVkN3?=
 =?utf-8?B?UEpKRjM3b2dqRklWWHpveXlvbkR6dDhzYUhMd3lCc3N1R1FjRWRIcnowdXZS?=
 =?utf-8?B?d0ltYmt4dG4rd1o1MjdSN2MzMjBWU0Q5Rmk5Vm9LOU4xb24vTHA0RFljZlRZ?=
 =?utf-8?B?b2tRckNEVzUzNUJUNnI2YnUxR3VUKzFndVgyMzRTK1AyRVg4Q0JicEJlN0dN?=
 =?utf-8?Q?j3wNCkhcpCf5BMsTA9RDViU3+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71D87B3E8299474D82C7ADDDECC86E88@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB1212.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2bb20d-34c1-45b5-51f9-08ddc62127b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2025 17:33:05.8424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hCSRi9zQNI6Gvj7q1tXj/s+2b8EPe+3RishSDDADo0Thu4M1Vn1im33bk1ZQHDs9P51mGBLlhDbjigqjlHQIHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PPF7FE030CB9

T24gRGksIDIwMjUtMDctMDggYXQgMTA6MzUgKzAyMDAsIFByaW1veiBGaXNlciB3cm90ZToKPiBI
aSBhbGwsCj4gCj4gaXMgdGhlcmUgc29tZXRoaW5nIGhvbGRpbmcgdXAgdGhpcyBwYXRjaD8KCkkg
ZG9udCBzZWUgYW55IGJsb2NrZXIuCkBNYWludGFpbmVyczogSWYgdGhlcmUgaXMgYW55IG1pc3Np
bmcvYmxvY2tpbmcgcG9pbnQsIGNvdWxkIHlvdQpwbGVhc2XCoGNvbW1lbnQuCgpUaGFua3MsCkNo
cmlzdG9waAoKPiAKPiBCUiwKPiBQcmltb3oKPiAKPiBPbiAyLiAwNi4gMjUgMTQ6MjYsIEFuZHJl
dyBMdW5uIHdyb3RlOgo+ID4gPiA+IEkgYWdyZWUgaXQgaXMgbG9uZyBlbm91Z2gsIGJ1dCBpJ20g
YWxzbyBzdXJwcmlzZWQgaG93IHNsb3cgdGhlCj4gPiA+ID4ga2VybmVsCj4gPiA+ID4gd2FzLiBB
cmUgeW91IHVzaW5nIGEgZml4ZWQgSVAgYWRkcmVzcywgb3IgZGhjcD8KPiA+ID4gCj4gPiA+IEkg
dXNlIGEgZml4ZWQgSVAgYWRkcmVzcy4KPiA+ID4gCj4gPiA+IEJ1dCBpc24ndCB0aGUgYnJpbmd1
cCBvZiBldGhlcm5ldCtwaHkgaW50ZXJmYWNlIG9uZSBvZiB0aGUgbGFzdAo+ID4gPiB0aGluZ3MK
PiA+ID4gdGhhdCBoYXBwZW5zIGR1cmluZyB0aGUga2VybmVsIGJvb3QtdXA/Cj4gPiAKPiA+IE1v
dW50aW5nIHRoZSByb290ZnMgaXMgc29tZXdoYXQgdG93YXJkcyB0aGUgZW5kIG9mIHRoZSBjb3Jl
Cj4gPiBrZXJuZWwuIEJ1dCBpZiB5b3UgaGF2ZSBhbiBpbml0cmFtZnMsIHRoZXJlIGNhbiBiZSBt
b2R1bGVzIGxvYWRlZAo+ID4gYm90aAo+ID4gYmVmb3JlIGFuZCBhZnRlcndhcmRzLCBhbmQgb25j
ZSB0aGUgcm9vdGZzIGhhcyBiZWVuIG1vdW50ZWQsIHlldAo+ID4gbW9yZQo+ID4gbW9kdWxlcyBj
YW4gYmUgbG9hZGVkLgo+ID4gCj4gPiA+IEhvd2V2ZXIsIHdoYXQgdGltaW5nIHdvdWxkIHlvdSBl
eHBlY3Q/Cj4gPiAKPiA+IEkndmUgc2VlbiBpbnRlcmZhY2VzIGNvbmZpZ3VyZWQgdXAgZnJvbSBk
ZWVwIHdpdGhpbgo+ID4gcmVnaXN0ZXJfbmV0ZGV2KCkuIEkgZG9uJ3QgcmVtZW1iZXIgdGhlIGV4
YWN0IGNvbmZpZ3VyYXRpb24sIGJ1dCBpCj4gPiB0aG91Z2h0IGl0IHdhcyBORlMgcm9vdC4gSXQg
bWlnaHQgYmUgaW4gY29tYmluYXRpb24gd2l0aCBpbml0cmFtZnMuCj4gPiBJZgo+ID4geW91IGhh
dmUgdGhlIEV0aGVybmV0IGRyaXZlciBhcyBhIG1vZHVsZSBpbiB0aGUgaW5pdHJhbWZzLCBhbmQg
YXJlCj4gPiB1c2luZyB0aGUgInJvb3R3YWl0IiBvcHRpb24sIGl0IGNvdWxkIGJlIHRoYXQgeW91
IGFyZSBhbHJlYWR5IHBhc3QKPiA+IHRoZQo+ID4gcG9pbnQgaXQgd291bGQgZmlyc3QgbW91bnQg
dGhlIHJvb3RmcywgYW5kIHdpdGggZXZlcnkgbmV3IGRldmljZQo+ID4gcG9wcGluZyBpbnRvIGV4
aXN0ZW5jZSBpdCBpcyB0cnlpbmcgdG8gc2VlIGlmIHRoZSBqdXN0IGNyZWF0ZWQKPiA+IGRldmlj
ZQo+ID4gYWxsb3dzIGl0IHRvIGRvIHRoZSBtb3VudC4gQXQgdGhhdCBwb2ludCwgcmVnaXN0ZXJf
bmV0ZGV2KCkgaXMKPiA+IGdvaW5nCj4gPiB0byB0cmlnZ2VyIGFjdGlvbnMuCj4gPiAKPiA+IMKg
QW5kcmV3Cj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+ID4gdXBzdHJlYW0gbWFpbGluZyBsaXN0IC0tIHVwc3RyZWFtQGxpc3RzLnBoeXRlYy5kZQo+
ID4gVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byB1cHN0cmVhbS1sZWF2ZUBsaXN0cy5w
aHl0ZWMuZGUKPiAK

