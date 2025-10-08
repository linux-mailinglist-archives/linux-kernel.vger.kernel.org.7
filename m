Return-Path: <linux-kernel+bounces-845776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCB8BC6144
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 332DF4EB3D2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C852EBB96;
	Wed,  8 Oct 2025 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WpXuJgJN"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D3C25FA2D
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759942381; cv=none; b=c8hDeEjJ9LPVC0QQDo86SCLqZ1oe2MuqRG6FAWtnAQbCqv4F0/ozYWrStc0mOIdIkX1F9j00vU0zXlc01tMmzgaCQ5bDP6Ku82IzfeDIcHAIA83QV87Si70CXIe6oe40OOD9rsjGVAK8WE8OA4SzbbbhTC3pPb5Pbhe/oH3B/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759942381; c=relaxed/simple;
	bh=Cdk/aO6tvlVhTXsrhkMkGMbUJJ5f1Z/oxjXW1lCVoNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzYYkxXv62pda4m4guSKNVTI0EOFSkRQb3vrw5QsiSAVwm677u23D2IvQ07GFYiig9sWBMYlhoFMbcM6L8F9cr/EAP2vVQPztM6ai60HTSXbiuqz7ClTO6ZAUpCmoUzmG6o754IRCP+UJdQdX2hsszng083YwxPq+/1CNKpnSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WpXuJgJN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27d67abd215so6185ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759942379; x=1760547179; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9EYeVWKaJLduXJ1zMxIN+V+sOd/pgipLt8fA/AHC3Rs=;
        b=WpXuJgJNhFxZEfHytsC5VXISlsJ2pdwIgosJZ8kZELide//0nbRS/8tlNq+gSXunMV
         4HXImnh6tdmR9FOA/oAa9xkjG9rU/Zw3/zAfJZIGIDFVR28qb0cbvY1NZAmU9Rr3z0ME
         NvudjCLuCpOyj/JyihaI2YSn7Qxy05k/zdRU/Lt73eHoSlQjEbawbSK6WZFjZ7vBJvLm
         r9lCqE8wTrSUzrBmX5Db1knklxe1QhP37B7VxdEyk9z5XHEDS7e9q0cCNXghQt/eiSRe
         +HuQ1rA5+5tH16mbAmEXbx4/eP13YHWzd1nRHSqKgb/jdJsnEkYVRM0UjPvoA9FpfC8Z
         gZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759942380; x=1760547180;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9EYeVWKaJLduXJ1zMxIN+V+sOd/pgipLt8fA/AHC3Rs=;
        b=p7rqy6EIRLehvMxxSVBfJf0Tbjge1Rdbks6W7fkbnMksMWEtbGN0dw8D4KF0LqAN7/
         Uj+fY9XbmQHcKXIvNSHenVPi72PYYvXS3B/1XFvcA+sRBBrNygk/iPbjx3vlHxLiNb8B
         zAXTRBj9psCIn+Kd+nzD4dRuqyLtZV5Vws6cv7z2S1w1PyPr0hxYwMzLxi2BsMSc63T8
         kmG8KqAPZziuySFl4ZKtrvkIQOv1mj9X5jIN6S7euzAenIPkTRZYEKqgYUZLDfbO0Fzm
         9SzSZb+o4DpKbAHHlBrfckYNqfk6pggsGfZqW+vFqBr5NYxTbYIhi/ycMq/ZiqLHIEwC
         epJA==
X-Forwarded-Encrypted: i=1; AJvYcCVBlWGSLExF5zrePddH61HWuVEDzv1BiFwdlXIMjieEm/B6tIICxds0Qd2dO94FjVrkzchcmnIo3I6iBgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/sdL4er4xTCbNf83xp3D8/UmxBVKdSG0YLFftfHG6+6Y4GFt2
	954sOF2KZE6q46ORi174SW3w/uUIhXzqWjzcaaBFiw3WEGom994jdYDWeQKH9mCvvQ==
X-Gm-Gg: ASbGnctyTukDmtcwA0fkRpypyjxUOk/blvN4IJGmDb0HSwDij1cwWF+PivqgJ9DDOly
	oZts3Nhc4ZdtMSZj0SAaAIL5Ciy6tCYypaoGNzkYsmITbEefJmR8pW0lZD511TuFO0eRI/uE6TA
	0357aasj+gP5FiyCfR1w8qwnH218/Zok59e3TcxILJbOcBqAoKs35alle8cBYG4hQFO/AvK2Evx
	rWXOYiCtMqdxrQF+KD1jpbAFRZ6I9taUm7yF9IDk0oUC1/lZ2qcfJ2k3/WcmycpAXg3QU0NaYgL
	ajrUF+yxbBfIyVTWAvNQVhCpZbOhUQLh3exHb8QHB85Ma/UQC0DYht+v54jHK+Je+MTCBxlVQGA
	VBrw+ggJe5Oi/Epx6/M78vPBAw1cyAkYIGjB28ytmCtN387sTQ4RRhA7CNj89gYkc1G9QdKcO1p
	Du8Wefd+QmLicS9RuoqHWCot8MQT35klgwHVwUoNscYEAdzsdm3j0fAAbUHzPuHSUxZkHODQSE9
	A==
X-Google-Smtp-Source: AGHT+IHzTEcwMHKZKFietSiNe1qUQn1vA6hRSbT6ZocFw4Y26Trifqiyl9kKxaDDNqG25VyOHaKKZQ==
X-Received: by 2002:a17:902:ecd2:b0:26e:ac44:3b44 with SMTP id d9443c01a7336-2902768e4c9mr6564885ad.10.1759942379209;
        Wed, 08 Oct 2025 09:52:59 -0700 (PDT)
Received: from google.com (235.215.125.34.bc.googleusercontent.com. [34.125.215.235])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b62e121e0afsm15752127a12.25.2025.10.08.09.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 09:52:58 -0700 (PDT)
Date: Wed, 8 Oct 2025 16:52:54 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/3] rust_binder: freeze_notif_done should resend if
 wrong state
Message-ID: <aOaW5s30sRc6gPnA@google.com>
References: <20251007-binder-freeze-v2-0-5376bd64fb59@google.com>
 <20251007-binder-freeze-v2-1-5376bd64fb59@google.com>
 <aOaSA0dPnY2I4a_D@google.com>
 <CAH5fLgiChj29SbwN-5vHhCNzaUa7wewOXe1D8mN3XFfyZr33gw@mail.gmail.com>
 <aOaTgDMY-VvM_r6m@google.com>
 <CAH5fLgha8DdiZ=XyyNRx8Y+GS6SCO2DHF4qMgKwMoq8tUXc3LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgha8DdiZ=XyyNRx8Y+GS6SCO2DHF4qMgKwMoq8tUXc3LQ@mail.gmail.com>

On Wed, Oct 08, 2025 at 06:41:20PM +0200, Alice Ryhl wrote:
> On Wed, Oct 8, 2025 at 6:38 PM Carlos Llamas <cmllamas@google.com> wrote:
> >
> > On Wed, Oct 08, 2025 at 06:34:54PM +0200, Alice Ryhl wrote:
> > > On Wed, Oct 8, 2025 at 6:32 PM Carlos Llamas <cmllamas@google.com> wrote:
> > > >
> > > > On Tue, Oct 07, 2025 at 09:39:51AM +0000, Alice Ryhl wrote:
> > > > > Consider the following scenario:
> > > > > 1. A freeze notification is delivered to thread 1.
> > > > > 2. The process becomes frozen or unfrozen.
> > > > > 3. The message for step 2 is delivered to thread 2 and ignored because
> > > > >    there is already a pending notification from step 1.
> > > > > 4. Thread 1 acknowledges the notification from step 1.
> > > > > In this case, step 4 should ensure that the message ignored in step 3 is
> > > > > resent as it can now be delivered.
> > > >
> > > > hmmm, I wonder what happens with 3 threads involved where the state goes
> > > > back to the (unconsumed) initial freeze notification. Userspace will
> > > > probably see two separate notifications of the same state?
> > >
> > > The way I implemented it, the work items report the current state when
> > > the work item is *executed*, and they do nothing if there's no change
> > > since last notification.
> >
> > Oh I see, then that means the 2nd and 3rd notifications would do nothing
> > as the state went back to the last notification, correct?
> 
> Yeah.
> 
> If the state flips quickly, userspace might not get told about that if
> it's too slow to receive the update, but that's no different from C
> Binder.

I believe the difference is C binder doesn't report the current state at
the time of consuming the notification. So I'm thinking that it would
report two notifications regardless of the state, even if they are both
the same. Oh well.

Thanks,
Carlos Llamas

