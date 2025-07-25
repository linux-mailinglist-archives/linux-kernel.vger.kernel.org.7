Return-Path: <linux-kernel+bounces-745663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 898BEB11CC1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34041C87C29
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C21B23909C;
	Fri, 25 Jul 2025 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r1yoz0mZ"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2189214A4F9
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753440371; cv=none; b=ix5oiIhxaTxDcMNxl5luzuJUO16d5gZ/arf8OtX9kX54zXbQX1qL1wjo/Flrbn6ejbwY7tRzt8ezkzFuKsHfcog6iZKR9uQJ9jOg4KO/6HxrgGM9tQcGU1yeyQ4Wlgv5RnwMiHk00WtX/ajoOGPuBP0zwKZBaOhLyuqh7WlpPwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753440371; c=relaxed/simple;
	bh=fF4PL9tvH2hx88UDbIFTAygBoPyZcuGafhb6Mxwr5BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMf7Msabud3LnIEpNomLYfHLsPvUkpn2OebqpuVOv2aN+ELmaSwOInrmpQVNqz25jLhjscv83CnF1DS3GVCs+vwfNuqOrxXmR8k48LtU3DUKcywOYEI8qqP4y0EywwxlkNXsXUG5rcjCP/UpYvYbJCSy7XN/WPuvjfAobqbnesA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r1yoz0mZ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso18713686d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 03:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753440369; x=1754045169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gySqMQaXdvjL1SUF3U6xcl1pKceXBAohIwzO69Rd5i8=;
        b=r1yoz0mZMDWBLFOpHJSC2nqQd1wBZztijXHX0WmhcNtljwNvCAKbzGmuw8qKbog+9A
         NEzQHATM7IwH/CvPXXTBu+ITpP9FgjsNV3LcFEQlnNB6BkXQ+hsJo6fqXMJ8aVLtE54P
         dEjH0gDu0QmUte+/HtBU8HuOvsdfYl0CAd8Ytm9uTT5L36CUz+OGiFBnbZOH1sYWc88V
         iG3HvgitOPybK5sddbJqXlsW18PE50upb0PSRD6mTNwZFaVyYoMkcGQjaOxyU1O4zdOT
         i0V+xti4TKuMwbRwlKD65FMq476NNj5rmW4RJALjUbKhmBgXg1nRjF2LJSvJUrjzj+cs
         wLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753440369; x=1754045169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gySqMQaXdvjL1SUF3U6xcl1pKceXBAohIwzO69Rd5i8=;
        b=eC7si5ZKczfhl87URh0eX2Z3dOIbeTM6ZH8xpmCnKRg6UPNzkokTB1XXawdjFtuQ6k
         1blZNRjHbGT097Lg2CxvLqfnh430Hj36aK9Uocqr7kJIe6NOcTVoRIeUYiFEcP0/Jm4K
         LZOob4CDYqO+PW6/AMYU6pNMBQAu3RCLNRWB5je8VmzsJ2ZsW190scZCPoKwqE7Cnzma
         kLGmPlkvtUurr+LYFT/bGeGdI/fQtBdPC8sx8ZHX+uyy5DuXLeq7/Ze9hKfw7Mq5RY0G
         qskzdoP/uXTuqUDnOGxU47IURxcqMHfY75/2xHutrwBDdRSb721qZv080+4hwufhKdgw
         CP3w==
X-Forwarded-Encrypted: i=1; AJvYcCXGHawZPNpziVUJwxmuPtCxns5XxozQgz6W/gqF6o42AdwD1eRzhoT22xURuGyjkvUbGXr2fb1HvKIXMiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8vOF2GNtIbFQ2nx2KLBTIB7gG8zeq2lk3QxBEMBhMZfHte0Xp
	co7kOMvg4U8PkuRck4XOkEuF0dYmfsR/K/9RIBe5anPyHtoiMo5gQg8RcOBBAjcmNUTTmrjc4Ig
	2uzeMvGXEDBvJLlGr7+xd8qKX4A3T9RC/tGMRRC6M
X-Gm-Gg: ASbGncviDPEwyGi3iUQH6vBKLcotokuWizd0kul4Lm+9bayqeVai/LuEZAQCraaILlL
	Szyg0kOd59qXOSorHpHY9Pjaa35rRI+KfdKI9VogvxBidVUEijIaA7WeXyYfNjMJ0ae1jmeTgUR
	iBC9WVSsKgxC7NcpQ7/BZxahNJtPRgF8ps9K9crGuF7e4yHrjh3U8CuqIhE/HkYjdG3MfrBqLER
	5ucG7AucaE7vMz1VMFmiRhh1D3UOJdBMpG6VA==
X-Google-Smtp-Source: AGHT+IHRD1UWGiyIC60LlnsB5sezvPO8tuRskqg2x2L+jDXciiUcmeuiV8oN3K1SPrqaOG0BvMYWFeHB+Hfn4XIyk2c=
X-Received: by 2002:a05:6214:767:b0:706:c9df:8f84 with SMTP id
 6a1803df08f44-707204f5ac1mr17171246d6.16.1753440368716; Fri, 25 Jul 2025
 03:46:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626134158.3385080-1-glider@google.com> <20250626134158.3385080-8-glider@google.com>
 <CACT4Y+Za7vRTQ6M6kKs-+4N4+D6q05OKf422LZCMBBy-k4Cqqw@mail.gmail.com>
In-Reply-To: <CACT4Y+Za7vRTQ6M6kKs-+4N4+D6q05OKf422LZCMBBy-k4Cqqw@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 25 Jul 2025 12:45:31 +0200
X-Gm-Features: Ac12FXwWsA3nZdUcsOE5scpAqUIULEe94j7gJoqbG5voc1b4SXUvntmzYkUXFoY
Message-ID: <CAG_fn=VWX8aRaASWpgkfgFOwJLXOx97ykPHR50MtyBC4E8iJKg@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] kcov: add trace and trace_size to struct kcov_state
To: Dmitry Vyukov <dvyukov@google.com>
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

> > +        * Pointer to user-provided memory used by kcov. This memory may
>
> s/kcov/KCOV/ for consistency
Ack.


> > @@ -382,11 +382,13 @@ static void kcov_start(struct task_struct *t, struct kcov *kcov,
> >
> >  static void kcov_stop(struct task_struct *t)
> >  {
> > +       int saved_sequence = t->kcov_state.sequence;
> > +
> >         WRITE_ONCE(t->kcov_mode, KCOV_MODE_DISABLED);
> >         barrier();
> >         t->kcov = NULL;
> > -       t->kcov_state.size = 0;
> > -       t->kcov_state.area = NULL;
> > +       t->kcov_state = (typeof(t->kcov_state)){ 0 };
>
> In a previous patch you used the following syntax, let's stick to one
> of these forms:
>
> data->saved_state = (struct kcov_state){};

Yeah, I did some research recently and figured out {} is more preferred.

