Return-Path: <linux-kernel+bounces-818374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB2BB590C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411121BC534B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB37D136E3F;
	Tue, 16 Sep 2025 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bWV1U8G+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366864A04
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011597; cv=none; b=Z+hTkrZjWy3gzbXd7M3N5NL/fTm1DbA3uI/dLXx3n4/cmB4mfmIZ0El8hgSdG86ifSDmb/T2QtzlCpxkUWYyK6ibs2aVst3bqg0fe+4eESnx8EZqUJW6R8nGNVZ69NvFeeF8w58PlCv/623G//VQMJym+vOfRuTnGvXBbIguBQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011597; c=relaxed/simple;
	bh=dZ9QHh+CbViuneTCKqhjLSwCnMJxoL2w16uVplJVSRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRWWAGP2gniRav7oiC7A/VSB897H39fUxH7AJ5aAxmcc5RvczaWLiSIhrKYpURZhNjGanNaeMU259uD978qgnmkX6+XEg7dlj/RSRhcVeCT493Mdm7cRGeP5YHUMoxtl8HtSlhV8Vsp9lIs7PYFP8s7ah8QUqSZBo4HzqPxftLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bWV1U8G+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692FEC4CEEB;
	Tue, 16 Sep 2025 08:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758011596;
	bh=dZ9QHh+CbViuneTCKqhjLSwCnMJxoL2w16uVplJVSRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bWV1U8G+mdVFNYLJYzt8td/7ZEail7WMEAEn21DQuwcufZ8Pbt1XXehk7JXaim0QK
	 XHIf45Naj6xAzqim+xk7g7bgyzcxkCjcMe+nAKL+QZlQ4dDxkj9jDPbmIu91p3Xrtj
	 vbZ39VtL6iR32MUb1AbXD6m1mh1VvbcdJvJdlFbQ=
Date: Tue, 16 Sep 2025 10:32:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chanwoo Choi <chanwoo@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] extcon next for 6.18
Message-ID: <2025091633-pectin-resisting-9dd3@gregkh>
References: <c88d98fb-cc14-435a-b943-ee3be4eaf60f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c88d98fb-cc14-435a-b943-ee3be4eaf60f@kernel.org>

On Fri, Sep 12, 2025 at 11:29:56PM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> I'm sorry that I did not send the separate fixes pull request.
> This pull request does not contain any problematic patches according to your comment.
> 
> Best Regards,
> Chanwoo Choi
> 
> The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:
> 
>   Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-6.18

Pulled and pushed out, thanks.

greg k-h

