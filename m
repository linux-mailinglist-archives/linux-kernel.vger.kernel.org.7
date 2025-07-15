Return-Path: <linux-kernel+bounces-732155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2CFB062DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A7A17D3ED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C81230BD9;
	Tue, 15 Jul 2025 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhNxn5Hj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DCF14386D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593060; cv=none; b=EwmjkCipVElmyLAI3mxG6VRGOPTzvVX6+W3jtE1rJLGyxCnPJPDuwe08an/8g0kpXhARmyUC5nrfBUUcdcnewZ2jCy0ckUJ0QMeyfdgxKk93jLCCJFWXrN4p8XB/O+y+Jm5IMk8eRX7fspwtWhkTuzarswMIgy2N183KyEWwDHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593060; c=relaxed/simple;
	bh=LmfGXgbaGNQsbBG0W06QrFh9jam8csQ8J8b/R7IuV5Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I1CxGlhTMZPCGf4ce+hIRI8wNTKkC/foaRpO2eUuWxl6pPeHgU0cFO923j5rHs5y/ipVeI34YhZv+IVmOePfPBAyttHFyg4iLqkvnpnwcKX+ZMLo3l76fkBenBWVmnchk2fQlRUZK7NbUpBs25RZRKwVPFCaeFld2s7UGpIjT8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BhNxn5Hj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752593057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NQXH91nErjb8qEpTCbnLQFKGPXnH6O5DS1xuVtrdrCs=;
	b=BhNxn5Hjr3K/oRdhRgFT/WxTYWjLKn0ZNIYsJ+XCpzC6g4Qjek2Ise4FCUQa8SIoSfsMI8
	jYBVyjOOo7l13DxX93e7JTfwXJmFiMp0ALbps9/7FCW0lsOVP5WYcRFbEZkWlTVzVneDBl
	c4XG7MPqx4ns0eqAqMRR8H+hVkZe+gs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-hiwvoPh5NbOd-SxD1-HQ2Q-1; Tue, 15 Jul 2025 11:24:16 -0400
X-MC-Unique: hiwvoPh5NbOd-SxD1-HQ2Q-1
X-Mimecast-MFC-AGG-ID: hiwvoPh5NbOd-SxD1-HQ2Q_1752593055
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f7f1b932so3353737f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752593055; x=1753197855;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQXH91nErjb8qEpTCbnLQFKGPXnH6O5DS1xuVtrdrCs=;
        b=Sic85MaBUUTYG+aKYxzy2kkrcgKy4D5LYlysIsAxtSfmjkt04Iv5dEhUuAFB4X9+Xs
         w2jUBrTYxRuxIGR03nG8EXHIrQjyusD37XNogHYjA1dfVM5QHFMZNPa1kidCxiLW/ZVe
         TaUj8r2daDrpV+mHDeuoAjhZxiRsghpPx4rrWKXpIg4L0i1hcIN7HArPzoAwwgE/eR5L
         H5njQ03mOvITp9UKBp33CZAzEftXyNqTOTFi3x+PrzZgW5H6dggYTuHi8qQWN7fbg13n
         WWGcHJc3XPvAL6HUg6s/lHdAtXAb3o+2uhifAdu+/hexQtxXTwqlrgcXnrxeJ55eriYN
         FYcA==
X-Gm-Message-State: AOJu0Yz/oD1pGdV2+9ZQNBfwFqP2HVZ0kj7ffaDvtSSO1Yiu6Cn0uVD/
	psfqu4/NhHk33NUY1jZWZK+AMWFqHO9DzR4VgEkhjmy29K+KkBhq4DRNsNxAcPLFM/bEHrJHcNu
	AMwl9zysKj+4XqsSdG2lVah3PS+lfPf+3VNLU3lEh7D62w2zw14FTzgtVvwn5JactPw==
X-Gm-Gg: ASbGncvpSS/jYDVR2Ec9rFlrD8ZV/XFDzDyRBuCylXXs65aYm9iLrAw5R9yjhaC5IQY
	yeIE4uARbmJUmrB1lJZvqo2aZH6PWzBffAUOixdYBK4vQvxXIOboUDIWDtuylYvAw72W6jq6c83
	2nUOPMfFpZ65Pe/MBcyh2vV6qhXHTJEGrYiakpBS6JgvO6ZF6FdQtfVK0gEX5QBZ8OevGYft9//
	UnvbPZr2J3++4Ql5w8+RFrwdoP+TH6NpzyIGJ0MkFOqGr9TFsL/nXxyPuNfbUXKqxd1zzGSyriU
	ucGXSna6hXNAS9fPeYIVfJE2D+42qavvsX8dZrOFuESdqKQWNp1yKK1QIbHjbDilRA==
X-Received: by 2002:a05:6000:144b:b0:3a4:f661:c3e0 with SMTP id ffacd0b85a97d-3b5f2e272e5mr15797885f8f.45.1752593054870;
        Tue, 15 Jul 2025 08:24:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAD/RPdEIGo+NLp2nTXtLdhtHXl+E8RQZSORherbEUs+bWoj5Dv0TdttD3NS0GePRkad31xw==
X-Received: by 2002:a05:6000:144b:b0:3a4:f661:c3e0 with SMTP id ffacd0b85a97d-3b5f2e272e5mr15797848f8f.45.1752593054413;
        Tue, 15 Jul 2025 08:24:14 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc3a62sm15212690f8f.40.2025.07.15.08.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 08:24:14 -0700 (PDT)
Message-ID: <17efdc2b3e206730cfbef410fc89a713da133b65.camel@redhat.com>
Subject: Re: [PATCH v3 10/17] rv: Fix generated files going over 100 column
 limit
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,  Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Tue, 15 Jul 2025 17:24:11 +0200
In-Reply-To: <20250715150828.BNdFfB8h@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-11-gmonaco@redhat.com>
	 <20250715150828.BNdFfB8h@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



On Tue, 2025-07-15 at 17:08 +0200, Nam Cao wrote:
> On Tue, Jul 15, 2025 at 09:14:27AM +0200, Gabriele Monaco wrote:
> > The dot2c.py script generates all states in a single line. This
> > breaks the
> > 100 column limit when the state machines are non-trivial.
> > Recent changes allow it to print states over multiple lines if the
> > resulting line would have been too long.
> >=20
> > Adapt existing monitors with line length over the limit.
> >=20
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > ---
> > =C2=A0kernel/trace/rv/monitors/sco/sco.h=C2=A0=C2=A0=C2=A0=C2=A0 | 12 +=
+++++++++--
> > =C2=A0kernel/trace/rv/monitors/snep/snep.h=C2=A0=C2=A0 | 14 +++++++++++=
+--
> > =C2=A0kernel/trace/rv/monitors/snroc/snroc.h | 12 ++++++++++--
> > =C2=A03 files changed, 32 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/kernel/trace/rv/monitors/sco/sco.h
> > b/kernel/trace/rv/monitors/sco/sco.h
> > index 7a4c1f2d5ca1c..83ca9a03331af 100644
> > --- a/kernel/trace/rv/monitors/sco/sco.h
> > +++ b/kernel/trace/rv/monitors/sco/sco.h
> > @@ -39,8 +39,16 @@ static const struct automaton_sco automaton_sco
> > =3D {
> > =C2=A0		"schedule_exit"
> > =C2=A0	},
> > =C2=A0	.function =3D {
> > -		{=C2=A0=C2=A0=C2=A0=C2=A0 thread_context_sco,
> > scheduling_context_sco,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 INVALID_STATE },
> > -		{=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INVALID_STAT=
E,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > INVALID_STATE,=C2=A0=C2=A0=C2=A0=C2=A0 thread_context_sco },
> > +		{
> > +			thread_context_sco,
> > +			scheduling_context_sco,
> > +			INVALID_STATE
> > +		},
> > +		{
> > +			INVALID_STATE,
> > +			INVALID_STATE,
> > +			thread_context_sco
> > +		},
>=20
> I'm confused, these lines were not over 100 columns. Same for snroc.
>=20
> From my understanding of the previous patch, the script does not
> break
> lines which are not over the limit. Did I miss something?

Right, I didn't make it obvious in the commit description since I
thought it wasn't too important.
Those are the monitors whose lines are going to be longer than 100
columns later in the series.

Changing it there saves a bit of complication in the next patches,
where I only add lines for new events instead of splitting the line
/and/ adding the events.

Do you think I should mention this in the commit description?

Thanks,
Gabriele


