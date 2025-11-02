Return-Path: <linux-kernel+bounces-881824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B15C2902C
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 15:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E42188D6F3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 14:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B89223702;
	Sun,  2 Nov 2025 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pGOzhWOF"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171BA34D3A0;
	Sun,  2 Nov 2025 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762093508; cv=fail; b=OdPLA72DUIaD/A0HHCD3Cn79BEktXAkKxLt0ZVloGZlGLQoPdOs65Lo5x/dwuV7KZDE+sEEG8GNuoSWwpjcCTuZcfzGP94c+cMgoWh5EBx9fD6F61Tjs0VqzWQyGZCgk64paWZWrYN+IsWetOeC2DOXTAgCv9pqCI1/NdeZCsps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762093508; c=relaxed/simple;
	bh=8+6e4SDvJ9VYNkl74C1C7bk0kyIVOqZkcdNPik5wrEk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=n5WoYX9yroWAf87P4uGN1lsVKyvTA2kxapDZ40nSC0gk4scS7NAbio2n9LqfpcVJXuYxrJTzRpcoHG5dLeYBlinZYLwscYGvfeYBRRK4CRYReuvvtUIDwupOykjjxbLXLFeGrDCKbnn0h+0Ain9THucEXeOMrMeDbAEv8k08EYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pGOzhWOF; arc=fail smtp.client-ip=40.107.208.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O63hIsZyiG1uLGuc8bHroXGEuPUtg4evO9sFBS4/G4q3cYvLum7mXFOrCWJm1MRz384ynPnNWzdo4xU7fXkOPQQ06tqY+AmIT3Yd8SvRzCFZGR/1JsyoPA2GX1aGIAeu8B2XjKkBME1S6VENbX+S3S2zyUPikixVRFVJ3LLRv8D+v8DFR2lAa8ZOXLEh6w87th7uwy/Rl0tQ6Q13+1hvoHvje2i7km4l7mZiL7KStSZfL6kqrUgpWc1Ock9eSWiKd3mcyA5UifxeQPKrcGXS1TYMc58GGxUcr0KfqIWVUvKer/AUQb24qf0l5sNn1yhD3rDGXCL6q4rJryVJUC8sMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wgu7qBXmBn3bOzgXafZOQwki4S6O3nCj69slvl88tHY=;
 b=Gm5y4aVEvByGTE3zXNypp8JhKiDhE7t2qZbNHZVkiExLqMc138nF6eityblQD+JAkOD8QMscd4ONEK/syzzNOQUiTngdb7lIthqZT8WFwBWCcCvS5e3fAR7HytV3EoioMMt4jP1xUu3S9ZQ3ee3gCHwkTZrRi4MdykQ4SJ65AEPlLHlC19Kbq5wFpWmnzHyr699AXaOJvki0pE8BFsffDJJPnKgx5MFioz9MaFpT4eidyWnWFnM/WwpzVHBoCXQUP1tSxaOLH/JfKebZLnbqBOHi2+ZmHvdkL9tqZeTVxDrOAN2b6KqHsQ81vkNY9hek4wN2NATZjTUGIY1YCX19LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wgu7qBXmBn3bOzgXafZOQwki4S6O3nCj69slvl88tHY=;
 b=pGOzhWOFy9/4fK6p983j0zRcGZ302W5pQN8QJabk52SCVmkdYE3vl8sbrLRtP3B4W3i45490zK04ZisBh024sKFwW6wRj810/R2woECYGLVtISRPmSXPj2hKMa+bY9G2nrgWi++BH4zGl3dxneByjsCM0MZIY9w2q5vAOSxLd5caeBIW79m49KtuyIRfEQ3/nwiDIcNWdgfVpTRMHxnrWHMnNTBM5gJBJNaOBgnvoVjmqh/6rS0cnRICNA6uhCTOsoEtgXGlGbJJiEKsvrVeoGCGhOlRQsfqAafgc95TfwCNg00/LUv4vg852SrSqTb67j3DKI6N0lVou/WCs10Log==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB7158.namprd12.prod.outlook.com (2603:10b6:510:22a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sun, 2 Nov
 2025 14:25:01 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.013; Sun, 2 Nov 2025
 14:25:01 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v2 0/2] rust: add BitInt type and use in Nova's bitfield
 macro
Date: Sun, 02 Nov 2025 23:24:41 +0900
Message-Id: <20251102-bounded_ints-v2-0-7ef0c26b1d36@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKlpB2kC/23NTQrCMBCG4auUrI0k6b8r7yEiaWdiZ2EiTQ1K6
 d1NK0IrLr+B552ReewJPTskI+sxkCdn41C7hLWdtlfkBHEzJVQuhZC8cQ8LCBeyg+cSRJaXUGt
 UBYvk3qOh55I7nePuyA+ufy31IOfrN6S2oSC54ACFMHklMtTZ0QYC0vvW3ebwR6Xyj0IFTQuVA
 V3KtZr/B7X+Wf9oFbUxKZQGMTUGNnqapjfqwbsdHQEAAA==
X-Change-ID: 20251001-bounded_ints-1d0457d9ae26
To: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Jesung Yang <y.j3ms.n@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0251.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ebb94c-1e02-4357-7ef7-08de1a1b9b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WG83Um04Uk9tTUQvYjdWeXdGOEZTeHl3MHA3TnhFU0VmNzhkR083QzdiaGJU?=
 =?utf-8?B?TkRZU2dxbXNhUVU3Wlc4dEYrb3Fvbjc0YUJ6WU1DVXBDL0xLQkFzTnJibkpP?=
 =?utf-8?B?RXpPeExueEtpVTBINGlrL3Z3cldRK3dGNXRLSWxMWDNiQmRnTFdRNm43WVRa?=
 =?utf-8?B?cmdaczVBMm85bHB3QXB0M2c4VXdnZTM1aEJMZi9OV2t2VUxQd1dDSmVKdnVV?=
 =?utf-8?B?RldhcThWVkZQd1lwMXhUTWI4MDNPaDBod3BIWlFKREd6MzlCYm9IUkMxRVEr?=
 =?utf-8?B?elhkSmE0cHpRNnhXa09wanNycGpmTVNlZU4yUjFPdFZEOGVOL21uRHNnSnhi?=
 =?utf-8?B?bnBXZ080eWF3azAwYXFOSzYzcVVKS0xRR2lPTkJuNlliZVgxY1BXS3RvRURD?=
 =?utf-8?B?L3N3bmJDUXJHY25hZmhWU1NTa3ZWeFRiK3VnSVBkVmU1Yzd1OGxJZTFOSCsy?=
 =?utf-8?B?UW9OanlqWG5qQW80VTBCeG5GbDd4V1QzenFpak1CcUJIVHcxQnZZMllTb01Y?=
 =?utf-8?B?QjhYVXdiZDdYVStiaVNsV2ZTdjI0Tk1IUkJBWVAvQVJpOFJNcVFhMXRXRzB2?=
 =?utf-8?B?bnV0Tkh6a0NSeVlaSEE1MGs4azhwdTljckJrb0RzVXNGK214YjFmMGQ0Ukp5?=
 =?utf-8?B?VFJCVFJTN2FRUDdrT3RJTW1uWGt3bXFUMlN6cUQ5ODJFM2hBSWt0eXlYRkZL?=
 =?utf-8?B?THBUUmhjYmptNVJtTHRoUTczUWptQXFQK3hoNEVZbGRVOXkwRkFnVTZ1OHVx?=
 =?utf-8?B?WDY5YzBZK25vWmoxZFNEMXZNYUthS294c21idkJCUnc3S2NxeGRWazRIN1lQ?=
 =?utf-8?B?NFo5RHErcTdxRDdadXpiTjRWN0VrMC8xZDJieE9mNmF5c1d3NjViVHBDWlpl?=
 =?utf-8?B?cnRySDUybktHalI3N2ljcS9lQ3A1UDM3OWgxaFJ4U3RlWExtejB1R2lIekZF?=
 =?utf-8?B?a0F2Q0piL1ZCUEorMkJOa0hPNGJkRWtyMlp4aG9LVmViR08vYXBVYVQ2N2ZH?=
 =?utf-8?B?bnBrZG9WVXN4emMzbFFLQWFKeHhxU013TFUwbmZLWHEwYUVBQ3ZzVTFWTzdo?=
 =?utf-8?B?VmErV0wzdGpTUGN4blBrMkNIaGNnRTBFMCthaWk3OGg3SEZaRG5vOE1oMzFP?=
 =?utf-8?B?b3FaTnhWeWJEYjIxM21NcWJyM2JuY2p4UFpGS3NLUFFPdWFjOVpTcjhEQnhL?=
 =?utf-8?B?ekxpdmhhY2htTllNbGY5V2N0ck1mOWRUdEtRN1UxZEpHRDhKeVMxMW51TWh5?=
 =?utf-8?B?K2JvMXZUQmdaYWc5eDZLMHd3aldwcE1ETXpkRUJnaGJxM3pHbGdrUHd1dkhu?=
 =?utf-8?B?NHFsSEtVTnZVY01NM09rL0M5VWttT3BHb2NNQnN3RFRqaUJEWEpGTWxGMURG?=
 =?utf-8?B?OWVZUVhjb0VhdmlSc2JLdS9LeW5lbEVUTlA5Ym9EMTJlNXlLemd1ZitFUElu?=
 =?utf-8?B?a3V4MHIxU3M3UExnOXdmOUVCQmlicnhzM2Rya2MxOG5VanFFd2M3dWZzNUNn?=
 =?utf-8?B?a2RQcnB0OEU3bEpFcWcxeC9OZnEwNkxmU0p0cEhGa2Qxbk9rUG5tMFo3WEw0?=
 =?utf-8?B?ZUpVaXE1eEFZcVAzRW1TYUp5Nis3K2dzOUFMV0RrQ1JYbWQwWU4xSThNSDhC?=
 =?utf-8?B?dVhoNzdFQzd2Z0lRVXVpUENlTUh5QU1DN2J3RG5xSVVSK2VhREVtZ1FCUmha?=
 =?utf-8?B?S2orWmIzclk3YnUzQ0FmOFU1ZXVORndjL21pQVpjMVNDb2FrdnU3VDhwTXA4?=
 =?utf-8?B?R1Iwc0RkMDRVcnZHU3gzOU1jSGFNaysxM0xkMGJmZmU2eXQ5VFJDcVE1UnYv?=
 =?utf-8?B?dkNEc1dlTk5udTdwMGFWcEpCamdiM3RkQ3gwWElKQkNlNXMwdnVMRnVWdzl1?=
 =?utf-8?B?UXczcmN2WFVpRWdjQUhaOEc3NWR6Qkx1c3NXVFU0VmJ4citJbk9NbFVvbjFF?=
 =?utf-8?B?QmtocTd5SXRJNkdtOEdxeXBDRGV1RjNia2orRmV0SnN3ZTY2ZWNBaUlQUU5n?=
 =?utf-8?B?OXBGRnEwcmVwa3pIaVdNMmFzTlp6cEFCOUJadXBscWphS3dGazBjRU54ZUtF?=
 =?utf-8?Q?tpA8tF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aE4rcWloUHBTSzg5TEtJV2RwUHJHdmpPa0loUjlERnpsL1hjR3ZOaStHVk9t?=
 =?utf-8?B?VGFlL1pxT0V4ekI5RFFMbGRHRytIMldQWnhxVjhlTms4aSs4SVpVY0tlY0Vk?=
 =?utf-8?B?OXFQa0l6MUVPTldYR1dLbnoydGl3THpqREN0dnNCcUQxa25odDBCSDJaQVBN?=
 =?utf-8?B?MFdkVk16MzRDSmVISnhpenpFWHhuanYvOVN2SnAwajEyakRmTng2SkJwQTNp?=
 =?utf-8?B?K1M1UnpsdXg1Um9qM0JHc1hjMTBqS0VVOFZhclNoSjBKdHNKRG53U0JXVzla?=
 =?utf-8?B?elEzdXhkRlBNN0taNkliNTQ2aTU1cVhlYngvclRRdExHQmFrM1RBRlUvME8z?=
 =?utf-8?B?Y0ZCQzc1a29pMjRIYUZyKzk3OHRyeTBodWNaS1NGSDBGOXhXdSs5dzRUa0RI?=
 =?utf-8?B?YWdON1A1OE5USFA2S1R6amFqaWJROWw0SE1SZzdCa3BBVHZPWFA0bWdzM0lj?=
 =?utf-8?B?aU10YlBrcnZaNU1wWGlHclR5MmpRNVc1MERDZzF1WHlVazRFck1IOGQ1MDJ4?=
 =?utf-8?B?ZTEyMTM5N0lacVU2RUpUaGwvKzFzR002cHE3TnkvV01GUW9PNjlWcks4ZE5W?=
 =?utf-8?B?QVlBRHdBYmlSWDlvZ2dBaGUvWHYvU1lKTENOTU1KTjZJRnNidUpPNXJyeWE4?=
 =?utf-8?B?WTl1UUFsOUdOTThtdUNTbEcrTVBEdlFTYlgveG1HRHBLVldIZVoxWHJGTmdn?=
 =?utf-8?B?eUl3WWgvS3BmOUtZby9keVlWQUhxRFlydFRVeGlOZjZrcThnbldKUGg2RHNO?=
 =?utf-8?B?Uk5SclRpMDFjd1FVUkMwRGZIYVJHQkFRc3MzTFVLMXVkMVM4TkpONnNWblNa?=
 =?utf-8?B?Q3orZUxpS2hETGcwVGcreUx5TDlVZWhEanJhaVR6QWo0d1M4dTZDSnJXSi9z?=
 =?utf-8?B?ODBJUzZrSm1vZFhyQjZKV3ZsLzVoYUY5U0t2ZzNiczVESHdqYTVzLzZwdXAw?=
 =?utf-8?B?SlBHcnNEbS9YVmRmaVJMdTJpUG1jV1ZyOEkvcXF5ZEFFVHRHV0E4MVNSTG0v?=
 =?utf-8?B?MDVob2VKSFVVK0NscEtHQjBCUEp5cyt5YnJpL0ZpT3N3QUR1KzVYOER2TzVL?=
 =?utf-8?B?NUxqSG5xdklKL0VReFpWQTNTTmVqMDI1YWtmaHRWQkFSTm41YjhQaG5NODRX?=
 =?utf-8?B?OFJqclFaTCt0amlBUDdXdTBYbE5WbExzSW51LzVjUDlJM0xaOVlVVXhWZWVs?=
 =?utf-8?B?YVpvaVVKTVB1TkFoSWVZVXRFMnRibGFrbEw4UFVROU1INkRBQThyK1BoQ3lj?=
 =?utf-8?B?ZnIveXBuSGdFTWU1K3FCakN0OEhHUU4ra1kvR1RBUjRJeXpzYWxlTjdIZllG?=
 =?utf-8?B?K1I0b2x0d3kyNEZPOWRlQUIyVUZwdWNZM3lneTZhWWtKb2VZRmRMMlQxMzh6?=
 =?utf-8?B?L1VEMlpnTXRYaklGdnFFcTI0b3dyVmwyZmd1dEZQT0cwVFRoYWRhSFNoa0ox?=
 =?utf-8?B?NFFQcmtNbnU4UVY0ZC9mYkEzelpyRitwY2JXVlpDZVNDNWc4NFRuYTB4LzQy?=
 =?utf-8?B?S0NKWStJQ2pmUlpWOHF1U1U4UStIYmtvU2dxZ0JVZWw1VE1VV1RsOFpnR0Rk?=
 =?utf-8?B?clBVZ3ZEek5RVkdUZVoybjRPdW94Q1UyOTNrcVB1RDM2WmJVWW9Gako5UHpT?=
 =?utf-8?B?TGREZjlOOGgvbnI0VlRiZWE0aWdMNjVMMy9pUjZQblR2Tzk1dk9vYXZiamc4?=
 =?utf-8?B?Y0ZVSDRNM25sWG9veUJVSUQ2eGlxUXBhaHFEOFdZck54YVY2S29vd0RZc0RP?=
 =?utf-8?B?Q3lVTnpFS21wSHllSEcwbUxHS1BLczVxbzR0MWJSck1pZnUrZHFyYk82SEVF?=
 =?utf-8?B?bGF3TCs3TW55WHVZM1dxSjkwWUhMT3hvd2UvKzRkT0M3aUp5R2ZkNWFtVGl1?=
 =?utf-8?B?Uk00T1NNRGhMRldGNURzVWJHMHZCVWJaRTdQMnYxWEMzSnh4QUdWMTRPTXd2?=
 =?utf-8?B?K3FoL1lEQnkyRXJxN0JZZE9HOFluQ2I3REZoVnRJdUZyZWxrQmJYdHdRRVBz?=
 =?utf-8?B?TWpMUFBUeEVtOUtqQjVNNERONVgzMEx4enlFMjNqakplZGcxYWpHbDBqV2cw?=
 =?utf-8?B?VkJFNjc0Snc2L0NQNGRxeHN2a1VEdUozSm9YV29BVXZXSVg2Yld1RldndmJD?=
 =?utf-8?B?R3l4ZzA2TjI3aWlRN25lRnF4angvQm5oUXpTNTRFcFJvcHVSYkJaSnhBbU1B?=
 =?utf-8?Q?frLoZHiIU5+t+LEawc2Ky0Otl2Lsj5OkZXNCaVWOys0s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ebb94c-1e02-4357-7ef7-08de1a1b9b57
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2025 14:25:00.7961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5H1/otAjEbEJGm8vYZlMnDCc42/Q9mBEcQbFQN2mJDETgN46DiedVPa5QLzxyG5pjgFOJmthHBdNhFlNjz1wsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7158

Second non-RFC, with quite a few improvements - notably, the `From`
implementations from and to primitive types have been simplified, and I
guess that's the best I can do without the `generic_const_exprs`
feature. Another improvement is that the type invariants are now
enforced from a single place.

This series provides `BitInt`, a wrapper type for primitive integers
that guarantees that only a given number of bits are used to represent
values. This is particularly useful when working with bitfields, as the
guarantee that a given value fits within the number of assigned bits can
be enforced by the type system, saving cumbersome runtime checks, or
(worse) stripping data when bits are silently dropped.

Don't worry too much about the size; a lot of it is rustdoc. :)

For a basic usage, please see the rustdoc of the `BitInt` type on the
first patch.

The first use of this will be to represent bitfields in Nova register
types to guarantee that no data is ever stripped when manipulating them.
This should eventually allow the `bitfield` and `register` macros to
move out of Nova and into the kernel crate.

The second patch is here to illustrate the use of this module; it is not
intended to be merged this cycle as it would likely result in big merge
conflicts with the drm tree.

This series applies on top of drm-rust-next for the needs of the second
patch. The first patch should apply cleanly on rust-next. A branch with
this series and its dependencies is available here:

https://github.com/Gnurou/linux/tree/b4/bounded_ints

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v2:
- Move type invariants of `BitInt` to a centralizing private
  constructor.
- Simplify `From` implementations to and from primitive types.
- Remove ability to convert between unsigned and signed types as it was
  buggy, and its utility doubtful.
- Use macro to implement `Integer` and avoid repeating code.
- Fix a few typos.
- More doctests, and split them into different paragraphs in the
  `BitInt` main doccomment.
- Fix build with Rust 1.78.
- Finish implementing relevant `core::ops` traits.
- Link to v1: https://lore.kernel.org/r/20251031-bounded_ints-v1-0-e2dbcd8fda71@nvidia.com

Changes in v1:
- Rebase on top of `drm-rust-next`.
- Rename `BoundedInt` to `BitInt` (thanks Yury!).
- Add lots of documentation.
- Use shifts to validate bounds, as it works with both unsigned and
  signed types contrary to the mask method.
- Support signed types (albeit with some bugs).
- Use `new` for the const static constructor and make it the preferred
  way to build values (thanks Alice and Joel!).
- Rename `LargerThanX` into `AtLeastX` (thanks Joel!).
- Support basic arithmetic operations (+, -, etc.) against the backing
  type.
- Add `Deref` implementation as alternative to the `get` method.
- Write correct `Default` implementation for bitfields.
- Make the new bitfield accessors `inline(always)`.
- Update bitfield documentation to the new usage.
- Link to RFC v2: https://lore.kernel.org/r/20251009-bounded_ints-v2-0-ff3d7fee3ffd@nvidia.com

Changes in RFC v2:
- Thorough implementation of `BoundedInt`.
- nova-core fully adapted to use `BoundedInt`.
- Link to RFC v1: https://lore.kernel.org/r/20251002-bounded_ints-v1-0-dd60f5804ea4@nvidia.com

---
Alexandre Courbot (2):
      rust: add BitInt integer wrapping type
      [FOR REFERENCE] gpu: nova-core: use BitInt for bitfields

 drivers/gpu/nova-core/bitfield.rs         |  366 ++++++-----
 drivers/gpu/nova-core/falcon.rs           |  134 ++--
 drivers/gpu/nova-core/falcon/hal/ga102.rs |    5 +-
 drivers/gpu/nova-core/fb/hal/ga100.rs     |    3 +-
 drivers/gpu/nova-core/gpu.rs              |    9 +-
 drivers/gpu/nova-core/regs.rs             |  139 ++--
 rust/kernel/lib.rs                        |    1 +
 rust/kernel/num.rs                        |   50 ++
 rust/kernel/num/bitint.rs                 | 1001 +++++++++++++++++++++++++++++
 9 files changed, 1405 insertions(+), 303 deletions(-)
---
base-commit: 9a3c2f8a4f84960a48c056d0da88de3d09e6d622
change-id: 20251001-bounded_ints-1d0457d9ae26

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>


