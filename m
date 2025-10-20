Return-Path: <linux-kernel+bounces-861833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8D6BF3C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04836351D43
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7751D2E173B;
	Mon, 20 Oct 2025 21:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrnTDDHQ"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12F6332EC8
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995811; cv=none; b=tcoVZcwTX4vf/okkeV2Vf6tadYPiWdgC7LKJwGqhM9MeKZHUdfx5q6Y1V7m3hxcHcsH9jJMDCRfTCggnd64w67ed43Y6ZXq4FKJ3yy1zHynt9N/U84OEdwDGvcm/s6uU+6bcYCvnxltllhM6j6nAxpeBGhm2ptjFm/dYzc485RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995811; c=relaxed/simple;
	bh=z6lh+i5u+Wh6yLod//AsM+A5+3tCiCGhL03IBz7fnx8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=KBHtR8hsSbHh9VXHNWpJ7WQTuE6vrvN4X7SGmCwpyIuIToO5xRyGTMVCtLMnwUIzBS1vWZE0atUpFK7o2CDL7N5tEI4b6kRVzw5+CRuZWIT7bTdpdzSEjIPGXAQAzWJNqSZyoRouveESwna1cTdwra09B8Muui1z/srgZTsqBWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrnTDDHQ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-57e36125e8aso4730883e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760995807; x=1761600607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z6lh+i5u+Wh6yLod//AsM+A5+3tCiCGhL03IBz7fnx8=;
        b=PrnTDDHQ9nBvXHaIltDGt0K9kFe+TiE+Jp52IvnpPX9iJ81kWgFNqCdZgbZldTT6O7
         /qzAGlE8t6AQRqIk/PlBfAJnUeRKlQTepO4QQm7ZyXT+uDmrukaSgKgOa3w223Eu1ldO
         E/KUlspCEi2tjWwul6yLNOmnA815gBkAVHnCUr39hJTBBBhYNAWSPnJEVyOOglT3p4++
         8IibYnmysRgFI5rkM/iUS1cjz3y29G30IIvE9P0RVfyqSKyzepC0kRfTkmK8kS1ofujw
         nJhWFxqzNKTcSIrPdV8Ckebq5nwm6OywlHhY4X90AD6UQay6nHq6zYK/hLOCXtI/GMf/
         RIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760995807; x=1761600607;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z6lh+i5u+Wh6yLod//AsM+A5+3tCiCGhL03IBz7fnx8=;
        b=GXYDD2lcS/EKeE4ceVFeHXsczXyPBh5Eb7RkZCbT9JijGOST4Ky+ocLB0o8J7qqMJB
         zxCx/pLfG57oYtWq8E/ec16u/QQwCiw9cNS5PXAIj9gbAk5t5TIK3U9woOtlW29/rGb/
         a4LRn1RlySeH6e1oyKlzMwNHRkifR0AQE85Z9B81Rg0rA3qK84Mw4Gjr58lmf9qQleql
         RIVVL09KJPF8G3P0VqwLqdM9rwPU7q3q2PYcpLHLDGFLasrIXn/CilDDErVfHAk1gGYs
         zPBrNjkH7rd5JPm1v0RHcH8waY648gv5zhh+aIp4G7JTUL7/hHtBbejuzYT+GCLiyHTP
         nRCg==
X-Gm-Message-State: AOJu0Yz2Edib6ZO38gNiEKPRp60BysoKNEupZWfILAoEF31gspNLHWYv
	NQsRRoBONQzX7FCDvvp9C0nN20hxKytJX+czI/Xia/0UFQZM2NgZezAiCHMrhQ==
X-Gm-Gg: ASbGncvqPEtUdPI3+o/3ez6O6auSEBvpeGEKqiRtLle0IK5ef4W4bQ6T/Nf3F+NTAUa
	W0gEs3D+ESJVIG4UAO6Gq8DpS3ZN5WLsx3CS7UM+HbX+/OA8pQWSZcugxthTvp+fWZEkFvl3VA4
	3DBpASJNZl7NyKasXdKEEbTrHoMP0DGgl28I4a/HoKYcYFK9a4JU6U4VzDCithyrUdE+2/TvxPY
	HRXxlqy0sD4YLLZeluUMgwjJyFvuTLazkNFapZguzVBDnO/P/yHFb43iQN750Wnx83Nvlmzq66r
	L1iQxy2f82aJtur4InRswidwrY3gHLnh3nR1fiIzil9qxXos7msjjSVUCl8FelalisRuGtppW1v
	BhjAZ7Dz2vdMkAnsZ/7n7AaGNiTLq0/sI7joZZ2iJ9MXipR0WpvhG48cCQLNdN3cbnqPl3bq5LR
	y9O+E=
X-Google-Smtp-Source: AGHT+IF5Bo08jM3TJ9uTNNWsiKlOlxEIRjh6gnDCwho4yiSF9vdgaePcv1Kqghvk3FNrZemW5YDYQA==
X-Received: by 2002:a05:6512:3341:b0:58a:fa11:b7a1 with SMTP id 2adb3069b0e04-591d8566459mr4087945e87.24.1760995806577;
        Mon, 20 Oct 2025 14:30:06 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def160dbsm2863843e87.62.2025.10.20.14.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 14:30:06 -0700 (PDT)
From: Sergey Organov <sorganov@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org,  Russell King <linux@armlinux.org.uk>,
  Ulf Hansson <ulf.hansson@linaro.org>,  Shawn Guo <shawnguo@kernel.org>,
  "Rob Herring (Arm)" <robh@kernel.org>,  Angelo Dureghello
 <angelo@kernel-space.org>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
References: <87v7l03pqe.fsf@osv.gnss.ru>
	<CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
	<87zfa016bd.fsf@osv.gnss.ru>
	<CAOMZO5AFer_Yy20fqD9oVSNVPR2ZvvwYbrkSuj7eFgS_uMJC3A@mail.gmail.com>
	<87v7ko11iw.fsf@osv.gnss.ru>
	<CAOMZO5C0=vy6aABa6PGrD2iWBBRQ==LfpnRg3BTh_yTSn3vHcA@mail.gmail.com>
	<87plav2186.fsf@osv.gnss.ru>
	<CAOMZO5CsY-zRPE4hm=1kdTVquY24Y4T3evQrn9E792xZ434vBA@mail.gmail.com>
	<87y0piiz04.fsf@osv.gnss.ru>
	<CAOMZO5A2YMQQV8J6jg2o0C3qeFif0fSc5j6-98xhqNz=Lk4T+Q@mail.gmail.com>
	<87ecr9upfd.fsf@osv.gnss.ru>
	<CAOMZO5DmzokFbmucbcDg73CKzaz0vVdMgnfLdBapHFLWVzEqpA@mail.gmail.com>
Date: Tue, 21 Oct 2025 00:30:05 +0300
In-Reply-To: <CAOMZO5DmzokFbmucbcDg73CKzaz0vVdMgnfLdBapHFLWVzEqpA@mail.gmail.com>
	(Fabio Estevam's message of "Mon, 13 Oct 2025 21:45:26 -0300")
Message-ID: <87ms5lqn1e.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Fabio,

Fabio Estevam <festevam@gmail.com> writes:

> Hi Sergey,
>
> On Sat, Oct 11, 2025 at 5:57 PM Sergey Organov <sorganov@gmail.com>
> wrote:
>
>> I'm not familiar with the code and can't figure what exactly I'm
>> expected to check. Could you please prepare a patch, and I'll be
>> happy to apply and check it.
>
> Here is a patch you can try.
>
> It's not a formal patch yet, as it needs to be split.

As I've already reported, this patch unfortunately doesn't solve my
issue, but then things got even more "interesting".

Before I've said that latest kernel branch lf-6.12.y on
https://github.com/nxp-imx/linux-imx does not have the 816978f83b
commit, but yesterday I've found it does include similar change though
with different commit message and without any reference to the original
commit (that's why I missed it):

https://github.com/nxp-imx/linux-imx/commit/3f127cc4f5f0f1c8563390c4db7727fcb5735aa9

Now, this commit does *not* solve my problem either. I.e., lf-6.12.y
still hangs on my board. I even tried to cherry-pick the original
816978f83b on top of this, and all the conflicts I got look formal
rather than functional, leaving code unchanged after resolution, so this
commit is in fact almost perfect cherry-pick of the original 816978f83b
that did solve my problem on the imx_4.9.11_1.0.0_ga branch of that
repository.

Yet another thing I figured that it's unlikely powering problem, as both
3.3 and 1.8 are still there on eMMC when the board hangs. Clocks are
most probable suspect then.

I'm going to dig into imx_4.9.11_1.0.0_ga branch again more carefully to
try to figure what's going on, and what actually either fixes or
work-arounds the problem at hand.

-- Sergey Organov

