Return-Path: <linux-kernel+bounces-884793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B049EC31286
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EADEE18C0F08
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D731315D5E;
	Tue,  4 Nov 2025 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZfhvFAu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AED3164AF;
	Tue,  4 Nov 2025 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762261795; cv=none; b=Q6mwrRPXN8o+6Ks55DBxayVaSQpBKTJ/+iBQW9NhCis5tynPi3gqNfxBWe4+XQCGqDV1RT/OF4PmuINAYkPmbt8cBcMArQlxSrbi41CaKjG4antrVa4rRL51cvImYSxD9BoNK8/Ykxk4pc8SE0TdN+MLj1Fdk/cgGS0blZ7Qshg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762261795; c=relaxed/simple;
	bh=Pqh89lUQZhJ8CsY/0xEaVx+K9g/ynb2A8QtBWjoHrnk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=pq1gfGTddP6hD3ehT6PGciKY5m4HaGZhp9W5cP3MDHu2zv6ZLc20BwyhG/UnmNY7O1SPo79fViRk7Uaw5basBVFoE69GH51I/IB6r2c1jXC/PQt/UG1yZA0pWhFmydHN1oCUMr/BK8xcIJlIQXfq+olX+oYujPK0yC/UxybVdqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZfhvFAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F6CC2BC9E;
	Tue,  4 Nov 2025 13:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762261795;
	bh=Pqh89lUQZhJ8CsY/0xEaVx+K9g/ynb2A8QtBWjoHrnk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=VZfhvFAuduDx6Ibe/wwDd+NE4buQo/HLV7dI7Xcb5YhqYPkkPTsdDeuh3t2QlT0XT
	 xfunzgkf4KvEYVDrRza4rJXRRR2iEGXDhiy9RPyngeIaZDLtka36Rvl8vSfMy6ny/j
	 2rghPVRrL5XXJ0ikNf5pWcAbrSErxmCpIttZOXh0mLW0HY6wkM2ZIGJ9mpV2XSeeL3
	 XjwlGo7eZpEQZfBFqKPM5c3pfBS2eTNjW1+ArvwehJWuJ2Zio/tXw/xRTiGENIOj+O
	 T03VWkw5zZsCjYSMYyaom8MR5slqXyVYTj5br3gJvQLu0oivpwY7bcrAnSkgFL2zfz
	 xIaz0iCZFijfQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Nov 2025 14:09:49 +0100
Message-Id: <DDZXO1Q8X0VJ.2CTDX2SFTY3FR@kernel.org>
Subject: Re: [PATCH v4 0/2] Add read_poll_timeout_atomic support
Cc: <a.hindborg@kernel.org>, <alex.gaynor@gmail.com>,
 <aliceryhl@google.com>, <daniel.almeida@collabora.com>, <ojeda@kernel.org>,
 <anna-maria@linutronix.de>, <bjorn3_gh@protonmail.com>,
 <boqun.feng@gmail.com>, <frederic@kernel.org>, <gary@garyguo.net>,
 <jstultz@google.com>, <linux-kernel@vger.kernel.org>, <lossin@kernel.org>,
 <lyude@redhat.com>, <rust-for-linux@vger.kernel.org>, <sboyd@kernel.org>,
 <tglx@linutronix.de>, <tmgross@umich.edu>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251103112958.2961517-1-fujita.tomonori@gmail.com>
In-Reply-To: <20251103112958.2961517-1-fujita.tomonori@gmail.com>

On Mon Nov 3, 2025 at 12:29 PM CET, FUJITA Tomonori wrote:

Applied to driver-core-testing, thanks!

> FUJITA Tomonori (2):
>   rust: add udelay() function
>   rust: Add read_poll_timeout_atomic function

    [ Adjust imports to use "kernel vertical" style. - Danilo ]

