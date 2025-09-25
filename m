Return-Path: <linux-kernel+bounces-832801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D8CBA064C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB692A662C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E293B2F2907;
	Thu, 25 Sep 2025 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzcdXdGv"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D114B2EC568
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814790; cv=none; b=RJORBy+C8bYLLFHKmiHpTTX7k5mO/3+ox1GDUimbFKb09Sa6NjmGvxR1Rc/me66WAB5atuDen3p1aHxhYU6sfeyPpd5OZKeP83rR8kWnrsuBWwsLVDyqolAPxeVn1s9ABikj5MVt9BQ3h8HeKvVqURnmtgoXjmQ6bzFyMdv+Ji4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814790; c=relaxed/simple;
	bh=fcx1xsQ2HV2BsgfD6Y/SkjMcXQLAmOVXzQfm7XG4V+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrDsAwAjryrmmhjGVIniI/pK2FosLSFIUbO/v0z7QjHXbK4B2Q4oseGanADpB8CHH4TWxwGx7J6ZIGS7o62ZmswTfpUqaNfbbAgcapZDc1Vn2qdEcwmCpCT60Or7Y/rKF1OobPNoqmkEsntJXOCxXo0KWHHj3+l4G0QzWf14x60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzcdXdGv; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-70ba7aa131fso11224366d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758814787; x=1759419587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/gxM2GZ//p3vsM9/c44+z51oZMOCRO2uPq/3cokxHU=;
        b=hzcdXdGvYf5Ug4nt1N55Jr1Qb7mPoptzIRJ6OI+N/LvgcvYajNsmi3CwqOwNNWCg/n
         FoWKOLGr0oB7eWfFTvD34sw5wRmQoHWTaPNMlBXDjJEAVQycGprQpthGEIyQMt7Wfqon
         QAgEQA6sj4fLmEqXhFRlncWk3ElYvgD7BJINo41Q9JbByNUwF28bse/aXWbPvslXSccK
         OMhILsv3k+8ykjUzvIQGFSCo5VJ5ECz3Rd5JOzX9xLYOIIGPROeF/J0+K5zQEDMYPwoZ
         L4dnKWuKLH2cvtJIGSZWLh7K4QX/tx8WH+R/llhvWmSuulYfpGlriXUjAszHS5rKtLzZ
         laxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758814787; x=1759419587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/gxM2GZ//p3vsM9/c44+z51oZMOCRO2uPq/3cokxHU=;
        b=ODnVxgCaCmBsyWpCs3SU/tiQ0BwL8X5whDJlNSjfCGFboEpNjZoJOgnzmr0KCpQvB+
         aKSRNl2R1JmIO5frge+Nx0upHZ47sLUdJL6ev4974qOHOKc/lWNofWxvnns2le6iXmqq
         /cNqZJ1/ZAw3iio+HKluF1ffkCEsrfiQflN9l3gwJiZkvO3PEH6IVH5Fx9VFBF8IkKwN
         ocb0ZmInEhIwPzkcio0GuVKLdLhEujs/eTkEERrUdJGaPDDqinyUBtUWwpkZGz7ksIPQ
         9dY5jpfldEOj8YO69upbeTepZzyPc5c5f3a96JbQaSg5UxdtP+n8E1xvdZJ8JR9OumL1
         gZxw==
X-Gm-Message-State: AOJu0YwC9SPAl1yArIZ2/rktZeAN89u3DbjgthzX/C2t6R5UFS6NQ+zX
	+vwtGRk7xifO98fMae2Bj0UZqmb2sJ9H5DwQE8gyQMc0dhH0L1zL4g4RodJiWPh0H6IyySS0khl
	5ydbpMoZLCQfrp6PKMsT1VhOIZRAdswE=
X-Gm-Gg: ASbGnctLGaGPDP9+EzLn+SHax7eajqe6/hpdSlAhm/UJUDVlL6z7ErwhvOBEZ6xcYch
	42xP7tq2/SKMdCOvFfGXtWRyB6G0ZJxr++q9khvSntTH1+GN4UFavSAnJM5ecpqIh6SJnmGKGb8
	7mkIxKtpqhcyhDXtlu3wFFwknFBeBjT8UV8nIv7exppOCwWAl65XGhcxRAej6wNMH4jToy8uoCD
	jc5JqptbLKi2n1Hj18AYvcEwOCcwAijBER5FXdlc5nyRvsh/xm7gKnb8rnCGq1GEUNpNIBPF4lX
	9s6NodvNKaC3VGtCSuIaIpY5EUc8hvkciHttehwKO+bQilW/+VXGCiDJrELW2+Qc2l1l2eeUOLI
	B+HfOlgP5l/+g3gonpLybkubi0xxl+mMP
X-Google-Smtp-Source: AGHT+IES8OpxO46lya6Ja3cpgdYv4JUSL0YgHDVfezBAbW3XrWI16+5dA+Asr6InsRlLJadadFe3Lz5rMdcADr3IL+E=
X-Received: by 2002:a05:6214:3017:b0:7fa:dc54:5e60 with SMTP id
 6a1803df08f44-7fc32001335mr55979626d6.24.1758814787364; Thu, 25 Sep 2025
 08:39:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aNU0D_3x5WC9qBzQ@sirena.org.uk>
In-Reply-To: <aNU0D_3x5WC9qBzQ@sirena.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Thu, 25 Sep 2025 10:39:36 -0500
X-Gm-Features: AS18NWAFD_qjJ50kmUkTB6KYbooErErcY7xLI1bEOzK65no55USKLs4S-XcQjgI
Message-ID: <CAH2r5mt_TXXsrik3HPFBfSOcVm9Azu4Qprj5ps51S5VXGet3tA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the ksmbd tree with the cifs tree
To: Mark Brown <broonie@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Stefan Metzmacher <metze@samba.org>, 
	Steve French <stfrench@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have updated cifs-2.6.git for-next to remove the duplicate patch
(that was already in ksmbd-for-next), and have updated ksmbd-for-next
(somewhat fewer patches, and he has reordered them to be less
confusing, and fixed the missing Signed-off-by).   Should be ok now

On Thu, Sep 25, 2025 at 7:22=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> Hi all,
>
> Today's linux-next merge of the ksmbd tree got conflicts in:
>
>   fs/smb/client/smbdirect.h
>   fs/smb/client/smbdirect.c
>
> between commit:
>
>   8c78e78d99355 ("smb: client: fix sending the iwrap custom IRD/ORD negot=
iation messages")
>
> from the cifs tree and commits:
>
>   4e152f2732650 ("smb: client: make use of smbdirect_connection_negotiate=
_rdma_resources()")
>   c0a6d2d41a3b6 ("smb: client: initialize recv_io->cqe.done =3D recv_done=
 just once")
>   d5b264e469201 ("smb: client: fix sending the iwrap custom IRD/ORD negot=
iation messages")
>   8435735745f65 ("smb: client: make use of smbdirect_socket_parameters.{i=
nitiator_depth,responder_resources}")
>
> from the ksmbd tree.
>
> I don't feel equipped to sensibly resolve this today and there's also a
> missing signoff in the ksmbd tree, I've used the version of the ksmbd tre=
e
> from yesterday and will hopefully have the time to look at this
> tomorrow.



--=20
Thanks,

Steve

