Return-Path: <linux-kernel+bounces-788360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ACDB38356
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B4C3BEA4C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5A5303CAE;
	Wed, 27 Aug 2025 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Vmi2qfjY"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D8428F1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756300020; cv=none; b=rzuaISHkpnTEtg9CgRYiF5s/XDWn7WsTSGvBj3TT7zRu8AS5m9iMxjnEKPcmpcwoQ8hA2VJlXV+G/35KDlpKoREITWz8jmW8PSMaf2l5j/hy4cF9R4FP7wB1TdRi8EivzA+77AZD1jmJnNNgzoFbv+3J/wvGpluG31hlKQup8JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756300020; c=relaxed/simple;
	bh=gvREMMUGX4DDLPmaa03a7mYhWcIU01kBarCsM6l7Nu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPa5RfgX8rGO6G6kWtDFEEr9oSJamQj9G67uKPRZDTj23wIKJFqwhhf3w6gTZe9LRmm2Lb+EH2ePLAUJIdkwuCvs6/9aisU8CfbR2adT9w4nVvEstlycIwaiGqXlO8r9W75lgj5EKy6rkK7iZqMJToBluCkKTTcEQe1BAB399g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Vmi2qfjY; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7a3a085so1079346366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756300016; x=1756904816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvREMMUGX4DDLPmaa03a7mYhWcIU01kBarCsM6l7Nu4=;
        b=Vmi2qfjYhpZJ/Mm+AVUDh/nzdXT+frnbsQcW3K30OJ8yJDVL3mGghID5Or/NU/HSIj
         h0yTz5273n6YUldXxe/ZmgL+khWm39UIDKJBjVQED/6yR/d8LiJoe0h7dkjSFZ0mxFZ5
         G8fUGxZDSmifB/kYOomEcWxX9hqUhK81moWPZL0CTQDk1Q+DupRTlFikdepe3Qs6hE6A
         KWKxElqnN/0bFyld7fIDExrpTGanXey86iC5YH8SNHweIQ9vdOaYljEckwDpzdSaTdx4
         Gd6Yd7elICV2Ps8154MRDr9nE+eN89UsRcBb1F8dsx7QlyXKK5yVd0mfLJNZCOKleB+s
         iY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756300016; x=1756904816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvREMMUGX4DDLPmaa03a7mYhWcIU01kBarCsM6l7Nu4=;
        b=B7Qtt/7dkpVKZ0Wz/WtQhplPeRFiOgprttrN7sf326xm5VQzmZiKXFW1TU2v100Cw3
         NRoriw7dK2Dsf7rC9pO1e7F20YeciDrwNt3uk41nIy/5DV9VSYMF/KJQ+8TM06GWG+HN
         YpkCFN5ljkyKM7He/eiSLexi+ibQ0ZFJ5ZIQ4Ixd8tboWtU6Xd/+E2mD7ihvCsns4sqU
         eX5zNC80hiwlOq3A3UOGiCswJ0NA/o7cP0o3mIKHGRsQPrmS4PXEWoH3C11b4QnHgu8W
         99l7Jgr0MWZAgrdlCqxcVUQavX31E2ES+Xq9k790iKO90hfzODyGDWHMlgPHSMfgA+Rv
         STSg==
X-Forwarded-Encrypted: i=1; AJvYcCWjSEuBcBJTVbFKywleXpBern+raVOvPm9v4WJFb5zGPMUqOphZEXF9TsiIg2dfKNF+xMQWTJ5H5RFkr8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwlFiiMnmwl/Evw1SZZOyJfqg6Aul/3+htD6oaD0ojteFezQfd
	yquvBh0JmBmg2pDwrbnzr6smkssa8LhDCRSAEqT375gfERb7ABip/mmwLeInwxinwlvGlc0fT9L
	jva/63u97VLG/l03hZC4wFzRWHRWD3ybb27Gq0673Kg==
X-Gm-Gg: ASbGncuSv4fEp7QtJtf3bC+aIYd+JsUClPG4/UIk/Oh5inZXOArNHhf6MvW/6QQyKri
	UOtQdULjpHGFl0kR2WNavS8c98hOoDlgF4aQv9+T8AAMCFlozJo6oxwHb+qx12XgkChWHBqAR5Z
	zjH01K0EJ1j6qXAJcdWWPfL1uqYUKMnl2h+r9X0jjM2Fikr8s8EQPaC7peZcT26iFtNXP/4iPbx
	sQbeAF7dAFk1fZrp+dqFLCMT98w5yN6jq4=
X-Google-Smtp-Source: AGHT+IGcS2N5xEv+uacw/lgkOH8CRCWcPBIObSa2NzqVcxO43YGBpA+T+PSuO6/+E8wHrtpzJhJ0Nnk1Cw52ryvCxD4=
X-Received: by 2002:a17:906:ca48:b0:afe:8d39:41f8 with SMTP id
 a640c23a62f3a-afe8d3944d2mr748684266b.40.1756300016515; Wed, 27 Aug 2025
 06:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826231626.218675-1-max.kellermann@ionos.com>
 <20250826185515.7fbe1821713195b170ac1b31@linux-foundation.org>
 <CAKPOu+9wz9g0VuYDPiNDYdaGG-gdK86h1gGSCmVPsC2a5f-GPA@mail.gmail.com>
 <e5783c3d-7eeb-41d9-9fe7-730155f9bf17@redhat.com> <CAKPOu+_8_gfko=Sh-YKpbgcMy0aJB=m9yrC5JJKEZm=yeYPOgA@mail.gmail.com>
 <11a5d391-3a13-4376-98f1-34b529d3c583@redhat.com>
In-Reply-To: <11a5d391-3a13-4376-98f1-34b529d3c583@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 27 Aug 2025 15:06:43 +0200
X-Gm-Features: Ac12FXwwckjBhLQ7o_PMRpGnjCBD6ur9uuZ01YuxV6JXk5dizy4yroOgpwkCCEU
Message-ID: <CAKPOu+9j5+w6ydvygdWnryZM24AFPSVJB_21VH8Odi_xdrNksg@mail.gmail.com>
Subject: Re: [PATCH 1/2] huge_mm.h: is_huge_zero_folio(NULL) should return false
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, lorenzo.stoakes@oracle.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com, 
	bhe@redhat.com, chrisl@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 1:56=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
> > This patch isn't about the function parameter but about the global
> > variable being NULL.
> > (Don't mix up with my other patch.)
>
> Huh?

Oh, I see the misunderstanding. You are right here, yes my patch is
indeed about passing NULL to is_huge_zero_folio(). My previous reply
was confusing.

But you were replying to a sub-thread by Andrew who questioned whether
a call is_huge_zero_folio() is legal at all before the huge zero folio
has been created.
The question I asked Andrew, which you replied to, was not about
passing NULL to is_huge_zero_folio(), but about whether the call to
is_huge_zero_folio() is legal at all, no matter which parameter value.

I agree with you that is_huge_zero_folio(NULL) should not be legal and
makes no sense. It's a bug somewhere in the caller.
But I saw that the current implementation effectively (randomly) hides
a bug in another part of the kernel (=3D Ceph), one that I'd rather like
to be visible (and get fixed). And that is the point of my patch, and
is the reason why I chose to have the additional debug-only code
inside an #ifdef - I don't want normal users to pay the price for a
debugging feature, no matter how small the price.

David, what is your opinion here?

- leave it as it is; is_huge_zero_folio(NULL) may randomly return true
or false (=3D reject this patch)
- add the huge_zero_folio=3D=3DNULL check, but guarded with #ifdef DEBUG
(=3D this patch)
- add the huge_zero_folio=3D=3DNULL check unconditionally (suggested by Zi =
Yan)

And do you agree with Andrew that calling is_huge_zero_folio() should
only be legal if huge_zero_folio!=3DNULL?

Max

