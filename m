Return-Path: <linux-kernel+bounces-851840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 032F6BD76A4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50FD41889704
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECA12951B3;
	Tue, 14 Oct 2025 05:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2vcQ48re"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C871D90DF;
	Tue, 14 Oct 2025 05:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760419605; cv=none; b=F6oZKpJElfdstehmS0TF5eUVLGCIHkR7/xGuaeNnXXlNVc7VS5KNwYqvY+9fpUbtTfIK8yd6O8T2lSztrNmbjAdOdAUIjWqAGLCirlkUO3BYH5ffNGr1Fj10Efc5E0x2ZOaJTmouQIasZRsGRml0qOCuNQTgCSuDzaVQPSkkFO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760419605; c=relaxed/simple;
	bh=xRxNYi2KzUftFZSDYbJ0VLjSrE10iosicJFnyTcMp80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwjKLu+ic3p5j+pCz8gL4L4bbJ9Gk/y5FuyGIYI2RU0qOH9uFXE/yHB/ApVlHHiezcI9tcZvdC8emrG5AIndSMKTBKQHOJaiZFkQTErkl5wy/KURfu98Np19284FVKN7CtuC3KQIYJi0NgVfXcpW2MEQ0ZN1zj2Z1/q4m8BldXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2vcQ48re; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9617EC4CEE7;
	Tue, 14 Oct 2025 05:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760419605;
	bh=xRxNYi2KzUftFZSDYbJ0VLjSrE10iosicJFnyTcMp80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2vcQ48re5n9Cj7S9G3im49vRU6aTQWT3x4CIke2elH5SFRrqxbpf9MNVZv4Aa8RNO
	 ZmtHOAer1JM6jAnM+qVfeq5tUQcOavP16tW7VJXDntGPpAimML0NC7htjae7RPEhKY
	 jQer6BZwNrLm4tgT+C3bxwNtjj5M6spOeLpLOiKs=
Date: Tue, 14 Oct 2025 07:26:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiaming Zhang <r772577952@gmail.com>
Cc: broonie@kernel.org, cryolitia@uniontech.com,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	perex@perex.cz, pierre-louis.bossart@linux.dev,
	quic_wcheng@quicinc.com, syzkaller@googlegroups.com, tiwai@suse.com
Subject: Re: [PATCH] ALSA: usb-audio: Fix NULL pointer deference in
 try_to_register_card
Message-ID: <2025101453-backboned-shine-17b8@gregkh>
References: <2025101225-lisp-monkhood-af34@gregkh>
 <20251014040149.1031348-1-r772577952@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014040149.1031348-1-r772577952@gmail.com>

On Tue, Oct 14, 2025 at 12:01:49PM +0800, Jiaming Zhang wrote:
> Hi Greg,
> 
> Thanks for the guidance. You're right, the root cause of this issue is
> that a USB audio device is created without a proper interface.
> 
> To fix this issue, I added a check for the NULL return value in
> try_to_register_card() before calling usb_interface_claimed().
> I have tested patch with the reproducer on the latest version (v6.18-rc1),
> the issue was not triggered again.
> 
> Please let me know if any changes are needed.
> 
> Best regards,
> Jiaming Zhang

Can you resend this without this text above the changelog comment?

> ---
> 
> In try_to_register_card(), the return value of usb_ifnum_to_if() is
> passed directly to usb_interface_claimed() without a NULL check, which
> will lead to a NULL pointer dereference when creating an invalid
> USB audio device. Fix this by adding a check to ensure the interface
> pointer is valid before passing it to usb_interface_claimed().
> 
> Reported-by: Jiaming Zhang <r772577952@gmail.com>
> Signed-off-by: Jiaming Zhang <r772577952@gmail.com>

And as you authored this, no need for "Reported-by:" :)

thanks,

greg k-h

