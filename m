Return-Path: <linux-kernel+bounces-746579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F104B12889
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D841C26C41
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5DE1DB92C;
	Sat, 26 Jul 2025 02:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="JAl16UCB"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3FA19D89B
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753495817; cv=none; b=qPOgGopTBAamFkGbyl5tz+x86hopP87AR0jERVWaKGh4V1b8PPAu6bKqhTGk8epYT0bsCofCE6A8rklqYP1g1QgDm+QCCl/Pc5ZkNh2sxVK8feBqX0KbWTg8g5yfUOgqedxvIHkJTpL7BbMbzMBf4Ym6h9s5JLe+jNn5LX1x3VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753495817; c=relaxed/simple;
	bh=PULKyoQPfoJBUREloodC53J6LvdB2Nf9AZX03v3VUNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=at+jcTGE/rXowtKHfif7qrcRxSohtQl/GJ78igR5iAywxLPeNrz2b5hkmEtMAQGkRoY/zSF2qZRPuevwQj5MLr6soBHlK0uDFr2yEcB03tgrnQnhdHuA9eE7UbhP4DR2BXhlJFswOdNQqQSHOguKq+RUhG6+8faQ+mK34Umukt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=JAl16UCB; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6facf4d8e9eso18289896d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 19:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1753495814; x=1754100614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qQ7SXOragRTIX4LIzQZOTZXKs9RiWGmIsBpnIAlkZMg=;
        b=JAl16UCBWi8OLPPf4pIRVwZigMoaiuk9N1jlQj49CCriK6Cnjk6LfLCypQq3se6/ES
         Qw05f7fRlIr0DVEyr28WPtbUF1C7PiWnYEJCLbspVY+v0T4AVg1n6/sGCl4+I2aeLmMJ
         gm9GYP50kVcq0ss89lNFlsQHGWE8QrXKKWAX5niu2zV0eiyIDGuZPnAyqcYyIRED/Nbx
         hw7jQVPoL0cXUhISqW9GdzRThYQvXOBCDsc5xVOABSuzegSTdVaCBnZSDFQUmT+RcfF0
         nn48b/ASYLEQvT6SJfV1awxPPyNTbIgv8nuk3lK1mI1uL5au+xluF6nscthAos6g7oWB
         4qCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753495814; x=1754100614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQ7SXOragRTIX4LIzQZOTZXKs9RiWGmIsBpnIAlkZMg=;
        b=nhpbr0aL8q92frKsSpmAlo4MV3WARyBhvRXZq3lZbr8zrz+oCdQj4L8VfkSo0OvWR6
         TotcdiY1IGApcCVimQgYHHayHfMbQnjyyoH9cMd4Dc3iWcEPlk+pX1LoLiQKvmBjlXbi
         bQ5jt7Bf183xcE/8O0YNeAyFOTyHnWUWtiHF16ry/nROwkDxlj+LaZzb9DIf3HWyLAbm
         LgubONaeq//FgqmqTlZx+aDmEDm2NICGN20K0razs+Ss2HzymH7P09qhs5ZFhoPbkh1c
         rrQGQU/Qw2sPc6/zvnfNvJ9GVI+wvOKCLOc8GGwYRG11IIAZN4MRobsQdRicza8XFzyW
         6TmA==
X-Forwarded-Encrypted: i=1; AJvYcCUzuIvTeCPEL9vgQB3WioL6YFD2sy6H2dwN0KaPre2zx+9sbydA7r0cEQxPy7PKjLQFk1qMZTan2MFGBWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOcIlJmuRSlzIjcSDGnXyfhx/MDj63C5e31tmOHgU8L38YhxnK
	hHyR2GtOY3wZPNpdQtO4mjdjOO0Hx9bsFaxS9VuiUrVQD4Ks1LWaCPFdT6H5AshdNw==
X-Gm-Gg: ASbGnctDMRjsbMP/26SJ9AvbjbZhnXT4pfnNqkDFcj1dY2t3C8xqxANgIVVS/TLEeTw
	TMDCYudm5ir/oFx0CpNkVTCm7c9IQO7QNO4957ZUOQWB6qjEWzAwGpIlqwZdO/UwQppLdigQjBx
	MjlKGz9b3UbvEG17NF9aWCnbebRvhOHN3hwKcUH07uHq1Hj3tsWNP+1oSDwrUmcAqFoPYwwsY+F
	H274otO8Y3awc6lH71uMGjLQkFT2pqBsa6oCyCFPZGkSj7mUq6k8deGi3x1wNTFMeH3hSl/bhPS
	JUM/vSN3fx1s7KKWYB53ImMDEHXW2fVDNQguVbBisc97uEIkokXdvytUDJiyFJlLf0TiwettFKw
	dt7XPn6RG6n2O8bQW44l6HUU=
X-Google-Smtp-Source: AGHT+IGzVgC7zSPm77RvN7HmL7AuYbfj2Q2hSHE5FaAmz4RBfNyLkVHyW8mGDSfY2XCDjy3dmKWnzw==
X-Received: by 2002:a05:6214:1942:b0:707:2b04:b04c with SMTP id 6a1803df08f44-7072b04b19dmr24997336d6.30.1753495814078;
        Fri, 25 Jul 2025 19:10:14 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::317e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70729a63136sm6683706d6.24.2025.07.25.19.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 19:10:13 -0700 (PDT)
Date: Fri, 25 Jul 2025 22:10:11 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Olivier Tuchon <tcn@google.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: Add gadgetmon traffic monitor
Message-ID: <1e4a2aca-cde2-45ea-aebd-408fe9bf9672@rowland.harvard.edu>
References: <CALU+5Va_zeqS5YK7v3HNvDKkg8srqc87P5ZaQUK5tGFUMyNrkg@mail.gmail.com>
 <42f4753a-f7db-49a3-ba40-8743a78684b4@rowland.harvard.edu>
 <CALU+5VYnZfp2CqXqn7X14J5pGsXyHDOcC5mOCZx4nKA6tjzO2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALU+5VYnZfp2CqXqn7X14J5pGsXyHDOcC5mOCZx4nKA6tjzO2Q@mail.gmail.com>

On Fri, Jul 25, 2025 at 10:45:29PM +0200, Olivier Tuchon wrote:
> > There should be a similar optimization for IN givebacks.  The data to
> > be transferred to the host was already recorded by the submission
> > hook, so you can save space by not copying it a second time during the
> > giveback.
> 
> After a couple of tests, I found that the payload at the Submit ('S') stage
> is often meaningless (zero-filled) for both IN and OUT transfers or the
> payload size is already set to zero.

That doesn't sound right at all.  Maybe your tests only covered 
situations where no data was being sent?  Certainly the response to a 
Get-Device-Descriptor or Get-Config-Descriptor IN request would not have 
a meaningless, zero-filled, or zero-length payload.

> I simplified the logic to drop the payload for ALL Submit events.
> Fixed in the next patch.

usbmon takes the opposite approach, omitting the payload for OUT 
transfers during the giveback event rather than the submit event, and so 
that's what I'm used to.  But I suppose you could reasonably do it 
either way.

Also, Greg will no doubt complain about some problems with the v2 patch 
email.  The most notable one was that formatting was messed up again 
(tab characters replaced by a single space) -- you should try mailing 
the patch to yourself first and then verifying that you can apply it as 
received.  In addition, it wasn't really a v2 patch because it applies 
on top of the original patch, not as a replacement for the original.

Alan Stern

