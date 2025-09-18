Return-Path: <linux-kernel+bounces-822257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35386B8365B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C601C80496
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED18F2EC0A5;
	Thu, 18 Sep 2025 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PoAS+eVt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE472D781B;
	Thu, 18 Sep 2025 07:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181834; cv=none; b=OmZ2FgKEqetjoYQEOJncYCTlAs/r34iwzbhkfFG/zR+qTJdm5Yaf/9/eciL0+354CU9KwVGxbxhWMwF4Nd1xfaJ+Erke+L9JmYHhrEzAVDb2Qwm8fIV5aKMpfVgppbA3KmcQvw7DaQtFP2ih0cMeDGYJas1cYP5nKxi5Su4kH0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181834; c=relaxed/simple;
	bh=6uag2AunqpzXIa9WrJ+VB/u3jSUtR9uci+FcdNiRDGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U588/HeoVsZtrf472llEuux9vT2Sm1MVNXVTImZxumZXlKt6urb8pHKy0AQMw+g3gzHYw2+iu0GkI0kqm4Wzw+thwsDSn44a3qPuiVuCg70d+jJkFUNgUxLW0hVFuJ4qjy3Sv+ARzIlgej/BazDgZFBlM/gxdo1wLjpXalh/TNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PoAS+eVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561E1C4CEE7;
	Thu, 18 Sep 2025 07:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758181833;
	bh=6uag2AunqpzXIa9WrJ+VB/u3jSUtR9uci+FcdNiRDGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PoAS+eVt5vuIdPJi3Vc3ApwXx99/H6ScEg0erXUZhghTPaoEGGqoNjnUeiBrXHxGi
	 hWBTqgJSWrz8roh4/n+vfgjFELw0GA+yFVGayQJqPGmR+/IndPHLuLjZX8wnqg2z/N
	 h9xmyqNre/1/bcrW54Ezo5FkJk8WAvXHsW4/OZV0=
Date: Thu, 18 Sep 2025 09:50:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Handle incorrect num_connectors
 capability
Message-ID: <2025091819-bullion-hut-8242@gregkh>
References: <mpearson-lenovo@squebb.ca>
 <20250821185319.2585023-1-mpearson-lenovo@squebb.ca>
 <2025082213-antacid-correct-53b1@gregkh>
 <0ac78125-a028-4d99-b106-d792d8660d0f@app.fastmail.com>
 <1c185541-2b6b-4c43-938a-9f4f4d1499b4@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c185541-2b6b-4c43-938a-9f4f4d1499b4@app.fastmail.com>

On Wed, Sep 17, 2025 at 02:14:28PM -0400, Mark Pearson wrote:
> Hi all,
> 
> On Fri, Aug 22, 2025, at 8:54 AM, Mark Pearson wrote:
> > Hi Greg,
> >
> > On Fri, Aug 22, 2025, at 12:51 AM, Greg KH wrote:
> >> On Thu, Aug 21, 2025 at 02:53:07PM -0400, Mark Pearson wrote:
> >>> The UCSI spec states that the num_connectors field is 7 bits, and the
> >>> 8th bit is reserved and should be set to zero.
> >>> Some buggy FW has been known to set this bit, and it can lead to a
> >>> system not booting.
> >>> Flag that the FW is not behaving correctly, and auto-fix the value
> >>> so that the system boots correctly.
> >>> 
> >>> Found on Lenovo P1 G8 during Linux enablement program. The FW will
> >>> be fixed, but seemed worth addressing in case it hit platforms that
> >>> aren't officially Linux supported.
> >>> 
> >>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> >>
> >> Any hints as to what commit id this fixes?
> >>
> >> thanks,
> >>
> >> greg k-h
> >
> > Maybe 3cf657f ('Remove all bit-fields')?
> >
> > The commit there states that 'We can't use bit fields with data that is 
> > received or send
> > to/from the device.'
> > Not sure why that is, but I assumed this means we shouldn't change the 
> > structure to use 7 bits for num_connectors, which was my original plan.
> >
> > After that, we go all the way back to the file creation (c1b0bc2) where 
> > it was defined as 8 bit.
> >
> 
> Just a gentle nudge to see if there are any concerns or questions with the patch.

I was waiting for the maintainer of this code to review it :)

