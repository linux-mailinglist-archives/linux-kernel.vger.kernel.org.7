Return-Path: <linux-kernel+bounces-801685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B8AB448C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A0E1BC2B7F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DBD296BBE;
	Thu,  4 Sep 2025 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3n/qL+w"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358F1BA4A;
	Thu,  4 Sep 2025 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757022367; cv=none; b=T5u9Hcp7JlYMOjxYS8OUuHoETZfebgpCSeRvBL3XJ/PF/EGFQTnnR+y2ziG4Jc8uJk7CY4WrvyJbhSdB/GoGzTJ4+eDiNcxnBsWdozjovVsL5VSzRb2eudgap+WOH+D4mEdNGOjK5e+qTmKM9w4vElo+rXdB1p2De2Zos+vy1lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757022367; c=relaxed/simple;
	bh=Y4WScoMBSoQ0K3o9GeRyrWn+v8aRfgQG6RE84ONiSK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0vbEjr9oNMnJ3Z6Ldj1IfKa9a0hOB3wjiS8yb4UNrKV5Pfnb5iQyTTBnLbMCr2B5tJFkOHujl/5SmnucvYhAOFjkhDNZaPfEmnGjOY0GagBQRH+/hNLlqm5ByQ7CNIbcYL/0pRHEKcjYHBxF3zJ3m99OD8Ny97I93uHQPSv6Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3n/qL+w; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-723bc91d7bbso18358997b3.3;
        Thu, 04 Sep 2025 14:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757022365; x=1757627165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2dxmIK87Es6+ed8yKW7yiT6uue3ZfsQixPgvt43/STU=;
        b=E3n/qL+wMeQL86+qrOQk2v0pDhEUY9554RJnKywfh47UFev2RoECbqL+t+weTF5bRd
         1mnGA3yrVGrwj6mrHeAcKR9AQZiXwKjN2tbHszaLfi5qm4EfPZD8nMSonEan3W3mzNrd
         bl9c93/Rn7YTRT/oCIeCSLQz2TtHdKg32oFJyq7So5JVX/9pWiqxCbghS/5jmyfC9nWj
         9LOfT7D3lb8AyudeD/8EGMN6R2V2rJWzVesGYz9OeFZ3SHq/oOGSqkFchMdfJif+5F+5
         VPEu4EnrvQm9ynGmVBvnxxUgU3MGsYURHhd8j67del494TanuOk8JqOBodKQKqUsqavX
         VnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757022365; x=1757627165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dxmIK87Es6+ed8yKW7yiT6uue3ZfsQixPgvt43/STU=;
        b=iRwmRAyiZcMkV3xENQ6ISSG5vHf6fQX9rmeQ2tQUmNf6lf540x02RYk1qt1kQv4X4q
         nd3QJwr1myFWn0IzDaO1joWo3Iz3SZQEq423H8T0mIhlXBi6n+z6+M8MhsfvwlWIb2nW
         bgcASZuhvD7DUOX2LMhd5yeQqh+4dbYo505N69yn93lQAnKD0wr+uM3kMX8g6mPnYF10
         cEB8qM2NhgGAlpd7JFnT5oKfSDXIBPOve01pcdPJmWZ1z7iUq/zQdcwL8oFzJI+wbEe2
         sPHGgcCnBDCsW2deONoMT5UMKu2/b44xSj2rWh8r7bGjjUaUu/o5eDIG//dMWzhLRL/o
         Y4Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWU8deC84Ca4e7uAEd4Y46VnoyQgG98hafI4GgH4wl2RTYXLUXKoSVIkl6kD3bE+3L1AOb5ZX5TacXfIeQ=@vger.kernel.org, AJvYcCXauzQJbBuQ5COdM4shEfyVwrRKOZxL1ojQxguJas6iqpYWZ3UBMMKD+oo0YTbg0tJkp7qZspbrTo2UItu9n70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnX4Pg+MSkJMbVkZtcTZDTWPWTK55uMUy97m81+k98++aqcurL
	TAb4/fAxDKuFZFk+fvTPsICBxqAcyy1ZQvvxbCUU9TQ155FJjie04HzM
X-Gm-Gg: ASbGnct1VMgIlwmu8C6MiFHBjJB3LuwksIpIraWSCM8o8jPstixbyOUbeqm2TkB5Tyb
	JWzIfGzDnGXn7u9dprv34TCHXfWFNDazgANi44LArLZSnDeoYcC0Y8O36IDgDyq1oTRHRdq4jBI
	Zf++AHQhdF+GTlPdgIwGGpSH4wKOHXs+Ko/CT4twGUU+f7KbQueIsXfd10UlOvT+8S4XKIBDgNQ
	3pY4Q8nu9+vsnZTF1ccajpg+bTl+f0Hbzs7WbeqXfIUmreIYwdIzezxZG88oIsKtFKCSMDXzNgw
	XSFXbqA1+0yviTFbh61N58U0KOZgLpSChbEoazR5uNKK3Pc2LGxZHgX8NBJesoJp7FkrBKMmKLq
	hb9uyEdxpbpAtuPY6w7fG80sDGlKREYFoRenXdMoOtMU=
X-Google-Smtp-Source: AGHT+IFMi8TYlY3AfynFMyr7MO2wBtRPKgDfu06foXlotOWPPhYh6f2Czm6tvqNfbPzn8j5BUU9pJw==
X-Received: by 2002:a05:690c:61c6:b0:721:5b31:54d7 with SMTP id 00721157ae682-7227635bbcfmr192690397b3.7.1757022365134;
        Thu, 04 Sep 2025 14:46:05 -0700 (PDT)
Received: from localhost ([2601:347:100:5ea0:1218:85e4:58ab:e67f])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-609d205c24dsm632727d50.0.2025.09.04.14.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 14:46:04 -0700 (PDT)
Date: Thu, 4 Sep 2025 17:46:03 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Mitchell Levy <levymitchell0@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Tyler Hicks <code@tyhicks.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 5/7] rust: percpu: Support non-zeroable types for
 DynamicPerCpu
Message-ID: <aLoIm94aP6Er0Gn8@yury>
References: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com>
 <20250828-rust-percpu-v3-5-4dd92e1e7904@gmail.com>
 <aLi-7W21N45fBGJk@yury>
 <68b9f5e2.170a0220.1224d9.5d3d@mx.google.com>
 <aLn4bopPt8uS4d1O@yury>
 <68b9ff1c.050a0220.35de1d.11b7@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b9ff1c.050a0220.35de1d.11b7@mx.google.com>

> > 
> >         for_each_possible_cpu(cpu) {
> >                 let remote_ptr = unsafe { ptr.get_remote_ptr(cpu) };
> >                 unsafe { (*remote_ptr).write(val.clone()); }
> >                 let arc = Arc::new(alloc, flags).ok()?;
> >                 Some(Self { alloc: arc })
> >         }
> > 
> > Is it possible to do the above in rust?
> 
> Ah, I see.
> 
> The syntax would be slightly different, probably something like
> 
>         use cpu::for_each_possible_cpu;
> 
>         for_each_possible_cpu(|&cpu| {
>                 let remote_ptr = unsafe { ptr.get_remote_ptr(cpu) };
>                 // ...
>         })
> 
> it *might* also be possible to use a macro and dispense with the need for
> a closure, though I'm not familiar enough with proc macros to say for
> sure. That would probably look like
> 
>         for_each_possible_cpu!(cpu) {
>                 let remote_ptr = unsafe { ptr.get_remote_ptr(cpu) };
>                 // ...
>         }
> 
> though personally I think the first one is better (simpler
> implementation without too much syntactic overhead, especially since
> closures are already used some within R4L).

Sure, #1 is OK if you prefer it.

