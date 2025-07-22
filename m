Return-Path: <linux-kernel+bounces-740442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7613B0D42D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05CE3A14B5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9317A2C15B5;
	Tue, 22 Jul 2025 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kWVmbW4U"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E32F9D9;
	Tue, 22 Jul 2025 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753171944; cv=fail; b=tV5Y2h9HBRwwMnvxzU/hQE3WktYvvYU1K2fE3mnclnKYKbrA3LE4T0qBq9ct6YsQkws/Y4vxP4cHTAyfCA/p+1pcPREZ28z9c5xcJpbTlhuDx/1YJt8zokRUg6ZSOW5xy0J8oqfA36Ee6lCPqN4WsOvLmxywDlqSLAC4FWD2NKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753171944; c=relaxed/simple;
	bh=ylxWdrLX2vYgrTO1F0ZASOfqKzLyUFlEOzvkIDM507A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mxgg0KFp5Kbew/3wpq1XIiLgxkjDh/eZtYrfeL8jIrH8ssn8ZGfEtVogK6w4iEo9rj1Vseoq2efDZySPpeKbl0Z1CuhirfXCruCSvv7F58HWnXCqXyfFP6Byr7xW/5otAAbhOdHeFhtlBWq/LUZq1gDtQptv7CEBHHLb7MzB1LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kWVmbW4U; arc=fail smtp.client-ip=40.107.95.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COOfftOA30+sunU/OtA05pBIgMnkp6h2vY9Nrb1qX2dfhl//dqgNSHvvHA+Cjy+giB40OsEa3Df/FW6oQnyLLYGx3fc+QL/yXH0UoI0DmsG9N8sVNBdg0DDtlnb0jperYIiulBwS6HeepONlmN5wSi95x9GxfEd6L8jzjPbXHIRtY48dyK4iENcD+7XDxbUej4bXsnIty3HPpDLJ0qrOtGQTta1oKOqIrWWBpRtr4PgEq6jq/65bPUQWV6v32i8FehBwmuxUcrepyAEbmaaENe7F4u4I92MxhAaks+TLsa6MU+0O8io/XufJ7/4XLPQYrlV3cDxodjt+BVqaNhkt8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eBZIg4M1J39A9EVU11iqx3Y7zdLk8y0++7KnFHdJqE=;
 b=BdBkZrDS14UMefQj9FLwdSEQX4hmiu0CsNMzQz4rkDF0RuhkgziCqLR6Y7F3vdq/QhuYR19249QZdo9ohLFLyzEzMxHftOXchvNTCWZiByKbBMyuoFBCcAKQnw/Jx5elFPsFwXunxibWYt9mwVrWNoBDX1HKlWfDe/+9m+97RGLpWH0e4IjP+X6rXtg3ZaE7tAeoPl69frmM2N6k97qlmx0WCporDNJJkV0Xms1K3dPwvEruCmBG4KGPBWOvtNp2r4Lw4DrNih0Y3GTXfSZKviEYnopISvVtHw86nppASi6WfI3vPAAx8B2yMaKrO8di/LPufM+R2I8pHD89phrMjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eBZIg4M1J39A9EVU11iqx3Y7zdLk8y0++7KnFHdJqE=;
 b=kWVmbW4UeGrB4LvO7Hm5mjGOkM7lLxj28RZKOzqAjEX7JxYJsH/O5teQtZMtwXjA+I2ybo9IFxmZeBu9DVCNetQ0612DdU/Yft3wzvDE8V92pexLHgCmra4Uc2uJgPYpPnHqV3UkWKjBQcFC+7JCx880P7kCtUOAYCZVR0iJ5Ck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 08:12:21 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 08:12:20 +0000
Message-ID: <c9747893-45f5-4d1b-8b7a-193eb90221e9@amd.com>
Date: Tue, 22 Jul 2025 10:12:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Add Xilinx INTC
 binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>
References: <6ddaf6f1e3748cdeda2e2e32ee69343a06c60dcb.1753166980.git.michal.simek@amd.com>
 <20250722-pragmatic-nebulous-bloodhound-6251bb@kuoka>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250722-pragmatic-nebulous-bloodhound-6251bb@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0237.eurprd07.prod.outlook.com
 (2603:10a6:802:58::40) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: 590bb61d-aa34-44cb-eea3-08ddc8f77b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDJFOVJKZm9yVlNhSGdRSXFoVnBNaEZoS1FXUnNrajYvRTVNcjk1TWFMOEZn?=
 =?utf-8?B?Kzk1VW5idEFsZUt6YkgyR0lRQ0hXaC85WFZvWGM5QnBjMmhsZWxWQlh2a1R0?=
 =?utf-8?B?Q09Wa21RSE5scmwya2Z5eDU5S3JKMWY4N2RPR3lHdTFBbmtTVHNxcjEvSGFw?=
 =?utf-8?B?YXByS3d3UlBvUlFQNnpVL3VHTVZiUFZVZWpFRFQ3d25Uek1aYkhoZEovdEdS?=
 =?utf-8?B?MUt2SkxkUlhBV0oyU0U4TEhpMU5ZWXNVeUxOdTRvRGlHQnp2em9sYXIxOW5s?=
 =?utf-8?B?TGhQWTVuZVNQUUhjMWFoYkNEODhOWFZUandqdlJUbVNWSkdtdXlWK2V5cG9R?=
 =?utf-8?B?aHJSM1B0M3o5RGhJY0hheGkyZWxQVklaWjV4ZndqZFU4OGZmVTNrMzJtaDc4?=
 =?utf-8?B?Nkh6aEs4U3RPc1pFeC9TTmFQNU9sbEdWUk9YNUdKWFhTa1M4NGVyeUNsZzVh?=
 =?utf-8?B?TFNDeXJ0bzFab0oxb0trcDFTUnM3TWYwdDR5REZKbEdYanFkcWlvbFl1em94?=
 =?utf-8?B?Y3NvZDIrdHRBZmErS2MrSlNBSDlTWXl2Y3hYTzBxdVVLdXZRY1J3dDI0WUNi?=
 =?utf-8?B?KzN6VHNTYnlJZmVPa3BIWTdEVHhVRFh1cnNad1crek1uY0YxdzVxb2NHVGxv?=
 =?utf-8?B?M1pWeHNVYjNTWGErMWphWFQ4MHRwWGFKOGhjclNVcEJuYnlSUnloejJMRUNl?=
 =?utf-8?B?dHdmbDhGNWo0N1VFQWZyTXE1cGQzR0lkMDBxT3FwVU9xeHdLSUVPUmFpaGNq?=
 =?utf-8?B?aEtqdkVDbVNzajlYYzZoN2c5OS9ITHBIWnNyeVVWMG5UQmJ2bk5aTnk4cDFQ?=
 =?utf-8?B?cytNaFlSMDVxNEY2SktlMm1aMVFTdzZOVC9tVzEvV21PY25iVElrQ2NGaldJ?=
 =?utf-8?B?amlqRDZHbzFnaW4rMGtUUThMbWNneUk3WE9nWHBsWHU4S0FqeE5MbG90UlpX?=
 =?utf-8?B?UFV4NG1iYmVkMnU0SW1qM2xCKy83QzFIc0xBbUsydUV0RytoMHhaYk1DejFw?=
 =?utf-8?B?OHdGT0xCTDJjdnlYRHVxK0FVQ0lzU29jditHYWFDbThyUlJUR3FpUHJlTXBT?=
 =?utf-8?B?ajl6R093ei9lL1IycWEwWjZZdDVyeWxzN3lUUWM3c0FQV1VCT3UwazN6VTBl?=
 =?utf-8?B?RXV4UEhaWWRnOHFxQUZ5Z29LSDZtTFBENWhNaE54aU96YWxuMVRTZGhOSk5Q?=
 =?utf-8?B?QWpxY2dNZFYwT00vS2F1c3B3Rk5kL3IyNE5xWnNuVkxDQ0haWTZUMmRTT0FM?=
 =?utf-8?B?RzNJY2UxOFZVZGNMUEloa0ZVNGxpNDlKRjFQT082Y0RMdlZTNE1lclljT1ph?=
 =?utf-8?B?Y0tzUlg3Mk9FcXhpRUZhSjdKWUVxYkZDenZ1NVF0ZDFIRXFwQSt6blZYcU84?=
 =?utf-8?B?U2FIN1RvQnFVMFZ5YStVYzhvV0NJN1RFMlhZT2hXVmUwTkFEOGd3MEMzZzR2?=
 =?utf-8?B?T09xV1ZIWGRZbzBOcWh1ZUgvcW04SngwdmpBQ0NwOEp6ckNCYjRTck5QU29a?=
 =?utf-8?B?NzdMUGQ4WmlZRXYzdlR3MGpsaStJWDM4TmQ2NGJTbUZ0Znh0VDF3VnhGL1Ji?=
 =?utf-8?B?cXBjZU0yMkJIUTB4MEdWbjh2QTFpdmNsczY1OVZPL29SbjkwbGpFcXBraXh5?=
 =?utf-8?B?SmpzMVM4c0xYY0IvK0pidGQxTG1SaUlvRS84T1JZS2FJZmpvZTJZczBjSkdr?=
 =?utf-8?B?RUg0M25XZHZKZ0pXZGtqOUx2WVl2eUZoUGJLazBUYk5uZ0RvVlhRNURmV2U2?=
 =?utf-8?B?QWFLdU9xbmp5MWRpVWN5YXhaSzhmcnZJN2Q2Q1pHWXhtUnQyU0JpSjFaeFcy?=
 =?utf-8?B?RENLaGYzVnhTeHpLYnBvZGI3elAwM21LSXBKM0ZCaWtqZUt3Zkt1R20zWVFT?=
 =?utf-8?B?eWVtVHZhRkdnMURZSjV2bFFaMkhGWmFTWTkzbm5BelljT1k1dXhEMGg1TTdV?=
 =?utf-8?Q?M0+gnLhtt4A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzZiY2lZS1k2bitNQ1lnVkRZbmNmeHdGNG1SZHMwa3VxQ1RlVXhyWW1XcmN4?=
 =?utf-8?B?QzhmREtRdldhYnBxc2VLbUZQdlQvZUV4K1JhdzNZeWpaa3Zxa1MzOUlUWVJH?=
 =?utf-8?B?Q25uZEV0R3FVMlJnZ3FNYzVnUExLSmlOZzFoVW5Ha1M0MFdLL3JVNmdsTUww?=
 =?utf-8?B?d01aL2hDUVEvRWJaRXpEUTJSVzlGeklsajNKQlhZNG9CTWNQSFdWWUo0TWtC?=
 =?utf-8?B?dVc3YVJHTTJhUzJ1TEgzeVZ0TTZZNDlQVmpKNkZBM0NMNjJQRU1qZGxndHJW?=
 =?utf-8?B?a0hJb05YN0NBMWFhbnhCYzViSlB1dVhGZm5DUWFJQkpQVktQUmU3SjdYbEJF?=
 =?utf-8?B?WUJGZWU2cHZaRHZNN2tsdEE4SUM4bzdCb0JLbWVnM3RjSWE0NlUxSm5JcHZM?=
 =?utf-8?B?bm1ZSGducWJtTmtCeUFyQXI4bmdmb2w4dEhUY080SjlUUUNxdm52YzJ6T25X?=
 =?utf-8?B?b0toZGlyMytIQVNVditpcnppUi9kd2lGUGJoT0RLOWJQUG9JbytId3Q2MnVD?=
 =?utf-8?B?VFF1bkpaN2o4OS91N1hIWkhReUdEZ0lxN1Y3UnJrdjZ2MkQzY1F6MzZHTG1P?=
 =?utf-8?B?bFd2RmZuUElSTEQxSlE1d3NVZFU4bm5hM2xZcGJ1K1hDdUtYUmc2RmNCaklG?=
 =?utf-8?B?L09nYzdYUkpRelA4YTNWdjJHSmtraUhXbDdiWFJZSVo1TGdBYVBOK0xSK1hY?=
 =?utf-8?B?OWZZQ1JYeFd3ZjdRMFR6UkgzVTNiTXV2akhGTlBDWmtabFBLWE9ad3YxY0g4?=
 =?utf-8?B?MG1NeUhId0cvRkdBMmNETFJkZ3lDbGJ2Z25hcWtGRVJucVpsSnNqVXQ0cU9q?=
 =?utf-8?B?UFJvL1VBN2ZyelpnbVVURVZmbm1Zb3JyVEZEU1ZJM05ZcDQ5WWtHMzJ2WUVu?=
 =?utf-8?B?Q3lJT29YbUtTQkFIUTAyQm44YytMaUZEcGQzM0pPUG5ZdzFyM1FNSUhFdVNw?=
 =?utf-8?B?bzdlNlp1OHZnd0ZEMnl1SjZzS0dDd05icTNJSmwraXRwSW1CaTF5R0J4RkZl?=
 =?utf-8?B?cS9SdExOS1FxTmQrOUlXa1dtdkg0ajYvRC92KzdDMWxOWHJ1SGd5MHh1VEVj?=
 =?utf-8?B?K0JYbXBESkJFUUJaRzljODFwUUxpcWVOZjJJYi9kaW9yLzA2L0NSNEFSLzZv?=
 =?utf-8?B?MGJhcTNFejVGdmhlNXFKMXB5Rk54RGd5dlJIM3EzWUVTWVJZUWIwRFlIc0ZJ?=
 =?utf-8?B?TjFLQnRFenNVNTNRQnl6V1pTWWVUaDM4UnU2WmxSeVViQ2NBbG1wOVg0TDJP?=
 =?utf-8?B?ZGY4YkMyVGhUKzZOZ0ZXR0hGMlVVWFVXYk9IamNpTm1lbnQwV0lKSHg1bWc3?=
 =?utf-8?B?YzcwUHU2Qlh4ajVKTzBlNFVIaG5BWHoyRlBQV3VlYWM5WVNMUTRtOUpLOWVC?=
 =?utf-8?B?c2NzRFFwUXF6RGJFaTlSNTRRdjhKL0xDazNrbGl3SkR2dmtJWDE1UDFDN1p0?=
 =?utf-8?B?aXlzWlc5eTRRby9ibFZXSmZUYU16cVlDNFRTaVhvUFZwZGdRRjBCaEpjd1RH?=
 =?utf-8?B?S3ZuNzdhQW40ZW9mMXBacXFadU1XNnptbjM3NmlORCtlcEZkVy9maGYyWFZK?=
 =?utf-8?B?VmZkVUJZRWV5YlN4Mlo3dnNBTGZqUzZoVFhVTCtMUEhxRTZIVytxVmhieTZ3?=
 =?utf-8?B?enRYZ3JCVkZDTExHQXB5VzNvL0ZUNHJnd0I0TlJBVFEwb2Z1NEMrZ0U4TFpv?=
 =?utf-8?B?blVYOEpCWDZXaXAwV3hEeFlKbzg5Ykd1R1BLYlovZW9mREE0aEY0dGVFdzVj?=
 =?utf-8?B?RHdEOFY0a1FIYXdHaW5Rb0ZyemllMjJ0OG4yYXRscUJFbFBlVzlNWEtQL0s3?=
 =?utf-8?B?aXd2ZFZCVDRHTVBra1VIeGNJVVdTRzVuYmE2M3l0M1pJajFSK1pYa1NqajhP?=
 =?utf-8?B?eTJOUmNLaS9EQitUdlp6VDRZbG5lWDNwWlgzRXhSSGF4TkJENW80SWdTdlNK?=
 =?utf-8?B?QTZiZzY0ZjJSSW4vckVVbENwYTFwL2UzNFo4YnFIUldEL3Q2MXpLOXBGaGgx?=
 =?utf-8?B?QjVJZFhiaTBIZGg3dG11ZU12L3dDOW1aNFBMNXROWGJiTnpxTmVkWUN0NW9E?=
 =?utf-8?B?dUttUEQ2d2tvaHJuenltSVgzeEZTK29Sbm02OFFJQjJkb0w1N1BKaXJwQ0tr?=
 =?utf-8?Q?wuU00q67mBKOvAc9tkW8dVlaR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590bb61d-aa34-44cb-eea3-08ddc8f77b38
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 08:12:20.8826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPxOmZcu4xdLnyCcirFUQrAtbPSlqOyPDny0N7Jb5ak/8BgxGHqVdOeoPWsSiHqH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7558



On 7/22/25 09:40, Krzysztof Kozlowski wrote:
> On Tue, Jul 22, 2025 at 08:49:42AM +0200, Michal Simek wrote:
>> +  "#interrupt-cells":
>> +    const: 2
>> +    description:
>> +      Specifies the number of cells needed to encode an interrupt source.
>> +      The value shall be a minimum of 1. The Xilinx device trees typically
>> +      use 2 but the 2nd value is not used.
>> +
>> +  interrupt-controller: true
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +    description:
>> +      Specifies the interrupt of the parent controller from which it is chained.
>> +
>> +  xlnx,kind-of-intr:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      A 32 bit value specifying the interrupt type for each possible interrupt
>> +      (1 = edge, 0 = level). The interrupt type typically comes in thru
>> +      the device tree node of the interrupt generating device, but in this case
>> +      the interrupt type is determined by the interrupt controller based on how
>> +      it was implemented.
> 
> enum: [ 0, 1 ]

It is hex value for all interrupts together.
And bit position correspond to interrupt line. And you can mix edge or level 
interrupts together and this is the property which distinguish them.

I know that separate cell is normally used but it has never been converted to be 
like that but interrupt-cells is 2 that binding allows using this description too.

Thanks,
Michal






