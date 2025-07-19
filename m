Return-Path: <linux-kernel+bounces-737810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC501B0B0D9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 18:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9CB1890EEE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 16:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B36288504;
	Sat, 19 Jul 2025 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="YDeobr0h"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBDD2882B0
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752941064; cv=none; b=i6zjQ5k3ZrFC47HWm/Oae5LuZHJDtXPO0nb/+c9FmdIskdo3yfwZNJM9ZqT/F6t1+wOaL1bwDvBxIHO1ak4EksBWspY8tiVGpeDN030jCoJBF0SNhmaj/ZL5GBn4xXo0nuJs5rKKZ2nav5Q9gLp081U3zp0baCMY2SBCLEtd5Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752941064; c=relaxed/simple;
	bh=dtOI65LhgHFtv82udLEOmmxkyTgXRIG9O2WAf0dESLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOXOOYMvSR01JqAISOIZ1lpkpcPBtJF5vmsLJ3Yn5InpD2BNR2KQfwonTdndQ/byqtUHbF3eY2sK0fwBhRXIyPPKfdfkmf4FjnrieBo2ijJlDxNl4HIln7cRV/HIeTgcMOVOHNpHjyXugQ0GJWco+03P2iZaNOlvzT9kwLN2GEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=YDeobr0h; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso2705435b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1752941062; x=1753545862; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5d/ib6Wai1Z2ZOHQMq63LhaGxiIClkPv7o7Qpq/YpQ=;
        b=YDeobr0hsKAWnrAZUsAGGZ5ELNVVvihSQZnubYFhEE1oYAZ7U5E3EANRvqlHz9U4Xr
         gmNCjfQRVtL5QcjXEQHr3jBxmPhm5KQJ3V7xiAec/1JfbBdvzONISkC/lCO/plK53c5c
         VsDcEhDmfHODJVsCs0qnnSOK17h73CxR5kVl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752941062; x=1753545862;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5d/ib6Wai1Z2ZOHQMq63LhaGxiIClkPv7o7Qpq/YpQ=;
        b=SQSCuG+4Y5nymoSR/e/JBni1fyyWZZ8s7L39Uj9Pe9TQAjc7lrOv2npx4DvpUefzNt
         gR5dSeCyB1KLq9ib2giT12XiCnUO9CpzDT5//g7BS8JD42MHaBq4jAPgUHc16ArMte4m
         F5PRVrJAkjWOoPIKIzf7G+gE9EfVvMmdIEEa12+qH2jeNsmQ+wQd57qhhezusO/8/UUd
         8Qv0Cn8mlt0DbiC4vL07WMThdh++FcRs6DuF264a7M4zDwGnEU8UOtDII3y15tEzWA9E
         11q4M5u64SJDgL/9L1GRnK+tmo1E7FTeWQfLyO6+7q/U/+4KwSPiQZfKd3gp4VG/9D8f
         iU5A==
X-Forwarded-Encrypted: i=1; AJvYcCVYReaG7zgOfaHlHhzxnTXmFhnzR+rRsjgEE0aJ2HRJtpC8PqrOhHy+ZxgnZPpYy27gGOLo9MgS52QiD7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMPMoiPshEK6SZPwEq8V7/Ta8iVEY1J6s7OJ8ZTiwqv677QZkE
	3cqjVPHpUYctqtyYwAG65ZMBWe0YOF8SE9RlLsEcIexU2sZevGBtqdL2cYAcwr04Drg=
X-Gm-Gg: ASbGncspHKTZ8rTi3as2fH97Hoe/YVQJdoSSasLgVjEQSmDSKDj4eOMSxpvn2CR7iUA
	XdupWElNCPaLiIpFgjwbdmyA6zyFPZg+9veQHSFnJvuw/vRwSrFCh9AifV8Bi+pLfj8Tq5zsJi2
	2HXbXxDKo/Uz0mIwl0rit5PZyIZz2wY/a/AQ+64P6F/hkcCKNAfiorfh7d84Sq9V3qoKVboXEPd
	bUwr3WIFD66Ay9Tg4s20QJUsQBXdrRDVBxpsRiMNYiVWvF3+NjHtrnAyFJ3UFOgRLxXXi3rWa11
	yoIxsP9FQ6HtNWnz0e5b3Qxzk5le+XciCoe8H9mOT16f03RAlky0qANbYUyuETJvjvs8HjqgT+N
	jrXkPy3NTVHKE6H899mbo
X-Google-Smtp-Source: AGHT+IH83v5eeEPPaT8st6SyrtwMkBgJMeKccmYxqQZlY0VGJM8lFIkCGR8IEOwRJZLtQja0yF7isA==
X-Received: by 2002:a05:6a00:2d08:b0:74c:efae:ffae with SMTP id d2e1a72fcca58-75722376ce1mr16590166b3a.5.1752941062361;
        Sat, 19 Jul 2025 09:04:22 -0700 (PDT)
Received: from localhost ([101.127.220.50])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-759cb157629sm3063739b3a.87.2025.07.19.09.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 09:04:21 -0700 (PDT)
Date: Sun, 20 Jul 2025 00:04:19 +0800
From: Chris Down <chris@chrisdown.name>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@fb.com, Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: Mask data status from LE ext adv
 reports
Message-ID: <aHvCA4YFoQPbFChv@chrisdown.name>
References: <aHfd_H6c9MheDoQP@chrisdown.name>
 <CABBYNZJo48983SWhxcB7UzWXPeUofRCMhQ8mJjih-rJoTET3_Q@mail.gmail.com>
 <aHoCQ_RfBl5Zm4oQ@chrisdown.name>
 <CABBYNZJ60JUyz30u8QXvv6OO5dAu1A5-JDB_jJ=H_yR6+WYfng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CABBYNZJ60JUyz30u8QXvv6OO5dAu1A5-JDB_jJ=H_yR6+WYfng@mail.gmail.com>
User-Agent: Mutt/2.2.14 (516568dc) (2025-02-20)

Hi Luiz,

>Try to capture one of them using btmon and then add to the patch description.

Thanks, I have one now and will add for v2.

>> >> -       if (evt_type == LE_EXT_ADV_NON_CONN_IND ||
>> >> -           evt_type & LE_EXT_ADV_DIRECT_IND)
>> >> +       if (pdu_type == LE_EXT_ADV_NON_CONN_IND ||
>> >
>> >I'm not sure I would keep checking for  LE_EXT_ADV_NON_CONN_IND, maybe
>> >just return LE_ADV_NONCONN_IND, LE_EXT_ADV_NON_CONN_IND is not
>> >actually a bit it is the absence of any bits being set, so I guess the
>> >only invalid adv are the ones for legacy which seem to require a bit
>> >to be set.
>>
>> So are you thinking of doing this?
>>
>>    if (!(pdu_type & ~(LE_EXT_ADV_DIRECT_IND)))
>>            return LE_ADV_NONCONN_IND;
>
>We can probably return early on if (!evt_type) return
>LE_ADV_NONCONN_IND since there is no point in evaluating it if it is
>zero.

I guess you meant `if (!pdu_type)`? That correctly handles the 0x40 case (where 
pdu_type becomes 0), but it would miss non-connectable directed advertisements 
(PDU type 0x04), right? Or maybe you meant something else?

