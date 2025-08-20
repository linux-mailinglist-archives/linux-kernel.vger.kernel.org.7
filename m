Return-Path: <linux-kernel+bounces-777036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73056B2D454
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E17E3BF456
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C452D12F5;
	Wed, 20 Aug 2025 06:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZVRWyZM+"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ED42797AE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755672770; cv=none; b=ajaUcuRjdvycgo/COzhjW78ltfvSa6X09KFvFrothZAC64zOl/Nj1RBKkAZfHIjjF46LhFa9oPXa5Q7TrV6EIueoIKZKWIHq2gIwOp/ntRBLfCxVRawfL+T7Fk/P8GA5Y+KPbBf7Vu+vqnLh+Uihwe0iJPbY1Q9UMl4NVh9vhLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755672770; c=relaxed/simple;
	bh=8KpNSuplwGzUxo+pl/kaST7GJG3ijoRwu/q/QBQCOQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LO8u9UwQbogG+ET7ABT2t8R2v4CP6NzmK6g93SalRfFm0KCu2dHXQPxaLvGcLE6tJCQ5tCWp16CDDFFOaooKeZs+fyIjhyECcTjVlyGpEXanRXDG7GoUrhRqex3s7X0h7/4Mk7FQ8VXjWL4htNh/sPGWwe5Kh0ErtiNWUPb86T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ZVRWyZM+; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b0fa7ed37dso6287101cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755672768; x=1756277568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=50jwrZQGjSslyTyuIwE+ZuameHGuXlZuSBPYcNv7KGE=;
        b=ZVRWyZM+Bu0wsEu0yNCXSetYI+iD1L2DQAO0g2CrR+UQrKK/Y3iQnDtBMvLlPu3AKM
         6yCcontr7PhcI6qbkfRLciQtaBFBp4xy2mISvv5zJHH7qsAyBGf3tuf8ZIkTuc+twaRa
         JTHRpDfpLrij0ap5ioA1LZbxA+vnwXcCrWPsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755672768; x=1756277568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50jwrZQGjSslyTyuIwE+ZuameHGuXlZuSBPYcNv7KGE=;
        b=u3s0Gl/1eMNNiwuP3yVIJQjKA9Yl1b8N8Cu4mqjpaMptVLPB5rlVzuM2bVfk4H6epj
         rZ2Q9qWEIPmpe35670NV3uUP/VlBWQo2/9egbaQjcp3u60qSbdc63scc7jMHhf1eihKn
         onTwMNjpLYhjJDy85NsakIaGDiW8jHwntW/Cl0IyGP/PYHhtzfrExKD6yNLzaRLrmbh8
         QYDOp/XTwXfQsf0YhnGhUYnXx8ng4fczqZpdfM+Uo/Fnr/GjyW/xhKihP36kmmlz8+dI
         HzRyHqLOwwbqmWIUngY8mo+GcKnN2WVmobhxPl9sET2p+qyk0diPDimuZxvsldSk33IZ
         sHrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA63rtNTCOPovxjFem0ieLy0niOo8fnDH0sN+f78ckOoPo4gamdsGyS3VvojNpNDPHUgSXgzx6QptP/r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwixVaWkvZ7zclb7f6tP2Y7ht3nQm+m1tGNKRqr4EedGmViDx0U
	G0b223ODfk1tWHgnnDkXOVC9IqVcEeDsDbrQBXiHztORQCeB9L+eH701shrfQYMvWBJ2bGzieOo
	mISQgokywbJty4CXPOWsnjjje26NJ4l3ItKr8SqJplw==
X-Gm-Gg: ASbGncufGt/SYF9fFhnS0W4gBfhov5rfEhj62Xv/EZZy2ZsOf4A3XgB8bJn2LtzNkFp
	MOdVW5GYavqhZptHKFKkmrc9BQ7fUJ/Ug712yM/0zaSYu7vo5YCaX4/juT1qAOH7jxORVvV9/An
	CiGUyZLoVZAg1+jkvmImB5iUkD/YiJS13mapP4dM23Af7aCnZvfqO+UOPG8E8TR+aHK7gZ1dCCk
	VxYt2NBRQ==
X-Google-Smtp-Source: AGHT+IHMMLFegyAHtkHM39XKsIT7CwuHtFQVVR0IPD+S1rOAm1yFvIpYjEgCtH8dZpenVWW8VUPUG0GfQjanDxMFd38=
X-Received: by 2002:a05:622a:146:b0:4b0:769e:42e8 with SMTP id
 d75a77b69052e-4b291245817mr17863531cf.29.1755672767783; Tue, 19 Aug 2025
 23:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegsz3fScMWh4BVuzax1ovVN5qEm1yr8g=XEU0DnsHbXCvQ@mail.gmail.com>
 <20250820021143.1069-1-luochunsheng@ustc.edu> <20250820052043.GJ7942@frogsfrogsfrogs>
In-Reply-To: <20250820052043.GJ7942@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 20 Aug 2025 08:52:35 +0200
X-Gm-Features: Ac12FXw2UXnjG3CcysEUnSzytZykEIInMtM4kPoHI69C9Q7SHuaQEOwDwiyPNBY
Message-ID: <CAJfpegtXUekKPaCxEG29SWAK0CTz-fdGvH=_1G5rcK9=eHt6wQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: clarify extending writes handling
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Chunsheng Luo <luochunsheng@ustc.edu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Aug 2025 at 07:20, Darrick J. Wong <djwong@kernel.org> wrote:

> I don't understand the current behavior at all -- why do the callers of
> fuse_writeback_range pass an @end parameter when it ignores @end in
> favor of LLONG_MAX?  And why is it necessary to flush to EOF at all?
> fallocate and copy_file_range both take i_rwsem, so what could they be
> racing with?  Or am I missing something here?

commit 59bda8ecee2f ("fuse: flush extending writes")

The issue AFAICS is that if writes beyond the range end are not
flushed, then EOF on backing file could be below range end (if pending
writes create a hole), hence copy_file_range() will stop copying at
the start of that hole.

So this patch is incorrect, since not flushing copy_file_range input
file could result in a short copy.

Thanks,
Miklos

