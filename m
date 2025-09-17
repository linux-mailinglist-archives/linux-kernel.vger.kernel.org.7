Return-Path: <linux-kernel+bounces-821232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F17B80D11
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1C2E7BF73A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0092F7AB9;
	Wed, 17 Sep 2025 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eQQTboZT"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD12341344
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124867; cv=none; b=uJPw+vXv5Ejogv/AjTrD/31DkpSqJYjGNJuTkrQF6akdQ9xyX+CqZsmVgHXdv3/nTY4lSeTmX7Osb+nPsp/QzkFqwnkiQNP8TpBEcQjZnbLyMjfoR7ieLbvhxCL+jpI+1JBFo7o8w7hmAUeFHue1CBLzBsE+kOjDudf/MhSZyFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124867; c=relaxed/simple;
	bh=R+c35AuppakFE0a1IYStQD/Bya5KMo/q8zDUXOBtdQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syYikjDdx5Y1SsYeNFo7kY3jBkUymbRVS2nLF6Dzv9fcUfJUXWeFjqK2tMBKgJAlWCw6nCRO8K0qcrMcxURlmKvSl0M+sxy0P42UwLiMfY/f5Ip1VHagBUnMDPwdBlwEvhIR4pJQfzjBqMPyWka+e4YBPfpYKVwC120WR7YojB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eQQTboZT; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-33ca74c62acso62155041fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758124863; x=1758729663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JHH0nWjRof+d38qRI7i6SC6thOcfFRvUhOi9KQmmkY=;
        b=eQQTboZTirZNi3pK0pgbsR9ahoXJ/Q/82zpG46QcQ19q1xnN6tPifSrzqAKHyLgotT
         eqUKRcnl7iBWmYFjorHEDjYC32DKRDRJRcWBaXlQanKxbuAxRk23viOFecKSKtqEmn6o
         FBufqAcE7ok6NEIo27V+d4sz4EOYE3StqPj69AaAW1vA8nXyybK2psM78Exj6Nu9Z7fl
         LQroFsIX1bOPa3WKNMcy/VLIFH59AuBfuyPpvBhAsPr+fdxb8avhhnCxmigK1tixFRXA
         RgY3YNGCWWw1EjdYoDUcQ0MzL43uuzeIdX/4yl7BWjbF9EHZlPQkl/SrhGzygAeg2xRi
         Mkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758124863; x=1758729663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JHH0nWjRof+d38qRI7i6SC6thOcfFRvUhOi9KQmmkY=;
        b=nsWySEuURoau1F8JQXAWwiPHXdgivBKubTM2LNVC220r7Zr1btsa1oaFN3Gq7tYPYv
         3QIYf359LlOh+sbTsNiHh6qqtb6alCYkb/Emvyw2qhV8cGPCzATQxlbKeVqvQt18alwE
         IQ0x23U9RvUdI/oRQGvlvBpKjpA60L8uUpEA4Kk5vtFfnIceE84owFz6EiuZaiMtR6NB
         DhN9qA3hQPJinSFXWEaT8FrGeeoleee6oQ6nSebMHpN9Ks7HMS/L1TnIzZT4pUvQ1dQJ
         04UNOkzK3GU0/U5/bkIpmF9H7a999xJvo3SdPqDRa9W9r714wOoixMqUYTyXujiq5VC1
         QMdw==
X-Gm-Message-State: AOJu0Yx/vw3T0OZ3hKmHRZ0WNLECv64955C6J+Xya/KjHNY7PyDu3u9p
	05noKqki05w6euK8X8089Lam+GkJT/GxYHirkRY+kYOaztNRF5Kn5E71Ck74tmBm24m2vYJyeUg
	HGxJMqgY0ug1dcIgv9qA2/9epxvWo4PjAKcgfoh5QaQ==
X-Gm-Gg: ASbGncsZRiXPPjGdIw7IX1dFJtjNmVUvED68HXok27WpMb4SxElvYj8B1lxYMMY6ByB
	7H8oVtfCMJmFmJAci6FF95E5KfY9Ql4WLFKthnr2mHnPD2Qe+skZGl38ox3bHg4MJQvW9ximauN
	TQ93SUmc2eaF3qUT+9W4J6ZawCvVerLCAAB+OW8avgSbWmp0Uyd40oWzkabnSI45NzmEEIvrC8U
	X1pShvEUbjokagohTCgH8tXR/CHvinFV6pAafRd
X-Google-Smtp-Source: AGHT+IE39hdC5ZGtI8PXvGdgL45ZRWcKVCKPPrn5iysgQEjnw6ihmVjEHLHg/DoBa0zjxyqogHxZ5Once142DTclBnI=
X-Received: by 2002:a2e:a546:0:b0:336:d2fa:b3b with SMTP id
 38308e7fff4ca-35f64836119mr9877501fa.33.1758124863287; Wed, 17 Sep 2025
 09:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090747.107232-1-marco.crivellari@suse.com> <c83ad820-3380-423d-aa1f-96e3cd2c56b4@paulmck-laptop>
In-Reply-To: <c83ad820-3380-423d-aa1f-96e3cd2c56b4@paulmck-laptop>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 17 Sep 2025 18:00:51 +0200
X-Gm-Features: AS18NWAV-ybV0eDyblgDlZq51PcF4JXkzDusen8CH-S22FCwqGierv0IIMtkEP0
Message-ID: <CAAofZF5BcRXMFynGnJty8g-yqEQiTVzy6sbQpvFV1_M53MCHyQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] rcu: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Jens Axboe <axboe@kernel.dk>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 2:16=E2=80=AFAM Paul E. McKenney <paulmck@kernel.org=
> wrote:
> Queued for review and testing.  If you would prefer to route this some
> other way, please let me know.

Thank you, Paul!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

