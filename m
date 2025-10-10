Return-Path: <linux-kernel+bounces-847604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0929BCB42C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 02:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AB063A9BE7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398532868B;
	Fri, 10 Oct 2025 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="bVCJhvI2"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013093.outbound.protection.outlook.com [52.103.20.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5309D625;
	Fri, 10 Oct 2025 00:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760055010; cv=fail; b=fL9wXX/11ppSx381USsPTbYbnBlyqTUjLExywmAgeJbwF4Y064FT+vOuo9LtSHgMFSnkekfpVI1RoqNX1F9XicVM/Qh7daOmTTSalyQgy+x2TKVlgG1zSvgt4Ccpc0VkxBRFiXfyBachB+QWJKVLloc3sxnH9PeSGKQvx5qj5kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760055010; c=relaxed/simple;
	bh=QMt4/pXO56PB0cQO0zB3pg09k8+Vm3w656CQ4uTXZrw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TinM1mubKz7RjhL9mwzSVjLrYrNuA/SrZc75XxbqynQSICZmdeRZtd+SuVpUb1mrzuy1xWn6yEmFb4BuACFmOvY54G0aa7w0mvG3pddbnfAv8DaOJgEarjXnKNEobg53fInhdd3dj0/XeLm8tYkqbodYAStacCwe5QFHGiw0syY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=bVCJhvI2; arc=fail smtp.client-ip=52.103.20.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITufQAbWleSjyMWkXN8fbqoaitkUHS3ZNXRdfBLilwuYMgAN7i2Lq+0CN92NakG08tTHLVRsDC0dE8woSvpU56jZqPWot/wMgAazaEB6IqoW+g1386gv1T61dZmhz13RC3Xnig8fo+PoTDyJKJtSxe0OJYZeijp5ukzhZUzQMRIAIb085pRo9kbT+xwvita/wCym6DU9KHu+bf1Nzphq5YIIL3dcmYMWds1gtpyjvVZxqZCtIZ31WZBzp6nzOwdkvABVIM8qCAjhPrhjYT9Nujd2+hRe+mknJ8zIJNijFXC843QbnvE+pw7rbKljUODn4S69k4hoMgI4S56zw5HwBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMt4/pXO56PB0cQO0zB3pg09k8+Vm3w656CQ4uTXZrw=;
 b=ieyo0JCYl4CjcDUNHXCGryFsJ1igqQC9yiCx0E4Qt4yYR3xJUNbScUl1lkRsDB4wohu7t21UlVX9tV9yersERtDp6wEA+KqpSa4KCffOousrCBpN2SVkgneebT4YGqttGJPKAOcgm6EA4Rw3CDWW/0knVWGUXACg07mHZZymnXdnRZ0ntMDlN+MUwPTsEewqzcVxqKvHYmjLD5ej3p6gjFvNxla0BlSJUYTY8P1lWdxOUrz5VRNeHf0bUqWPinRpTBF/fy61Waftf77RTd7lj/sGvTmf254hDEJ2tCGbjiRAgK75xgr7OaghaG3YJu3m4TrGAY7aMwysWn9aEgXDyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMt4/pXO56PB0cQO0zB3pg09k8+Vm3w656CQ4uTXZrw=;
 b=bVCJhvI2y4a//juJHwaUtGX1CocAmh5EhKNxfnv9kA7f6oZ8dwwvZnCBIrJnWvgLA66ePtBAP0lomrBVPW/ZZKi1y99ROUY6wSYhS7cAoMx7ddKviDvyIdOFjYlzXpNgikgKo35U8dcGOzCiyqi8SzyZ0A62uNQyrNzsH4BVW4JpCUr8kVnK9BDcUMIw4IZ2WIRMxdL24XbUFzaOm2bz455v/F05RnSIVgJKC30CZwpV233pxBZMn7Kb6SXAuzhZdhPjE4DBEsZQtKUc4qZaqXi89MCW1VyaAKrdNEW/AN4Wa8OjQpxkOymhBTGioAj4jtbbIUXcB/v0jAQi2LzY0A==
Received: from DS0PR84MB3746.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:1aa::21)
 by LV3PR84MB3458.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:212::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 00:10:05 +0000
Received: from DS0PR84MB3746.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::478a:57e4:fdbe:4a6c]) by DS0PR84MB3746.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::478a:57e4:fdbe:4a6c%7]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 00:10:05 +0000
From: Jonathan Brophy <professor_jonny@hotmail.com>
To: Lee Jones <lee@kernel.org>
CC: Pavel Machek <pavel@kernel.org>, Jonathan Brophy
	<professor_jonny@hotmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Radoslav
 Tsvetkov <rtsvetkov@gradotech.eu>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] leds: Add Virtual Color LED Group driver
Thread-Topic: [PATCH 1/4] leds: Add Virtual Color LED Group driver
Thread-Index: AQHcOPjeZbpHjj7zckCnYSQlC0YSorS57hKAgABzlMA=
Date: Fri, 10 Oct 2025 00:10:05 +0000
Message-ID:
 <DS0PR84MB3746BE2BCCCC3BB0185D3F6B9FEFA@DS0PR84MB3746.NAMPRD84.PROD.OUTLOOK.COM>
References: <20251009084339.1586319-1-professorjonny98@gmail.com>
 <20251009151847.GC2890766@google.com>
In-Reply-To: <20251009151847.GC2890766@google.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR84MB3746:EE_|LV3PR84MB3458:EE_
x-ms-office365-filtering-correlation-id: c852163b-b35e-4641-6993-08de07915d9e
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|41001999006|8060799015|8062599012|19110799012|31061999003|13091999003|3412199025|440099028|40105399003|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmJ0azdyM0NaaEdUaUtROGxUNmtaUUZMRW1aQW1OYTZybS8vNG9qOW1hVWpR?=
 =?utf-8?B?TGhkcGphVVl1S0kxTGEzTlJTcTNhRHVEYU0rWElkOWpNZVJiVDFKTDVDcVRD?=
 =?utf-8?B?UU91ZVI3Y1NRV29nYXlVWkxkTms4MkRSSm1OemN3QW0rWFcrZTk4eTBleWsy?=
 =?utf-8?B?a1N2UDZQazZlZnNiZFBCeU1iZUtXeFBxdVZVWHg5cEU4TEo1YVluZitIaUhp?=
 =?utf-8?B?L0RPd3QyVkJURk12ZDNvNnZuTmpzUHB1L01XK1NzbytkeS83ZXdSYXF3WVBX?=
 =?utf-8?B?bVJJSjh5dlplRUh3TllONFpsN2tSeVhqSkNvcW1TUHhWa2t2S28yMTh4L3Ey?=
 =?utf-8?B?VG5tY2hWUkhKMkQ5WU9sdGxBQmRJNE1uNVkvVFYxUFZxT1BXYmEyenNOWHpR?=
 =?utf-8?B?Y0ZVUkh5bERhWXRBTjZ1cWFOTnd0bXJNL2lidk1YdjZISFBhTE4wbFZnQnVn?=
 =?utf-8?B?ODlwdEFtdGp3K21TOU1MTzZGNXY2ZmR5RmRtZkdkaGhoYitGaWc4dk9IQUU1?=
 =?utf-8?B?dTUxTDVkL0FEMHhpV3RUQ1lvN0xNZHkvcmM3RmYwalZvengrRS9BaU9jM1hv?=
 =?utf-8?B?dDNxZlhSanFKM0VCYlVtYnNvRmhacmVzSU1VVUUrOXRVY0dQMzE1VWpNOXFQ?=
 =?utf-8?B?MzAwWW1KVTVtWTZ2blo4WXppNXRZdFBLZ1VSQlRCbmtYY1pzdnIxTm5rbVVJ?=
 =?utf-8?B?VFdYUk1IMkcrektmNVZFQXVaaW41UVlEWW96MXJ0aGE4ZUlyK0hQY0tqQ0cx?=
 =?utf-8?B?a0xtTE5vQXEzeTlMSVFTZXBPR2VvY1JVV3JhcEYxT3puMzd2WFhYbWh3QTll?=
 =?utf-8?B?NGZxUkQ3aG5oR2xIMTgrVWZWVm5MUnpMRW5qdUR3cWR0ZUtKSSt6cnA2K2hC?=
 =?utf-8?B?dUdQK05xbG15L1ZZdTlVLzl1OEI3bWlOU243QjNkelh2VTRHTDNrakEyNVJZ?=
 =?utf-8?B?WklCZzZMNUJwTm41NldONHd4V3pUelNHQkp6Vm1LV2FEN0wwTG5YMzVSUDhx?=
 =?utf-8?B?OXI1OWUwc0E4WFllcFdaaWFLcW4xQjZNVG5kTy9ZWGozR2RLOEZhZnVkNWNB?=
 =?utf-8?B?SThWRSt0M2tqcmgrNHF4ODB3RmkwMmtvdjZxaDJDcnluWjFvdHhrS0FpMlJl?=
 =?utf-8?B?N1B0cEk5amk1aDVKZUFFUUFTVzY4SjlnY012UE9UcGdSYWM0aHVzNml2NUl3?=
 =?utf-8?B?YU1VeXFmTnM1bnExbXNwd2pSbXhFY3ZGR1NNNGFmcUJPa3BYQ0EvRVE4dEtn?=
 =?utf-8?B?MEY5ZTJ3MlFVSnY2UjZhdHBGR1RGL0FkQXptck84QmhUR2xJQUpuTkxHbldp?=
 =?utf-8?B?VkNoNTZEdHJmT3BUcHJaZ0d2eFdTUGFLM2xmRzZ0RFlXcjV0YldBT1B4QTZK?=
 =?utf-8?B?QVFINmpPUDBqMG85SmVQQ2djQkcrcUc2ZGlHcDVxMU9QNzhnb0NLTDg2Q2sx?=
 =?utf-8?B?MGV1bzAwazdhZHlmMStnUE1RNnFGZzhRUFZkNGp4VU9PeVJSNEE0WnUrSTZZ?=
 =?utf-8?B?d01WMWgrZzRBTWJ2Ni93MXNGVzFGektxUU5FbUdSaGUrK1hwY0pSTzVIVDBs?=
 =?utf-8?B?RXBUckhjcWszUUF4TUM3MlIrOThQOGhKMXlEaUl3bEdnMUZwdHV2WU5YWGdt?=
 =?utf-8?Q?ndTpY4HNv+VMwWsZ3yB1cof9oFoUcgEMM4CrXDlC5RJs=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXZnd3FVcTZkTksraGdUbXJjMUpFZElockxaNHY4SVdCNE5ENEw0NG1zWHZo?=
 =?utf-8?B?M0pHeWtNVU1xa1ZUeFlxYXo3eStnRlNTaFZoYzFFb3QrMVhNWEh5WXRjbWhP?=
 =?utf-8?B?eG03UEY5dzQ0SjZ5c3hiSDJTVzQwV2Qwa2dEQ21nY3lDT3UzczdEVnZXODhv?=
 =?utf-8?B?V09td2dYMzdhSU5iYlJIbUtON09uRExvSGZSUUhKRSs4Q0JjMjl2NDZvQldY?=
 =?utf-8?B?Wk1TRWJZK0hGNnpnNENmMElMRnM3OTduU0d4d0E1YituanBKNVVZQUpmcC9h?=
 =?utf-8?B?dDNXTDMzZkRXYVBFakdNY2lWQzB5U2s4bmhSaU4zc1Z5YytoQnVVUWlHQm01?=
 =?utf-8?B?ODI2TTRuUzJiSHRPWERFMkpTVVJqblpVRllMVDB0V3F3MTgySEEvbGNkakdm?=
 =?utf-8?B?bi9CV2NMY21aMVIvOHQ4ZVlRWm1ZdVBhQXQ3UjhhZmJKQlhta2FXcFk5V3M2?=
 =?utf-8?B?dHBaS2lOWmZReGlVeFd5N0R3M2hJbmo0UG42UWcyV0tBYm5mOUhpdHJGeHVm?=
 =?utf-8?B?b1RIMlU1MVgxRDBsdXFoVXptcGhaMFVNUGpZOHJSUFFjNmN3UmFlR2M4M3Ni?=
 =?utf-8?B?SXF1MDBWcnErdC9aTzdGNDdJMG9aMDFTKzBCcUFhMzB2Qmh0RGFTQy83a0U4?=
 =?utf-8?B?L1hXRlpudUdmeE9YbDBRY0pJTWc1SDJGKzlpUU92SFl0cTlSTERMMWNQNy93?=
 =?utf-8?B?b3UzbndPV1U2c3BrNjRNMDgwM0phMkU1OTJSbUdMRmF3UmpaWXVVNS9DcDh1?=
 =?utf-8?B?YTR3TVM3ekdIRGJLOXZGRW8zS29SeFZBaG82cVNKNExRUUVNNmd4bVh3SzVq?=
 =?utf-8?B?MWZtcGh6ZklsL0RHazBBd3IwNVpNbUZ3MHlmUjhoV2tnUUdBUDY2a3Z4RW1G?=
 =?utf-8?B?NGZWTEFJWnRBL1N5VzhzRXhycHljTm1Hd3hCSzEySGN1MXVXVTFWWE40L3h5?=
 =?utf-8?B?NjFid05XaFFoYUhpSExiVDgvOE83ZXptMDV0YnF0aFpnK0JtN2xxdUpXMkUx?=
 =?utf-8?B?SGdNeDI1aGxUbUsya1FJQVozUzVGLzJibUtlaXl3aTVhcmFqYll0Q1d2TGRD?=
 =?utf-8?B?TWNaOXU5alhxZlVxbnhLZEpOdldiVHpNaVRwYmFnMmdmU3RjUzFKYkR4SDFD?=
 =?utf-8?B?dldtSlpWcmNSUFByS0hzSEN6Mkt5NlY3TUJ3TUZ1cEoxeU5sWndiUHdOKzRn?=
 =?utf-8?B?L2lBaWtPcTVwUVNsUUNnYUpQeER6NmxpdDNuZ20rRlVLZ3dTd2RZTFMxSzlE?=
 =?utf-8?B?SGMvemFIbTVXMGdMaFB0WVRtMzI0R3d3VDJtdHI4MmhIRk9sNERRU1A3ZXNS?=
 =?utf-8?B?anRpYTVNeUlISDBBcnl0Um9MQThSbFI4bWdTU01YeERBRXBjc1VMRHZFYmhW?=
 =?utf-8?B?N0l0bmVkdUZmeHhyVmJ0YUxEc3ZLczd3a2VvV2RhSzh6OE15Lzc5VFpzMlMw?=
 =?utf-8?B?N1Yvb25mUFZ2WUJhMHAyUDhtOUo4RHRrODZXdlhvOVUwUDl1Y2V6SFh4UlF2?=
 =?utf-8?B?cDl0SmxhOGg1OWJhVGppVmlwcy9vUmY2YVBuK3V3SFdFRmJQem5yUnpjYUht?=
 =?utf-8?B?ODcxZjJpU3BsRURHL2ptWmV0b0k1K09mRTFUOTNTQlRHeXU2WEtmT0JQT1BT?=
 =?utf-8?Q?vRvpLI18Mc5ruD+UEP3L/ss7iQjyedJwdi9XyTfLqJCY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-774d9.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR84MB3746.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c852163b-b35e-4641-6993-08de07915d9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 00:10:05.5124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR84MB3458

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMZWUgSm9uZXMgPGxlZUBrZXJu
ZWwub3JnPiANClNlbnQ6IEZyaWRheSwgMTAgT2N0b2JlciAyMDI1IDQ6MTkgQU0NClRvOiBKb25h
dGhhbiBCcm9waHkgPHByb2Zlc3Nvcmpvbm55OThAZ21haWwuY29tPg0KQ2M6IFBhdmVsIE1hY2hl
ayA8cGF2ZWxAa2VybmVsLm9yZz47IEpvbmF0aGFuIEJyb3BoeSA8cHJvZmVzc29yX2pvbm55QGhv
dG1haWwuY29tPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3ps
b3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVs
Lm9yZz47IFJhZG9zbGF2IFRzdmV0a292IDxydHN2ZXRrb3ZAZ3JhZG90ZWNoLmV1PjsgZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWxlZHNAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIDEvNF0gbGVkczogQWRk
IFZpcnR1YWwgQ29sb3IgTEVEIEdyb3VwIGRyaXZlcg0KDQpPbiBUaHUsIDA5IE9jdCAyMDI1LCBK
b25hdGhhbiBCcm9waHkgd3JvdGU6DQoNCj4gRnJvbTogSm9uYXRoYW4gQnJvcGh5IDxwcm9mZXNz
b3Jfam9ubnlAaG90bWFpbC5jb20+DQo+IA0KPiBUaGlzIGNvbW1pdCBpbnRyb2R1Y2VzIGEgbmV3
IGRyaXZlciB0aGF0IGltcGxlbWVudHMgdmlydHVhbCBMRUQgZ3JvdXBzIA0KPiBieSBhZ2dyZWdh
dGluZyBtdWx0aXBsZSBtb25vY2hyb21hdGljIExFRHMuIFRoZSBkcml2ZXIgcHJvdmlkZXMgDQo+
IHByaW9yaXR5LWJhc2VkIGNvbnRyb2wgdG8gbWFuYWdlIGNvbmN1cnJlbnQgTEVEIGFjdGl2YXRp
b24gcmVxdWVzdHMsIA0KPiBlbnN1cmluZyB0aGF0IG9ubHkgdGhlIGhpZ2hlc3QtcHJpb3JpdHkg
TEVEIGdyb3VwJ3Mgc3RhdGUgaXMgYWN0aXZlIGF0IA0KPiBhbnkgZ2l2ZW4gdGltZS4NCj4gDQo+
IFRoaXMgZHJpdmVyIGlzIHVzZWZ1bCBmb3Igc3lzdGVtcyB0aGF0IHJlcXVpcmUgY29vcmRpbmF0
ZWQgY29udHJvbCANCj4gb3ZlciBtdWx0aXBsZSBMRURzLCBzdWNoIGFzIFJHQiBpbmRpY2F0b3Jz
IG9yIHN0YXR1cyBMRURzIHRoYXQgcmVmbGVjdCANCj4gY29tcGxleCBzeXN0ZW0gc3RhdGVzLg0K
PiANCj4gQ28tZGV2ZWxvcGVkLWJ5OiBSYWRvc2xhdiBUc3ZldGtvdiA8cnRzdmV0a292QGdyYWRv
dGVjaC5ldT4NCj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gQnJvcGh5IDxwcm9mZXNzb3Jfam9u
bnlAaG90bWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9sZWRzL3JnYi9LY29uZmlnICAgICAg
ICAgICAgICAgICAgIHwgIDE3ICsNCj4gIGRyaXZlcnMvbGVkcy9yZ2IvTWFrZWZpbGUgICAgICAg
ICAgICAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL2xlZHMvcmdiL2xlZHMtZ3JvdXAtdmlydHVh
bGNvbG9yLmMgfCA0NDAgDQo+ICsrKysrKysrKysrKysrKysrKysrKw0KPiAgMyBmaWxlcyBjaGFu
Z2VkLCA0NTggaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbGVk
cy9yZ2IvbGVkcy1ncm91cC12aXJ0dWFsY29sb3IuYw0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbGVkcy9yZ2IvS2NvbmZpZyBiL2RyaXZlcnMvbGVkcy9yZ2IvS2NvbmZpZyBpbmRleCANCj4g
MjIyZDk0M2Q4MjZhLi43MGE4MGZkNDZiOWMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbGVkcy9y
Z2IvS2NvbmZpZw0KPiArKysgYi9kcml2ZXJzL2xlZHMvcmdiL0tjb25maWcNCj4gQEAgLTc1LDQg
Kzc1LDIxIEBAIGNvbmZpZyBMRURTX01UNjM3MF9SR0INCj4gIAkgIFRoaXMgZHJpdmVyIGNhbiBh
bHNvIGJlIGJ1aWx0IGFzIGEgbW9kdWxlLiBJZiBzbywgdGhlIG1vZHVsZQ0KPiAgCSAgd2lsbCBi
ZSBjYWxsZWQgImxlZHMtbXQ2MzcwLXJnYiIuDQo+ICANCj4gK2NvbmZpZyBMRURTX0dST1VQX1ZJ
UlRVQUxDT0xPUg0KPiArCXRyaXN0YXRlICJWaXJ0dWFsIExFRCBHcm91cCBEcml2ZXIgd2l0aCBQ
cmlvcml0eSBDb250cm9sIg0KPiArCWRlcGVuZHMgb24gT0YgfHwgQ09NUElMRV9URVNUDQo+ICsJ
aGVscA0KPiArCSAgVGhpcyBvcHRpb24gZW5hYmxlcyBzdXBwb3J0IGZvciB2aXJ0dWFsIExFRCBn
cm91cHMgdGhhdCBhZ2dyZWdhdGUNCj4gKwkgIG11bHRpcGxlIG1vbm9jaHJvbWF0aWMgTEVEcyB3
aXRoIHByaW9yaXR5LWJhc2VkIGNvbnRyb2wuIEl0IGFsbG93cw0KPiArCSAgbWFuYWdpbmcgY29u
Y3VycmVudCBMRUQgYWN0aXZhdGlvbiByZXF1ZXN0cyBieSBlbnN1cmluZyBvbmx5IHRoZQ0KPiAr
CSAgaGlnaGVzdC1wcmlvcml0eSBMRUQgc3RhdGUgaXMgYWN0aXZlIGF0IGFueSBnaXZlbiB0aW1l
Lg0KDQpHcmVwIGZvcjoNCg0KICAiVGhpcyBkcml2ZXIgZ3JvdXBzIHNldmVyYWwgbW9ub2Nocm9t
YXRpYyBMRUQgZGV2aWNlcyBpbiBhIHNpbmdsZSBtdWx0aWNvbG9yIExFRCBkZXZpY2UuIg0KDQpE
b2VzIHRoaXMgc2NyYXRjaCB5b3VyIGl0Y2g/ICBJcyB0aGlzIHNvbWV0aGluZyB3b3J0aCBidWls
ZGluZyBvbj8NCg0KPiArDQo+ICsJICBNdWx0aXBsZSBMRURzIGNhbiBiZSBncm91cGVkIHRvZ2V0
aGVyIGFuZCBjb250cm9sbGVkIGFzIGEgc2luZ2xlDQo+ICsJICB2aXJ0dWFsIExFRCB3aXRoIHBy
aW9yaXR5IGxldmVscyBhbmQgYmxpbmtpbmcgc3VwcG9ydC4gVGhpcyBpcw0KPiArCSAgdXNlZnVs
IGZvciBzeXN0ZW1zIHRoYXQgbmVlZCB0byBtYW5hZ2UgbXVsdGlwbGUgTEVEIGluZGljYXRvcnMN
Cj4gKwkgIHdpdGggZGlmZmVyZW50IHByaW9yaXR5IGxldmVscy4NCj4gKw0KPiArCSAgVG8gY29t
cGlsZSB0aGlzIGRyaXZlciBhcyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVyZTogdGhlIG1vZHVsZQ0K
PiArCSAgd2lsbCBiZSBjYWxsZWQgbGVkcy1ncm91cC12aXJ0dWFsY29sb3IuDQoNCi0tDQpMZWUg
Sm9uZXMgW+adjueQvOaWr10NCg0KSSdtIG5vdCBlbnRpcmVseSBzdXJlIHdoYXQgeW91IG1lYW4g
YWJvdXQgZ3JlcCBmb3IgYnV0IEkgY2FuIHVwZGF0ZSB0aGUgbWVzc2FnZSBtb3JlIGZyaWVuZGx5
LCBpZiB0aGF0IGlzIHdoYXQgeW91IG1lYW4/DQoNCkFzIGZvciBpcyB0aGlzIHdvcnRoIHNvbWV0
aGluZyBidWlsZGluZyBvbi4uLi4gIHRoZXJlIEFyZSBwb3NzaWJseSBtb3JlIGZlYXR1cmVzIHRo
YXQgY2FuIGJlIGFkZGVkLCBidXQgaXQgc2VydmVzIHRoZSBwdXJwb3NlIEkgaW50ZW5kZWQgdG8g
dXNlIGl0IGZvciBjdXJyZW50bHksIEkgZGlkIHRoaW5rIGl0IG1heSBiZSBhIHNlY3VyaXR5IGlz
c3VlIGlmIG9uZSBjb3VsZCBjcmVhdGUgdmlydHVhbCBsZWQgaW5zdGFuY2VzIGZvcm0gdXNlcnNw
YWNlIGJ1dCBpdCBpcyBhIHBvdGVudGlhbCBmZWF0dXJlLg0KDQpPdGhlciBmZWF0dXJlcyBzdWNo
IGEgY3ljbGluZywgZGltaW5nIHNlcXVlbmNlcywgb24gZGVsYXkgYW5kIG9mZiBkZWxheSBvciBt
b3JlIGNvbXBsZXggbG9naWMgY291bGQgYmUgY29uZmlndXJlZCBpbiB0aGUgRFRTIEkgZ3Vlc3M/
Lg0KDQpPcmlnaW5hbGx5IHRoZSBkcml2ZXIgd2FzIGludGVuZGVkIGZvciBPcGVuV3J0IHNvIHN0
YW5kYXJkIHRyaWdnZXJzIGFuZCBhbGlhc2VzIGNhbiBiZSBhdHRhY2hlZCB0byB2aXJ0dWFsIExF
RHMsICB0aGUgaW50ZW50aW9uIHdhcyB0byBiZSBhYmxlIHRvIGNsb3NlbHkgbWF0Y2ggZnVuY3Rp
b25zIG9mIE9FTSBwcm9kdWN0cyBzdGF0dXMgTEVEcyB0aGF0IG9mdGVuIGluZGljYXRlIG11bHRp
cGxlIHN0YXRlcy4NClRoZSBpbnRlbnRpb24gd2FzIHRvIGVsaW1pbmF0ZSB1c2Vyc3BhY2Ugc2Ny
aXB0aW5nIGNvbnRyb2xsaW5nIHRoZSBsb2dpYywgc28gdGhlc2Ugc3RhdHVzZXMgY291bGQgYmUg
cmVhbGlzZWQgYnkganVzdCBzaW1wbGUgYmluZGluZ3MuDQoNClRoZXJlIGlzIGEgc2ltaWxhciBi
YXNpYyBkcml2ZXIgZnVuY3Rpb24gaW4gdGhlIFF1YWxjb21tIFNESyBiYXNlZCBvbiBPcGVuV3J0
IGJ1dCBpdCBkb2VzIG5vdCBmZWF0dXJlIHByb3BlcnRpZXMgc3VjaCBhcyB0aW1pbmcgYW5kIHBy
aW9yaXR5Lg0KDQpPbmUgdGhpbmcgaXMgdGhhdCB0aGUgbGVkIGR0IGJpbmRpbmdzIHByb3BlcnR5
J3MgZnVuY3Rpb24gYW5kIGNvbG91ciBhcmUgcXVpdGUgcmVzdHJpY3RpdmUgaW4gbmFtaW5nIGFz
IHlvdSBjYW4ndCBzdGFjayB0aGUgZnVuY3Rpb25zIHdoZW4geW91IGFyZSB0cnlpbmcgdG8gZGVz
Y3JpYmUgcHJvcGVydGllcyBvZiBhIGNvbXBsZXggbGVkLCBvciBpZiB5b3UgaGF2ZSBtdWx0aXBs
ZSB2aXJ0dWFsIExFRHMgb2YgdGhlIHNhbWUgY29sb3IsIGl0IGNhbiBnZXQgY29uZnVzaW5nIGFz
IGl0IHByaW9yaXRpc2VzIHRoaXMgYXMgb3Bwb3NlZCB0byB0aGUgbm9kZSBuYW1lIG9yIGxhYmVs
Lg0KVGhlIGxhYmVsIHByb3BlcnR5IG1ha2VzIGl0IGVhc3kgdG8gZGVzY3JpYmUgaXQgYnV0IHRo
aXMgZm9ybWF0IGlzIGRlcHJlY2F0ZWQuDQoNCkVHOg0KDQpmdW5jdGlvbiA9IExFRF9GVU5DVElP
Tl9TVEFUVVM7DQpjb2xvciA9IDwgTEVEX0NPTE9SX0lEX1lFTExPVz47DQoNCmxhYmVsID08WUVM
TE9XX1NZU1RFTV9GTEFTSElOR19WSVJUVUFMX1NUQVVTX0xFRD4gOw0KDQpjb3VsZCB3ZSBzdGFj
ayB0aGUgcHJvcGVydHkgZnVuY3Rpb24gaW4gYW4gYXJyYXkgdG8gbWFrZSBpdCBtb3JlIGRlc2Ny
aXB0aXZlOg0KDQpmdW5jdGlvbiA9IDwgTEVEX0ZVTkNUSU9OX1NUQVRVUyA+LCA8IExFRF9GVU5D
VElPTl9GTEFTSD4sIDwgTEVEX0ZVTkNUSU9OX1ZJUlRVQUxfU1RBVFVTPiA7DQoNCk9uZSB0aGlu
ZyBJIGRpZCBhbHNvIG5vdGljZSB0aGUgQ29sb3VyIE1hZ2VudGEgaXMgbm90IGFuIGF2YWlsYWJs
ZSBvcHRpb24gaW4gdGhlIERUIGJpbmRpbmdzIHdoaWNoIGlzIHRlY2huaWNhbGx5IGNvcnJlY3Qg
Zm9yIGFuIFJHQiBMRUQgIGJ1dCB2aW9sZXQgYW5kIHB1cnBsZSBpcyB0aGVyZSBhcyBhIGNsb3Nl
IG9wdGlvbiBidXQgSSBkb24ndCBrbm93IHdoZXJlIGhlIGJlc3QgcGxhY2UgaXMgdG8gY29tbWVu
dCBvbiB0aGlzLg0KDQpKb25hdGhhbiBCcm9waHkNCg==

