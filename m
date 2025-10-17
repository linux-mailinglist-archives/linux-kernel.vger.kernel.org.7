Return-Path: <linux-kernel+bounces-858130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1A8BE912F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389AC3B010B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A573C369965;
	Fri, 17 Oct 2025 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3gAb+y2S"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD7C34AB0D
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760709431; cv=fail; b=ANnC/4Ge6/8RvbxStwP9KMIaYuYWczmbxCCbzx+zxaWKZcc7t+WYPGaZX+xNaS4Rv0UoRmAid19yBaZJHytvPJd59EH36nvhMIAns/V91bmPNpIgNdF+FIFL+laDK8AUKv2GUtCBfAwBXkgwXy5TWzhxSC3OvXbk+XgZDQMeOk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760709431; c=relaxed/simple;
	bh=6A/fO2zJXsamVl0G0uqLVfjWbEvatqg1JG97GDRepik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g2FmJMEe7jXtnyPV0AMTtHmg+8OhL0oVg3tT0emJGBsx0yhlUUb7myqjsB0ac9FCSOMTjEjJNZG9tDNrXm4hQ8ZNeKALWCCAhYlck9xY36KaWyoE1R6qkKTUG3NES6HrBtI0/+GWP97moH7l8ZYAi8F4+MkyNXKgyMPHaYEQP8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3gAb+y2S; arc=fail smtp.client-ip=52.101.53.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2BbF7tHEDHKdILqElCWYPHn/OpWPbSVQcWGDQANXWTQvXt3/uZ7Uy/2gGHtNF7l9BcU0h0Ze+7ZByi0gvtjPIkN+riWAL3hWpghvnNFgkCPURcxcOg12atWeH++fzdSQj0fUYav51SEfNZsJ2/4WmTrUMXrC7uv7oEWBB1D2ZpUsnpM6zQAfEaCSLcH1CwWRSlQA6agIhnTYaMJxKmqzBHOReTsvoFlbf55IZRNvyylD3XI44cDa7agytSe6Scu64Nf6DudY1ckyMUtnTGh7c3VR3MUgH1dWWDpIE5JSJ86oVf2Qrc6oPCt7uEn9MSDxh1PVB07pfL+kjUhktPNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6A/fO2zJXsamVl0G0uqLVfjWbEvatqg1JG97GDRepik=;
 b=Rf3yg2k0yWYtr66GxSH9sMk6sYWrToyidz7bZ53oGCH7o2zVPYDulNmrqnqYU7Hd2iZxZniybf2f6bO+bMdjnmqBFZiP0zHEfS66E6d2SkPOb17vArlr7ny7SVfPPvFDb6nAePIhroski1WokSslelae8eZvvXeqGETS5NT2FYYW8TS5jGWuK2Z+8pPxq91QBb+wKAUlIZLlrPOz90CanqRzzGoPkB4IiI4+Q2ioInrwWbRwziFeIzQTBwzJCbFwBLF/oNm6xhbn5b8EO/wzJ7BuAZDKDUyGEd25zt2NHx1GlI7ZawVEK3grqJnYyndcUzCw7OxzJv23Q18qXjalJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6A/fO2zJXsamVl0G0uqLVfjWbEvatqg1JG97GDRepik=;
 b=3gAb+y2SswDtioF1i0mfaH1CQCX2pCBBa4cVMJLvF9ShtZLyfSxiz5Ro19PBwDSb6BPfkzHE3Dyi2vnNXJggD5e8pAqEYgch7kfi6hpGIKKK3NeCkvfebqupFFNQXHEwWT7MLoc7vMb9ReyIYUKrpGOrKddYNIPGec8s8uMtV3U=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DS0PR12MB9448.namprd12.prod.outlook.com (2603:10b6:8:1bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 13:57:07 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 13:57:07 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 02/56] x86/Kconfig: Add CONFIG_DYNAMIC_MITIGATIONS
Thread-Topic: [RFC PATCH 02/56] x86/Kconfig: Add CONFIG_DYNAMIC_MITIGATIONS
Thread-Index: AQHcPuKwNffSghaUmkGhvbzqd3XcDrTGXXqw
Date: Fri, 17 Oct 2025 13:57:06 +0000
Message-ID:
 <LV3PR12MB9265E6B500778AD03739545194F6A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-3-david.kaplan@amd.com>
 <mor3gytqfo236eiwrdmpghwn5lfobc4ebseea54zsewrtyj45s@7b5xnm3vdult>
In-Reply-To: <mor3gytqfo236eiwrdmpghwn5lfobc4ebseea54zsewrtyj45s@7b5xnm3vdult>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-17T13:54:58.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DS0PR12MB9448:EE_
x-ms-office365-filtering-correlation-id: e2383f27-a65f-4a38-98e3-08de0d850f40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?R2ZvWlp6UTVHbVlJbzZjV2RoaHJVNWdoZ3NXTWdLUmJxUEt6WmExM1IyR1Rs?=
 =?utf-8?B?Qkl2bjZGSkppV2plRVhQRDRKamlHOEVtZW5XM21ycm1CalFlZDVmOXY2L3Y5?=
 =?utf-8?B?R2lFY2xmcFFaZENBcGV3ZWVZa2NLNU82RGZuanRLRG9CcTZDRHQvN1c5dDBn?=
 =?utf-8?B?NmFNYVVleXJLcFZVeW1qb2NJZ2t6dDFKZS9NWnpWeWlub3pIUjJzQzI2MVJq?=
 =?utf-8?B?MUxFSXlCbmRSZU1OS3NYMlR1YkZsbkpEK0hSdkJETkF2cXh4SmpJbVNxSXRW?=
 =?utf-8?B?ai8zNjVJcm9CVWNKZm41dkR5Y3NrUTJQTE9vOXdZRGRlL0FHa2JpWTV6czJB?=
 =?utf-8?B?UmkwSWI5WWp6Z3hNdGs3aVJWaDBqZHdvOGdNWnJmT0FQYkNLb04vdkNMMUF6?=
 =?utf-8?B?ZHg1VFRIbUZIQXVObkdVT2dvcHhJNzltbGFkR1F5WU9PNW1lbGZLaFZGcDNl?=
 =?utf-8?B?cnZGU0h1RkFKVkhHdjBsNnNYcXlhUHc4Ym0yWTZneWtXMWQ1OGU5bVQxVWhp?=
 =?utf-8?B?Q3lFMFV1V29tTHZkSldSNFBMRFN0c1VnRU5UeGQvbEljQ1FXL2V2VHZ3eGRo?=
 =?utf-8?B?OGpjYWI0YVBiZ25QdmtRWXJ6dGQxZG5PTk9COUFpUHRyZ2dFRDA3TEpyOUNI?=
 =?utf-8?B?bW1SWlJkUll5bllacjg3YVdBOEw1TXhDak9vMDlxd3ROVERlZitWM3pBUVFa?=
 =?utf-8?B?UE9pMGpFR2poY090Y3N4TWxocUJOVzZNeEVtRHgvTjFKVzRsckZ5Mkpkam00?=
 =?utf-8?B?cldaL1FSaXFBMGpTcE91RDFsZkJCUW01ajUzdGJwcGtmUVpCZ2U3MXZzZzM3?=
 =?utf-8?B?OEp6eHhoSU56Yi8rTFd4RjRuQjNTT25aU3Jlc3hndk4vZ0tVaWF1ZHRnVmNF?=
 =?utf-8?B?ZmJWYnZGdGtvSk5IU1hjZWx1dG5OR1gvSm9abDkwVTN6a2VRZVlyUitaN2F3?=
 =?utf-8?B?MnpuejVidzhZSHNDN211UkUvQnA2QlIxeStPVjdhSlk0aFpwYTc0N2RtY0Jj?=
 =?utf-8?B?NUdHWTNPZjFlWU1rRmFnT1UwL3NDUVl3RUdwNkljakFmQnptSitCdFdnZDlF?=
 =?utf-8?B?SXRYbngya1dCQm5GM1hqMXJzRjF4RGdhOFBLZkVyemEvcWx5VVdSYkIvUGxp?=
 =?utf-8?B?T0d0ZDMrUlQ0eVh3TEFHblkwYmJ4cUxNeTBsL1llUHBrdEozZlVjbXk1bUwz?=
 =?utf-8?B?RlMveFRIYm9Vdlozd2tWcCsveFVwQXFuaDRyNVhQZGpRRW5BL08rdHRWOGpG?=
 =?utf-8?B?NEZoVXlBWGM1R0daS25OYUVTemlnM0g4STZHTGQ0TzdqVmdBZU5aTk9oRUxh?=
 =?utf-8?B?QmF5ak8yeGdGd3ZvKzR5Y2dVaE9JOVRsSWJYN1dSYkhkcCt5ZWU5K3U3L3FI?=
 =?utf-8?B?TmZqUmJqNkIwK3BzQk9ZZ1ZWVWoydTltUXpaTHNvdW1UOE9zT1haY0VuVlN4?=
 =?utf-8?B?QitvR0VjenZrV0kreHNFQ0xoTDk1MjF2UUthMFRDV09PVHBJaDBwdXBFZlFD?=
 =?utf-8?B?SzlSNjRhOEJ6YzVBbGFwR1h1WnNHc09PQVN0RllRQTRnRDVlZExPOXBPM0NK?=
 =?utf-8?B?ajB4dEtlaUF3K3FYZnBOUmxlZVBOcnRKRFFBMThpak5VNk9UQUY5bEMwUTRR?=
 =?utf-8?B?YWpqNDNGSzdWR0JabFdsMzZtTVY5NHlGZGxpeEVNUUJySkQ1OHpGUVRtYUVz?=
 =?utf-8?B?ZWVRbmtHTVc0SWN2dWpYMUVOUlNxRlczSlBBUi9CZWZIandwWHIrV3VuUzN3?=
 =?utf-8?B?c3N2VGlWMlg4YW5hRmJ3MWI5WFc0Q1pnVFFmNVVwSzFwcCthelBJaVFvWjhv?=
 =?utf-8?B?aDRxVGNYMWJwT0t0Y0pYVjRuZVVSODJzNU1taDVuenpvZ0NHTnFqcENvWkl2?=
 =?utf-8?B?cy9pRkZIajZUdldoN1ZkZWtxQmhoeVRGNXZ3MWp2MHEyREg5SnBocHJxOE9a?=
 =?utf-8?B?V2JxY3ZtU2x1L2NkUEZ4WnZHNVJ6anF3KzFkZCtFbVpOWFdMbmllSVNiaTQ3?=
 =?utf-8?B?cFI1dHMzaTZiTFpZRHRHQUhScGIxbUxEL2RqTlVhR1NXa0piR3pkL1drNVpV?=
 =?utf-8?Q?dXrkFM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0xJajFVVTlERDI4S01NRVJtRUt5SDFUbitTUFdtVGZLVlVSK1BzZWFmbnEz?=
 =?utf-8?B?Tm5Za1pZa3BBVlcrMjZEeTdFdk53aENDQUNTb1U1eDdkNnpOeHo0dnlKV2cw?=
 =?utf-8?B?NC9Xd3F4UktuNUIrT0o4VngxZkVsQ0NlSk0zR3Foa1I0OW8rM25TNmlNM2d1?=
 =?utf-8?B?eG5wRkxrR0dTbzVEVU1aMitTQ1NQSXdmOVAyZlZwa2VpL241VzZYblRsTzJM?=
 =?utf-8?B?aEpjK3NRREFKUTJrSWlnVkNCQmZSTUxIdG1wTStCVW00TTEwajNYR3p1alFU?=
 =?utf-8?B?YThUcTRadXBZK0kzNExIaHdPM3YrdDRydFg0YzQrNWZhZytwNFIzTFMwQ09E?=
 =?utf-8?B?anl0c3RQSHNhemtkNjRGbGVrOXBRUG1yNHZuVGRmbGdFVmNEUVByODB3ODZZ?=
 =?utf-8?B?Qzd6WkRES3dYQjRBYURqb0hnM2MzS0ltWkc4VUUrdy82UjZHSGJXMlJOY0FY?=
 =?utf-8?B?dXcyQ09Zd2xOenJIeGppSDE0STAvYnJHdjllUEM1aVJ1dzBGNUZkMnBscUJt?=
 =?utf-8?B?aHZwQ2xVcmlYcTZTbmg2N24zMjZFZExZOGhsdklFWXRxWWxKd2kxQjczVkdY?=
 =?utf-8?B?bXV4aTVmeUlncTVZMW05QUllbFBzdUFvakJCMFM4aUFUMHF1eWFCaHlZVTNZ?=
 =?utf-8?B?ZkZraFJBZjR0bHZhc0JENTVyLzZoeFdSdEoybVJCZ2Z0TytwWHp5MUhmTXhy?=
 =?utf-8?B?Nm1Sd01qdWJYd0prZS9wWE14WXl3cXo0MUUvcE9iWmhWZmpnb1VBOTFMaW5o?=
 =?utf-8?B?VkhXd2Y0Zzk2N0ZoSEtGNitINlJZekFMamRod25MVGhwaEZFOUtYVVQ0aTV4?=
 =?utf-8?B?K21FU2hLd3AvcnlPaGdzem03SytjcEZkU0VSQTdPWGVjYU1tN0hIYjZNb3lB?=
 =?utf-8?B?eFVMTld6ajVzbjhDeUc4MTNFSERQakh6c0FnaHo2NjM4ck0xU2huSENQNXBr?=
 =?utf-8?B?TTZuMXlGUkpoMm5LczJ3ZHJxUlZmUWZ1OU5EaXhTaHRzR1BSTGZKRlRmK2Y4?=
 =?utf-8?B?UFB1b1RNU3BGUnRoOUNFSVdUc2VxSmNxTmZEQjBZVTRwMStQSUZ5UDE1MGNu?=
 =?utf-8?B?Yi9lNjBZc3ROSUFjR2xRRjFWYkRoK0thWjlPdysxRHdsRFhzemhSMnB6dlVj?=
 =?utf-8?B?ellUcm9QdzBsUXMwa0RRM0h4bXNza3pzZlIwNXl3cEZjTTh0ZVRVT3RWM2hN?=
 =?utf-8?B?YTJQYWJOc2NlYkE3WkVPMG9leUM5dnU4WXpZd2xIRWhFZndEMDl2dDFTb0dW?=
 =?utf-8?B?UTd5a1M0Ui9oVjNjK2M3bEJFUWo2OXVOYUg3cXFsRHJjUE4wM0hmTm91MnNS?=
 =?utf-8?B?RDBIMlo0dXAvd1B4TG1FdTZTTzFGMkFBYmNQMXkxUUVNNnVYd2ZJa2F3Sm5P?=
 =?utf-8?B?NnlHQkJ3NDF5NTJSZ1Y0ZzZQNEVYc1lkaUJmaTFHZUpaazFTUlRNdlBtOHFh?=
 =?utf-8?B?TnN2T2NGWnMzOCtxOFoxa1FJT3hKeGtjU0k4N1dPMEVnNzJmZXprb3NiN0Yy?=
 =?utf-8?B?azNPWUNWclphbUtnaXgwY2FVZ3NyaTlneDdJdFdTbmNPUDgrbU9ZbEhQcDlv?=
 =?utf-8?B?ZkJDTGFHZHU2M3JqcC8yNXQvMUdWRDFSYm5hWjk2TG9oTVRScEVBc0xCQ0R1?=
 =?utf-8?B?TGVaeEkrR2dNZURVTzFWNDlWY1V0VE1oclVyOUVjV2o4b1RKeTE4aFlNcTZ4?=
 =?utf-8?B?SlhIblFoRGlMSW03Njd2OXVyOGcveEdKR3dnWi9xZm8yZVpDYnc2U216K01T?=
 =?utf-8?B?ZzlpQzBEeEszQ3BsQXZsYzRjM1I1YXhwSnYxRk13eVY5U3o1RnpieHBNNFls?=
 =?utf-8?B?Z0lneU9PN3pWRVk1RjJkeDZXRUVmWnRyN3FlcnVMOHJ6M252dnZVSDE5eEZ0?=
 =?utf-8?B?QXVyRTk0WjRiVVU2aGg0RS9ybTI1bDBGQUpaSHlqdDlFU1dhUi9zSUVpS2dK?=
 =?utf-8?B?eDJsM0s1WXBSUGI3dVY3UHJqV043SkNlNURiMm5yRnFLWlBkY2N2YTFmWXky?=
 =?utf-8?B?eWlNaERlb1loYVdObm9tdzUxbnkwVktwRlhkbmYwbllmMk5pVFp4eG5CbVQ2?=
 =?utf-8?B?M1FlandxRnhkaEJxY1gxT3BXRlhhRTFKZFBQQ1ZRMG9Nd1dBMFM0ZlVINURI?=
 =?utf-8?Q?sCBU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e2383f27-a65f-4a38-98e3-08de0d850f40
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 13:57:07.0625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uAsdPsiQLP20PEhGnDFXNXgEuepC4zJT+50mr0OFzwGDU2AG/c8HL2vAUO01tWXT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9448

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3NoIFBvaW1ib2V1ZiA8
anBvaW1ib2VAa2VybmVsLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMTYsIDIwMjUg
NDoyMCBQTQ0KPiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+DQo+IENj
OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47IEJvcmlzbGF2IFBldGtvdiA8
YnBAYWxpZW44LmRlPjsgUGV0ZXINCj4gWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsg
UGF3YW4gR3VwdGENCj4gPHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IEluZ28g
TW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgRGF2ZQ0KPiBIYW5zZW4gPGRhdmUuaGFuc2VuQGxp
bnV4LmludGVsLmNvbT47IHg4NkBrZXJuZWwub3JnOyBIIC4gUGV0ZXIgQW52aW4NCj4gPGhwYUB6
eXRvci5jb20+OyBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPjsgQm9yaXMgT3N0cm92
c2t5DQo+IDxib3Jpcy5vc3Ryb3Zza3lAb3JhY2xlLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMDIvNTZdIHg4Ni9LY29uZmlnOiBB
ZGQNCj4gQ09ORklHX0RZTkFNSUNfTUlUSUdBVElPTlMNCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNz
YWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlv
bg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25k
aW5nLg0KPg0KPg0KPiBPbiBNb24sIE9jdCAxMywgMjAyNSBhdCAwOTozMzo1MEFNIC0wNTAwLCBE
YXZpZCBLYXBsYW4gd3JvdGU6DQo+ID4gQ09ORklHX0RZTkFNSUNfTUlUSUdBVElPTlMgZW5hYmxl
cyBzdXBwb3J0IGZvciBydW50aW1lIHJlLXBhdGNoaW5nIG9mIHRoZQ0KPiA+IGtlcm5lbCB3aGVu
IG1pdGlnYXRpb24gc2VsZWN0aW9ucyBhcmUgY2hhbmdlZC4gIEl0IGRlcGVuZHMgb24NCj4gPiBD
T05GSUdfTElWRVBBVENIIGJlY2F1c2UgaXQgbmVlZHMgbW9kdWxlcyB0byBwcmVzZXJ2ZSBhbGwg
dGhlaXIgRUxGDQo+ID4gaW5mb3JtYXRpb24gZm9yIGxhdGVyIHJlLXBhdGNoaW5nLiAgSXQgYWxz
byBkZXBlbmRzIG9uIENPTkZJR19GUkVFWkVSDQo+ID4gYmVjYXVzZSByZS1wYXRjaGluZyBtdXN0
IGJlIGRvbmUgd2hpbGUgYWxsIHRhc2tzIGFyZSBpbiB0aGUgZnJlZXplciB0bw0KPiA+IGF2b2lk
IHJhY2UgY29uZGl0aW9ucy4NCj4NCj4gVGhlIExJVkVQQVRDSCBkZXBlbmRlbmN5IHNlZW1zIGEg
Yml0IGFyYml0cmFyeSwgY2FuIHdlIGhhdmUgYW4NCj4gdW5kZXJseWluZyBDT05GSUdfTU9EVUxF
X1BSRVNFUlZFX0VMRiwgd2hpY2ggTElWRVBBVENIIGFuZA0KPiBEWU5BTUlDX01JVElHQVRJT05T
IGJvdGggc2VsZWN0Pw0KPg0KDQpBaCwgdGhhdCdzIGEgZ29vZCBpZGVhLiAgSSdsbCBsb29rIGlu
dG8gdGhhdC4NCg0KVGhhbmtzDQotLURhdmlkIEthcGxhbg0K

