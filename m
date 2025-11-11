Return-Path: <linux-kernel+bounces-896133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A930C4FB9A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28DD11898A32
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3933271F5;
	Tue, 11 Nov 2025 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEvQrIMY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55D22C325C;
	Tue, 11 Nov 2025 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762893638; cv=none; b=l0VbkI783B2hNUB+ONf9jWaNedccuRKlBHIOpqQhvu0gWBapJGfbvWrC0e8Oz3HydOB0tkKcSVL1+5KhXmGhtRvinb4kE9XGBhQVtw18GK3dMczcFvHoxLR+9fhwAC0inad4FRnK9C2SmTenNuf7NxgpsJQ+cES6MaYQJtP7quc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762893638; c=relaxed/simple;
	bh=uGliNdOOPJaIbDrUl6HWZzpc/JOuRWYAfw93bPebCZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoklB8wIPs6ocBfS9VQBSP56xXSzmrgqxjVBAcY/d1Kq8dpZeU3Wdaa3TRfR7ph9PtFGRozRIJwZdFJxXXqa9xk//szcVWM62mGHkpS6JenZDSkLi5Nb2QMLPpjEE/8oVgoBrlgzQKxaQoHTdhHTOWBQNwAhXr+6yXT6hkM5jyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEvQrIMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103A5C4CEF7;
	Tue, 11 Nov 2025 20:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762893638;
	bh=uGliNdOOPJaIbDrUl6HWZzpc/JOuRWYAfw93bPebCZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SEvQrIMY8XDntihN0uVb8210NuSmUUqXW7EiupXoe7KqywDWQOyZq9KIyjR7MPEBn
	 l0e+lKiY90Hhzp1w3/o6vHLK313l8gOrPlhdf+HURWSIzGypn/sZ4Fp6EOtjEPUtiM
	 7qiw5bsir3A6iV9hau+DKN4dX5/Yg0uUdvygtRE8S4zoy6+Pc5xdPL6QGkXK4NWj87
	 Q/C4UFQvvW47FLWEy8zuTm/oDShoy/GMz08dLDl97721EukY+uxK0hrD+3VogfJuSE
	 msZOsO+Th2fZWo53B7ZR0zeifWVsP4ogon35sVAtq1xDwwIJRRNtc8rjxl7jjWuUJZ
	 yGTZ86t6D6Msg==
Date: Tue, 11 Nov 2025 10:40:36 -1000
From: Tejun Heo <tj@kernel.org>
To: ying chen <yc1082463@gmail.com>
Cc: corbet@lwn.net, jiangshanlai@gmail.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, laoar.shao@gmail.com
Subject: Re: [PATCH] workqueue: add workqueue.mayday_initial_timeout
Message-ID: <aROfRBGmglPgcPVf@slm.duckdns.org>
References: <CAN2Y7hwttMyUn0qsEcSBbrQ1h+aSzNpHMhgAxEbqJZn4vf5hBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN2Y7hwttMyUn0qsEcSBbrQ1h+aSzNpHMhgAxEbqJZn4vf5hBw@mail.gmail.com>

Hello,

On Tue, Nov 11, 2025 at 10:52:44AM +0800, ying chen wrote:
> If creating a new worker takes longer than MAYDAY_INITIAL_TIMEOUT,
> the rescuer thread will be woken up to process works scheduled on
> @pool, resulting in sequential execution of all works. This may lead
> to a situation where one work blocks others. However, the initial
> rescue timeout defaults to 10 milliseconds, which can easily be
> triggered in heavy-load environments.

This is not how workqueue works. Rescuer doesn't exclude other workers. If
other workers become available, they will run the workqueue concurrently.
All that initial timeout achieves is delaying the initial execution from the
rescuer.

Is this from observing real behaviors? If so, what was the test case and how
did the behavior after the patch? It couldn't have gotten better.

Thanks.

-- 
tejun

