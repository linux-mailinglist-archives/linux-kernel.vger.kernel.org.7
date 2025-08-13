Return-Path: <linux-kernel+bounces-766440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1484AB24698
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3571BC6C99
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355472F1FFF;
	Wed, 13 Aug 2025 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAgPhmeC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1A62F656B;
	Wed, 13 Aug 2025 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079180; cv=none; b=uXldmhIbeWyq3hfxeiYHA6/7JuSPBG1zkbBIPJzRe4QbcTcqt6nl3W/4H39+pUykyYxVAeWYVWIlJfQ8BjBALPxrnbwuhQXT5b+htGbLQpEaA1pNfrSCBnWL6zAH4aFgmwPJ/X0Zz39OiJ9zZDlCQcB+B1z2yu5yy5jSf9ElRtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079180; c=relaxed/simple;
	bh=fz8vXQqF6XX47y7hrdAgB22LMoN3frcHQcMQz/PlEVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAEHFnWLX3G3NGm1mCpjP30R9drmOz81SeKAkrCLaPBpRNLuKJdZF6ipAfDaP5KYFwyUFHTuUHf55koilsnm8TDe9ZBMvQTR+yqDYGqfzLr3LsPTW5R1ncOR3PMYx5uUf+wELzZKtQg/oQYu0Ev6RR6dNncjeHRW5LO4Z0cbNDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAgPhmeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3564C4CEEB;
	Wed, 13 Aug 2025 09:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755079180;
	bh=fz8vXQqF6XX47y7hrdAgB22LMoN3frcHQcMQz/PlEVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pAgPhmeCryLp0XfUbl0U5MAkus4ypvGckg53N4VVzeBbppGZFee/Wuzt37d4kVCpk
	 kfi8N4eq547u0zrUWr3vphYmFg5Mb+wVv90ZaEFo07UeAbpcsyoYE3G3/qom3kVXCS
	 bESrR2y9vXK5SaCuqvUT6191e7/A/yCyvtcoxAEeWJ45eFNpvUzuXkdfISZynLox5Z
	 ImHXCRZdfwci3Hxb/+U3uM7NTgf4OO3WfpbPpIc9xG5QJg8EMGC/Wj8q5FPyDysbNw
	 BU+JgHqAfuqCCjr4LU0NN+RtihtqM23A01oNfsVLJK6Xavlsb7HpKg0XdSIHryWcIj
	 wRHMWCiEmFFXA==
Date: Wed, 13 Aug 2025 09:59:36 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Benson Leung <bleung@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	"open list:CHROME HARDWARE PLATFORM SUPPORT" <chrome-platform@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/chrome: wilco_ec: Remove redundant semicolons
Message-ID: <aJxiCEvaRdLlbLp-@google.com>
References: <20250813094858.557742-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813094858.557742-1-liaoyuanhong@vivo.com>

On Wed, Aug 13, 2025 at 05:48:55PM +0800, Liao Yuanhong wrote:
> Remove unnecessary semicolons.

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/1] platform/chrome: wilco_ec: Remove redundant semicolons
      commit: f7439a723e5aa5b35c76355e1b9b2cd1108f656e

Thanks!

