Return-Path: <linux-kernel+bounces-807817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE196B4A9B0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124D5364817
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24973148DE;
	Tue,  9 Sep 2025 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ebPceX+I"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0293101D2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412726; cv=none; b=WSvjp/wHriL1R3XflpPRH/pR8xolRyubq0wzxJQ1xrq4bg347+SPgUJIWLyI7frZDb5RHQ7gUC6sQxMm0RrOOwDinEzt3x0wOcdOikW5o28b7lDx4r3S8nmvEoqaVAfZhO+5E0f3mKnM5+2/4t1yVFrIi1RGcpfShK5H1T608xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412726; c=relaxed/simple;
	bh=932mIFgivKfhOi4TgO4xe7Dbk1HS5EyWyGGgF47Q53A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pr0q4EE30GV8w5ApEQdYk4Ps2PguJfKh6b7/INKZoA0x+zueimEodcUwlpebdyNzidQ1FrBU7so0PzCFDSMwSSiy6MoV2sM7gCWHIaUmhksfNclUpKsG3Zoo2thq0OK9x/F/NY22lfmFwgym+jkQ6Iu/o4bc8quSYEAU2mUfsXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ebPceX+I; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-336b5c44a5bso53893041fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 03:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757412721; x=1758017521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=932mIFgivKfhOi4TgO4xe7Dbk1HS5EyWyGGgF47Q53A=;
        b=ebPceX+IPqCjI9JuBUAbH2xXuHvhnJbxz8oe7TRlR2wqm03Q8xQRql2B6yt6IODfY8
         S0DK6z9clQBQEX6kAHyDYUGSV/o2ryNCpfqVw5GgI/w8UQg6izM7VSJeItR7fX8HUB+E
         CC+1KHN6GGiBSDZS+mcVSqAJLt3oCTPLqkvXIq0juLRfP6EUa5do1P9rF7CdM7o4sFwM
         D+C+H44MreX6aGfpQgeK9CuT+MLruXfSko95YmCCWgtUnLg/2QVBLzQCEj7u6wFCXmUq
         P/lmvUj5EUlm53mArKkz3pFmMdb04aLmezVvCFF8AFDsEt7reASB9W7yKE7ywnfazAIV
         n9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412721; x=1758017521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=932mIFgivKfhOi4TgO4xe7Dbk1HS5EyWyGGgF47Q53A=;
        b=QByORab5PitNn6SLMynOm9CQDquXhdXUPULggtarD39ZWKSF5TqdYv9DajmxrZqJeB
         5srvSJ1IF6ASk0p2P3G3+Iu/gGzHhc3DSW9kCdJt+3HmXqcL/CkYi2pbHWbIIoLV8acY
         DlOHiFBCQJA9L9OKwKA4PkO2FXayjrQurj6uvm17BBuegsbFBmDnNYtiyN75iypYB2SR
         jpEW+p89/q1LkQh85d62mLFg5zh/Cu9cCWdOIATHjlp0/15rPBLtpAe97cPFdNFK2aHQ
         qKqJSFnbZ+elTVOmeDPJygou3X9+KZ/wE7gtc30ms4DXjrdgTXrhSEqU+1fkzt7oeejO
         mgGg==
X-Gm-Message-State: AOJu0YwjwJCKI2VUd6rkftdeSbmhwGwPrPh3CTHQWJjDGH/E/aNWrTGP
	MYaFb4llaxUcrBi9mL0Q4lsJeC+eHQt4UCJdsTp7RUNiRxodFJ4T417ldtRG5gknetUCabbC7j2
	jN9fWo3disqTObOF7T2NHCa5rdeDxWWzzwxbXElc/Lg==
X-Gm-Gg: ASbGncsyXRsdjq+VuqA7/+T59BmshryArQK1acg8x2hOL342VCNU/VnXpM6l9KoOmZK
	AN9RHt1fPhvTQQLYo8KaGmN9pLLpBKLsrxRpEc5miiJ6CT5mzXAIwqt5GDPyP3eO8kKXuLTQnH7
	UXa6k1xXYerbRUvzZgse2NUEypYo0IFrV5zdqWxz9P3xZBSaY4HxcHEqPdwa0KZIBjkkpByki3t
	8vaZk+hlDETZE7mQ8TIY8+d8Z+64z954hLzLJNg
X-Google-Smtp-Source: AGHT+IFgCUrOgKDXyTj7GZPbtBGdfLjCb3Cogmef8NZ3q9DnRJcUl4hBGQ5M8P4T/CAyyaWU2Gl1rIxBQFBTfREpwE8=
X-Received: by 2002:a05:651c:1117:10b0:336:cf86:d405 with SMTP id
 38308e7fff4ca-33bb00c67dcmr27527941fa.18.1757412721551; Tue, 09 Sep 2025
 03:12:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905085625.97367-1-marco.crivellari@suse.com>
 <20250905085625.97367-2-marco.crivellari@suse.com> <n7ktycej5ipkjem7hdf6bqsz3srawduxdstxe5du3gybwrm5gz@wdd3ipeyxn7a>
In-Reply-To: <n7ktycej5ipkjem7hdf6bqsz3srawduxdstxe5du3gybwrm5gz@wdd3ipeyxn7a>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 9 Sep 2025 12:11:49 +0200
X-Gm-Features: Ac12FXxIGUvjtajBOd1EV4WHH__xO4CN7wJNct_nnLPT70RCboiwCvfhIMXNols
Message-ID: <CAAofZF7bssWkmP3pv7XPEzPr2qEy=jwowzt_8gVB3QfeeESdrg@mail.gmail.com>
Subject: Re: [PATCH 1/1] closure: replace use of system_wq with system_percpu_wq
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 8:54=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> I was confused until I realized you're updating a comment.
>
> Acked-by: Kent Overstreet <kent.overstreet@linux.dev>

Hello Kent,

Yes, sorry for the confusion.

Thanks!

--

Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com

