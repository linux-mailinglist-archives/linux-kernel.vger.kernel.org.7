Return-Path: <linux-kernel+bounces-772020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC380B28DED
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1D9581592
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A622D1900;
	Sat, 16 Aug 2025 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SE1+Wdf+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7651628D84F
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755348473; cv=none; b=Z3nNDCXqzkfT9ERXOMQdunx551TzRUiqlZCXJIJ6YNft78PCq2riyrGVmmI7G65KY9L8HzAjKeVa3fI71ytdo0Gv1UI9p0YpmjNJPtS8wPxgq+sNVWWKfhzwsx3hOOSrxYu1XxyqaMuRbN/XJOx9wLVXTBAQIslWCCTDQg75nD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755348473; c=relaxed/simple;
	bh=WxO29k33UTWUeR3N+rlkqqLeQh/MtXv0aq0+XhZFl/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWC3OUQb+pK2GPXGnChrr2Bi5hJiMB+YUhd0Vx9y7G1uj2ceb/DpypPGYt/nIv7wTmflhV+WMECk9bnpehdrW65EPVyWz0Ytw8zgD/drAuKzTMqFR50pa8l2imaW26rZofNqOHv+zpaLeNYAjKVYjiDIGKDLGxTgsz056FoK9G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SE1+Wdf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961D7C4CEEF;
	Sat, 16 Aug 2025 12:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755348473;
	bh=WxO29k33UTWUeR3N+rlkqqLeQh/MtXv0aq0+XhZFl/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SE1+Wdf+wu+ojHcSZtbyy2qNlPuRDX7DPxvBgccncc+pxntX9w3SvmpUkcfD7E/Fl
	 4S3cDTDZoLYbRNERpnN2uycjM3X/mNR8UNZFoUdbKs1eUQ23lI/3I9Qrj0RGCld44R
	 Tz9TD3P2ckyEBl2e+mTihsvDNTLbnMbDVoEJc5lc=
Date: Sat, 16 Aug 2025 14:47:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: RFE: Make ANDROID_BINDER_IPC tristate
Message-ID: <2025081642-viewpoint-exemption-006f@gregkh>
References: <DC3UBQJQJ2SN.3B2AJHOP3933Z@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC3UBQJQJ2SN.3B2AJHOP3933Z@cknow.org>

On Sat, Aug 16, 2025 at 02:11:24PM +0200, Diederik de Haas wrote:
> Hi,
> 
> Programs like Waydroid allows people to run Android in a Linux container
> but it needs ANDROID_BINDER_IPC to do that.
> It would be really helpful if ANDROID_BINDER_IPC could be dynamically
> loaded when someone wants to use Waydroid (and unload when no longer
> needed). But currently ANDROID_BINDER_IPC is a 'bool' so either you have
> it at all times or you will never have it.
> 
> So hereby the request to make ANDROID_BINDER_IPC tristate so people that
> want to use it can load it when needed.
> 
> Debian has a patch to make it tristate since 2018, but it would be so
> much more useful to have it tristate upstream.

Please submit a patch to do so!

