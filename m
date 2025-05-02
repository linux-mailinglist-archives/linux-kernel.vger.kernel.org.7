Return-Path: <linux-kernel+bounces-630375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD913AA793B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 20:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506D63B18C0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 18:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B411DB125;
	Fri,  2 May 2025 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ypbvoqXw"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D471411EB
	for <linux-kernel@vger.kernel.org>; Fri,  2 May 2025 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746210083; cv=none; b=a6U3O8gMASd17UuLam0EnXKcxY3CEctChYya2VqLuT2YVzLf+N04jENusLrNPmrGsEJwITOVhK4O4dOGl8E//kOOZo9n6Hq1cZ++wylgd3nwKSyZy7uBPRA/8OJTzqKj1IY6HL7iEdKk0q0z6Ageyvaa9I4/h1wB2MDdvoMpFVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746210083; c=relaxed/simple;
	bh=2WAMa5lmi4lEi4ASbBbqVXM5gRQJLj8uyHr1nQ6tpio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rf+3OI16kEWBKij0mxpxBG5ApMUgKzvh1pwk224iSah5wq6WhsR23z/sbfBenNimLvufowjmjdE7mKzRBMChLjkTQMVhzRNGzrAC+aW2kpif3BziGEkNrUxABBZfkZRA+tcXX+sN1wdiZx9EMGv8xuz7sD/HOJrtyHoG7saHocg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ypbvoqXw; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2c663a3daso435884966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 May 2025 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746210080; x=1746814880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkMbn9QXaGEw1P97vg6t7ERPvjjVBU2OczUa5ek4HA4=;
        b=ypbvoqXwliPdsMPHAqRpYuOsGSXps19dsakqwFtVJV5HCu7/AP9HQMQgJJkMPiE6qU
         06Fc6dlPMR6F10mezDVMOiDE4cFbmmtRLnyBWB0J5yBHULIRuLw+HWZegNh2gOiReS+U
         4ohl6ln5TDaWBoQh7itolAPHn14w9/Jm6mTzU07ZjMjE/H5XcuQmFpjRenzgay1ChXNv
         Z58F54GyJXJ4xh/2mZJ/UV3Kg1NLS+Nqdr7DqTcqK7Vkn2T8EanQNBkQDJU1tzRSwu5w
         FqprMRc+3jyWcwvAaquVqZxFGzNcRPdyiu/94d0VNFOwNifVq3sMDeK3xzs/itdbikEv
         IP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746210080; x=1746814880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkMbn9QXaGEw1P97vg6t7ERPvjjVBU2OczUa5ek4HA4=;
        b=p6iIZ1MG69+HWvgfE1g+0Ibck8thPIyEGNIEdvJfZdSNp71SwCKrbDEyBE6ELZ7pHU
         3iuznLMxhtwg5KNVYPKDezsNTe4p98PzGNHKrLMY03SI/hV3xDmEufVGUFjES0tESwVN
         +hO4aU0Gb0fZU8DyAT3MtG1/HL8dYOSHCag7I22GVyOFyYg2XNyds7Vdp1OFh1/mZ8gT
         rSbzxSLVpV44gHe321ZwIPmUSqGAufcXO+Ieb1YJfcgcBYTWd9l8wwJyMom/lmcnojeW
         7gFRKSLxu+iTqn9oh+5llrLmcpAObP6EyxWV7MC2u7sGc9JYnzlmKQF/Zq7ark/X5jgF
         jvvw==
X-Forwarded-Encrypted: i=1; AJvYcCX2I7cbtXGJMCrNJoVkoWD6kwyVSLsGFCjeOQtDFXJIQS9BX9Urb4w4cLgbh6LLzMWMiO/W2mfnpZZ/eGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQEHxVrKAAR7POmGecuNonEsEwhwfPyuebyoaMyW/AFHjGvr2F
	H5kCbt/z4vynqRv2yFUQB9jr6CwCqTlb/3ASeFQ4Y25azJnKTkhaa103kZGjyQybIAWtPhYB3mo
	j/9i11NggzeLrUlWpjpXn0+u4WQR+t19ukQ+i
X-Gm-Gg: ASbGncvWWNUsteXmBYzxRXpHzE8UKjCPQaNIDrQiqYIb7SVOEwWFQu1K4Sb3MEaTkTo
	6EXOfYcc+ofmt+CNCPYlEq6mSG+CIKiY65R/XmSbvfDgstYH6p6p/kzSJmlEBkXfYhO6b1YKR3v
	TsNrYUvQnkc9gZFk8PTpu7t/P2mTRM3reWxcPDOKzkV4k10caNgoeqQMSuHdAZkEx2iQ==
X-Google-Smtp-Source: AGHT+IEdf5njijWY0ZrOWI1O0+1uGtYv2R15+pc7DLL6yq2G2gQkjnd/PdMfxhmqzzN2hFNRZe6U6KwT1CdUdShaq+E=
X-Received: by 2002:a17:907:c297:b0:aca:c9b5:31a8 with SMTP id
 a640c23a62f3a-ad17af654d2mr303967966b.45.1746210079771; Fri, 02 May 2025
 11:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430140611.599078-1-tmricht@linux.ibm.com> <aBT0a5lGzUSLpWpX@x1>
In-Reply-To: <aBT0a5lGzUSLpWpX@x1>
From: Chun-Tse Shao <ctshao@google.com>
Date: Fri, 2 May 2025 11:21:07 -0700
X-Gm-Features: ATxdqUHVxQdL0GCWAn6KorP0yATuhPIQ_Bazh2IodVceKAzOSd1WOrk1KyonOi4
Message-ID: <CAJpZYjWW07J8J40ygx6-5q_rfKEoz2g0VYCC=Go3PM2pBKvDRw@mail.gmail.com>
Subject: Re: [PATCH V4] perf test: Allow tolerance for leader sampling test
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

I submitted the patch v1 and Thomas helped me to modify and submit v2
and v3 while I was OOO. In this case I am not sure which one should be
the author, maybe just keep it as Thomas.

Thanks,
CT

On Fri, May 2, 2025 at 9:35=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Wed, Apr 30, 2025 at 04:06:11PM +0200, Thomas Richter wrote:
> > V4: Update to be applied onto linux-next
> > V3: Added check for missing samples as suggested by Chun-Tse.
> > V2: Changed bc invocation to return 0 on success and 1 on error.
> >
> > There is a known issue that the leader sampling is inconsistent, since
> > throttle only affect leader, not the slave. The detail is in [1]. To
> > maintain test coverage, this patch sets a tolerance rate of 80% to
> > accommodate the throttled samples and prevent test failures due to
> > throttling.
> >
> > [1] lore.kernel.org/20250328182752.769662-1-ctshao@google.com
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
>
> But who is the author? As-is this patch states Thomas Richter as the
> author, but since there is also a Suggested-by and Tested-by Thomas
> Richter, it makes me believe the author is Chun-Tse Shao, is that the
> case?
>
> - Arnaldo
>
> > Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > ---
> >  tools/perf/tests/shell/record.sh | 33 ++++++++++++++++++++++++++------
> >  1 file changed, 27 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/=
record.sh
> > index 05d91a663fda..587f62e34414 100755
> > --- a/tools/perf/tests/shell/record.sh
> > +++ b/tools/perf/tests/shell/record.sh
> > @@ -240,22 +240,43 @@ test_leader_sampling() {
> >      err=3D1
> >      return
> >    fi
> > +  perf script -i "${perfdata}" | grep brstack > $script_output
> > +  # Check if the two instruction counts are equal in each record.
> > +  # However, the throttling code doesn't consider event grouping. Duri=
ng throttling, only the
> > +  # leader is stopped, causing the slave's counts significantly higher=
. To temporarily solve this,
> > +  # let's set the tolerance rate to 80%.
> > +  # TODO: Revert the code for tolerance once the throttling mechanism =
is fixed.
> >    index=3D0
> > -  perf script -i "${perfdata}" > "${script_output}"
> > +  valid_counts=3D0
> > +  invalid_counts=3D0
> > +  tolerance_rate=3D0.8
> >    while IFS=3D read -r line
> >    do
> > -    # Check if the two instruction counts are equal in each record
> >      cycles=3D$(echo $line | awk '{for(i=3D1;i<=3DNF;i++) if($i=3D=3D"c=
ycles:") print $(i-1)}')
> >      if [ $(($index%2)) -ne 0 ] && [ ${cycles}x !=3D ${prev_cycles}x ]
> >      then
> > -      echo "Leader sampling [Failed inconsistent cycles count]"
> > -      err=3D1
> > -      return
> > +      invalid_counts=3D$(($invalid_counts+1))
> > +    else
> > +      valid_counts=3D$(($valid_counts+1))
> >      fi
> >      index=3D$(($index+1))
> >      prev_cycles=3D$cycles
> >    done < "${script_output}"
> > -  echo "Basic leader sampling test [Success]"
> > +  total_counts=3D$(bc <<< "$invalid_counts+$valid_counts")
> > +  if (( $(bc <<< "$total_counts <=3D 0") ))
> > +  then
> > +    echo "Leader sampling [No sample generated]"
> > +    err=3D1
> > +    return
> > +  fi
> > +  isok=3D$(bc <<< "scale=3D2; if (($invalid_counts/$total_counts) < (1=
-$tolerance_rate)) { 0 } else { 1 };")
> > +  if [ $isok -eq 1 ]
> > +  then
> > +     echo "Leader sampling [Failed inconsistent cycles count]"
> > +     err=3D1
> > +  else
> > +    echo "Basic leader sampling test [Success]"
> > +  fi
> >  }
> >
> >  test_topdown_leader_sampling() {
> > --
> > 2.45.2

