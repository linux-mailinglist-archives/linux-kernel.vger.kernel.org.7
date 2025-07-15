Return-Path: <linux-kernel+bounces-731180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AFDB0507D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9E2A7B3243
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679882D3235;
	Tue, 15 Jul 2025 04:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2qCM8U2T"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490BE2D29B7
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752555143; cv=none; b=I9btG5h/Q22pIdHffi05b3lUb+86u4hakOPxTCUsVV3Na8pTuCNU3Xq1U5Ha8iRhRY5EhfnIdrMEXwd+57G6Cikn6dJTQw69LCw8UFQVBgye4R/IrhhvHARGSfnHqS+9n8Zk+JSVlwDqP0Dv8SK2F48cIyuM/qslQ4vCdAeDB9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752555143; c=relaxed/simple;
	bh=W82zO+9Zk9kb+sclogRLx9y901Tn5UyPZIadU0/7naQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0vdOP9UnYHCreb6O6QF08b3ySP+jXLBksPiw2db7B7t+WOCJX8d40sacnLezXlo0aKnZfLFwTdAMn4V4bklZXDsU74TEVKk4U4hGIG626X+D4fep/IDHJ4FoJdYFUHP+LP+Qv1372RM07WvvPPgtKOVTj78oEHlhqR/2HKEIGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2qCM8U2T; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso237811cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 21:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752555141; x=1753159941; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W82zO+9Zk9kb+sclogRLx9y901Tn5UyPZIadU0/7naQ=;
        b=2qCM8U2T2GmqqjHeycy0hR7orZnxQvfRKN1cTEqqTDU6BXSorfYCxwX8sM+luBubuK
         T4DF2JXAAasFlVHyGVmMSUc3f0XE//XClxJaqUPY//Z4xHDRE8LlzWpMgR3WWK6RmlPH
         lkrIjmw/4SXxFCWRCIElkQpDpnQ96hGPrspf+Mmn733JXQ8R5sx0TYqqBYlHMurGVt85
         FD2SSaqvSvd+6xGeZgaZ4V7OzJrYHQ17TOxkvvLEchhmd93vuwtOSTM2ZlVpwPEY2CmB
         akYRVcaEFSFwb5FpsoIOmdA7y8hGtIJzoLNAXqzW4slDgNN48Nf8n5MnVPqF/h5Aqo4x
         /Tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752555141; x=1753159941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W82zO+9Zk9kb+sclogRLx9y901Tn5UyPZIadU0/7naQ=;
        b=JLIRP1OcN344W3HOLgYzAgQMvs0XF7i9A4uY7znK4SAwDzXMOMLG6N2pN87avdVY5J
         Qy57huyeh18aQhvbKgVUgwsNJDlXwhNfn7mTtrM/2U+ntzH5k1r7YRWPDydQxU/9Bhnt
         72Qzc3dAn/C0QfF9UIArDWB9pZk2/kbCiwFFSpt83xIHl9vKUCUi2b1GqMzQrOIO2nav
         prw/1DFFtb2ZO+eXLXXbLqHIyn7rtT8JxC47F4J1dEfuYXYPZOYTwzJIUsgQntf965ES
         0KwR+O9zoeRBaBAiVeo3ULj9CuQ+9PCnierZtr2wEytsi8ib/UBKl2tyltP2T9CHp3bp
         +3zA==
X-Gm-Message-State: AOJu0YxyEHVhb85GrkjmONSDhXszOoEm5y314cbsw0sddx+f9TsP3Ro+
	el0C+wD/Ig2ENfgrmprkTa+rP4PB037VUdGTt0yxbtWhim1aXbSSLHdAyJxMO5+rOVim8NKv9Mg
	FCno1KOnkPYJ5R6jI3kJ/m1LL0Ea+nKwluXK5wGzt
X-Gm-Gg: ASbGnct65nKqal5aRGpt5Sr8TJSxyWoItvnetiuttNdeCfXNx5dUUFJlglpo/QYfZxY
	gqRaRc89KrUKuQTGRtIF7YwQSr7P2oY2gFIiYO90b6L48K8f+d/9829zNUUs0o1+x1Ya/RDMF8h
	5MKlqQEgY1Hq0OJIS3d4b54m5eZ+rHC2qg5eYyAMIQXdfrDyTG9kKyKTGgF8JANYO5kU7xf5twl
	d4ixg==
X-Google-Smtp-Source: AGHT+IED7N/lFrOYBOYjF0Dvn3zylukKfxNlLoQX8mf7MZZJLc58OLah+XC3MNlIKZT5qh5n2NtYRCvvSWgJnwsQexw=
X-Received: by 2002:ac8:6909:0:b0:4a9:d263:d983 with SMTP id
 d75a77b69052e-4ab80cc6f95mr2687821cf.22.1752555140881; Mon, 14 Jul 2025
 21:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714185321.2417234-1-ynaffit@google.com> <20250714185321.2417234-3-ynaffit@google.com>
In-Reply-To: <20250714185321.2417234-3-ynaffit@google.com>
From: Carlos Llamas <cmllamas@google.com>
Date: Mon, 14 Jul 2025 21:52:08 -0700
X-Gm-Features: Ac12FXy73gl4GP6af37XKxpu8Kr2I-Iyp6kE6QBvVYc6xfOcNLtXE2zrbgmOfwU
Message-ID: <CAFuZdDL50S0Nos_U07Zt18LwiKEz=ChyEt0d6qNWeMqKRS133w@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] binder: Store lru freelist in binder_alloc
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, keescook@google.com, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, Jul 14, 2025 at 11:53:15AM -0700, Tiffany Yang wrote:
> Store a pointer to the free pages list that the binder allocator should
> use for a process inside of struct binder_alloc. This change allows
> binder allocator code to be tested and debugged deterministically while
> a system is using binder; i.e., without interfering with other binder
> processes and independently of the shrinker. This is necessary to
> convert the current binder_alloc_selftest into a kunit test that does
> not rely on hijacking an existing binder_proc to run.
>
> A binder process's binder_alloc->freelist should not be changed after
> it is initialized. A sole exception is the process that runs the
> existing binder_alloc selftest. Its freelist can be temporarily replaced
> for the duration of the test because it runs as a single thread before
> any pages can be added to the global binder freelist, and the test frees
> every page it allocates before dropping the binder_selftest_lock. This
> exception allows the existing selftest to be used to check for
> regressions, but it will be dropped when the binder_alloc tests are
> converted to kunit in a subsequent patch in this series.
>
> Signed-off-by: Tiffany Yang <ynaffit@google.com>
> ---

LGTM!

Acked-by: Carlos Llamas <cmllamas@google.com>

