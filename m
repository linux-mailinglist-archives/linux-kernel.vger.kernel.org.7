Return-Path: <linux-kernel+bounces-844163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37418BC1330
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E04C3A5FF0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8CE2DA758;
	Tue,  7 Oct 2025 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="TO08fIZk"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023108.outbound.protection.outlook.com [40.107.162.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96836165F16;
	Tue,  7 Oct 2025 11:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759836209; cv=fail; b=AcyPr/kpLOu3reM6xXecOtN2pAxyAwsmyh3nZXGun+EvHZLUaiCCSxVsz7A1ZADRrrWGYiJ7IlLoTryhiUO1su/lseQsK05gzpq/KkqxZQ9j4GtK8b2M7EfTPsrXwZ+EBNTPinTSRml9ahXxGFCeQ38KgNWXPHlbRNcRBs5JsL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759836209; c=relaxed/simple;
	bh=ZVPU6A7tMXPlJAqKLyXo8dYeyqSUqvbUplxrKu4EjHM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X+5dP1cXgovEG0+B/ZPpOQhH4HUaBGSdzLza5u/CU3iVbPTJ3XdyVahb97A7P72NDOk55/YaQvyerZc9Hdwsb6xmX3jYKhkkWS231+LoNw1y1ZmqmYbH5L9Wpj6xciPHTQ7g30jyhLSpoVfl5UphJmx2+0xQ92K72CmmGfBrc/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=TO08fIZk; arc=fail smtp.client-ip=40.107.162.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RD68dA+4pG1gTbzO3pcgS1JsZ/G+4muICZnVBLTmcMc8AEpG56veQmvLH6kCuzpbP95L60WoGVlzlZx/W0U5JWwrjGls2xAXLyACI/HzgAiNwzFa3XbZnsefr/U/cYnG2q0V6phMchETOQyfCYblLB/wRDoqXsSp0yV5/E0Q1mQQ6THkWpceFNVfmzPZPgMV80O276nn3gO/A0+epqVZVLbvaty88ESlx0AXZWG3AuA7hK4L75G649nIZGNBTjYOWlD0DenKxqbRe8CcmyY88tkPH3Xc664M2NQg7CdrhynudH1wbGlQM71d4MR8X7oZhyy9isHse+QcNvet3iAOWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVPU6A7tMXPlJAqKLyXo8dYeyqSUqvbUplxrKu4EjHM=;
 b=f5Z3EvXexuLBmyS8EkuK+s0u7D8usmwrGGnbI1q4Dj7Qd5LuMws4lq1pAXbGsymYe7I6KOFpoHP8IV/VTsxgwHcfrhY6IqXJyOn09xXO0CmI6FKBZi+b/4w/NXXDG4A1YisQP51a1zpxgDiJsi9tzrXzZuYKbndeZhNHRYdhLjIM0ds2zuwRBCshKHFkBGU6b2dRcGHrRTH89AqK4vQwPQixkQGrrfaQqUoP8k7hMjA9uZpxxpFrDRVDJ/FGaDhM9f18fPMPoH8WbjMlnJ+e8sUJn8O2jjehQ7JhrudyYZX71rDPqOUSQkALcFc6ZC2xrs0pLNqvUPqJjeMCWDQasQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVPU6A7tMXPlJAqKLyXo8dYeyqSUqvbUplxrKu4EjHM=;
 b=TO08fIZkO6E3mkYPzcEqWYF5KDH9w5yHcbcH4oPtdpDmM1NIqdk8TrWgmyZnBxNx+9OwBk3FCKxTj8UTmTha245ZYrv4CDcSdd/91dDJbzSWobWja5T24s4sz6vdR46AW4gnA8eEqiqoj7FIYAwfwijzylO4q4tZeZg8htZfqkRq+W0G0/1FBwJ8V2aIlLU0yEBkc2L8cGI6RKOU3ed6H/xmdv8ZGZZ76yU2409Dfx4RMDpDGT22RA3ecD00w6t7URgypO9N0s1CO6dnWXHUCrrrnVCv6N8hi5H7LbJUfkr7MLCnG2tCJjkOHp1JSsnt/j31H9Lf708rWQgjNSCZsQ==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by AS4P195MB1647.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:507::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 11:23:18 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%6]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 11:23:17 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Krzysztof Kozlowski <krzk@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "upstream@lists.phytec.de"
	<upstream@lists.phytec.de>
Subject: Re: [PATCH v4 1/4] arm64: dts: im8mp-phy{board,core}: update license
 and copyright
Thread-Topic: [PATCH v4 1/4] arm64: dts: im8mp-phy{board,core}: update license
 and copyright
Thread-Index: AQHcN2JNWhY97ESoqEe2usdZ1br5IrS2XXkAgAAtUIA=
Date: Tue, 7 Oct 2025 11:23:17 +0000
Message-ID: <7d18c23201dde4b6f21739ff92cac13e597deca5.camel@phytec.de>
References:
 <20251007-imx8mp-pollux-display-overlays-v4-0-778c61a4495c@phytec.de>
	 <20251007-imx8mp-pollux-display-overlays-v4-1-778c61a4495c@phytec.de>
	 <342abe63-4062-4e37-9beb-4bfe8d55cd9b@kernel.org>
In-Reply-To: <342abe63-4062-4e37-9beb-4bfe8d55cd9b@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|AS4P195MB1647:EE_
x-ms-office365-filtering-correlation-id: a61cd880-d9b6-489c-479a-08de0593ea0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?K0g5SXk3bW1MdXA1Tlh3ZHV4bXFOZHBzcHFpWUU0UC9SVXl1S3hMSGsvKzVu?=
 =?utf-8?B?Qmpwc3k0WlQrY09na2E4THlVUmFxL2FEYnVHNGh4YSt4d1dkdTBVNUZ5VDZn?=
 =?utf-8?B?KzNEMFNsSzJRajk3L0pub1p3WXNCRS96eG50bVNPaUYrVVpzWkN3c3MxTWpn?=
 =?utf-8?B?T3JtTkpQVnlaOVB5Y3Nob1hKQXBtU2lDcXkxTFFTM3FKU0twVGg3NTlWL290?=
 =?utf-8?B?WXdnV1pKNHNQdWUxaUZ6T3NhRktMTjN1akpYRWVTQktiTjU3NDFLMmNxTWNB?=
 =?utf-8?B?RHFUYkJXZGFta0NPZXpNcGxwSitVYTFlR2prTlZmbFpFSTRyY2ZPOU12dnJ4?=
 =?utf-8?B?eGNBZHpCMlgwTGxybDlqRldOVkhWVDMxamFHU3VxTVdOTUJqVWpYWEFKa1d0?=
 =?utf-8?B?N0hhKzNNTDd2K1pVL1JYWVBPTHFGdGVrVGFQOEd3SG94QlFUN0k2dVd3TFJp?=
 =?utf-8?B?cTNaYjV3Z3ZxZCs4ekxkeUNWQkR4eUp2Wkt2VWJXSjJkM3pVSzkzVTFvdklw?=
 =?utf-8?B?Zmk5ckNaVHZaQ1NRei9YdUVtME9WamlyWGdSWDN0UG1yOXZEbUw5aUVoV0pz?=
 =?utf-8?B?a2V4dzc3dUxLaWZaeXdFMkdBSGt2UHVQMy9pVkR3eXdtajZ2c3N1bjB4cVAw?=
 =?utf-8?B?ZzRTTm5VbCsrODhHQU5kSWlXZFpYSDduTUxIRWtQOHpQWkJqR1pSMGNMOGNs?=
 =?utf-8?B?SHBycHp1WC9vMEVVQ1hkaElneWVubU5ISk1JNTc1d2I2eFVzdlNLM2JWdHd5?=
 =?utf-8?B?SXNvR3NiMG9PVlZXVnNYd29mZ3NUZ1MxNEhvS0F4SDNIdlQwS1dFRFpxVGRC?=
 =?utf-8?B?TGpnbU5xbEt1Zks0cWFuODN1blFhajFhSk0zdDd1aWh2WjZmVXpFUUl4a2Jo?=
 =?utf-8?B?dmJPbWxGd0RsampRS0VuaTVRUWhsQVNWVFhzS2g5TW9NbVJVUTFZMzJKWUNs?=
 =?utf-8?B?eUlLWStIdm1FVFREZjFleUZzM2NYV3EveVBrUTE4aTFwZzVtV0czRXIwbDZ2?=
 =?utf-8?B?VExma1J3bHkybG4vNUZEQkVSMEpyVC9hR1dvTTcvbGxkOEc4dVRFeWRnbytj?=
 =?utf-8?B?K1Jlc0R2ZVpXb054cDFhNEQ2QjN0K2RCWE5DYm9scVRFNlY2Myt4MlA2cTZv?=
 =?utf-8?B?emNwQUd6V3NjNlk2QXlZMmRPRlRsZWhOMHBYQnRtWm1VNTdnZE1CQ0dQcTR5?=
 =?utf-8?B?V2FUMkF3M05kVnVseGRzM2NrWHAxejFMNTZEZCtjazRycWRjNGNMUkE3YU45?=
 =?utf-8?B?NUJHNkswaDN6a3lkSlBGd05zTXRMQ1A2a3RWMEdCbEd2cUtydkhYRmdOTkhj?=
 =?utf-8?B?WUVHeGt5cXBOb0pzekdIZXpucTVZU0ZhcExFT3VqaWZsUGxvRzdHMVJseGVk?=
 =?utf-8?B?NnY1dTIwTWplTk5acTJ0SnZKTWpsTTJWNVgzSW5JWG83c2Z3NG1BTlhSOEVW?=
 =?utf-8?B?NjBHNmFDQ0J4QnRiejRFODMwMTA1bXdncjBTNHZvSEVMbnFXRERBbHhmeGJC?=
 =?utf-8?B?VVo1b0JhY21Eb2xNN0Y3cEdENGM3M3haM2lYUUtuVkpqT2hXZ1Bic1pZWUtn?=
 =?utf-8?B?MzJaM01Ga1kxYWNxSlRLWmJIYzlGTzRPVkNxcTF2amFHRWMveVVPdUNGaDZM?=
 =?utf-8?B?SzUyeTJOcXRyN3BtUGk1aDlsNTdqSnl0bFhVNlQvMTRSczl3UDRuOHJiNjZh?=
 =?utf-8?B?UUUyK2hOUnlLSjdOb2JzWm9YVEFEZTNZZTBWWXdCcmlVdlgveGVwZE1ham9X?=
 =?utf-8?B?Z09yM25iREFwTXYwY2ptMGFWRHlhdzhrNXd4cVpwMTgwdkZXNVI5VTdncFU3?=
 =?utf-8?B?WUN2V004QkVLZ2JPZlUrRnNkb2YrdnZtSHZDR0Z3amFhdTJzLzcwTGJRK001?=
 =?utf-8?B?dmxyRHUrSC9BOEVna0JNWEY0UWxDZ204Y1lMVFI1VmE0bzZFU3N3WUxuTmdP?=
 =?utf-8?B?QVlvNU1qaCtraEZvZlZYcmozcVlCd0ZHQWFjWk55TVJRZmlOaVg4UDdJWUZG?=
 =?utf-8?B?RDJwNENEcmxNYVROWTVwQ241MVRUNVdMcURzUzJ6bkg0OHdnSEFyL3BhanZM?=
 =?utf-8?Q?8Gtfy1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?REVTVzVwMkZwNVB1WU5CWmp6bzVJRXlNRGJjNUxxTjVoZmF1WGZjY2Q1aDRQ?=
 =?utf-8?B?U1oyejhzMWtzZTVjUnRiaFVXZXBMVSt0K1ZvZUxSWEhReitwSGI5Y0hlNXYx?=
 =?utf-8?B?dW41ejcxakc5SkFEQ3dvcWpyWnZpOFl2ejU0QW5LcUtXZWdZcndZZFptc2xz?=
 =?utf-8?B?c0hKL3BTWjlrQk1NeE5QWk93N0JIVGdHbnVxZmtTY1VUUFcyT2ViTUREYWVE?=
 =?utf-8?B?cXQ3c2w4MFlWeDZ2YWh1SzUwY2hyeWp6N2dJSVU2eUM3UDlkUnloOGtFWDhE?=
 =?utf-8?B?Q1pUbzZZaThZeXVlN09XNlJZZy8zd0tLS3E4SjNWNTFnQVdZTk1NY2dza3Rw?=
 =?utf-8?B?TEtwSTBuU2VJUnQ2cllCandXTXgxUkFPTllEOWpZdjRHSmRRV3lEcGx4SU5L?=
 =?utf-8?B?U2xNYU13bGZ1bTZ0dXZkSVhvOUdvdE5wWnd6U0ZlUmJuM2lSVGgyYlpuUjhh?=
 =?utf-8?B?cTcrL1p3eVNRdzQ5NTM4cHRYbndxQTVnTEQ3NU1ZV0o3bDhYd3AwZ2dnRjdw?=
 =?utf-8?B?a0kyMHhIS2ZNZnd5Wms3ZkhkWXg2M2JIMlFZK3FwWDA3TmZmbmx4aWtlTlJJ?=
 =?utf-8?B?SlJLeGNGZTlOdXlUcTZ4dEJlVStkUXQ5VFp6WmV3dTJEWVJHQVVyNjFZRjVo?=
 =?utf-8?B?K2Z5bGRCdktjUVVobTAzSFBEemtmaU90djdqc3RtRHlmUUJ3dW5yOFkyNGNx?=
 =?utf-8?B?VHZpa2Ftdm8vQThrVVFpQThlM3JvOVVPaUZra1ZvSThEK0dFb0l3Nkx4YStx?=
 =?utf-8?B?RG9Uc3JraGVndGtRYi82RDBFZTJBT1lqVjFuRFgwNkREdGdDdVdQKzcvTXMx?=
 =?utf-8?B?ZnpNSE5SejB3SXNKZXFOdkpIZTVsSGI0ZExaVGsxOFY4RVVTb0dtZVVVRVRR?=
 =?utf-8?B?OFlsRy90eXBOUGJIRzhHamxXWk05Wnd3cU9zVmZWUHVwWjQ1aTNraGl6aGVK?=
 =?utf-8?B?UzNvKys2UnNlT0xWN0xlQjcyNzZjRmxjZVFsR0xhbjVDa3BORGtYTTdGNzdo?=
 =?utf-8?B?a2hWYm82L1IyR3hiZnJpazRUUE9EMlpCVVRmQTJ3N3h3L0F0R25RaUhDYm5G?=
 =?utf-8?B?U09rVTRZL2IzVGdDVm8rbEZNRmJ4TGx6VytJMjFJTUtkL1RUVjBCWVBialJr?=
 =?utf-8?B?QjZDTytrN0hQeng1Y0dFMk9kRVlIUlB2N2ExUDVFbHRUYWNuMDJEeExLNmN0?=
 =?utf-8?B?ckdtTlFxNFA4Y3A4NTVYK0dmcXdVeWd5ZyswVzB5VW84L3FiSUVxMFJJVHVG?=
 =?utf-8?B?MjFrOVhEUTlnMm5NbGVZOG5LMTBUUktrcmpiMXhYSURsWUtTM1lPL2p1YWNz?=
 =?utf-8?B?NDJkTXRCeVoybmVrUEJZdjhzQ1pESkpXK2tYekZ3VVE2elBPUWppT0VNVEl5?=
 =?utf-8?B?ejB0YnpNTW1GcWs2NEdrM0lpZ2RjUXo3SWovYXo3QXNxeXc4U0JXSzcvVjY2?=
 =?utf-8?B?ZlBNclRsZzhIcGhIVEd5dm8wUXpnR25pbC9YcWFzTlRVYmViMTcwN3dCRWRN?=
 =?utf-8?B?SEUvNVp4clBBNTFMTWg1eGlvYzJKVjdIcWxBUHdnUFBnaWEwVnNxVzhlcGp1?=
 =?utf-8?B?WnRkQ0tkVyt1dFhxOHRsVEMwQXpZUHRRWDF4SUwrV2hUZjJLanJmYnpKT1B0?=
 =?utf-8?B?azdNajY2VTVzb0RCQ0ZaT0hpd1BYNCthRFFJZjU3L05PYzY2TjlNMEtOY3c3?=
 =?utf-8?B?LzU0NEwyU2Y2MmkxNGIrWjhaRnRhdm9EempZMDJyMWZ5eDlic0hOOUhEVWpW?=
 =?utf-8?B?VHR5SityMXFnVVRlSVFaWlJZcS9qNk9MUTlEc0R1eUNoU3RoeEpYSDZYandx?=
 =?utf-8?B?SlFpeVRxbzhDNVplaVVuUHFucSs0VUlLc2VZdFpCQ2x6RDkrT3pDbWN1emlM?=
 =?utf-8?B?SU1lM2V4N2xnLzc1WHNVTnlrQ3IwYkcyQndXWlVHbXM1Z1pWL0puekpnc3VB?=
 =?utf-8?B?enJQYkhwNXFCbU1ueW1LM1A4T3VXenlka1NVSFBVV0thaGVQZkhPQzFkM1Jw?=
 =?utf-8?B?cUhLSlB4MWVLMVAvYUh2bVlIY0paci9CemVSS3NLandObTBweG5IS2cyVnhx?=
 =?utf-8?B?RVFqRTkwV2F2Y3ptU1pJblZwWW4wU21paVZXYnFIZTNKbjlKNUNVcTI0MDlS?=
 =?utf-8?Q?sxQI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25F9997A3903B8478F020410937E98CD@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a61cd880-d9b6-489c-479a-08de0593ea0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 11:23:17.8125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ys/QYJMOM8cT3vinh2xu2CcjhOg0vUi7k7nfaqyCTl9iIajGx1PUuRI2/YNb/Vus6a4oQbfTprO6RFdRx17mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1647

QW0gRGllbnN0YWcsIGRlbSAwNy4xMC4yMDI1IHVtIDE3OjQxICswOTAwIHNjaHJpZWIgS3J6eXN6
dG9mIEtvemxvd3NraToKPiBPbiAwNy8xMC8yMDI1IDE3OjEzLCBZYW5uaWMgTW9vZyB3cm90ZToK
PiA+IFVwZGF0ZSBDb3B5cmlnaHQgeWVhciBhbmQgY2hhbmdlIGxpY2Vuc2UgZnJvbSBHUEwtMi4w
IHRvCj4gPiBHUEwtMi4wLW9yLWxhdGVyIE9SIE1JVC4gVXNlIHN5bnRheCBhcyBkZWZpbmVkIGlu
IHRoZSBTUERYIHN0YW5kYXJkLgo+ID4gQWxzbyByZW1vdmUgaW5kaXZpZHVhbCBhdXRob3JzaGlw
Lgo+IAo+IFlvdSBkaWQgbm90IGV4cGxhaW4gd2h5LiBJIHNlZSBubyByZWFzb24gKG5vIGV4cGxh
bmF0aW9uKSB0byBjbGFpbSB0aGF0Cj4geW91IGFkZGVkIGNvcHlyaWdodGVkIG1hdGVyaWFsIGZv
ciBlYWNoIG9mIHRoZXNlIGluZGl2aWR1YWwgZGF0ZXMuCj4gCj4gV3JpdGUgY29tcGxldGUgY2hh
bmdlbG9ncyBleHBsYWluaW5nIHN1Y2ggZGV0YWlscy4KCkZhaXIgZW5vdWdoLiBJJ2xsIHJldmVy
dCB0byBsZWF2ZSB0aGUgZGF0ZXMgdG8gb3JpZ2luYWwgcHVibGljYXRpb24gZm9yIG5vdyBhbmQK
Y29uc3VsdCBpbnRlcm5hbGx5IGluIG9yZGVyIG5vdCB0byBob2xkIHRoZXNlIGNoYW5nZXMgaG9z
dGFnZS4KCllhbm5pYwoKPiAKPiBCZXN0IHJlZ2FyZHMsCj4gS3J6eXN6dG9mCg==

