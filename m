Return-Path: <linux-kernel+bounces-853472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4BCBDBC07
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC073AFFB3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDA930F556;
	Tue, 14 Oct 2025 23:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GkIkFMgv"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C9D30EF90
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483584; cv=none; b=exeBX+Yg8dBIuXq3Ubibk1PCxn67Y0h2inlA6uVqC9icHbXr6QSsY2OBmDC1krha7hura+7cTiVEVLAl23NagWwGFvzlsJsN/WdKPSCtKS340zy1cRb2sbErJIbwXH1TdEjiqxHc3y1QYxwMa29K6s3nj9eAhI0TsINhjiKzUKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483584; c=relaxed/simple;
	bh=THERYyfWpJts86ukp6+/qN9qrzmQKu6JuEBRRXPCS04=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Bm0RZ+dLtYYJFy9I0m48q1EH9EeWZUy791qurWNMka9NKm3vyKzQIMWUXP1K9MFlC1pMlZwqF6qVasnfOlMztwrnjWVcKXHhQft6flHH8vslvAypAeN4Q9UOUOp0Q/f6GwEVIZhw1yQGNgM2tX+3b7/vtGQa/biKbcxXvZ2WUeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GkIkFMgv; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-88e4704a626so1711485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483581; x=1761088381; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YlJ/rymt2z0wf/HxlvzM0A8sd5hIISBlOct/3Lv9hgc=;
        b=GkIkFMgvsbHSUec2iqXrzQ6YkQNWroORiwcfzim1k+yimK40eAgy/MJ7vsZhnVCart
         eEL43wryNNCskIbZG2i4xyXjsZpW7jE60WE9uuXlFDvar85+RJXi6oEsYueFgaNTO8Ww
         YQuHfv509GC/Femn5YIK/rH54kyHYPj1fMFpxdNPOIgvikS+sraeWxz3eBjg27wkbX3F
         H0QXkiU9qtI9b4LiMp/KB2yPA0ysZuX+EfDeNfkbPKyRQlOHrgHtxfj4YQ3OkcfZLP4L
         4BD8k2RHQlcwYPGeINzZBMHXGM3N4fctvX50MFCmXFK4ZAt22Mb2WV1d+D9LuA2TW3tk
         htEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483581; x=1761088381;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YlJ/rymt2z0wf/HxlvzM0A8sd5hIISBlOct/3Lv9hgc=;
        b=KobN4xsRjxDxrAm+PAv2XsiOLMAEUpYromjU5qDB5eyCxw706mAHG1u2pPcfpFSQRg
         hbuKzPGOE0nPjcFX4SlfbdhY7zjZm5HGZgMmgW/GZvFoGEzyLc12F/bAcQ3v0gwDTJcp
         RbyxJXYMrxgeDbeURZRbTygNdbky9gcf2QoTVvBJFSP0yuaTkSZvT+Z5L6EaANjg5DPB
         6S91ia+Qba4FF7gj1E/DZffaczd0yHfa1O7d4lhtVFxvZ3sNzAn8yRwhU2AEE5i2erba
         LEzmuicEJ9pTZBaH+tlvKfEBdICuFUsvyngg9KVUNi4QyfPPO72datbRV/ZHp+BN5lan
         x2Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWTGtbI86pSK5qvJbNbWsSHfjXw0TCgC5bac2CwTqCWgW/aWuTJZsMx/8X25zimTmjvFSLWk+ZbpVhpeXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8VcZopRMZVMj4/OeYaqyNx2reca4Bk3QCH8ZEHV1ZgD5LIfPd
	VlfTG8RN7WOPJAaN/WXJNeeNRs37zgLUf74ODYguKdToturYCQwALF3L8bcvA8yYZw==
X-Gm-Gg: ASbGncvu71o4f+kUzDydbJBcI/RM0dQybVjLuu/uKs8BnR95+M4DhXtPvwuE3BWdEHD
	EGLkqFXzvI3ecS2DL0QkvKNCVIm9het5QRyYouTrRSTQXzkgQLZujZeRZWn/3EKWWOC9WY5vXal
	XwYi4xopReIHFaaxgb9wWpDcl9YjY3MRPvIL3YCnnCCORitcAaIgDPe8d3FdYgkx1B2BP15Jap+
	jlVHo47Wt4+znQrGOcgTkivE/Iwy7l6tNpRwbtUuCF/cIFDAyH1EVuSkB629/L2mMbEjxAxozWd
	L68v5o0w0te6SEJYdJSaZ7//EG6jrAStdQDhN6GVU4hYEqz2jeLkhMMQdmUI8lDXleUMVv4zvMr
	9XMbt1MKbelOahOV0k/K1Vb6pIH9bNwptdR2Zie0hzdoMUnBHCb5l4ymmWpr0hpqRR/Rrxflqc7
	IHPbYfFtRUB6Y=
X-Google-Smtp-Source: AGHT+IHjfyLXfSHciAF/hfVvhvyE+ji/i+hx1L96OGYtoV5M7LCsXCFga6nnYCODgc+TQMAmXTHAGA==
X-Received: by 2002:a05:620a:4589:b0:84a:af34:5b7f with SMTP id af79cd13be357-88352d9a115mr3780054485a.75.1760483581287;
        Tue, 14 Oct 2025 16:13:01 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-884a293bcbasm1290971085a.58.2025.10.14.16.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:13:00 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:59 -0400
Message-ID: <8f72249ed9358a895e6821495cab933a@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251014_1821/pstg-lib:20251014_1132/pstg-pwork:20251014_1821
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH RFC 12/15] LSM: Allow reservation of netlabel
References: <20250621171851.5869-13-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-13-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Allow LSMs to request exclusive access to the netlabel facility.
> Provide mechanism for LSMs to determine if they have access to
> netlabel. Update the current users of netlabel, SELinux and Smack,
> to use and respect the exclusive use of netlabel.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h           |  1 +
>  security/lsm_init.c                 |  6 +++++
>  security/selinux/hooks.c            |  7 +++---
>  security/selinux/include/netlabel.h |  5 ++++
>  security/selinux/netlabel.c         |  4 ++--
>  security/smack/smack.h              |  5 ++++
>  security/smack/smack_lsm.c          | 36 +++++++++++++++++++++--------
>  security/smack/smackfs.c            | 20 +++++++++++++++-
>  8 files changed, 69 insertions(+), 15 deletions(-)

We discussed this patch in a separate patchset, lore link below.

https://lore.kernel.org/linux-security-module/20251001215643.31465-1-casey@schaufler-ca.com/

--
paul-moore.com

