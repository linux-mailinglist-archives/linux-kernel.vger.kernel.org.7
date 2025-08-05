Return-Path: <linux-kernel+bounces-756916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8B3B1BB03
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4F987A3A15
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EC1238143;
	Tue,  5 Aug 2025 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AdgEqdVx"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6522221A94F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422757; cv=none; b=N3qD0VHX/1fzBcUhSXwTxIe7lfV8uEiJTkRhwBLksMCFqmKeOyHKPMtTvNfsFjeUiVQbwBOgBvABs6Vyu9w0VzBOYrfB++a8xI8vY8AuhIzbc1w2tjsNPKCNXMM2fS5OLlEJKLxzb3Ypp+vRB0Lz6TNiMJs8exKaXTo8AQXspZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422757; c=relaxed/simple;
	bh=hrWShkwoLgpiXECNmA7ue8Ad2qXssEeiJhCjKxFwpUw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=md23DNFIa1jvXxEWFOtzhPqA/HqdaL8a4hCuUUUvy/I/GwpSSIiNgtOs6ZSabKhvAXcOw1IurRMsdbTJ9KlfhdzQPYNfFJ9rAhe5Z12oCCrkZrpzdyq6ZdTbPZEgY44NbarWqedDhhaFbJJGoqpuKfXeGE0xe9BP1Z8ecJMxjfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AdgEqdVx; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b070b3b7adso34911421cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 12:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754422754; x=1755027554; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBazbWpOs6DnsY5hjuc5EgI1FanuICFKa6JiwIf4Boc=;
        b=AdgEqdVxp+p3aCgMQklEJoqYqxtp3hq7CHD70lHatl48iYNUfqs4J6ioXr1JDcaSy2
         D4cDsSNeSsWU8YrTTqI2HmzntGW50i2nVttSP2SU5zi8bdGHm8ZreaiZfdT+0ILIFmPt
         ENjn6X7E+DC24x1/Xp1PQ/JllxFrDUw+v6bXyDEIMLn7AvpPvCKG48xKGJwYdobqgu3q
         Q3MuCQ15mQAPFq+aAgAiRbjoqOEbMtNcJAU5Io4X140zmfrDY0LXEF83+SgsLmtxF3Ql
         6zZJ8LEkasEMCLGlub5mrif7b6bJ7+R6t/yWSD3yGJjf+TcdV1Yg81t79kdRQw0F+4sC
         QXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754422754; x=1755027554;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fBazbWpOs6DnsY5hjuc5EgI1FanuICFKa6JiwIf4Boc=;
        b=cK/M0G04iAgRjkJeTJmy+4P7HBIrEu+t7LmqdrSsJy3vB1gsziuK6Vz5MRYcAOcZR5
         AtTaI7X1uleMoMpWoMKfvhL8ABrCmqufcKtf21GsnUEUWg2NZJ9EfhcjkGQfgYZPpjFh
         3ghhfYH2jPweABNvm76Co2/aPENmdo2ZKpYEoXvjVp7a/stlDBH1LSSnH+zK0I1V03RR
         bpg4UIEYUSbIZ6xGExuFB5wtFqqtiNyy1tEfuthZ2eBRPrm199rHjYRja7w8RdhK4rPG
         eblcsqfnF6p1laageomA3ujoKO1uY2WdXkhybpM4WBxx1Bvow7G4mrrc1ztLdXca9iCy
         4kzg==
X-Forwarded-Encrypted: i=1; AJvYcCVv/Z0zepRHoX0M0lKZm0l7KC6kF5iCZPlc8+8yRlc1/9LhQHnQFTOoLAYRvzQK0sHJ8lJaGHZFiNvgqvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhi2zEjFY6VMtvNQ1P+0R0LEUZuDegSdYUjFTNBNDonL/f3LJZ
	M+N0zCosuPDyYUJcOalhQkiP8ZBm/dmYxREQRQm6/9lPjHVP2zayAcb8pPXON/7ItQ==
X-Gm-Gg: ASbGncsO6EVTCeNVrg0i0OnOipyJDO+s3VqlYcZF3aK9AWoFSu2264b0qe5tYs7sHPE
	ea27zHKNWIZ/H+2ZeR597vefiTD4jUr4pOoW9ZdmYT69uqyMLxgQyA3PEBSpaaJMVsJFHUwtzwe
	xWTUFXjHVnCwOVRdnUVh/FosOwtvtYnwFU8AYwNcFijOl+GkzhSH0hxYDRYPbeEe9Jsqnm0XuDx
	84cKEMXR15WeE9cVbzJC0+xgHDV3YmJdQoDP52LeVDaJKHeO2aduIdpSN1O9LRYlWCA8fXCxVQB
	YSC6V+wu+knVbKgKVuJLK53FUgWv9vwjLKpSUNvLeMOPk52PjVVXyg06ERQE0HymBKitZLX1RNC
	FBQnRi3AnNjIoCv3l/TeVz59D5xeRTiOCzVl1QLGIEuHNZNH6B97l0MR/zXfqKL59TF0=
X-Google-Smtp-Source: AGHT+IE+HthgC1i47sqQa2UGVUpX+LBzsQmL7EJldwFkiqkyAsWUvz71mh0r1BVzJ+awOI6xE6jKGw==
X-Received: by 2002:a05:6214:2a4c:b0:707:5c4f:f0c9 with SMTP id 6a1803df08f44-70979523ac7mr9246676d6.16.1754422754256;
        Tue, 05 Aug 2025 12:39:14 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7077ca464acsm76152926d6.36.2025.08.05.12.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:39:12 -0700 (PDT)
Date: Tue, 05 Aug 2025 15:39:12 -0400
Message-ID: <d5f0d7a5edea8511ab4467e0fb225b8b@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250805_1248/pstg-lib:20250804_1752/pstg-pwork:20250805_1248
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v5 4/5] Audit: Fix indentation in audit_log_exit
References: <20250716212731.31628-5-casey@schaufler-ca.com>
In-Reply-To: <20250716212731.31628-5-casey@schaufler-ca.com>

On Jul 16, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Fix two indentation errors in audit_log_exit().
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/auditsc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

As this is indepdendent of all the other changes in this patchset, I'm
going to merge this into audit/dev-staging now and audit/dev later when
the merge window is closed.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 322d4e27f28e..84173d234d4a 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1780,15 +1780,16 @@ static void audit_log_exit(void)
>  						  axs->target_sessionid[i],
>  						  &axs->target_ref[i],
>  						  axs->target_comm[i]))
> -				call_panic = 1;
> +			call_panic = 1;
>  	}
>  
>  	if (context->target_pid &&
>  	    audit_log_pid_context(context, context->target_pid,
>  				  context->target_auid, context->target_uid,
>  				  context->target_sessionid,
> -				  &context->target_ref, context->target_comm))
> -			call_panic = 1;
> +				  &context->target_ref,
> +				  context->target_comm))
> +		call_panic = 1;
>  
>  	if (context->pwd.dentry && context->pwd.mnt) {
>  		ab = audit_log_start(context, GFP_KERNEL, AUDIT_CWD);
> -- 
> 2.50.1

--
paul-moore.com

