Return-Path: <linux-kernel+bounces-856394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1E4BE40AA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82A134EBE60
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721863451AD;
	Thu, 16 Oct 2025 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kcIlKG7s"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD78343D97
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626618; cv=none; b=T+HNg/J8ir/Sjic8ee6W85a+eZoMOPTV2vWiN3JO6Los+ii9F43Ziycv33FUO2tPNSMV09djQ7Lmp6V3hyKyfRfl/TqQUdSMr6XJ7IbrtDWyqYMatoFv9GHp+Md0owYoICRpzcI+8JtLgVvof5gWSYBw0DtqamfXoOiKbGOMPZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626618; c=relaxed/simple;
	bh=kicW/IxTSwb37jIvvx2fhfICk9Db6NVXk41X/MPzS7s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ATGZ2cqxVicbWQJSLKBSQ5v99FKisurFN4zv95IZR+iBY+vIn04gFM53h0qNoGwzU/cUw2hqK2H6KzR92E7a0ricm6weuOVh6vo63kt+dZElquHR2NKdQoLePgq2gIYhWdhc/s2mgdROf0eIfMP4bmX5TIoENM6hbBFO5dg6SCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kcIlKG7s; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-639de61a425so1287888a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760626611; x=1761231411; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v95TRU50K/iONp5JVhA52itWoGS0vrXV0XcMvuar1+E=;
        b=kcIlKG7sgfyaBGYotVZbhjfMe9hpEQ3/ESLtCGPU1YUEIr4GLNdWMIPJ56cYwQ7Gan
         0AvrXgdnPoF+Nm5dlVrOjgOsSfEp+hiII9htEnIFqHd2JEiPJCOOH/F6YHPVV04MUWgq
         EAyDqgXiIPLXqJD8UZ7iHxoX3/kj0NnhwZpYAtwI24ZRkVCJZ5Rwf69G/ggT6wTiwet1
         WK9B1rbTTzocK1zZ6SQc6eg5uLhhQUCakHiThYo7wH1OsfNIGVaHrVDmGdQTZEux0+Ae
         PtM3SzXPbC9CYOwo+R9iAvKBRgkvOJK2ulJ3Pn6QhY35/iR+EUJttqeOMjxHXZQlHi+s
         RNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626611; x=1761231411;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v95TRU50K/iONp5JVhA52itWoGS0vrXV0XcMvuar1+E=;
        b=iBZbcd5GTtRthWPCja/1sdirhUC4Koy5+WyOlsZ+ba7fclhRKBrD8CKX+Z3SIWyea6
         AnT8r3n8zTQNhJcbWIGYqjS47Q6U7LttIDuJmVHP6SEh87KnZvbN8wL4SEHbd/tqKFuw
         Ck5jiMHS5eMuCPfwlL6JsWyUWAMeQpdQR+guGVL7f8C0HkWYuxFTx9FSCuXHJ/ggyIfT
         EmzyCarSnvbvLqhy5KrIhLQD6OB0tQcc+D9CNxKGAO5gdVSGiISBsLg6RqerPqjCeLvP
         cqN9HSBsAMtgD5shqgt9WjS0J4OLK119dJGV4HbtgCsjfhdJAefATLCEz794rLtcQJEy
         L7HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYZ4GJZptdVglFpULoIJuDeO3Uxyx8wPj6635lOejj9x+SAboyH1Y7huVS4I+/TagoqmFkCjLFptEufxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr4S3+tU0D01zTAV2IH8F6DvI0zmzAZYMFMq8uBpg+SCVhRVq2
	tofVXUXIcRO92iwRMlgSOeKRjlvbVugXI4s+zhftW5FtVRc4zO2qQyKQH7f+VVACwA2rMIkvbWM
	kJpvX4oW0O8qiEg==
X-Google-Smtp-Source: AGHT+IF+tkDF/7Qunb0b14zXeq/ywv4RNeY4BjsXE5Yl1BIu5rViAwZ4zcI1oKyFXjSGqxSVVyW7QwVEl06auQ==
X-Received: from edt17.prod.google.com ([2002:a05:6402:4551:b0:63b:fc78:ee0b])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:cfc9:0:b0:63b:fb27:9314 with SMTP id 4fb4d7f45d1cf-63bfc7a22femr2902726a12.0.1760626611092;
 Thu, 16 Oct 2025 07:56:51 -0700 (PDT)
Date: Thu, 16 Oct 2025 14:56:50 +0000
In-Reply-To: <DS0PR12MB92739B4BF6D4F35250F1B44994E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013143444.3999-1-david.kaplan@amd.com> <20251013143444.3999-8-david.kaplan@amd.com>
 <DDJRFMTS5HX9.3MT8W88VM4U2I@google.com> <DS0PR12MB92739B4BF6D4F35250F1B44994E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
X-Mailer: aerc 0.21.0
Message-ID: <DDJU1MUCPR2J.14W8SU21KQK4F@google.com>
Subject: Re: [RFC PATCH 07/56] x86/bugs: Reset spectre_v2_user mitigations
From: Brendan Jackman <jackmanb@google.com>
To: "Kaplan, David" <David.Kaplan@amd.com>, Brendan Jackman <jackmanb@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>
Cc: Alexander Graf <graf@amazon.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu Oct 16, 2025 at 2:06 PM UTC, David Kaplan wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>> -----Original Message-----
>> From: Brendan Jackman <jackmanb@google.com>
>> Sent: Thursday, October 16, 2025 7:54 AM
>> To: Kaplan, David <David.Kaplan@amd.com>; Thomas Gleixner
>> <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>; Peter Zijlstra
>> <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; Pawan Gupta
>> <pawan.kumar.gupta@linux.intel.com>; Ingo Molnar <mingo@redhat.com>; Dave
>> Hansen <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter Anvin
>> <hpa@zytor.com>
>> Cc: Alexander Graf <graf@amazon.com>; Boris Ostrovsky
>> <boris.ostrovsky@oracle.com>; linux-kernel@vger.kernel.org
>> Subject: Re: [RFC PATCH 07/56] x86/bugs: Reset spectre_v2_user mitigations
>>
>> Caution: This message originated from an External Source. Use proper caution
>> when opening attachments, clicking links, or responding.
>>
>>
>> On Mon Oct 13, 2025 at 2:33 PM UTC, David Kaplan wrote:
>> > Add function to reset spectre_v2_user mitigations back to their boot-time
>> > defaults.
>> >
>> > Signed-off-by: David Kaplan <david.kaplan@amd.com>
>> > ---
>> >  arch/x86/kernel/cpu/bugs.c | 13 +++++++++++++
>> >  1 file changed, 13 insertions(+)
>> >
>> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>> > index 1f56ccb5f641..4ca46f58e384 100644
>> > --- a/arch/x86/kernel/cpu/bugs.c
>> > +++ b/arch/x86/kernel/cpu/bugs.c
>> > @@ -2056,6 +2056,18 @@ static void __init
>> spectre_v2_user_apply_mitigation(void)
>> >       }
>> >  }
>> >
>> > +#ifdef CONFIG_DYNAMIC_MITIGATIONS
>> > +static void spectre_v2_user_reset_mitigation(void)
>> > +{
>> > +     static_branch_disable(&switch_vcpu_ibpb);
>> > +     static_branch_disable(&switch_mm_always_ibpb);
>> > +     static_branch_disable(&switch_mm_cond_ibpb);
>> > +     spectre_v2_user_stibp = SPECTRE_V2_USER_NONE;
>> > +     spectre_v2_user_ibpb = SPECTRE_V2_USER_NONE;
>> > +     spectre_v2_user_cmd = SPECTRE_V2_USER_CMD_AUTO;
>> > +}
>> > +#endif
>> > +
>> >  static const char * const spectre_v2_strings[] = {
>> >       [SPECTRE_V2_NONE]                       = "Vulnerable",
>> >       [SPECTRE_V2_RETPOLINE]                  = "Mitigation: Retpolines",
>> > @@ -3844,5 +3856,6 @@ void arch_cpu_reset_mitigations(void)
>> >       spectre_v1_reset_mitigation();
>> >       spectre_v2_reset_mitigation();
>> >       retbleed_reset_mitigation();
>> > +     spectre_v2_user_reset_mitigation();
>> >  }
>> >  #endif
>>
>> I think this might be failing to account for task state? E.g. if a
>> user boots with spectre_v2=off then we ignore the PR_SPEC_DISABLE calls
>> that would enable IBPB-on-context-switch for that task. Then if they
>> enable it via this dynamic interface they probably expect their
>> PR_SPEC_DISABLE to take effect retroactively. I don't think it will with
>> the current code, do I have that right?
>
> If I'm reading the logic correct, if a process tries to do PR_SPEC_DISABLE say for indirects but spectre_v2_user=off then they'll get -EPERM, so we don't ignore it.
>
> But there could be a case where spectre_v2=on (aka force), when PR_SPEC_DISABLE does get ignored.  And then if spectre_v2 is changed to something else like prctl then the relevant task flags weren't set.

Er yeah good point, my example was wrong but the issue exists to some
extent.

> Not sure the best way to handle this...even if we were to always set the task flags in this case, there could be other cases where the process might think it could set this flag and then get surprised with an -EPERM.  Open to ideas here.

Hm, isn't the issue of surprise-EPERM orthogonal to the task state
issue? I suspect I'm doing a bit of motivated reasoning here, but it
feels to me like a userspace bug for someone to infer statically whether
they should expect -EPERM here. Like, the docs don't say that much, but
they do say something about what the prctls do, and that doesn't include
anything about the _reason_ you got -EPERM.

(BTW, it's not relevant here but I actually think -EPERM is a bug [0])

[0] https://lore.kernel.org/all/DDJU0415JEBQ.H2SD942NMDWX@google.com/


