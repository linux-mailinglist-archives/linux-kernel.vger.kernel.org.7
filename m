Return-Path: <linux-kernel+bounces-731184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F32B05085
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4828C4A6CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4C02D374D;
	Tue, 15 Jul 2025 04:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0tNfTw63"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5585D2D1F6B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752555165; cv=none; b=qTKXdHhLwPwjdlK/7w+SfclUvTgQkcS0HRh5tduzs/pXSvIuhum9JW7bKCD3Ch1UDSq0AQ6x8ucYnbsdlk64FdwxCj+xrbdHFXFAcpD9pZGp0dHlbdB/Ie9ONBUX7gZptFkflro4hXfU3vfYSpCoJrFAO/tnQROHEkI78JxPoA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752555165; c=relaxed/simple;
	bh=BxTI/XChBwRPVd/lpnjOnhO+7Id5XPqsDPrvgCog6pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pe8BQsrRRspFBH0HfoFPPvvJwML4gYG7yLTSfB0f9QiuYVyO0HvlYFwEELMKaZZmdCJWWyOVxplHdNCv9vqHUtvcchVmTpzhUOgHWUoh8SazFmJlZuo/zhLDoZCe+FIjI0ggE17pk7T1gv4x9+6YOIL3gf9DvbuLifuDqRF2MZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0tNfTw63; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso237991cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 21:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752555163; x=1753159963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BxTI/XChBwRPVd/lpnjOnhO+7Id5XPqsDPrvgCog6pw=;
        b=0tNfTw63bk0gDsBcniPOUUaz3Pp2YV/7S3uEeA4HG1VU0qCi9XABynmKQc2q459Alo
         M/f9ga4bdI0m4Rv5NAjtjORCRmLZg6ueFZKqRFO0SmTufKQsVjd/F03gMlo/jLNN7OfU
         0ixbLRjFplgqAUEqIzd3CLAJgzoV093OrvhM0kOU7kIILRlP7m/fzmFVHL6cl5Z2//di
         JXm+gQhX9Me/FUwBWmfW80eNUmsCUvZ0V3aKy2lOCFdZXONvjhp7CjaGrk7v6cPT0xzW
         rfj93WdTpFfjgMriWNNcyD1pQ/4gup++X+o+3c/hFd7o2PJJtg175Hsjaw9JmoBodTr9
         7oBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752555163; x=1753159963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BxTI/XChBwRPVd/lpnjOnhO+7Id5XPqsDPrvgCog6pw=;
        b=YXPO5JQE/P2SoaOGAWBHztyB/mEHB+carpvUVa+wbAO/L0fzxscqe8RGXInBbw2bOK
         3OfU5XS0JIH6Wort01SYDyn8c1fHj7ypoWzB2dDF88yyEkrccKuxIux1cD2BIGqGBmsf
         OWLudp81F3ynB87R12P5T1/Z+cx/LRFuyZvuaFhnQPBSI9si2zNKIEP7fywToxInxt4y
         kvN25T7T/Tor8bdfeSd3yTFJEm+/1DYjByAignTGDv14bqdg+CuDLT5GqawuxhhchPkf
         C/e+6vHhMP/RqHQIyQALF7z4nVi87Yvn2vWR0qPkpVGUYS1vxWSFquLUBoHQwjoASdpp
         E3FA==
X-Gm-Message-State: AOJu0YzzEKTD0lcIqBeQ3J7FMntqM4ZbMNZGv0XKyFcjg3kyIAJKTZy+
	IWVdPd6meM/+HM5tr32aqVF4Fce56vbBUvnTDXkjH/XHuiAy3WFvtOMsQSd+vmCZu3ibe3jxgFs
	zTYDRaQkIqOVaHX+BRU6NVDDugzFZcaTekBULzu74
X-Gm-Gg: ASbGncvY0ogWZwnn5NSp/sxxb7JNi7znvGVctJYmaGsGE4t3wlkZ3FWDHIm582qL+5E
	bailruEYnqqEpdOWypg4VOoNfdI99Oj2jwxetvn1XlrqNmFQuqsu8C8sNChtU/lTA04ZrnEwTRl
	9/9/fnW7ORasSynd2rCT0XmAmCP4HkxCE9CLwsEhBMw7sA16WaUxXi8KV2TLsV6NBFAExv7FjR8
	gcdIg==
X-Google-Smtp-Source: AGHT+IFUhtmXQZiFx0HnrQznPC6IHTh4TbC7da33DxdEZqwkXlBLL3dZed+VclptZNoBrX9qvm4zJO2cyCsQb0zu0TQ=
X-Received: by 2002:ac8:7dc8:0:b0:4a9:a4ef:35c2 with SMTP id
 d75a77b69052e-4ab8293b386mr1488711cf.23.1752555163096; Mon, 14 Jul 2025
 21:52:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714185321.2417234-1-ynaffit@google.com> <20250714185321.2417234-7-ynaffit@google.com>
In-Reply-To: <20250714185321.2417234-7-ynaffit@google.com>
From: Carlos Llamas <cmllamas@google.com>
Date: Mon, 14 Jul 2025 21:52:30 -0700
X-Gm-Features: Ac12FXxjkWr-PhLv_CrnQtbWXbuLd4c2lXNM0HkAQBusanbPr2cAK6HGaGFz8Tc
Message-ID: <CAFuZdDJRuQOhQQN79cgNERJQnMuOkQx4W-eTGcotCCUMk5HULA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] binder: encapsulate individual alloc test cases
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, keescook@google.com, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, Jul 14, 2025 at 11:53:19AM -0700, Tiffany Yang wrote:
> Each case tested by the binder allocator test is defined by 3 parameters:
> the end alignment type of each requested buffer allocation, whether those
> buffers share the front or back pages of the allotted address space, and
> the order in which those buffers should be released. The alignment type
> represents how a binder buffer may be laid out within or across page
> boundaries and relative to other buffers, and it's used along with
> whether the buffers cover part (sharing the front pages) of or all
> (sharing the back pages) of the vma to calculate the sizes passed into
> each test.
>
> binder_alloc_test_alloc recursively generates each possible arrangement
> of alignment types and then tests that the binder_alloc code tracks pages
> correctly when those buffers are allocated and then freed in every
> possible order at both ends of the address space. While they provide
> comprehensive coverage, they are poor candidates to be represented as
> KUnit test cases, which must be statically enumerated. For 5 buffers and
> 5 end alignment types, the test case array would have 750,000 entries.
> This change structures the recursive calls into meaningful test cases so
> that failures are easier to interpret.
>
> Signed-off-by: Tiffany Yang <ynaffit@google.com>
> ---

Great job here. Thanks!

Acked-by: Carlos Llamas <cmllamas@google.com>

