Return-Path: <linux-kernel+bounces-804224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E29B46D84
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 923577ADB27
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 13:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E3E2EDD6D;
	Sat,  6 Sep 2025 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuJHtlUb"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B08C2EB85A;
	Sat,  6 Sep 2025 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757164179; cv=none; b=s1xEdOscbMYwdFIozEwhhauFMnl7WueTWQMVTSmtHYWUzhmmt16fkrMs6lIaKtJmMFDyzpBVHo/IfeudNnmU0oQVk8I+Us7vmprqzr/qHLUUgglAqlcC+M2iCI/w0jCjNoifjDU7OOH0Bs53n76ABeZ2flL9BspRFHjuD/oG15g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757164179; c=relaxed/simple;
	bh=FqlNOawhiczNnMYgtV78WNwSk3WFr/Z1jReSPh5SzeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+1cvftMQZe1lEwuRx8PTOMh1NrZyvsd1m7s2Ft0lZCrDszb/rJxsywZXVceW+AXctAuBH+gPE2bQta2rVmBWPCrHgdRfo26WGt9SQtWQspjeFV37ZQdLlb3cYMTQoop/ahyEf3phi6BlUcPpbCKVRpqyH1e1Y7+JpdipuA3d5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuJHtlUb; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-746da717f35so963752a34.1;
        Sat, 06 Sep 2025 06:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757164177; x=1757768977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqlNOawhiczNnMYgtV78WNwSk3WFr/Z1jReSPh5SzeI=;
        b=ZuJHtlUbj9QkBUBpiq4vnptYNc3rq0pAqRhPBftrJYj7LdWCsPrN3YJLsqDjVSL7pf
         PCAJLGeZMOuU4yD8/bnm5XfNhMVXSJSxZlCABe1K4ZlaSyVUqfu8IXvJjaSiqRlpf1EG
         bronEgSchkRGwnsKK5htrSRHcXF1KVXvDd8J3rftbB3FHK0zpHkxUhuw88TgVS1rpHlg
         9NHUgqW0OaVytIa1eNbfHEjLLjKyvPufzrLTptMRIk9sd9kVQ4jXClGny9dfuAT5Am/o
         aaWPYrL45rKOpdvImqrwTJsb85qzOQIhWy3xCZ8HZYc6a8xAZ+unRFOpC8w43tBpfsF5
         Q+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757164177; x=1757768977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqlNOawhiczNnMYgtV78WNwSk3WFr/Z1jReSPh5SzeI=;
        b=UoeZWbdTkJG3uYoNmi1bqKYwM6y2OC94mnokZpOvvJS9JotTXxfjsS4A1WdHg50Ug/
         1tX47x+0aJHyEV5Wz1WuhCVQBKmpAMmm97UaHOB7ac/lvxFMGMeGmHil+C54tC7I8Xgy
         TIcViUoQ07cMjjbOTkO4ME2WKwGd6h07uYevfHn5Bt5GILaVCWYb/0SbOn+xF2L1xjNd
         Lty7cnJiW1Y67wK1Qi/O5LOFIY+yVFqytL93ha7jqDIMFDCof8QrV4exUa5jKEqJIGmC
         MN2ryiRApgZLjhxsbA4hih5Nlbwifybw+mGwXDlSxuBuvazBFLHFtGy7O/f/cp689EfE
         mJzw==
X-Forwarded-Encrypted: i=1; AJvYcCUsvgNcF/YaUy05VwKA6iqCSswNFdeJ1ev7K+xfQIzwnVF6/+LmumQd2Ovje3F2FXeQjFAaZktuNFsn9PSG@vger.kernel.org, AJvYcCWn3ChQJgNmJPU67YdeoCxwC1zxUx66NQGgPOikgHhccCs1vF8bxhIDimAsjAJdojm/JSySBknIupuT@vger.kernel.org
X-Gm-Message-State: AOJu0YyVxno46UukzFJ1viYvodvRravvv6IzWI33iiZnM6AJfHRclIXv
	T1lIgE7+HMl1QpDA1GwS1ZfolMDQ5DxXK5008iwWxAiEKBVLnnLZJ4Ovnu4uwvET1xPABKgSP8S
	/+uth0vZ6UYBXTZqB3Uy3gAaXLii6Yzc=
X-Gm-Gg: ASbGncswomvWbtwr03ZotSprwA8z7ZBf2ImT3ZiJM8x85dZCja+aeUUwlWfNQaQ2tN5
	8rovRV8vpSdk3taoe+ekTpi3CKiF3/eoa8C3SoHz+nchzFw0+YjxpV7hrCekPBlLeubK6pK7G1o
	G31HBiUce6XmWAnBXUCjO0AZLcXXbzP4YL+MfeFqHnFRMbcd4tZ8Gp/17+sKVti3SHyLbYDYs21
	c/oo+OTzu1lF9UmKEvcLbWpo6tw
X-Google-Smtp-Source: AGHT+IHEg3AUdpr9HZfCSunIoPawPsj+5zDP0vZEWNpUApCdkvhspa2BeDectYhc12P9JKqYJhzerVjfjFkrV2gkucQ=
X-Received: by 2002:a05:6808:d50:b0:438:4117:a869 with SMTP id
 5614622812f47-43b29a3db49mr717669b6e.3.1757164177102; Sat, 06 Sep 2025
 06:09:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902142749.13724-1-kusogame68@gmail.com> <20250903074205.GB2163762@google.com>
 <28c1ff61-8510-4fd4-9cd2-0e3ff4fe3a02@kernel.org> <CABZAGRE=6Dg1npRx-jmcycnGMkbtmY6A7E=upffeQ+KANTqcLA@mail.gmail.com>
 <96e6578e-b21f-498e-82f6-eeee3ee81e20@kernel.org>
In-Reply-To: <96e6578e-b21f-498e-82f6-eeee3ee81e20@kernel.org>
From: Nick Huang <sef1548@gmail.com>
Date: Sat, 6 Sep 2025 21:09:26 +0800
X-Gm-Features: Ac12FXzTTU9OxWKAR_Al-DgJ1eaR96FG-JSCEoP1ITu-KcxZJya_I-zlzWyriRg
Message-ID: <CABZAGRGof5e=mwpfmEgE7W+Pn5gS05ei7io8e7C4tPfkvz1=Gw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: fix typo in documentation Correct a typo in
 the documentation by replacing "abd" with the correct word "and". This
 improves readability and avoids confusion in the description.
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Johnsodn Huang <kusogame68@gmail.com>, Lee Jones <lee@kernel.org>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, weiyan huang <dory85109@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, I have read it. The subject and the content were mixed together,
so I will reorganize and resend the patch.

Best regards,
Nick

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2025=E5=B9=B49=E6=9C=886=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=888:00=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 06/09/2025 11:13, Nick Huang wrote:
> > Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2025=E5=B9=B49=E6=9C=88=
6=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=883:38=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >>
> >> On 03/09/2025 09:42, Lee Jones wrote:
> >>> Looks like you corrupted the subject line with the commit message.
> >>>
> >>> Please resubmit.
> >>>
> >>>> From: Johnson Huang <kusogame68@gmail.com>
> >>>
> >>> Use `git format-patch` and `git send-email` instead.
> >>>
> >>>> Co-developed-by: Nick Huang <sef1548@gmail.com>
> >>>> Signed-off-by: Nick Huang <sef1548@gmail.com>
> >>>> Signed-off-by: Johnson Huang <kusogame68@gmail.com>
> >>>
> >>> It took two of you to correct the word "and"?
> >>
> >> Can you respond to the comment instead of ignoring it and sending the =
same?
> >>
> >> Best regards,
> >> Krzysztof
> >
> > Hi Krzysztof,
> >
> > Sure, at the moment this commit only addresses the typo in the word 'an=
d'.
>
> Did you read the question?
>
> Best regards,
> Krzysztof

