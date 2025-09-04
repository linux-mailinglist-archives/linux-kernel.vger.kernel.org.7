Return-Path: <linux-kernel+bounces-801403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DF4B4449F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0DD17B9D7B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDAB3126DB;
	Thu,  4 Sep 2025 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TE1vVPb0"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA0B30CD95
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007833; cv=none; b=XK39qQ+tQRiUZEl9MU3yc7LqUJpQqNWuGHilrF6j5RLF2NlEbdcei8SoRIDYY2uNcA3s8NW/H1lTubV4PXaRA4v7A92xr6iAitbW+X3u269kUX/c/lz7/G7jQ/dhruBcpAz4AqTb6eEM8nOdUVYgANlFoYy+kJtCk33ju1V4sgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007833; c=relaxed/simple;
	bh=nvtjTRQxSbVnjS2GFpfTukafqkG6VSPv0h4nKpUgFaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDpPjhPuS5usVw0H3bGDGW9Xhng89RrAx8rFpqn0tq1M0t8Wb9xHXnbPLRQoEEdNg0+Ziu0yfgnkx14McF1kfK9qBS7cD/ugxlA0GqeILoa3n+lFWO7KMpxuHK/aLFJOy1rUN3cOA5tsQA7j3l2FztQnhaGKlEo4uOCfioYvljs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TE1vVPb0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24b2337d1bfso19415ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 10:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757007831; x=1757612631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wWbc1gScFbVDYqIT9xFJKpu1PWDgbhL6vhmg/aRJGY=;
        b=TE1vVPb00EWEQpVe5fcpCOJPQ+MvgOw5n85Jj7LULfNX3mBLs0S4gIhRqQwlXQjmon
         TyiEf4+1hGqib61dfA4W108G4420I3JS7HRS4poeLJF0aG8A5ObOLS4En9oVTgKVlGvE
         G3x5+Sq4NbIteLGj/K2eZvqcIHlHJzBXq2B1dD4zpabys09IfOf/qoB1N83Hk/AqPgt5
         Pg2H5QpdSRAMiBJFCupk7s50QXh9EgjPjex1Qo9AojFPqC2YwEqTItveiKMw6B2DvPSn
         dHKTuDOFGqvpmQZgXvqTzNjEWQUAMTDPnWmlstetbiTFazsCa7z63HojqadkooGCdB8Z
         +1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757007831; x=1757612631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wWbc1gScFbVDYqIT9xFJKpu1PWDgbhL6vhmg/aRJGY=;
        b=vsyR0FEBtvMlV2tXziGSgyMVhxDriNKCZp+Msy97M3Bg0QC9FdkustuD0rMhB2u4nB
         cdvG3R1hn/md1/R6TlLSUkMQRZLWXgwjTkxZ8S+1zcllpfY60PgizbC46y/shG1r3apS
         KoRGE4XF1xil0C1lS2yEYh+qtrx8WGO+DYjqeQwaz4XlWfAAACEGhaSTfWqGmUFIU+PE
         ui4f9apRvJFe1AfDUnYVcsT/TA5q9Yxg1HxckSZQD0mvGjgNhovlWFRlpw08vgH1A2GY
         Fp8gC+GaAF+OvGDdVLSKATRW/6aNODux9JdpytLQrVI6P8WMzRZfdmRduLPp9T6cAR7i
         S3RA==
X-Forwarded-Encrypted: i=1; AJvYcCWzkOC0fGCNt+Lhn2WnP6mGlApHYJMD9kUJtm7/iHfaVM/CwRFsxI2pYAOljY/yOkRN1Lf9W2s9i8igHek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8IZykKABa4Doc2cGY5dXHBpBrXBJ7X8jVdE3UmlVzazNBJshs
	CCuxZQr6VgSdoe2LwdC1c4CuphuaSbten34jdjzZEwmgJixg2Z+nE9U4uh0azlA8d/WPTkirAE2
	W2d6OnvY2plbPdOOvXrByoS010gb2/Fr6fVN7Zpz/
X-Gm-Gg: ASbGncuevmupJtx7tOBeETtKVkNGXQcw16xA648I7RD5xDtEfBUPSNfl2x5yJxHDMRW
	S0+1TjMxsooW253Sgb7wTF+KsDxa4FUceNgFanpNALaB4Ahm4ona2al59K7LD5H6zeSu8t0Gc9U
	GR9+MgnTdH3XDC43g5SVEU27YVAeOqnzfPO+YOrr316rhg70KdnWtjlS5661QlQnb0GfGlbCov1
	aQ0E/WGii7rViDlmTRYxrPLNb02uuOfUH2DnG7VrgPCZNidRMj739U=
X-Google-Smtp-Source: AGHT+IFroDM4Brfkdoh6XHD17Mw5Q+wL7QsYilpxVXqgsw9AcRCm8Y2S/sHTZ0sspf0CyKz9yiAXKqbgpVOuuSHbKe4=
X-Received: by 2002:a17:902:f693:b0:248:9d28:fca with SMTP id
 d9443c01a7336-24cf5c4af03mr42785ad.14.1757007830996; Thu, 04 Sep 2025
 10:43:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903232437.1454293-1-kaleshsingh@google.com>
 <827c844f-7106-4f62-a108-1f83544aa56e@lucifer.local> <43ryds7hzhs5bpaxznco7fppmakdb4f46agwtsc5erudqfoz2x@7y4jgbtft7jj>
 <413ee338-1795-433c-b3d4-72c870488d95@lucifer.local>
In-Reply-To: <413ee338-1795-433c-b3d4-72c870488d95@lucifer.local>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Thu, 4 Sep 2025 10:43:39 -0700
X-Gm-Features: Ac12FXwMuBbeKLTnzz-vrMqaDdYeAL1AnUaDmDRhybzWNwdrA2CKosvm7364eLA
Message-ID: <CAC_TJvcCW003ef3=RCXTbC7daSS2+tiS24-7JdTLn3QVJX3Bgg@mail.gmail.com>
Subject: Re: [PATCH] mm: centralize and fix max map count limit checking
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, minchan@kernel.org, 
	kernel-team@android.com, android-mm@google.com, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 10:33=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Sep 04, 2025 at 01:22:51PM -0400, Liam R. Howlett wrote:
> > > > diff --git a/mm/mremap.c b/mm/mremap.c
> > > > index e618a706aff5..793fad58302c 100644
> > > > --- a/mm/mremap.c
> > > > +++ b/mm/mremap.c
> > > > @@ -1040,7 +1040,7 @@ static unsigned long prep_move_vma(struct vma=
_remap_struct *vrm)
> > > >    * We'd prefer to avoid failure later on in do_munmap:
> > > >    * which may split one vma into three before unmapping.
> > > >    */
> > > > - if (current->mm->map_count >=3D sysctl_max_map_count - 3)
> > > > + if (exceeds_max_map_count(current->mm, 4))
> > > >           return -ENOMEM;
> > >
> > > In my version this would be:
> > >
> > >     if (map_count_capacity(current->mm) < 4)
> > >             return -ENOMEM;
> > >
> >
> > Someone could write map_count_capacity(current->mm) <=3D 4 and reintrod=
uce
> > what this is trying to solve.  And with the way it is written in this
> > patch, someone could pass in the wrong number.

Hi Liam,

I still think there is value to this as it's lot less likely to get
the common case incorrectly:

if (!map_count_capacity(mm))
        return -ENOMEM;

It also facilitate us adding the asserts as Pedro suggested (excluding
the munmap() case.

>
> Right, but I think 'capacity' is pretty clear here, if the caller does so=
mething
> silly then that's on them...
>
> >
> > I'm not sure this is worth doing.  There are places we allow the count
> > to go higher.
>
> ...But yeah, it's kinda borderline as to how useful this is.
>
> I _do_ however like the 'put map count in one place statically' rather th=
an
> having a global, so a minimal version of this could be to just have a hel=
per
> function that gets the sysctl_max_map_count, e.g.:
>
> if (current->mm->mmap_count >=3D max_map_count() - 3)
>
> etc. etc.
>
> >
> > Certainly fix the brk < to be <=3D and any other calculations, but the
> > rest seem okay as-is to me.  The only real way to be sure we don't caus=
e
> > a bug in the future is to have better testing.
>
> Speaking of testing - Kalesh - do make sure to test the VMA tests to make=
 sure
> this doesn't break those - they live in tools/testing/vma and you just ha=
ve to
> do make && ./vma

Thanks Lorenzo, will do.

-- Kalesh

>
> Cheers!
>
> >
> > Thanks,
> > Liam

