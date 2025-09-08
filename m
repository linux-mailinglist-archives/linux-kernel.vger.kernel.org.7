Return-Path: <linux-kernel+bounces-806733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5608B49B19
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0C61BC22C4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9941B2DAFC0;
	Mon,  8 Sep 2025 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8rxwp5l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24DDDDC5;
	Mon,  8 Sep 2025 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757363493; cv=none; b=OAvdBP14b2ZLa+aRRAdyiMaHyMwbhYmYHLKVi3Mm1NuZx9DGgNqhx6Jnzn3unPjsDs8TLzKQu1IpOzhXCbLp+qt5hCMWilYWaK/Czf8yDFp+DFmzDDxJ6XWfFkBXDi9VMCXgLf1qlEv9Zw16wOi99iIRhpW4NKIs+GDEf9DwOvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757363493; c=relaxed/simple;
	bh=hrtCs+d2E1+ZtnFDpaH9ke47jZDkqnapPnBMnSJIioQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VceaedE3xnhcMuPXESSrQ7F28BNjKfUT9K4tmqr6XNTj2+K2JrIzq9p2gx4RR2SBecSwIMgaT2y9WouaHUYyTRLXNRZW0ANj4I1pGxbV0qfUBhc0+jMEpvkqzi7Pwt5pBW20LWhkxdVg4UYI43qvN+X5h06SgNE826AjSX5hTDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8rxwp5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4D4C4CEF1;
	Mon,  8 Sep 2025 20:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757363492;
	bh=hrtCs+d2E1+ZtnFDpaH9ke47jZDkqnapPnBMnSJIioQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q8rxwp5lJ0twMck5PyS94wmZvQp59gqTUcZ7yaRCgq4IsyOVd/hgx2u+BsSlypVDE
	 amqBhH6VMmtgh+tQysoF7sTrbwSqB1nSg51f7dKGPK8TPvIBAWgRQARscbrrX2gRpM
	 1TK32E8QtP9rmwFAOo9zdF9e4kfOwQHJRwQ9OQXLwWrGvbHE8Ue5DzWhVRDwVe8CRq
	 P+41GrXPRIpekV6lzacVwx5auLwOY9myUOD4Vd2RMpkS+/3NiDo//3FdwIN5KhFa+u
	 hrHP2B7lLhkMmsKCBtX+h7x4EDpIdCmy1inoree2jGCUG16M4nu2vU03LKrsJWby6n
	 x7hZsC+CX9E0A==
Message-ID: <fa398b6c-8336-4c4e-b4ce-5ab37d944190@kernel.org>
Date: Mon, 8 Sep 2025 22:31:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: pin-init: add references to previously initialized
 fields
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Fiona Behrens <me@kloenk.dev>,
 Alban Kurti <kurti@invicto.ai>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C2=B4nski?=
 <kwilczynski@kernel.org>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <aLzoyWpOr6eg-3yB@tardis-2.local>
 <DCMFN8UGD7QN.27HTYEXL87Z8@kernel.org>
 <DCMQVH09L1Y5.3A842FC1NGG5H@kernel.org>
 <DCMVHB8P7Z2G.PCOWPQXBSBT6@kernel.org>
 <DCMW6H0VJ9AP.1XWI1RI9YWO9H@kernel.org>
 <DCMXPGXDXHYT.D9VJ5QBMAVPN@kernel.org>
 <DCMYLXICOGM7.2G4JBQAE7805B@kernel.org> <aL46nRkYj2SlOhl8@tardis-2.local>
 <DCN9YYV750Q4.3K9X2EAA3RKJ8@kernel.org>
 <DCNALVTE4DIN.1K0U4BGN35CHI@kernel.org> <aL8wnJcro6uXiD74@tardis-2.local>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <aL8wnJcro6uXiD74@tardis-2.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/25 9:38 PM, Boqun Feng wrote:
> On Mon, Sep 08, 2025 at 10:57:36AM +0200, Danilo Krummrich wrote:
>> So, I think it should one clear instruction, i.e. #[bind], #[access], #[ref],
>> #[use], #[let], etc.
> 
> In that sense I think `#[let]` is best? Because it indicates this field
> initialization works as a `let`-statement (in term of creating a new
> binding), of course I don't have strong ojections against other options.
Same for me, I'm fine with any of this kind. :)

