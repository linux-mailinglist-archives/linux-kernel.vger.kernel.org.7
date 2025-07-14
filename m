Return-Path: <linux-kernel+bounces-729644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA140B039A4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D425B3B4F59
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCF923B612;
	Mon, 14 Jul 2025 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Um7C8wHO"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0878B101DE
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752482261; cv=none; b=eFCyvhFAL5T57syO6XAvlxqoNazvFiYjQS+lpuRLANrcNYdSjVG0kYK/BVRj/uz3jjDVqjm8dNXkN65zwAXBR3hgtq9GXOnMchtUiuhNkjDu5S/2uPYFC7dTzcc5a8p+Yg0mkAXW2dW5v9+3auvnBuP1jeAKpZszB2kvHWwTtQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752482261; c=relaxed/simple;
	bh=cFj5eeBSExWTpQ/HwTcn0/zymDyCea+9T3MnfE4Y/As=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=dJRQhHGy+p+qkT9mL8ibDEX2YGU6Sl7DTLPyYx0zg41VnkWJWitFpkoXWt2cB7q5p25Y+Gn/27HuA6mXLY6YUIuSz+Xv5zpnLZf+opU1Lea4FS1/JzjcrQlQxRgNK+343+gUfgz/I5f+3s8u7k+6i1yNhY2wjMgI5Y48SNdQOp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Um7C8wHO; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae3be3eabd8so854923566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 01:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752482258; x=1753087058; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXsZdLs2z4I7jkOtdXK4ZMSs6eg0//WRTlMsswQxRuw=;
        b=Um7C8wHOb2QsR9ZTi7oYXdzojDvLtC0pbkZkZanPRXvOB7v1DH6AhRqhOCB1THCXzt
         bg5moJVh/v1NF8eG4saGQ08/3lMFVr/gnKaa/qBQlaJKLMsK8eaR0sM+3+zsen7l/X3F
         plFvcr7afbqnqnq5EhD4j+oADdFWqtc/VVGM65OmJQrxkB1gWh4aVjFTu21H/eHXCaka
         nRsCMk5oC8DKocGFnb8ixIUNTMjkDS8wzdliXYhlSuxDpEG5hNdSJ+j+psi8Sgn/x0Pk
         ZvxQ+h+u49g5asxfxW4Ickag4SQXsDp3PLHHrY88IMK9JD/kH2ySvvEjyzDlKEoKHQDa
         S1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752482258; x=1753087058;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TXsZdLs2z4I7jkOtdXK4ZMSs6eg0//WRTlMsswQxRuw=;
        b=KEwK1ByjTzFkXFhs+uIErD3nvqXZvRP0tWqJfo3kzj6c7a++ssZ3LuP4RVuE9lxzwA
         9wHNEh5plj52CQ0YDGhz2Zk0pu1MkjqGKyBgg6lCFtJMu6jdh3S4ewiELS2OKEAuKmvP
         HThrbZHZ1pwI1YA+Iop9GWKoofyHGG/+eQnYrqu/zOWQPyV0g6ZYklT5Kf9hfTVPoIsV
         ZLSgIdZ1gjQjXjPoq6ESVRVks6iIF8kDf2CMz34TB+vY5D160S1UicWBD+cASuOH1PlG
         yPRP9v7TgJ1GdNvlVlKt/xGvB+ZFB8oqQN73h8FOvEDNYxt9a12xnsGQxi8Xedx/vhc+
         jI+A==
X-Gm-Message-State: AOJu0Yzyxu2HLmJkWQwKTMIUDUKDqIj3SwqBYtObaqswV/UJkoH5y/jz
	oEwxbmfJt5Bw+k2g8DdtC4XratDMDd4lvB1hgoOgg+PIh7K6bU4iHkYyWGj/mV2XNDY=
X-Gm-Gg: ASbGncsYGvbeTgzPMkmKV8unaTz/IDo9EpeILNCTNJkBCkdQOha4OIbX4NHmTa5Em6q
	jMpesYAt4Paq08AY4zL+g+BR7lUyrtaD1/LyVFMtNscRVnEqPc8hFgVNr0UgTD39QtnzanxYPaQ
	p2a3e+6w6ZQJA9p+GYkPhAFRyq6ju0Cyxg2ny5x0tcyS99Y2T/EX4x72PedjDYLiihznGvMAPH5
	DdaX3EfW0P3/4LGH2XFtfre+z+WwKBmBINtTBh6czhhFKVAVfvRPvbRB1SLIBQwznDRt3Y3YhwR
	fO29moRkrvrRGRY+/vIvqP0eY7nfVxrU4PbpT9Latqsp2z/V0TC3XeATahP4lrQRmC0PTmSWSfL
	ejhDaJb5nUpPjejvN4QY17QMjk4EbkBU8JD5KtfBpEdTn7fkC5iEhjENCEUJXTmgMVMU4fZEbnN
	G5esVIDH1GfJUpbEcGdQC7YVm4t53eGgQjNQ==
X-Google-Smtp-Source: AGHT+IE2Qj0I2yzWrMiGCxaPbtun1R7PKz3AbxgLlIXZKbAlmPcU2AVCewde9Sqhm+0Au9TYSEdYHg==
X-Received: by 2002:a17:906:f596:b0:ae3:c777:6e5e with SMTP id a640c23a62f3a-ae6fb838efdmr1224680866b.19.1752482258190;
        Mon, 14 Jul 2025 01:37:38 -0700 (PDT)
Received: from localhost (2a02-8388-6584-6400-d322-7350-96d2-429d.cable.dynamic.v6.surfer.at. [2a02:8388:6584:6400:d322:7350:96d2:429d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82645b8sm782699366b.106.2025.07.14.01.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 01:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 10:37:36 +0200
Message-Id: <DBBN42KD0D2L.10BGEGJJ5XH0J@fairphone.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>, "Linus Walleij"
 <linus.walleij@linaro.org>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, "Linux Next
 Mailing List" <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pinctrl tree
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250714170848.0fb46353@canb.auug.org.au>
In-Reply-To: <20250714170848.0fb46353@canb.auug.org.au>

On Mon Jul 14, 2025 at 9:08 AM CEST, Stephen Rothwell wrote:
> Hi all,
>
> After merging the pinctrl tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/pinctrl/qcom/pinctrl-milos.c:1323:19: error: 'msm_pinctrl_remove'=
 undeclared here (not in a function); did you mean 'msm_pinctrl_probe'?
>  1323 |         .remove =3D msm_pinctrl_remove,
>       |                   ^~~~~~~~~~~~~~~~~~
>       |                   msm_pinctrl_probe
>
> Caused by commit
>
>   b614f176b308 ("pinctrl: qcom: Add Milos pinctrl driver")
>
> I have used the pinctrl tree from next-20250711 for today.

This seems to be the for-next/devel branch not containing a commit from
fixes. I'll let Linus sort this out, just needs one line to be removed
from pinctrl-milos.c as per
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/co=
mmit/?h=3D56ec63a6e107e724619e61c7e605b49d365dfa07

Regards
Luca

