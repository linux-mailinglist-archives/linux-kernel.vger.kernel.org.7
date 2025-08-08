Return-Path: <linux-kernel+bounces-760698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A52B1EF02
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 21:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0331C58745B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75E3265CDD;
	Fri,  8 Aug 2025 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="eCJDu3rB"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90B21E7C05
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754682702; cv=none; b=BhNs2rtfdRN2Wvgv1Re7zX3zrChS82k9Hv0PIol/SoRG1rGJqE+4FyDdQnaqAK1G9MHVki/bnI62TYBx2px+Be2M2oI9+oiUIvpG/kj4+3UqtKn0DBKdWKzNEF7yPLphrQMTBVpCoPXyKOaAUtSJ1u7TGhwRV3jCBxK3gBaYpUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754682702; c=relaxed/simple;
	bh=BHL0fkXpKKjHtLjXIr2YakBJO2tAgTy6UPx3ySoZ6f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nqbZKXGbI7pdkisPzUsXGMUucIN3anNyUmS++3Q38yWK/AHOG8GrlThKobNXIqwLL8wD/JfZZT5XLhH54tDYN9tad9iudLgFwRDlJgLAf/GjqKUVbbtNuhyY5ssB8k6VwRa7N5CTtYgXdSGodWUGl7+eE7mP6HwoeOAU2QJOFHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=eCJDu3rB; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4af12ba96daso28356421cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 12:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754682699; x=1755287499; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZI3NF4nmF87wkVHXd95sZzslTewp5Rg+7HCCf5M8kbU=;
        b=eCJDu3rB9W6i7ZSxgnM3kWTQIfXiFfn5dNp3bdZ1Ws91iRaiO+Gm0BaH2KvTX/vR2n
         2lDowxIqVHUlKBiCwfboBUHzaWvRZ1yFADbz7hvbASCYag4cvkoX+x6FqvAGratVsRx9
         YERtobn1eHy3IXvG2xoGNlNllu2GImAu2tqKjU4oIV8AKgIhUamt8x/O0xBi2PjyRCd9
         iBlZoAdDd3Vl2EWSHjM+u2/WOzm4ZtVIqQQpgn0TRqUBV6wh46pwXyaAd/cJmCIZY1Au
         9qEL7qQy2l0ROyUer/lJQEEJRC9m3eoY9B/QE0QjtRJFeyW1dB2NMTAHP2kX1OZxnKom
         xntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754682699; x=1755287499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZI3NF4nmF87wkVHXd95sZzslTewp5Rg+7HCCf5M8kbU=;
        b=gsbdBKfmauege9pKQedNXWHBPJlIdAiJ08UleIN9YuWKPRkX5dgwhJQ9ThFGAnQuPN
         Ca3XxDAXPUIgDRuk/HO6Vaf+AfXk7ZzyZSRkeKpt87WHVpUn554wBiVsEgXb0XY6N7Z6
         T+vhtpxKZRmOUp8rbizX+9wYckzQMwyX9/WS818N8SPr4qjgabyUa7NQFjNwIjbYSLjj
         klf5/lXsGE3JXgOOYxVG9MF5AvOrZkIVoFLwoOmUQNzwmIRzeP75GUUChCAODFbchfmn
         Vap8zWUsAeOTv/n5oovF8qrCBz63xWNx2Nb4dwwxm01x7/mndeegfay2g0rIS8kQbz8/
         Ivew==
X-Forwarded-Encrypted: i=1; AJvYcCUkd9IJXtTo/Hbmqb2zwXLzfyidqC+ZKTLYjz9ckaY8qTTVWgcG4bWbsxI9ZOb6IdP9shTcMYa4N4rcX+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYgx6UIg8y0WX/XaiNvoXA4VvyA3khZVkvyxr5ECOkJFpMAry8
	7FQqp83mnBQgu2Q7kcccKtt+ReBLjIy4uXueeTpeC3f0aDulyAKWNJYaKxCN7p+Ng6ZsXD5z4YD
	qzlUQ2DoxPzlA3XOEmeHVE7K1UtWzopcox/0yNP423A==
X-Gm-Gg: ASbGncs48S3zKZKkMefIkQbVDTxTMFJn+AcVhYRq5+zsGByOaKEl2zn7zTpWqgiI7AX
	Q/QJ15fgQyOMDhblj6PrHW1nOor6oGF4rrScQ7lpUvWZylUd7OqhWTLqNGhNdQPrKQqL1XBm8sb
	989227r+DHwDi8y3Bt3O9RDS33dTnaMnrMxeeFitE2qLb8p+wTfbnbIu7ZN4Hmen5DTr0xmM7Jn
	pR5
X-Google-Smtp-Source: AGHT+IHCcrYg7/jG4VG+Cw86KyymKHrjmDEsAzQfWB1gMcCPUUW3z00Eo/TfCPxNGcOawpm+qrN8GOrYgzTiH++NeZ4=
X-Received: by 2002:ac8:58d1:0:b0:4b0:82ee:f732 with SMTP id
 d75a77b69052e-4b0aee3b087mr66564781cf.53.1754682699519; Fri, 08 Aug 2025
 12:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-2-pasha.tatashin@soleen.com> <mafs0o6sqavkx.fsf@kernel.org>
 <mafs0bjoqav4j.fsf@kernel.org> <CA+CK2bBoMNEfyFKgvKR0JvECpZrGKP1mEbC_fo8SqystEBAQUA@mail.gmail.com>
 <20250808120616.40842e9a9fdc056c9eb74123@linux-foundation.org>
In-Reply-To: <20250808120616.40842e9a9fdc056c9eb74123@linux-foundation.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 8 Aug 2025 19:51:01 +0000
X-Gm-Features: Ac12FXzwr7BB3_YD7FWm0iRwopXjM6LILZ73ll6nomRu2PpALziQgUA6db3Oe8A
Message-ID: <CA+CK2bCVziiUZzdGaEabmPSB4Dq41QZe7gVxtgwy4pWmpo=D_w@mail.gmail.com>
Subject: Re: [PATCH v3 01/30] kho: init new_physxa->phys_bits to fix lockdep
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, tj@kernel.org, 
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev, 
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com, 
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org, 
	dan.j.williams@intel.com, david@redhat.com, joel.granados@kernel.org, 
	rostedt@goodmis.org, anna.schumaker@oracle.com, song@kernel.org, 
	zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> > Thanks Pratyush, I will make this simplification change if Andrew does
> > not take this patch in before the next revision.
> >
>
> Yes please on the simplification - the original has an irritating
> amount of kinda duplication of things from other places.  Perhaps a bit
> of a redo of these functions would clean things up.  But later.
>
> Can we please have this as a standalone hotfix patch with a cc:stable?
> As Pratyush helpfully suggested in
> https://lkml.kernel.org/r/mafs0sei2aw80.fsf@kernel.org.

I think we should take the first three patches as hotfixes.

Let me send them as a separate series in the next 15 minutes.

Pasha

