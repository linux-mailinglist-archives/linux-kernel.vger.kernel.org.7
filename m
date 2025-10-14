Return-Path: <linux-kernel+bounces-851833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D54BD765C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0CC319A23AE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766E728851E;
	Tue, 14 Oct 2025 05:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vyloUoVM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A90284886;
	Tue, 14 Oct 2025 05:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760419077; cv=none; b=T7VhalUtyV65fh3qGOVRVtwnWTfPHJpzUxE7hr4cMvaXAfXx5M60YHVXVryeAbwpLEbdodm0b8npr0iOYlRK+UjnxbxxDFmByBnm0RHJMATVDRJPciuXjGmOGYvK1cI5tyiQd9glGf/LeuSU4/Z31uvWejWS4hyRXwdUTgNOLxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760419077; c=relaxed/simple;
	bh=Dtyuh444g7DKNV9pBujDeAEPnHQc6ECr+0VZ8XEmtLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7Tz5dWmTow7+OoWrZON4Q3qu0Gwmjoz3t9AS/9O+yh1Vrg83M6kmiatHRMGQYqp7S1mQl2qkMIueCSVpYK216+pi4NJAHBgniYD07cSQVDOeZKZ4t/+EAq715Z5cyKo6Ztkv9+41nwCrU6k0e1kri0tDNibFiO5ixLm6Xa8trg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vyloUoVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E24C4CEE7;
	Tue, 14 Oct 2025 05:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760419077;
	bh=Dtyuh444g7DKNV9pBujDeAEPnHQc6ECr+0VZ8XEmtLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vyloUoVMeriqUBxf4K0Hfe8g+pgSVltbBgkoVN9CDRPjHJrLzeX+Lo0Xqp8RBDM5W
	 fqmMoGjZLE0zbY+vdPp04VfiRJ3APWSMeqdcgO27ekl646QDi0HunWydzdQKJxnSxZ
	 Lb3YYyScq3TBqOrWMoYSHHuv2vRAvOoP64wSx8ZM=
Date: Tue, 14 Oct 2025 07:17:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: core: Add tracepoints for device allocation and
 state changes
Message-ID: <2025101423-caravan-dominoes-0037@gregkh>
References: <20251013-usbcore-tracing-v1-0-b885a3121b09@google.com>
 <20251013-usbcore-tracing-v1-2-b885a3121b09@google.com>
 <66a98159-b75c-41f0-8b4d-0ce9b1c8e4ec@rowland.harvard.edu>
 <CAKzKK0pzfSFJ15esnGB9gY_HMrgubZ1QtSkLOUo2FvsNGtCi6g@mail.gmail.com>
 <3d4f625f-eecb-4265-ac86-1420d646aa14@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d4f625f-eecb-4265-ac86-1420d646aa14@rowland.harvard.edu>

On Mon, Oct 13, 2025 at 11:24:47PM -0400, Alan Stern wrote:
> On Tue, Oct 14, 2025 at 08:05:25AM +0800, Kuen-Han Tsai wrote:
> > Hi Alan,
> > 
> > On Mon, Oct 13, 2025 at 9:20 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > Suggestion: Rather than printing the meaningless numerical value of
> > > __entry->state, print the string value returned by
> > > usb_state_string(__entry->state).
> > 
> > I kept it consistent with the udc_log_gadget tracepoint, which also
> > uses the numerical value for the USB state.
> > 
> > If we change the state to a string, should we convert the speed field
> > to a string using usb_speed_string()?
> > 
> > I lean toward keeping both as numerical values, but I am happy to
> > switch both to strings if you prefer. Please let me know what you
> > think is best.
> 
> I agree that if one of them uses strings then so should the other.
> 
> As for whether you should change them...  I don't care very much, since 
> I haven't used tracepoints in my gadget debugging.  I was just thinking 
> of what other people might like.
> 
> Greg, do you have a recommendation?

Strings are always easier for people to understand, otherwise we have to
go look the value up somewhere.  So both should use them.

thanks,

greg k-h

