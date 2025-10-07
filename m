Return-Path: <linux-kernel+bounces-844569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630D0BC23DF
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 19:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A262A3C11A8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 17:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E3B2E8B72;
	Tue,  7 Oct 2025 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToBuI3E2"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FB82DEA90
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759857689; cv=none; b=iB6wEX+A7KFFvlLIVLREYcvgkkgwPl6xUdfCEh6ZYZosPx6d2W39rgHrYslYOx2tuWf/QX307kko8ERQK3WxjeAWwNvUcDLXwouoQ8T2moXyO/HgO11Lv1r6yS2jQ1VUVdfHzTimL1mqCXV6/743ao4k6mo5Z56DMQQJfB8iWWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759857689; c=relaxed/simple;
	bh=npfrZy3PQI9uuBJ8os2reujGutciWsH0vsyOW4dEBqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIcJitqmNzkha3KSz0FqWIPUsncGfkpf0oiVzAQHpFbpqzIHf4kcI1X1mYu/OBHrqFN7PB/CM1Ov+tLQ628vVyFcReUiZw6jvAk+tOQDTr4QptvtPFDD8oJnNfYmLa6iGyQKmFMB5CUE6aNdwkL87n7PGXuwB0B2oqBduvllBNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToBuI3E2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-26808b24a00so11276015ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 10:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759857687; x=1760462487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GY9baoySzSZr6T4oYF3bCPJoTe08YW4EjCGWDqwSwoI=;
        b=ToBuI3E2CGOl/PAMPlmOgX3Uj5WSfM4NSY2IkK/io/zJsyuD/SbD5WyBiKXyzchhi7
         njB0GOLLiW/jgixgQvPuI2WAmy9kbFQ1gYfG9fT4DEXjUNYzP4B82ICPuy8cq3ItMjhX
         jgAOkn8ht2lrX8KoPxqJroeNWvBsJn4uq/62JFlDRaSxuPGl0y+d6Jhrnnn/Ug/36oJn
         HsaD58QSnl9cRMI1jjxK0FLQcingpxQejSitNGF7rO9Ic525zDmvlsf2fgRZAT3Kdtx+
         4fp08Oi61mMqnngJ1fQ453cqTTI/nxfPmRHLqWKjw709G1gOWJ4fFjrqXrqm3+y82f4c
         jUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759857687; x=1760462487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GY9baoySzSZr6T4oYF3bCPJoTe08YW4EjCGWDqwSwoI=;
        b=b4pzQUbfm5DmB5XLoCMRAxPpN6vpyDMb+4lnh+cV2i3r3G7Sq1X+9S5WkwUjoN/SBz
         RCt6tlPbyOI0/SST0aq26yFmpeiv9BbxPpTrvw/amnhdozOWrtnT3Ma4dbSNS7jR4efX
         pXLDv3AiSfgt3p9Sv+9CMoEhTXXA8QkpwhxIYrwBxwsFFlOEQACVvIOd3dYm9WlevMk6
         lImJYcH0K+EOl9XOO+auvuhAv1vYHWA1eFF3HLwyAD3Svp3+WqXD7/9R/S7XHUkcQC0h
         M2X7/AcwqB+VtE/QYoAHuRAMDj3yJr4AgYNCk51OZKEf8b1u4qFK28CFYlgU/yh40sK4
         9YAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW28RD/PRXx8kXcqkjV0uGR0Sut/txnwtUFSsxsTe+YPJvAuf1LpiFluY5938Gn1mDbE70JkDLmAmXH+Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhwevP6GZMnjYBR76GJzm6WBHWQlYrb5m4bBkJFGLIbgCbvwNF
	fKs6rJd5tHfzNjAtFDwi75c+w53UOd2PhF2IwO0hmnt75ubOE6rUlQ8hGsDrLULIr+W61laho4L
	9nuSE1hF8BMA1bXWaCYdC0EvP7T9Srxs=
X-Gm-Gg: ASbGncul+UZwacCScPflnupI4JXzVuH6Z+8zsbqBkxQLws0FfrTxsF410x9xjFcs65s
	l3gF3e7SdK/V/08HgAGje4jqFi08bHR6GldA+TCHqtj5kDqA8IAgHBEEMTKsTtcBxIeUcZmMpdH
	DLYZDCBoIsaRbzIgLEqgy+6mRTaHVyRqVLQiFFEDyUSl5IRGGcpmE3HV3Cg1gBWzylf9lJB4N3D
	TBzZDnk9paP1wMaEA5EoG0ksu7107fUxtJgjaXoY2sjtWvwZHIwCS0TYoEVXNMYLaixxxUM4/rK
	9mouy/Gk9NmqRtKdumjKPRAD8rw3edCevkqIZLA6tz3xgrJXxA==
X-Google-Smtp-Source: AGHT+IGb9eTHfz3z9Yt3XqFGv9YvEYPb2KiB7MHj2b6wZb1nnL/QXub+VSTfQ0PcWpPzT36tTEahOhEzWY23RhwT1a4=
X-Received: by 2002:a17:902:fb8b:b0:266:914a:2e7a with SMTP id
 d9443c01a7336-2902743ae8fmr2411475ad.6.1759857687383; Tue, 07 Oct 2025
 10:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzYUBfz+YmifRDgdBsuTL=FpBxQVfxu23it48kGRzJNPQ@mail.gmail.com>
 <CANiq72kq5YHovH=_a9c0JQgfrAx9gRsQvVo1VfHd-FaupOp7rQ@mail.gmail.com>
 <bd004ac5-9e51-4e90-a3a4-025d74941a38@nvidia.com> <3771775.lGaqSPkdTl@hyperion>
 <CAHk-=wj4_zaYJ9ieazt9dnL69R+SL1PEfJtquGVOqsNCVt_rDA@mail.gmail.com>
In-Reply-To: <CAHk-=wj4_zaYJ9ieazt9dnL69R+SL1PEfJtquGVOqsNCVt_rDA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 7 Oct 2025 19:21:13 +0200
X-Gm-Features: AS18NWC_RH9_bRB4snwAZ0VxZRYHqiLEXEVcXDR2yH7h0c0kZfkYKI8KcUzkT5I
Message-ID: <CANiq72kDB1cX1XXX7sc3yQvnaUUYB8q1wVKNxykv8=OV-=rWuQ@mail.gmail.com>
Subject: Re: [git pull] drm for 6.18-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Maarten ter Huurne <maarten@treewalker.org>, John Hubbard <jhubbard@nvidia.com>, 
	Dave Airlie <airlied@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Sima Vetter <sima@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 5, 2025 at 11:33=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Oh, that sounds like a good heuristic, because that "comma after last
> entry" is very much "I expect this list to be expanded upon later".

We can use a trick today to approximate that, which is adding a
comment after one of the commas, e.g.

    use crate::{
        fmt,
        page::AsPageIter, //
    };

It is not the first time I do something like that -- I used an empty
comment to force visual separation between attributes in b9b701fce49a
("rust: clarify the language unstable features in use"), so there is
some precedent.

Yes, it isn't ideal, but it avoids the repetition of the prefix all
the time (many `use` statements), and we can use that temporarily as a
shorthand for "skip formatting this" (which `rustfmt` also supports
with an attribute, but takes more characters and a new line). Then, if
upstream `rustfmt` agrees, eventually we should be able to remove
those extra couple slashes and everything should "just work", i.e.
stay the same.

It seems to work fine in the nested cases (i.e. you can control it
per-level), and it allows to keep single item cases with braces too.

So I will send you a patch to unbreak the situation with some added
docs too, unless you hate it.

By the way, I also took a very quick look at the "trailing comma" idea
to see how complex it could be upstream (it could be either a "just
accept the multiline formatting if there is a trailing comma" approach
or the "take the comma as a hint to reformat accordingly" one
mentioned), and it seems doable. But we will see what they think about
it -- they don't have much bandwidth, I think.

I ran a quick test for the reformatting approach on the kernel, and
the diff isn't terribly big (e.g. +183 -45). One gets things like [1]
-- notice how the nested one (`property::`) is kept as a one liner
because there is no comma there, but the others are reformatted as
vertical on purpose. And if one adds a comma after `NArgs`, then it
will make it multiline.

If we got something like this upstream, it should be easy to
eventually migrate since the diff can be kept small by using the
workaround above meanwhile.

Cheers,
Miguel

[1]

diff --git a/samples/rust/rust_driver_platform.rs
b/samples/rust/rust_driver_platform.rs
index 6473baf4f120..90544b093c85 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -63,13 +63,15 @@
 //!

 use kernel::{
-    acpi, c_str,
+    acpi,
+    c_str,
     device::{
         self,
         property::{FwNodeReferenceArgs, NArgs},
         Core,
     },
-    of, platform,
+    of,
+    platform,
     prelude::*,
     str::CString,
     sync::aref::ARef,

