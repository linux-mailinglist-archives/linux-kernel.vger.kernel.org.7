Return-Path: <linux-kernel+bounces-863037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6E9BF6D82
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18B51894650
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8BA337BA2;
	Tue, 21 Oct 2025 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="BHUZwM/E";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="JzB5Xykz"
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36067334C1F;
	Tue, 21 Oct 2025 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054038; cv=fail; b=YFfDPx6ciSGDhEAicfmEDkagn/ds5XW/YBru1DUSeMkRMF4H9XTE2QFSK1x4arA3TP9y0TsWqXcVsYaJXpSXv49rGoE0Jh5o5fBnBtp+kDeU/S5V+Bv9QOYgcDM6k/uapCsYPjq3owKBCYYfIQvrkzQVpfFCiF5A0kQSLy3Gpvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054038; c=relaxed/simple;
	bh=vaWOszRMG6sZriishly7BpfgyJL4PUQ+6okVu9TyLa8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=APtwzlbRneChu9tj+GJI4Cse+X2bjP1pJPwlNfp7R7yLlr7jjhJzH8t4+NEMCENfQmbQT7lFSd9itJNafChAOrOw/HVGyHmknJ7wckFYYIQob4XIWKWrsPzdyGJENfVL7UCLrvufPENN/67D6eqMUYl1GiO5tLy03kejQ1pUhNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=BHUZwM/E; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=JzB5Xykz; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59L0BBrd479037;
	Tue, 21 Oct 2025 06:40:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=vaWOszRMG6sZriishly7BpfgyJL4PUQ+6okVu9TyL
	a8=; b=BHUZwM/E87HN+ZfsUscqE8YXn0vhGF+0G3C4B+UOcbDkDja5KxBNObT1W
	AZFUsrK2ijjbKpYtioZBq9TQAkh2OD8dE82rf00AksI8BJd0fHgLHLtrXfFxqTzV
	WXP1SS1g6R2V+TuPpIfELcOJJeKtX6BwAt5Woo0aRyIwIDYfQiLIZ9mTJJbQ2qRs
	Y4gCw+ArlgAX/iKeJm415e70d9+ixKFV0/hUtlalC7mYW4S3oXtzPkH7MEIDgg2t
	L6E6I9V7DWhQwjIu+cyZpNCHCE2cmDkVTSacjQiJRAn/bg1QsDnvRJBEvdapa0lH
	7WFGEJuR4eH+4g6AhY2F30+r7mDsg==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11021103.outbound.protection.outlook.com [52.101.62.103])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49wydkh3bx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 06:40:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/CPwUcUp0r6O7uXz4+hmoRNcjqJ2e328r7r688H2NJhwXqySCxXYmZUM9ebw9VtnonLpstX6ITa4mCTmvCBNoZJ79bmS/dOPJS+WEwKko+3U0KRANcWckRTXHG8w3xXy0LWpVyuZBxHYZgjd0F0yoF18c/0b23bOirz1vPpCLI7vDfS5auU/Jqd9T5C7Wp6t/VE8E1+cVU3zBDuv9zspVSAGzz59jOZ6q/QoOaRwlcIYsWBje3YEgQrGCAgYaB5ecSFlJZJlnYCGmYir1gzV8yGFmHjrvSZl+cG59KQBPkEzajnKjnnWLOPCbk4sJVQh3QXehLUaRPZ1xUrfMoPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaWOszRMG6sZriishly7BpfgyJL4PUQ+6okVu9TyLa8=;
 b=stQLA8h4ENC3dXnQGlQJ63rslVqxrrYZ9WuyjS8qecKP5AVeZ8JPiOmJHYh4UCfDYpeAc+4xZoAjwGvj6hsZ9Ec6/ef6Z1QrqtniZxlK/yBnYKqoz2TQkEaKJZx0uJh8A2/xTTf71Xy5poXqDXYT1LzkolBov8F+VowDFoAMmpCrpLrnW4Pw4DD4zpALOFUlpTL/y92oavQsbSrq9RjZlC1SPD8PjJF0NMrGL+2Prj1PKg+ukseyb9zLvECBHMAsfJU/CcpGLbYp1D6Wbp7YszjyxH6yGCH+fVjnMVowvMiwAp84JCugI56cgYHkmt/51UpyYJJRB+PT58qw/fgZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaWOszRMG6sZriishly7BpfgyJL4PUQ+6okVu9TyLa8=;
 b=JzB5XykzK7aaTEwNItWtZsZqqZ/sVY53hLD5Fgd5auOi3c7lcG9BjLwIfRxx3MMZUwrn0v/u+GqD2Wmf/mtKRj4EMby02zT7Cvmg6HLOa5kc9yzEm+q5DiwcK3LYCCIyM2awiyl4i5/xS7GIcP+10XYAaepIRDWFXOZByHnR0XsugJFoF6bRpajHv0IV1t1ZxVBoqJ0MDkkSNiTdmHwAVs7R5wI7qKSO8mFkYz0q7iLiKvzNDFRQD+qvcWqV5KTQDRIwM65KyWUaeUelXFNyKwEUOJIrDZWnwlrA7gf1npgzi9XUTC3WR+7VnuDMF7by/am9XyvUuj5bPu+GNl5olg==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by LV9PR02MB11181.namprd02.prod.outlook.com
 (2603:10b6:408:367::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 13:40:01 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%5]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 13:40:01 +0000
From: Jon Kohler <jon@nutanix.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
        Josh
 Poimboeuf <jpoimboe@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Ingo
 Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Brian
 Gerst <brgerst@gmail.com>,
        Brendan Jackman <jackmanb@google.com>,
        "Ahmed S.
 Darwish" <darwi@linutronix.de>,
        Alexandre Chartre
	<alexandre.chartre@oracle.com>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/its: use Sapphire Rapids+ feature to opt out
Thread-Topic: [PATCH] x86/its: use Sapphire Rapids+ feature to opt out
Thread-Index:
 AQHcPv2ViIPRgARTk0+c7Boi5TEVVrTLdggAgAACrgCAAAzWAIAAGO+AgAAJB4CAAPrcgA==
Date: Tue, 21 Oct 2025 13:40:01 +0000
Message-ID: <1D952EBC-CA16-49FE-8AD0-48BCE038332B@nutanix.com>
References: <20251017011253.2937710-1-jon@nutanix.com>
 <20251020194446.w2s5f6nr7i7vw4ve@desk>
 <EA2E1D80-07A3-459D-B330-A667821E7C05@nutanix.com>
 <20251020204026.a7xuhnagsqo4otpx@desk>
 <225134fd-033f-4d63-b88c-772179054694@intel.com>
 <20251020224159.xkhfs3phai5o6rzb@desk>
In-Reply-To: <20251020224159.xkhfs3phai5o6rzb@desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|LV9PR02MB11181:EE_
x-ms-office365-filtering-correlation-id: 275738d3-3855-4e30-7ed2-08de10a755af
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Nkk0dFlrOCtRY2g2SkxaZEJaeFNRc09aVTM1d01QVUs2K2trcjQwMm1iMnV1?=
 =?utf-8?B?c2UzWENmZ0pNN0xtT3ZhQWNVQXZSbWRXUWxySC9TRHNZQU1aV2Q2Um9YSFJJ?=
 =?utf-8?B?VWQ5dXVVMjNVNkxJT1dVN1hiR2cxWnhsdnRvRnI1eTdMd0FKNFpIWGhmMHlH?=
 =?utf-8?B?MW9QeWdTWExOeGk0cmxubSt6R1ZQYzUwQWd0NXJ1ekoyYy9JcXNaZy93VGVR?=
 =?utf-8?B?VmVzYmR2UlZvbUJ2eUJ1K2YralJ1TDE0cUljcWQzQXMvdWEvb2lyVWkvR1g5?=
 =?utf-8?B?M3kvdjJBNTVtZUlUcU1yYU5KSm5yNjV3Yk80WXlyZ05URlNmbkphbW5sUkZH?=
 =?utf-8?B?YjUrT3V5ekdpTE9IN0JpMDlHa0VvVytMK2lFbzNHcWlxVTd2V2pab0pPUXNS?=
 =?utf-8?B?ZWdjUjd2cnNTcU1GNm5MU1F2b3psSk0xUm4reksrV1ZZRmh0ZkpRRTd4bXlM?=
 =?utf-8?B?cWZLd0JWVmhCSG9kSkhwczhMaithbVgzYkY5ZlJwNGlDdzZ3eVEwUzFad01N?=
 =?utf-8?B?VkdsN1F1amRrem5ObmRsMFNVR2Nxd0RkUjErUEJFdXlvVFdJbDdJMlFqWmd2?=
 =?utf-8?B?WU9vYWtjaE5OcW1zd0NNZzdpKzYvZDBrY1JjMjVRWlBuL0g0b3lsQ09zajcx?=
 =?utf-8?B?TkMzT25FTDlPUEcvU0xRKzBKUFJOU0J5TmRMTVJGckkzR0pEL213SXh5TFIy?=
 =?utf-8?B?SEphaVJpUjZZZksvanpGWitjNjE5RFZJbGFWNG8xRWd6MDNQSkdkeEEzTkxm?=
 =?utf-8?B?VXBsa2ljMUNiWXNvME91N3F6MFdqa3JQRUFHay9ZWFQ4RG5wbEhxQ2RUc0ZD?=
 =?utf-8?B?VjVFYzJDWHhSL0NPYnZRQWRvKzIvbm5URU02dXlTbGtBMGdlS1A0WjYzeWsw?=
 =?utf-8?B?OWQ4V3pkNUdQeTlBYmJoNFlBUkJkVjFNQUZseEJEK3N6WHhmanN1SzhhTXBS?=
 =?utf-8?B?cU4zRDRGY21nN3U3UVl1UmY0Vk16djRKM3AzMGdGd3RXRVl0dnlURmpoMHZS?=
 =?utf-8?B?TitweE9Ud1lLRnNZRnBqa0RFa3ZiM0ZwdkNabFpUQ0diSkhKa0NIOW5HV1J2?=
 =?utf-8?B?bW1SeE9wQVpYbEI4dkFqVXgwbXpKb0dWNkdIT3IyYzRVUkNXMTFtaEsvaGw5?=
 =?utf-8?B?VWxRMzBjSS9MeU1SNnp5dlZqRjBlNE82TThGZlhlRkdYYlg0UnNjKzNqaUU5?=
 =?utf-8?B?cEF2VTNhc25ZSTdxTXFSOGhCQXMwd2JkdXo1SiszcHRIQ0Zzd3ZkNWZhUUtZ?=
 =?utf-8?B?N3UzQm5jcExCdmU4V0RNMzhmK2RBQmNPbW8vNmQrYmRIZGZ5aDJqK09Cdmd2?=
 =?utf-8?B?Q29ZdStQQ1pzQUlDQlpzdE5yN0htQVVWOERnelV5NWJrQXRFMHQrVitIU3Yy?=
 =?utf-8?B?bnpEUDUvVnNGVGNocE9ZUDZDeW5UVWhJajFycGloRGpyM3ppUWVnSFF1RmZV?=
 =?utf-8?B?YlJOUzNFbEFUYnNVT1VpUWN2R04weVRud2N4cjFtZlNuQXVzclBBK0pxckVR?=
 =?utf-8?B?WUQycGhGbWI4SUJWYkJkdXVDT2JRaGxVNXFsTUwvWkpnZncvMmxqRGw0clhE?=
 =?utf-8?B?RWticllYOUFFUm9SRjZwUU4wUDJYUGdHSU1BYWpFQjEzQ3JPU3FKRGMyUy9G?=
 =?utf-8?B?eFlKZVNId0NWL21lTXZwN2hiWndhRkt0MFd0QU8vdi9kc013b2VPWnlwRGtC?=
 =?utf-8?B?WHo4S1ZuWTY1QnhPZ2NWcWtUditoMktMWXZBMWkxQ3NhaUV1ZnRqamJiNVJ3?=
 =?utf-8?B?cWJydTVhTjRkV25xTGd1T3J1VTU5cFBzTVJYTlFNWHRxMm54U2hVelBTN0x3?=
 =?utf-8?B?V3NPSUFBeFhOVHVOc1pOekxWWk83WlB3SzFObW1tbVpsTVpQdDVNK1Y1TmI0?=
 =?utf-8?B?a2w4UVFibmhmN2VQcGt1ejlyKzBDK1ZLc0JQYXhmZC9rbzVVMEJZQTgwdklY?=
 =?utf-8?B?YWdQTk1qUVU0R2gySVZuMTNTRlNUOEFPWjJWZnBXS0ZVYVB1ZGdvVTc4VUZG?=
 =?utf-8?B?VDI2TUgxUVFtcWJ5WisxSDVDY1REVmw4cmF0RGh2clIwS2xKaFdnNUloWWNy?=
 =?utf-8?Q?BLIaCo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(10070799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bzJ2QXl1MFJ1L0tycEM5b3R4RjdvM2xBcjUwTFcwT1RWdmNlam45ZHZoTVRG?=
 =?utf-8?B?RDR2eGowTC9MN0p4ZXFLMUZ6K2tNcVNxUmVJVk9GNDE0Zm5jNkFNMW9VZzJy?=
 =?utf-8?B?aE5Ed1BoWXhrVjVqSzlqamZvMnRoUjVRMW8xclppS2YyNld6RmYvZzc0N0FX?=
 =?utf-8?B?SW9QSXlOZ000eE1vWk9VUjhzV1VNODB4R3hMdCtqbDNXZjJrVGgxR2JnRWhQ?=
 =?utf-8?B?UzB5TzF0ZzNzbTFSbmh4WUQ4eHhwTHJlSnRmT0ZoMmNYMWhXLzBNdFBPVjUw?=
 =?utf-8?B?clJkUmdzSC91WWkxZEZ3TzBtSU1Cb3h4RG5YcHNFcDZHbGQ3d3c1SzgrNGRo?=
 =?utf-8?B?YlVuZlNPTmFyM2ZSSmtSQ1BJSDRqQm5jcnJXMXJHekFnc3IrVmxTcnViYlk0?=
 =?utf-8?B?RFh5R00wNDZEeXh6TkZmdU9SMGVHeW5iVkRXZ1pJREh1Mm1MNVF0U3p3eVE4?=
 =?utf-8?B?OHlEUmdNWW14VktvSk11MGJDYTBzOGhBMERtVUcveitGL1RNMzYxSGpVYmlx?=
 =?utf-8?B?YlNiTTBOYVJvMCtJWTVhT1pOZmhTcEljQ1lTSmljOVNycG80WTFramdYNTY3?=
 =?utf-8?B?dnVKcXZaUXNoTHltU0xwNzUzenN2WW0zNXpldXhCRzBRWktkVGg3UzBGNnM4?=
 =?utf-8?B?NmRRZU9zTkc0UWNzbksyNEI2TjhrZnFGMFlsMFVlSFlOTkE2RVk5SU9kY2RR?=
 =?utf-8?B?TTNWZTJUR29kbGxUanZoSVM0bDB0VjNicWd1dEtLdjU5UG1jRElIZzdzZzQ4?=
 =?utf-8?B?dlc2NkRQbngvczNuMEwyOXJHb3ZpaHRocVVNUDltRFZ1eTdINThnOFdFUkFr?=
 =?utf-8?B?NDFRd3Erb1RqUEc5cG85YmhHeEd5WlorV0JKUThOV2ttY2xESUp5Q29YL0xn?=
 =?utf-8?B?TEhtMEVxRlZnUkFTYThXNStLb0x4UEE2b2s0U2piR3VOQ1E2Wk1OM2RnakZG?=
 =?utf-8?B?TnA3UnVqQ04yZGlCUHd2VGZFZCt4a2xlNXh6TGJKNG8yM284Y0Z5MEF2YmQ1?=
 =?utf-8?B?dkFGZlcxMzdKN3VUL3BTQUJVTnlFOTltMm1KWjFITEx2ZjNDVTJmb0VOb3kv?=
 =?utf-8?B?Zzg4RUNmUnRtTHlLaWhnSS9WZTRRalAvOEovOUp3WEttNnhicjZGS1JET0Zi?=
 =?utf-8?B?VlFUK1k1SEZsYmU0RXB6K1Z1d1licGRQOFJxQmtKakVsenVOcGZlTWdGdDQ5?=
 =?utf-8?B?WG1SaXBza3llbU9tckozRmlzcy95cnNqUzlkRk5sTWF1UnhvRC9LQThHSmtI?=
 =?utf-8?B?SWVVRkxuTlI0M2F2S0dVSFZPOEtnYlF1YVZqU3Y0bWpNUmlQdXhPVlhhdytP?=
 =?utf-8?B?TjJKeXRZcnZKNDJERUU1QitMRVBjMGU3UEJOYVZPNDVWR2lMTXA2N0dwanl6?=
 =?utf-8?B?U3RtUHVhTWJlR0hZMFlsblNUc2RDRkJvRElpc3pjL0V1RUxJbEdpQjlYOW5z?=
 =?utf-8?B?MkRweWFzOHV2VGRmMFBVSUdRZUtXVkJHTER2SkJNa3pmejJ6NTNaalMxbVNI?=
 =?utf-8?B?UEdkcGg0aHVucWx3NVkwaXJhZ1ZVT1RySU8rZzNBNlJNZERFTm9YQnNORmNY?=
 =?utf-8?B?Qzl1U0JUTS9ZTktaMC8rcmp6Y3J2WlJIbVJDZWx4bXBrMFdWWnQ0c3llZlJG?=
 =?utf-8?B?NGZXRzVRZEYrbjZGWDRuS1d3SzhGYkc5bGl0NFJ6RzR5YWVzQ2preTlodVRu?=
 =?utf-8?B?cERsNDRqTXI1YUNFRi8xQ2M3WnJXbVhzcVpQTFhlY3J2RnJ1Lzk0bWFLVzZh?=
 =?utf-8?B?QSt5cDcra1VIVFB1ZysvSWhuMUUrLzZzb2dHRnNJcGVzRmVtS0tnVlN6VzJT?=
 =?utf-8?B?TWpjcXRzVmtQVi9Db1dCelNKNUVWK1BLTmZwQmI5TWNWbGdLdkhPOXhqL1E1?=
 =?utf-8?B?T0ZkamVVRUVycHhsTFV3TUtMdkowc0lmT3pNYndHci83b3FuLzF1WVl3amxi?=
 =?utf-8?B?b0JnOWNXd09PeVNYV2MxNUttT2ROUG5qYXc3THZOdCs3RmZUTUIxSEhpMTJU?=
 =?utf-8?B?Q1lLVUM1ZDlmWTRNUjJmS2pDRnBFM080Nkw4N3hFOS9Va2JxbmVqT3FoVll5?=
 =?utf-8?B?Slc2anNvZHBnMlJyYkxDa3dsL2gvTFQ0L1BVZGpEeEYrOStOSzY4YVhyUzRR?=
 =?utf-8?B?cjVnWDlaLytMZlNHS3lKNVJPdG9hdUhVc1o4WFc5bjFwci9HNnBET3BOZjJG?=
 =?utf-8?B?YXVieFYrSFVmbEJNTGszSkFIR1dOL25HK1dmYzFrUWNMQ2Q0TkJ2VEJFa2Jx?=
 =?utf-8?B?WlRvaFRTMlVaQXljR2YyK1liS21nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE41A6AFE6C4A24C9532A71C74038098@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275738d3-3855-4e30-7ed2-08de10a755af
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 13:40:01.5332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lps3CVVHrJRnTDO0RVUJyEpOBH7IxXgHMNZd7Xk9stAPzq8DASEMiY3MDR3Yl+/pPm02tIZncu9VC1oNA8hG2VxFSvYujNCmLT6mfp5iJwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR02MB11181
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDEwNyBTYWx0ZWRfX0AzOZ0L3rrkf
 8A+6PAt/n+0I9Vo3K48KbZ9Z6FP8AkF9iJiWYaLO60fG2cLxURdpDn8SoEjRHnDZa96wWUqC0XL
 t25U/6Y1be+1UDs7zy3qTNAyGx5ptkC0dD8VGul2+wmlE0iuTIS4ZE8hqS/LaeDbQTi/4CpjuZl
 AVD0TRCzHost8qnyYyVQqIqBtDMycEOya8woe6jLtDRKelSgLM30IvZdGYza8fPlOA0gA2ULhv+
 72gTg8aMem08fOU/PLVHkK+AHmwXDl7R1+Mvy50O2ZH3PzP2ySBJuwznSgllkdPyPnuFmltZ2M+
 4E4vhYPGN2i3SvzoNr5YiFH1gjaOoj3LZtfPWPNKwPQaS8mj9CKyMcmjUXdKsfMUZbi5HLBbmtB
 hg/sej+VfhuagL0Qr7LRCqd9ilIioQ==
X-Authority-Analysis: v=2.4 cv=MbVhep/f c=1 sm=1 tr=0 ts=68f78d33 cx=c_pps
 a=QJ8jp5v3SeQRmo9gzrsiOg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=B-AZO7OkcHXLnTe50hIA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: iZ-RqmkiO7oLHvdj7zLXmU9Y_7aYD7nZ
X-Proofpoint-GUID: iZ-RqmkiO7oLHvdj7zLXmU9Y_7aYD7nZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gT2N0IDIwLCAyMDI1LCBhdCA2OjQx4oCvUE0sIFBhd2FuIEd1cHRhIDxwYXdhbi5r
dW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gIS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+
ICBDQVVUSU9OOiBFeHRlcm5hbCBFbWFpbA0KPiANCj4gfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0hDQo+IA0KPiBPbiBN
b24sIE9jdCAyMCwgMjAyNSBhdCAwMzowOTo0MVBNIC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToN
Cj4+IE9uIDEwLzIwLzI1IDEzOjQwLCBQYXdhbiBHdXB0YSB3cm90ZToNCj4+Pj4gSSBjYW7igJl0
IHNwZWFrIHRvIG90aGVyIFZNTXMgKGUuZy4gdm13LCBoeXBlcnYsIGh5cGVyc2NhbGVycykgYW5k
IGhvdyB0aGV5IGRvDQo+Pj4+IGl0LCBidXQgSSBzdXNwZWN0IHRoZXJlIGFyZSBzaW1pbGFyIGNo
YWxsZW5nZXMgYXJvdW5kIHBvc3QtbGF1bmNoIGZlYXR1cmUvYml0DQo+Pj4+IGFkZGl0aW9ucyB0
aGF0IHJlcXVpcmUgdGhlIFZNIHRvIGJlIGNvbXBsZXRlbHkgY29sZC1ib290ZWQuDQoNCkZpcnN0
IHRoaW5nLCBJIHdhbnQgdG8gYXBvbG9naXplIGZvciB0aGUgY29uZnVzaW9uIHllc3RlcmRheSB3
aGVuIHRhbGtpbmcgYWJvdXQgdGhlDQpRRU1VIGVuYWJsZW1lbnQsIEnigJltIHNvcnJ5IEkgbWlz
LXJlcHJlc2VudGVkIHRoYXQuIFdhc27igJl0IGludGVudGlvbmFsLCB0aGF0IHdhcw0KbWUgZ2V0
dGluZyBteSB3aXJlcyBjcm9zc2VkLg0KDQpUaGUgYmFzZWxpbmUgZW5hYmxlbWVudCBpdHMtbm8g
aXMgdGhlcmUgaWYgeW914oCZdmUgZ290IGJvdGggdGhlIFFFTVUgYW5kIGtlcm5lbA0Kc2lkZSB0
b2dldGhlciwgaXRzLW5vPXllcyBzaG91bGQgd29yay4gTm90IHRoYXQgaXNu4oCZdCBleHBvc2Vk
IG5hdGl2ZWx5IG9uIGFueSBDUFUNCm1vZGVscyBmcm9tIHRoZSBsb29rcyBvZiBpdC4gSSBjYW4g
cHJvcG9zZSBhIHBhdGNoIG9uIHRoZSBxZW11IHNpZGUgZm9yIHRoYXQuDQoNCj4+PiBPaywgdGhh
dCBtYWtlcyBCVVNfTE9DS19ERVRFQ1QgYSBiZXR0ZXIgY2hvaWNlIHRoYW4gQkhJX0NUUkwuIEkg
dGhpbmsgaXQNCj4+PiBiZSBiZXR0ZXIgdG8gcmVwbGFjZSBCSElfQ1RSTCB3aXRoIEJVU19MT0NL
X0RFVEVDVC4NCj4+IA0KPj4gRm9sa3MsIEkganVzdCB0aGluayB0aGlzIGtpbmQgb2YgcmFuZG9t
IGZlYXR1cmUgc3BhZ2hldHRpIHZvb2RvbyBpcyBhDQo+PiBiYWQgaWRlYS4gU3VwcG9zZSBYODZf
RkVBVFVSRV9CVVNfTE9DS19ERVRFQ1QgaXMgaW4gc2lsaWNvbiBvbiBhbg0KPj4gYWZmZWN0ZWQg
cGFydCBidXQgbm9ybWFsbHkgZnVzZWQgb2ZmLiBCdXQgYSBiaWcgY3VzdG9tZXIgc2hvd3MgdXAg
d2l0aCBhDQo+PiBiaWcgY2hlY2tib29rIGFuZCBJbnRlbCByZWxlYXNlcyBtaWNyb2NvZGUgdG8g
ZW51bWVyYXRlDQo+PiBYODZfRkVBVFVSRV9CVVNfTE9DS19ERVRFQ1Qgb24gYW4gYWZmZWN0ZWQg
cGFydC4NCj4gDQo+IEhtbSwgcmlnaHQuDQo+IA0KPj4gV2hhdCB0aGVuPw0KPj4gDQo+PiBZb3Vy
IG9ubHkgY2hvaWNlIGlzIHRvIGNvbnZpbmNlIEludGVsIHRvIG1ha2UgYXJjaGl0ZWN0dXJhbCB0
aGUgaWRlYQ0KPj4gdGhhdCBYODZfRkVBVFVSRV9CVVNfTE9DS19ERVRFQ1QgaXMgbmV2ZXIgZW51
bWVyYXRlZCBvbiBhbiBhZmZlY3RlZCBwYXJ0Lg0KPj4gDQo+PiBCZWNhdXNlIGV2ZW4gaWYgd2Ug
Z28gZm9yd2FyZCB3aXRoIHRoYXQgcGF0Y2ggd2UndmUgKkRPTkUqIHRoYXQgaW4NCj4+IExpbnV4
OiB3ZSd2ZSBtYWRlIGl0IGRlIGZhY3RvIGFyY2hpdGVjdHVyZSBhbmQgSW50ZWwgY2FuIG5ldmVy
IGNoYW5nZSBpdC4NCj4gDQo+IFVzaW5nIEJISV9DVFJMIGhlcmUgd2FzIGluIGFncmVlbWVudCB3
aXRoIENQVSBhcmNoaXRlY3RzLiBFdmVuIHRob3VnaCBpdHMgYQ0KPiBoZXVyaXN0aWMsIGl0IGlz
IHZlcnkgdW5saWtlbHkgdG8gYmUgYnJva2VuIGJ5IGEgbWljcm9jb2RlIHVwZGF0ZS4NCj4gDQo+
IEkgY2FuJ3Qgc2F5IGZvciBzdXJlIGFib3V0IEJVU19MT0NLX0RFVEVDVC4NCj4gDQo+PiBDYW4g
c29tZW9uZSB0cnkgdG8gYm9pbCBkb3duIHRoZSBwcm9ibGVtIHN0YXRlbWVudCBmb3IgbWUgYWdh
aW4sIHBsZWFzZT8NCj4+IA0KPj4gVk1zIGFyZSBzbG93IGJlY2F1c2Ugb2YgbWl0aWdhdGlvbnMg
Zm9yIGlzc3VlcyB0byB3aGljaCB0aGV5IGFyZQ0KPj4gbm90IHZ1bG5lcmFibGUgd2hlbiBydW5u
aW5nIG9sZCBrZXJuZWxzIG9uIG9sZCBoeXBlcnZpc29ycy4NCg0KVGhlIHByb2JsZW0gc3RhdGVt
ZW50IGlzIHRoYXQsIElUUyBpcyBvbiBieSBkZWZhdWx0LCBvbiBub24taW1wYWN0ZWQgaGFyZHdh
cmUsDQphbmQgYXQgbGVhc3QgZm9yIHRoZSBRRU1VIGVjb3N5c3RlbSwgdGhlIGZlYXR1cmUgY2hv
c2VuIChCSElfQ1RSTCkgd2FzIG5vdA0KZXhwb3NlZCBhdCB0aGUgc2FtZSB0aW1lIHRoZSBTUFIg
bW9kZWwgd2FzIGludHJvZHVjZWQsIHNvIGd1ZXN0cyBvbiBwbGF0Zm9ybXMNCnRoYXQgZG9u4oCZ
dCBoYXZlIEJISV9DVFJMIG9yIElUU19OTyBmb3IgYW55IHJlYXNvbiB3aWxsIGJlIGltcGFjdGVk
IGZvcg0KcGVyZm9ybWFuY2UsIG1pdGlnYXRpbmcgYWdhaW5zdCBhbiBpc3N1ZSB0aGF0IHRoZXkg
ZG9u4oCZdCBhY3R1YWxseSBoYXZlLg0KDQpTbyB0byBzaW1wbGlmeSBpdCBkb3duOg0KQSBndWVz
dCBWTSB0aGF0IHVwZGF0ZXMgdG8gYSBJVFMtZW5hYmxlZCBndWVzdCBrZXJuZWwgc2VlcyBwZXJm
b3JtYW5jZQ0KaW1wYWN0cyBvbiBub24tdnVsbmVyYWJsZSBoYXJkd2FyZSwgd2hlbiBydW5uaW5n
IG9uIG5vbi1CSElfQ1RSTCBhbmQvb3INCm5vbi1JVFNfTk8gaHlwZXJ2aXNvcnMsIHdoaWNoIGlz
IGEgdmVyeSBlYXN5IHNpdHVhdGlvbiB0byBnZXQgaW50bywgZXNwZWNpYWxseQ0Kb24gUUVNVSB3
aXRoIGxpdmUgbWlncmF0aW9uLWVuYWJsZWQgcG9vbHMuDQoNCj4gDQo+IEZyb20gd2hhdCBJIHVu
ZGVyc3RhbmQ6DQo+IA0KPiAgVW5sZXNzIGEgVk0gaXMgY29sZC1ib290ZWQsIGl0IGNhbm5vdCBz
ZWUgdGhlIG5ldyBmZWF0dXJlcy9pbW11bml0eSBiaXRzDQo+ICBleHBvc2VkIGJ5IHRoZSBoeXBl
cnZpc29yLiBJbiB0aGlzIHBhcnRpY3VsYXIgY2FzZSwgYSBndWVzdCBnZXRzIHRoZQ0KPiAgdXBk
YXRlZCBrZXJuZWwgd2l0aCBJVFMgbWl0aWdhdGlvbiwgYnV0IGNhbid0IHNlZSB0aGUgaW1tdW5p
dHkgYml0IHVubGVzcw0KPiAgaXQgaXMgY29sZC1ib290ZWQuDQo+IA0KPiAgVGhlIG90aGVyIHBh
cnQgb2YgdGhlIHByb2JsZW0gaXMgd2hlbiBob3N0IGtlcm5lbC9oeXBlcnZpc29yIGlzIG5vdA0K
PiAgdXBkYXRlZC4gSW4gdGhpcyBjYXNlIGltbXVuaXR5IGJpdCBpcyBub3QgZXhwb3NlZCB0byB0
aGUgZ3Vlc3QgYXQgYWxsLg0KPiANCj4gTXkgMiBjZW50czogQWxsIG9mIHRoaXMgbWFrZXMgbWUg
ZmVlbCB0aGUgaW5zdGVhZCBvZiBleHBvc2luZyB0aGUgaW1tdW5pdHkNCj4gYml0LCBhIGd1ZXN0
IHNob3VsZCBiZSB0b2xkIGFib3V0IHRoZSBidWcgcHJlc2VuY2UuIFRoYXQgd2F5IHNlY3VyaXR5
DQo+IG1pbmRlZCB1c2VycyB3aG8gdXBkYXRlIHJlZ3VsYXJseSBnZXQgdGhlIGJ1ZyBlbnVtZXJh
dGlvbnMsIGFuZCBoZW5jZSB0aGUNCj4gbWl0aWdhdGlvbnMuIE9UT0gsIHBlcmZvcm1hbmNlIGZv
Y3VzZWQgdXNlcnMgd2hvIGRvbid0IHVwZGF0ZS9jb2xkLWJvb3QNCj4gb2Z0ZW4gZG9uJ3QgZ2V0
IHVubmVjZXNzYXJpbHkgc2xvd2VkIGRvd24uDQoNCg0KDQoNCg0K

