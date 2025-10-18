Return-Path: <linux-kernel+bounces-858971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A639BEC617
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3A03ABAC7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D3826F2AB;
	Sat, 18 Oct 2025 02:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e+1mMqAQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6DC26E71E
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760755857; cv=fail; b=TqWgF3gpinid+dSDH3aicyRbOabhYNrXc2CZ/90wwas2R0NAvMQZvdsfEkGJCsjQ31rZQ9n5xUU5i+6gG7iuvRvVJH8hxFxpkQXGLYwXKt1NLE0kQwbRrlkUWpLohT8j8usSJS6wmyzc+GZfZ0jdbi2ggzQzzY3B9rjJAe6AU/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760755857; c=relaxed/simple;
	bh=Uu6kFl9auBgk7+LVbPyIpceZVcGH9gDkRNKeDr/u8kw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Nr20WU81f3l36UIalODaQSNp5zi9/OxXm8HL1dYPW0Jw/7skxGu6yJep632sy/tvbQ7VGEh2Mbt+kviSb0zVflwSNbYFHbwHNyAwqce57el2GLNSGREZaDiSHUXt3WnMTlKddU4jiMfrgjlUMyY+yKjzhGL8KMhF1B3E+6auBlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e+1mMqAQ; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760755856; x=1792291856;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Uu6kFl9auBgk7+LVbPyIpceZVcGH9gDkRNKeDr/u8kw=;
  b=e+1mMqAQaiWwaqJioTpNLKE/fDJlJfjvKeP0iXqWQRuzBsq1sw4HXUbN
   kqyq3LyuuPPDD4WRhQUJ0/fu8CGSDT5c3/1cE2aJntGy49tVVmiIx/LQZ
   jKBXORAmzd/g2Of7oxolzOHVSo/qfRI8w/DGVRGWDZUbJj5oHL6QT0SND
   iiuiyn6Opv/n1ARqj1M0pNY2ifnGcfDTDCDDP/LtcJLBrkUGWArXRVNS4
   3j+7fsEGSFcF498FfQMMcNGSw+ZgdaKS/SxKTn6EHA7kR2Rkj4zGrSGsM
   WkCa0ntFCoOwwgEKUQ6Fsu1s9uX1+uae4z6kveUC59wLtlVx5Kol0GS9l
   A==;
X-CSE-ConnectionGUID: fXTH+ie5Q0e2rFsXc6ajuA==
X-CSE-MsgGUID: zWXv9ADIQIiGLBc8mvZ7cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="88441480"
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="88441480"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 19:50:56 -0700
X-CSE-ConnectionGUID: IWmBDqMcRASP/2yp7s+XIA==
X-CSE-MsgGUID: itqvpXcWTFWYSE5GmJM5rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="188177820"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 19:50:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 17:08:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 17 Oct 2025 17:08:22 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.36) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 17:08:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oss340iRpOwuX4P8LZUALH01xImWiWY0XGBpDiA70UCcPLm3Ah+3r5AYQP0ydlhklD9XaNjBhng4v2C3vKGLbnKqIHa3D74CSmmPYs/mYg5OJs6SXvJ90xaTRsVrYG7hwdrszkrDzSY0hJbxDN7pvXUI0P8xCPRzRvs189lAlHOzqNG4A1ZwHXUuv+/EgRDQTClfWzz3Wi417CxMIYIj8btgpAajKxzfcz+2Vmhc1raWMlrPawtqoFaTJusO/4qwNYNfQgYi6734YzNuFNlYc1gBo3qng/2/KnyAszSSevsEUbs1gsWyZgz39BZHBYKKEdKBHxlO4jFlOXZ2cWkkyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foAwEzghRKY+awhrEAMJ+3kCa8sDY+qFVJpZ5Pbxdhw=;
 b=FzTnU4goWcW3mLKIQ5EhDW7aXMbpCP3fK6izr7la5NiTF+le0EQBBCpoYjoB+a49gqnfupkF/bSg1XXSkxGSEMgDFN4GHgwmYA+hNz9Tu+/N/Q5lTDCjBG3mYQvpZ0zWg1r0tNYvpC8qtSjMrUdungtOsZO1ECdiSaG/KM+Kp8+qhVgoyurEa2f/yl4/d+HHp87gvWOzJWQMBmw8mo8RIfJV2f5r+XB+snOm8Ara3dD4rUXrtXskTeouLx2O+Bdrb1b0JConGEoF9qebTD8wSHnajFZ6rJw2nxi0Nj6RpJDS5UhE1TRMCDoXMJR/zyzoHAemM1YH1BO4+KBOLYOvVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB7023.namprd11.prod.outlook.com (2603:10b6:510:221::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Sat, 18 Oct
 2025 00:08:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9228.011; Sat, 18 Oct 2025
 00:08:13 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 17 Oct 2025 17:08:11 -0700
To: Mike Rapoport <rppt@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>
CC: <jane.chu@oracle.com>, =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?=
	<mclapinski@google.com>, Mike Rapoport <rppt@kernel.org>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Tyler Hicks <code@tyhicks.com>,
	<linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>
Message-ID: <68f2da6bd013e_2a201008c@dwillia2-mobl4.notmuch>
In-Reply-To: <20251015080020.3018581-2-rppt@kernel.org>
References: <20251015080020.3018581-1-rppt@kernel.org>
 <20251015080020.3018581-2-rppt@kernel.org>
Subject: Re: [PATCH v2 1/1] nvdimm: allow exposing RAM carveouts as NVDIMM
 DIMM devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: e5bb51ae-d804-4553-5739-08de0dda6dfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVArdmhRZEpqU2F1bnMrRjNvUHJ3TnE4WFBnM2lYZm9JYmZ1TnZQRFJYQnZL?=
 =?utf-8?B?Uld6cXB2SnIzYlp6QXFkSVRwM1JwSTF1bzZFRFpaQy9YNHduN1p6c0NveFZD?=
 =?utf-8?B?bkR3M1JwWFdKR3J1VlhhdGdId2oyWkJJNGlHK0ZSeVIrekpSMlFRSWcwTHhH?=
 =?utf-8?B?K2VlWWEzV0Z5cG5KUFNUYlJFUDZVRHhzeW9vcXY0VGRTM0FrNnRhdFA4UTBO?=
 =?utf-8?B?L01jNFJOWk1RQTlma0RtSXllRTlWRSt1K1NPNm9rMk5nenhTanNSaCtDM2Fa?=
 =?utf-8?B?cStnak5YQyt3RS9LcGd1MUVWaGxWN2RscmlJNmpYSTRQb0lDYnJ4SkYzUUpi?=
 =?utf-8?B?QnN1S0VMUkJQN2hjNlRCK1FtanlWdytZeE5sWjdLWlFFbGQ2UUxzb3Zady80?=
 =?utf-8?B?T2tMSTF5V2pTbmh1OSs0TEtOYVo0RTZMb056bmVMQlFwUEZMWXlhM2xMQXUr?=
 =?utf-8?B?M0pWbGdWTGhwdExrK2lHS3ZKVXVwc0RyMEFRTERtdERIMmRtam9Cb0NMZXRM?=
 =?utf-8?B?OVFOdlFVYWNMY2k1WE1UallPWk9td0JIYk1qMmRiQ3ZWMldROC9SSFVlMmkw?=
 =?utf-8?B?QnlLdTNWKzRRTG4vaHlZQjNUTUJiTlpNS0JaUmpKaTNwYVEyOXFINVdBQzNR?=
 =?utf-8?B?czBpVEo5cTJLZGJLYVhUU0o1Rzg0eGFXLzVHdnIvSTFCekdQbGIrL1ZreUt2?=
 =?utf-8?B?dXVuSGg1Tndva1RFZlZia2FtQnlrdXFsTWxNaDdZT2VQaW9zcml1OEc5RU5x?=
 =?utf-8?B?aXVYNmc4M0VNdCtpTnZ2YmE2cUhaNlpXQkEwODh5Q0w3dFJCK3JCci9FUFpa?=
 =?utf-8?B?UmJseU8wWjFQV3pUd0I1bEUrSFkyelZBNTJ3M0J4RE40ZzFNcGVqSUM4SXJ5?=
 =?utf-8?B?QVF2UHd1bTA1azc0V0V5SUY4dlFDU3JXKy9tTGhFR0RxODJGQkpFSkErZUlS?=
 =?utf-8?B?VVBpbVNwOG8yRmlRcjc3ekxTZE45Q1pES1NGM0VRMTRTVzJrMklZYm80Tngy?=
 =?utf-8?B?YW0reUl1QitmZ3hwMXhWYTcyNG92VmliWG9NUlFtd0sveXBIYVI3QTE1UDl1?=
 =?utf-8?B?Um9DcnpWMHNMOEJFYk1qdmRsQ0lGV0VsZjNEUEczNU1EbktvUGlTYUIwdkNR?=
 =?utf-8?B?RjVWVVFPZTFGeXowcTFDNmdKNXAvbmtiMHpEcW9JdHFxc0dsK0c0eUpPMGlp?=
 =?utf-8?B?SWFWTEpUN2RXK0U3d255eEQ4TEJ5SUJrWnNOVFlZU0JCS3UyWERJTGRkajB2?=
 =?utf-8?B?eXdNVGpwMGY2R3NsdW00c2FOa3RlM1FsejdodFpCYkhCakRHME1ReFVYaWty?=
 =?utf-8?B?WXBYMGdEcDZINjlZS2dBOFhjRXhpNXpseEthdXJHRUs5NDE3RWpuRTM3NE8x?=
 =?utf-8?B?SnV5QnEzQ2hrYXVROC82U3QzSngwOEdrUnZCaWpTN0E0UUtHOHhtR2VjdEJt?=
 =?utf-8?B?MjhrcTlnV1VaUkZzQXB2T21ESEs2bjVpbEQrd1VOODdjVEQ1VTlzZGs5em9a?=
 =?utf-8?B?aFpYQWN4dUdJTURZVmVsUzNaMWlSZlN0NUk4cG1yR2NoaE43ME00ZEVkdndZ?=
 =?utf-8?B?RWlheXhnTVF2V01wNFI2Tm9HMXJidko5c2RNM2wwZUE1KzVDMnU1R2tMWnRw?=
 =?utf-8?B?RlMvSk9zRW1YSVhhdFQ4NHNvRk5FcjdRTStPTHZSWTU5T0crSkFEWStOT0s3?=
 =?utf-8?B?MFFjWmNSZERIa2oyQ2tTTUdxWk1WNVFibHZEWkJiN0tTQmxRNzNJcWNsTktS?=
 =?utf-8?B?WWdOU3JaTEozaEM4L3pkcTJmc3BzZFlJZk80Z1RsSlozUVhtMFZ0dlZZeG5m?=
 =?utf-8?B?Yi9uaGxGbmUvcUFyOUdqVzZxSUh2YllleFE0d0Z5QjV2aWp1UFBKSG40bkRr?=
 =?utf-8?B?N0V2Y1U4T2NTUHpxTEtOc3lFNndPeXpMdDFBbVR1Uk8zem5QbHVsdm9DMWw2?=
 =?utf-8?Q?lREpA0Lvhp0/eRPDxaOGevC5yIoCTeSs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlFYd0Y0S1h2UnRVYzBXR2NPOXdHWDF0SmNRY1JnVFBGU292ZnJaSUhCblp5?=
 =?utf-8?B?MzJwNEtvbG4xckxhU2lRVXNvWTFoZitGdWhpbUhYYnQzcnVUbytjWjVubk8z?=
 =?utf-8?B?MTJDbFVrdG5lWDFsNys1eEhmNlN6REFqTHg5RHRYMUlSZ0RVUnIzajVwdFhC?=
 =?utf-8?B?VXVEY2pFNmJWSk14Unk1U3RYY0NFZ2ZXbWh2eGNaRGM0ayt3Q0JTTDRXNjNB?=
 =?utf-8?B?WVVsUGN4RXNIOHRjQkNZbVgyKzJHSVZxNThyTzhJT0pHamo3ZG41TTJWQU9P?=
 =?utf-8?B?akMwZldlRlpXUThaZnpOVmNwcXlTNmFlZGMwbEpEd05qeER2c2hMWUtPMTI1?=
 =?utf-8?B?RFU2dWtqL2R2d0o2VEJrZ0VqY00wVjhIdTlhdS9BYUdEb3FCeUhUbVJDYkIw?=
 =?utf-8?B?V0xXUSs2ZkpRZEd4dlJTRHdHdXMvMWVOV1R2ZWVZcHN1amQyaHNPMnViaE4v?=
 =?utf-8?B?aE9ZblVhYU1yVzl5dGFZem9TbDArZVpNOU9SQnYzTFNsVDFaaFlDY2l3Umht?=
 =?utf-8?B?Y2hnSGdtYnB4dm9YU3ZUMlhkRzc0TnRJRVI2N3dhcVJIcmNuRFlaVkF6eXRy?=
 =?utf-8?B?THlPVmRxTzJuanlyeVNUdUM2YW1lT3VrdU0zbVdEZDJ3UDlhL1R1UXF5b25i?=
 =?utf-8?B?V1RSY3B5am04Mm90ZkZ5VUNBcXY5MkU1V1hBYTBVemk0TGJ0U1VCU1Exb1FC?=
 =?utf-8?B?RnI1aldQbFlKb0hzVk1NQmRCUlVWOEdhemQxSG9DemZENzJaRWFIajdwU0hq?=
 =?utf-8?B?V0dLMFlnRHNtU0NWSG1JV0t4SWpoTXBJcEpQLzk3M2Vhc1ZpMVNxQzVTZVo1?=
 =?utf-8?B?aVZSLzBUbXFma3RveXdESGx4d25RQjd2ZVJ5eFhFUis3L3NuMndiMVNON0d6?=
 =?utf-8?B?aWU1TmUzZ2ZLTUFuaDRVOFRLN0kyeTM0R0dpQkthc0lsNDNvZVpmQldoSU9T?=
 =?utf-8?B?d0k1MFp4aE1SWjg5R2N3Mktpc3E1UExpMHhTUjJlWDBsMVBlR2FFS28wSXFw?=
 =?utf-8?B?aU9WZ05sa3hqaERwckhkRzdLc21BVFFjQlFxNDNaZHFFNXlFamFWZkhhZ0Uy?=
 =?utf-8?B?SWk0Mzl4T280azAwM0Z1NXByWFRUZnR0NU1tZUZLYXdEVmFWRGxyRTF0VGpj?=
 =?utf-8?B?TWYxTVEyRjRwMmoxVkpiYUtaRGFvakdTMUJtTTRXVXF6MjFwTkNkd2tQTnRM?=
 =?utf-8?B?WE9uNEhxejlYekdNb2daekpJSWpiWGtZZTdVVU1YT3pnNVZ1Zjljckl3V3o1?=
 =?utf-8?B?MW1HbnVremxDTFMvZ3NOeDRRUlBEekNCbi9NTzdEWEV3SThWZFVaZDZER1FZ?=
 =?utf-8?B?VUhBclp5WkpkSnYxdDk1dnNnZmE5WXBabjF1aUE1RCtVb2k5Q1g1SS9LN1dO?=
 =?utf-8?B?Qk5zNDVCTUpPSFNyMDNtR1FZdDFTUkdDZS9xUmdzN1J1L3hrL0UrL0ZPWjFX?=
 =?utf-8?B?b3MyQmNyeW9abThJS0xtelBqaVh3ZXdIMlJkQU1qRDlGUEg1andqU2hJU0ZP?=
 =?utf-8?B?ekZXTzcwMGN6K0xXdDRscURDZEU2cUVDV2dJeHdOSXRnMjJSaTQ4Vm5TSGRZ?=
 =?utf-8?B?VUl2M29aU2hiNm5kYUh1Y3N1SmYxYWUwcHVYd0VpMHpJc205VlZ5T1VzTUcy?=
 =?utf-8?B?Y1dML3h4TDI4cERscm1uckFUZ25xWnc4dWVoait0UjFYeldTM2MwdVJxS2hx?=
 =?utf-8?B?QTM0RHErWlpZd0RJNzFPKzRoeDhUcmxpYXNHamJwQmxvdjRxeGJlU0xsVzdI?=
 =?utf-8?B?QVk1Vm0rSzl2bDVHN0ZnUW1DZnZ4Um1Fbm1LaWVmQ2FzQ0ZQcU80ODZOUm43?=
 =?utf-8?B?SnJSVEdOODNsQVpUb3Q0anhEaEdUSEhZS0lLckVJVmNlOWxJQnJqMkwwVGlu?=
 =?utf-8?B?L1A0RitlamdqbnZTSlNUWUtJcytrRXBIV216dkNRWjJqeHVHY2NhejdZOVJJ?=
 =?utf-8?B?TWlhd1VDVnp0Nmh0YUMyT3E1WE5IUWs0NHR6SWkwcURQMWtwb2Fqc01MOElC?=
 =?utf-8?B?Z3lyRzNJdzRodUEzTWtyOTZ1WU9BYjJ4bml1S1Ywc0RnR3k0Qzc0TU5XdHFp?=
 =?utf-8?B?Sjd5QlFnTlI1cnNGcHBEWE96MzB1azV0WEFEc0tNeC9SK2VqbmptUlNEY1dV?=
 =?utf-8?B?ZitEdWNxcFR0MHJwaHp3NzEzUmloYlZuaEVBUlNRTGZ2RUZVa1VOY3hQRTRN?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bb51ae-d804-4553-5739-08de0dda6dfe
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2025 00:08:13.6338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYJBQCJTgbwLcCQFu3K940ogDrpywIyCtx3Sk8ze5RspaUzwybwisBCKRv9PZ+u93SurvugGezGTGtBOwcWR34jrK1QrBQoCZULrmE5QQbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7023
X-OriginatorOrg: intel.com

Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> There are use cases, for example virtual machine hosts, that create
> "persistent" memory regions using memmap= option on x86 or dummy
> pmem-region device tree nodes on DT based systems.
> 
> Both these options are inflexible because they create static regions and
> the layout of the "persistent" memory cannot be adjusted without reboot
> and sometimes they even require firmware update.
> 
> Add a ramdax driver that allows creation of DIMM devices on top of
> E820_TYPE_PRAM regions and devicetree pmem-region nodes.
> 
> The DIMMs support label space management on the "device" and provide a
> flexible way to access RAM using fsdax and devdax.
> 
> Signed-off-by: Mike Rapoport (Mircosoft) <rppt@kernel.org>
> ---
>  drivers/nvdimm/Kconfig  |  17 +++
>  drivers/nvdimm/Makefile |   1 +
>  drivers/nvdimm/ramdax.c | 272 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 290 insertions(+)
>  create mode 100644 drivers/nvdimm/ramdax.c
> 
> diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
> index fde3e17c836c..9ac96a7cd773 100644
> --- a/drivers/nvdimm/Kconfig
> +++ b/drivers/nvdimm/Kconfig
> @@ -97,6 +97,23 @@ config OF_PMEM
>  
>  	  Select Y if unsure.
>  
> +config RAMDAX
> +	tristate "Support persistent memory interfaces on RAM carveouts"
> +	depends on OF || X86

I see no compile time dependency for CONFIG_OF. The one call to
dev_of_node() looks like it still builds in the CONFIG_OF=n case. For
CONFIG_X86 the situation is different because the kernel needs
infrastructure to build the device.

So maybe change the dependency to drop OF and make it:

	depends on X86_PMEM_LEGACY if X86
	
> +	select X86_PMEM_LEGACY_DEVICE

...and drop this select.

> +	default LIBNVDIMM
> +	help
> +	  Allows creation of DAX devices on RAM carveouts.
> +
> +	  Memory ranges that are manually specified by the
> +	  'memmap=nn[KMG]!ss[KMG]' kernel command line or defined by dummy
> +	  pmem-region device tree nodes would be managed by this driver as DIMM
> +	  devices with support for dynamic layout of namespaces.
> +	  The driver can be bound to e820_pmem or pmem-region platform
> +	  devices using 'driver_override' device attribute.

Maybe some notes for details like:

* 128K stolen at the end of the memmap range
* supports 509 namespaces (see 'ndctl create-namespace --help')
* must be force bound via driver_override

[..]
> +static int ramdax_probe(struct platform_device *pdev)
> +{
> +	static struct nvdimm_bus_descriptor nd_desc;
> +	struct device *dev = &pdev->dev;
> +	struct nvdimm_bus *nvdimm_bus;
> +	struct device_node *np;
> +	int rc = -ENXIO;
> +
> +	nd_desc.provider_name = "ramdax";
> +	nd_desc.module = THIS_MODULE;
> +	nd_desc.ndctl = ramdax_ctl;
> +	nvdimm_bus = nvdimm_bus_register(dev, &nd_desc);
> +	if (!nvdimm_bus)
> +		goto err;
> +
> +	np = dev_of_node(&pdev->dev);
> +	if (np)
> +		rc = ramdax_probe_of(pdev, nvdimm_bus, np);

Hmm, I do not see any confirmation that this node is actually a
"pmem-region". If you attach the kernel to the wrong device I think you
get fireworks that could be avoided with a manual of_match_node() check
of the same device_id list as the of_pmem driver.

That still would not require a "depends on OF" given of_match_node()
compiles away in the CONFIG_OF=n case.

[..]

This looks good to me. With the above comments addressed you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

