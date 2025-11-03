Return-Path: <linux-kernel+bounces-882199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB464C29DCB
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 03:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9E2188C18B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 02:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F196E17DFE7;
	Mon,  3 Nov 2025 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aopg8xA+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AAD79F2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 02:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762137119; cv=none; b=aBNnWz9+ZDjBCmuvBv7L+nGl+RJiT51EY35iLr9HMXhxC37Ltw3Zp2nm5ZaJfr5j6KxB+MDmCnu4YIcogYjT8dkZJy72fc4fz8rQMP7wyggjD2Rmlwa2yDS9tglokweBVuaZXDpSEESbhXIy2fBiSWmNrHoVKPc2NIPPs0heWfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762137119; c=relaxed/simple;
	bh=Vtr8xLqE/U8u7psrPpr6WVoJmFLmnRdNWlMXS2Zn6BM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YJXbKWOdJGldfj8hiapVkwgwxwyzaeyjomb8C6/IUnk5vQddWeJcauu8qtW5unB0JKVRl6YePZ55qFpcb+L/N6ObfHGpD1qs+pwNBqsMlFrIQ0oAJAim+IGfPpweyI2g999oAaYCxjlhJaHSqP4crNzExezZnq/mvSiRMS69n2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aopg8xA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4ACC4CEF7;
	Mon,  3 Nov 2025 02:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762137118;
	bh=Vtr8xLqE/U8u7psrPpr6WVoJmFLmnRdNWlMXS2Zn6BM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=aopg8xA+aBmDFKS9tuPwvbfkEG8QXZU8N4aJlZ9TuR3BhrNwxZ9I9zVLSCRApFcBl
	 B/5tjB0Ihh4N0S/03xt+g2U0Y38Zn1nfeSQfyQ4I6uj1uM+55vsmYkc9nhxoa/tZyV
	 bJdrOZr7g2RICW79Nm2wnrK8Rys7/f29z07/0TpGO/gUs4jEFWGGvYqUcQfs063G0h
	 6gbzdDflATO2oJjvN1rRuEu0VQUV7s7+jFgY9ntvPRiDP31RpGW44qy1NQdLCslXt1
	 pWK/eFTMLQFh44C4H6nLEwKKkGkkUbZ3nbjAUMQp7n4Rr/GxM5vA56D2/zpfMvQTGO
	 9n9NjG3Iv7gKg==
Message-ID: <d52e6fc9-9285-4e49-addf-9d6b7eb1e6e1@kernel.org>
Date: Mon, 3 Nov 2025 10:31:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add fadvise tracepoint
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20251028195444.3181203-1-jaegeuk@kernel.org>
 <aQUrtSAXWtHtLhtm@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <aQUrtSAXWtHtLhtm@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/25 05:35, Jaegeuk Kim via Linux-f2fs-devel wrote:
> This adds a tracepoint in the fadvise call path.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

