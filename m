Return-Path: <linux-kernel+bounces-894846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CA4C4C37E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8FD1634F634
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0419D2D2382;
	Tue, 11 Nov 2025 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMEXNro+"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E442E23C4FD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848040; cv=none; b=UBhzYkaHzM2M9X7xNzhsRezQ+QQ9TzyIpzQNYT2WNU34ICSpfW2FqQh6l86a75Y5Ptsy2bO4HJzPFzj3SJvRH++LKuyDQ1pFQWHGv1Z/5Ai8CDG6VpxTHl+D3TLOWgN7uIpD9URF0yswOGeye/U9NwDK3QkPrhTQiHqs6c7Vhgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848040; c=relaxed/simple;
	bh=rDckcXtAxCRs1jWV+jUesnF45T+CnmnVpB2u0iOadWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GrmARc+4c1lgf/LyY811vzJXNSPTYxCvLIc3TZJz2TYLIGefsAPpfQAgdw/ocbbX0dKJ4aQvpauL+QKPISXYTrvci150FJs12beYdz97t7Wujibdu6Y+Cmq7mlSx9ZPuf1GdsgSrGMVqDP0pviIvZrrLUlLfj/I7ZGVXyQZRGbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMEXNro+; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ed7a7ddc27so38844261cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762848038; x=1763452838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDckcXtAxCRs1jWV+jUesnF45T+CnmnVpB2u0iOadWc=;
        b=dMEXNro+SHGTY/+9Z/7uc1v48KYx21QMwKplGdMpfJnE75nZOkiVa7BPpGDoIUGu9h
         ybEKHEth3SL2IbekjtgU+rOUwldyFy8b1gQD1KrMvh0uKu2sy0EpxQuPmlpCvdemDnw6
         Fo9wibn6RR6vdd4osfOmannEoFin2tMt35E4s17M9sqhYPzTyjO7T626bqUJay3jENT2
         MFnjXESOoXW550pxUAn/ejwNl6JSdLnlRSDWHP1bL83J9BVBdhM/qFkxHL8V9dYjx5v8
         vN8ZQ8oIs7YxODm8F0YN04ZD/e7+lDLwrhnJ88FDHvGugcTm14i1ClDaJcgPjc8JfXce
         qRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762848038; x=1763452838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rDckcXtAxCRs1jWV+jUesnF45T+CnmnVpB2u0iOadWc=;
        b=eniKKxRcZysI0+Sx3R9z6BcDLrgFZh9/qXN5fMJwLHcBXiH3+5G3sNhVRrkHNmh3BI
         Svf0U3GX8BUqn7cRR4A1GP92utFshBgla++DbutgNjMroe+aFmvf7oxod2Act4DGF9/9
         RZMJZMgEZtMKelgT1mSCFH6P2+kG4+Og5+trbbhDcYxTKtBJ2mHN6b8bc6ga84aXUslQ
         E9BGHA89L8TcDVtJfX1j0dOEfzXlJ1maT62R2OhicLv8wL06XEhuJ99pwSyqq7IZwl3S
         HDfUiGockqzfNI+3LlTRneRxKMf96Yr0yOjuISE6iHuZxw8qp2qon3PW4UAwAuOaH18p
         ATbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyu2wN42J3OhnvtxXSLVRoAbqD12NMRopahWkuKgXPpav5uWlW1H1RSQnub41emcUvjdwdnxQPWv0dges=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya365zO4mqU0kouW0Z5e5nqY8izQFTaIseCcg2K3q8y7Ceja2h
	ylWQ+NOa18ck4tgD8M8AO8oXGeXoGgjE+bHaf5TzkWm1fmu7QYiPkRc2WxoviEFFWkmKRm+B9JQ
	nXkzctFmmyVJN9vrw0bi25bZyfWGskSA=
X-Gm-Gg: ASbGncsiA4te/J0lE/5YiEXEl6zFiN0RZsY65MzuXfLsey0QsttNfYuVADatVUlSMz0
	Ge0No1GlqkCKjVxr5/F7IzpLOznyhTsyUw87dDgD6CDLKTzklcQGnpakIkg9Ks3dPNXmaSYry76
	h4SyvpiQJsrXz9Vq0ePex6fpTL5BQFP+FE+oTci8yEUBy3IUFMYqDYhKmY/OImoR9YiI0yMkkIY
	XSpmjq6Mz7htreKeWTOIJvvWLK8fIBCGTIIr4bh7cujSUcgZTk4xNOcLrE=
X-Google-Smtp-Source: AGHT+IFVQuNm4jzoJ0sfN31dAeG2EzznRF+s6nZQWq2ePzdvY6tzRS6akqHmsN2TOSmWNU1I2EXt++5wc1vnYMks77o=
X-Received: by 2002:a05:622a:1487:b0:4ec:f39e:a614 with SMTP id
 d75a77b69052e-4eda4fe7d80mr139466921cf.74.1762848037835; Tue, 11 Nov 2025
 00:00:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN2Y7hwttMyUn0qsEcSBbrQ1h+aSzNpHMhgAxEbqJZn4vf5hBw@mail.gmail.com>
 <aRKll6BXZdW2I_Wq@casper.infradead.org>
In-Reply-To: <aRKll6BXZdW2I_Wq@casper.infradead.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Tue, 11 Nov 2025 16:00:26 +0800
X-Gm-Features: AWmQ_bkZp1Ha95rOqs1HW3UzS3vKjZUDVxeK0wVkc4B4tdWTsyLi5q4Md1SVIsM
Message-ID: <CAJhGHyCArEwKNF3uug3ZW8eAJKw4EyJwt302W1O7PnvPY=k-7A@mail.gmail.com>
Subject: Re: [PATCH] workqueue: add workqueue.mayday_initial_timeout
To: ying chen <yc1082463@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, corbet@lwn.net, tj@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, laoar.shao@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Chen

Thanks for trying to improve.

On Tue, Nov 11, 2025 at 10:55=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Tue, Nov 11, 2025 at 10:52:44AM +0800, ying chen wrote:
> > If creating a new worker takes longer than MAYDAY_INITIAL_TIMEOUT,
> > the rescuer thread will be woken up to process works scheduled on
> > @pool, resulting in sequential execution of all works. This may lead
> > to a situation where one work blocks others. However, the initial
> > rescue timeout defaults to 10 milliseconds, which can easily be
> > triggered in heavy-load environments.


This is what it was intended for. A workqueue equipped with a rescuer
is considered a single-threaded workqueue, where deadlock can occur
when there are works depending on each other.

It is recommended that the user modify the works to eliminate any
dependencies or consider using multiple workqueues. Increasing the
timeout doesn=E2=80=99t solve the problem; it merely hides it.

Changing the workqueue implementation to support concurrency for
the rescuer would complicate the design unnecessarily. The use of a
rescuer is only for memory reclamation, where the works should be
simple, focusing on freeing memory rather than waiting each other.

Thanks
Lai

>
> Then we should tune it automatically, not blame the admin for not tuning
> this parameter.

