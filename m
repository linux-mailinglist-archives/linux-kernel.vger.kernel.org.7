Return-Path: <linux-kernel+bounces-853469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A51BDBDBBE9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243A919A0C32
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AC930DD36;
	Tue, 14 Oct 2025 23:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N1jMtUhr"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BD73019B6
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483577; cv=none; b=BNveWWCuVRCuH9BM4uQ46KULQ8l+S8iRh5/bhpyTNqzU0XJczHWjdspMnvaMVqtehyOmIBFbCBqITjRNs9wSvjGkeY3s0rwsJ2zyTBGgRqUj+uG7/yr/TgchOV2e7+ekVTo5XB3S2IBkoL5RHNqkpNmxtI9uZhVGGN5nfYYbRsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483577; c=relaxed/simple;
	bh=yBSQDIAerL1pP8jBEJSFDm/XqydoQBHKsJlKkV81ReI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=L4d6W+iZtkJoqYgY4kImvJm/8UXaRODmaOXrRI9f7mLahFGj8k8VQATSDmi65Rw/p+J0u6xS/2qdn0cOAfFDufOfIn9/Xv4yUgtoEQkqb9EgDFpVpmXrpHDrhoebPoCqr8kIs0GiFPVGuuoD2PT/w7fMqSCIhMHw/yG+qpUaoAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N1jMtUhr; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8608f72582eso412238785a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483575; x=1761088375; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3staXW51kCGZsXIYMV8mfgMCQKvW22Nmb5sYckB4owE=;
        b=N1jMtUhrEsoqSqmuUt4dNAp2G91diUd+lxSNjM5PHpqvyt+msQmcGnTt8sMI+PzIB5
         zzCchOTWn2kMn2zqx6sDRH0X9lZEGpQ5gcZta/w8esbx27at03sPyIxE1Dv3vK1URwqf
         3mf9g2dDt3uMI3u3nAQs3WOaKlQgwUVDyR3ZQrzLeSEX9g/ngZI+7sIBub3GNgrYSVDn
         nlHPI0/575JpkkQt7M7qb4IQr+lW/ULVNlN2xjN7wdZ/2WXU48A+FE4NT+qviSkLxz4t
         ubNO21xBE4pteCCm3wm/5/ufpCajLYNUwkKl9lbzFY27+Q15CGDzJvSLvBGO24TuCgSF
         hmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483575; x=1761088375;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3staXW51kCGZsXIYMV8mfgMCQKvW22Nmb5sYckB4owE=;
        b=ZyMKuMabusvBObCG8RaExuTFkVqZNxJvg6DY+lSW7uLxOlkz8UDEj0YWptazBaA914
         qb9TyyG2e/WXfNpWyi6ThgV70MVl/k9+bwtsWokFRgX0eOb5YBlQapj/MJazHxelwBKu
         PnEvEzG74Ecp8/ZB4XyZgu7ZgYJsH04pg65rXUeMbEY4zGul1GFxoOfS4VvW+LtTxwUw
         1Zd7UsVUVJQ71NpADJwI9nJ5fGrsHsvRGxmeBYQocnTn6kLfQliAQhpyKUVJyYWKZeVk
         X9qLy9gOD00EFZcM29v+1VuCSTs5Bga9FRT+uPC50L5VJI8mxUjsto/1/Mq/AE2dct39
         Na1w==
X-Forwarded-Encrypted: i=1; AJvYcCXJEgVIaHnSkrtrua7fvR/xFXOw1u8fR1xFwa0bdN1wIK+CKOhmRNnS5x7dDGuqNfwvZPqeAyz4Lay1LeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxylDcX1Ppk31b95G13xrXw7NnzaR43TfPc5As+HkD2EkPmgR/5
	9nTNSrteirH7WVDGuDDTd2q2Eifq2xTi8swk+GIhmc8WLpJW47BH4RgTMZ86BApOnw==
X-Gm-Gg: ASbGncso2Yp3OZ6lGSM8CnshpE+xON5nlEKFuuoIYB3+MVKguFDRe/mX9XhDlzCYvlD
	IViKLWlnIx87WLORpx8Rj53opHB2l7o0kd0ivx1F1L9sY+7lF8rj1xDTimI5vUjUFUq/pkSMSGU
	ChPiCH2CCVUmZSQiN7apZTovMU8jZKj13gUC7pUnK2cEpYr1ydTOgret/84P6sTXhg1uI2iyqNw
	RYwzXWHzXKm6phqo4u8W+XsmrecZC6UpuShTN1wS03NhfXOyucgMET78oKqGUrOlOFQcPkaf4pX
	2YGF4LWPzs2lnTP0xERAz7AgzxYLZEcBYoeHCpnLBONpFSSuRveILBroLvmz48ukVsEd+f0G6Sg
	ZQC8jT+y01n1rdas9ZFbtf2wU+mxzEjDOFaFvoEFhq8UFF2K8vVHc8vMU84NUR04XzDlzDi/0aW
	dwfk/LDLOcjdfUzawntlzfVQ==
X-Google-Smtp-Source: AGHT+IHQuFhiVAIzWYGxERI883rLNluCPfSroNYywP2IoanX/gCv8E91aVZJ/MsGoz8MOXeF3+6hyA==
X-Received: by 2002:a05:622a:1989:b0:4ca:9c53:f1e8 with SMTP id d75a77b69052e-4e6ead793c4mr365706661cf.73.1760483574819;
        Tue, 14 Oct 2025 16:12:54 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4e881d2c71csm7370921cf.43.2025.10.14.16.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:53 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:53 -0400
Message-ID: <b73ddac399f78e46ba753f6bea4fcbb5@paul-moore.com>
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
Subject: Re: [PATCH RFC 9/15] LSM: Add mount opts blob size tracking
References: <20250621171851.5869-10-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-10-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
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

We discussed this patch in a separate patchset, lore link below.

https://lore.kernel.org/linux-security-module/20250925171208.5997-1-casey@schaufler-ca.com/

--
paul-moore.com

