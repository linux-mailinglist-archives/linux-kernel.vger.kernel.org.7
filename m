Return-Path: <linux-kernel+bounces-723934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B9AAFEC91
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EED45615B0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D722E54D5;
	Wed,  9 Jul 2025 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qpt7XJRc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEFF2DAFBB
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072595; cv=none; b=Vn5st1z9CsH6G2sPgrAUGoZCEJq+lwoqySuTHi3srRWyhS+9fKCI4EZT4pNbui5+y36AuyIFOrAqmMZmur2NT4fcwzuydwwGHdApZvUFB6ybJ+qfnXXARPJZFroF7SL6+aJRSHD/3TRJo82tQhx55dEP1VDCkpMLPPBHg2W6LIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072595; c=relaxed/simple;
	bh=CDfig1Vs2OYQIKyFkHBQNLu5l47DCuM6T3Xm86P9MZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZC0yWN6dqbL4DOT5txlnV9hYsL0qKoQ9VIpV6oON4+otL9PZlYIIwpOdjcuoIUYIbqPSRHiZlxllF+kENM+h02Z8Dut34hbZWyt5ZPBr9vXpxS2d4sXBgWBYPbFrBT4OsIf4D96m+Pj6oJbh4zucH22g582KUdvD4jRp2nMc6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qpt7XJRc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752072592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CDfig1Vs2OYQIKyFkHBQNLu5l47DCuM6T3Xm86P9MZk=;
	b=Qpt7XJRcQRTbnzjQ5cQpUBD9uGZNWfgRUVbgKw66MvnhlpFMwabAg17ukJd9eDyeQoZwCQ
	Ttoo7CSuSVYQUjwel+dnTAJpRgLMQnAgaVs1j2k+t3q+JyYreryVpGZUucPLeK3MzcwCkE
	zG1plQpn0mgLMEjITIGmhcAbItb9Rg8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-BGiNOkPIOCWZqHeDhR4gvQ-1; Wed, 09 Jul 2025 10:49:51 -0400
X-MC-Unique: BGiNOkPIOCWZqHeDhR4gvQ-1
X-Mimecast-MFC-AGG-ID: BGiNOkPIOCWZqHeDhR4gvQ_1752072591
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a43988c314so95137381cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752072591; x=1752677391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDfig1Vs2OYQIKyFkHBQNLu5l47DCuM6T3Xm86P9MZk=;
        b=UcEqWyePfQtbDnsgyinU7N8sP7qP8bHC7/aMx1GbGMvxq7nRamUF+ONB2w24p8idA3
         5Yr1o9UInGhYEqasCNVxqgAA+mZX2Yl4lOaAsYyzGi79g0Ue4ErR9vPNTM3vKqs1FBCd
         7mj1ToFYlCaQNCTvQSdozQBsyv3NRxfU3f13XvRsIf0V3+l94k6aZGRE++eJBL32IKC0
         kLV6q5SGDDeht33WVvin634Kf2aXuuQFcK70CLN8RMd/K7JPw7iniGt6uoB8yvKbm3nc
         hpbF6F9DmQWGkDRJIZVNmh/3RXsPbj4/gq+/vFP82LNMYe7SfPuKOwCX6S9B+A2htIQC
         8HQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9gqhQPaG8EHXpFYUfvbRDCJ6gZXt2fSTpALvPwQ+R6T6sHYOc7/eJaETKFS4EKSfiwYKXZWI/D3ZjSq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGXESr9tmJJ7+9Ck4ch4VkwP7rS4L9I8rXtGqizUjGy+HB3f0l
	0u1JWiWP4IwYAWD7GimVMiltekCUtDiHlCqr1AHEBjq2I4c4cYF1Jk9Ua7W89lwwNCz38A88BWs
	OiJ/nVZws17UM2UNnrhON0agTSZt26Kt5qp8XtHpmuLrhUy5A+O/DhupAXR2CRh0lnO7rDdKbVE
	nm5fOQpFIW5D3chO4ZVWNnaQmWHXhrksqhM2FJZJg0
X-Gm-Gg: ASbGnctbN0vV53bMJgDVq+/0n22MNmMlKTfCEcQ959rdXTp5ehY1yXxfkiHXlYPcH3G
	G9hnf/zpCRK4QkGSWGDs9vpcdt9VNf4UNKQb9VNnDGd2O6dnwYN+3Q2txmHiWTuBndOiWSZ4O3/
	eC8ftHNRI6vEdparmCinXiM8Wq5Jk8IGH6pTU=
X-Received: by 2002:a05:622a:1101:b0:4a4:3b2f:cc30 with SMTP id d75a77b69052e-4a9e92faca6mr100401cf.11.1752072590690;
        Wed, 09 Jul 2025 07:49:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxoTgrN0uV1FyvH78vCowCYgJSBaifp6bq9xohfH2baiCbJ0gY3aYvPlS/LGW5BiAxJqrcqI4sySU3oZpk/04=
X-Received: by 2002:a05:622a:1101:b0:4a4:3b2f:cc30 with SMTP id
 d75a77b69052e-4a9e92faca6mr100031cf.11.1752072590350; Wed, 09 Jul 2025
 07:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620085618.4489-1-gpaoloni@redhat.com> <20250701195939.3e297e20@gandalf.local.home>
 <20250709100626.fc0611eb6801b7a8dad9164f@kernel.org> <20250708212539.054a7d5b@batman.local.home>
 <CA+wEVJab6Gwkd7q58=v8uVhfmKpwNRAqtK67f15JtZcKSB_ziA@mail.gmail.com> <20250709101216.5949e86f@batman.local.home>
In-Reply-To: <20250709101216.5949e86f@batman.local.home>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Wed, 9 Jul 2025 16:49:39 +0200
X-Gm-Features: Ac12FXwwCZqMDFTyYYFREweJbRjIa_PWtDKIGBqGPHwVX_GVTlz4BsfGHZMs6Qk
Message-ID: <CA+wEVJZRFGW-8-FT9qJJcaWZ7So+tFeAdyupoOMG4ev_8Cpqdw@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND] tracing: add kernel documentation for
 trace_array_set_clr_event, trace_set_clr_event and supporting functions
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 4:12=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 9 Jul 2025 15:35:50 +0200
> Gabriele Paoloni <gpaoloni@redhat.com> wrote:
>
> > > Hmm, now here's an interesting point. So this is to define requiremen=
ts
> > > of a function based on what the function is doing. But does the
> > > function have to have strict requirements?
> >
> > IMO one of the main goals for these requirements is testability.
> > In order to have testable requirements we should state what the
> > valid input values are. In this case:
> > 0 -> disable, 1 -> enable, everything else -> Error.
> >
> > Now checking the code again it seems that the switch statement
> > is missing a default "ret =3D -EINVAL" (or else it should be changed
> > to boolean, but I guess it would have a wider impact on the rest
> > of the code...).
>
> Well, it's mostly used internally and the only places that call it uses
> 0 or 1, so there's never been any issue.
>
> >
> > >
> > > If it can handle "0" or "!0" does that mean that's how it will be
> > > defined? Or can it just state "0" or "1" and yes "2" is UB. That is,
> > > it's not part of the requirements but if someone passes in 2, it coul=
d
> > > act as a 1 as it's UB and implementation defined. Not a requirement.
> >
> > Right now if 2 is passed the function would silently return success,
> > but do we have a use case for this? I am trying to understand
> > where the implementation defined behavior would be....
>
> The issue is that all the callers pass in the proper value, and that
> can be easily verified, but by adding the "anything else ERROR", it
> would require adding more code that is not needed.
>
> I rather just switch that and soft_disable into a boolean than to add
> superficial error checks.

Many thanks for the explanation. Please consider that, from a requirement
point of view, it is also perfectly fine to document the assumption of use =
that
no other values than 0 or 1 shall be passed by the caller (so the bool rewo=
rk
can be avoided eventually).

Gab

>
>
> -- Steve
>


