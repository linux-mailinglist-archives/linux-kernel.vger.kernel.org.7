Return-Path: <linux-kernel+bounces-805139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91331B48474
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CA63A2DD0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467C42E1F04;
	Mon,  8 Sep 2025 06:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q+mZfoG1"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1266921A436;
	Mon,  8 Sep 2025 06:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314270; cv=fail; b=BPDDhspzjhqaeq7HrzWK0PZ5KZIZ1YBFq+EWTrTyKukrHN4vDPZWQNP+SHysUk6xOsi3U2wuKY8jGqRz0vJ2K8IsbFsaj4e8jH/6diMN03hJ++4arLmT2Rr89mBysIYgjhZUNLnfLa9ghekBaosIhLuAAm80ZU4t2PDOe11Czt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314270; c=relaxed/simple;
	bh=DrQDB/GLicFW5TUno7BLvbTtgLK+o2VO4NwV7s2EZoA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LyI/nQuAjKXgse5h9XSWS0NryR3SHDW23ExYyy+oKl3OpJVXj6xWY7V8x6m017/HQulDdPbmdtoEH/29rFp3ZH78EhLXx8HgkQsDAXydFzE5moQevvAI6X3Dk/wgYHCifuq3zOmK0y3ApWyFteihkPxAc25ezs8UI42C2PpF++M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q+mZfoG1; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHR8A3pPW1Qbza04lGFZ7op1uTOW8CShSjtPVmsl25bJmNOIvXh8zfz7oIQNk5l5dbIJjSn2nYVTiViyf9+7Fu76lUjUKh4PHXRL9NzjboJlC5u7g2BHm7VS2vQis/LNrLVoBVn1+pQhIgshf7b1Li8ciwMOsYeBq4svGotJtKUt8m//b33cDCNghRFrculDGVvdmvyUkz/snLt3g1imRGulpRiCKYX5ScHQKpJMgrYWIQkIKDuxzKbUJHzOqkF+uXydtZjfpXfjHoTf2aCR61lgBSdonUSgAkJDxYRHIm6/OjGBFmidJL96j3H202qJdEj43teBmPO3GKNq4fhkmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plJ2v/6dxB8Uo6ADug6848BNDrzp2rKu90OAcM2o8/Y=;
 b=FWKT84e0mHnd92Js+Dj4OsLtLokuuSHtRRwb1DrcusDVmIBNcXOZZ/mB7iq8Y7vd7VVKGXKtj+Pv0u/vSqnP3jU5QNKPphjRa4IgM+91pykOPwrZIgwNcrfa54JrieWLyxdVw/bRjhCwMg5cTLypc1LAzAYMuVIjU21VG0zM68HdaCzRct8UjgeYQjj0+3aGQTiyRrLur5/fslcA8aQHPkdz8srWGBboVIhsFk8ddAznozwwimo8tB3T0HkhcTkLq/f8nZQL901K7V5zZk27zrD8vIgALnBVgml+aiL172LldBi/NgUgB4cbx+Xmw7LJTBYSHnZQGif2ZS7lbnKCyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plJ2v/6dxB8Uo6ADug6848BNDrzp2rKu90OAcM2o8/Y=;
 b=q+mZfoG1zxzNiRRZn5Jr9YLXYxvNrpMAgMUtCvkku/4dR+d3lIMNier8VnkSs/ieKhc0C21G68BM2BFGJVgM+dnKpvuEhc+X17tBTBhz/HKt0iNkCbDpp15mmj0XlTIs+zP/HCYQEM+NsQMI6x2rZoeZLH5b9Cx14Cy2jHj+9FI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 06:51:06 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 06:51:06 +0000
Message-ID: <4537e452-9eec-4577-95fe-deb8fadf4531@amd.com>
Date: Mon, 8 Sep 2025 08:51:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: clock: silabs,si5341: Add missing properties
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250906201657.1734462-1-robh@kernel.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250906201657.1734462-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::18) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 699c9148-fd50-44f7-45f6-08ddeea41583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkhhYlpFZmJDSzcrZTdXdVczYnRpTXF5aGlNQXEzNHBFV1NWVHd2NWdhZGZ5?=
 =?utf-8?B?cTVrbHJXS3RIZnI2WjhvZTZsbFA3K3htRk0veWM0bnNzWGcyekNTb0pQQUdy?=
 =?utf-8?B?V0tTS3RSZ2ZTcWdXczlTWXArdzZkYk5MeXpFVWRKc0dNVERKUUExWXdBaXEz?=
 =?utf-8?B?QkpJaDVsTzlmV1pNL1oxOHhPMWhxdlRuc3JqYzI5Wmh6WmJEN1BqbE1sSTh4?=
 =?utf-8?B?RDA0SCtkN3BDSzk5TXFlUmRMMHN1aWV3VWM1MmdLdlgraUJQdG95WmZqNDhP?=
 =?utf-8?B?ciszMFRHVGdMRm1ML29UQy8ydkM0V1g4RXpQQldqNzEzYmJvV3ZtK3FwcE43?=
 =?utf-8?B?c2FLMW8wbEZKNHcwckNzYXBIUUc5TmYrUy9TR0JFc04xa2xNQ1ROekpnMFUz?=
 =?utf-8?B?Y1ZwenBRVnE4TStmT3V1ZEI5aWUwZW5oQkxXdjlNYlFzbkpMVVdsNDRHNVQz?=
 =?utf-8?B?enBrdTR2TFBRd3kzYi9tcUxKMWdCQXdVZndYZjB5RFVCVmY1ZENUTDJWV0Rk?=
 =?utf-8?B?M1RIeGtpeTMxOEVKSWsvU3lxcG1JcDJWM0ZBQVVncnRFWlV6WDdGRkhkR0tD?=
 =?utf-8?B?dlBaSzB5d0R4eGNzNVRTTVVCU3NJZHNjdWQxVnRzZ3pVYkdDZm1VbW1paVZm?=
 =?utf-8?B?THdlQndlYnF4ZWhtRmVpL05acWM2MjBHVFNZMG1YSEx0YmVsTGVUajBsZmZi?=
 =?utf-8?B?Qll4eDA2RzFjUUNzVUl2dzlTQS9NNC9xVDVNWndldEN2MmtpSWovTVVoSytH?=
 =?utf-8?B?bVF4UUlHWjFVK01acFpYQ3FSNzcyOVpPa05GdWQxQm9Zc1hMZGxXYVU4SExv?=
 =?utf-8?B?WmJoalFBdFo3RmV1Q25OZjM0Q2dBdEYvQUgvUzF5aisxTW1uSGNFZC9sWm5w?=
 =?utf-8?B?cGRTdnZWcDdIZzV6WXYrNEdwaE53UUdNNjRJR0hseSt4UEhQeDYvK2c5Z2xR?=
 =?utf-8?B?dkhIa1NMN2pZcjd1TTZiWVM4Zld4MUtBYTFGcnhrc2FVWG5vV1ZSV3pWcjBm?=
 =?utf-8?B?VUtIdEZGYjFnZ0pwNEJma3d2Umt1d0h0YXdSQzdjMW9WRlJzVDJMTUNFR0Rh?=
 =?utf-8?B?WDlnUTZPLzUzK2g2V2Rlbmk1TWduZ1VtREVIdXpxbmdvSG9HNm1UcW5ubnVD?=
 =?utf-8?B?VnN1UHRISWh4UGd2bTRLb0t5MzVJd2JJWVFUTCtvVHRqK2VZUS9sdy9WVHhO?=
 =?utf-8?B?R3ZwU1RlUUVLcFMrVy9yQTltd1Y1Ym0vdEpBTytHYUFnL1VZcmhhcFNsSkJ4?=
 =?utf-8?B?OFdMZ2w4T2hXaTYwTm1pZkVsMzNCYTZ6c1hDM21CTW9hUGhGQ05RdnZvTkwv?=
 =?utf-8?B?cUNIQ1YyRzBjZ0tTNDQ4UnhwL0hnalJsNmFrZ3FBVUxIbVltMHdiZnVjUVRP?=
 =?utf-8?B?TE5DR01mVTVhUWZHN3pwL04rZkJkUHE1eTFIVDA4L2VxMDBHY1RQV28ybDJQ?=
 =?utf-8?B?aGNBUGFndkV0M245VVZHL2s3aXRQV3VtaXJiUEZJQmxnR1hWZlViMXJYR1Nx?=
 =?utf-8?B?UkVEMmRybjFUUVc2VlFtUWhPVzVYdDl3MEFvRlNveGlDNUcrVnBzNUdpZGhO?=
 =?utf-8?B?Z1hkdjFGKzFDY0RaK1IzemR4ZU5ZWFlrZWs2Q29JbW1zQVc5a1o0UE5uMmQx?=
 =?utf-8?B?SEYwZmk3Q1JWWTBkSWY0NkU4Vks1VCtDOWRJOHBTaDRza0pPRGtkdG5qaDlR?=
 =?utf-8?B?aHA0MmU2WGhmSWwyOEdlaGU4NGh1dEN3MDUrSVA5YXI4K1JHMzYrS0dRRFpj?=
 =?utf-8?B?R1ZVWGFXTkV3K3hiYjdGNFNWaW16U2RDQkpMcUVweDJMZDFhQlB5T2hxSTA1?=
 =?utf-8?B?UWN5UWJoUUVRbUhaWm55QnFwRHVXUWdEaTZ1WS9vYnJYUUZXdVJJbXpoN0pO?=
 =?utf-8?B?TVVYdHIrT2ZBb2x1UjFtc3h3ZUxqemg2YVdabzdNSngrNm44anZhUmlOR2x6?=
 =?utf-8?Q?nXlQK6WKn5Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekFkdzM4cThxbFlmOUlsUmRZTEdBdWNBT1hZbDBnd3F2QVdIOXhDWUNPRWlm?=
 =?utf-8?B?TGlxYldjNlhIYjZvUlNobWxWMVQxVEFWSVNmcDY5OVNwajRob2x4RUJlVjlF?=
 =?utf-8?B?V0pROVg0azlONjZMYUMvcmtCd1AxQ0Y5blZHWS9HZllpREFsemI4eDZwV1dI?=
 =?utf-8?B?RGg1Q2JJYjFsNXpjTnRTbFVRdVJwbm1mS2h2cCtwOHo1ampJNXBaQTZoZWxL?=
 =?utf-8?B?eFFVWFJOeHZRTnh6bnFUM3ZaYkY1TVlSR2ErY3F5TXJ3dE4vQ05BbjdDaENv?=
 =?utf-8?B?Wm9oWGdKd2xGajdqQnNYWU1mQVFBVzNLTStTbS9IL29QZ01iRFpoSVZQVXlS?=
 =?utf-8?B?bllTZmJ5MTBiTlFEd3FoV0VDSC94TVp0REV6M0ZNcE1ab2xnU3BQV25lMWJ4?=
 =?utf-8?B?bnVveWxOemw3VitRYnJsNXY1TGpaY0FHVFEzcGQyTVRGTS82SWkvUDJnekM0?=
 =?utf-8?B?OE50VUhHSFhoOC9waE43eEx6RTVjeTRkRFNUQVh4NjVDYlFabzVJTndjbEpj?=
 =?utf-8?B?N1lDeEJwYWxoRUVkTVg1UTBlaHVmNFlNcjF0TXdqTHJIbW93elpzbXVuWjVs?=
 =?utf-8?B?cjU1cEdEbEFCMXZKcDF0aG91Z1poZ2QxdzRJaUoyaENEWHhNSXlaSGduSi9v?=
 =?utf-8?B?d0lEUzhxR1BVNFFZaGFGUmsxZUhpakw2VHpjT0VZSHNvTmxvdXA0NnMxczVi?=
 =?utf-8?B?NlJ2MmdkUzNsV0s0YjlKY053amF6emxpV1pxbTh6cWZ5N2tRelJvUlRLWWp5?=
 =?utf-8?B?QVlUMURPMmJMY2Uyc3A5TCtJaE44TFhhSlVyV1dlUGM4Q3h4R2kxSGxqb0Y3?=
 =?utf-8?B?c3BYdjRsd2ZISEtBTkNsc3RITU8vOVU1Tm1BYmJrcWE3UTJtY1VpY2tQNXFh?=
 =?utf-8?B?SVRQY3lZMEdiZlowekh3UUZ0YlJNRGpFL0xiTXc5azIyemgrcUp1VU81V3Y1?=
 =?utf-8?B?RjhDMDhxU2QvZzVUVGJYQ2g3Qm1FYUNJN3NaVU5HQ0lhTW9vanJWQWxLM2tU?=
 =?utf-8?B?NzAzais3cDZRZmh6TnJjVytNVGJCUWFySkJIM1dING1EbHgwa2FZckZHYmZO?=
 =?utf-8?B?V3dpZmRobnVSM081ZC8xVFRDQ05EL0w4aHZrc1BKRXhuVExFVGxkRGx3MUU2?=
 =?utf-8?B?ZGdheDFORnJ1WlBkMlBFSnFJbHVrdFdqQ1ZGcHovVmhsZEhCNisvYWI5eUs1?=
 =?utf-8?B?cEplZjZaWVUzdnMvUFpKM25zTWtGUEFaOEVIZmxTTVJHRWQ5bWEzbjVpNWVU?=
 =?utf-8?B?UzM4V2gveW9yeG56YTZJQWRnUkl0VkV6a2xOZVV2ZmtqSTJRZDZWTFhobDlS?=
 =?utf-8?B?eWFxQ0ZSa2hRejN0MDVhenJIL3lGQllweForVUdDZVQvS2lsME04UmVVSThs?=
 =?utf-8?B?MnhneUR6RmlpREJncjBxMTdOeE5MSHdMTkl4bmMxeWhHM2szckJtRUdMTGtY?=
 =?utf-8?B?ZUN0aThMU2NBUEkzWWR1OVlDcjU3dkZ1L2NXejhrRG5JQ0RLbGZPUWpuaHQy?=
 =?utf-8?B?MjN1RlRzcHYzeEk0UENGZ0E3Z1hKREpGMXl4S1BKZVJ2OW4wMG02MWhaVTVj?=
 =?utf-8?B?a2VNOHBCdkUyWFFIVk9KSmwrbFhKUHFqMnBRV0QveGU0cGFrRzE2K0Rkcktj?=
 =?utf-8?B?ZXlScWhDNHdUVG04SVA1cWZ3SENDN1BqdTJycFRiaGI0d3plSFF1SVBLSjR3?=
 =?utf-8?B?eEJUN0hmMHVzS044ZFlvR3N2MTNsVC9aeHYvQlc4ZXptVmxOLzhVdkRTaDNO?=
 =?utf-8?B?V282bG8wcnVLWTJqYzV2RlNZNWFhTTNFRUFiU3lld1R5eXNQM1E4OFN0MUc4?=
 =?utf-8?B?Q0hMMzUvSjI4bmM3WEx3S2VaZFg0RXQ2SlB4OHNjb1Q5RDdkZ256VEZLTGhG?=
 =?utf-8?B?Qnp4aEFXRkl4N0Z1Ny9uL1htTDJTeEVlTHdPZ3FOamJYVzRnVUxmWWVMUVVW?=
 =?utf-8?B?ZGhCVjJzUGtGaE9hM1FJWjdEUkRUWjZZbHNMZkJ3WUhENUVSMWNtMndKcUdY?=
 =?utf-8?B?SGdlUTlYNW9ZcnNDbVBBd0dCWlYwaExtck84ZEQ4Q0ZXTGNlTzFCcXVMT3B6?=
 =?utf-8?B?UEpMUWtudzNjUUk5RUtMU3RiMUt0MlVSdkMzZnZFYm1EUmtKZWVobkl3eis5?=
 =?utf-8?Q?niHIwXH4PYT+BJdJ95rcUyoXj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 699c9148-fd50-44f7-45f6-08ddeea41583
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 06:51:06.0442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRRQ5J0P5Xle1nfLH9Ue+izFqPJciIVWm/oOWtjM7mN2aeuVjzZAn3LBPpkcf7Mk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748



On 9/6/25 22:16, Rob Herring (Arm) wrote:
> Add "clock-output-names" which is a standard property for clock
> providers.
> 
> Add the "always-on" boolean property which was undocumented, but
> already in use for some time. The flag prevents a clock output from
> being disabled.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   Documentation/devicetree/bindings/clock/silabs,si5341.yaml | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/silabs,si5341.yaml b/Documentation/devicetree/bindings/clock/silabs,si5341.yaml
> index b4f7efdf0b7b..d6416bded3d5 100644
> --- a/Documentation/devicetree/bindings/clock/silabs,si5341.yaml
> +++ b/Documentation/devicetree/bindings/clock/silabs,si5341.yaml
> @@ -73,6 +73,8 @@ properties:
>         - const: in1
>         - const: in2
>   
> +  clock-output-names: true
> +
>     interrupts:
>       maxItems: 1
>       description: Interrupt for INTRb pin
> @@ -130,6 +132,10 @@ patternProperties:
>           description: Number of clock output
>           maximum: 9
>   
> +      always-on:
> +        description: Set to keep the clock output always running
> +        type: boolean
> +
>         silabs,format:
>           description: Output format
>           $ref: /schemas/types.yaml#/definitions/uint32


Reviewed-by: Michal Simek <michal.simek@amd.com>
Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal


