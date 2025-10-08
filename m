Return-Path: <linux-kernel+bounces-845545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3C3BC5541
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47C374E9EEC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6AC288C21;
	Wed,  8 Oct 2025 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btLyQNEB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B604D284670;
	Wed,  8 Oct 2025 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931864; cv=none; b=l5cKUjwQ57gC7lnSJIf2yu94GceKNsT+njoqSsxMLPSnYDmynyakYHZtIQ4bAQ/xCMhfAJ2A7hAihiPN4hjt2JlySE6Xqgq6uurGNbr5MzSg246cX1Ix9sKDlO1H5cGLKbWpqxydVMha2U87ZVh8V1uWwNk2kC0/R/1yknjiVdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931864; c=relaxed/simple;
	bh=3xT85CT/P1jeGTZY3huEJ5JRccxDMFaCN0SMPtXlL6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixckSFRSMsIr1nfJGl+cX0a9FmfUWZSQVJG4AOfgYup49byf6maLjG8uI6azBSlhNggG11vhgFgqInMHTfxsZ8f2tTFuo+EpEt+dseD0HTMFAFwhGkt3NiqSlTGAyVaQje6gvLfLCAGYTMA1hQ4j2BO7Ehpw6eTlbZpUZ7BjFp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btLyQNEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD01EC4CEE7;
	Wed,  8 Oct 2025 13:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759931864;
	bh=3xT85CT/P1jeGTZY3huEJ5JRccxDMFaCN0SMPtXlL6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btLyQNEBjY5F1ulKVbtXT+e7r8PeA3SG/SPfwT8Qz9QmGqlRzClVoeuktL6vhHqSH
	 MjaW38Qh58m6qKnBBqkZa5xal1kLNvzVjXp5RtF8ij5z9/Rd9eXL5Ia4+j+f0IQGEK
	 DJAontqMzliW40srMf7YsO7EaMtOUW7p7ocG2Jo5uYrTn/K97TI321G/4GUqBIi2KT
	 lla3lM7v2FvnBt/gkTKn0E49isfaRjf/sQ8n7k2wMVxcP18V4Th1I4+YlyGRJ42gMy
	 fY6tp0AqzXResdFCnmHzJpfwbaZLV+Xk8utzc9KZkI0r2p6Wa9lCN0ps0wvVsuI1Da
	 qsJacXp07UpKQ==
Date: Wed, 8 Oct 2025 14:57:39 +0100
From: Lee Jones <lee@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Janne Grunau <j@jannau.net>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	LKML <linux-kernel@vger.kernel.org>, Neal Gompa <neal@gompa.dev>,
	Sven Peter <sven@kernel.org>
Subject: Re: mfd: macsmc: Initialize mutex
Message-ID: <20251008135739.GX8757@google.com>
References: <20250925-macsmc-mutex_init-v1-1-416e9e644735@jannau.net>
 <1bc9a4b3-7a8d-4bcf-9481-36fdc76e066c@web.de>
 <20251001095505.GP8757@google.com>
 <0acf13d6-d63b-4079-93ba-d53910e624d7@web.de>
 <20251001124825.GR8757@google.com>
 <a3b93cc1-0c0f-4aa7-9b08-b3821ce8e70e@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3b93cc1-0c0f-4aa7-9b08-b3821ce8e70e@web.de>

On Wed, 01 Oct 2025, Markus Elfring wrote:

> >>>>> Struct apple_smc's mutex was not initialized before use. Surprisingly
> >>>>> this only resulted in occasional NULL pointer dereferences in
> >>>>> apple_smc_read() calls from the probe() functions of sub devices.
> …> However, you must also provide your own context.
> 
> Do you try to support the creation of improved change descriptions?

Not to -pedantic levels, no.

-- 
Lee Jones [李琼斯]

