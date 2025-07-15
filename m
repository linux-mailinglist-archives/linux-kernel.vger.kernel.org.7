Return-Path: <linux-kernel+bounces-731465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07045B054C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B233B7B640D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C34527602D;
	Tue, 15 Jul 2025 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCSTFOay"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2D225F973;
	Tue, 15 Jul 2025 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567776; cv=none; b=BTXI8uJKUrqHWUpMnVa1IsdqoB+51zHD9KGVidbESEi++9jUiCY1Tuzi7fwUn7ud7A6K2BIdukow3D5IGq5bqTEzDvgRhKJCNHTqzKOkBwGulyh9O7KTnpfTuEhmcuaSAS2cDtZskG5SP5UlWy20zDrZAr2jwQIAM5Z3G5k+VDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567776; c=relaxed/simple;
	bh=e+GveHWQsznhWVSVvbglpHmf7i2wCktpNbLp6nwd69E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=RQRdpBXI/MgQIYTgn5/gS0fbaaKTmQopUVa4SboyhpCySKaSIiwHq+XxiNx41CwB2oLx1rgPGhKUbpHdQweIs0aYDMn0t1aY05vtVxZ8QfSvSgVckvmW9pJHz/DrMizLc3EODiO2uPE8t0YNtD1rP4qaLP8DV1koFDjJSGyU9/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCSTFOay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B272C4CEF6;
	Tue, 15 Jul 2025 08:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752567776;
	bh=e+GveHWQsznhWVSVvbglpHmf7i2wCktpNbLp6nwd69E=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=uCSTFOayI1PlYUOW/L/A7im4447V053jBVrUql8+jedyJUZ9yIWB31OCH6UR7MDyl
	 mJcl+M+lD1aVOyxY2jTm+gqM3R0ie1h7Pz5MnEWVVTh4g0qehh4HxmDNIgKdzawyJ2
	 gsMDtZ3Stl0zrm4utvXVJFoUt0nvXVkVmSni+Xs3f2XjXUCZsRHp2HN8t3unkfsFwy
	 MQPaJUXyS/R4jg9aE6bz64uCaCthdNS8ObiDAwIU7JN0Y9gRTRtHSoIO6zDLJ6ltAc
	 zfHn0uSDFkicPd+F08QcIMZe64uOWq8sy3wqTEOF+Yg+xgXHl0XkbQLwSkiIk/14Hs
	 7NWylmfhk14hQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 10:22:51 +0200
Message-Id: <DBCHFBDWRHZ1.96R3AMCDUX9S@kernel.org>
Subject: Re: [PATCH] rust: devres: initialize Devres::inner::data last
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <daniel.almeida@collabora.com>,
 <m.wilczynski@samsung.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250714113712.22158-1-dakr@kernel.org>
 <aHYCOFZZYbgP39nR@google.com>
In-Reply-To: <aHYCOFZZYbgP39nR@google.com>

On Tue Jul 15, 2025 at 9:24 AM CEST, Alice Ryhl wrote:
> On Mon, Jul 14, 2025 at 01:32:35PM +0200, Danilo Krummrich wrote:
>> Users may want to access the Devres object from callbacks registered
>> through the initialization of Devres::inner::data.
>>=20
>> For those accesses to be valid, Devres::inner::data must be initialized
>> last [1].
>>=20
>> Credit to Boqun for spotting this [2].
>>=20
>> Link: https://lore.kernel.org/lkml/DBBPHO26CPBS.2OVI1OERCB2J5@kernel.org=
/ [1]
>> Link: https://lore.kernel.org/lkml/aHSmxWeIy3L-AKIV@Mac.home/ [2]
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
>> base-commit: 3964d07dd821efe9680e90c51c86661a98e60a0f
>
> I couldn't find this commit. Where does this apply?

The commit is in driver-core-next.

