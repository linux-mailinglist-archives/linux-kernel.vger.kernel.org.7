Return-Path: <linux-kernel+bounces-799757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F35B42FE6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 557ED1C235A7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C411FBCB0;
	Thu,  4 Sep 2025 02:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCAkafBm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18043D3B3;
	Thu,  4 Sep 2025 02:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756953783; cv=none; b=f6xYzit4/51NHHt1iTHtUiqQYnuKrZOT+PJWtdRaADk5m81lHinYF1REMbkqkQH9zw9P3OE18gcQPJEFphAGElvhHx3py8ddhezB+IfYvqnAMPjaa/9MMtjXrVoCJ8aQJkhXE0dBv9ctFdT6kAlddQiUGW95h9nGuyfY62cpmzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756953783; c=relaxed/simple;
	bh=zPXfcP6u5ldvZ0n0AJVf3O40vfM/a3dstYlcI1bi8cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/O/GCnKjFeEQUTJ2WDndCOq1FCgHJPwr0yStc1zsZeXkDWfuP6Uwe65oIMKf6boHdWJAzxFtAzz8BdIfqZXhEJ2ne1MdMbsvAr6jbq4wmThhfzP613/mQkH0D+DPz7te1CmvVR/uaD22Jg2+uUUY6367QbKEi7GQcVxVxxy/Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCAkafBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B86C4CEE7;
	Thu,  4 Sep 2025 02:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756953782;
	bh=zPXfcP6u5ldvZ0n0AJVf3O40vfM/a3dstYlcI1bi8cU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iCAkafBmBXwbyBz65mxgzRKbaJ2jy9doEOh4i669NW6QqmvWF30A76KQuQNzPvbTb
	 mZoVQJcI4e/vFmesyozumwb/xWZ52kUGC8AN4WeQonRBlD8JURgBDtTLvcziZNWbp2
	 LaAbuJAPF+sKB4xHZHOysRb+mmf2/SqCeuYgTIi8aKl4LlRj0url5bR2qlO/oBAWWc
	 KtN1+7NgxKalF0YHIt2pJaRD4uNkRGmggHdRcnYe8oJgTRgoUMd+dfhvk4zOdoKXMR
	 pJcr6amhOTmjZFcqBg6SxzjA+c9WhnexgGsd7bdC3H7mwYUjdhVtHmfHXmEQDfLPsh
	 XmorXH/sYYCXQ==
Date: Wed, 3 Sep 2025 19:43:02 -0700
From: Kees Cook <kees@kernel.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/3] overflow: add range_overflows() and
 range_end_overflows()
Message-ID: <202509031942.A1669D10F@keescook>
References: <20250829174601.2163064-1-jani.nikula@intel.com>
 <20250829174601.2163064-3-jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829174601.2163064-3-jani.nikula@intel.com>

On Fri, Aug 29, 2025 at 08:46:01PM +0300, Jani Nikula wrote:
> Move the range_overflows() and range_end_overflows() along with the _t
> variants over from drm/i915 and drm/buddy to overflow.h.
> 
> Cc: Kees Cook <kees@kernel.org>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Looks good to me! :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

