Return-Path: <linux-kernel+bounces-839384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BEFBB185D
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 20:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2AE1C7077
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 18:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE962D63EF;
	Wed,  1 Oct 2025 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5I5+QMH"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E092D595B
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759344040; cv=none; b=llxHpGs4hh4zzZsjgdgQkUwDi4tRWtizJRrk+QpclhgOcBoY6E4yIN5ukq2yTHK81h2fo6hpauIqv9Hva2nuAhzE1qIUevAfSIdJ30qm8nzuGCYAATXzcqsRiUyI1wNgtFAkr/0kMeqrSDV24uJCToAxajUtGcKFMsJORNFwnfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759344040; c=relaxed/simple;
	bh=1umPVrMN25rwtFM9uAPR5FtEtbF3kEcUkN60uAVDZI8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gfUPQYunontDtDeiQw5SChswEkkQnOqKd7FIm4kcVxYOQ7nu6FShm/jTy29kF87qHuFV4xSdtorbXdmn0Z2Rsinp4zho2mkGmQa4PFlUA+92EernVpSvwEbL/XFSvULKYOZsugtWo0jdL3hO5N9Ffh46afQ/ZYzE4MBXSFMC7k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5I5+QMH; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-329a41dc2ebso291124a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759344037; x=1759948837; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MDEJ0lu1+GJ/IUFWINEx2UnZw97BBaeZD5EhIvxkjMY=;
        b=L5I5+QMHtgKoXh3KKNHFDT7RZM0N0beLpSElit0R6zOcchdxQ59x99KNzr68Bif+Ai
         KrXjdMBupOkkzXLn8xMGLU2OHwBiXun6djZyls2y0jtmXhPOP9cry+c93JnKX9MbqOiJ
         lsp9SLL1972DXHf0dmKnGYb+cSpKJhz+yU1O2fNaL3lTJlz8Rx5Px6rXkVdvRyglQXx2
         5sxUzwQqDeiY6s8xfat223VH9Bg4jDAbc5hiSFxQUOGt+/5p/st/W3FFkqEmGoW0Qloz
         6730+id/5t3gL+ViXyKdfMAJBWfojFqzRG+x9GGmL0a9JfIfFyXvJB+/POd4K1hBC4EI
         LAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759344037; x=1759948837;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDEJ0lu1+GJ/IUFWINEx2UnZw97BBaeZD5EhIvxkjMY=;
        b=kDwNZPZ8VHKNm+fRuFIAz1gWZDtSFE5Y9w/gK80AngU3d92rOLwIcfPmx0jAylgQuR
         gUHkfPqNQraoejGYUnlrXPsvHJdPiEdzBpcS+WDSas03XAXzlgp39RpFcUSopXkWbyOW
         m9cpAnJahPfS6mF/LjoepW5WmhwMmvDIIubLVsKZozjSoDtmrH9k49pUAQVEIp8Njkqd
         b0ts79RMdv4T617BJx59rg5KUuOAaDeVez2AoqfxO27Hs8q7ZBugFb/Gjd4x2pvgfG3i
         E4IrcpqjDd4psN55fEZ3lKEFAq6CLq7g+39rIrH2lIsD6oh212xiajEUxXWozKrJAuOA
         OfRw==
X-Forwarded-Encrypted: i=1; AJvYcCXxaAsHyMA2ZJhe2rLn3F24QInaNYvc2xN+pmwksZ5sCQ+Y7eFwx5x6B+hkE1KNsG46kwOPdMMB45SKXlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrg1H+CsXOhTsC8f248p5xH10m512fcYhvSgPO6WZyHsbR3kVS
	4bu67GdBtTAeHXzHHn61RnSw9rQJ9NERhWND6Vb+SM+jX7hEZHmn27bh
X-Gm-Gg: ASbGncv4P4GWMVTgQk9tjDUEM9NusGXw81xD5TjR8R7wD++PzbLhrpqEnsX0UaAo5nc
	xelei2gSheuztggSoi6QHGvsbVynkiXe+vwUiSMPBpUpvN5PQyY0GdI9b6bHF4FA/zYtGUlRDzG
	Z0yFQdfJ8Qbq2/+ipkgoGgTbek3jWmqmo7JkA/YXdEXlipT8SXQWV/edWa/FdTVmdiwjvueqIJ8
	bGQkFnsnqjU1ewewVaGzHI5nrXcMA90xh2AF2y0tO0xmaJ4a0UJBNBplCozH6hIuSFJhMrVeMtS
	deVb0QBtsx0ZWeixVOb3j/LnMoDzseVwMJyUg4WuqQww8GNgkD3c2ebQeaSLjgiUVWXd0vUlPzQ
	4Vwl2H7kr0bjyIaKqUePy3VkZLptx4/vvPJwHApneDwrem0VYN58KrUevo5IGMxyoq5vfG0s=
X-Google-Smtp-Source: AGHT+IE9d7N5NG4XiPa9maEZ3RHrGA6o00yJybkBashehg2u+Wl6ekgRkDIwbZ+lXbWcT5ia5gUc1w==
X-Received: by 2002:a17:90b:4d84:b0:330:4a1d:223c with SMTP id 98e67ed59e1d1-339a6e955e2mr5211655a91.15.1759344036919;
        Wed, 01 Oct 2025 11:40:36 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ed4:e17:bedc:abbb? ([2620:10d:c090:500::6:420a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f594afsm184384a12.37.2025.10.01.11.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 11:40:36 -0700 (PDT)
Message-ID: <15515a5f10587827b33b3e9eaeb854d5c96e88c6.camel@gmail.com>
Subject: Re: [PATCH v3 0/2] bpf: Fix verifier crash on BPF_NEG with pointer
 register
From: Eduard Zingerman <eddyz87@gmail.com>
To: Brahmajit Das <listout@listout.xyz>, 
	syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, 	song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev, 
	kafai.wan@linux.dev
Date: Wed, 01 Oct 2025 11:40:35 -0700
In-Reply-To: <20251001095613.267475-1-listout@listout.xyz>
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
	 <20251001095613.267475-1-listout@listout.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-01 at 15:26 +0530, Brahmajit Das wrote:
> This patch fixes a crash in the BPF verifier triggered when the BPF_NEG
> operation is applied to a pointer-typed register. The verifier now
> checks that the destination register is not a pointer before performing
> the operation.
>=20
> Tested with syzkaller reproducer and new BPF sefltest.
> Closes: https://syzkaller.appspot.com/bug?extid=3Dd36d5ae81e1b0a53ef58

Nit: In the future, could you please include links to previous
     patch-set versions in the cover letter?  These links are usually
     accompanied with a short description of changes from version to
     version.

>=20
> Brahmajit Das (1):
>   bpf: Skip scalar adjustment for BPF_NEG if dst is a pointer
>=20
> KaFai Wan (1):
>   selftests/bpf: Add test for BPF_NEG alu on CONST_PTR_TO_MAP
>=20
>  kernel/bpf/verifier.c                          |  3 ++-
>  .../bpf/progs/verifier_value_illegal_alu.c     | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)

