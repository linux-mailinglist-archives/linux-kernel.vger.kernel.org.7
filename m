Return-Path: <linux-kernel+bounces-836321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 292ADBA951E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76C4E7AB3FF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72C130749E;
	Mon, 29 Sep 2025 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uAiCpOjm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E0126F443
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759152191; cv=none; b=LxagmlKB1hSU5d0IrPkipLY1qs7+RXLzb6XxZ4CmABqqN/FEk7Pm5fjGd3AmKGaXGz2Yo/9/SwzlGy2+F5mOlWAhrFviWIBzFWrV/7XAlgOsQLSbcPDMYdHmxug+ZqCUeVjYvd9vvdezYO0x/3C5JXU0OVzGzbmacueFh13t3go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759152191; c=relaxed/simple;
	bh=P1PsCnGMAgf0bqZLjbw5phw2MRrVsgqiwNrstfCMcbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3qdtk52gDdReQwgStufFAO+UuDIXcbSFnHa0uRG+6kvkKmeqYZptvxHTXyvQU66BI0W7NMj8o0ml+xBd66VmKoELJTKQglFglUfEdaB3L6qyl8AEwMSSYKiIX/h/mXNGXnUgzxHhJNoIx6BnnH/3b3QE5+3cCQAeBPZmAPXpE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uAiCpOjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F024C4CEF4;
	Mon, 29 Sep 2025 13:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759152190;
	bh=P1PsCnGMAgf0bqZLjbw5phw2MRrVsgqiwNrstfCMcbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uAiCpOjmaE6J58WPTJGbqKcsWaopRumhycCUTS57z8lvUu0VcaOxi9bcW5/hEixAE
	 R3nMXYTQBtwk1Z/n/eUrCnrXIpq1HPhVZj6zv1u7704oD4iNWm1x/UciAp9lNHRHEW
	 9HJfurNjMp4LwdeVZ9yT0epMP37v++9ZbYxXi4nw=
Date: Mon, 29 Sep 2025 15:23:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Scott Haiden <scott.b.haiden@gmail.com>
Subject: Re: [PATCH 5.15, 5.10, 5.4] NFSv4: Don't clear capabilities that
 won't be reset
Message-ID: <2025092953-unsettled-hangup-5721@gregkh>
References: <2025091224-CVE-2025-39798-a66e@gregkh>
 <20250925125800.74222-1-siddh.raman.pant@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925125800.74222-1-siddh.raman.pant@oracle.com>

On Thu, Sep 25, 2025 at 06:28:00PM +0530, Siddh Raman Pant wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> Don't clear the capabilities that are not going to get reset by the call
> to _nfs4_server_capabilities().
> 
> Reported-by: Scott Haiden <scott.b.haiden@gmail.com>
> Fixes: b01f21cacde9 ("NFS: Fix the setting of capabilities when automounting a new filesystem")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> (cherry picked from commit 31f1a960ad1a14def94fa0b8c25d62b4c032813f)
> Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
> ---
> This got backported till 6.1 but not later for some reason. It got
> cherry-picked cleanly.

It's in the queue, just not been released yet, thanks.

greg k-h

