Return-Path: <linux-kernel+bounces-877717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11810C1ED86
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43223B5BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19553385A5;
	Thu, 30 Oct 2025 07:50:31 +0000 (UTC)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B4833439D
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761810631; cv=none; b=DZyUHk/45Yoap3+hFXvRMfR2Pbl4+i0F5yZa7yA4DK0nYDJ0rQyWmP7q8jKQbdo1k2d1Vtfiel9VwW/woidoLlgAVWXSiXf5AI3J74G1XVgoIqRjKhbDb4iBeXWAqtVSYVB3NcZQJ5EMvqI0TmV5Awz92YFgW8wslX0dsaSi5yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761810631; c=relaxed/simple;
	bh=CdfXVXdcEVWV8KxlMBFv8tqG6D/onHIHIshcEqcEa2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzEJgU1m/+t3OvtRtLwbxPSL1t6MpLrH++m8tMBVZBwWbR6S/QoPL1mpKEkIUyR4ht+JVKQlczd+GK/9BC93WlzKazuepzhLzGmQo2RD01y6ZKFljGLwOqLXptjLcF5NO5l9KHK2C5aF9dZbWt3N/ZeGv5dPcLCBSClMPEpmJfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-556a2d6ff0cso2142e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761810629; x=1762415429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKqtAUe6d6BWCG6Zj08y0hgYpvyRn/Yr9YKqc5tlCW8=;
        b=S+mmMNd291nDEuaQHyrRkqu8xdu6RpYj8OLhssffhNnDAcTbyin9rCuGGrasiwFgWz
         /yGWzODUJqYcNFqmlZPRAnvBZvwpFjmhBHSgrStiXJbMefEaXvOqnVFs3hx7KR77zOBF
         +r+I2CRua1bibfzuGdyy9MvFiMy4oUq0KwHeW+0ek4l0Z8znWJ+mHJB5KFtZF2ufsC+T
         p5vQP9qFEWYTfozt/c4Vjs5J1IWcdbDKoJJhpZjrxQQvaFGrnK/lasDuGF1LoDq4qHtm
         hK2Y2MmAoNVjSGdwR9mK/H82HweeoM0TxLANvyfnPG6zt1JBOLXGQNaldgXFtrosxhJh
         4YvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRfNXx6MjC0SwP//gjMTkzF2cwAqdA0PfopddX2hbucCXGuQ36Gt6DrEkg7pQII9r8DUqE7LWQdg/ZRPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfvuF+9e+fcCXf0mcDg/YSm8UiMB23tpaxLSxn4hU3GGsDj9Gy
	Hohs44bQhwO6Cz5GVHDb2UpLiPtEJnE2PDwqfTeIs+jEpgYmNYCq8RYdtEXlGg==
X-Gm-Gg: ASbGncvQGXyQfhdlxYZD8vMOVLMRi/B9ttGbbbSIkfO1dswbQQOu31nsr7iKD6grsQ+
	3/NY8pWH9gzH3SvKzDASpY0P7BZ5+yhMftVxqPzyIQ1VVUlFqz/Hdf7hXrDS8oPV3/0w/ImLtD4
	DWKAl1zC7Kt9gs6Bx2Z0t3HQv5r4lBeTe0joIrFNOedSGYmh8DbIoDb0hpHXMFcL+snaj5/ajlN
	yFSx7SjUikCcG+1cancHLa7VX1fugypULOr7S59YJZ/QPewcTRo0nJbFR2BVbf7Scd4GSxJ5H5k
	R4zwltQ0mXZQWSL115kuxgt5rLE/MSYe86WR09IyurbhctTgzk5Ts3WPjxUVRnslo0HCJxx65z1
	963pGkgDMSe7UJhxV98eSd3QZ+NhGFbf/UBBNuwHiQGcVFLEoq+AG6+83gjhKWL6sikSZZE8UdC
	Ud9f9ixPr7PhM87ueNwQ+FhnGRNFdLQITIZX87/RhlxK64
X-Google-Smtp-Source: AGHT+IGduKInZ8yZK/REkEj47BGANFNONvxmxNZmJNqr+ZqIepemM5FUlempvz7maf9mDVH/tS8ubQ==
X-Received: by 2002:a05:6122:46a5:b0:557:c86a:6065 with SMTP id 71dfb90a1353d-558140824cbmr1791442e0c.1.1761810628615;
        Thu, 30 Oct 2025 00:50:28 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddb5e29asm6503514e0c.16.2025.10.30.00.50.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 00:50:28 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-54a86cc950dso47577e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:50:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAc89dqPcaMr1jBj8X8X5UrbE1hOpiSs+QYzxF9EqstMXL970c0q2n9uhuavPlZlZjh11kU17cXpaZI4k=@vger.kernel.org
X-Received: by 2002:a05:6122:1d9f:b0:556:4f4e:812a with SMTP id
 71dfb90a1353d-55814105b1cmr1922901e0c.7.1761810627957; Thu, 30 Oct 2025
 00:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr> <aQMUGvXv6sy75nKn@tucnak>
In-Reply-To: <aQMUGvXv6sy75nKn@tucnak>
From: Fangrui Song <maskray@sourceware.org>
Date: Thu, 30 Oct 2025 00:50:42 -0700
X-Gmail-Original-Message-ID: <CAN30aBHOw16Tzdn_Z0TZKie7Fyi39bmB2PQK4LB-rjU1vn3zQQ@mail.gmail.com>
X-Gm-Features: AWmQ_blIh4FHNSYYQRBDu76pw1cN_M4hli274r6aO84F-zHC22yGF-j77KUjiOI
Message-ID: <CAN30aBHOw16Tzdn_Z0TZKie7Fyi39bmB2PQK4LB-rjU1vn3zQQ@mail.gmail.com>
Subject: Re: Concerns about SFrame viability for userspace stack walking
To: Jakub Jelinek <jakub@redhat.com>
Cc: Fangrui Song <maskray@sourceware.org>, linux-toolchains@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 12:30=E2=80=AFAM Jakub Jelinek <jakub@redhat.com> w=
rote:
>
> On Wed, Oct 29, 2025 at 11:53:32PM -0700, Fangrui Song wrote:
> > I've been following the SFrame discussion and wanted to share some conc=
erns about its viability for userspace adoption, based on concrete measurem=
ents and comparison with existing compact unwind implementations in LLVM.
> >
> > **Size overhead concerns**
> >
> > Measurements on a x86-64 clang binary show that .sframe (8.87 MiB) is a=
pproximately 10% larger than the combined size of .eh_frame and .eh_frame_h=
dr (8.06 MiB total).
> > This is problematic because .eh_frame cannot be eliminated - it contain=
s essential information for restoring callee-saved registers, LSDA, and per=
sonality information needed for debugging (e.g. reading local variables in =
a coredump) and C++ exception handling.
>
> I believe .sframe only provides a subset of the .eh_frame information, so
> can't be used for exception throwing, and you don't want to lose
> .eh_frame_hdr either because then dlopen becomes very costly and it will
> even slow down exception throwing.

Right.

> If .eh_frame is considered too large, rather than inventing a new format =
I'd
> suggest to work in the DWARF committee and provide further size
> optimizations for .dwarf_frame which can then be used in .eh_frame, or ag=
ree
> on .eh_frame extensions to make it smaller.
>
>         Jakub

Thanks for the suggestion.
An effective compact unwinding scheme needs to leverage ISA-specific proper=
ties.
This architecture-specific nature makes it likely fall outside the
DWARF's scope.
That said, input from the DWARF committee would certainly be valuable.

