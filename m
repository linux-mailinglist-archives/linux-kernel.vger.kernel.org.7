Return-Path: <linux-kernel+bounces-873210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAF8C135F8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DBC15029CE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4973B248898;
	Tue, 28 Oct 2025 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Df16USv6"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8599D86337
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761637788; cv=none; b=dHkWc9FeFr+Wrz3vb9DNNxTOWmf1FALhNRmY0+H9DfdVxjh+6cxDL+3A+mOagZ1UsHy72amQmdZ9XBqkwAvuPCcGb7yoZSYQbr3pEcYmTerUzZrqV6x9NAAn75EoK7dqYhl+Qa90gJIeZw+OvARmsaVWRzPK/UNwnlrJTL2owt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761637788; c=relaxed/simple;
	bh=xde4VpDak39g0S4VLqYId+aibXlv3b+Nn4ZFo8SnVCE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cht+7CiBXRjLOzLfYOZVIZtOk77++xAfjICzHhVpNKKhHg3NVet+5D93WZ70YpatVq1f9AVARIyGn38g/XI/Tkyt5zQyv9/AS5/AgnkYTmAsrDx7dBnx71/LDphQ5qe41HmJFcqtSgIQPGkHS+LdjcjnQDSwqzXwoeOAMSj0CJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Df16USv6; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-37902f130e1so16614861fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761637784; x=1762242584; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=599KCBsf74z9253rS1v8/WJK6GniRppSrGmNjd3JNU4=;
        b=Df16USv6fXkTMozzM7zpTOsApyC+k72BrCdObrzEYOA+5fq2+bk88fViCe2gF41+JV
         mQ7mr7NMFvhz2+qLDl3iHSsTJ4eoEinSdOO97cFqivFDtckC72oNxI59dUS/RpOBkSu1
         1cPJhGEmLAYtShSDFYidGsCExIBc/v7Inh93K0tKJdFom5gvmnKeu0rr2ftnaeM6sWxp
         FE/9Ozi9mB1zKZh6njEkLeN9etbetDaU9H8vMomEeiMtGpSHXZyzGU9zIdNB97UGi6we
         LId8RYSJZgXw75tx6+YQH5w4NmzNDfo7zTR9waDjPbk3YjdSqxfBwNSpRBX/RL5a43hc
         KQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761637784; x=1762242584;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=599KCBsf74z9253rS1v8/WJK6GniRppSrGmNjd3JNU4=;
        b=Eag70cXA1Q13MzCFOkijTYJ0b6/WTu57gdMm6d0Ak0CsT4GpAvPGAJc3lL/Q1jsZUc
         1+h2mqE5haaV00eunK/DO5YGpK1Gpd1cr/BTcJIwYXRfNLTnxN5gsL00jBM1Hup8Ilr4
         Rw2CBgAHP5NYqQQHAB4Y3HAXPZKTvJqj9fAwIdlj3VzXpE+uTTQlTwMJfzFHUHmaZrq/
         7ReQw1V4lQZicaI2TuxTMvHSwnmzaU3y3Kc+G1sVr0ft3q22uxvRSf74XB+CWVHWfYUq
         o3m6CAXs51Cx94F7rlEXaE3vGD2i6umgDYwFDi7qwaxMIj1crDB43WO1EKwYWYGNlXFf
         FCew==
X-Forwarded-Encrypted: i=1; AJvYcCWTJmKuzN3pSp05rsIhLMKSHhLd7nRNHw6WIfrHU1jn4gy+zugeWuBOVuD3NN02G+uN44YYhvpOcxlfwHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTJj1m2I62AlAmawAtdhbS9Oui8bRK2vv/A785d8d4/ykVIHxY
	7Zgw6gKK+1BFvTLcrfQLhgnKBBhc5iWPsjdRFbPBVh2Xy3ne+4bvDGSPYAjWB+3NbF/ozRHbbmH
	/wKtEQVWXf0GTh+2UdXrmPnQHrGcmEak=
X-Gm-Gg: ASbGncuhgkE+KSWh96fbglsUUvVFdlcyBVUwTU5satGa6wuYlROJ22FnaySd7nh7mBb
	V3UuG0x2M2wIViBXksmE9ZSpbbvwmfJHZ8EPFe3MGXpRxTWo9By5KwSuwHpNTIPJtdk7/zt9+za
	cespZtRgy/yyAfrHPeYOLQ1wuXNrusnPGbCdR43mfeJoHdiQzeLhQhylSfSgkOD9xA8XeVJhw2P
	80707anmH5TT3OuVLgD4cEawWO/+hj4Zkhh2uh6pkDVC+AURfAZougXb1jpCc4=
X-Google-Smtp-Source: AGHT+IH2BejTHHAppc5i+MLtbQ9Ba/am1ffHoIuDO9J1uNsvZpU1FSZDgA92e1yRaikWm0/RlVJ5cDZmXhv2BHqDSEw=
X-Received: by 2002:a2e:9a0e:0:b0:378:ee95:cb10 with SMTP id
 38308e7fff4ca-3790779e5c3mr7549691fa.44.1761637784189; Tue, 28 Oct 2025
 00:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tingjia Cao <tjcao980311@gmail.com>
Date: Tue, 28 Oct 2025 03:49:32 -0400
X-Gm-Features: AWmQ_bmD3TUW_gld4khNnCFdO-2m1sCL8Yu7g_nOQ7cXlwxVXPN9Bh2LtIRNXgk
Message-ID: <CABcWv98gu6HqbOEoOPBL4tJrcGmU=1x3=fN3Fpho8wiY+D22CQ@mail.gmail.com>
Subject: [BUG] select_idle_sibling() doesn't consider sync wakeup logic
To: mingo@redhat.com, peterz@infradead.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, dietmar.eggemann@arm.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000599b650642334290"

--000000000000599b650642334290
Content-Type: multipart/alternative; boundary="000000000000599b64064233428e"

--000000000000599b64064233428e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

We have observed an issue in the CFS scheduler's task placement logic
present in kernel versions v6.14 and latest v6.18-rc3.

The function select_idle_sibling() in *fair.c* does not correctly handle
the WF_SYNC wakeup flag, leading to suboptimal placement of newly awakened
child tasks.

The core issue lies in a logical contradiction between wake_affine_idle()
and select_idle_sibling() when sync is true.

1. Intended Behavior (wake_affine_idle): During a sync wakeup (WF_SYNC is
true), the scheduler's intent is to place the child task on this_cpu (the
parent's current CPU) if there is only 1 runnable task. The rationale is
that the parent is expected to go to sleep almost immediately, making its
CPU available. It keeps the child task on a CPU with a hot cache.
static int wake_affine_idle(int this_cpu, int prev_cpu, int sync) {
    ...
    if ((rq->nr_running - cfs_h_nr_delayed(rq)) =3D=3D 1)
        return this_cpu;
    ...
}

2. Flawed Behavior (select_idle_sibling): When select_task_rq_fair() later
calls select_idle_sibling() with "this_cpu" as the "target", it rejects the
"target" because it is not currently idle (the parent is still running).
Instead, it searches for an actually idle sibling CPU within the same LLC
domain. During a sync wakeup, however, the scheduler assumes the parent
will sleep immediately and should treat the parent=E2=80=99s CPU as effecti=
vely
available if it's the only runnable task.

3. The Consequence: The wakee is placed on a remote idle sibling rather
than on the idle parent=E2=80=99s CPU, losing cache locality. The remote CP=
U may
also have been idle in a deeper C-state and/or at a lower frequency,
further hurting the child=E2=80=99s performance.

Kernel Info
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Host OS: on ubuntu24.04, running qemu with "-smp cpus=3D3,cores=3D3"
Processor: Two Intel Xeon Silver 4114 10-core CPUs at 2.20 GHz
Kernel Version: v6.14 and latest v6.18-rc3

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
We attached a patch to fix this issue. Thank you for the effort!

Best,
Tingjia

--000000000000599b64064233428e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><br>We have observed an issue in the CFS schedul=
er&#39;s task placement logic present in kernel versions v6.14 and latest v=
6.18-rc3.<br><br>The function select_idle_sibling() in <b>fair.c</b> does n=
ot correctly handle the WF_SYNC wakeup flag, leading to suboptimal placemen=
t of newly awakened child tasks.<br><br>The core issue lies in a logical co=
ntradiction between wake_affine_idle() and select_idle_sibling() when sync =
is true.<br><br>1. Intended Behavior (wake_affine_idle): During a sync wake=
up (WF_SYNC is true), the scheduler&#39;s intent is to place the child task=
 on this_cpu (the parent&#39;s current CPU) if there is only 1 runnable tas=
k. The rationale is that the parent is expected to go to sleep almost immed=
iately, making its CPU available. It keeps the child task on a CPU with a h=
ot cache.<br>static int wake_affine_idle(int this_cpu, int prev_cpu, int sy=
nc) {<div>=C2=A0 =C2=A0 ...<br>=C2=A0 =C2=A0 if ((rq-&gt;nr_running - cfs_h=
_nr_delayed(rq)) =3D=3D 1)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return this_cpu;<=
/div><div>=C2=A0 =C2=A0 ...</div><div>}<br><br>2. Flawed Behavior (select_i=
dle_sibling): When select_task_rq_fair() later calls select_idle_sibling() =
with &quot;this_cpu&quot; as the &quot;target&quot;, it rejects the &quot;t=
arget&quot; because it is not currently idle (the parent is still running).=
 Instead, it searches for an actually idle sibling CPU within the same LLC =
domain. During a sync wakeup, however, the scheduler assumes the parent wil=
l sleep immediately and should treat the parent=E2=80=99s CPU as effectivel=
y available if it&#39;s the only runnable task.<br><br>3. The Consequence: =
The wakee is placed on a remote idle sibling rather than on the idle parent=
=E2=80=99s CPU, losing cache locality. The remote CPU may also have been id=
le in a deeper C-state and/or at a lower frequency, further hurting the chi=
ld=E2=80=99s performance.</div><div><br>Kernel Info<br>=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Host OS: on ubuntu24.04, running qemu with &=
quot;-smp cpus=3D3,cores=3D3&quot;<br>Processor: Two Intel Xeon Silver 4114=
 10-core CPUs at 2.20 GHz<br>Kernel Version: v6.14 and latest v6.18-rc3</di=
v><div><br></div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><d=
iv>We attached a patch to fix this issue. Thank=C2=A0you for the effort!<br=
></div><div><br></div><div>Best,</div><div>Tingjia</div></div>

--000000000000599b64064233428e--
--000000000000599b650642334290
Content-Type: application/octet-stream; 
	name="0001-consider-sync-wakeup-when-selecting-idle-sibling.patch"
Content-Disposition: attachment; 
	filename="0001-consider-sync-wakeup-when-selecting-idle-sibling.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mha8zwvw0>
X-Attachment-Id: f_mha8zwvw0

RnJvbSA4YTJjODU1NzY4YWRkMmViNTNjMjQ5NmE1MjMwYThjMWQ3YzY3N2JmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaW5namlhLTB2MCA8dGpjYW85ODAzMTFAZ21haWwuY29tPgpE
YXRlOiBUdWUsIDI4IE9jdCAyMDI1IDAyOjMwOjU3IC0wNTAwClN1YmplY3Q6IFtQQVRDSF0gY29u
c2lkZXIgc3luYyB3YWtldXAgd2hlbiBzZWxlY3RpbmcgaWRsZSBzaWJsaW5nCgotLS0KIGtlcm5l
bC9zY2hlZC9mYWlyLmMgfCAxMCArKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9mYWlyLmMg
Yi9rZXJuZWwvc2NoZWQvZmFpci5jCmluZGV4IGNlZTE3OTNlODI3Ny4uMDE0MjBhNDgxYzM4IDEw
MDY0NAotLS0gYS9rZXJuZWwvc2NoZWQvZmFpci5jCisrKyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMK
QEAgLTEwNjQsNyArMTA2NCw3IEBAIHN0YXRpYyBib29sIHVwZGF0ZV9kZWFkbGluZShzdHJ1Y3Qg
Y2ZzX3JxICpjZnNfcnEsIHN0cnVjdCBzY2hlZF9lbnRpdHkgKnNlKQogCiAjaW5jbHVkZSAicGVs
dC5oIgogCi1zdGF0aWMgaW50IHNlbGVjdF9pZGxlX3NpYmxpbmcoc3RydWN0IHRhc2tfc3RydWN0
ICpwLCBpbnQgcHJldl9jcHUsIGludCBjcHUpOworc3RhdGljIGludCBzZWxlY3RfaWRsZV9zaWJs
aW5nKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwgaW50IHByZXZfY3B1LCBpbnQgY3B1LCBpbnQgc3lu
Yyk7CiBzdGF0aWMgdW5zaWduZWQgbG9uZyB0YXNrX2hfbG9hZChzdHJ1Y3QgdGFza19zdHJ1Y3Qg
KnApOwogc3RhdGljIHVuc2lnbmVkIGxvbmcgY2FwYWNpdHlfb2YoaW50IGNwdSk7CiAKQEAgLTc4
MTAsMTIgKzc4MTAsMTMgQEAgc3RhdGljIGlubGluZSBib29sIGFzeW1fZml0c19jcHUodW5zaWdu
ZWQgbG9uZyB1dGlsLAogLyoKICAqIFRyeSBhbmQgbG9jYXRlIGFuIGlkbGUgY29yZS90aHJlYWQg
aW4gdGhlIExMQyBjYWNoZSBkb21haW4uCiAgKi8KLXN0YXRpYyBpbnQgc2VsZWN0X2lkbGVfc2li
bGluZyhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIGludCBwcmV2LCBpbnQgdGFyZ2V0KQorc3RhdGlj
IGludCBzZWxlY3RfaWRsZV9zaWJsaW5nKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwgaW50IHByZXYs
IGludCB0YXJnZXQsIGludCBzeW5jKQogewogCWJvb2wgaGFzX2lkbGVfY29yZSA9IGZhbHNlOwog
CXN0cnVjdCBzY2hlZF9kb21haW4gKnNkOwogCXVuc2lnbmVkIGxvbmcgdGFza191dGlsLCB1dGls
X21pbiwgdXRpbF9tYXg7CiAJaW50IGksIHJlY2VudF91c2VkX2NwdSwgcHJldl9hZmYgPSAtMTsK
KwlzdHJ1Y3QgcnEgKnJxID0gY3B1X3JxKHRhcmdldCk7CiAKIAkvKgogCSAqIE9uIGFzeW1tZXRy
aWMgc3lzdGVtLCB1cGRhdGUgdGFzayB1dGlsaXphdGlvbiBiZWNhdXNlIHdlIHdpbGwgY2hlY2sK
QEAgLTc4MzcsNiArNzgzOCw5IEBAIHN0YXRpYyBpbnQgc2VsZWN0X2lkbGVfc2libGluZyhzdHJ1
Y3QgdGFza19zdHJ1Y3QgKnAsIGludCBwcmV2LCBpbnQgdGFyZ2V0KQogCSAgICBhc3ltX2ZpdHNf
Y3B1KHRhc2tfdXRpbCwgdXRpbF9taW4sIHV0aWxfbWF4LCB0YXJnZXQpKQogCQlyZXR1cm4gdGFy
Z2V0OwogCisJaWYgKHN5bmMgJiYgKHJxLT5ucl9ydW5uaW5nIC0gY2ZzX2hfbnJfZGVsYXllZChy
cSkpID09IDEpCisJCXJldHVybiB0YXJnZXQ7CisKIAkvKgogCSAqIElmIHRoZSBwcmV2aW91cyBD
UFUgaXMgY2FjaGUgYWZmaW5lIGFuZCBpZGxlLCBkb24ndCBiZSBzdHVwaWQ6CiAJICovCkBAIC04
NjE4LDcgKzg2MjIsNyBAQCBzZWxlY3RfdGFza19ycV9mYWlyKHN0cnVjdCB0YXNrX3N0cnVjdCAq
cCwgaW50IHByZXZfY3B1LCBpbnQgd2FrZV9mbGFncykKIAkJbmV3X2NwdSA9IHNjaGVkX2JhbGFu
Y2VfZmluZF9kc3RfY3B1KHNkLCBwLCBjcHUsIHByZXZfY3B1LCBzZF9mbGFnKTsKIAl9IGVsc2Ug
aWYgKHdha2VfZmxhZ3MgJiBXRl9UVFdVKSB7IC8qIFhYWCBhbHdheXMgPyAqLwogCQkvKiBGYXN0
IHBhdGggKi8KLQkJbmV3X2NwdSA9IHNlbGVjdF9pZGxlX3NpYmxpbmcocCwgcHJldl9jcHUsIG5l
d19jcHUpOworCQluZXdfY3B1ID0gc2VsZWN0X2lkbGVfc2libGluZyhwLCBwcmV2X2NwdSwgbmV3
X2NwdSwgc3luYyk7CiAJfQogCXJjdV9yZWFkX3VubG9jaygpOwogCi0tIAoyLjQzLjAKCg==
--000000000000599b650642334290--

