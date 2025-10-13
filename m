Return-Path: <linux-kernel+bounces-851240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5CDBD5E38
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD6718A2FF6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B88E2D877C;
	Mon, 13 Oct 2025 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XpPJm+vr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B3B2D661A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760382699; cv=none; b=tDksrsbtOAGwuWKRM5sszTzzQ5GkVEVG5Z4X1L6xgv8a8B80RKvHtzfDL5OwkHUGmUEEjRMOeEmotn5Yj2zgN9cI6HKDuqKGspPsWJWple8m74M/xhyOyK2VQBn/OizQ5nzmj9HRQwcQLlekAB+H8aPAUxDc75s0vPJ2UMnCI/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760382699; c=relaxed/simple;
	bh=YnqDhTt+IrtlvAL/Hrj549WY1No/n/MTQkCaJCyZ/Ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejgirWQ+wLVoUu1jcGbYXipnSAD5qCQ4LcPX+X0ds1lhpwXUsM2PEERFhGkPBd1DLCLRjfipzcgyrvq2WAgoIzhtGSQKoh6lE8M5QMJfHRbsYRk/MTI12CFtDiRvGcbWmXtUEvaEJrCwuT14fGbLnhWPYX7qOyTnyyUJs1yB63w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XpPJm+vr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760382697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnqDhTt+IrtlvAL/Hrj549WY1No/n/MTQkCaJCyZ/Ys=;
	b=XpPJm+vrl8aQnF9nNs+ESPNzfYvrXtmE/MvIx1kelYLdrqYe6UdrNNSLGpqwYLVcRqV1Q9
	WQ8wmUZfckGOoANEdLdt+3EAKJ2KUV8rb8Qc+vMkicJ0wHU8cc/jTPSGHySeIXScoZr8ko
	ALAOTjlSltIF+Gi39PTuO40pqHh6aRs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-aV-z4oVNMS6sxt3ttJWOYw-1; Mon, 13 Oct 2025 15:11:34 -0400
X-MC-Unique: aV-z4oVNMS6sxt3ttJWOYw-1
X-Mimecast-MFC-AGG-ID: aV-z4oVNMS6sxt3ttJWOYw_1760382693
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b3d525fb67eso593323266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760382693; x=1760987493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnqDhTt+IrtlvAL/Hrj549WY1No/n/MTQkCaJCyZ/Ys=;
        b=LLtzBKanARCMj2rXpPrPF23xp/dwDB1YATsHvsFQ4InBnG0MAZzK5WRwbD791SKSaK
         FhCqlhERk1iwYyBRhhUk0uz4QnfNxeenGwBC2CTJkYmD+qOBmG2E6pgA7m3JjthKZofK
         7Khg3Cf29uawYJ0OkYgcL5EaPdweohi2OMBiB+V1rBxTqdmp2N6rN+7XsFEt5M3D6GP6
         n1XfpTxaL3nmwv15MHDQJpACcTq6an2IH0lRW77sv1c9VyH0rWgCYL5kSDQOY3wvFKSM
         j5RuUSBknsy890yiFKLHU85IHXjTPNIaFBsJAcfaPoAxDRXyYzFkPBtrDRqJbyvb0WgR
         PnPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMfYV1g4M+sA3vZ6ZQgecbhXAbrth/ibExc9y9dXQYu+Y8JNMi7dlEh2uEaczymmbE7+g8ZD7XPIYzheM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoDREto1GImFPq05kELt03s3ede+SPRs6MaHkuep64drUR3MZg
	hRGARUvxizvHk+W1N/J5hTyiY3CvwCcJLbqD4lJxrfoq8alfRm/5rlRiacL6KCPfeLRsr2TfEir
	8YNgYdV5mYTfM/qePMRRYcyGvHyPDQRMxaDZVB6h0cub8IPEH6b9LxfmY9t/C7ZGRKzs/HDNV+V
	e0HcImHHWXPWnK8bamwzUxU7/3y/n+P33PO1JWpOmk
X-Gm-Gg: ASbGnctDr42NeLVtnc/Olc0xNJuXChJ3VoVOvZtjzMIVAOniCleR7eKjZZUybUPAF1w
	CJpQytM3JFSz7Gt4tACBIcnBvXgl2RVgz1wtEb+++jwEhyLXTI9Wmhdg+HI1les8wsgBCqwlo00
	TFLyOge+mw5XLG+8gQaefRe9sybJ/1irbNH53wBXRxzK8IbD9/hpl9dw==
X-Received: by 2002:a17:907:7f0b:b0:b46:31be:e8fe with SMTP id a640c23a62f3a-b50aa48c4f0mr2434548666b.11.1760382692717;
        Mon, 13 Oct 2025 12:11:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdZSlJjUKGUyEQeXbLsv9VheuVhvq3shA+CFJRXSerqAlSqVOk9p/8bvz3PxsEytGYzwrMZIP2BUftmKkR2Ws=
X-Received: by 2002:a17:907:7f0b:b0:b46:31be:e8fe with SMTP id
 a640c23a62f3a-b50aa48c4f0mr2434545466b.11.1760382692352; Mon, 13 Oct 2025
 12:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926193035.2158860-1-rrobaina@redhat.com> <aNfAKjRGXNUoSxQV@strlen.de>
 <CAABTaaDc_1N90BQP5mEHCoBEX5KkS=cyHV0FnY9H3deEbc7_Xw@mail.gmail.com>
 <CAHC9VhR+U3c_tH11wgQceov5aP_PwjPEX6bjCaowZ5Kcwv71rA@mail.gmail.com> <CAHC9VhR-EXz-w6QeX7NfyyO7B3KUXTnz-Jjhd=xbD9UpXnqr+w@mail.gmail.com>
In-Reply-To: <CAHC9VhR-EXz-w6QeX7NfyyO7B3KUXTnz-Jjhd=xbD9UpXnqr+w@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Mon, 13 Oct 2025 16:11:20 -0300
X-Gm-Features: AS18NWBRpmVXsqMwV5PkEQwwAsDGsJpwgtFtU7bYTbHsTAe-yKFLi7W40fQv0tM
Message-ID: <CAABTaaBO2KBujB=bqvyumO2xW=JCxKP0hc87myqcLF3pbxSorA@mail.gmail.com>
Subject: Re: [PATCH v3] audit: include source and destination ports to NETFILTER_PKT
To: Paul Moore <paul@paul-moore.com>
Cc: Florian Westphal <fw@strlen.de>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, eparis@redhat.com, 
	pablo@netfilter.org, kadlec@netfilter.org, ej@inai.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Oct 13, 2025 at 2:48=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Fri, Oct 3, 2025 at 11:43=E2=80=AFAM Ricardo Robaina <rrobaina@redha=
t.com> wrote:
> > > On Sat, Sep 27, 2025 at 7:45=E2=80=AFAM Florian Westphal <fw@strlen.d=
e> wrote:
> > > > Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > ...
> >
> > > > Maybe Paul would be open to adding something like audit_log_packet(=
) to
> > > > kernel/audit.c and then have xt_AUDIT.c and nft_log.c just call the
> > > > common helper.
> > >
> > > It sounds like a good idea to me. What do you think, Paul?
> >
> > Seems like a good idea to me too.
>
> A quick follow-up to this ... when you are doing the work Ricardo,
> please do this as a two patch patchset; the first patch should
> introduce a new common function called by both audit_tg() and
> nft_log_eval_audit(), and the second patch should add new port
> information to the audit record.
>
> --
> paul-moore.com
>

Thanks for the tip, Paul! I'll work on it next week.


