Return-Path: <linux-kernel+bounces-810644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA691B51D37
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DD9B4E2D33
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72633314C5;
	Wed, 10 Sep 2025 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoC1xbOf"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85671B425C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520837; cv=none; b=a81tEPRAqHBDDDDmCR0D0SiNW6ecdd0upDq5BTXf4rLeZnbES4raZXn2FxRjA2iuLeTMKFMyYq2roPBkGlIA2GpzpaC3VSWujOFVOvA4kIXkwKoCfybM/iGVeU7hjcdndZdHYmqS8ZjPin+1yeePXVMZvUVecRt/Yv9bk7Haog8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520837; c=relaxed/simple;
	bh=QdiDWwxajDafGytCRj5Idko5t6hGYc52LVL1KdhcrAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LxK56RaxXEidUJuFecspbAm7HPVL36KXY2osX/MLxu3cFO7oqGvThx5vZCcotgXUk8T5NKEXVg0rZzuUilbs5IPkyKh84V59UNOmufK+JjQJJNttk5PiCttS3MWMFxvCPc0PMh7U/dUh5FJnilzuyILPjwE8mN0AE9mWSMDepPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoC1xbOf; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32dc4faa0d7so657591a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757520835; x=1758125635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdiDWwxajDafGytCRj5Idko5t6hGYc52LVL1KdhcrAU=;
        b=QoC1xbOfL7H/N/gNRArMUFz1iaH7BGodKqjamav3x4pjwyYoz7ZfvGkjLPR3r9iotd
         P15CfQ4rpy/RZTgw0VWGSYxcPr3xSoP2ucVKp5GfPdmhcrU0vxB8WFUqQuPFW8cd24LV
         vel9aHqcoRSMpf02eYRcoHUEw6Qmnh9uq2/h12I0lIBUdplysMrB461+ZUTL+TB3ctFU
         n4JgLmdOf1EtaIKzwDicgsCIUallhr9/deK9eIjrPsFhygLxbdqc62vqj9zyCIgrU/Cl
         nXf6qek6vOQfcm0p3fHPTyNpOnDjU/Iu+sZdSq9Kw0EfYXJEfL1W/scEmGdsfPh06RU1
         ZfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520835; x=1758125635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdiDWwxajDafGytCRj5Idko5t6hGYc52LVL1KdhcrAU=;
        b=GJSNgYY9sSVOO2Fbw0Dtv1USmo/yxX73dMf8Ms0QvYBr1E5+jfrjuKga1mA88fTsat
         ey9X6DL6y4MvatJbpdyFopFho0FbbHaeJByuuxJZU8f9Yqn6q6bkRWgx5Pvirc42KjZE
         kZrJBa5mpl8v7/cCqBHaQrtWV569gu6viPExiMCWY87mjPGtQOzXYJjmmO4dLalQnogT
         4yAPOHHR5gAPuvN24YS3Vx0z8/ANjgKuWf/WPppr7WPeWXETgf/tn6GN8gO5OyGLUD4d
         Q1v3xAnw4YHhkk/wVK/fWszIZtxRvwPUYpylDYPyZdYBiwDWuUuoygL03IcniakX/TA7
         +f5w==
X-Forwarded-Encrypted: i=1; AJvYcCXtXAPYAvd0F2a5ccfHEJGKoDMkyu5WaqB6sW2gT6Thc05Uwq0cO0pq/nsx+oO3OGCDkWZJEdo1cZIncHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP1IEYYufgLaxALJclhvC9la6ltsCgf1rYE/RaHZppU+ufInUD
	j6zAK2yKyP/0AsvqfPJAf3zxPxn8BJ9QMeU8crEASfd/SryBmsZvgU6DhHW7j9HymzYE93QIOgD
	AG8BW+nn7nKV7OBPelPW0Phgof+j/0QM=
X-Gm-Gg: ASbGncs7xUFMdOG2YIVqtCIVOeDXwZVgShYLkRjxpl1MwmKHKV92aGoyNQg99zBwm3Q
	7nLG7g0D4VvLCcHnhVoC8/MHwr9Nu7KcjNHT6uqe+kF4eZfMZ2FB+t5QDpfbGU7lyMnMCJgxVVv
	8JlJszdot/w+xwQKEOsZpELhMmv/Mw507lCoKCf1HOQ//YkjUA2x/rq4PCemop0yjpQvJZF1+Dt
	sjV+Lz0Mko=
X-Google-Smtp-Source: AGHT+IGTt7x1vLOYMI6PYO93ndUSxRjal+0P7YHM1pddCpCgfatgREvad06nsjSla4ZkyN4Ux4D+siw/yg6LeyGPZ1o=
X-Received: by 2002:a17:90b:3950:b0:32b:cb15:5fdc with SMTP id
 98e67ed59e1d1-32d43f82724mr19760720a91.30.1757520835029; Wed, 10 Sep 2025
 09:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910160833.3464-1-ryncsn@gmail.com> <20250910160833.3464-2-ryncsn@gmail.com>
In-Reply-To: <20250910160833.3464-2-ryncsn@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 11 Sep 2025 00:13:15 +0800
X-Gm-Features: Ac12FXw7L2tf9IDZt7MK2f3EMzzx492hVTOs8W7PnEPHCh4J_mvxiTWsay0SzGY
Message-ID: <CAMgjq7Db_DbZosWrUUAGfObDYA2e34zB=RtUpRZc2u4RJBiSxg@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] docs/mm: add document for swap table
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 12:08=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> From: Chris Li <chrisl@kernel.org>

So sorry about this. I did fix my git config and verified that, but
sent the email on another machine that still having a broken config :/

Hi Andrew, can you help fix the Author to be Chris here?

BTW I saw the current version in mm-new, the author is already Chris,
which is correct.

