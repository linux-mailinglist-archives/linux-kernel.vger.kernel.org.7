Return-Path: <linux-kernel+bounces-811645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4102FB52C06
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025A9A030FF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E542E54BF;
	Thu, 11 Sep 2025 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XnUQwasN"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2F123372C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757580265; cv=none; b=Z17ohGKtOCilkBZK3kJNdCyi27o/RKdy0kHKUv8wC1Y3fIHoZxp3hSGwoDNcz6473ZVTA8FspiAIdx/+EGgNbSXMKByqWABI82yU4f6p+5v8qJZzP88M5CBoZ816Ixo8DwHvWUG3CXXZjDQSJK6W6IJviHlQChqeCu8kbX9p7fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757580265; c=relaxed/simple;
	bh=1K49ZJm2cjVDd4VuqrRdstuQEPhQ6l2n2BOtJAelo0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJCmRfXQnq9uxPXDBoqkwBpw1alH3n1hqJd2Pr9BscWyvUfR4A2JvYAM2gOwqcF1HV8nj9UJQyr5lB8+0+vLhh0e8p88m/pj4ds+jOkx1QOI/5Cw+/zr1t8v2+vfRHEWoYuIHRPRoHJSWp4Tl4mrv8+OQqL5/n2d0UfTEsdZzCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XnUQwasN; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-544bac3caf2so1198887e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757580262; x=1758185062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuBL8uqFp6SRqtjWGK32//PnPpBAxLJ8lgwayga7/Cw=;
        b=XnUQwasNTu9+h4/n9MAE+OBV8h8PTAtVF3osot9KrsOdCstd94jvh4f78TWW6CMRy5
         +m5sZaWyDaZrWUnGZVru2wMVzWUQUN2J1ffBTqpv67TwMR0OYHY2JUV81zGWfP0HhVZr
         Q/vtkCI2tvEiADlalCunzLqT48G1FskLDKs/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757580262; x=1758185062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuBL8uqFp6SRqtjWGK32//PnPpBAxLJ8lgwayga7/Cw=;
        b=hmKun7qbGPaPQDXAl4H7rP8SIDqVOvWmTINFbTf8y9GwSi0SRDSJNNUuTM2Qwd2U2P
         mszFhsJXnSP9ABxlzPonb/KWyU5IjOmlLA67tArLN/gaUfdBY3yS9fFn1O7FVlHloZW9
         TMxgJKf6LvaNfMvqMklGz0ZWDCQMOFPF6ntyzJRv6R1BFMISTDPUzoBygIG5XMc4E2fc
         OcluwOfAOjtROp1mZSLPSM7QSTGNxLufy0h3FUG8anDZxGREKNxF4KlG2Mbo5u7OMMXi
         IfaiE5ehteMBARexdFtnjwNwOPvPWUnCytA6bFXu0NvJ84UyC7klHl1CbYWCT8RoYX1B
         L08A==
X-Forwarded-Encrypted: i=1; AJvYcCVVpg8pktcyPJ2Fl0GfKdCk49mdBQRpPf78AqtVqVhwCTT4yU5KpQMyysU0CODIvquP38lGc5ojcnbBp7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMi/lMSYU3LnpGqICC5L70X10oZB1mHt5sl/67q/jvnKZIzSCl
	UVGk2hnA3tlJoO1ShfnoGdlBPqPwn3s9Gle/uW7hIxCqt6ivrSLK4VnToPqh1q/R/S3OynI31kP
	jpCY=
X-Gm-Gg: ASbGnctwOlonpaEpazGON4GfWeFNDlMOJ9Lb8KST79yJLLTm44ry+ACG7h9TitocJue
	55+gHNKZaB0KVqc+X8rGOr6HThkk9mPbxUJlz+Wfh/AbcEyfP7OR6+I/e3myHI169S6aG14MjSt
	+RDyVZElf+M3vqLm/mJ05udy7i9jExkoumRS/eA1c/ERceK4pO9uwo++n5Zkz5AdqbZVpfWfOfh
	iiFw1bQVcTX4gSLsCrvEASxE00THRD5URQj9e0P9PxJ6/z8n7RUDU2QwLvQEjdAIEc5ER2AxSrj
	/nZiNx6NOCdIoi5r7iDzb8x4NklVjYQBrSOzDufJnTPvq2oLJRP+Xm6lREx8NB4ZHsaSOKZ1VzX
	2otDPVJ4v45HnyLRF/TFv+T+6shD9EOVaCRvssor2OAD9iUdCNBUbq10YnA==
X-Google-Smtp-Source: AGHT+IFAa38i+qivgCKHAAy6W86HYjsE18w1YMOKbzS68NATvQHfQTemL3SKXG8fGQRgoa95rCp2BA==
X-Received: by 2002:a67:e706:0:b0:530:f657:c2e with SMTP id ada2fe7eead31-55209704db1mr1112271137.13.1757580262598;
        Thu, 11 Sep 2025 01:44:22 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5536f7c6a99sm204920137.4.2025.09.11.01.44.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 01:44:21 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-8900fcc0330so1054371241.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:44:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU28zWgl0sFvnnxU6RBa5ZCDt9/qjD1KLH/s91RfuixYieXRQSnhBkqP8mDzUQOsLxU8xtbDdy7FEZhtsQ=@vger.kernel.org
X-Received: by 2002:a05:6102:5086:b0:4e2:a235:24d1 with SMTP id
 ada2fe7eead31-552065728bcmr950644137.4.1757580261120; Thu, 11 Sep 2025
 01:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908044348.2402981-1-fshao@chromium.org> <20250910115508.0000785e@huawei.com>
In-Reply-To: <20250910115508.0000785e@huawei.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 11 Sep 2025 16:43:45 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhDRQFVBDydTq=fmC=jz8e941aPwzg+cY1ZQDqWppx+fQ@mail.gmail.com>
X-Gm-Features: AS18NWDats_rTOk_H5DcYgtjHSlZm8cS5lY_RPdvAh5_wYx68w1LGLEaew8wQCg
Message-ID: <CAC=S1nhDRQFVBDydTq=fmC=jz8e941aPwzg+cY1ZQDqWppx+fQ@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: mediatek: Use for_each_available_child_of_node_scoped()
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 6:55=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Mon,  8 Sep 2025 12:43:25 +0800
> Fei Shao <fshao@chromium.org> wrote:
>
> > Use scoped for_each_available_child_of_node_scoped() to remove manual
> > of_node_put() calls from early returns.
>
> There aren't any early returns here.
>
> This runs into some of the stuff that cleanup.h docs suggest we shouldn't
> do which is combining gotos and __free() magic.
> I think this case is actually fine despite that but in general worth
> thinking about the code structure and whether that can be avoided.
>
> One option would be to factor out the loop into another function then use
> and error return from that to call the stuff under the init_free label.

Fair point, I can send a v2 with that.

Thanks,
Fei

>
> Jonathan
>

