Return-Path: <linux-kernel+bounces-722920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E906CAFE0AD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECFAE1C27342
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A5526CE21;
	Wed,  9 Jul 2025 07:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="GMfVMMSq"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44D5625;
	Wed,  9 Jul 2025 07:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752044434; cv=fail; b=ETFoGwQx4RVzVVCiw5guqCT9eUcRML8jAYDXr4PKmve8t7a/YpNXkLtvyVIWgDvVFEpef1XvMDRQN7TpGZpwv3OYZc+zgR83zV+GyLDA40lxSPNgdCViQNoypFPqAzY240frlZTwKP/5WSpw//6Z6Br3ZGaqrfv8AQnyWLaUX9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752044434; c=relaxed/simple;
	bh=P5ul4UwbEzOK9HDWJDyKA1vP10CxpTSLPq4vN0hKD1Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Amfz7IU5/E1P//jwjZhpQM+r2HHsB+l24qSzOMns2ewhk8Q5Cljn4SaV29W/1Hzv4qJ8+6quN4UbzVE4sguU06WEL0PCQF5PGsWvB7piJVDH/QQoLE8PM12MWotCuDZZzHpBPhe6emPGAPO+bxzbs5Rdce4KCAlbceAJwkdbo+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=GMfVMMSq; arc=fail smtp.client-ip=40.107.212.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4Dwa5SKMr+Gch7Ohn68U94KeCc7Mr1W9xZtv7cHEBRGg4sStuOlsS4acTDxumleRylKdqJdvuribuX3+XZZ/WFQftXmXv53Ep0onv8SDMjDVG/E2cc+EkOgT7sN2BVUXMi0eyTDlnfoCNfWg6+5lfXenLAE8iK2RzRiIR3p64Ju/wTCTNUrKjZZru3CE+pXjuX391oyn8o5Cxzc4x3gEdaciamQMEbE4SMupaq1u04A6o8R32QQ8OaXCetBnfa/itzbJQ2CMUdc/YzJevAkRKMCf0+MP0fPK+AWKFzqY+GeOxgZ7RJwZsyT9P0xPJ+qfQ5TmWzZWfevwIS+tT/KKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5ul4UwbEzOK9HDWJDyKA1vP10CxpTSLPq4vN0hKD1Y=;
 b=bXXUEt7mL2Ri+zndofaf/eoV1LiiIITC6pH3hLhWZ6pRhEqbQNH8tdRls9KoD8lZhzhbwkk992VgO8w3iQ9EChVLk3WI4trx9w442DGdhiIRpayeSEsAyCOl9trjHVOg6qOPjchHkwEZvIZoyrgBILunpH3r7vhAvNWWdXJcLD6QKK1ZqRoM0RoBkMcweniSiF8Y6M/6hVnjKriaTFFGTtfr4lvXWODadSaafXpPTD6u/W/Omt6C0P1tr66OuWXQbZsC4mPcQ9CpvTDe71h+DUygsEvCpESlCm76DrP1FG+cselzaBm4bSnEimWHIW6x1eknVpyqY2z12wMs4yt97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5ul4UwbEzOK9HDWJDyKA1vP10CxpTSLPq4vN0hKD1Y=;
 b=GMfVMMSq8W+BDZrfLe/t/6bmYeOPBd54lyeY+WWi5boB21QdN3Ww+qOMaoIR8ureFL9I5FXqOVLT3aMn7dhHvfWZ4o/Jbt3VogfdpjeZLRme2V4jiY+UxS40ssbZtJmu6apO00BZhNSCEkU5BYwxBFwBp+5txwaInDg1ISsscohLP428s1mnk4Mh2j+9ef/o7TEtl1fKAyW6jtGFozrhmXSJkP1glHdETsgCEthhTSuzhxBYq8XYBjlCckW5kdQo2p2Dj/7VjiVXWKUZkBccZgbaICA1upi8TUlFmkV0nHjfwQJRBx8ujKZjbPwsbFSiJUtrAFWFEz54gVKouAOVRQ==
Received: from BL1PR03MB6088.namprd03.prod.outlook.com (2603:10b6:208:311::22)
 by IA1PR03MB8090.namprd03.prod.outlook.com (2603:10b6:208:594::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 07:00:28 +0000
Received: from BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::21c8:ce4a:b199:fc9d]) by BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::21c8:ce4a:b199:fc9d%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 07:00:28 +0000
From: "Fong, Yan Kei" <yan.kei.fong@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
	"Gerlach, Matthew" <matthew.gerlach@altera.com>
Subject: RE: [PATCH 0/4] Add 4-bit SPI bus width on target devices
Thread-Topic: [PATCH 0/4] Add 4-bit SPI bus width on target devices
Thread-Index: AQHb5NSQkWHd9XFH0EahDy/LlCdlKbQSkjqAgBbhfrA=
Date: Wed, 9 Jul 2025 07:00:28 +0000
Message-ID:
 <BL1PR03MB6088383692B602E169494FB5AB49A@BL1PR03MB6088.namprd03.prod.outlook.com>
References: <cover.1750747163.git.yan.kei.fong@altera.com>
 <70e3a367-8d9d-477b-9858-9f2a7b97bbca@kernel.org>
In-Reply-To: <70e3a367-8d9d-477b-9858-9f2a7b97bbca@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR03MB6088:EE_|IA1PR03MB8090:EE_
x-ms-office365-filtering-correlation-id: 4ef2e38f-f251-41f6-417d-08ddbeb6498c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NFpuQzEyOENjZXJvZnRhYWI3ZzIxYU11d2tnSmNEZWtVK3dkV1B5VVFnS01B?=
 =?utf-8?B?L2lhbWVTZll0ZnFSZlczd2x1SU1WSjBFcVZ2S2YzTkZBRllSbEE5dndpUDFa?=
 =?utf-8?B?N1pYZFVndkpLRTBrazhTOC9TVTJUbDVXZ09wVUVGcWdBR1lmRDNJKzRXdDNz?=
 =?utf-8?B?a3YzVE5VM0hMTTBqLzN6RWlkRXVJbVJITHRDTmJib3d3VzUzMXlVV2pZS1Fj?=
 =?utf-8?B?M2xHTDBaZGxVT0wxUEIxK3BZamVlQ0x2eFZybTlYazRIeTl3K2pXeGQ0aDBa?=
 =?utf-8?B?R0dObkdaVmJPY1U4LzJtMkh6K0J5RTZYZ3NZSCtDS0E5U3BVb3ZybHU0UGMr?=
 =?utf-8?B?b096emRaM3lKTTl3SmVBMzArNFdWZW4raEpONUVFeGloUVhBUmxsamd5VHNG?=
 =?utf-8?B?ZVY4Q2JBc25PWm1pK1VzdmFtak9HelAzRVNKT0M4SUlxcHM3R0lTVG1HYi9Q?=
 =?utf-8?B?RVRBZjZ6aHB0N3REQyswTkR6d2tsWS96Y0NnQWZTOUljQ2FMUWg5L0dMNVY4?=
 =?utf-8?B?a3RPbmhDVHVteHlmNnFHOUl6Z2ovaTlicWFyYkVtRG5VRXlXYi9hSHluTm45?=
 =?utf-8?B?cmlvU2VVOW9uZ1IzTU5yWWRTT2wyaVE3YlUrQkN2Mklrc2h6NzFzQURHM3J4?=
 =?utf-8?B?MU1PR3RmdGJOcjdhVWMrNURIYnBCK1NweGdoY0MwSEczMUFMZXJyc2l5TzBR?=
 =?utf-8?B?Rzd2SVBLYXR5d0hYdEI2ZkJCQjVLS0hNK0hpZE4wVHNTVFdURUJsZkJ2K2l5?=
 =?utf-8?B?K3paOUlSUzJRYTdmKzBobnJKUGp2Ky91YTJUTkVKQWhnUGp6VThxS1dTTWY4?=
 =?utf-8?B?S3U1dS9uZFFOMXkreVpZdmYrTzFGK3d2NDhnandGb3pycnZRcWo0UzliaTRu?=
 =?utf-8?B?UU9jSDlaS3ZkYVF1dVZub3VCeVVHM3RtSnVBWmRCQjd2RzNzdFVNQ0VGby9r?=
 =?utf-8?B?UUxka2N1MExUSWZ3cldjMGVqdlU4OTlKRHg3b3J5M01FbC9aREVqU3NKS0xa?=
 =?utf-8?B?emt4WXpyaWQ3eFZOZDRKeHlQamlmT0x5OGZJdEZZTHpjYjdkZWhLUEc2M1FO?=
 =?utf-8?B?UjNwQ24rbVpHMjBQLy9UdUwxNXE2TjdNSmZzSGRycEpkMUwwdjUvUUZsa2hy?=
 =?utf-8?B?ckhUMS9JQ2JTR0FsZXpxejRlS2FMdUNDeDdUYkVNUjAvcFM1alQ2bFRlSkN5?=
 =?utf-8?B?dWR3Z1VFb0JQaEhlKzJDcTlCSnN1WS9wdnhQQjlXbkNpZTlWaU93ZFJUalRB?=
 =?utf-8?B?RWZPNTRYdlp3Njc4N1B5UHNkSVlRN2pGU01vcXo4MUltZUlhUTMyT0dmbXBi?=
 =?utf-8?B?blhLVVpvQU5rMEJjdXhyQ214KzNUVUdKcG9YRzl0ZHoxbmMvS2FhUHAwaWUz?=
 =?utf-8?B?L1hrWVY3ZU9rWFp6d09EVm5kc3A3aG5PVHpETW5ERmpTMmV0NFR5MFVyck1x?=
 =?utf-8?B?VTFTNHdENXhGUmo0bzh2bVBpQy9pTHZvS1pncWR2SkZtS2dLNm9nNkVLTElm?=
 =?utf-8?B?U0FpT0xFRTdYcFpLWW1PL0pzWmJ5Qk9SeUh3RW10dkl6MXFRdGdpRnlTN3Ey?=
 =?utf-8?B?SmxKMENPNXZDVk12L3RpTyszemZxS1JkQVhEQUtLUTZJM0RoUndhcFlNT2x3?=
 =?utf-8?B?bXE3UmZ1aG12U2dxQURQNFh4YXB3VURnRHJHNU5VZlZabjJKeTkyS2hoVVh4?=
 =?utf-8?B?ZWtobmlTREEwUk1mQnZnTmZaM0N5M1FPbCtZOTNtaDJrM1FJWVJWdkhVbG1G?=
 =?utf-8?B?QTRpOXRmRDA3WE55RGI1Qzl6WWtVSEYxQkJxVC9FT3NiNWVBQXJmSU5nU04r?=
 =?utf-8?B?djFUQXNDQ1ZNc0ZrdUlIZFJyT1pXc0lSMEptVTJ0YUdUQWlWRDNFMlJOSDVF?=
 =?utf-8?B?MlQ0OEhTeVYxdkQ1MUdLVDRIL2tIQ2RlelcvOFNNRFVaczNoRlp3M1BRL09W?=
 =?utf-8?B?L05ZbGdrWXgybjdTL0RZQTJ2VUNxUURONGNKbmg1Tnl0TEpQRCs2Zll5WlpE?=
 =?utf-8?B?cDBoQXJZRjh3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6088.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUlaN2U2SG01STdBc3JIOXhXVkFXNVpEZm52UW0yd2paYkM5UFhES2lyMEcy?=
 =?utf-8?B?MHRDMUN0THJqR1NwKy9jTTlCSXVTazU2UzZieFJrNmErT3pjUEhzVzNKSFJt?=
 =?utf-8?B?SjRsUFZYbTBDcGRrbXRWRUhQdjgxcitMSFRsTEV0V0oxMHJxSU1ieDUvS0Q5?=
 =?utf-8?B?VWVEK05Va3M0R3JQTFY0K282ejVaK3BQdCtpZ3crM1lGbEFWQUJVSU1ucTdI?=
 =?utf-8?B?bkVPVlNTSDRrVzlIMVpoaEZzQ3lkQ0pWc1BYcXhIQVV4OU5GaWMvdFhVaDc5?=
 =?utf-8?B?NEJzOUx5cE1rcUU2Snk2U0hQcURjTHhqZ1FrL0h3bHpnOTkvdjNwaDNLdU5v?=
 =?utf-8?B?Y3NTYnIzQXJObTdkamd2RmdxS2JQVENwRHQ0OXo5bldmSjIzZ0NZVUF4d3ZC?=
 =?utf-8?B?QWRXa3NIZzNmN2dFblhmUkRkb0hpVUhGYkRNcDdoM25PRHIzL280aWVqMmhX?=
 =?utf-8?B?OGNrMG9ydDU1Y2FYVmZRNzB5bVNrRXVmZDVOc0p0SXRyZlZuQS91TlFyOTZ6?=
 =?utf-8?B?bG50NTVUdndDSU5wWUQybFBNN3JWN3IvTnd1ZUh3WXA4RVlNZlN0amM4Tm1N?=
 =?utf-8?B?Vm1kS3RESGR3ZHMvSVVQUkIyMFUxeTc3eFhGMXdWQlJNL2JDSmc1dmhtZGVY?=
 =?utf-8?B?R24xSW5qYUVhKzlRNUdjSGdJTEtheUxHTndxYm5XZHhCekQxS01PWFBnbkhh?=
 =?utf-8?B?N3dQWUZSVVFjT2RUenRweTFyWTErNHpnQUZoZkZaN0VHVUlTeC9WQzhHYzk5?=
 =?utf-8?B?M3NMc0grd2grbytBS1UvZDFnYWZOYXdKTUxoc1BrRXlEemVDVmV1YXFMS3U5?=
 =?utf-8?B?OCtzcEdXdWtHME9TQjNsSHFrSWttd0FOU3FQSHdldFdVMHFhci84VWdHNEJO?=
 =?utf-8?B?T3VQUWFwMTRzcE5UNjlST2tFZHA5V1hHZ3BvblpxVTgvM243ai9HK1E5Ukp1?=
 =?utf-8?B?WEhwZXVrOVdhTkFVY2NyTjhDK3lZdFBidzBOWTljOTJScWdpODRsYlF4L3F3?=
 =?utf-8?B?TVlwa090akc4cTZLajJ2ajJsa092dFhsQTBXcHNPV2ExcGczS0FxQnRHejdB?=
 =?utf-8?B?NkQzQlh5WjlVYnBYWC9XODVuaXl4TFh5Z3EvbzBQZHBrQmcrTkFlYU5kWTlN?=
 =?utf-8?B?WC9HN1FjRzBsRFAzcE5RVDIwTk9kU3dvWWU3T3FmUVMzMCtSWHJSMUZid0t5?=
 =?utf-8?B?QXVHeHM3WFpYb1p2TURsQWVQK25yck5DUWQwbVhmUDYrSHY1aEdXNVBNZDJu?=
 =?utf-8?B?YVphbVluUGg3dytKeUplNlB2K3VHYjE3R0ZtWkMrbkQreXFtVlA1NDk4U2oz?=
 =?utf-8?B?d3lueWhibnhPcU1XaFYyRENpMjRGTVhpdXpIYmN5QkQ5Qk9XSTN3Y084REIz?=
 =?utf-8?B?YWJDTGRBSDZLa0VkQnFxSG9HMXdyRVdRVVBKenhBNWJFUjFTL2NqWUdCSHkx?=
 =?utf-8?B?OGJRSVFQS05HUXp1cDJrTjNhb3djVEk5SmZwdG9PRzc5c201Vi9wYnYxMXMy?=
 =?utf-8?B?UFBPZy9JdnQyQU4rVmNHVlQxY2JrR3FwRXpncGlkZEkzSnZON0ZZL2NkQjlZ?=
 =?utf-8?B?Y2hMbTVHdlJKdDhrc2YyQ2Q2YkpOUytGSzhQZ0NSVHVHSU1ab1N2QXg5SnVN?=
 =?utf-8?B?dG40SEFkYnAwdGM5ZkpGdHdDVk5pVzBacTRydnRhRkZ4ZWtYTVFVUU1WeGpZ?=
 =?utf-8?B?Y2JGdVFNajZGVXl4RHlwNTBSWjhFUkhMVnp3SnV6dDIxMkxBY2gvNWl3a0Vj?=
 =?utf-8?B?cThid3N2MUgwbkkzUXprbnRhRWw2aGhzRW1PYVZsODhyNHdlM0VGcXN4YWVE?=
 =?utf-8?B?Z3RSc3ZMdHAyM25DYnYwTHM1SHdsSXVPUExZTkIrbTZuN2ZsWnNlMlZ6eTll?=
 =?utf-8?B?YWFWcGcyRUNMTm83YlQvMTZpN0RyOTJtNGdreGU4dXMwQVJkSVZlanl1V0Rw?=
 =?utf-8?B?clltVXRueVlqV1VlR3pURnRzRzRyRVZ0azJxQ21tUXFCVGtCUGdMdkI3SVdK?=
 =?utf-8?B?SnJ3UW5BUzRMSDNQZEF3aVVGVVM2K0R0VUI2aVhoV2kyY1JQb3RKdE4rc2lu?=
 =?utf-8?B?R3FVaUdpNVdGUENzWGN6SktFM0NZU3hnS2kxeXJnMnN3K1BJODdEY25wclpK?=
 =?utf-8?Q?vgUVpqszSMKobVui6Oluq9Bnx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6088.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef2e38f-f251-41f6-417d-08ddbeb6498c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 07:00:28.3359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wK1LUzaTiV8hTrk+jgabMZM6XW5iwaIpXM6yoXFvdlUVZIBdne+KowEcPTRJ3b85A65mkPISp5Bt7vpvW0+GQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR03MB8090

PiBPbiA2LzI0LzI1IDAxOjUyLCB5YW5rZWkuZm9uZ0BhbHRlcmEuY29tIHdyb3RlOg0KPiA+IEZy
b206ICJGb25nLCBZYW4gS2VpIiA8eWFuLmtlaS5mb25nQGFsdGVyYS5jb20+DQo+ID4NCj4gPiBB
ZGQgU1BJIGJ1cyB3aWR0aCBwcm9wZXJ0aWVzIHRvIGNvcnJlY3RseSBkZXNjcmliZSB0aGUgaGFy
ZHdhcmUgb24gdGhlDQo+IGZvbGxvd2luZyBkZXZpY2VzOg0KPiA+ICAgLSBTdHJhdGl4MTANCj4g
PiAgIC0gQWdpbGV4DQo+ID4gICAtIEFnaWxleDUNCj4gPiAgIC0gTjVYDQo+ID4NCj4gPiBGb25n
LCBZYW4gS2VpICg0KToNCj4gPiAgICBhcm02NDogZHRzOiBzb2NmcGdhOiBuNXg6IEFkZCA0LWJp
dCBTUEkgYnVzIHdpZHRoDQo+ID4gICAgYXJtNjQ6IGR0czogc29jZnBnYTogc3RyYXRpeDEwOiBB
ZGQgNC1iaXQgU1BJIGJ1cyB3aWR0aA0KPiA+ICAgIGFybTY0OiBkdHM6IHNvY2ZwZ2E6IGFnaWxl
eDogQWRkIDQtYml0IFNQSSBidXMgd2lkdGgNCj4gPiAgICBhcm02NDogZHRzOiBzb2NmcGdhOiBh
Z2lsZXg1OiBBZGQgNC1iaXQgU1BJIGJ1cyB3aWR0aA0KPiA+DQo+ID4gICBhcmNoL2FybTY0L2Jv
b3QvZHRzL2FsdGVyYS9zb2NmcGdhX3N0cmF0aXgxMF9zb2Nkay5kdHMgfCAyICsrDQo+ID4gICBh
cmNoL2FybTY0L2Jvb3QvZHRzL2ludGVsL3NvY2ZwZ2FfYWdpbGV4NV9zb2Nkay5kdHMgICAgfCAy
ICsrDQo+ID4gICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ludGVsL3NvY2ZwZ2FfYWdpbGV4X3NvY2Rr
LmR0cyAgICAgfCAyICsrDQo+ID4gICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ludGVsL3NvY2ZwZ2Ff
bjV4X3NvY2RrLmR0cyAgICAgICAgfCAyICsrDQo+ID4gICA0IGZpbGVzIGNoYW5nZWQsIDggaW5z
ZXJ0aW9ucygrKQ0KPiA+DQo+IA0KPiBUaGlzIGlzIGZvciB0aGUgUVNQSSBkcml2ZXIgcmlnaHQ/
IEkgZG9uJ3QgZXZlbiBzZWUgdGhlIGRyaXZlciB1c2luZyB0aGlzIHByb3BlcnR5Lg0KPiBTbyBo
b3cgd291bGQgdGhpcyBoZWxwPw0KDQpZZXMsIGl0J3MgZm9yIFFTUEkgZHJpdmVyLiBUaGUgYmlu
ZGluZ3MgKHNwaS10eC1idXMtd2lkdGggYW5kIHNwaS1yeC1idXMtd2lkdGgpIGFyZSBkZWZpbmVk
IGluIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLXBlcmlwaGVyYWwt
cHJvcHMueWFtbC4gVGhleSBhcmUgcmVhZCBpbiBvZl9zcGlfcGFyc2VfZHQoKSB3aGljaCBpcyB1
bHRpbWF0ZWx5IGNhbGxlZCBmcm9tIHNwaV9yZWdpc3Rlcl9jb250cm9sbGVyKCkuDQo=

