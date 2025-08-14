Return-Path: <linux-kernel+bounces-767939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66437B25AC9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90A21B661E9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A39121FF4D;
	Thu, 14 Aug 2025 05:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5cHtRuP"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6A31C3F36
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 05:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755148995; cv=none; b=eM1EuMMgCmFlx1Uu31xFUxU9hfevBtqlm7UR08TZw7ZGHB2qg5wFkHYYZuwcbOeaqkeHRKOh4hSzoaEWrxwhBkZIutnEGkujLT7keV/0aaDmIMG80VtoVRuWERPxBaRohl7oRUQtv8atGIw/q67zN/RmlqDWpJxDma/dhBSZJj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755148995; c=relaxed/simple;
	bh=3LSoCl56fyWME0v8PiSkctUuL3gtGDTjl3bz0icHfT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdgJTVcFBjfCVkBsfORO647KMZdHXLAMYKugx27v9Qm/AgMz1qK7NajVaE1g/ccKB/I+zyFE77/pjiiC8UNMgEXQGr+mntUmUJ+/BAApLAS7gqONNd4XQItwFniipH9gkVQFM6T7yLWxcx/HiZk6lsoRq4wplKlCMKyeK+WAQB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5cHtRuP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b0d0bc0so3566285e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755148992; x=1755753792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LSoCl56fyWME0v8PiSkctUuL3gtGDTjl3bz0icHfT8=;
        b=b5cHtRuPG/9E9p2llnY0xQjT2uR4Y9NWqZzBQxQUdg/qcmikQ5cKTVBIphbrfzSycV
         nJ7Q/g9LedV2eYd1t5zT+S49X+e1C+1Y9550/jRWmU4x1FlYHlf6+2kyQQ/agS4IqeTJ
         imYbbCVu5XewGWM1kP8+mr/fjFaVL/UTbk5RHQwo9F0ArzL1ADHbMicIl+mHdiJExorS
         Nkri6v5SD4SCWhSIHbBatzWKa7xez3oSK5TKscIjCu+m/LhyQTYUbCOUdXCdCA8vokJS
         9pM88O+BaM8UkCKf+1qTRJo7jq+I9RM/+dsGb0QObqhNbgzHPKicdr6d/Qa1Gn1wCdIG
         GXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755148992; x=1755753792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LSoCl56fyWME0v8PiSkctUuL3gtGDTjl3bz0icHfT8=;
        b=P3oXnel/sx7oG0eru9kizQ15kr8+ZBnIePa2MDOBWu3iEL4roYVIAVz83yVuXqQICG
         YooOOcB25+C7Dzx+rJL7F0VZhluy9tFYfCS/QuaR9wAQYr1xvuOEYpAiXwQ1T3uyULPW
         bUALBHhHrdAo4FOSTmf1vA34J9H6rKeLTNP9l7bOiMYZng6d+SJo+MUAzYWDIcakhNU7
         9Ek7IUunur3RNuA2tEuqRd03w7lTZ8rzBxEDl2ZkeuWaScgX/+cXnRFr9cWoEv/0V9WT
         fwSkBU3lyg3T6soizUCvkcC5jLYKNIJ81OvL6b6No+st+BT5AKKwmweLLjf0yowwBUAb
         nfmw==
X-Forwarded-Encrypted: i=1; AJvYcCW0fKE9sGEvy36xMhDVmyHy5cENzeXJOCTPLY3rErpGSwYQeHVAXF1EhFQsYx/X6uDCHlevaqUhIwFWkaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDrLylF6tzxURDSt4FAJJO/jzhjpiGGw3X4Mgr70PEgu0dBVc3
	Hw8jDQP1/u4ZOTxsL5sGahM9kMjjzXf29fqiN3FJAUjh8DsgvgZ6A8d+ydfyQJH0e7P7zKG149N
	PnakVxLOJvIyqOTUNOTr4tuqmqzxA0UA=
X-Gm-Gg: ASbGnctLcRBr/k/gilyjH8BnxD4t5Zqm5GAsW3GNsjVYYsxgT5Usr1b2WTBwxer6KE6
	XZiD5wComSPYo6QRZhvpzZLynUCY3cUvC8gRSJm/Q3WNDtQPR0I7/7xDxa1yNwRctdWqZdH0rwH
	i5U643D+y2SKF40dRHAdwwyx4os6hqvegje60Y3unplxjjOD6dDi9lFsraOuqHbxpqU+zYNhnfq
	0fMtVXk7w==
X-Google-Smtp-Source: AGHT+IG3JLfHafFtVhrpyJJQVLI+yi2yjJjHCa2aqw39VKsfuinwVVPCl+kdFo32hMLPEgR8b1e3VmqLD+4/eg8BBs4=
X-Received: by 2002:a5d:5d88:0:b0:3b6:8acb:a9d2 with SMTP id
 ffacd0b85a97d-3b9edfcd141mr1235453f8f.7.1755148992352; Wed, 13 Aug 2025
 22:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812124941.69508-1-bhe@redhat.com> <CA+fCnZcAa62uXqnUwxFmDYh1xPqKBOQqOT55kU8iY_pgQg2+NA@mail.gmail.com>
 <CA+fCnZdKy-AQr+L3w=gfaw9EnFvKd0Gz4LtAZciYDP_SiWrL2A@mail.gmail.com> <aJxzehJYKez5Q1v2@MiWiFi-R3L-srv>
In-Reply-To: <aJxzehJYKez5Q1v2@MiWiFi-R3L-srv>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 14 Aug 2025 07:23:01 +0200
X-Gm-Features: Ac12FXxjjLGYLRyCaqd7TSTNKQmFZtITu9sph-q46cifbE2W4uXByRYl8-gsmGA
Message-ID: <CA+fCnZfv9sbHuRVy8G9QdbKaaeO-Vguf7b2Atc5WXEs+uJx0YQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com, 
	elver@google.com, snovitoll@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 1:14=E2=80=AFPM 'Baoquan He' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> > I'm not familiar with the internals of kdump, but would it be
> > possible/reasonable to teach kdump to ignore the KASAN shadow region?
>
> Yes, we can teach kdump to do that. Then people may hate those conditiona=
l
> check "if (is_kdump_kernel())" being added in kasan code. E.g even
> though we skip kasan_init(), we still need to check is_kdump_kernel()
> in kasan_populate_vmalloc(), right?
>
> Combined with the existing kasan_arch_is_ready(), it will make kasan code
> ugly. I planned to add kasan_enabled() via static key
> kasan_flag_enabled, then it can also easily remove kasan_arch_is_ready()
> cleanly.

What I had in mind was something different: into the kdump code, we
add a check whether the region of memory it's trying to dump is the
KASAN shadow, and make kdump not to dump this region.

Would this work? Would this help with the issue you have?

(I assume the problem is with the virtual region that is the shadow
memory, as kdump would dump all RAM either way? If not, please clarify
what how does the "heavy burden" that the shadow memory causes
manifests.)

Thank you!

