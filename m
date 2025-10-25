Return-Path: <linux-kernel+bounces-869710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A41DBC088E2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 04:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B27694EE814
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 02:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064F923AB90;
	Sat, 25 Oct 2025 02:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="cqtirC/d"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0F321CA02
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761358834; cv=fail; b=NKDFNA6pK2X6VMPlpw9Kj5JIz9Vg6VIY4wK50IHamIoD3ib+bQEKOo2SJkmXKGdg6TrpzX1//6pd2sX3MWuSgwBLnEzXzkTYXAEdQpSGG2Bhaja+gxp1uIQ2klewCHevS9svU2nL5BxJ2sMyru89DbgP/3kCf8GS8rN+WlMFc9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761358834; c=relaxed/simple;
	bh=HuFnjyFQsoCYvO51W1XiFdG62iY8CAbAHXQTgna4xcw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pJDcdkg/guuGYubXOKNXwGpNgO6HsoPjgZr7E96EZ55Mu/FKztJoyiAvlUDSuQGYVj0R0G0GxtL2DhykhwYtWIeb6BTpRS2IZmw1aW644n7qiANML5lg98zjDoh3UtftCYGUV3MQzIo6KKxAwkE9Ry/mG/V4EagTKfI3pC12UCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=cqtirC/d; arc=fail smtp.client-ip=52.101.61.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T41dPTmKkzs6khIGoHx/1ji6AFx0yLOeF8BLOX6NbMhxYEqtn9S4zWzZjRyDkpuNGx/pw6lHMK+r9yCJ26Q50JYMa7n3kRLbhz7KgN5Se1AbxdcdBpVT3yu3yf1UjxaEo2CqdxwA2OmByTEOLCOACCXcuyeji21K0UFxF7/f/Nuqy8QoISOzANY+oQyHE0g/a13Z7J4rz1WYZBzpsRS4LsOzpa6KEXHwS+5iCgaCP/k6CPd/ubYsPA2ILCGCcvHzFm3hti6FDSXfEoJa3g32KMhI+zALxXr25L6u+/l62IWb3Y4UteWYwDSmcQ8ER2m0BlGXdfQ8WETZfacp7j/qEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lViSC96tAbMkXUrDtHD1+RD0yxeFjzPX9tiGXz64C7o=;
 b=HGOhfAOQgJABU763M6bF4mcmhAkHhyF1xwOChMy8mYcOma52QGQVrU3lvi/7MjtBRSHFymIXVee5eM+ROWy2wkCwtHa2fc2ou+Fvj8iOSLhyOpulNJTrE7w4yA101esTfOWFvxYcYq/ENnaVamSU3O+9qYRplDZVgBEt7xhWb2y01yHhOc83uVxB+VPsuePV15xzXQIx68swkl9RhWtbvTc4onNIHc3rsudPdH60+Bgv1PZdDaaD71Ks5qFkg6T9vhMjmpW0F4FffQT+/BYCSGYMYWrA6t7ngQyHnxPk8CCDVCxwFZvZ/pATKBqYX/9NY+yCerBLToOPe8i0eImAuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lViSC96tAbMkXUrDtHD1+RD0yxeFjzPX9tiGXz64C7o=;
 b=cqtirC/dbBd0xq9MrZp4U+JkF4hiQ5WgFVnD+PsJimiUhfI7UVvqhr+hrBFT/Wd1FmN961k+nNckYDyL/u4sku8g4jMTHPf3YbiH5XNDB/MnqW+/635wbwDn1tWQuyePIPAIRO55abU5JDj16yxmt2bGSBL06h02cygw6F0hFK45Bak/TUQSYWusGD9gw0zSJiTTMwo5th5/SqUaRD2evGShlxB+SVCt3HAm0aexiGTKINtUxHplOATjEBWeXdKbMDozOJyyM/fxjEzzj7vTv+vwIElsdNqwu2r8zYtHwtdZ3ZTDTbLJ5w/I5a6xyDHHk6StUQHC1Fgt+FwfEl6ZcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by PH0PR03MB5687.namprd03.prod.outlook.com (2603:10b6:510:39::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Sat, 25 Oct
 2025 02:20:29 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9253.011; Sat, 25 Oct 2025
 02:20:29 +0000
Message-ID: <c7369d8f-5397-41fc-92de-afdcb47020d5@altera.com>
Date: Sat, 25 Oct 2025 10:20:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: rawnand: cadence: Add support for NV-DDR
 interface mode
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251024102611.310568-1-niravkumarlaxmidas.rabara@altera.com>
 <87zf9gpn1j.fsf@bootlin.com>
Content-Language: en-US
From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
In-Reply-To: <87zf9gpn1j.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0081.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:2b::17) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|PH0PR03MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a4c49e8-ac75-40d2-b438-08de136d10df
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDRwanczV3VlalFMaUVLRXVLdE5LN25abHZ0NkUzTWtCVjRqQmt2UXdhMUVk?=
 =?utf-8?B?WFQ0cThRNGVCbHo1VE8ydGJXTDREVWNLNVR2NVhISElVdCtTL1RoZVl1WmI3?=
 =?utf-8?B?UjhFaHVwN1p5aEJ3SXJHWkw1QVpJWW5OOUVDRGFDY0FvZDVUVnBSTHp0NmUy?=
 =?utf-8?B?RmhETzZGaFhIVThzUkZic3Zkb3BHRHZWb2FmK2V2VWlncFFKY1J1b1EwdzZh?=
 =?utf-8?B?cFBlOXJrem1VUDB3TGVYTE1nSkR5OGMyVk5DaTAzQlBLbGpEY0VPYmxkNTR6?=
 =?utf-8?B?djJSeElHSVNFeVZna1V6cmlvdExoN01JRWIvdlpqdEsvQnhiZEZtSTZmdTBD?=
 =?utf-8?B?dnIwd28vYkJPMWsrR0FmeHVqVitwdXlpS3ZkRlNKbXY2Zm9MdUY0OUZOT1Rl?=
 =?utf-8?B?ald0RUxBVnVhRC9sWjBPNHQwbFAyR3RPTkk4K2JoTVV1TkZnRy81RFdzVjUv?=
 =?utf-8?B?SGpaUXN3Si9GeHI5YzR1RGM2aXBOS1UzRDJraFpVRS9LV0cwbTZTMENKazBu?=
 =?utf-8?B?dEFIeTAxSkQyREQxZ1FZWUw1L0hVUTY5SGlTK0UyVCtiKzJFQXlyd09jSGZP?=
 =?utf-8?B?MHEzYmxoNWxld21ZVU15bVVxVGI5TlBJL2tDVVZtV0N3NVdoK3BUNnRkK0xl?=
 =?utf-8?B?YW9zYlFUYzFBb0o0ZkRlMXN0L0phcHB4QlhONFR1QjBPTk1RWEFURmVIajYy?=
 =?utf-8?B?T0NUWThHcVQ0MzA4WUM4Q1FtQy96c0pHQzQ3WUxlVk5NT1lBdktpcUw2NEVC?=
 =?utf-8?B?aFJYVGNnSU1YbWd2YWp6UGg1a09aU3JBNnMzREVkS3dhYjN3dFZldjVBVXR2?=
 =?utf-8?B?bHljZ0RMRWhma2wwTFpJb0lqVnA2T0M1SkMvZ3FmbFFHQlJORkJ1cHRBbEZE?=
 =?utf-8?B?SWFBR1lNSTlCSi9TbnRIcTBGZHBTLytiRXhlVDh5akx5ankwWVZDdjkrNUM1?=
 =?utf-8?B?Q3pOeWw1bUtINkxqc2ZZMzRFTTIrbVlySlJDS3dMUWFXREdwTHVLb0dFc3Fm?=
 =?utf-8?B?VUxITjJXSEhKYzN0cHVlNFp0TlQrTStsYWtFU2pXZE5neHYvVTg4dXhsL20v?=
 =?utf-8?B?RnRJWWxqOHl6SWpJc3pqc0ZxL08zekJlUTUwLy9GSXZTYmNCZTlDYzdiVTB4?=
 =?utf-8?B?bzVRSml0T2JqR0daLzJCS3dobnhYaVVSVTJhT2MrbnZaUU5DWW9mMmtyekZV?=
 =?utf-8?B?czZ2NWFtbms3b2NYaklCbGVobk1VRmhJS01IRGsvSHhpcGFwSnRHY3F4TlI3?=
 =?utf-8?B?cTBEZk1uY2VSN2N1bEFadW1YZnJreDRXbXVqaXV3UjYweENKMkN6VDN2WWto?=
 =?utf-8?B?cnVWaHFTZUMwbHJPa3EzV0dNQlBUNVNFUkwzM3FkV1Z2Sm1vUVV3aEVNTDBO?=
 =?utf-8?B?cElGTnhOeHNWa2FPRkhYaEx3cmVRRURORGpoaHhlY3F6NG9yS1pkaUdJTmhO?=
 =?utf-8?B?NHgzLzJVVDJvakZpK2NTbldMS1JxWkZMQlpnM2IrZUR1bFhkNjFUdkpZdlA4?=
 =?utf-8?B?RDZsVitBN0p6dnV0ZUpjMmpGUWF5cEJCMzg3NzlOcTh2REZ4UTB5bVRRTHhz?=
 =?utf-8?B?T0JqYVdyYmJDcmZ0RVdvb2NiU0VBc3RIcUdTTWJ1dDNtTVptR0ZGL2hKMjJ5?=
 =?utf-8?B?eFZQVXJlbjFLMm10c3B1YklBdzloZTU1QlRhQXgyOGlpV3RKMDB6RWVHekk1?=
 =?utf-8?B?aFFHWDBCVXRlRExCb3JOY1pZUjFuOS9sRXpDbmNvWVhjeDZxYUx0S3ZKWlNJ?=
 =?utf-8?B?T1FlQ28yZExVcjMva3VGVVBXUjgrV2Fmc3lrb2M2UmFUNWw0TGJwclpJdFg0?=
 =?utf-8?B?TThZUzJFVTQ0dklWLzRoWWZlRTBYN2VpdEg0SzZmZHVMMktlRVlPREFSMkVW?=
 =?utf-8?B?RTRRM2FuT1JPOGpRaHR1dytrdk96WUlyR2trUWMzWmwwMlc2clFhT093b2dQ?=
 =?utf-8?Q?NSlfEZD6neZBc1qSkZjqGjFxoZzFsVrN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDdycnVjanB1ejZQelUyU3lpSDJXWW1Qb2VDRm40Ri9sb2xLUlp1NEJXeFlL?=
 =?utf-8?B?NGo0T0R2akpsNmFYdVhsZjhraVJpbUhnVjNZMDQxUVU0SjIweitLUkZiK01x?=
 =?utf-8?B?aFREU2xEMG1NWkp3RWlyT3l3V2VhN0VHSjhRZEpNM1h1bkxHYnFxY3BFOURh?=
 =?utf-8?B?RmRSeFYweXA3TUwwOGlWU2N4NnNOYUJuZzRwczdWc3VrWjhVYkxvTzJ1YWE3?=
 =?utf-8?B?WTA0ODhRS0JsbTFuSEJkcGZzY1RacjNxVTRxSERabjZNVDNjZWNHbFBFM1RK?=
 =?utf-8?B?MWlZU0R2QkdIOUducU5QOHBtdkg0TVd6aFRCTG9lZStvRmVycVZWandma2lv?=
 =?utf-8?B?YnV6L2plOFNjZ1AwbVVSc3JXQzZlVkxMcDdCdVI5SU84eWdvMGh6OTR2dzdu?=
 =?utf-8?B?WDFxNVUxZDRkMUJvRm1IZzdhdXFnQU9Xa0grZnFCa2pyNjA3YUNKdlkwZHVJ?=
 =?utf-8?B?Wm5nTW1hK1hqUm9ZeXlheWczeDFXbUcwWG94Z1U3SmtwaUhWVVlFcTlGTHBP?=
 =?utf-8?B?TWhXUnpNMzNkclhaS0dlQ3pSUktyUDc4V0szTVYwQzh4SmcyenIyWlNQRnBh?=
 =?utf-8?B?QzgvcW5SVFZRdkhZNkMyZnI0R0xTVmc1dW5OS3N0UFp5cGljNUJMdUU5SlFO?=
 =?utf-8?B?V214Q0dTeHpyMGkvVjRpMVluWmhzZDBBakZFT2lkckltWm0vdmxtY3ZCcnlW?=
 =?utf-8?B?eGpFRXFLenNQSDNSZ1hnVk41SEFENEpOZTMvZXlTckovSk8xZ21MNlgvK2JP?=
 =?utf-8?B?bUg3eS9kQzVwSUhOV0lNeHNqeC9FZTI0dzFYRVh3K3l0L0RUR3NsV3ExaUd1?=
 =?utf-8?B?eUV0d0RhM2locGtSWThaNTdTeHZCVHkxYklLTkkwTDA3bXlSTFgvcS9qQ2RF?=
 =?utf-8?B?a21YZGkvdVh0NGtyc3pneVY0VHRvcWdCNUlGRmRxTGRHSGp4YkZtNTlFbmxa?=
 =?utf-8?B?bjRObGRmbUFIRXZSbVAxQ2FxMkNXWjJGbFVnbFR6UVBHb0hMOU1sNXMvblFJ?=
 =?utf-8?B?STg0NHJKUGtEdDN2bFlMVStqVWQwSVJYSmhTaHRBZkxOdE5UcmNwZ0dDU01R?=
 =?utf-8?B?ZUhVbE42L3RwcU82aEQ0MG0wYko2dkhxSWV1T2tWY2RLZHVyMStzcFB0QS9U?=
 =?utf-8?B?VVJPZnlYK0tGaW1QbWcxWmVqbGxUM0tmUDdJYUVESGw2dmU1YlozUjVVOU1R?=
 =?utf-8?B?b3BPNHNnaSs5aEJxbEduYnI1RXdmcVB5dWdnV3kybXZWVkNXV3AwYkhReTEr?=
 =?utf-8?B?b0xETlJIKzd0d01VYm9tWUpwbWVWVURwMGp2YW5vT21HMElzNHV4eDREUHJX?=
 =?utf-8?B?Y1MvMy9VUjE1YnA1U05ZN3FMZE9UYnJyL05PeXowL2FuTnoxMnRNbkx5UEN0?=
 =?utf-8?B?MXJoKzFEQ3dmRUxJUFhBOVRQdnlhQ3RZRktuLys0V3ZjMEl6Sis2dDM5Qndo?=
 =?utf-8?B?SVBzWG9OaHZMUmttQ0JaU1JOeXJkV01LU3R6d0JieWxQNjRFVDQwQzRJT21r?=
 =?utf-8?B?N1VHd2RuUHp6ZnF6dHA4azYvSEZUejZDN1BVUndQWURDVDhDOG5JU2cxZ2RX?=
 =?utf-8?B?bmhNQ0FhY01aRTM0aERPQzZQY2FITVJMaFZjU0svSVdiaGhPSzd2c0phRUEz?=
 =?utf-8?B?ZzlzaUM0SmNrSGVMSm4zUFNtaDZ0U2VlVnJWc2cwNXAxT0dxMzc0SUhUMi9k?=
 =?utf-8?B?MHNlUkhCVXlpd0hJSC95b1p0czd2cWx2WEF4bVphckRoNEF3VVNKcFE2Y3dK?=
 =?utf-8?B?L0F0cmc2TEZxcWI0eUU5NUVUTE9NQkRNcE9uQ1JJSTJtZ2ZHb0tHd3MwOGhq?=
 =?utf-8?B?Z0VHZDIvblpYSThCLyswb28yK2pvWFB2bWl6cDNVYWxXa0E1MnZLOGxmQTZ2?=
 =?utf-8?B?R2Z3NlNGQUpkcXlYNkhqRHFINWcvT2c5OFVCdlBPeXdHWU5GZzZlS0VPaDhk?=
 =?utf-8?B?YVFGUWQxTFhiblpWTnh6NnF1ejM2QVR2bEdONzJwQ01hVDFXR2xvZ2FjVkN6?=
 =?utf-8?B?QU9aSFpzclU4R2cwS2ZEdnY5U21BNlVNVS9ybElQRUdQbVZRZzlBdjdtTG5u?=
 =?utf-8?B?cmdEVG5pYk5za0lyTE9PNzlDTGVsY2IrVnJMVlRFUm5KRFBscnV5ejVyOWM4?=
 =?utf-8?B?UXZWaGNCMFRvNndxcHF1eWh3LzNiVVJVSkllV0IxNjNuZytzbVRORXEvK1No?=
 =?utf-8?B?R3hvVFFoTkdHUEdrdVkybitLbm1oeGthTE9LRVdmdktVQ2hUaXNvTUNLMWhq?=
 =?utf-8?Q?zh+EhAkAQCQQ3eyfq+2pf/Zbyf3NC+pX8Tt/3GBmCY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4c49e8-ac75-40d2-b438-08de136d10df
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2025 02:20:29.1043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQLnCoBjPF/G4PteO3h1c1HrCQsMqdA8WUUrebT//zIMqRURqfunn6Afl6jh8Zh3WDT+vId33YCDzwoD5iQiaJwY2dZohrQd+cutBYcDvcFuD5MLD5V5MGvvKNqonEvy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5687



On 24/10/2025 7:16 pm, Miquel Raynal wrote:
> Hi,
> 
>> +	if (nand_interface_is_sdr(conf)) {
>> +		const struct nand_sdr_timings *sdr = nand_get_sdr_timings(conf);
>> +
>> +		if (IS_ERR(sdr))
>> +			return PTR_ERR(sdr);
>> +
>> +		ret = cadence_nand_setup_sdr_interface(chip, sdr);
>> +	} else {
>> +		if (chipnr < 0)
>> +			return ret;
> 
> I still think this is incorrect. The chipnr value shall not be treated
> differently from the SDR path.
> 
> Thanks,
> Miquèl

You are right — the chipnr check should be common, irrespective of SDR 
or NVDDR.

Just to share some background on why I initially added the check only 
for NVDDR:
While enabling NVDDR support, I noticed that the setup_interface() 
callback is invoked once with chipnr = 0 for SDR, but twice for NVDDR — 
first with chipnr = -1 (NAND_DATA_IFACE_CHECK_ONLY) and then with chipnr 
= 0.
Because of this difference, I added the check only for the NVDDR path.

After your comment, I rechecked the NAND framework and realized that the 
behavior I observed occurs because NAND flash on my board supports NVDDR 
and the framework first checks for NVDDR mode, followed by SDR.

If the flash supports only SDR, the setup_interface() callback would 
also be called with chipnr = NAND_DATA_IFACE_CHECK_ONLY for SDR.

I’ll move the chipnr check before the if() in the v3 patch.

Thanks,
Nirav


