Return-Path: <linux-kernel+bounces-767718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F0CB25806
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 02:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155173AF0E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E288134AC;
	Thu, 14 Aug 2025 00:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyC357Fm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F021315A8;
	Thu, 14 Aug 2025 00:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755129772; cv=none; b=CbJQXkwXORYRNtAt9vN8RlUTEpE9yiSIuZkCY9lA9ixq7Liv84Zy+Ho2/rYRIojiE7KxZKRL0AK52DSG6A/8Z3v6ABuvRrOKIYKWg84vY4NyqnD1q8NfSa5iivXz7F+LkWlPwy00DHgK9Z4uCFgagIgc/mJhGCF3m+gME9JGYSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755129772; c=relaxed/simple;
	bh=pCkLqHJVxHIBrRg8IlFTsiErFNyOyReLeRZ6vWWKD4I=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=d7NPR4+OE8ibDkoCDrhAO2eFxm5m/uu8dw76+uA6glmkzHfxUi6V8unmGdrk5szYyChSre0jT3JQx71cZ67HomZS3zsLc6DBONBjl6gfL4KIIeKb8uA4pg7w2+ZMIwOFEHec9/9krk3jyavoWf7cCn9aYcHYC95Qc271Ei+CpvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyC357Fm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45F2C4CEEB;
	Thu, 14 Aug 2025 00:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755129771;
	bh=pCkLqHJVxHIBrRg8IlFTsiErFNyOyReLeRZ6vWWKD4I=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=kyC357FmR0TTltplZk1k6UAu4GhqHHtsX6n7LPo1VTykWNptk4PmoMO+j6qlfRCB1
	 xm9i5xg8DYPxjN4PvRSKcDFnL9u4jYzYAfRDa7hjBQtXp+nESccR6wKX9dbBlHGpR6
	 +snd0C1LEkLePNgZZjLsFfLXSBTcmv23ISn80Pl5CW6p4RJFvJg6FWNfTA5uGV2NUp
	 hfzeKdYs3e/mfrN6jXekJV+LtC9lJueyAMOzAhUF22Org8WfZX5r3V7g6Rz8rAAQmV
	 Rd3vhuuq16cCVzBTsTuSqYmyi5bdX7Pk7tHhC0eUQwqd9LH1i2sJtG+623FliaW0/z
	 ZsBkdc9bOzIMg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Aug 2025 02:02:46 +0200
Message-Id: <DC1PKRVW2XCS.1ZD5TWL9Q87HZ@kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2] rust: devres: fix leaking call to devm_add_action()
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250812130928.11075-1-dakr@kernel.org>
In-Reply-To: <20250812130928.11075-1-dakr@kernel.org>

On Tue Aug 12, 2025 at 3:09 PM CEST, Danilo Krummrich wrote:
> When the data argument of Devres::new() is Err(), we leak the preceding
> call to devm_add_action().
>
> In order to fix this, call devm_add_action() in a unit type initializer i=
n
> try_pin_init!() after the initializers of all other fields.
>
> Fixes: f5d3ef25d238 ("rust: devres: get rid of Devres' inner Arc")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Applied to driver-core-linus, thanks!

