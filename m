Return-Path: <linux-kernel+bounces-837853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14171BADB5B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C9B4C10C6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2E33074BB;
	Tue, 30 Sep 2025 15:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSqJGSAW"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B020F3043B8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245295; cv=none; b=SwxP++pRdlyz+LHqOK21jTd6e4xv96gMkjyTt2oW7wJA2LtM3tcOyKqFHj3tDPbz4C9JmbVz2VIFXE2KieYV35RPoUAM6eKzBRIFgGUr1D+ETzRT7eOlDZMwX03vKQ1Vjhdfj6nKKTQYs0D4MMttW5s63QIvVgwHoiWbnOTvNSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245295; c=relaxed/simple;
	bh=sqQp7CJ0/ZUkBsxNzFP0LcZLdH18lJsedYddrwxvvpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQYR5kgrQQeFFlFrk5xYvfIILDDF/hQfdgTmKQoDv0WdanuuHEb4Yw3xgFV0fSq1s8KmcNbd/lvaH0ecrV5cMvw1okodLodtcpw+aWvDE/5F0HiDOp0Q8VxpDnnYLoQbS/kFqf/60+KPsCpSMUTkgTYORxYxPHGEmZ6oO7MLMmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSqJGSAW; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b5ae7a97452so36501a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759245292; x=1759850092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqQp7CJ0/ZUkBsxNzFP0LcZLdH18lJsedYddrwxvvpk=;
        b=QSqJGSAWjDtAz+M3vQ1V/WULdHxStqJpEu5vJeOq84gRzU9awazEwc68tBRYUGX76G
         tOawJWeopwYnQU3elWcGoT7qBO6HIS7i8zH7LUitFToWJyyS6qGasxWKRwFj6K5j1iKi
         QD0QGbS5YqD8gYjHQoLbb600tyL3JyvhGvWlZOkUpzCxzuKbvvOS/rMtEGYvh9OitK0n
         DOJ5js2ir8T9WJvhO+/7jtNIUqtYHKQK8rInFa6KRvIwDsL02KrlmKn9DUcz3zFWXUOK
         86zkXth57KmBKHo3DaWjKBBILTU/mFrL6GBfWyUFHY9AG7OLJKzva/4+xBOJw+cJUruz
         YPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759245292; x=1759850092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqQp7CJ0/ZUkBsxNzFP0LcZLdH18lJsedYddrwxvvpk=;
        b=aQUKEKBPbxAyAQ20E7tJJwI2EcY0RYttF+rK/DOSFYRc2zajvORfNRGy5MVw3Xc1Q4
         x57c/GGYyNaRO+98cpL+2F9IO0DKbM0XjDea2FKTPJYoKAaSfyLm8ZAvtR2vq9ZCvRzz
         gqrrdxXm0rfwGVuW2Rclo6dW8umV1hInjN5NBHNOjvgpUkpjmTM6U6kXXcWH4/immjvk
         BV1bMYo9dzl6pLPADDD7XJ7PGg1sgr8PVvCDi4pJ+knHWJxtgZAqSyxsiJjKxjxdDvrk
         oNnGPYcrjkNXNle1MFQvjuoupVHIGoePkfQ0jm91jh6BBX4ck62DCdjpG13CV06VAd+7
         kp2w==
X-Forwarded-Encrypted: i=1; AJvYcCV2jjFhhsObWD4iR3V3rMLS0pGiUZ5tnijYbN8DVBErypm0QiC1I/rV1Wo4Q8mAvDXumxbyd+L0x+PT9hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI9Al83gsm4cTrBDd1s6Uz9nKwlP5czLJ9qCGCZeuiDAgBtzBj
	9h4t6ZvWHOXUd2Iihi4/1uPAdyApU+jJ3CgP9vbmJVSs/yoB6D350Kx2o8lsDPW4GTbOlu25DZl
	Cb1voarIMLAccfa6p/GmhEFfuPHu4zm0=
X-Gm-Gg: ASbGncubg6mfIQH+G4vB5Nou51kx7SUrHN7/zD72DAUN2Rp1a0knMx2lMVXUryM9BOI
	Xy9yZIkeDIkQvXaYqkY7XRxe8xp9FHArkFgrMH+vBHnpnTaF60vz1s8yYNyDv0z/g7jDFO3HczX
	DdSiuBflMPk2SwNulEf9ccrFAN7NZeZrnazTrJ3qOlUXkruvW/3+KjbfrzHccjyKSn4zdX4a6dQ
	eb5TL2R+VZ6r/srKigXkA+zFvexWyQc01c2PJqSjXI=
X-Google-Smtp-Source: AGHT+IExoZXRGA9mlKSnNf+W/ZNX3bZkUMtUXmlXaqFzDSzAGWgOOtRwh4IW/Lva8s/pV6iOzxj6lm0qRAbLvvk3MsE=
X-Received: by 2002:a17:90b:1c04:b0:330:7a07:edb5 with SMTP id
 98e67ed59e1d1-3342a22a7d9mr11752276a91.2.1759245291691; Tue, 30 Sep 2025
 08:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGfirffPy5biFVLtSNEW60UCXa6_=-=NrQbU7iLQ8+BXnFQ=1A@mail.gmail.com>
 <175922381867.30706.10351894191632562572@jlahtine-mobl>
In-Reply-To: <175922381867.30706.10351894191632562572@jlahtine-mobl>
From: =?UTF-8?B?6rmA6rCV66+8?= <km.kim1503@gmail.com>
Date: Wed, 1 Oct 2025 00:14:41 +0900
X-Gm-Features: AS18NWAxKWtkalxkS1HEf0Xmhu8rrPNzm3u1MnhkYOFR4UIYsfyEiR54fm4Pd-8
Message-ID: <CAGfirfdDe879wFzABVZkTV7grEimpnc0XrrKpj2SX1w_TLtgNg@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in eb_release_vmas
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, 
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com, 
	simona@ffwll.ch, andi.shyti@linux.intel.com, ville.syrjala@linux.intel.com, 
	nitin.r.gote@intel.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok, I will do it.

Best Regards,
GangMin Kim.

2025=EB=85=84 9=EC=9B=94 30=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 6:17, J=
oonas Lahtinen
<joonas.lahtinen@linux.intel.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi,
>
> Can you please open a bug as per the instructions in:
>
> https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html
>
> Thanks in advance!
>
> Regards, Joonas

