Return-Path: <linux-kernel+bounces-737877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C48DB0B178
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 20:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E48163AEA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 18:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A89223302;
	Sat, 19 Jul 2025 18:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RHChGeSK"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911021C54A9
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 18:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752950305; cv=none; b=seiPV9G/PaNpyXYvo7z//hanY5PDOoTSttcG8huHVA8NeQK0bhL177OBAGhx2OwF9XjuptFheYMF2DWESvcuRUGjSLQRHFnxGfBobbDyZFrO4Wi7IOi65NpIeNlba+VU3GXXyV0TIjJzcrlrxIzfEHw27syCTcbFvQXr8lP8x5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752950305; c=relaxed/simple;
	bh=AF3p4dcJEuGWtg0GuYj+jCfsY/ZvAbYUKXbHdJmKvyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrQ1aYtONy5X0xkTbRS2O7nOOljJrEk5JVeSR08djpICWxDYVTGNg6s9phWNTHMBYip1oGFz/vkC7hKIS3tODkKC89qAjaDkL1AjprszPcjGP7gX6BfqaweaI5XU9KeZpCKrVE3bZ0x2Isx+3CAp0PNW0ROD2gOXgHP6Y1pZaZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RHChGeSK; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 19 Jul 2025 14:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752950300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AF3p4dcJEuGWtg0GuYj+jCfsY/ZvAbYUKXbHdJmKvyE=;
	b=RHChGeSKF2M7hKHfmQ5CqF/IWCM3kUkhz1BZ5pC8xiL0Y1G69AB9FiARxKRis7Y8zima6q
	Qo1Vg7NsPWbpfoaysvSLxexznl2413C6bY/F7ccW7g7C/hhhMhSckgqdwi3F5nhqiGeSkJ
	zwNU+6kw5tYGp/wYOW1UB3mT+cWOBDY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+397f6fe952a0defb9424@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_fill_extent (2)
Message-ID: <p337gu4fd36z2ciwwuz46k44h2brymdfmdkmilbft654p44hz6@zpqhai5bubge>
References: <687605ef.050a0220.158d12.0000.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <687605ef.050a0220.158d12.0000.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Fix unhandled key type in fiemap_fill_extent

