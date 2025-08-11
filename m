Return-Path: <linux-kernel+bounces-763656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0A6B2184E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 00:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6DB463151
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035EC2E2856;
	Mon, 11 Aug 2025 22:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VQmJ9bwJ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071E92253FE
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754951005; cv=none; b=VYmZ6WkSRlS/dDN3FqbtBzopW+rZTWCL+fDbTbkiY74Hc3GTftQJ1O7T9fE8r63XQffN7bAhaaxnMqc15UV0ADQD/eFJlVBkpwywsiDtlVR97Y0rULNZzB5ecKjBp+StR2oOtJVHXoNtGkzNZziKfRVZLDb16FpGQ3xVEg3Cvgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754951005; c=relaxed/simple;
	bh=UkjdFhfkD/5MPGo9lrvJIpAtslR7NzBNQeU9GjEIVS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8bCRZj3HeYIoSNDGmuDuT4wFF56eCmRn3oKHUHhjmY2el1o2ag20oaKasD9yacdsIf1sLn1s/PqwwDF72gbYmtyQjqt383gegpsh5C9VFkBK5kEb5f3VS4UKD+llqolK4zw0oYevFonW/CFs28XNyIoMQ3Jq26tlpkfpjq3syE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VQmJ9bwJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2402b5396cdso30259385ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754951003; x=1755555803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqRVwbRElxBdPXk8lHsckCVjfIRqkrurOlwpMKEN7BE=;
        b=VQmJ9bwJjq7NqmL65iNeFkBh+Ge9NCFhKyWZftypmXP+/uAHG7wQm/Zgf6FMKYZS+z
         +tTMy9gQLYG0PnpKM7PVHR53L2E4L0Gd19THj1TyLej+OoteZXFT5PnJB1o11MSUN//b
         YgQAvGypyDjdlH2JwcZpita+BDoyBG4siomr9xQnyN90PL2aGnQxGqe9HUO0C0mBJ9Cq
         tGVOzW/risvTcO3fROub+p7EULiCTtv8dxBOy/AP+H1yBRSaYsZ1y/IysT1MmTtx/SWJ
         RVq80ogNIMh5xCAbvljTyJNvU8YT+9XzmyOkdvFa/e+86b8TCohnJR6dwhqK+UA/xqUf
         zTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754951003; x=1755555803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqRVwbRElxBdPXk8lHsckCVjfIRqkrurOlwpMKEN7BE=;
        b=pVGyhVQQ7DE8vLbFS9BF3b7jJ6GR2VS4fzOIfAFPoqBkErKaBYQC4lJUa+RgypkkBw
         44/hzu4cS5vf4An5S/9jvGb6rkSxrboVC956zsaD7GequB6fUjVgzfa1QsODM4WD8seZ
         Wc9Nxz1rE67khDiA9AmHh4vA5UMLrIz3wjRzLJ1Hm1n7KkXxrV/jvpAUTmXoh5lPIKew
         IihJfdzw8Q6pk6Oo8o/QhBRN2r7rubuOFwiCXMLkQtl3UjLXNrvsCxWV2iiI5+289nKK
         umT7fzJ8LITimTQTP9m+ZKoPMFuV50uAo9Ujz2N/FNeM3Jk59VpP8xFgtOG4iezwWBFd
         enBw==
X-Forwarded-Encrypted: i=1; AJvYcCX/JkS32fFewMPM3iHabVw3SaBWJdl+cA99VKm6KxpdnmYj4rGws61xrBrdhnR4a6l69juPAJ0XHHL1Z6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzUMKYUlrElz/7VzlEtdsNjeFp9ce1fK5bcHeQ2VEw5X47BvlH
	UjeskCpVbKMPMk8KHVXNa7GiS3F8mjzusZom4u2zTOIHye8sQsuz1Jv74fHv69+ebHgpPRi7QJb
	sqGJt6RpKtuR1UyN45uluxxDELpUZdFvqXzVc3mkk
X-Gm-Gg: ASbGnctM1UbtekkNd552WopBW80WKK1XVXDLXeYS9nLgJfvGiSSS/7QGrjdufe4zqp8
	lxfyRZz54P//7gcOzYYeNeBCWhyeZ9hCCsTc8QFk0iiDdecwIh7r9j1czl2BPbjvPJ66grSh4m5
	QpT9HbbFqyQATSpyWunPEWgpcfCMqjwLuIMcuX5fufNRfMgfnfEJ857wyt4WdQeA6JkLputrmUZ
	p9DrSY=
X-Google-Smtp-Source: AGHT+IGOFn6nK9TXlaa8CkF00jvK01f6MUwhUi89/qVrrGCFQDmatsrEWgtc5jXmtyHYczNSCnTUlh5awjVGJA2HI2M=
X-Received: by 2002:a17:902:ea0c:b0:23d:f986:6472 with SMTP id
 d9443c01a7336-242fc287481mr14184195ad.25.1754951003328; Mon, 11 Aug 2025
 15:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a18a0b1af0ccca1fc56a8e82f02d5e4ab36149c.1754063834.git.rgb@redhat.com>
 <74767dff9834360b2100907df5142ab9@paul-moore.com> <aJSyXpsVfU+PfFzN@madcap2.tricolour.ca>
In-Reply-To: <aJSyXpsVfU+PfFzN@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 Aug 2025 18:23:10 -0400
X-Gm-Features: Ac12FXzlcanNoS7j2e973OwKiT9rlNsc4IrrFZzGeXXhu4-6krmOTM7sf1LTA6A
Message-ID: <CAHC9VhQY_0wm_Wz7HD0wv0Xc_Pikv3FNtw4_ppGSYLyyKdFJWA@mail.gmail.com>
Subject: Re: [PATCH v2] audit: record fanotify event regardless of presence of rules
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>, Eric Paris <eparis@parisplace.org>, 
	Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 10:04=E2=80=AFAM Richard Guy Briggs <rgb@redhat.com>=
 wrote:
> On 2025-08-06 21:47, Paul Moore wrote:
> > On Aug  6, 2025 Richard Guy Briggs <rgb@redhat.com> wrote:
> > >
> > > When no audit rules are in place, fanotify event results are
> > > unconditionally dropped due to an explicit check for the existence of
> > > any audit rules.  Given this is a report from another security
> > > sub-system, allow it to be recorded regardless of the existence of an=
y
> > > audit rules.
> > >
> > > To test, install and run the fapolicyd daemon with default config.  T=
hen
> > > as an unprivileged user, create and run a very simple binary that sho=
uld
> > > be denied.  Then check for an event with
> > >     ausearch -m FANOTIFY -ts recent
> > >
> > > Link: https://issues.redhat.com/browse/RHEL-9065
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > > changelog:
> > > v2
> > > - re-add audit_enabled check
> > > ---
> > >  include/linux/audit.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Merged into audit/dev-staging with the plan being to merge it to
> > audit/dev once the merge window closes.
>
> Thanks Paul.

Now merged into audit/dev, thanks!

--=20
paul-moore.com

