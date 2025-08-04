Return-Path: <linux-kernel+bounces-754992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA392B19FA2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1698E17A77B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0B924BBEB;
	Mon,  4 Aug 2025 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GinAAvOf"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEA122097;
	Mon,  4 Aug 2025 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754302818; cv=none; b=p5P8fPtj/vQYODkfXj3w3CaW1PZPrjWhW3Fk2vK+sfwnQO8j8/haSQhnRIxf5bd04ThB3CLEiRmxUmE3lkSDjPKDtp59NyLR/YdppmNGExbqzx4AKzTOyXj/9NBySnEI3yZdsV31I1OsuZMFVKQWhrkimEFtLieyO1iD8T5JwWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754302818; c=relaxed/simple;
	bh=zt15Xzme5yX3vbYfjn4cy3mxjGr5KzEP5dV0ertZ+YY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=O7Mwacgd+HC1W+0kKEDFnKWIDQQFEqdn3C9am/sS/m3U2ioHgRAz/tOzRXzGahRSzf8pyp+HuIBMgfWql7PFYzXU9Tg+HANsg2fU/I9DK0ZqG4T7LJNpdSKHf4Jwq2RE5FqCPaoT0QYpE8E8RTFQJgXIfre61q4YL+JeNE/5ymo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GinAAvOf; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6156a162537so6354110a12.2;
        Mon, 04 Aug 2025 03:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754302814; x=1754907614; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7eZUHFrYxgQ0qDhUY5kKCZADajcB96cOqkgb1jMTj8E=;
        b=GinAAvOfqKjufjm3o5T1XgdzkY0ki6auPxUrfyS3boSucSjuYJJUU38mh/IUzcq6nV
         JzkD5Hf+LMjLoCjhllROnLJeq4IDbXSbCy5iLhbaSitKkbLoKn7YZhpXm4Mcoy2G5d3S
         4vHNFV1cmaaYDF7sqUrzbNwOEEmDd9XPGUq/QUuNIU0QuU9vc7zwABHveyVSZm8XHMuh
         8TeqVc+sWb2PkQtXpyq28nmZqf8r3JKYVY5BKD0PS2lujo79ijox02yyvEEQuVmN9d7p
         nztm+2F7vV8VVBy+17XJg92eTWz3gLzxDawlVc0wA6ICzV3djLBeaZprarbWgR9ZdOLz
         Np5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754302814; x=1754907614;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eZUHFrYxgQ0qDhUY5kKCZADajcB96cOqkgb1jMTj8E=;
        b=JwwSPtV+5k5XA2JGQ0fpdFyZsj548y1oFwElQOsce+MbUduxCOdPE1Wkpehc5R2RHI
         2L5vT9TkbSi1saCHv2TC8533dFpc42zqgGZcietlAAQoywPWZZ7ed+2kTWtaJqrYEhxq
         Om2YHoysFGa6b+hYecYfPvG/dKDbE0NNo3eRgXrQeVYJEetcVhEowsOnuGYcJrzuo1bk
         pP8Xx1R+8GJhni7rj52Srj+QzHSUAVBr3zRQVIk+m3cBlHyPyf1fcffVvBpZc2Y+SUOs
         Pewc5UUnwTzi6ZYFjCF53K7QRQTySxr2k6KlGue1bLALhHYJySrPP2YvmagViRvXe21O
         aq0g==
X-Forwarded-Encrypted: i=1; AJvYcCUXsZBT752JizFFlNuqbQxCUARz7lWYLxTRbs2u3wy4NgmFoFMX0RKseklGQMDLzMpZvWMaA7cMLKaX@vger.kernel.org, AJvYcCVPji64PgRBoZmQZRAcN3ZHW720Cwo3Ts1foK8AbVeuuqB05UmNJVIi5V8dVqUS29WqFRforzKqlqj+Ii20@vger.kernel.org, AJvYcCX5qGNltruc9NCLrzK/MpGbPKp6Lw1uF9tAUcZLKh/3B+9dlW89ZY1IRDUU3xrYNq8PHE22sRa4yqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7GQE8s9OmI52L2HcsM6YfmwNS4YBeRItfENLqkrBSJSKKr651
	62GWVag3lhlrr22ugWcxSZvC63wopE+oYpRIU31epRo+yt3rcKRdnPAj
X-Gm-Gg: ASbGncvrvXvgReL7pmU71QqlbghI/onifWFFIivLOZDLMPQmUTUZiInf/kfGg53SuhI
	Vj6MrRCIMLJRA2lVg/8lsOB+kWvm55q/kjustv9YT67KExit3a9cqSHfcHGfuAZUiUew/fDLe9a
	jg92aCOROyZm34qMJEioG9NFQpLRCKiODrUpHoqNphZdWKcoi8IcFgl+kFGc/DM2kIX1TjT2WW/
	0yyrW+vtqRGXvrwRZ20L4uvsCoIfmHCkH6H4XOVo6YUbTzFIexn+Ail04wkNrpiA5feA6QihxnR
	IlMaj0lhe60f5/A3H7y44iFXkZJx6K9ShILlmmND+8q1OqvLVT+oXErU0eQq/mETxIPUKhYrDN4
	gJ3LDo0yWMIXehj/N
X-Google-Smtp-Source: AGHT+IFta7Ntkqfvi3HuONMfCPmHJQg2TPNp6F+bRBsfU0kdVF8GqogtcbzAjOt0sfxx+o8g+632HA==
X-Received: by 2002:a17:906:f59f:b0:af9:38ed:935c with SMTP id a640c23a62f3a-af93ffc5908mr934225466b.3.1754302814126;
        Mon, 04 Aug 2025 03:20:14 -0700 (PDT)
Received: from localhost (twin.jikos.cz. [91.219.245.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a241bdfsm712239366b.131.2025.08.04.03.20.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Aug 2025 03:20:13 -0700 (PDT)
From: Jiri Kosina <kosina@gmail.com>
X-Google-Original-From: Jiri Kosina <jikos@kernel.org>
Date: Mon, 4 Aug 2025 12:20:12 +0200 (CEST)
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
cc: Sasha Levin <sashal@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
    Greg KH <greg@kroah.com>, corbet@lwn.net, linux-doc@vger.kernel.org, 
    workflows@vger.kernel.org, josh@joshtriplett.org, kees@kernel.org, 
    konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
In-Reply-To: <a1022055-52bd-4948-9399-908b29ca140a@lucifer.local>
Message-ID: <alpine.LRH.2.00.2508041219130.22517@gjva.wvxbf.pm>
References: <20250727195802.2222764-1-sashal@kernel.org> <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local> <2025072854-earthen-velcro-8b32@gregkh> <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local> <20250730112753.17f5af13@gandalf.local.home>
 <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local> <20250730121829.0c89228d@gandalf.local.home> <aIpKCXrc-k2Dx43x@lappy> <a1022055-52bd-4948-9399-908b29ca140a@lucifer.local>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 30 Jul 2025, Lorenzo Stoakes wrote:

> > This way we can extend MAINTAINERS to indicate which subsystems are
> > more open to research work (drivers/staging/ comes to mind) vs ones that
> > aren't.
> >
> > Some sort of a "traffic light" system:
> >
> >  1. Green: the subsystem is happy to receive patches from any source.
> >
> >  2. Yellow: "If you're unfamiliar with the subsystem and using any
> >  tooling to generate your patches, please have a reviewed-by from a
> >  trusted developer before sending your patch".
> >
> >  3. No tool-generated patches without prior maintainer approval.
> 
> This sounds good, with a default on red. Which would enforce the opt-in
> part.

I strongly believe that at least a distinction between 'static tools' and 
'LLM-based tools' needs to be introduced here.

Thanks,

-- 
Jiri Kosina
SUSE Labs

