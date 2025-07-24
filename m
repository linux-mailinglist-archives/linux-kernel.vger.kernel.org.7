Return-Path: <linux-kernel+bounces-744064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F06A2B10799
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B36E27B23E9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541F9262FDC;
	Thu, 24 Jul 2025 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qq2ELFR8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73B82367D0
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753352431; cv=none; b=ojAHjqAsf/2fNXC0rWJSf99l2ewjoL3m+N2EKgbOHFtsp20sEdI81gGCGCUFPlOyjOEcjIn1GsObb1HG9L5EOWCxNi9sKvCkW/HUB5JrmtP1w4v0EUKiKFQgMedX7FLz9LTyjBDRrCdCN8Ef8NimrDWyGLF8bvyto6J0lfzACa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753352431; c=relaxed/simple;
	bh=5+gY8DXBBGj50Rlph9ha2cxAdbcRjVO9FLuKdrkGcD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UG7c/a5LqTu/+raJe3vP+ndLsdZ2yVJI2uGB9fMm2z4YQXBsTyefiIDyNAd0D3u3RvHZLbdB11fx9j2RHOSOA607zbhhuPiPuGr8u9eIZGgA+kw0eKFJDPfP9Cf9qZwtMrmcKtPIc5AhsMw/Crwoiv9WN+sRMJop46ZKqm18srE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qq2ELFR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07741C4CEED;
	Thu, 24 Jul 2025 10:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753352431;
	bh=5+gY8DXBBGj50Rlph9ha2cxAdbcRjVO9FLuKdrkGcD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qq2ELFR8/+O8+2xa6y3h8+OLQk74cHf0Tj3rHJJ0jPDf+YF8Z6LO86tSRZcbnGWbg
	 9eVlT7vbkHfRwkgcA9ogd3gHj6sOrjagQkKrF+LgTS8/KLIvM4eX2624ZWz2K5HSB1
	 zlX1nl6ebhzGClAyockx/9Qahc7WFj6iH2ps+k+iW2s/ZGa4R/UzJ/Z8cxsUEfqJct
	 y3KRJ3lknGZMpBbTi2+ytDlSILl82dY5ynOAUoWYszKcdcxIa5bjAZLGzurwxjLRLo
	 6xxExSW76BJ2QVEd2OuiT2tuWUAHPIbbFlh7sQ1tNYfnXFBDZg2tonpxl0rX7cHB4n
	 Uusz+i9IahVUg==
Date: Thu, 24 Jul 2025 12:20:28 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v8 2/7] timers: Add the available mask in timer migration
Message-ID: <aIII7MXdqdXMOcQt@localhost.localdomain>
References: <20250714133050.193108-9-gmonaco@redhat.com>
 <20250714133050.193108-11-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250714133050.193108-11-gmonaco@redhat.com>

Le Mon, Jul 14, 2025 at 03:30:53PM +0200, Gabriele Monaco a écrit :
> Keep track of the CPUs available for timer migration in a cpumask. This
> prepares the ground to generalise the concept of unavailable CPUs.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

