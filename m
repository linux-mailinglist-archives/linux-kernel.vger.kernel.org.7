Return-Path: <linux-kernel+bounces-799133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF36B42776
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76628684925
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F2D2FD1C2;
	Wed,  3 Sep 2025 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WX5jujSj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7102F23AB8B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918857; cv=none; b=FTmdSaFjBMZ5SZTohCanz5wiQMo4r/dlTJ6VDtrtDsjyhqzdEiS6QkdNUV0wlFVYC83BabZR9k6/1zWkcOLl7KHErzg53EKkLwDt4PxXChtIXzeeS/Oljy/0UMg2nJ02GgkMO41w9zbpL979QAU86J9HBTwthy01VNrmcbY5e5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918857; c=relaxed/simple;
	bh=ADM/h/8et+6bJvbuj7C7JBlo51axN+17zc8+HqvWRNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0e6iA86B2gFiRka8XWcPKt5ewCQkZaHggpOtiyi42L6XTqCtyS4raLNxwaxyJrPNDqO5e712uGSqEuGlhPJJ3QsdN0Hgl3euUoPsKphWzBZIcsGzPMY/ShWqI1ohLYHcZ/1GpkOxvBPFwY7Tjf0pjbe6R20EJrWsB4P1UuX9xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WX5jujSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D319AC4CEE7;
	Wed,  3 Sep 2025 17:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756918857;
	bh=ADM/h/8et+6bJvbuj7C7JBlo51axN+17zc8+HqvWRNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WX5jujSjejWYeaKtXje+yp//6bKp9hoKnPUcTcITkx68Nm1Jo6I/2guVmntXALs+Z
	 HcxuvWgaHOQx4rV+/9zrm1QDTkMKK+C+QVZATyypwvkJqbS3Y7XolQ88DXuCajrEoJ
	 rkOMapurU+Ngz/Rtbv0Bh2oxuxFogSmOj9LwuBPbGdXm6HB20IpRDyYfk58K7YOdJf
	 R5u5M60b4zuVRj7cT340d4DY3qBYFAeahuMEuInb9Mc3g3nenUwyoqSqQ8Ic/bFNUQ
	 A4x2UqVg0mpbRsnzf7q7hKO3PG7nTQ3M4q4NAjtWlTOHXfvcA+SnJYwToTvb04+l9p
	 eWRIoj3SJb/wQ==
Date: Wed, 3 Sep 2025 07:00:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: void@manifault.com, multics69@gmail.com, linux-kernel@vger.kernel.org,
	sched-ext@meta.com
Subject: Re: [PATCH 3/4] sched_ext: Move internal type and accessor
 definitions to ext_internal.h
Message-ID: <aLh0SAkBdIlGVLTU@slm.duckdns.org>
References: <20250902234817.279206-1-tj@kernel.org>
 <20250902234817.279206-4-tj@kernel.org>
 <aLgZPcwe9UFXw7rb@gpd4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLgZPcwe9UFXw7rb@gpd4>

Hello,

On Wed, Sep 03, 2025 at 12:32:29PM +0200, Andrea Righi wrote:
> On Tue, Sep 02, 2025 at 01:48:05PM -1000, Tejun Heo wrote:
> > There currently isn't a place to place SCX-internal types and accessors to
> > be shared between ext.c and ext_idle.c. Create kernel/sched/ext_internal.h
> > and move internal type and accessor definitions there. This trims ext.c a
> > bit and makes future additions easier. Pure code reorganization. No
> > functional changes.
> 
> Having sched_ext_ops and scx_*_flags defined in ext_internal.h feels a
> bit counterintuitive, sched_ext_ops also includes the documentation for all
> the scx callbacks. How about moving these to ext.h and everything else in
> ext_internal.h?

Hmm... so, _internal headers are for things which aren't interesting to
other subsystems in the kernel. ie. internal to this particular subsystem,
which is the case here. I understand that _internal may be counter-intuitive
if the reader isn't working in the kernel tree, but am not sure that's a
primary concern in naming source files.

Thanks.

-- 
tejun

