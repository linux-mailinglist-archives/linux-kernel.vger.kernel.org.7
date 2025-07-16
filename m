Return-Path: <linux-kernel+bounces-733005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8DBB06EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0CA650388E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BE628A73B;
	Wed, 16 Jul 2025 07:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="hBxU0FI6"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB0028A1EE
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650151; cv=none; b=WN8uGU0x6fxMsFgWYQEdYG+KxkCqqG/rWCRcyjEkQoxN+ivRd9TTor9cX7AGvLw9vQYJhylu14H2NT3STbPCk+bmw7gl/qVWLgHp8pr5oB1FuwY/8KM96vV1pBdrztlCFlCb84wmHMvA0N5udmF9O0mjyPTpGd3QMn+4oyU/peQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650151; c=relaxed/simple;
	bh=24Tb/LcZcpuEpFKIVKeMZB7NBtNKQTvEKsUhXdnCMXk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=YD9vb+WpH0Ae4mP7Wu3kNUSRrzNDsWTcF15mPfFNq+jmF2yGN8S5vVCE/QQDoiGKw3FRpIFIz/tCpznJWbC1ob/nW6S/MPX/HvDdMhixSk691ky2lt9KBxlyr8hJDBglHTLOEkCPhGJaN0FspV5v7BxC6+V1KcRlLrV9ZBB4XXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=hBxU0FI6; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so10186437a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752650146; x=1753254946; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfsjryOJJcheH9NBkSyCY8ER+5hEKLpu3+/ZdvPKIxw=;
        b=hBxU0FI6N4QyvB9ewq8YRKB58MORaqNgkMrhXYVmffHaIufzTUqBkT5pO9I8Vk7sVE
         72DJEvKxWuMuruygEKXhPttCZprFXvvhq/onoRMHK+fYnYSdR6nPotsCmeUcjpu33+bd
         SW28QC5rr8OhHWCFj3WjkAJEGVQuEzcaVWEhBawOZVZlR+TlMUybSl/eA9k/dkb7sQRp
         vyD6PszlSyymICoMdafqoXUgi8embFU2wiMtp/1pOQPcBf2u9Tk23JVIss5JvzxQV6mt
         KJUfr4UHgNhJfILhy5Y8HbMlMt+GiPBTPhOc2IfkdHjiCHrZcmqSCCKB6RzVlswHxfOU
         Elyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752650146; x=1753254946;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YfsjryOJJcheH9NBkSyCY8ER+5hEKLpu3+/ZdvPKIxw=;
        b=mcPbgMkLjHMD7bBB0J379c2NsU4bLbC+8GB+sWeDAKUPr+N7Qb9unCXLM9CrxkqPfB
         eONB5pT8y9dqWAG33YFdxLvzSNYAjUUOQ2I+jPAMVQrbH1fB/A7WY0LvpNrmM8/A+KWw
         UvNiOU7j8WUhz4h0paE17E2VjDfiCEKj5QpH9dU0qEudckGoOBdhuUtuS6oo7JU755Rb
         zlPUMa+vHApsixnj3ErRftpwKE/WFmZN4R3iBNuFPQScfyxMXOUTb3g8CsREbXSSz+gK
         9hTfte8bajaPL9oAarY5jhYxNAHK2mj2tS4VL/6NNBas1rIqxbcI8MYdl9k7c90qZXLF
         jolA==
X-Forwarded-Encrypted: i=1; AJvYcCV+FeSQNgkoL7u4WADZih69An0SxSCNpfr1QiusJDtYv6rcJdBFYEhTr52gb+nHa/lEC1u0qzvt+rVeXew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyICdkPCfZAjoMGu8Pd1ome4I+k0bK1z2q3cQ+V/+TiP+OQ2A2a
	qXcj2TISOXzqijmahA5bTsklJCX+d/QbgAK7SnRGyqbWa/ZpcAU4940K0494iXh8Avo=
X-Gm-Gg: ASbGnctfL/RaHfBXxXE2rzteoMI8D2C7vRyp05efdHj5gCLBQBENfTaSTUlZyyubOTK
	duqQ/HSFxnUR2/o1/kA9jeZ3pI+9W9cNjjNJaiEb3U95W5PZ/MxfUhpsCECNok6unglqIM4VO7t
	ZLS6mpgexvBN3eQtsv/lozmEgdsuKGXKCq59vHEpsqzAvjGRwSWbKF0G63o5N2PldUvI8Na4VKJ
	YR4oEyF6/2v2DsqswZ8bXgQOI1AvGbdxJbBVPguqWf4eG7RTP+qvyJL7W9CsrVMo+jmN8dd5DJ/
	KwKIc2fU2F75e07hoUAmvUjhMw26iBiikL+GpqcoXOWYdFpdRe7V84jxRLFujXwxlKPOrJvVHsH
	lAW1CTFD77u/oxVLcaH1uKxPxkFoj8MH0y/EoOXDy4fIgIc50ibK3aXY=
X-Google-Smtp-Source: AGHT+IHh6O0xWZNdSmDIs+XRRgBqO1v1bLel1oaIRd2A4zdKO7Ksr9kC4ZbOvvs8AVHwGMBGLMFLbg==
X-Received: by 2002:a05:6402:2343:b0:606:9211:e293 with SMTP id 4fb4d7f45d1cf-61281ebe084mr1668193a12.9.1752650145562;
        Wed, 16 Jul 2025 00:15:45 -0700 (PDT)
Received: from localhost (212095005088.public.telering.at. [212.95.5.88])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c976ec04sm8197036a12.60.2025.07.16.00.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 00:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Jul 2025 09:15:43 +0200
Message-Id: <DBDAMGN9UQA0.J6KJJ48PLJ2L@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH 0/3] Fixes/improvements for SM6350 UFS
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250314-sm6350-ufs-things-v1-0-3600362cc52c@fairphone.com>
In-Reply-To: <20250314-sm6350-ufs-things-v1-0-3600362cc52c@fairphone.com>

Hi Bjorn,

On Fri Mar 14, 2025 at 10:17 AM CET, Luca Weiss wrote:
> Fix the order of the freq-table-hz property, then convert to OPP tables
> and add interconnect support for UFS for the SM6350 SoC.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Luca Weiss (3):
>       arm64: dts: qcom: sm6350: Fix wrong order of freq-table-hz for UFS
>       arm64: dts: qcom: sm6350: Add OPP table support to UFSHC
>       arm64: dts: qcom: sm6350: Add interconnect support to UFS

Could you please pick up this series? Konrad already gave his R-b a
while ago.

Regards
Luca

>
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 49 ++++++++++++++++++++++++++++--=
------
>  1 file changed, 39 insertions(+), 10 deletions(-)
> ---
> base-commit: eea255893718268e1ab852fb52f70c613d109b99
> change-id: 20250314-sm6350-ufs-things-53c5de9fec5e
>
> Best regards,


