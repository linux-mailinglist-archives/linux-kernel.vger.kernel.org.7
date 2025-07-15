Return-Path: <linux-kernel+bounces-732503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC28B067BA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16105648C9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0802BE63B;
	Tue, 15 Jul 2025 20:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+VCbrIm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE3A2727EC;
	Tue, 15 Jul 2025 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752611400; cv=none; b=qAPN8/h9e7rejnAZjwPDavGdEbkRLmws1bUeK+FFn9sTvevLWwzrFmzJScLxqQ9rbNXuN2NROZ5xtlWdD/yC0Jff3klNwzrL1zf5KdTSCx708Jw5BJZG9uDs1kyDh/fa4p2OHjASJlArCa6FFeS3o4bdNf7300qXlvjV6WNA4Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752611400; c=relaxed/simple;
	bh=s1AZC3mbmHb2undumjXjWb3GFUaGZlxyaMwiYR1evAo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=O3MxynR1sQRLAt57XtSGOvyQW8lO/IqR1DO0G33HpBQlKLc2yOhv8N56gX3ntPpE0ZLWDOXXamqGLozwZOROn6I7QweQEVxFlY3+uAAqWFighbaVWPoxL5LaxelG0pB83qDBANrBOiMUzDCSqbfPmWSV4Q55WVjcT/FYfdn1yKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+VCbrIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9E4C4CEE3;
	Tue, 15 Jul 2025 20:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752611400;
	bh=s1AZC3mbmHb2undumjXjWb3GFUaGZlxyaMwiYR1evAo=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=e+VCbrIm8yAUY2nPpU0XmHKeewyFoIxrPMpkoi39p2KmvqZbyOmYKgD3ul4LKoqKF
	 nBBH27Sjc8um1CWrjVbwGYfmWRuxeRmuY0mmyapVCD2yjVDPSK9V1xSMosc5jjNPUB
	 88n3tzuRafkUqc0eiX2j/9ZF1fNv5iaLe7E6mO98TVp0POc+sDz7aqrcgvyFr6LviF
	 3m8CXPtJsWrOHdIA0TVM3USnXL2jYIfzqg3Z3hW6mY7qaeaQhjcurXxhnpSNrKgiSX
	 7XQgDx8ElW2VhS5MLqc9t12hTuzNbCHaFBlLNg6S6kDs2Ljimm5id7E33IXo8yohDx
	 YZyHaqdNBrWKg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 22:29:48 +0200
Message-Id: <DBCWVWUNRR05.37YH3UZW1R0PW@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/2] rust: devres: provide an accessor for the device
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <daniel.almeida@collabora.com>, <m.wilczynski@samsung.com>
References: <20250713182737.64448-1-dakr@kernel.org>
In-Reply-To: <20250713182737.64448-1-dakr@kernel.org>

On Sun Jul 13, 2025 at 8:26 PM CEST, Danilo Krummrich wrote:
> Provide an accessor for the Device a Devres instance has been created
> with.
>
> For instance, this is useful when registrations want to provide a
> &Device<Bound> for a scope that is protected by Devres.
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Applied to driver-core-testing, thanks!

