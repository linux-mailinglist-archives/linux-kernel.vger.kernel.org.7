Return-Path: <linux-kernel+bounces-788800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EF6B38A73
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5AF15E40EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E0A2D0C9D;
	Wed, 27 Aug 2025 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ybAP3xO/"
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020121.outbound.protection.outlook.com [52.101.195.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F301B2641E3;
	Wed, 27 Aug 2025 19:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756324156; cv=fail; b=TlW9hQAIgtbNbqOAwDN07YdEG/bUM8Tqr1y9HTZc6TsohxHU5TAfq3TdYEpg8zkB1Nsd3sR6WgETJSJ8sGEF6wM8BPSqXTT3f5hg3zgH5TbE6YVavXxMa8yuu0XMS6JQnPIfGnMHQh7Dw05u2u0SdjR257UTBaqmT9TeSe+Nrk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756324156; c=relaxed/simple;
	bh=lOulybJf3l5U6hGYFEqUvoM+uxz3A/mFHvBgsAMxlXw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GB+cRGjYl0WU5/9swlnf2uZIfCyB4tdeibJ4QcWu3Cz/TOJu52FCpEfymMsUxYmOOnW4rKNz9QeUVqWdgdO8Kcq+7Auf/2vnJCVb3buyVaHH5AqXmRUY2Rb+YNvOBQhkJy6mVkKjoYl5V8eYVmY4O5D3t1ZqOx75CXD4mZ5qbe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ybAP3xO/; arc=fail smtp.client-ip=52.101.195.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RV704T/x8JoyhLQ3Pdq1s6Euh7cc+CIHV7qFL3HZN2TNJkULjmycrW9t+D6KfIeGkq+QB8V6UqCxAVrh3Sa8ycgBHMM3P9MZqAPRp2EUmmO9oCusYlaNi7RjUTWfSg4jHVpOe4DEgM7Mae7RMwstl3gdVxWjLoteTwkUsAXTic6+GD8PHNH1ThSNKuv1ZAez3nuIGAGsvDw0p+FtTKa9USQgZRHcpF8pVqh7QHR5ZSjzTMzQr8ujUdkAs1QW/LxxqujvRdtgqRhbuIpRpIji3P5ZKfzZWQ9shONiabeeNUQGICBgHfXQxEm/TEgENi6rbSWtgUK3UlGIGUnAC66m6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBRFDsp7tTQ3ldJRsPpzp7WtZ9hwtW050eQAY3G5hQk=;
 b=Dr+0wIwR+ddRmhtL+gbKUmlWZW65bj3TnkfyPdm3llUn6pmrjJeWSzwOmLVJMXBg0Jq49lwweBBF5VTtfHSWNXiIH5Z+4VlQL6SBoBiv58ZXEuFmLQcrvUglsKDrKSDWZeDowCyhZ3peHmscPMrtj1OgrEDIGVdMta+QdK7vTnGyw4B1eszC6m4Lh1j4l3wFhlYqdcU21JvyHU464YRjmVXPagUKWwnmEdO5zU3n80JwyQvBWsrKUBPnoFKMU5Xdgu79SbfVerHzCMCSa/gokRZhAE4GoQuYUnAeMtgl6mYUaMp7VUkQiZwSaBrWSZigxVNZz0G2Bg8ULWd1QWdaLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBRFDsp7tTQ3ldJRsPpzp7WtZ9hwtW050eQAY3G5hQk=;
 b=ybAP3xO/fV7BRZl3pTjBnjcW7R/tBBXTZtKLkdxErfli4FqO9INoZvEXR4X15Poa2S1OnhxX/YwljPMcgECFEALnovbZjKw3l0jBwl+6vaLQ5sytDfgOBgrMC/VYqbw0f4Xykjcv1jJE2/6Hq+Q6UU0HMizeOI1qCd5u5kGM8GA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6035.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Wed, 27 Aug
 2025 19:49:09 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 19:49:09 +0000
Date: Wed, 27 Aug 2025 20:49:01 +0100
From: Gary Guo <gary@garyguo.net>
To: "Benno Lossin" <lossin@kernel.org>
Cc: "Gary Guo" <gary@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Will Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Tamir Duberstein"
 <tamird@gmail.com>, "Ingo Molnar" <mingo@kernel.org>, "Mitchell Levy"
 <levymitchell0@gmail.com>, "Lyude Paul" <lyude@redhat.com>, "Wedson Almeida
 Filho" <wedsonaf@gmail.com>, "Viresh Kumar" <viresh.kumar@linaro.org>,
 <rust-for-linux@vger.kernel.org>, "Fiona Behrens" <me@kloenk.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] rust: implement `kernel::sync::Refcount`
Message-ID: <20250827204901.75a47868.gary@garyguo.net>
In-Reply-To: <DC0AOTWSN7X8.2ZCPAFGHB9XJ@kernel.org>
References: <20250723233312.3304339-1-gary@kernel.org>
	<20250723233312.3304339-2-gary@kernel.org>
	<DC0AOTWSN7X8.2ZCPAFGHB9XJ@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0038.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::15) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: e508de8a-003f-4cfb-508f-08dde5a2c9d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wVJBxHsCet3g+LC9LvtFq5fnxWg5UGXYn7+SAIOPeKG+qeE/z4wN89pI41SA?=
 =?us-ascii?Q?SO7nNY8nbWJWh5xH4HXLydbK07JvkRgv13Hh6/ds8QH/JyvJkYyhn/gg4mCY?=
 =?us-ascii?Q?18WLrp4hOotVQW2xx2y/BAmrD+iEK9+RTvG1JU7SXPZ1QlmUmh5zlzkMAgMN?=
 =?us-ascii?Q?cAAGVebKmYzJWw6HZ7Zr4gxDl8l8uKrQ1KuCGA2QIrypF+GRstDgjuwB14QV?=
 =?us-ascii?Q?KNYJ+bzeTbrI/+WqrJJ7fxIqUqTXYb7NEXLyT1WPz0/Ws6N4Y6PSzHyGSfSe?=
 =?us-ascii?Q?LgbwjzA2lpp1Zq0pIFYlQGpCBE5R8EjA/xRaqgLLexsnQvEbvyFUBrqS2gES?=
 =?us-ascii?Q?hwW7KftE98OjaY7x4Hxr5TqLSR2C9tsDv88s93BzBNR1pYfXIJcJXh42exSZ?=
 =?us-ascii?Q?UcUGXga8aybe7x/0Bz9Wqh8RZ/J7geVzwyB/8ClBuJZaX5P7p2GU02R0bg7A?=
 =?us-ascii?Q?xtVPueTCH5QiiTuB1JzR2Mvza+RyGybdeHt45xNUqJy3oLtG9BJx6S1yBVlv?=
 =?us-ascii?Q?gbp2UHIEV/evHNhOa5bnjPd6oapBEWhFUmhFx8ADZfqzs3LuK/96ZYQJUeYv?=
 =?us-ascii?Q?WnOwFGYA+tMEqDZiIZX258skq89qan3IkDBKNYEd3PIciUzFOThJux6NvQw0?=
 =?us-ascii?Q?jrjNOVOeiEvtHBKfWRp/kRUObndzJDChlLscLhpfFji7H33VmgG4K/4NYRmu?=
 =?us-ascii?Q?Z/dj/L/lIcYIMs4GIkujWuzMlNhKESivCX+cgHNLZAC4r0NhG4mlz1qki51M?=
 =?us-ascii?Q?jKFCKXAqmxTTVJcjmjYm0pW2DEKUfQY2Smzc8LRHGsoJI0RYU6J4lzR57Duv?=
 =?us-ascii?Q?UvmWTrVhPfJZs3Q5hCr/UXnMP3vlyyvS6WH6ZS3FDF42p7/eNjqfAVbvctmt?=
 =?us-ascii?Q?dHmsYaHjy8a1bMlC09U1RZEqOKyIQWn9OqV/rf2At28+Aqc7P6rrsZv7wleg?=
 =?us-ascii?Q?FhPXcnZj6Y8sTh3PX4HtjblUCrfjvDYnG96oUydTJVMF1trpF2MNJ4MdNalu?=
 =?us-ascii?Q?ZvBaN/OUp41/cu6XxVxVbNOCxEjEj8HMGevPQZjaCLYdy496eiC3J/Uzk3s0?=
 =?us-ascii?Q?WWGg4nE0d+S76w8pR2D/VIytS5Tu5lVUNDwe6TAGpznhPhqC/fmNS2Wc7Vmq?=
 =?us-ascii?Q?MITsSNyvyz82s1IcIDTsjISyBZXLr0X5aU368Xe219gzGDAbbPDI3VLJX7mW?=
 =?us-ascii?Q?xPXGA18BMLRSat1o1ToNjY4Vk0/8tqgLQgmvCCTNIFmNvWMkeb6G6a6qFGwD?=
 =?us-ascii?Q?QmjdYY1/FjvXB42ajVbitxbAfXSD4t4TYXOEeEDxTlU/YeJgQ63quWBNgeAs?=
 =?us-ascii?Q?YHeFCJYqzAJzQZb0z1a2XbCXEW8OxfUajOB8v5iN48lfsAtz7rBks1lYlbGb?=
 =?us-ascii?Q?gp9d6muBYBKdm5ditwB3RiLb1B9PSlW2j5dStH2wIlw5E02YVnMPgbUqacB9?=
 =?us-ascii?Q?1LFQRA18kVU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I9IElDUDLpaxAC6JN6TyVTWO48Un7P0Ton8W1/zGNA9PwLB1b3BG107ys2lR?=
 =?us-ascii?Q?esJjE/l6n8sGpyMofeR7MI7KM8XFqMBD1bFgtwphtZxTWwTpaz3VbUKSvQGg?=
 =?us-ascii?Q?WWCQu8N6Y9+wGXnoPnHTCiGvfNlogleBaVuxKUp6U9L/XD1Okz5iVUxuZWqG?=
 =?us-ascii?Q?+6ATa9rk2vWElQEaHNzLP0AoxhdpsUHVllJhE2V4Y8O3XiQyAXXXYgQSufEb?=
 =?us-ascii?Q?GoXK6fU2EKhSyWaUme6d7HALORtjDrH+k1n+rmtIVb4+L10IQEMBUTmlBREh?=
 =?us-ascii?Q?Q3O3XZ4tMN7IBTDcnZZgwSkF/Ejq75WCGsZ2jQAn/jldt9AZ/Ezc6lCkNbC+?=
 =?us-ascii?Q?FGzejaf8kSyoPVQXb25G7PQg5XXJz7pLoe5D5GViV+A+gQtPuN79mBEbuZKI?=
 =?us-ascii?Q?fVFvRkfRJS4M6Z4ktTyVd3C+sXlsAb/hfr1TzDSzKBH2v2AleoZ5n6cB1iNX?=
 =?us-ascii?Q?+N0oAh5zAS626MqmFQ6SP9y+CRCHpKCnw65vRryu/Ww5m6sF+/48c4/fnPOz?=
 =?us-ascii?Q?Ae6j915eDuC+wNfKvSjWCHJ3IjifassFo8vhT7cSCJAbgbh1EzZkoJhcURYH?=
 =?us-ascii?Q?AIQKhB8j2vIdkCpWLF8biREacQIhJ6RWLKWE54isSRZqfWlUpYcv5MdbjWuh?=
 =?us-ascii?Q?CNc/twS7VeCfeUFZUIEQhoFKZo5PPaaFRCLwrEDGZNIttXmci9qGkXJ8eUBT?=
 =?us-ascii?Q?I8pxMmxBmn/+qL/s8f1+ydBGY/ShRttfaOhIx7cnmadGJkFykx6yCplbIOTP?=
 =?us-ascii?Q?LJUlNJvBShN90m5QuCJ5ymUSWxHeFTjKXEAQrvMDF06SnF0Kj6FPzvbF7yhD?=
 =?us-ascii?Q?rX6bz9Y2f9QS31+SNCihiY30oNNXpWp8zXh1FaP1Ocj/ePjvuD74buyuyCl7?=
 =?us-ascii?Q?FbeL6ZOucaAJ3fsTLziwSx7OUvXP5bjhL1lVPZqtj4psvvwjEJz06ITlIL7U?=
 =?us-ascii?Q?rA1w5yypFNVV9ns4AyGQ0zKQI3FdbLjAcajzwPZPBW58C/Yn/AvY3Ai7aLAC?=
 =?us-ascii?Q?cUsbsXZzOsNtyLcIOYrDSQIRSQrlw8Yjln06SGqaywcwib71eBMfCPa3YI+R?=
 =?us-ascii?Q?ERgSqXuItKAdIE05nI4RHba19LwiCCRb3CMrJhhiwSGQ3midm7oXQyR+QfP7?=
 =?us-ascii?Q?MF87DHRut3LyhL1HvlQkTLAZsY9gRv+H0NHn6E2n8U9tx1Enw9YlWqOaxrnk?=
 =?us-ascii?Q?XnWrNJzgVuRjPLN9CVpmvOmYifnZ7JBi8g3pe/4RQlM4E7mljJkdsax7AtYe?=
 =?us-ascii?Q?mQtPZw7/BBwicnkaRooj5JGTz8i+TLfLkLRqY3K5MVxpnKKriI20cZWTie7M?=
 =?us-ascii?Q?0o2SJ+NAhZjxPU1lEdnrtJry5eTDJ2MwycJUcDnfjt+Qc00ug2iizqCpxM4H?=
 =?us-ascii?Q?c+SrMsiyrkxfLiOgxqZG86Kwh8uifYiHYfmBZkrHk/SzkpiXsKcfXcX4T7Yj?=
 =?us-ascii?Q?kR3wdel1GeBF5fQUPRAOPrbcUL4ai+kFNSbdtSRjkbj6rqr0lRA2rK0NZxNJ?=
 =?us-ascii?Q?8RVAENOU7a2Ge75oErtZz3lPSNIJ7K6QdYaVwXSQafbni4EZXZXN+DKwNB2d?=
 =?us-ascii?Q?aI0Wy/RlPJfL80d0eIZd8veaHzeamYRgKRsNB1yqcF7Xko6JqM/feplCSVkP?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e508de8a-003f-4cfb-508f-08dde5a2c9d8
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 19:49:09.1959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8sMeMvKAMvcnHmUNL94B+vldjs6rTQhCGYP0gY9BlstZs3/sQZuaOZ7QqbAbFJTXHT4Sl0uMAdD89VPX0AWNmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6035

On Tue, 12 Aug 2025 10:10:08 +0200
"Benno Lossin" <lossin@kernel.org> wrote:

> On Thu Jul 24, 2025 at 1:32 AM CEST, Gary Guo wrote:
> > From: Gary Guo <gary@garyguo.net>
> >
> > This is a wrapping layer of `include/linux/refcount.h`. Currently the
> > kernel refcount has already been used in `Arc`, however it calls into
> > FFI directly.
> >
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > Reviewed-by: Fiona Behrens <me@kloenk.dev>
> > Signed-off-by: Gary Guo <gary@garyguo.net>  
> 
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> 
> > ---
> >  rust/helpers/refcount.c      | 10 ++++
> >  rust/kernel/sync.rs          |  2 +
> >  rust/kernel/sync/refcount.rs | 98 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 110 insertions(+)
> >  create mode 100644 rust/kernel/sync/refcount.rs  
> 
> > +    #[inline]
> > +    fn as_ptr(&self) -> *mut bindings::refcount_t {  
> 
> I think we should make this `pub(crate)` from the get-go.

I think it's probably fine as is. I think this method won't be useful
outside this module unless people add a `from_ptr` later. But I'm also
fine changing this.

Best,
Gary

> 
> > +        self.0.get()
> > +    }
> > +  
> 
> > +    /// Decrement a refcount and test if it is 0.
> > +    ///
> > +    /// It will `WARN` on underflow and fail to decrement when saturated.
> > +    ///
> > +    /// Provides release memory ordering, such that prior loads and stores are done
> > +    /// before, and provides an acquire ordering on success such that memory deallocation
> > +    /// must come after.
> > +    ///
> > +    /// Returns true if the resulting refcount is 0, false otherwise.
> > +    ///
> > +    /// # Notes
> > +    ///
> > +    /// A common pattern of using `Refcount` is to free memory when the reference count reaches
> > +    /// zero. This means that the reference to `Refcount` could become invalid after calling this
> > +    /// function. This is fine as long as the reference to `Refcount` is no longer used when this
> > +    /// function returns `false`. It is not necessary to use raw pointers in this scenario, see
> > +    /// https://github.com/rust-lang/rust/issues/55005.  
> 
> Missing `<>` around link.
> 
> ---
> Cheers,
> Benno


