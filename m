Return-Path: <linux-kernel+bounces-721841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83610AFCE81
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADDF37A4ED0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C892DAFC1;
	Tue,  8 Jul 2025 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dddBhdbu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E661526563B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987073; cv=none; b=XQ9FgOu5Wd5FT14wq9uMqstJPgP3CwvK4OBVXcuFNQ4NdKDBRIsSej0+H+DbMphb5e4JltztA5L4VF+MAGSdQSfXJ9QmmIaFu6AF9ttUrXnUjEhs7jeFIvUmLVp5KbURwuSBUKaKIpK28o3KhYKVLYjF3BtM/yfSUmw/DCTuEgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987073; c=relaxed/simple;
	bh=pDH2XFHl/iv3yIYHUvYceoo2XrEbUJyxj+Z370eNWa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxbPhWa2TyfD584+XwC3FpygnkV5wzWEtDAL3mp1KFgCxw8hFmuuAPxRlRmGhXrgNq3JR+PgUwTU1ADYUgrn3iqOKSpA+H9b0Hev5VEge1zEeNXGR/X+2q2uPjTVznBdl65Bt2fNuPGWUK5KTozAO4s64ksd1uZU98u9W6bSeJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dddBhdbu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751987071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tl43DWhHwsKq17d5JHNS8cD2rQiVgiSwSkjGnb/5syA=;
	b=dddBhdbuTZ3tA14rRW0EMyCW6D3HR98cnCvZiRfodl/bWc76W/z4HbSlBHPe25D9TKZiNO
	g0zqDxAX7862TEnew+2PFRtOwsZBmiSGD5Z3jD0P/ao/Qmf3Wv36VjFllapgwRKSMHodfX
	Umh+TXSNn5w7OaUqMq5K24surMSz4TI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-VrINqQlHPd2kDqyAFy-zAQ-1; Tue, 08 Jul 2025 11:04:29 -0400
X-MC-Unique: VrINqQlHPd2kDqyAFy-zAQ-1
X-Mimecast-MFC-AGG-ID: VrINqQlHPd2kDqyAFy-zAQ_1751987068
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-748cf01de06so6973747b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 08:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751987068; x=1752591868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tl43DWhHwsKq17d5JHNS8cD2rQiVgiSwSkjGnb/5syA=;
        b=XxHNVm9TDkmNSk6MHo7scKiXMN74rBimPbLUv/I17z/IFFs78sf39AVcCETD6JeH/e
         NXZrezCf5wDh2Nhiyyu82v97e+c4Q9mwrtequd5+eF400+uKHni37WBvdDb+bYJds3Hn
         KMsLZRgDXQ+v+N7wqaAeC/aFSCgR+TxN0KyCmxys8LjrDOxpSaoX47ZUuObMDy3nINWs
         Car5CFxCM2IjLglAHiP0ibKehSpSbhpcsxyC1G9g+BJGePn6W98aKCNT4K33xxxmjFPG
         b3d5sXzNyQvjXoIi9cI1jEySFiBt/nmAwIBoWLFxbC2y6YwMPPMOzAQ3g428lI25JvRh
         A0qA==
X-Forwarded-Encrypted: i=1; AJvYcCWhRPOvcvfOltZUE1PNM8MAnsv0wE+JMkPN770zG0QNzGo12bDy/0cz/FAF2nqdPU1ePPYNkcI/9+661fE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW0GmiKOj3+aLDAdQaFaZxnAdoH0+pJ4U3w0zeFokE9u46HS82
	HYQNvHwk4TEAA9LmA/na65x4beoyHEy0UhM1kJITQF3OqK6cN3WL8OBj6eEucOO6rpVgYu5QaIy
	axLF0MOCEiZWnRrGRXZkj4jc/3J9dbHbEp+yDUcbXscnUlhQlgeORvUhmjWRVKUJE8PnbMcdwZ6
	m20+gbwO+CwZVVZCZ6uX1iCYy0mUEExXkJLL1aTHIA
X-Gm-Gg: ASbGnctX3C429ouSvYbts4/2aMm0SyZL3VRsZbiPQT8R3W7veihIltBmpHCLw2+3sR7
	pN7mtJE2Vdk3HFVdexLU/QgsYZEPl8pvMIwsa7YK9CMYdFBH30Nk8KpZ/6rNagbuYJLGmsU3CN0
	3jZg==
X-Received: by 2002:a05:6a00:1ac7:b0:736:3d7c:236c with SMTP id d2e1a72fcca58-74ce6669a73mr22213602b3a.14.1751987068066;
        Tue, 08 Jul 2025 08:04:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2ejvW3YmvccpHRprgPMxap6Mer3Z8N0cp8nCP+Ldw5z9vAhxZz6fSn4zsrkaqz4eR37sKS5kCEKtiNL+HIT4=
X-Received: by 2002:a05:6a00:1ac7:b0:736:3d7c:236c with SMTP id
 d2e1a72fcca58-74ce6669a73mr22213546b3a.14.1751987067575; Tue, 08 Jul 2025
 08:04:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626224336.867412-1-seanjc@google.com>
In-Reply-To: <20250626224336.867412-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 8 Jul 2025 17:04:07 +0200
X-Gm-Features: Ac12FXyJCla8Zq0EueybAUCeQZdUT7OiUHbkPJGhCeECDpLsEK99IMU2xCp9p5Q
Message-ID: <CABgObfbpf58Nhc75TfmFCK+jLbTZ_DkuEZCHFjDAwKabieFugg@mail.gmail.com>
Subject: Re: [kvm-unit-tests GIT PULL] x86: Fixes, cleanups, and new testcases
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 12:43=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>  - Play nice with QEMU builds that disable VNX support.

This mysterious VNX caught my attention. :)

This could be fixed in QEMU to accept "-vnc none", or could be changed
to "-display none" (-display being the newer and nicer option that
sums up -vnc, -sdl, -gtk and so on).

I'll send the patch and have pushed the rest in the meanwhile.

Paolo


