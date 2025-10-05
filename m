Return-Path: <linux-kernel+bounces-842223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF660BB942D
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 08:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8876E1896EBD
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 06:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E93F1DF247;
	Sun,  5 Oct 2025 06:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="elHc3QSx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B080C13AF2
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759645464; cv=none; b=QtEyPZ3kKdwai7rz7Aq6tX6zDHVMBoKbOknsPACiDciF1Vb/o2RzOR3lH6z2eghoza2OPat/QkAcrk8OHv+QLE5Vpvjmv8KB9HnqlM+5B5OGEvk/Bk3gx1/UmPoJThOJaqRWaEACsl9bwErOICz+MNB8/I0J38yTPApSM168BcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759645464; c=relaxed/simple;
	bh=umoRovBsip0RXPLbRuzD+/yCJzmUGlTa25/YNNq75R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcpD0yE9cM1IzV+z9gUlGleViZ5yUijDUet7CbF5eESH5OcI+v3vkktPK5HseqNWhzeHK5MZ7M8mLdgl/IJ1qvWqqIxvVJzOtahQFxQXG8seSYR3Xjy317vGu3JIe/mwUAHK+uWQRQam0DzAOJH/MDEd8fk5lCHD0EnlcRs8Xa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=elHc3QSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5FBC4CEF4;
	Sun,  5 Oct 2025 06:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759645464;
	bh=umoRovBsip0RXPLbRuzD+/yCJzmUGlTa25/YNNq75R4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=elHc3QSxhSyGcfDAwJhIiWQorFHB9pLhzKJJPE2XZ5OtoWlbgFv1k7ki3tPDEWI/T
	 GC5SwuA9YmRr0DqYXWdR+2K11gfZD/tFoK63HdmSlRmeSkxL+ZlS7KA2pfK2ghyxlA
	 JMnGrBe3NP0D/gRsOmuuP93hfQgQDr5zjm8MfERU=
Date: Sun, 5 Oct 2025 08:24:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Madhur Kumar <madhurkumar004@gmail.com>
Cc: mirq-linux@rere.qmqm.pl, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: cb710: Replace deprecated PCI functions
Message-ID: <2025100559-array-reverse-9fb0@gregkh>
References: <aM7Vab4TWill5vev@qmqm.qmqm.pl>
 <20251004215357.1839791-1-madhurkumar004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251004215357.1839791-1-madhurkumar004@gmail.com>

On Sun, Oct 05, 2025 at 03:23:04AM +0530, Madhur Kumar wrote:
> On Sat, Sep 20, 2025 at 18:25:13 +0200, Michał Mirosław wrote:
> > Acked-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> 
> Thanks for the Ack!
> 
> Has this patch been applied or queued somewhere? Any feedback on the change?

It's the middle of the merge window, I can't do anything with it until
after -rc1 is out.

thanks,

greg k-h

