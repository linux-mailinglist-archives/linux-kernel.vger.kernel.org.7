Return-Path: <linux-kernel+bounces-828994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C987B96013
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8C518A3500
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0D132779A;
	Tue, 23 Sep 2025 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="iU6lirxa"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC72F324B0E;
	Tue, 23 Sep 2025 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758633916; cv=pass; b=M7my4qDBRmclq110k2eMYAzk8uxrSCtdtq+kjo9q0YSSMlNAVCZMiDEeoncmnchJm4jpKRMYCI9sqfzFslbCAuWYNea9Z10oOwmQPBNQswgOvsUssnxdWpjmZVXmsQewinRfUgvpxKSPMCqeuvDL33NB84DM+wizRZDU6cje7Cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758633916; c=relaxed/simple;
	bh=uxK21olE8I0kkzRCqSIRF1sDogYFA1KCs4N+9Lo086w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bIWKBDGLQwaqIgOu5l1B5ZARJa/Puet2cMFNqbyhZsPdUdjGirbBmsUtZqbSPt38ra0cIlY1F/Xdi8MM4yh5L5s/LB6oMr5+7+IGAbm5JzoDoUESqaRF3ybETZf3H0ebVGLwXxcuyMUswnin6TT/rj6tEm44AruTPjNzQJhjlSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=iU6lirxa; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758633897; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lMe8QmUk0N20jVA7g/B6KCUpUhtq7Gh11DVUEdez+IoVst/E3bT6CqOchHTmOQ8HBzdm7bVOVgHLK/u23W3QwY6K9a9RivCpKRgEv8BIsHovf6x7H6SY/yZkxK0ZSP6yl0r8pU/p2nFh97FPreO6sxVaPbiJnHSfE+igOI84ink=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758633897; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uxK21olE8I0kkzRCqSIRF1sDogYFA1KCs4N+9Lo086w=; 
	b=ZOd7Zek9xo+flokSqPmS7JOpcJNob12lgpulNklBvHMWFZRyNA9o931I+k6wrwcv/DRhD+Lz4GVR7MpOTuMSSs8rqP62gtRWAOqr+rHN6Z2SancWJBqQiLGecJ6aQdqX580LlGwiy9pa15RMOplfVqatcY1l4NumIPSniUSuW7c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758633897;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=uxK21olE8I0kkzRCqSIRF1sDogYFA1KCs4N+9Lo086w=;
	b=iU6lirxaoyUAeuPBEgEX/cGTsVbKR0uJXTjPl5GZrdGNekCrIIbwbv7+uHQmtMZD
	T0HQqtghvU+J+L6hHhDI5/CZ4ce2RLfh5cmlt7JRbxtZtlMEn9GClChMgJYzPxDe9X5
	CpAOwHgGmn6qA5vGpSnHciPJPUKmRNOlzWd5hYos=
Received: by mx.zohomail.com with SMTPS id 1758633895698414.7325397327801;
	Tue, 23 Sep 2025 06:24:55 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 0/2] rust: usb: add initial USB abstractions
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CANiq72k4VG4UMDJUUfD=LNM+tJmvceNDxG=A-+6GDjLzCVXurw@mail.gmail.com>
Date: Tue, 23 Sep 2025 15:24:41 +0200
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-usb@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F14B2B5C-C361-4670-88C0-61A1EC97E630@collabora.com>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <2025092338-elbow-dash-373d@gregkh>
 <CANiq72k4VG4UMDJUUfD=LNM+tJmvceNDxG=A-+6GDjLzCVXurw@mail.gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Miguel,

> On 23 Sep 2025, at 14:56, Miguel Ojeda =
<miguel.ojeda.sandonis@gmail.com> wrote:
>=20
> On Tue, Sep 23, 2025 at 2:05=E2=80=AFPM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>=20
>> I tried to apply these
>=20
> By the way, a `MAINTAINERS` entry is needed, according to the log.
>=20
> Cheers,
> Miguel
>=20

Yeah, I did not add that on purpose. What=E2=80=99s the preferred =
approach here? I
wonder if we can add the Rust files to the USB SUBSYSTEM entry? I can =
maintain
the sample driver under a separate entry, for example.

I=E2=80=99m open to any other arrangements.

=E2=80=94 Daniel



