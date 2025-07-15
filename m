Return-Path: <linux-kernel+bounces-731829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E30B05A63
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EE3F7AFC5F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C922E040D;
	Tue, 15 Jul 2025 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ta6Ybp+5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FDC1EDA09;
	Tue, 15 Jul 2025 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583105; cv=none; b=syYFKoORxZoQyZ+3XMx1iVtUCqh9om53zQOJnWX5OqkHiT6KZw5Cl+4fLEbzr71YfUTW4DObwhL+k7/tudvnLGPdlqMMCeClnrBD+frBAShiYQrjIwxiDoCHWwnGRr+S5bLt+BO9hjGfxWQYYBo1QqKl9r8OA768iMx3oQYsizE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583105; c=relaxed/simple;
	bh=gMdl43/0bMuiZDFZdXVaO2ZI3Rf0NtBZ9KAPxIt6tNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TK16BQZWWynGD4kTqS4wokKo3VMlgblgxCKOVWss+zCwQhraUQy8NUDhgvflhUFpkPXB0cu+N1NyJMB96yZIVuLArCiNQRfKDP/B1VF329R2UG1nlvtWfxDeyjIoX+4vmC4vsX4ZFq5drFhwSsHPjreBvv1RkkpOBs17PFotlKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ta6Ybp+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D421C4CEE3;
	Tue, 15 Jul 2025 12:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752583105;
	bh=gMdl43/0bMuiZDFZdXVaO2ZI3Rf0NtBZ9KAPxIt6tNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ta6Ybp+5ZGZoiwIBSSjQQyLrXmiGjzZJFt4ku+MWt3JHYPaR1L/VuwDJUhkoazfvI
	 OtRkxFOAc5xQeUgBZY4VTsF7o4I95UfO/5HwfWQ9huaLnKyKgj6V7j/b+AIvZiSfAs
	 XPUBUC3No8i9wZiW5lPqwKq3HyHR8+6I+D/0siuODGLllyMLcPX/e7jLdYS+eV572f
	 o1fnowKHCk+9gp5FkmNbRGWAJyR4q8j7HYPn++3UwoUMxOXY3V443Ynq541bujK+Ne
	 dhOxmfOwn8L795bpGYslwf8sM5xdxAqfZgoCtmbE99tDWV43VBkixuBiVXn40KhfNP
	 IIMrBHsPyXWew==
Date: Tue, 15 Jul 2025 18:08:21 +0530
From: Vinod Koul <vkoul@kernel.org>
To: George Verhaegen <verhaegen@google.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Srinivas Kandagatla <srini@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, kernel-team@android.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com, linux-arm-msm@vger.kernel.org,
	sound-open-firmware@alsa-project.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 0/4] ALSA: compress_offload: Add 64-bit safe timestamp
 API
Message-ID: <aHZLvVnNiBcqXdXG@vaman>
References: <20250711082441.4193295-1-verhaegen@google.com>
 <aHEEu1eSSGRhITmW@vaman>
 <CAAntYmKea1p=ao3OOWb=1Q+BXdyo1SCm9qGb_JMC5ry5DQVt-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAntYmKea1p=ao3OOWb=1Q+BXdyo1SCm9qGb_JMC5ry5DQVt-Q@mail.gmail.com>

On 11-07-25, 14:58, George Verhaegen wrote:
> On Fri, 11 Jul 2025 at 13:34, Vinod Koul <vkoul@kernel.org> wrote:

> > Please share patches for tinycompress support too, we need those to test
> > this
> 
> I didn't make changes to tinycompress. The overflow happens in the
> kernel file compress_offload.c. As a test, I let it run for more than
> 3.1 hours and observed that the overflow no longer occurs.
> The overflow is in
> stream->runtime->total_bytes_transferred = tstamp->copied_total

You need to add support for new ioctl in tinycompress too

-- 
~Vinod

