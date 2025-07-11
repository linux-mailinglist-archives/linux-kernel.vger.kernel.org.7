Return-Path: <linux-kernel+bounces-726852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 156ABB01205
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB4F1C26C9F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC531A5BA4;
	Fri, 11 Jul 2025 04:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgV30nfi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD001991C9;
	Fri, 11 Jul 2025 04:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752207073; cv=none; b=uOs95p1C1Oze2V06c7oV1q76pI2y7UC6qj1HC41geSaUKFhlEZ+4ooklx4T+NaFu02wiaYY2E2MZFI6QtM55ZotDYJJPDJdMWwaQb52d9OgA9s0kpnKPrO29jUXyQaniUmBWiKON8+uRWn4xd20mV8UEPxQuG9CrchcxJNT4iWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752207073; c=relaxed/simple;
	bh=Rnl7xU9bY0O/MPpuuywEFh9UQKQjWtrcMdb/YCLb/YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ID8ZRcCqOfdILINK3E5vosuYlUIof2F8jAxTSp8++NKv08Dtw514uEbSm74/NuWNRqKAhtD0e2G5RM4KqOWzUOiPCxfguRWYZfwNvn9fl/hPB1ayvST9Gx/YBDs/zl7p7K5iiyKsmOrWVUwGLXYqKRWATBaOgWnSLMDUXAtGYEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgV30nfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB813C4CEEF;
	Fri, 11 Jul 2025 04:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752207073;
	bh=Rnl7xU9bY0O/MPpuuywEFh9UQKQjWtrcMdb/YCLb/YQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UgV30nfiV46FqX1HvGKcrcD82ba8T8h8GdzWIiFVNc9Eq5cQnFyv5PXU+ZBYQocut
	 WJ8eRkphp/zlJcdXE+39A69XDEviCyXpLg5p5yMNWDA+ORCegrKvL6+erMAtj9Mn1O
	 16I6GKVJjU0w09VIo0d8FBDbC7tSnkpmcOUlPctjMJs67kJq2EvKB2VZavypExq4Dq
	 tnRXxlYc8DKESp4Agq/jwveKGwEGeIvokJk7pM2EkPtnSQYcb9+fDxgIfkDEbwAUYa
	 aY+n8rfqa0oSe/kF6TNq7UsnJB7sbzlIxO05b4K5G6O5IJviVrJboBw69aiCuneepU
	 IeMebvS3On0nA==
Date: Fri, 11 Jul 2025 04:11:09 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Radu Vele <raduvele@google.com>
Cc: Benson Leung <bleung@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/2] platform/chrome: cros_ec_typec: Add role
 swap ops
Message-ID: <aHCO3ZqIFYJu2YTn@google.com>
References: <20250711003502.857536-1-raduvele@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711003502.857536-1-raduvele@google.com>

On Fri, Jul 11, 2025 at 12:35:01AM +0000, Radu Vele wrote:
> Add the pr_set and dr_set typec_operations to registered typec ports.
> This enables sysfs to control power and data role when the port is
> capable of doing so.
> 
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/2] platform/chrome: cros_ec_typec: Add role swap ops
      commit: ab229c2b72c35739e8ffb70af11190ff40f38701

Thanks!

