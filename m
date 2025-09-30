Return-Path: <linux-kernel+bounces-836946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 584D3BAAF2A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD471884028
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA241FC7C5;
	Tue, 30 Sep 2025 02:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="WsBC8zPK"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022138.outbound.protection.outlook.com [40.107.75.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F1F13EFE3;
	Tue, 30 Sep 2025 02:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759197932; cv=fail; b=CazLOChsp9TNV8Ll9yPl0ktW9jzRG7szJrIW+rBi7lzQRU2yQOUo3fZ+0FyhWjiIZbBZzm7P9SPxr7gCpjRR/u94O2S858ooUzKqewletqkB3A/9XmfDqeOfOwKuYjFW9qAGATkkiym3FchnLWcHCMqg3SE9pFHBDM6SQlThgFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759197932; c=relaxed/simple;
	bh=2sQ7yDUt1dzDRCXlKCvdePA6iplsu/nnUL5y9kuFK6M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dHwtYOgB79sNFHPCHShQo0LuJnheW/D+18kB32GsgKhikwdJhN9VfPrC2mR2oYQQspT7e7Rw/RkaVBBpaSzWKjBu4QXXAwq1eEkDQzmTNZOTFoXplvabBq1r2Qzv4+yGQDHIqWTUkvzE+dOFkX4omkw/Vtcl8Jkokp1Lv9W7SOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=WsBC8zPK; arc=fail smtp.client-ip=40.107.75.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjmtgmBCVF/rtjkzh7vPX+HhM7Q3X9X/BSHeHlCbUcNnKhsKNBt7AUTtCnVkWHmCgL1DRjMwh8DykZ+S1qiq/P0sFosGYZSNSzuquasOH9zZwYKqwkUu7fipMKTwhUQEhETr9lfd8sFNnt4NEjFvCKDV+29vP55cbIVKDo2uQ0w7Ie+9XMzRQpWCkE63fTvw+tHRDd/DsQoNN1gXkMO0Y1aSWgDbMTJz3d66j+soMhGK/6KMswn9HShkNQp6arfv9l5yZdw7rP5B8ZQwAa+J0LuRcI1MrRWCMkh3QLmc6AZB9oISJhTEvM5u+p9TA8XRlxSCh6PX576W5bbxdzY0xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71JOEv/Db94sl02aDS2Ms3EvhNizH/iYcFxKQSOQwp0=;
 b=YHsKT3g9l4snF7HvgcTVg27yeLga879nBCl0FNbwNTglm40Ea5FmOXn9YN7mIdDfMvjEM5U8JU5oGCUY66coTDsF5nX+V/HfHT0YCjsb3SWNkC6RiHYIHQn3H5wHslYQ5EquK3rIRkZUMM+FNITRGmRDUzIY9TA6YtaeZE3+0J6iUIRelSZ0MglwKYwDVsMqmjvC62GmfkRcweUOcGekQLWfLz0fUQ2qXGW6ViLuenuo/92x2hs2TyLfxJYUFxm6WNLlw4edA+t/wXSVlnQB3UCgzDxO3RlHPuYpaZefk3CGlsbOTI4KRjdromW1ioW4VJibzW3ZP6nZVJ3VVBsBiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71JOEv/Db94sl02aDS2Ms3EvhNizH/iYcFxKQSOQwp0=;
 b=WsBC8zPKfAKEY6knntKanfw0EAZFS8gk/gLPXI/8dFdcvJU+3B2/RQbuFBoAaNAFnb6G28ZqnjnlWEtfZxfXi7UHOiuxDTwwEHicGkp8GjGlEnMfjnzMDcuGB5q2X4BPjjZULnAHBjoFkozQQYxCABvr/gmJVlBp1nFv9BAjf2y7PuVIUZK23YCWhsECr+b6Xzkfwf2Yk1V+IBPAqYeg+YuY89hZCQSFlW+R0tldE83qPvvDVzoyew8/PtB287RoXGjHGL4SdT2cnN5JizpG/fpzox17mkvErNK+hckS2feSU2xh/BLUhOS978JH0lV37qzRWjUFkZnP3pghr5d5uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by SEYPR03MB8741.apcprd03.prod.outlook.com (2603:1096:101:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.14; Tue, 30 Sep
 2025 02:05:23 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 02:05:22 +0000
Message-ID: <1639bb9d-9cb7-409f-bbf8-bfe4a5d1b8bc@amlogic.com>
Date: Tue, 30 Sep 2025 10:04:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk: meson: Fix glitch free mux related issues
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20240929-fix_glitch_free-v1-0-22f9c36b7edf@amlogic.com>
 <20240929-fix_glitch_free-v1-2-22f9c36b7edf@amlogic.com>
 <CAFBinCBd5-s6vaBoJNerXavQiHgsv4Fm3v0svUX7geL=kJvVYg@mail.gmail.com>
 <20178015-4075-40e9-bbf4-20ae558c2bef@amlogic.com>
 <1jldyzrv2t.fsf@starbuckisacylon.baylibre.com>
 <e70e9aaa-f448-4f67-9149-cb5970c9bbd6@amlogic.com>
 <9834c7c5-9334-4c78-a2fe-588ff03cf935@amlogic.com>
 <CAFBinCCoX5+6+KQAtbhKx9KdSZhXVxS=cz8DfMVhjPX1c0iSPw@mail.gmail.com>
 <1jfrc563wa.fsf@starbuckisacylon.baylibre.com>
 <36cd6282-ae1d-43f3-8738-592f043d0ba6@amlogic.com>
 <1j1pnp5sg7.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1j1pnp5sg7.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|SEYPR03MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: b2951d75-3e25-48bc-e9f3-08ddffc5d04b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVFDQ1hQWlJYaGVITWVuZUxSTW9ISTM0MGxWM0dlNEhjci9FcnNTZm5sTW5x?=
 =?utf-8?B?bUR4alNjV0FLbDVHODhDbWwycVA0TWdEUTEzV1BGVmhSQXNqc2ZmTGdvbTRu?=
 =?utf-8?B?eVV5RmJZenQyZlhNUlkvTHZzUXdvZlZmZzlDREIzbmVuZUxOek1sRmZFM3hl?=
 =?utf-8?B?ME5QblJONVlnYjhjbWwwYlV6cFhjSDJhNmRaLzhxTHR3U25PNVZVVHpWSWI1?=
 =?utf-8?B?S25KYnl3N0tVZHJVRWFnMkw0akhUVlc2ZmRrTlkvMnRXS2dHVnFjSklENXdC?=
 =?utf-8?B?ZndlYjFwWDhvM1lVQkQxckFBc1V1NVhtM1BkUzdYU2xKNi9ZRlJvMDdHTDUx?=
 =?utf-8?B?OFpaeTFCQUdkQWRObjBLbzRydXM0THpaMTNHQ3M0bG9wT2lLdmRBTFk2MjNp?=
 =?utf-8?B?R01SYlVZMlB5aWFmYzNEeDk1YmtRMFU1eUV5YVFrc0lRdCs0N0U4dStWWXRZ?=
 =?utf-8?B?YnpJeCsyNU5tSi9IUVNCOTRpSG82bGwzVEcyM1d0VlVtVmdacWExelh5NHg3?=
 =?utf-8?B?RmdkR3E1QTJhOWswcXZZUVJUVmJGYUZBTFU5U1VPWTFNRVV3L3RRSVcrS2V0?=
 =?utf-8?B?ZDRUVXBwV2UrL1BSdDRrK0hXRER6Wk91SlBmRVRjWDBqLzBlekhlN2dRdkJJ?=
 =?utf-8?B?RVJ4Vkp2Vkd6Qk9uanEwRER5RzRnOXVGY0NKVmhncGV0bW5JYWdKK2hIcnRo?=
 =?utf-8?B?WmZKa1dRZXpwQUp0bE9pbGFhM1pKYlYvaDdvWThqdCsvdCtLUEhFTjZTTTRG?=
 =?utf-8?B?ZFZ5cmRYQTRNQkhoUCtTSzdJOGFrSk5hekxRZG4wOTJhcjR1dkIwVkR6VWpm?=
 =?utf-8?B?cEgrcDRpbWorMm1haXlrYVp1SVVzUit5VlZOMWRiTnBEa3lBOFF5Tkd4cWE2?=
 =?utf-8?B?b3pIbGtaays5Q2FTaFJCQjJweGlWSFVodWpPZEpTOUNVb0RZODlFVHVHUVQw?=
 =?utf-8?B?VXNzbFlocDMxYVJjZitXMjMxdzAzbVRzRnRidC9YVGI5WGpmL1hCUGdoN3BF?=
 =?utf-8?B?OTNVbUorWWFOZmY3UFRBR0JqbEtnU000Z3pNckJ1cmVJdG5HQ01aK1BEeE5W?=
 =?utf-8?B?RzEwNDBkUmQwRHBLdWNxRVdsL0g2R2psT2UxWmxlTTgyWTZYUXJQRm9hYnBr?=
 =?utf-8?B?bUxlSzBWUldlM1Z6eVVtd0R1MXZkYzNSRE5YblNmaDJPZlpHamRONno1cWcz?=
 =?utf-8?B?bTc5SU0vaUVoZ2hhNDRDL1dWZEw1YWJUM2lvY2RMWk1sUWtXMTBVeHFncUJ4?=
 =?utf-8?B?SkplSVhTQUdERCtRV2NyK3VOK21FeENkYWh0SjVJWUJSR2VCT0xnRWY5ZU9x?=
 =?utf-8?B?MGJRZWlnOGVEVU10ZkdkeVRUTUZpYjhwQjFaV21BbGpTTDFyZkw3TVJBWTRr?=
 =?utf-8?B?SGdHZFptcUJGVUNNeDJjQWVJdGNRemUxSFBQS3orQW5LajVremRVUndIbmFz?=
 =?utf-8?B?aVZRMDVNQmZHaDA4cHY4TlhtK2xTVWlwVFk2MEpSVDh5WkFXenhTL2FQb3ov?=
 =?utf-8?B?VGxBeVpDeHBIK1VqVFdPQ01MVHlHNmREMkx6NVQvKzg3UUp5ZU5GN2RTdDZa?=
 =?utf-8?B?ZmxTa091S0I1M09Da1drc1Y3R2ZTYldVbm1FQ2VDbVVpSitRYm1jT3ZMaVpH?=
 =?utf-8?B?WmhCamN6Y05HL2hyS2c2TmhGM0wxNHA2YWh4cTNOV1MzR3hObWQxL2Vqd25O?=
 =?utf-8?B?NjJiWjFSaWVPLzU5dDVwM1ByWjlKdytKeFB0RFFEZXB5UWJCY0JNd09xUWtL?=
 =?utf-8?B?K1JWcVRYeGdGU01xYm9aejZLT1dIeDViQ0lhQWl3bmR0VzVPcnI5dnV3bmFv?=
 =?utf-8?B?dDFKeU91OHd4b3FpMkZwL3lwOHJSekRQcmd0OVhMdlhYVS93RU03QVY1bXA4?=
 =?utf-8?B?cEE4ZXRDKzB1NmYrajlVRGhLaEo3VDc1RTRPWmpqcWNjaTFWSXRobHdUa0NN?=
 =?utf-8?Q?Lq6BASgesqfT4vIrMSDQTAXgmC7NQGyt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVNnV2g3dmhJYjlaLytUWnc0Wk16NFN0OUF3YlFsbFNrMHZzNFM4anR1dmRE?=
 =?utf-8?B?V2FMcjJMMms1NlNMeU4zUjEwWnhmMCt0eW9JWmlyWTA1Nlk0TkY4OUdjMnRJ?=
 =?utf-8?B?bmUvZGhDTDZCK3hCakRvTmpSQWQ4Z2QrUFNVOW9IQWZwRnJQbkZGOCtiUkoy?=
 =?utf-8?B?SEtpdGRzU3luQU9BWFU0Qzk3RmdESGRhRFBFZWNicXcwcTd3YUFsTFd1NE0w?=
 =?utf-8?B?dVFTdG93Rm5QS0liaWxvZGhzZ2gzbnBXa2Y1bytLS1BKMkRpQjUyclVHM1F6?=
 =?utf-8?B?LzNScXFYcDAyQTl5TGRtcXR0UzN2eTgrcGRoUTVkU0Zjb1FCYkJOQVkyNTlF?=
 =?utf-8?B?TkNWcEFtVnMzUVVpekFYZkd1WHBIVEpUQ0dEOVpEZkxTRVVFTGpmZGdUVkE2?=
 =?utf-8?B?ZXNJc05STE5vaXJQTjFOeFIrcE5CbHh5TnhaRHdCUmwySXMxRWN2NFFVeGxp?=
 =?utf-8?B?OVRTeWorZ1cvWUdrd2FSZSt3YkZEZUgvcUtWcmcycERWV2h0UmpUUkxVZGRo?=
 =?utf-8?B?amdGSUs1dTFTWmt6T2ZTaHlkTXFJL1BaWnRJbXZ5SzVHT0FrSTNsVjdJcENU?=
 =?utf-8?B?dVJrbE9NMk4zY0dDUDBKcmNQYlhhZ1dQQnM2VWU1SjFPNk1qaWhsVlRtbDd1?=
 =?utf-8?B?Zk1QWEZQQmc1UU53RnZ5NDUwbENPcHgzSVVGVlB3Mmd5bXE5SzBsZlZQNG5W?=
 =?utf-8?B?c1hBbmNkUjRneU1HOTM4cjc0MWxYNTQ4bDFEUXU5NmcvSVYzRVJjazQ2NXpt?=
 =?utf-8?B?MHY0OElXTUJxWUxPQ2d4cjNiTFpzaklTcS9EcVhKRnVSVFVkVlZlVXBpZHZO?=
 =?utf-8?B?cUF1RGhnY01ERlNGaUNoWVM5ZWhncnI5OUVnSThnYmdYU0U5TmhEMFpjUTI2?=
 =?utf-8?B?ZmZVVTY3MHB1Qnhjc1FuZ21JZ1NWTys5WStHMi9hdjArSmpzZWR3Mm5UNStM?=
 =?utf-8?B?VEQvY1g1cnRHNHV4NDk5N3ErdmdPWTlPYzJtZmoyNnNVQWdxektLS3RSR1NO?=
 =?utf-8?B?NFhmSi9uVGRXT3VFK3Zya1RJdG9nL1dVUDRzbkk5QUJLbEs4SDRoTDlxQUJa?=
 =?utf-8?B?OWVaZ09HMldEU2N0dVNWZ2FDejVpNnNpWld5T2RDeFJqTlIza2pPdE9XcDBk?=
 =?utf-8?B?UFVaRFhqUjZocjdEYTFFYUZVcmJFZnJ5L20xZXVVZE0xTHpZZ01KRGswT1da?=
 =?utf-8?B?OXRzNUhMZHZOSm9YYzR0OGc1c2ltdTlqVXdqMzFIMURxZHc1Rzl4K2RFcm5Y?=
 =?utf-8?B?SnhjSXk1SmtMMDdoK1czY1h3QVpITEZsTmRwT3drRGlCZ2dvYldwN3gxWHR6?=
 =?utf-8?B?RTRnejA3M0x0OG9TbWlTWXhCZ3hZekdhKzRjMmZkUlQvQjEzbFZNclhmNENL?=
 =?utf-8?B?czJaemhuMVBVZnEvckNpSzl2TWtEWk1BbjNMSGNUZTBaSlQ0OVNpWlVORUlk?=
 =?utf-8?B?ellyaFQyZ2tPL1crODJ2V1V3S3R6VWtteWFVdVlOUXdLQkZQTUxNSHplK1dh?=
 =?utf-8?B?TjBmS2lXTFpMREJTeVJpSDhVbm9WdDJRMUpXWW1YSFJEbSsyVlVNcE1HcTdu?=
 =?utf-8?B?eDEvRTdwZ1AyZjBuY0k5enlGK2E2cEJxM1ExdjJTM3k2QkZzTVFwWFlOd3Zn?=
 =?utf-8?B?dU50cTJidUsrUEtKalR3cHBHRHFIWENyU3BVSUdMUmltbkhYMWFRNno2UzhI?=
 =?utf-8?B?ZTNYUVAvUmx3Skx5Mlpwa21VV3oxQUVjT3FlOGtvVXhqdU1hZXI2MDRHS0pT?=
 =?utf-8?B?M2lHOHRVVTNJK21HQ0pRUmJ1WUcyZjJJLzdzMzBYZ0N0ZFAxM1o4RXZCdnRF?=
 =?utf-8?B?Y2hEZ3N2Y096QlJsWEVUdVQyNENKZHJoTk1ESEEvdHo2RHJ2YzJOUDJHcmxW?=
 =?utf-8?B?QzZXS1diK0tzenhUdzhZelRDTzFicW9oWFFjV1IzTk9HaW1iWDE3Q09DMk4w?=
 =?utf-8?B?bEFyRm16UnVhcklrUTJSWGZQSHlnOGtnMjhtK3RMcTJYdGorbFNVU3p6WFlq?=
 =?utf-8?B?UlBlNzBkK0xCc04xajJtYXNkTHBsM01Da2xvWTAwMXdGSzZZd3V1VFVpQjFx?=
 =?utf-8?B?a0Z6eUk5MytSWndCMHhuZkN3UmRvMGlLS1g2VzZaazFIYVRZOGs3VFdOK1N4?=
 =?utf-8?Q?2fV2vF+mNU5vWY1Y3BxYua6Ll?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2951d75-3e25-48bc-e9f3-08ddffc5d04b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 02:05:22.6618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: faLErKVuaasSrWW5qnoAcGClOi6shPLMsjSQrwscgy+twaULaxJnDV2Hxz9xlFYsnYUqMa+4CeqOo1C6ZEHQ9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8741

Hi Jerome,


On 9/29/2025 8:55 PM, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
>
> On Mon 29 Sep 2025 at 17:31, Chuan Liu <chuan.liu@amlogic.com> wrote:
>
>> On 9/29/2025 4:48 PM, Jerome Brunet wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On Sun 28 Sep 2025 at 22:55, Martin Blumenstingl
>>> <martin.blumenstingl@googlemail.com> wrote:
>>>
>>>> Hello,
>>>>
>>>> On Sun, Sep 28, 2025 at 8:41 AM Chuan Liu <chuan.liu@amlogic.com> wrote:
>>>>> On 9/28/2025 2:05 PM, Chuan Liu wrote:
>>>>>> Hi Jerome & Martin:
>>>>>>
>>>>>> Sorry for the imprecise description of the glitch-free mux earlier.
>>>>>>
>>>>>> Recently, while troubleshooting a CPU hang issue caused by glitches,
>>>>>> I realized there was a discrepancy from our previous understanding,
>>>>>> so I'd like to clarify it here.
>>>> [...]
>>>>> An example of the clock waveform is shown below:
>>>>>
>>>>>
>>>                        1                  2
>>>                        v                  v
>>>>>           __    __    __    __    __    __    __    __
>>>>> ori:  ↑  |__↑  |__↑  |__↑  |__↑  |__↑  |__↑  |__↑  |__↑
>>>>>                      ^
>>>>>                      1 * cycle original channel.
>>>>>           _   _   _   _   _   _   _   _   _   _   _   _
>>>>> new:  ↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑
>>>>>                                          ^
>>>>>                                          5 * cycles new channel.
>>>>>           __    __                        _   _   _   _
>>>>> out:  ↑  |__↑  |______________________↑ |_↑ |_↑ |_↑ |_↑
>>>>>                 ^                        ^
>>>>>                 start switching mux.     switch to new channel.
>>> Ok ... but when is it safe to disable the "ori" clock ?
>>> Can you do it at '1' already ? or do you have to wait for '2' ?
>>
>> It should wait for "2", because there is a state machine in the
>> glitch-free mux, this state machine is driven by the working clock
>> provided by its channel 0.
> Then I don't think the 2 flags are enough to make it safe
>
> Nothing guarantees that CCF will wait for those 5 cycles to turn off
> the clock noted 'ori' above.
>
> I think you need new specific ops for this mux
>
> Something that would
> * protect both parents before changing the mux
> * do the actual change
> * wait for it to settle
> * remove the protection


Got it, thanks for your suggestion. I will try to address it in this way
moving forward, but it may take some time, as I'm currently working on
the bring-up of a new SoC.

By the way, On the new SoC, we have standardized the clock tree and PLL
design at the chip level. As a result, future drivers won't need to
include a large amount of redundant register bit definitions. This
should also help improve the generality, memory footprint, and
performance of our drivers.


>>
>>>> Thank you for the detailed report!
>>>> This is indeed problematic behavior. I guess the result is somewhat
>>>> random: depending on load (power draw), silicon lottery (quality),
>>>> temperature, voltage supply, ... - one may or may not see crashes
>>>> caused by this.
>>>>
>>>> Based on the previous discussion on this topic, my suggestion is to
>>>> split the original patch:
>>>> - one to add CLK_SET_RATE_GATE where needed (I think the meson8b.c
>>>> driver already has this where needed) to actually enable the
>>>> glitch-free mux behavior
>>>> - another one with the CLK_OPS_PARENT_ENABLE change (meson8b.c would
>>>> also need to be updated) to prevent the glitch-free mux from
>>>> temporarily outputting an electrical low signal. Jerome also asked to
>>>> document the behavior so we don't forget why we set this flag
>>> Yes please split the changes and visit all the controllers shipping this
>>> type of muxes.
>>>
>>>> Both patches should get the proper "Fixes" tags.
>>> ... and proper fixes tag maybe different depending on the controller so
>>> there might more that just 2 changes.
>>>
>>>> I think it would also be great if you could include the waveform
>>>> example in at least the commit message as it helps understand the
>>>> problem.
>>>>
>>>> Let's also give Jerome some time to comment before you send patches.
>>>>
>>>>
>>>> Best regards,
>>>> Martin
>>> --
>>> Jerome
> --
> Jerome

