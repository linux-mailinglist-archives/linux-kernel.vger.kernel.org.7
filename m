Return-Path: <linux-kernel+bounces-882823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D3EC2B972
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 42E95348C20
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A8530ACF9;
	Mon,  3 Nov 2025 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="zC9ft3RB"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906C3309F19
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172236; cv=none; b=U1lXpdHhSR4fR5lA1ASQABalECxxJ675PjsV/ZLPL/BIHHrJPhxIsY6hapfmnWH0gj85Hji1LNXCN0ScCBo8VOWf51WSD4K4JQxaN6/6LlFI7dNPyvVdIMogB5L0omi8Gq4Oe6F8X2+At/+Z5CJI3nzEDQRMTDInRz4xG+gAsAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172236; c=relaxed/simple;
	bh=N6dzLqWRKXo3vdjPNtp4WU0RNAGv8JDAOdUXXVowYMU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=WNK3JRpAkSuxmAIfIZmeFY6inmK86/NfBbcm0R8p22FuxWENwZ4cAJrvMafW4YcUP2NDBJZBEq1gKD22Sa8LiWTBq6kyoC4PvnjS/zISX8gNe4lpAt3ejgCH87Km+pWGhvxKtz1Uw/1IR/DEng8NLRqB9aoOGW0hwXU9QAaIYoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=zC9ft3RB; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b71397df721so108409766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1762172232; x=1762777032; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNjT7Aiq5Dh6jiEB8sw52p14qgaFnxeV2nRWidKXfx4=;
        b=zC9ft3RBWag/V+c4hsCUTEoIz0cffEe3V3R2CDajBFXXkVe2pm0bDhvl7lNKRLQIrq
         spwO0fb0gLqktktSW3Mh1iTK/dS6rW582Ewl8JrbaSsAbE0syaRN+BM4SJp0d2g6ZlLq
         2xl+67Dod/VLo51R1ncoCrhoCyaCRxsNbFAlqi0CnOKodq4xLsNlEfAxteq87mULbxPU
         OzIf1wYjaaRE6AXA8Ery/wcNRvedXLjPlxS/Fue98UAVeo91zmq+yjk4bVAFzLufeF01
         WdoES5CFbHlIhtxgm/lAyDMnTYR2zJHlSk4unA+ElbdgpUT9OlSj9GjCQu6AGxZbG15Q
         jMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762172232; x=1762777032;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aNjT7Aiq5Dh6jiEB8sw52p14qgaFnxeV2nRWidKXfx4=;
        b=ZpFyHAmYVmuh/Hgrp8xlzN5MtlSBUUbTF7GB++jWPbw2QaUMs6mtZXrl01+Vc+m6hp
         A5kh8SH5qALqZnYccj6jLEn4werUfqu7NLXs8f6Mv+J1r+R/1igGnqGYYrMIh7Dca3IP
         4OOGCtsLKfaHJD2/RkDr+HOjupsqFmsvmGUKRs5MUn9zaSLvk74XiDZeVPyDLNGBfQ26
         nRVe4h4Dj4NDAeJunKx7xXyVNhgWNQ+bgRVK5SfMes7TsRBEa+nGs4Zpwkd6ol+ce8f8
         iXX6fioWgAVNrc0q7Ls1yzbzaTJ5mt+3zEI6GA7PQZ/54NdhcnsU0HtYu5x2J6Njl2fE
         +ZDA==
X-Forwarded-Encrypted: i=1; AJvYcCUk7tqBQSTh+Vu3GXf11Rm2Ls1puYTmoq2/PCgsDdaGpOKQcwV7yh++NmefYC/zDoRdTeSFM1hWmtID/KE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT4rreqhwyNR7hP3QfslXrK410WhAOss5HYHPzwPL9ww6mpePm
	2RLCKfhVcXF9/R3IM43OpNggwMluXnJeMxjHRR6/zqr9Or+wVmKsTprVSY1JSuwXIo4=
X-Gm-Gg: ASbGncuIzyVEqeEllyfkUl5meghmqt2uELUGj/YBlB1Aks1Zhej+/jGLBhgooHEmfP7
	IjKMGUk0DOaz6GjV5zbqGoA8befM79ollLBrES9sP5e8nGSi3kVdNKP17SNTYLWrqgnAkItIidB
	4crnGRVvdgOchZ5TYQcpLzfNi6NOkDC10urIQfKY/mm1+FOePuEvC2b1+NoN8l4bdUK2cta24jF
	KsQHFCsQzWpLYt3v91nmg/GD7wkbStS0rv1b9cwgdrroV93tXOYlgMr0ViY5Jm2VmtiacN65bZk
	yGkIJ+DWRhp68rlk6VbjDlCMUBDxkHaetDhaU9+hXhPtuQtR48x5KoHzMyJUhZ4cFn7VRal5bS8
	gwONua8XjR3eyOFm4SDH7RCYNuUuw2VpJOlY36z0sjtYJPhPYAvts0eTwkahRFVnPZsCNOYYZw5
	cFx6eQJ59h3hcnzCsdwm636gLOQiSZyEMsrBOnr0l/0VZnbOBxuQ7cqWFI
X-Google-Smtp-Source: AGHT+IEKZUv1KyQWAizLeoG+U9udqAbGU47hQIHv4aHNYJKhylIq0YUcjZYxg94xX07JT/Vlq4yG1g==
X-Received: by 2002:a17:906:f5a9:b0:b6d:519f:2389 with SMTP id a640c23a62f3a-b707083253dmr1286167366b.52.1762172231791;
        Mon, 03 Nov 2025 04:17:11 -0800 (PST)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70bedcec19sm332233966b.7.2025.11.03.04.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 04:17:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Nov 2025 13:17:11 +0100
Message-Id: <DDZ1X799V2KV.269J9YL1AGCIF@fairphone.com>
Subject: Re: [PATCH v3 0/7] Various dt-bindings for Milos and The Fairphone
 (Gen. 6) addition
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Manivannan Sadhasivam" <mani@kernel.org>, "Herbert
 Xu" <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 "Vinod Koul" <vkoul@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250905-sm7635-fp6-initial-v3-0-0117c2eff1b7@fairphone.com>
 <c93afd94-9d94-42fb-a312-df6e26bb2bc8@oss.qualcomm.com>
In-Reply-To: <c93afd94-9d94-42fb-a312-df6e26bb2bc8@oss.qualcomm.com>

On Mon Nov 3, 2025 at 1:14 PM CET, Konrad Dybcio wrote:
> On 9/5/25 12:40 PM, Luca Weiss wrote:
>> Document various bits of the Milos SoC in the dt-bindings, which don't
>> really need any other changes.
>>=20
>> Then we can add the dtsi for the Milos SoC and finally add a dts for
>> the newly announced The Fairphone (Gen. 6) smartphone.
>>=20
>> Dependencies:
>> * The dt-bindings should not have any dependencies on any other patches.
>> * The qcom dts bits depend on most other Milos patchsets I have sent in
>>   conjuction with this one. The exact ones are specified in the b4 deps.
>>=20
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>
> FWIW this looks good.. where are we with regards to the dependencies?
>
> Are we waiting for anything else than the PMIV0104 (as part of glymur/
> kaanapali)?

Hi,

From my side, I'm not aware of any patches that have any unresolved
comments, so I'm essentially just waiting for the correct maintainers to
pick up the variety of dt-bindings patches in this series, and the
PMIV0104 and PM7550 series.

Any advice to make this actually proceed would be appreciated since most
have been waiting for quite a while.

Regards
Luca

>
> Konrad


