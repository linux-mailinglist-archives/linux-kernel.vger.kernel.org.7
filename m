Return-Path: <linux-kernel+bounces-840304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED99CBB40EF
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 15:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A2194E2B1E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 13:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4FE31329E;
	Thu,  2 Oct 2025 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p6mdIUEN"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CADE311977;
	Thu,  2 Oct 2025 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411930; cv=fail; b=OvJTIxJR5LkolV+KhJ8aaecSFo9P374KkF9xGSooj0lpsAUEsp4IXK5NBO73TjmoQ4ZMkjqkeLuja0z5UjCL348KHqrc0pyS+VhC1TXO8feqUN5zzL/s5fMQkxpvY4sTZ0WqAldhruUEqw9Mk6LuwKJBXw9oWqjRAQAN1OlsIpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411930; c=relaxed/simple;
	bh=SdbG+V8bgMYYEb14ddVjuPz9BRK4t+kfrYod0wpN37k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jv/7Tu5As4T0HPOMzYVa3SkS1+X1I4S2PVOJDEXQfG5e2pxIMFIEhaDtbbLzO8xom1rkF9XIEHTtD84aLThNvPuEUwvM/I2GbuasmGm/1ncal/Et4JLTnO/PfihaDCVygXCtO+Q66NEpT9aJLE6eDzDlGjSAvqLPtpAFr8xJmZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p6mdIUEN; arc=fail smtp.client-ip=52.101.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZMms/yCjof2mgl+g4s6UY6LdKUJDmnLigQqCDayAmZnwOGF2a1biB3LPMdCRgyk9uw5WoikOU7/+qtf0OIefaf2Bc3cnhxyJnELPMPGfTF1u2h2gTHEwy3eV9cGfnpNwodOFvMJ8eOf4aP5X93jpWWDAYomPPrSR1hx2NREFipjsL7L/0PgTmRwNs+dyQaSEh0lUJD2j+esv3A2hoAP2i7yEeC4WjFfsRvsn0/w8s7vqUospXeATCLpp2sPDxXp6aB10a59LB4EoGJzZp+gICaqxIxuscB6Kdqz7ERuXKoT94XkwuBUZW4Oja9UAC9UTAQ6hOshiLRvVvIKbb1TXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdbG+V8bgMYYEb14ddVjuPz9BRK4t+kfrYod0wpN37k=;
 b=xzmPAFoCTBRaxsZoXheLswxkM2ZstZA2+Db4kQevRYGNpQ4VzocHL723mYzteyOYaPGjGAfBplU0Xu58Mp6OqQ9oBTsCGJunSpnfyi9pE9O5Co9HYJAbPSq0ms+Lz2PnZwTl8dnCEhE83fgAq6GUKCSUhAo2p90KOXxz96fFKM1XwVAdG6lV4LkVHlcnuDMkkl6wTFbp2jnnM9Dv1e4fKCd43EHRURCVEzJIRJtKp4voV0LSlXGCyrJj6GPOHY5sZdClGMHXlFzOyqu52knZWNCtepUsbN4Mwqgl8q8OKZOVNIBWEg76rbTAvezvWB06/BTloi1NOiGufpFZ0B+lYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdbG+V8bgMYYEb14ddVjuPz9BRK4t+kfrYod0wpN37k=;
 b=p6mdIUENToW7c4/J0w2SKmxnjK99f0WFz5Uh4jYPjtLznCG4c9DPLTQAiRZc4wqRt2kDIULaW36mzQcIxY5Ma4LwYmieultDus1fFZ7BJbXQkG/MU86hjBwsZZH32OAwoOaRixorc/QVTWUgZMXVI1B7W6LhP3IkDrGS7sXPjt01WSh+bW/UzNFxuLFQxREc3Lfnnbw1hePn5FMnNNPoUKfXGXSWTHzdy5z0Fh/Ko97Fu3b4Ar5lEOvbkD/faePTcAV/3oAuaitnNXpk4XV+3XGzJQvfttaGkfeVcDQHA3wK1h3iWpRfSRqiSnG9sNf0eivhlswjjEYbsakqcVvgBg==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 2 Oct
 2025 13:32:03 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 13:32:02 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
CC: Yury Norov <yury.norov@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>
Subject: Re: [RFC PATCH 0/2] rust: bounded integer types and use in register
 macro
Thread-Topic: [RFC PATCH 0/2] rust: bounded integer types and use in register
 macro
Thread-Index: AQHcMuSa3CM8I/X/VESFd3sVK/64K7St2eiAgABSf4CAAK+vNQ==
Date: Thu, 2 Oct 2025 13:32:02 +0000
Message-ID: <C35B5306-98C6-447B-A239-9D6A6C548A4F@nvidia.com>
References: <20251002-bounded_ints-v1-0-dd60f5804ea4@nvidia.com>
 <6d4b5659-7c0e-4720-8305-5b0053807443@nvidia.com>
 <DD7I3NGT6DHI.114KADERSQ8VG@nvidia.com>
In-Reply-To: <DD7I3NGT6DHI.114KADERSQ8VG@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|PH7PR12MB6491:EE_
x-ms-office365-filtering-correlation-id: 4d246abb-280d-43fd-1858-08de01b81275
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bHhXaGdaMGM2T0lxVnpVbjV2bUptbXZLb1dyYU9KYW1ySGs4eFhqVktMTWZz?=
 =?utf-8?B?NXM2SXk1elZkR2ZVbXBVMDA1eUN5WFdGQ0QrajhHbDVsam5aYWNiOVlMNDdV?=
 =?utf-8?B?TndoaE56czdzd2tramlicVNOcnBQR3FSTGhja3dMVTQ3TGZUVGV6cHB2d2p2?=
 =?utf-8?B?TDVNbTQ0UG9VK2NUbEYrTVVJamhadjd1YVBUaEZPczFWbHQxMW9Pa05xSXV2?=
 =?utf-8?B?eCtVd3hkbWU5bGQzZWJhWWJrc2ZXaTBrTHZOZmMyajdhWlNBZjQ5L29wdTNy?=
 =?utf-8?B?TnV5OGFIR1JmL2hzN09lNk82ODZLUDRHV0JsVkxSbTI1c09xa1RCeXp6eWUy?=
 =?utf-8?B?SDVmZ205YnRURFBiK3VSOWhoMnVIZUZiUXBjNXVZK0l5UGpiUUtIcG5Vc1g3?=
 =?utf-8?B?Q3h3bGJEZXZEZjAyMll4Tlo0VlhnMmcxY3Z5cVR6R3Fnem4wbzY3T2RPb0pB?=
 =?utf-8?B?aDJybzVZU3MrVW1CdTZpV3VrZnBteVozTHZKSWlESFdidHpJcXBGYVNTTHB5?=
 =?utf-8?B?cExzamcvek4wMkMrOXU3SVEycXBCZUt3YmZ6ZEdEc3RxZVpkeEhndXpjVlhJ?=
 =?utf-8?B?RkZ3bWxaZllSSmNVVFlBSGx0RWl5UG5FOSt2RU5rZVhtaGdrVWJ2bFR5RjlW?=
 =?utf-8?B?NExJVTB0YUVNRmRCV0IvUnFCSFlVcEZ1czUvak1KQkNBTzF4MHFXeVJnSzZl?=
 =?utf-8?B?dUVrL0pSUnkrWFdNazNzTExxenYwSlJ0SDRxNVFYRVhIbzlWNExNbzZ1Nkwv?=
 =?utf-8?B?TGVnbW93SWdFanRZUkUySEtlM2F6SGtRdTRhaG1CS2NCSmdMUUlXa0RhKzBv?=
 =?utf-8?B?dWtmNXZlWGsvb2orQUZraWtMeFdONVg0OEtaSmNrK3I2eEhNUTRYNmVwRzJJ?=
 =?utf-8?B?bWZYQWttOFNUT3pDalVoeURBUTQya0lPa0UwK2JWL1RyTnh5V0p1OWh4QjlO?=
 =?utf-8?B?aERPZndyK0t1QmlLenc2NU5IMUpqN2VSbjBNcEdubllndm5scE51YUIxZTho?=
 =?utf-8?B?cE5mMXZQUkZDMXdmaHpmKzRyRm1xTTN0RStRM1lEMmdtdWhJblFWUkFxaW9i?=
 =?utf-8?B?QU9uTE9xQy9pV0ZpVFZXOTI0ZnpNdHZsc240dzJtWDhhR0hvb0FuUFVGSmE4?=
 =?utf-8?B?L05wWS8rdkRZNDk1TVhOM2JmNlJUbDVWcFNjVklGWVZwaFRIWlMxeDNzSlVT?=
 =?utf-8?B?NWtIQVo3c0hyUk43c2twRVpEL1dRelpvak40R1NyUHdWN1VhR2NWdEliZko0?=
 =?utf-8?B?cTltMWdCazRSMGpBYy82SnJqckN4dVdadWRYUEhUM3ltVHE4ZG5oQXhjTXpz?=
 =?utf-8?B?ck5uQkNzYnVXUjB6b2dNOU9WeXVDNWZqWXlaVkNBaUVBdnZjaitUd0ltTHhC?=
 =?utf-8?B?aVM4Q2ZMU2dsRG5Ya1NQZ1RORGNYdUtlUUMxTmJ3RThVZHhsL3pPVldZL3Ux?=
 =?utf-8?B?REZPUlNubU03LzVWMDV0NmVPQ0QrR2tyellMbC9vZmxUWWFnNlUrbWVXVTdQ?=
 =?utf-8?B?UkJNQlVVeHpNclJjRE1aM1lTN3FweGFreHpyblNZQ2UxcmF5cUFsQ0FSY3l5?=
 =?utf-8?B?QjhSVmJNR00rNWVvSlc0c3V0SUhyMytSZ1NVM1U5LzAxWFAwcDRBaVVjOFk3?=
 =?utf-8?B?NVpBT20wSkl5b3F5TXp5S3h6K08yTHNSektiVFNySmUycHJBZzNNcys5L0ho?=
 =?utf-8?B?MkNjSkwwVk12YUxQK290Y08xeUsxQ2dzWXhUdS9GUnIvdkRXeDRpREsvT1Mz?=
 =?utf-8?B?ZXgzWm1HMUdMbTIwVmhLeHBiSDloeURyRHRic2ZSQ1lJTlhXTUV4aVZBM2x6?=
 =?utf-8?B?SkJjRW12RzRvdFdsQ2FXTVRUUXVicnNwZThPZWhKVFlSSENQVmYyZHBWUW9Q?=
 =?utf-8?B?TC9ZNmJuODQzNmhaYUt3KzJUQTBqZHUzczFRRVVjeFIwaHpCNnZCTmViSWZi?=
 =?utf-8?B?MC93WmZiQi9YNnB1OHo1MUMyZWtYTjFXdjg3WXVRTUZwWGl5MjVCVjNCcXJp?=
 =?utf-8?B?MExhQnk1NFExTGMvS1JrdDRmclJ3N2MxRGZtcmN0bGJjay81QVBsc1N0aERK?=
 =?utf-8?Q?/s4gq7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVBkSVJ0clRPUlNYeGRUdHJhamNaWnZzZDF0aHJmQmlSMmlNYlRJMGlZdUll?=
 =?utf-8?B?Qk9HTEZGK243dVVueXBwdjJhQmRDVzJnRmlqQkEvWU1TR1pPMmE3cFVQTXYx?=
 =?utf-8?B?T0dJZmNmcTc0dzlERnNqVkJncTNPeTBLa21sL3hxZ1hJZlJwRjhDZVFaUExT?=
 =?utf-8?B?ZkFCQzhMVkNOdmFFTHNQczVzTEpSK1Y4VGNTVldyVURRUDA3dzRIRnVyckZm?=
 =?utf-8?B?SlJ2VlIzV243VUxzdzk2N0h0dUNyNTgxR0Z3czRrZUJURGNtMUFqRlZ1dWp5?=
 =?utf-8?B?NzlYZUplK1dGNFgxcWdxY250THFXRkRsUEV4OEdkOFk3M1lEcmI0SVZueDFi?=
 =?utf-8?B?T0NsUlJmVkhuUThkU29uOFdxOG5mSStSOEVXU1Facmc4YzJPRXZNN2Rua0Fr?=
 =?utf-8?B?K1RiamRlbk9sUzBsQXZ2Y3pyTHEvU0JzYW05dWExUkJMSFRNNjZyajNBRUIy?=
 =?utf-8?B?dnpvMzB2OGQrZ3NYQitzM2NqR1EwSnBLSzZ2ZUhYbVVZelE2aFlEMU5uR2d6?=
 =?utf-8?B?QUhRa3JUZDJlNDVvMXM3T3BUYWxBNWovaFJtc0hiRzZUOThvVmdyUHZHRGho?=
 =?utf-8?B?eDQzdzRNWjdudU1jcUVydVVZMWZFL0dFVXloMTVWVWdnRG9zVFVsVzVCcUVZ?=
 =?utf-8?B?T2lXOWlyamZKOUdmTnFpZEtQdklSYWhrTXI4OTdWWldJbFNvMzJnU1pXUGZO?=
 =?utf-8?B?N2RuNWlMYW1ua2lMdzJDOG41cEs4dFdZTkdxbXRrMGI2ZEx6alZIR24wTEZi?=
 =?utf-8?B?SW5Sb2tCeW1kWTh1NmJQRHczY2ZvQTFiczJDcEZsd05Pejd5RGdieVpyb1JW?=
 =?utf-8?B?YTl1M1dzY1ljRjJaazZlZHlmakZUMHB2STZwaTJJNGI5dWRDcUJEWHp6UkFT?=
 =?utf-8?B?K2w5QXIzYkw5UTlIUmxkNkg1eURnUG43ZE01TWEwU21BOTFXMjAzZTdBNFor?=
 =?utf-8?B?MDVCb01FbktmMU43Q0Q0dEpQSTVUeURzWG5FaFlmLytrUU5WMWR2MWcybkRJ?=
 =?utf-8?B?TjEwclFqVVdvdDFVYnh0MU1DRmk2eFhyaXJmY2pxTEFxQ2xnV3J4SUxlMFJp?=
 =?utf-8?B?cW03R3MxdmNVTG5tbFI0L1VkdTl6TUl2L3c4ZFRSWi9VNW9xWFVraUJSU3dp?=
 =?utf-8?B?SzlvZmtSRzI1dFNhZWhEWVZVcHVXckdZK2ZWLzJOMHlONXo5c0UyckgwbEIy?=
 =?utf-8?B?cmtYUWd2bWFwbzNPcS9odVZTR3dMenF3WTVmbDRYT2hqUmUwOEpFNWdpclQ1?=
 =?utf-8?B?dEU0N2puZzBKMFVpWE5tWHRVbHA5V2xkM0RpMjFwV3lmZVZlOEo2SUJqckZ6?=
 =?utf-8?B?bDV6cUJ1RExFdldETVlrVk50Vmdaak5GMGJodVhKUnNoMndxUTF1UWh2WC9i?=
 =?utf-8?B?UTNxRm5zeTZQbXVwT1cxS0hnOE1mQXRtakRtdW16Q2ZuckxuTXdidS9MVmpF?=
 =?utf-8?B?OTQzc2FIeUVqZTd2a0VnZGlERWJONFJieGtVY2JLOVlSMU9MS2lGNGZjQkdN?=
 =?utf-8?B?WW8wMFEwL2RDbXFVelFoM0RYQUlJTnlkVmo2ZzIzTTVvampIOWZqOXFrQWZq?=
 =?utf-8?B?aDlENW92WlJVQ1BvRjF3REN4bWo0SERYcGhscHRockFMdC9VMkFvVkdFV1cx?=
 =?utf-8?B?SHFCaW1yUTRoVTdoT0w0TEV5aTVsRkMwS254d0VqbjRQaVNTckIxRmF4Rm5N?=
 =?utf-8?B?dkgyMHorU0Z0MkxRYmFhV3pReDBOKzFoeFZ0WkM3STgzQXZnblp2ZjBlOGpB?=
 =?utf-8?B?TXQ3dStFNVI0NVBpdlFreGpmYzh0dGZLTDlaZjVOY2grVm9Rb21tR2RsUURP?=
 =?utf-8?B?Q3lBSlI4azZrRVRLQ0w1dFQ5anIwR2ZIVG91QVVkMDNwbEx3dm1nOTZsVHZ5?=
 =?utf-8?B?L2tqUTd2US9BT2xSNzRYYUNseHpneFM4VEdVSXFKZXJUUE13Z3czUGNWL28x?=
 =?utf-8?B?c1daYUVqeWttR2VRcFR3anZuTm16eTBJdUxCOTV2Q1NKRHkrZTNBNmorRU41?=
 =?utf-8?B?Vko1ckdyc2R2UVpCbEtGaFphNiszUHJDb001LzMyZnlnU2JPa1BaODNtZHk3?=
 =?utf-8?B?Z0dtcEhISUFFbUd5d1dmcTFnSEI0bEdvejlUN3dib3FpM1g3bG1hZ1NnRm1t?=
 =?utf-8?Q?ywxV1H5VRvci0pvo/fmGxI7qG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d246abb-280d-43fd-1858-08de01b81275
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 13:32:02.8207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ta8HU6xkmwDWIJm+FzLEUpKGHv8Uir7StJx5u3Et854xlFe9AIAksufuN2SWmpOOpqqiMOe8NTFg0/n92sfsZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491

DQoNCj4gT24gT2N0IDEsIDIwMjUsIGF0IDExOjAz4oCvUE0sIEFsZXhhbmRyZSBDb3VyYm90IDxh
Y291cmJvdEBudmlkaWEuY29tPiB3cm90ZToNCj4gDQo+IO+7v09uIFRodSBPY3QgMiwgMjAyNSBh
dCA3OjA3IEFNIEpTVCwgSm9lbCBGZXJuYW5kZXMgd3JvdGU6DQo+PiBIaSBBbGV4LA0KPj4gDQo+
PiBOaWNlIQ0KPj4gDQo+Pj4gT24gMTAvMS8yMDI1IDExOjAzIEFNLCBBbGV4YW5kcmUgQ291cmJv
dCB3cm90ZToNCj4+PiBGb3IgY29udmVuaWVuY2UsIHRoaXMgUG9DIGlzIGJhc2VkIG9uIGRybS1y
dXN0LW5leHQuIElmIHdlIGRlY2lkZSB0bw0KPj4+IHByb2NlZWQgd2l0aCBpdCwgd2Ugd291bGQg
ZG8gaXQgYWZ0ZXIgdGhlIHBhdGNoc2V0IGV4dHJhY3RpbmcgYW5kIG1vdmluZw0KPj4+IHRoZSBi
aXRmaWVsZCBsb2dpYyBbM10gbGFuZHMsIGFzIHRoZSB0d28gd291bGQgY29uZmxpY3QgaGVhdmls
eS4NCj4+IA0KPj4gSSB3b3VsZCBzdHJvbmdseSBwcmVmZXIgdGhpcyBhcyB3ZWxsLCB0byBhdm9p
ZCBjb25mbGljdHMuIE9uIGluaXRpYWwgbG9vaywgdGhpcw0KPj4gc2VlbXMgdG8gYmUgaW4gdGhl
IHJpZ2h0IGRpcmVjdGlvbiBhbmQgc29sdmVzIHRoZSBwYWluIHBvaW50cyB3ZSB3ZXJlIHNlZWlu
Zy4NCj4+IA0KPj4gLSAgICAgICAgICAgIC5zZXRfc2VjKGlmIHNlYyB7IDEgfSBlbHNlIHsgMCB9
KTsNCj4+ICsgICAgICAgICAgICAuc2V0X3NlY19ib3VuZGVkKEJvdW5kZWRJbnQ6Om5ldyhpZiBz
ZWMgeyAxIH0gZWxzZSB7IDAgfSkpOw0KPj4gDQo+PiBIZXJlLCBJIHdvdWxkIHByZWZlciBpZiB3
ZSBkaWQgbm90IGFkZCBfYm91bmRlZCwgc2luY2UgdGhlIGlkZWEgaXMgdG8gc29sdmUgdGhlDQo+
PiBwcm9ibGVtcyBpbiB0aGUgbWFjcm8ncyBzZXR0ZXJzIGl0c2VsZiAobWFrZSBpdCBpbmZhbGxp
YmxlLCBub3QgcGFuaWNraW5nIGV0YykuDQo+PiBTbyB3ZSBjYW4ganVzdCBtb2RpZnkgdGhvc2U/
DQo+IA0KPiBPaCBhYnNvbHV0ZWx5LCB0aGUgYW5kIGdvYWwgaXMgdG8gcmVwbGFjZSB0aGUgZXhp
c3RpbmcgYWNjZXNzb3JzLiBGb3INCj4gdGhpcyBSRkMgSSB3ZW50IHRoZSBsYXp5IHdheSBhbmQg
YWRkZWQgbmV3IG9uZXMsIG90aGVyd2lzZSBJIHdvdWxkIGhhdmUNCj4gaGFkIHRvIHVwZGF0ZSBt
b3JlIGNhbGwgc2l0ZXMgaW4gbm92YS1jb3JlLg0KDQpBY2suDQoNCj4gDQo+PiANCj4+IEFsc28s
IEJvdW5kZWRJbnQgc291bmRzIGxpa2UgYSBnb29kIG5hbWUgdG8gbWUgSU1PLg0KPj4gDQo+PiBB
bHNvLCBzaW5jZSBUcnlGcm9tIHRyYWl0IGlzIGltcGxlbWVudGVkIGluIHRoZSBmaXJzdCBwYXRj
aCwgdGhlbiBpbiBub3ZhIHdlIGNhbg0KPj4ganVzdCBkbyB0aGUgZm9sbG93aW5nPw0KPj4gIC5z
ZXRfZm9vKHZhbHVlLnRyeV9pbnRvKCk/KTsNCj4gDQo+IFllcyEgVGhhdCBkb2VzIHdvcmsgaW5k
ZWVkIGFuZCBpcyBtb3JlIGNvbmNpc2UuIEFuZCB3ZSBjYW4gYWxzbyBtYWtlDQo+IHRoaW5ncyBs
ZXNzIHZlcmJvc2Ugb24gdGhlIGNhbGxlciBzaWRlIGJ5IGFkZGluZyBhIG5ldyBnZW5lcmljIHNl
dHRlciBpbg0KPiB0aGUgZm9ybSBvZjoNCj4gDQo+ICAgIGZuIHRyeV9zZXRfZmllbGQ8VDogVHJ5
SW50bzxCb3VuZGVkSW50PC4uPj4oc2VsZiwgdmFsdWU6VCkgLT4gUmVzdWx0DQo+IA0KPiBUaGlz
IHNldHRlciBjb3VsZCB0cnkgdG8gcGVyZm9ybSB0aGUgY29udmVyc2lvbiBpdHNlbGYgYW5kIHJl
dHVybiBhbg0KPiBlcnJvciBhcyBuZWVkZWQsIGFuZCB0aGUgY2FsbGVyIHdvdWxkIGp1c3QgbmVl
ZCB0byBjYWxsIGUuZy4NCj4gDQo+ICAgIC50cnlfc2V0X2Zvbyh2YWx1ZSk/Ow0KPiANCj4gaW5z
dGVhZCBvZiBidWlsZGluZyB0aGUgQm91bmRlZEludCB0aGVtc2VsdmVzLg0KDQpBY2ssIHRoaXMg
d291bGQgYmUgYSBncmVhdCBhZGRpdGlvbiB0b28sIHdlIHNob3VsZCBkbyBpdCBJTU8uDQoNClRo
YW5rcyENCg0KLSBKb2VsDQoNCg0KDQo+IA0KPiBUaGVyZSBhcmUgYWxzbyBtYW55IG90aGVyIGlt
cHJvdmVtZW50cyB0aGF0IGNhbiBiZSBkb25lLCBsaWtlIGhhdmluZw0KPiBmaWVsZHMgd2l0aCBh
IHJvdW5kIG51bWJlciBvZiBiaXRzIGJlIHJlcHJlc2VudGVkIGJ5IHRoZSByZWxldmFudA0KPiBw
cmltaXRpdmUgZGlyZWN0bHkgaW5zdGVhZCBvZiBhIEJvdW5kZWRJbnQsIGJ1dCB0aGF0IHdpbGwg
cmVxdWlyZXMgc29tZQ0KPiBtb3JlIG1hY3JvIG1hZ2ljLg0KPiANCg==

