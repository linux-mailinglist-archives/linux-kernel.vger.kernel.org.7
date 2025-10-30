Return-Path: <linux-kernel+bounces-879161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB59C226A0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67F13B20C7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77197329E76;
	Thu, 30 Oct 2025 21:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+c1BmRR"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270CA329E54
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761859654; cv=none; b=anO006cz/C1YzBij0bfwmjD+LcP0FSDT7uxCvxPMMww75MVcocXHWQIIJ+MV5caWTF1z1vq7+ziXHGptVWn9PMtyIovLwpKn81uYOpxHkIgCDjzB+SBuvax47ZvvBDwTSZhP9zO38CYsBc1hSLzFEb3namlcJkfR9eZ7gW6pkL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761859654; c=relaxed/simple;
	bh=+Sl6Z4dyePh+kUuRaS1oDzrsEBPK6/HiJluRs2eyFX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGRyOOmPoxgGjbZS4Graz4yTKTT+EUGAy181G8gDn+Upw0S3ZZ8mQJnGQBWAGQeq9Bbv+Rq/lsy8evEafh7tQaXUShzegs8t4H43xltNOO9d5LoW8rihB86ffJSUfO3611HQG7nBT4G3Ea49JmDfMFrUmUzsB1oe5ZRjr8lRLuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+c1BmRR; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64074f01a6eso1137195a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761859650; x=1762464450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G2gY82C8nLyw94EfwUiPT9I8jzFFk795RN8AeGsby+0=;
        b=N+c1BmRRNt1Bk4l98j4+Pw1muXjrPCFTUMCnmBxmFCg0GNmAxeVu5dloQlY1lex+em
         iBpJykj3dnz0Y0q8O4dRqi/oEt2O7uebBxAbHTkXaqrWCW5OGXyulabMYZzxuLHZAQOI
         U4oipW9kd+4j50beaQy/uXLwFETygPyTNNuW6P/F8TQ6ldAwOfbxIfUZ/ndED6Inwmh9
         sfVIUYXrRa3eje/bC2gMqABl0zmP0DrlH6wjzmdTLG3srwLcF9jM/Y9xi0PG5N6msk5F
         1T2NvoeHS9UzcGPTB8gRQvE7b+9eOIOI4DgW8Eak/LOApWO55la8UDS2Af/So+p/uPyD
         0hrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761859650; x=1762464450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2gY82C8nLyw94EfwUiPT9I8jzFFk795RN8AeGsby+0=;
        b=pwTLBEQcUbwfzFdxIgotn3WfjTfOP5XIntPUFGZLYc2CetXG9gALlOMncZYktJOJLu
         Le4iZdSHdxWxziGIeiedcawqcpUD3lgFqmE7HZ2S3rkJwi8a4vE5y+7F3c1BOn8MBp0u
         PmZ5wiHCUZg+vrtyU6eYuaAOXbI9P73hhPcd67RcBndw5JRoaaFKH8aMTFH1MncKen2h
         uAE0vApdcRVWhzQLB2HUXh4qRoslDAsYah/K2OEUslOokmNfLqe8fp+AMI/YOUiXg4hr
         xj6+vrxZGp7Suar3Yfka5SOaEw2boQoUmjlndyBKZ/s9ELy9hbYPtD0WmObgQUEqpahy
         U6Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXuAi10t2AgFRlZ4HRiURXT6rO3yXY1pWI3Xo4ZU2mhgJ2SyEFm8HzE+1oi0kjjgKsU8HFZ2NgXVOQY/MI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKmbghFGBF+uvqR/9rLKpTfNgU8rYI07+QBdlvFNH41Ec200+f
	Cm2SNDU/oPdR3ewNPXQarU4HxA1AC7m79CfYl+eWdE5rxRCsJNcfaqoDezN/tTr87+C0UQfUNkr
	iCWcnC/LMw1ozGeMqu2dOMpZ41AOU8FI=
X-Gm-Gg: ASbGncuMPs1k4iDiRfWoy39AEqTwvF9vuP6rKQxA4sYWm09Vzsey4z4nVUfAafDd2Pw
	NIx951XhoLbnic4dxcEYWU+bb9BpZ/OVdWuLo5KKYohvp0ZbkUgsaHR+CC7dj+doIFYzybMbqoP
	zlhi858ro8TJpv4jEaSnAYah5/BwPrC9wBZHnbQjMd1jGUc4lIWldUU6HMWAsaREbysrRP1/AMg
	bKOpRH/2uzpPJixsle7uaHdy2IcVaE8l2e/j9kO2WoSxtlhxHedP0K7bEO7BSwVmVZp+O1V1Qcv
	wsFfc2ixjJPgYQMT50OREIFv1YX2oLeUfOA=
X-Google-Smtp-Source: AGHT+IGLu+PCJltWDujSpQPIkY5FNxNB+Kt49ac69OQRIVOUnPy875s9e3ocPHOw6lCdck1PipJMXtwmB9MhLWw0d34=
X-Received: by 2002:a05:6402:1ec2:b0:63b:f157:bc2d with SMTP id
 4fb4d7f45d1cf-64076f6bf8amr902937a12.1.1761859650094; Thu, 30 Oct 2025
 14:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014231501.2301398-1-peterx@redhat.com> <78424672-065c-47fc-ba76-c5a866dcdc98@redhat.com>
 <aPZDVuscFsYSlQjI@x1.local> <dtepn7obw5syd47uhyxavytodp7ws2pzr2yuchda32wcwn4bj4@wazn24gijumu>
 <aPe0oWR9-Oj58Asz@x1.local> <nnxhd7zxjza6m4w4lr5qyev2krbkp4yfcgcwq6nkaqrqt6bzpb@iklep2xxp5gv>
 <aQO3Zko6Qrk7O96u@x1.local> <aQPCwFZqNd_ZlZ0S@x1.local> <d0b037a6-11b9-483b-aa67-b2a8984e56e0@lucifer.local>
 <aQPU-tyo_w68cnKK@x1.local>
In-Reply-To: <aQPU-tyo_w68cnKK@x1.local>
From: Peter <peterjgray999@gmail.com>
Date: Thu, 30 Oct 2025 21:27:17 +0000
X-Gm-Features: AWmQ_blMSRgvqIQWevhuChxEd5G2uJ2xb-qez3wJLdFHrAINA2vrHCmzKSt6Cuk
Message-ID: <CAL_esO2M6Tpqj5zgHXzbx1NKF5pU7kGBM7h95PBZYgf2Rrg8zQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] mm/userfaultfd: modulize memory types
To: Peter Xu <peterx@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Nikita Kalyazin <kalyazin@amazon.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Axel Rasmussen <axelrasmussen@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	James Houghton <jthoughton@google.com>, Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@suse.com>, 
	Ujwal Kundur <ujwal.kundur@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	Suren Baghdasaryan <surenb@google.com>, Andrea Arcangeli <aarcange@redhat.com>, conduct@kernel.org
Content-Type: text/plain; charset="UTF-8"

thank you


On Thu, 30 Oct 2025 at 21:24, Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Oct 30, 2025 at 08:23:03PM +0000, Lorenzo Stoakes wrote:
> > +cc CoC
> >
> > Peter,
> >
> > I'm sorry but your reply here is completely out of line.
> >
> > I know tensions can run high sometimes, but this is a _good faith_ effort to try
> > to find a way forward.
> >
> > Please take a step back and show some respect for the fact that Liam has put
> > VERY significant effort in preparing this after you _repeatedly_ asked him to
> > show him code.
> >
> > I am starting to worry that your approach here is to bat off criticism by trying
> > to wear reviewers down and that's really not a good thing.
> >
> > Again, this is _good faith_. Nobody is trying to unreasonably push back on these
> > changes, we are just trying to find the best solution possible.
> >
> > Comments like:
> >
> > 'Your code allows to operate on pmd* in a module??? That's too risky and mm can
> > explode!  Isn't it?'
> >
> > and 'that's the wrong way to go. I explained to you multiple times.'
> >
> > and 'I'm pretty sure my code introduce zero or very little bug, if there's one, I'll
> > fix it, but really, likely not, because the changes are straightforward.'
> >
> > vs. 'Your changes are huge.  I would not be surprised you break things here and
> > there.  I hope at least you will be around fixing them when it happens, even if
> > we're not sure the benefits of most of the changes.'
> >
> > are just _entirely_ unhelpful and really unacceptable.
> >
> > I have an extremely heavy workload at the moment anyway, but honestly
> > interactions like this have seriously put me off being involved in this review
> > personally.
> >
> > Do we really want this to be how review in mm or the kernel is?
> >
> > Is that really the culture we want to have here?
>
> Gosh.. Seriously?
>
> I'm ok if this needs to be audited.  I have all the previous discussions in
> the cover letter as links.
>
> --
> Peter Xu
>
>

