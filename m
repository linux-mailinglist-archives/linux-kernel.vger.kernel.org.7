Return-Path: <linux-kernel+bounces-814059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B04A6B54EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16EAE1C835E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48862305077;
	Fri, 12 Sep 2025 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jX8c+to4"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EE22DC787
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682380; cv=none; b=F5wogjKQf7n9nb5bjJ0NXGWE57M2z3/tVg2jXWUMzsOPg9chEkIQPdZsUUmoacZKyrXkurFKW2kjwyqrawPMyZvvISqUez/UYqGSSPqAexvq9S63JKmxJu9vqpOvjQprbt8oY55bNleoR28zydhme1DJec1hR0jkl5JcS8uawos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682380; c=relaxed/simple;
	bh=vk699rVhodheWPWoL0W1GwqpoAL90lDdPjyBrXCBHN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxN6qAxFOVsJo3hAwnWSVTnLk5PaxC6sMKLjgImCQiC4nRpG0M0SaSsOBuW4hNMGWgknteLtbdMbVh1nD578dG/pB9+bYqO71EwKi4TaoYOgWuFH/d2daq4en29rU6kHxVf2FFW9g5pDY8bCtHl+n2mHEvi3XSczeoFmrDORjos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jX8c+to4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77280e7bde3so281149b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757682378; x=1758287178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ckr1nOupG/FHOX87n/x1D8vzmImJQCNO14BvHg2YgKk=;
        b=jX8c+to4GbSMMwxtcSe7lBC58RBqz1jndQPlZrKQetfaW8moNLTac4Aj7bzKrhMSd9
         HdK0tmwqTkEaxx3MwyUQbkIJLSKJmrVZwO97QYO08oepYrbZnbZlWmjCMnWfpSN1E7Ut
         4/P9RChZsA0TIvbcqG+Mmwl0A/wOb+9SofvTmfpD7wTPhVEKcaQItpl82cKhG9HwZ/za
         QGeRucqz+Kkx2QImGe56jL7rcSrfKxNP7rrVFii19P1txLeRoQMZyyoxV7TwfcfMxzsr
         sEC2dcheJC7M63KOK/AF7xrXAUza+GAqZ+Ydi4w5bFW7dWRHksV68H69/YLw1aVVWSUM
         2xCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757682378; x=1758287178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ckr1nOupG/FHOX87n/x1D8vzmImJQCNO14BvHg2YgKk=;
        b=CwHflgXNYXN3fLdIay0A8WKXZCb5T5+0XzgKYSMfZUQY6BO6UBgj9Ywb/nbn01rSmX
         azt9IfNWLBX5qnkf/RDgH0VI2PXfA1XeztjQC0ghvbjoMREn5dZBfsYZc9VgaW6cu3zO
         CW7aojXm6Uh984X6pLIk8oX+bCbooxMwxKnN0vZjDzhfStbLWa3iPJB9CvjHpiAcWc9s
         S8xNMtmwT5u4i/B6h2OMnAsO+QXMg0vGMhKsGzH0K31TTu1ULNylvnYnsSSzl421hidh
         4Igh3eRSp/idWl8ANyVCTI4TWHSbGEKUWvOOSYUoEmpg9P95JHsHJglusQ+g4sOnaxda
         ZvLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoAqy6XMK0AGBqXG+2cnkHSeditCuhAg0fQhIOg0cvSXt4wMwMZMqVSQ5rSyz0aF7BJIfVKvToXACSWGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT1F0IVgzI7Jx61bM8ekwiym4wdublIh9H4TtxEVg4FZSVTTdu
	+V+kXtLGtj93IPglnObunvKcKJ0j8f2c7Tdwre/f2csGlXysrDo2STHmkfswT2RsDPH9L5TGlx5
	ntNh7tM3y12EF7uQSaGrhL7I0SdM4+NuupA==
X-Gm-Gg: ASbGncu16ITcLArAoLj5Bsf5GmFGrrSzpoT9Vlp/uXDMIqfWQsIMRsauxR7t64kLMoG
	KUb4YDyQH3I2yYfWrlg873P0yG7eC5A+aK4cbKs81IfhSRp83YDmH9JrQl0zFg7o6L0wP6c+9k2
	6ucr2VefSX43rbsRsR7hz5GRUwxe65dbupdnWMEFe9ESOudJnYph/pIA1LxSONkTclt3v6tPbfB
	IlbZS8cKZsO3/yjDQ==
X-Google-Smtp-Source: AGHT+IGTTvtC1IuLrcY8b4AvWUeugef+D6CmgxiovRG+v0ayfpqmLzCTs+HKBKHE/plPyLUKu92jZlW/yTLM+LNCrgY=
X-Received: by 2002:a17:90b:3b84:b0:32b:bc5c:85b2 with SMTP id
 98e67ed59e1d1-32de4e69e6emr2013081a91.2.1757682378471; Fri, 12 Sep 2025
 06:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909151146.760450-2-thorsten.blum@linux.dev>
 <CADnq5_MFDZdJg3XFFw9+tWB=_LP47PwE3HXgPK=sryOx+_0wGQ@mail.gmail.com> <FED6FFD1-2C51-45F4-BF34-76484C415C83@linux.dev>
In-Reply-To: <FED6FFD1-2C51-45F4-BF34-76484C415C83@linux.dev>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Sep 2025 09:06:07 -0400
X-Gm-Features: Ac12FXwJwCDZ_BVgzYuq56yoU1VX5uqBys40Ob0J7ZAD0NdiVqJ_P3OSul7PJJI
Message-ID: <CADnq5_NXCEFH6V_m0nvEqHU6tOhjUZ-ExSRb93Hi=7qxDAo6Vg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Replace kmalloc + copy_from_user with memdup_user
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 8:48=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Hi Alex,
>
> On 9. Sep 2025, at 17:35, Alex Deucher wrote:
> > Applied.  Thanks!
> >
> > On Tue, Sep 9, 2025 at 11:29=E2=80=AFAM Thorsten Blum <thorsten.blum@li=
nux.dev> wrote:
> >>
> >> Replace kmalloc() followed by copy_from_user() with memdup_user() to
> >> improve and simplify kfd_criu_restore_queue().
> >>
> >> No functional changes intended.
> >>
> >> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> >> ---
>
> I just learned that calling kfree() on an error pointer doesn't work, so
> this patch should probably be reverted/not applied.

Thanks for the heads up.

Alex

