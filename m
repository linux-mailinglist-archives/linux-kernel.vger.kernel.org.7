Return-Path: <linux-kernel+bounces-858759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EB5BEBC89
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 23:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082B319C8107
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E92029E0FD;
	Fri, 17 Oct 2025 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEyHlQor"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29D826C3A2;
	Fri, 17 Oct 2025 21:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760735384; cv=none; b=XerCiK44EGQrfQnU4LFufd2qSXl5PowM/8/LuFpk+1i3Kw40CQ/lbROW6kAtHeYpu0voVWsG8pZznQ3f+2YYQWkLhCsZtJcR0GXCHu85zVQS3ucsEt1j3xXBL1uDvrY/8ZP0AHUsUDYq/jNG9M7QWQ4BJU06YFS7OdusakU1UI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760735384; c=relaxed/simple;
	bh=MUDqIKKwpcOalbVlQw7f73/p4pZFhDngV44KpR8dpfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJJ5g8ih/b/ZosdY1S/1UiwN3C7bMhhAyqYcir6VgDufLckHCTjcPCkIhRWQSUCWBz2mCZb0HxRRvxXVoLaEkTI/8uYspl7MUlEQh38cRXazyGAnb0g24A/g94hJ1TroFKNuR7ODCgfbxXGTPIgynFGOYxpYfICHyCqG/e4SKBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEyHlQor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55466C4CEE7;
	Fri, 17 Oct 2025 21:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760735384;
	bh=MUDqIKKwpcOalbVlQw7f73/p4pZFhDngV44KpR8dpfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VEyHlQorZmITIIWwk6iqv0GuasGrI+LDJ5pg+L/2YAIHFyhkwgzxleKIZIm2i5gHA
	 Y1AHjwN6+4Kq8EHXRTUChQor5snqBFfdwfwA38JSHJLHS/TRVeDtxwRGOPYENStW2U
	 8YvjdGpCvRzBPTQiiQTAaJCtVjd0Zc0YldqalC97ZEa9ZwrUQeXRWR7uI8jQoOXEEc
	 uIyF1sBniLLo9ptiQgdRxBWE/jzXjs7/Grd1mFLbfJgQM05YJY9esfLoEdAe9nsqgQ
	 S1kJIOmw9f10DSYgMQslfqaC3yCx9Zch2VfFRcBcioGkaDSp+w4JT/iGz5CvMRF4i/
	 WKVcx5yIXdrJA==
Date: Fri, 17 Oct 2025 23:09:39 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Brian Masney <bmasney@redhat.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Maxime Ripard <mripard@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH RESEND] i2c: busses: bcm2835: convert from round_rate()
 to determine_rate()
Message-ID: <hf3zdgvdwkyaubicndcejmioqjqhlko4ypnderd7viobiyjtua@ozxt2adok2j7>
References: <20251016-i2c-round-rate-resend-v1-1-96dd1d725e8f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-i2c-round-rate-resend-v1-1-96dd1d725e8f@redhat.com>

Hi,

On Thu, Oct 16, 2025 at 12:08:12PM -0400, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate().
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>

I'm sorry for the late response on this. Merged into
i2c/i2c-host.

Thanks,
Andi

