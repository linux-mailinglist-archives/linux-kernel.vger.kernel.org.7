Return-Path: <linux-kernel+bounces-764545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EAAB2245F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97681B66E16
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C948A2EBBAC;
	Tue, 12 Aug 2025 10:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yv4OyQit"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82B52EAD15
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993574; cv=none; b=qd/LifzvDqoSHgTDiFwXsj+jeB7i/ezU2YquEp6zToPFv5n32p3idFynjAa/2gzZ11uBWkiHPQg1yaZywTYi0yKDHcT2LBDt2tGLErOKsup3Ddue/q08jJxHPoRjBQ/VqVJUOOyFKYbTT0sEKfD/fdLYd+4LJdxSBlw9ev7hqJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993574; c=relaxed/simple;
	bh=PyDpZGaB9vjnuyLEg74orsTYp6Uqpd3EwERmpZJtIak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eg2huWXayWdMRuct5MOyJDa6RYJp5Wu2Xvo3gnzP5VWFZhVK091B3VkcJVQOOViWZeiMxsa54WEJoEED7yKyVtHbKtF3ofcWyBoWejFuj4qrNwnlyrpP23sh+HlqXmgrfKmMJp6XY7twW7xq/1vr3isg0C3UE+cwdXY3VqDqYg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Yv4OyQit; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-af95525bac4so943128466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754993570; x=1755598370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mKuuXxUGx7wqBMRdZAcbFUxPV6FoMbOMnsurp8d6llI=;
        b=Yv4OyQitvCBEnND9LxFaZcjnqnSIBT7MTeIye6OQ1Rup/7rmvGTOZNdJuFaUYX+HiC
         pFcZ473Z5Ulu1SHyphkMkNMKroUlFoy2ldif79S7qQiDvDZ8dpyhS0TvWqRNbbeBhhAM
         t/exTaVRYTmshrPSM5PfcqlIOksKN/GWuaE8R4VHg03VMnMi5klpiOdb4vO/vzm9/9B9
         XRLdEHLHPr09ifBM+aWMCxHW53m5ihqq/ShZUaeOv307IUUbGV8ZcwwwlosIqMfcwunf
         Z9FD3SJk8Y721VTINdNSRqmqYMpr9GsER/U7hXwpWuZGUGgPDacd29n3+Vl5xdO6yb0F
         DubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754993570; x=1755598370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKuuXxUGx7wqBMRdZAcbFUxPV6FoMbOMnsurp8d6llI=;
        b=kN0eLWzsxo6zCi28+XGJe8OcvNrcLaqSRfcFpmlPu+TB2es8+xy/L1+G3An+aTBD1m
         nREcNTg9/nlL092gHdUayMu1LtVJmnL0iZBcIPKHYjUStGXGodAI/0c0WDDlRoZZPvFZ
         2Ex4SA60WAuaLc0rymP8wB6/1A6eEaGZIsmHriVyApiGjhLVZcnVZeF6q323lfScnEC4
         NEcRZ5oqdcvHk1k10BOFHZksjqgns2pL0kUqIqq/4heS83z7q+aIPgQPJ3uhYkkEnhPp
         HnYro5/RP0Xjpy/JoF11E9b/Ci12zGaNGJ0c2vZfekN0pVtg2UUwqeyrsBKKqolptgXs
         PzQw==
X-Forwarded-Encrypted: i=1; AJvYcCV5tAz+Cs/yS45gtYZMumj5xnqOEAwPqhxjMR/qZYXf0Hr1Mir0bE6W1OS97Poqal7pR7HwS//9RR2RK/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFMR5acDvyK1TDk59nPhugi2X856+IXDGDcj/xPBmj5IzwW0k+
	dcTLkBBk7FAiyZvt7AmtmbIjOveJE/RoW+Wda3zAnQPHOo6kMUokw6PUQd5V29CbCP4=
X-Gm-Gg: ASbGncsHYOy+hT39emcrP3LuEDFh0WMKSc/mP3s6V4t6wbb6sJdB+DmTAjswBAy3Y5j
	ooEaD+tYUjzsc+LukvubjHfr2J2dk/PR2yYZjHtdORdVx3iNnV75xaJAz4VghnWCIw2HS4EhcDI
	ZnqKvWezNddqf90CEujwyM+HKvC/waavfTCr8CR4K7PL6VALfOAUobxAuvatFwq+JD8XvEJX7va
	MXajUpKpBKTZ5lphukwa8m3pSR6OhrMWq0TeOhqDodFLhYQnyU9UzDyXII00QsojlRRQcTNyrpf
	y1yUdRWurJk9uHB2MLwj4h/ffD0mmXIWR0dvp1lKSD13Vjg384u9lv/RvnCf61NM6lkZR3GUNK8
	Y4BFBVkGdD3ExTQ==
X-Google-Smtp-Source: AGHT+IGhSBYnvUSSIEADULk5kAZzAY2BDjT1cYY5WvOCM5sO15+YHIUScKB6Jyaxjne07hZln9TecA==
X-Received: by 2002:a17:907:1c26:b0:ae0:cde3:4bbd with SMTP id a640c23a62f3a-af9c6540e44mr1477923666b.44.1754993570016;
        Tue, 12 Aug 2025 03:12:50 -0700 (PDT)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c10asm2197131766b.116.2025.08.12.03.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 03:12:49 -0700 (PDT)
Date: Tue, 12 Aug 2025 12:12:47 +0200
From: Petr Mladek <pmladek@suse.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lance Yang <lance.yang@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH v3 2/5] panic: generalize panic_print's function to show
 sys info
Message-ID: <aJsTn82r5uqZ84OZ@pathway>
References: <20250703021004.42328-1-feng.tang@linux.alibaba.com>
 <20250703021004.42328-3-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703021004.42328-3-feng.tang@linux.alibaba.com>

On Thu 2025-07-03 10:10:01, Feng Tang wrote:
> 'panic_print' was introduced to help debugging kernel panic by dumping
> different kinds of system information like tasks' call stack, memory,
> ftrace buffer, etc. Actually this function could also be used to help
> debugging other cases like task-hung, soft/hard lockup, etc. where user
> may need the snapshot of system info at that time.
> 
> Extract system info dump function related code from panic.c to separate
> file sys_info.[ch], for wider usage by other kernel parts for debugging.
> 
> Also modify the macro names about singulars/plurals.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: I know that it has already been merged into the mainline
    but I wanted to double check it.

