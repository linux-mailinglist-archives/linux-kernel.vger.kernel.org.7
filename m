Return-Path: <linux-kernel+bounces-898106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1D5C54618
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A242B3AD1F5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47683288C34;
	Wed, 12 Nov 2025 20:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6qGln/p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F837A55;
	Wed, 12 Nov 2025 20:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978110; cv=none; b=cswWRL3aputYEYJlvi2tFvQYmQwpBYFQ7saW7s2EiHe/5Ls7AXzZX8WoDrE7/LNDO9N4MoHu1BaOSy/PJ+FyzhK3fP69G68qFRUJcGRj9C18f/5DggW0SYq89iJY5XvOeAsMJthVEDu+ZY1ZBr4WqlaG5+LzjMUH6k8X/ACzUgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978110; c=relaxed/simple;
	bh=IBaCdq28fwapjp7V/4XKS8Fmm2gV6YM9nEce1KcEJ4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBVpV86Ww+EjTULDTJVCdLlepd3BLD+WfXzdFRNN4w8qy0vIRaFmJbYCld+nC2HQZYBBTMU0oVejEswOdLUD40tnbmzWk6uJK34i2lZ4lTeyl86ZJ99T9Na71opPDJ0zRzinoU7cx4vyIK9l7yY6qMrM6Sqp3w7NIY8PwRej0tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6qGln/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9548C4CEF5;
	Wed, 12 Nov 2025 20:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762978110;
	bh=IBaCdq28fwapjp7V/4XKS8Fmm2gV6YM9nEce1KcEJ4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a6qGln/pKustJdC7wLKSeHJvUVnF6U9X+SQueOf89gVbk20eCsxgpGPvdElCwA/T1
	 4DNEyn/34DOgnvGHlmDBq3YGsPT7AbMvRh8ZMY3anK/mnv/w1vnZhJw20DNsU1NSjX
	 a3GTtWAehaLQUpF7dOyNGU6PipdlOKT9uhBzm36oLn0CtlHTLMTvnCeFRRMqVz2/cX
	 xl+uqRByN9KOU/jAFBNMiFujZvmUrujwwSObb/VKbgGNVW/u8H0SYdTKpbp0NKTHIk
	 JYUwqdylkYpDl+HMwq5GvhZiFgew5iLvReQrHvoo5anB7ZDmsR6Pqj3nwEV1h8sP2y
	 fUXH6g3RLjZ2w==
Date: Wed, 12 Nov 2025 14:08:28 -0600
From: Rob Herring <robh@kernel.org>
To: Yuntao Wang <yuntao.wang@linux.dev>
Cc: Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	James Morse <james.morse@arm.com>,
	Chen Zhou <chenzhou10@huawei.com>, Baoquan He <bhe@redhat.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Alexander Graf <graf@amazon.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] of/address: Remove the incorrect and misleading
 comment
Message-ID: <20251112200828.GB2155854-robh@kernel.org>
References: <20251112143520.233870-1-yuntao.wang@linux.dev>
 <20251112143520.233870-11-yuntao.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112143520.233870-11-yuntao.wang@linux.dev>

On Wed, Nov 12, 2025 at 10:35:20PM +0800, Yuntao Wang wrote:
> The of_bus_default_match() function appears to have been copied from
> of_bus_default_flags_match() with some modifications.
> 
> However, the comment was left unchanged and still describes the behavior
> of of_bus_default_flags_match(), it is incorrect and misleading, remove it.
> 
> Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
> ---
>  drivers/of/address.c | 4 ----
>  1 file changed, 4 deletions(-)

Applied, thanks!

