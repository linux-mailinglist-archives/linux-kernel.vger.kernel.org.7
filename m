Return-Path: <linux-kernel+bounces-896764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7A5C512AB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2526A349A69
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3152FD679;
	Wed, 12 Nov 2025 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1TD7s1u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76917165F1A;
	Wed, 12 Nov 2025 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937185; cv=none; b=IIJ14xUkMU/A+msPoo9e2EccdnjHmPGDYsO4NjiPzxWVkAeXEM83d4mayebSr1Yh7VddXMl0sEhVRgtPsG3j5ylSCmKWRRIwjfwkZIHCPb4Q1eYW/gmARx3Tv9e1OTSNMvl02VnCMQzcwMtvUjXxDKQ2OCrE/3+FEs/TmrFL/Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937185; c=relaxed/simple;
	bh=KEZXM4zUZZ3RBNrVZmQebqOCHnjRNcJH7W78DGS6xDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svZdirmQHJzXRRoil/fesakCtnvX6/aK0NQE5NORRSQnFmWxyRFf+OuEJWfg4/YA97t/sVr8Rc0wka4LUXrTYuq5b9SX8iFU+EoZgrasB32137Y5W7FRO89Yesh2WpGIPYkP+JmlTPuDejdu+OXXheBz6KLvV9bSNDgTp4oJ0lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1TD7s1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D046FC4CEF7;
	Wed, 12 Nov 2025 08:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762937185;
	bh=KEZXM4zUZZ3RBNrVZmQebqOCHnjRNcJH7W78DGS6xDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a1TD7s1uEEYWU9iBtDDai5z9Bcw8w+/nXf+AUsRtJ79nbmsZmTqtvPipyDzxGyAFe
	 XBiJUim/bdhVf6mGXmFaYmbZI2gcuWmU7HVVtkKqGnGyeqsLea3eBks+LFK2WWa2ro
	 h/7EJgy6C8dSKYj9z9Wrc89blaVkEKaXGiUm15PXqlopj2dBNoRfE0trrvMWd6t+rx
	 HpBRM/I2RdJ4Iyt/2Z9ydj98Ry+zeZlygjEPQijnkqyPBorE6W4s9mhP440bRXEMYy
	 YFV+QlaxQeRoYv8o0wkA8AB7xcK5Ctugbs3lUz6je6wm5bFeQBC6OfNuM1OHefbDdp
	 Lf9DQCK8GXTVA==
Date: Wed, 12 Nov 2025 14:16:21 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "Liao, Bard" <yung-chuan.liao@linux.intel.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev, bard.liao@intel.com
Subject: Re: [PATCH 0/3] soundwire: send multi sections in one BPT stream
Message-ID: <aRRJXZz5KX4eufmC@vaman>
References: <20251021094355.132943-1-yung-chuan.liao@linux.intel.com>
 <aRQXWpLqDm8EduYN@vaman>
 <679f8b6d-727e-44b2-abd8-714dffc35228@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <679f8b6d-727e-44b2-abd8-714dffc35228@linux.intel.com>

On 12-11-25, 14:13, Liao, Bard wrote:
> 
> 
> On 11/12/2025 1:12 PM, Vinod Koul wrote:
> > On 21-10-25, 17:43, Bard Liao wrote:
> >> Currently we send a BRA message with a start address with continuous
> >> registers in a BPT stream. However, a codec may need to write different
> >> register sections shortly. It makes more sense to send different
> >> register sections in a BPT stream and no need to close/open the BPT
> >> stream repeatedly.
> >>
> >> This series depends on the "ASoC/soundwire: add fake BPT frame to align
> >> Intel DMA buffer size" series. Sending it now to get more review time.
> > 
> > I have applied it on top of above series, pls check why it is not
> > applying in :
> > error: patch failed: drivers/soundwire/intel_ace2x.c:156
> > error: drivers/soundwire/intel_ace2x.c: patch does not apply
> > 
> 
> Hi Vinod,
> 
> I just tried "git am" this series again and it can apply on top of
> 04878e873d94 ("ASoC/soundwire: add fake BPT frame to align Intel DMA
> buffer size").
> Also, I checked drivers/soundwire/intel_ace2x.c line 156 and it has the
> same content as the "soundwire: introduce BPT section" patch.
> Sorry, I have no idea why it didn't apply. Could you please try again?

Yeah I fixed the commit base and it worked, thanks

-- 
~Vinod

