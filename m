Return-Path: <linux-kernel+bounces-770989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9F2B2814A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724D21D0063A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55C61BCA07;
	Fri, 15 Aug 2025 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="N3yx+Ht7"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B37823DD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755266897; cv=none; b=hRxR/Kf9LVp4DhEIVmqezKyg9YBP+8C2fMAw72XCwQm4aLGcFUU1SxRTnWsHQVEoStFCBkpZgFT7+hzerNMp0MRwsa0IGN4+C18aTMU+vHMQsf4H69mcjpiNOl0upnRQMJOarjRXZwdUXDWbb06T3Cj7j+cA23zeX18a66bhFnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755266897; c=relaxed/simple;
	bh=VDhjwpGHBg0MQH6G9NkIMOkdUWrGpn9U5kCm/MCSSAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q0gSbixDYE1wJv1wEiU9K8R9xyh0X3kMZRLjNfAMOjDBM7qqdg+HFu9dr1Ai1ReL8CBOwHvaVzBwT5tgVo+c+/rIYHPhQBeJGiAhh20cxBnRtptPF0n+7qx7DZoirqig2YMl+n/bclfUkxpN5A+RB9V5E+k6rJCETscMkPBs3wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=N3yx+Ht7; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F1D0C40AD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755266895; bh=c39e0zqy27pWqpttnGDibIfJBLBnRjYP1oibXFSk1bo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=N3yx+Ht7mJxZT6wuXtv7OTl7/jlkx30kDzkcoqgnUWAEyLNHX+mWmGoUb36gqABQe
	 DNRP1z6/NN12sfhXuEBU3QviTZxFL0EoWF/p/u1/nF++qzF5GGkByGc+Dwghb6I3WB
	 GBblM7EnSUfC1bRRHrzeiqWRP6yERF12h5r/TOubpTOBPmIhWQl553grUmk/CiEK5j
	 eyP1fLhtoJPKxBnejZ7aogUqF3m0WNV2uEEtPxWE1IzFhBFnKvVVCYMD2tsblT9+DX
	 StLIJDFsnThFQFQ3rdxax7HfaQF4FSL3mTtKQkBgaC7f6PmfRD9YbZ4LXJo+6kztMr
	 QRHeOJxYPbkKQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id F1D0C40AD8;
	Fri, 15 Aug 2025 14:08:14 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: shiva teja sathi <shivateja769@gmail.com>, paulmck@kernel.org
Cc: akiyks@gmail.com, parri.andrea@gmail.com, haakon.bugge@oracle.com,
 linux-kernel@vger.kernel.org, shiva teja <shivateja769@gmail.com>
Subject: Re: [PATCH] docs: clarify and improve wording in memory-barriers.txt
In-Reply-To: <20250815132434.1445-1-shivateja769@gmail.com>
References: <20250815132434.1445-1-shivateja769@gmail.com>
Date: Fri, 15 Aug 2025 08:08:14 -0600
Message-ID: <87o6sgekz5.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shiva teja sathi <shivateja769@gmail.com> writes:

> From: shiva teja <shivateja769@gmail.com>
>
> Signed-off-by: shiva teja <shivateja769@gmail.com>
> ---
>  Documentation/memory-barriers.txt | 6032 ++++++++++++++---------------
>  1 file changed, 3016 insertions(+), 3016 deletions(-)

Thanks for working to improve our documentation.  Unfortunately, nobody
will be able to review this patch.  To have your changes considered,
please:

- Provide a proper changelog describing the changes you have made

- Avoid adding the CLRF line endings.  We do not use those in the
  kernel, and they completely obscure the changes you have actually made
  in the diff.

Thanks,

jon

