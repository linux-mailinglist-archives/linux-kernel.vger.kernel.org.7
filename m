Return-Path: <linux-kernel+bounces-787052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B25B370D0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042811BA2035
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08022E3361;
	Tue, 26 Aug 2025 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="EaynqJiN"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995602E1F04;
	Tue, 26 Aug 2025 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227638; cv=pass; b=j49sE+Q66m3TCGrZwa9aJM0LyUKChtDcXRZjZR7DWY8RDNl5r7rSfyw0q9YJQb9EmaBDPoxKDwX7Esd+IB04AmO36WwljtG+IS4Uw/TGPQHQg9NFvQ512UVBgS3Hi1tVCA2uxihFwXEU6lPYzlU6Hz6R8xpq8IN3/T49aMnSMKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227638; c=relaxed/simple;
	bh=TIjhL3/glWuWkmNxgtVTJrNVg8H0+2TwA+mzFnGvXEM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=S2C5DozqqmcPrXwBBGB87DMtDiHDWce/68Aq2nCz5+e3QYrAjNKmBmPxFnnrHnu5Hq0FefdlGLjG4/iR4QL/xsER5aiRLnM1sr9qteZ891P4z4b3OHlrubwCqvb5CpaGH6WAzV1+M9Oz8JrQQyymRaMzc7lUubHn4A84zrfz/sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=EaynqJiN; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756227605; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GU+wWCA06Ef0XAbyP8Qi2VkUWgOfhkU/ED3asqzVhn46EVNT3M/1QsK9nHR2mS/O8s5l0QJKKZuZ6U1Z5Kf9KrEKd54SkBjh+xDsY5mPFKSYWUWJWWLYig/blPlZ79px4YP/jn2zGSfhiAIRQ3kwGKktlZvn0I5Xzy5oHe5z3zs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756227605; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8kaOWCQOS7mBDgpB8EtQMMvOlmhHeTGUBybC70QWiIU=; 
	b=dKrJT1Nsl/dfcp/epgAChL4Xf78pm8U1u1GrYkWUkQokhl1IhZB7UQw8mpH/qic43f1hUxGsaZgpVU1WExVllWxO70Uob4zgfO6SiX0ayHgytYC9we+pg6ZylEFrGylC/Wfyn9iyJyu1DlVCTm8lx3bp2ZeTFwO10SviNUFpmVw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756227605;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=8kaOWCQOS7mBDgpB8EtQMMvOlmhHeTGUBybC70QWiIU=;
	b=EaynqJiNEQOxh4k0NKESxZmDo1+dztGMraiiXBH2LlfPlmx2ZuGtDKFBzamCN5iq
	MUZMCdU3LmmjL4IEaalQv8gztvhRN7xSut1w4wIqZ22u5YwG6EyZS3XaoMQ+ZLSLCH/
	/ibO/88AnTpyM4nueIl0hAraRU2yjCidSz6fDJH8=
Received: by mx.zohomail.com with SMTPS id 1756227603732130.95087999284272;
	Tue, 26 Aug 2025 10:00:03 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v1 2/2] rust: Add read_poll_timeout_atomic function
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DCCF63BESWQ9.9LC8MZK7NG1Y@kernel.org>
Date: Tue, 26 Aug 2025 13:59:46 -0300
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
 a.hindborg@kernel.org,
 alex.gaynor@gmail.com,
 ojeda@kernel.org,
 aliceryhl@google.com,
 anna-maria@linutronix.de,
 bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com,
 frederic@kernel.org,
 gary@garyguo.net,
 jstultz@google.com,
 linux-kernel@vger.kernel.org,
 lossin@kernel.org,
 lyude@redhat.com,
 rust-for-linux@vger.kernel.org,
 sboyd@kernel.org,
 tglx@linutronix.de,
 tmgross@umich.edu,
 acourbot@nvidia.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <33725E09-3994-4306-AD4F-4A0253261DE1@collabora.com>
References: <20250821035710.3692455-1-fujita.tomonori@gmail.com>
 <20250821035710.3692455-3-fujita.tomonori@gmail.com>
 <DCCF63BESWQ9.9LC8MZK7NG1Y@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 26 Aug 2025, at 11:12, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Thu Aug 21, 2025 at 5:57 AM CEST, FUJITA Tomonori wrote:
>> +pub fn read_poll_timeout_atomic<Op, Cond, T>(
>> +    mut op: Op,
>> +    mut cond: Cond,
>> +    delay_delta: Delta,
>> +    timeout_delta: Delta,
>> +) -> Result<T>
>> +where
>> +    Op: FnMut() -> Result<T>,
>> +    Cond: FnMut(&T) -> bool,
>> +{
>> +    let mut left_ns =3D timeout_delta.as_nanos();
>> +    let delay_ns =3D delay_delta.as_nanos();
>> +
>> +    loop {
>> +        let val =3D op()?;
>> +        if cond(&val) {
>> +            // Unlike the C version, we immediately return.
>> +            // We know the condition is met so we don't need to =
check again.
>> +            return Ok(val);
>> +        }
>> +
>> +        if left_ns < 0 {
>> +            // Unlike the C version, we immediately return.
>> +            // We have just called `op()` so we don't need to call =
it again.
>> +            return Err(ETIMEDOUT);
>> +        }
>> +
>> +        if !delay_delta.is_zero() {
>> +            udelay(delay_delta);
>> +            left_ns -=3D delay_ns;
>> +        }
>> +
>> +        cpu_relax();
>> +        left_ns -=3D 1;
>=20
> How do we know that each iteration costs 1ns? To make it even more =
obvious, we
> don't control the implementation of cond(). Shouldn't we use ktime for =
this?

I don=E2=80=99t think ktime can be used from an atomic context?

=E2=80=94 Daniel




