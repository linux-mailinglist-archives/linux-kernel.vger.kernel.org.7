Return-Path: <linux-kernel+bounces-726980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B078DB01393
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7051174232
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906BB1D618C;
	Fri, 11 Jul 2025 06:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCFr5MeF"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B32C1DD543;
	Fri, 11 Jul 2025 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752215355; cv=none; b=KafL10etMoScLXZZPR0DCkOk0Q0HGwV5dF6v8pyiIPyqninJjBD+9vdi4gJvtbFhUTl6YpbedS3aZwaWtnkvIn1sRAsV7nQfGPTuD+aBOfBa2F+331bsYHz5Plmiw1ES10nEzfWDePjmkbyG1HNanSs6AcvsAdn7k6E17EFglIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752215355; c=relaxed/simple;
	bh=XBHCzQk52+WakhFmaUYCMp/mXQ8Bibmq6sj942pmOe4=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ATmmbcYt7QGKWGnykKTzbv2wDgBwFtJsYPE4YgTr9oKzgOm2zyqHQW5YaKaV/J5wDQrl4zx2DQHfGOKGmaBBXyvoOqqaf+7NZgRYfhWYgKYEkvZIa3tRyxOYUhxsJJIocbcGaTA+ydppX4yFEagFnoNKS8TRqgaNeaZE9mcTfMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCFr5MeF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-73972a54919so1589296b3a.3;
        Thu, 10 Jul 2025 23:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752215353; x=1752820153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=doBsTaevLu6acrfbrAIdB5MrtI6CLhxUs5MsNAnj1E0=;
        b=iCFr5MeFHL0gk1faBx6tdXHBlYyp4WBYBW2w6+Q6O7TqvOgIpzp1zzmzx+NsHlICR5
         FY+AvzztgO/iXTrsZXg1rue6th9wxPnftRn8L+PXNEKe9Pj4p0Ce7o0/NMdsjoJNkk40
         FyHFiQvlg32OjhVGwQr+0eeVzLWHXecVuZ7fkryvztXBaU1dTI0zy80S3qIc08RfrAN0
         fCEIRdhIYRmpuHhZlK4GgdO9kF5jE4eVqqqaNxUd7U7/5+8JtnWnpvKPYkxuXyQgHzvU
         MCrBSH7ACg6BJKuy9j+zWb/yMWCZrSmF3NP9+cNqF6xZRL9mvZiAK/6Q+RouRw/UwdOY
         RWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752215353; x=1752820153;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=doBsTaevLu6acrfbrAIdB5MrtI6CLhxUs5MsNAnj1E0=;
        b=SPCmKRIon2CI29I2rU56ufp/zX2cW93va2xfuOV7ozsZxH6ysp610/QoCorqOwYGMR
         n531ADaNXcU0YPAx+lP55ujKKOUeDEyu0MdXPVxW2jTQ92od+8+DRyoIqWs/Lz0oCRMg
         escBhvYc7zgoh3aFiyfsbfpmrxgTfY2KojXv3gtA/THASL04TWf57hIXJzkVNyDzAACd
         jtj1I0G9g3YojfV+7xJtKSFEzjZ4TnUxLUcNWz/CWNCjaiXvSGmEMJKrVvFDHn8PKdTk
         B+inX9vJaCRUsRAJJ6fAbqAAH1Nneb+ojW6JgzswNmfZ2LKWBfCX6Fm/AUzgHmNbTukB
         ocOw==
X-Forwarded-Encrypted: i=1; AJvYcCWdar3oJVBMxwT3V2W+ZaImNK/0g/KZroC+cDpOZMY+5CNlU+jtj7jFKZJDzdWXff9nPkcYWTyIp1ETP5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmSRVdZAsQtKJrK9bPT/ba5uQ0NVx6QU5QTeyHAaUe3Eg2r1RI
	Bw3iCa7xhZEm6IsDXBoi2beTFkOC+T2IGDtGIBZVYiD/6p+TNlSdmTQT0gYrDqr8
X-Gm-Gg: ASbGnct/tx5iw4FhcxmAOELEw0AymimJH9FDxidyRcjDPNBc40jFFncPVvddsgJ1IZz
	rfPasIiduQQ0W3IhSbY7hH0jJRT1+8e3Wst+L1P3f/og2cMln/CYE9SshSzh/iDmOn1DnT/Pwa3
	Eotj1su/ixWuXqfdCoDeGLNEUFClzS16JNdznBPeqma3U+pgu3Hv4nl9KIMFWcG4+XCZDUiz02N
	X/30Rik2VGoLIBSRR1EoG+pDYCU5iaH3FcobQWviVwQbrcw0jRwXqL+eQ3UmivnlyeOrVhQY1UU
	iZEbwUf4l/iTroGsDLryD/2/SRqcedvukfbmF0ppcgAqmgR2nKJGT3ldHbpwOGkhnH9KQVPDaKs
	E+XSMLd+4ODYE9oPZsuHSpxQGQd7J5EwWuPNH4yavQrvoiJ9WGlH6S3P0SpgThmDGcbuGr7neH7
	Kd
X-Google-Smtp-Source: AGHT+IES4WNXXt0Et9UN1DETgdYyyjztunjVzLzrap2PGO5Ol7oBrMg2NuqRBgiT8gk2COUrGDTO+w==
X-Received: by 2002:a05:6a00:1398:b0:73f:f623:55f8 with SMTP id d2e1a72fcca58-74ee02a8c26mr2290190b3a.5.1752215352740;
        Thu, 10 Jul 2025 23:29:12 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4b16fsm3981909b3a.120.2025.07.10.23.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 23:29:12 -0700 (PDT)
Date: Fri, 11 Jul 2025 15:28:57 +0900 (JST)
Message-Id: <20250711.152857.1107725157402630466.fujita.tomonori@gmail.com>
To: lyude@redhat.com
Cc: rust-for-linux@vger.kernel.org, fujita.tomonori@gmail.com,
 a.hindborg@kernel.org, boqun.feng@gmail.com, frederic@kernel.org,
 tglx@linutronix.de, anna-maria@linutronix.de, jstultz@google.com,
 sboyd@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: time: Pass correct timer mode ID to
 hrtimer_start_range_ns
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20250710225129.670051-1-lyude@redhat.com>
References: <20250710225129.670051-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 18:51:13 -0400
Lyude Paul <lyude@redhat.com> wrote:

> While rebasing rvkms I noticed that timers I was setting seemed to have
> pretty random timer values that amounted slightly over 2x the time value I
> set each time. After a lot of debugging, I finally managed to figure out
> why: it seems that since we moved to Instant and Delta, we mistakenly
> began passing the clocksource ID to hrtimer_start_range_ns, when we should
> be passing the timer mode instead. Presumably, this works fine for simple
> relative timers - but immediately breaks on other types of timers.
> 
> So, fix this by passing the ID for the timer mode instead.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Fixes: fcc1dd8c8656 ("rust: time: Make HasHrTimer generic over HrTimerMode")
> ---
>  rust/kernel/time/hrtimer.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Ah, my bad! Thanks a lot for the fix.

Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

