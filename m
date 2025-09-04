Return-Path: <linux-kernel+bounces-800049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EB2B432C6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A79582B81
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A062857F9;
	Thu,  4 Sep 2025 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="CCAkY7uy"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013060.outbound.protection.outlook.com [52.101.83.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB892857C1;
	Thu,  4 Sep 2025 06:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968524; cv=fail; b=qJFbukHhHvqUuXeVc/NonFpKDD9Qihjbv4diUY9HBuvZis3hEfYaSXfM/WOLAMq2fFDslim7ZQ+JurzGgdFqFzGIMYh+FmokIyhYxVb0T2ElD4eO6EtYJ3SuCtmwkk8q5LfehiwhYIaSNA8Ax1tFgVecg1HGybWY0O5w3L8tUYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968524; c=relaxed/simple;
	bh=T/T0z3P6H6ifnnzYcmmWOHxAAMRF0SaOKifEht3gemY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WwYnNQ2ZNxBYtvFZIGlAqDEYiL1s44SNSg8MFXNbl6kHYHRmlT6XongjJiQBn6to69Gki5gyfRhVCjj+htz9473lftikpjsILP5rjWwdjIBauXNvvPDGzDwvYh6W83qVF1z4DyoaylBm1U+0wqCA7Hyj+SazHqMJDz9G3jeni8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=CCAkY7uy; arc=fail smtp.client-ip=52.101.83.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wb+wQ6vx+d/fS32AHFur4Vob7wC9iQi6Wkkf29joL8j/JRaif657y0clUv7Xf3+kiVkm3h9W755qXgJzBdmNoTWZK+TEqYUS0Pn6xh5qgzq5E0usZgTGedVB2AOcVR5dmfwkzP2iGXGwkmR297wm4inFPUTYcdvwIGzeLztzKvcVJJSS1yZLdzBP6YDphdaOBsjCZoExmNvwuoXctxAZAdf3GZqmCxbNcEf7I1wQd2N4rfXOzD3AAGYTaH38DLFEioDmcVLyjJ8n/uN+4qmYzfE3CgvnVDZBnwXxGdFFNk3L2Kf1ybcQgaDf8T5zAboe9FB2qDdrCfXFg/tfItHuTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPMAZ7citxPEckTrUQe9l+gcpYaktiZJUHxVlpT7Ssg=;
 b=NhoXlH0Gbc+R9qcsUC0de16aOXDwqgHVNeitACTFMLnhOGgsBd9EZ7U1bN6kXWdnLrLGS1tWbwXYKqJvYAgHTMJDLQ6AT4Fg49+6JF8mq3COIOpkfEs0xuwj9VfJnzDcANd4lAvlU0xU86OfZiLv89LT/2c7kPXr7ZDn9YUzeD5PSs4VaRZPz0+w5vzy8Ah4bGgJY4JNFz444hw4uzSd5LQN9F/p3S8wzPgHJtbdlKdcY5+tufEIZgvrxcKyCTCgTF5TeOgLyXpd2QJGjau8fE8C1OuiFe/xUE8CZ0kmt6V4JPi1mK3ZbqImvYWkJI2Let9pv+MZNWbIRkz3dDqm7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPMAZ7citxPEckTrUQe9l+gcpYaktiZJUHxVlpT7Ssg=;
 b=CCAkY7uyCuF1y+vUimeIATw2E9cXhh7CeUuWN7V4Ok2rpOeFn+W+/QxLQBlNRXw86+bCvkOTcj0010ppelPM12DxposdklZP/1w+C0UfZPUPRaQmTvLdxZAuE7HXBEa1NzshumzVhkMJ/iFC4/N8SMTyLPQnkeGcFIOBmfR3Yo5Yi4bsgca7mZCKSVCmVIQ8dWU3cWn8JEcy4EgrCnj138ZU+dJU6ZA+RvTHG7/IG/fSfKBNfjr4wiwZNZLx2tySwEP44BEIV8iiwXUjea5KL0fFK2xDgF7OifYcVbxT9aYCRWFKCdnFzDEL3WuW3WOe0kgRdcR5cBj0LcozuC3+Pg==
Received: from DU7PR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::15) by AM7PR10MB3254.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:de::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 06:48:35 +0000
Received: from DU2PEPF00028D01.eurprd03.prod.outlook.com
 (2603:10a6:10:50e:cafe::f9) by DU7PR01CA0025.outlook.office365.com
 (2603:10a6:10:50e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Thu,
 4 Sep 2025 06:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DU2PEPF00028D01.mail.protection.outlook.com (10.167.242.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 06:48:35 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Thu, 4 Sep
 2025 08:48:22 +0200
Received: from RNGMBX3002.de.bosch.com (10.124.11.207) by
 SI-EXCAS2000.de.bosch.com (10.139.217.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.58; Thu, 4 Sep 2025 08:48:22 +0200
Received: from [10.34.219.93] (10.34.219.93) by smtp.app.bosch.com
 (10.124.11.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Sep
 2025 08:48:21 +0200
Message-ID: <55ad62f0-759d-48db-a8b2-6ca0b34380c0@de.bosch.com>
Date: Thu, 4 Sep 2025 08:48:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v4 3/4] rust: validate: add `Validate` trait
To: Benno Lossin <lossin@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
	Simona Vetter <simona.vetter@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>
CC: Benno Lossin <benno.lossin@proton.me>, <rust-for-linux@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250814124424.516191-1-lossin@kernel.org>
 <20250814124424.516191-4-lossin@kernel.org>
Content-Language: en-GB
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20250814124424.516191-4-lossin@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D01:EE_|AM7PR10MB3254:EE_
X-MS-Office365-Filtering-Correlation-Id: 35bd53cf-2844-43f6-74c3-08ddeb7f124e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmNBcXFmMFI3d0V0NTRHZWExV3FPTUh0cmRXdzVTTzFNTTdkdGZKMHBzbXpo?=
 =?utf-8?B?cGlZRjhZbXg1TDZkUnZieUdaeXdibnJkTVRDK1ZJQXppWGNTQlk0cVNTZ1NJ?=
 =?utf-8?B?RUJTWXkyZThraXpJSk9TYjRvZ0FxRFowbFFNZlhSclRUNlVDYXN0Q05YMjdD?=
 =?utf-8?B?V3FTWGxsQ1BGa21BOVRFQ0NNWk5qZ3hvMnNZWHJad2NuWVNPSHlGL3NjNXMr?=
 =?utf-8?B?L01OMmxVYTN4QURYci9zcnhkM1p0VTlLblV2Y0xBdTFlanBXcDZLWm1oZGNW?=
 =?utf-8?B?ZWxnN3BJYmVDNDZKVmhwWWVNVXlpd2F2aFNaNnVZR1IrYjlGMllZZmRlSEJZ?=
 =?utf-8?B?WENvSC9QMi82cEdtNWFPSnVhVDdNblE5MGkvaEVheUNnYWhKZzZqYUxuTG5y?=
 =?utf-8?B?a3RLZHB2SWJYQStUZmNwdlYxNzBNejNPeFJYbFhRTXJzYzhNTTlnUjJVZU95?=
 =?utf-8?B?MWI3bHE3U3kvdjNmZmxEd0lib2gxT29KMzNkZWhtMGZuYzlsVkk4TTFEbUZq?=
 =?utf-8?B?aThRUVQzZXFXTHdSdXNiU2VvdFp5alA2K1ovamtJa1k2c1Z0TEVsaUk3NTd5?=
 =?utf-8?B?QjVJcEY2TUtwUVRHTlFUUEZ3b2tuSHNRTDQxTmZjWWtObklWKzlVOHpYMWxj?=
 =?utf-8?B?V255Zi9lbXhMNlgwcitpL3hKWnh1dHpZYnpreDN4YVI0aXo1QzcvL2xISEx1?=
 =?utf-8?B?a3dWYTNzcmt3QUpxbWhIM3Bxa0RDOTVONkhXS01mWmRsNEw0ZFRSbngrSk9G?=
 =?utf-8?B?aVhvOTIzR3JqVDVVTksxcGdTbVEzSXZYZU9vSU1oZHNSc3RQdmhXQ3luR0tN?=
 =?utf-8?B?UEJJNFZiZUZKRHVGMEFQNWlIVEtJcm5kVDJaY21xZkNIajB0QmF5Ri8yV0tE?=
 =?utf-8?B?N0Y4amxkcWxPcU90dTNPazR6cU5oeVFYMThzZ3ZLakNlcVZvS2loU3hjR1M4?=
 =?utf-8?B?RW81blNRSmRmay94WDdJWG83dDgzYS9TdnB3NGp0V2cwYk16TGRZQ3RZTjNx?=
 =?utf-8?B?YTQ4Nm9SWDlCVUxRaVI3K2VUZGl2SDY1OE1pM1puM0FXaWk5UllsdStIZFpB?=
 =?utf-8?B?WXJDNGFoRFJsV2RXelduRTgrcVdCaW50VUF1aHFzQTNJU0g1Z3ZOSkoreUxn?=
 =?utf-8?B?SEkvWkYrTXdJZGdEb3Nkc3lLbTR4Q3o0Ym53NXdReTJNYTRsZFFFUWZzZWVr?=
 =?utf-8?B?Rm5KT2FSOHRJWGhLVzBWTlY5WVZFZHQweHBlVkR0WXlsQ2lhQkN5Z1ZVQlJD?=
 =?utf-8?B?Y0g2UHlXTnh2WTRHQWVQaC9qME00QlY1cUtUOUoxSVEyc0hnUkNKc3hrRnFN?=
 =?utf-8?B?VExydFZsblZva0tTb0dNS3ZFMkJuRS90N0xKbW1UejZ0VUJaQ3h5NCtHMkts?=
 =?utf-8?B?WjdsWGFIMk4wdGFnelVCTGZUcldXbzNlYUNKYStTc3VxZUhFVldHNDd2S2Nw?=
 =?utf-8?B?VzlmeWNKN1pienVBRzR6TWZ4a3BqcWY2blh4YU14QlRFcFVMajZCd09qbnM5?=
 =?utf-8?B?QlVQcnpKek5xbkMrZXdaV01NdHplSWNuQmt6RXltWE1zZDl3ajJDSW1Ld1B3?=
 =?utf-8?B?cEZsREpZYndVMlVmMGYvVTBIbTdvb3FUQWtacEtUQ3hIOW5IbHVzblFhU3l5?=
 =?utf-8?B?M0REdWlPd29aRlVxNFFObE43NHFyMGFrV0JEbGVFQVFJejAvQk9BV0JUbmlM?=
 =?utf-8?B?aEdINEhEb2JCN3FwUXpLNStpczlyZnk1a09QYlMxSFJWYWhlYk9HZWEwTGlI?=
 =?utf-8?B?Tks2UjVEcGtLd1BHejdwZkZ4cnN6RHowZElDSDZmekJ1Z01JUUJXMmROb1JO?=
 =?utf-8?B?YllRVUw3SDJmd3JQSkVNSTdIcEw5aHp1SFN3RTZJQ0hsRjAySjlyTVFlYmYw?=
 =?utf-8?B?NmRwdyt2b3I2UnJKMkZXNTlpWE5ScGJGL2U1UTJoWG5mdFdQbkpFcWJwYkY0?=
 =?utf-8?B?V3JTdkdCN203dSsrckRQRENXVzNLMUozcjUzOGt2MnE2MkVVMXdwalFYMDBP?=
 =?utf-8?B?bEh1NHRvTStPdklIT05GN3lIN0FMVHdHSjhiVVNQcXRBSmpGL3Y2ZzVLSzlQ?=
 =?utf-8?B?ZE9aMFErbFIxSitoSDBxT1RuK3Q2eTM1RXVEdz09?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 06:48:35.5867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35bd53cf-2844-43f6-74c3-08ddeb7f124e
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3254

On 14/08/2025 14:44, Benno Lossin wrote:
> From: Benno Lossin <benno.lossin@proton.me>
> 
> Introduce the `Validate<Input>` trait and functions to validate
> `Untrusted<T>` using said trait. This allows one to access the inner
> value of `Untrusted<T>` via `validate{,_ref,_mut}` functions which
> subsequently delegate the validation to user-implemented `Validate`
> trait.
> 
> The `Validate` trait is the only entry point for validation code, making
> it easy to spot where data is being validated.
> 
> The reason for restricting the types that can be inputs to
> `Validate::validate` is to be able to have the `validate...` functions
> on `Untrusted`. This is also the reason for the suggestions in the
> `Usage in API Design` section in the commit that introduced
> `Untrusted<T>`.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>


While experimenting with this I was looking for an example how to use
`Validate::validate`. For example, illustrating how the "very bad idea"
read_bytes_from_network() example from patch 2/4 could be done correctly
with these patches would be nice.

Just to illustrate what I'm thinking about see [1].

Thanks!

Dirk

[1]

diff --git a/rust/kernel/validate.rs b/rust/kernel/validate.rs
index 2a582a572aa5e..688ccd541712a 100644
--- a/rust/kernel/validate.rs
+++ b/rust/kernel/validate.rs
@@ -82,6 +82,7 @@
 /// Here too the reason is that `KVec<Untrusted<u8>>` is more
restrictive compared to
 /// `Untrusted<KVec<u8>>`.
 #[repr(transparent)]
+#[derive(Copy, Clone)]
 pub struct Untrusted<T: ?Sized>(T);

 impl<T: ?Sized> Untrusted<T> {
@@ -201,6 +202,49 @@ impl<'a, T: ?Sized> Sealed for &'a mut Untrusted<T> {}
 /// Care must be taken when implementing this trait, as unprotected
access to unvalidated data is
 /// given to the [`Validate::validate`] function. The implementer must
ensure that the data is only
 /// used for logic after successful validation.
+///
+/// # Examples
+///
+///```
+/// # use kernel::validate::{Untrusted, Validate};
+///
+/// struct TrustedIndex(u8);
+/// struct TrustedData(u8);
+///
+/// # fn read_bytes_from_network() -> KBox<Untrusted<[u8]>> {
+/// #    Box::new(Untrusted::new([1, 0]),
kernel::alloc::flags::GFP_KERNEL).unwrap()
+/// # }
+/// impl Validate<Untrusted<u8>> for TrustedIndex {
+///     type Err = Error;
+///
+///     fn validate(raw: u8) -> Result<Self, Self::Err> {
+///         if raw != 1 {
+///             pr_err!("Invalid index: {}\n", raw);
+///             return Err(EINVAL);
+///         }
+///         Ok(TrustedIndex(raw))
+///     }
+/// }
+///
+/// impl Validate<Untrusted<u8>> for TrustedData {
+///     type Err = Error;
+///
+///     fn validate(raw: u8) -> Result<Self, Self::Err> {
+///         // All raw data values are valid
+///         Ok(TrustedData(raw))
+///     }
+/// }
+///
+/// fn example() -> Result{
+///    let rawbytes = read_bytes_from_network();
+///    let index = rawbytes[0].validate::<TrustedIndex>()?;
+///    let data =
rawbytes[usize::from(index.0)].validate::<TrustedData>()?;
+///    assert_eq!(data.0, 0);
+///    Ok(())
+/// }
+/// # example()?;
+/// # Ok::<(), Error>(())
+/// ```
 pub trait Validate<Input: ValidateInput>: Sized {
     /// Validation error.
     type Err;

