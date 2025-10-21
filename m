Return-Path: <linux-kernel+bounces-863725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C69ABF8EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED9E4240ED
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BF628CF49;
	Tue, 21 Oct 2025 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZ97+p0r"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8342AD16
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761081987; cv=none; b=nwy4fUrVpM7ME4wLeMGeUTQR3myqQIos9gTetqCjCtxHVWD1z+EwD3B4gaaJT/XRuaakeC9uJ2o8S7aTeSZ6bvFWOjhJbfVNTjBmWDelsCE8bC6/Ys3pwWwGgeRFAEOesGkPPUOJNm65hB1yLhJQEYIBoLpqkPaSG/yE58hF91E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761081987; c=relaxed/simple;
	bh=fk4uDHBJ7seBjI9wBGl6e9lK7q/Nv9TIYlYWxndM84s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+gaNZTOCS9smNvraBl/shN3NZWhrUKYd4aeCGroIcKP/2exzBxBQJIAQ5NVNPwqzoSKKCz3RgDIzp5KLr6TLJcjfr9N4+yh0r+AvdCKd1A/I42XnFziSGoHjCxzKNA+98rXYC1AHzj4I4aD2Si0XVoHMttaobvG4zkbdrBpMHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UZ97+p0r; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c2b48c201so1661a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761081985; x=1761686785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fk4uDHBJ7seBjI9wBGl6e9lK7q/Nv9TIYlYWxndM84s=;
        b=UZ97+p0roE8xztzXGDJzWe4bui6rJO4WpILhIXPHY2SG/i9k4LbD0uzC1NVa0Usvxa
         4bWIzp1biTjkrCmJvYVAEj0HkF0wX9SwKCI8foGlJKbqzQjyYWydGMki66fuN5L+/RPx
         5gNtmc/RN4d+h1xsvyadWMY9mPAPfg9L6kVfERpG9dmiJnh5pJdx6l0o8X5GFk21lJxN
         8U+wr0p9FCYczU0YAa35dy1KmluPnUPYUx5KKqyoHUmvl+dIEDcK0n5U25gyc0yXm3HB
         NKNZqC4sv3cpIJj7/otvG3Us3l+PefxCnDjdQVWGoURbPykTZSLvjLL9f1ia06fvfaif
         40YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761081985; x=1761686785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fk4uDHBJ7seBjI9wBGl6e9lK7q/Nv9TIYlYWxndM84s=;
        b=dMXV3cJQaNQ7C9ocv0PZHc5ay1rXEsPHhC82FRU8zRXK2dIf5wQ8lRucTCa9NCgcJL
         t6jYjpUdsgTldCGvct3p/k1Cr4wBmisW0kTQ8iZgcySYBwn8g8BScC6hOOcd24wkOK4l
         W221phkfmJZ92QafY16BCqOOzLK8whTyY5QeOjpMmA1z6Tf+9CloUOyqsxGTQOo/2LEi
         0+SqUwmHeFz1Tj1j2y3XNg54ff+mZSVZlwbbIEh1Avi/6/1UNO0bfoNYgTNiV0nP3elj
         frGDSaSMWk+RvB7SDzOJTwG4BUXkbiyg0t5BWNXzOBDlSPHQIBOYEwW04elcAsPOVsYi
         1RoA==
X-Forwarded-Encrypted: i=1; AJvYcCV+uYixG34h7hlT48cZVss3t/bkZ3rF4tiIBQGkBGyVpUr35QE0VF8E0Nzx/RXfBeHzEnjUpm1u9gj6lT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd309T35Q8rH6orSBkwDSg7gM7RFuMtfK8kqc1izH5trZXpme5
	EKvnxI+I0ADJbaTCU6fpGMZhlJga/L/cRdRqgpiDxpo7wHHUzhwjA3jiL92ev7p6+Bqtp/srFoW
	wUFOpdP2z1sXX21Vg04I6pHJhKmVoSeWE6mDoZHQc
X-Gm-Gg: ASbGncvVkjdDB/tpCqWgE6Oj/QOaDFWQBZgh4KajTo96E4Kd8KUVqafS0QZkEjIIlef
	fxmODLVLp+P6LdY7+jZOgax+ZevPf2k6Z6QJYrN2f8/EI5pZAxWziYsNxPibHRVm0+WheZvdd1R
	XBduBCL42muJnv0LNZ6/2x1fd1BfqTC1DGUwbaLdz5GCymKe0JCvnGyf18vkjLvoEZ+rmW2LUSM
	JQ8jT6PUx9KpxGc1kuizIIOhLO5QWU2YTDog2PvUEUk0W9XPZf55H3lmc/ZOvW/3VpJvKdECemX
	gIhrUn3y/IUgsgk=
X-Google-Smtp-Source: AGHT+IHIK7LRKircy3o7ZXU64JDEZ1svJocF6KUfMmgbCGzy8S1rqeS98AsrhAAzTWhtg1sLGH+a+O1AV1PvLhW6NO8=
X-Received: by 2002:a05:6402:a18e:b0:63c:11a5:3b24 with SMTP id
 4fb4d7f45d1cf-63e1d96bb8dmr8627a12.1.1761081984441; Tue, 21 Oct 2025 14:26:24
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020222722.240473-1-dakr@kernel.org> <2025102150-maturely-squiggle-f87e@gregkh>
In-Reply-To: <2025102150-maturely-squiggle-f87e@gregkh>
From: Matthew Maurer <mmaurer@google.com>
Date: Tue, 21 Oct 2025 14:26:12 -0700
X-Gm-Features: AS18NWC-1jwJmoNEc6IBrfF-BcQRCnK47G8SMuewBFW-uaWirgjur0uX31H4tG0
Message-ID: <CAGSQo00J6SjVLBDFHYqwVZ7x_5nT8L=RQEHTfAe43CoDuo0q3Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Binary Large Objects for Rust DebugFS
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Danilo Krummrich <dakr@kernel.org>, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 12:10=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Tue, Oct 21, 2025 at 12:26:12AM +0200, Danilo Krummrich wrote:
> > This series adds support for exposing binary large objects via Rust deb=
ugfs.
> >
> > The first two patches extend UserSliceReader and UserSliceWriter with p=
artial
> > read/write helpers.
> >
> > The series further introduces read_binary_file(), write_binary_file() a=
nd
> > read_write_binary_file() methods for the Dir and ScopedDir types.
> >
> > It also introduces the BinaryWriter and BinaryReader traits, which are =
used to
> > read/write the implementing type's binary representation with the help =
of the
> > backing file operations from/to debugfs.
> >
> > Additional to some more generic blanked implementations for the BinaryW=
riter and
> > BinaryReader traits it also provides implementations for common smart p=
ointer
> > types.
> >
> > Both samples (file-based and scoped) are updated with corresponding exa=
mples.
> >
> > A branch containing the patches can be found in [1].
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/=
?h=3Ddebugfs_blobs
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Matthew Maurer <mmaurer@google.com>

