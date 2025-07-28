Return-Path: <linux-kernel+bounces-747847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F56FB1390F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E431749B5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795B7246BD7;
	Mon, 28 Jul 2025 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cl0Aap7f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8A8226520;
	Mon, 28 Jul 2025 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753699036; cv=none; b=Ouc5A+8ltIwDX5s/xTypRaauov5vEoNiyKrbGSZZXfgJLBiMw2fmQcZPp6JTKczGDir9B+orNVIPYzb9gpP5F+fHSJwK820nLCHxe5JwmTsh8E7f0ExgiJA3Y90hW8NQRQOVzA9p8iKl7mJglf13nacx5Z+I55E1UCjnx0i9T2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753699036; c=relaxed/simple;
	bh=3ZuJcB18Y6mCPbtHnn6ZE5KHrE88WwQpU4n3sZtPNwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gi0KJRIANG8tN7KB+lf1kYZB3MTpTypi50OKFSRDZz/QpnoL2mMuq2zsz+8hvrmjWmnsPEBxNXismRsx8qgdxb7SZw6r1zGTMue9FMPjKCkLSdb2yQSiZ1c7PdaJPrKVO07H7hw56uJ1J/CyDKO6ddt9ml9j+8Vx9jzbsEtDh9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cl0Aap7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBE3C4CEE7;
	Mon, 28 Jul 2025 10:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753699034;
	bh=3ZuJcB18Y6mCPbtHnn6ZE5KHrE88WwQpU4n3sZtPNwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cl0Aap7fr/lqvF9GTIlUE8Zsfll71hC1awDPqNZFbECWkSAAHiDe5NWbB3AJ0akEx
	 7WAXKobhPIWRleHOpeurvL3qeoJakw51U/Hku2Xg7xLeVoGQOLmbzWx/UfIIw2MsrS
	 ziv9hr5OWgLSjqOU5LN0IxY9LN9W44O+5hXV/bkg=
Date: Mon, 28 Jul 2025 12:37:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Sasha Levin <sashal@kernel.org>,
	corbet@lwn.net, linux-doc@vger.kernel.org,
	workflows@vger.kernel.org, josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <2025072832-enrich-pampers-54b9@gregkh>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <75d86e96-cb18-4996-998c-da7ac0e97468@suse.cz>
 <9afd157a-296d-4f4d-9d65-07b89ab3906f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9afd157a-296d-4f4d-9d65-07b89ab3906f@redhat.com>

On Mon, Jul 28, 2025 at 11:27:48AM +0200, David Hildenbrand wrote:
> This must not be the new mechanism to DoS kernel maintainers with AI slop.

I will note that we are already getting this kind of "slop" today, with
the numbers going up on a weekly basis.  Be lucky if you haven't seen it
in your subsystem yet...

thanks,

greg k-h

