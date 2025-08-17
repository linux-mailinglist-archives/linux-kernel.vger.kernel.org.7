Return-Path: <linux-kernel+bounces-772450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086BAB292CC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 13:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3CD3AFEA9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 11:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5FD2882A2;
	Sun, 17 Aug 2025 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="byWSvTKD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBD02080C8
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 11:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755429148; cv=none; b=JUQYDsAEAqrDSoA+4cfV7v0CA5llREoapwMKidVPmW237AT698JT7HSXcFN4TT4uCzQLkhj9UC+rNISHf09L6yRuR5IssiA+jEZCgFi0JXU/83YHpNy9AIzbCHGG6HG41KyzBFLgUaZn7g9DeCCfSbVdX4cux9rwDGJznRi5yTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755429148; c=relaxed/simple;
	bh=9LykHiLdx3/jrL6y9eVLfJS7LgaVLBDG1kagV8RG9w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWX/HFOFTfAtvAAaKIs72kaCe39hngfCEXCelhe5tsoIWE8010pU1P0AtUvY/7AoK1tRCgoOI/wVgPytoMAWnXoOMYLF4nUi+8/udzwOozzskfd8LFnOyUwsQLb/a+uJKbSORwgBBcCTNkRM+YG/qvlDKy8x3+L1vOqLGZ+22ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=byWSvTKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E8FC4CEEB;
	Sun, 17 Aug 2025 11:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755429147;
	bh=9LykHiLdx3/jrL6y9eVLfJS7LgaVLBDG1kagV8RG9w4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=byWSvTKDoLrj7s4jBUyachbaaty7uaHhwAfjdFORiZM0M3OefOCn1FcRFPP1C+rpC
	 Gruv+Ttl4MAyMDsU8GsoSvwxnhV8yK6lCdf3o0C/SkGhAhNeJRB6ZC7G0jm8Krs88n
	 6ZI3yfZftHshYgQbAQUWwK5H7fQm7lChMrl+Cb4M=
Date: Sun, 17 Aug 2025 13:12:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Cc: gshahrouzi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: fix maximum TX packet length check
Message-ID: <2025081755-actress-flogging-4261@gregkh>
References: <20250802205943.958071-1-ovidiu.panait.oss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250802205943.958071-1-ovidiu.panait.oss@gmail.com>

On Sat, Aug 02, 2025 at 11:59:43PM +0300, Ovidiu Panait wrote:
> Since commit 2ca34b508774 ("staging: axis-fifo: Correct handling of
> tx_fifo_depth for size validation"), write() operations with packets
> larger than 'tx_fifo_depth - 4' words are no longer rejected with -EINVAL.
> 
> Fortunately, the packets are not actually getting transmitted to hardware,
> otherwise they would be raising a 'Transmit Packet Overrun Error'
> interrupt, which requires a reset of the TX circuit to recover from.
> 
> Instead, the request times out inside wait_event_interruptible_timeout()
> and always returns -EAGAIN, since the wake up condition can never be true
> for these packets. But still, they unnecessarily block other tasks from
> writing to the FIFO and the EAGAIN return code signals userspace to retry
> the write() call, even though it will always fail and time out.
> 
> According to the AXI4-Stream FIFO reference manual (PG080), the maximum
> valid packet length is 'tx_fifo_depth - 4' words, so attempting to send
> larger packets is invalid and should not be happening in the first place:
> 
> > The maximum packet that can be transmitted is limited by the size of
> > the FIFO, which is (C_TX_FIFO_DEPTH–4)*(data interface width/8) bytes.
> 
> Therefore, bring back the old behavior and outright reject packets larger
> than 'tx_fifo_depth - 4' with -EINVAL. Add a comment to explain why the
> check is necessary. The dev_err() message was removed to avoid cluttering
> the dmesg log if an invalid packet is received from userspace.
> 
> Fixes: 2ca34b508774 ("staging: axis-fifo: Correct handling of tx_fifo_depth for size validation")
> Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>

Any specific reason you didn't cc: the staging list?  Or add cc: stable
to this commit?

thanks,

greg k-h

