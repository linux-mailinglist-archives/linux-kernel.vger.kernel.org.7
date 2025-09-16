Return-Path: <linux-kernel+bounces-818716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A452B59598
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8FA3323C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA36730DD17;
	Tue, 16 Sep 2025 11:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N2NSSuJr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D3D13D638;
	Tue, 16 Sep 2025 11:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758023669; cv=none; b=XJEYhLNe5EkquCZipT9HUWU2DHVK7HLmqQ3F4kptZ1hEZzN7fnQN2qbaHjFChbIO2EzVXfa3hlSD2VSWYxoLI7TQtNil5ceUN6dne1goahUA/JE+BL+iH3b2874UCQ9EsFjhfyjA4gPgfBQCjpdbOKnshw6macqL7iN2SEz9EdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758023669; c=relaxed/simple;
	bh=IX6I147vwhuwINm2ZsDn7ANleLwLQ5AO0LNeCnkR4iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMNSXzGjNa9F63a9zyVKH/7lgg2nSMn/d2jxcfT4ZGCtCR7s38VpO1+aG32oGweMxu2s388DNbg7XVNr6PM4zFM8lsvmpDC4aekUQD0g6nJTCK1runUZpmAOq9Lu93LyurPrsPjhcX473g+d9izcB03I04Rd9qu8D4HPDzG9oF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N2NSSuJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B87C4CEEB;
	Tue, 16 Sep 2025 11:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758023668;
	bh=IX6I147vwhuwINm2ZsDn7ANleLwLQ5AO0LNeCnkR4iY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N2NSSuJropN0J6OPAInfT7Ics+ZaNcmSLX9W7vUuytq4ngG+84mNjcctZFiv3Ugwd
	 uhUQGas1We56Mf4a4E8FJBQ82TLteu4q9RczDVyUNC0B1JpRIyeKMP7sV0wDS7e4/h
	 S0DaYmK2VVvtjeLAJPZV5uwVFGw11OUBxwRiah1w=
Date: Tue, 16 Sep 2025 13:54:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: JaimeF <jaimefine6@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, david.m.ertman@intel.com,
	ira.weiny@intel.com, leon@kernel.org, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, onur-ozkan <contact@onurozkan.dev>
Subject: Re: [PATCH] Fixed "initialialized" typo in auxiliary.rs
Message-ID: <2025091651-symptom-unsocial-385e@gregkh>
References: <20250916103839.17202-1-jaimefine6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916103839.17202-1-jaimefine6@gmail.com>

On Tue, Sep 16, 2025 at 10:38:38AM +0000, JaimeF wrote:
> From: Jaime Fan <jaimefine6@gmail.com>
> 
> Suggested-by: onur-ozkan <contact@onurozkan.dev>
> Link: https://github.com/Rust-for-Linux/linux/issues/1187
> Signed-off-by: Jaime F <jaimefine6@gmail.com>

This name did not match your From: line :(

Also, you need to provide some text in the changelog, I can not take
"empty" changelogs, sorry.

thanks,

greg k-h

