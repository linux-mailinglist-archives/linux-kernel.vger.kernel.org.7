Return-Path: <linux-kernel+bounces-878626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A489C21202
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCA6F4EA70A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10599366FB8;
	Thu, 30 Oct 2025 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UId4TLOE"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8702D5C6C
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840971; cv=none; b=qmxf5BVLQFmnGN4qBjQ3tpKRiIC98on6ouxCs2Qa79P5wNELxXmSJfeywvsWbBwDCUQNimQBpTqgFlSawSt0jpPK6djbPpF/GMjf8CvSpD1faesmHDVE9qvIl44JXeGmQeE7cF10YonSx60AqnqQCkh1i4te19AczrO150NwiyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840971; c=relaxed/simple;
	bh=3PZCpmv1UBcJosb3KtjhEsOvPeKs1OWlWrA5tIUqwow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqTtzsicRBZVVqxYQcV2TfBB/vQM+yq9W/vLWFVqBxb/BteZVwC9eQKn62qN+WIZ3pUoqdKZzYQ/N+urnUbShFs3aATwNTnt9cIHFAcYJqhq6oaLdGVoyNqUB1TPcH/KBauWq4uVwLXqAIGjIfO9JHTg5epWA6qDpW39ARIG11w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UId4TLOE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63c0c9a408aso1899957a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761840967; x=1762445767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=37QCyIeGwvA6HmR+BTiKhh74UwXuJsbblG2L67MaTUg=;
        b=UId4TLOEWDiFacmi0zzUEyROjX6Va3NYjnd4sqp5HWq3WfyzEaDaXPIDBo8Rg7MOTY
         EtWNIEN0cy2QqJ4q1n+DYtvdvA5hIXxsuisI1GfSuZcJKG06+3zdVnb2yGA7JiVLipZP
         cSVfCfdG4NvL0DkXj1f/6TO8fDZTVYtYoVhjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761840967; x=1762445767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=37QCyIeGwvA6HmR+BTiKhh74UwXuJsbblG2L67MaTUg=;
        b=HO0rwnmNAOmPA0+MxKQuSGhFFy0c9+8YEpvw2gBa9A9tho4bvrrb5V33XhJx1agLZ8
         LNtGTqHl6H5fyCvaVFCoXVck72wZONv1/g4ngdSiMA11TrC5E0/CqbMB+L3X+PZP6+2a
         Fwl6YwqLLB1mPdnkZeDO/0gUoA2/Dr6sYy2OXHOVya66B4h4W4aDRe0YLJijaPlip4D0
         6NeiV4UiMdFDlHWN4Ae3wVvRsltqxgla2R8Eg5ZYwIoNvFl7e+1JY4fF9922AFEvb88O
         pPbaq3Fgu2YcbObG5wOraL+7crdsANbhS9EcnlI6JUzEWXt6gaaQR1MP2dvu8HA0ixkl
         nD2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSFSGTSSARDnOdK+ddqL5N6ZlyJUFAuPw7R9qtaPszhU7ItX3xEtv+3NM+Cj+RIGcMMJTJmoSLt8ffEfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy07IGjdk4QUjkvJExuu3qvRwMdNaE4VHKD8h/e5Lgvd/7PiQ9
	R5ux1BVbhdBCwZ6UMvwCfHUadElMCWYj/Cm1VGSbO6lFHPcG+dxu7t2qKPKR5xVoB+GdZm3cK38
	44CC7A8U=
X-Gm-Gg: ASbGncuvgCiXpkUV4N8h25shJZehu6J+8vRlfln2pP1UA+H/EvgMbnKrsGUHrC5uAPe
	v6funBUnh2BcAL7ZTTOjGCoS2lRAZsH11ryPqDC+I1P9v9J5hyI9BeCg8ROXFTDAaM60rtQQJwz
	OPVfqeBpWssBe9Y4tgsJ4avpy3IE6o5azcGJi3nTEO89gsNQsoRCxK1C+spdb6s3XjePt+Itghv
	BJEYFwDYYdS6UIEwlg+G5fcMp6U2Q181c657QJv1TZ7NDlEuLwLj1WI21aj29GamMa/aI3rQ7wL
	N28giIVU0UuRoXjLBlGJCPDsc4gDqV81Ar6sP6V6H9M1b7Ikr+Q46WqodGI7RzIFVYSMJJi8nX5
	Z/mUeY7T81Fp8ro/Mc3zZ2GO5uAJ/bV/K6c8XEBucegwz3UuFjBk6ccQxbsWsGa7yoWemzA4FA4
	70Dr63D3lJpqPioqj58UA6x/chQjkpWBojxLN/wOXUHgrv4pTiVW1ajkphJ0sI
X-Google-Smtp-Source: AGHT+IFRdNOiusNmm4LsQcLyUEyJCb7MzkbteiUiWmndcbGL3r/gPQX876nVZeaWaEI40JV0PvD5DA==
X-Received: by 2002:a17:907:8693:b0:b6d:2f32:844a with SMTP id a640c23a62f3a-b7070188912mr5608666b.22.1761840967274;
        Thu, 30 Oct 2025 09:16:07 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef82865sm15120704a12.9.2025.10.30.09.16.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 09:16:06 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c0c9a408aso1899886a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:16:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJdHRsurlfSPMFcSwuyZ8Z4GcIC1UfPubSPBOYj+5N51Va4y5iKU7Sdh6m6h56QFkc0mAMxDfOodPJrhM=@vger.kernel.org
X-Received: by 2002:a05:6402:158a:b0:638:d4bb:6c80 with SMTP id
 4fb4d7f45d1cf-64061a85a65mr2751516a12.36.1761840965644; Thu, 30 Oct 2025
 09:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030105242.801528-1-mjguzik@gmail.com>
In-Reply-To: <20251030105242.801528-1-mjguzik@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 30 Oct 2025 09:15:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5o+BPgrUNase4tOuzbBMmiqyiYO9apO9Ou-M_M1-tKQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmbYP_XajbVrJr4WKmI6U_GU3vIz5LIod-PXSCdTIzn0TCAmvCzK8JZig4
Message-ID: <CAHk-=wj5o+BPgrUNase4tOuzbBMmiqyiYO9apO9Ou-M_M1-tKQ@mail.gmail.com>
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Oct 2025 at 03:52, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> Should someone(tm) make this work for modules I'm not going to protest.

Btw, that's a good point. When I did this all originally, I explicitly
did *not* want to make it work for modules, but I do note that it can
be used for modules very easily by mistake.

> Vast majority of actual usage is coming from core kernel, which *is*
> getting the new treatment and I don't think the ifdef is particularly
> nasty.

I suspect we should make that #ifdef be an integral part of the
runtime const headers. Because right now it's really much too easy to
get it wrong, and I wonder if we already do.

              Linus

