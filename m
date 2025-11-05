Return-Path: <linux-kernel+bounces-885686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BFFC33AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 02:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9CA04F0974
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 01:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5541E23507C;
	Wed,  5 Nov 2025 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="TJ90wofi"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012054.outbound.protection.outlook.com [40.93.195.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6419B22127A;
	Wed,  5 Nov 2025 01:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762306812; cv=fail; b=p6GBre2E9YRMlCvJS4k31WsmwvB9kE5Az7QdKE9IvY2b9IdDQCCMiP7ziUBIJKftltR+tjvQDdqjFfYI0J5rLsHZpoYcjydcsGIB/N+o2oSyB+itPh0L2IYmB7rANpQjeWrqb4xkCxcG1a5rYtEYMQm3tauB48T98qNj3mznMGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762306812; c=relaxed/simple;
	bh=H8gWkTm0t7OI6EOJspJ9fr4lnJSp7pmpCiUA/RUSj0U=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gze5DjPZQiViAUEsLHlC+CKQfeQxwoX708zHGbk7xgbJ+oVEBgOnPwmHelqUVHclC/5OgtdP2Ji0zOp5LvwToSDvyfmdMts2off+Io3H2mHdsl4R4+40f8UYteRzd0PzotDXNgdO50I7iFttStwElwePJ0YVZ/N5YIn+h9M+GMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=TJ90wofi; arc=fail smtp.client-ip=40.93.195.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILVovkBeK6NH0fEuYFYlLUW0JsKsYjS0Ey+/tdheaE+lwOmHgmNk9w+ItiMrF/niLSZFokh+PgpgFuukEHHyOY2+B14mH9rKHXtCiT8RlxShKS3iL2ZhPVigxJiPB1CVgYHa6Igyz3ocGtQvHYc6E1wq23i3ppzff2V8RoALQKMGPL1Unzucgc+Qz6P0bf94ELAYAntFHZMAjQ6i9ctap33lUYz41m4e81DrrHgk1ebF4ivayyYQC590ByMzWSnJtqxox9tQfeFA2F+5bTjWuWt8bccXj1tgFs69N7WK4RvTd+WgBio+FnaIMk0zBqBelzftcEBPS9BzK+gJsieN4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8gWkTm0t7OI6EOJspJ9fr4lnJSp7pmpCiUA/RUSj0U=;
 b=g4OEhyL095oCeyIvDunWqW7YnyPD+NnAFeMTNn9afurAClDFI8ofVRtk94BwC9/U2LAwSEfj1VMWNdfDFVsIcrWJBh9LjFpl9W+K0uouoyYcnNQh4kHDt42EmywL5glosmMNBCzhiXhn+9tCq4KX3r02603OgfIFp/3BbRbNHbmPIchjg8shyPzgCOqepAvoq/vZmOQjAzec4mcS0mT3Uw0wWWjtVGsQk9wxESgUJRXuJdgef5bBMrKwlu0ka9+10h/TI4tq91FuWzRPObi51xqtz+pAc8pZurwagYzeIJdJhwi3RSRSCnRHeqBiS2BbajCd+0BvaGA2ITgNppWHbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8gWkTm0t7OI6EOJspJ9fr4lnJSp7pmpCiUA/RUSj0U=;
 b=TJ90wofihOFIoexb/OKY700ecacUG65lEFL+l3usSFKUd6EeYlSjd9z5ly0Jf/dBv5F4+TW6AaItbw+frGsodWlaTUjjv1TgjQAWCGoyrWC5+rCLO8Ed4MJgtjPtCL1aXfojASQaZMJZoVK3+wn4lqloiyjAWcHCIqS3tnz3foUo5G+70rDArkZsrfATEL72oSST3HMwlZRhkyOPOQhz+tWo/T0b3lCNw5DNPC/AIX+Q/hpAzKticNe7xhZWqfmDGHtXWZp9OfmtFX0n5dK3HYoqsBvzUfObxSpZeT4FfPY1khIeMus/2myL7ia31La/uqmtpZFSMDTZXbSJdy3cVQ==
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SA0PR03MB5449.namprd03.prod.outlook.com (2603:10b6:806:bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 01:40:06 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Wed, 5 Nov 2025
 01:40:06 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"Rao, Mahesh" <mahesh.rao@altera.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "Ng, Adrian Ho Yin"
	<adrian.ho.yin.ng@altera.com>, "Rabara, Niravkumar Laxmidas"
	<nirav.rabara@altera.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: firmware: svc: Add IOMMU support for
 Agilex5
Thread-Topic: [PATCH v3 1/2] dt-bindings: firmware: svc: Add IOMMU support for
 Agilex5
Thread-Index: AQHcTRsfYhpQdyjrIUmvh9KarfOPLbTjUAAA
Date: Wed, 5 Nov 2025 01:40:06 +0000
Message-ID: <d64add31-5d4d-4dc3-aa09-5deb8e7b6cba@altera.com>
References: <cover.1762135710.git.khairul.anuar.romli@altera.com>
 <ca75b88a64412274d415e17d4aef6dd018ac7167.1762135710.git.khairul.anuar.romli@altera.com>
In-Reply-To:
 <ca75b88a64412274d415e17d4aef6dd018ac7167.1762135710.git.khairul.anuar.romli@altera.com>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB4927:EE_|SA0PR03MB5449:EE_
x-ms-office365-filtering-correlation-id: 09ca3c9c-6ccc-4da4-1c64-08de1c0c3f91
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?elFEVzJnN29sd2xPZ3dvRGd1NDhkNE54RUxCcWtRUmFMZE9Ed0UvNFo3RkFW?=
 =?utf-8?B?aHUyM0xBRUJNOHVXM0prY1pRcnpKTlBHRXlYTlNkT1pqRXdtakIxZlpRRXBJ?=
 =?utf-8?B?S2ZJVEhuUVhseGpRS1RkRU5KZGxzV2tGWWtGUzJVaW83WGtRVkk3OElkaHZ2?=
 =?utf-8?B?WTNkU2JDM2paSS9OSm1GNzUvZ1hsWldRU1dZMmtuYW04d01KYVJ1dGNadno4?=
 =?utf-8?B?eWZXdExQMEhYQjNZK1RsVjdyVVRCbXFGc05lOEJGb3RET3BMS3dlWU1CdU5L?=
 =?utf-8?B?SWNORDlpRDRTYSt4R2lDc2lycFQzVTRlMkRlLzYzYlk1dWxaeU5FZjJPS1lv?=
 =?utf-8?B?dUc5K2FNUzcveUFKQjF2RDJGUElCdlg1V1dhVEFHd1RYWDg1L0QyTC9Scm8z?=
 =?utf-8?B?QkNLTDJYM0dNcmdtOElrM3pIdFlvTnlHelk3emFhelpZSi9HdGZ2c2NnN1lz?=
 =?utf-8?B?Wkc3T01mbVI5akR6UnlNY1loSEVORWVlZk5MRCtIZStXR2hmTWxERUx0czl0?=
 =?utf-8?B?dlJaV2FvSmh1WUQ1bnFjZ3k3MnJNbmRmdUNSc2dNdzRxUVp6Slk2K1VrMllU?=
 =?utf-8?B?eW0rM0dia2JTUlBlTjdmOUNSWW9qTmpBZHJFM3lwVE1FR1ZqeGhIM0cyNHNi?=
 =?utf-8?B?RlJwbjJmUndrdFQ3end1ZDFjV1Z5bXFlTlp4M0Y5MnR4cG1wcUdBOXoxUkNV?=
 =?utf-8?B?c2JHeDFyWE8vZmhMNk1BdkVuR09UYkNzbytIc00yOGVUZVRVUFdrcmNOZ3Rw?=
 =?utf-8?B?ZFBZZ0w5a2piZjJ0Z3dlcW1uMCs1bTV6WG42a2czQ0kxY21MQ0UyTlRyNnQ2?=
 =?utf-8?B?aVJmeTJyY2NpN2FSSlNiTGNFS3hYWDdGb20wVzk5dkVld3NleURvWFdaR1F1?=
 =?utf-8?B?UGRuTjROZU84VmVtZTBPMDhlMXRKVmlPUWJEcFhXMnVwUGhzejc4YU5obXdG?=
 =?utf-8?B?LythL0VrbWgwS2JMZkttWDY5eGJFek5oU3Q2YXJ3SC9BSlZjRktDNGxrbExJ?=
 =?utf-8?B?dlYzMU8xZ0hwWjE4d3c0dDd1TEFyL1VFaks2RjhUSDNteXp1NGhZQ1VhbnhL?=
 =?utf-8?B?dDQweEI2V2ZYSmc4ajNPSXJsUzdvUDRXWjZBLzFOVGNZOXMxc2VOSkNwOHQ0?=
 =?utf-8?B?eUtTVnMyTkQ1YVpyVmJQZ3ZZUWZMdWVwa2NDdW5RNTFXSjYrMU1PbGJ0N1J0?=
 =?utf-8?B?WW0zamh0ZTN6SmpUcmhCcmZINVZGNzAxT0toM3NkVVNOcTZaZGtoUnVBSHJE?=
 =?utf-8?B?ZEMvaEdXd1NCZFdvajJ1RGJuSU8wT1NkWERYS2ltYkdSVkJ6QXQyMW9tMCty?=
 =?utf-8?B?Z3NUVmVrWnJud1RaYVlHVFFuYzRLK3JuWkczL1VqUlhxY3l4NVhXQkNUOVlR?=
 =?utf-8?B?Z2gwb1N2eDM0cTR1WTV4d1g2eXBBeHhIYWY3VEVXZmhjcDBETXljZjFDSHIz?=
 =?utf-8?B?OVVXM2c4bUw5KzErb3d0TnUvRDUvVHVJc2w1bWJ3eng5UytBcCtmUTN6cTFN?=
 =?utf-8?B?cm1BNk9takFraEVzREE3cTZlUDdPZTk4SXBnbklidWRvaVgzcDA3SklBMnVG?=
 =?utf-8?B?LzZnTDkwcnF4VjFyUkUxZURRbVRwQzc2VENKYy9tSUdZNmRWQ0pmdGNJMjNt?=
 =?utf-8?B?VlMzNy9zbDNkQmI5T1IxMDZHR05aNnFVakVPTE1KYyswRDkydWlNYklnbzky?=
 =?utf-8?B?c1krSDZIak5UNXNmQzExdEVQZlFFbU45WHR3QnVRV25YSE4xOVE4NUNqeDlu?=
 =?utf-8?B?NDZQWmhRVk9aQVlWczQwOXgrT0IvbERTWnJVUCs3TlBOYmlEbXJCa0VmSVdO?=
 =?utf-8?B?WFBLcHMyYld4bkhRRHJKejAyZlVTa2U0aWJFaFJCTHhUc3A4a0tuU0hxbjBq?=
 =?utf-8?B?RC84eU9Pdm5OQmtBRllsSWg0NHQwcDc5L292bzRxOXo1bUR1TkVBbVRpV044?=
 =?utf-8?B?OUV0QTEvVE4xTHIrclpoNkljWnlJeGFWOHdDcGdqU2g3a0VTMHFESnRGMmkx?=
 =?utf-8?B?RmROYmhObG9jeVdGT3VYL2NWMXFtd0VpYUN3Zm93TFo4VEdHRHV3MkI0ZzJ1?=
 =?utf-8?B?Y1dNUG5QY1k4dWh2aWdpaHpsbWowNGh5blVxUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bDBtdFBFTXR3Q1JQb3Nac3hrRkpOUGhjV2s3WTFJckpaTU1FNVBsOWJHWmVK?=
 =?utf-8?B?RGo5NENvK0gyWHEzZUxPVXlOckxyZVE2MnFRM0JSTkJOVFhQN041R1AwSGZm?=
 =?utf-8?B?c2NNb0kvbG8xa0dabk5ldlhnZ3lVYUhMWUJId3l0NjU2cnFNSlVTNGNFMVBB?=
 =?utf-8?B?cHN5ZzBlMjdsSHBKZTh1VjFMVUxjVEw2TjZvQlZhaXlITW1ydXNVQ3RNcDBW?=
 =?utf-8?B?WmxqR21kZ0dTZjFUU3hHempuWlVRMmNnOHdid1doSE1lYVVkS0RKaWtkREpi?=
 =?utf-8?B?ZzBFMUdyR3JyUXBUQ3E0MDVtR0xlT01jM2FpUTV0YXNaUXlDQU13VGZVR3J5?=
 =?utf-8?B?Tms4bDREK01sV1VTRndYeUNNR2xOWWQrVWhWeVdMaitFTlMrS0FLSG56QXhZ?=
 =?utf-8?B?a0hyYUxNYVdkTDFlOVJ4Mmt1RHV5bDVVMXEzZ0pGSWRvakZKckpzc0JHOFY3?=
 =?utf-8?B?bWhHYUJ6aVBFa1diK3l6SmoxYTE5Yk02TGtXYlV1cUYyUnF1T2xYTTUvNm9y?=
 =?utf-8?B?dDJ5OVIrczMxc3ZSVzNJL29Qckc0OHRiOTdybjd5VGc0UDQrMnJGSGlsenls?=
 =?utf-8?B?cVM1bUVwbWpOWEZQQklxZWJ0VmI1NDFoYklta2ttV0RlKzYzWkRSRU1vdWFk?=
 =?utf-8?B?WG5TdW5VYU1qTnB2dGxqVjVhajJaTndTU09NVEhYTDEzWDMxV0pGOEJmNVpE?=
 =?utf-8?B?eWttSDVOSkpXOWJob0JhcUdBaGFaZ2tiTVpCREFsM0M4Wmw0TUNjY0N1TTdK?=
 =?utf-8?B?T21pWWdvaHpTUmY0RUtqUkpLNzZUaWpmY2tWUmNQaUkwYkFtNG9PYjhpSnVl?=
 =?utf-8?B?VmNCTjRVeFVRbGtsVVplY242SlJXcTNUTlJEYm5aZ3BYc0YvRWZkakVpOUxh?=
 =?utf-8?B?VURFV3BaY21TOHlqekRpaEtXTkc0TW9Xbm0xMzh6Mko0eVJLeUhVRVR0WjZD?=
 =?utf-8?B?N1RWOUNvWGhmTU5iTFU5NFo5dVpEcEpDRkY4eGF5MFhYb0JaWjdTc0daZWJy?=
 =?utf-8?B?Zll6bFB2Z2RWTENnT0RNZnBtdnEwQWpRaVNrTTVwWHdLVXV1OXNlc2ZtWkJ3?=
 =?utf-8?B?bWZuMXBpU25rVHA1M053VnNEZUpOMDMwMlhQMzBJN21qNDM0SGp2U2JoZW5D?=
 =?utf-8?B?SVBzWkEyK0pvZHMyZDBrVXV1cFF0UklnUUd0NU9DYW50MUozWjlwRTdpNm8z?=
 =?utf-8?B?K1lMMVBiclFVN3NjbzE2SHVYdkNGQ1NSWjhYVnk5VTBRWVRuc2dEVXg5OTZF?=
 =?utf-8?B?a0UvTnZYc3ZkM3VSYTg3TitkYW12ek1ja2NTcVF6Rjd1MjBOSGVFWUtncjdJ?=
 =?utf-8?B?L0dKVXFGNXNBL0kzQnZQNVlQT0crV1h2MmFoQ1lRM0h4djIybDJ0ZmFjaEdu?=
 =?utf-8?B?cjB4bFcvM0tZeFU0V3JXL0R2L3F4V0EvS28vMjhCS08vejlocG9ORzdLSTVz?=
 =?utf-8?B?akpCdEtvZ1JZMGZuUHNoNGZlRDI0QnU2dWc3OGZtU2JTTTBoVjdKVFljaE5n?=
 =?utf-8?B?aU1KV1Q5aGFFdFFZbythM2hIL3NBUk5iMzQrRDZhYXFoVjZ0L3NrY3lrMTI1?=
 =?utf-8?B?MEVZbzlFV2Q1dU9WZHhvMTJTZUl2cXVzQmFINlVtaXZIWmdraG1JOTFNdk9N?=
 =?utf-8?B?L2xCS3pnYjF2eWtXSUlIZExodTNlbWY2RFJjRElWZURHSFdWbW1RVDJQUVVD?=
 =?utf-8?B?dWNhbjZESkRKNDhoSjBpWEdCejNOOGhxd1BTM2dxbHRKQ2JiVFhVZmtCYlJS?=
 =?utf-8?B?QW15VEthUjkxb28wOHAzbnhadmZQQVYzYXgyd2ZYODVFdnQydSttUkptbEVi?=
 =?utf-8?B?clRzWU9JWW1VZUVIdWhaUTUzS01POVEwSEtuTkl3WEQ5ZE55TmdRSVB0VTVM?=
 =?utf-8?B?b2FIRFpyVE5Dd0N0eERDYjNzcWhJV2Z4dTkya0xaY2VNNzFvMHA0YU1keUYx?=
 =?utf-8?B?U1RSZlhsYnM4L3VjYk1wTXZvSzZVa2FZL2FZZEh6WWh4djZNUnhibFdWZyta?=
 =?utf-8?B?Z3RjRUhKUTRReEtFZ21wa2F1QlZhaEJkdmtBdmptckMrd0pjTDdzcUNUUk5G?=
 =?utf-8?B?T0ZUQks2UTB4aGpXcnFaeEUrM1ZDVXBCU2N0U2FUMzIreWJVNG93RndMbVdo?=
 =?utf-8?B?dHNwbVo0NTJ1Q1FnaWloS3M3WSt0VjVBSHQ3d1pJUEd1QUtTeDBURTBkNEgr?=
 =?utf-8?Q?LSgq1S+k23U2V7Arzo8lYWM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <609CA33076BEE94DAABEB60261400D5D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ca3c9c-6ccc-4da4-1c64-08de1c0c3f91
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 01:40:06.4616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pl9O4Re0HBPlBX64pUlnX9vt7pHPVj/xQxk5tchpzofCCPiJnQT2vZjzNxalOLgofNbu2D/2dT7GNy4yQC5pGD++wt2oRjoSMjsP5zGSGdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5449

T24gNC8xMS8yMDI1IDc6MzkgYW0sIFJvbWxpLCBLaGFpcnVsIEFudWFyIHdyb3RlOg0KPiBJbiBB
Z2lsZXg1LCB0aGUgVEJVIChUcmFuc2xhdGlvbiBCdWZmZXIgVW5pdCkgY2FuIG5vdyBvcGVyYXRl
IGluIG5vbi1zZWN1cmUNCj4gbW9kZSwgZW5hYmxpbmcgTGludXggdG8gdXRpbGl6ZSBpdCB0aHJv
dWdoIHRoZSBJT01NVSBmcmFtZXdvcmsuIFRoaXMgYWxsb3dzDQo+IGltcHJvdmVkIG1lbW9yeSBt
YW5hZ2VtZW50IGNhcGFiaWxpdGllcyBpbiBub24tc2VjdXJlIGVudmlyb25tZW50cy4gV2l0aA0K
PiBBZ2lsZXg1IGxpZnRpbmcgdGhpcyByZXN0cmljdGlvbiwgd2UgYXJlIG5vdyBleHRlbmRpbmcg
dGhlIGRldmljZSB0cmVlDQo+IGJpbmRpbmdzIHRvIHN1cHBvcnQgSU9NTVUgZm9yIHRoZSBBZ2ls
ZXg1IFNWQy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtoYWlydWwgQW51YXIgUm9tbGkgPGtoYWly
dWwuYW51YXIucm9tbGlAYWx0ZXJhLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFkcmlhbiBOZyBIbyBZ
aW4gPGFkcmlhbmhveWluLm5nQGFsdGVyYS5jb20+DQo+IFJldmlld2VkLWJ5OiBOaXJhdmt1bWFy
IEwgUmFiYXJhIDxuaXJhdmt1bWFybGF4bWlkYXMucmFiYXJhQGFsdGVyYS5jb20+DQo+IC0tLQ0K
PiBDaGFuZ2VzIGluIHYzOg0KPiAJLSBBZGQgaW9tbXUgcHJvcGVydHkuDQo+IAktIEFkZCBsb2dp
Y2FsIGNoZWNrIHdoZXJlIG9ubHkgQWdpbGV4NSByZXF1aXJlZCBpb21tdXMNCj4gCS0gUmV3cml0
ZSB0aGUgY29tbWl0IG1lc3NhZ2UgdG8gZXhwbGFpbiB3aHkgdGhpcyBjaGFuZ2VzIGlzDQo+IAkg
IG5lZWRlZC4NCj4gQ2hhbmdlcyBpbiB2MjoNCj4gCS0gUmVwcmFzZSBjb21taXQgbWVzc2FnZSB0
byBleGNsdWRlIGlvbW11DQo+IC0tLQ0KPiAgIC4uLi9maXJtd2FyZS9pbnRlbCxzdHJhdGl4MTAt
c3ZjLnlhbWwgICAgICAgICB8IDIwICsrKysrKysrKysrKysrKy0tLS0NCj4gICAxIGZpbGUgY2hh
bmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZmlybXdhcmUvaW50ZWwsc3RyYXRp
eDEwLXN2Yy55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Zpcm13YXJl
L2ludGVsLHN0cmF0aXgxMC1zdmMueWFtbA0KPiBpbmRleCBmYWMxZTk1NTg1MmUuLjA5NDk3MzQ5
NDA5OCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Zp
cm13YXJlL2ludGVsLHN0cmF0aXgxMC1zdmMueWFtbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvZmlybXdhcmUvaW50ZWwsc3RyYXRpeDEwLXN2Yy55YW1sDQo+IEBA
IC0zNCw2ICszNCw3IEBAIHByb3BlcnRpZXM6DQo+ICAgICAgIGVudW06DQo+ICAgICAgICAgLSBp
bnRlbCxzdHJhdGl4MTAtc3ZjDQo+ICAgICAgICAgLSBpbnRlbCxhZ2lsZXgtc3ZjDQo+ICsgICAg
ICAtIGludGVsLGFnaWxleDUtc3ZjDQo+ICAgDQo+ICAgICBtZXRob2Q6DQo+ICAgICAgIGRlc2Ny
aXB0aW9uOiB8DQo+IEBAIC01NCwxNCArNTUsMjUgQEAgcHJvcGVydGllczoNCj4gICAgICAgICBy
ZXNlcnZlZCBtZW1vcnkgcmVnaW9uIGZvciB0aGUgc2VydmljZSBsYXllciBkcml2ZXIgdG8NCj4g
ICAgICAgICBjb21tdW5pY2F0ZSB3aXRoIHRoZSBzZWN1cmUgZGV2aWNlIG1hbmFnZXIuDQo+ICAg
DQo+ICsgIGlvbW11czoNCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+ICAgICBmcGdhLW1ncjoN
Cj4gICAgICAgJHJlZjogL3NjaGVtYXMvZnBnYS9pbnRlbCxzdHJhdGl4MTAtc29jLWZwZ2EtbWdy
LnlhbWwNCj4gICAgICAgZGVzY3JpcHRpb246IE9wdGlvbmFsIGNoaWxkIG5vZGUgZm9yIGZwZ2Eg
bWFuYWdlciB0byBwZXJmb3JtIGZhYnJpYyBjb25maWd1cmF0aW9uLg0KPiAgIA0KPiAtcmVxdWly
ZWQ6DQo+IC0gIC0gY29tcGF0aWJsZQ0KPiAtICAtIG1ldGhvZA0KPiAtICAtIG1lbW9yeS1yZWdp
b24NCj4gK2FsbE9mOg0KPiArICAtIHJlcXVpcmVkOg0KPiArICAgICAgLSBjb21wYXRpYmxlDQo+
ICsgICAgICAtIG1ldGhvZA0KPiArICAgICAgLSBtZW1vcnktcmVnaW9uDQo+ICsgIC0gaWY6DQo+
ICsgICAgICBwcm9wZXJ0aWVzOg0KPiArICAgICAgICBjb21wYXRpYmxlOg0KPiArICAgICAgICAg
IGNvbnN0OiBpbnRlbCxhZ2lsZXg1LXN2Yw0KDQpJIGFtIHNlbmRpbmcgdGhlIG5leHQgcmV2aXNp
b24gdG8gdXNlIGNvbnRhaW5zOiBlbnVtOiBpbnN0ZWFkIG9mIGNvbnN0Lg0KPiArICAgIHRoZW46
DQo+ICsgICAgICByZXF1aXJlZDoNCj4gKyAgICAgICAgLSBpb21tdXMNCj4gICANCj4gICBhZGRp
dGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gICANCg0K

