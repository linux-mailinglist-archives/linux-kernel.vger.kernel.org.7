Return-Path: <linux-kernel+bounces-815625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8CCB5691B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 027734E1411
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2887C1D6194;
	Sun, 14 Sep 2025 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OwgAUerd"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDCC1C701F
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757855048; cv=none; b=CSS8qf0PcKpeIRnQc/vYgo4+GCkYqIiuS3Bhdh9yRBXlnFV3LwUSAB3dtHc0TCM3YWVhfhfs4YyHvy0rC7cxcPxj0VoxPxLms4rMsVwV7+hP6mQrFltlGPZQ+TVYtLQjVgkD43GD9qfyFeOCha5CL++xTdh0+aznt+rsPiImSKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757855048; c=relaxed/simple;
	bh=eIT6B8Ck9ZTCH2/rxxoLMv5C3Gz96MZvLQcPMa0DpaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6kCbFk5qafVXlVqKKOV+fgu5fj/6DKf8jkXb9Erl8D5N+XRjV34VGkFc0PuqfATYs5htEoKRYaNx/BD4AU2Iou77kQ4DUhwjrjJZtJHz6yt1EXb2HmZzbXNSKs2WvFG3iiHHWa4XziSjDDC0vGLZzFm3ywGZ0mkEEDbE4odTuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OwgAUerd; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3515a0bca13so21221761fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 06:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757855045; x=1758459845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IqFaUQpd7LmKv213z82AUXz93Hm+V03TkEIouxYHoY=;
        b=OwgAUerdLug2M75lePk8QhIf/tbr9nJpmPkcM6yRhWrTPV0bVHEyzXy4HnypGzssrg
         GNJkr7ano9YHAawyr8hrWlfN2UZxClS7S4Cnv7gvsbJCL9xhT0EZ5CLXHgVrZRobcI0q
         UiCf8/kQQ4PTrTdM1Nlnqh4Icso9HLsNDiq2Fr7nTGX0FIOGizKhbDIJDU1UwGKnBnSd
         V+gYib4H+QcjoDlmpMH/HU1DjMFCTgwjblRcvZDOGVJsZQ7TzGkTcrkwRvhkkt0B+IXE
         2j3I1A2P8XbHQbKR9ladZ4oRPlMX6XpAYl/lXbG2AnT0jumrdxOUn/5lKORm+9K3SNpP
         H71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757855045; x=1758459845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IqFaUQpd7LmKv213z82AUXz93Hm+V03TkEIouxYHoY=;
        b=KxgQk1oUyT3Trr/YaAEhmBzKPF5PQTZ4Kh4AfBQvDWFwdbEMdzC4xbspaVprrQVEeJ
         Bmm9g5pq/U6LA+bRu9nd68JFpyTrLyzLQfNQRftXqb5CcCO9rs9K/QCFpMLL9u3RpQne
         OZg/tvu3HTjk1bUR1G5CUMZxW3xOhhFmd7k2TBpOzKZNcn3VJf+SCzsHBVfk2XgyHaYE
         OSQRfMfs8PqBymupknmQHy0dwJQ9/qVNmfswTIudNl0EocE7O6CQAxMLmJMYBhUKPnxP
         LC6qhHA/BDZjbnohGIT1yDw6afiRbCf6kSR6zB/Car1Cz0yUQTsIglaQk0aCTsHjLJvl
         /NSg==
X-Gm-Message-State: AOJu0YyQtly7QS1nR/yyVAjcAyL4b+f+9HOVxj9IL5lKnDa7mj6hN6fw
	JLlrf5afuQgqH4xn+ztYK/wEGI+PnB2MQz4nD9qtUVjOdXfBoH/C1uDkZeoYeCkXJEMVpr+O08v
	2VLaWrVVdw2ozC0twiAYM+bcX+GTubRJv22sHM2/3Fg==
X-Gm-Gg: ASbGncvLcEwf2tBMl1+mH5mJVfGhuRFT45DZEihc1I8qbEPb64EUI1WRBtLm2Ler4Zv
	gYC8X6gjc7KsJ/oSbg7q4mkOF2stK++zdGBgUEfT4Y3E87V7CRtVJWot/8HoQxjLjlLYLLVeFfq
	TloVggzviTZwPoM0gkdIXuwSDSX2sSJcVUXw8BTLvn9FmfSx1eEIAY1L0NesvCCQ6g5v1LuJWNK
	N0ipK9pli9hDUkO14Re260PAEwnel2IOkcwpzLL
X-Google-Smtp-Source: AGHT+IEUO398q8ckm2nbKF/dOfbPRQTls5OtTZlpWKI8X1lmN9sBYbCZbQk5qLKT3g9QcDozIiQpYjXsSWw6+qhCGak=
X-Received: by 2002:a05:651c:2096:b0:352:7dce:2e15 with SMTP id
 38308e7fff4ca-3527dce34d9mr18523461fa.5.1757855044619; Sun, 14 Sep 2025
 06:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090533.105303-1-marco.crivellari@suse.com> <aMTzW6nGz_FCYzNp@gondor.apana.org.au>
In-Reply-To: <aMTzW6nGz_FCYzNp@gondor.apana.org.au>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Sun, 14 Sep 2025 15:03:53 +0200
X-Gm-Features: Ac12FXwMPunGDOshIZwWaT-ESRpfqLsn7vzZW0pkKSYKtDiTk5wEhcGe2BsXX6o
Message-ID: <CAAofZF66bRAupdBTJeCHcKN4FZu+_GRHptwLRzzkcOM89V0=kg@mail.gmail.com>
Subject: Re: [PATCH 0/2] padata: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, tj@kernel.org, 
	jiangshanlai@gmail.com, frederic@kernel.org, bigeasy@linutronix.de, 
	mhocko@suse.com, steffen.klassert@secunet.com, daniel.m.jordan@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 6:30=E2=80=AFAM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
> All applied.  Thanks.

Many Thanks!

--
Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com

