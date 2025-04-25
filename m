Return-Path: <linux-kernel+bounces-619628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC79A9BF25
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 09:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803029A0677
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 07:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3F322D7A8;
	Fri, 25 Apr 2025 07:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+TbAGL7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7841A199EBB;
	Fri, 25 Apr 2025 07:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564676; cv=none; b=EnIwwS5pYLKdXsKQxAx1p5fch9B7grDlste1/SExd6/JR1aTeBf+KY9Ybp4RQBvE9bE/JzVvAIJxzyojfY67wlS/wtr+nT+00LpcMaDoWT30nNIGqGKkPvQlIiAW0iHJOmd2xXM6gHYYv7GKBU4kCqLPozrDRaHgbGpi+vjgATo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564676; c=relaxed/simple;
	bh=KajVQki4imu+USB01LcAiYyTc8lhLWP99y+8+fYR9Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oV9y2u7B/ZkRZEnaPpdww7iLJx3rbHDS4d82On/bhC+r7UG5NLp7jXYW6S980yNulgELCFrnxnLBBThUrc2kEtY5P2+J5/CWYWtxoCywq67SwIh+arY/A6azBj9gM5TIdKAcoQtX3OwzCB9C3ABBj4TucxUOq2N25t4lQ84IGZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+TbAGL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA729C4CEE4;
	Fri, 25 Apr 2025 07:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745564675;
	bh=KajVQki4imu+USB01LcAiYyTc8lhLWP99y+8+fYR9Aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+TbAGL77mItqOCYvHWzc79YChIl4yQVFNbKWzJhaIeUgiPrfAIUbsJ9PvPB8LUCB
	 wamjr+V+ec1CRgS0y3aP6Yaon+W49450u7VftmxhEmjuHDzlfuUmURn/7/ewyFIsm/
	 uXYUImDXHIRpoGbVg5Q4hu5aibkF6azR4eB6WO74N++iEyca8zlTk632WIaIKa8FZF
	 sWgFuMvEnsP5KRfME73BlwzTXG5YeC7nz7LtjEXa7oRrxd+A1zDX+1YD9F1EZN9AHJ
	 bsi8RAYXrl6l9TPHjYtJpc8TmbJQ/478gzTIFHMbC6CMiCWH6Fc1djUdbOCXYIbB8x
	 5/DLQ1uMU9cXw==
Date: Fri, 25 Apr 2025 07:04:33 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v4] hv/hv_kvp_daemon: Enable debug logs for hv_kvp_daemon
Message-ID: <aAs0AfTUAN8MVqqp@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <1744715978-8185-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1744715978-8185-1-git-send-email-shradhagupta@linux.microsoft.com>

On Tue, Apr 15, 2025 at 04:19:38AM -0700, Shradha Gupta wrote:
> Allow the KVP daemon to log the KVP updates triggered in the VM
> with a new debug flag(-d).
> When the daemon is started with this flag, it logs updates and debug
> information in syslog with loglevel LOG_DEBUG. This information comes
> in handy for debugging issues where the key-value pairs for certain
> pools show mismatch/incorrect values.
> The distro-vendors can further consume these changes and modify the
> respective service files to redirect the logs to specific files as
> needed.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
> Reviewed-by: Dexuan Cui <decui@microsoft.com>

Applied to hyperv-next. I change the prefix a bit to shorten the subject
line.

