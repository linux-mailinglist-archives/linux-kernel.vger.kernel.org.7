Return-Path: <linux-kernel+bounces-850341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB75BD28EF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBBB1897447
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A072715E5BB;
	Mon, 13 Oct 2025 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SsolKaTe"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BAA2FF64C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760351224; cv=none; b=bzfNljERED2LP0k/BlqQni5nsvR53dGIBUWA/ZMv57g1r22XyRgtm+IwPFrEl//pL0UkLQWk9Vo5DfmuukIvxVCxunnTbmw5DfbUOzluXN05qABHwQR+4rSNkSuVwgYgkjlpkPUG45FvhnDdmUdMBqorHko7rHR4/LgFvi1depk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760351224; c=relaxed/simple;
	bh=mYP/OQKzVS1m6M+HpUKFSESiFlsi27UhRPn0dyau2kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GVcjoHelk3PGugCIq61gl9yIRUWeNz4Ma8YqLmuEqmE5obAtu1nG6Yg/wsMLp5O4VPbhtMD/zpCfaJsnlkQDMgpZm4YO64VsqDZQ38V/EKYX3cBqZEiWdyxlQC/9BuE8WjhqIv+0eWhocAPMLUGCapsiAN+WlXGJQQYdb5v1bHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SsolKaTe; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-373a56498b9so49824251fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760351221; x=1760956021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUycCPtJNwSyf8L3pkwEVzuTkjNQoDRYegjRAHgk7u8=;
        b=SsolKaTel+wOEiH34+tTPJIPAO7a03Br/+cCmXFLjq/daH3rzWQm6FzeftLmlmiNxP
         PbxFFyDH54AJMVAEn5YQZnDTFnZoaAPXiWaIVr2vlv+B5HcmKjb3MpR4bYZugomGzXVV
         95czHWAvbVksRzkqABUVRn0qdj6/iOE7bsrobtNe1ilco2kYIB94GGIDfZ9iCGy2SFAQ
         M01qxUkWogyG7UZ2lCraonpybGL31SUS7PoAnnQ1I/POtnMnE6XVej0txDchL3rv061t
         zE4GUVRWqKnaQIqL/ArlI6yCZha6HC64v+ImMxlr+qSfb9IHlurTspnSkZr4WcedGAm8
         uWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760351221; x=1760956021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUycCPtJNwSyf8L3pkwEVzuTkjNQoDRYegjRAHgk7u8=;
        b=PqgGXqgyokMMsaiUZMu1dX4knkFhGDoh3FiAv4mM0yQFB/SNfbRPR3UqM0nVf3nKbW
         HJ60V5ExZwEHQGvI+8i24Gim1p2L8dx076cigMzoudilPadQb0vio9rhc3PVMIjC7b7m
         ixv7cEeC6xn6+fu2apny4Z/fDK/8W32GeKHCXlTUG+3L2jXMxNBHXydii/P0haZft+Tk
         jHuQecxuKgU8lLRAxkxvbcegOD5u1P/zY31NAyRQJtg/VNAh+au/gE6PU4PMaHQCZ5lD
         kQ7ENhuL6detw2r/nZyGO55oXVn4aLaveKlJReNz60oRXIeDOQBRL4Sj7SgJWKt9o3il
         iS0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgQ2thugIAmvFg2DFq9pm+g4BHR3XeATTKcIBTgtYWtqmPZPYrp60q6AY2IlYWFLVHL1B1uxgWmqX8yds=@vger.kernel.org
X-Gm-Message-State: AOJu0YySgJkk2N/cj1Wpb0/OimQYJBw9MyGsFx9tEX6GDk4vMA54AG2P
	yg7/DeCoci8q5xEJFbWGfzGKUQJiTV3O2bSSr3Ft49nZMgBHjd81eVKgNhjsqOhjGQ3hkI9u6vQ
	YMAvt8Pd8rakqMIBa7DtiNTQ5DroCfa9dFFuCr3S7jA==
X-Gm-Gg: ASbGnculhMEKKFnfYMFzDgLd+jIqFYnBJaiMxR0Y0Z/GGfA/HsIMwZZ9DOTAVpN/7lU
	OK0amtV54/RUfm6gAVex9jBP+tI4VT4jMIwV0eHmCTpIbRtPv+6UIgF3UqVN+Da9j2XLBcvzgml
	SSqsb7HUJF9I1eXfHC84PGRdT1wD7E781peZwhlZ952ipSOV66F/8Hl5LEeknFiby4/xHHfcC9M
	/fTwSsWHiQGhHUcHBl4xI8lgfn7HQ==
X-Google-Smtp-Source: AGHT+IFAEsHnMAjQz8hxHe77PJ/PCdDOE9sQkCxeRCWPsKIX77lQMxoPbYN5YcgGmocyzXCOJWX9oJCl9IJt3sstsZ8=
X-Received: by 2002:a2e:a54a:0:b0:373:c272:d986 with SMTP id
 38308e7fff4ca-375f526e5b0mr67753781fa.17.1760351220605; Mon, 13 Oct 2025
 03:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-knp-tlmm-v1-0-acabb59ae48c@oss.qualcomm.com>
In-Reply-To: <20250924-knp-tlmm-v1-0-acabb59ae48c@oss.qualcomm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Oct 2025 12:26:49 +0200
X-Gm-Features: AS18NWCGvuxtBzvkEQk1ZaKR73JeD7vVIfCcLysVpFERoAJPL1BMWsaJUOjyAzE
Message-ID: <CACRpkdZOSvEaUU8AGQY19co6maeFwkqEFP+TH-=NnToJuoih9A@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: qcom: Introduce Pinctrl for Kaanapali
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com, 
	tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com, 
	yijie.yang@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jingyi,

thanks for your patches!

On Thu, Sep 25, 2025 at 1:16=E2=80=AFAM Jingyi Wang
<jingyi.wang@oss.qualcomm.com> wrote:

> Introduce Top Level Mode Multiplexer dt-binding and driver for Qualcomm
> Kaanapali SoC.
>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
> Jingyi Wang (2):
>       dt-bindings: pinctrl: describe Kaanapali TLMM
>       pinctrl: qcom: add the tlmm driver for Kaanapali platforms

I have applied these for v6.19!

Yours,
Linus Walleij

