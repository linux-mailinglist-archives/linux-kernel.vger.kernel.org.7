Return-Path: <linux-kernel+bounces-792751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77225B3C87E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 08:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D7B1C22C06
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 06:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E872417E0;
	Sat, 30 Aug 2025 06:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="eyjjbucl"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB34A2869E
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 06:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756535183; cv=none; b=SafUYU98vOszpuw8m7Sboy3pv4Q1OVqVoCuHg4fYX4eVB8TrjlCttNRsYkldi/nFM8f1dYui2o0G+NblWEm8Gw7gSRfA+PleHpfIY9rzMAdiPW5zO3XTQIvXe0Wr4/48DB0Lqt4I1K+v2YhcE9VM267FCGIwmhhHxxl1RBCq938=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756535183; c=relaxed/simple;
	bh=mgXyUB6vLmyGEIM/HvW/8ZTwZD3HAIcm1Xp9HqVBKsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umJj3Ccz1NXIZGsFiErZ/u/9FdLmm5sCZ0fr/ngvBe0iN3xUPr+pOBoaaqkJt+fPKc0xAhqC/G1/+DCKHqISpkN19vZpXvAELWTPyXdldsqRqwTN/XbeLKihyiesuwu0PsGYdOb3Tzezu5KC18KxPe8JZa81VQdEQwSsPEggpbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=eyjjbucl; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb731caaaso427688066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 23:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756535179; x=1757139979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgXyUB6vLmyGEIM/HvW/8ZTwZD3HAIcm1Xp9HqVBKsQ=;
        b=eyjjbuclKw+hl+pxWvBXo365o+tdRR15pX+twchEnZHR4/3XtskNd5P1yVisdr7FZV
         0x4SvTWlvwOQOdYervbVeGtKl/wUO7dQjwSyKbzgpyP63ahEymaB0k2ijnh2ft3pIZHS
         RFNZfNdAyHG51kp609pzjIeT/i5O7S8xhynv6+2BlMFP1lwaREvMhhyDadQHSP2h+sBs
         c/p+jiEg+t2Xh8tNqNTsZjPVCJIkrgc54fYE6l3kV11vxSIipChGNsrVIE+J3XFcv0Mt
         P5ZI9pW5yak2X7m5D9yr/7wkYlreTTmZG8Kaomwz5ISYj3sv4HorQShKQvhGB2GtXrq8
         s6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756535179; x=1757139979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgXyUB6vLmyGEIM/HvW/8ZTwZD3HAIcm1Xp9HqVBKsQ=;
        b=bXSejyzNLdZJspmLjRL/3+we6lhdqS2ONQ9jrlDVTgdBK1J/z53v7u2MqWwqkknRdl
         sgvHCh4+KJ0MXR35rnTcHud0HKAk1EeeAjJEivz+YFpZZcproHeeYYxFhbdFmm9zM6bB
         717Q7CbptKlbTI9zaiDQAQcPEEscjF86ZDDDml8+16PmuMO5AH7R2niBbW0GaAfzP6ft
         ZrJ9jEU2Ax9vUz17tTJyR4CZpRUwDs0vCdoLLxFcyh3g2dMbf1BXYyjyCUt3WOCKWiuk
         jOfMiG3+3DCU12Ty4MYjaIlw1dqdTKY73m0jdGO+XhBvWprFDCUfc/j6r4OsAQcCPBj3
         03fw==
X-Forwarded-Encrypted: i=1; AJvYcCXN3Cyq0gG9WsKLvokicsETozPxmlg0WfzcfVx+J/Jp9P4MjxwyzfQS7wZCNTIgvjcFDfFGtXr/hnbA4Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBUFvlw0jhriWQEvnNsd00LJcGYW+u4X0nfn8GM7ruLNOfD5o5
	vHAUt8J9j2aTg+1F33EfIuHgiihE3/e7xv6vBjc0Ibxnr0ipZJNwCb3PE6gcAanQmoErWQu6yVb
	+H62DU852LIl2zFDhkcVnzDPYxvuyBFxEO5a9aEMrQg==
X-Gm-Gg: ASbGncs0V+IbUhiz2jRjLF5g91vgLQRExbd0flGOUOiM+bAiyH1i4xukM/Dsc1t9n0e
	ppQtRoXQV3i9xuCZrHjIkt2OwJUyS2UI5pPBkJ7M6+QlgVYta/jSMYwwendG/dAwh0yk3+6+ggW
	9l9EHoEMC+JsuCA+Wxbr8m3LXLLuck5DppnIeGjJbwEB6+nJyRndQpeRuNxUT8Hh1KvtNhXn9vx
	6cagfp6i3dbGFrqgVai2u7ONqXIfMxnApGaHSLzIp7btw==
X-Google-Smtp-Source: AGHT+IHCvHn9uk7hSHPOZ2nzeLKH9MIFtgrASONd9bINKE+pcP/w+esbaAmtMOpllURppKjJONJErHArmMQvP7OpUoU=
X-Received: by 2002:a17:907:9411:b0:afe:c1e4:5554 with SMTP id
 a640c23a62f3a-b01d9730679mr107602366b.38.1756535179041; Fri, 29 Aug 2025
 23:26:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829183159.2223948-1-max.kellermann@ionos.com>
 <20250829183159.2223948-6-max.kellermann@ionos.com> <aLIxs1cFhneGU5D9@fedora>
In-Reply-To: <aLIxs1cFhneGU5D9@fedora>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Sat, 30 Aug 2025 08:26:07 +0200
X-Gm-Features: Ac12FXytabmAexw3b0aFU-olWuI7_QFOvp6zOtmDGZ1G5mwKvBMIUZZnCVOTVT8
Message-ID: <CAKPOu+9MBokh6z2o8=GKwTeU61Ce8Pbs7zjTSxo9=d+vKCYZWw@mail.gmail.com>
Subject: Re: [PATCH 05/12] mm/oom_kill: add `const` to pointer parameter
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com, 
	yuanchu@google.com, willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 1:03=E2=80=AFAM Vishal Moola (Oracle)
<vishal.moola@gmail.com> wrote:
> > -extern bool process_shares_mm(struct task_struct *p, struct mm_struct =
*mm);
> > +extern bool process_shares_mm(struct task_struct *p, const struct mm_s=
truct *mm);
>
> Nowadays we're dropping the extern keyword.

I can do that - is it acceptable to do that in the same patch?

> Also, Is there any reason you didn't also make the task_struct pointer co=
nst?

I wasn't sure whether for_each_thread() is const-safe. I think I
looked at the wrong definition; for_each_thread() looks safe, only
for_other_threads() is not because it uses next_thread() which takes a
non-const pointer. I'll amend the patch.

