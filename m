Return-Path: <linux-kernel+bounces-793002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF46B3CB63
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 16:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7EA204E56
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 14:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC9D23BD01;
	Sat, 30 Aug 2025 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PAcJ58PU"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A339274B2B
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756563320; cv=none; b=lWXMKfmo4BuIeulE7eT4fNLHLOScrRnq0EJOVL+Qk9B8JaJycUvlSRf7d54HDWPqbdbHsVqM9zzvK7nvfrSMM1INAzDbfokEE838nQ4DtZneol9A5jIBAp3XJBceQoh4AW1ogC/LIDC4VMfYLLajVFxurRvHFd9/ewfmK3OfcTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756563320; c=relaxed/simple;
	bh=JUvCDmRXFunAkEsF1GRXbXtYikzq0w1vDWUP6HCoymU=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=MoNXWJ0FCVCtDIRkiarvY+mx12ZmBBwUg8h122Ir01fRqoFnBGbOuEV+QHM61G1QFeqIa29Ssa+OR2TSTs+Nw9vrLdFznT13PN0iajMMHkoG+1lQ4Jhnnsn/G0UZSLNowmeE5W+BIpxpEFQ+Wmzuo2PpVVtrOkdPl/86Nt+Ue9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PAcJ58PU; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b47052620a6so2912003a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 07:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756563316; x=1757168116; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xdijhc2hQ+HCzm0Bxa3P9aIQeay6kqPQfSVWfxshLOQ=;
        b=PAcJ58PUHfp4hMcxmDTRQ7mRryINHbS+m+lSZ7TAjVR3iI99kawAFbYvh9WVYxrpZy
         getGeM4yZeVviSxsCRg1BL0FC2KgdgiGS6GK+3kilIhXLCwmi0prmwRKWJrCDKLXncCV
         1WgHT2JADs/f8s2meak1aqvHkLdnW3+8gwlGrcuNT2ZXwo2AI9sWZfyH4Dlxp3LJhgbm
         aaotxR3RztfRL1ELuPgSUdr7EHIpdewzIu+11FRlShCkvz9Vtue4KdL3vBm+zHyvxKum
         SGcelhgtLcSUAgUgRiZPDVvKO6sla5ijwCfYLtYHqvseiL8NvfK0lmKCJOYWykMDswix
         Ci9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756563316; x=1757168116;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xdijhc2hQ+HCzm0Bxa3P9aIQeay6kqPQfSVWfxshLOQ=;
        b=YdnZ1o27mcBfqZtRQnqgxXormtMYk4IxIybUCzoYagSXeqOOuzLOFtqaN4hpa26lIc
         leY7CEADPj2DfiamcskUylUlmXmyTA2gMoMN1PQaTKYkNoePkvuRh/iToI2ULH+nSEQ9
         LzYAe82C6QOt2Az/vB1HB4T7Mazv1DJSz6hJMh11MJS9iN5gZCMzpOgxwDlDetH+Ns+w
         lO0i0ke6EUnvOcNc8EPulfJ/L0vdH3OX3cnjMQb2SMJDUpuI2h5ZUVAk8jYEbpIqztj/
         f/51igpoqGOUcTiqlYneNQYChhah7EqEqlw8fjWQElwhQ9zdAjIrYMVxJfX5y7FNlfOQ
         /ueA==
X-Forwarded-Encrypted: i=1; AJvYcCW7SHfmP60Ft8vbOa5wjZuMUA8tmvUBiq4UJfq/HYKj+5eId3kKR0Bra6UPt+6JCOUEvjROqA3E0qWC+Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSlXCkpJxmEumqjJlK3TpPfy52zpoAxY9W4sj4n3CGwkk1WUmR
	NC2j3uTkDd29lali/KZjYryuROKpLucFLA54SMovBh6aIhvYeCRM+oDImlYoo1XcRw==
X-Gm-Gg: ASbGnctYBAyAVilH6MCn9v5qI2F/njGL8b/KmEIQ9sbUEyYmwY8NcZxaJYOuDPAeu+P
	CiyQodVSpkAr66pb2VXcMqLTijOqxf0M01Bmtnm0ffQcfzjxjNpnlA5q4qgo6g8bg5O9dVZCR2u
	2pZFWD0SeDDdnRgNcfq76WMgHuqP9N1I0D0/eBa+oFexLqKjXWemtVXhqiMVWYKr0cyGKw6s5Jo
	n3Qq/5D8Q6xFCLga2v13J93DJ7idotbPIQxm/wnamxETcm5d0k242sM11BnCTpZQNKuEh+R9RLi
	POhwULBts69oa3TPPTlrBWiHQp5NAcjdY/Ocmd4eARWXX1ZbTKhJP40WMCsS9+BOO88cBtN6euj
	TJJiODrkgpb9ny+73LxJ9ZQRI
X-Google-Smtp-Source: AGHT+IEQEsGM+8lfyVtjTlgkC5lbtII1qVz6+A4KiCnqNKckDNqV+kxRsJNCugaEBNYu7LYPVzpTNQ==
X-Received: by 2002:a17:903:186:b0:246:2cb3:5768 with SMTP id d9443c01a7336-24944b4323fmr31449135ad.30.1756563316240;
        Sat, 30 Aug 2025 07:15:16 -0700 (PDT)
Received: from localhost ([205.220.129.22])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24903755851sm53673845ad.56.2025.08.30.07.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 07:15:15 -0700 (PDT)
Date: Sat, 30 Aug 2025 10:15:06 -0400
Message-ID: <1c0e40a52934243b9721df47aa604734@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250830_ 948/pstg-lib:20250830_ 845/pstg-pwork:20250830_ 948
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v6 3/4] Audit: Add record for multiple task security  contexts
References: <20250816172859.6437-4-casey@schaufler-ca.com>
In-Reply-To: <20250816172859.6437-4-casey@schaufler-ca.com>

On Aug 16, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the single skb pointer in an audit_buffer with a list of
> skb pointers. Add the audit_stamp information to the audit_buffer as
> there's no guarantee that there will be an audit_context containing
> the stamp associated with the event. At audit_log_end() time create
> auxiliary records as have been added to the list. Functions are
> created to manage the skb list in the audit_buffer.
> 
> Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
> An example of the MAC_TASK_CONTEXTS record is:
> 
>     type=MAC_TASK_CONTEXTS
>     msg=audit(1600880931.832:113)
>     subj_apparmor=unconfined
>     subj_smack=_
> 
> When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record the
> "subj=" field in other records in the event will be "subj=?".
> An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based on a
> subject security context.
> 
> Refactor audit_log_task_context(), creating a new audit_log_subj_ctx().
> This is used in netlabel auditing to provide multiple subject security
> contexts as necessary.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h        |  16 +++
>  include/uapi/linux/audit.h   |   1 +
>  kernel/audit.c               | 208 +++++++++++++++++++++++++++++------
>  net/netlabel/netlabel_user.c |   9 +-
>  security/apparmor/lsm.c      |   3 +
>  security/selinux/hooks.c     |   3 +
>  security/smack/smack_lsm.c   |   3 +
>  7 files changed, 202 insertions(+), 41 deletions(-)

Merged into audit/dev, thanks.

--
paul-moore.com

