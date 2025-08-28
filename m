Return-Path: <linux-kernel+bounces-790024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC15AB39E59
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27F8561FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE263115A2;
	Thu, 28 Aug 2025 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJyenKxe"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231A0311597;
	Thu, 28 Aug 2025 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386708; cv=none; b=jr2FN6wD4e+b4X9TL9P7kawrNWNmC3Q+8E6mCDQ+K+Apb/Zez3dQam6v5RiqRjBM0nDLdxWHnF9gjevpIbR3fzRfxbjL83QfpejT9UAKOP5/cPu+blS3CkvkHaXhjt9E/xtgWM+Tma+0QmemhTtgl9vA157l23MwL6npwr/U8Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386708; c=relaxed/simple;
	bh=7vtdkKKXemcTSIP8EypgaGa8rfk8ybUyyAZvh5aVdwM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jch/Dz9Gdjb6gyQShVeJDQ4g8YkydbDHwXQs9ZBgD89U3R7hInRxCWr8a3tYd+lGHpnV+3axR79TPYBAcJY6nB6S1pzRlf6nPgDDPzczwo1+Rd+2FsjMVWjsHZwxwaYYSMUWz8mPt4EtA4krTbTofc7wGMfelqhTvpPHwbhcmDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJyenKxe; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-771eecebb09so1293898b3a.3;
        Thu, 28 Aug 2025 06:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756386706; x=1756991506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mixQJA5VNMzhDOPVkzxwybu9+hBFZg9B1OsbT8DsCaI=;
        b=EJyenKxeBItdGumfcB/WStSM60FGZn0rGfTrlqrAPvdxhhv3wdf/pBs6FJCYrx2ZHu
         vIIe4lJVRALJubDlAIDT7P5HVbb2zDIexyAugQpd20kpkVE+Zh/RyX7VtqUJNtO5J8fg
         5ujtyncql6X91Am7EgGAbdPtWdX+c5fEKq6IOE8qTQYFwedcehj1vzBdU9zdDAiFrff4
         YhU2xKk5iNaGCi0cefws4TkF2uNYp+FKgQzRgzO6O9bpF7snJ9TK5eFbWW4XQ1EQQXbs
         p5aY/frL1zqaFv+0QB5NXUOmOvHF7y80Bv+cYF/Lt6mbsRzu22dpT8u2IlibvhoFYy7F
         uHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756386706; x=1756991506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mixQJA5VNMzhDOPVkzxwybu9+hBFZg9B1OsbT8DsCaI=;
        b=k4k9hVqkK9g394xCwTYinasYyCo9QADay3EwlSfonxKcJE0daQBVZi9dyw3ofSX1u3
         6RtLPFzJjKwnuPwocVkLeOHWfZ9L5E63twXaWo8OM/gjhH7Lfm9iDZURmWv5OdA1yqv0
         b5dyTH525EDdqjBMMuZe0MCiipoy60aGviR8UMScfFp95Ljj9CmjuShfpn2iTAp+wPUd
         z74G877UkCKRb9GN15waZiX3jV/EGDbzmJOM/7Cjyf/bHMpMoTo4gt33YaivR4up1xi6
         7MlgMxscoXD3MkRTcDXBRz85mJEM+U8Bgh2TjcFnGHXXw+L1uVIRYoC14eDxQIDSyLwv
         gnzg==
X-Forwarded-Encrypted: i=1; AJvYcCW5hlaqXbBRSl3UDMFtxwALaofo0FKi18LcKzvr8R0zEYw4zggXbELe+HrVpgqyMgHsFYOF39HvPKby5I9Bvls=@vger.kernel.org, AJvYcCW9rba80/YqBsy4vUdNLFHkfNV/au1zlP0XatOFcTeGLn09eQ61azfSRueVts2RVSIILWrhJ9lx6wzEZtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPSa87ftwLOMoprIPymfWLpsvJoJ8uFt3t8k/U9TRDodKXm0iJ
	e7McoJkNALCojIwoD5OXBCE6a0BjRw4zXNR2XC00CsNfVeXKi0joJIl2
X-Gm-Gg: ASbGncsnnBIP6Ba0r83fqPJfc+1knE+bjo5NQxJwgq5GSLqQ4kl1oG6+sxOeoeJlKU8
	pvXTwE2D/zVpwDyXISD/RT5Esmx3U7nfQ+fHQl21p4Ai2xhdJB17fk5Phl8FP2Vclr0x/tEHEti
	TIDY23wy5axPeBaeVeU1p6FCVeI3BOeyhWi64c0SxNYOIcI/q3ZtSWDf5IcsMbCr4RZWR70IGD4
	k/xEXEeZuwmZrOwM/mtth+Nz+5LLbn4Zs4MQuZ9agcVWnSmzM6LNH7SD5c0MY2N4EfrELX23SZx
	EHKccE6E/wzs5wpZco029AuKNugzCwgZcIya2rQgGZ+ehr1oD85sG0cHQrmVufi92XM0KG25uKH
	AuBrPUZ5d9eHnRApIDfAoIyMabV0iDndQT87WfFRNM/V6As6GNmu1jA==
X-Google-Smtp-Source: AGHT+IFbLkRYD7C99OX7/11odZX+OlwwmyhMZTL0Kf7v08V38rOYw5nOv4LsyruTNAx2C/YzX1+1tw==
X-Received: by 2002:a05:6a00:3911:b0:736:5664:53f3 with SMTP id d2e1a72fcca58-7702faafa61mr30644246b3a.15.1756386706235;
        Thu, 28 Aug 2025 06:11:46 -0700 (PDT)
Received: from shankari-IdeaPad.. ([2409:408c:8287:494b:7e30:8fca:150a:443a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77054bb0c46sm13245004b3a.41.2025.08.28.06.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:11:45 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH] rust: sync: Update ARef and AlwaysRefCounted imports from sync::aref
Date: Thu, 28 Aug 2025 18:41:35 +0530
Message-Id: <20250828131135.125303-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Aug 26, 2025 at 11:07:31AM +0200, Miguel Ojeda wrote:
> On Mon, Aug 18, 2025 at 9:11 PM Shankari Anand
> <shankari.ak0208@gmail.com> wrote:
> >
> > Fixes: 07dad44aa9a93 ("rust: kernel: move ARef and AlwaysRefCounted to sync::aref")
> 
> > Apologies, I had missed out on changing the in-file reference call for the modules. This should fix that.
> 
> I am not sure if this should count as a fix -- it could have easily
> been an intentional, second patch on top of the move, so that the move
> is minimal to avoid modifying the lines at the same time, which is
> something we typically do/want. :)
> 
> Thanks!

Hey, yep I agree. So should I drop the Fixes tag?
 
> Cheers,
> Miguel

Regards,
Shankari

