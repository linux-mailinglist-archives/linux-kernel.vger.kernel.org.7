Return-Path: <linux-kernel+bounces-890068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 245DFC3F30B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABBC74EA9EC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EFF3019C0;
	Fri,  7 Nov 2025 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pDgsktyb"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C267A21578F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508263; cv=none; b=Zl26MtaUnQ3hK8W0v0nO8YYIwUbPDcuH1GAhO23TcBnSJYrwey0QiDIbZgejsTlF83WvLU3U0E3VaiF53aRC53lrmj1QmnfCbusMu+0ZvKdKSQ1Mw8zsPmPfPdeUpbzFVChAZSmg4UPoXxlcnsIAy4zWI1BQCy0BrJkpYQM6Tew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508263; c=relaxed/simple;
	bh=d+fykfbo0yVSu5PSzD1il/dNIIo186gGMyzSZ6FzhPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jJ0UBkCxEsiTDE6/xBCu6e1rU7Qxsu8KL0qtF2CfejVSKuIRJo8+8dzM3REtWjlutVf6YHDJn5Pgwqx1XjN0StctUADpVmdUMRYuMt/LNYghf/A/QYidT7ZIINvcylrGcrLbbYxIOYFXDU5fsHPKR+GRe1BwwH28YZcfj/HjSA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pDgsktyb; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4775d8428e8so3995795e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762508260; x=1763113060; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+AnBAo1ieXfvVE9W+nwSIevZrdDCppUWTkwbf9O15Qo=;
        b=pDgsktybRkhaxwGIrbn0QDqQ+hrQsLdJtQ4vwwhuLBBrtcaJB0eUVMAQ2Syt9Bcj2b
         G1NBqER7+ogZabRnbvehZkXLygKAMpy96vsDVOrT/i3xeZMlWV9eMHzn2fzYs2P/2KVC
         wPVnugSxBAi8CDIYucI7xVGF0Yl1KOVF44FtCjRWwyWMW3SnfDLBmiHF0dEn0q5UQWZ7
         +9qn/NOmC82JVMU50ywqFTDKYBhUsx3LWNvwyJXCi1skutpsHBtAPVjWqcVaUMsnYu2G
         EJrK6tlrLxJ/NqoGfmcexbjFfpPH2Eu8NC3Z1vt2cw+mTGXnSUUZ0G56MyG5snyz6K79
         NQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762508260; x=1763113060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+AnBAo1ieXfvVE9W+nwSIevZrdDCppUWTkwbf9O15Qo=;
        b=QghcP1KHsXGzRRRAWH9L8ocPnY+IEnVDOs5PImBmRXoGyBXjU4VkeEbIdKenmymfS7
         KvWL+JbZm9fnIDM75Q57ZeTabIyB0LrxCA3wPgJNJT8JULMF6huG5AoUe2GfHYGTU/mn
         9IDgfBhR0RJ6+xVGQmvUAb6P687sZQjy+Kpqn/O+fn87fE+k5MiiZYjwJMHPjU98BvCr
         kJApwJQNB73fz8n1pFFMRi7P+tdvbZVMo0wzEzGT2xg64y31V0Qw5XIdigZLkBFqXXjy
         OvCwNfWe5dh+l+fICP3unlZns55FMGtBw9fJMLgtr11h9ZEVqymnJ4A6prgyY4qxfWda
         x4hw==
X-Forwarded-Encrypted: i=1; AJvYcCU16anDB0GwMxO5dT0HRxbRPSYfOaJ3NmwycIyvS+zZL0+U4cHze6ld7nzuX7g/dgjE+XrkDYghUslGIl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfB8YQyVyBnd47gHFT4NlM6oOdq02PsjxNmmJI2wBv+pArmw8i
	hWUHxfqTzT8qgtWISJdZqARB+fiPP4lxApdHZWnZNoQ1W/8VYS+9jclgbCugsZA6G9TcYlgN9JT
	WThPPWQx/7lf1/DPUuA==
X-Google-Smtp-Source: AGHT+IFx6JnB83u2hch19RaQnggflMp9yQa+OdndiPmwepxjVcH0thfA6gW27ocmbkG1cgsMwvesbWOHXfMAUhU=
X-Received: from wmlf4.prod.google.com ([2002:a7b:c8c4:0:b0:477:5506:8a6d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35c2:b0:46e:3550:9390 with SMTP id 5b1f17b1804b1-4776bcbbb54mr23797035e9.20.1762508260292;
 Fri, 07 Nov 2025 01:37:40 -0800 (PST)
Date: Fri, 7 Nov 2025 09:37:38 +0000
In-Reply-To: <20251107091612.2557480-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107091612.2557480-1-dakr@kernel.org>
Message-ID: <aQ294kwmW_-vu_1f@google.com>
Subject: Re: [PATCH] rust: debugfs: Implement BinaryReader for Mutex<T> only
 when T is Unpin
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="utf-8"

On Fri, Nov 07, 2025 at 10:16:07AM +0100, Danilo Krummrich wrote:
> Commit da123f0ee40f ("rust: lock: guard: Add T: Unpin bound to
> DerefMut") from tip/master adds an Unpin bound to T for Mutex<T>, hence
> also restrict the implementation of BinaryReader for Mutex<T>
> accordingly.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/all/20251107134144.117905bd@canb.auug.org.au/
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

