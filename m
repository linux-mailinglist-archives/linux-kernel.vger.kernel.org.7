Return-Path: <linux-kernel+bounces-856479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4B6BE4408
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 44C3E359D2F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F79C34DCD0;
	Thu, 16 Oct 2025 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2qZbovK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691FC343D9E
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628739; cv=none; b=WgR1F/Ej4t9edEat7ZJf+OOy4y61fnFSuyt9KNtng451t11AYh4AMKWS83qI+N79xt4EuwheXyHWxbOxntIbFHl0CWuw5ViWmHKFL5kOSin6982RgzpmKTejnbu+smO/lgyf2ZTqMOE7U9kntwoVlY5XoR1NGf5iiHqy7qdUnBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628739; c=relaxed/simple;
	bh=jCbbkx8WRZSUomE4rx5o7V35Bo7sjCQoeqQNqzw8Ous=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n90Y6QxmzmaBb6BEWezcbrLgWtGUJuU6CHB4m7e3LeQzF9zP6nIpRPcH3/U5tbcExtG29YGrUvy9ZAa3Jscl/bkWQpHMzwshAcaf/GBM0g67aQjgaZweWZVUzhdzpHnQMPG4M0wu+d4P6cFLTAzBZ4mnFo8yX2UqFle8PsbLGUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2qZbovK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2306FC4CEF1;
	Thu, 16 Oct 2025 15:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760628739;
	bh=jCbbkx8WRZSUomE4rx5o7V35Bo7sjCQoeqQNqzw8Ous=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l2qZbovKaErD34Fb6Vl9QzA1ZxgafdNKK8CQfcupzbTkAyOPE96C+BM9qZbgshMUE
	 AqKOxlztP/Oz/U22UJmEI4J+hSBUIAkEOQnFF0iBLVQ02mgptELHVPnwrxDkMXITTh
	 UQF3wprr4wwYGe8pxJ13vCFHiAA47nIVUz87+Wqz88uy/q028+sKepJm1T4DReEGhR
	 L39I8uPp9cVTVnYDcdxf/f/dVW4tWSR29Bo3lN6jL7YRBF/nRamlJIbl+BveumN8S0
	 WBosk3os2YvaMmP9hCk4joPVTxenzbeVI9bVhFMJnUGSKaAn5XWdA79y5pM2qxuew2
	 I6dUQLXuj4sJw==
Date: Thu, 16 Oct 2025 05:32:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Support RT workqueue
Message-ID: <aPEQAqGOWOzzZl4Y@slm.duckdns.org>
References: <20251016102345.2200815-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016102345.2200815-1-jackzxcui1989@163.com>

Hello,

On Thu, Oct 16, 2025 at 06:23:45PM +0800, Xin Zhao wrote:
> In a system with high real-time requirements, we have noticed that many
> high-priority tasks, such as kernel threads responsible for dispatching
> GPU tasks and receiving data sources, often experience latency spikes
> due to insufficient real-time execution of work.
> The kworker threads are shared globally based on the attributes of the
> workqueue (wq) and the parameters of queue_work_on. This means that
> regardless of whether you create a new wq or use an existing one, the
> kworker thread that processes the work does not exclusively run any
> specific work or work from a specific wq. While this design saves
> resources, it makes it difficult to ensure the real-time execution of
> work by modifying the priority of the kworker thread associated with a
> specific work in hard real-time scenarios. Additionally, if I manually
> set the real-time priority of the kworker while executing the work task
> and then adjust it back upon completion, the next time queue_work_on is
> called, the priority of the kworker thread will have reverted, making it
> impossible to ensure timely execution of these lower-priority threads.
> Moreover, frequent priority adjustments can incur additional overhead.
> Perhaps we could implement all logic related to hard real-time tasks
> using kernel threads, but I believe this workload is unnecessary. The
> existing workqueue mechanism in the system is well-structured and can
> guarantee that work executes in an orderly manner in concurrent scenarios
> by adjusting the max_active and WQ_ORDERED attributes. We only need to
> introduce a WQ_RT flag and add a small amount of code to meet the
> requirements of hard real-time workqueues.

For things that may need RT, please use kthread_work.

Thanks.

-- 
tejun

