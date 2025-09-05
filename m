Return-Path: <linux-kernel+bounces-803598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8079B462DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1038ABA188E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41328315D5F;
	Fri,  5 Sep 2025 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="MsbNAmrs"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D78315D5A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 18:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098223; cv=none; b=X94z9H5uRReMu6zZyD3LtS0g/AFHoI0odyBciWDCATUbXACQE4YdZEhoJ8/C0j2gm1AVOQEcmO+z6LvC3d4u3k4vZgwq1VWcW+9dlxb94hejqZhFBhbxHoOCfw4bpNM14Z+sUDdELB+D3N4HDlmZvBIKZ5MmhnaBu7qJ9VCzDRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098223; c=relaxed/simple;
	bh=0hYvnTz+R7sjXCKT6oK+dyNsXz+XwJzcx6mP2KzeeiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAqHzqlvC4eDNvrqUN6RViWARPtcjpsOM33V7McrLH7ZgCMdvFsuMTmxBSOwxk2FVJeqgI0m+HMnErrzJTR2jsOvUvhKWLfjWnATKSJURAWmn0GUvoQl86AyROdEnYPg3NIwIVQyqTQTejmVLrA8ezkbJD8fXLxDN36eidIVthM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=MsbNAmrs; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-74be52f5447so45644a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1757098220; x=1757703020; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FEEk6xUwhvxiQOfwQMcWge63YTvzvqM+uAXEwNhtVtc=;
        b=MsbNAmrsizfrJ9c/xKL4vtL/HemI+mu4h0B87BMe3blqlk9YqsXyHa5p4uxRsVSsAI
         msiqFPDynZ8iBTXdwkmWpvhCwa9eC9cJU+fP7maLqfLxGgIXCIsVdVc3rSmsfMa4l5zg
         k+msg9SSYbevw76Ab6YxisA5L2oA5UuKVnQEzIu8D5vozNLiUahPwNxciAqfazPv/eW4
         LByLv0dvVQhbmMMrOHRU1R3qaTCqw4SGvBDa7Cb7bJuq7qHBz8B90EPpzhFXcqOrzAuk
         H5VeK50WX4IeWloLoBa1YqQ+ZkUjezmARMnd7ww8NZe1gYHwdS3kuf+TPz88DeOYuCVE
         UhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757098220; x=1757703020;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FEEk6xUwhvxiQOfwQMcWge63YTvzvqM+uAXEwNhtVtc=;
        b=sjebhtt8ipjXhAdzVX1XH0I2NgVgzY/SyfF2/XXB/GZPfhJpQmVf61HX1GD9BlKE/w
         ziXrgvBTdsyI+/vn962b0sA8qOOo7o3cUhShERKWIgfvo10B4gOnSfATu07FVIgW7hbg
         VQMu8BSbhtxWtAVXoNo+JureeCts1rsQFU61fGKbSEhFw3LZONzXqZofSgAXElIHuMex
         QIpCvJ8cTmUfffrpymtLV/pN5F+PtmUINXHh87o3nVkb2d/xm0xtRp4bVXJilwNwhGgM
         GLRRMHH+LpAVgPGrqfxN5dFGvz2iQNZtYFlKTw2YU9E0gCdq7I8UHbG3etNqk3gyIwzz
         NPIA==
X-Gm-Message-State: AOJu0Yzu873ptkRaLNCHYcMTe9FT57reRBm3//N/Lwftg0S/8j1ZQ5XF
	cmUl9JMzpjCfQPStG/kxNUzcyvyaA3oHJCRQF2aFEm7sEYsttVEo0H+b8zuqdsVmKmU=
X-Gm-Gg: ASbGncsHmUjne91GnNNY3IYFcoxl02Z19cc3l5d1x/l6cHaCTeNVCJdtzm/BXp/EUcT
	n60q7rPZw90cSNiXkuSBXkrdeCz+KYiE7yLJI+qKUNFHcsjC0zNF5gcWypmUVUx9dF7SF0uvPDr
	/uz8IjHYRIxgE9dza0gJdzBLCkX3b1tIB7nxi5Wk2s+PoruX7Z2YF9xi3j5gJWmX0Qyklq3O4Eh
	VYDXoKIcDid3Svsn3gzsun5b5cf9uLVyqjGI5gXnRKybEfNM/J9pD98r6Tk2N1+CX92oKUf0mzw
	aXuuphc8FE1aaEb9VAP0jID+RhmEbiFHvdVMhgUrZs5DYBcQhi0P27luijqgFnoBJkTSeiWeJrQ
	E9MrBu9pKErDvpS3WqJy8JLzt
X-Google-Smtp-Source: AGHT+IGhE9dThViFZe1QFt4sm/cQOA52RjTcfkrT7ftr8yl7gfauhn1PktZuJ2w0amu5yhU2y/mqIA==
X-Received: by 2002:a05:6830:498f:b0:742:fefe:4311 with SMTP id 46e09a7af769-74569deee96mr13615645a34.16.1757098220481;
        Fri, 05 Sep 2025 11:50:20 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:e171:344b:daa:1a1a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-746db51a7ccsm1049989a34.30.2025.09.05.11.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:50:19 -0700 (PDT)
Date: Fri, 5 Sep 2025 13:50:16 -0500
From: Corey Minyard <corey@minyard.net>
To: Gilles BULOZ <gilles.buloz@kontron.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: Re: user->nr_msgs going negative in ipmi_msghandler.c
Message-ID: <aLsw6G0GyqfpKs2S@mail.minyard.net>
Reply-To: corey@minyard.net
References: <5cc48305-d88d-ac15-ce0d-55306a60a0dd@kontron.com>
 <aLrPbzfho1d2kMsn@mail.minyard.net>
 <aLrRlQZdeToIgPBG@mail.minyard.net>
 <c3c0cba1-a45d-8619-06c0-64046d8ecd76@kontron.com>
 <f14bd1ca-c47a-13b3-fd5f-5f5ad0c89fad@kontron.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f14bd1ca-c47a-13b3-fd5f-5f5ad0c89fad@kontron.com>

I'm adding the OpenIPMI mailing list and the LKML.

On Fri, Sep 05, 2025 at 05:04:28PM +0200, Gilles BULOZ wrote:
> Le 05/09/2025 à 15:15, Gilles BULOZ a écrit :
> > Le 05/09/2025 à 14:03, Corey Minyard a écrit :
> >> On Fri, Sep 05, 2025 at 06:54:23AM -0500, Corey Minyard wrote:
> >>> On Fri, Sep 05, 2025 at 10:16:19AM +0200, Gilles BULOZ wrote:
> >>>> Hi Corey,
> >>>>
> >>>> I'm HW/SW developer at Kontron (computer manufacturer) and don't know what to
> >>>> think about an issue with user->nr_msgs going negative in ipmi_msghandler.c.
> >>>> Not sure if it's a weakness in ipmi_msghandler.c or a bug in the IPMC software
> >>>> of our computer board (satellite) with event messages.
> >>> I worked with people from Kontron a long time ago.  Those were good
> >>> times :).
> >>>
> >>>> I see this when I run ipmitool on this board while some event messages already
> >>>> available. In this case deliver_response() is processing the messages and is
> >>>> decreasing user->nr_msgs below 0. Then when ipmitool calls
> >>>> ioctl(IPMICTL_SEND_COMMAND) it gets an error with errno=EBUSY because in
> >>>> i_ipmi_request() user->nr_msgs is incremented but still negative, casted to
> >>>> unsigned int so becomes huge, and found greater than max_msgs_per_user (100).
> >>> Thanks for the detailed description.  The fix for the bug is:
> >>>
> >>> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> >>> index e12b531f5c2f..ba33070622b1 100644
> >>> --- a/drivers/char/ipmi/ipmi_msghandler.c
> >>> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> >>> @@ -1634,6 +1634,7 @@ int ipmi_set_gets_events(struct ipmi_user *user, bool val)
> >>>
> >>>                 list_for_each_entry_safe(msg, msg2, &msgs, link) {
> >>>                         msg->user = user;
> >>> +                       atomic_add(1, &usr->nr_msgs);
> >> Sorry, that should obviously be user->nr_msgs
> > Thanks very much !
> > I've tried it with kernel 6.11.8 and it's better but still not enough.
> > Running "ipmitool sensor" with some debug in ipmi_msghandler.c shows that I always have nr_msgs=1 right after the atomic_add (called
> > 9 times), then when in i_ipmi_request() I reach line "rv = -EBUSY;" with nr_msgs=-2 (twice).
> My understanding is that ipmitool calls ioctl(IPMICTL_SET_GETS_EVENTS_CMD) calling ipmi_set_gets_events() and thanks to your patch
> for each event available the nr_msgs is incremented here and decremented in deliver_response(). So your patch is OK for that.
> But after that if other events are coming, deliver_response() is called and nr_msgs gets decremented. So when ipmitool calls
> ioctl(IPMICTL_SEND_COMMAND), this calls i_ipmi_request() with nr_msgs < 0 and that returns -EBUSY


Yeah, after I sent my email I started looking through the driver for
other issues around this, and there were several.  That change wasn't
well thought through.

So, I've added some tests around this in my test suite, and I've
reworked this to be a much better implementation that's harder to get
wrong.

I'm going to send the fix in a separate email.

Thanks,

-corey

> >>>                         kref_get(&user->refcount);
> >>>                         deliver_local_response(intf, msg);
> >>>                 }
> >>>
> >>>
> >>> Can you try that out?
> >>>
> >>> I'll forward port this to current kernel (if appropriate, this has all
> >>> been rewritten) and required a backport.
> >>>
> >>> Thanks,
> >>>
> >>> -corey
> >>>
> >>>> As workaround I set module parameter max_msgs_per_user to 0xffffffff so that
> >>>> user->nr_msgs is never greater than this value.
> >>>> I was using kernel 6.11.8 but updated to 6.16.3 and get the same issue.
> >>>> I'm also not sure if our board is supposed to receive such event messages as
> >>>> it is not Shelf Manager, even if these events come from the local sensors of
> >>>> the board.
> >>>>
> >>>> Best regards
> >>>>
> >>>> Gilles Buloz
> >>>> Kontron Modular Computers France
> >>>> R&D SW/HW senior developer
> >>>>
> >> .
> 

