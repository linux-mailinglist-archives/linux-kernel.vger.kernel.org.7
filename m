Return-Path: <linux-kernel+bounces-767432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B810B2542A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468F79A1474
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7673E23D7DD;
	Wed, 13 Aug 2025 20:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CBmdxhME"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C4AF4FA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755115462; cv=none; b=kdt6OetPIWZRVyI0Z/wUnMmA3BYISrT7J6bh1Um+IFslV8y9Q/decL/PRjDSpFXXuXwUg9q6MYzzHI7waSn7nwJQqnm8J3Kp3ZgEK8v5tTVOzXPt2PmqWyrcLSNE8W1m76pGvGZWQ/8xymOGq1+un1fkE4BL+RTU9gg1zjotv5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755115462; c=relaxed/simple;
	bh=4wyPneH/nGrgfmIkWdX/AmiSXZ71l0nEriXq1uOG3Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNypqtkws1u6IFLbSZDT0Uj9ANrex5fKYkSyHL/Q036h3tWMHtJfmXZk8E9ar4EYEtjW4NR0PVjNxIqumAgE+LSvvt0JCvXSoUbjcUkOG5K26Vjm6QrRUetO9FcT4lco6zmS8TDxhZeBiBS3jOoACGl2duYf8HoKLZfZSbj3UjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CBmdxhME; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b0bd88ab8fso71091cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755115460; x=1755720260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzHK0GVXrkNcQiUS+Baq2ibSrjcKTe7n1BFVnpn3tlw=;
        b=CBmdxhME9gGQYQOKjv/OGtGWlrXHcrkdUH6bc2gEraj4huRJ+EhWz6nvWUbIXBauDg
         4DsIINr3hdAWAtza7q4sawStdZhmPKPmxo5xxbkzObzOdTaK5i1LRECCJm5IZSSgHueF
         qZfs975giXXTJZMwweuke9C7nRFTcvbiTnUadenPAUsa8XRs+jZfufrg4fEDURPFFbg1
         GWNuQQ+onbFZSgImoENAnSfMVLpT7wGhGSrYWFcyf5r9AH0xh47ptZWtM3S2gA0X40Tn
         9VodYU3Ghn9A1lUHHxgp0BQ0HiLkL2ttHxaElOZnPjBPHbfVxP3oCsa9BKOa/rdtpHgT
         TIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755115460; x=1755720260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzHK0GVXrkNcQiUS+Baq2ibSrjcKTe7n1BFVnpn3tlw=;
        b=S5ZDYlyYk04eSVzs9YnB4uEIphSq2RBxrj9dv6YC+yEqzCJ4g+nwBCz7DEfLlZOmpn
         6/EVMFlnMwTHJQT35IlRyi5K8wYA3EqngFU1PjVAvWW5vagPEf5eVJ4hbyJx6tpsr+zv
         27xi7bCqGiWD75TvGvvnRivmPqo3bzi9fYNYLMGwydnyWCternnu9VmiiOZQY+kPzHYl
         vKfvveWY5tmvbvtI5ZOKvAJY08m4jzQSKAhJo0LW46n0V7F10rzyV0ntwUwf7WrK6gnA
         +hbcjI/HBFa3mWrRw9xdzzk5z1424H0x2mXBrsBZrLTpWoXHJjNnbw7aZHJUsitks2JP
         MZ3w==
X-Forwarded-Encrypted: i=1; AJvYcCVNHB2n+nHFygzn7rb1QSXUTOGkmCtEQ0EgYHQirRcR51oevRB2wlKFIijkDuTNTZJnur2tyt6PV6x5URA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoEzDmnILVb2xZB78LFI6HQdfEk3oWbG0SAIPK10Z0n6sE/28W
	IuP9qrIds8G54lyp3UBJxaJLvvVQhj17adTEi053gTEJvvvV08On3MLng1M+BVjQPD1qJEpMfju
	sTSLwJU1FiRiXc5NOEhd00qx8s2eX2QDfVZBxwkA0
X-Gm-Gg: ASbGncvT8PDumeleSfxEXqnU2S1I8pI5/n9Le7duHj6gY0c/f3FueLw6Z2auv5RzhF5
	QEwIxi43mTsZy+Wl/cpwHgKGtFQ3jObFnNiVlyYQYSsHBtscKzYCFzSB8pCtqiGco4k2oeC+KA7
	Hu+UiIU3yVVaxlPpGtJ8+aeTdzSF3idTNxS85vjvckZXFZLpR2/0ROQ+QM3CjmUw4Py3OkXQLhq
	/BRiMrtFv8AfK35N03ukXLGL1/+gMA5PzFb4WZawre9h6D87l0OCyO/3Q==
X-Google-Smtp-Source: AGHT+IFof5TuMH8+QhHgnXvaTzUr+RXbKEgLUg6pHegzVmMLcAkHrJb3iKJN2OJZj3lXKhEok4WUK44KsW8CKKXI35Y=
X-Received: by 2002:a05:622a:1493:b0:4ae:d28f:b259 with SMTP id
 d75a77b69052e-4b10bc95c73mr132051cf.1.1755115459254; Wed, 13 Aug 2025
 13:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808072106.153449-1-fffsqian@163.com> <91d72c49-22df-43ed-aeeb-0b93a9da3bfa@redhat.com>
 <20250811214053.857168fd35e70e73dee1583d@linux-foundation.org>
In-Reply-To: <20250811214053.857168fd35e70e73dee1583d@linux-foundation.org>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Wed, 13 Aug 2025 13:03:42 -0700
X-Gm-Features: Ac12FXwkRQpdACiVxjXO0NFixyErDF24g59J38UDJEGj7evt80jGZnffIUaV1vU
Message-ID: <CAJHvVchDq-p77VbzO53nNxMTZ-5okMp1SUSQfw_VD3f75fFgAQ@mail.gmail.com>
Subject: Re: [PATCH] Fix the data type inconsistency issue of min (tier,
 MAX_CR_TIERS-1) in read_ctrl_pos
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Qingshuang Fu <fffsqian@163.com>, hannes@cmpxchg.org, 
	mhocko@kernel.org, zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Qingshuang Fu <fuqingshuang@kylinos.cn>, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 9:40=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 8 Aug 2025 09:35:19 +0200 David Hildenbrand <david@redhat.com> wr=
ote:
>
> > >
> > > Due to the fact that the tier data type in min (tier, MAX_CR_TIERS -1=
)
> > > is int,but MAX_CR_TIERS is an unsigned type, directly using
> > > the min function for comparison will result in an error:
> > > from mm/vmscan.c:15:
> > > mm/vmscan.c: In function =E2=80=98read_ctrl_pos=E2=80=99:
> > > ./include/linux/build_bug.h:78:41: error: static assertion failed:
> > > "min(tier, 4U - 1) signedness error, fix types or
> > > consider umin() before min_t()"
> > > And MAX_CR_TIERS is a macro definition defined as 4U,
> > > so min_t can be used to convert it to int type before
> > > performing the minimum value operation.
> > >
> >
> > Please use empty lines to make the description easier to read. Also, I
> > think you can simplify this heavily.
> >
> > We should add
> >
> > Fixes: 37a260870f2c ("mm/mglru: rework type selection")
>
> I'm not liking read_ctrl_pos() much.
>
> Local variable `i' has the rottenest possible name.  In this case it is
> a "tier", so let's call it that.  And its type should be unsigned.
>
> But an incoming arg has that name.  Probably inappropriately.  I'm
> suspecting that something like base_tier or start_tier would be more
> descriptive.  Hard to tell, because read_ctrl_pos() forgot to get
> documented.  And this arg should have unsigned type also.

I agree a more thorough rework to be consistent with types / make the
ctrl_pos helpers more readable would be better. As is, given David's
point about not being able to reproduce this without fiddling with
compiler flags, I wouldn't be in favor of taking this.

>
>
> (cc mglru maintainers, who have yet to reveal themselves in MAINTAINERS)

Sorry for that, I took a look at adding myself and Yuanchu, but it
wasn't clear how to represent MGLRU in MAINTAINERS, because there
isn't a mglru.c, it's bolted on to several existing files with
existing maintainers. Should us two just be appended to the list of
folks for vmscan.c, or?

