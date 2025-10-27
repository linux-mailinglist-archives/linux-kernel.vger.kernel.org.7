Return-Path: <linux-kernel+bounces-872323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33118C0FEE1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B80124E8BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424443164B6;
	Mon, 27 Oct 2025 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FV2IWENh"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892D2313277
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761589987; cv=none; b=UQd1ukWwm2IGiXGnKI4NH+iD8aoSMV7zhn6F9OutlO07fRdlum9qw+3EQdT5olxrmuwmrYGlgSBISGp1rtNZIzPQGTSG9N5sVEmxBRWa0keoUw3c3YbMvRyYJZtkQAziqQu94FFLkDjiaaEETt8Bvs+f0qEAz7DBPSvCRBGyNnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761589987; c=relaxed/simple;
	bh=5yC8PpIcUio4Ku4s4/CtCeIXIZihYpSkqy+RgQT0emA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=GEiJMzyljo+mz1cvawHiIdbMJW1gw2k5A38FPox5ey4bWMYJlS8lsvA0aO0J0IflkD+vxNLjJ2yxnKu14CZ76NgTZ7ZQ6phfG+unrIVjKSHGPjpd+MvZXSvUZRlsfyAGVs4wSt8VrN9kzLp1NS5ZvPCyJwf3+Jqwpkr9Wim5S0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FV2IWENh; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-78af743c232so4564559b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761589984; x=1762194784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5yC8PpIcUio4Ku4s4/CtCeIXIZihYpSkqy+RgQT0emA=;
        b=FV2IWENhh2JKYwqRHGajj7AYTBkfqP9U5SiC+g8cc08ULcrFbpwxGEZKE64pQxHfP+
         4+mVvI8QaXssyHl//t5pdCkmmd/z6WAvjniAvCCkwvfgL6V8PYOqQ3Sf01od15o4szKa
         8ke0Pw86686RR5p9aOARjyLySD1ka9/e97PgjZyksmVbx88trbMu4ckMVy+G/bhPjhmw
         NHdcfU0qN4DyNxJT1Btw6SNRnWRX3EMa7P/v8m1WK9rO9TlCgMRgvXE2cH/rmmD9As5Q
         +ppoDi3wKroHUG9omR7j4Nu6c8cwUjamf/P9MsqcR/lj9f4yAS30ooIyEjgPMp5UGXAv
         ErSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761589984; x=1762194784;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5yC8PpIcUio4Ku4s4/CtCeIXIZihYpSkqy+RgQT0emA=;
        b=e8d592r4z8jqaFj8i6sjTZR6m6z0OeGm69SJOhUoTpbLMmHuAhi6ZgQ5ECn3qRqh/l
         nBtCDDhQ5tYL7IzWE/8YMV2vb899ob9Yot8WfJDEIMFygZsNDeTGv25lAK1QcFW5XW/E
         nKuq36SP7znmjm8aUnXMgx/nQUSp9fXHg84BcCXuCvmwtY8uiZ/SEEkYHjkTU/04pOKE
         1fTJc5/b2vr2NJSBiMBc5djsGInEHw+0Oz4P0emcSboOogYkZoWbPuPOeSMkkjHQMGbV
         bMmkm8u+FVs6iDXfKdDfCM+hN+OD1UJ9dn2yDW8Ll108/f8zRxnGMxGeZZ0q66Wa1I0b
         v72A==
X-Forwarded-Encrypted: i=1; AJvYcCXfvzji+MDQUfLje7SqHl5Mo4qrW/kholudNEPC4bejJ4Tk004lJsH+2YClhDUnJkkEpHxy+xN6isY/Swg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXZFKa31C2VnWJDgLRlJmIEcYYOt34JgSRzWM39H/iOemnB/SA
	Qau56FHhd3df+H+kDKAeL4ifP508BD03En0GmaSxibucVdLUONnXOpM5
X-Gm-Gg: ASbGncuiV/694tAMGTz5d7Lz9OjKn19IUySXdOXehSV5kuXw/Y9yl0vGPI0wSomlEmy
	LBTyXZML0hG9RzgJ5vc0e6rUqkC5s9TCHJyQpxtXlCiMS5AkWyCssX6bM+EPefnwN3nUjRjHixu
	pjQ6/NkU6/d5HIu9+i2ZBnjimKdZtaF1Q33vHQrvTz2lYH72KxKNb1qwmaBZZe8M6/v9FUmqxSz
	ZvN1K1D8IlBpmc9Phq/J0sacn0G0RfxX078OI0kV9/6MnAUJkgcac6RSspWMiK+bU3nzM8jxb4M
	9G21VlxOT1FIwwUn/dltlhG5do9FPi0TfqvvQ6afNER6jF1KpuLHDcAzmdI94bxFW0RZKEmJQME
	gpJJz5s+QCDWp9lGB0CR18EtzILoBXfWvGp/F4qkZZFp5MFjeZJaeuKlhc2/NQZ0El5Nn5Pfyqn
	NfBkE0M0Py2dPoGrxRD+PIVw==
X-Google-Smtp-Source: AGHT+IHt4DJWNAM9MZTCzUyEfgg2vReTKwp653liwyZeiZgWrRZxP3BqzH/B64W+Bg8rAo6d5fksJw==
X-Received: by 2002:a05:6a00:995:b0:7a2:7237:79ff with SMTP id d2e1a72fcca58-7a441ba53a6mr1041339b3a.7.1761589983518;
        Mon, 27 Oct 2025 11:33:03 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:18:939:e8ae:c91b:7909:492a:aaa7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414069164sm9038019b3a.45.2025.10.27.11.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 11:33:03 -0700 (PDT)
Date: Mon, 27 Oct 2025 15:32:58 -0300
From: =?ISO-8859-1?Q?Eric_Gon=E7alves?= <ghatto404@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: r0q: add touchscreen support
User-Agent: Thunderbird for Android
In-Reply-To: <7e5f753d-a26d-40fb-9cde-ec17eff85c27@oss.qualcomm.com>
References: <20251014044135.177210-1-ghatto404@gmail.com> <20251014044135.177210-4-ghatto404@gmail.com> <e114504e-4bdd-46b9-b708-8eebc3075163@oss.qualcomm.com> <CAMQHOhfjsi1L+3j3TrcjEjPp3xkn94KOdsrVZvJCyUDFBBSeqg@mail.gmail.com> <d06a254f-bf54-4bdf-bd09-3ee5e5b31bad@oss.qualcomm.com> <CAMQHOhe=WYhtsjHMcRnJOi8UhnNNBfveTWRGSZ_bg24gFysAEw@mail.gmail.com> <8bd5486f-38a9-4104-8d09-234f642b45fe@oss.qualcomm.com> <CAMQHOheTkKC8NcRrPxKZdB_h0SJGNJVMd4NUD7TE4becPouWyQ@mail.gmail.com> <73d30994-3ec3-41bc-9b07-638d4173dfe6@oss.qualcomm.com> <7C2DF8E1-D84C-428C-B064-3D8CA16FEA29@gmail.com> <7e5f753d-a26d-40fb-9cde-ec17eff85c27@oss.qualcomm.com>
Message-ID: <E9C95D16-18DB-4AE9-8C50-BE3481A25FB3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On October 20, 2025 9:18:18 AM GMT-03:00, Konrad Dybcio <konrad=2Edybcio@o=
ss=2Equalcomm=2Ecom> wrote:
>On 10/17/25 8:22 PM, Eric Gon=C3=A7alves wrote:
>>=20
>>=20
>> On October 17, 2025 5:20:43 AM GMT-03:00, Konrad Dybcio <konrad=2Edybci=
o@oss=2Equalcomm=2Ecom> wrote:
>>> On 10/16/25 10:08 PM, Ghatto wrote:
>>>> On Thu, Oct 16, 2025 at 6:06=E2=80=AFAM Konrad Dybcio
>>>> <konrad=2Edybcio@oss=2Equalcomm=2Ecom> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 10/14/25 9:04 PM, Ghatto wrote:
>>>>>> On Tue, Oct 14, 2025 at 11:18=E2=80=AFAM Konrad Dybcio
>>>>>> <konrad=2Edybcio@oss=2Equalcomm=2Ecom> wrote:
>>>>>>>
>>>>>>> On 10/14/25 5:10 PM, Ghatto wrote:
>>>>>>>> On Tue, Oct 14, 2025 at 7:01=E2=80=AFAM Konrad Dybcio
>>>>>>>> <konrad=2Edybcio@oss=2Equalcomm=2Ecom> wrote:
>>>>>>>>>
>>>>>>>>> On 10/14/25 6:41 AM, Eric Gon=C3=A7alves wrote:
>>>>>>>>>> Enable the ST-Microelectronics FTS2BA61Y touchscreen=2E This pa=
tch
>>>>>>>>>> depends on "Input: add support for the STM FTS2BA61Y touchscree=
n"=2E
>>>>>>>>>
>>>>>>>>> The second sentence doesn't really make sense to be included in
>>>>>>>>> the git log
>>>>>>>> I'll keep it to the cover letter then
>>>>>>>>>
>>>>>>>>>> The device has an issue where SPI 8 (the bus which the touchscr=
een is
>>>>>>>>>> connected to) is not working properly right now, so
>>>>>>>>>> spi-gpio is used instead=2E
>>>>>>>>>
>>>>>>>>> Some Samsung devices used to use spi/i2c-gpio intentionally, als=
o
>>>>>>>>> on downstream=2E I'm assuming this isn't the case for r0q=2E
>>>>>>>> It isn't, the device uses fts2ba61y on the spi8 bus - I hosted th=
e
>>>>>>>> DT at https://github=2Ecom/ghatt-o/ss_experiments/blob/main/r0q=
=2Edts if you
>>>>>>>> want to take a look=2E
>>>>>>>>>
>>>>>>>>> Did you enable gpi_dma1, qupv3_id_1 before spi8, when testing
>>>>>>>> The driver probes, but it fails to recognize the touchscreen devi=
ce
>>>>>>>
>>>>>>> Could you post a complete dmesg and the precise DT diff you used?
>>>>>> https://pastebin=2Ecom/QkYa8nMp (android dmesg) mainline dmesg does=
n't have
>>>>>
>>>>> The link has expired =F0=9F=99=81
>>>> https://pastebin=2Ecom/s4abJS9M shouldn't expire now!
>>>
>>> And yet it did!
>>>
>>> Feel free to just attach it to your message=2E=2E the list may bounce
>>> it, but it will still reach the To/Cc recipients
>> Attached the dmesg=2Etxt file=2E
>
>I'm interested in what happens early when the SPI hosts are programmed,
>whether there's any additional debug messages=2E
>
>If your log buffer is overrunning, you can add log_buf_len=3D8M to your
>cmdline (which will make the buffer 8MiB long)
Is it that big of a deal though? spi-gpio
works just fine for touchscreen=2E
>
>Konrad

