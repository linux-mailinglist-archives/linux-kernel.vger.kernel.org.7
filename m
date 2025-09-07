Return-Path: <linux-kernel+bounces-804781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA85B47CE8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 20:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF01177416
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 18:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCDB220F2F;
	Sun,  7 Sep 2025 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4legIqKH"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400AC1A2389
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757270821; cv=none; b=m1Y5CnPUiMN5dSvsDhM/NsdaI0ESikMzKQao4giP+SadTHr0gL9czXcsxHGnaPDcteo8lXEh7keNpM6hEhY9MfVOGm4d6ljJLluFFE7eafc70tTIsAoLxkiH9MOrkiu1sA6HQeIcepF9XmqqNs5eAT0q9jvlG/wKzQQw/Nx+b9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757270821; c=relaxed/simple;
	bh=T3EwPJtzj1SpjYFQ48lBl+QcPQwCf4Y2eCpeUVXk7Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6iaG8UMGpZztWeYQjhHZsfcGM4OMrcIONAdLYpqWcb+mFw+gD5mHZjHA0uuP18wvmln1n5nILIFowm83QhTAfenA5Z9oEz/3i8iCgHHfUJSjbZchCNErHxQi2jJ3xNpuL3CzafNrAOxHzODZb7GATVq2tBJRy+e749ocHdr03E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4legIqKH; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-401078bfacdso12622915ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 11:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757270819; x=1757875619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEQRuei5YFvs4wxgmlDYvTephk2WPSdhzkeIUgzcfhE=;
        b=4legIqKHn0wflrNQKfcNmOqCGUkT8yxdhMEdaqmijgMTOBH8Q3Ue215LkfnV4Ru8cr
         0LFDxb8HDMG+ZlYh4w+JlCeCZJc4OY1HIX/oF3fYFTOE6dpWcig/yfOl5mdex/2e3QYL
         dBZ2xYdaOFCHGRE5RVUjbyme8cU6rsY/aT6gNA671YRj1cGxy1ntiZDiZTW+io/oeXYQ
         IM6p0AAZSRJC/7qqagR+4qKE/KDROR7J/uhW3a5hdKxOooot7aSxMvIJc9GopywxUe7L
         dZs/f1XLxCaCUPFYeecp7j+Y4w97IOHx8KclJ8Cngq5K7zUFCJ24Wq1oYfKGZSiZqDK6
         92qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757270819; x=1757875619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEQRuei5YFvs4wxgmlDYvTephk2WPSdhzkeIUgzcfhE=;
        b=HhdESn0uKbLuPxAFxE7hZY/XJT3N6IytqSU5tHCfgzjlAQodbtDDFHtRTD8ILyl3f1
         s+P2r1ukQUK3lzsQtEuv1/FZQeSfRRNcIDFMoRknd7DRlD7wFJGSDAwlkrrnrmukw8Vz
         3BCAwaxVUU+m2/dBGhv++2kUH8r4xMlexbdihy5CjwAuR1XbvBY+4nT/vLXTysw+VYOe
         0V/+dWGywAXhJ7tx/4PLFVvDIQExEOPHRT+1n6EwWRxTyT91tgFEY3V0x9n9g9xaNFCg
         fM7s24+6J/c2z58OSNOZA9AAjO54dvkpPBMY8u09bvK9ubA672wNTA8nRv9IEjUpUQxU
         kk9w==
X-Forwarded-Encrypted: i=1; AJvYcCUATLLl/ChFqp3PbfN3QE10BRcca6xAmxozMZwshuMSsmttFEwD2J3zgKZvHtO54w8e++K9lYiOZeqR/Og=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrSAQeQjlcFpWJduWy5+0H2isnfrz8PLX4xzfPCvWaIPjGkN7p
	6ooKHZO+LeQgHs5BmQ5UiqAQVCvIrZGO0gXPN0U3079fipID75qFAVyCevg6wk0Z7Q==
X-Gm-Gg: ASbGnctUf/UjbvFBwCxemQgFHAZ/zryMtBw2C3P5ZfemHuc/jojS4LquUJqTyAVb3WE
	FBhAsleZru5j6fIsJgOEsh7rD+JXHTPMTM1EI1yzhewB8ObbB8M6NCj4ZfDCcIj+vQpoMsdzNiO
	iidHqgZsmMYInqQZGS77Fgy7TBjEtPpzvx7YXAROgy88Wa4FOmIZAVZzO8UNTZYmGAfWSaXAeYF
	WH7hZx6XSOt+gahDZaMimusEZTsZmNX41AH3CGy+3UiT8YWT+djgIq4EIAnpSZgUgSXbSE/o8SP
	Y7QUE2Kzdu+4JXa37LJr2JSWDWQm4IjLO7VTQaIkp6cu1Lkxo3zhriooZ17JNet7x0042MhykYp
	/qbs23VZjkm6K20zjQ/xDgESjtq1/lY3q3c9+Of4WY+BCkfNC8A4ILrAg839OqHy6h2v7fvtRBE
	D5gT4=
X-Google-Smtp-Source: AGHT+IFP4TFfhBSXgMSup1FEcAD1tiIYNyc16qd4c15z9i573dYTshH/4CnU2TUvpU2Gmbm/2gjnmw==
X-Received: by 2002:a05:6e02:1607:b0:3f3:dd9a:63d6 with SMTP id e9e14a558f8ab-3fd961f424amr86831295ab.22.1757270819059;
        Sun, 07 Sep 2025 11:46:59 -0700 (PDT)
Received: from google.com (222.121.121.34.bc.googleusercontent.com. [34.121.121.222])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f3e0da92a3sm98600735ab.41.2025.09.07.11.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 11:46:58 -0700 (PDT)
Date: Sun, 7 Sep 2025 18:46:56 +0000
From: Neill Kapron <nkapron@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, kernel-team@android.com,
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: fix logic issue with per-file labeling for
 functionfs
Message-ID: <aL3TIN9UtGHKELuy@google.com>
References: <20250905222656.3692837-1-nkapron@google.com>
 <CAHC9VhT8NrsXMM-PPZJ0EPLxFHQ1vOu+ASCd+82Xth_mJPnDiA@mail.gmail.com>
 <aLunR_0BPCrATnBP@google.com>
 <CAHC9VhSaAm3G9bnJ86Aj+DnTio19ePE1Pu3voaB3XUvBveodbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSaAm3G9bnJ86Aj+DnTio19ePE1Pu3voaB3XUvBveodbw@mail.gmail.com>

On Sun, Sep 07, 2025 at 12:58:33PM -0400, Paul Moore wrote:
> 
> No need for a v4, it's just a single missing '!' and the commit
> happens to still be at the top of the patch stack.  In cases like this
> it's easier for me to just apply the fix manually.
> 
> Fixed the upstream commit and pushed back up to selinux/dev; please
> take a look and verify that it looks okay to you.
>

The commit with the fixup looks good to me.

Thanks,
Neill

