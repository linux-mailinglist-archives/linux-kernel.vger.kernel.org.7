Return-Path: <linux-kernel+bounces-879142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15577C225EF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4731A22247
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E03219303;
	Thu, 30 Oct 2025 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UkZ3/dam"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B640329E40
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761858239; cv=none; b=gyjNWvpd/OftbSEZoPvI/URCiYAo60BNcxcLpvZ893NmnUbrZV1juUgT9Smjqsepj3nlpH2u4fscnE3cAy2rD3WxZC/K056ZwxKADUy0OPYjyz6z/INvcsNb8I5l3stVh8idplWOrHE62GHhntXGhKGMCLS+2etfd6KbWAVD3LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761858239; c=relaxed/simple;
	bh=Mmg0QcOckoARFwLJXtWfFSkFuqQoLOpNDnE+ivjKx9M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KKxt+lcHb808484ikFbq/6OHib4lxlsmjIx8xXz2mtEu5Rm3kdD3IrVvigFcDyNrk5PG2BQQFzIBH/qZzNevWwxLuFrpbdYEvmiSQYHLf9Xrs6uTjuzT6BRNGq1cXbxLjmjmo65IHOiLR2eCj6hmrE61OzWm+V3IR5Yz+niywRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UkZ3/dam; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-471b80b994bso19339605e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761858236; x=1762463036; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mmg0QcOckoARFwLJXtWfFSkFuqQoLOpNDnE+ivjKx9M=;
        b=UkZ3/damTIqvOWERo56XKIBZCdAm9AZkcsyynHOpmH/6mG6U03VaSjqxyFUPJBm0bU
         OP0F0NyyiR9YmK0u3w0Zi40A2+yOI85fEN60jSI6KCDZvrdh/lFK3o9+PYGMLQCOrW1s
         YZUSxmrVnjiGt+7hmpT9GHu2SzobUSEl9seEzz8gCMEqGF4ShmVRn0br2nOSM/78BEVt
         QGCm5Ju4UajqUY+AzPT++Q/n8owf7oP0nqteiumsbuu0WtM76lpdZmpdrmVau3Xpq2Us
         2DDpL30cNpE8shiEl3dIst+Fv62+t8JXpxKtPXpgBhPDyIPsN9/xuK1zVZTSX4+OHVF3
         pL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761858236; x=1762463036;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mmg0QcOckoARFwLJXtWfFSkFuqQoLOpNDnE+ivjKx9M=;
        b=L7sUc3JVEJUn0BLs3Lb/8Dw4HCgPXtzeXgt8qegIbvijrT2WnOvCNZzkFcG8G7F/Rr
         4TbobApAqf1Z9vk58mpEafOkN65fIelXwqCrcuDiYUXWU0ZNZ82TIuJZjFt07rTfKHM+
         GYzkmyIodCXD7hR9mg2SuPFnULeaO6oL9WmkPLnzCfAKLE1B6bcWzJM90KCVf+zKctXN
         MRzJOiuhwXh7WAd0d8J5zo3cPy9sz7wu0SGATXgbjjmNpcqIYt2OeJw6/QOzr33nXOP9
         jbrP7CeAELuQeBjfxnejjbXTI+GuYHyZrD5Z/3k/bSFKSWjkAiEpledUotxsSTqJt09E
         SXew==
X-Forwarded-Encrypted: i=1; AJvYcCVUFUBNux5ao7D3uvULd+u9hmPAERa2MAsRfoIofQz8srCmssaIkZRBXagzBlwPiqgyqMnk8E65NbyQrXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ4jeGLNl58jfHkaN6OCP9+c9ihl2HhK4i1RTUynlS4ymlS3xv
	UDYUn1HIq0Lerza+CBF04TRpmTxbU8Sc6ihnSSQO9Pxl5wXuwiSpjPSnvGHvjV2Lx4w=
X-Gm-Gg: ASbGnctZpHS50bvFd9Ug/lGGbTV2Y+89izXAAhO3n8YituRUPsEk+mflfIuSTePNxoA
	SHII7ZjCgqXeD6dlfvepGUIrHTcs2uJ0mQWXrX8iZP5z89euDwZynIP3Vald55SYi5vVltQfEa+
	ucTVG6vllZrmueIQbV8G0EHWvzoNQt30P9G4/NGFsMsaE8yrnDBYaMhQ/M05+DtY/MSraFDSxrY
	dBMeUBxnorf83przDRmI76gbajJat+pZLwR/1pCxve2aYVaU3sFLcc+ZvaCXg2kU4DDTAaFHCOu
	lkdg7y19/rMkekgG9qUEqiJGKZ0CxjrouWd0N6h7X6Fx4IiLkni1Qg3wnHUbUuwJtDZEc7uyZtB
	V1HTFeEp2Jgnf3T1Jw2lv8c1nfrn9XqEA1HzQpWTFQ47q9o5Q8dX/EViWMLAI/rqN7pfQHE7OGQ
	Zpy1Ld1G1UvSzl9Dv/8GMWMSMEBQ==
X-Google-Smtp-Source: AGHT+IGkeNaYKvyK6RfsmW9P2I2Bei9/3fDZq7zhXE2U6MX7ry6sRZVC9VoMigtpV+m4XtidjifL/g==
X-Received: by 2002:a05:600c:83ce:b0:471:115e:87bd with SMTP id 5b1f17b1804b1-4773086eb33mr8700635e9.26.1761858235643;
        Thu, 30 Oct 2025 14:03:55 -0700 (PDT)
Received: from localhost (054722ac.skybroadband.com. [5.71.34.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm34127953f8f.38.2025.10.30.14.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 14:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Oct 2025 21:03:51 +0000
Message-Id: <DDVYM9SMCT7O.17T5SIB9IEED4@linaro.org>
Cc: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <devicetree@vger.kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
 <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: pm4125-sdw: correct number of
 soundwire ports
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Srinivas Kandagatla" <srinivas.kandagatla@oss.qualcomm.com>,
 <broonie@kernel.org>, <srini@kernel.org>
X-Mailer: aerc 0.21.0
References: <20251029144636.357203-1-srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20251029144636.357203-1-srinivas.kandagatla@oss.qualcomm.com>

On Wed Oct 29, 2025 at 2:46 PM GMT, Srinivas Kandagatla wrote:
> For some reason we ended up limiting the number of soundwire ports to 2
> in the bindings, the actual codec supports 4 rx and 5 tx ports.

The reason is quite simple. The available _limited_ documentation at that
point suggested that there are two rx and two tx ports. There simply
were no better docs.
If you finally got access to the right docs then it is good to fix that.

> Fixes: 88d0d17192c5 ("ASoC: dt-bindings: add bindings for pm4125 audio co=
dec")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

You should run get_maintainer.pl script when sending patches and check who
should be put into c/c. See [1] too.
Here you should run smth like this:

get_maintainer.pl -f Documentation/devicetree/bindings/sound/qcom,pm4125-sd=
w.yaml=20

or check with b4 how it works.

The c/c list is not full.
Perhaps this is a consequence of putting all Qcom audio related things unde=
r
one entry in maintainers file.

Best regards,
Alexey

[1]: https://docs.kernel.org/process/submitting-patches.html#select-the-rec=
ipients-for-your-patch


