Return-Path: <linux-kernel+bounces-845334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CCABC47FE
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD2119E0DB4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266902F6581;
	Wed,  8 Oct 2025 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BeYfH5FA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D84E2F6183;
	Wed,  8 Oct 2025 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759921538; cv=none; b=bQmSqLg7x8hLJYhKlcTeAGkI3TXfuXNp7UnssgNIL+6R74T1yM1/mdMKvWfzSr94LQiRb0o5krRmEMlJgJy4N2gEtPkyMCmssu0+TCMn6GiiQaIwpgAZf7Fhban773W7nMqmmhnUZv7A+PnZY3Pv2QLsmYw0fTXMSm3lVI22cY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759921538; c=relaxed/simple;
	bh=kWG7keRcd/fqT+xo1UMsewfx7azEECIcONYveu/uEeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oc2jiecBbgi/26nOCkNGXTww9oDJ+eQAmjd0RaRjbrHyrLAIEUL8+DBUnd6WidZNgYC8LlvKWm+xj4+oh4fbeJOcRJFIfiUrCUfBo9zT+eJEmPQgSv34gIHRds5j/eB+f7NGy9wUgMCKV9JvDXSkfvY6OpRur2GgLqUO01IuJ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BeYfH5FA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D54C4CEF4;
	Wed,  8 Oct 2025 11:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759921538;
	bh=kWG7keRcd/fqT+xo1UMsewfx7azEECIcONYveu/uEeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BeYfH5FAetvnZyCRRxmGQBBK4g8ZDP8EJLa4w6nl7O1T13EJ69pR5ASi2SK8Dovg0
	 e2AkKGSlotUcesm6Q5I4CYRZYVKV4+PJ6kiQLSznBjOdQbf9w7Q4HJrdp+E/lDPwwb
	 uaYivhG9NH4qs2L/d6b1HbRsXQD/nPe4bV9MJVWA=
Date: Wed, 8 Oct 2025 13:05:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Rex Nie <rex.nie@jaguarmicro.com>, Jann Horn <jannh@google.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: core: replace kmalloc + copy_from_user with
 memdup_user
Message-ID: <2025100807-spellbind-catching-597c@gregkh>
References: <20250919115654.1011141-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919115654.1011141-2-thorsten.blum@linux.dev>

On Fri, Sep 19, 2025 at 01:56:50PM +0200, Thorsten Blum wrote:
> Replace kmalloc() followed by copy_from_user() with memdup_user() to
> simplify and improve proc_do_submiturb(). Replace the hard-coded 8 bytes
> with the size of 'struct usb_ctrlrequest'.
> 
> Return early if an error occurs, and avoid manually setting 'ret' and
> using 'goto error'.
> 
> No functional changes intended.


Same comments as the other patch that you submitted doing the same thing
for a different part of the same function.

thanks,

greg k-h

