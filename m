Return-Path: <linux-kernel+bounces-758424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A9BB1CEF5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 00:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8743A7AEC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7AB233707;
	Wed,  6 Aug 2025 22:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KqKCtHbP"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FA620E6E2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 22:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517976; cv=none; b=LuJpmtvyS4h1P/P89jI3JXIrMN4Mk0EkUDnuaewfYE4u/TGPou3pU/r9llBddl2gL4qERZgOPTGp8KU9JlMW/r9FJRYGoorPf14IkJaqQpwAfeHMg/pBFXaZi1NlHk4pyHUA1R3UVCUBh6kZdt/hqNpl9TwEu8INju5iQOSxoaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517976; c=relaxed/simple;
	bh=AZb3s71JJh33LT/OJ6WTaBPpWMRvxVzhiysQxR+t4Yo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=VvFa1McGUdl/TsaGuz1DAE4hHFR8ok5UlZ4HRJgxUNLwNzYu6wP60jULDVvNecdhmh3RIcYz9Bf6X/tJoepKRY8obwKjetynFMjDWHppoo8oe+xKfMIRATPvMNEjy4r1XSK0XsD0IjNOcEK14+PnjBaMH/OVl3ndFwxy+kx45as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KqKCtHbP; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b06d162789so4377911cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 15:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754517973; x=1755122773; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1o80sNmGFwzKlK4FxAE/E67Erwh6Se4s2RUs98B2vc0=;
        b=KqKCtHbPnuDXRIY+fhAZjVUj+3FIOk6+LdpoQun47mvWq3iDGxfZQx8mvZ+dM6OLli
         aEgKnWZL2Csvrc0hfMITHWLc0Rjmg/V+OyTpyWgiwe1hsreV3UUqV5s76tKJzfJZV3KC
         /5bVqqdquQlc+27y9Sta6Nw38+EBtZK0jiN7OEYd97+QcALMsrFucfDGHrxGcDoMvRUN
         X1b/APBElAfNVYTpDOpBUOH3aBrOcf39M2Or84eZwUKW9xs2Skuk3tgvkDKuKihOj1t3
         ZVP/us2flk87x2oHs8NTH0OCI+oCTChB1ld1gu78VBS1IKRFMzMZhJjLG2PFoyMAN6xr
         o/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754517973; x=1755122773;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1o80sNmGFwzKlK4FxAE/E67Erwh6Se4s2RUs98B2vc0=;
        b=hYA6gUqMiLzf/GvhcLD8VnoTVGs+vwQ58uVBo9IiwWyc+zWOARgGa1rRKYcV0CVn3N
         JRas1+n1q8oC8Clr3uP25Qotpd1LFdKMALxrBcH0Fp+TypExTD0p1EUQ9P8cB8VY2P4D
         uXPCdq0b9ChsGZnbQgSNH1ar1ESntODSJUQHzF3P2GLbOu70oxxvjg1cMSiJHBLY0tfw
         s70ocJORbAP0dhdf5A/1ZvnjQKGXtV0Y9ImuuzY7lpgtIKvY+ASKubJYSEA3JB1xEew9
         GMcW6XurnO1xiKG6lE1PZRc0WbIxZdH7lm8AxTHDsAjvz24DGw8l6yeztHkn9UXHbAfR
         BP5w==
X-Forwarded-Encrypted: i=1; AJvYcCUorgPSgwbG1XKiVxiiGkkUphrxsLMrrwqrVkd5Hl/5MTUMOZ+PZE0gdMSJyZq2oAtsjShYkRG96dNnV24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOeSmTTC/Lere6X5C6DXK0YM6XMv/pYr6vbkyaY/Q6L9vvnQ6o
	opZ7cqfL5LwsTyzIrirUkSwbNZm0WRgrZ8Zvmd3aYxzOL3rOxCMEhP+nUX0KzOnlWw==
X-Gm-Gg: ASbGnctoPzofM10ywytrbahxHh/gksaDKvW6dkozEmXxxx/jhyUYTcxMOVwj4Ezk3oT
	FmED8KbYJ6biZOYBKkp+C143lFCEHbKwr+20jx04dDr3+BHIU+WKaIDd5tpojFx2crZy2kCGOa6
	W9qG1elqbx0hZzm/N5IcErvaO+JLqRAGDyHuNL2sx3xY5aizN/fzKA18thBX34tVjpBWZEzvQAZ
	14pNq6lRtJeE0DwT573t+eAXiZI37Y+2xhlC699zhA0gwfGIg4HVZ9RTkDTxaWqgglvKPb7iXf0
	SBDayjJLE+moFrIlPpApGVng+upowJGzEXkrr5g+QmtRu7DYpfqpqt/jk4aOueCE9/4AUM8FpYb
	Izyr9P9WSI7QLy+IjbO50B2CgMrgz9XwlGqD1n9YhRSNjYbYO/zTtxkjGobGC1JT3REw=
X-Google-Smtp-Source: AGHT+IG4WOTe52hbcaGbNLSDM3J6PCnYw/yKUN/TtQ1ElGqLlp3dNbbODonDRI+YTHlBq/QwlhefrA==
X-Received: by 2002:a05:622a:4012:b0:4ab:a762:4c8d with SMTP id d75a77b69052e-4b0924b5879mr63239841cf.4.1754517972960;
        Wed, 06 Aug 2025 15:06:12 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b06f790834sm40991931cf.60.2025.08.06.15.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 15:06:12 -0700 (PDT)
Date: Wed, 06 Aug 2025 18:06:11 -0400
Message-ID: <3e45e20228c80f9f6a126d09208ff995@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250806_1659/pstg-lib:20250806_1657/pstg-pwork:20250806_1659
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 1/3] LSM: Add mount opts blob size tracking
References: <20250617210105.17479-2-casey@schaufler-ca.com>
In-Reply-To: <20250617210105.17479-2-casey@schaufler-ca.com>

On Jun 17, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add mount option data to the blob size accounting in anticipation
> of using a shared mnt_opts blob.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h  | 1 +
>  security/lsm_init.c        | 2 ++
>  security/selinux/hooks.c   | 1 +
>  security/smack/smack_lsm.c | 1 +
>  4 files changed, 5 insertions(+)

Since you're respinning this patchset for other reasons, just base it
on the existing LSM initialization code.  If this patchset collides with
the init rework mid-flight I'll handle the merge fixup.

I appreciate the consideration, but in this case I think it's easier to
not have the dependency.

--
paul-moore.com

