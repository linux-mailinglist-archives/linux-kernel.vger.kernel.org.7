Return-Path: <linux-kernel+bounces-762948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542CFB20CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED9A169B0D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BB61DED5F;
	Mon, 11 Aug 2025 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="JpuPeoch"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797372EB10
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923860; cv=none; b=Uz+WvdQo89XquX0wrT8edFEY97L053znh6uxKCrcKrFKGtwfa6jZXZaL9NmikhgXM6jzxnFlufZAUvMBT+ikh10Fe/wAVlaNpcxlZdAl1w18qaFeEUbIDnA7YmFk0mjvhfXlqLJGSPkdtdRDTXFjVD9BQooEr9wduEa6nm6j0Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923860; c=relaxed/simple;
	bh=UrfR5n7IhPYKBi/Lqcz5yk1uTlktmzqQ02/Ydq81H3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMukB2wOe5r1RKcA31LznmxDCFnLVk/KKWzk7NGrQwAMbLKCKweGg12JMKX1a/rpmhVXldwAd67rXBFiETIxtFr7IfG/jIjpUwECQMH8pXXHHQNBwg8Qaw/+sQgUcVH5FjXEOm8YwtTMcSlXQFR1YXuZ3LEDvd8lDWEKdFXjh58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=JpuPeoch; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2400f746440so36956595ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1754923859; x=1755528659; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TqaIrXcHxWrL1H6SRe7KL4MjQpJTbyEPe6hM6UsacwI=;
        b=JpuPeoch2+TxE9As6aoaCEwEBYYUHJdoTLnnX/AkXfYUhYiQaq/SqT9vrjSswyxVpv
         alenS49pEfo88xGu6oOkC5yfkRkw5xYDiZnUUGm0SLu6RdNnAESA6m/W1Ig1AnE959e1
         8yUPyYyiMfvrmKfg/8rzf4/iXvGtdbCIn71Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754923859; x=1755528659;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TqaIrXcHxWrL1H6SRe7KL4MjQpJTbyEPe6hM6UsacwI=;
        b=dNmWj/jpwwx+QCnUAVRoSguhWOn0QtRlenK2RQUusRr2+t50Gak+sVIXIUUQMYnNL+
         iU9bX8xAGOpujVxlKFKXMWB76QbSCUiwUSiJlBbGAU1p/iXri3/1A7FkPQLdqwvSHZO0
         0Rbjlo66UH053kNX+mB4TIjYXACbgF3i00wLoxgNZjyvvPrVHIMj0VdwQmQ1UuOuXC7D
         xaIxvs9B+YYRF0v3lQ/F3ZRNcZSnx6l1uHAMrs06A8T0Y5y15a0SYf/19Jw3b4w1EvnJ
         nONxq+Dhbc8Pm4paZBHmUsKpLHmPlOeXAzkd3o2EdJ6qd+A6aw//b9d7EP6qlEri1xmC
         VrgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKpWcoKQDtXGx8tp72CC/CubIiPXNEv+njGUTSt8SDi2R4gOoXqRo/B+In3a2aTOF/Skea94/iPwo4rOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6VF6rIdYN5sEpjune+aiG/GL1Fk25/hxTwapZngHkD9v9WFFu
	Lx5ofM+RtfqlEPwnUsgC2cIHFh8425kxpHLJdt1PZwXJjM1ZY+RQAmDlscyOjP4AtDA=
X-Gm-Gg: ASbGnctAnCdv3kM7xUUI9sM2Ia8g770GFsnleeSmKUy6bXjmwWTIN8y3G9WCxJmz3Mv
	L9j37OKZhtQlyCU0qtSGajr3HRk8CBTEffOqGRqVyg46GigQs2pOiTinkkN+XQ/qL6bfHMl2rEn
	WNwA+/JlWvCUUDo8mJ5QvjBQ2SIC6rntJXbB+QlaAWqHf0Rua+nmF7XIAZgPekoPcfsOI8L9aSu
	LgkywgxqDUKxk6qwCysyeKxDcxKgYw/Nlt9N+C7+QZqGqF1sBl/Enh3W0jVff5SmO5hr1rUNTQU
	CzLw4F2HIKDPh6r5vMFfEHeOeCM1qT30cknziCd/7qeV9ad2Ynp4JImDG+OXE93dBXi7f6hm8C5
	4RcCEUQL2QT6Vme+eY+uSI6/XHSwIEEIAZqKsfBtN3QcB1QKpGpgYFPZz
X-Google-Smtp-Source: AGHT+IF2BTqUckXG0twZ2kDSE6NTLwtbVM7gMBnyWr2B9RIG1HbA4Y0IKJsLCxz1V0fmyaceJslw7w==
X-Received: by 2002:a17:902:f70f:b0:240:48f4:40d5 with SMTP id d9443c01a7336-242c22c8876mr213888415ad.39.1754923858843;
        Mon, 11 Aug 2025 07:50:58 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976cb1sm276618225ad.89.2025.08.11.07.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:50:58 -0700 (PDT)
Date: Mon, 11 Aug 2025 23:50:52 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Benno Lossin <lossin@kernel.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] rust: io_uring: introduce rust abstraction
 for io-uring cmd
Message-ID: <aJoDTDwkoj50eKBX@sidongui-MacBookPro.local>
References: <aJXG3wPf9W3usEj2@sidongui-MacBookPro.local>
 <DBXTJQ27RY6K.1R6KUNEXF008N@kernel.org>
 <aJdEbFI2FqSCBt9L@sidongui-MacBookPro.local>
 <DBY6DMQYZ2CL.2P0LZO2HF13MJ@kernel.org>
 <aJijj4kiMV9yxOrM@sidongui-MacBookPro.local>
 <81C84BD8-D99C-4103-A280-CFC71DF58E3B@collabora.com>
 <aJiwrcq9nz0mUqKh@sidongui-MacBookPro.local>
 <DBZ0O49ME4BF.2JFHBZQVPJ4TK@kernel.org>
 <aJnjYPAqA6vtn9YH@sidongui-MacBookPro.local>
 <8416C381-A654-41D4-A731-323CEDE58BB1@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8416C381-A654-41D4-A731-323CEDE58BB1@collabora.com>

On Mon, Aug 11, 2025 at 09:44:22AM -0300, Daniel Almeida wrote:
> 
> > 
> > There is `uring_cmd` callback in `file_operation` at c side. `Pin<&mut IoUringCmd>`
> > would be create in the callback function. But the callback function could be
> > called repeatedly with same `io_uring_cmd` instance as far as I know.
> > 
> > But in c side, there is initialization step `io_uring_cmd_prep()`.
> > How about fill zero pdu in `io_uring_cmd_prep()`? And we could assign a byte
> > as flag in pdu for checking initialized also we should provide 31 bytes except
> > a byte for the flag.
> > 
> 
> That was a follow-up question of mine. Can´t we enforce zero-initialization
> in C to get rid of this MaybeUninit? Uninitialized data is just bad in general.
> 
> Hopefully this can be done as you've described above, but I don't want to over
> extend my opinion on something I know nothing about.

I need to add a commit that initialize pdu in prep step in next version. 
I'd like to get a comment from io_uring maintainer Jens. Thanks.

If we could initialize (filling zero) in prep step, How about casting issue?
Driver still needs to cast array to its private struct in unsafe?

Thanks,
Sidong

> 
> - Daniel

