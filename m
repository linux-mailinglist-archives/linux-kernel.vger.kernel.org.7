Return-Path: <linux-kernel+bounces-775461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D3FB2BF6C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14690624A69
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9C0322DA6;
	Tue, 19 Aug 2025 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R29ZQdnR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D821F8722
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600818; cv=none; b=igiXb8uaRLszuNhX16TPmpgih+/AMm1jduEBFFdjGzJFudHOWy57SvZPHHwM5F8y7KB6i8oBDFc6xYe13yBQrTFvyQLoO/hY5CNyVxiM8ySpuXNlm+vQ8vTZcFyKFxqaM5nOdWJV6UxEbU3exrg75c38eaAZbnHCHYbw1ovKhwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600818; c=relaxed/simple;
	bh=EO7ENISm3BJxsvKkBt5+Cb5jSwNR2GlaMZL8G5qc7Rs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E7EtMQJKh2QgTMFQmO/uHe1XFWu4TwZRdfsqLfcsbNDqwFqJjIKxGw37t5QkPUFjdQvZFEYn5PNUKvBFrRhHYGG/Xh+Zi/KWMcKY9FzNB3b9VxnOaOmLheMcQbu0CB3cNwzVMrn4deZyh1TViSfsgmZfL3QP52E6YC+Lp571GKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R29ZQdnR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755600815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EO7ENISm3BJxsvKkBt5+Cb5jSwNR2GlaMZL8G5qc7Rs=;
	b=R29ZQdnReF3/qyFeGRw3BPeQtpwp70kbGeOzzoAcB0lMBOz/Yl98d+9asRxssEtU71Ium6
	fRmJkBnDTULszLEFdEuw+Dv/KD0ZoAZ0uL+yYQmLnkzDBMIV3s+HAMRnyOjaKZ5Y1XTiRv
	3lBGzeuCdxtdfNd5Thz17hLbmPah3uI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-bJ98OXKrNBuMW_uLJ-qCMA-1; Tue, 19 Aug 2025 06:53:33 -0400
X-MC-Unique: bJ98OXKrNBuMW_uLJ-qCMA-1
X-Mimecast-MFC-AGG-ID: bJ98OXKrNBuMW_uLJ-qCMA_1755600813
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e88f379fafso1297018985a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755600813; x=1756205613;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EO7ENISm3BJxsvKkBt5+Cb5jSwNR2GlaMZL8G5qc7Rs=;
        b=ZmZlDJc60c0mpqFtJuh+hH0u+TIykTWpHND7w+pmXlnZ8vg6OIL9MOAs27yDibwyg0
         dMHyRF9oTyOiipq8dF7hTYLGyDif5tn2byYcg5SqmedUMMwqN9F3w4M8gVSbJNj+8S9S
         lMncEcYYh0Oq9TZhapHMtNFMKxurAfhxq1VizUBda3+wDoKCfJI9MFJricZWi8mczCTg
         IktfD2s8+jKyzD/INXiJl+CXemI3cSInajjlnrcil2TWuqWeldd5WCea1MgPs+/xERit
         Exu6ta7/+ieJZgSwzMPxYTO2nnEFC1X5yd2WqP0SmnVkoH/7z3periahPshPYqq0pxkd
         J6/w==
X-Gm-Message-State: AOJu0YzEJC0PvXbXSioGcbuDC5C2zbtgekBwoIASRiTWeghrbfVpsDhv
	ualMv/jD3G4hbjpVq+DTNAf+ryTOdpoUP4XmJOw3dogZlLFCDK1BTXP2BW2/PnrnURNXrGCF48V
	Aik7NEte+/JpxNbfO2L0Y/k+ELN57fUF53UxiGqu1HewCK5T/55vsC1pPF2QzXtHevQ==
X-Gm-Gg: ASbGnctEcHorV3x7i5vTRnFyHgG+1UW9Worp1yySqZ+Fv0WhGjNk9672U+h5z9Kci2H
	4AuwSavBdn3upbp39duXdr/onodTy0UanuPNKBeF1GfPNKhGduj9Z3OMQxLx++fS/n9C0kHX2T1
	JzenKPWLxiikEGjfOoNbjknWRiJ+NKQ/OrgIWv2yUFLaOEWb8HY6laFlQrRqWjYn0ZgyurvV+sj
	5Zo3qrhNlUooDcnSl1UWt97GVj6mezDdQ0DNlDVtLaQp22gtL/YJBOK00KOZib0iM44W2EyFtI6
	cgbcNFexHuMFRiYqYzxfFZBuFMIHiPPDILqYi1Ku19sQMvyD7FqtgoXqMY4Ncbvz3g==
X-Received: by 2002:a05:620a:6919:b0:7e8:5bb:b398 with SMTP id af79cd13be357-7e9f33150acmr222348485a.9.1755600813286;
        Tue, 19 Aug 2025 03:53:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP30Q9P2VNlQmQH24vup08QANMA6P1yMtCmVsXUmoSlrvw+NxlGy89RF9eCDaDscDIOYA0ig==
X-Received: by 2002:a05:620a:6919:b0:7e8:5bb:b398 with SMTP id af79cd13be357-7e9f33150acmr222346485a.9.1755600812832;
        Tue, 19 Aug 2025 03:53:32 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e0228f1sm759267485a.8.2025.08.19.03.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:53:32 -0700 (PDT)
Message-ID: <d907bcaa640a44ecb739b3253df49e16bcd4e38d.camel@redhat.com>
Subject: Re: [RFC PATCH 08/17] rv: Add Hybrid Automata monitor type
From: Gabriele Monaco <gmonaco@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>,  John
 Kacur <jkacur@redhat.com>
Date: Tue, 19 Aug 2025 12:53:29 +0200
In-Reply-To: <aKRNMHCslAt3dx5t@jlelli-thinkpadt14gen4.remote.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-9-gmonaco@redhat.com>
	 <aKRBg-KhyCqgFEg3@jlelli-thinkpadt14gen4.remote.csb>
	 <762f7d52bf75475d3ec2587a8e370e4fb2a5ae6a.camel@redhat.com>
	 <aKRNMHCslAt3dx5t@jlelli-thinkpadt14gen4.remote.csb>
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



On Tue, 2025-08-19 at 12:08 +0200, Juri Lelli wrote:
> On 19/08/25 11:48, Gabriele Monaco wrote:
> > That's a good point, I need to check the actual overhead..
> >=20
> > One thing to note is that this timer is used only on state
> > constraints,
> > one could write roughly the same monitor like this:
> >=20
> > =C2=A0 +------------------------------------------+
> > =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enqueued=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > =C2=A0 +------------------------------------------+
> > =C2=A0=C2=A0=C2=A0 |
> > =C2=A0=C2=A0=C2=A0 | sched_switch_in;clk < threshold_jiffies
> > =C2=A0=C2=A0=C2=A0 v
> >=20
> > or like this:
> >=20
> > =C2=A0 +------------------------------------------+
> > =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enqueued=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk < threshol=
d_jiffies=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > =C2=A0 +------------------------------------------+
> > =C2=A0=C2=A0=C2=A0 |
> > =C2=A0=C2=A0=C2=A0 | sched_switch_in
> > =C2=A0=C2=A0=C2=A0 v
> >=20
> > the first won't fail as soon as the threshold passes, but will
> > eventually fail when the sched_switch_in event occurs. This won't
> > use a timer at all (well, mostly, some calls are still made to keep
> > the code general, I could improve that if it matters).
> >=20
> > Depending on the monitor, the first option could be a lower
> > overhead yet valid alternative to the second, if it's guaranteed
> > sched_switch_in will eventually come and reaction latency isn't an
> > issue.
>=20
> Right, as in the first example you have in the docs. I was thinking
> it would be cool to possibly replace the hung task monitor with this
> one, but again we would need to check for overhead, as the definition
> that does expect a switch_in to eventually happen wouldn't work in
> this case.

Yeah if the overhead is really high that might be an option. Although
the monitor might become a bit pointless then: if a task starves
forever, no error will be reported.

If that's a real issue, I might look at other options where to check
for constraints (the tick perhaps).

> > > Does this also need to be _HARD on RT for the monitor to work?
> >=20
> > That might be something we want configurable actually.. I assume
> > the more aggressive the timer is, the more overhead it will have on
> > the system.
> > Some monitors might be fine with a bit of latency.
>=20
> It might not only be about latency, as if the callback timer is not
> serviced in case of starvation (if it's not hard) then the monitor
> won't probably react and we won't be able to rely on it.

I think hit that in some conditions and changed the ha_cancel_timer()
to handle this case.

After leaving the state arming a timer, we always cancel it (to avoid
it expiring outside) at that time if it was expiring but the callback
didn't run, the monitor fails.

Again, if the monitor never leaves the state, we'd never report a
failure, but I'm not sure how common that is.

Thanks,
Gabriele


