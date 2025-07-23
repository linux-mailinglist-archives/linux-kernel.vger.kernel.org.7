Return-Path: <linux-kernel+bounces-743316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD29B0FD33
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A053D1C86CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2237C2580F1;
	Wed, 23 Jul 2025 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8lKkAZU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8277D282F5;
	Wed, 23 Jul 2025 23:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753312310; cv=none; b=Di3saR3NkuC8mErYqZO/8kxAjWJnzAiWUu3fyHUVYqdCg/qnyxTORuSDsigQnLd1vwmTuW7DAWiQ1ApPBZutedxdITAu/L14wWkiOab5ZGLrmPT2/mVoDSPEPIcJ2IhCGZne+ilmtfVeZO53ubgHyGN1Oj3lOYTj2kCJ7NcvIiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753312310; c=relaxed/simple;
	bh=hxXOHQqRKduiI/O4cWjz4zZNBqHGKPWgQrt6WqgJVsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCQYwIr23/T8izOAydIQPGxEUKEZTNb3WuPQ8Z93IRlYjeReLR2GOqUSUl/AUNg383cHeh+SOOJ1iD0sC39xhB1ryprF/CUL9/XFhvAKWIdMdkZ1RccmnxemqBhxB3R5nAwCqSVeYRqIdGE8WywNqP2EP2uP9Tw+WJjBInJxmJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8lKkAZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D72C4CEE7;
	Wed, 23 Jul 2025 23:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753312310;
	bh=hxXOHQqRKduiI/O4cWjz4zZNBqHGKPWgQrt6WqgJVsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j8lKkAZUxpf2wgw1t0sjB8Lv2f+qsaRlWF6HYLl9zVkJueclCghQ1CNe0JrsGuflx
	 2O+J2exAep0yEMDfzk2yyxum7Kqkdy7DACeJl9HftzQ6VtkLYF/5EPet3h545WoB2O
	 YvdUJQBZ40wAu+Mh6PCHVC2grLScvxuj5TD/lXfEjhOE4ZFS1hzYYRsmb6JJb7dfK+
	 gNRglIP898V4lvbVFnxZgRLHWcbPKZUGQquHyAwrmrfvmMMlZFSTNF76hZrcoVk1tb
	 kLOBWvysy2wLImnyWuMxR2+Gjf3qRdzPE9dMuU+jYR7VqOd+sKE7fyA/ECaXJI462N
	 f8rFF+s0KJJ9A==
Date: Wed, 23 Jul 2025 23:11:47 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Keenan Salandy <keenansalandy@gmail.com>
Cc: bleung@chromium.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] platform/chrome: Fix typo in CROS_USBPD_NOTIFY help text
Message-ID: <aIFsM5tFwgDu3HXu@google.com>
References: <20250723140930.1443-1-keenansalandy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723140930.1443-1-keenansalandy@gmail.com>

On Wed, Jul 23, 2025 at 10:09:30AM -0400, Keenan Salandy wrote:
> Correct the misspelling "platorms" to "platforms" in the help text
> for the CROS_USBPD_NOTIFY Kconfig option.
> 

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/1] platform/chrome: Fix typo in CROS_USBPD_NOTIFY help text
      commit: cc2d5b72b13b3af2b9b4bed3d5dfd0de14414230

Thanks!

