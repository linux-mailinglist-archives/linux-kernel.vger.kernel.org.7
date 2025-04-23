Return-Path: <linux-kernel+bounces-616062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE57A986CB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 12:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2695F1B6553B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 10:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D1F269CF5;
	Wed, 23 Apr 2025 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ww/GE/7F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A795B26981C;
	Wed, 23 Apr 2025 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403056; cv=none; b=IIHEZcvtnwW/Nsjoy4DauPUuwiCr6EP9+UyAjsB4q6EYBmAaU/G6OtzSn5h/BKnDePDE9TvHnI9BALT8+sRcl78Mbh404AbOVrMmsWOqpApuoVzJmcUlunah766otVPYx/3YxQXIumFc+QrYHhlBU5L3z3WiMDEyXzQOKp2ymqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403056; c=relaxed/simple;
	bh=+yYCShvmraSEMTdaROMxn8suowRlbwu6H8r89f2vRUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndy5C9RgeJFLgNqC0T5YwTaOwSOi7Tb+f1F2O5aRYmBJdEOYeuZdRIMLuChqbY4QqDN9PnqE/BDlzbdlTP6Q+eZQ/NOSVaMwrKvfPb2KanIm0k6dGgxphuhPItK8m5SfZSUL3wIfY7rlSzJRjqldlSQCkAvth00vZWqw6A5Oq5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ww/GE/7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836E4C4CEE2;
	Wed, 23 Apr 2025 10:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745403056;
	bh=+yYCShvmraSEMTdaROMxn8suowRlbwu6H8r89f2vRUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ww/GE/7Fc1P07FhfgcBz9fLgUa0HlVdt8nIFCSiE36jSc/s5yxSB8+Ew2KonxmOsx
	 iTLhqaZce4bLzHw/Vknnt9+cgNMS+SsJjg2ajB91oIpOJtyqw+FWDWja+aQZ3djwdD
	 Y60WaEXRfj6RfhWdKv6rzTR65fESWJYSd4r4thJ0kyh5gng7oAQunz8nZiKlM9BSfV
	 DhPQabXvrQjiPOMghSh3WSN8NaSH1AGoChkOj3JrxD9iD03ooN0ka1l7JKmFoniAX0
	 3MaGJopSrzhHFaFrXZQprDUkzshYWSkDopBLUhv0N5Dju017/BixOsoqzvStHeT6Mw
	 O2IqfGMW7YI5w==
Date: Wed, 23 Apr 2025 12:10:50 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Andrew Ballance <andrewjballance@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] rust: alloc: split `Vec::set_len` into
 `Vec::{inc,dec}_len`
Message-ID: <aAi8qnGjhHsQKvWc@pollux>
References: <20250416-vec-set-len-v4-0-112b222604cd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416-vec-set-len-v4-0-112b222604cd@gmail.com>

On Wed, Apr 16, 2025 at 01:15:39PM -0400, Tamir Duberstein wrote:
> This series is the product of a discussion[0] on the safety requirements
> of `set_len`.

With the following changes, applied to alloc-next, thanks!

  * Temporarily add #[expect(unused)] to dec_len() to avoid a compiler warning.

- Danilo

