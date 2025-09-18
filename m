Return-Path: <linux-kernel+bounces-765109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 577CFB22B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B18D2A6EFA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED45C2F5325;
	Tue, 12 Aug 2025 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Kx92KOQi"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9032ED850
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755012066; cv=none; b=S2/mZ0WgNFMIV8ZfxSEcJU5RwgQvscC0Ij/HGmHwEHAj5W2B5L9dxI1fF0w+K+yH2gyTQulfVWmyhHQRl0xG261ubwCvANUvBpqsxVpYuFi/loQeFDbJP5lO7r0Pt4XFJ+tI6q5QQeH8ViQ/PEwEjejRqm8sQcbtX6Y2hG91YW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755012066; c=relaxed/simple;
	bh=QHHuJW/EiamKuHBNtdgrPVoL/XB/qHj8wnI2/U0ofGM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=oa3Fd/Dz3dAKcZ3yVkTkLFcfSogqkvAL2QzmVqiQ9gk07qKJGiNzmr5fpQI8veZjiGG1kF221sv3IeQNBg3v5PcJBo2R1fdCjLPtUNswixoNgAQdP3M+0wtJ76NEInmEY3GRDTMP9tMSOiuSRwMigXpxuV1WOfwFlF5eJQlSY6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Kx92KOQi; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61592ff5ebbso8823835a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1755012062; x=1755616862; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cuCCH8VAlUam+cA47ykU/6jYW/fThVT5+TG1NG7tyQ=;
        b=Kx92KOQiTjcPZvbXOkNoFcoyc/RZ4hV53WytAL+F3IBvXRhfSJCvyP+4sNAOx5RhiL
         Qb+mKXqa8KtRUqL0jZX7zOL5ig7eigmWY6OxMicVhoGtmq8lG6wwREBqpTEIu267WL7V
         MWyRpDKgsYxqacDxGJRqKQp5/4p7p3sj0Fr+e8N5jqeNUcohEp5zw509/RL924NlEyYp
         p24XK8V5HOwgeIjsRQdUxXgThxa4jBdSInJJpj8xOZWr5vqokcARrP1ZZ+xjt9woUV1O
         fwkxnw22iVkBAlkB8xCxtPb8lpX9J6WMyOUbI69PzZ4mLZqYB8R0PrxW8IucfmVGIOF6
         jqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755012062; x=1755616862;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1cuCCH8VAlUam+cA47ykU/6jYW/fThVT5+TG1NG7tyQ=;
        b=nsdvQbR548u9RwQVv0eRpEWwfCkBen8jjMn/e5Wk5KFM89mdzHSmm5oP174AgoHka6
         c7GdDK+tlE4t4kbK436bz4TW+bkQ/WV4lFNu88GEj7vRYlTQWwCf0WbFbhO2yLSTpOCr
         16ZP+pgkZ4WnFS/kajDzgLTID3GEs6b0vG2dkBh70oxIqxznMRilju2iBotGYsG8sbnS
         wFRgGG75/4pMr0nzGr719hpqKYG4O75vaJhDfbyyc8f9BmPFEHYIRdiqh1gQDDZaJJdu
         3U3kDR1RqXYgQeNrtllWwfss5VR3Ik8FDEGoCrmLTRDpLte9oudJi3w0vfDREh8Ej2hs
         Ef/g==
X-Forwarded-Encrypted: i=1; AJvYcCX/pQiiIp79ZC0NktnBTfnRJWZ2yNg8q8HjgMLMzDxyXntrEx+h7PhSpaLwJ1AX1dok9z56Eo5njT6Qc/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhPzQofOGsj3msf7f+xyfZB5XILErdN5FHjL44Fp9uCbVnGT1D
	hd+i1A8tduOy6aYlmMb8Bw8n48OhOeXXWkl8wjm2SPuvW9dxzO985u/sUAJWhkJTTpM=
X-Gm-Gg: ASbGncuuCkHFFqymL+81ZVBGwrGhmgkoGFJqHUbN4OSe6A8Cs7EFJkeKbgdXYAdv9DU
	ukAs/aMiCDrWVcid3oq/Y4TSJM3UNbBoIpuJ4ut+wShPFsR1oPJcsXvI6SdteZOx+3kVQQcr6c7
	tDpIZyZjGgev3kmk4H6gGYmsbWztP0Ku+T9EiNT56JFgFLr5xU9aSmi/zis0yZKE15P9toXqYWr
	lfBGYXkmA8UbT9wiX6MbtWfeh1KN8WqPFrvflgITMkyET4e0VLPrdHJzT1zD4/0mRWVJ3ztC7mE
	7I+UFFw836GlpeabzEyv2NUjjeYovUhV4J13Twy+jwrH/w1nYXVv405NM/AcryCa9T7RFH6m6Jy
	pp9qKxtogSnhPmperTEzGzkh+X72J+g==
X-Google-Smtp-Source: AGHT+IHi8A4KGcy8JJcWOFoy6dDibyPAXIGPczBPkGZjgn5/c5sakdzR7AlrO/zc+TLqsTti16DCqQ==
X-Received: by 2002:a17:907:1c1d:b0:aec:65d1:cc30 with SMTP id a640c23a62f3a-afca3a74174mr8586866b.44.1755012061884;
        Tue, 12 Aug 2025 08:21:01 -0700 (PDT)
Received: from localhost ([2a05:2d01:2025:1908:e499:6dcf:1e86:8748])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3b77sm2220245866b.51.2025.08.12.08.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 08:21:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 17:21:01 +0200
Message-Id: <DC0JUQMZN9X8.26G5HXLTC8YJZ@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Bjorn
 Andersson" <andersson@kernel.org>
Cc: "Konrad Dybcio" <konradybcio@kernel.org>, "Rob Clark"
 <robin.clark@oss.qualcomm.com>, <~postmarketos/upstreaming@lists.sr.ht>,
 <phone-devel@vger.kernel.org>, "Konrad Dybcio"
 <konrad.dybcio@oss.qualcomm.com>, <linux-arm-msm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: qcom: ubwc: Add missing UBWC config for SM7225
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250723-ubwc-sm7225-v1-1-d688caff70f1@fairphone.com>
 <blibzpqgbjbbwvnsx3cu3fzjxk776lamnmd4erokc5jx7qkubh@7da6ihmb6xxj>
 <xsrkh75xb6klntc4mc564iq4wipe6iaqjiugk2r743n2y2h5dt@s33t7fckn5gq>
 <55xazajnwigd744shnkk3acba7fozsaciybjexvrp2rdvs2bhm@35lglwjsazdf>
In-Reply-To: <55xazajnwigd744shnkk3acba7fozsaciybjexvrp2rdvs2bhm@35lglwjsazdf>

On Tue Aug 12, 2025 at 1:10 PM CEST, Dmitry Baryshkov wrote:
> On Mon, Aug 11, 2025 at 01:32:00PM -0500, Bjorn Andersson wrote:
>> On Wed, Jul 23, 2025 at 10:03:15PM +0300, Dmitry Baryshkov wrote:
>> > On Wed, Jul 23, 2025 at 04:19:22PM +0200, Luca Weiss wrote:
>> > > SM7225 is a variation of SM6350, and also needs an entry in the tabl=
e.
>> > >=20
>> > > Fixes: 1924272b9ce1 ("soc: qcom: Add UBWC config provider")
>> > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> > > ---
>> > > Note, due to other bugs on next-20250723 I couldn't fully test that
>> > > DPU/GPU are working, but this seems to be required in any case...
>> > > ---
>> > >  drivers/soc/qcom/ubwc_config.c | 1 +
>> > >  1 file changed, 1 insertion(+)
>> > >=20
>> >=20
>> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> >=20
>>=20
>> @Dmitry will you pick this as well through your tree, so we avoid (the
>> trivial) conflict.
>
> Yes

Could you maybe amend this patch to also add sm7325?

Or check if any other compatibles were left out in ubwc_config.c which
are used upstream, I didn't check...

Regards
Luca

>
>>=20
>> Acked-by: Bjorn Andersson <andersson@kernel.org>
>>=20
>> Regards,
>> Bjorn
>>=20
>> >=20
>> > --=20
>> > With best wishes
>> > Dmitry


