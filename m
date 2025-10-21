Return-Path: <linux-kernel+bounces-862542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FABEBF590D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8838C4FAFFB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C250630216C;
	Tue, 21 Oct 2025 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYxy82pA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504962E7659
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039761; cv=none; b=NI0OQk3o4xwGosbxkrgulddNIBWreZJGpJJGciAhgTC5cX/MVfv9j5wl0K4SAndwsC/LppzpXAaU5BgYd6zCPQ34fRxq0Aa9MeJt1TemAdhdwPWM5NGySa/OOlvm28dHj6WV9ML4lvh0o3RbyrwjsE77qnu6K6L8bOY2BzpDt08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039761; c=relaxed/simple;
	bh=MSVMapS+wT8A48mbedXknuF6hMRfcMnPOR8fjkLNzBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efdF7IpwQexQmrYeU9bfB3iNqadUl4QxLq3hmBE2wam6ECrh/RVv9wFaEy6xEYgEG8uoIUHB+kh6b1D3vDdaYKK03odwMN3NeMPpsTTyjK/J6IXFia/wYp7X7xP7XApco0OD34OdE9AMytbUd2GNmvyKwQKXcLVmqk4D4eHM4Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYxy82pA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761039757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UHjS/qyeeKcJ3eN+7yFgpurORtwwe8MoT2GpgobO51M=;
	b=cYxy82pA+fjtnSs8kfgHcNsl0wGBbBsMQRBG41ACA+7CSNb/OBrgqAsEvNwLN+uFxeSpKC
	vYQaljoIpmyKo7wWCx5axfcPv0WBde3JufWEFIttmhBsoZCjqcgvTBdiXpvwMOo+2s6ojQ
	47yTjQROpASezdVVcLzBmaTKGKh7+bw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-Q_rUA6ljOBu0yyCHh9PudA-1; Tue, 21 Oct 2025 05:42:36 -0400
X-MC-Unique: Q_rUA6ljOBu0yyCHh9PudA-1
X-Mimecast-MFC-AGG-ID: Q_rUA6ljOBu0yyCHh9PudA_1761039755
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8787a94467cso214131936d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761039755; x=1761644555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHjS/qyeeKcJ3eN+7yFgpurORtwwe8MoT2GpgobO51M=;
        b=wk6lzulnb9W8/A0f8tr9wxBoCYjIr2z4OWqr+gJFFpQfMRvl/98UUSw5NZDWzuknW4
         UxUMWGH7QFO7ppdp90Z47fW4wkB6ZLqcYKUmNj1xme24aWHmP+HMklDMW7lrVSQJ2HzG
         LoDCWbTiD5rS+m/k7Yd2RirQuw2t4ja4YQxRykv08kulm2R/6nze0sXxCUZjww/RpPSX
         m17pGqNerKn4Ebf6I7Zoz5S4Y54FdA7tFREhlOsxphFMsNgMmRHaiQu25m8LWNJ5NIjV
         wfX7dh9+CTOdqlmVIMIZLyveJKIuC6e1Px7v4zq6y+2GRKp88ClY9oxv7eFJzlTNB49Z
         PykQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUcl+9iFEPH9mdT1K7LwJjZ4Mvaou+w6l1IiuvXg8K7rvSgXwv8Lr3HeIqrU7W/x2PSEVrt9/PIzNjtnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZSLbQRpTiuyFqQUF0xr++OKEPj7EBysTu8+J2mVmlPLSN71Yi
	QIyMOxmFXzu3zVg96q6hIts+Im5hsNvlYgHOH+HzKtRF8sxWuzenER+bwDm8nj+uAKtfx0n8RA+
	QSjs1N078sWXzonjFePgZcKr7SNJYf53f27zjeRrE63wb6NwWqmIa42+vdWTHrSL3HUjNeddqpu
	Dcd3AzcAn32Xgz4R/diasgHG2eI6gUuA9w49H3XfJxjyV74h9X
X-Gm-Gg: ASbGnctQoUfb1eVD8z92jh3+peTcZ4bQR5/49l/BTFeX0ds07PC4dz4bYbcTul9fCpc
	GuH9EFM7eg09mlpfxFBKNon4LaFE5KtOsj81PVozajiZFEv/jB4TXDDqbqr6xPbXXhvSh0fIbLB
	vAVK9mvAQ1rUBWerIC5DnxYUK1dyPoYmQPUxoQVOyCIgn0vtz+VXVvrXi0ZUOqdk168s0E/0huc
	3Y8MH13yM0DmmsW
X-Received: by 2002:ac8:5712:0:b0:4b0:6205:d22b with SMTP id d75a77b69052e-4e8b679b7a2mr115979261cf.52.1761039755352;
        Tue, 21 Oct 2025 02:42:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtJWXOjke0RTmK0/xZXoqnt4Ou0KacBj/M07aRFHuZEpUI1vDSqa7DdT8a6/Yrxfq2QlaYBVOMZ0kPdqztzzI=
X-Received: by 2002:ac8:5712:0:b0:4b0:6205:d22b with SMTP id
 d75a77b69052e-4e8b679b7a2mr115979131cf.52.1761039755012; Tue, 21 Oct 2025
 02:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910170000.6475-1-gpaoloni@redhat.com> <2025102111-facility-dismay-322e@gregkh>
In-Reply-To: <2025102111-facility-dismay-322e@gregkh>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Tue, 21 Oct 2025 11:42:24 +0200
X-Gm-Features: AS18NWBpQWaCgTUPFKBGe-mp83ffIdDKrAgAWm46CipP2yYr5wYthLbhuHqwos0
Message-ID: <CA+wEVJZEho_9kvaGYstc=5f6iHGi69x=_0zT+jrC2EqSFUQMWQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] Add testable code specifications
To: Greg KH <gregkh@linuxfoundation.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, safety-architecture@lists.elisa.tech, acarmina@redhat.com, 
	kstewart@linuxfoundation.org, chuckwolber@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Oct 21, 2025 at 9:35=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Sep 10, 2025 at 06:59:57PM +0200, Gabriele Paoloni wrote:
> > [1] was an initial proposal defining testable code specifications for
> > some functions in /drivers/char/mem.c.
> > However a Guideline to write such specifications was missing and test
> > cases tracing to such specifications were missing.
> > This patchset represents a next step and is organised as follows:
> > - patch 1/3 contains the Guideline for writing code specifications
> > - patch 2/3 contains examples of code specfications defined for some
> >   functions of drivers/char/mem.c
> > - patch 3/3 contains examples of selftests that map to some code
> >   specifications of patch 2/3
> >
> > [1] https://lore.kernel.org/all/20250821170419.70668-1-gpaoloni@redhat.=
com/
>
> "RFC" implies there is a request.  I don't see that here, am I missing
> that?  Or is this "good to go" and want us to seriously consider
> accepting this?

I assumed that an RFC (as in request for comments) that comes with proposed
changes to upstream files would be interpreted as a request for feedbacks
associated with the proposed changes (what is wrong or what is missing);
next time I will communicate the request explicitly.

WRT this specific patchset, the intent is to introduce formalism in specify=
ing
code behavior (so that the same formalism can also be used to write and
review test cases), so my high level asks would be:

1) In the first part of patch 1/3 we explain why we are doing this and the =
high
level goals. Do you agree with these? Are these clear?

2) In the rest of the patchset we introduce the formalism, we propose some
specs (in patch 2) and associated selftests (in patch 3). Please let us kno=
w
if there is something wrong, missing or to be improved.

Thanks and kind regards
Gab

>
> thanks,
>
> greg k-h
>


