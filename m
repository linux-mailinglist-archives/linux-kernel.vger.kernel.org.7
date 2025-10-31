Return-Path: <linux-kernel+bounces-880647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 840AEC26430
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25B73BD141
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDB62FD682;
	Fri, 31 Oct 2025 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYHWdcgP"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8982FD67F
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761929662; cv=none; b=erArFoyRE+B+9RW7jfiIHTfJnMwE6e5nAdfZEqsJRr3oIPyMcp3WImh571EnKYIuqodb6bV3FlU5GqCdxMINUOYMMfU+6V+8h88sHEdX9Hn1FulSJwp5Cql5NSmg5BR69SFUUQDpKfs558gRApQNHF8VDwekkWk0txPg+4fRqhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761929662; c=relaxed/simple;
	bh=ic8R7PeSfgqiLUOO7h3/ggxGPF9WW8qd3pCh4Pyv/o0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGa8n6HHDOZsjsnt5pp3giMaG9xH1H80BesLRqwCv0Tf+5z8Yb2rL5zonKLeoOPz6os0hzj2S0OUPd6Fq8MqQADx9av33je3nezKqMQGVzqQNCfHUvNpuyxFaruzTsD8wP+n4hjMqqtjZFlEnF67wGW/voSQl8SQhKGwzkHs+o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYHWdcgP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so24072595e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761929659; x=1762534459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/vCylrs+0tr4q3q6ZAFpBo+ranVb22GkyacwbW2xw4=;
        b=JYHWdcgPCmH2iRM6bEUrof+ZjoGWLoyy8Xof68kJKJTfCwJC5XeqDeLxeAXk7zl4Dt
         MbNzxIUPE9WoZiXB8w/geNbQz+GI5E8B6DEcl3F4ZmDKOvMul+FUIRfu3QESHRR+8jFb
         w7orhtRA/6gziMhT/Yh/0i5/4ePQONjaGDw7ZvwM5l+wjUHDcljqr/AEgYVsxqIvCJ3N
         HsG9XpX3NdAgrxLYUBjPl92U6oK5Aw+YG50Q1l06DKmMNEzfkBF3Zo0y0P67I561pMVy
         3zvvs9ouP5+LKKtpohlirUyIw5xvMwK7KH9o31IiamV9w1OuQtqP51Y5RxoK78LcRvEN
         WGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761929659; x=1762534459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/vCylrs+0tr4q3q6ZAFpBo+ranVb22GkyacwbW2xw4=;
        b=CWsWCP51fcsF4ebGjar7AZXf3wNgQhSe1RER8DiUJwSbiE4f4c2h96m3UEbtN1t+ta
         ie8qyq/q5CCnkSsckFHdubqfZNJ7C3Y+dQGSlW4TZtB1kZIUZn/GdV0kmfn+C0tqMp39
         IrroQf7WDdpjpU2QT8I+xTVDUFW52OxI2vtd8kzGvNDvNIENHC1YCl5L1d8lL6BKyRdd
         S6T9wPoJCXy5TYQw8pvSZM2Bx/+tgLzmYr8X6V7hQaE+//dOulHtv7V6hUSEOCvNjdy/
         CbpUFDrikTYwj5E5qqYtYvOwBSnsoVaYOLT073Q7tJ9X107jrmisHo/Nw+cv9qMSD/7m
         YWqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvDew14Q4ZkJWcMkrahxWwsKg3SzHPpWBefFaWPAnPUrIMu+50c0JIJkNcewsEUtHZV3RORIodvTtMSa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye53fquziytAEHPMByC/b5T/zxtocFIHggDO/qPC+KIWFcjf/f
	cmTvkpCLIrFkigMQTTJ1xFgBujg7FEHWkgS/Bw49rAwYQV4qhUNYYxVy
X-Gm-Gg: ASbGncvk38UEy/JVsrABvAO2EfmG4IEpyK5Chwjo+0XEKIa62uFTWwD0AbiJYynQH4D
	kU7VxKjXyUtbsBG87qhaUA5CvA6hdEbydl9uxd+vSo+RSa4yCliYBHkKaBpGIy+FfOk/pT8mMxl
	PrjxmI3emkNw1VWCoNeLhLHDEn/DRX7gRsNVpo1zbXDuJDXIGHC1zZqPk+CLE2LTEqlOK8tUZY9
	dAdWQqpFL9+3vNdakvze2z1Av1qfjs+ObDSSmsdiBorW0G+vqV1zX/MAOzcEv0J/MnrB7tVDtAE
	oHM3FlsWRgMLeJRz+ITsn29AitRn/GXApO7h9DF4fkIkhmC7HGhwV393gs9/fCDj/rI1Kv7NeXu
	GmQJmQpir8EU63EjlfgrWlndMPfVD35Menmq0+jL/iqggGEV2z3NURbIHwTnWbZyNzdgQJ4v6On
	3KSu4g7FF7I77lboK+DMe+8N3aN7ecnXeeheURv8cPmQ==
X-Google-Smtp-Source: AGHT+IHSI+zsuHw2dropePAurzOFarCziEZZIfwNC9vETGbIZ+nr86tqW6LFJQrkhJOWJLe3kxpBzw==
X-Received: by 2002:a05:600c:699a:b0:477:1326:7b4b with SMTP id 5b1f17b1804b1-47730872322mr45079395e9.19.1761929658835;
        Fri, 31 Oct 2025 09:54:18 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e03d0sm4564270f8f.26.2025.10.31.09.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 09:54:18 -0700 (PDT)
Date: Fri, 31 Oct 2025 16:54:17 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device_cgroup: Replace strcpy/sprintf in set_majmin
Message-ID: <20251031165417.4490941a@pumpkin>
In-Reply-To: <FE3AAB5A-9AB9-49B6-BB67-FCB97CD5AF29@linux.dev>
References: <20251031110647.102728-2-thorsten.blum@linux.dev>
	<20251031125916.3b0c8b22@pumpkin>
	<FE3AAB5A-9AB9-49B6-BB67-FCB97CD5AF29@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 16:23:02 +0100
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> On 31. Oct 2025, at 13:59, David Laight wrote:
> > Even if ex->major can be ~0 there are much cleaner ways of writing this code.  
> 
> Thanks for pointing this out. Looking at the bigger picture makes it
> clear that most of the code can actually be removed. What do you think
> of this change?

That is sort of what I was thinking about, but it doesn't quite work.

> 
> Thanks,
> Thorsten
> 
> diff --git a/security/device_cgroup.c b/security/device_cgroup.c
> index a41f558f6fdd..cb845b1fad6b 100644
> --- a/security/device_cgroup.c
> +++ b/security/device_cgroup.c
> @@ -244,7 +244,6 @@ static void devcgroup_css_free(struct cgroup_subsys_state *css)
> #define DEVCG_DENY 2
> #define DEVCG_LIST 3
> 
> -#define MAJMINLEN 13
> #define ACCLEN 4
> 
> static void set_access(char *acc, short access)
> @@ -270,19 +269,11 @@ static char type_to_char(short type)
> 	return 'X';
> }
> 
> -static void set_majmin(char *str, unsigned m)
> -{
> -	if (m == ~0)
> -		strscpy(str, "*", MAJMINLEN);
> -	else
> -		snprintf(str, MAJMINLEN, "%u", m);
> -}
> -
> static int devcgroup_seq_show(struct seq_file *m, void *v)
> {
> 	struct dev_cgroup *devcgroup = css_to_devcgroup(seq_css(m));
> 	struct dev_exception_item *ex;
> -	char maj[MAJMINLEN], min[MAJMINLEN], acc[ACCLEN];
> +	char acc[ACCLEN];
> 
> 	rcu_read_lock();
> 	/*
> @@ -293,17 +284,12 @@ static int devcgroup_seq_show(struct seq_file *m, void *v)
> 	 */
> 	if (devcgroup->behavior == DEVCG_DEFAULT_ALLOW) {
> 		set_access(acc, DEVCG_ACC_MASK);
> -		set_majmin(maj, ~0);
> -		set_majmin(min, ~0);
> -		seq_printf(m, "%c %s:%s %s\n", type_to_char(DEVCG_DEV_ALL),
> -			   maj, min, acc);
> +		seq_printf(m, "%c *:* %s\n", type_to_char(DEVCG_DEV_ALL), acc);

type_to_char(DEVCG_DEV_ALL) is 'a' and this is the only place it happens,
also acc is "rwm".
So that could be:
		seq_puts(m, "a *:* rwm\n");

> 	} else {
> 		list_for_each_entry_rcu(ex, &devcgroup->exceptions, list) {
> 			set_access(acc, ex->access);
> -			set_majmin(maj, ex->major);
> -			set_majmin(min, ex->minor);
> -			seq_printf(m, "%c %s:%s %s\n", type_to_char(ex->type),
> -				   maj, min, acc);
> +			seq_printf(m, "%c %u:%u %s\n", type_to_char(ex->type),
> +				   ex->major, ex->minor, acc);

It looks like both ex->major and ex->minor can be ~0.
(I'm not sure it makes any sense to have major == ~0 and minor != ~0).
However this should be ok:
			seq_putc(m, type_to_char(ex->type);
			if (ex->major == ~0)
				seq_puts(m, " *:");
			else
				seq_printf(m, " %u:", ex->major);
			if (ex->minor == ~0)
				seq_puts(m, "* ");
			else
				seq_printf(m, "%u ", ex->minor);
			if (ex->access & DEVCG_ACC_READ)
				seq_putc(m, 'r');
			if (ex->access & DEVCG_ACC_WRITE)
				seq_putc(m, 'w');
			if (ex->access & DEV_ACC_MKNOD)
				seq_putc(m. 'm');
			seq_putc(m, '\n');

A less intrusive change would be to pass 'm' the the set_xxx() functions
and add the separators between the calls.

	David


> 		}
> 	}
> 	rcu_read_unlock();
> 


