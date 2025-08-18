Return-Path: <linux-kernel+bounces-773925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F56B2AC70
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F4C20070E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C294F24C669;
	Mon, 18 Aug 2025 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PX8jA6DW"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BAA1D5150
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530073; cv=none; b=rI37juhxPmYq92HkS+qjqIhRCIkr4k0UnH3oigAidUzBUyPyX4xHGIHlLlmk2nyXPkAQBa9q0e69fM/mKqqxaaVEW7DclEXlXPAkahP3PCGAD2BkKfy5u0iKQ2FoMZTtURLFzkI+b31rqVqmCDmPYXqqJh3DuLrvD+RxtcUJKBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530073; c=relaxed/simple;
	bh=253Fk/k1w60T8GE/q67UW3vfoP4IJWTniJrrU83QFwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdr/66y6+GNgu42vOvRerijowK7/owqlq5oedRrWchFB7M/Nv06b/OgkfLrfYPfsdUHqKM/+dqwGeWs0bu61d6Ni2AFDqL0yE6jYfvapN1zK2oc39AjctOyr0X3r+Kbq02Yq/m4eN1Q1IPEGvxnbbWGxnC4IyPd4olVHsqucINU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PX8jA6DW; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3e6666a4f55so21118225ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755530071; x=1756134871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pJVnXpOKhtlkl1TVi/ph9w2E/L47rIuiNz17/FrH2rE=;
        b=PX8jA6DWh3+2msRkOFVsc6xrvtTWZ354UabPGxNrVgjeT1PbtT0rkR9St9dFCU/zH2
         KDzW8HsmJyY9t9L9FbhLW9z52JhEgXH800cE8dFjIz0uHtAsky684AZW2LSqHtNsR5z3
         7s/1m1aBOVAwJZusxugHz11R70HUeQMgrpxIoW43ZkFZWx0Yc5yNq9sOLlujo3aRF5yC
         MhfuYChIPUEHuG9kBfqER97BrSZX4jvZfy4l84BEsCwne5/59hSANPht3hvacVnp20nQ
         LV/QoUcBJal6H+DqTkLav4ZzodmY1Obb7lA/BR/7fWF3bcR77fpr4R3m//901YZgsUb2
         +Nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755530071; x=1756134871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJVnXpOKhtlkl1TVi/ph9w2E/L47rIuiNz17/FrH2rE=;
        b=d5QcWjtgjNBi7uQCCQlcGsqu9/gBdzJ9O6A9F4l5kaAy9BFid4sR3SB/WkyqUrC5Nw
         5jJtN/ofyLNA/qSHmc6D/ZAm8Eij8bojX1gBJzaiWuHZC+r0RYPus/QKZCuKo+nbrXG6
         HzIoCkkbNAoBmq2PvuEdn0SNFCSZxlP7lg5YLPMBAq4Tf0kyDyHUbC1gk3H2y2gtEaEO
         dzgkj0QjGhF3HOQKboFVJFOunRaMyEkfX2eS/8wNY2wB6IHl0wUBuFWMDnykWRQ23nUh
         Fl69kMMD3O77d4RbGHCSDBg5qRocRY+KprEw3ybrJh/HhSHK62feSeig3MnsLb6U302I
         V6Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUbHxu8uRGjSXCij7c/MdSAETU6Fv33jeRBWzwWj9gNZGQt85XIYdXk9gOe+/QGUR0iU0BRrfcVO7tRtk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLS6apJ1ntLGOVI8JgnNNGiximfgCZKtfmZV07bbbSKWh+5V48
	Q+pQKpPi57ZvJ0OsYINuBW6XtSJpR8f4FelPY3NMWBzngQEO11rNhBDBHOLPy0Ap16eN8fmEoNs
	M7QNSQAM=
X-Gm-Gg: ASbGncvtqkx1qErkCmbS0+zdPJE5sBteRcQF1F69uLjln0SzANB7brrWMZdo7V0TgdB
	3JU+TzUkHFk/nwgo8ZpGNoJNy9WxaBAseFs2ajw3+HACiXo4fdfsfUoGsnNVdJSDDMUczjqcOrv
	/NwEIgKRiB2lvzuR5dXDIVhmI0p4e0khe8ojjYvOtt/Qa1frnG7LmFFuNG1YSBsCQNmjwQ4GS5Q
	DUqlAGuVeahohVxMZP9ecprklg4oqQsI2pY7/5SZSCV/PJ+NjMPyUdTOR0SzfAt3gBp+79K295I
	VXUgjwX+Ox3fcj3Ze9CNc4P+Luq+reNKgkA4syb5t8zoVfQ9pibdG15sp9gtnLn5R85Mq/Xf2y6
	9jw==
X-Google-Smtp-Source: AGHT+IGD3WCH4r5/BDvKZhnt0hvOa7OtCml84sjjaSqIo8vg5MPK1lE8HmDoADIn5/UJ0sNbJ0LWYg==
X-Received: by 2002:a05:6e02:168e:b0:3e3:fd25:f6a with SMTP id e9e14a558f8ab-3e57e8ad57dmr221351925ab.11.1755530070566;
        Mon, 18 Aug 2025 08:14:30 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac5:8255:4e6::7d:7d])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e57e58c3c3sm35249495ab.2.2025.08.18.08.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 08:14:30 -0700 (PDT)
Date: Mon, 18 Aug 2025 10:14:28 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Corey Minyard <corey@minyard.net>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: [RFC] Patches to disable messages during BMC reset
Message-ID: <aKNDVFTI-UZeNq0Y@CMGLRV3>
References: <20250807230648.1112569-1-corey@minyard.net>
 <aJ-lPAc2bLlvHNa3@CMGLRV3>
 <aJ_lUYTlrzYnRD-5@mail.minyard.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ_lUYTlrzYnRD-5@mail.minyard.net>

On Fri, Aug 15, 2025 at 08:56:33PM -0500, Corey Minyard wrote:
> On Fri, Aug 15, 2025 at 04:23:08PM -0500, Frederick Lawler wrote:
> > Hi Corey,
> > 
> > On Thu, Aug 07, 2025 at 06:02:31PM -0500, Corey Minyard wrote:
> > > I went ahead and did some patches for this, since it was on my mind.
> > > 
> > > With these, if a reset is sent to the BMC, the driver will disable
> > > messages to the BMC for a time, defaulting to 30 seconds.  Don't
> > > modify message timing, since no messages are allowed, anyway.
> > > 
> > > If a firmware update command is sent to the BMC, then just reject
> > > sysfs commands that query the BMC.  Modify message timing and
> > > allow direct messages through the driver interface.
> > > 
> > > Hopefully this will work around the problem, and it's a good idea,
> > > anyway.
> > > 
> > > -corey
> > > 
> > 
> > Thanks for the patches, and sorry for the delay in response.
> > It's one of _those weeks_. Anyway, I backported the patch series
> > to 6.12, and the changes seem reasonable to me overall. Ran it
> > through our infra on a single node, and nothing seemed to break.
> > 
> > I did observe with testing that resetting BMC via ipmitool on the host
> > did kick out sysfs reads as expected.
> 
> Ok, I took the liberty of adding a "Tested-by" line with your name.  If
> that's not ok, I can pull it out.
>

Not a problem.

> > 
> > Resetting the BMC remotely, was not handled (this seems obvious given the state
> > changes are handled via ipmi_msg handler). Would the BMC send an event
> > to the kernel letting it know its resetting so that case could be
> > handled?
> 
> Unfortunately not.  It's one of the many things that would be nice to
> have...
> 
> In general, dealing with a BMC being reset is a real pain.  They tend to
> do all kinds of different things.  The worst is when they sort of act
> like they are operational, but then do strange things.
> 
> I haven't thought of a good general purpose way to handle this.  I'm
> toying with the idea of making it so if the BMC gets an error, just shut
> things down for a second or so and then test it to see if it's working.
> During this time just return errors, like the new patches do during
> reset.
> 
> Thanks for testing these.
> 
> -corey
>

Thanks for working with me on this.

> > 
> > Best,
> > Fred

