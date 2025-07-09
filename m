Return-Path: <linux-kernel+bounces-724033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBBFAFEDC3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3713B8EAB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173982E7F37;
	Wed,  9 Jul 2025 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="jtbO9RnH"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A31288C22;
	Wed,  9 Jul 2025 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074977; cv=none; b=XYhFW1pNKIG5vWDMcNyHydyz0FEgV+LH+qWfP78rXDoDrd97kr0Kjso3QojflfC4AFqYIO+U8aDayghc9dxfwZCbp4bKotHkgF6IeqPBKSHUkjhMGcdWQt7hC4H+QyHUa1kutTNe9IFD/dyOXTiNlzilCBUgW4+0CVWeWZxirMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074977; c=relaxed/simple;
	bh=9Z+grRSklTfhvS+8PlCC9Ev7rbfRGqoFZ/esvRQ20g4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QqCtaWeHMtb7vZoztjzOHwGRlv8V+fOHmE+ayu8VmhVwqaPf0w1DFnhQYDr5Tw+mIgvRscXsmqkbIr0pa/nH/wrTnZ85+o0EsDS7/AzUyESd/UC94TuZJ2aj5U9MCBWyYRIlo7A4NxZtCKinPrys1x3XSMJFQ9IMXukbp6U+R+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=jtbO9RnH; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C365D403E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752074968; bh=zMLx0BYVjQK4fSirHovfR4bAnXWmFQV8Zo3LMvVuScM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jtbO9RnH1molozbhEuo7Yt31TcIFUIOzwr8sxpfm8XRv2bItxOq0iJXObdlCkWbxg
	 JWlrH75h0xaBNddzze+P/1T1xMT97nZv29J7UXarMrF9FZ1cpxxMrua0vNluPIu0+k
	 igJhFyAbI7YQwFmwVCcexxYqwUypx086j+NOYJkrJ0KbAwx0CcECGPcf3L9t+2H0u2
	 ktTs/k+sj+UNYc0mTuZxwf9nmera5AyNJVt+cUMankU1E4UPcIyN7zRKEgKaq4pRrO
	 0A5MxZrZh1V2zSR3apZr0MJ99MwcdIeKDDwIWUfLzmtalzKl73txoWuRsRlkeVtN/x
	 GHKsZ5KNoOCCw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C365D403E1;
	Wed,  9 Jul 2025 15:29:28 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH 00/12] [PATCH 00/11] Thrash up the parser/output interface
In-Reply-To: <20250702223524.231794-1-corbet@lwn.net>
References: <20250702223524.231794-1-corbet@lwn.net>
Date: Wed, 09 Jul 2025 09:29:28 -0600
Message-ID: <87cya92xif.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Corbet <corbet@lwn.net> writes:

> [I'll slow down soon, honest - real work is piling up...]
>
> The kerneldoc parsing phase gathers all of the information about the
> declarations of interest, then passes it through to the output phase as a
> dict that is an unstructured blob of information; this organization has its
> origins in the Perl version of the program.  It results in an interface
> that is difficult to reason about, dozen-parameter function calls, and
> other ills.
>
> Introduce a new class (KdocItem) to carry this information between the
> parser and the output modules, and, step by step, modify the system to use
> this class in a more structured way.  This could be taken further by
> creating a subclass of KdocItem for each declaration type (function,
> struct, ...), but that is probably more structure than we need.
>
> As a final step, add some structure for the accumulation of the output
> text.
>
> The result is (I hope) clearer code, the removal of a bunch of boilerplate,
> and no changes to the generated output.

Has anybody else had a chance to look at this?  Or should I assume it's
perfect? :)

Thanks,

jon

