Return-Path: <linux-kernel+bounces-721378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B3DAFC867
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3134F1BC4D7A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A6A2BE03D;
	Tue,  8 Jul 2025 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Xm8Sccn6"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E922749E3
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751970485; cv=none; b=loqObk1mMGizo3fgtkvOH16Hf3eVeQXE7E8Cm66h+/jKo7YTFB/0mkXE9VoM8GAOKUl3BZobR7lB2ceQ0nRxhTkChu5fmSRWo2cvEEq1DF1zI6jjZb6obAO1dOSs09yvfrs/9V15zRCv/kEKU1qjhVTRBGokg++fduZ6J+pjwEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751970485; c=relaxed/simple;
	bh=xCTHOoLkdgQybEw/3ClPgB6sXkkKcXIzJacv5a1kNQ4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ASa8DJhOwHui3G3L+Fzvipo57QtJ/auUc42kEiDX/JQUxFV48Ca90ICNMN3a7HN4kSF7LrB3GrUyT7SWzcf8JMLFBwgQx9TYSxqS3toxeSOHxbnLUTXCBsAsJDYyt3qef+nzq/QypZpDOguZWoZEtJ/lCh4EWzQpBfYtpORjzwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Xm8Sccn6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae35f36da9dso796765866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 03:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1751970481; x=1752575281; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVV21gJNFvfXkrcluM+ctHAzr5MoawVmcTeL4xITtek=;
        b=Xm8Sccn6g+fIOw/1UgTMXMfJHRkXTxHeh7lnyug324Q2Yfixn91FM7iYrX/oWchM+o
         uVidExvPDCJ8Gi00lB+O269f0FFAKyh/qiLJC9sLZzm5oV/5F9ev9NO6ENxsh8ghspYt
         Zz/klc9S2ivwIDOXrOkWi3bt7k5PPcjKficHRssokf4hps3ruL5OCaBn1a7WkxcDOn7n
         JT/4qibsfY4thAz92QSeESeRMNO0c3R+cZB380KWx2lNSeu0aP0MxQkk7LGHdj1hs+hE
         k7G6sum77esRt1CsTIMhqc5ZVloi6dY4mdhLYzh2zWWo9SshbBj7biAqwadrUveGB5U4
         agiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751970481; x=1752575281;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JVV21gJNFvfXkrcluM+ctHAzr5MoawVmcTeL4xITtek=;
        b=A6rZUZVOP1wmGbsnXg3dRRXd8dBiyXBjGHpwKoUIU4RCb7cbj5bJX8Hdirc3+97zGF
         jJ2Ny95x/FuPWQHm0C7RGr/qQjYz8iDKYQioQAvsMKlZkD+2vnnFy8QRLlpjANxdpf3s
         sfyBoMnZh2NWt5Y+Ij7Ox+cJepgPVr5sVv5eOJqWUyLSJWmbLI//O1UuSxfePf4fvHCC
         JV0Gegs9rDd7z2HTlBcyBVQ4e+b4gpEkAHIgs+CFKSbMaQCGtxWW20ntF4prQKcqFHGX
         3l/C6c+I8FMfTNlowLdXu3B+d2Xq9BwPh7BSdA/5I0yu9OI0LmSJ62UGEmxg8zIcRau5
         7mDA==
X-Forwarded-Encrypted: i=1; AJvYcCWqi3BSrcVm6f0oSobw842CKR5qLa3TVPnev9fosrF1T9SwkBLEgsRsmTI7AXlEJ4iMajZ5Erd0kCo63rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIga1MO+C66KucyknifGo5D7HjQnzAHqXvIZZspUqMAkcxEQai
	T58CMTvUIOcWoWaQtebdT2gt0J80KtuSpd2aGFf64/hP2Qz9NqyqX7ZdyoBFbaEtbQk=
X-Gm-Gg: ASbGnct/ck2kDj0FOesOwHJ+k6oeNSMD9oV5abC49qT4A568qpz7MjtiKrPeJaYhNDw
	xLWIMyt79I+C+hl9ZHb4UrLGl0o+4ln2aSlWOmwLpAPoFFhkfAwiE/UtuNoOWAc5Zhs6ZjrP3c6
	143NsC1qfvfOsoNzSBfF1/I19IwWQqyaiYINx+0KOA6wJTZ/VnTgAFKTbKKXmcorTu/FDoppAxU
	nTg0C1tuj+0OBrg7GhQDA87Vl8mURGIF7ZVYv2Ss3wOlrUeMe9JKTdI3QP3A2iSF+z6W6JugLhQ
	xsXW2ds0xIpmkSx3b0c7x7pojAqH3cMF6fxGMbgnrPWsi/dQldCa+/E4vSVttHbWQX5B7uBzwnf
	o2HXgo0Uq0dAZ8asu4GkVUcF2KJTKufw=
X-Google-Smtp-Source: AGHT+IHaVz54M2Q9j7+0i4eoVqmwHKKm2/tqIC6pa1mIZEuAjoN4jfZ6/QMktPzCNPmSHVfF4oInMA==
X-Received: by 2002:a17:906:751:b0:ae3:b22c:2ee8 with SMTP id a640c23a62f3a-ae3fbd8b392mr1292958866b.37.1751970481431;
        Tue, 08 Jul 2025 03:28:01 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b6007fsm860633366b.166.2025.07.08.03.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 03:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 12:28:00 +0200
Message-Id: <DB6LPBOU5TDL.13B4A6U4NQQZQ@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] interconnect: qcom: Add SM7635 interconnect
 provider driver
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Georgi Djakov"
 <djakov@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250625-sm7635-icc-v1-0-8b49200416b0@fairphone.com>
 <20250625-sm7635-icc-v1-2-8b49200416b0@fairphone.com>
 <3f8bcecb-4c5e-48b1-98be-96f3c0c8329e@oss.qualcomm.com>
In-Reply-To: <3f8bcecb-4c5e-48b1-98be-96f3c0c8329e@oss.qualcomm.com>

Hi Konrad,

On Fri Jun 27, 2025 at 2:48 PM CEST, Konrad Dybcio wrote:
> On 6/25/25 11:13 AM, Luca Weiss wrote:
>> Add driver for the Qualcomm interconnect buses found in SM7635 based
>> platforms. The topology consists of several NoCs that are controlled by
>> a remote processor that collects the aggregated bandwidth for each
>> master-slave pairs.
>>=20
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>
> [...]
>
>> +static const struct of_device_id qnoc_of_match[] =3D {
>> +	{ .compatible =3D "qcom,sm7635-aggre1-noc",
>> +	  .data =3D &sm7635_aggre1_noc},
>> +	{ .compatible =3D "qcom,sm7635-aggre2-noc",
>> +	  .data =3D &sm7635_aggre2_noc},
>> +	{ .compatible =3D "qcom,sm7635-clk-virt",
>> +	  .data =3D &sm7635_clk_virt},
>> +	{ .compatible =3D "qcom,sm7635-cnoc-cfg",
>> +	  .data =3D &sm7635_cnoc_cfg},
>> +	{ .compatible =3D "qcom,sm7635-cnoc-main",
>> +	  .data =3D &sm7635_cnoc_main},
>> +	{ .compatible =3D "qcom,sm7635-gem-noc",
>> +	  .data =3D &sm7635_gem_noc},
>> +	{ .compatible =3D "qcom,sm7635-lpass-ag-noc",
>> +	  .data =3D &sm7635_lpass_ag_noc},
>> +	{ .compatible =3D "qcom,sm7635-mc-virt",
>> +	  .data =3D &sm7635_mc_virt},
>> +	{ .compatible =3D "qcom,sm7635-mmss-noc",
>> +	  .data =3D &sm7635_mmss_noc},
>> +	{ .compatible =3D "qcom,sm7635-nsp-noc",
>> +	  .data =3D &sm7635_nsp_noc},
>> +	{ .compatible =3D "qcom,sm7635-pcie-anoc",
>> +	  .data =3D &sm7635_pcie_anoc},
>> +	{ .compatible =3D "qcom,sm7635-system-noc",
>> +	  .data =3D &sm7635_system_noc},
>
> One line per entry, please
>
> In addition to what Dmitry asked for, please also look into porting
> QoS settings - those will require additional clock references in the ICC
> nodes and as such, the bindings will be altered (which we'd prefer to get
> right from the getgo).

I've forgotten to do this for v2, which I've just sent.

But we already have the clock references in the bindings, so the
bindings should be final, also when QoS is added, so just a driver patch
then.

I will put this on my todo list for a future patch to enable this, if
that's fine with you.

> As far as testing goes, there may not be any apparent perf changes, but
> if you get the clocks list wrong, the device will lock up at boot (unless
> you're booting with clk_ignore_unused and friends)

Ack

Regards
Luca

>
> Konrad


