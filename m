Return-Path: <linux-kernel+bounces-824113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD322B8826E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0E67189DF41
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF3E2C11F1;
	Fri, 19 Sep 2025 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUdNYidG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E58B270EBC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758266872; cv=none; b=o/XYuCh5iiOqvKDQ5xB6Rd5SFEuPw2fm5E+AVIYCxItHeKqNkI5DXOyv8qsavV/jOXwYRIUxoZkO5gA9y9ZeFDgafTyJApe3Oi2RsF1AytQD5oHH4tv+ZaFS5oyHilc198RQgUgo25GFC7b8SgQL2jUoOjsnoHOxy8RMDHNmwTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758266872; c=relaxed/simple;
	bh=YvEGTDyCymkNc5PTq5aWhwM4Y9NEGr2bhCtP+oNI5l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lp8Q6q7Hr+XK9Qdnmrr3aji4mQkXVrbV6uuBYxAenTwz/ZWzzKNCiY7Zl3yGee6bPbpN+E+2vt2KbwSyg7EXdHY0ZnnjIq0Y9rbIxqWqI2DQD1sqLul5a+8c2Soc41vA+gZVqTf7T6qry9PEv95yjzS0hM2qQo1WfFYZbAyvFTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUdNYidG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8899FC4CEF0;
	Fri, 19 Sep 2025 07:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758266871;
	bh=YvEGTDyCymkNc5PTq5aWhwM4Y9NEGr2bhCtP+oNI5l4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PUdNYidGtZd+Gf2oDNJm1Y+DKX+QRHgaLr2xT+TpvLnqcFb8C5Msiwp4UNg9MzHFh
	 K4+zVCjJkqdFob5skPlEqgTPb6AO3gn/1KGxDfGKRqc/Q0UMqNxiN1myAXJOwGxm8l
	 zM3e+bkFgg2R3AsMcEJX3ioMXLJVht7i2TmqmXDArbFjTllRtRykA97T04bHk3qbqf
	 ct7vMRPj+bpxOnP4u4culALYmvd2h4fxmqtEJyhdMYV2nD3BxQmNq6Xc2fj8WlGBsv
	 TnUuvCjYdVIG+3XKRCpv4QID7T+b7aW9J4PkIvfyNofexW7lt45eSz/Nf8WvI/YPZZ
	 XOixucKcpgIbw==
Date: Fri, 19 Sep 2025 08:27:45 +0100
From: Will Deacon <will@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: catalin.marinas@arm.com, anshuman.khandual@arm.com,
	quic_zhenhuah@quicinc.com, ryan.roberts@arm.com,
	kevin.brodsky@arm.com, yangyicong@hisilicon.com, joey.gouly@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	david@redhat.com, mark.rutland@arm.com, urezki@gmail.com,
	jthoughton@google.com
Subject: Re: [RESEND PATCH v5] arm64: Enable vmalloc-huge with ptdump
Message-ID: <aM0F8U-cW6sh62H-@willie-the-truck>
References: <20250723161827.15802-1-dev.jain@arm.com>
 <aMk8QhkumtEoPVTh@willie-the-truck>
 <aMrXBArFNLTdwWs3@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMrXBArFNLTdwWs3@willie-the-truck>

Dev,

On Wed, Sep 17, 2025 at 04:43:00PM +0100, Will Deacon wrote:
> On Tue, Sep 16, 2025 at 11:30:26AM +0100, Will Deacon wrote:
> > I'm currently trying to put together a litmus test with James (cc'd) so
> > maybe we can help you out with that part.
> 
> Here's what we came up with. There's not a good way to express the IPI
> from kick_all_cpus_sync() but it turns out that the ISB from the TLB
> invalidation is sufficient anyway. Does it make sense to you?

Any comments on the litmus test and/or my question about serialisation
of the static key? I'll be moving the arm64 tree to "fixes only" soon
as far as 6.18 is concerned.

Will

