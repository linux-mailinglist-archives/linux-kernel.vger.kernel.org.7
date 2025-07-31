Return-Path: <linux-kernel+bounces-751589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9100EB16B30
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642923AF3BE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2531A21CA07;
	Thu, 31 Jul 2025 04:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Som2U5oo"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73905539A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753936329; cv=none; b=eF6J1ADxmWQ7tery4XyPd4tvJqYtuM12cO0Bu7oVuyC1yw6pJZk+68gw86Vi3EtIsquAVKLVfNEK9R6rRfbm1sluSSm20IOLSnOgQ9FESVazq5mSYRoZPXbWFRw79Esa44/hDyoBPxwrr0X7sX5SPvUhrFzrSuK58Ih7TAAhO/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753936329; c=relaxed/simple;
	bh=kAoPuD10AQSP2tFsBD/EZdNTcawqCqeDZob1pgtlPDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKc4BPMpf2E53nhLmdtZKzgS0ULs5ifMw4kFzfk9VcjJjsFop5gnwNyudzYvV5vAM5zcq5TW6bNuzvaBG85Jpifq3Eqw9S6xlLanAoi/N+QkGIsPaajkdk5b03JMS440Fn5U2LsaOytqjFmEf309vMCq+QwzK3t8cThbJovYn+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Som2U5oo; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae708b0e83eso103955466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753936325; x=1754541125; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JKl/pMmd47NVhGRT8Fp3Ui4+sG0khep9g6c9Lmy2ESE=;
        b=Som2U5oo1RYQ3m/LX9SCqorxWoZLSzh96AinoppUrT71p95cYdqYARAFwdqxUfqgtJ
         8FhjrhhW3LLEf09V0ZOE9sT5m4LsZmwe2veXrxtvK2o7dgpAXSAAzfdW38D3B5l303iE
         xnBPT47F7en99RUVZY+0bUkam0xAevrAVOKr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753936325; x=1754541125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JKl/pMmd47NVhGRT8Fp3Ui4+sG0khep9g6c9Lmy2ESE=;
        b=vsoTnsD9soAanffKORiqDeIoEtqLKE0t3JZWZo6fMGSj1VHelq1ELhi0nzWMp+WDyA
         eMFU3PROnvGuNlkhpPm0YpJWfmL+LXXdNoAR9xqx3sQWOCx/SPqf6S2pur1exTVustJs
         CCZHSecbOFfhsav6jTOlw8kwTppWQGv0Ug3rUNTbfahc3GNY5b0tZseVWlqR4p0zQs83
         mLbjgRO/n+COqqisVTpChHNbh2iNrWK446sYK6zdiNA4QB59dpu7OrEfZXiwClg8eUSX
         rw78Ul0tYfk69bkgUx6gOYowRTrpATOMXEvvv6zC5Hc9jrIK7wWicyRtTz56id7P3LuJ
         LPPA==
X-Forwarded-Encrypted: i=1; AJvYcCWjFCtA4q4O7KJvkBojc+XfwGZ53epfz0qHcm0gxlsenaRwexLyBkRZ4OS2j4Uk3qrp4ZhDBsxYhSYoYnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz40gscCmoKIKbhzQR5AxZeltNphzfOYWHvSucIJJxaDouUSEhP
	v2uKM8fUfUyXSi7c0KDfsQhLwIvwbHb/2EKyTCV2FkB4MTChuglWjv1bfKe3hu0dc0tCo1ZBPTM
	OIm/T/iA=
X-Gm-Gg: ASbGncs0yexKTS+hGHYUpPh6zOlp5/kB9Aj3dPYP0mQPyNl8sTR6ublkTiAJceT76T0
	expRkJ7ZB9v741H1SvNkgZwWsim1CAlcnW3VoKevMj2pbXlIlxCsRPqVs26Porfe5BFKyS0shEh
	la9zGqBOuc3NaHk/CxEJ3teyP/5Pb+Ov4xath/tuunuXpaDuy9wKeMS9h5BrrIaIfw6HwtRx1OC
	zE7RytbMoNIqmyaz/EOurlnME3RZIKVN6oq2kyc+xBsc7Mo3OTNiBKesARLJPniKOB9HAmKq0Zl
	PhbHYqRz4Brf9UPw05HnXIp5N9SI2sqFqRZgfSj+2U+PhfHnVO9DSBoFlnXKu4z72zx1Q6HeO5y
	z+cYIFMJkZ4kWNV5++HoPK4RyLbISJ2j5yHqjyLf369Mjp/nF1P02lkiqPXiO3/JR2Li83qAZ
X-Google-Smtp-Source: AGHT+IHgEy6WO20ApuFAbTZIaUEvjSUUyif7iUg6bhDQYiJfrGruiaYfbd/UIt/+F/AwZYwJoeaiJQ==
X-Received: by 2002:a17:907:cd07:b0:ae3:d1fe:f953 with SMTP id a640c23a62f3a-af8fd9e4659mr692716766b.43.1753936325459;
        Wed, 30 Jul 2025 21:32:05 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a241bdfsm43413966b.131.2025.07.30.21.32.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 21:32:04 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6154655c8aeso697235a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:32:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpSNZ8Mx9P8EfZbA6CkYsv+K4LqFKCXs4vJO0SA1/vEW1oWUv96M6KqVrqQ1PNDc62IeQu/b6etwS8s+g=@vger.kernel.org
X-Received: by 2002:a05:6402:2355:b0:615:a3f9:7be5 with SMTP id
 4fb4d7f45d1cf-615a3f99733mr2566183a12.25.1753936323939; Wed, 30 Jul 2025
 21:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzVm80-v6_5nt6kko3nR+aQLZ7R98i419FV8f4-ayQWUw@mail.gmail.com>
 <CAHk-=wirxHy+KU6jmtO2dzmGQ1BwaOdd5Mjtrc40fGvZVULQQg@mail.gmail.com>
 <CAHk-=wjn5Pg2Gp=o2NVv-nRKqE=E75AxUypWCCpQ7MDXuHx+YA@mail.gmail.com>
 <CAHk-=whnuRuQEky2GsCDRQSf1dZbpoqnK+puw=qdR-D7aap9SQ@mail.gmail.com>
 <CAPM=9tygJqtbmYzB5gktxp-7fBfv_9gNq9p9+SdZ6wiYE2-6PQ@mail.gmail.com> <CAHk-=whB1X1c6rWbY34wZVGcnaY=yfPGLOtjd5h3mMDGV9Lbkg@mail.gmail.com>
In-Reply-To: <CAHk-=whB1X1c6rWbY34wZVGcnaY=yfPGLOtjd5h3mMDGV9Lbkg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Jul 2025 21:31:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgq9v6TWjO0QiG3OkvrUU1RL6wqsNHDjansGfEPn5HwCA@mail.gmail.com>
X-Gm-Features: Ac12FXzF8dSyFCi3xpDHC2zrTkYczwDagbLbkfhvdeVqtRqioJqvlewvWWBto04
Message-ID: <CAHk-=wgq9v6TWjO0QiG3OkvrUU1RL6wqsNHDjansGfEPn5HwCA@mail.gmail.com>
Subject: Re: [git pull] drm for 6.17-rc1
To: Dave Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 21:26, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The good news is that it's bisecting without any ambiguity. So nowhere
> near as painful as last merge window.

Right now it's in the range 1b556bcc3837..63b8c9fdfb7f.

A few more bisections and I'll have it down to a dozen or fewer commits.

          Linus

