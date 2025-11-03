Return-Path: <linux-kernel+bounces-883282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 137ADC2CECA
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE7C1884EAD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EDA313E14;
	Mon,  3 Nov 2025 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DzX6VnVg"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF5A313538
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185085; cv=none; b=GSStKe4Nq+OvLHf1g4hkuuX93gPi/S/ZTwmw/5Tt8DzcQapWFrj1oxSMWiWwuyj8N/Dn+NTruh9KmTXks2mY9Ni0VmBepZ68giGemnPzBLCXvxQGr59QFyNxSbh8ijOTuMrVeKLuXPpVKyOzdXyOO3oDBAwsYhJaSS1SOqZnJ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185085; c=relaxed/simple;
	bh=OQjvFetmiYdL/f1kIguow4v6f8CTl1kBF1K8Pqz4soo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0BlMP0MGY8cGiphHXaWl1J/U6IH0t1zD2lmtZtjkSgVJNuAyHdl6tKr9aUdgDHiD6Zfh3A3m/BXXOx6iVagyTllFoNVw5lIG7D98GW9DJiaddwfuujSEzsIMnNqoC1Tl6xSAoool7x5iXT85WZSkeVdnTXQopBRJFB5XGE8e48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DzX6VnVg; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-362acd22c78so40396011fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762185082; x=1762789882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQjvFetmiYdL/f1kIguow4v6f8CTl1kBF1K8Pqz4soo=;
        b=DzX6VnVgaT0I0H7uPROUX9fLAf9HeUmPq8AATD81p3KeSauSE4J4b3r2J1Xm0lyZFn
         IxDZ7EijMY2BMSK9dN8GslQII7sUilG/fIYne7JK5VBjYjmwp/EQ/Ca3793IqIWPI0aU
         SWQvvmahMIs92m89j8eKdkDhWrmzL0JBvszbP2Xy+jXgfzgPEy2W/LS9p0mIRnWgLwUR
         fTtletr3F28d5gLG17l55wdSiXVJKjGUrNhCZBRaiZFs4PoZxl28LiqTP9p05G2hDmrv
         ZulPhdZFDWNzJ8Eqe7iT/1gitZ1oVnhaT1XrZ2q60QK8ShLJ5gObg5xO/UClD7Y2ma4n
         P3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762185082; x=1762789882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQjvFetmiYdL/f1kIguow4v6f8CTl1kBF1K8Pqz4soo=;
        b=PDO4/KJlEZo1Key3uAt0Kf4O8KGTRT5HdSJ4Mr8dnTXPTqHbjCHJlkqHSHc/02qg8e
         oTyVfB4F6G3X1Hr8l7Tm7DYjI+axvB8IEoOet20lhLdfobWUpt9mzOEl+zfwIK0bp6V7
         znrJxyNIsQgighLB0wrwmjzYRcnNN5xFYlOCO7FhAb0RYgnulKrTdoo7rzAyWR7aSkaU
         8wwPVKaZKGwQfZ1QO79oIlEGEaAij21U/Pi/fHNhvzHbmDcCF8HwMZbrXynd7TWYrXTC
         SZre/yV3ZfN0DpYHN+ioo4Jgs6RNbCsZK+JTCtFi2kWI8JbZj34BhN8GKtE4nLANeQkd
         67Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVvJ7PYraKf8YNoFkzS7O0fdU4vOn+FMMN9mUl4L06+xznej0iL4KiGj4riYFMgwq7B9pUQa2HaAGPtbX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysi3JQVmF2hdRQkOzo+mocf3tH/PQh/XsnOgP2QhwESKiD3uUm
	OAjj7oQRgXoNqqPfoMVOzG2BiMY/kgh5cLL6HzPOUZceGZRipWgVTDbElmc5X2RLTJ9XFzobYqs
	+11fa3nVFJh0BkijIMJeLwP95ypB7QJFconnHY9qqsQ==
X-Gm-Gg: ASbGncvwoWPd1JG559z35e4DGEMZmVav44pBWZUIz1UenTL6MK7KaTsypWw0gGuAwsa
	fNgHLabKtYQd9gJSpZ65L5LK1vSIFHqaQ9klSZYrr3LumFnQHDUZn3lm8O6qnuD5fFIxMIIMnNN
	9KAcGSbdSCAm3BDXp7N2zFkEGb/nVxMQs9Sz8YuXUZ4lWC3HQ/ljBFi+72N06Tw5FFZVZwSb6pM
	eb2C4Ge0YqShM+rg80DDpDxcd+5uNiThGulTrW3589f9gv7CeDYFK/+IBIx+VNHXAn1v0Yjk2Tb
	TPO4yS9702wfJIX+k53zasMoPu4=
X-Google-Smtp-Source: AGHT+IFTE4kkY8oDuTyU0JwlMBj0Hp150L5ddl1U+wRmCvIHSNJ+3Z5q9aY9yIm7uAl9rRZGAyGuOJtuvjOMAYlfU+I=
X-Received: by 2002:a2e:a78a:0:b0:37a:36be:7282 with SMTP id
 38308e7fff4ca-37a36be76afmr14962851fa.41.1762185081776; Mon, 03 Nov 2025
 07:51:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102-multi_waitq_scm-v8-0-d71ee7b93b62@oss.qualcomm.com> <20251102-multi_waitq_scm-v8-3-d71ee7b93b62@oss.qualcomm.com>
In-Reply-To: <20251102-multi_waitq_scm-v8-3-d71ee7b93b62@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 3 Nov 2025 16:51:10 +0100
X-Gm-Features: AWmQ_bnzH0TpAGhoJr1R3tesTFaI7U48hH9uGbCfmc6L1UxxdFzOBxUD6y2t5Ec
Message-ID: <CAMRc=MfEgnmUXQr4U-919c5VLvW7PCduzS5e569FmqrtYvbJWw@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] firmware: qcom_scm: Check for waitq state in wait_for_wq_completion()
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Unnathi Chalicheemala <unnathi.chalicheemala@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 9:19=E2=80=AFAM Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> wrote:
>
> From: Unnathi Chalicheemala <unnathi.chalicheemala@oss.qualcomm.com>
>
> Modify wait_for_wq_completion() to check if task is in idle state using
> wait_for_completion_state().
>

This is not what's happening. wait_for_completion_state(comp,
TASK_IDLE) puts the waiting task into TASK_IDLE state. It's not
checking anything.

> This allows for detecting when waitq contexts are in idle state and
> propagates it to __scm_smc_do(), which is beneficial when task is idle
> and waiting for a kick to accept new requests.
>

Could you elaborate on what benefit exactly this is giving us? It's
not quite clear from this paragraph.

Bart

