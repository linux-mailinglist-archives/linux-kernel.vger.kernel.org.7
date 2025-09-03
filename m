Return-Path: <linux-kernel+bounces-798615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A966DB42062
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ADE06841E9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D122D3009E0;
	Wed,  3 Sep 2025 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="alecCDLZ"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8851A9FAF;
	Wed,  3 Sep 2025 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904699; cv=pass; b=ABaxf0yRShINU6+MSp03mPaQx5D9xBF2LeCTxlPV8xkCJMyAjCAv2E3RGp4en1tWJJ1IN8zPikCYRVkh5fhPOEGO8/9HnB0h9QJUSs/AX3NCT5DIzBVxf1+m/0SRhEahIGmrqX3eH6g6SYZm0RIYn1T7MEbk7lllDjk8tlaHj9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904699; c=relaxed/simple;
	bh=uiG9JxljEs1kyatFPvHD+V2jKizKib16PFXgVXUfJq8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VQ9TvPkfv/FzX8GSZuMAp2qGW4argId1u2n/fkaBUuG36vKiSPn8PDIMn1PlyXfMRw3EitSEwVltdDfWFZ2qHv1Dmjb5s/c9FcsGJ62E/76+kUQebYgpsjkY4Rl9+Js4t0MYQpmvle8hw/STs/URxh3Miuzr41UyoaVDF0TwnT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=alecCDLZ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756904660; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NwZegBwOb9r0i0ScPYhQeFi74NajYLGElLGyWyfRVpZuT2S/rHMQI3TR6H/MrhL9wVKRIDawS1bzJ5vbrHVzPT3MmsDjtEBEDrdm7/kPXTVLHe+EgTCJ/eRuXofbLl/yiycKc8RJly++agWdXk20vdIYO98ZibOuRBbkK45yzz4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756904660; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uiG9JxljEs1kyatFPvHD+V2jKizKib16PFXgVXUfJq8=; 
	b=l0Vhm7eCDrWV5hrXnWvLMsr08RJDJagjnsHd+qZ/Q26La6yThcRmdOQIFPHcbJsYZCrZMUc7OJ9dbjxjd+LlGyhtbDYFe81eFmWL8L0fZqhLf642rGk3QyOkgdwVaJjHnekVPMhVZ/JABwOQrWtRhxpOGhyDB6RMzI4YzLZafDk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756904660;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=uiG9JxljEs1kyatFPvHD+V2jKizKib16PFXgVXUfJq8=;
	b=alecCDLZa9tvD9O6WLvqsaqpXjZsnTnwGNf2BYZNCUivqhQZcZOwJ0mqRMYS7L1P
	NCSYXnaqrPZ2s/WEC3HLBpJSkHTsTzArXxn+ZC5Ejvs+xGbQZF2qjcQP7oXwMeqsEIl
	RElNDWSqeJlfT5H7Ni+dw79Q9gdzqcG+UlL47Q7Q=
Received: by mx.zohomail.com with SMTPS id 1756904659009698.6031413704457;
	Wed, 3 Sep 2025 06:04:19 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v5 0/3] rust: add `ww_mutex` support
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250903092422.37b29315@nimda.home>
Date: Wed, 3 Sep 2025 10:04:03 -0300
Cc: Benno Lossin <lossin@kernel.org>,
 Lyude Paul <lyude@redhat.com>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 a.hindborg@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 dakr@kernel.org,
 peterz@infradead.org,
 mingo@redhat.com,
 will@kernel.org,
 longman@redhat.com,
 felipe_life@live.com,
 daniel@sedlak.dev,
 bjorn3_gh@protonmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E0F8BE39-E2DE-450B-B915-59AEE3C7B10A@collabora.com>
References: <20250621184454.8354-1-work@onurozkan.dev>
 <20250724165351.509cff53@nimda.home>
 <ec32fc5f5a8658c084f96540bd41f5462fa5c182.camel@gmail.com>
 <20250806085702.5bf600a3@nimda.home>
 <539d3e0da773c32a42b4ab5c9d4aa90383481ff6.camel@redhat.com>
 <DBVLEGFYBWKE.2RW8J853CJHTY@kernel.org> <20250814141302.1eabda12@nimda.home>
 <76D4D052-79B6-4D3F-AAA1-164FF7A41284@collabora.com>
 <20250814185622.468aad30@nimda.home>
 <182E916F-3B59-4721-B415-81C3CF175DA7@collabora.com>
 <20250902195328.6293b5d4@nimda.home> <20250903092422.37b29315@nimda.home>
To: Onur <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Onur,

>=20
> There will be some changes to this API, I found some design issues on
> it. Previously, lock_all was an individual function, I will
> move it under `impl ExecContext` so that we can track more mutexes.
>=20
> I will send v6 in a day or two. To avoid confusion, please ignore the
> previous mail and review v6 directly since there will be some
> differences.
>=20
> Thanks,
> Onur
>=20

That=E2=80=99s fine. I liked it that you=E2=80=99ve included tests by =
the way.

=E2=80=94 Daniel=

