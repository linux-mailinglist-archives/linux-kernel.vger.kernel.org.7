Return-Path: <linux-kernel+bounces-881642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33940C289FA
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 06:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF5A94E5506
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 05:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F042571D8;
	Sun,  2 Nov 2025 05:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HpWjYar1"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F419E322A;
	Sun,  2 Nov 2025 05:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762062375; cv=fail; b=WIffWdps5pSLoAF4dQE4E/H42qYyfy+9EcfeXdVrXETuzIW8wUAT35JynHp6h0Fxc698AGRZw04xZiCJ6XgeBptAznPynKze6PjKqtJ9ewxVbHxaM7dVox5INKfaJqeqYlpig+AM/HIaKlKusg8o0pLcG+zpdwZpW9hO8AE7kdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762062375; c=relaxed/simple;
	bh=yca/Pz1T/8nU+SfuF6CFxC3292lAGYah7IWfhckmC+0=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=ObQBEo9e/IQnSz1353o/LjZSUrhMV8dCGXKGYUqogI/rolOYjkR+7IWZC8oPb0+IKeTO6JG4RXvAWx+Kbve40zfmEp247CpA8GrJzRLmP1qGdUm2GjyT66M4FP/M6KeS6DuVKB3gmAYZXa/v0k/xX4Ra0ylfjBDj+e7lCbLMtEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HpWjYar1; arc=fail smtp.client-ip=52.101.85.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLwPkxF8s9Vvf3227C7ebG1/gfXrCh9e7jDrTVaiJVzGHtisLiR7+weGd0dlwNO/NH3oJyPVG2DbS8+jUw9haGVTnfWa2FAw7Gc8oXk9fdOPfMETxKH8hl2pS1MiygTOjQRLGLWNXUZKL+fk7Jix0DufOGeExSm18CF44mnww1wCqvDDST17cPLiz/uwyOcdoTL4Ha6tzwBxrERTAn8EePq1yU/M1F7Sqv8uLAZms5gHPH+f5YZ7eK9L8L/RyDA9TDqCP8s0pBRBpdGG1BZOoAl/WgsWUJErHl5kQ1I4s3sOcoJ9bPJXAvCu/8XDBJj9Tzn5ysDZ83C5xJwtua/wXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lOHWGH5EZjKh+c4IarugLzeB/kWLY6BMrJS5T08Dtg=;
 b=DZtMR+LOdj3nStL1M9/DUONq8QV9wwg7sWp4jxzqfzTAX1senYOpY2MVmobOfakEeTPE6LjJS9+I0dM+dRrv4wZYcf5hM+xeLfcjJjo1RJPgRDyJvJPqYpDOawp/DCdFvaFIhejufjX7P3yOc/gD6aJDh0MG/GlRYYmR7evrVqVhb+zUQiZrj9and2qopF/Yzx3onvqtK3Vz3y6VPSxuaexVjpnIOwvD85g6orCJojx2MefvWnX4JZ/J9JDMFFNHrcyTJIqOqB5J03kAGEC8WLWBAr9N0ms1YQNxt+VLCSRCsf56em+04DwGQMruYjU6yDYtfQ64LhTPpzF57HRJcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lOHWGH5EZjKh+c4IarugLzeB/kWLY6BMrJS5T08Dtg=;
 b=HpWjYar1ixsZ4P89IFfrAatHRnfyoBvdS81nxNLXjQxHJVIcwKIBUL2wSSmixBXpAZOuHHLpe2uxjJOqNHTPvbElDovhG4N2nNUIvZk7I4S98gzCEUWwkPkAg5NahABmZY/rPYpf1oomV9xE5u9VD+0nIu2I84FKKI24pcA6iZtuZ28ZH7V96FdrH4pB5tJ2Qe58mP3nLVSf7JYxIBwxdt/3eQGJ6t4+3xjXjknIGjyICuzp5vzg16HzXxmOTKFPnbLYSwds9adCWOU7ZtRhGJuseaCvKeusVZ0RFZg8rrWgvwixeTkFXi1P9rJOu8hjtS+uudye9PoRHF5O4wgNKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH2PR12MB4197.namprd12.prod.outlook.com (2603:10b6:610:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Sun, 2 Nov
 2025 05:46:07 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.013; Sun, 2 Nov 2025
 05:46:05 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 02 Nov 2025 14:46:01 +0900
Message-Id: <DDXYZ5ZHVYCB.3F3GTUPLUQOAM@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Danilo Krummrich" <dakr@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Yury
 Norov" <yury.norov@gmail.com>, "Jesung Yang" <y.j3ms.n@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/2] rust: add BitInt integer wrapping type
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251031-bounded_ints-v1-0-e2dbcd8fda71@nvidia.com>
 <20251031-bounded_ints-v1-1-e2dbcd8fda71@nvidia.com>
In-Reply-To: <20251031-bounded_ints-v1-1-e2dbcd8fda71@nvidia.com>
X-ClientProxiedBy: TYCP286CA0223.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH2PR12MB4197:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d507d3-5b70-4c21-a3d1-08de19d31d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFM4T3ViNzRqRHJpYkVBNm9pU09OUnhOR2ZqRHZGSWpMVkJ3Z3BvdW5XUjV1?=
 =?utf-8?B?WHB6cUhWNnE0THExaWNRT3BGN0VuZEVXNXhGVDFwSmNsUDNjcGUvbFlwKzda?=
 =?utf-8?B?SWlHOGFiRUYyd2RoUUpJc2orcVIxeFRXeXJieUIwZzBUU0p0NUE4TnNkYTJl?=
 =?utf-8?B?YUlGSEFHdzlrUTNIdUUyWCtac3ZtNUpJWHVUZXdpVUI4bmYzbStjbllRQnRi?=
 =?utf-8?B?dEphMDNyWEZJMHYwUUlCdk1yZTBqTWJXdVJTZHlKV2Z3Qk1mZklCYVRQT0dW?=
 =?utf-8?B?dzhaU2RmaGo0YmpkbDRzdGZiNi82WU9hbnNNTEhkR1g1L3Z4Y3JVZ3dKQmVM?=
 =?utf-8?B?VE5obTA0RjVhbWVmQlpyTHRuRXcyWi9JZkFJY2o5RnBhU2VlSk10ak51UXha?=
 =?utf-8?B?UDhtT2tsR0VqbDlEbVBNMi9tNGs5Tmwva2xXRWVaQlJpT1VWUUtDUlRpWmI0?=
 =?utf-8?B?Z2FVZTFZSndGRGFGZXdNay8wTGVqVHp4dVBodXNjdEtmNkNIZ3Ywb3lZNG4w?=
 =?utf-8?B?UVF4SDZoVFBEN0V0Q245MXN4SGE2aHVIZGFDUE9RZ3RCbFVGYzVpNnRZTE1k?=
 =?utf-8?B?d1hUK3AvNGRhMjd6ei9QUTdrTG5TRWtscm84TlN1cjlOUXkyN2dWd2UyQ01a?=
 =?utf-8?B?c3NJYTdabGFHSHA3TVlSdnFxRWY2eVdkM1dUdm9wY2tFVzFsaXRXMkV6ZVJy?=
 =?utf-8?B?UTJ6V2d2bmhCaGFFVFFRTndkQmhvQlY2LzlDbUhlUmNvSmZncnhFdWluSjQ1?=
 =?utf-8?B?dmkrR0wxL0d3QmZ1QllzaGdlTS9ISGJYdHpZempmbnJYTW5weWRRb0dyaGtp?=
 =?utf-8?B?ZDFBRzhkbGppUmRoTE1hU00zRGlBaWplTVIzTjZRMDBkdGVuUlJwcTVxL1dD?=
 =?utf-8?B?TlBZQU1qR0g0R2JaZFd4LzN3VmdtOEE2K2x1SXBHZ25uaWF5K080RWoxdk9R?=
 =?utf-8?B?ZVh1YXBoRWhPVC9tL0E2aWN0Y2ZKdjhpNVRxaWt2MzIzK0JEeXpJRG51RW0v?=
 =?utf-8?B?UHN0RHZZR0ROVjZwbDB6U2hVQk1ZU2JENk9EVmpraDhCdTJWcUIxVW8zQjVF?=
 =?utf-8?B?bE5Ia1FWN2xEemVqYXVHUjVqWDBpeEhiSmNUUGsxdFoyK3d5YjMyanRwVEFt?=
 =?utf-8?B?K3haaGVoOFNZcC80cUllNHJLK2NTb0lHQXVZR1M4V1NRUlE0T3JaTlJMVHgr?=
 =?utf-8?B?SlRLSllNMVZuVHJBWmxUSEppRDRFR0poQnY3aE04T24yeGRHeEdUUmhsMHBl?=
 =?utf-8?B?eXBDYThZZ0lBemw0aDZUK0JteGpiTGNOU3krZEpyRDdHajhGRkc5aXVWTnVW?=
 =?utf-8?B?R2NEZkpSS3pwM0hwSUFNZmF4c2dnTTJzdC9sR09lazUvb1BNOExhQWU2UGZ5?=
 =?utf-8?B?MnJaNnZoemlVdEF3T1VTUlJCNXY3OFo4ZTNxSjhldTVSUCtTNDlRd2xzMmQ1?=
 =?utf-8?B?TWdudE5QNDNSTlpmZlhtc2hKWXB1U1l5YThiQTlhSEkvVHVzRE02VC9tQ2dp?=
 =?utf-8?B?M3MzalZyN2MzSWVRSDBQVEVYTk5HcTBoRzRETkpiZjFtc0VFSkVMSU1ETmdp?=
 =?utf-8?B?R0JmNjJ2WjBEU2FDQ2p5dnhTTk5jRlFwaEkzSVU2bTBIWFlyS0ZFcmo0T3dE?=
 =?utf-8?B?WCtpaCtqQ0F3c2JzVUs2ektEZmN0RmFaNTNrYXRGM1pCVVdXYzZSeG02eFkx?=
 =?utf-8?B?QmxlSDFJOExhUStGTWNVZXNvZmhGZERjQ0pkdmIwNi8yY1VyV3YyczNiNnBV?=
 =?utf-8?B?SlBkcm9BZk00M2hNKzBWbHNUK0lIS290STl1QlVOMktZM080MUI5NkI2NU9r?=
 =?utf-8?B?QnUzUUNrU05kdTRrSWtxekZKblhER1B6M2dGU1dCYURTZFAyMlNnWThDRTBE?=
 =?utf-8?B?SEFxUjAyRXBQMTdZSWluNXFIZjRzekl6WmdmbWR2Q0ErWS9ZUFpNazBsZUFG?=
 =?utf-8?B?TW9oa3pCZ2hqeDZuMTIzeWI5UXJjU1NnbEdMbCtFRlV6Rjl5VmlkVmJWMEVB?=
 =?utf-8?Q?zVWGxdrEzl0HLkwmwZNGvQSfBSOUjU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RCtVSXZnd1JXRWVJNS9OdnlEOWcyVjkvV1VMejA1cXVtTFcwUG02Nm9DMVJw?=
 =?utf-8?B?and3TEU1ZC91SGxHQ0lzR2tWWVlScklQcWxEVkJmMzBNcExreWxCbFhHK0xw?=
 =?utf-8?B?eFowdXBwZ2VnclVka01rQlh3Wi9kVzF3UDhKR3lJTnRoa1hQOHh6Y0RZNmdX?=
 =?utf-8?B?Z3FscE1WVWNLVGZwdzNlL2VZSUdDNzVxOHkraUlpYTFHS1pQb3piMDlMN3pS?=
 =?utf-8?B?aWJwZ05mOEtFbXBBQkthbGJmczl3ZXFNQWRBU0ZrNlhlWVdpQVY5QmNpYUN0?=
 =?utf-8?B?OFJFUHNVZzMrSEFyeTN2czlDY1NkYU5XdTBVY3JBYy80c0I3WFNsZzM2QkJQ?=
 =?utf-8?B?MDB2bWhCbVJVZ3BYUlhmT1RMVVFkcld4V3R0YWNWOUNxZ01FYTUvK29PbVRy?=
 =?utf-8?B?bzN2TEJnaFBhQmh0K0NjamJ1OWRVTFhVWkJoODRHOWd0Y1VqR21XakxTT1pX?=
 =?utf-8?B?WlQrYUhaZFdoRmRGZ0hpZXZueXdBMjkrT25QV24rZk92WDVoQnh4S1F2ZnZ6?=
 =?utf-8?B?TUZOYXdtaWtYRkFSOCtqek52b3FydGFNNUNxcGIzVWZwL3hIOXVTTUE4bUFD?=
 =?utf-8?B?anF0NmZ1MkxIcEI0RmVYVXBsNFBTdlVMZzdGSWZNZC9kZlh4SU1JQklBV3dt?=
 =?utf-8?B?SERIQlhjTW9wTzBiUEYyTmxzVkVmaDFiOE42bWw0SHpxd2llZ2V0L0c4WUxK?=
 =?utf-8?B?NjFsdFhzMEtqNW4zTW80S0Z3ZjJQVmR4NjZueDhyNk8rTlV1cUpURWxycVJR?=
 =?utf-8?B?bnpLUHN5Mjl5MVdYd2NrNTJ4Zmc4YUhTTW1kZHlxSmQ4T1ZTTTJ3OGsvUGVy?=
 =?utf-8?B?Z3A1clR1R0tOMTdPVGpRK0lhcVlPbXNJWmtZaGdTWVBOazIyQlhaL1NYZjV4?=
 =?utf-8?B?dkRtRVo5Yld0RGYzZmRib0hudG9WcTArUXoxRTVsR1lONE5GK1hUMitOSnpw?=
 =?utf-8?B?bkZ3bFU1MmRKVllKNnd0eStyRjFIeVZQK2xaS1o3ZFc3aEp3YlVKWWZwazdn?=
 =?utf-8?B?YVQ2Z0xaQWtHa3k1c0NpWENXMmQ1Q1ROVHFXZkNLNzFmbFNPa3VJaVdYcytB?=
 =?utf-8?B?cjFRSEFWZ1Y4WFpSVG5jTlJUd1dZUlF6ZmRLWFZpUHBhYWd3T1J3bXBMc2lP?=
 =?utf-8?B?T2x3NHpqT3VXR0ZOVmhwRXhiMk9xRTFqUFFZTzdwSEhkVHNBU085bzZua1Zt?=
 =?utf-8?B?TmlaeHhkZWgyc0dnVTBEZ25oOTgrWldVTW9VK01LN3o4OEE4c0s2WGR2TlFa?=
 =?utf-8?B?RDA2NC9XU09YbVJ4ZnR6N0ZUdm1QcVhKdFl3dXBHZ3JxclVPOTVaVW4yenFi?=
 =?utf-8?B?bHVvOTNDZ0VNRjYrZ1pjZWV1ZjZzQUpTYnlXV0ZKSXQydktCZVRod09rYXBK?=
 =?utf-8?B?L1hFR04vS0g3ZWp4TzRrMEt5TTZsUTZTRFZoWUVRa1dLYWpOc28rRUxtVVU0?=
 =?utf-8?B?eU9GS25td0p4dzhVQ1YzZUpTRmhVVk9ROGw2VGYrNTZUbFExcnMzYkk5S0Fo?=
 =?utf-8?B?aDR6akd1Q0tJYTBITTNrV3c0SlI5Znoxekh1OXAxbmtjSmtEUStmejhHc2hY?=
 =?utf-8?B?aExSQzBoZGhLdy9EeGlQTDByN2ZBeG1zU2V1ZGpNS3F4bW16bzk0MlZibURV?=
 =?utf-8?B?SXBlVERURUk2aUhBNlJZQWxTLytWYXZkT2x3ckF4TUV0RU11bDhqMEx3NTZy?=
 =?utf-8?B?SHpsVm90MjlSZUNaQmV0YU45QXE4TE5wR2ZodFJGYVUwbkdINEdVWDlIS0ZU?=
 =?utf-8?B?N2R5UURWY1hKL3k2ekd6MzVrWUx0Ni93QUpVNmg1OEtsQUxIbGN3clI3ZjdP?=
 =?utf-8?B?MVpOT01mdzF2Tlo4VHRER20wdzVzZHAvMmNrOVNiTXVpUHhCZWgzVk8wUUJZ?=
 =?utf-8?B?SVlTb2sxTHQwN214ditYSVFoalRMNDRpR2gyNTNKTWZvTlFHdFNKUnVPZCtJ?=
 =?utf-8?B?NE9BY0tFNGhzMm9QZXgxeE1OZE96U25kWXErU0RqRVhTTWdaSW9RcGxYampw?=
 =?utf-8?B?b0l5anprSmh3OVRCUkNZOG11KzlxSjRScFZOTEFmMTlHZFlubGp6bUFleW10?=
 =?utf-8?B?alVXdWg2NnQvdEg3TE4rdjNvK2VBNE5nQ2ZSdS8vakpYRSsxbkQ1TjFBekVX?=
 =?utf-8?B?RUxra3ZFY2lwVVZNbG1heUI5N05ITWQ3QVp2RHN6eEtLS05aRXB2cVhzTC9H?=
 =?utf-8?Q?OE1s6a4jU2CMnDrX9yrVKpLizwO/8D9/IpV3ig1xhn92?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d507d3-5b70-4c21-a3d1-08de19d31d3d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2025 05:46:05.6339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRDWUwQwJpDNdqTlisG9onffBklboIgvpj5wN1zCounAmOdAhyUWGF+Nkc4D7j3NekXgzWcdO+gi1zdGPrRaZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4197

Quick self-review as I've found a couple of points that can be improved.

On Fri Oct 31, 2025 at 10:39 PM JST, Alexandre Courbot wrote:
<snip>
> diff --git a/rust/kernel/num/bitint.rs b/rust/kernel/num/bitint.rs
> new file mode 100644
> index 000000000000..5af1447347a8
> --- /dev/null
> +++ b/rust/kernel/num/bitint.rs
> @@ -0,0 +1,896 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! [`BitInt`], a primitive integer type with a limited set of bits usab=
le to represent values.
> +
> +use core::ops::Deref;
> +
> +use kernel::num::{Integer, Signed, Unsigned};
> +use kernel::prelude::*;
> +
> +/// Evaluates to `true` if `$value` can be represented using at most `$n=
um_bits` on `$type`.
> +///
> +/// Can be used in const context.
> +macro_rules! fits_within {
> +    ($value:expr, $type:ty, $num_bits:expr) =3D> {{
> +        // Any attempt to create a `BitInt` with more bits used for repr=
esentation than its backing
> +        // type (i.e. create an invalid `BitInt`) must be aborted at bui=
ld time.
> +        build_assert!(
> +            <$type>::BITS >=3D $num_bits,
> +            "Number of bits requested for representation is larger than =
backing type."
> +        );

All these similar invariant checks sprinkled around the code are very
error-prone. A better way to enforce them is to have a private
constructor that is called by any path that creates a new `BitInt`, and
have these invariants enforced in a const block:

    const fn __new(value: T) -> Self {
        // Enforce the type invariants.
        const {
            // `NUM_BITS` cannot be zero.
            build_assert!(NUM_BITS !=3D 0);
            // The backing type is at least as large as `NUM_BITS`.
            build_assert!(NUM_BITS <=3D T::BITS);
        }

        Self(value)
    }

This means we do this in one place instead of 3 or 4, and since the
invariants are enforced in const context we get a decent error message
should they fail.

<snip>
> +mod atleast_impls {
> +    use super::*;
> +
> +    // Number of bits at least as large as `64`.
> +    impl_size_rule!(AtLeast64Bits, 64);
> +
> +    // Number of bits at least as large as `32`.
> +    impl_size_rule!(AtLeast32Bits,
> +        32 33 34 35 36 37 38 39
> +        40 41 42 43 44 45 46 47
> +        48 49 50 51 52 53 54 55
> +        56 57 58 59 60 61 62 63
> +    );
> +    // Anything larger than `64` is also larger than `32`.
> +    impl<T> AtLeast32Bits for T where T: AtLeast64Bits {}
> +
> +    // Number of bits at least as large as `16`.
> +    impl_size_rule!(AtLeast16Bits,
> +        16 17 18 19 20 21 22 23
> +        24 25 26 27 28 29 30 31
> +    );
> +    // Anything larger than `32` is also larger than `16`.
> +    impl<T> AtLeast16Bits for T where T: AtLeast32Bits {}
> +
> +    // Number of bits at least as large as a `8`.
> +    impl_size_rule!(AtLeast8Bits, 8 9 10 11 12 13 14 15);
> +    // Anything larger than `16` is also larger than `8`.
> +    impl<T> AtLeast8Bits for T where T: AtLeast16Bits {}
> +
> +    // Number of bits at least as large as `1`.
> +    impl_size_rule!(AtLeast1Bit, 1 2 3 4 5 6 7);
> +    // Anything larger than `8` is also larger than `1`.
> +    impl<T> AtLeast1Bit for T where T: AtLeast8Bits {}
> +
> +    /// Generates `From` implementations from a primitive type into a [`=
BitInt`] that is
> +    /// guaranteed to being able to contain it.
> +    macro_rules! impl_from_primitive {
> +        ($($type:ty =3D> $trait:ident),*) =3D> {
> +            $(
> +            impl<T, const NUM_BITS: u32> From<$type> for BitInt<T, NUM_B=
ITS>
> +            where
> +                Self: $trait,
> +                T: From<$type> + Boundable,
> +            {
> +                fn from(value: $type) -> Self {
> +                    build_assert!(
> +                        T::BITS >=3D NUM_BITS,
> +                        "Number of bits requested for representation is =
larger than backing type."
> +                    );
> +                    // INVARIANT: the impl constraints guarantee that th=
e source type is smaller
> +                    // than `NUM_BITS`, and the `build_assert` above tha=
t the backing type can
> +                    // contain `NUM_BITS`.
> +                    Self(T::from(value))
> +                }
> +            }
> +            )*
> +        }
> +    }
> +
> +    impl_from_primitive!(
> +        bool =3D> AtLeast1Bit,
> +        u8 =3D> AtLeast8Bits,
> +        i8 =3D> AtLeast8Bits,
> +        u16 =3D> AtLeast16Bits,
> +        i16 =3D> AtLeast16Bits,
> +        u32 =3D> AtLeast32Bits,
> +        i32 =3D> AtLeast32Bits,
> +        u64 =3D>AtLeast64Bits,
> +        i64 =3D>AtLeast64Bits
> +    );

I dislike this part so much, especially since it could be done much more
cleanly if only we had `generic_const_exprs`. But for now we have to
work our way around with macros.

Still, this can be simplified significantly by replacing the
`AtLeast8Bits`, `AtLeast16Bits`, ... traits with a single
`AtLeastXBits<const N: usize>`.

By doing so, the cryptic

    Self: $trait,

constraint can become

    Self: AtLeastXBits<{ <$type as Integer>::BITS as usize }>,

which is much more explicit about its purpose, and we can remove the
`$trait` argument from the macro.

what more, we can even write a constraint like=20

    Self: AtLeastXBits<{ <$type as Integer>::BITS as usize + 1 }>,

And support conversion from unsigned primitive types to signed `BitInt`s
with at least one more bit.

The same simplification can also be done for the `IntoXX` traits below.

I'll submit a v2 soonish with these improvements and some more minor
fixes.

