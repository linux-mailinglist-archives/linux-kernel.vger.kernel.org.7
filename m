Return-Path: <linux-kernel+bounces-731481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D980DB054FF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C163B2FCC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4BE2C15B4;
	Tue, 15 Jul 2025 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BrG9tgjD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E0D2741D4;
	Tue, 15 Jul 2025 08:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568351; cv=none; b=qSSlDaSSFNGNnz6lPmmFj1HtzmUmAt4LP/DRvVBkoO8AV44Fb/nDgd9/3SSilcVgqaSbl/Hi30A9xvBe+kJ4keZae1ULQVt1JLkCKUuxw7wU/rWzkGh3+qpLuxpSghc/B/eSopg1fiBjMU+gG0dLxR5YUOCCzgdIYG45tlY/wvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568351; c=relaxed/simple;
	bh=hO/kvJB40HVuEpcvrVIJ3+ckdcVlzTneCpqjB8KXFZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzPhhSLcUNyWdiv90Uxtqx6BuktfiZGHJJvy06oRIYEoMB3pOWP4aDWVeJa5RuEdtOWUs6HcrStWCse9k50GEDLDULqRYb98Fhco64ShtjcQcqOWqXya4R7V226FRckufeWyL7HlDIWXFOZpLZkUec588FnIYDBrsoeyY5c7v3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BrG9tgjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B299C4CEE3;
	Tue, 15 Jul 2025 08:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752568350;
	bh=hO/kvJB40HVuEpcvrVIJ3+ckdcVlzTneCpqjB8KXFZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BrG9tgjDB9kme4m4fV/4V2wAUXaQolUMfekjKfUb1uQ2hPhvSj6BEbsCf/ANrDLFs
	 bwtr6x8/UAOqonFBPSI/+fT5SOPcGxXDBINYXn//3pKmy4bC6hGEc8OiWO0OODB7n9
	 D3lJ04wydX1jgR3SsdDOKpFoLLwhlMaVwpolDKFw=
Date: Tue, 15 Jul 2025 10:32:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: jackysliu <1972843537@qq.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] usb: gadget: functioni: Fix a oob problem in rndis
Message-ID: <2025071539-tattoo-knickers-a775@gregkh>
References: <2025071116-landline-antelope-5c9f@gregkh>
 <tencent_AC052534ED0C97ED96CDBF2269E71DAE5905@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_AC052534ED0C97ED96CDBF2269E71DAE5905@qq.com>

On Tue, Jul 15, 2025 at 04:20:09PM +0800, jackysliu wrote:
> On Fri, Jul 11 2025 08:51:30 +0200, greg k-h wrote:
> 
> >Yes, and then look to see what buf_len (not buflen) in
> >gen_ndis_set_resp() is used for.  I'll wait... :)
> Oh,my bad.It seem that buf_len will only be used for some debugging code..
> 
> >What tool generated this static analysis?  You always have to mention
> >that as per our development rules.
> The vulnerability is found by  is found by Wukong-Agent, a code security AI agent,
>  through static code analysis.But It seems that this is a false positive..

As per our documentation, you have to always disclose what tools you use
to find stuff.  Please always do that, otherwise your reports are going
to be ignored.

And then also properly TEST your change to verify that it works before
submitting it, that didn't happen here.

> >And what qemu setup did you use to test this?  That would be helpful to
> >know so that I can verify it on my end.
> 
> I've add some web-usb device to test this model.But seems that I went into a wrong way.

What is a "web-usb" device?  How does rndis work with that?

thanks,

greg k-h

