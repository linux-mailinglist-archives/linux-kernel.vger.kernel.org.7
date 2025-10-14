Return-Path: <linux-kernel+bounces-853471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 919B6BDBC01
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F42A4E8D80
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9EC30E848;
	Tue, 14 Oct 2025 23:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WMyFQcnO"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED8930DD0D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483582; cv=none; b=ciC2nMUG+xo6/Es7xY3mGtCrsnmfaXf/XvkIC0Ir6ZnH6BrFYLTiALulYEtRboS0SjE9UH0Q5GEM+CWt804KkAv/aRTJ8Tb+G/4zU8fSAIHMSbDpLxBzE+no0SwhDtsfQIaazA2a3m6Cd1Kc2oeHYQbIWaL6BgGOFzNgfMpsdLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483582; c=relaxed/simple;
	bh=2OjZR0xIzGES+vVHimuhr1zX3QGgjQKBqN8vzmD73Qs=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=nwkjWAoBHG/bZYdeNYAzn/vIwoYt0O4XZzERMhT5A/hLgS8lQqxCRRQXjOKp4qMO7tjCW/6W0coqh3M2sBOdPWB9fu3d8km9XOl9qlyDhQFxRrJ5cEn/6uJGLKAA8YiSaQTT/SgmT1t3jrubGB8xfAAZkvHRe6tlLrvLhmMNnWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WMyFQcnO; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-883902b96c3so498925685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483579; x=1761088379; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtW7xGM0A0i7bPQL5H3HW6xoKoQmcrde+jRMi+evfuc=;
        b=WMyFQcnOAdB/+dSch4ZN4hT3y02F1Jxkg6407M2HSVC6sCpMjABchEszuEZXFkOjZv
         AcZMRdb3M0pJPorj69ymuxVr+f9TiowBWhxn428bmBRA8pxgRP5uCBWj2tHRmvgt0Yc5
         cls1grSuL3az3zgt/ouDRbQ088bZabq+Nn8wyJliCUpl4KpTpMG/8UnBDYE55dmOUac8
         GulLGa6WPgFfbLG3S66PPcuUwyu5RnSP5pHlg0W5nmQBrABhvVUGqJNYctvzFJTDS0Am
         QIOXzeeZdqujE6G/ixfdRe0VHk/aVeh6YtXTsvHix9+m7LLnBKyHjuY5Amr1KOfgQd5T
         zqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483579; x=1761088379;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mtW7xGM0A0i7bPQL5H3HW6xoKoQmcrde+jRMi+evfuc=;
        b=Iud9pwjzPyYkXO+ZlRa1lMaYG2weiRCe8PDwEZrbuSpiDCvmZZDM4d/NKayY6B6kQA
         55UeXSsizrlmi57GVL4eL+Il9RI5RAs9yWCY85MqKkCy89NHbkSVMBF3ojZcW60Z1/R3
         BH+m5ZkXQ/2R1s5NWXZy7TtLlCE48s2V3r6+YDWj2jbJaQJuvwEdnGyr3/fKiwNo+LqR
         684FkHxys7YE/DYHVPZpMJbghDRF8PUG1F585By8E3WVym0+DUDZ60sL3Lz683kopWhb
         SMIEJBvv2rAHXWtD4BSM1ZgsUM/jbpIGazGzdtt9VOgLKwVEWstynOesnCpyGwQlxKaZ
         +8Kw==
X-Forwarded-Encrypted: i=1; AJvYcCX7oC6ZcIWtywjyEc4IHi+yxSjokyBpgzjEQqGz4b0j2eMEKu3il7dH34LRMHqCVg/s6bj1kNE4BFiVV2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTgaZWaI/lX3vVycIcJqZkAbZqUvMdxMThcXe89riTv+NZqZgv
	KpZr25pMcd/7KTnJA7zP9cTOmkLaqG20e9QcdKETTCrhSdNnsmC7hxK0FgDopOfAlQ==
X-Gm-Gg: ASbGncugvU46eAknrVW8OQ+amUUG+y8jY9i5MSY5JwZugCEcY2pjPeqlS6XwhyOx4Qe
	nxcs+nRTiHBXAucblrKKCTXbj2/5Jyf4+mhyRD5JZAPtjyk698cHfJJrZu/MW55AIo08uTN4PD3
	uImPQpe59+Kt5ZVC+lVNm9Wo1QfS5WOlDtB4qdY9pT1caf3Zedr2BT0KuhyQv8QIcjyX0IGp5WT
	2bpc8a0uYkBZUQeQeKiHkdvx7EvCM67TRRBCuVYfpk+CP1UeIIvadYXNQzQNXj9SSgpZy+wvx3L
	8sZ5XzzZCKzZB3hFLvUE9EQPYfDNn4UMaWb6dfYZqWXSi6Ye6S4Sh6TT0bknpNB5c1Vzy35t+iW
	RWAjzd6PgylzqTEuruWs1KSJrVajzm7e/fTvNQIwkWxjqxJJSXbNXMDd+xSCipeqOaeyYYp6EVT
	Eq0h2nNStx3KkUCSDh7+J1Hg==
X-Google-Smtp-Source: AGHT+IEptTo2pxg8BQyRH/EAXGF7Ajlrs/OC3K7xB2VEK00ORspclexLASyXzj0clJy3+lke8DpgeA==
X-Received: by 2002:a05:622a:4814:b0:4b5:dc7c:a6ef with SMTP id d75a77b69052e-4e6ead57ffcmr362320031cf.50.1760483578960;
        Tue, 14 Oct 2025 16:12:58 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4e885f1bf3dsm517031cf.24.2025.10.14.16.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:57 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:57 -0400
Message-ID: <3559abfc0d5ceb11f03451aab517c8d2@paul-moore.com>
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
Subject: Re: [PATCH RFC 11/15] LSM: Infrastructure management of the mnt_opts  security blob
References: <20250621171851.5869-12-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-12-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Move management of the mnt_opts->security blob out of the
> individual security modules and into the security
> infrastructure. Blobs are still allocated within the modules
> as they are only required when mount options are present.
> The modules tell the infrastructure how much space is required,
> and the space is allocated if needed. Modules can no longer
> count on the presence of a blob implying that mount options
> specific to that module are present, so flags are added
> to the module specific blobs to indicate that this module
> has options.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/security.c        | 14 ++++-----
>  security/selinux/hooks.c   | 58 +++++++++++++++++++++++-------------
>  security/smack/smack_lsm.c | 61 ++++++++++++++++++++++++++------------
>  3 files changed, 85 insertions(+), 48 deletions(-)

We discussed this patch in a separate patchset, lore link below.

https://lore.kernel.org/linux-security-module/20250925171208.5997-1-casey@schaufler-ca.com/

--
paul-moore.com

