Return-Path: <linux-kernel+bounces-763654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFA2B21847
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 00:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39DA97B4767
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEA922425B;
	Mon, 11 Aug 2025 22:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="btRRtqFp"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976431DE3CA
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950888; cv=none; b=s5Emem8mfBSvvj3wyCLMsfRmnjEjyO75nycMdrin6G+qQrDXDAuHROOgQedJKsiASNbSVsZlJUpDN0FD9T3jbtpNXjPkuaJnuWYr2xQ+2g3VIRkJ17AbLZmr+72I7VTZ3N4wVAEuLskqEUJJC1afOY1sLMA+0//++XotBjmOjrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950888; c=relaxed/simple;
	bh=qXhanpL+DK2WbdhWgqSJLD1CMqNGLtc5qG4llyV7dp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfMttqc2Nxd7HB5TXd1s5QX3i2isKFtz00e9vF0ULHdehZGDiMQmaI9KUQUILeCHOUtdW8ccQ+qRwewIwAjDdpA9GcB7YTRA5/yjl16Okp1EUh+fxsSj7DzlLTRWzFMYTfsx48ygLuaMAjyAaMK52abL8A8TCtd0ulrN5BcNvgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=btRRtqFp; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31efc10bb03so4164885a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754950887; x=1755555687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXdnb41bcMRYFaefBcCIWWyf9vYxHasNkQCzWhItBkQ=;
        b=btRRtqFp9k1+3KHuadN8gK06YGLKpjW0+GWFyE9XG1iqlTQ16dWPQsFMmp51ph97Gj
         dLwIiXpomEM44yjpyqMmDrEv4P3wjNHXIYW6cGkpDaJt/NKkVf8AqZoieUypJT2i/UIh
         FriZsMf4aVn6qbLqdrEhohLz1rCS8ggHux2ODerie5ayBFWaS50j/EAqaLZj1aOLqcad
         XeYbY6PtgZpCRy8xnD0CFzH0MaFNaYaCzvcvkzFmDqQauEGA0Uu7fEj4huf6/5yCOzLA
         KlJb3aoG3F3DEp7WxAQxAi299lp1OJW51AUAGcvGJ+MdIoVSgb1gIWOzIOge6W2IRrdG
         xKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950887; x=1755555687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXdnb41bcMRYFaefBcCIWWyf9vYxHasNkQCzWhItBkQ=;
        b=NffvHlyhWM0mm5yk5UmBHGAS7xqKFGBw3m1R7STqaLvpwFQd/VhYTAzIH96ZYKPxcf
         L2yvMHFBw1dNSEkXp7xDHUVU3g+iY2OOCNtnhpN0n1KiNpEYV022UY4Ua2LBedO2YmH9
         nhz+gA1ozKtqDYHmJt2uzAQp75Fwqk3cVlUnQc60NfZ1oCnBKsm+hKnKAIbr23iiX5v9
         kYnxu5AiEQ98vTqtQvP7drTI1my8j7JCXQLfZ46f+G8YihplxddudyKd0sqAcJa1g0GI
         MZkBscEHDwEr33SWtbQoVmk/KsMjy77ESGJW77kuMMvWbCrHWgqC7qT6pYEYbbLzEbcd
         EH0g==
X-Forwarded-Encrypted: i=1; AJvYcCWqtiVu3vxBrWKlH0N3G5gf7gYQUlo2VjDiQyKDU4NjjVRSJQD2flOWLt5R0staFblVowvwLAe8Xy9w2Us=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxsI1BZdRcVgUUccNa2Y8cpKF9l/E4H5OmYNPKcaxc7hmMEVvs
	IBI6/IyX1Bebmruuh1ZnuH55f5Y5IlDIsV5t7oF8zw/OoQJa36mc/SQD9/ukX33CCG+pBvvNFT3
	SwygYNK3NhrV+jXKCWruSxzB2aGmm2irw6OiCp9Jk
X-Gm-Gg: ASbGncttE1lY8PF0KLA+Ws4DPcnq3+XEN0Bqj/Otk4yK5PvtH1U9C7Ziwz4+HhhxV2Z
	84eu4/R6tJutWIExCjo06oWbv5Ss26tWoYOpBxukV0s504egnwbIfFdqJ/x9BYrkBIHlep+SSJ/
	0XS5Us0x2GBiXJmp4yku0eqIbCswRw4YSuhR/j1E5dAqXAkHsphTkgiknvNQgPIYxoEIBmwekh4
	+999ZirZbEDBfczWg==
X-Google-Smtp-Source: AGHT+IEss2X+BEVYoSZIRFPMdBMIECB9EsuPm1/5BEpb7wMtfKbuhIPqkxFcGxZboN3KJZ7oj0OWy4xB2RyQ2dN40eo=
X-Received: by 2002:a17:90a:dfc4:b0:321:6ac:532b with SMTP id
 98e67ed59e1d1-321c0b3493dmr1670945a91.35.1754950886988; Mon, 11 Aug 2025
 15:21:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716212731.31628-5-casey@schaufler-ca.com>
 <d5f0d7a5edea8511ab4467e0fb225b8b@paul-moore.com> <4f6c9294-dfb3-45cf-8f46-c1a0063d2921@schaufler-ca.com>
In-Reply-To: <4f6c9294-dfb3-45cf-8f46-c1a0063d2921@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 Aug 2025 18:21:14 -0400
X-Gm-Features: Ac12FXyMjcnxuMYwY6jL1gdJPw-g9F2DzMGA2F70iCe8j7vzY4irDpbe-2aJOKM
Message-ID: <CAHC9VhR-Jd8JGhEETSBLDQA843FtsyN+ocM1XjfA_A6g+tJeng@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] Audit: Fix indentation in audit_log_exit
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: eparis@redhat.com, linux-security-module@vger.kernel.org, 
	audit@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 7:06=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 8/5/2025 12:39 PM, Paul Moore wrote:
> > On Jul 16, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Fix two indentation errors in audit_log_exit().
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  kernel/auditsc.c | 7 ++++---
> >>  1 file changed, 4 insertions(+), 3 deletions(-)
> > As this is indepdendent of all the other changes in this patchset, I'm
> > going to merge this into audit/dev-staging now and audit/dev later when
> > the merge window is closed.
>
> Spiffy. Thank You.

... and now it's in audit/dev, thanks!

--=20
paul-moore.com

