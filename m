Return-Path: <linux-kernel+bounces-863897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06776BF9707
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C165D19A8281
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D46472631;
	Wed, 22 Oct 2025 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="G3Bqj0g0"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AB22AE89
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761092144; cv=none; b=QlNXtKezY9XaC4hTl+SYXd7zifO6tQxr2q7jXXi3FtVWMbH1pK1efsx/XIR+GdSPvUq7rDUdtpl2GMojdlKn55dHQfI3xpjFV6o1PXx4B7x6bBwqieZVeTuiH+7soGVasr4EbODB1gsAD2xL8cnmJByR9yULl4keT0MZsHShUhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761092144; c=relaxed/simple;
	bh=QYMZVxBtPxYE6EZ33C1HyrkU93u+VGFDqSaut8Tc8WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lah+h5lPhDwHdkNj4YIGa6Oyi/fdhnsV3BYJu0WNoNushJqkDjj22VOxn4PdCMdCCj8sArjQrc78pxxAqrKWb2vl5a/HGUjo5To++Nva0JLAotkAnsPFQkR6AySxNcLVhOWUEBMjEarHmluCj/3zXiBHeg/4AmZOVs6mfYUH65k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=G3Bqj0g0; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso10531856a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761092141; x=1761696941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLtBMolvhxZ2nYZ7lKeFnDTLrdScVQzTUS7wwB8pSBo=;
        b=G3Bqj0g0xeWEZUc5Zh8TZGPqunr0+nw/v+B/GQzXSSE3VnxL90ic5vKhcPSEKcWZAb
         clhmQQJLDOj1LU2nE0RfCYy2T4w/SQ0VN2DwLPOodO2R9T8ghuiX4qLm3mXAk7UH6NpS
         qKrnE9g3avFQEuGRqq4v4uQUTd1rhIStJsFpJKlY3EDWgiYMcIV0nsPW9UL3PZT7SX8e
         GfDescpzt0BMIt2sZY48QG+KVWBcy32yJjBoPjBcHffNyAsOxV16iVLxkVq8X2tMVi5j
         qA9M0o6uoWEZSme5FIzzn5U3/QDqCoSKqi5zEnCVlli6RoXuKBlaE28o1mOYxZXfGMSf
         NutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761092141; x=1761696941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLtBMolvhxZ2nYZ7lKeFnDTLrdScVQzTUS7wwB8pSBo=;
        b=aUctWXx9Xs00/VSvRZ8iVLzVdhcUrcPEB+e9hVxkFwq6VfqBs5JnzDWGGt3j2ZewHi
         aZqYnUIweiXueTFzgHytOsZbuViJYTg0RsA/EvOfn/Zo8MmCIiGphgLhqEwHWF1tKGKE
         2etWmpwhqvyhTb1qaeuXi4v2z4YE4dJXaKoMdWo8EZO6FweHM2t1FEeUtqXdkjFus3fa
         58FEOkA2ITMhdm+axca5Y600Bei/nhgo5yYOywJt1yJerTXg2wM2viu2IHuZL7mpU8D2
         Y8x6DOhhcoYYEMI3XHdaZzYtkJ8OnpR6KWr9EV8kJVz9LLaOaR7Xq3apBFCsHVC5DocP
         58Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUj4advg0GHyrhEe54VXgYPA1Pw7/UO/8ecT8UzmCLXkyF4DUlbJfathJJzYaG4k2xk2txv/fKNOx6cXC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3zTmhIow2sLMJqJaTvHke+xEcSOEKZkIYpwIlcwSWMsCaasaT
	1da1KN8bw7PYc9Qu0g1xOXXPiSq1XzTo+PMh7f5V++oL0wdUy/6pVnXWZSJzzu4j5l8bBBfOkFA
	8d0xPXZbUFo0cQKw1xWf3yDZgEtRCsarAJ/msdLt5Hg==
X-Gm-Gg: ASbGncsbd29DEYRlRw3+VUIycUuxMB6CEh8z52KLapK4qRRmu9dsk5SzGarKyTnMw6r
	P/HdROoPuyi6iNDn6axoncAQtQ6suV36ejqu2EZBY0RKW40JFVYOLXc4CgU/0t6Bjz3Ebva2HVD
	uas1XcvVPj/32t7COs9pUToMSuMssuH0/xTUR0rSZzq+X1c/l76vboaKsHo66MBIySqhcDhMtoG
	nf/u7tjVKfAFV7ykqwcnjDCKs03hIcb66KrqfScVU094M8Ypn7zA3cYVhvibnEHCilIQAu/qfFL
	WRc=
X-Google-Smtp-Source: AGHT+IGEuNUf1RCSQwHL6z3gwL7zUADiyfawv+wMX5M61bryfLVp3bld3mKFx8Y8DLsaMjtsAzBcptrVbG9BZA3Wnzk=
X-Received: by 2002:a05:6402:d09:b0:633:7b1e:9aa3 with SMTP id
 4fb4d7f45d1cf-63c1f6f6269mr18383154a12.34.1761092141269; Tue, 21 Oct 2025
 17:15:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
 <aPchmxfh4ACM0vY2@kernel.org> <CA+CK2bAHH1tzMEGxAwbmrLnLTzJANMntRu=cp0J8-n101ER7Pw@mail.gmail.com>
 <20251021135331.8e0185a173a5fa40add60802@linux-foundation.org>
In-Reply-To: <20251021135331.8e0185a173a5fa40add60802@linux-foundation.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 21 Oct 2025 20:15:04 -0400
X-Gm-Features: AS18NWDlyfI6cWth3r_g0r1Pr5LDh2e3c5ckbdEBRacQjSIvh3eM9w5sLU_efF0
Message-ID: <CA+CK2bDPLAS7EM--stHkZkx8FSgYBjDOz6FdvWBYrdHwZpZZjw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] KHO: kfence + KHO memory corruption fix
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, brauner@kernel.org, corbet@lwn.net, graf@amazon.com, 
	jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, masahiroy@kernel.org, ojeda@kernel.org, 
	pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 4:53=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 21 Oct 2025 12:04:47 -0400 Pasha Tatashin <pasha.tatashin@soleen.=
com> wrote:
>
> > > With liveupdate: dropped from the subjects
> >
> > I noticed "liveupdate: " subject prefix left over only after sending
> > these patches. Andrew, would you like me to resend them, or could you
> > remove the prefix from these patches?
>
> No problem.
>
> What should we do about -stable kernels?
>
> It doesn't seem worthwhile to backport a 3-patch series for a pretty
> obscure bug.  Perhaps we could merge a patch which disables this

We are using KHO and have had obscure crashes due to this memory
corruption, with stacks all over the place. I would prefer this fix to
be properly backported to stable so we can also automatically consume
it once we switch to the upstream KHO. I do not think disabling kfence
in the Google fleet to resolve this problem would work for us, so if
it is not going to be part of stable, we would have to backport it
manually anyway.

Thanks,
Pasha

> combination in Kconfig, as a 6.18-rcX hotfix with a cc:stable.
>
> Then for 6.19-rc1 we add this series and a fourth patch which undoes
> that Kconfig change?

