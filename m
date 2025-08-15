Return-Path: <linux-kernel+bounces-770203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ABAB27869
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626D7AA5F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55962256C81;
	Fri, 15 Aug 2025 05:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhGE6E+J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A891F12F5A5;
	Fri, 15 Aug 2025 05:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235467; cv=none; b=mb4BoITSUOyeQ9jMSXKgbep6/GQau8eQTDWXawAQCQh3OjkfhfUBOM20Blf8Q2cM9cRcjkoLNKyQZaTYSSvMkQEs55tB5s+8wipLZqCSIBE710fJa4XBGrbHlI4Xm2Xk0JllDadtSaMoHFW+CVuV3a0h4LGRPMrDNNMR9bcElAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235467; c=relaxed/simple;
	bh=Pjp7K7C025lM3fgFxcQhJ/BxADo+k1Hy/bOjhJjK2gk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S9JiJ767uS57fYBKcBGt706L9tsTcHQkGbFgnFGHu8tvfZlRp+PaGm3OBMYO7Upx0FzrlIfvXZxf2hgfr0zKJAH9nhNzjeIGdl8lQd12vq0VUY/XKcW/84Qm8bV5XHVCjuRag1wmdBH/3eTzObravuApmK4Va24olyFwm1Y2ZuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhGE6E+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AA5C4CEEB;
	Fri, 15 Aug 2025 05:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755235467;
	bh=Pjp7K7C025lM3fgFxcQhJ/BxADo+k1Hy/bOjhJjK2gk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AhGE6E+JJpzohVkUy5l1jziBG74qVuyF3RA2562fZlDnyOX6vyj97dHU2QXopks5B
	 DmdLAEawZGyXgTXQB1Bhf3B82Qc5c56GmxUO0JNfUlog4gPj3aOghxZ+Qf9Rv/o03+
	 B13x98IKfHrNmtcgI2svKV5b16D5Xen/fePdYSC/jkXpEAENFZv+vQRcSO7fv4JF/8
	 0izY3qSLRkFxXUqCWicpUet4d/7jZZNCz5vYI6I9zIJe7eiRAkLgB4j7Bl3Wt2deZI
	 oLErdgCSPP2QynpK3FMpwdTkx8meVHj3bbArYbZx6riuD6/ZfpO6PIsarhdCE067hV
	 WaOI657QI/JCw==
Date: Fri, 15 Aug 2025 07:24:23 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH v2 0/7]
Message-ID: <20250815072423.4c7477b8@foz.lan>
In-Reply-To: <20250814154035.328769-1-corbet@lwn.net>
References: <20250814154035.328769-1-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 14 Aug 2025 09:40:28 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> docs: kdoc: tidy up create_parameter_list() somewhat
> 
> A relatively brief series to straighten up the code in
> create_parameter_list(), remove unneeded operations, and add a few
> comments.  No changes to the generated output.
> 
> Changes since v1:
> 
> - Put split regexes onto multiple lines for improved readability
> - Simplify one overly complex regex
> - Improve the patch 5 changelog
> 
> Mauro, I've added your tags from the first round - scream if that's not
> what you wanted!

Good enough for me. IMO the series is ready to be merged.

Thanks,
Mauro

