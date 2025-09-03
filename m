Return-Path: <linux-kernel+bounces-798386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 424D2B41D29
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46EC1BA177E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCCA2FABEB;
	Wed,  3 Sep 2025 11:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gyhv/EF+"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CCF2FABE3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756899382; cv=none; b=E8NnLfd0REbxYe7hnzVsMijYaIi4uq517otmtkCO0VKLdea+nbTctuo8J24Rbi6P/PwhLkLrVJL2aW18wExNNjQ7ejOu0Q0kVCeODW/Blf2RXS3EiTSLjDn4X1TyiNH3oVekDYlRhIo577xh61J1uOYS++ILRPj+k/W6agBjZgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756899382; c=relaxed/simple;
	bh=1S0oCNu8oF/vMuMeRiEdBUA7z3A55yPQtE9fmoNeTcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjgA0l1SFziRQG+NpKsovl0gElh+jZl0e6jmxsAxXgc8TKmITJcBJKd9qYCwQ9JkY5A+q9JODH/bKZeHiKFJDvtxeTG9rhhwoYTOoSZVfQ/rKCUqSMUwr3/haim/AwbQrycadok6EcM4I6yqjk9niBX37zB6ck0GmZ6oGxkzAas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gyhv/EF+; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b490287648so10393361cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756899380; x=1757504180; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a3IW4gClMpsxg8pegPHxJ+hydJ79H7ht+ce7OmUzWyQ=;
        b=Gyhv/EF+fGymevRyCu0EVkNBMQvLeQdRcexx1ZShr+sy0ozKNfLVd4thU1m/VRsY7d
         fqczt8DKt1DxNSeb3b4QesHHzmBDZ3dUA1mYWprJvOGM4PrXoeJj88b/Ym76oEF27bT4
         KIEUAPdr8UyuqEI5tO3ur3RSoipl9SMeEhbZnVGqxCkrKo0LIgV1BzCO+8eUij/ZKWrT
         Y2MkmxH9XwG6LzhFCNpmhIZ52lqdx2V6EEBrm4lYK+aw87/An+rAbP7qDm9HtzybwA+7
         DDLV7Z5AbnimY9uUOE7ZVcsWU964mrlWd3lPM+sKZBbN40Kxj8c+SHNXWdQzhJ9UIujr
         5Lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756899380; x=1757504180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3IW4gClMpsxg8pegPHxJ+hydJ79H7ht+ce7OmUzWyQ=;
        b=mVoqf5pX9+0Pmqd9H/0GfS9rZ7cssp/9paI7QSjKpOjWfNuSBIDgU2n2bZIMSdD+0s
         r3RnyYPzthAc4zS8qkdItNK0b0e/ishXruWyuQrZMBgg7BBOU5fxalZyuEy14pA7gEBd
         nW7v1u+k6UXtNs8bputbg+I1l9rQQA/TA0z6QQyX/Usn3W3Aa/6T+dFXEcLBPyeuVRwQ
         pvjNS5vDY83eV8HH9mYOW/CSJO2AerCKW6JfWGjQUjh1A1DfQi2zfFhaeoBI3+fud2y5
         VdBw01Wy8JxV7LfWXpTzU3/O93MQGLOXzCQD0zqvpbE47/X5f/WIGX46BNYFPtXSURjY
         VlBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+sbQrIW/N22xMNbg75DiDo6CqWNTUJRlTyOCYXb6ZSMXdx/WHqRdZlOohHYEFSi/3mmtf9exBVSuQ+fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfHWs1e0s88Kkm504ah5gqJJdTiS+DNZx6WSLnfoHvos71POlj
	zpcALnSe6BMGs7G39Zg+fRCn/Oc8ziCX/6KeG7F19NZOEzCRnDX9f+KL3w4w3N/+Q2FhaaVXbE2
	SuZ4Zux0SeyJ30/MOzpEWhX3h3ZSt8oYLZ94K9nGS
X-Gm-Gg: ASbGncu2P0629NUDd7Bexfwl5NBlHfDuVlyq6eoNgKYDE1GAM3AzJ7nLyCx8qbSezdw
	vVv8KMyUZ/qBXUDn1gesxIe8ICLGCagm4c0LRdZHjFWxG25cIaKhI9QyPhpdCHwCIwPD1IxMCeP
	tFSgH4qTEVkkEheHMb/Q8kLy4UQCMD9pQFum1kuH34e276G9IPHexyvqBNodt4SK5Mgv599lU/k
	O3O6nG2WmKL9vSK7s+fncqInuSe6RcevFN/FYiRvEA=
X-Google-Smtp-Source: AGHT+IHt5Uf7f9hHKKGO4y+S7XWf9ByCdyBez8I/gMbmDbS05z3pOWgerpBal3i6mcnzy0T4lRXiKY79hwA2pscstuA=
X-Received: by 2002:ad4:5aaf:0:b0:725:1fb:a6b6 with SMTP id
 6a1803df08f44-72501fbac03mr16948666d6.31.1756899379536; Wed, 03 Sep 2025
 04:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901164212.460229-1-ethan.w.s.graham@gmail.com> <20250901164212.460229-3-ethan.w.s.graham@gmail.com>
In-Reply-To: <20250901164212.460229-3-ethan.w.s.graham@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 3 Sep 2025 13:35:41 +0200
X-Gm-Features: Ac12FXyA87fTSQv-blZ3tbQBrKQAAZ9Bwbod18tXQa26iNm899ybg0GqU8LYCbA
Message-ID: <CAG_fn=U+xi3zjr+g+PaT_41JHSca1W6J72xd5=c0dVrSy75XpA@mail.gmail.com>
Subject: Re: [PATCH v2 RFC 2/7] kfuzztest: add user-facing API and data structures
To: Ethan Graham <ethan.w.s.graham@gmail.com>
Cc: ethangraham@google.com, andreyknvl@gmail.com, brendan.higgins@linux.dev, 
	davidgow@google.com, dvyukov@google.com, jannh@google.com, elver@google.com, 
	rmoar@google.com, shuah@kernel.org, tarasmadan@google.com, 
	kasan-dev@googlegroups.com, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, dhowells@redhat.com, 
	lukas@wunner.de, ignat@cloudflare.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +       static ssize_t kfuzztest_write_cb_##test_name(struct file *filp, const char __user *buf, size_t len, \
> +                                                     loff_t *off)                                           \
> +       {                                                                                                    \
> +               test_arg_type *arg;                                                                          \
> +               void *buffer;                                                                                \
> +               int ret;                                                                                     \
> +                                                                                                             \
> +               buffer = kmalloc(len, GFP_KERNEL);                                                           \
> +               if (!buffer)                                                                                 \
> +                       return -ENOMEM;                                                                      \
> +               ret = simple_write_to_buffer(buffer, len, off, buf, len);                                    \
> +               if (ret < 0)                                                                                 \
> +                       goto out;                                                                            \
> +               ret = kfuzztest_parse_and_relocate(buffer, len, (void **)&arg);                              \
> +               if (ret < 0)                                                                                 \
> +                       goto out;                                                                            \
> +               kfuzztest_logic_##test_name(arg);                                                            \
> +               ret = len;                                                                                   \
> +out:                                                                                                         \
> +               kfree(buffer);                                                                               \
> +               return ret;                                                                                  \
> +       }                                                                                                    \
> +       static void kfuzztest_logic_##test_name(test_arg_type *arg)

simple_write_to_buffer() may write less than len bytes if it hits a
protected page.
You should check that `ret == len` and return -EFAULT if they differ.

