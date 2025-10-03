Return-Path: <linux-kernel+bounces-841005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE63BB5F12
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 07:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 198CE3A22E4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 05:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9C21F2380;
	Fri,  3 Oct 2025 05:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD2qZaCy"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED46381BA
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 05:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759469366; cv=none; b=GvNGaar0v9owi5O8HIF2vMlCuRzmAUSM/4/hEHfrC4kvY/SBKbD0R1bC6E6j2kP2GY9me5zopOxzDp2ir2oUppCPsiOe/xR8N464qEguRDvMWvKrY6emA8YG8CsFv3oqfQij1jGTcxR1d7tZhyNN67DnjWHf5isR9ba1gtG3uro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759469366; c=relaxed/simple;
	bh=FAecbVfIu/2KfpMJLz5+NVIRF8lakTzCsR7c7STt1QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nR62ZwCO/X0Rr/xQvg7MYUVwf5CnyLn2Po50kc//vl8R451HuT7hrS/E9JxsHgnwtXaxM8+3djER96kf6/GRHmU+k2VCEigZeXHZ4qdpRqX1U4MeZpvQc6NNPXb4/BR142KnPKRcMRWvCEt1d9+Xg8cJAGYVSxK5DcrIWWLr/40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VD2qZaCy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27eda3a38ceso3105525ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 22:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759469364; x=1760074164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAecbVfIu/2KfpMJLz5+NVIRF8lakTzCsR7c7STt1QQ=;
        b=VD2qZaCybeyXJ8ePUVp1n9P2sreyZi4YH+7DUdUxVdU9luMeTDXpTRFuYXdQgNMQu7
         SJ5k6c9WGDqy6Il0GXo8oHm760Fg6ZGUbdT8cZcAEq89Q5LSSd9Cx6KJnLTZpTzZ9H1J
         XS9J68b4C02daCEPTe/buGoPCG+pSUyn8aytbjzPWUpWifaHKGPrLg/zpN1IF5a74MrU
         BBUgzSHbF4l/qrXuwiMt27/oibu3rTGMupzHWfonFbbtvPEAF7ZUqzfvauCbQEAC0vfp
         NQUSY8B8/bQcKpcz5bBgt+QL8WZ0yRnSfd6T7SzVFFZ8FjEfD3x4A5IO593T4hIUxykB
         Lxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759469364; x=1760074164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAecbVfIu/2KfpMJLz5+NVIRF8lakTzCsR7c7STt1QQ=;
        b=rddgj0UZEnSt2goE/IsOOrt4XdBsHed/Ad1+rveVrxj4fm1YQH0cjlllG9shjkXNfl
         OjWZvoHxXM9iHJjECwEfb7mizIVFbpVh+oE49ETLZEMgL/mi30XpKYFwkJpxqKDUXvSW
         DDwaMDJJE5O69jC1/9XYKzEQMkQG3Kd2wHitIBsN7e83RcRFWl6ye2O9NjVkCNo/XOgV
         sQYvip0NKTKK/y/0Bcxf0IWKzLuShI7Cm69GHJtT+zi/B0z1V+H/RO9G2SR7pfV7pnLI
         bHLB4AGQedL/QRRuOGtEYRHG6dJxC7hoyCQBngMP8Id5dZNC1/qGfA2ctLEDYDZGYAsU
         AHsw==
X-Forwarded-Encrypted: i=1; AJvYcCW/6ImZXyLrIH1FVX3EjQzMpIYmgEqEM9VKbR42US6PSj8cxpz06QkzT9ACZNhZkShJOw7XksTNKsbA3Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqfqG67NYfYYEC8xGT1ZKdVqXAxv4H2o2tF7vyKfj0j50mfdR5
	/AgkDCwydnPaORMWxKXfF3T5lUC9ea8Cp5JWye2JHfF3EwDGKXYZYGa+
X-Gm-Gg: ASbGncuIDDhybgUfhD9729lNFhNmyizZy1x0QZguNIlKztgyH+qSDHNYwvrFzL3+DWv
	PIgfd5XpT848iR8Z8RgxvHtH6bTwLTaelUQWKyGedx9rmbFGv+Dre7yHxQLfmYA5DmRRp5f/xU/
	7W/eg53WklaU9ImuNMaFzJjxuc4wqMw0KqUPxLR5buIaox/+U8ZR9M2zKpkTMjLXGoIOWF0KidF
	kUsbytT+a7E6N3tYqIw0FeKA2K9yxGi7ODhQA9b7Dz8pfnVtMdZ18vmiZt35SsVPsX4lQrA7urL
	bIrGMVpUbREWqu4qUt4/NfgEEJadtYo9pPc9smAAVNd/NUyXilcFjUgf/G/xEavv3vaUg99Q8AQ
	fqSIy7T6dPXzwDWdnt/gb9Vp39XDiHJ6MZ1qhZnR/ApE=
X-Google-Smtp-Source: AGHT+IEsmDDtxcH34zrU6yCLvoUnpVNeQpXjkmSiB1AE5fWsJSBu1loqYdfz+O0NGkUT3RQ1Vtyeiw==
X-Received: by 2002:a17:902:c403:b0:27e:f02a:b280 with SMTP id d9443c01a7336-28e9a65bd1cmr12557885ad.5.1759469363957;
        Thu, 02 Oct 2025 22:29:23 -0700 (PDT)
Received: from localhost ([104.249.174.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1108b8sm37676925ad.26.2025.10.02.22.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 22:29:23 -0700 (PDT)
From: Ben Guo <benx.guo@gmail.com>
To: seakeel@gmail.com
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	alexs@kernel.org,
	aliceryhl@google.com,
	benx.guo@gmail.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	corbet@lwn.net,
	dakr@kernel.org,
	dzm91@hust.edu.cn,
	gary@garyguo.net,
	hust-os-kernel-patches@googlegroups.com,
	justinstitt@google.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	lossin@kernel.org,
	morbo@google.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	si.yanteng@linux.dev,
	tmgross@umich.edu
Subject: Re: [PATCH] docs/zh_CN: Add translation of rust/testing.rst
Date: Fri,  3 Oct 2025 05:18:49 +0000
Message-ID: <20251003052826.454550-1-benx.guo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJy-Am=pC07CAWgRSTJ6WLaBdYeg8LQbVDCJp4PYoHaikFJ4Bw@mail.gmail.com>
References: <CAJy-Am=pC07CAWgRSTJ6WLaBdYeg8LQbVDCJp4PYoHaikFJ4Bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2 Oct 2025 21:33:59 +0800, Alex Shi <seakeel@gmail.com> wrote:
> I can't apply it after your previous rust patch. Could you rebase this
> patch on my tree?
> https://git.kernel.org/pub/scm/linux/kernel/git/alexs/linux.git/

> Thanks

Thanks for the feedback.
I will rebase the patch on your tree and resend as v2.

Thanks,
Ben Guo

