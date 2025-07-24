Return-Path: <linux-kernel+bounces-743987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DF4B1068E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39095AE4CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DA823E347;
	Thu, 24 Jul 2025 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ2M4x4r"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D9C23E25A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349522; cv=none; b=ctYGD0V9qaXZkb5CdvGeow5RitKb3+htUffOjVQS0OYhVIGgIzYLn6c3JUBTkhOj2tsVtbIw7cnBIrASorVIgNTbGuFowsYU0JED8swnCuIsaPHNS9x8NFycrRutBfNUXYMa12cn5/m83Lk5auqKi6jWj2o1AmI7gMbQqTe/9B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349522; c=relaxed/simple;
	bh=he6tpUSNHAGrzwZLLtdLElJhZxZKcPpVbnsfG1MF75k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esrLiZsgrb5vNa05oZlE6SKIxxDGZNSFLmyn1dgYl7qmMerVolMK3h6IiJqYGA3krmAZS2LdYJiXS02VBFqsUXe7IAbgpVtDqKpTgD0MgablLuTncjl5Hw5S9/ErM5OcQb2Ak8slOMGE0lOaMgXScLtK5FIR8MObvIx0RYeXlEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQ2M4x4r; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4e80ff08dd6so516526137.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753349520; x=1753954320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=he6tpUSNHAGrzwZLLtdLElJhZxZKcPpVbnsfG1MF75k=;
        b=aQ2M4x4r7myVVI280WVLiPw07q9D66ND2GV8l1f+cXMEMZeeWS0sXfRbay8efMdvtO
         yTCQrGXihyJ4hcFZtYkez9uRiLm3d1ZlR7w7LulEGjuuYMfqraCvshGIJDSv/tzHlCrC
         tUScA+tMzU292kTX5OEKKW0fJ1DCpYmjhtj2V8fQsJ25c3L3vpuduICImjPb++waigu+
         E/ZshzTB+KTzXQPy3fMHAoXS8Aik3Tq8ps6qdJPnNPzx3ouchQOB5/cXlt6WnBu36QZ0
         MsXjnpE9CaBB0TQLsvjlUHJWSAW3JLmYrG0Z9NlIJWY2cdCcyEscBNKMt8r0wffykswQ
         hHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753349520; x=1753954320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=he6tpUSNHAGrzwZLLtdLElJhZxZKcPpVbnsfG1MF75k=;
        b=hhPrc96WQuw0GWtXq2sETtGHT2+tjLm4ElOoRXdOPftDsdKcc1mM12i2Fvb6ysUfeX
         YX/+ZFdlJdSTb4levyUsV9vXCem5CL4PfkSvpHcV7hNmilr37ogMQKLzdE6f4+W2bHL1
         csAqv6eCC6vu2Vicmr2N88OoF1a90ocyCKyuKq/zcKwe/DL5YUhkwbFvPJhScEQq97gp
         eQD7IkKK+0koKruRjBTuIRiBH2JDCJkr7MsDy4UKT4IzApmVeuAB+sgg6dr3xfa4vSYt
         UrNSAG//o66JO94RXP5VdGtuuqQZ0DwuPf8r6/z0V99yHFuMSuyYJcGc0RcD4GypGrbC
         RwgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm2C2EeIBv+T3zEb0Qi709sY4ymWfp3BV5UGY+dpn4aWA69bj76YN7lIxE/RXr4oASo5iBwYQO/Njs9Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB4yTGDIqty45fimsyk2uo96C9wNSC2w1ywuwaSbS1JPDYYp3r
	13RrsgkyoeVyWDMmkVMcBHUMhxbJAEyCS9R2vkdvV9g3mbLrRyr6t9d3xpwcv6PknNMzSqfDvL7
	BqNtS07cEBADa0zBBlADbaZwk7hKxmmw=
X-Gm-Gg: ASbGncu3TvDRDk+dYPqfP0wDOMiimmTBNyx2z2JM4Zw3xQQccfF1ngIZ2uFVj1JCfNn
	in9ZCGB2Fw3mF9f+iYp8oEY1EHszwVz7xfPyHvJCeu3nBbgFAcMqDZGPhhdizFgU59GZM1xYwDy
	Qts3Tr52/zKnQGmRKq/qcRYDZ1oeH9oDB01oDiptoLbh0p+bG4TZ37VgrGNoY4YZaLEvqeNTTvw
	95tOfuRqF2GTvzmdw==
X-Google-Smtp-Source: AGHT+IERDcIbZblal/0JJXmwYHJNCS0XtjeF6wbnGcqRuyq4UjTwq33fQQpDdIpxKMFoLLbh2hYEhXu2cpFlMGZqD7c=
X-Received: by 2002:a05:6102:458a:b0:4df:9281:5ec3 with SMTP id
 ada2fe7eead31-4fa2eafe103mr361567137.2.1753349520018; Thu, 24 Jul 2025
 02:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724052301.23844-1-dev.jain@arm.com> <20250724052301.23844-2-dev.jain@arm.com>
In-Reply-To: <20250724052301.23844-2-dev.jain@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 24 Jul 2025 17:31:43 +0800
X-Gm-Features: Ac12FXz_gl7Q_9U3tXMQSMYcmWWpGLT-2j1IcNdZG7435iNjCJnxsvZokZWlwAM
Message-ID: <CAGsJ_4y3zXD1i+g2bt0s1v0h-Vap-pXzOO=bQNf3=68-dY8h3Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] mm: add get_and_clear_ptes() and clear_ptes()
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 1:23=E2=80=AFPM Dev Jain <dev.jain@arm.com> wrote:
>
> From: David Hildenbrand <david@redhat.com>
>
> Let's add variants to be used where "full" does not apply -- which will
> be the majority of cases in the future. "full" really only applies if
> we are about to tear down a full MM.
>
> Use get_and_clear_ptes() in existing code, clear_ptes() users will
> be added next.
>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Reviewed-by: Barry Song <baohua@kernel.org>

Thanks
Barry

