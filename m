Return-Path: <linux-kernel+bounces-879641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7494AC23A35
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED82834D26C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1839431158A;
	Fri, 31 Oct 2025 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGA80Tet"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2AA2ED85F
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897620; cv=none; b=qo/JlV1kZPcVMWf55mAxlnXQU8pmkPW72Uyf3CmFMwAtlw7Er/fL/aRVZ78eykHnRrmXwfXyu73+A4FZjOyv6zYl0NzStR4C65n58/7St2zMJZ2k+GQkRHK+nGF4B8N6QKxx0HFGQPHXoBqvhG9yWC5FY95CAmDHZ057KFzqn8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897620; c=relaxed/simple;
	bh=lB66Wru9u8c0qnRy/70ZKohUPZs+4FPyI3uKveKSmO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5C0+CVSr2L7uty0jZAy8THGK77eg5Pr8YVbYIYRpN7qKYOtgg3v7jP6r9H1kW3TTrZ2WaJVHaBJgTdgGgbS2pBTKSFdn5mj534j1xopUoQF/BQQnkZK6WiOy5i34XJ1fYMmOUfxjITBu1fzTem4ToRCeiq1jKOvB7Aayf4AoAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HGA80Tet; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761897617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Py1md6slarrM8D1qGHaVb4pyrrj+/8Hoqbx6eKekEk=;
	b=HGA80Teto6e27vCj1SjOi+n8g9EEJSQDHsa2JaHrHkxuhNcQg1J4WOh6HhpmBli5wUFMAI
	sdXlnCzRWV4Jnaoj+cSaptENzOlcJdb6gIkK5CYWo2/wmxYQWjpHbkz7BO0umXbUmtEHc8
	fZ0wfnCHA8FJqBLP6zTodWhGU2QEJUI=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-y8cb7G17NyCMD4JbAIh-Lg-1; Fri, 31 Oct 2025 04:00:16 -0400
X-MC-Unique: y8cb7G17NyCMD4JbAIh-Lg-1
X-Mimecast-MFC-AGG-ID: y8cb7G17NyCMD4JbAIh-Lg_1761897615
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7a264d65dbeso1677221b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761897615; x=1762502415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Py1md6slarrM8D1qGHaVb4pyrrj+/8Hoqbx6eKekEk=;
        b=WaQCEfoPGRfUYeDOUUNZu7Npp1zLPA7nSITUmojEzB5l5fK7m66yU5bHTfDff8Vbro
         tq2Y6ctW3M74MlUYRVBg7zTsUBYsOr0N42o2rMQIuPqdItHdeVqMUNE+20TE7fp9UTMy
         Y7b7vaKAYkhik5gaNAXGyCQmoOlW7hGFKP9/2YLKpsxQe4+Sk336FR/Roo5aB0U/wBtM
         w35hJNHaAJfHBxPkjYokX2U9C2F3q3nCUNYsveBIXKvnkNFy1TNBpLo4CgcxTMpcSqt0
         mDf74YfeAmqUueEd21MIiS0r2ddzWd07VwLaKPGQ/Tzy8oYu3zb6kHXtrcaBgtUnsuRM
         yd9A==
X-Forwarded-Encrypted: i=1; AJvYcCX7hAc3wHrOwTVas+fqRjsFwcLaX3kt5RIx4gwr08g4ndEq5dPT+GPk47oaB3+A+8P2bM5w9tgAnQ1yOc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU1LRpGk2isJqaMNrJziVWgxy9EWl49L8wXaOd/vhajHi9dgkg
	1jPTW6kbSuNe/nOEhJYXe7MR1zIElV6QSFgTIrOr5iIVb8drw70ccBNMvItCpHo+4V/qK43fW0Q
	LwcRWbd1rjsYg8QHB4DmGjBtcDldtXdN8KiYjkWfdYpQXPJHi+CW3SorfaZTZIL3xLw==
X-Gm-Gg: ASbGncsRHkiWMJNCTtFkC0SivPWhRDGj2pdlsrNmLLkx4d6KMQQ7LF7j0kyC0QDAgl/
	1wklh2Fb8YpsjF5DDV73zs8scSyC4kUC7mp2DIakfj67pFH9UCLQWhTfLgL+gNnB9lVg0IhtUHi
	oWN7BIR7VyU2TfuQLH0Q5wnhxpMj03ZyTxuniTZcJoq2z1y2PQX60tiEPQPC8pmaWuO3CP3lJJh
	0IOZHxIRU542reHZH7+n9icBc1toyMBApqY+m32zW5jCuO4ippctFamiQZw6KHGkd7m/5GdB3r7
	5e4rP+NqaaIpsACuHvbn0MVfPeqLd5gOvWt8+ajo+3Kl3IC1fkrpdbjG8u/M+WfYnA==
X-Received: by 2002:a05:6a00:2e9c:b0:781:16de:cc15 with SMTP id d2e1a72fcca58-7a778cf3a96mr3521389b3a.15.1761897614740;
        Fri, 31 Oct 2025 01:00:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDLa7KGTb5wSf4W252Q0VnFRq/HtpgYqzeaYMwjIvkHvSdOsEAOc6ZNfr8cT8FHHmEHw3VRg==
X-Received: by 2002:a05:6a00:2e9c:b0:781:16de:cc15 with SMTP id d2e1a72fcca58-7a778cf3a96mr3521347b3a.15.1761897614194;
        Fri, 31 Oct 2025 01:00:14 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8982117sm1250591b3a.15.2025.10.31.01.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:00:13 -0700 (PDT)
Date: Fri, 31 Oct 2025 15:58:11 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Karel Srot <ksrot@redhat.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: Fall back to default kernel module signature
 verification
Message-ID: <wlc2cylowxiuvfvj2yizes364yr27i3um5xen7ilyd4t2i3xzx@uucsqesigr2l>
References: <9d279fd3d7b3cbb2778183ec777d6b9da8a64b82.camel@linux.ibm.com>
 <5bzredottmp2tdm3uebzjfqjr6c7bwssqkrbdqvudruvzr764e@37j6ycjci2sk>
 <27bb0c218084f51eba07f041d0fffea8971865b9.camel@linux.ibm.com>
 <z6f4getlayaxaxvlxfxn2yvn5dvhrct64wke4uu2s3dfll3bqq@754bklrku55n>
 <559f6ebf4a19da321fffc2a3ca180dc3d6216a22.camel@linux.ibm.com>
 <02d18fe0a0ca1223eec9af5c8e01739aa164bf32.camel@linux.ibm.com>
 <xldwpvz4gzp74kualadf2n2wdlpbo3xorrgvkibhdocjtroipd@dpukmalev4yu>
 <26cb0926bd707edea6f19ca1bf8f5d5d3d10ff96.camel@linux.ibm.com>
 <pbkvp4o4m3spjgvctapidfnsswakekxl2vyigqip6yyfzp73z4@rgbohq7h4nnt>
 <1fb245a0e72a360df3a768726351e7fa76301471.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1fb245a0e72a360df3a768726351e7fa76301471.camel@linux.ibm.com>

On Thu, Oct 30, 2025 at 12:50:48PM -0400, Mimi Zohar wrote:
>On Thu, 2025-10-30 at 21:42 +0800, Coiby Xu wrote:
>> > >
>> > > Another question is whether we should allow loading a kernel module with
>> > > appended signature but misses IMA signature. Both IMA arch specific policy
>> > > and init_module syscall only require appended signature verification. On
>> > > the other hand, we only allow "appraise_type=imasig|modsig" but not
>> > > appraise_type=modsig. How about we allow loading a kernel module with
>> > > valid appended signature regardless of its IMA signature? We won't call
>> > > set_module_sig_enforced but as long as we know is_module_sig_enforced()
>> > > is true, we allow the module in IMA.
>> >
>> > Based on the policy, IMA enforces signature verification. Only if
>> > CONFIG_MODULE_SIG is configured, the IMA arch specific policy does not define an
>> > IMA kernel module appraise rule. However, custom policies could still require
>> > both types of signatures, not necessarily signed by the same entity.
>> >
>> > The option "appraise_type=imasig|modsig" allows either an IMA signature OR an
>> > appended signature.
>>
>> Thanks for the clarification! If I understand you correctly, some users
>> may want to enforce IMA signature verification and we should provide
>> such flexibility. Then do you think it's a good idea to change the kernel
>> module rule in ima_policy=secure_boot to
>> "appraise func=MODULE_CHECK appraise_type=imasig|modsig" so
>> ima_policy=secure_boot can also work for in-kernel decompressing
>> modules?
>
>Yes, that's fine.  Unlike the arch specific policy rules and the Kconfig
>appraise rules, which persist after loading a custom policy, the builtin secure
>boot rules do not persist.

Thanks for the confirmation! v2 has been posted.

>
>Mimi
>
>

-- 
Best regards,
Coiby


