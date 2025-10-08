Return-Path: <linux-kernel+bounces-844970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8096EBC32B8
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 04:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D6E94E4CE8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 02:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E81299AA3;
	Wed,  8 Oct 2025 02:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hTAdcuHp"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD902580FB
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 02:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759891248; cv=none; b=ur/Cq97MqOD+Swya/lxpVpkNzsKcI777QnRrqu0BrnjAYJtj1pk7qw9MWQ1txo90uLE2ysIIeTC/x664t2pkW61N6zubhe0c5ulQq/vRG3c9eu7w1AezKd1XfbdfHZ8O8iO6T715GW0MrzWtKFUd0lUSpS2VKUVgtFKlQTwSNg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759891248; c=relaxed/simple;
	bh=vbpwXTejC+yajTX3XXncJGeds605AJHrgdSUCP7BbNs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AJ4L7wTmp3EIW5dKirqiarVL3LvqyVnTPM3jvANvMd46SUuserXyJl5FVPYTa9qy+q/9pPz7z73g7K2UbqiXo0u8nDOTtJI5U0frCFCk3N7wKxN5Qq7yob+mKVYW5cSVgqWnNJ9IR4+PLVlxeEs4K4UX3KClStevs3Y03shYUXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hTAdcuHp; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso208296f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 19:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759891245; x=1760496045; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbpwXTejC+yajTX3XXncJGeds605AJHrgdSUCP7BbNs=;
        b=hTAdcuHpIxENGBpN9STA3bI7YsxHoTZ6EtRCkJqoMD/wiGNCAwTIKV7IsP8wPyG4bB
         U6GLpIU57vGx18Wjj4enoKZBERR5wmO+CeozzgXfVXfvblWakhfgees/6FpyeltmCUju
         r+vcJuwd/tQkQivDRtnhhfLFNyUpFiDRI8wWzWJph5fSpU5lb4/WfoN4XMlMK2tNKP4c
         q7vH969Hk7rYMvcGQmv2gquNNzh3cjb7FCO5O54XwwE3VQJr5H+Ly2ZHS94RxjpZKVZp
         Ty+Q+9JpswO9NMCEI7NDDv3pmVG0bz3NJfKPd27U5kJIHoTQcYK4lmCsqIRreMdBdLK6
         1NOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759891245; x=1760496045;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vbpwXTejC+yajTX3XXncJGeds605AJHrgdSUCP7BbNs=;
        b=dFfsxi+YFCo0yh6bZ8ucORmeMb0PNr/ZyVm2bAvfNFt1yH+oWKcvFGdPUwBouP1gwE
         Y98BctXqop8f6iKJ8SSM+m0QuKhKdPFok1Wz4O27EInuyIN98teJyMCrxDIKfUuPQz/I
         SeGVTDUcAb5gqd0yC3wOMCZhUkBU3Vhs+dhvcvnUbSF6VuyVPU1MtzHyEGZ16lCCytmM
         kTY7yzwvJq7PY9xlNMbpjbVlsqw8cDwlogVTBgr7dre5YWlclXslcfA8nGPy/bgZoS2Q
         roQNFQmT9FZt+5lZbfm5LJAGRszttG6Uwp7kasXFvueRhAHqIB/uvEdTzDnwFkbn6uhA
         CTcw==
X-Forwarded-Encrypted: i=1; AJvYcCWkbi4EfTlOGqFpRnat+8xedoaQBOyYYtv6jaB4uK0Ka0RMHuRzurPdhTGO9J0Wc5/bW8ncKogaBTDxQJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdMGwB4edeNPcbGIrgFx6aygCHy4cTxDgjxTAdHtVQ89khNcww
	VlSJHRctv9cEhaWtdQ1kNXyL3vAQmSH88j+4jDEhg4fURwl8uwQZIYxJHO42vksy/Azob9L63hA
	drQ9Y
X-Gm-Gg: ASbGnctglOUBUk7tWqn4GElF2gEQh3TEtaXGru+Xd1zz4nNPMznm9gAnOmItEeTCnzJ
	ssoUm1sz0LlL45hl3+RDxAChzJ1ceNXln5C07QuBpToDUtPRQzGFqEn15GG5y0PQyi+EJeSijmn
	D9GdO9dLq4sLBMdZ85n83f+r3kOycbVQ45QVz5hAYLvKyVeUUumPKgdFev5ht9u8qM9RfgvGYx7
	XrRNvY2cLITvMoL9dxcGKOCjjEWXBLDY8sKsBG1++oUBcwPZ7mPRyBqpaNvzzl1Y0E4ozgkZqna
	Cs8PGeziB/UqxWYpnJpj+XLgBDov7G82xlvOnJG8UfP+CPnB/utsa58555rj0V65lUDY6m9sjQy
	RgyDOb9H4xYHBZxVg4GmIp5sywu4zYyhd1hhakYq2oWH77JUvVVR+aW0=
X-Google-Smtp-Source: AGHT+IFFqlDGt7h0nc+NuKrTo3pc2pheELlH3q2GeHR9OiCLFLF0nYVBjizloysNNRJBS6y4P310LA==
X-Received: by 2002:a5d:584b:0:b0:3ee:3dce:f65f with SMTP id ffacd0b85a97d-425829e7935mr4259067f8f.14.1759891244667;
        Tue, 07 Oct 2025 19:40:44 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:8c32:dd4d:57f2:8be7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9724sm27496800f8f.28.2025.10.07.19.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 19:40:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Oct 2025 03:40:42 +0100
Message-Id: <DDCLDNFBCALB.19TNBLSQJ5X86@linaro.org>
Cc: "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>,
 <linux-sound@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: sound: qcom,sm8250: add QRB2210 and
 RB1 soundcards
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Srinivas Kandagatla"
 <srini@kernel.org>, "Liam Girdwood" <lgirdwood@gmail.com>, "Mark Brown"
 <broonie@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.20.0
References: <20251007-qrb2210-qcm2290-sndcard-v1-0-8222141bca79@linaro.org>
 <20251007-qrb2210-qcm2290-sndcard-v1-1-8222141bca79@linaro.org>
 <67e313d3-1f91-4205-8aec-fbbfa41004f2@kernel.org>
In-Reply-To: <67e313d3-1f91-4205-8aec-fbbfa41004f2@kernel.org>

On Tue Oct 7, 2025 at 2:45 AM BST, Krzysztof Kozlowski wrote:
> On 07/10/2025 10:26, Alexey Klimov wrote:
>> Add soundcard compatible for QRB2210 (QCM2290) platforms.
>> While at this, also add QRB2210 RB1 entry which is set to be
>> compatible with QRB2210 soundcard.
>
>
> You explained here what you did, but you should explain why. I don't
> quite get why SoC sound card and RB1 sound card are both needed. I would
> just go with one.


I wanted to go with none in the first place and just make it rb2
sndcard compatible (as a fallback). Then Dmitry suggested to follow other
sndcards patterns and implmenet it like this.

There is also at least one qrb2210/qcm2290-based board -- UNO Q and at this
point I can't say if it will need separate compatble or can use
qcom,qrb2210-sndcard as a fallback.


> Please use subject prefixes matching the subsystem. For bindings, the
> preferred subjects are explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-pat=
ches.html#i-for-patch-submitters

So the order in subject should be reversed. Got it.

Thanks,
Alexey

