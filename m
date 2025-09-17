Return-Path: <linux-kernel+bounces-821790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5636EB82402
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6C8B7AAFC5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C36B3112B3;
	Wed, 17 Sep 2025 23:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F3XrPynz"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010016.outbound.protection.outlook.com [40.93.198.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B4B2EAD0A;
	Wed, 17 Sep 2025 23:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758151177; cv=fail; b=ejoDftGdQ0m22nmzS029uG6ispMAE4PoqbB9jPDuzA/YXxFW7HXcv3C88SaQdcOaMkgJ/3thC5aPx9euhQ44WQaNYXZr6TPloxWWEzXVhv47rEGDs5kTYpnotdtcrsvplT+J5ovDmQr1ssSgrG7I12Zz/0f5FDX67DkXd/GTtO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758151177; c=relaxed/simple;
	bh=Bxz7VIz7g/nu8JcyIhHe3iJcGtSgYBCdU4gPG0E/3Zo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IdySdYSCvbVcHczKEr/FxcnCWYSLCKvVjfxYekev8XzC7lwyzxnqFRnV1aoblJzhYp0g7JGyEIz6dgojeQryk2fXsdwKAdcD0DsFHV11pUOuPW1GO9lb7zLrRXo9RfvS5S5YGr7EUSXLmhvO5sgSRxq8zmqQdX00bJzI4iIPjfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F3XrPynz; arc=fail smtp.client-ip=40.93.198.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RntFY6rRRsztJCCCf3GHBfRstE+yUeAMsMzjLiLPe2NoGueuY8BjE6XmTyCN1i+uFPOErOfqKOYmMf+yVWtk+Twg1DhhNGISb6AkpQ02+baReJFz3PbBSwoMx9JfIlEKdI3M1rlvTmhVWi4fSEhxTipDjRSJUFPIrHP9SIPCtVCHqZ0ql6BhsHt3U6BfiZ/uk6diMO2yeU3KeJpsmbugz5HvhNVHwvRX+CGQJ+qdKTVu8zvIOmfDYYsG9xt8YtUJZwtEGs0ZpxCVNmOg1I0XC6qdMNFKtpCuCFIV8HgF8cdg/Pi/dW4SO9ZcivyrJwB62xLGPuBC7Qr/tpRMg0GM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bxz7VIz7g/nu8JcyIhHe3iJcGtSgYBCdU4gPG0E/3Zo=;
 b=cVRMDias81nsXvlt7JX+ZPsZJuolJr1byVPBcKN3mu/jSV/u7+wX/nR5HhJNsM2Uh+Vml5obVeskUXz7tEg+E9ebnFy/vpcUFRzq0ZLLGiWHzNrukz2hPu1woE30BJ9b75lOvCzfvyhiWhSYBRlXnTCpp0ZXarEznYgJ7IKQJtgyUJ4Q3h1fJB1/kUeknt1l+nwvlpSlCV/ww/6cctep588gjsCwYxVOIg48ZLXEbTlFG+VaVQwPoATzNzjzbObDGF+crqMHUqdotujKO9qtvHNeHKBu23Oe9l1DflkPauJEhDB8P0TLSNfDxtEsqDIaEhyGiMXAho5qR/vldEoJ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bxz7VIz7g/nu8JcyIhHe3iJcGtSgYBCdU4gPG0E/3Zo=;
 b=F3XrPynzFqvu7phTZwwZ/tNcWxVuqKg3jWYBaidRZCrPjfpIs5XapOj5M2bQpwZxMyaSbLkiPu2HfkRX3W7rGl07701PI1g5fTVLlutQtCV4hFRr8s/ZRgV42RfANm45RUryFeYDUD+nxUFDRwqmzHak01SCu8yUf94WmBtCEiw2qQIpqMk+1n40WONDbv8ZelSlKSd7VJeN0P1Wc4dwmXwu/BjHQvVjnSymOYMmX9pVFb16LL1ua5wBXDle0k5w+VsunaPwqjU8/6I/sB6kstBbhjCO6rvkhudeKi+gNiWbIdxaTLyvQoVTtfukZpo5nxatx4D584zIPCsiV2cIyQ==
Received: from CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 17 Sep
 2025 23:18:11 +0000
Received: from CY5PR12MB6526.namprd12.prod.outlook.com
 ([fe80::d620:1806:4b87:6056]) by CY5PR12MB6526.namprd12.prod.outlook.com
 ([fe80::d620:1806:4b87:6056%3]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 23:18:11 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "andrewjballance@gmail.com" <andrewjballance@gmail.com>, Joel Fernandes
	<joelagnelf@nvidia.com>
CC: Alistair Popple <apopple@nvidia.com>, Alexandre Courbot
	<acourbot@nvidia.com>, "ojeda@kernel.org" <ojeda@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, John
 Hubbard <jhubbard@nvidia.com>
Subject: Re: Printing with overflow checks can cause modpost errors
Thread-Topic: Printing with overflow checks can cause modpost errors
Thread-Index:
 AQHcI2OCT8YEgEEUsUCjG4l+HC53qLSOsUAAgAAo34CAABTVgIAGtMcAgAAEd4CAAIc9gIAB3HQA
Date: Wed, 17 Sep 2025 23:18:11 +0000
Message-ID: <feb67ee04fde382ae071f84a439f60939e16100d.camel@nvidia.com>
References: <20250911213157.GA1039411@joelbox2>
	 <aMNo7qRCp_yprUAW@my-computer> <20250912025343.GA1376629@joelbox2>
	 <4940aa5a-18d0-4bcd-9125-80f5a9920627@gmail.com>
	 <20250916103252.GA1660986@joelbox2> <20250916104851.GA1679817@joelbox2>
	 <20250916185253.GA1765622@joelbox2>
In-Reply-To: <20250916185253.GA1765622@joelbox2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6526:EE_|MW4PR12MB6949:EE_
x-ms-office365-filtering-correlation-id: 342b4689-f62a-414a-ceb1-08ddf6407862
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WmFZV05zckJ4ZzNsaEh6aTRPckhHZFBFYy81VU5LaU92Q2paTTFmRW1DYS8r?=
 =?utf-8?B?YmtYajJWd1pTL24zR1BXMVBsblNCek1CdlBPckpDQ0NOd09oc04wV1h3T1Nr?=
 =?utf-8?B?WXNrYlk3ZU5JYkdwcTl0THRtV1dsak45ZVRhUEpQdTI0bWV3eU9jd1dFSW1O?=
 =?utf-8?B?TkdSdnZsMEZVT1VHMnY5RDFneFRUNGg1VUFOVHlURXlRNWpRVUZIdFNuSDRR?=
 =?utf-8?B?a0szc21KU1dCMW9CTm5hWTNQSXhYLzVEdllGZmJGQmJQMy9mbmxNcktZb2ZC?=
 =?utf-8?B?aFoxaVRhNGtTMVJmRVBHSkJJLzN0aE9ENEkzSUgxNlBQbm5hMmk1WXdXbVNm?=
 =?utf-8?B?T0RPdWxxZ05BaVV0eVkxbUM4Yk8xckJnRnRZcThoKzJTQ3dvNW9RNGhCV25j?=
 =?utf-8?B?QlFJNlE3QVNRcUNsVDdzU0dkN2prZS96aUZzaDBZWVNQb1kwVnovdTI4Q3Vi?=
 =?utf-8?B?LzRnOWc4NEVjcmxBelBlRnhjc1RwQzRWbHdQN0VGZ3JuL0dOa2FQRFBrRGVP?=
 =?utf-8?B?ZHZlMjBqQ1JVSzlvVGMzUGVGUzZ2VUFJakpiUHVRR1EyT1Z5VVN0d0xSY21T?=
 =?utf-8?B?cnNoZE90Qk91eDRlWjdSUlBJL2VkeDRPSUh3aEV0cmkxempTTjhRWEZQaFlz?=
 =?utf-8?B?bzgyeVA2NUZPRjdkaWVFT0FVMjF6QWhzQ1I3d1A1UjVaQkR0YVA0dEJVaGxF?=
 =?utf-8?B?MktOcS9aOFJLTHk3Y2JhWnMvdTFLVDRWUDhLWlUyRnlGTWtWNk9KUStONExs?=
 =?utf-8?B?dU11YVNrQ001dXBZREFyMmIzRWEycUFOdW9iMHQ3SlJBek9JbkFUdzZVUUgr?=
 =?utf-8?B?YUFqRno3MGg5K3dvSHBBaWsvQjRUa1FvUmsvYXZyWXV0dVBlQklCUFVISG95?=
 =?utf-8?B?c0pvejA2R2NUQ0psbHlMdS92ZWFoZnJTMUw5V2hJOGhRcE5qOWhUT3VrNlBh?=
 =?utf-8?B?eVFnVCs5eUduMElkLzh3VnR2QnJoZmlZV0tpSFZHUHg3Z2xSaFF0cXBsQ0Ji?=
 =?utf-8?B?N0hYNGcyV3lUcDk3OXNmL2w3VDFDMVBzSmhuMzQ3V2t5NU1WbDNWNkZZcExO?=
 =?utf-8?B?OVFTS3l1UHRDMWNqV2NiS2NCYklzK3pKZFlhOWxzVXpRZW1PTFl2cDVZOG5E?=
 =?utf-8?B?R0ptcHY1R0FXakZNT3RRZFh6Uy9PdUhPblRybk0vMzdzZTlEU0c3SGo0TjB0?=
 =?utf-8?B?YUNjdzZZU3VJWG05NGM1aC9zdUZsUlBrU0J6RTNiTGFLb2ZpaVNaWGxLbUlr?=
 =?utf-8?B?L2syaGdzN3VRbFQ3UmU1cDdzS1R1UlBvUnladWNCanh4bExzRWFtK1ZuMGNP?=
 =?utf-8?B?OUY3SWh1dWpDbVFWZVMwSEk2d25nL2NQazI1SzZFTWZsekhRQ3dyZXpBeVpv?=
 =?utf-8?B?bHY1YlVybVBtU3pMeWNIazdYTWFBbWVRbUVtUFlXM3crZVlEdWlzaGYvY0lt?=
 =?utf-8?B?WEVKUEU4UkY4MUplbjB4M0JNTk9icUk5eFRBT3FadkZYellyM3lVZVg5UEV3?=
 =?utf-8?B?V1M2eG5OcHBHOG9RcmlnMy9MUVhCRHo5NHdOMzNlYzlqc1ROSXlmOTZ0MHZj?=
 =?utf-8?B?WU1LbDhGN2RCWVo2Z2ZwZVBTc1czUVUxQXp0RnRFTEdEb3BYcDI5WE5vRWlq?=
 =?utf-8?B?OVRsQXNrK0N2MXpoZnFxN3JTM2psY21ZRXVGSzcxZmlZTE9yclZGZGRlZU5n?=
 =?utf-8?B?MGxwY3VnTWRabUhkN01aZUVYOFlNdzRGUmFvLzhnc2ZRMjlxZGp5L2NvM2R1?=
 =?utf-8?B?TlJQaWF6TC9Cb0ZnZ0lmeXRRQ3VIaG1pMHl0a2ozbGtSZWIrR1VsTDFDSXZM?=
 =?utf-8?B?bkM0ZG9Cdmk0ZjE4U0JNSlZSSmc1YTNYaFZCdDlUaXFUZHZxN3NBUUY4MXVv?=
 =?utf-8?B?SThTeXVmWlpTL0tTVEd4RkJnNVEyVWRXVmlXYU9WMUlIdFgrbk45RW0vRTRy?=
 =?utf-8?B?Q29tbklsQU91aXZlVGdGemtQM2M5RGFGb05iUVc5bDNMajZEeHllZnBNaU02?=
 =?utf-8?Q?NYcPTfhdxG2hHXM0BSwVju0agZPvZI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6526.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWZ2a2NrQ0dxQnZnMElidTcybEN6YUhnT2pmMmN1Z3ZBM3VoV3JVN0dRV1N2?=
 =?utf-8?B?b2gvallCSzcwcHEyS2Q0S1RrZCtHdHByMmdhRmRPVmVqUk94ZEJhaU1ySXVq?=
 =?utf-8?B?UHBRUUhrdHRqZVdDT2tVZEpWRzZMT3l3MnNSc05zeWFuRXR6b3RoNDFOekpB?=
 =?utf-8?B?dERWWllWNW5tbXh0UnMybUp5YnBuSnFLTEZmOEpZNnFwVTJxdmo4eVpPc0Rp?=
 =?utf-8?B?NVpqdS9mUVdVQVo1K0RmQm5zNzdEelhWbG5EUGdnZGxqTnJLaU10MHlvQWtl?=
 =?utf-8?B?SU5TM3hRZVhTcDBGUDZvUVFId0hFZDQ0U3FhTWs3ZVdudEp4SVFlZ01RWVc0?=
 =?utf-8?B?ZVhxL0JpekxkYmllU0x2NktPbHl3VFJPbU9Qem5PUHVlTmowRWZjM0NJazB4?=
 =?utf-8?B?Y2k5N2R6K1A3amxkZlhBWE4rb1VJWGVtZ0svQUlrWENaWkRvM0Vha1AvMmRw?=
 =?utf-8?B?aGMvNElxTHBtTktId1pYUHdMbE4wck0wcnU4QVJaRis0cjV1azhIaTlHclBQ?=
 =?utf-8?B?aXFWVE1MSkZuT2krTVJzOHJWZDVJSVByajduOStnNmZITy9UNlZXN1FrL0la?=
 =?utf-8?B?a0xKSG5qNWI0WlZ5N2ZNbWNkN29HMTJGbWdJMGhUNjBUY2tMU0dkTFJPSWtX?=
 =?utf-8?B?aUxiZGQ4VEdBdWdGaVJQa0NtT1NyV3dEdUZZQnhFdmJYKzA1c1RPc1JzKzI1?=
 =?utf-8?B?MWNVOXhSR0Y1bnRVbTlaUjlOaDVtSUVmbksyelZmVGFLbVhjcy85ZU1yZXdw?=
 =?utf-8?B?MlFFWFBtYU5sVjRxN0ZINk82eTNEdnZLVGtNRmtGQ3NRa1hPWDFDQjFiSE9T?=
 =?utf-8?B?dlFLTzE2Q2cyWTh1aGhZQWs4bmQvWGFlTkpDNEJoUEZ3Y0xSZjAxWUlqWXd2?=
 =?utf-8?B?WGx5ZXJlN25ISVVQbnRWOVNla2d1dDlKK1lNRHBrZFB3UDRUNVNBZllhdkV4?=
 =?utf-8?B?ZHN0ano5UFhySE1WYnY5NllaMlNyZFJtZkRYVXU5djh5SUV0UEh1UmJZYnJH?=
 =?utf-8?B?WFp1bU85MWJ0SklkVXhyeFpTUmlKbWJqQ09FblZUczhvVW9CUFk4diszT3lw?=
 =?utf-8?B?bVF2Yzk5UWNlVzBSNEdtRmFpSXg3VmlrTENZNEpiaVhZSWQzK3dpbWdsUnEz?=
 =?utf-8?B?LzRTVm5FOVRpaElrTktadEVJY1dJUUJZeWttTnBJbFMyOU53ZmVQNUNvQUNZ?=
 =?utf-8?B?OFZVbVQ1WjlRczhzMFZFdlJDNWk0MUlPeWE4VzN4d3QySzN0TGNrRFZCZEdD?=
 =?utf-8?B?YjVIZXAzR0dQb1g0VWlnZ0YwaVpJbXpVNGRsUWsxYSs5aXU2dFVBdmpqcWJv?=
 =?utf-8?B?SUI4SVF3ZDdqMkpIUFdyVXBNcVE3cUJYUTI4WStsbC9GY0g0MVdqQlNkSXNj?=
 =?utf-8?B?cWk1NzlmbEJ3S1BBM3NzZTlMMmY1Z2hzVGxIMjY3NDBDek1wNGZDZzFCSGdK?=
 =?utf-8?B?SEcyZlN5eWZpdFpKNElBdEdETFc5MXFldXd2cUtGV1ppSmJ0MEdPN052Sndj?=
 =?utf-8?B?TjBvWXJzQjVzUlYvR295NmNYdzhra3phWktxMDZuaXZCelFBNmdxMFpYaDd0?=
 =?utf-8?B?ZU1yNWVyZCtRNTdRWHZPQkNFZFpFeWFuTlE0SDBqRFlJS2N2YmJGZ1hzbzcy?=
 =?utf-8?B?OXdXZmEycXhXM09JbThBSEFuckJBdG9lbS9OYVZBVGI5SzIzdkg4QllZSEto?=
 =?utf-8?B?TlBJWUpTbGJkbzFxSmk3dUpTWkJVSkFNdzNiMllwUmlVUVA0ckFpSUFNeFU4?=
 =?utf-8?B?WVhCVUJEWkc3VkNMZy9rNUhUVGxVV2VjajVpR25taS80MnhRa0lqUk02THJF?=
 =?utf-8?B?QlcwVTZTeG1Za2NvNGdYK3NKZ2N1WTh1TVNtY1VFY29IanB5UUlBV2R3K2N0?=
 =?utf-8?B?alFtL2JGSEVsUXYzUzRnbkxlU3A1cHFCOEJ5Qm1ibkVxQzVneThaUzNoeU5Z?=
 =?utf-8?B?UFRsNVo3czhONEFCMnpWbUtGRDBRc1E3SHRyOHFXVUxxRnpocCtCaDlhTFRD?=
 =?utf-8?B?aktMZ051cXZJUVo4VXE4dmx2WnhKeWZLSGhseXZQd2wzZ3kvU3N5bFgwT1ZE?=
 =?utf-8?B?Vlh2UlQydTJSVWNoSGNVRnpTWW1sZHB2a3BsMDBrRDdQTzA1KzIrSEhzdGVZ?=
 =?utf-8?Q?2xD6imL5vFTgzjxTT7aR3kZu3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84C8D4EB8762654483D21692AF256F11@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6526.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 342b4689-f62a-414a-ceb1-08ddf6407862
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 23:18:11.4339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zh3B7h6748AxMO81euQG32Qdmlw38IG1lTT5CMwJg7ODjtyGS1oZKVPJw+9iisez9nOxq/A3n4C9i4DEi498fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949

T24gVHVlLCAyMDI1LTA5LTE2IGF0IDE0OjUyIC0wNDAwLCBKb2VsIEZlcm5hbmRlcyB3cm90ZToN
Cj4gRnJvbTogSm9lbCBGZXJuYW5kZXMgPGpvZWxhZ25lbGZAbnZpZGlhLmNvbT4NCj4gU3ViamVj
dDogW1BBVENIXSBydXN0OiBwcmludDogRml4IGlzc3VlIHdpdGggcnVzdF9idWlsZF9lcnJvcg0K
PiANCj4gV2hlbiBwcmludGluZyBqdXN0IGJlZm9yZSBjYWxsaW5nIGlvLndyaXRlMzIoKSwgbW9k
cG9zdCBmYWlscy4gVGhlIGlzc3VlDQo+IHNlZW1zIHRvIGJlIHRoYXQsIHRoZSBwcmludGsgYXJn
dW1lbnRzIGFyZSB1c2VkIGluIGFuIHVuc2FmZSBibG9jaywgdGh1cyBSdXN0DQo+IGNhbm5vdCB0
cnVzdCBpdHMgdmFsdWUuIFRoaXMgY2FuIGJlIGZpeGVkIGJ5IHNpbXBseSBjcmVhdGluZyBhIHZh
cmlhYmxlIGFsaWFzDQo+IGZvciBlYWNoIHZhcmlhYmxlLg0KPiANCj4gRml4IGl0IGluIGFuIGV2
ZW4gc2ltcGxlciB3YXkgYnkganVzdCBjYWxsIHByaW50ayBpbiBhIGNsb3N1cmUuIFJ1c3QgY2Fw
dHVyZXMNCj4gdGhlIGFyZ3VtZW50cyBpbnRvIHRoZSBjbG9zdXJlJ3MgYXJndW1lbnRzIHRodXMg
YnJlYWtpbmcgdGhlIGRlcGVuZGVuY2llcy4NCj4gVGVzdGVkIHdpdGggdGhlIGZvbGxvd2luZyBz
bmlwcGV0IGFuZCBpdCBidWlsZHMgd2l0aCBwYXRjaDoNCj4gDQo+IMKgIGxldCBvZmZzZXQgPSAw
Ow0KPiDCoCBwcl9lcnIhKCJ7fSIsIG9mZnNldCk7DQo+IMKgIGlvLndyaXRlMzIoYmFzZSwgb2Zm
c2V0KTsNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvZWwgRmVybmFuZGVzIDxqb2VsYWduZWxmQG52
aWRpYS5jb20+DQoNClRlc3RlZC1ieTogVGltdXIgVGFiaSA8dHRhYmlAbnZpZGlhLmNvbT4NCg0K
VGhpcyBmaXhlcyBhbiBpc3N1ZSBJIGhhZCB3aXRoIHByX2VyciEoKSBhbmQgaW8ud3JpdGUzMigp
IGFuZCBjYXVzaW5nIHJ1c3RfYnVpbGRfZXJyb3IuDQo=

