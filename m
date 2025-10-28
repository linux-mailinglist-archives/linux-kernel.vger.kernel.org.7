Return-Path: <linux-kernel+bounces-874551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB607C168EC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B353B8D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4638F2BE629;
	Tue, 28 Oct 2025 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mb2vbGuP"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55A921FF55
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761678178; cv=none; b=RjVpraRHWBKQYj7xr/DVWnDEKo6NMzdGJQAxM2eezRB+l7NZqapDSeYHGQzkDmZAzP8gXxOFE+xoq6lOj938WFWD7NvNte5dd8RB6FGXR3K8IwkPtsZ4Kq2ZHCA3gCfNfKSi1pSo3g8jUJ++AfvkUfmdGszlXMw5h90iUx6wmYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761678178; c=relaxed/simple;
	bh=+jSd32zz+V+z6TOnooQuFhiwCrfPuaTJRkfeK3blgyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHYfE2xvF7uXhlYbggoPrAWffzolB4yUTYdWD+NV8OscH7pPd9IZcWu/ppFHnBO+B4dE6dCQPauQHLB/BnZq3GK6OXCbKrwk9EJZKFZS122bfpU2sqwdvOalkHC4MZ4JsCvHwX6gFrES/TwMAL8zzYNqE1xjQkgPUhMzJ0Qc5+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Mb2vbGuP; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so1513212166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761678172; x=1762282972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3DB7KQQx967Zr7asx8yYmoFI4NdPDe4qEKfpzsaZyOI=;
        b=Mb2vbGuPvuq3kyHfaPxtA1G4z5AeSt5g7UCtGo98WEY9b8vW0Oug+3HEG9dkmW6KAV
         FfnetTEzEuw5VCQ7ByDXmccis9sndeAA8gvTPEzZYfV+ASEvazzMru5nGtnaOxoJOvJR
         33H/2owLf6bd9s7xvTGNXd7azl2HfOwUc4mHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761678172; x=1762282972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DB7KQQx967Zr7asx8yYmoFI4NdPDe4qEKfpzsaZyOI=;
        b=n+1/u67CrGkvg32f3UQm9ZkyckDCYUrXce3ZGx69nqfSlJ/ZzI50UqMpA7+C+iNmka
         nJwsy8Bo2hC88jt+ljvjy/+dEIi9ZO4RdzG/XD+T0V/dbO8est7GO1RFh2ZjXuYmIdxx
         3Z2YMY8dRGJGpPm61unqep1aM/If2fFWXFv0yLdDz0dJpNHuXhyKJZEjF8gLxwNZ9kw+
         w8NKo/A4jr4tC2S9D/ILhsGgV/azqPfmepqBqLjaPsRWkuUteXew1Ihu5XTGdeQzuomO
         EAOuKbIgXv5TtRlqZT9QQgTKDolwYhjzAcxt75muoD8iLGmhEAENVKHYvzGO9Y51uyzn
         Y5ng==
X-Forwarded-Encrypted: i=1; AJvYcCVQtUCeSb/3SKvhTREMRuXvbmW/ZJn0A3uh+TK/VFbkecEkntoEE+1Q21O69/uUySgD08kjgLd598Zz8q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm0KKcE510mMaTuFOFJC5O9imbAK/9/omBWmh6l/5yIrIbrjR6
	QcFqR70qvEwbYwzyt+Xsfxlq5hvHkpO88PmSO3IYppWBc0s1wrosdyhWJ9N3R9oj7CgubYCSPbU
	Lh0zuNqRbBA==
X-Gm-Gg: ASbGncsU1432eUxdTkSYQCYYR9jk/qHZGaYA3E+boaQn//uikyhjhY5Vzx7s8Az2BLG
	vA5XH4FveAvwoGPjASTiAeVaEgTQzvzSVrRO/Eazl6UeSdxbR7yTe/ur4OHysSLQrH+FhnnDuUI
	m/Z753F/K6/31X1V6G6rFxAbPe8S4jORmA7nYvvYKfIJc3BUgjP+PCFiz/AL1Egd8RNgu+9hStR
	JT45DcdWOXOOwmCWh0wCRD4Bpt/qiFrwxAyExdDn9Tbz22AedLzbTpwk/wHa9C5VezYD1MtniHK
	ioeDBk4Jmx7yR3qC0XJK/9z8fg3MKM04gHKXfcncgBwE7AFS1cC9D3qyGIRvk90X7X6Dc1vqVbP
	Ww88fa8WVzY3lTFuOq3gj8hYqPYdHBkuYGz96FgFv3Aw7KYBeZAHzMXYMANVI/yYI/1NECP/Xbt
	5K8U81xugPfLWHg6Cmz5M89hhbJIeVMtum9NZ0FyQuuXncdgPMIg==
X-Google-Smtp-Source: AGHT+IE4gzjzgkasVw4uUrW7oqnN4EjfSfj67IYsOzt2RXQ7y8S/i5LrLlLOIIFBsR+wRUFQMTcuew==
X-Received: by 2002:a17:907:d8e:b0:b40:cfe9:ed2c with SMTP id a640c23a62f3a-b703d61743amr5574666b.64.1761678171793;
        Tue, 28 Oct 2025 12:02:51 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85398439sm1172089566b.36.2025.10.28.12.02.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 12:02:50 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so1202478966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:02:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnlAUI01HsVf4A8GU+hKGTzxcJ7+XzncSjFVMR6trl8ho2fhGliZqoUQPhvnGqVUGbdyAtX5c/sHG3n8g=@vger.kernel.org
X-Received: by 2002:a17:907:1b10:b0:b6d:5b4d:7277 with SMTP id
 a640c23a62f3a-b703d087530mr13565366b.0.1761678170041; Tue, 28 Oct 2025
 12:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028175639.2567832-1-kuniyu@google.com>
In-Reply-To: <20251028175639.2567832-1-kuniyu@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 Oct 2025 12:02:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7s3VKFP2vLmEHhHZ=VBkr5v8J-Y47uzidnt=Kt+dzng@mail.gmail.com>
X-Gm-Features: AWmQ_bklKOGt3tOH6AMzsAYoGOlAXA1Ncxrlb7UB3aXAYq5mk3WEcr-n49jHO_o
Message-ID: <CAHk-=wj7s3VKFP2vLmEHhHZ=VBkr5v8J-Y47uzidnt=Kt+dzng@mail.gmail.com>
Subject: Re: [PATCH v2] epoll: Use user_write_access_begin() and
 unsafe_put_user() in epoll_put_uevent().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Laight <david.laight.linux@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@intel.com>
Content-Type: multipart/mixed; boundary="00000000000088f71106423ca991"

--00000000000088f71106423ca991
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Oct 2025 at 10:56, Kuniyuki Iwashima <kuniyu@google.com> wrote:
>
> Let's use user_write_access_begin() and unsafe_put_user() in
> epoll_put_uevent().
>
> We saw 2% more pps with udp_rr by saving a stac/clac pair.

This patch looks fine to me. Simple and targeted.

> Another option would be to use can_do_masked_user_access()
> and masked_user_access_begin(), but we saw 3% regression. (See Link)

So I find this intriguing, because generally,
masked_user_access_begin() should _never_ be slower than
user_write_access_begin().

user_write_access_begin() ends up doing a __uaccess_begin_nospec() on
x86, which is not just the STAC instruction, but also a barrier.

In contrast, masked_user_access_begin() obviously also has the STAC,
but it avoids the barrier and only uses a simple conditional mask.

So I get the feeling that you did something wrong. In particular,
following your link, I see you describe that case (2) as

  2) masked_user_access_begin() + masked_user_access_begin()
  97% pps compared to 1).
  96% calls of ep_try_send_events().

and you mention masked_user_access_begin() *twice*.

Which would certainly explain why it's slower.

Can you show what the patch you used is?

Because I think the proper patch should look something like the
attached.. For me, that generates


        movabs $0x123456789abcdef,%rcx
        cmp    %rcx,%r15
        cmova  %rcx,%r15
        stac
        mov    %r12d,(%r15)
        mov    %rax,0x4(%r15)
        clac

which honestly should be pretty much optimal.

(That 0x123456789abcdef is just a placeholder for the USER_PTR_MAX
value - it gets rewritten at boot to the right value).

NOTE! The attached patch has absolutely not been tested. I only used
it to verify the code generation visually, so you should definitely
check it yourself.

               Linus

--00000000000088f71106423ca991
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mhaxj01e0>
X-Attachment-Id: f_mhaxj01e0

IGluY2x1ZGUvbGludXgvZXZlbnRwb2xsLmggfCAxMyArKysrKysrKysrKy0tCiAxIGZpbGUgY2hh
bmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L2V2ZW50cG9sbC5oIGIvaW5jbHVkZS9saW51eC9ldmVudHBvbGwuaAppbmRleCBj
Y2I0NzhlYjE3NGIuLjZiY2VlZDM0YmIyMSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9ldmVu
dHBvbGwuaAorKysgYi9pbmNsdWRlL2xpbnV4L2V2ZW50cG9sbC5oCkBAIC04MiwxMSArODIsMjAg
QEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgZXBvbGxfZXZlbnQgX191c2VyICoKIGVwb2xsX3B1dF91
ZXZlbnQoX19wb2xsX3QgcmV2ZW50cywgX191NjQgZGF0YSwKIAkJIHN0cnVjdCBlcG9sbF9ldmVu
dCBfX3VzZXIgKnVldmVudCkKIHsKLQlpZiAoX19wdXRfdXNlcihyZXZlbnRzLCAmdWV2ZW50LT5l
dmVudHMpIHx8Ci0JICAgIF9fcHV0X3VzZXIoZGF0YSwgJnVldmVudC0+ZGF0YSkpCisJaWYgKGNh
bl9kb19tYXNrZWRfdXNlcl9hY2Nlc3MoKSkKKwkJdWV2ZW50ID0gbWFza2VkX3VzZXJfYWNjZXNz
X2JlZ2luKHVldmVudCk7CisJZWxzZSBpZiAoIXVzZXJfd3JpdGVfYWNjZXNzX2JlZ2luKHVldmVu
dCwgc2l6ZW9mKCp1ZXZlbnQpKSkKIAkJcmV0dXJuIE5VTEw7CiAKKwl1bnNhZmVfcHV0X3VzZXIo
cmV2ZW50cywgJnVldmVudC0+ZXZlbnRzLCBFZmF1bHQpOworCXVuc2FmZV9wdXRfdXNlcihkYXRh
LCAmdWV2ZW50LT5kYXRhLCBFZmF1bHQpOworCisJdXNlcl93cml0ZV9hY2Nlc3NfZW5kKCk7CiAJ
cmV0dXJuIHVldmVudCsxOworCitFZmF1bHQ6CisJdXNlcl9hY2Nlc3NfZW5kKCk7CisJcmV0dXJu
IE5VTEw7CiB9CiAjZW5kaWYKIAo=
--00000000000088f71106423ca991--

