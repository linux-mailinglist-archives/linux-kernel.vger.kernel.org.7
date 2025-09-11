Return-Path: <linux-kernel+bounces-811940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4B2B53070
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57D81C201D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DC031A045;
	Thu, 11 Sep 2025 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwFaA+vg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6EA31986D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590216; cv=none; b=pCJnlARqIOv1UbQAlOpDu1joV5ciYFRltBaTSxk0vip5altUnfMlvWVFWHliia1R/QRZj+rKeu/11zgCc3w2NInomwPbJQvporTaXi5ZSwcnThcOI4+TI7+YsNBjJP29pRE5iCIc2SzUOC9RaAXuVK+ZqrWAeAunccXSbNYXtb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590216; c=relaxed/simple;
	bh=NUmiUFiqfUg6KgSkyEEB4x1tZCu5PrZcN4T6cI6Oiyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QlPsw4F875DWCr1PhIdrJSaelA85E93a+vf1J5KJPJIdgnImVxa2rbCFGqtlXVey/ckjxWuM0bFB5D9f3lgEb/2QukGHa6cmXRM3lPIrsh/Ho0z8rUp8cWF600n7IQzS8gplfT8UnssGqx9p3c8YPANtm/VGNxgnqwV0DekTHNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwFaA+vg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757590213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUmiUFiqfUg6KgSkyEEB4x1tZCu5PrZcN4T6cI6Oiyc=;
	b=fwFaA+vgpU9xZuo+01BlbtZmEGTeuCaa94JaZa3Gx9OLiYE/YS2JPaLHZHza22nsva2K0s
	mLjtJp56e4hVba1sLIAOAjQ1ZunL8uDOckr0ZI9aPZNahybscqNVOchUP28kv5tMeaMZwx
	zUaE6l5StAby89WD5iP0jR8z5sCtjwY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-Lue94GcuMsSV0dLuXUooBg-1; Thu, 11 Sep 2025 07:30:12 -0400
X-MC-Unique: Lue94GcuMsSV0dLuXUooBg-1
X-Mimecast-MFC-AGG-ID: Lue94GcuMsSV0dLuXUooBg_1757590211
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-62ec5c6a08aso475141a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757590211; x=1758195011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUmiUFiqfUg6KgSkyEEB4x1tZCu5PrZcN4T6cI6Oiyc=;
        b=UmymOymbxuBjRB786CCMgZMYsDEa0ohv8qEeUad8zhuKaKnso84L3Q14993lP9UCPQ
         rwjbNmwnjQZsnTEdJ3tGLi+TinTnKOVLfZfYnNqSm8jCZfOCTdACmHpel0kkKmBmCkpk
         trCpe/+ztD+EcXnJeCTtdFZ5jBRiWjZdRhSBrQ58RF593QYNoV99piKEGKzY2JFp3y/R
         wVp60FvUd6Fh6ZNh8vLWoprQPW+gG2nuBzVAliWfySTGoAb+JFHTtUVR0tnUByFz/G/Y
         tCBZLJvNZcMay85Yk4wBmaIiZWE5U8Q+ftQXjmQ7C99+iI6qkZL7q3kVIyp607AEolOa
         uH0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRuuC9++HRAD90ZRsP2o2+2lF0i0mbW+MrbwmmAKOffD5NqTkmBz6nYomouscOVWZ+ehL56qF5/pIwAIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze18NvmjuhKv707v9wfqmoMNDr4xLzEUhVvTN9K9tzoZgJirA3
	tuxtgXWusejCwv+TeQTQ8NUi2bFFH3eN19tTx39poGsLikAH2onO1cuz1vHdLXqz8v8sZOXxRt/
	ucENgn6wXO79guvJjxejZhqRJyn6yUbKSrdHVWFl/lK5s0HdP5nLNtZtsQAU0t808C/AHRe9qcN
	T2WXntk6ZUs3kpfsdVJIEyzr82tXEulypZQsnPIeIVREyt7Ayc
X-Gm-Gg: ASbGncuQiJKkKmhr7nQjqiK/uJusKKthFvdE0IOnG77uquW8v0kxBnB8O41Qj696qXn
	bSo2lCyiB5w78S1WJaYLRH0H+Fc/2tf4ip/3Lue2qpp2o6Nt5hJZ8BTDxvLAu3mgsXfWVRMWCxm
	MmxJPbisr5q3xEW5UiwdY=
X-Received: by 2002:a17:906:7308:b0:b04:ae68:afdf with SMTP id a640c23a62f3a-b04b14afdaamr1804647066b.28.1757590210877;
        Thu, 11 Sep 2025 04:30:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnABc+KFrFpfTUERSeqlhV9AtywAZEQJi2YB1sLvQMPoBwEtOIxY8SSmmHUt7hjQ06toD5GKHKNh8zL+UX7Lk=
X-Received: by 2002:a17:906:7308:b0:b04:ae68:afdf with SMTP id
 a640c23a62f3a-b04b14afdaamr1804645166b.28.1757590210487; Thu, 11 Sep 2025
 04:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757034919.git.ipravdin.official@gmail.com> <a093065d78b7a4377c084fb4dc56942aedc5f6f2.1757034919.git.ipravdin.official@gmail.com>
In-Reply-To: <a093065d78b7a4377c084fb4dc56942aedc5f6f2.1757034919.git.ipravdin.official@gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 11 Sep 2025 13:29:59 +0200
X-Gm-Features: Ac12FXzz8um6-S3OMseB0U311Zcv84vqKdIlRtKjeumvmaIu22hPwQtw_OK_DKE
Message-ID: <CAP4=nvTZN6G+KAovidAZbYNt8Ubh64bfkKVDUMDCJVwPO+=DNQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] rtla: fix -C/--cgroup interface
To: Ivan Pravdin <ipravdin.official@gmail.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 8. 9. 2025 v 4:06 odes=C3=ADlatel Ivan Pravdin
<ipravdin.official@gmail.com> napsal:
>
> Refactor identical logic between -t/--trace and -C/--cgroup into a
> common function.
>
> Change documentation to reflect this user interface change.
>

Looks good to me, thank you for implementing the refactoring, now that
the logic is shared.

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas


