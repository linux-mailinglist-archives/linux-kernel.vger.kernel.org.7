Return-Path: <linux-kernel+bounces-734334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B638B0803F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 00:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2DC56634C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BBB2EE5F2;
	Wed, 16 Jul 2025 22:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KD48eNbH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EDEEACE;
	Wed, 16 Jul 2025 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703876; cv=none; b=Eiaa6jC5vz0/5XnYMAignQdwa2Fmz9fgz29GKPLVv1S5gsroAjFBOyCUQY3wCnz3vXngzsKomxJbdUi2ETttyl7B7oOay4yGDF2kO255f7Mj5icYeqiDj3mJWOqBaelrpfDybduXs2IvsSiWJf2JuyRe+fF/+xxhoB55hI/OmYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703876; c=relaxed/simple;
	bh=3SDH+1+pSijYEYf7NFSfZ/Q8NeDVbaPqts/KRkGfBXk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3pAbuzfPDoKAIQRPCYvupBO5smv9XCXFGylOb1AX7JZqyHiN9gem2EsqzflAtEF0aAUt+AGxecsi6LI6s6SQzBy+R8D/gYMR2JXNJdGV8XHxueQOxCGyrSZzHQoo5pd5ryNKjkfM5OxQFpuYfBbZIIicz/h9y8aKnmokP8+Uog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KD48eNbH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E117BC4CEE7;
	Wed, 16 Jul 2025 22:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752703876;
	bh=3SDH+1+pSijYEYf7NFSfZ/Q8NeDVbaPqts/KRkGfBXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KD48eNbHtItduaOjS4jwO/GrUphFrUvE5D4o6EY/YFmwp4S47g9Vl7RJ0bOUYKcZ+
	 YnF8inhdu+Mz4A46NY+3Bvmo2Xslc3fw/swcv7HsUQEk0fWbl9555yinbqv9YgGZrb
	 M3tx9p57V/p8SPfdHxZs1BKzw66yUtx3F8MrljMs7xXrmJSEqUN98S1k4oaNKs9sRb
	 VQkuGQ7TwD6+fsBCAmglabEgyGsA7qwQa057xagtnqLUOUSgu2z0sV2dwiVJI00h36
	 oSshTxiVoq0UWzcJ9CEVdsrA59hqZUgiEBfl01CJ8hB1lPdvhIaxgj8lQ5C1IxNM28
	 1jCBP251uwZjQ==
Date: Wed, 16 Jul 2025 15:11:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: Remove duplicate assignments for
 net->pcpu_stat_type
Message-ID: <20250716151115.0ef44776@kernel.org>
In-Reply-To: <20250716001524.168110-2-qiang.zhang@linux.dev>
References: <20250716001524.168110-1-qiang.zhang@linux.dev>
	<20250716001524.168110-2-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Jul 2025 08:15:24 +0800 Zqiang wrote:
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Your email address seems to suggest the latin spelling of your name
should be Qiang Zhang. Please use that instead of Zqiang?
-- 
pw-bot: cr

