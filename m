Return-Path: <linux-kernel+bounces-863130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C66FBBF7171
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86652546F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096E1339B35;
	Tue, 21 Oct 2025 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="F0JvGQcY"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9961921423C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057020; cv=none; b=Ke7x2JysIkXTNeb53u9Bah3SooZjW+nSrQTPZ0Nike6TzK+hQyBpZJ3BsJJgIw1qP7KGDFWp16Y8rm8t5AOicLedRBkDnZyxD6eNKIPMDgKphVlSGv1Ppa6LH+M6PaWEWyU36Qb4hYpyFeGgAPLOlGuDoJxJb4hX9XlrMWerk7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057020; c=relaxed/simple;
	bh=AMk6Lrxmvf/zuorD22sZx/fHRloh9GVoJWzNxQaEuIE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=b5hFuB6AlVpkCkveXQRTwHV92YlyUf3vBckkZoN8oHBRNR1e1amDTh8N6Kyo22jYF1r2pibXraNkGb8vtjqgiV8HUI2NSX7W/eXY5ufx+7JAbgdqH0JLZFVLhjo7iP4ItzHkxw+HcObsWevJzMXtVYdMqdC2RDTI16zRuyeQpqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=F0JvGQcY; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-78f3bfe3f69so4968014b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1761057018; x=1761661818; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=72EdVUvWUCeeRDpijDC/64Xkq93xQ0f8jqeBT4LAAk8=;
        b=F0JvGQcYcIE6u7mxUYwOWX/axYMIif+gYF93z84Hj1Bp5mbP29mbZHJkuwxxy4KoZs
         8vJyub5ZV2oqiVswWFh4GIH2yqvZHWhW3zG/yt1kliWbg96yxt/uhA+ladlMrUraK4Fd
         qpSz6rv/J+VZxFSEQAMoxRxk58BzKgYwvAUDnHeYgB/fCiUPPaUZW8tu8pQx5k6WWjpp
         hNEGNpxWWEMjoSJ9a0sYOQmsl1EnKXk+TQ/fRdGmbk0568lnsTjD2aMdMIPtdA89Zv2k
         h9DH5WW2AhJ8MwaO0MhrgZ5WxjZKQDuUgHVopAEqTK1NIhPjrsxAdJI3v2gUl7cO+tE0
         kgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761057018; x=1761661818;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72EdVUvWUCeeRDpijDC/64Xkq93xQ0f8jqeBT4LAAk8=;
        b=UOzmuYgcmvjVDuc6TKKptH9livRvR2ZeN/jK1o9jR962FHK80KZjgV/CtaEeZjUBWt
         +mriCHV7DMnHm/svbEc8wDd99CUjaHXH7RWMrVZu70pa493tkoajN6qoJgFsbNRk5PlL
         xkaAyevw49PRB9Ap6qDtDqK1p3SrVEMPXFzQvZbdIB9HUkET8iSlTrDB9fke7aRhon0C
         IpgfayxBjZPsAklQcvPFtJ11uT+GA3Tbsxp+yW3Wj3hkJ0i5h8Uj5sSHTN7swFqqlOZh
         AIkzeLujj97kmN8hf+YNibuaumybhVSb/kqgWOCwVPNKw6q1DosqyIss81tCZ4RM8gZc
         2QCw==
X-Forwarded-Encrypted: i=1; AJvYcCWB7mHZLKrZldyIGo8p0qc/roEI8iWJOfXujXQSc9xtbpoPX8f8rwxlKkNy3alwNJkp8MzfFFn+vUsMKsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2WWBdH3dEytxDWb5kK0QBVERjKD/KP3wLzATkHWlyyy00V8uG
	aslPWoNWLsXHN1CMsDbj4sAjjGBPWETiKMXgaBxOs9uwcvcy/G6QWMLrJ8cPxrJZWyIPLJ41Jtx
	A7zhs
X-Gm-Gg: ASbGncuo6PRGv+BkiMkZEiTiNbitzayAMrljLgREhCffkOXt98vIEDWlasQDsQlItbN
	pQoTpI4LZzXhl00bThtr2CfAkPlzScKBy/853Eqr9yDEdyUxbEMcIUy6PkXA/lw7gNiDULLoyij
	hVAFcUmMx4RFBiqhD8NUt2eNP/zsJmzaiTTzx9mTS/tpkvgDXOt7OZJAbC7JICZycpiMek5Yzg7
	m0CJz70MoQde2xnqyKxxHUzInjOu/1zCR/yWJwZ0BVeEBAsXfXPLXnYZAgHJfZbEuuIUoVBxQOS
	qYQd0+4g/luSqkslkh0ZC4jXu3oHm6Sq7yCxbSNMR+BZc8+z+s6uQWjJalQ8MnoZ4LiDaB+xvDs
	1hZ5S43R3tWpJg9VDwxFm5w2fapR5VIFTTGBhoh7Ey5HAeLJnO401dS+zsptsBYEUXHz4eGpZ3d
	ySbxGlRynXplEBm++Qn0RJBldr8gpn50jq4gyf0iGmbytg
X-Google-Smtp-Source: AGHT+IEqyxsWbC/jVX5CbA9miNQ3uKmcnqiXwB8tEcbEEj4Zq2w3qQ5vOuYWSkkg5NxKrD2+uN5BRg==
X-Received: by 2002:a05:6a20:431a:b0:334:a327:b0df with SMTP id adf61e73a8af0-334a85d88c3mr20566089637.29.1761057017712;
        Tue, 21 Oct 2025 07:30:17 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010e24fsm11510899b3a.57.2025.10.21.07.30.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2025 07:30:17 -0700 (PDT)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Sergey Senozhatsky'" <senozhatsky@chromium.org>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Christian Loehle'" <christian.loehle@arm.com>,
	"'Linux PM'" <linux-pm@vger.kernel.org>,
	"'LKML'" <linux-kernel@vger.kernel.org>,
	"'Artem Bityutskiy'" <artem.bityutskiy@linux.intel.com>,
	"'Tomasz Figa'" <tfiga@chromium.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <4687373.LvFx2qVVIh@rafael.j.wysocki> <5f0aa630-b30a-44c4-a52c-e08179cd3bf9@arm.com> <CAJZ5v0gBtv0bpK2swkc6D0AmanpKAvqO53dgRp2e7p9cWAM3TA@mail.gmail.com> <28ecb23b-ecee-409a-9771-24f801081d07@arm.com> <CAJZ5v0jMoEVUaYYPx6EtHFxsg6TF-QtDWJGrasGK7C2C+JxOFw@mail.gmail.com> <001801dc4041$607c19f0$21744dd0$@telus.net> <x4qvjfwxzatm6wnrtqgue7y673oqzo74i6ysmxalvnts5olkot@ekaee62fjg5l>
In-Reply-To: <x4qvjfwxzatm6wnrtqgue7y673oqzo74i6ysmxalvnts5olkot@ekaee62fjg5l>
Subject: RE: [PATCH v1] cpuidle: governors: menu: Predict longer idle time when in doubt
Date: Tue, 21 Oct 2025 07:30:17 -0700
Message-ID: <001201dc4297$3903af70$ab0b0e50$@telus.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEHjVQKCrlPynWgLAaVpIarC+pGJQGZtDQKAi3SGCUCWYi7hgLZuqUGAZPsdfIBj3Y3ebYVH1IA
Content-Language: en-ca

On 2025.10.20 20:43 Sergey Senozhatsky wrote:
> On (25/10/18 08:10), Doug Smythies wrote:
>> On 2025.10.18 04:47 Rafael wrote:
>>> On Fri, Oct 17, 2025 at 8:37=E2=80=AFPM Christian Loehle wrote:
>>>> On 10/17/25 10:39, Rafael J. Wysocki wrote:
>>>>> On Fri, Oct 17, 2025 at 10:22=E2=80=AFAM Christian Loehle wrote:
>>>>>> On 10/16/25 17:25, Rafael J. Wysocki wrote:
>>>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>>>
>>>>>>> It is reported that commit 85975daeaa4d ("cpuidle: menu: Avoid =
discarding
>>>>>>> useful information") led to a performance regression on Intel =
Jasper Lake
>>>>>>> systems because it reduced the time spent by CPUs in idle state =
C7 which
>>>>>>> is correlated to the maximum frequency the CPUs can get to =
because of an
>>>>>>> average running power limit [1].
>>=20
>> I would like to understand Sergey's benchmark test better, and even =
try
>> to repeat the results on my test system. I would also like to try to=20
>> separate the variables in an attempt to isolate potential =
contributors.
>>=20
>> To eliminate the PL1 effect, limit the CPU frequency to 2300 MHz and =
repeat
>> the test. To eliminate potential CPU frequency scaling contributions, =
use the
>> performance CPU frequency scaling governor. Both changes at once =
would
>> be an acceptable first step.
>>=20
>> Sergey: Would you be willing to do that test?
>
> Apologies for the delay.
>
> Sure, I can give it a try sometime this week, am dealing with a bunch
> of other stable regressions right now (will report separately).
>
> Can you please help me with the configuration steps?  CPU freq =
limiting,
> etc.

For your system booted with "base" and "revert" do:

echo performance | sudo tee =
/sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
echo 2300000 | sudo tee =
/sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq

then do your test.

>
>> Sergey: Could you provide more details about your test?
>
> We track regressions in a number of tests.  The one I'm running more
> often than others is a Google Docs test (our tests replicate real use
> cases).  The test in question creates new google docs (in chrome, of
> course) and inputs some text in them (with various words-per-minute
> settings - 60, 90, 120 wpm) in English, Japanese, Korean and other
> languages; different font faces, different styles (bold, italic),
> text highlighting/selection, windows switching, and so on.  The test
> measures input latency, the number of dropped frames during scrolling,
> CPU usage, power consumption, etc.

Okay, Thanks. So not a test I can repeat on my test computer.

... Doug



