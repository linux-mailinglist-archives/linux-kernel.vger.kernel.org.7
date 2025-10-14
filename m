Return-Path: <linux-kernel+bounces-853462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAB8BDBBAA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E0B3AA8B4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917302E2DCD;
	Tue, 14 Oct 2025 23:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="D+m1psg/"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9657D2C1599
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483563; cv=none; b=BCc4gzOPrlSDj7KpKEzyav3Sb9KKo67LxW0OabRzlxTsDwoBdkg6SYsbKwzFg8+W13YlZ2Q6gdG1uvaJiefU7K19S0CENfCySIGYQ0gHGSO+4fmgLT6Q+W4yW2BHb/EhDN31OtfwD56AQjUA7Ld1HCFKGtN0enZxK9cgJ5FHJF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483563; c=relaxed/simple;
	bh=jP7eKKlEemoHr9cH5h7XSAsqHsL7E6l+1k/CdljmEEA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=aOqZxFu8lEGvUOMdqclc7tgFXYRj37m1edBI/SaAqLyYk88LSklgIPkUJtD8BjIW2gZ7hEb+nJZslFRp5PcCoL7OQiDkqpgNvf19W1Dp78Oi5uIcJwqlu/xUMYdtKbM8r2gI1ZpRNQhw34OFB0E1XJOeLx4tMQ4N0T/raJuVjc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=D+m1psg/; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-883902b96c3so498916585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483560; x=1761088360; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLBpXGvn84P1YsJATB/vo2Be6tu4bfzDW/H1Hf/uJzg=;
        b=D+m1psg/0sPA5QUhpnBP97dPq4bd8CQkg3Pfjl/zaOpk19TkocwXe328GVOZCPcJdf
         bdwF7+IjhxslyctHtjf5J4Bbm11EuFY5VAPTLLChUPFzez8fN2e0Zod9GjCK2ix3WHH9
         L4p9WOhLc3SBVfIMcAbMWc5R65PsdBM8o0rCUAzH1o9DlvaM8ILu56S2mFUBcCqELEJ8
         pDfbFHDNvlEsAJWlOKgythNnBcgEbGR1MPesiNfqKBVCLji0Ez0A3Pou+wzUD6cwyqgt
         uJVfBOP67LMupZW2bPSuaWPfy5Yx7m5WjsYovsIzuOkpfH8RqvJfmiQu1R6qvp6wuHg4
         8ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483560; x=1761088360;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WLBpXGvn84P1YsJATB/vo2Be6tu4bfzDW/H1Hf/uJzg=;
        b=aXClsAriMyVYwB9Zzch2CF0vV1FfJ0pjbTy1ddrwmwQbncJo+PoJSxsV1qAvBwUBdB
         yFV6VC0/c686A0WuvNCtHKHwUpizLPLeScIHiWBq8Deqmbdalyjth2SuyWrbMxiJ3GKN
         wkUf12YXpFVUcZP4iCqSY2p9zym3FCScPrl+nJwEsimEVYzuAL4vWDODglpXqu/CxIhj
         Xzx+e49DtCHToF5eh42kA7KA9wm1zfMBRhmAZhxO5Exl5TX39YJOUZ4QayJyknJq+s8z
         Z3y31/xZShoUjdlCAGzetrgdUNoxN5Shx5bES9sllB95NlnRFy7HF9lgjnvhqoPC1C3O
         yzUA==
X-Forwarded-Encrypted: i=1; AJvYcCXX4e5yaCqUeJ8UPUCpMW9Vee2bCzFiuwHvV8gRfiQs1YpqHNrTrfYHSPgweQTZM0L4ca7sax9Cx9hOqoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcs44ggpyziaPmIEUK2I0UyIpr2MlWLrGLi3Bj2NS7EWc/isqu
	INwnQvwrFTtBsNlicV4bwFYEzuH+o46YuYTLKPHWIkX4+rxJFGPP2OWbp3MExjn40w==
X-Gm-Gg: ASbGncuiZYkPUkaantwxmm3YK/DCWe2oYTnCulkUgmaG+Sna5Yiq2M1j6cUUxZM3hbW
	8IRO3CB728TucEYDiqKGNWm8U0JcfOnN8B4IDIvhiwcfsO2SMqcl83eTe3O4UAgbfr1pzGCXjtQ
	QOjnF5y9/0QqhcyF/F6gPbCjltTn6b1QpeEpyhfLUaoL5VqpPqMoiiinG7aBzZ3mXJ7EGyaeTno
	Z9oNqI98+VE2fXe0cfmTj2rnQHMygqIfeBocW6c5BhlujvjJvQG8+264jZ8/XgUWq+q6B6u6DMF
	a/QeQJ0IqhJdv+fLt38pjDZI+nBDrPPz9herpKyUlH7SfXs4AuuIrUs9/rQX4j3qmOTrGfKezba
	UXf3yuoNGpUvIZmwxeybhtn2VE01l7HG5n9Cc26M533Ac2EcM2xsWVtSq51gzBEx+js2QUzWrTf
	aCXugx6NXBSl0=
X-Google-Smtp-Source: AGHT+IHHcLVZiMgSbPLG7eY76yfCqa2vB+jpgcP40CTtOHs38xnmpRUGPmtafOl88Gxs8UC/0Ltr+w==
X-Received: by 2002:a05:620a:254b:b0:88e:1671:2e4f with SMTP id af79cd13be357-88e16712febmr95763785a.78.1760483560211;
        Tue, 14 Oct 2025 16:12:40 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-88e1d60aecfsm23093585a.34.2025.10.14.16.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:38 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:37 -0400
Message-ID: <846555fc86ec02df31f55935e747a71f@paul-moore.com>
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
Subject: Re: [PATCH RFC 1/15] Audit: Create audit_stamp structure
References: <20250621171851.5869-2-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-2-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the timestamp and serial number pair used in audit records
> with a structure containing the two elements.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/audit.c   | 17 +++++++++--------
>  kernel/audit.h   | 13 +++++++++----
>  kernel/auditsc.c | 22 +++++++++-------------
>  3 files changed, 27 insertions(+), 25 deletions(-)

Dropped as this patch was merged into Linus' tree during the v6.18
merge window via another patchset.  To be clear, I generally don't have
a problem with multiple patchsets including a few common patches, it
helps prevent cross-dependencies between patchsets which is a good
thing.

--
paul-moore.com

