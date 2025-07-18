Return-Path: <linux-kernel+bounces-737422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A3CB0AC4B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 00:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 437D57B98C1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBD32253A0;
	Fri, 18 Jul 2025 22:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LZd0ZY1g"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3A1221721
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752878949; cv=none; b=Je0ACWmD3FfXQxVZFGe0qGOjXsqkOJegjzSo76ypWsojjtZ5fzkr0Tq8DEBd4BJwyAN+DYv104M2HiY6P6sEVOjQVM/nVWV8UPfBafvjJ1nHT79mePDMrIjschqeK16wcqeLWDl8dMe/gnCyyUvpJRW2gCDSgz1SHUC/LPes93E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752878949; c=relaxed/simple;
	bh=qo67utYF/ovAn2X4y/cKDIWgVFy2L9OSLb/CZy1qQmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PI3Zof3RK45A5HqnWtvnB/DUNEfp7lq3aizbDj/Xda9WGh4yiV2idPtO5SvMyZEOhfskjWA5xxwZWVf8j3S/+JzeCzzzqNB0YM9Z3gvnkdcabPXfME763bmXty2gpDxPTHK9+k+8H3wpie39VCL4FYthmTf4k6L4AogwxHri66E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LZd0ZY1g; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae36e88a5daso451645066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752878944; x=1753483744; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UqwKREBTKqb14178is+L3e4wy7hqQP2KCNVEXG6C+zY=;
        b=LZd0ZY1gHwA8SxbHuOXlr/sReUCuZqaPC5udU7vSU9xJx4XkLpWyjWJO0dMaofgYHO
         r0zRqA+5LG2sRFAwCs29B7H5ajTmm4WxaBnr7kgdK4XkA+OSqkS9d22fGBi0Eg01c4vP
         30jduNQOUlbkdPp2Eq8hLbjx+CekjakTX23nA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752878944; x=1753483744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqwKREBTKqb14178is+L3e4wy7hqQP2KCNVEXG6C+zY=;
        b=w82uSTmd8h+0mcGtu/qzIptIOTReZbSnLI2VjVRB7XParZnZj7gj5fz+No7UZweBXr
         BMqWYih6/77wSQqUAVzgSWiXFkb8m+IP1Lh34snxgQt5ubJO0Cx35pypf/U8Xwm0vkrK
         PdvBsgHhEvQB2AVkSuOYbY4o1cDUOagcwcFGtaTKgWTvncIubpojsMxAjrTf8DrWWjEV
         Yg5pMmg1Fce1UcauNOJKPxL+9B9e/sNOhbvTPwarr+IKsLoc8AThg1DV6/YVyvhm2yb+
         t6ducny0nC30AfCxC2xpipV4liGLUif3acHps+GIvaIPZyQI/K9r/m0j8LbCa0bWhSGz
         AmQg==
X-Forwarded-Encrypted: i=1; AJvYcCXnHqDBAgAiP2+b2L0OARcp9pcKJNqLIOAX+pgK5BlgEczz7VHUCq8QCdYp5rIUYanpb2VcALCICb8ripI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMPE8CTSNvGlEbYs8es+/3KZzED30QsvtW8a9xS0Vavo2Msn0T
	8LRXDMhnSvsSM3L9dQwLvoMLkFs7pkt9O8az30sIqTeH5E/mSNLkT/K4Jk4FTGTbfWLmwurwIVg
	t632gmi4=
X-Gm-Gg: ASbGncsw0gxTSjQ5PzFwAhzqHl/PxUXL+FBPXmlbAKv5dqHxKUjdZHHFBc3xhXcLchK
	6YISgSXElUKDxbLXnW6A621zBd78IhFeyyXNbkP3l0YAPUyehv2qv1IBaA3SXuo6HiclNHSCtax
	jlby6TtSGWvoShZBZ/1pBwsLnMaovmP04MeRjaTbDxe85RIWOn5nfyWip811How4z2IuH4rW6K/
	tn6R9sMSeTEeOIYiVoIUzpIDVWovxjPmJ89S5IOfddsXmP6KG2FBbaIoUDEHy9aN+z3/xcN9ud6
	hiBUv9txEfUrXZT9R0EDDWbhYGdqRgtSgGNuWJB75tjINTnJuus5b/WoZfIPxK1OW7RBFBSMnJO
	skEqHN25XbjVBaVOCV5pbGVbiZQ1YR0xIjPHZkBwZomqSgV6C4s+f4y8DaWpU0YVZbgXVbJPh
X-Google-Smtp-Source: AGHT+IFkbsHtSVIGacyg5kniP0nmIf2K1t1S6ousPbMfCzg5Uq5i6Mt4hMehSz9xsHHS0aR6RUQp8w==
X-Received: by 2002:a17:906:1251:b0:ae3:6068:235f with SMTP id a640c23a62f3a-ae9ce100f1fmr971482166b.48.1752878944411;
        Fri, 18 Jul 2025 15:49:04 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca310aasm193895066b.72.2025.07.18.15.49.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 15:49:03 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6070293103cso3984839a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:49:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHjiO0RuIbvBpucIfxYOT4JNc3kFGkWMEA6vWyRrLf6YU35ZIbYgrR54OM/xB2pX7OxHNlIc9SzF+jYYg=@vger.kernel.org
X-Received: by 2002:a05:6402:84d:b0:60c:3f77:3f44 with SMTP id
 4fb4d7f45d1cf-61285ba5366mr11281504a12.17.1752878941898; Fri, 18 Jul 2025
 15:49:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718213252.2384177-1-hpa@zytor.com> <20250718213252.2384177-5-hpa@zytor.com>
 <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
In-Reply-To: <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 Jul 2025 15:48:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=whrbqBn_rCnPNwtLuoGHwjkqsLgDXYgjA0NW2ShAwqNkw@mail.gmail.com>
X-Gm-Features: Ac12FXwPQm0wFuMqO4T5e7rkg71dcrU60Bx64WOT68AUbiGf34w2BtStF_AEh5c
Message-ID: <CAHk-=whrbqBn_rCnPNwtLuoGHwjkqsLgDXYgjA0NW2ShAwqNkw@mail.gmail.com>
Subject: Re: [PATCH 4/7] arch/nios: replace "__auto_type" with "auto"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Cong Wang <cong.wang@bytedance.com>, 
	Dan Williams <dan.j.williams@intel.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Laight <David.Laight@aculab.com>, 
	David Lechner <dlechner@baylibre.com>, Dinh Nguyen <dinguyen@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Gatlin Newhouse <gatlin.newhouse@gmail.com>, 
	Hao Luo <haoluo@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>, 
	Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>, NeilBrown <neil@brown.name>, 
	Peter Zijlstra <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Uros Bizjak <ubizjak@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Ye Bin <yebin10@huawei.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-sparse@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Jul 2025 at 14:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 18 Jul 2025 at 14:34, H. Peter Anvin <hpa@zytor.com> wrote:
> >
> > -       __auto_type __pu_ptr = (ptr);                                   \
> > +       auto __pu_ptr = (ptr);                                  \
> >         typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);            \
>
> But that second case obviously is exactly the "auto type" case, just
> written using __typeof__.

Actually, looking at it, I actually think the NIOS2 header is a bit
buggy here, exactly because it should *not* have that cast to force
the types the same.

It's the exact same situation that on x86 is inside
do_put_user_call(), and on x86 uses that

        __typeof__(*(ptr)) __x = (x); /* eval x once */

pattern instead: we don't want a cast, because we actually want just
the implicit type conversions, and a warning if the types aren't
compatible. Writing things to user space is still supposed to catch
type safety issues.

So having that '(typeof(*__pu_ptr))' cast of the value of '(x)' is
actually wrong, because it will silently (for example) convert a
pointer into a 'unsigned long' or vice versa, and __put_user() just
shouldn't do that.

If the user access is to a 'unsigned long __user *' location, the
kernel shouldn't be writing pointers into it.

Do we care? No. This is obviously nios2-specific, and the x86 version
will catch any generic mis-uses where somebody would try to
'put_user()' the wrong type.

And any "auto" conversion wouldn't change the bug anyway. But I
thought I'd mention it since it started bothering me and I went and
looked closer at that case I quoted.

And while looking at this, I think we have a similar mis-feature / bug
on x86 too: the unsafe_put_user() macro does exactly that cast:

  #define unsafe_put_user(x, ptr, label)  \
        __put_user_size((__typeof__(*(ptr)))(x), ..

and I think that cast is wrong.

I wonder if it's actively hiding some issue with unsafe_put_user(), or
if I'm just missing something.

            Linus

