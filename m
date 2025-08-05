Return-Path: <linux-kernel+bounces-756815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FCDB1B9A7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC4D3AB83B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DD2295D86;
	Tue,  5 Aug 2025 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpZcwvj4"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6477E295511
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754416536; cv=none; b=uUHS+3kcAId7VWv7kM7Dd9Fmj4tcbpG7I3GDzpqr/XgRiTEp5nVSBW8TZ1LWWllY5udEu0jsOJ/f22fvWXFFdOtU0K41CU0+/LJ2KlAyRbM6owySKzEq1ImsXXzbDQOduqn1vWzgtsANMU4qy5xzIKkskqV4neVAahe3/rUZaeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754416536; c=relaxed/simple;
	bh=5uRgKSu74lSNHScNwAmGr7aWrylfbsm7esJhr+/Y5Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2HlgtWMXv75quyKiRVsyXWCRBoGzmrYyAXg8BUuVVG8lvmLZzPAXsMEeO5kVUFZReW57Q8PgAmCsC+tXhDUe+Yg7ImTHgawl1M5e+RvNGSCbxTb6II7YkFL3hGtRoUhPZH0euCBR2zQUk+l65N3rOZjUECeLQbuReL3EzaDDs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpZcwvj4; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-88dc7abaf5cso700606241.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 10:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754416534; x=1755021334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tVq221nALtjhFP05t0bLvvBx0QkNkCxD0XEfFCrLV/s=;
        b=BpZcwvj4o2Tn374alqmHe5Ix4WfSe23cUx1IUDADcc55vhB1dXNFI0mTGP1zQLr1Rd
         YrZuausQhd2sNrU79jqpaleWGo6PoCfuLc7/v0Pdm3myNAGqE1U90vJuL+jHjB+yyrO1
         LPXdlgD8mRxqJkv9AA1VgnUsrIRG7e0GIkwhbhHnWeKEtaeCzrLY1YVD7pclkUWIOIQ6
         FI7DGypvpZ9tihV1z6DNjN58n6LtQP6+IjFhjEA2nxI2gGLMy2OCpxtsxSvo/OJvR7tm
         RlyzvIK7x8d8GuGzEPsqb2odSacoZfZY4xzkGK4hQt8bDFTugYcxRZg1XIK6Pc5dqRR6
         Aa4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754416534; x=1755021334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVq221nALtjhFP05t0bLvvBx0QkNkCxD0XEfFCrLV/s=;
        b=Fx6yqvbDA8t7OJcyg/R8CON3++UrMurMNnutTFl0GPVTFAJwcT99/Mcl5lhQOjk9JB
         3OU4p6Ibmj4Qix0tiU50tBOymLYXkptao02l9HFCsS/VP7D6E+qZlOe+58rddcZ3Wc6C
         UGWIKo9N4Uxmf50pvCFFJmjst+b57tS4t1VY/lYY4cfraIk1xM2WBbhG3nIR4zOESzFt
         d36PmSbR4wjIW7CqJJ3WPTY8EHCAuTUMhboqi6vjVaf6wxS6LulpCcIO8CAsMYweSf6z
         mKgH/JXZecm7iZ++5HtSrXiYmMM9Ik3rjkLtGhwtuPpctIgW/3eEp1XNumTUONlSCjIx
         42cw==
X-Forwarded-Encrypted: i=1; AJvYcCVjNXdqFh4tmDn3Ss0xPLqXYANMEdxybcrNd+XAfuY5OViQUeZ6HuZmMVKdxm8J+7h1oZZK2VDHWRjIKvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxddMaoyg97Fpkhnp1w0iDFnBXCFYEWZbQRR2PPbFOA8CheTZDS
	ZcRsIWDCn/+s4cW2VvRqD9TDbtl/kmSQ6UK+qdwgUGLTae7FYBETQ9LYPAJ8HQr3eP0ZAeTGY7+
	6aZLEcCT40lWftDZFnYYNOoo7EfJcHc4=
X-Gm-Gg: ASbGncsWg9L4MDuJWz/crd9NUWR/1yC9mtEJBTZGEvauHFT7Fl8boYbNTgmvNDEOBqn
	3l6tt//YT/2/B+N8UtQ3gu9LgOcM9pftl5h130+jcj8b+1XttBwF6zdTLifOheF8MEYybmVEzgY
	6QqjUnbwrNgLyssiKU+e9pf75OO+zUHumfoQXzAYbiQcibdjEXUUaq7BA/akT1DUyXxa0szXcFx
	kfx
X-Google-Smtp-Source: AGHT+IFq6h/thbNDD3MHQkdADFfHevpJOOgu6mE5Zb6UBKpSwxsw99sC3noj69jn6Ud4dU4nJziGqxM7qfPCA/wD4w4=
X-Received: by 2002:a05:6102:54a1:b0:4fa:37cc:2877 with SMTP id
 ada2fe7eead31-4fdbecde2bfmr6727430137.0.1754416534094; Tue, 05 Aug 2025
 10:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804212902.22554-1-rampxxxx@gmail.com> <qf6xwtxh57jg6ico7n53ft7bepogeal5wfhthodsnf55eabgum@de2ah47jovbg>
 <CABPJ0vgz6gib5LdKY1O6uhPq7Tk5GN2X_dcGBwtx3b=TRQUw-Q@mail.gmail.com> <DBUNH9S9HCXH.SIOBPAT3U91N@brighamcampbell.com>
In-Reply-To: <DBUNH9S9HCXH.SIOBPAT3U91N@brighamcampbell.com>
From: Giant Sand Fans <rampxxxx@gmail.com>
Date: Tue, 5 Aug 2025 19:55:22 +0200
X-Gm-Features: Ac12FXzIPlcfkrae5_ZD700aFaYyz_be01IYT0UOwDsK_87Zy6B94T_fGsVQH-4
Message-ID: <CABPJ0vgOMQk8aBUvtR5FhXzUJ1itF_mvXYiTw9gG8+0=5ipkyQ@mail.gmail.com>
Subject: Re: [PATCH] drm: Add directive to format code in comment
To: Brigham Campbell <me@brighamcampbell.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	dri-devel <dri-devel-bounces@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Aug 2025 at 18:55, Brigham Campbell <me@brighamcampbell.com> wrote:
>
> On Tue Aug 5, 2025 at 5:53 AM MDT, Giant Sand Fans wrote:
> > On Tue, 5 Aug 2025 at 12:49, Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >> Fixes tag?
> >    Sorry, what do you mean?
>
> Dmitry is looking for a tag in the body of your patch (much like your
> "Signed-off-by" tag) which describes the commit which introduced the bad
> behavior[1]. In this case, it looks like this block was introduced with
> the incorrect kerneldoc code block formatting by commit 471920ce25d5, so
> the correct Fixes tag would look like the following:

oh, thank you .

>
> Fixes: 471920ce25d5 ("drm/gpuvm: Add locking helpers")

Yes, this is it.


>
> [1]: https://docs.kernel.org/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes



>
> Cheers,
> Brigham

