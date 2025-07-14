Return-Path: <linux-kernel+bounces-729975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE4DB03E7B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C301C7A788A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2D51EFF96;
	Mon, 14 Jul 2025 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGN1Mr5q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5738222129F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495494; cv=none; b=VohYk3wju7qo3AQZ8kg2sDw7gyFxOUuTJNWDhI4HqUEXCWl/2xkMZ9RliA3eF0UHgjI24V762BxlvRwDCx8OVCdK51rdYh+JmOppdiYESG2AsQmHqrBZIKWeBKwPfAWss1ma9B8GiHuEGhLgZOpTZOLAKmC17wDH5PxQX6Q4I3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495494; c=relaxed/simple;
	bh=sbTH7bpIqbBT2avO8Y/yC0htibWJIa1RkAgN4GHKga0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kS+8RteqPiyY+N3+dmUYPUJRPs5Fynns/rPcnnavltdPczeazqfbRJ/zTJYcSSaYQD50s2jFaoAa+W1eElZjE6pjdaKfDNPWxA/qOKeB4jN0lHtGYGyFPdlTaZMW8Ol6PuVBk9oWkIDbipDnpMPJsCalUN9jhY7Itad4KlMS+L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AGN1Mr5q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752495491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vF4RRl/e27zgqzxDxG5kIPXppzZTec0QHAD68B9ffyk=;
	b=AGN1Mr5qBMNx/vWTww4+g9Je//U3iQd4Ob3kOPgdmQfRWCCHDa/kPt3Vr8aorwyXsty/qp
	SAEvD7zbChMSeDxaQcXc7j8yIitiFB20IY0AA9N5U279+LS+dPqrcxkuEchKP5cwv3t9lt
	qlRPIkrpX93Zm1/kyPrRU7zgcN2k0BY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-5l5toJnzOgSHQcBPY_bh8A-1; Mon, 14 Jul 2025 08:18:09 -0400
X-MC-Unique: 5l5toJnzOgSHQcBPY_bh8A-1
X-Mimecast-MFC-AGG-ID: 5l5toJnzOgSHQcBPY_bh8A_1752495489
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4eee2398bso2073657f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 05:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752495489; x=1753100289;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vF4RRl/e27zgqzxDxG5kIPXppzZTec0QHAD68B9ffyk=;
        b=KIS1Xden7OfFc0HGjUxeX9tUlFwG1df4W26vW65nues1QA1uL6OjFvpGxBXAGeermQ
         HpdSNwo/fiHAPzWGyXyjGD1i/zuWRvHKkZkApGE8V0TDWzrJruAy4bKbMQkrHZ2fAwwb
         tBfQNvqp3Dfh5YEk44yHoOTK8GA1cpFfoYQlnPpfrBDFRdy4XnUgk+7dZVDRoxPbqqJj
         hPjtW0u9SC3LWi+TO9c5kH4ty/LOst3skLdW6A5a9OTV2d+QI2ZCFplnC5zWnLQtephh
         T6exzLYnAvhw0tJp/iZTOBT84z3yLqraPSPiCnSHfmaqAKrbEwo7A/bSjpvPm/w2NHhB
         LdkA==
X-Forwarded-Encrypted: i=1; AJvYcCVz8LPrkMut+evjdCJAt4/1B6Bw0A1ldO3gBk3XCJdT/t1F6r6oMBKnAUsiKAT6xRIIhN1mje54A0jpJ9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+cGm8RmYWvE//mMO01tu6tAIvTRlaNhgBwVtaqsmR6IF+zXye
	RlOF/fQ5vqYeCC6N92jzomkjvZuqtNURQ40R7CreqatJ364yBL6IYNqIcQ6yXDUrKtTQDFshLgx
	IQ1L80gA0TdlZm+zYooC2EK7Ue/rho30eu5w5eSiNzgJuu3OMrrBV2NnrdCGeK+mp/g==
X-Gm-Gg: ASbGnculpX4WmpKwqSkZr3a1OPrQBhQ7OFtwpOS4tuIvafxlG2KC5SnydLscVSNoyE5
	hNhaJ6FERH4usK2QqyCGuHG6lKQH54nyFYJ456rH2P3LFu+//+NT+SD5bi6Eil4W3jqm2yDh6DT
	vnvJtJqnzlZlAK7IY6sFqui2vFDyZGJGKXOJhp5VUVemj/r94FVuSs9yUWmgS1sLqrVewyYQplx
	iDWJhbdi1SMDrx/qN2CvppiGKwW2aAOE1GXAEM2jTApLDVIeDOJ01jnMgKWGjggmkheUhYqmhNj
	4/ijJg9fdUhwZ9wFQUU4OUWMPuIt86XR0FuwCeTv+pqgGw7w2ivo/laddbUdmMvIoA==
X-Received: by 2002:a05:6000:3c1:b0:3b5:e792:18ce with SMTP id ffacd0b85a97d-3b5f3535dacmr7518348f8f.22.1752495488560;
        Mon, 14 Jul 2025 05:18:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8Nf6WPAKZGYybLTu8M3aBAKMcW9iO8m3H/R8fR2RDf0WhuGHwniepHzcEfAGdHD7s4onvbw==
X-Received: by 2002:a05:6000:3c1:b0:3b5:e792:18ce with SMTP id ffacd0b85a97d-3b5f3535dacmr7518329f8f.22.1752495487950;
        Mon, 14 Jul 2025 05:18:07 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc3a54sm12452681f8f.39.2025.07.14.05.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 05:18:07 -0700 (PDT)
Message-ID: <7f4409eae10023a804d24ad2a9c67d368db152cb.camel@redhat.com>
Subject: Re: [PATCH 2/2] verification/rvgen: Support the 'next' operator
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers	 <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 14 Jul 2025 14:18:05 +0200
In-Reply-To: <9c32cec04dd18d2e956fddd84b0e0a2503daa75a.1752239482.git.namcao@linutronix.de>
References: <cover.1752239482.git.namcao@linutronix.de>
		 <9c32cec04dd18d2e956fddd84b0e0a2503daa75a.1752239482.git.namcao@linutronix.de>
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

On Fri, 2025-07-11 at 15:17 +0200, Nam Cao wrote:
> The 'next' operator is a unary operator. It is defined as: "next
> time, the
> operand must be true".
>=20
> Support this operator. For RV monitors, "next time" means the next
> invocation of ltl_validate().
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Hi Nam,

thanks for the series, I did a very stupid test like this:

  RULE =3D always (SCHEDULING imply next SWITCH)

Despite the monitor working or not, the generator created code that
doesn't build, specifically:

1. It creates a variable named switch
  - sure I could change the name, but perhaps we could prepend
something to make sure local variables are not C keywords

2. It created unused variables in ltl_start
  - _fill_atom_values creates all variables but _fill_start uses only
those where the .init field is true (maybe the model is wrong though)

Now, this specific model reports errors without the sched_switch_vain
tracepoint which I'm introducing in another patch.

For it to work, I have to define it in such a way that scheduling
becomes true at schedule_entry and becomes false right after the
switch:

schedule_entry
	SCHEDULING=3Dtrue

sched_switch
	SWITCH=3Dtrue

schedule_exit
	SCHEDULING=3Dfalse
	SWITCH=3Dfalse

If I understood correctly that's intended behaviour since swapping the
assignments in schedule_exit (or doing a pulse in sched_switch) would
add another event when scheduling is true, which is against the next
requirement.

Now I can't think of a way to rewrite the model to allow a pulse in
sched_switch, that is /whenever scheduling turns to true, the next
event is a switch/ instead of /any time scheduling is true, the next
event is a switch/.

I tried something like:
  RULE =3D always ((not SCHEDULING and next SCHEDULING) imply next
SWITCH)
but the parser got the two SCHEDULING as two different atoms, so I
guess I did something I was not supposed to do..

Is the next operator only meaningful for atoms that are mutually
exclusive (e.g. RED next GREEN, if GREEN is true RED turns to false)
and/or when playing with ltl_atom_set without triggering validations?

What am I missing here?

Thanks,
Gabriele

> ---
> =C2=A0.../trace/rv/linear_temporal_logic.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0tools/verification/rvgen/rvgen/ltl2ba.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 26
> +++++++++++++++++++
> =C2=A02 files changed, 27 insertions(+)
>=20
> diff --git a/Documentation/trace/rv/linear_temporal_logic.rst
> b/Documentation/trace/rv/linear_temporal_logic.rst
> index 57f107fcf6dd..9eee09d9cacf 100644
> --- a/Documentation/trace/rv/linear_temporal_logic.rst
> +++ b/Documentation/trace/rv/linear_temporal_logic.rst
> @@ -41,6 +41,7 @@ Operands (opd):
> =C2=A0Unary Operators (unop):
> =C2=A0=C2=A0=C2=A0=C2=A0 always
> =C2=A0=C2=A0=C2=A0=C2=A0 eventually
> +=C2=A0=C2=A0=C2=A0 next
> =C2=A0=C2=A0=C2=A0=C2=A0 not
> =C2=A0
> =C2=A0Binary Operators (binop):
> diff --git a/tools/verification/rvgen/rvgen/ltl2ba.py
> b/tools/verification/rvgen/rvgen/ltl2ba.py
> index d11840af7f5f..f14e6760ac3d 100644
> --- a/tools/verification/rvgen/rvgen/ltl2ba.py
> +++ b/tools/verification/rvgen/rvgen/ltl2ba.py
> @@ -19,6 +19,7 @@ from ply.yacc import yacc
> =C2=A0# Unary Operators (unop):
> =C2=A0#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 always
> =C2=A0#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eventually
> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next
> =C2=A0#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 not
> =C2=A0#
> =C2=A0# Binary Operators (binop):
> @@ -35,6 +36,7 @@ tokens =3D (
> =C2=A0=C2=A0=C2=A0 'UNTIL',
> =C2=A0=C2=A0=C2=A0 'ALWAYS',
> =C2=A0=C2=A0=C2=A0 'EVENTUALLY',
> +=C2=A0=C2=A0 'NEXT',
> =C2=A0=C2=A0=C2=A0 'VARIABLE',
> =C2=A0=C2=A0=C2=A0 'LITERAL',
> =C2=A0=C2=A0=C2=A0 'NOT',
> @@ -48,6 +50,7 @@ t_OR =3D r'or'
> =C2=A0t_IMPLY =3D r'imply'
> =C2=A0t_UNTIL =3D r'until'
> =C2=A0t_ALWAYS =3D r'always'
> +t_NEXT =3D r'next'
> =C2=A0t_EVENTUALLY =3D r'eventually'
> =C2=A0t_VARIABLE =3D r'[A-Z_0-9]+'
> =C2=A0t_LITERAL =3D r'true|false'
> @@ -327,6 +330,26 @@ class AlwaysOp(UnaryOp):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # ![]F =3D=3D <>(!F)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return EventuallyOp(self=
.child.negate()).normalize()
> =C2=A0
> +class NextOp(UnaryOp):
> +=C2=A0=C2=A0=C2=A0 def normalize(self):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return self
> +
> +=C2=A0=C2=A0=C2=A0 def _is_temporal(self):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return True
> +
> +=C2=A0=C2=A0=C2=A0 def negate(self):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # not (next A) =3D=3D next (n=
ot A)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.child =3D self.child.neg=
ate()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return self
> +
> +=C2=A0=C2=A0=C2=A0 @staticmethod
> +=C2=A0=C2=A0=C2=A0 def expand(n: ASTNode, node: GraphNode, node_set) ->
> set[GraphNode]:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D GraphNode(node.incomi=
ng,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node.new=
,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node.old=
 | {n},
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node.nex=
t | {n.op.child})
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return tmp.expand(node_set)
> +
> =C2=A0class NotOp(UnaryOp):
> =C2=A0=C2=A0=C2=A0=C2=A0 def __str__(self):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "!" + str(self.ch=
ild)
> @@ -452,12 +475,15 @@ def p_unop(p):
> =C2=A0=C2=A0=C2=A0=C2=A0 '''
> =C2=A0=C2=A0=C2=A0=C2=A0 unop : ALWAYS ltl
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | EVENTUALLY ltl
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | NEXT ltl
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | NOT ltl
> =C2=A0=C2=A0=C2=A0=C2=A0 '''
> =C2=A0=C2=A0=C2=A0=C2=A0 if p[1] =3D=3D "always":
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D AlwaysOp(p[2])
> =C2=A0=C2=A0=C2=A0=C2=A0 elif p[1] =3D=3D "eventually":
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D EventuallyOp(p[2]=
)
> +=C2=A0=C2=A0=C2=A0 elif p[1] =3D=3D "next":
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D NextOp(p[2])
> =C2=A0=C2=A0=C2=A0=C2=A0 elif p[1] =3D=3D "not":
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D NotOp(p[2])
> =C2=A0=C2=A0=C2=A0=C2=A0 else:


