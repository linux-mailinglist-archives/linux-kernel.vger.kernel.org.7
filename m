Return-Path: <linux-kernel+bounces-872322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D26C0FED8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC5A428219
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE3431812E;
	Mon, 27 Oct 2025 18:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fxStWqAy"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CC86FBF;
	Mon, 27 Oct 2025 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761589961; cv=fail; b=WTss5F/Y8MXqIhn4rzbL24oQtU4VBJI9hDrA+7Tx1WrOofwiAnDOSjJHK1YrtY0j9yiCmzsbrlWQkfqoyNBViRYkT5B9NQLzoc6T7MXVc+asj1uQLf8rBbedXLVubg6otvtk0gOyELC8XHTF/Bh5Vfs3i/zZXKRGj4Jr/65Amao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761589961; c=relaxed/simple;
	bh=KpOxHIv3G+TzGXIFojM6t94U8TWcjnw8OHzxUmQVmXg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oExln79I4Xo8apDww8imd9jAlPhr//pfTXrZgbv/EwAMAcO8iuUCOQMD7QS3E20VYh1/kQOwJZqeyb9/PBZ/tN4rDBfR7iSNYyUWEKDsxX/YCpYsYXZ0ydWufkgUsTvyiNPIKmUCn/pGLTMqQUuy43ItxJ3w+Kbr3A9RlSvJT2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fxStWqAy; arc=fail smtp.client-ip=52.101.61.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9AA/99v69XUIVUUD5I2xQFIgonl12oaX7Dq7eV8Ds+ZTiKAjmv3sbg//f8jVolXclDgXQAtjWuB5WxGhr/A1KDKfqM7EDL1wMDi2SEjfiJ32NDf5rjNZX7bVn2w10/NRYidx2C4xIqErSzYZb3TsGBh+oXR1zIDOru4tlb6KL8qwuS28H6g5hVIRcUsGG6NMEM7Sm04QEBmc1MXif1GNhs0jwJk/sRZPsGzRKNSvM2WJgKLrySmMoSwLqDlXj/qgWwuwuPLeM0qDQvSNNbXzkVKnwXFrCbd8r2EgzuC50PrdR5RohiddcpZFv83ssKxu8YjAovG9dB3axzf47XlFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9QqRcIUtDWeHfaE7Btieoouvne4BmEk6KKTBDxuk/s=;
 b=o3SCMZWNU9kxwzMT6mtZPtJwVpp1uusxmVX/wdHaBK9yUb5hQecq29FnuPcZpIvgaCJbCgB9dKGwphT6J+ckkbxK3MawkS8A8fHfPR14mkb7hNhXmWWJ8azmrPTLA7v8tq0+Iz8eP4WUXOqRNkSrb5+oCaVWU0HJQEJnt6vjvE88QuOkN9BO9Z+bZQriDTDHv7f/CMwHCZeEWiaf9Zj1xNgpNUvPzfSe/LJ7H71VFg2nfqr15iQpHWFx/GHALisuxCABSZUerNsXhnTQyrnEUGsLCU952FeddDjPdu8CvqjSJSlCnkB0C1X8W2O0L4no2XeZj7aFSlLtiG77Ww7jbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9QqRcIUtDWeHfaE7Btieoouvne4BmEk6KKTBDxuk/s=;
 b=fxStWqAyRH4WUIJAutaXPmjoYVIdJpeH/XTsMLIGdiVFBK6E/NNAkB9LMU3NV3m4Jr58bV23gqrrnHF7esf+sAYGnDnW7R0MXRv8kDsVN5pgWldhQJbAIp/SKL+Ckk4Kew4Cr5urdQBkeBknhrGvfc3B9dku9j3044+6ky4yu1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c) by SJ0PR12MB8139.namprd12.prod.outlook.com
 (2603:10b6:a03:4e8::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 18:32:35 +0000
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::e4da:dfce:19e5:6405]) by DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::e4da:dfce:19e5:6405%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 18:32:34 +0000
Message-ID: <89afdfc8-9c78-4128-ab73-d569f6ac0c06@amd.com>
Date: Mon, 27 Oct 2025 13:32:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/10] fs/resctrl: Add user interface to
 enable/disable io_alloc feature
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, tony.luck@intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc: corbet@lwn.net, Dave.Martin@arm.com, james.morse@arm.com, x86@kernel.org,
 hpa@zytor.com, akpm@linux-foundation.org, paulmck@kernel.org,
 rdunlap@infradead.org, pmladek@suse.com, kees@kernel.org, arnd@arndb.de,
 fvdl@google.com, seanjc@google.com, pawan.kumar.gupta@linux.intel.com,
 xin@zytor.com, thomas.lendacky@amd.com, sohil.mehta@intel.com,
 jarkko@kernel.org, chang.seok.bae@intel.com, ebiggers@google.com,
 elena.reshetova@intel.com, ak@linux.intel.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 peternewman@google.com
References: <cover.1761090859.git.babu.moger@amd.com>
 <dd444497162c38f81858ba3b3f95c29058d38232.1761090860.git.babu.moger@amd.com>
 <b28ed9df-03cf-412e-b300-2b8499c30fc8@intel.com>
Content-Language: en-US
From: Babu Moger <bmoger@amd.com>
In-Reply-To: <b28ed9df-03cf-412e-b300-2b8499c30fc8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0090.namprd12.prod.outlook.com
 (2603:10b6:802:21::25) To DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPFA3734E4BA:EE_|SJ0PR12MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: 34cb3a6d-d5a2-440f-f009-08de15873271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEs4NVptRUx1bmdiQm0wM1oxNklmTndiY1Jhd3VpazluRGFXMmN3QUgyOEI5?=
 =?utf-8?B?Z1Azd1F2a2tCdFBETmdBRklETzNzUFZoNHZjM0YrMnpMV2tzcWVoV3JpcnQ3?=
 =?utf-8?B?eERkdGNMekpJT2RzU3E5MStkWGJvRnlWRDg4WjVmL2gvVy9haHRrMTlSU1NP?=
 =?utf-8?B?UHl2dUJPa3Brc1k5bzBMZCtnRnQ1NStHU2VWZmJKL0psZWlyTXVOa2c1ak0r?=
 =?utf-8?B?d1JDR1poSTZiL1l5VmxkK1hyRUNrL2VGRzJDbDFMeGFleDNXQUMrSGthU2U1?=
 =?utf-8?B?MFBoY2R0VXMySDJEUzJBN2d5am1RUzdFUmdWdjMvYWRwS1BFUzBwTVA5aFFx?=
 =?utf-8?B?VnZPcWRaUEkyUm96SFhLb1RsVWhkc1JGdGJEc083aVJrMTJBN09YRUZPM1JH?=
 =?utf-8?B?UjRnRmRyeE40V2s4b3dLYktiWCtwQ3BHSjJqV1VwdTQyM2JXS2ZrQXBTb3N4?=
 =?utf-8?B?dnhwd0ZPVzI1b0FhT1F2VlZDMlY2d1lMcVd1dDRDVWQvOWl4VGtVVG5ISCt6?=
 =?utf-8?B?TkxHQW1KNVZEWGo4QmRvWE1CdlZNTldHd0ZLcnBaQld3UE1zWUxING1vZVpG?=
 =?utf-8?B?S0tEL2UyVVhxaXhTSi80dElrWU4rVS96TFJqdlVpSTBmaW5hQVk1dUthbkZC?=
 =?utf-8?B?TTZyNnRXNldYOEZaVHVUU2YrK3NwY2kyaFRnMlhCS1c5UThpbGhvQzFyMDR6?=
 =?utf-8?B?THh5T0MvS0pLcUg3QWJvYlNjMHhVYUhoa0VNZUpkMFpiZEszdEE5YjRtT3Nw?=
 =?utf-8?B?RXkxci9CUmo3QjBjVHNjZGxzZXEyY2xHOGRYRGJ2T1l2NEZPZUI5cFhpM2p3?=
 =?utf-8?B?anFtOGRUUVJmbHY1TVdtSk1IcGh1V2VzQXpvV0o1UjlZdGpmSHBQS1VBaWxK?=
 =?utf-8?B?bHdlY1o2QVlzVXpIaUozWW90UVVtaE5ZTEVNb1htNXY1SURiaG1kL2ZnV2p6?=
 =?utf-8?B?QkhiYlU4dFRIUnpaOTg5U3hvcG9XeE8rb0JSMTFOZVN3YXE0N0VoREFFeU1i?=
 =?utf-8?B?Rk1FOC8xMVRQbmg1Q3JOSkhlQ3h5V2c1ZW9xRW1jazRWTVdBRXd4QXVpc01N?=
 =?utf-8?B?OEdTYjNKOE1mcEdlaDFkaGkyeEV0YTdFTzNRdEZ4NU1rc0hIUW1VN3hmdlpw?=
 =?utf-8?B?NHpLWVVnbzY3SWVROWg1SG9EZmNuNlIxTzEvKzRaaVBzc3RxUzNhZFFkMmhP?=
 =?utf-8?B?NmtuMWFGL2NpL1R2bHNJNnR4QjdGaWMybEp2blVNZm9LcDJGZHF5cEljNk5x?=
 =?utf-8?B?WW9Ld0MvWUp4V2YxT2h0bko2OC9tcFdZQ2p2WjViN05BQ0VLS0dYN0JRODQ2?=
 =?utf-8?B?N0tBOVg0dUlqMFhWeTkxNVZiUFVCUmV3RGdwSmUycTZXWGZGM204bldUYmRE?=
 =?utf-8?B?b21uT3VQNk1zTXgyYnBkM09TK3pCYmQ0cDNXN1U4T0sya0dOa0htK0FmT21y?=
 =?utf-8?B?OWJ1TVpWTitVeTdzeXBNQlduQzlUemJQSWZmZXIraWRFZlBDYmRnMTFaUGt1?=
 =?utf-8?B?YWxVSVlPd0FYQy9ucFYrZUl2TnBHVm5HSk84a1hkZnFQMFRoVVZPM0hoRVlL?=
 =?utf-8?B?S0ZHRXBjekVJeDlBYUhKSXc5aUZkK240ZVZNT1hKdFNEQ0NBc3phK0Z1Mi8z?=
 =?utf-8?B?S1dJelhpcmtTZE9KejVUUXM1ajZZanZZY3kzNXlvaXM2Q0RGNzM4L2RMNTNG?=
 =?utf-8?B?SlpGMm9pNXQ1ZHZUUkhxVXRFK1UwUmlKcHJwMlJVSHhhNXNiek9sYWlPdFl0?=
 =?utf-8?B?c0ZZZHVvVXFDU0xITUtNZjh6MzdpbDNqNWRJQnlWeloyYmVzYlN3c0lYZEd5?=
 =?utf-8?B?a3pSeE8vaWVmV1Q5dEZ2bC9kbFhueE1uTGFFbnJTaXdWUlNzOGgxazI2T2tp?=
 =?utf-8?B?QU9nT3RnSXZGVG8ydFZsYnVSaC92N2JWTFEyMUs3V2ZkQWdYSXpkYmNVNURr?=
 =?utf-8?Q?34M+5bWZ21iZvlRYm2IMH1Cm/FaZVk5y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPFA3734E4BA.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUZKWXZ5cTBSa25OV2VGQ2o4QkV4c1lzR3llL1BGb3h5bVlVK1NYSEplSFdz?=
 =?utf-8?B?bVBHbXFoYkVrV1c4dWEwVGxzY0c5Skl1TUFLWk5kanRiWjVBMkwvNFBrNFhD?=
 =?utf-8?B?OVZ5T2tMaXZTdHlGL2NYblE3ZlFsZ0gzeEdDWDVVWklBdGp6K3ZFQlBTVlVK?=
 =?utf-8?B?NEtlTG81QXJtNGJuYS9xREtSMW80Rm9wR0c1S0NZZ252SXBUaXo4ZWRqQzQ3?=
 =?utf-8?B?dkJoc3BVUFA4S2dkT0lJa09YMzV1Qml1SFhQbnprYWo5QUt2OEtzY2RvVWp4?=
 =?utf-8?B?bTJJSVZhQ29xVXFJbG00bXlBRktjVkQ4TzNFZE01T0QwZ1JCQkFlOFlqYUZw?=
 =?utf-8?B?eHNHUGt4V1hLZ0Vkazk5WEx1V2RhcEoycEMxcGRuRmFrY2RESSt4aWhZRW1i?=
 =?utf-8?B?ODRRQldqcmg5SGNpVU9HZ0kzWThnWlFWUlFTL0ZvNHo5T1RWS2NoL2VXckZK?=
 =?utf-8?B?eWRUaGxPb1h4WWxia0YzcFpaUjBtQ25xNmVudWEvMVJmOFVYWUxmSnk0cVF6?=
 =?utf-8?B?ei80N2ViZFYrUHFmVE80aGtGTzhRWTBiLy92R0FGQTJoVUxsL0ZzSUpCZVNq?=
 =?utf-8?B?ZjJzbjMvZ2RmMFl6MVg1RTUzSFpEanZ5a3Z6UXZXNTE5aGR3SEkrVk9TUkxC?=
 =?utf-8?B?azdDdXFTdkN3SGVCZzdPQTNOTmtHZnAzMXIvL3dFdDM1WlQ1Z2dVOG9KblU3?=
 =?utf-8?B?aVlpYVduaFY1NFh2cDdRUDh3N0gvRlhnMDFXQTkvditZck9UR0tpR05KUE1L?=
 =?utf-8?B?VkhZaE13WTBaOGlvQlZDWTAxREdyR1Z5NGJmeGZiR0tQc01qbnVjWHE3WE82?=
 =?utf-8?B?VitsVGlPWjU1NGxialRueVdsYldCcXZzM3poWUc3NXp4UEd4aXViYVNmNjM3?=
 =?utf-8?B?MUxpcEp4eGhQd2dUdkdVN0J0T3VmTi9PeFB1OE9sSUNjSVZwQkV3WFFTbFlK?=
 =?utf-8?B?ZCtZZ1Q0QzJNZitqU2s1akkyTHVoWm43bkdvb1Ywc2xMdjhkNkFKblQzNE9N?=
 =?utf-8?B?VGRmS2hMNDlzMFZqbUVRWitETzg2VzZOTTJ0eCtLMXR6UVpmdkpHa0xGTHpV?=
 =?utf-8?B?akhRbGhWbWRkOHlLNXNUOVVtK3k3aXRCNXFOeml1NUhPK01jNVZXSm1lUDY1?=
 =?utf-8?B?cFRhSGRoMUFBVnJGdVJGcFlIcEpaazNNVkZEQkJ4ZEpkbFlnRjBIVFQxTHlx?=
 =?utf-8?B?MmdTOTFxZWw5RnRxSU1iZlJzdEFPTWdzUStvSTBsNyszTG1jV1VZWThFdTNB?=
 =?utf-8?B?UThFSWVrb2ZoNmdIVjk1SCthWHVEU28raWF0R25OQU1TYllJTnMwZDdWWm5u?=
 =?utf-8?B?bGN0ckZZSDZQbEc0OVJ1V0M4YmdKbUpWODRBMStEYU13UCs3L3Y1djZNOWJa?=
 =?utf-8?B?Q21IVGRyRGlyNDF2TVZkbit5b1JHUUZPQURaV1Jwa3FpVWNNNnkzbXRSUUxK?=
 =?utf-8?B?c0JjWmZ1TVhJbm5EOVFldVR4MGxhYzhEMTJiTEFlVnh3WlpnVlVPbHI3Y0da?=
 =?utf-8?B?TEtGNXp6LzVXb1Y1dW12dEprVzRhRkFuTmRMNUsxSjNtWWV5b0lQb3BzdElo?=
 =?utf-8?B?d2pOaUxjaU53QWtCVWVLZXpxbTdUVThPc3R2TFJ5WTZVMTBGSEpFZURLVlRH?=
 =?utf-8?B?VE5iUUJwOUJ5N3ViZ1ZBQXNlQUdoMy8rQ0xkcnhTRXVrWHdHVEFCbmM4QXpt?=
 =?utf-8?B?VjY5UmRjcWpQaTZDMzVYUVdMSTAxUDduSndxcVpFelRkeUNRd3VHdGRxUFBX?=
 =?utf-8?B?Qk13eVVhUldjUFlnUUlIRy9RS0dZSXh4bWhwS0VTbzJ6MGFMdzJEN0RGTTd6?=
 =?utf-8?B?OFFNMUZFbGJpSi9PeWwxWGJFTlBndFQ2NlpMUFpFSGVWVUpUVVhyMG5hNzZF?=
 =?utf-8?B?SHVncXI1T1RxVU5zc2QxUjFBK0xBNDc4MkYvYzBKWlRtV3ZZS210Y3RLVGp5?=
 =?utf-8?B?SG9jZmhmWlFpcldOSDROb1RnaVZyak13T3V6ekdrOEJqdWlEWjFYRWVFanRq?=
 =?utf-8?B?TVpzYWlBdk5jcFpTU00rSklGTDM3QjBlbnJyNGY2WGMwREpoRzVwdXpHOHhE?=
 =?utf-8?B?Ry9ieVpRWU5JS3l6dFdNRjErMkxPUkVKTytwcTFXaVpteWUrMDZMb1lWanhn?=
 =?utf-8?Q?wq18=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34cb3a6d-d5a2-440f-f009-08de15873271
X-MS-Exchange-CrossTenant-AuthSource: DS5PPFA3734E4BA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 18:32:34.7492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+WtjIwcmhXoc2uDBew049FHh7TiAyXyGgKQyXJ1xFot5sTlsOwLl04PbiSWdQci
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8139

Hi Reinette,

Thanks for the review.

On 10/24/25 18:43, Reinette Chatre wrote:
> Hi Babu,
>
> On 10/21/25 4:54 PM, Babu Moger wrote:
>
> ...
>
>> When resctrl is mounted with "-o cdp" to enable code/data prioritization,
>> there are two L3 resources that can support I/O allocation: L3CODE and
>> L3DATA.  From resctrl fs perspective the two resources share a CLOSID and
>> the architecture's available CLOSID are halved to support this.  The
>> architecture's underlying CLOSID used by SDCIAE when CDP is enabled is the
>> CLOSID associated with the CDP_CODE resource, but from resctrl's perspective
>> there is only one CLOSID for both CDP_CODE and CDP_DATA. CDP_DATA is thus
>> not usable for general (CPU) cache allocation nor I/O allocation. Keep the
>> CDP_CODE and CDP_DATA I/O alloc status in sync to avoid any confusion to
>> user space. That is, enabling io_alloc on CDP_CODE does so on CDP_DATA and
>> vice-versa, and keep the I/O allocation CBMs of CDP_CODE and CDP_3DATA in
>> sync.
> CDP_3DATA -> CDP_DATA

Sure.


>
> ...
>
>> +ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
>> +			       size_t nbytes, loff_t off)
>> +{
>> +	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
>> +	struct rdt_resource *r = s->res;
>> +	char const *grp_name;
>> +	u32 io_alloc_closid;
>> +	bool enable;
>> +	int ret;
>> +
>> +	ret = kstrtobool(buf, &enable);
>> +	if (ret)
>> +		return ret;
>> +
>> +	cpus_read_lock();
>> +	mutex_lock(&rdtgroup_mutex);
>> +
>> +	rdt_last_cmd_clear();
>> +
>> +	if (!r->cache.io_alloc_capable) {
>> +		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
>> +		ret = -ENODEV;
>> +		goto out_unlock;
>> +	}
>> +
>> +	/* If the feature is already up to date, no action is needed. */
>> +	if (resctrl_arch_get_io_alloc_enabled(r) == enable)
>> +		goto out_unlock;
>> +
>> +	io_alloc_closid = resctrl_io_alloc_closid(r);
>> +	if (!resctrl_io_alloc_closid_supported(io_alloc_closid)) {
>> +		rdt_last_cmd_printf("io_alloc CLOSID (ctrl_hw_id) %u is not available\n",
>> +				    io_alloc_closid);
>> +		ret = -EINVAL;
>> +		goto out_unlock;
>> +	}
>> +
>> +	if (enable) {
>> +		if (!closid_alloc_fixed(io_alloc_closid)) {
>> +			grp_name = rdtgroup_name_by_closid(io_alloc_closid);
>> +			WARN_ON_ONCE(!grp_name);
>> +			rdt_last_cmd_printf("CLOSID (ctrl_hw_id) %u for io_alloc is used by %s group\n",
>> +					    io_alloc_closid, grp_name ? grp_name : "another");
>> +			ret = -ENOSPC;
>> +			goto out_unlock;
>> +		}
>> +
>> +		ret = resctrl_io_alloc_init_cbm(s, io_alloc_closid);
>> +		if (ret) {
>> +			rdt_last_cmd_puts("Failed to initialize io_alloc allocations\n");
>> +			closid_free(io_alloc_closid);
>> +			goto out_unlock;
>> +		}
>> +	} else {
>> +		closid_free(io_alloc_closid);
>> +	}
>> +
>> +	ret = resctrl_arch_io_alloc_enable(r, enable);
> I missed this earlier ... if enable == true then a CLOSID would have been allocated
> at this point but resctrl_arch_io_alloc_enable() is not expected to change the arch's
> state when it fails. io_alloc arch state would thus remain "disabled" while the io_alloc
> CLOSID is allocated. io_alloc CLOSID should free'd on failure of
> resctrl_arch_io_alloc_enable() to address this scenario.

Sure. Will add the check:

ret = resctrl_arch_io_alloc_enable(r, enable);

if (enable && ret) {
           rdt_last_cmd_puts("Failed to enable io_alloc feature\n");
            closid_free(io_alloc_closid);
}


>
>> +
>> +out_unlock:
>> +	mutex_unlock(&rdtgroup_mutex);
>> +	cpus_read_unlock();
>> +
>> +	return ret ?: nbytes;
>> +}
>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>> index a18ed8889396..26ab8f9b30d8 100644
>> --- a/fs/resctrl/internal.h
>> +++ b/fs/resctrl/internal.h
>> @@ -390,6 +390,8 @@ void rdt_staged_configs_clear(void);
>>   
>>   bool closid_allocated(unsigned int closid);
>>   
>> +bool closid_alloc_fixed(u32 closid);
>> +
>>   int resctrl_find_cleanest_closid(void);
>>   
>>   void *rdt_kn_parent_priv(struct kernfs_node *kn);
>> @@ -428,6 +430,15 @@ ssize_t mbm_L3_assignments_write(struct kernfs_open_file *of, char *buf, size_t
>>   				 loff_t off);
>>   int resctrl_io_alloc_show(struct kernfs_open_file *of, struct seq_file *seq, void *v);
>>   
>> +int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid);
>> +
>> +enum resctrl_conf_type resctrl_peer_type(enum resctrl_conf_type my_type);
>> +
>> +ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
>> +			       size_t nbytes, loff_t off);
>> +
>> +const char *rdtgroup_name_by_closid(int closid);
> Could this please keep the closid type consistent as u32?


Sure. Will do.

Thanks

Babu



