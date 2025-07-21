Return-Path: <linux-kernel+bounces-738699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8C5B0BC0F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10A867AB7B7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6BB1F2B90;
	Mon, 21 Jul 2025 05:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ETRKBnv8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F2F1DFDE
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 05:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753076523; cv=none; b=ko95YHGnVqLHPWkY8kuqyYjKjdnE4JBaWu6U2EEz3kaSoGRIdvbQiQrIzHgSJjgYK5MAKj1MmLm0ofiMP5snKpBPpENhw0XISfZdZehrwN8w8PlpxO+wvgPbx/zIbClM285GJwjmyHA4pdYLo6BM707KhTYCLuG525vsU76sLD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753076523; c=relaxed/simple;
	bh=nXG9FhBe67BTnpLCQdY9bst8YPMwisq+IMdx3y/DD+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKp1LjugPm6sXOi3rCpt0IRYrlJofE7iVPdWxssmF8z5Q0v4I8/4Ta5Zbsl4Cqh7Qss1RtyfN8AAWFdBu1N+hydpeqG+Judbp3BD/IBH1CpYgLfRjW0cg3ejjZgLK3kNi8da3cTRAbkk0FxpSV3ufkx9ulMYkcDSjT4y+DPwtvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ETRKBnv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446DCC4CEF1;
	Mon, 21 Jul 2025 05:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753076522;
	bh=nXG9FhBe67BTnpLCQdY9bst8YPMwisq+IMdx3y/DD+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ETRKBnv8TxnWTDy+y9wVB4lo5YVpYKVVY6qVAUyNa+f1SipPkfwhOJukFzSWQp9ku
	 g86t20vZmkag5VrXKs90f8ERhblNpVOyhpsw7FfXedev78ImIjWJce2T18oIaY+kfW
	 Fs+bqrdeQa+psBCjPJfmlAOuhMy61Ry/zNtmw5Ug=
Date: Mon, 21 Jul 2025 07:41:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: Eli Billauer <eli.billauer@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] char: xillybus: Replace deprecated MSI API
Message-ID: <2025072117-shale-verdict-c72c@gregkh>
References: <8d3513e3-6294-b6df-189a-cc3bee76f0a3@outbound.gmail.com>
 <aHskWESzZdyBFj4x@pc>
 <2025072004-karaoke-stilt-ef20@gregkh>
 <aHyvPWeN_4JmPAzc@pc>
 <2025072038-improvise-polymer-a538@gregkh>
 <aH0hdrEOhzsqjqMc@pc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH0hdrEOhzsqjqMc@pc>

On Sun, Jul 20, 2025 at 06:03:50PM +0100, Salah Triki wrote:
> Do you agree that for someone who wants to contribute to the kernel by doing
> cleanups, it is better to do these cleanups on a part that is not directly
> related to the drivers, because it is necessary to have hardware to test the
> changes.

I'm sorry, but I have no context here for what you are asking about.

Please always quote emails properly, and realize that some of us get
hundreds, if not thousands, of emails a day to deal with.

thanks,

greg k-h

