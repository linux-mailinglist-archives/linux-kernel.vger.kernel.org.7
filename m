Return-Path: <linux-kernel+bounces-793001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEADB3CB60
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 16:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDBDA20573D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 14:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1839326F445;
	Sat, 30 Aug 2025 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MBobF58f"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0543F19C54E
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756563306; cv=none; b=qQtn+mwUhOY4/KpKOGshcgFf/gListrUnfCcidY6frxL8nAM/aD0rE27ESWfWIkM3pGCtXdADn5xko4X4jqxIWDaP/pKDN7Nc2Y7zpEi+G6NKw5o3pUcXsAGu3SSVoS5u/LvWCK3a40pbXguJZO6O5t5Pnw8zDEyXzmjCqWREjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756563306; c=relaxed/simple;
	bh=KuCuDDtbZx5h6jDsIe6rWJMOFMPLouEnCPQ+GeEgm68=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=BameplyM4c8nidK95fW3ByH3wtAVikCYjvadM6X8VSZFjxzz2Xp+3ML1WHe/DhfyUcNikHffLmveY0LHlrsH6Mkt9DST+pLb8p2NFhNSbrdytH3C/9Oz/LcCSmXbenWj3GtTfq6K1/RxqxQDw5a2Np7WYwGph5edLdwGb+YYgXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MBobF58f; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2487a60d649so34685295ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 07:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756563304; x=1757168104; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yuNEhmGQmH8LY22b1eTjsCKfnCbGAYyebNq68E85dss=;
        b=MBobF58ficgNIc4oGrX19WVOGq6XLpZ8mh3kNK71TfrwdMap53XGAezhYuuypnEfQS
         6FexMpO4xuB1mVdLrLyyrAqCbIOauty20DTaXNgZhZNR+sw5C+RFK8NYqp3Oks1SLMSa
         8+P+kYFI+CCfQkAbMWU6m94Y84k+ntXZ+4MpDs5iZ0738PmdI1P7fKmxCb+nt/PEaQ8x
         V8LQAxvINYAlqLC2edlBjecg/ZIezwiXS1WP1a1V1/UiziUXUuHCOFsC43wdP150Td3B
         SqfKR0l7gJHVAZgfvYyUC847n0ZFZiuiITi9EbirCmdhtNgP81fS+0plKp1C1BScJ7Rf
         szBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756563304; x=1757168104;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yuNEhmGQmH8LY22b1eTjsCKfnCbGAYyebNq68E85dss=;
        b=a4aTQBpmgLeDidLorNUpM/77iViicmMWj/km/wlEkYzMrXrrP4EIj3FduTNGwpZBDN
         ACsG7PhOKEWcPL3EnJ1CchErHu8Ofz3c1sUeUPDmf6iPL18vafYq22HSxCF3Yq/j0wyM
         36dpiZbqvYyueTFCS4xAR2aqia1o0JdAcAGnDaBuMJcoVa//pe2pXkUsZKSKsWIn7UjT
         daflw3V3nI5CFajDRCLmYfU2IKFBfK2HpghdzUGCjHkOoRGLgf/EtaJnblty95TIO8ZM
         kDqt/TfBcabmGxqDt6QCtO67EdmQvrocBrqU6mByj/JEXkTJ+njaXPGjo/3H/WGDRhpZ
         bCcw==
X-Forwarded-Encrypted: i=1; AJvYcCX2teK91pW+EGdYdYTBnjSE4/5iGS5TIHEBdGVZwoMgm3fGwmAQ08GAD7RhzFBrazLovND0x8N8gvoMVcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBRpdWw8Dz6LTdIZMNnHDgBjkr7ofd0crVmiH4mCSc9jejcYuH
	zRxDcgLSemh4axhKnirDsO5Zzu1UeAbpHx9viydx5vQN+qPRW6x1nWIFmiN12v9cOg==
X-Gm-Gg: ASbGncsvAYZsIYlb89DvA0wKVEos5wlX90KmdnxQ1zMaJjGCY3/8AwGQOlzYT3V6S9m
	N+i/wYeZcxVNkw+fXWyJg0KO9fsUthuSxWwTFLN4WqY37ylug3LKK3PxTVOsENWby3sABvzwaKC
	NLVsAsbriaiQ4IbGncoUicYuNYNZNz/l5iL4AqhenS3+Fn4pdFMb5wJAeY8eyX4m6UbVOp4y0Km
	fczb9nfiPoVs8U4U7nBBPj7el+yfMEggDm6vobprw6T/Czkeexxj1AuloFt8kS4Ltj8yJIIGcJC
	X0WISwJorLYiazv1+mxoZVikMsuQacXSaFr4OwqFl7TqNRyD/Ran5i5neKyNX9DNkTmsavN7PTu
	b+ZLlI7cB85s/EQCoUczefQBCu2ncizkGX0g=
X-Google-Smtp-Source: AGHT+IFUA0BMN/ai3dblgX7nblxDAuW0oE4xAqPZKSyFbzHuCVTxFcaKqlDAd115j7vy2b6O2zjdFQ==
X-Received: by 2002:a17:903:19e8:b0:234:d292:be7a with SMTP id d9443c01a7336-249448803e6mr30907495ad.1.1756563304324;
        Sat, 30 Aug 2025 07:15:04 -0700 (PDT)
Received: from localhost ([205.220.129.22])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-249065a8036sm54004145ad.129.2025.08.30.07.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 07:15:03 -0700 (PDT)
Date: Sat, 30 Aug 2025 10:14:55 -0400
Message-ID: <808e70d5fe73e23bcf95bb445d2f91ef@paul-moore.com>
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
Subject: Re: [PATCH v6 2/4] LSM: security_lsmblob_to_secctx module selection
References: <20250816172859.6437-3-casey@schaufler-ca.com>
In-Reply-To: <20250816172859.6437-3-casey@schaufler-ca.com>

On Aug 16, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add a parameter lsmid to security_lsmblob_to_secctx() to identify which
> of the security modules that may be active should provide the security
> context. If the value of lsmid is LSM_ID_UNDEF the first LSM providing
> a hook is used. security_secid_to_secctx() is unchanged, and will
> always report the first LSM providing a hook.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h     |  6 ++++--
>  kernel/audit.c               |  4 ++--
>  kernel/auditsc.c             |  8 +++++---
>  net/netlabel/netlabel_user.c |  3 ++-
>  security/security.c          | 18 ++++++++++++++++--
>  5 files changed, 29 insertions(+), 10 deletions(-)

Merged into audit/dev, thanks.

--
paul-moore.com

