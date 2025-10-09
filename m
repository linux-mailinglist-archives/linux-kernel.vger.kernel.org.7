Return-Path: <linux-kernel+bounces-846950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A76E6BC97FD
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 932554E4538
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC302EAB66;
	Thu,  9 Oct 2025 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQH5MGD0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463CA2EA728
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020034; cv=none; b=trhls3yFj2ZfUaF99olTQvvZilLPvDFOHYeTEahP9QlfWDLy4y1Yl+51SYzUX9u8RSRzT1y12eOmmcU7cJiU7uBAv7X0WMWrx8sjOAWIyRFfqmO2HOYMlLKVk0hN4svwQMqobl0VFmjV09d35NBqXmEA9ZivP0WAZ4FO1Z7HfAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020034; c=relaxed/simple;
	bh=r/F02S07YxY/vR+W+qaExDIN6Da+5SzwX0AXZ3uJSi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMxpKuPYST/+q0nyXqIn0Msd80zWsncyBYWXfQ83lLfVa+J3y34TUCS6tx6Zchw51UxNYI4gfnpNBqynEN1tUJody46XHB47FkHRAAMI+MU4gf3KfSWkveORtqsg1q8azGwMjOoCLxBJVYJ0Tpacn5OPSJz3wiuypRxcj+imAV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQH5MGD0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760020031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r/F02S07YxY/vR+W+qaExDIN6Da+5SzwX0AXZ3uJSi4=;
	b=IQH5MGD0UDxq+A04zJcE0f80/9nfkfcKWTuAJH9W8DVD4X5ZPk+CR5HSTAASeB9GJfqzlY
	q11bo++aUV06F6vsXQERpEddS1Egho8bx22l9n3z9PL1MrARk9XQurZ/pQN6yL0lTuws+i
	FwgiqFNuAautaI5/Xy4g45miV0lC95E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-tmvrIAHvMWOv_KWuZIMEcw-1; Thu, 09 Oct 2025 10:27:09 -0400
X-MC-Unique: tmvrIAHvMWOv_KWuZIMEcw-1
X-Mimecast-MFC-AGG-ID: tmvrIAHvMWOv_KWuZIMEcw_1760020029
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b41c67edce5so203665266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760020029; x=1760624829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/F02S07YxY/vR+W+qaExDIN6Da+5SzwX0AXZ3uJSi4=;
        b=rT0MZjiYO98Hbfnv92Fh1hen1fJyFCQBNXlE32Hqz7l44Qqe7J7KT6fTc6WEmhCFtw
         f3Jrmt4aK74Wu1ot0LNkg1FEn9XNawrSFVJ6Gm5VBM3OeKdJZ+8xBVa9Y1mxH58zWp1w
         VqKQt0aL9IHk5s4Hz1NMgT/gRBePCta/QNcwPRPxuoGjE2TdD+kvBZaXGgfhkqdlgXK+
         ebVQCDcy8TdLeOJt9dJQkzRWAIgknYjBoX3Lsn/fhzGGm4da58loB4PoNgtoJbQVsN/T
         wFqnqrYQ4z0kDco02Z8rZ2q+066vj+HlZCG0JE3judEMg1QkK3j7mgk1OBn9G8bK8Yqz
         N1bg==
X-Forwarded-Encrypted: i=1; AJvYcCWvOWbokf7lFVxmR5v6x3ogMP+ZQtecSEFrOAPDiz7KQdvO+JD3mYQJIq+HvSwS2vNWbMbkJ719W2whuqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgx/BMrKgIJUTlWr5LDIrPKAfFemmU6fGn4SAyMU3miBE9nEol
	nch3ncrsuRUrD+IaF2gKFd4H2NRuN0qoTzeJUxotjDLD2QvrQKKYZb5SLGRLFerP4PJcgOuds1k
	Ieb/r+ckTudAf1PxskiANu/TX9zcviuDM/31HttIGK5OK+GnE6Gp7knRozOVOdtJOjN+chrxiGE
	kphSrv7tsUa65kncjxZLWQIkgzsRzFtKXz+4/3UFI9
X-Gm-Gg: ASbGncs4PfhapxtU6OH9P1Ij+yttC+2PkFKc2HSMsc8bBMvBW4eoS3a4+imSxJ2ZuoU
	6qRvPTm/NxFnOUXLP6AfjDKdPzU61okKMJRYjXdeaYEVJaacXkR75ERkphNfw0ChNg8eGRrRejq
	QJ/Bdy+ynVVSlszaDyTUnN0wB0WA==
X-Received: by 2002:a17:907:94c8:b0:b47:de64:df1b with SMTP id a640c23a62f3a-b50abfd6d92mr811671166b.39.1760020028558;
        Thu, 09 Oct 2025 07:27:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9K4Ovcv1oyU3VJoFriYFnWdSwGIcpMlhvL4pFzCqlwbu14cCZhq1aVRyK7USxJfsD/yZfE8XNTnaHJkha3f4=
X-Received: by 2002:a17:907:94c8:b0:b47:de64:df1b with SMTP id
 a640c23a62f3a-b50abfd6d92mr811668266b.39.1760020028075; Thu, 09 Oct 2025
 07:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP4=nvTjauRawBPTnGEztZpdDSNhGpgSJtjoTFuq+cCQHP5oEg@mail.gmail.com>
 <20251008184522.13201-1-krishnagopi487@gmail.com>
In-Reply-To: <20251008184522.13201-1-krishnagopi487@gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 9 Oct 2025 16:26:56 +0200
X-Gm-Features: AS18NWCYOpNrF7B48EqcyTUqbw_46aTsbs0KByL75_VH-zZNmvaxGmgx_22fbq8
Message-ID: <CAP4=nvQT5xkOCvVK9J-aYMjwqPv=F8bJ6m1yj2W9OcUwwJw+7A@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation/rtla: rename common_xxx.rst files to common_xxx.txt
To: Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: rostedt@goodmis.org, corbet@lwn.net, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
	linux-kernel-mentees@lists.linux.dev, crwood@redhat.com, 
	costa.shul@redhat.com, jkacur@redhat.com, 
	Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 8. 10. 2025 v 20:45 odes=C3=ADlatel Gopi Krishna Menon
<krishnagopi487@gmail.com> napsal:
>
> Running "make htmldocs" reports the following build errors for
> common_options.rst:
>
> Documentation/tools/rtla/common_options.rst:58: ERROR: Undefined substitu=
tion referenced: "threshold".
> Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitu=
tion referenced: "tool".
> Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitu=
tion referenced: "thresharg".
> Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitu=
tion referenced: "tracer".
> Documentation/tools/rtla/common_options.rst:92: ERROR: Undefined substitu=
tion referenced: "tracer".
> Documentation/tools/rtla/common_options.rst:98: ERROR: Undefined substitu=
tion referenced: "actionsperf".
> Documentation/tools/rtla/common_options.rst:113: ERROR: Undefined substit=
ution referenced: "tool".
>
> common_*.rst files are intended to be included by other rtla documents
> and are not meant to be built as a standalone document.
> common_options.rst in particular contains substitutions that are only
> resolved by other documents, so building it independently results in
> 'undefined substitution referenced' errors.
>
> Rename all common_*.rst files to common_*.txt to prevent Sphinx from
> building them as standalone documents and update all include references
> accordingly.
>
> Suggested-by: Tomas Glozar <tglozar@redhat.com>
> Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> ---

Looks good!

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas


