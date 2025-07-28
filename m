Return-Path: <linux-kernel+bounces-748448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F61B14170
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34BF17DE76
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6013273D83;
	Mon, 28 Jul 2025 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlNE8HDq"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2D321E08D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725117; cv=none; b=NQWq6IH1ZmY5wZx0tKr3GglqkVaxXeFaAZwhissnen26/Nqn5kYQHWq3glmtBjmM6X239/kd4XbseE7mVFP//90mcHFYIsjJaszwPw1PIL6aKYi3sl0xoTEYSXV7owAfE2na1MH0PxExsTrZGsnUOWVjPxOUqayc7JwxBjyd+Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725117; c=relaxed/simple;
	bh=TJi4GOB4EeT9H5uJD808QEtaaGwyl01PFC/2eTlYmV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhFGVaisFB9U4K1igdN2IHhb0qaTf+AjvGoN5ffXFaajbvouSS4OXrQzHK5NeYFnpxP8MUQNgNoWKDEzXGwrlOz2XWwr9LHfmq05ZM5eT755np8JmLggJBErS18NasJm3mhEQDLm9GEGL3ED4tQfHylcmxTBU36mAL0ArxgiUNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlNE8HDq; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e8e1b5e7e71so982478276.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725115; x=1754329915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2r29EAEWFlw/l/EgL4Ua3Lklyccw8yEpLgB6QQXTkI=;
        b=mlNE8HDqFd5yi+fxjCQ+AHttqRotcw9SJX05cII9K4ebjlngZi6UI/xlcqDcnMAncF
         agkvyrINfOigI66DSq6YkmvzCedOu7JlnkTyKkcKkYD7eD86fR5fE/MDVwzN6E5ujwT7
         r9j9epKb59Z+YrOpwaDjaPuNY97XNOPNol+qR7kZzgWSeOjHGch3yKUKIMhn/Wna8Rcg
         hTCiKBBouAFO5dH8ab+chYmlU3ItHT2iDbCe7qw5MLg2WdtvV+l0S1g7ULfay+aYx6mf
         33/KNMRSenJ9a6as43uzpSbXMihvpwArLmdR25SWQLCdCfqkQWbJOhuSkopGvjtSp9fN
         60Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725115; x=1754329915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2r29EAEWFlw/l/EgL4Ua3Lklyccw8yEpLgB6QQXTkI=;
        b=cf7lesyfASHk0XQSn+824xXvXVQuAij46AAs/r1FwJg5dRa2ztK/7RTJ3aAM3wURCF
         GpEB9nYqLkn23MOcJ+WHD/DyHeYtCoxkMSvOHwQTtz5bhUAKixo6rRyGpidE3GhMLp8t
         deSGG4V+YbmsEoRsC+f72g2cyKdMNuetHiSPB3oolnPaRZ08qQM2XEH7tCWeTWtGQnIr
         R+1Oi00aHWAmdXOxD5Y7jVGbflqoAQOf0kNWzQjYXydVAogvGavuSiyfZkH7a0IZqDPP
         J09a8wLH3xKd4o99ISuxe3pjzJsk8+eDkpPkBrU0BxtLY/OP0/hio5XfLVazu/4Cg5e6
         Obrw==
X-Forwarded-Encrypted: i=1; AJvYcCUPSFKtGJVVIeFb57freuOGCxQSIe2rn2yMwxLfdpkPsbWqaL27cbeDHwR7BBmT9zBRHeh3Ew7xxfLBu1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFuZV6WfPyc2qP3obSDUqSSD2fKyscdJltxeN3r8m7TaLI9uoR
	Y409JxTqvFOD8hJlz1MifaZs/Z+c0VB7rX/Qr++AQQaDozlIyoCoUFWsbWKhRw0/+W7h2/O7mum
	84uhXJ6r/Y/Wr2m2jrKR5o1kYREOP32HTKsnJ3ETRbMeF/3K+xfC1endg
X-Gm-Gg: ASbGncuTwWzeykG0uIkODC5bOMvJxSsAni1TGn3bP0mzV9krajGFttZBDOj0xDZotQG
	KlmSWPXOaVb0ALOUROUMhR4GdOymLY4S7CPosTd+1kvMnZQJ5Rn/LOWqhdhduKU2Kzd1x4B8Ipn
	A2UTBr7uuD1tNdPTe8+kVOJEyuB3eiv7RKa78FZxdS1EhsLMkaOaxYssN8T+zNnL9W0t9kgwCcw
	25Pd3kQ3pFsuORkYtl5qjcTfctvheSIgRD0
X-Google-Smtp-Source: AGHT+IFEXJWe8zNqy1Et2HKzb/9JPYRLQ2U4/5pPfu2NNHlcUwdpLBK5JpoQYc+dlXychoDupsm34AZdy6dcmmu5maI=
X-Received: by 2002:a05:6902:2d04:b0:e8b:a52e:5c83 with SMTP id
 3f1490d57ef6-e8df13c1321mr13649633276.37.1753725114121; Mon, 28 Jul 2025
 10:51:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707224720.4016504-1-jthoughton@google.com>
 <20250707224720.4016504-5-jthoughton@google.com> <aIFIPm5zENeKlgkw@google.com>
In-Reply-To: <aIFIPm5zENeKlgkw@google.com>
From: James Houghton <jthoughton@google.com>
Date: Mon, 28 Jul 2025 10:51:18 -0700
X-Gm-Features: Ac12FXy3wtVmUaMe5OGRUj9egCVeeNJ1mGFEDMoqTON0HprHOrR0fLwV6y-LoGQ
Message-ID: <CADrL8HVAcWFO3Nv3Ox4k6VdcON=8k+YrOFgqoFojOW=eWJOzaw@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] KVM: x86/mmu: Only grab RCU lock for nx hugepage
 recovery for TDP MMU
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vipin Sharma <vipinsh@google.com>, 
	David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 1:38=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, Jul 07, 2025, James Houghton wrote:
> > Now that we have separate paths for the TDP MMU, it is trivial to only
> > grab rcu_read_lock() for the TDP MMU case.
>
> Yeah, but it's also a largely pointless change.  For the overwhelming maj=
ority of
> deployments, rcu_read_{un}lock() does literally nothing.  And when it doe=
s do
> something, the cost is a single atomic.
>
> I'm leaning quite strongly toward skipping this patch, as I find the code=
 to be
> much more readable if KVM grabs RCU unconditionally.

That's fine with me, thanks Sean.

