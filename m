Return-Path: <linux-kernel+bounces-674554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A806ACF116
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 15:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F893AA87D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 13:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D17E25EF9F;
	Thu,  5 Jun 2025 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="If0rd5Yz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DB125E827
	for <linux-kernel@vger.kernel.org>; Thu,  5 Jun 2025 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131010; cv=none; b=W/ldv03O4XKqq8jVobgPoIKQCvQs/U54UmduViKIa3Coei47TSGD+9NRugiw8CNqbXgB0riuDLu4HBZAugKMGyLl0KdN2EFyi10ZIqGabIIKpbRoMgNPsL2Eh/GoJlOx0aBTcqJ0W0Py86Dc7duCXnGH5R0eibc6LJAIRfQEOGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131010; c=relaxed/simple;
	bh=Ibr9kab54z+bb8Bbxb6yjOzT0aoFx9OQrLydi6uSjbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g1oTPqr5CKjDOxqWC1ZpqrUP4TduxR3pDoF0Y2gii/wvOiJkDDGB/02rq6ZxGE82/3SI42r9vgKjLoJo7R3AEdkWSGLkXCArJ+1TLwa75xfcP+O3wvps/EG8RjcWeu6k/jCnZR3pWTNzyTGlDqCf9xhTZGBbuBmkrmQ3KLdmFlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=If0rd5Yz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749131007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WyJG+3VB/l9E5cKEG16NYCx4C/OXUyDFX/570MgrW70=;
	b=If0rd5YzEzDyvhxF/zINDSBNo61SMiB/3PH1vYJ3J5BSYkpmvpb88v6w+IATjs4iSwGm+u
	8sXWpHZHTB2aQasq/JtnhUcjknQPT2d3qnvsWZ1BM18/TrTSCSHlh78ZpVXDP/9ZNTpDB8
	63DWtFjv2HDXfW8ydXwHVleOmIeTnYY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-XGDbriIyM5mV7fj2yW2Rug-1; Thu, 05 Jun 2025 09:43:26 -0400
X-MC-Unique: XGDbriIyM5mV7fj2yW2Rug-1
X-Mimecast-MFC-AGG-ID: XGDbriIyM5mV7fj2yW2Rug_1749131005
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4eec544c6so502569f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jun 2025 06:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749131005; x=1749735805;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WyJG+3VB/l9E5cKEG16NYCx4C/OXUyDFX/570MgrW70=;
        b=k61vvgHxOnGkjzQT5kNJf1ifHDI1cCWUf/P0EqNJC2w1sv7aJZOzv59Pn+U3+NLy1s
         7n+q3UjO3BZs4thjhCnrlPupALWcufcuXa83uAzQd4c5LAiSY92PxoM+SndCDJsjAGu5
         U+ld9PiuV8f23bSvGh2ot2swQTnjc+04f+YnTWFM81wR7lte+RqWVcmAXkioPWgkrmq2
         e0VZ9SAUPs9D09QhJK/pNWWhngLkRAPtYXQQQtaK1IeW+XH6/OL/EI23fse65QM16kJP
         Ssf6tWiUCXKIRXweBVnIet6KTf7RQrXVJT9IRI8T+HYkA6Eo0J8bBaf2hUgCrG89CZso
         BM6w==
X-Forwarded-Encrypted: i=1; AJvYcCWcSChrigG5nItnndkida18knMjOddEbn4ezU/1Qx+pDmIYQsL2v66KxbO/Fwo0+8MJqf/PbRhjG6EPwiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Tw7LObBHH1CHGvQCZSjk71TLqOYewg9aPchL6xniakevVOhk
	exFh7kCIR1novl1sATObdiUdXbl6K6wIE7qWyhSERLSJxVVVXWDiLjyKisgRjoHR7POgr/N9zY7
	LsWzqcBPqtfu0JUVaVqvaHntUrIpBeZpCg6eRcgw+Vl0PW2zBr9ipKyIDgSErOqKFLw==
X-Gm-Gg: ASbGncuBtg7sAlwO+wOA4hKLHg2tvXQpRJ6QnTVIXQKFWIWGc3pUMrIdpjjbFLsGz0o
	VKIl06Kv40JKwF7oJUZlxNelTa1degTYNFXU2YpLf1kuB2jAqRwpQmLsb5e8vgJq5qis8lhWVQQ
	ZucgWU/Ej6jBwN63z1KH+M1x4xQy/e5vt/ewIc6WtK73EzH0riP2xCxgMx+VFKCwW7FBlchnoFd
	21qiKgPEW013EJGsf0CXTwh4HScWOyAeSIWoy5h2HgF/BdWcXUzRQo5Ix8hBgItHa2LRbYwHviA
	Q4/vHWH8NpzmCW45WA==
X-Received: by 2002:a05:6000:144c:b0:3a4:fc37:70e4 with SMTP id ffacd0b85a97d-3a51d97408amr5757690f8f.58.1749131005257;
        Thu, 05 Jun 2025 06:43:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH06+3a1Kbk78BFgL3ZwbDTDTsWsomlMTVTUM+GFt6c6uDgEbkD9kGtXYidxIou37MFPIzdSQ==
X-Received: by 2002:a05:6000:144c:b0:3a4:fc37:70e4 with SMTP id ffacd0b85a97d-3a51d97408amr5757647f8f.58.1749131004775;
        Thu, 05 Jun 2025 06:43:24 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b8f0sm24267394f8f.6.2025.06.05.06.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 06:43:24 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Eric Snowberg
 <eric.snowberg@oracle.com>
Cc: "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "linux-modules@vger.kernel.org"
 <linux-modules@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "keyrings@vger.kernel.org"
 <keyrings@vger.kernel.org>, David Howells <dhowells@redhat.com>, David
 Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Luis
 Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami
 Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, Peter Jones <pjones@redhat.com>, Robert
 Holmes <robeholmes@gmail.com>, Jeremy Cline <jcline@redhat.com>, Coiby Xu
 <coxu@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH RFC 0/1] module: Optionally use .platform keyring for
 signatures verification
In-Reply-To: <e4e838d03b3619df5523d429e0cd8160a8aef9f8.camel@HansenPartnership.com>
References: <20250602132535.897944-1-vkuznets@redhat.com>
 <0FD18D05-6114-4A25-BD77-C32C1D706CC3@oracle.com>
 <f0b37bc55ed3c02569c74f0fbdb6afa8efd329e2.camel@HansenPartnership.com>
 <87zfemoc76.fsf@redhat.com>
 <e4e838d03b3619df5523d429e0cd8160a8aef9f8.camel@HansenPartnership.com>
Date: Thu, 05 Jun 2025 15:43:23 +0200
Message-ID: <87tt4unw1w.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> On Thu, 2025-06-05 at 09:54 +0200, Vitaly Kuznetsov wrote:
>> One additional consideration is the fact that we already trust 'db'
>> for dm-verity (since 6fce1f40e951) and kexec (since 278311e417be) and
>> especially the later gives someone who is able to control 'db' access
>> to CPL0; a 'db'-signed module (IMO) wouldn't change much.
>
> Well, the kexec case is because kexec has to verify the new kernel as
> shim would and shim would use the UEFI keys.  The dm-verity one was
> added for a cloud use case by pressuring the maintainers in spite of
> the objection to using the platform keyring (it went to dm-devel only
> so not many integrity people saw it):
>
> https://lore.kernel.org/all/20240617220037.594792-1-luca.boccassi@gmail.com/
>
> The point here is I do think the cloud use case is legitimate, but it
> can't be supported simply by ignoring the bare metal security domain
> separation concerns of the integrity community.  The argument that
> distros have done it so it must be safe isn't really a winning one
> (especially as there's no clear explanation of why they did it).  So
> either you need a better argument or we need a way to support both sets
> of communities ... which is why I was wondering about a runtime
> differentiator.

So far, I got two 'runtime' ideas:
- Observe MokListTrustedRT and distrust .platform when it is
non-empty. This can, of course, be combine with a Kconfig for those, who
do not want it at all.

and/or
- Sysctl toggle. Keep things as they are by default but make .platform
trusted (either for modules or for everything) when switched 'on'. This
can (optionally) by combined with a previous idea and have e.g. an
'auto' state for the toggle which follows MokListTrustedRT.

-- 
Vitaly


