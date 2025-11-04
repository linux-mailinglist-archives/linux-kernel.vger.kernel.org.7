Return-Path: <linux-kernel+bounces-884815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C097C313CE
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76F624FC342
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C3E262FC0;
	Tue,  4 Nov 2025 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MTYHXUIN"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0203261FFE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262754; cv=none; b=kQZfE004OU/hQnnRB5g9ux3IIqJUSywdh5nA9rASlWwQwzk4t3JBVlUaKwYq+2q4gW576y+Jq4orSNOVEQyUnfPKxL+5FyG48ctudSP726/Nlhl1MFZ5FXfYZrr+nHNFKoJXiZT/yCJV4ql/sQW3M8d5rDzFnotL+8Kjps3p5KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262754; c=relaxed/simple;
	bh=Qsf2GQky7SiCrMKOgn5Wbw4eFRsOa8glOeOSc5TZCCU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=frFbVgsfIy/6Tnx3RurTHd1n5mbRG3wC2FXAdSCVm7+q0Ts5le9pyGQMmVkFMzpD9JaIkeubmWtS1br2iP6GJbGq/jBOL2uvsoNn4m42LaQDA9AF4Q0852+ZRwR0D3sXaSShOe8aA9tpIuoP3E1INnKsPfRYTKwuPuAMwQQ+cbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MTYHXUIN; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c0c9a408aso8068298a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762262751; x=1762867551; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qsf2GQky7SiCrMKOgn5Wbw4eFRsOa8glOeOSc5TZCCU=;
        b=MTYHXUINFRXX5yNHXsFQIbdJIsMVL0JUdFrUJhn+BOgoysdP30wvuSjMrUOMokBkWZ
         icr8d9lZ0lRHaAF3EZG9KOnQm2XcKrGd8Ko/iPnw3gfNtmYjsrunXQAmcqQZq7O/mE7N
         Frp6lx5PjCnIT0PP/E9iEQ0y95IyFANY1u4TJI1dJW7+q9bpv8iIEFusPYCvkCB9ZRRU
         /Awz1GeZx9VH/7rZZ+yDCLKG6cu6m1lSktg7WXkQgtjiDpca1T2jcdRdcLMV2BHipzLT
         uOw8+cN+gQRv5TicbisywOvXf1XwF6wXrUPl3UzC2vBq7kcYHD8Pbn+iKR47QknswtSG
         eJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762262751; x=1762867551;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qsf2GQky7SiCrMKOgn5Wbw4eFRsOa8glOeOSc5TZCCU=;
        b=ZnMhM/cJHulLnGVAcy1oZFnw9vS2FNpUH0DcQovA9dlLONaJKHEuiebvljA/RWGoV8
         A0LhdhEHluu+s84W1ho2xHcVGuIpHTkn/+OvCMpM8J3fb6AD705Fr/7EsB8QMeZopVXJ
         vdOzz3xJBcZs8gWEs7SU3MQlZzJmceaeKz+2XwKvzExSXsw0wcZ8Vp+Lqhz3ev06pJSB
         ALvoglG4ijLY1wiQYgH06GDap21SOh++51yFrwUusaDZBcWZJdLnRpL8JLNxAEWiFyT8
         GyiFZ2x4r6cZwMoVOi1UzDkOv/jec8HqKkk2c/+6WXoU6o44eb1OXnj7/FqLdnL4mg0H
         ZkfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfrCjRNz+953gkvdwE0zJj+zWZlwKBNOjYmrjgGoEDZhFiqfat/HIwcd/jK1VMNhxad0STUYYD2R24Gc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhe9TsQwzcOK7m99bDmsY/dPL7nOBCncgB0bjBCaAhuhBf1XhR
	XKek34L2uSKFP27ilJoS5Kb0NeHAohHG4GzU2iLVpYOX97XdCN6JwzzDeGjQL80lmtg=
X-Gm-Gg: ASbGncs/niVJ/xFOduKQQXKZS+qbcOMTPDKyUY4GYTxsz12uhoQv+dkIsGcompw7P8+
	UT61RBblEd0dA0fLu6JCS3fEUYEmCKXJ6MTs+oZBbptInaLE+FWJ9qnj0aBcpICb2ZA/fBF16pi
	ZkazbE8H7+0G3pjYN413UaQPHwuueOKVjGR0k2LS0T0YqxYg2/uSI5z+P1k0mFJ2JiRznmkHUbq
	kl1esKJLI9nrFpTPvTtnme6JyZmsxRf8E1XW4hnWACsci/TmALz/hM6kpvGBKin88PdrlIts/v/
	AlftX48ElicwpfcJRTvmD58XQ0I6oRj3tetUgizLm7PtB7RJ0/kS4lGI1+lyuYVM/Y8BpVP7IVc
	6PjHHXSNEmQTrZZmQnnstDtxCed5nHLCKHiHlvHR4iDdIGFuawRRCCibPg7fS+mw1qPrAVlazWo
	4c8fynl0bDf1i9iw==
X-Google-Smtp-Source: AGHT+IElp8wee46nZPe+Qnw/pdxkGqe40IGNO7IUlSKUetDFQ1Idpmyc8H9zzJSm2a5OIdNaYfCF0A==
X-Received: by 2002:a17:907:26c9:b0:b71:ea7c:e509 with SMTP id a640c23a62f3a-b71ea8c3121mr420101266b.41.1762262751243;
        Tue, 04 Nov 2025 05:25:51 -0800 (PST)
Received: from localhost ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b724034ade7sm211180166b.69.2025.11.04.05.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 05:25:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Nov 2025 13:25:51 +0000
Message-Id: <DDZY0BMTDAWW.1VSA92JVSMM1E@linaro.org>
Cc: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <aiqun.yu@oss.qualcomm.com>,
 <tingwei.zhang@oss.qualcomm.com>, <trilok.soni@oss.qualcomm.com>,
 <yijie.yang@oss.qualcomm.com>
Subject: Re: [PATCH 07/20] arm64: dts: qcom: kaanapali: Add remoteprocs for
 Kaanapali SoC
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Kumari Pallavi" <kumari.pallavi@oss.qualcomm.com>, "Jingyi Wang"
 <jingyi.wang@oss.qualcomm.com>, "Alexey Klimov" <alexey.klimov@linaro.org>,
 "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.21.0
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-7-3fdbc4b9e1b1@oss.qualcomm.com>
 <DD6B62STZOTG.L12V3DGNDZUZ@linaro.org>
 <bace46c5-e912-4003-812b-c654673be43e@oss.qualcomm.com>
 <d20b8fac-9676-41e8-a32d-006af74f4c44@oss.qualcomm.com>
In-Reply-To: <d20b8fac-9676-41e8-a32d-006af74f4c44@oss.qualcomm.com>

On Tue Nov 4, 2025 at 10:01 AM GMT, Kumari Pallavi wrote:
>
>
> On 11/4/2025 2:29 PM, Jingyi Wang wrote:
>>=20
>>=20
>> On 10/1/2025 1:24 AM, Alexey Klimov wrote:
>>> On Thu Sep 25, 2025 at 1:17 AM BST, Jingyi Wang wrote:
>>>> Add remoteproc PAS loader for ADSP, CDSP, MPSS and SoCCP with
>>>> its SMP2P and fastrpc nodes.

[..]

>>> Fastrpc nodes here. Was this tested? If yes, then how?
>>> Or was it just copied from somewhere from downstream?
>>>
>>> The same questions basically go for cdsp fastrpc too.
>>>
>>=20
>> +Kumari, could you please comment on this?
>>=20
>
> I verified the CDSP and ADSP nodes by running the tests available at=20
> https://github.com/qualcomm/fastrpc/tree/development/test. Upon=20
> successful execution, the message "All tests completed successfully" is=
=20
> displayed.

Sounds good. Thanks.

Best regards,
Alexey


