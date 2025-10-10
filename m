Return-Path: <linux-kernel+bounces-848564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC8ABCE0CA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9AF0735648B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4126F213236;
	Fri, 10 Oct 2025 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNsGdKKw"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31947204F93
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760116274; cv=none; b=EcDntVh3A59f4VnmCd9A6Fie4BWOf1a2b3f8dM6SpPp2K84Z4bD/TPiCmn7U7xGicllhapHwFipqyAkdp/Ksbd7lmwoHQDiLr2AANd7cenn2CGGfe72qT1RWDRnRcTa9cHO2pcnkfciD2ElZbYQpKx0IkzihloelcJ0aagnHAwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760116274; c=relaxed/simple;
	bh=MyGwhpm2qnDDcClWGxcw4aEpoDSw4r7sYiFcziRnQT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFDFS+UypN2WVkmnVYIP1e3H5fBfsiSp5VvCWYV50g06lV9LyrPXBR/ZvYUlzanRqvRn5DqxamVZS7pcpZcGDFC+cS5cKkDUvOaR43Ma5B4uJfg3OvQAmLarouYF3+awq8qyVXsA9RXjRWn1g5GmcAU2FuCiW6Bw3s/pMoBShBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNsGdKKw; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f343231fcso1652912b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760116272; x=1760721072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1Gc1PWI6j3YDPD0EWgLKXMB0oKPpLTGf9J5v8/+n1w=;
        b=DNsGdKKwpQKxx0ahEALxJ7E5K79wly1m/Ah3XdpHlBzM1GrEGe0nzFUav+riTwGWGp
         hjIMuMo4zume+4skI3q8RIg6iPzmm4HhiYD2efUX/2OGGG01+Vr3PNUpKXgfLVmlHFW4
         L6GAJdEW86R6EqqyROEk5FnXDJUKdfl7Xl+T8qLKdnrxubXVc1kY03SZTKTwj7Yyyqf9
         DFGY7gIicpxWE6KKyeL5b/Dk5sP+CKv1qVkkR4sWqD3MlBtTvGMEk4O8/F9XctGRG/9E
         mRyBWDKFjTDV7Q4a2j94ep7gNAN/i/RRIPtf9yvce+JbQNpMSI7QvaiKFUcgdo8rB3Nc
         xWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760116272; x=1760721072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1Gc1PWI6j3YDPD0EWgLKXMB0oKPpLTGf9J5v8/+n1w=;
        b=OFengK3z/hP5nkizaADGpwlV9Hoa/3vjGFwb6rXkttWW+FBXmBV++jHn/8leu4R20b
         YrPEXwDbsLMeztjKyfMmH4bOrhjhjanSoG4QZYTI9Qxs4/AZjtxenfjfmbfxGecPU7IN
         4IdTUOem1LW3KpjdXos0PXYJrY6bEoAXDI56fA5tRDSi30PBHPP7GJGO7T2V6o55L15A
         DQnEd8sjcuZg72gASeveE82tmfRHDkDB4sxKjbOv3kwydtWSgRazpv05RaOR0EH8OLdA
         t5EaC3ijORl0dpcBexfVjXTP9ZQObDjQghEK4j3rEcoxZUxcBxWTsdUO/o3RsjJk0Kkm
         DPkA==
X-Forwarded-Encrypted: i=1; AJvYcCUpB98HprR5Qycy6+JNWpEi1W7ste6/2fV9L6DO94T6cyaDf+KdOKENBsJjyLlYUySBtIkoxHxtz+FvsTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsz2U6o05JK0L3G5lPzPbvK5dIVYpMGsNonm5VSFwfxu42tOEm
	OfmkqSpyMHeU9nRXiYOwT6mDWwpqmv4BSUWZSZD9D6fKHyzkb/Mqzkio8NjUNEDkxLu6iEZqqOD
	yKcgYd92gy7EUjHRG8T6vyTLN7CkL2Fo=
X-Gm-Gg: ASbGnctDqpzS8ahNvgMOEHT7QRRRtGcP2BgC+f8qbRDIKDxLTI9xtSjjzGqHLyIBsYW
	id0pC+DZgq5Z6AENrUjQxdJOU5/523r29uPf8fgZeFZCiZ/Ozoy3K+DVDui88Er0xbeE20LsJcW
	CC8QDJc0KhMDbiTA4BP46RsBBAchCU0vP8eHH4xQ4IIb+leWmjww9mgvfVVNPhsgzBIGX9p5btS
	XsaxDbDDaFdqaZ43mdfmesvyDDaxXFQsoKa3v7Ha1naAQlyjJ0+d3jXATZKyN+/tgA1dHCfBxfM
	wxm2068cJzk=
X-Google-Smtp-Source: AGHT+IEeH87Fvb2m3fT5OUMEYcPRH9zbKkmf0z30ACW09GOgSlCrJAFRGtrIRAseikmrK919axDC/CMZ4XfiUw5sGIE=
X-Received: by 2002:a17:903:2f83:b0:25c:392c:33be with SMTP id
 d9443c01a7336-290273a415cmr165870945ad.59.1760116272223; Fri, 10 Oct 2025
 10:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929171712.1161253-1-kriish.sharma2006@gmail.com>
In-Reply-To: <20250929171712.1161253-1-kriish.sharma2006@gmail.com>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Fri, 10 Oct 2025 22:41:00 +0530
X-Gm-Features: AS18NWCmvBjKJp4WZGHdYCqIDHlcVY9wXyW21NIrKEfEehZDcQUT900Zo4DUft8
Message-ID: <CAL4kbRNDvPkNO=bnjKDD357mdQ4Jzbw5ds4RgaJfL71DtSxSvA@mail.gmail.com>
Subject: Re: [PATCH] filelock: add .gitignore
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi ,
Just checking if there=E2=80=99s any feedback on my patch

Thanks,
Kriish Sharma

On Mon, Sep 29, 2025 at 10:48=E2=80=AFPM Kriish Sharma
<kriish.sharma2006@gmail.com> wrote:
>
> Add a .gitignore to tools/testing/selftests/filelock to ignore build
> artifacts. This prevents accidental commits of object files or binaries.
>
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> ---
>  tools/testing/selftests/filelock/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 tools/testing/selftests/filelock/.gitignore
>
> diff --git a/tools/testing/selftests/filelock/.gitignore b/tools/testing/=
selftests/filelock/.gitignore
> new file mode 100644
> index 000000000000..410842f05f90
> --- /dev/null
> +++ b/tools/testing/selftests/filelock/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +ofdlocks
> \ No newline at end of file
> --
> 2.34.1
>

