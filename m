Return-Path: <linux-kernel+bounces-876683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A792C1C327
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76FBD5A451A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBD52E92BC;
	Wed, 29 Oct 2025 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="D2K3ITH8"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB7E2D8779;
	Wed, 29 Oct 2025 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754535; cv=none; b=eRduSK0Pqn7ZdYOKnnOJEwvPNkKLfppyIZWatqwA+gH/5XhXnJhtbuhnyy1EAcN3M9J36wODUf66xb9yhJDPWZ5JWCYPKz+kJPvZMSjHmUUoB0GiH0j9h7wEEXzKKKzIJC/zwioLJlsedewpcu2eisPUoJnc0HZUWGCIjD7s6ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754535; c=relaxed/simple;
	bh=P4oeid1HL5dlM2icZgrR+rwKVYRUYDzMQTRugMfcxYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ia25ffn6AA7qS9gCirKivHHzx4jLv+A97mlreOSVsgPETY/P5g+DqKhaKPFBj/K3OxcxlQEltUPD94Gho+WrfJPNYSlyFJlqnakFggs0J5LBoRWDcB6Acx9vR9ZEyIHyuUtXwcbo6VXYs6Qur/UnZsvP01oOYcUdctvVZrNK4Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=D2K3ITH8; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 941F3406FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761754532; bh=L8Kiv1HZUF4H6QpVPZ/toYV2pUWfUfVz6DT+A2payl0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=D2K3ITH8Kha3L/FIwspP7fM5n7jF6E1BIxFzPqhUrhs4Gp55B0Qkm9lTWyOcUMSTn
	 BCM4idQ3UQ9UAGFe7hZhSX/pbXXfOXEjLEhRQIYqJdulF+DVCKsdgeqd4tX4Qafp+6
	 x2E8mAxubaAFQLFWm4oh5ilnfR6xiZHQ/F9VyqKks6cn5SecFIjU9m5yoTA1rKG12P
	 aWeERTSVgMdwsJFk+fQENyZTSPKXtEeEXq7sa5MUTM8yAae2kPCQ1cCgBploZz0Thk
	 jAzxOiTSqXnVopEoL4CPw6HQyT9RkeCwgcB6TVYXJ/T3UPLBoWbxqDrWRNQMtq9yVI
	 iYKex9Bltjokw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 941F3406FB;
	Wed, 29 Oct 2025 16:15:32 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Brendan Jackman <jackmanb@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra
 <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>, Balbir Singh <sblbir@amazon.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Brendan Jackman
 <jackmanb@google.com>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 0/2] Documentation: fixups for L1D flushing
In-Reply-To: <20251015-l1d-flush-doc-v1-0-f8cefea3f2f2@google.com>
References: <20251015-l1d-flush-doc-v1-0-f8cefea3f2f2@google.com>
Date: Wed, 29 Oct 2025 10:15:31 -0600
Message-ID: <878qgtr8f0.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brendan Jackman <jackmanb@google.com> writes:

> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
> Brendan Jackman (2):
>       Documentation: clarify PR_SPEC_L1D_FLUSH
>       Documentation: fix reference to PR_SPEC_L1D_FLUSH
>
>  Documentation/admin-guide/hw-vuln/l1d_flush.rst | 2 +-
>  Documentation/userspace-api/spec_ctrl.rst       | 6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)

I've gone ahead and applied these two, thanks.

jon

