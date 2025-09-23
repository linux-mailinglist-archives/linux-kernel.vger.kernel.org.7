Return-Path: <linux-kernel+bounces-829719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9FEB97B53
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 417EB7A31EF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8577330CB20;
	Tue, 23 Sep 2025 22:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiwh+DbO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E132E200110
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666235; cv=none; b=RRXXlVPbzXS+WlRlX95mtf4ckHHyAPeZJ5bFVD4oJvMvEl2YOgPgx7YbR6/KqwrcxzXKJ6oYPgFf5cMw9ZtypzkJo3TJLyi2BYqjcr6hNM4r8oGysdrC1kqJAoiaQIyXgJ6MDVzEZ7n/0pOTC1exYpS4EQoGj56zpWD9c1Es2ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666235; c=relaxed/simple;
	bh=SBvIE6iyv0RH8pQu9z63WITWFSkglhOWaG+dhv/u/Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvZzbo6gEAqa8PJ5Y4nv6AkPkfmHysNd6fRAM+5WaFpK2iMkg0kysks2FubqXpMMC0JjF0qpBVUClu/UaJyyOD80C1e2jqr0efyREXj4e6pqrDESQdSgRFb2CHAmdp2gjOwvdyR9vvQS30061Sxk3m/ySVi7z0T+lP75mSce43o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiwh+DbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5EFC4CEF5;
	Tue, 23 Sep 2025 22:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758666234;
	bh=SBvIE6iyv0RH8pQu9z63WITWFSkglhOWaG+dhv/u/Eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uiwh+DbOvi1/OxARP1BcQoH1Gmh5jyrwjN/smnxANUZlk0nEwUnaIH4e8IjTrip0v
	 hxe0Il6UmZK/zqJnw7lByqppa2gX8BQ896770cgIQbnDfq6pxc3jOiTa0gBpK9YsYg
	 JsydNWOfoleDE2XowId329bjEjkDahiixRL7MiWgr8cbX0CM2VEK57uz9fNHZzdTxP
	 UB3cajzyDy2hWLx+VzHjEjsh9Por6F/ujJc+FvjodarKgVW2dfvjgVKnnllbdE5rly
	 8Ye+3ZQFgDgaS903oBOoHDh914coT/tZ8MlHzT56ktR9HEqyXhs0ipQNoEWiAHWScQ
	 vdSmaPA9bXSgg==
Date: Tue, 23 Sep 2025 15:23:52 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org
Subject: Re: [RFC PATCH v2 02/17] objtool: Create disassembly context
Message-ID: <cvgagwuga3dj6jsn4dfmfaklt5fhdkqbij2wxc46ci6nr4dmky@l2daxik5cqes>
References: <20250619145659.1377970-1-alexandre.chartre@oracle.com>
 <20250619145659.1377970-3-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250619145659.1377970-3-alexandre.chartre@oracle.com>

On Thu, Jun 19, 2025 at 04:56:44PM +0200, Alexandre Chartre wrote:
> +struct disas_context *disas_context_create(struct objtool_file *file)
> +{
> +	struct disas_context *dctx;
> +
> +	dctx = malloc(sizeof(*dctx));
> +	if (!dctx) {
> +		ERROR_GLIBC("failed to allocate disassembly context");
> +		return NULL;
> +	}

Since this isn't a fatal error, it should probably be WARN_GLIBC() or so.

-- 
Josh

