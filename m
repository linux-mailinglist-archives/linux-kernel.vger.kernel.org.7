Return-Path: <linux-kernel+bounces-583237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFB1A77868
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 12:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A576A188B6E3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 10:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306F01F03E0;
	Tue,  1 Apr 2025 10:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/o5mNI7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8630D1EEA32;
	Tue,  1 Apr 2025 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501912; cv=none; b=TUOcU3jeJYkggVAeBqNlSsvIL0FhSEqbHyjFL6avReLgmZ6cGmTMCDuXA2zG79+dpM0GDMQ5I1eN3R+8sLdQ2och+5zIOCdueFjzaf0NovxlTEfEVFIySP/1cR14SU+6vtKbY6MOVsyf4R7vwlaI2wYrMa/vBBLlH82JIHTzzkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501912; c=relaxed/simple;
	bh=XqqACZD4cGiQVb/IeRuwKp1AJQlOtwcHtaHrUVqvYew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGqE4URdXzf/L+wNztOE3kYv9zvhvQOBeC4vMP+0p7FqcFlH7ccvL0ekNLAdHfvpO8fmxEAdqpDye9FtZkae8QfR3O6U2UGVdtUil5EachBXGLkWSovE4qkhNiJWhD60DC+juBon2AA1G2aKdyRoCgn0YZPMH3NmJzu/1BMosLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/o5mNI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03BFC4CEE4;
	Tue,  1 Apr 2025 10:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743501910;
	bh=XqqACZD4cGiQVb/IeRuwKp1AJQlOtwcHtaHrUVqvYew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o/o5mNI7iNhrvYmAcSy6AMXtjk3neTwQaU6XKMhcNf4YKbU6reRiCQsif0CEF+nKD
	 0jVPCzJGBIsgujd9QorknipaelCcJE1HH5SjbDk3NJIKMzQb/bkbsyGNxG/XO7c61H
	 tjqvWZ3en3Y1BbrhjBkuOfMNOxkVVwZrx84Oq/gVPTlI9jjzdxiJQF9HwpbSDKQoxe
	 /9YNCDYMr/IQbBCdghapYS/QgX2SKcJ9xJ3gsDS9H+OrRquaAaWmM6w8vlCSNH/Usu
	 OotQ/A1ohwa468Shj88fzxkSaML1uak0w9Rcf3vk/7irZjsdjGKrYSJrgGeNdwiNj1
	 mn2iPzjGXmdvQ==
Date: Tue, 1 Apr 2025 10:05:07 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] platform/chrome: cros_ec_debugfs: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z-u6U_GDhf53PTA6@google.com>
References: <Z-aiAAcIP7sBRtz0@kspp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-aiAAcIP7sBRtz0@kspp>

On Fri, Mar 28, 2025 at 07:20:00AM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warnings:
> 
> drivers/platform/chrome/cros_ec_debugfs.c:211:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/platform/chrome/cros_ec_debugfs.c:257:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/platform/chrome/cros_ec_debugfs.c:279:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

For my reference:
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

