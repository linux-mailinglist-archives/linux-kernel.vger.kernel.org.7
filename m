Return-Path: <linux-kernel+bounces-733118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29323B07060
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EAF54A3560
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58072EACE2;
	Wed, 16 Jul 2025 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfT36+yS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182231F91C7
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654195; cv=none; b=XHZ8B+mKV+uNCLQgnvR49DGxBdCCU6C/S0tgLbdQn9nJuY6rTvJG1cVHD+ElkHRj9jF1V43Mdd4/d2pcogJs/vBAv4RnNli1n980k28KY7NorapkFwKldjl1OO9m+m+U0KxPGodFFGbLIJ0xfQ8loc5dveITp2luJ9sMiQF7rPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654195; c=relaxed/simple;
	bh=QhC5fRs5doJKhReUEEOwneof8iIMeW+qGMvAnKgzko0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F84r18ilAy+UYKtJ5rdZ8lgzXg1nvMyd5oc0GgtGuwkCLra2kd3EbIRBv1ndHf5sfRctVB/2l7bczQK2ue5gfM/BQKcpKaowvVMFDoYiZVAKyMyIQostmI8bA8t2XdYvTBEl/FyooBh5/JsAmEBTNbQek9RNUSjoYpTTSrx0bGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JfT36+yS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752654192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c1PstcO+u1wqs0BunJ8+c2Z9ZKN5Z+UyDqsIxKyzBg4=;
	b=JfT36+ySHwHdbRWL1RsM287/+zvOImWfEODmB/f+J/MQhhaSRgmaKXFmqJ3rM6dr7eiNzS
	0a7wr+zd0m9igbLsRRSObMaxLD2+IqREZYSYaecaPIHImkeuOIh6/atX3zkdroj/SpqfGX
	nsKkc8bvsPWuFipFicnmy3c03rW1OVY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-Yz-9WuWZNw29vJ2qJ9dX9w-1; Wed, 16 Jul 2025 04:20:43 -0400
X-MC-Unique: Yz-9WuWZNw29vJ2qJ9dX9w-1
X-Mimecast-MFC-AGG-ID: Yz-9WuWZNw29vJ2qJ9dX9w_1752654042
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso4201825e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752654042; x=1753258842;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1PstcO+u1wqs0BunJ8+c2Z9ZKN5Z+UyDqsIxKyzBg4=;
        b=jVk6Ox8tLUjiNCtRemJIajyu/EayI6spmY5pyO1kOnxM3408gRDj3VRS5ouNt/1ZdT
         rCaCB2KmTgYg5e5j/WOeZGhyF7RrmYFqu9P6kXsFNXXN9W9hlxtCRnZFXtNIsy0p4Djc
         lvE6RT7zNUxrKNnojyUTM4e9QKKaf46CrexpPhTiiDx80GNMTt8fXyWRxziQ16U8Xi90
         7OSBD37TGjVo12ioPzsIkvzzC5udF3Wj1AsIZuIJUzoKDsJpqJNYMhp932tJGqanLqS4
         1DyLOk3IfCL2q1VCRSDhuwXq9aDcX8M2+N6SRRuOB07j23wIjnxhVHbazU/HuKXkwBYF
         h+nQ==
X-Gm-Message-State: AOJu0Yxi18xAXtFqGZBJxW/C6Ig7mVnV4xVsXBaB0pHAV9qDD2Ytwns4
	Div9EGQQHmLjaVKQLJl/oJ/0F68lCoryv23R2ZnYKWgOLFWmzsua0SsogUB2BWLiG6/Cb7WHgDu
	ZQOhhh8NIyaAoWC66M4TqsJU+w8JjZ46pKdcd5gSucbEXsqhcVIOiWYTFizUujJhqJA==
X-Gm-Gg: ASbGncvjfT6oUPZx0DOAN2UDtO9Spy3QRcuFkmEI48C3ZXp5IsfzS/Q66cDJl5lS5GL
	EzF7yyHAwXWYeDUWi6PYanUXTSH3vROLSlS7ZpEElLBXlBju/K7ZaoJHoVS9tJ6asD7MlgutLxl
	gI8At2mNK5DECh25kj3tHytWYC72lrEkzi3PcTd39eLa3zYUcm9CuNBPNAaN0IDUmsY41qeA+oh
	EyVrw9N+PAcVjG23CuwuemDmaN53Y3uklnCEStokT3CaJppByu4iJ180vlM2ztEjmjEqHcpb7DB
	1lK9kYWxMukiFul6CQOGz6q5tm0YcPE1GZNw/BWnZQPYPcbaJV1DYu/4wSQvzasa1A==
X-Received: by 2002:a05:600c:4d88:b0:43c:f509:2bbf with SMTP id 5b1f17b1804b1-45625e8a225mr45136215e9.15.1752654041596;
        Wed, 16 Jul 2025 01:20:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWkWCHJjMY/myYk22StZdJs0ukLJ/nMqa3agTLjrAQaPWBsJTzFUh42lf3aHQpm/gQUOAuhg==
X-Received: by 2002:a05:600c:4d88:b0:43c:f509:2bbf with SMTP id 5b1f17b1804b1-45625e8a225mr45136025e9.15.1752654041084;
        Wed, 16 Jul 2025 01:20:41 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e5780efsm13699155e9.0.2025.07.16.01.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 01:20:40 -0700 (PDT)
Message-ID: <e2f4f8d372612cd61689b91562e73677599d08de.camel@redhat.com>
Subject: Re: [PATCH v3 11/17] rv: Retry when da monitor detects race
 conditions
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>,  Clark Williams <williams@redhat.com>, John
 Kacur <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 10:20:39 +0200
In-Reply-To: <20250715152322.Os4lDq_B@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-12-gmonaco@redhat.com>
	 <20250715152322.Os4lDq_B@linutronix.de>
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



On Tue, 2025-07-15 at 17:23 +0200, Nam Cao wrote:
> On Tue, Jul 15, 2025 at 09:14:28AM +0200, Gabriele Monaco wrote:
> > =C2=A0static inline
> > bool										\
> > =C2=A0da_event_##name(struct da_monitor *da_mon, enum events_##name
> > event)				\
> > =C2=A0{							=09
> > 				\
> > -	type curr_state =3D
> > da_monitor_curr_state_##name(da_mon);					\
> > -	type next_state =3D model_get_next_state_##name(curr_state,
> > event);			\
> > -
> > 												\
> > -	if (next_state !=3D INVALID_STATE)
> > {							\
> > -		da_monitor_set_state_##name(da_mon,
> > next_state);				\
> > -
> > 												\
> > -
> > 		trace_event_##name(model_get_state_name_##name(curr_state),			\
> > -				=C2=A0=C2=A0
> > model_get_event_name_##name(event),				\
> > -				=C2=A0=C2=A0
> > model_get_state_name_##name(next_state),			\
> > -				=C2=A0=C2=A0
> > model_is_final_state_##name(next_state));			\
> > -
> > 												\
> > -		return
> > true;									\
> > +	enum states_##name curr_state,
> > next_state;						\
> > +							=09
> > 				\
> > +	curr_state =3D READ_ONCE(da_mon-
> > >curr_state);						\
> > +	for (int i =3D 0; i < MAX_DA_RETRY_RACING_EVENTS; i++)
> > {					\
> > +		next_state =3D
> > model_get_next_state_##name(curr_state, event);			\
> > +		if (next_state =3D=3D
> > INVALID_STATE)						\
> > +			goto
> > out_react;								\
> > +		if (likely(try_cmpxchg(&da_mon->curr_state,
> > &curr_state, next_state)))		\
> > +			goto
> > out_success;							\
> > =C2=A0	}						=09
> > 				\
> > +	/* Special invalid transition if we run out of retries.
> > */				\
> > +	curr_state =3D
> > INVALID_STATE;								\
> > =C2=A0							=09
> > 				\
> > +out_react:						=09
> > 				\
> > =C2=A0	cond_react_##name(curr_state,
> > event);							\
> > =C2=A0							=09
> > 				\
> > =C2=A0	trace_error_##name(model_get_state_name_##name(curr_state)
> > ,				\
> > =C2=A0			=C2=A0=C2=A0
> > model_get_event_name_##name(event));					\
>=20
> If I understand correctly, if after 3 tries and we still fail to
> change the
> state, we will invoke the reactor and trace_error? Doesn't that cause
> a
> false positive? Because it is not a violation of the model, it is
> just a
> race making us fail to change the state.
>=20

Yes, that's correct.
My rationale was that, at that point, the monitor is likely no longer
in sync, so silently ignoring the situation is not really an option.
In this case, the reaction includes an invalid current state (because
in fact we don't know what the current state is) and tools may be able
to understand that. I know you wouldn't be able to do that in LTL..
By the way, LTL uses multiple statuses, so this lockless approach may
not really work.

I don't see this situation happening often: I only ever observed 2
events able to race, 4 happening at the same time is wild, but of
course cannot be excluded in principle for any possible monitor.
Yet, I have the feeling a monitor where this can happen is not well
designed and RV should point that out.
Do you have ideas of potential monitors where more than 3 events can
race?

Perhaps a full blown reaction is a bit aggressive in this situation, as
the /fault/ may not be necessarily in the monitor.
We could think of a special tracepoint or just printing.

> Same below.
>=20
> Also, I wouldn't use goto unless necessary. Perhaps it is better to
> put the
> code at "out_react:" and "out_success:" into the loop. But that's
> just my
> personal preference, up to you.

That could be done if we do a whole different thing when retries run
out, instead of defaulting to out_react.
I liked to avoid excessive indentation with those goto as well but
yeah, it may not be quite necessary.

I'll have a deeper thought on this.

Thanks,
Gabriele


