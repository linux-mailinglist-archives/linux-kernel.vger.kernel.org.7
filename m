Return-Path: <linux-kernel+bounces-794257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B2AB3DF10
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E6C17D057
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899F430DD10;
	Mon,  1 Sep 2025 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dXnHmj2r"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1E62F5326
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720473; cv=none; b=RHTnovL1vgWge5Zk6DuOjm9ONbR2JvBG8ZrBzaDeGDPGy0rFqXFFe+icUcmoJfADWd33zo8xMB4+SetibMeGStKTeieb+/j50p2QowqxSzJC968obMd220YkzJ1EhzO6N7UnuG8Jlv5V+AcCvXgaw9XvlO5zTkHMrOKG25Qr4fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720473; c=relaxed/simple;
	bh=AtiBYuO38BwZPKf5+lGKWitSMYCT01XKTDpZYzEyuXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeLt4koRVQ1Mam+ZNR4Uton8US8x/7q3yX2rsS1qBgwa1UeHSii7OU3EpJD9mDE5Tfzmqn2GJLqBjM5X/B1JuoLtHG2oIOwMx5HgBPXObIWb7zlU0g29OSH31JQwB50XGcg0qTtWYVEr0lU7bE6VNl/V/lB69bHpT3zR1FpT4fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dXnHmj2r; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b042cc3953cso89878766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756720470; x=1757325270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtiBYuO38BwZPKf5+lGKWitSMYCT01XKTDpZYzEyuXg=;
        b=dXnHmj2ruQ/xkdIt6xvN8ZOFV5vn3KttOEy0Zai/O9gwODsr9qAFzB8bJoTIraTcka
         gNmKu6bPouzRNelDM8eHQ4oT/ud4RXXND05tImUIW+1JIFKM36WZooAYG9JA0LqNix99
         5v7R5bgOeQQmOnN+5jWxYqdPbY3rj4H4JfhHxpMMA+GPdrj8DMmoUGEaKVq36VQP7STE
         9727yO6DUgz/oxpQuzSPa0soOYfjFbBf6LzZ2MIu3x6W7cFujKtoW/4YV20pYabI6h4K
         u8f2P9sLbX02tkQDV2WUMay9z4Va6M8FFsQvRnQ/07hjQaHlDIY7OBxYlnsxFLEYAFzp
         GsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756720470; x=1757325270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtiBYuO38BwZPKf5+lGKWitSMYCT01XKTDpZYzEyuXg=;
        b=mhsMojjBtiHNjx0dnZPlHIgHqTJ6b6ukb8PexniLbm3/0EocubcYqJEbYLp+6HKHkJ
         gzI/PAyeKsw/wKDvpE84n4bBCCo6vGa32ZdvadqAcqh+zd+Tw8uxpRZQ/E+34LxEUf48
         S+RMmmbThTUWJIfetecIqGH7n/PoWtt4nv8e1OmaioxBr19A1XQA+khwMIqrmdHd/ns1
         /GR1DhKmew2ttFttMncr+bMJYXXFyl8Kig7uAg2+I0hLzllCjQMNjmfzWaPRVFQcf8RL
         8HGXCZEtES9SyrWX7ohBU7opZdZUjHF6udj16/RXhktddPJIEIRlrz7mCVt6wUN/zRUH
         pHGA==
X-Forwarded-Encrypted: i=1; AJvYcCUdzCjT1/eAABQBa5fUOUXsPOPUDCx451/x0cAmaxohnTelujJjjSfUwXYLfx3/3MLvBt9wPhPJO+vYy6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk4Me+yBjiT75OJYrhDZjseKajsrReB69r6S5uc8PEgCVtPRUC
	37FNWcKuZow8RDkk/O7ICx1VL1hZx09tr3BkcXWbxlxvkw/6WqjNN+Bt+nHwN+wloW2tozP2mYg
	y91oe7bs1o/0Hgov5Cl3b4KbEgn0RoXtiCWBPigMX2w==
X-Gm-Gg: ASbGncsAQWhfhx07YvGr2mN5nLzsoNVbwcg44yuI+kc/ekTHdSu2nZM4ujsQY+XCQ0y
	LTiGCbXVZz48cbLXthQddgGBC8gLxlwN4diL98Yis5fPDVhVn8oUeUsmlt9AJSTUAAU5u4eQfDF
	HA0GSWQGUgcqqN8rMPfw18xDZoADJmdA0cWHThYe28ehsuvQPEGK3GwowkuhkguOlPMwCno8ube
	RpNkswNjKLoPocS/Aeg4Qim3o1Zqy4hXRo=
X-Google-Smtp-Source: AGHT+IG926akpOzWZcf5N3mV7elDZw28XggHb1wmpA4WdWitXiObkp2qNMaOn7Rtqs/aofUinFciyRkhDtIhzXPOX5o=
X-Received: by 2002:a17:906:c11:b0:b04:f8d:bd7f with SMTP id
 a640c23a62f3a-b040f8dbf99mr446115966b.65.1756720469662; Mon, 01 Sep 2025
 02:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901091916.3002082-1-max.kellermann@ionos.com> <f065d6ae-c7a7-4b43-9a7d-47b35adf944e@lucifer.local>
In-Reply-To: <f065d6ae-c7a7-4b43-9a7d-47b35adf944e@lucifer.local>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 11:54:18 +0200
X-Gm-Features: Ac12FXw_rNjhcoFzQKi2bXoe_2WtlXZb2wNk3G9XO3JBfL8ul9lEEea3cb4eO1Y
Message-ID: <CAKPOu+9smVnEyiRo=gibtpq7opF80s5XiX=B8+fxEBV7v3-Gyw@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] mm: establish const-correctness for pointer parameters
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com, 
	yuanchu@google.com, willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com, 
	linux@armlinux.org.uk, James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, 
	gor@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, 
	davem@davemloft.net, andreas@gaisler.com, dave.hansen@linux.intel.com, 
	luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, x86@kernel.org, hpa@zytor.com, chris@zankel.net, 
	jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	weixugc@google.com, baolin.wang@linux.alibaba.com, rientjes@google.com, 
	shakeel.butt@linux.dev, thuth@redhat.com, broonie@kernel.org, 
	osalvador@suse.de, jfalempe@redhat.com, mpe@ellerman.id.au, 
	nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 11:44=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> You are purposefully engaging in malicious compliance here, this isn't ho=
w
> things work.

This accusation of yours is NOT:
- Using welcoming and inclusive language
- Being respectful of differing viewpoints and experiences
- Showing empathy towards other community members

This is also not constructive criticism. It's just a personal attack.

(I'm also still waiting for your reply to
https://lore.kernel.org/lkml/CAKPOu+8esz_C=3D-m1+-Uip3ynbLm1geutJc7ip56mNJT=
Opm0BPA@mail.gmail.com/
)

