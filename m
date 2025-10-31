Return-Path: <linux-kernel+bounces-879734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 591E4C23D95
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9E5189CCE7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E312EBBA8;
	Fri, 31 Oct 2025 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="pcqWe0tz"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013051.outbound.protection.outlook.com [40.107.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936DF2236E9;
	Fri, 31 Oct 2025 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899851; cv=fail; b=bp763nkuBM3l71CDRdY4hpYVvBxdutZFTdB1kELTJru2jeCTd/cDE3p4gXXgevOXPpMMD5BLdo/yNjJZopUpjxHvrxpAPt566W0lL1rs2tZOHkMw4xWC3Q6NnveWJD/2tuhzYhPd7ZJuZBiAoRSaY9tuJwqyEw6b6je3jM6QyEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899851; c=relaxed/simple;
	bh=hWD1JsP5XucTxFgcJjbI7BNniG7IeimyRFCd/Z22Tw4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bz2asZwX0JBP0u+Av6cC1y/ovaE/expLABEUnkQX9NPQT7f1nyUt4W8qgG/YBTPbU8wtQ6cb6lrKDY2k99/5a5bPukQCerJdOyPtg3N1fhbkgxlMACmsB3C74zs2KKTJ5mRQbdzUuGenEpkdVx9OXT8R9bOa0/s3UWk06Tg+Cmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=pcqWe0tz; arc=fail smtp.client-ip=40.107.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSgQ420uV1uKmFumx4AvIIQxxt/JsMALMDLa5q3JH+jnKfxBEx9ZsllNr0Crb282aTAkV3KTBtORj5G6QPwU5W3PsZJhDkslwE0+g2uKFySDaZn9904E0xhEHAl0VJVkirKcxSQ0NaQRfSo1yt+DrVXM2R8vJycxGWjNhDC0o9HFgVlsmudXr+DLg56h2e1KRIPIYLYKWmuu4ZiQj8JW4vDkQ75bkUteVippmxpyqDD6qa+vA5FSnro4iyB8IngOa6MM/bxqUzyHJCqLfA/3w030IyeNKAPBHJvFT/0kBQ2rSiRCpXHS59may0hk/zt28uKiAc06QkYsin0VWfXynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkSefxlcyOAdHTK+vbhteoGNb3Ol09gdxpWFgpcukK0=;
 b=YjkHc1lYVzltuwKzCTPeJUdjELVypzFEVTkv88sdab56YHAQtHx7zNsLQ8FY6eUoN/3LVq7Cp3ND3g+4KkHNOy/3flzrSW0avucoFwumAEUtZtuVrPQT+nbJabJ0WRYThXY4HIvDjlDRb975yXLnk5vKpqaQfdp2o4kDXcuszIhGnmxezEXI8nuXN+qLb0JRj92HfjGJwDIkJD3y77oZzfZTPU/SCTVYOoBQFlkTCblqTgyEGGdGlCTrPNbUGRK66957xr9TvzZ2BjOJAZtgbXtjvMlg7B0xQFZq55D6EdrMhTGfpxUdFFdiBUsUixFvYZLUQ5C2kTMfChng8PUMnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkSefxlcyOAdHTK+vbhteoGNb3Ol09gdxpWFgpcukK0=;
 b=pcqWe0tzlhsufYpZVxLmu11cYF4irz99ORj+VWGH/6zJcBEnNRCY95YiP9s5GxrX8dC/Lvqyhi+6ifMmUSfILZ8C4R7EEI8H9zsD6WL4wz+k+/8tQ8CitnGZ5mlWoCV7vwim1K8xmRh4p+EFnsTLUFODfk74DFIcuJfEkKoLjbrPRswvFiH6RlPg4Ux8qfp9/sJzwIp+CIoFGlOjnpwWEA452Z14elZCSBfhwovaJZszGCnZAlMTc6IOmrumaP7gJOkg8RlSM8QGk6fwVsx84l+BguppWzodVk4d/Is544Z/yWgCGJ158LgWfWq/mVIfnt/AcX/q4wTWf3q8bn+M+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH0PR03MB6235.namprd03.prod.outlook.com (2603:10b6:510:ed::16)
 by IA3PR03MB8455.namprd03.prod.outlook.com (2603:10b6:208:53c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 08:37:26 +0000
Received: from PH0PR03MB6235.namprd03.prod.outlook.com
 ([fe80::24d3:54df:52d0:1030]) by PH0PR03MB6235.namprd03.prod.outlook.com
 ([fe80::24d3:54df:52d0:1030%6]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 08:37:26 +0000
Message-ID: <7d8e6c35-624e-4e39-b92e-9786db6514d6@altera.com>
Date: Fri, 31 Oct 2025 16:37:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/3] i3c: dw: Add Altera SoCFPGA runtime PM disable
 quirk
To: Krzysztof Kozlowski <krzk@kernel.org>, alexandre.belloni@bootlin.com,
 Frank.Li@nxp.com, wsa+renesas@sang-engineering.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dinguyen@kernel.org,
 linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1761893824.git.adrianhoyin.ng@altera.com>
 <3218e1dc-b8ba-449c-bed0-1615d8aab0b7@kernel.org>
Content-Language: en-US
From: "Ng, Adrian Ho Yin" <adrianhoyin.ng@altera.com>
In-Reply-To: <3218e1dc-b8ba-449c-bed0-1615d8aab0b7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To PH0PR03MB6235.namprd03.prod.outlook.com
 (2603:10b6:510:ed::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR03MB6235:EE_|IA3PR03MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e259341-f3ff-48ad-d25c-08de1858b4ce
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGw1eHZRRnpOaFQvT24xK3h3YndlQ3g4NzBYWWhZbEJOTTBzS0N4dDNVbVBQ?=
 =?utf-8?B?Ty9NTW90alA0SjJHS1ExejBZS0RNek43MTBWeFNtMzFIL3RJR0ljYWtvOUdz?=
 =?utf-8?B?QVMrZ21BZHFlR2tROGVRa3FKVE5KM0V4akx3TGxoRDc2OTlYSVRlcG9VTk9i?=
 =?utf-8?B?aFNtTzZFUXBoUCtJemFIZ2NTek1TZHJxWEw4RnpMSit4ZDZJUkI3SmRnVW8x?=
 =?utf-8?B?Si81YjNpVndtVUlyYis3dlN0a0NkdEFVaVh1OUhGOUhNVkMvVU5GUWR6NkJJ?=
 =?utf-8?B?ODk1YUxLeHNvSWxzd3J5UU5GQ2FLSXZSQ0xQanJGcDg5NWVMSk95bm44b3dt?=
 =?utf-8?B?UWI5VVNBUGFjWUdLQjl6WHBIYW4zM1Zrajg4RHR0bFRnN0Zna2tIdUlBN0kr?=
 =?utf-8?B?N04rakJ2bjI1OGFDVmkrMldFZWtmQ3R4OWVUNklscGdJVHdFTi91bENqK25s?=
 =?utf-8?B?eUF4Vm5LZHQyKy9hRkNCcTJvQ2VrT1ZYbUNOTzBLeWhzYkpFZWFpbStRZjF0?=
 =?utf-8?B?ay9TT0U4clBoeHdYWjhHdUVSUnlkR1EyUVlCa05WTlk5dFpnSFBUVWlnVVVp?=
 =?utf-8?B?eVdIR2dOQjlPREFIMFZGem16NFVqVTVKWWRyMU1Tb0RYc0UveHloaXllLzZG?=
 =?utf-8?B?T2lFQmd3dEFZWG5LMDJ6MTdjYmJGK0hBcE96cHB0eHFVdk9veXg4ZmowT3c1?=
 =?utf-8?B?NW9sU0xWbXZVSFpDS21zdlF3azBEQk1ZWXJhWWduamIwYkVNNTZpeFhDWHVL?=
 =?utf-8?B?dzYzVUxjczNDYktweFZjT0dXUXdIUFpjSy9Zbjd6blFnaTB1SzkrdVRmVU5C?=
 =?utf-8?B?SXdTdjBwY3JYRHQ0OVNhejVEUHpUU1VDbEdsbDQ5Nm14TmROSHpXWkF1Yy9h?=
 =?utf-8?B?UUVBcXhtSGNWeHdNekpwa25WRWx2UnNScm5QT3RhYXlZWWltOTdrcjlwdHBy?=
 =?utf-8?B?cDJwQzFmbng3d3JXOUhoRGNDa045SXllc1RCajZ2YmpZUEhRMFNLbXJSS0RZ?=
 =?utf-8?B?MjkzbC80b1ROUThVWTZFTzh5S1NlbFhUM0xxenZxTmsyUTN5ZUY3SEFCNVd6?=
 =?utf-8?B?cHd0dWpmYk1acEYxb0FLNWdybGNuWDl2cE42NVBvUGNOd1VyOFkySllaMHow?=
 =?utf-8?B?T1haSWVCRVNVRExmd3NRODE2R0lyVG9FM3dhRzJVOTRDbStyc2JNQXV5UnY3?=
 =?utf-8?B?bjN4aW42Mmx3NERBd25RRVg4OUNOcDVvSjRza0JyWXZZVXE5bWlPUytUcUR4?=
 =?utf-8?B?VVZBQ3Fzb1FOTVdGbmRsMkE3SmRBckQ0TjQ4bDNrbGhBN2MxeU4xUElQOHhl?=
 =?utf-8?B?NENLaUxBb0RKcVF1a2cyR1B0K1ZoTTFoSmlOY0NpU3RZSEp4bHREMmtacFIr?=
 =?utf-8?B?QmdnbWZPTlMxSk8yMDdMZUpSSEFTREVjU2djaW1GdTVEWjlvMHJzNGl4MDU0?=
 =?utf-8?B?QVhuYUlqNGNQeHlyZlRUNTVNbkg1SVljOTZ2cUdUbzZPd1hKcFdSMWloektD?=
 =?utf-8?B?Sm1OWnh0TzZ2TENPMEZiOFdMcDlHVWFoeTZiaFFzME9yUVczSW4vc2NsdGZO?=
 =?utf-8?B?a2ZNZDJXNklqS1JJTVZsa0JjK1lHeWxIWnRFYm1oeXVKRmF1MUxLczZEeGh6?=
 =?utf-8?B?K1E0NTF2L2ZKMDJwTk9QeFlXY0ZhMmc4NEFMRUxkNnJ6RHYvT3ZpM094UDBP?=
 =?utf-8?B?SkZqYXFrcldEMWJnNXZ0QjlMYUUwQ3V2ZlZzSndVaEFVVXg3T3JJODZRazll?=
 =?utf-8?B?bU9XN3ZvdURCQ0c4KzRQVVN1U1VraTNaSDlXRm8wcUozTnpyOGhjMzdHaTJw?=
 =?utf-8?B?ZFc1RDF3enhsaU1vT2xnYjN3dUVnTjVJK29XS01yeFpGQ1pWZXdmWFRvZHB5?=
 =?utf-8?B?aHdsRjgwMkI0Q1cxMSt4dmNhRkwxVWhqdzZBczdYV0VrQjhKbTYwZVJkMktI?=
 =?utf-8?B?a0paMitGSjN5REpEZjdnV1Qwak9xZGh3akxRQjd1S3hubEJnTHNmOENuL2dH?=
 =?utf-8?Q?YIHs+vMTvhPJ0a59lYVcWpqQOLtUSI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6235.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nm5Kam5sbldCU3BOQTFDb1F3WW5mS1BWQ1JmRW9TK3BGQmJCRFo3M2dzaXZq?=
 =?utf-8?B?eXlXOHExcVJjaXhCWlFNUWYxN1pWd3UyVk9FZENHYysvSlQwOGhncU0xMG1v?=
 =?utf-8?B?bXJKbXZ5Vy91ZzBjREhVcldjZElwNmxPbmZ1cnZrSjBpV3FwWHdOOFpLNDlZ?=
 =?utf-8?B?dnprb1h3R2QxbHhaTkY1Rk5SQjRQRUVEcVZ2cUtxTG9XRUFoaDU2V0tpSnJ2?=
 =?utf-8?B?MGxiY1JYUWx2a0NoVi9ZQnY1anR3WTdpNFFXaTNwNDlCcDd2a2VOSGlPRXI5?=
 =?utf-8?B?ZDJLYm9NSHFkRlBscGRHVk8vYU5rWjlhdlVPRDc2SVRjaXZUcStOUi9FUDg0?=
 =?utf-8?B?V3BVM2syclJiTWk1dGFwTlJTWnBjK29SdGtXZ0xiM0tMVGtOUko4RUQxSTFZ?=
 =?utf-8?B?SUdwMEdUUStpeVlNTDl6ZnZkRXZLeXVWMW5IMU5ycUwySzRvZGpRdWZXa2c5?=
 =?utf-8?B?Y2F5b1BpUXh2L2hxNzlXdWlKK1dtaENaMHJaNm5KQmtDRkNEd2sxYWVlcFh6?=
 =?utf-8?B?cjBCS3Q2YWhtbWcrcWpPMDdCbURsMzhNRWNKM2FFWFRYcGhmVkZIMnluUzgw?=
 =?utf-8?B?SCtGL2dNMjJ1b3ZPcGVPYnpDNVdyajVUQ1ROMXREK0xBSVRhcyswU2FSYnFC?=
 =?utf-8?B?SjRwejdqOHJvYUtmNW1ZTU1tNGdhTWJwOFpNTktOcXZjYWdyU3Bid3o3T2pJ?=
 =?utf-8?B?TWY0L1YvOWRRMkkxM2tHM1BXdUo3UjhLK2pYWVRtKzQ5cTZ4Mm1XMmZCRTF0?=
 =?utf-8?B?ZUxVcHBWWkR4a2VnM1JTK0hIYmpZdnVLWUk4em9rdFZxdk83SVlrNzdGNlV4?=
 =?utf-8?B?QmxXMFVzNWRFWFZwd0xPTXhyRStxVHR1SDU3Z3VPekFXaEZTbmdWdDFUaHF2?=
 =?utf-8?B?ZE1IRFpvV3UrZDBoTHJROGF4ZUVDSVZ4YXdHUFJPRkJWZ0Z1Z0RNZmNhVWl2?=
 =?utf-8?B?UUtzQXRnNWd3OGtlZTk1N1dnbjVaUDU3aXdJdGNSQnhMN3lHSkxsZjRIQjZR?=
 =?utf-8?B?QVozRGpEV1Yzc0NPRFdOK1RzQ2htR3RFU2pLN05YVldpY1ZpVDVsNk13MmRE?=
 =?utf-8?B?ZDdsWmpENXZqUGJtdjNLRCtuTThnR3ZQMG5lS2JKaDhEaUJxVXhyWnF4MW1Y?=
 =?utf-8?B?NVFpNFdUd2tpSXVDeG5RZFk2RTd4NS9MR2dXc05Yb0dsRHprYmFEelUyUHBw?=
 =?utf-8?B?NmF5SDRHWjJMS1JMZ1NGb0g1VGlwenJJWXFzTHlURzVFcCt2Y1RmSEx6K3Jm?=
 =?utf-8?B?eUpHZXpNTzJEVndMZWw5MTJnWmpyblVuSzNod2loN0VLSWd2SEh0c0MxMld2?=
 =?utf-8?B?b0JHLzJ2T2RZb3U4dnF4cnZVNG1lc0FqR0pVeHFlNTJrd2JkbFVWdE9EM2xk?=
 =?utf-8?B?TjNSVFdLR2JXc3R3YlZwRmY0cmYwaExYUWNnVzBQZzhONHdVbHJia0xUaUFa?=
 =?utf-8?B?LzhZSkJGQU1KOHZUWW1Id1ZhdTJHdmF5ekRSRGlRNWFHTDZ4VnJHTkN2TEdC?=
 =?utf-8?B?b2RudXBuMzcrdTlEOVFDOEpINjFzeWk2WjlmQTNTMkFGZVFOdDdVUkRmbzNH?=
 =?utf-8?B?QzVrcGZ1SEtPRGk0RjVzUTZFNHFORURKYzdCTFNTOSt5bzE2UEYyM1E3R1Va?=
 =?utf-8?B?RXhyb0E0V0FpeE9wT2swZUs3OWoreFZRbzYyc0kzdWR5bW5DUWkvN2FvVkwx?=
 =?utf-8?B?dDFLSnRUeFZ5ck9WNXdiZ3JxdnAwcTJ2em52UHJ5emw1aFJybkRCU2pVVzBw?=
 =?utf-8?B?TStEbk9jdG9rcTduQUJHc3ZCbjgrRWNhamsyWHdDYWRjanlJSXRxcHZoK0cw?=
 =?utf-8?B?TllkbncwTHhkSVJ2T0JmQUFRNThVRi8zU2tkVG9IS0tid0JRK05FN2pmY1B6?=
 =?utf-8?B?OWFuVk03YXQ4QXFJTFk0ZE9Fd1c0dG8yU2l1VWgzd2xTMVVWR0M0UUd3d3FL?=
 =?utf-8?B?UHU2Z2VXT05GTzBFaEJtdDRmWjZURVpYZjhwaW5ydThsMVVPaFkwcUlENHgy?=
 =?utf-8?B?SWVRMHBkL3oydzlXUUJtckpZTTVLeDdxRkprWmw5MzRJWEdpN2M5WUdHOHg2?=
 =?utf-8?B?U0ZNd2F5Tkgwb291bnhqSnQ5cUZXd1pKQ3pCVHkwbnZ4VlIxQmV6MDU2S1pL?=
 =?utf-8?B?aGowQnBoR0I1YW1nWHFzVzlnTFBNS1hGeExDNkJqcGRUNWJGdXJISHdta2FF?=
 =?utf-8?B?dlE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e259341-f3ff-48ad-d25c-08de1858b4ce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6235.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 08:37:26.1263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DMWV8CJx+iN2gH/IWrjQzvNO91xMUGVnN0HtKnr5HPv9GBuy49wwUWVWriYeeYfDq75pZ7pQmO0tXatktw3o8LJZOYM2sihNECAtT6m/Hc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB8455

On 10/31/2025 4:32 PM, Krzysztof Kozlowski wrote:
> On 31/10/2025 09:27, adrianhoyin.ng@altera.com wrote:
>> From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
>>
>> This patchset adds support for an Altera SoCFPGA-specific quirk
>> in the Synopsys DesignWare I3C master driver.
>>
>> While running the I3C compliance test suite on the Altera Agilex5 SoCFPGA,
>> the I3C bus was observed to hang when a slave device issued an IBI after
>> the Dynamic Address Assignment (DAA) process completed.
>>
>> This issue occurs because the controller enters a suspended state after
>> DAA due to runtime PM being enabled. When suspended, the controller stops
>> driving the SCL line. As a result, an IBI transfer cannot complete, leaving
>> the SDA line stuck low and the bus in a hung state.
>>
>> To address this issue, a new compatible string,
>> "altr,socfpga-dw-i3c-master", is introduced to identify the
>> SoCFPGA variant. When this compatible string is matched, a new
>> quirk (DW_I3C_DISABLE_RUNTIME_PM_QUIRK) disables all runtime PM
>> operations in the driver, ensuring the controller remains active
>> to handle IBI transactions reliably.
>>
>> ---
>> changelog:
>> v1->v2:
>> *Add new compatible string in dw i3c dt binding.
>> *Added new compatible string for altr socfpga platform.
>> *Remove Kconfig that disables runtime PM added in v1.
>> *Update implementation to disable runtime PM via compatible string
>> match
> 
> 
> Why is this still RFC? Please always provide reason in changelog and be
> aware that some maintainers - including me - skip or just look briefly
> through RFC patches since they are simply not ready.
> 
> Also remember that versioning *continuous* when dropping non-RFC.
> 
Noted. Will resend and drop the RFC tag and update reason in the 
changelog.>
> Best regards,
> Krzysztof


Thank You,
Adrian

