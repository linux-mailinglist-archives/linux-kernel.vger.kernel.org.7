Return-Path: <linux-kernel+bounces-765394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC207B23215
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3EE1AA66EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5812D2FDC4F;
	Tue, 12 Aug 2025 18:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T4s4Ptrv"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D7220409A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022047; cv=none; b=ltIe0kzSmG8r+BzBgcCUvZffwI5qOK17thr/LhZ8wYXKC8vkLuIf8J1MzH7MYjHDgkF48OZiWTlb2XNhfvZ/qOA6wwC6FbRZ0+BF0WyrGTdRbuBy8pfzTc5zn09jEoYl8taJeci6U8wMK2Cd8VQqvKQAakg8TV2oA/UrKStDAmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022047; c=relaxed/simple;
	bh=QLI0oP+F14LEUtSgUVTWdoo7hH4GRbMvsU76C8jeEK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWV8AZx3WU1Q0R6h+C7rJ+Xw5hjfkm6hfZOmcp68s6tg6d4CawAAknZRdbA0FtiOmESvv92VG3m/1q17r7/b0nN5pzXIJ+pm51F5Sns/Al5CHNv3E1RWHrvRt9GwrRDtLSwjh+c0jeknAJgRj46fKhS1FhYkhp6IRcx9vnwrZjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T4s4Ptrv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24009eeb2a7so53314425ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755022043; x=1755626843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLI0oP+F14LEUtSgUVTWdoo7hH4GRbMvsU76C8jeEK0=;
        b=T4s4PtrvBBdEHQbTLOfluHc60A/oYpcweFBWuAwtus13n8i972ZlDk4fH0B/BkUUMM
         BVCR6yXvUFYI9RXdKaKPR5LZTo56kl46fJ/PEyKYCDXfXeeZZxJVwjd+Bg+yWlYFMgbf
         jadb+AOKUVlC07ZR7mFuEwl9okJT4/FZ/UCu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755022043; x=1755626843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLI0oP+F14LEUtSgUVTWdoo7hH4GRbMvsU76C8jeEK0=;
        b=dVq3d0sYYbVcIrNg6BG0DIYyqX+sbs7FBJMC8Rvq7XHm/DwzDFWKou/LJ2tT2D2wq3
         ZCa5YskblmOlR2OhFwaCevef4xhtgODneZeXpiopBfsSAkywu/BYGthrGuZ5QwdySMUn
         8XZVVfMkYpcAHxqW24Mb0QI+MOGXF+H87hncDb2MdyBlZYkpdLD/AVyBmsjXZh0eEXe5
         lENXH8aQ+7tDqY7SX6mrR+8gKofnrNaUOS6IkifECYZkE4m//266I9AME0Kl0FMJTRx2
         YRq/A/ZDAuV9oX7O5AxmDhdC4LVzTR5O0KES2VR2NZzaAt8NcuvaudqxpV/vbMoqVZpB
         eXIg==
X-Forwarded-Encrypted: i=1; AJvYcCURKrdw0QvfMC2V9izwBrBd4VPkwVL0JBtnaK9n50zaWkqNiDNezFBT+VEb/gyFN6vMdN9kgpvMjN/chE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YygMiztPQCOhsTN0yPAc5rC56l+BUtU3Tl/2zMFsAaHUir5E+68
	v62e+Gn+2s5EXPfrUdPtjz976iX2HcO4+d/yYTZYX9Ybh2doCyDqXF5X6TWvlWo50o9b2IjYnhp
	56rw=
X-Gm-Gg: ASbGncvg6Fc1tMShoBvrBTCoULa0e6UTlzvv5mIt//v72YOrgJkz7egtv/CLCMyfOvt
	LDKsrNuXbwUINYVKqLygMV2Vi9IuR9VyXcTEOp4Csu/SCiTfsCyz8VN8WGSdNxojN58IFoFpbnV
	8edD+9b25uDqTLeMOjoaDZOioemreHgDw5Vw0wa5tIhMQRNiN6aqu7Pab1HVDYJBMTUuNUU43Gp
	afI2PoeC/nUbh/0dGyMZYpL3hwMAyXNOTj98aoKjJR70vI5HtONl8vn4FVebkLqzXgy8R0oXWme
	CttCydPrEMHwiaqPmnbGddkpx60jaxfyzrdxx6I8dAv5kmoEKVdYBhL0naqACweBelWDHmDk7Rf
	51nbdsnG53U4TGJv4Hx3+nxwyyQkpXOn7Anc22RcFPw63tbEWJPFUh28afIEe3oeSLA==
X-Google-Smtp-Source: AGHT+IE7qTY79blhLdw6mHpQgDcBdE98tkt1mD9pa1723/vvnZxFoRgjpuMd/9XvkSWrZ3K+NqTvDA==
X-Received: by 2002:a17:902:ccc9:b0:240:49d1:6347 with SMTP id d9443c01a7336-2430d1f84cfmr1841285ad.35.1755022042910;
        Tue, 12 Aug 2025 11:07:22 -0700 (PDT)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com. [209.85.215.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321c354f035sm2411630a91.33.2025.08.12.11.07.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 11:07:21 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b170c99aa49so3729917a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:07:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmQbHUUMR8KxW6gdoWVQw9TDlfwCs3x3CoBeY1qgn+Ps66bi3d+774QEED3HOlXpfzO8OlhK1UlCQ6FLI=@vger.kernel.org
X-Received: by 2002:a17:902:dac8:b0:240:3e72:efb3 with SMTP id
 d9443c01a7336-2430d2339a8mr1635395ad.43.1755022040938; Tue, 12 Aug 2025
 11:07:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812082135.3351172-1-fshao@chromium.org> <20250812082135.3351172-2-fshao@chromium.org>
In-Reply-To: <20250812082135.3351172-2-fshao@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 12 Aug 2025 11:07:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X_CiSoXyKkg8jBJLPKe3WDBpLEOAngQJNnN8yZfaC+qw@mail.gmail.com>
X-Gm-Features: Ac12FXy6bsmvYuZD83Q3h0I_SweeUYDQdTDt5N36mwyv9Lq7Agta6Te3OZSZQgg
Message-ID: <CAD=FV=X_CiSoXyKkg8jBJLPKe3WDBpLEOAngQJNnN8yZfaC+qw@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] drm_bridge: register content protect property
To: Fei Shao <fshao@chromium.org>
Cc: Hubert Mazur <hmazur@google.com>, Sean Paul <seanpaul@chromium.org>, 
	Hsin-Yi Wang <hsinyi@chromium.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 12, 2025 at 1:23=E2=80=AFAM Fei Shao <fshao@chromium.org> wrote=
:
>
> From: Hsin-Yi Wang <hsinyi@chromium.org>
>
> Some bridges can update HDCP status based on userspace requests if they
> support HDCP.
>
> The HDCP property is created after connector initialization and before
> registration, just like other connector properties.
>
> Add the content protection property to the connector if a bridge
> supports HDCP.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Fei Shao <fshao@chromium.org>
> Reviewed-by: Sean Paul <seanpaul@chromium.org>

nit: your Signed-off-by should always be moved to the bottom when
posting patches. I wouldn't bother re-posting just for that, though...
I can also independently confirm that Sean provided his Reviewed-by
tag and then it will be covered by my Signed-off-by.

As per my response to the cover letter [1], I'll plan to land both
patches midway through next week unless there are objections.

[1] https://lore.kernel.org/r/CAD=3DFV=3DU+Zh2V2r-THx25Qw7W-Fu_qM4v-+Evi+1t=
BCg92ieYKg@mail.gmail.com/

-Doug

