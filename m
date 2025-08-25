Return-Path: <linux-kernel+bounces-783878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7DFB333B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A20118954FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 01:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4DA21FF4C;
	Mon, 25 Aug 2025 01:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b="km6GewXX"
Received: from mo-csw.securemx.jp (mo-csw1121.securemx.jp [210.130.202.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0330225401
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.130.202.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756086967; cv=fail; b=HdTwKWfl3NshaTPfnovL/92/EL8bUphHuYqfZIhrKAdfUjKCSL3WUE6WGQLYzGKurDqWqHFPd2LUjCUSgdHcOqSRVQw0InKeaUd78bL1weObxE0y/quQWXxuxTkuZUNoh4DbeM8S0lYptVkjHWG/JIpZVd+XLo32VE5SLelMr1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756086967; c=relaxed/simple;
	bh=k/YT5dbWu/ODLK4SBP9qzGjUrtnHMlzs4e4NlOHn9Zk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jJyxUigpK1ylxCiWi0rpPtv9pp+IWB3KRF4JgAcQGbBZavXnOZlvK0n5+Hqw8uv9BHNz01vIyvYZSGBwkQBI45ZpeVNHS3ffo0NlXvuOtqYHKsZz0rWBDk5EC5AduZ3XDIrLjz4wQGzSwOToWn+bhGHH8VMOVP46GAA/kyywErM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba; spf=pass smtp.mailfrom=mail.toshiba; dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b=km6GewXX; arc=fail smtp.client-ip=210.130.202.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1756086926;x=1757296526;bh=k/YT5dbWu/ODLK4SBP9qzGjUrtnHMlzs4e4Nl
	OHn9Zk=;b=km6GewXXCRc4k05/8xSK5RmJjNm94Y51CqEeHbKhEX/fD9EXixHhvz+IsIwt1y3wLIE
	JR9b5Rca5WsweDtCOadsiK7GbPbwEjuIYPM8eClmHJmaiLO8zwtzZeaWBD2rEjfROtYzmsITroJaj
	/CbpuUa5qX2pg2/bp26eqwJb+5KzwG4r0yqX5Y6xmOc+w9agXcuQ0wOSt7cYwPWELkXs/TPEBTra4
	qIU1XQJDOiHNxTxv49WdwA/62JxRe0HuEDb0XldOwyp6yQd3ZCbElfXFr9BM239nGMlr/7TC76kMk
	FZdO0tudlXIk6i3VB8MGQMAe+xACjZdJIjt6+9DkJywQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 57P1tPHh3647379; Mon, 25 Aug 2025 10:55:25 +0900
X-Iguazu-Qid: 2rWhEqwpoAZxvBWwLy
X-Iguazu-QSIG: v=2; s=0; t=1756086924; q=2rWhEqwpoAZxvBWwLy; m=GwFWzQuMFPUTHGPKwZDkYG9aI1ixjwp1hsc/3D6PZvQ=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4c9DQM5XWpz4vyk; Mon, 25 Aug 2025 10:55:23 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJy77xmmNQcYaKJJAV0zPhM5Qype9CiEwnEJshOtHcBBCK0qEYeXxHnY30snG03EZC5PV+Q2IGnXSU+BILRWv5vyrjQeo9QxTOvqHWIb29ysOyzM9mcedI/9lCMOkVER+od079/vT8byTxFAZS3Ut9uaQMxVCLwW9UgzPngkDdu3pICkuLmrw7ULUwl8lm89b2bMfCWB3u1iy6bcJpsI9wiDcRLNgYFA5bY2tnatxi0bWwVAk3m/H1UH6uUuRomGr+wJ3juDOTj4evu8VpofP/ut6Rltw3V4jIrXObRnZWdqvx7Ok+QBJ6KOttpoySHDxAzYUUAdZZ9rhSqBYTpeMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThvjI2qMHGPe28RdLf8h7Af1r6bq52HFBdHNSXQVhQM=;
 b=DlbXPNYuO+9kOSU6Z0AVxJZ5uwC4Z5MNpj7tHIgxZDZAmC3T+xkwgbLSCWqjvLOKuZkSNApSIJNMi2dAIaJ2Wjxg7tt5ETEOqWypUCzI0yVjcZZjmxQPj9V4IbqlTdM2Dwi1dxS+/HYCGB/hlS+GCWimSj18Wrbwa0jz4l2QU3D4rJges9O3WuyRfLqqAoSrgXczygePWBQ0v0Bkze/YdnotLYzhMViQlsJXGj8AoAvksCCUCOsuoQYWB/4Ir1eYmfDq/RVHDDeNbJOJ6hgLjvjLA4n0SVGog/6KfETT5ps5InBFexhows7O+dJCFILt/D8jko4aclfQYxhnyIW2mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@ucw.cz>
CC: <arnd@arndb.de>, <soc@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS: Update Nobuhiro Iwamatsu's email address
Thread-Topic: [PATCH] MAINTAINERS: Update Nobuhiro Iwamatsu's email address
Thread-Index: AQHcEYodu5B0BJ9vE0+hrJKJBlxO9bRyKECAgAB7D6A=
Date: Mon, 25 Aug 2025 01:55:18 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818C728D500C4F21566337DCD3EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <1755663767-1612-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <aKtbG1xk/8sbyHmW@duo.ucw.cz>
In-Reply-To: <aKtbG1xk/8sbyHmW@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB6964:EE_
x-ms-office365-filtering-correlation-id: 75617c2d-0fbc-462f-2d5d-08dde37a71c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?aDJIcWxqSkRuamJES1puZTFmdi94Z2hXcU5lVVNPRVZwZmxLSTBkR05W?=
 =?iso-2022-jp?B?OEtGNDNJRm9zUzQrRWRyK2pKR0lpaFR3WWgwVENxdjFuVG5zdk9iNGZv?=
 =?iso-2022-jp?B?NXd6bHRxN09kYXNYMkdnMExwQVA4V05CbHJFWUEvazhrbWF2bjhETWRD?=
 =?iso-2022-jp?B?NU1YSFZ2UExua1ZmV2JYK2c3Rk1tNWwyaTBiR016UWJnTlJXQkdHN1FY?=
 =?iso-2022-jp?B?c0N1VzdZNUFoT3FWelBLL2lvZFZtUUlQeHBBM3h6RUZ6UEpwRUJ2eFpQ?=
 =?iso-2022-jp?B?MWdlakliTE9OTlZRM1BVS0pieDRKRjBFRGlaL0Qvb0Rpc3FQcEExWWlW?=
 =?iso-2022-jp?B?djUrVXpqcGFiWVNlTDFnQ3NrRFNxalFwUXJUaGFSNnI1SmJMSXkraXNK?=
 =?iso-2022-jp?B?Y05VWGdKaDRZNkJhTkJrZHRKem54LzZrVHplWVY1Qk9QQklkcUhuTUNz?=
 =?iso-2022-jp?B?SUZUUEJFWkpHOTZiVmExTnRKL2dWMHVHZUN5a2dUQ2ZOREdWSXVJbUt2?=
 =?iso-2022-jp?B?ZDRHVFhBMmlGYzJ0eEtkRGd0UEdVMFZPcFdQNlFMYVpTNHN2djBxQ1ph?=
 =?iso-2022-jp?B?cGpUZXZsYm02dlo2YXNHR0R3RGdWMk9VMndQTytYR0gyQ0hkbUNNci9n?=
 =?iso-2022-jp?B?ZjhxcXZJQVR3aFk1K0hrTGIvOHBZdDVsWVZHQk5HUjRNQkV4dzNpdU5p?=
 =?iso-2022-jp?B?aHBZaXE5bVRTS1crUG9YT1JNZWVVbjgxcWxwUkdpaGROU01tS3pzNFAr?=
 =?iso-2022-jp?B?aUs0eUQxQXZKckp4YWd5U0ZtY0JVbGdJa3lPWWZRUFlwUUdvQmpCMW51?=
 =?iso-2022-jp?B?bURJaE9IaG9wNUtzSkl4S1FKdldDUm9NeS9hUWVTZ2RxeWcwYjlEZ1ZD?=
 =?iso-2022-jp?B?N2pnS2J0MnpES2RLaVFQUEF2MllNNTVPNzdUVGhmTEJGemhaOGFQcTdK?=
 =?iso-2022-jp?B?cHNyb0pReHlzRUp2R3Qrazg4cktwbGQ0YWxtb0paWUxFZSs5MW5sTWJx?=
 =?iso-2022-jp?B?OWV4WDhwb2ZHMjd6T3hIelZQV0hjQVIvRWJoaGVuRGJVR1JPa0lYdi9w?=
 =?iso-2022-jp?B?MUx0UWlKdTdObTl4dDQrVFA1cU1Pdks4bUVRK1Rxbjd0Y25uVVdGWExI?=
 =?iso-2022-jp?B?MzVyTStiZUFia1B3cHFBSXZOZHY2UVpFU3JRMWRMRE1WMUk2T09MeGVM?=
 =?iso-2022-jp?B?Vzk4ZEJtcmw4UEI4NGw0MHk5U3N3RkhoUllSejk0SDB4WGRGY1hzdUF0?=
 =?iso-2022-jp?B?RE5adjEvUGZYNGlveW5ka2VaWllJQzlHTnM0SjdKQXFuRUpOck14NTBP?=
 =?iso-2022-jp?B?bU1UMkw0Q1NGbjFSa3MwVHRqV1Y5M0NFS2ZTTGhhNkVmSVY0djh3RC9w?=
 =?iso-2022-jp?B?bDROYXllYzk5bVVpWlNHZGxVTW9OSm5QdzUzWFN6MTBEd1p3YnBtSmNv?=
 =?iso-2022-jp?B?TjcxOWU0Z0VPWnMzMmZ5b0lwY3JsSHRpdW1MRjZBa2MyRUppUFdCRUV1?=
 =?iso-2022-jp?B?VEJhdmRvVmlSaDdQcnZmUktQTE13dFU1TE5LVnJtWkgyaUQrcG1zMFFi?=
 =?iso-2022-jp?B?ZGF1N1MzOTF4Z2xKWXdpTFZ2UXlNeURVWThoZ3dhY2ZsRGhmeVNiTnFh?=
 =?iso-2022-jp?B?aXgzaHpTL0JQRWdHUHBqVFlMQmdpN3h6SFU2WFlxY2wzMzkvZDhERDYz?=
 =?iso-2022-jp?B?SGVYUWJjRDc2aVMxZzdQb1B2UnlnMkl1S3g5ZWV1YndYS3F4clNCeC9i?=
 =?iso-2022-jp?B?VnIzYmYyRXFDcEdrVVlzYURpcndtN2hDVjlzWW1pN3BXODhBYVUxYW96?=
 =?iso-2022-jp?B?NERqUUNIMkRld1g0akNRVjE5Qk1RZWVMZk1kWnRWamVtaUFOVXVzbFpP?=
 =?iso-2022-jp?B?YkVpNm5MMVZ4NFZ6VWMzTlFTcmtyNGFhYjBDeVZOZ1lKNGxLeDVlTCt5?=
 =?iso-2022-jp?B?anRyMGozaXR0WHRyUVpIa0tPaDFXQ0hlc2Y0SlVmaU8wWG5jeFpHdFNG?=
 =?iso-2022-jp?B?L0Q0NURBU25wNE5ybHdYYnNRaGcxeW5QQWNWTktSYldzUnZvbnVNQkpI?=
 =?iso-2022-jp?B?OXgyKzNOOVF6YkMzb1NzY2lYMGRiY2tJVk9pbzRBTUpoMkJkL1BLMG5R?=
 =?iso-2022-jp?B?MjF5NFVFdDVoV3lvUGlRSzZHZ3FwQmxBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?V2U1WnhFWWNHa2JSSVNJdjZ4WUhuMVg3Z1Y5eWJyOEcyZ1g4dTVaWXpx?=
 =?iso-2022-jp?B?T1JGR0RLYU12cFk1Z2NmV1NvN3JDOFR2Q1NlakswWlA4Vjh1dCt0UUly?=
 =?iso-2022-jp?B?R0E3cStwU2FSbkdtTWVXWlFxdTU0cmVGRE5YY0JTVktLRzJHQ0hHOEll?=
 =?iso-2022-jp?B?TXgrTHM1UjVhSmFDa3NOOTBpaDZkeXJtK0YvdllPbHRtMnE3Nmt2dWhX?=
 =?iso-2022-jp?B?VDJoYUYzcEp5WjBjd09JOExZRzBrOFQwTUVPNjFiWXFmeHN6WE5XZkll?=
 =?iso-2022-jp?B?ZjNJOVZFNVFKSHlSYWVSMUdiV1pzUFZkaWpyU2ZjVzBmZEZYZTJzK1Jx?=
 =?iso-2022-jp?B?UGp4NXpOS2lvTWpEY01NSnNSekNuZ2d1eSt2NEZNNXphMVZiVFM2VnRy?=
 =?iso-2022-jp?B?MFgvM013VEdTL2Vrc1FrNWtKMGpVRUJiRDhBRy9lRHBXYzczQlhHTXJr?=
 =?iso-2022-jp?B?ZVJ4TTBtVFlUOVZaZWs5c3VXM3N5MHRZODVkQ1R1SmdiRDB2YUIyZ1Zl?=
 =?iso-2022-jp?B?T2VPV2w4UmRHVXhkQlZlN3NrOEF3RENqQmd6RXdhUFpzVmZHTjJnN3pU?=
 =?iso-2022-jp?B?NTBqcUhBbFlQWW1wYjJtc1V3Vy9hdDNydGJ6SkV0YnhjRld2aWtjc0I4?=
 =?iso-2022-jp?B?ZGdBTEpHZWpUS1RPQ3hIN2Y2WkdqVW9YWFZvUFJPZ3piZFVyTVd5ZFJZ?=
 =?iso-2022-jp?B?VHlCaWdqTjNDZ1dBK2NUNGdBLzdVdHF6UllWS2lqT0d3VFg2MTMzaG1Z?=
 =?iso-2022-jp?B?aFZMTElzcCtqV2R0ZzVscEVRdE1TcUhDN0REV1RodlhURWM4cHdFanA3?=
 =?iso-2022-jp?B?UC9kSWhwalI1VXpONU5xR3lvd0FnMmtPR1d0L01qN1BIb1k3eFVOSFNk?=
 =?iso-2022-jp?B?N1pBVE9WY0pJaitxK0d6M0o2bWt6OUZuZGlybVhwUWNPZE1LbTgwVyto?=
 =?iso-2022-jp?B?cE4vWndqQkpoNlk0N01OajF0bmdGcnVOVkw4dGdQbmNqMjZpSzdXSHJv?=
 =?iso-2022-jp?B?ZnBqU05Ed3ZMU3BuTmQ5dk04cU0yZ2VDODR6dWdYV09hcitKSUhBT2hq?=
 =?iso-2022-jp?B?NkwybFZQdW42MHRYaTBkZnhtYzRiUk9RRnVwUlpZWTRLSlpmSytwV25s?=
 =?iso-2022-jp?B?a3U2aUhCMUJHemdNdWhnK245Z3hXUFVlekFBUXlZM1prQ2haUFp0TXJY?=
 =?iso-2022-jp?B?dGhHOXpWWHNtL2xsNi82YVFsaDY0OVlrdVl2czdQOTlPRjdlc1Z5MSsr?=
 =?iso-2022-jp?B?a1RGWTdPYUpGV0s4Rk8xODZTNFkwakc5RFZ5Rmk5MWxSbkduUWMrbnlp?=
 =?iso-2022-jp?B?WEZyMXMvNmY3eWR2OGxKTkwzN1NjQTNJclJPc01CaU4vend4ejg3L3h3?=
 =?iso-2022-jp?B?MThQYlBWcVR0Mm4xZDNwdWYvV0NFVy93eDQvT3NtODltOUVRU0FWNmt2?=
 =?iso-2022-jp?B?QlZydy8xdlA5QldpbFU4TmR4cjdYQUpFVWNoalJOWldhYmN5aURxcjlo?=
 =?iso-2022-jp?B?VGJvRmpjRG5kU3phOUx5MFVWellSNDJDQUZCSTExT1o2dmk0ZkRZWVNT?=
 =?iso-2022-jp?B?aXhkWFVZVk5EWHNHSjljK1dMY0xQU2lhTnpLNE1VR2c3MmtZQzUvaWhR?=
 =?iso-2022-jp?B?Z2Y5MnVFVEt5alJQRHRrU1BwaGZHNkI1N1d0VjJkbjd5ZlAwYmZGU04w?=
 =?iso-2022-jp?B?dnhyNVh5N0NRdjY4eG1YaTVDQjNNWmtFS05SRFhTckhsejVIeHRFWm1T?=
 =?iso-2022-jp?B?Tjl0WnBnTlREN1JKaGNyeFF4WW1aV1JhbFpodnRUS2t4eUdBSEY0cE1i?=
 =?iso-2022-jp?B?Z1QvdFBoVE40TnNhN0JWckhNVFJ5TmQ2SisycmdKczVNb2J2Um4vWXBM?=
 =?iso-2022-jp?B?RjNvS2Rtd2lNbUsyWmFOMWVYc1hTbTVCTlg5OS9tVFlXVHNMTWREMExQ?=
 =?iso-2022-jp?B?VFN2TVl0U1NRbWFQNjJ1KzZQZFhXS3lHb1BpK01jRW0vWVhWQTdXS2RV?=
 =?iso-2022-jp?B?UDV2SElHQVYvWFZtQnEya0tMVEZ0NnAvMnc1K3pGRnhVRzZERGRvWWp4?=
 =?iso-2022-jp?B?S0dDeXFickNZNnRXOGxqbDJacHZTeEtHT0ZzMXFDWW9oTUJuQVJ3WUU0?=
 =?iso-2022-jp?B?bnZmV0EzeDhYQlFnYzB5SXNDd043TWhKL1JuWTg2T3pFK2tkN29iaG9w?=
 =?iso-2022-jp?B?L3ZBZERxMmJwZzZVTWFQZTA0YUU4TE1MWHdDOGRqeWxmWEcrSkFGRVVJ?=
 =?iso-2022-jp?B?WnU3Nm5HYk95NTlOblJ6dmlEY2I3bmM5M2t5YzlqNURmRzZoQlhQTXF6?=
 =?iso-2022-jp?B?U0dvZytUMmMyZ2tNemxwOWZpU3Z6R1hlbVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75617c2d-0fbc-462f-2d5d-08dde37a71c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 01:55:19.0186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jzuu0BAV3DlmB6iVhUFpAiykNgBHswHkgHIml6HIYjToyVCfmiVyfvAnkumHR2uUtH/QURsNYx69iZHNs52sMg66ClUtVjBEC+cj0B7SK7GWQeYrPAGqvictNS1fIhmb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6964

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@ucw.cz>
> Sent: Monday, August 25, 2025 3:34 AM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Cc: Arnd Bergmann <arnd@arndb.de>; soc@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] MAINTAINERS: Update Nobuhiro Iwamatsu's email
> address
>=20
> Hi!
>=20
> > The company's email address has been changed, so update my email
> > address in MAINTAINERS and .mailmap files.
> >
> > Signed-off-by: Nobuhiro Iwamatsu
> > <nobuhiro.iwamatsu.x90@mail.toshiba>
>=20
>=20
> > index 4bb3a7f253b9b..328b04f82dac7 100644
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -585,6 +585,7 @@ Nikolay Aleksandrov <razor@blackwall.org>
> > <nikolay@redhat.com>  Nikolay Aleksandrov <razor@blackwall.org>
> > <nikolay@cumulusnetworks.com>  Nikolay Aleksandrov
> > <razor@blackwall.org> <nikolay@nvidia.com>  Nikolay Aleksandrov
> > <razor@blackwall.org> <nikolay@isovalent.com>
> > +Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba> <nobuhiro
> > +1.iwamatsu@toshiba.co.jp>
> >  Odelu Kukatla <quic_okukatla@quicinc.com>
> <okukatla@codeaurora.org>
>=20
> There seems to be typo (extra space) in <nobuhiro
> 1.iwamatsu@toshiba.co.jp>.
>=20

Thanks! I will fix and send v2.

Best regards,
  Nobuhiro


