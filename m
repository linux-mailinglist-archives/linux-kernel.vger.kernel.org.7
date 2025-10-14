Return-Path: <linux-kernel+bounces-853198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93761BDAE75
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E43184FC738
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE451307AEC;
	Tue, 14 Oct 2025 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L1s9fqqR"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A085C3074BD
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760465220; cv=fail; b=nDfyL+uE7cTrJm6XVkG6CEBWCWF1Iyn28Egr5P6C9fgSvwv1dA4OrHNJNjL4nHlXfmLwUY9sH3iW4JOJZbXrn60Kk7pcjFPcKeIlL7a1QlvtjXn5NpbbHiN4j/hV4Lz2eGHiY/HvxR4s+uDyRu+r4dzqJI2aAZ2pF070FUL9Ba4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760465220; c=relaxed/simple;
	bh=xzC5OycpF1BRQgaFleen1DJG0KNHv94Wb9TMKR25sFI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oQftFnwQiImWdFPo97M/+o/NPfw2Gwq3svhaGbYWq1oOcYJeVLgbifZgeiSBhnEWj6HjKylvXtdufJcztdcUjdeOHEgpjkJteAzgiq6IyvU8KghvgntG4jMITjpnoIs/vOmBmy0a02BFe8a1rdliYz6C1+KLMs0xp4QUD/CNUNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L1s9fqqR; arc=fail smtp.client-ip=52.101.56.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgxWSK1C6pLwyM9xsEbZFbEz4q/bDNAZkzTCK+7qNXpg2wdUAkgjHihVk0Yv3iGLJIdBpHP7zyeTk5GfIx4B03HxRV+mrHkYpKWZt2I3h/swDmCYH41N29Ll3AkhqTmJENZ10tw6CsQxAc3UX96n7uige1ni8gxiSgH1nWt+Ti4mEuOss7xBdJgvmwm2daVUbxSWoFiWKEVM7tsluyQ+D9pvVF5+I9LGd8k4WnaRgoZdN50cpFUVxD+J46Yw4yTPpWXxPUAXkTsOHgtJfy2IybpstPMlPIz0M6RqL5tmnF3gzs998qsCKR8HAa3ItofX3J1SojMDgIvUzYuxSFi9/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzC5OycpF1BRQgaFleen1DJG0KNHv94Wb9TMKR25sFI=;
 b=uf8PVTXqRKZuSnfiMpFMV3EVUYoMW9VI060GngrmlFu1BtRi9JERykr7UU2hEUfqqLMWoKsgj27akt00ntngaC6SpKtddxTf8ghJ2h+dZYypw3EKZlO5Pol0BBFBMdxaZUqfP2EBeQD5CD5DZ43oE8r1lKlrHBV6/BEggEu6wL38eYhtSemMW/3ArAjbMjl3asoM6TrzWYytTQhczMjpK7h+/hS2kEFzi7g1S1pbV21BaTN4iJNbkdPx+XGPmmzWLpzvnvoEeUuI7FaElJUJ39LgWRBrAsJzXLJyyOb5pFoAhex/jkOAil2P0TxZITxsOfEo+O1GpNbEUQ6fqGYrEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzC5OycpF1BRQgaFleen1DJG0KNHv94Wb9TMKR25sFI=;
 b=L1s9fqqRURi4D00+DJAmFcLTdtTIOmIxt9eE9rP7NSBArWk/sCoLHW5Ary02HX6PCbapiV3Ff81JewTzxLTXBG1UfO+AR1ddO4T0moHP5waErZc7+1gxbYrOxPByn9Jzo17XEyDZr/JzBj3woLPD2BkbwHw10sJoWCi8OE3dMWU=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Tue, 14 Oct
 2025 18:06:54 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::2202:1a7e:2dd:ad1d]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::2202:1a7e:2dd:ad1d%4]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 18:06:48 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 00/56] Dynamic mitigations
Thread-Topic: [RFC PATCH 00/56] Dynamic mitigations
Thread-Index: AQHcPSe8b7qd0BZyXkK7jo/Wse1167TB7pjg
Date: Tue, 14 Oct 2025 18:06:48 +0000
Message-ID:
 <LV3PR12MB9265D0A464C2F597219A7B1294EBA@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <bjgjmijirueqwwmuen5dr6v7yqdcivk6kwa6gbukn3rodfcwko@fb5yxyqycena>
In-Reply-To: <bjgjmijirueqwwmuen5dr6v7yqdcivk6kwa6gbukn3rodfcwko@fb5yxyqycena>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-14T18:00:40.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DS7PR12MB5743:EE_
x-ms-office365-filtering-correlation-id: decbbe19-8b1f-411c-9d56-08de0b4c71d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MGttQ1lHaHZvc3FvU015Zjd2bUlpN1ZGVXhCVm1lY0l6cE5DOHcwN3lxZDAv?=
 =?utf-8?B?dldUbSsycnRqTEVjNFZPcnlYU1VEWkZ0OFYvdHF5Q3NLSG1Cckx2RW5QSWY3?=
 =?utf-8?B?OW9QU01sNGJrdWhuN0RjZk83ZHdtWjBCRUFwNHhIQ2duMUtvOWtySlZGWGdD?=
 =?utf-8?B?b1dHK2lXUm1OYUxBWVd6ekJXU245Ly95bXVaa1RYcEhqUFkwMWlPdnlBODNl?=
 =?utf-8?B?S050SDJPbXpURDk0MStaQjJRdHdlV1kzUGFxdnNHcUNYemgzMmR5US9LdlZW?=
 =?utf-8?B?SXhWMk1RcWdZSzlRV2xGd090N1liSWVHbmJFdjZMU3NVWEVIZ1FQUzU2SW1M?=
 =?utf-8?B?RHVjRWJLcVZsMktjN0JiL3o1RzF5eTRGT0NzZlp2aFZGeUhnM0hUUGtNUTk4?=
 =?utf-8?B?dlcwV3U3akxvVW9qS2gzb2p0cEE2NjJtTVN1RmczN1NaWGErL2E1bFRTTFpv?=
 =?utf-8?B?N0FvQ2ozb0I2ZVdGMGFWOWs2UTJXQklxUjhDVjlxbk1iUVZOcXhTSE9Td2pz?=
 =?utf-8?B?RUZ5dkdmUStrLzFucEN2dk5FYUxIc3FiUStlL1VpOEZCckY1V2szRXdDbE9z?=
 =?utf-8?B?VXZNdEtqOTlKcUVpNHF4VEMrWGtrLzN6M1JJVWdrQWx5aDZDZlBTd04rdm1x?=
 =?utf-8?B?eWdwSkluOENiUlZkdVZGVTJPREltQUNlRHpKTmhjYzhUcDQrRTNxaGVsUnpr?=
 =?utf-8?B?Z1JuK2FIMFpHTDVBeE1rQWh4QlZiY3M2YSt4eG8vcVBSdXcvbm5XSGNSejFD?=
 =?utf-8?B?N0l4dndiWFRsVTFRTlpNOEVKYTc0UHordDFQVEFvTE1laHBBdGlOOERncFQ0?=
 =?utf-8?B?OGt5dExheGtUWXB2dE5uT3V0RWlpRStqckNQd0F4TW9JMUV5aXdkZ01heVRE?=
 =?utf-8?B?UzhKcEJVNDVTditXTnVqMTdQMHk5ZXQ5Vlk0SlFmVDVJRlhhSVAzeExaZUFM?=
 =?utf-8?B?TCs1dGt3aHBSMmk1OE9jSTdVU05KbDkyREU2MHZYSkIyVEJ3dThuc2NhdlAx?=
 =?utf-8?B?aTI4bTVJWER6RE12cC9PMmM4UURnUzIycVJ5VmxKNWdtTWYvZ2xvN0h4QUQy?=
 =?utf-8?B?UEFCeEJGOHgyaXgwU3NEVmYxZFZva2ZUTldTbS9lZUo5QnRrTVdkMjNUdlds?=
 =?utf-8?B?Yndqb1NvWE4wWWNPQXZ1bXpKMDkvSVZwZnpQcHk1eU5ySERURkI1S0RzN1JV?=
 =?utf-8?B?UnFway9MQnFiL1p6TjF6anFZRi9zZWpzZHFwR1BiWFlNalU5VndubytiSFEx?=
 =?utf-8?B?clFYRmtTdG1tdlB3SW8rKzJiTSt6a01HMG5BV2VrNzNQMzdDY2Zac1lYYXZj?=
 =?utf-8?B?V3FqZVc5OFZIZFAwWTJkYlc5QURzVC9pVW9RVnRzQlFxU05MMnZlMnVGYVZu?=
 =?utf-8?B?OWxKWlNicUhJNDdKTlBaRUpKSHY2UHY0d3RQQjdQckZsRkhOTGJMK01hbXRx?=
 =?utf-8?B?c0g5K05qOEJpaDBHYzFSTjdkR1gwckxZWlFiSGFGaVR3bSs1TzNwYlBrVWFx?=
 =?utf-8?B?Mnh5a2VHTlYyb1owZ1VDY1pzNWM1VmU1UlY1VURxRjhGOXFpeVd4djlva1pi?=
 =?utf-8?B?d29heW9tL2JId1Fyc0ptTzlsdlQ1UDJ0aXRVNHBQNDJoQ3hxK01yNkk1TVVK?=
 =?utf-8?B?TlNWTVRSQWVwOS9XeU1SMzh2YTB0MHZ5aEdxZGh6bnk1Z1owRFUxcXdQcFUr?=
 =?utf-8?B?TTk2ckF3cDAvdXBFZHBsU2RNU2ZiS0Z4YTlnckFmRUg1NTYvZGlyVklzUVli?=
 =?utf-8?B?TFJJeFBMd0VCdHNxRUZCNW0vU2hZaHBOMVN0cW43L0tpelZPNnRvek8vcnhH?=
 =?utf-8?B?bjdqUzVCcVg0S0lFZjRyNmtBZmVSTUxZNHorTjZ4dUNrbFhwN01UTnJvdWND?=
 =?utf-8?B?NmxTSno5NWlRUFFCRGMzdTFVRWEyN2RnZ0UrVUVGNGZRdGtiR1RCbDJDMjdm?=
 =?utf-8?B?dnhtODhHeWlQNVdqMXRBUi9iSTJORG51ZFVBaVUwSXVKWE1CeTVNOXJocFhY?=
 =?utf-8?B?ekpPZnlyeTZNTU40UVd6OFlNRzJUdENDeklOSXdTZDRhL1ZHSTBrUnc5RVJk?=
 =?utf-8?Q?gEftDP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dlJQQiszK0dXUnBNWXFEQi9tK05QV3Q4cFVYa3lneGtzM0IwUmoxZFQ5OXUv?=
 =?utf-8?B?QUJnanpVc1pqTXRSWGdHOUxkcjJMS2VKL0Z3V25mZnFGY0UrM0JQeGxKbkYy?=
 =?utf-8?B?OWhHTkhuUGJmVnR5Tm91YUVhUVlTSXZESVFjN0RzalovYXM1NXdPbFUwVk9Q?=
 =?utf-8?B?cC9hWkpBUGppNW9ZOC9jWlYvSzk5UnZKck03dXBIM0NmbUNUWmM5VnhVL1I4?=
 =?utf-8?B?VnozNkRUS1hNMW9YVzhleWVyTzNCYjJFS0IwbXdGbkhHdUUzUnZiZXJ0ZVNN?=
 =?utf-8?B?WEw5WGpSbFdUdGJhZzljR1UxL3hRQ2tHZGRaMitHTUIzQXRhR3hhVFQ2R2VK?=
 =?utf-8?B?UUtLMDhIZWNWckJsVks4TURTVnc0b2tYaVkrWTRnSTFFY2pRWG1YNHpveDJi?=
 =?utf-8?B?ekdRVXB0S1FWNG43Zkh3ZjNSU21mbVBJTXlTdlVETFhOYnZ6U3I0RFlnMkNl?=
 =?utf-8?B?WXVoQlhrRDNTSTROb0IrMHdSK0ZEeUU5QStsYnBibGplNVFTeE1xZHNzeith?=
 =?utf-8?B?MnJNbmFud0ZuOXNVcTBSUERmVWVQQWdld2V0aHJLWUZhc2JCdS9CRG5zVlpL?=
 =?utf-8?B?bXBIcERvaFU0YWlDUHpDUE82Qk1MQmNwTTNwRThkdDQxUE9CQUpxcWxJMzJr?=
 =?utf-8?B?bkpXSmR3eHErUm93VmRzdWtMQzVGeDFFNzZWSkVSYkxrRitpMldBcnpRbHpy?=
 =?utf-8?B?S1FHNnR1SHdMQTc4amFOTGdiYkx6Mk9TbEFoNGZZNStvM1FjSDdvNm1XWDZa?=
 =?utf-8?B?aVRwYWJycjA5eFIxcTZDRXhGby8zTm9peW53MTg4ajlYMjYvV2xzQjFkUmFN?=
 =?utf-8?B?SUZCbjJMeWlBZE9YSTdIMmdWNks3a1UveUV2VXBxeWpzekJjUEdTVzFiMzNM?=
 =?utf-8?B?WjdRSkdBVkk5N3lmZVhzNktOOUtlMzR5bkhRTkYzaXZGZjZnMC9oa0ZjNTdU?=
 =?utf-8?B?V3h4cG9SamlvRDBGQlJPVmdmV2JHL01ESS9iVGYrcVhTbkZCbTlUQzgrNzV2?=
 =?utf-8?B?ZnpjalhKRzBpQW1TUjlYM2hyNVVSUW8yUjhKMHN5V1pLVTQ0NmFsQXJLVmpt?=
 =?utf-8?B?TGI4R3JnYlE1VUxMNHhCKzAyN3V6N3ZPYVkrMm4xNEJ3NXJQaWF2VFRXOGNa?=
 =?utf-8?B?a1MxNjVFaHUvYnhXOG5lLytzOGgraXdEdlJCcG1iQUFKK2dxSStjL2pFVEh3?=
 =?utf-8?B?cnQweFVIdCtTMVpwcGpGb3BoeUx5V01IeUpKakM3R0hKbVlHV1JBNmh4L2VC?=
 =?utf-8?B?MExzRUhoZkllZW9VQ0hoK2swVWR1ZWFnRzNVY1ovajVIWjJ6bG85RWRzVFpy?=
 =?utf-8?B?VnN5L2R6dDVaUHRIOTJveDlTZUwydWh1RkFnRmhQL1ZKc00vM3h5ZnJyZEVp?=
 =?utf-8?B?aW9wSnZQbzV6MFVIeGRZUitkd1ZsYVB6L3JkcG5lRk5OMDdLckYwZVF2bysv?=
 =?utf-8?B?d2EvZDlKVTRzT3dSSllEWVpFYTBVQlN2T1djUnh2UWJsU0FFZG13YjU2MXkv?=
 =?utf-8?B?Zm1yK283SzcrbEdBVjV1a1BCem1sTmtNL0cvTXB2bzFBSlJsbjBLZFhnOGQw?=
 =?utf-8?B?aGtmT2gyWW9ZV2NGdWVWOW9hejFXQkZDMkhqUDMwU2RUT3dMYWF3WUgvdytp?=
 =?utf-8?B?aTFjQWJUcXJhaUhDRW9jRkVEVWFQaGtDZmJJbVpWN0dkYk04QjB3em9xdThC?=
 =?utf-8?B?dVBzY28xbk1WVHBDWVd4Z3krN0FCcGg0YjRIRGlXQzJRNjVsNUpoelNkVHNP?=
 =?utf-8?B?YlZCZW1nQ3JBZTByWFQvdjlpSkVST29sa3RYancvemkvM1FpeEtEMW9jZDRt?=
 =?utf-8?B?TWNKcVpFM0krOW41Y01nd2phNFh2d0Q1VzRhdm1TbEg0cEVMc0hZbjlwZlc1?=
 =?utf-8?B?c0lVTDhLdjI0WmYxblllbjFRMTVWamhMNGhzcmIvWlBiVy9odllWdGJwM1o2?=
 =?utf-8?B?MGZYMFdUR1lCbGU2SGFhdFZmS3h3d1hVbndjTTNxdHdWYzgzVEp0YUFudzRy?=
 =?utf-8?B?QTZuVWpZOXJic3FzUWs0MjZEK3AvUno4Q21TZmF1cHJ4Y0VET01QcFM4bmY4?=
 =?utf-8?B?UlBZTU5rOWt5NHh6UDFyNDMxRU5PWHlSRTJsYzB6MVhMeGtJYllDUldyMm91?=
 =?utf-8?Q?aYJA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: decbbe19-8b1f-411c-9d56-08de0b4c71d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 18:06:48.7969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 66uc90yS+8Lnpb0wVQfcCyx1pvw8gDaQqehL+fuueDSnfDEUzsj7UfTl5yXs0C39
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3NoIFBvaW1ib2V1ZiA8
anBvaW1ib2VAa2VybmVsLm9yZz4NCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAxNCwgMjAyNSAx
MToyOSBBTQ0KPiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+DQo+IENj
OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47IEJvcmlzbGF2IFBldGtvdiA8
YnBAYWxpZW44LmRlPjsgUGV0ZXINCj4gWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsg
UGF3YW4gR3VwdGENCj4gPHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IEluZ28g
TW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgRGF2ZQ0KPiBIYW5zZW4gPGRhdmUuaGFuc2VuQGxp
bnV4LmludGVsLmNvbT47IHg4NkBrZXJuZWwub3JnOyBIIC4gUGV0ZXIgQW52aW4NCj4gPGhwYUB6
eXRvci5jb20+OyBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPjsgQm9yaXMgT3N0cm92
c2t5DQo+IDxib3Jpcy5vc3Ryb3Zza3lAb3JhY2xlLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMDAvNTZdIER5bmFtaWMgbWl0aWdh
dGlvbnMNCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRl
cm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVu
dHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBNb24sIE9jdCAx
MywgMjAyNSBhdCAwOTozMzo0OEFNIC0wNTAwLCBEYXZpZCBLYXBsYW4gd3JvdGU6DQo+ID4gRHlu
YW1pYyBtaXRpZ2F0aW9ucyBlbmFibGVzIGNoYW5naW5nIHRoZSBrZXJuZWwgQ1BVIHNlY3VyaXR5
IG1pdGlnYXRpb25zIGF0DQo+ID4gcnVudGltZSB3aXRob3V0IGEgcmVib290L2tleGVjLg0KPiA+
DQo+ID4gUHJldmlvdXNseSwgbWl0aWdhdGlvbiBjaG9pY2VzIGhhZCB0byBiZSBtYWRlIG9uIHRo
ZSBrZXJuZWwgY21kbGluZS4gIFdpdGgNCj4gPiB0aGlzIGZlYXR1cmUgYW4gYWRtaW5pc3RyYXRv
ciBjYW4gc2VsZWN0IG5ldyBtaXRpZ2F0aW9uIGNob2ljZXMgYnkgd3JpdGluZw0KPiA+IGEgc3lz
ZnMgZmlsZSwgYWZ0ZXIgd2hpY2ggdGhlIGtlcm5lbCB3aWxsIHJlLXBhdGNoIGl0c2VsZiBiYXNl
ZCBvbiB0aGUgbmV3DQo+ID4gbWl0aWdhdGlvbnMuDQo+ID4NCj4gPiBBcyB0aGUgcGVyZm9ybWFu
Y2UgY29zdCBvZiBDUFUgbWl0aWdhdGlvbnMgY2FuIGJlIHNpZ25pZmljYW50LCBzZWxlY3RpbmcN
Cj4gPiB0aGUgcmlnaHQgc2V0IG9mIG1pdGlnYXRpb25zIGlzIGltcG9ydGFudCB0byBhY2hpZXZl
IHRoZSBjb3JyZWN0IGJhbGFuY2Ugb2YNCj4gPiBwZXJmb3JtYW5jZS9zZWN1cml0eS4NCj4gPg0K
PiA+IFVzZQ0KPiA+IC0tLQ0KPiA+IEFzIGRlc2NyaWJlZCBpbiB0aGUgc3VwcGxpZWQgZG9jdW1l
bnRhdGlvbiBmaWxlLCBuZXcgbWl0aWdhdGlvbnMgYXJlDQo+ID4gc2VsZWN0ZWQgYnkgd3JpdGlu
ZyBjbWRsaW5lIG9wdGlvbnMgdG8gYSBuZXcgc3lzZnMgZmlsZS4gIE9ubHkgY21kbGluZQ0KPiA+
IG9wdGlvbnMgcmVsYXRlZCB0byBtaXRpZ2F0aW9ucyBhcmUgcmVjb2duaXplZCB2aWEgdGhpcyBp
bnRlcmZhY2UuICBBbGwNCj4gPiBwcmV2aW91cyBtaXRpZ2F0aW9uLXJlbGF0ZWQgY21kbGluZSBv
cHRpb25zIGFyZSBpZ25vcmVkIGFuZCBzZWxlY3Rpb25zIGFyZQ0KPiA+IGRvbmUgYmFzZWQgb24g
dGhlIG5ldyBvcHRpb25zLg0KPiA+DQo+ID4gRXhhbXBsZXM6DQo+ID4gICAgZWNobyAibWl0aWdh
dGlvbnM9b2ZmIiA+IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L21pdGlnYXRpb25zDQo+ID4gICAg
ZWNobyAic3BlY3RyZV92Mj1yZXRwb2xpbmUgdHNhPW9mZiIgPiAvc3lzL2RldmljZXMvc3lzdGVt
L2NwdS9taXRpZ2F0aW9ucw0KPiA+DQo+ID4NCj4gPiBUaGVyZSBhcmUgc2V2ZXJhbCB1c2UgY2Fz
ZXMgdGhhdCB3aWxsIGJlbmVmaXQgZnJvbSBkeW5hbWljIG1pdGlnYXRpb25zOg0KPiA+DQo+ID4g
VXNlIENhc2VzDQo+ID4gLS0tLS0tLS0tDQo+ID4gMS4gUnVudGltZSBQb2xpY3kNCj4gPg0KPiA+
IFNvbWUgd29ya2Zsb3dzIHJlbHkgb24gYm9vdGluZyBhIGdlbmVyaWMga2VybmVsIGJlZm9yZSBj
dXN0b21pemluZyB0aGUgc3lzdGVtLg0KPiA+IGNsb3VkLWluaXQgaXMgYSBwb3B1bGFyIGV4YW1w
bGUgb2YgdGhpcyB3aGVyZSBhIFZNIGlzIHN0YXJ0ZWQgdHlwaWNhbGx5IHdpdGgNCj4gPiBkZWZh
dWx0IHNldHRpbmdzIGFuZCB0aGVuIGlzIGN1c3RvbWl6ZWQgYmFzZWQgb24gYSBjdXN0b21lci1w
cm92aWRlZA0KPiA+IGNvbmZpZ3VyYXRpb24gZmlsZS4NCj4NCj4gSSdtIG5vdCByZWFsbHkgYSBm
YW4gb2YgdGhpcy4gIEl0IGFkZHMgY29tcGxleGl0eSB0byBzb21lIGFyZWFzIHRoYXQgYXJlDQo+
IGFscmVhZHkgc3RydWdnbGluZyB3aXRoIHRvbyBtdWNoIGNvbXBsZXhpdHkuDQo+DQo+IElNTyB0
aGlzIHdvdWxkIG5lZWQgc29tZSBSRUFMTFkgc3Ryb25nIGp1c3RpZmljYXRpb24sIG1vcmUgdGhh
biBqdXN0DQo+ICJoZXksIHRoaXMgbWFrZXMgdGhpbmdzIG1vcmUgY29udmVuaWVudC4iDQo+DQo+
IFRoZSBtaXRpZ2F0aW9ucyBzaG91bGQgYmUgYSAic2V0IGl0IGFuZCBmb3JnZXQgaXQiIHRoaW5n
LiAgSSBkb24ndCBzZWUNCj4gYW55dGhpbmcgaGVyZSB3aGljaCBqdXN0aWZpZXMgdGhlIGNvbnNp
ZGVyYWJsZSBtYWludGVuYW5jZSBidXJkZW4gdGhpcw0KPiB3b3VsZCBhZGQgZm9yIGFsbCBleGlz
dGluZyBhbmQgZnV0dXJlIG1pdGlnYXRpb25zLg0KPg0KDQpUaGUgcHJvYmxlbSBpcyB0aGVyZSBh
cmUgZW52aXJvbm1lbnRzIGxpa2UgdGhlIG9uZSBvdXRsaW5lZCB3aGVyZSB5b3UgY2FuJ3QganVz
dCAnc2V0IGl0IGFuZCBmb3JnZXQgaXQnIGJlY2F1c2UgdGhlIGtlcm5lbCBuZWVkcyBpdCBzZXQg
YXQgYm9vdC10aW1lLCBidXQgaW4gdGhlc2UgZW52aXJvbm1lbnRzIHlvdSBkb24ndCBrbm93IGhv
dyB0byBjb25maWd1cmUgdGhlIHN5c3RlbSB1bnRpbCBtdWNoIGxhdGVyIGluIGJvb3QuICBTbyB5
b3UgZW5kIHVwIHJ1bm5pbmcgd2l0aCB0aGUgZGVmYXVsdCBzZXR0aW5ncyBhbGwgdGhlIHRpbWUs
IGV2ZW4gaWYgeW91IGRvbid0IG5lZWQgdGhlbS4gIEFuZCB0aGUgZGVmYXVsdCBzZXR0aW5ncyBj
YW4gaGF2ZSBzaWduaWZpY2FudCBwZXJmb3JtYW5jZSBpbXBhY3RzIGluIG1hbnkgY2FzZXMuDQoN
ClRoZSBjbG91ZCBndXlzIG9uIHRoaXMgdGhyZWFkIG1heSBiZSBhYmxlIHRvIG9mZmVyIHNvbWUg
YWRkaXRpb25hbCBjb2xvciBoZXJlIHNpbmNlIEkgYmVsaWV2ZSB0aGF0J3Mgd2hlcmUgeW91J3Jl
IG1vc3QgbGlrZWx5IHRvIGhhdmUgdGhpcyBzaXR1YXRpb24uDQoNCi0tRGF2aWQgS2FwbGFuDQo=

