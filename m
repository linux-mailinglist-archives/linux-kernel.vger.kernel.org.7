Return-Path: <linux-kernel+bounces-769594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A26BFB270C5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 23:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729CA62332A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 21:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479C927584E;
	Thu, 14 Aug 2025 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1vTHOpe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995E625B1FF;
	Thu, 14 Aug 2025 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755206583; cv=none; b=N//ccfiKRSKFYQzw5E8LR7pp574m+C5QwOUkZ2Pyt5MxWbLgaezOeDiK9vn6vRGoLCeMStmFQHy5iH05RTXtELHiMSIQRV0teqk4rzLa8e10qysmOxRJYKq2SdmdtiwB3Y7JbT4k1EiJsqVRH68V2cpkpfyU3ot02WQM+H5TB+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755206583; c=relaxed/simple;
	bh=+6w3tFTK5fPIWnRbyQHTnQaWjidAzu/oHna6oYe4x+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSDDgJVD5rUUFSj2ncJnSUHKLuixcETLir8NL8hB5PjR0PgYNu9PUw93e27OiQnqrbsnEtdpsUuf+aYx0S4smDys3gKQcRuD6GgIPSxsdZnw3ykbrcRtWVuVIeXklUgnnTKjeAkNdt8H1V3o7uqm52voclVjGySyoOfbt9H3PXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1vTHOpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387AEC4CEED;
	Thu, 14 Aug 2025 21:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755206583;
	bh=+6w3tFTK5fPIWnRbyQHTnQaWjidAzu/oHna6oYe4x+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k1vTHOpey5XGuG82gY7jzQA2dbv7OGKOCRW5wJn/0rn+JqopM6fqPjG4R79+STnsG
	 xxwOrK+2M1HnSTyDB3rh/OMBNM0Ok9j9kSAvjTMkz/p0WMtiHfaLMYIJ5awXW9RTSb
	 Di9KP3rv8q0tT4xiQTuVvm3Bpvx54Z6jySdZUGhZcts5BwkMUd05xKdl7fwYiwcOSc
	 cglP79GCveQjlEIPg+s5GenY4ZTQXzcO10NbWl63ms+C4ALQXOKaKIF1XhMiuoW6bG
	 6C2omfa6xmqQFI2011X7U1qa48CmVxLHJoe4wsooO4lgi47pMVmmkA0wq599hYaBYa
	 l8RAsegRwLmYA==
Date: Thu, 14 Aug 2025 14:23:02 -0700
From: Kees Cook <kees@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Jonathan Corbet <corbet@lwn.net>, security@kernel.org,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] Documentation: clarify the expected collaboration
 with security bugs reporters
Message-ID: <202508141422.15BDB8E6@keescook>
References: <20250814192730.19252-1-w@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814192730.19252-1-w@1wt.eu>

On Thu, Aug 14, 2025 at 09:27:29PM +0200, Willy Tarreau wrote:
> Some bug reports sent to the security team sometimes lack any explanation,
> are only AI-generated without verification, or sometimes it can simply be
> difficult to have a conversation with an invisible reporter belonging to
> an opaque team. This fortunately remains rare but the trend has been
> steadily increasing over the last years and it seems important to clarify
> what developers expect from reporters to avoid frustration on any side and
> keep the process efficient.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Willy Tarreau <w@1wt.eu>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

