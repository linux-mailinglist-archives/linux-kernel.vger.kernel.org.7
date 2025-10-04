Return-Path: <linux-kernel+bounces-841915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02706BB885B
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 04:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A78874ED402
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 02:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B38027EC80;
	Sat,  4 Oct 2025 02:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iC0OeNze"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD1D18EB0
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 02:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759544245; cv=none; b=QfZHHwygMcgV8gXxHofHC2KF9NXCLSNSDYCXvwHDdqv9spzMTLSkAKtztQ7TErkKeuByD3foo0clxCrg3c2bFEreeBU+7HrnuFIKHTHWK4Z/bCtX/QZ/ip+21Gl8v84eQFDFVUf08jTv+HY1q10N3QWq9ORTSkSYYSOTbL5dOik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759544245; c=relaxed/simple;
	bh=j3kH8xpdE03dn/OLzuLAcV7uRid0sJk9pLrkyD9hM08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gn8iIVuPyBjoyCFzrNgh5IC4i3l54QsGr5v4DKkDcNtShiy/vELPwLGiDGPv/oEgFGtEWUWdIPYguexqv/q2YhBDEsvOCywwn6C6HjB0SvTLVnjhyXHG5dStGEesDbx4Hpw4FBUotDwgGU7+qdLYInmJkpu96pBJgknaBBwjfKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iC0OeNze; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b48d8deafaeso567963166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 19:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759544241; x=1760149041; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2vTYpOQNaxJxWiyEpSzZFbd7xL7UFgeW54OBL7psisU=;
        b=iC0OeNzeTGD0Y+LdUaUkg0IT8TW8eqEba56z4iYytihUH79XzgzXqmH3j5ALM3/J8a
         WL6zd0Ye+JDQzW5JU01m/zb0Ts0S1f+sisV7+eV1f88rbBFRVXxaMYtehBB89XqCUuzD
         AA6TmRsRQdwUtuCURqfCZ7ZZ4a9SWPcwNA/08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759544241; x=1760149041;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vTYpOQNaxJxWiyEpSzZFbd7xL7UFgeW54OBL7psisU=;
        b=RZXnSC5We+obrGx+G2lMJztDoF2hf7oLrp84HXCxVaW6y27KGL9aIC3KLuF4aQoAwX
         dm/FyJb+yvmZF/1Mmz83y7vUZZn8siE25Yru0AE+UcgeUui8Yq/XBGtfH/vSIsdaTMLL
         z2GqyCIPtBv58qiueDII8jpuYmi/RFGejHWSIVHciiM0v1aBMmYvSQ6Zrl2aeiVvv5yg
         kZtHOFnWwZR6HhxNw0f0QTJUF+WxN6yhSNJQrx7OxuLziQm+ByU9YfgBXKCbHqwxSmBk
         f5Ocf74YGYDl2o3Q/PtZVmoCNg8KbIH/5vzXaPQw8MgFPXyl0N/oStZZ54Y69/hSrCaM
         ko/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8JerETye65yrtw8MGfkUwHTRnr75bs92Rj7LWl2n7pmxEn7AhzADSaPhlQa2E5hiPxs1vM/Aj09r9qNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5xpOMV9ExSPpzDDU18h4HRYGcFT3auxkUc6Z5m9Dd6UG4xZDI
	iFI2muPwQRnCDEjJ3GIZ87PbsA1RMMekpd04yES09LfIzD0fzwud/LrtdkGsr9VVm64fTbXPBFs
	+E9/ztCs=
X-Gm-Gg: ASbGncteb8qPExOUhbzPA98i5i76twhRaI7W6Wyzzg8irA3zHdgUmLBL/zEhh8gaqJR
	LH7re1p4H/gPBV0WAnyaVz8/0anX5Y9JFEzvHvwTjBKnVPuJePTODh5oMfUv433K0yoNW4ouKo0
	Nw6Kevcghk778zSG6Q3VL7MPMScT8e8XapKjaRrtjKw1UvjyuZnrqK2GlC99l09pGBV+JpQlEDI
	a/ATJE66S39o3ZhZSTFZsa9OrkNKFDhvLcycMki2bvBIur0SnQsTK5bm68ZsYSAZ1KwXV3X0g1d
	iOpGq+PipsWuxI/jVGlU9IcLRbUJRhNOFCXuzmLig/jiZ8Clo+vRzbSJ4wt+cQ0VKbNr2+b4l57
	1gwBXwnLadB53HrBMGDEQHmhEBWFhXBoXNEAXvJcN9CU79TIVAi6WYtlNiAbcon2m7ssbFCqO+s
	q6acg9KN+51jLW8O9Wt2Ys
X-Google-Smtp-Source: AGHT+IH1ibuebd8ioK+lvMc9oo1uLkIQ6CToW5AD3B92cjvDsvcS32WRUvNK7xZxbG4ycf6H3aW20w==
X-Received: by 2002:a17:907:3f21:b0:b38:6689:b9fe with SMTP id a640c23a62f3a-b49c2a576ebmr536254566b.7.1759544241302;
        Fri, 03 Oct 2025 19:17:21 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865c81e3esm577229966b.33.2025.10.03.19.17.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 19:17:20 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-634a3327ff7so5967590a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 19:17:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+1SELPkf7+l/IqEj/1/ujc0/DuGLiNtt3ob7UdEUe+lrVG1IG1SlIGPpGk/0osnJeJl2qk+CTvO3JWy0=@vger.kernel.org
X-Received: by 2002:a17:906:c145:b0:b40:f7dd:f8ea with SMTP id
 a640c23a62f3a-b49c47acc78mr653224566b.31.1759544239925; Fri, 03 Oct 2025
 19:17:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzYUBfz+YmifRDgdBsuTL=FpBxQVfxu23it48kGRzJNPQ@mail.gmail.com>
 <CAHk-=wgO7S_FZUSBbngG5vtejWOpzDfTTBkVvP3_yjJmFddbzA@mail.gmail.com>
 <CANiq72kq5YHovH=_a9c0JQgfrAx9gRsQvVo1VfHd-FaupOp7rQ@mail.gmail.com> <bd004ac5-9e51-4e90-a3a4-025d74941a38@nvidia.com>
In-Reply-To: <bd004ac5-9e51-4e90-a3a4-025d74941a38@nvidia.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 Oct 2025 19:17:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkdbFkeZdV3-wFUEcs8JXy=066gNNhTjh5atmurTVqrg@mail.gmail.com>
X-Gm-Features: AS18NWAjFli5et_N0xki74y6xLLEIGirelL5EkqeXVth5ogXvBlNcKffgVMRK6Q
Message-ID: <CAHk-=whkdbFkeZdV3-wFUEcs8JXy=066gNNhTjh5atmurTVqrg@mail.gmail.com>
Subject: Re: [git pull] drm for 6.18-rc1
To: John Hubbard <jhubbard@nvidia.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Dave Airlie <airlied@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Sima Vetter <sima@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Oct 2025 at 18:54, John Hubbard <jhubbard@nvidia.com> wrote:
>
> The main complaint with rustfmt is that it is extremely twitchy and
> unstable with respect to one-line, vs. multi-line output.
>
> *Especially* with "use" statements.

The reason I'd like to fix the rules for "use" statements in
particular is that they do get a rather high rate of conflicts, and
then the "multiple entries per line" is actually very annoying
(because the merge turns into a "figure out small change within a
line" rather than "one line from side A, one line from side B").

And that's not because "use" lines are bad - it's actually pretty
natural, and is very similar to what we see with #include lines in C
files. Those too get much higher rate of conflicts than normal code,
and it simply isn't a problem: the conflicts are trivial to resolve.

Because unlike normal code where different people typically work on
different functions etc, the header includes - and for Rust, the "use"
lines - are kind of that shared area where everybody who makes a
change does so in the same place.

So conflicts in that area are normal and expected, and not generally a
sign of any problem.

But then that "small-items" rule makes for extra pain in this area.

Is it a _huge_ pain? No. But it's an unnecessary annoyance, I feel.

IOW, I really think "use" is fundamentally somewhat different from the
other Rust cases.

            Linus

