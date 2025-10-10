Return-Path: <linux-kernel+bounces-848087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 947EABCC7DD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69B214EA281
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B949C2EDD4F;
	Fri, 10 Oct 2025 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mu8Q4nsM"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010052.outbound.protection.outlook.com [52.101.84.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0838D27145C;
	Fri, 10 Oct 2025 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091172; cv=fail; b=nEbvD8ET7gyUZ8Kqym2rwZXckNnDNh2vw1307Nt5dr0TZzi6BkoTCmEPzD3v7YLQZFfvZZukccwAgMXHOeTQmQzZ3+p+VWs68uZkcA671A6H7mSlamwfYEBWqoXeuWYSQfjtl0bx8KiTSvkBqXBi7Ry/ldvPQUue/MANoe05vGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091172; c=relaxed/simple;
	bh=q1e7jX8RjqCpA2tprEMtgZKSAtRVqblCpb0lbB4hOBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d6iNbqOINtXFn9ayzOiwuG99wH67+68lHHoJEOoo4EvQBtGfJtBnVuuGvO0ZRTOkdPNyEvvthOJ3xPh2De/7YFAgCvutiRBEuShDaUKp8XLtC8TSifxGMtSMLpmiXloh7rtkVVq8iglwMexdwrSyVjWO7958GCdXz7CjifKpnqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mu8Q4nsM; arc=fail smtp.client-ip=52.101.84.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRvJApHd82tr9qPzShC+YQ9pfm4wHwCRAMn5oCVWe1oty4W6JQU+/+nBijk4G7DXCnfe/jLiI6nhvzTeiKRwtIY3/tDpJFerxXsYcC0M1gdZ/nvX8qQAjQV/2Lwm4dgu4Nil9MYQ7YwH9BOaReopUgKoN/GFtQ9o3ot+OaUsxd1+EE6SNvN/v8aaC6G5aMLqlL6awtz4CFr2ht8DPTHiWRnbW/DjzXDvGn7zVNFGBwEQ2jwbJqRZkthuLe7vwC2SQGqQlxqCqNdIoCcT6pE/t/UI3i5oQqI008NFwPV7o6gkfBh+9URwrGK4s6d1DpEFfnW2G/SI9lHdXn/pj89FPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1e7jX8RjqCpA2tprEMtgZKSAtRVqblCpb0lbB4hOBA=;
 b=fnxA0qq/4m3JO4u3jsSDEzcDwt6z100wftPM23GePDSAN7HbD59RoA4nO7M7QkX/6NfoTGrpbNiwZYp6LcMjDh6n9zhAyu3XQJtros2Y081us03Djezah5oLsjwfZK4nUUeVHCUrsnp9cwZsALxBkjexwp16/ygF47m5mZ7/VcIWw+MaWmMyGYlV/+PrKXvlOfuvT1h6J8KfZl4DvYDYZbf91XriO6HjQKCUD+ujwPBCSi5lXWiVIXie8EdJfsweyZhpEJnYFbZouiH69C8ykEKwt53uxqQQQpvo6gLUhFKXiBA+POK7wmG+041Ib1I8AR0qMW3MGxiO13X3BMYzDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1e7jX8RjqCpA2tprEMtgZKSAtRVqblCpb0lbB4hOBA=;
 b=mu8Q4nsMGrbwiexDCcWEAXsGcAo1vm2f6wSaI5gPDinRcgh+pY05Kt3vgEEE301H2zNj5aGjoAxQWfq+DyBRuywUSA5cM+EjPRcsbdqPEdna6YEbmVmu3I2L5jSe+ngpX5zhGh+lGfq2ODkarIm+MM3rVUOPJ9AfL2VBhC3XdUMpvWKEImgJg/ThR+rY8QyxxXGpb9E1c5ZlBc7u1CMll/aQj5/m8zwWV7OtB7XN3U8bwzFhYijb/D/TkkT+9t9ofr2D3+QQzciUg6BN4hFqf+uIf6BeZCmjPCC+7c14PfdsBM9k4enmnh9IXLusxTFnAt6Q5BqRD4qjR7dWOP3u7A==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB10004.eurprd04.prod.outlook.com (2603:10a6:800:1d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 10:12:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 10:12:46 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Jun
 Li <jun.li@nxp.com>, Abel Vesa <abelvesa@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
CC: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: RE: [PATCH 4/4] clk: imx95-blk-ctl: Add one clock mux for HSIO block
Thread-Topic: [PATCH 4/4] clk: imx95-blk-ctl: Add one clock mux for HSIO block
Thread-Index: AQHcKTOAIjWQ2EXjpUO6eEQmFvC1aLS7SltQ
Date: Fri, 10 Oct 2025 10:12:46 +0000
Message-ID:
 <PAXPR04MB8459E467C2935B20624D548B88EFA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250919-usb-phy-alt-clk-support-v1-0-57c2a13eea1c@nxp.com>
 <20250919-usb-phy-alt-clk-support-v1-4-57c2a13eea1c@nxp.com>
In-Reply-To: <20250919-usb-phy-alt-clk-support-v1-4-57c2a13eea1c@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI1PR04MB10004:EE_
x-ms-office365-filtering-correlation-id: fe4cdf32-54f8-4190-21cf-08de07e58f39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q3VETEtKakQ2ZTA2VEM4NXhuNHRpcC82ZXpHbDE4V3p3SU9tVVlaMFpQQk5q?=
 =?utf-8?B?SnlVeGtZNUtUYjNtSGJ3bWsrQWR4ZmozaFZhbkZiZEZOSmJSblhyQkwyNVI4?=
 =?utf-8?B?MXNIbkdMSzJJV3QwOEpaZ0JuSWNORE1BRGE5ZEliazJ5SkZyNVVuVzJJdWt1?=
 =?utf-8?B?MnJmYXlCWkdPMndmdkhFdCtyamo3eXdmbmxXVXRQZ1phbkpZT0NQU3BCdFg3?=
 =?utf-8?B?TDQ4ckxHL0t2dGZpdTYzNTF5TUs1eDZxWGpiamZTNUFFTmRWRUFGSEMzL2xW?=
 =?utf-8?B?dytnS09vY3pMMnA3a2hCNHFGS0NGeVg1bjFvdnYxeW94aTI0WHVKYS9QelFo?=
 =?utf-8?B?ZGJIVWxjSlhMOXVyNDVEeGlQaHlyWm9IUkZ6aHZ3UDdjYkRUWE5iQllWdUZG?=
 =?utf-8?B?RVR5STVBL1BubmFSU0hFaVB1NElDdnhCVWNzanNabXZ3Y3BnbTU1cDUyTmhr?=
 =?utf-8?B?SkxlckNIbFJhUHQrdndtUVNuNE5rZ1RpY0lQQ2l0dXdSbmszaitNN28yczRU?=
 =?utf-8?B?UVJYdjVPaXNRNWRBaFlSbFptRWswMjZoTHJ0YkxKcUxSLytMeWdHR0tQSEhE?=
 =?utf-8?B?b2JJK3pCTkRRRzEwQlVhaTVudDJaVVVReWJLYytRNmw2blhWSXJLVlVFamU2?=
 =?utf-8?B?c3piRnRRKytTc2lCajB0czJKbjdKQ2svOTZlZDNwV1pPSUFMbExwQWc4QUNN?=
 =?utf-8?B?SVQ5cmpvVDZIS1JPVWZoMEFQMHYrbnBINXo2RWlSb3RxS0tuZDIvaU51Nnpn?=
 =?utf-8?B?cXJpKy8yU0Y4R2NzalpUT2JGWWNQQVd0Znl0Y2hVbU95TWdSK0VLRzE5dFVD?=
 =?utf-8?B?MS9sSUpSZStCWkU5cTlmcHpQREYzd2ppZzBpQzI3MmVLT3kzQlkwQStIL01H?=
 =?utf-8?B?bVg0c3FrLzlVRi93OEkxOG5tQUVVUWhoLzRqL09DUHI2dGEvSzc4OXpEaFBB?=
 =?utf-8?B?Z3RMQnB0OXNsejk2RmZZUkhUWU14VFE1T1dyR1JOOGNJenUxc0ZaZUdnZVd6?=
 =?utf-8?B?encvZzMvNFlPTE5Ec0xHUDdYaGM5cFp3N3FXVCt6M0NXWGNIZG5Ma1lSTVBi?=
 =?utf-8?B?NkQrM0ZBSEc0VVhNNHJFSUNlaUpZN3ZpbktCOFRWb0RIa0VSVFlueDFrWlVQ?=
 =?utf-8?B?MUw2RnFKQytJOHhOQnVzTWJpelJ0NmNRUXpXQUI3clI4RUZGU2NuemVQVWhx?=
 =?utf-8?B?bHdkTEVvMzBMRk1XYmtVYUhpOW02QUdHckVWVHpDaCtXam5vdWtpN1doaytr?=
 =?utf-8?B?WldrMWozZW5TdGk5VWxaV0NyeWdKYmdITWZISkFyU2VJVkJxM0Q1WXpSdW1H?=
 =?utf-8?B?c3dpM0JnRE16aFFXZGUzczRMNzllcTdNcmtWdElRcFZjT1VYdzJZVzFlTnRL?=
 =?utf-8?B?MmROMHUyZjZkbDE1dzd1T3dTYm1za0tTVWVqT3FyT2RKY3UwKy94aG56YjVP?=
 =?utf-8?B?WTROZU8rSkdCTHRJUm9tdWY5UTlyb1lqSDI5cjd4OXFZOHZwY0lYQU1jNGFw?=
 =?utf-8?B?VXVlS3ZEQkU3UmNpM0dueEN4NG4zMVpGY3JzTDF2eVhyeE9nZEp3T1E5ZnVV?=
 =?utf-8?B?WS9oSGllU0VKNkVqNGVSTWhpVDFUcTd4TktoR2hmMUdXQ2pOaWlwSE1QbHBl?=
 =?utf-8?B?RFh3Ym1uV1VYZFZlSjFaLzJqc0lQTnpxYkZiRGd5YVZGRjdUcmNMTjY1VE1H?=
 =?utf-8?B?dXpqUHVIcjRmVmkrRlc0aUhMSC9VcFBDRWtpcUEzdkVjSXNWM1Z0cW55eVFD?=
 =?utf-8?B?Q2tOS0xhVGtJOFVEN0xFS3krUGV6OFQwUVp2bjd4ZEFCYTUxcEc1QTcvTUU4?=
 =?utf-8?B?MVdDQ1Z3SGlnUG9pNUNiYWtyL01EdTAydGRPRzV4OUlMM01zV0liRFcvVzlL?=
 =?utf-8?B?M1ZTTXdkSHgvSmI1bXM4MGVacHRjQmNOSHZENDlYK3JLQkg0ZGI5M2s1THh3?=
 =?utf-8?B?WmJPZVBwaXp1RTloalVKaWkzVDM5d0I1YVNiRUZDaUJEbW5SSm1wdlBZSlpB?=
 =?utf-8?B?OHRXRFRBKzJ1ZHRTclVsN3ppSEJneFc4cGR6QURJQnJnZFlkTGV3NUoxVFc2?=
 =?utf-8?B?dDl6WTQwZlFxLzZPeUVsN05vanFQUlJORVprQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cjMvYzc5ejd4YW42bytCVkMwc0xnUWQzaDFzWXREc09Ba2h5QW1SOXJPb3Fw?=
 =?utf-8?B?T3UzVis2RHNXcmh6K0RpTGFyUkJIVGoybzJlTVdXSnJVQlNtellhTjJ2bFJ0?=
 =?utf-8?B?eEFqZU5BQ1BaTzlUZkFSUFA3OXpuNUUxS25Dd0hUZFoxbHFpM1BnQ3NwTXFO?=
 =?utf-8?B?U0tNcEFWYkJyMitJRlRwUEtTT2V5L0NJUWVOK1hKdDRpNTVLdW0zYUduM0pH?=
 =?utf-8?B?TGhQc0U5Q0tMWU9yL2hwM2ZYS1pIbnRiYW40enZ5bHkvVDVpWEQwRS8xWm54?=
 =?utf-8?B?YmZmZ29pei80Vlc2VWozSDRhTWloWWZlRWh3bHRid2EzZlM5Q1VPL0hWc25x?=
 =?utf-8?B?dDQ4YXVoOWlyZzRIbEc2ZDlpQVVCQ2VZK0YwcDhzTTNZc2xZcjY2eGxJVCtD?=
 =?utf-8?B?MExEbTF3RTV0Q0F1elZVSUFraTBKNldVK2g5TVhMRytJZXBPSkNNRGFBbFI4?=
 =?utf-8?B?dUF5bHY1WXV6L1drNXpxUEUxanI3N05NM0dxWXF3WW9zeHl1T1I5a3g4OFlZ?=
 =?utf-8?B?d3IrMitqeHBOTlVzRnFGRVNxV3czRlVJVlFRK1ZZc014ZUJyM3VtUWF0OVlU?=
 =?utf-8?B?MDdXT3gxOXptQzROdWRZWS9VTnltKzljbEZlRHZrMnIyZFBMVGtnQnpsUkp3?=
 =?utf-8?B?Mnc4enYwWVA3T1R0K2lYUXpLK0lhRDVMRnBrU1RIVnBHWlJDZ3dRdG9jT1Aw?=
 =?utf-8?B?bUlWdFFGUkVSYjVlQWJpcVloWDBocjZCTHRwdWF4cUZZcUFrSnpyamFtakVv?=
 =?utf-8?B?R1RNeGNyNkRMWGRIdUVyaUgxVVRMNGNxZXFIUzRhMktaY3hwMDNPd0tlSjhx?=
 =?utf-8?B?cmJQKzI4Q2U2UWR0dUFYUWwyNmF2enc5dzV3bVFibExpSy83a2RzRDF1TTl4?=
 =?utf-8?B?cWpOQ1dlYm9iVWt6UVZXa2xmZm53eWtCdERpR1YyZ3ZTc2QyeHhHWWNMcW5t?=
 =?utf-8?B?eC9ORWZvdlhkWlhlY1lxY0JML3VvL2Y3bDVINy9CajZjVHpFQlozV0xRY3hR?=
 =?utf-8?B?bTRjQUcyR1VyWTgwdTdxS1lYWmJ1djVmbGxXSkRjMDFlT2d1UTJlVnFDUk8w?=
 =?utf-8?B?S2paWnI5K0J2UzBTOWUwby90QjI0UzNUaGMvSmxGaklIZEd5L1A5YnRGZFZV?=
 =?utf-8?B?aGxmNy9haE1RbGxaVWZVNHQ5Q2pJTlVDY0Vsd2pnc2ZpbFdOcTI4eVRrUmYx?=
 =?utf-8?B?VjA2dzF4eTVyY0QyT0kyYktPckV0aDBCREhyRUw1ck5La0ZlSTloRm5SR2Yr?=
 =?utf-8?B?L0c1b3VPVjVHNFNwQ00yd21FSndhSEZWS0VaVElDZ05lbk15NklLTXloK2F3?=
 =?utf-8?B?V1AwWFR3TGpMQjI0VVpwaWUrRjlIZUV3VkNoQXQ2Rk1nejRlelAyRUZFemQx?=
 =?utf-8?B?eDNvMWdLT29DZ2t0NEJGaXloU05WSUE5NjRhaXQrQmpzeXlVWWdEOHhrMFNl?=
 =?utf-8?B?SUUxUENETFRGdnB2aDNSWTRiYjl3azFqc0lldWp2VjF4QlYxZCtJK1VPWGdt?=
 =?utf-8?B?TExaZ2JQcExCbzE4dFQwMk5OOWNHUDh0VzkwdjVHR3dPTEd3ZUxaWUFEVU9G?=
 =?utf-8?B?MGFOR3k0eE9vU3NPeG5xa3NodnZDRWpIQkNEY05NSmFBb1laQkZLMUt0RjRr?=
 =?utf-8?B?amZSTDcxT0ZJckpiZW5ycDBWQ2d5cG1NaEk0OCtNN09YY0VSazhWajRQcHp5?=
 =?utf-8?B?a0NDeWtTREcxZ0tmMFZseU5vWHArWitOQUh6MmYySWd1M1ZxWGh4dDZVejFj?=
 =?utf-8?B?cHBMUTZPZy91eTdqKzFERk93MnkvVFlnbjBLUVVSTm1sVGVCcTBEejJUZnh4?=
 =?utf-8?B?ckE1d3ZoZ3VsUy9pWmk1SGxxK0RCbGdwbnVIc004WFEvc2E1N3I4VHRpRGhv?=
 =?utf-8?B?ak9VaE41Zm9scnk1aFlXY1FoRk05bE1GVXdXYklCdzd3eFZrYmc1dmI4ZHlE?=
 =?utf-8?B?TmF2b0xCbXhtNVZabi9KMlBlMjlReDlySnJRSEFzbUVYT21Ha2xoUjJGakNw?=
 =?utf-8?B?Ni9ZZ0VMeVExYUE1bTJhRHNudm0rYks2NDFvMXREUWFvUTFZV3k3VmphRHVL?=
 =?utf-8?B?c05GNitEaVluM0p4MVJERHBxN3Z3Qm04Y2pjMmVTOEVwRitNUThGNVBsaXZm?=
 =?utf-8?Q?ExvA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4cdf32-54f8-4190-21cf-08de07e58f39
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 10:12:46.4530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Uba77HUqk/TORk2Q+pSp1oOxNAGuauBLBMKdkRKLKLQEv3cXw7AeWrfbHxEbBMJoPNX2uQNMX60o9TKXJoTJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10004

PiBTdWJqZWN0OiBbUEFUQ0ggNC80XSBjbGs6IGlteDk1LWJsay1jdGw6IEFkZCBvbmUgY2xvY2sg
bXV4IGZvciBIU0lPDQo+IGJsb2NrDQo+IA0KPiBUaGUgR1BSX1JFRzAgcmVnaXN0ZXIgaGFzIGFu
IFVTQl9QSFlfUkVGX0NMS19TRUwgKGJpdCA2KSB0byBzZWxlY3QNCj4gVVNCIDMuMCBQSFkgcmVm
ZXJlbmNlIGNsb2NrLg0KPiANCj4gVVNCX1BIWV9SRUZfQ0xLX1NFTDoNCj4gYml0WzZdICAgLSAw
YiAyNCBNSHogZXh0ZXJuYWwgb3NjaWxsYXRvcg0KPiAgICAgICAgICAtIDFiIDEwMCBNSHogaGln
aCBwZXJmb3JtYW5jZSBQTEwNCj4gDQo+IEFkZCBhIGNsb2NrIG11bHRpcGxleGVyIHRvIHN1cHBv
cnQgVVNCMy4wIFBIWSBjbG9jayBzZWxlY3Rpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBYdSBZ
YW5nIDx4dS55YW5nXzJAbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFBlbmcgRmFuIDxwZW5nLmZh
bkBueHAuY29tPg0K

