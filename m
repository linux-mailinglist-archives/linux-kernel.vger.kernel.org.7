Return-Path: <linux-kernel+bounces-870086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0251C09E0F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37AFC4E1619
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 17:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA74302774;
	Sat, 25 Oct 2025 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1HUSyQO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721CC289376
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761414856; cv=none; b=EHqerpm1pd06iQ6fuga9pyhc84rqp5OXmFJod2YL7BWPrVO1SwKGAiIqNb5h4PoevSvGFr2MMOCyBYglofZxx33DJymHTzuG1BPV/xTm1YFOm2smzsjVYefWvUr9SQXssiXOK+95zz9iED1yR7Hb/F2hO4clu+2YG5ZE29JUHNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761414856; c=relaxed/simple;
	bh=/dCnsJxwgqeFs7PKSg+Ud/3vJjVEQ1NvMAtuR/PgdkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rl9EE2FA1P2FQj+O+Ebz+XXCunT2RRk7LnfuoJrRwAhdL4fOyXNLlrSVdudTduIKf6y8dH9EyOt+w3VYKsDOYEWQKZMSOosShP0z3ckTTIPr6EEZPJVD4dQgLfMILcarvJVvsg2JoHWPDJhMq+EYeMQ5Whzdme7V1yWCghQPE08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a1HUSyQO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761414853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/dCnsJxwgqeFs7PKSg+Ud/3vJjVEQ1NvMAtuR/PgdkQ=;
	b=a1HUSyQO3OeEXPML4yQrxyZWqSEO1LoJqHzZ1SFDWzzW0DeJwHgzpqVEEc8ze1YvPMz5s2
	9hby4VJeQbzTaaB3tCtDYTc/iECcyOEsZGeqLRV55O3onaskzEjy+U+RRDLOocWyDl8pgh
	LIpxtI3B1SYL18yv6g+bInsR2xsj6BU=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-evHlA6LfO3aE_ct-b7r6Lg-1; Sat, 25 Oct 2025 13:54:11 -0400
X-MC-Unique: evHlA6LfO3aE_ct-b7r6Lg-1
X-Mimecast-MFC-AGG-ID: evHlA6LfO3aE_ct-b7r6Lg_1761414851
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-556a45a4519so6549584e0c.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 10:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761414851; x=1762019651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dCnsJxwgqeFs7PKSg+Ud/3vJjVEQ1NvMAtuR/PgdkQ=;
        b=FF17S5rOPHJQn5/HVUwiqHNOaNpVfQiKaquQ9LBN2SzV1PkrsRNRexfm+X/pB4XDyq
         ibxG97Wbl8A1rOPw8HZ2uSdk5UCONaD9G8RVw9nxRtOzKcpEc60Fu1b55swf4qMH/2C5
         aanJz96KKLpIBGfHSfQ5bQFlnUBDFVwmtYJshiqNXQ7x5TqkezA5U7qJgoGfiYNkf/Ec
         QAWJuT/s1Byy4m+zuMVucko5cUbRDDMqMMuUuBZ/T/xJaXgzKExXAiXUpX0RJ0TOEOvg
         4nwUnw2Gs/Z6epMpphkuEniw1HCHCL+4NXbZmgAkPntwz5ctZOt5uN9A8VbnhkLzC3TO
         sRKA==
X-Forwarded-Encrypted: i=1; AJvYcCUTtOoH5R0dkqKfsDEhCmpa2ohHJMEaTFCQE10nWBCfghNDpXyTgGSV/VZKx2hxV86oEMmCjN3nWfLS+gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywck82Opy6dtdZMtnssE6T1NG03Dkgnttqo1uZiX98Q8xlDJoiB
	qLa2zTDSUWMVmC8J0kdzIdfJJe8UadqwrIYi2iuI4CQnoO3lZtVtbLLRS8V62MbeYD9mqAKl+1v
	VKW9vSv9ItKcxwYlrBVaZXCKn1Iu0Z/YrjVJoMIh8p2A74adgr0bkKb/n6eQFWx9wtHPx5hMvmK
	h1nG9WOjQrugd0B/BgmSB8n20xfZsWFISOvp/51V9I
X-Gm-Gg: ASbGncsydaNSckgggKMWDqHCIM6ZOJRRCzre1yLq1usAvreSL8JNN+f6p4WfrxZxIUt
	VMaJYO/7RpoCTY6V7m6lBhcKU0YrvwUIRCMxVi60QPGRgCBENBxq5NP4mryuvIoBWfIA7FC65kZ
	lqD85G81YbEiT8uUCUHQjNQzctAsrP8U0vFatkOtxWWq4VBb5YFPoYTwZXWqdw9HvV1cS2dd8=
X-Received: by 2002:a05:6122:3707:b0:537:3e57:6bdc with SMTP id 71dfb90a1353d-557cf0ca71amr1998852e0c.12.1761414851364;
        Sat, 25 Oct 2025 10:54:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgJOnM4bluQ6E9wHerRSTuFkaWRsBJjcnsXXzTai3J0SUYVYp4MA0v1jkm9r0t070IOxhPmLZo8Pqr0ynFtfU=
X-Received: by 2002:a05:6122:3707:b0:537:3e57:6bdc with SMTP id
 71dfb90a1353d-557cf0ca71amr1998840e0c.12.1761414851050; Sat, 25 Oct 2025
 10:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024084259.2359693-1-amarkuze@redhat.com> <20251024135301.0ed4b57d@gandalf.local.home>
 <CAO8a2ShRVUAFOc7HECWbuR7aZV0Va3eZs=zxSsxtu0cMvJmb5g@mail.gmail.com> <20251025105944.1a04e518@batman.local.home>
In-Reply-To: <20251025105944.1a04e518@batman.local.home>
From: Alex Markuze <amarkuze@redhat.com>
Date: Sat, 25 Oct 2025 20:54:00 +0300
X-Gm-Features: AWmQ_bn2KbQ7u7-I7QWQqLSntYdpaNFjyE6UUX-03Ig8JKgRbXdxkCbCcGhJeXw
Message-ID: <CAO8a2SgZ8gZ0VdtBAeW8wLMDxa+Eq42ppr-99tUpiu3Tpwqz5w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] BLOG: per-task logging contexts with Ceph consumer
To: Steven Rostedt <rostedt@goodmis.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	bsegall@google.com, david@redhat.com, dietmar.eggemann@arm.com, 
	idryomov@gmail.com, mingo@redhat.com, juri.lelli@redhat.com, kees@kernel.org, 
	lorenzo.stoakes@oracle.com, mgorman@suse.de, mhocko@suse.com, rppt@kernel.org, 
	peterz@infradead.org, surenb@google.com, vschneid@redhat.com, 
	vincent.guittot@linaro.org, vbabka@suse.cz, xiubli@redhat.com, 
	Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please correct me if I am wrong, I was not aware that ftrace is used
by any kernel component as the default unstructured logger.
This is the point of BLog, having a low impact unstructured logger,
it's not always possible or easy to provide a debug kernel where
ftarce is both enabled and used for dumping logs.
Having an always-on binary logger facilitates better debuggability.
When anything happens, a client with BLog has the option to send a
large log file with their report.
An additional benefit is that each logging buffer is attached to the
associated tasks and the whole module has its own separate cyclical
log buffer.

On Sat, Oct 25, 2025 at 5:59=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Sat, 25 Oct 2025 13:50:39 +0300
> Alex Markuze <amarkuze@redhat.com> wrote:
>
> > First of all, Ftrace is for debugging and development; you won't see
> > components or kernel modules run in production with ftrace enabled.
> > The main motivation is to have verbose logging that is usable for
> > production systems.
>
> That is totally untrue. Several production environments use ftrace. We
> have it enabled and used in Chromebooks and in Android. Google servers
> also have it enabled.
>
>
> > The second improvement is that the logs have a struct task hook which
> > facilitates better logging association between the kernel log and the
> > user process.
> > It's especially handy when debugging FS systems.
>
> So this is for use with debugging too?
>
> >
> > Specifically we had several bugs reported from the field that we could
> > not make progress on without additional logs.
>
> This still doesn't answer my question about not using ftrace. Heck,
> when I worked for Red Hat, we used ftrace to debug production
> environments. Did that change?
>
> -- Steve
>


