Return-Path: <linux-kernel+bounces-765351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CCCB22F0F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB1A3AB9D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814A42FD1DC;
	Tue, 12 Aug 2025 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yvl/AuzY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FA1273D6B;
	Tue, 12 Aug 2025 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755019752; cv=none; b=iD7ecdNvx686Qc+uR/Wu8yKIVdSW5ZFirVyFUZaqL7sA7P4TGBC1kAdl+MPZUzMbYvSdfszK6dRh6KPUgvSeEqiXXC3X/BhBKMpyAQ7vAPrYt+gwy8S7ZNYFDHkOGv2fdnAsAT2EASDbBspvtdf4wpGlGdwqkeD9q3A4mIj2v98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755019752; c=relaxed/simple;
	bh=VT5RV/eXYswbOXkV2oGMDMWd9Wx9gtGb9ZZrBa2mi+w=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=I23Z3w8mlZEsMJ3++MXUO2/ZLJpK5GxJQ7iG6ZEd9gth5t+CAxdwMO+PjjxYntXW6qwO63X1sSn2ct2zYm9YMfk3MgoounvnvOd8om47j5mK0Jy5q3z9v1O99pXiQcH9lXZMSZBiy5RqrJWADJkTHMGW3v1jlMePEaOlrEQAbYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yvl/AuzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAFCC4CEF0;
	Tue, 12 Aug 2025 17:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755019751;
	bh=VT5RV/eXYswbOXkV2oGMDMWd9Wx9gtGb9ZZrBa2mi+w=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=Yvl/AuzY2FrpLcnbh0ut3xoPfDkpI4k+Kbnnrrp+XXjoMSHENX8ao3LIolfeJB7rW
	 yHUVS0oQPOlj0dTpUjF32aPc1TqVI9dCrhNBH+Ye5S5JNq/h01u8qyzfpHABQeBQiv
	 e3+hyF/x4Hu/rAZyh3o0GJNtlLO1ZuULVJPQjUsoTmjR6xu5EP+8wVjnHMj4ksT8kk
	 jI7/5JEBjlRmlyT22bHApHDYDhPUi0Nlvzutc0VWA56wo3oMNl2fX4xgYEii4qgtlZ
	 uGUXjTvctWOXPuuAQ7S86POfW2Xc1y/l5NwwAGo2dPIG5jsb20hpJ6YgtBIctfhq1E
	 AAvuXj28scxZg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 19:29:07 +0200
Message-Id: <DC0MKTKUSL65.VZX2UIBJMTDN@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 0/3] Documentation for Device / Driver infrastructure
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>
References: <20250722150110.23565-1-dakr@kernel.org>
In-Reply-To: <20250722150110.23565-1-dakr@kernel.org>

On Tue Jul 22, 2025 at 4:59 PM CEST, Danilo Krummrich wrote:

Applied to driver-core-linus, thanks!

> Danilo Krummrich (3):
>   device: rust: expand documentation for DeviceContext

    [ Fix two minor typos. - Danilo ]

>   device: rust: expand documentation for Device

    [ Add empty line after code blocks, "in" -> "within", remove unnecessar=
y
      pin annotations in class device example. - Danilo ]

>   driver: rust: expand documentation for driver infrastructure

